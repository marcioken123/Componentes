unit ElInspector;
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

ElInspector unit
----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Variants,
  Windows,
  Classes,
  SysUtils,
  Graphics,
  Controls,
  Messages,
  Dialogs,
  Forms,
  StdCtrls,
  ExtCtrls,
  TypInfo,
  LMDTypes,
  LMDElConst,
  ElEdits,
  ElComponent,
  ElPanel,
  ElHTMLPanel,
  ElTree,
  ElTreeInplaceEditors,
  LMDObjectList,
  ElHeader,
  ElStack,
  ElSplit,
  ElVCLUtils,
  LMDGraph,
  LMDUnicodeStrings;

type
  // Data link actions
  TElInspectorAction = (iRebuildInspector);

  // Forwards
  TElEnumerator = class;
  TElCategories = class;
  TCustomElInspector = class;
  TElInspectorItem = class;
  TElInspectorData = class;
  TElInspectorClassesList = class;
  TElInspectorDataSource = class;

  // Class reference
  TElClassInplaceEditor = class of TElTreeInplaceEditor;
  TElClassInspectorData = class of TElInspectorData;

  // Events
  TNeedTextForHelpPanel = procedure (Sender: TObject; var TextFor: TLMDString) of object;
  TFilterItemEvent = procedure (Sender: TObject; AItem: TElInspectorData; var Accept: Boolean) of object;
  TNeedDisplayName = procedure (Sender: TObject; AItem: TElInspectorData; var ADisplayName: TLMDString) of object;
  TNeedCategory = procedure (Sender: TObject; AItem: TElInspectorData; var AIndex: Integer) of object;
  TGetValuesList = procedure (AItem: TElInspectorItem; ASList: TLMDStrings) of object;
  TValidateResult = procedure (Sender: TObject; AItem: TElInspectorData; var Accepted: Boolean) of object;

  // Workarounds
  TElComponentAccess = class(TComponent)
  end;

  TElTreeViewAccess = class(TElTreeView);

  // Exceptions
  EElInpectorError = class (Exception)
  end;

  // Classes
  // Use this base as ancestor for you own property types.
  TElInspectorData = class(TPersistent)
  protected
    FDisplayName: TLMDString;
    FInspectorItem: TElInspectorItem;
    function GetAsBoolean: Boolean; virtual;
    function GetAsDateTime: TDateTime; virtual;
    function GetAsFloat: Double; virtual;
    function GetAsInt64: Int64; virtual;
    function GetAsInteger: Integer; virtual;
    function GetAsMethod: TMethod; virtual;
    function GetAsObject: TObject; virtual;
    function GetAsString: TLMDString; virtual; abstract;
    function GetAsVariant: Variant; virtual;
    function GetDisplayName: TLMDString; virtual;
    function GetIsComplex: Boolean; virtual;
    function GetIsDefault: Boolean; virtual;
    function GetIsEnumerable: Boolean; virtual;
    function GetIsReadOnly: Boolean; virtual;
    function GetIsReference: Boolean; virtual;
    function GetMaxValue: Integer; virtual;
    function GetMinValue: Integer; virtual;
    function GetName: TLMDString; virtual; abstract;
    procedure SetAsBoolean(Value: Boolean); virtual;
    procedure SetAsDateTime(Value: TDateTime); virtual;
    procedure SetAsFloat(Value: Double); virtual;
    procedure SetAsInt64(Value: Int64); virtual;
    procedure SetAsInteger(Value: Integer); virtual;
    procedure SetAsMethod(Value: TMethod); virtual;
    procedure SetAsObject(Value: TObject); virtual;
    procedure SetAsString(Value: TLMDString); virtual; abstract;
    procedure SetAsVariant(Value: Variant); virtual;
    procedure SetDisplayName(Value: TLMDString); virtual;
  public
    function GetValuesList(const AList: TLMDStrings): Integer; virtual; abstract;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsMethod: TMethod read GetAsMethod write SetAsMethod;
    property AsObject: TObject read GetAsObject write SetAsObject;
    property AsString: TLMDString read GetAsString write SetAsString;
    property AsVariant: Variant read GetAsVariant write SetAsVariant;
    property DisplayName: TLMDString read GetDisplayName write SetDisplayName;
    property InspectorItem: TElInspectorItem read FInspectorItem write FInspectorItem;
    property IsComplex: Boolean read GetIsComplex;
    property IsDefault: Boolean read GetIsDefault;
    property IsReference: Boolean read GetIsReference;
    property IsEnumerable: Boolean read GetIsEnumerable;
    property IsReadOnly: Boolean read GetIsReadOnly;
    property MaxValue: Integer read GetMaxValue;
    property MinValue: Integer read GetMinValue;
    property Name: TLMDString read GetName;
    property Value: TLMDString read GetAsString write SetAsString;
  end;

  TElInspectorDataLink = class(TObject)
  private
    FInspector: TCustomElInspector;
    FInspectorDataSource: TElInspectorDataSource;
    procedure SetInspectorDataSource(Value: TElInspectorDataSource);
  public
    constructor Create(AInspector: TCustomElInspector);
    destructor Destroy; override;
    property InspectorDataSource: TElInspectorDataSource read FInspectorDataSource write SetInspectorDataSource;
    property Inspector: TCustomElInspector read FInspector;
    procedure NotifyInspector(Action: TElInspectorAction);
  end;

  TElInspectorDataSource = class(TElComponent)
  protected
    FInspectors : TLMDObjectList;
    FNeedCategory: TNeedCategory;
    function GetCategories: TElCategories; virtual; abstract;
    function GetRegClass: TElInspectorClassesList; virtual; abstract;
    procedure SetCategories(const Value: TElCategories); virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateEnumerator(Item: TElInspectorData): TElEnumerator; virtual; abstract;
    procedure NotifyInspectors(Action: TElInspectorAction);
    procedure ClearItemIndex; virtual; abstract;
    procedure DestroyEnumerator(AEnum: TElEnumerator); virtual; abstract;
    property Categories: TElCategories read GetCategories write SetCategories;
    property RegisterList: TElInspectorClassesList read GetRegClass;
    procedure RegisterDataLink(Value: TElInspectorDataLink);virtual;
    procedure UnregisterDataLink(Value: TElInspectorDataLink);virtual;
  end;

  // Store data about editors and
  TElInspectorRegister = class (TPersistent)
  protected
    FEditorClass: TElClassInplaceEditor;
    FInspectorData: TElClassInspectorData;
  public
    constructor Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData);
    property EditorClass: TElClassInplaceEditor read FEditorClass write FEditorClass;
    property InspectorData: TElClassInspectorData read FInspectorData Write FInspectorData;
  end;

  TElInspectorClassesList = class(TLMDObjectList)
  protected
    function GetData(Index: Integer): TElClassInspectorData;
    function GetEditor(Index: integer): TElClassInplaceEditor;
    procedure SetData(Index: Integer; const Value: TElClassInspectorData);
    procedure SetEditor(Index: integer; const Value: TElClassInplaceEditor);
  public
    function GetNeededData(const AItem: TElInspectorItem): TElInspectorRegister;
    function GetNeededEditor(const AItem: TElInspectorItem): TElInspectorRegister; virtual; abstract;
    procedure RegisterData(Value: TElInspectorRegister);
    property Data[Index: Integer]: TElClassInspectorData read GetData write SetData;
    property Editors[Index: integer]: TElClassInplaceEditor read GetEditor write SetEditor;
  end;

  // Classes
  TElCategory = class (TCollectionItem)
  protected
    FCategoryItem: TElInspectorItem;
    FName: TLMDString;
    FTag: Integer;
  public
    property CategoryItem: TElInspectorItem read FCategoryItem write FCategoryItem default nil;
  published
    property Name: TLMDString read FName write FName;
    property Tag: Integer read FTag write FTag;
  end;

  TElCategories = class(TCollection)
  protected
    function GetItems(index: integer): TElCategory;
    procedure SetItems(index: integer; newValue: TElCategory);
    procedure Update(Item: TCollectionItem); override;
  public
    function Add: TElCategory;
    property Items[index: integer]: TElCategory read GetItems write SetItems; default;
  end;

  TElEnumerator = class(TPersistent)
  protected
    FOwner: TElInspectorDataSource;
  public
    function GetFirstItem: TElInspectorData; virtual; abstract;
    function GetNextItem: TElInspectorData; virtual; abstract;
    property Owner: TElInspectorDataSource read FOwner Write FOwner;
  end;

  // Visual styles for TElInspector
  TElInspectorItemStyle = class(TPersistent)
  protected
    FColor: TColor;
    FBkColor: TColor;
    FFontStyles: TFontStyles;
  published
    property BkColor: TColor read FBkColor Write FBkColor;
    property Color: TColor read FColor write FColor default clBlack;
    property FontStyles: TFontStyles read FFontStyles write FFontStyles default [];
  end;

  (**
  Style for inspector
  *)
  TElTreeOptions = class(TPersistent)
  private
    FItemIndent: Integer;
    FBarStyle: Boolean;
    FDrawFocusRect: Boolean;
    FBkColor: TColor;
    FHorzDivLinesColor: TColor;
    FVertDivLinesColor: TColor;
    FFocusedSelectColor: TColor;
    FHideSelectColor: TColor;
    FFocusedSelectTextColor: TColor;
    FHideSelectTextColor: TColor;
  published
    property BarStyle: Boolean read FBarStyle Write FBarStyle;
    property DrawFocusRect: Boolean read FDrawFocusRect Write FDrawFocusRect;
    property HorzDivLinesColor: TColor read FHorzDivLinesColor Write FHorzDivLinesColor;
    property VertDivLinesColor: TColor read FVertDivLinesColor Write FVertDivLinesColor;
    property BkColor: TColor read FBkColor Write FBkColor;
    property HideSelectColor: TColor read FHideSelectColor write FHideSelectColor default clBtnFace;
    property FocusedSelectColor: TColor read FFocusedSelectColor write FFocusedSelectColor default clHighlight;
    property HideSelectTextColor: TColor read FHideSelectTextColor write FHideSelectTextColor default LMDElHideSelectTextColor;
    property FocusedSelectTextColor: TColor read FFocusedSelectTextColor write FFocusedSelectTextColor default clHighlightText;
    property ItemIndent: Integer read FItemIndent Write FItemIndent;
  end;

  TElInspectorStyle = class(TElComponent)
  private
    FElTreeOptions: TElTreeOptions;
    FBackground: TColor;
    FCategory: TElInspectorItemStyle;
    FDefaultPropertyValue: TElInspectorItemStyle;
    FEditBackground: TColor;
    FEditValue: TElInspectorItemStyle;
    FOwner: TCustomElInspector;
    FPropertyName: TElInspectorItemStyle;
    FPropertyValue: TElInspectorItemStyle;
    FReadOnlyProperty: TElInspectorItemStyle;
    FReferenceProperty: TElInspectorItemStyle;
    FSubProperty: TElInspectorItemStyle;
    FGutter: TElInspectorItemStyle;
    FLines: TElInspectorItemStyle;
    procedure SetGutter(const Value: TElInspectorItemStyle);
    procedure SetLines(const Value: TElInspectorItemStyle);
    procedure SetBackground(const Value: TColor);
    procedure SetCategory(const Value: TElInspectorItemStyle);
    procedure SetDefaultPropertyValue(const Value: TElInspectorItemStyle);
    procedure SetEditBackground(const Value: TColor);
    procedure SetEditValue(const Value: TElInspectorItemStyle);
    procedure SetPropertyName(const Value: TElInspectorItemStyle);
    procedure SetPropertyValue(const Value: TElInspectorItemStyle);
    procedure SetReadOnlyProperty(const Value: TElInspectorItemStyle);
    procedure SetReferenceProperty(const Value: TElInspectorItemStyle);
    procedure SetSubProperty(const Value: TElInspectorItemStyle);
  protected
    // Draw functions
    procedure DrawHorzLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect; const Width: Integer); virtual; abstract;
    procedure DrawVertLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect); virtual; abstract;
    procedure DrawGutter(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Background: TColor read FBackground write SetBackground;
    property Category: TElInspectorItemStyle read FCategory write SetCategory;
    property DefaultPropertyValue: TElInspectorItemStyle read FDefaultPropertyValue write SetDefaultPropertyValue;
    property EditBackground: TColor read FEditBackground write SetEditBackground;
    property EditValue: TElInspectorItemStyle read FEditValue write SetEditValue;
    property PropertyName: TElInspectorItemStyle read FPropertyName write SetPropertyName;
    property PropertyValue: TElInspectorItemStyle read FPropertyValue write SetPropertyValue;
    property ReadOnlyProperty: TElInspectorItemStyle read FReadOnlyProperty write SetReadOnlyProperty;
    property ReferenceProperty: TElInspectorItemStyle read FReferenceProperty write SetReferenceProperty;
    property SubProperty: TElInspectorItemStyle read FSubProperty write SetSubProperty;
    property Gutter: TElInspectorItemStyle read FGutter Write SetGutter;
    property Lines: TElInspectorItemStyle read FLines Write SetLines;
    property TreeOptions: TElTreeOptions read FElTreeOptions Write FElTreeOptions;
  end;

  TElInspectorStyleSidewinder = class(TElInspectorStyle)
  protected
    FGutterMarker: TBitmap;
    // Draw functions
    procedure DrawHorzLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect; const Width: integer); override;
    procedure DrawVertLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect); override;
    procedure DrawGutter(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TElInspectorStyleNET = class(TElInspectorStyle)
  protected
    // Draw functions
    procedure DrawHorzLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect; const Width: integer); override;
    procedure DrawVertLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect); override;
    procedure DrawGutter(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TElInspectorStyleBorland = class (TElInspectorStyle)
  protected
    // Draw functions
    procedure DrawHorzLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect; const Width: integer); override;
    procedure DrawVertLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  // Childs of ElTree classes
  TElInspectorItem = class (TElTreeItem)
  protected
    FInspectorData: TElInspectorData;
    FIsCategory: Boolean;
  public
    destructor Destroy; override;
    property InspectorData: TElInspectorData read FInspectorData write FInspectorData;
    property IsCategory: Boolean read FIsCategory write FIsCategory default false;
  end;

  TElInspectorTree = class(TElTreeView)
  private
    FResizeCol: Boolean;
  protected
    FLeftMargin: Integer;
    FRightMargin: Integer;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure DrawHorzLine(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect); override;
    procedure DrawVertLine(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect); override;
    procedure DrawGutter(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect); override;
  public
    constructor Create(Owner : TComponent); override;
  end;

  TCustomElInspector = class(TCustomElTree)
  protected
    FCategorized: Boolean;
    FElInspectorDataLink: TElInspectorDataLink;
    FElInspectorTree: TElInspectorTree;
    FFiltered: Boolean;
    FHelpPanel: TElHTMLPanel;
    FRebuildedItem: TElInspectorItem;
    FSplitter: TElSplitter;
    FInspectorStyle: TElInspectorStyle;
    FOldOnHeaderSectionResize: TElHeaderSectionEvent;
    FOnFilterItem: TFilterItemEvent;
    FOnNeedCategory: TNeedCategory;
    FOnNeedDisplayName: TNeedDisplayName;
    FOnNeedTextForHelpPanel: TNeedTextForHelpPanel;
    FOnGetValuesList: TGetValuesList;
    FOnValidateResult: TValidateResult;
    FShowHeader: Boolean;
    FShowHelpPanel: Boolean;
    procedure ValidateEditorInput(Sender: TObject; var Accepted: boolean; var DefaultConversion: boolean);
    procedure AlignPieces; override;
    procedure ApplyStyleToItem(AItem: TElInspectorItem);
    function CreateHelpPanel: TElHTMLPanel; virtual;
    function CreateSplit: TElSplitter; virtual;
    function CreateInplaceManager: TElTreeInplaceManager; override;
    function CreateItems: TElTreeItems; override;
    function CreateView: TElTreeView; override;
    procedure DoEndEditItem(Item: TElTreeItem; Section: TElHeaderSection; Canceled: boolean); override;
    function DoFilterItem(AItem: TElInspectorData): Boolean; virtual;
    procedure DoItemCollapse(Item: TElTreeItem); override;
    procedure DoItemExpand(Item: TElTreeItem); override;
    function DoNeedCategory(AItem: TElInspectorData): Integer; virtual;
    procedure DoNeedDisplayName(AItem: TElInspectorData); virtual;
    procedure DoRebuildInspector(AStartItem: TElInspectorItem); virtual;
    function GetCategory(AParent: TElInspectorItem; AItem: TElInspectorData): TElInspectorItem;
    function GetRebuildedItem: TElInspectorItem;
    procedure MouseDownTransfer(Sender : TObject; Button : TMouseButton; Shift: TShiftState; X : Integer; Y : Integer); override;
    procedure SetCategorized(const Value: Boolean);
    procedure SetDataSource(const Value: TElInspectorDataSource);
    function GetDataSource: TElInspectorDataSource;
    procedure SetFiltered(const Value: Boolean);
    procedure SetInspectorStyle(const Value: TElInspectorStyle);
    procedure SetShowHelpPanel(const Value: Boolean);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure TriggerInplaceEditorNeeded(Item: TElTreeItem; SectionIndex: Integer; SupposedFieldType : TElFieldType; var Editor: TElTreeInplaceEditor); override;
    procedure TriggerItemSelectedChangeEvent(Item: TElTreeItem); override;
    procedure TriggerNeedTextForHelpPanel(Sender: TObject); virtual;
    procedure TriggerGetValuesList(AItem: TElInspectorItem; ASList: TLMDStrings); virtual;
    procedure OnHeaderSectionResize(Header: TCustomElHeader; Section:TElHeaderSection);
    procedure OnSplitPositionChanged(Sender: TObject);
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Resize; override;
    procedure Rebuild(const AStartItem: TElInspectorItem); virtual;
    procedure TriggerValidateResult(const AEditor: TElTreeInplaceEditor; const AItem: TElInspectorData; var Accepted: Boolean); virtual;
  published
    property Categorized: Boolean read FCategorized write SetCategorized default False;
    property DataSource: TElInspectorDataSource read GetDataSource write SetDataSource;
    property Filtered: Boolean read FFiltered write SetFiltered default false;
    property InspectorStyle: TElInspectorStyle read FInspectorStyle write SetInspectorStyle;
    property RebuildedItem: TElInspectorItem read GetRebuildedItem write FRebuildedItem;
    property OnGetValuesList: TGetValuesList read FOnGetValuesList Write FOnGetValuesList;
    property OnFilterItem: TFilterItemEvent read FOnFilterItem write FOnFilterItem;
    property OnNeedCategory: TNeedCategory read FOnNeedCategory write FOnNeedCategory;
    property OnNeedDisplayName: TNeedDisplayName read FOnNeedDisplayName write FOnNeedDisplayName;
    property OnNeedTextForHelpPanel: TNeedTextForHelpPanel read FOnNeedTextForHelpPanel write FOnNeedTextForHelpPanel;
    property OnValidateResult: TValidateResult read FOnValidateResult write FOnValidateResult;
    property ShowHelpPanel: Boolean read FShowHelpPanel write SetShowHelpPanel;
  end;

  TElInspector = class(TCustomElInspector)
  published
    property ActiveBorderType;
    property DragCursor;

    property Align;
    property AlwaysKeepFocus;
    property AlwaysKeepSelection;
    property AutoCollapse;
    property AutoExpand;
    property AutoLineHeight;
    property AutoLookup;
    property AutoResizeColumns;

    property Anchors;
    property Constraints;
    property DockOrientation default doNoOrient;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;

    property DefaultSectionWidth;

    property AdjustMultilineHeight;
    property Background;
    property BackgroundType;

    property BorderStyle;
    property BorderSides;
    property ChangeDelay;
    property ChangeStateImage;
    property CheckBoxGlyph;
    property CheckBoxSize;
    property Ctl3D;
