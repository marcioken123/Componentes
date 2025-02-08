unit LMDDownload;
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

LMDDownload unit (DD)
--------------------
Download object

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SyncObjs, Variants, WinInet,
  LMDSyncUnit, LMDURLSupp, LMDWebBase;

const
  BUF_SIZE = 1024;

  RT_APPLICATION = 'application/octet-stream';
  RT_HTML = 'text/html';

  MIN_SENDTIME = 500;

  LE_INFO = 0;
  LE_ERROR = 1;

type
  TLMDDownloadState = (DS_NONE, DS_PROCESSING, DS_PROCESSED, DS_ERROR,
    DS_PREPARED);
  TLMDIVerb = (IV_GET, IV_POST);

  TLMDDownloadItem = class;
  TLMDDownloads = class;
  TLMDDownloadProgress = procedure(Sender: TLMDDownloadItem) of object;
  TLMDDownloadProcessed = procedure(Sender: TLMDDownloads) of object;
  TLMDDownloadLogEvent = procedure(Sender: TLMDDownloadItem; iEvent: Integer;
    szDescription, szData: string) of object;

  { ******************************* TLMDProcessThread **************************** }
  TLMDProcessThread = class(TThread)
  private
    FDownloads: TLMDDownloads;
  protected
    procedure Execute; override;
  public
    constructor Create(Downloads: TLMDDownloads);
    destructor Destroy; override;
  end;

  { ******************************* TLMDCookiesList **************************** }
  TLMDCookiesList = class(TStringList)
  public
    procedure AddText(const szText: string);
  end;

  { ******************************* TLMDDownloadItem **************************** }
  TLMDDownloadItem = class(TCollectionItem)
  private
    FSem: THandle;
    hInet: HINTERNET;
    hSession: HINTERNET;
    FURL: string;
    FError: DWORD;
    FProgress: Integer;
    FErrorString: string;
    FState: TLMDDownloadState;
    FDataSize: DWORD;
    FResultType: string;
    FActualType: string;
    FTag: Integer;
    FStringData: string;
    FUserData: TObject;
    FPostData: Variant;
    FHeaders: string;
    FVerb: TLMDIVerb;
    FUserName: string;
    FUserPassword: string;
    FCheckOnly: Boolean;
    FReady: Boolean;
    FInternetOptions: TLMDInternetOptions;
    FCaption: string;
    FReload: Boolean;
    FLastModified: TDateTime;
    FExcludedTypes: TStringList;
    FSetCookies: TLMDCookiesList;
    FGetCookies: TLMDCookiesList;
    FLocalURL: string;
    FUserObject: TObject;
    FReferer: string;
    FFreeOnProcessed: Boolean;
    FActualURL: string;
    FDeleteExCookies: Boolean;
    FHeaderLoaded: Boolean;
    FNoRedirect: Boolean;

    FRangeStart: Int64;
    FRangeEnd: Int64;
    function GetProgressString: string;
    function GetStatusString: string;
    procedure SetUserName(const Value: string);
    procedure SetUserPassword(const Value: string);
    procedure SetCheckOnly(const Value: Boolean);
    procedure SetReady(const Value: Boolean);
    procedure SeTLMDInternetOptions(const Value: TLMDInternetOptions);
    function GetCaption: string;
    procedure SetReload(const Value: Boolean);
    procedure SetExcludedTypes(const Value: TStringList);
    procedure SetUserData(const Value: TObject);
    procedure SetLocalURL(const Value: string);
    procedure SetUserObject(const Value: TObject);
    procedure SetSetCookies(const Value: TLMDCookiesList);
    procedure SetGetCookies(const Value: TLMDCookiesList);
    procedure SetDeleteExCookies(const Value: Boolean);
    procedure SetHeaderLoaded(const Value: Boolean);
    procedure SetNoRedirect(const Value: Boolean);
  public
    DataStream: TMemoryStream;
    // EM change begin
    PersistStream : TStream;
    // EM change end
    iStatusCode: Integer;
    Terminated: Boolean;
    LickedID: Integer;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    // Prepare request. Don't use it
    procedure Prepare;
    // Process request. Don't use it
    procedure Process;
    // Terminate request
    procedure Terminate;
    // Reset downloaded data and free memory
    procedure ResetData;
    procedure Log(iEvent: Integer; szDescription, szData: string);
    procedure SetError(iError: Integer; ErrorString: string);
    function  BufferStartedWith(const Str: string; CheckCase: Boolean = True): Boolean;
    // Item caption for dialogs
    property Caption: string read GetCaption write FCaption;
    // Accepted result types divided by #13#10. if result type is empty then accept any result type
    property ResultType: string read FResultType write FResultType;
    // Actual result type
    property ActualType: string read FActualType write FActualType;
    // Actual URL. Supported only on redirection responses
    property ActualURL: string read FActualURL write FActualURL;
    // Item URL
    property URL: string read FURL write FURL;
    property LocalURL: string read FLocalURL write SetLocalURL;
    property Tag: Integer read FTag write FTag;
    property UserData: TObject read FUserData write SetUserData;
    // User Object. Item free it.
    property UserObject: TObject read FUserObject write SetUserObject;
    property StringData: string read FStringData write FStringData;
    // Downloaded data
