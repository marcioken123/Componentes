unit LMDVistaDialogs;
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

LMDVistaDialogs unit (AH)
-------------------------
New Vista API dialogs

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ActiveX, intfLMDFileDialog, Dialogs, LMDTypes, LMDSysIn, LMDRegExpr,
  LMDCustomComponent, LMDUnicodeDialogs, LMDStrings, LMDShUtils;

type
  TLMDCustomFileDialog = class;
  TLMDWideString = PWideChar;

  TLMDFileDialogOption = (fdoOverWritePrompt, fdoStrictFileTypes,
    fdoNoChangeDir, fdoPickFolders, fdoForceFileSystem,
    fdoAllNonStorageItems, fdoNoValidate, fdoAllowMultiSelect,
    fdoPathMustExist, fdoFileMustExist, fdoCreatePrompt,
    fdoShareAware, fdoNoReadOnlyReturn, fdoNoTestFileCreate,
    fdoHideMRUPlaces, fdoHidePinnedPlaces, fdoNoDereferenceLinks,
    fdoDontAddToRecent, fdoForceShowHidden,
    fdoDefaultNoMiniMode, fdoForcePreviewPaneOn);
  TLMDFileDialogOptions = set of TLMDFileDialogOption;

  TLMDFileDialogOverwriteResponse = (forDefault, forAccept, forRefuse);
  TLMDFileDialogShareViolationResponse = (fsrDefault, fsrAccept, fsrRefuse);

  TLMDFileDialogAddPlace = (fdapBottom, fdapTop);

  // FileDialog events
  TLMDFileDialogCloseEvent = procedure(Sender: TObject; var CanClose: Boolean) of object;
  TLMDFileDialogFolderChangingEvent = procedure(Sender: TObject; var CanChange: Boolean) of object;
  TLMDFileDialogOverwriteEvent = procedure(Sender: TObject; var Response: TLMDFileDialogOverwriteResponse) of object;
  TLMDFileDialogShareViolationEvent = procedure(Sender: TObject; var Response: TLMDFileDialogShareViolationResponse) of object;

  // Events for controls
  TLMDFileDialogItemSelected = procedure(Sender: TObject; dwIDCtl: Integer; dwIDItem: Integer) of object;
  TLMDFileDialogItemNotify = procedure(Sender: TObject; dwIDCtl: Integer) of object;
  TLMDFileDialogCheckButtonToggled = procedure(Sender: TObject; dwIDCtl: Integer; AChecked: Boolean) of object;

  TLMDFavoritePlace = class(TCollectionItem)
  private
    FLocation: TLMDString;
  protected
    function GetDisplayName: string; override;
    function GetIShellItem: IShellItem;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property Location: TLMDString read FLocation write FLocation;
  end;

  TLMDFavoritePlaces = class(TCollection)
  private
    function GetItem(Index: Integer): TLMDFavoritePlace;
    procedure SetItem(Index: Integer; const Value: TLMDFavoritePlace);
  public
    function Add: TLMDFavoritePlace;
    property Items[Index: Integer]: TLMDFavoritePlace read GetItem write SetItem;
  end;

  TLMDFileTypeItem = class(TCollectionItem)
  private
    FDisplayName: TLMDString;
    FFileMask: TLMDString;
  protected
    function GetDisplayName: string; override;
  public
    procedure Assign(Source: TPersistent); override;
  published
    property DisplayName: TLMDString read FDisplayName write FDisplayName;
    property FileMask: TLMDString read FFileMask write FFileMask;
  end;

  TLMDFileTypeItems = class(TCollection)
  private
    FNativeBuffer: PComDlgFilterspec;
    function GetItem(Index: Integer): TLMDFileTypeItem;
    procedure SetItem(Index: Integer; const Value: TLMDFileTypeItem);
    function GetOldFilter: TLMDString;
    procedure SetOldFilter(const Value: TLMDString);
  protected
    procedure AllocNativeBuffer;
    procedure FreeNativeBuffer;
    function FillNativeBuffer: PComDlgFilterspec;
  public
    function Add: TLMDFileTypeItem;
    property OldFilter: TLMDString read GetOldFilter write SetOldFilter;
    property Items[Index: Integer]: TLMDFileTypeItem read GetItem write SetItem;
  end;

  {$EXTERNALSYM TLMDFileDialogEvents} // ToDo Alex
  TLMDFileDialogEvents = class(TInterfacedObject, IFileDialogEvents, IFileDialogControlEvents)
  private
    FDialog: TLMDCustomFileDialog;
    FCookie: DWORD;
  public
    constructor Create(ADialog: TLMDCustomFileDialog);
    destructor Destroy; override;

    // IFileDialogEvents implementation
    function OnFileOk(const pfd: IFileDialog): HRESULT; stdcall;
    function OnFolderChanging(const pfd: IFileDialog; const psiFolder: IShellItem): HRESULT; stdcall;
    function OnFolderChange(const pfd: IFileDialog): HRESULT; stdcall;
    function OnSelectionChange(const pfd: IFileDialog): HRESULT; stdcall;
    // Note: FOS_SHAREAWARE must be set in IFileDialog::SetOptions in order for this method to be called.
    function OnShareViolation(const pfd: IFileDialog; const psi: IShellItem; out pResponse: DWORD): HRESULT; stdcall;
    function OnTypeChange(const pfd: IFileDialog): HRESULT; stdcall;
    // Note: FOS_OVERWRITEPROMPT must be set in IFileDialog::SetOptions in order for this method to be called.
    function OnOverwrite(const pfd: IFileDialog; const psi: IShellItem; out pResponse: DWORD): HRESULT; stdcall;

    // IFileDialogControlEvents implementation
    function OnItemSelected(const pfdc: IFileDialogCustomize; dwIDCtl: DWORD; dwIDItem: DWORD): HRESULT; stdcall;
    function OnButtonClicked(const pfdc: IFileDialogCustomize; dwIDCtl: DWORD): HRESULT; stdcall;
    function OnCheckButtonToggled(const pfdc: IFileDialogCustomize; dwIDCtl: DWORD; bChecked: BOOL): HRESULT; stdcall;
    function OnControlActivating(const pfdc: IFileDialogCustomize; dwIDCtl: DWORD): HRESULT; stdcall;
  end;

  TLMDCustomFileDialog = class(TLMDCustomComponent)
  private
    FFavoriteLinksPlace: TLMDFileDialogAddPlace;
    FFileTypeIndex: Cardinal;
    FClientGuid: string;
    FFavoriteLinks: TLMDFavoritePlaces;
    FOnFileOkClick: TLMDFileDialogCloseEvent;
    FOnFolderChanging: TLMDFileDialogFolderChangingEvent;
    FOptions: TLMDFileDialogOptions;
    FOnOverwrite: TLMDFileDialogOverwriteEvent;
    FOnShareViolation: TLMDFileDialogShareViolationEvent;
    FFileTypes: TLMDFileTypeItems;
    FOnExecute: TNotifyEvent;
    FOnFolderChange: TNotifyEvent;
    FOnSelectionChange: TNotifyEvent;
    FOnTypeChange: TNotifyEvent;
    FFileNameLabel: TLMDString;
    FDefaultFolder: TLMDString;
    FTitle: TLMDString;
    FOKButtonLabel: TLMDString;
    FFileName: TLMDString;
    FDefaultExt: TLMDString;
    FDialog: IFileDialog;
    FFiles: TLMDStrings;
    FHandle: HWnd;
    FShellItem: IShellItem;
    FShellItems: IShellItemArray;
    FOnItemSelected: TLMDFileDialogItemSelected;
    FOnButtonClicked: TLMDFileDialogItemNotify;
    FOnCheckButtonToggled: TLMDFileDialogCheckButtonToggled;
    FOnControlActivating: TLMDFileDialogItemNotify;
    procedure SetClientGuid(const Value: string);
    procedure SetDefaultExt(const Value: TLMDString);
    procedure SetDefaultFolder(const Value: TLMDString);
    procedure SetFileName(const Value: TLMDString);
    procedure SetFileNameLable(const Value: TLMDString);
    procedure SetFileTypeIndex(const Value: Integer);
    procedure SetOKButtonLabel(const Value: TLMDString);
    procedure SetOptions(const Value: TLMDFileDialogOptions);
    procedure SetTitle(const Value: TLMDString);
    function GetFileDialogCustomize: IFileDialogCustomize;
    procedure SetFavoriteLinks(const Value: TLMDFavoritePlaces);
    procedure SetFileTypes(const Value: TLMDFileTypeItems);
  protected
    procedure TriggerSelectionChange; virtual;
    function GetFileTypeIndex: Integer; virtual;

    // This methods, should be overrided in child class
    procedure CreateNativeDialog; virtual; abstract;
    procedure DestroyDialog; virtual; abstract;
    function ExecuteOldDialog(AParent: HWND): Boolean; virtual; abstract;

    function GetItemName(AShellItem: IShellItem; var AFileName: TLMDString): Boolean;
    function SelectionChange: HRESULT; virtual;
    function GetResults: Boolean; virtual;
    procedure TriggerExecute; virtual;
    function TriggerButtonClicked(dwIDCtl: Integer): Boolean; virtual;
    function TriggerItemSelected(dwIDCtl, dwIDItem: Integer): Boolean; virtual;
    function TriggerControlActivating(dwIDCtl: Integer): Boolean; virtual;
    function TriggerCheckButtonToogled(dwIDCtl: Integer; AChecked: Boolean): Boolean; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; overload; virtual;
    function Execute(AParent: HWND): Boolean; overload; virtual;
    property Dialog: IFileDialog read FDialog;
    property DialogCustomize: IFileDialogCustomize read GetFileDialogCustomize;
    property ClientGuid: string read FClientGuid write SetClientGuid;
    property DefaultExtension: TLMDString read FDefaultExt write SetDefaultExt;
    property DefaultFolder: TLMDString read FDefaultFolder write SetDefaultFolder;
    property FavoriteLinks: TLMDFavoritePlaces read FFavoriteLinks write SetFavoriteLinks;
    property FavoriteLinksPlace: TLMDFileDialogAddPlace read FFavoriteLinksPlace write FFavoriteLinksPlace default fdapBottom;
    property FileName: TLMDString read FFileName write SetFileName;
    property FileNameLabel: TLMDString read FFileNameLabel write SetFileNameLable;
    property FileTypeIndex: Integer read GetFileTypeIndex write SetFileTypeIndex;
    property FileTypes: TLMDFileTypeItems read FFileTypes write SetFileTypes;
    property Files: TLMDStrings read FFiles;
    property Handle: HWnd read FHandle;
    property OkButtonLabel: TLMDString read FOKButtonLabel write SetOKButtonLabel;
    property Options: TLMDFileDialogOptions read FOptions write SetOptions;
    property Title: TLMDString read FTitle write SetTitle;
    property ShellItem: IShellItem read FShellItem;
    property ShellItems: IShellItemArray read FShellItems;

    property OnExecute: TNotifyEvent read FOnExecute write FOnExecute;
    property OnFileOkClick: TLMDFileDialogCloseEvent read FOnFileOkClick write FOnFileOkClick;
    property OnFolderChange: TNotifyEvent read FOnFolderChange write FOnFolderChange;
    property OnFolderChanging: TLMDFileDialogFolderChangingEvent read FOnFolderChanging write FOnFolderChanging;
    property OnOverwrite: TLMDFileDialogOverwriteEvent read FOnOverwrite write FOnOverwrite;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnShareViolation: TLMDFileDialogShareViolationEvent read FOnShareViolation write FOnShareViolation;
    property OnTypeChange: TNotifyEvent read FOnTypeChange write FOnTypeChange;

    property OnItemSelected: TLMDFileDialogItemSelected read FOnItemSelected write FOnItemSelected;
    property OnButtonClicked: TLMDFileDialogItemNotify read FOnButtonClicked write FOnButtonClicked;
    property OnCheckButtonToggled: TLMDFileDialogCheckButtonToggled read FOnCheckButtonToggled write FOnCheckButtonToggled;
    property OnControlActivating: TLMDFileDialogItemNotify read FOnControlActivating write FOnControlActivating;
  end;

  TLMDCustomFileOpenDialog = class(TLMDCustomFileDialog)
  private
    FOpenDialog: TLMDOpenDialog;
    FExteranlDialog: Boolean;
    function EnumShellItems(LShellItems: IShellItemArray): HResult;
  protected
    function GetResults: Boolean; override;
    procedure CreateNativeDialog; override;
    procedure DestroyDialog; override;
    function ExecuteOldDialog(AParent: HWND): Boolean; override;
    function SelectionChange: HRESULT; override;
    property OpenDialog: TLMDOpenDialog read FOpenDialog write FOpenDialog;
  end;

  TLMDCustomFileSaveDialog = class(TLMDCustomFileDialog)
  private
    FSaveDialog: TLMDOpenDialog;
    FExternalDialog: Boolean;
  protected
    function GetFileTypeIndex: Integer; override;
    procedure CreateNativeDialog; override;
    procedure DestroyDialog; override;
    function ExecuteOldDialog(AParent: HWND): Boolean; override;
    property SaveDialog: TLMDOpenDialog read FSaveDialog write FSaveDialog;
  end;

  TLMDFileOpenDialog = class(TLMDCustomFileOpenDialog)
  published
    property About;
    property ClientGuid;
    property DefaultExtension;
    property DefaultFolder;
    property FavoriteLinks;
    property FavoriteLinksPlace;
    property FileName;
    property FileNameLabel;
    property FileTypes;
    property FileTypeIndex;
    property OkButtonLabel;
    property Options;
    property OpenDialog;
    property Title;
    property OnExecute;
    property OnFileOkClick;
    property OnFolderChange;
    property OnFolderChanging;
    property OnSelectionChange;
    property OnShareViolation;
    property OnTypeChange;
    property OnItemSelected;
    property OnButtonClicked;
    property OnCheckButtonToggled;
    property OnControlActivating;
  end;

  TLMDFileSaveDialog = class(TLMDCustomFileSaveDialog)
  published
    property About;
    property ClientGuid;
    property DefaultExtension;
    property DefaultFolder;
    property FavoriteLinks;
    property FavoriteLinksPlace;
    property FileName;
    property FileNameLabel;
    property FileTypes;
    property FileTypeIndex;
    property OkButtonLabel;
    property Options;
    property SaveDialog;
    property Title;
    property OnExecute;
    property OnFileOkClick;
    property OnFolderChange;
    property OnFolderChanging;
    property OnSelectionChange;
    property OnShareViolation;
    property OnTypeChange;
    property OnItemSelected;
    property OnButtonClicked;
    property OnCheckButtonToggled;
    property OnControlActivating;
  end;