// here is fine
    property Color;
    property Cursor;
    property CustomCheckboxes;
    property CustomPlusMinus;
    property DeselectChildrenOnCollapse;
    property DblClickMode;
    property DoInplaceEdit;
    property DragAllowed;

    property DragExpandDelay;
    property DraggableSections;
    property DrawFocusRect;
    property DragImageMode;
    property DragRectAcceptColor;
    property DragRectDenyColor;
    property DragScrollInterval;
    property DragTrgDrawMode;
    property DragType;

    property Enabled;
    property ExpandOnDragOver;
    property ExplorerEditMode;
    property FilteredVisibility;
    property Flat;
    property FlatFocusedScrollbars;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property ForcedScrollBars;
    property Font stored IsFontStored;
    property FullRowSelect;

    property GradientStartColor;
    property GradientEndColor;
    property GradientSteps;

    property HeaderActiveFilterColor;
    property HeaderColor;
    property HeaderHeight;
    property HeaderHotTrack;
    property HeaderInvertSortArrows;
    property HeaderSections;
    property HeaderFilterColor;
    property HeaderFlat;
    property HeaderFont;
    property HeaderUseTreeFont;
    property HeaderImages;
    property AlphaForHeaderImages;

    property HeaderWrapCaptions;

    property HideFocusRect;
    property HideHintOnTimer;
    property HideHintOnMove;
    property HideSelectColor;
    property HideSelectTextColor;
    property HideSelection;
    property HighlightAlphaLevel;
    property HorizontalLines;
    property HideHorzScrollBar;
    property HideVertScrollBar;
    property Hint;
    property HintType;
    property HorzDivLinesColor;
    property HorzScrollBarStyles;
    property IgnoreEnabled;
    property HeaderImageForm;
    property ImageForm;
    property Images;
    property Images2;
    property AlphaForImages;
    property AlphaForImages2;
    property InactiveBorderType;
    property IncrementalSearch;
    property IncrementalSearchScope;
    property IncrementalSearchTimeout;
    property InplaceEditorDelay;
    property ItemIndent;
    property KeepSelectionWithinLevel;
    property LeafPicture;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property LineHeight;
    property LinesColor;
    property LinesStyle;
    property LineHintColor;
    property LineHintMode default shmLong;
    property LineHintTimeout;
    property LineHintType;
    property LockHeaderHeight;
    property MainTextType;
    property MainTreeColumn;
    property MinusPicture;
    property MoveColumnOnDrag;
    property MoveFocusOnCollapse;
    property MouseFrameSelect;
    property MouseFrameVisible;
    property MultiSelect;
    property MultiSelectLevel;
    property OwnerDrawByColumn default true;
    property OwnerDrawMask;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PathSeparator;
    property PlusMinusTransparent;
    property PlusPicture;
    property PopupMenu;
    property QuickEditMode;

    property RadioButtonGlyph;
    property RightAlignedText;
    property RightAlignedView;
    property RightClickSelect;
    property RowHotTrack;
    property RowSelect;
    property ScrollbarOpposite;
    property HorzScrollTracking;
    property VertScrollTracking;
    property SelectColumn;
    property ShowButtons;
    property ShowColumns;
    property ShowCheckBoxes;
    property ShowEmptyImages;
    property ShowEmptyImages2;
    property ShowHint;
    property ShowImages;
    property ShowLeafButton;
    property ShowLines;
    property ShowRoot;
    property ShowRootButtons;
    property SelectionMode;
    property SortDir;
    property SortMode;
    property SortSection;
    property SortType;

    property Storage;
    property StoragePath;

    property SortUseCase;
    property StickyHeaderSections;
    property StripedOddColor;
    property StripedEvenColor;
    property StripedItems;
    property Items;

    property TabOrder;
    property TabStop;
    property HotTrack;
    property TrackColor;
    property UnderlineTracked;
    property UseCustomScrollBars;

    property VertScrollBarStyles;
    property VirtualityLevel;
    property Visible;
    property UseSystemHintColors;
    property ThemeMode;
    property ThemeGlobalMode;
    property OnScroll;
    property OnHeaderColumnClick;
    property OnHeaderColumnDraw;
    property OnHeaderColumnResize;
    property OnHeaderColumnMove;
    property OnHeaderLookup;
    property OnHeaderLookupDone;
    property OnHeaderResize;
    property OnHeaderSectionExpand;
    property OnHeaderSectionCollapse;
    property OnHeaderSectionFilterCall;
    property OnHeaderSectionAutoSize;
    property OnHeaderSectionMeasure;
    property OnHorzScrollDrawPart;
    property OnHorzScrollHintNeeded;

    property OnAfterSelectionChange;
    property OnApplyVisFilter;
    property OnChanging;
    property OnDragTargetChange;
    property OnItemChange;
    property OnItemPreDraw;
    property OnItemDraw;
    property OnResize;

    property OnTryEdit;
    property OnInplaceEditorNeeded;

    property OnEndEditItem;

    property OnItemChecked;
    property OnItemExpand;
    property OnItemCollapse;
    property OnItemExpanding;
    property OnItemCollapsing;
    property OnItemDeletion;
    property OnItemFocused;
    property OnShowLineHint;
    property OnCompareItems;
    property OnItemPicDraw;
    property OnItemPicDraw2;
    property OnItemPostDraw;
    property OnHotTrack;
    property OnMeasureItemPart;
    property OnSortBegin;
    property OnSortEnd;
    property OnItemSave;
    property OnItemLoad;
    property OnItemSelectedChange;
    property OnCellStyleSave;
    property OnCellStyleLoad;
    property OnVertScrollDrawPart;
    property OnVertScrollHintNeeded;

    property OnHTMLImageNeeded;
    property OnLinkClick;
    property LinkCursor;
    property LinkColor;
    property LinkStyle;

    property OnVirtualPropsNeeded;
    property OnVirtualTextNeeded;
    property OnVirtualHintNeeded;
    property OnVirtualValueNeeded;
    property OnVirtualStyleNeeded;

    property OnHeaderMouseDown;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnDragDrop;
    property OnDragOver;
    property OnStartDrag;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;

    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;

    property OnStartDock;
    property OnEndDock;

    property OnContextPopup;

    property OnOleTargetDrag;
    property OnOleTargetDrop;
    property OnOleDragStart;
    property OnOleDragFinish;

