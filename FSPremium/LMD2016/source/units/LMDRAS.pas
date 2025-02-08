unit LMDRAS;
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

LMDRAS unit (DD)
----------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Messages,
  LMDWebBase, LMDProcs;

const
  RASDIALEVENT = 'RasDialEvent';
  WM_RASDIALEVENT = $CCCD;

  DNLEN = 15; // Maximum domain name length
  UNLEN = 256; // Maximum user name length
  PWLEN = 256; // Maximum password length
  NETBIOS_NAME_LEN = 16; // NetBIOS net name (bytes)

  RASMaxDeviceType = 16;
  RASMaxPhoneNumber = 128;
  RASMaxIpAddress = 15;
  RASMaxIpxAddress = 21;
  RASMaxEntryName = 256;
  RASMaxDeviceName = 128;
  RASMaxCallbackNumber = RASMaxPhoneNumber;

  // Enumerates intermediate states to a connection
  RASCS_PAUSED = $1000;
  RASCS_DONE = $2000;

  RASCS_OpenPort = 0;
  RASCS_PortOpened = 1;
  RASCS_ConnectDevice = 2;
  RASCS_DeviceConnected = 3;
  RASCS_AllDevicesConnected = 4;
  RASCS_Authenticate = 5;
  RASCS_AuthNotify = 6;
  RASCS_AuthRetry = 7;
  RASCS_AuthCallback = 8;
  RASCS_AuthChangePassword = 9;
  RASCS_AuthProject = 10;
  RASCS_AuthLinkSpeed = 11;
  RASCS_AuthAck = 12;
  RASCS_ReAuthenticate = 13;
  RASCS_Authenticated = 14;
  RASCS_PrepareForCallback = 15;
  RASCS_WaitForModemReset = 16;
  RASCS_WaitForCallback = 17;
  RASCS_Projected = 18;
  RASCS_StartAuthentication = 19;
  RASCS_CallbackComplete = 20;
  RASCS_LogonNetwork = 21;

  RASCS_Interactive = RASCS_PAUSED;
  RASCS_RetryAuthentication = RASCS_PAUSED + 1;
  RASCS_CallbackSetByCaller = RASCS_PAUSED + 2;
  RASCS_PasswordExpired = RASCS_PAUSED + 3;

  RASCS_Connected = RASCS_DONE;
  RASCS_Disconnected = RASCS_DONE + 1;

  // Dial options
  RDEOPT_UsePrefixSuffix = $00000001;
  RDEOPT_PausedStates = $00000002;
  RDEOPT_IgnoreModemSpeaker = $00000004;
  RDEOPT_SetModemSpeaker = $00000008;
  RDEOPT_IgnoreSoftwareCompression = $00000010;
  RDEOPT_SetSoftwareCompression = $00000020;

type
  // RAS API
//  LPHRasConn = ^THRasConn;
  THRasConn = Longint;
