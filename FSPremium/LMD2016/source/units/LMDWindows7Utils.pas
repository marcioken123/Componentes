unit LMDWindows7Utils;
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

LMDWindows7Utils unit (AH)
--------------------------
Missing declarations for Windows 7

Changes
-------
Release 10.0 (October 2009)
 - Initial Release

###############################################################################}

interface

uses
{$ifdef LMDCOMP14}
  ActiveX;
{$else}
  Windows, ShlObj, Classes, CommCtrl, ActiveX, LMDSysIn;

const
  CLSID_TaskbarList:  TGUID = '{56FDF344-FD6D-11d0-958A-006097C9A090}';
  CLSID_PropertyStore: TGUID = '{886d8eeb-8cf2-4446-8d02-cdba1dbdcf99}';
  CLSID_IObjectArray: TGUID = '{92CA9DCD-5622-4BBA-A805-5E9F541BD8C9}';
  CLSID_ICustomDestinationList: TGUID = '{6332DEBF-87B5-4670-90C0-5E57B408A49E}';
  CLSID_IObjectCollection: TGUID = '{5632B1A4-E38A-400A-928A-D4CD63230295}';

  SID_ITaskbarList = '{56FDF344-FD6D-11d0-958A-006097C9A090}';
  SID_ITaskbarList2 = '{602D4995-B13A-429b-A66E-1935E44F4317}';
  SID_ITaskbarList3 = '{EA1AFB91-9E28-4B86-90E9-9E9F8A5EEFAF}';
  SID_ITaskbarList4 = '{C43DC798-95D1-4BEA-9030-BB99E2983A1A}';
  SID_IPropertyStore = '{886d8eeb-8cf2-4446-8d02-cdba1dbdcf99}';
  SID_IObjectArray = '{92CA9DCD-5622-4BBA-A805-5E9F541BD8C9}';
  SID_ICustomDestinationList = '{6332DEBF-87B5-4670-90C0-5E57B408A49E}';
  SID_IObjectCollection = '{5632B1A4-E38A-400A-928A-D4CD63230295}';

  IID_ITaskbarList: TGUID = SID_ITaskbarList;
  IID_ITaskbarList2: TGUID = SID_ITaskbarList2;
  IID_ITaskbarList3: TGUID = SID_ITaskbarList3;
  IID_ITaskbarList4: TGUID = SID_ITaskbarList4;

  KDC_FREQUEST = 1;
  KDC_RECENT = 2;

type
  STPFLAG = (
    STPF_NONE = $00000000,
    STPF_USEAPPTHUMBNAILALWAYS  = $00000001,
    STPF_USEAPPTHUMBNAILWHENACTIVE  = $00000002,
    STPF_USEAPPPEEKALWAYS = $00000004,
    STPF_USEAPPPEEKWHENACTIVE = $00000008
  );
  TStpFlag = STPFLAG;

  TBPFLAG = (
    TBPF_NOPROGRESS = $00000000,
    TBPF_INDETERMINATE = $00000001,
    TBPF_NORMAL = $00000002,
    TBPF_ERROR = $00000004,
    TBPF_PAUSED = $00000008
  );
  TTBPFFlag = TBPFLAG;

  THUMBBUTTONFLAGS = (
    THBF_ENABLED = $00000000,
    THBF_DISABLED = $00000001,
    THBF_DISMISSONCLICK = $00000002,
    THBF_NOBACKGROUND = $00000004,
    THBF_HIDDEN = $00000008,
    THBF_NONINTERACTIVE = $00000010
  );
  TThumbButtonFlags = THUMBBUTTONFLAGS;

  THUMBBUTTONMASK = (
    THB_BITMAP = $00000001,
    THB_ICON = $00000002,
    THB_TOOLTIP = $00000004,
    THB_FLAGS = $00000008
  );
  TThumbButtonMask = THUMBBUTTONMASK;

  THUMBBUTTON = record
    dwMask: TThumbButtonMask;
    iId: Cardinal;
    iBitmap: Cardinal;
    hIcon: HICON;
    szTip: packed array[0..259] of WideChar;
    dwFlags: TThumbButtonFlags;
  end;
  PThumbButton = ^TThumbButton;
  TThumbButton = THUMBBUTTON;