{$IFDEF HOTTRACK_CURSOR}
    property TrackingCursor;
{$ENDIF}
  end;

  THackElTreeItemStaticDataEx = class (TElTreeItemStaticDataEx)
  end;

  implementation

uses
  ElInspectorEditors, LMDElProConst, Types
  ;

{-**********************************************************************
   Class:    TElInspectorTree
***********************************************************************-}
constructor TElInspectorTree.Create(Owner : TComponent);
begin
  inherited;
  FResizeCol := false;
  FLeftMargin := 25;
  FRightMargin := 25;
end;

procedure TElInspectorTree.DrawGutter(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect);
begin
  if Assigned(TElInspector(FOwner).InspectorStyle) then
    TElInspector(FOwner).InspectorStyle.DrawGutter(ACanvas, Item, R)
  else
    inherited;
end;

procedure TElInspectorTree.DrawHorzLine(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect);
begin
  if Assigned(TElInspector(FOwner).InspectorStyle) then
    TElInspector(FOwner).InspectorStyle.DrawHorzLine(ACanvas, Item, R, FHeader.Sections[0].Width)
  else
    inherited;
end;

procedure TElInspectorTree.DrawVertLine(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect);
begin
  if Assigned(TElInspector(FOwner).InspectorStyle) then
  begin
    TElInspector(FOwner).InspectorStyle.DrawVertLine(ACanvas, Item, R);
  end
  else
    inherited;
end;

procedure TElInspectorTree.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FOwner.IsUpdating := True;
  if (X in [FHeader.Sections[0].Width - 3..FHeader.Sections[0].Width + 1]) then
    FResizeCol := True
  else
    inherited;
  FOwner.IsUpdating := false;
end;

