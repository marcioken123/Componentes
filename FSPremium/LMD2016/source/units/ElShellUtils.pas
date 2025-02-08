unit ElShellUtils;
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

ElShellUtils unit
-----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  ComObj,
  ActiveX,
  ShellAPI,
  Registry,
  Graphics,
  ShlObj,
  CommCtrl,
  Controls,
  ImgList,
  Classes,
  SysUtils,
  Forms,
  Types,

  LMDTypes,
  LMDDebugUnit,
  LMDObjectList,
  LMDProcs,
  LMDSysIn,
  {$ifdef LMD_UNICODE}
  LMDUnicode,
  {$endif}
  LMDStrings,

  ElVCLUtils;

{HPPEMIT '#include "ElInprocHookAPI.hpp"'}

type

  TShellFolders =
     (sfoDesktopExpanded,sfoDesktop,sfoPrograms, sfoControlPanel,
      sfoPrinters,sfoPersonal,sfoFavorites,sfoStartup, sfoRecent,
      sfoSendto,sfoRecycleBin,sfoStartMenu,sfoDesktopDirectory,
      sfoMyComputer,
      sfoNetwork,sfoNetworkNeighborhood,sfoFonts,sfoTemplates,
      // sfoCommon is available starting from NT 4
      sfoCommonStartMenu, sfoCommonPrograms, sfoCommonStartup,
      sfoCommonDesktopDirectory, sfoAppData, sfoPrintHood,

      // other:
      sfoLocalAppData, sfoAltStartUp, sfoCommonAltStartUp, sfoCommonFavorites,
      sfoInternetCache, sfoCookies, sfoHistory, sfoCommonAppData, sfoWindows,
      sfoSystem, sfoProgramFiles, sfoMyPictures, sfoProfile, sfoSystemX86,
      sfoProgramFilesX86, sfoProgramFilesCommon, sfoProgramFilesCommonX86,
      sfoCommonTemplates, sfoCommonDocuments, sfoCommonAdminTools, sfoAdminTools,

      sfoCustom);

  TShellAttr = Cardinal;

{$ifndef LMDCOMP16}
 {EN Add HPPEMIT instructions for CBUILDER}
{$HPPEMIT '#ifndef NO_WIN32_LEAN_AND_MEAN'}
{$HPPEMIT 'typedef UNALIGNED _ITEMIDLIST * LPITEMIDLIST;'}
{$HPPEMIT 'typedef const UNALIGNED _ITEMIDLIST * LPCITEMIDLIST;'}
{$ifndef lmdcomp11}
{$HPPEMIT 'typedef struct _STRRET'}
{$HPPEMIT '{'}
{$HPPEMIT '    UINT uType; // One of the STRRET_* values'}
{$HPPEMIT '    union'}
{$HPPEMIT '    {'}
{$HPPEMIT '        LPWSTR          pOleStr;        // must be freed by caller of GetDisplayNameOf'}
{$HPPEMIT '        LPSTR           pStr;           // NOT USED'}
{$HPPEMIT '        UINT            uOffset;        // Offset into SHITEMID'}
{$HPPEMIT '        char            cStr[MAX_PATH]; // Buffer to fill in (ANSI)'}
(*$HPPEMIT '    } DUMMYUNIONNAME;'*)
(*$HPPEMIT '} STRRET, *LPSTRRET;'*)

