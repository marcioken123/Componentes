unit LMDShNtf;
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

LMDShNtf unit (DS)
-----------------
Contains TLMDShellNotify component.


Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}
interface

uses
  Windows, Classes, ShlObj, Messages,
  LMDShPIDL, LMDShBase, LMDShMisc, LMDShUtils;

type
  {****************************************************************************}
  TLMDShellNotifyEventType =(snAnyEvent, snDiskEvent, snGlobalEvent, snAssociationChanged,
    snAttributesChanged, snDriveAdded, snDriveRemoved, snItemCreated,
    snItemDeleted, snItemUpdated, snItemRenamed, snFolderCreated, snFolderDeleted,
    snFolderRenamed, snFolderUpdated, snFreespaceChanged, snImageUpdated,
    snMediaInserted, snMediaRemoved, snNetworkDriveAdded, snResourceShared,
    snResourceUnshared, snServerDisconnected);
  TLMDShellNotifyEventTypes = set of TLMDShellNotifyEventType;

  {****************************************************************************}
  TLMDShellInterruptOption = (ioAcceptInterrupts, ioAcceptNonInterrupts);
  TLMDShellInterruptOptions = set of TLMDShellInterruptOption;

  {****************************************************************************}
  TLMDShellNotifyEvent1 = procedure(aSender : TObject; aPIDL : PItemIDList) of object;

  {****************************************************************************}
  TLMDShellNotifyEvent2 = procedure(aSender : TObject; aPIDL1, aPIDL2 : PItemIDList) of object;

  {****************************************************************************}
  TLMDShellNotifyEvent3 = procedure(aSender : TObject; aPIDL1, aPIDL2 : PItemIDList; aEvents : TLMDShellNotifyEventTypes) of object;

  {****************************************************************************}
  TLMDShellNotifyEvent4 = procedure(aSender : TObject; aDrive : Cardinal) of object;

  {****************************************************************************}
  TLMDShellNotificationItem = class
  private
    FPidl1      : PItemIDList;
    FPidl2      : PItemIDList;
    FEventMask  : DWORD;
  public
    constructor Create(aPidl1, aPidl2 : PItemIDList; aMask : DWORD);
    destructor Destroy; override;

    property EventMask : DWORD
        read FEventMask
        write FEventMask;

  end;

  {****************************************************************************}
  TLMDShellNotificationEvents = class
  private
    FItems      : TList;
    function GetCount : integer;
    function GetHead : TLMDShellNotificationItem;
  public
    { constructor / destructor }
    constructor Create;
    destructor Destroy; override;

    { methods }
    function Add(aItem : TLMDShellNotificationItem) : TLMDShellNotificationItem;
    procedure Clear;
    procedure PopHead;

    { properties }
    property Head : TLMDShellNotificationItem
        read GetHead;

    property Count : integer
        read GetCount;
  end;

  {****************************************************************************}
  TLMDShellNotify = class(TLMDShellComponent)
  private
    { property variables }
    FActive             : boolean;
    FNotifyEvents       : TLMDShellNotifyEventTypes;
    FOptions            : TLMDShellInterruptOptions;
    FWatchFolder        : string;
    FWatchPidl          : PItemIDList;
    FWatchSubFolders    : boolean;
    FRootFolder         : TLMDRoot;
    FMaxNotifications   : integer;

    { internal variables }
    FHandle             : HWnd;
    FRegistered         : boolean;
    FHNotify            : THandle;
    FEvents             : TLMDShellNotificationEvents;
    FSNotifyEvents      : TLMDShellNotifyEventTypes;
    FRenameCounter      : integer;
    FDeleteCounter      : integer;
    { event variables }
    FOnAssociationChange : TNotifyEvent;
    FOnAttributeChange   : TLMDShellNotifyEvent2;
    FOnDriveAdd          : TLMDShellNotifyEvent1;
    FOnDriveRemove       : TLMDShellNotifyEvent1;
    FOnDriveSpaceChange  : TLMDShellNotifyEvent4;
    FOnFileChange        : TLMDShellNotifyEvent1;
    FOnFileCreate        : TLMDShellNotifyEvent1;
    FOnFileDelete        : TLMDShellNotifyEvent2;
    FOnFileRename        : TLMDShellNotifyEvent2;
    FOnFolderChange      : TLMDShellNotifyEvent1;
    FOnFolderCreate      : TLMDShellNotifyEvent1;
    FOnFolderDelete      : TLMDShellNotifyEvent1;
    FOnFolderRename      : TLMDShellNotifyEvent2;
    FOnImageListChange   : TNotifyEvent;
    FOnMediaInsert       : TLMDShellNotifyEvent1;
    FOnMediaRemove       : TLMDShellNotifyEvent1;
    FOnNetShare          : TLMDShellNotifyEvent1;
    FOnNetUnShare        : TLMDShellNotifyEvent1;
    FOnServerDisconnect  : TLMDShellNotifyEvent1;
    FOnShellChangeNotify : TLMDShellNotifyEvent3;
    FOnShellDriveAdd     : TLMDShellNotifyEvent1;

    { property methods }
    procedure SetActive(const aValue : boolean);
    procedure SetNotifyEvents(const aValue : TLMDShellNotifyEventTypes);
    procedure SetOptions(const aValue : TLMDShellInterruptOptions);
    procedure SetRootFolder(const aValue : TLMDRoot);
    procedure SetWatchFolder(const aValue : string);
    procedure SetWatchPidl(aValue : PItemIDList);
    procedure SetWatchSubFolders(const aValue : boolean);

    { internal methods }
    function GetRenamedPIDL(aPIDL : PItemIDList) : PItemIDList;
  protected
    procedure Loaded; override;
    procedure WndProc(var Msg : TMessage);
    procedure ShellNotifyRegister;
    procedure ShellNotifyUnRegister;

    { virtual event methods }
    procedure DoAssociationChange; virtual;
    procedure DoAttributesChange(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList); virtual;
    procedure DoDriveAdd(aPIDL : PItemIDList); virtual;
    procedure DoDriveRemove(aPIDL : PItemIDList); virtual;
    procedure DoDriveSpaceChange(aDrives : DWORD); virtual;
    procedure DoFileChange(aPIDL : PItemIDList); virtual;
    procedure DoFileCreate(aPIDL : PItemIDList); virtual;
    procedure DoFileDelete(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList); virtual;
    procedure DoFileRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList); virtual;
    procedure DoFolderChange(aPIDL : PItemIDList); virtual;
    procedure DoFolderCreate(aPIDL : PItemIDList); virtual;
    procedure DoFolderDelete(aPIDL : PItemIDList); virtual;
    procedure DoFolderRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList); virtual;
    procedure DoImageListChange; virtual;
    procedure DoMediaInsert(aPIDL : PItemIDList); virtual;
    procedure DoMediaRemove(aPIDL : PItemIDList); virtual;
    procedure DoNetShare(aPIDL : PItemIDList); virtual;
    procedure DoNetUnShare(aPIDL : PItemIDList); virtual;
    procedure DoServerDisconnect(aPIDL : PItemIDList); virtual;
    procedure DoShellDriveAdd(aPIDL : PItemIDList); virtual;
    procedure DoShellChangeNotify(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList;
      aEvents : TLMDShellNotifyEventTypes); virtual;

  public
    { constructor / destructor }
    constructor Create(aOwner : TComponent); override;
    destructor Destroy; override;

    { properties }    
    property WatchPidl : PItemIDList
        read FWatchPidl
        write SetWatchPidl;

  published
    { properties }
    property Active : boolean
        read FActive
        write SetActive;

    property NotifyEvents : TLMDShellNotifyEventTypes
        read FNotifyEvents
        write SetNotifyEvents;

    property Options : TLMDShellInterruptOptions
        read FOptions
        write SetOptions;
        property WatchFolder : string
        read FWatchFolder
        write SetWatchFolder;

    property WatchSubFolders : boolean
        read FWatchSubFolders
        write SetWatchSubFolders;
        property RootFolder : TLMDRoot
        read FRootFolder
        write SetRootFolder;

    property MaxNotifications : integer
        read FMaxNotifications
        write FMaxNotifications;

    { events }
    property OnAssociationChange : TNotifyEvent
      read FOnAssociationChange
      write FOnAssociationChange;

    property OnAttributeChange : TLMDShellNotifyEvent2
      read FOnAttributeChange
      write FOnAttributeChange;

    property OnDriveAdd : TLMDShellNotifyEvent1
      read FOnDriveAdd
      write FOnDriveAdd;

    property OnDriveRemove : TLMDShellNotifyEvent1
      read FOnDriveRemove
      write FOnDriveRemove;

    property OnDriveSpaceChange : TLMDShellNotifyEvent4
      read FOnDriveSpaceChange
      write FOnDriveSpaceChange;

    property OnFileChange : TLMDShellNotifyEvent1
      read FOnFileChange
      write FOnFileChange;

    property OnFileCreate : TLMDShellNotifyEvent1
      read FOnFileCreate
      write FOnFileCreate;

    property OnFileDelete : TLMDShellNotifyEvent2
      read FOnFileDelete
      write FOnFileDelete;

    property OnFileRename : TLMDShellNotifyEvent2
      read FOnFileRename
      write FOnFileRename;

    property OnFolderChange : TLMDShellNotifyEvent1
      read FOnFolderChange
      write FOnFolderChange;

    property OnFolderCreate : TLMDShellNotifyEvent1
      read FOnFolderCreate
      write FOnFolderCreate;

    property OnFolderDelete : TLMDShellNotifyEvent1
      read FOnFolderDelete
      write FOnFolderDelete;

    property OnFolderRename : TLMDShellNotifyEvent2
      read FOnFolderRename
      write FOnFolderRename;

    property OnImageListChange : TNotifyEvent
      read FOnImageListChange
      write FOnImageListChange;

    property OnMediaInsert : TLMDShellNotifyEvent1
      read FOnMediaInsert
      write FOnMediaInsert;

    property OnMediaRemove : TLMDShellNotifyEvent1
      read FOnMediaRemove
      write FOnMediaRemove;

    property OnNetShare : TLMDShellNotifyEvent1
      read FOnNetShare
      write FOnNetShare;

    property OnNetUnShare : TLMDShellNotifyEvent1
      read FOnNetUnShare
      write FOnNetUnShare;

    property OnServerDisconnect : TLMDShellNotifyEvent1
      read FOnServerDisconnect
      write FOnServerDisconnect;

    property OnShellChangeNotify : TLMDShellNotifyEvent3
      read FOnShellChangeNotify
      write FOnShellChangeNotify;

    property OnShellDriveAdd : TLMDShellNotifyEvent1
      read FOnShellDriveAdd
      write FOnShellDriveAdd;

  end;

