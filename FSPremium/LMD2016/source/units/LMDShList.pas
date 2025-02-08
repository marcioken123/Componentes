unit LMDShList;
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

LMDShList unit (DS)
------------------------
Contains shell virtual List View


Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Dialogs, Classes, Comctrls, Graphics, Controls, Commctrl, Messages,
  ExtCtrls, ActiveX, ShlObj, Menus, UxTheme,
  LMDShBase, LMDShView, LMDShFolder, LMDShMisc, LMDShPIDL, LMDShItem, LMDControl,
  LMDTypes, LMDSysIn;

const
  LMDWM_Refresh = WM_USER + 9374;
  LMDWM_AdjustColumns = LMDWM_Refresh + 1;

type

  {****************************************************************************}
  TLMDShellList = class;

  {****************************************************************************}
  TLMDShellListOption = (loShowHidden, loShowFolders, loShowNonFolders,
                         loAllowRename, loAllowDrag, loAllowDrop,
                         loColorCompressed, loExtendedMenu, loOpenFoldersInNewWindow,
                         loShellMenu, loSortTypeByExt, loUseSuppressFolderNavigation);
  TLMDShellListOptions = set of TLMDShellListOption;

  {****************************************************************************}
  { only for old cpb }
  TLMDShellListItem = class(TListItem)
  private
    fIndex: integer;
    function GetShellItem: TLMDShellItem;
  public
    property ShellItem: TLMDShellItem read GetShellItem;
  end;

  {****************************************************************************}
  TLMDShellListCustomColumn = class(TCollectionItem)
  private
    FDataType: TLMDShellItemDetailsColumn;
    FAutoSize: Boolean;
    FTag: Integer;
    FCaption: string;
    FAlignment: TAlignment;
    FMinWidth: TWidth;
    FMaxWidth: TWidth;
    FWidth: TWidth;
    FImageIndex: LongInt;
    FVisible: boolean;
    FDefaultColumn: boolean;
    FColID: integer;
    procedure SetDataType(const Value: TLMDShellItemDetailsColumn);
    function IsWidthStored: Boolean;
    procedure SetAlignment(const Value: TAlignment);
    procedure SetAutoSize(const Value: Boolean);
    procedure SetCaption(const Value: string);
    procedure SetMaxWidth(const Value: TWidth);
    procedure SetMinWidth(const Value: TWidth);
    procedure SetWidth(const Value: TWidth);
{$HINTS OFF}
    function IsCaptionStored: Boolean;
{$HINTS ON}
    procedure SetImageIndex(const Value: LongInt);
    procedure SetVisible(const value: boolean);
    procedure SetDefaultColumn(const value: boolean);
  protected
    function GetDisplayName: string; override;
    procedure DoChange;
    procedure Store(const aPath: string);
    procedure Restore(const aPath: string);
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(Collection: TCollection); override;
    function GetText(aItem: TLMDCustomShellItem): string;
    procedure SetDefaultWidth;
    property  ColID: integer read FColID write FColID;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property DataType: TLMDShellItemDetailsColumn read FDataType write SetDataType;
    //Caption after DataType    
	property Caption: string read FCaption write SetCaption;
    property ImageIndex: LongInt read FImageIndex write SetImageIndex default -1;
    property MaxWidth: TWidth read FMaxWidth write SetMaxWidth default 0;
    property MinWidth: TWidth read FMinWidth write SetMinWidth default 0;
    property Tag: Integer read FTag write FTag default 0;
    property Width: TWidth read FWidth write SetWidth stored IsWidthStored default -1;
    property Visible: boolean read FVisible write SetVisible default False;
    property DefaultColumn: boolean read FDefaultColumn write SetDefaultColumn default True;
  end;

  {****************************************************************************}
  TLMDShellListCustomColumns = class(TOwnedCollection)
  private
    FColumnChanged: boolean;
    FLockUpdates: integer;
    function GetListView: TLMDShellList;
    function GetItem(Index: Integer): TLMDShellListCustomColumn;
    procedure SetItem(Index: Integer; const Value: TLMDShellListCustomColumn);
  protected
    procedure Update(Item: TCollectionItem); override;
    procedure SetColumnChanged;
    procedure DoChange;
    procedure Store(const aPath: string);
    procedure Restore(const aPath: string);
    property ListView: TLMDShellList read GetListView;
  public
    constructor Create(aOwner: TLMDShellList);
    destructor Destroy; override;
    function Owner: TPersistent;
    procedure BeginUpdates;
    procedure EndUpdates;
    procedure CreateDefaultColumns;
    property Items[Index: LongInt]: TLMDShellListCustomColumn read GetItem write SetItem; default;
  end;

  {****************************************************************************}
  TLMDShellList = class(TLMDBaseListView, IUnknown,
                        IDropTarget, ILMDShellView, ILMDShellEdit)
  private
    { property variables }
    FHighlightedHeaderItem: Integer;
    FShellFolder: TLMDShellFolder;
    FShellItems: TLMDShellItems;
    FItemsCache: TLMDShellItemsList;
    FCompressedColor: TColor;
    FFileFilter: TStringList;
    FFiltered: Boolean;
    FFilterDirs: Boolean;
    FOptions: TLMDShellListOptions;
    FShowCheckBoxes: Boolean;
    FSortDirection: TLMDShellSortDirection;
    FViewStyle: TViewStyle;
    FColumns: TLMDShellListCustomColumns;
    FStoreSettings: boolean;
    FRegistryPath: string;
    FDefaultColumns: boolean;
    FNewHeaderProc: Pointer;
    FOldHeaderProc: Pointer;

    { internal variables }
    FOldSortDirection: TLMDShellSortDirection;
    FOldColumn: integer;
    FClickedColumn: integer;
    FStateImages: TImageList;
    FHeaderHandle: HWND;
    FHeaderID: LongInt;
    FEnumOptions: TLMDShellEnumOptions;
    FClickPoint: TPoint;
    FDataObject: IDataObject;
    FDropTargetItem: string;
    FFileSystemSort: boolean;
    FPopup: TPopupMenu;
    FTempIcon: TIcon;

    { V2.0 }
    FAutoContext: boolean;
    FAutoSortSupport: boolean;
    FOnSelectionInfo: TLMDShellInfoEvent;
    FShowOverlayIcon: boolean;

    { events }
    FOnFilterItem: TLMDShellItemFilter;
    FOnItemDblClick: TLMDShellItemEvent;
    FOnItemSelected: TLMDShellItemEvent;

    RootPid, OldFolder: PItemIDList;
    FSuppressDefaultAction: Boolean;
    FSuppressFolderNavigation: Boolean;
    FRefreshTimer: TTimer;
//    FAutoSizeNameColumn: Boolean;

    { property methods }
    procedure SetShellFolder(const aValue: TLMDShellFolder);
    procedure SetCompressedColor(const aValue: TColor);
    function GetFileFilter: string;
    procedure SetFileFilter(const aValue: string);
    procedure SetFiltered(const aValue: boolean);
    procedure SetFilterDirs(const aValue: boolean);
    procedure SetOptions(const aValue: TLMDShellListOptions);
    procedure SetShowCheckBoxes(const aValue: boolean);
    procedure SetSortDirection(const aValue: TLMDShellSortDirection);
    procedure SetDefaultColumns(const aValue: boolean);
    function GetCheckedCount: integer;
    function GetCheckedItem(index: integer): TLMDCustomShellItem;
    function GetSelectedItems(index: integer): TLMDCustomShellItem;
    function GetShellItem(Item: TListItem): TLMDCustomShellItem;
    function GetSelectedItem: TLMDCustomShellItem;

    procedure SetCustomColumns(const value: TLMDShellListCustomColumns);
    procedure SetShowOverlayIcon(value: boolean);

    { internal methods }
    procedure FilterShellItems;
    procedure SortShellItems;
    procedure RepaintEx;
    procedure UpdateEx;
    //    procedure EnumColumns;
    procedure ClearLists;
    procedure EnumItems;
    procedure DrawHeaderItem(const PDIS: TDrawItemStruct);
    procedure DrawOverlayItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; Stage: TCustomDrawStage; var DefaultDraw:
      Boolean);
    procedure LMDWMRefresh(var Msg: TMessage); message LMDWM_Refresh;
    procedure NeedRefresh;
    procedure SelectionChange(Item: TListItem; Selected: Boolean);
    procedure UpdateSelectionInfo;
    procedure ApplyFilter;
    procedure RefreshTimerFire(Sender: TObject);
    procedure FakeReadMethod(Reader: TReader);
    function  MakeSelectedList(IncludeParent: Boolean = False): TLMDShellPIDLS;
    procedure AdjustColumnWidth;

    procedure CNNotify(var Message: TWMNotify); message CN_Notify;

//    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMParentNotify(var Message: TWMParentNotify); message
      WM_PARENTNOTIFY;
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
    procedure LMDWMAdjustColumns(var Message: TMessage); message LMDWM_AdjustColumns;
    procedure SetSuppressDefaultAction(const Value: Boolean);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function OwnerDataStateChange(StartIndex, EndIndex: Integer; OldState,
            NewState: TItemStates): Boolean; override;
    procedure DoFilterItem(const aItem: TLMDCustomShellItem;
            var aAccept: Boolean); virtual;
    procedure SetViewStyle(aValue: TViewStyle); override;
    { base class methods }
    function CreateListItem: TListItem; override;
    function CanEdit(Item: TListItem): Boolean; override;
    procedure Click; override;
    procedure DblClick; override;
    procedure ColClick(Column: TListColumn); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure Edit(const Item: TLVItem); override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change(Item: TListItem; Change: Integer); override;

    procedure HeaderWndProc(var Message: TMessage); virtual;

    { virtual list methods }
    function OwnerDataFetch(Item: TListItem; Request: TItemRequest): Boolean; override;

    function OwnerDataFind(Find: TItemFind; const FindString: string;
      const FindPosition: TPoint; FindData: Pointer; StartIndex: Integer;
      Direction: TSearchDirection; Wrap: Boolean): Integer; override;

    function OwnerDataHint(StartIndex, EndIndex: Integer): Boolean; override;
    function CustomDrawItem(Item: TListItem; State: TCustomDrawState; Stage:
      TCustomDrawStage): Boolean; override;
    function IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage):  Boolean; override;

    function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
    { message handlers }
    procedure WndProc(var Message: TMessage); override;

    property ShellItems: TLMDShellItems read FShellItems;

    { IDropTarget }
    function IDropTarget.DragEnter = ShellListDragEnter;
    function IDropTarget.DragOver = ShellListDragOver;
    function IDropTarget.DragLeave = ShellListDragLeave;
    function IDropTarget.Drop = ShellListDrop;

    function ShellListDragEnter(const dataObj: IDataObject; grfKeyState:
      Longint; pt: TPoint; var dwEffect: Longint): HResult; stdcall;
    function ShellListDragOver(grfKeyState: Longint; pt: TPoint; var dwEffect:
      Longint): HResult; stdcall;
    function ShellListDragLeave: HResult; stdcall;
    function ShellListDrop(const dataObj: IDataObject; grfKeyState: Longint; pt:
      TPoint; var dwEffect: Longint): HResult; stdcall;

    property Columns;
  public
    { constructor / destructor }
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure EnumColumns;

    procedure Store(const aPath: string);
    procedure Restore(const aPath: string);
    { methods }
    procedure Clear; override;

    procedure RefreshData;
    { ILMDView methods }
    procedure BeginUpdate;
    procedure EndUpdate;

    procedure BeginEnumeration;
    procedure EndEnumeration;
    function TerminateEnumeration: boolean;
    procedure AddItem(aItem: TLMDCustomShellItem); reintroduce;
    procedure ActiveFolderChanged;
    function Controller: TLMDCustomShellController;
    procedure DoFileChange(aPIDL: PItemIDList);
    procedure DoFileCreate(aPIDL: PItemIDList);
    procedure DoFileDelete(aPIDL1: PItemIDList; aPIDL2: PItemIDList);
    procedure DoFileRename(aPIDL1: PItemIDList; aPIDL2: PItemIDList);
    procedure DoFolderChange(aPIDL: PItemIDList);
    procedure DoFolderCreate(aPIDL: PItemIDList);
    procedure DoFolderDelete(aPIDL: PItemIDList);
    procedure DoFolderRename(aPIDL1: PItemIDList; aPIDL2: PItemIDList);

    // RM 12-Oct-2006
    // --------------
    // sort after column of type aColumn
    procedure SortColumn(aColumn:TLMDShellItemDetailsColumn);overload;
    // sort after column of type aColumn with sort direction aDirection.
    procedure SortColumn(aColumn:TLMDShellItemDetailsColumn;aDirection:TLMDShellSortDirection);overload;
    // sort after column with index aIndex
    procedure SortColumn(aIndex:Integer=-1);overload;
    // sort after column with index aIndex and sort direction aDirection.
    procedure SortColumn(aIndex:Integer; aDirection:TLMDShellSortDirection);overload;
    // --------------

    // RM 30-July-2003
    // ----------------
    function Editable: Boolean;
    function CanCut: Boolean;
    function CanCopy: Boolean;
    function CanDelete: Boolean;
    function CanPaste: Boolean;
    function CanRename: Boolean;
    function CanAccessItem: Boolean;

    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;
    procedure DeleteItems;

    procedure CopyItems(const Target: string);
    procedure MoveItems(const Target: string);

    function  Rename: Boolean;
    procedure ShowProperties;
    procedure CopyFileNameAsText;
    procedure CopyPathAsText;
    function  NewFolder: Boolean;
    procedure Open;
    procedure OpenWith;

    procedure ExecuteCommand(const Verb: string; var Handled: Boolean); overload;
    function  ExecuteCommand(const Verb: string): Boolean; overload;
    // ----------------

    // Shell-List specific
    procedure InvertSelection;
    procedure CalculateSelectionInfo(var Count: Integer; var Size: Int64);

    function getLMDPackage:TLMDPackageID;override;

    { properties }
    property CheckedItem[index: integer]: TLMDCustomShellItem read GetCheckedItem;
    property CheckedCount: integer read GetCheckedCount;

    property SelectedItem: TLMDCustomShellItem read GetSelectedItem;
    property SelectedItems[index: integer]: TLMDCustomShellItem read GetSelectedItems;
    property Items;
  published
    { properties }
    property About;
    property FileFilter: string read GetFileFilter write SetFileFilter;
    property Filtered: Boolean read FFiltered write SetFiltered default false;
    property FilterDirs: Boolean read FFilterDirs write SetFilterDirs default
      false;

    property Folder: TLMDShellFolder read FShellFolder write SetShellFolder;
    property CompressedColor: TColor read FCompressedColor write
      SetCompressedColor default clBlue;
    property Options: TLMDShellListOptions read FOptions write SetOptions;
    property ShowCheckBoxes: boolean read FShowCheckBoxes write
      SetShowCheckBoxes;
    property SortDirection: TLMDShellSortDirection read FSortDirection write
      SetSortDirection;
    property ViewStyle: TViewStyle read FViewStyle write SetViewStyle;
    property CustomColumns: TLMDShellListCustomColumns read FColumns write
      SetCustomColumns;
    property StoreSettings: boolean read FStoreSettings write FStoreSettings;
    property RegistryPath: string read FRegistryPath write FRegistryPath;
    property DefaultColumns: boolean read FDefaultColumns write
      SetDefaultColumns;

    property ShowOverlayIcon: boolean read FShowOverlayIcon write
      SetShowOverlayIcon default True;

    { V2.0 }
    property AutoContextMenus: boolean read FAutoContext write FAutoContext;
    property AutoSortSupport: boolean read FAutoSortSupport write
      FAutoSortSupport;
    property OnSelectionInfo: TLMDShellInfoEvent read FOnSelectionInfo write
      FOnSelectionInfo;

    property SuppressDefaultAction: Boolean read FSuppressDefaultAction
      write SetSuppressDefaultAction default False;
    property SuppressFolderNavigation: Boolean read FSuppressFolderNavigation
      write FSuppressFolderNavigation default False;

    { events }
    property OnFilterItem: TLMDShellItemFilter read FOnFilterItem write
      FOnFilterItem;
    property OnItemDblClick: TLMDShellItemEvent read FOnItemDblClick write
      FOnItemDblClick;
    property OnItemSelected: TLMDShellItemEvent read FOnItemSelected write
      FOnItemSelected;

    {properties}
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderWidth;
    property Constraints;
    property FlatScrollBars;
    property FullDrag;
    property HotTrackStyles;
    property ParentBiDiMode;
    property HoverTime;
    property ShowWorkAreas;
    property AllocBy;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property Enabled;
    property Font;
    property GridLines;
    property HideSelection;
    property HotTrack;
    property IconOptions;
    property MultiSelect nodefault;
    property ReadOnly;
    property RowSelect;
    property ParentColor default False;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property ShowHint;
    property SortType;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnColumnClick;
