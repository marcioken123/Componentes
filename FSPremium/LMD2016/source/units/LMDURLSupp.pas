unit LMDURLSupp;
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

LMDURLSupp unit (DD)
--------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Registry, WinInet,
  LMDRAS, LMDFSSupport;

const
  CFSTR_MIME_HTML = 'text/html';
  GLOBALOFFLINE_KEY =
    '\SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\INTERNET SETTINGS\';
type
  TLMDURI=class(TObject)
  public
    class procedure NormalizePath(var APath: string);
  end;

  TLMDInternetOptionsInteractiveAction= (IA_DIAL_QUERY);
  TLMDInternetOptionsInteractiveResult= (IR_YES,IR_NO);
  TLMDInternetOptions=class;

  TLMDInternetOptionsInteractiveEvent=function (Sender:TLMDInternetOptions;Action : TLMDInternetOptionsInteractiveAction):TLMDInternetOptionsInteractiveResult of object;
  TLMDSocksVersion = (sv4, sv4A, sv5);
  { **************************TLMDInternetOptions**************************** }
  TLMDInternetOptions = class(TPersistent)
  private
    FUseProxy: boolean;
    FUseProxyAuth: boolean;
    FConnectTimeOut: integer;
    FDataTimeout: integer;
    FProxyPort: integer;
    FUserAgent: string;
    FProxyName: string;
    FProxyPassword: string;
    FProxyUserName: string;
    FConnectRetries: integer;
    FModemConnection: boolean;
    FUseDefaultOptions: boolean;
    FServerThreads: integer;
    FUseDefaultBows: boolean;
    FUseIEDUNSettings: boolean;
    FAutoDial: boolean;
    FAutoClose: boolean;
    FDUN: string;
    FPathList: TStringList;
    FSocksProxy: boolean;
    FSocksVersion: TLMDSocksVersion;
    FForceInternetCheck: boolean;
    FOnInteractiveEvent: TLMDInternetOptionsInteractiveEvent;
    procedure SetUseDefaultOptions(const Value: boolean);
    procedure SetAutoDial(const Value: boolean);
    procedure SetAutoClose(const Value: boolean);
    procedure SetDUN(const Value: string);
    procedure SetPathList(const Value: TStringList);
    procedure SetUseDefaultBows(const Value: boolean);
    procedure SetUseIEDUNSettings(const Value: boolean);
    procedure SetSocksProxy(const Value: boolean);
    procedure SetSocksVersion(const Value: TLMDSocksVersion);
    procedure SetForceInternetCheck(const Value: boolean);
    procedure SetOnInteractiveEvent(
      const Value: TLMDInternetOptionsInteractiveEvent);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property   PathList: TStringList read FPathList write SetPathList;
  published
    property ConnectRetries: integer read FConnectRetries write FConnectRetries default 2;
    property ConnectTimeout: integer read FConnectTimeOut write FConnectTimeOut default 30;
    property DataTimeout: integer read FDataTimeout write FDataTimeout default 0;
    property UseProxy: boolean read FUseProxy write FUseProxy default False;
    property SocksProxy: boolean read FSocksProxy write SetSocksProxy default True;
    property SocksVersion: TLMDSocksVersion read FSocksVersion write
      SetSocksVersion;
    property ProxyName: string read FProxyName write FProxyName;
    property ProxyPort: integer read FProxyPort write FProxyPort default 0;
    property UseProxyAuth: boolean read FUseProxyAuth write FUseProxyAuth default True;
    property ProxyUserName: string read FProxyUserName write FProxyUserName;
    property ProxyPassword: string read FProxyPassword write FProxyPassword;
    property UserAgent: string read FUserAgent write FUserAgent stored True;
    property UseDefaultOptions: boolean read FUseDefaultOptions write
      SetUseDefaultOptions default false;
    property ServerThreads: integer read FServerThreads write FServerThreads default 4;
    property ModemConnection: boolean read FModemConnection write
      FModemConnection default True;
    property UseDefaultBrowser: boolean read FUseDefaultBows write
      SetUseDefaultBows default True;
    property AutoDial: boolean read FAutoDial write SetAutoDial default True;
    property AutoClose: boolean read FAutoClose write SetAutoClose default True;
    property ForceInternetCheck: boolean read FForceInternetCheck write
      SetForceInternetCheck default false;
    property UseIEDUNSettings: boolean read FUseIEDUNSettings write
      SetUseIEDUNSettings default True;
    property DUN: string read FDUN write SetDUN;

    property OnInteractiveEvent:TLMDInternetOptionsInteractiveEvent read FOnInteractiveEvent write SetOnInteractiveEvent;
  end;