//    property Data: Pointer read GetData;
    // Downloaded data size
    property DataSize: DWORD read FDataSize;
    property LastModified: TDateTime read FLastModified;
    // Error
    property dwError: DWORD read FError write FError;
    // Error String
    property ErrorString: string read FErrorString write FErrorString;
    // Current progress
    property Progress: Integer read FProgress write FProgress;
    // Current State
    property State: TLMDDownloadState read FState;
    property ProgressString: string read GetProgressString;
    property StatusString: string read GetStatusString;
    // Post parameters. String or array of bytes
    property PostData: Variant read FPostData write FPostData;
    // Ext headers
    property Headers: string read FHeaders write FHeaders;
    // Cookies to set
    property SetCookies: TLMDCookiesList read FSetCookies write SetSetCookies;
    // Response cookies
    property GetCookies: TLMDCookiesList read FGetCookies write SetGetCookies;
    property Referer: string read FReferer write FReferer;
    property Verb: TLMDIVerb read FVerb write FVerb;
    property UserName: string read FUserName write SetUserName;
    property UserPassword: string read FUserPassword write SetUserPassword;
    // Check only. Don't download item
    property CheckOnly: Boolean read FCheckOnly write SetCheckOnly;
    property Ready: Boolean read FReady write SetReady;
    // Reload item...not from cache. Only for WinInet version
    property Reload: Boolean read FReload write SetReload;
    // Flag for event handler to process headers and terminate process if needed
    property HeaderLoaded: Boolean read FHeaderLoaded write SetHeaderLoaded;
    // Delete response cookies parameters
    property DeleteExCookies: Boolean read FDeleteExCookies write
      SetDeleteExCookies;
    property InternetOptions: TLMDInternetOptions read FInternetOptions write
      SetLMDInternetOptions;
    // Excluded types
    property ExcludedTypes: TStringList read FExcludedTypes write
      SetExcludedTypes;
    // Free item after download
    property FreeOnProcessed: Boolean read FFreeOnProcessed write
      FFreeOnProcessed;
    // No automatic redirect and return redirect information
    property NoRedirect: Boolean read FNoRedirect write SetNoRedirect;

    property RangeStart: Int64 read FRangeStart write FRangeStart;
    property RangeEnd: Int64 read FRangeEnd write FRangeEnd;
  end;

  TLMDProcessDownloadThread = class;
(*$HPPEMIT 'class DELPHICLASS TLMDProcessDownloadThread;' *)
  TLMDProcessDownloadThreadArray = array of TLMDProcessDownloadThread;

  { ******************************* TLMDDownloads **************************** }

  TLMDDownloads = class(TCollection)
  private
    FStartTime: Longword;
    FAllSize: int64;
    FDelItems: TList;
    FProcessThread: TThread;
    FSem: THandle;
    FSemP: THandle;
    iServerIndex: Integer;
    FState: TLMDDownloadState;
    FServerThreads: Integer;
    FOnProcessed: TLMDDownloadProcessed;
    FOnProgress: TLMDDownloadProgress;
    FSyncObj: TLMDSyncObject;
    FProgressObj: TLMDDownloadItem;
    aT: TLMDProcessDownloadThreadArray;
    FInternetOptions: TLMDInternetOptions;
    FOnLog: TLMDDownloadLogEvent;
    FReload: Boolean;
    function GetItems(index: Integer): TLMDDownloadItem;
    procedure SetOnProcessed(const Value: TLMDDownloadProcessed);
    procedure SetOnProgress(const Value: TLMDDownloadProgress);
    procedure SendProgress(Sender: TLMDDownloadItem; bNonCritical: Boolean =
      False);
    procedure Progress;
    procedure Processed;
    procedure SeTLMDInternetOptions(const Value: TLMDInternetOptions);
    procedure DeleteItem(Item: TLMDDownloadItem);
    function GetCPS: Integer;
    procedure SizeChanged(iSize: int64; lTime: Longword);
    procedure SetOnLog(const Value: TLMDDownloadLogEvent);
    procedure SetReload(const Value: Boolean);
  public
    Terminated: Boolean;
    constructor Create;
    destructor Destroy; override;
    // Process requests. Block thread
    function Process: Boolean;
    // Process request in threads...
    procedure ThreadProcess;
    function Add: TLMDDownloadItem;
    // Internal function
    function GetNextServer(Sender: TLMDProcessDownloadThread): TLMDDownloadItem;
    // Clear object state
    procedure ClearState;
    // Terminate requests
    procedure Terminate;
    // Wait for end threaded process
    procedure WaitForEnd;
    // Continue process. Used only in event handler if it add new download items
    procedure ContinueProcess;
    property Items[index: Integer]: TLMDDownloadItem read GetItems; default;
    property State: TLMDDownloadState read FState;
    property Reload: Boolean read FReload write SetReload;
    property InternetOptions: TLMDInternetOptions read FInternetOptions write
      SeTLMDInternetOptions;
    // Number of downloads threads
    property ServerThreads: Integer read FServerThreads write FServerThreads;
    property AllSize: int64 read FAllSize;
    property CPS: Integer read GetCPS;
    property OnProgress: TLMDDownloadProgress read FOnProgress write
      SetOnProgress;
    property OnProcessed: TLMDDownloadProcessed read FOnProcessed write
      SetOnProcessed;
    property OnLog: TLMDDownloadLogEvent read FOnLog write SetOnLog;
  end;

  { ******************************* TLMDProcessDownloadThread **************************** }
  TLMDProcessDownloadThread = class(TThread)
  private
    FDownloads: TLMDDownloads;
    FThreadTerminated: Boolean;
    FWaitEvent: TEvent;
  protected
    procedure Execute; override;
    procedure Process;
  public
    NullItem: Boolean;
    constructor Create(Downloads: TLMDDownloads);
    destructor  Destroy; override;
  end;

implementation

uses
  SysUtils, Math,
  {$ifdef LMDCOMP12}
  AnsiStrings,
  {$endif}
  LMDInetConst, LMDWebConst, LMDHTTPSupp, LMDStringsSupport, LMDProcs, LMDUnicode
  ;

{ ******************************* TLMDDownloadItem **************************** }
{-----------------------------------------------------------------------------}

constructor TLMDDownloadItem.Create(Collection: TCollection);
begin
  inherited;
  FSem:= CreateSemaphore(nil, 1, 1, '');
  FDeleteExCookies:= True;
  FFreeOnProcessed:= False;
  FExcludedTypes:= TStringList.Create;
  FSetCookies:= TLMDCookiesList.Create;
  FGetCookies:= TLMDCookiesList.Create;
  if(Collection<>nil) then
    FReload:= TLMDDownloads(Collection).FReload;
  FLastModified:= 0;
  hInet:= nil;
  hSession:= nil;
  DataStream:= TMemoryStream.Create;
  Terminated:= False;
  FProgress:= 0;
  FError:= 0;
  FErrorString:= '';
  FDataSize:= 0;
  FState:= DS_NONE;
  FResultType:= '';
  FActualType:= '';
  FVerb:= IV_GET;
  FUserName:= '';
  FUserPassword:= '';
  FHeaders:= '';
  FCheckOnly:= False;
  FReady:= False;
  FTag:= 0;
  FUserData:= nil;
  FUserObject:= nil;
  FNoRedirect:= False;
  FInternetOptions:= TLMDInternetOptions.Create;