procedure TElInspectorTree.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (X in [FHeader.Sections[0].Width - 3..FHeader.Sections[0].Width + 1]) then
    Cursor := crHSplit
  else
    Cursor :=  crDefault;
  if (FResizeCol) and (X > FLeftMargin) and (Width - X > FRightMargin) then
  begin
    FOwner.IsUpdating := True;
    FHeader.Sections[0].Width := X;
    FOwner.IsUpdating := False;
  end
end;

procedure TElInspectorTree.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FResizeCol := false;
end;

{-**********************************************************************
   Class:    TElInspectorRegister
***********************************************************************-}
constructor TElInspectorRegister.Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData);
begin
  inherited Create();
  FEditorClass := AClass;
  FInspectorData := AInspData;
end;

{-**********************************************************************
   Class:    TElInspectorClassesList
***********************************************************************-}
function TElInspectorClassesList.GetData(Index: Integer): TElClassInspectorData;
begin
  Result := TElInspectorRegister(Items[Index]).FInspectorData;
end;

procedure TElInspectorClassesList.SetData(Index: Integer; const Value: TElClassInspectorData);
begin
  TElInspectorRegister(Items[Index]).FInspectorData := Value;
end;

function TElInspectorClassesList.GetEditor(Index: integer): TElClassInplaceEditor;
begin
  Result := TElInspectorRegister(Items[Index]).FEditorClass;
end;

procedure TElInspectorClassesList.SetEditor(Index: integer; const Value: TElClassInplaceEditor);
begin
  TElInspectorRegister(Items[Index]).FEditorClass := Value;
end;

procedure TElInspectorClassesList.RegisterData(Value: TElInspectorRegister);
begin
  Add(Pointer(Value));
  end;

function TElInspectorClassesList.GetNeededData(const AItem: TElInspectorItem): TElInspectorRegister;
begin
  Result := nil;
end;

{-**********************************************************************
   Class:    TCustomElInspector
***********************************************************************-}
constructor TCustomElInspector.Create(AOwner: TComponent);
begin
  inherited;
  FElInspectorDataLink := TElInspectorDataLink.Create(Self);
  FShowHeader := true;
  FMultiSelect := false;
  FRowSelect := true;
  //  SelectColumn := 0;
  FRowHotTrack := false;
  FShowRoot := false;
  FShowButtons := true;
  FShowLines := false;
  FShowImages := false;
  FVerticalLines := true;
  FHorizontalLines := true;
  FVerticalLinesLong := false;
  FBarStyle := true;

  FRebuildedItem := nil;

  FExplorerEditMode := True;
  FDoubleBuffered := True;

  FHideHorzScrollBar := True;

  FDrawFocusRect := false;

  // first column
  FHeader.Sections.AddSection.Editable := False;
  // second column
  FHeader.Sections.AddSection.Editable := True;

  FOldOnHeaderSectionResize := FHeader.OnSectionResize;
  FHeader.OnSectionResize := OnHeaderSectionResize;

  SetShowHeader(True);
  SetLockHeaderHeight(True);
  FHeader.Height := 0;

  FHelpPanel := CreateHelpPanel;

  TElComponentAccess(FHelpPanel).SetDesigning(csDesigning in ComponentState);

  FHelpPanel.TransparentXPThemes := False;
  FHelpPanel.Color := clBtnFace;
  FHelpPanel.Align := alBottom;
  FHelpPanel.Visible := FShowHelpPanel;
  FHelpPanel.Parent := Self;

  FSplitter := CreateSplit;

  TElComponentAccess(FSplitter).SetDesigning(csDesigning in ComponentState);

  FSplitter.Align := alBottom;
  FSplitter.Visible := FShowHelpPanel;
  FSplitter.OnPositionChanged := OnSplitPositionChanged;
  FSplitter.Parent := Self;

  SetItemIndent(11);
  FQuickEditMode := False;
  FNotRaiseForBarStyle := True;

  AlignPieces;
end;

destructor TCustomElInspector.Destroy;
begin
  FElInspectorDataLink.Destroy;
  FHelpPanel.Free;
  inherited;
end;

procedure TCustomElInspector.AlignPieces;
var
  TreeRect: TRect;
  PanelRect: TRect;
  VScrollRect: TRect;
  wv: Integer;
begin
  if not HandleAllocated then Exit;
  FIgnoreSBChange := True;
  //  inherited;
  TreeRect := ClientRect;
  FHelpPanel.Left := 0;
  if FShowHelpPanel then
  begin
    FSplitter.Top := TreeRect.Bottom - FSplitter.Height - FHelpPanel.Height;
    FSplitter.Width := TreeRect.Right;
    FHelpPanel.Top := TreeRect.Bottom - FHelpPanel.Height{ - FSplitter.Height};
    FHelpPanel.Width := TreeRect.Right;
    TreeRect.Bottom := FHelpPanel.Top - FSplitter.Height;
    PanelRect := FHelpPanel.BoundsRect;
  end
  else
    if csDesigning in ComponentState then
    begin
      FSplitter.Top := -$FFFF;
      FHelpPanel.Top := -$FFFF;
    end;
  if FVScrollVisible and FUseCustomBars then
  begin
    wv := FVScrollBar.Width;
    if RightAlignedText xor ScrollBarOpposite then
    begin
      VScrollRect := Rect(TreeRect.Left, 0, TreeRect.Left + wv, TreeRect.Bottom);
      Inc(TreeRect.Left, wv);
    end
    else
    begin
      VScrollRect := Rect(TreeRect.Right - wv, 0, TreeRect.Right, TreeRect.Bottom);
      dec(TreeRect.Right, wv);
    end;
    if FShowHelpPanel then
      VScrollRect.Bottom := FHelpPanel.Top - FSplitter.Height;
  end;

  FView.Align := alNone;
  with TreeRect do
    SetWindowPos(FView.Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top, SWP_NOACTIVATE or SWP_NOOWNERZORDER or SWP_NOZORDER or SWP_SHOWWINDOW or SWP_NOSENDCHANGING);

  with VScrollRect do
    if FVScrollVisible and FUseCustomBars then
      SetWindowPos(FVScrollBar.Handle, HWND_TOP, VScrollRect.Left, VScrollRect.Top, VScrollRect.Right - VScrollRect.Left, VScrollRect.Bottom - VScrollRect.Top, SWP_NOACTIVATE or SWP_NOOWNERZORDER {or SWP_NOZORDER }or SWP_SHOWWINDOW or SWP_NOSENDCHANGING)
    else
      SetWindowPos(FVScrollBar.Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_HIDEWINDOW);

  FIgnoreSBChange := false;
  OnHeaderSectionResize(FHeader, FHeader.Sections[1]);
end;

procedure TCustomElInspector.ApplyStyleToItem(AItem: TElInspectorItem);
var
  LStyle: TElCellStyle;

  procedure ApplyStyle(ACell: TElCellStyle; AStyle: TElInspectorItemStyle);
  begin
    with ACell do
    begin
      OwnerProps := false;
      UseBkColor := true;
      if (AItem.Selected) and (ACell <> AItem.MainStyle){ and (not AItem.InspectorData.IsReadOnly) }then
      begin
        CellBkColor := InspectorStyle.EditBackground;
        TextBkColor := InspectorStyle.EditBackground;
      end
      else
      begin
//        CellBkColor := InspectorStyle.Background;
//        TextBkColor := InspectorStyle.Background;
        CellBkColor := AStyle.BkColor;
        TextBkColor := AStyle.BkColor;
      end;

      FontStyles := AStyle.FontStyles;
      TextColor := AStyle.Color;
    end;
  end;

begin
  if Assigned(FInspectorStyle) and Assigned(AItem) then
  begin
    AItem.UseStyles := True;
    AItem.UseBkColor := true;
    if AItem.StylesCount > 0 then
      LStyle := AItem.Styles[0]
    else
      LStyle := AItem.AddStyle;

    // TODO: Make style assigned to item
    if Assigned(AItem.Parent) and (not TElInspectorItem(AItem.Parent).IsCategory) and
       (Assigned(TElInspectorItem(AItem.Parent).InspectorData) and
       TElInspectorItem(AItem.Parent).InspectorData.IsReference) then
      ApplyStyle(AItem.MainStyle, InspectorStyle.SubProperty)
    else
      ApplyStyle(AItem.MainStyle, InspectorStyle.PropertyName);

    if AItem.IsCategory then
    begin
      ApplyStyle(AItem.MainStyle, InspectorStyle.Category);
      ApplyStyle(LStyle, InspectorStyle.Category);
      AItem.MainStyle.CellType := sftUndef;
    end
    else
    begin
      if Assigned(AItem.InspectorData) then
      begin
        // Reference
        if AItem.InspectorData.IsReference then
          ApplyStyle(AItem.MainStyle, InspectorStyle.ReferenceProperty);

        // non-Default value
        if AItem.InspectorData.IsDefault then
          ApplyStyle(LStyle, InspectorStyle.DefaultPropertyValue)
        else
          ApplyStyle(LStyle, InspectorStyle.PropertyValue);

        if AItem.InspectorData.IsReadOnly then
          ApplyStyle(AItem.MainStyle, InspectorStyle.ReadOnlyProperty);
      end;
    end;
  end;
end;

function TCustomElInspector.CreateHelpPanel: TElHTMLPanel;
begin
  Result := TElHTMLPanel.Create(Self);
  with Result do
  begin
    BorderStyle := bsNone;
    BevelOuter := bvNone;
    BevelKind := bkNone;
    Alignment := taLeftJustify;
    Layout := tlTop;
    Caption := '';
  end;
end;