procedure SetConnectionOptions(hInet: HINTERNET; Options: TLMDInternetOptions);
procedure SetProxyAuthOptions(hInet: HINTERNET; Options: TLMDInternetOptions);
function CheckConnected(hInet: HINTERNET; bModem: boolean): boolean;

procedure LMDParseURI(const AURI: string; var VProtocol, VHost, VPath, VDocument, VPort,
      VBookmark, VUserName, VPassword, VParams: string); overload;
procedure LMDParseURI(const URI: string; var Protocol, Host, path, Document, Params,
  Port, Bookmark: string); overload;
procedure LMDParseURI(const URI: string; var Protocol, Host, path, Document,
  Port, Bookmark: string); overload;

procedure ParseURI(const AURI: string; var VProtocol, VHost, VPath, VDocument, VPort, VBookmark,
      VUserName, VPassword: string); overload;
procedure ParseURI(const AURI: string; var VProtocol, VHost, VPath, VDocument, VPort, VBookmark
      : string); overload;

function  CombineURL(const szBaseURL,szRelativeURL:String):String;

function CheckInet(IO: TLMDInternetOptions): boolean;
procedure SetDisconnect(IO: TLMDInternetOptions);
function CanCheckConnected: boolean;
function InternetCompareURL(Url1, Url2: string): boolean;
function CheckInCache(const szURL: string): boolean;
function CheckLocal(const szURL: string): boolean;
procedure SetGlobalOffline(bOffline: boolean);
function GetGlobalOffline: boolean;
function CheckInetConnected(bModem: boolean): boolean;
function GetHost(const URL_: string): string;
function GetHostURL(const URL_: string): string;
function GetPath(const URL_: string): string;
function ExtractURLFilePath(const FileName: string): string;
function ExtractURLRelativePath(const BaseName, DestName: string): string;
function ExtractURLFileName(const FileName: string): string;

function  CallInternetCrackUrl(const URL: string; dwFlags: DWORD;
    var Scheme, HostName, UserName, Password, UrlPath,
    ExtraInfo: Ansistring; var nPort: INTERNET_PORT): BOOL; overload;
function  CallInternetCrackUrl(const URL: string; dwFlags: DWORD;
    var Scheme, HostName: string; var nPort: INTERNET_PORT): BOOL; overload;

procedure LMDWebAllocTURLComponents(var uComp: TURLComponents; dwFlags: DWORD);
procedure LMDWebFreeTURLComponents(var uComp: TURLComponents; dwFlags: DWORD);

implementation

uses
  Math, SysUtils,
  LMDWebBase, LMDRASSupport, LMDStringsSupport, LMDProcs;

var
  hWININET: THANDLE;

  InternetGetConnectedStateProc: function(out lpdwFlags:
          DWORD; dwReserved: DWORD): BOOL; stdcall = nil;

const
  WinInetLib = 'WININET.DLL';

{-----------------------------------------------------------------------------}
function CheckConnected(hInet: HINTERNET; bModem: boolean): boolean;
var
  dwFlags: DWORD;
begin
  dwFlags:= INTERNET_CONNECTION_MODEM or INTERNET_CONNECTION_PROXY;
  if not bModem then
    dwFlags:= dwFlags or INTERNET_CONNECTION_LAN;
  if Assigned(InternetGetConnectedStateProc) then
    Result:= InternetGetConnectedStateProc(dwFlags, 0)
  else
    Result:= True;
end;

{-----------------------------------------------------------------------------}
function CanCheckConnected: boolean;
begin
  Result:= Assigned(InternetGetConnectedStateProc);
end;

{-----------------------------------------------------------------------------}
function CheckInetConnected(bModem: boolean): boolean;
var
  hInet: HINTERNET;