end;

{-----------------------------------------------------------------------------}

destructor TLMDDownloadItem.Destroy;
begin
  FGetCookies.Free;
  FSetCookies.Free;
  if FUserObject <> nil then
    FUserObject.Free;
  FExcludedTypes.Free;
  FInternetOptions.Free;
  DataStream.Free;
  CloseHandle(FSem);
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDDownloadItem.GetCaption: string;
begin
  Result:= FCaption;
  if Result = '' then
    Result:= FURL;
end;

{-----------------------------------------------------------------------------}

function TLMDDownloadItem.GetProgressString: string;
begin
  Result:= '';
  case FState of
    DS_NONE: Result:= IDLE_NAME;
    DS_PROCESSING: Result:= IntToStr(Progress) + '%';
    DS_PROCESSED: Result:= COMPLITE_NAME;
    DS_ERROR: Result:= FErrorString;
  end;
end;

{-----------------------------------------------------------------------------}

function TLMDDownloadItem.GetStatusString: string;
begin
  Result:= '';
  case FState of
    DS_NONE: Result:= IDLE_NAME;
    DS_PROCESSING: Result:= PROCESS_NAME;
    DS_PROCESSED: Result:= COMPLITE_NAME;
    DS_ERROR: Result:= ERROR_NAME;
  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDDownloadItem.Prepare;
begin
  hInet:= nil;
  hSession:= nil;
  DataStream.Clear;
  FDataSize:= 0;
  Terminated:= False;
  FProgress:= 0;
  FError:= 0;
  FErrorString:= '';
  FState:= DS_NONE;
  FActualType:= '';
end;

{-----------------------------------------------------------------------------}

function d_InternetQueryOptionAsDWORD(hInet: HINTERNET; dwOption: DWORD;
  var lpBuffer: DWORD; var lpdwBufferLength: DWORD): BOOL; stdcall;
  external 'wininet.dll' name 'InternetQueryOptionA';

function InternetQueryOptionAsDWORD(hInet: HINTERNET; dwOption: DWORD;
    var lpBuffer: DWORD): BOOL;
var
  i: dword;
begin
  i := sizeof(lpBuffer);
  Result := d_InternetQueryOptionAsDWORD(hInet, dwOption, lpBuffer, i);
end;

{------------------------------------------------------------------------------}
procedure TLMDDownloadItem.Process;

  procedure GetError;
  var
    iCount: DWORD;

  begin
    if FState = DS_ERROR then
      exit;
    FError:= GetLastError;
    if (Terminated) and (FError = 0) then
      FError:= 6;
    FErrorString:= GetInternetError(dwError);
    if FError = ERROR_INTERNET_EXTENDED_ERROR then
      begin
        iCount:= 256;

        SetLength(FErrorString, iCount);
        if InternetGetLastResponseInfo(FError, int_Ref(FErrorString), iCount) then
          SetLength(FErrorString, iCount);

      end;
  end;

  function QueryInfo(hURL: HINTERNET; dwInfoLevel: DWORD; var Res: Ansistring): BOOL;
  var
    iRes: DWORD;
    iCount: DWORD;

{$IFDEF LMDCOMP12}
    LAnsiString: AnsiString;
{$ENDIF}
  begin
    Result := False;
    iRes:= 0;
    iCount:= BUF_SIZE;

  {$IFDEF LMDCOMP12}
    SetLength(LAnsiString, iCount);
    if HttpQueryInfoA(hURL, dwInfoLevel, int_RefA(LAnsiString), iCount, iRes) then
      begin
        try
          SetLength(LAnsiString, iCount);
          Res := LAnsiString;
          Result := True;
        except
        end;
      end
  {$ELSE}
    SetLength(Res, iCount);
    if HttpQueryInfoA(hURL, dwInfoLevel, int_Ref(Res), iCount, iRes) then
      begin
        try
          SetLength(Res, iCount);
          Result := True;
        except
        end;
      end
  {$ENDIF}
    else
      Res := '';

  end;

  function FtpFileTimeToDateTime(FileTime: TFileTime): TDateTime;
  var
    iFileTime: Integer;
    TheDate, TheTime: Word;
  begin
    FileTimeToDosDateTime(FileTime, TheDate, TheTime);
    iFileTime := MakeLong(TheTime, TheDate);
    try
      Result:= FileDateToDateTime(iFileTime);
    except
      Result:= 0;
    end;
  end;

var
  szTmp: Ansistring;
  b: Boolean;
  i: Integer;
  Flags: DWORD;
  hURL: HINTERNET;
  bytesRead: Cardinal;
  bResult: Boolean;
  szBuf: AnsiString;
  iSize: Longint;
  FBuf: TMemoryStream;
  iOldSize: DWORD;
  lTime: Longword;
  lTime1: Longword;
  szVerb: AnsiString;
  SchemeName, HostName: AnsiString;
  UserName, Password, UrlPath, ExtraInfo: AnsiString;
  nPort: INTERNET_PORT;
  pParams: PAnsiChar;
  iParams: Integer;
  szParams: AnsiString;
  dwHandleType: DWORD;
  FindData: TWin32FindDataA;
  hFtpFile: HINTERNET;
  szURL: Ansistring;
  tmpList: TStringList;
  hFile :Integer;
  OkSend: Boolean;
  Li: Integer;
  szBufRange: AnsiString;