//    property OnCompare;
    property OnDblClick;
    property OnDeletion;
    property OnEdited;
    property OnEditing;
//    property OnEndDrag;
    property OnEnter;
    property OnExit;
//    property OnDragDrop;
//    property OnDragOver;
    property OnInsert;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
//    property OnStartDrag;
    property OnColumnRightClick;
    property OnContextPopup;
    property OnGetSubItemImage;
    property OnInfoTip;
    property OnEndDock;
    property OnGetImageIndex;
    property OnResize;
    property OnSelectItem;
    property OnStartDock;
  end;

implementation

uses
  SysUtils, Registry, Masks, Imglist, Forms, ClipBrd, ShellAPI, ComObj, Themes,
  LMDThemes, LMDShController, LMDShDragDrop, LMDShConsts, LMDUtils, LMDProcs,
  LMDStrings;

const
  LMDSHELL_COLUMNNAMES: array[TLMDShellItemDetailsColumn] of string =
  (IDSHELL_ColumnName, IDSHELL_ColumnType, IDSHELL_ColumnSize,
    IDSHELL_ColumnAttr,
    IDSHELL_ColumnWriteDate, IDSHELL_ColumnWriteTime, IDSHELL_ColumnWriteDate,
    IDSHELL_ColumnCreateDate, IDSHELL_ColumnCreateTime,
    IDSHELL_ColumnCreateDate,
    IDSHELL_ColumnAccessDate, IDSHELL_ColumnAccessTime,
    IDSHELL_ColumnAccessDate, '');

const
  WM_RESTOREPOPUP = WM_USER + 3;

const
  //  SHCOLUMNID.pid

  //  The storage property set
  PID_STG_NAME        = 10;   // The object's display name
  PID_STG_STORAGETYPE = 4;    // The object's type
  PID_STG_SIZE        = 12;   // The object's size
  PID_STG_WRITETIME   = 14;   // The object's modified attribute
  PID_STG_ATTRIBUTES  = 13;   // The object's attributes

  //  The volume property set provides volume information.
  PID_VOLUME_FREE     = 2;    // The amount of free space.

  //  The displaced property set supports files that have been deleted
  //  and moved to the Recycle Bin.
  PID_DISPLACED_FROM  = 2;    // Location that file was deleted from.
  PID_DISPLACED_DATE  = 3;    // Date that the file was deleted.

{** TLMDShellListItem *********************************************************}
{-- private -------------------------------------------------------------------}

function TLMDShellListItem.GetShellItem: TLMDShellItem;
begin
  if (ListView is TLMDShellList) and (fIndex >= 0) then
    Result := TLMDShellItem(TLMDShellList(ListView).FItemsCache[fIndex])
  else
    Result := nil;
end;

{** TLMDCustomColumn **********************************************************}
{-- private -------------------------------------------------------------------}

