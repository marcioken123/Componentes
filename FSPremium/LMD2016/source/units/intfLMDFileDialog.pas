unit intfLMDFileDialog;
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

intfLMDFileDialog unit (AH)
---------------------------
New Vista API dialogs

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDTypes,
  ActiveX,
  Classes,
  Windows;

{$HPPEMIT 'typedef DelphiInterface<IBindCtx> _di_IBindCtx;'}

const
  {$EXTERNALSYM OF_CAP_CANSWITCHTO}
  OF_CAP_CANSWITCHTO = 1;
  {$EXTERNALSYM OF_CAP_CANCLOSE}
  OF_CAP_CANCLOSE = 2;

  CLSID_IShellItem: TGUID = '{43826d1e-e718-42ee-bc55-a1e261c37bfe}';
  CLSID_FileOpenDialog: TGUID = '{DC1C5A9C-E88A-4dde-A5A1-60F82A20AEF7}';
  CLSID_FileSaveDialog: TGUID = '{C0B4E2F3-BA21-4773-8DBA-335EC946EB8B}';

  IID_FileOpenDialog: TGUID = '{d57c7288-d4ad-4768-be02-9d969532d960}';
  IID_FileSaveDialog: TGUID = '{84bccd23-5fde-4cdb-aea4-af64b83d78ab}';

  SID_IModalWindow       = '{b4db1657-70d7-485e-8e3e-6fcb5a5c1802}';
  SID_IEnumShellItems    = '{70629033-e363-4a28-a567-0db78006e6d7}';
  SID_IShellItem         = '{43826d1e-e718-42ee-bc55-a1e261c37bfe}';
  SID_IShellItemFilter   = '{2659B475-EEB8-48b7-8F07-B378810F48CF}';
  SID_IShellItemArray    = '{b63ea76d-1f85-456f-a19c-48159efa858b}';
  SID_IPropertyStore     = '{886d8eeb-8cf2-4446-8d02-cdba1dbdcf99}';
  SID_IPropertyDescriptionList = '{1f9fc1d0-c39b-4b26-817f-011967d3440e}';
  SID_IFileOperationProgressSink = '{04b0f1a7-9490-44bc-96e1-4296a31252e2}';
  SID_IFileDialogCustomize = '{e6fdd21a-163f-4975-9c8c-a69f1ba37034}';
  SID_IFileDialogEvents  = '{973510db-7d7f-452b-8975-74a85828d354}';
  SID_IFileDialogControlEvents = '{36116642-D713-4b97-9B83-7484A9D00433}';
  SID_IFileDialog        = '{42f85136-db7e-439c-85f1-e4075d135fc8}';
  SID_IFileOpenDialog    = '{d57c7288-d4ad-4768-be02-9d969532d960}';
  SID_IFileSaveDialog    = '{84bccd23-5fde-4cdb-aea4-af64b83d78ab}';

type
  IModalWindow = interface(IUnknown)
    [SID_IModalWindow]
  function Show(hwndParent : HWnd) : HResult; stdcall;
  end;

  tagFILE_USAGE_TYPE = (FUT_PLAYING, FUT_EDITING, FUT_GENERIC);
  FILE_USAGE_TYPE = tagFILE_USAGE_TYPE;

  IFileIsInUse = interface(IUnknown)
  ['{64a1cbf0-3a1a-4461-9158-376969693950}']
    function GetAppName(out ppszName: PWideChar): HRESULT; stdcall;
  function GetUsage(var pfut: FILE_USAGE_TYPE): HRESULT; stdcall;
    function GetCapabilities(var pdwCapFlags: DWORD): HRESULT; stdcall;
    function GetSwitchToHWND(var phwnd: HWND): HRESULT; stdcall;
    function CloseFile: HRESULT; stdcall;
  end;