function TCustomElInspector.CreateSplit: TElSplitter;
begin
  Result := TElSplitter.Create(Self);
  with Result do
  begin
    ControlTopLeft := FView;
    ControlBottomRight := FHelpPanel;
    Height := 3;
    ShowSnapButton := false;
    ResizeStyle := ersPattern;
  end;
end;

function TCustomElInspector.CreateInplaceManager: TElTreeInplaceManager;
begin
  Result := TElInspectorInplaceManager.Create(Self);
end;

function TCustomElInspector.CreateItems: TElTreeItems;
begin
  Result := TElTreeItems.CreateClass(Self, TElInspectorItem);
end;

function TCustomElInspector.CreateView: TElTreeView;
begin
  Result := TElInspectorTree.Create(Self);
  Result.Align := alClient;
end;

procedure TCustomElInspector.DoEndEditItem(Item: TElTreeItem; Section: TElHeaderSection; Canceled: boolean);
begin
  //  TElInspectorItem(Item).InspectorData.Value := Item.ColumnText.Strings[0];
  inherited;
end;

function TCustomElInspector.DoFilterItem(AItem: TElInspectorData): Boolean;
begin
  Result := True;
  if Filtered then
    if Assigned(FOnFilterItem) then
      FOnFilterItem(Self, AItem, Result);
end;

procedure TCustomElInspector.DoItemCollapse(Item: TElTreeItem);
begin
  inherited;
  Selected := Item;
end;

procedure TCustomElInspector.DoItemExpand(Item: TElTreeItem);
begin
  inherited;
  Selected := Item;
end;

function TCustomElInspector.DoNeedCategory(AItem: TElInspectorData): Integer;
begin
  Result := -1;
  if Assigned(DataSource.FNeedCategory) then
    DataSource.FNeedCategory(Self, AItem, Result)
  else
    if Assigned(FOnNeedCategory) then
      FOnNeedCategory(Self, AItem, Result);
end;

procedure TCustomElInspector.DoNeedDisplayName(AItem: TElInspectorData);
var
  LDisplayName: TLMDString;
begin
  if Assigned(FOnNeedDisplayName) then
  begin
    FOnNeedDisplayName(Self, AItem, LDisplayName);
    AItem.DisplayName := LDisplayName;
  end;
end;

procedure TCustomElInspector.DoRebuildInspector(AStartItem: TElInspectorItem);

  {$Q+}
  procedure Recurse(AParent: TElInspectorItem);
  var
    LEnum: TElEnumerator;
    LItem: TElInspectorData;
    LParent: TElInspectorItem;
  begin
    if Assigned(AParent) then
      LEnum := DataSource.CreateEnumerator(AParent.InspectorData)
    else
      LEnum := DataSource.CreateEnumerator(nil);

    if Assigned(LEnum) then
    begin
      LItem := LEnum.GetFirstItem;
      while (Assigned(LItem)) do
      begin

        if DoFilterItem(LItem) then
        begin
          DoNeedDisplayName(LItem);

          AParent := GetCategory(AParent, LItem);

          LParent := (Items.AddChild(AParent, LItem.DisplayName) as TElInspectorItem);
          if Assigned(AParent) then
            if AParent.IsCategory then
              AParent := nil;

          LItem.InspectorItem := LParent;
          LParent.ColumnText.Add(LItem.Value);
          LParent.InspectorData := LItem;

          ApplyStyleToItem(LParent);

          if LItem.IsComplex then
            Recurse(LParent);
        end;

        LItem := LEnum.GetNextItem;
      end;

      DataSource.DestroyEnumerator(LEnum);
    end;
  end;
  {$Q-}

begin
  IsUpdating := True;
  if Assigned(AStartItem) then
    AStartItem.Clear
  else
    Items.Clear;

  if DataSource <> nil then
  begin
    DataSource.ClearItemIndex;
    Recurse(AStartItem);
  end;
  IsUpdating := False;
end;

function TCustomElInspector.GetCategory(AParent: TElInspectorItem; AItem: TElInspectorData): TElInspectorItem;
var
  LIdx: Integer;
begin
  Result := AParent;
  if (not Assigned(AParent)) and (Categorized) then
  begin
    LIdx := DoNeedCategory(AItem);
    if (LIdx >= 0) and (LIdx < DataSource.Categories.Count) then
    begin
      if Assigned(DataSource.Categories.Items[LIdx].CategoryItem) then
        Result := DataSource.Categories.Items[LIdx].CategoryItem
      else
      begin
        Result := TElInspectorItem(Items.Add(nil, DataSource.Categories.Items[LIdx].Name));
        Result.IsCategory := true;
        DataSource.Categories.Items[LIdx].FCategoryItem := Result;
      end;
      ApplyStyleToItem(Result);
    end;
  end;
end;

function TCustomElInspector.GetRebuildedItem: TElInspectorItem;
begin
  Result := FRebuildedItem;
end;

procedure TCustomElInspector.MouseDownTransfer(Sender : TObject; Button : TMouseButton; Shift: TShiftState; X : Integer; Y : Integer);
begin
  IsUpdating := True;
  inherited;
  EndEdit(False);
  if Assigned(Selected) then
    if Assigned(TElInspectorItem(Selected).InspectorData) then
      if not TElInspectorItem(Selected).InspectorData.IsReadOnly then
        if Assigned(Selected) then
        begin
          TriggerNeedTextForHelpPanel(Selected);

          if Assigned(Selected.Parent) then
          begin
            if (Selected.Parent.Expanded) then
              EditItem(Selected, 1)
            else
            begin
              Selected := Selected.Parent;
              EditItem(Selected, 1);
            end
          end
          else
            EditItem(Selected, 1);
        end
        else
          EndEdit(false);
  if RebuildedItem <> nil then
  begin
    Rebuild(RebuildedItem);
    RebuildedItem := nil;
  end;
  IsUpdating := False;
end;

procedure TCustomElInspector.OnHeaderSectionResize(Header: TCustomElHeader; Section:TElHeaderSection);
begin
  if Assigned(FHeader) and (not (csLoading in Componentstate)) then
  begin
    FOldOnHeaderSectionResize(Header, Section);
    FHeader.OnSectionResize := nil;
    FHeader.Sections[1].Width := View.Width - FHeader.Sections[0].Width + 1;
    FHeader.OnSectionResize := OnHeaderSectionResize;
  end;
end;

procedure TCustomElInspector.OnSplitPositionChanged(Sender: TObject);
begin
  AlignPieces;
end;

procedure TCustomElInspector.SetCategorized(const Value: Boolean);
begin
  if FCategorized <> Value then
  begin
    FCategorized := Value;
    if IsEditing then
      EndEdit(false);
    if Assigned(DataSource) then
      DoRebuildInspector(nil);
  end;
end;

function TCustomElInspector.GetDataSource: TElInspectorDataSource;
begin
  Result := FElInspectorDataLink.InspectorDataSource;
end;

procedure TCustomElInspector.SetDataSource(const Value: TElInspectorDataSource);
begin
  FElInspectorDataLink.InspectorDataSource := Value;
  DoRebuildInspector(nil);
end;

procedure TCustomElInspector.SetFiltered(const Value: Boolean);
begin
  if FFiltered <> Value then
  begin
    FFiltered := Value;
    DoRebuildInspector(nil);
  end;
end;

procedure TCustomElInspector.SetInspectorStyle(const Value: TElInspectorStyle);
begin
  FInspectorStyle := Value;
  try
    FInspectorStyle.FOwner := Self;
    BarStyle := FInspectorStyle.TreeOptions.BarStyle;
    DrawFocusRect := FInspectorStyle.TreeOptions.DrawFocusRect;
    HorzDivLinesColor := FInspectorStyle.TreeOptions.HorzDivLinesColor;
    VertDivLinesColor := FInspectorStyle.TreeOptions.VertDivLinesColor;
    HideSelectTextColor := FInspectorStyle.TreeOptions.HideSelectTextColor;
    HideSelectColor := FInspectorStyle.TreeOptions.HideSelectColor;
    FocusedSelectColor := FInspectorStyle.TreeOptions.FocusedSelectColor;
    FocusedSelectTextColor := FInspectorStyle.TreeOptions.FocusedSelectTextColor;
    ItemIndent := FInspectorStyle.TreeOptions.ItemIndent;
    BkColor := FInspectorStyle.TreeOptions.BkColor;
    Color := FInspectorStyle.TreeOptions.BkColor;
  except
    FInspectorStyle := nil;
  end;
  if DataSource <> nil then
    DoRebuildInspector(nil);
end;

procedure TCustomElInspector.SetShowHelpPanel(const Value: Boolean);
begin
  if FShowHelpPanel <> Value then
  begin
    FShowHelpPanel := Value;
    FHelpPanel.Visible := Value;
    FSplitter.Visible := Value;
    AlignPieces;
  end;
end;

procedure TCustomElInspector.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FInspectorStyle then
    begin
      FInspectorStyle := nil;
      Invalidate;
    end;
  end;
end;

procedure TCustomElInspector.TriggerInplaceEditorNeeded(Item: TElTreeItem; SectionIndex: Integer; SupposedFieldType : TElFieldType; var Editor: TElTreeInplaceEditor);
var
  LEditorClass: TElClassInplaceEditor;
  LReg: TElInspectorRegister;