begin
  hInet:= InternetOpen('LMDWEB20', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  Result:= CheckConnected(hInet, bModem);
  InternetCloseHandle(hInet);
end;

{-----------------------------------------------------------------------------}
function  int_InternetSetOption(hInet: HINTERNET; dwOption: DWORD;
  dwValue: DWORD): BOOL; overload;
begin

  Result := InternetSetOption(hInet, dwOption, @dwValue, sizeof(dwValue));

end;

{-----------------------------------------------------------------------------}
function  int_InternetSetOption(hInet: HINTERNET; dwOption: DWORD;
  const Str: string): BOOL; overload;
begin
  Result := InternetSetOption(hInet, dwOption, int_Ref(Str), Length(Str));
end;

{-----------------------------------------------------------------------------}
procedure SetConnectionOptions(hInet: HINTERNET; Options: TLMDInternetOptions);
var
  szTmp: string;
  Proxy: TINTERNETPROXYINFO;

begin
  int_InternetSetOption(hInet, INTERNET_OPTION_CONNECT_RETRIES, Options.ConnectRetries);
  int_InternetSetOption(hInet, INTERNET_OPTION_CONNECT_TIME, Options.ConnectTimeout);
  int_InternetSetOption(hInet, INTERNET_OPTION_RECEIVE_TIMEOUT, Options.DataTimeout);
  int_InternetSetOption(hInet, INTERNET_OPTION_SEND_TIMEOUT, Options.DataTimeout);
  int_InternetSetOption(hInet, INTERNET_OPTION_DATA_RECEIVE_TIMEOUT, Options.DataTimeout);
  int_InternetSetOption(hInet, INTERNET_OPTION_DATA_SEND_TIMEOUT, Options.DataTimeout);
  LMDWebClearData(Proxy, sizeof(Proxy), 0);
//  FillChar(Proxy, sizeof(Proxy), 0);
  if Options.UseProxy then
    begin
      Proxy.dwAccessType:= INTERNET_OPEN_TYPE_PROXY;
      szTmp:= Options.ProxyName + ':' + IntToStr(Options.ProxyPort) + #0;
      Proxy.lpszProxy:= {$IFDEF LMDCOMP14}
                        PAnsiChar(AnsiString(szTmp))
                        {$ELSE}int_ref(szTmp)
                        {$ENDIF};
    end
  else
    begin
      Proxy.dwAccessType:= INTERNET_OPEN_TYPE_DIRECT;
    end;

  InternetSetOption(hInet, INTERNET_OPTION_PROXY, @Proxy, sizeof(Proxy));

end;

{-----------------------------------------------------------------------------}
procedure SetProxyAuthOptions(hInet: HINTERNET; Options: TLMDInternetOptions);
begin
  if Options.UseProxy and Options.UseProxyAuth then
    begin
      int_InternetSetOption(hInet, INTERNET_OPTION_PROXY_USERNAME, Options.ProxyUserName);
      int_InternetSetOption(hInet, INTERNET_OPTION_PROXY_PASSWORD, Options.ProxyPassword);
    end;
end;

{-----------------------------------------------------------------------------}
procedure ParseURI(const AURI: string; var VProtocol, VHost, VPath, VDocument, VPort, VBookmark,
      VUserName, VPassword: string);
begin
  ParseURI(AURI, VProtocol, VHost, VPath, VDocument, VPort, VBookmark);
  VUserName := '';
  VPassword := '';
end;

{-----------------------------------------------------------------------------}
procedure ParseURI(const AURI: string; var VProtocol, VHost, VPath, VDocument, VPort, VBookmark
      : string);
begin
  LMDParseURI(AURI, VProtocol, VHost, VPath, VDocument, VPort, VBookmark);
end;

{-----------------------------------------------------------------------------}
function GetGlobalOffline: boolean;
var
  Reg: TRegistry;
begin
  Reg:= TRegistry.Create;
  if Reg.OpenKeyReadOnly(GLOBALOFFLINE_KEY) then
    begin
      Result:= Reg.ReadBool('GlobalUserOffline');
    end
  else
    Result:= False;
  Reg.Free;
end;

{-----------------------------------------------------------------------------}
procedure SetGlobalOffline(bOffline: boolean);
var
  Reg: TRegistry;
begin
  Reg:= TRegistry.Create;
  if Reg.OpenKey(GLOBALOFFLINE_KEY, False) then
    begin
      Reg.WriteBool('GlobalUserOffline', bOffline);
    end;
  Reg.Free;
end;

{------------------------------------------------------------------------------}
function CheckInCache(const szURL: string): boolean;
begin
  Result:= False;
end;

{-----------------------------------------------------------------------------}
function CheckLocal(const szURL: string): boolean;
var
  LProto, LHost, LPath, LDoc, LPort, LBookmark: string;
begin
  ParseURI(szURL, LProto, LHost, LPath, LDoc, LPort, LBookmark);
  Result:= (LProto = '') or SameText(LProto, 'FILE')
    or SameText(LHost, 'localhost') or SameText(LHost, '127.0.0.1');
end;

{-----------------------------------------------------------------------------}
function InternetCompareURL(Url1, Url2: string): boolean;
var
  LProto1, LHost1, LPath1, LDoc1, LPort1, LBookmark1: string;
  LProto2, LHost2, LPath2, LDoc2, LPort2, LBookmark2: string;
begin
  ParseURI(UpperCase(Url1), LProto1, LHost1, LPath1, LDoc1, LPort1, LBookmark1);
  ParseURI(UpperCase(Url2), LProto2, LHost2, LPath2, LDoc2, LPort2, LBookmark2);
  Result:= (LProto1 + LHost1 + LPath1 + LDoc1 + LPort1) = (LProto2 + LHost2 +
    LPath2 + LDoc2 + LPort2);
end;

{-----------------------------------------------------------------------------}
function GetHost(const URL_: string): string;
var
  LProto, LHost, LPath, LDoc, LPort, LBookmark: string;
begin
  ParseURI(URL_, LProto, LHost, LPath, LDoc, LPort, LBookmark);
  Result:= LHost;
end;

{-----------------------------------------------------------------------------}
function GetHostURL(const URL_: string): string;
var
  LProto, LHost, LPath, LDoc, LPort, LBookmark: string;
begin
  ParseURI(URL_, LProto, LHost, LPath, LDoc, LPort, LBookmark);
  Result:= LProto + '://' + LHost;
  if LPort <> '' then
    Result:= Result + ':' + LPort;
end;

{-----------------------------------------------------------------------------}
function GetPath(const URL_: string): string;
var
  LProto, LHost, LPath, LDoc, LPort, LBookmark: string;
begin
  LMDParseURI(URL_, LProto, LHost, LPath, LDoc, LPort, LBookmark);
  Result:= LPath + LDoc;
  if Result = '' then
    Result:= '/';
end;

{------------------------------------------------------------------------------}
class procedure TLMDURI.NormalizePath(var APath: string);
var
  i: Integer;
begin
  // Normalize the directory delimiters to follow the UNIX syntax
  i := 1;
  while i <= Length(APath) do begin
    if AnsiChar(APath[i]) in LeadBytes then begin
      inc(i, 2)
    end else if APath[i] = '\' then begin    {Do not Localize}
      APath[i] := '/';    {Do not Localize}
      inc(i, 1);
    end else begin
      inc(i, 1);
    end;
  end;
end;

{------------------------------------------------------------------------------}
function  i_Pos(const Substr, S: string): Integer;
begin
  if LeadBytes = [] then
    Result := Pos(Substr, S)
  else
    Result := AnsiPos(Substr, S);
end;

{------------------------------------------------------------------------------}
function RPos(const ASub, AIn: String; AStart: Integer = -1): Integer;
var
  i: Integer;
  LStartPos: Integer;
  LTokenLen: Integer;
begin
  result := 0;
  LTokenLen := Length(ASub);
  // Get starting position
  if AStart = -1 then begin
    AStart := Length(AIn);
  end;
  if AStart < (Length(AIn) - LTokenLen + 1) then begin
    LStartPos := AStart;
  end else begin
    LStartPos := (Length(AIn) - LTokenLen + 1);
  end;
  // Search for the string
  for i := LStartPos downto 1 do begin
    if SameText(Copy(AIn, i, LTokenLen), ASub) then begin
      result := i;
      break;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function Fetch(var AInput: string; const ADelim: string; const ADelete: Boolean): String;
var
  LPos: integer;
begin
  if ADelim = #0 then begin
    // AnsiPos does not work with #0
    LPos := Pos(ADelim, AInput);
  end else begin
    LPos := i_Pos(ADelim, AInput);
  end;
  if LPos = 0 then begin
    Result := AInput;
    if ADelete then begin
      AInput := '';    {Do not Localize}
    end;
  end
  else begin
    Result := Copy(AInput, 1, LPos - 1);
    if ADelete then begin
      //slower Delete(AInput, 1, LPos + Length(ADelim) - 1);
      AInput:=Copy(AInput, LPos + Length(ADelim), MaxInt);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure LMDParseURI(const URI: string; var Protocol, Host, path, Document, Params,
  Port, Bookmark: string);
var
  UserName, Password: string;
begin
  LMDParseURI(URI, Protocol, Host, Path, Document, Port,
        Bookmark, UserName, Password, Params);
end;

{------------------------------------------------------------------------------}
procedure LMDParseURI(const AURI: string; var VProtocol, VHost, VPath, VDocument,
      VPort, VBookmark, VUserName, VPassword, VParams: string); 
var
  LBuffer: string;
  iTokenPos, iParamsPos: Integer;
  LURI: string;
begin
  LURI := AURI;
  TLMDURI.NormalizePath(LURI);
  VHost := '';
  VProtocol := '';
  VPath := '';
  VDocument := '';
  VPort := '';
  VBookmark := '';
  VUsername := '';
  VPassword := '';
  VParams := '';

  iTokenPos := i_Pos('://', LURI);
  if iTokenPos > 0 then
    begin
      VProtocol := Copy(LURI, 1, iTokenPos  - 1);
      Delete(LURI, 1, iTokenPos + 2);
      LBuffer := Fetch(LURI, '/', True);
      // Get username and password
      iTokenPos := i_Pos('@', LBuffer);
      VPassword := Copy(LBuffer, 1, iTokenPos  - 1);
      if iTokenPos > 0 then
        Delete(LBuffer, 1, iTokenPos);
      VUserName := Fetch(VPassword, ':', True);
      if Length(VUserName) = 0 then
        VPassword := '';

      VHost := Fetch(LBuffer, ':', True);
      VPort := LBuffer;
      // Get the path
      iParamsPos := i_Pos('?', LURI);

      if iParamsPos > 0 then
        iTokenPos := RPos('/', LURI, iParamsPos)
      else
        begin
          iParamsPos := i_Pos('=', LURI);
          if iParamsPos > 0 then
            iTokenPos := RPos('/', LURI, iParamsPos)
          else
            iTokenPos := RPos('/', LURI, -1);
        end;

      VPath := '/' + Copy(LURI, 1, iTokenPos);

      if iParamsPos > 0 then
        begin
          VDocument := Copy(LURI, 1, iParamsPos - 1);
          Delete(LURI, 1, iParamsPos - 1);
          VParams := LURI;
        end
      else
        VDocument := LURI;

      Delete(VDocument, 1, iTokenPos);
      VBookmark := VDocument;
      VDocument := Fetch(VBookmark, '#', True);
    end
  else
    begin
      // received an absolute path, not an URI
      iParamsPos := i_Pos('?', LURI);
      if iParamsPos > 0 then
        iTokenPos := RPos('/', LURI, iParamsPos)
      else
        begin
          iParamsPos := i_Pos('=', LURI);
          if iParamsPos > 0 then
            iTokenPos := RPos('/', LURI, iParamsPos)
          else
            iTokenPos := RPos('/', LURI, -1);
        end;

      VPath := Copy(LURI, 1, iTokenPos);
      // Get the document
      if iParamsPos > 0 then
        begin
          VDocument := Copy(LURI, 1, iParamsPos - 1);
          Delete(LURI, 1, iParamsPos - 1);
          VParams := LURI;
        end
      else
        VDocument := LURI;

      Delete(VDocument, 1, iTokenPos);
    end;

  // Parse the # bookmark from the document
  if Length(VBookmark) = 0 then
    begin
      VBookmark := VParams;
      VParams := Fetch(VBookmark, '#', True);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDParseURI(const URI: string; var Protocol, Host, path, Document,
  Port, Bookmark: string);
var
  szParams: string;
begin
  LMDParseURI(URI, Protocol, Host, path, Document, szParams, Port, Bookmark);
  Document:= Document + szParams;
end;

function  CombineURL(const szBaseURL,szRelativeURL:String):String;
const
  Buf_Size = 1024;
var

  Buffer: array[1..Buf_Size] of char;

  iCount: DWORD;
begin
  Result := szRelativeURL;
  iCount:= Buf_Size;

  if InternetCombineUrl(int_Ref(szBaseURL), int_Ref(szRelativeURL), @Buffer[1], iCount,
    ICU_BROWSER_MODE or ICU_NO_META) then
    begin
      Result:= StrPas(PChar(@Buffer[1]));

      //Fix Microsoft BUG
      if UpperCase(Copy(Result,1,9))='FILE://\\' then
        Result := 'file://'+Copy(Result,10,Length(Result)-9);
      Result:= LMDWebDeleteBackSlash(Result);
    end;
end;

{ ************************** TLMDInternetOptions **************************** }
{-----------------------------------------------------------------------------}
procedure TLMDInternetOptions.Assign(Source: TPersistent);
begin
  if Source is TLMDInternetOptions then
    begin
      with TLMDInternetOptions(Source) do
        begin
          Self.ConnectRetries:= ConnectRetries;
          Self.ConnectTimeout:= ConnectTimeout;
          Self.DataTimeout:= DataTimeout;
          Self.UseProxy:= UseProxy;
          Self.ProxyName:= ProxyName;
          Self.ProxyPort:= ProxyPort;
          Self.UseProxyAuth:= UseProxyAuth;
          Self.ProxyUserName:= ProxyUserName;
          Self.ProxyPassword:= ProxyPassword;
          Self.UserAgent:= UserAgent;
          Self.FModemConnection:= FModemConnection;
          Self.FUseDefaultOptions:= FUseDefaultOptions;
          Self.FAutoDial:= FAutoDial;
          Self.FAutoClose := FAutoClose;
          Self.FUseIEDUNSettings:= FUseIEDUNSettings;
          Self.FDUN:= FDUN;
          Self.FUseDefaultBows:= FUseDefaultBows;
          Self.ForceInternetCheck:= ForceInternetCheck;
          Self.FOnInteractiveEvent := FOnInteractiveEvent;
        end;
    end
  else
    inherited;
end;

{-----------------------------------------------------------------------------}
constructor TLMDInternetOptions.Create;
begin
  inherited Create;
  FUseProxy:= False;
  FDataTimeout:= 0;
  FConnectTimeOut:= 30;
  FConnectRetries:= 2;
  FUserAgent:= 'Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)';
  FUseDefaultOptions:= False;
  FServerThreads:= 4;
  FPathList:= TStringList.Create;
  FUseDefaultBows:= True;
  FUseIEDUNSettings:= True;
  FForceInternetCheck:= False;
end;

{-----------------------------------------------------------------------------}
destructor TLMDInternetOptions.Destroy;
begin
  FPathList.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}