{$ifndef LMDCOMP10}
  _tagpropertykey = packed record
    fmtid: TGUID;
    pid: DWORD;
  end;
  {$EXTERNALSYM PROPERTYKEY}
  PROPERTYKEY = _tagpropertykey;
  PPropertyKey = ^TPropertyKey;
  TPropertyKey = _tagpropertykey;
{$endif}

{$ifndef LMDCOMP7}
  UInt64 = Int64;
{$endif}

const
  PKEY_AppUserModel_ID: TPropertyKey = (fmtid: '{9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}'; pid: 5);

type
  ITaskbarList = interface(IUnknown)
    [SID_TaskbarList]
    function HrInit: HResult; stdcall;
    function AddTab(hwnd: Cardinal): HResult; stdcall;
    function DeleteTab(hwnd: Cardinal): HResult; stdcall;
    function ActivateTab(hwnd: Cardinal): HResult; stdcall;
    function SetActiveAlt(hwnd: Cardinal): HResult; stdcall;
  end;

  ITaskbarList2 = interface(ITaskbarList)
    [SID_TaskbarList2]
    function MarkFullscreenWindow(wnd : HWND; fFullscreen : bool) : HResult; stdcall;
  end;

  ITaskbarList3 = interface(ITaskbarList2)
    [SID_TaskbarList3]
    function RegisterTab(hwndTab: HWND; hwndMDI: HWND): HResult; stdcall;
    function SetOverlayIcon(hwnd: HWND; hIcon: HICON; pszDescription: PWideChar): HResult; stdcall;
    function SetProgressState(hwnd: HWND; flags: TTBPFFlag): HResult; stdcall;
    function SetProgressValue(hwnd: HWND; ullCompleted: UInt64; ullTotal: UInt64): HResult; stdcall;
    function SetTabActive(hwndTab: HWND; hwndMDI: HWND; dwReserved: DWORD): HResult; stdcall;
    function SetTabOrder(hwndTab: HWND; hwndInsertBefore: HWND): HResult; stdcall;

    function SetThumbnailClip(hwnd: HWND; prcClip: PRect): HResult; stdcall;
    function SetThumbnailTooltip(hwnd: HWND; pszTip: PWideChar): HResult; stdcall;

    function ThumbBarAddButtons(hwnd: HWND; cButtons: Cardinal; pButton: PThumbButton): HResult; stdcall;
    function ThumbBarSetImageList(hwnd: HWND; cButtons: Cardinal; himl: HIMAGELIST): HResult; stdcall;
    function ThumbBarUpdateButtons(hwnd: HWND; cButtons: Cardinal; pButton: PThumbButton): HResult; stdcall;

    function UnregisterTab(hwndTab: HWND): HResult; stdcall;
  end;

  ITaskbarList4 = interface(ITaskbarList3)
    [SID_TaskbarList4]
    function AbortList(): HResult; stdcall;
    function SetTabProperties(hwndTab: HWND; stpFlags: TStpFlag): HResult; stdcall;
  end;

  IObjectArray = interface(IUnknown)
    [SID_ObjectArray]
    function GetAt(uiIndex: Cardinal; const riid: TIID; out ppv): HREsult; stdcall;
    function GetCount(var pcObjects: Cardinal): HResult; stdcall;
  end;

  ICustomDestinationList = interface(IUnknown)
    [SID_CustomDestinationList]
    function AddUserTasks(const poa: IObjectArray): HResult; stdcall;
    function AppendCategory(pszCategory: PWideChar; const poa: IObjectArray): HResult; stdcall;
    function AppendKnownCategory(category: Integer): HResult; stdcall;
    function BeginList(const pcMinSlots: Cardinal; riid: TIID; out ppv): HResult; stdcall;
    function CommitList(): HResult; stdcall;
    function DeleteList(pszAppID: PWideChar): HResult; stdcall;
    function GetRemovedDestinations(riid: TIID; out ppv): HResult; stdcall;
    function SetAppID(pszAppID: PWideChar): HResult; stdcall;
  end;