implementation

uses
  Forms, SysUtils, ShellApi,
  LMDShConsts, LMDShItem, LMDStrings;

const
  WM_SHELLNOTIFY                = WM_USER + 1;
  WM_SHELLNOTIFY_REFLECTION     = WM_USER + 2;

  SHCNF_ACCEPT_INTERRUPTS       = $0001;
  SHCNF_ACCEPT_NON_INTERRUPTS   = $0002;
  SHCNF_NO_PROXY                = $8000;

  cNTF : array[TLMDShellNotifyEventType] of DWORD = (
    SHCNE_ALLEVENTS, SHCNE_DISKEVENTS, SHCNE_GLOBALEVENTS, SHCNE_ASSOCCHANGED,
    SHCNE_ATTRIBUTES, SHCNE_DRIVEADD, SHCNE_DRIVEREMOVED, SHCNE_CREATE,
    SHCNE_DELETE, SHCNE_UPDATEITEM, SHCNE_RENAMEITEM, SHCNE_MKDIR, SHCNE_RMDIR,
    SHCNE_RENAMEFOLDER, SHCNE_UPDATEDIR, SHCNE_FREESPACE, SHCNE_UPDATEIMAGE,
    SHCNE_MEDIAINSERTED, SHCNE_MEDIAREMOVED, SHCNE_DRIVEADDGUI, SHCNE_NETSHARE,
    SHCNE_NETUNSHARE, SHCNE_SERVERDISCONNECT);

