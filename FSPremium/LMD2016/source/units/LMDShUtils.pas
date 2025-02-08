unit  LMDShUtils;
{$I lmdcmps.INC}

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

LMDShUtils unit ()
------------------

Changes
-------
Release 8.05
+ All required declarations for TrayIcon Win2K+ features

Release 8.0 (October 2006)
 - Initial Release

##############################################################################}

interface

uses
  ExtCtrls, Windows, Messages, ShellAPI, ShlObj, SysUtils,
  LMDTypes;

{$IFNDEF LMDCOMP7}
const
  ComCtlVersionIE501 = $00050051;
  ComCtlVersionIE6 = $00060000;
  // already defined in ComCtrls.pas:
  // ComCtlVersionIE3, ComCtlVersionIE4, ComCtlVersionIE401, ComCtlVersionIE5
{$ENDIF}

// Improved TrayIcon Support
// ----------------------------------
{$IFNDEF LMDCOMP10}
const
  {$EXTERNALSYM NIIF_NONE}
  NIIF_NONE       = $00000000;
  {$EXTERNALSYM NIIF_INFO}
  NIIF_INFO       = $00000001;
  {$EXTERNALSYM NIIF_WARNING}
  NIIF_WARNING    = $00000002;
  {$EXTERNALSYM NIIF_ERROR}
  NIIF_ERROR      = $00000003;

  {$EXTERNALSYM NIF_INFO}
  NIF_INFO        = $00000010;

  {$EXTERNALSYM NIN_BALLOONSHOW}
  NIN_BALLOONSHOW       = $0400 + 2;
  {$EXTERNALSYM NIN_BALLOONHIDE}
  NIN_BALLOONHIDE       = $0400 + 3;
  {$EXTERNALSYM NIN_BALLOONTIMEOUT}
  NIN_BALLOONTIMEOUT    = $0400 + 4;
  {$EXTERNALSYM NIN_BALLOONUSERCLICK}
  NIN_BALLOONUSERCLICK  = $0400 + 5;

  {$EXTERNALSYM WM_SYSTEM_TRAY_MESSAGE}
  WM_SYSTEM_TRAY_MESSAGE = WM_USER + 1;


type
  TLMDBalloonFlags = {$IFDEF LMDCOMP7}
                     (bfNone = NIIF_NONE, bfInfo = NIIF_INFO,
                      bfWarning = NIIF_WARNING, bfError = NIIF_ERROR);
                     {$ELSE}
                     (bfNone, bfInfo, bfWarning, bfError);
                     {$ENDIF}



// extended TNotifyIconData record available from Win2K on
type
  TNotifyIconData2K = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..127] of AnsiChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array [0..255] of AnsiChar;
    case Integer of
      1: (uTimeout: UINT);
      2: (uVersion: UINT;
          szInfoTitle: array [0..63] of AnsiChar;
          dwInfoFlags: DWORD;
          guidItem: TGUID;
          hBalloonIcon: hIcon;)
  end;

  TLMDNotifyIconData = TNotifyIconData2K;
  {$ELSE}
type
  TLMDBalloonFlags = TBalloonFlags;
  TLMDNotifyIconData = TNotifyIconData;

{$ENDIF}

const
  {$EXTERNALSYM NOTIFYICONDATA_V3_SIZE}
  NOTIFYICONDATA_V3_SIZE = SizeOf(TNotifyIconData) - SizeOf(HICON);
  {$EXTERNALSYM NOTIFYICONDATA_V2_SIZE}
  NOTIFYICONDATA_V2_SIZE = SizeOf(TNotifyIconData) - SizeOf(HICON) - SizeOf(TGUID);
  {$EXTERNALSYM NOTIFYICONDATA_V1_SIZE}
  NOTIFYICONDATA_V1_SIZE = SizeOf(DWORD) + SizeOf(HWND) + SizeOf(UINT) + SizeOf(UINT) + SizeOf(UINT) + SizeOf(HICON) + 64*SizeOf(Char);