procedure TLMDInternetOptions.SetAutoDial(const Value: boolean);
begin
  FAutoDial:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDInternetOptions.SetAutoClose(const Value: boolean);
begin
  FAutoClose := Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDInternetOptions.SetDUN(const Value: string);
begin
  FDUN:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDInternetOptions.SetForceInternetCheck(const Value: boolean);
begin
  FForceInternetCheck:= Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDInternetOptions.SetOnInteractiveEvent(const Value: TLMDInternetOptionsInteractiveEvent);
begin
  FOnInteractiveEvent := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDInternetOptions.SetPathList(const Value: TStringList);
begin
  FPathList.Assign(Value);
end;

{-----------------------------------------------------------------------------}
procedure TLMDInternetOptions.SetSocksProxy(const Value: boolean);
begin
  FSocksProxy:= Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDInternetOptions.SetSocksVersion(const Value: TLMDSocksVersion);
begin
  FSocksVersion:= Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDInternetOptions.SetUseDefaultBows(const Value: boolean);
begin
  FUseDefaultBows:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDInternetOptions.SetUseDefaultOptions(const Value: boolean);
begin
  FUseDefaultOptions:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDInternetOptions.SetUseIEDUNSettings(const Value: boolean);
begin
  FUseIEDUNSettings:= Value;