const
  FDEOR_DEFAULT            = $00000000; // The application has not handled the event, and the dialog should put up UI asking the user
                                        // whether or not the file should be overwritten and be returned from the dialog
  FDEOR_ACCEPT             = $00000001; // The application has decided that the file should be returned from the dialog
  FDEOR_REFUSE             = $00000002; // The application has decided that the file should not be returned from the dialog

  FDESVR_DEFAULT           = $00000000; // The application has not handled the event.  The dialog will put up UI indicating the file
                                        // is in use, and a different file must be chosen.
  FDESVR_ACCEPT            = $00000001; // The application has decided that the file should be returned from the dialog
  FDESVR_REFUSE            = $00000002; // The application has decided that the file should not be returned from the dialog

  FDAP_BOTTOM              = $00000000; // The place is added to the bottom of the default list.
  FDAP_TOP                 = $00000001; // The place is added to the top of the default list.

  SIGDN_NORMALDISPLAY               = $00000000;
  SIGDN_PARENTRELATIVEPARSING       = $80018001;
  SIGDN_PARENTRELATIVEFORADDRESSBAR = $8001c001;
  SIGDN_DESKTOPABSOLUTEPARSING      = $80028000;
  SIGDN_PARENTRELATIVEEDITING       = $80031001;
  SIGDN_DESKTOPABSOLUTEEDITING      = $8004c000;
  SIGDN_FILESYSPATH                 = $80058000;
  SIGDN_URL                         = $80068000;

  SICHINT_DISPLAY   = $00000000; //iOrder based on display in a folder view
  SICHINT_ALLFIELDS = $80000000; //exact instance compare
  SICHINT_CANONICAL = $10000000; //iOrder based on canonical name (better performance)

//
// Implemented by the common file dialog browser, used by clients to
//  initialize, show, and get results from the dialog.
//
//
// Implemented by the common file dialog browser, used by clients to
//  initialize, show, and get results from the dialog.
//
const
  FOS_OVERWRITEPROMPT = $00000002;
  FOS_STRICTFILETYPES = $00000004;
  FOS_NOCHANGEDIR = $00000008;
  FOS_PICKFOLDERS = $00000020;
  FOS_FORCEFILESYSTEM = $00000040; // Ensure that items returned are filesystem items.
  FOS_ALLNONSTORAGEITEMS = $00000080; // Allow choosing items that have no storage.
  FOS_NOVALIDATE = $00000100;
  FOS_ALLOWMULTISELECT = $00000200;
  FOS_PATHMUSTEXIST = $00000800;
  FOS_FILEMUSTEXIST = $00001000;
  FOS_CREATEPROMPT = $00002000;
  FOS_SHAREAWARE = $00004000;
  FOS_NOREADONLYRETURN = $00008000;
  FOS_NOTESTFILECREATE = $00010000;
  FOS_HIDEMRUPLACES = $00020000;
  FOS_HIDEPINNEDPLACES = $00040000;
  FOS_NODEREFERENCELINKS = $00100000;
  FOS_DONTADDTORECENT = $02000000;
  FOS_FORCESHOWHIDDEN = $10000000;
  FOS_DEFAULTNOMINIMODE = $20000000;
  FOS_FORCEPREVIEWPANEON = $40000000;

const
  SHCONTF_INIT_ON_FIRST_NEXT  = $0100;   // allow EnumObject() to return before validating enum
  SHCONTF_NETPRINTERSRCH      = $0200;   // hint that client is looking for printers
  SHCONTF_SHAREABLE           = $0400;   // hint that client is looking sharable resources (remote shares)
  SHCONTF_STORAGE             = $0800;   // include all items with accessible storage and their ancestors

  CDCS_INACTIVE       = $00000000;
  CDCS_ENABLED        = $00000001;
  CDCS_VISIBLE        = $00000002;

type
  _COMDLG_FILTERSPEC = record
    pszName: PWideChar;
    pszSpec: PWideChar;
    end;
  COMDLG_FILTERSPEC = _COMDLG_FILTERSPEC;
  TComDlgFilterspec = COMDLG_FILTERSPEC;
  PComDlgFilterspec = ^TComDlgFilterspec;

  SIGDN = DWORD;
  SICHINTF = DWORD;
  SFGAOF = ULONG;

  SHCONTF = DWORD;

  IShellItem = interface(IUnknown)
    [SID_IShellItem]
  function BindToHandler(const pbc: IBindCtx; const bhid: TGUID;
      const riid: TIID; out ppv): HResult; stdcall;
    function GetParent(var ppsi: IShellItem): HResult; stdcall;
    function GetDisplayName(sigdnName: DWORD; var ppszName: LPWSTR): HResult; stdcall;
    function GetAttributes(sfgaoMask: DWORD; var psfgaoAttribs: DWORD): HResult; stdcall;
    function Compare(const psi: IShellItem; hint: DWORD;
      var piOrder: Integer): HResult; stdcall;
  end;

  IShellItemFilter = interface(IUnknown)
    [SID_IShellItemFilter]
  function GetEnumFlagsForItem(psi: IShellItem; var pgrfFlags: SHCONTF): HRESULT; stdcall;
    function IncludeItem(psi: IShellItem): HRESULT; stdcall;
  end;