//  LPRasConnState = ^TRasConnState;
  TRasConnState = Integer;

  LPRasConn = ^TRasConn;
  TRasConn = record
    dwSize: Longint;
    hrasconn: THRasConn;
    szEntryName: array[0..RASMaxEntryName] of AnsiChar;
    szDeviceType: array[0..RASMaxDeviceType] of AnsiChar;
    szDeviceName: array[0..RASMaxDeviceName] of AnsiChar;
  end;

  LPRasDialParams = ^TRasDialParams;
  TRasDialParams = record
    dwSize: Longint;
    szEntryName: array[0..RASMaxEntryName] of AnsiChar;
    szPhoneNumber: array[0..RASMaxPhoneNumber] of AnsiChar;
    szCallbackNumber: array[0..RASMaxCallbackNumber] of AnsiChar;
    szUserName: array[0..UNLEN] of AnsiChar;
    szPassword: array[0..PWLEN] of AnsiChar;
    szDomain: array[0..DNLEN] of AnsiChar;
  end;

  LPRasConnStatus = ^TRasConnStatus;
  TRasConnStatus = record
    dwSize: Longint;
    rasconnstate: TRasConnState;
    dwError: Longint;
    szDeviceType: array[0..RASMaxDeviceType] of AnsiChar;
    szDeviceName: array[0..RASMaxDeviceName] of AnsiChar;
  end;

  LPRasEntryName = ^TRasEntryName;
  TRasEntryName = record
    dwSize: Longint;
    szEntryName: array[0..RASMaxEntryName] of AnsiChar;
  end;

  TRasEntryDlg = record
    dwSize   : DWORD;
    hwndOwner: HWND;
    dwFlags  : DWORD;
    xDlg     : LongInt;
    yDlg     : LongInt;
    szEntry  : packed array[0..RASMaxEntryName] of AnsiChar;
    dwError  : DWORD;
    reserved : DWORD;
    reserved2: DWORD;
  end;

  LPRasDialExtensions = ^TRasDialExtensions;
  TRasDialExtensions = record
    dwSize: Longint;
    dwfOptions: Longint;
    hwndParent: HWND;
    reserved: Longint;
  end;

  TRasDialDlg = record
    dwSize      : DWORD;
    hwndOwner   : HWND;
    dwFlags     : DWORD;
    xDlg        : integer;
    yDlg        : integer;
    dwSubEntry  : DWORD;
    dwError     : DWORD;
    reserved    : DWORD;
    reserved2   : DWORD;
  end;

  TRasPBDlg = record
    dwSize      : DWORD;
    hwndOwner   : HWND;
    dwFlags     : DWORD;
    xDlg        : integer;
    yDlg        : integer;
    dwCallbackId: DWORD;
    pCallback   : pointer;
    dwError     : DWORD;
    reserved    : DWORD;
    reserved2   : DWORD;
  end;

  TRasMonitorDlg = record
    dwSize: DWORD;
    hwndOwner: HWND;
    dwFlags: DWORD;
    dwStartPage: DWORD;
    xDlg: LongInt;
    yDlg: LongInt;
    dwError: DWORD;
    reserved: DWORD;
    reserved2: DWORD;
  end;

  TOnAsyncEvent = procedure(Sender: TObject; State: TRasConnState; Error:
    Integer; MessageText: string) of object;

  TLMDRAS = class(TLMDWebComponent)
  private
    FErrorString: string;
    FCurrentConnection: String;
    FOnAsyncEvent: TOnAsyncEvent;
    procedure SetErrorString(const Value: string);
    procedure SetSelectConnection(const Value: String);
    function GetIsConnected: Boolean;
  protected
    hRAS: THRasConn;
    uMsg: UINT;
    hNotifier: THandle;
    procedure NotifierProc(var Message: TMessage);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetEntries(Entries: TStrings);
    procedure GetConnections(Connections: TStrings);
    function GetConnectionState(hRAS: THRasConn): TRasConnStatus;
    function Dial(const szEntry: String): Boolean;
    function HangUp: Integer;
    function GetStatusString(State: TRasConnState; Error: Integer): string;
    function DefaultConnection: String;
    // The RasPhonebookDlg function displays the main Dial-Up Networking dialog box.
    // From this modal dialog box, the user can dial, edit, or delete a selected
    // phone-book entry, create a new phone-book entry, or specify user preferences.
    // The RasPhonebookDlg function returns when the dialog box closes.
    // Params:
    // PhoneBook - full path and file name of the phone-book file
    // Entry - name of the phone-book entry to highlight
    function ShowRasPhonebookDlg(const PhoneBook: String = ''; const Entry: String = ''): Boolean;
    // The RasEntryDlg function displays modal property sheets that allow a user
    // to manipulate phone-book entries. If editing or copying an existing phone-book entry,
    // the function displays a phone-book entry property sheet. The RasEntryDlg
    // function returns when the user closes the property sheet.
    // Params:
    // PhoneBook - full path and file name of the phone-book file
    // Entry - name of the phone-book entry to edit, copy, or create
    function ShowRasEntryDlg(const PhoneBook: String = ''; const Entry: String = ''): Boolean;
    // The ShowRasDialDlg function establishes a RAS connection using a specified
    // phone-book entry and the credentials of the logged-on user. The function
    // displays a stream of dialog boxes that indicate the state of the connection operation.
    // Params:
    // PhoneBook - full path and file name of the phone-book file
    // Entry - name of the phone-book entry to dial
    // PhoneNumber - replacement phone number to dial
    function ShowRasDialDlg(const PhoneBook, Entry: String; const PhoneNumber: String = ''): Boolean;
    // The ShowRasMonitorDlg function displays the Dial-Up Networking Monitor property sheet that describes the status of RAS connections.
    // This dialog is supported only on Windows 2000 and previous versions of the operating system.
    // Params:
    // DeviceName - name of the device to display initially
    function ShowRasMonitorDlg(const DeviceName: String): boolean;
    property ErrorString: string read FErrorString write SetErrorString;
    property IsConnected: Boolean read GetIsConnected default True;
    property SelectConnection: String read FCurrentConnection write SetSelectConnection;
    property HRASCONN: THRasConn read hRAS;
  published
    property About;
    property OnAsyncEvent: TOnAsyncEvent read FOnAsyncEvent write FOnAsyncEvent;
  end;