begin
  LReg := DataSource.RegisterList.GetNeededEditor(TElInspectorItem(Item));
  Editor := nil;
  if Assigned(LReg) then
  begin
    LEditorClass := LReg.EditorClass;
    Editor := TElInspectorInplaceManager(FEditorManager).GetSuitableEditor(LEditorClass);
    if Assigned(Editor) then
      Editor.OnAfterOperation := ValidateEditorInput;
  end;
end;

procedure TCustomElInspector.TriggerItemSelectedChangeEvent(Item: TElTreeItem);
begin
  IsUpdating := True;
  ApplyStyleToItem(TElInspectorItem(Item));
  IsUpdating := false;
  inherited;
end;

procedure TCustomElInspector.TriggerNeedTextForHelpPanel(Sender: TObject);
var
  LS: TLMDString;
begin
  if Assigned(FOnNeedTextForHelpPanel) then
    OnNeedTextForHelpPanel(Sender, LS)
  else
    LS := '<html><b>' + (Sender as TElTreeItem).Caption + '</b>';

  FHelpPanel.Caption := LS;
end;

procedure TCustomElInspector.TriggerValidateResult(const AEditor: TElTreeInplaceEditor; const AItem: TElInspectorData; var Accepted: Boolean);
begin
  if  Assigned(FOnValidateResult) then
    FOnValidateResult(AEditor, AItem, Accepted)
  else
    Accepted := True;
end;

procedure TCustomElInspector.ValidateEditorInput(Sender: TObject; var Accepted: boolean; var DefaultConversion: boolean);
begin
  ;
end;

procedure TCustomElInspector.TriggerGetValuesList(AItem: TElInspectorItem; ASList: TLMDStrings);
begin
  if Assigned(FOnGetValuesList) then
    FOnGetValuesList(AItem, ASList);
end;

procedure TCustomElInspector.Resize;
begin
  IsUpdating := True;
  inherited;
  FHeader.Sections[0].Width := Width div 2;
  IsUpdating := False;
end;

procedure TCustomElInspector.Rebuild(const AStartItem: TElInspectorItem);
begin
  DoRebuildInspector(AStartItem);
end;

{-**********************************************************************
   Class:    TElCategories
***********************************************************************-}
function TElCategories.GetItems(index: integer): TElCategory;
begin
  Result := TElCategory(inherited GetItem(Index));
end;

procedure TElCategories.SetItems(index: integer; newValue: TElCategory);
begin
  inherited SetItem(Index, newValue);
end;

procedure TElCategories.Update(Item: TCollectionItem);
begin
  inherited;
end;

function TElCategories.Add: TElCategory;
begin
  Result := TElCategory(Inherited Add);
  Result.FCategoryItem := nil;
end;

{-**********************************************************************
   Class:    TElInspectorData
***********************************************************************-}
function TElInspectorData.GetAsBoolean: Boolean;
begin
  Result := StrToBool(GetAsString);
  end;

function TElInspectorData.GetAsDateTime: TDateTime;
begin
  Result := StrToDateTime(GetAsString);
end;

function TElInspectorData.GetAsFloat: Double;
begin
  Result := StrToFloat(GetAsString);
end;

function TElInspectorData.GetAsInt64: Int64;
begin
  Result := StrToInt64(GetAsString);
end;

function TElInspectorData.GetAsInteger: Integer;
begin
  Result := StrToInt(GetAsString);
end;

function TElInspectorData.GetAsMethod: TMethod;
begin
  raise EElStackError.CreateFmt(SLMDElCantGetThisPropAs, ['TMethod']);
end;

function TElInspectorData.GetAsObject: TObject;
begin
  raise EElInpectorError.CreateFmt(SLMDElCantGetThisPropAs, ['TObject']);
end;

function TElInspectorData.GetAsVariant: Variant;
begin
  Result := GetAsString;
end;

function TElInspectorData.GetDisplayName: TLMDString;
begin
  if FDisplayName <> '' then
    Result := FDisplayName
  else
    Result := GetName;
end;

function TElInspectorData.GetIsComplex: Boolean;
begin
  Result := False;
end;

function TElInspectorData.GetIsEnumerable: Boolean;
begin
  Result := False;
end;

function TElInspectorData.GetIsReference: Boolean;
begin
  Result := False;
end;

function TElInspectorData.GetIsReadOnly: Boolean;
begin
  Result := False;
end;

function TElInspectorData.GetMaxValue: Integer;
begin
  Result := 0;
end;

function TElInspectorData.GetMinValue: Integer;
begin
  Result := 255;
end;

procedure TElInspectorData.SetAsBoolean(Value: Boolean);

begin
  SetAsString(BoolToStr(Value));
  end;

procedure TElInspectorData.SetAsDateTime(Value: TDateTime);
begin
  SetAsString(DateTimeToStr(Value));
end;

procedure TElInspectorData.SetAsFloat(Value: Double);
begin
  SetAsString(FloatToStr(Value));
end;

procedure TElInspectorData.SetAsInt64(Value: Int64);
begin
  SetAsString(IntToStr(Value));
end;

procedure TElInspectorData.SetAsInteger(Value: Integer);
begin
  SetAsString(IntToStr(Value));
end;

procedure TElInspectorData.SetAsMethod(Value: TMethod);
begin
  raise EElInpectorError.CreateFmt(SLMDElCantSetThisPropAs, ['TMethod']);
end;

procedure TElInspectorData.SetAsObject(Value: TObject);
begin
  raise EElInpectorError.CreateFmt(SLMDElCantSetThisPropAs, ['TObject']);
end;

procedure TElInspectorData.SetAsVariant(Value: Variant);
begin
  SetAsString(Value);
end;

procedure TElInspectorData.SetDisplayName(Value: TLMDString);
begin
  if FDisplayName <> Value then
  begin
    FDisplayName := Value;
    if Assigned(FInspectorItem) then
      FInspectorItem.Caption := GetDisplayName;
  end;
end;

function TElInspectorData.GetIsDefault: Boolean;
begin
  Result := false;
end;

{-**********************************************************************
   Class:    TElInspectorStyle
***********************************************************************-}
constructor TElInspectorStyle.Create(AOwner: TComponent);
begin
  inherited;
  FElTreeOptions := TElTreeOptions.Create;
  FEditValue := TElInspectorItemStyle.Create;
  FCategory := TElInspectorItemStyle.Create;
  FPropertyName := TElInspectorItemStyle.Create;
  FPropertyValue := TElInspectorItemStyle.Create;
  FDefaultPropertyValue := TElInspectorItemStyle.Create;
  FReadOnlyProperty := TElInspectorItemStyle.Create;
  FReferenceProperty := TElInspectorItemStyle.Create;
  FSubProperty := TElInspectorItemStyle.Create;
  FGutter := TElInspectorItemStyle.Create;
  FLines := TElInspectorItemStyle.Create;
end;

destructor TElInspectorStyle.Destroy;
begin
  FElTreeOptions.Free;
  FEditValue.Free;
  FCategory.Free;
  FPropertyName.Free;
  FPropertyValue.Free;
  FDefaultPropertyValue.Free;
  FReadOnlyProperty.Free;
  FReferenceProperty.Free;
  FSubProperty.Free;
  FGutter.Free;
  FLines.Free;
  inherited;
end;

procedure TElInspectorStyle.DrawGutter(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect);
begin
  ;
end;

procedure TElInspectorStyle.SetBackground(const Value: TColor);
begin
  FBackground := Value;
//  if Assigned(FOwner) then
//    FOwner.DoRebuildInspector(TElInspectorItem(Items.RootItem[0]));
end;

procedure TElInspectorStyle.SetCategory(const Value: TElInspectorItemStyle);
begin
  FCategory := Value;
//  if Assigned(FOwner) then
//    FOwner.DoRebuildInspector(TElInspectorItem(Items.RootItem[0]));
end;

procedure TElInspectorStyle.SetDefaultPropertyValue(const Value: TElInspectorItemStyle);
begin
  FDefaultPropertyValue := Value;
  if Assigned(FOwner) then
    FOwner.DoRebuildInspector(nil);
end;

procedure TElInspectorStyle.SetEditBackground(const Value: TColor);
begin
  FEditBackground := Value;
  if Assigned(FOwner) then
    FOwner.DoRebuildInspector(nil);
end;

procedure TElInspectorStyle.SetEditValue(const Value: TElInspectorItemStyle);
begin
  FEditValue := Value;
  if Assigned(FOwner) then
    FOwner.DoRebuildInspector(nil);
end;

procedure TElInspectorStyle.SetGutter(const Value: TElInspectorItemStyle);
begin
  FGutter := Value;
  if Assigned(FOwner) then
    FOwner.DoRebuildInspector(nil);
end;

procedure TElInspectorStyle.SetLines(const Value: TElInspectorItemStyle);
begin
  FLines := Value;
  if Assigned(FOwner) then
    FOwner.DoRebuildInspector(nil);
end;

procedure TElInspectorStyle.SetPropertyName(const Value: TElInspectorItemStyle);
begin
  FPropertyName := Value;
  if Assigned(FOwner) then
    FOwner.DoRebuildInspector(nil);
end;

procedure TElInspectorStyle.SetPropertyValue(const Value: TElInspectorItemStyle);
begin
  FPropertyValue := Value;
  if Assigned(FOwner) then
    FOwner.DoRebuildInspector(nil);
end;

procedure TElInspectorStyle.SetReadOnlyProperty(const Value: TElInspectorItemStyle);
begin
  FReadOnlyProperty := Value;
  if Assigned(FOwner) then
    FOwner.DoRebuildInspector(nil);
