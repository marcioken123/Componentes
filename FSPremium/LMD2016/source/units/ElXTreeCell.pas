unit ElXTreeCell;
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

ElXTreeCell unit
----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils,
  Classes,
  Controls,
  Messages,
  Math,
  Windows,
  Graphics,
  Forms,
  StdCtrls,
  ExtCtrls,
  CommCtrl,
  Types,
  LMDTypes,
  LMDProcs,
  ImgList,
  Buttons,
  Menus,
  UxTheme, Themes,
  Variants,
  {$ifndef VER90}
  ActiveX,
{$endif}

  ElStyleMan,
  ElHook,
  ElXPThemedControl,
  ElHeader,
  ElSBCtrl,
  ElScrollBar,
  ElHintWnd,
  ElInputProcessor,
  ElIni,
  ElImgFrm,
  ElDragDrop,
  ElTreeInplaceEditors,
  ElVCLUtils,

  LMDClass,
  LMDObjectList,
  LMDStrings,
  LMDThemes,
{$ifdef LMD_UNICODE}
  LMDUnicodeStrings,
{$endif}
  LMDGlyphs,
  LMDSysIn,
  LMDHTMLUnit,
  LMDGraphUtils,
  LMDGraph,
  LMDElConst;

const
  CDefaultTextFlags = DT_NOPREFIX or DT_SINGLELINE or DT_VCENTER or DT_LEFT or DT_END_ELLIPSIS;

type
  EStyleNotAssigned = class(Exception);
  TElXCustomTreeCell = class;
  TElXCellControl = class;
  TElXTreeCustomCellRange = class;
  {$HPPEMIT 'class DELPHICLASS TElXTreeCustomCellRange;'}
//  TElXTreeCustomCellRangeArray = array of TElXTreeCustomCellRange;

  TElXTreeCellColorType = (cctTextColor, cctTextBackGroundColor, cctCellBackGroundColor,
    {cctRowBackGroundColor,} cctBorderSpaceColor, cctStrikedLineColor);

  TElSTIState = (
    stsCut,
    stsUnderlined,
    stsBold,
    stsItalic,
    stsExpanded,
    stsStrikeOut
  );

  TElSTIStates = set of TElSTIState;

  PStyleInfo = ^TStyleInfo;

  TStyleInfo = record
    FBorderStyle: TElItemBorderStyle;
    FCellBackGroundColor: TColor;
    FTextBackGroundColor: TColor;
    FTextColor: TColor;
    FTextFlags: DWORD;
    FPicture: {$IFDEF LMDX64}Integer{$ELSE}TBitmap{$ENDIF};
    FCellType: TElFieldType;
    FDrawStyle: TElSectionStyle;
    FOwnerProps: Boolean;
    FUseBackGroundColor: Boolean;
    FFontSize: integer;
    FFontStyles: TFontStyles;
    FTextAlignment: TAlignment;
    FBorderSpaceColor: TColor;
    FBorderSides: TLMDBorderSides;
    FStrikedLineColor: TColor;
    FStrikedOutLine: boolean;
    FTag: Integer;
    FParentColors: Boolean;
    FState: TElSTIStates;
  end;

  TElXTreeViewColorHelper = class(TObject)
  private
//    FOverColors: Boolean;
    FRowOvColors: Boolean;
    FVisible: TLMDObjectList;
  public
    constructor Create;
    destructor Destroy; override;
//    property OverColors: Boolean read FOverColors write FOverColors;
    property RowOvColors: Boolean read FRowOvColors write FRowOvColors;
    property Visible: TLMDObjectList read FVisible;
  end;

  TElXCellStyleAncestor = class;

  TElXCellFont = class(TFont)
  private
  protected
    FOwner: TElXCellStyleAncestor;
    procedure Changed; override;
  public
    constructor Create(AOwner: TElXCellStyleAncestor);
  end;

  TElXCellStyleAncestor = class(TPersistent)
  private
  protected
    FParentColors: Boolean;
    FState: TElSTIStates;
    FIsUpdating: Boolean;
    FTag: Integer;
    FItem: TPersistent;
    FCell: TElXCustomTreeCell;
    FCellBackGroundColor: TColor;
    FTextBackGroundColor: TColor;

    FTextFlags: DWORD;
    FCellType: TElFieldType;
    FDrawStyle: TElSectionStyle;
    //FOwnerProps: Boolean;

    FControl: TElXCellControl;
    FUseBackGroundColor: Boolean;
    FBorderStyle: TElItemBorderStyle;
    FFont: TElXCellFont;
    FTextAlignment: TAlignment;

    FBorderSpaceColor: TColor;
    FStrikedLineColor: TColor;
    FStrikedOutLine: boolean;
    FBorderSides: TLMDBorderSides;
    FOnChange: TNotifyEvent;
    procedure DoChangeEvent;
//    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure SetParentColors(const Value: Boolean);
    procedure SetBorderSpaceColor(const Value: TColor);
    procedure SetStrikedLineColor(const Value: TColor);

//    procedure TriggerVirtualStyleNeeded;
    procedure SetControl(newValue: TElXCellControl);
    function GetFontSize: Integer;
    procedure SetFontSize(newValue: integer);
    function GetFontStyles: TFontStyles;
    procedure SetFontStyles(newValue: TFontStyles);
    function GetFontName: TFontName;
    procedure SetFontName(newValue: TFontName);
    //procedure SetOwnerColors(newValue: Boolean);
    procedure SetDrawStyle(newValue: TElSectionStyle);
    function GetCellBackGroundColor: TColor;
    procedure SetCellBackGroundColor(newValue: TColor);
    function GetTextBackGroundColor: TColor;
    procedure SetTextBackGroundColor(newValue: TColor);
    function GetTextColor: TColor;
    procedure SetTextColor(newValue: TColor);
    procedure SetTextFlags(newValue: DWORD);
    procedure SetUseBackGroundColor(Value: Boolean);
    procedure SetBorderStyle(Value: TElItemBorderStyle);
    procedure ColumnSizeUpdate;
    procedure SetTextAlignment(Value: TAlignment);
    function GetTextAlignment:TAlignment;
    procedure SetStrikedOutLine(Value: boolean);
    function GetState(AIndex: integer): Boolean;
    procedure SetState(AIndex: integer; AValue: Boolean);
  public
    constructor Create(AItem: TPersistent {TElXTreeItem}; ACell: TElXCustomTreeCell);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent);override;
    procedure Update;
    procedure LoadFromStream(Stream : TStream);virtual;
    procedure WriteToStream(Stream : TStream);virtual;
  end;

  TElXCellStyleRead = class(TElXCellStyleAncestor)
  public
    property IsUpdating: Boolean read FIsUpdating;
    property Item: TPersistent read FItem;
    property Cell: TElXCustomTreeCell read FCell;
  published
    property BorderSides: TLMDBorderSides read FBorderSides;
    property ParentColors: Boolean read FParentColors;
    property Tag: Integer read FTag;
    property Control: TElXCellControl read FControl;
    property CellBackGroundColor: TColor read GetCellBackGroundColor;
    property TextBackGroundColor: TColor read GetTextBackGroundColor;
    property TextColor: TColor read GetTextColor;
    property TextFlags: DWORD read FTextFlags;
    property CellType: TElFieldType read FCellType default sftText;
    property DrawStyle: TElSectionStyle read FDrawStyle;
    property FontSize: integer read GetFontSize;
    property FontStyles: TFontStyles read GetFontStyles;
    property FontName: TFontName read GetFontName;
    property UseBackGroundColor: Boolean read FUseBackGroundColor;
    property BorderStyle: TElItemBorderStyle read FBorderStyle;
    property TextAlignment: TAlignment read FTextAlignment;

    property BorderSpaceColor: TColor read FBorderSpaceColor;
    property StrikedLineColor: TColor read FStrikedLineColor;
    property StrikedOutLine: boolean read FStrikedOutLine;

//    property Cut: Boolean index stsCut read GetState;
    property Bold: Boolean index stsBold read GetState;
    property Underlined: Boolean index stsUnderlined read GetState;
    property Italic: Boolean index stsItalic read GetState;
    property StrikeOut: Boolean index stsStrikeOut read GetState;
  end;

  TElXCellStyle = class(TElXCellStyleRead)
  public
    property IsUpdating: Boolean read FIsUpdating write FIsUpdating;
    property Owner: TPersistent read FItem; // deprecated, use Item or Cell instead
    property Item: TPersistent read FItem;
    property Cell: TElXCustomTreeCell read FCell;
  published
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property BorderSides: TLMDBorderSides read FBorderSides write FBorderSides default [ebsLeft, ebsRight, ebsTop, ebsBottom];
    property ParentColors: Boolean read FParentColors write SetParentColors default True;
    property Tag: Integer read FTag write FTag default 0;
    property Control: TElXCellControl read FControl write SetControl; { Published }
    property CellBackGroundColor: TColor read GetCellBackGroundColor write SetCellBackGroundColor default clNone;
    property TextBackGroundColor: TColor read GetTextBackGroundColor write SetTextBackGroundColor default clNone;
    property TextColor: TColor read GetTextColor write SetTextColor default clWindowText;
    property TextFlags: DWORD read FTextFlags write SetTextFlags default CDefaultTextFlags;
    property CellType: TElFieldType read FCellType write FCellType default sftText;
    property DrawStyle: TElSectionStyle read FDrawStyle write SetDrawStyle default elhsText;
    property FontSize: integer read GetFontSize write SetFontSize;
    property FontStyles: TFontStyles read GetFontStyles write SetFontStyles;
    property FontName: TFontName read GetFontName write SetFontName;
    property UseBackGroundColor: Boolean read FUseBackGroundColor write SetUseBackGroundColor default true;
    property BorderStyle: TElItemBorderStyle read FBorderStyle write SetBorderStyle default ibsNone;
    property TextAlignment: TAlignment read FTextAlignment write SetTextAlignment default taLeftJustify;
    property BorderSpaceColor: TColor read FBorderSpaceColor write SetBorderSpaceColor default clWindow;
    property StrikedLineColor: TColor read FStrikedLineColor write SetStrikedLineColor default clNone;
    property StrikedOutLine: boolean read FStrikedOutLine write SetStrikedOutLine default False;
//    property Cut: Boolean index stsCut read GetState write SetState;
    property Bold: Boolean index stsBold read GetState write SetState default False;
    property Underlined: Boolean index stsUnderlined read GetState write SetState default False;
    property Italic: Boolean index stsItalic read GetState write SetState default False;
    property StrikeOut: Boolean index stsStrikeOut read GetState write SetState default False;
  end;

  TElXCellControl = class(TComponent)
  private
    FPopupMenu: TPopupMenu;
    FOwner: TElXCellStyleAncestor;
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
//    FSelected: Boolean;

    procedure SetPopupMenu(newValue: TPopupMenu);
    procedure FontChanged(Sender: TObject);
    procedure SetFont(newValue: TFont);
  protected
       //procedure SetBoundsRect(newValue : TRect); virtual;
    FBorderWidth: Integer;
//    procedure SetSelected(const ASelected: Boolean);
    procedure SetCaption(newValue: TLMDString); virtual;
    procedure SetVisible(newValue: Boolean); virtual;
    procedure SetEnabled(newValue: Boolean); virtual;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetBorderWidth(Value: Integer);
  public
    procedure TriggerClickEvent; virtual;
    procedure TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    procedure TriggerDblClickEvent; virtual;
    procedure TriggerMouseMoveEvent(Shift: TShiftState; X, Y: Integer); virtual;
    procedure TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); virtual;
    function PassClicks: Boolean; virtual;
    procedure SetControlActive; virtual;
    procedure Update; virtual;

    procedure Assign(Source: TElXCellControl); reintroduce; virtual;

    procedure Paint(ACell: TElXCustomTreeCell; Canvas: TCanvas; Rect: TRect); virtual;
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
//    property Selected: Boolean read FSelected write SetSelected;
  published
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth;
    property Font: TFont read FFont write SetFont;
    property Caption: TLMDString read FCaption write SetCaption;
    property Owner : TElXCellStyleAncestor read FOwner write FOwner;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Visible: Boolean read FVisible write SetVisible default True;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnMouseDown: TMouseEvent read FOnMouseDown write FOnMouseDown;
    property OnMouseUp: TMouseEvent read FOnMouseUp write FOnMouseUp;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnMouseMove: TMouseMoveEvent read FOnMouseMove write FOnMouseMove;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
  end;

  TElXCellControlClass = class of TElXCellControl;

  TElXCellCheckBox = class(TElXCellControl)
  private
    FAlignment : TAlignment;
    FState     : TCheckBoxState;
    FAllowGrayed : boolean;
    FCheckBoxType: TElCheckBoxType;
    procedure SetState(newValue : TCheckBoxState);
    procedure SetAllowGrayed(newValue : Boolean);
    function GetChecked : Boolean;
    procedure SetChecked(newValue : Boolean);
    procedure SetAlignment(newValue : TAlignment);
    procedure SetCheckBoxType(newValue : TElCheckBoxType);
  protected
  public
    procedure TriggerClickEvent; override;
    procedure TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Assign(Source: TElXCellControl); override;
    constructor Create; override;
    destructor Destroy; override;
    procedure Paint(ACell: TElXCustomTreeCell; Canvas: TCanvas; R: TRect); override;
  published
    property State : TCheckBoxState read FState write SetState;
    property Checked : boolean read GetChecked write SetChecked;
    property AllowGrayed : Boolean read FAllowGrayed write SetAllowGrayed; { Published }
    property Alignment : TAlignment read FAlignment write SetAlignment default taRightJustify; { Protected }
    property CheckBoxType: TElCheckBoxType read FCheckBoxType write SetCheckBoxType;
  end;

  TElXCellButtonGlyph = class(TLMDButtonGlyph)
    property ImageList;
    property ImageIndex;
    property UseImageList;
  end;

  TElXCellButton = class(TElXCellControl)
  private
    FGlyph: TElXCellButtonGlyph;
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
  public
    procedure TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Assign(Source: TElXCellControl); override;
    constructor Create; override;
    destructor Destroy; override;
    procedure Paint(ACell: TElXCustomTreeCell; Canvas: TCanvas; R: TRect); override;
  published
    property UseImageList : Boolean read GetUseImageList write SetUseImageList;  { Public }
    property ImageList : TCustomImageList read GetImageList write SetImageList;  { Public }
    property ImageIndex : Integer read GetImageIndex write SetImageIndex;  { Public }

    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property FixClick: Boolean read FFixClick write FFixClick;
    property Down: Boolean read FDown write SetDown default False;
    property Layout: TButtonLayout read FLayout write SetLayout default blGlyphLeft;
  end;

  TElXCellProgressBar = class(TElXCellControl)
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
  public
    constructor Create; override;
    procedure Assign(Source: TElXCellControl); override;
    procedure Paint(ACell: TElXCustomTreeCell; Canvas: TCanvas; R: TRect); override;
    function PassClicks: Boolean; override;
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

  TJointCellRole = (jcrSingle, jcrMaster, jcrSlave);

  TElXBaseCell = class
  private
  protected
    FOwner: TPersistent;
    FText: TLMDString;
    FJointCellRole: TJointCellRole;
    FJointCellMaster: TElXBaseCell;
    FJointRowCount: Integer;
    FJointColumnCount: Integer;
    function GetText: TLMDString; virtual;
    procedure SetText(const AValue: TLMDString); virtual;
    function GetJointRangeMasterCell: TElXBaseCell; virtual;
    procedure LoadFromStream(Stream : TStream);virtual;
    procedure WriteToStream(Stream : TStream);virtual;
    function GetIndex: Integer; virtual;abstract;
    function GetRowIndex: Integer;virtual;abstract;
    property Owner: TPersistent read FOwner write FOwner; // TElXTreeItem for TElXTreeCustomCell
  public
    constructor Create(AOwner: TPersistent);virtual;
    destructor Destroy; override;
    function GetOwner: TPersistent; virtual;
    procedure Join(ARowCount, AColumnCount: Integer); virtual;abstract;
    procedure Split; virtual;abstract;
    property Index: Integer read GetIndex;
    property Text: TLMDString read GetText write SetText;
    property JointCellMaster: TElXBaseCell read FJointCellMaster;
    property JointCellRole: TJointCellRole read FJointCellRole;
    property JointRowCount: Integer read FJointRowCount;
    property JointColumnCount: Integer read FJointColumnCount;
    property RowIndex: Integer read GetRowIndex;
  end;

  TElXCustomTreeCell = class(TElXBaseCell)
  private
    FPicture: TBitmap;
    procedure SetUseOwnStyle(const Value: Boolean);
    function GetUseOwnStyle: Boolean;
    procedure SetHTMLControlsVisible(const Value: boolean);
  protected
    FCellRect: TRect;
    FTag: Integer;
    FUserText: Boolean;
    FSelected: Boolean;
    FObject: TObject;
    FWidth: Integer;
    FOwnStyle: TElXCellStyle;
    FVirtStyle: TElXCellStyle;
    FShowCheckBox: boolean;
    FData          : Pointer; // generic data

    FUseOwnStyle: boolean;
    FTextTooLarge: Boolean; // value to reduce MeasureCellText calls
    FHTMLControlsVisible: boolean;

    function IsSelected: Boolean;
    procedure SetPicture(newValue: TBitmap);
    function GetJointRangeMasterCell: TElXCustomTreeCell; reintroduce;
    function GetIndex: Integer; override;
    function GetControl: TElXCellControl;
    function GetText: TLMDString; override;
    procedure SetText(const AValue: TLMDString); override;
    function GetOwnStyle: TElXCellStyle;
    function GetCurrentStyle: TElXCellStyleRead;

    function GetHeaderSection: TPersistent; virtual;
    function GetAbsoluteRowIndex: Integer; virtual;
    function GetRowIndex: Integer; override;

    function GetVisible: Boolean; virtual;

    function GetLeft: Integer; virtual;
    function GetTop: Integer; virtual;
    function GetHeight: Integer; virtual;
    function GetWidth: Integer; virtual;

    procedure SetLeft(const Value: Integer); virtual;
    procedure SetTop(const Value: Integer); virtual;
    procedure SetHeight(const Value: Integer); virtual;
    procedure SetWidth(const Value: Integer); virtual;

    procedure SetVisible(const Value: Boolean); virtual;

    procedure SetSelected(const ASelected: Boolean);
    procedure SetStyleProps(const ACanvas: TCanvas; const AStyle: TElXCellStyleRead);
    procedure SetSelDropColors(const ACanvas: TCanvas);
    procedure SetRowDragColors(const ACanvas: TCanvas);
    procedure NoStylesItemDraw(const ACanvas: TCanvas; var ARect: TRect; AStyle: TElXCellStyleRead; AUsePartialCheck: boolean = true);
    procedure CalcTextRect(const ACanvas: TCanvas; var ATextRect, AR: TRect;
      const AText: TLMDString; AUsePartialCheck: boolean = true);
    procedure SetHtmlProps(const ACanvas: TCanvas;
      var ATextRect: TRect; const AText: TLMDString; const ARect: TRect; AUsePartialCheck: boolean = true);
    procedure HtmlOutput(const ACanvas: TCanvas; var ATextRect: TRect; const AR, AR1: TRect;
      const AVAlign: Integer; AUsePartialCheck: boolean = true);
    procedure NonHtmlOutput(const ACanvas: TCanvas; var ATextRect: TRect; const AR, AR1: TRect;
      const AVAlign, AHAlign: Integer; const AText: TLMDString);
    procedure SetStyledFontProps(const ACanvas: TCanvas;
      const ACurStyle: TElXCellStyleRead);
    procedure SetSelItemColors(const ACanvas: TCanvas);
    procedure SetDropTrgItemColors(const ACanvas: TCanvas);
    procedure AdjustTextRect(const ACanvas: TCanvas; var ATextRect: TRect;
      var AR: TRect; const AItemWholeRect: TRect;
      const AHAlign: Integer; var AVAlign: Integer);
    procedure PictureOutput(const ACanvas: TCanvas; const ARect: TRect);
    procedure TreeLinesOffsetRect(var R: TRect);
    procedure DrawNodeButtons(const ACanvas: TCanvas; var ARect: TRect);
    procedure DrawItemCheckBox(const ACanvas:TCanvas; ABitmap:TBitmap; var ARect: TRect);
    procedure DrawItemImages(const ACanvas:TCanvas; ABitmap:TBitmap; var ARect: TRect);
    procedure DrawBox(const ACanvas: TCanvas; const ARect: TRect;
      const AStyle: TElXCellStyleRead);
    procedure DrawCellBk(const ACanvas: TCanvas; const ARect: TRect; AAbsIndex: integer = -1; AVisIndex: integer = -1);
    procedure DrawFocusedCellBk(const ACanvas: TCanvas; const APosition: Integer; var ARect: TRect);
    procedure DrawCellBorders(const ACanvas: TCanvas; const ARect: TRect);
    procedure DrawCellTextLocal(const ACanvas: TCanvas; var ARect: TRect; AUsePartialCheck: boolean = true);
    procedure DrawVerticalLines(const ACanvas: TCanvas; const ARect: TRect;
      ACurStyle: TElXCellStyleRead);
    procedure DrawHorizontalLines(const ACanvas: TCanvas; const ARect: TRect;
      ACurStyle: TElXCellStyleRead);
    procedure PaintStrikedOutLine(const ACanvas: TCanvas; const ARect: TRect);

    property Selected: Boolean read FSelected write SetSelected;
    property Control: TElXCellControl read GetControl;
    property Style: TElXCellStyle read GetOwnStyle;
    property HeaderSection: TPersistent read GetHeaderSection;

    property UserText: Boolean read FUserText write FUserText;
    property UseOwnStyle: Boolean read GetUseOwnStyle write SetUseOwnStyle;
    procedure LoadFromStream(Stream : TStream; ver: integer);reintroduce;
    procedure WriteToStream(Stream : TStream);override;
    function GetJointCellMaster: TElXCustomTreeCell;
    property CurrentStyle: TElXCellStyleRead read GetCurrentStyle;
  public
    constructor Create(AOwner: TPersistent);override;
    destructor Destroy; override;
    procedure Assign(Source: TElXCustomTreeCell); virtual;
    procedure Join(ARowCount, AColumnCount: Integer); override;
    procedure Split; override;
    procedure Paint(const ACanvas: TCanvas; const ARect: TRect; AUsePartialCheck: boolean = true; AAbsIndex: integer = -1; AVisIndex: integer = -1); virtual;
    function CreateControl(AControlClass: TElXCellControlClass): TElXCellControl;
    property JointCellMaster: TElXCustomTreeCell read GetJointCellMaster;
    property Visible: Boolean read GetVisible write SetVisible;
    property CellObject: TObject read FObject write FObject;
    property AbsoluteRowIndex: Integer read GetAbsoluteRowIndex;
    property Top: Integer read GetTop write SetTop;
    property Left: Integer read GetLeft write SetLeft;
    property Height: Integer read GetHeight write SetHeight;
    property Width: Integer read GetWidth write SetWidth;
    property Picture: TBitmap read FPicture write SetPicture;
    property Tag: Integer read FTag write FTag;
    property Data: Pointer read FData write FData;
    property CellRect: TRect read FCellRect write FCellRect;
    property HTMLControlsVisible: boolean read FHTMLControlsVisible write SetHTMLControlsVisible default true;
  end;

  // cell horizontal row
  TElXBaseCellRow = class(TLMDObjectList)
  protected
    function GetCell(AIndex: Integer): TElXBaseCell;virtual;
    function IntGetCount: Integer; virtual;
    function GetCount: Integer;
    constructor Create;
    property Cell[AIndex: Integer]: TElXBaseCell read GetCell; default;
    property Count: Integer read GetCount;
  public
    procedure Delete(AIndex: Integer); override;
    function IndexOf(ACell: TElXBaseCell): Integer; virtual;
  end;

  TElXTreeCustomCellRow = class(TElXBaseCellRow)
  protected
    function GetCell(AIndex: Integer): TElXCustomTreeCell;reintroduce;
    property Cell[AIndex: Integer]: TElXCustomTreeCell read GetCell; default;
  public
    function IndexOf(ACell: TElXCustomTreeCell): Integer;reintroduce;
  end;

  TElXTreeCustomCellRange = class(TLMDObjectList)
  protected
    FRowStart,
    FRowEnd,
    FColStart,
    FColEnd: Integer;
  public
    procedure Split;
    function CanSplit: Boolean;
    function CanMerge: Boolean;
    procedure CheckBorderValues;
    property RowStart: Integer read FRowStart;
    property RowEnd: Integer read FRowEnd;
    property ColStart: Integer read FColStart;
    property ColEnd: Integer read FColEnd;
  end;