function IsRASExist: Boolean;

implementation

uses
  SysUtils, Controls, Registry, Forms,

  LMDStringsSupport, LMDWebConst, LMDSyncUnit
  ;

type

  TRasDial = function(lpRasDialExt: LPRasDialExtensions;
    lpszPhoneBook: PAnsiChar; var params: TRasDialParams; dwNotifierType: Longint;
    lpNotifier: Pointer; var rasconn: THRasConn): Longint; stdcall;
  TRasEnumConnections = function(var RasConnArray: TRasConn; var lpcb: Longint;
    var lpcConnections: Longint): Longint; stdcall;
  TRasEnumEntries = function(reserved: PAnsiChar; lpszPhoneBook: PAnsiChar;
    var entrynamesArray: TRasEntryName; var lpcb: Longint;
    var lpcEntries: Longint): Longint; stdcall;
  TRasGetConnectStatus = function(hConn: THRasConn; var lpStatus:
    TRasConnStatus): Longint; stdcall;
  TRasGetErrorString = function(errorValue: Integer; erroString: PAnsiChar;
    cBufSize: Longint): Longint; stdcall;
  TRasHangUp = function(hConn: THRasConn): Longint; stdcall;
  TRasGetEntryDialParams = function(lpszPhoneBook: PAnsiChar;
    var lpDialParams: TRasDialParams;
    var lpfPassword: LongBool): Longint; stdcall;
  TRasPhonebookDlg = function(lpszPhonebook, pszEntry: pchar;
    var lpInfo : TRasPBDlg): BOOL; stdcall;
  TRasEntryDialog = function(lpszPhonebook: PChar; lpszEntry: PChar;
    var lpInfo: TRasEntryDlg): BOOL; stdcall;
  TRasDialDialog = function(lpszPhonebook, pszEntry, lpszPhoneNumber: pchar;
    var lpInfo: TRasDialDlg): BOOL; stdcall;
  TRasMonitorDialog = function(lpszDeviceName: PAnsiChar;
    var lpInfo: TRasMonitorDlg): BOOL; stdcall;

const
  c_rasapi32 = 'rasapi32.dll';
  c_rasdlg = 'rasdlg.dll';

var
  RLib: THandle;
  RDlg: THandle;
  RASExist: Boolean;
  bRASInit: Boolean;
  RasDial: TRasDial = nil;
  RasEnumConnections: TRasEnumConnections = nil;
  RasEnumEntries: TRasEnumEntries = nil;
  RasGetConnectStatus: TRasGetConnectStatus = nil;
  __RasGetErrorString: TRasGetErrorString = nil;
  RasHangUp: TRasHangUp = nil;
  RasGetEntryDialParams: TRasGetEntryDialParams = nil;
  RasPhonebookDlg: TRasPhonebookDlg = nil;
  RasEntryDlg: TRasEntryDialog = nil;
  RasDialDlg: TRasDialDialog = nil;
  RasMonitorDlg: TRasMonitorDialog = nil;

function  RasGetErrorString(errorValue: Integer): string;
const
  c_MaxErrorStringLength = 256;
var

  szBuf: array[0..c_MaxErrorStringLength] of Char;

begin
  if  Assigned(__RasGetErrorString) then
  begin

    if  __RasGetErrorString(errorValue, @szBuf, sizeof(szBuf)) = 0 then
      Result := szBuf

    else
      Result := Format('Unknown Error # %d', [errorValue]);
  end
  else
    Result := Format('Unknown RAS error # %d', [errorValue]);
end;

procedure RASInit;

  function GetAddress_(hModule: HMODULE; const szName: string; var Res: FARPROC): Boolean;
  begin
    Res := GetProcAddress(hModule, PChar(szName + 'A'));
    Result := Assigned(Res);
  end;

  function GetAddress(const szName: string): FARPROC;
  begin
    if  not GetAddress_(RLib, szName, Result)
        and not GetAddress_(RDlg, szName, Result) then
      raise Exception.Create('RAS fuction ' + szName + ' not found');
  end;