{$ifndef LMDCOMP10}
  IPropertyStore = interface(IUnknown)
    [SID_PropertyStore]
    function Commit: HResult; stdcall;
    function GetAt(iProp: DWORD; out pkey: TPropertyKey): HResult; stdcall;
    function GetCount(out cProps: DWORD): HResult; stdcall;
    function GetValue(const key: TPropertyKey; out pv: TPropVariant): HResult; stdcall;
    function SetValue(const key: TPropertyKey; const propvar: TPropVariant): HResult; stdcall;
  end;
{$endif}

var
  WM_TASKBARBUTTONCREATED: Cardinal;

{$EXTERNALSYM GetCurrentProcessExplicitAppUserModelID}
function GetCurrentProcessExplicitAppUserModelID(var AppID: PWideChar): HRESULT;
{$EXTERNALSYM SetCurrentProcessExplicitAppUserModelID}
function SetCurrentProcessExplicitAppUserModelID(const AppID: PWideChar): HRESULT;
{$EXTERNALSYM SHGetPropertyStoreForWindow}
function SHGetPropertyStoreForWindow(hwnd: HWND; riid: TIID; out ppv): HRESULT;
{$endif}

function InitPropVariantFromString(psz: PWideChar; var PropVar: TPropVariant): HRESULT;

implementation

function InitPropVariantFromString(psz: PWideChar; var PropVar: TPropVariant): HRESULT;
begin
  try
    PropVar.vt := VT_BSTR;
    PropVar.bstrVal := SysAllocString(psz);
    Result := S_OK;
  except
    SysFreeString(PropVar.bstrVal);
    Result := E_UNEXPECTED;
  end;
end;

{$ifndef LMDCOMP14}
var
  GetCurrentProcessExplicitAppUserModelIDProto: function(var AppID: PWideChar): HRESULT; stdcall;
  SetCurrentProcessExplicitAppUserModelIDProto: function(const AppID: PWideChar): HRESULT; stdcall;
  SHGetPropertyStoreForWindowProto: function(hwnd: HWND; riid: TIID; out ppv): HRESULT; stdcall;

function GetCurrentProcessExplicitAppUserModelID(var AppID: PWideChar): HRESULT;
begin
  if Assigned(GetCurrentProcessExplicitAppUserModelIDProto) then
    Result := GetCurrentProcessExplicitAppUserModelIDProto(AppID)
  else
    Result := E_NOTIMPL;
end;

function SetCurrentProcessExplicitAppUserModelID(const AppID: PWideChar): HRESULT;
begin
  if Assigned(SetCurrentProcessExplicitAppUserModelIDProto) then
    Result := SetCurrentProcessExplicitAppUserModelIDProto(AppID)
  else
    Result := E_NOTIMPL;
end;

function SHGetPropertyStoreForWindow(hwnd: HWND; riid: TIID; out ppv): HRESULT;
begin
  if Assigned(SHGetPropertyStoreForWindowProto) then
    Result := SHGetPropertyStoreForWindowProto(hwnd, riid, ppv)
  else
    Result := E_NOTIMPL;
end;

var
  CShell32Handle: THandle;

initialization
  CShell32Handle := LoadLibrary('shell32.dll');
  if CShell32Handle <> 0 then
  begin
    GetCurrentProcessExplicitAppUserModelIDProto := GetProcAddress(CShell32Handle, 'GetCurrentProcessExplicitAppUserModelID');
    SetCurrentProcessExplicitAppUserModelIDProto := GetProcAddress(CShell32Handle, 'SetCurrentProcessExplicitAppUserModelID');
    SHGetPropertyStoreForWindowProto := GetProcAddress(CShell32Handle, 'SHGetPropertyStoreForWindow');
  end;
  if LMDSIWindowsWindows7 then
    WM_TASKBARBUTTONCREATED := RegisterWindowMessage('TaskbarButtonCreated');
{$endif}

end.