// ----------------------------------
type
  TLMDSystemFolder=(sfDesktop, sfMyComputer, sfProgramMenu, sfControlPanel,
                    sfPrinters, sfPersonal, sfFavorites, sfStartup, sfRecentDocuments,
                    sfSendto, sfRecycleBin, sfStartMenu, sfDesktopDirectory,
                    sfNetworkFolder, sfNetworkNeighborhood, sfInternet, sfFonts,
                    sfTemplates, sfCommonStartMenu, sfCommonPrograms, sfCommonStartup,
                    sfCommonDesktopDirectory, sfAppData, sfPrintHood, sfAltStartup,
                    sfCommonAltStartup, sfCommonFavorites, sfInternetCache, sfCookies,
                    sfHistory, sfMyVideo, sfCommonVideo, sfMyPictures, sfCommonPictures,
                    sfMyMusic, sfCommonMusic, sfMyDocuments, sfAdminTools, sfCommonAdminTools,
                    sfBurnArea, sfProfile, sfProfiles, sfProgramFiles, sfCommonProgramFiles,
                    sfWindows, sfSystem, sfCustomFolder);

  TLMDRootFolder = sfDesktop..sfSystem;

  {****************************************************************************}
  TLMDRoot = type string;

  TLMDChangeFilterStruct = record
    cbSize: DWORD;
    ExtStatus: DWORD;
  end;

// System Folder related methods
function LMDGetSpecialFolderPath(const Folder:TLMDSystemFolder): string;
function LMDGetRootFolderID(aValue : TLMDRoot) : PItemIDList; overload;
function LMDGetRootFolderID(aValue : TLMDSystemFolder) : PItemIDList; overload;

function LMDSHGetFileInfo(const pszPath: string; dwFileAttributes: DWORD;
                          out psfi: TSHFileInfo; uFlags: UINT): DWORD; overload;
function LMDSHGetFileInfo(aPIDL: PItemIDList; dwFileAttributes: DWORD;
                          out psfi: TSHFileInfo; uFlags: UINT): DWORD; overload;
function LMDExtractIconEx(const lpszFile: string; nIconIndex: Integer;
                          var phiconLarge, phiconSmall: HICON): UINT;
function LMDGetIconCount(const lpszFile: string): integer;

function LMDGetFileSize(const FileName: TLMDString): Int64;
function LMDBrowseForFolder(Handle: Integer; Caption: String;
                            var strFolder: String): Boolean;
function LMDBrowseForFolderEx(Handle: Integer; Caption: String;
                              AddFlags: Cardinal;
                              RemoveFlags: Cardinal;
                              var strFolder: String): Boolean;

// Vista specific routines
function LMDIsElevated: Boolean;
function LMDRunElevated(AWindow: HWND; const APath: TLMDString; const AParams: TLMDString; const AWorkDir: TLMDString): Boolean;
function LMDChangeWindowMessageFilter(AMessage: Word; AAddMessage: Boolean): Boolean;
function LMDChangeWindowMessageFilterEx(AWindow: HWND; AMessage: Word; AAddMessage: Boolean; var pChangeFilterStruct: TLMDChangeFilterStruct): Boolean;

implementation

uses
 LMDFiles, TypInfo, ActiveX, LMDSysIn, LMDStrings, Dialogs;

var
  ChangeWindowMessageFilter: function(msg: UINT; dwFlag: dword): Boolean; stdcall;
  ChangeWindowMessageFilterEx: function(hWnd: HWND; msg: UINT; dwFlag: dword; var pChangeFilterStruct: TLMDChangeFilterStruct): Boolean; stdcall;

  LUser32Handle: THandle;