type
  IFileDialog = interface;
  //
  // Implemented by a client of the common file dialog browser,
  //  for notification of events within the dialog.
  //
  IFileDialogEvents = interface(IUnknown)
    [SID_IFileDialogEvents]
  function OnFileOk(const pfd: IFileDialog): HRESULT; stdcall;
    function OnFolderChanging(const pfd: IFileDialog; const psiFolder: IShellItem): HRESULT; stdcall;
    function OnFolderChange(const pfd: IFileDialog): HRESULT; stdcall;
    function OnSelectionChange(const pfd: IFileDialog): HRESULT; stdcall;
    // Note: FOS_SHAREAWARE must be set in IFileDialog::SetOptions in order for this method to be called.
    function OnShareViolation(const pfd: IFileDialog; const psi: IShellItem; out pResponse: DWORD): HRESULT; stdcall;
    function OnTypeChange(const pfd: IFileDialog): HRESULT; stdcall;
    // Note: FOS_OVERWRITEPROMPT must be set in IFileDialog::SetOptions in order for this method to be called.
    function OnOverwrite(const pfd: IFileDialog; const psi: IShellItem; out pResponse: DWORD): HRESULT; stdcall;
  end;

// Some facts:
// - Controls are added before the dialog is shown.  Their relative layout is implied by the order in which
//    they are added. Controls may be added below or above the standard set of controls.
//    Controls can not be removed or added afterwards, but they may be hidden or disabled at any time.
//    Their labels may be changed at any time.
// - Some controls are container controls: combobox, toolsmenu, opendropdown, radiogroup.  These may have
//   items added to them.
// - Items with a container control are "immutable", except for their enabled/visible state.  They can be
//    added and removed at will.  There is no ability to position items within a container - they appear in the
//    order they were added.  IDs for items are scoped to their parent control.
// - Container controls have the notion of a "selected item", with the exception of the toolsmenu.
// - radiobuttongroups behave exactly like comboboxes.  The radio buttons within the group are treated exactly
//    like items in a combobox, one of which can be the "selected item".
  IFileDialogCustomize = interface(IUnknown)
    [SID_IFileDialogCustomize]
  // Methods for adding or enabling controls. All of these can have their
    // enabled/visible state set, however the default is for them to be enabled and visible,
    // so this parameter has been left off these methods.
    function EnableOpenDropDown(dwIDCtl: DWORD): HRESULT; stdcall;

    function AddMenu(dwIDCtl: DWORD; pszLabel: PWideChar): HRESULT; stdcall;
    function AddPushButton(dwIDCtl: DWORD; pszLabel: PWideChar): HRESULT; stdcall;
    function AddComboBox(dwIDCtl: DWORD): HRESULT; stdcall;
    function AddRadioButtonList(dwIDCtl: DWORD): HRESULT; stdcall;
    function AddCheckButton(dwIDCtl: DWORD; pszLabel: PWideChar; bChecked: BOOL): HRESULT; stdcall;
    function AddEditBox(dwIDCtl: DWORD; pszText: PWideChar): HRESULT; stdcall;
    function AddText(dwIDCtl: DWORD; pszText: PWideChar): HRESULT; stdcall;
    function AddSeparator(dwIDCtl: DWORD): HRESULT; stdcall;

    // Getting/setting attributes on controls on the fly
    function GetEditBoxText(dwIDCtl: DWORD; out ppszText: PWideChar): HRESULT; stdcall;
    function SetEditBoxText(dwIDCtl: DWORD; pszText: PWideChar): HRESULT; stdcall;
    function SetControlLabel(dwIDCtl: DWORD; pszLabel: PWideChar): HRESULT; stdcall;
    function GetControlState(dwIDCtl: DWORD; out pdwState: DWORD): HRESULT; stdcall;
    function SetControlState(dwIDCtl: DWORD; dwState: DWORD): HRESULT; stdcall;
    function GetCheckButtonState(dwIDCtl: DWORD; out pbChecked: BOOL): HRESULT; stdcall;
    function SetCheckButtonState(dwIDCtl: DWORD; bChecked: BOOL): HRESULT; stdcall;

    // Method for adding items to "container controls" (radiogroup, combobox, opendropdown, toolsmenu)
    function AddControlItem(dwIDCtl: DWORD;  dwIDItem: DWORD; pszLabel: PWideChar): HRESULT; stdcall;
    // Methods for removing items in the "container controls"
    function RemoveControlItem(dwIDCtl: DWORD; dwIDItem: DWORD): HRESULT; stdcall;
    function RemoveAllControlItems(dwIDCtl: DWORD): HRESULT; stdcall;

    // Getting/setting attributes on control items on the fly
    // Items are considered immutable once created, except for their state:
    function GetControlItemState(dwIDCtl: DWORD; dwIDItem: DWORD; out pdwState: DWORD): HRESULT; stdcall;
    function SetControlItemState(dwIDCtl: DWORD; dwIDItem: DWORD; dwState: DWORD): HRESULT; stdcall;

    // Methods for some "container controls": OpenDropDown, combobox, radiobuttongroup.
    // These methods don't apply to the tools menu.
    // These methods can be called after the dialog has closed, to determine the users final choice.
    // For comboboxes and radiobuttongroups, these methods may also be called while the
    // dialog is showing (which makes no sense for the OpenDropDown).
    function GetSelectedControlItem(dwIDCtl: DWORD; out pdwIDItem: DWORD): HRESULT; stdcall;
    function SetSelectedControlItem(dwIDCtl: DWORD; dwIDItem: DWORD): HRESULT; stdcall; // Not valid for OpenDropDown

    // Controls can be grouped by wrapping their adds in StartVisualGroup/EndVisualGroup
    // Groups have control IDs, and can be disabled/hidden, just like other controls.
    function StartVisualGroup(dwIDCtl: DWORD; pszLabel: PWideChar): HRESULT; stdcall; // Not valid for OpenDropDown
    function EndVisualGroup: HRESULT; stdcall; // Not valid for OpenDropDown

    // One control may be marked as appearing prominently in the UI
    function MakeProminent(dwIDCtl: DWORD): HRESULT; stdcall;
  end;

  // Event notifications from the controls, handled by an interface
  // optionally implemented by the same IFileDialogEvents object supplied by the app.
  IFileDialogControlEvents = interface(IUnknown)
    [SID_IFileDialogControlEvents]
  // An item in a combobox, toolsmenu, or radiobutton group was selected.
    // (this notification is *not* sent when an item is chosen from the open dropdown,
    //  as the action here is always the same: close the dialog as if the user clicked open.
    //  At that point, the app will then be able to call GetSelectedItem() for the open dropdown, to
    //  obtain the item that was chosen).
    function OnItemSelected(const pfdc: IFileDialogCustomize; dwIDCtl: DWORD; dwIDItem: DWORD): HRESULT; stdcall;
    // A pushbutton was clicked.
    function OnButtonClicked(const pfdc: IFileDialogCustomize; dwIDCtl: DWORD): HRESULT; stdcall;
    // A checkbutton was toggled.
    function OnCheckButtonToggled(const pfdc: IFileDialogCustomize; dwIDCtl: DWORD; bChecked: BOOL): HRESULT; stdcall;
    // A combobox, toolsmenu or open dropdown is about to be "dropped down".  At this point,
    // the application may want to update the contents based on the current state of the dialog.
    function OnControlActivating(const pfdc: IFileDialogCustomize; dwIDCtl: DWORD): HRESULT; stdcall;
  end;

  IFileDialog = interface(IModalWindow)
    [SID_IFileDialog]
    function SetFileTypes(cFileTypes: UINT; const rgFilterSpec: PComDlgFilterSpec): HRESULT; stdcall;
    function SetFileTypeIndex(iFileType: UINT): HResult; stdcall;
    function GetFileTypeIndex(var piFileType: UINT): HResult; stdcall;
    function Advise(const pfde: IFileDialogEvents; var pdwCookie: DWORD): HResult; stdcall;
    function Unadvise(dwCookie: DWORD): HResult; stdcall;
    function SetOptions(fos: DWORD): HResult; stdcall;
    function GetOptions(var pfos: DWORD): HResult; stdcall;
    function SetDefaultFolder(const psi: IShellItem): HResult; stdcall;
    function SetFolder(const psi: IShellItem): HResult; stdcall;
    function GetFolder(var ppsi: IShellItem): HResult; stdcall;
    function GetCurrentSelection(var ppsi: IShellItem): HResult; stdcall;
    function SetFileName(pszName: PWideChar): HRESULT; stdcall;
    function GetFileName(var pszName: PWideChar): HRESULT; stdcall;
    function SetTitle(pszTitle: PWideChar): HRESULT; stdcall;
    function SetOkButtonLabel(pszText: PWideChar): HRESULT; stdcall;
    function SetFileNameLabel(pszLabel: PWideChar): HRESULT; stdcall;
    function GetResult(var ppsi: IShellItem): HResult; stdcall;
    function AddPlace(const psi: IShellItem; fdap: DWORD): HResult; stdcall;
    function SetDefaultExtension(pszDefaultExtension: PWideChar): HRESULT; stdcall;
    function Close(hr: HResult): HResult; stdcall;
    function SetClientGuid(const guid: TGUID): HResult; stdcall;
    function ClearClientData: HResult; stdcall;
    function SetFilter(const pFilter: IShellItemFilter): HResult; stdcall;
  end;