implementation

{*************************** TLMDVistaFileDialog ******************************}
{------------------------------------------------------------------------------}
constructor TLMDCustomFileDialog.Create(AOwner: TComponent);
begin
  inherited;
  FFavoriteLinksPlace := fdapBottom;
  FFavoriteLinks := TLMDFavoritePlaces.Create(TLMDFavoritePlace);
  FFileTypes := TLMDFileTypeItems.Create(TLMDFileTypeItem);
  FFiles := TLMDMemoryStrings.Create;
  FDialog := nil;
  FShellItem := nil;
  FShellItems := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomFileDialog.Destroy;
begin
  FFavoriteLinks.Free;
  FFileTypes.Free;
  FDialog := nil;
  FShellItem := nil;
  FShellItems := nil;
  FFiles.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileDialog.Execute: Boolean;
var
  LParentWnd: HWND;
begin
  {$ifdef LMDCOMP11}
  if Application.ModalPopupMode <> pmNone then
  begin
    LParentWnd := Application.ActiveFormHandle;
    if LParentWnd = 0 then
      LParentWnd := Application.Handle;
  end
  else
  {$endif}
    LParentWnd := Application.Handle;
  Result := Execute(LParentWnd);
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileDialog.Execute(AParent: HWND): Boolean;
const
  CDialogOptions: array[TLMDFileDialogOption] of DWORD = (
    FOS_OVERWRITEPROMPT, FOS_STRICTFILETYPES, FOS_NOCHANGEDIR,
    FOS_PICKFOLDERS, FOS_FORCEFILESYSTEM, FOS_ALLNONSTORAGEITEMS,
    FOS_NOVALIDATE, FOS_ALLOWMULTISELECT, FOS_PATHMUSTEXIST,
    FOS_FILEMUSTEXIST, FOS_CREATEPROMPT, FOS_SHAREAWARE,
    FOS_NOREADONLYRETURN, FOS_NOTESTFILECREATE, FOS_HIDEMRUPLACES,
    FOS_HIDEPINNEDPLACES, FOS_NODEREFERENCELINKS,
    FOS_DONTADDTORECENT, FOS_FORCESHOWHIDDEN,
    FOS_DEFAULTNOMINIMODE, FOS_FORCEPREVIEWPANEON);