function TLMDShellListCustomColumn.IsWidthStored: Boolean;
begin
  Result := not FAutoSize and (Width > 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.SetAlignment(const Value: TAlignment);
begin
  if FAlignment = Value then
    Exit;
  FAlignment := Value;
  DoChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.SetAutoSize(const Value: Boolean);
begin
  if FAutoSize = Value then
    Exit;
  FAutoSize := Value;
  DoChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.SetCaption(const Value: string);
begin
  if FCaption = Value then
    Exit;
  FCaption := Value;
  DoChange;
end;

{------------------------------------------------------------------------------}
function TLMDShellListCustomColumn.IsCaptionStored: Boolean;
begin
  Result := not LMDAnsiSameText(FCaption, LMDSHELL_COLUMNNAMES[DataType]);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.SetDataType(const Value:
  TLMDShellItemDetailsColumn);
begin
  if FDataType = Value then
    Exit;
  FDataType := Value;
  FCaption := LMDSHELL_COLUMNNAMES[Value];
  if Value = cdSize then
    FAlignment := taRightJustify;
  DoChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.SetMaxWidth(const Value: TWidth);
begin
  if FMaxWidth = Value then
    Exit;
  FMaxWidth := Value;
  DoChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.SetMinWidth(const Value: TWidth);
begin
  if FMinWidth = Value then
    Exit;
  FMinWidth := Value;
  DoChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.SetWidth(const Value: TWidth);
begin
  if FWidth = Value then
    Exit;
  FWidth := Value;
  DoChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.SetImageIndex(const Value: LongInt);
begin
  FImageIndex := Value;
  DoChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.SetVisible(const value: boolean);
begin
  if FDataType = cdName then
    FVisible := True
  else if FVisible = value then
    Exit
  else
    FVisible := value;
  DoChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.SetDefaultColumn(const value: boolean);
begin
  if FDefaultColumn = value then
    Exit;
  FDefaultColumn := value;
  DoChange;
end;

{-- protected -----------------------------------------------------------------}
procedure TLMDShellListCustomColumn.Assign(Source: TPersistent);
begin
  if Source is TLMDShellListCustomColumn then
    with TLMDShellListCustomColumn(Source) do
      begin
        self.Alignment:=Alignment;
        self.AutoSize:=AutoSize;
        self.Caption:=Caption;
        self.DataType:=DataType;
        self.ImageIndex:=ImageIndex;
        self.MaxWidth:=MaxWidth;
        self.MinWidth:=MinWidth;
        self.Tag:=Tag;
        self.Width:=Width;
        self.Visible:=Visible;
        self.DefaultColumn:=DefaultColumn;
        exit;
      end;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDShellListCustomColumn.GetDisplayName: string;
begin
  if Caption = '' then
    Result := inherited GetDisplayName
  else
    Result := Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.DoChange;
begin
  TLMDShellListCustomColumns(Collection).SetColumnChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.Store(const aPath: string);
var
  R: TRegistry;
begin
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    if R.OpenKey('\Software' + aPath, true) then
    begin
      R.WriteString('Column_' + FCaption + '_Alignment',
        IntToStr(Integer(FAlignment)));
      R.WriteString('Column_' + FCaption + '_AutoSize',
        IntToStr(Integer(FAutoSize)));
      R.WriteString('Column_' + FCaption + '_MaxWidth', IntToStr(FMaxWidth));
      R.WriteString('Column_' + FCaption + '_MinWidth', IntToStr(FMinWidth));
      R.WriteString('Column_' + FCaption + '_Width', IntToStr(FWidth));
      R.WriteString('Column_' + FCaption + '_Visible',
        IntToStr(integer(FVisible)));
    end;
  finally
    R.CloseKey;
    R.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.Restore(const aPath: string);
var
  R: TRegistry;
begin
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    if R.OpenKeyReadOnly('\Software' + aPath) then
    begin
      FAlignment := TAlignment(LMDSafeStrToInt(R.ReadString('Column_' + FCaption +
        '_Alignment')));
      FAutoSize := boolean(LMDSafeStrToInt(R.ReadString('Column_' + FCaption +
        '_AutoSize')));
      FMaxWidth := LMDSafeStrToInt(R.ReadString('Column_' + FCaption +
        '_MaxWidth'));
      FMinWidth := LMDSafeStrToInt(R.ReadString('Column_' + FCaption +
        '_MinWidth'));
      FWidth := LMDSafeStrToInt(R.ReadString('Column_' + FCaption + '_Width'));
      FVisible := boolean(LMDSafeStrToInt(R.ReadString('Column_' + FCaption +
        '_Visible')));
    end;
  finally
    R.CloseKey;
    R.Free;
  end;
end;

{-- public ------------------------------------------------------------------- }

constructor TLMDShellListCustomColumn.Create(Collection: TCollection);
begin
  inherited;
  FDataType := cdName;
  FCaption := IDSHELL_ColumnName;
  FAlignment := taLeftJustify;
  FAutoSize := false;
  FMaxWidth := 0;
  FMinWidth := 0;
  FTag := 0;
  FWidth := -1;
  FImageIndex := -1;
  FVisible := False;
  FDefaultColumn := True;
end;

{------------------------------------------------------------------------------}
function TLMDShellListCustomColumn.GetText(aItem: TLMDCustomShellItem): string;
begin
  //result := '';
  result := aItem.Details[integer(FDataType)];
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumn.SetDefaultWidth;
begin
  FWidth := 100;
end;

{** TLMDCustomColumns *********************************************************}
{-- private -------------------------------------------------------------------}

function TLMDShellListCustomColumns.GetListView: TLMDShellList;
begin
  result := TLMDShellList(Owner);
end;

{------------------------------------------------------------------------------}
function TLMDShellListCustomColumns.GetItem(Index: Integer):
  TLMDShellListCustomColumn;
begin
  Result := TLMDShellListCustomColumn(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumns.SetItem(Index: Integer; const Value:
  TLMDShellListCustomColumn);
begin
  inherited SetItem(Index, Value);
end;

{-- protected -----------------------------------------------------------------}

procedure TLMDShellListCustomColumns.Update(Item: TCollectionItem);
begin
  inherited;
  DoChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumns.Store(const aPath: string);
var
  i: integer;
begin
  if aPath = '' then
    Exit;
  for i := 0 to count - 1 do
    GetItem(i).Store(aPath);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumns.Restore(const aPath: string);
var
  i: integer;
begin
  if aPath = '' then
    Exit;
  for i := 0 to count - 1 do
    GetItem(i).Restore(aPath);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumns.SetColumnChanged;
begin
  if (FLockUpdates = 0) then
    DoChange
  else
    FColumnChanged := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumns.DoChange;
begin
  if  (UpdateCount = 0) and Assigned(ListView) and (FLockUpdates = 0)
      and not ListView.DefaultColumns then
    ListView.EnumColumns;
end;

{-- public ------------------------------------------------------------------- }

constructor TLMDShellListCustomColumns.Create(aOwner: TLMDShellList);
begin
  inherited Create(aOwner, TLMDShellListCustomColumn);
  FLockUpdates := 0;
  FColumnChanged := False;
  CreateDefaultColumns;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellListCustomColumns.Destroy;
begin
  if ListView.StoreSettings then
    Store(ListView.RegistryPath);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumns.CreateDefaultColumns;
var
  idx: TLMDShellItemDetailsColumn;
begin
  BeginUpdate;

  for idx := Low(TLMDShellItemDetailsColumn) to High(cdWriteDateTime) do
    if idx in [cdName, cdTypeName, cdSize, cdAttributes, cdWriteDateTime] then
      with TLMDShellListCustomColumn(inherited Add) do
      begin
        DataType := idx;
        MaxWidth := 300;
        Visible := (DataType in [cdName, cdTypeName, cdSize, cdAttributes,
          cdWriteDateTime]);
        DefaultColumn := (DataType in [cdName, cdTypeName, cdSize, cdAttributes,
          cdWriteDateTime]);
        // specific settings
        case idx of
          cdName:
            Width := 180;
          cdTypeName:
            Width := 150;
          cdSize:
            Width := 96;
          cdAttributes:
            Width := 80;
          cdWriteDateTime:
            Width := 120;
          cdCreateDateTime,
            cdAccessDateTime:
            Width := 120;
        end;
      end;

  if ListView.StoreSettings then
    Restore(ListView.RegistryPath);

  EndUpdate;

end;

{------------------------------------------------------------------------------}
function TLMDShellListCustomColumns.Owner: TPersistent;
begin
  Result := GetOwner;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumns.BeginUpdates;
begin
  Inc(FLockUpdates);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellListCustomColumns.EndUpdates;
begin
  Dec(FLockUpdates);
  if (FLockUpdates = 0) and FColumnChanged then
  begin
    FColumnChanged := False;
    DoChange;
  end;
end;

{** TLMDShellList *************************************************************}
{ ---------------------------------------------------------------------------- }
procedure TLMDShellList.FakeReadMethod(Reader: TReader);
begin
  Reader.ReadIdent;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellList.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('OnDragDrop', FakeReadMethod, nil, false);
  Filer.DefineProperty('OnDragOver', FakeReadMethod, nil, false);
  Filer.DefineProperty('OnEndDrag', FakeReadMethod, nil, false);
  Filer.DefineProperty('OnCompare', FakeReadMethod, nil, false);
  Filer.DefineProperty('OnStartDrag', FakeReadMethod, nil, false);
end;

{-- private -------------------------------------------------------------------}

procedure TLMDShellList.SetShellFolder(const aValue: TLMDShellFolder);
begin
  if FShellFolder = aValue then
    Exit;

  if FShellFolder <> nil then
    FShellFolder.UnRegisterView(Self);
  ClearLists;
  FShellFolder := aValue;
  if FShellFolder <> nil then
  begin
    FShellFolder.RegisterView(Self);
    SmallImages := FShellFolder.SmallFolderImages;
    LargeImages := FShellFolder.LargeFolderImages;
    ActiveFolderChanged;
  end
  else
    UpdateEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SetCompressedColor(const aValue: TColor);
begin
  if FCompressedColor = aValue then
    Exit;
  FCompressedColor := aValue;
  if (loColorCompressed in FOptions) then
    RepaintEx;
end;

{------------------------------------------------------------------------------}
function TLMDShellList.GetFileFilter: string;
begin
  result := FFileFilter.DelimitedText;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.ApplyFilter;
var
  Cur: PItemIDList;
  SelItem: TLMDCustomShellItem;
  i: integer;
  Itm: TListItem;
begin
  if not HandleAllocated  then
    exit;

  Itm := nil;
  Cur := nil;

  Items.BeginUpdate;
  try
    SelItem := SelectedItem;

    if  Assigned(SelItem)  then
      Cur := FShellFolder.ID_Clone(SelItem.AbsoluteID);

    FilterShellItems;
    SortShellItems;
    UpdateEx;

    if  Assigned(Cur) then
      begin
        for i := 0 to Items.Count - 1 do
          if  FShellFolder.ID_Equal(Cur, TLMDShellListItem(Items[i]).ShellItem.AbsoluteID)  then
            begin
              Itm := Items[i];
              break;
            end;
      end;
  finally
    Items.EndUpdate;
    if  Assigned(Cur) then
      FShellFolder.ID_Free(Cur);
  end;

  if  Assigned(Itm) then
    begin
      Itm.MakeVisible(False);
      Itm.Selected := True;
      Itm.Focused := True;
    end
  else
    Selected := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SetFileFilter(const aValue: string);
begin
  if FileFilter = aValue then
    Exit;
  FFileFilter.DelimitedText := aValue;
  if (csLoading in ComponentState) or (not FFiltered) then
    exit;
  ApplyFilter;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SetFiltered(const aValue: boolean);
begin
  if FFiltered = aValue then
    Exit;
  FFiltered := aValue;
  if csLoading in ComponentState then
    exit;
  ApplyFilter;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SetFilterDirs(const aValue: boolean);
begin
  if aValue <> FFilterDirs then
  begin
    FFilterDirs := aValue;
    if (csLoading in ComponentState) or (not FFiltered) then
      exit;

    ApplyFilter;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SetOptions(const aValue: TLMDShellListOptions);
var
  NeedRepaint: boolean;
  NeedEnum: boolean;
begin
  if FOptions = aValue then
    Exit;
  NeedRepaint := (not (loColorCompressed in FOptions) and (loColorCompressed in
    aValue)) or
    ((loColorCompressed in FOptions) and not (loColorCompressed in aValue));

  NeedEnum := (not (loShowHidden in FOptions) and (loShowHidden in aValue)) or
    (not (loShowHidden in aValue) and (loShowHidden in FOptions)) or
    (not (loShowFolders in FOptions) and (loShowFolders in aValue)) or
    (not (loShowFolders in aValue) and (loShowFolders in FOptions)) or
    (not (loShowNonFolders in FOptions) and (loShowNonFolders in aValue)) or
    (not (loShowNonFolders in aValue) and (loShowNonFolders in FOptions));

  if not (csDesigning in ComponentState) and HandleAllocated  then
    if (loAllowDrop in aValue) and not (loAllowDrop in FOptions) then
      RegisterDragDrop(Handle, Self)
    else
    if (loAllowDrop in FOptions) and not (loAllowDrop in aValue) then
      RevokeDragDrop(Handle);

  FOptions := aValue;

  FEnumOptions := [];
  if loShowHidden in FOptions then
    Include(FEnumOptions, eoIncludeHidden);
  if loShowFolders in FOptions then
    Include(FEnumOptions, eoFolders);
  if loShowNonFolders in FOptions then
    Include(FEnumOptions, eoNonFolders);

  if NeedEnum then
    ActiveFolderChanged
  else if NeedRepaint then
    RepaintEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SetShowCheckBoxes(const aValue: boolean);
begin
  if FShowCheckBoxes = aValue then
    Exit;
  FShowCheckBoxes := aValue;
  if not FShowCheckBoxes then
    StateImages := nil
  else
    StateImages := FStateImages;
  RepaintEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SetSortDirection(const aValue: TLMDShellSortDirection);
begin
  if FSortDirection<>aValue then
    begin
      FSortDirection := aValue;
      if ViewStyle=vsReport then
        SortColumn
      else
        RepaintEx;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SetDefaultColumns(const aValue: boolean);
begin
  if FDefaultColumns = aValue then
    Exit;
  FDefaultColumns := aValue;
  OldFolder := nil;

  if  HandleAllocated then
    begin
      EnumColumns;
      RepaintEx;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShellList.GetCheckedCount: integer;
var
  i: integer;
begin
  result := 0;
  for i := 0 to FItemsCache.count - 1 do
    if FItemsCache[i].Checked then
      Inc(result);
end;

{------------------------------------------------------------------------------}
function TLMDShellList.GetCheckedItem(index: integer): TLMDCustomShellItem;
var
  i: integer;
  idx: integer;
begin
  idx := -1;
  result := nil;
  for i := 0 to FItemsCache.count - 1 do
    if FItemsCache[i].Checked then
    begin
      Inc(idx);
      if idx = index then
      begin
        result := FItemsCache[i];
        Break;
      end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShellList.GetShellItem(Item: TListItem): TLMDCustomShellItem;
begin
  Result := nil;

  if  Assigned(Item) and (TLMDShellListItem(Item).fIndex >= 0) then
    Result := FItemsCache[TLMDShellListItem(Item).fIndex];
end;

procedure TLMDShellList.HeaderWndProc(var Message: TMessage);

  procedure RedrawHeaderItem(AIndex: Integer; ARect: TRect; AState: Integer);
  var
    LStruct: TDrawItemStruct;
  begin
    LStruct.hDC := GetDC(FHeaderHandle);
    LStruct.itemID := AIndex;
    LStruct.itemState := AState;
    LStruct.rcItem := ARect;
    SendMessage(Handle, WM_DRAWITEM, 0, Integer(@LStruct));
  end;

var
  LRect: TRect;
  i: Integer;
  LOldHighlightingHeaderItem: Integer;
begin
  Message.Result := CallWindowProc(FOldHeaderProc, FHeaderHandle, Message.Msg, Message.WParam, Message.LParam);
  if IsThemed then
  begin
    if Message.Msg = WM_MOUSELEAVE then
    begin
      Header_GetItemRect(FHeaderHandle, FHighlightedHeaderItem, @LRect);
      RedrawHeaderItem(FHighlightedHeaderItem, LRect, ODS_DEFAULT);
      FHighlightedHeaderItem := -1;
    end;
    if Message.Msg = WM_MOUSEMOVE then
    begin
      LOldHighlightingHeaderItem := FHighlightedHeaderItem;
      for i := 0 to Columns.Count - 1 do
      begin
        Header_GetItemRect(FHeaderHandle, i, @LRect);
        if LMDPointInRect(Point(Message.LParamLo, Message.LParamHi), LRect) then
        begin
          FHighlightedHeaderItem := i;
          Break;
        end;
      end;
      if FHighlightedHeaderItem <> LOldHighlightingHeaderItem then
      begin
        RedrawHeaderItem(FHighlightedHeaderItem, LRect, ODS_HOTLIGHT);
        if LOldHighlightingHeaderItem > -1 then
        begin
          Header_GetItemRect(FHeaderHandle, LOldHighlightingHeaderItem, @LRect);
          RedrawHeaderItem(LOldHighlightingHeaderItem, LRect, ODS_DEFAULT);
        end;
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShellList.GetSelectedItem: TLMDCustomShellItem;
begin
  Result := GetShellItem(Selected);
end;

{------------------------------------------------------------------------------}
function TLMDShellList.GetSelectedItems(index: integer): TLMDCustomShellItem;
var
  i: integer;
  idx: integer;
begin
  idx := -1;
  result := nil;
  for i := 0 to Items.count - 1 do
    if Items[i].Selected then
    begin
      Inc(Idx);
      if idx = index then
      begin
        Result := GetShellItem(Items[i]);
        Break;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SetCustomColumns(const value:
  TLMDShellListCustomColumns);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SetShowOverlayIcon(value: boolean);
begin
  if FShowOverlayIcon <> value then
  begin
    FShowOverlayIcon := value;
    invalidate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.FilterShellItems;
var
  i: integer;
  bAccept: boolean;
begin
  FItemsCache.Clear;
  for i := 0 to ShellItems.count - 1 do
  begin
    bAccept := True;
    DoFilterItem(ShellItems[i], bAccept);
    if bAccept then
      FItemsCache.Add(ShellItems[i]);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SortShellItems;
var
  i, j: integer;
  lSelectedNames: TStringList;
  lAllNames: TStringList;
  lDirect: boolean;
begin
  if FClickedColumn >= Columns.count then
    Exit;

  lAllNames := nil;
  lSelectedNames := nil;

  if SelCount > 0 then
    begin
      lSelectedNames := TStringList.Create;
      for i := 0 to Items.count - 1 do
        if Items[i].Selected then
          begin
            lDirect := ((FSortDirection = sdDescending) and (FClickedColumn = FOldColumn)) or
                       ((FOldSortDirection <> sdDescending) and (FClickedColumn <> FOldColumn));
            if (lDirect) then
              lSelectedNames.Add(FItemsCache[i].DisplayName)
            else
              lSelectedNames.Add(FItemsCache[Items.count - i - 1].DisplayName);
          end;
    end;

  if ViewStyle = vsReport then
    case FColumns[Column[FClickedColumn].Tag].DataType of
      cdName:
        if FFileSystemSort then
          FItemsCache.SortByRelativeID
        else
          FItemsCache.SortByName;
      cdTypeName: FItemsCache.SortByTypeName;
      cdSize: FItemsCache.SortByFileSize;
      cdAttributes: FItemsCache.SortByAttributes;
      cdCreateDate,
        cdCreateTime,
        cdCreateDateTime: FItemsCache.SortByCreationDate;
      cdAccessDate,
        cdAccessTime,
        cdAccessDateTime: FItemsCache.SortByAccessDate;
      cdWriteDate,
        cdWriteTime,
        cdWriteDateTime: FItemsCache.SortByModifiedDate;
      cdCustom:
        FItemsCache.SortByDetails(Column[FClickedColumn].Tag);
    end
  else if FFileSystemSort then
    FItemsCache.SortByRelativeID
  else
    FItemsCache.SortByName;

  if SelCount > 0 then
    try
      lAllNames := TStringList.Create;

      for i := 0 to Items.Count - 1 do
        begin
          lAllNames.Add(Items[i].Caption);
          Items[i].Selected := false;
        end;

      for i := 0 to lSelectedNames.Count - 1 do
        begin
          j := lAllNames.IndexOf(lSelectedNames[i]);
          if (j >= 0) then
            Items[j].Selected := true;
        end;

    finally
      lSelectedNames.Clear;
      lAllNames.Clear;
      lSelectedNames.Free;
      lAllNames.Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.RepaintEx;
begin
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.UpdateEx;
begin
  Items.Count := FItemsCache.Count;
  RepaintEx;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.ClearLists;
begin
  FShellItems.Clear;
  FItemsCache.Clear;

  if  not (csDestroying in ComponentState) and HandleAllocated then
    begin
      Items.Count := 0;
      if Assigned(FOnItemSelected) then
        FOnItemSelected(Self, nil);
      UpdateSelectionInfo;
    end;
end;

{------------------------------------------------------------------------------}
function  TLMDShellList.MakeSelectedList(IncludeParent: Boolean): TLMDShellPIDLS;
var
  Cnt, i, j: integer;
begin
  j := 0;
  Result := nil;
  Cnt := SelCount;

  if  IncludeParent and Assigned(FShellFolder)  then
    begin
      Result := TLMDShellPIDLS.Create;
      Result.Count := Cnt + 1;
      Result[0] := FShellFolder.ActiveFolder.AbsoluteID;
      j := 1;
    end
  else
  if  Cnt > 0 then
    begin
      j := 0;
      Result := TLMDShellPIDLS.Create;
      Result.Count := Cnt;
    end;

  if  Assigned(Result)  then
    for i := 0 to Items.count - 1 do
      if Items[i].Selected then
        begin
          Result[j] := GetShellItem(Items[i]).RelativeID;
          inc(j);
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.ExecuteCommand(const Verb: string; var Handled: Boolean);
var
  ShellItem: TLMDCustomShellItem;
  PIDLS: TLMDShellPIDLS;
begin
  Handled := False;
  ShellItem := GetSelectedItem;

  if Assigned(ShellItem)  then
    begin
      PIDLS := MakeSelectedList();

      if  Assigned(PIDLS) then
        try
          Handled := LMDShellDoContextMenuVerb(nil,
              ShellItem.ParentShellFolderIntf, PIDLS.List, Handle, Verb);
        finally
          PIDLS.Free;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function  TLMDShellList.ExecuteCommand(const Verb: string): Boolean;
begin
  ExecuteCommand(Verb, Result);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.EnumItems;
var
  OldCurs: TCursor;
begin
  if (FShellFolder = nil) then
    Exit;
  if FShellFolder.ActiveFolder = nil then
    Exit;

  FFileSystemSort := (FShellFolder.ActiveFolder.IsFolder and not
    (FShellFolder.ActiveFolder.IsFileSystem))
    or FShellFolder.ID_Equal(FShellFolder.ActiveFolder.AbsoluteID,
    FShellFolder.NamespaceRootID);

  OldCurs := Screen.Cursor;
  Items.BeginUpdate;
  try
    Screen.Cursor := crHourGlass;

    FShellFolder.Enumerate(FShellFolder.ActiveFolder.AbsoluteID, Self,
      FEnumOptions);

  finally
    Items.EndUpdate;
    Screen.Cursor := OldCurs;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDShellList.DrawHeaderItem(const PDIS: TDrawItemStruct);

  function i_MoveToEx(DC: HDC; X, Y: Integer; out lpPoint: TPoint): BOOL;
  begin
    Result := MoveToEx(DC, X, Y, @lpPoint);
  end;

  procedure DrawSortingArrow(LRcIcon: TRect; LIOffset: Integer);
  var
    penLight: HPEN;
    penShadow: HPEN;
    pOldPen: HPEN;
    OldPos: TPoint;
  begin
    penLight := CreatePen(PS_SOLID, 1, GetSysColor(COLOR_3DHILIGHT));
    penShadow := CreatePen(PS_SOLID, 1, GetSysColor(COLOR_3DSHADOW));
    pOldPen := SelectObject(PDIS.hDC, penLight);

    if FSortDirection = sdAscending then
    begin
      i_MoveToEx(PDIS.hDC, LRcIcon.right - 2 * LIOffset, LIOffset, OldPos);
      LineTo(PDIS.hDC, LRcIcon.right - LIOffset, LRcIcon.bottom - LIOffset - 1);
      LineTo(PDIS.hDC, LRcIcon.right - 3 * LIOffset - 2, LRcIcon.bottom - LIOffset
        - 1);
      SelectObject(PDIS.hDC, penShadow);
      i_MoveToEx(PDIS.hDC, LRcIcon.right - 3 * LIOffset - 1, LRcIcon.bottom - LIOffset
        - 1, OldPos);
      LineTo(PDIS.hDC, LRcIcon.right - 2 * LIOffset, LIOffset - 1);
    end
    else
    begin
      i_MoveToEx(PDIS.hDC, LRcIcon.right - LIOffset - 1, LIOffset, OldPos);
      LineTo(PDIS.hDC, LRcIcon.right - 2 * LIOffset - 1, LRcIcon.bottom -
        LIOffset);
      SelectObject(PDIS.hDC, penShadow);
      i_MoveToEx(PDIS.hDC, LRcIcon.right - 2 * LIOffset - 2, LRcIcon.bottom -
        LIOffset, OldPos);
      LineTo(PDIS.hDC, LRcIcon.right - 3 * LIOffset - 1, LIOffset);
      LineTo(PDIS.hDC, LRcIcon.right - LIOffset - 1, LIOffset);
    end;

    SelectObject(PDIS.hDC, pOldPen);
    DeleteObject(penLight);
    DeleteObject(penShadow);
  end;

var
  iSavedDC: integer;
  LRect: TRect;
  //rgn: HRGN;
  LText: String;
  hditem: HD_ITEM;
  uFormat: UINT;
  rcIcon: TRect;
  iOffset: Integer;
  Brush: HBRUSH;
  Buf: PChar;
  LDetails: TThemedElementDetails;
  LUseThemeMode: TLMDThemeMode;
  LSize: TSize;
  LArrowRect: TRect;
begin
  if not CustomColumns.FColumnChanged then
  begin
    iSavedDC := SaveDC(PDIS.hDC);
    LRect := PDIS.rcItem;

    SetLength(LText, 256);
    FillChar(PChar(LText)^, 256, 0);
    hditem.mask := HDI_TEXT or HDI_FORMAT;
    hditem.pszText := Int_RefA(LText, Buf);
    hditem.cchTextMax := 255;
    //FHeaderHandle := ListView_GetHeader(Handle);
    Header_GetItem(FHeaderHandle, PDIS.itemID, hditem);
    int_Free([Buf]);

    uFormat := DT_SINGLELINE or DT_NOPREFIX or DT_NOCLIP or DT_VCENTER or
      DT_END_ELLIPSIS;
    if (hditem.fmt and HDF_CENTER) <> 0 then
      uFormat := uFormat or DT_CENTER
    else if (hditem.fmt and HDF_RIGHT) <> 0 then
      uFormat := uFormat or DT_RIGHT
    else
      uFormat := uFormat or DT_LEFT;

    if IsThemed then
    begin
      LUseThemeMode := UseThemeMode;
      LDetails.Element := teHeader;
      LDetails.Part := 0;
      LDetails.State := 0;
      LMDThemeServices.DrawElement(LUseThemeMode, PDIS.hDC, LDetails, LRect, LMDRectToPtr(LRect));;

      if (PDIS.itemState = ODS_SELECTED) then
        LDetails.State := HIS_PRESSED
      else if (PDIS.itemState = ODS_HOTLIGHT) then
        LDetails.State := HIS_HOT
      else
        LDetails.State := HIS_NORMAL;
      if Columns[PDIS.itemID].Tag = FClickedColumn then
        LDetails.State := HIS_SORTEDNORMAL;
      LDetails.Part := HP_HEADERITEM;
      LMDThemeServices.DrawElement(LUseThemeMode, PDIS.hDC, LDetails, LRect, LMDRectToPtr(LRect));

      rcIcon := LRect;
      iOffset := (rcIcon.bottom - rcIcon.top) div 4;
      if Columns[PDIS.itemID].Tag = FClickedColumn then
      begin
        if (IsThemed) and (LMDSIWindowsVistaUp) then
        begin
          if (FSortDirection = sdAscending) then
            LDetails.State := HSAS_SORTEDUP
          else
            LDetails.State := HSAS_SORTEDDOWN;
          LDetails.Part := HP_HEADERSORTARROW;
          LMDThemeServices.GetThemePartSize(LUseThemeMode, PDIS.hDC, LDetails, LSize);
          LArrowRect.Top := 0;
          LArrowRect.Bottom := LSize.cy + 0;
          LArrowRect.Left := LRect.Left + ((LMDRectWidth(LRect) - LSize.cx) div 2);
          LArrowRect.Right := LArrowRect.Left + LSize.cx;
          LMDThemeServices.DrawElement(LUseThemeMode, PDIS.hDC, LDetails, LArrowRect, LMDRectToPtr(LArrowRect));
        end
        else
          DrawSortingArrow(rcIcon, iOffset);
      end;

      if Columns[PDIS.itemID].Tag = FClickedColumn then
        Dec(LRect.right, 3 * iOffset);

      Inc(LRect.left, iOffset);
      Dec(LRect.right, iOffset);

      if LRect.left < LRect.right then
      begin
        LDetails.Part := HP_HEADERITEM;
//        FillChar(LFont, SizeOf(LFont), 0);
//        if (LMDThemeServices.GetThemeFont(LUseThemeMode, PDIS.hDC, LDetails.Element, LDetails.State, LDetails.State, TMT_FONT, LFont)) then
//        begin
//          SelectObject(PDIS.hDC, CreateFontIndirect(LFont));
//        end;
        SelectObject(PDIS.hDC, Canvas.Font.Handle);
        LMDThemeServices.DrawThemeText(LUseThemeMode, PDIS.hDC, LDetails, LText, -1, uFormat, 0, LRect);
      end;
    end
    else
    begin
      //rgn := CreateRectRgnIndirect(LRect);   //commented out VB Nov 2008
      //SelectObject(PDIS.hDC, rgn);        //(see BTS 637 issue #2)
      //DeleteObject(rgn);

      Brush := CreateSolidBrush(GetSysColor(COLOR_3DFACE));
      FillRect(PDIS.hDC, LRect, Brush);
      DeleteObject(Brush);

      if PDIS.itemState = ODS_SELECTED then
      begin
        Inc(LRect.left);
        Inc(LRect.top, 2);
        Inc(LRect.right);
      end;

      rcIcon := LRect;
      iOffset := round((rcIcon.bottom - rcIcon.top) / 4);

      if Columns[PDIS.itemID].Tag = FClickedColumn then
        Dec(LRect.right, 3 * iOffset);

      Inc(LRect.left, iOffset);
      Dec(LRect.right, iOffset);

      if LRect.left < LRect.right then
        DrawText(PDIS.hDC, Int_Ref(LText), -1, LRect, uFormat);

      if Columns[PDIS.itemID].Tag = FClickedColumn then
        DrawSortingArrow(rcIcon, iOffset);

      RestoreDC(PDIS.hDC, iSavedDC);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DrawOverlayItem(Sender: TCustomListView;
          Item: TListItem; State: TCustomDrawState; Stage: TCustomDrawStage;
          var DefaultDraw: Boolean);
var
  ShellItem: TLMDCustomShellItem;
  r: TRect;
  icnOverlay: TIcon;
  icn16, icn32: HICON;
begin
  if not ShowOverlayIcon then
    exit;
  ShellItem := GetShellItem(Item);
  if (ShellItem = nil) then
    exit;

  icn16 := 0;
  icn32 := 0;

  if ShellItem.IsShared then
    ExtractIconEx('SHELL32.DLL', 28, icn32, icn16, 1)
  else if ShellItem.IsLink then
    ExtractIconEx('SHELL32.DLL', 29, icn32, icn16, 1)
  else
    Exit;
  ListView_GetItemRect(handle, Item.Index, r, LVIR_ICON);
  icnOverlay := TIcon.Create;
  try
    if ViewStyle = vsIcon then
    begin
      r.Left := (r.Left + r.Right - 32) div 2;
      r.Top := r.Top + 2;
      icnOverlay.Handle := icn32;
    end
    else
      icnOverlay.Handle := icn16;
    Canvas.Draw(r.Left, r.top, icnOverlay);
  finally
    icnOverlay.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShellList.ShellListDragEnter(const dataObj: IDataObject;
  grfKeyState: Longint; pt: TPoint; var dwEffect: Longint): HResult;
var
  FE: TFormatEtc;
  ClientPt: TPoint;
begin
  FDataObject := nil;

  FE.cfFormat := CF_HDROP;
  FE.dwAspect := DVASPECT_CONTENT;
  FE.ptd := nil;
  FE.tymed := TYMED_HGLOBAL;
  FE.lindex := -1;

  if (dataObj.QueryGetData(FE) <> NOERROR) then
  begin
    dwEffect := DROPEFFECT_NONE;
    Result := NOERROR;
  end
  else
  begin
    FDataObject := dataObj;
    Result := NOERROR;
  end;
  ImageList_GetDragImage(nil, nil);
  ClientPt := ScreenToClient(pt);
  ImageList_DragEnter(Handle, ClientPt.x, ClientPt.y);
end;

{------------------------------------------------------------------------------}
function TLMDShellList.ShellListDragOver(grfKeyState: Longint; pt: TPoint; var
  dwEffect: Longint): HResult;
var
  Item: TListItem;
  NextItem: TListItem;
  ClientPt: TPoint;
  DropTarget: IDropTarget;
  DoScroll: Boolean;
  Delay: Integer;
  ShellItem: TLMDCustomShellItem;
  Flag: boolean;
  Rect: TRect;
begin
  result := S_OK;
  if (FDataObject = nil) or (FShellFolder = nil)  then
  begin
    dwEffect := DROPEFFECT_NONE;
    result := NOERROR;
  end
  else
  begin
    ClientPt := ScreenToClient(pt);
    Item := GetItemAt(ClientPt.X, ClientPt.Y);
    NextItem := nil;
    DropTarget := nil;
    if Assigned(Item) then
    begin
      DoScroll := False;
      ClientPt := ScreenToClient(pt);
      Delay := 0;

      case ViewStyle of
        vsReport, vsSmallIcon:
          begin
            if (ClientPt.Y < 30) then
            begin
              NextItem := GetNextItem(Item, sdAbove, [isNone]);
              if Assigned(NextItem) then
              begin
                Delay := 30;
                DoScroll := True;
              end;
            end;

            if (ClientPt.Y > Height - 30) then
            begin
              NextItem := GetNextItem(Item, sdBelow, [isNone]);
              if Assigned(NextItem) then
              begin
                Delay := 30;
                DoScroll := True;
              end;
            end;
          end;

        vsIcon:
          begin
            if (ClientPt.Y < 30) then
            begin
              NextItem := GetNextItem(Item, sdAbove, [isNone]);
              if Assigned(NextItem) then
              begin
                Delay := 100;
                DoScroll := True;
              end;
            end;

            if (ClientPt.Y > Height - 30) then
            begin
              NextItem := GetNextItem(Item, sdBelow, [isNone]);
              if NextItem = nil then
                NextItem := GetNextItem(Item, sdAll, [isNone]);
              if Assigned(NextItem) then
              begin
                DoScroll := True;
                Delay := 100;
              end;
            end;
          end;

        vsList:
          begin
            if (ClientPt.X < 10) then
            begin
              NextItem := GetNextItem(Item, sdLeft, [isNone]);
              if Assigned(NextItem) then
              begin
                DoScroll := True;
                Delay := 400;
              end;
            end;

            if (ClientPt.X > Width - 30) then
            begin
              NextItem := GetNextItem(Item, sdRight, [isNone]);
              if NextItem = nil then
                NextItem := GetNextItem(Item, sdAll, [isNone]);
              if Assigned(NextItem) then
              begin
                DoScroll := True;
                Delay := 400;
              end;
            end;
          end;
      end;

      if (NextItem <> nil) and DoScroll then
      begin
        ImageList_DragShowNoLock(False);
        NextItem.MakeVisible(False);
        ImageList_DragShowNoLock(True);
        Sleep(Delay);
      end;

      ShellItem := GetShellItem(Item);
      DropTarget := ShellItem.DropTargetIntf;
    end
    else
    begin
      if Assigned(FShellFolder) and (FShellFolder.DragSource = Self) then
      begin
        ImageList_DragMove(ClientPt.x, ClientPt.y);
        dwEffect := DROPEFFECT_NONE;
        Exit;
      end;

      if  Assigned(FShellFolder)  then
        DropTarget := FShellFolder.ActiveFolder.DropTargetIntf;
    end;

    if Assigned(DropTarget) then
    begin
      DropTarget.DragEnter(FDataObject, grfKeyState, pt, dwEffect);
      result := DropTarget.DragOver(grfKeyState, pt, dwEffect);
      DropTarget.DragLeave;
      DropTarget := nil;
    end;

    if Assigned(Item) then
    begin
      ShellItem := GetShellItem(Item);
      Flag := True;
      if (FDropTargetItem <> '') then
        Flag := not LMDAnsiSameText(ShellItem.DisplayName, FDropTargetItem);

      if Flag then
      begin
        FDropTargetItem := '';
        FDropTargetItem := Item.Caption;
        Item.DropTarget := True;

        ImageList_DragMove(ClientPt.x, ClientPt.y);
        ImageList_DragShowNoLock(False);

        Rect := Item.DisplayRect(drSelectBounds);
        if (ViewStyle = vsReport) then
        begin
          Dec(Rect.Top, 40);
          Inc(Rect.Bottom, 40);
        end;

        LMDInvalidateRect(Handle, Rect, False);
        UpdateWindow(Handle);
        ImageList_DragShowNoLock(True);
        Exit;
      end;
    end;
  end;
  ImageList_DragMove(ClientPt.x, ClientPt.y);
end;

{------------------------------------------------------------------------------}
function TLMDShellList.ShellListDragLeave: HResult;
var
  R: TRect;
  I: Integer;
  Index: Integer;
begin
  FDataObject := nil;
  ImageList_DragLeave(Handle);
  if FDropTargetItem <> '' then
  begin

    Index := -1;
    for I := 0 to Items.Count - 1 do
      if LMDAnsiSameText(Items[I].Caption, FDropTargetItem) then
      begin
        Index := I;
        Break;
      end;

    if Index <> -1 then
    begin
      Items[Index].DropTarget := False;
      R := Items[Index].DisplayRect(drBounds);
      LMDInvalidateRect(Handle, R, False);
      UpdateWindow(Handle);
    end;

    FDropTargetItem := '';
  end;
  Result := NOERROR;
end;

{------------------------------------------------------------------------------}
function TLMDShellList.ShellListDrop(const dataObj: IDataObject; grfKeyState:
  Longint; pt: TPoint; var dwEffect: Longint): HResult;
var
  Item: TListItem;
  ClientPt: TPoint;
  DropTarget: IDropTarget;
  I, Index: Integer;
  R: TRect;
begin
  result := S_OK;

  if (FDataObject = nil) or not Assigned(FShellFolder)  then
  begin
    result := E_FAIL;
    Exit;
  end;

  ShellListDragLeave();
  grfKeyState := grfKeyState or MK_LBUTTON;
  if (grfKeyState and MK_CONTROL) <> 0 then
    dwEffect := DROPEFFECT_COPY;

  ClientPt := ScreenToClient(pt);
  Item := GetItemAt(ClientPt.X, ClientPt.Y);
  if Item <> nil then
    DropTarget := GetShellItem(Item).DropTargetIntf
  else
    DropTarget := FShellFolder.ActiveFolder.DropTargetIntf;

  if DropTarget <> nil then
  begin
    DropTarget.DragEnter(dataObj, grfKeyState, pt, dwEffect);
    result := DropTarget.Drop(dataObj, grfKeyState, pt, dwEffect);
    DropTarget.DragLeave;
    DropTarget := nil;
  end;

  if FDropTargetItem <> '' then
  begin
    Index := -1;
    for i := 0 to Items.Count - 1 do
      if LMDAnsiSameText(Items[i].Caption, FDropTargetItem) then
      begin
        Index := I;
        Break;
      end;

    if Index <> -1 then
    begin
      Items[Index].DropTarget := False;
      R := Items[Index].DisplayRect(drBounds);
      LMDInvalidateRect(Handle, R, False);
      UpdateWindow(Handle);
    end;

    FDropTargetItem := '';
  end;

  NeedRefresh;
end;

{-- protected -----------------------------------------------------------------}
procedure TLMDShellList.SetViewStyle(aValue: TViewStyle);
//var
//  i: integer;
begin
  if FViewStyle = aValue then
    Exit;

  inherited SetViewStyle(aValue);

  FViewStyle := aValue;
  FClickedColumn := 0;

  if not (csDesigning in ComponentState) and (FShellFolder <> nil) then
  begin
    Perform(WM_SETREDRAW, 0, 0);
    if (FViewStyle = vsReport) and (ShellItems.count > 0) then
    begin
      EnumColumns;
    end;

    if (FViewStyle = vsList)  then
    begin
//      Columns[0].Width := 200;
    end;
//    SortShellItems;
  end;
  Perform(WM_SETREDRAW, 1, 0);

end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DoFilterItem(const aItem: TLMDCustomShellItem;
    var aAccept: Boolean);

  function FilterItem: boolean;
  var
    i: integer;
    Name: string;
  begin
    Result := True;

    if  FFileFilter.Count > 0 then
      begin
        if aItem.IsFolder and not FilterDirs  then
          exit;

        Result := False;
        Name := aItem.ExtDisplayName;

        for i := 0 to FFileFilter.Count - 1 do
          if (FFileFilter[i] = '*.*')
              or Masks.MatchesMask(Name, FFileFilter[i]) then
            begin
              Result := True;
              Break;
            end;
      end;
  end;

begin
  if (csDesigning in ComponentState) then
    Exit;
  if FFiltered then
    begin
      if  FFileFilter.Count > 0 then
        aAccept := FilterItem;

      if Assigned(FOnFilterItem) then
        FOnFilterItem(Self, aItem, aAccept);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShellList.CanEdit(Item: TListItem): Boolean;
begin
  //  Delphi-8 has bug!!! Item always = nil ! //vb: in bds 2006 .net all is ok
  Item := Selected;
  inherited CanEdit(Item);
  Result := Assigned(Item) and (loAllowRename in FOptions)
            and GetShellItem(Item).CanRename;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.Click;
var
  Item: TListItem;
  R: TRect;
begin
  inherited;
  Item := GetItemAt(FClickPoint.x, FClickPoint.y);
  if Item <> nil then
  begin
   if FShowCheckBoxes then
    begin
     R := Item.DisplayRect(drIcon);
      if (FClickPoint.x <= R.Left) and (FClickPoint.y >= R.Top)
        and (FClickPoint.y <= R.Bottom) then
      begin
        GetShellItem(Item).Checked := not GetShellItem(Item).Checked;
        RepaintEx;
      end;
    end;
    if Assigned(FOnItemSelected) then
      FOnItemSelected(Self, GetShellItem(Item));
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DblClick;
begin
  inherited;
  if Selected = nil then
    Exit;

  if (Selected <> nil) and Assigned(FOnItemDblClick) then
    FOnItemDblClick(self, GetSelectedItem);

  Open;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.ColClick(Column: TListColumn);
begin
  inherited;
  FOldSortDirection := FSortDirection;
  if FClickedColumn = Column.Index then
    begin
      if FSortDirection = sdAscending then
        FSortDirection := sdDescending
      else
        FSortDirection := sdAscending;
      SortColumn;
    end
  else
    begin
      FSortDirection := sdAscending;
      SortColumn(Column.Index);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SortColumn(aColumn:TLMDShellItemDetailsColumn);
begin
  SortColumn(aColumn, FSortDirection);
end;
{------------------------------------------------------------------------------}
procedure TLMDShellList.SortColumn(aColumn:TLMDShellItemDetailsColumn;aDirection:TLMDShellSortDirection);
var
  i, idx:Integer;
begin
  idx:=-1;
  for i:=0 to Columns.Count-1 do
    if CustomColumns[Integer(Columns[i].Tag)].DataType=aColumn then
      begin
        idx:=i;
        break;
      end;
  SortColumn(idx, aDirection);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SortColumn(aIndex:Integer=-1);
begin
  if aIndex=-1 then aIndex:=FClickedColumn;
  SortColumn(aIndex, FSortDirection);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SortColumn(aIndex:Integer; aDirection:TLMDShellSortDirection);
begin
  if (aIndex<0) or (aIndex>=FColumns.Count) then exit;
  FOldColumn:=FClickedColumn;
  FClickedColumn:=aIndex;
  FSortDirection:=aDirection;
  SortShellItems;
  RepaintEx;
  InvalidateRect(FHeaderHandle, nil, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.CreateWnd;
begin
  inherited;
  if not (csDesigning in ComponentState) then
    if (loAllowDrop in FOptions) then
      RegisterDragDrop(Handle, Self);

  if FShellFolder = nil then
    Exit;

  FHeaderHandle := ListView_GetHeader(Handle);
  FNewHeaderProc := MakeObjectInstance(HeaderWndProc);
  FOldHeaderProc := Pointer(SetWindowLong(FHeaderHandle, GWL_WNDPROC, Cardinal(FNewHeaderProc)));

  FShellFolder.RegisterView(Self);
  SmallImages := FShellFolder.SmallFolderImages;
  LargeImages := FShellFolder.LargeFolderImages;
  ActiveFolderChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DestroyWnd;
begin
  inherited;

  if not (csDesigning in ComponentState) then
    if (loAllowDrop in FOptions) then
      RevokeDragDrop(Handle);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.Edit(const Item: TLVItem);
var
  ShellItem: TLMDCustomShellItem;
  S: string;
begin
  inherited;
  S := LMDPtrToText(Item.pszText);
  ShellItem := GetShellItem(Selected);  //  ???
  if (S = ShellItem.DisplayName) or (S = '') then
    Exit;
  FShellFolder.RenameItem(ShellItem, S);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.Loaded;
begin
  inherited;
  if FFiltered then
  begin
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.Notification(AComponent: TComponent; Operation:
  TOperation);
begin
  inherited;
  if AComponent = FShellFolder then
    if Operation = opRemove then
      Folder := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.Change(Item: TListItem; Change: Integer);
begin
  inherited;

end;

{------------------------------------------------------------------------------}
function TLMDShellList.OwnerDataStateChange(StartIndex, EndIndex: Integer; OldState,
            NewState: TItemStates): Boolean;
begin
  if Assigned(FOnSelectionInfo) then
    begin
      Result := True;
      UpdateSelectionInfo;
    end
  else
    Result := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.CalculateSelectionInfo(var Count: Integer; var Size: Int64);
var
  i: integer;
begin
  Count := 0;
  Size := 0;

  for i := 0 to Items.count - 1 do
    with  Items[i] do
      if  Selected then
        begin
          inc(Count);
          Size := Size + GetShellItem(Items[i]).FileSize;
        end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SelectionChange(Item: TListItem; Selected: Boolean);
begin
  UpdateSelectionInfo;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.UpdateSelectionInfo;
var
  Count: Integer;
  Size: Int64;
begin
  if  Assigned(FOnSelectionInfo) then
    begin
      CalculateSelectionInfo(Count, Size);
      FOnSelectionInfo(Self, Count, Size);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShellList.CreateListItem: TListItem;
begin
  Result := TLMDShellListItem.Create(Items);
end;

{------------------------------------------------------------------------------}
function TLMDShellList.OwnerDataFetch(Item: TListItem; Request: TItemRequest):
  Boolean;
var
  ShellItem: TLMDCustomShellItem;
  Idx: Integer;

  procedure LoadColumnDetails(ShellItem, RootFolder: TLmdCustomShellItem; Handle: THandle);

    procedure LoadCustomColumn;
    var
      i: integer;
      Col: TLMDShellListCustomColumn;
      S: string;
      ColIDs: array of integer;
    begin
      for i := 1 to Columns.Count - 1 do
        begin
          Col := CustomColumns[Integer(Columns[i].Tag)];

          if  Col.FColID > 0 then
            begin
              SetLength(ColIDs, Length(ColIDs) + 1);
              ColIDs[High(ColIDs)] := Col.ColID;
            end;
        end;

      if  Length(ColIDs) > 0  then
        ShellItem.LoadDetailsEx(ColIDs);

      for i := 1 to Columns.Count - 1 do
        begin
          Col := CustomColumns[Integer(Columns[i].Tag)];

          if  Col.FColID > 0 then
            S := ShellItem.DetailsEx[Col.FColID]
          else
            S := ShellItem.GetDetailItem(Col.DataType);

          Item.SubItems.Add(S);
        end;
    end;

    procedure LoadDefaultColumns;
    var
      i: integer;
      ColIDs: array of integer;
    begin
      if Columns.Count > 0 then
      begin
        for i := 1 to Columns.Count - 1 do
          if  CustomColumns[i].FColID < 0 then
            begin
              LoadCustomColumn;
              exit;
            end;

        SetLength(ColIDs, Columns.Count - 1);

        for i := 1 to Columns.Count - 1 do
          ColIDs[i - 1] := Columns[i].Tag;

        ShellItem.LoadDetailsEx(ColIDs);

        for i := Low(ColIDs) to High(ColIDs) do
          Item.SubItems.Add(ShellItem.DetailsEx[ColIDs[i]]);
      end;
    end;

  begin
    if Item.SubItems.Count > 0 then  Exit;

    Item.SubItems.Clear;

    if  DefaultColumns  then
      LoadDefaultColumns
    else
      LoadCustomColumn;

    Item.SubItems.Add('');
  end;

begin
  inherited OwnerDataFetch(Item, Request);
  Result := True;
  if Item.Index >= FItemsCache.Count then
    Exit;
  if SortDirection = sdAscending then
    Idx := Item.Index
  else
    Idx := FItemsCache.Count - Item.Index - 1;

  ShellItem := FItemsCache[Idx];

  Item.Caption := ShellItem.DisplayName;
  Item.ImageIndex := ShellItem.IconIndex;
  Item.OverlayIndex := ShellItem.OverlayIconIndex;
  TLMDShellListItem(Item).fIndex := Idx;
  Item.Cut := ShellItem.IsGhosted;
  if FShowCheckBoxes then
  begin
    if ShellItem.Checked then
      Item.StateIndex := 2
    else
      Item.StateIndex := 1;
  end;
  if (ViewStyle = vsReport) {$ifdef LMDCOMP12}and (not (csDesigning in ComponentState)){$endif} then
    LoadColumnDetails(ShellItem, FShellFolder.ActiveFolder ,handle);
  result := True;
end;

{------------------------------------------------------------------------------}

function TLMDShellList.OwnerDataFind(Find: TItemFind; const FindString: string;
      const FindPosition: TPoint; FindData: Pointer; StartIndex: Integer;
      Direction: TSearchDirection; Wrap: Boolean): Integer;

var
  i: Integer;
  Idx: Integer;
begin
  inherited OwnerDataFind(Find, FindString, FindPosition, FindData, StartIndex,
    Direction, Wrap);
  Idx := -1;
  for i := StartIndex to FItemsCache.Count - 1 do
  begin
    if Find = ifData then
    begin
      if FItemsCache[i].AbsoluteID = PItemIDList(FindData) then
      begin
        Idx := i;
        Break;
      end
    end
    else if Find = ifPartialString then
    begin
      if Pos(FindString, FItemsCache[i].DisplayName) <> 0 then
      begin
        Idx := i;
        Break;
      end
    end
    else if Find = ifExactString then
    begin
      if FItemsCache[i].DisplayName = FindString then
      begin
        Idx := i;
        Break;
      end;
    end;
  end;
  result := Idx;
end;

{------------------------------------------------------------------------------}
function TLMDShellList.OwnerDataHint(StartIndex, EndIndex: Integer): Boolean;
begin
  result := inherited OwnerDataHint(StartIndex, EndIndex);
end;

{------------------------------------------------------------------------------}
function TLMDShellList.CustomDrawItem(Item: TListItem; State: TCustomDrawState;
  Stage: TCustomDrawStage): Boolean;
var
  ShellItem: TLMDCustomShellItem;
  NewState: TCustomDrawState;
begin
  NewState := State;

  if not (csDesigning in ComponentState) then
  begin
    ShellItem := GetShellItem(Item);
    if ShellItem <> nil then
    begin
      if ShellItem.IsGhosted then
        NewState := NewState + [cdsGrayed];
    end;
  end;

  result := inherited CustomDrawItem(Item, NewState, Stage);
exit;
  if Stage = cdPrePaint then
    if not (csDesigning in ComponentState) then
      if (loColorCompressed in FOptions) then
      begin
        ShellItem := GetShellItem(Item);
        if ShellItem <> nil then
        begin
          if ShellItem.DriveType = DRIVE_REMOVABLE then
            Exit;
          if ShellItem.IsCompressed then
            Canvas.Font.Color := FCompressedColor;
        end;
      end;
  DrawOverlayItem(self, Item, NewState, Stage, Result);
end;

{------------------------------------------------------------------------------}
function TLMDShellList.IsCustomDrawn(Target: TCustomDrawTarget; Stage: TCustomDrawStage): Boolean;
begin
  result := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.WndProc(var Message: TMessage);
var
  ShellItem: TLMDCustomShellItem;
  PIDLS: TLMDShellPIDLS;
  Res: Integer;
  Flags: DWORD;
  start, i: integer;
  ch: char;
begin
  with  Message do
    if ((Msg = WM_INITMENUPOPUP) or (Msg = WM_DRAWITEM) or (Msg = WM_MENUCHAR)
    or (Msg = WM_MEASUREITEM)) and Assigned(ContextMenu2) then
    begin
      ContextMenu2.HandleMenuMsg(Msg, wParam, lParam);
      Result := 0;
    end;

  case Message.Msg of
    WM_RESTOREPOPUP:
      PopupMenu := FPopup;

    WM_CONTEXTMENU:
    if (loShellMenu in FOptions) and (PopupMenu = nil)  then
    begin
      Flags := CMF_EXPLORE;
      if (loAllowRename in FOptions) then
        Flags := Flags or CMF_CANRENAME;
      if (loExtendedMenu in Options) and (GetKeyState(VK_SHIFT) < 0) then
        Flags := Flags or $00000080;
      if Selected <> nil then
        begin
          ShellItem := GetShellItem(Selected);
          PIDLS := MakeSelectedList();

          try
            if  Assigned(PIDLS) then
              begin
                Res := LMDShellInvokeContextMenu(Self,
                  ShellItem.ParentShellFolderIntf, PIDLS.List,
                  LoWord(Message.lParam), HiWord(Message.lParam), Handle, Flags);
                if Res = 19 then
                  Selected.EditCaption;
              end;
          finally
            PIDLS.Free;
          end;
        end
      else
        begin
          ShellItem := FShellFolder.ActiveFolder;
          LMDShellInvokeContextMenu(Self, ShellItem.ParentShellFolderIntf,
                ShellItem.RelativeID, LoWord(Message.lParam), HiWord(Message.lParam), Handle, Flags);
        end;
      Exit;
    end;

    WM_DRAWITEM:
    if (Message.WParam = WPARAM(FHeaderID)) and not Assigned(ContextMenu2) then
    begin
      DrawHeaderItem(PDrawItemStruct(Pointer(Message.LParam))^);
      Message.Result := 1;
      Exit;
    end;
    WM_CHAR:
    begin
      i := TWMChar(Message).CharCode;
      ch := chr(i);
      if Selected <> nil then
        start := Selected.Index + 1
      else
        start := 0;
      for i := 0 to Items.Count - 1 do
        Items[i].Selected := false;
      for i := start  to Items.Count - 1 do
        begin
          if (Items[i].Caption[1] = ch) then
            begin
              Items[i].Selected := true;
              break;
            end;
        end;
    end;
    WM_LBUTTONUP, WM_RBUTTONUP: FClickPoint := Point(Message.LParamLo,
      Message.LParamHi);
  end;

  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.WMParentNotify(var Message: TWMParentNotify);
begin
  with Message do
    if (Event = WM_CREATE) and (FHeaderHandle = 0) then
    begin
      FHeaderHandle := ChildWnd;
      FHeaderID := ChildID;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.WMNotify(var Message: TWMNotify);
var

  HD: PHDNotify;
  PItem: PHDItem;

  F: Boolean;
  Column: TListColumn;
  Code: integer;
begin
  inherited;
  F := FALSE;

  if (FHeaderHandle <> 0) and (Message.NMHdr.hWndFrom = FHeaderHandle) then
  begin
    Code := Message.NMHdr.Code;

    if  (Code = HDN_ITEMCHANGING)
        or (Code = HDN_ITEMCHANGED)
        or (Code = HDN_ENDTRACK) then
    begin

      HD := PHDNotify(Message.NMHdr);
      PItem := HD.PItem;

      case  Code of
        HDN_ITEMCHANGING:
          if (PItem.Mask and HDI_FORMAT) <> 0 then
            PItem.fmt := PItem.fmt or HDF_OWNERDRAW;
        HDN_ITEMCHANGED:
          if PItem.mask AND HDI_WIDTH <> 0 then
          begin
            Column := Columns[HD.Item];
            if Column.Width <> PItem.cxy then
            begin
              Column.Width := PItem.cxy;
              F := TRUE;
            end;
          end;
        HDN_ENDTRACK:
            F :=(PItem.mask AND HDI_WIDTH <> 0);
      end;
    end;
  end;

  if  F   then
    PostMessage(Handle, LMDWM_AdjustColumns, 0, 0);
end;

{$HINTS OFF}
{------------------------------------------------------------------------------}

procedure TLMDShellList.CNNotify(var Message: TWMNotify);

var
  i, j: integer;
  NMHdr: TNMHdr;
  NMList: TNMListView;
  Item: TListItem;
  DropEffect: Integer;
  ShellItem: TLMDCustomShellItem;
  DropSource: IDropSource;
  HDragImgList: HIMAGELIST;
  PIDLS: TLMDShellPIDLS;
  P0: TPoint;

  M: PNMListView;
  S: PNMLVODStateChange;

begin

  if (csDesigning in ComponentState)  then
    begin
      inherited ;
      exit;
    end;

  if  Message.NMHdr = nil then

    begin
      inherited ;
      exit;
    end;

  NMHdr := Message.NMHdr^;

  case NMHdr.Code of
    LVN_BEGINDRAG:
      if (loAllowDrag in FOptions) then
      begin
        PIDLS := TLMDShellPIDLS.Create;
        FShellFolder.DragSource := Self;

        NMList := PNMListView(Message.NMHdr)^;

        PIDLS := MakeSelectedList(True);

        DropEffect := 0;
        for i := 0 to Items.count - 1 do
          if Items[i].Selected then
            begin
              ShellItem := GetShellItem(Items[i]);
              DropEffect := DropEffect or Integer(ShellItem.DWFileAttributes);
            end;

        FDataObject := TLMDShellDataObject.Create(PIDLS);
        DropSource := TLMDShellDropSource.Create;

        P0 := Point(0, 0);
        HDragImgList := ListView_CreateDragImage(Handle, NMList.iItem, P0);
        ImageList_BeginDrag(HDragImgList, 0, 0, 0);

        FDropTargetItem := '';
        DoDragDrop(FDataObject, DropSource, DropEffect, DropEffect);
        FShellFolder.DragSource := nil;

        ImageList_EndDrag();
        ImageList_Destroy(HDragImgList);
        PIDLS.Free;
        FDataObject := nil;
        DropSource := nil;
      end;
  end;
  if (csDesigning in ComponentState) and (NMHdr.code = NM_CUSTOMDRAW) then
    Exit
  else
    begin
      inherited;
      case NMHdr.code of
{
        LVN_ODSTATECHANGED:
          begin
            S := PNMLVODStateChange(Message.NMHdr);
          end;
}
        LVN_ITEMCHANGED:
          begin

            M := PNMListView(Message.NMHdr);

            if (M.uChanged = LVIF_STATE) then
              begin
                Item := Items[M.iItem];
                if (M.uOldState and LVIS_SELECTED <> 0)
                    and (M.uNewState and LVIS_SELECTED = 0) then
                  SelectionChange(Item, False)
                else
                if (M.uOldState and LVIS_SELECTED = 0)
                    and (M.uNewState and LVIS_SELECTED <> 0) then
                  SelectionChange(Item, True);
              end;
          end;
      end;
    end;
end;
{$HINTS ON}

{-- public --------------------------------------------------------------------}
constructor TLMDShellList.Create(aOwner: TComponent);
begin
  inherited;
  FShellFolder := nil;
  FTempIcon := TIcon.Create;

  FRefreshTimer := TTimer.Create(self);
  FRefreshTimer.Enabled := False;
  FRefreshTimer.Interval := 500;
  FRefreshTimer.OnTimer := RefreshTimerFire;
  FShellItems := TLMDShellItems.Create;
  FItemsCache := TLMDShellItemsList.Create;
  FOptions := [loShowFolders, loShowNonFolders, loAllowRename, loAllowDrag,
    loAllowDrop, loShellMenu];
  FEnumOptions := [eoFolders, eoNonFolders];
  FCompressedColor := clBlue;
  FFiltered := False;
  FFileFilter := TStringList.Create;
  FFileFilter.Delimiter := ';';
  FSortDirection := sdAscending;
  MultiSelect := True;
  OwnerData := True;
  FShowCheckBoxes := False;
  FClickedColumn := 0;
  FStateImages := TImageList.Create(nil);
  FStateImages.ResourceLoad(rtBitmap, 'LMDSHELLCHECKBOX', clFuchsia);
  FHeaderHandle := 0;
  FHeaderID := 0;
  FOnFilterItem := nil;
  FOnItemDblClick := nil;
  FOnItemSelected := nil;
  FDropTargetItem := '';
  FFileSystemSort := False;
  HideSelection := False;
  FPopup := nil;
  FColumns := TLMDShellListCustomColumns.Create(Self);
  FHighlightedHeaderItem := -1;
  { V2.0 }
  FAutoContext := False;
  FAutoSortSupport := False;
  FOnSelectionInfo := nil;
  FShowOverlayIcon := True;
  FSuppressDefaultAction := False;
  FSuppressFolderNavigation := False;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellList.Destroy;
begin
  if Assigned(FShellFolder) then
    FShellFolder.UnRegisterView(Self);

  FShellFolder := nil;
  ClearLists;

  FTempIcon.Free;
  FShellItems.Free;
  FItemsCache.Free;
  FStateImages.Free;
  FFileFilter.Free;
  FColumns.Free;

  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.Clear;
begin
  FItemsCache.Clear;
  FShellItems.Clear;
  Perform(WM_SETREDRAW, 0, 0);
  if Items.Count <> 0 then
    Items.Clear;
  Perform(WM_SETREDRAW, 1, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.BeginEnumeration;
begin
  ClearLists;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.EndEnumeration;
begin
  SortShellItems;
end;

procedure TLMDShellList.BeginUpdate;
Begin
  Columns.BeginUpdate;
  Items.BeginUpdate;
End;

procedure TLMDShellList.EndUpdate;
Begin
  Items.EndUpdate;
  Columns.EndUpdate;
End;

{------------------------------------------------------------------------------}
function TLMDShellList.TerminateEnumeration: boolean;
begin
  result := False
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.AddItem(aItem: TLMDCustomShellItem);
var
  bAccept: boolean;
begin
  ShellItems.Add(aItem);
  bAccept := True;
  DoFilterItem(aItem, bAccept);
  if bAccept then
    FItemsCache.Add(aItem);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.ActiveFolderChanged;
begin
  if  not Assigned(FShellFolder)  then  exit;

  if  HandleAllocated then
    begin
      Selected := nil;
      OldFolder := nil;
      Columns.BeginUpdate;
      Items.BeginUpdate;
      try
        RootPID := FShellFolder.ActiveFolder.AbsoluteID;
        Selected := nil;
        ItemFocused := nil;
        EnumColumns;
        EnumItems;
        UpdateEx;
      finally
        Items.EndUpdate;
        Columns.EndUpdate;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DoFileChange(aPIDL: PItemIDList);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DoFileCreate(aPIDL: PItemIDList);
var
  tmpPIDL: PItemIDList;
begin
  tmpPIDL := FShellFolder.ID_Clone(aPIDL);
  FShellFolder.ID_RemoveLastID(tmpPIDL);
  DoFolderChange(tmpPIDL);
  FShellFolder.ID_Free(tmpPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DoFileDelete(aPIDL1: PItemIDList; aPIDL2: PItemIDList);
begin
  DoFileCreate(aPIDL1);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DoFileRename(aPIDL1: PItemIDList; aPIDL2: PItemIDList);
begin
  DoFolderRename(aPIDL1, aPIDL2);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DoFolderChange(aPIDL: PItemIDList);
begin
  if not FShellFolder.ID_Equal(aPIDL, FShellFolder.ActiveFolder.AbsoluteID) then
    Exit;

  FRefreshTimer.Enabled := False;
  FRefreshTimer.Enabled := True;
  exit;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DoFolderCreate(aPIDL: PItemIDList);
begin
  DoFileCreate(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DoFolderDelete(aPIDL: PItemIDList);
begin
  DoFileCreate(aPIDL);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.DoFolderRename(aPIDL1: PItemIDList; aPIDL2:
  PItemIDList);
var
  tmpParent1: PItemIDList;
  tmpParent2: PItemIDList;
begin
  tmpParent1 := FShellFolder.ID_Clone(aPIDL1);
  FShellFolder.ID_RemoveLastID(tmpParent1);

  tmpParent2 := FShellFolder.ID_Clone(aPIDL2);
  FShellFolder.ID_RemoveLastID(tmpParent2);

  if FShellFolder.ID_Equal(tmpParent1, FShellFolder.ActiveFolder.AbsoluteID)
    then
    DoFolderChange(tmpParent1)
  else if FShellFolder.ID_Equal(tmpParent2, FShellFolder.ActiveFolder.AbsoluteID)
    then
    DoFolderChange(tmpParent2);

  FShellFolder.ID_Free(tmpParent1);
  FShellFolder.ID_Free(tmpParent2);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.CopyToClipboard;
var
  ShellItem: TLMDCustomShellItem;
begin
  ShellItem := GetSelectedItem;

  if Assigned(ShellItem) and ShellItem.CanCopy then
     ExecuteCommand('copy');
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.CutToClipboard;
var
  ShellItem: TLMDCustomShellItem;
begin
  ShellItem := GetSelectedItem;

  if Assigned(ShellItem) and ShellItem.CanCopy then
    ExecuteCommand('cut');
end;

{$HINTS OFF}
{------------------------------------------------------------------------------}
procedure TLMDShellList.PasteFromClipboard;
var
  tmpPIDL: PItemIDList;
  ShellItem: TLMDCustomShellItem;
begin
  if FShellFolder = nil then
    Exit;
  if FShellFolder.ActiveFolder = nil then
    Exit;

  ShellItem := nil;
  if Selected <> nil then
    ShellItem := GetShellItem(Selected)
  else
    ShellItem := FShellFolder.ActiveFolder;
  if ShellItem <> nil then
  begin
    tmpPIDL := ShellItem.RelativeID;
    if ShellItem.CanPaste then
      LMDShellDoContextMenuVerb(nil, ShellItem.ParentShellFolderIntf, tmpPIDL,
        Handle, 'paste');
  end;
end;
{$HINTS ON}

{------------------------------------------------------------------------------}
procedure TLMDShellList.DeleteItems;
begin
  ExecuteCommand('delete');
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.ShowProperties;
begin
  if FShellFolder = nil then
    Exit;
  if Selected = nil then
    Exit;
  FShellFolder.ShowPropertySheet(GetShellItem(Selected));
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.OpenWith;
var
  //cmd: string;
  SI: TLMDCustomShellItem;
begin
  SI := GetShellItem(Selected);

  if SI = nil then
    Exit;
  // for folders simulate Open command

  if SI.IsFolder then
    FShellFolder.ChDir(SI.AbsoluteID)
  else
  begin
    //cmd := 'rundll32.exe shell32.dll,OpenAs_RunDLL "' + SI.Path + '"';
    //WinExec(Int_RefA(cmd), 0);
    ShellExecute(0, 'open', 'rundll32.exe', int_Ref('shell32.dll,OpenAs_RunDLL ' + SI.Path + ''), int_Ref(''), 0);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.CopyFileNameAsText;
var
  i: integer;
  Buf: string;
begin
  Buf := '';
  for i := 0 to SelCount - 1 do
    Buf := Buf + ExtractFileName(SelectedItems[i].DisplayName) + #13#10;
  LMDSetClipboardText(Buf);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.CopyPathAsText;
var
  i: integer;
  Buf: string;
begin
  Buf := '';
  for i := 0 to SelCount - 1 do
    Buf := Buf + SelectedItems[i].Path + #13#10;
  LMDSetClipboardText(Buf);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.InvertSelection;
var
  i: integer;
begin
  for i := 0 to Items.count - 1 do
    items[i].Selected := not items[i].Selected;
end;

{------------------------------------------------------------------------------}
function  TLMDShellList.NewFolder: Boolean;
var
  i: integer;
  Path: string;
  S: TListItem;
begin
  Result := False;
  if (FShellFolder = nil) or IsEditing then
    Exit;
  Path := FShellFolder.NewFolder;
  RefreshData;
  S := nil;

  for i := 0 to Items.count - 1 do
    if LMDAnsiSameText(Path, GetShellItem(Items[i]).Path) then
    begin
      S := Items[i];
      Break;
    end;

  if  Assigned(S) then
    begin
      Result := True;
      Selected := S;
      S.MakeVisible(False);
      S.EditCaption;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDShellList.Store(const aPath: string);
var
  R: TRegistry;
  I: integer;
begin
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    if R.OpenKey('\Software' + aPath, true) then
    begin
      R.WriteString('AutoSortSupport', IntToStr(integer(FAutoSortSupport)));
      R.WriteString('ViewStyle', IntToStr(integer(ViewStyle)));
      R.WriteString('DefaultColumns', IntToStr(integer(DefaultColumns)));
      if DefaultColumns then
      begin
        R.WriteString('Columns_count', IntToStr(Columns.count));
        for I := 0 to Columns.Count - 1 do
          R.WriteString('Column_' + IntToStr(I),
            IntToStr(Columns.Items[I].Width));
      end
      else
      begin
        R.WriteString('Columns_count', IntToStr(CustomColumns.Count));
        for I := 0 to CustomColumns.Count - 1 do
        begin
          R.WriteString('Column_' + IntToStr(I) + '_Alignment',
            IntToStr(Integer(CustomColumns[I].Alignment)));
          R.WriteString('Column_' + IntToStr(I) + '_AutoSize',
            IntToStr(Integer(CustomColumns[I].AutoSize)));
          R.WriteString('Column_' + IntToStr(I) + '_Caption',
            CustomColumns[I].Caption);
          R.WriteString('Column_' + IntToStr(I) + '_DataType',
            IntToStr(Integer(CustomColumns[I].DataType)));
          R.WriteString('Column_' + IntToStr(I) + '_MaxWidth',
            IntToStr(CustomColumns[I].MaxWidth));
          R.WriteString('Column_' + IntToStr(I) + '_MinWidth',
            IntToStr(CustomColumns[I].MinWidth));
          R.WriteString('Column_' + IntToStr(I) + '_Width',
            IntToStr(CustomColumns[I].Width));
        end;
      end;
    end;
  finally
    R.CloseKey;
    R.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDShellList.Restore(const aPath: string);
var
  R: TRegistry;
  I, ColCount: integer;
  Col: TLMDShellListCustomColumn;
begin
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    if R.OpenKey('\Software' + aPath, false) then
    begin
      AutoSortSupport := boolean(LMDSafeStrToInt(R.ReadString('AutoSortSupport')));
      ViewStyle := TViewStyle(LMDSafeStrToInt(R.ReadString('ViewStyle')));
      DefaultColumns := boolean(LMDSafeStrToInt(R.ReadString('DefaultColumns')));
      ColCount := LMDSafeStrToInt(R.ReadString('Columns_count'));
      if DefaultColumns then
      begin
        for I := 0 to ColCount - 1 do
          if I < Columns.Count then
            Columns.Items[I].Width := LMDSafeStrToInt(R.ReadString('Column_' +
              IntToStr(I)));
      end
      else
      begin
        CustomColumns.Clear;
        for I := 0 to ColCount - 1 do
        begin
          Col := TLMDShellListCustomColumn(CustomColumns.Add);
          //                ColumnInitialization := True;
          Col.Alignment := TAlignment(LMDSafeStrToInt(R.ReadString('Column_' +
            IntToStr(I) + '_Alignment')));
          Col.AutoSize := boolean(LMDSafeStrToInt(R.ReadString('Column_' +
            IntToStr(I) + '_AutoSize')));
          Col.Caption := R.ReadString('Column_' + IntToStr(I) + '_Caption');
          Col.DataType :=
            TLMDShellItemDetailsColumn(LMDSafeStrToInt(R.ReadString('Column_' +
            IntToStr(I) + '_DataType')));
          Col.MaxWidth := LMDSafeStrToInt(R.ReadString('Column_' + IntToStr(I) +
            '_MaxWidth'));
          Col.MinWidth := LMDSafeStrToInt(R.ReadString('Column_' + IntToStr(I) +
            '_MinWidth'));
          Col.Width := LMDSafeStrToInt(R.ReadString('Column_' + IntToStr(I) +
            '_Width'));
          Col.ImageIndex := -1;
        end;
      end;
      EnumColumns;
    end;
  finally
    R.CloseKey;
    R.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDShellList.Editable: Boolean;
begin
  result := Enabled and Focused and Assigned(FShellFolder);
end;

{ ---------------------------------------------------------------------------- }
function TLMDShellList.CanCut: Boolean;
var i:integer;
begin
  result := Editable and (SelCount > 0);
  for i:=0 to SelCount-1 do Begin
    result := result and (IsElement(SFGAO_CANMOVE,SelectedItems[i].DWFileAttributes));
    if NOT result then
      Break;
  End;
end;

{ ---------------------------------------------------------------------------- }
function TLMDShellList.CanCopy: Boolean;
var i:integer;
begin
  result := Editable and (SelCount > 0);
  for i:=0 to SelCount-1 do Begin
    result := result and (IsElement(SFGAO_CANCOPY,SelectedItems[i].DWFileAttributes));
    if NOT result then
      Break;
  End;
end;

{ ---------------------------------------------------------------------------- }
function TLMDShellList.CanDelete: Boolean;
var i:integer;
begin
  result := Editable and (SelCount > 0);
  for i:=0 to SelCount-1 do Begin
    result := result and (IsElement(SFGAO_CANDELETE,SelectedItems[i].DWFileAttributes));
    if NOT result then
      Break;
  End;
end;

{ ---------------------------------------------------------------------------- }
function TLMDShellList.CanPaste: Boolean;
begin
  result := Editable and (Clipboard.HasFormat(LMDShPIDLCFormat));
end;

{ ---------------------------------------------------------------------------- }
function TLMDShellList.CanRename: Boolean;
var
  S: TListItem;
begin
  S := Selected;
  result := Assigned(S) and Editable and CanEdit(S) and not IsEditing;
end;

{ ---------------------------------------------------------------------------- }
function TLMDShellList.CanAccessItem: Boolean;
begin
  result := Editable and (SelCount > 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDShellList.Controller: TLMDCustomShellController;
begin
  result := FShellFolder;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellList.Open;
var
  Itm: TLMDCustomShellItem;
  lOpenFolder: boolean;
begin
  if Selected = nil then
    exit;
  Itm := GetShellItem(Selected);
  if  Assigned(Itm) then
    if Itm.IsFolder then
    begin
      lOpenFolder := (loUseSuppressFolderNavigation in Options) and
        not SuppressFolderNavigation or not (loUseSuppressFolderNavigation in Options) and not FSuppressDefaultAction;
      if lOpenFolder then
        FShellFolder.ChDir(Itm.AbsoluteID)
    end
    else
      if  not FSuppressDefaultAction  then
        FShellFolder.ExecuteDefault(Itm);
end;

{ ---------------------------------------------------------------------------- }
function  TLMDShellList.Rename: Boolean;
begin
  Result := CanRename;
  if  Result  then
    Selected.EditCaption;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellList.CopyItems(const Target: string);
var
  i: Integer;
  ShellItem: TLMDCustomShellItem;
  sItems: string;
begin
  sItems := '';
  if Selected <> nil then
  begin
    ShellItem := GetShellItem(Selected);
    if ShellItem.CanCopy then
    begin
      for i := 0 to SelCount - 1 do
        sItems := sItems + SelectedItems[i].PathName + #0;
      FShellFolder.CopyFiles(sItems, Target + #0);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDShellList.MoveItems(const Target: string);
var
  i: Integer;
  ShellItem: TLMDCustomShellItem;
  sItems: string;
begin
  sItems := '';
  if Selected <> nil then
  begin
    ShellItem := GetShellItem(Selected);
    if ShellItem.CanCopy then
    begin
      for i := 0 to SelCount - 1 do
        sItems := sItems + SelectedItems[i].PathName + #0;
      FShellFolder.MoveFiles(sItems, Target + #0);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.RefreshData;
var
  i: integer;
  Itm: TListItem;
  SelItems: TStringList;
  FocusedItem, S: string;
  CheckedItems: TStringList;
begin
  SelItems := TStringList.Create;
  CheckedItems := TStringList.Create;
  Items.BeginUpdate;
  try
    for i := 0 to Items.Count - 1 do
      if  Items[i].Selected then
        SelItems.Add(GetShellItem(Items[i]).DisplayName);

    for i := 0 to FShellItems.count - 1 do
      if FShellItems[i].Checked then
        CheckedItems.Add(FShellItems[i].DisplayName);

    if ItemFocused <> nil then
      FocusedItem := GetShellItem(ItemFocused).DisplayName
    else
      FocusedItem := '';

    RootPID := FShellFolder.ActiveFolder.AbsoluteID;
    Selected := nil;
    ItemFocused := nil;
    EnumItems;
    UpdateEx;

    for i := 0 to FShellItems.count - 1 do
      if  CheckedItems.IndexOf(FShellItems[i].DisplayName) >= 0 then
        FShellItems[i].Checked := True;

    for i := 0 to Items.Count - 1 do
      begin
        Itm := Items[i];
        S := GetShellItem(Itm).DisplayName;

        if  SelItems.IndexOf(S) >= 0 then
          Itm.Selected := True;

        if  (FocusedItem <> '') and LMDAnsiSameText(FocusedItem, S)  then
          Itm.Focused := True;
      end;

  finally
    SelItems.Free;
    CheckedItems.Free;
    Items.EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.LMDWMRefresh(var Msg: TMessage);
begin
  Msg.Result := 1;
  RefreshData;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.NeedRefresh;
begin
  if  HandleAllocated then
    PostMessage(Handle, LMDWM_Refresh, 0, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.RefreshTimerFire(Sender: TObject);
begin
  FRefreshTimer.Enabled := False;
  NeedRefresh;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.EnumColumns;

  function AddColumn(var SD: TShellDetails; iCol: integer; Kind: integer;
                     iWidth: integer = 0): boolean;
  var
    PIDL: PItemIDList;
    ColName: string;
    DataType: TLMDShellItemDetailsColumn;
    Col: TListColumn;
    i: integer;
  begin
    PIDL := nil;
    //ColName := Trim(String(LMDStrRetToStringEx(PIDL, SD.Str)));
    ColName := Trim(LMDStrRetToStr(PIDL, SD.Str));

    if ColName <> '' then
    begin
      Result := True;
      Col := Columns.Add;

      with Col do
      begin
        Caption := ColName;
        Tag := iCol;
        ImageIndex := SD.fmt;

        case SD.fmt of
          LVCFMT_CENTER: Alignment := taCenter;
          LVCFMT_LEFT: Alignment := taLeftJustify;
          LVCFMT_RIGHT: Alignment := taRightJustify;
        end;

        if  iWidth <= 0 then
          Width := SD.cxChar * Canvas.TextWidth('X')
        else
          Width := iWidth;
      end;

      case  Kind of
        PID_STG_NAME:         DataType := cdName;
        PID_STG_STORAGETYPE:  DataType := cdTypeName;
        PID_STG_SIZE:         DataType := cdSize;
        PID_STG_WRITETIME:    DataType := cdWriteDateTime;
        PID_STG_ATTRIBUTES:   DataType := cdAttributes;
        else
          if  Columns.Count = 1 then
            DataType := cdName
          else
            DataType := cdCustom
      end;

      for i := CustomColumns.Count to iCol do
        TLMDShellListCustomColumn(CustomColumns.Add).FColID := -1;

      CustomColumns[iCol].FDataType := DataType;
      CustomColumns[iCol].FColID := iCol;
    end
    else
      Result := True;
  end;

  procedure AddDefaultColumn(const ACaption: string; const AAlignment:
      TAlignment; AWidth: integer; DataType: TLMDShellItemDetailsColumn);
  var
    i, iCol: integer;
  begin
    with Columns.Add do
    begin
      Caption := ACaption;
      Alignment := AAlignment;
      Width := AWidth * Canvas.TextWidth('X');
      Tag := Index;
      iCol := Tag;
    end;

    for i := CustomColumns.Count to Columns.Count - 1 do
      TLMDShellListCustomColumn(CustomColumns.Add).FColID := -1;

    CustomColumns[iCol].FDataType := DataType;
    CustomColumns[iCol].FColID := -1;
  end;

  procedure AddDefaultColumns(const ColCount: integer = 1);
  var
    i: integer;
  begin
    if ColCount > 0 then
      AddDefaultColumn(IDSHELL_ColumnName, taLeftJustify, 35, cdName);
    if ColCount > 1 then
      AddDefaultColumn(IDSHELL_ColumnSize, taRightJustify, 10, cdSize);
    if ColCount > 2 then
      AddDefaultColumn(IDSHELL_ColumnType, taLeftJustify, 12, cdTypeName);
    if ColCount > 3 then
      AddDefaultColumn(IDSHELL_ColumnModified, taLeftJustify, 16, cdWriteDateTime);

    for i := 0 to Columns.Count - 1 do
      Columns[i].ImageIndex := -1;
  end;

var
  Col: Integer;
  SD: TShellDetails;
  ColFlags: DWORD;
  SF2: IShellFolder2;
  ISD: IShellDetails;
  SF: IShellFolder;
  ii: integer;
  SCID: TShColumnID;
  dCol: TLMDShellListCustomColumn;
begin
  if not Assigned(FShellFolder) then
    Exit;

  Columns.BeginUpdate;
  CustomColumns.FColumnChanged := True;
  try

    Col := 0;

    FillChar(SD, SizeOf(SD), 0);

    Columns.Clear;

    if  DefaultColumns or (CustomColumns.Count = 0) then
      begin
        SF := GetIShellFolder(RootPid);

        if  not Supports(SF, IShellFolder2, SF2)  then
          SF2 := nil;

        if Assigned(SF2) then // Have IShellFolder2 interface
        begin
          while Succeeded(SF2.GetDetailsOf(nil, Col, SD)) do
            begin
              ColFlags := 0;
              ii := SF2.GetDefaultColumnState(Col, ColFlags);
              if  Failed(ii) or Boolean(ColFlags and SHCOLSTATE_ONBYDEFAULT)
                      then
                begin

                  {$ifdef LMDCOMP14}
                  SF2.MapColumnToSCID(Col, SCID);
                  {$else}
                  SF2.MapNameToSCID(PWChar(Col), SCID);
                  {$endif}

                  AddColumn(SD, Col, SCID.pid);
                end;
              StrRetFree(SD.Str);
              Inc(Col);
            end;
        end;
      end;

    if  DefaultColumns or (CustomColumns.Count = 0) then
      begin
        SF2 := nil;

        if  Columns.Count = 0   then
          begin
            Col := 0;
            ISD := GetIShellDetails(SF, RootPid);
            if Assigned(ISD) then
              begin
                while (ISD.GetDetailsOf(nil, Col, SD) = S_OK) do
                  begin
                    if AddColumn(SD, Col, 0) then
                      begin
                        Inc(Col);
                        StrRetFree(SD.Str);
                      end
                    else
                      Break;
                  end;
              end;
          end;
      end;

    if  DefaultColumns and (Columns.Count = 0) then
      AddDefaultColumns(4);

    if  Columns.Count = 0   then
      for Col := 0 to CustomColumns.Count - 1 do
        begin
          dCol := CustomColumns[Col];

          with Columns.Add do
            begin
              Caption := dCol.Caption;
              Tag := Col;
              Alignment := dCol.Alignment;
              AutoSize := dCol.AutoSize;

              if  dCol.Width > 0  then
                Width := dCol.Width;

              if  dCol.MinWidth > 0  then
                MinWidth := dCol.MinWidth;

              if  dCol.MaxWidth > 0  then
                MaxWidth := dCol.MaxWidth;
            end;
        end;

    if  (Columns.Count = 0) then
      if  FShellFolder.ActiveFolder.IsFileSystem then
        AddDefaultColumns(4)
      else
        AddDefaultColumns(1);
  finally
    if Columns.Count = 1 then
      Columns[0].Width := ClientWidth;
    CustomColumns.FColumnChanged := False;
    Columns.EndUpdate;
    PostMessage(Handle, LMDWM_AdjustColumns, 0, 0);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.AdjustColumnWidth;
var
  WP: TWindowPos;
  i: integer;
  F: Boolean;
begin
  if  (ViewStyle = vsReport) then
  begin
    F := False;

    for i := 0 to Columns.Count - 1 do
      if  Columns[i].AutoSize then
        begin
          F := True;
          break;
        end;

    if  F then
      begin

        FillChar(WP, sizeof(WP), 0);
        SendMessage(Handle, WM_WINDOWPOSCHANGED, 0, LPARAM(@WP));

      end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDShellList.CanResize(var NewWidth, NewHeight: Integer): Boolean;
begin
  Result := inherited CanResize(NewWidth, NewHeight);

  if  Result
      and ((NewWidth <> Width) or (NewHeight <> Height))  then
    PostMessage(Handle, LMDWM_AdjustColumns, 0, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.LMDWMAdjustColumns(var Message: TMessage);
begin
  AdjustColumnWidth;
end;

{------------------------------------------------------------------------------}
function TLMDShellList.getLMDPackage:TLMDPackageID;
begin
  result:=pi_LMD_SHELL;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellList.SetSuppressDefaultAction(const Value: Boolean);
begin
  FSuppressDefaultAction := Value;
end;

initialization

  if not LMDDisableOleinit then
    OleInitialize(nil);

finalization

  if not LMDDisableOleinit then
    OleUninitialize;


end.
