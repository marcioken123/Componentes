unit ElTree;
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

ElTree unit
-----------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}
{$B-}

{$ALIGN ON}

interface

uses
  SysUtils,
  Classes,
  Controls,
  Messages,
  Windows,
  Graphics,
  Forms,
  StdCtrls,
  ExtCtrls,
  CommCtrl,
  Types,
  ImgList,
  Buttons,
  Menus,
  Math,
  UxTheme, Themes,
  Imm,
  Variants,
  ActiveX,

  LMDTypes,
  LMDElConst,
  LMDSysIn,
  LMDProcs,
  LMDUtils,
  LMDStrings,
  LMDDebugUnit,
  LMDFiles,
  LMDThemes,
  LMDClass,
  LMDObjectList,
{$ifdef LMD_UNICODE}
  LMDUnicodeStrings,
  LMDUnicode,
{$endif}
  LMDGlyphs,
  LMDArray,
  LMDHTMLUnit,
  LMDGraph,

  ElStyleMan,
  ElComponent,
  ElHook,
  ElXPThemedControl,
  ElHeader,
  ElSBCtrl,
  ElScrollBar,
  ElHintWnd,
  ElInputProcessor,
  ElIni,
  ElTreeInplaceEditors,
  ElImgFrm,
  ElDragDrop,
  ElVCLUtils;

type
  {$EXTERNALSYM TElHeaderSection}
  TElHeaderSection = ElHeader.TElHeaderSection;
  {$EXTERNALSYM TCustomElHeader}
  TCustomElHeader = ElHeader.TCustomElHeader;
  {$EXTERNALSYM TElFieldType}
  TElFieldType = ElHeader.TElFieldType;
  {$EXTERNALSYM TElFieldTypes}
  TElFieldTypes = ElHeader.TElFieldTypes;
  {$EXTERNALSYM TElScrollBarPart}
  TElScrollBarPart = ElSBCtrl.TElScrollBarPart;

  {$EXTERNALSYM TDragType}
  TDragType = ElDragDrop.TDragType;
  {$EXTERNALSYM IDataObject}
  IDataObject = ActiveX.IDataObject;
  {$EXTERNALSYM IDropSource}
  IDropSource = ActiveX.IDropSource;
  {$EXTERNALSYM TDragTypes}
  TDragTypes = ElDragDrop.TDragTypes;
  {$EXTERNALSYM TOleDragObject}
  TOleDragObject = ElDragDrop.TOleDragObject;

const
  DefaultTextFlags = DT_NOPREFIX or DT_SINGLELINE or DT_VCENTER or DT_LEFT or DT_END_ELLIPSIS;
  TM_CLOSEINPLACEEDITOR = WM_USER + 2835;

  //stsFocused = 1; // TElTreeItem states
  //stsSelected = 2;
  stsExpanded = 7;
  stsCut = 3;
  stsUnderlined = 4;
  stsBold = 5;
  stsItalic = 6;
  stsStrikeOut = 8;
  stiMaxState = 8;
type
  TSTIStates = set of 1..stiMaxState;

const
  //tisFocused    = 1;
  //tisSelected   = 2;
  tisExpanded   = 8;
  tisCut        = 4;
  tisBold       = 16;
  tisItalic     = 32;
  tisUnderlined = 64;
  tisStrikeout  = 128;

  ibfParentColors   = $0000001;
  ibfParentStyle    = $0000002;
  ibfSuppressLines  = $0000004;
  ibfForceButtons   = $0000020;
  ibfStrikedOutLine = $0000040;
  ibfDrawHLine      = $0000080;
  ibfWholeLine      = $0000100;
  ibfAllowEdit      = $0000200;
  ibfUseBkColor     = $0000400;
  ibfUseStyles      = $0001000;
  ibfSuppressButtons= $0010000;
  ibfCheckBoxEnabled= $0020000;
  ibfShowCheckBox   = $0040000;
  ibfHintIsHTML     = $0400000;
  ibfWordWrap       = $4000000;

  ibfImageDrawn     = $0000008;
  ibfImageDrawn2    = $0000010;
  ibfDeleting       = $0000800;
  ibfMultiline      = $0002000;
  ibfHidden         = $0004000;
  ibfEnabled        = $0008000;
  ibfIsHTML         = $0080000;
  ibfOwnerHeight    = $0100000;
  ibfRec            = $0200000;
  ibfSelected       = $0800000;
  ibfFocused        = $1000000;
  ibfExpanded       = $2000000;

type
  TCustomElTree = class;
  TElTreeItem = class;
  TElTreeItems = class;
  TElCellStyle = class;
  TElTreeView = class;

  TInplaceEditorNeededEvent   = procedure (Sender: TObject; Item: TElTreeItem; SectionIndex: Integer; SupposedFieldType: TElFieldType; var Editor: TElTreeInplaceEditor) of object;

//{$warnings off}
{$warnings off}
  TElCellControl = class(TElComponent)
  private
    FPopupMenu: TPopupMenu;
    FOwner: TElCellStyle;
    FCaption: TLMDString;
       //FBoundsRect : TRect;
    FVisible: Boolean;
    FEnabled: boolean;

    FOnClick: TNotifyEvent;
    FOnMouseDown: TMouseEvent;
    FOnMouseUp: TMouseEvent;
    FOnDblClick: TNotifyEvent;
    FOnMouseMove: TMouseMoveEvent;
    FFont: TFont;

    procedure SetPopupMenu(newValue: TPopupMenu);
    procedure FontChanged(Sender: TObject);
    procedure SetFont(newValue: TFont);
  protected
       //procedure SetBoundsRect(newValue : TRect); virtual;
    FBorderWidth: Integer;
    procedure SetCaption(newValue: TLMDString); virtual;
    procedure SetVisible(newValue: Boolean); virtual;
    procedure SetEnabled(newValue: Boolean); virtual;

    procedure TriggerClickEvent; virtual;
    procedure TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure TriggerDblClickEvent; virtual;
    procedure TriggerMouseMoveEvent(Shift: TShiftState; X, Y: Integer); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetBorderWidth(Value: Integer);
    function PassClicks: Boolean; virtual;
  public
    procedure Update; virtual;
    procedure Assign(Source: TElCellControl); virtual;
    procedure Paint(Tree : TCustomElTree; Item : TElTreeItem; Canvas: TCanvas;
        Rect: TRect); virtual; abstract;
    constructor Create; virtual;
    destructor Destroy; override;
//    property BorderWidth: Integer read FBorderWidth write SetBorderWidth;
//    property Font: TFont read FFont write SetFont;
  published
    property Caption: TLMDString read FCaption write SetCaption;
    property Owner : TElCellStyle read FOwner;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Visible: Boolean read FVisible write SetVisible default True;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth;
    property Font: TFont read FFont write SetFont;
  end;
{$warnings on}

  TElCellCheckBox = class (TElCellControl)
  private
    FAlignment : TAlignment;
    FState     : TCheckBoxState;
    FAllowGrayed : boolean;
    procedure SetState(newValue : TCheckBoxState);
    procedure SetAllowGrayed(newValue : Boolean);
    function GetChecked : Boolean;
    procedure SetChecked(newValue : Boolean);
    procedure SetAlignment(newValue : TAlignment);
  protected
    procedure TriggerClickEvent; override;
    procedure TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    procedure Assign(Source: TElCellControl); override;
    constructor Create; override;
    destructor Destroy; override;
    procedure Paint(Tree : TCustomElTree; Item : TElTreeItem; Canvas: TCanvas; R:
        TRect); override;

  published
    property State : TCheckBoxState read FState write SetState;
    property Checked : boolean read GetChecked write SetChecked;
    property AllowGrayed : Boolean read FAllowGrayed write SetAllowGrayed; { Published }
    property Alignment : TAlignment read FAlignment write SetAlignment default taRightJustify; { Protected }
  end;

  TElCellButtonGlyph = class(TLMDButtonGlyph)
    property ImageList;
    property ImageIndex;
    property UseImageList;
  end;

  TElCellButton = class(TElCellControl)
  private
    FGlyph: TElCellButtonGlyph;
    FLayout: TButtonLayout;
    FFixClick: Boolean;
    FDown: Boolean;
    function GetGlyph: TBitmap;
    procedure SetGlyph(newValue: TBitmap);
    procedure GlyphChanged(Sender: TObject);
    procedure SetDown(newValue: Boolean);
    procedure SetLayout(newValue: TButtonLayout);
    function GetUseImageList : Boolean;
    procedure SetUseImageList(newValue : Boolean);
    function GetImageList : TCustomImageList;
    procedure SetImageList(newValue : TCustomImageList);
    function GetImageIndex : Integer;
    procedure SetImageIndex(newValue : Integer);
  protected
    procedure TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    procedure Assign(Source: TElCellControl); override;
    constructor Create; override;
    destructor Destroy; override;
    procedure Paint(Tree : TCustomElTree; Item : TElTreeItem; Canvas: TCanvas; R:
        TRect); override;

  published
    property UseImageList : Boolean read GetUseImageList write SetUseImageList;  { Public }
    property ImageList : TCustomImageList read GetImageList write SetImageList;  { Public }
    property ImageIndex : Integer read GetImageIndex write SetImageIndex;  { Public }

    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property FixClick: Boolean read FFixClick write FFixClick;
    property Down: Boolean read FDown write SetDown default False;
    property Layout: TButtonLayout read FLayout write SetLayout default blGlyphLeft;
  end;

  TElCellProgressBar = class(TElCellControl)
  private
  protected
    FMinValue: Integer;
    FMaxValue: Integer;
    FValue: Integer;
    FBarColor: TColor;
    FShowProgressText: Boolean;
    FTextAlignment: TAlignment;
    FFrameColor: TColor;
    FColor: TColor;
    procedure SetMinValue(Value: Integer);
    procedure SetMaxValue(Value: Integer);
    procedure SetValue(Value: Integer);
    procedure SetBarColor(Value: TColor);
    procedure SetShowProgressText(Value: Boolean);
    procedure SetTextAlignment(Value: TAlignment);
    procedure SetFrameColor(Value: TColor);
    procedure SetColor(Value: TColor);
    function PassClicks: Boolean; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Assign(Source: TElCellControl); override;
    procedure Paint(Tree : TCustomElTree; Item : TElTreeItem; Canvas: TCanvas; R:
        TRect); override;

  published
    property MinValue: Integer read FMinValue write SetMinValue;
    property MaxValue: Integer read FMaxValue write SetMaxValue default 100;
    property Value: Integer read FValue write SetValue;
    property BarColor: TColor read FBarColor write SetBarColor default clHighlight;
    property TextAlignment: TAlignment read FTextAlignment write SetTextAlignment default taCenter;
    property ShowProgressText: Boolean read FShowProgressText write SetShowProgressText default true;
    property FrameColor: TColor read FFrameColor write SetFrameColor default clWindowText;
    property Color: TColor read FColor write SetColor default clWindow;
  end;

  TElCellStyle = class(TPersistent)
  private
    FTag: Integer;
    FOwner: TElTreeItem;
    FCellBkColor: TColor;
    FTextBkColor: TColor;
    FTextColor: TColor;
    FTextFlags: DWORD;
    FPicture: TBitmap;
    FCellType: TElFieldType;
    FStyle: TElSectionStyle;
    FOwnerProps: Boolean;
    FFontSize: integer;
    FFontStyles: TFontStyles;
    FFontName: TFontName;
    FControl: TElCellControl;
    FUseBkColor: Boolean;
    FBorderStyle: TElItemBorderStyle;
    procedure SetControl(newValue: TElCellControl);
    procedure SetFontSize(newValue: integer);
    procedure SetFontStyles(newValue: TFontStyles);
    procedure SetFontName(newValue: TFontName);
    procedure SetOwnerColors(newValue: Boolean);
    procedure SetStyle(newValue: TElSectionStyle);
    procedure SetCellBkColor(newValue: TColor);
    procedure SetTextBkColor(newValue: TColor);
    procedure SetTextColor(newValue: TColor);
    procedure SetTextFlags(newValue: DWORD);
    procedure SetPicture(newValue: TBitmap);
    procedure SetUseBkColor(Value: Boolean);
    procedure SetBorderStyle(Value: TElItemBorderStyle);
  protected
  public
    constructor Create(Owner: TElTreeItem);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent);override;
    procedure Update;
    property Owner   : TElTreeItem read FOwner;
  published
    property Tag: Integer read FTag write FTag default 0;
    property Control: TElCellControl read FControl write SetControl; { Published }
    property CellBkColor: TColor read FCellBkColor write SetCellBkColor default clNone;
    property TextBkColor: TColor read FTextBkColor write SetTextBkColor default clNone;
    property TextColor: TColor read FTextColor write SetTextColor default clWindowText;
    property TextFlags: DWORD read FTextFlags write SetTextFlags default DefaultTextFlags;
    property Picture: TBitmap read FPicture write SetPicture;
    property CellType: TElFieldType read FCellType write FCellType default sftText;
    property Style: TElSectionStyle read FStyle write SetStyle default elhsText;
    property OwnerProps: Boolean read FOwnerProps write SetOwnerColors default false;
    property FontSize: integer read FFontSize write SetFontSize;
    property FontStyles: TFontStyles read FFontStyles write SetFontStyles;
    property FontName: TFontName read FFontName write SetFontName;
    property UseBkColor: Boolean read FUseBkColor write SetUseBkColor default false;
    property BorderStyle: TElItemBorderStyle read FBorderStyle write SetBorderStyle default ibsNone;
  end;

  TElTreeItemStaticData = record
    FText    : TLMDString;
    FColText : TLMDMemoryStrings;
    FHint    : TLMDString;
    FMainStyle: TElCellStyle;
    FStyles  : TLMDObjectList;
  end;
  PElTreeItemStaticData = ^TElTreeItemStaticData;

  TElTreeItemStaticDataEx = class
  private
    // FStaticData : PElTreeItemStaticData;
    ItemRef     : TElTreeItem;
    FState      : TSTIStates;
    //IState      : integer;
  protected
    FBoolData1  : integer;
    FBkColor: TColor;
    FStrikedLineColor: TColor;
    FBorderSpaceColor: TColor;
    FIndentAdjust: Integer;
    FBorderStyle: TElItemBorderStyle;
    FColor: TColor;
    FCheckBoxType: TElCheckBoxType;
    FCheckBoxState: TCheckBoxState;
    FRowBkColor: TColor;
    FImageIndex   : Integer;
    FStImageIndex : Integer;
    FImageIndex2  : Integer;
    FStImageIndex2: Integer;
    FOverlayIndex : Integer;
    FOverlayIndex2: Integer;

    function GetImage(Index : integer): Integer;
    procedure SetImage(Index : integer; Value : integer);
    function GetBoolFlag(Index : integer): Boolean;
    function GetState(Index : integer): Boolean;
    procedure SetBoolFlag(Index : integer; Value : boolean);
    procedure SetState(Index : integer; Value : boolean);
    procedure Assign(Source : TElTreeItemStaticDataEx);
  public
    property StrikedLineColor: TColor read FStrikedLineColor write
        FStrikedLineColor;
    property BkColor: TColor read FBkColor write FBkColor;
    property BorderSpaceColor: TColor read FBorderSpaceColor write
        FBorderSpaceColor;
    property CheckBoxState: TCheckBoxState read FCheckBoxState write FCheckBoxState;
    property CheckBoxType: TElCheckBoxType read FCheckBoxType write FCheckBoxType;
    property Color: TColor read FColor write FColor;
    property BorderStyle: TElItemBorderStyle read FBorderStyle write FBorderStyle;
    property ImageIndex: Integer index 0 read GetImage write SetImage;
    property ImageIndex2: Integer index 1 read GetImage write SetImage;
    property IndentAdjust: Integer read FIndentAdjust write FIndentAdjust;
    property OverlayIndex: Integer index 4 read GetImage write SetImage;
    property OverlayIndex2: Integer index 5 read GetImage write SetImage;
    property RowBkColor: TColor read FRowBkColor write FRowBkColor;
    property StImageIndex: Integer index 2 read GetImage write SetImage;
    property StImageIndex2: Integer index 3 read GetImage write SetImage;
    property Cut: Boolean index 3 read GetState write SetState;
    property Bold: Boolean index 5 read GetState write SetState;
    property Underlined: Boolean index 4 read GetState write SetState;
    property Italic: Boolean index 6 read GetState write SetState;
    property Strikeout: Boolean index 8 read GetState write SetState;
    property ParentColors: Boolean index 1 read GetBoolFlag write SetBoolFlag;
    property ParentFontStyle: Boolean index 2 read GetBoolFlag write SetBoolFlag;
    property SuppressLines: Boolean index 3 read GetBoolFlag write SetBoolFlag;
    property ForceButtons: Boolean index 6 read GetBoolFlag write SetBoolFlag;
    property StrikedOutLine: Boolean index 7 read GetBoolFlag write SetBoolFlag;
    property DrawHLine: Boolean index 8 read GetBoolFlag write SetBoolFlag;
    // property AllowSelection: Boolean index 9 read GetBoolFlag write SetBoolFlag;
    property AllowEdit: Boolean index 10 read GetBoolFlag write SetBoolFlag;
    property UseBkColor: Boolean index 11 read GetBoolFlag write SetBoolFlag;
    property UseStyles: Boolean index 13 read GetBoolFlag write SetBoolFlag;
    property Enabled: Boolean index 16 read GetBoolFlag write SetBoolFlag;
    property SuppressButtons: Boolean index 17 read GetBoolFlag write SetBoolFlag;
    property CheckBoxEnabled: Boolean index 18 read GetBoolFlag write SetBoolFlag;
    property ShowCheckBox: Boolean index 19 read GetBoolFlag write SetBoolFlag;
    property HintIsHTML: Boolean index 23 read GetBoolFlag write SetBoolFlag;
  end;
  // PElTreeItemStaticDataEx = ^TElTreeItemStaticDataEx;

  TElTreeItem = class(TPersistent)
  private // iterate methods
    procedure IterateProc(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);
    procedure InvalidateItemPart(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);
  protected

    FHTMLData      : TLMDHTMLData;
    FHTMLDataArray : TLMDArray;

    FData          : TLMDDataTag; // generic data
    FTag           : Integer;
    FObject        : TObject;
    FDataInterface : IUnknown;
{$IFDEF USE_VARIANT}
    FSortData      : Variant;
{$ELSE}
    FSortData      : TLMDDataTag;
    FSortType      : integer;
{$ENDIF}
    FSortRef       : integer;

    FStaticData    : PElTreeItemStaticData;
    FStaticDataEx  : TElTreeItemStaticDataEx;

    FComplexHeight : Cardinal;

    FTextRect   : TRect;

    FChildren: TLMDObjectList;
    FOwner: TCustomElTree;
    FList : TElTreeItems;

    FBoolData : integer;

    FParent: TElTreeItem;
    FRoot  : TElTreeItem;

    function GetText: TLMDString;
    function GetHint: TLMDString; virtual;
    procedure SetHint(Value: TLMDString);
    procedure SetBorderStyle(Value: TElItemBorderStyle);
    function GetParent: TElTreeItem;
    function GetLevel: integer;
    procedure SetColor(Index: Integer; value: TColor);
    procedure SetUseBkColor(newValue: Boolean);
    function GetHasChildren: boolean;
    function GetHasVisibleChildren: Boolean;
    procedure SetExpanded(value: boolean);
    procedure SetParentColors(value: Boolean);
    procedure SetParentStyle(value: Boolean);
    function GetIndex: Integer;
    function GetAbsIndex: integer;
    function GetVisIndex: integer;
    function GetChildIndex(Child: TElTreeItem): integer;
    function IsExpanded: boolean;
    function GetFullExpand: boolean;
    procedure MakeFullyExpanded(value: boolean);
    procedure OnColTextChange(Sender: TObject);
    procedure SetImageIndex(Index: Integer; value: Integer);
    procedure SetForceButtons(newValue: Boolean);
    function GetChildrenCount: Integer;
    function GetCount: Integer;
    function GetItems(Index: integer): TElTreeItem;
    procedure SetUseStyles(newValue: Boolean);
    procedure OnStyleDelete(Sender: TObject; var Item:TLMDDataTag);
    function GetStyles(index: integer): TElCellStyle;
    procedure SetStyles(index: integer; newValue: TElCellStyle);
    function GetStylesCount: Integer;
    procedure SetCheckBoxState(newValue: TCheckBoxState);
    procedure SetChecked(newValue: Boolean);
    function GetChecked: boolean;
    procedure SetShowCheckBox(newValue: Boolean);
    procedure SetCheckBoxType(newValue: TElCheckBoxType);
    procedure SetCheckBoxEnabled(newValue: Boolean);
    procedure SetSuppressButtons(newValue: Boolean);
    procedure SetEnabled(newValue: Boolean);
    procedure SetHidden(newValue: Boolean);
    function GetFullyVisible: Boolean;
    procedure SetFullyVisible(newValue: Boolean);
    function GetSelected : boolean;
    procedure SetSelected(newValue : boolean);
    procedure CreateStyles;

    procedure SetOwnerHeight(newValue : Boolean);
    procedure SetHeight(newValue : Integer);

    function  GetHeight : Integer;
    procedure SetSuppressLines(newValue: Boolean);
    procedure UpdateItem;
    procedure SetText(Value: TLMDString); virtual;
    function GetState(index: integer): boolean;
    procedure SetState(index: integer; value: boolean);
    procedure RemoveChild(Child: TElTreeItem);
    procedure RemoveSubChild(Child: TElTreeItem);
    procedure DeleteChild(Child: TElTreeItem);
    function  AddChild(Child: TElTreeItem): integer;
    procedure  AddExistingChild(Child: TElTreeItem);
    function  AddLastChild(Child: TElTreeItem): integer;
    function InsertChild(index: integer; Child: TElTreeItem): integer;
    procedure ExchangeItems(I, J: integer);

    // Sorting-related methods
    procedure QuickSort(recursive: boolean;
                        L, R: Integer;
                        SM : TElSSortMode;
                        SortType: TSortTypes;
                        FSortSection : integer);
    procedure AddSortData(SortType: TSortTypes;
                          FSortSection : integer);
    procedure ReleaseSortData;
    procedure NormalizeSorts(StartIdx : integer);

    function  GetOwnerHeight : boolean;
    procedure SetMultiline(newValue: Boolean); virtual;
    procedure SetIsHTML(newValue: Boolean);
    procedure OnHTMLDataDestroy(Sender :TObject; Item : TLMDDataTag);

    function GetAncestor: TElTreeItem;

    procedure SetStrikedOutLine(const Value: boolean);
    function GetStrikedOutLine: boolean;
    procedure SetDrawHLine(const Value: Boolean);

    procedure SetAllowEdit(const Value: Boolean);
    function CalcSubItemsHeight: Integer;
    procedure NewStaticData;
    procedure DisposeStaticData;
    procedure FillStaticData;
    function GetColText: TLMDStrings;
    function GetParentStyle: Boolean;

    function GetMainStyle: TElCellStyle;
    function GetUseStyles: Boolean;
    function GetUseBkColor: Boolean;
    function GetParentColors: Boolean;
    function GetDrawHLine: Boolean;
    (*
    function GetAllowSelection: Boolean;
    procedure SetAllowSelection(Value: Boolean);
    *)
    function GetAllowEdit: Boolean;
    function GetForceButtons: Boolean;
    function GetSuppressButtons: Boolean;
    function GetSuppressLines: Boolean;
    function GetIsHTML: Boolean;
    function GetMultiline: Boolean;
    function GetShowCheckBox: Boolean;
    function GetCheckBoxEnabled: Boolean;
    function GetEnabled: Boolean;
    function GetHidden: Boolean;
    procedure SetIndentAdjust(Value: Integer);
    function GetDropTarget: Boolean;
    function GetHintIsHTML: Boolean;
    procedure SetHintIsHTML(Value: Boolean);
    procedure ClearSubChild;
    function GetTextDim(Index : integer): Integer;
    procedure SetIndex(Value: Integer);
    procedure NewStaticDataEx;
    procedure DisposeStaticDataEx;
    function GetColor(Index: Integer): TColor;
    function GetImageIndex(Index: Integer): Integer;
    function GetCheckBoxState: TCheckBoxState;
    function GetCheckBoxType: TElCheckBoxType;
    function GetIndentAdjust: Integer;
    function GetBorderStyle: TElItemBorderStyle;
    function GetFocused: Boolean;
    procedure SetFocused(Value: Boolean);
    procedure UpdateChangedMainText;
    procedure UpdateChangedCellText;
    procedure NewVirtualSort;
    procedure SetWordWrap(Value: Boolean);
    function GetWordWrap: Boolean;
    function GetWholeLine: Boolean;
    procedure SetWholeLine(Value: Boolean);
  public
    constructor Create(AOwner: TCustomElTree); virtual;
    destructor Destroy; override;
    procedure ReRenderMainText;virtual;
    procedure ReRenderAllTexts;virtual;
    function GetWidth: Integer; virtual;
    procedure ReadData(Stream: TStream); virtual;
    procedure WriteData(Stream: TStream); virtual;

    function IsUnder(Item: TElTreeItem): boolean;
    function GetFullName(separator: TLMDString): TLMDString;
    function GetFullNameEx(separator: TLMDString; AddRoot: boolean): TLMDString;
    procedure Expand(recursive: boolean);
    procedure Collapse(recursive: boolean);
    procedure Sort(recursive: boolean);
    procedure MoveTo(NewParent: TElTreeItem);
       // Moves the item to the new parent, adding it to the NewParent's
       // children list.
    procedure MoveToIns(NewParent: TElTreeItem; AnIndex: integer);
       // Moves the item to the new parent, inserting it to the NewParent's
       // children list at Index position

    procedure Clear;
    function GetFirstVisibleChild: TElTreeItem;
    function GetFirstChild: TElTreeItem;
    function GetLastChild: TElTreeItem;
    function GetNextChild(Child: TElTreeItem): TElTreeItem;
    function GetPrevChild(Child: TElTreeItem): TElTreeItem;
    function GetFirstSibling: TElTreeItem;
    function GetLastSibling: TElTreeItem;
    function GetNextSibling: TElTreeItem;
    function GetPrevSibling: TElTreeItem;
    function GetLastSubItem : TElTreeItem;
      // Get the last item, that has current item as one of its "parents"
    function GetChildByIndex(index: integer): TElTreeItem;
       // Get child item, which is on "index" position in the children list

    procedure EditText;

    procedure Assign(Source: TPersistent); override;
    procedure Delete; virtual;
    property TreeView: TCustomElTree read FOwner;
    function IsVisible: Boolean;
    function GetNextVisible: TElTreeItem;
    function GetPrevVisible: TElTreeItem;
    function GetPrev: TElTreeItem; virtual;
    function GetNext: TElTreeItem; virtual;
    procedure MoveToItem(Item: TElTreeItem; Mode: TNodeAttachMode); virtual;
    function AddStyle: TElCellStyle; virtual;
    procedure RemoveStyle(Style: TElCellStyle); virtual;
    procedure RedrawItem(DoCheck: boolean);
    procedure RedrawItemPart(DoCheck: boolean; Left, Right: integer);
    function DisplayRect(TextOnly : boolean): TRect;

    procedure EndEdit(ByCancel : boolean);

    procedure RecalcHeight;
    function HasAsParent(Item : TElTreeItem): Boolean;
    function IndexOf(Item : TElTreeItem): Integer;
    procedure MakeVisible;
    procedure UpdateInfo(PropTypes : TElVirtPropTypes);
    procedure AllocateStorage(MaxItems : integer); virtual;
    function IsFirstChild: Boolean;
    function IsLastChild: Boolean;

    property TextLeft: Integer index 0 read GetTextDim;
    property TextRight: Integer index 2 read GetTextDim;
    property Data: TLMDDataTag read FData write FData;
       // User defined data. The ElTree doesn't free this memory when
       // the item is deleted
    property DataInterface: IUnknown  read FDataInterface write FDataInterface;
    // User defined interface. Will be set to NIL before destruction to
    // decrease the reference counter.
    property Owner: TCustomElTree read FOwner;
       // Points to the item's owner ElTree component
    property Parent: TElTreeItem read GetParent write MoveTo;
       // Points to the item's parent item
    property HasVisibleChildren: boolean read GetHasVisibleChildren;
       // Shows, if the item has child items, that are not hidden
    property HasChildren: boolean read GetHasChildren;
       // Shows, if the item has child items
    property Index: Integer read GetIndex write SetIndex;
       // This is the index of the item in the parent's children list
    property AbsoluteIndex: integer read GetAbsIndex;
       // This is the index of the item among all items in the tree
    property VisIndex: integer read GetVisIndex;
       // This is the index of the item among all expanded items in the tree
    property Count: Integer read GetCount;
      // This is the number of elements in Children array. Direct children only!!!
    property ChildrenCount: integer read GetChildrenCount;
      // This is the number of children on all levels below this item.
    property Children[Index: integer]: TElTreeItem read GetItems; { Public }
      // The array of children elements. Direct children only!!!
      // To find out all subitems, use Iterate* methods
    property Item[Index: integer]: TElTreeItem read GetItems; { Public }
      // the same but for TTreeView compatibility
    property Level: integer read GetLevel;
       // Tells, on which level the item is
       // Root items have Level 0 (zero)
    property Styles[index: integer]: TElCellStyle read GetStyles write SetStyles;
    property Ancestor: TElTreeItem read GetAncestor;
    // property AllowSelection: Boolean read GetAllowSelection write SetAllowSelection;
    property Selected: boolean read GetSelected write SetSelected;
       // The item is marked as selected
    property SubItems  : TLMDStrings read GetColText;
       // Text for additional columns
    property DropTarget: Boolean read GetDropTarget;
    property TextRect: TRect read FTextRect write FTextRect;
  published
    property AnObject: TObject read FObject write FObject stored False;
       // User defined data. The ElTree doesn't free this memory when
       // the item is deleted
    property Tag : Integer read FTag write FTag;
    property Focused: Boolean read GetFocused write SetFocused stored false;
       // The item currently has focus
    property Expanded: boolean read IsExpanded write SetExpanded;
       // The item is expanded
    property FullyExpanded: boolean read GetFullExpand write MakeFullyExpanded;
       // The item and all its parent are expanded
    property WholeLine: Boolean read GetWholeLine write SetWholeLine default false;
    property StrikedOutLine: boolean read GetStrikedOutLine write SetStrikedOutLine;
    property StrikedLineColor: TColor index 5 read GetColor write SetColor;
    property DrawHLine: Boolean read GetDrawHLine write SetDrawHLine;
    property AllowEdit: Boolean read GetAllowEdit write SetAllowEdit;
    property Cut: boolean index 3 read GetState write SetState;
       // The item is marked as cut
    property Underlined: boolean index 4 read GetState write SetState;
       // This property sets the item's main text font style
       // This doesn't affect columns text style
    property Bold: boolean index 5 read GetState write SetState;
       // This property sets the item's main text font style
       // This doesn't affect columns text style
    property Italic: boolean index 6 read GetState write SetState;
       // This property sets the item's main text font style
       // This doesn't affect columns text style
    property StrikeOut: boolean index 8 read GetState write SetState;
       // This property sets the item's main text font style
       // This doesn't affect columns text style
       // if ParentFontStyle=true, then item's font styles are ignored, and tree's
       // are used
    property ParentFontStyle: Boolean read GetParentStyle write SetParentStyle;
    property Text: TLMDString read GetText write SetText;
    property Caption: TLMDString read GetText write SetText stored false;
       // Main tree text
    property ColumnText: TLMDStrings read GetColText;
      // the alias for ColumnText
    property Color: TColor index 1 read GetColor write SetColor;
       // Color of item's text
    property BkColor: TColor index 2 read GetColor write SetColor;
       // Color of item's text background
    property UseBkColor: Boolean read GetUseBkColor write SetUseBkColor;
       // defines if BkColor property is taken into account when painting the item
    property ParentColors: Boolean read GetParentColors write SetParentColors;
       // if ParentColors=True, then Color and BkColor properties are ignored
    property ImageIndex: Integer index 0 read GetImageIndex write SetImageIndex
        default -1;
    property StateImageIndex: Integer index 2 read GetImageIndex write
        SetImageIndex default -1;
    property ImageIndex2: Integer index 1 read GetImageIndex write SetImageIndex
        default -1;
    property StateImageIndex2: Integer index 3 read GetImageIndex write
        SetImageIndex default -1;
    property OverlayIndex: Integer index 4 read GetImageIndex write SetImageIndex
        default -1;
    property OverlayIndex2: Integer index 5 read GetImageIndex write SetImageIndex
        default -1;
    property ForceButtons: Boolean read GetForceButtons write SetForceButtons
        default False;
    property SuppressButtons: Boolean read GetSuppressButtons write
        SetSuppressButtons default False;
    property SuppressLines: Boolean read GetSuppressLines write SetSuppressLines;
    property Hint: TLMDString read GetHint write SetHint;
    property UseStyles: Boolean read GetUseStyles write SetUseStyles;
    property MainStyle  : TElCellStyle read GetMainStyle;
    property StylesCount: Integer read GetStylesCount;
    property CheckBoxState: TCheckBoxState read GetCheckBoxState write
        SetCheckBoxState default cbUnchecked;
    property Checked: Boolean read GetChecked write SetChecked default False;
    property ShowCheckBox: Boolean read GetShowCheckBox write SetShowCheckBox
        default True;
    property CheckBoxType: TElCheckBoxType read GetCheckBoxType write
        SetCheckBoxType default ectCheckBox;
    property CheckBoxEnabled: Boolean read GetCheckBoxEnabled write
        SetCheckBoxEnabled;
    property Enabled: Boolean read GetEnabled write SetEnabled default True;
    property Hidden: Boolean read GetHidden write SetHidden;
    property FullyVisible: Boolean read GetFullyVisible write SetFullyVisible;
    property Height      : Integer read GetHeight write SetHeight;  { Public }
    property OwnerHeight : Boolean read GetOwnerHeight write SetOwnerHeight;  { Public }
    property Multiline: Boolean read GetMultiline write SetMultiline;
    property RowBkColor: TColor index 3 read GetColor write SetColor;
    // The color of the item background (complete, not under text

    property IsHTML: Boolean read GetIsHTML write SetIsHTML;

    property BorderStyle: TElItemBorderStyle read GetBorderStyle write
        SetBorderStyle;
    property IndentAdjust: Integer read GetIndentAdjust write SetIndentAdjust;
    property HintIsHTML: Boolean read GetHintIsHTML write SetHintIsHTML;
    property BorderSpaceColor: TColor index 4 read GetColor write SetColor default
        clWindow;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap default false;
  end;

// *****************************************************************************

  TElTreeItemClass = class of TElTreeItem;

  TElLookupCompareProc = function(Item: TElTreeItem; SearchDetails: TLMDDataTag): boolean;
  TElLookupCompareMethod = function(Item: TElTreeItem; SearchDetails: TLMDDataTag): boolean of object;

  TElIterateProc = procedure(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
    IterateData: TLMDDataTag; Tree: TCustomElTree);

  TElIterateMethod = procedure(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
    IterateData: TLMDDataTag; Tree: TCustomElTree) of object;

  TElTreeItems = class(TPersistent)
  private
    procedure IntFind(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);
    procedure IntFind1(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);
    procedure IntFind3(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);
    procedure IntFind4(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);
  protected
    FOwner: TCustomElTree;
    //FCount: integer;

    FRoot: TElTreeItem;
    FItemClass : TElTreeItemClass;
    function GetVisCount: integer;
    procedure ReadData(Stream: TStream); virtual;
    procedure WriteData(Stream: TStream); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    function CreateItem(FOwner: TCustomElTree): TElTreeItem; virtual;
    function GetCount: Integer;
    function GetRootCount: Integer;
    function GetRootItem(Index: Integer): TElTreeItem;
    function GetItem(index: integer): TElTreeItem;
    function GetVisItem(index: integer): TElTreeItem;
    procedure Init; virtual;
  public
    procedure Assign(Source: TPersistent); override;
    constructor Create(AOwner: TCustomElTree); virtual;
    constructor CreateClass(AOwner: TCustomElTree; ItemClass : TElTreeItemClass);
    destructor Destroy; override;

    procedure AddExistingItem(Item, Parent: TElTreeItem);
    procedure InsertExistingItem(Item, Parent: TElTreeItem; Index: integer);
    procedure RemoveItem(Child: TElTreeItem);

    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);
    procedure SaveToFile(FileName: TLMDString);
    procedure LoadFromFile(FileName: TLMDString);

    procedure SaveToStringList(AStrings : TStrings);
    procedure LoadFromStringList(Strings : TStrings);
    {$ifdef LMD_UNICODE}
    procedure LoadFromWideStringList(Strings : TLMDWideStrings);
    procedure SaveToWideStringList(AStrings : TLMDWideStrings);
    {$endif}

    procedure DeleteItem(Child: TElTreeItem);
    function GetAbsIndex(Child: TElTreeItem) : integer;
    function GetVisIndex(Child: TElTreeItem) : integer;
    function AddItem(Parent: TElTreeItem)    : TElTreeItem;
    function AddLastItem(Parent: TElTreeItem): TElTreeItem;
    procedure SetItem(Index: Integer; Value: TElTreeItem);
    function InsertItem(Index: integer; Parent: TElTreeItem): TElTreeItem;

    // AllocateStorage increases the size of the list, thus speeding up items adding
    procedure AllocateStorage(MaxItems : integer);
    procedure AllocateStorageInRoot(MaxItems : integer);
    function Add(Item: TElTreeItem; Text: TLMDString): TElTreeItem; virtual;
    function AddChild(Item: TElTreeItem; Text: TLMDString): TElTreeItem; virtual;
    function AddChildFirst(Item: TElTreeItem; Text: TLMDString): TElTreeItem; virtual;
    function AddChildObject(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; virtual;
    function AddChildObjectFirst(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; virtual;
    function AddFirst(Item: TElTreeItem; Text: TLMDString): TElTreeItem; virtual;
    function AddObject(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; virtual;
    function AddObjectFirst(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; virtual;
    function Insert(Item: TElTreeItem; Text: TLMDString): TElTreeItem; virtual;
    function InsertObject(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; virtual;
    function InsertAfter(Item: TElTreeItem; Text: TLMDString): TElTreeItem; virtual;
    function InsertAfterObject(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; virtual;
    function InsertItemFromString(Index : integer; AString : TLMDString): TElTreeItem;

    procedure Delete(Item: TElTreeItem); virtual;
    function GetFirstNode: TElTreeItem;

    procedure Clear;
    procedure IterateBranch(VisibleOnly: boolean; IterateProc: TElIterateProc; IterateData: TLMDDataTag; BranchParent: TElTreeItem); overload;
    procedure IterateFrom(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElIterateProc; IterateData: TLMDDataTag; StartFrom: TElTreeItem); overload;
    procedure IterateBackFrom(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElIterateProc; IterateData: TLMDDataTag; StartFrom: TElTreeItem); overload;
    procedure Iterate(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElIterateProc; IterateData: TLMDDataTag); overload;
    procedure IterateBack(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElIterateProc; IterateData: TLMDDataTag); overload;

    procedure Iterate(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElIterateMethod; IterateData: TLMDDataTag); overload;
    procedure IterateBack(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElIterateMethod; IterateData: TLMDDataTag); overload;
    procedure IterateFrom(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElIterateMethod; IterateData: TLMDDataTag; StartFrom: TElTreeItem); overload;
    procedure IterateBackFrom(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElIterateMethod; IterateData: TLMDDataTag; StartFrom: TElTreeItem); overload;
    procedure IterateBranch(VisibleOnly: boolean; IterateMethod: TElIterateMethod; IterateData: TLMDDataTag; BranchParent: TElTreeItem); overload;
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;

    function LookForItem(StartItem: TElTreeItem;
      TextToFind: TLMDString;
      DataToFind:TLMDDataTag;
      ColumnNum : integer;
      LookForData,
      CheckStartItem,
      SubItemsOnly,
      VisibleOnly,
      NoCase: boolean): TElTreeItem;
        (*<+>*)
    function LookForItem2(StartItem: TElTreeItem;
      TextToFind: TLMDString;
      WholeTextOnly: boolean;
      DataToFind: TLMDDataTag;
      ColumnNum : integer;
      LookForData,
      CheckStartItem,
      SubItemsOnly,
      VisibleOnly,
      CheckCollapsed,
      NoCase: boolean): TElTreeItem;

    function LookForItemEx(StartItem: TElTreeItem; ColumnNum: integer;
      CheckStartItem, SubItemsOnly, VisibleOnly: boolean;
      SearchDetails: TLMDDataTag;
      CompareProc: TElLookupCompareProc): TElTreeItem;

    function LookBackForItemEx2(StartItem: TElTreeItem; ColumnNum: integer;
      CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: boolean;
      SearchDetails: TLMDDataTag;
      CompareProc: TElLookupCompareProc): TElTreeItem;

    (*<+>*)
    function LookForItemEx2(StartItem: TElTreeItem; ColumnNum: integer;
      CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: boolean;
      SearchDetails: TLMDDataTag;
      CompareProc: TElLookupCompareProc): TElTreeItem; overload;

    function LookForItemEx2(StartItem: TElTreeItem; ColumnNum: integer;
      CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: boolean;
      SearchDetails: TLMDDataTag;
      CompareMethod: TElLookupCompareMethod): TElTreeItem; overload;
    property ItemClass : TElTreeItemClass read FItemClass write FItemClass;
    property Owner: TCustomElTree read FOwner;
    property Item[Index: integer]: TElTreeItem read GetItem; default;
    property ItemAsVis[Index: integer]: TElTreeItem read GetVisItem;
    property Count: Integer read GetCount;
    property VisCount: integer read GetVisCount;
    property RootCount: Integer read GetRootCount;
    property RootItem[Index: Integer]: TElTreeItem read GetRootItem;
  end;

// *****************************************************************************

  TOleDragStartEvent = procedure(Sender: TObject; var dataObj: IDataObject;
    var dropSource: IDropSource; var dwOKEffects: TDragTypes) of object;
  TOleDragFinishEvent = procedure(Sender: TObject; dwEffect: TDragType; Result: HResult) of object;

  TMeasureItemPartEvent = procedure(Sender: TObject; Item: TElTreeItem; PartIndex: integer; var Size: TPoint) of object;
  THeaderSectionEvent = procedure(Sender: TObject; Section: TElHeaderSection) of object;

  TOnItemDrawEvent = procedure(Sender: TObject; Item: TElTreeItem; Surface: TCanvas;
    R: TRect; SectionIndex: integer) of object;
  TOnShowHintEvent = procedure(Sender: TObject;
    Item: TElTreeItem;
    Section : TElHeaderSection;
    var Text: TLMDString;
    HintWindow: THintWindow;
    MousePos: TPoint;
    var DoShowHint: boolean) of object;
  TApplyVisFilterEvent = procedure(Sender: TObject; Item: TElTreeItem; var Hidden: boolean) of object;

  TTuneUpInplaceEditEvent = procedure(Sender : TObject; Item : TElTreeItem; SectionIndex : integer; Editor : TCustomEdit) of object;
  TOnItemExpandEvent = procedure(Sender: TObject; Item: TElTreeItem) of object;
  TOnItemCheckedEvent = Procedure (Sender: TObject; Item: TelTreeItem) of Object;
  TItemSelChangeEvent = procedure(Sender: TObject; Item: TElTreeItem) of object;
  TOnItemChangeEvent = procedure(Sender: TObject; Item: TElTreeItem;
    ItemChangeMode: TItemChangeMode) of object;

  TOnCompareItems = procedure(Sender: TObject; Item1, Item2: TElTreeItem;
    var res: integer) of object;

  TOnItemExpanding = procedure(Sender: TObject; Item: TElTreeItem;
    var CanProcess: boolean) of object;

  TOnPicDrawEvent = procedure(Sender: TObject; Item: TElTreeItem;
    var ImageIndex: integer) of object;

  THotTrackEvent = procedure(Sender: TObject; OldItem, NewItem: TElTreeItem) of object;

  TOnValidateEvent = procedure(Sender: TObject; Item: TElTreeItem;
    Section: TElHeaderSection;
    var Text: string; var Accept: boolean) of object;

  TOnEndEditEvent = procedure(Sender: TObject; Item: TElTreeItem;
    Section: TElHeaderSection; Canceled: boolean) of object;  (*<+>*)
  TTryEditEvent = procedure(Sender: TObject; Item: TElTreeItem;
    SectionIndex: integer; var CellType: TElFieldType; var CanEdit: boolean) of object;
  TEditRequestEvent = procedure(Sender: TObject; Item: TElTreeItem;
    Section: TElHeaderSection) of object;

  TComboEditShowEvent = procedure(Sender: TObject; Item: TElTreeItem;
    Section: TElHeaderSection;
    Combobox: TCombobox) of object;

  TValidateComboEvent = procedure(Sender: TObject; Item: TElTreeItem;
    Section: TElHeaderSection;
    Combo: TComboBox;
    var Accept: boolean) of object;

  TElScrollEvent = procedure(Sender: TObject;
    ScrollBarKind: TScrollBarKind;
    ScrollCode: integer) of object;

  TElColumnMoveEvent = procedure(Sender: TCustomElTree;
    Section: TElHeaderSection;
    OldPos, NewPos: integer) of object;

  TElItemSaveEvent = procedure(Sender: TObject; Stream: TStream;
    Item: TElTreeItem) of object;

  TElCellStyleSaveEvent = procedure(Sender: TObject; Stream: TStream;
    Style: TElCellStyle) of object;

  TElTreeChangingEvent = procedure (Sender : TObject; Item : TElTreeItem;
    var AllowChange: Boolean) of object;

  TElTreeItemPostDrawEvent = procedure(Sender : TObject; Canvas : TCanvas; Item : TElTreeItem;
    ItemRect : TRect; var DrawFocusRect : boolean) of object;

  TElTreeItemDragTargetEvent = procedure (Sender : TObject; Item : TElTreeItem;
    ItemRect : TRect; X, Y : integer) of object;

  TElCanDragEvent = procedure(Sender: TObject; Item: TElTreeItem; var CanDrag: Boolean) of object;

  TVirtualTextNeededEvent = procedure (Sender : TObject; Item : TElTreeItem; SectionIndex : Integer; var Text : TLMDString) of object;
  TVirtualHintNeededEvent = procedure (Sender : TObject; Item : TElTreeItem; var Hint : TLMDString) of object;
  TVirtualValueNeededEvent= procedure (Sender : TObject; Item : TElTreeItem; SectionIndex : Integer; VarType : integer; var Value : Variant) of object;
  TVirtualPropsNeededEvent= procedure (Sender : TObject; Item : TElTreeItem; PropTypes : TElVirtPropTypes; Value : TElTreeItemStaticDataEx) of object;
  TVirtualStyleNeededEvent= procedure (Sender : TObject; Item : TElTreeItem; SectionIndex : Integer; Style : TElCellStyle) of object;

  TElTreeView = class(TElTreeViewAncestor)
  private // iterate methods
    procedure IntVis0(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);
    procedure IntNextVis(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);
    procedure IntPgVis(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);
    procedure IntPrevVis(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);
  protected
    FHeader   : TElHeader;
    FOwner    : TCustomElTree;
    FItems    : TElTreeItems;
    VirtStyle : TElCellStyle;
    // Hint fields
    FHintTimer: TTimer;
    FHintWnd  : TElHintWindow;
    FHintCoord: TPoint;
    FHintItem,
    FHintItemEx : TElTreeItem;
    FHintHCol: Integer;
    FOnCanDrag: TElCanDragEvent;

    // Update fields
    FPainting, // already in Paint
    FClearVis, // do update visibles list
    FClearAll, // clear the whole ClientRect
    FVisUpdated, // visibles list updated
    FRangeUpdate // all items should be updated
               : boolean;

    // Positioning fields
    FHRange    : integer;

    // Mouse action fields
    FPressCoord: TPoint;
    FPressed   : boolean;
    FMouseSel  : boolean;
    FClickCoord: TPoint;
    FClicked   : boolean;
    FClickControl: TElCellControl;
    FIgnoreClick,
    FIgnoreClick2: boolean;
    FClickPassed : boolean;
    FPassedItem  : TElTreeItem;
    FPassedShift : TShiftState;

    FClickSection: integer;
    // Current items
    FClickItem,
    FTrackItem,

    FEditingItem,

    FFocused,
    FSelected,
    FDropTrg  : TElTreeItem;

    // mouse frame selection
    FMFSStartItem  : TElTreeItem;
    FMFSStartCoord : TPoint;
    FMFSEndItem    : TElTreeItem;
    FMFSendCoord   : TPoint;
    FMFSList       : TLMDObjectList;

    // for correct handle checkbox click
    FClickedItem   : TElTreeItem;

    // Painting helper fields
    FVisible  : TLMDObjectList;
    FOverColors,
    FRowOvColors: boolean;

    // Drag'n'drop fields
    FDragScrollTimer,
    FDragExpandTimer : TTimer;
    FDropAcc   : boolean;
    FInDragging: boolean;
    FDDY       : integer;

    FDragImages: TImageList;

    // Edit fields

    FInpEdit   : TElTreeInplaceEditor;
    //FEditing   : boolean;
    FEditType  : TElFieldType;
    FEditSect  : integer;
    FEditTimer : TTimer;
    FItemToEdit: TElTreeItem;
    FEndEditWhenDestroy : Boolean;

    FOldHide   : boolean;
    FFakePopup : TPopupMenu;

    FRender    : TLMDHTMLRender;

    FTmpBmp   : TBitmap;

    Input : TElKeyboardInput;
    SearchTextTimeoutThread : TThread;

    FScrollFirstClick: boolean;

    FHasFocus : boolean;

    procedure StartClearSearchTimeoutThread ;
    procedure StopClearSearchTimeoutThread ;
    procedure SearchTextTimeout (Sender : TObject) ;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    // Custom background routines
    procedure RedoTmpBmp;

    // Painting routines
    procedure RedrawTree(ACanvas : TCanvas; RealLeftPos : integer; ItemsList : TLMDObjectList); virtual;
    procedure DrawImages(ACanvas : TCanvas; Item : TElTreeItem; HelperBitmap : TBitmap; var R : TRect; var ItemRect : TRect);
    procedure DrawHorzLine(ACanvas : TCanvas; Item : TElTreeItem; var R : TRect); virtual;
    procedure DrawVertLine(ACanvas : TCanvas; Item : TElTreeItem; var R : TRect); virtual;
    procedure DrawGutter(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect); virtual;
    procedure DrawButtons(ACanvas : TCanvas; Item : TElTreeItem; IsNode : boolean; HelperBitmap : TBitmap; var R : TRect; var ItemRect : TRect);
    procedure DrawCheckBoxes(ACanvas : TCanvas; Item : TElTreeItem; HelperBitmap : TBitmap; var R : TRect; var ItemRect : TRect);
    procedure DrawItemLines(ACanvas : TCanvas; Item : TElTreeItem; var R : TRect; var ItemRect : TRect);
    procedure DoRedrawItem(ACanvas : TCanvas; Item: TElTreeItem; ItemRect, SurfRect: TRect);
    procedure DoRedrawItemTree(ACanvas : TCanvas; HelperBitmap : TBitmap; Item:
        TElTreeItem; ItemRect, SurfRect: TRect);
    procedure Paint; override;
    procedure WMPaint(var Msg : TWMPaint); message WM_PAINT;
    procedure DoPaintBkgnd(DC : HDC; ClipRect : TRect);
    procedure UpdateView;

    // Hint routines
    procedure TryStartHint(XPos, YPos : Integer);
    procedure OnHintTimer(Sender: TObject);
    procedure DoHideLineHint;
    procedure DoShowLineHint(Item: TElTreeItem; Section : TElHeaderSection);
    function  GetHintText(Item: TElTreeItem; var Section : TElHeaderSection) : TLMDString;

    // Dynamic height helper routines
    function CalcPageUpPos(CurIdx : integer) : integer;
    function CalcPageDownPos(CurIdx : integer) : integer;

    // Windows Message handling
    procedure WndProc(var Message: TMessage); override;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LButtonDblClk;
    procedure WMRButtonDblClk(var Msg: TWMRButtonDblClk); message WM_RBUTTONDBLCLK;
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Msg: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMIMEComposition(var Message: TMessage); message WM_IME_COMPOSITION;
    procedure WMIMEStartComposition(var Message: TMessage); message WM_IME_STARTCOMPOSITION;
    {$ifdef LMD_UNICODE}
    procedure WMDeadChar(var Message: TWMDeadChar); message WM_DEADCHAR;
    {$endif}
    function IntLButtonDown(X, Y : integer; Shift : TShiftState): Boolean;
    function IntLButtonUp(X, Y : integer; Shift : TShiftState): Boolean;
    procedure IntRButtonDown(X, Y : integer; Shift : TShiftState);
    function IntRButtonUp(X, Y : integer; Shift : TShiftState): Boolean;
    function IntLButtonDblClick(X, Y : integer; Shift : TShiftState): Boolean;
    function IntRButtonDblClick(X, Y : integer; Shift : TShiftState): Boolean;
    procedure IntMouseMove(X, Y : integer; Shift : TShiftState);

    // VCL notification handlers
    procedure CMMouseWheel(var Msg : TCMMouseWheel); message CM_MOUSEWHEEL;
    procedure CMSysColorChange(var Msg: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMHintShow(var Msg : TCMHintShow); message CM_HINTSHOW;
    // Scrolling routines
    procedure SetHPosition(value: integer);
    procedure SetVPosition(value: integer);
    procedure DoSetTopIndex(Value: integer);

    procedure OnHScroll(Sender: TObject; ScrollCode: TElScrollCode; var ScrollPos: Integer; var DoChange : boolean);
    procedure OnVScroll(Sender: TObject; ScrollCode: TElScrollCode; var ScrollPos: Integer; var DoChange : boolean);

    // Painting helper routines
    procedure FillVisFwd(StartIndex: integer);
    procedure DefineHRange;
    function GetVisCount: integer; virtual;
    function GetVisiblesHeight : integer;

    // editing routines

    procedure OnEditTimer(Sender : TObject);
    procedure DoEditItem(Item: TElTreeItem; SectionNum: integer); virtual;
    procedure DoEndEdit(ByCancel: boolean); virtual;
    procedure EditOperationCancelled; override;
    procedure EditOperationAccepted; override;

    // drag'n'drop routines
    procedure FillDragImage;
    procedure DoCanDrag(Item: TElTreeItem; var CanDrag: Boolean); virtual;
    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean); virtual;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure CMDrag(var Message: TCMDrag); message CM_DRAG;
    function DragScroll(Source: TDragObject; X, Y: integer): boolean; virtual;
    procedure OnScrollTimer(Sender : TObject);
    procedure OnDragExpandTimer(Sender : TObject);
    procedure OnDropTargetDrag(Sender: TObject; State: TDragState; Source: TOleDragObject; Shift: TShiftState; X: Integer; Y: Integer; var DragType: TDragType);
    procedure OnDropTargetDrop(Sender: TObject; Source: TOleDragObject; Shift: TShiftState; X: Integer; Y: Integer; var DragType: TDragType);

    // coords routines
    function GetItemRect(ItemIndex: integer): TRect; virtual;
    function GetItemAtY(Y: integer): TElTreeItem; virtual;
    function GetItemAt(X, Y: Integer; var ItemPart: TSTItemPart; var HitColumn: integer): TElTreeItem; virtual;

    // user input routines
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    function NeedToFoxusItemInMouseDown(): Boolean; virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure CMMouseLeave(var Message: TMessage); message CM_MouseLeave;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;

    procedure ProcessPassedClick;
    procedure FitMostChildren(Item : TElTreeItem);

    procedure DestroyWnd; override;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DestroyWindowHandle; override;
    // selection routines
    procedure DoSetSelected(value: TElTreeItem);
    function GetVisCount2: Integer; virtual;
    procedure DrawMouseSelectFrame;
    procedure AllocateMouseSelectFrame;
    procedure DeallocateMouseSelectFrame;
    procedure SelectMouseSelectItems;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
    procedure CancelMouseSel;
    procedure CMDeactivate(var Message: TCMDeactivate); message CM_DEACTIVATE;

    function FindNewFocused(Key : word; PVal1 : PInteger; var Sel : boolean): TElTreeItem; overload; virtual;
    function FindNewFocused(Key : word; var Sel : boolean): TElTreeItem; overload; virtual;
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    procedure InitiateEditOp(Item : TElTreeItem; HCol : integer; Immediate :
        boolean); virtual;
    function IsControlCell(Item : TElTreeItem; SectionIndex : integer): Boolean;
    procedure DrawCellImage(ACanvas : TCanvas; Item : TElTreeItem; ImageIndex :
        Integer; SectionIndex : integer; HelperBitmap : TBitmap; var R : TRect);
    procedure DoPerformSearch(SearchText : TLMDString); virtual;
    procedure WMHScroll(var Msg : TWMHScroll); message WM_HSCROLL;
    procedure WMVScroll(var Msg : TWMVScroll); message WM_VSCROLL;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
  public
    constructor Create(Owner : TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
    function GetDragImages: TDragImageList; override;
    property DragCursor;
    property Owner : TCustomElTree read FOwner;
    end;

  TCustomElTree = class(TElTreeAncestor)
  private
    function IntCompare(Item: TElTreeItem; SearchDetails: TLMDDataTag): boolean;
    procedure SetMultilineEllipsis(const Value: boolean);
    procedure SetSinglelineEllipsis(const Value: boolean);
  protected
    FUseThemeForSelection: Boolean;
    FStripedOddColor: TColor;
    FStripedEvenColor: TColor;
    FStripedItems: Boolean;
    FOnVirtualStyleNeeded: TVirtualStyleNeededEvent;
    FOnBeginUpdate: TNotifyEvent;
    FOnEndUpdate: TNotifyEvent;
    FSortSections        : TLMDObjectList;
    FOnVirtualTextNeeded : TVirtualTextNeededEvent;
    FVirtualityLevel     : TVirtualityLevel;
    FOnVirtualHintNeeded : TVirtualHintNeededEvent;
    FOnVirtualValueNeeded: TVirtualValueNeededEvent;
    FOnVirtualPropsNeeded: TVirtualPropsNeededEvent;
    FLineHintType        : TLineHintType;
    FLineHintTimeout     : Integer;
    FFireFocusEvents     : integer;
    FTransButtons        : boolean;
    FTransCheckBoxes     : boolean;
    FTrackColor          : TColor;
    FExpandOnDragOver    : Boolean;
    FForcedScrollBars    : TScrollStyle;
    FMoveFocusOnCollapse : Boolean;
    FHeaderHeight        : integer;
    FOnVertScrollHintNeeded : TElScrollHintNeededEvent;
    FOnHorzScrollDrawPart   : TElScrollDrawPartEvent;
    FOnHorzScrollHintNeeded : TElScrollHintNeededEvent;
    FOnVertScrollDrawPart   : TElScrollDrawPartEvent;
    FOnVertScrollHitTest    : TElScrollHitTestEvent;
    FOnChanging             : TElTreeChangingEvent;

    FBevelKindDummy : TBevelKind;

    FHintType : TElHintType;
    FOnClick : TNotifyEvent;
    FOnDblClick : TNotifyEvent;
    //FOnEndDrag : TDragDropEvent;
    FOnDrop : TDragDropEvent;
    FOnOver : TDragOverEvent;
    FOnDrag : TEndDragEvent;
    FOnEnter : TNotifyEvent;
    FOnExit : TNotifyEvent;
    FOnKeyDown : TKeyEvent;
    FOnKeyPress : TKeyPressEvent;
    FOnKeyUp : TKeyEvent;
    FOnMouseDown : TMouseEvent;
    FOnMouseMove : TMouseMoveEvent;
    FOnMouseUp : TMouseEvent;
    FOnStartDrag : TStartDragEvent;
    FOnItemPreDraw: TOnItemExpandEvent;
    FOnDragTargetChange: TElTreeItemDragTargetEvent;

    FGradientStartColor : TColor;
    FGradientEndColor : TColor;
    FGradientSteps : Integer;

    FActiveBorderType : TElFlatBorderType;
    FInactiveBorderType : TElFlatBorderType;
    FRowHotTrack : Boolean;
    FFocusedSelectColor: TColor;
    FHideSelectColor: TColor;
    FFocusedSelectTextColor: TColor;
    FHideSelectTextColor: TColor;

    FBackground : TBitmap;
    FBackgroundType : TLMDBackgroundType;
    FAdjustMultilineHeight : Boolean;

    FFlatFocusedScrollbars : Boolean;
    FAutoResizeColumns : Boolean;
    FHideFocusRect: Boolean;
    FShowEmptyImages : Boolean;
    FShowEmptyImages2: Boolean;
    FShowRootButtons : Boolean;
    FUnderlineTracked: Boolean;
    FCustomCheckboxes: Boolean;
    FCheckBoxGlyph: TBitmap;
    FRadioButtonGlyph: TBitmap;

    FFilteredVisibility: Boolean;
    FOnApplyVisFilter: TApplyVisFilterEvent;
    FRightAlignedText: Boolean;
    FFlat: Boolean;
    FRightAlignedView: Boolean;
    FPathSeparator: Char;
    FLinesStyle: TPenStyle;
    FLinesColor: TColor;
    FDeselectChildrenOnCollapse: Boolean;
    FDrawFocusRect: Boolean;
    FBarStyle: Boolean;
    FNotRaiseForBarStyle: Boolean;
    FAlwaysKeepFocus : boolean;
    FAlwaysKeepSelection: Boolean;
    FFullRowSelect: Boolean;
    FDragType  : TElDragType;
    FMouseOver : boolean;

    FDropTarget: TElDropTarget;

    FDragObject : TDragObject;
    FAutoLookup: Boolean;
    FSelectColumn: Integer;
    FAutoExpand: Boolean;
    FLeafPicture,
    FPlusPicture,
    FMinusPicture: TBitmap;
    FCustomPlusMinus: Boolean;
    FShowHeader,
    FShowCheckboxes: Boolean;

    FImgForm : TElImageForm;
    FImgFormChLink : TImgFormChangeLink;
    FStorage: TElIniFile;
    FStoragePath: string;
    FDragImageMode: TDragImgMode;
    FHideHorzScrollBar: Boolean;
    FHideVertScrollBar: Boolean;
    FHideHintOnMove: Boolean;
    FSortSection: Integer;
    FSortMode: TSortModes;
    FSortType: TSortTypes;
    FDragAllowed: Boolean;
    FBkColor  : TColor;
    FTextColor: TColor;
    FShowButtons: boolean;
    FShowLines: boolean;
    FShowImages: boolean;
    FShowRoot: boolean;
    FLineHintColor: TColor;
    FShowHintMode: THintModes;
    // BMP: TBitmap;
    FBorderStyle: TBorderStyle;

    FCanEdit: boolean;

    FIgnoreSBChange : boolean;
    FScrollbarsInitialized : boolean;

    FSortRequired,
    FProcUpdate, // already in SetIsUpdating
    FUpdated : boolean;
    FInSorting : integer;
    FBSVLines: Boolean;
    FAllList,
    FSelectedList : TLMDObjectList;

    FVertScrollTracking,
    FHorzScrollTracking,
      FTracking: boolean;
    FHeaderHotTrack: boolean;
    FODFollowCol: boolean;
    FODMask: TLMDString;

    FImages: TCustomImageList;
    FImages2: TCustomImageList;
    FAlphaImages: TCustomImageList;
    FAlphaImages2: TCustomImageList;

    FImageChangeLink: TChangeLink;
    FAImageChangeLink: TChangeLink;

    FTopIndex,
      FBottomIndex: integer; // visible items
    FChStateImage: boolean;
    FRealHint,
    FHint       : TLMDString;
    FMainTreeCol: integer;
    FMultiSelect: boolean;
    FMultiSelectLevel: Integer; // CNS: -1 any, 0,1,2... limit multiseletion to this level
    FRowSelect  : boolean;
    FHideSelect : boolean;
    FLineHeight : integer;
    FAutoLineHeight: boolean;
    ItemExt        : integer;
    FUseCustomBars : boolean;

    // FTreeIsFocused : boolean;

    FHPos: integer;
    FVScrollVisible,
    FHScrollVisible: boolean;
    FSelMode: TSTSelModes;
    FSortDir: TSortDirs;

    FSelChange: boolean;
    FColSizeUpdate,
    FUpdating : // UpdateCount > 0
                 boolean;
    FUpdateCount: integer;

    FHintHide: boolean;
    FUseSystemHintColors : boolean;
    IgnoreResize: boolean;
    FCurBkColor: TColor;
    FCurTextColor: TColor;

    FDelOnEdit: boolean;

    FAutoSizingColumns: boolean;
    FItems: TElTreeItems;

    FOnColumnResize: TColumnNotifyEvent;
    FOnColumnClick: TColumnNotifyEvent;
    FOnColumnDraw: TElSectionRedrawEvent;

    FOnItemChange: TOnItemChangeEvent;
    FOnItemDraw: TOnItemDrawEvent;
    FOnItemChecked : TOnItemCheckedEvent;
    FOnItemExpand: TOnItemExpandEvent;
    FOnItemCollapse: TOnItemExpandEvent;
    FOnItemExpanding: TOnItemExpanding;
    FOnItemCollapsing: TOnItemExpanding;
    FOnItemDelete: TOnItemExpandEvent;
    FOnItemFocused: TNotifyEvent;
    FOnItemPostDraw : TElTreeItemPostDrawEvent;
    FOnShowHint: TOnShowHintEvent;
    FOnCompareItems: TOnCompareItems;
    FOnItemPicDraw: TOnPicDrawEvent;
    FOnItemPicDraw2: TOnPicDrawEvent;
    FOnHotTrack: THotTrackEvent;

    FOnScroll: TElScrollEvent;
    FOnItemSave: TElItemSaveEvent;
    FOnItemLoad: TElItemSaveEvent;

    FOnTryEdit: TTryEditEvent;
    FOnEndEdit: TOnEndEditEvent;

    FOnHeaderColumnMove: TElColumnMoveEvent;
    FOnSave: TElCellStyleSaveEvent;
    FOnLoad: TElCellStyleSaveEvent;
    FOnItemSelectedChange: TItemSelChangeEvent;
    FOnHeaderLookup: TElHeaderLookupEvent;
    FOnHeaderLookupDone: TElHeaderLookupDoneEvent;
    FOnHeaderResize: TNotifyEvent;
    FOnHeaderSectionExpand: THeaderSectionEvent;
    FOnHeaderSectionCollapse: THeaderSectionEvent;
    FOnHeaderSectionMeasure : TMeasureSectionEvent;
    FOnSectionAutoSize : TColumnNotifyEvent;
    FOnSectionFilterCall : TColumnNotifyEvent;
    FOnMeasureItemPart   : TMeasureItemPartEvent;
    FOnSortBegin,
    FOnSortEnd           : TNotifyEvent;

    FOnEditKeyDown       : TKeyEvent;

    FOnOleDragFinish: TOleDragFinishEvent;
    FOnOleDragStart: TOleDragStartEvent;
    FOnOleTargetDrag: TTargetDragEvent;
    FOnOleTargetDrop: TTargetDropEvent;

    TotalHiddenCount,
    TotalVisCount: integer;
    TotalVarHeightCount : integer;

    FView: TElTreeView;
    FHeader: TElHeader;
    FHScrollBar : TElScrollBar;
    FVScrollBar : TElScrollBar;
    FHorzScrollBarStyle,
    FVertScrollBarStyle : TElScrollBarStyles;
    SavedHH   : integer;
    FDelayTimer: TTimer;

    FDelayedItem: TElTreeItem;
    FDragExpandDelay,
    FChangeDelay: Integer;
    FDragTrgDrawMode: TDragTargetDraw;

    FOnHeaderMouseDown: TMouseEvent;
    FOnAfterSelectionChange: TNotifyEvent;
    FDragRectAcceptColor: TColor;
    FDragRectDenyColor: TColor;
    FIncrementalSearchTimeout : integer;
    FIncrementalSearch: Boolean;
    FRightClickSelect: Boolean;
    FScrollbarOpposite: Boolean;
    FVerticalLinesLong: Boolean;
    FBorderSides: TLMDBorderSides;
    FOnInplaceEditorNeeded: TInplaceEditorNeededEvent;
    FCursor : TCursor;

    FOnImageNeeded : TElHTMLImageNeededEvent;
    FOnImageNeededEx : TLMDHTMLImageNeededEvent;
    FOnLinkClick : TElHTMLLinkClickEvent;
    FOnLinkOver: TElHTMLLinkOverEvent;
    FLinkCursor: TCursor;
    FLinkColor : TColor;
    FLinkStyle : TFontStyles;

    FQuickEditMode: Boolean;
    FMainTextType: TElFieldType;
    FOnHorzScrollHitTest: TElScrollHitTestEvent;
    FMouseFrameVisible,
    FMouseFrameSelect : Boolean;
    FVertDivLinesColor: TColor;
    FHorzDivLinesColor: TColor;
    FDragScrollInterval: Integer;
    FShowLeafButton: Boolean;
    FCheckBoxSize: Integer;
    FIgnoreEnabled: Boolean;
    FInplaceEditorDelay: Integer;
    FHeaderFont: TFont;
    FHeaderUseTreeFont: Boolean;
    FKeepSelectionWithinLevel: Boolean;
    FAutoCollapse: Boolean;
    FIgnoreResizes: Boolean;
    FSortUseCase: Boolean;
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FDblClickMode: TElDblClickMode;
    FDoubleBuffered: Boolean;
    FDoubleBufferedOnResize: Boolean;
    InSizeMove : boolean;
    FHook : TElHook;
    FHighlightAlphaLevel: Integer;

    FDataCache : TLMDObjectList;
    FDataCacheSize: Integer;
    FLastWasDown  : boolean;
{$IFDEF HOTTRACK_CURSOR}
    FTrackingCursor : TCursor;
{$ENDIF}

    FSortSectionToCompare: Integer;
    FIncrementalSearchScope: TElIncSearchScope;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;
    FIncrementalSearchColumn: TElIncSearchColumn;
    FCheckBoxFlat: Boolean;
    FHorzArrowsScroll: Boolean;
    FSortColumnColor: TColor;

    FSinglelineEllipsis: boolean;
    FMultilineEllipsis: boolean;

    procedure SetUseThemeForSelection(const Value: Boolean);
    function IsVistaSelNeed: boolean;
    procedure ReadState(Reader: TReader); override;
    procedure SetStripedOddColor(Value: TColor);
    procedure SetStripedEvenColor(Value: TColor);
    procedure SetStripedItems(Value: Boolean);

    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image : TBitmap); virtual;
    procedure TriggerImageNeededExEvent(Sender : TObject; Src : TLMDString; Image : TPicture); virtual;

    procedure TriggerLinkClickEvent(HRef : string; X, Y: integer); virtual;
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;

    procedure OnBeforeHook(Sender : TObject; var Message : TMessage; var Handled : boolean);
    procedure SetParent(AParent: TWinControl); override;
    procedure SetVirtualityLevel(Value: TVirtualityLevel);
    procedure SetBorderSides(Value: TLMDBorderSides);
    function GetDefaultSectionWidth: Integer;
    procedure SetDefaultSectionWidth(Value: Integer);
    procedure OnHeaderSectionResize(Header: TCustomElHeader; Section: TElHeaderSection);
    procedure OnHeaderSectionClick(Header: TCustomElHeader; Section: TElHeaderSection);
    procedure OnHeaderSectionDelete(Header: TCustomElHeader; Section: TElHeaderSection);virtual;
    procedure DoHeaderMouseDown(Sender: TObject; Button: TMouseButton; Shift:
        TShiftState; X, Y: Integer);
    procedure OnHeaderSectionLookup(Sender: TObject; Section: TElHeaderSection; var Text: TLMDString);
    procedure OnHeaderSectionLookupDone(Sender: TObject; Section: TElHeaderSection; Text: TLMDString; Accepted: boolean);
    procedure OnHeaderExpand(Sender: TCustomElHeader; Section: TElHeaderSection);
    procedure OnHeaderCollapse(Sender: TCustomElHeader; Section: TElHeaderSection);
    procedure OnHeaderSectionVisChange(Sender: TCustomElHeader; Section: TElHeaderSection);
    procedure HeaderSectionAutoSizeHandler(Sender : TCustomElHeader; Section : TElHeaderSection);  { TElHeaderSectionEvent }
    procedure SectionAutoSizeTransfer(Sender : TCustomElHeader; Section : TElHeaderSection);  { TElHeaderSectionEvent }
    procedure SectionFilterCallTransfer(Sender : TCustomElHeader; Section : TElHeaderSection);  { TElHeaderSectionEvent }

    procedure DoHeaderResize(Sender: TObject);
    procedure OnFontChange(Sender: TObject); virtual;
    function IsHeaderFontStored : boolean;
    function IsFontStored : boolean;
    procedure OnSignChange(Sender: TObject);
    procedure ImageListChange(Sender: TObject);

    function GetCanDrag: TElCanDragEvent;
    procedure SetCanDrag(const Value: TElCanDragEvent);

    function GetDropTarget: TElTreeItem;
    function GetTreeViewAncestor: TElTreeViewAncestor; override;
    function GetAlignmentOnSection(SectionIndex: integer): string; override;

    procedure SetTextColor(value: TColor);
    procedure SetBkColor(value: TColor);

    function  GetHeaderWrapCaptions : boolean;
    procedure SetHeaderWrapCaptions(Value : boolean);

    procedure SetHeaderHotTrack(value: boolean);
    procedure SetHeaderHeight(value: integer);
    procedure SetShowEmptyImages(newValue : boolean);
    procedure SetShowEmptyImages2(newValue : boolean);
    procedure SetImages(Value: TCustomImageList);
    procedure SetImages2(newValue: TCustomImageList);
    procedure SetAlphaImages(Value: TCustomImageList);
    procedure SetAlphaImages2(newValue: TCustomImageList);
    procedure SetLineHintTimeout(Value: Integer);

    procedure SetLineStyle(Value: Boolean);
    procedure SetRootStyle(Value: Boolean);
    procedure SetImagesStyle(Value: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetButtonStyle(Value: Boolean);
    procedure SetUpdating(value: boolean);
    function  GetUpdating : boolean;
    procedure SetHLines(value: boolean);
    procedure SetVLines(value: boolean);
    procedure SetBSVLines(value: boolean);
    procedure SetRowSelect(value: boolean);
    procedure SetMultiSelectLevel(Value : integer);
    procedure SetMultiSelect(value: boolean);
    procedure SetFocused(value: TElTreeItem);
    procedure SetHideSelect(value: boolean);
    procedure SetAutoExpand(value: boolean);
    procedure SetMoveFocusOnCollapse(value: boolean);
    function GetHeaderSections: TElHeaderSections;
    procedure SetHeaderSections(value: TElHeaderSections);
    procedure SetChStateImage(value: boolean);
    procedure SetUseStdBars(value : boolean);

    procedure SetItemIndent(value: integer);
    procedure SetLineHeight(value: integer);
    procedure SetAutoLineHeight(value: boolean);
    function GetHeaderHeight: integer;
    procedure SetMainTreeCol(value: integer);
    procedure SetItems(value: TElTreeItems);
    function GetTotalVisCount: integer;
    function GetDraggableSections: Boolean;
    procedure SetDraggableSections(newValue: Boolean);
    procedure SetSortMode(newValue: TSortModes);
    procedure SetSortSection(newValue: Integer);

    function GetMoveColumnOnDrag: Boolean;
    procedure SetMoveColumnOnDrag(newValue: Boolean);
    procedure SetHideHorzScrollBar(newValue: Boolean);
    procedure SetHideVertScrollBar(newValue: Boolean);
    function GetHeaderImages: TCustomImageList;
    procedure SetHeaderImages(newValue: TCustomImageList);
    function GetAlphaHeaderImages: TCustomImageList;
    procedure SetAlphaHeaderImages(newValue: TCustomImageList);

    function GetFireFocusEvents: boolean;
    procedure SetFireFocusEvents(Value: boolean);

    procedure SetScrollbarOpposite(Value: Boolean);
    procedure SetVerticalLinesLong(Value: Boolean);

    function GetSelCount: integer;
    function GetSelected: TElTreeItem;
    function GetFocused : TElTreeItem;
    procedure SetSelected(newValue: TElTreeItem);

    procedure SetStorage(newValue: TElIniFile);

    procedure SetImageForm(newValue : TElImageForm);
    procedure ImageFormChange(Sender: TObject);
    procedure SetHeaderImageForm(newValue : TElImageForm);
    function GetHeaderImageForm : TElImageForm;

    procedure SetShowCheckboxes(newValue: Boolean);
    procedure SetPlusPicture(newValue: TBitmap);
    procedure SetMinusPicture(newValue: TBitmap);
    procedure SetCustomPlusMinus(newValue: Boolean);
    procedure SetSelectColumn(newValue: Integer);
    procedure SetDragType(newValue: TElDragType);

    procedure HeaderResizeTransfer(Sender: TObject);
    procedure HeaderResizeHandler(Sender: TObject);

    function GetStickyHeaderSections: Boolean;
    procedure SetStickyHeaderSections(newValue: Boolean);
    procedure SetBarStyle(newValue: Boolean);
    procedure SetDrawFocusRect(newValue: Boolean);
    procedure SetLinesColor(newValue: TColor);
    procedure SetHorzDivLinesColor(newValue: TColor);
    procedure SetLinesStyle(newValue: TPenStyle);
    procedure SetRightAlignedView(newValue: Boolean);
    procedure SetFlat(newValue: Boolean);
    procedure SetRightAlignedText(newValue: Boolean);
    procedure SetFilteredVisibility(newValue: Boolean);
    procedure SetUnderlineTracked(newValue: Boolean);
    procedure SetCustomCheckboxes(newValue: Boolean);
    procedure SetCheckBoxGlyph(newValue: TBitmap);
    procedure SetRadioButtonGlyph(newValue: TBitmap);
    procedure SetShowRootButtons(newValue: Boolean);
    procedure SetHideFocusRect(newValue: Boolean);
    function GetLockHeaderHeight: Boolean;
    procedure SetLockHeaderHeight(newValue: Boolean);
    procedure SetTransButtons(newValue : boolean);

    procedure UpdateFrame;
    procedure SetHeaderActiveFilterColor(newValue : TColor);
    function GetHeaderActiveFilterColor : TColor;
    procedure SetHeaderFilterColor(newValue : TColor);
    function GetHeaderFilterColor : TColor;
    procedure SetHeaderFlat(newValue : Boolean);
    function GetHeaderFlat : Boolean;

    procedure DrawFlatBorder(HorzTracking, VertTracking : boolean);
    procedure DrawFlatBorderEx(DC : Windows.HDC; HorzTracking, VertTracking : boolean);
    procedure ReRenderAllHTMLItems;

    procedure SetFlatFocusedScrollbars(newValue : Boolean);

    procedure SetBackground(newValue : TBitmap);
    procedure SetBackgroundType(newValue : TLMDBackgroundType);
    procedure BackgroundChange(Sender : TObject);

    procedure WMNCHITTEST(var Msg : TWMNCHitTest); message WM_NCHITTEST;
    procedure WMVScroll(var Msg : TWMVScroll); message WM_VSCROLL;
    procedure WMHScroll(var Msg : TWMHScroll); message WM_HSCROLL;
    procedure WMEnable(var Msg : TWMEnable); message WM_ENABLE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure CMMouseEnter( var Msg: TMessage ); message CM_MouseEnter;
    procedure CMMouseLeave(var Message: TMessage); message CM_MouseLeave;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMSysColorChange(var Msg: TWMSysColorChange); message WM_SYSCOLORCHANGE;

    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;
    procedure IFMCanPaintBkgnd(var Message: TMessage); message IFM_CANPAINTBKGND;
    procedure SetHideSelectColor(newValue: TColor);
    procedure SetFocusedSelectColor(newValue: TColor);

    procedure SetHideSelectTextColor(newValue: TColor);
    procedure SetFocusedSelectTextColor(newValue: TColor);

    procedure SetRowHotTrack(newValue : Boolean);
    procedure SetActiveBorderType(newValue : TElFlatBorderType);
    procedure SetInactiveBorderType(newValue : TElFlatBorderType);

    procedure SetGradientStartColor(newValue : TColor);
    procedure SetGradientEndColor(newValue : TColor);
    procedure SetGradientSteps(newValue : Integer);

    procedure SetHPosition(value: integer);
    procedure SetVPosition(value: integer);

    procedure ClickTransfer(Sender : TObject);  virtual;
    procedure DblClickTransfer(Sender : TObject); virtual;
    procedure DropTransfer(Sender : TObject; Source : TObject; X : Integer; Y : Integer);  virtual;
    //procedure EndDragTransfer(Sender : TObject; Source : TObject; X : Integer; Y : Integer);
    procedure OverTransfer(Sender : TObject; Source : TObject; X : Integer; Y : Integer; State : TDragState; var Accept : Boolean); virtual;
    procedure DragTransfer(Sender : TObject; Target : TObject; X : Integer; Y : Integer); virtual;
    procedure EnterTransfer(Sender : TObject); virtual;
    procedure ExitTransfer(Sender : TObject); virtual;
    procedure KeyDownTransfer(Sender : TObject; var Key : Word; Shift : TShiftState); virtual;
    procedure KeyPressTransfer(Sender : TObject; var Key : Char); virtual;
    procedure KeyUpTransfer(Sender : TObject; var Key : Word; Shift : TShiftState); virtual;
    procedure MouseDownTransfer(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X : Integer; Y : Integer); virtual;
    procedure MouseMoveTransfer(Sender : TObject; Shift : TShiftState; X : Integer; Y : Integer); virtual;
    procedure MouseUpTransfer(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X : Integer; Y : Integer); virtual;
    procedure StartDragTransfer(Sender : TObject; var DragObject : TDragObject); virtual;
    procedure MeasureSectionTransfer(Sender : TObject; Section : TElHeaderSection; var Size: TPoint); virtual;
    procedure SetCursor(newValue : TCursor);
    function  GetCursor : TCursor;
    function  SetScrollInfo(hWnd: HWND; BarFlag: Integer; const ScrollInfo: TScrollInfo; Redraw: BOOL): Integer;
    function  GetScrollInfo(hWnd: HWND; BarFlag: Integer; var ScrollInfo: TScrollInfo): BOOL;
    procedure SetHorzScrollBarStyle(newValue : TElScrollBarStyles);
    procedure SetVertScrollBarStyle(newValue : TElScrollBarStyles);
    procedure HorzScrollDrawPartTransfer(Sender : TObject; Canvas : TCanvas; R : TRect; Part : TElScrollBarPart; Enabled : Boolean; Focused : Boolean; Pressed : Boolean; var DefaultDraw : Boolean);  { TElScrollDrawPartEvent }
    procedure HorzScrollHintNeededTransfer(Sender : TObject; TrackPosition : Integer; var Hint : TLMDString);  { TElScrollHintNeededEvent }
    procedure VertScrollDrawPartTransfer(Sender : TObject; Canvas : TCanvas; R : TRect; Part : TElScrollBarPart; Enabled : Boolean; Focused : Boolean; Pressed : Boolean; var DefaultDraw : Boolean);  { TElScrollDrawPartEvent }
    procedure VertScrollHintNeededHandler(Sender : TObject; TrackPosition : Integer; var Hint  : TLMDString);  { TElScrollHintNeededEvent }
    procedure VertScrollHintNeededTransfer(Sender : TObject; TrackPosition : Integer; var Hint : TLMDString);  { TElScrollHintNeededEvent }
    function GetHeaderInvertSortArrows : Boolean;
    procedure SetHeaderInvertSortArrows(newValue : Boolean);
    // procedure OnFontChanged(Sender: TObject); virtual;
    procedure SBChanged(Sender: TObject);
    procedure ScrollBarMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SetForcedScrollBars(newValue : TScrollStyle);
    function GetDragCursor : TCursor;
    procedure SetDragCursor(Value : TCursor);
    procedure SetTrackColor(value : TColor);

    function GetLockedHeaderSection : TElHeaderSection;
    procedure SetLockedHeaderSection(newValue : TElHeaderSection);
    procedure SetAdjustMultilineHeight(newValue : Boolean); virtual;

    procedure ActionChange(Sender : TObject; CheckDefaults : Boolean); override;

    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure AlignPieces; virtual;
    function GetRoot: TElTreeItem; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function  CompareItems(Item1, Item2: TElTreeItem; SM : TElSSortMode; ST : TSortTypes; FSortSection : integer): integer; virtual;

    procedure SetCanEdit(value: boolean); virtual;

    procedure SetShowHeader(value: boolean); virtual;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure Resize; override;

    function  DoGetPicture(Item: TElTreeItem): integer; virtual;
    function  DoGetPicture2(Item: TElTreeItem): integer; virtual;
    function  DefineLineHeight: integer; virtual;
    procedure UpdateScrollBars; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    function  CreateItems: TElTreeItems; virtual;
    function  CreateItemsExt(ItemClass : TElTreeItemClass) : TElTreeItems; virtual;
    function  CreateHeader: TElHeader; virtual;
    function DoSetFocused(value: TElTreeItem; Forced : boolean): Boolean;
    function DoSetFocusedEx(value: TElTreeItem; Forced, Delayed : boolean): Boolean;
    procedure SetHeaderColor(newValue : TColor); virtual;
    function  GetHeaderColor : TColor; virtual;
    function GetHint: TLMDString;
    procedure SetHint(newValue: TLMDString);

    procedure DoChanging(Item : TElTreeItem; var AllowChange: Boolean); virtual;
    procedure DoOnColumnResize(SectionIndex: integer); virtual;
    procedure DoColumnClick(SectionIndex: integer); virtual;
    procedure DoItemFocused; virtual;
    procedure DoBeginUpdate; virtual;
    procedure DoEndUpdate; virtual;
    procedure DoItemDraw(Item: TElTreeItem; Surface: TCanvas; R: TRect; SectionIndex: integer); virtual;

    procedure DoItemChange(Item: TElTreeItem; ItemChangeMode: TItemChangeMode); virtual;
    procedure DoItemExpanding(Item: TElTreeItem; var CanProcess: boolean); virtual;
    procedure DoItemCollapsing(Item: TElTreeItem; var CanProcess: boolean); virtual;
    procedure DoItemChecked(Item : TElTreeItem); virtual;
    procedure DoItemExpand(Item: TElTreeItem); virtual;
    procedure DoItemCollapse(Item: TElTreeItem); virtual;
    procedure DoItemDelete(Item: TElTreeItem); virtual;
    procedure DoCompareItems(Item1, Item2: TElTreeItem; var res: integer); virtual;
    procedure DoHeaderDraw(Header: TCustomElHeader; Canvas : TCanvas; Section: TElHeaderSection;
      Rect: TRect; Pressed: Boolean); virtual;
    procedure OnHeaderSectionChange(Sender: TCustomElHeader; Section: TElHeaderSection; Change: TSectionChangeMode); virtual;
    procedure OnHeaderSectionMove(Sender: TCustomElHeader; Section: TElHeaderSection; OldPos, NewPos: integer); virtual;
    procedure TriggerHotTrackEvent(OldItem, NewItem: TElTreeItem); virtual;

    procedure TriggerScrollEvent(ScrollBarKind: TScrollBarKind; ScrollCode: integer); virtual;
    procedure TriggerHeaderColumnMoveEvent(Section: TElHeaderSection; OldPos, NewPos: integer); virtual;
    procedure TriggerItemSaveEvent(Stream: TStream; Item: TElTreeItem); virtual;
    procedure TriggerItemLoadEvent(Stream: TStream; Item: TElTreeItem); virtual;
    procedure TriggerItemSelectedChangeEvent(Item: TElTreeItem); virtual;
    procedure DoShowHint(Item: TElTreeItem; Section : TElHeaderSection; var Text: TLMDString; HintWindow: THintWindow; MousePos: TPoint; var DoShowHint: boolean); virtual;

    procedure Paint; override;
    procedure OnHeaderSectionCreate(Header: TCustomElHeader; Section: TElHeaderSection); virtual;

    procedure TriggerHeaderLookupEvent(Section: TElHeaderSection; var Text: TLMDString); virtual;
    procedure TriggerHeaderLookupDoneEvent(Section: TElHeaderSection; Text: TLMDString;
        Accepted: boolean); virtual;
    procedure TriggerHeaderSectionExpandEvent(Section: TElHeaderSection); virtual;
    procedure TriggerHeaderSectionCollapseEvent(Section: TElHeaderSection); virtual;
    procedure TriggerMeasureItemPartEvent(Item: TElTreeItem; PartIndex: integer; var Size: TPoint); virtual;
    procedure TriggerApplyVisFilterEvent(Item: TElTreeItem; var Hidden: boolean); virtual;
    procedure TriggerItemPostDrawEvent(Canvas : TCanvas; Item : TElTreeItem; ItemRect : TRect; var DrawFocusRect : boolean); virtual;
    procedure TriggerItemPreDrawEvent(Item : TElTreeItem); virtual;

    procedure TriggerOleTargetDragEvent(State: TDragState; Source: TOleDragObject;
      Shift: TShiftState; X, Y: integer; var DragType: TDragType); virtual;
    procedure TriggerOleTargetDropEvent(Source: TOleDragObject; Shift: TShiftState;
      X, Y: integer; var DragType: TDragType); virtual;
    procedure TriggerOleDragStartEvent(var dataObj: IDataObject; var dropSource: IDropSource;
      var dwOKEffects: TDragTypes); virtual;
    procedure TriggerOleDragFinishEvent(dwEffect: TDragType; Result: HResult); virtual;
    function GetTopItem: TElTreeItem; virtual;
    procedure SetTopItem(Item: TElTreeItem); virtual;
    procedure Loaded; override;
    function SectionTypeToSortType(SectionType: TElFieldType): TSortTypes;
    procedure TriggerSortBegin; virtual;
    procedure TriggerSortEnd; virtual;
    function CreateView : TElTreeView; virtual;
    procedure CreateWnd; override;
    procedure StartDelayedFocus(FocusItemToReport : TElTreeItem);
    procedure StopDelayedFocus;
    procedure OnDelayTimer(Sender : TObject);
    procedure DoAfterSelectionChange; virtual;
    procedure SetDragRectAcceptColor(const Value: TColor);
    procedure SetDragRectDenyColor(Value: TColor);
    procedure SetDragTrgDrawMode(Value: TDragTargetDraw);
    function GetVisibleRowCount: Integer;
    procedure DoSetDragTrgDrawMode(Value: TDragTargetDraw; RedrawItem : boolean);
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure UpdateDiffItems;
    procedure SlowCompareItems(Item1, Item2: TElTreeItem; Section :
        TElHeaderSection; var Result : integer);
    procedure TriggerVirtualPropsNeeded(Item : TElTreeItem;
        PropTypes : TElVirtPropTypes; Value : TElTreeItemStaticDataEx);
    procedure TriggerVirtualTextNeeded(Item : TElTreeItem; SectionIndex : Integer;
        var Text : TLMDString); virtual;
    procedure TriggerVirtualHintNeeded(Item : TElTreeItem; var Hint : TLMDString);
        virtual;
    procedure TriggerVirtualValueNeeded(Item : TElTreeItem; SectionIndex : Integer;
        VarType : integer; var Value : Variant); virtual;
    procedure TriggerVirtualStyleNeeded(Item : TElTreeItem; SectionIndex : Integer;
        Style : TElCellStyle); virtual;

    procedure TriggerTryEditEvent(Item: TElTreeItem; SectionIndex : integer;
      var CellType: TElFieldType; var CanEdit: boolean); virtual;
    procedure TriggerInplaceEditorNeeded(Item : TElTreeItem; SectionIndex : Integer;
        SupposedFieldType : TElFieldType; var Editor : TElTreeInplaceEditor);
        virtual;
    function CreateInplaceManager: TElTreeInplaceManager; virtual;
    procedure DoEndEditItem(Item: TElTreeItem; Section: TElHeaderSection; Canceled: boolean); virtual;

    procedure VertScrollHitTestTransfer(Sender : TObject; X, Y : integer; var Part
        : TElScrollBarPart; var DefaultTest : boolean); virtual;
    procedure HorzScrollHitTestTransfer(Sender : TObject; X, Y : integer; var Part
        : TElScrollBarPart; var DefaultTest : boolean); virtual;
    procedure SetVertDivLinesColor(Value: TColor);
    procedure SetCheckBoxSize(Value: Integer);
    function GetTrackItem: TElTreeItem;
    function GetDragging: Boolean;
    procedure SetShowLeafButton(Value: Boolean);
    procedure SetLeafPicture(Value: TBitmap);
    procedure MouseWheelTransfer(Sender : TObject; Shift: TShiftState; WheelDelta:
        Integer; MousePos: TPoint; var Handled: Boolean);
    procedure MouseWheelDownTransfer(Sender : TObject; Shift: TShiftState;
        MousePos: TPoint; var Handled: Boolean);
    procedure MouseWheelUpTransfer(Sender : TObject; Shift: TShiftState; MousePos:
        TPoint; var Handled: Boolean);
    procedure FitMostChildren(Item : TElTreeItem);
    // function GetThemedClassName: TLMDThemedItem; override;
    function GetThemedElement: TThemedElement; override;

    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetThemeGlobalMode(const Value: Boolean);override;
    procedure SetThemeMode(const Value: TLMDThemeMode);override;

    function GetCheckBoxSize: Integer;
    function GetHeaderPopupMenu: TPopupMenu;
    procedure SetHeaderPopupMenu(Value: TPopupMenu);
    procedure SetHeaderFont(Value: TFont);
    procedure SetHeaderUseTreeFont(Value: Boolean);
    procedure HeaderFontChanged(Sender: TObject);
    function IsStripedColorStored: Boolean;
    function IsOwnerDrawMaskStored: Boolean;
    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure ELSettingChange(var Message: TMessage); message EL_SETTINGCHANGE;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure SetSortUseCase(Value: Boolean);
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure SetDblClickMode(Value: TElDblClickMode);
    function GetPlusPicture: TBitmap;
    function GetLeafPicture: TBitmap;
    function GetMinusPicture: TBitmap;
    function GetCheckBoxGlyph: TBitmap;
    function GetRadioButtonGlyph: TBitmap;
    procedure OnCheckSignChange(Sender: TObject);
    procedure WMUpdateSBFrame(var Message: TMessage); message WM_UPDATESBFRAME;
    procedure SetDoubleBuffered(Value: Boolean);
    procedure SetHighlightAlphaLevel(Value: Integer);
    procedure ReadRightAlignedTree(Reader : TReader);
    procedure DefineProperties(Filer : TFiler); override;
    procedure DataCacheAllocate;
    procedure DataCacheDeallocate;
    procedure DataCacheClear;
    procedure SetDataCacheSize(Value: Integer);
    function CreateDataCacheItem: TElTreeItemStaticDataEx;
    procedure CacheItem(Item : TElTreeItem; MinInCache : integer);
    function GetIncSearchColumnText(Item : TElTreeItem): TLMDString; virtual;
    procedure ResetAllItemsHeight;
    procedure ReadScrollTracking(Reader : TReader);
    procedure ReadExpandOnDblClick(Reader : TReader);
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);
    procedure SetCheckBoxFlat(Value: Boolean);
    procedure SetSortColumnColor(Value: TColor);

    property  SinglelineEllipsis: boolean read FSinglelineEllipsis write SetSinglelineEllipsis default true;
    property  MultilineEllipsis: boolean read FMultilineEllipsis write SetMultilineEllipsis default false;

    property TextColor: TColor read FTextColor write SetTextColor default clWindowText;
    property BkColor: TColor read FBkColor write SetBkColor default clWindow;

    property ShowButtons: Boolean read FShowButtons write SetButtonStyle default true;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property ShowLines: Boolean read FShowLines write SetLineStyle default true;
    property ShowImages: Boolean read FShowImages write SetImagesStyle default true;
    property ShowRoot: boolean read FShowRoot write SetRootStyle default false;
    property LineHintMode: THintModes read FShowHintMode write FShowHintMode default shmLong;
    property LineHintColor: TColor read FLineHintColor write FLineHintColor default clWindow;
    property HideSelection: Boolean read FHideSelect write SetHideSelect default false;
    property HideHintOnTimer: boolean read FHintHide write FHintHide default false;
    property Images: TCustomImageList read FImages write SetImages;
    property Images2: TCustomImageList read FImages2 write SetImages2;
    property AlphaForImages: TCustomImageList read FAlphaImages write SetAlphaImages;
    property AlphaForImages2: TCustomImageList read FAlphaImages2 write SetAlphaImages2;

    property ChangeStateImage: boolean read FChStateImage write SetChStateImage default false;
    property ShowColumns: Boolean read FShowHeader write SetShowHeader default false;
    property DragTrgDrawMode: TDragTargetDraw read FDragTrgDrawMode write
        SetDragTrgDrawMode default SelColorRect;
    property DraggableSections: Boolean read GetDraggableSections write SetDraggableSections default false; { Published }
    property SelectionMode: TSTSelModes read FSelMode write FSelMode default smUsual;

    property DoInplaceEdit: boolean read FCanEdit write SetCanEdit default true;

    property VerticalLines: boolean read FVerticalLines write SetVLines default false;
    property BarStyleVerticalLines : boolean read FBSVLines write SetBSVLines default false;
    property HorizontalLines: boolean read FHorizontalLines write SetHLines default false;
    property HorzScrollTracking: boolean read FHorzScrollTracking write FHorzScrollTracking default false;
    property VertScrollTracking: boolean read FVertScrollTracking write FVertScrollTracking default false;
    property HotTrack: Boolean read FTracking write FTracking default true;
    property Tracking: boolean read FTracking write FTracking default true;
    property RowSelect: boolean read FRowSelect write SetRowSelect default true;
    property MultiSelect: boolean read FMultiSelect write SetMultiSelect default true;
    property MultiSelectLevel: Integer read FMultiSelectLevel write SetMultiSelectLevel default -1; // CNS
    property LineHeight: integer read FLineHeight write SetLineHeight nodefault;
    property AutoLineHeight: boolean read FAutoLineHeight write SetAutoLineHeight default true;
    property HeaderHotTrack: boolean read FHeaderHotTrack write SetHeaderHotTrack default true;
    property HeaderSections: TElHeaderSections read GetHeaderSections write SetHeaderSections;
    property HeaderHeight: integer read GetHeaderHeight write SetHeaderHeight nodefault;
    property MainTreeColumn: integer read FMainTreeCol write SetMainTreeCol default 0;
    property OwnerDrawByColumn: boolean read FODFollowCol write FODFollowCol default true;
    property OwnerDrawMask: TLMDString read FODMask write FODMask stored IsOwnerDrawMaskStored;
    property DragAllowed: Boolean read FDragAllowed write FDragAllowed default false;
    property SortDir: TSortDirs read FSortDir write FSortDir default sdAscend;
    property SortMode: TSortModes read FSortMode write SetSortMode default smNone; { Published }
    property SortSection: Integer read FSortSection write SetSortSection default 0; { Published }
    property SortType: TSortTypes read FSortType write FSortType default stText;
    property HideHintOnMove: Boolean read FHideHintOnMove write FHideHintOnMove default true; { Protected }
    property MoveColumnOnDrag: Boolean read GetMoveColumnOnDrag write SetMoveColumnOnDrag default false; { Published }
    property HideHorzScrollBar: Boolean read FHideHorzScrollBar write SetHideHorzScrollBar default false; { Published }
    property HideVertScrollBar: Boolean read FHideVertScrollBar write SetHideVertScrollBar default false; { Published }
    property HorzScrollBarStyles : TElScrollBarStyles read FHorzScrollBarStyle write SetHorzScrollBarStyle stored true;
    property VertScrollBarStyles : TElScrollBarStyles read FVertScrollBarStyle write SetVertScrollBarStyle stored true;

    property Background : TBitmap read FBackground write SetBackground;  { Protected }
    property BackgroundType : TLMDBackgroundType read FBackgroundType write SetBackgroundType default bgtColorFill;  { Protected }
    property HeaderImages: TCustomImageList read GetHeaderImages write SetHeaderImages; { Protected }
    property AlphaForHeaderImages: TCustomImageList read GetAlphaHeaderImages write SetAlphaHeaderImages; { Protected }
    property DragImageMode: TDragImgMode read FDragImageMode write FDragImageMode default dimNever; { Protected }
    property StoragePath     : string read FStoragePath write FStoragePath;

    property Storage         : TElIniFile read FStorage write SetStorage;

    property ImageForm       : TElImageForm read FImgForm write SetImageForm;
    property HeaderImageForm : TElImageForm read GetHeaderImageForm write SetHeaderImageForm;
    property ShowCheckBoxes: Boolean read FShowCheckboxes write SetShowCheckboxes default false;
    property PlusPicture: TBitmap read GetPlusPicture write SetPlusPicture;
    property MinusPicture: TBitmap read GetMinusPicture write SetMinusPicture;
    property CustomPlusMinus: Boolean read FCustomPlusMinus write SetCustomPlusMinus default false;
    property SelectColumn: Integer read FSelectColumn write SetSelectColumn default -1;
    property AutoExpand: Boolean read FAutoExpand write SetAutoExpand default false;
    property AutoLookup: Boolean read FAutoLookup write FAutoLookup default false;
    property DragType: TElDragType read FDragType write SetDragType default dtDelphi;
    property FullRowSelect: Boolean read FFullRowSelect write FFullRowSelect default true;
    property AlwaysKeepSelection: Boolean read FAlwaysKeepSelection write FAlwaysKeepSelection default true;
    property AlwaysKeepFocus: Boolean read FAlwaysKeepFocus write FAlwaysKeepFocus default false;
    property StickyHeaderSections: Boolean read GetStickyHeaderSections write SetStickyHeaderSections default false;
    property BarStyle: Boolean read FBarStyle write SetBarStyle default false;
    property DrawFocusRect: Boolean read FDrawFocusRect write SetDrawFocusRect default true;
    property DeselectChildrenOnCollapse: Boolean read FDeselectChildrenOnCollapse write FDeselectChildrenOnCollapse default false;
    property HorzDivLinesColor: TColor read FHorzDivLinesColor write
        SetHorzDivLinesColor default clBtnFace;
    property LinesColor: TColor read FLinesColor write SetLinesColor default clBtnFace;
    property LinesStyle: TPenStyle read FLinesStyle write SetLinesStyle default psDot;
    property PathSeparator: Char read FPathSeparator write FPathSeparator default '\'; { Protected }
    property RightAlignedView: Boolean read FRightAlignedView write SetRightAlignedView default false;
    property Flat: Boolean read FFlat write SetFlat default false; { Protected }
    property RightAlignedText: Boolean read FRightAlignedText write SetRightAlignedText default false;
    property FilteredVisibility: Boolean read FFilteredVisibility write SetFilteredVisibility default false;
    property UnderlineTracked: Boolean read FUnderlineTracked write SetUnderlineTracked default true; { Published }
    property CustomCheckboxes: Boolean read FCustomCheckboxes write SetCustomCheckboxes default false; { Published }
    property CheckBoxGlyph: TBitmap read GetCheckBoxGlyph write SetCheckBoxGlyph;
    property RadioButtonGlyph: TBitmap read GetRadioButtonGlyph write
        SetRadioButtonGlyph;
    property ScrollbarOpposite: Boolean read FScrollbarOpposite write SetScrollbarOpposite default False;
    property ShowRootButtons: Boolean read FShowRootButtons write SetShowRootButtons default true;
    property ShowEmptyImages : Boolean read FShowEmptyImages write SetShowEmptyImages default false;
    property ShowEmptyImages2: Boolean read FShowEmptyImages2 write SetShowEmptyImages2 default false;

    property HideFocusRect: Boolean read FHideFocusRect write SetHideFocusRect default false;
    property LockHeaderHeight: Boolean read GetLockHeaderHeight write SetLockHeaderHeight default false; { Protected }
    property AutoResizeColumns : Boolean read FAutoResizeColumns write FAutoResizeColumns default True;  { Protected }
    property HeaderActiveFilterColor : TColor read GetHeaderActiveFilterColor write SetHeaderActiveFilterColor default clBlack;
    property HeaderFilterColor : TColor read GetHeaderFilterColor write SetHeaderFilterColor default clBtnText;
    property HeaderFlat : Boolean read GetHeaderFlat write SetHeaderFlat default false;

    property HeaderWrapCaptions : Boolean read GetHeaderWrapCaptions write SetHeaderWrapCaptions default false;

    property FlatFocusedScrollbars : Boolean read FFlatFocusedScrollbars write SetFlatFocusedScrollbars default true;  { Protected }
    property HideSelectColor: TColor read FHideSelectColor write SetHideSelectColor default clBtnFace;
    property FocusedSelectColor: TColor read FFocusedSelectColor write SetFocusedSelectColor default clHighlight;
    property HideSelectTextColor: TColor read FHideSelectTextColor write SetHideSelectTextColor default LMDElHideSelectTextColor;
    property FocusedSelectTextColor: TColor read FFocusedSelectTextColor write SetFocusedSelectTextColor default clHighlightText;

    property UseCustomScrollBars : boolean read FUseCustomBars write SetUseStdBars default true;

    property RowHotTrack : Boolean read FRowHotTrack write SetRowHotTrack default false;  { Protected }
    property ActiveBorderType : TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;  { Protected }
    property InactiveBorderType : TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;  { Protected }
    property ItemIndent : integer read ItemExt write SetItemIndent default 17;

    property GradientStartColor : TColor read FGradientStartColor write SetGradientStartColor default clBlack;  { Protected }
    property GradientEndColor : TColor read FGradientEndColor write SetGradientEndColor  default clBlack;  { Protected }
    property GradientSteps : Integer read FGradientSteps write SetGradientSteps default 64;  { Protected }

    property Cursor : TCursor read GetCursor write SetCursor default crDefault;
    property HeaderInvertSortArrows : Boolean read GetHeaderInvertSortArrows write SetHeaderInvertSortArrows default false;  { Protected }
    property MoveFocusOnCollapse : Boolean read FMoveFocusOnCollapse write SetMoveFocusOnCollapse default false;  { Protected }
    property ForcedScrollBars : TScrollStyle read FForcedScrollBars write SetForcedScrollBars default ssNone;  { Protected }
    property PlusMinusTransparent : boolean read FTransButtons write SetTransButtons default false;
    property Hint: TLMDString read GetHint write SetHint;
    property DragRectAcceptColor: TColor read FDragRectAcceptColor write
        SetDragRectAcceptColor default clGreen;
    property DragRectDenyColor: TColor read FDragRectDenyColor write
        SetDragRectDenyColor default clRed;
    property DragExpandDelay: Integer read FDragExpandDelay write FDragExpandDelay
        default 500;
    property IncrementalSearchTimeout : integer read FIncrementalSearchTimeout write FIncrementalSearchTimeout default 500;
    property IncrementalSearch: Boolean read FIncrementalSearch write
        FIncrementalSearch default False;
    property AdjustMultilineHeight : Boolean read FAdjustMultilineHeight write SetAdjustMultilineHeight default true;  { Protected }
    property ExpandOnDragOver : Boolean read FExpandOnDragOver write FExpandOnDragOver default false;  { Protected }
    property DragCursor : TCursor read GetDragCursor write SetDragCursor default crDrag;
    property TrackColor : TColor read FTrackColor write SetTrackColor default clHighlight;
    property UseSystemHintColors : Boolean read FUseSystemHintColors write FUseSystemHintColors default false;  { Protected }
    property HeaderColor : TColor read GetHeaderColor write SetHeaderColor default clBtnFace;
    property ChangeDelay: Integer read FChangeDelay write FChangeDelay default 500;
    property RightClickSelect: Boolean read FRightClickSelect write
        FRightClickSelect default true;
    property StripedOddColor: TColor read FStripedOddColor write SetStripedOddColor stored IsStripedColorStored;
    property StripedEvenColor: TColor read FStripedEvenColor write SetStripedEvenColor stored IsStripedColorStored;
    property StripedItems: Boolean read FStripedItems write SetStripedItems default false;
    property OnInplaceEditorNeeded: TInplaceEditorNeededEvent read
        FOnInplaceEditorNeeded write FOnInplaceEditorNeeded;
    property QuickEditMode: Boolean read FQuickEditMode write FQuickEditMode
        default false;
    property MainTextType: TElFieldType read FMainTextType write FMainTextType
        default sftText;
    property HintType: TElHintType read FHintType write FHintType
        default shtHintOrText;
    property OnVertScrollHitTest: TElScrollHitTestEvent read FOnVertScrollHitTest
        write FOnVertScrollHitTest;
    property OnHorzScrollHitTest: TElScrollHitTestEvent read FOnHorzScrollHitTest
        write FOnHorzScrollHitTest;
    property MouseFrameVisible: Boolean read FMouseFrameVisible write
        FMouseFrameVisible default true;
    property MouseFrameSelect: Boolean read FMouseFrameSelect write
        FMouseFrameSelect default true;
    property VertDivLinesColor: TColor read FVertDivLinesColor write
        SetVertDivLinesColor default clBtnFace;

    property OnItemChange: TOnItemChangeEvent read FOnItemChange write FOnItemChange;
    property OnItemDraw: TOnItemDrawEvent read FOnItemDraw write FOnItemDraw;
    property OnItemChecked  : TOnItemCheckedEvent read FOnItemChecked write FOnItemChecked;
    property OnItemExpand: TOnItemExpandEvent read FOnItemExpand write FOnItemExpand;
    property OnItemCollapse: TOnItemExpandEvent read FOnItemCollapse write FOnItemCollapse;
    property OnItemExpanding: TOnItemExpanding read FOnItemExpanding write FOnItemExpanding;
    property OnItemCollapsing: TOnItemExpanding read FOnItemCollapsing write FOnItemCollapsing;
    property OnScroll: TElScrollEvent read FOnScroll write FOnScroll;
    property OnItemDeletion: TOnItemExpandEvent read FOnItemDelete write FOnItemDelete;
    property OnChanging: TElTreeChangingEvent read FOnChanging write FOnChanging;
    property OnItemFocused: TNotifyEvent read FOnItemFocused write FOnItemFocused;
    property OnBeginUpdate: TNotifyEvent read FOnBeginUpdate write FOnBeginUpdate;
    property OnEndUpdate: TNotifyEvent read FOnEndUpdate write FOnEndUpdate;
    property OnShowLineHint: TOnShowHintEvent read FOnShowHint write FOnShowHint;
    property OnCompareItems: TOnCompareItems read FOnCompareItems write FOnCompareItems;
    property OnItemPicDraw: TOnPicDrawEvent read FOnItemPicDraw write FOnItemPicDraw;
    property OnItemPicDraw2: TOnPicDrawEvent read FOnItemPicDraw2 write FOnItemPicDraw2;
    property OnHotTrack: THotTrackEvent read FOnHotTrack write FOnHotTrack;

    property OnCanDrag: TElCanDragEvent read GetCanDrag write SetCanDrag;

    property OnTryEdit: TTryEditEvent read FOnTryEdit write FOnTryEdit;

    property OnEndEditItem: TOnEndEditEvent read FOnEndEdit write FOnEndEdit;

    property OnItemSave: TElItemSaveEvent read FOnItemSave write FOnItemSave;
    property OnItemLoad: TElItemSaveEvent read FOnItemLoad write FOnItemLoad;
    property OnItemSelectedChange: TItemSelChangeEvent read FOnItemSelectedChange write FOnItemSelectedChange;
    property OnCellStyleSave: TElCellStyleSaveEvent read FOnSave write FOnSave;
    property OnCellStyleLoad: TElCellStyleSaveEvent read FOnLoad write FOnLoad;
    property OnSortBegin : TNotifyEvent read FOnSortBegin write FOnSortBegin;
    property OnSortEnd : TNotifyEvent read FOnSortEnd write FOnSortEnd;

    property OnHeaderResize: TNotifyEvent read FOnHeaderResize write FOnHeaderResize;
    property OnHeaderLookup: TElHeaderLookupEvent read FOnHeaderLookup write FOnHeaderLookup;
    property OnHeaderLookupDone: TElHeaderLookupDoneEvent read FOnHeaderLookupDone write FOnHeaderLookupDone;
    property OnHeaderSectionExpand: THeaderSectionEvent read FOnHeaderSectionExpand write FOnHeaderSectionExpand;
    property OnHeaderSectionCollapse : THeaderSectionEvent read FOnHeaderSectionCollapse write FOnHeaderSectionCollapse;
    property OnHeaderSectionAutoSize : TColumnNotifyEvent read FOnSectionAutoSize write FOnSectionAutoSize;
    property OnHeaderColumnResize: TColumnNotifyEvent read FOnColumnResize write FOnColumnResize;
    property OnHeaderColumnClick: TColumnNotifyEvent read FOnColumnClick write FOnColumnClick;
    property OnHeaderColumnMove: TElColumnMoveEvent read FOnHeaderColumnMove write FOnHeaderColumnMove;
    property OnHeaderColumnDraw: TElSectionRedrawEvent read FOnColumnDraw write FOnColumnDraw;
    property OnHeaderSectionFilterCall : TColumnNotifyEvent read FOnSectionFilterCall write FOnSectionFilterCall;
    property OnHeaderSectionMeasure : TMeasureSectionEvent read FOnHeaderSectionMeasure write FOnHeaderSectionMeasure;
    property OnApplyVisFilter: TApplyVisFilterEvent read FOnApplyVisFilter write FOnApplyVisFilter;
    property OnItemPostDraw : TElTreeItemPostDrawEvent read FOnItemPostDraw write FOnItemPostDraw;
    property OnMeasureItemPart: TMeasureItemPartEvent read FOnMeasureItemPart write FOnMeasureItemPart;

    property OnHTMLImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnHTMLImageNeededEx : TLMDHTMLImageNeededEvent read FOnImageNeededEx write FOnImageNeededEx;
    property OnLinkClick : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnLinkOver : TElHTMLLinkOverEvent read FOnLinkOver write FOnLinkOver;
    property LinkCursor: TCursor read FLinkCursor write FLinkCursor default crHandPoint;
    property LinkColor : TColor read FLinkColor write SetLinkColor default clBlue;  { Published }
    property LinkStyle : TFontStyles read FLinkStyle write SetLinkStyle default [fsUnderline];  { Published }

    property OnClick : TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick : TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnDragDrop : TDragDropEvent read FOnDrop write FOnDrop;
    property OnDragOver : TDragOverEvent read FOnOver write FOnOver;
    //property OnEndDrag : TEndDragEvent read FOnDrag write FOnDrag;
    property OnEnter : TNotifyEvent read FOnEnter write FOnEnter;
    property OnExit : TNotifyEvent read FOnExit write FOnExit;
    property OnKeyDown : TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyPress : Tkeypressevent read FOnKeyPress write FOnKeyPress;
    property OnKeyUp : TKeyEvent read FOnKeyUp write FOnKeyUp;
    property OnMouseDown : TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseMove : TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property OnMouseUp : TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnStartDrag : TStartDragEvent read FOnStartDrag write FOnStartDrag;

    property OnOleTargetDrag: TTargetDragEvent read FOnOleTargetDrag write FOnOleTargetDrag;
    property OnOleTargetDrop: TTargetDropEvent read FOnOleTargetDrop write FOnOleTargetDrop;
    property OnOleDragStart: TOleDragStartEvent read FOnOleDragStart write FOnOleDragStart;
    property OnOleDragFinish: TOleDragFinishEvent read FOnOleDragFinish write FOnOleDragFinish;

    property OnHorzScrollDrawPart : TElScrollDrawPartEvent read FOnHorzScrollDrawPart write FOnHorzScrollDrawPart;
    property OnHorzScrollHintNeeded : TElScrollHintNeededEvent read FOnHorzScrollHintNeeded write FOnHorzScrollHintNeeded;
    property OnVertScrollDrawPart : TElScrollDrawPartEvent read FOnVertScrollDrawPart write FOnVertScrollDrawPart;
    property OnVertScrollHintNeeded : TElScrollHintNeededEvent read FOnVertScrollHintNeeded write FOnVertScrollHintNeeded;

    property OnHeaderMouseDown: TMouseEvent read FOnHeaderMouseDown write
        FOnHeaderMouseDown;
    property OnAfterSelectionChange: TNotifyEvent read FOnAfterSelectionChange
        write FOnAfterSelectionChange;
    property OnItemPreDraw: TOnItemExpandEvent read FOnItemPreDraw write
        FOnItemPreDraw;
    property OnDragTargetChange: TElTreeItemDragTargetEvent read
        FOnDragTargetChange write FOnDragTargetChange;
    property LineHintTimeout: Integer read FLineHintTimeout write
        SetLineHintTimeout default 3000;
    property VerticalLinesLong: Boolean read FVerticalLinesLong write
        SetVerticalLinesLong default true;
    property DefaultSectionWidth: Integer read GetDefaultSectionWidth write
        SetDefaultSectionWidth default DefaultHeaderSectionWidth;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides default [ebsLeft, ebsRight, ebsTop, ebsBottom];
    property LineHintType: TLineHintType read FLineHintType write FLineHintType
        default lhtSmart;
    property OnVirtualPropsNeeded: TVirtualPropsNeededEvent read FOnVirtualPropsNeeded write FOnVirtualPropsNeeded;
    property OnVirtualTextNeeded: TVirtualTextNeededEvent read FOnVirtualTextNeeded
        write FOnVirtualTextNeeded;
    property VirtualityLevel: TVirtualityLevel read FVirtualityLevel write
        SetVirtualityLevel default vlNone;
    property OnVirtualHintNeeded: TVirtualHintNeededEvent read FOnVirtualHintNeeded
        write FOnVirtualHintNeeded;
    property OnVirtualValueNeeded: TVirtualValueNeededEvent read
        FOnVirtualValueNeeded write FOnVirtualValueNeeded;
    property OnVirtualStyleNeeded: TVirtualStyleNeededEvent read
        FOnVirtualStyleNeeded write FOnVirtualStyleNeeded;
    property CheckBoxSize: Integer read GetCheckBoxSize write SetCheckBoxSize
        default 15;
    property DragScrollInterval: Integer read FDragScrollInterval write
        FDragScrollInterval default 100;
    property ShowLeafButton: Boolean read FShowLeafButton write SetShowLeafButton default False;
    property LeafPicture: TBitmap read GetLeafPicture write SetLeafPicture;
    property ExplorerEditMode: Boolean read FExplorerEditMode write
        FExplorerEditMode default False;
    property IgnoreEnabled: Boolean read FIgnoreEnabled write FIgnoreEnabled default False;

    property InplaceEditorDelay: Integer read FInplaceEditorDelay write
        FInplaceEditorDelay default 500;
    property HeaderFont: TFont read FHeaderFont write SetHeaderFont stored IsHeaderFontStored;
    property HeaderUseTreeFont: Boolean read FHeaderUseTreeFont write
        SetHeaderUseTreeFont default true;
    property KeepSelectionWithinLevel: Boolean read FKeepSelectionWithinLevel write
        FKeepSelectionWithinLevel default False;
    property AutoCollapse: Boolean read FAutoCollapse write FAutoCollapse default
        false;
    property SortUseCase: Boolean read FSortUseCase write SetSortUseCase default
        true;
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor default clBlack;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor default clBlack;
    property DblClickMode: TElDblClickMode read FDblClickMode write SetDblClickMode
        default dcmExpand;
{$IFDEF HOTTRACK_CURSOR}
    property TrackingCursor: TCursor read FTrackingCursor write FTrackingCursor default crDefault;
{$ENDIF}

    property HighlightAlphaLevel : Integer read FHighlightAlphaLevel write
        SetHighlightAlphaLevel default 255;

    property DataCacheSize: Integer read FDataCacheSize write SetDataCacheSize
        default 200;
    property IncrementalSearchScope: TElIncSearchScope read FIncrementalSearchScope
        write FIncrementalSearchScope default issWholeTree;
    property IncrementalSearchColumn: TElIncSearchColumn read
        FIncrementalSearchColumn write FIncrementalSearchColumn default iscMainText;
    property CheckBoxFlat: Boolean read FCheckBoxFlat write SetCheckBoxFlat default
        false;
    property HorzArrowsScroll: Boolean read FHorzArrowsScroll write
        FHorzArrowsScroll default false;
    property SortColumnColor: TColor read FSortColumnColor write SetSortColumnColor default clNone;
    procedure EnsureVisibleEx(Item: TElTreeItem; Expande: Boolean);
    procedure EnsureVisibleBottomEx(Item: TElTreeItem; Expande: Boolean);
    procedure Init; // to avoid error about call virtual constructor from another constructor

    public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    constructor CreateClass(AOwner: TComponent; ItemClass : TElTreeItemClass);
    destructor Destroy; override;
    procedure Update; override;
    procedure Assign(Source: TPersistent); override;
    procedure FullCollapse; virtual;
    procedure FullExpand; virtual;
{$warnings off}
    function CanFocus : boolean; override;
{$warnings on}
    function GetDragImages: TDragImageList; override;
    function Focused: Boolean;  override;
    function GetItemRect(ItemIndex: integer): TRect; virtual;
    function GetItemAtY(Y: integer): TElTreeItem; virtual;
    function GetItemAt(X, Y: Integer; var ItemPart: TSTItemPart;
      var HitColumn: integer): TElTreeItem; virtual;
    procedure MeasureCell(Item : TElTreeItem; ColumnNum : integer; MaxWidth :
        integer; var Size : TPoint); virtual;
    function GetNextSelected(Prev: TElTreeItem): TElTreeItem; virtual;
    procedure AllSelected(SelectedItems: TLMDObjectList); virtual;
    procedure SelectAll; virtual;
    procedure InvertSelection; virtual;
    procedure SelectAllEx(IncludeHidden: boolean); virtual;
    procedure InvertSelectionEx(IncludeHidden: boolean); virtual;
    procedure DeselectAll; virtual;
    procedure DeselectAllEx(IncludeHidden: boolean); virtual;
    procedure SelectRange(FromItem, ToItem: TElTreeItem); virtual;
    procedure SelectRange2(FromItem, ToItem: TElTreeItem; SelectDisabled : boolean; SelectCollapsedChildren : boolean); virtual;
    procedure SelectRangeEx(FromItem, ToItem: TElTreeItem; IncludeHidden : boolean); virtual;
    procedure SelectRangeEx2(FromItem, ToItem: TElTreeItem; IncludeHidden, SelectDisabled, SelectCollapsedChildren : boolean); virtual;
    procedure Sort(recursive: boolean); virtual;

    procedure Save; virtual;
    procedure Restore; virtual;

    procedure EnsureVisible(Item: TElTreeItem);
    procedure EnsureVisibleBottom(Item: TElTreeItem);

    function IsEditing: boolean;
    procedure EditItem(Item: TElTreeItem; SectionNum: integer); virtual;
    procedure EndEdit(ByCancel: boolean);

    procedure SaveStringsToStream(Stream: TStream); virtual;
    function GetNodeAt(X, Y: integer): TElTreeItem;
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    function IsInView(Item: TElTreeItem): Boolean; virtual;
    function MeasureColumnWidth(ColumnNum: integer; VisibleOnly : boolean): integer;
    function IndexInView(Item : TElTreeItem): Integer;
    procedure AllSelectedEx(SelectedItems : TLMDObjectList; Order : boolean);
    procedure AddSortSection(Index : Integer; ReSort : boolean);
    procedure RemoveSortSection(Index : Integer; ReSort : boolean);
    procedure ClearSortList(ReSort : boolean);
    procedure AutoSizeAllColumns;
    procedure AutoSizeColumn(SectionIndex : integer);

    procedure AutoSizeAllColumnsEx(VisibleOnly : boolean);
    procedure AutoSizeColumnEx(SectionIndex : integer; VisibleOnly : boolean);

    // procedure SetColumnBestWidth(ColumnNum: integer; VisibleOnly: boolean)

    function MeasureCellText(Item : TElTreeItem; ColumnNum : integer; MaxWidth :
        integer; var Size : TPoint): Boolean; virtual;
    procedure ResetUpdateCounter;

    property TopIndex: integer read FTopIndex write SetVPosition;

    property BottomIndex: integer read FBottomIndex;
    property IsUpdating: boolean read GetUpdating write SetUpdating;
    property Items: TElTreeItems read FItems write SetItems;
    property ItemFocused: TElTreeItem read GetFocused write SetFocused;
    property SelectedCount: integer read GetSelCount;
    property FireFocusEvents: boolean read GetFireFocusEvents write SetFireFocusEvents default true;

    property Selected: TElTreeItem read GetSelected write SetSelected;
    property TopItem: TElTreeitem read GetTopItem write SetTopItem;
    property DragObject : TDragObject read FDragObject;
    property View : TElTreeView read FView;
    property HorzScrollBarVisible : boolean read FHScrollVisible;
    property VertScrollBarVisible : boolean read FVScrollVisible;

    property LockedHeaderSection : TElHeaderSection read GetLockedHeaderSection write SetLockedHeaderSection;  { Public }
    property VisibleRowCount: Integer read GetVisibleRowCount;

    property DropTarget: TElTreeItem read GetDropTarget;
    property HScrollBar: TElScrollBar read FHScrollBar;  (*<+>*)
    property VScrollBar : TElScrollBar read FVScrollBar;  (*<+>*)
    property TrackItem: TElTreeItem read GetTrackItem;

    property SortSectionToCompare: Integer read FSortSectionToCompare;
    property UseThemeForSelection: Boolean read FUseThemeForSelection write SetUseThemeForSelection default false;
  published
    property LeftPosition: integer read FHPos write SetHPosition default 0;
    property BevelKind : TBevelKind read FBevelKindDummy write FBevelKindDummy stored false default bkNone;

    property HeaderPopupMenu: TPopupMenu read GetHeaderPopupMenu write
        SetHeaderPopupMenu;
    property DoubleBuffered: Boolean read FDoubleBuffered write SetDoubleBuffered
        default true;
    property DoubleBufferedOnResize: Boolean read FDoubleBufferedOnResize write
        FDoubleBufferedOnResize default true;
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;
    property BorderColorWindow: TColor read FBorderColorWindow write
        SetBorderColorWindow default clWindow;
  end;

  TElTree = class(TCustomElTree)
  published
    property UseThemeForSelection;
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

    property BarStyle;
    property BarStyleVerticalLines;
    property BorderStyle;
    property BorderSides;
    property ChangeDelay;
    property ChangeStateImage;
    property CheckBoxFlat;
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
    property HorzArrowsScroll;
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
    property IncrementalSearchColumn;
    property IncrementalSearchTimeout;
    property InplaceEditorDelay;
    property ItemIndent;
    property Items;
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
    property MultilineEllipsis;
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
    property SinglelineEllipsis;
    property SelectionMode;
    property SortColumnColor;
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

    property TabOrder;
    property TabStop default True;
    property Tracking;
    property TrackColor;
    property UnderlineTracked;
    property UseCustomScrollBars;

    property VertDivLinesColor;
    property VerticalLines;
    property VerticalLinesLong;
    property VertScrollBarStyles;
    property VirtualityLevel;
    property Visible;
    property UseSystemHintColors;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
    property TextColor;
    property BkColor;

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
    property OnBeginUpdate;
    property OnEndUpdate;
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
    property OnCanDrag;
    property OnHTMLImageNeeded;
    property OnHTMLImageNeededEx;
    property OnLinkClick;
    property OnLinkOver;
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

type

  TElTreeDragObject = class(TDragControlObject)
  protected
    public
    procedure Finished(Target: TObject; X, Y: Integer; Accepted: Boolean); override;
    function GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor; override;
    destructor Destroy; override;
  end;

const
  FDivLineWidth = 1;
  CheckMargin   = 2;
  CheckBoxSize  = 15;

  // CNS
  crDragSingleNo    = 20001;
  crDragSingleMove  = 20002;
  crDragSingleCopy  = 20003;
  {
  crDragMultiNo     = 20004;
  crDragMultiMove   = 20005;
  crDragMultiCopy   = 20006;
  }

const MultiLineFlags : array[boolean] of integer = (DT_SINGLELINE, DT_ELCUSTOMDRAW);
      WordWrapFlags : array[boolean, boolean] of integer = ((0, 0), (0, DT_WORDBREAK));
      //MultiLineEllipseFlags : array[boolean] of integer = (DT_END_ELLIPSIS, 0);

var LeafBmp,
    PlusBmp,
    MinusBmp : TBitmap;

implementation

uses
  ElStack, LMDGraphUtils;

type PBoolean = ^Boolean;

type
     TElHeaderHack = class (TCustomElHeader)
     public
       property IsDesigning;
     end;

     TElScrollBarHack = class(TElScrollBar)
     public
       property IsDesigning;
     end;

(*
function GetErrorMsg(ID: integer): string;
var
  p: pchar;
begin
  GetMem(p, 260);
  LoadString(HInstance, ID, p, 260);
  result := StrPas(p);
  FreeMem(p, 260);
end;
*)

procedure ChangeButtonColors(AButton : TBitmap);
var i, j : integer;
begin
  for i := 0 to AButton.Width -1 do
  begin
    for j := 0 to AButton.Height -1 do
    begin
      case AButton.Canvas.Pixels[i, j] of
        clDkGray: AButton.Canvas.Pixels[i, j]:= GetSysColor(COLOR_3DSHADOW);//GetSysColor(COLOR_BTNSHADOW);
        clBlack: AButton.Canvas.Pixels[i, j] := GetSysColor(COLOR_WINDOWTEXT);
        clWhite: AButton.Canvas.Pixels[i, j] := GetSysColor(COLOR_WINDOW);
      end;
    end;
  end;
end;

procedure DrawFlatCheckboxFrame(Tree : TCustomElTree; DC : HDC; R : TRect; Enabled : boolean);
var AColor, Color : TColor;
begin
  //with Tree do
  begin
    if ((Tree.Focused or Tree.FMouseOver) and (Tree.ActiveBorderType = fbtColorLineBorder)) or
       ((not (Tree.Focused or Tree.FMouseOver)) and (Tree.InactiveBorderType = fbtColorLineBorder)) then
    begin
      if Enabled then
        Color := clWindow
      else
        Color := clBtnFace;
      if Tree.Focused or Tree.FMouseOver then
        AColor := Tree.LineBorderActiveColor
      else
        AColor := Tree.LineBorderInactiveColor;
      ELVCLUtils.DrawFlatFrameEx2(DC, R, AColor, Color, false, true, AllBorderSides, fbtColorLineBorder, Tree.FBorderColorFace, Tree.FBorderColorDkShadow, Tree.FBorderColorShadow, Tree.FBorderColorHighlight, Tree.FBorderColorWindow);
    end
    else
      ElVCLUtils.DrawFlatFrame(DC, R, clBtnFace, false);
  end;
end;

procedure DrawFlatRadioButtonFrame(Tree : TCustomElTree; DC : HDC; R : TRect; Enabled : boolean);
var
  i : integer;
  Color : TColor;
  AColor: TColor;

const
  points : array[0..27] of TPoint = ((x : 1; y : 4), (x : 1; y : 5), (x : 1; y : 6), (x : 1; y : 7),
    (x : 2; y : 2), (x : 2; y : 3), (x : 2; y : 8),
    (x : 3; y : 2), (x : 4; y : 1), (x : 5; y : 1), (x : 6; y : 1), (x : 7; y : 1),
    (x : 8; y : 2), (x : 9; y : 2),

    (x : 2; y : 9), (x : 3; y : 9),
    (x : 4; y : 10), (x : 5; y : 10), (x : 6; y : 10), (x : 7; y : 10),
    (x : 8; y : 9), (x : 9; y : 9), (x : 9; y : 8),
    (x : 10; y : 7), (x : 10; y : 6), (x : 10; y : 5),
    (x : 10; y : 4), (x : 9; y : 3)
    );

  Apoints : array[0..31] of TPoint = ((x : 0; y : 4), (x : 0; y : 5), (x : 0; y : 6), (x : 0; y : 7),
    (x : 1; y : 2), (x : 1; y : 3), (x : 1; y : 8), (x : 1; y : 9),

    (x : 2; y : 1), (x : 3; y : 1), (x : 4; y : 0), (x : 5; y : 0), (x : 6; y : 0), (x : 7; y : 0),
    (x : 8; y : 1), (x : 9; y : 1),

    (x : 2; y : 10), (x : 3; y : 10),
    (x : 4; y : 11), (x : 5; y : 11), (x : 6; y : 11), (x : 7; y : 11),
    (x : 8; y : 10), (x : 9; y : 10),
    (x : 10; y : 9), (x : 10; y : 8),
    (x : 11; y : 7), (x : 11; y : 6), (x : 11; y : 5), (x : 11; y : 4),
    (x : 10; y : 3), (x : 10; y : 2)
    );

begin
  if ((Tree.Focused or Tree.FMouseOver) and (Tree.ActiveBorderType = fbtColorLineBorder)) or
     ((not (Tree.Focused or Tree.FMouseOver)) and (Tree.InactiveBorderType = fbtColorLineBorder)) then
  begin
    if Enabled then
      Color := clWindow
    else
      Color := clBtnFace;

    if Tree.Focused or Tree.FMouseOver then
      AColor := Tree.LineBorderActiveColor
    else
      AColor := Tree.LineBorderInactiveColor;

    for i := 0 to 27 do
    begin
      SetPixel(DC, R.Left + Points[i].x + 1, R.Top + Points[i].y, ColorToRGB(Color));
    end;
    for i := 0 to 31 do
    begin
      SetPixel(DC,  R.Left + APoints[i].x + 1, R.Top + APoints[i].y, ColorToRGB(AColor));
    end;
  end
  else
  begin
    if Enabled then
      AColor := clWindow
    else
      AColor := clBtnFace;
    for i := 0 to 27 do
    begin
      SetPixel(DC,  R.Left + Points[i].x + 1, R.Top + Points[i].y, ColorToRGB(AColor));
    end;
  end;
end;

function TElTreeDragObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
var {
     FTree      : TCustomElTree;
     IsDragMulti,
    }
    IsDragCopy : Boolean;
begin
  if (Control is TCustomElTree) then
  begin
    IsDragCopy  := ((GetKeyState(VK_CONTROL) and $8000) = $8000);
    {
    FTree := TCustomElTree(Control);
    IsDragMulti := (FTree.SelectedCount > 1);
    if IsDragMulti then
    begin
      if not Accepted then
        result := crDragMultiNo
      else
      if IsDragCopy then
        result := crDragMultiCopy // Ctrl key down
      else
        result := crDragMultiMove;
    end
    else
    }
    begin
      if not Accepted then
        result := crDragSingleNo
      else
      if IsDragCopy then
        result := crDragSingleCopy // Ctrl key down
      else
        result := crDragSingleMove;
    end;
  end
  else
    result := inherited GetDragCursor(Accepted, X, Y);
end;

procedure TElTreeDragObject.Finished;
begin
  inherited;
  Free;
end;

destructor TElTreeDragObject.Destroy;
begin
  inherited;
end;

// ****************************************************************************
//                            TElCellControl
// ****************************************************************************

procedure TElCellControl.Update;
begin
  if Visible and (Owner <> nil) then Owner.Update;
end;

constructor TElCellControl.Create;
begin
  inherited Create(nil);
  FVisible := true;
  FEnabled := true;
  FFont := TFont.Create;
  FFont.Color := clBtnText;
  FFont.OnChange := FontChanged;
end;

destructor TElCellControl.Destroy;
begin
  FFont.Free;
  if Owner <> nil then
  begin
    Owner.FControl := nil;
    Owner.Update;
  end;
  inherited;
end;

procedure TElCellControl.SetCaption(newValue: TLMDString);
{ Sets data member FCaption to newValue. }
begin
  if (FCaption <> newValue) then
  begin
    FCaption := newValue;
    if Visible then Update;
  end; { if }
end; { SetCaption }

procedure TElCellControl.TriggerClickEvent;
{ Triggers the OnClick event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnClick)) then FOnClick(Self);
end; { TriggerClickEvent }

procedure TElCellControl.TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{ Triggers the onMousedown event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnMouseDown)) then
    FOnMouseDown(Self, Button, Shift, X, Y);
end; { TriggerMouseDownEvent }

procedure TElCellControl.TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
{ Triggers the OnMouseUp event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnMouseUp)) then
    FOnMouseUp(Self, Button, Shift, X, Y);
end; { TriggerMouseUpEvent }

procedure TElCellControl.TriggerDblClickEvent;
{ Triggers the OnDblClick event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnDblClick)) then
    FOnDblClick(Self);
end; { TriggerDblClickEvent }

procedure TElCellControl.TriggerMouseMoveEvent(Shift: TShiftState; X, Y: Integer);
{ Triggers the OnMouseMove event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnMouseMove)) then
    FOnMouseMove(Self, Shift, X, Y);
end; { TriggerMouseMoveEvent }
(*
procedure TElCellControl.SetBoundsRect(newValue : TRect);
begin
  if not EqualRect(FBoundsRect, newValue) then
  begin
    FBoundsRect := newValue;
    if Visible then Update;
  end;  { if }
end;  { SetBoundsRect }
*)

procedure TElCellControl.SetVisible(newValue: Boolean);
begin
  if (FVisible <> newValue) then
  begin
    FVisible := newValue;
    //if not newValue then FBoundsRect := Rect(0, 0, 0, 0);
    Update;
  end; {if}
end;

procedure TElCellControl.SetEnabled(newValue: Boolean);
begin
  if (FEnabled <> newValue) then
  begin
    FEnabled := newValue;
    Update;
  end; {if}
end; {SetEnabled}

procedure TElCellControl.SetPopupMenu(newValue: TPopupMenu);
begin
  if (FPopupMenu <> newValue) then
  begin
    if FPopupMenu <> nil then
      if not (csDestroying in FPopupMenu.ComponentState) then
        FPopupMenu.RemoveFreeNotification(Self);
    FPopupMenu := newValue;
    if FPopupMenu <> nil then FPopupMenu.FreeNotification(Self);
  end;  {if}
end;

procedure TElCellControl.Notification(AComponent: TComponent; Operation:
  TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FPopupMenu) then FPopupMenu := nil;
end;

procedure TElCellControl.SetBorderWidth(Value: Integer);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    Update;
  end;
end;

function TElCellControl.PassClicks: Boolean;
begin
  Result := false;
end;

procedure TElCellControl.FontChanged(Sender: TObject);
begin
  Update;
end;

procedure TElCellControl.SetFont(newValue: TFont);
begin
  FFont.Assign(newValue);
end;

procedure TElCellControl.Assign(Source: TElCellControl);
begin
  if Source <> nil then
  begin
    Self.FCaption := Source.Caption;
    Self.FVisible := Source.Visible;
    Self.FEnabled := Source.Enabled;
    Self.FBorderWidth := Source.BorderWidth;
  end;
end;

// ****************************************************************************
//                              TElCellCheckBox
// ****************************************************************************

procedure TElCellCheckBox.SetState(newValue : TCheckBoxState);
begin
  if FState <> newValue then
  begin
    if (newValue = cbGrayed) and not FAllowGrayed then exit;
    FState := newValue;
    Update;
  end;
end;

procedure TElCellCheckBox.SetAllowGrayed(newValue : Boolean);
begin
  if (not newValue) and (FState = cbGrayed) then State := cbUnchecked;
  FAllowGrayed := newValue;
end;

function TElCellCheckBox.GetChecked : Boolean;
begin
  result := FState = cbChecked;
end;

procedure TElCellCheckBox.SetChecked(newValue : Boolean);
begin
  if newValue
     then State := cbChecked
     else State := cbUnchecked;
end;

procedure TElCellCheckBox.SetAlignment(newValue : TAlignment);
begin
 if (FAlignment <> newValue) then
  begin
    FAlignment := newValue;
    Update;
  end; { if }
end;

procedure TElCellCheckBox.Paint(Tree : TCustomElTree; Item : TElTreeItem;
  Canvas: TCanvas; R: TRect);
var
  ARect : TRect;
  SrcRect,
    CheckRect : TRect;
  cbh, ch,
  cw, cbw : integer;
  i : integer;
  AFont : TFont;
  FGlyph: TBitmap;
//  LTheme   : HTheme;
  sid      : integer;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
begin
  {Canvas.Brush.Color := Color;
  Canvas.FillRect(R);
  }

  LUseThemeMode := Tree.UseThemeMode;
  inc(R.Right);
  inc(R.Bottom);

  ARect  := R;
  FGlyph := Tree.CheckBoxGlyph;

  if (Tree <> nil) and (LUseThemeMode <> ttmNone) then
  begin
      case State of
        cbUnchecked:
          if not Enabled then
            sid := CBS_UNCHECKEDDISABLED
          else
            sid := CBS_UNCHECKEDNORMAL;

        cbChecked:
          if not Enabled then
            sid := CBS_CHECKEDDISABLED
          else
            sid := CBS_CHECKEDNORMAL;

        cbGrayed:
          if not Enabled then
            sid := CBS_MIXEDDISABLED
          else
            sid := CBS_MIXEDNORMAL;
        else
          sid := CBS_UNCHECKEDNORMAL;
      end;

      cbw := Tree.CheckBoxSize;
      cbh := cbw;

      ch := R.Bottom - R.Top + 1;
      cw := R.Right {- R.Left} + 1;

      if (Alignment = taRightJustify) xor Tree.RightAlignedText then
      begin
        CheckRect := Rect(R.Left + CheckMargin, R.Top + (ch shr 1 - cbh shr 1), R.Left + CheckMargin + cbw, R.Top + (ch shr 1 + cbh - cbh shr 1));
      end
      else
      if (Alignment = taRightJustify) or Tree.RightAlignedText then (*<+>*)
      begin
        CheckRect := Rect(cw - CheckMargin - cbw, R.Top + (ch shr 1 - cbh shr 1), cw - CheckMargin, R.Top + (ch shr 1 + cbh - cbh shr 1));
      end
      else
      if Alignment = taCenter then
      begin
        CheckRect := Rect((R.Left + R.Right - cbw) shr 1 - 1 , R.Top + (ch shr 1 - cbh shr 1), (R.Left + R.Right - cbw) shr 1 + cbw, R.Top + (ch shr 1 + cbh - cbh shr 1));
      end;

      LDetails.Part    := BP_CHECKBOX;
      LDetails.State   := sid;
      LDetails.Element := teButton;

      LMDThemeServices.DrawElement(LUseThemeMode, Canvas.Handle, LDetails, CheckRect, LMDRectToPtr(R));

      if (Alignment = taRightJustify) xor Tree.RightAlignedText then
      begin
        ARect.Left := ARect.Left + cbw + CheckMargin * 2;
      end
      else
      begin
        ARect.Right := ARect.Right - cbw - CheckMargin * 2;
      end;

      Canvas.Brush.Style := bsClear;
      InflateRect(ARect, -1, -1);

      LMDThemeServices.DrawThemeText(LUseThemeMode, Canvas.Handle, LDetails, WideString(Caption), Length(WideString(Caption)), DT_SINGLELINE or DT_LEFT or DT_VCENTER, 0, ARect);
      Exit;
  end;

  if Tree.FCustomCheckboxes and (not FGlyph.Empty) then
  begin
    cbh := FGlyph.Height;
    cbw := FGlyph.Width div 6;
    case State of
      cbUnchecked :
        if Enabled then SrcRect := Rect(0, 0, cbw, cbh) else SrcRect := Rect(cbw, 0, cbw * 2, cbh);
      cbChecked :
        if Enabled then SrcRect := Rect(cbw * 2, 0, cbw * 3, cbh) else SrcRect := Rect(cbw * 3, 0, cbw * 4, cbh);
      cbGrayed :
        if Enabled then SrcRect := Rect(cbw * 4, 0, cbw * 5, cbh) else SrcRect := Rect(cbw * 5, 0, cbw * 6, cbh);
    end;
    i := 0;
  end
  else
  begin
    cbw := CheckBoxSize;
    cbh := CheckBoxSize;
    i := DFCS_BUTTONCHECK or DFCS_CHECKED;
    begin
      case State of
        cbChecked : i := DFCS_BUTTONCHECK or DFCS_CHECKED;
        cbUnchecked : i := DFCS_BUTTONCHECK;
        cbGrayed : i := DFCS_BUTTON3STATE or DFCS_CHECKED;
      end; // case
    end;
    if (not Enabled) {or (FMouseInControl and FPressed) }then i := i or DFCS_INACTIVE;
  end;

  ch := R.Bottom - R.Top + 1;
  cw := R.Right {- R.Left} + 1;

  if (Alignment = taRightJustify) xor Tree.RightAlignedText then
  begin
    CheckRect := Rect(R.Left + CheckMargin, R.Top + (ch shr 1 - cbh shr 1), R.Left + CheckMargin + cbw, R.Top + (ch shr 1 + cbh - cbh shr 1));
  end
  else if (Alignment = taRightJustify) or Tree.RightAlignedText then (*<+>*)
  begin
    CheckRect := Rect(cw - CheckMargin - cbw, R.Top + (ch shr 1 - cbh shr 1), cw - CheckMargin, R.Top + (ch shr 1 + cbh - cbh shr 1));
  end
  else if Alignment = taCenter then
  begin
    CheckRect := Rect((R.Left + R.Right - cbw) shr 1 - 1 , R.Top + (ch shr 1 - cbh shr 1), (R.Left + R.Right - cbw) shr 1 + cbw, R.Top + (ch shr 1 + cbh - cbh shr 1));
  end;

  if Tree.FCustomCheckboxes and (not FGlyph.Empty) then
  begin
    Canvas.CopyRect(CheckRect, FGlyph.Canvas, SrcRect);
  end
  else
  begin
    // Canvas.Brush.Style := bsClear;
    DrawFrameControl(Canvas.Handle, CheckRect, DFC_BUTTON, i);
    if Tree.CheckBoxFlat then
      DrawFlatCheckboxFrame(Tree, Canvas.Handle, CheckRect, Enabled);
    // if Flat and Enabled then DrawFlatFrame(CheckRect);
  end;

  if (Alignment = taRightJustify) xor Tree.RightAlignedText then
  begin
    ARect.Left := ARect.Left + cbw + CheckMargin * 2;
  end
  else
  begin
    ARect.Right := ARect.Right - cbw - CheckMargin * 2;
  end;

  if Caption <> '' then
  begin
    Canvas.Brush.Style := bsClear;
    InflateRect(ARect, -1, -1);
    AFont := TFont.Create;
    AFont.Assign(Canvas.Font);
    Canvas.Font := Font;

    if not Enabled then
    begin
      OffsetRect(ARect, 1, 1);
      Canvas.Font.Color := clBtnHighlight;
      LMDDrawText(Canvas.Handle, Caption, Length(Caption), ARect, DT_SINGLELINE or DT_LEFT or DT_VCENTER);
      Canvas.Font.Color := clBtnShadow;
      OffsetRect(ARect, -1, -1);
      LMDDrawText(Canvas.Handle, Caption, Length(Caption), ARect, DT_SINGLELINE or DT_LEFT or DT_VCENTER);
      end
    else
    begin
      // Canvas.Font.Color := FTree.TextColor;

      if Item.Selected then
      begin
        if ((not Tree.FBarStyle) and (Item.BorderStyle = ibsNone)) and
           (((Tree.FSelectColumn = Tree.FMainTreeCol) and (Tree.FShowHeader)) or
             Tree.FRowSelect) {and (FTree.HighlightAlphaLevel = 255)} then
        begin
          if Tree.FView.FHasFocus then
            Canvas.Font.Color := Tree.FFocusedSelectTextColor
          else
          if not Tree.HideSelection then
            Canvas.Font.Color := Tree.FHideSelectTextColor;
        end;
      end;

      {$ifdef LMD_UNICODE}
      DrawTypedTextW(Canvas, ARect, Caption, DT_SINGLELINE or DT_LEFT or DT_VCENTER, tdtNormal);
      {$else}
      DrawTypedText(Canvas, ARect, Caption, DT_SINGLELINE or DT_LEFT or DT_VCENTER, tdtNormal);
      {$endif}
      end;
    Canvas.Brush.Style := bsSolid;
    Canvas.Font := AFont;
    AFont.Free;
  end;
end; { Paint }

procedure TElCellCheckBox.TriggerClickEvent;
var
  State : TCheckBoxState;
begin
  State := Self.State;
  case State of
    cbChecked : Checked := false;
    cbGrayed : Checked := true;
    cbUnchecked :
      if AllowGrayed then Self.State := cbGrayed else Checked := true;
  end;
  inherited;
end;

procedure TElCellCheckBox.TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
end;

procedure TElCellCheckBox.TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
end;

procedure TElCellCheckBox.Assign(Source: TElCellControl);
begin
  if Source is TElCellButton then
  begin
    with Source as TElCellButton do
    begin
      Self.Alignment := Alignment;
      Self.AllowGrayed := AllowGrayed;
      Self.FState := State;
    end;
    inherited;
  end;
end;

constructor TElCellCheckBox.Create;
begin
  inherited;
  Alignment := taRightJustify;
end;

destructor TElCellCheckBox.Destroy;
begin
  inherited;
end;

// ****************************************************************************
//                                   TElCellButton
// ****************************************************************************

function TElCellButton.GetGlyph: TBitmap;
begin
  Result := FGlyph.Glyph;
end; {GetGlyph}

procedure TElCellButton.GlyphChanged(Sender: TObject);
begin
  Update;
end;

procedure TElCellButton.SetGlyph(newValue: TBitmap);
begin
  FGlyph.Glyph := newValue;
  Update;
end; {SetGlyph}

procedure TElCellButton.SetDown(newValue: Boolean);
begin
  if (FDown <> newValue) then
  begin
    FDown := newValue;
    Update;
  end; {if}
end; {SetDown}

procedure TElCellButton.Assign;
begin
  if Source is TElCellButton then
  begin
    with Source as TElCellButton do
    begin
      Self.Glyph := Glyph;
      Self.FFixClick := FixClick;
      Self.FDown := Down;
    end;
    inherited;
  end;
end;

procedure TElCellButton.TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FFixClick then SetDown(not Down) else SetDown(true);
  inherited;
end;

procedure TElCellButton.TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not FFixClick then SetDown(false);
  inherited;
end;

procedure TElCellButton.Paint(Tree : TCustomElTree; Item : TElTreeItem; Canvas:
    TCanvas; R: TRect);
var
  DrawFlags: Integer;
  FState   : TLMDExButtonState;
  FBrush   : TBrush;
  FPen     : TPen;
  FSFont   : TFont;
  // LTheme   : HTheme;
  sid      : integer;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
begin
  LUseThemeMode := Tree.UseThemeMode;
  inc(R.Right);
  inc(R.Bottom);

  if (Tree <> nil) and (LUseThemeMode <> ttmNone) then
  begin
    // LTheme := LMDThemeService.Theme[tiButton];
//    if LTheme <> 0 then
//    begin
      if FDown then
        sid := PBS_PRESSED
      else
        sid := PBS_NORMAL;
      LDetails.Element := teButton;
      LDetails.Part := BP_PUSHBUTTON;
      LDetails.State := sid;
       LMDThemeServices.DrawElement(LUseThemeMode, Canvas.Handle, LDetails, R, LMDRectToPtr(R));

      if not FEnabled then
        FState := ebsDisabled
      else
      if FDown then
      begin
        FState := ebsDown;
        OffsetRect(R, 1, 1);
      end
      else
        FState := ebsUp;

      FBrush   := TBrush.Create;
      FPen     := TPen.Create;
      FSFont   := TFont.Create;
      FBrush.Assign(Canvas.Brush);
      FPen.Assign(Canvas.Pen);
      FSFont.Assign(Canvas.Font);
      Canvas.Font.Assign(FFont);
      FGlyph.Draw(Canvas, R, Point(0, 0), Caption, FLayout, -1, -1, FState, FState, taCenter, false,
        Pos(#13#10, FCaption) > 0, false, true, true, 0, tdtNormal, clBtnFace, LUseThemeMode, LDetails,  false, false, false, nil, true);
      Canvas.Font.Assign(FSFont);
      Canvas.Pen.Assign(FPen);
      Canvas.Brush.Assign(FBrush);
      FBrush.Free;
      FPen.Free;
      FSFont.Free;
      exit;
    // end;
  end;
  DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
  if (FDown) then DrawFlags := DrawFlags or DFCS_PUSHED;
  DrawFrameControl(Canvas.Handle, R, DFC_BUTTON, DrawFlags);
  InflateRect(R, 1, 1);
  if not FEnabled then
    FState := ebsDisabled
  else
  if FDown then
  begin
    FState := ebsDown;
    OffsetRect(R, 1, 1);
  end
  else
    FState := ebsUp;

  FBrush   := TBrush.Create;
  FPen     := TPen.Create;
  FSFont   := TFont.Create;
  FBrush.Assign(Canvas.Brush);
  FPen.Assign(Canvas.Pen);
  FSFont.Assign(Canvas.Font);
  Canvas.Font.Assign(FFont);
  FGlyph.Draw(Canvas, R, Point(0, 0), Caption, FLayout, -1, -1, FState, FState, taCenter, false,
    Pos(#13#10, FCaption) > 0, false, true, true, 0, tdtNormal, clBtnFace, LUseThemeMode, LDetails, false, false, false, nil, true);
  Canvas.Font.Assign(FSFont);
  Canvas.Pen.Assign(FPen);
  Canvas.Brush.Assign(FBrush);
  FBrush.Free;
  FPen.Free;
  FSFont.Free;
end; {Paint}

procedure TElCellButton.SetLayout(newValue: TButtonLayout);
begin
  if (FLayout <> newValue) then
  begin
    FLayout := newValue;
    Update;
  end; {if}
end;

function TElCellButton.GetUseImageList : Boolean;
{ Returns the value of data member FUseImageList. }
begin
  result := FGlyph.UseImageList; //FUseImageList;
end;  { GetUseImageList }

procedure TElCellButton.SetUseImageList(newValue : Boolean);
{ Sets data member FUseImageList to newValue. }
begin
  if (FGlyph.UseImageList <> newValue) then
  begin
    FGlyph.UseImageList := newValue;
    Update;
  end;  { if }
end;  { SetUseImageList }

function TElCellButton.GetImageList : TCustomImageList;
{ Returns the value of data member FImageList. }
begin
  result := FGlyph.ImageList;
end;  { GetImageList }

procedure TElCellButton.SetImageList(newValue : TCustomImageList);
{ Sets data member FImageList to newValue. }
begin
  if (FGlyph.ImageList <> newValue) then
  begin
    if FGlyph.ImageList <> nil then
      if not (csDestroying in FGlyph.ImageList.ComponentState) then
        FGlyph.ImageList.RemoveFreeNotification(Self);
    FGlyph.ImageList := newValue;
    if FGlyph.ImageList <> nil then FGlyph.ImageList.FreeNotification(Self);
    if UseImageList then Update;
  end;  { if }
end;  { SetImageList }

function TElCellButton.GetImageIndex : Integer;
{ Returns the value of data member FImageIndex. }
begin
  result := FGlyph.ImageIndex;
end;  { GetImageIndex }

procedure TElCellButton.SetImageIndex(newValue : Integer);
{ Sets data member FImageIndex to newValue. }
begin
  if (FGlyph.ImageIndex <> newValue) then
  begin
    FGlyph.ImageIndex := newValue;
    if UseImageList then Update;
  end;  { if }
end;  { SetImageIndex }

destructor TElCellButton.Destroy;
begin
  Dec(ButtonCount);
  if ButtonCount <= 0 then
  begin
    Pattern.Free;
    Pattern := nil;
  end;
  FGlyph.Free;
  inherited;
end;

constructor TElCellButton.Create;
begin

  FGlyph := TElCellButtonGlyph.Create;
  FGlyph.OnChange := GlyphChanged;
  inherited;

  Inc(ButtonCount);
  FDown := False;
  FLayout := blGlyphLeft;
end; {Create}

constructor TElCellProgressBar.Create;
begin
  inherited;
  FMaxValue := 100;
  FColor := clWindow;
  FBarColor := clHighlight;
  FFrameColor := clWindowText;
  FShowProgressText := true;
  FTextAlignment := taCenter;
end; {Create}

destructor TElCellProgressBar.Destroy;
begin
  inherited;
end;

procedure TElCellProgressBar.Assign;
begin
  if Source is TElCellProgressBar then
  begin
    with Source as TElCellProgressBar do
    begin
      Self.FBarColor := BarColor;
      Self.FMaxValue := MaxValue;
      Self.FMinValue := MinValue;
      Self.FShowProgressText := ShowProgressText;
      Self.FTextAlignment := TextAlignment;
      Self.FValue := Value;
      Self.FFrameColor := FFrameColor;
      Self.FColor := Color;
    end;
    inherited;
  end;
end;

procedure TElCellProgressBar.Paint(Tree : TCustomElTree; Item : TElTreeItem;
    Canvas: TCanvas; R: TRect);
var
  BrushColor,
  PenColor : TColor;
  FFont    : TFont;
  FillRect,
  BarRect,
  TextRect : TRect;
  MCaption,
  ACaption  : TLMDString;
begin
  inc(R.Right);
  //inc(R.Bottom);
  BarRect := R;

  if (ShowProgressText or (Caption <> '')) and (TextAlignment in [taLeftJustify, taRightJustify]) then
  begin
    SetRectEmpty(TextRect);

    if ShowProgressText then
    begin
      ACaption := IntToStr(MulDiv(Value , 100, (MaxValue - MinValue))) + '%';
      MCaption := '100%';
    end
    else
    begin
      ACaption := Caption;
      MCaption := Caption;
    end;

    FFont := TFont.Create;
    FFont.Assign(Canvas.Font);
    Canvas.Font.Assign(Font);
    if Item.Selected then
    begin
      if ((not Tree.FBarStyle) and (Item.BorderStyle = ibsNone)) and
         (((Tree.FSelectColumn = Tree.FMainTreeCol) and (Tree.FShowHeader)) or
           Tree.FRowSelect) {and (Tree.HighlightAlphaLevel = 255) }then
      begin
        if Tree.FView.FHasFocus then
          Canvas.Font.Color := Tree.FFocusedSelectTextColor
        else
        if not Tree.HideSelection then
          Canvas.Font.Color := Tree.FHideSelectTextColor;
      end;
    end;
    LMDDrawText(Canvas.Handle, MCaption, Length(MCaption), TextRect, DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_CALCRECT);
    if TextRect.Right - TextRect.Left < R.Right - R.Left then
    begin
      if (TextAlignment = taRightJustify) xor Tree.FRightAlignedView then
      begin
        BarRect.Right  := R.Right - (TextRect.Right - TextRect.Left) - 2;
        TextRect.Left  := R.Right - (TextRect.Right - TextRect.Left);
        TextRect.Right := R.Right;
      end
      else
      begin
        BarRect.Left   := R.Left + (TextRect.Right - TextRect.Left) + 2;
        TextRect.Right := R.Left + (TextRect.Right - TextRect.Left);
        TextRect.Left  := R.Left;
      end;
      TextRect.Top := BarRect.Top;
      TextRect.Bottom := BarRect.Bottom;
      Canvas.Brush.Style := bsClear;
      LMDDrawText(Canvas.Handle, ACaption, Length(ACaption), TextRect, DT_SINGLELINE or DT_LEFT or DT_VCENTER);
      end;
    Canvas.Font.Assign(FFont);
    FFont.Free;
  end;

  if BarRect.Right > BarRect.Left then
  begin
    BrushColor := Canvas.Brush.Color;
    PenColor := Canvas.Pen.Color;
    Canvas.Pen.Color := FrameColor;
    Canvas.Brush.Color := Color;
    with BarRect do
      Canvas.Rectangle(Left, Top, Right, Bottom);

    FillRect := BarRect;

    if Value > MinValue then
    begin
      if not Tree.FRightAlignedView then
      begin
        FillRect.Left := BarRect.Left;
        FillRect.Right := Min(BarRect.Right - 1, FillRect.Left + MulDiv(BarRect.Right - BarRect.Left, Value, MaxValue - MinValue));
        InflateRect(FillRect, -1, -1);
        inc(FillRect.Right);
      end
      else
      begin
        FillRect.Right := BarRect.Right;
        FillRect.Left := max(BarRect.Left - 1, FillRect.Right - MulDiv(BarRect.Right - BarRect.Left, Value, MaxValue - MinValue));
        InflateRect(FillRect, -1, -1);
        dec(FillRect.Left);
      end;
      Canvas.Brush.Color := BarColor;
      Canvas.FillRect(FillRect);
    end;
    Canvas.Brush.Color := BrushColor;
    Canvas.Pen.Color := PenColor;

    if (ShowProgressText or (Caption <> '')) and (TextAlignment = taCenter) then
    begin
      SetRectEmpty(TextRect);
      FFont := TFont.Create;
      FFont.Assign(Canvas.Font);
      Canvas.Font.Assign(Font);

      (*
      if Item.Selected then
      begin
        if ((not Tree.FBarStyle) and (Item.BorderStyle = ibsNone)) and
           (((Tree.FSelectColumn = Tree.FMainTreeCol) and (Tree.FShowHeader)) or
             Tree.FRowSelect) {and (FTree.HighlightAlphaLevel = 255)} then
        begin
          if Tree.FView.FHasFocus then
            Canvas.Font.Color := Tree.FFocusedSelectTextColor
          else
          if not Tree.HideSelection then
            Canvas.Font.Color := Tree.FHideSelectTextColor;
        end;
      end;
      *)

      if ShowProgressText then
        ACaption := IntToStr(MulDiv(Value , 100, (MaxValue - MinValue))) + '%'
      else
        ACaption := Caption;

      LMDDrawText(Canvas.Handle, ACaption, Length(ACaption), TextRect, DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_CALCRECT);
      if TextRect.Right - TextRect.Left < R.Right - R.Left then
      begin
        Canvas.Brush.Style := bsClear;
        TextRect := R;
        LMDDrawText(Canvas.Handle, ACaption, Length(ACaption), TextRect, DT_SINGLELINE or DT_CENTER or DT_VCENTER);
      end;
      Canvas.Font.Assign(FFont);
      FFont.Free;
    end;
  end;
end; {Paint}

procedure TElCellProgressBar.SetMinValue(Value: Integer);
begin
  if FMinValue <> Value then
  begin
    FMinValue := Value;
    Update;
  end;
end;

procedure TElCellProgressBar.SetMaxValue(Value: Integer);
begin
  if FMaxValue <> Value then
  begin
    FMaxValue := Value;
    Update;
  end;
end;

procedure TElCellProgressBar.SetValue(Value: Integer);
begin
  if FValue <> Value then
  begin
    FValue := Min(Max(MinValue, Value), MaxValue);
    Update;
  end;
end;

procedure TElCellProgressBar.SetBarColor(Value: TColor);
begin
  if FBarColor <> Value then
  begin
    FBarColor := Value;
    Update;
  end;
end;

procedure TElCellProgressBar.SetShowProgressText(Value: Boolean);
begin
  if FShowProgressText <> Value then
  begin
    FShowProgressText := Value;
    Update;
  end;
end;

procedure TElCellProgressBar.SetTextAlignment(Value: TAlignment);
begin
  if FTextAlignment <> Value then
  begin
    FTextAlignment := Value;
    Update;
  end;
end;

procedure TElCellProgressBar.SetFrameColor(Value: TColor);
begin
  if FFrameColor <> Value then
  begin
    FFrameColor := Value;
    Update;
  end;
end;

procedure TElCellProgressBar.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Update;
  end;
end;

function TElCellProgressBar.PassClicks: Boolean;
begin
  Result := true;
end;

// ****************************************************************************
//                                TElTreeView
// ****************************************************************************

constructor TElTreeView.Create(Owner : TComponent);
begin
  FOwner := Owner as TCustomElTree;
  inherited;
  ControlStyle := ControlStyle + [csOpaque, csDisplayDragImage] - [csCaptureMouse];

  FEndEditWhenDestroy := True;
  Input := TElKeyboardInput.Create;

  FTmpBmp := TBitmap.Create;

  FVisible := TLMDObjectList.Create;
  FHRange := -1;
  FHintHCol := -1;
end;

destructor TElTreeView.Destroy;
begin
  StopClearSearchTimeoutThread;
  FreeAndNil(Input);
  if FDragExpandTimer <> nil then
    FreeAndNil(FDragExpandTimer);
  if FHintItem <> nil then
     DoHideLineHint;
  FHintItemEx := nil;

  FreeAndNil(FHintTimer);
  FreeAndNil(FHintWnd);
  FreeAndNil(FDragScrollTimer);

  if FInpEdit <> nil then
    DoEndEdit(true);
  FreeAndNil(FEditTimer);

  FVisible.Free;

  FTmpBmp.Free;

  if VirtStyle <> nil then
    VirtStyle.Free;
  inherited;
end;

procedure TElTreeView.DestroyWnd;  { protected }

begin

  if FEndEditWhenDestroy then
    DoEndEdit(true);

  inherited;
end;  { DestroyWnd }

procedure TElTreeView.RedoTmpBmp;
var BgRect,
    BgRect1,
    BgRect2,
    BgRect4    : TRect;

begin
  if FOwner.BackgroundType in [bgtColorFill, bgtCenterBitmap] then
  begin
    FTmpBmp.FreeImage;
    {FTmpBmp.Height := 0;
    FTmpBmp.Width := 0;}
  end else
  if LMDBackgroundIsGradient(FOwner.BackgroundType) then
  begin
    if (ClientWidth <> 0) and (ClientHeight <> 0) then
    begin
      FTmpBmp.Height := ClientHeight + 1;
      FTmpBmp.Width := ClientWidth + 1;
      BgRect := ClientRect;
      with FOwner do
        LMDGradientPaint(FTmpBmp.Canvas, BgRect, GradientStartColor, GradientEndColor, GradientSteps, LMDBackgroundType2GradientStyle[BackgroundType], 0, 0);
      end;
  end else
  begin
    if (ClientWidth <> 0) and (ClientHeight <> 0) then
    begin
      FTmpBmp.Height := ClientHeight + 1;
      FTmpBmp.Width := ClientWidth + 1;
      FTmpBmp.Handle := CreateCompatibleBitmap(FOwner.Background.Canvas.Handle, FTmpBmp.Width + 1, FTmpBmp.Height + 1);
      BgRect := ClientRect;
      BgRect4 := BgRect;
      BgRect1 := ClientRect;
      BgRect2 := BgRect;
      OffsetRect(BgRect2, BgRect2.Left, BgRect2.Top);
      with FOwner do
        LMDExtDrawBkgnd(FTmpBmp.Canvas.Handle, BgRect1, BgRect, BgRect, BgRect2, false, BkColor, BkColor, Background, backgroUndtype);
      end;
  end;
end;

procedure TElTreeView.DoHideLineHint;
begin
  FHintItem := nil;
  if FHintTimer <> nil then
  begin
    FHintTimer.Free;
    FHintTimer := nil;
  end;
  if FHintWnd <> nil then
  begin
    FHintWnd.ReleaseHandle;
    FHintWnd.Hide;
    //FHintWnd.Free;
    //FHintWnd := nil;
  end;
end;

procedure TElTreeView.TryStartHint(XPos, YPos : Integer);
var Item  : TElTreeItem;
    R3    : TRect;
    xoffs : integer;
    Section,
    S2    : TElHeaderSection;
    hc    : integer;
    ip    : TSTItemPart;
    IT    : TLMDString;
    Show1 : boolean;
    Size  : TPoint;
    w, i  : integer;

    HTMLData : TLMDHTMLData;

begin
  Item := GetItemAt(XPos, YPos, ip, hc);
  if ip <> ipOutside then
  begin
    if hc = -1 then
      Section := nil
    else
      Section := FOwner.FHeader.Sections[hc];
  end
  else
    exit;

  if Item = nil then exit;
  if FOwner.FHintType = shtHintOnly then
  begin
    IT := Item.Hint;
    Show1 := true;
  end
  else
  begin
    IT := GetHintText(Item, Section);
    if FOwner.FShowHintMode = shmAll then
      Show1 := true
    else
    if (FOwner.FShowHintMode = shmLong) and (Item.Hint = '') then
    begin
      SetRectEmpty(R3);

      if Item.IsHTML and (Copy(IT, 1, 6) = '<html>') then
      begin
        if (not FOwner.ShowColumns) or (Section.Index = FOwner.MainTreeColumn) then
          HTMLData := Item.FHTMLData
        else
        begin
          hc := Section.Index;
          if hc > FOwner.MainTreeColumn then
            dec(hc);
          HTMLData := TLMDHTMLData(Item.FHTMLDataArray[hc]);
        end;
        if HTMLData <> nil then
        begin
          R3.Right := HTMLData.TextSize.cx;
          R3.Bottom := HTMLData.TextSize.cy;
        end;
      end
      else
        LMDDrawText(Canvas.Handle, IT, Length(IT), R3, DT_NOPREFIX or DT_CALCRECT);
      with FOwner do
        if FHeader.Visible and (FMainTreeCol <> - 1) and
           (FHeader.Sections.Count > FMainTreeCol)
    and FHeader.Sections[FMainTreeCol].Locked
    then
          xOffs := - FHPos
        else
          xOffs := 0;

      if (not FOwner.ShowColumns) then
      begin
        FOwner.MeasureCell(Item, -1, 0, Size);
        Show1 := (Size.x > ClientWidth) or
                 (Item.FTextRect.Right > ClientWidth + FOwner.FHPos + xOffs) or (Item.FTextRect.Left < FOwner.FHPos + xOffs)
        (*
        Show1 := ((R3.Right - R3.Left) > (Item.FTextRect.Right - Item.FTextRect.Left)) or
                 (Item.FTextRect.Right > ClientWidth + FOwner.FHPos + xOffs) or (Item.FTextRect.Left < FOwner.FHPos + xOffs);
        *)
      end
      else
      if Item.WholeLine then
      begin
        w := 0;
        for i := 0 to Pred(FOwner.FHeader.Sections.Count) do
        begin
          S2 := FOwner.FHeader.Sections[i];
          if S2.Visible then
            inc(w, S2.Width);
        end;

        FOwner.MeasureCellText(Item, FOwner.FMainTreeCol, w, Size);

        Show1 :=
                   (FOwner.RightAlignedView and (Item.FTextRect.Right - Size.x < Section.Left)) or
                   (not FOwner.RightAlignedView and (Item.FTextRect.Left + Size.x > Section.Right)) or
                   ((Item.FTextRect.Right > ClientWidth + FOwner.FHPos + xOffs) or
                   (Item.FTextRect.Left < FOwner.FHPos + xOffs))
      end
      else
      begin

        FOwner.MeasureCellText(Item, Section.Index, Section.Width, Size);
        if Section.Index = FOwner.FMainTreeCol then
          Show1 := // (Size.x - (FOwner.ItemExt div 3) > Section.Width) or
                   (FOwner.RightAlignedView and (Item.FTextRect.Right - Size.x < Section.Left)) or
                   (not FOwner.RightAlignedView and (Item.FTextRect.Left + Size.x > Section.Right)) or
                   ((Item.FTextRect.Right > ClientWidth + FOwner.FHPos + xOffs) or
                   (Item.FTextRect.Left < FOwner.FHPos + xOffs))
        else
          Show1 := (Size.x + (FOwner.ItemExt * 3 div 5) > Section.Width) or
                   ((Section.Right - (FOwner.ItemExt * 3 div 5) > ClientWidth + FOwner.FHPos + xOffs) or
                   (Section.Left + (FOwner.ItemExt * 3 div 5) < FOwner.FHPos + xOffs));
        (*
        if Section.Index = FOwner.FMainTreeCol then
          Show1 := ((R3.Right - R3.Left) > (Item.FTextRect.Right - Item.FTextRect.Left)) or
                   ((Item.FTextRect.Right > ClientWidth + FOwner.FHPos + xOffs) or
                   (Item.FTextRect.Left < FOwner.FHPos + xOffs))
        else
          Show1 := ((R3.Right - R3.Left) > (Section.Width - (FOwner.ItemExt div 3) shl 1)) or
                   ((Section.Right - (FOwner.ItemExt div 3) > ClientWidth + FOwner.FHPos + xOffs) or
                   (Section.Left + (FOwner.ItemExt div 3) < FOwner.FHPos + xOffs));
        *)
      end;
    end
    else
      Show1 := true;
  end;

  if (FHintItem = nil) and Show1 then
    DoShowLineHint(Item, Section);
end;

function TElTreeView.GetHintText;
var si : integer;
    AStyle : TElCEllStyle;
    b : boolean;

    function GetShortHint(AHint : TLMDString) : TLMDString;
    begin
      {$ifdef LMD_UNICODE}
      if LMDWidePos('|', AHint) > 0 then
      {$else}
      if Pos('|', AHint) > 0 then
      {$endif}
        result := Copy(AHint, 1, Pos('|', AHint) - 1)
      else
        result := AHint;
    end;

begin
  b := true;
  if FOwner.FHintType = shtHintOnly then
  begin
    result := GetShortHint(Item.Hint);
  end
  else
  begin
    if FOwner.FHintType = shtHintOrText then
    begin
      result := GetShortHint(Item.Hint);
      if Length(Result) <> 0 then
        exit;
    end;
    if (FOwner.LineHintType <> lhtMainTextOnly) and
      FOwner.ShowColumns then
    begin
      if Assigned(Section) then
        si := Section.Index
      else
        si := 0;
      if FOwner.VirtualityLevel = vlNone then
      begin
        if si > FOwner.MainTreeColumn then
          dec(si);
      end;

      if FOwner.VirtualityLevel = vlNone then
      begin
        AStyle := nil;

        if Item.UseStyles then
        begin
          AStyle := Item.MainStyle;
          if (Section.Index <> FOwner.MainTreeColumn) and
             (Item.StylesCount > si) and (not AStyle.FOwnerProps) then
            AStyle := Item.Styles[si];
        end;
      end
      else
      begin
        AStyle := nil;
        if Item.UseStyles then
        begin
          AStyle := VirtStyle;
          FOwner.TriggerVirtualStyleNeeded(Item, si, AStyle);
        end;
      end;

      if (AStyle = nil) or (AStyle.FStyle = ElhsText) then
      begin
        if Item.FStaticData <> nil then
        begin
          if (not Assigned(Section)) or (Section.Index = FOwner.MainTreeColumn) then
            b := true
          else
          if Item.ColumnText.Count > si then
          begin
            result := Item.ColumnText[si];
            if (Length(Result) <> 0) or
               (FOwner.LineHintType <> lhtSmart) then
              b := false
            else
            if (FOwner.LineHintType = lhtSmart) then
              Section := FOwner.FHeader.Sections[FOwner.MainTreeColumn];
          end
          else
          if FOwner.LineHintType = lhtCellTextOnly then
            b := false;
        end
        else
        begin
          if Section.Index = FOwner.MainTreeColumn then
            b := true
          else
          FOwner.TriggerVirtualTextNeeded(Item, Section.Index, result);
          if (Length(Result) <> 0) or
             (FOwner.LineHintType <> lhtSmart) then
            b := false
          else
          if (FOwner.LineHintType = lhtSmart) then
            Section := FOwner.FHeader.Sections[FOwner.MainTreeColumn]
          else
          if FOwner.LineHintType = lhtCellTextOnly then
            b := false;
        end;
      end

      else
      if FOwner.LineHintType = lhtCellTextOnly then
        b := false;
    end;

    if b = true then // we are showing long text
      result := Item.Text;
  end;
end;

procedure TElTreeView.DoShowLineHint(Item: TElTreeItem; Section : TElHeaderSection);
var
  S, S1: TLMDString;
  R, R1, R2: TRect;
  dx, dy: integer;
  b: boolean;
  P: TPoint;
  xOffs : integer;
begin
  if FOwner.IsEditing or  FMouseSel then
    exit;
  R1 := GetItemRect(FVisible.IndexOf(Item));
  if IsRectEmpty(R1) then exit;
  if FHintWnd = nil then
     FHintWnd := TElHintWindow.Create(self);
  b := true;
  S := GetHintText(Item, Section);
  if S = '' then
    exit;

  FHintWnd.Font := Font;
  if not FOwner.UseSystemHintColors then
  begin
    FHintWnd.Color        := FOwner.FLineHintColor;
    FHintWnd.Font.Color   := FOwner.FTextColor;
  end
  else
  begin
    FHintWnd.Color := clInfoBk;
    FHintWnd.Font.Color := clInfoText;
  end;
  FHintWnd.Font.Charset := Font.Charset;

  FHintWnd.IsHTML := Item.HintIsHTML;
  FHintWnd.OnImageNeeded := FOwner.TriggerImageNeededEvent;

  with FOwner do
    if FHeader.Visible and (FMainTreeCol <> - 1) and
         (FHeader.Sections.Count > FMainTreeCol)

         and FHeader.Sections[FMainTreeCol].Locked

         then
      xOffs := - FHPos
    else
      xOffs := 0;

  if not FOwner.ShowColumns then
    R1.Left := Max(0, Item.FTextRect.Left - FOwner.FHPos - xOffs)
  else
  begin
    if Section.Index = FOwner.FMainTreeCol then
      R1.Left := Max(0, Item.FTextRect.Left + FOwner.FHPos - xOffs)
    else
      R1.Left := Max(0, Section.Left + FOwner.ItemExt div 5 - FOwner.FHPos - xOffs);
  end;
  {$ifdef LMD_UNICODE}
  R := FHintWnd.CalcHintRectW(10000, S, nil);
  {$else}
  R := FHintWnd.CalcHintRect(10000, S, nil);
  {$endif}

  dec(R.Bottom, 2);
  dx := R.Right - R.Left + 1;
  dy := R.Bottom - R.Top + 1;
  R.Left := R1.Left;
  R.Top := R1.Top;
  R.Right := R.Left + dx;
  R.Bottom := R.Top + dy;
  R.TopLeft := ClientToScreen(R.TopLeft);
  R.BottomRight := ClientToScreen(R.BottomRight);
  FHintWnd.BoundsRect := R;
  b := true;
  P := FHintCoord;
  if FOwner.ShowColumns then
    Inc(P.Y, FOwner.HeaderHeight);
  S1 := S;
  FOwner.DoShowHint(Item, Section, S, FHintWnd, P, b);
  if (b and (S <> S1)) then
  begin
    R := FHintWnd.BoundsRect;
    {$ifdef LMD_UNICODE}
    R2 := FHintWnd.CalcHintRectW(10000, S, nil);
    {$else}
    R2 := FHintWnd.CalcHintRect(10000, S, nil);
    {$endif}
    dec(R2.Bottom, 2);
    dx := R2.Right - R2.Left + 1;
    dy := R2.Bottom - R2.Top + 1;
    R.Right := R.Left + dx;
    R.Bottom := R.Top + dy;
  end;
  if b then
  begin
    FHintItem := Item;
    {$ifdef LMD_UNICODE}
    FHintWnd.ActivateHintW(R, S);
    {$else}
    FHintWnd.ActivateHint(R, S);
    {$endif}
  end;
end;

procedure TElTreeView.WndProc(var Message: TMessage);
var P1 : TPoint;
    Item : TElTreeItem;
    HCol : Integer;
    IP : TSTItemPart;
begin
  if (FHintItem <> nil) and (FOwner.FHideHintOnMove) then
  begin
    if ((Message.Msg >= WM_MOUSEMOVE) and (Message.Msg <= WM_MOUSELAST)) or (Message.Msg = WM_NCMOUSEMOVE) then
    begin
      GetCursorPos(P1);
      P1 := ScreenToClient(P1);
      Item := GetItemAt(P1.X, P1.Y, IP, HCol);
      if Item <> FHintItem then
         DoHideLineHint;
      inherited;
      exit;
    end
    else
    if
      ((Message.Msg >= WM_KEYFIRST) and (Message.Msg <= WM_KEYLAST)) or
      ((Message.Msg = CM_ACTIVATE) or (Message.Msg = CM_DEACTIVATE)) or
      (Message.Msg = CM_APPKEYDOWN) or (Message.Msg = CM_APPSYSCOMMAND) or
      (Message.Msg = WM_COMMAND) or
      ((Message.Msg > WM_MOUSEMOVE) and (Message.Msg <= WM_MOUSELAST))
      or (Message.Msg = WM_NCMOUSEMOVE) then
      DoHideLineHint;
  end;
  if (FHintItem <> nil) and ((Message.Msg = CM_ACTIVATE) or (Message.Msg = CM_DEACTIVATE))
    or (Message.Msg = WM_NCMOUSEMOVE) then
    DoHideLineHint;
  inherited;
end;

procedure TElTreeView.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  Message.Result := DLGC_WANTARROWS or DLGC_WANTCHARS;
end;

procedure TElTreeView.CMMouseWheel(var Msg: TCMMouseWheel);  { private }
var
  Dy : integer;
  sl : integer;
  TSI: TElTreeItem;
  R  : TRect;
  Pos: TPoint;
  Message: TWMMouseMove;
begin

  if FOwner.IsEditing then
    exit;

  if LMDSIWindowsNTUp or LMDSIWindows98 then
    SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
  else
    sl := 3;
  if sl = 0 then sl := 1;
  Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
  if Dy <> 0 then
  begin
    if FMouseSel then
    begin
      DrawMouseSelectFrame;
      SetVPosition(FOwner.FTopIndex - Dy);
      Update;
      Pos := ScreenToClient(SmallPointToPoint(Msg.Pos));
      if PtInRect(ClientRect, Pos) then
      begin
        TSI := GetItemAtY(Pos.y);
        if TSI = nil then
          TSI := TElTreeItem(FVisible.Last);
        begin
          R := GetItemRect(FVisible.IndexOf(TSI));
          FMFSEndItem := TSI;
          FMFSEndCoord.x := Pos.x + FOwner.FHPos;
          FMFSEndCoord.y := Pos.y - R.Top;
        end;
        SelectMouseSelectItems;
        FOwner.DoAfterSelectionChange;
      end;
      DrawMouseSelectFrame;
    end
    else
      SetVPosition(FOwner.FTopIndex - Dy);

    Message.Msg := WM_MOUSEMOVE;
    Message.Keys := 0;
    Message.Pos := Msg.Pos;
    Message.Result := 0;
    WMMouseMove(Message);
    end;
  inherited;
end;  { CMMouseWheel }

procedure TElTreeView.WMMouseWheel(var Msg: TWMMouseWheel); { private }
var
  LMsg: TCMMouseWheel;
begin
  inherited;
  LMsg := TCMMouseWheel(Msg);
  CMMouseWheel(LMsg);
  Msg.Result := LMsg.Result;
end; { WMMouseWheel }

procedure TElTreeView.OnHintTimer;
begin
  if FHintItem <> nil then
  begin
    DoHideLineHint;
    exit;
  end;

  if FInpEdit <> nil then exit;

  if FHintTimer = nil then exit;
  FHintTimer.Enabled := false;
  if not FOwner.HandleAllocated then exit;

  if (not (csDesigning in ComponentState)) then
  begin
    TryStartHint(FHintCoord.X, FHintCoord.Y);

    if FOwner.FHintHide then
    begin
      if FOwner.FLineHintTimeout <= 0 then
      begin
        FHintTimer.Interval := Application.HintHidePause;
        if FHintTimer.Interval = 0 then
          FHintTimer.Interval := 1000;
      end
      else
        FHintTimer.Interval := FOwner.FLineHintTimeout;
      FHintTimer.Enabled := true;
    end;
  end;
end;

procedure TElTreeView.SetHPosition(value: integer);
var
  Code: Word;
  Form: TCustomForm;
begin
  FOwner.IsUpdating := true;
  try
    if csReading in ComponentState then
      FOwner.FHPos := Value
    else
    begin
      if Value > FHRange - ClientWidth then
        Value := FHRange - ClientWidth;
      //if Value > FHRange then Value := FHRange;
      if Value < 0 then Value := 0;
      if Value <> FOwner.FHPos then
      begin
        FOwner.FHPos := Value;
        with FOwner do
        begin
          FHeader.LeftPos := FHPos;
          {//LockedColumn, update
           FHeader.Left := -FHPos;
          FHeader.Width := FHPos + FView.Width;}
        end;
        FClearAll := true;
        if csDesigning in ComponentState then
        begin
          Form := GetParentForm(self);
          if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
          end;
        FOwner.FUpdated := true;
        FRangeUpdate := true;
      end;
      Code := SB_CTL;
      with FOwner do
        if Windows.GetScrollPos(FHScrollBar.Handle, Code) <> FHPos then
          SetScrollPos(FHScrollBar.Handle, Code, FHPos, true);
      FOwner.TriggerScrollEvent(sbHorizontal, 0{ScrollCodesToInt[ScrollCode]});
    end;
  finally
    FOwner.IsUpdating := false;
  end;
end;

procedure TElTreeView.SetVPosition(value: integer);
var
  MaxV: integer;

  Code: Word;
  Form: TCustomForm;
begin
  FOwner.IsUpdating := true;
  try
    FTrackItem := nil;
    if csReading in ComponentState then
      FOwner.FTopIndex := Value
    else
    begin
      with FOwner do
      begin
        if TotalVarHeightCount > 0 then
        begin
          if TotalVisCount = 0 then
            GetTotalVisCount;
          maxV := CalcPageUpPos(TotalVisCount - 1);//TotalVisCount - CalcPageUpPos(TotalVisCount - 1);
        end
        else
        begin
          if TotalVisCount = 0 then
            GetTotalVisCount;
          maxV := TotalVisCount - GetVisCount + 1;
        end;
        if Value > maxV then Value := maxV;
      end;
      if Value < 0 then Value := 0;
      if Value <> FOwner.FTopIndex then
      begin
        FOwner.FUpdated := true;
        FClearVis := true;
        FClearAll := true;
        DoSetTopIndex(Value);
      end;
      if csDesigning in ComponentState then
      begin
        Form := GetParentForm(self);
        if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
        end;
      Code := SB_CTL;
      with FOwner do
        SetScrollPos(FVScrollBar.Handle, Code, FTopIndex, True);
      FOwner.TriggerScrollEvent(sbVertical, 0{ScrollCodesToInt[ScrollCode]});
    end;
  finally
    FOwner.IsUpdating := false;
  end;
end;

procedure TElTreeView.DoSetTopIndex;
var MaxV : integer;
  //  b : boolean;
begin
  (*
  b := false;
  if ((value >= Integer(FItems.Count)) and (value > 0)) then
    b := true
  else
  if (value < 0) then
    // Raise EElTreeError.Create(GetErrorMsg(STExOutOfBounds));
    value := 0;
  *)
  with FOwner do
  begin
    if TotalVisCount = 0 then
      GetTotalVisCount;
    if TotalVarHeightCount > 0 then
      maxV := CalcPageUpPos(TotalVisCount - 1)//TotalVisCount - //1// CalcPageUpPos(TotalVisCount - 1) + 1
    else
      maxV := TotalVisCount - View.GetVisCount + 1;
    if (Value < 0) or (MaxV < 0) then
      Value := 0
    else
    if Value > MaxV then
      Value := MaxV;
    FTopIndex := value;
    if (FTopIndex = 0) and (FItems.Count = 0) then
      FBottomIndex := 0
    else
    begin
      FillVisFwd(FTopIndex);
      FBottomIndex := FTopIndex + FVisible.Count - 1;
    end;
  end;
end;

procedure TElTreeView.FillVisFwd;
var i, j, k : integer;
    Item : TElTreeItem;
    ah, th, CurHeight : integer;
    ItemsAdded : integer;
begin
  FVisible.Clear;
  th := Height;
  i := 0;
  j := FOwner.FAllList.Count;
  k := 0;
  ItemsAdded := 0;
  CurHeight := 0;
  while k < j do
  begin
    Item := TElTreeItem(FOwner.FAllList[k]);
    if (FOwner.FilteredVisibility and Item.Hidden) then
      k := FOwner.FAllList.IndexOfFrom(k, Item.GetLastSubItem)
    else
    begin
      if i >= StartIndex then
      begin
        if (CurHeight > th) then break;
        if FOwner.TotalVarHeightCount > 0 then
           ah := Item.GetHeight
        else
           ah := FOwner.LineHeight;
        FVisible.Add(Item);

        // refresh virtuality cache
        if (FOwner.VirtualityLevel >= vlAllProps) and (not (csDesigning in ComponentState)) then
        begin
          inc(ItemsAdded);
          FOwner.CacheItem(Item, ItemsAdded);
        end;

        inc(CurHeight, ah);
        if (CurHeight > th) then break;
      end;
      if (Item.FChildren <> nil) and (Item.FChildren.Count > 0) then
         if not Item.Expanded then
           k := FOwner.FAllList.IndexOfFrom(k, Item.GetLastSubItem);
      inc(i);
    end;
    inc(k);
  end;
end;

(*
procedure TElTreeView.FillVisFwd;
var i, j, k : integer;
    Item : TElTreeItem;
    ah, th, CurHeight : integer;
    ItemsAdded : integer;
begin
  FVisible.Clear;
  th := Height;
  j := FOwner.FAllList.Count;
  i := 0;

  if FOwner.FilteredVisibility then
  begin
    k := 0;
    ItemsAdded := 0;
    CurHeight := 0;
    while k < j do
    begin
      Item := TElTreeItem(FOwner.FAllList[k]);
      if Item.Hidden then
        k := FOwner.FAllList.IndexOfFrom(k, Item.GetLastSubItem)
      else
      begin
        if i >= StartIndex then
        begin
          if (CurHeight > th) then break;
          if FOwner.TotalVarHeightCount > 0 then
             ah := Item.GetHeight
          else
             ah := FOwner.LineHeight;
          FVisible.Add(Item);

          // refresh virtuality cache
          if (FOwner.VirtualityLevel >= vlAllProps) and (not (csDesigning in ComponentState)) then
          begin
            inc(ItemsAdded);
            FOwner.CacheItem(Item, ItemsAdded);
          end;

          inc(CurHeight, ah);
          if (CurHeight > th) then break;
        end;
        if (Item.FChildren <> nil) and (Item.FChildren.Count > 0) then
           if not Item.Expanded then
             k := FOwner.FAllList.IndexOfFrom(k, Item.GetLastSubItem);
        inc(i);
      end;
      inc(k);
    end;
  end
  else
  begin
    k := StartIndex;
    ItemsAdded := 0;
    CurHeight := 0;
    while k < j do
    begin
      if (CurHeight > th) then break;

      Item := TElTreeItem(FOwner.FAllList[k]);

      if not Item.FullyExpanded then
      begin
        Item := Item.FParent;
        while (Item <> nil) and Item.Expanded do
        begin
          if Item.FParent = nil then
            break;
          Item := Item.FParent;
        end;
        if not Item.Expanded then
          k := FOwner.FAllList.IndexOfFrom(k, Item.GetLastSubItem);
        inc(k);
        continue;
      end;

      if FOwner.TotalVarHeightCount > 0 then
         ah := Item.GetHeight
      else
         ah := FOwner.LineHeight;
      FVisible.Add(Item);

      // refresh virtuality cache
      if (FOwner.VirtualityLevel >= vlAllProps) and (not (csDesigning in ComponentState)) then
      begin
        inc(ItemsAdded);
        FOwner.CacheItem(Item, ItemsAdded);
      end;

      inc(CurHeight, ah);
      if (CurHeight > th) then break;
      if (Item.FChildren <> nil) and (Item.FChildren.Count > 0) then
         if not Item.Expanded then
           k := FOwner.FAllList.IndexOfFrom(k, Item.GetLastSubItem);
      inc(k);
    end;
  end;
end;
*)

procedure TElTreeView.WMSize(var Msg : TWMSize);  { private }

begin
  inherited;
  begin
    FOwner.IsUpdating := true;
    FOwner.FUpdated := true;
    FClearVis := true;
    FClearAll := true;
    FVisUpdated := true;
    DoSetTopIndex(FOwner.FTopIndex);
    FOwner.IsUpdating := false;
  end;

  if not (FOwner.BackgroundType in [bgtColorFill, bgtCenterBitmap]) then RedoTmpBmp;

  //Invalidate;
end;  { WMSize }

const ScrollCodesToInt : array [TElScrollCode] of Integer = (SB_LINEUP, SB_LINEDOWN, SB_PAGEUP, SB_PAGEDOWN, SB_THUMBPOSITION, SB_THUMBTRACK, SB_TOP, SB_BOTTOM, SB_ENDSCROLL, SB_ENDSCROLL + 1, SB_ENDSCROLL + 2);

procedure TElTreeView.OnHScroll(Sender: TObject; ScrollCode: TElScrollCode; var ScrollPos: Integer; var DoChange : boolean);
var AScrollCode : TElScrollCode;
begin
  AScrollCode := ScrollCode;
  if AScrollCode = escSndLineDown then
  begin
    if FOwner.FVScrollBar.SecondBtnKind = sbkOpposite then AscrollCode := escLineUp else
    if FOwner.FVscrollBar.SecondBtnKind = sbkPage then AScrollCode := escPageDown;
  end else
  if AScrollCode = escSndLineUp then
  begin
    if FOwner.FVscrollBar.SecondBtnKind = sbkOpposite then AscrollCode := escLineDown else
    if FOwner.FVscrollBar.SecondBtnKind = sbkPage then AScrollCode := escPageUp;
  end;

  if FInpEdit <> nil then DoEndEdit(false);

  with FOwner do
  case AScrollCode of
    escLineUp : SetHPosition(FHPos - 4);
    escLineDown: SetHPosition(FHPos + 4);
    escPageUp: SetHPosition(FHPos - Self.Width shr 1);
    escPageDown: SetHPosition(FHPos + Self.Width shr 1);
    escPosition: SetHPosition(ScrollPos);
    escTrack: if FHorzScrollTracking then SetHPosition(ScrollPos);
    escTop: SetHPosition(0);
    escBottom: SetHPosition(FHRange);
  end; // case
  FOwner.TriggerScrollEvent(sbHorizontal, ScrollCodesToInt[ScrollCode]);
  {with FOwner do
    if Flat or FUseCustomBars then DrawFlatBorder(false, false);
  }
  DoChange := false;
end;

procedure TElTreeView.OnVScroll(Sender: TObject; ScrollCode: TElScrollCode; var ScrollPos: Integer; var DoChange : boolean);
var AScrollCode : TElScrollCode;
    aNewPos     : integer;
    Message     : TWMMouseMove;
    P           : TPoint;
begin

  if (FInpEdit <> nil) then
  begin
    DoChange := false;
    FScrollFirstClick := not FScrollFirstClick;
    if FScrollFirstClick then
    begin
      FOwner.FVScrollbar.EndScroll;
      exit
    end
    else
    if ScrollCode <> escEndScroll then
      DoEndEdit(false);
  end
  else

    FScrollFirstClick := false;

  AScrollCode := ScrollCode;
  if AScrollCode = escSndLineDown then
  begin
    if FOwner.FVscrollBar.SecondBtnKind = sbkOpposite then
      AscrollCode := escLineUp
    else
    if FOwner.FVscrollBar.SecondBtnKind = sbkPage then
      AScrollCode := escPageDown;
  end else
  if AScrollCode = escSndLineUp then
  begin
    if FOwner.FVscrollBar.SecondBtnKind = sbkOpposite then
      AscrollCode := escLineDown
    else
    if FOwner.FVscrollBar.SecondBtnKind = sbkPage then
      AScrollCode := escPageUp;
  end;

  if FInpEdit <> nil then
    DoEndEdit(false);

  with FOwner do
  case AScrollCode of
    escLineUp:   SetVPosition(FTopIndex - 1);
    escLineDown: SetVPosition(FTopIndex + 1);
    escPageUp  :
      begin
        {aNewPos := CalcPageUpPos(FTopIndex);
        if (aNewPos = FTopIndex) and (FVisible.Count = 1) and (TotalVisCount <> 1) then dec(aNewPos);}
        if FOwner.TotalVarHeightCount > 0 then
           aNewPos := CalcPageUpPos(FTopIndex)
        else
           aNewPos := FTopIndex - (GetVisCount - 1);
        if aNewPos < 0 then aNewPos := 0;
        SetVPosition(aNewPos);
      end;
    escPageDown:
      begin
        if FOwner.TotalVarHeightCount > 0 then
           aNewPos := CalcPageDownPos(FTopIndex)
        else
           aNewPos := FTopIndex + (GetVisCount - 1);
        if (aNewPos = FTopIndex) and (FVisible.Count = 1) and (TotalVisCount <> 1) then inc(aNewPos);
        SetVPosition(aNewPos);
      end;
    escPosition: SetVPosition(ScrollPos);
    escTop:      SetVPosition(0);
    escBottom:   SetVPosition(TotalVisCount);
    escTrack:    if FVertScrollTracking then SetVPosition(ScrollPos);
  end; // case
  FOwner.TriggerScrollEvent(sbVertical, ScrollCodesToInt[ScrollCode]);
  {with FOwner do
    if Flat or FUseCustomBars then DrawFlatBorder(false, false);
  }
  if FMouseSel then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    Message.Msg := WM_MOUSEMOVE;
    Message.Keys := 0;
    Message.XPos := P.X;
    Message.YPos := P.Y;
    Message.Result := 0;
    WMMouseMove(Message);
    end;
  DoChange := false;
end;

type
  TSRec = record
    MaxHeight : integer;
    CurHeight : integer;
    LastItem  : TElTreeItem;
  end;
  PSRec = ^TSRec;
  procedure TElTreeView.IntPrevVis(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);

begin
 with PSRec(IterateData)^ do
 begin
   Inc(CurHeight, Item.GetHeight);
   if CurHeight > MaxHeight then
     ContinueIterate := false
   else
     LastItem := Item;
 end;
 end;

function TElTreeView.CalcPageUpPos;
var
  i : integer;
  SRec : TSRec;
begin
  i := CurIdx;
  if (i <= 0) or (FVisible.Count = 0) then
  begin
    result := 0;
    exit;
  end;
  SRec.MaxHeight := ClientHeight;
  SRec.CurHeight := 0;
  SRec.LastItem  := FOwner.FItems.GetVisItem(i);
  FOwner.FItems.IterateBackFrom(true, false, IntPrevVis, @SRec, SRec.LastItem); (*<+>*)
  if Assigned(SRec.LastItem) then
    result := SRec.LastItem.VisIndex
  else
    result := 0;
  end;

function TElTreeView.CalcPageDownPos;
var
  i : integer;
var
  SRec : TSRec;
begin
  i := CurIdx;
  if (i < 0) or (FVisible.Count = 0) then
  begin
    result := 0;
    exit;
  end;
    SRec.MaxHeight := ClientHeight;
  SRec.CurHeight := 0;
  SRec.LastItem  := FOwner.FItems.GetVisItem(i);
  FOwner.FItems.IterateFrom(true, false, IntPrevVis, @SRec, SRec.LastItem); (*<+>*)
  if Assigned(SRec.LastItem) then
    result := SRec.LastItem.VisIndex
  else
    result := 0;
  end;

procedure TElTreeView.DefineHRange;

  procedure CalcWidth(Item: TElTreeItem; {Index: integer; var ContinueIterate: boolean;
    IterateData: pointer; }Tree: TCustomElTree);
  var
    w: integer;

  begin
    w := Item.GetWidth;
    if w > FHRange then
      FHRange := w;
  end;

var i, j : integer;
    Item : TElTreeItem;

begin
  FHRange := -1;
  if not HandleAllocated then
    exit;
  j := FOwner.FAllList.Count;
  i := 0;
  while i < j do
  begin
    Item := TElTreeItem(FOwner.FAllList[i]);
    if (FOwner.FilteredVisibility and Item.Hidden) then
    begin
      i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end
    else
    begin
      CalcWidth(Item, FOwner);
      if not Item.Expanded then
         i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    inc(i);
  end;
  exit;

  //FItems.Iterate(true, @CalcWidth, nil);
end;

procedure TElTreeView.Paint;

begin
  FPainting := true;
  RedrawTree(Canvas, FOwner.FHPos, FVisible);
  FPainting := false;
end;

procedure TElTreeView.FillDragImage;
var
  ABmp: TBitmap;
  TIL : TImageList;
  i, j: integer;
  b,
  hwl : boolean;
  tt,
    bb: integer;
  R   : TRect;

  procedure IntRedrawItemTree(Index: integer; Surface: TBitmap);
  var
    R: TRect;
    SText: TLMDString;
    Item: TElTreeItem;
    R1, R3: TRect;
    //SaveStyle: TFontStyles;
    ImDrawStyle: TDrawingStyle;
    StImIndex: integer;

    BMP, amBMP: TBitmap;
    ar2 : TRect;

    FakeStaticDataEx : TElTreeItemStaticDataEx;
    CurStaticDataEx : TElTreeItemStaticDataEx;

  begin
    Item := TElTreeItem(FVisible[index]);
    SText := Item.Text;

    with FOwner do
    begin

      R := Self.GetItemRect(index);
      dec(R.Top, FDDY);
      dec(R.Bottom, FDDY);
      if RightAlignedView then
      begin
        if (FShowRoot and FShowLines) or (FShowButtons and FShowRootButtons) then dec(R.Right, ItemExt);
      end else
      begin
        if (FShowRoot and FShowLines) or (FShowButtons and FShowRootButtons) then Inc(R.Left, ItemExt);
      end;

      if RightAlignedView then
      begin
        dec(R.Right, Item.Level * ItemExt);
      end else
      begin
        inc(R.Left, Item.Level * ItemExt);
      end;

      if FShowImages then
      begin
        if (FImages <> nil) then
        begin
          ImDrawStyle := FImages.DrawingStyle;
          FImages.DrawingStyle := dsFocus;
          if (Item.FBoolData and (ibfFocused {or ibfSelected} or ibfExpanded)) = 0 then
            StImIndex := Item.ImageIndex
          else
            StImIndex := Item.StateImageIndex;
          if StImIndex = -1 then
            StImIndex := DoGetPicture(Item);
          if LMDInRange(StImIndex, 0, FImages.Count - 1) then
          begin
            if RightAlignedView then
            begin
              ar2.Left := R.Right - FImages.Width;
              ar2.Top := (R.Top + (R.Bottom - R.Top + 1) shr 1) - (FImages.Height shr 1);
              dec(R.Right, FImages.Width);
            end else
            begin
              ar2.Left := R.Left;
              ar2.Top := (R.Top + (R.Bottom - R.Top + 1) shr 1) - (FImages.Height shr 1);
              inc(R.Left, FImages.Width);
            end;

            if (FAlphaImages<>nil)and LMDInRange(StImIndex, 0, FAlphaImages.Count-1) then
            begin
              BMP := TBitmap.Create;
              BMP.Width := FImages.Width;
              BMP.Height := FImages.Height;
              ImageList_DrawEx(FImages.Handle, StImIndex, BMP.Canvas.Handle, 0, 0, 0, 0,
                clNone, clNone, ILD_Normal);

              ar2.Right := ar2.Left + BMP.Width;
              ar2.Bottom := ar2.Top + BMP.Height;

              amBMP := TBitmap.Create;
              amBMP.Width := FAlphaImages.Width;
              amBMP.Height := FAlphaImages.Height;
              ImageList_DrawEx(FAlphaImages.Handle, StImIndex, amBMP.Canvas.Handle, 0, 0, 0, 0,
                clNone, clNone, ILD_Normal);

              AlphaCopyRect2(Surface.Canvas.Handle, ar2, BMP.Canvas.Handle,
                rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

              BMP.Free;
              amBMP.Free;
            end
            else
              FImages.Draw(Surface.Canvas, ar2.Left, ar2.Top, StImIndex);
          end;
          FImages.DrawingStyle := ImDrawStyle;
        end;
      end; // Show images
      if RightAlignedView then
      begin
        dec(R.Right, (ItemExt div 3));
      end else
      begin
        inc(R.Left, (ItemExt div 3));
      end;

      if (FODFollowCol and (FHeader.Sections.Count > 0) and (FHeader.Sections[FMainTreeCol].Style = ElhsOwnerDraw))
        or ((not (FODFollowCol)) and (SText = FODMask)) then
      begin
        DoItemDraw(Item, Canvas, R, FMainTreeCol);
      end
      else
      begin
        FakeStaticDataEx := nil;
        CurStaticDataEx := Item.FStaticDataEx;
        if (FVirtualityLevel >= vlAllProps) and (not (csDesigning in ComponentState)) then
        begin
          if Item.FStaticDataEx <> nil then
            CurStaticDataEx := Item.FStaticDataEx
          else
          begin
            FakeStaticDataEx := TElTreeItemStaticDataEx.Create;
            CurStaticDataEx := FakeStaticDataEx;
            TriggerVirtualPropsNeeded(Item, [vptMainText, vptStyles, vptFontStyle{, vptCheck, vptButtons, vptImages}], FakeStaticDataEx);
          end;
        end;

        if (((CurStaticDataEx.FBoolData1 and ibfUseStyles) <> ibfUseStyles)) and
           FOwner.ShowColumns and (FHeader.Sections[FMainTreeCol].Style = elhsImageIndex) then
        begin
          BMP := TBitmap.Create;
          DrawCellImage(Surface.Canvas, Item, StrToIntDef(SText, -1), FMainTreeCol, Bmp, R);
          FreeAndNil(Bmp);
        end
        else
        begin
          with Surface.Canvas do
          begin
            if not Item.ParentFontStyle then
            begin
              with Surface.Canvas.Font do
              begin
                Style := [];
                if Item.Bold then Style := [fsBold];
                if Item.Italic then Style := Style + [fsItalic];
                if Item.Underlined then Style := Style + [fsUnderline];
                if Item.StrikeOut then Style := Style + [fsStrikeOut];
              end;
            end;
          end;
          R1 := R;
          SetRectEmpty(R3);
  if Item.IsHTML and (Copy(SText, 1, 6) = '<html>') then
          begin
            R3.Left := 0;
            R3.Top := 0;
            with FRender do
            begin
              Data.Charset := Surface.Canvas.Font.Charset;
              PrepareText(SText, 0, false);
              R3.Right := R.Right - R.Left;
//              R3.Right := Data.TextSize.cx;
              R3.Bottom := Data.TextSize.cy;
            end;
          end
          else
          begin
            if Item.Multiline and Item.WordWrap then
              R3.Right := R3.Left + R1.Right - R1.Left;
            LMDDrawText(Surface.Canvas.Handle, SText, Length(SText), R3, DT_NOPREFIX or MultiLineFlags[Item.Multiline] or WordWrapFlags[Item.Multiline, Item.WordWrap] or DT_CALCRECT);
          end;
          if RightAlignedView then
          begin
            R1.Left := R1.Right - (R3.Right - R3.Left);
          end else
          begin
            R1.Right := R1.Left + (R3.Right - R3.Left);
          end;
  if Item.IsHTML and (Copy(SText, 1, 6) = '<html>') then
          begin

            with FRender do
            begin
              //Charset := Surface.Canvas.Font.Charset;
              //PrepareText(SText, 0, false);
              Data.DefaultStyle := Surface.Canvas.Font.Style;
              Data.LinkColor := FOwner.LinkColor;
              Data.LinkStyle := FOwner.LinkStyle;

              DrawText(Surface.Canvas, Point(0, 0), R1, clNone);
            end;
          end else
  //SaveStyle := Surface.Canvas.Font.Style;
          begin
            if RightAlignedText then
            begin
              LMDDrawText(Surface.Canvas.Handle, SText, Length(SText), R1, DT_NOPREFIX or MultiLineFlags[Item.Multiline] or WordWrapFlags[Item.Multiline, Item.WordWrap] or DT_VCENTER or DT_RIGHT or DT_RTLREADING);
            end
            else
            begin
              LMDDrawText(Surface.Canvas.Handle, SText, Length(SText), R1, DT_NOPREFIX or MultiLineFlags[Item.Multiline] or WordWrapFlags[Item.Multiline, Item.WordWrap] or DT_VCENTER);
            end;
          end;
        end;
        FreeAndNil(FakeStaticDataEx);
        //Surface.Canvas.Font.Style := SaveStyle;
      end; // if ... else
    end;
  end;

  procedure DrawDragImages;
  var
    i: integer;
    R,
      R1: TRect;
    Right : integer;
  begin
    with FOwner do
    begin
      j := FVisible.Count;

      Right := 0;
      if FShowHeader then
      begin
        i := FHeader.Sections.Count - 1;
        while i > FHeader.Sections[FMainTreeCol].Position do
        begin
          if FHeader.Sections.ItemByPos[i].Visible then break;
          dec(i);
        end;
        Right := FHeader.Sections[i].Right;
      end;

      for i := 0 to j - 1 do
        if (TElTreeItem(FVisible[i]).Selected) then
        begin
          R := Self.GetItemRect(i);
          dec(R.Top, FDDY);
          dec(R.Bottom, FDDY);
          if FHorizontalLines then dec(R.Bottom, FDivLineWidth);
          R.Left := 0;
          r1 := r;
          if FShowHeader then
          begin
            if TElTreeItem(FVisible[i]).WholeLine then
              r1.right := Right
            else
              r1.right := FHeader.Sections[FMainTreeCol].Width
          end
          else
             r1.right := Max(FHRange, FHPos + ClientWidth);
          ABmp.Canvas.Font := Canvas.Font;
          ABmp.Canvas.Font.Color := FTextColor;
          ABmp.Canvas.Pen.Color := FTextColor;
          IntRedrawItemTree(i, ABmp);
        end;
    end;
  end;

begin
  FDragImages := nil;
  if FOwner.DragImageMode = dimNever then exit;
  b := false;
  hwl := false;
  tt := -1;
  bb := -1;

  with FOwner do
    if DragImageMode = dimOne then
      for i := 0 to FVisible.Count - 1 do
      begin
        if (TElTreeItem(FVisible[i]).Selected) then
        begin
          if b then
          begin
            FDragImages := nil;
            exit;
          end
          else
          begin
            hwl := hwl or TElTreeItem(FVisible[i]).WholeLine;
            b := true;
            R := Self.GetItemRect(i);
            tt := R.Top;//i * LineHeight;
            bb := R.Bottom;
          end;
        end;
      end
    else
    begin
      for i := 0 to FVisible.Count - 1 do
      begin
        if (TElTreeItem(FVisible[i]).Selected) then
        begin
          hwl := hwl or TElTreeItem(FVisible[i]).WholeLine;
          R := Self.GetItemRect(i);
          bb := R.Bottom;
          if not b then
          begin
            tt := R.Top;
            b := true;
          end;
        end;
      end;
    end;
  TIL := TImageList.Create(self);
  TIL.Height := bb - tt + 1;
  FDDY := tt;

  with FOwner do
    if FMainTreeCol >= FHeader.Sections.Count then
      FMainTreeCol := 0;
  if FOwner.FShowHeader then
  begin
    if hwl then
    begin
      i := FHeader.Sections.Count - 1;
      while i > FHeader.Sections[FOwner.FMainTreeCol].Position do
      begin
        if FHeader.Sections.ItemByPos[i].Visible then break;
        dec(i);
      end;
      TIL.Width := FHeader.Sections[i].Right - FHeader.Sections[FOwner.FMainTreeCol].Left;
    end
    else
      TIL.Width := FHeader.Sections[FOwner.FMainTreeCol].Width;
  end
  else
    TIL.Width := Max(FHRange, FOwner.FHPos + Width);

  ABmp := TBitmap.Create;
  try
    ABmp.Width := TIL.Width;
    ABmp.Height := TIL.Height;
    ABmp.Handle := CreateCompatibleBitmap(Canvas.Handle, TIL.Width, TIL.Height);
    ABmp.TransparentMode := tmFixed;
    ABmp.TransparentColor := FOwner.FBkColor;
    ABmp.Canvas.FillRect(Rect(0, 0, ABMP.Width, ABMP.Height));
    ABmp.Canvas.Lock;
    try
      DrawDragImages;
    finally
      ABmp.Canvas.UnLock;
    end;
    TIL.AddMasked(ABmp, clDefault);
  finally
    ABmp.Free;
  end;
  FDragImages := TIL;
end;

procedure TElTreeView.DrawImages(ACanvas : TCanvas; Item : TElTreeItem; HelperBitmap : TBitmap; var R : TRect; var ItemRect : TRect);
var
  FTImages : TCustomImageList;
  FATImages : TCustomImageList;
  ImDrawStyle: TDrawingStyle;
  OvIndex  : integer;
  StImIndex: integer;
  h, w     : integer;
  R2       : TRect;

  procedure DoDrawImage;
  var
    xp : integer;
  amBmp : TBitmap;
  begin
    h := FTImages.Height;
    w := FTImages.Width;

    if FOwner.RightAlignedView then
      R2 := Rect(Max(R.Left, R.Right - w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), R.Right, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h)
    else
      R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), Min(R.Right, R.Left + w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h);

    if R2.Right >= R2.Left then
    begin
      HelperBitmap.PixelFormat := pfDevice;
      HelperBitmap.Height := R2.Bottom - R2.Top;
      HelperBitmap.Width  := R2.Right - R2.Left;

      bitblt(HelperBitmap.Canvas.Handle, 0, 0, HelperBitmap.Width, HelperBitmap.Height, ACanvas.Handle, R2.Left, R2.Top, srccopy);
      if FOwner.RightAlignedView then
        xp := HelperBitmap.Width - w
      else
        xp := 0;
      if OvIndex <> -1 then
      begin
        FTImages.DrawOverlay(HelperBitmap.Canvas, xp, 0, StImIndex, OvIndex);
      end
      else
      FTImages.Draw(HelperBitmap.Canvas, xp, 0, StImIndex);

      if (FATImages <> nil) and LMDInRange(StImIndex, 0, FATImages.Count - 1) then
      begin
        amBMP := TBitmap.Create;
        amBMP.Width := FATImages.Width;
        amBMP.Height := FATImages.Height;
        ImageList_DrawEx(FATImages.Handle, StImIndex, amBMP.Canvas.Handle, 0, 0, 0, 0,
          clNone, clNone, ILD_Normal);

        AlphaCopyRect2(ACanvas.Handle, r2, HelperBitmap.Canvas.Handle,
          rect(0, 0, HelperBitmap.Width, HelperBitmap.Height), amBMP, 255);

        amBMP.Free;
      end
      else
        bitblt(ACanvas.Handle, r2.Left, R2.Top, HelperBitmap.Width, HelperBitmap.Height, HelperBitmap.Canvas.Handle, 0, 0, srccopy);
      end;

    if FOwner.RightAlignedView then dec(R.Right, w) else inc(R.Left, w);
  end;

begin
  if R.Left >= R.Right then exit;

  with FOwner do
  begin
    if FImages2 <> nil then
    begin
      FTImages := FImages2;
      FATImages := FAlphaImages2;
      end else
    begin
      FTImages := FImages;
      FATImages := FAlphaImages;
      end;

    if FTImages <> nil then
    begin
      ImDrawStyle := FTImages.DrawingStyle;
      if FChStateImage and RowSelect then
      begin
        if Item.Selected or Item.Cut then
          FTImages.DrawingStyle := dsSelected
        else
        if Item.Focused then
          FTImages.DrawingStyle := dsFocus
        else
          FTImages.DrawingStyle := dsNormal;
      end
      else
      if FChStateImage and Item.Cut then
        FTImages.DrawingStyle := dsSelected;
      // draw 2nd image
      if (Item.Focused or Item.Selected or (Item.Expanded {and Item.HasVisibleChildren})) then
        StImIndex := Item.StateImageIndex2
      else
        StImIndex := Item.ImageIndex2;
      if StImIndex = -1 then
         StImIndex := DoGetPicture2(Item);
      OvIndex := Item.OverlayIndex2;
      if lmdInRange(StImIndex, 0, FTImages.Count - 1) then
      begin
        if Item.ShowCheckBox and FOwner.ShowCheckboxes then
          if RightAlignedView then
            dec(R.Right, ItemExt div 3)
          else
            inc(R.Left, ItemExt div 3);

        DoDrawImage;
        Item.FBoolData := Item.FBoolData or ibfImageDrawn2;
      end else
      begin
        if FShowEmptyImages2 then
        begin
          if FOwner.RightAlignedView then
            dec(R.Right, FTImages.Width)
          else
            inc(R.Left, FTImages.Width);
          Item.FBoolData := Item.FBoolData or ibfImageDrawn2;
        end
        else
          Item.FBoolData := Item.FBoolData and not ibfImageDrawn2;
      end;
      FTImages.DrawingStyle := ImDrawStyle;
      end;

    if (FImages <> nil) then
    begin
      FTImages := FImages;
      FATImages := FAlphaImages;
      ImDrawStyle := FImages.DrawingStyle;
      if FChStateImage and RowSelect then
      begin
        if Item.Selected or Item.Cut then
           FTImages.DrawingStyle := dsSelected
        else
           if Item.Focused then
              FTImages.DrawingStyle := dsFocus
           else
              FTImages.DrawingStyle := dsNormal;
      end
      else
        if FChStateImage and Item.Cut then
          FTImages.DrawingStyle := dsSelected;
      if (Item.Focused or Item.Selected or (Item.Expanded {and Item.HasVisibleChildren})) then
        StImIndex := Item.StateImageIndex
      else
        StImIndex := Item.ImageIndex;
      if StImIndex = -1 then
        StImIndex := DoGetPicture(Item);

      OvIndex := Item.OverlayIndex;
      if LMDInRange(StImIndex, 0, FTImages.Count - 1) then
      begin
        if RightAlignedView then
        begin
          if ((Item.FBoolData and ibfImageDrawn2) = ibfImageDrawn2) or
             (Item.ShowCheckBox and FOwner.ShowCheckboxes) then
            dec(R.Right, ItemExt div 3); // make the space between images
        end
        else
        begin
          if ((Item.FBoolData and ibfImageDrawn2) = ibfImageDrawn2) or
             (Item.ShowCheckBox and FOwner.ShowCheckboxes) then
            inc(R.Left, ItemExt div 3); // make the space between images
        end;
        DoDrawImage;
        Item.FBoolData := Item.FBoolData or ibfImageDrawn;
      end
      else
        if FShowEmptyImages then
        begin
          if RightAlignedView then
          begin
            if ((Item.FBoolData and ibfImageDrawn2) = ibfImageDrawn2) or
             (Item.ShowCheckBox and FOwner.ShowCheckboxes) then
              dec(R.Right, ItemExt div 3); // make the space between images
          end
          else
          begin
            if ((Item.FBoolData and ibfImageDrawn2) = ibfImageDrawn2) or
             (Item.ShowCheckBox and FOwner.ShowCheckboxes) then
              inc(R.Left, ItemExt div 3); // make the space between images
          end;
          if FOwner.RightAlignedView then
            dec(R.Right, FTImages.Width)
          else
            inc(R.Left, FTImages.Width);

          Item.FBoolData := Item.FBoolData or ibfImageDrawn;
        end
        else
          Item.FBoolData := Item.FBoolData and not ibfImageDrawn;
      FTImages.DrawingStyle := ImDrawStyle;
      end;
  end;
end;
{.$HINTS OFF}

{$WARNINGS OFF}
procedure TElTreeView.DrawButtons(ACanvas : TCanvas; Item : TElTreeItem; IsNode : boolean; HelperBitmap : TBitmap; var R : TRect; var ItemRect : TRect);
var FCCanvas : TCanvas;
    //FCBitmap : HBitmap;
    FCBitmap : TBitmap;
    R1 : TRect;
    w,
    h  : integer;
    TC : TColor;
    PX : TSize;
    //HR : HRESULT;
    LUseThemeMode: TLMDThemeMode;
    LDetails: TThemedElementDetails;
begin
  LUseThemeMode := FOwner.UseThemeMode;
  if R.Left >= R.Right then exit;
  with FOwner do
  begin
    h := 0;
    // w := 0;
    if LUseThemeMode <> ttmNone then
    begin
      if Item.Expanded then
        LDetails.State := GLPS_OPENED
      else
        LDetails.State := GLPS_CLOSED;
      //PX.cx := 0;
      //PX.cy := 0;
      SetRectEmpty(R1);

      LDetails.Part := TVP_GLYPH;
      LDetails.Element := teTreeview;
      LMDThemeServices.GetThemePartSize(LUseThemeMode, ACanvas.Handle, LDetails, PX);

      // GetThemePartSize(Theme, ACanvas.Handle, TVP_GLYPH, sid, nil, TS_TRUE, PX);
      w := Px.cx;
      h := Px.cy;
      //w := 10;
      //h := 10;
      LMDCenterRects(w + 1, ItemExt, h + 1, R.Bottom - R.Top + 1, R1);
    end
    else
    begin
      if FCustomPlusMinus then
      begin
        w := PlusPicture.Width;
        h := PlusPicture.Height;

        LMDCenterRects(w, ItemExt, h, R.Bottom - R.Top + 1, R1);

        if not IsNode then
        begin
          FCCanvas := FLeafPicture.Canvas;
          //FCBitmap := FPlusPicture.Handle;
          TC := FLeafPicture.Canvas.Pixels[0, h-1];
          //FCBitmap := FPlusPicture.Handle;
          FCBitmap := FLeafPicture;
        end
        else
        if not Item.Expanded then
        begin
          FCCanvas := FPlusPicture.Canvas;
          TC := FPlusPicture.Canvas.Pixels[0, h-1];
          FCBitmap := FPlusPicture;
        end else
        begin
          FCCanvas := FMinusPicture.Canvas;
          TC := FMinusPicture.Canvas.Pixels[0, h-1];
          FCBitmap := FMinusPicture;
        end;
      end
      else
      begin
        w := 10;
        LMDCenterRects(w, ItemExt, w, R.Bottom - R.Top + 1, R1);
        if not IsNode then
        begin
          FCCanvas := LeafBmp.Canvas;
          TC := LeafBmp.Canvas.Pixels[1, LeafBmp.Height-2];
          //FCBitmap := PlusBmp.Handle;
          FCBitmap := LeafBmp;
        end
        else
        if not Item.Expanded then
        begin
          FCCanvas := PlusBmp.Canvas;
          TC := PlusBmp.Canvas.Pixels[1, PlusBmp.Height-2];
          FCBitmap := PlusBmp;
        end else
        begin
          FCCanvas := MinusBmp.Canvas;
          TC := MinusBmp.Canvas.Pixels[1, MinusBmp.Height - 2];
          FCBitmap := MinusBmp;
        end;
      end;
    end;

    if RightAlignedView then
    begin
      R1 := Rect(max(R.Right - R1.Right, R.Left), R1.Top + R.Top, R.Right - (R1.Right - w), R1.Bottom + R.Top);
      if LUseThemeMode <> ttmNone then
      begin
        LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetails, Rect(R1.Right - w, R1.Top, R1.Right, R1.Top + h), LMDRectToPtr(R1));

        end
      else
      begin
        if FOwner.FTransButtons then
          DrawTransparentBitmapEx(ACanvas.Handle, FCBitmap, R1.Left, R1.Top, Rect(w - (R1.Right - R1.Left), 0, w, R1.Bottom - R1.Top), TC)
        else
          BitBlt(ACanvas.Handle, R1.Left, R1.Top, R1.Right - R1.Left + 1, R1.Bottom - R1.Top + 1, FCCanvas.Handle, w - (R1.Right - R1.Left), 0, SRCCOPY);
        end;
    end
    else
    begin
      OffsetRect(R1, R.Left, R.Top);
      if LUseThemeMode <> ttmNone then
      begin
        LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetails, Rect(R1.Left, R1.top, R1.Left + w, R1.Top + h), LMDRectToPtr(R1));

        end
      else
      begin
        if FOwner.FTransButtons then
          DrawTransparentBitmapEx(ACanvas.Handle, FCBitmap, R1.Left, R1.Top,
                                   Rect(0, 0, min(R1.Right - R1.Left, R.Right - R1.Left), R1.Bottom - R1.Top), TC)
        else
          BitBlt(ACanvas.Handle, R1.Left, R1.Top, min(R1.Right - R1.Left + 1, R.Right - R.Left), R1.Bottom - R1.Top + 1, FCCanvas.Handle, 0, 0, SRCCOPY);
        end;
    end;
  end;
end;

{$WARNINGS ON}
procedure TElTreeView.DrawCheckBoxes(ACanvas : TCanvas; Item : TElTreeItem; HelperBitmap : TBitmap; var R : TRect; var ItemRect : TRect);
var
  cbh,
  cbw,
  i    : integer;
  R1,
  R2,
  R3   : TRect;
  ADC   : HDC;
  HObj  : HGDIObj;
  PX    : TSize;
  sid   : integer;
  // ATheme: HTheme;
  CurStaticDataEx : TElTreeItemStaticDataEx;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
begin
  LUseThemeMode := FOwner.UseThemeMode;
  CurStaticDataEx := Item.FStaticDataEx;
  with FOwner do
  begin
    if (CurStaticDataEx.FBoolData1 and ibfShowCheckBox) = ibfShowCheckBox then
    begin
      cbw := 0;
      try
        {
        if RightAlignedView then
          dec(R.Right, 2)
        else
          inc(R.Left, 2);
        }
        if (LUseThemeMode <> ttmNone) and (not FCustomCheckBoxes) then
        begin
          SetRectEmpty(R1);
          // ATheme := LMDThemeService.Theme[tiButton];
          (* if ATheme <> 0 then
          begin *)
            SetRectEmpty(R1);

            if CurStaticDataEx.CheckBoxType = ectRadioButton then
              sid := Ord(tbCheckBoxUncheckedNormal) //!!!
            else
              sid := Ord(tbCheckBoxUncheckedNormal);

            LDetails := LMDThemeServices.GetDetails(teButton, sid);
            if not LMDThemeServices.GetThemePartSizeNew(LUseThemeMode,
              Canvas.Handle, LDetails, PX) then
            begin
              Px.cx := 16;
              Px.cy := 16;
            end;

            cbw := Px.cx;
            cbh := Px.cy;
          (* end
          else
          begin
            cbw := FCheckBoxSize;
            cbh := FCheckBoxSize;
          end;
          *)
          if CurStaticDataEx.CheckBoxType = ectRadioButton then
          begin
            if not Item.Checked then
            begin
              if not Item.CheckBoxEnabled then
                sid := Ord(tbRadioButtonUncheckedDisabled)
              else
                sid := Ord(tbRadioButtonUncheckedNormal);
            end
            else
            begin
              if not Item.CheckBoxEnabled then
                sid := Ord(tbRadioButtonCheckedDisabled)
              else
                sid := Ord(tbRadioButtonCheckedNormal);
            end;
          end
          else
          begin
            case CurStaticDataEx.CheckBoxState of
              cbUnchecked :
                if (not Item.CheckboxEnabled) or (not FOwner.Enabled) then
                  sid := Ord(tbCheckBoxUncheckedDisabled)
                else
                  sid := Ord(tbCheckBoxUncheckedNormal);

              cbChecked :
                if (not Item.CheckboxEnabled) or (not FOwner.Enabled) then
                  sid := Ord(tbCheckBoxCheckedDisabled)
                else
                  sid := Ord(tbCheckBoxCheckedNormal);

              cbGrayed :
                if (not Item.CheckboxEnabled) or (not FOwner.Enabled) then
                  sid := Ord(tbCheckBoxMixedDisabled)
                else
                  sid := Ord(tbCheckBoxMixedNormal);
            end;
          end;
          if RightAlignedView then
          begin
            R2 := Rect(Max(R.Left, R.Right - cbw), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (cbh shr 1), R.Right, R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbh shr 1 + 1);
            R3 := Rect(R2.Right - cbw, r2.top, R2.Right, r2.Top + cbh);
          end
          else
          begin
            R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (cbh shr 1), Min(R.Right, R.Left + cbw), R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbh shr 1 + 1);
            R3 := Rect(R2.Left, R2.Top, R2.Left + cbw, R2.Top + cbh);
          end;
          if R.Left >= R2.Right then
            Exit;

//          LDetails.Element := teButton;
//          LDetails.Part := pid;
//          LDetails.State := sid;

          LDetails := LMDThemeServices.GetDetails(teButton, sid);
          LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetails,
                                       R3, LMDRectToPtr(R2));
        end
        else if FCustomCheckboxes then
        begin
          if CurStaticDataEx.CheckBoxType = ectRadioButton then
          begin
            cbh := FRadioButtonGlyph.Height;
            cbw := FRadioButtonGlyph.Width div 6;

            if not Item.Checked then
            begin
              if Item.CheckBoxEnabled then
                R3 := Rect(0, 0, cbw, cbh)
              else
                R3 := Rect(cbw, 0, cbw * 2, cbh);
            end
            else
            begin
              if Item.CheckBoxEnabled then
                R3 := Rect(cbw * 2, 0, cbw * 3, cbh)
              else
                R3 := Rect(cbw * 3, 0, cbw * 6, cbh);
            end;
          end
          else
          if CurStaticDataEx.CheckBoxType = ectCheckBox then
          begin
            cbh := FCheckBoxGlyph.Height;
            cbw := FCheckBoxGlyph.Width div 6;

            if not Item.Checked then
            begin
              if Item.CheckBoxEnabled then
                R3 := Rect(0, 0, cbw, cbh)
              else
                R3 := Rect(cbw, 0, cbw * 2, cbh);
            end else
            begin
              if Item.CheckBoxEnabled then
                R3 := Rect(cbw * 2, 0, cbw * 3, cbh)
              else
                R3 := Rect(cbw * 3, 0, cbw * 4, cbh);
            end;
          end
          else
          begin
            cbh := FCheckBoxGlyph.Height;
            cbw := FCheckBoxGlyph.Width div 6;

            case Item.CheckBoxState of
              cbUnchecked:
                if Item.CheckBoxEnabled then R3 := Rect(0, 0, cbw, cbh)
                else R3 := Rect(cbw, 0, cbw * 2, cbh);
              cbChecked:
                if Item.CheckBoxEnabled then R3 := Rect(cbw * 2, 0, cbw * 3, cbh)
                else R3 := Rect(cbw * 3, 0, cbw * 4, cbh);
              cbGrayed:
                if Item.CheckBoxEnabled then R3 := Rect(cbw * 4, 0, cbw * 5, cbh)
                else R3 := Rect(cbw * 5, 0, cbw * 6, cbh);
            end;
          end;

          if RightAlignedView then
          begin
            R2 := Rect(R.Right - cbw + 1, R.Top + ((R.Bottom - R.Top + 1) shr 1) - cbh shr 1, R.Right, R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbw shr 1);

            if R.Left >= R2.Right then exit;
            if R.Left >= R.Right - cbw then
            begin
              R2.Left := R.Left;
              R3.Left := r3.Right - (R.Right - R.Left + 1);
              HelperBitmap.Width := R.Right - R2.Left;
            end
            else
              HelperBitmap.Width := cbw;
          end
          else
          begin
            R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - cbh shr 1, R.Left + cbw, R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbw shr 1);

            if R2.Left >= R.Right then exit;
            if R2.Left + cbw >= R.Right then
            begin
              R2.Right := R.Right;
              R3.Right := R3.Left + (R.Right - R.Left + 1);
              HelperBitmap.Width := R.Right - R.Left + 1;
            end
            else
              HelperBitmap.Width := cbw;
          end;
          HelperBitmap.Height := R2.Bottom - R2.Top + 1;

          bitblt(HelperBitmap.Canvas.Handle, 0, 0, HelperBitmap.Width, HelperBitmap.Height, ACanvas.Handle, r2.Left, R2.Top, srccopy);
          if CurStaticDataEx.CheckBoxType = ectRadioButton then
          begin
            FRadioButtonGlyph.Pixelformat := pfDevice;
            DrawTransparentBitmapEx(HelperBitmap.Canvas.Handle, FRadioButtonGlyph, 0, 0, R3, FRadioButtonGlyph.traNsparentcolor);
          end
          else
          begin
            FCheckBoxGlyph.Pixelformat := pfDevice;
            DrawTransparentBitmapEx(HelperBitmap.Canvas.Handle, FCheckBoxGlyph, 0, 0, R3, FCheckBoxGlyph.TransparentColor);
          end;
          bitblt(ACanvas.Handle, r2.Left, R2.Top, HelperBitmap.Width, HelperBitmap.Height, HelperBitmap.Canvas.Handle, 0, 0, srccopy);
          end
        else
        begin
          //cbw := ItemExt - 2;
          cbw := FOwner.CheckBoxSize;
          cbh := cbw;
          //cbh := ItemExt - 2;

          i := DFCS_BUTTONCHECK or DFCS_CHECKED;
          if CurStaticDataEx.CheckBoxType = ectRadioButton then
          begin
            if Item.Checked then i := DFCS_BUTTONRADIO or DFCS_CHECKED
            else i := DFCS_BUTTONRADIO;
          end else
            if CurStaticDataEx.CheckBoxType = ectCheckBox then
            begin
              if Item.Checked then i := DFCS_BUTTONCHECK or DFCS_CHECKED
              else i := DFCS_BUTTONCHECK;
            end else
            begin
              case CurStaticDataEx.CheckBoxState of //
                cbChecked: i := DFCS_BUTTONCHECK or DFCS_CHECKED;
                cbUnchecked: i := DFCS_BUTTONCHECK;
                cbGrayed: i := DFCS_BUTTON3STATE or DFCS_CHECKED;
              end; // case
            end;
          if ((CurStaticDataEx.FBoolData1 and ibfCheckBoxEnabled) <> ibfCheckBoxEnabled) or (not FOwner.Enabled) then
            i := i or DFCS_INACTIVE;
          if RightAlignedView then
          begin
            R2 := Rect(Max(R.Left, R.Right - (cbw - 2)), R.Top + ((R.Bottom - R.Top + 1) shr 1) - cbh shr 1, R.Right, R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbh shr 1);

            R3 := Rect(0, 0, cbw - 1, cbw - 1);
            if R.Left >= R2.Right then exit;
            if R.Left >= R.Right - cbw then
            begin
              R2.Left := R.Left;
              OffsetRect(R3, -(R.Left - (R.Right - cbw)), 0);
              HelperBitmap.Width := R.Right - R2.Left;
            end
            else
              HelperBitmap.Width := cbw;
          end
          else
          begin
            R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - cbh shr 1, Min(R.Right, R.Left + cbw), R.Top + ((R.Bottom - R.Top + 1) shr 1) + cbh shr 1);

            R3 := Rect(0, 0, cbw -1, cbw -1);
            if R2.Left >= R.Right then exit;
            if R2.Left + cbw >= R.Right then
            begin
              R2.Right := R.Right;
              HelperBitmap.Width := R.Right - R2.Left;
            end
            else
              HelperBitmap.Width := cbw;
          end;
          HelperBitmap.Height := cbw - 1;

          ADC := CreateCompatibleDC(ACanvas.Handle);
          HObj := SelectObject(ADC, HelperBitmap.Handle);
          bitblt(ADC, 0, 0, HelperBitmap.Width, HelperBitmap.Height, ACanvas.Handle, r2.Left, R2.Top, srccopy);

          //SetBkMode(ADC, OPAQUE);
          DrawFrameControl(ADC, R3, DFC_BUTTON, i);

          if FOwner.CheckBoxFlat then
          begin
            if CurStaticDataEx.CheckBoxType = ectRadioButton then
              DrawFlatRadioButtonFrame(FOwner, ADC, R3, Enabled)
            else
              DrawFlatCheckboxFrame(FOwner, ADC, R3, Enabled);
          end;
          bitblt(ACanvas.Handle, r2.Left, R2.Top, HelperBitmap.Width, HelperBitmap.Height, ADC, 0, 0, srccopy);
          SelectObject(ADC, HObj);
          DeleteDC(ADC);
          end;
      finally
        if RightAlignedView then
          dec(R.Right, cbw)
        else
          inc(R.Left, cbw);
      end;
    end;
  end;
end;

procedure TElTreeView.DrawItemLines(ACanvas : TCanvas; Item : TElTreeItem; var R : TRect; var ItemRect : TRect);

var
  Stack : TElStack;
  //ItemRoot,
  TSI,
    TSI1: TElTreeItem;
  SavePen    : TPenStyle;
  SavePenCol : TColor;

function GetPrevVisChild(Parent, Item: TElTreeItem; NoRoot : boolean): TElTreeItem;
  begin
    if NoRoot and (Item.FParent = FItems.FRoot) then
    begin
      result := nil;
      exit;
    end;
    Result := Parent.GetPrevChild(Item);
    if FOwner.FilteredVisibility then
      while Assigned(Result) and (Result.Hidden) do Result := Parent.GetPrevChild(Result);
  end;

  function GetNextVisChild(Parent, Item: TElTreeItem; NoRoot : boolean): TElTreeItem;
  begin
    if NoRoot and (Item.FParent = FItems.FRoot) then
    begin
      Result := nil;
      exit;
    end;
    Result := Parent.GetNextChild(Item);
    if FOwner.FilteredVisibility then
      while Assigned(Result) and (Result.Hidden) do Result := Parent.GetNextChild(Result);
  end;

  procedure DrawLine(Canvas : TCanvas; StartX, StartY, EndX, EndY : integer);
  var
    Coord: Integer;
    // CRef: COLORREF;
    // DC: HDC;
  begin
    Canvas.Pen.Style := psSolid;
    if FOwner.LinesStyle = psDot then
    begin
      // CRef := ColorToRGB(Canvas.Pen.Color);
      // skip a pixel if not in grid
      Coord := (StartX and 1) xor (StartY and 1);
      if StartX = EndX then
      begin
        // draw vertical line
        Inc(Coord, StartY);
        // DC := Canvas.Handle;
        while Coord < EndY do
        begin
          Canvas.MoveTo(StartX, Coord);
          Inc(Coord, 1);
          Canvas.LineTo(StartX, Coord);
          Inc(Coord, 1);
          (*
          SetPixel(DC, StartX, Coord, CRef);
          Inc(Coord, 2);
          *)
        end;
      end
      else
      begin
        // draw horizontal line
        Inc(Coord, StartX);
        //DC := Canvas.Handle;
        while Coord < EndX do
        begin
          Canvas.MoveTo(Coord, StartY);
          Inc(Coord, 1);
          Canvas.LineTo(Coord, StartY);
          Inc(Coord, 1);
          (*
          SetPixel(DC, Coord, StartY, CRef);
          Inc(Coord, 2);
          *)
        end;
      end;
    end
    else
    begin
      Canvas.MoveTo(StartX, StartY);
      Canvas.LineTo(EndX, EndY);

      {MoveToEx(Canvas.Handle, StartX, StartY, nil);
      LineTo(Canvas.Handle, EndX, EndY);}
    end;
  end;

  function GetNextNotLineSuppressedSibling(Item: TElTreeItem): TElTreeItem;
  var
    NextSibling: TElTreeItem;
  begin
    Result := nil;

    NextSibling := Item.GetNextSibling;
    while (NextSibling <> nil) and (Result = nil) do begin
      if not NextSibling.SuppressLines then Result := NextSibling;

      NextSibling := NextSibling.GetNextSibling;
    end;
  end;

begin
  inc(R.Bottom);
  try
    with FOwner do
    begin
      Stack := TElStack.Create;
      TSI := Item.Parent;
      SavePen := ACanvas.Pen.Style;
      SavePenCol := ACanvas.Pen.Color;
      ACanvas.Pen.Style := LinesStyle;
      ACanvas.Pen.Color := LinesColor;
      while TSI <> nil do
      begin
        Stack.Push(TSI);
        (*
        if TSI.SuppressLines and (ShowRoot or (TSI.FParent <> FItems.FRoot)) then
        begin //Eyal
          if RightAlignedView then
          begin
            inc(R.Right, ItemExt);
          end else
          begin
            dec(R.Left, ItemExt);
          end;
        end;
        *)
        TSI := TSI.Parent;
      end;
      //DC := ACanvas.Handle;

      if Item.FParent <> FItems.FRoot then
      begin
        TSI := Item;

        while TSI.FParent <> FItems.FRoot do
          TSI := TSI.FParent;
        if ShowRoot and (GetNextVisChild(TSI.FParent, TSI, false) <> nil) then
        begin
          if RightAlignedView then
          begin
            Inc(R.Right, ItemExt);
            if (R.Right - (ItemExt shr 1 {+ 4}) > R.Left) then
              DrawLine(ACanvas, R.Right - (ItemExt shr 1 {+ 4}), R.Top{ + ((R.Bottom - R.Top + 1) shr 1)}, R.Right - (ItemExt shr 1 {+ 4}), R.Top + (R.Bottom - R.Top + 1));
            Dec(R.Right, ItemExt);
          end
          else
          begin
            Dec(R.Left, ItemExt);
            if (R.Left + (ItemExt shr 1 {- 4}) < R.Right) then
              DrawLine(ACanvas, R.Left + (ItemExt shr 1 {- 4}), R.Top, R.Left + (ItemExt shr 1 {- 4}), R.Top + (R.Bottom - R.Top + 1));
            Inc(R.Left, ItemExt);
          end;
        end;
      end;

      if Stack.Count > 0 then
      begin
        TSI := TElTreeItem(Stack.Pop);
        while Stack.Count > 0 do
        begin
          TSI1 := TSI;

          if Stack.Count > 0 then
          begin
            TSI := TElTreeItem(Stack.Pop);

            if (GetNextVisChild(TSI1, TSI, true) <> nil) and ((R.Left + ItemExt shr 1) < R.Right) and
               (GetNextNotLineSuppressedSibling(TSI) <> nil) then
              if RightAlignedView then
              begin
                if (GetNextVisChild(TSI1, TSI, true) <> nil) and ((R.Right - ItemExt shr 1) > R.Left) then
                  DrawLine(ACanvas, R.Right - ItemExt shr 1, R.Top, R.Right - ItemExt shr 1, ItemRect.Bottom + 1);
              end
              else
              begin
                if (GetNextVisChild(TSI1, TSI, true) <> nil) and ((R.Left + ItemExt shr 1) < R.Right) then
                  DrawLine(ACanvas, R.Left + ItemExt shr 1, R.Top,  R.Left + ItemExt shr 1, ItemRect.Bottom + 1);
              end;
          end;
          if RightAlignedView then
            dec(R.Right, ItemExt)
          else
            inc(R.Left, ItemExt);
        end;
        if RightAlignedView then
          dec(R.Right, ItemExt)
        else
          inc(R.Left, ItemExt);
      end;
      Stack.Free;

      if (Item.FParent <> Item.FRoot) then
      begin
        if RightAlignedView then
        begin
          inc(R.Right, ItemExt);
          if ((R.Right - ItemExt shr 1) > R.Left) then
          begin
            DrawLine(ACanvas, R.Right - ItemExt shr 1, R.Top, R.Right - ItemExt shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1));
            if not Item.SuppressLines then
              DrawLine(ACanvas, R.Right - ItemExt shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1), Max(R.Right - ItemExt, R.Left), R.Top + ((R.Bottom - R.Top + 1) shr 1));
          end;
        end
        else
        begin
          dec(R.Left, ItemExt);
          if ((R.Left + ItemExt shr 1) < R.Right) then
          begin
            if not Item.SuppressLines or (GetNextNotLineSuppressedSibling(Item) <> nil) then
              DrawLine(ACanvas, R.Left + ItemExt shr 1, R.Top, R.Left + ItemExt shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1));
            if not Item.SuppressLines then
              DrawLine(ACanvas, R.Left + ItemExt shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1), Min(R.Left + ItemExt, R.Right), R.Top + ((R.Bottom - R.Top + 1) shr 1));
          end;
        end;

        if (GetNextVisChild(Item.Parent, Item, true) <> nil) and
           (GetNextNotLineSuppressedSibling(Item) <> nil) then
        begin
          if RightAlignedView then
          begin
            if ((R.Right - ItemExt shr 1) > R.Left) then
              DrawLine(ACanvas, R.Right - ItemExt shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1), R.Right - ItemExt shr 1, R.Bottom + 1);
          end else
          begin
            if ((R.Left + ItemExt shr 1) < R.Right) then
              DrawLine(ACanvas, R.Left + ItemExt shr 1, R.Top + ((R.Bottom - R.Top + 1) shr 1), R.Left + ItemExt shr 1, R.Bottom + 1);
          end;
        end; //if
      end // if
      else
      begin
        if RightAlignedView then
          inc(R.Right, ItemExt)
        else
          dec(R.Left, ItemExt);

        if FShowRoot then
        begin
          if RightAlignedView then
          begin
            if (R.Right - (ItemExt shr 1{ + 4}) > R.Left) then
            begin
              if not Item.SuppressLines then
                DrawLine(ACanvas, R.Right - (ItemExt shr 1{ + 4}), R.Top + ((R.Bottom - R.Top + 1) shr 1), Max(R.Right - ItemExt, R.Left), R.Top + ((R.Bottom - R.Top + 1) shr 1));
              if GetPrevVisChild(Item.FParent, Item, false) <> nil then
                DrawLine(ACanvas, R.Right - (ItemExt shr 1 {+ 4}), R.Top, R.Right - (ItemExt shr 1 {+ 4}), R.Top + ((R.Bottom - R.Top + 1) shr 1));
              if not Item.SuppressLines then
                if GetNextVisChild(Item.FParent, Item, false) <> nil then
                   DrawLine(ACanvas, R.Right - (ItemExt shr 1 {+ 4}), R.Top + ((R.Bottom - R.Top + 1) shr 1), R.Right - (ItemExt shr 1 {+ 4}), R.Top + (R.Bottom - R.Top + 1));
            end;
          end else
          begin
            if (R.Left + (ItemExt shr 1 {- 4}) < R.Right) then
            begin
              if not Item.SuppressLines then
                DrawLine(ACanvas, R.Left + (ItemExt shr 1 {- 4}), R.Top + ((R.Bottom - R.Top + 1) shr 1), Min(R.Left + ItemExt, R.Right), R.Top + ((R.Bottom - R.Top + 1) shr 1));
              if GetPrevVisChild(Item.FParent, Item, false) <> nil then
                DrawLine(ACanvas, R.Left + (ItemExt shr 1 {- 4}), R.Top, R.Left + (ItemExt shr 1 {- 4}), R.Top + ((R.Bottom - R.Top + 1) shr 1));
              if (GetNextVisChild(Item.FParent, Item, false) <> nil) then
                if not Item.SuppressLines then
                  DrawLine(ACanvas, R.Left + (ItemExt shr 1 {- 4}), R.Top + ((R.Bottom - R.Top + 1) shr 1), R.Left + (ItemExt shr 1 {- 4}), R.Top + (R.Bottom - R.Top + 1));
            end;
          end;
        end;
      end;
      ACanvas.Pen.Style := SavePen;
      ACanvas.Pen.Color := SavePenCol;
    end;
  finally
    dec(R.Bottom);
  end;
end;

{.$HINTS OFF}
procedure TElTreeView.DoRedrawItemTree(ACanvas : TCanvas; HelperBitmap :
    TBitmap; Item: TElTreeItem; ItemRect, SurfRect: TRect);
var
  SText: TLMDString;
  R, R1,
  R2,
  R3, R4: TRect;
  AL, VAL    : integer;
  W,
  H     : integer;
  CurStyle : TElCellStyle;
  i        : integer;
  xxx      : TFontStyles;
  TransBk  : boolean;
  OwnBk    : boolean;
  xOffs    : integer;

  FData    : TLMDHTMLData;

  ANode    : boolean;
  AdjColor : TColor;
  CurStaticDataEx  : TElTreeItemStaticDataEx;
  HS, RHS  : TElHeaderSection;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
  lMultiLineEllipseFlags: array[boolean] of integer;

  function MainColumnIsImage : boolean;
  begin
    HS := FOwner.FHeader.Sections[FOWner.FMainTreeCol];
    if HS <> nil then
      result := HS.Style = elhsImageIndex
    else
      result := false;
  end;

begin
  lMultiLineEllipseFlags[false] := DT_END_ELLIPSIS*ord(FOwner.SinglelineEllipsis);
  lMultiLineEllipseFlags[true] := DT_END_ELLIPSIS*ord(FOwner.MultilineEllipsis);

  LUseThemeMode := FOwner.UseThemeMode;

  if FOwner.FShowHeader then
    HS := FOwner.FHeader.Sections[FOWner.FMainTreeCol]
  else
    HS := nil;

  OwnBk := FOverColors;
  TransBk := false;
  SText := Item.Text;
  xOffs := 0;

  CurStaticDataEx := Item.FStaticDataEx;

  with FOwner do
  begin
    if FShowHeader then
    begin
      if Item.WholeLine then
      begin
        i := FHeader.Sections.Count - 1;
        while i > HS.Position do
        begin
          if FHeader.Sections.ItemByPos[i].Visible then break;
          dec(i);
        end;
        RHS := FHeader.Sections.ItemByPos[i];
        R := Rect(HS.Left - FHPos - xOffs, ItemRect.Top, RHS.Right - FHPos  - xOffs, ItemRect.Bottom);
      end
      else
      begin

        if HS.Locked then
           xOffs := - FHPos;
  R := Rect(HS.Left - FHPos - xOffs, ItemRect.Top, HS.Right - FHPos  - xOffs, ItemRect.Bottom);
      end;

      if FVerticalLines and ((not FBarStyle) or FBSVLines) then
        Dec(R.Right, FDivLineWidth);
    end
    else
      R := Rect(SurfRect.Left - FHPos - xOffs, ItemRect.Top, SurfRect.Right - FHPos - xOffs, ItemRect.Bottom);
    //if not FHLines then
         //inc(R.Bottom, FDivLineWidth);
    if (CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles then
      if (FOwner.VirtualityLevel <> vlNone) then
      begin
        if FOwner.ShowColumns then
          al := MainTreeColumn
        else
          al := -1;
        FOwner.TriggerVirtualStyleNeeded(Item, al, VirtStyle);
      end;
    if (CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles then
    begin
      if Item.FStaticData <> nil then
      begin
        CurStyle := Item.MainStyle;
      end
      else
        CurStyle := VirtStyle;

      if FOverColors or (CurStyle.FOwnerProps and
         ((not ShowColumns) or (HS.SortMode = hsmNone) or (SortColumnColor = clNone))) then
      begin
        ACanvas.Brush.Color := FCurBkColor;
        ACanvas.Font.Color := FCurTextColor;
        if FOverColors then OwnBk := true;
      end
      else
      if (ShowColumns and (HS.SortMode <> hsmNone) and (SortColumnColor <> clNone)) then
      begin
        ACanvas.Brush.Color := SortColumnColor;
        OwnBk := true;
      end
      else
      begin
        ACanvas.Brush.Color := CurStyle.FCellBkColor;
        {if FOverColors then
          OwnBk := false
        else       }
          OwnBk := CurStyle.UseBkColor;
      end;
    end
    else
    if (ShowColumns and (HS.SortMode <> hsmNone) and (SortColumnColor <> clNone)) then
    begin
      ACanvas.Brush.Color := SortColumnColor;
      OwnBk := true;
    end
    else
    begin
      ACanvas.Brush.Color := FCurBkColor;
      ACanvas.Font.Color := FCurTextColor;
    end;
    if Item.Selected and (FHasFocus or (not HideSelection)) and ((not FBarStyle) and (Item.BorderStyle = ibsNone)) and
       ((((FSelectColumn = FMainTreeCol) {or (FSelectColumn = -1)}) and (FShowHeader)) or FRowSelect) and
       (FHighlightAlphaLevel = 255) then
    begin
      if not (FOwner.IsVistaSelNeed) then
      begin
        if FHasFocus then
          ACanvas.Brush.Color := FFocusedSelectColor
        else
          ACanvas.Brush.Color := FHideSelectColor;
      end;
      OwnBk := true;
    end;
    if (Item = FDropTrg) and (FDragTrgDrawMode in [ColorRect, SelColorRect])
       and ((((FSelectColumn = FMainTreeCol) {or (FSelectColumn = -1)}) and (FShowHeader)) or FRowSelect) and
       (FHighlightAlphaLevel = 255) then
    begin
      case FDragTrgDrawMode of
        ColorRect:
          begin
            if FDropAcc then
              ACanvas.Brush.Color := FOwner.FDragRectAcceptColor
            else
              ACanvas.Brush.Color := FOwner.FDragRectDenyColor;
          end;
        SelColorRect:
          ACanvas.Brush.Color := clHighlight;
      end; // case
      OwnBk := true;
    end;
    // now fill the background
    //if (not FHLines) or FBarStyle then
    //inc(R.Bottom);

    if (InSizeMove) and (BackgroundType = bgtColorFill)
    and ((csDesigning in ComponentState) or (ImageForm = nil))
    then
    begin
      if not OwnBk then
        ACanvas.Brush.Color := BkColor;
      ACanvas.FillRect(R);
    end
    else
    if OwnBk then
    begin
      if ((FHasFocus or not HideSelection) and Item.Selected and FOwner.IsVistaSelNeed) then
      begin
        if not RowSelect then
        begin
          LDetails.Element := teMenu;
          LDetails.Part := MENU_POPUPITEM;
          LDetails.State := MPI_HOT;
          LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetails, R, LMDRectToPtr(R));
        end
      end
      else
        ACanvas.FillRect(R);
    end;
    //if (not FHLines) or FBarStyle then dec(R.Bottom);

    if Item.IndentAdjust <> 0 then
    begin
      if RightAlignedView then
        dec(R.Right, Item.IndentAdjust)
      else
        inc(R.Left, Item.IndentAdjust);
    end;

    if RightAlignedView then
    begin
      if (FShowRoot and FShowLines) or (FShowButtons and (FShowRootButtons )) then
        dec(R.Right, ItemExt)
      else
        dec(R.Right, ItemExt div 5);
    end else
    begin
      if (FShowRoot and FShowLines) or (FShowButtons and (FShowRootButtons )) then
        Inc(R.Left, ItemExt)
      else
        Inc(R.Left, ItemExt div 5);
    end;

    (*
    if Item.Ancestor.SuppressLines then
    begin //Eyal
      if RightAlignedView then
      begin
        inc(R.Right, ItemExt);
      end else
      begin
        dec(R.Left, ItemExt);
      end;
    end;
    *)

    // draw tree and images
    if (FShowLines) and (not Item.SuppressLines) then
      DrawItemLines(ACanvas, Item, r, ItemRect)
    else
    begin
      if RightAlignedView then
        dec(R.Right, (Item.Level - 1) * ItemExt)
      else
        inc(R.Left, (Item.Level - 1) * ItemExt);
    end;

    (*
    if Item.Ancestor.SuppressButtons and (FShowRootButtons or (Item.FParent <> Items.FRoot)) then
    begin //Eyal
      if RightAlignedView then
      begin
        inc(R.Right, ItemExt);
      end else
      begin
        dec(R.Left, ItemExt);
      end;
    end;
    *)

    R4 := R;
    R4.Left := 0;
    DrawGutter(ACanvas, Item, R4);

    ANode := ((Item.HasVisibleChildren) or Item.ForceButtons);
    if FShowButtons  and (not Item.SuppressButtons) and
       (FShowRootButtons or (Item.FParent <> Items.FRoot)) and
       (ANode or ShowLeafButton) then
      DrawButtons(ACanvas, Item, ANode, HelperBitmap, R, ItemRect);

    if RightAlignedView then
      dec(R.Right, ItemExt)
    else
      inc(R.Left, ItemExt);

    if FShowCheckBoxes then
      DrawCheckBoxes(ACanvas, Item, HelperBitmap, R, ItemRect);

    Item.FBoolData := (Item.FBoolData and not ibfImageDrawn) and not ibfImageDrawn2;

    if (FShowImages) then
      DrawImages(ACanvas, Item, HelperBitmap, R, ItemRect);

{$WARNINGS off}
    if Item.FStaticData <> nil then
      CurStyle := Item.MainStyle
    else
      CurStyle := VirtStyle;
    if (FODFollowCol and (FHeader.Sections.Count > 0) and
        (FHeader.Sections[FMainTreeCol].Style = ElhsOwnerDraw)) or
       ((SText = FODMask) and (not (FODFollowCol)))
      or (((CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) and (CurStyle.FStyle = elhsOwnerDraw))
      then
    begin
      DoItemDraw(Item, ACanvas, R, FMainTreeCol);
      if RightAlignedView then
      begin
        dec(R.Right, ItemExt div 3);
        R1 := R;
        Item.FTextRect.Left := R1.Left + FHPos - xOffs;
        Item.FTextRect.Right := R1.Right + FHPos - xOffs;
        with FOwner do
          if not (ShowButtons or ShowLines or ShowImages or ShowCheckBoxes) then
            Inc(Item.FTextRect.Right, ItemExt div 3);
        inc(R1.Right);
      end
      else
      begin
        inc(R.Left, ItemExt div 3);
        R1 := R;
        Item.FTextRect.Left := R1.Left + FHPos + xOffs - 1;
        Item.FTextRect.Right := R1.Right + FHPos + xOffs + 1;

        with FOwner do
          if not (ShowButtons or ShowLines or ShowImages or ShowCheckBoxes) then
            Dec(Item.FTextRect.Left, ItemExt div 3);

        dec(R1.Left);
      end;
    end
    else
    begin
      // make the empty space, that relates to the text
      if RightAlignedView then
        dec(R.Right, ItemExt div 3)
      else
        inc(R.Left, ItemExt div 3);

      (*
      if Item.UseStyles and (CurStyle.Control <> nil) then
      begin
        CurStyle.Control.Paint(ACanvas, R);
      end
      else
      *)
      if (Item.UseStyles and (CurStyle.FStyle = elhsText)) or
      ((CurStaticDataEx.FBoolData1 and ibfUseStyles) <> ibfUseStyles) then
      begin
        xxx := [];
        if ((CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
        begin
          if FOverColors or (CurStyle.FOwnerProps and
             (Assigned(HS) and ((HS.SortMode = hsmNone) or (SortColumnColor = clNone)))) then
          begin
            ACanvas.Font.Color := FCurTextColor;
            ACanvas.Brush.Color := FCurBkColor;
            TransBk := false;
          end
          else
          if (ShowColumns and (HS.SortMode <> hsmNone) and (SortColumnColor <> clNone)) then
          begin
            ACanvas.Brush.Color := SortColumnColor;
            OwnBk := true;
          end
          else
          begin
            ACanvas.Brush.Color := CurStyle.FTextBkColor;
            ACanvas.Font.Color := CurStyle.FTextColor;
            if not CurStyle.UseBkColor then
              TransBk := true;
          end;
          if not CurStyle.FOwnerProps then
          with CurStyle do
          begin
            //if ACanvas.Font.Name <> FontName then
            ACanvas.Font.Name := FontName;
            xxx := FontStyles; //if ACanvas.Font.Style <> FontStyles then
            //if ACanvas.Font.Size <> FontSize then
            ACanvas.Font.Size := FontSize;
            AL := CurStyle.FTextFlags;

            VAL:= AL and (DT_TOP or DT_BOTTOM or DT_VCENTER);
            end
          else
          begin
            if ACanvas.Font.Name <> Font.Name then
              ACanvas.Font.Name := Font.Name;
            if ((CurStaticDataEx.FBoolData1 and ibfParentStyle) = ibfParentStyle) then
              xxx := Font.Style
            else
            begin
              if stsBold in CurStaticDataEx.FState then Include(xxx, fsBold);
              if stsItalic in CurStaticDataEx.FState then Include(xxx, fsItalic);
              if stsUnderlined in CurStaticDataEx.FState then Include(xxx, fsUnderline);
              if stsStrikeOut in CurStaticDataEx.FState then Include(xxx, fsStrikeout);
            end;
            //if ACanvas.Font.Size <> Font.Size then
              ACanvas.Font.Size := Font.Size;

            Al := DT_LEFT;
            if Assigned(FHeader) and (FShowHeader) and (FHeader.Sections.Count > FMainTreeCol) then
              case FHeader.Sections[FMainTreeCol].Alignment of
                hsaCenter: Al := DT_CENTER;
                hsaRight: Al := DT_RIGHT;
              end; // case


            AL := DT_NOPREFIX or MultiLineFlags[Item.Multiline] or AL or lMultiLineEllipseFlags[Item.Multiline];
            VAL := 0;
            end;
        end
        else
        begin
          if (ShowColumns and (HS.SortMode <> hsmNone) and (SortColumnColor <> clNone)) then
          begin
            ACanvas.Brush.Color := SortColumnColor;
            OwnBk := true;
          end
          else
            ACanvas.Brush.Color := FCurBkColor;

          ACanvas.Font.Color := FCurTextColor;
          if ACanvas.Font.Name <> Font.Name then ACanvas.Font.Name := Font.Name;
          if ((Item.FStaticDataEx.FBoolData1 and ibfParentStyle) = ibfParentStyle) then
            xxx := Font.Style
          else
          begin
            if stsBold in CurStaticDataEx.FState then Include(xxx, fsBold);
            if stsItalic in CurStaticDataEx.FState then Include(xxx, fsItalic);
            if stsUnderlined in CurStaticDataEx.FState then Include(xxx, fsUnderline);
            if stsStrikeOut in CurStaticDataEx.FState then Include(xxx, fsStrikeout);
          end;
          if not ((CurStaticDataEx.FBoolData1 and ibfParentColors) = ibfParentColors) then
          begin
            ACanvas.Font.Color := Item.Color;
            if ((CurStaticDataEx.FBoolData1 and ibfUseBkColor) = ibfUseBkColor) then
              ACanvas.Brush.Color := Item.BkColor
            else
               TransBk := true;
            OwnBk := (not FOverColors) or FRowOvColors;
          end;
          if ACanvas.Font.Size <> Font.Size then
            ACanvas.Font.Size := Font.Size;

          if FRightAlignedView then
            Al := DT_RIGHT
          else
            Al := DT_LEFT;

          AL := DT_NOPREFIX or MultiLineFlags[Item.Multiline] or AL or lMultiLineEllipseFlags[Item.Multiline];
          if RightAlignedText then AL := AL or DT_RTLREADING;
          VAL := 0;
        end;
        if (FTracking and (Item = FTrackItem)) and FUnderlineTracked then
          Include(xxx, fsUnderline);

        ACanvas.Font.Style := xxx;

        if Item.Selected and (FHasFocus or (not HideSelection)) and ((not FBarStyle) and (Item.BorderStyle = ibsNone)) and
           ((FSelectColumn = -1) or (FSelectColumn = FMainTreeCol) or FRowSelect or (not FShowHeader)) then
        begin
          if not (FOwner.IsVistaSelNeed) then
          begin
            if FHasFocus then
            begin
              ACanvas.Font.Color := FFocusedSelectTextColor;
              if (FHighlightAlphaLevel = 255) then
              begin
                ACanvas.Brush.Color := FFocusedSelectColor;
                TransBk := false;
              end;
            end
            else
            begin
              if (FHighlightAlphaLevel = 255) then
              begin
                ACanvas.Brush.Color := FHideSelectColor;
                TransBk := false;
              end;
              if not FHideSelect then
                ACanvas.Font.Color := FHideSelectTextColor;
            end;
            if (FHighlightAlphaLevel = 255) then
            begin
              OwnBk := true;
            end;
          end
          else
            OwnBk := (FSelectColumn = -1);
          if (RowSelect or FullRowSelect) then
            OwnBk := false;
        end;
        if (FTracking and (Item = FTrackItem)) then
           if Item.Selected and (FHasFocus or (not HideSelection)) and ((not FBarStyle) and (CurStaticDataEx.BorderStyle = ibsNone)) and
             (FRowSelect or (FSelectColumn = -1) or
             (FShowHeader and (FMainTreeCol = FSelectColumn))) then
             begin
               if not (FOwner.IsVistaSelNeed) then
               begin
                 if FHasFocus then
                 begin
                   if (FHighlightAlphaLevel = 255) then
                   ACanvas.Brush.Color := FFocusedSelectColor;
                   ACanvas.Font.Color := FFocusedSelectTextColor;
                 end
                 else
                 begin
                   if (FHighlightAlphaLevel = 255) then
                   ACanvas.Brush.Color := FHideSelectColor;
                   if not FHideSelect then
                     ACanvas.Font.Color := FHideSelectTextColor;
                 end;
               end;
             end
           else
              ACanvas.Font.Color := FOwner.TrackColor;

        if (Item = FDropTrg)
           and (FDragTrgDrawMode in [ColorRect, SelColorRect])
           and ((FSelectColumn = -1)
             or (FSelectColumn = FMainTreeCol)
             or FRowSelect
             or (not FShowHeader)) then
        begin

          case FDragTrgDrawMode of
            ColorRect:
              begin
                if FHighlightAlphaLevel = 255 then
                begin
                  if FDropAcc then
                    ACanvas.Brush.Color := FDragRectAcceptColor
                  else
                    ACanvas.Brush.Color := FDragRectDenyColor;
                  TransBk := false;
                end;
                ACanvas.Font.Color := clBtnText;
              end;
            SelColorRect:
              begin
                if FHighlightAlphaLevel = 255 then
                begin
                  ACanvas.Brush.Color := clHighlight;
                  TransBk := false;
                end;
                ACanvas.Font.Color := clHighlightText;
              end;
          end; // case
          if FHighlightAlphaLevel = 255 then
          begin
            OwnBk := true;
          end;
        end;

        SetRectEmpty(R3);
        ACanvas.Font.Charset := Font.Charset;

        if Item.IsHTML and (Copy(SText, 1, 6) = '<html>') then
        begin
          R3.Left := 0;
          R3.Top := 0;
          if VirtualityLevel = vlNone then
          begin
            FData := Item.FHTMLData;
            if FData = nil then
            begin
              R3.Right := 0;
              R3.Bottom := 0;
            end else
            begin
              R3.Right := R.Right - R.Left;
//              R3.Right := FData.TextSize.cx;
              R3.Bottom := FData.TextSize.cy;
            end;
          end
          else
          begin
            with FRender do
            begin
              Data.DefaultStyle := ACanvas.Font.Style;
              Data.DefaultFont  := ACanvas.Font.Name;
              Data.DefaultColor := ACanvas.Font.Color;
              Data.DefaultHeight := ACanvas.Font.Height;
              Data.Charset      := ACanvas.Font.Charset;

              PrepareText(SText, 0, false);
              R3.Right := R.Right - R.Left;
//              R3.Right := Data.TextSize.cx;
              R3.Bottom := Data.TextSize.cy;
            end;
          end;
        end
        else

        begin
          if Item.Multiline and Item.WordWrap then
            R3.Right := R3.Left + R.Right - R.Left;
          LMDDrawText(ACanvas.Handle, SText, Length(SText), R3, DT_NOPREFIX or MultiLineFlags[Item.Multiline] or WordWrapFlags[Item.Multiline, Item.WordWrap] or  DT_LEFT or DT_CALCRECT or DT_EXTERNALLEADING);
        //InflateRect(R, 2, 0);
        end;

        if RightAlignedView then
        begin
          R1 := R;
          inc(R1.Right, 2);
          R1.Left := Max(R1.Left, R1.Right - ((R3.Right - R3.Left + 1) + 4) + FDivLineWidth);
        end
        else
        begin
          R1 := R;
          dec(R1.Left);
          R1.Right := Min(R1.Left + (R3.Right - R3.Left + 1) + 4 - FDivLineWidth, R.Right);
        end;
        //InflateRect(R1, -1, -1);
        if R1.Left + 1 < R1.Right then
        begin

          if (Item.Multiline
          or Item.IsHTML)
          and (VAL = 0)
          and (LineHeight < (R1.Bottom - R1.Top)) then
            VAL := DT_TOP
          else
            VAL := DT_VCENTER;
          if RightAlignedText then
          begin
            R3.Left := R1.Right - Min(R1.Right - R.Left, R3.Right - R3.Left);
            R3.Right := R1.Right;
          end else
          begin
            R3.Right := Min(R1.Right - R.Left, R3.Right - R3.Left) + R1.Left;
            R3.Left := R1.Left;
          end;
          R3.Bottom := Min(R3.Bottom, R3.Top + (R1.Bottom - R1.Top));

          if (VAL and DT_BOTTOM) = DT_BOTTOM then
          OffsetRect(R3, 0, R1.Top + (R1.Bottom - r1.Top) - (R3.Bottom - R3.Top))
          else
          if (VAL and DT_VCENTER) = DT_VCENTER then
          OffsetRect(R3, 0, R1.Top + (((R1.Bottom - r1.Top) - (R3.Bottom - R3.Top)) shr 1))
          else
            OffsetRect(R3, 0, R1.Top);

          // === define TextRect begin
          if RightAlignedView then
          begin
            Item.FTextRect := Rect(R3.Left - 1, R1.Top, R3.Right + 1, R1.Bottom);

            with FOwner do
              if not (ShowButtons or ShowLines or ShowImages or ShowCheckBoxes) then
                Inc(Item.FTextRect.Right, ItemExt div 3);
          end
          else
          begin
            Item.FTextRect := Rect(R3.Left - 1, R1.Top, R3.Right + 1, R1.Bottom);

            with FOwner do
              if not (ShowButtons or ShowLines or ShowImages or ShowCheckBoxes) then
                Dec(Item.FTextRect.Left, ItemExt div 3);
          end;
          // === define TextRect end

          if OwnBk and (not TransBk) then
          begin
           if ((FHasFocus or not HideSelection) and Item.Selected and FOwner.IsVistaSelNeed) then
           begin
             LDetails.Element := teMenu;
             LDetails.Part := MENU_POPUPITEM;
             LDetails.State := MPI_HOT;
             LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetails, Item.FTextRect, LMDRectToPtr(Item.FTextRect));
           end
           else
              ACanvas.FillRect(Item.FTextRect);
            AdjColor := ACanvas.Brush.Color;
            end
          else
            AdjColor := clNone
          ;

          OffsetRect(Item.FTextRect, FHPos + xOffs, 0);

          if RightAlignedView then
            dec(R1.Right)
          else
            inc(R1.Left);
          ACanvas.Brush.Style := bsClear;

          if Item.IsHTML and (Copy(SText, 1, 6) = '<html>') then
          begin
            if VirtualityLevel = vlNone then
              FData := Item.FHTMLData
            else
              FData := FRender.Data;

            if FData <> nil then
            begin
              (*
              if RightAlignedText then
              begin
                R3.Left := R1.Right - Min(R1.Right - R.Left, R3.Right - R3.Left);
                R3.Right := R1.Right;
              end else
              begin
                R3.Right := Min(R1.Right - R.Left, R3.Right - R3.Left) + R1.Left;
                R3.Left := R1.Left;
              end;
              R3.Bottom := Min(R3.Bottom, R3.Top + (R1.Bottom - R1.Top));

              {$ifndef C LX_USED}
              if (VAL and DT_BOTTOM) = DT_BOTTOM then
              {$else}
              if (VAL and Integer(AlignmentFlags_AlignBottom)) = Integer(AlignmentFlags_AlignBottom) then
              {$endif}
                OffsetRect(R3, 0, R1.Top + (R1.Bottom - r1.Top) - (R3.Bottom - R3.Top))
              else
              {$ifndef C LX_USED}
              if (VAL and DT_VCENTER) = DT_VCENTER then
              {$else}
              if (VAL and Integer(AlignmentFlags_AlignVCenter)) = Integer(AlignmentFlags_AlignVCenter) then
              {$endif}
                OffsetRect(R3, 0, R1.Top + (((R1.Bottom - r1.Top) - (R3.Bottom - R3.Top)) shr 1) - 1)
              else
                OffsetRect(R3, 0, R1.Top);
              *)

              with FRender do
              begin
                SetData(FData);
                PrepareText(SText, R3.Right - R3.Left, Item.Multiline and Item.WordWrap);
                Data.LinkColor := FOwner.LinkColor;
                Data.LinkStyle := FOwner.LinkStyle;

                DrawTextEx(ACanvas, Point(0, 0), R3, true, ACanvas.Font.Color, FData.DefaultBgColor, FData.HighlightColor, FData.HighlightBgColor, AdjColor);
                if VirtualityLevel = vlNone then SetData(nil);
              end;
            end;
          end
          else
          begin
            LMDDrawText(ACanvas.Handle, SText, Length(SText), R3, VAL or MultiLineFlags[Item.Multiline] or WordWrapFlags[Item.Multiline, Item.WordWrap] or  DT_NOPREFIX or AL or DT_EXTERNALLEADING);
          end;
          if RightAlignedView then
            inc(R1.Right)
          else
            dec(R1.Left);

          (*
          // === define TextRect begin
          if RightAlignedView then
          begin
            Item.FTextRect := Rect(R3.Left - 1, R1.Top, R3.Right, R1.Bottom);

            with FOwner do
              if not (ShowButtons or ShowLines or ShowImages or ShowCheckBoxes) then
                Inc(Item.FTextRect.Right, ItemExt div 3);
          end
          else
          begin
            Item.FTextRect := Rect(R3.Left, R1.Top, R3.Right + 1, R1.Bottom);

            with FOwner do
              if not (ShowButtons or ShowLines or ShowImages or ShowCheckBoxes) then
                Dec(Item.FTextRect.Left, ItemExt div 3);
          end;
          OffsetRect(Item.FTextRect, FHPos + xOffs, 0);
          // === define TextRect end
          *)
        end
        else
        begin
          Item.FTextRect := Rect(R1.Left + FHPos + xOffs -1, R1.Top, R1.Left + FHPos + xOffs -1, R1.Bottom);
        end;
        ACanvas.Brush.Style := bsSolid;
      end
      else
      if ({not }Item.UseStyles) and (ShowColumns) and MainColumnIsImage then
      begin
        DrawCellImage(ACanvas, Item, StrToIntDef(Item.Text, -1), FMainTreeCol, HelperBitmap, R);
        Item.FTextRect := Rect(R.Left + FHPos + xOffs, R.Top, R.Right + FHPos + xOffs, R.Bottom);
      end
      else
      if (Item.UseStyles and (CurStyle.FStyle = elhsPictureOnly) and Assigned(CurStyle.FPicture)) then
      begin
        h := CurStyle.FPicture.Height;
        w := CurStyle.FPicture.Width;

        if RightAlignedView then
        begin
          R2 := Rect(((R.Left + R.Right) shr 1)-(w shr 1), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), Min(R.Right, ((R.Left + R.Right) shr 1)-(w shr 1) + w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h);
          // R2 := Rect(Max(R.Left, R.Right - w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), R.Right, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h);
          Item.FTextRect := Rect(R.Left + FHPos + xOffs, R.Top, R.Right + FHPos + xOffs, R.Bottom);

          if CurStyle.FPicture.Transparent then
          begin
          //R2 := Rect(0, 0, Min(CurStyle.FPicture.Width, R.Right - R.Left), Min(CurStyle.FPicture.Height, ((R.Bottom-R.Top+1) shr 1)- (h shr 1) + h));
          //DrawTransparentBitmapEx(ACanvas.Handle, CurStyle.FPicture.Handle, R.Left, R.Top + ((R.Bottom-R.Top + 1) shr 1)-(h shr 1), R2, CurStyle.FPicture.TransparentColor)
            DrawTransparentBitmapEx(ACanvas.Handle, CurStyle.FPicture, R2.Left, R2.Top, Rect(0, 0, R.Right - min(w, Max(R.Left, R.Right - w + 1) + 1), h), CurStyle.FPicture.TransparentColor);
            end
          else
          begin
            ACanvas.CopyRect(R2, CurStyle.FPicture.Canvas, Rect(0, 0, R.Right - min(w, Max(R.Left, R.Right - w + 1) + 1), h));
            end;
        end
        else
        begin
          R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), Min(R.Right, R.Left + w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h);
          Item.FTextRect := Rect(R.Left + FHPos + xOffs, R.Top, R.Right + FHPos + xOffs, R.Bottom);
          if CurStyle.FPicture.Transparent then
          begin
          //R2 := Rect(0, 0, Min(CurStyle.FPicture.Width, R.Right - R.Left), Min(CurStyle.FPicture.Height, ((R.Bottom-R.Top+1) shr 1)- (h shr 1) + h));
          //DrawTransparentBitmapEx(ACanvas.Handle, CurStyle.FPicture.Handle, R.Left, R.Top + ((R.Bottom-R.Top + 1) shr 1)-(h shr 1), R2, CurStyle.FPicture.TransparentColor)
            DrawTransparentBitmapEx(ACanvas.Handle, CurStyle.FPicture, R2.Left, R2.Top, Rect(0, 0, min(w, Min(R.Right, R.Left + w - 1) - R.Left + 1), h), CurStyle.FPicture.TransparentColor);
            end
          else
          begin
            ACanvas.CopyRect(R2, CurStyle.FPicture.Canvas, Rect(0, 0, min(w, Min(R.Right, R.Left + w - 1) - R.Left + 1), h));
            end;
        end;
      end;
    end; // if ... else
  end;
end;

procedure TElTreeView.DoRedrawItem;
var
  TSI: TElTreeItem;
  R, R1,
  RD, R2,
  R3: TRect;
  SText: TLMDString;
  i, j, k,
  h,
  w,
  al,
  val,
  hi,
  tw: integer;
  dfr : boolean;
  HS: TElHeaderSection;
  PrevPenColor : TColor;
  FTransBk     : boolean;
  flv: integer;
  CurStyle: TElCellStyle;

  OwnBk : boolean;
  xOffs : integer;
  xxx   : TFontStyles;
  aLockBmp : TBitmap;

  FData    : TLMDHTMLData;

  AdjColor : TColor;

  OldPenColor : TColor;
  CurStaticDataEx  : TElTreeItemStaticDataEx;
  HelperBmp : TBitmap;
  LRect : TRect;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
  lMultiLineEllipseFlags: array[boolean] of integer;

begin
  lMultiLineEllipseFlags[false] := DT_END_ELLIPSIS*ord(FOwner.SinglelineEllipsis);
  lMultiLineEllipseFlags[true] := DT_END_ELLIPSIS*ord(FOwner.MultilineEllipsis);

  LUseThemeMode := FOwner.UseThemeMode;
  aLockBmp := nil;
  TSI      := Item;
  xOffs := 0;
  HelperBmp := TBitmap.Create;

  CurStaticDataEx := Item.FStaticDataEx;

  with FOwner do
  begin
    r1 := Rect(SurfRect.Left - FHPos, ItemRect.Top, SurfRect.Right - 1 - FHPos, ItemRect.Bottom);
    flv := FDivLineWidth;
    if (not VerticalLines) or (FBarStyle and (not FBSVLines)) or
        (Item.BorderStyle <> ibsNone) then
      flv := 0;
    FOverColors := false;
    FRowOvColors:= false;
    if (not Item.ParentColors) and (Item.UseBkColor) then
    begin
      ACanvas.Brush.Color := Item.RowBkColor;
      FCurBkColor := Item.RowBkColor;
      FOverColors := true;
      FRowOvColors:= true;
    end;

    if TSI.Selected and (FHasFocus or (not HideSelection)) and ((not FBarStyle) and (Item.BorderStyle = ibsNone)) and
       FRowSelect then
    begin
      if FOwner.IsVistaSelNeed then
      begin
        if FullRowSelect then
        begin
          LDetails.Element := teMenu;
          LDetails.Part := MENU_POPUPITEM;
          LDetails.State := MPI_HOT;
          LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetails, ItemRect, LMDRectToPtr(ItemRect));
        end
      end
      else
      begin
        if FHasFocus then
        begin
          if (FHighlightAlphaLevel = 255) then
          begin
            ACanvas.Brush.Color := FFocusedSelectColor;
            FCurBkColor := FFocusedSelectColor;
          end;
          ACanvas.Font.Color := FFocusedSelectTextColor;
          FCurTextColor := clHighlightText;
        end
        else
        begin
          if (FHighlightAlphaLevel = 255) then
          begin
            FCurBkColor := FHideSelectColor;
            ACanvas.Brush.Color := FHideSelectColor;
          end;
          if not FHideSelect then
          begin
            ACanvas.Font.Color := FHideSelectTextColor;
            FCurTextColor := FHideSelectTextColor;
          end;
        end;
        if (FHighlightAlphaLevel = 255) then
        begin
          FOverColors := true;
        end;
        if FullRowSelect then
          LMDAlphaFillRect(ACanvas, ItemRect, ACanvas.Brush.color, FHighlightAlphaLevel);
      end;
    end
    else
    if (not ((not Item.ParentColors) and (Item.UseBkColor))) and StripedItems then
    begin
      if (FVisible.IndexOf(Item) + TopIndex) mod 2 = 0 then
        FCurBkColor := FStripedEvenColor
      else
        FCurBkColor := FStripedOddColor;
      FOverColors := true;
    end;
    if FRowSelect then
    begin
      if (TSI = FDropTrg) and (FDragTrgDrawMode in [ColorRect, SelColorRect]) and (FHighlightAlphaLevel = 255) then
      begin
        case FDragTrgDrawMode of
          ColorRect:
            begin
              if FDropAcc then
                ACanvas.Brush.Color := FOwner.FDragRectAcceptColor
              else
                ACanvas.Brush.Color := FOwner.FDragRectDenyColor;
              FCurBkColor := ACanvas.Brush.Color;
              ACanvas.Font.Color := clBtnText;
              FCurTextColor := clBtnText;
              FOverColors := true;
            end;
          SelColorRect:
            begin
              ACanvas.Brush.Color := clHighlight;
              ACanvas.Font.Color := clHighlightText;
              FCurBkColor := clHighlight;
              FCurTextColor := clHighlightText;
              FOverColors := true;
            end;
        end; // case
      end;
    end;
    k := FHeader.Sections.Count;
    if FShowHeader then
    begin

      if (FHeader.LockedSection <> nil) and (FHeader.LockedSection.Visible) then
      begin
        ALockBmp := TBitmap.Create;
        HS := FHeader.LockedSection;
        xOffs := 0; if HS.Locked then xOffs := - FHPos;
        R := Rect(HS.Left - FHPos - xOffs, ItemRect.Top, HS.Right - FHPos - flv - xOffs, ItemRect.Bottom);
        inc(R.Bottom, FDivLineWidth);
        ALockBmp.Width := R.Right - R.Left;
        ALockBmp.Height := R.Bottom - R.Top;
        ALockBmp.Handle := CreateCompatibleBitmap(ACanvas.Handle, ALockBmp.Width, ALockBmp.Height);
        BitBlt(ALockBmp.Canvas.Handle, 0, 0, ALockBmp.Width, ALockBmp.Height, ACanvas.Handle, R.Left, R.Top, SRCCOPY);
        end;

      for j := 0 to k do
      begin
        FTransBk := false;
        if (j = k) then
        begin

          if (FHeader.LockedSection = nil) then
            break
          else
            HS := FHeader.LockedSection;

        end
        else
        begin
          HS := FHeader.Sections.ItemByPos[j];

          if HS.Locked then Continue;

        end;
        if not HS.Visible then Continue;
        xOffs := 0;

        if HS.Locked then
          xOffs := - FHPos;

        OwnBk := FOverColors;
        hi := HS.Index;
        //if HS.Visible then
        begin

          if HS.Locked then
          begin
            R := Rect(HS.Left - FHPos - xOffs, ItemRect.Top, HS.Right - FHPos - flv - xOffs, ItemRect.Bottom);
            inc(R.Bottom, FDivLineWidth);
            BitBlt(ACanvas.Handle, R.Left, R.Top, ALockBmp.Width, ALockBmp.Height, ALockBmp.Canvas.Handle, 0, 0, SRCCOPY);
            end;

          if HS.Index = FMainTreeCol then
          begin
            DoRedrawItemTree(ACanvas, HelperBmp, Item, ItemRect, ItemRect);
          end
          else
          if (not Item.WholeLine) or
             ((not RightAlignedView) and (HS.Position < FHeader.Sections[FMainTreeCol].Position)) or
             (RightAlignedView and (HS.Position > FHeader.Sections[FMainTreeCol].Position)) then
          begin
            // check the proper section and subtext index
            i := hi;
            if VirtualityLevel = vlNone then
            begin
              if i > FMainTreeCol then
                dec(i);
              if i >= Item.ColumnText.Count then
                SText := ''
              else
                if HS.Password then
                  SText := '******'
                else
                  SText := Item.ColumnText[i];
            end
            else
            begin
              if HS.Password then
                SText := '******'
              else
                FOwner.TriggerVirtualTextNeeded(Item, i, SText);
            end;
            if ((CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
            begin
              if VirtualityLevel = vlNone then
              begin
                if (Item.FStaticData.FStyles = nil) or (i >= Item.FStaticData.FStyles.Count) or (HS.UseMainStyle) then
                   CurStyle := Item.MainStyle
                else
                   CurStyle := TElCellStyle(Item.FStaticData.FStyles[i]);
              end
              else
              begin
                Fowner.TriggerVirtualStyleNeeded(Item, i, VirtStyle);
                CurStyle := VirtStyle;
              end;
              if FOverColors or (CurStyle.FOwnerProps and
                ((HS.SortMode = hsmNone) or (SortColumnColor = clNone))) then
              begin
                ACanvas.Brush.Color := FCurBkColor;
                ACanvas.Font.Color := FCurTextColor;
              end
              else
              if ((HS.SortMode <> hsmNone) and (SortColumnColor <> clNone)) then
              begin
                ACanvas.Brush.Color := SortColumnColor;
                OwnBk := true;
              end
              else
              begin
                ACanvas.Brush.Color := CurStyle.FCellBkColor;
                if (not (Item.Selected and ((not FBarStyle) and (Item.BorderStyle = ibsNone)) and ((FSelectColumn = HS.Index) or FRowSelect))) or (FHighlightAlphaLevel < 255) then
                begin
                  if not CurStyle.UseBkColor then
                    FTransBk := true
                  else
                    OwnBk := true
                  ;
                end;
              end;
            end
            else
            if ((HS.SortMode <> hsmNone) and (SortColumnColor <> clNone)) then
            begin
              ACanvas.Brush.Color := SortColumnColor;
              OwnBk := true;
            end
            else
            begin
              ACanvas.Brush.Color := FCurBkColor;
              ACanvas.Font.Color := FCurTextColor;
            end;
            if Item.Selected and (FHasFocus or (not HideSelection)) and ((not FBarStyle) and (Item.BorderStyle = ibsNone)) and ((FSelectColumn = HS.Index) or FRowSelect) and (FHighlightAlphaLevel = 255) then
            begin
              if not FOwner.IsVistaSelNeed then
              begin
                if FHasFocus then
                   ACanvas.Brush.Color := FFocusedSelectColor
                else
                   ACanvas.Brush.Color := FHideSelectColor;
              end;
              OwnBk := true;
            end;
            if (TSI = FDropTrg) and (FDragTrgDrawMode in [ColorRect, SelColorRect])
               and (((not FRowSelect) and (FSelectColumn = hi)) or FRowSelect) and (FHighlightAlphaLevel = 255) then
            begin
              OwnBk := true;
              case FDragTrgDrawMode of
                ColorRect:
                  begin
                    if FDropAcc then
                      ACanvas.Brush.Color := FDragRectAcceptColor
                    else
                      ACanvas.Brush.Color := FDragRectDenyColor;
                  end;
                SelColorRect:
                  ACanvas.Brush.Color := clHighlight;
              end; // case
            end;
            // now fill the background

            R := Rect(HS.Left - FHPos - xOffs, ItemRect.Top, HS.Right {-1} - FHPos - flv - xOffs, ItemRect.Bottom);
            //if (not FHLines) or FBarStyle then

            if (InSizeMove) and (BackgroundType = bgtColorFill) and ((csDesigning in ComponentState)  or (ImageForm = nil)) then
            begin
              if not OwnBk then
                ACanvas.Brush.Color := BkColor;
              ACanvas.FillRect(R);
            end
            else
            if OwnBk and (not FTransBk) then
              if ((FHasFocus or not HideSelection) and Item.Selected and FOwner.IsVistaSelNeed) then
              begin
                if not RowSelect then
                begin
                  LDetails.Element := teMenu;
                  LDetails.Part := MENU_POPUPITEM;
                  LDetails.State := MPI_HOT;
                  LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetails, R, LMDRectToPtr(R));
                end
              end
              else
                ACanvas.FillRect(R);

            if (FODFollowCol and (HS.Style = ElhsOwnerDraw)) or ((not (FODFollowCol)) and (SText = FODMask))
              or (((Item.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) and (CurStyle.FStyle = elhsOwnerDraw))
              then
            begin
              R := Rect(HS.Left + 1 - FHPos - xOffs, ItemRect.Top + 1, HS.Right - (FHPos + flv {+ 1}) - xOffs, ItemRect.Bottom - 1);
              DoItemDraw(Item, ACanvas, R, hi);
            end
            else
            begin
              if Item.UseStyles and (not CurStyle.OwnerProps) and (CurStyle.Control <> nil) then
              begin
                if CurStyle.Control.Visible then
                begin
                  R := Rect(HS.Left - FHPos - xOffs, ItemRect.Top, HS.Right - (FHPos + flv + 1) - xOffs, ItemRect.Bottom);
                  InflateRect(R, -CurStyle.Control.BorderWidth, -CurStyle.Control.BorderWidth);
                  CurStyle.Control.Paint(FOwner, Item, ACanvas, R);
                end;
              end
              else
              if (Item.UseStyles and (CurStyle.OwnerProps or (CurStyle.FStyle = elhsText))) or (not Item.UseStyles) then
              begin
                if ((not Item.UseStyles)
                or CurStyle.OwnerProps
                ) and (HS.Style = elhsImageIndex) then
                begin
                  R := Rect(HS.Left - FHPos - xOffs, ItemRect.Top, HS.Right - (FHPos + flv + 1) - xOffs, ItemRect.Bottom);
                  DrawCellImage(ACanvas, Item, StrToIntDef(SText, -1), j, HelperBmp, R);
                end
                else
                begin
                  if ((CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) and (not CurStyle.OwnerProps) then
                  begin
                    AL := CurStyle.FTextFlags;
                    VAL := AL and (DT_TOP or DT_BOTTOM or DT_VCENTER);
                    if FOverColors or CurStyle.FOwnerProps then
                    begin
                      ACanvas.Font.Color := FCurTextColor;
                      ACanvas.Brush.Color := FCurBkColor;
                    end
                    else
                    begin
                      ACanvas.Brush.Color := CurStyle.FTextBkColor;
                      ACanvas.Font.Color := CurStyle.FTextColor;
                      if not CurStyle.UseBkColor then
                        FTransBk := true;
                      OwnBk := true;
                    end;
                    if not CurStyle.FOwnerProps then with CurStyle do
                    begin
                      if ACanvas.Font.Name <> FontName then ACanvas.Font.Name := FontName;
                      if ACanvas.Font.Style <> FontStyles then ACanvas.Font.Style := FontStyles;
                      if ACanvas.Font.Size <> FontSize then ACanvas.Font.Size := FontSize;
                    end
                    else
                    begin
                      if ACanvas.Font.Name <> Font.Name then ACanvas.Font.Name := Font.Name;
                      if ACanvas.Font.Style <> Font.Style then ACanvas.Font.Style := Font.Style;
                      if ACanvas.Font.Size <> Font.Size then ACanvas.Font.Size := Font.Size;
                    end;
                  end
                  else
                  begin
                    if ((CurStaticDataEx.FBoolData1 and ibfParentStyle) = ibfParentStyle) then
                      xxx := Font.Style
                    else
                    begin
                      if stsBold in CurStaticDataEx.FState then Include(xxx, fsBold);
                      if stsItalic in CurStaticDataEx.FState then Include(xxx, fsItalic);
                      if stsUnderlined in CurStaticDataEx.FState then Include(xxx, fsUnderline);
                      if stsStrikeOut in CurStaticDataEx.FState then Include(xxx, fsStrikeout);
                    end;
                    if not ((CurStaticDataEx.FBoolData1 and ibfParentColors) = ibfParentColors) then
                    begin
                      ACanvas.Font.Color := Item.Color;
                      if ((CurStaticDataEx.FBoolData1 and ibfUseBkColor) = ibfUseBkColor) then
                      begin
                        ACanvas.Brush.Color := Item.BkColor;
                        OwnBk := FRowOvColors;
                      end;
                    end;
                    if ACanvas.Font.Name <> Font.Name then
                      ACanvas.Font.Name := Font.Name;
                    if ACanvas.Font.Size <> Font.Size then
                      ACanvas.Font.Size := Font.Size;
                    ACanvas.Font.Style := xxx;

                    {
                    if ACanvas.Font.Name <> Font.Name then ACanvas.Font.Name := Font.Name;
                    if ACanvas.Font.Style <> Font.Style then ACanvas.Font.Style := Font.Style;
                    if ACanvas.Font.Size <> Font.Size then ACanvas.Font.Size := Font.Size;
                    }

                    if FRightAlignedText then AL := DT_RIGHT else Al := DT_LEFT;
                    if FRightAlignedText then
                    begin
                      case HS.Alignment of
                        hsaCenter: Al := DT_CENTER;
                        hsaRight: Al := DT_LEFT;
                      end; // case
                    end
                    else
                    begin
                      case HS.Alignment of
                        hsaCenter: Al := DT_CENTER;
                        hsaRight: Al := DT_RIGHT;
                      end; // case
                    end;
                    AL := AL or DT_NOPREFIX or MultiLineFlags[Item.Multiline] or lMultiLineEllipseFlags[Item.Multiline];
  VAL := 0;
  end;
                  if (FTracking and (Item = FTrackItem)) and FUnderlineTracked and FRowHotTrack then ACanvas.Font.Style := ACanvas.Font.Style + [fsUnderline];

                  if Item.Selected and (FHasFocus or (not HideSelection)) and ((not FBarStyle) and (Item.BorderStyle = ibsNone)) and ((FSelectColumn = hi) or FRowSelect) then
                  begin
                    if not (FOwner.IsVistaSelNeed) then
                    begin
                      if FHasFocus then
                      begin
                        if (FHighlightAlphaLevel = 255) then
                        ACanvas.Brush.Color := FFocusedSelectColor;
                        ACanvas.Font.Color := FFocusedSelectTextColor;
                      end else
                      begin
                        if (FHighlightAlphaLevel = 255) then
                        ACanvas.Brush.Color := FHideSelectColor;
                        if not FHideSelect then
                          ACanvas.Font.Color := FHideSelectTextColor;
                      end;
                      if (FHighlightAlphaLevel = 255) then
                      begin
                        OwnBk := true;
                      end;
                    end;
                  end;

                  if (TSI = FDropTrg) and (FDragTrgDrawMode in [ColorRect, SelColorRect])
                     and (((not FRowSelect) and (FSelectColumn = hi)) or FRowSelect) then
                  begin
                    case FDragTrgDrawMode of
                      ColorRect:
                        begin
                          if (FHighlightAlphaLevel = 255) then
                          begin
                            if FDropAcc then
                              ACanvas.Brush.Color := FDragRectAcceptColor
                            else
                              ACanvas.Brush.Color := FDragRectDenyColor;
                          end;
                          ACanvas.Font.Color := clBtnText;
                        end;
                      SelColorRect:
                        begin
                          if (FHighlightAlphaLevel = 255) then
                          ACanvas.Brush.Color := clHighlight;
                          ACanvas.Font.Color := clHighlightText;
                        end;
                    end; // case
                    if (FHighlightAlphaLevel = 255) then
                    begin
                      OwnBk := true;
                    end;
                  end;
                  R := Rect(HS.Left - FHPos - xOffs, ItemRect.Top, HS.Right - (FHPos + flv) - xOffs, ItemRect.Bottom);

                  SetRectEmpty(R3);
                  ACanvas.Font.Charset := Font.Charset;
                  if ((FHasFocus or not HideSelection) and Item.Selected and FOwner.IsVistaSelNeed) then
                    ACanvas.Brush.Style := bsClear;
                  if Item.IsHTML and (Copy(SText, 1, 6) = '<html>') then
                  begin
                    R3.Left := 0;
                    R3.Top := 0;
                    if VirtualityLevel = vlNone then
                    begin
                      FData := TLMDHTMLData(Item.FHTMLDataArray[i]);

                      if FData = nil then
                      begin
                        R3.Right  := 0;
                        R3.Bottom := 0;
                      end
                      else
                      with FRender do
                      begin
                        R3.Right := R.Right - R.Left;
//                        R3.Right := FData.TextSize.cx;
                        R3.Bottom := FData.TextSize.cy;
                      end;
                    end
                    else
                    begin
                      with FRender do
                      begin
                        Data.DefaultStyle := ACanvas.Font.Style;
                        Data.DefaultFont  := ACanvas.Font.Name;
                        Data.DefaultColor := ACanvas.Font.Color;
                        Data.DefaultHeight := ACanvas.Font.Height;
                        Data.Charset      := ACanvas.Font.Charset;

                        PrepareText(SText, R.Right - R.Left, Item.Multiline and Item.WordWrap);
//                        PrepareText(SText, 0, false);
                        R3.Right := R.Right - R.Left;
//                        R3.Right := Data.TextSize.cx;
                        R3.Bottom := Data.TextSize.cy;
                      end;
                    end;
                  end
                  else
  begin
                    if FTransBk then
                      ACanvas.Brush.Style := bsClear;
                    if Item.Multiline and Item.WordWrap then
                      R3.Right := R3.Left + R.Right - R.Left;

                    if FOwner.RightAlignedView then
                      R3.Right := Max(R3.Right - ItemExt div 5, R3.Left)
                    else
                      R3.Left := Min(R3.Left + ItemExt div 5, R3.Right);
                    LMDDrawText(ACanvas.Handle, SText, Length(SText), R3, DT_NOPREFIX or MultiLineFlags[Item.Multiline] or WordWrapFlags[Item.Multiline, Item.WordWrap] or  DT_CALCRECT);
                  end;
                  tw := R3.Right - R3.Left + FDivLineWidth * 2;
                  // define the rectangle for the text
                  // R := Rect(HS.Left - (FHPos + xOffs) {- FDivLineWidth}, ItemRect.Top, HS.Right - (FHPos + flv + 1) - xOffs {- FDivLineWidth}, ItemRect.Bottom);
                  R2 := R;
                  case (AL and (DT_LEFT or DT_RIGHT or DT_CENTER)) of
                  DT_LEFT:
                  begin
                        R.Right := Min(R.Left + tw + ItemExt div 3, R.Right);
                        R.Left := Min(R.Left + ItemExt div 5, R.Right);
                      end;
                  DT_RIGHT:
                  begin
                        R.Left := Max(R.Right - (tw + ItemExt div 3), R.Left);
                        R.Right := Max(R.Right - ItemExt div 5, R.Left);
                      end;
                  DT_CENTER:
                  begin
                        //InflateRect(R, -FDivLineWidth, 0);
                        R.Left := R.Left + ((R.Right - R.Left) shr 1 - Min(R.Right - R.Left, tw + 3) shr 1);
                        R.Right := R.Left + Min(R.Right - R.Left, tw + 3);
                      end;
                  end;

                  if (R.Left > R2.Right) then
                    R.Left := R2.Right;
                  if R.Right < R2.Left then
                    R.Right := R2.Left;

                  //InflateRect(R, 1, 1);
                  //if FHLines then inc(R.Bottom, FDivLineWidth);
                  AdjColor := clNone;
                  if OwnBk then
                  begin
                    ACanvas.FillRect(R);
                    AdjColor := ACanvas.Brush.Color;
                    end;
                  ACanvas.Brush.Style := bsClear;

                  if (Item.Multiline
                  or Item.IsHTML)
                  and (VAL = 0)
                  and (LineHeight < (R1.Bottom - R1.Top)) then
                  VAL := DT_TOP
                  else
                  VAL := DT_VCENTER;
                  if Item.IsHTML and (Copy(SText, 1, 6) = '<html>') then
                  begin
                    if RightAlignedText then
                    begin
                      R3.Left := R.Right - Min(R.Right - R.Left, R3.Right - R3.Left);
                      R3.Right := R.Right;
                    end else
                    begin
                      R3.Right := Min(R.Right - R.Left, R3.Right - R3.Left) + R.Left;
                      R3.Left := R.Left;
                    end;

                    R3.Bottom := Min(R3.Bottom, R3.Top + (R1.Bottom - R1.Top));

                    if (VAL and DT_BOTTOM) = DT_BOTTOM then
                    begin
                      OffsetRect(R3, 0, R.Top + (R.Bottom - R.Top) - (R3.Bottom - R3.Top));
                    end else
                    if (VAL and DT_VCENTER) = DT_VCENTER then
                    begin
                      OffsetRect(R3, 0, R.Top + (((R.Bottom - R.Top) - (R3.Bottom - R3.Top)) shr 1) - 1);
                    end else
                    begin
                      OffsetRect(R3, 0, R.Top);
                    end;
                    if VirtualityLevel = vlNone then
                      FData := TLMDHTMLData(Item.FHTMLDataArray[i])
                    else
                      FData := FRender.Data;

                    if FData <> nil then
                    with FRender do
                    begin
                      SetData(FData);
                      Data.LinkColor := FOwner.LinkColor;
                      Data.LinkStyle := FOwner.LinkStyle;
                      PrepareText(SText, R.Right - R.Left, Item.Multiline and Item.WordWrap);
                      DrawTextEx(ACanvas, Point(0, 0), R3, true, ACanvas.Font.Color, FData.DefaultBgColor, FData.HighlightColor, FData.HighlightBgColor, AdjColor);
                      if VirtualityLevel = vlNone then
                        SetData(nil);
                    end;
                  end
                  else
  begin
                    if RightAlignedText then
                    begin
                      R3.Left := R.Right - Min(R.Right - R.Left, R3.Right - R3.Left);
                      R3.Right := R.Right;
                    end else
                    begin
                      R3.Right := Min(R.Right - R.Left, R3.Right - R3.Left) + R.Left;
                      R3.Left := R.Left;
                    end;
                    R3.Bottom := Min(R3.Bottom, R3.Top + (R1.Bottom - R1.Top));

                    if (VAL and DT_BOTTOM) = DT_BOTTOM then
                    begin
                      OffsetRect(R3, 0, R.Top + (R.Bottom - R.Top) - (R3.Bottom - R3.Top) - 1);
                    end else
                    if (VAL and DT_VCENTER) = DT_VCENTER then
                    begin
                      OffsetRect(R3, 0, R.Top + (((R.Bottom - R.Top) - (R3.Bottom - R3.Top)) shr 1){ - 1});
                    end else
                    begin
                      OffsetRect(R3, 0, R.Top);
                    end;
                      LMDDrawText(ACanvas.Handle, SText, Length(SText), R3, DT_NOPREFIX or VAL or MultiLineFlags[Item.Multiline] or WordWrapFlags[Item.Multiline, Item.WordWrap] or  AL or DT_EXTERNALLEADING);
                    end;
                  ACanvas.Brush.Style := bsSolid;
                end;
              end
              else
              if Item.UseStyles and (CurStyle.FStyle = elhsPictureOnly) and Assigned(CurStyle.FPicture) then
              begin
                R := Rect(HS.Left - FHPos - xOffs, ItemRect.Top, HS.Right - (FHPos + flv + 1) - xOffs, ItemRect.Bottom);
                h := CurStyle.FPicture.Height;
                w := CurStyle.FPicture.Width;
                R2 := Rect(Max(R.Left, ((R.Left + R.Right) shr 1)-(w shr 1)), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), Min(R.Right, ((R.Left + R.Right) shr 1)-(w shr 1) + w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h);
//              R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), Min(R.Right, R.Left + w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h);
                if CurStyle.FPicture.Transparent then
                begin
                  //R2 := Rect(0, 0, Min(CurStyle.FPicture.Width, R.Right - R.Left), Min(CurStyle.FPicture.Height, ((R.Bottom-R.Top+1) shr 1)- (h shr 1) + h));
                  //DrawTransparentBitmapEx(ACanvas.Handle, CurStyle.FPicture.Handle, R.Left, R.Top + ((R.Bottom-R.Top + 1) shr 1)-(h shr 1), R2, CurStyle.FPicture.TransparentColor)
                  DrawTransparentBitmapEx(ACanvas.Handle, CurStyle.FPicture, R2.Left, R2.Top, Rect(0, 0, min(w, Min(R.Right, R.Left + w - 1) - R.Left + 1), h), CurStyle.FPicture.TransparentColor);
                end
                else
                  ACanvas.CopyRect(R2, CurStyle.FPicture.Canvas, Rect(0, 0, min(w, Min(R.Right, R.Left + w - 1) - R.Left + 1), h));
              end;
            end; // if/else
          end;
          if FVerticalLines and (((not FBarStyle) and (Item.BorderStyle = ibsNone)) or FBSVLines or FNotRaiseForBarStyle) then
          begin
            xOffs := 0;

            if HS.Locked then
              xOffs := - FHPos;

            i := HS.Right - FHPos - xOffs - 1;
            ACanvas.Pen.Color := VertDivLinesColor;
            OldPenColor := ACanvas.Pen.Color;

            if Item.UseStyles then
            begin
              if VirtualityLevel = vlNone then
              begin
                if (Item.FStaticData.FStyles = nil) or (j >= Item.FStaticData.FStyles.Count) or (HS.UseMainStyle) then
                   CurStyle := Item.MainStyle
                else
                   CurStyle := TElCellStyle(Item.FStaticData.FStyles[j]);
              end
              else
              begin
                Fowner.TriggerVirtualStyleNeeded(Item, j, VirtStyle);
                CurStyle := VirtStyle;
              end;
            end
            else
              CurStyle := nil;

            if (not Item.UseStyles and (Item.BkColor = FOwner.VertDivLinesColor)) or
               (Item.UseStyles and CurStyle.UseBkColor and (CurStyle.CellBkColor = FOwner.VertDivLinesColor) and (CurStyle.BorderStyle = ibsNone)) then
              ACanvas.Pen.Color := InvertColor(FOwner.VertDivLinesColor);
            LRect := ItemRect;
            LRect.Left := i;
            LRect.Bottom := LRect.Bottom + 1;
            DrawVertLine(ACanvas, Item, LRect);
            ACanvas.Pen.Color := OldPenColor;
          end
          else
            i := i;

          // draw bar styles for the cell (if needed)
          if Item.UseStyles then
          begin
            i := hi;
            if (hi = FMainTreeCol) and (VirtualityLevel = vlNone) then
              CurStyle := Item.MainStyle
            else
            begin
              if VirtualityLevel = vlNone then
              begin
                if i > FMainTreeCol then
                  dec(i);

                if (Item.FStaticData.FStyles = nil) or (i >= Item.FStaticData.FStyles.Count) or (HS.UseMainStyle) then
                   CurStyle := Item.MainStyle
                else
                  CurStyle := TElCellStyle(Item.FStaticData.FStyles[i]);
              end
              else
              begin
                Fowner.TriggerVirtualStyleNeeded(Item, i, VirtStyle);
                CurStyle := VirtStyle;
              end;
            end;

            if CurStyle.BorderStyle <> ibsNone then
            begin

              if HS.Locked then
              begin
                R := Rect(HS.Left - FHPos - xOffs, ItemRect.Top, HS.Right - FHPos - flv - xOffs, ItemRect.Bottom);
                inc(R.Bottom, FDivLineWidth);
              end
              else

                R := Rect(HS.Left - FHPos - xOffs, ItemRect.Top, HS.Right {-1} - FHPos - flv - xOffs, ItemRect.Bottom);
              //if (not FHLines) or FBarStyle then

              case CurStyle.BorderStyle of
                ibsRaised: DrawEdge(ACanvas.Handle, R, BDR_RAISEDINNER, BF_RECT);
                ibsFlat: DrawEdge(ACanvas.Handle, R, BDR_SUNKENOUTER, BF_FLAT or BF_RECT);
                ibsSunken: DrawEdge(ACanvas.Handle, R, BDR_SUNKENOUTER, BF_RECT);
                ibsSpace:
                  begin
                    Windows.SetBkColor(ACanvas.Handle, ColorToRGB(Item.BorderSpaceColor));
                    FrameRect(ACanvas.Handle, R, ACanvas.Brush.Handle);
                    end;
              end;
            end;
          end;

        end;
      end; //for

      if Item.StrikedOutLine then
      begin
        PrevPenColor := ACanvas.Pen.Color;
        if Item.Selected and (FHasFocus or (not HideSelection)) and ((not FBarStyle) and (Item.BorderStyle = ibsNone)) and FRowSelect then
        begin
          if FHasFocus then
            ACanvas.Pen.Color := FFocusedSelectTextColor
          else
          if not FHideSelect then
            ACanvas.Pen.Color := FHideSelectTextColor;
        end
        else
          ACanvas.Pen.Color := Item.StrikedLineColor;
        xOffs := 0;

            if (FHeader.Sections.Count = 1) and FHeader.Sections[0].Locked then
              xOffs := - FHPos;

        MoveToEx(ACanvas.Handle,Item.FTextRect.Left - 2 - (FHPos - xOffs), (ItemRect.Top + ItemRect.Bottom) shr 1 + 1 , nil);
        LineTo(ACanvas.Handle, FHeader.SectionsWidth - (FHPos - xOffs), (ItemRect.Top + ItemRect.Bottom) shr 1 + 1);
        ACanvas.Pen.Color := PrevPenColor;
      end;
    end
    else
    begin
      DoRedrawItemTree(ACanvas, HelperBmp, Item, ItemRect, ItemRect);
      if Item.StrikedOutLine then
      begin
        PrevPenColor := ACanvas.Pen.Color;
        if Item.Selected and (FHasFocus or (not HideSelection)) and ((not FBarStyle) and (Item.BorderStyle = ibsNone)) and FRowSelect then
        begin
          if FHasFocus then
            ACanvas.Pen.Color := FFocusedSelectTextColor
          else
          if not FHideSelect then
            ACanvas.Pen.Color := FHideSelectTextColor;
        end
        else
          ACanvas.Pen.Color := Item.StrikedLineColor;

        MoveToEx(ACanvas.Handle, Item.FTextRect.Left - 2 - FHPos, (ItemRect.Top + ItemRect.Bottom) shr 1 + 1 , nil);
        LineTo(ACanvas.Handle, Item.FTextRect.Right + FHPos, (ItemRect.Top + ItemRect.Bottom) shr 1 + 1);
        ACanvas.Pen.Color := PrevPenColor;
      end;
    end;
    if ALockBmp <> nil then ALockBmp.Free;

    if not (FRowSelect) then
    begin
      if (FSelectColumn = -1) or (not FShowHeader) or (FHeader.Sections.Count <= FSelectColumn) then
      begin
        // R1.left := TSI.FTextRect.Left - FHPos - xOffs + 1;
        // R1.Right := TSI.FTextRect.Right - FHPos - xOffs - 1;
        R1 := Item.FTextRect;
        OffsetRect(R1, - FHPos - xOffs, 0);
      end
      else
      begin
        k := 0;
        if FHeader.Sections.Count < 2 then
          i:= 0
        else
          for i := 0 to FHeader.Sections.Count - 2 do
          begin
            if FHeader.Sections[i].Visible then
            begin
              if (k = FSelectColumn) then
                Break;
              k := k + 1;
            end;
          end;
        HS := FHeader.Sections[i];
        R1.Left := HS.Left - FHPos - xOffs;
        R1.Right := R1.Left + HS.Width - xOffs;
        if FVerticalLines then
          dec(R1.Right, FDivLineWidth);
      end;
    end;

    begin
      RD := R1;

      if RowSelect then
      begin
        RD.Left := ItemRect.Left - FHPos;
        if FShowHeader then
        begin
    if LockedHeaderSection <> nil then RD.Left := 0;
    RD.Right := ClientWidth;
          if (FBarStyle or (Item.BorderStyle <> ibsNone)) then
          begin
            dec(RD.Right);
    if LockedHeaderSection <> nil then inc(RD.Left);
    end;
        end
        else
           RD.Right := ItemRect.Right + 1;
      end;

      Inc(RD.Bottom);

      if RowSelect then
      begin
        R1.Left := ItemRect.Left - FHPos;
        if FShowHeader then
        begin
  if LockedHeaderSection <> nil then R1.Left := 0;
  R1.Right := FHeader.SectionsWidth - FHPos - flv; //ItemRect.Right {- FHPos }- flv;
          if (FBarStyle or (Item.BorderStyle <> ibsNone)) then
          begin
            dec(R1.Right);
  if LockedHeaderSection <> nil then
              inc(R1.Left);
  end;
        end
        else
           R1.Right := ItemRect.Right(* - 1*);
      end
    end;

    //if not FHLines then
    dfr := FHasFocus or (not FHideFocusRect);
    FOwner.TriggerItemPostDrawEvent(ACanvas, Item, R1, dfr);

    if Item.Selected and (FHasFocus or (not HideSelection)) and ((not FBarStyle) and (Item.BorderStyle = ibsNone)) and
       (FHighlightAlphaLevel < 255) and not (FOwner.IsVistaSelNeed) then
    begin
      if FHasFocus then
        ACanvas.Brush.Color := FFocusedSelectColor
      else
        ACanvas.Brush.Color := FHideSelectColor;
      LMDAlphaFillRect(ACanvas, R1, ACanvas.Brush.color, FHighlightAlphaLevel);
    end;

    if (TSI = FDropTrg) and (FDragTrgDrawMode in [ColorRect, SelColorRect]) and (FHighlightAlphaLevel < 255) then
    begin
      case FDragTrgDrawMode of
        ColorRect:
          begin
            if FDropAcc then
              ACanvas.Brush.Color := FOwner.FDragRectAcceptColor
            else
              ACanvas.Brush.Color := FOwner.FDragRectDenyColor;
            LMDAlphaFillRect(ACanvas, R1, ACanvas.Brush.color, FHighlightAlphaLevel shr 1);
          end;
        SelColorRect:
          begin
            ACanvas.Brush.Color := clHighlight;
            LMDAlphaFillRect(ACanvas, R1, ACanvas.Brush.Color, FHighlightAlphaLevel shr 1);
          end;
      end; // case
    end;
    if RowSelect and not FullRowSelect and Item.Selected and (FOwner.IsVistaSelNeed) then
    begin
      LDetails.Element := teMenu;
      LDetails.Part := MENU_POPUPITEM;
      LDetails.State := MPI_HOT;
      LMDThemeServices.DrawElement(LUseThemeMode, ACanvas.Handle, LDetails, R1, LMDRectToPtr(R1));
    end;
    if TSI.Focused and dfr and FDrawFocusRect and not FOwner.IsVistaSelNeed then
    begin
      ACanvas.Brush.Color := FBkColor;
      ACanvas.Pen.Color := FTextColor;
      ACanvas.Font.Color := FTextColor;
      // this one is made to fix the colors
      ACanvas.TextOut(R1.Left, R1.Top, '');
      // otherwise FocusRect won't draw right
      ACanvas.DrawFocusRect(R1);
    end;
    if (TSI = FDropTrg) then
    begin
      case FDragTrgDrawMode of
      ColorFrame:
        begin
          if FDropAcc then
            ACanvas.Brush.Color := FDragRectAcceptColor
          else
            ACanvas.Brush.Color := FDragRectDenyColor;
          ACanvas.TextOut(RD.Left, RD.Top, '');
          ACanvas.FrameRect(RD);
          end;
      dtdUpColorLine:
        begin
          if FDropAcc then
            ACanvas.Pen.Color := FDragRectAcceptColor
          else
            ACanvas.Pen.Color := FDragRectDenyColor;
          ACanvas.MoveTo(RD.Left, RD.Top);
          ACanvas.LineTo(RD.Right, RD.Top);

          ACanvas.MoveTo(RD.Left, RD.Top + 3);
          ACanvas.LineTo(RD.Left, RD.Top);
          ACanvas.MoveTo(RD.Left + 1, RD.Top + 1);
          ACanvas.LineTo(RD.Left + 1, RD.Top);

          ACanvas.MoveTo(RD.Right - 1, RD.Top + 3);
          ACanvas.LineTo(RD.Right - 1, RD.Top);
          ACanvas.MoveTo(RD.Right - 2, RD.Top + 1);
          ACanvas.LineTo(RD.Right - 2, RD.Top);
        end;
      dtdDownColorLine:
        begin
          dec(RD.Bottom);
          if FDropAcc then
            ACanvas.Pen.Color := FDragRectAcceptColor
          else
            ACanvas.Pen.Color := FDragRectDenyColor;
          ACanvas.MoveTo(RD.Left, RD.Bottom);
          ACanvas.LineTo(RD.Right, RD.Bottom);

          ACanvas.MoveTo(RD.Left, RD.Bottom - 3);
          ACanvas.LineTo(RD.Left, RD.Bottom);
          ACanvas.MoveTo(RD.Left + 1, RD.Bottom - 1);
          ACanvas.LineTo(RD.Left + 1, RD.Bottom);

          ACanvas.MoveTo(RD.Right - 1, RD.Bottom - 3);
          ACanvas.LineTo(RD.Right - 1, RD.Bottom);
          ACanvas.MoveTo(RD.Right - 2, RD.Bottom - 1);
          ACanvas.LineTo(RD.Right - 2, RD.Bottom);
        end;
      dtdUpSelColorLine:
        begin
          ACanvas.Pen.Color := clHighlight;
          ACanvas.MoveTo(RD.Left, RD.Top);
          ACanvas.LineTo(RD.Right, RD.Top);

          ACanvas.MoveTo(RD.Left, RD.Top + 3);
          ACanvas.LineTo(RD.Left, RD.Top);
          ACanvas.MoveTo(RD.Left + 1, RD.Top + 1);
          ACanvas.LineTo(RD.Left + 1, RD.Top);

          ACanvas.MoveTo(RD.Right - 1, RD.Top + 3);
          ACanvas.LineTo(RD.Right - 1, RD.Top);
          ACanvas.MoveTo(RD.Right - 2, RD.Top + 1);
          ACanvas.LineTo(RD.Right - 2, RD.Top);
        end;
      dtdDownSelColorLine:
        begin
          dec(RD.Bottom, 2);
          ACanvas.Pen.Color := clHighlight;
          ACanvas.MoveTo(RD.Left, RD.Bottom);
          ACanvas.LineTo(RD.Right, RD.Bottom);

          ACanvas.MoveTo(RD.Left, RD.Bottom - 3);
          ACanvas.LineTo(RD.Left, RD.Bottom);
          ACanvas.MoveTo(RD.Left + 1, RD.Bottom - 1);
          ACanvas.LineTo(RD.Left + 1, RD.Bottom);

          ACanvas.MoveTo(RD.Right - 1, RD.Bottom - 3);
          ACanvas.LineTo(RD.Right - 1, RD.Bottom);
          ACanvas.MoveTo(RD.Right - 2, RD.Bottom - 1);
          ACanvas.LineTo(RD.Right - 2, RD.Bottom);
        end;
      end;
    end;
  end;
  HelperBmp.Free;
end;
{$WARNINGS on}
{$hints on}

function TElTreeView.GetVisiblesHeight : integer;
var i : integer;
begin
  result := 0;
  for i := 0 to FVisible.Count - 1 do
      inc(Result, TelTreeItem(FVisible[i]).GetHeight);
end;

procedure TElTreeView.DrawHorzLine(ACanvas : TCanvas; Item : TElTreeItem; var R : TRect);
begin
  ACanvas.MoveTo(R.Left, R.Top);
  ACanvas.LineTo(R.Right, R.Top);
end;

procedure TElTreeView.DrawVertLine(ACanvas : TCanvas; Item : TElTreeItem; var R : TRect);
begin
  ACanvas.MoveTo(R.Left, R.Top);
  ACanvas.LineTo(R.Left, R.Bottom);
end;

procedure TElTreeView.DrawGutter(ACanvas: TCanvas; Item: TElTreeItem; var R: TRect);
begin
  //empty, but not abstract because not needed in all children objects
  ;
end;

procedure TElTreeView.RedrawTree(ACanvas : TCanvas; RealLeftPos : integer; ItemsList : TLMDObjectList);
var
  i, j,
  y, h,
  oy  : integer;
  R, r1, R2, r4: TRect;
  Item: TElTreeItem;
  Sect: TElHeaderSection;
  fSaveStyle : TBrushStyle;
  FSaveLeftPos : integer;
  mb : integer;
  PrevPenColor: TColor;
  CurStyle : TElCellStyle;

begin
  with FOwner do
  begin
    if FShowHeader then
    begin
      with FHeader do
      if (Left <> FHPos) {or (Width <> FHPos + FView.Width) }then
      begin
        LeftPos := FHPos;
        //Width := FHPos + FView.Width;
      end;
    end;
    FSaveLeftPos := FHPos;
    FHPos := RealLeftPos;
    FHeader.LeftPos := FHPos;

    if FHeader.Sections.Count <= MainTreeColumn then
       MainTreeColumn := 0;

    fSaveStyle := ACanvas.Brush.Style;
    // redraw items
//    j := ItemsList.Count - 1;
    i := 0;
    while i < ItemsList.Count do
    begin
      R := Self.GetItemRect(i);
      Item := TElTreeItem(ItemsList[i]);
      if FHorizontalLines and ((not FBarStyle) and (Item.BorderStyle = ibsNone)) then
          dec(R.Bottom, FDivLineWidth);
      if IntersectRect(R4, R, ACanvas.ClipRect) then
      begin
        r1 := r4;
        R1.Bottom := r1.Top + Item.Height;
        if FHorizontalLines and ((not FBarStyle) and (Item.BorderStyle = ibsNone)) then
           dec(R1.Bottom, FDivLineWidth);
        if FShowHeader then
           r1.right := FHeader.SectionsWidth
        else
        begin
          R.Right := Max(FHRange, FHPos + Self.Width);
          r1.right := R.Right;
        end;

        if not ((Item.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
        begin
          ACanvas.Font.Color := FTextColor;
          ACanvas.Pen.Color := FTextColor;
        end;

        // TODO: FCurBkColor := BkColor;
        FCurTextColor := FTextColor;
        if FBarStyle or (Item.BorderStyle <> ibsNone) then
        begin
          InflateRect(R, -1, -1);
          InflateRect(R1, -1, -1);
        end;
        FOwner.TriggerItemPreDrawEvent(Item);
        DoRedrawItem(ACanvas, Item, R, R1);
        if FBarStyle or (Item.BorderStyle <> ibsNone) then
        begin
          InflateRect(R, 1, 1);
          //inc(R.Bottom);
          if FShowHeader then
            R.Right := -FHPos + FHeader.SectionsWidth;
          if Item.BorderStyle <> ibsNone then
          begin
            case Item.BorderStyle of
              ibsRaised: DrawEdge(ACanvas.Handle, R, BDR_RAISEDINNER, BF_RECT);
              ibsFlat: DrawEdge(ACanvas.Handle, R, BDR_SUNKENOUTER, BF_FLAT or BF_RECT);
              ibsSunken: DrawEdge(ACanvas.Handle, R, BDR_SUNKENOUTER, BF_RECT);
              ibsSpace:
                begin
                  Windows.SetBkColor(ACanvas.Handle, ColorToRGB(Item.BorderSpaceColor));
                  FrameRect(ACanvas.Handle, R, ACanvas.Brush.Handle);
                  end;
            end;
          end
          else
          begin
            if FNotRaiseForBarStyle then
            begin
              if Item.Selected then
                DrawEdge(ACanvas.Handle, R, BDR_SUNKENOUTER, BF_RECT);
            end
            else
            begin
              if not Item.Selected then
                DrawEdge(ACanvas.Handle, R, BDR_RAISEDINNER, BF_RECT)
              else
                DrawEdge(ACanvas.Handle, R, BDR_SUNKENOUTER, BF_RECT);
            end;
          end;
        end;
      end;
      i := i + 1;
    end;
    ACanvas.Brush.Style := fSaveStyle;
    // fill the rest of the window
    r2 := Self.ClientRect;
    Inc(R2.Right);
    Inc(R2.Bottom);
    if IntersectRect(R4, R2, ACanvas.ClipRect) and (BackgroundType = bgtColorFill) and ((csDesigning in ComponentState)  or (ImageForm = nil)) then
    begin
      // Draw bottom empty part
      ACanvas.Brush.Color := FBkColor;
      oy := R4.top - 1;
      Y := GetVisiblesHeight;
      //Changed for flexible heights FVisible.Count * FLineHeight;
      if (R4.Top < Y) then
        R4.Top := Y;
      if InSizeMove then
      ACanvas.FillRect(R4);
      // Draw side empty part
      if FShowHeader then
      begin
        if FHeader.Sections.Count > 0 then
          r4.Left := FHeader.SectionsWidth
        else
          r4.left := 0;
        dec(R4.Left, FHPos);
        R4.Top := oy;
        if InSizeMove then
        ACanvas.FillRect(R4);
      end;
    end;

    ACanvas.Pen.Color := FOwner.HorzDivLinesColor;

    // Draw horizontal lines
    if ((not FBarStyle) or FBSVLines) or (FNotRaiseForBarStyle) then
    begin
      if FHorizontalLines and ((not BarStyle) or (FNotRaiseForBarStyle)) then
      begin
        y := 0;
        if FShowHeader then
          h := FHeader.SectionsWidth - FHPos
        else
          h := Self.ClientWidth;

        i := 0;
        if ItemsList.Count > 0 then
        begin
          Inc(Y, TElTreeItem(ItemsList[i]).GetHeight - 1);

          while Y < Self.ClientHeight do
          begin
            if TElTreeItem(ItemsList[i]).DrawHLine then
              if IntersectRect(R, Rect(0, Y, h, Y + FDivLineWidth), ACanvas.ClipRect) then
              begin
                PrevPenColor := ACanvas.Pen.Color;
                if TElTreeItem(ItemsList[i]).UseStyles then
                begin
                  if VirtualityLevel > vlNone then
                  begin
                    Fowner.TriggerVirtualStyleNeeded(TElTreeItem(ItemsList[i]), -1, VirtStyle);
                    CurStyle := VirtStyle;
                  end
                  else
                    CurStyle := TElTreeItem(ItemsList[i]).MainStyle;
                end
                else
                  CurStyle := nil;
                if (not TElTreeItem(ItemsList[i]).UseStyles and
                (TElTreeItem(ItemsList[i]).BkColor = FOwner.HorzDivLinesColor)) or
                (TElTreeItem(ItemsList[i]).UseStyles and (CurStyle.CellBkColor = FOwner.HorzDivLinesColor)) then
                  ACanvas.Pen.Color := InvertColor(FOwner.HorzDivLinesColor);

                DrawHorzLine(ACanvas, TElTreeItem(ItemsList[i]), R);
                ACanvas.Pen.Color := PrevPenColor;
              end;
            inc(i);
            if i >= FVisible.Count then break;
            Inc(Y, TElTreeItem(FVisible[i]).GetHeight);
          end;
        end;
      end;

      ACanvas.Pen.Color := FOwner.VertDivLinesColor;

      // Draw vertical lines
      if FVerticalLines and (FShowHeader) then
      begin
        if (FBottomIndex >= 0) then
          mb := GetItemRect(ItemsList.Count - 1).Bottom - FHeader.Height
        else
          mb := ClientHeight - FHeader.Height;

        for i := 0 to FHeader.Sections.Count - 1 do
        begin
          Sect := FHeader.Sections[i];
          if (not Sect.Visible) or (Sect.Width <= 0) then continue;

          if Sect.Locked then
             j := Sect.Right
          else

          begin
            j := Sect.Right - FHPos;

            if FHeader.LockedSection <> nil then
            begin
              if j < FHeader.LockedSection.Width then Continue;
            end;

          end;

          if FVerticalLinesLong and IntersectRect(R, Rect(j - FDivLineWidth, 0, j, Self.ClientHeight), ACanvas.ClipRect) then
          begin
            R.Top := mb;
            // TODO: draw vert line
            DrawVertLine(ACanvas, nil, R);
          end;
        end;
      end;
    end;
    FHPos := FSaveLeftPos;
    FHeader.LeftPos := FHPos;
  end;
end;

procedure TElTreeView.IntMouseMove(X, Y : integer; Shift : TShiftState);
var
  TSI  : TElTreeItem;
  R    : Trect;
  IP   : TSTItemPart;

  HCol : integer;
  P    : TPoint;
  b    : boolean;

  dataObj: IDataObject;
  dropSource: IDropSource;
  OKEffects: TDragTypes;
  Effect: TDragType;
  dwOKEffects,
    dwEffect: integer;
  HRes: HResult;

  href: TLMDString;
    od, htmldata: TLMDHTMLData;

  vHint:String;
begin

  TSI := GetItemAt(X, Y, IP, HCol);
  if (TSI<>nil) and ((IP=ipColumn) or (IP=ipMainText)) then
  begin
    if HCol=FOwner.FMainTreeCol then
      htmldata := TSI.FHTMLData
    else
    begin
      if HCol > FOwner.FMainTreeCol then
        dec(HCol);
      if TSI.FHTMLDataArray<>nil then
        htmldata := TLMDHTMLData(TSI.FHTMLDataArray[HCol])
      else
        htmldata := nil;
    end;

    if htmldata<>nil then
    begin
      od := FRender.Data;
      FRender.SetData(HTMLData);
      p := point(x-HTMLData.Rect.Left, y-HTMLData.Rect.Top);
      if FRender.IsCursorOverLink(P, Point(0,0), HTMLData.Rect, href) then
      begin
        Cursor := FOwner.FLinkCursor;
        if Assigned(FOwner.FOnLinkOver) then
          FOwner.FOnLinkOver(Self, HRef, X, Y);
      end
      else
        Cursor := FOwner.FCursor;
      FRender.SetData(od);
    end;
  end
  else
    Cursor := FOwner.FCursor;

  if not Dragging then
  begin
    if FPressed then
    begin
      TSI := GetItemAt(X, Y, IP, HCol);
      if FOwner.RowSelect and (TSI <> nil) and (IP = ipOutside) then IP := ipMainText;

      b := True;

      if Assigned(FFocused) then
        DoCanDrag(FFocused, b);

      b := b and (ip <> ipOutside) and (not FMouseSel) and FOwner.DragAllowed and
           ((FOwner.MultiSelect and (FOwner.FSelectedList <> nil) and (FOwner.FSelectedList.Count > 0)) or
           (not FOwner.MultiSelect and (FSelected <> nil))) and
           ((sqr(FPressCoord.X - X) + sqr(FPressCoord.Y - Y)) >= 25);

      if b then
      begin

        if FEditTimer <> nil then
           FEditTimer.Enabled := false;

        FClickPassed := false;
        FPassedItem := nil;
        FIgnoreClick2 := true;

        if FOwner.DragType <> dtOLE then
        begin
          BeginDrag(true);
        end
        else
        begin
          FClickPassed := false;
          FPassedItem := nil;
          dataObj := nil;
          dropSource := nil;
          OKEffects := [];
          FOwner.TriggerOleDragStartEvent(dataObj, dropSource, OKEffects);
          dwOkEffects := 0;
          if dtCopy in OKEffects then dwOkEffects := dwOkEffects or DROPEFFECT_COPY;
          if dtMove in OKEffects then dwOkEffects := dwOkEffects or DROPEFFECT_MOVE;
          if dtLink in OKEffects then dwOkEffects := dwOkEffects or DROPEFFECT_LINK;
          FPressed := false;

          if Assigned(DataObj) and Assigned(dropSource) then
          begin
            dwEffect := DROPEFFECT_NONE;
            Effect := dtNone;
            HRes := DoDragDrop(dataObj, dropSource, dwOKEffects, dwEffect);
            if (dwEffect and DROPEFFECT_COPY) <> 0 then Effect := dtCopy;
            if (dwEffect and DROPEFFECT_LINK) <> 0 then Effect := dtLink;
            if (dwEffect and DROPEFFECT_Move) <> 0 then Effect := dtMove;
            FOwner.TriggerOleDragFinishEvent(Effect, HRes);
          end;

        end;
      end
      else
      if FOwner.FMouseFrameSelect and (FVisible.Count > 0) and (FOwner.MultiSelect) then
      begin
        FClickPassed := false;
        FPassedItem := nil;

        if (not FMouseSel) then
        begin
          if (sqrt(sqr(FPressCoord.X - X) + sqr(FPressCoord.Y - Y)) >= 5) then
          begin
            TSI := GetItemAtY(FPressCoord.Y);
            if TSI = nil then
              TSI := TElTreeItem(FVisible.Last);
            begin
              R := GetItemRect(FVisible.IndexOf(TSI));
              FMFSStartItem := TSI;
              FMFSStartCoord.x := FPressCoord.X + FOwner.FHPos;
              FMFSStartCoord.y := FPressCoord.Y - R.Top;
              FMFSEndItem := TSI;
              FMFSEndCoord := FMFSStartCoord;
              if not (ssCtrl in LMDGetShiftState) then
              begin
                FOwner.DeselectAll;
                FOwner.DoAfterSelectionChange;
              end;
              SetCapture(Handle);
              if FOwner.FMouseFrameVisible then
                AllocateMouseSelectFrame;
              FMouseSel := true;
              FMFSList  := TLMDObjectList.Create;
            end;
          end;
        end
        else
        begin
          if FOwner.MouseFrameVisible then
            DrawMouseSelectFrame;
          if PtInRect(ClientRect, Point(X, Y)) then
          begin
            TSI := GetItemAtY(Y);
            if TSI = nil then
              TSI := TElTreeItem(FVisible.Last);
            begin
              R := GetItemRect(FVisible.IndexOf(TSI));
              FMFSEndItem := TSI;
              FMFSEndCoord.x := X + FOwner.FHPos;
              FMFSEndCoord.y := Y - R.Top;
            end;
            SelectMouseSelectItems;
            FOwner.DoAfterSelectionChange;
          end
          else
          begin
            if Y >= ClientHeight then
            begin
              SetVPosition(FOwner.FTopIndex + 1);
            end
            else
            if Y < 0 then
            begin
              SetVPosition(FOwner.FTopIndex - 1);
            end
            else
            if X >= ClientWidth then
            begin
              SetHPosition(FOwner.FHPos + 4);
            end
            else
            if X < 0 then
            begin
              SetHPosition(FOwner.FHPos - 4);
            end;
            Update;
          end;
          if FOwner.MouseFrameVisible then
            DrawMouseSelectFrame;
        end;
      end;
    end;
    if ((FHintItemEx <> nil) or (not ShowHint)) and (not FMouseSel) then
    begin
      TSI := GetItemAt(X, Y, IP, HCol);
      if (TSI <> nil) then
      begin
        if (FHintItemEx <> TSI) or (HCol <> FHintHCol) then
        begin
          vHint := TSI.Hint;
          if vHint <> '' then
          begin
             Application.Hint := vHint;
             Hint := vHint;
          end;
          if ShowHint and (not FInDragging) then
          begin
            P := ClientToScreen(Point(X, Y));
            Application.ActivateHint(P);
          end;
        end;
      end
      else
      begin
        Application.Hint := FOwner.FRealHint;
        Hint := FOwner.FRealHint;
      end;
    end;

    if (FOwner.FShowHintMode <> shmNone) and (not FMouseSel) then
    begin
      if (FHintCoord.X <> X) or (FHintCoord.Y <> Y) then
      begin
        TSI := GetItemAtY(Y);
        if ((FOwner.FHideHintOnMove) or (TSI <> nil)) and (FHintItem <> TSI) or (HCol <> FHintHCol) then
        begin
          DoHideLineHint;
          FHintItem := nil;
          FHintCoord := Point(X, Y);
          FHintHCol := HCol;
          FHintTimer := TTimer.Create(self);
          FHintTimer.Enabled  := false;
          FHintTimer.OnTimer  := OnHintTimer;
          FHintTimer.Interval := Application.HintPause; // old value HintShortPause was changed to show hint like in explorer.
          if FHintTimer.Interval = 0 then
             FHintTimer.Interval := 50;
          FHintTimer.Enabled := true;
        end;
      end;
    end;
    if FOwner.FTracking {and Focused }and (not FMouseSel) then
    begin
      TSI := FTrackItem;
      if FOwner.IsEditing then
        FTrackItem := nil
      else
      FTrackItem := GetItemAtY(Y);
{$IFDEF HOTTRACK_CURSOR}
      if (FTrackItem = nil) and (Cursor <> crDefault) then
        Cursor := crDefault;
{$ENDIF}
      if TSI = FTrackItem then exit;
      if (not FOwner.IgnoreEnabled) and (FTrackItem <> nil) and (not FTrackItem.Enabled) then
        FTrackItem := nil;

      if TSI <> nil then
      begin
        if (not FOwner.FShowHeader) or FOwner.FRowHotTrack or TSI.WholeLine then
          TSI.RedrawItem(false)
        else
        begin
          R := GetItemRect(FVisible.IndexOf(TSI));
          with FOwner do
          begin
            R.Left := FHeader.Sections[FMainTreeCol].Left - FHPos;
            R.Right := FHeader.Sections[FMainTreeCol].Right - FHPos;
          end;
          InvalidateRect(Handle, @R, true);
          end;
      end;
      if FTrackItem <> nil then
      begin
        if (not FOwner.FShowHeader) or FOwner.FRowHotTrack or FTrackItem.WholeLine then FTrackItem.RedrawItem(false)
        else
        begin
          R := GetItemRect(FVisible.IndexOf(FTrackItem));
          with FOwner do
          begin
            R.Left := FHeader.Sections[FMainTreeCol].Left - FHPos;
            R.Right := FHeader.Sections[FMainTreeCol].Right - FHPos;
          end;
          InvalidateRect(Handle, @R, true);
          end;
      end;
      FOwner.TriggerHotTrackEvent(TSI, FTrackItem);
{$IFDEF HOTTRACK_CURSOR}
      if not (Owner = nil) and (Cursor <> Owner.TrackingCursor) then
        Cursor := Owner.TrackingCursor;
{$ENDIF}
      //Update;
    end; // if (FTracking and Focused)
  end; //if (not Dragging)
end;

function TElTreeView.IntLButtonDown(X, Y : integer; Shift : TShiftState): Boolean;
begin
  if FEditTimer <> nil then
     FEditTimer.Enabled := false;
  DoHideLineHint;
  FIgnoreClick2 := false;
  // this has been moved to MouseDown
  if FOwner.IsEditing and Assigned(FInpEdit) then
  begin
    Result := True;
    FInpEdit.TriggerValidateResult(Result);
    FInpEdit.InputChecked := Result;
  end
  else
    Result := True;
  if Result then
  begin
    if (not (csDesigning in ComponentState)) and (not Focused) and CanFocus then
      SetFocus;
    FPressCoord := Point(X, Y);
    FPressed := true;
  end;
end;

function TElTreeView.IntLButtonUp(X, Y : integer; Shift : TShiftState): Boolean;
var
  Item, Item1: TElTreeItem;
  ItemPart: TSTItemPart;
  HCol    : Integer;
  i, j: integer;
  Ctrl: TElCellControl;
  b: boolean;
  AStyle : TElCEllStyle;
  href: TLMDString;
     p: tpoint;
    od,htmldata: TLMDHTMLData;

begin
  result := false;
  if FOwner.IsEditing then
    exit;
  if FEditTimer <> nil then
     FEditTimer.Enabled := false;
  DoHideLineHint;
  FPressed := false;
  if FMouseSel then
  begin
    CancelMouseSel;
    FIgnoreClick2 := false;
    exit;
  end;

  Item := GetItemAt(X, Y, ItemPart, HCol);

  if (Item = nil) or (Item.Enabled) or (FOwner.IgnoreEnabled) then
  begin
    if (FPressCoord.Y = Y) and (FPressCoord.X = X)
    // if the mouse was moved when the button was pressed, we don't check for editing
    and {(ItemPart <> ipInside) and }(ItemPart <> ipOutside) and (ItemPart <> ipButton) then
    begin
      if not FIgnoreClick2 then
      begin
        if (ItemPart in [ipMainText, ipColumn, ipInside]) and
           (Item <> nil) and ((Item = FClickItem) or FOwner.QuickEditMode) and Item.AllowEdit
            and FOwner.FCanEdit and ((FClicked or FOwner.QuickEditMode) and (FOwner.FDblClickMode <> dcmEdit)) then
          InitiateEditOp(Item, HCol, false);
        FClicked := true;
        FClickCoord := Point(X, Y);
        FClickItem := Item;
        FClickSection := HCol;
      end;
    end;
    if Item = nil then
      FClickItem := nil;
    FIgnoreClick2 := false;

    result := true;

    if (Item<>nil) and ((ItemPart=ipColumn) or (ItemPart=ipMainText)) then
    begin
      if HCol=FOwner.FMainTreeCol then
        htmldata := Item.FHTMLData
      else
      begin
        if Item.FHTMLDataArray <> nil then
          if HCol <= FOwner.FMainTreeCol then
            htmldata := TLMDHTMLData(Item.FHTMLDataArray[HCol])
          else
            htmldata := TLMDHTMLData(Item.FHTMLDataArray[HCol-1])
        else
          htmldata := nil;
      end;
      if htmldata <> nil then
      begin
        od := FRender.Data;
        FRender.SetData(htmldata);

        p := point(x-htmldata.Rect.Left, y-htmldata.Rect.Top);
        if FRender.IsCursorOverLink(P, Point(0,0), htmldata.Rect, href) then
          FOwner.TriggerLinkClickEvent(href, X - Left, Y - Top);
        FRender.SetData(od);
      end;
    end;

    // now check the CellControl

    b := (FClickControl <> nil);
    Item1 := GetItemAt(X, Y, ItemPart, HCol);
    if Item1 <> Item then
      exit;

    if ItemPart = ipColumn then
    begin
      if Item.UseStyles then
      begin
        if FOwner.VirtualityLevel = vlNone then
        begin
          i := HCol;
          j := i;
          if i = FOwner.FMainTreeCol then
            AStyle := Item.MainStyle
          else
          begin
            if i > FOwner.FMainTreeCol then Dec(i);
            if Item.StylesCount > i then
              AStyle := Item.Styles[i]
            else
              AStyle := Item.MainStyle;
          end;
        end
        else
        begin
          j := HCol;
          AStyle := VirtStyle;
          FOwner.TriggerVirtualStyleNeeded(Item, HCol, AStyle);
        end;
        if (AStyle <> nil) and (not AStyle.OwnerProps) and (AStyle.Control <> nil)  and (AStyle.Control.Visible) and (AStyle.Control.Enabled) then
        begin
          with FOwner do
          begin
            Ctrl := AStyle.Control;
            if Ctrl <> nil then
            begin
              Ctrl.TriggerMouseUpEvent(mbLeft, Shift, X - FOwner.FHPos - FHeader.Sections[j].Left, Y);
              if Ctrl = FClickControl then Ctrl.TriggerClickEvent;
              b := false;
            end;
          end;
        end;
      end;
    end;
    if b then
      FClickControl.TriggerMouseUpEvent(mbRight, LMDGetShiftState, -1, -1);
    FClickControl := nil;
  end;
end;

procedure TCustomElTree.TriggerLinkClickEvent(HRef : string; X, Y: integer);
begin
  if Assigned(FOnLinkClick) then FOnLinkClick(Self, HRef);
end;

procedure TElTreeView.IntRButtonDown(X, Y : integer; Shift : TShiftState);
begin
  if not (csDesigning in ComponentState) and
    (CanFocus or (GetParentForm(Self) = nil)) then
  begin
    SetFocus;
  end;
end;

function TElTreeView.IntRButtonUp(X, Y : integer; Shift : TShiftState): Boolean;
var
  ItemPart: TSTItemPart;
  HCol: Integer;
  Item: TElTreeItem;
  Ctrl: TElCellControl;
  AStyle: TElCellStyle;
  b: boolean;
  APopupMenu : TPopupMenu;
  i, j : integer;
begin
  result := false;
  if FEditTimer <> nil then
     FEditTimer.Enabled := false;
  DoHideLineHint;

  b := (FClickControl <> nil);
  Item := GetItemAt(X, Y, ItemPart, HCol);
  if (Item = nil) or (Item.Enabled) or (FOwner.IgnoreEnabled) then
  begin
    if ItemPart = ipColumn then
    begin
      if Item.UseStyles then
      begin
        if FOwner.VirtualityLevel = vlNone then
        begin
          i := HCol;
          j := i;
          if i = FOwner.FMainTreeCol then
            AStyle := Item.MainStyle
          else
          begin
            if i > FOwner.FMainTreeCol then Dec(i);
            if Item.StylesCount > i then
              AStyle := Item.Styles[i]
            else
              AStyle := Item.MainStyle;
          end;
        end
        else
        begin
          j := HCol;
          AStyle := VirtStyle;
          FOwner.TriggerVirtualStyleNeeded(Item, HCol, AStyle);
        end;
        if (AStyle <> nil) and (not AStyle.OwnerProps) and (AStyle.Control <> nil) and (AStyle.Control.Visible) and (AStyle.Control.Enabled) then
        begin
          with FOwner do
          begin
            Ctrl := AStyle.Control;
            // if Ctrl <> nil then
            begin
              Ctrl.TriggerMouseUpEvent(mbRight, Shift, X - FOwner.FHPos - FHeader.Sections[j].Left, Y);
              if Ctrl = FClickControl then Ctrl.TriggerClickEvent;
              APopupMenu := Ctrl.PopupMenu;
              if (APopupMenu <> nil) and APopupMenu.AutoPopup then
              begin
                SendCancelMode(nil);
                APopupMenu.PopupComponent := Ctrl;
                with ClientToScreen(Point(X, Y)) do
                  APopupMenu.Popup(X, Y);
                Exit;
              end
              else
                result := true;
            end;
          end;
        end;
      end;
    end;
    if b and Assigned(FClickControl) then
       FClickControl.TriggerMouseUpEvent(mbRight, LMDGetShiftState, -1, -1);
    FClickControl := nil;
    if (not b) then
       result := true;
  end;
end;

function TElTreeView.IntLButtonDblClick(X, Y : integer; Shift : TShiftState):
    Boolean;
var
  ItemPart: TSTItemPart;
  HCol: Integer;
  Item,
  FOldSelected: TElTreeItem;
  Ctrl: TElCellControl;
  i: integer;
begin
  result := false;
  if FEditTimer <> nil then
     FEditTimer.Enabled := false;
  HCol := 0;
  Item := GetItemAt(X, Y, ItemPart, HCol);
  if (Item = nil) or (Item.Enabled) or (FOwner.IgnoreEnabled) then
  begin
    if (FOwner.FDblClickMode = dcmEdit) and FOwner.FCanEdit and (Item <> nil) and Item.AllowEdit and
       (ItemPart in [ipMainText, ipColumn, ipInside]) and
       ((Item = FClickItem) or FOwner.QuickEditMode) then
      begin
        InitiateEditOp(Item, HCol, true);
      end
    else
    if ((ItemPart = ipMainText) or ((Item <> nil) and (FOwner.FRowSelect) and (ItemPart <> ipCheckBox))) and (FOwner.FDblClickMode = dcmExpand) then
    begin
      if Item.Expanded then
      begin
        FOldSelected := FFocused;
        Item.Expanded := false;
        if FOwner.MoveFocusOnCollapse and (FOldSelected <> FFocused) then
        begin
          FOwner.DoAfterSelectionChange;
          FOwner.DoItemFocused;
        end;
      end
      else
      begin
        Item.Expanded := true;
        FitMostChildren(Item);
      end;
    end;
    if (ItemPart = ipColumn) then
    begin
      i := HCol;
      if i > FOwner.FMainTreeCol then Dec(i);
      if Item.UseStyles and (Item.StylesCount > HCol) then
      begin
        if not Item.Styles[i].OwnerProps then
        begin
          Ctrl := Item.Styles[i].Control;
          if Ctrl <> nil then
          begin
            Ctrl.TriggerDblClickEvent;
            exit;
          end;
        end;
      end;
    end;
    FClicked := false;
    FClickItem := nil;
    FClickSection := -2;
    FIgnoreClick2 := true;
    if (ItemPart <> ipButton) and (ItemPart <> ipCheckBox) then
      result := true;
    FIgnoreClick := false;
  end;
end;

function TElTreeView.IntRButtonDblClick(X, Y : integer; Shift : TShiftState):
    Boolean;
var
  ItemPart: TSTItemPart;
  HCol: Integer;
  Item: TElTreeItem;
  Ctrl: TElCellControl;
  i: integer;
begin
  result := false;
  if FEditTimer <> nil then
     FEditTimer.Enabled := false;
  HCol := 0;
  Item := GetItemAt(X, Y, ItemPart, HCol);
  if (Item = nil) or (Item.Enabled) or (FOwner.IgnoreEnabled) then
  begin
    if (ItemPart = ipColumn) then
    begin
      i := HCol;
      if i > FOwner.FMainTreeCol then Dec(i);
      if Item.UseStyles and (Item.StylesCount > HCol) then
      begin
        if not Item.Styles[i].OwnerProps then
        begin
          Ctrl := Item.Styles[i].Control;
          if Ctrl <> nil then
          begin
            Ctrl.TriggerDblClickEvent;
            exit;
          end;
        end;
      end;
    end;
    result := true;
  end;
end;

procedure TElTreeView.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TElTreeView.OnEditTimer(Sender : TObject);
begin
  FEditTimer.Enabled := false;
  if FMouseSel or (FItemToEdit = nil) then exit;
  DoEditItem(FItemToEdit, FEditSect);
end;

procedure TElTreeView.DoEditItem(Item: TElTreeItem; SectionNum: integer);
var
  Section: TElHeaderSection;
  R: TRect;
  Left, Right : integer;
  TextWidth: integer;
  Style: TElCellStyle;
  i: integer;
  FT: TElFieldType;
  Editor : TElTreeInplaceEditor;
  s : TLMDString;
  sn : integer;
  b  : boolean;
begin
  if Item = nil then
    raise EElTreeError.Create(STexInvItem);
  if FVisible.IndexOf(Item) = -1 then
    FOwner.EnsureVisible(Item);
  if FInpEdit <> nil then
    DoEndEdit(true);

  //obvious
  if not FOwner.FCanEdit or not Item.Enabled or not Item.AllowEdit or
  ((FHeader.Sections.Count > 0) and (SectionNum >= 0) and not FHeader.Sections[SectionNum].Editable) then
            exit;

  if FOwner.ShowColumns and (SectionNum = -1) then
     SectionNum := FOwner.MainTreeColumn;
  FEditingItem := Item;
  if (SectionNum <> -1) then
  begin
    Section := FHeader.Sections[SectionNum];
    if (not Section.Visible) then
    begin
      FEditingItem := nil;
      exit;
    end;
  end
  else
    Section := nil;
  if Item.UseStyles then
  begin
    if FOwner.VirtualityLevel = vlNone then
    begin
      if (SectionNum = FOwner.MainTreeColumn) or (SectionNum = -1) then
         Style := Item.MainStyle
      else
      begin
        i := SectionNum;
        if i > FOwner.MainTreeColumn then dec(i);
        if (Item.FStaticData.FStyles = nil) or (Item.FStaticData.FStyles.Count <= i) then
          Style := Item.MainStyle
        else
          Style := TElCellStyle(Item.FStaticData.FStyles[i]);
      end;
    end
    else
    begin
      FOwner.TriggerVirtualStyleNeeded(Item, SectionNum, VirtStyle);
      Style := VirtStyle;
    end;
    FT := Style.CellType;
  end else
  begin
    if Section <> nil then
      FT := Section.FieldType
    else
      FT := FOwner.MainTextType;
  end;

  b := true;
  FOwner.TriggerTryEditEvent(Item, SectionNum, FT, b);
  if not b then exit;
  FOwner.TriggerInplaceEditorNeeded(Item, SectionNum, FT, Editor);

  if Editor = nil then
    exit
  else
  begin
    if (Section = nil) or (Section.Index = FOwner.FMainTreeCol) then
    begin
      s := Item.Text;
    end
    else
    begin
      if Item.FStaticData <> nil then
      begin
        sn := Section.Index;
        if sn > FOwner.MainTreeColumn then
          dec(sn);
        if Item.ColumnText.Count <= sn then
           s := ''
        else
           s := Item.ColumnText[sn];
      end
      else
        FOwner.TriggerVirtualTextNeeded(Item, Section.Index, s);
    end;
    R := GetItemRect(FVisible.IndexOf(Item));
    if (Section = nil) or (not FOwner.ShowColumns) then
    begin
      if (Item.FTextRect.Left < FOwner.FHPos) or (Item.FTextRect.Left > FOwner.FHPos + Self.Width) then
         SetHPosition(Item.FTextRect.Left);
      if FOwner.RightAlignedView then
      begin
        R.Right := Item.FTextRect.Right - FOwner.FHPos;
        R.Left := 0;
      end
      else
      begin
        R.Left := Item.FTextRect.Left - FOwner.FHPos;
        R.Right := ClientWidth - 1;
      end;
    end
    else
    begin
      if FOwner.RightAlignedView then
      begin
        if SectionNum = FOwner.FMainTreeCol then begin
          Left := Item.FTextRect.Left;
          Right := Item.FTextRect.Right;
          TextWidth := Right - Left;
        end else begin
          Left := Section.Left;
          Right := Section.Right;
          TextWidth := Section.Width;
        end;

        //remark: the following change makes a fine tuning for tree editing behavior
        // in case the right of the section is hidden to the right or the section edit width is bigger than
        // the tree client width the section will be aligned to the right so we can see the maximum of the editing area,
        // otherwise, if the section is fully or partially hidden to the left and the width of the section edit is
        // smaller than the tree client width, the section will be aligned to the left.
        if (Right > FOwner.FHPos + ClientWidth) or (TextWidth >= ClientWidth) then
           FOwner.SetHPosition(Right - ClientWidth)
        else if (Left < FOwner.FHPos) then
           FOwner.SetHPosition(Left);

        R.Right := Right - FOwner.FHPos;
        R.Left := Section.Left - FOwner.FHPos;
        if R.Left < 0 then
          R.Left := 0;
      end
      else
      begin
        if SectionNum = FOwner.FMainTreeCol then begin
          Left := Item.FTextRect.Left;
          Right := Item.FTextRect.Right;
          TextWidth := Right - Left;
        end else begin
          Left := Section.Left;
          Right := Section.Right;
          TextWidth := Section.Width;
        end;
        //remark: the following change makes a fine tuning for tree editing behavior
        // in case the left of the section is hidden to the left or the section edit width is bigger than
        // the tree client width the section will be aligned to the left so we can see the maximum of the editing area,
        // otherwise, if the section is fully or partially hidden to the right and the width of the section edit is
        // smaller than the tree client width, the section will be aligned to the right.
        if (Left < FOwner.FHPos) or (TextWidth >= ClientWidth) then
           FOwner.SetHPosition(Left)
        else if (Right > FOwner.FHPos + ClientWidth) then
           FOwner.SetHPosition(Right - ClientWidth);

        R.Left := Left - FOwner.FHPos;
        R.Right := Section.Right - FOwner.FHPos;
        if R.Right >= ClientWidth then
           R.Right := ClientWidth - 1;
      end;
    end;
//    if FOwner.HorizontalLines then
    begin
      R.Bottom := R.Bottom - 2 * FDivLineWidth;
      R.Top := R.Top + FDivLineWidth;
    end;
    if FOwner.VerticalLines then
    begin
      if SectionNum = FOwner.FMainTreeCol then
        i := 0
      else
        i := 1;
      if FOwner.RightAlignedView then
      begin
        R.Right := R.Right - i * FDivLineWidth;
        R.Left := R.Left + FDivLineWidth;
      end
      else
      begin
        R.Right := R.Right - FDivLineWidth;
        R.Left := R.Left + i * FDivLineWidth;
      end;
    end;
    inc(R.Bottom);
    FInpEdit := Editor;
    Editor.Tree := FOwner;
    Editor.ValueAsText := S;
    Editor.Item := Item;
    Editor.SectionIndex := SectionNum;
    Editor.Datatype := FT;
    Editor.CellRect := R;
    Editor.StartOperation;
  end;
end;

procedure TElTreeView.DoEndEdit;
begin
  if FInpEdit <> nil then
  begin
    FInpEdit.CompleteOperation(not ByCancel);
  end;
end;

procedure TElTreeView.EditOperationCancelled;
var HeaderSection : TElHeaderSection;
begin
  if FInpEdit = nil then
    HeaderSection := nil
  else
    HeaderSection := FOwner.HeaderSections[FInpEdit.SectionIndex];

  FInpEdit := nil;
  FOwner.DoEndEditItem(FEditingItem, HeaderSection, true);
end;

procedure TElTreeView.EditOperationAccepted;
var
  si : integer;
  LInpEdit: TElTreeInplaceEditor;
begin
  if Assigned(FInpEdit) then
  begin
    LInpEdit := FInpEdit;
    FInpEdit := nil;
    if FOwner.VirtualityLevel = vlNone then
    begin
      si := LInpEdit.SectionIndex;
      if (si = FOwner.MainTreeColumn) or (si = -1) then
        FEditingItem.Text := LInpEdit.ValueAsText
      else
      begin
        if si > FOwner.MainTreeColumn then
          dec(si);
        while FEditingItem.FStaticData.FColText.Count <= si do
          FEditingItem.FStaticData.FColText.Add('');
        Refresh;
        FEditingItem.FStaticData.FColText[si] := LInpEdit.ValueAsText;
      end;
    end;
    si := LInpEdit.SectionIndex;
    FInpEdit := nil;
    FOwner.DoEndEditItem(FEditingItem, FOwner.HeaderSections[si], false);
  end;
end;

procedure TCustomElTree.EditItem(Item: TElTreeItem; SectionNum: integer);
begin
  if not FCanEdit then exit;
  try
    with FView do
      if FInpEdit <> nil then
        EndEdit(true);
  except
  end;
  FView.DoEditItem(Item, SectionNum);
end;

procedure TCustomElTree.EndEdit(ByCancel: boolean);
begin
  FView.DoEndEdit(ByCancel);
end;

procedure TElTreeView.DoEndDrag(Target: TObject; X, Y: Integer);
var
  TSI: TElTreeItem;
begin
  inherited DoEndDrag(Target, X, Y);
  FDragImages.Free;
  FDragImages := nil;
  TSI := FDropTrg;
  FDropTrg := nil;
  if TSI <> nil then
    TSI.RedrawItem(true);
end;

procedure TElTreeView.WMRButtonUp(var Msg: TWMRButtonUp);
begin
  if IntRButtonUp(Msg.XPos, Msg.YPos, KeyDataToShiftState(Msg.Keys)) then
    inherited;
end;

procedure TElTreeView.WMLButtonUp(var Message: TWMLButtonUp);
begin
  if IntLButtonUp(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys)) then
    inherited;
end;

procedure TElTreeView.MouseMove(Shift: TShiftState; X, Y: Integer); { protected }
var
  ItemPart: TSTItemPart;
  HCol: Integer;
  Item: TElTreeItem;
  Ctrl: TElCellControl;
  CX, CY: integer;
  i, j: integer;
begin
  HCol := 0;
  Item := GetItemAt(X, Y, ItemPart, HCol);
  if (ItemPart = ipColumn) then
  begin
    i := HCol;
    j := i;
    if i > FOwner.FMainTreeCol then Dec(i);
    if Item.UseStyles and (Item.StylesCount > HCol) then
    begin
      CY := X;
      CX := Y;
      with FOwner do
        cy := (cy div LineHeight) * LineHeight;
      if not Item.Styles[i].OwnerProps then
      begin
        Ctrl := Item.Styles[i].Control;
        if Ctrl <> nil then
        begin
          Ctrl.TriggerMouseMoveEvent(LMDGetShiftState, CX - FOwner.FHPos - FHeader.Sections[j].Left, CY);
          exit;
        end;
      end;
    end;
  end;
  inherited;
end; { MouseMove }

procedure TElTreeView.WMRButtonDblClk(var Msg: TWMRButtonDblClk); { private }
begin
  if IntRButtonDblClick(Msg.XPos, Msg.YPos, KeyDataToShiftState(Msg.Keys)) then
    inherited;
end; { WMRButtonDblClk }

procedure TElTreeView.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  if IntLButtonDblClick(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys)) then
    inherited;
end;

procedure TElTreeView.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if IntLButtonDown(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys)) then
    inherited;
end;

procedure TElTreeView.WMRButtonDown(var Message: TWMRButtonDown);
begin
  // this is also in EventFilter
  if FEditTimer <> nil then
     FEditTimer.Enabled := false;
  DoHideLineHint;
  if FMouseSel then
    CancelMouseSel;

  IntRButtonDown(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys));
  inherited;
end;

procedure TElTreeView.DoCanDrag(Item: TElTreeItem; var CanDrag: Boolean);
begin
  if Assigned(FOnCanDrag) then
    FOnCanDrag(Self, Item, CanDrag);
end;

procedure TElTreeView.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  IntMouseMove(Message.XPos, Message.YPos, KeyDataToShiftState(Message.Keys));
end;

procedure TElTreeView.DoStartDrag(var DragObject: TDragObject);
begin
  DragCursor := FOwner.DragCursor;
  FDropTrg := nil;
  if (FSelected <> nil) or ((FOwner.FSelectedList <> nil) and (FOwner.FSelectedList.Count > 0)) then
     FillDragImage;
  if (FDragImages <> nil) then
  begin
    with FOwner do
    if FShowHeader then
      FDragImages.SetDragImage(0, FPressCoord.X + FHPos - FHeader.Sections[FMainTreeCol].Left, FPressCoord.y - fddy)
    else
      FDragImages.SetDragImage(0, FPressCoord.X + FHPos, FPressCoord.y - fddy);
  end;
  inherited DoStartDrag(DragObject);
end;

procedure TElTreeView.OnScrollTimer(Sender : TObject);
var P : TPoint;
    Y : integer;
begin
  FDragScrollTimer.Enabled := false;
  FDragScrollTimer.Interval := FOwner.DragScrollInterval;
  if FVisible.Count > 0 then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    y := P.Y;
    if ((FOwner.TopIndex > 0) and (Y <= TElTreeItem(FVisible[0]).GetHeight)) then // CNS div by 2 removed
    // if ((FOwner.TopIndex > 0) and (Y <= TElTreeItem(FVisible[0]).GetHeight shr 1)) then
    begin
      if FOwner.FDragObject <> nil then FOwner.FDragObject.HideDragImage;
      SetVPosition(FOwner.TopIndex - 1);
      if FOwner.FDragObject <> nil then FOwner.FDragObject.ShowDragImage;
      FDragScrollTimer.Enabled := true;
    end else
    if ((FOwner.BottomIndex <= FOwner.TotalVisCount) and (Y >= Height - TElTreeItem(FVisible.Last).GetHeight)) then // CNS div by 2 removed
    // if ((FOwner.BottomIndex <= FOwner.TotalVisCount) and (Y >= Height - TElTreeItem(FVisible.Last).GetHeight shr 1)) then
    begin
      if FOwner.FDragObject <> nil then FOwner.FDragObject.HideDragImage;
      SetVPosition(FOwner.TopIndex + 1);
      if FOwner.FDragObject <> nil then FOwner.FDragObject.ShowDragImage;
      FDragScrollTimer.Enabled := true;
    end;
  end;
end;

function TElTreeView.DragScroll; { protected }
var
  NewY: integer;
begin
  result := false;
  NewY := 0;
  if (Y < NewY + (FOwner.FLineHeight shr 1)) and (FOwner.TopIndex > 0) then
  begin
    Source.HideDragImage;
    result := true;
    SetVPosition(FOwner.TopIndex - 1);
  end else
    if (Y > Height - (FOwner.FLineHeight shr 1)) and (FOwner.BottomIndex <= FOwner.TotalVisCount) then
    begin
      Source.HideDragImage;
      result := true;
      SetVPosition(FOwner.TopIndex + 1);
    end;
end; { DragScroll }

procedure TElTreeView.DoDragOver(Source: TDragObject; X, Y: Integer; CanDrop: Boolean);
var
  TSI: TElTreeItem;
  R  : TRect;
begin
  //TDragObject(Source).HideDragImage;
  if (FHintTimer <> nil) or (FHintItem <> nil) then
    DoHideLineHint;

  if FVisible.Count > 0 then
    if ((FOwner.TopIndex > 0) and
        (Y <= TElTreeItem(FVisible[0]).GetHeight)) or
        // (Y <= TElTreeItem(FVisible[0]).GetHeight shr 1)) or
       ((FOwner.BottomIndex <= FOwner.TotalVisCount) and
        (Y >= Height - TElTreeItem(FVisible.Last).GetHeight)) then
        // (Y >= Height - TElTreeItem(FVisible.Last).GetHeight shr 1)) then
    begin
      if FDragScrollTimer = nil then
      begin
        FDragScrollTimer := TTimer.Create(self);
        FDragScrollTimer.Enabled := false;
      end;
      if not FDragScrollTimer.Enabled then
      begin
        FDragScrollTimer.OnTimer := OnScrollTimer;
        FDragScrollTimer.Interval := 1000;//FOwner.DragScrollInterval * 2;
        FDragScrollTimer.Enabled := true;
      end;
    end;
  //fh := DragScroll(Source, X, Y);

  FDropAcc := CanDrop;
  TSI := FDropTrg;

  FDropTrg := GetItemAtY(Y);
  if Assigned(FDropTrg) and not (FOwner.IgnoreEnabled or FDropTrg.Enabled) then
    FDropTrg := nil;
  if TSI = FDropTrg then
  begin
    // if there is no code that might change DragImgDrawMode,
    // we have nothing more to do so we can leave the method
    if not Assigned(FOwner.OnDragTargetChange) then
      exit;
  end;
  Source.HideDragImage;
  try
  if TSI <> nil then
      TSI.RedrawItem(false);

    if Assigned(FOwner.OnDragTargetChange) and (TSI <> FDropTrg) then
    begin
      R := FOwner.GetItemRect(FVisible.IndexOf(FDropTrg));
      FOwner.OnDragTargetChange(FOwner, FDropTrg, R, X, Y + Top);
    end;

    if FDropTrg <> nil then
    begin
      if FOwner.FExpandOnDragOver then
      begin
        if FOwner.FDragExpandDelay = 0 then
        begin
          if FOwner.FDragObject <> nil then
            FOwner.FDragObject.HideDragImage;
          FDropTrg.Expand(false);
          Update;
          if FOwner.FDragObject <> nil then
            FOwner.FDragObject.ShowDragImage;
        end
        else
        begin
          if FDragExpandTimer = nil then
            FDragExpandTimer := TTimer.Create(self);
          with FDragExpandTimer do
          begin
            Enabled := false;
            OnTimer := OnDragExpandTimer;
            Interval:= FOwner.FDragExpandDelay;
            Enabled := true;
          end;
        end;
      end;
      FDropTrg.RedrawItem(false);
    end;
    Update;
    finally
    Source.ShowDragImage;
  end;
    end;

function TElTreeView.GetItemAt;
var
  dX, i: integer;
  odx  : integer;
  io   : integer;
begin
  result := GetItemAtY(Y);
  ItemPart := ipOutside;
  if Result = nil then exit;
  with FOwner do
  begin
    if RightAlignedView then
    begin
      dX := X + FHPos;
      odx := dX;
      if FShowHeader then
        for i := 0 to FHeader.Sections.Count - 1 do
        begin

          if FHeader.Sections[i] = FHeader.LockedSection then
          begin
            odx := dx;
            dx := dx - FHeader.LeftPos;
          end else

          begin
            dx := odx;
          end;
          if (dX >= FHeader.Sections[i].Left) and (dX < FHeader.Sections[i].Right) then
          begin
            HitColumn := i;
            if (HitColumn <> FMainTreeCol) and not (Result.WholeLine) then
            begin
              ItemPart := ipColumn;
              exit;
            end
            else
            begin
              ItemPart := ipInside;
              if Result.WholeLine then
                HitColumn := FOwner.MainTreeColumn;
              break;
            end;
          end; // if
        end; // for
      if (dX >= Result.FTextRect.Left) and (dX <= Result.FTextRect.Right + ItemExt div 3 - 1) then
      begin
        ItemPart := ipMainText;
        HitColumn := MainTreeColumn;
        exit;
      end; // else ItemPart := ipInside;
      if ((Result.FBoolData and ibfImageDrawn) = ibfImageDrawn) then
      begin
        i := Result.FTextRect.Right + FImages.Width + ItemExt div 3 - 1;
        if (dX >= i - FImages.Width) and (dX < i) then
        begin
          ItemPart := ipPicture;
          HitColumn := MainTreeColumn;
          exit;
        end;
        if ((Result.FBoolData and ibfImageDrawn2) = ibfImageDrawn2) or
           (Result.ShowCheckBox and FOwner.ShowCheckboxes) then
          inc(i, ItemExt div 3);
      end
      else
        i := Result.FTextRect.Right + ItemExt div 3 - 1;
      if ((Result.FBoolData and ibfImageDrawn2) = ibfImageDrawn2) then
      begin
        io := 0;
        if FImages2 <> nil then
        begin
          inc(i, FImages2.Width);
          if (dX >= i - FImages2.Width) and (dX < i + io) then
          begin
            ItemPart := ipPicture2;
            HitColumn := MainTreeColumn;
            exit;
          end;
        end else
        begin
          inc(i, FImages.Width);
          if (dX >= i - FImages.Width) and (dX < i) then
          begin
            ItemPart := ipPicture2;
            HitColumn := MainTreeColumn;
            exit;
          end;
        end;
      end;
      if FShowCheckBoxes and ((Result.FStaticDataEx.FBoolData1 and ibfShowCheckBox) = ibfShowCheckBox) then
      begin
        inc(i, {ItemExt div 3} - 1);
        if FCustomCheckboxes then
        begin
          if Result.FStaticDataEx.CheckBoxType = ectRadioButton then
          begin
            if (dX >= i) and (dX < i + FRadioButtonGlyph.Width div 6) then
            begin
              ItemPart := ipCheckBox;
              HitColumn := MainTreeColumn;
              exit;
            end;
            inc(i, FRadioButtonGlyph.Width div 6);
          end
          else
          begin
            if (dX >= i) and (dX < i + FCheckBoxGlyph.Width div 6) then
            begin
              ItemPart := ipCheckBox;
              HitColumn := MainTreeColumn;
              exit;
            end;
            inc(i, FCheckBoxGlyph.Width div 6);
          end;
        end
        else
        begin
          if (dX >= i) and (dX < i + CheckBoxSize) then
          begin
            ItemPart := ipCheckBox;
            HitColumn := MainTreeColumn;
            exit;
          end;
          inc(i, CheckBoxSize);
        end;
      end;
      if not (ShowButtons) or (not (Result.HasVisibleChildren or Result.ForceButtons or ShowLeafButton)) then exit;
      if (dX >= i) and (dX < i + ItemExt) then
      begin
        if Result.SuppressButtons then
          ItemPart := ipInside
        else
          ItemPart := ipButton;
        HitColumn := MainTreeColumn;
        exit;
      end;
    end
    else
    begin
      dX := X + FHPos;
      odx := dx;

      if FShowHeader then
        for i := 0 to FHeader.Sections.Count - 1 do
        begin

          if FHeader.Sections[i] = FHeader.LockedSection then
          begin
            odx := dx;
            dx := dx - FHeader.LeftPos;
          end else

          begin
            dx := odx;
          end;
          if (dX >= FHeader.Sections[i].Left) and (dX < FHeader.Sections[i].Right) then
          begin
            HitColumn := i;

            if (HitColumn <> FMainTreeCol) and not (Result.WholeLine) then
            begin
              ItemPart := ipColumn;
              exit;
            end
            else
            begin
              ItemPart := ipInside;
              if Result.WholeLine then
                HitColumn := FOwner.MainTreeColumn;
              break;
            end;
          end; // if
        end; // for
      if (dX >= Result.FTextRect.Left - (ItemExt div 3) + 1) and (dX <= Result.FTextRect.Right) then
      begin
        ItemPart := ipMainText;
        HitColumn := MainTreeColumn;
        exit;
      end; // else ItemPart := ipInside;
      if ((Result.FBoolData and ibfImageDrawn) = ibfImageDrawn) then
      begin
        i := Result.FTextRect.Left - FImages.Width - (ItemExt div 3) + 1;
        if (dX < i + FImages.Width) and (dX >= i) then
        begin
          ItemPart := ipPicture;
          HitColumn := MainTreeColumn;
          exit;
        end;
        if ((Result.FBoolData and ibfImageDrawn2) = ibfImageDrawn2) or
           (Result.ShowCheckBox and FOwner.ShowCheckboxes) then
          dec(i, ItemExt div 3);
      end
      else
        i := Result.FTextRect.Left - (ItemExt div 3) + 1;
      if ((Result.FBoolData and ibfImageDrawn2) = ibfImageDrawn2) then
      begin
        io := 0;
        if FImages2 <> nil then
        begin
          dec(i, FImages2.Width);
          if (dX < i + FImages2.Width + io) and (dX >= i) then
          begin
            ItemPart := ipPicture2;
            HitColumn := MainTreeColumn;
            exit;
          end;
        end
        else
        begin
          dec(i, FImages.Width);
          if (dX < i + FImages.Width) and (dX >= i) then
          begin
            ItemPart := ipPicture2;
            HitColumn := MainTreeColumn;
            exit;
          end;
        end;
      end;
      if FShowCheckBoxes and ((Result.FStaticDataEx.FBoolData1 and ibfShowCheckBox) = ibfShowCheckBox) then
      begin
        dec(i, {ItemExt div 3} - 1);
        if FCustomCheckboxes then
        begin
          if Result.FStaticDataEx.CheckBoxType = ectRadioButton then
          begin
            if (dX < i) and (dX >= i - FRadioButtonGlyph.Width div 6) then
            begin
              ItemPart := ipCheckBox;
              HitColumn := MainTreeColumn;
              exit;
            end;
            dec(i, FRadioButtonGlyph.Width div 6);
          end else
          begin
            if (dX < i) and (dX >= i - FCheckBoxGlyph.Width div 6) then
            begin
              ItemPart := ipCheckBox;
              HitColumn := MainTreeColumn;
              exit;
            end;
            dec(i, FCheckBoxGlyph.Width div 6);
          end;
        end
        else
        begin
          if (dX < i) and (dX >= i - CheckBoxSize) then
          begin
            ItemPart := ipCheckBox;
            HitColumn := MainTreeColumn;
            exit;
          end;
          dec(i, CheckBoxSize);
        end;
      end;
      if not (ShowButtons) or (not (Result.HasVisibleChildren or Result.ForceButtons or ShowLeafButton)) then exit;
      if (dX < i) and (dX >= i - ItemExt) then
      begin
        if Result.SuppressButtons then
          ItemPart := ipInside
        else
          ItemPart := ipButton;
        HitColumn := MainTreeColumn;
        exit;
      end;
    end;
  end;
end;

function TElTreeView.GetItemAtY(y: integer): TElTreeItem;
var
  i : integer;
  j : integer;
begin
  result := nil;
  if Y < 0 then exit;
  j := 0;
  for i := 0 to FVisible.Count - 1 do
  begin
    Inc(J, TElTreeItem(FVisible[i]).GetHeight);
    if Y < J then
    begin
      result := TElTreeItem(FVisible[i]);
      exit;
    end;
  end;
end;

function TElTreeView.GetItemRect;
var i, j : integer;
begin
  if (not LMDInRange(ItemIndex, 0, FVisible.Count - 1)) or (csDestroying in ComponentState) then
  begin
    SetRectEmpty(result);
    exit;
  end;
  j := 0;
  for i := 0 to ItemIndex - 1 do
    Inc(J, TElTreeItem(FVisible[i]).GetHeight);
  Result := Rect(0, j, Self.Width, j + TElTreeItem(FVisible[ItemIndex]).GetHeight);
end;

procedure TElTreeView.ProcessPassedClick;
var Item,
    FS : TElTreeItem;
    FFS  : boolean;
begin
  Item := FPassedItem;
  FClickPassed := false;

  if FOwner.IsEditing then exit;

  with FOwner do
    if FMultiSelect then IsUpdating := true;
  FFS := false;
  if (FOwner.FSelMode = smUsual) and (FOwner.FMultiSelect) then
  begin
    if (not (ssCtrl in FPassedShift)) and (not (ssShift in FPassedShift)) then
    begin
      with FOwner do
      begin
        if ItemFocused <> nil then FFS := ItemFocused.Selected;
        DeselectAll;
      end;
    end;
    if ssShift in FPassedShift then
    begin
      with FOwner do
      begin
        FS := FSelected;
        DeselectAll;
        if FS <> nil then
        begin
          FSelected := FS;
          FSelected.Selected := true;
        end;
        SelectRangeEx2(Item, FSelected, false, false, true);
      end;
    end;
  end;
  with FOwner do
  begin
    if ItemFocused = Item then
    begin
      if (((not FFS) or (FOwner.FAlwaysKeepSelection)) and
         (FOwner.FSelMode = smUsual)) and (not Item.Selected) then
         DoSetSelected(Item)
    end
    else
      ItemFocused := Item;
    if ((FMultiSelect) and (not (ssCtrl in FPassedShift)) and (not (ssShift in FPassedShift))) or
       (not FMultiSelect) {and Item.AllowSelection} then
        FSelected := Item;
  end;
  with FOwner do
    if FMultiSelect then
       IsUpdating := false;
  FOwner.DoAfterSelectionChange;
end;

procedure TElTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  ItemPart: TSTItemPart;
  HCol: Integer;
  FOldSelected,
  Item: TElTreeItem;
  SelList: TLMDObjectList;
  FFS: boolean;
  //Form : TCustomForm;
  AStyle : TElCellStyle;
  Ctrl: TElCellControl;
  CX, CY: integer;
  i, j: integer;
  b : boolean;
  FOldSelcount : integer;
begin
  //Form := GetParentForm(Self);
  if FIgnoreClick or (ssDouble in Shift) then
  begin
    inherited;
    exit;
  end;
  FOwner.FSelChange := false;

  HCol := 0;
  Item := GetItemAt(X, Y, ItemPart, HCol);

  if (ItemPart = ipOutside) and ((FOwner.ShowColumns) or (not FOwner.RowSelect)) then
    Item := nil;
  if (Item = nil) or ((Item.Enabled) or (FOwner.IgnoreEnabled)) {and
     ((not FOwner.ShowColumns) or FOwner.RowSelect))} then
  begin
    //b := true;
    if (ItemPart = ipButton) and ((ssRight in Shift) or (button = mbRight)) then
       ItemPart := ipMainText;
    if (ItemPart = ipButton) then
    begin
      if Item.Expanded then
      begin
        FOldSelected := FFocused;
        Item.Expanded := false;
        if FOwner.MoveFocusOnCollapse and (FOldSelected <> FFocused) then
        begin
          FOwner.DoAfterSelectionChange;
          FOwner.DoItemFocused;
        end;
      end
      else
      begin
        Item.Expanded := true;
        FitMostChildren(Item);
      end;
      //b := false;
    end
    else
    if (ItemPart = ipCheckBox) and ((ssLeft in Shift) or (button = mbLeft)) then
    begin
      FClickedItem := nil;
      if not (Item.Enabled or (FOwner.IgnoreEnabled)) then
        exit;
      if Item.CheckBoxEnabled then
        FClickedItem := Item;
    end
    else
    begin
      if (ItemPart = ipColumn) then
      begin
        // b := true;
        if Item.UseStyles then
        begin
          if FOwner.VirtualityLevel = vlNone then
          begin
            i := HCol;
            j := i;
            if i = FOwner.FMainTreeCol then
              AStyle := Item.MainStyle
            else
            begin
              if i > FOwner.FMainTreeCol then Dec(i);
              if Item.StylesCount > i then
                AStyle := Item.Styles[i]
              else
                AStyle := Item.MainStyle;
            end;
          end
          else
          begin
            i := HCol;
            j := i;
            AStyle := VirtStyle;
            FOwner.TriggerVirtualStyleNeeded(Item, HCol, AStyle);
          end;
          if (AStyle <> nil) and (not AStyle.OwnerProps) and (AStyle.Control <> nil) and (AStyle.Control.Visible) and (AStyle.Control.Enabled) then
          begin
            CY := y;
            CX := x;
            with FOwner do
            begin
              cy := (cy div LineHeight) * LineHeight;
              Ctrl := AStyle.Control;
              if Ctrl <> nil then
              begin
                begin
                  Ctrl.TriggerMouseDownEvent(Button, Shift, CX - FOwner.FHPos - FHeader.Sections[j].Left, CY);
                  FClickControl := Ctrl;
                  b := Ctrl.PassClicks;
                end;
                if not b then
                begin
                  inherited;
                  exit;
                end;
              end;
            end;
          end;
        end;
        if not FHeader.Sections[HCol].ClickSelect then exit;
      end;
    end;
    if ((ssLeft in Shift) or (button = mbLeft)) and (ItemPart <> ipButton) and (ItemPart <> ipCheckbox) then
    begin
      with FOwner do
        if FMultiSelect then IsUpdating := true;
      if (Item <> nil) and (not (ItemPart in [ipInside, ipOutside, ipColumn]) or (Item <> FOwner.ItemFocused)) then
      begin
        with FOwner do
        begin
          if FMultiSelect then
             FOldSelcount := FSelectedList.Count
          else
          if FSelected <> nil then
             FOldSelCount := 1
          else {Eyal}
          if not FOwner.AlwaysKeepSelection then {Eyal}
             FOldSelCount := 0;
        end;    { with }
         // when uncommented, a weird side-effect happens when selection jumps after
          // a message box is shown in responce to double-click
        if FOwner.MultiSelect and Item.Selected and (not (ssCtrl in Shift)) then
        begin
          FClickPassed := true;
          FPassedItem := Item;
          FPassedShift := Shift;
          FFS := Item.Selected;
          FOwner.ItemFocused := Item;
          if (FFS or (FOwner.AlwaysKeepSelection)) then
          begin
            Item.Selected := (FOwner.FSelMode = smUsual);
          end;
        end
        else
        begin
          //FFS := false;
          if (FOwner.FSelMode = smUsual) and (FOwner.FMultiSelect) then
          begin
            if (not (ssCtrl in shift)) and (not (ssShift in shift)) then
            begin
              with FOwner do
                DeselectAll;
            end;
            if ssShift in shift then
            begin
              with FOwner do
              begin
                FOldSelected := FSelected;
                DeselectAll;
                //FOwner.FSelChange := true;
                FSelected := FOldSelected;
                if FSelected <> nil then
                   FSelected.Selected := true;
                SelectRangeEx2(Item, FSelected, false, false, true);
                if ItemFocused <> Item then
                  Item.Selected := false;
              end;
            end;
          end;
          with FOwner do
          begin
            if ItemFocused = Item then
            begin
              if (not Item.Selected) or ((not FOwner.FAlwaysKeepSelection) or (FOldSelcount > 1)) then
                   DoSetSelected(Item);
            end
            else
//               if Item.AllowSelection then
            if NeedToFoxusItemInMouseDown then
              ItemFocused := Item;
            if (((FMultiSelect) and (not (ssCtrl in shift)) and (not (ssShift in shift)))
              or (not FMultiSelect)) and Item.Focused then
              FSelected := Item;
            if ((ssCtrl in shift) and (FOldSelCount <= 1))
               and (FMultiSelect) and (FOwner.FSelectedList.Count = 0)
               {and FOwner.FAlwaysKeepSelection} and Item.Focused then
               DoSetSelected(Item);
            //FOwner.FSelChange := true;
          end;
        end;
      end
      else // Eyal: (?) if FOwner.FMultiSelect or not FOwner.FAlwaysKeepSelection then {Eyal}
      begin
        if Item = nil then
        with FOwner do
        begin
          if (not FAlwaysKeepFocus) then
            ItemFocused := nil;
          if MultiSelect and (not AlwaysKeepSelection) then
          begin
            DeselectAll;
            //FOwner.FSelChange := true;
          end;
        end;
      end;
      with FOwner do
        if FMultiSelect then IsUpdating := false;
      if FOwner.FSelChange then
      begin
        FOwner.DoAfterSelectionChange;
        FOwner.FSelChange := false;
      end;
    end
    else
    if ((ssRight in Shift) or (button = mbRight)) and FOwner.RightClickSelect then
    begin
      with FOwner do
      if FMultiSelect then
      begin
        IsUpdating := true;
        SelList := TLMDObjectList.Create;
        AllSelected(SelList);
      end;

      if FOwner.MultiSelect and Assigned(Item) and Item.Selected then
      begin
        FFS := Item.Selected;
        FOwner.ItemFocused := Item;
        if FFS or (FOwner.AlwaysKeepSelection) then Item.Selected := true;
      end else
  {$WARNINGS off}
      with FOwner do
      if (not FMultiSelect) or (FMultiSelect and ((SelList.Count < 2) and (FSelMode = smUsual)) or (FSelMode = smSimple)) then
      begin
        if (Item <> nil) and (({(ItemPart <> ipInside) and }(ItemPart <> ipOutside)) or FRowSelect) then
        begin
          begin
            if (FSelMode = smUsual) and (FMultiSelect) then
            begin
              if (not (ssCtrl in shift)) and (not (ssShift in shift)) then
              begin
            //if ItemFocused <> nil then FFS := ItemFocused.Selected;
                DeselectAll;
              end;
              if ssShift in shift then
              begin
                DeselectAll;
                if FSelected <> nil then FSelected.Selected := true;
                SelectRangeEx2(Item, FSelected, false, false, true);
              end;
            end;
            if (ItemFocused = Item) and (not Item.Selected) then
               DoSetSelected(Item)
            else
            if {Item.AllowSelection and }(ItemFocused <> Item) then
              ItemFocused := Item;
            if ((FMultiSelect) and (not (ssCtrl in shift)) and (not (ssShift in shift)))
              or (not FMultiSelect) then
             FSelected := Item;
          end;
        end
        else // Eyal: (?) if FOwner.FMultiSelect or not FOwner.FAlwaysKeepSelection then {Eyal}
          if (Item = nil) and (not FAlwaysKeepFocus) then ItemFocused := nil;
      end;
      with FOwner do
      if FMultiSelect then
      begin
        SelList.Free;
        IsUpdating := false;
      end;
      if FOwner.FSelChange then
      begin
        FOwner.DoAfterSelectionChange;
        FOwner.FSelChange := false;
      end;
    end;
  end;
  inherited;
end;
{$WARNINGS on}

procedure TElTreeView.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ItemPart: TSTItemPart;
  HCol: Integer;
  Item: TElTreeItem;
begin
  inherited;
  HCol := 0;
  Item := GetItemAt(X, Y, ItemPart, HCol);
  if (Item = nil) or (Item.Enabled) or (FOwner.IgnoreEnabled) then
  begin
    if (ItemPart = ipCheckBox) then
    begin
      if not (Item.Enabled or (FOwner.IgnoreEnabled)) then exit;
      if Item.CheckBoxEnabled and (FClickedItem = Item) then
      begin
        FClickedItem := nil;
        if Item.CheckBoxType = ect3SCheckBox then
        begin
          if Item.CheckBoxState = cbChecked then
            Item.CheckBoxState := cbUnchecked
          else
          if Item.CheckBoxState = cbUnchecked then
            Item.CheckBoxState := cbGrayed
          else
            Item.CheckBoxState := cbChecked;
        end
        else
        if Item.CheckBoxType = ectCheckBox then
          Item.Checked := not Item.Checked
        else
          Item.Checked := true;
        FOwner.DoItemChecked(Item);
        FOwner.DoItemChange(Item, icmCheckState);
      end;
    end;
    if FClickPassed then
      ProcessPassedClick;
  end;
end;

function TElTreeView.NeedToFoxusItemInMouseDown: Boolean;
begin
  Result := True;
end;

{$WARNINGS OFF}
procedure TElTreeView.KeyDown(var Key: Word; Shift: TShiftState);
var
  PrevSel,
  TSI, TSI1: TElTreeItem;
  OldSel,
    OldSel1: boolean;
  gr : integer;
  sel: boolean;
  NewFocused: TElTreeItem;

begin
  inherited;
  if not (csNoStdEvents in ControlStyle) then
  begin
    (*
    if FOwner.FIncrementalSearch and (Shift = []) then
    begin
      if ProcessSearch(Char(Key)) then exit;
    end;
    *)

    if FMouseSel then
      exit;

    FOwner.FSelChange := false;

    with FOwner do
      if FMultiSelect then
        IsUpdating := true;

    try
      TSI := nil;
      TSI1 := nil;
      NewFocused := nil;
      OldSel := false;
      OldSel1 := false;

      if (ssCtrl in shift) and (ssShift in shift) then Shift := Shift - [ssCtrl];
      if (ssShift in shift) and (Key = Ord('8')) then
      begin
        if (FFocused <> nil) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) and (FFocused.HasVisibleChildren or FFocused.ForceButtons) then FFocused.Expand(true);
      end
      else
      case Key of //
        VK_BACK:
          if (FFocused <> nil) and (FFocused.Parent <> nil) and ((FFocused.Parent.Enabled) or (FOwner.IgnoreEnabled)) then
          begin
            FOwner.DoSetFocusedEx(FFocused.Parent, false, true);
            FOwner.EnsureVisible(FOwner.ItemFocused);
          end;
        VK_ADD:
          if ssCtrl in Shift then
            FOwner.AutoSizeAllColumns
          else
          if (FFocused <> nil) and (FFocused.HasVisibleChildren or FFocused.ForceButtons) and
             (not (FFocused.Expanded)) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) then
          begin
            FFocused.Expanded := true;
            FitMostChildren(FFocused);
          end;
        VK_SUBTRACT:
          if (FFocused <> nil) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) and (FFocused.Expanded) then
             FFocused.Expanded := false;
        VK_MULTIPLY:
          if (FFocused <> nil) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) and
             (FFocused.HasVisibleChildren or FFocused.ForceButtons) then
             begin
               FFocused.Expand(true);
               FitMostChildren(FFocused);
             end;
        VK_DIVIDE:
          if (FFocused <> nil) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) then
             FFocused.Collapse(true);
        VK_SPACE:
          if (FFocused <> nil) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) and (FOwner.FMultiSelect) then
          begin
            if (not (ssCtrl in shift)) and (not (ssShift in shift)) and (FOwner.FSelMode = smUsual) then
            begin
              FOwner.DeselectAll;
              FSelected := FFocused;
            end;
            if FOwner.FSelMode = smSimple then
              FSelected := FFocused;
            FFocused.Selected := not (FFocused.Selected);
            FOwner.DoAfterSelectionChange;
          end;
        VK_HOME,
          VK_END,
          VK_PRIOR,
          VK_NEXT,
          VK_LEFT,
          VK_RIGHT,
          VK_UP,
          VK_DOWN:
          begin
            if FOwner.RightAlignedView then
            begin
              if Key = VK_LEFT then
                Key := VK_RIGHT
              else
                if Key = VK_RIGHT then
                  Key := VK_LEFT;
            end;
            if FOwner.HorzArrowsScroll and ((Key = VK_LEFT) or (Key = VK_RIGHT)) then
            begin
              if Key = VK_LEFT then
                PostMessage(FOwner.Handle, WM_HSCROLL, SB_LINELEFT, 0)
              else
                PostMessage(FOwner.Handle, WM_HSCROLL, SB_LINERIGHT, 0);
              exit;
            end;
            if Key = VK_LEFT then
              if (FFocused <> nil) and FFocused.Expanded and ((FFocused.Enabled) or (FOwner.IgnoreEnabled))  then
              begin
                FFocused.Expanded := false;
//                with FOwner do
//                  if FMultiSelect then
//                    IsUpdating := false;
                exit;
              end;
            if Key = VK_RIGHT then
              if (FFocused <> nil) and (not (FFocused.Expanded)) and ((FFocused.Enabled) or (FOwner.IgnoreEnabled)) and (FFocused.HasVisibleChildren or FFocused.ForceButtons) then
              begin
                FFocused.Expanded := true;
                FitMostChildren(FFocused);
//                with FOwner do
//                  if FMultiSelect then
//                    IsUpdating := false;
                exit;
              end;
            (*
            GIRec.OTSI := nil;
            GIRec.TSI := nil;
            GIRec.i := 0;
            GIRec.NewFocused := nil;
            *)
            with FOwner do
            if FMultiSelect then
            begin
              if ((ssCtrl in Shift) and (FSelMode = smUsual)) or (FSelMode = smSimple) then
              begin
                TSI := FFocused;
                if TSI <> nil then
                   OldSel := TSI.Selected
                else
                   OldSel := false;
              end;
              if (ssShift in Shift) then
              begin
                TSI1 := FSelected;
                if TSI1 <> nil then
                   OldSel1 := TSI1.Selected
                else
                   OldSel1 := false;
              end;
              PrevSel := FSelected;
              if (FSelMode = smUsual) and (not (ssCtrl in shift)) then
                 DeselectAll;
            end;
            if Key = VK_UP then
            begin
              NewFocused := FindNewFocused(VK_UP, @gr, sel);
              if (FFocused = nil) and (NewFocused = nil) then
                exit;
            end
            else
            if Key = VK_DOWN then
            begin
              NewFocused := FindNewFocused(VK_DOWN, @gr, sel);
              if (FFocused = nil) and (NewFocused = nil) then
                exit;
            end
            else
            if Key = VK_Left then
            begin
              if (FFocused <> nil) and (FFocused.Parent <> nil) then
                if FFocused.Parent <> nil then
                  NewFocused := FFocused.Parent
                else
                  NewFocused := FFocused;

                if NewFocused <> nil then
                  gr := NewFocused.AbsoluteIndex
                else
                  gr := -1;
            end
            else
            if Key = VK_Right then
            begin
              if (FFocused <> nil) and (FFocused.GetFirstVisibleChild <> nil) then
              begin
                FOwner.IsUpdating := true;
                NewFocused := FFocused.GetFirstVisibleChild;
                if NewFocused = nil then
                  NewFocused := FFocused;

                if NewFocused <> nil then
                  gr := NewFocused.AbsoluteIndex
                else
                  gr := -1;

                FOwner.FUpdated := true;
                FRangeUpdate := true;
                FOwner.IsUpdating := false;
              end
              else
              if FOwner.ItemFocused <> nil then
                gr := FOwner.ItemFocused.AbsoluteIndex
              else
                gr := -1;
            end
            else
            if Key = VK_NEXT then
            begin
              NewFocused := FindNewFocused(VK_NEXT, sel);
            end else
            if Key = VK_PRIOR then
            begin
              NewFocused := FindNewFocused(VK_PRIOR, sel);
            end
            else
            if Key = VK_HOME then
            begin
              NewFocused := FindNewFocused(VK_HOME, sel);
            end
            else
            if Key = VK_END then
            begin
              NewFocused := FindNewFocused(VK_END, sel);
            end;
            if FOwner.FMultiSelect then
            begin
              if ((ssCtrl in Shift) and (FOwner.FSelMode = smUsual)) or (FOwner.FSelMode = smSimple) then
              begin
                if TSI <> nil then TSI.Selected := OldSel;
                 //if FFocused<>TSI then FFocused.Selected:=GIRec.Sel;
              end;
              if ssShift in shift then
              begin
                FOwner.SelectRangeEx2(TSI1, NewFocused, false, false, true);
                if TSI1 <> nil then
                  TSI1.Selected := OldSel1;
                 //if FFocused <> nil then FFocused.Selected:=true;
              end;
            end;
            if NewFocused <> nil then
            begin
              if FOwner.FMultiSelect then
              begin
                if ((ssCtrl in Shift) and (FOwner.FSelMode = smUsual)) or (FOwner.FSelMode = smSimple) then
                begin
                  if NewFocused <> TSI then
                     NewFocused.Selected := not sel;
                end;
                if ssShift in shift then
                begin
                  if FFocused <> NewFocused then
                     NewFocused.Selected := false;
                end;
              end;
              if FFocused <> NewFocused then
              begin
                FOwner.DoSetFocusedEx(NewFocused, false, true);

                if FOwner.FMultiSelect then
                   FSelected := PrevSel;
              end
              else
              begin
                if FOwner.FMultiSelect and (FSelected = nil) then
                  FSelected := PrevSel;
                NewFocused.Selected := true;
              end;
            end;
            if (not ((ssCtrl in shift) or (ssShift in shift))) or
               (not FOwner.FMultiSelect) then
            begin
              if FFocused <> nil then
                FSelected := FFocused;
              if (FFocused <> nil) and (not ((FOwner.FMultiSelect) and (FOwner.FSelMode = smSimple))) and (FOwner.FMultiSelect) then
                FFocused.Selected := true;
            end;
            if (FFocused <> nil) and ((FVisible.IndexOf(FFocused) = -1) {or xx}) then
            begin
              if Key = VK_UP then
              begin
                SetVPosition(gr);
              end else
              if Key = VK_DOWN then
              begin
                //FOwner.EnsureVisibleBottom(FItems.GetVisItem(GIRec.i));
                if FOwner.TotalVarHeightCount > 0 then
                   SetVPosition(CalcPageUpPos(gr))
                else
                   SetVPosition(gr - (GetVisCount - 2));
              end else
              if Key = VK_Left then
              begin
                SetVPosition(FFocused.VisIndex);
              end else
              if Key = VK_Right then
              begin
                //FOwner.EnsureVisibleBottom({FItems.GetVisItem(gr)});
                if FOwner.TotalVarHeightCount > 0 then
                   SetVPosition(CalcPageUpPos(gr))
                else
                   SetVPosition(gr - (GetVisCount - 2));
              end else
              if Key = VK_PRIOR then
              begin
                if FOwner.TotalVarHeightCount > 0 then
                     SetVPosition(CalcPageUpPos(FOwner.FTopIndex))
                  else
                     SetVPosition(FOwner.FTopIndex - (GetVisCount - 1));
              end else
              if Key = VK_NEXT then
              begin
                if FOwner.TotalVarHeightCount > 0 then
                   SetVPosition(CalcPageDownPos(FOwner.FTopIndex))
                else
                   SetVPosition(FOwner.FTopIndex + (GetVisCount - 1));
              end
              else
              if KEY = VK_Home then
              begin
                SetVPosition(0);
              end else
              if KEY = VK_End then
              begin
                SetVPosition(FOwner.TotalVisCount - 1);
              end;
              FClearVis := true;
              FClearAll := true;
            end;
          end;
      end; // case
    finally
      with FOwner do
        if FMultiSelect then
          IsUpdating := false;
    end;
    if FOwner.FSelChange then
    begin
      FOwner.DoAfterSelectionChange;
      FOwner.FSelChange := false;
    end;
  end;
end;

{$WARNINGS ON}
procedure TElTreeView.KeyPress(var Key: Char);
begin
  inherited;
end;

procedure TElTreeView.SetFocus;
begin
  if CanFocus then
  try
    inherited SetFocus;
 except
 end;
end;

procedure TElTreeView.DoSetSelected;
var PreLevel : Integer; // CNS
begin
  // if (value <> nil) and (not value.AllowSelection) then exit;

  if FOwner.FMultiSelect then
  begin
    if Value <> nil then with Value do
    begin
      if FOwner.FSelectedList.Count > 0 then // CNS if existing selection(s), then get previous level started
        PreLevel := TElTreeItem(FOwner.FSelectedList.First).Level
      else
        PreLevel:=FOwner.FMultiSelectLevel;

      if FOwner.FMultiSelectLevel >= 0 then // CNS if either existing or new select has wrong level, deselect all
      begin
        if (Value.Level<>FOwner.FMultiSelectLevel) or
           (PreLevel<>FOwner.FMultiSelectLevel) then
          Owner.DeselectAll;
      end;

      if (FBoolData and ibfSelected) > 0 then
      begin
        FOwner.FSelChange := true;
        //Exclude(FState, stsSelected);
        FBoolData := FBoolData and (not ibfSelected);
        FOwner.FSelectedList.Remove(Value);
        if FSelected = Value then
           FSelected := nil;
      end
      else
      begin
        if FOwner.FKeepSelectionWithinLevel and (FOwner.FSelectedList.Count > 0) and
          (FOwner.FSelectedList[0] <> Value) then
        begin
          if Value.Level <> TElTreeItem(FOwner.FSelectedList[0]).Level then
            exit;
        end;

        FOwner.FSelChange := true;
        //Include(FState, stsSelected);
        FBoolData := FBoolData or ibfSelected;
        FOwner.FSelectedList.Add(Value);
        if not Assigned(FOwner.View.FSelected) then
          FOwner.View.FSelected := Value;
      end;
      FOwner.TriggerItemSelectedChangeEvent(Value);
      Value.UpdateItem;
    end
  end
  else
  begin
    if Self.FSelected <> nil then
    with Self.FSelected do
    begin
      FOwner.FSelChange := true;
      //Exclude(FState, stsSelected);
      FBoolData := FBoolData and (not ibfSelected);
      FSelected.UpdateItem;
      FOwner.TriggerItemSelectedChangeEvent(Self.FSelected);
      FSelected := nil;
    end;
    if Value <> nil then with value do
    begin
      FOwner.FSelChange := true;
      //Include(FState, stsSelected);
      FBoolData := FBoolData or ibfSelected;
      FSelected := Value;
      FOwner.TriggerItemSelectedChangeEvent(Value);
      Value.UpdateItem;
//      FOwner.DoAfterSelectionChange;
    end;
  end;
end;

function TElTreeView.GetVisCount;
var
  j: integer;
  CliHeight: integer;

begin
  CliHeight := ClientHeight;
  j := FOwner.FLineHeight;
  result := CliHeight div j;
  if ((CliHeight mod j) > 0) then inc(result);
end;

procedure TElTreeView.CMMouseLeave;
var
  TSI: TElTreeItem;
begin
  if (Message.LParam = 0) or (Message.LParam = TLMDPtrInt(Self)) then
    begin
      if assigned(FInpEdit) and FInpEdit.Visible then exit;
      TSI := FTrackItem;
      FTrackItem := nil;
      if TSI <> nil then
        begin
          TSI.RedrawItem(true);
          Update;
        end;
      FHintItemEx := nil;
      // Destroy Hint timer
      DoHideLineHint;
      if FClickControl <> nil then
        begin
          FClickControl.TriggerMouseUpEvent(mbLeft, LMDGetShiftState, -1, -1);
          FClickControl := nil;
        end;
    end;
  inherited;
end;

procedure TElTreeView.CMHintShow(var Msg : TCMHintShow);
var

  HintInfo : PHintInfo;

  Item     : TElTreeItem;
  IP       : TSTItemPart;
  HCol     : integer;

  {$ifdef LMD_UNICODE}
  {$ifndef LMD_NATIVEUNICODE}
  S : String;
  WS: WideString;
  l : integer;
  T: WideChar;
  {$endif}
  {$endif}

begin

  HintInfo := Msg.HintInfo;

  Item := GetItemAt(HintInfo.CursorPos.X, HintInfo.CursorPos.Y, IP, HCol);
  if (Item <> nil) and (Item.Hint <> '') then
     HintInfo.HintStr := Item.Hint;
  FHintItemEx := Item;
  {$ifdef LMD_UNICODE}
  {$ifndef LMD_NATIVEUNICODE}
  if (Item <> nil) and (Item.Hint <> '') then
    WS := Item.Hint
  else
    WS := Owner.FHint;
  if Length(WS) = 0 then
  begin
    HintInfo.HintStr := '';
    exit;
  end;

  if HintInfo.HintStr = GetShortHint(Owner.Hint) then
  begin
    WS := LMDWideGetShortHint(WS);
    S := WS;
  end
  else
    S := WS;
  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
  {$endif}
  {$endif}
end;

procedure TElTreeView.CMSysColorChange(var Msg: TMessage);

begin
  inherited;
  Invalidate;
  if PlusBmp <> nil then
    ChangeButtonColors(PlusBmp);
  if MinusBmp <> nil then
    ChangeButtonColors(MinusBmp);
  if LeafBmp <> nil then
    ChangeButtonColors(LeafBmp);
  end;

procedure TElTreeView.OnDropTargetDrag(Sender: TObject; State: TDragState; Source: TOleDragObject; Shift: TShiftState; X: Integer; Y: Integer; var DragType: TDragType);
var
  Item: TElTreeItem;

begin
  FOwner.TriggerOleTargetDragEvent(State, Source, Shift, X, Y, DragType);
  DoDragOver(Source, X, Y, DragType in [dtCopy, dtMove, dtLink]);
  if State = dsDragLeave then
  begin
    if Self.FDropTrg <> nil then
    begin
      Item := FDropTrg;
      FDropTrg := nil;
      Item.RedrawItem(true);
    end;
  end;
end;

procedure TElTreeView.OnDropTargetDrop(Sender: TObject; Source: TOleDragObject; Shift: TShiftState; X: Integer; Y: Integer; var DragType: TDragType);
var
  TSI: TElTreeItem;
begin
  TSI := FDropTrg;
  FDropTrg := nil;
  if TSI <> nil then TSI.RedrawItem(true);
  FOwner.TriggerOleTargetDropEvent(Source, Shift, X, Y, DragType);
end;

procedure TElTreeView.WMSetFocus(var Msg : TWMSetFocus);  { private }
begin
  inherited;
  FHasFocus := true;
  if (FOwner.HideSelection or (FOwner.HideSelectColor <> FOwner.FocusedSelectColor) or (FOwner.HideSelectTextColor <> FOwner.FocusedSelectTextColor)) and
     (FOwner.Items.Count > 0) then
    Invalidate;
  with FOwner do
    if Flat or FUseCustomBars or FOwner.IsThemed then UpdateFrame;
end;  { WMSetFocus }

procedure TElTreeView.WMKillFocus(var Msg : TWMKillFocus);  { private }

begin
  FMouseSel := false;
  FPressed  := false;
  FHasFocus := false;
  inherited;
  FHintItemEx := nil;
  DoHideLineHint;

  if HandleAllocated then
  begin
    with FOwner do
      if Flat or FUseCustomBars or FOwner.IsThemed then
      begin
        UpdateFrame;
        DrawFlatBorder(false, false);
        if FUseCustomBars then
        begin
          HScrollBar.HideHint;
          VScrollBar.HideHint;
        end;
      end;
    if (FOwner.HideSelection or (FOwner.HideSelectColor <> FOwner.FocusedSelectColor) or (FOwner.HideSelectTextColor <> FOwner.FocusedSelectTextColor)) and
       (FOwner.Items.Count > 0) then
      Invalidate;
  end;
end;  { WMKillFocus }

function TElTreeView.GetDragImages: TDragImageList;

begin
  if (FDragImages <> nil) and (FDragImages.Count > 0) then
     Result := FDragImages
  else
     result := nil;
end;

procedure TElTreeView.UpdateView;
var
  R: TRect;
begin
  if (not HandleAllocated) then
  begin
    FOwner.FUpdated := true;
    exit;
  end;
  if FOwner.FUpdateCount > 0 then
    FOwner.FUpdated := true
  else
  begin
    if FRangeUpdate or (FClearAll) then
    begin
      if (FOwner.FVerticalLines and FOwner.FShowHeader) or (FClearAll) then
      begin
        R := ClientRect;
        FClearAll := false;
      end
      else
        R := Rect(0, 0, ClientWidth, GetVisiblesHeight);
      InvalidateRect(Handle,@R, true);
      FRangeUpdate := false;
    end;
    Update;
  end;
end;

procedure TElTreeView.DoPaintBkgnd(DC : HDC; ClipRect : TRect);
var
  AClipRect: TRect;
  ACtl : TWinControl;
  R1,
  BgRect

  ,
  BgRect1

          : TRect;
begin
  Canvas.Brush.Color := FOwner.BkColor;
  BgRect := ClientRect;
  Inc(BgRect.Bottom);
  Inc(BgRect.Right);
  AClipRect := ClipRect;
  if (FOwner.FImgForm <> nil) and (not (csDesigning in FOwner.FImgForm.ComponentState)) then
  begin
    //if (FOwner.FImgForm.Control <> Parent) then
    begin
      ACtl := FOwner.FImgForm.GetRealControl;
      R1 := BgRect;
      BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      //BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
      //BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

      FOwner.FImgForm.PaintBkgnd(DC, R1, BgRect.TopLeft, false);
    end;
  end
  else
  if (FOwner.BackgroundType <> bgtColorFill) then
  begin
    BgRect1 := BgRect;
    if FOwner.BackgroundType <> bgtCenterBitmap then
    begin
      LMDExtDrawBkgnd(DC,  BgRect1, BgRect, BgRect, AClipRect, false, Canvas.Brush.Color, Canvas.Brush.Color, FTmpBmp, bgtCenterBitmap);
    end
    else
    begin
      LMDExtDrawBkgnd(DC, BgRect1, BgRect, BgRect, AClipRect, false, Canvas.Brush.Color, Canvas.Brush.Color, FOwner.Background, FOwner.BackgroundType);
    end;
    end
  else

  begin
    if not FOwner.InSizeMove then
      FillRect(DC, AClipRect, Canvas.Brush.Handle);
    end;
end;

{$warnings off}

procedure TElTreeView.WMPaint(var Msg : TWMPaint);  { private }
var
  ADC,
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R : TRect;
  ARgn : HRGN;
  DoDoubleBuffer : boolean;
begin
  DoDoubleBuffer := (FOwner.DoubleBuffered and not Fowner.InSizeMove) or (FOwner.InSizeMove and FOwner.DoubleBufferedOnResize);
  if not FOwner.IsUpdating then
  begin
    if (Msg.DC <> 0) then
      PaintHandler(Msg)
    else
    begin
      DC := BeginPaint(Handle, PS);
      try
        if DoDoubleBuffer then
        begin
          //DC := GetDC(0);
          MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
          //ReleaseDC(0, DC);
          MemDC := CreateCompatibleDC(0);
          OldBitmap := SelectObject(MemDC, MemBitmap);
          ADC := MemDC;
        end
        else
          ADC := 0;

        try
          if not DoDoubleBuffer then
            ADC := DC;
          GetClipBox(DC, R);
          if IsRectEmpty(R) then
            R := ClientRect
          else
          begin
            inc(R.Right);
            inc(R.Bottom);
          end;
          //with R do
          //  BitBlt(MemDC, Left, Top, Right - Left, Bottom - Top, DC, Left, Top, SRCCOPY);

          if DoDoubleBuffer then
          begin
            with R do
              ARgn := CreateRectRgn(Left, Top, Right, Bottom);
            {$IFDEF DEBUG_TREE_DRAW}
              SelectClipRgn({A$$}DC, ARgn);
            {$ELSE}
              SelectClipRgn(ADC, ARgn);
            {$ENDIF}
          end;

          {$IFDEF DEBUG_TREE_DRAW}
            DoPaintBkgnd({A$$}DC, R);
            Msg.DC := {A$$}DC;
          {$ELSE}
            DoPaintBkgnd(ADC, R);
            Msg.DC := ADC;
          {$ENDIF}

          PaintHandler(Msg);

          if DoDoubleBuffer then
          begin
          {$IFDEF DEBUG_TREE_DRAW}
            SelectClipRgn({Mem$$}DC, 0);
          {$ELSE}
            SelectClipRgn(MemDC, 0);
          {$ENDIF}
            DeleteObject(ARgn);
          end;
          Msg.DC := 0;
          if DoDoubleBuffer then
            with R do
              {$IFDEF DEBUG_TREE_DRAW}
                BitBlt(DC, Left, Top, Right - Left, Bottom - Top, {Mem$$}DC, Left, Top, SRCCOPY);
              {$ELSE}
                BitBlt(DC, Left, Top, Right - Left, Bottom - Top, MemDC, Left, Top, SRCCOPY);
              {$ENDIF}
        finally
          if DoDoubleBuffer then
          begin
            SelectObject(MemDC, OldBitmap);
            DeleteDC(MemDC);
            DeleteObject(MemBitmap);
          end;
        end;
      finally
        EndPaint(Handle, PS);
      end;
    end;
  end
  else
  begin
    DefWindowProc(Handle, WM_PAINT, TMessage(Msg).wParam, TMessage(Msg).lParam);
    FClearAll := true;
  end;
end;
{$warnings on}

function TElTreeView.GetVisCount2: Integer;
var
  j: integer;
  CliHeight: integer;

begin
  CliHeight := Height;
  j := FOwner.FLineHeight;
  result := CliHeight div j;
end;

procedure TElTreeView.OnDragExpandTimer(Sender : TObject);
begin
  FDragExpandTimer.Enabled := false;
  if (FDropTrg <> nil) and (not FDropTrg.Expanded) {and (FDropTrg.HasVisibleChildren) }then
  begin
    if FOwner.FDragObject <> nil then
      FOwner.FDragObject.HideDragImage;
    FDropTrg.Expand(false);
    Update;
    if FOwner.FDragObject <> nil then
      FOwner.FDragObject.ShowDragImage;
  end;
end;

procedure TElTreeView.StartClearSearchTimeoutThread ;
begin
  if Assigned (SearchTextTimeoutThread) then
    TSearchTextTimeoutThread(SearchTextTimeoutThread).KeepAlive := True
  else
  begin
    SearchTextTimeoutThread := TSearchTextTimeoutThread.Create ;
    SearchTextTimeoutThread.OnTerminate := SearchTextTimeout ;
    SearchTextTimeoutThread.Resume
  end;
  TSearchTextTimeoutThread(SearchTextTimeoutThread).IncrementalSearchTimeout := FOwner.IncrementalSearchTimeout;
end;

procedure TElTreeView.StopClearSearchTimeoutThread ;
begin
  if Assigned (SearchTextTimeoutThread) then
  begin
    SearchTextTimeoutThread.OnTerminate := nil ;
    SearchTextTimeoutThread.Terminate ;

    SearchTextTimeoutThread := nil
  end
end ;

procedure TElTreeView.SearchTextTimeout (Sender : TObject) ;
begin
  SearchTextTimeoutThread := nil ;
  Input.Reset;
end;

procedure TElTreeView.FitMostChildren(Item : TElTreeItem);
var
  R: TRect;
  i,
  k,
  ch,
  cti : integer;
  oi  : integer;
  TopItem: TElTreeItem;

begin
  if Item.FullyExpanded and Item.FullyVisible and (FOwner.IsInView(Item)) then
  begin
    k := Item.CalcSubItemsHeight;
    TopItem := FOwner.GetTopItem();
    if TopItem <> nil then
    begin
      cti := TopItem.VisIndex;
      oi  := Item.VisIndex;
      R   := GetItemRect(FVisible.IndexOf(Item));
      i   := 0;
      ch := ClientHeight;
      if cti < oi then
      begin
        while (cti < oi) do
        begin
          if FVisible.Count <= i then
            break;

          TopItem := TElTreeItem(FVisible[i]);

          if R.Bottom + k >= ch then
          begin

            Dec(R.Bottom, TopItem.Height);

            inc(i);
            Inc(cti);
          end
          else
          begin
            break;
          end;
        end;
        FOwner.GetTotalVisCount;
        FOwner.TopIndex := FOwner.TopIndex + i;
      end;
    end;
  end;
end;

{$warnings off}
type
  TGIRec = record
    i, oi,
    ni, PgCnt  : integer;
    TSI, OTSI  : TElTreeItem;
    Sel, fp    : boolean;
    NewFocused : TElTreeItem;
  end;
  PGIRec = ^TGIRec;
  procedure TElTreeView.IntVis0(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
    IterateData: TLMDDataTag; Tree: TCustomElTree);

begin
  with PGIRec(IterateData)^ do
  begin
    if (Item.Enabled or (Tree.IgnoreEnabled)) then
    begin
      Sel := Item.Selected;
      NewFocused := Item;
      i := 0;
      ContinueIterate := false;
    end;
  end;
  end;

procedure TElTreeView.IntNextVis(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
  IterateData: TLMDDataTag; Tree: TCustomElTree);

begin
  with PGIRec(IterateData)^ do
  begin
    if (OTSI = Tree.FView.FFocused) and (Tree.IgnoreEnabled or (Item.Enabled)) then
    begin
      Sel := Item.Selected;
      NewFocused := Item;
      i := Index;
      ContinueIterate := false;
    end;
    if Item = Tree.FView.FFocused then
       OTSI := Item;
  end;
  end;

procedure TElTreeView.IntPgVis(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
  IterateData: TLMDDataTag; Tree: TCustomElTree);

begin
  with PGIRec(IterateData)^ do
  begin
    if Item = Tree.FView.FFocused then
       oi := 1;
    if oi = 1 then
    begin
      if Tree.IgnoreEnabled or Item.Enabled then
      begin
        dec(PgCnt);
        NewFocused := Item;
      end;

      TSI := Item;
      Sel := Item.Selected;
      i := Index;
    end;
    if PgCnt < 0 then
    begin
      ContinueIterate := false;
    end;
  end;
  end;

function TElTreeView.FindNewFocused(Key : word; var Sel : boolean): TElTreeItem;

begin
  Result := FindNewFocused(Key, nil, Sel);
  end;

function TElTreeView.FindNewFocused(Key : word;  PVal1 : PInteger; var Sel : boolean): TElTreeItem;
var
  GIRec: TGIRec;
begin
  Result := nil;
  FillChar(GIRec, sizeof(GIRec), 0);
  if Key = VK_UP then
  begin
    if FFocused = nil then
    begin
      if FOwner.TotalVisCount > 0 then
      begin
        FItems.Iterate(true, false, IntVis0, @GIRec);
        Result := GIRec.NewFocused;
      end;
    end
    else
    begin
      FItems.IterateBack(true, false, IntNextVis, @GIRec);
      if GIRec.NewFocused <> nil then
        Result := GIRec.NewFocused
      else
        Result := FFocused;
    end;
    if PVal1 <> nil then
      PVal1^ := GIRec.i;
    Sel := GIRec.Sel;
  end
  else
  if Key = VK_DOWN then
  begin
    if FFocused = nil then
    begin
      if FOwner.TotalVisCount > 0 then
      begin
        FItems.Iterate(true, false, IntVis0, @GIRec);
        result := GIRec.NewFocused;
      end;
    end else
    begin
      FItems.Iterate(true, false, IntNextVis, @GIRec);
      if GIRec.NewFocused <> nil then
        result := GIRec.NewFocused
      else
        result := FFocused;
    end;
    if PVal1 <> nil then
      PVal1^ := GIRec.i;
    Sel := GIRec.Sel;
  end
  else
  if Key = VK_NEXT then
  begin
    if FOwner.TotalVarHeightCount > 0 then
       GIRec.PgCnt := CalcPageDownPos(FOwner.FTopIndex) - FOwner.FTopIndex
    else
       GIRec.PgCnt := GetVisCount - 1;

    GIRec.oi := 0;
    GIRec.NewFocused := nil;
    if FFocused <> nil then
       FItems.IterateFrom(true, false, IntPgVis, @GIRec, FOwner.ItemFocused);
    if GIRec.NewFocused <> nil then
      result := GIRec.NewFocused
    else
      result := FFocused;
    Sel := GIRec.Sel;
  end
  else
  if Key = VK_PRIOR then
  begin
    if FFocused = nil then
    begin
      if FOwner.TotalVarHeightCount > 0 then
         GIRec.PgCnt := FOwner.FTopIndex - CalcPageUpPos(FOwner.FTopIndex)
      else
         GIRec.PgCnt := GetVisCount - 1;
    end else
    begin
      GIRec.oi := FFocused.VisIndex;
      if FOwner.TotalVarHeightCount > 0 then
         GIRec.PgCnt := GIRec.oi - CalcPageUpPos(GIRec.oi)
      else
         GIRec.PgCnt := GetVisCount - 1;
    end;
    GIRec.oi := 0;
    GIRec.NewFocused := nil;

    if FFocused <> nil then
       FItems.IterateBackFrom(true, false, IntPgVis, @GIRec, FOwner.ItemFocused);
    if GIRec.NewFocused <> nil then
      result := GIRec.NewFocused
    else
      result := FFocused;

    Sel := GIRec.Sel;
  end
  else
  if Key = VK_HOME then
  begin
    if FFocused <> nil then
    begin
      FItems.Iterate(true, false, IntVis0, @GIRec);
      result := GIRec.NewFocused;
      GIRec.i := 0;
      if result = nil then
      begin
        with FOwner do
        begin
          result := ItemFocused;
          GIRec.i := FTopIndex;
        end;
      end;
    end;
    Sel := GIRec.Sel;
  end
  else
  if Key = VK_END then
  begin
    if FFocused <> nil then
    with FOwner do
    begin
      GIRec.i := TotalVisCount - 1;
      Result := FItems.GetVisItem(GIRec.i);
      while (Result <> nil) and (not (FOwner.IgnoreEnabled or Result.Enabled)) do
      begin
        dec(GIRec.i);
        if GIRec.i >= 0 then
           Result := FItems.GetVisItem(GIRec.i);
      end;
      if Result = nil then
      begin
        Result := ItemFocused;
        GIRec.i := FTopIndex;
      end;
    end;
    Sel := GIRec.Sel;
  end;
  end;

{$warnings on}

procedure TElTreeView.DrawMouseSelectFrame;
var R,
    R1 : TRect;
    si,
    ei : integer;

begin
  R := Rect(Min(FMFSStartCoord.X, FMFSEndCoord.X), 0, Max(FMFSStartCoord.X, FMFSEndCoord.X), 0);
  OffsetRect(R, -FOwner.FHPos, 0);
  si := FVisible.IndexOf(FMFSStartItem);
  if si <> -1 then
  begin
    R1 := GetItemRect(si);
    si := R1.Top + FMFSStartCoord.Y;
  end;
  ei := FVisible.IndexOf(FMFSEndItem);
  if ei <> -1 then
  begin
    R1 := GetItemRect(ei);
    ei := R1.Top + FMFSEndCoord.Y;
  end;
  if (ei <> -1) and (si <> -1) then
  begin
    R.Top := Min(si, ei);
    R.Bottom := Max(si, ei);
  end
  else
  if (si = -1) and (ei = -1) then
  begin
    R.Top := -1;
    R.Bottom := ClientHeight + 1;
  end
  else
  if si = -1 then
  begin
    if FMFSStartItem.AbsoluteIndex > FMFSEndItem.AbsoluteIndex then
    begin
      R.Top := ei;
      R.Bottom := ClientHeight + 1;
    end
    else
    begin
      R.Top := -1;
      R.Bottom := ei;
    end;
  end
  else
  if ei = -1 then
  begin
    R.Top := si;
    R.Bottom := ClientHeight + 1;
  end;
  Canvas.Brush.Color := FOwner.FBkColor;
  Canvas.Pen.Color := FOwner.FTextColor;
  Canvas.Font.Color := FOwner.FTextColor;
  // this one is made to fix the colors
  Canvas.TextOut(R.Left, R.Top, '');
  // otherwise FocusRect won't draw right
  Canvas.DrawFocusRect(R);
end;

procedure TElTreeView.AllocateMouseSelectFrame;
begin
  DrawMouseSelectFrame;
end;

procedure TElTreeView.DeallocateMouseSelectFrame;
begin
  DrawMouseSelectFrame;
end;

procedure TElTreeView.SelectMouseSelectItems;
var si,
    ei   : integer;
    i    : integer;
    al   : TLMDObjectList;
    Item : TElTreeItem;
    R    : TRect;
    HCol : integer;
    ip   : TSTItemPart;
begin
  i := 0;
  if (FMFSEndItem = FMFSStartItem) then
  begin
    si := FMFSStartItem.AbsoluteIndex;
    ei := si;
    if (FMFSStartItem = FVisible.Last) then
    begin
      R := GetItemRect(FVisible.Count - 1);
      Item := GetItemAt(FMFSStartCoord.X - FOwner.FHPos, FMFSStartCoord.Y + R.Top, ip, HCol);
      if Item = nil then
      begin
        Item := GetItemAt(FMFSEndCoord.X - FOwner.FHPos, FMFSEndCoord.Y + R.Top, ip, HCol);
        if Item = nil then
        begin
          ei := si - 1;
          i := -1;
        end;
      end;
    end;
  end
  else
  begin
    {
    if FMFSStartItem.Selected then
      si := FMFSStartItem.AbsoluteIndex + 1
    else
    }
      si := FMFSStartItem.AbsoluteIndex;
    ei := FMFSEndItem.AbsoluteIndex;
  end;
  if (si > ei) and (i <> -1) then
  begin
    i := si;
    si := ei;
    ei := i;
  end;

  Al := TLMDObjectList.Create;
  for i := si to ei do
  begin
    Item := FOwner.Items[i];
    if FOwner.ShowColumns then
    begin
      if (Min(FMFSStartCoord.X, FMFSEndCoord.X) < FOwner.FHeader.SectionsWidth) and (not (FOwner.FilteredVisibility and Item.Hidden)) then
        Al.Add(Item);
    end
    else
    if (Min(FMFSStartCoord.X, FMFSEndCoord.X) < Item.GetWidth) and (not (FOwner.FilteredVisibility and Item.Hidden)) then
        Al.Add(Item);
  end;
  FOwner.SetUpdating(true);
  for i := 0 to Al.Count - 1 do
  begin
    Item := TElTreeItem(Al.FastGet(i));
    if FMFSList.IndexOf(Item) = -1 then
    begin
      if FOwner.IgnoreEnabled or Item.Enabled then
      begin
        if Item = FMFSStartItem then
          Item.Selected := true
        else
          Item.Selected := not Item.Selected;
      end;
    end;
  end;
  for i := 0 to FMFSList.Count - 1 do
  begin
    Item := TElTreeItem(FMFSList.FastGet(i));
    if AL.IndexOf(Item) = -1 then
    begin
      if FOwner.IgnoreEnabled or Item.Enabled then
        Item.Selected := not Item.Selected;
    end;
  end;
  FOwner.SetUpdating(false);
  Update;
  FMFSList.Free;
  FMFSList := AL;
end;

procedure TElTreeView.WMCancelMode(var Message: TWMCancelMode);
begin
  if FMouseSel then
    CancelMouseSel;
  inherited;
end;

procedure TElTreeView.CancelMouseSel;
begin
  FMFSList.Free;
  FMFSList := nil;
  FMouseSel := false;
  if FOwner.FMouseFrameVisible then
    DeallocateMouseSelectFrame;
  ReleaseCapture;
  end;

procedure TElTreeView.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);

  if Assigned(FOwner.FDropTarget) then
    FOwner.FDropTarget.Target := Self;
end; {CreateWindowHandle}

procedure TElTreeView.DestroyWindowHandle;
begin
  if Assigned(FOwner.FDropTarget) and (FOwner.FDropTarget.Target = Self) then
    FOwner.FDropTarget.Target := nil;
  inherited;
end;

procedure TElTreeView.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
  end;

procedure TElTreeView.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (FOwner.ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TElTreeView.CMDeactivate(var Message: TCMDeactivate);
begin
  inherited;
  if FOwner.FHideSelect then
    Invalidate;
end;

procedure TElTreeView.CMDrag(var Message: TCMDrag);
var
  TSI: TElTreeItem;
begin
  FOwner.FDragObject := Message.DragRec^.Source;
  inherited;
  with Message, DragRec^ do
  begin
    case DragMessage of
      dmDragEnter:
        FInDragging := true;
      dmDragMove:
        begin
          if FOwner.DragAllowed then
            with ScreenToClient(Pos) do
              DoDragOver(Source, X, Y, Message.Result <> 0);
        end;
      (*
      dmFindTarget:
        begin
          if FOwner.DragAllowed then
            with ScreenToClient(Pos) do
              DoDragOver(Source, X, Y, Message.Result <> 0);
        end;
      *)
      dmDragLeave:
        begin
          FInDragging := false;
          FOwner.FDragObject := nil;
          if FDragExpandTimer <> nil then
          begin
            FDragExpandTimer.Enabled := false;
          end;

          if FOwner.DragAllowed then
          begin
            if FDragScrollTimer <> nil then
            begin
              FDragScrollTimer.Free;
              FDragScrollTimer := nil;
            end;
            TDragObject(Source).HideDragImage;
            TSI := FDropTrg;
            FDropTrg := nil;
            if TSI <> nil then
            begin
              TSI.RedrawItem(false);
              Update;
            end;
            TDragObject(Source).ShowDragImage;
          end;
        end;
      dmDragDrop,
      dmDragCancel:
        begin
          FInDragging := false;
          FOwner.FDragObject := nil;
          if FDragExpandTimer <> nil then
          begin
            FDragExpandTimer.Enabled := false;
            FDragExpandTimer.Free;
            FDragExpandTimer := nil;
          end;

          if FOwner.DragAllowed then
          begin
            if FDragScrollTimer <> nil then
            begin
              FDragScrollTimer.Free;
              FDragScrollTimer := nil;
            end;
            TSI := FDropTrg;
            FDropTrg := nil;
            if TSI <> nil then
            begin
              TSI.RedrawItem(false);
              Update;
            end;
          end;
        end;
    end;
  end;
end;

procedure TElTreeView.InitiateEditOp(Item : TElTreeItem; HCol : integer;
    Immediate : boolean);
begin
  with FOwner do
  if (FShowHeader) then
  begin
    if ((FClickSection = HCol) or (FOwner.QuickEditMode)) and FHeader.Sections[HCol].Editable and
        not (csDesigning in FOwner.ComponentState) then
    begin
      if FEditTimer = nil then
        FEditTimer := TTimer.Create(self);
      FEditTimer.Enabled := false;
      // FEditTimer.Interval := 500;
      if not Immediate then
        FEditTimer.Interval := FOwner.InplaceEditorDelay
      else
        FEditTimer.Interval := 1;
      FEditTimer.OnTimer := OnEditTimer;
      FItemToEdit := Item;
      FEditSect   := HCol;
      FEditTimer.Enabled := true;
    end;
  end
  else
  if not (csDesigning in FOwner.ComponentState) then
  begin
    if FEditTimer = nil then
      FEditTimer := TTimer.Create(self);
    FEditTimer.Enabled := false;
    if not Immediate then
      FEditTimer.Interval := FOwner.InplaceEditorDelay
    else
      FEditTimer.Interval := 1;
    FEditTimer.OnTimer := OnEditTimer;
    FItemToEdit := Item;
    FEditSect   := -1;
    FEditTimer.Enabled := true
  end;
end;

function TElTreeView.IsControlCell(Item : TElTreeItem; SectionIndex : integer):
    Boolean;
var
  AStyle : TElCellStyle;
  i : integer;
begin
  result := false;
  if Item.UseStyles then
  begin
    if FOwner.VirtualityLevel = vlNone then
    begin
      i := SectionIndex;
      if i = FOwner.FMainTreeCol then
        AStyle := Item.MainStyle
      else
      begin
        if i > FOwner.FMainTreeCol then Dec(i);
        if Item.StylesCount > i then
          AStyle := Item.Styles[i]
        else
          AStyle := Item.MainStyle;
      end;
    end
    else
    begin
      AStyle := VirtStyle;
      FOwner.TriggerVirtualStyleNeeded(Item, SectionIndex, AStyle);
    end;
    if (AStyle <> nil) and (not AStyle.OwnerProps) and (AStyle.Control <> nil) and (AStyle.Control.Visible) then
      result := true;
  end;
end;

procedure TElTreeView.DrawCellImage(ACanvas : TCanvas; Item : TElTreeItem;
    ImageIndex : Integer; SectionIndex : integer; HelperBitmap : TBitmap; var R
    : TRect);
var
  FTImages : TCustomImageList;
  FATImages : TCustomImageList;
  ImDrawStyle: TDrawingStyle;
  StImIndex: integer;
  h, w     : integer;
  R2       : TRect;
  xp       : integer;
  amBmp : TBitmap;
  begin
  if R.Left >= R.Right then exit;

  with FOwner do
  begin
    FTImages := FImages;
    FATImages := FAlphaImages;
    if FTImages <> nil then
    begin
      ImDrawStyle := FTImages.DrawingStyle;
      FTImages.DrawingStyle := dsNormal;
      StImIndex := ImageIndex;
      if StImIndex = -1 then
        StImIndex := DoGetPicture(Item);

      if LMDInRange(StImIndex, 0, FTImages.Count - 1) then
      begin
        h := FTImages.Height;
        w := FTImages.Width;

        if FOwner.RightAlignedView then
          R2 := Rect(Max(R.Left, R.Right - w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), R.Right, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h)
        else
          R2 := Rect(R.Left, R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1), Min(R.Right, R.Left + w), R.Top + ((R.Bottom - R.Top + 1) shr 1) - (h shr 1) + h);

        if R2.Right - R2.Left = w then
        begin
          OffsetRect(R2, ((R.right - R.Left) - w) div 2, 0);
        end;
        if R2.Right >= R2.Left then
        begin
          HelperBitmap.PixelFormat := pfDevice;
          HelperBitmap.Height := R2.Bottom - R2.Top;
          HelperBitmap.Width  := R2.Right - R2.Left;

          bitblt(HelperBitmap.Canvas.Handle, 0, 0, HelperBitmap.Width, HelperBitmap.Height, ACanvas.Handle, R2.Left, R2.Top, srccopy);
          if FOwner.RightAlignedView then
            xp := HelperBitmap.Width - w
          else
            xp := 0;
          FTImages.Draw(HelperBitmap.Canvas, xp, 0, StImIndex);

          if (FATImages <> nil) and LMDInRange(StImIndex, 0, FATImages.Count - 1) then
          begin
            amBMP := TBitmap.Create;
            amBMP.Width := FATImages.Width;
            amBMP.Height := FATImages.Height;
            ImageList_DrawEx(FATImages.Handle, StImIndex, amBMP.Canvas.Handle, 0, 0, 0, 0,
              clNone, clNone, ILD_Normal);

            AlphaCopyRect2(ACanvas.Handle, r2, HelperBitmap.Canvas.Handle,
              rect(0, 0, HelperBitmap.Width, HelperBitmap.Height), amBMP, 255);

            amBMP.Free;
          end
          else
            bitblt(ACanvas.Handle, r2.Left, R2.Top, HelperBitmap.Width, HelperBitmap.Height, HelperBitmap.Canvas.Handle, 0, 0, srccopy);
          end;

        if FOwner.RightAlignedView then
          dec(R.Right, w)
        else
          inc(R.Left, w);
      end;

      FTImages.DrawingStyle := ImDrawStyle;
      end;
  end;
end;

procedure TElTreeView.DoPerformSearch(SearchText : TLMDString);
var
  liSearchTextLength,
  liIndex,
  siIndex  : Integer ;
  AnItem   : TElTreeItem;
  ItemText : TLMDString;
begin
  if (SearchText > '') then
  begin
    liSearchTextLength := Length (SearchText) ;
    //ItemsCount := FOwner.Items.Count;
    if (FOwner.FIncrementalSearchScope = issWholeTree) or (FOwner.ItemFocused = nil) then
    begin
      if FOwner.ItemFocused = nil then
      begin
        liIndex := 0;
        siIndex := - 1;
      end
      else
      begin
        liIndex := FOwner.ItemFocused.AbsoluteIndex;
        siIndex := liIndex - 1;
        //if siIndex = -1 then
        //  siIndex := FOwner.Items.Count - 1;
      end;
    end
    else
    begin
      liIndex := FOwner.ItemFocused.FParent.GetFirstChild.Index;
      siIndex := FOwner.ItemFocused.FParent.GetLastSubItem.Index;
    end;
    while (liIndex <> siIndex) do
    begin
      AnItem := FOwner.Items [liIndex];
      if AnItem <> nil then
      begin
        ItemText := FOwner.GetIncSearchColumnText(AnItem);

        if ((not FOwner.FilteredVisibility) or (not AnItem.Hidden)) and AnItem.Enabled then
        begin
          {$ifdef LMD_UNICODE}
          if LMDWideSameText(SearchText, Copy(ItemText, 1, liSearchTextLength)) then
          {$else}
          if LMDAnsiSameText(SearchText, Copy (ItemText, 1, liSearchTextLength)) then
          {$endif}
          begin
            FOwner.EnsureVisible(AnItem) ;
            AnItem.Focused := True ;
            AnItem.Selected := False ;
            FOwner.DoAfterSelectionChange;
            break;
          end ;
        end;
        inc(liIndex);
        if liIndex >= FOwner.Items.Count then
        begin
          if siIndex = -1 then
            break
          else
            liIndex := 0;
        end;
      end
      else
        exit;
    end;
    StartClearSearchTimeoutThread;
  end;
end;

procedure TElTreeView.WMKeyDown(var Message: TWMKeyDown);
begin
  inherited;
  if FOwner.IncrementalSearch then
  begin
    Input.WMKeyDown(Message);
    DoPerformSearch(Input.Text);
  end;
end;

procedure TElTreeView.WMIMEStartComposition(var Message: TMessage);
var
  IMC: HIMC;
  LogFont: TLogFont;
  CF: TCompositionForm;
  FCRect : TRect;
begin
  inherited;
  if FOwner.IncrementalSearch then
  begin
    IMC := ImmGetContext(Handle);
    if IMC <> 0 then
    begin
      GetObject(Canvas.Font.Handle, SizeOf(TLogFont), @LogFont);
      ImmSetCompositionFont(IMC, @LogFont);
      CF.dwStyle := CFS_RECT;
      CF.rcArea  := ClientRect;
      if FOwner.ItemFocused <> nil then
      begin
        FCRect := GetItemRect(FOwner.IndexInView(FOwner.ItemFocused));
        CF.ptCurrentPos := FCRect.TopLeft;
      end
      else
        CF.ptCurrentPos := Point(0, 0);

      ImmSetCompositionWindow(IMC, @CF);
      ImmReleaseContext(Handle, IMC);
    end;
  end;
end;

procedure TElTreeView.WMIMEComposition(var Message: TMessage);
begin
  inherited;
  if FOwner.IncrementalSearch then
  begin
    {$ifdef LMD_UNICODE}
    Input.WMImeComposition(Message);
    {$endif}
    DoPerformSearch(Input.Text);
  end;
end;

{$ifdef LMD_UNICODE}
procedure TElTreeView.WMDeadChar(var Message: TWMDeadChar);
begin
  inherited;
  if FOwner.IncrementalSearch then
    Input.WMDeadChar(Message);
end;
{$endif}

procedure TElTreeView.WMHScroll(var Msg : TWMHScroll);
var b : boolean;
    sc: TElscrollCode;
    sp: integer;
begin
  b := false;
  sc := escPosition;
  case Msg.ScrollCode of
    SB_TOP:       sc := escTop;
    SB_BOTTOM:    sc := escBottom;
    SB_ENDSCROLL: sc := escEndScroll;
    SB_LINEDOWN:  sc := escLineDown;
    SB_LINEUP:    sc := escLineUp;
    SB_PAGEDOWN:  sc := escPageDown;
    SB_PAGEUP:    sc := escPageUp;
    SB_THUMBPOSITION: sc := escPosition;
    SB_THUMBTRACK: sc := escTrack;
  end;
  sp := Msg.Pos;
  OnHScroll(FOwner.FHScrollBar, SC, sp, b);
end;  { WMHScroll }

procedure TElTreeView.WMVScroll(var Msg : TWMVScroll);
var b : boolean;
    sc: TElscrollCode;
    sp: integer;
    ScrollInfo : TScrollInfo;
begin
  b := false;
  sc := escPosition;
  case Msg.ScrollCode of
    SB_TOP:       sc := escTop;
    SB_BOTTOM:    sc := escBottom;
    SB_ENDSCROLL: sc := escEndScroll;
    SB_LINEDOWN:  sc := escLineDown;
    SB_LINEUP:    sc := escLineUp;
    SB_PAGEDOWN:  sc := escPageDown;
    SB_PAGEUP:    sc := escPageUp;
    SB_THUMBPOSITION: sc := escPosition;
    SB_THUMBTRACK: sc := escTrack;
  end;
  ScrollInfo.cbSize := Sizeof(ScrollInfo);
  ScrollInfo.fMask := SIF_POS or SIF_TRACKPOS or SIF_RANGE;
  if FOwner.FUseCustomBars then
    GetScrollInfo(FOwner.FVScrollBar.Handle, SB_CTL, ScrollInfo)
  else
    Windows.GetScrollInfo({FOwner.}Handle, SB_VERT, ScrollInfo);
  if (Msg.ScrollCode <> SB_THUMBTRACK) and (Msg.ScrollCode <> SB_THUMBPOSITION) then
    sp := ScrollInfo.nPos
  else
    sp := ScrollInfo.nTrackPos;
  OnVScroll(FOwner.FVScrollBar, SC, sp, b);
end;  { WMVScroll }

procedure TElTreeView.WMNCCalcSize(var Message : TWMNCCalcSize);
begin
  if not FOwner.UseCustomScrollBars then
    inherited;
  Message.Result := WVR_VREDRAW;
end;

// ****************************************************************************
//                                   TElTreeItem
// ****************************************************************************

constructor TElTreeItem.Create(AOwner: TCustomElTree);
begin
  inherited Create;
  FOwner := AOwner;
  FBoolData := ibfOwnerHeight or ibfEnabled;

  FComplexHeight := WORD(-1);
  //FRealHeight  := -1;

end;

destructor TElTreeItem.Destroy;
begin
  if (FOwner <> nil) and ((FBoolData and ibfSelected) > 0) then
  begin
    with FOwner do
    begin
      if FMultiSelect then
        FSelectedList.Remove(Self)
      else
        FView.FSelected := nil;
    end
  end;
  if FChildren <> nil then
    FreeAndNil(FChildren);
  FDataInterface := nil;

  if IsHTML then
    inc(FOwner.TotalVarHeightCount);
  IsHTML := false;

  inherited Destroy;
end;

procedure TElTreeItem.CreateStyles;
begin
  if FStaticData <> nil then
  with FStaticData^ do
  begin
    FStyles := TLMDObjectList.Create;
    FStyles.OnDelete := OnStyleDelete;
  end;
end;

procedure TElTreeItem.OnStyleDelete(Sender: TObject; var Item:TLMDDataTag);
var
  cs: TElCellStyle;
begin
  cs := TElCellStyle(Item);
  Item := nil;
  cs.Free;
end;

type
  TItemPersistInfo = record
    FState        : TSTIStates;
    FImageIndex   : integer;
    FStImageIndex : integer;
    FImageIndex2  : integer;
    FStImageIndex2: integer;
    FBoolData1    : integer;
    FBoolData2    : integer;
    FColor        : TColor;
    FRowBkColor   : TColor;
    FBkColor      : TColor;
    FCheckBoxState: TCheckBoxState;
    FCheckBoxType : TElCheckBoxType;
    FHeight       : Cardinal;
    FBorderStyle  : TElItemBorderStyle;
    FIndentAdjust : integer;
    FStrikedLineColor: TColor;
    FTag          : Integer;
    FOverlayImage : integer;
    FOtherData    : array[0..14] of integer;
    end;

  TS28aItemInfo = record
    FState       : TSTIStates;
    FImageIndex  : integer;
    FStImageIndex: integer;
    ForceButtons : LongBool;
    FColor,
    FRowBkColor,
      FBkColor   : TColor;
    FParentColors: boolean;
    FParentStyle : boolean;
    FCheckBoxEnabled: Boolean;
    FCheckBoxState: TCheckBoxState;
    FShowCheckBox: Boolean;
    FCheckBoxType: TElCheckBoxType;
    FImageIndex2: integer;
    FStImageIndex2: integer;
    FEnabled: boolean;
    FHidden: boolean;
    FUseBkColor : boolean;

    FMultiline    : boolean;
    FOwnerHeight  : boolean;
    FHeight       : Cardinal;
    FSuppressLines: boolean;

    FIsHTML   : boolean;

  end;

  TS28ItemInfo = record
    FState: TSTIStates;
    FImageIndex: integer;
    FStImageIndex: integer;
    ForceButtons: LongBool;
    FColor,
      FBkColor: TColor;
    FParentColors: boolean;
    FParentStyle: boolean;
    FCheckBoxEnabled: Boolean;
    FCheckBoxState: TCheckBoxState;
    FShowCheckBox: Boolean;
    FCheckBoxType: TElCheckBoxType;
    FImageIndex2: integer;
    FStImageIndex2: integer;
    FEnabled: boolean;
    FHidden: boolean;

    FMultiline    : boolean;
    FOwnerHeight  : boolean;
    FHeight       : Cardinal;
    FSuppressLines: boolean;

    FIsHTML   : boolean;

  end;

  PStyleInfo = ^TStyleInfo;
  TStyleInfo = record
    FCellBkColor: TColor;
    FTextBkColor: TColor;
    FTextColor: TColor;
    FTextFlags: DWORD;
    FPicture: TBitmap;
    FCellType: TElFieldType;
    FStyle: TElSectionStyle;
    FOwnerProps: Boolean;
    FUseBkColor: boolean;
    FFontSize: integer;
    FFontStyles: TFontStyles;
    FTag: integer;
    end;

(*
procedure StateSetToStateInt(FState : TSTIStates; var FIState : Integer);
begin
  FIState := 0;

  if stsCut in FState then
    FIState := FIState or tisCut
  else
    FIState := FIState and (not tisCut);

  if stsBold in FState then
    FIState := FIState or tisBold
  else
    FIState := FIState and (not tisBold);

  if stsItalic in FState then
    FIState := FIState or tisItalic
  else
    FIState := FIState and (not tisItalic);

  if stsUnderlined in FState then
    FIState := FIState or tisUnderlined
  else
    FIState := FIState and (not tisUnderlined);

  if stsStrikeOut in FState then
    FIState := FIState or tisStrikeOut
  else
    FIState := FIState and (not tisStrikeOut);
end;
*)

procedure TElTreeItem.ReadData(Stream: TStream);
var
  i, j, k: integer;
  s : AnsiString;
  t28  : TS28ItemInfo;
  t28a : TS28aItemInfo;
  PInfo: TItemPersistInfo;
  ver  : integer;
  SI   : TStyleInfo;
  Style: TElCellStyle;
  {$ifdef LMD_UNICODE}
  WS   : WideString;
  {$endif}
  b, b1: boolean;
  Child: TElTreeItem;
  begin
  Stream.ReadBuffer(k, SizeOf(k));
  Ver := 0;
  if k < 0 then
  begin
    ver := k;
    if ver < -13 then
    begin
    {$ifdef LMD_UNICODE}
    LMDWideReadStringFromStream(Stream, WS);
//    S := WS; EK
    {$else}
    LMDAnsiReadStringFromStream(Stream, S);
    {$endif}
    end
    else
    begin
      Stream.ReadBuffer(k, SizeOf(k));
      SetLength(s, k);
      {$IFNDEF LMDCOMP12}
      Stream.ReadBuffer(pchar(s)^, k);
      {$ELSE}
      Stream.ReadBuffer(PAnsiChar(s)^, k);
      {$ENDIF}

      {$ifdef LMD_UNICODE}
      WS := WideString(S);
      {$endif}
    end;
  end
  else
  begin
    SetLength(s, k);
    {$IFNDEF LMDCOMP12}
    Stream.ReadBuffer(pchar(s)^, k);
    {$ELSE}
    Stream.ReadBuffer(PAnsiChar(s)^, k);
    {$ENDIF}
    end;
  if FStaticData <> nil then
  {$ifdef LMD_UNICODE}
    FStaticData.FText := WS;
  {$else}
    FStaticData.FText := s;
  {$endif}
  if

    (Ver = -7) or

    (Ver = -8) or
    (Ver = -9) then
  begin
    Stream.ReadBuffer(T28, SizeOf(T28));
    Stream.ReadBuffer(b, SizeOf(b));

    if FStaticDataEx <> nil then
    with FStaticDataEx do
    begin
      if b then
        FBoolData1 := FBoolData1 or ibfUseBkColor
      else
        FBoolData1 := FBoolData1 and not ibfUseBkColor;

      FState := T28.FState;
      // StateSetToStateInt(State, FIState);

      Color := T28.FColor;
      BkColor := T28.FBkColor;
      ImageIndex := T28.FImageIndex;
      StImageIndex := T28.FStImageIndex;

      if T28.FParentColors then
        FBoolData1 := FBoolData1 or ibfParentColors
      else
        FBoolData1 := FBoolData1 and not ibfParentColors;
      if T28.FParentStyle then
        FBoolData1 := FBoolData1 or ibfParentStyle
      else
        FBoolData1 := FBoolData1 and not ibfParentStyle;
      if T28.ForceButtons then
        FBoolData1 := FBoolData1 or ibfForceButtons
      else
        FBoolData1 := FBoolData1 and not ibfForceButtons;
      if T28.FCheckBoxEnabled then
        FBoolData1 := FBoolData1 or ibfCheckBoxEnabled
      else
        FBoolData1 := FBoolData1 and not ibfCheckBoxEnabled;
      if T28.FShowCheckBox then
        FBoolData1 := FBoolData1 or ibfShowCheckBox
      else
        FBoolData1 := FBoolData1 and not ibfShowCheckBox;

      CheckBoxState := T28.FCheckBoxState;
      CheckBoxType := T28.FCheckBoxType;
      ImageIndex2 := T28.FImageIndex2;
      StImageIndex2 := T28.FStImageIndex2;

      if T28.FSuppressLines then
        FBoolData1 := FBoolData1 or ibfSuppressLines
      else
        FBoolData1 := FBoolData1 and not ibfSuppressLines;
      IsHTML       := T28.FIsHTML;
  end;

    FBoolData := PInfo.FBoolData1 and (ibfMultiline or ibfHidden or ibfOwnerHeight or ibfIsHTML);
    if T28.FEnabled then
      FBoolData := FBoolData or ibfEnabled
    else
      FBoolData := FBoolData and not ibfEnabled;

    if stsExpanded in T28.FState then
      FBoolData := FBoolData or ibfExpanded
    else
      FBoolData := FBoolData and not ibfExpanded;

    if T28.FHidden then
      Self.FBoolData := FBoolData or ibfHidden
    else
      Self.FBoolData := FBoolData and not ibfHidden;

    if T28.FMultiline then
      Self.FBoolData := FBoolData or ibfMultiline
    else
      FBoolData := FBoolData and not ibfMultiline;
    if T28.FOwnerHeight then
      FBoolData := FBoolData or ibfOwnerHeight
    else
      FBoolData := FBoolData and not ibfOwnerHeight;

    FComplexHeight:= T28.FHeight shl 16 or (FComplexHeight and $0000FFFF);

  end
  else
  if Ver = -10 then
  begin
    Stream.ReadBuffer(T28a, SizeOf(T28a));
    Stream.ReadBuffer(b, SizeOf(b));

    if FStaticDataEx <> nil then
    with FStaticDataEx do
    begin
      if b then
        FBoolData1 := FBoolData1 or ibfUseBkColor
      else
        FBoolData1 := FBoolData1 and not ibfUseBkColor;

      FState := T28a.FState;
      // StateSetToStateInt(FState, FIState);

      FColor := T28a.FColor;
      FBkColor := T28a.FBkColor;
      FRowBkColor := T28a.FRowBkColor;
      FImageIndex := T28a.FImageIndex;
      FStImageIndex := T28a.FStImageIndex;

      FCheckBoxState := T28a.FCheckBoxState;
      FCheckBoxType := T28a.FCheckBoxType;

      if T28a.FParentColors then
        FBoolData1 := FBoolData1 or ibfParentColors
      else
        FBoolData1 := FBoolData1 and not ibfParentColors;
      if T28a.FParentStyle then
        FBoolData1 := FBoolData1 or ibfParentStyle
      else
        FBoolData1 := FBoolData1 and not ibfParentStyle;
      if T28a.ForceButtons then
        FBoolData1 := FBoolData1 or ibfForceButtons
      else
        FBoolData1 := FBoolData1 and not ibfForceButtons;
      if T28a.FCheckBoxEnabled then
        FBoolData1 := FBoolData1 or ibfCheckBoxEnabled
      else
        FBoolData1 := FBoolData1 and not ibfCheckBoxEnabled;
      if T28a.FShowCheckBox then
        FBoolData1 := FBoolData1 or ibfShowCheckBox
      else
        FBoolData1 := FBoolData1 and not ibfShowCheckBox;
      if T28a.FSuppressLines then
        FBoolData1 := FBoolData1 or ibfSuppressLines
      else
        FBoolData1 := FBoolData1 and not ibfSuppressLines;
      IsHTML       := T28a.FIsHTML;
  end;

    FBoolData := PInfo.FBoolData1 and (ibfMultiline or ibfHidden or ibfOwnerHeight or ibfIsHTML);
    if T28a.FEnabled then
      FBoolData := FBoolData or ibfEnabled
    else
      FBoolData := FBoolData and not ibfEnabled;

    if stsExpanded in T28a.FState then
      FBoolData := FBoolData or ibfExpanded
    else
      FBoolData := FBoolData and not ibfExpanded;

    if T28a.FHidden then
      FBoolData := FBoolData or ibfHidden
    else
      FBoolData := FBoolData and not ibfHidden;
  if T28a.FMultiline then
      FBoolData := FBoolData or ibfMultiline
    else
      FBoolData := FBoolData and not ibfMultiline;

    if T28a.FOwnerHeight then
      FBoolData := FBoolData or ibfOwnerHeight
    else
      FBoolData := FBoolData and not ibfOwnerHeight;

    FComplexHeight:= T28a.FHeight shl 16 or (FComplexHeight and $0000FFFF);
  end
  else
  if Ver <= -11 then
  begin
    Stream.ReadBuffer(PInfo, SizeOf(TItemPersistInfo));
    if FStaticDataEx <> nil then
    with FStaticDataEx do
    begin
      FState := PInfo.FState;
      //StateSetToStateInt(FState, FIState);

      FImageIndex   := PInfo.FImageIndex;
      FStImageIndex := PInfo.FStImageIndex;
      FImageIndex2  := PInfo.FImageIndex2;
      FStImageIndex2:= PInfo.FStImageIndex2;
      FColor        := PInfo.FColor;
      FRowBkColor   := PInfo.FRowBkColor;
      FBkColor      := PInfo.FBkColor;
      FCheckBoxState:= PInfo.FCheckBoxState;
      FCheckBoxType := PInfo.FCheckBoxType;
      FBorderStyle  := PInfo.FBorderStyle;
      FIndentAdjust := PInfo.FIndentAdjust;
      FStrikedLineColor:= PInfo.FStrikedLineColor;
      FBoolData1    := PInfo.FBoolData1 and not (ibfMultiline or ibfHidden or ibfOwnerHeight or ibfSelected or ibfFocused or ibfEnabled or ibfIsHTML or ibfWordWrap or ibfWholeLine);
    end;

    FTag      := PInfo.FTag;
    FBoolData := PInfo.FBoolData1 and (ibfMultiline or ibfHidden or ibfOwnerHeight or ibfEnabled or ibfIsHTML or ibfWordWrap or ibfWholeLine);
    if stsExpanded in PInfo.FState then
      FBoolData := FBoolData or ibfExpanded
    else
      FBoolData := FBoolData and not ibfExpanded;

    if FParent = nil then
      FBoolData := FBoolData or ibfExpanded or ibfEnabled;

    FComplexHeight:= PInfo.FHeight shl 16 or (FComplexHeight and $0000FFFF);

  if IsHTML then
    begin
      FBoolData := FBoolData and not ibfIsHTML;
      IsHTML := true;
    end;
  if Ver = -13 then
    FBoolData := FBoolData and not ibfWholeLine;
  if Ver <= -13 then
    begin
      if FStaticDataEx <> nil then
      with FStaticDataEx do
      begin
        FOverlayIndex := PInfo.FOverlayImage and $0000FFFF;
        FOVerlayIndex2 := (PInfo.FOverlayImage and $FFFF0000) shr 16;
      end;
    end;
  end;

  if (not OwnerHeight) or IsHTML then
    inc(Owner.TotalVarHeightCount);

  Stream.ReadBuffer(i, SizeOf(i));
  if i = -1 then
  begin
    {$ifdef LMD_UNICODE}
    if Ver <= -12 then
    begin
      LMDWideReadStringFromStream(Stream, WS);
      if FStaticData <> nil then
        FStaticData.FHint := WS;
    end
    else
    {$endif}
    begin
      LMDAnsiReadStringFromStream(Stream, s);
      if FStaticData <> nil then
        FStaticData.FHint := TLMDString(s);
    end;
    Stream.ReadBuffer(i, SizeOf(i));
  end;
  for j := 0 to i - 1 do
  begin
    {$ifdef LMD_UNICODE}
    if Ver < -13 then
    begin
      LMDWideReadStringFromStream(Stream, WS);
      if FStaticData <> nil then
        FStaticData.FColText.Add(WS);
    end
    else
    {$endif}
    begin
      Stream.ReadBuffer(k, SizeOf(k));
      SetLength(s, k);
      {$IFNDEF LMDCOMP12}
      Stream.ReadBuffer(pchar(s)^, k);
      {$ELSE}
      Stream.ReadBuffer(PAnsiChar(s)^, k);
      {$ENDIF}
      if FStaticData <> nil then
        FStaticData.FColText.Add(String(s));
    end;
  end;
  if Ver < 0 then
  begin
    Stream.ReadBuffer(b1, sizeof(b1));
    if FStaticDataEx <> nil then
    with FStaticDataEx do
    begin
      if b1 then
        FBoolData1 := FBoolData1 or ibfUseStyles
      else
        FBoolData1 := FBoolData1 and not ibfUseStyles;
    end;

    if b1 then
    begin
      if Ver < -1 then
        Stream.ReadBuffer(b, sizeof(boolean))
      else
        b := false;

      if b then
      begin
        if Assigned(FOwner.FOnLoad) then FOwner.FOnLoad(Self, Stream, MainStyle);
      end
      else
      begin
        if Assigned(MainStyle) then
        with MainStyle do
        begin
          Stream.ReadBuffer(SI, sizeof(TStyleInfo));
          LMDAnsiReadStringFromStream(Stream, s);
          MainStyle.FFontName := String(s);
          FCellBkColor := SI.FCellBkColor;
          FTextBkColor := SI.FTextBkColor;
          FTextColor := SI.FTextColor;
          FTextFlags := SI.FTextFlags;
          FPicture := SI.FPicture;
          FCellType := SI.FCellType;
          FStyle := SI.FStyle;
          FOwnerProps := SI.FOwnerProps;
          FFontSize := SI.FFontSize;
          FFontStyles := SI.FFontStyles;
          FTag := SI.FTag;
          FUseBkColor := SI.FUseBkColor;
        end;
      end;
      if FStaticData <> nil then
      begin
      Stream.ReadBuffer(i, SizeOf(i));
      for j := 1 to i do
      begin
        Style := AddStyle;
        if b then
        begin
            if Assigned(FOwner.FOnLoad) then 
              FOwner.FOnLoad(Self, Stream, Style);
          end 
        else
        begin
          Stream.ReadBuffer(SI, sizeof(TStyleInfo));
          with Style do
          begin
            FCellBkColor := SI.FCellBkColor;
            FTextBkColor := SI.FTextBkColor;
            FTextColor := SI.FTextColor;
            FTextFlags := SI.FTextFlags;
            FPicture := SI.FPicture;
            FCellType := SI.FCellType;
            FStyle := SI.FStyle;
            FOwnerProps := SI.FOwnerProps;
            FFontSize := SI.FFontSize;
            FFontStyles := SI.FFontStyles;
            FTag := SI.FTag;
            FUseBkColor := SI.FUseBkColor;
          end;
          LMDAnsiReadStringFromStream(Stream, s);
          Style.FFontName := String(s);
        end;
      end; // for
    end; //if FStaticData <> nil
  end;
  end;
  FOwner.TriggerItemLoadEvent(Stream, Self);

  Stream.ReadBuffer(i, SizeOf(i));
  for j := 0 to i - 1 do
  begin
    Child := FList.AddItem(self);
    Child.ReadData(Stream);
  end;
end;

procedure TElTreeItem.WriteData(Stream: TStream);
var
  i, j, k: integer;
  s: TLMDString;
  PInfo : TItemPersistInfo;
  // p: pchar;
  SI: TStyleInfo;
  Style: TElCellStyle;
  b: boolean;
begin
  // write version
  k := -14;
  Stream.WriteBuffer(k, SizeOf(k));
  // write text data
  s := '';
  if FStaticData <> nil then
    s := FStaticData.FText;
  //k := length(s);
  {$ifdef LMD_UNICODE}
  LMDWideWriteStringtoStream(Stream, S);
  {$else}
  LMDAnsiWriteStringtoStream(Stream, S);
  {$endif}
  // write binary data
  FillMemory(@PInfo, sizeof(PInfo), 0);
  PInfo.FBoolData1 := FBoolData;
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    PInfo.FState := FState;
    if FBoolData and ibfExpanded = ibfExpanded then
      PInfo.FState := PInfo.FState + [stsExpanded];
    PInfo.FBoolData1 := PInfo.FBoolData1 or FBoolData1;
    PInfo.FImageIndex := FImageIndex;
    PInfo.FImageIndex2 := FImageIndex2;
    PInfo.FStImageIndex := FStImageIndex;
    PInfo.FStImageIndex2 := FStImageIndex2;
    PInfo.FColor := FColor;
    PInfo.FBkColor := FBkColor;
    PInfo.FRowBkColor := FRowBkColor;

    PInfo.FCheckBoxState := FCheckBoxState;
    PInfo.FCheckBoxType := FCheckBoxType;
    PInfo.FBorderStyle := FBorderStyle;
    PInfo.FIndentAdjust := FIndentAdjust;
    PInfo.FStrikedLineColor := FStrikedLineColor;
    PInfo.FOverlayImage := FOverlayIndex or (FOverlayIndex2 shl 16);
  end;
  PInfo.FTag := FTag;

  PInfo.FHeight := FComplexHeight shr 16;
  Stream.WriteBuffer(PInfo, SizeOf(PInfo));
  // write SubStrings
  i := -1;
  Stream.WriteBuffer(i, SizeOf(i));

  if FStaticData <> nil then
    s := FStaticData.FHint
  else
    S := '';
  {$ifdef LMD_UNICODE}
  LMDWideWriteStringtoStream(Stream, S);
  {$else}
  LMDAnsiWriteStringToStream(Stream, S);
  {$endif}

  if FStaticData <> nil then
    i := FStaticData.FColText.Count
  else
    i := 0;
  Stream.WriteBuffer(i, SizeOf(i));
  for j := 0 to i - 1 do
  begin
    if FStaticData <> nil then
      s := FStaticData.FColText[j]
    else
      s := '';
    {$ifdef LMD_UNICODE}
    LMDWideWriteStringtoStream(Stream, S);
    {$else}
    LMDAnsiWriteStringtoStream(Stream, S);
    {$endif}

  end;
  if  FStaticDataEx <> nil then
    b := (FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles
  else
    b := false;
  Stream.WriteBuffer(b, sizeof(b));
  if b then
  begin
    b := Assigned(FOwner.FOnSave);
    Stream.WriteBuffer(b, sizeof(boolean));
    if FStaticData <> nil then
    begin
      if FStaticData.FStyles = nil then
        i := 0
      else
        i := FStaticData.FStyles.Count;
      for j := 0 to i do
      begin
        if j = 0 then
          Style := MainStyle
        else
          Style := TElCellStyle(FStaticData.FStyles[j - 1]);
        if b then
          FOwner.FOnSave(Self, Stream, Style)
        else
        begin
          with Style do
          begin
            SI.FCellBkColor := FCellBkColor;
            SI.FTextBkColor := FTextBkColor;
            SI.FTextColor := FTextColor;
            SI.FTextFlags := FTextFlags;
            SI.FPicture := FPicture;
            SI.FCellType := FCellType;
            SI.FStyle := FStyle;
            SI.FOwnerProps := FOwnerProps;
            SI.FFontSize := FFontSize;
            SI.FFontStyles := FFontStyles;
            SI.FTag := FTag;
            SI.FUseBkColor := FUseBkColor;
          end;
          Stream.WriteBuffer(SI, sizeof(TStyleInfo));
          LMDAnsiWriteStringToStream(Stream, AnsiString(Style.FFontName));
        end;
        if j = 0 then
          Stream.WriteBuffer(i, sizeof(i));
      end;
    end;
  end;
  FOwner.TriggerItemSaveEvent(Stream, Self);
  // write subitems
  if FChildren = nil then i := 0 else i := FChildren.Count;
  Stream.WriteBuffer(i, SizeOf(i));
  for j := 0 to i - 1 do
    TElTreeItem(FChildren.List[j]).WriteData(Stream);
    end;

procedure TElTreeItem.Assign(Source: TPersistent);
var
  Item, Child: TElTreeItem;
  i, j : integer;
  Style: TElCellStyle;
begin
  if Source is TElTreeItem then
  begin
    if FOwner <> nil then
      FOwner.IsUpdating := true;
    Item := TElTreeItem(Source);
    if (FStaticData <> nil) then
    begin
      FStaticData.FText := Item.Text;
      if Item.ColumnText <> nil then
        FStaticData.FColText.Assign(Item.ColumnText);
      FStaticData.FHint := Item.Hint;
    end;
    Data := Item.Data;
    if (FStaticDataEx <> nil) and (Item.FStaticDataEx <> nil) then
    with FStaticDataEx do
    begin
      FBoolData1 := Item.FStaticDataEx.FBoolData1;
      FColor := Item.FStaticDataEx.FColor;
      FBkColor := Item.FStaticDataEx.FBkColor;
      FRowBkColor := Item.FStaticDataEx.FRowBkColor;
      FImageIndex := Item.FStaticDataEx.FImageIndex;
      FStImageIndex := Item.FStaticDataEx.FStImageIndex;
      FImageIndex2 := Item.FStaticDataEx.FImageIndex2;
      FStImageIndex2 := Item.FStaticDataEx.FStImageIndex2;
      FCheckBoxState := Item.FStaticDataEx.FCheckBoxState;
      FCheckBoxType := Item.FStaticDataEx.FCheckBoxType;
      FBorderStyle := Item.FStaticDataEx.FBorderStyle;
      FIndentAdjust := Item.FStaticDataEx.FIndentAdjust;
      FStrikedLineColor := Item.FStaticDataEx.FStrikedLineColor;
      FOverlayIndex := Item.FStaticDataEx.FOverlayIndex;
      FOverlayIndex2 := Item.FStaticDataEx.FOverlayIndex2;
      FState := Item.FStaticDataEx.FState;
    end;
    FBoolData := Item.FBoolData and not (ibfFocused or ibfSelected or ibfIsHTML or ibfImageDrawn or ibfImageDrawn2);

    if ((FBoolData and ibfOwnerHeight) <> ibfOwnerHeight) then
      Inc(FOwner.TotalVarHeightCount);

    IsHTML := Item.IsHTML;
    FComplexHeight := Item.FComplexHeight;
    FObject := Item.FObject;
    FDataInterface := Item.FDataInterface;
    FTag := Item.FTag;
    if (FStaticData <> nil) and (Item.FStaticData <> nil) then
    begin
      FStaticData.FMainStyle.Assign(Item.MainStyle);
      if FStaticData.FStyles <> nil then
        FStaticData.FStyles.Clear;
      if Item.FStaticData.FStyles <> nil then
      begin
        if FStaticData.FStyles = nil then
          CreateStyles;
        for i := 0 to Item.FStaticData.FStyles.Count - 1 do
        begin
          Style := AddStyle;
          Style.Assign(Item.Styles[i]);
        end;
      end;
    end;
    Clear;
    if Item.FChildren <> nil then
    begin
      if FChildren = nil then
        FChildren := TLMDObjectList.Create;
      j := 0;
      for i := 0 to Item.FChildren.Count - 1 do
      begin
        Child := FList.CreateItem(FOwner);
        if FOwner.VirtualityLevel = vlNone then
          Child.NewStaticData;
        if (FOwner.VirtualityLevel < vlAllProps) or (csDesigning in FOwner.ComponentState) then
          Child.NewStaticDataEx;

        if FOwner.FAllList.Count > 0 then
           j := FOwner.FAllList.IndexOfFrom(j, GetLastSubItem) + 1
        else
           j := 0;
        FChildren.Add(Child);
        FOwner.FAllList.Insert(j, Child);
        Child.FRoot := FRoot;
        Child.FList := FList;
        Child.FParent := self;
        Child.FOwner := FOwner;
        Child.Assign(TElTreeItem(Item.FChildren.List[i]));
        end;
    end
    else
      FreeAndNil(FChildren);

    if (FOwner <> nil) then
    with FOwner.FView do
    begin
      FOwner.FUpdated := true;
      FVisUpdated := true;
      FClearVis := true;
      FClearAll := true;
      FOwner.IsUpdating := false;
    end;
  end
  else
    inherited Assign(Source);
end;

procedure TElTreeItem.SetUseBkColor(newValue: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
    if ((FBoolData1 and ibfUseBkColor) = ibfUseBkColor) <> newValue then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfUseBkColor
      else
        FBoolData1 := FBoolData1 and not ibfUseBkColor;
      UpdateItem;
    end;
end;

procedure TElTreeItem.SetColor(Index: Integer; value: TColor);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  case index of
    1:
      begin
        if FColor = value then exit;
        FColor := value;
        if not ParentColors then
          UpdateItem;
      end;
    2:
      begin
        if FBkColor = value then exit;
        FBkColor := value;
        if (not ParentColors) and UseBkColor then
          UpdateItem;
      end;
    3:
      begin
        if FRowBkColor = value then exit;
        FRowBkColor := value;
        if (not ParentColors) and UseBkColor then
          UpdateItem;
      end;
    4:
      begin
        FBorderSpaceColor := Value;
        if BorderStyle = ibsSpace then
          UpdateItem;
      end;
    5:
      begin
        FStrikedLineColor := Value;
        if StrikedOutline then
          UpdateItem;
      end;
  end;
end;

function TElTreeItem.GetParent;
begin
  if FParent = FRoot then
    result := nil
  else
    result := FParent;
end;

procedure TElTreeItem.EditText;
begin
  FOwner.FView.DoEditItem(self, -1);
end;

function TElTreeItem.GetFullNameEx;
begin
  if (FParent <> FRoot) or (AddRoot) then
    if Separator <> #0 then
      result := separator + Text
    else
      result := Text
  else
    result := Text;
  if FParent <> FRoot then
    result := FParent.GetFullNameEx(separator, AddRoot) + result;
end;

function TElTreeItem.GetFullName;
begin
  if Separator <> #0 then
    result := separator + Text
  else
    result := Text;
  if FParent <> FRoot then
    result := FParent.GetFullName(separator) + result;
end;

function TElTreeItem.GetChildByIndex;
begin
  if (index < 0) or (FChildren = nil) or (index >= FChildren.Count) then
    raise EElTreeError.Create(STExOutOfBounds);
  result := TElTreeItem(FChildren.List[index]);
end;

function TElTreeItem.GetChildrenCount;
var
  i, j: integer;
begin
  if FChildren = nil then
     Result := 0
  else
     Result := FChildren.Count;
  j := result;
  for i := 0 to j - 1 do
    result := result + TElTreeItem(FChildren.List[i]).ChildrenCount;
end;

function TElTreeItem.GetNextChild;
var
  i: integer;
begin
  if FChildren = nil then
     result := nil
  else
  begin
    i := Child.Index;
    if (i = (FChildren.Count - 1)) then
       result := nil
    else
       result := TElTreeItem(FChildren.List[i + 1]);
  end;
end;

function TElTreeItem.GetPrevChild;
var
  i: integer;
begin
  if FChildren = nil then
     result := nil
  else
  begin
    i := Child.Index;
    if i = 0 then
       result := nil
    else
      result := TElTreeItem(FChildren.List[i - 1]);
  end;
end;

function TElTreeItem.GetFirstVisibleChild;
var
  i: integer;
  ChC : integer;
  Item: TElTreeItem;
begin
  result := nil;
  if (not FOwner.FilteredVisibility) then
  begin
    result := GetFirstChild;
    exit;
  end;
  if (FChildren <> nil) then
  begin
    Chc := FChildren.Count;
    if (Chc > 0) then
    for i := 0 to ChC - 1 do
    begin
      Item := TElTreeItem(FChildren.List[i]);
      if not Item.Hidden then
      begin
        result := Item;
        exit;
      end;
    end;
  end;
end;

function TElTreeItem.GetFirstChild;
begin
  if (FChildren = nil) or (FChildren.Count = 0) then
     result := nil
  else
     result := TElTreeItem(FChildren.List[0]);
end;

function TElTreeItem.GetLastChild;
begin
  if (FChildren = nil) or (FChildren.Count = 0) then
     result := nil
  else
     result := TElTreeItem(FChildren.Last);
end;

function TElTreeItem.GetFirstSibling;
begin
  if FParent = nil then
     result := nil
  else
     result := FParent.GetFirstChild;
end;

function TElTreeItem.GetLastSibling;
begin
  if FParent = nil then
     result := nil
  else
     result := FParent.GetLastChild;
end;

function TElTreeItem.GetNextSibling;
begin
  if FParent = nil then
     result := nil
  else
     result := FParent.GetNextChild(self);
end;

function TElTreeItem.GetPrevSibling;
begin
  if FParent = nil then
     result := nil
  else
    result := FParent.GetPrevChild(self);
end;

function TElTreeItem.GetFullExpand;
begin
  if Parent = nil then
     result := Expanded or not HasChildren
  else
     result := Parent.FullyExpanded and (Expanded or not HasChildren);
end;

function TElTreeItem.GetSelected : boolean;
begin
  result := (FBoolData and ibfSelected) = ibfSelected;
end;

procedure TElTreeItem.SetSelected(newValue : boolean);
var b : boolean;
begin
   if FOwner.FMultiSelect then
   begin
     b := ((FBoolData and ibfSelected) = ibfSelected) xor newValue;
     if b then
     begin
       if newValue = false then
       begin
         FOwner.FSelChange := true;
         //Exclude(FState, stsSelected);
         FBoolData := FBoolData and (not ibfSelected);
         FOwner.FSelectedList.Remove(Self);
         with FOwner.FView do
         if FSelected = Self then
           FSelected := nil;
       end
       else
       begin
         if FOwner.FKeepSelectionWithinLevel and (FOwner.FSelectedList.Count > 0) and
            (FOwner.FSelectedList[0] <> Self) then
         begin
           if Level <> TElTreeItem(FOwner.FSelectedList[0]).Level then
             exit;
         end;
         FOwner.FSelChange := true;
         // Include(FState, stsSelected);
         FBoolData := FBoolData or ibfSelected;
         FOwner.FSelectedList.Add(Self);
       end;
       FOwner.TriggerItemSelectedChangeEvent(Self);
       UpdateItem;
     end;
   end;
end;

procedure TElTreeItem.SetState;
var
  FOldState: TSTIStates;
  reqitemch: boolean;
begin
  reqitemch := true;
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    FOldState := FState;
    case index of
      stsCut:
        begin
          if value = false then Exclude(FState, stsCut)
          else Include(FState, stsCut);
        end;
      stsUnderlined:
        begin
          if value = false then Exclude(FState, stsUnderlined)
          else Include(FState, stsUnderlined);
        end;
      stsBold:
        begin
          if value = false then Exclude(FState, stsBold)
          else Include(FState, stsBold);
        end;
      stsItalic:
        begin
          if value = false then Exclude(FState, stsItalic)
          else Include(FState, stsItalic);
        end;
      stsStrikeOut:
        begin
          if value = false then Exclude(FState, stsStrikeOut)
          else Include(FState, stsStrikeOut);
        end;
    end; // case
    if FOldState <> FState then
    begin
      if (index in [stsBold, stsItalic]) and (not FOwner.FShowHeader) and FullyExpanded then
      begin
        if FOwner.FUpdateCount > 0 then
          FOwner.FView.FHRange := -1
        else
          FOwner.FView.DefineHRange;
      end;
      if reqitemch then FOwner.DoItemChange(self, icmState);
      UpdateItem;
    end;
  end;
end;

function TElTreeItem.GetState;
begin
  if FStaticDataEx <> nil then
    result := index in FStaticDataEx.FState
  else
    result := false;
end;

function TElTreeItem.IsExpanded;
begin
  result := (FBoolData and ibfExpanded) <> 0;
end;

procedure TElTreeItem.Expand;
var
  i,
  j: integer;
  b: boolean;

begin
  b := true;
  if Self <> FRoot then
    FOwner.DoItemExpanding(self, b);
  if not (b) then exit;
  FOwner.IsUpdating := true;
  with FOwner.FView do
  begin
    FVisUpdated := true;
    FRangeUpdate := true;
  end;
  FBoolData := FBoolData or ibfExpanded;
  if Assigned(FStaticDataEx) then
    Include(FStaticDataEx.FState, stsExpanded);
  if recursive then
  begin
    if (FChildren = nil) then
       j := 0
    else
       j := FChildren.Count;
    for i := 0 to j - 1 do
        TElTreeItem(FChildren.List[i]).expand(true);
  end;
  if (not FOwner.FShowHeader) and FullyExpanded then
    FOwner.FView.FHRange := -1;
  with FOwner.FView do
  begin
    FClearVis := true;
    FOwner.FUpdated := true;
  end;
  FOwner.IsUpdating := false;
  //Adjusting the width of the tree column to the width of the tree
  if FOwner.FHeader.Sections[FOwner.FMainTreeCol] <> nil then
    Fowner.AutoSizeColumn(FOwner.FMainTreeCol);

  if Self <> FRoot then FOwner.DoItemExpand(self);
end;

procedure TElTreeItem.IterateProc(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
  IterateData: TLMDDataTag; Tree: TCustomElTree);
begin
  if not Item.IsUnder(TElTreeItem(IterateData)) then
  begin
    ContinueIterate := false;
    exit;
  end;
  ContinueIterate := true;
  if Item <> IterateData then Item.Selected := false;
end;

procedure TElTreeItem.Collapse;
var
  i : integer;
  b : boolean;
  AnItem : TElTreeItem;
begin
  b := true;
  if Self <> FRoot then FOwner.DoItemCollapsing(self, b);
  if not (b) then exit;
  FOwner.IsUpdating := true;
  with FOwner.FView do
  begin
    FRangeUpdate := true;
    FVisUpdated := true;
  end;
  FBoolData := FBoolData and not ibfExpanded;
  if Assigned(FStaticDataEx) then
    Exclude(FStaticDataEx.FState, stsExpanded);
  with FOwner do
    if (ItemFocused <> nil) and (ItemFocused <> Self) and (ItemFocused.IsUnder(Self)) and (FMoveFocusOnCollapse) then
    begin
      if SelectedCount = 1 then
      begin
        AnItem := ItemFocused;
        b := FAutoExpand;
        FAutoExpand := false;
        ItemFocused := Self;
        FAutoExpand := b;
        AnItem.Selected := false;
      end
      else
        ItemFocused := Self;
    end;
  if Recursive then
  begin
    if Assigned(FChildren) then
      for i := 0 to Pred(FChildren.Count) do
        TElTreeItem(FChildren.List[i]).Collapse(True);
  end;

  if FOwner.FDeselectChildrenOnCollapse then
    FOwner.Items.IterateFrom(false, true, IterateProc, Self, Self); (*<+>*)

  if (not FOwner.FShowHeader) and FullyExpanded then
     FOwner.FView.FHRange := -1;
  with FOwner.FView do
  begin
    FClearVis := true;
    FClearAll := true;
  end;
  FOwner.FUpdated := true;
  FOwner.IsUpdating := false;
  //Adjusting the width of the tree column to the width of the tree
  if FOwner.FHeader.Sections[FOwner.FMainTreeCol] <> nil then
    Fowner.AutoSizeColumn(FOwner.FMainTreeCol);

  if Self <> FRoot then FOwner.DoItemCollapse(self);
end;

function TElTreeItem.GetChildIndex;
begin
  if FChildren = nil then
     result := -1
  else
     result := FChildren.IndexOf(Child);
end;

function TElTreeItem.GetIndex: Integer;
begin
  if FParent = nil then
     result := -1
  else
     result := FParent.GetChildIndex(self);
end;

function TElTreeItem.GetVisIndex;
begin
  // no check for root - should never be called for root
  result := FList.GetVisIndex(self);
end;

function TElTreeItem.GetAbsIndex;
begin
  // no check for root - should never be called for root
  result := FList.GetAbsIndex(self);
end;

procedure TElTreeItem.RemoveChild;
var
  i: integer;
begin
  with FOwner.FView do
  begin
    i := FVisible.IndexOf(Child);
    if i >= 0 then
       FVisible.Delete(i);
  end;

  {with FOwner.FView do
    if FSelected = Child then FSelected := nil;
  }

  if FChildren <> nil then
  begin
    i := FChildren.IndexOf(Child);
    if i <> -1 then
       FChildren.Delete(i);
    if FChildren.Count = 0 then
      FreeAndNil(FChildren);
    //dec(FList.FCount);
  end;
end;

procedure TElTreeItem.RemoveSubChild;
var
  i: integer;
  DataEx : TElTreeItemStaticDataEx;
begin
//  Child.FBoolData1 := Child.FBoolData1 or ibfDeleting;
  FOwner.IsUpdating := true;
  Child.ClearSubChild;
  if Child.Hidden then
  begin
    dec(FOwner.TotalHiddenCount);
    Child.FBoolData := Child.FBoolData and not ibfHidden;
  end;
  if Child = FOwner.FView.FSelected then
  begin
    if csDestroying in FOwner.ComponentState then
      FOwner.SetSelected(nil)
    else
    begin
      FOwner.SetSelected(GetNextChild(Child));
      if FOwner.FView.FSelected = nil then
        FOwner.SetSelected(GetPrevChild(Child));
      if FOwner.FView.FSelected = nil then
        if Self <> FRoot then
          FOwner.SetSelected(Self);
    end;
  end;
  Child.Selected := false;
  // Move focus, if needed
  if Child = FOwner.FView.FFocused then
  begin
    if csDestroying in FOwner.ComponentState then
      FOwner.DoSetFocused(nil, true)
    else
    begin
      FOwner.DoSetFocused(GetNextChild(Child), true);
      if FOwner.ItemFocused = nil then
        FOwner.DoSetFocused(GetPrevChild(Child), true);
      if FOwner.ItemFocused = nil then
        if Self <> FRoot then
          FOwner.DoSetFocused(Self, true);
    end;
  end;
  with FOwner do
    if (FUpdateCount = 0) and (FilteredVisibility) then
       UpdateDiffItems;
  with FOwner.FView do
  begin

    if FItemToEdit = Child then
       FItemToEdit := nil;

    if FPassedItem = Child then
       FPassedItem := nil;
    if FTrackItem = Child then
       FTrackItem := nil;

    if FOwner.IsEditing then
    begin
      FEditingItem := nil;
      DoEndEdit(true);
    end;

  end;
  if (FOwner.FView.FVisible.Count > 0) and not (csDestroying in FOwner.ComponentState) then
  with FOwner.FView do
  begin
    i := FVisible.IndexOfBack(FVisible.Count - 1, Child);
    if (i >= 0) then
       FVisible.Delete(i);
  end;
  FOwner.DoItemDelete(Child);

  if (not Child.OwnerHeight) or (Child.Multiline and FOwner.FAdjustMultilineHeight) then
    dec(FOwner.TotalVarHeightCount);

  if (Child.FBoolData and ibfIsHTML) = ibfIsHTML then
     dec(FOwner.TotalVarHeightCount);

  Child.ClearSubChild;
  i := FOwner.FAllList.IndexOfBack(FOwner.FAllList.Count - 1, Child);
  if (i >= 0) then
    FOwner.FAllList.Delete(i);

  if (FOwner.VirtualityLevel >= vlAllProps) and (not (csDesigning in FOwner.ComponentState)) then
  begin
    if Child.FStaticDataEx <> nil then
    begin
      // move static data item in caches
      Child.FStaticDataEx.ItemRef := nil;

      DataEx := TElTreeItemStaticDataEx.Create;
      DataEx.Assign(Child.FStaticDataEx);

      if FOwner.FDataCache.Count <= FOwner.FDataCacheSize then
        FOwner.FDataCache.Move(FOwner.FDataCache.IndexOf(Child.FStaticDataEx), 0)
      else
      begin
        FOwner.FDataCache.Remove(Child.FStaticDataEx);
        Child.FStaticDataEx.Free;
      end;
      Child.FStaticDataEx := DataEx;
    end
    else
    begin
      Child.FStaticDataEx := TElTreeItemStaticDataEx.Create;
      FOwner.TriggerVirtualPropsNeeded(Child, AllVirtPropTypes, Child.FStaticDataEx);
    end;
  end;
  with FOwner do
  begin
    FUpdated := true;
    FView.FRangeUpdate := true;
    IsUpdating := false;
  end;
end;

procedure TElTreeItem.DeleteChild;
var
  i: integer;
begin
  Child.FBoolData := Child.FBoolData or ibfDeleting;
  FOwner.IsUpdating := true;
  try
    Child.Clear;
    if Child.Hidden then
    begin
      dec(FOwner.TotalHiddenCount);
      Child.FBoolData := Child.FBoolData and not ibfHidden;
    end;
    if Child = FOwner.FView.FSelected then
    begin
      if csDestroying in FOwner.ComponentState then
        FOwner.SetSelected(nil)
      else
      begin
        FOwner.SetSelected(GetNextChild(Child));
        if FOwner.FView.FSelected = nil then
          FOwner.SetSelected(GetPrevChild(Child));
        if FOwner.FView.FSelected = nil then
          if Self <> FRoot then
            FOwner.SetSelected(Self);
      end;
    end;
    if Child.Selected then
      Child.Selected := false;
    // Move focus, if needed
    if Child = FOwner.FView.FFocused then
    begin
      if csDestroying in FOwner.ComponentState then
        FOwner.DoSetFocused(nil, true)
      else
      begin
        FOwner.DoSetFocused(GetNextChild(Child), true);
        if FOwner.ItemFocused = nil then
          FOwner.DoSetFocused(GetPrevChild(Child), true);
        if FOwner.ItemFocused = nil then
          if Self <> FRoot then
            FOwner.DoSetFocused(Self, true);
      end;
    end;
    with FOwner do
      if (FUpdateCount = 0) and (FilteredVisibility) then
         UpdateDiffItems;
    with FOwner.FView do
    begin
  if FItemToEdit = Child then
         FItemToEdit := nil;
  if FPassedItem = Child then
         FPassedItem := nil;
      if FTrackItem = Child then
         FTrackItem := nil;
  if FOwner.IsEditing then
      begin
        FEditingItem := nil;
        DoEndEdit(true);
      end;
  end;
    if (FOwner.FView.FVisible.Count > 0) and not (csDestroying in FOwner.ComponentState) then
    with FOwner.FView do
    begin
      i := FVisible.IndexOfBack(FVisible.Count - 1, Child);
      if (i >= 0) then
         FVisible.Delete(i);
    end;
    FOwner.DoItemDelete(Child);
    if FChildren.Count > 0 then
    begin
      i := FChildren.IndexOfBack(FChildren.Count - 1, Child);
      if i <> -1 then
         FChildren.Delete(i);
      if FChildren.Count = 0 then
        FreeAndNil(FChildren);
    end;
  if (not Child.OwnerHeight) or (Child.Multiline and FOwner.FAdjustMultilineHeight) then
       dec(FOwner.TotalVarHeightCount);
  if (Child.FBoolData and ibfIsHTML) = ibfIsHTML then
       dec(FOwner.TotalVarHeightCount);
  //Child.Clear;
    i := FOwner.FAllList.IndexOfBack(FOwner.FAllList.Count - 1, Child);
    if (i >= 0) then
      FOwner.FAllList.Delete(i);

    if (FOwner.VirtualityLevel < vlAllProps) or (csDesigning in FOwner.ComponentState) then
    begin
      Child.DisposeStaticDataEx;
    end
    else
    if (Child.FStaticDataEx <> nil) then
    begin
      // move static data item in caches
      Child.FStaticDataEx.ItemRef := nil;
      if FOwner.FDataCache.Count <= FOwner.FDataCacheSize then
        FOwner.FDataCache.Move(FOwner.FDataCache.IndexOf(Child.FStaticDataEx), 0)
      else
      begin
        FOwner.FDataCache.Remove(Child.FStaticDataEx);
        Child.FStaticDataEx.Free;
      end;
      Child.FStaticDataEx := nil;
    end;
    if Child.FStaticData <> nil then
      Child.DisposeStaticData;
    Child.Free;
  finally
    with FOwner do
    begin
      if FOwner.ItemFocused = nil then
        FView.FSelected := nil;
      FUpdated := true;
      FView.FRangeUpdate := true;
      IsUpdating := false;
    end;
  end;
end;

function TElTreeItem.GetLastSubItem : TElTreeItem;
var Item : TElTreeItem;
begin
  result := Self;
  Item := Result.GetLastChild;
  While Item <> nil do
  begin
    result := Item;
    Item := Result.GetLastChild;
  end;
end;

function TElTreeItem.AddChild;
var i : integer;
begin
  if FChildren = nil then
     FChildren := TLMDObjectList.Create;
  with FOwner do
  begin
    if (FAllList.Count = 0) or (GetLastSubItem = FAllList.Last) then
        FAllList.Add(Child)
    else
    begin
      i := FAllList.IndexOf(GetLastSubItem);
      FAllList.Insert(i + 1, Child);
    end;
  end;
  result := FChildren.Add(Child);
  Child.FRoot := FRoot;

  Child.FParent := Self;
  Child.FList := Self.FList;

  if (FOwner.VirtualityLevel = vlNone) and (Child.FStaticData = nil) then
    Child.NewStaticData;
  if ((FOwner.VirtualityLevel < vlAllProps) or (csDesigning in FOwner.ComponentState)) and (Child.FStaticDataEx = nil) then
    Child.NewStaticDataEx;

  FOwner.FUpdated := true;

  if FOwner.VirtualityLevel > vlNone then
    NewVirtualSort;
end;

procedure TElTreeItem.AddExistingChild;
var i : integer;
    DataEx : TElTreeItemStaticDataEx;
begin
  with FOwner do
  begin
    i := FAllList.IndexOf(self);
    FAllList.Insert(i + 1, Child);
  end;
  Child.FRoot := FRoot;
  Child.FOwner := FOwner;
  Child.FList := FList;
  if Child.FChildren <> nil then
    for i := Child.FChildren.Count - 1 downto 0 do
      Child.AddExistingChild(TElTreeItem(Child.FChildren.Items[i]));
  if (FOwner.VirtualityLevel >= vlAllProps)  and (not (csDesigning in FOwner.ComponentState)) then
  begin
    with FOwner do
    begin
      if FDataCache.Count > FOwner.FView.FVisible.Count then
      begin
        DataEx := TElTreeItemStaticDataEx(FDataCache[0]);
        DataEx.ItemRef.FStaticDataEx := nil;
        DataEx.ItemRef := Child;
        DataEx.Assign(Child.FStaticDataEx);
        Child.FStaticDataEx.Free;
        Child.FStaticDataEx := DataEx;
        FDataCache.Move(0, FDataCache.Count - 1);
      end
      else
      begin
        DataEx := TElTreeItemStaticDataEx.Create;
        DataEx.Assign(Child.FStaticDataEx);
        DataEx.ItemRef := Child;
        Child.FStaticDataEx.Free;
        Child.FStaticDataEx := DataEx;
        FDataCache.Add(DataEx);
      end;
    end;
  end;
  FOwner.FUpdated := true;

  if FOwner.VirtualityLevel > vlNone then
    NewVirtualSort;
end;

function TElTreeItem.AddLastChild;
begin
  if FChildren = nil then FChildren := TLMDObjectList.Create;
  with FOwner do
  begin
    FAllList.Add(Child);
  end;
  result := FChildren.Add(Child);
  Child.FRoot := FRoot;
  if (FOwner.VirtualityLevel = vlNone) and (Child.FStaticData = nil) then
    Child.NewStaticData;
  if ((FOwner.VirtualityLevel < vlAllProps) or (csDesigning in FOwner.ComponentState)) and (Child.FStaticDataEx = nil)   then
    Child.NewStaticDataEx;
  FOwner.FUpdated := true;

  if FOwner.VirtualityLevel > vlNone then
    NewVirtualSort;
end;

function TElTreeItem.InsertChild;
var i : integer;
    SI: TElTreeItem;

begin
  if FChildren = nil then FChildren := TLMDObjectList.Create;
  if Index > FChildren.Count then
    raise EElTreeError.Create(STExOutOfBounds);

  with FOwner do
  begin
    if Count = 0 then
      i := FAllList.IndexOf(Self) + 1
    else
    begin
      if FChildren.Count = Index then
      begin
        SI := TElTreeItem(FChildren.List[Index - 1]).GetLastSubItem;
        if SI = FAllList.Last then
           i := FAllList.Count
        else
           i := FAllList.IndexOf(SI) + 1;
      end
      else
        i := FAllList.IndexOf(FChildren.List[Index]);
    end;
    if i = FAllList.Count then
       FAllList.Add(Child)
    else
       FAllList.Insert(i, Child);
  end;

  FChildren.Insert(Index, Child);
  result := index;
  Child.FParent := self;
  Child.FRoot := FRoot;
  if (FOwner.VirtualityLevel = vlNone) and (Child.FStaticData = nil) then
    Child.NewStaticData;
  if ((FOwner.VirtualityLevel < vlAllProps) or (csDesigning in FOwner.ComponentState)) and (Child.FStaticDataEx = nil) then
    Child.NewStaticDataEx;
  FOwner.FUpdated := true;

  if FOwner.VirtualityLevel > vlNone then
    NewVirtualSort;
end;

procedure TElTreeItem.MoveTo;
var TSI: TElTreeItem;
begin
  if NewParent = self then exit;
  if NewParent = nil then
     TSI := FRoot
  else
     TSI := NewParent;
  if TSI.FChildren = nil then
     MoveToIns(NewParent, 0)
  else
     MoveToIns(NewParent, TSI.FChildren.Count);
end;

procedure TElTreeItem.MoveToIns(NewParent: TElTreeItem; AnIndex: integer);
var i : integer;
    OldStart,
    OldEnd,
    NewStart : integer;
    aresize  : boolean;
    //OldSel   : boolean;
begin
  if NewParent = self then exit;
  if NewParent = nil then NewParent := FRoot;
  if NewParent.IsUnder(self) then
    raise EElTreeError.Create(STexRecursiveMove);
  FOwner.IsUpdating := true;
  {if FParent.FChildren = nil then
  begin
    i := -1;
    FParent.FChildren := TLMDObjectList.Create;
  end else }
  i := FParent.FChildren.IndexOf(self);

  with FOwner.FAllList do
  begin
    OldStart := IndexOf(Self);
    OldEnd   := IndexOfFrom(OldStart, GetLastSubItem);
  end;
  aresize := false;
  {if FParent <> nil then }
  //OldSel := FOwner.FView.FSelected = Self;
  FParent.RemoveChild(self);
  if (FParent = NewParent) and (AnIndex > i) and (AnIndex >= FParent.Count) then
  begin
    NewStart := FOwner.FAllList.IndexOf(FParent.GetLastSubItem);
    with FOwner.FAllList do
    if NewStart = Count - 1 then
    begin
      aresize := true;
      Count := Count + 1;
    end;
    inc(NewStart);
    with FParent do
    begin
      if FChildren = nil then
         FChildren := TLMDObjectList.Create;
      FChildren.Add(self);
    end;
  end
  else
  begin
    with NewParent do
    begin
      if FChildren = nil then
         FChildren := TLMDObjectList.Create;
      FChildren.Insert(AnIndex, self);
      if AnIndex = 0 then
         NewStart := FOwner.FAllList.IndexOf(NewParent)
      else
         NewStart := FOwner.FAllList.IndexOf(TElTreeItem(FChildren.List[AnIndex - 1]).GetLastSubItem);
    end;
    with FOwner.FAllList do
      if NewStart = Count - 1 then
      begin
        aresize := true;
        Count := Count + 1;
      end;
    inc(NewStart);
  end;
  FOwner.FAllList.MoveRange(OldStart, OldEnd, NewStart);

  //if OldSel then FOwner.FView.FSelected := Self;

  if aresize then
  with FOwner.FAllList do
     Count := Count - 1;
  FParent := NewParent;
  with FOwner do
  begin
    //inc(FItems.FCount);
    if ((FSortMode = smAdd) or (FSortMode = smAddClick)) and (FInSorting = 0) then
    begin
      if (FMainTreeCol = FSortSection) or (FSortSection = -1) then
        FSortRequired := true;
    end;
    with FOwner.FView do
    begin
      FVisUpdated := true;
      FClearVis := true;
      FUpdated := true;
      FClearAll := true;
    end;
    IsUpdating := false;
  end;
end;

procedure TElTreeItem.RedrawItemPart;
var
  R: TRect;
begin
  if (FOwner = nil) or ((FBoolData and ibfDeleting) = ibfDeleting) then exit;
  with FOwner do
    R := FView.GetItemRect(FView.FVisible.IndexOf(self));
  inc(R.Bottom);
  if DoCheck and IsRectEmpty(R) then exit;
  R.Left := Left - FOwner.FHPos;
  R.Right := Right - FOwner.FHPos;
  if not (csDestroying in FOwner.ComponentState) then
  InvalidateRect(FOwner.FView.Handle, @R, true);
end;

procedure TElTreeItem.RedrawItem;
var
  R: TRect;
begin
  if (FOwner = nil) or ((FBoolData and ibfDeleting) = ibfDeleting) then exit;
  if DoCheck and (FOwner.FView.FVisible.IndexOf(Self) = -1) then
    exit;
  with FOwner do
    R := FView.GetItemRect(FView.FVisible.IndexOf(self));
  inc(R.Bottom);
  if DoCheck and IsRectEmpty(R) then exit;
  if not (csDestroying in FOwner.ComponentState) then
  InvalidateRect(FOwner.FView.Handle, @R, true);
end;

procedure TElTreeItem.SetText(Value: TLMDString);
begin
  if FStaticData <> nil then
  begin
    FStaticData.FText := Value;
    FOwner.DoItemChange(Self, icmText);
    FOwner.IsUpdating := true;
    UpdateChangedMainText;
    FOwner.IsUpdating := false;
  end;
  UpdateItem;
end;

function TElTreeItem.GetLevel: integer;
begin
  if Self = FRoot then
    result := -1
  else
    result := FParent.Level + 1;
end;

{Returns true if the item is under then given item in the tree}

function TElTreeItem.IsUnder(Item: TElTreeItem): boolean;
begin
  if Item = nil then
  begin
    result := false;
    exit;
  end;
  if Self = Item then
     result := true
  else
  if (FParent <> FRoot) and (FParent <> nil) then
     result := FParent.IsUnder(Item)
  else
     result := false;
end;

procedure TElTreeItem.SetExpanded;
begin
  if value = Expanded then exit;
  FOwner.IsUpdating := true;
  try
    if value = true then
      Expand(false)
    else
      Collapse(false);
  finally
    FOwner.IsUpdating := false;
  end;
end;

procedure TElTreeItem.MakeFullyExpanded;
var
  TSI: TElTreeItem;
begin
  if not value then exit;
  FOwner.IsUpdating := true;
  try
    TSI := Self;
    TSI.Expand(false);
    while TSI.FParent <> nil do
    begin
      if not TSI.FParent.Expanded then
        TSI.FParent.Expand(false);
      TSI := TSI.FParent;
    end; // while
    with FOwner.FView do
    begin
      FClearVis := true;
      FVisUpdated := true;
      FRangeUpdate := true;
    end;
    FOwner.FUpdated := true;
  finally
    FOwner.IsUpdating := false;
  end;
end;

procedure TElTreeItem.SetParentStyle(value: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if value = ((FBoolData1 and ibfParentStyle) = ibfParentStyle) then exit;
    if Value then
      FBoolData1 := FBoolData1 or ibfParentStyle
    else
      FBoolData1 := FBoolData1 and not ibfParentStyle;
    with FOwner do
    begin
      IsUpdating := true;
      if FShowHeader then
        FColSizeUpdate := true;

      if (not FShowHeader) and FullyExpanded then
        FView.FHRange := -1;

      FView.FRangeUpdate := true;
      FUpdated := true;
      IsUpdating := false;
    end;
    UpdateItem;
  end;
end;

procedure TElTreeItem.SetParentColors(value: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if value = ((FBoolData1 and ibfParentColors) = ibfParentColors) then exit;
    if Value then
      FBoolData1 := FBoolData1 or ibfParentColors
    else
      FBoolData1 := FBoolData1 and not ibfParentColors;
    UpdateItem;
  end;
end;

function TElTreeItem.GetHasChildren: boolean;
begin
  result := (FChildren <> nil) and (FChildren.Count > 0);
end;

procedure TElTreeItem.Clear;
var i : integer;
    OldFocused : TElTreeItem;
begin
  OldFocused := FOwner.FView.FFocused;
  inc(FOwner.FFireFocusEvents);
  try
    if FChildren = nil then exit;
    for i := -FChildren.Count + 1 to 0 do
        DeleteChild(TElTreeItem(FChildren.Last));
    FreeAndNil(FChildren);
    if FullyExpanded then
      FOwner.FView.FVisUpdated := true;
  finally
    Dec(FOwner.FFireFocusEvents);
  end;
  if (OldFocused <> FOwner.FView.FFocused) and (FOwner.FFireFocusEvents = 0) then
    FOwner.DoItemFocused;
end;

procedure TElTreeItem.ClearSubChild;
var i : integer;
    OldFocused : TElTreeItem;
begin
  if FChildren = nil then exit;
  OldFocused := FOwner.FView.FFocused;
  inc(FOwner.FFireFocusEvents);
  try
    for i := FChildren.Count-1 downto 0 do
      RemoveSubChild(TElTreeItem(FChildren.Items[i]));
    if FullyExpanded then
      FOwner.FView.FVisUpdated := true;
  finally
    Dec(FOwner.FFireFocusEvents);
  end;
  if (OldFocused <> FOwner.FView.FFocused) and (FOwner.FFireFocusEvents = 0) then
    FOwner.DoItemFocused;
end;

procedure TElTreeItem.ExchangeItems(I, J: integer);
var
  P : TLMDDataTag;
begin
  // No check for FChildren and indexes validity. The routine should be called from QuickSort only!
  P := FChildren.List[i];
  FChildren.List[i] := FChildren.List[j];
  FChildren.List[j] := P;
end;

procedure TElTreeItem.NormalizeSorts(StartIdx : integer);

  procedure IntNormalize(List : TLMDObjectList; Item : TElTreeItem; var CurIdx : integer);
  var i : integer;
      AChild : TElTreeItem;
      ChC    : integer;
  begin
    if (Item.FChildren <> nil) then
    begin
      ChC := Item.FChildren.Count;
      if (ChC > 0) then
      begin
        for i := 0 to ChC - 1 do
        begin
          AChild := TElTreeItem(Item.FChildren.List[i]);
          if CurIdx > List.Count - 1 then
            List.Count := CurIdx + 1;

          List[CurIdx] := AChild;
          Inc(CurIdx);
          if (AChild.FChildren <> nil) and (AChild.FChildren.Count > 0) then
             IntNormalize(List, AChild, CurIdx);
        end;
      end;
    end;
  end;

begin
  IntNormalize(FOwner.FAllList, Self, StartIdx);
end;

procedure TElTreeItem.Sort(recursive: boolean);
var
  ST       : TSortTypes;
  ASection : TElHeaderSection;
  SM       : TElSSortMode;
  FCol     : integer;
  StartItem: TElTreeItem;
  StartIdx : Integer;
begin
  inc(FOwner.FInSorting);
  if (FChildren <> nil) and (Recursive or (FChildren.Count > 1)) then
  begin
    FOwner.IsUpdating := true;

    with FOwner do
    begin
      if (not FShowHeader) or (FHeader.Sections.Count <= FSortSection) then
      begin
        FCol := -1;
      end
      else
      begin
        FCol := FSortSection;
      end;
      SM := hsmNone;
      ST := FSortType;

      if FShowHeader and (FCol >= 0) and (FHeader.Sections.Count > FSortSection) then
      begin
        ASection := FHeader.Sections[FCol];
        if ASection <> nil then
        begin
          SM := ASection.SortMode;
          ST := SectionTypeToSortType(ASection.FieldType);
        end
        else
          FCol := -1;
      end
      else
        FCol := -1;
    end;

    StartItem := TElTreeItem(FChildren.FastGet(0));
    StartIdx := StartItem.AbsoluteIndex;

    FBoolData := FBoolData and not ibfRec;

    QuickSort(recursive, 0, FChildren.Count - 1, SM, ST, FCol);

    NormalizeSorts(StartIdx);

    with FOwner.FView do
    begin
      FClearAll := true;
      FClearVis := true;
    end;
    with FOwner do
    begin
      FUpdated := true;
      IsUpdating := false;
    end;
  end;
  dec(FOwner.FInSorting);
end;

procedure TElTreeItem.AddSortData(SortType: TSortTypes;
                                  FSortSection : integer);
var
  S : TLMDString;
  N, I, FCol : integer;
  CC: Currency;
  bb: boolean;
  T : TDateTime;
  F : Extended;
  MTC: integer;
  VA : Variant;
  IntConv : boolean;

begin
  MTC := FOwner.FMainTreeCol;
  if FSortRef = 0 then
  begin
    {$IFDEF USE_VARIANT}
    VarClear(FSortData);
    {$ELSE}
    FSortType := -1;
    {$ENDIF}
    IntConv := true;
    if FOwner.VirtualityLevel <> vlNone then
    begin
      //if Assigned(FOwner.FOnVirtualValueNeeded) then
      begin
        IntConv := false;
        try
          if SortType = stText then
          begin
            FOwner.TriggerVirtualTextNeeded(Self, FSortSection, S);
            {$IFDEF USE_VARIANT}
            FSortData := S;
            {$ELSE}
            FSortType := vtString;
            {$ifdef LMD_UNICODE}

            GetMem(FSortData, (Length(S) + 1) * sizeof(WideChar));
            if FOwner.SortUseCase then
              LMDWideStrPCopy(PWideChar(FSortData), S)
            else
              LMDWideStrPCopy(PWideChar(FSortData), LMDWideUpperCase(S));
            {$else}
            GetMem(FSortData, (Length(S) + 1) * SizeOf(Char));
            if FOwner.SortUseCase then
              StrPLCopy(PChar(FSortData), S, Length(S))
            else
              StrPLCopy(PChar(FSortData), Uppercase(S), Length(S));
            {$endif}
            {$ENDIF}
          end
          else
          begin
            case SortType of
              stNumber:
                begin
                  {$IFDEF USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtInteger, VA);
                  FSortData := VA;
                  {$ELSE}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtInteger, VA);
                  N := VA;
                  FSortType := vtInteger;
                  TLMDPtrInt(FSortData) := N;
                  {$ENDIF}
                end;
              stCurrency:
                begin
                  {$IFDEF USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtCurrency, VA);
                  FSortData := VA;
                  {$ELSE}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtCurrency, VA);
                  CC := VA;
                  FSortType := vtCurrency;
                  GetMem(FSortData, sizeof(Currency));
                  PCurrency(FSortData)^ := CC;
                  {$ENDIF}
                end;
              stFloating:
                begin
                  {$IFDEF USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtExtended, VA);
                  FSortData := VA;
                  {$ELSE}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtExtended, VA);
                  F := VA;
                  FSortType := vtExtended;
                  GetMem(FSortData, sizeof(Double));
                  PDouble(FSortData)^ := F;
                  {$ENDIF}
                end;
              stDateTime,
              stDate,
              stTime:
                begin
                  {$IFDEF USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtExtended, VA);
                  FSortData := VA;
                  {$ELSE}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtExtended, VA);
                  T := VA;
                  FSortType := vtExtended;
                  GetMem(FSortData, sizeof(Double));
                  PDouble(FSortData)^ := T;
                  {$ENDIF}
                end;
              stBoolean:
                begin
                  {$IFDEF USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtBoolean, VA);
                  FSortData := VA;
                  {$ELSE}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtBoolean, VA);
                  BB := VA;
                  FSortType := vtBoolean;
                  FSortData := TObject(BB);
                  {$ENDIF}
                end;
              else
                begin
                  {$IFDEF USE_VARIANT}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtString, VA);
                  FSortData := VA;
                  {$ELSE}
                  FOwner.TriggerVirtualValueNeeded(Self, FSortSection, vtString, VA);
                  S := VA;
                  FSortType := vtString;
                  GetMem(FSortData, (Length(S) + 1) * SizeOf(Char));
                  StrPLCopy(PChar(FSortData), S, Length(S))
                  {$ENDIF}
                end;
            end;
          end;
        except
          on E: EVariantError do
            IntConv := true;
        end;
      end;
    end;

    if IntConv then
    begin
      if (FSortSection = MTC) or (FSortSection = -1) then
      begin
        S := Text; // NOTE:
      end
      else
      begin
        FCol := FSortSection;
        if FSortSection > MTC then
           dec(FCol);
        if FCol >= FStaticData.FColText.Count then
           S := ''
        else
           S := FStaticData.FColText[FCol];
      end;

      if SortType = stText then
      begin
        {$IFDEF USE_VARIANT}
        FSortData := S;
        {$ELSE}
        FSortType := vtString;

        {$ifdef LMD_UNICODE}

        GetMem(FSortData, (Length(S) + 1) * sizeof(WideChar));
        if FOwner.SortUseCase then
          LMDWideStrPCopy(PWideChar(FSortData), S)
        else
          LMDWideStrPCopy(PWideChar(FSortData), LMDWideUpperCase(S));

        {$else}
        GetMem(FSortData, (Length(S) + 1) * SizeOf(Char));
        if FOwner.SortUseCase then
          StrPLCopy(PChar(FSortData), S, Length(S))
        else
          StrPLCopy(PChar(FSortData), Uppercase(S), Length(S));
        {$endif}
        {$ENDIF}
      end
      else
      if SortType = stNumber then
      begin
        {$IFDEF USE_VARIANT}
        TVarData(FSortData).VType := vtInteger;
        Val(S, N, I);
        if I <> 0 then
          FSortData := NULL
        else
          FSortData := N;
        {$ELSE}
        FSortType := vtInteger;
        Val(S, N, I);
        if I <> 0 then
          FSortType := -1
        else
          TLMDPtrInt(FSortData) := N;
          {$ENDIF}
      end
      else
      case SortType of
        stCurrency:
          begin
            {$IFDEF USE_VARIANT}
            FSortData := PrettyStrToCurr(S);
            {$ELSE}
            FSortType := vtCurrency;

            GetMem(FSortData, sizeof(Currency));
            PCurrency(FSortData)^ := LMDPrettyStrToCurr(S);
            {$ENDIF}
          end;
        stFloating:
          begin
            {$IFDEF USE_VARIANT}
            TVarData(FSortData).VType := vtExtended;
            if (not TextToFloat(Pchar(S), F, fvExtended)) then
               FSortData := NULL
            else
               FSortData := F;
            {$ELSE}
            FSortType := vtExtended;

            if (not TextToFloat(PChar(String(S)), F, fvExtended)) then
               FSortType := -1
            else
            begin
              GetMem(FSortData, sizeof(Double));
              PDouble(FSortData)^ := F;
            end;
            {$ENDIF}
          end;
        stDateTime:
          begin
            {$IFDEF USE_VARIANT}
            TVarData(FSortData).VType := vtExtended;
            try
              if system.Length(s) > 0 then
              begin
                T := StrToDateTime(S);
                FSortData := T;
              end
              else
                FSortData := NULL;
            except
              FSortData := NULL
            end;
            {$ELSE}
            FSortType := vtExtended;
            try
              if system.Length(s) > 0 then
              begin
                T := StrToDateTime(S);
                GetMem(FSortData, sizeof(Double));
                PDouble(FSortData)^ := T;
                end
              else
                FSortType := -1;
            except
              FSortType := -1;
            end;
            {$ENDIF}
          end;
        stDate:
          begin
            {$IFDEF USE_VARIANT}
            TVarData(FSortData).VType := vtExtended;
            try
              if system.Length(s) > 0 then
              begin
                T := StrToDate(S);
                FSortData := T;
              else
                FSortData := NULL;
            except
              FSortData := NULL
            end;
            {$ELSE}
            FSortType := vtExtended;
            try
              if system.Length(s) > 0 then
              begin
                T := StrToDate(S);
                GetMem(FSortData, sizeof(Double));
                PDouble(FSortData)^ := T;
                end
              else
                FSortType := -1;
            except
              FSortType := -1;
            end;
            {$ENDIF}
          end;
        stTime:
          begin
            {$IFDEF USE_VARIANT}
            TVarData(FSortData).VType := vtExtended;
            try
              if system.Length(s) > 0 then
              begin
                T := StrToTime(S);
                FSortData := T;
              end
              else
                FSortData := NULL;
            except
              FSortData := NULL
            end;
            {$ELSE}
            FSortType := vtExtended;
            try
              if system.Length(s) > 0 then
              begin
                T := StrToTime(S);
                GetMem(FSortData, sizeof(Double));
                PDouble(FSortData)^ := T;
                end
              else
                FSortType := -1;
            except
              FSortType := -1;
            end;
            {$ENDIF}
          end;
        stBoolean:
          begin
            {$IFDEF USE_VARIANT}
            TVarData(FSortData).VType := vtBoolean;
            FSortData := boolean(S <> '');
            {$ELSE}
            FSortType := vtBoolean;
            TLMDPtrInt(FSortData) := Length(S);
            {$ENDIF}
          end;
        else
          begin
            {$IFDEF USE_VARIANT}
            FSortData := S;
            {$ELSE}
            FSortType := vtString;
            GetMem(FSortData, (Length(S) + 1) * SizeOf(Char));
            StrPLCopy(PChar(FSortData), S, Length(S));
            {$ENDIF}
          end;
      end;
    end;
  end;
  inc(FSortRef);
end;

procedure TElTreeItem.ReleaseSortData;
begin
  dec(FSortRef);
  if (FSortRef = 0) then
  {$IFDEF USE_VARIANT}
     VarClear(FSortData);
  {$ELSE}
  begin
    if ((FSortType = vtExtended) or (FSortType = vtString)) and (FSortData <> nil) then
       FreeMem(FSortData);
    FSortData := nil;
    FSortType := -1;
  end;
  {$ENDIF}
end;

procedure TElTreeItem.QuickSort(recursive: boolean;
                                L, R: Integer;
                                SM : TElSSortMode;
                                SortType: TSortTypes;
                                FSortSection : integer);
var
  I, J       : Integer;
  P          : TElTreeItem;
  EL, ER     : integer;
  ChildCount : integer;
  LocalFRec  : boolean;
  Item1,
  Item2      : TElTreeItem;

begin
  Childcount := FChildren.Count;
  inc(FOwner.FInSorting);
  if ChildCount > 1 then
  begin
    if (FBoolData and ibfRec) <> ibfRec then
    begin
      for i := 0 to ChildCount - 1 do
      begin
        p := TElTreeItem(FChildren.List[i]);
        if P.FSortRef = 0 then
           P.AddSortData(SortType, FSortSection)
        else
           inc(P.FSortRef);
      end;
    end;
    El := L;
    Er := R;
    repeat
      I := L;
      J := R;
      P := TElTreeItem(FChildren.List[(L + R) shr 1]);
      repeat
        while (I < ChildCount) do
        begin
          Item1 := TElTreeItem(FChildren.List[I]);
          Item2 := P;
          if Item1 = Item2 then break;
          if (FOwner.CompareItems(Item1, Item2, SM, SortType, FSortSection) >= 0) then break;
          Inc(I);
        end;
        while (J >= 0) do
        begin
          Item1 := TElTreeItem(FChildren.List[J]);
          Item2 := P;
          if Item1 = Item2 then break;
          if (FOwner.CompareItems(Item1, P, SM, SortType, FSortSection) < 0) then break;
          Dec(J);
        end;
        if I <= J then
        begin
          if i <> j then
             ExchangeItems(I, J);
          Inc(I);
          Dec(J);
        end;
      until I > J;
      if (L < J) and ((EL <> L) or (ER <> J)) then
      begin
        LocalFRec:= (FBoolData and ibfRec) = ibfRec;
        FBoolData := FBoolData or ibfRec;
        QuickSort(recursive, L, J, SM, SortType, FSortSection);
        if LocalFRec then
          FBoolData := FBoolData or ibfRec
        else
          FBoolData := FBoolData and not ibfRec;
      end;
      L := I;
    until I >= R;
    if (FBoolData and ibfRec) <> ibfRec then
      for i := 0 to ChildCount - 1 do
      begin
        P := TElTreeItem(FChildren.List[i]);
        if P.FSortRef = 1 then
           P.ReleaseSortData
        else
           dec(P.FSortRef);
      end;
  end;

  if Recursive then
  begin
    if (FBoolData and ibfRec) <> ibfRec then
    begin
      for i := 0 to ChildCount - 1 do
      begin
        P := TElTreeItem(FChildren.List[i]);
        if (P.FChildren <> nil) and (P.FChildren.Count > 0) then
            P.QuickSort(recursive, 0, P.FChildren.Count - 1, SM, SortType, FSortSection);
      end; // for
    end;
  end;
  dec(FOwner.FInSorting);
end;

procedure TElTreeItem.OnColTextChange(Sender: TObject);
begin
  if FOwner <> nil then
  begin
    FOwner.DoItemChange(Self, icmColumnText);
    UpdateChangedCellText;
    UpdateItem;
  end;
end;

procedure TElTreeItem.SetImageIndex(Index: Integer; value: Integer);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    case Index of
      0:
        begin
          if FImageIndex = value then exit;
          FImageIndex := value;
        end;
      1:
        begin
          if FImageIndex2 = value then exit;
          FImageIndex2 := value;
        end;
      2:
        begin
          if FStImageIndex = value then exit;
          FStImageIndex := value;
        end;
      3:
        begin
          if FStImageIndex2 = value then exit;
          FStImageIndex2 := value;
        end;
      4:
        begin
          if (FOverlayIndex = value) or (Value < -1) or (Value > 3) then exit;
          FOverlayIndex := value;
        end;
      5:
        begin
          if (FOverlayIndex2 = value) or (Value < -1) or (Value > 3) then exit;
          FOverlayIndex2 := value;
        end;
    end;

    // We do not do update if we exist in a status of drawing
    if FOwner.FView.FPainting then
      exit;

    FOwner.IsUpdating := true;
    try
      if FOwner.FShowImages then
      begin
        with FOwner do
        begin
          if Index in [0, 1] then
          begin
            if (not FShowEmptyImages) and FShowHeader then
               AutoSizeColumn(FMainTreeCol)
            else
               FColSizeUpdate := true;
          end
          else
          if Index in [2, 3] then
          begin
            if (not FShowEmptyImages2) and FShowHeader then
               AutoSizeColumn(FMainTreeCol)
            else
               FColSizeUpdate := true;
          end;
          if (not FShowHeader) and FullyExpanded then
            FView.FHRange := -1;
        end;
        UpdateItem;
      end;
    finally
      FOwner.IsUpdating := false;
    end;
  end;
end; { SetImageIndex }

procedure TElTreeItem.SetForceButtons(newValue: Boolean);
{ Sets data member FForceButtons to newValue. }
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if ((FBoolData1 and ibfForceButtons) = ibfForceButtons) <> newValue then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfForceButtons
      else
        FBoolData1 := FBoolData1 and not ibfForceButtons;

      if FOwner.FShowButtons then
      begin
        with FOwner do
          if FShowHeader and (FOwner.FUpdateCount = 0) then
            AutoSizeColumn(FMainTreeCol)
          else
            FOwner.FColSizeUpdate := true;
        UpdateItem;
      end;
    end;
  end;
end; { SetForceButtons }

function TElTreeItem.GetCount: Integer;
begin
  if FChildren = nil then
    result := 0
  else
    result := FChildren.Count;
end; { GetCount }

function TElTreeItem.GetItems(Index: integer): TElTreeItem;
{ Returns the value of data member FItems[Index ]. }
begin
  if FChildren = nil then
     result := nil
  else
     result := TElTreeItem(FChildren[Index]);
end; { GetItems }

procedure TElTreeItem.Delete; { public }
begin
  FList.DeleteItem(Self);
end; { Delete }

function TElTreeItem.IsVisible: Boolean; { public }
begin
  result := FullyExpanded;
  if Self = FList.FRoot then
    result := true
  else
    result := result or (not (FOwner.FFilteredVisibility and Hidden) and (FParent.IsVisible and FParent.Expanded));
end; { IsVisible }

function TElTreeItem.GetNextVisible: TElTreeItem; { public }
begin
  Result := GetNext;
  while Assigned(Result) and (not Result.IsVisible) do Result := Result.GetNext;
end;

function TElTreeItem.GetPrevVisible: TElTreeItem; { public }
begin
  Result := GetPrev;
  while Assigned(Result) and (not Result.IsVisible) do Result := Result.GetPrev;
end;

function TElTreeItem.GetPrev: TElTreeItem; { public }
var i : integer;

begin
  i := FOwner.FAllList.IndexOf(Self);
  if i = 0 then
     Result := nil
  else
     Result := TElTreeItem(FOwner.FAllList[Pred(i)]);
end; { GetPrev }

function TElTreeItem.GetNext: TElTreeItem; { public }
var i : integer;

begin
  i := FOwner.FAllList.IndexOf(Self);
  if i = Pred(FOwner.FAllList.Count) then
     Result := nil
  else
     Result := TElTreeItem(FOwner.FAllList[Succ(i)]);
end; { GetNext }

procedure TElTreeItem.MoveToItem(Item: TElTreeItem; Mode: TNodeAttachMode); { public }
begin
  case Mode of
    naAdd:
      begin
        if not Assigned(item) then
           raise EElTreeError.Create(STexInvItem);
        if not Assigned(item) then
           MoveTo(nil)
        else
           MoveToIns(item.FParent, item.FParent.Count);
      end;
    naAddFirst:
      begin
        if not Assigned(item) then
           MoveToIns(nil, 0)
        else
           MoveToIns(item.FParent, 0);
      end;
    naAddChild: MoveTo(item);
    naAddChildFirst: MoveToIns(item, 0);
    naInsert:
      begin
        if not Assigned(item) then
          MoveToIns(nil, 0)
        else
          if (FParent = item.FParent) and (Index < Item.Index) then
            MoveToIns(item.FParent, item.Index-1)
          else
            MoveToIns(item.FParent, item.Index);
      end;
  end;
end; { MoveToItem }

procedure TElTreeItem.SetUseStyles(newValue: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if ((FBoolData1 and ibfUseStyles) = ibfUseStyles) <> newValue then
    begin
      FOwner.IsUpdating := true;
      if newValue then
        FBoolData1 := FBoolData1 or ibfUseStyles
      else
        FBoolData1 := FBoolData1 and not ibfUseStyles;
      if FStaticData <> nil then
        if (FBoolData1 and ibfUseStyles) = ibfUseStyles then
        begin
          if FStaticData.FStyles = nil then
            CreateStyles;
        end
        else
        begin
          if FStaticData.FStyles <> nil then
          begin
            FStaticData.FStyles.Free;
            FStaticData.FStyles := nil;
          end;
        end;
      with FOwner do
      begin
        if FShowHeader then
          FColSizeUpdate := true;

        if (not FShowHeader) and FullyExpanded then
          FView.FHRange := -1;
        FView.FRangeUpdate := true;
        FUpdated := true;
        IsUpdating := false;
      end;
    end; {if}
  end;
end;

procedure TElTreeItem.UpdateItem;
begin
  if not (FOwner.FFilteredVisibility and Hidden) {and (FOwner.FUpdateCount = 0) }then
    RedrawItem(true);
  with FOwner do
    if FUpdateCount > 0 then
      FUpdated := true
    else
      FView.Update;
end;

function TElTreeItem.GetStyles(index: integer): TElCellStyle;
begin
  if FStaticData <> nil then
  begin
    if FStaticData.FStyles = nil then
      result := nil
    else
      result := TElCellStyle(FStaticData.FStyles[index]);
  end
  else
    result := nil;
end;

procedure TElTreeItem.SetStyles(index: integer; newValue: TElCellStyle);
begin
  if FStaticData <> nil then
  begin
    if FStaticData.FStyles = nil then
      CreateStyles;
    if (FStaticData.FStyles[index] <> newValue) then
    begin
      FStaticData.FStyles[index] := newValue;
    end; {if}
  end;
end;

function TElTreeItem.AddStyle: TElCellStyle;
begin
  if FStaticData <> nil then
  begin
    Result := TElCellStyle.Create(Self);
    Result.FOwnerProps := true;
    Result.FFontSize := FOwner.Font.Size;
    Result.FFontStyles := FOwner.Font.Style;
    Result.FFontName := FOwner.Font.Name;
    if Assigned(FStaticData.FMainStyle) then
      Result.Assign(FStaticData.FMainStyle);
    if FStaticData.FStyles = nil then
      CreateStyles;
    FStaticData.FStyles.Add(Result);
  end
  else
    result := nil;
end;

procedure TElTreeItem.RemoveStyle(Style: TElCellStyle);
begin
  if FStaticData <> nil then
  begin
    FStaticData.FStyles.Remove(Style);
    if FStaticData.FStyles.Count = 0 then
    begin
      FStaticData.FStyles.Free;
      FStaticData.FStyles := nil;
    end;
  end;
end;

function TElTreeItem.GetStylesCount: Integer;
begin
  if FStaticData <> nil then
  begin
    if FStaticData.FStyles = nil then
      result := 0
    else
      result := FStaticData.FStyles.Count;
  end
  else
    result := 0;
end;

procedure TElTreeItem.SetCheckBoxState(newValue: TCheckBoxState);
var
  Section: TElHeaderSection;
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (FCheckBoxState <> newValue) then
    begin
      FCheckBoxState := newValue;
      if ((FBoolData1 and ibfShowCheckBox) = ibfShowCheckBox) and (FOwner.FShowCheckboxes) then
      begin
        if FOwner.FShowHeader then
        begin
          Section := FOwner.FHeader.Sections[FOwner.FMainTreeCol];
          RedrawItemPart(true, Section.Left, Section.Right);
        end else RedrawItem(true);
        with FOwner do
          if IsUpdating then FUpdated := true else FView.Update;
      end;
    end; {if}
  end;
end; {SetCheckBoxState}

function TElTreeItem.GetChecked: boolean;
begin
  if FStaticDataEx <> nil then
    Result := FStaticDataEx.FCheckBoxState = cbChecked
  else
    Result := false;
end;

procedure TElTreeItem.SetChecked(newValue: Boolean);
var
  Section: TElHeaderSection;
  i: integer;
  Item: TElTreeItem;
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if ((FStaticDataEx.FCheckBoxState = cbChecked) <> newValue) then
    begin
      if newValue then
        FCheckBoxState := cbChecked
      else
        FCheckBoxState := cbUnchecked;
      if (FCheckBoxType = ectRadioButton) and (newValue) then
      begin
        if Assigned(FParent.FChildren) then
        begin
          for i := 0 to Pred(FParent.FChildren.Count) do
          begin
            Item := FParent.Children[i];
            if Item.FStaticDataEx <> nil then
              if (Item.FStaticDataEx.FCheckBoxType = ectRadioButton) and (Item <> Self) then
              begin
                Item.Checked := false;
              end;
          end; // for
        end; // if
      end;
      if ((FBoolData1 and ibfShowCheckBox) = ibfShowCheckBox) and (FOwner.FShowCheckboxes) then
      begin
        if FOwner.FShowHeader then
        begin
          Section := FOwner.FHeader.Sections[FOwner.FMainTreeCol];
          RedrawItemPart(true, Section.Left, Section.Right);
        end
        else
          RedrawItem(true);
        with FOwner do
          if IsUpdating then FUpdated := true else FView.Update;
      end;
    end;
  end;
end; {SetChecked}

procedure TElTreeItem.SetShowCheckBox(newValue: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfShowCheckBox) = ibfShowCheckBox) <> newValue) then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfShowCheckbox
      else
        FBoolData1 := FBoolData1 and not ibfShowCheckbox;

      with FOwner do
      begin
        if (FShowCheckboxes) then
        begin
          if FShowHeader and (FOwner.FUpdateCount = 0) then
            AutoSizeColumn(FMainTreeCol)
          else
            FOwner.FColSizeUpdate := true;
          if (not FShowHeader) and FullyExpanded then
            if FUpdateCount > 0 then
              FView.FHRange := -1
            else
              FView.DefineHRange;
          UpdateItem;
        end;
      end;
    end; {if}
  end;
end; {SetShowCheckBox}

procedure TElTreeItem.SetCheckBoxType(newValue: TElCheckBoxType);
var
  Section: TElHeaderSection;
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (FCheckBoxType <> newValue) then
    begin
      FCheckBoxType := newValue;
      if ((FBoolData1 and ibfShowCheckBox) = ibfShowCheckBox) and (FOwner.FShowCheckboxes) then
      begin
        if FOwner.FShowHeader then
        begin
          Section := FOwner.FHeader.Sections[FOwner.FMainTreeCol];
          RedrawItemPart(true, Section.Left, Section.Right);
        end
        else
          RedrawItem(true);
        with FOwner do
          if IsUpdating then
            FUpdated := true
          else
            FView.Update;
      end;
    end; {if}
  end;
end; {SetCheckBoxType}

procedure TElTreeItem.SetCheckBoxEnabled(newValue: Boolean);
var
  Section: TElHeaderSection;
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfCheckBoxEnabled) = ibfCheckBoxEnabled) <> newValue) then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfCheckBoxEnabled
      else
        FBoolData1 := FBoolData1 and not ibfCheckBoxEnabled;

      if ((FBoolData1 and ibfShowCheckBox) = ibfShowCheckBox) and FOwner.FShowCheckboxes then
      begin
        if FOwner.FShowHeader then
        begin
          Section := FOwner.FHeader.Sections[FOwner.FMainTreeCol];
          RedrawItemPart(true, Section.Left, Section.Right);
        end else RedrawItem(true);
        with FOwner do
          if IsUpdating then FUpdated := true else FView.Update;
      end;
    end; {if}
  end;
end; {SetCheckBoxEnabled}

procedure TElTreeItem.SetSuppressButtons(newValue: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfSuppressButtons) = ibfSuppressButtons) <> newValue) then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfSuppressButtons
      else
        FBoolData1 := FBoolData1 and not ibfSuppressButtons;
      with FOwner do
      begin
        if FShowButtons and FShowHeader and (FOwner.FUpdateCount = 0) then
          AutoSizeColumn(FMainTreeCol)
        else
          FOwner.FColSizeUpdate := true;
        if (not FShowHeader) and FullyExpanded then
          if FUpdateCount > 0 then
            FView.FHRange := -1
          else
            FView.DefineHRange;
      end;
      UpdateItem;
    end; {if}
  end;
end;

procedure TElTreeItem.SetEnabled(newValue: Boolean);
begin
  if (((FBoolData and ibfEnabled) = ibfEnabled) <> newValue) then
  begin
    if newValue then
      FBoolData := FBoolData or ibfEnabled
    else
      FBoolData := FBoolData and not ibfEnabled;
    // UpdateItem;
  end; {if}
end; {SetEnabled}

procedure TElTreeItem.SetHidden(newValue: Boolean);
begin
  if (((FBoolData and ibfHidden) = ibfHidden) <> newValue) then
  begin
    if newValue then
      FBoolData := FBoolData or ibfHidden
    else
      FBoolData := FBoolData and not ibfHidden;
    if FOwner <> nil then
    begin
      FOwner.IsUpdating := true;
      if newValue = true then
      begin
        inc(FOwner.TotalHiddenCount);
      end else
      begin
        dec(FOwner.TotalHiddenCount);
      end;
      if FOwner.FilteredVisibility then
      with FOwner.FView do
      begin
        FVisUpdated := true;
        FClearVis := true;
        FClearAll := true;
        FRangeUpdate := true;
        FOwner.FUpdated := true;
      end;
      FOwner.IsUpdating := false;
    end;
    with FOwner do
      if FShowHeader and (FOwner.FUpdateCount = 0) then
        AutoSizeColumn(FMainTreeCol)
      else
        FOwner.FColSizeUpdate := true;
  end; {if}
end;

function TElTreeItem.GetFullyVisible: Boolean;
begin
  if Parent <> nil then
    result := (not hidden) and Parent.FullyVisible
  else
    result := not hidden;
end;

procedure TElTreeItem.SetFullyVisible(newValue: Boolean);
begin
  if (FullyVisible <> newValue) then
  begin
    if newValue and (Parent <> nil) then
    begin
      Parent.FullyVisible := true;
      Hidden := false;
    end;
  end; {if}
end;

function TElTreeItem.GetHasVisibleChildren: Boolean;
var
  i: integer;
begin
  result := false;
  if FChildren = nil then
    result := false
  else
  begin
    if not FOwner.FilteredVisibility then
      result := FChildren.Count > 0
    else
    begin
      if FChildren.Count <> 0 then
        for i := 0 to FChildren.Count - 1 do
        begin
          if not TElTreeItem(FChildren.List[i]).Hidden then
          begin
            result := true;
            exit;
          end;
        end;
    end;
  end;
end;

procedure TElTreeItem.SetOwnerHeight(newValue : Boolean);
{ Sets data member FOwnerHeight to newValue. }
begin
  if (((FBoolData and ibfOwnerHeight) = ibfOwnerHeight) <> newValue) then
  begin
    if newValue then
      FBoolData := FBoolData or ibfOwnerHeight
    else
      FBoolData := FBoolData and not ibfOwnerHeight;

    FOwner.IsUpdating := true;
    FComplexHeight := (FComplexHeight and $FFFF0000) or word(-1);
    if newValue then
      dec(FOwner.TotalVarHeightCount)
    else
      inc(FOwner.TotalVarHeightCount);
    with FOwner.FView do
    begin
      FVisUpdated := true;
      FClearVis := true;
      FClearAll := true;
      FRangeUpdate := true;
      FOwner.FUpdated := true;
    end;
    FOwner.IsUpdating := false;
  end;  { if }
end;  { SetOwnerHeight }

function TElTreeItem.GetHeight : Integer;

var Size : TPoint;
    i : integer;
    Section : TElHeaderSection;
    w       : integer;

    function TextLinesCount : integer;
    var i, j : integer;
        AText: TLMDString;
    begin
      i := 1;
      result := 0;
      AText := Text;
      j := Length(AText);
      while i <= j do
      begin
        if (AText[i] = #13) and (i < j) and (AText[i + 1] = #10) then
        begin
          inc(result);
          inc(i);
        end;
        inc(i);
      end;
      if i > 1 then
        inc(result);
    end;

begin

  if ((FBoolData and ibfOwnerHeight) <> ibfOwnerHeight) or IsHTML or  (Multiline and FOwner.AdjustMultilineHeight) then
  begin
    if (((FComplexHeight shr 16) > 0) and ((FBoolData and ibfOwnerHeight) <> ibfOwnerHeight){(not Multiline) and not IsHTML}) then
      result := FComplexHeight shr 16
    else
    begin
//      if SmallInt(FComplexHeight shr 16) <> -1 then
//         result := SmallInt(FComplexHeight shr 16)
      if SmallInt(FComplexHeight and $0000FFFF) <> -1 then
         result := SmallInt(FComplexHeight and $0000FFFF)
      else
      begin
        if FOwner.ShowColumns then
        begin
          if WholeLine then
          begin
            result := 0;
            w := 0;
            for i := 0 to Pred(FOwner.FHeader.Sections.Count) do
            begin
              Section := FOwner.FHeader.Sections[i];
              if Section.Visible then
                inc(w, Section.Width);
            end;
            FOwner.MeasureCell(Self, FOwner.MainTreeColumn, w - 1, Size);
            result := Max(result, Size.Y);
          end
          else
          begin
            result := 0;
            for i := 0 to Pred(FOwner.FHeader.Sections.Count) do
            begin
              FOwner.MeasureCell(Self, i, FOwner.FHeader.Sections[i].Width - 1, Size);
              result := Max(result, Size.Y);
            end;
          end;
        end
        else
        begin
          FOwner.MeasureCell(Self, -1, FOwner.FView.ClientWidth, Size);
          result := Size.Y;
        end;
        FComplexHeight := (FComplexHeight and $FFFF0000) or Word(result);
      end;
    end;
  end
  else
    result := FOwner.LineHeight;

end;  { GetHeight }

procedure TElTreeItem.SetHeight(newValue : Integer);
{ Sets data member FHeight to newValue. }
begin
  if (SmallInt((FComplexHeight shr 16)) <> newValue) then
  begin
    FComplexHeight := (Word(newValue) shl 16) or (FComplexHeight and $0000FFFF);

    if ((FBoolData and ibfOwnerHeight) <> ibfOwnerHeight) then
    begin
      FOwner.IsUpdating := true;
      with FOwner.FView do
      begin
        FVisUpdated := true;
        FClearVis := true;
        FClearAll := true;
        FRangeUpdate := true;
        FOwner.FUpdated := true;
      end;
      FOwner.IsUpdating := false;
    end;
  end;  { if }
end;  { SetHeight }

procedure TElTreeItem.RecalcHeight;
begin
  if (FComplexHeight and $0000FFFF) <> word(-1) then
  begin
    FComplexHeight := (FComplexHeight and $FFFF0000) or word(-1);
    FOwner.IsUpdating := true;
    with FOwner.FView do
    begin
      FVisUpdated := true;
      FClearVis := true;
      FClearAll := true;
      FRangeUpdate := true;
      FOwner.FUpdated := true;
    end;
    FOwner.IsUpdating := false;
  end;
end;

procedure TElTreeItem.InvalidateItemPart(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: TLMDDataTag; Tree: TCustomElTree);
var
  R: TRect;
begin
  with Item.TreeView do
    R := GetItemRect(Item.AbsoluteIndex);
  Item.RedrawItemPart(true,R.Left, R.Right);

  ContinueIterate := true;
end;

procedure TElTreeItem.SetSuppressLines(newValue: Boolean);
{ Sets data member FSuppressLines to newValue. }
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfSuppressLines) = ibfSuppressLines) <> newValue) then
    begin
      if newValue then
        FBoolData1 := FBoolData1 or ibfSuppressLines
      else
        FBoolData1 := FBoolData1 and not ibfSuppressLines;

      if FOwner.FShowLines then
      begin
        FList.IterateFrom(true, false, InvalidateItemPart, nil, FParent); (*<+>*)
        with FOwner do
        begin
          if FShowHeader and (FOwner.FUpdateCount = 0) then
            AutoSizeColumn(FMainTreeCol)
          else
            FColSizeUpdate := true;
          if (not FShowHeader) and FullyExpanded then
            if FUpdateCount > 0 then
              FView.FHRange := -1
            else
              FView.DefineHRange;
        end;
        RedrawItem(true);
      end;
    end;  { if }
  end;
end;  { SetSuppressLines }

function TElTreeItem.GetOwnerHeight : boolean;
begin
  result := not (((FBoolData and ibfOwnerHeight) <> ibfOwnerHeight)(*{$IFNDEF LITE} or (Multiline and FOwner.FAdjustMultilineHeight){$ENDIF}*));
end;

procedure TElTreeItem.SetMultiline(newValue: Boolean);
{ Sets data member FMultiline to newValue. }
begin
  if (((FBoolData and ibfMultiline) = ibfMultiline) <> newValue) then
  begin
    if newValue then
      FBoolData := FBoolData or ibfMultiline
    else
      FBoolData := FBoolData and not ibfMultiline;

    FComplexHeight := (FComplexHeight and $FFFF0000) or WORD(-1);

    FOwner.IsUpdating := true;
    if FOwner.FAdjustMultilineHeight then
    begin
      if newValue then
        inc(FOwner.TotalVarHeightCount)
      else
        dec(FOwner.TotalVarHeightCount);
    end;
    with FOwner do
      if (not FShowHeader) and FullyExpanded then
        FView.FHRange := -1;

    with FOwner.FView do
    begin
      FVisUpdated := true;
      FClearVis := true;
      FClearAll := true;
      FRangeUpdate := true;
      FOwner.FUpdated := true;
    end;
    FOwner.IsUpdating := false;
  end;  { if }
end;  { SetMultiline }

procedure TElTreeItem.ReRenderMainText;
var
  AText : TLMDString;
  MaxWidth: integer;
begin
  if csLoading in FOwner.ComponentState then exit;
  if ((FBoolData and ibfIsHTML) <> ibfIsHTML) then exit;
  AText := Text;
  if FHTMLData <> nil then
     FOwner.FView.FRender.DestroyData(FHTMLData);
  MaxWidth := 0;
  if WordWrap then
  begin
    if FOwner.ShowColumns and (FOwner.HeaderSections.Count > FOwner.MainTreeColumn) then
      MaxWidth := FOwner.HeaderSections[FOwner.MainTreeColumn].Width
    else
      MaxWidth := FOwner.Width;
  end;
  if (AText = '') or (Pos('<html>', AText) <> 1) then
     FHTMLData := nil
  else
  begin
    FHTMLData := FOwner.FView.FRender.CreateData;

    FHTMLData.DefaultColor := FOwner.TextColor;
    if UseStyles and Assigned(MainStyle) then
    begin
      FHTMLData.DefaultStyle := MainStyle.FontStyles;
      FHTMLData.DefaultFont := MainStyle.FFontName;
//      FHTMLData.DefaultHeight := MainStyle.FFontSize;
      FHTMLData.DefaultHeight := -MulDiv(MainStyle.FFontSize, Screen.PixelsPerInch, 72);
      if not ParentColors then
        FHTMLData.DefaultColor := MainStyle.FTextColor;
    end
    else
    begin
      FHTMLData.DefaultStyle := FOwner.Font.Style;
      FHTMLData.DefaultFont  := FOwner.Font.Name;
      FHTMLData.DefaultHeight:= FOwner.Font.Height;
    end;
    FHTMLData.Charset      := FOwner.Font.Charset;
    FHTMLData.LinkStyle := FOwner.LinkStyle;
    FHTMLData.LinkColor := FOwner.LinkColor;

    FOwner.FView.FRender.PrepareToData(AText, MaxWidth, WordWrap and Multiline, FHTMLData);
  end;
end;

procedure TElTreeItem.ReRenderAllTexts;
var i : integer;
    FData : TLMDHTMLData;
    MaxWidth: integer;
begin
  if csLoading in FOwner.ComponentState then exit;
  if ((FBoolData and ibfIsHTML) <> ibfIsHTML) then exit;
  FHTMLDataArray.Clear;
  if FOwner.VirtualityLevel = vlNone then
  begin
    for i := 0 to ColumnText.Count -1 do
    begin
      if (Pos(('<html>'), ColumnText[i]) = 1) then
      begin
        FHTMLDataArray[i] := FOwner.FView.FRender.CreateData;
        FData := TLMDHTMLData(FHTMLDataArray[i]);
        if WordWrap then
        begin
          if (FOwner.ShowColumns) and (FOwner.HeaderSections.Count > i) then
            MaxWidth := FOwner.HeaderSections[i].Width
          else
            MaxWidth := FOwner.Width;
        end
        else
          MaxWidth := 0;

        FData.DefaultColor := FOwner.TextColor;
        if UseStyles and (i < StylesCount) then
        begin
          FData.DefaultStyle := Styles[i].FontStyles;
          FData.DefaultFont := Styles[i].FFontName;
//          FData.DefaultHeight:= Styles[i].FFontSize;
          FData.DefaultHeight:= -MulDiv(Styles[i].FFontSize, Screen.PixelsPerInch, 72);
          if not ParentColors then
            FData.DefaultColor := Styles[i].FTextColor;
        end
        else
        begin
          FData.DefaultStyle := FOwner.Font.Style;
          FData.DefaultFont  := FOwner.Font.Name;
          FData.DefaultHeight:= FOwner.Font.Height;
        end;
        FData.Charset      := FOwner.Font.Charset;
        FData.LinkStyle := FOwner.LinkStyle;
        FData.LinkColor := FOwner.LinkColor;

        FOwner.FView.FRender.PrepareToData(ColumnText[i], MaxWidth, WordWrap and Multiline, FData);
      end;
    end;
  end;
end;

procedure TElTreeItem.OnHTMLDataDestroy(Sender :TObject; Item : TLMDDataTag);
var FData : TLMDHTMLData;
begin
  FData := TLMDHTMLData(Item);
  if FOwner <> nil then
     FOwner.FView.FRender.DestroyData(FData)
  else
     FData.Free;
end;

procedure TElTreeItem.SetIsHTML(newValue: Boolean);
begin
  if (((FBoolData and ibfIsHTML) = ibfIsHTML) <> newValue) then
  begin
    if newValue then
      FBoolData := FBoolData or ibfIsHTML
    else
      FBoolData := FBoolData and not ibfIsHTML;

    FComplexHeight := (FComplexHeight and $FFFF0000) or WORD(-1);
    if NewValue then
    begin
      if FStaticDataEx <> nil then with FStaticDataEx do
        FBoolData1 := FBoolData1 or ibfHintIsHTML;
      FHTMLData      := nil;
      FHTMLDataArray := TLMDArray.Create;
      FHTMLDataArray.OnDelete := OnHTMLDataDestroy;
      ReRenderMainText;
      ReRenderAllTexts;
    end
    else
    begin
      if FHTMLData <> nil then
      begin
        if FOwner <> nil then
           FOwner.FView.FRender.DestroyData(FHTMLData)
        else
           FHTMLData.Free;
      end;
      FHTMLData := nil;
      FHTMLDataArray.Free;
      FHTMLDataArray := nil;
    end;

    if newValue then
      inc(FOwner.TotalVarHeightCount)
    else
      dec(FOwner.TotalVarHeightCount);

    if not (csDestroying in FOwner.ComponentState) then
    begin
      FOwner.IsUpdating := true;
      with FOwner do
        if (not FShowHeader) and FullyExpanded then
          FView.FHRange := -1;
      with FOwner.FView do
      begin
        FVisUpdated := true;
        FClearVis := true;
        FClearAll := true;
        FRangeUpdate := true;
        FOwner.FUpdated := true;
      end;
      FOwner.IsUpdating := false;
    end;
  end;  { if }
end;

function TElTreeItem.GetAncestor: TElTreeItem;
begin
  Result := Self;
  while Result.Parent <> nil do
    Result := Result.Parent;
end;

function TElTreeItem.CalcSubItemsHeight: Integer;
var
  Item : TElTreeItem;
  i    : integer;
begin
  Result := 0;
  if Expanded and (FChildren <> nil) then
  begin
    for i := 0 to FChildren.Count - 1 do
    begin
      Item := TElTreeItem(FChildren[i]);
      if Item.Hidden then
        Continue;
      inc(Result, Item.Height);
      if Item.Expanded then
        inc(Result, Item.CalcSubItemsHeight);
    end;
  end;
end;

procedure TElTreeItem.SetStrikedOutLine(const Value: boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfStrikedOutLine) = ibfStrikedOutLine) <> Value) then
    begin
      if Value then
        FBoolData1 := FBoolData1 or ibfStrikedOutLine
      else
        FBoolData1 := FBoolData1 and not ibfStrikedOutLine;
      UpdateItem;
    end;
  end;
end;

function TElTreeItem.GetStrikedOutLine: boolean;
begin
  if FStaticDataEx <> nil then
    Result := ((FStaticDataEx.FBoolData1 and ibfStrikedOutLine) = ibfStrikedOutLine)
  else
    Result := false;
end;

procedure TElTreeItem.SetDrawHLine(const Value: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfDrawHLine) = ibfDrawHLine) <> Value) then
    begin
      if Value then
        FBoolData1 := FBoolData1 or ibfDrawHLine
      else
        FBoolData1 := FBoolData1 and not ibfDrawHLine;

      UpdateItem;
    end;
  end;
end;

procedure TElTreeItem.SetAllowEdit(const Value: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfAllowEdit) = ibfAllowEdit) <> Value) then
    begin
      if Value then
        FBoolData1 := FBoolData1 or ibfAllowEdit
      else
        FBoolData1 := FBoolData1 and not ibfAllowEdit;
    end;
  end;
end;

procedure TElTreeItem.NewStaticData;
begin
  New(FStaticData);
  FillChar(FStaticData^, sizeof(TElTreeItemStaticData), 0);
  with FStaticData^ do
  begin
    FColText := TLMDMemoryStrings.Create;
    FColText.OnChange := OnColTextChange;
    FMainStyle := TElCellStyle.Create(Self);
    FMainStyle.FFontSize := FOwner.Font.Size;
    FMainStyle.FFontStyles := FOwner.Font.Style;
    FMainStyle.FFontName := FOwner.Font.Name;
    FMainStyle.FOwnerProps := true;
  end;
end;

procedure TElTreeItem.DisposeStaticData;
begin
  with FStaticData^ do
  begin
    if FColText <> nil then
      FColText.Free;
    if FMainStyle <> nil then
    begin
      FMainStyle.Free;
      FMainStyle := nil;
    end;
    if FStyles <> nil then
    begin
      FStyles.Free;
      FStyles := nil;
    end;
  end;
  Dispose(FStaticData);
  FStaticData := nil;
  end;

procedure TElTreeItem.FillStaticData;
begin
  // currently empty
end;

procedure TElTreeItem.NewStaticDataEx;
begin
  FStaticDataEx :=  TElTreeItemStaticDataEx.Create;
  with FStaticDataEx do
  begin
    FBoolData1 := ibfParentColors or ibfParentStyle or ibfCheckBoxEnabled or ibfShowCheckbox or
      ibfEnabled or ibfUseBkColor or ibfDrawHLine {or ibfAllowSelection }or ibfAllowEdit;
    FImageIndex := -1;
    FStImageIndex := -1;
    FImageIndex2 := -1;
    FStImageIndex2 := -1;
    FOverlayIndex := -1;
    FOverlayIndex2 := -1;
    FCheckBoxState := cbUnchecked;
    FCheckBoxType := ectCheckBox;
    FBorderSpaceColor := clWindow;
  end;
end;

procedure TElTreeItem.DisposeStaticDataEx;
begin
  FStaticDataEx.Free;
  FStaticDataEx := nil;
end;

function TElTreeItem.GetText: TLMDString;
begin
  if FStaticData <> nil then
    Result := FStaticData.FText
  else
    FOwner.TriggerVirtualTextNeeded(Self, -1, result);
end;

function TElTreeItem.GetColText: TLMDStrings;
begin
  if FStaticData <> nil then
    Result := FStaticData.FColText
  else
    Result := nil;
end;

function TElTreeItem.GetHint: TLMDString;
begin
  if FStaticData <> nil then
    Result := FStaticData.FHint
  else
    FOwner.TriggerVirtualHintNeeded(Self, Result);
end;

procedure TElTreeItem.SetHint(Value: TLMDString);
begin
  if FStaticData <> nil then
    FStaticData.FHint := Value;
end;

function TElTreeItem.GetMainStyle: TElCellStyle;
begin
  if FStaticData <> nil then
    Result := FStaticData.FMainStyle
  else
    Result := nil;
end;

procedure TElTreeItem.SetBorderStyle(Value: TElItemBorderStyle);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if FBorderStyle <> Value then
    begin
      FBorderStyle := Value;
      UpdateItem;
    end;
  end;
end;

function TElTreeItem.GetWidth: Integer;
var
  Size : TPoint;
begin
  FOwner.MeasureCell(Self, -1, FOwner.FView.ClientWidth, Size);
  result := Size.x;
end;

function TElTreeItem.GetDrawHLine: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfDrawHLine) = ibfDrawHLine
  else
    result := false;
end;

(*
function TElTreeItem.GetAllowSelection: Boolean;
begin
  Result := (FBoolData1 and ibfAllowSelection) = ibfAllowSelection;
end;

procedure TElTreeItem.SetAllowSelection(Value: Boolean);
begin
  if Value then
    FBoolData1 := FBoolData1 or ibfAllowSelection
  else
    FBoolData1 := FBoolData1 and not ibfAllowSelection;
end;
*)

function TElTreeItem.GetAllowEdit: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfAllowEdit) = ibfAllowEdit
  else
    Result := true;
end;

function TElTreeItem.GetParentStyle: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfParentStyle) = ibfParentStyle
  else
    Result := false;
end;

function TElTreeItem.GetUseStyles: Boolean;
begin
  if FStaticDataEx <> nil then
    result := (FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles
  else
    Result := false;
end;

function TElTreeItem.GetUseBkColor: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfUseBkColor) = ibfUseBkColor
  else
    Result := false;
end;

function TElTreeItem.GetParentColors: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfParentColors) = ibfParentColors
  else
    Result := false;
end;

function TElTreeItem.GetForceButtons: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfForceButtons) = ibfForceButtons
  else
    Result := false;
end;

function TElTreeItem.GetSuppressButtons: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := ((FStaticDataEx.FBoolData1 and ibfSuppressButtons) = ibfSuppressButtons) and
            ((Level > 0) or (FOwner.ShowRootButtons))
  else
    Result := false;
end;

function TElTreeItem.GetSuppressLines: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := ((FStaticDataEx.FBoolData1 and ibfSuppressLines) = ibfSuppressLines) and
            ((Level > 0) or (FOwner.ShowRoot))
  else
    Result := false;
end;

function TElTreeItem.GetIsHTML: Boolean;
begin
  Result := (FBoolData and ibfIsHTML) = ibfIsHTML;
end;

function TElTreeItem.GetMultiline: Boolean;
begin
  Result := (FBoolData and ibfMultiline) = ibfMultiline;
end;

function TElTreeItem.GetShowCheckBox: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfShowCheckbox) = ibfShowCheckbox
  else
    Result := false;
end;

function TElTreeItem.GetCheckBoxEnabled: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfCheckboxEnabled) = ibfCheckboxEnabled
  else
    Result := false;
end;

function TElTreeItem.GetEnabled: Boolean;
begin
  Result := (FBoolData and ibfEnabled) = ibfEnabled;
end;

function TElTreeItem.GetHidden: Boolean;
begin
  Result := (FBoolData and ibfHidden) = ibfHidden;
end;

procedure TElTreeItem.SetIndentAdjust(Value: Integer);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if IndentAdjust <> Value then
    begin
      FIndentAdjust := Value;
      with FOwner do
      begin
        if FShowHeader then
           AutoSizeColumn(FMainTreeCol)
        else
           FColSizeUpdate := true;
        if (not FShowHeader) and FullyExpanded then
          if FUpdateCount > 0 then
            FView.FHRange := -1
          else
            FView.DefineHRange;
      end;
      UpdateItem;
    end;
  end;
end;

function TElTreeItem.DisplayRect(TextOnly : boolean): TRect;
begin
  if not FOwner.IsInView(Self) then
  begin
    SetRectEmpty(Result);
    exit;
  end;
  result := FOwner.GetItemRect(FOwner.IndexInView(Self));
  if TextOnly then
  begin
    Result.Left := FTextRect.Left;
    Result.Right := FTextRect.Right;
  end;
end;

procedure TElTreeItem.EndEdit(ByCancel : boolean);
begin
  FOwner.EndEdit(ByCancel);
end;

function TElTreeItem.HasAsParent(Item : TElTreeItem): Boolean;
begin
  Result := IsUnder(Item);
end;

function TElTreeItem.IndexOf(Item : TElTreeItem): Integer;
begin
  if Item.IsUnder(Self) then
    result := Item.Index
  else
    result := -1;
end;

procedure TElTreeItem.MakeVisible;
begin
  FOwner.EnsureVisible(Self);
end;

function TElTreeItem.GetDropTarget: Boolean;
begin
  Result := FOwner.DropTarget = Self;
end;

function TElTreeItem.GetHintIsHTML: Boolean;
begin
  if FStaticDataEx <> nil then
    Result := (FStaticDataEx.FBoolData1 and ibfHintIsHTML) = ibfHintIsHTML
  else
    Result := (FBoolData and ibfIsHTML) = ibfIsHTML;
end;

procedure TElTreeItem.SetHintIsHTML(Value: Boolean);
begin
  if FStaticDataEx <> nil then
  with FStaticDataEx do
  begin
    if (((FBoolData1 and ibfHintIsHTML) = ibfHintIsHTML) <> Value) then
    begin
      if Value then
        FBoolData1 := FBoolData1 or ibfHintIsHTML
      else
        FBoolData1 := FBoolData1 and not ibfHintIsHTML;
    end;
  end;
end;

function TElTreeItem.GetTextDim(Index : integer): Integer;
begin
  case Index of
    1: result := FTextRect.Top;
    2: result := FTextRect.Right;
    3: result := FTextRect.Bottom;
    else result := FTextRect.Left;
  end;
end;

procedure TElTreeItem.SetIndex(Value: Integer);
begin
  if Value <> index then
  begin
    if (Value < 0) or (Value > FParent.Count - 1) then
      raise EElTreeError.Create(STExOutOfBounds);
    MoveToIns(Parent, Value);
  end;
end;

function TElTreeItem.GetColor(Index: Integer): TColor;
begin
  if FStaticDataEx <> nil then with FStaticDataEx do
  begin
    case Index of
      1: result := FColor;
      2: result := FBkColor;
      3: result := FRowBkColor;
      4: result := FBorderSpaceColor;
      5: result := FStrikedLineColor;
      else
        result := clBlack;
    end;
  end
  else
    Result := clBlack;
end;

function TElTreeItem.GetImageIndex(Index: Integer): Integer;
begin
  if FStaticDataEx <> nil then
    case Index of
      0: Result := FStaticDataEx.FImageIndex;
      1: Result := FStaticDataEx.FImageIndex2;
      2: Result := FStaticDataEx.FStImageIndex;
      3: Result := FStaticDataEx.FStImageIndex2;
      4: begin
           Result := FStaticDataEx.FOverlayIndex;
           if (Result < 0) or (Result > 3) then
             Result := -1;
         end;
      5: begin
           Result := FStaticDataEx.FOverlayIndex2;
           if (Result<0)or(Result>3) then
             Result := -1;
         end;
      else
        Result := -1;
    end
  else
    Result := -1;
end;

function TElTreeItem.GetCheckBoxState: TCheckBoxState;
begin
  if FStaticDataEx <> nil then
    Result := FStaticDataEx.FCheckBoxState
  else
    Result := cbUnchecked;
end;

function TElTreeItem.GetCheckBoxType: TElCheckBoxType;
begin
  if FStaticDataEx <> nil then
    Result := FStaticDataEx.FCheckBoxType
  else
    Result := ectCheckbox;
end;

function TElTreeItem.GetIndentAdjust: Integer;
begin
  if FStaticDataEx <> nil then
    Result := FStaticDataEx.FIndentAdjust
  else
    Result := 0;
end;

function TElTreeItem.GetBorderStyle: TElItemBorderStyle;
begin
  if FStaticDataEx <> nil then
    Result := FStaticDataEx.FBorderStyle
  else
    Result := ibsNone;
end;

function TElTreeItem.GetFocused: Boolean;
begin
  Result := (FBoolData and ibfFocused) <> 0;
end;

procedure TElTreeItem.SetFocused(Value: Boolean);
begin
  if (value = false) then
  begin
    if FOwner.ItemFocused = Self then
       FOwner.ItemFocused := nil;
  end
  else
     FOwner.ItemFocused := self;
end;

procedure TElTreeItem.UpdateInfo(PropTypes : TElVirtPropTypes);
var UpdItem : boolean;
    UpdCache: boolean;
begin
  if (FOwner <> nil) and (FOwner.FVirtualityLevel > vlNone) then
  begin
    UpdItem := false;
    UpdCache:= false;
    FOwner.IsUpdating := true;

    try

      if vptMainText in PropTypes then
        UpdateChangedMainText;

      if vptCellText in PropTypes then
      begin
        UpdateChangedCellText;
        UpdItem := true;
      end;

      if vptStyles in PropTypes then
      begin
        if (FOwner.FVirtualityLevel >= vlAllProps) and (not (csDesigning in FOwner.ComponentState)) then
          UpdCache := true
        else
        if FStaticDataEx.UseStyles then
          UpdItem  := true;
      end;

      if (FOwner.FVirtualityLevel >= vlAllProps) and (not (csDesigning in FOwner.ComponentState)) then
        if (PropTypes * [vptFontStyle, vptVisual, vptSelection, vptCheck, vptButtons, vptImages, vptColors, vptIndent]) <> [] then
          UpdCache := true;

      if vptFontStyle in PropTypes then
      begin
        if (not FOwner.FShowHeader) and FullyExpanded then
          FOwner.FView.FHRange := -1;
      end;

      if vptVisual in PropTypes then
        UpdItem := true;

      if vptSelection in PropTypes then
        UpdItem := true;

      if vptCheck in PropTypes then
      begin
        FOwner.FColSizeUpdate := true;
        if (not FOwner.FShowHeader) and FullyExpanded then
          FOwner.FView.FHRange := -1;
        UpdItem := true;
      end;

      if vptButtons in PropTypes then
      begin
        with FOwner do
        begin
          FColSizeUpdate := true;
          if (not FShowHeader) and FullyExpanded then
            FView.FHRange := -1
        end;
        UpdItem := true;
      end;

      if vptImages in PropTypes then
      begin
        with FOwner do
          if FShowImages then
          begin
            FColSizeUpdate := true;
            if (not FShowHeader) and FullyExpanded then
              FView.FHRange := -1;
          end;
        UpdItem := true;
      end;

      if vptColors in PropTypes then
        UpdItem := true;

      if vptIndent in PropTypes then
      begin
        with FOwner do
        begin
          FColSizeUpdate := true;
          if (not FShowHeader) and FullyExpanded then
            FView.FHRange := -1;
        end;
        UpdItem := true;
      end;

      if (FOwner.FVirtualityLevel >= vlAllProps) and (not (csDesigning in FOwner.ComponentState)) and UpdCache then
      begin
        if FStaticDataEx <> nil then
          FOwner.TriggerVirtualPropsNeeded(Self, PropTypes, FStaticDataEx);
      end;

      if UpdItem then
        UpdateItem;
    finally
      FOwner.IsUpdating := false;
    end;
  end;
end;

procedure TElTreeItem.UpdateChangedMainText;
begin
  with FOwner do
  begin
    if (not FShowHeader) and FullyExpanded then
    begin
      if FUpdateCount > 0 then
        FView.FHRange := -1
      else
        FView.DefineHRange;
      FView.FRangeUpdate := true;
      FOwner.FUpdated := true;
    end;
    if (FSortMode = smAdd) or (FSortMode = smAddClick) then
    begin
      if (FMainTreeCol = FSortSection) or (FSortSection = -1) then
      begin
        if FUpdateCount > 0 then
           FSortRequired := true
        else
        begin
          FOwner.TriggerSortBegin;
          FParent.Sort(false);
          FOwner.TriggerSortBegin;
        end;
      end;
    end;
    if FShowHeader and (FUpdateCount = 0) then
       AutoSizeColumn(FMainTreeCol)
    // bug fix
    else
    if FShowHeader then
    begin
      FOwner.FUpdated := true;
      FOwner.FColSizeUpdate := true;
    end;
  end;

  if (Multiline and FOwner.AdjustMultilineHeight)
      or IsHTML
      then
  begin
    if IsHTML then ReRenderMainText;
    FComplexHeight := (FComplexHeight and $FFFF0000) or WORD(-1);
    //FRealHeight := -1;

    with FOwner.FView do
    begin
      FVisUpdated := true;
      FClearVis := true;
      FClearAll := true;
      FRangeUpdate := true;
    end;
  end;
  end;

procedure TElTreeItem.UpdateChangedCellText;
begin
  with FOwner do
  if (FSortMode = smAdd) or (FSortMode = smAddClick) then
  begin
    if LMDInRange(FSortSection, -1, FHeader.Sections.Count - 1) then
    begin
      if FParent <> nil then
      begin
        if FUpdateCount > 0 then
           FSortRequired := true
        else
        begin
          FOwner.TriggerSortBegin;
          FParent.Sort(false);
          FOwner.TriggerSortBegin;
        end;
      end;
    end;
  end;
  with FOwner do
    if FShowHeader and (FUpdateCount = 0) then
       AutoSizeAllColumns
    else
    begin
      FOwner.FUpdated := true;
      FColSizeUpdate := true;
    end;
  if (Multiline and FOwner.AdjustMultilineHeight)
      or IsHTML
      then
  begin
    FComplexHeight := (FComplexHeight and $FFFF0000) or word(-1);
    if (FBoolData and ibfIsHTML) = ibfIsHTML then
      ReRenderAllTexts;
    FOwner.IsUpdating := true;
    with FOwner.FView do
    begin
      FVisUpdated := true;
      FClearVis := true;
      FClearAll := true;
      FRangeUpdate := true;
    end;
    FOwner.FUpdated := true;
    FOwner.IsUpdating := false;
  end;
  end;

procedure TElTreeItem.AllocateStorage(MaxItems : integer);
begin
  if FChildren = nil then
    FChildren := TLMDObjectList.Create;
  FChildren.Capacity := max(FChildren.Capacity, MaxItems);
end;

procedure TElTreeItem.NewVirtualSort;
begin
  with FOwner do
  begin
    if (FSortMode = smAdd) or (FSortMode = smAddClick) then
    begin
      if (FMainTreeCol = FSortSection) or (FSortSection = -1) then
      begin
        if FUpdateCount > 0 then
           FSortRequired := true
        else
        begin
          TriggerSortBegin;
          Self.FParent.Sort(false);
          TriggerSortBegin;
        end;
      end;
    end;
  end;
end;

function TElTreeItem.IsFirstChild: Boolean;
begin
  Result := Self = FParent.FChildren.First;
end;

function TElTreeItem.IsLastChild: Boolean;
begin
  Result := Self = FParent.FChildren.Last;
end;

procedure TElTreeItem.SetWordWrap(Value: Boolean);
begin
  if (((FBoolData and ibfWordWrap) = ibfWordWrap) <> Value) then
  begin
    if Value then
      FBoolData := FBoolData or ibfWordWrap
    else
      FBoolData := FBoolData and not ibfWordWrap;

    if Multiline then
    begin
      FOwner.IsUpdating := true;
      with FOwner do
      begin
        if (not FShowHeader) and FullyExpanded then
        begin
          if FUpdateCount > 0 then
            FView.FHRange := -1
          else
            FView.DefineHRange;
          FView.FRangeUpdate := true;
          FOwner.FUpdated := true;
        end;
        if FShowHeader then
        begin
          FOwner.FUpdated := true;
          FOwner.FColSizeUpdate := true;
        end;
      end;

      if (Multiline and FOwner.AdjustMultilineHeight)
          or IsHTML
          then
      begin
        FComplexHeight := (FComplexHeight and $FFFF0000) or word(-1);
        if (FBoolData and ibfIsHTML) = ibfIsHTML then
          ReRenderAllTexts;
        with FOwner.FView do
        begin
          FVisUpdated := true;
          FClearVis := true;
          FClearAll := true;
          FRangeUpdate := true;
        end;
      end;
      FOwner.IsUpdating := false;
    end;
    end;
end;

function TElTreeItem.GetWordWrap: Boolean;
begin
  Result := (FBoolData and ibfWordWrap) = ibfWordWrap;
end;

function TElTreeItem.GetWholeLine: Boolean;
begin
  Result := (FBoolData and ibfWholeLine) = ibfWholeLine;
end;

procedure TElTreeItem.SetWholeLine(Value: Boolean);
begin
  if (((FBoolData and ibfWholeLine) = ibfWholeLine) <> Value) then
  begin
    if Value then
      FBoolData := FBoolData or ibfWholeLine
    else
      FBoolData := FBoolData and not ibfWholeLine;

    if FOWner.FShowHeader then
    with FOwner do
    begin
      IsUpdating := true;

      if (FUpdateCount = 0) then
         AutoSizeColumn(FMainTreeCol)
      else
      if FShowHeader then
      begin
        FOwner.FUpdated := true;
        FOwner.FColSizeUpdate := true;
      end;

      if Multiline then
        FComplexHeight := (FComplexHeight and $FFFF0000) or WORD(-1);

      if (Multiline and FOwner.AdjustMultilineHeight)
          or IsHTML
          then
      begin
        if IsHTML then ReRenderMainText;
        FComplexHeight := (FComplexHeight and $FFFF0000) or WORD(-1);
        //FRealHeight := -1;

        with FOwner.FView do
        begin
          FVisUpdated := true;
          FClearVis := true;
          FClearAll := true;
          FRangeUpdate := true;
        end;
      end;
      IsUpdating := false;
    end;
  end;
end;

// ****************************************************************************
//                               TElTreeItems
// ****************************************************************************

constructor TElTreeItems.CreateClass(AOwner: TCustomElTree; ItemClass : TElTreeItemClass);
begin
  inherited Create;
  FOwner := AOwner;
  FItemClass := ItemClass;
  Init;
end;

constructor TElTreeItems.Create(AOwner: TCustomElTree);
begin
  inherited Create;
  FOwner := AOwner;
  Init;
end;

destructor TElTreeItems.Destroy;
begin
  FOwner.IsUpdating := true;
  FRoot.DisposeStaticData;
  FRoot.Clear;
  FRoot.Free;
  inherited Destroy;
end;

procedure TElTreeItems.Init;
begin
  if FItemClass = nil then
    FItemClass := TElTreeItem;
  FRoot := FItemClass.Create(FOwner);
  FRoot.FList := self;
  FRoot.FParent := nil;
  FRoot.FRoot := FRoot;
  FRoot.NewStaticData;
  FRoot.FBoolData := FRoot.FBoolData or ibfExpanded or ibfEnabled;
end;

function TElTreeItems.GetVisCount: integer;
begin
  result := FOwner.TotalVisCount;
end;

procedure TElTreeItems.DefineProperties(Filer: TFiler);

  function WriteNodes: Boolean;
  begin
    Result := Count > 0;
  end;

begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('Data', ReadData, WriteData, WriteNodes);
end;

procedure TElTreeItems.SetItem(Index: Integer; Value: TElTreeItem);
begin
  GetItem(Index).Assign(Value);
end;

procedure TElTreeItems.Iterate(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElIterateProc; IterateData: TLMDDataTag);
var
  j: integer;
  DoContinue: boolean;

  procedure IntIterate(VisibleOnly, CheckCollapsed: boolean; Item: TElTreeItem); (*<+>*)
  var
    i, k: integer;
  begin
    inc(j);
    if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then IterateProc(Item, j, DoContinue, IterateData, FOwner);
    if not (DoContinue) then exit;
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if CheckCollapsed or (Item.Expanded) then  (*<+>*)
    begin
      if Item.FChildren = nil then
         k := 0
      else
         k := Item.FChildren.Count;
      for i := 0 to k - 1 do
      begin
        if (not VisibleOnly) or ((not TElTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
          IntIterate(VisibleOnly, CheckCollapsed, TElTreeItem(Item.FChildren.List[i])); (*<+>*)
        if not (DoContinue) then exit;
      end;
    end;
  end;

begin
  j := -2;
  DoContinue := true;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot);
end;

procedure TElTreeItems.IterateBranch(VisibleOnly: boolean; IterateProc: TElIterateProc; IterateData: TLMDDataTag; BranchParent: TElTreeItem);
var
  j: integer;
  DoContinue: boolean;
  Stack: TElStack;
  TSI: TElTreeItem;

  procedure IntIterate(VisibleOnly: boolean; Item: TElTreeItem; StartFrom: TElTreeItem; var Stack: TElStack);
  var
    i, k, l: integer;
  begin
    inc(j);
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
         k := -1
      else
         k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
      begin
        Stack.Free;
        Stack := nil;
      end;
    end
    else
    begin
      if not Item.IsUnder(StartFrom) then
         DoContinue := false
      else
        if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
           IterateProc(Item, j, DoContinue, IterateData, FOwner);
      if not (DoContinue) then
         exit;
      k := 0;
    end;
    if (not (VisibleOnly)) or (Item.Expanded) then
    begin
      if Item.FChildren = nil then
         l := 0
      else
         l := Item.FChildren.Count;
      if k <> - 1 then
        for i := k to l - 1 do
        begin
          if (not VisibleOnly) or ((not TElTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
              IntIterate(VisibleOnly, TElTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
          if not DoContinue then
             exit;
        end;
    end;
  end;

begin
  j := -2;
  if BranchParent <> nil then
  begin
    Stack := TElStack.Create;
    TSI := BranchParent;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
    DoContinue := true;
    IntIterate(VisibleOnly, FRoot, BranchParent, Stack);
    Stack.Free;
  end
  else
    Iterate(VisibleOnly, not VisibleOnly, IterateProc, IterateData); (*<+>*)
end;

procedure TElTreeItems.IterateFrom(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElIterateProc; IterateData: TLMDDataTag; StartFrom: TElTreeItem);
var
  j: integer;
  DoContinue: boolean;
  Stack: TElStack;
  TSI: TElTreeItem;

  procedure IntIterate(VisibleOnly, CheckCollapsed: boolean; Item: TElTreeItem; StartFrom: TElTreeItem; var Stack: TElStack); (*<+>*)
  var
    i, k, l: integer;
  begin
    inc(j);
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
        k := -1
      else
        k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
      begin
        Stack.Free;
        Stack := nil;
      end;
    end
    else
    begin
      if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
        IterateProc(Item, j, DoContinue, IterateData, FOwner);
      if not (DoContinue) then exit;
      k := 0;
    end;
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if CheckCollapsed or (Item.Expanded) then
    begin
      if Item.FChildren = nil
         then l := 0
      else
         l := Item.FChildren.Count;
      if k <> - 1 then
        for i := k to l - 1 do
        begin
          if (not VisibleOnly) or ((not TElTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
            IntIterate(VisibleOnly, CheckCollapsed, TElTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
          if not (DoContinue) then exit;
        end;
    end;
  end;

begin
  j := -2;
  if StartFrom <> nil then
  begin
    Stack := TElStack.Create;
    TSI := StartFrom;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
  end
  else
    Stack := nil;
  DoContinue := true;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot, StartFrom, Stack); (*<+>*)
  if Stack <> nil then Stack.Free;
end;

procedure TElTreeItems.IterateBack(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElIterateProc; IterateData: TLMDDataTag);
var
  j: integer;
  DoContinue: boolean;

  procedure IntIterate(VisibleOnly, CheckCollapsed: boolean; Item: TElTreeItem);  (*<+>*)
  var
    i, k: integer;
  begin
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if CheckCollapsed or (Item.Expanded) then (*<+>*)
    begin
      if Item.FChildren = nil then
        k := 0
      else
        k := Item.FChildren.Count;
      for i := k - 1 downto 0 do
      begin
        if (not VisibleOnly) or ((not TElTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
           IntIterate(VisibleOnly, CheckCollapsed, TElTreeItem(Item.FChildren.List[i])); (*<+>*)
        if not (DoContinue) then exit;
      end;
    end;
    dec(j);
    if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
       IterateProc(Item, j, DoContinue, IterateData, FOwner);
    if not (DoContinue) then exit;
  end;

begin
  if VisibleOnly then
     j := FOwner.TotalVisCount
  else
     j := FOwner.FAllList.Count;
  DoContinue := true;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot); (*<+>*)
end;

// Changed 10/28/98 by EM

procedure TElTreeItems.IterateBackFrom(VisibleOnly, CheckCollapsed: boolean; IterateProc: TElIterateProc; IterateData: TLMDDataTag; StartFrom: TElTreeItem);
var
  j: integer;
  DoContinue: boolean;
  Stack: TElStack;
  TSI: TElTreeItem;

  procedure IntIterate(VisibleOnly, CheckCollapsed: boolean; Item: TElTreeItem; StartFrom: TElTreeItem; var Stack: TElStack); (*<+>*)
  var
    i, k: integer;
  begin
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
        k := -1
      else
        k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
      begin
        Stack.Free;
        Stack := nil;
      end;
    end
    else
    begin
      if Item.FChildren = nil then k := -1 else k := Item.FChildren.Count - 1;
    end;
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if (CheckCollapsed or Item.Expanded) and (Item <> StartFrom) then (*<+>*)
      for i := k downto 0 do
      begin
        if (not VisibleOnly) or
           ((not TElTreeItem(Item.FChildren.List[i]).Hidden) or
           (not FOwner.FilteredVisibility)) then
          IntIterate(VisibleOnly, CheckCollapsed, TElTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
        if not (DoContinue) then exit;
      end;
    dec(j);
    if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or
       (not FOwner.FilteredVisibility))) and (Item <> FRoot) then
      IterateProc(Item, j, DoContinue, IterateData, FOwner);
    if (not DoContinue) then exit;
  end;

begin
  if VisibleOnly then
     j := FOwner.TotalVisCount
  else
     j := FOwner.FAllList.Count;
  if StartFrom <> nil then
  begin
    Stack := TElStack.Create;
    TSI := StartFrom;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
  end else Stack := nil;
  DoContinue := true;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot, StartFrom, Stack);
  if Stack <> nil then Stack.Free;
end;

procedure TElTreeItems.Iterate(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElIterateMethod; IterateData:  TLMDDataTag );
var
  j: integer;
  DoContinue: boolean;

  procedure IntIterate(VisibleOnly, CheckCollapsed: boolean; Item: TElTreeItem); (*<+>*)
  var
    i, k: integer;
  begin
    inc(j);
    if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then IterateMethod(Item, j, DoContinue, IterateData, FOwner);
    if not (DoContinue) then exit;
    if CheckCollapsed or (Item.Expanded) then  (*<+>*)
    begin
      if Item.FChildren = nil then
         k := 0
      else
         k := Item.FChildren.Count;
      for i := 0 to k - 1 do
      begin
        if (not VisibleOnly) or ((not TElTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
          IntIterate(VisibleOnly, CheckCollapsed, TElTreeItem(Item.FChildren.List[i])); (*<+>*)
        if not (DoContinue) then exit;
      end;
    end;
  end;

begin
  j := -2;
  DoContinue := true;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot);
end;

procedure TElTreeItems.IterateBack(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElIterateMethod; IterateData:TLMDDataTag);
var
  j: integer;
  DoContinue: boolean;

  procedure IntIterate(VisibleOnly, CheckCollapsed: boolean; Item: TElTreeItem);  (*<+>*)
  var
    i, k: integer;
  begin
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if CheckCollapsed or (Item.Expanded) then (*<+>*)
    begin
      if Item.FChildren = nil then
        k := 0
      else
        k := Item.FChildren.Count;
      for i := k - 1 downto 0 do
      begin
        if (not VisibleOnly) or ((not TElTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
           IntIterate(VisibleOnly, CheckCollapsed, TElTreeItem(Item.FChildren.List[i])); (*<+>*)
        if not (DoContinue) then exit;
      end;
    end;
    dec(j);
    if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
       IterateMethod(Item, j, DoContinue, IterateData, FOwner);
    if not (DoContinue) then exit;
  end;
begin
  if VisibleOnly then
     j := FOwner.TotalVisCount
  else
     j := FOwner.FAllList.Count;
  DoContinue := true;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot); (*<+>*)
end;

procedure TElTreeItems.IterateFrom(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElIterateMethod; IterateData:TLMDDataTag; StartFrom: TElTreeItem);
var
  j: integer;
  DoContinue: boolean;
  Stack: TElStack;
  TSI: TElTreeItem;

  procedure IntIterate(VisibleOnly, CheckCollapsed: boolean; Item: TElTreeItem; StartFrom: TElTreeItem; var Stack: TElStack); (*<+>*)
  var
    i, k, l: integer;
  begin
    inc(j);
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
        k := -1
      else
        k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
      begin
        Stack.Free;
        Stack := nil;
      end;
    end
    else
    begin
      if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
        IterateMethod(Item, j, DoContinue, IterateData, FOwner);
      if not (DoContinue) then exit;
      k := 0;
    end;
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if CheckCollapsed or (Item.Expanded) then
    begin
      if Item.FChildren = nil
         then l := 0
      else
         l := Item.FChildren.Count;
      if k <> - 1 then
        for i := k to l - 1 do
        begin
          if (not VisibleOnly) or ((not TElTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
            IntIterate(VisibleOnly, CheckCollapsed, TElTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
          if not (DoContinue) then exit;
        end;
    end;
  end;

begin
  j := -2;
  if StartFrom <> nil then
  begin
    Stack := TElStack.Create;
    TSI := StartFrom;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
  end
  else
    Stack := nil;
  DoContinue := true;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot, StartFrom, Stack); (*<+>*)
  if Stack <> nil then Stack.Free;
end;

procedure TElTreeItems.IterateBackFrom(VisibleOnly, CheckCollapsed: boolean; IterateMethod: TElIterateMethod; IterateData:TLMDDataTag; StartFrom: TElTreeItem);
var
  j: integer;
  DoContinue: boolean;
  Stack: TElStack;
  TSI: TElTreeItem;

  procedure IntIterate(VisibleOnly, CheckCollapsed: boolean; Item: TElTreeItem; StartFrom: TElTreeItem; var Stack: TElStack); (*<+>*)
  var
    i, k: integer;
  begin
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
        k := -1
      else
        k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
      begin
        Stack.Free;
        Stack := nil;
      end;
    end
    else
    begin
      if Item.FChildren = nil then k := -1 else k := Item.FChildren.Count - 1;
    end;
    // check for (not VisibleOnly) removed - it was a error, think of it and you will see :)
    // besides it checked in the condition for the call to IntInterate, that's the right place.
    if (CheckCollapsed or Item.Expanded) and (Item <> StartFrom) then (*<+>*)
      for i := k downto 0 do
      begin
        if (not VisibleOnly) or
           ((not TElTreeItem(Item.FChildren.List[i]).Hidden) or
           (not FOwner.FilteredVisibility)) then
          IntIterate(VisibleOnly, CheckCollapsed, TElTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
        if not (DoContinue) then exit;
      end;
    dec(j);
    if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or
       (not FOwner.FilteredVisibility))) and (Item <> FRoot) then
      IterateMethod(Item, j, DoContinue, IterateData, FOwner);
    if (not DoContinue) then exit;
  end;

begin
  if VisibleOnly then
     j := FOwner.TotalVisCount
  else
     j := FOwner.FAllList.Count;
  if StartFrom <> nil then
  begin
    Stack := TElStack.Create;
    TSI := StartFrom;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
  end else Stack := nil;
  DoContinue := true;
  IntIterate(VisibleOnly, CheckCollapsed, FRoot, StartFrom, Stack);
  if Stack <> nil then Stack.Free;
end;

procedure TElTreeItems.IterateBranch(VisibleOnly: boolean; IterateMethod: TElIterateMethod; IterateData:TLMDDataTag; BranchParent: TElTreeItem);
var
  j: integer;
  DoContinue: boolean;
  Stack: TElStack;
  TSI: TElTreeItem;

  procedure IntIterate(VisibleOnly: boolean; Item: TElTreeItem; StartFrom: TElTreeItem; var Stack: TElStack);
  var
    i, k, l: integer;
  begin
    inc(j);
    if (Stack <> nil) and (Stack.Count > 0) then
    begin
      if Item.FChildren = nil then
         k := -1
      else
         k := Item.FChildren.IndexOf(Stack.Pop);
      if Stack.Count = 0 then
      begin
        Stack.Free;
        Stack := nil;
      end;
    end
    else
    begin
      if not Item.IsUnder(StartFrom) then
         DoContinue := false
      else
        if (j >= 0) and ((not VisibleOnly) or ((not Item.Hidden) or (not FOwner.FilteredVisibility))) then
           IterateMethod(Item, j, DoContinue, IterateData, FOwner);
      if not (DoContinue) then
         exit;
      k := 0;
    end;
    if (not (VisibleOnly)) or (Item.Expanded) then
    begin
      if Item.FChildren = nil then
         l := 0
      else
         l := Item.FChildren.Count;
      if k <> - 1 then
        for i := k to l - 1 do
        begin
          if (not VisibleOnly) or ((not TElTreeItem(Item.FChildren.List[i]).Hidden) or (not FOwner.FilteredVisibility)) then
              IntIterate(VisibleOnly, TElTreeItem(Item.FChildren.List[i]), StartFrom, Stack);
          if not DoContinue then
             exit;
        end;
    end;
  end;

begin
  j := -2;
  if BranchParent <> nil then
  begin
    Stack := TElStack.Create;
    TSI := BranchParent;
    Stack.Push(TSI);
    while TSI.Parent <> nil do
    begin
      Stack.Push(TSI.Parent);
      TSI := TSI.Parent;
    end; // while
    DoContinue := true;
    IntIterate(VisibleOnly, FRoot, BranchParent, Stack);
    Stack.Free;
  end
  else
    Iterate(VisibleOnly, not VisibleOnly, IterateMethod, IterateData);
end;

function TElTreeItems.GetVisItem;
var i, j, idx : integer;
    Item : TElTreeItem;
begin
  if (index < 0) or (index >= FOwner.TotalVisCount) then
  begin
    result := nil;
    exit;
  end;

  i := 0;
  idx := 0;
  j := FOwner.FAllList.Count;
  while i < j do
  begin
    Item := TElTreeItem(FOwner.FAllList[i]);
    if (FOwner.FilteredVisibility and Item.Hidden) then
    begin
      i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end else
    begin
      if idx = index then
      begin
        result := Item;
        exit;
      end;
      inc(idx);
      if not Item.Expanded then
         i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    inc(i);
  end;
  result := nil;
end;

function TElTreeItems.GetItem;
begin
  if (index < 0) or (index >= Integer(Count)) then
  begin
    result := nil;
    exit;
  end;
  result := TElTreeItem(FOwner.FAllList.List[index]);
end;

function TElTreeItems.GetVisIndex;
var i, j, idx : integer;
    Item : TElTreeItem;

begin
  if Child = nil then
  begin
    result := -1;
    exit;
  end;

  i := 0;
  idx := 0;
  j := FOwner.FAllList.Count;
  while i < j do
  begin
    Item := TElTreeItem(FOwner.FAllList[i]);
    if (FOwner.FilteredVisibility and Item.Hidden) then
    begin
      i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end else
    begin
      if Child = Item then
      begin
        result := idx;
        exit;
      end;
      inc(idx);
      if not Item.Expanded then
         i := FOwner.FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    inc(i);
  end;
  result := -1;
end;

function TElTreeItems.GetAbsIndex;
begin
  if Child = nil then
    result := -1
  else
    result := FOwner.FAllList.IndexOf(Child);
end;

procedure TElTreeItems.DeleteItem;
var
  TSI: TElTreeItem;
begin
  if (Child = nil) or (child = FRoot) then exit;
  FOwner.IsUpdating := true;
  try
    if Child.Selected then
      Child.Selected := False;
//    if not FOwner.FMultiSelect then
//      FOwner.View.FSelected := nil;
    TSI := Child.FParent;
    TSI.DeleteChild(Child);
    if TSI.FullyExpanded and TSI.Expanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := true;
        FClearAll := true;
        FVisUpdated := true;
      end;
      FOwner.FUpdated := true;
    end;
  finally
    FOwner.IsUpdating := false;
  end;
end;

procedure TElTreeItems.AllocateStorage(MaxItems : integer);
var NewCapacity : longint;
begin
  NewCapacity := (MaxItems + (AlignMem - 1)) and not (AlignMem - 1);
  with FOwner do
    if FAllList.Capacity < NewCapacity then
      FAllList.Capacity := NewCapacity;
end;

procedure TElTreeItems.AllocateStorageInRoot(MaxItems : integer);
begin
  FRoot.AllocateStorage(MaxItems);
end;

procedure TElTreeItems.RemoveItem;
var
  TSI: TElTreeItem;
begin
  if (Child = nil) or (child = FRoot) then exit;
  FOwner.IsUpdating := true;
  try
    TSI := Child.FParent;
    TSI.RemoveSubChild(Child);
    TSI.RemoveChild(Child);
{
    Child.FParent := nil;
    Child.FRoot := nil;
    Child.FOwner := nil;
}
    if TSI.FullyExpanded and TSI.Expanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := true;
        FClearAll := true;
        FVisUpdated := true;
      end;
      FOwner.FUpdated := true;
    end;
  finally
    FOwner.IsUpdating := false;
  end;
end;

procedure TElTreeItems.AddExistingItem(Item, Parent: TElTreeItem); { public }
var
  Child, AParent: TElTreeItem;
  i: integer;
begin
  FOwner.IsUpdating := true;
  Child := Item;
  if Parent = nil then
  begin
    Child.FParent := FRoot;
    Child.FList := self;
    Child.FRoot := FRoot;
  end else
  begin
    Child.FParent := Parent;
    Child.FList := Parent.FList; { := self}
    Child.FRoot := Parent.FRoot; { := FRoot}
  end;
  AParent := Child.FParent;
  Child.FOwner := AParent.FOwner;
  AParent.AddChild(Child);
  //inc(FCount);
  if Child.FChildren <> nil then
    for i := Child.FChildren.Count-1 downto 0 do
      Child.AddExistingChild(TElTreeItem(Child.FChildren.Items[i]));
  with
   FOwner do
  begin
    if AParent.FullyExpanded and AParent.Expanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := true;
        FVisUpdated := true;
      end;
    end;

    if not Child.OwnerHeight then
       inc(TotalVarHeightCount);
    if Child.Multiline and FAdjustMultilineHeight then
       inc(TotalVarHeightCount);

    if (Child.FBoolData and ibfIsHTML) = ibfIsHTML then
       inc(TotalVarHeightCount);

    FUpdated := true;
    FView.FRangeUpdate := true;
    IsUpdating := false;
  end;
end;

procedure TElTreeItems.InsertExistingItem(Item, Parent: TElTreeItem; Index: integer); { public }
var
  Child, AParent: TElTreeItem;
begin
  if parent = nil then AParent := FRoot else AParent := parent;

  if (index > AParent.Count) or (index < 0) then
    raise EElTreeError.Create(STExOutOfBounds);
  Child := Item;
  AddExistingItem(Child, AParent);
  Child.MoveToItem(AParent.Children[Index], naInsert);
end;

function TElTreeItems.InsertItem;
var
  Child, AParent: TElTreeItem;
begin
  FOwner.IsUpdating := true;
  Child := CreateItem(FOwner);
  Child.FList := self;
  Child.FParent := Parent;
  if Child.FParent = nil then Child.FParent := FRoot;
  AParent := Child.FParent;
  if (AParent.FChildren = nil) then AParent.FChildren := TLMDObjectList.Create;
  if (index > AParent.FChildren.Count) or (index < 0) then
    raise EElTreeError.Create(STExOutOfBounds);
  AParent.InsertChild(Index, Child);
  //inc(FCount);

  result := Child;
  with FOwner do
  begin
    if AParent.FullyExpanded and AParent.Expanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := true;
        FClearAll := true;
        FVisUpdated := true;
      end;
    end;
    with FOwner.FView do
    begin
      FUpdated := true;
      FRangeUpdate := true;
    end;
    IsUpdating := false;
  end;
end;

function TElTreeItems.AddLastItem(Parent: TElTreeItem): TElTreeItem;
var
  Child, AParent: TElTreeItem;
begin
  FOwner.IsUpdating := true;
  Child := CreateItem(FOwner);
  Child.FList := self;
  Child.FParent := Parent;
  if Child.FParent = nil then Child.FParent := FRoot;
  AParent := Child.FParent;
  AParent.AddLastChild(Child);
  //inc(FCount);
  result := Child;
  with FOwner do
  begin
    if AParent.Expanded and AParent.FullyExpanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := true;
        FVisUpdated := true;
      end;
    end;
    with FOwner.FView do
    begin
      FUpdated := true;
      FRangeUpdate := true;
    end;
    IsUpdating := false;
  end;
end;

function TElTreeItems.AddItem;
var
  Child, AParent: TElTreeItem;
begin
  FOwner.IsUpdating := true;
  Child := CreateItem(FOwner);
  Child.FList := self;
  Child.FParent := Parent;
  if Child.FParent = nil then
    Child.FParent := FRoot;
  AParent := Child.FParent;
  AParent.AddChild(Child);
  //inc(FCount);
  result := Child;
  with FOwner do
  begin
    if AParent.Expanded and AParent.FullyExpanded then
    begin
      with FOwner.FView do
      begin
        FClearVis := true;
        FVisUpdated := true;
      end;
    end;
    with FOwner.FView do
    begin
      FUpdated := true;
      FRangeUpdate := true;
    end;
    IsUpdating := false;
  end;
end;

procedure TElTreeItems.Assign;
begin
  if Source is TElTreeItems then
  begin
    if FOwner <> nil then
      FOwner.IsUpdating := true;
    FRoot.Assign(TElTreeItems(Source).FRoot);
    //FCount := TElTreeItems(Source).FCount;
    if FOwner <> nil then
      with FOwner.FView do
      begin
        FHRange  := -1;
        FOwner.FUpdated := true;
        FVisUpdated := true;
        FClearVis := true;
        FClearAll := true;
        FOwner.IsUpdating := false;
      end;
  end
  else
  if (Source is TStrings) then
    LoadFromStringList(TStrings(Source))
  {$ifdef LMD_UNICODE}
  else
  if (Source is TLMDWideStrings) then
    LoadFromWideStringList(TLMDWideStrings(Source))
  {$endif}
  else
    inherited;
end;

procedure TElTreeItems.Clear;
var i : integer;
    FMSel : boolean;
begin
  i := Count;
  if FOwner <> nil then
  begin
    FOwner.IsUpdating := true;
    FOwner.ItemFocused := nil;
    FOwner.FView.FSelected := nil;
    FOwner.FTopIndex := 0;

    // clear data cache for virtual mode
    FOwner.DataCacheClear;

    // clear visibles list
    FOwner.FView.FVisible.Clear;
  end;

  // clear items list
  FMSel := FOwner.FMultiSelect;
  FOwner.FMultiSelect := false;
  FRoot.Clear;
  if FOwner.FSelectedList <> nil then
    FOwner.FSelectedList.Count := 0;
  FOwner.FMultiSelect := FMSel;
  if FOwner <> nil then
  with FOwner.FView do
  begin
    FHRange := -1;
    if i > 0 then
    begin
      FVisUpdated := true;
      FClearVis := true;
      FClearAll := true;
    end;
    FOwner.FUpdated := true;
    FOwner.IsUpdating := false;
  end;
end;

function TElTreeItems.GetCount: Integer;
begin
  if Self.FOwner <> nil then
    result := FOwner.FAllList.Count
  else
    result := 0;
end;

function TElTreeItems.CreateItem;
begin
  result := FItemClass.Create(FOwner);
end;

procedure TElTreeItems.ReadData;
begin
  if FOwner <> nil then
    FOwner.IsUpdating := true;
  FRoot.Clear;
  FRoot.ReadData(Stream);
  if FOwner <> nil then
  with FOwner.FView do
    begin
      FHRange := -1;
      FVisUpdated := true;
      FClearVis := true;
      FClearAll := true;
      FOwner.FUpdated := true;
      FOwner.IsUpdating := false;
    end;
end;

procedure TElTreeItems.WriteData;
var
  TSI: TElTreeItem;
begin
  TSI := nil;
  if FOwner <> nil then
  begin
    TSI := FOwner.ItemFocused;
    FOwner.ItemFocused := nil;
  end;
  FRoot.WriteData(Stream);
  if FOwner <> nil then
  begin
    FOwner.ItemFocused := TSI;
  end;
end;

procedure TElTreeItems.SaveToStream;
begin
  WriteData(Stream);
end;

procedure TElTreeItems.LoadFromStream;
begin
  ReadData(Stream);
end;

procedure TElTreeItems.SaveToFile;
var
  T: TStream;
begin
  T := nil;
  try
    T := TLMDFileStream.Create(FileName, fmCreate or fmShareDenyWrite);
    SaveToStream(T);
  finally
    T.Free;
  end;
end;

procedure TElTreeItems.LoadFromFile;
var
  T: TStream;
begin
  T := nil;
  try
    T := TLMDFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite);
    LoadFromStream(T);
  finally
    T.Free;
  end;
end;

function TElTreeItems.Add(Item: TElTreeItem; Text: TLMDString): TElTreeItem; { public }
begin
  if Item = nil
     then result := AddItem(nil)
     else result := AddItem(Item.FParent);
  Result.Text := Text;
end; { Add }

function TElTreeItems.AddChild(Item: TElTreeItem; Text: TLMDString): TElTreeItem; { public }
begin
  result := AddItem(Item);
  Result.Text := Text;
end; { AddChild }

function TElTreeItems.AddChildFirst(Item: TElTreeItem; Text: TLMDString): TElTreeItem; { public }
begin
  result := InsertItem(0, Item);
  Result.Text := Text;
end; { AddChildFirst }

function TElTreeItems.AddChildObject(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; { public }
begin
  Result := AddItem(Item);
  Result.Text := Text;
  Result.Data := Ptr;
end; { AddChildObject }

function TElTreeItems.AddChildObjectFirst(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; { public }
begin
  result := InsertItem(0, Item);
  Result.Text := Text;
  Result.Data := Ptr;
end; { AddChildObjectFirst }

function TElTreeItems.AddFirst(Item: TElTreeItem; Text: TLMDString): TElTreeItem; { public }
begin
  if Item = nil then result := InsertItem(0, nil)
  else result := InsertItem(0, Item.FParent);
  Result.Text := Text;
end; { AddFirst }

function TElTreeItems.AddObject(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; { public }
begin
  if Item = nil then result := AddItem(nil) else result := AddItem(Item.FParent);
  Result.Text := Text;
  Result.Data := Ptr;
end; { AddObject }

function TElTreeItems.AddObjectFirst(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; { public }
begin
  if Item = nil then result := InsertItem(0, nil) else result := InsertItem(0, Item.FParent);
  Result.Text := Text;
  Result.Data := Ptr;
end; { AddObjectFirst }

function TElTreeItems.Insert(Item: TElTreeItem; Text: TLMDString): TElTreeItem; { public }
var
  i: integer;
  FParent: TElTreeItem;
begin
  if Item = nil then
  begin
    i := 0;
    FParent := nil;
  end else
  begin
    i := Item.Index;
    FParent := Item.FParent;
  end;
  result := InsertItem(i, FParent);
  Result.Text := Text;
end; { Insert }

// Changed 10/28/98 by EM

function TElTreeItems.InsertObject(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; { public }
var
  i: integer;
  FParent: TElTreeItem;
begin
  if Item = nil then
  begin
    i := 0;
    FParent := nil;
  end else
  begin
    i := Item.Index;
    FParent := Item.FParent;
  end;
  result := InsertItem(i, FParent);
  Result.Text := Text;
  Result.Data := Ptr;
end; { InsertObject }

procedure TElTreeItems.Delete; { public }
begin
  DeleteItem(Item);
end; { Delete }

function TElTreeItems.GetFirstNode: TElTreeItem; { public }
begin
  Result := Item[0];
end; { GetFirstNode }

// Changed 10/27/98 by EM

procedure TElTreeItems.BeginUpdate; { public }
begin
  FOwner.IsUpdating := true;
end; { BeginUpdate }

// Changed 10/27/98 by EM

procedure TElTreeItems.EndUpdate; { public }
begin
  FOwner.IsUpdating := false;
end; { EndUpdate }

// Changed 10/28/98 by EM

function TElTreeItems.InsertAfterObject(Item: TElTreeItem; Text: TLMDString; Ptr: TLMDDataTag): TElTreeItem; { public }
var
  i: integer;
  FParent: TElTreeItem;
begin
  if Item = nil then
  begin
    i := 0;
    FParent := nil;
  end else
  begin
    i := Succ(Item.Index);
    FParent := Item.FParent;
  end;
  result := InsertItem(i, FParent);
  Result.Text := Text;
  Result.Data := Ptr;
end; { InsertAfterObject }

// Changed 10/28/98 by EM

function TElTreeItems.InsertAfter(Item: TElTreeItem; Text: TLMDString): TElTreeItem; { public }
var
  i: integer;
  FParent: TElTreeItem;
begin
  if Item = nil then
  begin
    i := 0;
    FParent := nil;
  end else
  begin
    i := Item.Index + 1;
    FParent := Item.FParent;
  end;
  result := InsertItem(i, FParent);
  Result.Text := Text;
end; { InsertAfter }

type
  TSRecEx0 = record
    TextToFind: TLMDString;
    WholeTextOnly: boolean;
    ColumnNum: integer;
    StartItem: TElTreeItem;
    DataToFind: TLMDDataTag;
    CheckStartItem,
      LookForData,
      SubItemsOnly: boolean;
    NoCase: boolean;
    Result: TElTreeItem;
  end;
  PSRecEx0 = ^TSRecEx0;
  TSRecEx = record
    ColumnNum: integer;
    StartItem: TElTreeItem;
    CheckStartItem,
      SubItemsOnly: boolean;
    Result: TElTreeItem;
    CompProc: TElLookupCompareProc;
    CompMethod: TElLookupCompareMethod;
    SearchDetails: TLMDDataTag;
  end;
  PSRecEx = ^TSRecEx;
  procedure TElTreeItems.IntFind(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
  IterateData: TLMDDataTag; Tree: TCustomElTree);
var
  b: boolean;
  begin
  with PSRecEx(IterateData)^ do
  begin
    if (Item = StartItem) and (not CheckStartItem) then exit;
    if ((not CheckStartItem) or (Item <> StartItem)) and
    (SubItemsOnly) and (not Item.IsUnder(StartItem)) then
    begin
      ContinueIterate := false;
      exit;
    end;
    if Assigned(CompProc) then
      b := CompProc(Item, SearchDetails)
    else
      b := CompMethod(Item, SearchDetails);
    if b then
    begin
      result := Item;
      ContinueIterate := false;
      exit;
    end;
  end;
  end;

function TElTreeItems.LookBackForItemEx2(StartItem: TElTreeItem; ColumnNum: integer;
        CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: boolean;
        SearchDetails: TLMDDataTag;
        CompareProc: TElLookupCompareProc): TElTreeItem;
var
  SRec: TSRecEx;
begin
  SRec.ColumnNum := ColumnNum;
  SRec.StartItem := StartItem;
  SRec.CheckStartItem := CheckStartItem;
  SRec.SubItemsOnly := SubItemsOnly;
  SRec.CompProc := CompareProc;
  SRec.SearchDetails := SearchDetails;
  SRec.Result := nil;
  try
    IterateBackFrom(VisibleOnly, CheckCollapsed, IntFind, @SRec, StartItem); (*<+>*)
  finally
    Result := SRec.Result;
    end;
end;

type
  TSRecEx2 = record
    TextToFind: TLMDString;
    ColumnNum: integer;
    StartItem: TElTreeItem;
    DataToFind: TLMDDataTag;
    CheckStartItem,
      LookForData,
      SubItemsOnly: boolean;
    NoCase: boolean;
    Result: TElTreeItem;
  end;
  PSRecEx2 = ^TSRecEx2;
  procedure TElTreeItems.IntFind1(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
  IterateData: TLMDDataTag; Tree: TCustomElTree);
var
  i: integer;
  s: TLMDString;
  L: PSRecEx2;
begin
  L := PSRecEx2(IterateData);
  if (Item = PSRecEx2(IterateData).StartItem) and (not PSRecEx2(IterateData).CheckStartItem) then exit;
  if (PSRecEx2(IterateData).SubItemsOnly) and (not Item.IsUnder(PSRecEx2(IterateData).StartItem)) then
  begin
    ContinueIterate := false;
    exit;
  end;
  if L.LookForData then
  begin
    if Item.FData = L.DataToFind then
    begin
      L.Result := Item;
      ContinueIterate := false;
      exit;
    end;
  end else
  begin
    if (L.ColumnNum = -1) or (L.ColumnNum = Tree.MainTreeColumn) then
      s := Item.Text
    else
    begin
      i := L.ColumnNum;
      if Item.FStaticData <> nil then
      begin
        if i > Tree.MainTreeColumn then
          dec(i);
        if Item.ColumnText.Count <= i then
          s := ''
        else
          s := Item.ColumnText[i];
      end
      else
        Tree.TriggerVirtualTextNeeded(Item, i, s);
    end;
    if L.NoCase then
    begin
      {$ifdef LMD_UNICODE}
      if LMDWideSameText(S, L.TextToFind) then
      {$else}
      if LMDAnsiSameText(S, L.TextToFind) then
      {$endif}
      begin
        L.Result := Item;
        ContinueIterate := false;
        exit;
      end;
    end else
    begin
      if S = L.TextToFind then
      begin
        L.Result := Item;
        ContinueIterate := false;
        exit;
      end;
    end;
  end;
  end;

function TElTreeItems.LookForItem(StartItem: TElTreeItem;
  TextToFind: TLMDString;
  DataToFind: TLMDDataTag;
  ColumnNum: integer;
  LookForData,
  CheckStartItem,
  SubItemsOnly,
  VisibleOnly,
  NoCase: boolean): TElTreeItem;
var
  SRec: TSRecEx2;
begin
  result := nil;
  SRec.TextToFind := TextToFind;
  SRec.ColumnNum := ColumnNum;
  if StartItem = nil then
  begin
    if Count = 0 then
      exit
    else
      SRec.StartItem := Item[0];
  end
  else
    SRec.StartItem := StartItem;
  SRec.LookForData := LookForData;
  SRec.DataToFind := DataToFind;
  SRec.NoCase := NoCase;
  SRec.CheckStartItem := CheckStartItem;
  SRec.SubItemsOnly := SubItemsOnly;
  SRec.Result := nil;
  try
    IterateFrom(VisibleOnly, not VisibleOnly, IntFind1, @SRec, StartItem); (*<+>*)
  finally
    Result := SRec.Result;
    end;
end;

(*<+>*)
function TElTreeItems.LookForItemEx2(StartItem: TElTreeItem; ColumnNum: integer;
      CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: boolean;
      SearchDetails: TLMDDataTag;
      CompareProc: TElLookupCompareProc): TElTreeItem;
var
  SRec: TSRecEx;
begin
  result := nil;
  SRec.ColumnNum := ColumnNum;
  if StartItem = nil then
  begin
    if Count = 0 then
      exit
    else
      SRec.StartItem := Item[0];
  end
  else
    SRec.StartItem := StartItem;

  SRec.CheckStartItem := CheckStartItem;
  SRec.SubItemsOnly := SubItemsOnly;
  SRec.CompProc := CompareProc;
  SRec.SearchDetails := SearchDetails;
  SRec.Result := nil;
  try
    IterateFrom(VisibleOnly, CheckCollapsed, IntFind, @SRec, StartItem); (*<+>*)
  finally
    Result := SRec.Result;
    end;
end;

function TElTreeItems.LookForItemEx2(StartItem: TElTreeItem; ColumnNum: integer;
      CheckStartItem, SubItemsOnly, VisibleOnly, CheckCollapsed: boolean;
      SearchDetails: TLMDDataTag;
      CompareMethod: TElLookupCompareMethod): TElTreeItem;
var
  SRec: TSRecEx;
begin
  result := nil;
  SRec.ColumnNum := ColumnNum;
  if StartItem = nil then
  begin
    if Count = 0 then
      exit
    else
      SRec.StartItem := Item[0];
  end
  else
    SRec.StartItem := StartItem;

  SRec.CheckStartItem := CheckStartItem;
  SRec.SubItemsOnly := SubItemsOnly;
  SRec.CompProc := nil;
  SRec.CompMethod := CompareMethod;
  SRec.SearchDetails := SearchDetails;
  SRec.Result := nil;
  try
    IterateFrom(VisibleOnly, CheckCollapsed, IntFind, @SRec, StartItem); (*<+>*)
  finally
    Result := SRec.Result;
    end;
end;

procedure TElTreeItems.IntFind3(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
  IterateData: TLMDDataTag; Tree: TCustomElTree);
var
  SubStrPos, i: integer;
  s, CopiedSubStr: TLMDString;
  begin
  with PSRecEx0(IterateData)^ do
  begin
    if (Item = StartItem) and (not CheckStartItem) then exit;
    if (SubItemsOnly) and not (Item = StartItem) and (not Item.IsUnder(StartItem)) then
    begin
      ContinueIterate := false;
      exit;
    end;
    if LookForData then
    begin
      if Item.FData = DataToFind then
      begin
        result := Item;
        ContinueIterate := false;
        exit;
      end;
    end else
    begin
      if (ColumnNum = -1) or (ColumnNum = Tree.MainTreeColumn) then s := Item.Text else
      begin
        i := ColumnNum;
        if i > Tree.MainTreeColumn then dec(i);
        if Item.ColumnText.Count <= i then s := ''
        else s := Item.ColumnText[i];
      end;
      if NoCase then
      begin
        if (WholeTextOnly and
           {$ifdef LMD_UNICODE}
           (LMDWideSameText(S, TextToFind))) or
           {$else}
           (LMDAnsiSameText(S, TextToFind))) or
           {$endif}
           (not WholeTextOnly and
           {$ifdef LMD_UNICODE}
           (LMDWidePos(LMDWideUpperCase(TextToFind), LMDWideUpperCase(S)) > 0))
           {$else}
           (Pos(UpperCase(TextToFind),UpperCase(S)) > 0))
           {$endif}
           then
        begin
          result := Item;
          ContinueIterate := false;
          exit;
        end;
      end
      else
      begin
        {$ifdef LMD_UNICODE}
        SubStrPos := LMDWidePos(TextToFind, S);
        {$else}
        SubStrPos := Pos(TextToFind,S);
        {$endif}
        CopiedSubStr := '';
        if SubStrPos > 0 then
          CopiedSubStr := Copy(S, SubStrPos, Length(TextToFind));
        if (WholeTextOnly and (S = TextToFind)) or
           (not WholeTextOnly and
           {$ifdef LMD_UNICODE}
           (LMDWidePos(TextToFind,S) > 0))
           {$else}
           (Pos(TextToFind,S) > 0))
           {$endif}
           then
        begin
          Result := Item;
          ContinueIterate := false;
          exit;
        end;
      end;
    end;
  end;
  end;

(*<+>*)
function TElTreeItems.LookForItem2(StartItem: TElTreeItem;
  TextToFind: TLMDString;
  WholeTextOnly: boolean;
  DataToFind: TLMDDataTag;
  ColumnNum: integer;
  LookForData,
  CheckStartItem,
  SubItemsOnly,
  VisibleOnly,
  CheckCollapsed,
  NoCase: boolean): TElTreeItem;
var
  SRec: TSRecEx0;
begin
  Result := nil;
  SRec.TextToFind := TextToFind;
  SRec.WholeTextOnly := WholeTextOnly;
  SRec.ColumnNum := ColumnNum;
  if StartItem = nil then
  begin
    if Count = 0 then
      exit
    else
      SRec.StartItem := Item[0];
  end
  else
    SRec.StartItem := StartItem;

  SRec.LookForData := LookForData;
  SRec.DataToFind := DataToFind;
  SRec.NoCase := NoCase;
  SRec.CheckStartItem := CheckStartItem;
  SRec.SubItemsOnly := SubItemsOnly;
  SRec.Result := nil;
  try
    IterateFrom(VisibleOnly, CheckCollapsed, IntFind3, @SRec, StartItem); (*<+>*)
  finally
    Result := SRec.Result;
    end;
end;

procedure TElTreeItems.IntFind4(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
  IterateData: TLMDDataTag; Tree: TCustomElTree);
var
  b: boolean;
begin
  if (Item = PSRecEx(IterateData).StartItem) and (not PSRecEx(IterateData).CheckStartItem) then exit;
  if (PSRecEx(IterateData).SubItemsOnly) and (not Item.IsUnder(PSRecEx(IterateData).StartItem)) then
  begin
    ContinueIterate := false;
    exit;
  end;
  b := PSRecEx(IterateData).CompProc(Item, PSRecEx(IterateData).SearchDetails);
  if b then
  begin
    PSRecEx(IterateData).result := Item;
    ContinueIterate := false;
    exit;
  end;
end;

function TElTreeItems.LookForItemEx(StartItem: TElTreeItem; ColumnNum: integer; CheckStartItem, SubItemsOnly,
  VisibleOnly: boolean; SearchDetails: TLMDDataTag; CompareProc: TElLookupCompareProc): TElTreeItem;
var
  SRec: TSRecEx;
begin
  result := nil;
  SRec.ColumnNum := ColumnNum;
  if StartItem = nil then
  begin
    if Count = 0 then
      exit
    else
      SRec.StartItem := Item[0];
  end
  else
    SRec.StartItem := StartItem;
  SRec.CheckStartItem := CheckStartItem;
  SRec.SubItemsOnly := SubItemsOnly;
  SRec.CompProc := CompareProc;
  SRec.SearchDetails := SearchDetails;
  SRec.Result := nil;
  try
    IterateFrom(VisibleOnly, not VisibleOnly, IntFind4, @SRec, StartItem); (*<+>*)
  finally
    Result := SRec.Result;
    end;
end;

function TElTreeItems.GetRootCount: Integer;
begin
  Result := FRoot.Count;
end;

function TElTreeItems.GetRootItem(Index: Integer): TElTreeItem;
begin
  Result := FRoot.Item[Index];
end;

procedure TElTreeItems.LoadFromStringList(Strings : TStrings);
var i : integer;
begin
  BeginUpdate;
  try
    Clear;
    for i := 0 to Strings.Count - 1 do
      InsertItemFromString(i, Strings[i]);
  finally
    EndUpdate;
  end;
end;

{$ifdef LMD_UNICODE}
procedure TElTreeItems.LoadFromWideStringList(Strings : TLMDWideStrings);
var i : integer;
begin
  BeginUpdate;
  try
    Clear;
    for i := 0 to Strings.Count - 1 do
      InsertItemFromString(i, Strings[i]);
  finally
    EndUpdate;
  end;
end;
{$endif}

function TElTreeItems.InsertItemFromString(Index: integer; AString: TLMDString): TElTreeItem;
var
  l,
  cl    : integer;
  p,
  op    : PLMDChar;
  CItem,
  NItem : TElTreeItem;
  S     : TLMDString;
  i     : integer;
  begin
  if Index > 0 then
    CItem := GetItem(Index - 1)
  else
    CItem := nil;
  l := 0;
  p := PLMDChar(AString);
  while (p^ = #9) do
  begin
    inc(p);
  inc(l);
  end;
  if CItem <> nil then
    cl := CItem.Level
  else
    cl := 0;
  if l > cl + 1 then
    l := cl + 1;
  while cl > l do
  begin
    CItem := CItem.Parent;
    dec(cl);
  end;
  if (cl = l) and (CItem <> nil) then
    CItem := CItem.Parent;
  NItem := AddItem(CItem);
  Result := NItem;
  i := 0;
  while true do
  begin
    op := p;
    while (p^ <> #9) and (p^ <> #0) do
    begin
      inc(p);
    end;
    SetLength(S, p - op);
    if p - op > 0 then
      Move(op^, S[1], Length(S) * sizeof(TLMDChar));
    if {((i = 0) and (not FOwner.FShowHeader)) or }(i = FOwner.FMainTreeCol) then
      NItem.Text := S
    else
      NItem.ColumnText.Add(S);
    inc(i);
    if (p^ = #0) then
      break
    else
      inc(p);
    end;
end;

procedure TElTreeItems.SaveToStringList(AStrings : TStrings);
var i, j : integer;
    S    : String;
    AnItem : TElTreeItem;
begin
  AStrings.Clear;
  for i := 0 to Count - 1 do
  begin
    AnItem := GetItem(i);
    {$ifdef LMD_UNICODE}
    S := LMDWideMakeString(AnItem.Level, #9);
    {$else}
    S := LMDAnsiMakeString(AnItem.Level, #9);
    {$endif}
    {
    if FOwner.FShowHeader then
      k := Owner.HeaderSections.Count - 1
    else
      k := 0;
    }
    j := 0;
    while true do
    begin
      if j > 0 then S := S + #9;
      if {(not FOwner.FShowHeader) or }(j = FOwner.FMainTreeCol) then
        S := S + AnItem.Text
      else
      if j < FOwner.FMainTreeCol then
      begin
        if AnItem.ColumnText.Count > j then
          S := S + AnItem.ColumnText[j]
        else
          break;
      end
      else
      begin
        if AnItem.ColumnText.Count > j - 1 then
          S := S + AnItem.ColumnText[j - 1]
        else
          break;
      end;
      inc(j);
    end;
    AStrings.Add(S);
  end;
end;

{$ifdef LMD_UNICODE}
procedure TElTreeItems.SaveToWideStringList(AStrings : TLMDWideStrings);
var i, j : integer;
    S    : WideString;
    AnItem : TElTreeItem;
begin
  AStrings.Clear;
  for i := 0 to Count - 1 do
  begin
    AnItem := GetItem(i);
    S := LMDWideMakeString(AnItem.Level, #9);
    {
    if FOwner.FShowHeader then
      k := Owner.HeaderSections.Count - 1
    else
      k := 0;
    }
    j := 0;
    while true do
    begin
      if j > 0 then S := S + #9;
      if {(not FOwner.FShowHeader) or }(j = FOwner.FMainTreeCol) then
        S := S + AnItem.Text
      else
      if j < FOwner.FMainTreeCol then
      begin
        if AnItem.ColumnText.Count > j then
          S := S + AnItem.ColumnText[j]
        else
          break;
      end
      else
      begin
        if AnItem.ColumnText.Count > j - 1 then
          S := S + AnItem.ColumnText[j - 1]
        else
          break;
      end;
      inc(j);
    end;
    AStrings.Add(S);
  end;
end;
{$endif}

// ****************************************************************************
//                                 TCustomElTree
// ****************************************************************************

procedure TCustomElTree.SetBSVLines;
begin
  if (FBSVLines = value) then exit;
  IsUpdating := true;
  with FView do
  begin
    FBSVLines := value;
    if BarStyle then
    begin
      FClearAll := true;
      FUpdated := true;
    end;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.AlignPieces;
var
  TreeRect,
  HeaderRect,
  HScrollRect,
  VScrollRect : TRect;
  BlindRect   : TRect;
  hh, hs, wv  : integer;

begin
  if not HandleAllocated then exit;
  FIgnoreSBChange := true;
  try
    TreeRect := ClientRect;
    if FShowHeader then
    begin
      TElHeaderHack(FHeader).AdjustHeaderHeight;
      SavedHH := GetHeaderHeight;
      hh := SavedHH;
      HeaderRect := Rect(0, 0, TreeRect.Right, hh);
//      if StickyHeaderSections then inc(HeaderRect.Right);
      TreeRect.Top := hh;
    end;
    SetRectEmpty(BlindRect);
    if FHScrollVisible and FUseCustomBars then
    begin
      hs := FHScrollBar.Height;
      Dec(TreeRect.Bottom, hs);
      HScrollRect := Rect(0, TreeRect.Bottom, TreeRect.Right, TreeRect.Bottom + hs);
    end;
    if FVScrollVisible and FUseCustomBars then
    begin
      wv := FVScrollBar.Width;
      if RightAlignedText xor ScrollBarOpposite then
      begin
        VScrollRect := Rect(TreeRect.Left, 0, TreeRect.Left + wv, TreeRect.Bottom);
        Inc(HeaderRect.Left, wv);
        Inc(TreeRect.Left, wv);
        Inc(HScrollRect.Left, wv);
        if FHScrollVisible then
           BlindRect := Rect(0, VScrollRect.Bottom + 1, VScrollRect.Right, HScrollRect.Bottom);
      end else
      begin
        VScrollRect := Rect(TreeRect.Right - wv, 0, TreeRect.Right, TreeRect.Bottom);
        dec(HeaderRect.Right, wv);
        dec(TreeRect.Right, wv);
        dec(HScrollRect.Right, wv);
        if FHScrollVisible then
           BlindRect := Rect(VScrollRect.Left, VScrollRect.Bottom + 1, VScrollRect.Right, HScrollRect.Bottom);
      end;
    end;
    with HeaderRect do
      if FShowHeader then
        SetWindowPos(FHeader.Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top, SWP_NOACTIVATE or SWP_NOZORDER or SWP_NOOWNERZORDER or SWP_SHOWWINDOW or SWP_NOSENDCHANGING)
      else
        SetWindowPos(FHeader.Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_HIDEWINDOW);
      PBoolean(@FHeader.Visible)^ := FShowHeader;
      with TreeRect do
        SetWindowPos(FView.Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top, SWP_NOACTIVATE or SWP_NOOWNERZORDER or SWP_NOZORDER or SWP_SHOWWINDOW or SWP_NOSENDCHANGING);
    with HScrollRect do
      if FHScrollVisible and FUseCustomBars then
        SetWindowPos(FHScrollBar.Handle, HWND_TOP, Left, Top, Right - Left, Bottom - Top, SWP_NOACTIVATE or SWP_NOOWNERZORDER or SWP_NOZORDER or SWP_SHOWWINDOW or SWP_NOSENDCHANGING)
      else
        SetWindowPos(FHScrollBar.Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_HIDEWINDOW);
      PBoolean(@FHScrollBar.Visible)^ := FHScrollVisible and FUseCustomBars;
      with VScrollRect do
      if FVScrollVisible and FUseCustomBars then
        SetWindowPos(FVScrollBar.Handle, HWND_TOP, VScrollRect.Left, VScrollRect.Top, VScrollRect.Right - VScrollRect.Left, VScrollRect.Bottom - VScrollRect.Top, SWP_NOACTIVATE or SWP_NOOWNERZORDER {or SWP_NOZORDER }or SWP_SHOWWINDOW or SWP_NOSENDCHANGING)
      else
        SetWindowPos(FVScrollBar.Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or SWP_HIDEWINDOW);
      PBoolean(@FVScrollBar.Visible)^ := FVScrollVisible and FUseCustomBars;
      if not IsRectEmpty(BlindRect) then
    InvalidateRect(Handle, @BlindRect, true);
    if ShowColumns and StickyHeaderSections then
    begin
      TElHeaderHack(FHeader).AdjustStickySize(nil);
      FHeader.Invalidate;
    end;
  finally
    FIgnoreSBChange := false;
  end;
end;

function TCustomElTree.GetRoot: TElTreeItem;
begin
  result := FItems.FRoot;
end;

type THackScrollBar = class(TElScrollBar)
       property Font;
       property NoScrollMessages;
     end;

constructor TCustomElTree.CreateClass;
begin
  BeginCreate;
  inherited Create(AOwner);
  CreateItemsExt(ItemClass);
  Init;
  EndCreate;
end;

constructor TCustomElTree.Create;
begin
  BeginCreate;
  inherited;
  Init;
  EndCreate;
end;

function TCustomElTree.IsVistaSelNeed: boolean;
begin
  Result := FUseThemeForSelection and IsThemed {UseXPThemes and XPThemesAvailable} and LMDSIWindowsVistaUp {and IsThemeActive};
end;

procedure TCustomElTree.SetUseThemeForSelection(const Value: Boolean);
begin
  if FUseThemeForSelection <> Value then
  begin
    FUseThemeForSelection := Value;
    Invalidate;
  end;
end;

procedure TCustomElTree.ReadState(Reader: TReader);
begin
// restore default values
  FHScrollBar.AltDisablingArrows := false;
  FHScrollBar.IsHTML := false;
  FVScrollBar.ShowTrackHint := false;
  FVScrollBar.AltDisablingArrows := false;
  FVScrollBar.IsHTML := false;
  inherited;
end;

procedure TCustomElTree.Init;
begin
  FSinglelineEllipsis := true;
  FMultilineEllipsis  := false;
  FEditorManager := CreateInplaceManager;
  FUseCustomBars := true;
  ControlStyle :=
  [csClickEvents, csOpaque, csDoubleClicks,// csCaptureMouse,
    csDisplayDragImage, csReplicatable, csReflector ];

  FNotRaiseForBarStyle := False;

  FAllList := TLMDObjectList.Create;
  FSelectedList := TLMDObjectList.Create;
  if FItems = nil then
    FItems := CreateItems;

  //BMP := TBitmap.Create;
  Height := 100;
  Width := 200;
  FView := CreateView;
  FMainTextType := sftText;
  FHintType := shtHintOrText;
  FQuickEditMode := false;

  FView.FRender := TLMDHTMLRender.Create;
  FView.FRender.OnImageNeeded := TriggerImageNeededEvent;
  FView.FRender.OnImageNeededEx := TriggerImageNeededExEvent;

  FView.TabStop := false;
  FView.OnClick := ClickTransfer;
  FView.OnDblClick := DblClickTransfer;
  FView.OnDragDrop := DropTransfer;
  FView.OnDragOver := OverTransfer;
  FView.OnEndDrag := DragTransfer;
  FView.OnEnter := EnterTransfer;
  FView.OnExit := ExitTransfer;
  FView.OnKeyDown := KeyDownTransfer;
  FView.OnKeyPress := KeyPressTransfer;
  FView.OnKeyUp := KeyUpTransfer;
  FView.OnMouseDown := MouseDownTransfer;
  FView.OnMouseMove := MouseMoveTransfer;
  FView.OnMouseUp := MouseUpTransfer;
  FView.OnStartDrag := StartDragTransfer;
  FView.OnMouseWheel := MouseWheelTransfer;
  FView.OnMouseWheelDown := MouseWheelDownTransfer;
  FView.OnMouseWheelUp := MouseWheelUpTransfer;
  FView.Ctl3D := false;
  FView.ParentShowHint := true;
  FView.TabStop := true;
  FView.TabOrder := 0;
  FView.ParentFont := true;

  FHScrollBar := TElScrollBar.Create(Self);
  FHScrollBar.StyleManager := nil;
  THackScrollBar(FHScrollBar).ControlStyle := FHScrollBar.ControlStyle + [csNoDesignVisible];
  THackScrollBar(FHScrollBar).NoScrollMessages := true;
  FHorzScrollBarStyle := TElScrollBarStyles.Create(FHScrollBar, Self);
  FHorzScrollBarStyle.OnChange := SBChanged;
  FHScrollBar.OnDrawPart := HorzScrollDrawPartTransfer;
  FHScrollBar.OnScrollHintNeeded := HorzScrollHintNeededTransfer;

  FHScrollBar.ParentFont := true;
  FHScrollBar.TabStop := false;
  FHScrollBar.OnScroll := FView.OnHScroll;
  FHScrollBar.Ctl3D := false;
  FHScrollBar.Height := GetSystemMetrics(SM_CYVTHUMB);
  FHScrollBar.Visible := false;
  FHScrollBar.OnMouseDown := ScrollBarMouseDown;
  FHScrollBar.AltDisablingArrows := true;

  FHScrollBar.IsHTML := true;
  FLinkColor := clBlue;
  FLinkStyle := [fsUnderline];

  FVScrollBar := TElScrollBar.Create(Self);
  FVScrollBar.StyleManager := nil;
  THackScrollBar(FVScrollBar).ControlStyle := FHScrollBar.ControlStyle + [csNoDesignVisible];
  THackScrollBar(FVScrollBar).NoScrollMessages := true;
  FVertScrollBarStyle := TElScrollBarStyles.Create(FVScrollBar, Self);
  FVertScrollBarStyle.OnChange := SBChanged;
  FVScrollBar.OnDrawPart := VertScrollDrawPartTransfer;
  FVScrollBar.OnScrollHintNeeded := VertScrollHintNeededHandler;
  FVScrollBar.ShowTrackHint := true;

  FVScrollBar.ParentFont := true;
  FVScrollBar.Kind := sbVertical;
  FVScrollBar.TabStop := false;
  FVScrollBar.OnScroll := FView.OnVScroll;
  FVScrollBar.Ctl3D := false;
  FVScrollBar.Width := GetSystemMetrics(SM_CXHTHUMB);
  FVScrollBar.Visible := false;
  FVScrollBar.OnMouseDown := ScrollBarMouseDown;
  FVScrollBar.AltDisablingArrows := true;

  FVScrollBar.IsHTML := true;
  FLinkCursor := crHandPoint;

  ItemExt := 17;
  FCheckBoxSize := 15;
  FHeader := CreateHeader;
  FView.FHeader := FHeader;
  FView.FItems := FItems;
  FHeaderHotTrack := true;

  with FHeader do
  begin
    StyleManager := nil;
    TabStop := false;
    SetDesigning(csDesigning in ComponentState);
    OnSectionDraw := DoHeaderDraw;
    OnResize := HeaderResizeHandler;
    OnSectionResize := OnHeaderSectionResize;
    OnSectionClick := OnHeaderSectionClick;
    OnSectionDelete := OnHeaderSectionDelete;
    OnMouseDown := DoHeaderMouseDown;
    OnSectionMove := OnHeaderSectionMove;
    OnSectionShowHide := OnHeaderSectionVisChange;
    OnSectionChange := OnHeaderSectionChange;
    OnSectionCreate := OnHeaderSectionCreate;
    OnHeaderLookup := OnHeaderSectionLookup;
    OnHeaderLookupDone := OnHeaderSectionLookupDone;
    OnSectionExpand := Self.OnHeaderExpand;
    OnSectionCollapse := Self.OnHeaderCollapse;
    OnSectionAutoSize := HeaderSectionAutoSizeHandler;
    OnFilterCall := SectionFilterCallTransfer;
    Tracking := FHeaderHotTrack;
    Align := alNone;
    Visible := false;
    AllowDrag := false;

    MultiSort := true;

  end; //with
  FHeader.Font.Assign(Font);

  FLineHeight := DefineLineHeight;

  FShowHeader := False;
  // Font.OnChange := OnFontChange;

  FAdjustMultilineHeight := true;
  FHighlightAlphaLevel := 255;
  FBorderStyle := bsSingle;

  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;

  FBkColor := clWindow;
  FTextColor := clWindowText;
  FCanEdit := true;
  FHorizontalLines := false;
  FVerticalLines := false;
  FVerticalLinesLong := true;
  FFullRowSelect := true;
  FSelMode := smUsual;
  FShowHintMode := shmLong;
  FMultiSelect := true;
  FMultiSelectLevel := -1;  // CNS
  FDragScrollInterval := 100;
  FMouseFrameVisible := true;
  FMouseFrameSelect := true;
  FDblClickMode := dcmExpand;
  FHideSelect := false;
  FODFollowCol := true;
  FODMask := DefaultTreeOwnerDrawMask;
  FRowSelect := True;
  FTracking := true;
{$IFDEF HOTTRACK_CURSOR}
  FTrackingCursor := crDefault;
{$ENDIF}
  FShowButtons := True;
  FShowImages := True;
  FShowLines := True;
  FDrawFocusRect := true;
  TabStop := true;
  FAutoLineHeight := true;
  FLineHintType := lhtSmart;
  FDragTrgDrawMode := SelColorRect;
  FPathSeparator := '\';
  FSortMode := smNone;
  FSortColumnColor := clNone;
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FAImageChangeLink := TChangeLink.Create;
  FAImageChangeLink.OnChange := ImageListChange;
  DragMode := dmManual;
  FHideHintOnMove := true;
  FAlwaysKeepSelection := true;
  FIncrementalSearchScope := issWholeTree;

  //FPlusPicture := TBitmap.Create;
  //FPlusPicture.OnChange := OnSignChange;
  //FMinusPicture := TBitmap.Create;
  //FMinusPicture.OnChange := OnSignChange;
  //FLeafPicture := TBitmap.Create;
  //FLeafPicture.OnChange := OnSignChange;
  //FCheckBoxGlyph := TBitmap.Create;
  //FRadioButtonGlyph := TBitmap.Create;

  FSelectColumn := -1;
  FDragType := dtDelphi;
  FLinesColor := clBtnFace;
  FLineHintColor := FBkColor;
  FLinesStyle := psDot;
  FActiveBorderType := fbtSunken;
  FInactiveBorderType := fbtSunkenOuter;

  FStoragePath := '\Tree';
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FUnderlineTracked := true;
  FShowRootButtons := true;
  FAutoResizeColumns := True;
  FFlatFocusedScrollbars := true;
  FHorzDivLinesColor := clBtnFace;
  FVertDivLinesColor := clBtnFace;

  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChange;
  FBackgroundType := bgtColorFill;

  FFocusedSelectColor := clHighlight;
  FHideSelectColor := clBtnFace;
  FFocusedSelectTextColor := clHighlightText;
  FHideSelectTextColor := LMDElHideSelectTextColor;
  FTrackColor := clHighlight;
  FDragRectAcceptColor := clGreen;
  FDragRectDenyColor   := clRed;
  FRightClickSelect := true;
  FSortType := stText;
  FSortUseCase := true;

  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FStripedEvenColor := clBtnHighlight;
  FStripedOddColor := clBtnShadow;

  FHeaderUseTreeFont := true;
  FHeaderFont := TFont.Create;
  FHeaderFont.OnChange := HeaderFontChanged;

  FLineHintTimeout := 3000;
  FChangeDelay := 500;
  FDragExpandDelay := 500;

  FGradientSteps := 64;

  FDelayTimer := TTimer.Create(self);

  FDelayTimer.Enabled := false;
  FDelayTimer.OnTimer := OnDelayTimer;
  FInplaceEditorDelay := 500;
  FIncrementalSearchTimeout := 500;

  FHook := TElHook.Create(nil);
  FHook.OnBeforeProcess := OnBeforeHook;
  DragCursor := crDrag; // to preserve right behavior in future versions of VCL
  FDoubleBuffered := true;
  FDoubleBufferedOnResize := true;

  // for CLX to work, these must be the last
  FView.Parent := Self;
  FHScrollBar.Parent := Self;
  FVScrollBar.Parent := Self;
  FHeader.Parent := Self;
  FCursor := crArrow;
  DataCacheSize := 200;
end;

destructor TCustomElTree.Destroy;
begin
  inherited Destroying;
  if IsEditing then EndEdit(true);
  FBackground.Free;
  ImageForm := nil;
  FreeAndNil(FImgFormChLink);
  UseXPThemes := false;
  FCheckBoxGlyph.Free;
  FRadioButtonGlyph.Free;

  FPlusPicture.Free;
  FMinusPicture.Free;
  FLeafPicture.Free;

  FItems.Free;
  DataCacheDeallocate;

  FView.FRender.Free;

  if FDropTarget <> nil then
     FDropTarget.Free;

  FView.Free;
  FVertScrollBarStyle.Free;
  FHorzScrollBarStyle.Free;
  FHScrollBar.Free;
  FVScrollBar.Free;
  FHeader.Free;
  FHeaderFont.Free;
  FDelayedItem := nil;
  FDelayTimer.Free;
  FDelayTimer := nil;
  if FSelectedList <> nil then
    FSelectedList.Free;
  FAllList.Free;
  if Font <> nil then Font.OnChange := nil;
  if FImages <> nil then FImages.UnregisterChanges(FImageChangeLink);
  if FImages2 <> nil then FImages2.UnregisterChanges(FImageChangeLink);
  if FAlphaImages <> nil then FAlphaImages.UnregisterChanges(FAImageChangeLink);
  if FAlphaImages2 <> nil then FAlphaImages2.UnregisterChanges(FAImageChangeLink);
  FImageChangeLink.Free;
  FAImageChangeLink.Free;
  //BMP.Free;

  FEditorManager.Free;
  FSortSections.Free;
  FSortSections := nil;
  FHook.Free;
  FHook := nil;
  inherited Destroy;
end;

procedure TCustomElTree.SetLinkColor(newValue : TColor);
begin
  if (FLinkColor <> newValue) then
  begin
    FLinkColor := newValue;
    ReRenderAllHTMLItems;
    Repaint;
  end;
end;

procedure TCustomElTree.SetLinkStyle(newValue : TFontStyles);
begin
  if (FLinkStyle <> newValue) then
  begin
    FLinkStyle := newValue;
    ReRenderAllHTMLItems;
    Repaint;
  end;
end;

procedure TCustomElTree.CreateWindowHandle(const Params: TCreateParams);
begin
  inherited CreateWindowHandle(Params);
  AlignPieces;
end; {CreateWindowHandle}

function TCustomElTree.GetSelCount;
begin
  if MultiSelect then
  begin
    result := FSelectedList.Count;
  end else
  begin
    if ItemFocused = nil then result := 0 else result := 1;
  end;
end;

procedure TCustomElTree.CreateParams;
const
  BorderStyles: array[TBorderStyle] of DWord = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle] or (WS_HSCROLL or WS_VSCROLL);

    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;

    //with Params.WindowClass do
      style := style and not (CS_HREDRAW or CS_VREDRAW);
    Params.WindowClass.style := Params.WindowClass.style or CS_HREDRAW or CS_VREDRAW;
    if RightAlignedText then
      ExStyle := ExStyle or WS_EX_RTLREADING or WS_EX_RIGHT and (not WS_EX_RIGHTSCROLLBAR);
  end;
end;

procedure TCustomElTree.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then RecreateWnd;
  inherited;
end;

procedure TCustomElTree.SetHorzScrollBarStyle(newValue : TElScrollBarStyles);
begin
  FHorzScrollBarStyle.Assign(newValue);
end;

procedure TCustomElTree.SetVertScrollBarStyle(newValue : TElScrollBarStyles);
begin
  FVertScrollBarStyle.Assign(newValue);
end;

function TCustomElTree.GetItemAt;
begin
  y := Y - FView.Top;
  X := X - FView.Left;
  result := FView.GetItemAt(X, Y, ItemPart, HitColumn);
end;

procedure TCustomElTree.SetImages;
var
  i: integer;
begin
  if FImages = value then exit;
  IsUpdating := true;
  if FImages <> nil then
  begin
    FImages.RemoveFreeNotification(Self);
    FImages.UnRegisterChanges(FImageChangeLink);
  end;
  FImages := Value;
  if FImages <> nil then
  begin
    FImages.RegisterChanges(FImageChangeLink);
    FImages.FreeNotification(Self);
  end;
  if csDestroying in ComponentState then exit;
  i := DefineLineHeight;
  if FAutoLineHeight and (i <> FLineHeight) then
  begin
    FLineHeight := i;
    with FView do
    begin
      FClearVis := true;
      FClearAll := true;
    end;
  end;
  if not FShowHeader then
  begin
    with FView do
    begin
      FHRange := -1;
      DefineHRange;
    end;
    if RightAlignedView then
    begin
      FRightAlignedView := false;
      RightAlignedView := true;
    end;
  end else
  begin
    if FShowHeader and Assigned(FHeader.Sections[FMainTreeCol]) then
      if FHeader.Sections[FMainTreeCol].AutoSize then
        if (FUpdateCount = 0) then
          AutoSizeColumn(FMainTreeCol)
        else
          FColSizeUpdate := true;
  end;
  with FView do
  begin
    FRangeUpdate := true;
    FUpdated := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.SetAlphaImages;
{var
  i: integer;}
begin
  if FAlphaImages = value then exit;
  IsUpdating := true;
  if FAlphaImages <> nil then
  begin
    if not (csDestroying in FAlphaImages.ComponentState) then
      FAlphaImages.RemoveFreeNotification(Self);
    FAlphaImages.UnRegisterChanges(FAImageChangeLink);
  end;
  FAlphaImages := Value;
  if FAlphaImages <> nil then
  begin
    FAlphaImages.RegisterChanges(FAImageChangeLink);
    FAlphaImages.FreeNotification(Self);
  end;
  if csDestroying in ComponentState then exit;
{
  i := DefineLineHeight;
  if FAutoLineHeight and (i <> FLineHeight) then
  begin
    FLineHeight := i;
    with FView do
    begin
      FClearVis := true;
      FClearAll := true;
    end;
  end;
  if not FShowHeader then
  begin
    with FView do
    begin
      FHRange := -1;
      DefineHRange;
    end;
    if RightAlignedView then
    begin
      FRightAlignedView := false;
      RightAlignedView := true;
    end;
  end else
  begin
    if FShowHeader and FHeader.Sections[FMainTreeCol].AutoSize then
      if (FUpdateCount = 0) then
        AutoSizeColumn(FMainTreeCol)
      else
        FColSizeUpdate := true;
  end;
}
  with FView do
  begin
    FRangeUpdate := true;
    FUpdated := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.SetLineStyle;
begin
  if FShowLines = value then exit;
  IsUpdating := true;
  FShowLines := value;
  with FView do
  begin
    if not FShowHeader then FHRange := -1;
    FRangeUpdate := true;
    FUpdated := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.SetShowEmptyImages(newValue : boolean);
begin
  if FShowEmptyImages <> newValue then
  begin
    FShowEmptyImages := newValue;
    if (not ShowImages) or (FImages = nil) then exit;
    IsUpdating := true;
    with FView do
    begin
      if not FShowHeader then FHRange := -1;
      FUpdated := true;
      FRangeUpdate := true;
    end;
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.SetShowEmptyImages2(newValue : boolean);
begin
  if FShowEmptyImages2 <> newValue then
  begin
    FShowEmptyImages2 := newValue;
    if (not ShowImages) or (FImages = nil) then exit;
    IsUpdating := true;
    with FView do
    begin
      if not FShowHeader then FHRange := -1;
      FUpdated := true;
      FRangeUpdate := true;
    end;
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.SetRootStyle;
begin
  if FShowRoot = value then exit;
  IsUpdating := true;
  FShowRoot := value;
  with FView do
  begin
    if not FShowHeader then
      FHRange := -1;
    FUpdated := true;
    FRangeUpdate := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.SetImagesStyle;
var
  i: integer;
begin
  if FShowImages = value then exit;
  IsUpdating := true;
  FShowImages := value;
  if not FShowHeader then FView.FHRange := -1;
  i := DefineLineHeight;
  if FAutoLineHeight and (i <> FLineHeight) then
  begin
    FLineHeight := i;
    with FView do
    begin
      FClearVis := true;
      FClearAll := true;
    end;
  end;
  with FView do
  begin
    FRangeUpdate := true;
    FUpdated := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.ImageListChange;
var
  i: integer;
begin
  if FView.FPainting then exit;
  IsUpdating := true;
  if AutoLineHeight then
  begin
    i := DefineLineHeight;
    if i <> FLineHeight then
    begin
      with FView do
      begin
        FClearVis := true;
        if i < FLineHeight then FClearAll := true;
      end;
      FLineHeight := i;
    end;
  end;
  with FView do
  begin
    FUpdated := true;
    FRangeUpdate := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.SetBorderStyle;
begin
  if FBorderStyle = value then exit;
  FBorderStyle := value;
  RecreateWnd;
end;

procedure TCustomElTree.SetButtonStyle;
begin
  if FShowButtons = value then exit;
  IsUpdating := true;
  FShowButtons := value;
  with FView do
  begin
    if not FShowHeader then FHRange := -1;
    FUpdated := true;
    FRangeUpdate := true;
  end;
  IsUpdating := false;
end;

function TCustomElTree.GetUpdating : boolean;
begin
  result := FUpdateCount > 0;
end;

procedure TCustomElTree.SetUpdating;
var
  i: integer;
begin
  if FProcUpdate then exit;

  if value = true then
  begin
    if FUpdateCount = 0 then
      DoBeginUpdate;
    FHeader.BeginUpdate;
    inc(FUpdateCount)
  end
  else
  begin
    dec(FUpdateCount);
    FHeader.EndUpdate;
    if FUpdateCount = 0 then
      DoEndUpdate;
  end;

  if FUpdateCount > 0 then
    exit;
  if (csDestroying in ComponentState) or (csLoading in ComponentState) then
    exit;
  FProcUpdate := true;
  if FilteredVisibility then
    UpdateDiffItems;
  with FView do
  begin
    if FAutoLineHeight then
    begin
      i := DefineLineHeight;
      if i <> FLineHeight then
      begin
        FClearVis := true;
        FLineHeight := i;
      end;
    end;
    if (FHRange = -1) and (not FShowHeader) then FView.DefineHRange;
    if FSortRequired then
    begin
      TriggerSortBegin;
      Sort(true);
      TriggerSortEnd;
      FSortRequired := false;
    end;
    if FUpdated then
    begin
      if FVisUpdated then // recount visibles
      begin
        TotalVisCount := GetTotalVisCount;
        FVisUpdated := false;
      end;
      IgnoreResize := true;
      if (not (csLoading in ComponentState)) and (HandleAllocated) then
      begin
        UpdateScrollBars;
      end;
      IgnoreResize := false;
      if FClearVis and HandleAllocated then // refresh FVisible
      begin
        DoSetTopIndex(FTopIndex);
        FClearVis := false;
      end;
      IgnoreResize := true;
      if FShowHeader and (VirtualityLevel = vlNone) and (FColSizeUpdate) then
      begin
        FColSizeUpdate := false;
        AutoSizeAllColumns;
      end;
      if (not (csLoading in ComponentState)) and (HandleAllocated) then
        UpdateScrollBars;
      IgnoreResize := false;
      UpdateView;
      FUpdated := false;
    end;
  end;
  FProcUpdate := false;
end;

procedure TCustomElTree.DoBeginUpdate; { protected }
begin
  if Assigned(FOnBeginUpdate) then FOnBeginUpdate(self);
end; { DoBeginUpdate }

procedure TCustomElTree.DoEndUpdate; { protected }
begin
  if Assigned(FOnEndUpdate) then FOnEndUpdate(self);
end; { DoEndUpdate }

function TCustomElTree.GetTotalVisCount;
var i, j, idx : integer;
    Item : TElTreeItem;
begin
  i := 0;
  idx := 0;
  j := FAllList.Count;
  while i < j do
  begin
    Item := TElTreeItem(FAllList[i]);
    if (FilteredVisibility and Item.Hidden) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end else
    begin
      inc(idx);
      if not Item.Expanded then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    inc(i);
  end;
  result := idx;
  TotalVisCount := result;
end;

procedure TCustomElTree.UpdateScrollBars;

  function UpdHBar: boolean;
  var
    b1: boolean;
    ScrollInfo: TScrollInfo;
    CurPos: integer;
    hsw : integer;
  begin
    b1 := FHScrollVisible;
    ScrollInfo.cbSize := Sizeof(ScrollInfo);
    ScrollInfo.fMask := SIF_POS or SIF_RANGE;
    GetScrollInfo(FHScrollBar.Handle, SB_CTL, ScrollInfo);
    if FShowHeader then
    begin
      FView.FHRange := 0;
      if FHeader.Sections.Count > 0 then
      begin
        hsw := FHeader.SectionsWidth;
        ScrollInfo.nMax := hsw;
        FView.FHRange := hsw;
      end
         else ScrollInfo.nMax := 0;
    end
    else
      ScrollInfo.nMax := FView.FHRange;
    if ScrollInfo.nMax < 0 then
      ScrollInfo.nMax := 0;
    ScrollInfo.nPage := FView.ClientWidth + 1;

    FHScrollVisible := (ScrollInfo.nMax - Integer(ScrollInfo.nPage) > 0) and (not FHideHorzScrollBar);
    if (not FHScrollVisible) then
    begin
      ScrollInfo.nMax := 0;
      FHPos := 0;
      FHeader.LeftPos := 0
      //LockedColumn, update
      //if FHeader.Left < 0 then FHeader.Left := 0;
    end;
    FHScrollVisible := FHScrollVisible or (ForcedScrollBars in [ssHorizontal, ssBoth]);
    result := (FHScrollVisible <> b1);// and (not (ForcedScrollBars in [ssHorizontal, ssBoth]));

    FHPos := Min(FHPos, Max(0, ScrollInfo.nMax));
    CurPos := FHPos;
    ScrollInfo.fMask := SIF_ALL;

    ScrollInfo.nMin := 0;
    ScrollInfo.cbSize := SizeOf(ScrollInfo);
    ScrollInfo.nPos := CurPos;
    ScrollInfo.nTrackPos := CurPos;

    SetScrollInfo(FHScrollBar.Handle, SB_CTL, ScrollInfo, true);
//    CurPos := THackScrollBar(FHScrollBar).UpdateThumbPos;
    if not IsEditing then
      FHScrollBar.Position := CurPos;
    // Set info for hidden standard scrollbar
    if FUseCustomBars or (ForcedScrollBars in [ssHorizontal, ssBoth]) then
       ScrollInfo.fMask := ScrollInfo.fMask or SIF_DISABLENOSCROLL;
    Windows.SetScrollInfo(Handle, SB_HORZ, ScrollInfo, not FUseCustomBars);
    Windows.SetScrollInfo(FView.Handle, SB_HORZ, ScrollInfo, not FUseCustomBars);
    if (FHeader.LeftPos <> FHPos) then
      FHeader.LeftPos := FHPos;
    FHScrollVisible := FHScrollVisible or (ForcedScrollBars in [ssHorizontal, ssBoth])
  end;

  function UpdVBar: boolean;
  var
    b: boolean;
    CHeight   : integer;
    ScrollInfo: TScrollInfo;
    maxV      : integer;
  begin
    if TotalVisCount = 0 then
      GetTotalVisCount;
    maxV := TotalVisCount - 1;

    if TotalVarHeightCount > 0 then
      MaxV := FView.CalcPageUpPos(maxV);

    ScrollInfo.nMax := maxV;

    ScrollInfo.fMask := SIF_ALL;
    ScrollInfo.nMin := 0;
    ScrollInfo.cbSize := SizeOf(ScrollInfo);
    ScrollInfo.nPos := FTopIndex;
    ScrollInfo.nTrackPos := FTopIndex;
    B := FVScrollVisible;
    CHeight := FView.Height;
    FVScrollVisible := ((FTopIndex > 0) or (FView.GetVisiblesHeight > CHeight) or ((ScrollInfo.nMax > FView.FVisible.Count) and (FView.FVisible.Count > 0))) and (not FHideVertScrollBar);
    //if (FTopIndex > 0) and (not FHideVertScrollBar) then FVScrollVisible := true;

    if TotalVarHeightCount > 0 then
      ScrollInfo.nPage := 1// min((FView.CalcPageDownPos(TopIndex) - FView.CalcPageUpPos(TopIndex)) shr 1{TopIndex}, View.GetVisCount - 1)
    else
      ScrollInfo.nPage := View.GetVisCount - 1;

    if not (FVScrollVisible) then
    begin
      ScrollInfo.nMax := 0;
      ScrollInfo.nPage := 1;
    end;
    FVScrollVisible := FVScrollVisible or (ForcedScrollBars in [ssVertical, ssBoth]);

    SetScrollInfo(FVScrollBar.Handle, SB_CTL, ScrollInfo, true);
    // Set info for hidden standard scrollbar

    //ScrollInfo.fMask := SIF_POS or SIF_RANGE or SIF_PAGE;
    if FUseCustomBars or (ForcedScrollBars in [ssVertical, ssBoth]) then
       ScrollInfo.fMask := ScrollInfo.fMask or SIF_DISABLENOSCROLL;

    Windows.SetScrollInfo(Handle, SB_VERT, ScrollInfo, not FUseCustomBars);
    Windows.SetScrollInfo(FView.Handle, SB_VERT, ScrollInfo, not FUseCustomBars);
    result := (FVScrollVisible <> b);// and (not (ForcedScrollBars in [ssVertical, ssBoth]));
    FVScrollVisible := FVScrollVisible or (ForcedScrollBars in [ssVertical, ssBoth])
end;

// var FHVis, FVVis : boolean;
var i : integer;
begin
  // FHVis := FHScrollVisible;
  // FVVis := FVScrollVisible;
  i := 0;
  while UpdHBar or UpdVBar do
  begin
    AlignPieces;
    inc(i);
    if i > 3 then break;
  end;
  {
  if (FHVis <> FHScrollVisible) or (FVVis <> FVScrollVisible) then
  begin
    AlignPieces;
  end;
  }
  if not FScrollbarsInitialized then
  begin
    FScrollbarsInitialized := true;
    if UseCustomScrollbars then
      PostMessage(Handle, WM_UPDATESBFRAME, 0, 0);
    end;
  if FUseCustomBars and (BorderStyle = bsSingle) then
     DrawFlatBorder(false, false);
end;

procedure TCustomElTree.SetHLines;
var
  i: integer;
begin
  if FHorizontalLines = value then exit;
  IsUpdating := true;
  FHorizontalLines := value;
  if FAutoLineHeight then
  begin
    i := DefineLineHeight;
    if i <> FLineHeight then
    begin
      FLineHeight := i;
      with FView do
      begin
        FClearVis := true;
        FClearAll := true;
      end;
    end;
  end;
  with FView do
  begin
    FRangeUpdate := true;
    FUpdated := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.SetVLines;
begin
  if FVerticalLines = value then exit;
  IsUpdating := true;
  with FView do
  begin
    FVerticalLines := value;
    FClearAll := true;
    FUpdated := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.OnHeaderSectionResize;
begin
  IsUpdating := true;
  ResetAllItemsHeight;
  ReRenderAllHTMLItems;

  if not (csLoading in ComponentState) then
    DoOnColumnResize(Section.Index);

  with FView do
  begin
    FUpdated := true;
    FRangeUpdate := true;
    FClearVis := true;
    if FVerticalLines then FClearAll := true else FRangeUpdate := true;
  end;
  if RightAlignedView then
    FHScrollBar.Refresh;
  IsUpdating := false;
  {if FHeader.SectionsWidth < FView.Width then AlignPieces;}
end;

type
  TSRecInt = record
    Text: PLMDChar;
    ColNum: integer;
  end;
  PSRecInt = ^TSRecInt;
  function TCustomElTree.IntCompare(Item: TElTreeItem; SearchDetails: TLMDDataTag): boolean;
var
  i: integer;
  AT: TLMDString;
  begin
  with PSRecInt(SearchDetails)^ do
  begin
    i := ColNum;
    if Item.FOwner.MainTreeColumn = i then
      AT := AnsiUpperCase(Item.Text)
    else
    begin
      if Item.FStaticData <> nil then
      begin
        if Item.ColumnText.Count <= i then
          AT := ''
        else
        begin
          if I > Item.FOwner.MainTreeColumn then
            AT := AnsiUpperCase(Item.ColumnText[i - 1])
          else
            AT := AnsiUpperCase(Item.ColumnText[i]);
        end;
      end
      else
      begin
        Item.FOwner.TriggerVirtualTextNeeded(Item, i, AT);
        AT := AnsiUpperCase(AT);
      end;
    end;
    {$ifndef LMD_UNICODE}
    result := Pos(AnsiUpperCase(StrPas(PChar(Text))), AT) = 1;
    {$else}
    Result := LMDWidePos(LMDWideUpperCase(LMDWideStrPas(PWideChar(Text))), AT) = 1;
    {$endif}
    end;
  end;

procedure TCustomElTree.OnHeaderSectionLookup(Sender: TObject; Section: TElHeaderSection; var Text: TLMDString);
var
  SRec: TSRecInt;
  TI: TElTreeItem;
begin
  TriggerHeaderLookupEvent(Section, Text);
  if AutoLookup then
  begin
    SRec.Text := PLMDChar(Text);
    SRec.ColNum := Section.Index;
    TI := Items.LookForItemEx2(nil, Section.Index, true, false, false, true, @SRec, IntCompare);  (*<+>*)
    if TI <> nil then
    begin
      if Assigned(FView.FFocused) and (FView.FFocused <> TI) then
        FView.FFocused.Selected := false;
      EnsureVisible(TI);
      ItemFocused := TI;
    end;
  end;
  end;

procedure TCustomElTree.OnHeaderExpand;
begin
  TriggerHeaderSectionExpandEvent(Section);
  try
    IsUpdating := true;
    with FView do
    begin
      FUpdated := true;
      FClearAll := true;
    end;
    //if FShowHeader then FHeader.Repaint;
  finally
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.OnHeaderCollapse;
begin
  TriggerHeaderSectionCollapseEvent(Section);
  try
    IsUpdating := true;
    with FView do
    begin
      FUpdated := true;
      FClearAll := true;
    end;
    //if FShowHeader then FHeader.Repaint;
  finally
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.OnHeaderSectionLookupDone(Sender: TObject; Section: TElHeaderSection; Text: TLMDString; Accepted: boolean);
begin
  TriggerHeaderLookupDoneEvent(Section, Text, Accepted);
end;

procedure TCustomElTree.DoHeaderMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
begin

  if FView.FInpEdit <> nil then FView.DoEndEdit(not ExplorerEditMode);

  if Assigned(FOnHeaderMouseDown) then
    FOnHeaderMouseDown(Sender, Button, Shift, X, Y);
end;

procedure TCustomElTree.OnHeaderSectionClick;
begin
  DoColumnClick(Section.Index);
  if (FSortMode = smClick) or (FSortMode = smAddClick) then
  begin
    IsUpdating := true;
    if not (ssCtrl in LMDGetShiftState) then
    begin

      FHeader.MultiSort := false;

      if FSortSections <> nil then
        FSortSections.Clear;
//      SortSection := Section.Index;
      if (Section.SortMode = hsmNone) then
      begin
        (*
        if SortSection <> -1 then
        begin
          Section.SortMode := FHeader.Sections[SortSection].SortMode;
        end
        else
        if SortDir = sdAscend then
        begin
          Section.SortMode := hsmDescend;
          // SortDir := sdDescend;
        end
        else
        begin
          Section.SortMode := hsmAscend;
          // SortDir := sdAscend;
        end;
        *)
      end;
      if Section.SortMode = hsmAscend then
      begin
        Section.SortMode := hsmDescend;
        //SortDir := sdDescend;
      end
      else
      begin
        Section.SortMode := hsmAscend;
        //SortDir := sdAscend;
      end;
      if Section.SortMode <> hsmNone then
      begin
        if FSortSections = nil then
          FSortSections := TLMDObjectList.Create;
        AddSortSection(Section.Index, false);
      end;
      SortSection := Section.Index;
      (*
      case Section.FieldType of
        sftText: SortType := stText;
        sftNumber: SortType := stNumber;
        sftFloating: SortType := stFloating;
        sftDateTime: SortType := stDateTime;
        sftDate: SortType := stDate;
        sftTime: SortType := stTime;
        sftBool: SortType := stBoolean;
        sftCurrency: SortType := stCurrency;
      else
        SortType := stCustom;
      end;
      *)

      FHeader.MultiSort := true;

    end
    else
    begin
      if FSortSections = nil then
        FSortSections := TLMDObjectList.Create;
      if Section.SortMode = hsmNone then
      begin
        Section.SortMode := hsmAscend;
        AddSortSection(Section.Index, false);
      end
      else
      if Section.SortMode = hsmAscend then
      begin
        Section.SortMode := hsmDescend;
        if FSortSections.IndexOf(Section) = -1 then
          FSortSections.Add(Section);
      end
      else
      begin
        Section.SortMode := hsmNone;
        RemoveSortSection(Section.Index, false);
      end;
    end;
    TriggerSortBegin;
    FItems.FRoot.Sort(true);
    TriggerSortEnd;
    with FView do
    begin
      FUpdated := true;
      FRangeUpdate := true;
      FVisUpdated := true;
    end;
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.OnSignChange(Sender: TObject);
var
  i: integer;
begin
  if not FCustomPlusMinus then exit;
  IsUpdating := true;
  if AutoLineHeight then
  begin
    i := DefineLineHeight;
    if i <> FLineHeight then
    begin
      with FView do
      begin
        FClearVis := true;
        if i < FLineHeight then FClearAll := true;
      end;
      FLineHeight := i;
    end;
    FView.FVisUpdated := true;
  end;
  with FView do
  begin
    FRangeUpdate := true;
    FUpdated := true;
  end;
  IsUpdating := false;
end;

function TCustomElTree.IsHeaderFontStored;
begin
  result := not FHeaderUseTreeFont;
end;

function TCustomElTree.IsFontStored;
begin
  result := not ParentFont;
end;

procedure TCustomElTree.OnFontChange;
begin
  (*
  if FView.FPainting then exit;
  IsUpdating := true;

  ParentFont := false;

  Canvas.Font.Assign(Font);
  {$ifndef C LX_USED}
  Perform(CM_FONTCHANGED, 0, 0);
  {$else}
  NotifyControls(CM_PARENTFONTCHANGED);
  {$endif}
  if HeaderUseTreeFont then
    FHeader.Font.Assign(Font);
  //TElHeaderHack(FHeader).OnFontChange(FHeader.Font);
  ReRenderAllHTMLItems;
  if AutoLineHeight then
  begin
    i := DefineLineHeight;
    if i <> FLineHeight then
    begin
      with FView do
      begin
        FClearVis := true;
        if i < FLineHeight then FClearAll := true;
      end;
      FLineHeight := i;
    end;
  end;
  with FView do
  begin
    FUpdated := true;
    FRangeUpdate := true;
  end;
  IsUpdating := false;
  *)
end;

function TCustomElTree.GetHeaderWrapCaptions : boolean;
begin
  result := TElHeader(FHeader).WrapCaptions;
end;

procedure TCustomElTree.SetHeaderWrapCaptions(Value : boolean);
begin
  TElHeader(FHeader).WrapCaptions := value;
end;

procedure TCustomElTree.SetHeaderHotTrack;
begin
  FHeaderHotTrack := value;
  FHeader.Tracking := value;
end;

procedure TCustomElTree.SetRowSelect;
begin
  IsUpdating := true;
  FRowSelect := value;
  if FRowSelect = false then
    FullRowSelect := false;
  with FView do
  begin
    FClearAll := true;
    FClearVis := true;
    FUpdated := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.SetMultilineEllipsis(const Value: boolean);
begin
  if FMultilineEllipsis <> Value then
  begin
    FMultilineEllipsis := Value;
    Repaint;
  end;
end;

procedure TCustomElTree.SetMultiSelect;
var TSI: TElTreeItem;
begin
  if Value <> FMultiSelect then
  begin
    IsUpdating := true;
    FUpdated := true;
    TSI := ItemFocused;
    if Value = true then
    begin
      FMultiSelect := true;
      FSelectedList := TLMDObjectList.Create;
      with FView do
        if FSelected <> nil then
          FSelectedList.Add(FSelected);
    end
    else
    begin
      DeselectAllEx(true);
      FMultiSelect := false;
      if TSI <> nil then
      begin
        TSI.Focused := true;
        TSI.Selected := true;
      end;
      FSelectedList.Free;
      FSelectedList := nil;
    end;
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.SetMultiSelectLevel;    // CNS
var TSI: TElTreeItem;
begin
  if Value<>FMultiSelectLevel then
  begin
    IsUpdating := True;
    FUpdated := true;
    FMultiSelectLevel := value;
    TSI := ItemFocused;
    DeselectAllEx(True);  // just deselect everything on change
    if TSI <> nil then    // and reselected the focused item
    begin
      TSI.Focused := true;
      TSI.Selected := true;
    end;
    IsUpdating := false;
  end;
end;

function TCustomElTree.DoSetFocused(value: TElTreeItem; Forced : boolean):
    Boolean;
begin
   result := DoSetFocusedEx(value, Forced, false);
end;

function TCustomElTree.DoSetFocusedEx(value: TElTreeItem; Forced, Delayed :
    boolean): Boolean;
var
  AnItem,
  FOld     : TElTreeItem;
  DoChange : boolean;

begin

  result := false;
  (*if (value <> nil) and
     (not value.AllowSelection) then exit;
  *)
  if FView.FFocused <> Value then
  begin
    DoChange := Forced;
    DoChanging(Value, DoChange);

    if (not Forced) and (not DoChange) then
    begin
      if MultiSelect then
        FView.DoSetSelected(FView.FFocused);
      exit;
    end;

    IsUpdating := true;
    try
      AnItem := FView.FFocused;
      if AnItem <> nil then with AnItem do
      begin
        if FMultiSelect then
          FBoolData := FBoolData and not ibfFocused
        else
          FBoolData := FBoolData and not ibfFocused and not ibfSelected;
        RedrawItem(true);
        FView.FFocused := nil;
        if FAutoExpand and (value <> nil) then
        begin
          FOld := AnItem;
          if AutoCollapse then
          while (FOld <> nil) and (not Value.IsUnder(FOld)) do
          begin
            FOld.Collapse(false);
            FOld := FOld.Parent;
          end; // while
          FUpdated := true;
        end;
      end;
      result := true;
      with FView do
      (*
      if FItemToEdit = FFocused then
        FItemToEdit := value
      else
        FView.FItemToEdit := nil;
      *)
      if FEditTimer <> nil then
        FEditTimer.Enabled := false;
      FView.FFocused := value;
      if (Assigned(Value) and (not Value.Selected)) or not FAlwaysKeepSelection then
        FView.DoSetSelected(value);
      if FView.FFocused <> nil then
      begin
        if (FVirtualityLevel >= vlAllProps) and (not (csDesigning in ComponentState)) then
          CacheItem(Value, FView.FVisible.Count);

        with FView do
        begin
          FFocused.FBoolData := FFocused.FBoolData or ibfFocused;
          FFocused.RedrawItem(true);
          if FAutoExpand then FFocused.Expand(false);
        end;
        if not (csDestroying in ComponentState) then
        begin
          with FView do
            if (FVisible.IndexOf(FFocused) = FVisible.Count - 1) and
               (GetVisiblesHeight > Height  + LineHeight div 4) and (FVisible.Count > 1) then
              TopIndex := TopIndex + 1;
        end;
      end;
      if (FChangeDelay = 0) or (not Delayed) then
        DoItemFocused
      else
      begin
        StopDelayedFocus;
        StartDelayedFocus(FView.FFocused);
      end;
      FUpdated := true;
    finally
      IsUpdating := false;
    end;
  end;
end;

procedure TCustomElTree.DoChanging(Item : TElTreeItem; var AllowChange: Boolean);
begin
  if Assigned(FOnChanging) and (FFireFocusEvents = 0) then
     FOnChanging(Self, Item, AllowChange)
  else AllowChange := true;
end;

procedure TCustomElTree.SetFocused;
begin
 DoSetFocused(Value, false);
end;

function TCustomElTree.GetNextSelected;
var i : integer;
begin
  if not (FMultiSelect) then
  begin
    if Prev = nil then
       result := ItemFocused
    else
       result := nil;
    exit;
  end;

  if (Prev = nil) and (FSelectedList.Count > 0) then
     result := TElTreeItem(FSelectedList[0])
  else
  begin
    i := FSelectedList.IndexOf(Prev);
    if (i <> -1) and (i < FSelectedList.Count - 1) then
       result := TElTreeItem(FSelectedList[i+1])
    else
       result := nil;
  end;
end;

procedure TCustomElTree.AllSelected(SelectedItems: TLMDObjectList);
begin
  if FMultiSelect then
    SelectedItems.Assign(FSelectedList)
  else
  begin
    SelectedItems.Clear;
    if (ItemFocused <> nil) then
      SelectedItems.Add(ItemFocused);
  end;
end;

procedure TCustomElTree.EnsureVisibleEx(Item: TElTreeItem; Expande: Boolean);
begin
  if IsUpdating then exit;
  FView.FillVisFwd(TopIndex);

  if Item = nil then
     exit;
  if FView.FVisible.IndexOf(Item) <> -1 then exit;
  if (Expande) and (not Item.FullyExpanded) then
     Item.MakeFullyExpanded(true);

  if FView.FVisible.IndexOf(Item) <> -1 then exit;

  IsUpdating := true;
  SetVPosition(Item.VisIndex);
  FUpdated := true;
  with FView do
  begin
    FRangeUpdate := true;
    FClearAll := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.EnsureVisibleBottomEx(Item: TElTreeItem; Expande: Boolean);
begin
  if IsUpdating then exit;
  if Item = nil then exit;
  if FView.FVisible.IndexOf(Item) <> -1 then exit;
  if (Expande) and (not Item.FullyExpanded) then
     Item.MakeFullyExpanded(true);
  IsUpdating := true;
  SetVPosition(FView.CalcPageUpPos(Item.VisIndex){ + 1});
  FUpdated := true;
  with FView do
  begin
    FRangeUpdate := true;
    FClearAll := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.EnsureVisible;
begin
  EnsureVisibleEx(Item,True);
end;

procedure TCustomElTree.EnsureVisibleBottom;
begin
  EnsureVisibleBottomEx(Item,True);
end;

procedure TCustomElTree.SetAutoLineHeight;
begin
  if FAutoLineHeight = value then
     exit;
  IsUpdating := true;
  FAutoLineHeight := value;
  if value = true then
     FLineHeight := DefineLineHeight;
  FUpdated := true;
  with FView do
  begin
    FClearAll := true;
    FClearVis := true;
  end;
  FUpdated := true;
  IsUpdating := false;
end;

procedure TCustomElTree.SetItemIndent(value: integer);
begin
  if ItemExt <> Value then
  begin
    IsUpdating := true;
    ItemExt := Value;
    FUpdated := true;
    FView.FClearAll := true;
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.SetLineHeight;
begin
  if (FLineHeight = value) or FAutoLineHeight then
     exit;
  IsUpdating := true;
  FUpdated := true;
  FLineHeight := value;
  with FView do
  begin
    FClearVis := true;
    FClearAll := true;
  end;
  if value = 0 then FLineHeight := DefineLineHeight;
  IsUpdating := false;
end;

function TCustomElTree.DefineLineHeight;
var
  m: integer;
begin
  m := 0;
  if FShowImages then
  begin
    if (Images <> nil) then m := Images.Height;
    if (Images2 <> nil) then m := Max(m, Images2.Height);
  end;
  if ItemExt > m then m := ItemExt;
  if Font.Height < 0 then
     m := max(m, Abs(Font.Height) + 4)
  else
     m := max(m, Abs(Font.Height) + 2);
  if ShowCheckboxes then
  begin
    if CustomCheckboxes then
    begin
      m := Max(m, Max(FRadioButtonGlyph.Height, FCheckBoxGlyph.Height));
    end else
    begin
      m := max(m, ItemExt - 2);
    end;
  end;
  result := m;
  if FBarStyle then inc(result, 2);
  if FHorizontalLines and not (FBarStyle) then inc(result, FDivLineWidth);
end;

procedure TCustomElTree.WMSize;
begin
  inherited;

  if Flat or FUseCustomBars or IsThemed then UpdateFrame;
end;

procedure TCustomElTree.Resize;
begin

  inherited;

  IsUpdating := true;
  AlignPieces;
  (*
  with FView do
  begin
    FVisUpdated := true;
    FClearAll := true;
    FClearVis := true;
  end;
  FUpdated := true;
  *)

  if IsThemed or (Flat and (BorderStyle <> bsNone)) then
    DrawFlatBorder(false, false);

  IsUpdating := false;
end;

function TCustomElTree.GetItemRect;
begin
  result := FView.GetItemRect(ItemIndex);
  OffsetRect(result, 0, FView.Top);
end;

procedure TCustomElTree.OnHeaderSectionVisChange(Sender: TCustomElHeader; Section: TElHeaderSection); { private }
begin
  IsUpdating := true;
  with FView do
  begin
    FClearAll := true;
    FHRange := -1;
  end;
  if FHeader.SectionsWidth < FView.Width then
  begin
    FHeader.Invalidate;
    SetHPosition(0);
  end;
  FUpdated := true;
  IsUpdating := false;
end; { OnHeaderSectionVisChange }

procedure TCustomElTree.DoOnColumnResize(SectionIndex: integer); { protected }
begin
  if Assigned(FOnColumnResize) then FOnColumnResize(self, SectionIndex);
end; { DoOnColumnResize }

procedure TCustomElTree.DoColumnClick(SectionIndex: integer); { protected }
begin
  if Assigned(FOnColumnClick) then FOnColumnClick(self, SectionIndex);
end; { DoColumnClick }

procedure TCustomElTree.DoItemFocused; { protected }
begin
  if Assigned(FOnItemFocused) and
     (not (csDestroying in ComponentState)) and
     (FFireFocusEvents = 0) then
    FOnItemFocused(self);
end; { DoItemFocused }

procedure TCustomElTree.DoItemDraw(Item: TElTreeItem; Surface: TCanvas; R: TRect; SectionIndex: integer); { protected }
begin
  if Assigned(FOnItemDraw) then FOnItemDraw(Self, Item, Surface, R, SectionIndex);
end; { DoItemDraw }

procedure TCustomElTree.DoEndEditItem(Item: TElTreeItem; Section: TElHeaderSection; Canceled: boolean);
begin
  if Assigned(FOnEndEdit) then FOnEndEdit(Self, Item, Section, Canceled);
end;

procedure TCustomElTree.DoShowHint(Item: TElTreeItem; Section : TElHeaderSection; var Text: TLMDString; HintWindow: THintWindow; MousePos: TPoint; var DoShowHint: boolean); { protected }
begin
  if assigned(FOnShowHint) then
    FOnShowHint(Self, Item, Section, Text, HintWindow, MousePos, DoShowHint);
end; { DoShowHint }

procedure TCustomElTree.DoItemChange(Item: TElTreeItem; ItemChangeMode: TItemChangeMode); { protected }
begin
  if Assigned(FOnItemChange) then FOnItemChange(Self, Item, ItemChangeMode);
end; { DoOnItemChange }

procedure TCustomElTree.DoItemExpanding(Item: TElTreeItem; var CanProcess: boolean); { protected }
begin
  if assigned(FOnItemExpanding) then FOnItemExpanding(Self, Item, CanProcess);
end; { DoItemExpanding }

procedure TCustomElTree.DoItemCollapsing(Item: TElTreeItem; var CanProcess: boolean); { protected }
begin
  if assigned(FOnItemCollapsing) then FOnItemCollapsing(Self, Item, CanProcess);
end; { DoItemCollapsing }

procedure TCustomElTree.DoItemChecked(Item : TElTreeItem);  { protected }
begin
  if assigned(FOnItemChecked) then FOnItemChecked(Self, Item);
end;  { DoItemChecked }

procedure TCustomElTree.DoItemExpand(Item: TElTreeItem); { protected }
begin
  if assigned(FOnItemExpand) then FOnItemExpand(Self, Item);
end; { DoItemExpand }

procedure TCustomElTree.DoItemCollapse(Item: TElTreeItem); { protected }
begin
  if assigned(FOnItemCollapse) then FOnItemCollapse(Self, Item);
end; { DoItemCollapse }

procedure TCustomElTree.DoItemDelete(Item: TElTreeItem); { protected }
begin
  if assigned(FOnItemDelete) then FOnItemDelete(Self, Item);
end; { DoItemDelete }

procedure TCustomElTree.DoCompareItems(Item1, Item2: TElTreeItem; var res: integer); { protected }
begin
  if assigned(FOnCompareItems) then
    FOnCompareItems(Self, Item1, Item2, res)
  else
    res := 0;
end; { DoCompareItems }

procedure TCustomElTree.OnHeaderSectionChange(Sender: TCustomElHeader; Section: TElHeaderSection; Change: TSectionChangeMode); { protected }
begin
  case Change of
    scmAlign:
      if Section.Visible then
      begin
        IsUpdating := true;
        FView.FClearAll := true;
        IsUpdating := false;
      end;
    scmStyle:
      if FODFollowCol and Section.Visible then
      begin
        IsUpdating := true;
        FView.FClearAll := true;
        IsUpdating := false;
      end;
    scmPassword:
      if Section.Visible then
        FView.Invalidate;//Repaint;
  end;
end; { OnHeaderSectionChange }

function TCustomElTree.CreateHeader: TElHeader; { protected }
begin
  result := TElHeader.Create(self);
end; { CreateHeader }

procedure TCustomElTree.SetCanEdit(value: boolean);
begin
  FCanEdit := value;
end;

procedure TCustomElTree.OnHeaderSectionCreate(Header: TCustomElHeader; Section: TElHeaderSection); { protected }
begin
  IsUpdating := true;
  FUpdated := true;
  AlignPieces;
  IsUpdating := false;
end; { OnHeaderSectionCreate }

procedure TCustomElTree.Paint; { protected }
var R : TRect;
    ACtl   : TWinControl;
    ax, ay : integer;
    P      : TPoint;
    BgRect : TRect;
    LUseThemeMode: TLMDThemeMode;
    LDetails: TThemedElementDetails;
begin
  LUseThemeMode := UseThemeMode;
  if ((Flat or FUseCustomBars) and (BorderStyle = bsSingle)) or (LUseThemeMode <> ttmNone) then
    DrawFlatBorder(false, false);
  if (FVScrollVisible and FHScrollVisible) and FUseCustomBars then
  begin
    R := Rect(FVScrollbar.Left, FHScrollBar.Top, FVScrollBar.Left + FVScrollBar.Width, FHScrollBar.Top + FHScrollBar.Height);
    if (LUseThemeMode <> ttmNone) then
    begin
      R := Rect(FVScrollbar.Left, FHScrollBar.Top, FVScrollBar.Left + FVScrollBar.Width, FHScrollBar.Top + FHScrollBar.Height);
      InflateRect(R, 1, 1);

      (*
      Canvas.Brush.Style := bsSolid;
      if GetThemeColor(Theme, 0, 0, TMT_BACKGROUND, AColor) <> S_OK then
        Canvas.Brush.Color := Color;
      Canvas.FillRect(R);
      *)

      LDetails.Element := teTreeview;
      LDetails.Part := 0;
      LDetails.State := 0;
      LMDThemeServices.DrawElement(LUseThemeMode, Canvas.Handle, LDetails, R, nil);
      // DrawThemeBackground(Theme, Canvas.Handle, 0, 0, R, nil);
      end
    else
    if (FImgForm <> nil) and (not (csDesigning in FImgForm.GetRealControl.ComponentState)) then
    begin
      //if (FImgForm.Control <> Self) then
      begin
        ACtl := FImgForm.GetRealControl;
        BgRect := R;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := Parent.ClientToScreen(Point(Left, Top));
        ax := BgRect.Left - P.x;
        ay := BgRect.Top - P.y;

        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);
        FImgForm.PaintBkgnd(Canvas.Handle, R, Point(BgRect.Left - ax, BgRect.Top - ay), false);
      end;
    end
    else
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := Color;
      Canvas.FillRect(R);
    end;
  end;
end; { Paint }

function TCustomElTree.GetMoveColumnOnDrag: Boolean;
begin
  result := FHeader.MoveOnDrag;
end; { GetMoveColumnOnDrag }

procedure TCustomElTree.SetMoveColumnOnDrag(newValue: Boolean);
begin
  if (FHeader.MoveOnDrag <> newValue) then FHeader.MoveOnDrag := newValue;
end; { SetMoveColumnOnDrag }

procedure TCustomElTree.SetHideHorzScrollBar(newValue: Boolean);
begin
  if (FHideHorzScrollBar <> newValue) then
  begin
    FHideHorzScrollBar := newValue;
    IsUpdating := true;
    with FView do
    begin
      FVisUpdated := true;
      FClearAll := true;
      FClearVis := true;
    end;
    FUpdated := true;
    AlignPieces;
    IsUpdating := false;
  end; { if }
end; { SetHideHorzScrollBar }

procedure TCustomElTree.SetHideVertScrollBar(newValue: Boolean);
begin
  if (FHideVertScrollBar <> newValue) then
  begin
    FHideVertScrollBar := newValue;
    IsUpdating := true;
    with FView do
    begin
      FVisUpdated := true;
      FClearAll := true;
      FClearVis := true;
    end;
    FUpdated := true;
    AlignPieces;
    IsUpdating := false;
  end; { if }
end; { SetHideVertScrollBar }

procedure TCustomElTree.SetUnderlineTracked(newValue: Boolean);
begin
  if (FUnderlineTracked <> newValue) then
  begin
    FUnderlineTracked := newValue;
    with FView do
      if Tracking and (FTrackItem <> nil) then FTrackItem.RedrawItem(true);
  end; { if }
end; { SetUnderlineTracked }

procedure TCustomElTree.SetCustomCheckboxes(newValue: Boolean);
begin
  if (FCustomCheckboxes <> newValue) then
  begin
    FCustomCheckboxes := newValue;
    if FCustomCheckboxes then
    begin
      GetCheckBoxGlyph;
      GetRadioButtonGlyph;
    end;
    if ShowCheckBoxes then
    begin
      IsUpdating := true;
      FUpdated := true;
      FView.FClearAll := true;
      IsUpdating := false;
    end;
  end; { if }
end; { SetCustomCheckboxes }

procedure TCustomElTree.SetCheckBoxGlyph(newValue: TBitmap);
begin
  CheckBoxGlyph.Assign(newValue);

  if newValue = nil then
    CustomCheckboxes := false;
  if ShowCheckBoxes then
  begin
    IsUpdating := true;
    FUpdated := true;
    FView.FClearAll := true;
    IsUpdating := false;
  end;
end; { SetCheckBoxGlyph }

procedure TCustomElTree.SetRadioButtonGlyph(newValue: TBitmap);
{ Sets data member FRadioButtonGlyph to newValue. }
begin
  RadioButtonGlyph.Assign(newValue);

  if newValue = nil then
    CustomCheckboxes := false;
  if ShowCheckBoxes then
  begin
    IsUpdating := true;
    FUpdated := true;
    FView.FClearAll := true;
    IsUpdating := false;
  end;
end; { SetRadioButtonGlyph }

procedure TCustomElTree.SetShowRootButtons(newValue: Boolean);
begin
  if FShowRootButtons = newValue then exit;
  IsUpdating := true;
  FShowRootButtons := newValue;
  if not FShowHeader then FView.FHRange := -1;
  FUpdated := true;
  FView.FRangeUpdate := true;
  IsUpdating := false;
end;

procedure TCustomElTree.SetSinglelineEllipsis(const Value: boolean);
begin
  if FSinglelineEllipsis <> Value then
  begin
    FSinglelineEllipsis := Value;
    Repaint;
  end;
end;

procedure TCustomElTree.SetHideFocusRect(newValue: Boolean);
begin
  if (FHideFocusRect <> newValue) then
  begin
    FHideFocusRect := newValue;
    if (not Focused) and (HandleAllocated) then
    begin
      IsUpdating := true;
      FView.FRangeUpdate := true;
      FUpdated := true;
      IsUpdating := false;
    end;
  end; {if}
end;

function TCustomElTree.GetLockHeaderHeight: Boolean;
begin
  result := FHeader.LockHeight;
end; { GetLockHeaderHeight }

procedure TCustomElTree.SetLockHeaderHeight(newValue: Boolean);
begin
  if (LockHeaderHeight <> newValue) then
    FHeader.LockHeight := newValue;
end; { SetLockHeaderHeight }

procedure TCustomElTree.UpdateFrame;
var R : TRect;
begin
  if not HandleAllocated then exit;
  R := Rect( 0, 0, Width, Height);
  if (BorderStyle = bsSingle) then
     RedrawWindow(Handle,@R, 0, rdw_Invalidate or rdw_UpdateNow or rdw_Frame );
end;

type
  TSelHackWinControl = class (TWinControl)
  ;

procedure TCustomElTree.WMSetFocus(var Msg : TWMSetFocus);  { private }
begin
  inherited;
  if Msg.FocusedWnd <> FView.Handle then
    if (FView.Enabled and FView.Visible) and Parent.Visible then
      FView.SetFocus
  else
    if TWinControl(Owner).Enabled and TWinControl(Owner).Visible then
      TSelHackWinControl({!!!Parent}Owner).SelectNext(Self, false, True);
  if (Flat and (FInactiveBorderType <> FActiveBorderType)) or FUseCustomBars then
    UpdateFrame;
end;  { WMSetFocus }

procedure TCustomElTree.WMKillFocus(var Msg : TWMKillFocus);  { private }
begin
  inherited;
  if not HandleAllocated then exit;
  if (Flat and (FInactiveBorderType <> FActiveBorderType)) or FUseCustomBars then
    UpdateFrame;
end;  { WMKillFocus }

procedure TCustomElTree.AutoSizeAllColumnsEx(VisibleOnly : boolean);
var i : integer;
begin
  if FAutosizingColumns then exit;
  FAutosizingColumns := true;
  for i := 0 to Pred(FHeader.Sections.Count) do
    AutoSizeColumnEx(i, VisibleOnly);

  if AdjustMultilineHeight then
    ResetAllItemsHeight;
  FAutosizingColumns := false;
end;

procedure TCustomElTree.AutoSizeColumnEx(SectionIndex : integer; VisibleOnly : boolean);
var
  Section : TElHeaderSection;
  begin
  Section := FHeader.Sections[SectionIndex];
  if (section <> nil) then
  begin
    Section.Width := Max(FHeader.MeasureSectionWidth(Section, nil,nil), MeasureColumnWidth(SectionIndex, VisibleOnly));
    if AdjustMultilineHeight and (not FAutosizingColumns) then
      ResetAllItemsHeight;
    OnHeaderSectionResize(FHeader, Section);
  end;
end;

procedure TCustomElTree.AutoSizeColumn(SectionIndex : integer);
var
  Section : TElHeaderSection;
  begin
  if FUpdateCount > 0 then
  begin
    FColSizeUpdate := true;
    FUpdated := true;
    exit;
  end;
  Section := FHeader.Sections[SectionIndex];
  if (section <> nil) and Section.AutoSize then
  begin
    Section.Width := Max(FHeader.MeasureSectionWidth(Section, nil,nil), MeasureColumnWidth(SectionIndex, true));
    if AdjustMultilineHeight and (not FAutosizingColumns) then
      ResetAllItemsHeight;
    OnHeaderSectionResize(FHeader, Section);
  end;
end;

procedure TCustomElTree.AutoSizeAllColumns;
var i : integer;
begin
  if FAutosizingColumns then exit;
  if FUpdateCount > 0 then
  begin
    FUpdated := true;
    FColSizeUpdate := true;
    exit;
  end;
  FAutosizingColumns := true;
  for i := 0 to Pred(FHeader.Sections.Count) do
  begin
    AutoSizeColumn(i);
  end;
  if AdjustMultilineHeight then
    ResetAllItemsHeight;
  FAutosizingColumns := false;
end;

function TCustomElTree.CanFocus : boolean;
begin
  result := inherited CanFocus;
end;

{.$warnings off}
{.$hints off}

function TCustomElTree.MeasureCellText(Item : TElTreeItem; ColumnNum : integer;
    MaxWidth : integer; var Size : TPoint): Boolean;
var HS : TElHeaderSection;
    CurStyle : TElCellStyle;
    FakeStaticDataEx : TElTreeItemStaticDataEx;
    CurStaticDataEx : TElTreeItemStaticDataEx;
    OwnFontSet : boolean;
    xxx,
    SaveFontStyle : TFontStyles;
    SaveFontSize : integer;
    SaveFontName : TFontName;
    cNum, AL : integer;
    R3 : TRect;
    ASize : TPoint;
    SText : TLMDString;

begin
  result := false;
  if (ColumnNum = -1)and ShowColumns then
    ColumnNum := FMainTreeCol;
  if (ColumnNum = -1) or (ColumnNum = FMainTreeCol) then
  begin
    FakeStaticDataEx := nil;
    CurStaticDataEx := Item.FStaticDataEx;
    if (FVirtualityLevel >= vlAllProps) and (not (csDesigning in ComponentState)) then
    begin
      if Item.FStaticDataEx <> nil then
        CurStaticDataEx := Item.FStaticDataEx
      else
      begin
        FakeStaticDataEx := TElTreeItemStaticDataEx.Create;
        CurStaticDataEx := FakeStaticDataEx;
        TriggerVirtualPropsNeeded(Item, [vptMainText, vptStyles, vptFontStyle{, vptCheck, vptButtons, vptImages}], FakeStaticDataEx);
      end;
    end;
    if VirtualityLevel = vlNone then
    begin
      if Item.UseStyles then
        CurStyle := Item.MainStyle
      else
        CurStyle := nil;
    end
    else
    begin
      if Item.UseStyles then
      begin
        CurStyle := FView.VirtStyle;
        TriggerVirtualStyleNeeded(Item, ColumnNum, CurStyle);
      end
      else
        CurStyle := nil;
    end;
    Size.Y := FLineHeight;
    Size.X := 0;

    if (FODFollowCol and ({FShowHeader and }(FHeader.Sections.Count > 0) and (FHeader.Sections[FMainTreeCol].Style = ElhsOwnerDraw)))
      or ((Item.Text = FODMask) and (not (FODFollowCol)))
      or (Item.UseStyles and (CurStyle.FStyle = elhsOwnerDraw))
    then
    begin
      TriggerMeasureItemPartEvent(Item, ColumnNum, ASize);
      inc(Size.X, ASize.X);
      if ((Item.FBoolData and ibfOwnerHeight) <> ibfOwnerHeight) or  (Item.Multiline and FAdjustMultilineHeight) then
        Size.Y := max(Size.Y, ASize.Y);
      result := true;
    end
    else
    begin
      if (((CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) and (Assigned(CurStyle) and (CurStyle.OwnerProps or (CurStyle.FStyle = elhsText)))) or
         ((CurStaticDataEx.FBoolData1 and ibfUseStyles) <> ibfUseStyles) then
      begin
        if (((CurStaticDataEx.FBoolData1 and ibfUseStyles) <> ibfUseStyles)
        or ((CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) and (CurStyle.OwnerProps)
        )
        and
           ShowColumns and (FHeader.Sections[ColumnNum].Style = elhsImageIndex) then
        begin
          if FImages <> nil then
            inc(Size.x, FImages.Width);
          result := false;
        end
        else
        begin
          xxx := [];
          SaveFontStyle := Canvas.Font.Style;
          SaveFontSize := Canvas.Font.Height;
          SaveFontName := Canvas.Font.Name;
          OwnFontSet := false;
          if ((CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
          begin
            if not CurStyle.FOwnerProps then with CurStyle do
            begin
              if Canvas.Font.Name <> FontName then
              begin
                Canvas.Font.Name := FontName;
                OwnFontSet := true;
              end;
              xxx := FontStyles;
              if Canvas.Font.Size <> FontSize then
              begin
                Canvas.Font.Size := FontSize;
                OwnFontSet := true;
              end;
            end
            else
            begin
              if Canvas.Font.Name <> Font.Name then
              begin
                Canvas.Font.Name := Font.Name;
                OwnFontSet := true;
              end;
              if ((CurStaticDataEx.FBoolData1 and ibfParentStyle) = ibfParentStyle) then
                xxx := Font.Style
              else
              begin
                if stsBold in CurStaticDataEx.FState then Include(xxx, fsBold);
                if stsItalic in CurStaticDataEx.FState then Include(xxx, fsItalic);
                if stsUnderlined in CurStaticDataEx.FState then Include(xxx, fsUnderline);
                if stsStrikeOut in CurStaticDataEx.FState then Include(xxx, fsStrikeout);
              end;
              if Canvas.Font.Size <> Font.Size then
              begin
                Canvas.Font.Size := Font.Size;
                OwnFontSet := true;
              end;
            end;
          end
          else
          begin
            if Canvas.Font.Name <> Font.Name then
            begin
              Canvas.Font.Name := Font.Name;
              OwnFontSet := true;
            end;
            if ((CurStaticDataEx.FBoolData1 and ibfParentStyle) = ibfParentStyle) then
              xxx := Font.Style
            else
            begin
              if stsBold in CurStaticDataEx.FState then Include(xxx, fsBold);
              if stsItalic in CurStaticDataEx.FState then Include(xxx, fsItalic);
              if stsUnderlined in CurStaticDataEx.FState then Include(xxx, fsUnderline);
              if stsStrikeOut in CurStaticDataEx.FState then Include(xxx, fsStrikeout);
            end;
            if Canvas.Font.Size <> Font.Size then
            begin
              Canvas.Font.Size := Font.Size;
              OwnFontSet := true;
            end;
          end;
          if Canvas.Font.Style <> xxx then
          begin
            Canvas.Font.Style := xxx;
            OwnFontSet := true;
          end;
          AL := DT_NOPREFIX or MultiLineFlags[Item.Multiline] or WordWrapFlags[Item.Multiline, Item.WordWrap] or DT_VCENTER or DT_LEFT or DT_CALCRECT;
          if RightAlignedText then
            AL := AL or DT_RTLREADING;
          SetRectEmpty(R3);
          if Item.IsHTML and (Copy(Item.Text, 1, 6) = '<html>') then
          begin
            R3.Left := 0;
            R3.Top := 0;
            with FView.FRender do
            begin
              Data.DefaultStyle := Canvas.Font.Style;
              Data.DefaultFont  := Canvas.Font.Name;
              Data.DefaultHeight := Canvas.Font.Height;
              Data.Charset      := Canvas.Font.Charset;

              PrepareText(Item.Text, MaxWidth, Item.WordWrap and Item.Multiline);
              R3.Right := Data.TextSize.cx;
              R3.Bottom := Data.TextSize.cy;
            end;
          end
          else
  begin
            if Item.Multiline and Item.WordWrap then
              R3.Right := R3.Left + MaxWidth;
            SText := Item.Text;
            if RightAlignedView then
              R3.Right := Max(R3.Right - ItemExt div 5, R3.Left)
            else
              R3.Left := Min(R3.Left + ItemExt div 5, R3.Right);
            LMDDrawText(Canvas.Handle, SText, Length(SText), R3,  DT_NOPREFIX or AL);
          end;
          Size.Y := Max(Size.Y, R3.Bottom - R3.Top + 1);

          Inc(Size.X, R3.Right - R3.Left);
          if OwnFontSet then
          begin
            Canvas.Font.Style  := SaveFontStyle;
            Canvas.Font.Height := SaveFontSize;
            Canvas.Font.Name   := SaveFontName;
          end;
          result := true;
        end;
      end
      else
      if Item.UseStyles and (CurStyle.FStyle = elhsPictureOnly) and Assigned(CurStyle.FPicture) then
      begin
        Inc(Size.X, CurStyle.Picture.Width + 3);
        result := false;
      end;
    end;
    if CurStaticDataEx = FakeStaticDataEx then
      FakeStaticDataEx.Free;
  end
  else
  begin
    FakeStaticDataEx := nil;
    CurStaticDataEx := Item.FStaticDataEx;
    if (FVirtualityLevel >= vlAllProps) and (not (csDesigning in ComponentState)) then
    begin
      if Item.FStaticDataEx <> nil then
        CurStaticDataEx := Item.FStaticDataEx
      else
      begin
        FakeStaticDataEx := TElTreeItemStaticDataEx.Create;
        CurStaticDataEx := FakeStaticDataEx;
        TriggerVirtualPropsNeeded(Item, [vptCellText, vptStyles, vptFontStyle], FakeStaticDataEx);
      end;
    end;

    HS := FHeader.Sections[ColumnNum];

    OwnFontSet := false;
    CurStyle := nil;
    if Item.UseStyles then
    begin
      if Item.FStaticData <> nil then
      begin
        cNum := ColumnNum;
        if cNum > FMainTreeCol then
          dec(cNum);

        if (Item.StylesCount > cNum) and (not HS.UseMainStyle) then
           CurStyle := Item.Styles[cNum];
        if CurStyle = nil then
          CurStyle := Item.MainStyle;
      end
      else
      begin
        CurStyle := FView.VirtStyle;
        TriggerVirtualStyleNeeded(Item, ColumnNum, CurStyle);
      end;
    end;
    if Item.FStaticData <> nil then
    begin
      cNum := ColumnNum;
      if cNum > FMainTreeCol then dec(cNum);

      if Item.ColumnText.Count <= cNum then
        SText := ''
      else
        SText := Item.ColumnText[cNum];
    end
    else
      TriggerVirtualTextNeeded(Item, ColumnNum, SText);

    if (FODFollowCol and (HS.Style = ElhsOwnerDraw)) or ((not (FODFollowCol)) and (SText = FODMask))
      or (((CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) and (Assigned(CurStyle) and (CurStyle.FStyle = elhsOwnerDraw)))
    then
    begin
      Size.Y := FLineHeight;
      Size.X := 0;
      TriggerMeasureItemPartEvent(Item, ColumnNum, Size);
      result := false;
    end
    else
    if ((CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) and (Assigned(CurStyle) and (CurStyle.Control <> nil)) then
    begin
      Size.X := HS.Width;
      Size.Y := FLineHeight;
    end
    else
    if Item.UseStyles and (CurStyle.FStyle = elhsPictureOnly) and Assigned(CurStyle.FPicture) then
    begin
      Size.Y := CurStyle.FPicture.Height;
      Size.X := CurStyle.FPicture.Width;
      result := false;
    end
    else
    if (((CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) and (Assigned(CurStyle) and (CurStyle.FStyle = elhsText))) or ((CurStaticDataEx.FBoolData1 and ibfUseStyles) <> ibfUseStyles) then
    begin
      SaveFontStyle := Canvas.Font.Style;
      SaveFontSize := Canvas.Font.Height;
      SaveFontName := Canvas.Font.Name;
      if ((CurStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) and (Assigned(CurStyle) and (not CurStyle.FOwnerProps)) then
      with CurStyle do
      begin
        Canvas.Font.Name := FontName;
        Canvas.Font.Size := FontSize;
        Canvas.Font.Style := FontStyles;
      end
      else
      begin
        if ((CurStaticDataEx.FBoolData1 and ibfParentStyle) = ibfParentStyle) then
          xxx := Font.Style
        else
        begin
          xxx := [];
          if stsBold in CurStaticDataEx.FState then Include(xxx, fsBold);
          if stsItalic in CurStaticDataEx.FState then Include(xxx, fsItalic);
          if stsUnderlined in CurStaticDataEx.FState then Include(xxx, fsUnderline);
          if stsStrikeOut in CurStaticDataEx.FState then Include(xxx, fsStrikeout);
        end;
        Canvas.Font.Style := xxx;
      end;
      AL := DT_NOPREFIX or MultiLineFlags[Item.Multiline]  or WordWrapFlags[Item.Multiline, Item.WordWrap] or DT_VCENTER or DT_LEFT or DT_CALCRECT;
      if RightAlignedText then AL := AL or DT_RTLREADING;
      if HS.Password then
        SText := '******'
      else
      if Item.FStaticData <> nil then
      begin
        cNum := ColumnNum;
        if cNum > FMainTreeCol then dec(cNum);
        if Item.ColumnText.Count <= cNum then
          SText := ''
        else
          SText := Item.ColumnText[cNum];
      end
      else
        TriggerVirtualTextNeeded(Item, ColumnNum, SText);

      SetRectEmpty(R3);
  if Item.IsHTML and (Copy(SText, 1, 6) = '<html>') then
      begin
        with FView.FRender do
        begin
          Data.DefaultStyle := Canvas.Font.Style;
          Data.DefaultFont  := Canvas.Font.Name;
          Data.DefaultHeight := Canvas.Font.Height;
          Data.Charset      := Canvas.Font.Charset;

          PrepareText(SText, MaxWidth, Item.WordWrap and Item.Multiline);
          R3.Right := Data.TextSize.cx;
          R3.Bottom := Data.TextSize.cy;
        end;
      end
      else
  begin
        if Item.Multiline and Item.WordWrap then
          R3.Right := R3.Left + MaxWidth;
        if RightAlignedView then
          R3.Right := Max(R3.Right - ItemExt div 5, R3.Left)
        else
          R3.Left := Min(R3.Left + ItemExt div 5, R3.Right);
        LMDDrawText(Canvas.Handle, SText, Length(SText), R3, DT_NOPREFIX or AL);
      end;
      InflateRect(R3, 1, 1);

      Size.X := R3.Right - R3.Left + FDivLineWidth * 2;
      Size.Y := Max(FLineHeight, R3.Bottom - R3.Top + 1);

      if OwnFontSet then
      begin
        Canvas.Font.Style  := SaveFontStyle;
        Canvas.Font.Height := SaveFontSize;
        Canvas.Font.Name   := SaveFontName;
      end;
      result := true;
    end
    else
    begin
      Size.X := 0;
      Size.Y := FLineHeight;
      result := false;
    end;
    if CurStaticDataEx = FakeStaticDataEx then
      FakeStaticDataEx.Free;
  end;
end;

procedure TCustomElTree.MeasureCell(Item : TElTreeItem; ColumnNum : integer;
    MaxWidth : integer; var Size : TPoint);
var
    FTImages : TCustomImageList;
    StImIndex : integer;
    FID       : boolean;
    ASize : TPoint;
    FakeStaticDataEx : TElTreeItemStaticDataEx;
    CurStaticDataEx : TElTreeItemStaticDataEx;
begin
  Size.Y := FLineHeight;
  Size.X := 0;

  if (ColumnNum = -1) or (ColumnNum = FMainTreeCol) then
  begin
    FakeStaticDataEx := nil;
    CurStaticDataEx := Item.FStaticDataEx;
    if (FVirtualityLevel >= vlAllProps) and (not (csDesigning in ComponentState)) then
    begin
      if Item.FStaticDataEx <> nil then
        CurStaticDataEx := Item.FStaticDataEx
      else
      begin
        FakeStaticDataEx := TElTreeItemStaticDataEx.Create;
        CurStaticDataEx := FakeStaticDataEx;
        TriggerVirtualPropsNeeded(Item, [vptCheck, vptButtons, vptImages, vptIndent], FakeStaticDataEx);
      end;
    end;

    if (FShowRoot and FShowLines) or (FShowButtons and FShowRootButtons) then
      Inc(Size.X, ItemExt)
    else
      Inc(Size.X, ItemExt div 5);

    Inc(Size.X, Item.Level * ItemExt);

    if FShowCheckBoxes then
    begin
      if (CurStaticDataEx.FBoolData1 and ibfShowCheckBox) = ibfShowCheckBox then
      begin
        if FCustomCheckboxes then
          inc(Size.X, FRadioButtonGlyph.Width div 6)
        else
          inc(Size.X, CheckBoxSize);
      end;
    end;

    if (FShowImages) then
    begin
      Fid := false;
      if FImages2 <> nil then
        FTImages := FImages2
      else
        FTImages := FImages;
      if FTImages <> nil then
      begin
        if FShowEmptyImages2 then
        begin
          inc(Size.X, FTImages.Width);
          if ShowCheckBoxes and Item.ShowCheckBox then
            inc(Size.X, ItemExt div 3);
          FID := true;
        end
        else
        begin
          if (Item.Focused or Item.Selected or Item.Cut or (Item.Expanded and Item.HasVisibleChildren)) then
            StImIndex := CurStaticDataEx.FStImageIndex2
          else
            StImIndex := CurStaticDataEx.FImageIndex2;
          if StImIndex = -1 then
            StImIndex := DoGetPicture2(Item);
          if LMDInRange(StImIndex, 0, FTImages.Count - 1) then
          begin
            inc(Size.X, FTImages.Width);
            if ShowCheckBoxes and Item.ShowCheckBox then
              inc(Size.X, ItemExt div 3);
            FID := true;
          end;
        end;
      end;
      if (FImages <> nil) then
      begin
        if FShowEmptyImages then
        begin
          inc(Size.X, FImages.Width);
          if FID or (ShowCheckBoxes and Item.ShowCheckBox) then
            inc(Size.X, ItemExt div 3); // make the space between images
        end
        else
        begin
          if (Item.Focused or Item.Selected or Item.Cut or (Item.Expanded and Item.HasVisibleChildren)) then
            StImIndex := CurStaticDataEx.FStImageIndex
          else
            StImIndex := CurStaticDataEx.FImageIndex;
          if StImIndex = -1 then
            StImIndex := DoGetPicture(Item);
          //StImIndex := 2;
          if LMDInRange(StImIndex, 0, FImages.Count - 1) or FShowEmptyImages then
          begin
            inc(Size.X, FImages.Width);
            if FID or (ShowCheckBoxes and Item.ShowCheckBox) then
              inc(Size.X, ItemExt div 3); // make the space between images
          end;
        end;
      end;
    end; // Show images
    if CurStaticDataEx = FakeStaticDataEx then
      FakeStaticDataEx.Free;
    if MaxWidth <> 0 then
      dec(MaxWidth, Size.x + ItemExt * 3 div 5);
  end;

  if MeasureCellText(Item, ColumnNum, MaxWidth, ASize) then
    inc(Size.x, ItemExt * 3 div 5);
  inc(Size.x, ASize.x);
  Size.y := ASize.y;
end;
{$warnings on}
{$hints on}

function TCustomElTree.MeasureColumnWidth(ColumnNum: integer; VisibleOnly : boolean): integer;

{type TMeasureProc = procedure(Item : TElTreeItem; ColumnNum : integer; var Size : TPoint) of object;

type TSRec = record
       MeasureProc : TMeasureProc;
       CurWidth,
       ColumnNum    : integer;
     end;
     PSRec = ^TSRec;

         procedure IntMeasure(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean; IterateData: pointer; Tree: TCustomElTree);
         var P : TPoint;
         begin
           PSRec(IterateData).MeasureProc(Item, PSRec(IterateData).ColumnNum, P);
           if P.X > PSRec(IterateData).CurWidth then PSRec(IterateData).CurWidth := P.x;
         end;

var SRec : TSRec;
}
var i, j : integer;
    Item : TElTreeItem;
    CurWidth : integer;
    P    : TPoint;

begin
  if (ColumnNum >= FHeader.Sections.Count) then
  begin
    result := 0;
    exit;
  end;

  CurWidth := 0;
  i := 0;
  j := FAllList.Count;
  while i < j do
  begin
    Item := TElTreeItem(FAllList[i]);

    if (FilteredVisibility and Item.Hidden and VisibleOnly) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end else
    begin
      MeasureCell(Item, ColumnNum, 0{FHeader.Sections[ColumnNum].Width}, P);
      if P.X > CurWidth then CurWidth := P.x;
      if (not Item.Expanded) and VisibleOnly then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    inc(i);
  end;
  result := CurWidth;
  {SRec.MeasureProc := MeasureCell;
  SRec.ColumnNum := ColumnNum;
  Canvas.Font.Assign(Font);
  Items.Iterate(VisibleOnly, @IntMeasure, @SRec);
  result := SRec.CurWidth;}
end;

procedure TCustomElTree.HeaderSectionAutoSizeHandler(Sender : TCustomElHeader; Section : TElHeaderSection);

begin
  if FAutoResizeColumns then
  begin
    if Section.AutoSize then
       AutoSizeColumn(Section.Index)
    else
    begin
      Section.Width := Max(FHeader.MeasureSectionWidth(Section, nil,nil), MeasureColumnWidth(Section.Index, true));
      ResetAllItemsHeight;
      end;
    OnHeaderSectionResize(FHeader, Section);
  end
  else
  begin
    if Section.AutoSize then
       AutoSizeColumn(Section.Index)
    else
      SectionAutoSizeTransfer(Sender, Section);
  end;
end;  { HeaderSectionAutoSizeHandler }

procedure TCustomElTree.SectionAutoSizeTransfer(Sender : TCustomElHeader; Section : TElHeaderSection);
{ Transfers FHeader OnSectionAutoSize event to the outside world. }
begin
  if (assigned(FOnSectionAutoSize)) then
    FOnSectionAutoSize(Self, Section.Index);  { Substitute Self for subcomponent's Sender. }
end;  { SectionAutoSizeTransfer }

procedure TCustomElTree.SectionFilterCallTransfer(Sender : TCustomElHeader; Section : TElHeaderSection);
{ Transfers FHeader OnFilterCall event to the outside world. }
begin
  if (assigned(FOnSectionFilterCall)) then
    FOnSectionFilterCall(Self, Section.Index);  { Substitute Self for subcomponent's Sender. }
end;  { SectionFilterCallTransfer }

{ Exposed properties' Read/Write methods: }
procedure TCustomElTree.SetHeaderActiveFilterColor(newValue : TColor);
{ Sets the FHeader subcomponent's ActiveFilterColor property to newValue. }
begin
  FHeader.ActiveFilterColor := newValue;
end;  { SetHeaderActiveFilterColor }

function TCustomElTree.GetHeaderActiveFilterColor : TColor;
{ Returns the ActiveFilterColor property from the FHeader subcomponent. }
begin
  GetHeaderActiveFilterColor := FHeader.ActiveFilterColor;
end;  { GetHeaderActiveFilterColor }

procedure TCustomElTree.SetHeaderFilterColor(newValue : TColor);
{ Sets the FHeader subcomponent's FilterColor property to newValue. }
begin
  FHeader.FilterColor := newValue;
end;  { SetHeaderFilterColor }

function TCustomElTree.GetHeaderFilterColor : TColor;
{ Returns the FilterColor property from the FHeader subcomponent. }
begin
  GetHeaderFilterColor := FHeader.FilterColor;
end;  { GetHeaderFilterColor }

procedure TCustomElTree.SetHeaderFlat(newValue : Boolean);
{ Sets the FHeader subcomponent's Flat property to newValue. }
begin
  FHeader.Flat := newValue;
end;  { SetHeaderFlat }

function TCustomElTree.GetHeaderFlat : Boolean;
{ Returns the Flat property from the FHeader subcomponent. }
begin
  GetHeaderFlat := FHeader.Flat;
end;  { GetHeaderFlat }

procedure TCustomElTree.WMEnable(var Msg : TWMEnable);  { private }
begin
  inherited;
  if (Flat or FUseCustomBars) and (not IsThemed) then DrawFlatBorder(false, false);
end;  { WMEnable }

procedure TCustomElTree.SetFlatFocusedScrollbars(newValue : Boolean);
{ Sets data member FFlatFocusedScrollbars to newValue. }
begin
  if (FFlatFocusedScrollbars <> newValue) then
  begin
    FFlatFocusedScrollbars := newValue;
    if Focused and (not FUseCustomBars) and (not IsThemed) then
      DrawFlatBorder(false, false);
    end;  { if }
end;  { SetFlatFocusedScrollbars }

procedure TCustomElTree.BackgroundChange(Sender : TObject);
begin
  if (Background.Empty) then FBackgroundType := bgtColorFill else
  begin
    with FView do
    begin
      RedoTmpBmp;
      if BackgroundType <> bgtColorFill then
        if not (csLoading in ComponentState) then Invalidate;//Repaint;
    end;
  end;
end;

procedure TCustomElTree.SetBackground(newValue : TBitmap);
{ Sets data member FBackground to newValue. }
begin
  FBackground.Assign(newValue);
end;  { SetBackground }

procedure TCustomElTree.SetBackgroundType(newValue : TLMDBackgroundType);
{ Sets data member FBackgroundType to newValue. }
begin
  if (FBackgroundType <> newValue) then
  begin
    if (Background.Empty) and (FBackGroundType in [bgtTileBitmap, bgtStretchBitmap, bgtCenterBitmap])
       then FBackgroundType := bgtColorFill
       else FBackgroundType := newValue;
    with FView do
    begin
      RedoTmpBmp;
      if not (csLoading in Self.ComponentState) then Invalidate;//Repaint;
    end;
  end;  { if }
end;  { SetBackgroundType }

procedure TCustomElTree.SetHideSelectTextColor(newValue: TColor);
begin
  if (FHideSelectTextColor <> newValue) then
  begin
    FHideSelectTextColor := newValue;
    if (not FView.FHasFocus) and not FHideSelect then FView.Invalidate;
  end;  {if}
end;

procedure TCustomElTree.SetFocusedSelectTextColor(newValue: TColor);
begin
  if (FFocusedSelectTextColor <> newValue) then
  begin
    FFocusedSelectTextColor := newValue;
    if FView.FHasFocus then FView.Invalidate;
  end;  {if}
end;

procedure TCustomElTree.SetHideSelectColor(newValue: TColor);
begin
  if (FHideSelectColor <> newValue) then
  begin
    FHideSelectColor := newValue;
    if (not FView.FHasFocus) and not FHideSelect then FView.Invalidate;
  end;  {if}
end;

procedure TCustomElTree.SetFocusedSelectColor(newValue: TColor);
begin
  if (FFocusedSelectColor <> newValue) then
  begin
    FFocusedSelectColor := newValue;
    if FView.FHasFocus then FView.Invalidate;
  end;  {if}
end;

procedure TCustomElTree.SetRowHotTrack(newValue : Boolean);
{ Sets data member FRowHotTrack to newValue. }
begin
  if (FRowHotTrack <> newValue) then
  begin
    FRowHotTrack := newValue;
    with FView do
      if Tracking and (FTrackItem <> nil) then FTrackItem.RedrawItem(true);
  end;  { if }
end;  { SetRowHotTrack }

procedure TCustomElTree.SetActiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FActiveBorderStyle to newValue. }
begin
  if (FActiveBorderType <> newValue) then
  begin
    FActiveBorderType := newValue;
    if (FView.FHasFocus or FMouseOver) or FUseCustomBars then UpdateFrame;
    end;  { if }
end;  { SetActiveBorderStyle }

procedure TCustomElTree.SetInactiveBorderType(newValue : TElFlatBorderType);
{ Sets data member FInactiveBorderStyle to newValue. }
begin
  if (FInactiveBorderType <> newValue) then
  begin
    FInactiveBorderType := newValue;
    if not (FView.FHasFocus or FMouseOver) or FUseCustomBars then UpdateFrame;
    end;  { if }
end;  { SetInactiveBorderStyle }

procedure TCustomElTree.SetGradientStartColor(newValue : TColor);
{ Sets data member FGradientStartColor to newValue. }
begin
  if (FGradientStartColor <> newValue) then
  begin
    FGradientStartColor := newValue;
    if LMDBackgroundIsGradient(BackgroundType) and (FUpdateCount = 0) then
    with FView do
    begin
      RedoTmpBmp;
      Invalidate;//Repaint;
    end;
  end;  { if }
end;  { SetGradientStartColor }

procedure TCustomElTree.SetGradientEndColor(newValue : TColor);
{ Sets data member FGradientEndColor to newValue. }
begin
  if (FGradientEndColor <> newValue) then
  begin
    FGradientEndColor := newValue;
    if LMDBackgroundIsGradient(BackgroundType) and (FUpdateCount = 0) then
    with FView do
    begin
      RedoTmpBmp;
      Invalidate;//Repaint;
    end;
  end;  { if }
end;  { SetGradientEndColor }

procedure TCustomElTree.SetGradientSteps(newValue : Integer);
{ Sets data member FGradientSteps to newValue. }
begin
  if (FGradientSteps <> newValue) and (newValue > 0) then
  begin
    FGradientSteps := newValue;
    if LMDBackgroundIsGradient(BackgroundType) and (FUpdateCount = 0) then
    with FView do
    begin
      RedoTmpBmp;
      Invalidate;//Repaint;
    end;
  end;  { if }
end;  { SetGradientSteps }

function TCustomElTree.GetHeaderImages: TCustomImageList;
{ Returns the value of data member FHeaderImages. }
begin
  result := FHeader.Images;
end; { GetHeaderImages }

function TCustomElTree.GetAlphaHeaderImages: TCustomImageList;
{ Returns the value of data member FHeaderImages. }
begin
  result := FHeader.AlphaForImages;
end; { GetAlphaHeaderImages }

procedure TCustomElTree.SetHeaderImages(newValue: TCustomImageList);
{ Sets data member FHeaderImages to newValue. }
begin
  if (FHeader.Images <> newValue) then FHeader.Images := newValue;
end; { SetHeaderImages }

procedure TCustomElTree.SetAlphaHeaderImages(newValue: TCustomImageList);
{ Sets data member FHeaderImages to newValue. }
begin
  if (FHeader.AlphaForImages <> newValue) then FHeader.AlphaForImages := newValue;
end; { SetHeaderImages }

procedure TCustomElTree.TriggerScrollEvent(ScrollBarKind: TScrollBarKind; ScrollCode: integer);
begin
  if (assigned(FOnScroll)) then
    FOnScroll(Self, ScrollBarKind, ScrollCode);
end; { TriggerScrollEvent }

procedure TCustomElTree.DeSelectAllEx; { public }

{  procedure IntSelAll(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
    IterateData: pointer; Tree: TCustomElTree);
  begin
    if (Item.FIState and tisSelected) > 0 then
    begin
      Item.Selected := false;
      if Tree.FSelectedList.Count = 0 then ContinueIterate := false;
    end;
  end;
}
var i,
    si : integer;
    TI : TElTreeItem;
begin
  if FMultiSelect = false then exit;
  if not IncludeHidden then DeselectAll else
  begin
    IsUpdating := true;
    i := 0;
    while i < FSelectedList.Count do    // Iterate
    begin
      TI := TElTreeItem(FSelectedList[i]);
      FSelChange := true;
      TI.FBoolData := TI.FBoolData and (not ibfSelected);
      if FView.FSelected = TI then
        FView.FSelected := nil;
      si := FSelectedList.Count;
      TriggerItemSelectedChangeEvent(TI);
      TI.UpdateItem;
      if FSelectedList.Count < SI then
      begin
        i := 0;
        Continue;
      end;
      inc(i);
    end;    // for
    FSelectedList.Count := 0;
    IsUpdating := false;
  end;
{  exit;

  IsUpdating := true;
  FItems.Iterate(not IncludeHidden, @IntSelAll, nil);
  IsUpdating := false;
}
end; { DeSelectAll }

procedure TCustomElTree.DeSelectAll; { public }

{  procedure IntSelAll(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
    IterateData: pointer; Tree: TCustomElTree);
  begin
    if (Item.FIState and tisSelected) > 0 then
    begin
      Item.Selected := false;
      if Tree.FSelectedList.Count = 0 then ContinueIterate := false;
    end;
  end;
}

var i,
    si : integer;
    TI : TElTreeItem;
begin
  if FMultiSelect = false then exit;
  IsUpdating := true;
  i := FSelectedList.Count - 1;
  while i >= 0 do    // Iterate
  begin
    TI := TElTreeItem(FSelectedList[i]);
    if not (FilteredVisibility and TI.Hidden) then
    begin
      FSelChange := true;
      TI.FBoolData := TI.FBoolData and (not ibfSelected);
      FSelectedList.Delete(i);
      if FView.FSelected = TI then FView.FSelected := nil;
      si := FSelectedList.Count;
      TriggerItemSelectedChangeEvent(TI);
      TI.UpdateItem;
      if FSelectedList.Count < SI then
      begin
        i := FSelectedList.Count - 1;
        Continue;
      end;
    end;
    dec(i);
  end;    // for
  //FItems.Iterate(FilteredVisibility, @IntSelAll, nil);
  IsUpdating := false;
end; { DeSelectAll }

procedure TCustomElTree.SelectAllEx; { public }

{  procedure IntSelAll(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
    IterateData: pointer; Tree: TCustomElTree);
  begin
    if (Item.FIState and tisSelected) = 0 then Item.Selected := true;
  end;
}

var i, j : integer;
    Item : TElTreeItem;

begin
  if FMultiSelect = false then exit;
  i := 0;
  j := FAllList.Count;
  IsUpdating := true;
  while i < j do
  begin
    Item := TElTreeItem(FAllList[i]);

    if (FilteredVisibility and (not IncludeHidden) and Item.Hidden) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end else
    begin
      if (Item.FBoolData and ibfSelected) = 0 then
        Item.Selected := true;
      if (not Item.Expanded) and (not IncludeHidden) then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    inc(i);
  end;
  IsUpdating := false;

  {if FMultiSelect = false then exit;
  IsUpdating := true;
  FItems.Iterate(not IncludeHidden, @IntSelAll, nil);
  IsUpdating := false;}
end; { SelectAll }

procedure TCustomElTree.SelectAll; { public }

{  procedure IntSelAll(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
    IterateData: pointer; Tree: TCustomElTree);
  begin
    if (Item.FIState and tisSelected) = 0 then Item.Selected := true;
  end;
}

var i, j : integer;
    Item : TElTreeItem;

begin
  if FMultiSelect = false then exit;
  i := 0;
  j := FAllList.Count;
  IsUpdating := true;
  while i < j do
  begin
    Item := TElTreeItem(FAllList[i]);

    if (FilteredVisibility and Item.Hidden) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end else
    begin
      if (Item.FBoolData and ibfSelected) = 0 then Item.Selected := true;
      if (not Item.Expanded) and (FilteredVisibility) then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    inc(i);
  end;
  IsUpdating := false;

  {if FMultiSelect = false then exit;
  IsUpdating := true;
  FItems.Iterate(FilteredVisibility, @IntSelAll, nil);
  IsUpdating := false;}
end; { SelectAll }

procedure TCustomElTree.InvertSelectionEx; { public }

{  procedure IntInvSel(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
    IterateData: pointer; Tree: TCustomElTree);
  begin
    Item.Selected := not Item.Selected;
  end;
}
var i, j : integer;
    Item : TElTreeItem;

begin
  if FMultiSelect = false then exit;
  i := 0;
  j := FAllList.Count;
  IsUpdating := true;
  while i < j do
  begin
    Item := TElTreeItem(FAllList[i]);

    if (FilteredVisibility and (not IncludeHidden) and Item.Hidden) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end else
    begin
      Item.Selected := not Item.Selected;
      if (not Item.Expanded) and (not IncludeHidden) then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    inc(i);
  end;
  IsUpdating := false;

  {if FMultiSelect = false then exit;
  IsUpdating := true;
  FItems.Iterate(not IncludeHidden, @IntInvSel, nil);
  IsUpdating := false;}
end;

procedure TCustomElTree.InvertSelection; { public }

{  procedure IntInvSel(Item: TElTreeItem; Index: integer; var ContinueIterate: boolean;
    IterateData: pointer; Tree: TCustomElTree);
  begin
    Item.Selected := not Item.Selected;
  end;
}

var i, j : integer;
    Item : TElTreeItem;

begin
  if FMultiSelect = false then exit;
  i := 0;
  j := FAllList.Count;
  IsUpdating := true;
  while i < j do
  begin
    Item := TElTreeItem(FAllList[i]);

    if (FilteredVisibility and Item.Hidden) then
    begin
      i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end else
    begin
      Item.Selected := not Item.Selected;
      if (not Item.Expanded) and (FilteredVisibility) then
         i := FAllList.IndexOfFrom(i, Item.GetLastSubItem);
    end;
    inc(i);
  end;
  IsUpdating := false;

{
  if FMultiSelect = false then exit;
  IsUpdating := true;
  FItems.Iterate(FilteredVisibility, @IntInvSel, nil);
  IsUpdating := false;
}
end;

function TCustomElTree.GetFocused: TElTreeItem;
begin
  result := FView.FFocused;
end;

function TCustomElTree.GetSelected: TElTreeItem;
begin
  result := FView.FSelected;
end; { GetSelected }

procedure TCustomElTree.SetSelected(newValue: TElTreeItem);
begin
  if not FMultiSelect then
  begin
   if Assigned(newValue) or not FAlwaysKeepSelection then
     SetFocused(newValue);
  end
  else
    if FView <> nil then
    begin
      if Assigned(newValue) or (not FAlwaysKeepSelection) or (FSelectedList.Count > 1) then
      begin
        if Assigned(FView.FSelected) then
          FView.FSelected.Selected := false;
        if not Assigned(FView.FFocused) then
          FView.FFocused := newValue;
        FView.FSelected := newValue;
        if Assigned(NewValue) and not newValue.Selected then
          newValue.Selected := True;
        SetFocused(newValue);
      end;
    end;
end; { SetSelected }

function TCustomElTree.GetTopItem: TElTreeItem; { public }
begin
  with FView do
    if FVisible.Count = 0 then
      result := nil
    else
      Result := TElTreeItem(FVisible[0]);
end; { GetTopItem }

procedure TCustomElTree.SetTopItem(Item: TElTreeItem); { public }
begin
  if Item = nil then raise EElTreeError.Create(STexInvItem);
  TopIndex := Item.VisIndex;
end; { SetTopItem }

procedure TCustomElTree.TriggerHeaderColumnMoveEvent;
begin
  if (assigned(FOnHeaderColumnMove)) then
    FOnHeaderColumnMove(Self, Section, OldPos, NewPos);
end; { TriggerHeaderColumnMoveEvent }

procedure TCustomElTree.TriggerTryEditEvent(Item: TElTreeItem; SectionIndex : integer;
  var CellType: TElFieldType; var CanEdit: boolean);
begin
  if (assigned(FOnTryEdit)) and (not (csDestroying in ComponentState)) then
    FOnTryEdit(Self, Item, SectionIndex, CellType, CanEdit);
end;

procedure TCustomElTree.TriggerItemSaveEvent(Stream: TStream; Item: TElTreeItem);
begin
  if (assigned(FOnItemSave)) then FOnItemSave(Self, Stream, Item);
end;

procedure TCustomElTree.TriggerItemLoadEvent(Stream: TStream; Item:
  TElTreeItem);
begin
  if (assigned(FOnItemLoad)) then FOnItemLoad(Self, Stream, Item);
end;

procedure TCustomElTree.Save;
var
  FSaveKey: string;
  F: TForm;
  S: string;
  AKey: string;
begin
  if Assigned(FStorage) then
  begin
    FSaveKey := FStorage.CurrentKey;
    F := LMDGetOwnerForm(Self);
    if (F <> nil) and (F.Name <> '') then
      S := F.Name + FStorage.Delimiter
    else
      S := '';
    AKey := FStorage.Delimiter + S + FStoragePath;
    FHeader.Storage := FStorage;
    FHeader.StoragePath := AKey;
    FHeader.Save;
    if FStorage.OpenKey(AKey, true) then
    begin
      FStorage.WriteInteger('', 'FontSize', Font.Size);
      FStorage.WriteInteger('', 'FontColor', Font.Color);
      FStorage.WriteString('', 'FontName', Font.Name);
      FStorage.WriteBool('', 'FontBold', fsBold in Font.Style);
      FStorage.WriteBool('', 'FontItalic', fsItalic in Font.Style);
      FStorage.WriteBool('', 'FontUnderline', fsUnderline in Font.Style);
      FStorage.WriteBool('', 'FontStrikeout', fsStrikeout in Font.Style);
      FStorage.WriteInteger('', 'SortType', integer(FSortType));
      FStorage.WriteInteger('', 'SortMode', integer(FSortMode));
      FStorage.WriteInteger('', 'SortDir', integer(FSortDir));
      FStorage.WriteInteger('', 'SortSection', integer(FSortSection));
    end;
    FStorage.OpenKey(FSaveKey, false);
  end;
end; {Save}

procedure TCustomElTree.Restore;
var
  FSaveKey: string;
  i: integer;
  b: Boolean;
  s: string;
  F: TForm;
  AKey: string;
begin
  IsUpdating := true;
  if Assigned(FStorage) then
  begin
    F := LMDGetOwnerForm(Self);
    if (F <> nil) and (F.Name <> '') then S := F.Name + FStorage.Delimiter else S := '';
    AKey := FStorage.Delimiter + S + FStoragePath;
    FHeader.Storage := FStorage;
    FHeader.StoragePath := AKey;
    FHeader.Restore;
    FSaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(AKey, false) then
    begin
      FStorage.ReadInteger('', 'FontSize', Font.Size, i);
      Font.Size := i;
      FStorage.ReadInteger('', 'FontColor', Font.Color, i);
      Font.Color := i;
      FStorage.ReadString('', 'FontName', Font.Name, s);
      Font.Name := s;
      FStorage.ReadBool('', 'FontBold', fsBold in Font.Style, b);
      if b then Font.Style := Font.Style + [fsBold] else Font.Style := Font.Style - [fsBold];
      FStorage.ReadBool('', 'FontItalic', fsItalic in Font.Style, b);
      if b then Font.Style := Font.Style + [fsItalic] else Font.Style := Font.Style - [fsItalic];
      FStorage.ReadBool('', 'FontUnderline', fsUnderline in Font.Style, b);
      if b then Font.Style := Font.Style + [fsUnderline] else Font.Style := Font.Style - [fsUnderline];
      FStorage.ReadBool('', 'FontStrikeout', fsStrikeout in Font.Style, b);
      if b then Font.Style := Font.Style + [fsStrikeout] else Font.Style := Font.Style - [fsStrikeout];
      FStorage.ReadInteger('', 'SortType', integer(FSortType), i);
      FSortType := TSortTypes(i);
      FStorage.ReadInteger('', 'SortMode', integer(FSortMode), i);
      FSortMode := TSortModes(i);
      FStorage.ReadInteger('', 'SortDir', integer(FSortDir), i);
      FSortDir := TSortDirs(i);
      FStorage.ReadInteger('', 'SortSection', FSortSection, i);
      FSortSection := i;
    end;
    FStorage.OpenKey(FSaveKey, false);
  end;
  IsUpdating := false;
end; {Restore}

procedure TCustomElTree.TriggerItemSelectedChangeEvent(Item: TElTreeItem);
begin
  if (assigned(FOnItemSelectedChange)) and (not (csDestroying in ComponentState)) then
    FOnItemSelectedChange(Self, Item);
end; {TriggerItemSelectedChangeEvent}

procedure TCustomElTree.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  //inherited;
  Message.Result := 1;
end;

procedure TCustomElTree.SetShowHeader;
begin
  if (FHeader = nil) then exit;
  if not (csReading in ComponentState) and (Value) and (FHeader.Sections.Count = 0) then exit;
  FShowHeader := value;
  if value = false then FView.FHRange := -1;
  //if csReading in ComponentState then exit;
  IsUpdating := true;
  FUpdated := true;

  with FView do
  begin
    FVisUpdated := true;
    FClearAll := true;
    FClearVis := true;
  end;

  if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then FView.RedoTmpBmp;

  AlignPieces;
  IsUpdating := false;
end;

procedure TCustomElTree.SetMainTreeCol;
begin
  if value = FMainTreeCol then exit;
  if value >= FHeader.Sections.Count then
    FMainTreeCol := 0
  else
  if value >= 0 then
    FMainTreeCol := value
  else
    exit;
  IsUpdating := true;
  FView.FRangeUpdate := true;
  FUpdated := true;
  IsUpdating := false;
end;

procedure TCustomElTree.DoHeaderResize;
begin
  if FView.FPainting or FIgnoreResizes then exit;
  IsUpdating := true;
  FUpdated := true;
  with FView do
  begin
    FRangeUpdate := true;
    FClearVis := true;
  end;
  if SavedHH <> FHeader.Height then
  begin
    with FView do
    begin
      FClearAll := true;
      FVisUpdated:= true;
    end;
    AlignPieces;
  end;
  if (FHeader.LeftPos <> FHPos) {or (FHeader.Width <> FHPos + FView.Width)} then
  begin
    FHeader.LeftPos := FHPos;
    {//LockedColumn, update
    FHeader.Left := -FHPos;
    FHeader.Width := FHPos + FView.Width;}
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.DoHeaderDraw;
begin
  if assigned(FOnColumnDraw) then FOnColumnDraw(Header, Canvas, Section, Rect, Pressed);
end;

procedure TCustomElTree.CMFontChanged(var Message: TMessage);
var
  i: integer;
begin
  inherited;
  if Canvas <> nil then Canvas.Font.Assign(Font);

  if (FHeader <> nil) and (FHeaderUseTreeFont) then
  begin
    FHeaderFont.Assign(Font);
    FHeader.Font.Assign(Font);
    TElHeaderHack(FHeader).OnFontChange(FHeader.Font);
    end;

  ReRenderAllHTMLItems;

  if AutoLineHeight then
  begin
    i := DefineLineHeight;
    if i <> FLineHeight then
    begin
      with FView do
      begin
        FClearVis := true;
        if i < FLineHeight then FClearAll := true;
      end;
      FLineHeight := i;
    end;
  end;

  IsUpdating := true;
  FView.FRangeUpdate := true;
  FUpdated := true;
  IsUpdating := false;
end;

procedure TCustomElTree.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if Canvas <> nil then Canvas.Brush.Color := Color;
end;

procedure TCustomElTree.SetHeaderHeight(value: integer);
begin
  IsUpdating := true;
  if csLoading in ComponentState then
    FHeaderHeight := value
  else
  begin
    FHeader.Height := value;
    // AlignPieces;
    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then FView.RedoTmpBmp;
    end;
  with FView do
  begin
    FClearAll := true;
    FClearVis := true;
  end;
  FUpdated := true;
  IsUpdating := false;
end;

function TCustomElTree.GetHeaderHeight;
begin
  Result := FHeader.Height;
end;

procedure TCustomElTree.SetHeaderSections;
begin
  IsUpdating := true;
  FHeader.Sections := value;
  FUpdated := true;
  FView.FRangeUpdate := true;
  IsUpdating := false;
end;

function TCustomElTree.GetHeaderSections;
begin
  Result := FHeader.Sections;
end;

procedure TCustomElTree.SaveStringsToStream(Stream: TStream);

  procedure IntSaveString(Item: TElTreeItem);
  var
    NodeStr: string;
    begin
    NodeStr := StringOfChar(' ', Pred(Item.Level)) + Item.Text + #13#10;
    Stream.Write(Pointer(NodeStr)^, Length(NodeStr));
    end;

var
  i: integer;
  Item: TElTreeItem;

begin
  for i := 0 to Pred(FAllList.Count) do
  begin
    Item := TElTreeItem(FAllList[i]);
    IntSaveString(Item);
  end;
end;

function TCustomElTree.GetItemAtY(y: integer): TElTreeItem;
begin
  Result := FView.GetItemAtY(y - FView.Top);
end;

function TCustomElTree.Focused : boolean;
begin
  result := FView.FHasFocus;
  exit;
end;

procedure TCustomElTree.FullCollapse;
var
  i: integer;
begin
  if FItems.FRoot.FChildren = nil then exit;
  IsUpdating := true;
  try
    for i := 0 to FItems.FRoot.FChildren.Count - 1 do
      TElTreeItem(FItems.FRoot.FChildren.List[i]).Collapse(true);
  finally
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.FullExpand;
var
  i: integer;
begin
  if FItems.FRoot.FChildren = nil then exit;
  IsUpdating := true;
  try
    for i := 0 to FItems.FRoot.FChildren.Count - 1 do
      TElTreeItem(FItems.FRoot.FChildren.List[i]).Expand(true);
  finally
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.ImageFormChange(Sender: TObject);
begin
  if not (csDesigning in ComponentState) then
    Invalidate;
end;

procedure TCustomElTree.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    FImgForm := newValue;
    if FImgForm <> nil then
    begin
      FImgForm.RegisterChanges(FImgFormChLink);
      FImgForm.FreeNotification(Self);
    end;
    if not (csDesigning in ComponentState) then
      Invalidate;
  end;
end;

procedure TCustomElTree.SetTextColor(value: TColor);
begin
  if FTextColor = value then exit;
  FTextColor := value;
  IsUpdating := true;
  FUpdated := true;
  with FView do
  begin
    FVisUpdated := true;
    FClearVis := true;
    FClearAll := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.SetBkColor(value: TColor);
begin
  if FBkColor = value then exit;
  FBkColor := value;
  IsUpdating := true;
  FUpdated := true;
  with FView do
  begin
    FVisUpdated := true;
    FClearVis := true;
    FClearAll := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.SetItems(value: TElTreeItems);
begin
  FItems.Assign(value);
end;

function TCustomElTree.CreateItemsExt(ItemClass : TElTreeItemClass): TElTreeItems;
begin
  result := TElTreeItems.CreateClass(Self, ItemClass);
end;

function TCustomElTree.CreateItems;
begin
  result := TElTreeItems.Create(Self);
end;

procedure TCustomElTree.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin

    if AComponent = FStorage then Storage := nil;

    if AComponent = FImgForm then
    begin
      ImageForm := nil;
      Invalidate;
    end;
    if AComponent = Images then
    begin
      Images.UnRegisterChanges(FImageChangeLink);
      Images := nil;
    end;
    if AComponent = Images2 then
    begin
      Images2.UnRegisterChanges(FImageChangeLink);
      Images2 := nil;
    end;
    if AComponent = AlphaForImages then
    begin
      AlphaForImages.UnRegisterChanges(FAImageChangeLink);
      AlphaForImages := nil;
    end;
    if AComponent = AlphaForImages2 then
    begin
      AlphaForImages2.UnRegisterChanges(FAImageChangeLink);
      AlphaForImages2 := nil;
    end;
  end;
end;

procedure TCustomElTree.SelectRangeEx2(FromItem, ToItem: TElTreeItem; IncludeHidden, SelectDisabled, SelectCollapsedChildren: boolean);
var i,
    EndIdx,
    StartIdx : integer;
    Item,
    LItem : TElTreeItem;

begin
  if FMultiSelect = false then exit;
  if (FromItem = ToItem) and (FromItem <> nil) then
     exit;
  if (not FilteredVisibility) or IncludeHidden then
     SelectRange2(FromItem, ToItem, SelectDisabled, SelectCollapsedChildren)
  else
  begin
    IsUpdating := true;
    try
      if FromItem = nil then
         StartIdx := 0
      else
         StartIdx := FromItem.AbsoluteIndex;

      if ToItem = nil then
         EndIdx := 0
      else
         EndIdx := ToItem.AbsoluteIndex;

      if StartIdx > EndIdx then
      begin
        i := EndIdx;
        EndIdx := StartIdx;
        StartIdx := i;
      end;
      i := StartIdx;
      while i < EndIdx do
      begin
        Item := TElTreeItem(FAllList[i]);
        if Item.Hidden then
        begin
          LItem := Item.GetLastSubItem;
          if LItem <> nil then
             i := FAllList.IndexOfFrom(i, LItem);
        end
        else
        begin
          if SelectDisabled or (IgnoreEnabled or Item.Enabled) then
             Item.Selected := true;
          if (not Item.Expanded) and (not SelectCollapsedChildren) then
          begin
            LItem := Item.GetLastSubItem;
            if LItem <> nil then
              i := FAllList.IndexOfFrom(i, LItem);
          end;
        end;
        inc(i);
      end;
    finally
      IsUpdating := false;
    end;
  end;
end;

procedure TCustomElTree.SelectRangeEx(FromItem, ToItem: TElTreeItem; IncludeHidden: boolean);
begin
  SelectRangeEx2(FromItem, ToItem, IncludeHidden, true, true);
end;

procedure TCustomElTree.SelectRange2(FromItem, ToItem: TElTreeItem; SelectDisabled : boolean; SelectCollapsedChildren : boolean);
var i, EndIdx,
    StartIdx : integer;
    Item, LItem : TElTreeItem;
begin
  if FMultiSelect = false then exit;
  if (FromItem = ToItem) and (FromItem <> nil) then exit;

  IsUpdating := true;
  try
    if FromItem = nil then
       StartIdx := 0
    else
       StartIdx := FromItem.AbsoluteIndex;

    if ToItem = nil then
       EndIdx := 0
    else
       EndIdx := ToItem.AbsoluteIndex;

    (*
    if StartIdx > EndIdx then
    begin
      i := EndIdx;
      EndIdx := StartIdx;
      StartIdx := i;
    end;
    *)
    if StartIdx > EndIdx then
    begin
      i := EndIdx;
      EndIdx := StartIdx;
      StartIdx := i;
    end;
    i := StartIdx;
    while i <= EndIdx do
    begin
      Item := TElTreeItem(FAllList[i]);

      if SelectDisabled or (IgnoreEnabled or Item.Enabled) then
         Item.Selected := true;
      if (not Item.Expanded) and (not SelectCollapsedChildren) then
      begin
        LItem := Item.GetLastSubItem;
        if LItem <> nil then
          i := FAllList.IndexOfFrom(i, LItem);
      end;
      inc(i);
    end;
  finally
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.SelectRange(FromItem, ToItem: TElTreeItem);
begin
  SelectRange2(FromItem, ToItem, true, true);
end;

procedure TCustomElTree.SetUseStdBars(value : boolean);
begin
  if Value <> FUseCustomBars then
  begin
    FUseCustomBars := Value;
    RecreateWnd;
    end;
end;

procedure TCustomElTree.SetChStateImage(value: boolean);
begin
  if value = FChStateImage then exit;
  IsUpdating := true;
  FChStateImage := value;
  FView.FRangeUpdate := true;
  FUpdated := true;
  IsUpdating := false;
end;

procedure TCustomElTree.SetHideSelect(value: boolean);
begin
  if value = FHideSelect then exit;
  FHideSelect := value;
  if (not Focused) and (HandleAllocated) then
  begin
    IsUpdating := true;
    FView.FRangeUpdate := true;
    FUpdated := true;
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.Assign(Source: TPersistent);
var
  T: TCustomElTree;
  Form: TCustomForm;

begin
  if Source is TCustomElTree then
  begin
    //inherited;
    IsUpdating := true;
    T := TCustomElTree(Source);
    FItems.Assign(T.FItems);
    FLinesStyle := T.FLinesStyle;
    FLinesColor := T.LinesColor;
    FDeselectChildrenOnCollapse := T.FDeselectChildrenOnCollapse;
    FDrawFocusRect := T.FDrawFocusRect;
    FBarStyle := T.FBarStyle;
    FAlwaysKeepSelection := T.FAlwaysKeepSelection;
    FFullRowSelect := T.FFullRowSelect;
    FDragType := T.FDragType;
    FAutoLookup := T.FAutoLookup;
    FSelectColumn := T.FSelectColumn;
    FAutoExpand := AutoExpand;
    PlusPicture.Assign(T.PlusPicture);
    FMinusPicture.Assign(T.FMinusPicture);
    FLeafPicture.Assign(T.FLeafPicture);
    FCustomPlusMinus := T.FCustomPlusMinus;
    FShowCheckboxes := T.FShowCheckboxes;
    FShowLeafButton := T.FShowLeafButton;
    FHideHorzScrollBar := T.FHideHorzScrollBar;
    FHideVertScrollBar := T.FHideVertScrollBar;

    FBkColor := T.FBkColor;
    FTextColor := T.FTextColor;
    FShowButtons := T.FShowButtons;
    FShowLines := T.FShowLines;
    FShowImages := T.FShowImages;
    FShowRoot := T.FShowRoot;
    FShowHintMode := T.FShowHintMode;
    ShowColumns := T.ShowColumns;
    FBorderStyle := T.FBorderStyle;
    FCanEdit := T.FCanEdit;
    FHorizontalLines := T.FHorizontalLines;
    FVerticalLines := T.FVerticalLines;
    FVertScrollTracking := T.FVertScrollTracking;
    FHorzScrollTracking := T.FHorzScrollTracking;
    FTracking := T.FTracking;
    HeaderHotTrack := T.HeaderHotTrack;
    FODFollowCol := T.FODFollowCol;
    FODMask := T.FODMask;
    FDragTrgDrawMode := T.FDragTrgDrawMode;
    TopIndex := T.TopIndex;
    FAutoLineHeight := T.FAutoLineHeight;
    FLineHeight := T.FLineHeight;

    FStorage := T.FStorage;
    FStoragePath := T.FStoragePath;

    FUpdated := true;
    with FView do
    begin
      FHRange := -1;
      FVisUpdated := true;
      FClearVis := true;
      FClearAll := true;
    end;
    IsUpdating := false;
    if csDesigning in ComponentState then
    begin
      Form := GetParentForm(self);
      if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
    end;
    end
  else
    inherited;
end;

procedure TCustomElTree.Sort;
begin
  TriggerSortBegin;
  inc(FInSorting);
  FItems.FRoot.Sort(recursive);
  dec(FInSorting);
  TriggerSortEnd;
end;

procedure TCustomElTree.CMMouseEnter;
begin
  inherited;
  FMouseOver := true;
  if Flat and (not FView.FHasFocus) and
     (FInactiveBorderType <> FActiveBorderType) and (not IsThemed) then
       DrawFlatBorder(false, false);
end;

procedure TCustomElTree.CMMouseLeave;
begin
  FMouseOver := false;
  if Flat and (not FView.FHasFocus) and
     (FInactiveBorderType <> FActiveBorderType)  and (not IsThemed) then
       DrawFlatBorder(false, false);
  inherited;
end;

procedure TCustomElTree.OnHeaderSectionDelete;
begin
  if FHeader.Sections.Count = 0 then
    ShowColumns := false;
  IsUpdating := true;
  with FView do
    if not FShowHeader then
      FHRange := -1
    else
      FClearVis := true;
  AlignPieces;
  if FSortSection >= FHeader.Sections.Count then
    FSortSection := -1;
  if (FSortSections <> nil) then
  begin
    if (Section = nil) or (FSortSections.IndexOf(Section) >= 0) then
    begin
      if (Section <> nil) then
        FSortSections.Remove(Section);
      if SortMode in [smClick, smAddClick] then
        FSortRequired := true;
    end;
  end;
  FUpdated := true;
  IsUpdating := false;
end;

function TCustomElTree.DoGetPicture(Item: TElTreeItem): integer;
begin
  result := Item.ImageIndex;
  if Assigned(FOnItemPicDraw) then FOnItemPicDraw(self, Item, result);
end;

function TCustomElTree.DoGetPicture2(Item: TElTreeItem): integer;
begin
  result := Item.ImageIndex2;
  if Assigned(FOnItemPicDraw2) then FOnItemPicDraw2(self, Item, result);
end;

function TCustomElTree.GetDraggableSections: Boolean;
{ Returns the value of data member FDraggableSections. }
begin
  result := FHeader.AllowDrag;
end; { GetDraggableSections }

procedure TCustomElTree.SetDraggableSections(newValue: Boolean);
begin
  if FHeader.AllowDrag <> newValue then
  begin
    FHeader.AllowDrag := newValue;
  end; { if }
end; { SetDraggableSections }

procedure TCustomElTree.OnHeaderSectionMove(Sender: TCustomElHeader; Section: TElHeaderSection; OldPos, NewPos: integer); { protected }
begin
  IsUpdating := true;
  FView.FClearAll := true;
  FUpdated := true;
  IsUpdating := false;
  TriggerHeaderColumnMoveEvent(Section, OldPos, NewPos);
end; { OnHeaderSectionMove }

procedure TCustomElTree.TriggerHotTrackEvent(OldItem, NewItem: TElTreeItem);
begin
  if assigned(FOnHotTrack) then FOnHotTrack(Self, OldItem, NewItem);
end; { TriggerHotTrackEvent }

procedure TCustomElTree.SetSortMode(newValue: TSortModes);
begin
  if FSortMode <> newValue then FSortMode := newValue;
end; { SetSortMode }

procedure TCustomElTree.SetSortSection(newValue: Integer);
begin
  if FSortSection <> newValue then
  begin
    FSortSection := newValue;
//    if FSortSections <> nil then
//      FSortSections.Clear;
  end;
end; { SetSortSection }

function TCustomElTree.CompareItems(Item1, Item2: TElTreeItem; SM : TElSSortMode; ST : TSortTypes; FSortSection : integer): integer;
var
  T1, T2   : TDateTime;
  N1, N2   : integer;
  F1, F2   : extended;
  B1, B2   : boolean;
  C1, C2   : Currency;
  CurIdx   : integer;
begin
  begin
    if ST = stCustom then
    begin
      FSortSectionToCompare := FSortSection;
      DoCompareItems(Item1, Item2, result);
      if (SM = hsmDescend) or ((SM = hsmNone) and (FSortDir = sdDescend)) then
         result := -result;
    end
    else
    begin
      {$IFDEF USE_VARIANT}
      if (not VarIsEmpty(Item1.FSortData)) and (not VarIsEmpty(Item2.FSortData)) then
      {$ELSE}
      if (Item1.FSortType <> -1) and (Item2.FSortType <> -1) then
      {$ENDIF}
      begin
        {$IFDEF USE_VARIANT}
        if TVarData(Item1.FSortData).VType = TVarData(Item2.FSortData).VType then
        {$ELSE}
        if Item1.FSortType = Item2.FSortType then
        {$ENDIF}
        begin
          if ST = stText then
          begin
{$ifdef LMD_UNICODE}
            {$IFDEF USE_VARIANT}
            result := LMDSign(WideCompareText(Item1.FSortData, Item2.FSortData));
            {$ELSE}
            //if SortUseCase then
            result := LMDSign(LMDWideStrComp(PWideChar(Item1.FSortData), PWideChar(Item2.FSortData)))
            ;
            //else
            //  result := LMDSign(WideCompareText(PWideChar(WideUppercase(WideStrPas(PWidechar(Item1.FSortData)))), PWideChar(WideUppercase(WideStrPas(PWidechar(Item2.FSortData))))));
            {$ENDIF}
{$else}
            {$IFDEF USE_VARIANT}
            result := LMDSign(AnsiCompareText(Item1.FSortData, Item2.FSortData));
            {$ELSE}
            //if SortUseCase then
            result := LMDSign(AnsiStrComp(PChar(Item1.FSortData), PChar(Item2.FSortData)))
            ;
            //else
            //  result := LMDSign(AnsiStrIComp(PChar(Item1.FSortData), PChar(Item2.FSortData)));
            {$ENDIF}
{$endif}
          end
          else
          if ST = stNumber then
          begin
            {$IFDEF USE_VARIANT}
            N1 := Item1.FSortData;
            N2 := Item2.FSortData;
            {$ELSE}
            N1 := Integer(Item1.FSortData);
            N2 := Integer(Item2.FSortData);
            {$ENDIF}
            if N1 > N2 then
               result := 1
            else
            if N1 < N2 then
               result := -1
            else
               result := 0;
          end
          else
          case ST of
            stFloating:
              begin
                {$IFDEF USE_VARIANT}
                F1 := Item1.FSortData;
                F2 := Item2.FSortData;
                {$ELSE}
                F1 := PDouble(Item1.FSortData)^;
                F2 := PDouble(Item2.FSortData)^;
                {$ENDIF}
                if F1 > F2 then
                   result := 1
                else
                if F1 < F2 then
                   result := -1
                else
                   result := 0;
              end;
            stCurrency:
              begin
                {$IFDEF USE_VARIANT}
                C1 := Item1.FSortData;
                C2 := Item2.FSortData;
                {$ELSE}
                C1 := PCurrency(Item1.FSortData)^;
                C2 := PCurrency(Item2.FSortData)^;
                {$ENDIF}
                if C1 > C2 then
                   result := 1
                else
                if C1 < C2 then
                   result := -1
                else
                   result := 0;
              end;
            stDateTime:
              begin
                {$IFDEF USE_VARIANT}
                T1 := Item1.FSortData;
                T2 := Item2.FSortData;
                {$ELSE}

                T1 := PDouble(Item1.FSortData)^;
                T2 := PDouble(Item2.FSortData)^;
                {$ENDIF}
                if T1 > T2 then
                   result := 1
                else
                if T1 < T2 then
                   result := -1
                else
                   result := 0;
              end;
            stDate:
              begin
                {$IFDEF USE_VARIANT}
                T1 := Item1.FSortData;
                T2 := Item2.FSortData;
                T1 := Trunc(T1);
                T2 := Trunc(T2);
                {$ELSE}
                T1 := PDouble(Item1.FSortData)^;
                T2 := PDouble(Item2.FSortData)^;
                T1 := Trunc(T1);
                T2 := Trunc(T2);
                {$ENDIF}

                if T1 > T2 then
                   result := 1
                else
                if T1 < T2 then
                   result := -1
                else
                   result := 0;
              end;
            stTime:
              begin
                {$IFDEF USE_VARIANT}
                T1 := Item1.FSortData;
                T2 := Item2.FSortData;
                T1 := Frac(T1);
                T2 := Frac(T2);
                {$ELSE}
                T1 := PDouble(Item1.FSortData)^;
                T2 := PDouble(Item2.FSortData)^;
                T1 := Frac(T1);
                T2 := Frac(T2);
                {$ENDIF}
                if T1 > T2 then
                   result := 1
                else
                if T1 < T2 then
                   result := -1
                else
                   result := 0;
              end;
            stBoolean:
              begin
               {$IFDEF USE_VARIANT}
                B1 := Item1.FSortData;
                B2 := Item2.FSortData;
                {$ELSE}
                B1 := Integer(Item1.FSortData) > 0;
                B2 := Integer(Item2.FSortData) > 0;
                {$ENDIF}
                if B1 = B2 then
                   result := 0
                else
                if B1 then
                   result := 1
                else
                   result := -1;
              end;
          end;
        end
        else
          // if items can't be compared, they are treated as equal
          result := 0;
      end
      else
      {$IFDEF USE_VARIANT}
      if (VarIsEmpty(Item1.FSortData)) then
      begin
        if (VarIsEmpty(Item2.FSortData)) then
      {$ELSE}
      if Item1.FSortType = -1 then
      begin
        if Item2.FSortType = -1 then
      {$ENDIF}
        begin
          result := 0;
        end
        else
        begin
          result := -1;
        end;
      end
      else
      {$IFDEF USE_VARIANT}
      if (VarIsEmpty(Item2.FSortData)) then
      {$ELSE}
      if Item2.FSortType = -1 then
      {$ENDIF}
        result := 1
      ;
      if (not (SM = hsmAscend)) then
          if (SM = hsmDescend) or ((SM = hsmNone) and (FSortDir = sdDescend)) then
              result := -result;
    end;
  end;
  // he-he, multisort.
  if (result = 0) and (FSortSections <> nil) and (FSortSections.Count > 1) then
  begin
    CurIdx := 0;
    while (CurIdx < FSortSections.Count) do
    begin
      SlowCompareItems(Item1, Item2, FSortSections[CurIdx], Result);
      if (Result <> 0) then
        break;
      Inc(CurIdx);
    end;
  end;
  if (Result = 0) and (Item1 <> Item2) then
  begin
      if (TLMDPtrInt(Pointer(Item1)) > TLMDPtrInt(Pointer(Item2))) then
      Result := 1
      else
        Result := -1;
    if (not (SM = hsmAscend)) then
      if (SM = hsmDescend) or ((SM = hsmNone) and (FSortDir = sdDescend)) then
        result := -result;
  end;
end;

procedure TCustomElTree.SlowCompareItems(Item1, Item2: TElTreeItem; Section :
    TElHeaderSection; var Result : integer);
var
  SectIdx  : Integer;
  Text1,
  Text2    : TLMDString;

  T1, T2   : TDateTime;
  N1, N2   : integer;
  F1, F2   : extended;
  B1, B2   : boolean;
  C1, C2   : Currency;
  V        : Variant;
  IntConv  : boolean;

begin
  SectIdx := Section.Index;
  IntConv := true;
  if (VirtualityLevel <> vlNone) then
  begin
    if Assigned(FOnVirtualValueNeeded) then
    begin
      IntConv := false;
      try
        case SectionTypeToSortType(Section.FieldType) of
          stCustom:
            begin
              FSortSectionToCompare := SectIdx;
              DoCompareItems(Item1, Item2, Result);
            end;
          stText :
            begin
              TriggerVirtualTextNeeded(Item1, SectIdx, Text1);
              TriggerVirtualTextNeeded(Item2, SectIdx, Text2);

              {$ifdef LMD_UNICODE}
              if SortUseCase then
                result := LMDSign(LMDWideStrComp(PWideChar(WideString(Text1)), PWideChar(WideString(Text2))))
              else
                result := LMDSign(LMDWideCompareText(PWideChar(LMDWideUppercase(Text1)), PWideChar(LMDWideUppercase(Text2))));
                {$else}

              if SortUseCase then
                result := LMDSign(AnsiStrComp(PChar(Text1), PChar(Text2)))
              else
                result := LMDSign(AnsiStrIComp(PChar(Text1), PChar(Text2)));
              {$endif}
            end;
          stNumber:
            begin
              TriggerVirtualValueNeeded(Item1, SectIdx, vtInteger, V);
              N1 := V;
              TriggerVirtualValueNeeded(Item2, SectIdx, vtInteger, V);
              N2 := V;

              if N1 < N2 then
                result := -1
              else
              if N1 > N2 then
                result := 1
              else
                result := 0;
            end;
          stFloating:
            begin
              TriggerVirtualValueNeeded(Item1, SectIdx, vtExtended, V);
              F1 := V;
              TriggerVirtualValueNeeded(Item2, SectIdx, vtExtended, V);
              F2 := V;
              if F1 < F2 then
                result := -1
              else
              if F1 > F2 then
                result := 1
              else
                result := 0;
            end;
          stDate,
          stTime,
          stDateTime:
            begin
              TriggerVirtualValueNeeded(Item1, SectIdx, vtExtended, V);
              T1 := V;
              TriggerVirtualValueNeeded(Item2, SectIdx, vtExtended, V);
              T2 := V;
              if T1 < T2 then
                result := -1
              else
              if T1 > T2 then
                result := 1
              else
                result := 0;
            end;
          stBoolean:
            begin
              TriggerVirtualValueNeeded(Item1, SectIdx, vtBoolean, V);
              B1 := V;
              TriggerVirtualValueNeeded(Item2, SectIdx, vtBoolean, V);
              B2 := V;

              if B1 = B2 then
                 result := 0
              else
              if B1 then
                 result := 1
              else
                 result := -1;
            end;
          stCurrency:
            begin
              TriggerVirtualValueNeeded(Item1, SectIdx, vtCurrency, V);
              C1 := V;
              TriggerVirtualValueNeeded(Item2, SectIdx, vtCurrency, V);
              C2 := V;

              if C1 > C2 then
                 result := 1
              else
              if C1 < C2 then
                 result := -1
              else
                 result := 0;
            end;
        end;
      except
        on E : EVariantError do
          IntConv := true;
      end;
    end;
  end;

  if IntConv then
  begin
    FSortSectionToCompare := SectIdx;

    if SectIdx = MainTreeColumn then
    begin
      Text1 := Item1.Text;
      Text2 := Item2.Text;
    end
    else
    begin
      if SectIdx > MainTreeColumn then
        dec(SectIdx);

        if Assigned(Item1.ColumnText) then
        begin
          if SectIdx < Item1.ColumnText.Count then
            Text1 := Item1.ColumnText[SectIdx]
          else
            Text1 := '';
          if SectIdx < Item2.ColumnText.Count then
            Text2 := Item2.ColumnText[SectIdx]
          else
            Text2 := '';
        end;
    end;
    case SectionTypeToSortType(Section.FieldType) of
      stCustom:
        DoCompareItems(Item1, Item2, Result);
      stText :
        {$ifdef LMD_UNICODE}
        if SortUseCase then
          result := LMDSign(LMDWideStrComp(PWideChar(WideString(Text1)), PWideChar(WideString(Text2))))
        else
          result := LMDSign(LMDWideCompareText(PWideChar(LMDWideUppercase(Text1)), PWideChar(LMDWideUppercase(Text2))));
        {$else}

        if SortUseCase then
          result := LMDSign(AnsiStrComp(PChar(Text1), PChar(Text2)))
        else
          result := LMDSign(AnsiStrIComp(PChar(Text1), PChar(Text2)));
        {$endif}
      stNumber:
        begin
          N1 := StrToIntDef(Text1, 0);
          N2 := StrToIntDef(Text2, 0);
          if N1 < N2 then
            result := -1
          else
          if N1 > N2 then
            result := 1
          else
            result := 0;
        end;
      stFloating:
        begin
          TextToFloat(PChar(String(Text1)), F1, fvExtended);
          TextToFloat(PChar(String(Text2)), F2, fvExtended);
          if F1 < F2 then
            result := -1
          else
          if F1 > F2 then
            result := 1
          else
            result := 0;
        end;
      stDateTime:
        begin
          if (Length(Text1) = 0) or (Length(Text2) = 0) then
          begin
            if Length(Text1) = 0 then
              Result := -1
            else
              Result := 1;
          end
          else
          begin
            T1 := StrToDateTime(Text1);
            T2 := StrToDateTime(Text2);
            if T1 < T2 then
              Result := -1
            else
            if T1 > T2 then
              Result := 1
            else
              Result := 0;
          end;
        end;
      stDate:
        begin
          if (Length(Text1) = 0) or (Length(Text2) = 0) then
          begin
            if Length(Text1) = 0 then
              Result := -1
            else
              Result := 1;
          end
          else
          begin
            T1 := StrToDate(Text1);
            T2 := StrToDate(Text2);
            if T1 < T2 then
              Result := -1
            else
            if T1 > T2 then
              Result := 1
            else
              Result := 0;
          end;
        end;
      stTime:
        begin
          if (Length(Text1) = 0) or (Length(Text2) = 0) then
          begin
            if Length(Text1) = 0 then
              Result := -1
            else
              Result := 1;
          end
          else
          begin
            T1 := StrToTime(Text1);
            T2 := StrToTime(Text2);
            if T1 < T2 then
              Result := -1
            else
            if T1 > T2 then
              Result := 1
            else
              Result := 0;
          end;
        end;
      stBoolean:
        begin
          B1 := Text1 <> '';
          B2 := Text2 <> '';
          if B1 = B2 then
             result := 0
          else
          if B1 then
             result := 1
          else
             result := -1;
        end;
      stCurrency:
        begin
          C1 := LMDPrettyStrToCurr(Text1);
          C2 := LMDPrettyStrToCurr(Text2);
          if C1 > C2 then
             result := 1
          else
          if C1 < C2 then
             result := -1
          else
             result := 0;
        end;
    end;
  end;
  {
  if (Result = 0) and (Item1 <> Item2) then
    if (Integer(Pointer(Item1)) > Integer(Pointer(Item2))) then
      Result := 1
    else
      Result := -1;
  }
  if Section.SortMode = hsmDescend then
    Result := -Result;
end;

procedure TCustomElTree.Update;
begin
  inherited;
end;

function TCustomElTree.IsEditing: boolean;
begin
  result := (FView.FInpEdit <> nil) and FView.FInpEdit.Visible and FView.FInpEdit.Editing;
  // result := FView.FEditing;
end;

procedure TCustomElTree.SetStorage(newValue: TElIniFile);
begin
  if newValue <> FStorage then
  begin
    if FStorage <> nil then
      if not (csDestroying in FStorage.ComponentState) then
        FStorage.RemoveFreeNotification(Self);
    FStorage := newValue;
    if FStorage <> nil then
      FStorage.FreeNotification(Self);
  end;
end;

function TCustomElTree.GetNodeAt(X, Y: integer): TElTreeItem; { public }
begin
  result := GetItemAtY(Y);
end; { GetNodeAt }

procedure TCustomElTree.SetShowCheckboxes(newValue: Boolean);
begin
  if (FShowCheckboxes <> newValue) then
  begin
    IsUpdating := true;
    FShowCheckboxes := newValue;
    with FView do
    begin
      if not FShowHeader then FView.FHRange := -1;
      FClearAll := true;
    end;
    FUpdated := true;
    IsUpdating := false;
  end; {if}
end; {SetShowCheckboxes}

procedure TCustomElTree.SetPlusPicture(newValue: TBitmap);
begin
  PlusPicture.Assign(newValue);
end; {SetPlusPicture}

procedure TCustomElTree.SetMinusPicture(newValue: TBitmap);
begin
  MinusPicture.Assign(newValue);
end; {SetMinusPicture}

procedure TCustomElTree.SetCustomPlusMinus(newValue: Boolean);
begin
  if (FCustomPlusMinus <> newValue) then
  begin
    IsUpdating := true;
    FCustomPlusMinus := newValue;
    if FCustomPlusMinus then
    begin
      GetPlusPicture;
      GetMinusPicture;
      GetLeafPicture;
    end;
    with FView do
    begin
      if not FShowHeader then FView.FHRange := -1;
      FClearAll := true;
    end;
    FUpdated := true;
    IsUpdating := false;
  end; {if}
end; {SetCustomPlusMinus}

procedure TCustomElTree.SetSelectColumn(newValue: Integer);
begin
  if (FSelectColumn <> newValue) then
  begin
    if (newValue > -2) and ((newValue < FHeader.Sections.Count) or
       (csLoading in ComponentState)) then
    begin
      FSelectColumn := newValue;
      if FView.FEditTimer <> nil then
        FView.FEditTimer.Enabled := false;
      if not FRowSelect then
      begin
        if not FMultiSelect then
        begin
          with FView do
            if (FFocused <> nil) then FFocused.UpdateItem;
        end else
        begin
          IsUpdating := true;
          FView.FClearAll := true;
          FUpdated := true;
          IsUpdating := false;
        end; // if/else
      end; //if
    end; // if
  end;
end; {SetSelectColumn}

procedure TCustomElTree.TriggerHeaderLookupEvent;
begin
  if (assigned(FOnHeaderLookup)) then FOnHeaderLookup(Self, Section, Text);
end; {TriggerHeaderLookupEvent}

procedure TCustomElTree.TriggerHeaderLookupDoneEvent;
begin
  if (assigned(FOnHeaderLookupDone)) then FOnHeaderLookupDone(Self, Section, Text, Accepted);
end; {TriggerHeaderLookupDoneEvent}

procedure TCustomElTree.TriggerHeaderSectionExpandEvent(Section:
  TElHeaderSection);
begin
  if (assigned(FOnHeaderSectionExpand)) then FOnHeaderSectionExpand(Self, Section);
end;

procedure TCustomElTree.TriggerHeaderSectionCollapseEvent(Section: TElHeaderSection);
begin
  if (assigned(FOnHeaderSectionCollapse)) then
    FOnHeaderSectionCollapse(Self, Section);
end;

procedure TCustomElTree.ScrollBarMouseDown;
begin
  if (not FView.Focused) and FView.CanFocus and CanFocus {and
     (not (csDesigning in ComponentState))} then
      FView.SetFocus;
end;

procedure TCustomElTree.SBChanged;
begin
  if (not FIgnoreSBChange) and (not (csLoading in ComponentState)) and ((Owner = nil) or (not (csLoading in Owner.ComponentState))) then
  begin
    AlignPieces;
    UpdateScrollBars;
  end;
end;

procedure TCustomElTree.Loaded;

var
  DT: TElDragType;

var SS : TScrollStyle;
begin
  inherited;
  IsUpdating := true;
  FHeader.Loaded;
  if (FSortMode = smAdd) or (FSortMode = smAddClick) then
  begin
    TriggerSortBegin;
    FItems.FRoot.Sort(true);
    TriggerSortEnd;
  end;
  FUpdated := true;
  FView.FClearAll := true;

  if HandleAllocated then
  begin
    DT := FDragType;
    FDragType := dtDelphi;
    DragType := DT;
    OnFontChange(Font);
  end;

  ReRenderAllHTMLItems;
  if SelectColumn >= FHeader.Sections.Count then
    SelectColumn := -1;
  FHScrollBar.Loaded;
  FVScrollBar.Loaded;
  if FHeader.Height <> FHeaderHeight then
  begin
    FHeader.Height := FHeaderHeight;
    Resize;
    if not (BackgroundType in [bgtColorFill, bgtCenterBitmap]) then FView.RedoTmpBmp;
    end
  else
    Resize;
  if FForcedScrollBars <> ssNone then
  begin
    SS := FForcedScrollBars;
    FForcedScrollBars := ssNone;
    ForcedScrollBars := SS;
  end;
  if FHeaderUseTreeFont then
    FHeader.Font := Font
  else
    FHeader.Font := FHeaderFont;
  AutoSizeAllColumns;
  IsUpdating := false;
end;

procedure TCustomElTree.SetDragType(newValue: TElDragType);
begin
  if (FDragType <> newValue) then
  begin
    if newValue = dtDelphi then

    begin
      FDropTarget.Free;
      FDropTarget := nil;
    end

    else
    begin
      if (FDragType = dtDelphi) and FView.HandleAllocated and (not (csLoading in ComponentState))
        and (FDropTarget = nil)
        then // when switching from one to another OLE mode we don't create a drop target

      begin

        FDropTarget := TElDropTarget.Create(nil);
        FDropTarget.Target := FView;
        FDropTarget.OnTargetDrag := FView.OnDropTargetDrag;
        FDropTarget.OnTargetDrop := FView.OnDropTargetDrop;

      end;
    end;
    FDragType := newValue;
  end; {if}
end; {SetDragType}

procedure TCustomElTree.TriggerOleTargetDragEvent;
begin
  Y := Y + FView.Top;
  X := X + FView.Left;
  if (assigned(FOnOleTargetDrag)) then
    FOnOleTargetDrag(Self, State, Source, Shift, X, Y, DragType);
end; {TriggerOleTargetDragEvent}

procedure TCustomElTree.TriggerOleTargetDropEvent;
begin
  Y := Y + FView.Top;
  X := X + FView.Left;
  if (assigned(FOnOleTargetDrop)) then
    FOnOleTargetDrop(Self, Source, Shift, X, Y, DragType);
end; {TriggerOleTargetDropEvent}

procedure TCustomElTree.TriggerOleDragStartEvent;
begin
  if (assigned(FOnOleDragStart)) then
    FOnOleDragStart(Self, dataObj, dropSource, dwOKEffects);
end; {TriggerOleDragStartEvent}

procedure TCustomElTree.TriggerOleDragFinishEvent;
begin
  if (assigned(FOnOleDragFinish)) then FOnOleDragFinish(Self, dwEffect, Result);
end; {TriggerOleDragFinishEvent}

procedure TCustomElTree.HeaderResizeTransfer(Sender: TObject);
begin
  if (assigned(FOnHeaderResize)) then
    FOnHeaderResize(Self);
end;

procedure TCustomElTree.HeaderResizeHandler(Sender: TObject);
begin
  DoHeaderResize(Sender);
  HeaderResizeTransfer(Self);
end;

function TCustomElTree.IsInView(Item: TElTreeItem): Boolean;
begin
  result := FView.FVisible.IndexOf(Item) <> -1;
end;

function TCustomElTree.SectionTypeToSortType(SectionType: TElFieldType):
  TSortTypes;
begin
  case SectionType of
    sftText: result := stText;
    sftNumber: result := stNumber;
    sftFloating: result := stFloating;
    sftDateTime: result := stDateTime;
    sftDate: result := stDate;
    sftTime: result := stTime;
    sftBool: result := stBoolean;
    sftCurrency: result := stCurrency;
  else
    result := stCustom;
  end;
end;

function TCustomElTree.GetStickyHeaderSections: Boolean;
begin
  result := FHeader.StickySections;
end; {GetStickyHeaderSections}

procedure TCustomElTree.SetStickyHeaderSections(newValue: Boolean);
begin
  FHeader.StickySections := newValue;
  AlignPieces;
end; {SetStickyHeaderSections}

procedure TCustomElTree.SetBarStyle(newValue: Boolean);
begin
  if (FBarStyle <> newValue) then
  begin
    IsUpdating := true;
    FBarStyle := newValue;
    if FBarStyle then
    begin
      BkColor := clBtnFace;
      TextColor := clBtnText;
      LinesColor := clBtnShadow;
    end;
    if FAutoLineHeight then FLineHeight := DefineLineHeight;
    with FView do
    begin
      if not FShowHeader then FHRange := -1;
      FClearAll := true;
    end;
    FUpdated := true;
    IsUpdating := false;
  end; {if}
end; {SetBarStyle}

procedure TCustomElTree.SetDrawFocusRect(newValue: Boolean);
begin
  if (FDrawFocusRect <> newValue) then
  begin
    FDrawFocusRect := newValue;
    if ItemFocused <> nil then ItemFocused.RedrawItem(true);
  end; {if}
end; {SetDrawFocusRect}

procedure TCustomElTree.TriggerMeasureItemPartEvent(Item: TElTreeItem; PartIndex: integer; var Size: TPoint);
begin
  if (assigned(FOnMeasureItemPart)) then
    FOnMeasureItemPart(Self, Item, PartIndex, Size);
end; {TriggerMeasureItemPartEvent}

procedure TCustomElTree.SetHorzDivLinesColor(newValue: TColor);
begin
  if (FHorzDivLinesColor <> newValue) then
  begin
    IsUpdating := true;
    FHorzDivLinesColor := newValue;
    if FHorizontalLines then
    begin
      FView.FClearAll := true;
      FUpdated := true;
    end;
    IsUpdating := false;
  end; {if}
end; {SetLinesColor}

procedure TCustomElTree.SetLinesColor(newValue: TColor);
begin
  if (FLinesColor <> newValue) then
  begin
    IsUpdating := true;
    FLinesColor := newValue;
    if FShowLines then
    begin
      FView.FClearAll := true;
      FUpdated := true;
    end;
    IsUpdating := false;
  end; {if}
end; {SetLinesColor}

procedure TCustomElTree.SetLinesStyle(newValue: TPenStyle);
begin
  if (FLinesStyle <> newValue) then
  begin
    IsUpdating := true;
    FLinesStyle := newValue;
    if FShowLines then
    begin
      FView.FClearAll := true;
      FUpdated := true;
    end;
    IsUpdating := false;
  end; {if}
end; {SetLinesStyle}

procedure TCustomElTree.SetImages2(newValue: TCustomImageList);
var
  i: integer;
begin
  if FImages2 = newValue then exit;
  IsUpdating := true;
  if FImages2 <> nil then
  begin
    if not (csDestroying in FImages2.ComponentState) then
      FImages2.RemoveFreeNotification(Self);
    FImages2.UnRegisterChanges(FImageChangeLink);
  end;
  FImages2 := newValue;
  if FImages2 <> nil then
  begin
    FImages2.RegisterChanges(FImageChangeLink);
    FImages2.FreeNotification(Self);
  end;
  if csDestroying in ComponentState then exit;
  i := DefineLineHeight;
  if FAutoLineHeight and (i <> FLineHeight) then
  begin
    FLineHeight := i;
    with FView do
    begin
      FClearVis := true;
      FClearAll := true;
    end;
  end;
  if not FShowHeader then
  begin
    with FView do
    begin
      FHRange := -1;
      DefineHRange;
    end;
    if RightAlignedView then
    begin
      FRightAlignedView := false;
      RightAlignedView := true;
    end;
  end;
  FView.FRangeUpdate := true;
  FUpdated := true;
  IsUpdating := false;
end;

procedure TCustomElTree.SetAlphaImages2(newValue: TCustomImageList);
{var
  i: integer;}
begin
  if FAlphaImages2 = newValue then exit;
  IsUpdating := true;
  if FAlphaImages2 <> nil then
  begin
    if not (csDestroying in FAlphaImages2.ComponentState) then
      FAlphaImages2.RemoveFreeNotification(Self);
    FAlphaImages2.UnRegisterChanges(FAImageChangeLink);
  end;
  FAlphaImages2 := newValue;
  if FAlphaImages2 <> nil then
  begin
    FAlphaImages2.RegisterChanges(FAImageChangeLink);
    FAlphaImages2.FreeNotification(Self);
  end;
  if csDestroying in ComponentState then exit;
{
  i := DefineLineHeight;
  if FAutoLineHeight and (i <> FLineHeight) then
  begin
    FLineHeight := i;
    with FView do
    begin
      FClearVis := true;
      FClearAll := true;
    end;
  end;
  if not FShowHeader then
  begin
    with FView do
    begin
      FHRange := -1;
      DefineHRange;
    end;
    if RightAlignedView then
    begin
      FRightAlignedView := false;
      RightAlignedView := true;
    end;
  end;
}
  FView.FRangeUpdate := true;
  FUpdated := true;
  IsUpdating := false;
end;

procedure TCustomElTree.SetRightAlignedView(newValue: Boolean);
begin
  if (FRightAlignedView <> newValue) then
  begin
    FRightAlignedView := newValue;
    FHeader.RightAlignedOrder := newValue;
    if not FShowHeader then
    begin
      with FView do
      begin
        if FHRange = -1 then DefineHRange;
        if newValue then SetHPosition(FHRange - FHPos) else SetHPosition(0);
      end;
    end;
    FView.Invalidate;//Repaint;
  end; {if}
end;

procedure TCustomElTree.SetFlat(newValue: Boolean);
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    if Flat then
      Ctl3D := true;
    if HandleAllocated then
      RecreateWnd;
    //SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
    // UpdateFrame;
    end; { if }
end; { SetFlat }

procedure TCustomElTree.DrawFlatBorder(HorzTracking, VertTracking : boolean);
var
  DC : Windows.HDC;
  SavedDC : Windows.HDC;
  b  : boolean;
  BS : TElFlatBorderType;
  RW,
  RC : TRect;
  AColor : TColor;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
  const ScrollBars: array [boolean, boolean] of TScrollStyle = ((ssNone, ssVertical), (ssHorizontal, ssBoth));

begin
  LUseThemeMode := UseThemeMode;
  Windows.GetClientRect(Handle, RC);
  if not UseCustomScrollBars then
  begin
    if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL));
    if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
      inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
  end;
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  OffsetRect(RW, -RW.Left, -RW.Top);

  DC := GetWindowDC(Handle);
  try
    if (LUseThemeMode <> ttmNone) and (BorderStyle = bsSingle) then
    begin
      SavedDC := SaveDC(DC);
      Inc(Rw.Right, 1);
      Inc(Rw.Bottom, 1);
      ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);

      LDetails.Element := teTreeview;
      LDetails.Part := 0;
      LDetails.State := 0;

      LMDThemeServices.DrawElement(LUseThemeMode, DC, LDetails, RW, nil);
      // DrawThemeBackground(Theme, DC, 0, 0, RW, nil);

      RestoreDC(DC, SavedDC);
    end;
    begin
      if (BorderStyle = bsSingle) and (LUseThemeMode = ttmNone) then
      begin
        b := FView.FHasFocus or FMouseOver;
        if b then BS := FActiveBorderType else BS := FInactiveBorderType;
        if ((not FFlat) and FUseCustomBars) then
           BS := fbtSunken;
        if bs = fbtRaised then bs := fbtRaisedOuter;
        if Focused or FMouseOver then
          AColor := LineBorderActiveColor
        else
          AColor := LineBorderInactiveColor;

        DrawFlatFrameEx2(DC, RW, AColor, BkColor, b, Enabled, BorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
      end;
      if (not FUseCustomBars) and (LUseThemeMode = ttmNone) then
         DrawFlatScrollBars(Handle, DC, RW, (Focused or FMouseOver) and (not FlatFocusedScrollBars),
                            ScrollBars[FHScrollVisible, FVScrollVisible], HorzTracking, VertTracking, false, GetWindowLong(Handle, GWL_STYLE), GetWindowLong(Handle, GWL_EXSTYLE));
      end;
    finally
    ReleaseDC(Handle, DC);
    end;
end;

procedure TCustomElTree.DrawFlatBorderEx(DC : Windows.HDC; HorzTracking,
VertTracking : boolean);
var
  b  : boolean;
  BS : TElFlatBorderType;
  SavedDC : Windows.HDC;
  RW,
  RC : TRect;
  AColor : TColor;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
  const ScrollBars: array [boolean, boolean] of TScrollStyle = ((ssNone, ssVertical), (ssHorizontal, ssBoth));
begin
  LUseThemeMode := UseThemeMode;
  Windows.GetClientRect(Handle, RC);
  if not UseCustomScrollBars then
  begin
    if GetWindowLong(Handle, GWL_STYLE) and WS_VSCROLL <> 0 then
      inc(RC.Right, GetSystemMetrics(SM_CXVSCROLL));
    if GetWindowLong(Handle, GWL_STYLE) and WS_HSCROLL <> 0 then
      inc(RC.Bottom, GetSystemMetrics(SM_CYHSCROLL));
  end;
  GetWindowRect(Handle, RW);
  MapWindowPoints(0, Handle, RW, 2);
  OffsetRect(RC, -RW.Left, -RW.Top);
  OffsetRect(RW, -RW.Left, -RW.Top);

  if (LUseThemeMode <> ttmNone) and (BorderStyle = bsSingle) then
  begin
    SavedDC := SaveDC(DC);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    LDetails.Element := teTreeview;
    LDetails.State := 0;
    LDetails.Part := 0;
    LMDThemeServices.DrawElement(LUseThemeMode, DC, LDetails, RW, nil);
    // DrawThemeBackground(Theme, DC, 0, 0, RW, nil);

    RestoreDC(DC, SavedDC);
  end;

  begin
    if (BorderStyle = bsSingle) and (LUseThemeMode = ttmNone) then
    begin
      b := FView.FHasFocus or FMouseOver;
      if b then BS := FActiveBorderType else BS := FInactiveBorderType;
      if ((not FFlat) and FUseCustomBars) then
         BS := fbtSunken;
      if bs = fbtRaised then bs := fbtRaisedOuter;
      if Focused or FMouseOver then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;

      DrawFlatFrameEx2(DC, RW, AColor, BkColor, b, Enabled, FBorderSides, BS, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
    end;

    if (not FUseCustomBars) and (LUseThemeMode = ttmNone) then
       DrawFlatScrollBars(Handle, DC, RW,
                          (Focused or FMouseOver) and (not FlatFocusedScrollBars),
                          ScrollBars[FHScrollVisible, FVScrollVisible],
                          HorzTracking, VertTracking, false, GetWindowLong(Handle, GWL_STYLE), GetWindowLong(Handle, GWL_EXSTYLE));
  end;
end;

procedure TCustomElTree.WMNCCalcSize(var Message : TWMNCCalcSize);
begin

   if BorderStyle = bsSingle then
   begin
      inc(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
      inc(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
      dec(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
      dec(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));
      if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
        Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
      if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
        Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;

      if not (ebsLeft in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(smYEdge[Ctl3D]));
      if not (ebsTop in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(smXEdge[Ctl3D]));
      if not (ebsRight in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(smYEdge[Ctl3D]));
      if not (ebsBottom in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(smXEdge[Ctl3D]));

      if Message.CalcSize_Params.rgrc[0].Right < Message.CalcSize_Params.rgrc[0].Left then
        Message.CalcSize_Params.rgrc[0].Right := Message.CalcSize_Params.rgrc[0].Left;
      if Message.CalcSize_Params.rgrc[0].Bottom < Message.CalcSize_Params.rgrc[0].Top then
        Message.CalcSize_Params.rgrc[0].Bottom := Message.CalcSize_Params.rgrc[0].Top;
  end;
  Message.Result := 0;
end;

procedure TCustomElTree.CMEnabledChanged(var Message: TMessage);

begin
  inherited;
  FVScrollBar.Enabled := Enabled;
  FHScrollBar.Enabled := Enabled;
end;

procedure TCustomElTree.WMNCHITTEST(var Msg : TWMNCHitTest);  { private }
begin
  inherited;
  if FUseCustomBars then
  begin
    if (Msg.Result = HTHSCROLL) or (Msg.Result = HTVSCROLL) then
        Msg.Result := HTBORDER;
  end;
end;  { WMNCHITTEST }

procedure TCustomElTree.WMNCPaint(var Msg: TWMNCPaint); { private }
var
  DC : HDC;
begin
  if FHook <> nil then
  begin
    if FHook.Control = nil then
    begin
      FHook.Control := GetParentForm(Self);
      FHook.Active := DoubleBuffered and (not (csDesigning in componentState));
    end;
  end;

  if not FUseCustomBars then
    inherited;
  if (Flat or FUseCustomBars or IsThemed or
      (not FUseCustomBars and not IsThemed)) and (BorderStyle = bsSingle) then
  begin
    DC := GetWindowDC(Handle);
    DrawFlatBorderEx(DC, false, false);

    ReleaseDC(Handle, DC);
    Msg.Result := 0;
  end;
end; { WMNCPaint }

procedure TCustomElTree.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  FView.MouseMove(KeysToShiftState(Message.Keys),Message.XPos - FView.Left, Message.YPos - FView.Top);
end;

procedure TCustomElTree.SetRightAlignedText(newValue: Boolean);
begin
  if (FRightAlignedText <> newValue) then
  begin
    FRightAlignedText := newValue;
    FHeader.RightAlignedText := newValue;
    RecreateWnd;
    end; {if}
end;

procedure TCustomElTree.SetForcedScrollBars(newValue : TScrollStyle);
begin
  if (FForcedScrollBars <> newValue) then
  begin
    FForcedScrollBars := newValue;
    if HandleAllocated then
    begin
      if (not FUseCustomBars) then
         RecreateWnd;
      IsUpdating := true;
      UpdateScrollBars;

      FUpdated   := true;
      IsUpdating := false;
    end;
  end;  { if }
end;  { SetForcedScrollBars }

procedure TCustomElTree.SetFilteredVisibility(newValue: Boolean);
begin
  if (FFilteredVisibility <> newValue) then
  begin
    IsUpdating := true;
    FFilteredVisibility := newValue;
    if newValue then
      UpdateDiffItems;
    with FView do
    begin
      FVisUpdated := true;
      FClearVis := true;
      FClearAll := true;
      if not FShowHeader then
        FHRange := -1;
      FRangeUpdate := true;
    end;
    FUpdated := true;
    IsUpdating := false;
  end; {if}
end;

procedure TCustomElTree.TriggerApplyVisFilterEvent(Item: TElTreeItem; var
  Hidden: boolean);
begin
  if (assigned(FOnApplyVisFilter)) then
    FOnApplyVisFilter(Self, Item, Hidden);
end;

procedure TCustomElTree.SetHPosition(value: integer);
begin
  FView.SetHPosition(value);
end;

procedure TCustomElTree.SetVPosition(value: integer);
begin
  FView.SetVPosition(value);
end;

procedure TCustomElTree.ClickTransfer(Sender : TObject);
{ Transfers FView OnClick event to the outside world. }
begin
  if (assigned(FOnClick)) then FOnClick(Self);  { Substitute Self for subcomponent's Sender. }
end;  { ClickTransfer }

procedure TCustomElTree.DblClickTransfer(Sender : TObject);
{ Transfers FView OnDblClick event to the outside world. }
begin
  if (assigned(FOnDblClick)) then FOnDblClick(Self);
end;  { DblClickTransfer }
(*
procedure TCustomElTree.EndDragTransfer(Sender : TObject; Source : TObject; X : Integer; Y : Integer);
begin
  y := Y + FView.Top;
  X := X + FView.Left;
  if Source = FView then Source := Self
  else
  if Source is TElTreeDragObject then Source := TElTreeDragObject(Source).Control;
  if (assigned(FOnDrop)) then
    FOnDrop(Self, Source , X , Y );  { Substitute Self for subcomponent's Sender. }
end;
*)
procedure TCustomElTree.DropTransfer(Sender : TObject; Source : TObject; X : Integer; Y : Integer);
{ Transfers FView OnDragDrop event to the outside world. }
begin
  y := Y + FView.Top;
  X := X + FView.Left;
  {if Source is TElTreeDragObject then
     Sender := Source
  else
     }Sender := Self;
  if Source = FView then
     Source := Self
  else
  if Source is TElTreeDragObject then
     Source := TElTreeDragObject(Source).Control;
  if (assigned(FOnDrop)) then
     FOnDrop(Sender, Source , X , Y );  { Substitute Self for subcomponent's Sender. }
end;  { DropTransfer }

procedure TCustomElTree.OverTransfer(Sender : TObject; Source : TObject; X : Integer; Y : Integer; State : TDragState; var Accept : Boolean);
{ Transfers FView OnDragOver event to the outside world. }
begin
  Accept := false;
  y := Y + FView.Top;
  X := X + FView.Left;
  {if Source is TElTreeDragObject then
     Sender := Source
  else}
     Sender := Self;
  if Source = FView then
     Source := Self
  else
  if Source is TElTreeDragObject then
     Source := TElTreeDragObject(Source).Control;
  if (assigned(FOnOver)) then
     FOnOver(Sender, Source , X , Y , State , Accept );  { Substitute Self for subcomponent's Sender. }
end;  { OverTransfer }

procedure TCustomElTree.DragTransfer(Sender : TObject; Target : TObject; X : Integer; Y : Integer);
{ Transfers FView OnEndDrag event to the outside world. }
begin
  y := Y + FView.Top;
  X := X + FView.Left;
  {if Target is TElTreeDragObject then
     Sender := Target
  else
     }Sender := Self;
  if Target = FView then Target := Self;
  if (assigned(FOnDrag)) then
    FOnDrag(Sender, Target , X , Y );  { Substitute Self for subcomponent's Sender. }
end;  { DragTransfer }

procedure TCustomElTree.EnterTransfer(Sender : TObject);
{ Transfers FView OnEnter event to the outside world. }
begin
  if (assigned(FOnEnter)) then
    FOnEnter(Self);  { Substitute Self for subcomponent's Sender. }
end;  { EnterTransfer }

procedure TCustomElTree.ExitTransfer(Sender : TObject);
{ Transfers FView OnExit event to the outside world. }
begin
  if (assigned(FOnExit)) then
    FOnExit(Self);  { Substitute Self for subcomponent's Sender. }
end;  { ExitTransfer }

procedure TCustomElTree.KeyDownTransfer(Sender : TObject; var Key : Word; Shift : TShiftState);
{ Transfers FView OnKeyDown event to the outside world. }
begin
  if (assigned(FOnKeyDown)) then
    FOnKeyDown(Self, Key , Shift );  { Substitute Self for subcomponent's Sender. }
end;  { KeyDownTransfer }

procedure TCustomElTree.KeyPressTransfer(Sender : TObject; var Key : Char);
{ Transfers FView OnKeyPress event to the outside world. }
begin
  if (assigned(FOnKeyPress)) then
    FOnKeyPress(Self, Key );  { Substitute Self for subcomponent's Sender. }
end;  { KeyPressTransfer }

procedure TCustomElTree.KeyUpTransfer(Sender : TObject; var Key : Word; Shift : TShiftState);
{ Transfers FView OnKeyUp event to the outside world. }
begin
  if (assigned(FOnKeyUp)) then
    FOnKeyUp(Self, Key , Shift );  { Substitute Self for subcomponent's Sender. }
end;  { KeyUpTransfer }

procedure TCustomElTree.MouseDownTransfer(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X : Integer; Y : Integer);
{ Transfers FView OnMouseDown event to the outside world. }
begin
  y := Y + FView.Top;
  X := X + FView.Left;
  if (assigned(FOnMouseDown)) then
    FOnMouseDown(Self, Button , Shift , X , Y );  { Substitute Self for subcomponent's Sender. }
end;  { MouseDownTransfer }

procedure TCustomElTree.MouseMoveTransfer(Sender : TObject; Shift : TShiftState; X : Integer; Y : Integer);
{ Transfers FView OnMouseMove event to the outside world. }
begin
  Y := Y + FView.Top;
  X := X + FView.Left;
  if (assigned(FOnMouseMove)) then
    FOnMouseMove(Self, Shift , X , Y );  { Substitute Self for subcomponent's Sender. }
end;  { MouseMoveTransfer }

procedure TCustomElTree.MouseUpTransfer(Sender : TObject; Button : TMouseButton; Shift : TShiftState; X : Integer; Y : Integer);
{ Transfers FView OnMouseUp event to the outside world. }
begin
  Y := Y + FView.Top;
  X := X + FView.Left;
  if (assigned(FOnMouseUp)) then
    FOnMouseUp(Self, Button , Shift , X , Y );  { Substitute Self for subcomponent's Sender. }
end;  { MouseUpTransfer }

procedure TCustomElTree.StartDragTransfer(Sender : TObject; var DragObject : TDragObject);
{ Transfers FView OnStartDrag event to the outside world. }

begin
  if DragObject <> nil then
    with DragObject.DragPos do
      DragObject.DragPos := Point(X + FView.Left, Y + FView.Top);

  if (assigned(FOnStartDrag)) then
    FOnStartDrag(Self, DragObject);  { Substitute Self for subcomponent's Sender. }

  if DragObject <> nil then
    with DragObject.DragPos do
      DragObject.DragPos := Point(X - FView.Left, Y - FView.Top);

  if DragObject = nil then
  begin
    DragObject := TElTreeDragObject.Create(Self);
  end;
end;  { StartDragTransfer }

procedure TCustomElTree.MeasureSectionTransfer(Sender : TObject; Section : TElHeaderSection; var Size: TPoint);
begin
  if Assigned(FOnHeaderSectionMeasure) then FOnHeaderSectionMeasure(Self, Section, Size);
end;

function TCustomElTree.CreateView : TElTreeView;  { protected }
begin
  result := TElTreeView.Create(Self);
end;  { CreateView }

function TCustomElTree.CreateInplaceManager: TElTreeInplaceManager;
begin
  Result := TElTreeInplaceManager.Create(Self);
end;

{ Exposed properties' Read/Write methods: }
procedure TCustomElTree.SetCursor(newValue : TCursor);
begin
  FView.Cursor := newValue;
  if newValue <> FCursor then FCursor := newValue;
end;  { SetCursor }

function TCustomElTree.GetCursor : TCursor;
{ Returns the Cursor property from the FView subcomponent. }
begin
  GetCursor := FView.Cursor;
end;  { GetCursor }

function TCustomElTree.SetScrollInfo(hWnd: HWND; BarFlag: Integer; const ScrollInfo: TScrollInfo; Redraw: BOOL): Integer;

begin
  if (hWnd = FHScrollBar.Handle) or (hWnd = FVScrollBar.Handle) then
  begin
    Result := SendMessage(hWnd, SBM_SetScrollInfo, WPARAM(Redraw), LPARAM(@ScrollInfo));
    end
  else
    result := -1;
end;

function TCustomElTree.GetScrollInfo(hWnd: HWND; BarFlag: Integer; var ScrollInfo: TScrollInfo): BOOL;
begin
  if (hWnd = FHScrollBar.Handle) or (hWnd = FVScrollBar.Handle) then
  begin
    SendMessage(hWnd, SBM_GetScrollInfo, 0, TLMDPtrInt(@ScrollInfo));
    result := BOOL(true);
  end
  else
    result := BOOL(false);
end;

procedure TCustomElTree.HorzScrollDrawPartTransfer(Sender : TObject;
                                                   Canvas : TCanvas;
                                                   R : TRect;
                                                   Part : TElScrollBarPart;
                                                   Enabled : Boolean;
                                                   Focused : Boolean;
                                                   Pressed : Boolean;
                                                   var DefaultDraw : Boolean);
{ Transfers FHScrollBar OnDrawPart event to the outside world. }
begin
  if (assigned(FOnHorzScrollDrawPart)) then
    FOnHorzScrollDrawPart(Self, Canvas , R , Part , Enabled , Focused , Pressed , DefaultDraw );  { Substitute Self for subcomponent's Sender. }
end;  { HorzScrollDrawPartTransfer }

procedure TCustomElTree.HorzScrollHintNeededTransfer(Sender : TObject; TrackPosition : Integer; var Hint : TLMDString);
{ Transfers FHScrollBar OnScrollHintNeeded event to the outside world. }
begin
  if (assigned(FOnHorzScrollHintNeeded)) then
    FOnHorzScrollHintNeeded(Self, TrackPosition , Hint );  { Substitute Self for subcomponent's Sender. }
end;  { HorzScrollHintNeededTransfer }

procedure TCustomElTree.VertScrollDrawPartTransfer(Sender : TObject; Canvas : TCanvas;
                                                   R : TRect;
                                                   Part : TElScrollBarPart;
                                                   Enabled : Boolean;
                                                   Focused : Boolean;
                                                   Pressed : Boolean;
                                                   var DefaultDraw : Boolean);
{ Transfers FVScrollBar OnDrawPart event to the outside world. }
begin
  if (assigned(FOnVertScrollDrawPart)) then
    FOnVertScrollDrawPart(Self, Canvas , R , Part , Enabled , Focused , Pressed , DefaultDraw );  { Substitute Self for subcomponent's Sender. }
end;  { VertScrollDrawPartTransfer }

procedure TCustomElTree.VertScrollHintNeededHandler(Sender : TObject; TrackPosition : Integer; var Hint : TLMDString);
var Item : TElTreeItem;
    FCol : integer;
begin
  VertScrollHintNeededTransfer(Self, TrackPosition, Hint);
  if Hint = '' then
  begin
    Item := Items.ItemAsVis[TrackPosition];
    if Item = nil then
      exit;

    if FSortSection = -1 then
    begin
      if Item.FStaticData <> nil then
        Hint := Item.Text
      else
        TriggerVirtualTextNeeded(Item, FSortSection, Hint);
    end
    else
    begin
      if Item.FStaticData <> nil then
      begin
        if FSortSection = FMainTreeCol then
          Hint := Item.Text
        else
        begin
          FCol := FSortSection;
          if FSortSection > FMainTreeCol then dec(FCol);
          try
            if FCol < Item.FStaticData.FColText.Count then
              Hint := Item.FStaticData.FColText[FCol];
          except
          end;
        end;
      end
      else
        TriggerVirtualTextNeeded(Item, FSortSection, Hint);
    end;
  end;
end;  { VertScrollHintNeededHandler }

procedure TCustomElTree.VertScrollHintNeededTransfer(Sender : TObject; TrackPosition : Integer; var Hint : TLMDString);
{ Transfers FHScrollBar OnScrollHintNeeded event to the outside world. }
begin
  if (assigned(FOnVertScrollHintNeeded)) then
    FOnVertScrollHintNeeded(Self, TrackPosition , Hint );  { Substitute Self for subcomponent's Sender. }
end;  { HorzScrollHintNeededTransfer }

procedure TCustomElTree.CreateWnd;  { protected }
var
  SaveDragType : TElDragType;
begin
  FScrollbarsInitialized := false;
  inherited;
  //FHScrollBar.ControlStyle := FHScrollBar.ControlStyle + [csNoDesignVisible];
  //FVScrollBar.ControlStyle := FVScrollBar.ControlStyle + [csNoDesignVisible];
  TElScrollBarHack(FHScrollBar).SetDesigning(false);
  TElScrollBarHack(FVScrollBar).SetDesigning(false);
  TElHeaderHack(FHeader).IsDesigning := false;
  FView.SetDesigning(csDesigning in ComponentState);
  AlignPieces;

  if ((ComponentState * [csLoading, csReading]) = []) and (FDragType <> dtDelphi) then
  begin
    SaveDragType := FDragType;
    DragType := dtDelphi;
    DragType := SaveDragType;
  end;
end;  { CreateWnd }

procedure TCustomElTree.AlignControls(AControl: TControl; var Rect: TRect);
begin
  if not (csDesigning in ComponentState) then
     inherited;
end;

function TCustomElTree.GetHeaderInvertSortArrows : Boolean;
{ Returns the value of data member FHeaderInvertSortArrows. }
begin
  result := FHeader.InvertSortArrows;
end;  { GetHeaderInvertSortArrows }

procedure TCustomElTree.SetHeaderInvertSortArrows(newValue : Boolean);
{ Sets data member FHeaderInvertSortArrows to newValue. }
begin
  FHeader.InvertSortArrows := newValue;
end;  { SetHeaderInvertSortArrows }

function TCustomElTree.GetDragImages: TDragImageList;

begin
  result := FView.GetDragImages;
end;

function TCustomElTree.GetLockedHeaderSection : TElHeaderSection;
{ Returns the value of data member FLockedHeaderSection. }
begin
  result := FHeader.LockedSection;
end;  { GetLockedHeaderSection }

procedure TCustomElTree.SetLockedHeaderSection(newValue : TElHeaderSection);
{ Sets data member FLockedHeaderSection to newValue. }
begin
  FHeader.LockedSection := newValue;
end;  { SetLockedHeaderSection }

procedure TCustomElTree.ActionChange(Sender : TObject; CheckDefaults : Boolean);
begin
  inherited;
end;

procedure TCustomElTree.SetAutoExpand(value: boolean);
begin
  if AutoExpand <> value then
  begin
    FAutoExpand := value;
    //if value then FMoveFocusOnCollapse := false;
  end;
end;

procedure TCustomElTree.SetMoveFocusOnCollapse(value: boolean);
begin
  if FMoveFocusOnCollapse <> value then
  begin
    FMoveFocusOnCollapse := value;
    //if value then AutoExpand := false;
  end;
end;

function TCustomElTree.GetDragCursor : TCursor;
begin
  result := FView.DragCursor;
end;

procedure TCustomElTree.SetDragCursor(Value : TCursor);
begin
  FView.DragCursor := Value;
end;

procedure TCustomElTree.SetTrackColor(value : TColor);
begin
  if FTrackColor <> Value then
  begin
    FTrackColor := Value;
    if Assigned(FView.FTrackItem) then
       FView.FTrackItem.RedrawItem(true);
  end;
end;

procedure TCustomElTree.SetTransButtons(newValue : boolean);
begin
  if newValue <> FTransButtons then
  begin
    FTransButtons := newValue;
    if FShowButtons then
    begin
      IsUpdating := true;
      FUpdated := true;
      FView.FRangeUpdate := true;
      IsUpdating := false;
    end;
  end;
end;

procedure TCustomElTree.SetHeaderColor(newValue : TColor);
{ Sets the FHeader subcomponent's Color property to newValue. }
begin
  FHeader.Color := newValue;
end;  { SetColor }

function TCustomElTree.GetHeaderColor : TColor;
{ Returns the Color property from the FHeader subcomponent. }
begin
  result := FHeader.Color;
end;  { GetColor }

procedure TCustomElTree.SetAdjustMultilineHeight(newValue : Boolean);
var i, j : integer;
begin
  if (FAdjustMultilineHeight <> newValue) then
  begin
    FAdjustMultilineHeight := newValue;
    j := FAllList.Count - 1;
    for i := 0 to j do
    begin
      if TElTreeItem(FAllList[i]).Multiline then
      begin
        if newValue then
           inc(TotalVarHeightCount)
        else
           dec(TotalVarHeightCount);
      end;
    end;
    IsUpdating := true;
    with FView do
    begin
      FVisUpdated := true;
      FClearVis := true;
      FClearAll := true;
      FRangeUpdate := true;
    end;
    FUpdated := true;
    IsUpdating := false;
  end;  { if }
end;  { SetAdjustMultilineHeight }

procedure TCustomElTree.TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image : TBitmap);
begin
  if (assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src, Image );
end;

procedure TCustomElTree.TriggerImageNeededExEvent(Sender: TObject;
  Src: TLMDString; Image: TPicture);
begin
  if (Assigned(FOnImageNeededEx)) then
    FOnImageNeededEx(Self, Src, Image);
end;

{$WARNINGS OFF}
procedure TCustomElTree.WMVScroll(var Msg : TWMVScroll);  { private }
var b : boolean;
    sc: TElscrollCode;
    sp: integer;
    ScrollInfo : TScrollInfo;
begin
  b := false;
  case Msg.ScrollCode of
    SB_TOP:       sc := escTop;
    SB_BOTTOM:    sc := escBottom;
    SB_ENDSCROLL: sc := escEndScroll;
    SB_LINEDOWN:  sc := escLineDown;
    SB_LINEUP:    sc := escLineUp;
    SB_PAGEDOWN:  sc := escPageDown;
    SB_PAGEUP:    sc := escPageUp;
    SB_THUMBPOSITION: sc := escPosition;
    SB_THUMBTRACK: sc := escTrack;
  end;
  ScrollInfo.cbSize := Sizeof(ScrollInfo);
  ScrollInfo.fMask := SIF_POS or SIF_TRACKPOS or SIF_RANGE;
  if FUseCustomBars then
    GetScrollInfo(FVScrollBar.Handle, SB_CTL, ScrollInfo)
  else
    Windows.GetScrollInfo(Handle, SB_VERT, ScrollInfo);
  if (Msg.ScrollCode <> SB_THUMBTRACK) and (Msg.ScrollCode <> SB_THUMBPOSITION) then
    sp := ScrollInfo.nPos
  else
    sp := ScrollInfo.nTrackPos;
  FView.OnVScroll(FVScrollBar, SC, sp, b);
end;  { WMVScroll }

procedure TCustomElTree.WMHScroll(var Msg : TWMHScroll);  { private }
var b : boolean;
    sc: TElscrollCode;
    sp: integer;
begin
  b := false;
  case Msg.ScrollCode of
    SB_TOP:       sc := escTop;
    SB_BOTTOM:    sc := escBottom;
    SB_ENDSCROLL: sc := escEndScroll;
    SB_LINEDOWN:  sc := escLineDown;
    SB_LINEUP:    sc := escLineUp;
    SB_PAGEDOWN:  sc := escPageDown;
    SB_PAGEUP:    sc := escPageUp;
    SB_THUMBPOSITION: sc := escPosition;
    SB_THUMBTRACK: sc := escTrack;
  end;
  sp := Msg.Pos;
  FView.OnHScroll(FHScrollBar, SC, sp, b);
end;  { WMHScroll }
{$WARNINGS ON}

procedure TCustomElTree.TriggerSortBegin;
begin
  if Assigned(FOnSortBegin) then FOnSortBegin(Self);
end;

procedure TCustomElTree.TriggerSortEnd;
begin
  if Assigned(FOnSortEnd) then FOnSortEnd(Self);
end;

procedure TCustomElTree.TriggerItemPreDrawEvent(Item : TElTreeItem);
begin
  if assigned(FOnItemPredraw) then FOnItemPredraw(Self, Item);
end;

procedure TCustomElTree.TriggerItemPostDrawEvent(Canvas : TCanvas; Item : TElTreeItem; ItemRect : TRect; var DrawFocusRect : boolean);
begin
  if (assigned(FOnItemPostDraw)) then
    FOnItemPostDraw(Self, Canvas , Item, ItemRect , DrawFocusRect );
end;  { TriggerItemPostDrawEvent }

procedure TCustomElTree.SetHeaderImageForm(newValue : TElImageForm);
begin
  FHeader.ImageForm := newValue;
end;  { SetImageForm }

function TCustomElTree.GetHeaderImageForm : TElImageForm;
begin
  result := FHeader.ImageForm;
end;  { GetImageForm }

function TCustomElTree.GetHint: TLMDString;
begin
  result := FHint;
end;

procedure TCustomElTree.SetHint(newValue: TLMDString);
begin
  FHint := newValue;
  FRealHint := newValue;
end;

procedure TCustomElTree.StartDelayedFocus(FocusItemToReport : TElTreeItem);
begin
  FDelayTimer.Enabled := false;
  FDelayedItem := FocusItemToReport;
  FDelayTimer.Interval := FChangeDelay;
  FDelayTimer.Enabled := true;
end;

procedure TCustomElTree.StopDelayedFocus;
begin
  FDelayTimer.Enabled := false;
  FDelayedItem := nil;
end;

procedure TCustomElTree.OnDelayTimer(Sender : TObject);
begin
  FDelayTimer.Enabled := false;
  if FDelayedItem = FView.FFocused then
    DoItemFocused;
end;

procedure TCustomElTree.DoAfterSelectionChange;
begin
  if Assigned(FOnAfterSelectionChange) then
    FOnAfterSelectionChange(Self);
end;

procedure TCustomElTree.SetDragRectAcceptColor(const Value: TColor);
begin
  if FDragRectAcceptColor <> Value then
  begin
    FDragRectAcceptColor := Value;
    if (FDragTrgDrawMode in [ColorFrame, ColorRect, dtdUpColorLine, dtdDownColorLine]) and (FView.FDropTrg <> nil) then
    begin
      if FDragObject <> nil then
        FDragObject.HideDragImage;
      FView.FDropTrg.RedrawItem(false);
      Update;
      if FDragObject <> nil then
        FDragObject.ShowDragImage;
    end;
  end;
end;

procedure TCustomElTree.SetDragRectDenyColor(Value: TColor);
begin
  if FDragRectDenyColor <> Value then
  begin
    FDragRectDenyColor := Value;
    if (FDragTrgDrawMode in [ColorFrame, ColorRect, dtdUpColorLine, dtdDownColorLine]) and (FView.FDropTrg <> nil) then
    begin
      if FDragObject <> nil then
        FDragObject.HideDragImage;
      FView.FDropTrg.RedrawItem(false);
      Update;
      if FDragObject <> nil then
        FDragObject.ShowDragImage;
    end;
  end;
end;

procedure TCustomElTree.SetDragTrgDrawMode(Value: TDragTargetDraw);
begin
  if FDragTrgDrawMode <> Value then
  begin
    DoSetDragTrgDrawMode(Value, True);
  end;
end;

function TCustomElTree.GetVisibleRowCount: Integer;
begin
  Result := FView.GetVisCount2;
end;

function TCustomElTree.IndexInView(Item : TElTreeItem): Integer;
begin
  Result := FView.FVisible.IndexOf(Item);
end;

function TCustomElTree.GetCanDrag: TElCanDragEvent;
begin
  Result := FView.FOnCanDrag;
end;

procedure TCustomElTree.SetCanDrag(const Value: TElCanDragEvent);
begin
  FView.FOnCanDrag := Value;
end;

function TCustomElTree.GetTreeViewAncestor: TElTreeViewAncestor;
begin
  Result := FView;
end;

function TCustomElTree.GetAlignmentOnSection(SectionIndex: integer): string;
begin
  Result := 'none';
end;

function TCustomElTree.GetDropTarget: TElTreeItem;
begin
  Result := FView.FDropTrg;
end;

procedure TCustomElTree.DoSetDragTrgDrawMode(Value: TDragTargetDraw; RedrawItem
    : boolean);
begin
  if FDragTrgDrawMode <> Value then
  begin
    FDragTrgDrawMode := Value;
    if (FView.FDropTrg <> nil) and (RedrawItem) then
    begin
      if FDragObject <> nil then
        FDragObject.HideDragImage;
      FView.FDropTrg.RedrawItem(false);
      Update;
      if FDragObject <> nil then
        FDragObject.ShowDragImage;
    end;
  end;
end;

procedure TCustomElTree.AllSelectedEx(SelectedItems : TLMDObjectList; Order : boolean);
var i : integer;
    Item : TElTreeItem;
begin
  if FSelectedList = nil then
    exit;

  if not Order then
  begin
    SelectedItems.Assign(FSelectedList);
  end
  else
  begin
    SelectedItems.Capacity := FSelectedList.Capacity;
    for i := 0 to FAllList.Count - 1 do
    begin
      Item := TElTreeItem(FAllList.FastGet(i));
      if Item.Selected then
        SelectedItems.Add(Item);
    end;
  end;
end;

function TCustomElTree.GetFireFocusEvents: boolean;
begin
  Result := (FFireFocusEvents = 0) and not (csDestroying in ComponentState);
end;

procedure TCustomElTree.SetFireFocusEvents(Value: boolean);
begin
  if Value then
    dec(FFireFocusEvents)
  else
    inc(FFireFocusEvents);
end;

procedure TCustomElTree.SetScrollbarOpposite(Value: Boolean);
begin
  if FScrollbarOpposite <> Value then
  begin
    FScrollbarOpposite := Value;
    if FUseCustomBars then
    AlignPieces;
  end;
end;

procedure TCustomElTree.SetLineHintTimeout(Value: Integer);
begin
  if FLineHintTimeout <> Value then
  begin
    FLineHintTimeout := Value;
  end;
end;

procedure TCustomElTree.SetVerticalLinesLong(Value: Boolean);
begin
  if FVerticalLinesLong <> Value then
  begin
    FVerticalLinesLong := Value;
    if FVerticalLines then
      Invalidate;
  end;
end;

procedure TCustomElTree.DoEndDrag(Target: TObject; X, Y: Integer);
begin
  inherited;
  FView.DoEndDrag(Target, X, Y);
end;

function TCustomElTree.GetDefaultSectionWidth: Integer;
begin
  Result := FHeader.DefaultWidth;
end;

procedure TCustomElTree.SetDefaultSectionWidth(Value: Integer);
begin
  FHeader.DefaultWidth := Value;
end;

procedure TCustomElTree.UpdateDiffItems;
var AnItem : TElTreeItem;
    i, j : integer;
begin
  if (FView.FTrackItem <> nil) and FView.FTrackItem.Hidden then
   FView.FTrackItem := nil;
  if (FView.FDropTrg <> nil) and FView.FDropTrg.Hidden then
    FView.FDropTrg := nil;

  (*
  while true do
  begin
    AnItem := FView.FSelected;
    if (AnItem <> nil) and AnItem.Hidden then
    begin
      if AnItem.FParent = FItems.FRoot then
      begin
        i := AnItem.AbsoluteIndex;
        j := i;
        while (AnItem <> nil) and AnItem.Hidden do
        begin
          if i > 0 then
            AnItem := Items[i]
          else
            AnItem := nil;
          Dec(i);
        end;
        if AnItem <> nil then
          SetSelected(AnItem)
        else
        begin
          i := j;
          while (AnItem <> nil) and AnItem.Hidden do
          begin
            if i > 0 then
              AnItem := Items[i]
            else
              AnItem := nil;
            Dec(i);
          end;
          if AnItem <> nil then
            SetSelected(AnItem)
        end;
      end
      else
        if (AnItem <> nil) and (AnItem.FParent <> FItems.FRoot) then
          SetSelected(AnItem.FParent);
      if AnItem <> nil then
        AnItem.Selected := false;
    end
    else
      break;
  end;
  *)

  while true do
  begin
    AnItem := FView.FSelected;
    if (AnItem <> nil) and AnItem.Hidden then
    begin
      if AnItem.FParent = FItems.FRoot then
      begin
        i := AnItem.AbsoluteIndex;
        // j := i;
        while (AnItem <> nil) and AnItem.Hidden do
        begin
          if i >= 0 then  // RAH changed from i > 0
            AnItem := Items[i]
          else
            AnItem := nil;
          Dec(i);
        end;
        if AnItem <> nil then
        begin
          SetSelected(AnItem);
          break;
        end
        else
        begin
          AnItem := FView.FSelected;  // RAH need to restore AnItem
          i := AnItem.AbsoluteIndex; // RAH should be the same as j
          while (AnItem <> nil) and AnItem.Hidden do
          begin
            if i < Integer(Items.Count) then // RAH make sure we stay in bounds
              AnItem := Items[i]
            else
              AnItem := nil;
            inc(i);  // RAH work forward
          end;
          if AnItem <> nil then
             SetSelected(AnItem);
          break;
       end;
     end
     else
       if (AnItem <> nil) and (AnItem.FParent <> FItems.FRoot) then
          SetSelected(AnItem.FParent);
     if AnItem <> nil then
       AnItem.Selected := false;
   end
   else
     break;
  end;

  // Move focus, if needed
  while true do
  begin
    AnItem := FView.FFocused;
    if (AnItem <> nil) and AnItem.Hidden then
    begin
      if AnItem.FParent = FItems.FRoot then
      begin
        i := AnItem.AbsoluteIndex;
        j := i;
        while (AnItem <> nil) and AnItem.Hidden do
        begin
          if i > 0 then
            AnItem := Items[i]
          else
            AnItem := nil;
          Dec(i);
        end;
        if AnItem = nil then
        begin
          i := j;
          while (AnItem <> nil) and AnItem.Hidden do
          begin
            if i > 0 then
              AnItem := Items[i]
            else
              AnItem := nil;
            Dec(i);
          end;
        end;
        DoSetFocused(AnItem, true);
        break;
      end
      else
        if (AnItem <> nil) and (AnItem.FParent <> FItems.FRoot) then
          DoSetFocused(AnItem.FParent, true);
    end
    else
      break;
  end;
end;

procedure TCustomElTree.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
    end;
end;

procedure TCustomElTree.ClearSortList(ReSort : boolean);
begin
  if FSortSections <> nil then
  begin
    FSortSections.Clear;
    if Resort then
    begin
      if FUpdateCount > 0 then
        FSortRequired := true
      else
        Sort(true);
    end;
  end;
end;

procedure TCustomElTree.AddSortSection(Index : Integer; ReSort : boolean);
var ASection : TElHeaderSection;
begin
  if FSortSections = nil then
    FSortSections := TLMDObjectList.Create;
  if FHeader.Sections.Count > Index then
  begin
    ASection := FHeader.Sections[Index];
    FSortSections.Remove(ASection);
    FSortSections.Add(ASection);
    if Resort then
    begin
      if FUpdateCount > 0 then
        FSortRequired := true
      else
        Sort(true);
    end;
  end;
end;

procedure TCustomElTree.RemoveSortSection(Index : Integer; ReSort : boolean);
var i : integer;
begin
  if FSortSections <> nil then
  begin
    if FHeader.Sections.Count > Index then
    begin
      i := FSortSections.IndexOf(FHeader.Sections[Index]);
      if i >= 0 then
      begin
        FSortSections.Delete(i);
        if Resort then
        begin
          if FUpdateCount > 0 then
            FSortRequired := true
          else
            Sort(true);
        end;
      end;
    end;
  end;
end;

procedure TCustomElTree.TriggerVirtualTextNeeded(Item : TElTreeItem;
    SectionIndex : Integer; var Text : TLMDString);
begin
  Text := '';
  if Assigned(FOnVirtualTextNeeded) then
    OnVirtualTextNeeded(Self, Item, SectionIndex, Text);
end;

procedure TCustomElTree.SetVirtualityLevel(Value: TVirtualityLevel);
var i       : integer;
    OldValue: TVirtualityLevel;
begin
  if FVirtualityLevel <> Value then
  begin
    if (FAllList.Count > 0) and (Value <> vlNone) and (csDesigning in ComponentState) and (ComponentState * [csLoading, csReading] = []) then
    if MessageBox(0, 'Changing Virtuality Level will clear all data of the items. Continue?', 'Warning', MB_ICONWARNING or MB_OKCANCEL) = IDCANCEL then exit;
    OldValue := FVirtualityLevel;
    FVirtualityLevel := Value;
    IsUpdating := true;
    try
      if Value <> vlNone then
        FView.VirtStyle := TElCellStyle.Create(nil)
      else
      begin
        FView.VirtStyle.Free;
        FView.VirtStyle := nil;
      end;

      if (Value <> vlAllProps) or (csDesigning in ComponentState) then
        DataCacheDeallocate;

      for i := 0 to FAllList.Count - 1 do
      begin
        if (Value in [vlTextAndStyles, vlAllProps]) and (OldValue = vlNone) then
          TElTreeItem(FAllList[i]).DisposeStaticData
        else
          TElTreeItem(FAllList[i]).NewStaticData;

        if (Value = vlAllProps) and (not (csDesigning in ComponentState)) then
        begin
          TElTreeItem(FAllList[i]).DisposeStaticDataEx
        end
        else
        begin
          TElTreeItem(FAllList[i]).NewStaticDataEx;
          TriggerVirtualPropsNeeded(TElTreeItem(FAllList[i]), AllVirtPropTypes, TElTreeItem(FAllList[i]).FStaticDataEx);
        end;
      end;
      if (Value = vlAllProps) and (not (csDesigning in ComponentState)) then
        DataCacheAllocate;

      FView.FClearVis  := true;
      FView.FVisUpdated:= true;
    finally
      IsUpdating := false;
    end;
  end;
end;

procedure TCustomElTree.TriggerVirtualHintNeeded(Item : TElTreeItem; var Hint :
    TLMDString);
begin
  Hint := '';
  if Assigned(FOnVirtualHintNeeded) then
    OnVirtualHintNeeded(Self, Item, Hint);
end;

procedure TCustomElTree.TriggerVirtualValueNeeded(Item : TElTreeItem;
    SectionIndex : Integer; VarType : integer; var Value : Variant);
begin
  Value := Unassigned;
  if Assigned(FOnVirtualValueNeeded) then
    FOnVirtualValueNeeded(Self, Item, SectionIndex, VarType, Value);
end;

procedure TCustomElTree.TriggerVirtualStyleNeeded(Item : TElTreeItem;
    SectionIndex : Integer; Style : TElCellStyle);
begin
  if Assigned(FOnVirtualStyleNeeded) then
    OnVirtualStyleNeeded(Self, Item, SectionIndex, Style);
end;

procedure TCustomElTree.TriggerVirtualPropsNeeded(Item : TElTreeItem;
        PropTypes : TElVirtPropTypes; Value : TElTreeItemStaticDataEx);
begin
  if Assigned(FOnVirtualPropsNeeded) then
    FOnVirtualPropsNeeded(Self, Item, PropTypes, Value);
end;

procedure TCustomElTree.SetStripedOddColor(Value: TColor);
begin
  if FStripedOddColor <> Value then
  begin
    FStripedOddColor := Value;
    if FStripedItems then
      Invalidate;
  end;
end;

procedure TCustomElTree.SetStripedEvenColor(Value: TColor);
begin
  if FStripedEvenColor <> Value then
  begin
    FStripedEvenColor := Value;
    if FStripedItems then
      Invalidate;
  end;
end;

procedure TCustomElTree.SetStripedItems(Value: Boolean);
begin
  if FStripedItems <> Value then
  begin
    FStripedItems := Value;
    Invalidate;
  end;
end;

procedure TCustomElTree.TriggerInplaceEditorNeeded(Item : TElTreeItem;
    SectionIndex : Integer; SupposedFieldType : TElFieldType; var Editor :
    TElTreeInplaceEditor);
begin
   Editor := FEditorManager.GetSuitableEditor(SupposedFieldType);
   if Assigned(FOnInplaceEditorNeeded) then
     FOnInplaceEditorNeeded(Self, Item, SectionIndex, SupposedFieldType, Editor);
end;

procedure TCustomElTree.VertScrollHitTestTransfer(Sender : TObject; X, Y :
    integer; var Part : TElScrollBarPart; var DefaultTest : boolean);
begin
  if assigned(FOnVertScrollHitTest) then
    FOnVertScrollHitTest(Self, X, Y, Part, DefaultTest);
end;

procedure TCustomElTree.HorzScrollHitTestTransfer(Sender : TObject; X, Y :
    integer; var Part : TElScrollBarPart; var DefaultTest : boolean);
begin
  if assigned(FOnHorzScrollHitTest) then
    FOnHorzScrollHitTest(Self, X, Y, Part, DefaultTest);
end;

procedure TCustomElTree.SetVertDivLinesColor(Value: TColor);
begin
  if (FVertDivLinesColor <> Value) then
  begin
    IsUpdating := true;
    FVertDivLinesColor := Value;
    if FVerticalLines then
    begin
      FView.FClearAll := true;
      FUpdated := true;
    end;
    IsUpdating := false;
  end; {if}
end;

procedure TCustomElTree.SetCheckBoxSize(Value: Integer);
begin
  if FCheckBoxSize <> Value then
  begin
    IsUpdating := true;
    FCheckBoxSize := Value;
    if FShowCheckboxes then
    with FView do
    begin
      if not FShowHeader then
        FView.FHRange := -1;
      FClearAll := true;
    end;
    FUpdated := true;
    IsUpdating := false;
  end;
end;

function TCustomElTree.GetTrackItem: TElTreeItem;
begin
  Result := FView.FTrackItem;
end;

function TCustomElTree.GetDragging: Boolean;
begin
  Result := FView.FInDragging;
end;

procedure TCustomElTree.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TCustomElTree.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TCustomElTree.IFMCanPaintBkgnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

procedure TCustomElTree.SetShowLeafButton(Value: Boolean);
begin
  if FShowLeafButton <> Value then
  begin
    FShowLeafButton := Value;
    IsUpdating := true;
    with FView do
    begin
      if not FShowHeader then
        FHRange := -1;
      FUpdated := true;
      FRangeUpdate := true;
    end;
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.SetLeafPicture(Value: TBitmap);
begin
  LeafPicture.Assign(Value);
end;

procedure TCustomElTree.MouseWheelTransfer(Sender : TObject; Shift: TShiftState;
    WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := DoMouseWheel(Shift, WheelDelta, MousePos);
end;

procedure TCustomElTree.MouseWheelDownTransfer(Sender : TObject; Shift:
    TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := DoMouseWheelDown(Shift, MousePos);
end;

procedure TCustomElTree.MouseWheelUpTransfer(Sender : TObject; Shift:
    TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  Handled := DoMouseWheelUp(Shift, MousePos);
end;

procedure TCustomElTree.FitMostChildren(Item : TElTreeItem);
begin
  FView.FitMostChildren(Item);
end;
{
function TCustomElTree.GetThemedClassName: TLMDThemedItem;
begin
  Result := tiTreeView;
end;
}
function TCustomElTree.GetThemedElement: TThemedElement;
begin
  Result := teTreeView;
end;

procedure TCustomElTree.SetUseXPThemes(const Value: Boolean);
begin
  inherited;
  Self.FHScrollBar.UseXPThemes := Value;
  Self.FVScrollBar.UseXPThemes := Value;
  TElHeaderHack(FHeader).UseXPThemes := Value;
  end;

procedure TCustomElTree.SetThemeGlobalMode(const Value: Boolean);
begin
  inherited;
  if Assigned(Self.FHScrollBar) then
    Self.FHScrollBar.ThemeGlobalMode := Value;
  if Assigned(Self.FVScrollBar) then
    Self.FVScrollBar.ThemeGlobalMode := Value;
  FHeader.ThemeGlobalMode := Value;
end;

procedure TCustomElTree.SetThemeMode(const Value: TLMDThemeMode);
begin
  inherited;
  if Assigned(Self.FHScrollBar) then
    Self.FHScrollBar.ThemeMode := Value;
  if Assigned(Self.FVScrollBar) then
    Self.FVScrollBar.ThemeMode := Value;
  FHeader.ThemeMode := Value;
end;

function TCustomElTree.GetCheckBoxSize: Integer;

var //Theme : HTheme;
  PX    : TSize;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
begin
  LUseThemeMode := UseThemeMode;
  if (LUseThemeMode <> ttmNone) and (not (csDesigning in ComponentState)) then
  begin
    // Theme := LMDThemeService.Theme[tiButton];
//    if Theme <> 0 then
//    begin
      LDetails := LMDThemeServices.GetDetails(teButton, Ord(tbCheckBoxUncheckedNormal));
      if not LMDThemeServices.GetThemePartSizeNew(LUseThemeMode, Canvas.Handle, LDetails, PX) then
      begin
        Px.cx := 16;
        Px.cy := 16;
      end;

      Result := max(PX.cx, PX.cy);
//    end
//    else
//      Result := FCheckBoxSize;
  end
  else
  Result := FCheckBoxSize;
end;

function TCustomElTree.GetHeaderPopupMenu: TPopupMenu;
begin
  Result := FHeader.PopupMenu;
end;

procedure TCustomElTree.SetHeaderPopupMenu(Value: TPopupMenu);
begin
  FHeader.PopupMenu := Value;
end;

procedure TCustomElTree.ReRenderAllHTMLItems;
var i : integer;
    Item : TElTreeItem;
begin
  for i := 0 to FAllList.Count - 1 do
  begin
    Item := TElTreeItem(FAllList[i]);
    if Item.IsHTML then
    begin
      Item.ReRenderMainText;
      Item.ReRenderAllTexts;
    end;
  end;
end;

procedure TCustomElTree.SetHeaderFont(Value: TFont);
begin
  FHeaderFont.Assign(Value);
end;

procedure TCustomElTree.SetHeaderUseTreeFont(Value: Boolean);
begin
  if FHeaderUseTreeFont <> Value then
  begin
    FHeaderUseTreeFont := Value;
    if FHeaderUseTreeFont then
      FHeader.Font := Font
    else
      FHeader.Font := FHeaderFont;
  end;
end;

procedure TCustomElTree.HeaderFontChanged(Sender: TObject);
begin
  if not HeaderUseTreeFont then
    FHeader.Font := FHeaderFont;
end;

function TCustomElTree.IsStripedColorStored: Boolean;
begin
  Result := StripedItems;
end;

function TCustomElTree.IsOwnerDrawMaskStored: Boolean;
begin
  Result := (FODMask <> DefaultTreeOwnerDrawMask);
end;

procedure TCustomElTree.ELThemeChanged(var Message: TMessage);
begin
  inherited;
  AlignPieces;
end;

procedure TCustomElTree.ELSettingChange(var Message: TMessage);
begin
  if UseCustomScrollBars then
  begin
    SendMessage(FHScrollBar.Handle, Message.Msg, Message.wParam, Message.lParam);
    SendMessage(FVScrollBar.Handle, Message.Msg, Message.wParam, Message.lParam);
    AlignPieces;
  end;
end;

procedure TCustomElTree.SetSortUseCase(Value: Boolean);
begin
  if FSortUseCase <> Value then
  begin
    FSortUseCase := Value;
  end;
end;

procedure TCustomElTree.DoEnter;
begin
  inherited;
  FView.FHasFocus := true;
end;

procedure TCustomElTree.DoExit;
begin
  FView.FHasFocus := false;
  inherited;
end;

procedure TCustomElTree.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TCustomElTree.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TCustomElTree.SetDblClickMode(Value: TElDblClickMode);
begin
  if FDblClickMode <> Value then
  begin
    FDblClickMode := Value;
  end;
end;

procedure TCustomElTree.OnBeforeHook(Sender : TObject; var Message : TMessage;
    var Handled : boolean);
begin
  Handled := false;
  if Message.Msg = WM_ENTERSIZEMOVE then
    InSizeMove := true
  else
  if Message.Msg = WM_EXITSIZEMOVE then
    InSizeMove := false;
end;

procedure TCustomElTree.SetParent(AParent: TWinControl);
begin
  inherited;
  if (AParent <> nil) and (FHook <> nil) then
  begin
    FHook.Control := GetParentForm(AParent);
    FHook.Active := DoubleBuffered and (not (csDesigning in componentState));
  end
  else
    if FHook <> nil then
      FHook.Control := nil;
  InSizeMove := false;
end;

function TCustomElTree.GetPlusPicture: TBitmap;
begin
  if FPlusPicture = nil then
  begin
    FPlusPicture := TBitmap.Create;
    FPlusPicture.OnChange := OnSignChange;
  end;
  Result := FPlusPicture;
end;

function TCustomElTree.GetLeafPicture: TBitmap;
begin
  if FLeafPicture = nil then
  begin
    FLeafPicture := TBitmap.Create;
    FLeafPicture.OnChange := OnSignChange;
  end;
  Result := FLeafPicture;
end;

function TCustomElTree.GetMinusPicture: TBitmap;
begin
  if FMinusPicture = nil then
  begin
    FMinusPicture := TBitmap.Create;
    FMinusPicture.OnChange := OnSignChange;
  end;
  Result := FMinusPicture;
end;

function TCustomElTree.GetCheckBoxGlyph: TBitmap;
begin
  if FCheckBoxGlyph = nil then
  begin
    FCheckBoxGlyph := TBitmap.Create;
    FCheckBoxGlyph.OnChange := OnCheckSignChange;
  end;
  Result := FCheckBoxGlyph;
end;

function TCustomElTree.GetRadioButtonGlyph: TBitmap;
begin
  if FRadioButtonGlyph = nil then
  begin
    FRadioButtonGlyph := TBitmap.Create;
    FRadioButtonGlyph.OnChange := OnCheckSignChange;
  end;
  Result := FRadioButtonGlyph;
end;

procedure TCustomElTree.OnCheckSignChange(Sender: TObject);
var
  i: integer;
begin
  if not FCustomCheckboxes then exit;
  if FView.FPainting then exit;
  IsUpdating := true;
  if AutoLineHeight then
  begin
    i := DefineLineHeight;
    if i <> FLineHeight then
    begin
      with FView do
      begin
        FClearVis := true;
        if i < FLineHeight then FClearAll := true;
      end;
      FLineHeight := i;
    end;
    FView.FVisUpdated := true;
  end;
  with FView do
  begin
    FRangeUpdate := true;
    FUpdated := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.WMUpdateSBFrame(var Message: TMessage);
begin
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
end;

procedure TCustomElTree.SetDoubleBuffered(Value: Boolean);
begin
  if FDoubleBuffered <> Value then
  begin
    FDoubleBuffered := Value;
    if FHook <> nil then
      FHook.Active := DoubleBuffered and (not (csDesigning in componentState));
    end;
end;

procedure TCustomElTree.WMSysColorChange(var Msg: TWMSysColorChange);
begin
  inherited;
  PostMessage(FVScrollBar.Handle, Msg.Msg,  TMessage(Msg).WParam,  TMessage(Msg).LParam);
  PostMessage(FHScrollBar.Handle, Msg.Msg,  TMessage(Msg).WParam,  TMessage(Msg).LParam);
  PostMessage(FHeader.Handle, Msg.Msg,  TMessage(Msg).WParam,  TMessage(Msg).LParam);
end; { WMSysColorChange }

procedure TCustomElTree.SetHighlightAlphaLevel(Value: Integer);
begin
  if (FHighlightAlphaLevel <> Value) and (Value >= 0) and (Value <= 255) then
  begin
    FHighlightAlphaLevel := Value;
    Invalidate;
  end;
end;

procedure TCustomElTree.ReadRightAlignedTree(Reader : TReader);
begin
  RightAlignedView := Reader.ReadBoolean;
end;

procedure TCustomElTree.DefineProperties(Filer : TFiler);
begin
  inherited;
  with GetElReader do
  begin
    Filer.DefineProperty('Action', FakeValue, nil, false);
    Filer.DefineProperty('NoBlendSelected', FakeBoolean, nil, false);
    Filer.DefineProperty('ScrollBackground', FakeBoolean, nil, false);
    {$IFNDEF HOTTRACK_CURSOR}
    Filer.DefineProperty('TrackingCursor', FakeValue, nil, false);
    {$ENDIF}
  end;
  Filer.DefineProperty('RightAlignedTree', ReadRightAlignedTree, nil, false);
  Filer.DefineProperty('ExpandOnDblClick', ReadExpandOnDblClick, nil, false);
  Filer.DefineProperty('ScrollTracking', ReadScrollTracking, nil, false);
end;

procedure TCustomElTree.DataCacheAllocate;
var i : integer;
begin
  FDataCache := TLMDObjectList.Create;
  for i := 0 to DataCacheSize -1 do
    FDataCache.Add(CreateDataCacheItem);
end;

procedure TCustomElTree.DataCacheDeallocate;
begin
  if FDataCache <> nil then
  begin
    DataCacheClear;
    FDataCache.Free;
    FDataCache := nil;
  end;
end;

procedure TCustomElTree.DataCacheClear;
var Item : TElTreeItemStaticDataEx;
begin
  if (FDataCache <> nil) then
  begin
    while FDataCache.Count > 0 do
    begin
      Item := TElTreeItemStaticDataEx(FDataCache.Last);
      if Item.ItemRef <> nil then
        Item.ItemRef.FStaticDataEx := nil;
      Item.Free;
      FDataCache.Count := FDataCache.Count - 1;
    end;
  end;
end;

procedure TCustomElTree.SetDataCacheSize(Value: Integer);
var i, j : integer;
    Item : TElTreeItemStaticDataEx;
begin
  if FDataCacheSize <> Value then
  begin
    FDataCacheSize := Value;
    if (FDataCache <> nil) then
    begin
      if FDataCache.Count > Value then
      begin
        i := Max(Value, FView.FVisible.Count);
        for j := 0 to FDataCache.Count - i - 1 do
        begin
          Item := TElTreeItemStaticDataEx(FDataCache[j]);
          if Item.ItemRef <> nil then
            Item.ItemRef.FStaticDataEx := nil;
          Item.Free;
          FDataCache[j] := nil;
        end;
        FDataCache.MoveRange(FDataCache.Count - i, FDataCache.Count - 1, 0);
        FDataCache.Count := i;
      end
      else
      begin
        i := Value - FDataCache.Count;
        while i > 0 do
        begin
          FDataCache.Add(CreateDataCacheItem);
          dec(i);
        end;
      end;
    end;
  end;
end;

function TCustomElTree.CreateDataCacheItem: TElTreeItemStaticDataEx;
begin
  Result := TElTreeItemStaticDataEx.Create;
  with Result do
  begin
    FBoolData1 := ibfParentColors or ibfParentStyle or ibfCheckBoxEnabled or ibfShowCheckbox or
      ibfEnabled or ibfUseBkColor or ibfDrawHLine {or ibfAllowSelection }or ibfAllowEdit;
    FImageIndex := -1;
    FStImageIndex := -1;
    FImageIndex2 := -1;
    FStImageIndex2 := -1;
    FOverlayIndex := -1;
    FOverlayIndex2 := -1;
    FCheckBoxState := cbUnchecked;
    FCheckBoxType := ectCheckBox;
    FBorderSpaceColor := clWindow;
  end;
end;

procedure TCustomElTree.CacheItem(Item : TElTreeItem; MinInCache : integer);
begin
  if Item.FStaticDataEx <> nil then
  begin
    FDataCache.Move(FDataCache.IndexOf(Item.FStaticDataEx), FDataCache.Count - 1);
  end
  else
  begin
    if FDataCache.Count > MinInCache then
    begin
      Item.FStaticDataEx := TElTreeItemStaticDataEx(FDataCache[0]);
      if Item.FStaticDataEx.ItemRef <> nil then
        Item.FStaticDataEx.ItemRef.FStaticDataEx := nil;
      Item.FStaticDataEx.ItemRef := Item;
      TriggerVirtualPropsNeeded(Item, AllVirtPropTypes, Item.FStaticDataEx);
      FDataCache.Move(0, FDataCache.Count - 1);
    end
    else
    begin
      Item.FStaticDataEx := CreateDataCacheItem;
      Item.FStaticDataEx.ItemRef := Item;
      TriggerVirtualPropsNeeded(Item, AllVirtPropTypes, Item.FStaticDataEx);
      FDataCache.Add(Item.FStaticDataEx);
    end;
  end;
end;

function TCustomElTree.GetIncSearchColumnText(Item : TElTreeItem): TLMDString;
var cc    : integer;

    FData : TLMDHTMLData;

begin
  if Item = nil then
  begin
    result := '';
    exit;
  end;
  if ShowColumns and (SelectColumn <> -1) and (SelectColumn <> MainTreeColumn) then
  begin
    cc := SelectColumn;
    if SelectColumn > MainTreeColumn then
      dec(cc);
    if Item.ColumnText.Count <= cc then
      result := ''
    else
    begin
      Result := Item.ColumnText[cc];
    end;
  end
  else
  if ShowColumns and (IncrementalSearchColumn = iscSortColumn) then
  begin
    cc := SortSection;
    if SortSection > MainTreeColumn then
      dec(cc);
    if Item.ColumnText.Count <= cc then
      result := ''
    else
    begin
      Result := Item.ColumnText[cc];
    end;
  end
  else
  begin
    cc := -1;
    Result := Item.Text;
  end;
  if Item.IsHTML then
  begin
    if Copy(Result, 1, 6) = '<html>' then
    begin
      with FView do
      begin
        if VirtualityLevel = vlNone then
        begin
          if cc <> -1 then
            FData := TLMDHTMLData(Item.FHTMLDataArray[cc])
          else
            FData := Item.FHTMLData;
        end
        else
        begin
          FRender.PrepareText(Result, 0, false);
          FData := FRender.Data;
        end;
        if FData <> nil then
        begin
          with FRender do
          begin
            SetData(FData);
            result := FRender.AsText;
            if VirtualityLevel = vlNone then
              SetData(nil);
          end;
        end;
      end;
    end;
  end;
  end;

procedure TCustomElTree.ResetAllItemsHeight;
var i : integer;
begin
  IsUpdating := true;
  for i := 0 to Items.Count - 1 do
  begin
    if (Items[i].FBoolData and (ibfWordWrap or ibfMultiline)) = (ibfWordWrap or ibfMultiline) then
      Items[i].FComplexHeight := (Items[i].FComplexHeight and $FFFF0000) or word(-1);
  end;
  with FView do
  begin
    FVisUpdated := true;
    FClearVis := true;
    FClearAll := true;
    FRangeUpdate := true;
  end;
  IsUpdating := false;
end;

procedure TCustomElTree.ReadScrollTracking(Reader : TReader);
begin
  FVertScrollTracking := Reader.ReadBoolean;
  FHorzScrollTracking := FVertScrollTracking;
end;

procedure TCustomElTree.ReadExpandOnDblClick(Reader : TReader);
begin
  if Reader.ReadBoolean then
    DblClickMode := dcmExpand;
end;

procedure TCustomElTree.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder(false, false);
    end;
end;

procedure TCustomElTree.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder(false, false);
    end;
end;

procedure TCustomElTree.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder(false, false);
    end;
end;

procedure TCustomElTree.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder(false, false);
    end;
end;

procedure TCustomElTree.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder(false, false);
    end;
end;

procedure TCustomElTree.ResetUpdateCounter;
begin
  if FUpdateCount > 0 then
  begin
    FUpdateCount := 1;
    SetUpdating(false);
  end
  else
  begin
    FUpdateCount := 0;
  end;
  FHeader.ResetUpdateCounter;
end;

procedure TCustomElTree.SetCheckBoxFlat(Value: Boolean);
begin
  if FCheckBoxFlat <> Value then
  begin
    IsUpdating := true;
    FCheckBoxFlat := Value;
    if FShowCheckboxes then
    with FView do
    begin
      FClearAll := true;
    end;
    FUpdated := true;
    IsUpdating := false;
  end;
end;

procedure TCustomElTree.SetSortColumnColor(Value: TColor);
begin
  if FSortColumnColor <> Value then
  begin
    IsUpdating := true;
    FSortColumnColor := Value;
    FView.FClearAll := true;
    FUpdated := true;
    IsUpdating := false;
  end;
end;

// ****************************************************************************
//                                  TElCellStyle
// ****************************************************************************
constructor TElCellStyle.Create;
begin
  inherited Create;
  FOwner := Owner;
  FCellType := sftText;
  FCellBkColor := clNone;
  FTextBkColor := clNone;
  FTextColor := clWindowText;
  FTextFlags := DefaultTextFlags;
  FCellType := sftText;
  FStyle := elhsText;
  FOwnerProps := False;
  BorderStyle := ibsNone;
end;

destructor TElCellStyle.Destroy;
begin
  Control := nil;
  inherited;
end;

procedure TElCellStyle.SetCellBkColor(newValue: TColor);
begin
  if (FCellBkColor <> newValue) then
  begin
    FCellBkColor := newValue;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
      FOwner.UpdateItem;
  end; {if}
end;

procedure TElCellStyle.SetTextBkColor(newValue: TColor);
begin
  if (FTextBkColor <> newValue) then
  begin
    FTextBkColor := newValue;
    if FStyle <> elhsText then exit;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
      FOwner.UpdateItem;
  end; {if}
end;

procedure TElCellStyle.SetTextColor(newValue: TColor);
begin
  if (FTextColor <> newValue) then
  begin
    FTextColor := newValue;
    if FStyle <> elhsText then exit;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
      FOwner.UpdateItem;
  end; {if}
end;

procedure TElCellStyle.SetTextFlags(newValue: DWORD);
begin
  if (FTextFlags <> newValue) then
  begin
    FTextFlags := newValue;
    if FStyle <> elhsText then exit;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
      FOwner.UpdateItem;
  end; {if}
end;

procedure TElCellStyle.SetPicture(newValue: TBitmap);
begin
  if (FPicture <> newValue) then
  begin
    FPicture := newValue;
    if FStyle <> elhsPictureOnly then exit;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
      FOwner.UpdateItem;
  end; {if}
end;

procedure TElCellStyle.SetStyle(newValue: TElSectionStyle);
begin
  if (FStyle <> newValue) then
  begin
    FStyle := newValue;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
      FOwner.UpdateItem;
  end; {if}
end;

procedure TElCellStyle.SetOwnerColors(newValue: Boolean);
begin
  if (FOwnerProps <> newValue) then
  begin
    FOwnerProps := newValue;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
      FOwner.UpdateItem;
  end; {if}
end;

procedure TElCellStyle.SetFontSize(newValue: integer);
begin
  if (FFontSize <> newValue) then
  begin
    FFontSize := newValue;
    if FStyle <> elhsText then exit;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
    begin
      with FOwner.FOwner do
        if FShowHeader and (FUpdateCount = 0) and (VirtualityLevel = vlNone) then
          AutoSizeColumn(Self.FOwner.FStaticData.FStyles.IndexOf(Self))
        else
          FColSizeUpdate := true;
      FOwner.UpdateItem;
    end;
  end; {if}
end;

procedure TElCellStyle.SetFontStyles(newValue: TFontStyles);
begin
  if (FFontStyles <> newValue) then
  begin
    FFontStyles := newValue;
    if FStyle <> elhsText then exit;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
    begin
      with FOwner.FOwner do
        if FShowHeader and (FUpdateCount = 0) and (VirtualityLevel = vlNone) then
          AutoSizeColumn(Self.FOwner.FStaticData.FStyles.IndexOf(Self))
        else
          FColSizeUpdate := true;
      FOwner.UpdateItem;
    end;
  end; {if}
end;

procedure TElCellStyle.SetFontName(newValue: TFontName);
begin
  if (FFontName <> newValue) then
  begin
    FFontName := newValue;
    if FStyle <> elhsText then exit;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
    begin
      with FOwner.FOwner do
        if FShowHeader and (FUpdateCount = 0) and (VirtualityLevel = vlNone) then
          AutoSizeColumn(Self.FOwner.FStaticData.FStyles.IndexOf(Self))
        else
          FColSizeUpdate := true;
      FOwner.UpdateItem;
    end;
  end; {if}
end;

procedure TElCellStyle.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TElCellStyle) then
  begin
    FUseBkColor  := TElCellStyle(Source).FUseBkColor;
    FCellBkColor := TElCellStyle(Source).FCellBkColor;
    FTextBkColor := TElCellStyle(Source).FTextBkColor;
    FTextColor := TElCellStyle(Source).FTextColor;
    FTextFlags := TElCellStyle(Source).FTextFlags;
    FPicture := TElCellStyle(Source).FPicture;
    FCellType := TElCellStyle(Source).FCellType;
    FStyle := TElCellStyle(Source).FStyle;
    FOwnerProps := TElCellStyle(Source).FOwnerProps;
    FFontSize := TElCellStyle(Source).FFontSize;
    FFontStyles := TElCellStyle(Source).FFontStyles;
    FFontName := TElCellStyle(Source).FFontName;
  end
  else
    inherited Assign(Source);
end; {Assign}

procedure TElCellStyle.SetControl(newValue: TElCellControl);
begin
  if (FControl <> newValue) then
  begin
    if FControl <> nil then
      if (FOwner <> nil) and (FOwner.FOwner <> nil) and (FOwner.FOwner.VirtualityLevel = vlNone) then
        FControl.Destroy;
    FControl := newValue;
    if FControl <> nil then
      FControl.FOwner := Self;
    Update;
  end; { if }
end; { SetControl }

procedure TElCellStyle.Update; { public }
begin
  if FOwner <> nil then FOwner.RedrawItem(true);
end; { Update }

procedure TElCellStyle.SetUseBkColor(Value: Boolean);
begin
  if FUseBkColor <> Value then
  begin
    FUseBkColor := Value;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
      FOwner.UpdateItem;
  end;
end;

procedure TElCellStyle.SetBorderStyle(Value: TElItemBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    if Assigned(FOwner) and Assigned(Owner.FStaticDataEx) and ((FOwner.FStaticDataEx.FBoolData1 and ibfUseStyles) = ibfUseStyles) then
      FOwner.UpdateItem;
  end;
end;

function TElTreeItemStaticDataEx.GetImage(Index : integer): Integer;
begin
  case Index of
    1: result := FImageIndex2;
    2: result := FStImageIndex;
    3: result := FStImageIndex2;
    4: result := FOverlayIndex;
    5: result := FOverlayIndex2;
    else
      result := FImageIndex;
  end;
end;

procedure TElTreeItemStaticDataEx.SetImage(Index : integer; Value : integer);
begin
  case Index of
    1: FImageIndex2 := Value;
    2: FStImageIndex := Value;
    3: FStImageIndex2 := Value;
    4: FOverlayIndex := value;
    5: FOverlayIndex2 := value;
    else
      FImageIndex := value;
  end;
end;

function TElTreeItemStaticDataEx.GetBoolFlag(Index : integer): Boolean;
begin
  Result := (FBoolData1 and (1 shl (Index - 1))) <> 0;
end;

procedure TElTreeItemStaticDataEx.SetBoolFlag(Index : integer; Value : boolean);
begin
  if Value then
    FBoolData1 := FBoolData1 or (1 shl (Index - 1))
  else
    FBoolData1 := FBoolData1 and not (1 shl (Index - 1));
end;

function TElTreeItemStaticDataEx.GetState(Index : integer) : Boolean;
begin
  result := index in FState;
end;

procedure TElTreeItemStaticDataEx.SetState(Index : integer; Value : boolean);
begin
  case index of
    stsCut:
      begin
        if value = false then Exclude(FState, stsCut)
        else Include(FState, stsCut);
      end;
    stsUnderlined:
      begin
        if value = false then Exclude(FState, stsUnderlined)
        else Include(FState, stsUnderlined);
      end;
    stsBold:
      begin
        if value = false then Exclude(FState, stsBold)
        else Include(FState, stsBold);
      end;
    stsItalic:
      begin
        if value = false then Exclude(FState, stsItalic)
        else Include(FState, stsItalic);
      end;
    stsStrikeOut:
      begin
        if value = false then Exclude(FState, stsStrikeOut)
        else Include(FState, stsStrikeOut);
      end;
  end; // case
end;

procedure TElTreeItemStaticDataEx.Assign(Source : TElTreeItemStaticDataEx);
begin
  FBoolData1 := Source.FBoolData1;
  FState  := Source.FState;
  FBkColor := Source.FBkColor;
  FStrikedLineColor:= Source.FStrikedLineColor;
  FBorderSpaceColor:= Source.FBorderSpaceColor;
  FIndentAdjust:= Source.FIndentAdjust;
  FBorderStyle:= Source.FBorderStyle;
  FColor:= Source.FColor;
  FCheckBoxType:= Source.FCheckBoxType;
  FCheckBoxState:= Source.FCheckBoxState;
  FRowBkColor:= Source.RowBkColor;
  FImageIndex   := Source.FImageIndex;
  FStImageIndex := Source.FStImageIndex;
  FImageIndex2  := Source.FImageIndex2;
  FStImageIndex2:= Source.FStImageIndex2;
  FOverlayIndex := Source.FOverlayIndex;
  FOverlayIndex2:= SOurce.FOverlayIndex2;
end;

var
  OleDLL : HModule;

initialization

  OleDLL := LoadLibrary('OLE32.DLL');
  Screen.Cursors[crDragSingleNo] := LoadCursor(OleDLL, PChar(1));
  Screen.Cursors[crDragSingleMove] := LoadCursor(OleDLL, PChar(2));
  Screen.Cursors[crDragSingleCopy] := LoadCursor(OleDLL, PChar(3));

  PlusBmp := TBitmap.Create;
  MinusBmp := TBitmap.Create;
  LeafBmp := TBitmap.Create;

  PlusBmp.LoadFromResourceName(HInstance, 'PlusBmp');
  MinusBmp.LoadFromResourceName(HInstance, 'MinusBmp');
  LeafBmp.LoadFromResourceName(HInstance, 'LeafBmp');
  PlusBmp.PixelFormat := pf32bit;
  MinusBmp.PixelFormat := pf32bit;
  LeafBmp.PixelFormat := pf32bit;

  ChangeButtonColors(PlusBmp);
  ChangeButtonColors(MinusBmp);
  ChangeButtonColors(LeafBmp);

  PlusBmp.PixelFormat := pfDevice;
  MinusBmp.PixelFormat := pfDevice;
  LeafBmp.PixelFormat := pfDevice;

finalization
  try
    FreeAndNil(PlusBmp);
    FreeAndNil(MinusBmp);
    FreeAndNil(LeafBmp);
    FreeLibrary(OleDLL);
    except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElTree: ' + e.Message);
    end;
  end;

end.