procedure DrawFlatCheckboxFrame(ATree: TCustomControl; DC: HDC; R: TRect; Enabled: boolean);
procedure DrawFlatRadioButtonFrame(ATree: TCustomControl; DC: HDC; R: TRect; Enabled: boolean);
procedure DrawCellFrame(Cell: TElXCustomTreeCell;const ACanvas: TCanvas; const ARect: TRect; grfFlags: UINT; IsDot: Boolean = False; CheckMaster: Boolean = False);

implementation

uses
  ElXTree, ElXHeader;

type
  THCustomElXTree = class(TCustomElXTree);
  THElXTreeView = class(TElXTreeView);
  THElXTreeItem = class(TElXTreeItem);

procedure DrawFlatCheckboxFrame(ATree: TCustomControl; DC: HDC; R: TRect; Enabled: boolean);
var
  AColor, Color : TColor;
  LTree: TElXTree;
  begin
  LTree := TElXTree(ATree);
  if ((LTree.Focused or LTree.MouseOver) and (LTree.ActiveBorderType = fbtColorLineBorder)) or
     ((not (LTree.Focused or LTree.MouseOver)) and (LTree.InactiveBorderType = fbtColorLineBorder)) then
  begin
    if Enabled then
      Color := clWindow
    else
      Color := clBtnFace;
    if LTree.Focused or LTree.MouseOver then
      AColor := LTree.LineBorderActiveColor
    else
      AColor := LTree.LineBorderInactiveColor;
  ELVCLUtils.DrawFlatFrameEx2(DC, R, AColor, Color, false, true,
      AllBorderSides, fbtColorLineBorder, LTree.BorderColorFace,
      LTree.BorderColorDkShadow, LTree.BorderColorShadow,
      LTree.BorderColorHighlight, LTree.BorderColorWindow);
  end
  else
    ElVCLUtils.DrawFlatFrame(DC, R, clBtnFace, false);
end;

procedure DrawFlatRadioButtonFrame(ATree: TCustomControl; DC: HDC; R: TRect; Enabled: boolean);
var
  i : integer;
  Color : TColor;
  AColor: TColor;
  LTree: TElXTree;

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
  LTree := TElXTree(ATree);
  if ((LTree.Focused or LTree.MouseOver) and (LTree.ActiveBorderType = fbtColorLineBorder)) or
     ((not (LTree.Focused or LTree.MouseOver)) and (LTree.InactiveBorderType = fbtColorLineBorder)) then
  begin
    if Enabled then
      Color := clWindow
    else
      Color := clBtnFace;

    if LTree.Focused or LTree.MouseOver then
      AColor := LTree.LineBorderActiveColor
    else
      AColor := LTree.LineBorderInactiveColor;

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

// ****************************************************************************
//                                  TElXCellStyle
// ****************************************************************************

constructor TElXCellStyleAncestor.Create(AItem: TPersistent {TElXTreeItem}; ACell: TElXCustomTreeCell);
var
  LItem: TElXTreeItem;
begin
  inherited Create;

  FUseBackgroundColor := True;
  FParentColors := True;
  FFont := TElXCellFont.Create(Self);
  FItem := AItem;
  FCell := ACell;
  FTextFlags := CDefaultTextFlags;
  FCellType := sftText;
  FControl := nil;
  FFont.Color := clWindowText;
  FCellBackGroundColor := clNone;
  FTextBackGroundColor := clNone;
  FStrikedLineColor := clNone;
  FTextAlignment := taLeftJustify;
  FBorderSpaceColor := clWindow;
  FBorderStyle := ibsNone;
  FCellBackGroundColor := clNone;
  FTextBackGroundColor := clNone;
  FBorderSides := [ebsLeft, ebsRight, ebsTop, ebsBottom];
  if Assigned(AItem) and
  (THCustomElXTree(TElXTreeItem(AItem).Owner).VirtualityLevel = vlNone)
  then
  begin
    LItem := AItem as TElXTreeItem;
    if Assigned(LItem.CurrentStyle) then
      Self.Assign(LItem.CurrentStyle)
  end
  else
  begin
    if Assigned(AItem) then
      FFont.Assign(TElXTreeItem(AItem).Owner.Font);
  end;
end;

destructor TElXCellStyleAncestor.Destroy;
begin
  if Assigned(FControl) then
    FControl.Free;
  FControl := nil;
  FreeAndNil(FFont);
//  Control.Free;
  inherited;
end;

//procedure TElXCellStyleAncestor.TriggerVirtualStyleNeeded;
//var
//  LCell: TElXCustomTreeCell;
//  LItem: TElXTreeItem;
//  LTree: THCustomElXTree;
//begin
//  LCell := FCell;
//  if Assigned(LCell) then
//  begin
//    if Assigned(LCell.Owner) then
//    begin
//      LItem := LCell.Owner as TElXTreeItem;
//      LTree := THCustomElXTree(LItem.Owner);
//      if Assigned(LTree) and (LTree.VirtualityLevel <> vlNone) then
//      begin
//        LTree.TriggerVirtualStyleNeeded(LItem, LCell.Index, TElXCellStyle(Self));
////        if Assigned(LTree.OnVirtualPropsNeeded) then
////          LTree.OnVirtualPropsNeeded(LCell, LItem
//      end;
//    end;
//  end;
////  LItem := TElXTreeItem(FItem);
////  if Assigned(LItem) then;
//end;

function TElXCellStyleAncestor.GetCellBackGroundColor: TColor;
begin
//  TriggerVirtualStyleNeeded;
  Result := FCellBackGroundColor;
end;

procedure TElXCellStyleAncestor.SetCellBackGroundColor(newValue: TColor);
var
  LItem: TElXTreeItem;
begin
  if (FCellBackGroundColor <> newValue) then
  begin
    FCellBackGroundColor := newValue;
    LItem := TElXTreeItem(FItem);
    if not FIsUpdating and Assigned(LItem) and
    (THCustomElXTree(LItem.Owner).VirtualityLevel = vlNone)
    then
      LItem.UpdateItem;
    DoChangeEvent;
  end;
end;

function TElXCellStyleAncestor.GetTextBackGroundColor: TColor;
begin
//  TriggerVirtualStyleNeeded;
  Result := FTextBackGroundColor;
end;

procedure TElXCellStyleAncestor.SetTextBackGroundColor(newValue: TColor);
var
  LItem: TElXTreeItem;
begin
  if (FTextBackGroundColor <> newValue) then
  begin
    FTextBackGroundColor := newValue;
    if FDrawStyle <> elhsText then exit;
    LItem := TElXTreeItem(FItem);
    if not FIsUpdating and Assigned(LItem) and
    (THCustomElXTree(LItem.Owner).VirtualityLevel = vlNone)
    then
      LItem.UpdateItem;
    DoChangeEvent;
  end;
end;

function TElXCellStyleAncestor.GetTextColor: TColor;
begin
  Result := FFont.Color;
end;

procedure TElXCellStyleAncestor.SetTextColor(newValue: TColor);
var
  LItem: TElXTreeItem;
begin
  if (FFont.Color <> newValue) then
  begin
    FIsUpdating := True;
    FFont.Color := newValue;
    FIsUpdating := False;
    if FDrawStyle <> elhsText then exit;
    LItem := TElXTreeItem(FItem);
    if not FIsUpdating and Assigned(LItem) and
    (THCustomElXTree(LItem.Owner).VirtualityLevel = vlNone)
    then
      LItem.UpdateItem;
    DoChangeEvent;
  end;
end;

procedure TElXCellStyleAncestor.SetTextFlags(newValue: DWORD);
var
  LItem: TElXTreeItem;
begin
  if (FTextFlags <> newValue) then
  begin
    FTextFlags := newValue;
    if FDrawStyle <> elhsText then exit;
    LItem := TElXTreeItem(FItem);
    if not FIsUpdating and Assigned(LItem) and
    (THCustomElXTree(LItem.Owner).VirtualityLevel = vlNone)
    then
      LItem.UpdateItem;
    DoChangeEvent;
  end;
end;

procedure TElXCellStyleAncestor.SetDrawStyle(newValue: TElSectionStyle);
var
  LItem: TElXTreeItem;
begin
  if (FDrawStyle <> newValue) then
  begin
    FDrawStyle := newValue;
    LItem := TElXTreeItem(FItem);
    if not FIsUpdating and Assigned(LItem) and
    (THCustomElXTree(LItem.Owner).VirtualityLevel = vlNone)
    then
      LItem.UpdateItem;
    DoChangeEvent;
  end;
end;
{
procedure TElXCellStyle.SetOwnerColors(newValue: Boolean);
var
  LItem: TElXTreeItem;
begin
  if (FOwnerProps <> newValue) then
  begin
    FOwnerProps := newValue;
    LItem := TElXTreeItem(FItem);
    if not IsUpdating and Assigned(LItem) and LItem.UseStyles then
      LItem.UpdateItem;
  end;
end;
}

function TElXCellStyleAncestor.GetFontSize: Integer;
begin
  Result := FFont.Size;
end;

function TElXCellStyleAncestor.GetTextAlignment:TAlignment;
begin
  result := taLeftJustify;
  if DT_LEFT and FTextFlags = DT_LEFT then result := taLeftJustify;
  if DT_RIGHT and FTextFlags = DT_RIGHT then result := taRightJustify;
  if DT_CENTER and FTextFlags = DT_CENTER then result := taCenter;
end;

procedure TElXCellStyleAncestor.SetTextAlignment(Value: TAlignment);
begin
  if (FTextAlignment <> Value) then
  begin
    FTextAlignment := Value;
    case Value of
      taLeftJustify: FTextFlags := FTextFlags and not (DT_RIGHT or DT_CENTER);
      taRightJustify: FTextFlags := (FTextFlags and not DT_CENTER) or DT_RIGHT;
      taCenter: FTextFlags := (FTextFlags and not DT_RIGHT) or DT_CENTER;
    end;
    DoChangeEvent;
  end;
end;

procedure TElXCellStyleAncestor.ColumnSizeUpdate;
var
  LItem: TElXTreeItem;
  LTree: THCustomElXTree;
  begin
  LItem := TElXTreeItem(FItem);
  if Assigned(LItem) and not LItem.Owner.IsUpdating and LItem.UseOwnStyle then
  begin

    LTree := THCustomElXTree(LItem.Owner);
    if LTree.ShowColumns and (LTree.UpdateCount = 0) and (LTree.VirtualityLevel = vlNone) then

      if Assigned(FCell) then
        LTree.AutoSizeColumn(FCell.Index)
      else
        LTree.AutoSizeAllColumns;
//    else
//      LTree.ColumnSizeUpdate := true;
    if (LTree.VirtualityLevel = vlNone) then
    LItem.UpdateItem;
  end;
end;

procedure TElXCellStyleAncestor.SetFontSize(newValue: integer);
begin
  if FFont.Size = newValue then
    Exit;
  FIsUpdating := True;
  FFont.Size := newValue;
  FIsUpdating := False;
  if FDrawStyle = elhsText then
    ColumnSizeUpdate;
  DoChangeEvent;
end;

function TElXCellStyleAncestor.GetFontStyles: TFontStyles;
begin
  Result := FFont.Style;
end;

procedure TElXCellStyleAncestor.SetFontStyles(newValue: TFontStyles);
var
  LOldIsUpdating: Boolean;
begin
  if FFont.Style = newValue then
    Exit;

  LOldIsUpdating := FIsUpdating;
  FIsUpdating := True;
  FFont.Style := newValue;
  FIsUpdating := LOldIsUpdating;
  if FDrawStyle = elhsText then
    ColumnSizeUpdate;
  DoChangeEvent;
end;

function TElXCellStyleAncestor.GetFontName: TFontName;
begin
  Result := FFont.Name;
end;

procedure TElXCellStyleAncestor.SetFontName(newValue: TFontName);
var
  LOldIsUpdating: Boolean;
begin
  if FFont.Name = newValue then
    Exit;

  LOldIsUpdating := FIsUpdating;
  FIsUpdating := True;
  FFont.Name := newValue;
  FIsUpdating := LOldIsUpdating;
  if FDrawStyle = elhsText then
    ColumnSizeUpdate;
  DoChangeEvent;
end;

procedure TElXCellStyleAncestor.Assign(Source: TPersistent);
begin
  if Assigned(Source) and (Source is TElXCellStyleAncestor) then
  begin
    FTag := TElXCellStyleAncestor(Source).FTag;
    FBorderStyle := TElXCellStyleAncestor(Source).FBorderStyle;
    FBorderSides := TElXCellStyleAncestor(Source).FBorderSides;
    FTextAlignment := TElXCellStyleAncestor(Source).FTextAlignment;
    FBorderSpaceColor := TElXCellStyleAncestor(Source).FBorderSpaceColor;
    FStrikedLineColor := TElXCellStyleAncestor(Source).FStrikedLineColor;
    FStrikedOutLine := TElXCellStyleAncestor(Source).FStrikedOutLine;

    FParentColors := TElXCellStyleAncestor(Source).FParentColors;
    FUseBackGroundColor  := TElXCellStyleAncestor(Source).FUseBackGroundColor;
    FCellBackGroundColor := TElXCellStyleAncestor(Source).FCellBackGroundColor;
    FTextBackGroundColor := TElXCellStyleAncestor(Source).FTextBackGroundColor;
    FTextFlags := TElXCellStyleAncestor(Source).FTextFlags;
    FCellType := TElXCellStyleAncestor(Source).FCellType;
    FDrawStyle := TElXCellStyleAncestor(Source).FDrawStyle;
    if TElXCellStyleAncestor(Source).FControl <> nil then
    begin
      if FControl <> nil then
        FreeAndNil(FControl);
      if TElXCellStyleAncestor(Source).FControl is TElXCellCheckBox then
        FControl := TElXCellCheckBox.Create;
      if TElXCellStyleAncestor(Source).FControl is TElXCellButton then
        FControl := TElXCellButton.Create;
      if TElXCellStyleAncestor(Source).FControl is TElXCellProgressBar then
        FControl := TElXCellProgressBar.Create;
      FControl.Assign(TElXCellStyleAncestor(Source).FControl);
    end;
    //FOwnerProps := TElXCellStyleAncestor(Source).FOwnerProps;
    FFont.Color := TElXCellStyleAncestor(Source).FFont.Color;
    FFont.Size := TElXCellStyleAncestor(Source).FFont.Size;
    FFont.Style := TElXCellStyleAncestor(Source).FFont.Style;
    FFont.Name := TElXCellStyleAncestor(Source).FFont.Name;
    FState := TElXCellStyleAncestor(Source).FState;
  end
  else
    inherited Assign(Source);
end;

procedure TElXCellStyleAncestor.WriteToStream(Stream: TStream);
var
  SI: TStyleInfo;
  b: Boolean;
  s: AnsiString;
begin
  b:= false;
  if Assigned(FItem) and (FItem is TElXTreeItem) then
  begin
  b := Assigned(THCustomElXTree(TElXTreeItem(FItem).TreeView).FOnSave);
  end;
  Stream.WriteBuffer(b, sizeof(b));
  if b then
     THCustomElXTree(TElXTreeItem(FItem).TreeView).FOnSave(FItem, Stream, Self)
     else
  begin
    LMDAnsiWriteStringToStream(Stream, AnsiString(FFont.Name));

    SI.FCellBackGroundColor := FCellBackGroundColor;
    SI.FTextBackGroundColor := FTextBackGroundColor;
    SI.FTextColor := FFont.Color;
    SI.FTextFlags := FTextFlags;
    SI.FCellType := FCellType;
    SI.FDrawStyle := FDrawStyle;
    SI.FFontSize := FFont.Size;
    SI.FFontStyles := FFont.Style;
    SI.FTag := FTag;
    SI.FUseBackGroundColor := FUseBackGroundColor;
    SI.FBorderStyle := FBorderStyle;
    SI.FTextAlignment := FTextAlignment;
    SI.FBorderSpaceColor := FBorderSpaceColor;
    SI.FBorderSides := FBorderSides;
    SI.FStrikedLineColor := FStrikedLineColor;
    SI.FStrikedOutLine := FStrikedOutLine;
    SI.FParentColors := FParentColors;
    SI.FState := FState;
//    SI.FControl := FControl;
    Stream.WriteBuffer(SI, sizeof(TStyleInfo));
    b := Assigned(FControl);
    Stream.WriteBuffer(b, sizeof(b));
    if b then
    begin
      s := AnsiString(FControl.ClassName);
      LMDAnsiWriteStringToStream(Stream, s);
      Stream.WriteComponent(FControl);
    end;
  end;
end;

procedure TElXCellStyleAncestor.LoadFromStream(Stream: TStream);
var
  SI: TStyleInfo;
  b: Boolean;
  s: AnsiString;
  LOldIsUpdating: Boolean;