var
  LShellItem: IShellItem;
  LDialogOptions: Cardinal;
  i: Integer;
begin
  FHandle := AParent;
  CreateNativeDialog;
  try
    if Assigned(FDialog) and LMDSIWindowsVistaUp then
    begin
      if FClientGuid <> '' then
        FDialog.SetClientGuid(StringToGUID(FClientGuid));
      if FDefaultExt <> '' then
        FDialog.SetDefaultExtension(TLMDWideString(DefaultExtension));
      if FFileName <> '' then
        FDialog.SetFileName(TLMDWideString(FFileName));
      if FFileNameLabel <> '' then
        FDialog.SetFileNameLabel(TLMDWideString(FFileNameLabel));
      if FOKButtonLabel <> '' then
        FDialog.SetOkButtonLabel(TLMDWideString(FOKButtonLabel));
      if FTitle <> '' then
        FDialog.SetTitle(TLMDWideString(FTitle));

      if FDefaultFolder <> '' then
      begin
        if Succeeded(SHCreateItemFromParsingName(PLMDChar(FDefaultFolder), nil, CLSID_IShellItem, LShellItem)) then
          FDialog.SetFolder(LShellItem);
      end;

      LDialogOptions := 0;
      for i := Integer(Low(TLMDFileDialogOption)) to Integer(High(TLMDFileDialogOption)) do
        if TLMDFileDialogOption(i) in FOptions then
          LDialogOptions := LDialogOptions or CDialogOptions[TLMDFileDialogOption(i)];
      FDialog.SetOptions(LDialogOptions);

      if FFavoriteLinks.Count > 0 then
        for i := 0 to FFavoriteLinks.Count - 1 do
          FDialog.AddPlace(FFavoriteLinks.Items[i].GetIShellItem, TLMDPtrInt(FFavoriteLinksPlace));

      FDialog.SetFileTypeIndex(FFileTypeIndex);
      if FFileTypes.Count > 0 then
      begin
        FFileTypes.AllocNativeBuffer;
        try
          FDialog.SetFileTypes(FFileTypes.Count, FFileTypes.FillNativeBuffer);
          FDialog.SetFileTypeIndex(FFileTypeIndex + 1);
        finally
          FFileTypes.FreeNativeBuffer;
        end;
      end;

      with TLMDFileDialogEvents.Create(Self) do
      begin
        TriggerExecute;
        Result := Succeeded(Dialog.Show(AParent));
        if Result then
          Result := GetResults;
      end
    end
    else
      Result := ExecuteOldDialog(AParent);
  finally
    DestroyDialog;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileDialog.TriggerButtonClicked(dwIDCtl: Integer): Boolean;
