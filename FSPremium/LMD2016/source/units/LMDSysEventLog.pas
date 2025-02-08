unit LMDSysEventLog;
{$I LMDCmps.inc}

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

LMDSysEventLog unit (RM)
-----------------------

ToDo
----
Category Descriptions (CategoryToString), Icons, Sorting

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Forms,
  LMDSysBase, LMDSysEventListView, LMDSysConst;

type
  TLMDSysEventLogRecord=record
    Length:DWORD;
    Reserved:DWORD;
    RecordNumber:DWORD;
    TimeGenerated:DWORD;
    TimeWritten:DWORD;
    EventID:DWORD;
    EventType:WORD;
    NumStrings:WORD;
    EventCategory:WORD;
    ReservedFlags:WORD;
    ClosingRecordNumber:DWORD;
    StringOffset:DWORD;
    UserSidLength:DWORD;
    UserSidOffset:DWORD;
    DataLength:DWORD;
    DataOffset:DWORD;
  end;
  PLMDSysEventLogRecord=^TLMDSysEventLogRecord;

  TLMDSysEventType=(setError, setWarning, setInformation, setAuditSuccess, setAuditFailure, setUnknown);

const
  LMDSysEventTypeString:array[TLMDSysEventType] of string=(sLMDsysEventTypeError, sLMDsysEventTypeWarning,
                                                           sLMDsysEventTypeInformation, sLMDsysEventTypeAuditSuccess,
                                                           sLMDsysEventTypeAuditFailure, sLMDSysUnknown);
  type
  TLMDSysEventInfo=record
    Source:String;
    Category:String;
    ComputerName:String;
    DateTime:TDateTime;
    EventType:TLMDSysEventType;
    EventID:DWord;
    RecordNumber:DWord;
    UserSID:PSID;
    UserName:String;
    UserNameLong:String;
    MessageText:String;
  end;
  PLMDSysEventInfo=^TLMDSysEventInfo;

  TLMDSysLogType = (sltApplication, sltSecurity, sltSystem, sltCustom);
  TLMDSysEventOnReadItem=procedure(Sender:TObject; ItemData:PLMDSysEventInfo; var Continue:Boolean) of object;
  TLMDSysEventDlgChange=procedure(Sender:TObject; Position:Integer) of object;

  TLMDSysEventDlgOptions = set of (sdoCenterDialog, sdoCenterOwnerForm, sdoListShowDialog, sdoListUpdatePosition);

const
  def_DlgOptions=[sdoCenterDialog, sdoListShowDialog, sdoListUpdatePosition];