begin
  if FState <> DS_NONE then
    begin
      exit;
    end;

  FHeaderLoaded:= False;
  Terminated:= False;
  FState:= DS_PROCESSING;
  if (not InternetOptions.ForceInternetCheck) and (not
    CheckInetConnected(InternetOptions.ModemConnection)) and (not CheckLocal(FURL))
    then
    begin
      FState:= DS_ERROR;
      FError:= DE_HTTP_ERROR;
      FErrorString:= NOT_CONNECTED_ERROR;
    end
  else
  try
    if (Collection <> nil) then
      TLMDDownloads(Collection).SendProgress(Self);
    if InternetOptions.UserAgent = '' then
      hInet:= InternetOpen('DW', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil,
        INTERNET_FLAG_MAKE_PERSISTENT)
    else
      hInet:= InternetOpen(int_Ref(InternetOptions.UserAgent),
        INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, INTERNET_FLAG_MAKE_PERSISTENT);
    iSize:= 0;
    FLastModified:= 0;
    if hInet <> nil then
      begin
        if not InternetOptions.UseDefaultOptions then
          SetConnectionOptions(hInet, InternetOptions);
        if (not InternetOptions.ForceInternetCheck) and (not
          CheckConnected(hInet, InternetOptions.ModemConnection)) and (not
          CheckLocal(FURL)) then
          begin
            FState:= DS_ERROR;
            FError:= DE_HTTP_ERROR;
            FErrorString:= NOT_CONNECTED_ERROR;
            InternetCloseHandle(hInet);
          end
        else
          try
            if pos('#', FURL) > 0 then
              FURL:= FURL;
            FGetCookies.Clear;
            hSession:= nil;
            hURL:= nil;
            CallInternetCrackUrl(FURL, 0, SchemeName, HostName,
                UserName, Password, UrlPath, ExtraInfo, nPort);

            UrlPath := UrlPath + ExtraInfo;

            if SameText(String(SchemeName), 'HTTP') or SameText(String(SchemeName), 'HTTPS') then
              begin
                szVerb:= '';
                case Verb of
                  IV_GET: szVerb:= 'GET';
                  IV_POST: szVerb:= 'POST';
                end;
                hSession:= nil;
                if not Terminated then
                  hSession:= InternetConnectA(hInet, int_Ref(HostName),
                      nPort, int_Ref(AnsiString(FUserName)), int_Ref(AnsiString(FUserPassword)),
                      INTERNET_SERVICE_HTTP, 0, 0);
                if hSession <> nil then
                  begin
                    SetProxyAuthOptions(hSession, InternetOptions);
                    hURL:= nil;
                    Flags:= INTERNET_FLAG_KEEP_CONNECTION;
                    if FReload then
                      Flags:= Flags or INTERNET_FLAG_RELOAD or
                        INTERNET_FLAG_PRAGMA_NOCACHE;
                    if FNoRedirect then
                      Flags:= Flags or INTERNET_FLAG_NO_AUTO_REDIRECT;
                    if FReferer <> '' then
                      szTmp:= AnsiString(FReferer)
                    else
                      szTmp:= AnsiString(UrlPath);
                    szURL:= UrlPath;
                    if pos('#', String(szURL)) > 0 then
                      szURL:= Copy(szURL, 1, pos('#', String(szURL)) - 1);
                    if not Terminated then
                      hURL:= HttpOpenRequestA(hSession, int_RefA(szVerb),
                        int_RefA(szURL), '', int_RefA(szTmp), nil,
                        Flags, 0);
                      szParams:= '';
                    case VarType(FPostData) of

                      varOleStr,

{$ifdef LMDCOMP12}
                      varUString,
{$endif ifndef LMDCOMP12}

                        varString:
                        begin
                          szParams:= AnsiString(FPostData);
                        end;

                      (varArray or varByte):
                        begin

                          VarArrayLock(FPostData);
                          iParams:= VarArrayHighBound(FPostData, 1) -
                            VarArrayLowBound(FPostData, 1) + 1;
                          SetLength(szParams, iParams);
                          Move(VarArrayLock(FPostData)^, szParams[1], iParams);
                          VarArrayUnLock(FPostData);
//                          pParams:= PChar(szParams);

                        end;
                    end;
                    if FSetCookies.Count > 0 then
                      begin
                        szBuf:= 'Cookie: ';
                        b:= False;
                        for i:= 0 to FSetCookies.Count - 1 do
                          begin
                            if (FSetCookies.Names[i] <> 'expires') and
                              (FSetCookies.Names[i] <> 'path') then
                              begin
                                if b then
                                  szBuf:= szBuf + '; '
                                else
                                  b:= True;
                                szBuf:= szBuf + AnsiString(FSetCookies[i]);
                              end;
                          end;
                        HttpAddRequestHeadersA(hURL, int_Ref(AnsiString(szBuf)), Length(szBuf),
                          HTTP_ADDREQ_FLAG_ADD);
                      end;
                    if not Terminated and (szParams <> '') then
                    begin
                      szBuf:= 'CONTENT-TYPE:application/x-www-form-urlencoded';
                      HttpAddRequestHeadersA(hURL, int_Ref(AnsiString(szBuf)), Length(szBuf),
                        HTTP_ADDREQ_FLAG_ADD);
                    end;

//                    if FRangeStart + FRangeEnd > 0 then
                    begin
                      if FRangeEnd > FRangeStart then
                        szBufRange := AnsiString(Format('Range: bytes=%d-%d', [FRangeStart, FRangeEnd]))
                      else
                        if FRangeEnd < 0 then
                          szBufRange := AnsiString(Format('Range: bytes=-%d', [Abs(FRangeEnd)]))
                        else
                          szBufRange := AnsiString(Format('Range: bytes=%d-', [FRangeStart]));
                      HttpAddRequestHeadersA(hURL, int_Ref(AnsiString(szBufRange)), Length(szBufRange),
                        HTTP_ADDREQ_FLAG_ADD_IF_NEW);
                    end;

                    OkSend := False;

                    if not Terminated then
                      begin
                        pParams := int_RefA(szParams);
                        try
                          iParams := Length(szParams);
                          OkSend := HttpSendRequest(hURL, int_Ref(FHeaders),
                                Length(FHeaders), pParams, iParams);
                        finally
                          {$IFDEF LMDCOMP12}
                          // TODO: int_Free([pParams]);
                          {$ELSE}
                          int_Free([pParams]);
                          {$ENDIF}
                        end;
                      end;

                    if Terminated or not OkSend then
                      begin
                        GetError;
                        InternetCloseHandle(hURL);
                        hURL:= nil;
                        FState:= DS_ERROR;
                      end;
                  end;
              end
            else
              if SameText(String(SchemeName), 'FTP') then
                begin
                  hSession:= nil;
                  if not Terminated then
                    hSession:= InternetConnectA(hInet, int_Ref(HostName),
                      nPort, int_Ref(AnsiString(FUserName)), int_Ref(AnsiString(FUserPassword)),
                      INTERNET_SERVICE_FTP, 0, 0);

                  if hSession <> nil then
                    begin
                      hFtpFile:= FtpFindFirstFileA(hSession, int_Ref(UrlPath), FindData,
                        INTERNET_FLAG_RELOAD, 0);
                      if hFtpFile <> nil then
                        begin
                          FLastModified:=
                            FtpFileTimeToDateTime(FindData.ftLastWriteTime);
                          iSize:= FindData.nFileSizeHigh * MAXDWORD +
                            FindData.nFileSizeLow;
                          InternetCloseHandle(hFtpFile);
                        end
                      else
                        if CheckOnly then
                          begin
                            GetError;
                            FState:= DS_ERROR;
                          end;
                      if FState <> DS_ERROR then
                        hURL:= FtpOpenFileA(hSession, int_Ref(UrlPath), GENERIC_READ,
                          FTP_TRANSFER_TYPE_BINARY or INTERNET_FLAG_RELOAD, 0);
                    end;
                end
              else
                if not Terminated then
                  hURL:= InternetOpenUrl(hInet, int_Ref(FURL), nil, 0,
                      INTERNET_FLAG_EXISTING_CONNECT , 0);