end;

procedure TElInspectorStyle.SetReferenceProperty(const Value: TElInspectorItemStyle);
begin
  FReferenceProperty := Value;
  if Assigned(FOwner) then
    FOwner.DoRebuildInspector(nil);
end;

procedure TElInspectorStyle.SetSubProperty(const Value: TElInspectorItemStyle);
begin
  FSubProperty := Value;
  if Assigned(FOwner) then
     FOwner.DoRebuildInspector(nil);
end;

{-**********************************************************************
   Class:    TElInspectorStyleBorland
***********************************************************************-}
constructor TElInspectorStyleBorland.Create(AOwner: TComponent);
begin
  inherited;
  FBackground := clBtnFace;
  FEditBackground := clBtnFace;//clWindow;
  FEditValue.FColor := clBtnText;

  FCategory.FColor := clPurple;
  FCategory.FBkColor := clBtnFace;
  FCategory.FFontStyles := [fsBold];

  FPropertyName.FColor := clBtnText;
  FPropertyName.FBkColor := clBtnFace;

  FPropertyValue.FColor := clNavy;
  FPropertyValue.FBkColor := clBtnFace;

  FDefaultPropertyValue.FColor := clNavy;
  FDefaultPropertyValue.FBkColor := clBtnFace;
  FDefaultPropertyValue.FFontStyles := [fsBold];

  FReadOnlyProperty.FColor := clBtnText;
  FReadOnlyProperty.FBkColor := clBtnFace;

  FReferenceProperty.FColor := clMaroon;
  FReferenceProperty.FBkColor := clBtnFace;

  FSubProperty.FColor := clGreen;
  FSubProperty.FBkColor := clBtnFace;

  with FElTreeOptions do
  begin
    FBarStyle := True;
    HorzDivLinesColor := clBtnShadow;
    VertDivLinesColor := clBtnShadow;
    DrawFocusRect := False;
    BkColor := clBtnFace;
    ItemIndent := 10;
  end;
end;

procedure TElInspectorStyleBorland.DrawHorzLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect; const Width: integer);
var
  k: Integer;
begin
  if not Item.Selected then
  begin
    k := R.Left;
    While (k <= R.Right) do
    begin
      ACanvas.MoveTo(k, R.Top);
      if (not (k in [Width - 1, Width])) or (TElInspectorItem(Item).IsCategory) then
        ACanvas.LineTo(k + 1, R.Top);
      Inc(k, 2);
    end;
  end;
end;

procedure TElInspectorStyleBorland.DrawVertLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect);
begin
  if not TElInspectorItem(Item).IsCategory then
  begin
    ACanvas.Pen.Color := clBtnHighlight;
    ACanvas.MoveTo(R.Left, R.Top - 1);
    ACanvas.LineTo(R.Left, R.Bottom);
    ACanvas.Pen.Color := clBtnShadow;
    ACanvas.MoveTo(R.Left - 1, R.Bottom);
    ACanvas.LineTo(R.Left - 1, R.Top - 1);
  end;
end;

{-**********************************************************************
   Class: TElInspectorStyleNET
***********************************************************************-}
constructor TElInspectorStyleNET.Create(AOwner: TComponent);
begin
  inherited;
  FBackground := clWindow;
  FEditBackground := clWindow;
  FEditValue.FColor := clBtnText;

  FCategory.FColor := clBtnShadow;
  FCategory.FBkColor := clBtnFace;
  FCategory.FFontStyles := [fsBold];

  FPropertyName.FColor := clBtnText;
  FPropertyName.FBkColor := clWindow;

  FPropertyValue.FColor := clBtnText;
  FPropertyValue.FBkColor := clWindow;

  FDefaultPropertyValue.FColor := clBtnText;
  FDefaultPropertyValue.FBkColor := clWindow;
  FDefaultPropertyValue.FFontStyles := [fsBold];

  FReadOnlyProperty.FColor := clBtnText;
  FReadOnlyProperty.FBkColor := clWindow;

  FReferenceProperty.FColor := clBlack;
  FReferenceProperty.FBkColor := clWindow;

  FSubProperty.FColor := clBlack;
  FSubProperty.FBkColor := clWindow;

  FGutter.FBkColor := clBtnFace;
  FGutter.FColor := clBlack;

  FLines.FBkColor := clBtnFace;
  FLines.FColor := clBtnShadow;

  with FElTreeOptions do
  begin
    FBarStyle := false;
    HorzDivLinesColor := clBtnFace;
    VertDivLinesColor := clBtnFace;
    DrawFocusRect := true;
    HideSelectColor := clHighlight;
    HideSelectTextColor := clHighlightText;

    FocusedSelectColor := clHighlight;
    FocusedSelectTextColor := clHighlightText;
    BkColor := clWindow;
    ItemIndent := 14;
  end;
end;

procedure TElInspectorStyleNET.DrawGutter(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect);
begin
  ACanvas.Brush.Color := Gutter.BkColor;
  ACanvas.FillRect(Rect(R.Left, R.Top - 1, R.Left + TreeOptions.ItemIndent, R.Bottom + 1));
end;

procedure TElInspectorStyleNET.DrawHorzLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect; const Width: integer);
var
  LSaveColor: TColor;
begin
  if Assigned(Item) and TElInspectorItem(Item).IsCategory and (not Item.Expanded) then
    ACanvas.MoveTo(R.Left, R.Top)
  else
  begin
    LSaveColor := ACanvas.Pen.Color;
    ACanvas.Pen.Color := Lines.Color;
    ACanvas.MoveTo(R.Left + TreeOptions.ItemIndent, R.Top);
    ACanvas.LineTo(R.Left + TreeOptions.ItemIndent + 1, R.Top);
    ACanvas.Pen.Color := LSaveColor;
  end;

  if (Assigned(Item.Parent) and (Item.Parent.GetLastChild = Item) and
     (TElInspectorItem(Item.Parent).IsCategory)){ or (Item.IsLastChild) }then
  begin
    ACanvas.MoveTo(R.Left, R.Top);
    ACanvas.Pen.Color := Lines.Color;
  end;

  ACanvas.LineTo(R.Right, R.Top);
end;

procedure TElInspectorStyleNET.DrawVertLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect);
begin
  if Assigned(Item) and TElInspectorItem(Item).IsCategory and Item.Expanded then
  begin
    ACanvas.Pen.Color := Gutter.BkColor;
    ACanvas.MoveTo(0, R.Top);
    ACanvas.LineTo(TreeOptions.ItemIndent, R.Top);
    ACanvas.Pen.Color := Lines.Color;
  end;

  if TElInspectorItem(Item).IsCategory then
  begin
    if Item.Selected then
      ACanvas.Pen.Color := FElTreeOptions.HideSelectColor
    else
      ACanvas.Pen.Color := Category.BkColor;
  end;
  ACanvas.MoveTo(R.Left, R.Top);
  ACanvas.LineTo(R.Left, R.Bottom);

  if (Assigned(Item) and (not TElInspectorItem(Item).IsCategory)) then
  begin
    ACanvas.Pen.Color := Lines.Color;
    ACanvas.MoveTo(TreeOptions.ItemIndent, R.Top);
    ACanvas.LineTo(TreeOptions.ItemIndent, R.Top + Item.Height);
  end;
end;

{-**********************************************************************
   Class: TElInspectorStyleSidewinder
***********************************************************************-}
constructor TElInspectorStyleSidewinder.Create(AOwner: TComponent);
begin
  inherited;
  FBackground := clWindow;
  FEditBackground := clWindow;
  FEditValue.FColor := clBtnText;

  FCategory.FColor := RGB(128, 0, 64);
  FCategory.FBkColor := RGB(224, 224, 224);
  FCategory.FFontStyles := [fsBold];

  FPropertyName.FColor := clBtnText;
  FPropertyName.FBkColor := clWindow;

  FPropertyValue.FColor := clNavy;
  FPropertyValue.FBkColor := clWindow;

  FDefaultPropertyValue.FColor := clNavy;
  FDefaultPropertyValue.FBkColor := clWindow;
  FDefaultPropertyValue.FFontStyles := [fsBold];

  FReadOnlyProperty.FColor := clNavy;
  FReadOnlyProperty.FBkColor := clWindow;

  FReferenceProperty.FColor := clBtnText;
  FReferenceProperty.FBkColor := clWindow;

  FSubProperty.FColor := clNavy;
  FSubProperty.FBkColor := clWindow;

  FGutter.FBkColor := clCream;
  FGutter.FColor := clBlack;

  FLines.FBkColor := clBtnFace;
  FLines.FColor := clGray;

  with FElTreeOptions do
  begin
    FBarStyle := false;
    HorzDivLinesColor := clGray;
    VertDivLinesColor := clGray;
    DrawFocusRect := False;
    BkColor := clWindow;
    ItemIndent := 11;
    HideSelectColor := Category.BkColor;
    HideSelectTextColor := clBtnText;

    FocusedSelectColor := Category.BkColor;
    FocusedSelectTextColor := HideSelectTextColor;
  end;

  FGutterMarker := TBitmap.Create;
  FGutterMarker.LoadFromResourceName(HInstance, 'ELDBLARROW');
  FGutterMarker.TransparentColor := clWhite;
  FGutterMarker.TransparentMode := tmFixed;
  FGutterMarker.Transparent := True;
end;

destructor TElInspectorStyleSidewinder.Destroy;
begin
  FGutterMarker.Free;
  inherited;