//
// Additional methods specific to the file save dialog
//
  IFileSaveDialog = interface(IFileDialog)
    [SID_IFileSaveDialog]
  function SetSaveAsItem(psi: IShellItem): HRESULT; stdcall;
    function SetProperties(pStore: IUnknown): HRESULT; stdcall;
    function SetCollectedProperties(pList: IUnknown; fAppendDefault: BOOL): HRESULT; stdcall;
    function GetProperties(out ppStore: IUnknown): HRESULT; stdcall;
    function ApplyProperties(psi: IShellItem; pStore: IUnknown; hwnd: HWND; pSink: IUnknown): HRESULT; stdcall;
    end;

type
  IEnumShellItems = interface(IUnknown)
    [SID_IEnumShellItems]
  function Next(celt: UINT; out rgelt: IShellItem; var pceltFetched: DWORD): HResult; stdcall;
    function Skip(celt: UINT): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out ppenum: IEnumShellItems): HResult; stdcall;
  end;

  {$ifndef LMDCOMP11}
  _tagpropertykey = packed record
    fmtid: TGUID;
    pid: DWORD;
  end;
  TPropertyKey = _tagpropertykey;
  {$endif}

  IShellItemArray = interface(IUnknown)
    [SID_IShellItemArray]
  function BindToHandler(pbc : IBindCtx; const rbhid : TGUID; const riid : TIID; out ppvOut): HResult; stdcall;
    function GetPropertyStore(flags: DWORD; const riid: TIID; out ppv): HResult; stdcall;
    function GetPropertyDescriptionList(const keyType: TPropertyKey;
      const riid: TIID; out ppv): HResult; stdcall;
    function GetAttrributes(nEnum : integer; dwRequested : dword; out pdwResult : dword): HResult; stdcall;
    function GetCount(var pCount : UINT): HResult; stdcall;
    function GetItemAt(nIndex : uint; out ppItem : IShellItem) : HResult; stdcall;
    function EnumItems(var enumShellItems : IEnumShellItems): HResult; stdcall;
  end;

  //
  // Additional methods specific to the file open dialog
  // (adding multiselect capability)
  //
  IFileOpenDialog = interface(IFileDialog)
    [SID_IFileOpenDialog]
  function GetResults(out ppenum: IShellItemArray): HResult; stdcall;
    function GetSelectedItems(out ppsai: IShellItemArray): HResult; stdcall;
  end;

function SHCreateItemFromParsingName(pszPath: WideString; const pbc: IBindCtx; const riid: TIID; out ppv): HResult;

implementation

const
  Shell32 = 'shell32.dll';

var
  _SHCreateItemFromParsingName: function(pszPath: LPCWSTR; const pbc: IBindCtx;
    const riid: TIID; out ppv): HResult; stdcall;

function SHCreateItemFromParsingName(pszPath: WideString; const pbc: IBindCtx;
  const riid: TIID; out ppv): HResult;
var
  Shell32Lib: THandle;
begin
  if Assigned(_SHCreateItemFromParsingName) then
    Result := _SHCreateItemFromParsingName(PWideChar(pszPath), pbc, riid, ppv)
  else
  begin
    Shell32Lib := GetModuleHandle(shell32);
    Result := E_NOTIMPL;
    if Shell32Lib > 0 then
    begin
      // Do not localize
      _SHCreateItemFromParsingName := GetProcAddress(Shell32Lib, 'SHCreateItemFromParsingName');
      if Assigned(_SHCreateItemFromParsingName) then
        Result := _SHCreateItemFromParsingName(PWideChar(pszPath), pbc, riid, ppv);
      end;
  end;
end;

end.