begin
  Stream.ReadBuffer(b, sizeof(b));
  if b then
  begin
    if Assigned(FItem) and (FItem is TElXTreeItem) and
      Assigned(THCustomElXTree(TElXTreeItem(FItem).TreeView).FOnLoad)
    then
     THCustomElXTree(TElXTreeItem(FItem).TreeView).FOnLoad(FItem, Stream, Self)
      end
  else
  begin
    LOldIsUpdating := FIsUpdating;
    FIsUpdating := True;
    LMDAnsiReadStringFromStream(Stream, s);
    FFont.Name := String(s);
    Stream.ReadBuffer(SI, sizeof(TStyleInfo));
    //    IsUpdating := True;
    FCellBackGroundColor := SI.FCellBackGroundColor;
    FTextBackGroundColor := SI.FTextBackGroundColor;
    FFont.Color := SI.FTextColor;
    FTextFlags := SI.FTextFlags;
    FCellType := SI.FCellType;
    FDrawStyle := SI.FDrawStyle;
    FFont.Size := SI.FFontSize;
    FFont.Style := SI.FFontStyles;
    FTag := SI.FTag;
    FUseBackGroundColor := SI.FUseBackGroundColor;
    FBorderStyle := SI.FBorderStyle;
    FTextAlignment := SI.FTextAlignment;
    FBorderSpaceColor := SI.FBorderSpaceColor;
    FBorderSides := SI.FBorderSides;
    FStrikedLineColor := SI.FStrikedLineColor;
    FStrikedOutLine := SI.FStrikedOutLine;
    FParentColors := SI.FParentColors;
    FState := SI.FState;

    Stream.ReadBuffer(b, sizeof(b));
    if b then
    begin
      LMDAnsiReadStringFromStream(Stream, s);
      if not Assigned(FControl) then
      begin
        if s = 'TElXCellProgressBar' then
          FControl := TElXCellProgressBar.Create;
        if s = 'TElXCellButton' then
          FControl := TElXCellButton.Create;
        if s = 'TElXCellCheckBox' then
          FControl := TElXCellCheckBox.Create;
        if not Assigned(FControl) then
          FControl := TElXCellControl.Create;
        Stream.ReadComponent(FControl);
        FControl.FOwner := Self;
      end;
    end;
    FIsUpdating := LOldIsUpdating;
  end;
end;

procedure TElXCellStyleAncestor.SetControl(newValue: TElXCellControl);
var
  LItem: TElXTreeItem;
  HOwner: THCustomElXTree;
//  LControl: TElXCellControl;
begin
  if (FControl <> newValue) then
  begin
    if Assigned(FControl) then begin
      LItem := TElXTreeItem(FItem);
      if Assigned(LItem) and Assigned(LItem.Owner) and
      (THCustomElXTree(LItem.Owner).VirtualityLevel = vlNone)
      then
        FControl.Destroy;
    end;
    FControl := newValue;
    if Assigned(FControl) then
    begin
      (FControl as TElXCellControl).FOwner := Self;
      LItem := TElXTreeItem(FItem);
      if Assigned(LItem) and Assigned(LItem.Owner) then
      begin
        HOwner := THCustomElXTree(LItem.Owner);
        if HOwner.VirtualityLevel = vlNone then
        begin
          FControl.OnClick := HOwner.DoOnCtlClick;
          FControl.OnDblClick := HOwner.DoOnCtlDblClick;
          FControl.OnMouseDown := HOwner.DoOnCtlMouseDown;
          FControl.OnMouseMove := HOwner.DoOnCtlMouseMove;
          FControl.OnMouseUp := HOwner.DoOnCtlMouseUp;
        end;
      end;
    end;
    if not FIsUpdating then
      Update;
  end;
end;

procedure TElXCellStyleAncestor.Update; { public }
var
  LItem: TElXTreeItem;
begin
  LItem := TElXTreeItem(FItem);
  FIsUpdating := False;
  if Assigned(LItem) then
    LItem.RedrawItem(true);
end; { Update }

procedure TElXCellStyleAncestor.SetUseBackGroundColor(Value: Boolean);
var
  LItem: TElXTreeItem;
begin
  if FUseBackGroundColor <> Value then
  begin
    FUseBackGroundColor := Value;
    LItem := TElXTreeItem(FItem);
    if not FIsUpdating and Assigned(LItem) and
    (THCustomElXTree(LItem.Owner).VirtualityLevel = vlNone)
    then
      LItem.UpdateItem;
    DoChangeEvent;
  end;
end;

//function TElXCustomTreeCell.GetUseBackGroundColor: Boolean;
//begin
//  if Assigned(FOwnStyle) then
//    Result := FOwnStyle.UseBackGroundColor
//  else
//    Result := Style.UseBackGroundColor;
//end;

procedure TElXCellStyleAncestor.SetBorderStyle(Value: TElItemBorderStyle);
var
  LItem: TElXTreeItem;
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    LItem := TElXTreeItem(FItem);
    if not FIsUpdating and Assigned(LItem) and
    (THCustomElXTree(LItem.Owner).VirtualityLevel = vlNone)
    then
      LItem.UpdateItem;
    DoChangeEvent;
  end;
end;

// ****************************************************************************
//                            TElXCellControl
// ****************************************************************************

procedure TElXCellControl.Update;
begin
  if Visible and Assigned(Owner) then
    Owner.Update;
end;

constructor TElXCellControl.Create;
begin
  inherited Create(nil);
  FVisible := true;
  FEnabled := true;
  FFont := TFont.Create;
  FFont.Color := clBtnText;
  FFont.OnChange := FontChanged;
end;

destructor TElXCellControl.Destroy;
begin
  FFont.Free;
  if Assigned(Owner) {and not (csDestroying in ComponentState)} then
  begin
    Owner.FControl := nil;
    if not (csDestroying in ComponentState) then
      Owner.Update;
  end;
  inherited;
end;

procedure TElXCellControl.SetCaption(newValue: TLMDString);
{ Sets data member FCaption to newValue. }
begin
  if (FCaption <> newValue) then
  begin
    FCaption := newValue;
    if Visible then Update;
  end; { if }
end; { SetCaption }

procedure TElXCellControl.TriggerClickEvent;
begin
  if (assigned(FOnClick)) then FOnClick(Self);
end; { TriggerClickEvent }

procedure TElXCellControl.TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (assigned(FOnMouseDown)) then
    FOnMouseDown(Self, Button, Shift, X, Y);
end; { TriggerMouseDownEvent }

procedure TElXCellControl.TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (assigned(FOnMouseUp)) then
    FOnMouseUp(Self, Button, Shift, X, Y);
end; { TriggerMouseUpEvent }

procedure TElXCellControl.TriggerDblClickEvent;
begin
  if (assigned(FOnDblClick)) then
    FOnDblClick(Self);
end; { TriggerDblClickEvent }

procedure TElXCellControl.TriggerMouseMoveEvent(Shift: TShiftState; X, Y: Integer);
begin
  if (assigned(FOnMouseMove)) then
    FOnMouseMove(Self, Shift, X, Y);
end; { TriggerMouseMoveEvent }
(*
procedure TElXCellControl.SetBoundsRect(newValue : TRect);
begin
  if not EqualRect(FBoundsRect, newValue) then
  begin
    FBoundsRect := newValue;
    if Visible then Update;
  end;  { if }
end;  { SetBoundsRect }
*)

procedure TElXCellControl.SetVisible(newValue: Boolean);
begin
  if (FVisible <> newValue) then
  begin
    FVisible := newValue;
    //if not newValue then FBoundsRect := Rect(0, 0, 0, 0);
    Update;
  end; {if}
end;

procedure TElXCellControl.SetEnabled(newValue: Boolean);
begin
  if (FEnabled <> newValue) then
  begin
    FEnabled := newValue;
    Update;
  end; {if}
end; {SetEnabled}

procedure TElXCellControl.SetPopupMenu(newValue: TPopupMenu);
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

procedure TElXCellControl.Notification(AComponent: TComponent; Operation:
  TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FPopupMenu) then FPopupMenu := nil;
end;

procedure TElXCellControl.SetBorderWidth(Value: Integer);
begin
  if FBorderWidth <> Value then
  begin
    FBorderWidth := Value;
    Update;
  end;
end;

function TElXCellControl.PassClicks: Boolean;
begin
  Result := false;
end;

procedure TElXCellControl.SetControlActive;
begin
end;

procedure TElXCellControl.FontChanged(Sender: TObject);
begin
  Update;
end;

procedure TElXCellControl.SetFont(newValue: TFont);
begin
  FFont.Assign(newValue);
end;

procedure TElXCellControl.Assign(Source: TElXCellControl);
begin
  if Source <> nil then
  begin
    Self.FCaption := Source.Caption;
    Self.FVisible := Source.Visible;
    Self.FEnabled := Source.Enabled;
    Self.FBorderWidth := Source.BorderWidth;
  end;
end;

procedure TElXCellControl.Paint(ACell: TElXCustomTreeCell; Canvas: TCanvas; Rect: TRect);
begin
// nothing to do
end;

{procedure TElXCellControl.SetSelected(const ASelected: Boolean);
var
  LItem: TElXTreeItem;
begin
  if FSelected = ASelected then
    Exit;
  FSelected := ASelected;
  if not Assigned(Owner) then
    Exit;
  LItem := (Owner.Owner as TElXTreeItem);
  if not Assigned(LItem) then
    Exit;
  if not Assigned(LItem.Owner) then
    Exit;
  with LItem.Owner do
    if not IsUpdating then
      Refresh;
end;}

// ****************************************************************************
//                              TElXCellCheckBox
// ****************************************************************************

procedure TElXCellCheckBox.SetState(newValue : TCheckBoxState);
begin
  if FState <> newValue then
  begin
    if (newValue = cbGrayed) and not FAllowGrayed then exit;
    FState := newValue;
    Update;
  end;
end;

procedure TElXCellCheckBox.SetAllowGrayed(newValue : Boolean);
begin
  if not newValue and (FState = cbGrayed) then
    State := cbUnchecked;
  FAllowGrayed := newValue;
end;

function TElXCellCheckBox.GetChecked : Boolean;
begin
  Result := FState = cbChecked;
end;

procedure TElXCellCheckBox.SetChecked(newValue : Boolean);
begin
  if newValue then
    State := cbChecked
  else
    State := cbUnchecked;
end;

procedure TElXCellCheckBox.SetAlignment(newValue : TAlignment);
begin
 if (FAlignment <> newValue) then
  begin
    FAlignment := newValue;
    Update;
  end;
end;

procedure TElXCellCheckBox.SetCheckBoxType(newValue: TElCheckBoxType);
begin
  if FCheckBoxType <> newValue then
  begin
    FCheckBoxType := newValue;
    Update;
  end;
end;

procedure TElXCellCheckBox.Paint(ACell: TElXCustomTreeCell; Canvas: TCanvas; R: TRect);
var
  LTree: THCustomElXTree;
  LItem: TElXTreeItem;

  function DrawThemedTree(var ARect:TRect):Boolean;
  var
    cbh, ch,
    cw, cbw : integer;
    CheckRect : TRect;
    LDetail: TThemedButton;
    LThemeMode: TLMDThemeMode;
  begin
    LThemeMode :=  ttmPlatform;
    Result := LMDThemeServices.ThemesEnabled;
    if not Result then
      Exit;
    if FCheckBoxType = ectRadioButton then
      case State of
        cbUnchecked: LDetail := tbRadioButtonUncheckedNormal;
        cbChecked:   LDetail := tbRadioButtonCheckedNormal;
        else         LDetail := tbRadioButtonUncheckedDisabled;
      end
    else
      case State of
        cbUnchecked: LDetail := tbCheckBoxUncheckedNormal;
        cbChecked:   LDetail := tbCheckBoxCheckedNormal;
        else         LDetail := tbCheckBoxMixedNormal;
      end;

    cbw := LTree.CheckBoxSize;
    cbh := cbw;

    ch := R.Bottom - R.Top + 1;
    cw := R.Right + 1;

    if (Alignment = taRightJustify) xor LTree.RightAlignedText then
      CheckRect := Rect(R.Left + CheckMargin, R.Top + (ch shr 1 - cbh shr 1), R.Left + CheckMargin + cbw, R.Top + (ch shr 1 + cbh - cbh shr 1))
    else if (Alignment = taRightJustify) or LTree.RightAlignedText then (*<+>*)
      CheckRect := Rect(cw - 2*CheckMargin - cbw, R.Top + (ch shr 1 - cbh shr 1), cw - CheckMargin, R.Top + (ch shr 1 + cbh - cbh shr 1))
    else if Alignment = taCenter then
      CheckRect := Rect((R.Left + R.Right - cbw) shr 1 - 1 , R.Top + (ch shr 1 - cbh shr 1), (R.Left + R.Right - cbw) shr 1 + cbw, R.Top + (ch shr 1 + cbh - cbh shr 1));

    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, CheckRect, LMDRectToPtr(R));

    if (Alignment = taRightJustify) xor LTree.RightAlignedText then
      ARect.Left := ARect.Left + cbw + CheckMargin * 2
    else
      ARect.Right := ARect.Right - cbw - CheckMargin * 2;
    Canvas.Brush.Style := bsClear;
    InflateRect(ARect, -1, -1);

    LMDThemeServices.DrawThemeText(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail), Caption, Length(Caption),DT_SINGLELINE or DT_LEFT or DT_VCENTER, 0, ARect);

    Result := True;
  end;

  procedure GetGlyphDrawData(const FGlyph: TBitmap;
    var SrcRect:TRect; var cbh, cbw, StateDrawFlags:Integer);
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
    StateDrawFlags := 0;
  end;

  procedure GetDrawData(var cbh, cbw, StateDrawFlags:Integer);
  begin
    cbw := CheckBoxSize;
    cbh := CheckBoxSize;
    if FCheckBoxType = ectRadioButton then
      StateDrawFlags := DFCS_BUTTONRADIO
    else
      StateDrawFlags := DFCS_BUTTONCHECK;
    if Enabled then
      case State of
        cbChecked : StateDrawFlags := StateDrawFlags or DFCS_CHECKED;
//        cbUnchecked : StateDrawFlags := DFCS_BUTTONCHECK;
        cbGrayed : StateDrawFlags := StateDrawFlags or DFCS_CHECKED;
      end
    else
      StateDrawFlags := StateDrawFlags or DFCS_INACTIVE;
  end;

  procedure DrawDisabledCaption(var ARect:TRect);
  begin
    OffsetRect(ARect, 1, 1);
    Canvas.Font.Color := clBtnHighlight;
    LMDDrawText(Canvas.Handle, Caption, Length(Caption), ARect, DT_SINGLELINE or DT_LEFT or DT_VCENTER);
    Canvas.Font.Color := clBtnShadow;
    OffsetRect(ARect, -1, -1);
    LMDDrawText(Canvas.Handle, Caption, Length(Caption), ARect, DT_SINGLELINE or DT_LEFT or DT_VCENTER);
  end;

  procedure DrawEnabledCaption(var ARect:TRect);
  begin
    // Canvas.Font.Color := FTree.TextColor;

    if ACell.Selected then
    begin
      if not LTree.BarStyle
        and (LItem.CurrentStyle.BorderStyle = ibsNone)
        and (LTree.RowSelect or (LTree.SelectColumn = LTree.MainTreeColumn) and LTree.ShowColumns)
        // and (FTree.HighlightAlphaLevel = 255)
      then
      begin
        if LTree.View.HasFocus then
        begin
          if not (LTree.IsThemed and LTree.UseThemeForSelection and LMDSIWindowsVistaUp) then
            Canvas.Font.Color := LTree.FocusedSelectTextColor;
        end
        else if not LTree.HideSelection then
          Canvas.Font.Color := LTree.HideSelectTextColor;
        end;
    end;

  {$ifdef LMD_UNICODE}
      DrawTypedTextW(Canvas, ARect, Caption, DT_SINGLELINE or DT_LEFT or DT_VCENTER, tdtNormal);
    {$else}
      DrawTypedText(Canvas, ARect, Caption, DT_SINGLELINE or DT_LEFT or DT_VCENTER, tdtNormal);
    {$endif}
  end;

  procedure DrawCaption(var ARect:TRect);
  var
    AFont : TFont;
  begin
    Canvas.Brush.Style := bsClear;
    InflateRect(ARect, -1, -1);
    AFont := TFont.Create;
    AFont.Assign(Canvas.Font);
    Canvas.Font := Font;

    if not Enabled then
      DrawDisabledCaption(ARect)
    else
      DrawEnabledCaption(ARect);
    Canvas.Brush.Style := bsSolid;
    Canvas.Font := AFont;
    AFont.Free;
  end;

var
  ARect : TRect;
  CheckRect : TRect;
  SrcRect : TRect;
  StateDrawFlags : integer;
  ch, cw, cbh, cbw:Integer;
  FGlyph: TBitmap;
begin
  LItem := ACell.Owner as TElXTreeItem;
  LTree := THCustomElXTree(LItem.Owner);
  Inc(R.Right);
  Inc(R.Bottom);

  ARect  := R;
  if FCheckBoxType = ectRadioButton then
  FGlyph := LTree.RadioButtonGlyph
  else
    FGlyph := LTree.CheckBoxGlyph;
  if LTree.IsThemed then
    if DrawThemedTree(ARect) then Exit;
  if LTree.CustomCheckboxes and not FGlyph.Empty then
    GetGlyphDrawData(FGlyph, SrcRect, cbh, cbw, StateDrawFlags)
  else
    GetDrawData(cbh, cbw, StateDrawFlags);
  ch := R.Bottom - R.Top + 1;
  cw := R.Right {- R.Left} + 1;
  if (Alignment = taRightJustify) xor LTree.RightAlignedText then
    CheckRect := Rect(R.Left + CheckMargin, R.Top + (ch shr 1 - cbh shr 1), R.Left + CheckMargin + cbw, R.Top + (ch shr 1 + cbh - cbh shr 1))
  else if (Alignment = taRightJustify) or LTree.RightAlignedText then (*<+>*)
    CheckRect := Rect(cw - 2*CheckMargin - cbw, R.Top + (ch shr 1 - cbh shr 1), cw - CheckMargin, R.Top + (ch shr 1 + cbh - cbh shr 1))
  else if Alignment = taCenter then
    CheckRect := Rect((R.Left + R.Right - cbw) shr 1 - 1 , R.Top + (ch shr 1 - cbh shr 1), (R.Left + R.Right - cbw) shr 1 + cbw, R.Top + (ch shr 1 + cbh - cbh shr 1));
  if LTree.CustomCheckboxes and not FGlyph.Empty then
    Canvas.CopyRect(CheckRect, FGlyph.Canvas, SrcRect)
  else
  begin
    DrawFrameControl(Canvas.Handle, CheckRect, DFC_BUTTON, StateDrawFlags);
    if LTree.CheckBoxFlat then
      DrawFlatCheckboxFrame(LTree, Canvas.Handle, CheckRect, Enabled);
  end;
  if (Alignment = taRightJustify) xor LTree.RightAlignedText then
    ARect.Left := ARect.Left + cbw + CheckMargin * 2
  else
    ARect.Right := ARect.Right - cbw - CheckMargin * 2;
  if Caption <> '' then
    DrawCaption(ARect);
end; { Paint }

procedure TElXCellCheckBox.TriggerClickEvent;
var
  State : TCheckBoxState;
begin
  State := Self.State;
  if (FCheckBoxType = ectRadioButton) then
  begin
    case State of
      cbChecked : Checked := false;
      cbUnchecked : Checked := true;
    end;
  end
  else
    case State of
      cbChecked : Checked := false;
      cbGrayed : Checked := true;
      cbUnchecked :
        if AllowGrayed then Self.State := cbGrayed else Checked := true;
    end;
  inherited;
end;

procedure TElXCellCheckBox.TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
end;

procedure TElXCellCheckBox.TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
end;

procedure TElXCellCheckBox.Assign(Source: TElXCellControl);
begin
  if Source is TElXCellCheckBox then
  begin
    with Source as TElXCellCheckBox do
    begin
      Self.Alignment := Alignment;
      Self.AllowGrayed := AllowGrayed;
      Self.FState := State;
    end;
    inherited;
  end;
end;

constructor TElXCellCheckBox.Create;
begin
  inherited;
  Alignment := taRightJustify;
  FCheckBoxType := ect3SCheckBox;
end;

destructor TElXCellCheckBox.Destroy;
begin
  inherited;
end;

// ****************************************************************************
//                                   TElXCellButton
// ****************************************************************************

function TElXCellButton.GetGlyph: TBitmap;
begin
  Result := FGlyph.Glyph;
end; {GetGlyph}

procedure TElXCellButton.GlyphChanged(Sender: TObject);
begin
  Update;
end;

procedure TElXCellButton.SetGlyph(newValue: TBitmap);
begin
  FGlyph.Glyph := newValue;
  Update;
end; {SetGlyph}

procedure TElXCellButton.SetDown(newValue: Boolean);
begin
  if (FDown <> newValue) then
  begin
    FDown := newValue;
    Update;
  end; {if}
end; {SetDown}