begin
  RLib := LoadLibrary(c_rasapi32);
  RDlg := LoadLibrary(c_rasdlg);
  RASExist:= (RLib <> 0)
{  and (RDlg <> 0)  }
  ;
  if RASExist then
    try

      RasDial:= GetAddress('RasDial');
      RasEnumConnections:= GetAddress('RasEnumConnections');
      RasEnumEntries:= GetAddress('RasEnumEntries');
      RasGetConnectStatus:= GetAddress('RasGetConnectStatus');
      __RasGetErrorString:= GetAddress('RasGetErrorString');
      RasHangUp:= GetAddress('RasHangUp');
      RasGetEntryDialParams:= GetAddress('RasGetEntryDialParams');
      if RDlg <> 0 then
      begin
        RasPhonebookDlg := GetAddress('RasPhonebookDlg');
        RasDialDlg := GetAddress('RasDialDlg');
        RasEntryDlg := GetAddress('RasEntryDlg');
        RasMonitorDlg := GetAddress('RasMonitorDlg');
      end;

    except
      if RLib <> 0  then  FreeLibrary(RLib);
      if RDlg <> 0  then  FreeLibrary(RDlg);
      RASExist:= False;
      RLib := 0;
      RDlg := 0;
    end;
end;

function IsRASExist: Boolean;
begin
  if not bRASInit then
    RASInit;
  Result:= RASExist;
end;

{ TLMDRAS }

constructor TLMDRAS.Create(AOwner: TComponent);
begin
  inherited;
  hRAS := 0;
  uMsg:= RegisterWindowMessage(RASDIALEVENT);
  if uMsg = 0 then
    uMsg:= WM_RASDIALEVENT;
  hNotifier:=AllocateHWnd(NotifierProc);
  FCurrentConnection := '';
end;

destructor TLMDRAS.Destroy;
begin
  DeallocateHWnd(hNotifier);
  inherited;
end;

function TLMDRAS.Dial(const szEntry: String): Boolean;
var
  iPassword: LongBool;
  iRes: Integer;
  DialParams: TRasDialParams;
begin
  FErrorString:= '';
  Result:= False;
  if not RASExist or not Assigned(RasDial)  then
    exit;
  HangUp;

  LMDWebClearData(DialParams, SizeOf(DialParams), 0);

  DialParams.dwSize := SizeOf(DialParams);
  StrPCopy(DialParams.szEntryName, AnsiString(szEntry));

  iRes:= RasGetEntryDialParams(nil, DialParams, iPassword);
  if iRes <> 0 then
    begin
      FErrorString:= RASE_GETPARAMS;
      exit;
    end;

  hRAS:= 0;

  iRes:= RasDial(nil, nil, DialParams, -1, Pointer(hNotifier), hRAS);

  if iRes <> 0 then
    FErrorString:= RasGetErrorString(iRes)
  else
  begin
    Result:= True;
    FCurrentConnection := szEntry;
  end;
end;

procedure TLMDRAS.GetConnections(Connections: TStrings);
var
  iBufferSize: Integer;
  iRes, i: Integer;
  iCount: Integer;
  Conn: array[0..100] of TRasConn;
begin
  Connections.Clear;
  if not IsRASExist then
    exit;

  Conn[0].dwSize:= SizeOf(TRasConn);
  iBufferSize:= SizeOf(Conn);
  iRes:= RasEnumConnections(Conn[0], iBufferSize, iCount);

  if (iRes = 0) and (iCount > 0) then
    begin
      for i := 0 to iCount - 1 do
        begin
          Connections.AddObject(String(Conn[i].szEntryName), TObject(Conn[i].hrasconn));
        end;
    end
  else
    FErrorString:= RasGetErrorString(iRes);
end;

function TLMDRAS.GetConnectionState(hRAS: THRasConn): TRasConnStatus;
var
  iRes: Integer;
  szBuf: array[0..255] of Char;
begin
  LMDWebClearData(Result,sizeof(Result),0);
  LMDWebClearData(szBuf,sizeof(szBuf),0);
//  FillChar(Result,sizeof(Result),0);
//  FillChar(szBuf,sizeof(szBuf),0);

  Result.dwSize:= SizeOf(Result);
  iRes:= RasGetConnectStatus(hRAS, Result);
  if iRes <> 0 then
    begin
      Result.rasconnstate := RASCS_Disconnected;
      FErrorString:= RasGetErrorString(iRes);
    end;
end;