type
  {****************************************************************************}
  TNotifyRegister = packed record
    pidl                : PItemIDList;
    WatchSubTree        : BOOL;
  end;
  PNotifyRegister = ^TNotifyRegister;

  {****************************************************************************}
  PLMDShellTwoPIDLArray = ^TLMDShellTwoPIDLArray;
  TLMDShellTwoPIDLArray = packed record
    PIDL1: PItemIDList;
    PIDL2: PItemIDList;
  end;

  {****************************************************************************}
  PLMDDriveSpaceRec = ^TLMDDriveSpaceRec;
  TLMDDriveSpaceRec = packed record
    Dummy : Word;
    Item1 : DWORD;
    Item2 : DWORD;
  end;

  {****************************************************************************}
  TLMDSHChangeNotifyRegister = function(Window: HWND; Flags: DWORD; EventMask: ULONG;
//    MessageID: UINT; ItemCount: DWORD; var Items: array of TNotifyRegister) : THandle; stdcall;
    MessageID: UINT; ItemCount: DWORD; var Items: TNotifyRegister) : THandle;stdcall;
  TLMDSHChangeNotifyDeregister = function(Notification: THandle): BOOL; stdcall;
  TLMDSHChangeNotifyLock = function(MemoryMap: THandle; ProcessID: DWORD;

    var PIDLs: PLMDShellTwoPIDLArray; var EventID: ULONG): THandle; stdcall;