procedure TElXCellButton.Assign(Source: TElXCellControl);
begin
  if Source is TElXCellButton then
  begin
    with Source as TElXCellButton do
    begin
      Self.Glyph := Glyph;
      Self.FFixClick := FixClick;
      Self.FDown := Down;
    end;
    inherited;
  end;
end;

procedure TElXCellButton.TriggerMouseDownEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if FFixClick then
    SetDown(not Down)
  else
    SetDown(True);
  inherited;
end;

procedure TElXCellButton.TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not FFixClick then
    SetDown(false);
  inherited;
end;

procedure TElXCellButton.Paint(ACell: TElXCustomTreeCell; Canvas: TCanvas; R: TRect);
  procedure DrawGlyph(AThemeMode: TLMDThemeMode; ADetails: TThemedElementDetails);
  var
    FBrush   : TBrush;
    FPen     : TPen;
    FSFont   : TFont;
    FState   : TLMDExButtonState;
  begin
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
    FGlyph.Draw(Canvas, R, Point(0, 0), Caption, FLayout, -1, -1, FState, FState, taCenter, FGlyph.Glyph.Transparent,
      Pos(#13#10, FCaption) > 0, false, true, true, 0, tdtNormal, clBtnFace,
      AThemeMode, ADetails, false, false, false, nil, true);
    Canvas.Font.Assign(FSFont);
    Canvas.Pen.Assign(FPen);
    Canvas.Brush.Assign(FBrush);
    FSFont.Free;
    FPen.Free;
    FBrush.Free;
  end;

  function DrawThemedButton:Boolean;
  var
    LDetails: TThemedElementDetails;
    LThemeMode: TLMDThemeMode;
  begin
    LThemeMode := ttmPlatform;;
    Result := LMDThemeServices.ThemesEnabled;
    if not Result then
      Exit;
    LDetails.Element := teButton;
    if FDown then
      LDetails.State := PBS_PRESSED
    else
      LDetails.State := PBS_NORMAL;
    LDetails.Part := BP_PUSHBUTTON;

    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetails, R, LMDRectToPtr(R));
    DrawGlyph(LThemeMode, LDetails);
  end;

var
  LTree: THCustomElXTree;
  LDrawFlags: Integer;
  LDetails: TThemedElementDetails;
begin
//  LItem := (ACell.Owner as TElXTreeItem);

  LTree := THCustomElXTree((ACell.Owner as TElXTreeItem).Owner);

  Dec(R.Right);
  Dec(R.Bottom);

  if LTree.IsThemed and DrawThemedButton() then
    Exit;

  LDrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
  if FDown then
    LDrawFlags := LDrawFlags or DFCS_PUSHED;
  DrawFrameControl(Canvas.Handle, R, DFC_BUTTON, LDrawFlags);
  InflateRect(R, 1, 1);
  DrawGlyph(ttmNone, LDetails);
end; {Paint}

procedure TElXCellButton.SetLayout(newValue: TButtonLayout);
begin
  if (FLayout <> newValue) then
  begin
    FLayout := newValue;
    Update;
  end;
end;

function TElXCellButton.GetUseImageList : Boolean;
begin
  Result := FGlyph.UseImageList;
end;

procedure TElXCellButton.SetUseImageList(newValue : Boolean);
begin
  if (FGlyph.UseImageList <> newValue) then
  begin
    FGlyph.UseImageList := newValue;
    Update;
  end;
end;

function TElXCellButton.GetImageList : TCustomImageList;
begin
  Result := FGlyph.ImageList;
end;

procedure TElXCellButton.SetImageList(newValue : TCustomImageList);
begin
  if (FGlyph.ImageList <> newValue) then
    begin
      if FGlyph.ImageList <> nil then
        if not (csDestroying in FGlyph.ImageList.ComponentState) then
          FGlyph.ImageList.RemoveFreeNotification(Self);
      FGlyph.ImageList := newValue;
      if FGlyph.ImageList <> nil then FGlyph.ImageList.FreeNotification(Self);
      if UseImageList then Update;
    end;
end;

function TElXCellButton.GetImageIndex : Integer;
begin
  Result := FGlyph.ImageIndex;
end;

procedure TElXCellButton.SetImageIndex(newValue : Integer);
begin
  if (FGlyph.ImageIndex <> newValue) then
  begin
    FGlyph.ImageIndex := newValue;
    if UseImageList then Update;
  end;  { if }
end;

destructor TElXCellButton.Destroy;
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

constructor TElXCellButton.Create;
begin
  inherited;
  FGlyph := TElXCellButtonGlyph.Create;
  FGlyph.OnChange := GlyphChanged;
  Inc(ButtonCount);
  FDown := False;
  FLayout := blGlyphLeft;
end; {Create}

constructor TElXCellProgressBar.Create;
begin
  inherited;
  FMaxValue := 100;
  FColor := clWindow;
  FBarColor := clHighlight;
  FFrameColor := clWindowText;
  FShowProgressText := true;
  FTextAlignment := taCenter;
end; {Create}

procedure TElXCellProgressBar.Assign(Source: TElXCellControl);
begin
  if Source is TElXCellProgressBar then
  begin
    with Source as TElXCellProgressBar do
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

procedure TElXCellProgressBar.Paint(ACell: TElXCustomTreeCell; Canvas: TCanvas; R: TRect);
var

  LTree: THCustomElXTree;

  LItem: TElXTreeItem;

  function SaveFont(const Src, NewFont:TFont):TFont;
  begin
    Result := TFont.Create;
    Result.Assign(Src);
    if Assigned(NewFont) then
      Src.Assign(NewFont);
  end;

  procedure RestoreFont(const Dst:TFont; var OldFont:TFont);
  begin
    Dst.Assign(OldFont);
    OldFont.Free;
    OldFont := nil;
  end;

  procedure DrawTextRect(var TextRect: TRect; const ACaption: TLMDString; AFlags: UINT);
  begin
    LMDDrawText(Canvas.Handle, ACaption, Length(ACaption), TextRect, AFlags);
  end;

  procedure DrawLeftOrRightAlignedText;
  var
    BarRect,
    TextRect : TRect;
    MCaption,
    ACaption  : TLMDString;
    LSaveFont: TFont;
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

    LSaveFont := SaveFont(Canvas.Font, Font);
    if ACell.Selected then
    begin
      if not LTree.BarStyle
        and (LItem.CurrentStyle.BorderStyle = ibsNone)

        and (LTree.RowSelect or (LTree.SelectColumn = LTree.MainTreeColumn) and LTree.ShowColumns)

        // and (LTree.HighlightAlphaLevel = 255)
      then
      begin
        if LTree.View.HasFocus then

        begin
          if not (LTree.IsThemed and LTree.UseThemeForSelection and LMDSIWindowsVistaUp) then
            Canvas.Font.Color := LTree.FocusedSelectTextColor;
        end
        else if not LTree.HideSelection then
          Canvas.Font.Color := LTree.HideSelectTextColor;

      end;
    end;
    DrawTextRect(TextRect, MCaption,
      DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_CALCRECT);
    if TextRect.Right - TextRect.Left < R.Right - R.Left then
    begin
      if (TextAlignment = taRightJustify) xor LTree.RightAlignedView then
      begin
        BarRect.Right  := R.Right - TextRect.Right - TextRect.Left - 2;
        TextRect.Left  := R.Right - TextRect.Right - TextRect.Left;
        TextRect.Right := R.Right;
      end
      else
      begin
        BarRect.Left   := R.Left + TextRect.Right - TextRect.Left + 2;
        TextRect.Right := R.Left + TextRect.Right - TextRect.Left;
        TextRect.Left  := R.Left;
      end;
      TextRect.Top := BarRect.Top;
      TextRect.Bottom := BarRect.Bottom;
      Canvas.Brush.Style := bsClear;
      DrawTextRect(TextRect, ACaption, DT_SINGLELINE or DT_LEFT or DT_VCENTER);
    end;
    RestoreFont(Canvas.Font, LSaveFont);
  end;

  procedure DrawCenterAlignedText();
  var
    TextRect : TRect;
    ACaption  : TLMDString;
    LSaveFont: TFont;
  begin
    SetRectEmpty(TextRect);
    LSaveFont := SaveFont(Canvas.Font, Font);

    (*
    if LItem.Selected then
    begin
      if ((not LTree.FBarStyle) and (LItem.BorderStyle = ibsNone)) and
         (((LTree.FSelectColumn = LTree.FMainTreeColumn) and (LTree.ShowColumns)) or
           LTree.FRowSelect) {and (FTree.HighlightAlphaLevel = 255)} then
      begin
        if LTree.FView.FHasFocus then
          Canvas.Font.Color := LTree.FFocusedSelectTextColor
        else
        if not LTree.HideSelection then
          Canvas.Font.Color := LTree.FHideSelectTextColor;
      end;
    end;
    *)

    if ShowProgressText then
      ACaption := IntToStr(MulDiv(Value , 100, (MaxValue - MinValue))) + '%'
    else
      ACaption := Caption;

    DrawTextRect(TextRect, ACaption,
    DT_SINGLELINE or DT_LEFT or DT_VCENTER or DT_CALCRECT);
    if TextRect.Right - TextRect.Left < R.Right - R.Left then
    begin
      Canvas.Brush.Style := bsClear;
      TextRect := R;
      DrawTextRect(TextRect, ACaption,
      DT_SINGLELINE or DT_CENTER or DT_VCENTER);
      end;
    RestoreFont(Canvas.Font, LSaveFont);
  end;

var
  BrushColor: TColor;
  PenColor: TColor;
  FillRect: TRect;
  BarRect: TRect;
begin
  Inc(R.Left);
  Dec(R.Right);
  Dec(R.Bottom);

  BarRect := R;
  LItem := ACell.Owner as TElXTreeItem;
  LTree := THCustomElXTree(LItem.Owner);
  if (ShowProgressText or (Caption <> '')) and (TextAlignment in [taLeftJustify, taRightJustify]) then
    DrawLeftOrRightAlignedText();

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
      if not LTree.RightAlignedView then
      begin
        FillRect.Left := BarRect.Left;
        FillRect.Right := min(BarRect.Right - 1, FillRect.Left + MulDiv(BarRect.Right - BarRect.Left, Value, MaxValue - MinValue));
        InflateRect(FillRect, -1, -1);
        Inc(FillRect.Right);
      end
      else
      begin
        FillRect.Right := BarRect.Right;
        FillRect.Left := max(BarRect.Left - 1, FillRect.Right - MulDiv(BarRect.Right - BarRect.Left, Value, MaxValue - MinValue));
        InflateRect(FillRect, -1, -1);
        Dec(FillRect.Left);
      end;
      Canvas.Brush.Color := BarColor;
      Canvas.FillRect(FillRect);
    end;
    Canvas.Brush.Color := BrushColor;
    Canvas.Pen.Color := PenColor;

    if (ShowProgressText or (Caption <> '')) and (TextAlignment = taCenter) then
      DrawCenterAlignedText();
  end;
end; {Paint}

procedure TElXCellProgressBar.SetMinValue(Value: Integer);
begin
  if FMinValue <> Value then
  begin
    FMinValue := Value;
    Update;
  end;
end;

procedure TElXCellProgressBar.SetMaxValue(Value: Integer);
begin
  if FMaxValue <> Value then
  begin
    FMaxValue := Value;
    Update;
  end;
end;

procedure TElXCellProgressBar.SetValue(Value: Integer);
begin
  if FValue <> Value then
  begin
    FValue := Min(Max(MinValue, Value), MaxValue);
    Update;
  end;
end;

procedure TElXCellProgressBar.SetBarColor(Value: TColor);
begin
  if FBarColor <> Value then
  begin
    FBarColor := Value;
    Update;
  end;
end;

procedure TElXCellProgressBar.SetShowProgressText(Value: Boolean);
begin
  if FShowProgressText <> Value then
  begin
    FShowProgressText := Value;
    Update;
  end;
end;

procedure TElXCellProgressBar.SetTextAlignment(Value: TAlignment);
begin
  if FTextAlignment <> Value then
  begin
    FTextAlignment := Value;
    Update;
  end;
end;

procedure TElXCellProgressBar.SetFrameColor(Value: TColor);
begin
  if FFrameColor <> Value then
  begin
    FFrameColor := Value;
    Update;
  end;
end;

procedure TElXCellProgressBar.SetColor(Value: TColor);
begin
  if FColor <> Value then
  begin
    FColor := Value;
    Update;
  end;
end;

function TElXCellProgressBar.PassClicks: Boolean;
begin
  Result := true;
end;

{ TElXCustomTreeCell }

constructor TElXCustomTreeCell.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FSelected := False;

  FUserText := False;
  FUseOwnStyle := false;
  FHTMLControlsVisible := true;
end;

procedure TElXCustomTreeCell.PictureOutput(const ACanvas: TCanvas; const ARect: TRect);
var
  LRTmp: TRect;
  LPictureH: Integer;
  LPictureW: Integer;
begin
  LPictureH := FPicture.Height;
  LPictureW := FPicture.Width;
  LRTmp := Rect(Max(ARect.Left, ((ARect.Left + ARect.Right) shr 1)-(LPictureW shr 1)),
    ARect.Top + ((ARect.Bottom - ARect.Top + 1) shr 1) - (LPictureH shr 1),
    Min(ARect.Right, ((ARect.Left + ARect.Right) shr 1)-(LPictureW shr 1) + LPictureW),
    ARect.Top + ((ARect.Bottom - ARect.Top + 1) shr 1) - (LPictureH shr 1) + LPictureH
  );
  if FPicture.Transparent then
    DrawTransparentBitmapEx(ACanvas.Handle, FPicture,
      LRTmp.Left, LRTmp.Top,
      Rect(0, 0,
        min(LPictureW, Min(ARect.Right, ARect.Left + LPictureW - 1) - ARect.Left + 1),
        LPictureH),
      FPicture.TransparentColor
    )
  else
    ACanvas.CopyRect(LRTmp, FPicture.Canvas,
      Rect(0, 0, min(LPictureW, Min(ARect.Right, ARect.Left + LPictureW - 1) - ARect.Left + 1),
      LPictureH)
    );
  if Index = TElXTree(TElXTreeItem(FOwner).Owner).MainTreeColumn then
    THElXTreeItem(TElXTreeItem(FOwner)).FTextRect := LRTmp;
  end;

procedure TElXCustomTreeCell.TreeLinesOffsetRect(var R: TRect);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  if LItem.IndentAdjust <> 0 then
  begin
    if LTree.RightAlignedView then
    Dec(R.Right, LItem.IndentAdjust)
    else
      Inc(R.Left, LItem.IndentAdjust);
  end;
  if LTree.RightAlignedView then
  begin
    if (LTree.ShowRoot and LTree.ShowLines) or (LTree.ShowButtons and LTree.ShowRootButtons) then
      Dec(R.Right, LTree.ItemIndent)
    else
      Dec(R.Right, LTree.ItemIndent div 5);
  end
  else
  begin
    if (LTree.ShowRoot and LTree.ShowLines) or (LTree.ShowButtons and LTree.ShowRootButtons) then
      Inc(R.Left, LTree.ItemIndent)
    else
      Inc(R.Left, LTree.ItemIndent div 5);
  end;
  if R.Left > R.Right then
    R.Left := R.Right;
end;

procedure DrawCellFrame(Cell: TElXCustomTreeCell; const ACanvas: TCanvas; const ARect: TRect; grfFlags: UINT; IsDot: Boolean = False; CheckMaster: Boolean = False);
  procedure DrawLine(Canvas: TCanvas; StartX, StartY, EndX, EndY: integer);
  var
    Coord: Integer;
  begin
    Coord := (StartX and 1) xor (StartY and 1);
    if StartX = EndX then
    begin
      // draw vertical Line
      Inc(Coord, StartY);
      while Coord < EndY do
      begin
        Canvas.MoveTo(StartX, Coord);
        Inc(Coord, 1);
        Canvas.LineTo(StartX, Coord);
        Inc(Coord, 1);
      end;
    end
    else
    begin
      // draw horizontal Line
      Inc(Coord, StartX);
      while Coord < EndX do
      begin
        Canvas.MoveTo(Coord, StartY);
        Inc(Coord, 1);
        Canvas.LineTo(Coord, StartY);
        Inc(Coord, 1);
      end;
    end;
  end;
var
  LItem: TElXTreeItem;
  X: Integer;
begin
  LItem := TElXTreeItem(Cell.FOwner);
  if (grfFlags and BF_LEFT) <> 0 then
    begin
      X := ARect.Top;
      if CheckMaster and (Cell.JointCellRole = jcrMaster) and LMDInRange(Cell.Index, 1, LItem.Cells.Count - 1) then
      begin
        if LItem.Cells[Cell.index - 1].Height < Cell.Height then
          X := ARect.Top + LItem.Cells[Cell.index - 1].Height - 1
        else
          X := ARect.Bottom;
      end;
      ACanvas.MoveTo(ARect.Left, X);
      if IsDot then
        DrawLine(ACanvas, ARect.Left, X, ARect.Left, ARect.Bottom - 1)
      else
        ACanvas.LineTo(ARect.Left, ARect.Bottom - 1);
    end;
  if (grfFlags and BF_TOP) <> 0 then
    begin
      ACanvas.MoveTo(ARect.Left, ARect.Top );
      if IsDot then
        DrawLine(ACanvas, ARect.Left, ARect.Top, ARect.Right, ARect.Top)
      else
        ACanvas.LineTo(ARect.Right,ARect.Top );
    end;
  if (grfFlags and BF_RIGHT) <> 0 then
    begin
      X := ARect.Top;
      if CheckMaster and (Cell.JointCellRole = jcrMaster) and LMDInRange(Cell.Index, 1, LItem.Cells.Count - 2) then
      begin
        if LItem.Cells[Cell.index + 1].Height < Cell.Height then
          X := ARect.Top + LItem.Cells[Cell.index + 1].Height - 1
        else
          X := ARect.Bottom;
      end;
      ACanvas.MoveTo(ARect.Right - 1, X );
      if IsDot then
        DrawLine(ACanvas, ARect.Right - 1, X, ARect.Right - 1, ARect.Bottom - 1)
      else
        ACanvas.LineTo(ARect.Right - 1, ARect.Bottom - 1);
    end;
  if (grfFlags and BF_BOTTOM) <> 0 then
    begin
      ACanvas.MoveTo(ARect.Left, ARect.Bottom - 1);
      if IsDot then
        DrawLine(ACanvas, ARect.Left, ARect.Bottom - 1, ARect.Right, ARect.Bottom - 1)
      else
        ACanvas.LineTo(ARect.Right,ARect.Bottom - 1);
    end;
end;

procedure TElXCustomTreeCell.DrawCellBorders(const ACanvas: TCanvas; const ARect: TRect);
  procedure DrawMasterBorder(LItem: TElXTreeItem; BS, frFlags: Integer; LRect: TRect);
  var
    TmpRect: TRect;
  begin
    if LItem.Cells[index - 1].Height < Height then
    begin
      TmpRect := LRect;
      Dec(TmpRect.Bottom);
      TmpRect.Top := LRect.Top + LItem.Cells[index - 1].Height - 1;
      DrawEdge(ACanvas.Handle, TMPRect, BS, BF_LEFT);
    end;
    if LItem.Cells[index + 1].Height < Height then
    begin
      TmpRect := LRect;
      Dec(TmpRect.Bottom);
      TmpRect.Top := LRect.Top + LItem.Cells[index + 1].Height - 1;
      DrawEdge(ACanvas.Handle, TMPRect, BS, BF_RIGHT);
    end;
  end;
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LRect: TRect;
  frFlags, BS: Cardinal;
begin
  LItem := TElXTreeItem(FOwner);
  if Assigned(LItem) then
  LTree := TElXTree(LItem.Owner)
  else
    LTree := nil;
  LRect := ARect;
  bs := 0;
  if LTree.BarStyle then
  begin
    frFlags := (BF_TOP or BF_BOTTOM);
    if LTree.BarStyleVerticalLines then
    frFlags := frFlags or BF_LEFT or BF_RIGHT;
    if Index = 0 then
      frFlags := frFlags or BF_LEFT;
    if Index = LItem.Cells.Count - 1 then
      frFlags := frFlags or BF_RIGHT;
    if LTree.BarStyleNotRaise then
    begin
      if LItem.Selected then
        BS := BDR_SUNKENOUTER;
    end
    else
    begin
      if not LItem.Selected then
        BS := BDR_RAISEDINNER
      else
        BS := BDR_SUNKENOUTER;
    end;
    DrawEdge(ACanvas.Handle, LRect, BS, frFlags);
    if (JointCellRole = jcrMaster) and LMDInRange(Index, 1, LItem.Cells.Count - 2) then
    begin
      DrawMasterBorder(LItem, BS, frFlags, LRect);
    end;
  end
  else
  begin
    if (LItem.CurrentStyle.BorderStyle <> ibsNone) then
    begin
      LRect := ARect;
      frFlags := 0;
      if (Index = 0) and (ebsLeft in LItem.CurrentStyle.BorderSides) then
        frFlags := frFlags or BF_LEFT;
      if (Index = LItem.Cells.Count - 1) and (ebsRight in LItem.CurrentStyle.BorderSides) then
        frFlags := frFlags or BF_RIGHT;
      if (ebsTop in LItem.CurrentStyle.BorderSides) then
        frFlags := frFlags or BF_TOP;
      if (ebsBottom in LItem.CurrentStyle.BorderSides) then
        frFlags := frFlags or BF_BOTTOM;
      case LItem.CurrentStyle.BorderStyle of
        ibsRaised:
        begin