procedure TLMDRAS.GetEntries(Entries: TStrings);
var
  iBufferSize: Integer;
  iRes, i: Integer;
  iEntriesCount: Integer;
  Entry: array[0..100] of TRasEntryName;
begin
  Entries.Clear;
  if not IsRASExist then
    exit;

  Entry[0].dwSize:= SizeOf(TRasEntryName);
  iBufferSize:= SizeOf(Entry);
  iRes:= RasEnumEntries(nil, nil, Entry[0], iBufferSize, iEntriesCount);

  if (iRes = 0) and (iEntriesCount > 0) then
    begin
      for i:= 0 to iEntriesCount - 1 do
        begin
          Entries.Add(String(Entry[i].szEntryName));
        end;
    end
  else
    begin
      FErrorString:= RasGetErrorString(iRes);
    end;
end;

function TLMDRAS.GetIsConnected: Boolean;
begin
  Result:= (hRAS <> 0) and (GetConnectionState(hRAS).rasconnstate = RASCS_Connected);
end;

function TLMDRAS.GetStatusString(State: TRasConnState;
  Error: Integer): string;
var
  C: array[0..255] of Char;
  S: string;
begin
  LMDWebClearData(C, sizeof(C),0);
//  FillChar(C,sizeof(C),0);
  if Error <> 0 then
    begin
      Result:= RasGetErrorString(Error);
    end
  else
    begin
      S:= '';
      case State of
        RASCS_OpenPort:
          S:= 'Opening port';
        RASCS_PortOpened:
          S:= 'Port opened';
        RASCS_ConnectDevice:
          S:= 'Connecting device';
        RASCS_DeviceConnected:
          S:= 'Device connected';
        RASCS_AllDevicesConnected:
          S:= 'All devices connected';
        RASCS_Authenticate:
          S:= 'Start authenticating';
        RASCS_AuthNotify:
          S:= 'Authentication: notify';
        RASCS_AuthRetry:
          S:= 'Authentication: retry';
        RASCS_AuthCallback:
          S:= 'Authentication: callback';
        RASCS_AuthChangePassword:
          S:= 'Authentication: change password';
        RASCS_AuthProject:
          S:= 'Authentication: projecting';
        RASCS_AuthLinkSpeed:
          S:= 'Authentication: link speed';
        RASCS_AuthAck:
          S:= 'Authentication: acknowledge';
        RASCS_ReAuthenticate:
          S:= 'Authentication: reauthenticate';
        RASCS_Authenticated:
          S:= 'Authenticated';
        RASCS_PrepareForCallback:
          S:= 'Preparing for callback';
        RASCS_WaitForModemReset:
          S:= 'Waiting for modem reset';
        RASCS_WaitForCallback:
          S:= 'Waiting for callback';
        RASCS_Projected:
          S:= 'Projected';
        RASCS_StartAuthentication:
          S:= 'Start authentication';
        RASCS_CallbackComplete:
          S:= 'Callback complete';
        RASCS_LogonNetwork:
          S:= 'Logging on network';

        RASCS_Interactive:
          S:= 'Interactive';
        RASCS_RetryAuthentication:
          S:= 'Retry Authentication';
        RASCS_CallbackSetByCaller:
          S:= 'Callback set by caller';
        RASCS_PasswordExpired:
          S:= 'Password expired';

        RASCS_Connected:
          S:= 'Connected';
        RASCS_Disconnected:
          S:= 'Disconnected';
      end;
      Result:= S;
    end;
end;

function TLMDRAS.DefaultConnection: String;
var
  Reg: TRegistry;
  RASRootKey: HKEY;
  RemAcc: string;
  IntProf: string;
begin
  Result := '';
  if (Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4) and
   (Win32MinorVersion > 0) then
  begin
    //It's Windows XP or something newer
    RASRootKey := HKEY_LOCAL_MACHINE;
    RemAcc := 'SOFTWARE\Microsoft\RAS AutoDial\Default' ;
    IntProf := 'DefaultInternet' ;
  end
  else
  begin
     RASRootKey := HKEY_CURRENT_USER;
     RemAcc := 'RemoteAccess';
     IntProf := 'InternetProfile';
  end;

  Reg := TRegistry.Create;
  try
    with Reg do
    begin
      RootKey := RASRootKey;
      if OpenKey(RemAcc, false) then
      begin
        Result := ReadString(IntProf);
        CloseKey;
      end;
    end;
  finally
    FreeAndNil(Reg);
  end;
