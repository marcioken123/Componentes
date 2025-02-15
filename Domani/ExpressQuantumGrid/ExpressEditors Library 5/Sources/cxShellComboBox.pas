
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressEditors                                               }
{                                                                    }
{       Copyright (c) 1998-2007 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxShellComboBox;

{$I cxVer.inc}

interface

uses
  Windows, Messages, Classes, ComCtrls, Controls, ImgList, ShlObj, cxClasses,
  cxContainer, cxDataUtils, cxDropDownEdit, cxEdit, cxGraphics, cxTextEdit,
  cxShellListView, cxShellTreeView, cxShellCommon, cxShellControls;

type
  TcxShellComboBoxViewOption = (scvoShowFiles, scvoShowHidden);
  TcxShellComboBoxViewOptions = set of TcxShellComboBoxViewOption;

  TcxPopupShellTreeViewOption = (tvoContextMenus, tvoHotTrack, tvoShowButtons,
    tvoShowInfoTips, tvoShowLines, tvoShowRoot, tvoShowToolTip,
    tvoRightClickSelect);
  TcxPopupShellTreeViewOptions = set of TcxPopupShellTreeViewOption;

  TcxShellComboBoxShowFullPath = (sfpNever, sfpAlways, sfpNotFocused);

  { TcxShellComboBoxViewInfo }

  TcxShellComboBoxViewInfo = class(TcxCustomTextEditViewInfo)
  public
    ShellIconPosition: TPoint;
    ShellSysIconIndex: Integer;
    ShellSysIconOverlayIndex: Integer;
    procedure Offset(DX, DY: Integer); override;
    procedure Paint(ACanvas: TcxCanvas); override;
  end;

  { TcxShellComboBoxViewData }

  TcxCustomShellComboBoxProperties = class;

  TcxShellComboBoxViewData = class(TcxCustomDropDownEditViewData)
  private
    function GetProperties: TcxCustomShellComboBoxProperties;
  protected
    function InternalEditValueToDisplayText(AEditValue: TcxEditValue): string; override;
    function InternalGetEditConstantPartSize(ACanvas: TcxCanvas; AIsInplace: Boolean;
      AEditSizeProperties: TcxEditSizeProperties; var MinContentSize: TSize;
      AViewInfo: TcxCustomEditViewInfo): TSize; override;
  public
    procedure Calculate(ACanvas: TcxCanvas; const ABounds: TRect;
      const P: TPoint; Button: TcxMouseButton; Shift: TShiftState;
      AViewInfo: TcxCustomEditViewInfo; AIsMouseEvent: Boolean); override;
    procedure EditValueToDrawValue(ACanvas: TcxCanvas;
      const AEditValue: TcxEditValue; AViewInfo: TcxCustomEditViewInfo); override;
    function GetClientExtent(ACanvas: TcxCanvas;
      AViewInfo: TcxCustomEditViewInfo): TRect; override;
    property Properties: TcxCustomShellComboBoxProperties read GetProperties;
  end;

  { TcxShellComboBoxRoot }

  TcxShellComboBoxRoot = class(TcxCustomShellRoot)
  private
    FOnChange: TNotifyEvent;
  protected
    procedure RootUpdated; override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  { TcxShellComboBoxLookupData }

  TcxCustomShellComboBox = class;

  TcxShellComboBoxLookupData = class(TcxCustomTextEditLookupData)
  private
    function GetEdit: TcxCustomShellComboBox;
  protected
    function GetItem(Index: Integer): string; override;
    function GetItemCount: Integer; override;
    procedure ListChanged; override;
    property Edit: TcxCustomShellComboBox read GetEdit;
  end;

  { TcxCustomShellComboBoxProperties }

  TcxCustomShellComboBoxProperties = class(TcxCustomPopupEditProperties)
  private
    FFastSearch: Boolean;
    FIncrementalSearch: Boolean;
    FRoot: TcxShellComboBoxRoot;
    FShowFullPath: TcxShellComboBoxShowFullPath;
    FStoreRelativePath: Boolean;
    FTreeViewOptions: TcxPopupShellTreeViewOptions;
    FViewOptions: TcxShellComboBoxViewOptions;
    FOnAddFolder: TcxShellAddFolderEvent;
    FOnRootSettingsChanged: TNotifyEvent;
    procedure DoRootSettingsChanged;
    function GetDropDownSizeable: Boolean;
    function GetDropDownWidth: Integer;
    procedure RootChangeHandler(Sender: TObject);
    procedure RootSettingsChanged(Sender: TObject);
    procedure SetDropDownSizeable(Value: Boolean);
    procedure SetDropDownWidth(Value: Integer);
    procedure SetFastSearch(Value: Boolean);
    procedure SetIncrementalSearch(Value: Boolean);
    procedure SetShowFullPath(Value: TcxShellComboBoxShowFullPath);
    procedure SetStoreRelativePath(Value: Boolean);
    procedure SetTreeViewOptions(Value: TcxPopupShellTreeViewOptions);
    procedure SetViewOptions(Value: TcxShellComboBoxViewOptions);
  protected
    class function GetPopupWindowClass: TcxCustomEditPopupWindowClass; override;
    class function GetViewDataClass: TcxCustomEditViewDataClass; override;
    procedure CheckRoot;
    function EditValueToPIDL(const AEditValue: TcxEditValue): PItemIDList; virtual;
    function GetShellViewOptions: TcxShellViewOptions;
    procedure RootChanged; virtual;
    property OnRootSettingsChanged: TNotifyEvent read FOnRootSettingsChanged
      write FOnRootSettingsChanged;
  public
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function CompareDisplayValues(
      const AEditValue1, AEditValue2: TcxEditValue): Boolean; override;
    class function GetContainerClass: TcxContainerClass; override;
    function GetDisplayText(const AEditValue: TcxEditValue;
      AFullText: Boolean = False; AIsInplace: Boolean = True): WideString; override;
    function GetEditValueSource(AEditFocused: Boolean): TcxDataEditValueSource; override;
    class function GetLookupDataClass: TcxInterfacedPersistentClass; override;
    procedure GetShellDisplayValue(const AEditValue: TcxEditValue;
      AFocused: Boolean; out AText: string;
      out AShellSysIconIndex, AShellSysIconOverlayIndex: Integer);
    class function GetViewInfoClass: TcxContainerViewInfoClass; override;
    function IsEditValueValid(var EditValue: TcxEditValue;
      AEditFocused: Boolean): Boolean; override;
    // !!!
    property DropDownSizeable: Boolean read GetDropDownSizeable write SetDropDownSizeable default True;
    property DropDownWidth: Integer read GetDropDownWidth write SetDropDownWidth
      default 250;
    property FastSearch: Boolean read FFastSearch write SetFastSearch default False;
    property IncrementalSearch: Boolean read FIncrementalSearch
      write SetIncrementalSearch default False;
    property Root: TcxShellComboBoxRoot read FRoot write FRoot;
    property ShowFullPath: TcxShellComboBoxShowFullPath read FShowFullPath
      write SetShowFullPath default sfpNever;
    property StoreRelativePath: Boolean read FStoreRelativePath write SetStoreRelativePath default True;
    property TreeViewOptions: TcxPopupShellTreeViewOptions read FTreeViewOptions
      write SetTreeViewOptions default [tvoContextMenus, tvoHotTrack,
      tvoShowButtons, tvoShowLines, tvoShowRoot, tvoShowToolTip];
    property ViewOptions: TcxShellComboBoxViewOptions read FViewOptions
      write SetViewOptions default [];
    property OnAddFolder: TcxShellAddFolderEvent read FOnAddFolder
      write FOnAddFolder;
  end;

  { TcxShellComboBoxProperties }

  TcxShellComboBoxProperties = class(TcxCustomShellComboBoxProperties)
  published
    property Alignment;
    property AssignedValues;
    property AutoSelect;
    property ButtonGlyph;
    property ClearKey;
    property DropDownSizeable;
    property DropDownWidth;
    property FastSearch;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property IncrementalSearch;
    property PopupAlignment;
    property ReadOnly;
    property Root;
    property ShowFullPath;
    property StoreRelativePath;
    property TreeViewOptions;
    property UseLeftAlignmentOnEditing;
    property ValidateOnEnter;
    property ViewOptions;
    property OnAddFolder;
    property OnChange;
    property OnCloseUp;
    property OnEditValueChanged;
    property OnPopup;
  end;

  { TcxPopupShellTreeView }

  TcxPopupShellTreeView = class(TcxShellTreeView)
  private
    function GetEdit: TcxCustomShellComboBox;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DoSelectNode(AClosePopupReason: TcxEditCloseUpReason); virtual;
    property Edit: TcxCustomShellComboBox read GetEdit;
  end;

  TcxPopupShellTreeViewClass = class of TcxPopupShellTreeView;

  { TcxShellComboBoxPopupWindow }

  TcxShellComboBoxPopupWindow = class(TcxPopupEditPopupWindow)
  private
    procedure WMEnable(var Message: TMessage); message WM_ENABLE;
  end;

  { TcxCustomShellComboBox }

  TcxCustomShellComboBox = class(TcxCustomPopupEdit)
  private
    FAbsolutePIDL: PItemIDList;
    FIsDependentShellControlsNotification, FNotificationFromDependentShellControls: Boolean;
    FIsSelectedNodeChangeEventLocked: Boolean;
    FPopupShellTreeView: TcxPopupShellTreeView;
    FPopupWindowShowing: Boolean;
    FShellListView: TcxCustomShellListView;
    FShellTreeView: TcxCustomShellTreeView;
    procedure AddFolderHandler(Sender: TObject; AFolder: TcxShellFolder;
      var ACanAdd: Boolean);
    function GetAbsolutePIDL: PItemIDList;
    function GetActiveProperties: TcxCustomShellComboBoxProperties;
    function GetPath: string;
    function GetProperties: TcxCustomShellComboBoxProperties;
//    function GetRelativePath: string;
    function GetViewInfo: TcxShellComboBoxViewInfo;
    procedure RootChangeHandler(Sender: TObject);
    procedure RootSettingsChanged(Sender: TObject);
    procedure SetAbsolutePIDL(Value: PItemIDList);
    procedure SetPath(const Value: string);
    procedure SetProperties(Value: TcxCustomShellComboBoxProperties);
    procedure SetRelativePIDL(Value: PItemIDList);
//    procedure SetRelativePath(const Value: string);
    procedure SetShellListView(Value: TcxCustomShellListView);
    procedure SetShellTreeView(Value: TcxCustomShellTreeView);
    procedure DSMDoNavigate(var Message: TMessage); message DSM_DONAVIGATE;
    procedure DSMSynchronizeRoot(var Message: TMessage); message DSM_SYNCHRONIZEROOT;
  protected
    function CanDropDown: Boolean; override;
    procedure CloseUp(AReason: TcxEditCloseUpReason); override;
    procedure CreatePopupWindow; override;
    procedure DoInitPopup; override;
    procedure DropDown; override;
    procedure HandleSelectItem(Sender: TObject); override;
    procedure Initialize; override;
    procedure InitializePopupWindow; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PopupWindowShowed(Sender: TObject); override;
    procedure PopupWindowShowing(Sender: TObject); override;
    procedure PropertiesChanged(Sender: TObject); override;
    procedure SynchronizeDisplayValue; override;
    procedure SynchronizeEditValue; override;
    function CheckAbsolutePIDL(var APIDL: PItemIDList;
      ACheckObjectExistence: Boolean): Boolean;
    procedure CheckPopupShellTreeView;
    function FindNodeAmongExpandedNodes(ANodeText: string): TTreeNode;
    function GetPopupShellTreeViewClass: TcxPopupShellTreeViewClass; virtual;
    procedure InternalSetAbsolutePIDL(Value: PItemIDList);
    procedure InternalSynchronizeEditValue(APIDL: PItemIDList;
      const ADisplayText: string = ''); virtual;
    procedure InvalidateShellIconRect;
    procedure SelectedNodeChangeHandler(Sender: TObject; ANode: TTreeNode); virtual;
    procedure SynchronizeDependentShellControls;
    procedure SynchronizePopupShellTreeView;
    function TraverseAllVisibleNodes(var ANodeIndex: Integer;
      ATreeNode: TTreeNode = nil): TTreeNode;
    property ShellListView: TcxCustomShellListView read FShellListView write SetShellListView;
    property ShellTreeView: TcxCustomShellTreeView read FShellTreeView write SetShellTreeView;
    property ViewInfo: TcxShellComboBoxViewInfo read GetViewInfo;
  public
    destructor Destroy; override;
    function CanHide: Boolean; override;
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    property AbsolutePIDL: PItemIDList read GetAbsolutePIDL write SetAbsolutePIDL;
    property AbsolutePath: string read GetPath write SetPath; // deprecated
    property ActiveProperties: TcxCustomShellComboBoxProperties
      read GetActiveProperties;
    property Path: string read GetPath write SetPath;
    property PopupShellTreeView: TcxPopupShellTreeView read FPopupShellTreeView;
    property Properties: TcxCustomShellComboBoxProperties read GetProperties
      write SetProperties;
    property RelativePIDL: PItemIDList write SetRelativePIDL; // TODO
//    property RelativePath: string read GetRelativePath write SetRelativePath;
  end;

  { TcxShellComboBox }

  TcxShellComboBox = class(TcxCustomShellComboBox)
  private
    function GetActiveProperties: TcxShellComboBoxProperties;
    function GetProperties: TcxShellComboBoxProperties;
    procedure SetProperties(Value: TcxShellComboBoxProperties);
  public
    class function GetPropertiesClass: TcxCustomEditPropertiesClass; override;
    property ActiveProperties: TcxShellComboBoxProperties
      read GetActiveProperties;
  published
    property Align;
    property Anchors;
    property AutoSize;
    property BeepOnEnter;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ImeMode;
    property ImeName;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Properties: TcxShellComboBoxProperties read GetProperties
      write SetProperties;
    property ShellListView;
    property ShellTreeView;
    property ShowHint;
    property Style;
    property StyleDisabled;
    property StyleFocused;
    property StyleHot;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

var
  cxShellComboBoxImageList: TCustomImageList;

implementation

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  ActiveX, CommCtrl, Graphics, ShellAPI, SysUtils, cxDBEdit, cxEditPaintUtils,
  cxEditUtils, cxExtEditConsts, cxFilterControlUtils, cxVariants, cxControls;

type
  TcxDBTextEditDataBindingAccess = class(TcxDBTextEditDataBinding);
  TcxCustomEditAccess = class(TcxCustomEdit);
  TcxInnerShellListViewAccess = class(TcxInnerShellListView);
  TcxInnerShellTreeViewAccess = class(TcxInnerShellTreeView);
  TcxPopupEditPopupWindowAccess = class(TcxPopupEditPopupWindow);
  TcxShellTreeItemProducerAccess = class(TcxShellTreeItemProducer);

const
  ShellRootIDL: Word = 0;

type
  { TcxFilterShellComboBoxHelper }

  TcxFilterShellComboBoxHelper = class(TcxFilterDropDownEditHelper)
  public
    class function GetFilterEditClass: TcxCustomEditClass; override;
  end;

class function TcxFilterShellComboBoxHelper.GetFilterEditClass: TcxCustomEditClass;
begin
  Result := TcxShellComboBox;
end;

procedure FreeAndNilPIDL(var APIDL: PItemIDList);
begin
  if APIDL <> nil then
  begin
    cxMalloc.Free(APIDL);
    APIDL := nil;
  end;
end;

procedure GetShellSysIconIndex(APIDL: PItemIDList;
  out AShellSysIconIndex, AShellSysIconOverlayIndex: Integer);
const
  SHGFI_ATTR_SPECIFIED = $20000;
var
  AFlags: Integer;
  ASHFileInfo: TSHFileInfo;
begin
  AFlags := SHGFI_PIDL or SHGFI_SYSICONINDEX or SHGFI_SMALLICON or
    SHGFI_ATTR_SPECIFIED or SHGFI_ATTRIBUTES;
  ASHFileInfo.dwAttributes := SFGAO_LINK or SFGAO_SHARE;
  SHGetFileInfo(Pointer(APIDL), 0, ASHFileInfo, SizeOf(ASHFileInfo), AFlags);
  AShellSysIconIndex := ASHFileInfo.iIcon;
  if ASHFileInfo.dwAttributes and SFGAO_LINK <> 0 then
    AShellSysIconOverlayIndex := cxShellShortcutItemOverlayIndex
  else
    if ASHFileInfo.dwAttributes and SFGAO_SHARE <> 0 then
      AShellSysIconOverlayIndex := cxShellSharedItemOverlayIndex
    else
      AShellSysIconOverlayIndex := cxShellNormalItemOverlayIndex;
end;

procedure PrepareShellComboBoxImageList;
var
  ASHFileInfo : TSHFileInfo;
begin
  cxShellComboBoxImageList := TCustomImageList.Create(nil);
  with cxShellComboBoxImageList do
  begin
    ShareImages := True;
    Handle := SHGetFileInfo(@ShellRootIDL, 0, ASHFileInfo, SizeOf(ASHFileInfo),
      SHGFI_PIDL or SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  end;
end;

{ TcxShellComboBoxViewInfo }

procedure TcxShellComboBoxViewInfo.Offset(DX, DY: Integer);
begin
  inherited Offset(DX, DY);
  Inc(ShellIconPosition.X, DX);
  Inc(ShellIconPosition.Y, DY);
end;

procedure TcxShellComboBoxViewInfo.Paint(ACanvas: TcxCanvas);
var
  R: TRect;
begin
  if ShellSysIconIndex <> -1 then
  begin
    R.TopLeft := ShellIconPosition;
    R.Right := R.Left + cxShellComboBoxImageList.Width;
    R.Bottom := R.Top + cxShellComboBoxImageList.Height;
    if not Transparent then
      cxEditFillRect(ACanvas.Handle, R, GetSolidBrush(BackgroundColor));
    ImageList_Draw(cxShellComboBoxImageList.Handle, ShellSysIconIndex,
      ACanvas.Handle, R.Left, R.Top,
      ILD_TRANSPARENT or IndexToOverlayMask(ShellSysIconOverlayIndex + 1));
    if not Transparent then
      ACanvas.ExcludeClipRect(R);
  end;
  inherited Paint(ACanvas);
end;

{ TcxShellComboBoxViewData }

procedure TcxShellComboBoxViewData.Calculate(ACanvas: TcxCanvas;
  const ABounds: TRect; const P: TPoint; Button: TcxMouseButton;
  Shift: TShiftState; AViewInfo: TcxCustomEditViewInfo;
  AIsMouseEvent: Boolean);
begin
  inherited Calculate(ACanvas, ABounds, P, Button, Shift, AViewInfo, AIsMouseEvent);
  with TcxShellComboBoxViewInfo(AViewInfo) do
  begin
    ShellIconPosition.X :=  BorderRect.Left + 1;
    ShellIconPosition.Y := BorderRect.Top + (BorderRect.Bottom - BorderRect.Top -
      cxShellComboBoxImageList.Height) div 2
  end;
end;

procedure TcxShellComboBoxViewData.EditValueToDrawValue(ACanvas: TcxCanvas;
  const AEditValue: TcxEditValue; AViewInfo: TcxCustomEditViewInfo);
begin
  with TcxShellComboBoxViewInfo(AViewInfo) do
  begin
    Properties.GetShellDisplayValue(AEditValue, False, string(Text),
      ShellSysIconIndex, ShellSysIconOverlayIndex);
    DoOnGetDisplayText(string(Text));
  end;
  PrepareSelection(AViewInfo);
end;

function TcxShellComboBoxViewData.GetClientExtent(ACanvas: TcxCanvas;
  AViewInfo: TcxCustomEditViewInfo): TRect;
begin
  Result := inherited GetClientExtent(ACanvas, AViewInfo);
  if not(Properties.FastSearch and (Edit = nil)) then
    Inc(Result.Left, cxShellComboBoxImageList.Width + 4);
end;

function TcxShellComboBoxViewData.InternalGetEditConstantPartSize(ACanvas: TcxCanvas;
  AIsInplace: Boolean; AEditSizeProperties: TcxEditSizeProperties;
  var MinContentSize: TSize; AViewInfo: TcxCustomEditViewInfo): TSize;
begin
  Result := inherited InternalGetEditConstantPartSize(ACanvas, AIsInplace,
    AEditSizeProperties, MinContentSize, AViewInfo);
  if IsInplace or (Edit <> nil) and TcxCustomEditAccess(Edit).AutoSize then
  begin
    if MinContentSize.cy < cxShellComboBoxImageList.Height then
      MinContentSize.cy := cxShellComboBoxImageList.Height;
  end;
end;

function TcxShellComboBoxViewData.InternalEditValueToDisplayText(
  AEditValue: TcxEditValue): string;
var
  AShellSysIconIndex, AShellSysIconOverlayIndex: Integer;
begin
  Properties.GetShellDisplayValue(AEditValue, Focused, Result, AShellSysIconIndex,
    AShellSysIconOverlayIndex);
end;

function TcxShellComboBoxViewData.GetProperties: TcxCustomShellComboBoxProperties;
begin
  Result := TcxCustomShellComboBoxProperties(FProperties);
end;

{ TcxShellComboBoxRoot }

procedure TcxShellComboBoxRoot.RootUpdated;
begin
  inherited RootUpdated;
  TcxCustomShellComboBoxProperties(Owner).RootChangeHandler(Self);
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{ TcxShellComboBoxLookupData }

function TcxShellComboBoxLookupData.GetItem(Index: Integer): string;
begin
  Result := Edit.TraverseAllVisibleNodes(Index).Text;
end;

function TcxShellComboBoxLookupData.GetItemCount: Integer;
begin
  if Edit.ActiveProperties.IncrementalSearch then
  begin
    Result := -1;
    Edit.TraverseAllVisibleNodes(Result);
  end
  else
    Result := 0;
end;

procedure TcxShellComboBoxLookupData.ListChanged;
begin
end;

function TcxShellComboBoxLookupData.GetEdit: TcxCustomShellComboBox;
begin
  Result := TcxCustomShellComboBox(GetOwner);
end;

{ TcxCustomShellComboBoxProperties }

constructor TcxCustomShellComboBoxProperties.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FRoot := TcxShellComboBoxRoot.Create(Self, 0);
  FRoot.OnSettingsChanged := RootSettingsChanged;
  DropDownSizeable := True;
  ImmediateDropDown := False;
  PopupAutoSize := False;
  TreeViewOptions := [tvoContextMenus, tvoHotTrack, tvoShowButtons,
    tvoShowLines, tvoShowRoot, tvoShowToolTip];
  ValidateOnEnter := True;

  FStoreRelativePath := True;
end;

destructor TcxCustomShellComboBoxProperties.Destroy;
begin
  FreeAndNil(FRoot);
  inherited Destroy;
end;

procedure TcxCustomShellComboBoxProperties.Assign(Source: TPersistent);
begin
  if Source is TcxCustomShellComboBoxProperties then
  begin
    BeginUpdate;
    try
      inherited Assign(Source);
      with Source as TcxCustomShellComboBoxProperties do
      begin
        Self.FastSearch := FastSearch;
        Self.IncrementalSearch := IncrementalSearch;
        Self.Root.Assign(Root);
        Self.ShowFullPath := ShowFullPath;
        Self.StoreRelativePath := StoreRelativePath;
        Self.TreeViewOptions := TreeViewOptions;
        Self.ViewOptions := ViewOptions;
        Self.OnAddFolder := OnAddFolder;
      end;
    finally
      EndUpdate;
    end
  end
  else
    inherited Assign(Source);
end;

function TcxCustomShellComboBoxProperties.CompareDisplayValues(
  const AEditValue1, AEditValue2: TcxEditValue): Boolean;
var
  AShellSysIconIndex1, AShellSysIconIndex2: Integer;
  AShellSysIconOverlayIndex1, AShellSysIconOverlayIndex2: Integer;
  AText1, AText2: string;
begin
  GetShellDisplayValue(AEditValue1, False, AText1, AShellSysIconIndex1,
    AShellSysIconOverlayIndex1);
  GetShellDisplayValue(AEditValue2, False, AText2, AShellSysIconIndex2,
    AShellSysIconOverlayIndex2);
  Result := InternalCompareString(AText1, AText2, True) and (FastSearch or
    (AShellSysIconIndex1 = AShellSysIconIndex2) and
    (AShellSysIconOverlayIndex1 = AShellSysIconOverlayIndex2));
end;

class function TcxCustomShellComboBoxProperties.GetContainerClass: TcxContainerClass;
begin
  Result := TcxShellComboBox;
end;

function TcxCustomShellComboBoxProperties.GetDisplayText(const AEditValue: TcxEditValue;
  AFullText: Boolean = False; AIsInplace: Boolean = True): WideString;
var
  AShellSysIconIndex, AShellSysIconOverlayIndex: Integer;
  AText: string;
begin
  GetShellDisplayValue(AEditValue, False, AText, AShellSysIconIndex,
    AShellSysIconOverlayIndex);
  Result := AText;
end;

function TcxCustomShellComboBoxProperties.GetEditValueSource(AEditFocused: Boolean): TcxDataEditValueSource;
begin
  Result := evsValue;
end;

class function TcxCustomShellComboBoxProperties.GetLookupDataClass: TcxInterfacedPersistentClass;
begin
  Result := TcxShellComboBoxLookupData;
end;

procedure TcxCustomShellComboBoxProperties.GetShellDisplayValue(
  const AEditValue: TcxEditValue; AFocused: Boolean;
  out AText: string; out AShellSysIconIndex, AShellSysIconOverlayIndex: Integer);
var
  APath: string;

  procedure GetShellObjectName;
  var
    APathLength: Integer;
    I: Integer;
  begin
    APathLength := Length(APath);
    for I := APathLength - 1 downto 1 do
      if APath[I] = '\' then
      begin
        APath := Copy(APath, I + 1, APathLength - I);
        Break;
      end;
  end;

var
  AAttributes, AParsedCharCount: ULONG;
  APIDL: PItemIDList;
begin
  AShellSysIconIndex := -1;
  if FastSearch then
  begin
    if VarIsNull(AEditValue) or VarIsEmpty(AEditValue) then
      AText := ''
    else
    begin
      APath := VarToStr(AEditValue);
      CheckRoot;
      if APath = '' then
        AText := GetPIDLDisplayName(Root.Pidl)
      else
        case CheckShellObjectPath(APath, GetPidlName(Root.Pidl), False) of
          sptVirtual:
            begin
              AAttributes := SFGAO_HIDDEN or SFGAO_FOLDER;
              GetDesktopIShellFolder.ParseDisplayName(0, nil, StringToOleStr(APath),
                AParsedCharCount, APIDL, AAttributes);
              if (APIDL <> nil) and not CheckViewOptions(GetShellViewOptions, AAttributes) then
                  APIDL := nil;
              if APIDL = nil then
                AText := APath
              else
              begin
                AText := GetPIDLDisplayName(APIDL);
                DisposePidl(APIDL);
              end;
            end;
          else
            begin
              GetShellObjectName;
              AText := APath;
            end;
        end;
    end;
    Exit;
  end;


  if VarIsNull(AEditValue) or VarIsEmpty(AEditValue) then
    APIDL := nil
  else
    APIDL := EditValueToPIDL(AEditValue);
  if APIDL = nil then
    AText := VarToStr(AEditValue)
  else
  begin
    AText := GetPIDLDisplayName(APIDL, (ShowFullPath = sfpAlways) or
      (ShowFullPath = sfpNotFocused) and not AFocused);
    GetShellSysIconIndex(APIDL, AShellSysIconIndex, AShellSysIconOverlayIndex);
    DisposePidl(APIDL);
  end;
  DisplayValueToDisplayText(AText);
end;

class function TcxCustomShellComboBoxProperties.GetViewInfoClass: TcxContainerViewInfoClass;
begin
  Result := TcxShellComboBoxViewInfo;
end;

function TcxCustomShellComboBoxProperties.IsEditValueValid(var EditValue: TcxEditValue;
  AEditFocused: Boolean): Boolean;
begin
  Result := True;
end;

class function TcxCustomShellComboBoxProperties.GetPopupWindowClass: TcxCustomEditPopupWindowClass;
begin
  Result := TcxShellComboBoxPopupWindow;
end;

class function TcxCustomShellComboBoxProperties.GetViewDataClass: TcxCustomEditViewDataClass;
begin
  Result := TcxShellComboBoxViewData;
end;

procedure TcxCustomShellComboBoxProperties.CheckRoot;
begin
  if Root.ShellFolder = nil then
  begin
    BeginUpdate;
    try
      Root.CheckRoot;
    finally
      EndUpdate(False);
    end;
  end;
end;

function TcxCustomShellComboBoxProperties.EditValueToPIDL(const AEditValue: TcxEditValue): PItemIDList;
begin
  CheckRoot;
  if VarIsNull(AEditValue) or VarIsEmpty(AEditValue) then
    Result := nil
  else
    Result := PathToAbsolutePIDL(VarToStr(AEditValue), Root, GetShellViewOptions);
end;

function TcxCustomShellComboBoxProperties.GetShellViewOptions: TcxShellViewOptions;
begin
  Result := [svoShowFolders];
  if scvoShowFiles in FViewOptions then
    Include(Result, svoShowFiles);
  if scvoShowHidden in FViewOptions then
    Include(Result, svoShowHidden);
end;

procedure TcxCustomShellComboBoxProperties.RootChanged;
begin
  Changed;
end;

procedure TcxCustomShellComboBoxProperties.DoRootSettingsChanged;
begin
  if Assigned(FOnRootSettingsChanged) then
    FOnRootSettingsChanged(Self);
end;

function TcxCustomShellComboBoxProperties.GetDropDownSizeable: Boolean;
begin
  Result := PopupSizeable;
end;

function TcxCustomShellComboBoxProperties.GetDropDownWidth: Integer;
begin
  Result := PopupWidth;
end;

procedure TcxCustomShellComboBoxProperties.RootChangeHandler(Sender: TObject);
begin
  RootChanged;
end;

procedure TcxCustomShellComboBoxProperties.RootSettingsChanged(Sender: TObject);
begin
  DoRootSettingsChanged;
end;

procedure TcxCustomShellComboBoxProperties.SetDropDownSizeable(Value: Boolean);
begin
  PopupSizeable := Value;
end;

procedure TcxCustomShellComboBoxProperties.SetDropDownWidth(Value: Integer);
begin
  PopupWidth := Value;
end;

procedure TcxCustomShellComboBoxProperties.SetFastSearch(Value: Boolean);
begin
  if Value <> FFastSearch then
  begin
    FFastSearch := Value;
    Changed;
  end;
end;

procedure TcxCustomShellComboBoxProperties.SetIncrementalSearch(Value: Boolean);
begin
  if Value <> FIncrementalSearch then
  begin
    FIncrementalSearch := Value;
    Changed;
  end;
end;

procedure TcxCustomShellComboBoxProperties.SetShowFullPath(
  Value: TcxShellComboBoxShowFullPath);
begin
  if Value <> FShowFullPath then
  begin
    FShowFullPath := Value;
    Changed;
  end;
end;

procedure TcxCustomShellComboBoxProperties.SetStoreRelativePath(Value: Boolean);
begin
  if Value <> FStoreRelativePath then
  begin
    FStoreRelativePath := Value;
    Changed;
  end;
end;

procedure TcxCustomShellComboBoxProperties.SetTreeViewOptions(Value: TcxPopupShellTreeViewOptions);
begin
  if Value <> FTreeViewOptions then
  begin
    FTreeViewOptions := Value;
    Changed;
  end;
end;

procedure TcxCustomShellComboBoxProperties.SetViewOptions(Value: TcxShellComboBoxViewOptions);
begin
  if Value <> FViewOptions then
  begin
    FViewOptions := Value;
    Changed;
  end;
end;

{ TcxPopupShellTreeView }

procedure TcxPopupShellTreeView.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_TAB then
    Edit.DoEditKeyDown(Key, Shift);
  inherited KeyDown(Key, Shift);
  case Key of
    VK_ESCAPE:
      begin
        DoSelectNode(crCancel);
        Key := 0;
      end;
    VK_F4:
      if not (ssAlt in Shift) then
      begin
        DoSelectNode(crClose);
        Key := 0;
      end;
    VK_UP, VK_DOWN:
      if ssAlt in Shift then
      begin
        DoSelectNode(crClose);
        Key := 0;
      end;
    VK_RETURN:
      if (Shift = []) and (InnerTreeView.Selected <> nil) then
        DoSelectNode(crEnter);
  end;
end;

procedure TcxPopupShellTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  AHitTests : THitTests;
begin
  inherited MouseUp(Button, Shift, X, Y);
  AHitTests := InnerTreeView.GetHitTestInfoAt(X, Y);
  if ((Button = mbLeft) and not RightClickSelect) or ((Button = mbRight) and RightClickSelect) then
    if ([htOnIcon, htOnItem, htOnLabel] * AHitTests <> []) and (AHitTests <> [htOnIcon, htOnItem]) then
      DoSelectNode(crEnter);
end;

procedure TcxPopupShellTreeView.DoSelectNode(AClosePopupReason: TcxEditCloseUpReason);
begin
  Edit.CloseUp(AClosePopupReason)
end;

function TcxPopupShellTreeView.GetEdit: TcxCustomShellComboBox;
begin
  Result := TcxCustomShellComboBox(TcxPopupEditPopupWindowAccess(Parent).Edit);
end;

{ TcxShellComboBoxPopupWindow }

procedure TcxShellComboBoxPopupWindow.WMEnable(var Message: TMessage);
begin
  inherited;
  if not IsInternalWindowsDisabling then
    if Bool(Message.WParam) then
      EnableAppWindows
    else
      DisableAppWindows;
end;

{ TcxCustomShellComboBox }

destructor TcxCustomShellComboBox.Destroy;
begin
  if FAbsolutePIDL <> nil then
  begin
    DisposePidl(FAbsolutePIDL);
    FAbsolutePIDL := nil;
  end;

  if FShellListView <> nil then
    with FShellListView do
      if (InnerListView <> nil) and not(csDestroying in InnerListView.ComponentState) then
        TcxInnerShellListViewAccess(InnerListView).ComboBoxControl := nil;

  if FShellTreeView <> nil then
    with FShellTreeView do
      if (InnerTreeView <> nil) and not(csDestroying in InnerTreeView.ComponentState) then
        TcxInnerShellTreeViewAccess(InnerTreeView).ComboBoxControl := nil;

  inherited Destroy;
end;

function TcxCustomShellComboBox.CanHide: Boolean;
begin
  Result := not HasPopupWindow or IsWindowEnabled(PopupWindow.Handle);
end;

class function TcxCustomShellComboBox.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxCustomShellComboBoxProperties;
end;

function TcxCustomShellComboBox.CanDropDown: Boolean;
begin
  Result := True;
end;

procedure TcxCustomShellComboBox.CloseUp(AReason: TcxEditCloseUpReason);
begin
  if not HasPopupWindow then
    Exit;
  if AReason in [crTab, crEnter] then
  begin
    ValidateEdit(True);
    SelectAll;
  end;
  FCloseUpReason := AReason;
  PopupWindow.ClosePopup;
end;

procedure TcxCustomShellComboBox.CreatePopupWindow;
begin
  inherited CreatePopupWindow;
  PopupWindow.ModalMode := False;
end;

procedure TcxCustomShellComboBox.DoInitPopup;
begin
  inherited DoInitPopup;
  ActiveProperties.PopupControl := FPopupShellTreeView;  
end;

procedure TcxCustomShellComboBox.DropDown;
begin
  FIsSelectedNodeChangeEventLocked := True;
  inherited DropDown;
end;

procedure TcxCustomShellComboBox.HandleSelectItem(Sender: TObject);
var
  ANodeIndex: Integer;
  APIDL: PItemIDList;
begin
  ANodeIndex := ILookupData.CurrentKey;
  APIDL := FPopupShellTreeView.GetNodeAbsolutePIDL(TraverseAllVisibleNodes(ANodeIndex));
  InternalSynchronizeEditValue(APIDL, '');
  DisposePidl(APIDL);
  SelectAll;
end;

procedure TcxCustomShellComboBox.Initialize;
begin
  inherited Initialize;
  ActiveProperties.Root.OnChange := RootChangeHandler;
  ActiveProperties.Root.OnSettingsChanged := RootSettingsChanged;
  if IsDesigning then
    Exit;
  FPopupShellTreeView := GetPopupShellTreeViewClass.Create(PopupWindow);
  ActiveProperties.PopupControl := FPopupShellTreeView;
  with FPopupShellTreeView do
  begin
    LookAndFeel.MasterLookAndFeel := Self.PopupControlsLookAndFeel;
    ParentColor := True;
    Parent := Self.PopupWindow;
    Options.ShowNonFolders := False;
    Style.BorderStyle := cbsNone;
    Style.HotTrack := False;
    Style.TransparentBorder := False;
    TreeHotTrack := True;
    InnerTreeView.ShowInfoTips := False;
    OnAddFolder := Self.AddFolderHandler;
    OnChange := Self.SelectedNodeChangeHandler;
  end;
end;

procedure TcxCustomShellComboBox.InitializePopupWindow;
begin
  inherited InitializePopupWindow;
  TcxPopupEditPopupWindowAccess(PopupWindow).SysPanelStyle := ActiveProperties.PopupSizeable;
  PopupShellTreeView.Color := ActiveStyle.Color;
  PopupWindow.Font := ActiveStyle.GetVisibleFont;
end;

procedure TcxCustomShellComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);

  if Operation = opRemove then
    if AComponent = ShellListView then
      ShellListView := nil
    else
      if AComponent = ShellTreeView then
        ShellTreeView := nil;
end;

procedure TcxCustomShellComboBox.PopupWindowShowed(Sender: TObject);
begin
  inherited PopupWindowShowed(Sender);
  FPopupWindowShowing := False;
end;

procedure TcxCustomShellComboBox.PopupWindowShowing(Sender: TObject);
var
  ARootNode: TTreeNode;
begin
  FPopupWindowShowing := True;
  try
    inherited PopupWindowShowing(Sender);
    SynchronizePopupShellTreeView;
    ARootNode := FPopupShellTreeView.InnerTreeView.Items.GetFirstNode;
    if (ARootNode <> nil) and not ARootNode.Expanded then
      ARootNode.Expanded := True;
  finally
    FIsSelectedNodeChangeEventLocked := False;
  end;
end;

procedure TcxCustomShellComboBox.PropertiesChanged(Sender: TObject);
begin
  inherited PropertiesChanged(Sender);
  ActiveProperties.PopupControl := FPopupShellTreeView;
  if FPopupShellTreeView <> nil then
    with FPopupShellTreeView do
    begin
      ImeMode := ActiveProperties.ImeMode;
      ImeName := ActiveProperties.ImeName;
      Options.ContextMenus := tvoContextMenus in ActiveProperties.TreeViewOptions;
      Options.ShowHidden := scvoShowHidden in ActiveProperties.ViewOptions;
      Options.ShowNonFolders := scvoShowFiles in ActiveProperties.ViewOptions;
      Options.ShowToolTip := tvoShowToolTip in ActiveProperties.TreeViewOptions;
      RightClickSelect := tvoRightClickSelect in ActiveProperties.TreeViewOptions;
      ShowButtons := tvoShowButtons in ActiveProperties.TreeViewOptions;
      ShowInfoTips := tvoShowInfoTips in ActiveProperties.TreeViewOptions;
      ShowLines := tvoShowLines in ActiveProperties.TreeViewOptions;
      ShowRoot := tvoShowRoot in ActiveProperties.TreeViewOptions;
      TreeHotTrack := tvoHotTrack in ActiveProperties.TreeViewOptions
    end;
end;

procedure TcxCustomShellComboBox.SynchronizeDisplayValue;
var
  APIDL: PItemIDList;
  S: String;
begin
  if DataBinding is TcxDBTextEditDataBinding then // TODO Remove cxDBEdit, IsDataSourceLive
    with TcxDBTextEditDataBindingAccess(DataBinding) do
      if not IsDataAvailable then
      begin
        ViewInfo.ShellSysIconIndex := -1;
        Exit;
      end;

  if VarIsNull(FEditValue) or VarIsEmpty(FEditValue) then
  begin
    ActiveProperties.CheckRoot;
    APIDL := GetPidlCopy(ActiveProperties.Root.Pidl);
  end
  else
    APIDL := ActiveProperties.EditValueToPIDL(FEditValue);

  InternalSetAbsolutePIDL(APIDL);

  if APIDL = nil then
  begin
    S := VarToStr(FEditValue);
    ViewInfo.ShellSysIconIndex := -1;
  end
  else
  begin
    S := GetPIDLDisplayName(APIDL, (ActiveProperties.ShowFullPath = sfpAlways) or
      (ActiveProperties.ShowFullPath = sfpNotFocused) and not IsFocused);
    GetShellSysIconIndex(APIDL, ViewInfo.ShellSysIconIndex,
      ViewInfo.ShellSysIconOverlayIndex);
    DisposePidl(APIDL);
  end;

  DataBinding.DisplayValue := S;
//  SelStart := Length(S);
  InvalidateShellIconRect;
end;

procedure TcxCustomShellComboBox.SynchronizeEditValue;
var
  APIDL: PItemIDList;

  procedure InternalEditValueToPIDL;
  var
    ACSIDL: Integer;
    ANode: TTreeNode;
    AParentIFolder: IShellFolder;
    AParentFolderPIDL: PItemIDList;
    APath: string;
    APathType: TcxShellObjectPathType;
    AShellViewOptions: TcxShellViewOptions;
    ATempPIDL: PItemIDList;
  begin
    APath := AnsiUpperCase(DisplayValue);
    ActiveProperties.CheckRoot;

    if APath = '' then
    begin
      APIDL := GetPidlCopy(ActiveProperties.Root.Pidl);
      Exit;
    end;

    if IsDesigning or (FPopupShellTreeView.InnerTreeView.Selected = nil) then
      ATempPIDL := GetPidlCopy(ActiveProperties.Root.Pidl)
    else
      with FPopupShellTreeView do
        ATempPIDL := GetNodeAbsolutePIDL(InnerTreeView.Selected);
    APathType := CheckShellObjectPath(APath,
      AnsiUpperCase(GetPidlName(ATempPIDL)), True);
    DisposePidl(ATempPIDL);

    APIDL := nil;
    AShellViewOptions := ActiveProperties.GetShellViewOptions;
    repeat
      case APathType of
        sptAbsolutePhysical, sptUNC, sptVirtual:
          APIDL := InternalParseDisplayName(GetDesktopIShellFolder, APath,
            AShellViewOptions);
        sptInternalAbsoluteVirtual, sptInternalRelativeVirtual:
          APIDL := ShellObjectInternalVirtualPathToPIDL(APath, ActiveProperties.Root,
            AShellViewOptions);
        sptRelativePhysical:
          begin
            if IsDesigning or (FPopupShellTreeView.InnerTreeView.Selected = nil) then
            begin
              AParentFolderPIDL := GetPidlCopy(ActiveProperties.Root.Pidl);
              AParentIFolder := ActiveProperties.Root.ShellFolder;
            end
            else
            begin
              with FPopupShellTreeView do
                AParentFolderPIDL := GetNodeAbsolutePIDL(InnerTreeView.Selected);
              GetDesktopIShellFolder.BindToObject(AParentFolderPIDL, nil,
                IID_IShellFolder, Pointer(AParentIFolder));
            end;
            if AParentIFolder <> nil then
            begin
              APIDL := InternalParseDisplayName(AParentIFolder, APath,
                AShellViewOptions);
              if APIDL <> nil then
              begin
                ATempPIDL := APIDL;
                APIDL := ConcatenatePidls(AParentFolderPIDL, APIDL);
                DisposePidl(ATempPIDL);
              end;
              DisposePidl(AParentFolderPIDL);
              if APIDL <> nil then
                Break;
            end;

            if not IsDesigning then
            begin
              ANode := FindNodeAmongExpandedNodes(APath);
              if ANode <> nil then
              begin
                APIDL := FPopupShellTreeView.GetNodeAbsolutePIDL(ANode);
                Break;
              end;
            end;

            for ACSIDL := CSIDL_DESKTOP to CSIDL_HISTORY do
              with cxShellSpecialFolderInfoTable[ACSIDL] do
                if (PIDL <> nil) and (PIDLUpperCaseDisplayName = APath) and
                  CheckViewOptions(AShellViewOptions, Attributes) then
                begin
                  APIDL := GetPidlCopy(PIDL);
                  Break;
                end;
          end;
      end;
    until True;

    if (APIDL <> nil) and not IsSubPath(ActiveProperties.Root.Pidl, APIDL) then
    begin
      DisposePidl(APIDL);
      APIDL := nil;
    end;
  end;

begin
  if DataBinding is TcxDBTextEditDataBinding then // TODO Remove cxDBEdit, IsDataSourceLive
    with TcxDBTextEditDataBindingAccess(DataBinding) do
      if not IsDataAvailable then
      begin
        ViewInfo.ShellSysIconIndex := -1;
        Exit;
      end;
  InternalEditValueToPIDL;
  InternalSynchronizeEditValue(APIDL, DisplayValue);
  DisposePidl(APIDL);
end;

function TcxCustomShellComboBox.CheckAbsolutePIDL(var APIDL: PItemIDList;
  ACheckObjectExistence: Boolean): Boolean;
begin
  ActiveProperties.CheckRoot;
  if APIDL = nil then
  begin
    Result := True;
    APIDL := ActiveProperties.Root.Pidl;
  end
  else
  begin
    Result := IsSubPath(ActiveProperties.Root.Pidl, APIDL);
    if Result and ACheckObjectExistence then
      Result := CheckShellObjectExistence(APIDL);
  end;
end;

procedure TcxCustomShellComboBox.CheckPopupShellTreeView;
var
  ARootNode: TTreeNode;
begin
  if (FPopupShellTreeView = nil) or (FPopupShellTreeView.InnerTreeView = nil) or
      (FPopupShellTreeView.InnerTreeView.Items.Count = 0) then
    Exit;

  ARootNode := FPopupShellTreeView.InnerTreeView.Items[0];
  if not ARootNode.Expanded then
    ARootNode.Expanded := True;
end;

function TcxCustomShellComboBox.FindNodeAmongExpandedNodes(ANodeText: string): TTreeNode;

  function InternalFindPIDLAmongExpandedNodes(ANode: TTreeNode): TTreeNode;
  var
    AChildNode: TTreeNode;
  begin
    Result := nil;
    if ANode = nil then
      Exit;
    if ANodeText = AnsiUpperCase(ANode.Text) then
    begin
      Result := ANode;
      Exit;
    end;
    if not ANode.Expanded then
      Exit;
    AChildNode := ANode.GetFirstChild;
    while AChildNode <> nil do
    begin
      Result := InternalFindPIDLAmongExpandedNodes(AChildNode);
      if Result <> nil then
        Break;
      AChildNode := ANode.GetNextChild(AChildNode);
    end;
  end;

begin
  ANodeText := AnsiUpperCase(ANodeText);
  with FPopupShellTreeView.InnerTreeView do
    if (Selected <> nil) and (ANodeText = AnsiUpperCase(Selected.Text)) then
      Result := Selected
    else
      Result := InternalFindPIDLAmongExpandedNodes(Items.GetFirstNode);
end;

function TcxCustomShellComboBox.GetPopupShellTreeViewClass: TcxPopupShellTreeViewClass;
begin
  Result := TcxPopupShellTreeView;
end;

procedure TcxCustomShellComboBox.InternalSetAbsolutePIDL(Value: PItemIDList);
begin
  if not EqualPIDLs(FAbsolutePIDL, Value) then
  begin
    if FAbsolutePIDL <> nil then
      FreeAndNilPIDL(FAbsolutePIDL);
    if Value <> nil then
    begin
      FAbsolutePIDL := GetPidlCopy(Value);
      SynchronizeDependentShellControls;
    end;
  end;
end;

procedure TcxCustomShellComboBox.InternalSynchronizeEditValue(APIDL: PItemIDList;
  const ADisplayText: string = '');
var
  APIDLName: string;

  function UseInternalVirtualPathFormat: Boolean;
  var
    AShellSysIconIndex1, AShellSysIconOverlayIndex1: Integer;
    AShellSysIconIndex2, AShellSysIconOverlayIndex2: Integer;
    ATempPIDL: PItemIDList;
  begin
    APIDLName := GetPidlName(APIDL);
    Result := APIDLName = '';
    if not Result then
    begin
      ATempPIDL := InternalParseDisplayName(GetDesktopIShellFolder, APIDLName,
        ActiveProperties.GetShellViewOptions);
      try
        GetShellSysIconIndex(APIDL, AShellSysIconIndex1, AShellSysIconOverlayIndex1);
        GetShellSysIconIndex(ATempPIDL, AShellSysIconIndex2, AShellSysIconOverlayIndex2);
        Result := (AShellSysIconIndex1 <> AShellSysIconIndex2) or
          (AShellSysIconOverlayIndex1 <> AShellSysIconOverlayIndex2);
      finally
        DisposePidl(ATempPIDL);
      end;
    end;
  end;

var
  AIsEditValueChanged: Boolean;
  ANewEditValue: string;
  AParentIFolder: IShellFolder;
  AStrRet: TStrRet;
  ATempPIDL, ATempPIDL1: PItemIDList;
  I: Integer;
  S1, S2: string;
begin
  InternalSetAbsolutePIDL(APIDL);

  if APIDL = nil then
  begin
    ViewInfo.ShellSysIconIndex := -1;
    S1 := ADisplayText;
    ANewEditValue := DisplayValue;
  end
  else
  begin
    if ActiveProperties.StoreRelativePath and EqualPIDLs(ActiveProperties.Root.Pidl, APIDL) then
    begin
      ANewEditValue := '';
      S1 := GetPIDLDisplayName(APIDL, (ActiveProperties.ShowFullPath = sfpAlways) or
        (ActiveProperties.ShowFullPath = sfpNotFocused) and not IsFocused);
    end
    else
      if UseInternalVirtualPathFormat then
      begin
        ATempPIDL := APIDL;
        try
          if ActiveProperties.StoreRelativePath then
          begin
            Integer(APIDL) := Integer(APIDL) + GetPidlSize(ActiveProperties.Root.Pidl);
            S2 := cxShellObjectInternalRelativeVirtualPathPrefix;
            AParentIFolder := ActiveProperties.Root.ShellFolder;
          end
          else
          begin
            S2 := cxShellObjectInternalAbsoluteVirtualPathPrefix;
            AParentIFolder := GetDesktopIShellFolder;
          end;
          for I := 1 to GetPidlItemsCount(APIDL) do
          begin
            ATempPIDL1 := cxMalloc.Alloc(APIDL^.mkid.cb + SizeOf(SHITEMID));
            FillChar(ATempPIDL1^, APIDL^.mkid.cb + SizeOf(SHITEMID), 0);
            CopyMemory(ATempPIDL1, APIDL, APIDL^.mkid.cb);
            Integer(APIDL) := Integer(APIDL) + APIDL^.mkid.cb;
            AParentIFolder.GetDisplayNameOf(ATempPIDL1, SHGDN_INFOLDER, AStrRet);
            S1 := GetTextFromStrRet(AStrRet, ATempPIDL1);
            S2 := S2 + '\' + S1;
            AParentIFolder.BindToObject(ATempPIDL1, nil, IID_IShellFolder,
              Pointer(AParentIFolder));
            DisposePidl(ATempPIDL1);
          end;
          ANewEditValue := S2;
        finally
          APIDL := ATempPIDL;
        end;
      end
      else
      begin
        if ActiveProperties.StoreRelativePath then
        begin
          S1 := GetPidlName(ActiveProperties.Root.Pidl);
          S2 := GetPidlName(APIDL);
          if Pos(S1, S2) = 1 then
          begin
            if S1[Length(S1)] = '\' then
              S1 := Copy(S2, Length(S1) + 1, Length(S2) - Length(S1))
            else
              S1 := Copy(S2, Length(S1) + 2, Length(S2) - Length(S1) - 1);
            if (Length(S1) >= 1) and (S1[1] = '\') then
              S1 := Copy(S1, 2, Length(S1) - 1);
            ANewEditValue := S1;
          end
          else
            ANewEditValue := GetPidlName(APIDL);
        end
        else
          ANewEditValue := APidlName;
        S1 := GetPIDLDisplayName(APIDL, (ActiveProperties.ShowFullPath = sfpAlways) or
          (ActiveProperties.ShowFullPath = sfpNotFocused) and not IsFocused);
      end;
    GetShellSysIconIndex(APIDL, ViewInfo.ShellSysIconIndex,
      ViewInfo.ShellSysIconOverlayIndex);
  end;

  AIsEditValueChanged := (VarType(FEditValue) <> VarType(ANewEditValue)) or
      not VarEqualsExact(FEditValue, ANewEditValue);
  FEditValue := ANewEditValue;

  DataBinding.DisplayValue := S1;
//  SelStart := Length(S1);
  InvalidateShellIconRect;

  if AIsEditValueChanged then
    DoEditValueChanged;
end;

procedure TcxCustomShellComboBox.InvalidateShellIconRect;
begin
  with ViewInfo.ShellIconPosition do
    InvalidateRect(Rect(X, Y, X + cxShellComboBoxImageList.Width, Y +
      cxShellComboBoxImageList.Height), False);
end;

procedure TcxCustomShellComboBox.SelectedNodeChangeHandler(Sender: TObject;
  ANode: TTreeNode);
var
  ANodeIndex: Integer;
begin
  if (not HasPopupWindow) and not FNotificationFromDependentShellControls then
    Exit;

  ANodeIndex := -1;
  TraverseAllVisibleNodes(ANodeIndex, ANode);
  TcxShellComboBoxLookupData(FLookupData).InternalSetCurrentKey(ANodeIndex);

  if FIsSelectedNodeChangeEventLocked or (not FPopupWindowShowing and
    not DataBinding.Modified and not DoEditing) then
      Exit;

  DataBinding.DisplayValue :=
    GetPIDLDisplayName(FPopupShellTreeView.GetNodeAbsolutePIDL(ANode),
      ActiveProperties.ShowFullPath = sfpAlways);
  if FPopupWindowShowing then
    ModifiedAfterEnter := False
  else
    if IsFocused then
      ModifiedAfterEnter := True;
  SelStart := Length(DataBinding.DisplayValue);
  ViewInfo.ShellSysIconIndex := ANode.ImageIndex;
  ViewInfo.ShellSysIconOverlayIndex := ANode.OverlayIndex;
  InvalidateShellIconRect;

  if ActiveProperties.ImmediatePost and CanPostEditValue and ValidateEdit(True) then
    InternalPostEditValue;
end;

procedure TcxCustomShellComboBox.SynchronizeDependentShellControls;
var
  ATempPIDL: PItemIDList;
begin
  if FIsDependentShellControlsNotification or FNotificationFromDependentShellControls then
    Exit;
  FIsDependentShellControlsNotification := True;
  try
    if FAbsolutePIDL = nil then
      Exit;
    ATempPIDL := GetPidlCopy(FAbsolutePIDL);
    try
      if (FShellTreeView <> nil) and FShellTreeView.HandleAllocated then
        SendMessage(FShellTreeView.InnerTreeView.Handle, DSM_DONAVIGATE,
          Integer(ATempPIDL), 0);

      if FShellListView <> nil then
        FShellListView.ProcessTreeViewNavigate(ATempPIDL);

      SynchronizePopupShellTreeView;
    finally
      DisposePidl(ATempPIDL);
    end;
  finally
    FIsDependentShellControlsNotification := False;
  end;
end;

procedure TcxCustomShellComboBox.SynchronizePopupShellTreeView;
begin
  if FAbsolutePIDL = nil then
    Exit;

  if not IsDesigning and (FPopupShellTreeView <> nil) and (HasPopupWindow(* or not IsInplace*)) then
    with FPopupShellTreeView do
      if (Parent <> nil) and Parent.HandleAllocated and (InnerTreeView <> nil) then
      begin
        InnerTreeView.HandleNeeded;
        SendMessage(InnerTreeView.Handle, DSM_DONAVIGATE, WPARAM(FAbsolutePIDL), 0);
      end;
end;

function TcxCustomShellComboBox.TraverseAllVisibleNodes(var ANodeIndex: Integer;
  ATreeNode: TTreeNode = nil): TTreeNode;
var
  ANodeCount: Integer;

  function InternalTraverseAllVisibleNodes(ANode: TTreeNode): TTreeNode;
  var
    AChildNode: TTreeNode;
  begin
    Result := nil;
    if ANode = nil then
      Exit;
    if (ANodeCount = ANodeIndex) or (ANode = ATreeNode) then
    begin
      Result := ANode;
      Exit;
    end;
    Inc(ANodeCount);
    if not ANode.Expanded then
      Exit;
    AChildNode := ANode.GetFirstChild;
    while AChildNode <> nil do
    begin
      Result := InternalTraverseAllVisibleNodes(AChildNode);
      if Result <> nil then
        Break;
      AChildNode := ANode.GetNextChild(AChildNode);
    end;
  end;

begin
  CheckPopupShellTreeView;
  ANodeCount := 0;
  if FPopupShellTreeView = nil then
    Result := nil
  else
    with FPopupShellTreeView.InnerTreeView do
      Result := InternalTraverseAllVisibleNodes(Items.GetFirstNode);
  ANodeIndex := ANodeCount;
end;

procedure TcxCustomShellComboBox.AddFolderHandler(Sender: TObject;
  AFolder: TcxShellFolder; var ACanAdd: Boolean);

  procedure DoAddFolder(AProperties: TcxCustomShellComboBoxProperties);
  begin
    with AProperties do
      if Assigned(OnAddFolder) then
        OnAddFolder(Self, AFolder, ACanAdd);
  end;

begin
  DoAddFolder(Properties);
  if ACanAdd and (RepositoryItem <> nil) then
    DoAddFolder(ActiveProperties);
end;

function TcxCustomShellComboBox.GetAbsolutePIDL: PItemIDList;
begin
  Result := GetPidlCopy(FAbsolutePIDL);
end;

function TcxCustomShellComboBox.GetActiveProperties: TcxCustomShellComboBoxProperties;
begin
  Result := TcxCustomShellComboBoxProperties(InternalGetActiveProperties);
end;

function TcxCustomShellComboBox.GetPath: string;
begin
  if FAbsolutePIDL = nil then
    Result := ''
  else
    Result := GetPidlName(FAbsolutePIDL);
end;

function TcxCustomShellComboBox.GetProperties: TcxCustomShellComboBoxProperties;
begin
  Result := TcxCustomShellComboBoxProperties(FProperties);
end;

(*function TcxCustomShellComboBox.GetRelativePath: string;
begin
end;*)

function TcxCustomShellComboBox.GetViewInfo: TcxShellComboBoxViewInfo;
begin
  Result := TcxShellComboBoxViewInfo(FViewInfo);
end;

procedure TcxCustomShellComboBox.RootChangeHandler(Sender: TObject);
begin
  if not IsDesigning then
    FPopupShellTreeView.Root.Assign(ActiveProperties.Root);
  if not ActiveProperties.ChangedLocked and not ModifiedAfterEnter then
    SynchronizeDisplayValue;
end;

procedure TcxCustomShellComboBox.RootSettingsChanged(Sender: TObject);
begin
  if IsLoading then
    Exit;
  if (ShellListView <> nil) and ShellListView.HandleAllocated then
    SendMessage(ShellListView.InnerListView.Handle, DSM_SYNCHRONIZEROOT,
      Integer(ActiveProperties.Root), 0);
  if (ShellTreeView <> nil) and ShellTreeView.HandleAllocated then
    SendMessage(ShellTreeView.InnerTreeView.Handle, DSM_SYNCHRONIZEROOT,
      Integer(ActiveProperties.Root), 0);
end;

procedure TcxCustomShellComboBox.SetAbsolutePIDL(Value: PItemIDList);
begin
  if not CheckAbsolutePIDL(Value, True) then
    Exit;
  InternalSynchronizeEditValue(Value);
end;

procedure TcxCustomShellComboBox.SetPath(const Value: string);
begin
  InternalEditValue := Value;
end;

procedure TcxCustomShellComboBox.SetProperties(Value: TcxCustomShellComboBoxProperties);
begin
  FProperties.Assign(Value);
end;

procedure TcxCustomShellComboBox.SetRelativePIDL(Value: PItemIDList);
var
  ATempPIDL: PItemIDList;
begin
  ActiveProperties.CheckRoot;
  if Value = nil then
    InternalSynchronizeEditValue(ActiveProperties.Root.Pidl)
  else
  begin
    ATempPIDL := ConcatenatePidls(ActiveProperties.Root.Pidl, Value);
    try
      if CheckShellObjectExistence(ATempPIDL) then
        InternalSynchronizeEditValue(ATempPIDL);
    finally
      DisposePidl(ATempPIDL);
    end;
  end;
end;

(*procedure TcxCustomShellComboBox.SetRelativePath(const Value: string);
begin
end;*)

procedure TcxCustomShellComboBox.SetShellListView(Value: TcxCustomShellListView);
begin
  if Value = FShellListView then
    Exit;
  if FShellListView <> nil then
  begin
    if (FShellListView.InnerListView <> nil) and not(csDestroying in FShellListView.InnerListView.ComponentState) then
      TcxInnerShellListViewAccess(FShellListView.InnerListView).ComboBoxControl := nil;
{$IFDEF DELPHI5}
    FShellListView.RemoveFreeNotification(Self);
{$ENDIF}
  end;
  FShellListView := Value;
  if FShellListView <> nil then
  begin
    FShellListView.FreeNotification(Self);
    TcxInnerShellListViewAccess(FShellListView.InnerListView).ComboBoxControl := Self;
  end;
end;

procedure TcxCustomShellComboBox.SetShellTreeView(Value: TcxCustomShellTreeView);
begin
  if Value = FShellTreeView then
    Exit;
  if FShellTreeView <> nil then
  begin
    if (FShellTreeView.InnerTreeView <> nil) and not(csDestroying in FShellTreeView.InnerTreeView.ComponentState) then
      TcxInnerShellTreeViewAccess(FShellTreeView.InnerTreeView).ComboBoxControl := nil;
{$IFDEF DELPHI5}
    FShellTreeView.RemoveFreeNotification(Self);
{$ENDIF}
  end;
  FShellTreeView := Value;
  if FShellTreeView <> nil then
  begin
    FShellTreeView.FreeNotification(Self);
    TcxInnerShellTreeViewAccess(FShellTreeView.InnerTreeView).ComboBoxControl := Self;
  end;
end;

procedure TcxCustomShellComboBox.DSMDoNavigate(var Message: TMessage);
var
  APIDL: PItemIDList;
begin
  if FIsDependentShellControlsNotification or FNotificationFromDependentShellControls then
    Exit;
  FNotificationFromDependentShellControls := True;
  try
    if FShellTreeView <> nil then
      APIDL := FShellTreeView.AbsolutePIDL
    else if FShellListView <> nil then
      APIDL := FShellListView.AbsolutePIDL
    else
      APIDL := PItemIDList(Message.WParam);
    if not CheckAbsolutePIDL(APIDL, False) then
      Exit;
    if not IsDesigning and (FPopupShellTreeView <> nil) then
      with FPopupShellTreeView do
        if (Parent <> nil) and Parent.HandleAllocated and (InnerTreeView <> nil) then
        begin
          InnerTreeView.HandleNeeded;
          SendMessage(InnerTreeView.Handle, DSM_DONAVIGATE, WPARAM(APIDL), 0);
          SynchronizeEditValue;
          Exit;
        end;

    InternalSynchronizeEditValue(APIDL);
  finally
    FNotificationFromDependentShellControls := False;
  end;
end;

procedure TcxCustomShellComboBox.DSMSynchronizeRoot(var Message: TMessage);
begin
  if not IsLoading then
    ActiveProperties.Root.Update(TcxCustomShellRoot(Message.WParam));
end;

{ TcxShellComboBox }

class function TcxShellComboBox.GetPropertiesClass: TcxCustomEditPropertiesClass;
begin
  Result := TcxShellComboBoxProperties;
end;

function TcxShellComboBox.GetActiveProperties: TcxShellComboBoxProperties;
begin
  Result := TcxShellComboBoxProperties(InternalGetActiveProperties);
end;

function TcxShellComboBox.GetProperties: TcxShellComboBoxProperties;
begin
  Result := TcxShellComboBoxProperties(FProperties);
end;

procedure TcxShellComboBox.SetProperties(Value: TcxShellComboBoxProperties);
begin
  FProperties.Assign(Value);
end;

initialization
  GetRegisteredEditProperties.Register(TcxShellComboBoxProperties, scxSEditRepositoryShellComboBoxItem);
  FilterEditsController.Register(TcxShellComboBoxProperties, TcxFilterShellComboBoxHelper);
  PrepareShellComboBoxImageList;

finalization
  FreeAndNil(cxShellComboBoxImageList);
  FilterEditsController.Unregister(TcxShellComboBoxProperties, TcxFilterShellComboBoxHelper);
  GetRegisteredEditProperties.Unregister(TcxShellComboBoxProperties);

end.