//          Dec(LRect.Bottom);
          DrawEdge(ACanvas.Handle, LRect, BDR_RAISEDINNER, frFlags);
          if (JointCellRole = jcrMaster) and LMDInRange(Index, 1,LItem.Cells.Count - 2) then
          begin
            DrawMasterBorder(LItem, BDR_RAISEDINNER, frFlags, LRect);
          end;
        end;
        ibsFlat:
        begin
//          Dec(LRect.Bottom);
          DrawEdge(ACanvas.Handle, LRect, BDR_SUNKENOUTER, BF_FLAT or frFlags);
          if (JointCellRole = jcrMaster) and LMDInRange(Index, 1, LItem.Cells.Count - 2) then
          begin
            DrawMasterBorder(LItem, BDR_SUNKENOUTER, BF_FLAT or frFlags, LRect);
          end;
        end;
        ibsSunken:
        begin
//          Dec(LRect.Bottom);
          DrawEdge(ACanvas.Handle, LRect, BDR_SUNKENOUTER, frFlags);
          if (JointCellRole = jcrMaster) and LMDInRange(Index, 1, LItem.Cells.Count - 2) then
          begin
            DrawMasterBorder(LItem, BDR_SUNKENOUTER, frFlags, LRect);
          end;
        end;
        ibsSpace:
          begin
//            Dec(LRect.Top);
//            Dec(LRect.Bottom);
            ACanvas.Pen.Color := LItem.CurrentStyle.BorderSpaceColor;
            if JointCellRole = jcrMaster then
            begin
              if (ebsLeft in LItem.CurrentStyle.BorderSides) then
                frFlags := frFlags or BF_LEFT;
              if (ebsRight in LItem.CurrentStyle.BorderSides) then
                frFlags := frFlags or BF_RIGHT;
            end;
            DrawCellFrame(Self, ACanvas, LRect, frFlags,False, True);
          end;
      end;
    end;
    if (UseOwnStyle) and (Style.BorderStyle <> ibsNone) then
    begin
      frFlags := 0;
      if (LItem.CurrentStyle.BorderStyle <> ibsNone) then
        InflateRect(LRect,-1,-1);
      if (ebsLeft in Style.BorderSides) then
        frFlags := frFlags or BF_LEFT;
      if (ebsRight in Style.BorderSides) then
        frFlags := frFlags or BF_RIGHT;
      if (ebsTop in Style.BorderSides) then
        frFlags := frFlags or BF_TOP;
      if (ebsBottom in Style.BorderSides) then
        frFlags := frFlags or BF_BOTTOM;
//      Dec(LRect.Bottom);
      case Style.BorderStyle of
        ibsRaised:
          DrawEdge(ACanvas.Handle, LRect, BDR_RAISEDINNER, frFlags);
        ibsFlat:
          DrawEdge(ACanvas.Handle, LRect, BDR_SUNKENOUTER, BF_FLAT or frFlags);
        ibsSunken:
          DrawEdge(ACanvas.Handle, LRect, BDR_SUNKENOUTER, frFlags);
        ibsSpace:
          begin
//            Inc(LRect.Bottom);
//            if (LItem.CurrentStyle.BorderStyle <> ibsNone) then
//              Dec(LRect.Top);
            ACanvas.Pen.Color := Style.BorderSpaceColor;
            DrawCellFrame(Self,ACanvas,LRect,frFlags);
          end;
      end;
    end;
  end;
end;

function TElXCustomTreeCell.IsSelected: Boolean;
{var
  i, j: integer;
  LItem, MItem: TElXTreeItem;}
begin
{  Result := False;
  LItem := TElXTreeItem(FOwner);
  if JointCellRole = jcrMaster then
  begin
    for j := LItem.AbsoluteIndex to LItem.AbsoluteIndex + JointRowCount - 1 do
    begin
      MItem := LItem.Owner.Items[j];
      for i := index to index + JointColumnCount - 1 do
      begin
        Result := Result or MItem.Cells[i].Selected;
        if Result then exit;
      end;
    end;
  end
  else }
    Result := FSelected;
end;

procedure TElXCustomTreeCell.DrawCellBk(const ACanvas: TCanvas; const ARect: TRect; AAbsIndex: integer = -1; AVisIndex: integer = -1);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LRect: TRect;
  b: boolean;
  LDetails: TThemedElementDetails;
  LThemeMode: TLMDThemeMode;
begin
  LItem := TElXTreeItem(FOwner);
  if Assigned(LItem) then
    LTree := TElXTree(LItem.Owner)
    else
    LTree := nil;

  if (LTree.BackgroundType = bgtColorFill)
  or ((CurrentStyle.CellBackGroundColor <> clNone) and CurrentStyle.UseBackGroundColor) then
  begin
    // EK: ignore bkcolor for selected cell
    if (not Selected) and (UseOwnStyle) and (Style.CellBackGroundColor <> clNone) and (not Style.ParentColors) then
    begin
      ACanvas.Brush.Color := Style.CellBackGroundColor;
      ACanvas.FillRect(ARect);
    end
    else
    begin
      if (not IsSelected) and (LTree.StripedItems) then
      begin
//        if (LItem.VisIndex) mod 2 = 0 then //VB May 2006 - printing tree with striped items issue
        if AVisIndex > -1 then
          b := (AVisIndex mod 2 = 0)
        else
          b := ((LItem.VisIndex) mod 2 = 0);
        if b then
        ACanvas.Brush.Color := LTree.StripedEvenColor
        else
          ACanvas.Brush.Color := LTree.StripedOddColor;
        ACanvas.FillRect(ARect);
      end;
    end;
  end;
  if IsSelected and (not LTree.BarStyle)
  and (LItem.CurrentStyle.BorderStyle = ibsNone) and (CurrentStyle.BorderStyle = ibsNone) then
  begin
    if ((LTree.View.HasFocus) or (not LTree.HideSelection)) then
    begin
//      if (LTree.ShowColumns or LTree.RowSelect) and not LTree.FullRowSelect then
      if LTree.ShowColumns and (not (LTree.FullRowSelect or LTree.RowSelect) or (JointCellRole = jcrMaster)) then
    begin
        LRect := ARect;
        ACanvas.Brush.Style := bsSolid;
        if LTree.View.HasFocus then
        ACanvas.Brush.Color := LTree.FocusedSelectColor
        else
          ACanvas.Brush.Color := LTree.HideSelectColor;
        if LTree.RightAlignedView then
          inc(LRect.Left, 2);
        if LTree.IsThemed and LTree.UseThemeForSelection and LMDSIWindowsVistaUp and LTree.View.HasFocus then
        begin
          ACanvas.Brush.Color := LTree.BackGroundColor;
          ACanvas.FillRect(LRect);
          lDetails.Element := teListView;
          lDetails.Part := 6;
          lDetails.State := 11;
          LThemeMode := LTree.UseThemeMode;
          LMDThemeServices.DrawElement(LThemeMode, ACanvas.Handle, LDetails, LRect, LMDRectToPtr(LRect));
        end
        else
          LMDAlphaFillRect(ACanvas, LRect, ACanvas.Brush.Color, LTree.HighlightAlphaLevel);
        end;
    end;
  end;
end;

procedure TElXCustomTreeCell.DrawFocusedCellBk(const ACanvas: TCanvas; const APosition: Integer;
  var ARect: TRect);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LRect: TRect;
  frFlags: Cardinal;
begin
  LItem := TElXTreeItem(FOwner);
  if Assigned(LItem) then
    LTree := TElXTree(LItem.Owner)
  else
    LTree := nil;
  if IsSelected and (LTree.ItemFocused = LItem) and
    (LTree.DrawFocusRect) and (not LTree.FullRowSelect or (JointCellRole = jcrMaster))
    then
  begin
    if (not LTree.RowSelect) or (LItem.Selected) then
    begin
      LRect := ARect;
      if not LTree.View.HasFocus and LTree.HideFocusRect then
        exit;

      if LTree.View.HasFocus and ((not LTree.BarStyle) and (LItem.CurrentStyle.BorderStyle = ibsNone) and (CurrentStyle.BorderStyle = ibsNone)) then
        ACanvas.Pen.Color := LTree.FocusedSelectTextColor
      else
        ACanvas.Pen.Color := LTree.FocusedSelectColor;
      ACanvas.Brush.Style := bsClear;
      frFlags := BF_TOP or BF_BOTTOM;
      if (LTree.RowSelect) then
      begin
        if APosition = 0 then
          frFlags := frFlags or BF_LEFT;
        if (APosition = LItem.Cells.Count - 1) and not (LTree.FullRowSelect) then
          frFlags := frFlags or BF_RIGHT;
        if JointCellRole = jcrMaster then
          frFlags := frFlags or BF_RIGHT or BF_LEFT;
        DrawCellFrame(Self, ACanvas, LRect, frFlags,True, True);
      end
      else
      begin
        frFlags := frFlags or BF_RIGHT or BF_LEFT;
        DrawCellFrame(Self, ACanvas, LRect, frFlags,True);
      end;
    end;
  end;
end;

procedure TElXCustomTreeCell.Paint(const ACanvas: TCanvas; const ARect: TRect; AUsePartialCheck: boolean = true; AAbsIndex: integer = -1; AVisIndex: integer = -1);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LHeaderSection: TElXHeaderSection;
  LControl: TElXCellControl;
  LStyle: TElXCellStyleRead;
  LRect, LRectTmp, LDrawItemLinesRect, LDrawItemLinesItemRect: TRect;
  LHelperBitmap: TBitmap;
begin
  LItem := TElXTreeItem(FOwner);
  if Assigned(LItem) then
    LTree := TElXTree(LItem.Owner)
  else
    LTree := nil;
  LHeaderSection := TElHeaderSection(GetHeaderSection) as TElXHeaderSection;
  LControl := GetControl;
  LRect := ARect;
  if LTree.RightAlignedView then
    inc(LRect.Left);
  if LTree.HorizontalLines and ((not LTree.BarStyle) or LTree.BarStyleNotRaise) then
    dec(Lrect.Bottom);
  if LTree.VerticalLines and ((not LTree.BarStyle) {or LTree.BarStyleVerticalLines} or LTree.BarStyleNotRaise) then
    if LTree.RightAlignedView then
  inc(LRect.Left)
    else
      dec(LRect.Right);
//  if (THCustomElXTree(TElXTreeItem(FOwner).Owner).VirtualityLevel > vlNone) then
//  begin
//    if not Assigned(FVirtStyle) then
//      FVirtStyle := TElXCellStyle.Create(TElXTreeItem(FOwner),Self);
//    if (not (csDesigning in TElXTreeItem(FOwner).Owner.ComponentState)) then
//      THCustomElXTree(TElXTreeItem(FOwner).Owner).TriggerVirtualStyleNeeded(TElXTreeItem(FOwner),Index,FVirtStyle);
//  end;
  LStyle := CurrentStyle;
  DrawCellBk(ACanvas, ARect, AAbsIndex, AVisIndex);
  DrawCellBorders(ACanvas,LRect);
  ACanvas.Brush.Style := bsClear;

  if LTree.RowSelect then
    SetRowDragColors(ACanvas);

  SetStyleProps(ACanvas, LStyle);

  SetSelDropColors(ACanvas);
  SetSelItemColors(ACanvas);
  SetDropTrgItemColors(ACanvas);

  ACanvas.Brush.Style := bsClear;

  if (Index = LTree.MainTreeColumn) then
//  if (LHeaderSection.Position = LTree.MainTreeColumn) then
  begin
    LDrawItemLinesRect := LRect;
    LDrawItemLinesItemRect := LRect;

    //<-- VB each of subsequent calls changes LDrawItemLinesRect
    TreeLinesOffsetRect(LDrawItemLinesRect);
    LTree.View.DrawItemLines(ACanvas, LItem, LDrawItemLinesRect, LDrawItemLinesItemRect);
    DrawNodeButtons(ACanvas, LDrawItemLinesRect);

    LHelperBitmap := TBitmap.Create;
    if LTree.ShowCheckBoxes then
      DrawItemCheckBox(ACanvas, LHelperBitmap, LDrawItemLinesRect);
    if LTree.ShowImages then
      DrawItemImages(ACanvas, LHelperBitmap, LDrawItemLinesRect);
    //-->
    if LTree.RightAlignedView then
      dec(LDrawItemLinesRect.Right, LTree.ItemIndent div 5)
    else
      inc(LDrawItemLinesRect.Left, LTree.ItemIndent div 5);
    LHelperBitmap.Free;
    if LTree.RightAlignedView then
      LRect.Right := LDrawItemLinesRect.Right
    else
      LRect.Left := LDrawItemLinesRect.Left;
  end;
  if LRect.Left > LRect.Right then
    LRect.Left := LRect.Right;
  if (LTree.OwnerDrawByColumn and Assigned(LHeaderSection) and (LHeaderSection.Style = ElhsOwnerDraw))
    or (not LTree.OwnerDrawByColumn
    and (GetText = LTree.OwnerDrawMask))
  or (assigned(LStyle) and (LStyle.FDrawStyle = elhsOwnerDraw))
  then
  begin
    if (csDesigning in LTree.ComponentState) then
      exit;
    LRectTmp := LRect;
    Inc(LRectTmp.Right);
    InflateRect(LRectTmp, -1, -1);

    if Assigned(LHeaderSection) then
      THCustomElXTree(LTree).DoItemDraw(LItem, ACanvas, LRectTmp, LHeaderSection.Index)
    else
      THCustomElXTree(LTree).DoItemDraw(LItem, ACanvas, LRectTmp, Index);

  end
  else
  begin
    if Assigned(LStyle.Control)
    then
    begin
      if LControl.Visible then
      begin
        LRectTmp := LRect;
        Inc(LRectTmp.Right);
        InflateRect(LRectTmp, -LControl.BorderWidth, -LControl.BorderWidth);
        LControl.Paint(Self, ACanvas, LRectTmp);
        if LTree.RightAlignedText then
        begin
          dec(LRect.Right, LTree.CheckBoxSize);//vb
        end
        else
          Inc(LRect.Left, LTree.CheckBoxSize);//vb
        end;
    end;
    //draw cell text only if there's no cell control or it is a checkbox  //vb
//    if (not Assigned(HeaderSection)) or ((TElXHeaderSection(HeaderSection).Style <> elhsPictureOnly) and (LStyle.DrawStyle = elhsText) and ((LControl is TElXCellCheckBox) or not Assigned(LControl)))
    if (not Assigned(HeaderSection) and (LStyle.FDrawStyle <> elhsPictureOnly)) or (Assigned(HeaderSection) and ((TElXHeaderSection(HeaderSection).Style <> elhsPictureOnly) and (LStyle.DrawStyle in [elhsText, elhsImageIndex]) and ((LControl is TElXCellCheckBox) or not Assigned(LControl))))
    then
      NoStylesItemDraw(ACanvas, LRect, LStyle, AUsePartialCheck)
    else
    if (Assigned(Style) and (Style.FDrawStyle = elhsPictureOnly)) or (((not Assigned(Style)) and (TElXHeaderSection(HeaderSection).Style = elhsPictureOnly)))
      and Assigned(FPicture) then
      PictureOutput(ACanvas, LRect);
  end;
  DrawBox(ACanvas, ARect, LStyle);
  if LStyle.StrikedOutLine then
    PaintStrikedOutLine(ACanvas, LRect);
  if (LTree.ShowColumns or LTree.RowSelect) then
  LRect.Left := ARect.Left;
  if LTree.RightAlignedView then
    inc(LRect.Left, 2);
  if Assigned(LHeaderSection) then
    DrawFocusedCellBk(ACanvas, LHeaderSection.Position, LRect)
  else
    DrawFocusedCellBk(ACanvas, Index, LRect);
end;

procedure TElXCustomTreeCell.DrawBox(const ACanvas: TCanvas; const ARect: TRect;
  const AStyle: TElXCellStyleRead);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  if LTree.HorizontalLines and ((not LTree.BarStyle) or LTree.BarStyleNotRaise) {and (LItem.CurrentStyle.BorderStyle = ibsNone) and (CurrentStyle.BorderStyle = ibsNone) } then
  begin
    DrawHorizontalLines(ACanvas, ARect, AStyle);
  end;
  if LTree.VerticalLines and ((not LTree.BarStyle) {or LTree.BarStyleVerticalLines} or LTree.BarStyleNotRaise) then
  begin
    DrawVerticalLines(ACanvas, ARect, AStyle);
  end;
end;

procedure TElXCustomTreeCell.DrawVerticalLines(const ACanvas: TCanvas; const ARect: TRect;
  ACurStyle: TElXCellStyleRead);
var
  LOldPenColor: TColor;
  LItem: TElXTreeItem;
  LTree: TElXTree;
  begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  if (LTree.BarStyle and (not LTree.BarStyleNotRaise)) then
  begin
    if (Index = LItem.Cells.Count - 1) then
      exit;
  end
  else
    if ((Index = LItem.Cells.Count - 1) and (LItem.CurrentStyle.BorderStyle <> ibsNone)){ or (UseOwnStyle and (Style.BorderStyle <> ibsNone))} then
      exit;

  LOldPenColor := ACanvas.Pen.Color;
  ACanvas.Pen.Color := LTree.VertDivLinesColor;
  if  ACurStyle.UseBackGroundColor
      and (ACurStyle.CellBackGroundColor = LTree.VertDivLinesColor)
      and (ACurStyle.BorderStyle = ibsNone)
  then
    ACanvas.Pen.Color := InvertColor(LTree.VertDivLinesColor);
    LTree.View.DrawVertLine(ACanvas, LItem,
  Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom), not LTree.RightAlignedView);
  if not (LTree.RightAlignedView) then
    if LTree.ShowColumns then
  if (Index = 0) then
        LTree.View.DrawVertLine(ACanvas, LItem, Rect(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom), True);
 ACanvas.Pen.Color := LOldPenColor;
end;

procedure TElXCustomTreeCell.DrawHorizontalLines(const ACanvas: TCanvas; const ARect: TRect;
  ACurStyle: TElXCellStyleRead);
var
  LOldPenColor: TColor;
  LItem: TElXTreeItem;
  LTree: TElXTree;
begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  if not LTree.HorizontalLines then
    Exit;
  LOldPenColor := ACanvas.Pen.Color;
  ACanvas.Pen.Color := LTree.HorzDivLinesColor;
  LTree.View.DrawHorzLine(ACanvas, LItem, Rect(ARect.Left, ARect.Bottom, ARect.Right, ARect.Bottom));
  ACanvas.Pen.Color := LOldPenColor;
end;

procedure TElXCustomTreeCell.CalcTextRect(const ACanvas: TCanvas;
  var ATextRect, AR: TRect; const AText: TLMDString; AUsePartialCheck: boolean = true);
var
  LItem: TElXTreeItem;
  LText: TLMDString;
  fmt: cardinal;
begin
  LItem := TElXTreeItem(FOwner);
  LText := AText;

  SetRectEmpty(ATextRect);

  //if not CurrentStyle.UseBackgroundColor then //en
  //  ACanvas.Brush.Style := bsClear;
  if LItem.Multiline and LItem.WordWrap then
     ATextRect.Right := ATextRect.Left + AR.Right - AR.Left - TElXTree(LItem.TreeView).ItemIndent div 5;
  fmt := DT_NOPREFIX or DT_CALCRECT
    or MultiLineFlags[LItem.Multiline] or WordWrapFlags[LItem.Multiline, LItem.WordWrap];
{$ifdef LMD_UNICODE}
  if not AUsePartialCheck then
    fmt := fmt or DT_ELCUSTOMDRAW;
{$endif}
  LMDDrawText(ACanvas.Handle, LText, Length(LText), ATextRect, fmt);
end;

procedure TElXCustomTreeCell.SetHtmlProps(const ACanvas: TCanvas; var ATextRect: TRect; const AText: TLMDString; const ARect: TRect; AUsePartialCheck: boolean = true);
var
  LHtmlData: TLMDHTMLData;
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LView: TElXTreeView;
  LIndex: Integer;
begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  LView := LTree.View;
  LIndex := GetIndex;

  SetRectEmpty(ATextRect);
  ATextRect.Left := 0;
  ATextRect.Top := 0;
  if LTree.VirtualityLevel = vlNone then
  begin
    LHtmlData := TLMDHTMLData(LItem.HTMLDataArray[LIndex]);
    if LHtmlData = nil then
    begin
      ATextRect.Right  := 0;
      ATextRect.Bottom := 0;
    end
    else
    with LView.Render do
    begin
      ATextRect.Right := min(LHtmlData.TextSize.cx, ARect.Right);
      ATextRect.Bottom := LHtmlData.TextSize.cy;
    end;
  end
  else
  begin
    with LView.Render do
    begin
      Data.DefaultStyle := ACanvas.Font.Style;
      Data.DefaultFont  := ACanvas.Font.Name;
      Data.DefaultColor := ACanvas.Font.Color;
      Data.DefaultHeight:= ACanvas.Font.Height;
      Data.Charset      := ACanvas.Font.Charset;

      PrepareText(AText, ARect.Right - ARect.Left, (LItem.WordWrap and LItem.Multiline));
      ATextRect.Right := Data.TextSize.cx;
      ATextRect.Bottom := Data.TextSize.cy;
    end;
  end;
//  if not AUsePartialCheck then
//  begin
//    ATextRect.Top := ARect.Top;
//    ATextRect.Bottom  := ARect.Bottom;
//  end;
end;

procedure TElXCustomTreeCell.HtmlOutput(const ACanvas: TCanvas;
  var ATextRect: TRect; const AR, AR1: TRect;
  const AVAlign: Integer; AUsePartialCheck: boolean = true);
var
  LData: TLMDHTMLData;
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LView: TElXTreeView;
  LHeaderSection: TElHeaderSection;
  LAdjColor: TColor;
begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  LView := LTree.View;
  LHeaderSection := TElHeaderSection(GetHeaderSection);

//  ATextRect.Bottom := Min(ATextRect.Bottom, ATextRect.Top + (AR1.Bottom - AR1.Top));
  if Index = LTree.MainTreeColumn then
    THElXTreeItem(LItem).FTextRect := ATextRect;
  if (AVAlign and DT_BOTTOM) = DT_BOTTOM then
    OffsetRect(ATextRect, 0, AR.Top + (AR.Bottom - AR.Top) - (ATextRect.Bottom - ATextRect.Top) - 1)
  else
  if (AVAlign and DT_VCENTER) = DT_VCENTER then
    OffsetRect(ATextRect, 0,
      AR.Top + (((AR.Bottom - AR.Top) - (ATextRect.Bottom - ATextRect.Top)) shr 1){ - 1})
  else
    OffsetRect(ATextRect, 0, AR.Top);

  if LTree.VirtualityLevel = vlNone then
	if Assigned(LHeaderSection) then
      LData := TLMDHTMLData(LItem.HTMLDataArray[LHeaderSection.Index])
    else
      LData := TLMDHTMLData(LItem.HTMLDataArray[0])
  else
    LData := LView.Render.Data;

  if LData <> nil then
  with LView.Render do
  begin
    if not AUsePartialCheck then
      DoubleBuffered := false;
    SetData(LData);
    Data.LinkColor := LTree.LinkColor;
    if Selected then
      if LTree.Focused or (not LTree.HideSelection) then
        Data.LinkColor := Data.LinkColor xor
                          LTree.FocusedSelectColor
                          xor $ffffff
      else
    Data.LinkColor := LTree.HideSelectTextColor;
    Data.LinkStyle := LTree.LinkStyle;
    if (not UseOwnStyle) or (UseOwnStyle and (Style.ParentColors or (Style.CellBackGroundColor = clNone))) then
      LAdjColor := clNone
    else
      LAdjColor := Style.CellBackGroundColor;

    if (not UseOwnStyle) or (UseOwnStyle and (not Style.ParentColors) and Style.UseBackGroundColor and (Style.TextBackGroundColor <> clNone)) then
    begin
      InflateRect(ATextRect, 1, 1);
      ACanvas.FillRect(ATextRect);
      InflateRect(ATextRect, -1, -1);
    end;

    LData.HOffset := CellRect.Left;
    LData.VOffset := CellRect.Top;
    LData.AuxData := TElXCustomTreeCell(Self);
    DrawTextEx(ACanvas, Point(0, 0), ATextRect, true,
      ACanvas.Font.Color, LData.DefaultBgColor,
      LData.HighlightColor, LData.HighlightBgColor, LAdjColor);
    InflateRect(ATextRect, 1, 1);
    if LTree.VirtualityLevel = vlNone then
	  SetData(nil);
  end;
end;

// =============================================
procedure TElXCustomTreeCell.NonHtmlOutput(const ACanvas: TCanvas;
  var ATextRect: TRect; const AR, AR1: TRect;
  const AVAlign, AHAlign: Integer; const AText: TLMDString);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LFormat: integer;
begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  //  ATextRect.Bottom := Min(ATextRect.Bottom, ATextRect.Top + (AR1.Bottom - AR1.Top));
  if (AVAlign and DT_BOTTOM) = DT_BOTTOM then
    OffsetRect(ATextRect, 0, AR.Top + (AR.Bottom - AR.Top) - (ATextRect.Bottom - ATextRect.Top) - 1)
  else
  if (AVAlign and DT_VCENTER) = DT_VCENTER then
    OffsetRect(ATextRect, 0,
      AR.Top + (((AR.Bottom - AR.Top) - (ATextRect.Bottom - ATextRect.Top)) shr 1){ - 1})
  else
    OffsetRect(ATextRect, 0, AR.Top);

  if (not (LTree.ShowColumns or LTree.RowSelect)) and Selected then
  begin
    InflateRect(ATextRect,1,1);
    ACanvas.FillRect(ATextRect);
  end;
  LFormat :=  DT_NOPREFIX or AVAlign or AHAlign or DT_EXTERNALLEADING;
  if LTree.RightAlignedText and LTRee.RightAlignedView then
	LFormat := LFormat or DT_RTLREADING;
  if Index = LTree.MainTreeColumn then
    THElXTreeItem(LItem).FTextRect := ATextRect;
  // to fix problem with rigth-aligned italic text
  if (fsItalic in ACanvas.Font.Style) and ((LFormat and DT_RIGHT) = DT_RIGHT) then
    LFormat := LFormat or DT_NOCLIP;
  Inc(ATextRect.Right, 4);
  LMDDrawText(ACanvas.Handle, AText, Length(AText), ATextRect,
    LFormat or MultiLineFlags[LItem.Multiline] or WordWrapFlags[LItem.Multiline, LItem.WordWrap]);
end;

procedure TElXCustomTreeCell.SetStyledFontProps(const ACanvas: TCanvas;
  const ACurStyle: TElXCellStyleRead);
  function DoColorFound(AItem: TElXTreeItem): TColor;
  begin
    Result := THCustomElXTree(AItem.Owner).BackGroundColor;
    if THCustomElXTree(AItem.Owner).Style.UseBackGroundColor and ((THCustomElXTree(AItem.Owner).Style.TextBackGroundColor <> clNone) or (THCustomElXTree(AItem.Owner).Style.CellBackGroundColor <> clNone)) then
      if THCustomElXTree(AItem.Owner).Style.TextBackGroundColor <> clNone then
        Result := THCustomElXTree(AItem.Owner).Style.TextBackGroundColor
      else
        Result := THCustomElXTree(AItem.Owner).Style.CellBackGroundColor;
    if (AItem.UseOwnStyle) then
    begin
      if (not AItem.Style.ParentColors) and ((AItem.Style.TextBackGroundColor <> clNone) or (AItem.Style.CellBackGroundColor <> clNone)) then
        if (AItem.Style.TextBackGroundColor <> clNone) then
          Result := AItem.Style.TextBackGroundColor
        else
          Result := AItem.Style.CellBackGroundColor
      else
      begin
        if Assigned(AItem.Parent) then
          Result := DoColorFound(AItem.Parent)
        else
        begin
          if (THCustomElXTree(AItem.Owner).BackgroundType = bgtColorFill) then
            Result := THCustomElXTree(AItem.Owner).BackGroundColor
          else
            Result := clNone;
        end;
      end;
    end;
  end;
  function DoFontColorFound(AItem: TElXTreeItem): TColor;
  begin
    Result := THCustomElXTree(AItem.Owner).TextColor;
    if (AItem.UseOwnStyle) then
    begin
      if (not AItem.Style.ParentColors) and (AItem.Style.TextColor <> clNone) then
        Result := AItem.Style.TextColor
      else
      begin
        if Assigned(AItem.Parent) then
          Result := DoFontColorFound(AItem.Parent)
        else
          Result := THCustomElXTree(AItem.Owner).TextColor;
          end;
    end;
  end;
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  //if not ACurStyle.OwnerProps then
  begin
    if ACanvas.Font.Name <> ACurStyle.FontName then
      ACanvas.Font.Name := ACurStyle.FontName;
    if ACanvas.Font.Style <> ACurStyle.FontStyles then
      ACanvas.Font.Style := ACurStyle.FontStyles;
    if ACanvas.Font.Size <> ACurStyle.FontSize then
      ACanvas.Font.Size := ACurStyle.FontSize;
    if ((not IsSelected) or (LTree.HideSelection and (not LTree.View.HasFocus)) or (LTree.BarStyle)) or (LItem.CurrentStyle.BorderStyle <> ibsNone) or (CurrentStyle.BorderStyle <> ibsNone) then
	  ACanvas.Font.Color := ACurStyle.TextColor;
//    ACanvas.Brush.Color :=
    if CurrentStyle.UseBackGroundColor then
    begin
      if UseOwnStyle then
      begin
        if (not Style.ParentColors) and
           (ACanvas.Brush.Color<>Style.TextBackGroundColor) and
           (((not LTree.View.HasFocus) and (LTree.HideSelection)) or (not IsSelected) or (LTree.BarStyle))
           then
        begin
          if (Style.TextBackGroundColor<>clNone) then
            ACanvas.Brush.Color := Style.TextBackGroundColor;
        end;
        if Style.ParentColors and not (LTree.StripedItems) and
           (((not LTree.View.HasFocus) and (LTree.HideSelection)) or (not Selected) or (LTree.BarStyle))
        then
        begin
          ACanvas.Brush.Color := DoColorFound(LItem);
          ACanvas.Font.Color := DoFontColorFound(LItem);
        end;
      end
      else
        if (not IsSelected) and (LTree.BackgroundType = bgtColorFill) and (not LTree.StripedItems) then
          ACanvas.Brush.Color := DoColorFound(LItem);
    end;
    if ACanvas.Brush.Color =  clNone then
      ACanvas.Brush.Style := bsClear;
  end;
  {else
  begin
    if ACanvas.Font.Name <> LTree.Font.Name then
      ACanvas.Font.Name := LTree.Font.Name;
    if ACanvas.Font.Style <> LTree.Font.Style then
      ACanvas.Font.Style := LTree.Font.Style;
    if ACanvas.Font.Size <> LTree.Font.Size then
      ACanvas.Font.Size := LTree.Font.Size;
  end;}
  if (LItem = LTree.TrackItem) and
    (LTree.RowHotTrack or (LTree.HotTrack and (Index = LTree.MainTreeColumn) and (not Selected)))
    then
  begin
    if LTree.UnderlineTracked then
	  ACanvas.Font.Style := ACanvas.Font.Style + [fsUnderline];
    ACanvas.Font.Color := LTree.TrackColor;
  end;
  if IsSelected and not LTree.ShowColumns and not LTree.RowSelect and (not LTree.BarStyle) and (LItem.CurrentStyle.BorderStyle = ibsNone) and (CurrentStyle.BorderStyle = ibsNone) then
  begin
    if ((LTree.View.HasFocus) or (not LTree.HideSelection)) then
    begin
      if LTree.View.HasFocus then
        ACanvas.Brush.Color := LTree.FocusedSelectColor
      else
        ACanvas.Brush.Color := LTree.HideSelectColor;
	end
    else
      ACanvas.Font.Color := DoFontColorFound(LItem);
  end;
end;

procedure TElXCustomTreeCell.SetSelItemColors(const ACanvas: TCanvas);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LView: TElXTreeView;
//  LIndex: Integer;
begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  LView := LTree.View;
//  LIndex := GetIndex;

  if IsSelected
    and (LView.HasFocus or not LTree.HideSelection)
    and not LTree.BarStyle
    then
  begin
    if LView.HasFocus then
    begin
    if LTree.HighlightAlphaLevel = 255 then
        ACanvas.Brush.Color := LTree.FocusedSelectColor;
      if not (LTree.IsThemed and LTree.UseThemeForSelection and LMDSIWindowsVistaUp) then
        ACanvas.Font.Color := LTree.FocusedSelectTextColor;
    end
    else
    begin
      if LTree.HighlightAlphaLevel = 255 then
        ACanvas.Brush.Color := LTree.HideSelectColor;
      if not LTree.HideSelection then
        ACanvas.Font.Color := LTree.HideSelectTextColor;
    end;
  end;
end;

procedure TElXCustomTreeCell.SetDropTrgItemColors(const ACanvas: TCanvas);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LView: TElXTreeView;
  LIndex: Integer;
begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  LView := LTree.View;
  LIndex := GetIndex;

  if (LItem = LView.DropTrg)
    and (LTree.DragTrgDrawMode in [ColorRect, SelColorRect])
    and (LTree.RowSelect or (LTree.SelectColumn = LIndex))
    then
  begin
    case LTree.DragTrgDrawMode of
      ColorRect:
        begin
          if (LTree.HighlightAlphaLevel = 255) then
          begin
            if LView.DropAcc then
          ACanvas.Brush.Color := LTree.DragRectAcceptColor
            else
              ACanvas.Brush.Color := LTree.DragRectDenyColor;
          end;
          ACanvas.Font.Color := clBtnText;
        end;
      SelColorRect:
        begin
          if (LTree.HighlightAlphaLevel = 255) then
          ACanvas.Brush.Color := clHighlight;
          ACanvas.Font.Color := clHighlightText;
        end;
    end; // case
  end;
end;

procedure TElXCustomTreeCell.AdjustTextRect(const ACanvas: TCanvas;
  var ATextRect: TRect; var AR: TRect; const AItemWholeRect: TRect;
  const AHAlign: Integer; var AVAlign: Integer);
var
  LTextWidth: Integer;
  LRTmp: TRect;

  LItem: TElXTreeItem;
  LTree: TElXTree;
  //  ALeft: Integer;
begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  LTextWidth := ATextRect.Right - ATextRect.Left + FDivLineWidth * 2;
  // define the rectangle for the text
  // R := Rect(HS.Left - (FLeftPosition + xOffs) {- FDivLineWidth}, AItemRect.Top,
    // HS.Right - (FLeftPosition + LDivLineWidth + 1) - xOffs {- FDivLineWidth}, AItemRect.Bottom);
  LRTmp := AR;
//  ALeft := Min(AR.Left + LTree.ItemIndent div 5, AR.Right);
  case AHAlign and (DT_LEFT or DT_RIGHT or DT_CENTER) of
    DT_LEFT:
      begin
        AR.Right := Min(AR.Left + LTextWidth + LTree.ItemIndent div 5, AR.Right);
        AR.Left := Min(AR.Left + LTree.ItemIndent div 5, AR.Right);
      end;
    DT_RIGHT:
      begin
        AR.Left := Max(AR.Right - (LTextWidth + LTree.ItemIndent div 3), AR.Left);
        AR.Right := Max(AR.Right - LTree.ItemIndent div 5, AR.Left);
      end;
    DT_CENTER:
      begin
        //InflateRect(AR, -FDivLineWidth, 0);
        AR.Left := AR.Left + ((AR.Right - AR.Left) shr 1 - Min(AR.Right - AR.Left, LTextWidth + 3) shr 1);
        AR.Right := AR.Left + Min(AR.Right - AR.Left, LTextWidth + 3);
      end;
  end;

  AR.Left := Min(AR.Left, LRTmp.Right);
  AR.Right := Max(AR.Right, LRTmp.Left);
  if (LItem.Multiline or LItem.IsHTML)
    and (AVAlign = 0)
    and (LTree.LineHeight < (AItemWholeRect.Bottom - AItemWholeRect.Top))
    then
    AVAlign := DT_TOP
  else
    AVAlign := DT_VCENTER;
  if LItem.WholeLine and (Self.Index = LTree.MainTreeColumn) then
   AR.Right := LTree.Header.SectionsWidth - LTree.HeaderSections[Self.Index].Left;
  if (LTree.RightAlignedText and (Index <> LTree.MainTreeColumn)) or (LTree.RightAlignedView and (Index = LTree.MainTreeColumn)) then
  begin
    if Index <> LTree.MainTreeColumn then
  begin
      ATextRect.Left := AR.Right - Min(AR.Right - AR.Left, ATextRect.Right - ATextRect.Left);
      ATextRect.Right := AR.Right;
    end
    else
    begin
      ATextRect.Left := AItemWholeRect.Right - Min(AItemWholeRect.Right - AItemWholeRect.Left, ATextRect.Right - ATextRect.Left);
      ATextRect.Right := AItemWholeRect.Right;
    end;
  end
  else
  begin
    if Index <> LTree.MainTreeColumn then
    begin
      ATextRect.Right := Min(AR.Right - AR.Left, ATextRect.Right - ATextRect.Left) + AR.Left;
      ATextRect.Left := AR.Left;
    end
    else
    begin
      ATextRect.Right := Min(AItemWholeRect.Right - AItemWholeRect.Left, ATextRect.Right - ATextRect.Left) + AItemWholeRect.Left;
      ATextRect.Left := AItemWholeRect.Left;
    end;
  end;
  ATextRect.Bottom := Min(ATextRect.Bottom, ATextRect.Top + (AItemWholeRect.Bottom - AItemWholeRect.Top));
end;

procedure TElXCustomTreeCell.DrawCellTextLocal(const ACanvas: TCanvas; var ARect: TRect; AUsePartialCheck: boolean = true);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LStyle: TElXCellStyleRead;
  LText: TLMDString;
  LTextRect, R: TRect;
  LVAlign, LHAlign: Integer;
begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  LStyle := CurrentStyle;
//  if not Assigned(LStyle) then //vb
//    LStyle := GetDefaultStyle;
  LText := GetText;
  if LText='' then
  begin
    if Index = LTree.MainTreeColumn then
      THElXTreeItem(LItem).FTextRect := ARect;
    exit;  //en
  end;
  if Assigned(LStyle) then
    LHAlign := LStyle.TextFlags
  else
    LHAlign := CDefaultTextFlags;
  if (((LTree.VirtualityLevel <> vlNone) and (LHAlign = CDefaultTextFlags))
	or (not UseOwnStyle and (not TElXTreeItem(FOwner).UseOwnStyle))) and Assigned(HeaderSection) then
  begin
    LHAlign := DT_NOPREFIX or DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS;
    case TElHeaderSection(HeaderSection).Alignment of
      hsaRight:
        if LTree.RightAlignedText then
        LHAlign := LHAlign or DT_LEFT
        else
          LHAlign := LHAlign or DT_RIGHT;
      hsaCenter: LHAlign := LHAlign or DT_CENTER;
      else
        if LTree.RightAlignedText then
        LHAlign := LHAlign or DT_RIGHT
        else
          LHAlign := LHAlign or DT_LEFT;
    end;
  end;
  if LItem.Multiline then
    LHAlign := LHAlign and not DT_SINGLELINE;
  LVAlign := LHAlign and (DT_TOP or DT_BOTTOM or DT_VCENTER);

  SetStyledFontProps(ACanvas, LStyle);

    R := ARect;

    SetRectEmpty(LTextRect);
    ACanvas.Font.Charset := LTree.Font.Charset;

    if LItem.IsHTML and LMDIsHTMLText(LText) then
      SetHtmlProps(ACanvas, LTextRect, LText, ARect, AUsePArtialCheck)
    else
      CalcTextRect(ACanvas, LTextRect, R, LText, AUsePartialCheck);

    if (not LTree.ShowColumns) or (LItem.WholeLine) then
      FTextTooLarge := (LTextRect.Right + R.Left > LTree.ClientWidth - LTree.GutterWidth)
    else
      FTextTooLarge := not (((LTextRect.Right - LTextRect.Left + FDivLineWidth * 2) < (R.Right - R.Left))
                       and ((LTextRect.Bottom - LTextRect.Top) <= (R.Bottom - R.Top)));

    AdjustTextRect(ACanvas, LTextRect, R, ARect, LHAlign, LVAlign);

    if LItem.IsHTML and LMDIsHTMLText(LText) then
      HtmlOutput(ACanvas, LTextRect, R, ARect, LVAlign, AUsePartialCheck)
    else
      NonHtmlOutput(ACanvas, LTextRect, R, ARect, LVAlign, LHAlign, LText);
  if not (LTree.ShowColumns or LTree.RowSelect) then
  ARect := LTextRect;
end;

procedure TElXCustomTreeCell.NoStylesItemDraw(const ACanvas: TCanvas; var ARect: TRect;
  AStyle: TElXCellStyleRead; AUsePartialCheck: boolean = true);