end;

function TLMDRAS.ShowRasDialDlg(const PhoneBook, Entry: String; const PhoneNumber: String = ''): Boolean;
var
  infopb: TRasDialDlg;

begin
  Result := False;
  if not Assigned(RasDialDlg) or (Entry = '') then exit;
  LMDWebClearData(infopb, Sizeof(infopb), 0);

  if  Assigned(Owner) and (Owner is TWinControl)
    and TWinControl(Owner).HandleAllocated  then
    infopb.hwndOwner := TWinControl(Owner).Handle;

  infopb.xDlg := 100;
  infopb.yDlg := 100;

  infopb.dwSize := SizeOf(infopb);
  Result := RasDialDlg(int_Ref(PhoneBook), int_Ref(Entry), int_Ref(PhoneNumber), infopb);

//  Result := infopb.dwError = 0;
end;

function TLMDRAS.ShowRasMonitorDlg(const DeviceName: String): boolean;
var
  infopb: TRasMonitorDlg;
  P1: PChar;
begin
  Result := False;
  if not Assigned(RasMonitorDlg) then exit;
  LMDWebClearData(infopb, Sizeof(infopb), 0);

//  if  Assigned(Owner) and (Owner is TWinControl)
//    and TWinControl(Owner).HandleAllocated  then
//    infopb.hwndOwner := TWinControl(Owner).Handle;

  infopb.dwSize := SizeOf(infopb);
  try
    Result := RasMonitorDlg(PAnsiChar(int_RefA(DeviceName, P1)), infopb);
    finally
    int_Free([P1]);
  end;
//  Result := infopb.dwError = 0;
end;

function TLMDRAS.ShowRasPhonebookDlg(const PhoneBook: String = ''; const Entry: String = ''): Boolean;
var
  infopb : TRasPBDlg;

begin
  Result := False;
  if not Assigned(RasPhonebookDlg) then exit;
  LMDWebClearData(infopb, Sizeof(infopb), 0);
//  FillChar(infopb, Sizeof(TRasPBDlg), 0);

  if  Assigned(Owner) and (Owner is TWinControl)
    and TWinControl(Owner).HandleAllocated  then
    infopb.hwndOwner := TWinControl(Owner).Handle;

  infopb.dwSize := SizeOf(infopb);
  Result := RasPhonebookDlg(int_Ref(PhoneBook), int_Ref(Entry), infopb);

//  Result := infopb.dwError = 0;
end;

function TLMDRAS.ShowRasEntryDlg(const PhoneBook: String = ''; const Entry: String = ''): Boolean;
var
  infopb: TRasEntryDlg;

begin
  Result := False;
  if not Assigned(RasEntryDlg) then exit;
  LMDWebClearData(infopb, SizeOf(infopb), 0);

  infopb.dwSize := SizeOf(infopb);
  Result := RasEntryDlg(int_Ref(PhoneBook), int_Ref(Entry), infopb);

//  Result := infopb.dwError = 0;
end;

function TLMDRAS.HangUp: Integer;
var
  Stat: TRasConnStatus;
begin
  Result:= -1;
  if hRAS = 0 then
    exit;
  LMDWebClearData(Stat, SizeOf(Stat), 0);
  Stat.dwSize:= SizeOf(Stat);
  Result:= RasHangUp(hRAS);
  if (Result <> 0) then
    exit;
  while (RasGetConnectStatus(hRAS, Stat) <> ERROR_INVALID_HANDLE) do
    begin
      sleep(1);
      LMDProcessMessages;
//      Application.ProcessMessages;
    end;
  hRAS:= 0;
end;

procedure TLMDRAS.NotifierProc(var Message: TMessage);
begin
  if UINT(Message.Msg) = uMsg then
    begin
      if Assigned(FOnAsyncEvent) then
        FOnAsyncEvent(Self, Message.WParam, Message.LParam,
          GetStatusString(Message.WParam, Message.LParam));
    end;
end;

procedure TLMDRAS.SetErrorString(const Value: string);
begin
  FErrorString:= Value;
end;

procedure TLMDRAS.SetSelectConnection(const Value: String);
begin
  Dial(Value);
end;

initialization
  RLib := 0;
  RDlg := 0;
  bRASInit := False;
  RASExist := False;

finalization
  if RASExist and (RLib <> 0) then
    FreeLibrary(RLib);
  if RASExist and (RDlg <> 0) then
    FreeLibrary(RDlg);
end.