begin
  Result := False;
  if Assigned(FOnButtonClicked) then
  begin
    FOnButtonClicked(Self, dwIDCtl);
    Result := True;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileDialog.TriggerCheckButtonToogled(dwIDCtl: Integer; AChecked: Boolean): Boolean;
begin
  Result := False;
  if Assigned(FOnCheckButtonToggled) then
  begin
    FOnCheckButtonToggled(Self, dwIDCtl, AChecked);
    Result := True;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileDialog.TriggerControlActivating(dwIDCtl: Integer): Boolean;
begin
  Result := False;
  if Assigned(FOnControlActivating) then
  begin
    FOnControlActivating(Self, dwIDCtl);
    Result := True;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileDialog.TriggerItemSelected(dwIDCtl, dwIDItem: Integer): Boolean;
begin
  Result := False;
  if Assigned(FOnItemSelected) then
  begin
    FOnItemSelected(Self, dwIDCtl, dwIDItem);
    Result := True;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.TriggerExecute;
begin
  if Assigned(FOnExecute) then
    FOnExecute(Self);
end;

procedure TLMDCustomFileDialog.TriggerSelectionChange;
begin
  if Assigned(FOnSelectionChange) then
    FOnSelectionChange(Self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileDialog.GetItemName(AShellItem: IShellItem; var AFileName: TLMDString): Boolean;
var
  LName: TLMDWideString;
begin
  Result := True;
  if Failed(AShellItem.GetDisplayName(SIGDN_FILESYSPATH, LName)) then
  begin
    if Failed(AShellItem.GetDisplayName(SIGDN_NORMALDISPLAY, LName)) then
    begin
      Result := False;
      exit;
    end;
  end;
  AFileName := LName;
  CoTaskMemFree(LName);
  end;

{------------------------------------------------------------------------------}
function TLMDCustomFileDialog.SelectionChange: HRESULT;
begin
  FFileName := '';
  Result := FDialog.GetCurrentSelection(FShellItem);
  if Succeeded(Result) then
  begin
    if GetItemName(FShellItem, FFileName) then
      TriggerSelectionChange;
  end;
  FShellItem := nil;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileDialog.GetResults: Boolean;
var
  LResult: HResult;
begin
  Result := False;
  LResult := FDialog.GetResult(FShellItem);
  if Succeeded(LResult) then
  begin
    Result := GetItemName(FShellItem, FFileName);
    FFiles.Clear;
    FFiles.Add(FFileName);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.SetClientGuid(const Value: string);
begin
  FClientGuid := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.SetDefaultExt(const Value: TLMDString);
begin
  FDefaultExt := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.SetDefaultFolder(const Value: TLMDString);
begin
  FDefaultFolder := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.SetFavoriteLinks(const Value: TLMDFavoritePlaces);
begin
  FFavoriteLinks.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.SetFileName(const Value: TLMDString);
begin
  FFileName := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.SetFileNameLable(const Value: TLMDString);
begin
  FFileNameLabel := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.SetFileTypeIndex(const Value: Integer);
begin
  FFileTypeIndex := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.SetFileTypes(const Value: TLMDFileTypeItems);
begin
  FFileTypes.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.SetOKButtonLabel(const Value: TLMDString);
begin
  FOKButtonLabel := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.SetOptions(const Value: TLMDFileDialogOptions);
begin
  FOptions := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileDialog.SetTitle(const Value: TLMDString);
begin
  FTitle := Value;
end;

{************************** TLMDFileDialogEvents ******************************}
{------------------------------------------------------------------------------}
constructor TLMDFileDialogEvents.Create(ADialog: TLMDCustomFileDialog);
begin
  inherited Create;
  FDialog := ADialog;
  if Assigned(FDialog.Dialog) then
    FDialog.Dialog.Advise(Self, FCookie);
end;

{------------------------------------------------------------------------------}
destructor TLMDFileDialogEvents.Destroy;
begin
  inherited;
  if Assigned(FDialog.Dialog) then
    FDialog.Dialog.Unadvise(FCookie);
end;

{------------------------------------------------------------------------------}
function TLMDFileDialogEvents.OnButtonClicked(const pfdc: IFileDialogCustomize; dwIDCtl: DWORD): HRESULT;
begin
  if FDialog.TriggerButtonClicked(dwIDCtl) then
    Result := S_OK
  else
    Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDFileDialogEvents.OnCheckButtonToggled(const pfdc: IFileDialogCustomize; dwIDCtl: DWORD; bChecked: BOOL): HRESULT;
begin
  if FDialog.TriggerCheckButtonToogled(dwIDCtl, bChecked) then
    Result := S_OK
  else
    Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDFileDialogEvents.OnControlActivating(const pfdc: IFileDialogCustomize; dwIDCtl: DWORD): HRESULT;
begin
  if FDialog.TriggerControlActivating(dwIDCtl) then
    Result := S_OK
  else
    Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDFileDialogEvents.OnItemSelected(const pfdc: IFileDialogCustomize; dwIDCtl, dwIDItem: DWORD): HRESULT;
begin
  if FDialog.TriggerItemSelected(dwIDCtl, dwIDItem) then
    Result := S_OK
  else
    Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDFileDialogEvents.OnFileOk(const pfd: IFileDialog): HRESULT;
var
  LCanClose: Boolean;
  LName: TLMDWideString;
  LShellItem: IShellItem;
  LPath: TLMDWideString;
begin
  pfd.GetFileName(LName);
  pfd.GetFolder(LShellItem);
  pfd.GetFileTypeIndex(FDialog.FFileTypeIndex);

  // the GetFileTypeIndex() call above is just useless after
  // other my changes, but do it, if you wish, though with
  // subsequent Dec(), as IFileDialog returns 1-based index.
  Dec(FDialog.FFileTypeIndex);

  LShellItem.GetDisplayName(SIGDN_FILESYSPATH, LPath);
  FDialog.FFileName := TLMDString(LPath) + PathDelim + LName;
  if Assigned(FDialog.FOnFileOkClick) then
  begin
    FDialog.FOnFileOkClick(FDialog, LCanClose);
    if LCanClose then
      Result := S_OK
    else
      Result := S_FALSE;
  end
  else
    Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDFileDialogEvents.OnFolderChange(const pfd: IFileDialog): HRESULT;
begin
  if Assigned(FDialog.FOnFolderChange) then
  begin
    FDialog.FOnFolderChange(FDialog);
    Result := S_OK;
  end
  else
    Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDFileDialogEvents.OnFolderChanging(const pfd: IFileDialog; const psiFolder: IShellItem): HRESULT;
var
  LCanChange: Boolean;
begin
  if Assigned(FDialog.FOnFolderChanging) then
  begin
    FDialog.FOnFolderChanging(FDialog, LCanChange);
    if LCanChange then
      Result := S_OK
    else
      Result := S_FALSE;
  end
  else
    Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDFileDialogEvents.OnOverwrite(const pfd: IFileDialog;
  const psi: IShellItem; out pResponse: DWORD): HRESULT;
var
  LResponse: TLMDFileDialogOverwriteResponse;
begin
  if Assigned(FDialog.FOnOverwrite) then
  begin
    FDialog.FOnOverwrite(FDialog, LResponse);
    pResponse := DWORD(LResponse);
    Result := S_OK;
  end
  else
    Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDFileDialogEvents.OnSelectionChange(const pfd: IFileDialog): HRESULT;
begin
  if Assigned(FDialog.FOnSelectionChange) then
    Result := FDialog.SelectionChange
  else
    Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDFileDialogEvents.OnShareViolation(const pfd: IFileDialog;
  const psi: IShellItem; out pResponse: DWORD): HRESULT;
var
  LResponse: TLMDFileDialogShareViolationResponse;
begin
  if Assigned(FDialog.FOnShareViolation) then
  begin
    FDialog.FOnShareViolation(FDialog, LResponse);
    pResponse := DWORD(LResponse);
    Result := S_OK;
  end
  else
    Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDFileDialogEvents.OnTypeChange(const pfd: IFileDialog): HRESULT;
var
  idx: UINT;
begin
  pfd.GetFileTypeIndex(idx);
  FDialog.FFileTypeIndex := idx - 1;

  if Assigned(FDialog.FOnTypeChange) then
  begin
    FDialog.FOnTypeChange(FDialog);
    Result := S_OK;
  end
  else
    Result := E_NOTIMPL;
end;

{**************************** TLMDFavoritePlace *******************************}
{------------------------------------------------------------------------------}
procedure TLMDFavoritePlace.Assign(Source: TPersistent);
begin
  if Source is TLMDFavoritePlace then
  begin
    FLocation := (Source as TLMDFavoritePlace).Location;
  end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
function TLMDFavoritePlace.GetDisplayName: string;
begin
  if FLocation = '' then
    Result := inherited GetDisplayName
  else
    Result := FLocation;
end;

{------------------------------------------------------------------------------}
function TLMDFavoritePlace.GetIShellItem: IShellItem;
begin
  SHCreateItemFromParsingName(PLMDChar(FLocation), nil, CLSID_IShellItem, Result);
end;

{**************************** TLMDFavoritePlaces ******************************}
{------------------------------------------------------------------------------}
function TLMDFavoritePlaces.Add: TLMDFavoritePlace;
begin
  Result := TLMDFavoritePlace(inherited Add);
end;

{------------------------------------------------------------------------------}
function TLMDFavoritePlaces.GetItem(Index: Integer): TLMDFavoritePlace;
begin
  Result := TLMDFavoritePlace(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}
procedure TLMDFavoritePlaces.SetItem(Index: Integer; const Value: TLMDFavoritePlace);
begin
  inherited SetItem(Index, Value);
end;

{****************************** TLMDFileTypeItem ******************************}
{------------------------------------------------------------------------------}
procedure TLMDFileTypeItem.Assign(Source: TPersistent);
begin
  if Source is TLMDFileTypeItem then
  begin
    FDisplayName := (Source as TLMDFileTypeItem).DisplayName;
    FFileMask := (Source as TLMDFileTypeItem).FileMask;
  end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
function TLMDFileTypeItem.GetDisplayName: string;
begin
  if FDisplayName = '' then
    Result := inherited GetDisplayName
  else
    Result := FDisplayName;
end;

{***************************** TLMDFileTypeItems ******************************}
{------------------------------------------------------------------------------}
function TLMDFileTypeItems.Add: TLMDFileTypeItem;
begin
  Result := TLMDFileTypeItem(inherited Add);
end;

{------------------------------------------------------------------------------}
function TLMDFileTypeItems.GetItem(Index: Integer): TLMDFileTypeItem;
begin
  Result := TLMDFileTypeItem(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}
procedure TLMDFileTypeItems.AllocNativeBuffer;
begin
  GetMem(FNativeBuffer, Count * SizeOf(TComDlgFilterspec));
end;

{------------------------------------------------------------------------------}
function TLMDFileTypeItems.FillNativeBuffer: PComDlgFilterspec;
var
  LTemp: PComDlgFilterspec;
  i: Integer;
begin
  LTemp := FNativeBuffer;
  Result := FNativeBuffer;
  try
    for i := 0 to Count - 1 do
    begin
      LTemp^.pszName := TLMDWideString(Items[i].FDisplayName);
      LTemp^.pszSpec := TLMDWideString(Items[i].FFileMask);
      inc(LTemp);
    end;
  except
    Result := nil;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFileTypeItems.FreeNativeBuffer;
begin
  FreeMem(FNativeBuffer);
end;

{------------------------------------------------------------------------------}
function TLMDFileTypeItems.GetOldFilter: TLMDString;
var
  i: Integer;
  LFilter: String;
begin
  LFilter := '';
  for i := 0 to Count - 1 do
  begin
    if LFilter <> '' then
      LFilter := LFilter + '|';
    LFilter := LFilter + Items[i].DisplayName + '|' + Items[i].FileMask;
  end;
  Result := LFilter;
end;

{------------------------------------------------------------------------------}
procedure TLMDFileTypeItems.SetOldFilter(const Value: TLMDString);
var
  P, Start: PLMDChar;
  LDisplayName, LFileMask: TLMDString;
begin
  P := PLMDChar(Value);
  if P <> nil then
  begin
    while P^ <> #0 do
    begin
      Start := P;
      while not ((P^ = '|') or (P^ = #0)) do
        Inc(P);
      if (LDisplayName = '') then
        LMDSetString(LDisplayName, Start, P - Start)
      else if (LFileMask = '') then
      begin
        LMDSetString(LFileMask, Start, P - Start);
        with Add() do
        begin
          DisplayName := LDisplayName;
          FileMask := LFileMask;
        end;
        LDisplayName := '';
        LFileMask := '';
      end;
      if (P^ = '|') then
        Inc(P);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFileTypeItems.SetItem(Index: Integer; const Value: TLMDFileTypeItem);
begin
  SetItem(Index, Value);
end;

{------------------------------------------------------------------------------}
function OptionsConverter(AOptions: TLMDFileDialogOptions): TOpenOptions;
const
  CDialogOptions: array[TLMDFileDialogOption] of TOpenOptions = (
    [ofOverwritePrompt], [ofExtensionDifferent], [ofNoChangeDir], [] {fdoPickFolders},
    [] {fdoForceFileSystem}, [] {fdoAllNonStorageItems}, [ofNoValidate],
    [ofAllowMultiSelect], [ofPathMustExist], [ofFileMustExist], [ofCreatePrompt],
    [ofShareAware], [ofNoReadOnlyReturn], [ofNoTestFileCreate], [] {fdoHideMRUPlaces},
    [] {fdoHidePinnedPlaces}, [ofNoDereferenceLinks],
    [ofDontAddToRecent], [ofForceShowHidden],
    [] {fdoDefaultNoMiniMode}, []);
var
  LOption: TLMDFileDialogOption;
begin
  Result := [ofEnableSizing];
  for LOption := Low(TLMDFileDialogOption) to High(TLMDFileDialogOption) do
  begin
    if LOption in AOptions then
      Result := Result + CDialogOptions[LOption];
  end;
end;

{****************************** TLMDFileOpenDialog ****************************}
{------------------------------------------------------------------------------}
procedure TLMDCustomFileOpenDialog.CreateNativeDialog;
begin
  if LMDSIWindowsVistaUp then
    CoCreateInstance(CLSID_FileOpenDialog, nil, CLSCTX_INPROC_SERVER, IFileOpenDialog, FDialog)
  else
  begin
    if Assigned(FOpenDialog) then
      FExteranlDialog := True
    else
    begin
      if (fdoForcePreviewPaneOn in Options) then
        FOpenDialog := TLMDOpenPictureDialog.Create(Owner)
      else
        FOpenDialog := TLMDOpenDialog.Create(Owner);
      FExteranlDialog := False;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileOpenDialog.DestroyDialog;
begin
  if LMDSIWindowsVistaUp then
    FDialog := nil
  else
    if not FExteranlDialog then
      FreeAndNil(FOpenDialog);
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileOpenDialog.ExecuteOldDialog(AParent: HWND): Boolean;
begin
  Result := False;
  if Assigned(FOpenDialog) then
  begin
    if not FExteranlDialog then
      with FOpenDialog do
      begin
        Filter := FFileTypes.GetOldFilter;
        FilterIndex := FFileTypeIndex + 1;

        Title := Self.Title;
        DefaultExt := DefaultExtension;
        InitialDir := DefaultFolder;
        FileName := Self.FileName;
        Options := OptionsConverter(Self.Options);

        if Assigned(FOnFileOkClick) then
          OnCanClose := FOnFileOkClick;
        if Assigned(FOnFolderChange) then
          OnFolderChange := FOnFolderChange;
        if Assigned(FOnSelectionChange) then
          OnSelectionChange := FOnSelectionChange;
        if Assigned(FOnTypeChange) then
          OnTypeChange := FOnTypeChange;
      end;

    {$ifdef LMDCOMP9}
    Result := FOpenDialog.Execute(AParent);
    {$else}
    Result := FOpenDialog.Execute;
    {$endif}
    if Result then
    begin
      FileName := FOpenDialog.FileName;
      Files.Assign(FOpenDialog.Files);
      FileTypeIndex := FOpenDialog.FilterIndex - 1;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileOpenDialog.GetResults: Boolean;
var
  LShellItems: IShellItemArray;
begin
  FFiles.Clear;
  if fdoAllowMultiSelect in Options then
  begin
    (FDialog as IFileOpenDialog).GetResults(LShellItems);
    Result := EnumShellItems(LShellItems) = S_OK;
  end
  else
    Result := inherited GetResults;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileOpenDialog.SelectionChange: HRESULT;
begin
  if fdoAllowMultiSelect in Options then
  begin
    Result := (FDialog as IFileOpenDialog).GetSelectedItems(FShellItems);
    if Succeeded(Result) then
    begin
      Result := EnumShellItems(FShellItems);
      if Succeeded(Result) then
      begin
        FDialog.GetCurrentSelection(FShellItem);
        TriggerSelectionChange;
      end;
    end;
  end
  else
    Result := inherited SelectionChange;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileOpenDialog.EnumShellItems(LShellItems: IShellItemArray): HResult;
var
  LShellItem: IShellItem;
  LCount: Cardinal;
  LEnumerator: IEnumShellItems;
  LResult: HRESULT;
begin
  LShellItems.EnumItems(LEnumerator);
  Result := LEnumerator.Next(1, LShellItem, LCount);
  LResult := Result;
  while Succeeded(LResult) and (LCount > 0) do
  begin
    GetItemName(LShellItem, FFileName);
    FFiles.Add(FFileName);
    LResult := LEnumerator.Next(1, LShellItem, LCount);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileDialog.GetFileDialogCustomize: IFileDialogCustomize;
begin
  Result := nil;
  if Assigned(FDialog) then
    Result := (FDialog as IFileDialogCustomize);
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileDialog.GetFileTypeIndex: Integer;
begin
  Result := FFileTypeIndex;
  if Assigned(FDialog) then
  begin
    if (FDialog.GetFileTypeIndex(FFileTypeIndex) = S_OK) then
    begin
      dec(FFileTypeIndex); // returned value isn't zero based
      Result := FFileTypeIndex;
    end;
  end;
end;

{************************ TLMDCustomFileSaveDialog ****************************}
{------------------------------------------------------------------------------}
procedure TLMDCustomFileSaveDialog.CreateNativeDialog;
begin
  if LMDSIWindowsVistaUp then
  begin
    CoCreateInstance(CLSID_FileSaveDialog, nil, CLSCTX_INPROC_SERVER, IFileSaveDialog, FDialog);
    end
  else
  begin
    if Assigned(FSaveDialog) then
      FExternalDialog := True
    else
    begin
      if (fdoForcePreviewPaneOn in Options) then
        FSaveDialog := TLMDSavePictureDialog.Create(Owner)
      else
        FSaveDialog := TLMDSaveDialog.Create(Owner);
      FExternalDialog := False;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomFileSaveDialog.DestroyDialog;
begin
  if LMDSIWindowsVistaUp then
    FDialog := nil
  else
    if not FExternalDialog then
      FreeAndNil(FSaveDialog);
end;

{------------------------------------------------------------------------------}
function TLMDCustomFileSaveDialog.ExecuteOldDialog(AParent: HWND): Boolean;
begin
  Result := False;
  if Assigned(FSaveDialog) then
  begin
    if not FExternalDialog then
      with FSaveDialog do
      begin
        Filter := FFileTypes.GetOldFilter;
        FilterIndex := FFileTypeIndex + 1;

        Title := Self.Title;
        DefaultExt := DefaultExtension;
        InitialDir := DefaultFolder;
        FileName := Self.FileName;
        Options := OptionsConverter(Self.Options);

        if Assigned(FOnFileOkClick) then
          OnCanClose := FOnFileOkClick;
        if Assigned(FOnFolderChange) then
          OnFolderChange := FOnFolderChange;
        if Assigned(FOnSelectionChange) then
          OnSelectionChange := FOnSelectionChange;
        if Assigned(FOnTypeChange) then
          OnTypeChange := FOnTypeChange;
      end;

    {$ifdef LMDCOMP9}
    Result := FSaveDialog.Execute(AParent);
    {$else}
    Result := FSaveDialog.Execute;
    {$endif}
    if Result then
    begin
      FileName := FSaveDialog.FileName;
      Files.Assign(FSaveDialog.Files);
      FileTypeIndex := FSaveDialog.FilterIndex - 1;
    end;
  end;
end;

function TLMDCustomFileSaveDialog.GetFileTypeIndex: Integer;
begin
  if Assigned(FSaveDialog) then
    Result := FSaveDialog.FilterIndex - 1
  else
    Result := inherited GetFileTypeIndex;
end;

end.