var
  LItem: TElXTreeItem;
  LHeaderSection: TElHeaderSection;
  LText: TLMDString;
  Bmp: TBitmap;
//  R: TRect;
begin
  LItem := TElXTreeItem(FOwner);
  LHeaderSection := TElHeaderSection(GetHeaderSection);

  if Assigned(LHeaderSection) and (LHeaderSection.Style = elhsImageIndex)
  then
  begin
    LText := GetText;
    BMP := TBitmap.Create;
    LItem.Owner.View.DrawCellImage(ACanvas, LItem, StrToIntDef(LText, -1),
      LHeaderSection.Index,BMP , ARect);
    FreeAndNil(Bmp);
  end
  else
    DrawCellTextLocal(ACanvas, ARect, AUsePartialCheck);
end;

procedure TElXCustomTreeCell.SetRowDragColors(const ACanvas: TCanvas);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LView: TElXTreeView;
begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  LView := LTree.View;

  if (LItem = LView.DropTrg)
    and (LTree.DragTrgDrawMode in [ColorRect, SelColorRect])
    and (LTree.HighlightAlphaLevel = 255)
    then
  begin
    case LTree.DragTrgDrawMode of
    ColorRect:
        begin
          if LView.DropAcc then
          ACanvas.Brush.Color := LTree.DragRectAcceptColor
          else
            ACanvas.Brush.Color := LTree.DragRectDenyColor;
          end;
      SelColorRect:
        begin
          ACanvas.Brush.Color := clHighlight;
        end;
    end; // case
  end;
end;

procedure TElXCustomTreeCell.SetSelDropColors(const ACanvas: TCanvas);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LView: TElXTreeView;
//  LHeaderSection: TElHeaderSection;
begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  LView := LTree.View;

  if IsSelected
    and (LView.HasFocus or not LTree.HideSelection)
    and (not LTree.BarStyle and (LItem.CurrentStyle.BorderStyle = ibsNone))
    and (LTree.HighlightAlphaLevel = 255)
    then
  begin
    if LView.HasFocus then
    ACanvas.Brush.Color := LTree.FocusedSelectColor
    else
       ACanvas.Brush.Color := LTree.HideSelectColor;
    end;

  if (LItem = LView.DropTrg)
    and (LTree.DragTrgDrawMode in [ColorRect, SelColorRect])
    and (LTree.HighlightAlphaLevel = 255)
    then
  begin
    case LTree.DragTrgDrawMode of
      ColorRect:
        begin
          if LView.DropAcc then
          ACanvas.Brush.Color := LTree.DragRectAcceptColor
          else
            ACanvas.Brush.Color := LTree.DragRectDenyColor;
          end;
      SelColorRect:
        ACanvas.Brush.Color := clHighlight;
    end; // case
  end;
end;

procedure TElXCustomTreeCell.SetSelected(const ASelected: Boolean);
begin
  if FSelected = ASelected then
    Exit;
  if (FJointCellRole = jcrSlave) and (GetJointRangeMasterCell <> Self) then
    GetJointRangeMasterCell.SetSelected(ASelected);
//  if not Assigned((Owner as TElXTreeItem).TreeView.Selected) then
  if ASelected and not (Owner as TElXTreeItem).Selected then
  begin
    THElXTreeView((Owner as TElXTreeItem).TreeView.View).FHitColumn := Index;
    THElXTreeView((Owner as TElXTreeItem).TreeView.View).DoSetSelected(Owner as TElXTreeItem);
    end
  else
    FSelected := ASelected;
  with (Owner as TElXTreeItem).Owner do
    if not IsUpdating then
      Invalidate;
end;

{ TElXTreeCellRow }

function TElXTreeCustomCellRow.GetCell(AIndex: Integer): TElXCustomTreeCell;
begin
  Result := TElXCustomTreeCell(FastGet(AIndex));
end;

{ TElXCustomTreeCell }

function TElXCustomTreeCell.GetIndex: Integer;
var
  LItem: TElXTreeItem;
begin
  LItem := (GetJointRangeMasterCell.FOwner as TElXTreeItem);
  if LItem.Cells <> nil then
    Result := LItem.Cells.IndexOf(Self)
  else
    Result := -1;
end;

function TElXCustomTreeCell.GetAbsoluteRowIndex: Integer;
begin
  Result := (GetJointRangeMasterCell.FOwner as TElXTreeItem).AbsoluteIndex
end;

function TElXCustomTreeCell.GetRowIndex: Integer;
begin
  Result := (GetJointRangeMasterCell.FOwner as TElXTreeItem).Index
end;

function TElXCustomTreeCell.GetText: TLMDString;
var
  LItem: TElXTreeItem;

  LTree: THCustomElXTree;

  LResult: TLMDString;
  LCell: TElXCustomTreeCell;
  CellIndex: Integer;
begin
  LCell := GetJointRangeMasterCell;
  Result := LCell.FText;
  LItem := LCell.FOwner as TElXTreeItem;
  if Assigned(LItem) then
  begin
    CellIndex := LItem.Cells.IndexOf(LCell);
    LTree := THCustomElXTree(LItem.Owner);
    if Assigned(LTree) then
    begin
      if LTree.VirtualityLevel = vlNone then
      begin
        if FUserText then
          LTree.TriggerUserCellTextNeeded(LItem, CellIndex, Result)
        else
          if LTree.MainTreeColumn = CellIndex then
          Result := LItem.Text;
      end
      else
      begin
        if (not (csDesigning in TElXTreeItem(LCell.FOwner).Owner.ComponentState)) then
          LTree.TriggerVirtualTextNeeded(LItem, Index, LResult);
        Result := LResult;
      end;
    end;
  end;
end;

procedure TElXCustomTreeCell.SetPicture(newValue: TBitmap);
var
  LItem: TElXTreeItem;
begin
  if (FPicture <> newValue) then
  begin
    FPicture := newValue;
    if (not Assigned(HeaderSection)) or (TElXHeaderSection(GetHeaderSection).Style <> elhsPictureOnly) then
      exit;
    LItem := TElXTreeItem(FOwner);
    if not LItem.Owner.IsUpdating and Assigned(LItem) and
    (THCustomElXTree(LItem.Owner).VirtualityLevel = vlNone)
    then
      LItem.UpdateItem;
  end;
end;

procedure TElXCustomTreeCell.SetText(const AValue: TLMDString);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
begin
  if FText <> AValue then
  begin
    FText := AValue;
    LItem := TElXTreeItem(FOwner);
    if not Assigned(LItem) then
      Exit;

    LTree := TElXTree(LItem.Owner);
    if not Assigned(LTree) then
      Exit;

    LTree.IsUpdating := True;

    if Index = LTree.MainTreeColumn then
		  LItem.Text := AValue
    else
      THCustomElXTree(LTree).FColumnSizeUpdate := True;
    if LItem.IsHTML then
      LItem.ReRenderCellText(Index);
    THCustomElXTree(LTree).DoCellChange(LItem, Self, icmText);
    THElXTreeItem(LItem).UpdateChangedCellText(Index);

    LTree.IsUpdating := False;
		LItem.UpdateItem;
  end;
end;

function TElXCustomTreeCell.GetControl: TElXCellControl;
var
  LStyle: TElXCellStyleRead;
begin
  LStyle := GetJointRangeMasterCell.CurrentStyle;
  if Assigned(LStyle) then
    Result := TElXCellControl(LStyle.Control)
  else
    Result := nil;
end;

function TElXCustomTreeCell.GetOwnStyle: TElXCellStyle;
var
  LCell: TElXCustomTreeCell;
begin
  LCell := GetJointRangeMasterCell;
  if
    (THCustomElXTree(TElXTreeItem(LCell.FOwner).Owner).VirtualityLevel > vlNone)
    then
  begin
    if UseOwnStyle then
    begin
      Result := TElXCellStyle(CurrentStyle);
    end
    else
      Result := nil;
  end
  else
    result := FOwnStyle;
end;

function TElXCustomTreeCell.GetCurrentStyle: TElXCellStyleRead;
var
  LItem: TElXTreeItem;

  LTree: THCustomElXTree;

  LCell: TElXCustomTreeCell;
  begin
  LCell := GetJointRangeMasterCell;
  if (THCustomElXTree(TElXTreeItem(LCell.FOwner).Owner).VirtualityLevel > vlNone) then
  begin
    if Index = THCustomElXTree(TElXTreeItem(LCell.FOwner).Owner).MainTreeColumn then
    begin
      if not Assigned(THElXTreeItem(LCell.FOwner).FVirtStyle) then
      begin
        THElXTreeItem(LCell.FOwner).FVirtStyle := TElXCellStyle.Create(TElXTreeItem(LCell.FOwner),nil);
        if (not (csDesigning in TElXTreeItem(LCell.FOwner).Owner.ComponentState)) then
          THCustomElXTree(TElXTreeItem(LCell.FOwner).Owner).TriggerVirtualStyleNeeded(TElXTreeItem(LCell.FOwner),LCell.Index,THElXTreeItem(LCell.FOwner).FVirtStyle);
      end;
      Result := THElXTreeItem(LCell.FOwner).FVirtStyle;
      end
    else
    begin
      if not Assigned(LCell.FVirtStyle) then
      begin
        LCell.FVirtStyle := TElXCellStyle.Create(TElXTreeItem(LCell.FOwner), LCell);
        if (not (csDesigning in TElXTreeItem(LCell.FOwner).Owner.ComponentState)) then
        THCustomElXTree(TElXTreeItem(LCell.FOwner).Owner).TriggerVirtualStyleNeeded(TElXTreeItem(LCell.FOwner), LCell.Index, LCell.FVirtStyle);
        end;
      Result := LCell.FVirtStyle;
      exit;
    end;
  end
  else
  begin
    Result := LCell.FOwnStyle;
    if UseOwnStyle then
      exit;
    LItem := TElXTreeItem(LCell.FOwner);
    if Assigned(LItem) then
    begin
      LTree := THCustomElXTree(LItem.Owner);
      if LTree.VirtualityLevel = vlNone then
      begin
        Result := LItem.CurrentStyle;
          exit;
      end;
    end;
  end;
end;

procedure TElXCustomTreeCell.SetStyleProps(const ACanvas: TCanvas; const AStyle: TElXCellStyleRead);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LHeaderSection: TElHeaderSection;
begin
  LItem := TElXTreeItem(GetJointRangeMasterCell.FOwner);
  LTree := TElXTree(LItem.Owner);
  LHeaderSection := TElHeaderSection(GetHeaderSection);
  if not Assigned(LHeaderSection) then
    exit;
  if (LHeaderSection.SortMode <> hsmNone) and (LTree.SortColumnColor <> clNone)
  then
    ACanvas.Brush.Color := LTree.SortColumnColor;
  end;

function TElXCustomTreeCell.GetHeaderSection: TPersistent;
var
  LSections: TElXHeaderSections;
begin
  LSections := (FOwner as TElXTreeItem).Owner.HeaderSections;
  if Index < LSections.Count then
    Result := LSections[Index]
  else
    Result := nil;
end;

//procedure TElXCustomTreeCell.DrawGutter(const ACanvas: TCanvas; const R: TRect);
//var
//  LItem: TElXTreeItem;
//  LTree: TElXTree;
//  lGutterRect: TRect;
//begin
//  LItem := TElXTreeItem(FOwner);
//  LTree := TElXTree(LItem.Owner);
//
//  lGutterRect := R;
//  lGutterRect.Left := 0;
//  LTree.View.DrawGutter(ACanvas, LItem, lGutterRect);
//end;

procedure TElXCustomTreeCell.DrawNodeButtons(const ACanvas: TCanvas;
  var ARect: TRect);
var
  LIsNode: Boolean;
  LItem: TElXTreeItem;
  LTree: TElXTree;
  begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  if LTree.ShowButtons then
  begin
    LIsNode := LItem.HasVisibleChildren or LItem.ForceButtons or
            LTree.ShowLeafButton;
    if not LItem.SuppressButtons
    and (LTree.ShowRootButtons or (LItem.Parent <> LTree.Items.Root))
      and (LIsNode or LTree.ShowLeafButton)
    then
      begin
        LTree.View.DrawButtons(ACanvas, LItem, LIsNode, ARect);
      end;
  end
  else
  if LItem.ChildrenCount > 0 then
   with LTree do
    if RightAlignedView then
      Dec(ARect.Right, ItemIndent)
    else
      Inc(ARect.Left, ItemIndent);
  end;

procedure TElXCustomTreeCell.Join(ARowCount, AColumnCount: Integer);
var
  x, y, FRowCount, FColumnCount: Integer;
  LCellIndex: Integer;
  LItemIndex: Integer;
  LCell: TElXCustomTreeCell;
  LItem: TElXTreeItem;
  LTree: TElXTree;
  begin
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  LCellIndex := GetIndex;
  LItemIndex := LItem.AbsoluteIndex;
  FRowCount := max(ARowCount, 1);
  FColumnCount := max(AColumnCount, 1);
  // the column is bigger than the rightmost column index
  if (LCellIndex + FColumnCount > LTree.HeaderSections.Count)
    or (LItemIndex + FRowCount > LTree.Items.Count)
    or LMDInRange(LTree.FixedTopRowNum - 1, LItemIndex, LItemIndex + FRowCount)
    or LMDInRange(LTree.FixedColNum - 1, LCellIndex, LCellIndex + FColumnCount)
    then
    Exit;

  LTree.IsUpdating := True;

  for y := LItemIndex to LItemIndex + FRowCount - 1 do begin
    LItem := LTree.Items[y];
    for x := LCellIndex to LCellIndex + FColumnCount - 1 do
      LItem.Cells[x].Split;
  end;

  for y := LItemIndex to LItemIndex + FRowCount - 1 do begin
    LItem := LTree.Items[y];
    for x := LCellIndex to LCellIndex + FColumnCount - 1 do begin
      LCell := LItem.Cells[x];
      LCell.FJointCellRole := jcrSlave;
      LCell.FJointCellMaster := Self;
    end;
  end;
  FJointCellRole := jcrMaster;
  FJointRowCount := FRowCount;
  FJointColumnCount := FColumnCount;
  LTree.IsUpdating := False;
  LTree.View.Repaint;
end;

procedure TElXCustomTreeCell.Split;
var
  x, y: Integer;
  LCellIndex: Integer;
  LItemIndex: Integer;
  LRowCount: Integer;
  LColumnCount: Integer;
  LItem: TElXTreeItem;
  LTree: TElXTree;
  begin
  case FJointCellRole of
    jcrSingle: Exit;
//    jcrMaster: LCell := Self;
    jcrSlave: Self := JointCellMaster;
  end;

  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  if csDestroying in LTree.ComponentState then
    exit;
  LItemIndex := LItem.AbsoluteIndex;
  LCellIndex := GetIndex;
  LRowCount := FJointRowCount;
  LColumnCount := FJointColumnCount;
  if LItemIndex = -1 then
    exit;
  if LTree.Items <> nil then
  begin
    for y := LItemIndex to LItemIndex + LRowCount - 1 do
    begin
      LItem := LTree.Items[y];
      for x := LCellIndex to LCellIndex + LColumnCount - 1 do
      if Assigned(LItem) then
        with LItem.Cells[x] do begin
          FJointCellRole := jcrSingle;
          FJointCellMaster := LItem.Cells[x];
          FJointColumnCount := 1;
          FJointRowCount := 1;
        end
    end;
  end;
  LTree.View.Repaint;
end;

function TElXCustomTreeCell.GetHeight: Integer;
var
  LItem: TElXTreeItem;
  LMaster: TElXCustomTreeCell;
  i: integer;
begin
  LMaster := GetJointRangeMasterCell;
  LItem := TElXTreeItem(FOwner);
  Result := LItem.Height;
  if FJointCellRole = jcrSingle then
    Exit;
  if LMaster.JointRowCount > 1 then
  begin
    LItem := TElXTreeItem(LMaster.Owner);
    for i := 1 to LMaster.JointRowCount - 1 do
    begin
      LItem := LItem.GetNext;
      if Assigned(LItem) then
        if LItem.IsVisible and (not LItem.Hidden) then
          Result := Result + LItem.Height;
    end;
  end;
end;

function TElXCustomTreeCell.GetWidth: Integer;
var
  LColumnsLeft, LColumnIndex, LColumnIndexMax: Integer;
  LItem: TElXTreeItem;
  LTree: TElXTree;
  LHeaderSections: TElXHeaderSections;
  LSection: TElXHeaderSection;
begin
  Self := GetJointRangeMasterCell;
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  LHeaderSections := LTree.HeaderSections;
  LColumnIndex := Index;
  if Assigned(LHeaderSections[LColumnIndex]) then
    Result := LHeaderSections[LColumnIndex].Width
  else
    Result := LTree.Width - LTree.VScrollBar.Width;
  if FJointCellRole = jcrSingle then
    Exit;

  LColumnsLeft := FJointColumnCount - 1;
  LColumnIndexMax := LHeaderSections.Count - 1;
  while (LColumnsLeft > 0) and (LColumnIndex <= LColumnIndexMax) do
  begin
    Inc(LColumnIndex);
    if LItem.Cells[LColumnIndex] = nil then
      continue;
    LSection := LItem.Cells[LColumnIndex{+1}].HeaderSection; //vb
    if (not Assigned(LSection)) or (not LSection.Visible) then
      continue;
    Inc(Result, LSection.Width);
    Dec(LColumnsLeft);
  end;
end;

procedure TElXCustomTreeCell.PaintStrikedOutLine(const ACanvas: TCanvas;
  const ARect: TRect);
var
  LPrevPenColor: TColor;
  LItem: TElXTreeItem;

  LTree: THCustomElXTree;

  LView: TElXTreeView;
begin
  LItem := FOwner as TElXTreeItem;
  LTree := THCustomElXTree(LItem.Owner);
  LView := LTree.View;
  LPrevPenColor := ACanvas.Pen.Color;
  if Selected
    and (LView.HasFocus or not LTree.HideSelection)
    and (not LTree.BarStyle and (LItem.CurrentStyle.BorderStyle = ibsNone))
    and LTree.RowSelect
  then
  begin
    if LView.HasFocus then
      ACanvas.Pen.Color := LTree.FocusedSelectTextColor
      else
    if not LTree.HideSelection then
      ACanvas.Pen.Color := LTree.HideSelectTextColor;
      end
  else
    ACanvas.Pen.Color := CurrentStyle.StrikedLineColor;
  ACanvas.MoveTo(ARect.Left, (ARect.Top + ARect.Bottom) shr 1 + 1);
  ACanvas.LineTo(ARect.Right, (ARect.Top + ARect.Bottom) shr 1 + 1);
//  MoveToEx(ACanvas.Handle, LItem.TextRect.Left - 2 - (FOwner.FLeftPosition + AColumnXOffset),
//    (AItemRect.Top + AItemRect.Bottom) shr 1 + 1 , nil);
//  LineTo(ACanvas.Handle, FHeader.SectionsWidth - (FOwner.FLeftPosition + AColumnXOffset),
//    (AItemRect.Top + AItemRect.Bottom) shr 1 + 1);
  ACanvas.Pen.Color := LPrevPenColor;
end;

function TElXCellStyleAncestor.GetState(AIndex: integer): Boolean;
begin
  Result := TElSTIState(AIndex) in FState;
end;

procedure TElXCellStyleAncestor.SetState(AIndex: integer; AValue: Boolean);
var
  LFontStyle: TFontStyles;
begin
  if AValue then
  begin
    Include(FState, TElSTIState(AIndex));
    if (TElSTIState(AIndex) in [stsUnderlined,stsBold,stsItalic,stsStrikeOut]) then
    begin
      LFontStyle := FFont.Style;
      case TElSTIState(AIndex) of
        stsUnderlined: Include(LFontStyle, fsUnderline);
        stsBold: Include(LFontStyle, fsBold);
        stsItalic: Include(LFontStyle, fsItalic);
        stsStrikeOut: Include(LFontStyle, fsStrikeOut);
      end;
      if FFont.Style <> LFontStyle then
        FFont.Style := LFontStyle;
    end;
  end
  else
  begin
    Exclude(FState, TElSTIState(AIndex));
    if (TElSTIState(AIndex) in [stsUnderlined,stsBold,stsItalic,stsStrikeOut]) then
    begin
      LFontStyle := FFont.Style;
      case TElSTIState(AIndex) of
        stsUnderlined: Exclude(LFontStyle, fsUnderline);
        stsBold: Exclude(LFontStyle, fsBold);
        stsItalic: Exclude(LFontStyle, fsItalic);
        stsStrikeOut: Exclude(LFontStyle, fsStrikeOut);
      end;
      if FFont.Style <> LFontStyle then
        FFont.Style := LFontStyle;
    end;
  end;
  DoChangeEvent;
end;

function TElXCustomTreeCell.GetLeft: Integer;
var
  i: Integer;
  LItem: TElXTreeItem;
  LCell: TElXCustomTreeCell;