end;

procedure TElInspectorStyleSidewinder.DrawGutter(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect);
var
  LItem: TElTreeItem;
  LIsLast: boolean;
begin
  ACanvas.Brush.Color := Gutter.BkColor;
  ACanvas.FillRect(Rect(R.Left, R.Top - 1, R.Left + (TreeOptions.ItemIndent * (Item.Level + 1)), R.Bottom + 1));

  if Item.Selected and ((not Item.HasChildren) or (Item.Level > 0)) then
  begin
    if Item.HasChildren then
      ACanvas.Draw(R.Left + (TreeOptions.ItemIndent * (Item.Level - 1)), R.Bottom - Item.Height + 4, FGutterMarker)
    else
      ACanvas.Draw(R.Left + (TreeOptions.ItemIndent * Item.Level), R.Bottom - Item.Height + 4, FGutterMarker);
  end;

  LIsLast := true;
  LItem := Item.Parent;
  while LItem <> nil do
  begin
    if not LItem.IsLastChild then
    begin
      LIsLast := false;
      break
    end
    else
      LItem := LItem.Parent;
  end;

  if LIsLast then
  begin
    ACanvas.FillRect(Rect(R.Left, R.Bottom, R.Left + (TreeOptions.ItemIndent * (Item.Level + 1)), Item.Owner.Height));
    ACanvas.MoveTo(R.Left + (TreeOptions.ItemIndent * (Item.Level + 1)), R.Bottom);
    ACanvas.LineTo(R.Left + (TreeOptions.ItemIndent * (Item.Level + 1)), Item.Owner.Height);
  end;
end;

procedure TElInspectorStyleSidewinder.DrawHorzLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect; const Width: integer);
var
  k: integer;
  LV: TElTreeItem;
begin
  if Assigned(Item) then
  begin
    if (Item.IsLastChild) and (not Item.Expanded) then
    begin
      LV := Item.GetNextVisible;
      if Assigned(LV) then
      begin
        ACanvas.MoveTo(TreeOptions.ItemIndent * (LV.Level + 1) + 2, R.Top);
        ACanvas.LineTo(R.Left + TreeOptions.ItemIndent * (Item.Level + 1) - 1, R.Top);
        ACanvas.Pixels[TreeOptions.ItemIndent * (LV.Level + 1) + 1, R.Top + 1] := Lines.Color;
        ACanvas.Pixels[TreeOptions.ItemIndent * (LV.Level + 1), R.Top + 1] := Gutter.BkColor;
      end;
    end;

    if (Item.Expanded) then
    begin
      ACanvas.Pen.Color := Lines.Color;
      ACanvas.MoveTo((TreeOptions.ItemIndent * (Item.Level + 1)) + 2, R.Top);
      ACanvas.LineTo((TreeOptions.ItemIndent * (Item.Level + 2)) - 1, R.Top);
      ACanvas.Pixels[(TreeOptions.ItemIndent * (Item.Level + 1)) + 1, R.Top - 1] := Lines.Color;
      ACanvas.Pixels[(TreeOptions.ItemIndent * (Item.Level + 1)), R.Top - 1] := Gutter.BkColor;
    end
    else
    begin
      ACanvas.Pen.Color := Category.BkColor;
      ACanvas.MoveTo(R.Left + TreeOptions.ItemIndent * (Item.Level + 1) + 1, R.Top);
      ACanvas.LineTo(R.Right, R.Top);
      ACanvas.Pen.Color := Lines.Color;
    end;

    if Item.Expanded then
      k := R.Left + TreeOptions.ItemIndent * (Item.Level + 2) + 1
    else
      k := R.Left + TreeOptions.ItemIndent * (Item.Level + 1) + 1;
    While (k <= R.Right) do
    begin
      ACanvas.MoveTo(k, R.Top);
      if (not (k in [Width - 1, Width])) or (TElInspectorItem(Item).IsCategory) then
        ACanvas.LineTo(k + 1, R.Top);
      Inc(k, 2);
    end;
  end;
end;

procedure TElInspectorStyleSidewinder.DrawVertLine(ACanvas: TCanvas; Item: TElTreeItem; R: TRect);
begin
  if Assigned(Item) then
  begin

    if TElInspectorItem(Item).IsCategory then
    begin
      if Item.Selected then
        ACanvas.Pen.Color := FElTreeOptions.HideSelectColor
      else
        ACanvas.Pen.Color := Category.BkColor;
    end;

    ACanvas.MoveTo(R.Left, R.Top);
    ACanvas.LineTo(R.Left, R.Bottom);

    if Assigned(Item) then
    begin
      ACanvas.Pen.Color := Lines.Color;
      if Item.IsFirstChild then
      begin
        if Item.GetPrevVisible <> nil then
          ACanvas.Pixels[TreeOptions.ItemIndent * (Item.Level + 1) - 1, R.Top] := Lines.Color;
        ACanvas.MoveTo(TreeOptions.ItemIndent * (Item.Level + 1), R.Top + 1);
      end
      else
        ACanvas.MoveTo(TreeOptions.ItemIndent * (Item.Level + 1), R.Top);

      if Item.IsLastChild then
      begin
        ACanvas.LineTo(TreeOptions.ItemIndent * (Item.Level + 1), R.Top + Item.Height - 2);
        if (Item.Level > 0) and (Item.GetNextVisible <> nil) then
          if (not Item.Expanded) then
            ACanvas.Pixels[TreeOptions.ItemIndent * (Item.Level + 1) - 1, R.Top + Item.Height - 2] := Lines.Color
          else
            ACanvas.Pixels[TreeOptions.ItemIndent * (Item.Level + 1) + 1, R.Top + Item.Height - 2] := Lines.Color
      end
      else
        ACanvas.LineTo(TreeOptions.ItemIndent * (Item.Level + 1), R.Top + Item.Height);

    end;
  end;
end;

const
  TrueBoolStrs: array[0..0] of String = ('True');
  FalseBoolStrs: array[0..0] of String = ('False');

function TryStrToBool(const S: string; out Value: Boolean): Boolean;

  function CompareWith(const aArray: array of string): Boolean;
  var
    I: Integer;
  begin
    Result := False;
    for I := Low(aArray) to High(aArray) do
      if AnsiSameText(S, aArray[I]) then
        begin
          Result := True;
          Break;
        end;
  end;

var
  LResult: Extended;

begin
  try
    LResult := StrToFloat(S);
    result:=LResult<>0;
  except
    On Exception do
      begin
        Result := CompareWith(TrueBoolStrs);
        if Result then
          Value := True
        else
          begin
            Result := CompareWith(FalseBoolStrs);
            if Result then
              Value := False;
          end;
      end;
  end;
end;

function BoolToStr(B: Boolean; UseBoolStrs: Boolean = False): string;
const
  cSimpleBoolStrs: array [boolean] of String = ('0', '-1');
begin
  if UseBoolStrs then
    begin
      if B then
        Result := TrueBoolStrs[0]
      else
        Result := FalseBoolStrs[0];
    end
  else
    Result := cSimpleBoolStrs[B];
end;

{ TElInspectorDataLink }

constructor TElInspectorDataLink.Create(AInspector: TCustomElInspector);
begin
  inherited Create;
  FInspector := AInspector;
end;

destructor TElInspectorDataLink.Destroy;
begin
  if Assigned(InspectorDataSource) then
    InspectorDataSource.UnregisterDataLink(Self);
  inherited Destroy;
end;

procedure TElInspectorDataLink.NotifyInspector(Action: TElInspectorAction);
begin
  case Action of
    iRebuildInspector:
      if not FInspector.IsUpdating then
        FInspector.Rebuild(nil);
  end;
end;

procedure TElInspectorDataLink.SetInspectorDataSource(Value: TElInspectorDataSource);
begin
  if (FInspectorDataSource <> Value) then
  begin
    if Assigned(FInspectorDataSource) then
      FInspectorDataSource.UnregisterDataLink(Self);
    if Assigned(Value) then
      Value.RegisterDataLink(Self);
  end;
end;

{ TElInspectorDataSource }

procedure TElInspectorDataSource.NotifyInspectors(Action: TElInspectorAction);
var
  i: Integer;
begin
  for i := 0 to FInspectors.Count - 1 do
    TElInspectorDataLink(FInspectors[i]).NotifyInspector(Action);
end;

constructor TElInspectorDataSource.Create(AOwner: TComponent);
begin
  inherited;
  FInspectors := TLMDObjectList.Create;
end;

destructor TElInspectorDataSource.Destroy;
begin
  while FInspectors.Count > 0 do
    UnRegisterDataLink(TElInspectorDataLink(FInspectors.Last));
  FInspectors.Free;
  FInspectors := nil;
  inherited;
end;

procedure TElInspectorDataSource.RegisterDataLink(
  Value: TElInspectorDataLink);
begin
  Value.FInspectorDataSource := Self;
  if Assigned(FInspectors) then
    FInspectors.Add(Value);
end;

procedure TElInspectorDataSource.UnregisterDataLink(
  Value: TElInspectorDataLink);
begin
  if Assigned(FInspectors) then
  begin
    Value.FInspectorDataSource := nil;
    FInspectors.Remove(Value);
    Value.NotifyInspector(iRebuildInspector);
  end;
end;

{ TElInspectorItem }

destructor TElInspectorItem.Destroy;
begin
  FInspectorData.Free;
  inherited;
end;

end.