//    var PIDLs: PLMDShellTwoPIDLArray; var EventID: ULONG): THandle; stdcall;
  TLMDSHChangeNotifyUnLock = function(Lock: THandle): BOOL; stdcall;

var
  LMDSHChangeNotifyRegister   : TLMDSHChangeNotifyRegister = nil;
  LMDSHChangeNotifyDeregister : TLMDSHChangeNotifyDeregister = nil;
  i_LMDSHChangeNotifyLock     : TLMDSHChangeNotifyLock = nil;
  i_LMDSHChangeNotifyUnLock   : TLMDSHChangeNotifyUnLock = nil;

function  LMDSHChangeNotifyLock(MemoryMap: THandle; ProcessID: DWORD;

    var PIDLs: PLMDShellTwoPIDLArray; var EventID: ULONG): THandle;

begin
  if  Assigned(i_LMDSHChangeNotifyLock) then
    Result := i_LMDSHChangeNotifyLock(MemoryMap, ProcessID, PIDLs, EventID)
  else
    Result := 0;
end;

{-----------}

function  LMDSHChangeNotifyUnLock(Lock: THandle): BOOL;
begin
  if  Assigned(i_LMDSHChangeNotifyUnLock) then
    Result := i_LMDSHChangeNotifyUnLock(Lock)
  else
    Result := False;
end;

{-----------}

{------------------------------------------------------------------------------}
function LMDShellNotifyEnumToConst(NotifyType: TLMDShellNotifyEventType): DWORD;
begin
  Result:= cNTF[NotifyType];
end;