const
  SYSFOLDERS:array[TLMDRootFolder] of Integer=
             (CSIDL_DESKTOP, CSIDL_DRIVES, CSIDL_PROGRAMS, CSIDL_CONTROLS,
              CSIDL_PRINTERS, CSIDL_PERSONAL, CSIDL_FAVORITES,
              CSIDL_STARTUP, CSIDL_RECENT, CSIDL_SENDTO,
              CSIDL_BITBUCKET, CSIDL_STARTMENU, CSIDL_DESKTOPDIRECTORY,
              CSIDL_NETWORK, CSIDL_NETHOOD, $0001, //CSIDL_INTERNET
              CSIDL_FONTS, CSIDL_TEMPLATES, CSIDL_COMMON_STARTMENU,
              CSIDL_COMMON_PROGRAMS, CSIDL_COMMON_STARTUP, CSIDL_COMMON_DESKTOPDIRECTORY,
              CSIDL_APPDATA, CSIDL_PRINTHOOD,
              $001d, // ssfAltStartup
              $001e, // ssfCommonAltstartup
              $001f, // ssfCommonFavorites
              $0020, // ssfInternetCache
              $0021, // ssfCookies,
              $0022, // ssfHistory
              // -----------------
              $000e, // ssfMyVideo
              $0037, // CSIDL_COMMON_VIDEO
              $0027, // ssfMyPictures
              $0036, // CSIDL_COMMON_PICTURES
              $000d, // CSIDL_MYMUSIC
              $0035, // CSIDL_COMMON_MUSIC
              $000c, // CSIDL_MYDOCUMENTS
              $0030, // CSIDL_ADMINTOOLS
              $002f, // CSIDL_COMMON_ADMINTOOLS
              $003b, // CSIDL_CDBURN_AREA
              $0028, // CSIDL_PROFILE
              $003e, // CSIDL_PROFILES
              $0026, // CSIDL_PROGRAM_FILES
              $002b, // CSIDL_PROGRAM_FILES_COMMON
              $0024, // CSIDL_WINDOWS (0x)
              $0025  // CSIDL_SYSTEM (0x)
              );

{------------------------------------------------------------------------------}
function LMDGetSpecialFolderPath(const Folder:TLMDSystemFolder): string;
var
  PIDL: PItemIDList;
  Path: array[0..MAX_PATH] of char;
  Malloc: IMalloc;
begin
  Path := '';
  if Succeeded((SHGetSpecialFolderLocation(0, SYSFOLDERS[Folder], PIDL))) then
    if (SHGetPathFromIDList(PIDL, Path)) then
      if Succeeded(ShGetMalloc(Malloc)) then
        begin
          Malloc.Free(PIDL);
          Malloc := nil;
        end;
  Result := Path;
  end;

{------------------------------------------------------------------------------}
function LMDGetRootFolderID(aValue : TLMDRoot) : PItemIDList;
var
  RootIdx  : integer;