type
  { ************************************************************************** }
  TLMDSysEventLog = class(TLMDSysComponent)
  private
    FServer: String;
    FCustom: String;
    FAuto,
    FInternal:Boolean;
    FLogHandle:HWND;
    FLogType: TLMDSysLogType;
    FDlgOptions:TLMDSysEventDlgOptions;
    FOnReadItem:TLMDSysEventOnReadItem;
    FDirection: TLMDSysDirection;
    FOnDlgChange: TLMDSysEventDlgChange;
    FOnEnd,
    FOnStart,
    FOnClick,
    FOnDlgCustomize: TNotifyEvent;
    FControl: TLMDSysEventListView;

    procedure SetCustom(const Value: String);
    procedure SetControl(const Value: TLMDSysEventListView);
    procedure SetServer(const Value: String);
    procedure SetLogType(const Value: TLMDSysLogType);

    function CheckFlags:Boolean;
    procedure GetBtnClick(Sender: TObject);
    function GetLogName: String;
    function GetCount: LongInt;
    function GetOpenState: Boolean;
  protected
    procedure DoReadItem(ItemData:PLMDSysEventInfo; var Continue:Boolean);
    procedure ExtractInfo(indata: PLMDSysEventLogRecord; outData:PLMDSysEventInfo; ExInfo: Boolean=false);
    procedure FillControl;
    procedure Loaded;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    // open log file
    procedure Open;
    // close log file
    procedure Close;

    function CategoryToString(EventCategory:WORD):String;

    // oldest record number
    function FirstRecordNr:Integer;
    // newest record number
    function LastRecordNr:Integer;

    // Read LogItem with index Nr, Pointer to TLMDSysEventInfo object must be
    // provided. ExInfo parameter specifies whether extended log information should
    // be retrieved
    function Read(nr:Integer; ItemData:PLMDSysEventInfo; ExInfo:Boolean=false):Boolean;
    // Read all log items, store data via OnEventRead
    function ReadAll(ExInfo:Boolean=false):Boolean;

    // Shows predined event dialog
    function ShowEventDialog(nr:Integer=0; aOwner: TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;

    // Returns true when a log file is currently opened
    property Opened:Boolean read GetOpenState;

    // number of items in log specified by LogType
    property Count:LongInt read GetCount;

    // return name of current log
    property LogName:String read GetLogName;

    // CLR only: Current selected number in dlg
    published
    property Server:String read FServer write SetServer;
    property LogType:TLMDSysLogType read FLogType write SetLogType default sltApplication;
    property CustomLog:String read FCustom write SetCustom;

    property ReadDirection:TLMDSysDirection read FDirection write FDirection default sdDescending;

    property DlgOptions:TLMDSysEventDlgOptions read FDlgOptions write FDlgOptions default def_DlgOptions;

    // ReadEvents
    property OnReadAllStart:TNotifyEvent read FOnStart write FOnStart;
    property OnReadAllEnd:TNotifyEvent read FOnEnd write FOnEnd;
    property OnReadEvent:TLMDSysEventOnReadItem read FOnReadItem write FOnReadItem;

    // DisplayControl Connection
    property AutoRetrieve:Boolean read FAuto write FAuto default true;
    property DisplayControl:TLMDSysEventListView read FControl write SetControl;

    // Events
    property OnDetailsDlgCustomize:TNotifyEvent read FOnDlgCustomize write FOnDlgCustomize;
    property OnDetailsDlgChange:TLMDSysEventDlgChange read FOnDlgChange write FOnDlgChange;
    property OnDetailsDlgBtnClick:TNotifyEvent read FOnClick write FOnClick;

  end;

implementation
uses
  Controls, ComCtrls, Sysutils, Registry,
  LMDSysEventLogDetailsForm, LMDUtils, LMDSysIn;

const
  EVENTLOG_SEQUENTIAL_READ = $1;
  EVENTLOG_SEEK_READ = $2;
  EVENTLOG_FORWARDS_READ = $4;
  EVENTLOG_BACKWARDS_READ = $8;

  eBufferSize = $20000; //128k

procedure LMDSysEventRaiseError;
begin
  raise Exception.Create(sLMDSysEventNotOpen);
end;

function LMDMakeLangID(PrimaryLang, SubLang: DWORD): DWORD;
begin
  Result := (SubLang shl 10) or PrimaryLang;
end;

{ **************************** TLMDSysEventLog ********************************** }
{ ------------------------------- private ------------------------------------ }
procedure TLMDSysEventLog.SetCustom(const Value: String);
begin
  if Value<>FCustom then
    begin
      if FLogType=sltCustom then Close;
      FCustom:=Value;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventLog.SetControl(const Value: TLMDSysEventListView);
begin
  if Value<>FControl then
    begin
      if FControl<>nil then
        FControl.LogControl:=nil;
      FControl := Value;
      if FControl<>nil then
        begin
          FControl.LogControl:=self;
          FControl.FreeNotification(self);
          if CheckFlags then FillControl;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventLog.SetLogType(const Value: TLMDSysLogType);
var
  tmp:Boolean;
begin
  if FLogType<>Value then
    begin
      tmp:=Opened;
      Close;
      FLogType:=Value;
      if tmp then Open;
      if CheckFlags then FillControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventLog.SetServer(const Value: String);
begin
  if FServer<>Value then
    begin
      Close;
      FServer:=Value;
      if CheckFlags then FillControl;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDSysEventLog.CheckFlags: Boolean;
begin
  result:=FAuto and not ((csDesigning in ComponentState) or (csLoading in ComponentState));
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventLog.GetBtnClick(Sender: TObject);
var
  tmp:Integer;

  // slower, but works with any sorted column
  function SearchRecord(index:Integer):Integer;
  var
    i:Integer;
  begin
    result:=-1;
    for i:=0 to FControl.Items.Count-1 do
      if FControl.Items[i].Data = Pointer(Index) then
      begin
          result:=i;
          break;
        end;
  end;
begin
  if Assigned(FOnClick) then FOnClick(Sender);
  if not (sdoListUpdatePosition in FDlgOptions) then exit;

  if Assigned(FControl) and FControl.Visible then
    with FControl do
      begin
        tmp:=searchRecord(TComponent(Sender).Tag);
        if tmp<0 then tmp:=0;
        if tmp>Items.Count-1 then tmp:=Items.Count-1;
        Items[tmp].Selected:=true;
        Items[tmp].Focused:=true;
        Items[tmp].MakeVisible(true);
      end;
end;

{------------------------------------------------------------------------------}
function TLMDSysEventLog.GetOpenState: Boolean;
begin
  result := FLogHandle <> 0;
  end;

{------------------------------------------------------------------------------}
function TLMDSysEventLog.GetCount: LongInt;

var
  tmp:DWORD;

begin
  if not Opened then
    begin
      result:=0;
      LMDSysEventRaiseError;
      exit;
    end;
  GetNumberOfEventLogRecords (FLogHandle, tmp);
  Result:=tmp;
  end;

{------------------------------------------------------------------------------}
function TLMDSysEventLog.GetLogName: String;
const
  LogNames:array[TLMDSysLogType] of String=('Application', 'Security', 'System','');
begin
  if FLogType=sltCustom then
    result:=FCustom
  else
    result:=LogNames[FLogType];
end;

{ --------------------------- protected -------------------------------------- }

procedure TLMDSysEventLog.DoReadItem(ItemData: PLMDSysEventInfo; var Continue: Boolean);

var
  tmp:TListItem;
begin
  if Assigned(FControl) then
    with ItemData^ do
    begin
        tmp := FControl.Items.Add;
        tmp.Data := Pointer(RecordNumber);
        tmp.Caption := LMDSysEventTypeString[EventType];
        tmp.ImageIndex:=Ord(EventType);
        tmp.SubItems.Add(DateToStr(DateTime));
        tmp.SubItems.Add(TimeToStr(DateTime));
        tmp.SubItems.Add(Source);
        tmp.SubItems.Add(Category);
        tmp.SubItems.Add(inttostr(EventID));
        tmp.SubItems.Add(UserName);
        tmp.SubItems.Add(ComputerName);
      end;

  if not FInternal then
    if Assigned (FOnReadItem) then
      FOnReadItem(self, ItemData, Continue);
end;

{------------------------------------------------------------------------------}

procedure TLMDSysEventLog.ExtractInfo(indata: PLMDSysEventLogRecord; outData:PLMDSysEventInfo; ExInfo: Boolean);

var
  tmp: PAnsiChar;
  Arguments, pArguments: ^PAnsiChar;
  resDLLName, st1,st2, stMessage, key:string;
  dllHandle:THandle;
  SIDUse:SID_NAME_USE;
  sLen:DWORD;
  ps:Integer;

  // Format Insertion Strings
  function GetInsertionStrings: string;
  var
    tmps:PAnsiChar;
    i:Integer;
  begin
     result:='';
     if indata^.numstrings=0 then exit;
     tmps:=PAnsiChar(indata)+indata^.StringOffset;
     result:=' (';
     for i:=0 to indata^.numstrings-1 do
       begin
         if i=indata^.numstrings-1 then
           result:=result+String(tmps)+')'
         else
           result:=result+String(tmps)+',';
         Inc(tmps,lstrlenA(tmps)+1); // move pointer to next item
       end;
  end;

  // Get a single Insertion Strings
  function GetInsertionString(ix:Integer):string;
  var
    tmps:PChar;
  begin
    result:='';
    if ix>=Integer(indata^.NumStrings) then exit;
    tmps:= PChar(indata)+indata^.StringOffset;
    while ix>0 do
      begin
        Inc(tmps,lstrlen(tmps)+1);
        Dec(ix);
      end;
    result:=tmps;
  end;

begin
  // DateTime
  outdata^.DateTime:=LMDSysUnixTimeToDateTime(inData^.TimeGenerated);

  // RecordNumber
  outdata^.RecordNumber:=inData^.RecordNumber;

  // EventID
  outdata^.EventID:=inData^.EventID and $FFFF;

  // EventType
  if indata^.EventType AND EVENTLOG_ERROR_TYPE=EVENTLOG_ERROR_TYPE then
    outData^.EventType:=setError
  else
    if indata^.EventType AND EVENTLOG_WARNING_TYPE=EVENTLOG_WARNING_TYPE then
      outData^.EventType:=setWarning
    else
      if indata^.EventType AND EVENTLOG_INFORMATION_TYPE=EVENTLOG_INFORMATION_TYPE then
        outData^.EventType:=setInformation
      else
        if indata^.EventType AND EVENTLOG_AUDIT_SUCCESS=EVENTLOG_AUDIT_SUCCESS then
          outData^.EventType:=setAuditSuccess
        else
          if indata^.EventType AND EVENTLOG_AUDIT_FAILURE=EVENTLOG_AUDIT_FAILURE then
            outData^.EventType:=setAuditFailure
          else
            outData^.EventType:=setUnknown;

  tmp := PAnsiChar(indata)+sizeof(TLMDSysEventLogRecord);
  // point to sourcename
  outdata^.Source := string(tmp);
  // ComputerName follows after sourcename
  tmp := tmp + length (tmp) + 1;
  outdata^.ComputerName := string(tmp);

  outdata^.UserSID:=nil;
  outdata^.UserName:=sLMDSysNOTAVAILABLE;
  outdata^.UserNameLong:=sLMDSysNOTAVAILABLE;
  if indata^.UserSidLength>0 then
    begin
      outdata^.UserSID:=PSID(PChar(indata) + indata^.userSIDOffset);
      sLen:=256;
      SetLength(st1, sLen);SetLength(st2, sLen);
      if LookupAccountSID('', outdata^.UserSID,PChar(st1), sLen, PChar(st2),sLen,SIDUse) then
        begin
          //st1=Account, st2=Domain
          st1:=PChar(st1);st2:=Pchar(st2);
          outdata^.UserNameLong:=st2+'\'+st1;
          if ((SIDUse=sidTypeUser) or (SIDUse=sidTypeGroup)) and (st2<>LMDSIComputerName) then
            outdata^.UserName:=st2+'\'+st1
          else
            outdata^.UserName:=st1;
         end
    end;

  // Category
  outdata^.Category:=CategoryToString(inData^.EventCategory);
  if not ExInfo then
    exit;

  if (inData^.EventCategory<>0) then
    begin
      st1:=''; st2:=''; // Category Data
      with TRegistry.Create(KEY_READ) do
        try
          RootKey:=HKEY_LOCAL_MACHINE;
          key:='SYSTEM\CurrentControlSet\Services\EventLog\'+LogName+'\'+outdata^.source;
          OpenKeyReadOnly(key);
          // Get Path to localized resource dll
          resDLLname:=ReadString('CategoryMessageFile');
          if resDLLname<>'' then
            // The EventMessageFile key can contain more than one file reference (separated by ';')
            repeat
              tmp:='';
              ps:=Pos (';', resDLLname);
              if ps=0 then
                st1:=resDLLname  // only one file mentioned
              else
                begin
                  st1:=Copy(resDLLname,1,ps);
                  resDLLName:=Copy(resDLLName,ps+1, $FFFF);
                end;

              // expand %systemroot% and other shortcuts
              SetLength(st2, MAX_PATH);
              sLen:=ExpandEnvironmentStrings (PChar(st1),PChar(st2),MAX_PATH);
              SetLength(st2, sLen);
              dllHandle:=LoadLibraryEx(PChar(st2),0,LOAD_LIBRARY_AS_DATAFILE);
              if dllHandle<>0 then
                try
                 if FormatMessageA(FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_HMODULE,
                                   Pointer(dllHandle), indata^.EventCategory, 0, PAnsiChar(@tmp), 0, nil)>0 then
                   begin
                     outdata^.Category := string(tmp);
                     LocalFree(THandle(tmp)); //FORMAT_MESSAGE_ALLOCATE_BUFFER
                     break;
                   end;
                 finally
                  FreeLibrary(dllHandle);
                end;
              until (ps=0);
        finally
          Free;
        end;
    end;

  st1:=''; st2:='';
  // Move pointer to message description data
  tmp:=PAnsiChar(indata)+indata^.StringOffset;

  GetMem(Arguments,indata^.NumStrings*sizeof(PChar));
  try
      // FORMAT_MESSAGE_ARGUMENT_ARRAY flag: Pass a pointer to an array of values
    pArguments:=Arguments;
    tmp:=PAnsiChar(indata)+indata^.StringOffset;
    for ps:=0 to indata^.NumStrings-1 do
      begin
        pArguments^:=tmp;
        Inc(tmp,lstrlenA(tmp)+1);
        Inc(pArguments);
      end;

    // look up message string from resource dll
    // The location of resource dll can be found in system registry (EventMessageFile)
    with TRegistry.Create(KEY_READ) do
      try
        RootKey:=HKEY_LOCAL_MACHINE;
        key:='SYSTEM\CurrentControlSet\Services\EventLog\'+LogName+'\'+outdata^.source;
        OpenKeyReadOnly(key);
        // Get Path to localized resource dll
        resDLLname:=ReadString('EventMessageFile');

        if resDLLname = '' then
           stMessage := sLMDSysMessageDLLNOTFOUNT + GetInsertionStrings
        else
          // The EventMessageFile key can contain more than one file reference (separated by ';')
          repeat
            tmp:='';
            ps:=Pos (';', resDLLname);
            if ps=0 then
              st1:=resDLLname  // only one file mentioned
            else
              begin
                st1:=Copy(resDLLname,1,ps-1); // -1 added VB Nov 2005 to fix BTS284
                resDLLName:=Copy(resDLLName,ps+1, $FFFF);
              end;

            // expand %systemroot% and other shortcuts
            SetLength(st2, MAX_PATH);
            sLen:=ExpandEnvironmentStrings (PChar(st1),PChar(st2),MAX_PATH);
            SetLength(st2, sLen);
            dllHandle:=LoadLibraryEx(PChar(st2),0,LOAD_LIBRARY_AS_DATAFILE);
            if dllHandle<>0 then
              try
                 if FormatMessageA(FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_HMODULE or FORMAT_MESSAGE_ARGUMENT_ARRAY,
                                   Pointer(dllHandle),indata^.EventID, LMDMakeLangID( LANG_NEUTRAL, SUBLANG_DEFAULT), PAnsiChar(@tmp), 0, Arguments)>0 then
                   begin
                      stMessage := string(tmp);
                      LocalFree(THandle(tmp)); //FORMAT_MESSAGE_ALLOCATE_BUFFER
                      break;
                   end;
              finally
                FreeLibrary(dllHandle);
              end;
          until (ps=0);
      finally
        Free
      end

  finally
    FreeMem (Arguments)
  end;
  outdata^.MessageText:=stMessage;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventLog.FillControl;
begin
  if not Assigned(FControl) then exit;
  // try to open log
  Open;
  //check whether log is really opened, otherwise exit (e.g. on Win9X systems)
  if not Opened then exit;
  with FControl do
    try
      SortDirection:=sdDescending;
      SortedColumn:=-1;
      FInternal:=True;
      Items.BeginUpdate;
      Items.Clear;
      ReadAll;
    finally
      Items.EndUpdate;
      FInternal:=False;
      Close;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventLog.Loaded;
begin
  inherited;
  if FAuto and not (csDesigning in ComponentState) then FillControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventLog.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and (aComponent = FControl) then
    DisplayControl:=nil;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDSysEventLog.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FDlgOptions:=def_DlgOptions;
  FAuto:=True;
  FDirection:=sdDescending;
  end;

{------------------------------------------------------------------------------}
destructor TLMDSysEventLog.Destroy;
begin
  Close;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventLog.Close;
begin
  if not Opened then exit;
  CloseEventLog(FLogHandle);
  FLogHandle:=0;
  end;

{------------------------------------------------------------------------------}
procedure TLMDSysEventLog.Open;
var
  tmp:String;
begin
  tmp:=LogName;
  if Opened or (not LMDSIWindowsNT) then exit;
  FLogHandle:=OpenEventLog(PChar(FServer), PChar(tmp));
  if (FLogHandle=0) then LMDSysEventRaiseError;
  end;

{------------------------------------------------------------------------------}
function TLMDSysEventLog.CategoryToString(EventCategory: WORD): String;
begin
  if EventCategory=0 then
    result:=sLMDSysNone
  else
    result:='('+Inttostr(EventCategory)+')';
end;

{------------------------------------------------------------------------------}
function TLMDSysEventLog.ReadAll(ExInfo:Boolean=false):Boolean;
var
  buffer:PAnsiChar;
  pevlr:PLMDSysEventLogRecord;
  first, flags, tmpflags, ipos, dwRead, dwNeeded:DWORD;
  tmp: Boolean;
  eventinfo:TLMDSysEventInfo;

begin
  result:=false;
  if not Opened then
    begin
      LMDSysEventRaiseError;
      exit;
    end;

  if FDirection=sdDescending then
    begin
      // get newest record
      first:=LastRecordNr;
      flags := EVENTLOG_SEEK_READ or EVENTLOG_BACKWARDS_READ;
      tmpflags:=EVENTLOG_SEQUENTIAL_READ or EVENTLOG_BACKWARDS_READ;
    end
  else
    begin
      first:=FirstRecordNr;
      flags := EVENTLOG_SEEK_READ or EVENTLOG_FORWARDS_READ;
      tmpflags:=EVENTLOG_SEQUENTIAL_READ or EVENTLOG_FORWARDS_READ;
    end;
  if Assigned(FOnStart) then FOnStart(self);
  Screen.Cursor:=crHourGlass;
  GetMem (buffer, eBufferSize);
  try
    while ReadEventLogA(FLogHandle, flags, first, buffer, eBufferSize, dwRead, dwNeeded) do
      begin
        ipos:=0;
        flags:=tmpflags;

        // run through buffer to extract single records
        while ipos< dwRead do
          begin
            pevlr:=PLMDSysEventLogRecord(buffer + ipos);
            Inc (ipos, pevlr^.Length);
            ExtractInfo(pevlr, @eventinfo, exinfo);
            tmp:=True;
            DoReadItem(@eventinfo, tmp);
            if not tmp then exit;
          end;
    end;
    result:=true;
  finally
    FreeMem (buffer);
    Screen.Cursor:=crDefault;
    if Assigned(FOnEnd) then FOnEnd(self);
  end
end;

{------------------------------------------------------------------------------}

function TLMDSysEventLog.Read(nr: Integer; ItemData: PLMDSysEventInfo; ExInfo: Boolean): Boolean;

var
  buffer:PAnsiChar;
  pevlr:PLMDSysEventLogRecord;
  gpos, dwRead, dwNeeded:DWORD;
  dummy : char;
  lErr:dword;
  lStat: boolean;
begin
  result:=false;
  if not Opened then
    begin
      LMDSysEventRaiseError;
      exit;
    end;
  buffer:=nil;
  gpos:=FirstRecordNr+nr;
  lStat := ReadEventLogA(FLogHandle, EVENTLOG_SEEK_READ or EVENTLOG_FORWARDS_READ, gpos, @dummy, 0, dwRead, dwNeeded);
  lErr := GetLastError;
  if not lStat and (lErr = ERROR_INSUFFICIENT_BUFFER) then
    try
      GetMem (buffer, dwNeeded);
      ReadEventLogA(FLogHandle, EVENTLOG_SEEK_READ or EVENTLOG_FORWARDS_READ, gpos, buffer, dwNeeded, dwRead, dwNeeded);
      pevlr:=PLMDSysEventLogRecord(buffer);
      ExtractInfo(pevlr, itemdata, exinfo);
      result:=true;
    finally
      if buffer<>nil then FreeMem (buffer)
   end
end;

{------------------------------------------------------------------------------}
function TLMDSysEventLog.FirstRecordNr: Integer;

var
  tmp:DWORD;

begin
  result:=-1;
  if not Opened then
    begin
      LMDSysEventRaiseError;
      exit;
    end;
  GetOldestEventLogRecord(FLogHandle, tmp);
  result:=tmp;
  end;

{------------------------------------------------------------------------------}
function TLMDSysEventLog.LastRecordNr: Integer;

var
  tmp:DWORD;

begin
  result:=-1;
  if not Opened then
    begin
      LMDSysEventRaiseError;
      exit;
    end;
  GetOldestEventLogRecord(FLogHandle, tmp);
  tmp:=tmp+DWord(Count)-1;
  result:=tmp;
  end;

{------------------------------------------------------------------------------}
function TLMDSysEventLog.ShowEventDialog(nr: Integer=0; aOwner: TCustomForm=nil; X: Integer = -1; Y: Integer = -1): Boolean;
var
  tmp:TLMDSysEventInfo;
  dlg:TfrmLMDSysLogDetails;
begin
  result:=Read(nr, @tmp, true);
  if result then
    begin
      dlg:=TfrmLMDSysLogDetails.Create(nil);
      with dlg do
        try
          FOwner:=self;
          FPosition:=nr;
          FCount:=self.Count;
          DisplayEvent(@tmp);
          if Assigned(FOnDlgChange) then
            OnChange:=FOnDlgChange;

          // Position
          if AOwner<>nil then
            LMDCenterChild(TCustomForm(AOwner), dlg)
          else
            if sdoCenterDialog in FDlgOptions then
            begin
              if not (sdoCenterOwnerForm in FDlgOptions) then
                LMDCenterForm(dlg)
              else
                if self.Owner is TCustomForm then
                  LMDCenterChild(TCustomForm(self.Owner), dlg, false);
            end
            else
            begin
              if X <> -1 then dlg.Left := X;
              if Y <> -1 then dlg.Top := Y;
            end;

          if Assigned(FOnDlgCustomize) then
            FOnDlgCustomize(dlg);

          OnBtnClick := GetBtnClick;

          ShowModal;

          result:=true;
        finally
          free;
        end;
    end
  else
    raise Exception.Create(sLMDSysEventDlgError);
end;

end.