{$HPPEMIT 'typedef struct {}
{$HPPEMIT '    GUID fmtid;'}
{$HPPEMIT '    DWORD pid;'}
(*$HPPEMIT '} SHCOLUMNID, *LPSHCOLUMNID;'*)

{$HPPEMIT 'typedef const SHCOLUMNID* LPCSHCOLUMNID;'}

{$HPPEMIT 'typedef SHCOLUMNID *PShColumnID;'}

{$HPPEMIT 'typedef struct _SHELLDETAILS'}
(*$HPPEMIT '{'*)
{$HPPEMIT '    int     fmt;            // LVCFMT_* value (header only)'}
{$HPPEMIT '    int     cxChar;         // Number of "average" characters (header only)'}
{$HPPEMIT '    STRRET  str;            // String information'}
(*$HPPEMIT '} SHELLDETAILS, *LPSHELLDETAILS;'*)
{$endif}

{$HPPEMIT 'typedef _SHELLDETAILS *PShellDetails;'}

{$HPPEMIT 'typedef _SHELLDETAILS  TShellDetails;'}

{$ifndef lmdcomp11}
{$HPPEMIT 'DECLARE_INTERFACE_(IShellFolder, IUnknown)'}
{$HPPEMIT '{'}
{$HPPEMIT '    // *** IUnknown methods ***'}
{$HPPEMIT '    STDMETHOD(QueryInterface) (THIS_ REFIID riid, void **ppv) PURE;'}
{$HPPEMIT '    STDMETHOD_(ULONG,AddRef) (THIS)  PURE;'}
{$HPPEMIT '    STDMETHOD_(ULONG,Release) (THIS) PURE;'}
{$HPPEMIT ''}
{$HPPEMIT '    // *** IShellFolder methods ***'}
{$HPPEMIT '    STDMETHOD(ParseDisplayName)(THIS_ HWND hwnd, LPBC pbc, LPOLESTR pszDisplayName,'}
{$HPPEMIT '                                ULONG *pchEaten, LPITEMIDLIST *ppidl, ULONG *pdwAttributes) PURE;'}
{$HPPEMIT ''}
{$HPPEMIT '    STDMETHOD(EnumObjects)(THIS_ HWND hwnd, DWORD grfFlags, IEnumIDList **ppenumIDList) PURE;'}
{$HPPEMIT ''}
{$HPPEMIT '    STDMETHOD(BindToObject)(THIS_ LPCITEMIDLIST pidl, LPBC pbc, REFIID riid, void **ppv) PURE;'}
{$HPPEMIT '    STDMETHOD(BindToStorage)(THIS_ LPCITEMIDLIST pidl, LPBC pbc, REFIID riid, void **ppv) PURE;'}
{$HPPEMIT '    STDMETHOD(CompareIDs)(THIS_ LPARAM lParam, LPCITEMIDLIST pidl1, LPCITEMIDLIST pidl2) PURE;'}
{$HPPEMIT '    STDMETHOD(CreateViewObject)(THIS_ HWND hwndOwner, REFIID riid, void **ppv) PURE;'}
{$HPPEMIT '    STDMETHOD(GetAttributesOf)(THIS_ UINT cidl, LPCITEMIDLIST * apidl, ULONG * rgfInOut) PURE;'}
{$HPPEMIT '    STDMETHOD(GetUIObjectOf)(THIS_ HWND hwndOwner, UINT cidl, LPCITEMIDLIST * apidl,'}
{$HPPEMIT '                             REFIID riid, UINT * prgfInOut, void **ppv) PURE;'}
{$HPPEMIT '    STDMETHOD(GetDisplayNameOf)(THIS_ LPCITEMIDLIST pidl, DWORD uFlags, LPSTRRET lpName) PURE;'}
{$HPPEMIT '    STDMETHOD(SetNameOf)(THIS_ HWND hwnd, LPCITEMIDLIST pidl, LPCOLESTR pszName,'}
{$HPPEMIT '                         DWORD uFlags, LPITEMIDLIST *ppidlOut) PURE;'}
(*$HPPEMIT '};'*)
{$endif}

{$HPPEMIT 'typedef IShellFolder * LPSHELLFOLDER;'}

{$HPPEMIT 'typedef int (CALLBACK* BFFCALLBACK)(HWND hwnd, UINT uMsg, LPARAM lParam, LPARAM lpData);}

(*$HPPEMIT 'typedef struct _browseinfoA {*)
{$HPPEMIT '    HWND        hwndOwner;}
{$HPPEMIT '    LPCITEMIDLIST pidlRoot;}
{$HPPEMIT '    LPSTR        pszDisplayName; // Return display name of item selected.}
{$HPPEMIT '    LPCSTR       lpszTitle;      // text to go in the banner over the tree.}
{$HPPEMIT '    UINT         ulFlags;      // Flags that control the return stuff}
{$HPPEMIT '    BFFCALLBACK  lpfn;}
{$HPPEMIT '    LPARAM       lParam;     // extra info that's passed back in callbacks}
{$HPPEMIT '    int          iImage;     // output var: where to return the Image index.}
(*$HPPEMIT '} BROWSEINFOA, *PBROWSEINFOA, *LPBROWSEINFOA;*)

(*$HPPEMIT 'typedef struct _browseinfoW {*)
{$HPPEMIT '    HWND        hwndOwner;}
{$HPPEMIT '    LPCITEMIDLIST pidlRoot;}
{$HPPEMIT '    LPWSTR        pszDisplayName; // Return display name of item selected.}
{$HPPEMIT '    LPCWSTR       lpszTitle;      // text to go in the banner over the tree.}
{$HPPEMIT '    UINT         ulFlags;      // Flags that control the return stuff}
{$HPPEMIT '    BFFCALLBACK  lpfn;}
{$HPPEMIT '    LPARAM       lParam;     // extra info that's passed back in callbacks}
{$HPPEMIT '    int          iImage;     // output var: where to return the Image index.}
(*$HPPEMIT '} BROWSEINFOW, *PBROWSEINFOW, *LPBROWSEINFOW;*)

{$HPPEMIT '#endif'}
{$ENDIF}
{$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IEnumExtraSearch);'}
{END HPPEMIT instructions for CBUILDER}

function  GetParentPIDL(PIDL: PItemIDList): PItemIDList;
function  GetOwnPIDL(PIDL: PItemIDList): PItemIDList;
function  GetItemIDOnly(PIDL: PItemIDList): PItemIDList;
function GetNextItemID(PIDL: PItemIDList): PItemIDList;
function  GetEmptyPIDL: PItemIDList;
function  PIDLContainsAt(PIDL, SubPIDL: PItemIDList; Pos: Integer): Boolean;
function  PIDLStartsWith(PIDL, SubPIDL: PItemIDList): Boolean;
function GetLastPIDL(PIDL: PItemIDList): PItemIDList;
function GetDesktopFolder: IShellFolder;
function GetShellMalloc: IMalloc;
function GetShellFolder(PIDL: PItemIDList): IShellFolder;
function GetParentFolder(PIDL: PItemIDList): IShellFolder;
function GetPIDLTypeName(PIDL: PItemIDList): TLMDString;

function  AppendPIDL(ParentPIDL, ChildPIDL: PItemIDList): PItemIDList;
function  ClonePIDL(PIDL: PItemIDList): PItemIDList;
function  GetFolderPIDL(FolderID: TShellFolders; const CustomName: TLMDString): PItemIDList;
function GetFolderPIDL2(FolderID: TShellFolders; const CustomName: TLMDString): PItemIDList;
function  CalcPIDLSize(PIDL: PItemIDList): Integer;
function  CompareIDLists(IDList1, IDList2: PItemIDList): Boolean;
procedure FreeIDList(var PIDL: PItemIDList);
function  GetPathFromPIDL(PIDL: PItemIDList; var Path: TLMDString): Boolean;
function  GetPathFromPIDL2(PIDL: PItemIDList): TLMDString;
function  GetPIDLFromPath(const Path: TLMDString): PItemIDList;
function SHGetPIDLFromPath(const ShellFolder:IShellFolder; const Path: TLMDString): PItemIDList;
function  StrRetToPas(const str: TStrRet; PIDL: PItemIDList): TLMDString;
procedure StrRetFree(const str: TStrRet);
function  IsDesktopPIDL(PIDL: PItemIDList): Boolean;
function ShellExecutePIDL(PIDL: PItemIDList): Boolean;
function ExecutePIDLContextMenuVerb(Handle: THandle; RelativePIDL: PItemIDList;
  const ParentFolder: IShellFolder; const Verb: String):Boolean;

// This mode is not recommended to usage:
{.$define _DoNotUseSystemCache_}
// When it is used local cache of applications. It is slower mode!

type
  TElShellIconCache = class
  private
    FSmallImages  :TCustomImageList;
    {$ifdef _DoNotUseSystemCache_}
    FNames        :TLMDObjectList;
    DefSmallIcon  :HICON;
    procedure OnItemDelete(Sender: TObject; var Item: TxListItem);
    {$endif}
  public
    constructor Create;
    destructor Destroy; override;
    function AddFromPIDL(PIDL: PItemIDList; Flags: TShellAttr; OpenIcon: Boolean): Integer;
    property SmallImages: TCustomImageList read FSmallImages;
  end;

function ShellIconCache: TElShellIconCache;

function GetCompressedColor: Integer;

const
  SID_IShellDetails       = '{000214EC-0000-0000-C000-000000000046}';
  SID_IShellFolder2       = '{93F2F68C-1D1B-11D3-A30E-00C04F79ABD1}';
  SID_IEnumExtraSearch    = '{0e700be1-9db6-11d1-A1CE-00C04FD75D13}';

  IID_IShellDetails:TGUID = '{000214EC-0000-0000-C000-000000000046}';
  IID_IShellFolder2:TGUID = '{93F2F68C-1D1B-11D3-A30E-00C04F79ABD1}';

type

  {$EXTERNALSYM PExtraSearch}
  PExtraSearch = ^TExtraSearch;
  {$EXTERNALSYM tagExtraSearch}
  tagExtraSearch = record
    guidSearch       :TGUID;
    wszFriendlyName,
    wszMenuText      :array[0..79] of WideChar;
    wszHelpText      :array[0..MAX_PATH] of WideChar;
    wszUrl           :array[0..2047] of WideChar;
    wszIcon,
    wszGreyIcon,
    wszClrIcon       :array[0..MAX_PATH+10] of WideChar;
  end;
  {$EXTERNALSYM TExtraSearch}
  TExtraSearch = tagExtraSearch;

  PShColumnID = ^TShColumnID;
  {$EXTERNALSYM SHCOLUMNID}
  SHCOLUMNID = record
    fmtid :TGUID;
    pid   :DWORD;
  end;
  {$EXTERNALSYM TShColumnID}
  TShColumnID = SHCOLUMNID;

  PShellDetails = ^TShellDetails;
  {$EXTERNALSYM _SHELLDETAILS}
  _SHELLDETAILS = record
    fmt,
    cxChar :Integer;
    str    :TSTRRET;
  end;
  TShellDetails = _SHELLDETAILS;
  {$EXTERNALSYM SHELLDETAILS}
  SHELLDETAILS = _SHELLDETAILS;

  {$EXTERNALSYM IEnumExtraSearch}
  IEnumExtraSearch = interface(IUnknown)
    [SID_IEnumExtraSearch]
    function Next(celt: ULONG; out rgelt: PExtraSearch; out pceltFetched: ULONG): HResult; stdcall;
    function Skip(celt: ULONG): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppEnum: IEnumExtraSearch): HResult; stdcall;
  end;
  POleVariant = ^OleVariant;

  IShellFolder2 = interface(IShellFolder)
    [SID_IShellFolder2]
    function GetDefaultSearchGUID(out pguid: TGUID): HResult; stdcall;
    function EnumSearches(out ppEnum: IEnumExtraSearch): HResult; stdcall;
    function GetDefaultColumn(dwRes: DWORD; var pSort: ULONG;
      var pDisplay: ULONG): HResult; stdcall;
    function GetDefaultColumnState(iColumn: UINT; var pcsFlags: DWORD): HResult; stdcall;
    function GetDetailsEx(pidl: PItemIDList; const pscid: SHCOLUMNID;
      pv: POleVariant): HResult; stdcall;
    function GetDetailsOf(pidl: PItemIDList; iColumn: UINT;
      var psd: TShellDetails): HResult; stdcall;
    function MapNameToSCID(pwszName: LPCWSTR; var pscid: TShColumnID): HResult; stdcall;
  end;
  IShellDetails = interface(IUnknown)
    [SID_IShellDetails]
    function GetDetailsOf(pidl: PItemIDList; iColumn: UINT;
      var pDetails: TShellDetails): HResult; stdcall;
    function ColumnClick(iColumn: UINT): HResult; stdcall;
  end;
  // Undocumented Shell ChangeNotify API "ShlObj.h":
// [http://www.geocities.com/SiliconValley/4942/notify.html]

  PSHChangeNotifyEntry = ^TSHChangeNotifyEntry;
  TSHChangeNotifyEntry = packed record
    PIDL       :PItemIDList;
    fRecursive :BOOL;
  end;

  PSHDwordItemID = ^TSHDwordItemID;
  TSHDwordItemID = packed record
    dwItem1  :Pointer; //DWORD
    dwItem2  :Pointer; //DWORD
  end;
  PSHChangeDWORDAsIDList = ^TSHChangeDWORDAsIDList;
  TSHChangeDWORDAsIDList = packed record
    cb       :SHORT; // USHORT
    dwItem1  :DWORD;
    dwItem2  :DWORD;
    cbZero   :SHORT;  // USHORT
  end;

const
 SHCNF_ACCEPT_INTERRUPTS      = $0001;
 SHCNF_ACCEPT_NON_INTERRUPTS  = $0002;
 SHCNF_NO_PROXY               = $8000; // WinNT Only

var
  WM_SHCHANGENOTIFY : UINT;// ID = '{7EC0A8B0-F3CF-41E3-9345-C004F94A673F}'

type
  TSHChangeNotifyRegister = function (hWnd: HWND; fSources: DWORD; wEventMask: Cardinal;
    wMsg: UINT; cEntries: DWORD; const Items: TSHChangeNotifyEntry): ULONG; stdcall;
  TSHChangeNotifyDeregister = function (hNotify: ULONG): BOOL; stdcall;

function SHChangeNotifyRegister(hWnd: HWND; fSources: DWORD; wEventMask: Cardinal;
    wMsg: UINT; cEntries: DWORD; var Items: TSHChangeNotifyEntry): ULONG; stdcall;
function SHChangeNotifyDeregister(hNotify: ULONG): BOOL; stdcall;

{$EXTERNALSYM SHGetFileInfoW}
function SHGetFileInfoW(pszPath: PWideChar; dwFileAttributes: DWORD;
  var psfi: TSHFileInfoW; cbFileInfo, uFlags: UINT): DWORD; stdcall;

function SetAutoComplete(Handle: THandle; bFileSystem, bURL: Boolean): Boolean;
function GetModule(const ModuleName: String): HMODULE;

function ElCreateShellLinkA(const sFileName, sShortcutTo,
  sWorkingDir, sArguments, sDescription,
  sIconFileName: TLMDString; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;

function ElCreateShellLinkW(const wsFileName, wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: WideString; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;

function ElCreateShellLink(const wsFileName, wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: TLMDString; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;

function ElReadShellLinkA(const wsFileName: WideString; var sShortcutTo,
  sWorkingDir, sArguments, sDescription,
  sIconFileName: TLMDString; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;

function ElReadShellLinkW(const wsFileName: WideString; var wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: WideString; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;

function ElReadShellLink(const wsFileName: WideString; var wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: WideString; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;

function ElGetFileSizeFormat: string;

type
  LMDELSHGetPathFromIDListProcW = function (pidl: PItemIDList; pszPath: PWideChar): BOOL; stdcall;
  LMDELSHGetPathFromIDListProc = function (pidl: PItemIDList; pszPath: PChar): BOOL; stdcall;

function LMDELSHGetPathFromIDList(pidl: PItemIDList; pszPathW: PWideChar; pszPath: PChar; var IsWideStr: Boolean): BOOL; stdcall;

implementation

const
  shell32 = 'shell32.dll';
  shlwapi = 'shlwapi.dll';

const
  idxSHChangeNotifyRegister = 2;
  idxSHChangeNotifyDeregister = 4;

var
  _SHChangeNotifyRegister: TSHChangeNotifyRegister;
  _SHChangeNotifyDeregister :TSHChangeNotifyDeregister;
  GFileSizeFormat: string = '';

function SHChangeNotifyRegister(hWnd: HWND; fSources: DWORD; wEventMask: Cardinal;
    wMsg: UINT; cEntries: DWORD; var Items: TSHChangeNotifyEntry): ULONG;
var
  hShell32: THandle;
begin
  Result := 0;
  if @_SHChangeNotifyRegister = nil then
  begin
    hShell32 := GetModuleHandle(shell32);
    if hShell32=0 then
      hShell32 := SafeLoadLibrary(shell32);
    if hShell32=0 then
      exit;
    _SHChangeNotifyRegister := GetProcAddress(hShell32, Int_Ref(idxSHChangeNotifyRegister));
    end;
  if @_SHChangeNotifyRegister <> nil then
  Result := _SHChangeNotifyRegister(hWnd, fSources, wEventMask, wMsg, cEntries, Items);
end;

function SHChangeNotifyDeregister(hNotify: ULONG): BOOL; stdcall;
var
  hShell32: THandle;
begin
  Result := False;
  if @_SHChangeNotifyDeregister=nil then
  begin
    hShell32 := GetModuleHandle(shell32);
    if hShell32=0 then
      hShell32 := SafeLoadLibrary(shell32);
    if hShell32=0 then
      exit;
    _SHChangeNotifyDeregister := GetProcAddress(hShell32, PChar(idxSHChangeNotifyDeregister));
    end;
  if @_SHChangeNotifyDeregister<>nil then
  Result := _SHChangeNotifyDeregister(hNotify);
end;

function LMDELSHGetPathFromIDList(pidl: PItemIDList; pszPathW: PWideChar; pszPath: PChar; var IsWideStr: Boolean): BOOL; stdcall;

var
  hShell32: THandle;
  LLMDELSHGetPathFromIDList : LMDELSHGetPathFromIDListProc;
  LLMDELSHGetPathFromIDListW : LMDELSHGetPathFromIDListProcW;
  begin
  Result := False;
  IsWideStr := True;
  hShell32 := GetModuleHandle(shell32);
  if hShell32=0 then
    hShell32 := SafeLoadLibrary(shell32);
  if hShell32=0 then
    exit;
  LLMDELSHGetPathFromIDListW := GetProcAddress(hShell32, 'SHGetPathFromIDListW');
  if @LLMDELSHGetPathFromIDListW = nil then
  begin
    LLMDELSHGetPathFromIDList := GetProcAddress(hShell32, 'SHGetPathFromIDList');
    if @LLMDELSHGetPathFromIDList <> nil then
    begin
      IsWideStr := False;
      Result := LLMDELSHGetPathFromIDList(pidl, pszPath);
    end;
  end
  else
    Result := LLMDELSHGetPathFromIDListW(pidl, pszPathW);
  end;

function SHGetFileInfoW; external shell32 name 'SHGetFileInfoW';

var

  ShellMalloc        :IMalloc;
  ShellDesktopFolder :IShellFolder;
  vShellIconCache    :TElShellIconCache;

const

  CSIDL_LOCAL_APPDATA     = $001C;
  CSIDL_ALTSTARTUP        = $001D;
  CSIDL_COMMON_ALTSTARTUP = $001E;
  CSIDL_COMMON_FAVORITES  = $001F;
  CSIDL_INTERNET_CACHE    = $0020;
  CSIDL_COOKIES           = $0021;
  CSIDL_HISTORY           = $0022;
  CSIDL_COMMON_APPDATA    = $0023;
  CSIDL_WINDOWS           = $0024;
  CSIDL_SYSTEM            = $0025;
  CSIDL_PROGRAM_FILES     = $0026;
  CSIDL_MYPICTURES        = $0027;
  CSIDL_PROFILE           = $0028;
  CSIDL_SYSTEMX86         = $0029;
  CSIDL_PROGRAM_FILESX86  = $002A;
  CSIDL_PROGRAM_FILES_COMMON = $002B;
  CSIDL_PROGRAM_FILES_COMMONX86 = $002C;
  CSIDL_COMMON_TEMPLATES  = $002D;
  CSIDL_COMMON_DOCUMENTS  = $002E;
  CSIDL_COMMON_ADMINTOOLS = $002F;
  CSIDL_ADMINTOOLS        = $0030;

  ShellFolderIDs: array[TShellFolders] of Integer=
   ($FEFE {cfoDesktopExpanded}, CSIDL_DESKTOP,
    CSIDL_PROGRAMS, CSIDL_CONTROLS, CSIDL_PRINTERS, CSIDL_PERSONAL, CSIDL_FAVORITES,
    CSIDL_STARTUP, CSIDL_RECENT, CSIDL_SENDTO, CSIDL_BITBUCKET, CSIDL_STARTMENU,
    CSIDL_DESKTOPDIRECTORY, CSIDL_DRIVES, CSIDL_NETWORK, CSIDL_NETHOOD, CSIDL_FONTS,
    CSIDL_TEMPLATES,
    { CSIDL_COMMON_* is for NT 4.0+ }
    CSIDL_COMMON_STARTMENU, CSIDL_COMMON_PROGRAMS, CSIDL_COMMON_STARTUP,
    CSIDL_COMMON_DESKTOPDIRECTORY, CSIDL_APPDATA, CSIDL_PRINTHOOD,

    // other:
    CSIDL_LOCAL_APPDATA, CSIDL_ALTSTARTUP, CSIDL_COMMON_ALTSTARTUP, CSIDL_COMMON_FAVORITES,
      CSIDL_INTERNET_CACHE, CSIDL_COOKIES, CSIDL_HISTORY, CSIDL_COMMON_APPDATA, CSIDL_WINDOWS,
      CSIDL_SYSTEM, CSIDL_PROGRAM_FILES, CSIDL_MYPICTURES, CSIDL_PROFILE, CSIDL_SYSTEMX86,
      CSIDL_PROGRAM_FILESX86, CSIDL_PROGRAM_FILES_COMMON, CSIDL_PROGRAM_FILES_COMMONX86,
      CSIDL_COMMON_TEMPLATES, CSIDL_COMMON_DOCUMENTS, CSIDL_COMMON_ADMINTOOLS, CSIDL_ADMINTOOLS,
    -1
    );

function GetFolderPIDL(FolderID: TShellFolders; const CustomName: TLMDString): PItemIDList;
begin
  if FolderID = sfoDesktopExpanded then
    FolderID := sfoDesktop;
  Result := GetFolderPIDL2(FolderID, CustomName);
end;

function GetFolderPIDL2(FolderID: TShellFolders; const CustomName: TLMDString): PItemIDList;
begin
  if FolderID = sfoCustom then
  begin
    if Length(CustomName)>0 then
      Result := GetPIDLFromPath(CustomName)
    else
      Result := nil;
  end
  else
  begin
    Result := nil;
    if (not Succeeded(SHGetSpecialFolderLocation(0, ShellFolderIDs[FolderID], Result))) and
       Assigned(Result)
    then
    begin
      FreeIDList(Result);
      Result := nil;
    end;
  end;
end;

procedure FreeIDList(var PIDL: PItemIDList);
begin
  if (PIDL<>nil)and Assigned(ShellMalloc) then
  begin
    if ShellMalloc.DidAlloc(PIDL) = 1 then
       ShellMalloc.Free(PIDL);
    PIDL := nil;
  end;
end;

function GetPathFromPIDL(PIDL: PItemIDList; var Path: TLMDString): Boolean;
var
  {$ifdef LMD_UNICODE}
  APathW: array [0..MAX_PATH] of WideChar;
  IsWideStr: Boolean;
  {$endif}
  APath: array [0..MAX_PATH] of char;
  begin
  if PIDL=nil then
  begin
    Path := '';
    Result := False;
    exit;
  end;
  {$ifdef LMD_UNICODE}
  if LMDSIWindowsNTUp then
  begin
    Result := LMDELSHGetPathFromIDList(PIDL, @APathW, @APath, IsWideStr);
    if Result then
      if IsWideStr then
        Path := LMDWideStrPas(@APathW)
      else
        Path := TLMDString(StrPas({$ifdef lmdcomp12}PAnsiChar{$endif}(@APath)))
    else
      Path := '';
  end
  else
  {$endif}
  begin
    Result := SHGetPathFromIDList(PIDL, @APath);
    if Result then
      Path := StrPas({$ifdef lmdcomp12}PWideChar{$endif}(@APath))
    else
      Path := '';
  end;
  end;

function  GetPathFromPIDL2(PIDL: PItemIDList): TLMDString;
begin
  GetPathFromPIDL(PIDL, Result);
end;

function GetPIDLFromPath(const Path: TLMDString): PItemIDList;
begin
  Result := SHGetPIDLFromPath(GetDesktopFolder, Path);
end;

function SHGetPIDLFromPath(const ShellFolder: IShellFolder; const Path: TLMDString): PItemIDList;
var

  WSP: PWideChar;

  Eaten, Attribs: TShellAttr;
begin
  Result := nil;
  if (ShellFolder=nil) or (Length(Path)=0) then
    exit;

//  WSP := nil;
  {$ifdef LMD_UNICODE}
  if LMDSIWindowsNTUp then
    WSP := PWideChar(Path)
  else
  begin
    GetMem(WSP, (Length(Path)+1) * SizeOf(WideChar));
    StringToWideChar(Path, WSP, (Length(Path)+1) * SizeOf(WideChar));
  end;
  {$else}
  begin
    GetMem(WSP, (Length(Path)+1) * SizeOf(WideChar));
    StringToWideChar(Path, WSP, (Length(Path)+1) * SizeOf(WideChar));
  end;
  {$endif}
  Attribs := 0;
  Eaten := 0;
  if not Succeeded(ShellFolder.ParseDisplayName(0, nil, WSP, Eaten, Result, Attribs)) then
    FreeIDList(Result);
  {$ifdef LMD_UNICODE}
  if not LMDSIWindowsNTUp then
  {$endif}
    FreeMem(WSP);
  end;

function IsDesktopPIDL(PIDL: PItemIDList):Boolean;
begin
  Result := (PIDL <> nil) and (PIDL.mkid.cb = 0);
  end;

function StrRetToPas(const str: TStrRet; PIDL: PItemIDList): TLMDString;
begin
  case Str.uType of
    STRRET_CSTR:
      Result := TLMDString(StrPas({$ifdef lmdcomp12}PAnsiChar{$endif}(@Str.cStr)));
      STRRET_OFFSET:
      Result := StrPas(PChar(PIDL) + Str.uOffset);
      STRRET_WSTR:
      if Assigned(Str.pOLEStr) then
        Result := {WideCharToString(}Str.pOLEStr
        else
        Result := '';
    else
        Result := '';
  end;
end;

function ShellExecutePIDL(PIDL: PItemIDList): Boolean;
var
  ShellExecuteInfo: TShellExecuteInfo;
begin
  if PIDL=nil then
  begin
    Result := False;
    exit;
  end;
  FillChar(ShellExecuteInfo, SizeOf(ShellExecuteInfo), 0);
  with ShellExecuteInfo do
  begin
    cbSize := SizeOf(ShellExecuteInfo);
    wnd := Application.Handle;
    fMask := SEE_MASK_IDLIST or SEE_MASK_INVOKEIDLIST;
    lpIDList := PIDL;
    nShow := SW_SHOW;
  end;
  Result := ShellExecuteEx(@ShellExecuteInfo);
  end;

function GetPIDLTypeName(PIDL: PItemIDList): TLMDString;
var
  {$ifdef LMD_UNICODE}
  FileInfoW: TSHFileInfoW;
  {$endif}
  FileInfoA: TSHFileInfoA;
  begin
  if PIDL=nil then
  begin
    Result := '';
    exit;
  end;
  {$ifdef LMD_UNICODE}
  if LMDSIWindowsNTUp then
  begin
    SHGetFileInfoW(PWideChar(PIDL), 0, FileInfoW, SizeOf(FileInfoW),
      SHGFI_PIDL or SHGFI_TYPENAME);
    Result := FileInfoW.szTypeName;
    end
  else
  {$endif}
  begin
    SHGetFileInfoA(PAnsiChar(PIDL), 0, FileInfoA, SizeOf(FileInfoA),
      SHGFI_PIDL or SHGFI_TYPENAME);
    Result := TLMDString(FileInfoA.szTypeName);
    end;
end;

function GetLastPIDL(PIDL: PItemIDList): PItemIDList;
begin
  repeat
    Result := PIDL;
    PIDL := GetNextItemID(Result);
  until (PIDL = nil) or (PIDL.mkid.cb = 0);
  end;

function GetDesktopFolder: IShellFolder;
begin
  if not Assigned(ShellDesktopFolder) then
    SHGetDesktopFolder(ShellDesktopFolder);
  Result := ShellDesktopFolder;
end;

function GetShellMalloc: IMalloc;
begin
  if not Assigned(ShellMalloc) then
    SHGetMalloc(ShellMalloc);
  Result := ShellMalloc;
end;

function GetShellFolder(PIDL: PItemIDList): IShellFolder;
begin
  if IsDesktopPIDL(PIDL) then
    Result := GetDesktopFolder
  else
  begin
    Result := nil;
    if PIDL<>nil then
      GetDesktopFolder.BindToObject(PIDL, nil, IID_IShellFolder, Pointer(Result));
      end;
end;

procedure StripLastPIDL(PIDL: PItemIDList);

begin
  if Assigned(PIDL) then
  begin
    GetLastPIDL(PIDL).mkid.cb := 0;
    end;
end;

function GetParentFolder(PIDL: PItemIDList): IShellFolder;
var
  PrevPIDL: PItemIDList;
begin
  PrevPIDL := ClonePIDL(PIDL);
  try
    StripLastPIDL(PrevPIDL);
    Result := GetShellFolder(PrevPIDL);
  finally
    FreeIDList(PrevPIDL);
  end;
end;

function ExecutePIDLContextMenuVerb(Handle: THandle; RelativePIDL: PItemIDList;
  const ParentFolder: IShellFolder; const Verb: String): Boolean;
var
  ContextMenu: IContextMenu;
  CMICI: TCMInvokeCommandInfo;
begin
  Result := Assigned(RelativePIDL) and (Length(Verb)>0);
  if not Result then
    exit;
  Result := ParentFolder.GetUIObjectOf(Handle, 1, RelativePIDL,
    IID_IContextMenu, nil, Pointer(ContextMenu)) = S_OK;
  if Result then
  begin
    FillChar(CMICI, SizeOf(CMICI), 0);
    with CMICI do
    begin
      cbSize := SizeOf(CMICI);
      hWnd := Handle;
      lpVerb := {$ifdef lmdcomp12}PAnsiChar(Int_Ref(Verb)){$else}(Int_RefA(Verb)){$endif};
      nShow := SW_SHOWNORMAL;
    end;
    Result := ContextMenu.InvokeCommand(CMICI) = S_OK;
  end;
end;

procedure StrRetFree(const str: TStrRet);

begin
  if (Str.uType = STRRET_WSTR) and (Str.pOLEStr <> nil) then
    CoTaskMemFree(Str.pOleStr);
  end;

type
  TElShellIconCacheEntry = record
    Name  :PChar;
    Idx   :Integer;
  end;
  PElShellIconCacheEntry = ^TElShellIconCacheEntry;
  constructor TElShellIconCache.Create;
  var
  {$ifdef _DoNotUseSystemCache_}
    Fl       :TShellAttr;
    FI       :TSHFileInfo;
    Flags    :Integer;
  const
    Mask     :array[Boolean] of Longint = (0, ILC_MASK);
  {$else}
    FileInfo :TSHFileInfo;
  {$endif}
begin
  inherited;
  FSmallImages := TCustomImageList.Create(nil);
  {$ifdef _DoNotUseSystemCache_}
  FSmallImages.Width := GetSystemMetrics(SM_CXSMICON);
  FSmallImages.Height := GetSystemMetrics(SM_CYSMICON);

  Flags := Mask[FSmallImages.Masked];
  if LMDSIWindowsXPUp then
    Flags := Flags or ILC_COLOR32
  else
    Flags := Flags or ILC_COLORDDB;

  FSmallImages.Handle := ImageList_Create(FSmallImages.Width, FSmallImages.Height, Flags, 16, 16);
  {$else}
  FSmallImages.ShareImages := True;
  FSmallImages.Handle := SHGetFileInfo(
    '', 0, FileInfo, SizeOf(FileInfo), SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  {$endif}
  FSmallImages.DrawingStyle := dsTransparent;

  {$ifdef _DoNotUseSystemCache_}
  FNames := TLMDObjectList.Create;

  FNames.OnDelete := OnItemDelete;

  Fl := SHGFI_SMALLICON or SHGFI_USEFILEATTRIBUTES or SHGFI_ICON;
  SHGetFileInfo('', 0, FI, SizeOf(FI), Fl);
  DefSmallIcon := FI.hIcon;

  Fl := SHGFI_LARGEICON or SHGFI_USEFILEATTRIBUTES or SHGFI_ICON;
  SHGetFileInfo('', 0, FI, SizeOf(FI), Fl);
  {$endif}
end;

destructor TElShellIconCache.Destroy;
begin
  {$ifdef _DoNotUseSystemCache_}
  DestroyIcon(DefSmallIcon);
  FNames.Free;
  {$endif}
  FSmallImages.Free;
  inherited;
end;

{$ifdef _DoNotUseSystemCache_}
procedure TElShellIconCache.OnItemDelete(Sender: TObject; var Item: TxListItem);
begin
  if PElShellIconCacheEntry(Item).Name <> nil then
    FreeMem(PElShellIconCacheEntry(Item).Name);
  FreeMem(Item);
end;
{$endif}

function TElShellIconCache.AddFromPIDL(PIDL: PItemIDList; Flags: TShellAttr; OpenIcon: Boolean): Integer;
var
  {$ifdef _DoNotUseSystemCache_}
    Fl : TShellAttr;
    FI : TSHFileInfo;
    Entry : PElShellIconCacheEntry;
    SmallIcon : HICON;
    S : String;
    i : Integer;
  {$else}
    FileInfo: TSHFileInfo;
  {$endif}
begin
{$ifdef _DoNotUseSystemCache_}
  Fl := SHGFI_SMALLICON;
  if OpenIcon then
    Fl := Fl or SHGFI_OPENICON;

  // get icon location
  SHGetFileInfo(PChar(PIDL),0, FI, SizeOf(FI), SHGFI_PIDL or SHGFI_ICONLOCATION or Fl);
  S := StrPas(FI.szDisplayName);
  i := FI.iIcon;
  SetLength(S, StrLen(PChar(S)));

  if OpenIcon then
    Fl := SHGFI_SMALLICON or SHGFI_OPENICON
  else
    Fl := SHGFI_SMALLICON;

  // get icons
  SHGetFileInfo(PChar(PIDL),0, FI, SizeOf(FI), SHGFI_PIDL or SHGFI_ICON or Fl);
  smallIcon := FI.hIcon;

  // allocate entry
  GetMem(Entry, SizeOf(TElShellIconCacheEntry));
  if Length(S) > 0 then
  begin
    GetMem(Entry.Name, Length(S) + 1);
    StrPCopy(Entry.Name, S);
  end
  else
    Entry.Name := nil;

  Entry.Idx := i;
  Result := FNames.Add(Entry);

  ImageList_AddIcon(FSmallImages.Handle, smallIcon);

  DestroyIcon(smallIcon);
{$else}
  Flags := SHGFI_PIDL or SHGFI_SYSICONINDEX;
  if OpenIcon then
    Flags := Flags or SHGFI_OPENICON;
  //if LargeIcon then
  //  Flags := Flags or SHGFI_LARGEICON
  //else
    Flags := Flags or SHGFI_SMALLICON;
  SHGetFileInfo(PChar(PIDL),
                0,
                FileInfo,
                SizeOf(FileInfo),
                Flags);
  Result := FileInfo.iIcon;
{$endif}
end;

function GetCompressedColor: Integer;
var
  Reg :TRegistry;
  B   :Boolean;
  begin
  if LMDSIWindowsNTUp then
  begin
    try
      reg := TRegistry.Create;
      try
        Result := RGB(0, 0, 255);
        B := Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced', False);
        if B then
        begin
          B := (Reg.ReadInteger('ShowCompColor') = 1);
          if B then
          begin
            B := Reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Explorer', False);
            if B and (not (Reg.ReadBinaryData('AltColor', Result, SizeOf(Result)) <> SizeOf(Result))) then
            Result := RGB(0, 0, 255);
            end;
        end;
      finally
        Reg.free;
      end;
    except
      Result := RGB(0, 0, 255);
    end;
  end
  else
    Result := RGB(0, 0, 255);
end;

function ShellIconCache: TElShellIconCache;
begin
  Result := vShellIconCache;
end;

function GetNextItemID(PIDL: PItemIDList):PItemIDList;
var
  cb: TShellAttr;
  begin
   if(PIDL = nil) then
   begin
     Result := nil;
     exit;
   end;
   try
     // Get the size of the specified item identifier.
     cb := PIDL.mkid.cb;
     // If the size is zero, it is the end of the list.
     if (cb = 0) then
     begin
       Result := nil;
       exit;
     end;

     // Add cb to pidl (casting to increment by bytes).
     PIDL := PItemIDList(TShellAttr(PIDL) + cb);
     if PIDL.mkid.cb = 0 then
     Result := nil
     else
        Result := PIDL;
   except
     Result := nil;
   end;
end;

function PIDLStartsWith(PIDL, SubPIDL: PItemIDList): Boolean;
var
  Size, SubSize: Integer;
begin
  Result := False;
  if (PIDL <> nil) and (SubPIDL <> nil) then
  begin
    Size := CalcPIDLSize(PIDL);
    SubSize := CalcPIDLSize(SubPIDL);
    if SubSize < Size then
      Result := CompareMem(PIDL, SubPIDL, SubSize - SizeOf(SubPIDL.mkid.cb));
      end;
end;

function PIDLContainsAt(PIDL, SubPIDL: PItemIDList; Pos: Integer): Boolean;
var
  Total: Integer;
  begin
  Result := False;
  if (PIDL <> nil) and (SubPIDL <> nil) then
  begin
    Total := 0;
    while (PIDL <> nil) do
    begin
      Inc(Total);
      if Pos = Total then
      begin
        if PIDL.mkid.cb = SubPIDL.mkid.cb then
          Result := CompareMem(@PIDL.mkid.abID, @SubPIDL.mkid.abID, SubPIDL.mkid.cb - SizeOf(SubPIDL.mkid.cb));
        break;
      end;
      PIDL := GetNextItemID(PIDL);
    end;
  end;
end;

function CalcPIDLSize(PIDL: PItemIDList): Integer;
var
  cbTotal: Integer;
begin
  cbTotal := 0;
  if PIDL <> nil then
  begin
    Inc(cbTotal, SizeOf(pidl.mkid.cb));
    while (pidl <> nil) do
    begin
      Inc(cbTotal, pidl.mkid.cb);
      pidl := GetNextItemID(pidl);
    end;
  end;
  Result := cbTotal;
end;

function CompareIDLists(IDList1, IDList2: PItemIDList): Boolean;
var
  i: Integer;
begin
  i := CalcPIDLSize(IDList1);
  if i <> CalcPIDLSize(IDList2) then
    Result := False
  else
    Result := CompareMem(IDList1, IDList2, i);
    end;

function ClonePIDL(PIDL: PItemIDList): PItemIDList;
var
  PIDLTemp: PItemIDList;
  cb: TShellAttr;
begin
  if PIDL = nil then
  begin
    Result := nil;
    exit;
  end;
  if Assigned(ShellMalloc) then
  begin
    cb := CalcPIDLSize(PIDL);
    PIDLTemp := ShellMalloc.alloc(cb);
    MoveMemory(PIDLTemp, PIDL, cb);
    Result := PIDLTemp;
  end
  else
    Result := nil;
end;

function GetOwnPIDL(PIDL: PItemIDList): PItemIDList;
var
  oldPIDL: PItemIDList;
begin
  oldPIDL := nil;
  while (PIDL <> nil) and (PIDL.mkid.cb > 0) do
  begin
    oldPIDL := PIDL;
    PIDL := PItemIDList(TLMDPtrInt(PIDL) + PIDL.mkid.cb);
    end;
  Result := oldPIDL;
end;

function GetEmptyPIDL: PItemIDList;

begin
  if Assigned(ShellMalloc) then
  begin
    Result := ShellMalloc.alloc(2);
    Result.mkid.cb := 0;
    end
  else
    Result := nil;
end;

function GetItemIDOnly(PIDL: PItemIDList): PItemIDList;
var
  pc: TLMDPtrUInt;
  begin
  if Assigned(ShellMalloc) then
  begin
    Result := ShellMalloc.Alloc(SizeOf(PIDL.mkid.cb) + PIDL.mkid.cb);
    MoveMemory(Result, PIDL, PIDL.mkid.cb);
    pc := TLMDPtrUInt(Result);
    inc(pc, PIDL.mkid.cb);
    PWord(pc)^ := 0;
    end
  else
    Result := nil;
end;

function AppendPIDL(ParentPIDL, ChildPIDL: PItemIDList): PItemIDList;
var
  pcb, ccb :TShellAttr;
begin
  if Assigned(ShellMalloc) then
  begin
    pcb := CalcPIDLSize(ParentPIDL);
    ccb := CalcPIDLSize(ChildPIDL);
    Result := ShellMalloc.alloc(pcb + ccb - SizeOf(ParentPIDL.mkid.cb));
    if pcb - SizeOf(ParentPIDL.mkid.cb) > 0 then
      MoveMemory(Result, ParentPIDL, pcb - SizeOf(ParentPIDL.mkid.cb));
    if ccb > 0 then
      MoveMemory(PItemIDList(TShellAttr(Result) + pcb  - SizeOf(ParentPIDL.mkid.cb)),
        ChildPIDL, ccb);
    end
  else
    Result := nil;
end;

function GetParentPIDL(PIDL: PItemIDList): PItemIDList;
var
  PIDLLast, PIDLTemp :PItemIDList;
  cb                 :TShellAttr;
  begin
  if Assigned(ShellMalloc) then
  begin
    PIDLLast := GetOwnPIDL(PIDL);
    if PIDLLast = nil then
    begin
      Result := ShellMalloc.alloc(2);
      Result.mkid.cb := 0;
      end
    else
    begin
      cb := TLMDPtrInt(PIDLLast) - TLMDPtrInt(PIDL) + SizeOf(PIDLTemp.mkid.cb);
      PIDLTemp := ShellMalloc.alloc(cb);
      MoveMemory(PIDLTemp, PIDL, cb);
      PItemIDList(TShellAttr(PIDLTemp) + cb - SizeOf(PIDLTemp.mkid.cb)).mkid.cb := 0;
      Result := PIDLTemp;
    end;
  end
  else
    Result := nil;
end;

function GetModule(const ModuleName: String): HMODULE;
begin
  Result := GetModuleHandle(Int_Ref(ModuleName));
  if Result < HINSTANCE_ERROR then
    Result := SafeLoadLibrary(Int_Ref(ModuleName));
  if (Result > 0) and (Result < HINSTANCE_ERROR) then
    Result := 0;
end;

{ SetAutoComplete }

var
  ShlWAPIModule: THandle;

type
  TSHAutoCompleteFunc = function(hwndEdit: HWND; dwFlags: DWord): LongInt; stdcall;
var
  SHAutoCompleteFunc: TSHAutoCompleteFunc;

function SetAutoComplete(Handle: THandle; bFileSystem, bURL: Boolean): Boolean;
  const
    SHACF_FILESYSTEM = $00000001;
    SHACF_URLHISTORY = $00000002;
    SHACF_URLMRU     = $00000004;
    SHACF_USETAB     = $00000008;
  const
    cFileSystem :array[Boolean] of Cardinal = (0, SHACF_FILESYSTEM);
    cURL        :array[Boolean] of Cardinal = (0, SHACF_URLHISTORY or SHACF_URLMRU);
  var
    Flags: Cardinal;
begin
  if Assigned(SHAutoCompleteFunc) then
  begin
    Flags := cFileSystem[bFileSystem] or cURL[bURL];
    if Flags <> 0 then
    begin
      Flags := Flags or SHACF_USETAB;
      Result := SHAutoCompleteFunc(Handle, Flags) = 0;
    end
    else
      Result := False;
  end
  else
    Result := False;
end;

function ElCreateShellLinkA(const sFileName, sShortcutTo,
  sWorkingDir, sArguments, sDescription,
  sIconFileName: TLMDString; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;
var
  Obj: IUnknown;
  {$ifdef LMD_UNICODE}
  SLW: IShellLinkW;
  {$endif}
  SL: IShellLinkA;
  PF: IPersistFile;
  WS: WideString;
begin
  Obj := CreateComObject(CLSID_ShellLink);
  {$ifdef LMD_UNICODE}
  if LMDSIWindowsNTUp then
  begin
    SLW := Obj as IShellLinkW;

    if (IDList=nil) then
      SLW.SetPath(Int_RefW(sShortcutTo));
    if sArguments <> '' then
      SLW.SetArguments(Int_RefW(sArguments));
    if sWorkingDir <> '' then
      SLW.SetWorkingDirectory(Int_RefW(sWorkingDir));
    if sDescription <> '' then
      SLW.SetDescription(Int_RefW(sDescription));
    if (sIconFileName <> '') and (IconIndex>0) then
      SLW.SetIconLocation(Int_RefW(sIconFilename), IconIndex);

    if Assigned(IDList) then
      SLW.SetIDList(IDList);

    if (fShowCmd = SW_SHOWNORMAL) or (fShowCmd  = SW_SHOWMAXIMIZED) or
       (fShowCmd = SW_SHOWMINNOACTIVE) then
      SLW.SetShowCmd(fShowCmd);
    if Hotkey<>0 then
      SLW.SetHotkey(Hotkey);
  end
  else
  {$endif}
  begin
    SL := Obj as IShellLinkA;

    if (IDList=nil) then
      SL.SetPath(Int_RefA(AnsiString(sShortcutTo)));
    if sArguments <> '' then
      SL.SetArguments(Int_RefA(AnsiString(sArguments)));
    if sWorkingDir <> '' then
      SL.SetWorkingDirectory(Int_RefA(AnsiString(sWorkingDir)));
    if sDescription <> '' then
      SL.SetDescription(Int_RefA(AnsiString(sDescription)));
    if (sIconFileName <> '') and (IconIndex>0) then
      SL.SetIconLocation(Int_RefA(AnsiString(sIconFilename)), IconIndex);
    if Assigned(IDList) then
      SL.SetIDList(IDList);

    if (fShowCmd = SW_SHOWNORMAL) or (fShowCmd  = SW_SHOWMAXIMIZED) or
       (fShowCmd = SW_SHOWMINNOACTIVE) then
      SL.SetShowCmd(fShowCmd);
    if Hotkey<>0 then
      SL.SetHotkey(Hotkey);
  end;

  PF := Obj as IPersistFile;
  WS := sFilename;
  Result := PF.Save(POleStr(WS), True) = S_OK;
  end;

function ElCreateShellLinkW(const wsFileName, wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: WideString; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;
var
  Obj: IUnknown;
  SL: IShellLinkW;
  PF: IPersistFile;
begin
  if not LMDSIWindowsNTUp then
    Result := ElCreateShellLinkA(wsFileName, wsShortcutTo,
      wsWorkingDir, wsArguments, wsDescription,
      wsIconFileName, IconIndex, IDList, fShowCmd, Hotkey )
  else
  begin
    Obj := CreateComObject(CLSID_ShellLink);
    SL := Obj as IShellLinkW;

    if (IDList=nil) then
      SL.SetPath(Int_Refw(wsShortcutTo));
    if wsArguments <> '' then
      SL.SetArguments(Int_Refw(wsArguments));
    if wsWorkingDir <> '' then
      SL.SetWorkingDirectory(Int_Refw(wsWorkingDir));
    if wsDescription <> '' then
      SL.SetDescription(Int_Refw(wsDescription));
    if (wsIconFileName <> '') and (IconIndex>0) then
      SL.SetIconLocation(Int_Refw(wsIconFilename), IconIndex);

    if Assigned(IDList) then
      SL.SetIDList(IDList);

    if (fShowCmd = SW_SHOWNORMAL) or (fShowCmd  = SW_SHOWMAXIMIZED) or
       (fShowCmd = SW_SHOWMINNOACTIVE) then
      SL.SetShowCmd(fShowCmd);
    if Hotkey<>0 then
      SL.SetHotkey(Hotkey);

    PF := Obj as IPersistFile;
    Result := PF.Save(POleStr(wsFilename), True) = S_OK;
    end;
end;

function ElCreateShellLink(const wsFileName, wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: TLMDString; IconIndex: Integer;
  IDList :PItemIDList; fShowCmd: Integer; Hotkey: TShortCut
  ):Boolean;
begin
  if LMDSIWindowsNTUp then
    Result := ElCreateShellLinkW(wsFileName, wsShortcutTo,
      wsWorkingDir, wsArguments, wsDescription,
      wsIconFileName, IconIndex, IDList, fShowCmd, Hotkey )
  else
    Result := ElCreateShellLinkA(wsFileName, wsShortcutTo,
      wsWorkingDir, wsArguments, wsDescription,
      wsIconFileName, IconIndex, IDList, fShowCmd, Hotkey );
end;

function ElReadShellLinkA(const wsFileName: WideString; var sShortcutTo,
  sWorkingDir, sArguments, sDescription,
  sIconFileName: TLMDString; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;
var
  Obj: IUnknown;
  {$ifdef LMD_UNICODE}
  SLW: IShellLinkW;
  {$endif}
  SL: IShellLinkA;
  PF: IPersistFile;
begin
  sShortcutTo := '';
  sWorkingDir := '';
  sArguments := '';
  sDescription := '';
  sIconFileName := '';
  IconIndex := -1;
  IDList := nil;
  fShowCmd := 0;
  Hotkey := 0;
  Obj := CreateComObject(CLSID_ShellLink);
  {$ifdef LMD_UNICODE}
  SLW := Obj as IShellLinkW;
  {$endif}

  SL := Obj as IShellLinkA;
  PF := Obj as IPersistFile;
  Result := PF.Load(POleStr(wsFilename), 0) = S_OK;
  if not Result then
    exit;
  //
  {$ifdef LMD_UNICODE}
  if LMDSIWindowsNTUp then
  begin
    SetLength(sShortcutTo, 1024);

    if SLW.GetPath(Int_RefW(sShortcutTo), Length(sShortcutTo),
       {$IFDEF LMDCOMP10}PWin32FindDataW(nil)^,{$ELSE}PWin32FindData(nil)^,{$ENDIF}
       SLGP_UNCPRIORITY) <> NOERROR then
    sShortcutTo := '';
    if LMDSIWindows2000Up then
      SetLength(sArguments, {CommCtrl.}INFOTIPSIZE)
    else
      SetLength(sArguments, Windows.MAX_PATH);
    if SLW.GetArguments(Int_RefWI(sArguments), Length(sArguments)) <> S_OK then
      sArguments := '';
    //
    SetLength(sWorkingDir, 1024);
    if SLW.GetWorkingDirectory(Int_RefWI(sWorkingDir), Length(sWorkingDir)) <> s_OK then
      sWorkingDir := '';
    //
    if LMDSIWindows2000Up then
      SetLength(sDescription, {CommCtrl.}INFOTIPSIZE)
    else
      SetLength(sDescription, Windows.MAX_PATH);
    if SLW.GetDescription(Int_RefWI(sDescription), Length(sDescription)) <> S_OK then
      sDescription := '';
    //
    SetLength(sIconFileName, 1024);
    if SLW.GetIconLocation(Int_RefWI(sIconFilename), Length(sIconFilename), IconIndex) <> S_OK then
      sIconFilename := '';
    //
    SLW.GetShowCmd(fShowCmd);
    //
    SLW.GetHotkey(WORD(Hotkey));
    //
    if bReadIDList then
      SLW.GetIDList(IDList);
  end
  else
  {$endif}
  begin
    SetLength(sShortcutTo, 1024);
    if SL.GetPath({$ifdef lmdcomp12}PAnsiChar(Int_Ref(String(sShortcutTo))){$else}(Int_RefA(String(sShortcutTo))){$endif}, Length(sShortcutTo),
       PWin32FindDataA(nil)^,
       SLGP_UNCPRIORITY) <> NOERROR then
      sShortcutTo := '';
    if LMDSIWindows2000Up then
      SetLength(sArguments, {CommCtrl.}INFOTIPSIZE)
    else
      SetLength(sArguments, Windows.MAX_PATH);
    if SL.GetArguments({$ifdef lmdcomp12}PAnsiChar(Int_Ref(String(sArguments))){$else}(Int_RefA(String(sArguments))){$endif}, Length(sArguments)) <> S_OK then
      sArguments := '';
    //
    SetLength(sWorkingDir, 1024);
    if SL.GetWorkingDirectory({$ifdef lmdcomp12}PAnsiChar(Int_Ref(String(sWorkingDir))){$else}(Int_RefA(String(sWorkingDir))){$endif}, Length(sWorkingDir)) <> s_OK then
      sWorkingDir := '';
    //
    if LMDSIWindows2000Up then
      SetLength(sDescription, {CommCtrl.}INFOTIPSIZE)
    else
      SetLength(sDescription, Windows.MAX_PATH);
    if SL.GetDescription({$ifdef lmdcomp12}PAnsiChar(Int_Ref(String(sDescription))){$else}(Int_RefA(String(sDescription))){$endif}, Length(sDescription)) <> S_OK then
      sDescription := '';
    //
    SetLength(sIconFileName, 1024);
    if SL.GetIconLocation({$ifdef lmdcomp12}PAnsiChar(Int_Ref(String(sIconFilename))){$else}(Int_RefA(String(sIconFilename))){$endif}, Length(sIconFilename), IconIndex) <> S_OK then
      sIconFilename := '';
    //
    SL.GetShowCmd(fShowCmd);
    //
    SL.GetHotkey(WORD(Hotkey));
    //
    if bReadIDList then
      SL.GetIDList(IDList);
  end;
end;

function ElReadShellLinkW(const wsFileName: WideString; var wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: WideString; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;
var
  Obj: IUnknown;
  SL: IShellLinkW;
  PF: IPersistFile;
  //
  sFileName, sShortcutTo, sWorkingDir,
  sArguments, sDescription, sIconFileName: TLMDString;
begin
  wsShortcutTo := '';
  wsWorkingDir := '';
  wsArguments := '';
  wsDescription := '';
  wsIconFileName := '';
  IconIndex := -1;
  IDList := nil;
  fShowCmd := 0;
  Hotkey := 0;
  if not LMDSIWindowsNTUp then
  begin
    Result := ElReadShellLinkA(sFileName, sShortcutTo,
      sWorkingDir, sArguments, sDescription,
      sIconFileName, IconIndex, bReadIDList, IDList, fShowCmd, Hotkey );
    wsShortcutTo := sShortcutTo;
    wsWorkingDir := sWorkingDir;
    wsArguments := sArguments;
    wsDescription := sDescription;
    wsIconFileName := sIconFileName;
  end
  else
  begin
    Obj := CreateComObject(CLSID_ShellLink);
    SL := Obj as IShellLinkW;
    PF := Obj as IPersistFile;
    Result := PF.Load(POleStr(wsFilename), 0) = S_OK;
    if not Result then
      exit;
    //
    SetLength(wsShortcutTo, 1024);
    wsShortcutTo[1]:=#0;
    //? AV:
    //if Assigned(FD) then
    //  SL.GetPath(PWideChar(wsShortcutTo), Length(wsShortcutTo), FD{^}, SLGP_UNCPRIORITY);
    //  SL.GetPath(nil, 0, WFD{^}, SLGP_UNCPRIORITY);
    if SL.GetPath(Int_RefWI(wsShortcutTo), Length(wsShortcutTo),
       {$IFDEF LMDCOMP10}PWin32FindDataW(nil)^,{$ELSE}PWin32FindData(nil)^,{$ENDIF}
       SLGP_UNCPRIORITY) <> NOERROR then
      wsShortcutTo := '';
    if LMDSIWindows2000Up then
      SetLength(wsArguments, {CommCtrl.}INFOTIPSIZE)
    else
      SetLength(wsArguments, Windows.MAX_PATH);
    if SL.GetArguments(Int_RefWI(wsArguments), Length(wsArguments)) <> S_OK then
      wsArguments := '';
    //
    SetLength(wsWorkingDir, 1024);
    if SL.GetWorkingDirectory(Int_RefWI(wsWorkingDir), Length(wsWorkingDir)) <> s_OK then
      wsWorkingDir := '';
    //
    if LMDSIWindows2000Up then
      SetLength(wsDescription, {CommCtrl.}INFOTIPSIZE)
    else
      SetLength(wsDescription, Windows.MAX_PATH);
    if SL.GetDescription(Int_RefWI(wsDescription), Length(wsDescription)) <> S_OK then
      wsDescription := '';
    //
    SetLength(wsIconFileName, 1024);
    if SL.GetIconLocation(Int_RefWI(wsIconFilename), Length(wsIconFilename), IconIndex) <> S_OK then
      wsIconFilename := '';
    //
    SL.GetShowCmd(fShowCmd);
    //
    SL.GetHotkey(WORD(Hotkey));
    //
    if bReadIDList then
      SL.GetIDList(IDList);
  end;
end;

function ElReadShellLink(const wsFileName: WideString; var wsShortcutTo,
  wsWorkingDir, wsArguments, wsDescription,
  wsIconFileName: WideString; var IconIndex: Integer;
  bReadIDList:Boolean; var IDList :PItemIDList; var fShowCmd: Integer; var Hotkey: TShortCut
  ):Boolean;
var
  sShortcutTo, sWorkingDir,
  sArguments, sDescription, sIconFileName: TLMDString;
begin
  if LMDSIWindowsNTUp then
    Result := ElReadShellLinkW(wsFileName, wsShortcutTo,
      wsWorkingDir, wsArguments, wsDescription,
      wsIconFileName, IconIndex, bReadIDList, IDList, fShowCmd, Hotkey )
  else
  begin
    Result := ElReadShellLinkA(wsFileName, sShortcutTo,
      sWorkingDir, sArguments, sDescription,
      sIconFileName, IconIndex, bReadIDList, IDList, fShowCmd, Hotkey );
    wsShortcutTo := sShortcutTo;
    wsWorkingDir := sWorkingDir;
    wsArguments := sArguments;
    wsDescription := sDescription;
    wsIconFileName := sIconFileName;
  end;
end;

function GetStrFromModule(Module: THandle; ResIdentifier: LongInt): string;
var
  Buffer: array[0..200] of Char;
begin
  Buffer[0] := #0;
  LoadString(Module, ResIdentifier, Buffer, SizeOf(Buffer));
  Result := Buffer;
end;

function ElGetFileSizeFormat: String;
begin
  if (GFileSizeFormat = '') then
    GFileSizeFormat := GetStrFromModule(ShlWAPIModule, 260);
  Result := GFileSizeFormat;
end;

initialization

  //WM_SHCHANGENOTIFY  := RegisterWindowMessage('{7EC0A8B0-F3CF-41E3-9345-C004F94A673F}');

  vShellIconCache    := TElShellIconCache.Create;
  GetShellMalloc;

  ShlWAPIModule      := GetModule(shlwapi);
  SHAutoCompleteFunc := GetProcAddress(ShlWAPIModule, 'SHAutoComplete');
  finalization

  try

    ShellDesktopFolder := nil;
    ShellMalloc := nil;
    vShellIconCache.Free;

    if ShlWAPIModule <> 0 then
      FreeLibrary(ShlWAPIModule);

  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElShellUtils: ' + e.Message);
    end;
  end;

end.