begin
  Result := nil;
  if  (Pos(':', aValue) > 0) or (Pos('\', aValue) > 0) then
    RootIdx := -1
  else
    RootIdx := GetEnumValue(TypeInfo(TLMDRootFolder), aValue);

  if RootIdx>=0 then
    SHGetSpecialFolderLocation(0, SYSFOLDERS[TLMDRootFolder(RootIdx)], Result);
end;

{------------------------------------------------------------------------------}
function LMDGetRootFolderID(aValue : TLMDSystemFolder) : PItemIDList;
var
  RootIdx:integer;
begin
  Result := nil;
  if  (aValue>=Low(TLMDSystemFolder)) and (aValue<High(TLMDSystemFolder))  then
    begin
      RootIdx:=integer(aValue);
      SHGetSpecialFolderLocation(0, SYSFOLDERS[TLMDRootFolder(RootIdx)], Result);
    end;
end;

{------------------------------------------------------------------------------}
function LMDSHGetFileInfo(const pszPath: string; dwFileAttributes: DWORD;
                          out psfi: TSHFileInfo; uFlags: UINT): DWORD;
begin
  Result := SHGetFileInfo(PChar(pszPath), dwFileAttributes, psfi,
    SizeOf(psfi), uFlags);
end;

{------------------------------------------------------------------------------}
function LMDSHGetFileInfo(aPIDL: PItemIDList; dwFileAttributes: DWORD;
                          out psfi: TSHFileInfo; uFlags: UINT): DWORD;
begin
  uFlags := SHGFI_PIDL or uFlags;
  psfi.dwAttributes := uFlags;
  Result := SHGetFileInfo(PChar(aPIDL), dwFileAttributes, psfi,
              SizeOf(psfi), uFlags);
end;

{------------------------------------------------------------------------------}
function LMDExtractIconEx(const lpszFile: string; nIconIndex: Integer;
                          var phiconLarge, phiconSmall: HICON): UINT;
begin
  phiconLarge := 0;
  phiconSmall := 0;
  Result := ExtractIconEx(PChar(lpszFile), nIconIndex, phiconLarge, phiconSmall, 1);
end;

{------------------------------------------------------------------------------}
function ExtractIconEx_1(lpszFile: PChar; nIconIndex: Integer;
  phiconLarge, phiconSmall: Pointer; nIcons: UINT): UINT; stdcall;
    external shell32 name 'ExtractIconExA';

{------------------------------------------------------------------------------}
function LMDGetIconCount(const lpszFile: string): integer;
begin
  Result := ExtractIconEx_1(PChar(lpszFile), -1, nil, nil, 0);
end;

function LMDGetFileSize(const FileName: TLMDString): Int64;

var
  Handle: THandle;
  {$ifdef LMD_UNICODE}
  FindData: TWin32FindDataW;
  {$else}
  FindData: TWin32FindData;
  {$endif}
begin
  {$ifdef LMD_UNICODE}
  Handle := FindFirstFileW(PWideChar(FileName), FindData);
  {$else}
  Handle := FindFirstFile(PChar(FileName), FindData);
  {$endif}
  if Handle <> INVALID_HANDLE_VALUE then
    begin
      Windows.FindClose(Handle);
      if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
      begin
        Int64Rec(Result).Lo := FindData.nFileSizeLow;
        Int64Rec(Result).Hi := FindData.nFileSizeHigh;
        Exit;
      end;
    end;
  Result := -1;
end;

{------------------------------------------------------------------------------}
function _BrowseCallbackProc(hwnd: HWND; uMsg: UINT; lParam: LPARAM;
  lpData: LPARAM): Integer; stdcall;
begin
  if (uMsg = BFFM_INITIALIZED) then
    SendMessage(hwnd, BFFM_SETSELECTION, 1, lpData);
  Result := 0;
end;

{------------------------------------------------------------------------------}

function LMDBrowseForFolder(Handle: Integer; Caption: String;
                            var strFolder: String): Boolean;
begin
  Result := LMDBrowseForFolderEx(Handle, Caption, 0, 0, strFolder);
end;

function LMDBrowseForFolderEx(Handle: Integer; Caption: String;
                              AddFlags: Cardinal;
                              RemoveFlags: Cardinal;
                              var strFolder: String): Boolean;
const
  BIF_NEWDIALOGSTYLE       = $0040;
  BIF_RETURNONLYFSDIRS     = $0080;
  BIF_USENEWUI             = BIF_EDITBOX or BIF_NEWDIALOGSTYLE;

var
  BrowseInfo: TBrowseInfo;
  ItemIDList: PItemIDList;
  JtemIDList: PItemIDList;
  Path: PChar;
  begin
  Result := False;
  Path := StrAlloc(MAX_PATH);
  SHGetSpecialFolderLocation(Handle, CSIDL_DRIVES, JtemIDList);
  with BrowseInfo do
  begin
    hwndOwner := GetActiveWindow;
    pidlRoot := JtemIDList;
    SHGetSpecialFolderLocation(hwndOwner, CSIDL_DRIVES, JtemIDList);
    ulFlags:= BIF_RETURNONLYFSDIRS or BIF_USENEWUI or BIF_EDITBOX;
    pszDisplayName := StrAlloc(MAX_PATH);
    lpszTitle := PChar(Caption);
    lpfn := @_BrowseCallbackProc;
    lParam := Windows.LPARAM(PChar(strFolder));
    end;

  BrowseInfo.ulFlags := BrowseInfo.ulFlags or AddFlags;
  BrowseInfo.ulFlags := BrowseInfo.ulFlags and (not RemoveFlags);

  ItemIDList := SHBrowseForFolder(BrowseInfo);

  if (ItemIDList <> nil) then
    if SHGetPathFromIDList(ItemIDList, Path) then
    begin
      strFolder := Path;
      result := True
    end;
end;

{------------------------------------------------------------------------------}
function LMDIsElevated: Boolean;
var
  LToken: THandle;
  LTE: DWORD;
  LReturnedLength: DWORD;
  begin
  if LMDSIWindowsVistaUp then
  begin

    if (not OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, LToken)) then
    begin
      Result := False;
      exit;
    end;

    if (not GetTokenInformation(LToken, TTokenInformationClass(18) {TokenElevation}, @LTE, SizeOf(LTE), LReturnedLength)) then
    begin
      Result := False;
      exit;
    end
    else
    begin
      if LReturnedLength <> SizeOf(LTE) then
      begin
        Result := False;
        exit;
      end;

      if LTE = 2 then
        Result := True
      else
        Result := False;
    end;

    CloseHandle(LToken);
  end
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
function LMDRunElevated(AWindow: HWND; const APath: TLMDString; const AParams: TLMDString; const AWorkDir: TLMDString): Boolean;
var
  {$ifdef LMD_UNICODE}
  LShellExecInfo: TShellExecuteInfoW;
  {$else}
    LShellExecInfo: TShellExecuteInfoA;
    {$endif}
begin
  FillChar(LShellExecInfo, SizeOf(LShellExecInfo), 0);
  with LShellExecInfo do
  begin
    cbSize := SizeOf(LShellExecInfo);
    fMask := 0;
    Wnd := AWindow;
    lpVerb := 'runas';
    lpFile := PLMDChar(APath);
    lpParameters := PLMDChar(AParams);
    lpDirectory := PLMDChar(AWorkDir);
    nShow := SW_NORMAL;
  end;
  {$ifdef LMD_UNICODE}
  Result := ShellExecuteExW(@LShellExecInfo);
  {$else}
  Result := ShellExecuteExA(@LShellExecInfo);
  {$endif}
  end;

{------------------------------------------------------------------------------}
function LMDChangeWindowMessageFilterEx(AWindow: HWND; AMessage: Word; AAddMessage: Boolean; var pChangeFilterStruct: TLMDChangeFilterStruct): Boolean;
const
  MSGFLT_ADD    = 1;
  MSGFLT_REMOVE = 2;
begin
  Result := False;
  if LMDSIWindowsVistaUp then
  begin
    if Assigned(ChangeWindowMessageFilterEx) then
    begin
      if AAddMessage then
      begin
        Result := ChangeWindowMessageFilterEx(AWindow, AMessage, MSGFLT_ADD, pChangeFilterStruct);
      end
      else
      begin
        Result := ChangeWindowMessageFilterEx(AWindow, AMessage, MSGFLT_REMOVE, pChangeFilterStruct);
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function LMDChangeWindowMessageFilter(AMessage: Word; AAddMessage: Boolean): Boolean;
const
  MSGFLT_ADD    = 1;
  MSGFLT_REMOVE = 2;
begin
  Result := False;
  if LMDSIWindowsVistaUp then
  begin
    if Assigned(ChangeWindowMessageFilter) then
    begin
      if AAddMessage then
      begin
        Result := ChangeWindowMessageFilter(AMessage, MSGFLT_ADD);
      end
      else
      begin
        Result := ChangeWindowMessageFilter(AMessage, MSGFLT_REMOVE);
      end;
    end;
  end;
end;

procedure Load;
begin
  LUser32Handle := LoadLibrary('user32.dll');
  ChangeWindowMessageFilter := GetProcAddress(LUser32Handle, 'ChangeWindowMessageFilter');
  ChangeWindowMessageFilterEx := GetProcAddress(LUser32Handle, 'ChangeWindowMessageFilterEx');
end;

procedure UnLoad;
begin
  ChangeWindowMessageFilter := nil;
  FreeLibrary(LUser32Handle);
end;

initialization
  Load;

finalization
  UnLoad;

end.