begin
  Result := 0;
  LItem := FOwner as TElXTreeItem;
  if Assigned(HeaderSection) then
    Result := TElXHeaderSection(HeaderSection).Left
  else
    for i := 0 to Index - 1 do
    begin
      LCell := LItem.Cells[i];
      if LCell.Visible then
        Inc(Result, LCell.Width);
    end;
end;

function TElXCustomTreeCell.GetTop: Integer;
begin
  Result := FCellRect.Top;
end;

function TElXCustomTreeCell.GetVisible: Boolean;
begin
  Result := True;
end;

procedure TElXCustomTreeCell.SetHeight(const Value: Integer);
begin
end;

procedure TElXCustomTreeCell.SetLeft(const Value: Integer);
begin
end;

procedure TElXCustomTreeCell.SetTop(const Value: Integer);
begin
end;

procedure TElXCustomTreeCell.SetWidth(const Value: Integer);
begin
end;

procedure TElXCustomTreeCell.SetVisible(const Value: Boolean);
begin
end;

destructor TElXCustomTreeCell.Destroy;
begin
  if Assigned(Owner) then
    if Assigned(TElXTreeItem(Owner).Owner) then
    begin
      THCustomElXtree(TElXTreeItem(Owner).Owner).DoCellDeletion(Self);
      end;
  if Assigned(FOwnStyle) then
    FOwnStyle.Free;
  if Assigned(FVirtStyle) then
    FVirtStyle.Free;
  inherited;
end;

{
function TElXCustomTreeCell.GetColor(Index: TElXTreeCellColorType): TColor;
begin
  case Index of
    cctTextColor:
      if Assigned(FStyle) then
        Result := FStyle.TextColor
      else
        Result := clWindowText;
    cctTextBackGroundColor:
      if Assigned(FStyle) then
        Result := FStyle.TextBackGroundColor
      else
        Result := clWindow;
    cctCellBackGroundColor:
      if Assigned(FStyle) then
        Result := FStyle.CellBackGroundColor
      else
        Result := clWindow;
//    cctRowBackGroundColor: Result := FRowBackGroundColor;
    cctBorderSpaceColor: Result := FBorderSpaceColor;
    cctStrikedLineColor: Result := FStrikedLineColor;
  else
    Result := clBlack;
  end;
end;
}

(*
procedure TElXCustomTreeCell.SetColor(AIndex: TElXTreeCellColorType; AValue: TColor);
begin
  case AIndex of
    cctTextColor:
      begin
        if Assigned(FStyle) then
          FStyle.TextColor := AValue;
//        if not Owner.ParentColors then
//          Update;
      end;
    cctTextBackGroundColor:
      begin
        if Assigned(FStyle) then
          FStyle.TextBackGroundColor := AValue;
//        if not ParentColors and UseBackGroundColor then
//          UpdateItem;
      end;
    cctCellBackGroundColor:
      begin
        if Assigned(FStyle) then
          FStyle.CellBackGroundColor := AValue;
//        if not ParentColors and UseBackGroundColor then
//          UpdateItem;
      end;
{
    cctRowBackGroundColor:
      begin
        if FRowBackGroundColor = AValue then
          Exit;
        FRowBackGroundColor := AValue;
//        if not ParentColors and UseBackGroundColor then
//          UpdateItem;
      end;
{}
    cctBorderSpaceColor:
      begin
        FBorderSpaceColor := AValue;
//        if BorderStyle = ibsSpace then
//          UpdateItem;
      end;
    cctStrikedLineColor:
      begin
        FStrikedLineColor := AValue;
//        if StrikedOutline then
//          UpdateItem;
      end;
  end;
end;
*)

procedure TElXCellStyleAncestor.SetParentColors(const Value: Boolean);
begin
  if FParentColors = Value then
    Exit;
  FParentColors := Value;
  DoChangeEvent;
end;

procedure TElXCellStyleAncestor.SetStrikedOutLine(Value: Boolean);
begin
  if FStrikedOutLine <> Value then
  begin
    FStrikedOutLine := Value;
    DoChangeEvent;
  end;
end;

{procedure TElXCustomTreeCell.SetUseBackGroundColor(Value: Boolean);
begin
  if Assigned(FStyle) then
    FStyle.UseBackGroundColor := Value;
end;}

function TElXCustomTreeCell.CreateControl(
  AControlClass: TElXCellControlClass): TElXCellControl;
begin
  if Assigned(FOwnStyle) then
    begin
      Result := AControlClass.Create;
      FOwnStyle.Control := Result;
    end
  else
    raise EStyleNotAssigned.Create(Format(SLMDStyleInstanceNotAssigned,[self.ClassName]));
end;

procedure TElXCustomTreeCell.SetUseOwnStyle(const Value: Boolean);
begin
  if (FUseOwnStyle <> Value) then
    begin
      FUseOwnStyle := Value;

      if (THCustomElXTree(TElXTreeItem(Owner).Owner).VirtualityLevel = vlNone) then
      begin
        if FUseOwnStyle and (FOwnStyle = nil) then
          FOwnStyle := TElXCellStyle.Create(Owner, Self);
      end;
      if (Assigned(Owner)) and (not (Owner as TElXTreeItem).Owner.IsUpdating) and
      (THCustomElXTree((Owner as TElXTreeItem).Owner).VirtualityLevel = vlNone)
      then
        (Owner as TElXTreeItem).UpdateItem;
    end;
end;

procedure TElXCustomTreeCell.DrawItemCheckBox(const ACanvas: TCanvas; ABitmap:TBitmap;
  var ARect: TRect);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  w: integer;
begin
  if ARect.Right <= ARect.Left then
    exit;
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  if Index = LTree.MainTreeColumn then
  begin
    if LItem.ShowCheckBox then
    begin
      ABitmap.Height := ARect.Bottom - ARect.Top;
      ABitmap.Width := ARect.Right - ARect.Left;
      LTree.View.DrawCheckBox(ACanvas, LItem, ABitmap, ARect);
    end
    else
    begin
      if LTree.ForceAlign then
      begin
        w := LTree.CheckBoxSize;
        if LTree.RightAlignedView then
          Dec(ARect.Right, w)
        else
          inc(ARect.Left, w);
      end;
    end;
  end;
end;

procedure TElXCustomTreeCell.DrawItemImages(const ACanvas: TCanvas; ABitmap:TBitmap;
  var ARect: TRect);
var
  LItem: TElXTreeItem;
  LTree: TElXTree;
  begin
  if ARect.Right <= ARect.Left then exit;
  LItem := TElXTreeItem(FOwner);
  LTree := TElXTree(LItem.Owner);
  if Index = LTree.MainTreeColumn then
  begin
    ABitmap.Height := ARect.Bottom - ARect.Top;
    ABitmap.Width := ARect.Right - ARect.Left;
    LTree.View.DrawImages(ACanvas, LItem, ABitmap, ARect);
  end;
end;

procedure TElXCustomTreeCell.LoadFromStream(Stream: TStream; ver: integer);
var
  b: Boolean;
  LDummyInt: integer;

begin
  inherited LoadFromStream(Stream);
  Stream.ReadBuffer(FUserText, SizeOf(FUserText));
  Stream.ReadBuffer(FShowCheckBox, SizeOf(FShowCheckBox));
  Stream.ReadBuffer(FUseOwnStyle, SizeOf(FUseOwnStyle));
  if FUseOwnStyle then
  begin
    if not Assigned(FOwnStyle) then
      FOwnStyle := TElXCellStyle.Create(Owner, Self);
    FOwnStyle.LoadFromStream(Stream);
  end;

  if ver > -17 then
    Stream.ReadBuffer(LDummyInt, 4)
  else
  begin
    Stream.ReadBuffer(b, SizeOf(b));
    if b then
      FPicture.LoadFromStream(Stream);
  end;
//  Stream.ReadBuffer(FPicture, SizeOf(FPicture));

  if ver < -15 then
    Stream.ReadBuffer(FTag, SizeOf(FTag));
end;

procedure TElXCustomTreeCell.Assign(Source: TElXCustomTreeCell);
begin
  FText := Source.FText;
  FUserText := Source.FUserText;
  FShowCheckBox := Source.FShowCheckBox;
  FUseOwnStyle := Source.FUseOwnStyle;
  if Source.FUseOwnStyle then
  begin
    if not Assigned(FOwnStyle) then
      FOwnStyle := TElXCellStyle.Create(Owner, Self);
    FOwnStyle.Assign(Source.FOwnStyle);
  end;
  FPicture := Source.FPicture;
  FTag := Source.FTag;
  FData := Source.FData;
  FObject := Source.FObject;
end;

procedure TElXCustomTreeCell.WriteToStream(Stream: TStream);
var

 b: boolean;

begin
  inherited;
  Stream.WriteBuffer(FUserText, SizeOf(FUserText));
//  Stream.WriteBuffer(_FOverColors, SizeOf(_FOverColors));
//  Stream.WriteBuffer(FOwnerBackground, SizeOf(FOwnerBackground));
  Stream.WriteBuffer(FShowCheckBox, SizeOf(FShowCheckBox));
  Stream.WriteBuffer(FUseOwnStyle, SizeOf(FUseOwnStyle));
  if Assigned(FOwnStyle) then
  begin
    FOwnStyle.WriteToStream(Stream);
  end;

  b := Assigned(FPicture);
  Stream.WriteBuffer(b, SizeOf(Boolean));
  if b then
    FPicture.SaveToStream(Stream);
//  Stream.WriteBuffer(FPicture,SizeOf(FPicture));

  Stream.WriteBuffer(FTag, SizeOf(FTag));
end;

function TElXCustomTreeCell.GetJointRangeMasterCell: TElXCustomTreeCell;
begin
  Result := inherited GetJointRangeMasterCell as TElXCustomTreeCell;
end;

function TElXCustomTreeCell.GetJointCellMaster: TElXCustomTreeCell;
begin
  Result := FJointCellMaster as TElXCustomTreeCell;
end;

//{ TElXTreeCustomCellRange }
//
//constructor TElXTreeCustomCellRange.Create(AOwner: TElXPThemedControl);
//begin
//  FOwner := AOwner;
//end;
//
//function TElXTreeCustomCellRange.Range(ALeft, ATop, ARight, ABottom: Integer): TElXTreeCustomCellRange;
//begin
//  Result := nil;
//end;
//
//function TElXTreeCustomCellRange.Range(const ARect: TRect): TElXTreeCustomCellRange;
//begin
//  Result := Range(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
//end;
//
//function TElXTreeCustomCellRange.Union(const ARanges: array of TRect): TElXTreeCustomCellRange;
//begin
//  Result := nil;
//end;
//
//function TElXTreeCustomCellRange.GetAreas: TElXTreeCustomCellRangeArray;
//begin
//  SetLength(Result, 0);
//end;
//
//function TElXTreeCustomCellRange.GetSelected: Boolean;
//begin
//  Result := False;
//end;
//
//procedure TElXTreeCustomCellRange.SetSelected(const Value: Boolean);
//begin
//
//end;
//
//function TElXTreeCustomCellRange.GetSelection: TElXTreeCustomCellRange;
//begin
//  Result := nil;
//end;
//
//function TElXTreeCustomCellRange.GetCells(AX, AY: Integer): TElXTreeCustomCellRange;
//begin
//  Result := nil;
//end;
//
//function TElXTreeCustomCellRange.GetOffset(AX, AY: Integer): TElXTreeCustomCellRange;
//begin
//  Result := nil;
//end;
//
//function TElXTreeCustomCellRange.GetColumns(ACol: Integer): TElXTreeCustomCellRange;
//begin
//  Result := nil;
//end;
//
//function TElXTreeCustomCellRange.GetRows(ARow: Integer): TElXTreeCustomCellRange;
//begin
//  Result := nil;
//end;
//
//procedure TElXTreeCustomCellRange.Empty;
//begin
//
//end;
//
//function TElXTreeCustomCellRange.GetCell: TElXCustomTreeCell;
//begin
//  Result := nil;
//end;

function TElXCustomTreeCell.GetUseOwnStyle: Boolean;
begin
  Result := FUseOwnStyle or
    ((THCustomElXTree(TElXTreeItem(FOwner).Owner).VirtualityLevel > vlNone)
    and (not (csDesigning in TElXTreeItem(FOwner).Owner.ComponentState)))
end;

procedure TElXCustomTreeCell.SetHTMLControlsVisible(const Value: boolean);
begin
  FHTMLControlsVisible := Value;
end;

{ TElXTreeViewColorHelper }

constructor TElXTreeViewColorHelper.Create;
begin
  inherited Create;
  FVisible := TLMDObjectList.Create;
end;

destructor TElXTreeViewColorHelper.Destroy;
begin
  FVisible.Free;
  inherited;
end;

function TElXTreeCustomCellRow.IndexOf(ACell: TElXCustomTreeCell): Integer;
begin
  Result := inherited IndexOf(ACell);
end;

{ TElXCellFont }
procedure TElXCellFont.Changed;
begin
  inherited;
end;

constructor TElXCellFont.Create(AOwner: TElXCellStyleAncestor);
begin
  inherited Create;
  FOwner := AOwner;
end;

{
function TElXCellFont.GetCharset: TFontCharset;
begin
  Result := inherited Charset;
end;

function TElXCellFont.GetColor: TColor;
begin
  Result := inherited Color;
end;

function TElXCellFont.GetHeight: Integer;
begin
  Result := inherited Height;
end;

function TElXCellFont.GetName: TFontName;
begin
  Result := inherited Name;
end;

function TElXCellFont.GetPitch: TFontPitch;
begin
  Result := inherited Pitch;
end;

function TElXCellFont.GetPixelsPerInch: Integer;
begin
  Result := inherited PixelsPerInch;
end;

function TElXCellFont.GetSize: Integer;
begin
  Result := inherited Size;
end;

function TElXCellFont.GetStyle: TFontStyles;
begin
  Result := inherited Style;
end;

procedure TElXCellFont.SetCharset(const Value: TFontCharset);
begin
  inherited Charset := Value;
end;

procedure TElXCellFont.SetColor(const Value: TColor);
begin
  inherited Color := Value;
end;

procedure TElXCellFont.SetHeight(const Value: Integer);
begin
  inherited Height := Value;
end;

procedure TElXCellFont.SetName(const Value: TFontName);
begin
  inherited Name := Value;
end;

procedure TElXCellFont.SetPitch(const Value: TFontPitch);
begin
  inherited Pitch := Value;
end;

procedure TElXCellFont.SetPixelsPerInch(const Value: Integer);
begin
  inherited PixelsPerInch := Value;
end;

procedure TElXCellFont.SetSize(const Value: Integer);
begin
  inherited Size := Value;
end;

procedure TElXCellFont.SetStyle(const Value: TFontStyles);
begin
  inherited Style := Value;
end;
}

procedure TElXCellStyleAncestor.SetBorderSpaceColor(const Value: TColor);
begin
  if FBorderSpaceColor <> Value then
  begin
    FBorderSpaceColor := Value;
    DoChangeEvent;
  end;
end;

procedure TElXCellStyleAncestor.SetStrikedLineColor(const Value: TColor);
begin
  if FStrikedLineColor <> Value then
  begin
    FStrikedLineColor := Value;
    DoChangeEvent;
  end;
end;

{ TElXBaseCell }

function TElXBaseCell.GetJointRangeMasterCell: TElXBaseCell;
begin
  if FJointCellRole in [jcrMaster, jcrSingle] then
    Result := Self
  else
    Result := FJointCellMaster;
end;

function TElXBaseCell.GetText: TLMDString;
begin
  Result := FText;
end;

procedure TElXBaseCell.SetText(const AValue: TLMDString);
begin
  FText := AValue;
end;

procedure TElXBaseCell.WriteToStream(Stream: TStream);
begin
{$ifdef LMD_UNICODE}
  LMDWideWriteStringtoStream(Stream, FText);
{$else}
  LMDAnsiWriteStringtoStream(Stream, FText);
{$endif}
  Stream.WriteBuffer(FJointRowCount, SizeOf(FJointRowCount));
  Stream.WriteBuffer(FJointColumnCount, SizeOf(FJointColumnCount));

  Stream.WriteBuffer(FJointCellRole, SizeOf(FJointCellRole));

end;

procedure TElXBaseCell.LoadFromStream(Stream: TStream);
var

{$ifdef LMD_UNICODE}
  s: WideString;
  {$else}
  s: string;
{$endif}
begin
{$ifdef LMD_UNICODE}

  LMDWideReadStringFromStream(Stream, WideString(s));

{$else}
  LMDAnsiReadStringFromStream(Stream, s);
{$endif}
  FText := s;
  Stream.ReadBuffer(FJointRowCount, SizeOf(FJointRowCount));
  Stream.ReadBuffer(FJointColumnCount, SizeOf(FJointColumnCount));

  Stream.ReadBuffer(FJointCellRole, SizeOf(FJointCellRole));

end;

constructor TElXBaseCell.Create(AOwner: TPersistent);
begin
  inherited Create;
  FOwner := AOwner;
  FJointCellRole := jcrSingle;
  FJointCellMaster := Self;
  FJointRowCount := 1;
  FJointColumnCount := 1;
end;

destructor TElXBaseCell.Destroy;
begin
  if FJointCellRole <> jcrSingle then
  begin
    Split;
  end;
  inherited;
end;

function TElXBaseCell.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{ TElXBaseCellRow }

constructor TElXBaseCellRow.Create;
begin
  inherited;
  AutoClearObjects := True;
end;

procedure TElXBaseCellRow.Delete(AIndex: Integer);
begin
  if Cell[AIndex].FJointCellRole <> jcrSingle then
  begin
    Cell[AIndex].Split;
  end;
  inherited;
end;

function TElXBaseCellRow.GetCell(AIndex: Integer): TElXBaseCell;
begin
  Result := TElXBaseCell(FastGet(AIndex));
end;

function TElXBaseCellRow.GetCount: Integer;
begin
  Result := IntGetCount;
end;

function TElXBaseCellRow.IndexOf(ACell: TElXBaseCell): Integer;
begin
  Result := inherited IndexOf(ACell);
end;

function TElXBaseCellRow.IntGetCount: Integer;
begin
  Result := inherited Count;
end;

{TElXTreeCustomCellRange}

function TElXTreeCustomCellRange.CanSplit: Boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to Count - 1 do
    if TElXBaseCell(Items[i]).FJointCellRole = jcrMaster then
    begin
      Result := True;
      exit;
    end;
end;

procedure TElXTreeCustomCellRange.Split;
var
  i: integer;
begin
  for i := 0 to Count - 1 do
    if TElXBaseCell(Items[i]).FJointCellRole = jcrMaster then
      TElXBaseCell(Items[i]).Split;
end;

function TElXTreeCustomCellRange.CanMerge: Boolean;
var
  i: integer;
  LCell: TElXBaseCell;
begin
  Result := False;
  if Count < 2 then exit;
  CheckBorderValues;
  if (FColEnd - FColStart + 1)*(FRowEnd - FRowStart + 1) <> Count then
    exit;
  for i := 0 to Count - 1 do
  begin
    LCell := TElXBaseCell(Items[i]);
    if not LMDInRange(LCell.Index, FColStart, FColEnd) then
      exit;
    if not LMDInRange(LCell.RowIndex, FRowStart, FRowEnd) then
      exit;
  end;
  Result := True;
end;

procedure TElXTreeCustomCellRange.CheckBorderValues;
var
  i: integer;
  LCell: TElXBaseCell;
begin
  if Count < 1 then exit;
  FRowStart := TElXBaseCell(Items[0]).RowIndex;
  FColStart := TElXBaseCell(Items[0]).Index;
  FRowEnd := FRowStart;
  FColEnd:= FColStart;
  for i := 1 to Count - 1 do
  begin
    LCell := TElXBaseCell(Items[i]);
    if LCell.Index < FColStart then
      FColStart := LCell.Index;
    if LCell.JointCellRole = jcrMaster then
    begin
      if LCell.Index + LCell.JointColumnCount - 1 > FColEnd then
        FColEnd := LCell.Index + LCell.JointColumnCount - 1;
      if LCell.RowIndex + LCell.JointRowCount - 1 > FRowEnd then
        FRowEnd := LCell.RowIndex + LCell.JointRowCount - 1;
    end
    else
    begin
      if LCell.Index > FColEnd then
        FColEnd := LCell.Index;
      if LCell.RowIndex > FRowEnd then
        FRowEnd := LCell.RowIndex;
    end;
    if LCell.RowIndex < FRowStart then
      FRowStart := LCell.RowIndex;
  end;
end;

//procedure TElXCellStyleAncestor.SetBorderSides(Value: TLMDBorderSides);
//begin
//  if FBorderSides <> Value then
//  begin
//    FBorderSides := Value;
//  end;
//end;

procedure TElXCellStyleAncestor.DoChangeEvent;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

end.