//                    {INTERNET_FLAG_EXISTING_CONNECT or } INTERNET_FLAG_MAKE_PERSISTENT or
//                      INTERNET_FLAG_NEED_FILE, 0);
            if (hURL <> nil) and (FState <> DS_ERROR) then
              begin
                try
                  if InternetQueryOptionAsDWORD(hURL, INTERNET_OPTION_HANDLE_TYPE,
                        dwHandleType) then
                    begin
                      case dwHandleType of
                        14: //  INTERNET_HANDLE_TYPE_INTERNET
                          begin
                            if SameText(String(SchemeName), 'FILE') then
                            begin
                              szTmp := UrlPath;
                              if Copy(szTmp,1,2)='\\' then
                                szTmp := Copy(szTmp, 3, MAXINT);
                              if pos(':', String(szTmp))>0 then
                                if AnsiChar(szTmp[1]) in ['/','\'] then
                                  szTmp := Copy(szTmp, 2, MAXINT);
                              szTmp := ExpandFileName(szTmp);
                              hFile := FileOpen(String(szTmp), fmShareDenyNone or fmOpenRead);

                              if hFile >= 0 then
                              begin
                                FDataSize := FileSeek(hFile, 0, 2);
                                FLastModified :=  FileDateToDateTime(FileGetDate(hFile));
                                FileClose(hFile);
                              end;
                            end;
                          end;
                        INTERNET_HANDLE_TYPE_HTTP_REQUEST:
                          begin
                            QueryInfo(hURL, HTTP_QUERY_STATUS_CODE, szBuf);
                            if szBuf <> '' then
                              begin
                                try
                                  iStatusCode:= StrToInt(String(szBuf));
                                except
                                  iStatusCode:= 0;
                                end;
                                if (iStatusCode <> 200) and (iStatusCode <> 302) and (iStatusCode <> 206)
                                  then
                                  begin
                                    FError:= DE_HTTP_ERROR;
                                    FErrorString:= GetHTTPError(iStatusCode);
                                    FState:= DS_ERROR;
                                  end;
                              end;

                            QueryInfo(hURL, HTTP_QUERY_LOCATION, szBuf);
                            FActualURL:= String(szBuf);
                            if FActualURL='' then
                              FActualURL := FURL;

                            QueryInfo(hURL, HTTP_QUERY_CONTENT_TYPE, szBuf);
                            FActualType:= Trim(String(szBuf));
                            b := True;
                            if (FActualType <> '') then
                              begin
                                if FResultType <> '' then
                                  begin
                                    tmpList:= TStringList.Create;
                                    tmpList.Text:= FResultType;
                                    try
                                      for Li := 0 to tmpList.Count - 1 do
                                         if LMDWidePos(tmpList.Strings[Li], FActualType) > 0 then
                                         begin
                                           b := true;
                                           break;
                                         end
                                         else
                                          b := false;
                                      // b := (tmpList.IndexOf(FActualType) >= 0);
                                    finally
                                      tmpList.Free;
                                    end;
                                  end;

                                if  b and Assigned(FExcludedTypes)  then
                                  begin
                                    for Li := 0 to FExcludedTypes.Count - 1 do
                                      if LMDWidePos(FExcludedTypes.Strings[Li], FActualType) > 0 then
                                      begin
                                        b := false;
                                        break;
                                      end
                                      else
                                        b := true;
                                    // b := (FExcludedTypes.IndexOf(FActualType) < 0);
                                  end;
                              end;

                            if  not b then
                              begin
                                FState:= DS_ERROR;
                                FError:= HTTP_STATUS_PRECOND_FAILED;
                                FErrorString:= SHTTP_ERROR_HTTP_STATUS_PRECOND_FAILED;
                              end;

                            QueryInfo(hURL, HTTP_QUERY_RAW_HEADERS, szTmp);
                            ExtractSetCookies(String(szTmp), FGetCookies, DeleteExCookies);

                            QueryInfo(hURL, HTTP_QUERY_CONTENT_LENGTH, szBuf);
                            if szBuf <> '' then
                              begin
                                try
                                  iSize:= StrToInt(String(szBuf));
                                except
                                end;
                              end;

                            QueryInfo(hURL, HTTP_QUERY_LAST_MODIFIED, szBuf);
                            if szBuf <> '' then
                              begin
                                try
                                  FLastModified:= ParseDate(String(szBuf));
                                except
                                end;
                              end;
                          end;
                        INTERNET_HANDLE_TYPE_FTP_FILE:
                          begin
                          end;
                      end;
                    end;
                  if FState <> DS_ERROR then
                    begin
                      FDataSize:= iSize;
                      FHeaderLoaded:= True;
                      if (Collection <> nil) then
                        TLMDDownloads(Collection).SendProgress(Self);

                      FHeaderLoaded:= False;
                      if not FCheckOnly then
                        FDataSize:= 0;
                      if (not FCheckOnly) and (not Terminated) then
                        begin
                          FBuf := TMemoryStream.Create;
                          lTime:= 0;
                          try
                            FBuf.Size := BUF_SIZE * 16;
                            lTime1:= GetTickCount;
                            repeat
                              bResult:= InternetReadFile(hURL,
                                  FBuf.Memory, FBuf.Size, bytesRead);
                              if (bResult and (bytesRead <> 0)) then
                                begin
                                  iOldSize:= FDataSize;
                                  if Collection <> nil then
                                    TLMDDownloads(Collection).SizeChanged(bytesRead, (GetTickCount - lTime1));
                                  lTime1:= GetTickCount;
                                  FDataSize:= FDataSize + bytesRead;
                                  if iSize <> 0 then
                                    FProgress:= Round(FDataSize / iSize * 100);

                                  // EM change begin
                                  //FBuf.Position := 0;

                                  if PersistStream <> nil then
                                  begin
                                    PersistStream.Position := iOldSize;
                                    PersistStream.WriteBuffer(FBuf.Memory^, bytesRead);
                                    //PersistStream.CopyFrom(FBuf, bytesRead);
                                  end
                                  else
                                  begin
                                    DataStream.Position := iOldSize;
                                    //DataStream.CopyFrom(FBuf, bytesRead);
                                    DataStream.WriteBuffer(FBuf.Memory^, bytesRead);
                                  end;
                                  // EM change end
                                  if (not Terminated) and Assigned(Collection)
                                    and ((lTime - GetTickCount) > MIN_SENDTIME)
                                    then
                                    begin
                                      lTime:= GetTickCount;
                                      TLMDDownloads(Collection).SendProgress(Self, True);
                                    end;
                                end;
//                              Inc(iCount);
                            until (Terminated) or (bResult and (bytesRead = 0))
                              or (not bResult);
                            if not bResult then
                              begin
                                GetError;
                                if FError <> 0 then
                                  FState:= DS_ERROR;
                              end;
                            if (Terminated) and (FError = 0) then
                              GetError;
                          finally
                            FBuf.Free;
                          end;
                        end;
                    end;
                finally
                  if  Assigned(hURL)  then
                    InternetCloseHandle(hURL);
                end;
              end
            else
              begin
                GetError;
                FState:= DS_ERROR;
              end;
          finally
            if hSession <> nil then
              begin
                InternetCloseHandle(hSession);
                hSession:= nil;
              end;
            if hInet <> nil then
              begin
                InternetCloseHandle(hInet);
                hInet:= nil;
              end;
          end;
      end
    else
      begin
        GetError;
        FState:= DS_ERROR;
      end;
  except
    on E: Exception do
    begin
      FError:= SE_EXCEPTION;
      FErrorString:= E.Message;//Exception(ExceptObject).Message;
      FState:= DS_ERROR;
    end;
  end;
  if FState <> DS_ERROR then
    FState:= DS_PROCESSED;
  FProgress:= 100;
  if (not Terminated) and (Collection <> nil) then
    TLMDDownloads(Collection).SendProgress(Self);
  if FFreeOnProcessed then
    TLMDDownloads(Collection).DeleteItem(Self);
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.ResetData;
begin
  DataStream.Clear;
  FDataSize := 0;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetSetCookies(const Value: TLMDCookiesList);
begin
  FSetCookies.Assign(Value);
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetCheckOnly(const Value: Boolean);
begin
  FCheckOnly:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetExcludedTypes(const Value: TStringList);
begin
  FExcludedTypes.Assign(Value);
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetGetCookies(const Value: TLMDCookiesList);
begin
  FGetCookies.Assign(Value);
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SeTLMDInternetOptions(const Value:
  TLMDInternetOptions);
begin
  FInternetOptions.Assign(Value);
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetLocalURL(const Value: string);
begin
  FLocalURL:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetReady(const Value: Boolean);
begin
  FReady:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetReload(const Value: Boolean);
begin
  FReload:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetUserData(const Value: TObject);
begin
  FUserData:= Value;
end;

{-----------------------------------------------------------------------------}

procedure TLMDDownloadItem.SetUserName(const Value: string);
begin
  FUserName:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetUserObject(const Value: TObject);
begin
  if FUserObject = Value then
    exit;
  if FUserObject <> nil then
    FUserObject.Free;
  FUserObject:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetUserPassword(const Value: string);
begin
  FUserPassword:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.Terminate;
begin
  if FState = DS_PROCESSING then
    begin
      Terminated:= True;
      if hSession <> nil then
        begin
          InternetCloseHandle(hSession);
          hSession:= nil;
        end;
      if hInet <> nil then
        begin
          InternetCloseHandle(hInet);
          hInet:= nil;
        end;
    end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.Assign(Source: TPersistent);
begin
  if Source is TLMDDownloadItem then
    begin
      with TLMDDownloadItem(Source) do
        begin
          Self.Caption:= Caption;
          Self.ResultType:= ResultType;
          Self.ActualType:= ActualType;
          Self.URL:= URL;
          Self.LocalURL:= LocalURL;
          Self.Tag:= Tag;
          Self.UserData:= UserData;
          Self.UserObject:= UserObject;
          Self.StringData:= StringData;
          Self.PostData:= PostData;
          Self.Headers:= Headers;
          Self.SetCookies:= SetCookies;
          Self.GetCookies:= GetCookies;
          Self.Referer:= Referer;
          Self.Verb:= Verb;
          Self.UserName:= UserName;
          Self.UserPassword:= UserPassword;
          Self.CheckOnly:= CheckOnly;
          //      Self.Ready            :=  Ready;
          Self.Reload:= Reload;
          Self.NoRedirect:= NoRedirect;
          Self.InternetOptions.Assign(InternetOptions);
          Self.ExcludedTypes.Assign(ExcludedTypes);
          Self.FreeOnProcessed:= FreeOnProcessed;
        end;
    end
  else
    inherited;

end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetDeleteExCookies(const Value: Boolean);
begin
  FDeleteExCookies:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetHeaderLoaded(const Value: Boolean);
begin
  FHeaderLoaded:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetError(iError: Integer; ErrorString: string);
begin
  FErrorString:= ErrorString;
  dwError:= iError;
  FState:= DS_ERROR;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.SetNoRedirect(const Value: Boolean);
begin
  FNoRedirect:= Value;
end;

{-----------------------------------------------------------------------------}
function  TLMDDownloadItem.BufferStartedWith(const Str: string; CheckCase: Boolean = True): Boolean;
var
  L, P: integer;
  S: string;

  // EM change begin
  AStream : TStream;
  // EM change end
begin
  L := Length(Str);
  Result := False;

  // EM change begin
  if PersistStream <> nil then
    AStream := PersistStream
  else
    AStream := DataStream;

  if  Assigned(AStream) and (AStream.Size >= L)  then
    begin
      P := AStream.Position;
      AStream.Position := 0;

      SetLength(S, L);
      AStream.Read(S[1], L);

      AStream.Position := P;
  // EM change end

      if  CheckCase then
        Result := (Str = S)
      else
        Result := AnsiSameText(Str, S);
    end;
end;

{ ******************************* TLMDDownloads **************************** }
{-----------------------------------------------------------------------------}
function TLMDDownloads.Add: TLMDDownloadItem;
begin
  WaitForSingleObject(FSem, INFINITE);
  try
    Result:= TLMDDownloadItem(inherited Add);
  finally
    ReleaseSemaphore(FSem, 1, nil);
  end;
end;

{-----------------------------------------------------------------------------}
constructor TLMDDownloads.Create;
begin
  inherited Create(TLMDDownloadItem);
  FReload := False;
  FSem:= CreateSemaphore(nil, 1, 1, '');
  FSemP:= CreateSemaphore(nil, 1, 1, '');
  FInternetOptions:= TLMDInternetOptions.Create;
  iServerIndex:= -1;
  Terminated:= False;
  FState:= DS_NONE;
  FServerThreads:= 8;
  FOnProcessed:= nil;
  FOnProgress:= nil;
  FOnLog:= nil;
  FSyncObj:= TLMDSyncObject.Create;
  FSyncObj.bServerMode:= False;
  FProcessThread:= nil;
  FDelItems:= TList.Create;
end;

{-----------------------------------------------------------------------------}
destructor TLMDDownloads.Destroy;
begin
  FDelItems.Free;
  if FProcessThread <> nil then
    begin
      FProcessThread.Terminate;
    end;
  Terminate;
  if FProcessThread <> nil then
    FProcessThread.Free;
  FInternetOptions.Free;
  CloseHandle(FSem);
  CloseHandle(FSemP);
  Clear;
  FSyncObj.Free;
  inherited;
end;

{-----------------------------------------------------------------------------}
function TLMDDownloads.GetItems(index: Integer): TLMDDownloadItem;
begin
  Result:= TLMDDownloadItem(inherited Items[index]);
end;

{-----------------------------------------------------------------------------}
function TLMDDownloads.Process: Boolean;
var
  i: Integer;
  iCount: Integer;
  AllTerminated: Boolean;
begin
  FAllSize:= 0;

  iServerIndex:= -1;
  Terminated:= False;
  Result:= True;
  FDelItems.Clear;
  if Count = 0 then
    begin
      FState:= DS_PROCESSED;
      if Assigned(FOnProcessed) then
        FSyncObj.Synchronize(Processed);
      exit;
    end;
  FState:= DS_PROCESSING;
  try
    for i:= 0 to Count - 1 do
      Items[i].Prepare;
    iCount:= ServerThreads;

    if iCount >= MAX_SERVER_THREADS then
      iCount:= MAX_SERVER_THREADS;
    try
      SetLength(aT, iCount);
      for i := Low(aT) to High(aT) do
        begin
          aT[i]:= TLMDProcessDownloadThread.Create(Self);
          aT[i].Process;
        end;

      repeat
        AllTerminated := True;
        Sleep(30);
        for i := Low(aT) to High(aT) do
          AllTerminated := AllTerminated and aT[i].FThreadTerminated;
      until AllTerminated;
      FState:= DS_PROCESSED;
    finally
      for i := Low(aT) to High(aT) do
        begin
          aT[i].Free;
          aT[i]:= nil;
        end;
    end;
  except
  end;
  if assigned(FOnProcessed) then
    FSyncObj.Synchronize(Processed);
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.Terminate;
var
  i: Integer;
begin
  if FState = DS_PROCESSING then
    begin
      Terminated:= True;
      for i:= 0 to Count - 1 do
        Items[i].Terminate;
      WaitForSingleObject(FSem, INFINITE);
      try
        for i := Low(aT) to High(aT) do
          if aT[i] <> nil then
            begin
              aT[i].Terminate;
              aT[i].Process;
            end
          else
            break;
      except
      end;
      ReleaseSemaphore(FSem, 1, nil);
    end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.SetOnProcessed(const Value: TLMDDownloadProcessed);
begin
  FOnProcessed:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.SetOnProgress(const Value: TLMDDownloadProgress);
begin
  FOnProgress:= Value;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.Processed;
begin
  if assigned(FOnProcessed) then
    FOnProcessed(Self);
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.Progress;
begin
  if assigned(FOnProgress) then
    FOnProgress(FProgressObj);
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.SendProgress(Sender: TLMDDownloadItem; bNonCritical:
  Boolean = False);
begin
  if bNonCritical then
    if FSyncObj.CheckOverhead then
      exit;
  WaitForSingleObject(FSemP, INFINITE);
  try
    FProgressObj:= Sender;
    if assigned(FOnProgress) and (not Terminated) then
      FSyncObj.Synchronize(Progress);
  except
  end;
  ReleaseSemaphore(FSemP, 1, nil);
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.ThreadProcess;
begin
  try
    if FProcessThread <> nil then
      FProcessThread.Free;
    FProcessThread:= TLMDProcessThread.Create(Self);
    FProcessThread.Resume;
  except
    ;
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.WaitForEnd;
begin
  if FProcessThread <> nil then
    begin
      FProcessThread.WaitFor;
      FProcessThread.Free;
      FProcessThread:= nil;
    end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.ContinueProcess;
var
  i: Integer;
begin
  if FState = DS_PROCESSING then
    for i := Low(aT) to High(aT) do
      if (aT[i] <> nil)  then
        aT[i].Process;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.SeTLMDInternetOptions(const Value: TLMDInternetOptions);
begin
  FInternetOptions.Assign(Value);
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.ClearState;
begin
  if FState in [DS_PROCESSED, DS_ERROR] then
    FState:= DS_NONE;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.DeleteItem(Item: TLMDDownloadItem);
begin
  FDelItems.Add(Item);
end;

{-----------------------------------------------------------------------------}
function TLMDDownloads.GetCPS: Integer;
begin
  WaitForSingleObject(FSem, INFINITE);
  try
    if FStartTime <> GetTickCount then
      Result:= Trunc(FAllSize / (GetTickCount - FStartTime) * 1000)
    else
      Result:= 0;
  finally
    ReleaseSemaphore(FSem, 1, nil);
  end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.SizeChanged(iSize: int64; lTime: Longword);
begin
  WaitForSingleObject(FSem, INFINITE);
  try
    FAllSize:= FAllSize + iSize;
    if FStartTime = 0 then
      FStartTime:= GetTickCount - lTime;
  finally
    ReleaseSemaphore(FSem, 1, nil);
  end;
end;

{-----------------------------------------------------------------------------}
function TLMDDownloads.GetNextServer(Sender: TLMDProcessDownloadThread):
  TLMDDownloadItem;
var
  i: Integer;
  bAll: Boolean;
begin
  Result:= nil;
  if Terminated then
    exit;
  WaitForSingleObject(FSem, INFINITE);
  if Terminated then
    begin
      ReleaseSemaphore(FSem, 1, nil);
      exit;
    end;
  try
    Inc(iServerIndex);
    while FDelItems.Count > 0 do
      begin
        if TLMDDownloadItem(FDelItems[0]).index < iServerIndex then
          Dec(iServerIndex);
        TLMDDownloadItem(FDelItems[0]).Free;
        FDelItems.Delete(0);
      end;
    if (iServerIndex >= 0) and (iServerIndex < Count) then
      begin
        Result:= Items[iServerIndex];
        if not Result.Ready then
          begin
            WaitForSingleObject(FSemP, 100);
            ReleaseSemaphore(FSemP, 1, nil);
          end;
      end
    else
      Dec(iServerIndex);
    if Result = nil then
      begin
        Sender.NullItem:= True;
        bAll:= True;
        for i := Low(aT) to High(aT) do
          if (aT[i] <> nil) then
            begin
              if not aT[i].NullItem then
                begin
                  bAll:= False;
                  break;
                end;
            end
          else
            break;
        if bAll then
          begin
            for i := Low(aT) to High(aT) do
              if aT[i] <> nil then
                begin
                  aT[i].Terminate;
                  aT[i].Process;
                end
              else
                break;
            Terminated:= True;
          end;
      end
    else
      begin
        Result.InternetOptions:= InternetOptions;
        Sender.NullItem:= False;
      end;
  except
  end;
  ReleaseSemaphore(FSem, 1, nil);
end;

{ ************************ TLMDProcessDownloadThread ************************ }
{-----------------------------------------------------------------------------}
constructor TLMDProcessDownloadThread.Create(Downloads: TLMDDownloads);
begin
  FDownloads:= Downloads;
  FThreadTerminated := False;
  FWaitEvent := TEvent.Create(nil, True, False, '');
  inherited Create(False);
  FreeOnTerminate:= False;
  NullItem:= False;
end;

{------------------------------------------------------------------------------}
destructor  TLMDProcessDownloadThread.Destroy;
begin
  Process;
  FWaitEvent.WaitFor(INFINITE);
  FWaitEvent.Free;
  inherited ;
end;

{-----------------------------------------------------------------------------}
procedure TLMDProcessDownloadThread.Process;
begin
  FWaitEvent.SetEvent;
end;

{-----------------------------------------------------------------------------}
procedure TLMDProcessDownloadThread.Execute;
var
  DI: TLMDDownloadItem;
begin
  try
    while not Terminated do
      begin
        FWaitEvent.WaitFor(INFINITE);

        if  Terminated  then
          break;

        DI:= FDownloads.GetNextServer(Self);
        if DI <> nil then
          begin
            try
              if (not DI.Terminated) then
                DI.Process;
            except
            end;
          end
        else
          if not Terminated then
          begin
            FWaitEvent.ResetEvent;
          end;
      end;
  finally
    FThreadTerminated := True;
  end;
end;

{ ******************************* TLMDProcessThread **************************** }
{-----------------------------------------------------------------------------}
constructor TLMDProcessThread.Create(Downloads: TLMDDownloads);
begin
  FDownloads:= Downloads;
  inherited Create(True);
  FreeOnTerminate:= False;
end;

{-----------------------------------------------------------------------------}
destructor TLMDProcessThread.Destroy;
begin
  inherited;
end;

{-----------------------------------------------------------------------------}
procedure TLMDProcessThread.Execute;
begin
  FDownloads.Process;
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloadItem.Log(iEvent: Integer; szDescription,
  szData: string);
begin
  if (Collection <> nil) then
    if assigned(TLMDDownloads(Collection).FOnLog) then
      TLMDDownloads(Collection).FOnLog(Self, iEvent, szDescription, szData);
end;

{-----------------------------------------------------------------------------}
procedure TLMDDownloads.SetOnLog(const Value: TLMDDownloadLogEvent);
begin
  FOnLog:= Value;
end;

{ TLMDCookiesList }
{------------------------------------------------------------------------------}
procedure TLMDCookiesList.AddText(const szText: string);
var
  s: TStringList;
  i, j: Integer;
begin
  if szText <> '' then
    begin
      s:= TStringList.Create;
      s.Text:= szText;
      try
        for i:= 0 to s.Count - 1 do
          begin
            j:= IndexOfName(s.Names[i]);
            if j = -1 then
              Add(s[i])
            else
              Strings[j]:= s[i];
          end;
      finally
        s.Free;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDownloads.SetReload(const Value: Boolean);
begin
  FReload := Value;
end;

end.
