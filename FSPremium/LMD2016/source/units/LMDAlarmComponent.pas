unit LMDAlarmComponent;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDAlarmComponent unit (JH)
---------------------------

Component which holds a list of alarm dates All alarm dates will be executed
According to overall CPU usage and according to event handling code they can be
executed too late! Component used two threads thread #1 (LMDAlarmTimerThread)
checks for items to be executed (checks event list and, if event is to be executed,
passes events to thread #2 and inserts next event of item (to which passed events belongs)
into event queue thread #2 (LMDAlarmThread) will wait by using a semaphore till
any event is added to its alarm list This event will be fired as soon as possible
This "two thread" model is used because
- time checking is done independently
from execution (events are marked for execution "as soon" as they shall be executed
- "while" thread #1 gets new event from an item thread #2 can already execute
the last one
- by using priorities a high priority event can overtake any other
event in the seconds thread alarm/execution queue, and so be executed next

Changes

Release 8.06 (March 2008)
 - BTS #597 issue fixed (The case when an alarm item is freed in the OnAlarm event)

-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Dialogs,
  Classes,
  SyncObjs,
  Comctrls,
  Windows,
  LMDIniCtrl,
  LMDCustomComponent;

type
  TLMDAlarmItemMode = (imFixed, imInterval);
  TLMDAlarmInterval = (aiCustomInterval, aiSeconds, aiMinutes, aiHours, aiDays, aiWeeks,
                       aiMonths, aiYears);

  //intervalIs must be set to value <> aiCustomInterval!!!!!!!!!!!!!!!!
  TLMDAlarmCustomInterval = procedure (Sender: TObject; var anInterval: Int64; var intervalIs: TLMDAlarmInterval);

  {---------------------TLMDAlarmItem-------------------------------------}
  TLMDAlarmItem = class (TCollectionItem)
  private
    FLastExec,
    FLastCalc,
    FDateTime     : TDateTime;
    FCaption      : String;
    FPriority,
    FPassTimes,
    FExecTimes,

    FRepeatTimes,
    FId,
    FInterval     : Int64;
    FMode         : TLMDAlarmItemMode;
    FIntervalMode : TLMDAlarmInterval;
    FOnCustom     : TLMDAlarmCustomInterval;

    procedure SetTime (aValue: String);
    function GetTime: String;
    procedure SetDate (aValue: String);
    function GetDate: String;
    procedure SetDateTime (aValue: TDateTime);
    procedure ReadDate(Reader:TReader);
    procedure ReadTime(Reader:TReader);
  protected

    // 7.04
    procedure DefineProperties(Filer:TFiler);override;
    // ----

    //returns the next alarm - either from start (datetime) if no date has been
    //calculated yet or from the last one being calculated
    function getNextAlarm: TDateTime; overload;

    //get next alarm from given datetime value on
    function getNextAlarm(from: TDateTime): TDateTime; overload;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    //returns datetime value of last event executed by calling the
    //OnAlarm event, this value can be stored (for each item) - e.g. on
    //program termination and used on program startup in the OnInitItem event
    //of the alarm component for restarting the timed events from the
    //"last executed" one - otherwise it will always restart from the given
    //datetime
    //This enabled a user to keep the original datetime value (which could
    //be altered for achieving the same effect, too)
    property ExecutedLast: TDateTime read FLastExec;

    //returns number of executions / number of passes to second thread
    //can be not equal to the number of event executions!!!
    property Executed: Int64 read FExecTimes;
    property PassTimes: Int64 read FPassTimes;

    // 7.04, Moved to public
    property Date        : String read GetDate write SetDate;
    property Time        : String read GetTime write SetTime;
    // -----
    procedure Update;
  published
    property Index;
    property DisplayName;
    property Caption     : String read FCaption write FCaption;
    property DateTime    : TDateTime read FDateTime write SetDateTime;
    property Ident       : Int64 read FId write FId;
    property RepeatTimes : Int64 read FRepeatTimes write FRepeatTimes default -1;
    property Interval    : Int64 read FInterval write FInterval default 0;
    property IntervalMode: TLMDAlarmInterval read FIntervalMode
                                             write FIntervalMode
                                             default aiHours;
    property Mode        : TLMDAlarmItemMode read FMode write FMode
                                             default imFixed;
    property Priority: Int64 read FPriority write FPriority default 0;
  end;

  TLMDAlarmComponent = class;

  {---------------------TLMDAlarmItems-----------------------------------}
  TLMDAlarmItems = class (TCollection)
  private
    FOwner  : TLMDAlarmComponent;
    function GetItem(Index: Integer): TLMDAlarmItem;
    procedure SetItem(Index: Integer; Value: TLMDAlarmItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Owner : TLMDAlarmComponent);
    destructor Destroy; override;
    function Add: TLMDAlarmItem;
    procedure Delete(Index: Integer);
    function GetIndexByID(ID:integer):integer;
    property Items[Index: Integer]: TLMDAlarmItem read GetItem write SetItem; default;
  end;

  {----------TLMDAlarmListItem-----------}
  TLMDAlarmListItem = record
    DT       : TDateTime;    //dt and priority are stored in the lists for
    priority,                //avoiding access to the items (which could be
    index    : Int64;        //changed in the meantime)
  end;

  PLMDAlarmListItem = ^TLMDAlarmListItem;

  {---------------------TLMDAlarmThread----------------------------------------}
  TLMDAlarmThread = class (TThread)
  private
    FOwner         : TLMDAlarmComponent;
    FEventList     : TList;

    FEventNr       : Int64; //needed internally

    FOValid,
    FLockEventList : TCriticalSection; //on accessing event list this lock
                                       //should be acquired first
    FEventListSemaphore: THandle;
  public
    procedure SetOwner (anOwner: TLMDAlarmComponent);
    procedure ExecuteTheEvent; //requires value in FEventNr!
    procedure Execute; override;
    constructor Create(CreateSuspended: Boolean; Owner: TLMDAlarmComponent);
    destructor Destroy; override;

    procedure AddEvent (anEvent: TLMDAlarmListItem);
  end;

  {---------------------TLMDAlarmTimerThread----------------------------------------}
  TLMDAlarmTimerThread = class (TThread)
  private
    FOwner    : TLMDAlarmComponent;
    FOValid   : TCriticalSection;
  public
    procedure SetOwner (anOwner: TLMDAlarmComponent);
    procedure Execute; override;
    constructor Create(CreateSuspended: Boolean; Owner: TLMDAlarmComponent);
    destructor Destroy; override;
  end;

  TLMDAlarmEvent = procedure (Sender: TObject; item: TLMDAlarmItem) of object;
  TLMDAlarmInitItemEvent = procedure (Sender: TObject; item: TLMDAlarmItem; var aDateTime: TDateTime) of object;
  //TLMDAlarmOption = (aoIgnorePassed //
  //                   );

  //TLMDAlarmOptions = set of TLMDAlarmOption;
  {---------------------TLMDAlarmComponent-------------------------------------}
  TLMDAlarmComponent = class (TLMDCustomComponent)
  private
    FPriority,
    FActive          : Boolean;
    FStartTime       : TDateTime;
    FItems           : TLMDAlarmItems;
    FAlarmTimerThread: TLMDAlarmTimerThread;
    FAlarmThread     : TLMDAlarmThread;
    FAlarmList       : TList;
    FExecTimer       : TCriticalSection;
    //FOptions       : TLMDAlarmOptions;
    FSleepTime       : Dword;

    {Ini-Support}
    FIniLink       : TLMDIniCtrl;
    FIniUse        : TLMDIniUse;
    FSection       : String;

    FOnAlarm         : TLMDAlarmEvent;
    FOnInitItem      : TLMDAlarmInitItemEvent;

    procedure SetItems (aValue: TLMDAlarmItems);
    procedure SetActive (aValue: Boolean);

    procedure SetIniLink(aValue:TLMDIniCtrl);
    function SaveSection:Boolean;
  protected
    procedure ClearAlarmList;
    //function AddAlarmItem (anItem: Integer): Boolean;
    function AddAlarmItems (anItem: Integer): Boolean;
    function RemoveAlarmItems (anItem: Integer): Boolean;
    function RemoveAlarmItemsByID (anID: Integer): Boolean;
    procedure DoTimer (Sender: TObject);
    procedure ReadData;
    procedure ResetItems; virtual;
    procedure WriteData;
    public
    procedure Loaded; override;
    procedure Notification (AComponent: TComponent; Operation: TOperation); override;
    function AddItem( ADisplayName, ACaption : String;
                   ADateTime: TDateTime;
                   AIdent, ARepeatTimes, AInterval: Int64;
                   AIntervalMode: TLMDAlarmInterval = aiSeconds;
                   AMode: TLMDAlarmItemMode = imFixed;
                   APriority: Int64 = 0):integer;

    procedure ClearItems;
    constructor Create (aOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitItems;
    procedure RemoveItem(anItem: Integer);
  published
    property About;
    property Items  : TLMDAlarmItems read FItems write SetItems;
    property Active : Boolean read FActive write SetActive default false;
    property PriorityExec: Boolean read FPriority write FPriority default false;
    property SleepTime: dword read FSleepTime write FSleepTime default 500;

    {Ini-Support}
    property IniLink: TLMDIniCtrl read FIniLink write SetIniLink;
    property IniUse : TLMDIniUse read FIniUse write FIniUse default ioNone; {not active by default}
    property Section: String read FSection write FSection stored SaveSection;

//    property Options: TLMDAlarmOptions read FOptions write FOptions;
    property OnAlarm: TLMDAlarmEvent read FOnAlarm write FOnAlarm;
    property OnInitItem: TLMDAlarmInitItemEvent read FOnInitItem write FOnInitItem;

  end;

// helper functions
function LMDIncSecond (dt: TDateTime; Seconds: Int64): TDateTime;
function LMDIncMinute (dt: TDateTime; Minutes: Int64): TDateTime;
function LMDIncHour (dt: TDateTime; Hours: Int64): TDateTime;
function LMDIncDay (dt: TDateTime; Days: Int64): TDateTime;
function LMDIncWeek (dt: TDateTime; Weeks: Int64): TDateTime;
function LMDIncMonth (dt: TDateTime; Months: Int64): TDateTime;
function LMDIncYear (dt: TDateTime; Years: Int64): TDateTime;

implementation

uses
  Forms,
  SysUtils,
  LMDClass;

  { -------------------------------------------------------------------------- }
  function CompareDates (Item1, Item2: Pointer): Integer;
  begin
    if PLMDAlarmListItem(Item1).DT = PLMDAlarmListItem(Item2).DT then
      result := 0
    else
      if PLMDAlarmListItem(Item1).DT > PLMDAlarmListItem(Item2).DT then
        result := 1
      else
        result := -1;
  end;

  function ComparePriorities (Item1, Item2: Pointer): Integer;

  begin
    if PLMDAlarmListItem(Item1).Priority = PLMDAlarmListItem(Item2).Priority then
      result := 0
    else
      if PLMDAlarmListItem(Item1).Priority > PLMDAlarmListItem(Item2).Priority then
        result := 1
      else
        result := -1;
  end;

  { -------------------------------------------------------------------------- }

  function LMDIncSecond (dt: TDateTime; Seconds: Int64): TDateTime;
  begin
    result := dt + Seconds / 86400;
  end;

  function LMDIncMinute (dt: TDateTime; Minutes: Int64): TDateTime;
  begin
    result := dt + Minutes / 1440;
  end;

  function LMDIncHour (dt: TDateTime; Hours: Int64): TDateTime;
  begin
    result := dt + Hours / 24;
  end;

  function LMDIncDay (dt: TDateTime; Days: Int64): TDateTime;
  begin
    result := dt + Days;
    end;

  function LMDIncWeek (dt: TDateTime; Weeks: Int64): TDateTime;
  begin
    result := dt + Weeks * 7;
  end;

  function LMDIncMonth (dt: TDateTime; Months: Int64): TDateTime;
  begin
    result := IncMonth (dt, Months);
  end;

  function LMDIncYear (dt: TDateTime; Years: Int64): TDateTime;
  begin
    result := LMDIncMonth (dt, 12 * Years);
  end;

{ **************************** TLMDAlarmItem ********************************* }
{ ------------------------------- private ------------------------------------ }
procedure TLMDAlarmItem.SetTime (aValue: String);
begin
  DateTime := Int(DateTime) + Frac(StrToTime(aValue));
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlarmItem.GetTime: String;
begin
  result := TimeToStr (DateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmItem.SetDate (aValue: String);
begin
  DateTime := StrToDate (aValue) + Frac (DateTime);
  Changed (false);
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlarmItem.GetDate: String;
begin
  result := DateToStr (DateTime);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmItem.SetDateTime (aValue: TDateTime);
begin
  FDateTime := aValue;
  FLastExec := 0;
  FExecTimes := 0;
  FLastCalc := 0;
end;

{------------------------------------------------------------------------------}
procedure TLMDAlarmItem.ReadDate(Reader:TReader);
begin
  SetDate(Reader.ReadString);
end;

{------------------------------------------------------------------------------}
procedure TLMDAlarmItem.ReadTime(Reader:TReader);
begin
  SetTime(Reader.ReadString);
end;

{ ----------------------- protected ------------------------------------------ }
procedure TLMDAlarmItem.DefineProperties(Filer:TFiler);
begin
  inherited;
  Filer.DefineProperty( 'Date', ReadDate, nil, false );
  Filer.DefineProperty( 'Time', ReadTime, nil, false );
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlarmItem.getNextAlarm: TDateTime;
begin
  if FLastCalc <> 0 then
    result := getNextAlarm(FLastCalc)
  else
    result := getNextAlarm(DateTime);
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlarmItem.getNextAlarm(from: TDateTime): TDateTime;
var
  i: Int64;
  M: TLMDAlarmInterval;
begin
  result := 0;
  if Mode = imInterval then
    begin
      if (FRepeatTimes > 0) and (FExecTimes + FPassTimes >= FRepeatTimes) then //VB Sep 2006
        exit;

      if FLastCalc=0 then
        begin
          result := from;
          FLastCalc := result;
          exit;
        end;

      result := from;
      M := FIntervalMode;
      i := FInterval;

      case FIntervalMode of
        aiCustomInterval: begin
                             M := aiSeconds;
                             if Assigned (FOnCustom) then FOnCustom (self, i, M);
                           end;
      end;

      case M of
        aiSeconds        : result := LMDIncSecond (result, i);
        aiMinutes        : result := LMDIncMinute (result, i);
        aiHours          : result := LMDIncHour(result, i);
        aiDays           : result := LMDIncDay (result, i);
        aiWeeks          : result := LMDIncWeek (result, i);
        aiMonths         : result := LMDIncMonth(result, i);
        aiYears          : result := LMDIncYear (result, i);
      end;
      //remember last execution datetime
      FLastCalc := result;
    end
  else //Mode = imFixed,
    if (from = DateTime) and (FLastCalc = 0) then //first call?
      begin
        result := DateTime;
        FLastCalc := result;
      end;
end;

{ ----------------------- public -------------------------------------------- }
{ ---------------------------------------------------------------------------- }
constructor TLMDAlarmItem.Create(Collection: TCollection);
begin
  inherited Create (Collection);
  FInterval     := 0;
  FIntervalMode := aiHours;
  FMode         := imFixed;
  FRepeatTimes  := -1;
  FLastExec     := 0; //invalid date time (no last execution)
  FLastCalc     := 0;
  FExecTimes    := 0;
  FPassTimes    := 0;
  FPriority     := 0;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDAlarmItem.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmItem.Assign(Source: TPersistent);
var
  S: TLMDAlarmItem;
begin
  if Source is TLMDAlarmItem then
    begin
      S := TLMDAlarmItem(Source);
      DateTime    := S.DateTime;
      Caption     := S.Caption;
      Ident       := S.Ident;
      RepeatTimes := S.RepeatTimes;
      Interval    := S.Interval;
      IntervalMode:= S.IntervalMode;
      Mode        := S.Mode;
      Changed(false);
    end
  else
    inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmItem.Update;
begin
  TLMDAlarmItems(Collection).Update(self);
end;

{ ********************************TLMDAlarmItems****************************** }
function TLMDAlarmItems.GetIndexByID(ID: integer): integer;
var
  i:integer;
begin
  result := -1;
  for i:=0 to Count - 1 do
    if Items[i].ID = ID then
      begin
        result := i;
        break;
      end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlarmItems.GetItem(Index: Integer): TLMDAlarmItem;
begin
  result := TLMDAlarmItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmItems.Notify(Item: TCollectionItem; Action: TCollectionNotification);
begin
  inherited;
  if Action = cnDeleting then
    begin
      FOwner.FExecTimer.Acquire;
      FOwner.RemoveAlarmItemsByID(Item.ID);
      FOwner.FExecTimer.Release;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmItems.SetItem(Index: Integer; Value: TLMDAlarmItem);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlarmItems.GetOwner: TPersistent;
begin
  result := FOwner;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmItems.Update(Item: TCollectionItem);
var
  LItem: TLMDAlarmItem;
begin
  inherited;
  if Assigned (Item) then
    begin
      FOwner.FExecTimer.Acquire;
      LItem := Item as TLMDAlarmItem;
      //FOwner.RemoveAlarmItems (LItem.Index); //vb jul 2005
      FOwner.RemoveAlarmItemsByID (LItem.ID); //vb March 2008
      LItem.FPassTimes := 0;
      FOwner.AddAlarmItems (LItem.Index);    //vb jul 2005
      FOwner.FAlarmList.Sort(CompareDates); //vb Sep 2006
      FOwner.FExecTimer.Release;
    end;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDAlarmItems.Create(Owner : TLMDAlarmComponent);
begin
  inherited Create(TLMDAlarmItem);
  FOwner := Owner;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDAlarmItems.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlarmItems.Add: TLMDAlarmItem;
begin
  result := TLMDAlarmItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmItems.Delete(Index: Integer);
begin
  inherited Delete (index);
end;

{ *************************TLMDAlarmThread*********************************** }
{ ------------------------- public ------------------------------------------- }
procedure TLMDAlarmThread.SetOwner (anOwner: TLMDAlarmComponent);
begin
  FOValid.Acquire;
  try
    FOwner := anOwner;
  finally
    FOValid.Release;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmThread.ExecuteTheEvent;
begin
  if Terminated or not Assigned (FOwner) or (FEventNr >= FOwner.Items.Count) then exit;
  FOwner.FOnAlarm (self, FOwner.Items[FEventNr]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmThread.Execute;
var
  i: Int64;
  d: TDateTime;
  L: DWORD;
  r1, r2: boolean;
begin
  i:=0;
  d:=0;
  while not Terminated do
    begin
      //while not Terminated and (WaitForSingleObject (FEventListSemaphore, 1000) = WAIT_TIMEOUT)
      //  do;

      r1 := true;
      r2 := true;
      while r1 and r2 do
        begin
          r1 := not Terminated;
          L := WaitForSingleObject (FEventListSemaphore, 1000);
          r2 := (L = WAIT_TIMEOUT);
        end;

      if Terminated then exit;

      //LMDLog.SendString ('Thread entered! '+IntToStr (FEventList.Count));

      //lock the list (for making sure that the adding process
      //already has set the index value)
      FLockEventList.Acquire;
      try
        if not Terminated then
          begin
            i := PLMDAlarmListItem(FEventList.Items[0]).index;
            d := PLMDAlarmListItem(FEventList.Items[0]).dt;
          end;
      finally
        FLockEventList.Release;
      end;
      if Terminated then exit;
      //list remains unlocked while we execute the event
      //this enables the alarm component to add additional
      //events

      //fire event!
      FOValid.Acquire;
      try
        FEventNr := FOwner.Items.GetIndexByID(i); //vb jul 2005
        if not Terminated and not (csDestroying in FOwner.ComponentState) and
           Assigned (FOwner) and Assigned (FOwner.FOnAlarm) then
          Synchronize (ExecuteTheEvent);
        if (FEventNr < FOwner.Items.Count) and           //Check added
          (FOwner.Items[FEventNr].ID = i) then           //VB March 2008 (BTS 597)
          FOwner.Items[FEventNr].FLastExec := d //vb jul 2005
        else
          begin
            //the item was destroyed in the event handler //VB March 2008 (BTS 597)
            FOwner.FExecTimer.Acquire;
            FOwner.RemoveAlarmItemsByID(i);
            FOwner.FExecTimer.Release;
          end;
      finally
        FOValid.Release;
      end;

      if Terminated then exit;
      //lock the list again for removing the item
      FLockEventList.Acquire;
      try
        //remove event from list
        if not Terminated then
          begin

            Dispose(FEventList.Items[0]);

            FEventList.Delete(0); //delete first item
          end;
  //      if FEventList.Count > 0 then FAvail.Release; //free list ->
                    //only if there are remaining alarm items
                    //otherwise the thread should sleep
      finally
        FLockEventList.Release;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDAlarmThread.Create(CreateSuspended: Boolean; Owner: TLMDAlarmComponent);
begin
  inherited Create(CreateSuspended);
   //
  FOValid := TCriticalSection.Create;
   //set owning TLMDAlarmComponent
  FOwner := Owner;
   //create FLockEventList for protecting the event list (single access at one
   //time)
  FLockEventList      := TCriticalSection.Create;
   //create FEventListSemaphore, a counting semaphore for indicating that there
   //are items in the event list
   //this will make the thread sleep if the event list is empty (instead of busy
   //waiting
  FEventListSemaphore := CreateSemaphore (nil, 0, MaxListSize, '');
   //list of events to be fired
  FEventList          := TList.Create;
//  FreeOnTerminate := true;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDAlarmThread.Destroy;
var
  i: Integer;
begin
  if not Terminated then Terminate;

  FOValid.Acquire;
  try
    FOwner := nil;
  finally
    FOValid.Release;
  end;
  //lock the list for removing it - mainly needed for waiting for anything
  //which currently is accessing the list
  FLockEventList.Acquire;
  try
    for i := FEventList.Count - 1 downto 0 do

      Dispose(FEventList.Items[i]);

    FEventList.Free;
  finally
    FLockEventList.Release;
  end;

  inherited Destroy;

  CloseHandle (FEventListSemaphore);
  FOValid.Free;
  //we can now free the FLock ...
  FLockEventList.Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmThread.AddEvent (anEvent: TLMDAlarmListItem);
var
  p : PLMDAlarmListItem;
  b : boolean;
begin
  FLockEventList.Acquire;
  try
    New (p);
    p.index := anEvent.index; //vb jul 2005
    p.dt := anEvent.dt;
    p.priority := anEvent.priority;
    b := FOwner.FPriority;

    FEventList.Add (p);
    if b then FEventList.Sort(ComparePriorities);

    //we added one item, so we can reactivate the thread
    //-> counting semaphore, add 1 (one new item added to event list)
    ReleaseSemaphore (FEventListSemaphore, 1, nil);
  finally
    FLockEventList.Release;
  end;
end;

{ *************************TLMDAlarmTimerThread****************************** }
{ ------------------------- public ------------------------------------------- }
procedure TLMDAlarmTimerThread.SetOwner (anOwner: TLMDAlarmComponent);
begin
  FOValid.Acquire;
  try
    FOwner := anOwner;
  finally
    FOValid.Release;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmTimerThread.Execute;
var
  TimeOut:integer;
begin
  TimeOut := 500;
  if Assigned (FOwner) then
    TimeOut := FOwner.SleepTime;
  while not Terminated do
    begin
      SleepEx (TimeOut, true); //wait timeout number of milliseconds ...
      FOValid.Acquire;
      try
        if not Terminated and Assigned (FOwner) then
          FOwner.DoTimer (FOwner);
      finally
        FOValid.Release;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDAlarmTimerThread.Create(CreateSuspended: Boolean; Owner: TLMDAlarmComponent);
begin
  inherited Create (CreateSuspended);
  FOValid := TCriticalSection.Create;
  FOwner := Owner;
//  FreeOnTerminate := true;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDAlarmTimerThread.Destroy;
begin
  if not Terminated then Terminate;

  inherited Destroy;

  FOValid.Free;
end;

{ *************************TLMDAlarmComponent******************************** }
{ ------------------------- private ------------------------------------------ }
procedure TLMDAlarmComponent.SetItems (aValue: TLMDAlarmItems);
begin
  FItems.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmComponent.SetActive (aValue: Boolean);
var
  i: Integer;
begin
  if aValue <> FActive then
    begin
      FActive := aValue;

      if FActive then
        begin
          FStartTime := now;
          if csLoading in ComponentState then exit;

          FExecTimer.Acquire;
          ClearAlarmList;

          if not FAlarmThread.Suspended then
            FAlarmThread.Suspend;
          for i := 0 to Items.Count - 1 do
            AddAlarmItems (i);
          FAlarmList.Sort(CompareDates);
          FAlarmThread.Resume;
          FAlarmTimerThread.Resume;
          FExecTimer.Release;
        end
      else
        begin
          FExecTimer.Acquire;
          ClearAlarmList;
          ResetItems;
          if not FAlarmTimerThread.Suspended then
            FAlarmTimerThread.Suspend;
          if not FAlarmThread.Suspended then
            FAlarmThread.Suspend;
          FExecTimer.Release;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDAlarmComponent.SetIniLink(aValue:TLMDIniCtrl);
begin
  FIniLink:=aValue;
  if FIniLink<>nil then FIniLink.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDAlarmComponent.SaveSection:Boolean;
begin
  result:=(FSection<>'') and (FSection<>IDS_COMMON);
end;

{ ------------------------- protected ---------------------------------------- }
procedure TLMDAlarmComponent.ClearAlarmList;
var
  i: Integer;
begin
  for i := FAlarmList.Count - 1 downto 0 do
    begin
      Dispose(FAlarmList.Items[i]);
      FAlarmList.Delete(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlarmComponent.AddAlarmItems (anItem: Integer): Boolean;
var
  p: PLMDAlarmListItem;
  n,
  l: TDateTime;
begin
  Application.ProcessMessages;
  n := Now;
  result := false;
  if (anItem < 0) or (anItem >= Items.Count) or (not Active) then  //??? VB Sep 2006
    exit;
  l := Items[anItem].getNextAlarm;
  //check whether item requires reinsertion into list
  if (l <> 0) and (l >= FStartTime) and (l >= n) then // (l >= n) added VB Sep 2006
    begin
      New(p);
      p.DT := l;
      p.index := Items[anItem].ID;
      p.priority := Items[anItem].FPriority;
      FAlarmList.Add (p);
      result := true;
    end;

  while (l <> 0) and (l < n) do
    begin
      l := Items[anItem].getNextAlarm(l);
      if l <> 0 then
        inc (Items[anItem].FPassTimes);
      if (l <> 0) and (l >= FStartTime ) then  //vb jul 2005 added start time check
      //check whether item requires reinsertion into list
        begin
          New(p);
          p.DT := l;
          p.index := Items[anItem].ID; //anItem;  vb jul 2005
          p.priority := Items[anItem].FPriority;
          FAlarmList.Add (p);
          result := true; //VB Sep 2006
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlarmComponent.RemoveAlarmItems (anItem: Integer): Boolean;
var
  i: Integer;
begin
  result:=false;
  i:=0;
  while i < FAlarmList.Count do
    begin
      //remove all items from the alarm list with the given item index
      if PLMDAlarmListItem(FAlarmList[i]).index = items[anItem].Id then
        begin
          Dispose (FAlarmList[i]);
          FAlarmList.Delete (i);
          result:=true;
        end
      else
        inc(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlarmComponent.RemoveAlarmItemsByID (anID: Integer): Boolean;
var
  i: Integer;
begin
  result:=false;
  i:=0;
  while i < FAlarmList.Count do
    begin
      //remove all items from the alarm list with the given item index
      if PLMDAlarmListItem(FAlarmList[i]).index = anID then
        begin
          Dispose (FAlarmList[i]);
          FAlarmList.Delete (i);
          result:=true;
        end
      else
        inc(i);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmComponent.InitItems;
var
  i: Integer;
  d: TDateTime;
begin
  //if the program had been closed the knowledge about already executed events
  //gets lost
  for i := 0 to Items.Count - 1 do
    begin
      if Assigned (FOnInitItem) then FOnInitItem (self, Items[i], d);
      //simply set the last calculated value to the one from the init process
      Items[i].FLastCalc := d;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmComponent.DoTimer (Sender: TObject);
var
  a: Boolean;
  i: Int64;
  n: TDateTime;
begin
  if not Active or (csDestroying in ComponentState) then exit;
  //first get access rights to alarm list ...
  FExecTimer.Acquire;
  try
    //check whether there are any entries in the list
    if FAlarmList.Count = 0 then
      exit;
    //save current system date time
    n := Now;
    //assume that no new items have been added
    a := false;
    //check whether there are events to be fired
    while (FAlarmList.Count > 0) and (PLMDAlarmListItem(FAlarmList[0]).dt < n)
           and (not (csDestroying in ComponentState)) do
      begin
        //remember event for firing (event fire process will automatically do so
        //if event "can be" fired!

        i := PLMDAlarmListItem(FAlarmList[0]).Index;
        i := Items.GetIndexByID(i);

        inc(Items[i].FExecTimes);//VB Apr 2006

        FAlarmThread.AddEvent(PLMDAlarmListItem(FAlarmList[0])^);
        Dispose(PLMDAlarmListItem(FAlarmList[0]));

        FAlarmList.Delete(0);
        if (Items[i].FLastCalc <= n) then
                                        //only add new item if time proceeded
                                        //and there is no event for future
                                        //is available
          a := AddAlarmItems(i);
      end;
    //if we have added at least one item we should resort the list
    if a then FAlarmList.Sort(CompareDates);
  finally
    FExecTimer.Release;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmComponent.ReadData;

  procedure DoReadValues(aLink:TLMDIniCtrl);
  var
    //s  : TStringList;
    c,
    i  : Integer;
    ib: String;

  begin
     with aLink do
       begin
         c := aLink.ReadInteger (FSection,'ItemsNum', 0);
         for i := 0 to c - 1 do
           begin
             ib := 'Item'+IntToStr(i);

             if i >= Items.Count then Items.Add;
             Items[i].Ident := ReadInteger (FSection, ib+'Ident', Items[i].Ident);
             Items[i].Caption := ReadString (FSection, ib+'Caption', '');
             Items[i].DateTime := ReadDateTime (FSection, ib+'DateTime', Now);
             Items[i].RepeatTimes := ReadInteger (FSection, ib+'RepeatTimes', -1);
             Items[i].FExecTimes := ReadInteger (FSection, ib+'Repeated', 0);
             Items[i].FPassTimes := ReadInteger (FSection, ib+'Passed', 0);  //VB Sep 2006
             Items[i].IntervalMode := TLMDAlarmInterval(ReadInteger (FSection, ib+'IntervalMode', 0));
             Items[i].Mode := TLMDAlarmItemMode(ReadInteger (FSection, ib+'Mode', 0));
             Items[i].Interval := ReadInteger (FSection, ib+'Interval', 0);
             Items[i].Priority := ReadInteger (FSection, ib+'Priority', 0);

             if ReadString (FSection, ib+'ExecutedLast', '0') <> '0' then
               begin
                 Items[i].FLastExec := ReadDateTime (FSection, ib+'ExecutedLast', 0);
                 Items[i].FLastCalc := Items[i].FLastExec;
               end;
           end;
       end;
  end;

begin
  case FIniUse of
    ioUseLink:
      if Assigned(FIniLink) then DoReadValues(FIniLink);
    ioUseGlobal:
      DoReadValues(LMDApplication.Ini);
    ioNone: ;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmComponent.ResetItems;
var
  i: Integer;
begin
  for i := 0 to Items.Count - 1 do
    if Items[i].FMode = imFixed then
      Items[i].FLastCalc := 0;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmComponent.WriteData;

  procedure DoWriteValues(aLink:TLMDIniCtrl);
  var
    i  : Integer;
    ib : String;
  begin
     with aLink do
       begin
         WriteInteger (FSection,'ItemsNum',Items.Count);
         for i := 0 to Items.Count - 1 do
           begin
             ib := 'Item'+IntToStr(i);

             WriteInteger (FSection, ib+'Ident', Items[i].Ident);
             WriteString (FSection, ib+'Caption', Items[i].Caption);
             WriteDateTime (FSection, ib+'DateTime', Items[i].DateTime);
             WriteInteger (FSection, ib+'RepeatTimes', Items[i].RepeatTimes);
             WriteInteger (FSection, ib+'Repeated', Items[i].Executed);
             WriteInteger (FSection, ib+'Passed', Items[i].PassTimes);
             WriteInteger (FSection, ib+'IntervalMode', Ord(Items[i].IntervalMode));
             WriteInteger (FSection, ib+'Mode', Ord(Items[i].Mode));
             WriteInteger (FSection, ib+'Interval', Items[i].Interval);
             WriteInteger (FSection, ib+'Priority', Items[i].Priority);

             if Items[i].FLastExec > 0 then
               WriteDateTime (FSection, ib+'ExecutedLast', Items[i].FLastExec)
             else
               WriteInteger (FSection, ib+'ExecutedLast', 0)
           end;
       end;
  end;

begin
  case FIniUse of
    ioUseLink:
      if Assigned(FIniLink) then DoWriteValues(FIniLink);
    ioUseGlobal:
      DoWriteValues(LMDApplication.Ini);
    ioNone: ;
  end;
end;

{ ------------------------- public ------------------------------------------- }
procedure TLMDAlarmComponent.Loaded;
begin
  inherited Loaded;
  ReadData;
  if FActive then
    begin
      Active := false;
      Active := true;
    end
  else
    begin
      if not FAlarmTimerThread.Suspended then
        FAlarmTimerThread.Suspend;
      if not FAlarmThread.Suspended then
        FAlarmThread.Suspend;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDAlarmComponent.AddItem( ADisplayName, ACaption : String;
                   ADateTime: TDateTime;
                   AIdent, ARepeatTimes, AInterval: Int64;
                   AIntervalMode: TLMDAlarmInterval = aiSeconds;
                   AMode: TLMDAlarmItemMode = imFixed;
                   APriority: Int64 = 0):integer;
begin
  With Items.Add do
    Begin
      DisplayName := ADisplayName;
      Caption := ACaption;
      DateTime := ADateTime;
      Ident := AIdent;
      RepeatTimes := ARepeatTimes;
      Interval := AInterval;
      IntervalMode := AIntervalMode;
      Mode := AMode;
      Priority := APriority;
      result := index;
      Update;
    End;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmComponent.ClearItems;
begin
  FExecTimer.Acquire;
  ClearAlarmList;
  FAlarmThread.Suspend;
  FAlarmThread.Resume;
  FExecTimer.Release;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDAlarmComponent.Create (aOwner: TComponent);
begin
  inherited Create (aOwner);
  FSleepTime        := 500; //this MUST be initialized before threads are created VB Sep 2006
  FActive           := false;
  FExecTimer        := TCriticalSection.Create;
  FItems            := TLMDAlarmItems.Create(self);
  FAlarmTimerThread := TLMDAlarmTimerThread.Create ((csDesigning in ComponentState), self);
  FAlarmThread      := TLMDAlarmThread.Create ((csDesigning in ComponentState), self);
  FAlarmList        := TList.Create;
  FIniUse           := ioNone;
  FPriority         := false;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDAlarmComponent.Destroy;
begin
  FExecTimer.Acquire;
  try
    ClearAlarmList;
    FAlarmList.Free;
  finally
    FExecTimer.Release;
    FExecTimer.Free;
  end;

  if FAlarmThread.Suspended then //VB Sep 2006
    FAlarmThread.Resume;

  FAlarmThread.Free;

  if FAlarmTimerThread.Suspended then //VB Sep 2006
    FAlarmTimerThread.Resume;

  FAlarmTimerThread.Free;

  FItems.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmComponent.Notification (AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FIniLink) then
    begin
      if csDestroying in Owner.ComponentState then
        if not (csDesigning in ComponentState) then WriteData;
      FIniLink := nil;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlarmComponent.RemoveItem(anItem: Integer);
begin
  if (items.Count > 0) then
    if (anItem>=0) and (anItem < items.Count) then
      items.delete(anItem);
end;

end.