{** TLMDShellNotificationItem *************************************************}
{-- private -------------------------------------------------------------------}
{-- protected -----------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
constructor TLMDShellNotificationItem.Create(aPidl1, aPidl2 : PItemIDList; aMask : DWORD);
begin
  inherited Create;
  if aPidl1 <> nil then FPidl1 := LMDShPIDLClone(aPidl1);
  if aPidl2 <> nil then FPidl2 := LMDShPIDLClone(aPidl2);
  FEventMask := aMask;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellNotificationItem.Destroy;
begin
  if Assigned(FPidl1) then LMDShPIDLFree(FPidl1);
  if Assigned(FPidl2) then LMDShPIDLFree(FPidl2);
  inherited;
end;

{** TLMDShellNotificationEvents ***********************************************}
{-- private -------------------------------------------------------------------}
function TLMDShellNotificationEvents.GetCount : integer;
begin
  if  Assigned(FItems)  then
    result := FItems.Count
  else
    Result := 0;
end;

{------------------------------------------------------------------------------}
function TLMDShellNotificationEvents.GetHead : TLMDShellNotificationItem;
begin
  result := nil;
  if FItems.count = 0 then Exit;
  result := TLMDShellNotificationItem(FItems[0]);
end;

{-- protected -----------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
constructor TLMDShellNotificationEvents.Create;
begin
  inherited;
  FItems := TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellNotificationEvents.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotificationEvents.PopHead;
begin
  if FItems.count = 0 then Exit;
  FItems.Delete(0);
end;

{------------------------------------------------------------------------------}
function TLMDShellNotificationEvents.Add(aItem : TLMDShellNotificationItem) : TLMDShellNotificationItem;
begin
  FItems.Add(aItem);
  result := aItem;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotificationEvents.Clear;
var
  i : integer;
begin
  for i := 0 to FItems.count-1 do
    TObject(FItems[i]).Free;
  FItems.Clear;
end;

{** TLMDShellNotify ***********************************************************}
{-- private -------------------------------------------------------------------}
procedure TLMDShellNotify.SetActive(const aValue : boolean);
begin
  if FActive = aValue then Exit;
  FActive := aValue;
  if (csDesigning in ComponentState) then Exit;
  if FActive and not FRegistered then
    ShellNotifyRegister
  else
  if not(FActive) and FRegistered then
    ShellNotifyUnRegister;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.SetNotifyEvents(const aValue : TLMDShellNotifyEventTypes);
begin
  if FNotifyEvents = aValue then Exit;
  FNotifyEvents := aValue;
  if FActive then ShellNotifyRegister;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.SetOptions(const aValue : TLMDShellInterruptOptions);
begin
  if FOptions = aValue then Exit;
  FOptions := aValue;
  if FActive then ShellNotifyRegister;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.SetRootFolder(const aValue : TLMDRoot);
begin
  if LMDAnsiSameText(FRootFolder, aValue) then Exit;
  FRootFolder := aValue;
  if (csDesigning in ComponentState) then Exit;

  if (FRootFolder <> '') then
    begin
      WatchFolder := '';
      if FRootFolder = sRFDesktop then WatchPidl := nil
      else
        WatchPidl := LMDGetRootFolderID(FRootFolder);
      if FActive then ShellNotifyRegister;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.SetWatchFolder(const aValue : string);
var
  tmpPIDL : PItemIDList;
begin
  if LMDAnsiSameText(FWatchFolder, aValue) then Exit;
  FWatchFolder := aValue;
  if FWatchFolder <> '' then
    if (Pos(':', FWatchFolder) <> 0) and (Length(FWatchFolder) = 2) then
      FWatchFolder := FWatchFolder + '\';

  if FWatchFolder <> '' then
    begin
      RootFolder := '';
      tmpPIDL := LMDPathToPidl(FWatchFolder);
      if Assigned(tmpPIDL)  then
        begin
          WatchPidl := tmpPIDL;
          LMDShPIDLFree(tmpPIDL);
        end;
      if FActive then ShellNotifyRegister;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.SetWatchPidl(aValue : PItemIDList);
begin
  if LMDPIDLIsEqual(FWatchPidl, aValue) then
    Exit;
  if Assigned(FWatchPidl) then
    LMDShPIDLFree(FWatchPidl);
  if Assigned(aValue) then
    FWatchPidl := LMDShPIDLClone(aValue);
  if FActive then
    ShellNotifyRegister;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.SetWatchSubFolders(const aValue : boolean);
begin
  if FWatchSubFolders = aValue then Exit;
  FWatchSubFolders := aValue;
  if FActive then ShellNotifyRegister;
end;

{------------------------------------------------------------------------------}
function TLMDShellNotify.GetRenamedPIDL(aPIDL : PItemIDList) : PItemIDList;
var
  tmpPIDL       : PItemIDList;
  tmpPath       : string;

  Flags         : DWORD;
  ParentFolder  : IShellFolder;
  RelativeID    : PItemIDList;
  Folder        : IShellFolder;
  hwndParent    : HWND;
  Enum          : IEnumIDList;
  Count         : Cardinal;
  AbsoluteID    : PItemIDList;
  rgelt         : array of PItemIDList;
  function ID_ParentFolder(aPIDL : PItemIDList) : IShellFolder;
  var
    tmpPIDL : PItemIDList;
  begin
    Result := nil;
    tmpPIDL := LMDShPIDLClone(aPIDL);
    LMDShPIDLRemoveLastID(tmpPIDL);
    Result := GetIShellFolder(tmpPIDL);
    LMDShPIDLFree(tmpPIDL);
  end;

begin
  Result := nil;

  if aPIDL = nil then Exit;

  tmpPIDL := LMDShPIDLClone(aPIDL);
  LMDShPIDLRemoveLastID(tmpPIDL);
  tmpPath := LMDPidlToPath(aPIDL);

  Flags := SHCONTF_FOLDERS or SHCONTF_NONFOLDERS or SHCONTF_INCLUDEHIDDEN;

  if LMDPIDLIsEqual(tmpPIDL, LMDDesktopID) then
    begin
      ParentFolder := LMDDesktopFolder;
      RelativeID := LMDShPIDLClone(tmpPIDL);
      Folder := LMDDesktopFolder;
    end
  else
    begin
//      ParentFolder := ID_ParentFolder(tmpPIDL);
//      RelativeID := LMDShPIDLClone(LMDShPIDLFindLastID(tmpPIDL));
//      Folder := GetIShellFolder(RelativeID);
      ParentFolder := ID_ParentFolder(aPIDL);
      RelativeID := LMDShPIDLClone(LMDShPIDLFindLastID(tmpPIDL));
      Folder := ParentFolder;
    end;

  LMDShPIDLFree(RelativeID);
  hwndParent := 0;
  Enum := nil;
  SetLength(rgelt, 1);

  if Folder <> nil then Folder.EnumObjects(hwndParent, Flags, Enum);
  if Assigned(Enum) then
    while (Result = nil) and Succeeded(Enum.Next(1, rgelt[0], Count)) do
    begin
        if Count = 0 then Break;

        AbsoluteID :=  LMDShPIDLCombine(tmpPIDL, rgelt[0]);

        if LMDAnsiSameText(tmpPath, LMDPidlToPath(AbsoluteID)) then
          Result := LMDShPIDLClone(AbsoluteID);
        LMDShPIDLsFree(rgelt);
        LMDShPIDLFree(AbsoluteID);
      end;

  LMDShPIDLFree(tmpPIDL);
  Enum := nil;
  Folder := nil;
  ParentFolder := nil;
end;

{-- protected -----------------------------------------------------------------}
procedure TLMDShellNotify.Loaded;
begin
  inherited;
  if FActive and not FRegistered then ShellNotifyRegister;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.WndProc(var Msg : TMessage);
const
  Count : Integer = 0;
var
  Lock          : THandle;

  DrvSpace      : PLMDDriveSpaceRec;
  PidlArray     : PLMDShellTwoPIDLArray;

  EventMask     : DWORD;
  NItem         : TLMDShellNotificationItem;
begin
//  Lock := 0;
  case Msg.Msg of
    WM_SHELLNOTIFY :
      begin
        if (FMaxNotifications <> 0) and (FEvents.Count > FMaxNotifications) then Exit;
        if true then  //Win32Platform = VER_PLATFORM_WIN32_NT then
          Lock := LMDSHChangeNotifyLock(THandle(Msg.wParam), DWORD(Msg.lParam),

              PidlArray, EventMask)

        else
          begin
            EventMask := DWORD(Msg.lParam);

            PidlArray := PLMDShellTwoPIDLArray(Msg.wParam);

          end;

        if IsElement(SHCNE_ATTRIBUTES, EventMask) then
          begin
            FSNotifyEvents := [];
            FSNotifyEvents := [snAttributesChanged];
            DoAttributesChange(PidlArray.Pidl1, PidlArray.Pidl2);
            DoShellChangeNotify(PidlArray.Pidl1, PidlArray.Pidl2, FSNotifyEvents);
            Exit;
          end;
        NItem := TLMDShellNotificationItem.Create(PidlArray.Pidl1, PidlArray.Pidl2, EventMask);
        FEvents.Add(NItem);

        if Lock <> 0 then LMDSHChangeNotifyUnLock(Lock);

        if FEvents.Count = 1 then PostMessage(FHandle, WM_SHELLNOTIFY_REFLECTION, 0, 0);
        Exit;
      end;
    WM_SHELLNOTIFY_REFLECTION :
      begin
        if FEvents.Count = 0 then Exit;
        NItem := FEvents.Head;
        while NItem <> nil do
          begin
            FSNotifyEvents := [];
//            NItem := FEvents.Head;

            if IsElement(SHCNE_ASSOCCHANGED, NItem.EventMask) then
            begin
              FSNotifyEvents := FSNotifyEvents + [snAssociationChanged];
              DoAssociationChange;
            end;

            if IsElement(SHCNE_UPDATEITEM, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snItemUpdated];
                DoFileChange(NItem.FPidl1);
              end;

            if IsElement(SHCNE_CREATE, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snItemCreated];
                DoFileCreate(NItem.FPidl1);
             end;

            if IsElement(SHCNE_DELETE, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snItemDeleted];
                DoFileDelete(NItem.FPidl1, NItem.FPidl2);
              end;

            if IsElement(SHCNE_RENAMEITEM, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snItemRenamed];
                DoFileRename(NItem.FPidl1, NItem.FPidl2);
              end;

            if IsElement(SHCNE_DRIVEADD, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snDriveAdded];
                DoDriveAdd(NItem.FPidl1);
              end;

            if IsElement(SHCNE_DRIVEREMOVED, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snDriveRemoved];
                DoDriveRemove(NItem.FPidl1);
              end;

            if IsElement(SHCNE_DRIVEADDGUI, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snNetworkDriveAdded];
                DoShellDriveAdd(NItem.FPidl1);
              end;

            if IsElement(SHCNE_MEDIAINSERTED, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snMediaInserted];
                DoMediaInsert(NItem.FPidl1);
              end;

            if IsElement(SHCNE_MEDIAREMOVED, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snMediaRemoved];
                DoMediaRemove(NItem.FPidl1);
              end;

            if IsElement(SHCNE_MKDIR, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snFolderCreated];
                DoFolderCreate(NItem.FPidl1);
              end;

            if IsElement(SHCNE_RMDIR, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snFolderDeleted];
                DoFolderDelete(NItem.FPidl1);
              end;

            if IsElement(SHCNE_RENAMEFOLDER, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snFolderRenamed];
                DoFolderRename(NItem.FPidl1, NItem.FPidl2);
              end;

            if IsElement(SHCNE_UPDATEDIR, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snFolderUpdated];
                DoFolderChange(NItem.FPidl1);
              end;

            if IsElement(SHCNE_NETSHARE, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snResourceShared];
                DoNetShare(NItem.FPidl1);
              end;

            if IsElement(SHCNE_NETUNSHARE, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snResourceUnShared];
                DoNetUnShare(NItem.FPidl1);
              end;

            if IsElement(SHCNE_SERVERDISCONNECT, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snServerDisconnected];
                DoServerDisconnect(NItem.FPidl1);
              end;

            if IsElement(SHCNE_UPDATEIMAGE, NItem.EventMask) then
              begin
                FSNotifyEvents := FSNotifyEvents + [snImageUpdated];
                DoImageListChange;
              end;

            if IsElement(SHCNE_FREESPACE, NItem.EventMask) then
              begin

                DrvSpace := PLMDDriveSpaceRec(NItem.FPidl1);

                FSNotifyEvents := FSNotifyEvents + [snFreespaceChanged];
                DoDriveSpaceChange(DrvSpace.Item1);
              end;

            DoShellChangeNotify(NItem.FPidl1, NItem.FPidl2, FSNotifyEvents);
            NItem.Free;
            FEvents.PopHead;
            NItem := FEvents.Head;
          end;
        Exit;
      end;
    else
      Msg.Result := DefWindowProc(FHandle, Msg.Msg, Msg.wParam, Msg.lParam);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.ShellNotifyRegister;
var
//  NR            : array[0..0] of TNotifyRegister;
  NR            : TNotifyRegister;
  EventType     : TLMDShellNotifyEventType;
  Flags         : DWORD;
  EventMask     : DWORD;
begin
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then
    Exit;

  NR.pidl := FWatchPidl;
  NR.WatchSubTree := FWatchSubFolders;
{
  NR[0].pidl := FWatchPidl;
  NR[0].WatchSubTree := FWatchSubFolders;
}
  if FHNotify <> 0 then ShellNotifyUnRegister;

  Flags:= SHCNF_NO_PROXY;
  if ioAcceptInterrupts in FOptions then Flags := Flags or SHCNF_ACCEPT_INTERRUPTS;
  if ioAcceptNonInterrupts in FOptions then Flags := Flags or SHCNF_ACCEPT_NON_INTERRUPTS;

  EventMask:= 0;
  for EventType := Low(TLMDShellNotifyEventType) to High(TLMDShellNotifyEventType) do
    if EventType in FNotifyEvents then
      EventMask := EventMask or LMDShellNotifyEnumToConst(EventType);

//  FHNotify := LMDSHChangeNotifyRegister(FHandle, Flags, EventMask, WM_SHELLNOTIFY, 1, NR[0]);
  if  Assigned(LMDSHChangeNotifyRegister) then
    FHNotify := LMDSHChangeNotifyRegister(FHandle, Flags, EventMask, WM_SHELLNOTIFY, 1, NR)
  else
    FHNotify := 0;
    FRegistered := (FHNotify <> 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.ShellNotifyUnRegister;
begin
  if FHNotify <> 0 then
    begin
      LMDSHChangeNotifyDeregister(FHNotify);
      FHNotify := 0;
      FRegistered := False;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoAssociationChange;
begin
  if Assigned(FOnAssociationChange) then
    FOnAssociationChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoAttributesChange(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
begin
  if Assigned(FOnAttributeChange) then
    FOnAttributeChange(Self, aPIDL1, aPIDL2);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoDriveAdd(aPIDL : PItemIDList);
begin
  if Assigned(FOnDriveAdd) then
    FOnDriveAdd(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoDriveRemove(aPIDL : PItemIDList);
begin
  if Assigned(FOnDriveRemove) then
    FOnDriveRemove(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoDriveSpaceChange(aDrives : DWORD);
begin
  if Assigned(FOnDriveSpaceChange) then
    FOnDriveSpaceChange(Self, aDrives);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoFileChange(aPIDL : PItemIDList);
begin
  if Assigned(FOnFileChange) then
    FOnFileChange(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoFileCreate(aPIDL : PItemIDList);
begin
  if Assigned(FOnFileCreate) then
    FOnFileCreate(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoFileDelete(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
begin
  if Assigned(FOnFileDelete) then
    FOnFileDelete(Self, aPIDL1, aPIDL2);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoFileRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
var
  tmpPIDL : PItemIDList;
begin
  Inc(FRenameCounter);
  if FRenameCounter < 6 then Exit;
  FRenameCounter := 0;

  if Assigned(FOnFileRename) then
    begin
      tmpPIDL := GetRenamedPIDL(aPIDL2);

      try
        FOnFileRename(Self, aPIDL1, tmpPIDL);
      finally
        LMDShPIDLFree(tmpPIDL);
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoFolderChange(aPIDL : PItemIDList);
begin
  if Assigned(FOnFolderChange) then
    FOnFolderChange(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoFolderCreate(aPIDL : PItemIDList);
begin
  if Assigned(FOnFolderCreate) then
    FOnFolderCreate(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoFolderDelete(aPIDL : PItemIDList);
begin
{
  Inc(FDeleteCounter);
  if FDeleteCounter < 4 then Exit;
  FDeleteCounter := 0;
}
  if Assigned(FOnFolderDelete) then
    FOnFolderDelete(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoFolderRename(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList);
var
  tmpPIDL : PItemIDList;
begin
{
  Inc(FRenameCounter);
  if FRenameCounter < 6 then Exit;
}
  FRenameCounter := 0;

  tmpPIDL := GetRenamedPIDL(aPIDL2);
  if Assigned(FOnFolderRename) then
    FOnFolderRename(Self, aPIDL1, tmpPIDL);
  LMDShPIDLFree(tmpPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoImageListChange;
begin
  if Assigned(FOnImageListChange) then
    FOnImageListChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoMediaInsert(aPIDL : PItemIDList);
begin
  if Assigned(FOnMediaInsert) then
    FOnMediaInsert(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoMediaRemove(aPIDL : PItemIDList);
begin
  if Assigned(FOnMediaRemove) then
    FOnMediaRemove(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoNetShare(aPIDL : PItemIDList);
begin
  if Assigned(FOnNetShare) then
    FOnNetShare(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoNetUnShare(aPIDL : PItemIDList);
begin
  if Assigned(FOnNetUnShare) then
    FOnNetUnShare(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoServerDisconnect(aPIDL : PItemIDList);
begin
  if Assigned(FOnServerDisconnect) then
    FOnServerDisconnect(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoShellDriveAdd(aPIDL : PItemIDList);
begin
  if Assigned(FOnShellDriveAdd) then
    FOnShellDriveAdd(Self, aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellNotify.DoShellChangeNotify(aPIDL1 : PItemIDList; aPIDL2 : PItemIDList; aEvents : TLMDShellNotifyEventTypes);
begin
  if Assigned(FOnShellChangeNotify) then
    FOnShellChangeNotify(Self, aPIDL1, aPIDL2, aEvents);
end;

{-- public --------------------------------------------------------------------}
constructor TLMDShellNotify.Create(aOwner : TComponent);
begin
  inherited;
  FNotifyEvents := [snAnyEvent];
  FOptions := [ioAcceptInterrupts, ioAcceptNonInterrupts];
  FWatchFolder := '';
  FWatchPidl := nil;
  FWatchSubFolders := False;
  FRootFolder := sRFDesktop;
  FWatchSubFolders := True;
  FActive := False;
  FRegistered := False;
  FMaxNotifications := 5;
  FEvents := TLMDShellNotificationEvents.Create;
  FRenameCounter := 0;
  FDeleteCounter := 0;
  if not (csDesigning in ComponentState) then
    FHandle:=AllocateHWnd(WndProc);
end;

{------------------------------------------------------------------------------}
destructor TLMDShellNotify.Destroy;
begin
  if FHNotify <> 0 then
    ShellNotifyUnRegister;
  if FHandle <> 0 then
    DeallocateHWnd(FHandle);
  FreeAndNil(FEvents);
  if FWatchPidl <> nil then
    LMDShPIDLFree(FWatchPidl);
  inherited;
end;

{------------------------------------------------------------------------------}

procedure GetFunctions;
begin
  if hShell32 = 0 then Exit;

  LMDSHChangeNotifyRegister := GetProcAddress(hShell32, PChar(2));
  LMDSHChangeNotifyDeregister:= GetProcAddress(hShell32, PChar(4));
//  if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin
      i_LMDSHChangeNotifyLock := GetProcAddress(hShell32, PChar(644));
      i_LMDSHChangeNotifyUnLock := GetProcAddress(hShell32, PChar(645));
    end;

end;

initialization
  GetFunctions;
end.