end;
//--------------------------------------------------

{-----------------------------------------------------------------------------}
function ExtractURLFileName(const FileName: string): string;
var
  i: integer;
begin
  i:= LastDelimiter('/\:', FileName);
  Result:= Copy(FileName, i + 1, MaxInt);
end;

{-----------------------------------------------------------------------------}
function ExtractURLRelativePath(const BaseName, DestName: string): string;

  function ExtractFilePathNoDrive(const FileName: string): string;
  begin
    Result:= ExtractFilePath(FileName);
    Result:= Copy(Result, Length(ExtractFileDrive(FileName)) + 1, MAXINT);
  end;

  procedure SplitDirs(const path: string; Dirs: TStrings);
  var
    i, j: integer;
  begin
    j:= 1;

    for i := 1 to Length(Path) do
      if AnsiChar(path[i]) in ['\', '/'] then { Do not localize }
        begin
          Dirs.Add(Copy(Path, j, i - j {- 1})); //VB Feb 2006
          j := i + 1;
        end;
  end;

var
  BasePath, DestPath: string;
  BaseDirs, DestDirs: TStrings;
  i, J: integer;
begin
  if  SameText(GetHost(BaseName), GetHost(DestName)) then
    begin
      BasePath:= GetPath(BaseName);
      if AnsiChar(BasePath[Length(BasePath)]) in ['/', '\'] then
        BasePath:= ExtractURLFilePath(BasePath);
      DestPath:= GetPath(DestName);

      BaseDirs := TStringList.Create;
      DestDirs := TStringList.Create;

      try
      SplitDirs(BasePath, BaseDirs);
      SplitDirs(DestPath, DestDirs);
      i:= 0;
      while (i < BaseDirs.Count) and (i < DestDirs.Count) do
        begin
          if SameText(BaseDirs[i], DestDirs[i]) then
            Inc(i)
          else
            break;
        end;
      Result:= '';
      if i <= (BaseDirs.Count - 1) then
        begin
          Result:= GetPath(DestName);
        end
      else
        begin
          for J:= i to BaseDirs.Count - 1 do
            Result:= Result + '../'; { Do not localize }
          for J:= i to DestDirs.Count - 1 do
            Result:= Result + DestDirs[J] + '/'; { Do not localize }
          Result:= Result + ExtractURLFileName(DestName);
        end;
      finally
        BaseDirs.Free;
        DestDirs.Free;
      end;
    end
  else
    Result:= DestName;
end;

{-----------------------------------------------------------------------------}
function CheckInet(IO: TLMDInternetOptions): boolean;
var
  b : boolean;
begin
  Result:= IO.ForceInternetCheck or CheckInetConnected(IO.FModemConnection);

  if (not Result) and (IO.AutoDial) then
    begin
      b := true;
      if Assigned(IO.FOnInteractiveEvent) then
        Result := IO.FOnInteractiveEvent(IO,IA_DIAL_QUERY)=IR_YES;
      if b then
      begin
        RASConnect(IO);
        Result:= CheckInetConnected(IO.FModemConnection);
      end;
    end;
end;

{-----------------------------------------------------------------------------}
procedure SetDisconnect(IO: TLMDInternetOptions);
begin
  if IO.ModemConnection and IO.AutoDial and IO.AutoClose then RASDisconnect;
end;

{-----------------------------------------------------------------------------}
function ExtractURLFilePath(const FileName: string): string;
var
  i: integer;
begin
  i:= LastDelimiter('\/:', FileName);
  Result:= Copy(FileName, 1, i);
end;

{------------------------------------------------------------------------------}
procedure LMDWebAllocTURLComponents(var uComp: TURLComponents; dwFlags: DWORD);

  procedure int_Alloc(var Str: PChar; Length: integer);
  begin
    if  Length > 0  then
      GetMem(Str, Length)
    else
      Str := nil;
  end;

begin

  uComp.dwStructSize:= sizeof(uComp);

  if  dwFlags <> 0  then
    begin
      int_Alloc(uComp.lpszScheme, uComp.dwSchemeLength);
      int_Alloc(uComp.lpszHostName, uComp.dwHostNameLength);
      int_Alloc(uComp.lpszUserName, uComp.dwUserNameLength);
      int_Alloc(uComp.lpszPassword, uComp.dwPasswordLength);
      int_Alloc(uComp.lpszUrlPath, uComp.dwUrlPathLength);
      int_Alloc(uComp.lpszExtraInfo, uComp.dwExtraInfoLength);
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDWebFreeTURLComponents(var uComp: TURLComponents; dwFlags: DWORD);

  procedure int_Free(var Str: PChar);
  begin
    if  Assigned(Str) then
      FreeMem(Str);

    Str := nil;
  end;

begin
  if  dwFlags <> 0  then
    begin
      int_Free(uComp.lpszScheme);
      int_Free(uComp.lpszHostName);
      int_Free(uComp.lpszUserName);
      int_Free(uComp.lpszPassword);
      int_Free(uComp.lpszUrlPath);
      int_Free(uComp.lpszExtraInfo);
    end;
end;

{------------------------------------------------------------------------------}
function  CallInternetCrackUrl(const URL: string; dwFlags: DWORD;
    var Scheme, HostName, UserName, Password, UrlPath,
    ExtraInfo: Ansistring; var nPort: INTERNET_PORT): BOOL;
var
  U: TURLComponents;
begin
  LMDWebClearData(U, sizeof(U), 0);
  U.dwSchemeLength := 20;
  U.dwHostNameLength := 100;
  U.dwUserNameLength := 32;
  U.dwPasswordLength := 32;
  U.dwUrlPathLength := 400;
  U.dwExtraInfoLength := 400;

  LMDWebAllocTURLComponents(U, dwFlags);

  try
    Result := InternetCrackURL(Int_Ref(URL), Length(URL), dwFlags, U);
    Scheme := AnsiString(LMDWebBufToStr(U.lpszScheme, U.dwSchemeLength));
    HostName := AnsiString(LMDWebBufToStr(U.lpszHostName, U.dwHostNameLength));
    UserName := AnsiString(LMDWebBufToStr(U.lpszUserName, U.dwUserNameLength));
    Password := AnsiString(LMDWebBufToStr(U.lpszPassword, U.dwPasswordLength));
    UrlPath := AnsiString(LMDWebBufToStr(U.lpszUrlPath, U.dwUrlPathLength));
    ExtraInfo := AnsiString(LMDWebBufToStr(U.lpszExtraInfo, U.dwExtraInfoLength));
    nPort := U.nPort;
  finally
    LMDWebFreeTURLComponents(U, dwFlags);
  end;
end;

function  CallInternetCrackUrl(const URL: string; dwFlags: DWORD;
    var Scheme, HostName: string; var nPort: INTERNET_PORT): BOOL; overload;
var
  U: TURLComponents;
begin
  LMDWebClearData(U, sizeof(U), 0);
  U.dwSchemeLength := 20;
  U.dwHostNameLength := 100;
  LMDWebAllocTURLComponents(U, dwFlags);

  try
    Result := InternetCrackURL(Int_Ref(URL), Length(URL), dwFlags, U);
    Scheme := LMDWebBufToStr(U.lpszScheme, U.dwSchemeLength);
    HostName := LMDWebBufToStr(U.lpszHostName, U.dwHostNameLength);
    nPort := U.nPort;
  finally
    LMDWebFreeTURLComponents(U, dwFlags);
  end;
end;

initialization
  begin
    hWININET:= LoadLibrary(WinInetLib);
    if hWININET <> 0 then
      begin
        InternetGetConnectedStateProc:= GetProcAddress(hWININET, 'InternetGetConnectedState');
       end;
  end;

finalization
  if hWININET <> 0 then
    FreeLibrary(hWININET);
end.
