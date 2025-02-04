{******************************************************************************}
{                                                                              }
{                           GmTypes.pas v2.61 Lite                             }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmTypes;

interface

uses Windows, Classes, Forms, Controls, Graphics, extctrls, GmConst, stdctrls;

	{$I GMPS.INC}

type
  // forward declarations...
  TGmValue = class;
  TGmPage = class;
  TGmPageList = class;

  // enumerated types...
  TGmCaptionAlign     = (GmLeft, GmCenter, GmRight);
  TGmComplexPoints    = array[1..8] of Extended;
  TGmCoordsRelative   = (fromPage, fromPrinterMargins, fromUserMargins, fromHeaderLine);
  TGmCursor           = (gmDefault, gmZoomIn, gmZoomOut);
  TGmDitherType       = (gmNone, gmCourse, gmFine, gmLineArt, gmGrayScale);
  TGmDuplexType       = (gmSimplex, gmHorzDuplex, gmVertDuplex);
  TGmGraphicType      = (gtMetafile, gtBitmap, gtJPeg, gtIcon);
  TGmLineType         = (GmLine, GmLineExt);
  TGmMeasurement      = (GmUnits, GmPixels, GmMillimeters, GmCentimeters, GmInches, GmTwips);
  TGmOrientation      = (gmPortrait, gmLandscape);
  TGmOrientationType  = (gmPortraitReport, gmLandscapeReport, gmMixedOrientation);
  TGmPagesPerSheet    = (gmOnePage, gmTwoPage, gmFourPage);
  TGmPaperSize        = (A3, A4, A5, A6, B5, C5, Legal, Letter, Custom);
  TGmPrintColor       = (gmColor, gmMonochrome);
  TGmPrintQuality     = (gmDraft, gmLow, gmMedium, gmHigh);
  TGmRectType         = (gmRectangle, gmFillRect);
  TGmThumbNailLayout  = (gmThumbHorz, gmThumbVert, gmThumbGrid);
  TGmVertAlignment    = (gmTop, gmMiddle, gmBottom);
  TGmZoomStyle        = (gmFixedZoom, gmVariableZoom);

  // events...
  TBeforeLoadEvent        = procedure(Sender: TObject; FileVersion: Extended; var LoadFile: Boolean) of object;
  TBeforeReadWriteStream  = procedure(Sender: TObject; FileStream: TStream) of object;
  TFileProgressEvent      = procedure(Sender: TObject; Percent: Extended) of object;
  TGridNewPageEvent       = procedure (Sender: TObject; var ATopMargin, ABottomMargin: TGmValue) of object;
  TNeedRichEditEvent      = procedure (Sender: TObject; var ARichEdit: TCustomMemo) of object;
  TPageChangeEvent        = procedure(Sender: TObject; PageNum: integer) of object;
  TPageDragDropEvent      = procedure(Sender, Source: TObject;  X, Y: TGmValue) of object;
  TPageDragOverEvent      = procedure(Sender, Source: TObject; X, Y: TGmValue; State: TDragState; var Accept: Boolean) of object;
  TPageMouseEvent         = procedure(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: TGmValue) of object;
  TPageMouseMoveEvent     = procedure(Sender: TObject; Shift: TShiftState; X, Y: TGmValue) of object;
  TPageOrientationChanged = procedure(Sender: TObject; PageNum: integer; NewOrientation: TGmOrientation) of object;
  TPrintPageEvent         = procedure(Sender: TObject; APage: TGmPage; PrinterHandle: THandle) of object;
  TPrintProgressEvent     = procedure(Sender: TObject; Printed, Total: integer) of object;
  TThumbClickEvent        = procedure(Sender: TObject; AIndex: integer) of object;
  TThumbMouseDownEvent    = procedure (Sender: TObject; Button: TMouseButton; Shift: TShiftState; APage: TGmPage) of object;
  TZoomEvent              = procedure(Sender: TObject; OldZoom, NewZoom: integer) of object;

  // obsolete classes...
  TGmPageCanvas = TObject;

  // custom base classes...
  TGmCustomPrinter = TPersistent;

  // base classes for GmPrintSuite component decendants...

  TGmScrollingWinControl = class(TScrollingWinControl)
  private
    function GetAbout: string;
    function GetVersion: Extended;
    procedure SetAbout(const AValue: string);
  public
    property Version: Extended read GetVersion;
  published
    property About: string read GetAbout write SetAbout;
  end;

  TGmComponent = class(TComponent)
  private
    function GetAbout: string;
    function GetVersion: Extended;
    procedure SetAbout(const AValue: string);
  public
    property Version: Extended read GetVersion;
  published
    property About: string read GetAbout write SetAbout;
  end;

  TGmCustomComboBox = class(TCustomComboBox)
  private
    function GetAbout: string;
    function GetVersion: Extended;
    procedure SetAbout(const AValue: string);
  public
    property Version: Extended read GetVersion;
  published
    property About: string read GetAbout write SetAbout;
  end;

  TGmCustomPreview             = TGmScrollingWinControl;
  TGmCustomThumbnails          = TGmScrollingWinControl;

  TGmCustomBaseObject = class(TObject)
  private
    FOnChange: TNotifyEvent;
  protected
    procedure Changed;
  public
    procedure LoadFromStream(AVersion: Extended; AStream: TStream); virtual; abstract;
    procedure SaveToStream(AStream: TStream); virtual; abstract;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TCustomRtfInformation = class(TList);

  // record types...
  TGmPoint = record
    x: Extended;
    y: Extended;
  end;

  TGmSize = record
    Height: Extended;
    Width : Extended;
  end;

  TGmRect = record
    Left,
    Top,
    Right,
    Bottom: Extended;
  end;

  TGmBrush = record
    Color : TColor;
    Style : TBrushStyle;
  end;

  TGmFont = record
    Angle: Extended;
    Color: TColor;
    Name: string;
    Size: Integer;
    Style: TFontStyles;
  end;

  TGmPen = record
    Color: TColor;
    Style: TPenStyle;
    Width: Integer;
    Mode : TPenMode;
  end;

  // general classes...

  // *** TGmValue ***

  TGmValue = class
  private
    FValue: Integer; // (GmUnits)
    FOnChange: TNotifyEvent;
    procedure Changed;
    procedure SetAsGmValue(AMeasurement: TGmMeasurement; Value: Extended);
    procedure SetAsPixels(Ppi: integer; AValue: Integer);
    procedure SetAsMm(AValue: Extended);
    procedure SetAsCm(AValue: Extended);
    procedure SetAsInches(AValue: Extended);
    procedure SetAsTwips(AValue: integer);
    procedure SetAsUnits(AValue: integer);

    function GetAsGmValue(AMeasurement: TGmMeasurement): Extended;
    function GetAsPixels(Ppi: integer): Integer;
    function GetAsMm: Extended;
    function GetAsCm: Extended;
    function GetAsInches: Extended;
    function GetAsTwips: integer;
  public
    constructor Create;
    constructor CreateValue(Value: integer);
    constructor CreateValueEvent(AUnits: integer; AEvent: TNotifyEvent);
    //function AsGmValue(AMeasurement: TGmMeasurement): Extended;
    procedure Assign(Source: TGmValue);
    property AsUnits: Integer read FValue write SetAsUnits;
    property AsMillimeters: Extended read GetAsMm write SetAsMm;
    property AsCentimeters: Extended read GetAsCm write SetAsCm;
    property AsGmValue[index: TGmMeasurement]: Extended read GetAsGmValue write SetAsGmValue;
    property AsInches: Extended read GetAsInches write SetAsInches;
    property AsPixels[PPI: integer]: Integer read GetAsPixels write SetAsPixels;
    property AsTwips: integer read GetAsTwips write SetAsTwips;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

    // *** TGmValueSize ***

  TGmCustomValueSize = class
  protected
    FHeight: TGmValue;
    FWidth : TGmValue;
    FOnChange: TNotifyEvent;
    procedure Changed(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TGmValueSize = class(TGmCustomValueSize)
  public
    procedure Assign(Source: TGmValueSize);
    property Height: TGmValue read FHeight;
    property Width: TGmValue read FWidth;
  end;

  TGmValuePoint = class(TGmCustomValueSize)
  public
    procedure Assign(Source: TGmValuePoint);
    property x: TGmValue read FHeight;
    property y: TGmValue read FWidth;
  end;

  TGmValueRect = class
  private
    FLeft  : TGmValue;
    FTop   : TGmValue;
    FRight : TGmValue;
    FBottom: TGmValue;
    function GetTopLeft(AMeasurement: TGmMeasurement): TGmPoint;
    function GetTopRight(AMeasurement: TGmMeasurement): TGmPoint;
    function GetBottomLeft(AMeasurement: TGmMeasurement): TGmPoint;
    function GetBottomRight(AMeasurement: TGmMeasurement): TGmPoint;
  public
    constructor Create;
    constructor CreateValueEvent(AValues: TRect; AEvent: TNotifyEvent);
    destructor Destroy; override;
    procedure Assign(Source: TGmValueRect);
    procedure SaveToStream(AStream: TStream);
    procedure LoadFromStream(AStream: TStream);
    property Left: TGmValue read FLeft;
    property Top: TGmValue read FTop;
    property Right: TGmValue read FRight;
    property Bottom: TGmValue read FBottom;
    property TopLeft[AMeasurement: TGmMeasurement]: TGmPoint read GetTopLeft;
    property TopRight[AMeasurement: TGmMeasurement]: TGmPoint read GetTopRight;
    property BottomLeft[AMeasurement: TGmMeasurement]: TGmPoint read GetBottomLeft;
    property BottomRight[AMeasurement: TGmMeasurement]: TGmPoint read GetBottomRight;
  end;

  TGmMargins = class(TPersistent)
  private
    FClipMargins: Boolean;
    FMargins: TGmValueRect;
    FPrinterMargins: TGmValueRect;
    FPen: TPen;
    FPrinter: TGmCustomPrinter;
    FPrinterPen: TPen;
    FShowPrintMargins: Boolean;
    FVisible: Boolean;
    // events...
    FOnChange: TNotifyEvent;
    function GetAsInches: TGmRect;
    function GetLeftMargin: TGmValue;
    function GetTopMargin: TGmValue;
    function GetRightMargin: TGmValue;
    function GetBottomMargin: TGmValue;
    function GetPrinterMargins: TGmValueRect;
    procedure Changed(Sender: TObject);
    procedure SetClipMargins(AValue: Boolean);
    procedure SetPrinterPen(APen: TPen);
    procedure SetShowPrinterMargins(const AValue: Boolean);
    procedure SetVisible(const AValue: Boolean);
    procedure UpdatePrinterMargins;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToStream(AStream: TStream);
    procedure UsePrinterMargins;
    property AsInches: TGmRect read GetAsInches;
    property Left: TGmValue read GetLeftMargin;
    property Top: TGmValue read GetTopMargin;
    property Right: TGmValue read GetRightMargin;
    property Bottom: TGmValue read GetBottomMargin;
    property Printer: TGmCustomPrinter read FPrinter write FPrinter;
    property PrinterMargins: TGmValueRect read GetPrinterMargins;
  published
    property ClipMargins: Boolean read FClipMargins write SetClipMargins default False;
    property Pen: TPen read FPen write FPen;
    property PrinterMarginPen: TPen read FPrinterPen write SetPrinterPen;
    property ShowPrinterMargins: Boolean read FShowPrintMargins write SetShowPrinterMargins default False;
    property Visible: Boolean read FVisible write SetVisible default False;
    // events...
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TGmHeaderFooterCaption = class(TPersistent)
  private
    FCaption: string;
    FFont: TFont;
    FOnChange: TNotifyEvent;
    procedure Changed;
    procedure SetCaption(ACaption: string);
    procedure SetFont(AFont: TFont);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure LoadFromStream(AStream: TStream);
    procedure SaveToStream(AStream: TStream);
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Caption: string read FCaption write SetCaption;
    property Font: TFont read FFont write SetFont;
  end;


  TGmHeaderFooter = class(TPersistent)
  private
    FCaptions: array[GmLeft..GmRight] of TGmHeaderFooterCaption;
    FPageSizeInch: TGmSize;
    FPen: TPen;
    FMargins: TGmMargins;
    FPreview: TGmCustomPreview;
    FShowLine: Boolean;
    FTempValue: TGmValue;
    FVisible: Boolean;
    FOnChange: TNotifyEvent;
    function GetCaption(AIndex: TGmCaptionAlign): TGmHeaderFooterCaption;
		function GetIndexCaption(AIndex: integer): TGmHeaderFooterCaption;
    function GetHeight: TGmValue;
    function GetLargestFont: TFont;
    procedure SetCaption(AIndex: TGmCaptionAlign; ACaption: TGmHeaderFooterCaption);
    procedure SetIndexCaption(AIndex: integer; ACaption: TGmHeaderFooterCaption);
    procedure SetShowLine(AValue: Boolean);
    procedure SetVisible(AValue: Boolean);
    // events...
    procedure Changed(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Draw(ACanvas: TCanvas; DrawDpi, PageNum: integer; MarginRgn:HRGN); virtual; abstract;
    procedure LoadFromStream(AStream: TStream);
    procedure Print(APrinter: TGmCustomPrinter; PageNum: integer); virtual; abstract;
    procedure SaveToStream(AStream: TStream);
    property Caption[index: TGmCaptionAlign]: TGmHeaderFooterCaption read GetCaption write SetCaption;
    property Height: TGmValue read GetHeight;
    property Margins: TGmMargins read FMargins write FMargins;
    property PageSizeInch: TGmSize read FPageSizeInch write FPageSizeInch;
    property Preview: TGmCustomPreview read FPreview write FPreview;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property CaptionLeft: TGmHeaderFooterCaption index 0 read GetIndexCaption write SetIndexCaption;
    property CaptionCenter: TGmHeaderFooterCaption index 1 read GetIndexCaption write SetIndexCaption;
    property CaptionRight: TGmHeaderFooterCaption index 2 read GetIndexCaption write SetIndexCaption;
    property Pen: TPen read FPen write FPen;
    property ShowLine: Boolean read FShowLine write SetShowLine default True;
    property Visible: Boolean read FVisible write SetVisible default False;
  end;

  TGmHeader = class(TGmHeaderFooter)
  public
    procedure Draw(ACanvas: TCanvas; DrawDpi, PageNum: integer; MarginRgn:HRGN); override;
    procedure Print(APrinter: TGmCustomPrinter; PageNum: integer); override;
  end;

  TGmFooter = class(TGmHeaderFooter)
  public
    procedure Draw(ACanvas: TCanvas; DrawDpi, PageNum: integer; MarginRgn:HRGN); override;
    procedure Print(APrinter: TGmCustomPrinter; PageNum: integer); override;
  end;

  TGmPage = class
  private
    FFooter: TGmHeaderFooter;
    FHasChanged: Boolean;
    FRtfChanged: Boolean;
    FHeader: TGmHeaderFooter;
    FIsUpdating: Boolean;
    FMargins: TGmMargins;
    FMetafile: TMetafile;
    FMetafileRtf: TMetafile;
    FObjects: TList;
    FOrientation: TGmOrientation;
    FPageList: TGmPageList;
    FPageNum: integer;
    FPageSize: TGmValueSize;
    FShowFooter: Boolean;
    FShowHeader: Boolean;
    // events...
    FOnPageOrientationChange: TPageOrientationChanged;
    function GetBaseObject(index: integer): TGmCustomBaseObject;
    function GetObjectCount: integer;
    function GetMetafile: TMetafile;
    function GetMetafileDpi(dpi: integer): TMetafile;
    function GetMetafileRtf: TMetafile;
    function GetPageHeight: TGmValue;
    function GetPageWidth: TGmValue;
    procedure Changed(Sender: TObject);
    procedure DeleteGmObject(index: integer);
    procedure Redraw(DrawDpi: integer);
    procedure RedrawRtf;
    procedure SetHasChanged(AValue: Boolean);
    procedure SetOrientation(AValue: TGmOrientation);
    // events...
    procedure PageOrientationChanged;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddObject(AObject: TGmCustomBaseObject);
    procedure Assign(Source: TGmPage);
    procedure Clear;
    procedure LoadFromStream(AVersion: Extended; AStream: TStream);
    procedure Print(APrinter: TGmCustomPrinter);
    procedure SaveToStream(AStream: TStream);
    function RedrawPage: Boolean;
    property Count: integer read GetObjectCount;
    property Footer: TGmHeaderFooter read FFooter write FFooter;
    property HasChanged: Boolean read FHasChanged write SetHasChanged;
    property Header: TGmHeaderFooter read FHeader write FHeader;
    property GmObject[index: integer]: TGmCustomBaseObject read GetBaseObject;
    property Margins: TGmMargins read FMargins write FMargins;
    property Metafile: TMetafile read GetMetafile;
    property MetafileDPI[DotsPerInch: integer]: TMetafile read GetMetafileDpi;
    property MetafileRtf: TMetafile read GetMetafileRtf;
    property Orientation: TGmOrientation read FOrientation write SetOrientation default gmPortrait;
    property PageHeight: TGmValue read GetPageHeight;
    property PageSize: TGmValueSize read FPageSize;
    property PageWidth: TGmValue read GetPageWidth;
    property PageNum: integer read FPageNum;
    property ShowFooter: Boolean read FShowFooter write FShowFooter default True;
    property ShowHeader: Boolean read FShowHeader write FShowHeader default True;
    // events...
    property OnPageOrientationChanged: TPageOrientationChanged read FOnPageOrientationChange write FOnPageOrientationChange;
  end;

  TGmPageList = class
  private
    FFooter: TGmHeaderFooter;
    FHeader: TGmHeaderFooter;
    FMargins: TGmMargins;
    FOrientation: TGmOrientation;
    FPages: TList;
    FPageSize: TGmValueSize;
    FPaperSize: TGmPaperSize;
    FPreview: TGmCustomPreview;
    FRtfInformation: TCustomRtfInformation;
    // events...
    FOnChange: TNotifyEvent;
    FOnPageOrientationChanged: TPageOrientationChanged;
    function GetPage(index: integer): TGmPage;
    function GetPageCount: integer;
    function GetPageHeight: TGmValue;
    function GetPageWidth: TGmValue;
    procedure Repaginate;
    procedure SetOrientation(AOrientation: TGmOrientation);
    procedure SetPage(index: integer; APage: TGmPage);
    procedure SetPaperSize(APaperSize: TGmPaperSize);
    procedure UpdatePageSizes;

    // events...
    procedure PageSizeChange(Sender: TObject);
    procedure PageOrientationChange(Sender: TObject; PageNum: integer; AOrientation: TGmOrientation);
  public
    constructor Create;
    destructor Destroy; override;
    function AddPage: TGmPage;
    function GetOrientationType: TGmOrientationType;
    procedure Assign(Source: TGmPageList);
    procedure Clear;
    procedure DeletePage(APageNum: integer);
    procedure UpdateAll;
    property Count: integer read GetPageCount;
    property Footer: TGmHeaderFooter read FFooter write FFooter;
    property Header: TGmHeaderFooter read FHeader write FHeader;
    property Margins: TGmMargins read FMargins write FMargins;
    property Orientation: TGmOrientation read FOrientation write SetOrientation default gmPortrait;
    property Page[index: integer]: TGmPage read GetPage write SetPage; default;
    property PageHeight: TGmValue read GetPageHeight;
    property PageWidth: TGmValue read GetPageWidth;
    property PaperSize: TGmPaperSize read FPaperSize write SetPaperSize default A4;
    property Preview: TGmCustomPreview read FPreview write FPreview;
    property RtfInformation: TCustomRtfInformation read FRtfInformation;
    // events...
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnPageOrientationChange: TPageOrientationChanged read FOnPageOrientationChanged write FOnPageOrientationChanged;

  end;

  TGmShadow = class(TPersistent)
  private
    FWidth: integer;
    FColor: TColor;
    FVisible: Boolean;
    FOnChange: TNotifyEvent;
    procedure Changed;
    procedure SetColor(AColor: TColor);
    procedure SetVisible(AValue: Boolean);
    procedure SetWidth(AValue: integer);
  published
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    property Width: integer read FWidth write SetWidth default 5;
    property Color: TColor read FColor write SetColor default clBlack;
    property Visible: Boolean read FVisible write SetVisible default True;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

  end;

  TGmPaperImage = class(TPaintBox)
  private
    FBorders: TRect;
    FEnabled: Boolean;
    FGutter: integer;
   // FMetafile: TMetafile;
    //FMetafileRtf: TMetafile;
    FMargins: TGmMargins;
    FPage: TGmPage;
    FPaperSize: TGmPaperSize;
    FShadow: TGmShadow;
    FValue1,
    FValue2: TGmValue;
    FZoom: integer;
    // events...
    FOnPageDragDrop: TPageDragDropEvent;
    FOnPageDragOver: TPageDragOverEvent;
    FOnPageMouseDown: TPageMouseEvent;
    FOnPageMouseUp: TPageMouseEvent;
    FOnPageMouseMove: TPageMouseMoveEvent;
    function GetPageRect: TRect;
    function GetScale: Extended;
    function MouseOverPage(x,y: integer): Boolean;
    procedure SetMargins(AMargins: TGmMargins);
    procedure SetShadow(AShadow: TGmShadow);
    procedure Changed(Sender: TObject);
  protected
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    property Borders: TRect read FBorders write FBorders;
    property Enabled: Boolean read FEnabled write FEnabled default True;
    property Gutter: integer read FGutter write FGutter default DEFAULT_GUTTER;
    property Margins: TGmMargins read FMargins write SetMargins;
    property Shadow: TGmShadow read FShadow write SetShadow;
    property Page: TGmPage read FPage write FPage;
    property PageRect: TRect read GetPageRect;
    property PaperSize: TGmPaperSize read FPaperSize write FPaperSize default A4;
    property Zoom: integer read FZoom write FZoom default DEFAULT_ZOOM;
    // events...
    property OnPageDragDrop: TPageDragDropEvent read FOnPageDragDrop write FOnPageDragDrop;
    property OnPageDragOver: TPageDragOverEvent read FOnPageDragOver write FOnPageDragOver;
    property OnPageMouseDown: TPageMouseEvent read FOnPageMouseDown write FOnPageMouseDown;
    property OnPageMouseMove: TPageMouseMoveEvent read FOnPageMouseMove write FOnPageMouseMove;
    property OnPageMouseUp: TPageMouseEvent read FOnPageMouseUp write FOnPageMouseUp;
  end;

  function ConvertAlignment(Align: TAlignment): Byte;
  function ConvertVertAlignment(VertAlign: TGmVertAlignment): Byte;
  function ConvertValue(AValue: Extended; UnitsFrom, UnitsTo: TGmMeasurement): Extended;
  function ConvertGmRect(ARect: TGmRect; UnitsFrom, UnitsTo: TGmMeasurement): TGmRect;
  function ConvertGmSize(AGmSize: TGmSize; UnitsFrom, UnitsTo: TGmMeasurement): TGmSize;
  function ConvertComplexPoints(APoints: TGmComplexPoints; UnitsFrom, UnitsTo: TGmMeasurement): TGmComplexPoints;
  function BrushToGmBrush(ABrush: TBrush): TGmBrush;
  function FontToGmFont(AFont: TFont): TGmFont;
  function PenToGmPen(APen: TPen): TGmPen;
  function GetPaperDimensions(APaperSize: TGmPaperSize): TGmSize;
  function GmPoint(x, y: Extended): TGmPoint;
  function GmRect(x, y, x2, y2: Extended): TGmRect;
  function GmSize(AWidth, AHeight: Extended): TGmSize;
  function OffsetGmRect(ARect: TGmRect; Offset: TGmPoint): TGmRect;
  function RectAsGmRect(ARect: TRect): TGmRect;
  function PaperSizeToStr(APaperSize: TGmPaperSize): string;
  function StrToPaperSize(APaperStr: string): TGmPaperSize;

  procedure SelectPenIntoCanvas(APen: TPen; ACanvas: TCanvas);

  {$IFNDEF D4+}
  function Min(A, B: integer): integer;
	function Max(A, B: integer): integer;
  {$ENDIF}

implementation

//------------------------------------------------------------------------------

uses GmObjects, GmPrinter, GmStream, GmRtfFuncs, SysUtils, Math, Printers, JPeg,
  GmPreview;

//------------------------------------------------------------------------------

// *** Global functions ***

{$IFNDEF D4+}

function Min(A, B: integer): integer;
begin
	if A < B then Result := A else Result := B;
end;

function Max(A, B: integer): integer;
begin
  if A < B then Result := B else Result := A;
end;

{$ENDIF}

function ConvertAlignment(Align: TAlignment): Byte;
begin
  case Align of
    taLeftJustify : Result := DT_LEFT;
    taCenter      : Result := DT_CENTER;
  else
    Result := DT_RIGHT;
  end;
end;

function ConvertVertAlignment(VertAlign: TGmVertAlignment): Byte;
begin
  case VertAlign of
    gmTop    : Result := DT_TOP;
    gmMiddle : Result := DT_VCENTER + DT_SINGLELINE;
  else
    Result := DT_BOTTOM + DT_SINGLELINE;
  end;
end;

function ConvertValue(AValue: Extended; UnitsFrom, UnitsTo: TGmMeasurement): Extended;
var
  AsUnits: Extended;
begin
  // firstly convert to GmUnits...
  Result := AValue;
  if UnitsFrom = UnitsTo then Exit;
  AsUnits := AValue;
  case UnitsFrom of
    GmMillimeters: AsUnits := (AValue * 100);
    GmCentimeters: AsUnits := (AValue * 1000);
    GmInches     : AsUnits := (AValue * 100) * MM_PER_INCH;
    GmPixels     : AsUnits := ((AValue * 100) * MM_PER_INCH) / SCREEN_PPI;
    GmTwips      : AsUnits := ((AValue / 1440) * MM_PER_INCH) * 100;
  end;
  // now convert to the desired measurement...
  Result := AsUnits;
  case UnitsTo of
    GmMillimeters: Result := (AsUnits / 100);
    GmCentimeters: Result := (AsUnits / 1000);
    GmInches     : Result := (AsUnits / 100) / MM_PER_INCH;
    GmPixels     : Result :=((AsUnits / 100) / MM_PER_INCH) * SCREEN_PPI;
    GmTwips      : Result :=((AsUnits / 100) / MM_PER_INCH) * 1440;
  end;
end;

function ConvertGmSize(AGmSize: TGmSize; UnitsFrom, UnitsTo: TGmMeasurement): TGmSize;
begin
  Result.Height := ConvertValue(AGmSize.Height, UnitsFrom, UnitsTo);
  Result.Width  := ConvertValue(AGmSize.Width, UnitsFrom, UnitsTo);
end;

function ConvertGmRect(ARect: TGmRect; UnitsFrom, UnitsTo: TGmMeasurement): TGmRect;
begin
  Result.Left   := ConvertValue(ARect.Left, UnitsFrom, UnitsTo);
  Result.Top    := ConvertValue(ARect.Top, UnitsFrom, UnitsTo);
  Result.Right  := ConvertValue(ARect.Right, UnitsFrom, UnitsTo);
  Result.Bottom := ConvertValue(ARect.Bottom, UnitsFrom, UnitsTo);
end;

function ConvertComplexPoints(APoints: TGmComplexPoints; UnitsFrom, UnitsTo: TGmMeasurement): TGmComplexPoints;
var
  ICount: integer;
begin
  for ICount := 1 to 8 do
    Result[ICount] := ConvertValue(APoints[ICount], UnitsFrom, UnitsTo);
end;

function BrushToGmBrush(ABrush: TBrush): TGmBrush;
begin
  Result.Color  := ABrush.Color;
  Result.Style  := ABrush.Style;
end;

function FontToGmFont(AFont: TFont): TGmFont;
var
  logRec : TLogFont;
begin
  Result.Color  := AFont.Color;
  Result.Name   := AFont.Name;
  Result.Size   := AFont.Size;
  Result.Style  := AFont.Style;
  GetObject(AFont.Handle, SizeOf(TLogFont), @logrec);
  Result.Angle  := logrec.lfEscapement / 10;
end;

function PenToGmPen(APen: TPen): TGmPen;
begin
  Result.Color := APen.Color;
  Result.Style := APen.Style;
  Result.Width := APen.Width;
  Result.Mode  := APen.mode;
end;


function GetPaperDimensions(APaperSize: TGmPaperSize): TGmSize;
begin
  case APaperSize of
    A3: Result := GmSize(29700, 42000);
    A4: Result := GmSize(21000, 29700);
    A5: Result := GmSize(29700 div 2, 21000);
    A6: Result := GmSize(21000 div 2, 29700 div 2);
    B5: Result := GmSize(17600, 25000);
    C5: Result := GmSize(22900, 16300);
    Legal: Result := GmSize(21590, 35560);
    Letter: Result := GmSize(21590, 27940);
  end;
  Result := ConvertGmSize(Result, GmUnits, GmInches);
end;

function GmPoint(x, y: Extended): TGmPoint;
begin
  Result.x := x;
  Result.y := y;
end;

function GmRect(x, y, x2, y2: Extended): TGmRect;
begin
  Result.Left := x;
  Result.Top := y;
  Result.Right := x2;
  Result.Bottom := y2;
end;

function GmSize(AWidth, AHeight: Extended): TGmSize;
begin
  Result.Width := AWidth;
  Result.Height := AHeight;
end;

function OffsetGmRect(ARect: TGmRect; Offset: TGmPoint): TGmRect;
begin
  Result.Left   := ARect.Left + Offset.x;
  Result.Top    := ARect.Top + Offset.y;
  Result.Right  := ARect.Right + Offset.x;
  Result.Bottom := ARect.Bottom + Offset.y;
end;

function RectAsGmRect(ARect: TRect): TGmRect;
begin
  Result.Left   := ARect.Left;
  Result.Top    := ARect.Top;
  Result.Right  := ARect.Right;
  Result.Bottom := ARect.Bottom;
end;

function PaperSizeToStr(APaperSize: TGmPaperSize): string;
begin
  case APaperSize of
    A3    : Result := C_A3;
    A4    : Result := C_A4;
    A5    : Result := C_A5;
    A6    : Result := C_A6;
    B5    : Result := C_B5;
    C5    : Result := C_C5;
    Legal : Result := C_Legal;
    Letter: Result := C_Letter;
  else
    Result := C_CUSTOM;
  end;
end;

function StrToPaperSize(APaperStr: string): TGmPaperSize;
begin
  if APaperStr = C_A3 then Result := A3 else
  if APaperStr = C_A4 then Result := A4 else
  if APaperStr = C_A5 then Result := A5 else
  if APaperStr = C_A6 then Result := A6 else
  if APaperStr = C_B5 then Result := B5 else
  if APaperStr = C_C5 then Result := C5 else
  if APaperStr = C_Legal then Result := Legal else
  if APaperStr = C_Letter then Result := Letter else
  Result := Custom;
end;

procedure SelectPenIntoCanvas(APen: TPen; ACanvas: TCanvas);
var
  LB: TLogBrush;
  APenStyle: Byte;
  APenWidth: Cardinal;
  OnePt: Extended;
begin
  if APen.Width <= 1 then Exit;
  OnePt := ((DRAWING_DPI) / 72);
  LB.lbColor := APen.Color;
  LB.lbStyle := BS_SOLID;
  LB.lbHatch := 0;
  APenStyle := ConvertPenStyle(APen.Style);
  APenWidth := Round((APen.Width * (OnePt / 4)));
  if (APenStyle <> PS_SOLID) and (APenWidth < OnePt) then APenWidth := Round(OnePt+0.5);
  ACanvas.Pen.Handle := ExtCreatePen(PS_GEOMETRIC or APenStyle or PS_ENDCAP_SQUARE, APenWidth, LB, 0, nil);
end;

//------------------------------------------------------------------------------

function TGmScrollingWinControl.GetAbout: string;
begin
  Result := Self.ClassName + ' v' + FormatFloat('0.00', GetVersion);
end;

function TGmScrollingWinControl.GetVersion: Extended;
begin
  Result := SUITE_VERSION;
end;

procedure TGmScrollingWinControl.SetAbout(const AValue: string);
begin
  // does nothing.
end;

//------------------------------------------------------------------------------

function TGmComponent.GetAbout: string;
begin
  Result := Self.ClassName + ' v' + FormatFloat('0.00', GetVersion);
end;

function TGmComponent.GetVersion: Extended;
begin
  Result := SUITE_VERSION;
end;

procedure TGmComponent.SetAbout(const AValue: string);
begin
  // does nothing.
end;

//------------------------------------------------------------------------------

function TGmCustomComboBox.GetAbout: string;
begin
  Result := Self.ClassName + ' v' + FormatFloat('0.00', GetVersion);
end;

function TGmCustomComboBox.GetVersion: Extended;
begin
  Result := SUITE_VERSION;
end;

procedure TGmCustomComboBox.SetAbout(const AValue: string);
begin
  // does nothing.
end;

//------------------------------------------------------------------------------

procedure TGmCustomBaseObject.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

//------------------------------------------------------------------------------

// *** TGmValue ***

constructor TGmValue.Create;
begin
  inherited Create;
  FValue := 0;
end;

constructor TGmValue.CreateValue(Value: integer);
begin
  // create and set the value...
  inherited Create;
  FValue := Value;
end;

constructor TGmValue.CreateValueEvent(AUnits: integer; AEvent: TNotifyEvent);
begin
  // create, and set the value & OnChange event...
  inherited Create;
  FValue := AUnits;
  OnChange := AEvent;
end;

procedure TGmValue.Assign(Source: TGmValue);
begin
  AsUnits := (Source as TGmValue).AsUnits;
end;

procedure TGmValue.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TGmValue.SetAsGmValue(AMeasurement: TGmMeasurement; Value: Extended);
begin
  case AMeasurement of
    GmUnits       : SetAsUnits(Round(Value));
    GmPixels      : SetAsPixels(Screen.PixelsPerInch, Round(Value));
    GmMillimeters : SetAsMm(Value);
    GmCentimeters : SetAsCm(Value);
    GmInches      : SetAsInches(Value);
    GmTwips       : SetAsTwips(Round(Value));
  end;
end;

procedure TGmValue.SetAsPixels(Ppi: integer; AValue: Integer);
begin
  // set the value as pixels...
  AsUnits := Round((AValue * 2540) / Ppi);
end;

procedure TGmValue.SetAsMm(AValue: Extended);
begin
  // set the value as Millimeters...
  AsUnits := Round(AValue * 100);
end;

procedure TGmValue.SetAsCm(AValue: Extended);
begin
  // set the value as Centimeters...
  AsUnits := Round((AValue * 100) * 10);
end;

procedure TGmValue.SetAsInches(AValue: Extended);
begin
  // set the value as Inches...
  AsUnits := Round((AValue * 100) * MM_PER_INCH);
end;

procedure TGmValue.SetAsTwips(AValue: integer);
begin
  // set the value as twips...
  AsUnits := Round(((AValue / 1440) * MM_PER_INCH) * 100);
end;

procedure TGmValue.SetAsUnits(AValue: integer);
begin
  // set the value as Units (1/100 mm)
  if AValue <> FValue then
  begin
    FValue := AValue;
    Changed;
  end;
end;

function TGmValue.GetAsGmValue(AMeasurement: TGmMeasurement): Extended;
begin
  Result := FValue;
  case AMeasurement of
    GmPixels      : Result := GetAsPixels(Screen.PixelsPerInch);
    GmMillimeters : Result := GetAsMm;
    GmCentimeters : Result := GetAsCm;
    GmInches      : Result := GetAsInches;
    GmTwips       : Result := GetAsTwips;
  end;
end;

function TGmValue.GetAsPixels(Ppi: integer): Integer;
begin
  // return the value as Pixels...
  Result := Round((FValue / 2540) * Ppi);
end;

function TGmValue.GetAsMm: Extended;
begin
  // return the value as Millimeters...
  Result := (FValue / 100);
end;

function TGmValue.GetAsCm: Extended;
begin
  // return the value as Centimeters...
  Result := (FValue / 100) / 10;
end;

function TGmValue.GetAsInches: Extended;
begin
  // return the value as Inches...
  Result := (FValue / 100) / MM_PER_INCH;
end;

function TGmValue.GetAsTwips: integer;
begin
  // return the value as Twips...
  Result := Round(((FValue / 100) / MM_PER_INCH) * 1440)
end;

//------------------------------------------------------------------------------

// *** TGmCustomValueSize ***

constructor TGmCustomValueSize.Create;
begin
  inherited Create;
  FHeight := TGmValue.CreateValueEvent(0, Changed);
  FWidth  := TGmValue.CreateValueEvent(0, Changed);
end;

destructor TGmCustomValueSize.Destroy;
begin
  FHeight.Free;
  FWidth.Free;
  inherited Destroy;
end;

procedure TGmCustomValueSize.Changed(Sender: TObject);
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

//------------------------------------------------------------------------------

// *** TGmValueSize ***

procedure TGmValueSize.Assign(Source: TGmValueSize);
begin
  Height.Assign(Source.Height);
  Width.Assign(Source.Width);
end;

//------------------------------------------------------------------------------

// *** TGmValuePoint ***

procedure TGmValuePoint.Assign(Source: TGmValuePoint);
begin
  x.Assign(Source.x);
  y.Assign(Source.y);
end;
//------------------------------------------------------------------------------

// *** TGmValueRect ***

constructor TGmValueRect.Create;
begin
  // a TGmValueRect rect is a TRect type structure whose 4 values are
  // TGmValues.  (see TGmValue for more information)
  inherited Create;
  FLeft   := TGmValue.Create;
  FTop    := TGmValue.Create;
  FRight  := TGmValue.Create;
  FBottom := TGmValue.Create;
end;

constructor TGmValueRect.CreateValueEvent(AValues: TRect; AEvent: TNotifyEvent);
begin
  // create the TGmValueRect, set it's values and assign an OnChange event...
  Create;
  FLeft.FValue := AValues.Left;
  FTop.FValue  := AValues.Top;
  FRight.FValue := AValues.Right;
  FBottom.FValue := AValues.Bottom;
  FLeft.OnChange := AEvent;
  FTop.OnChange := AEvent;
  FRight.OnChange := AEvent;
  FBottom.OnChange := AEvent;
end;

destructor TGmValueRect.Destroy;
begin
  // free TGmValueRect objects...
  FLeft.Free;
  FTop.Free;
  FRight.Free;
  FBottom.Free;
  inherited Destroy;
end;

function TGmValueRect.GetTopLeft(AMeasurement: TGmMeasurement): TGmPoint;
begin
  Result := GmPoint(FLeft.AsGmValue[AMeasurement],
                    FTop.AsGmValue[AMeasurement]);
end;

function TGmValueRect.GetTopRight(AMeasurement: TGmMeasurement): TGmPoint;
begin
  Result := GmPoint(FRight.AsGmValue[AMeasurement],
                    FTop.AsGmValue[AMeasurement]);
end;

function TGmValueRect.GetBottomLeft(AMeasurement: TGmMeasurement): TGmPoint;
begin
  Result := GmPoint(FLeft.AsGmValue[AMeasurement],
                    FBottom.AsGmValue[AMeasurement]);
end;

function TGmValueRect.GetBottomRight(AMeasurement: TGmMeasurement): TGmPoint;
begin
  Result := GmPoint(FRight.AsGmValue[AMeasurement],
                    FBottom.AsGmValue[AMeasurement]);
end;

procedure TGmValueRect.Assign(Source: TGmValueRect);
var
  SourceRect: TGmValueRect;
begin
  // copy the values from the source TGmValueRect...
  SourceRect := (Source as TGmValueRect);
  Left.Assign(SourceRect.Left);
  Top.Assign(SourceRect.Top);
  Right.Assign(SourceRect.Right);
  Bottom.Assign(SourceRect.Bottom);
end;

procedure TGmValueRect.SaveToStream(AStream: TStream);
begin
  // Save the TGmValueRect to a stream...
  with (AStream as TGmExtStream) do
  begin
    WriteInteger(FLeft.AsUnits);
    WriteInteger(FTop.AsUnits);
    WriteInteger(FRight.AsUnits);
    WriteInteger(FBottom.AsUnits);
  end;
end;

procedure TGmValueRect.LoadFromStream(AStream: TStream);
begin
  // Load the TGmValueRect from a stream...
  with (AStream as TGmExtStream) do
  begin
    FLeft.AsUnits   := ReadInteger;
    FTop.AsUnits    := ReadInteger;
    FRight.AsUnits  := ReadInteger;
    FBottom.AsUnits := ReadInteger;
  end;
end;

//------------------------------------------------------------------------------


// *** TGmHeaderFooterCaption ***

constructor TGmHeaderFooterCaption.Create;
begin
  inherited Create;
  FFont := TFont.Create;
  FFont.Name := DEFAULT_FONT;
  FFont.Size := 12;
  FCaption := '';
end;

destructor TGmHeaderFooterCaption.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TGmHeaderFooterCaption.Assign(Source: TPersistent);
var
  SourceCaption: TGmHeaderFooterCaption;
begin
  SourceCaption := (Source as TGmHeaderFooterCaption);
  FCaption := SourceCaption.Caption;
  FFont.Assign(SourceCaption.Font);
  Changed;
end;

procedure TGmHeaderFooterCaption.LoadFromStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  // load the TGmHeaderFooterCaption from a stream..
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    GmFontToFont(FFont, GmStream.ReadFont);
    FCaption := GmStream.ReadStr;
  finally
    GmStream.Free;
  end;
end;

procedure TGmHeaderFooterCaption.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  // save the TGmHeaderFooterCaption to a stream..
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteFont(FontToGmFont(FFont));
    GmStream.WriteStr(FCaption);
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

procedure TGmHeaderFooterCaption.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TGmHeaderFooterCaption.SetCaption(ACaption: string);
begin
  if FCaption <> ACaption then
  begin
    FCaption := ACaption;
    Changed;
  end;
end;

procedure TGmHeaderFooterCaption.SetFont(AFont: TFont);
begin
  FFont.Assign(AFont);
  Changed;
end;

//------------------------------------------------------------------------------

// *** TGmHeaderFooter ***

constructor TGmHeaderFooter.Create;
var
  ICount: TGmCaptionAlign;
begin
  inherited Create;
  FPen := TPen.Create;
  FTempValue := TGmValue.Create;
  FPen.OnChange := Changed;
  FShowLine := True;
  FVisible := False;
  for ICount := GmLeft to GmRight do
  begin
    FCaptions[ICount] := TGmHeaderFooterCaption.Create;
    FCaptions[ICount].OnChange := Changed;
  end;
end;

destructor TGmHeaderFooter.Destroy;
var
  ICount: TGmCaptionAlign;
begin
  for ICount := GmLeft to GmRight do
    FCaptions[ICount].Free;
  FPen.Free;
  FTempValue.Free;
  inherited Destroy;
end;

procedure TGmHeaderFooter.Assign(Source: TPersistent);
var
  AHeaderFooter: TGmHeaderFooter;
  ICount: TGmCaptionAlign;
begin
  AHeaderFooter := (Source as TGmHeaderFooter);
  for ICount := GmLeft to GmRight do
    FCaptions[ICount].Assign(AHeaderFooter.Caption[ICount]);
  FPageSizeInch := AHeaderFooter.PageSizeInch;
  FPen.Assign(AHeaderFooter.Pen);
  FShowLine := AHeaderFooter.ShowLine;
  FVisible := AHeaderFooter.Visible;
  Changed(Self);
end;

procedure TGmHeaderFooter.LoadFromStream(AStream: TStream);
var
  ICount: TGmCaptionAlign;
  GmStream: TGmExtStream;
begin
  // Load the TGmHeaderFooter from a stream...
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FShowLine := GmStream.ReadBoolean;
    FVisible  := GmStream.ReadBoolean;
    for ICount := GmLeft to GmRight do
      FCaptions[ICount].LoadFromStream(GmStream);
    GmPenToPen(nil, FPen, GmStream.ReadPen);
  finally
    GmStream.Free;
  end;
end;

procedure TGmHeaderFooter.SaveToStream(AStream: TStream);
var
  ICount: TGmCaptionAlign;
  GmStream: TGmExtStream;
begin
  // Save the TGmHeaderFooter to a stream...
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteBoolean(FShowLine);
    GmStream.WriteBoolean(FVisible);
    for ICount := GmLeft to GmRight do
      FCaptions[ICount].SaveToStream(GmStream);
    GmStream.WritePen(PenToGmPen(FPen));
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

//------------------------------------------------------------------------------

// *** Private functions ***

function TGmHeaderFooter.GetCaption(AIndex: TGmCaptionAlign): TGmHeaderFooterCaption;
begin
  Result := FCaptions[AIndex];
end;

function TGmHeaderFooter.GetIndexCaption(AIndex: integer): TGmHeaderFooterCaption;
begin
 	Result := GetCaption(TGmCaptionAlign(AIndex));
end;

function TGmHeaderFooter.GetHeight: TGmValue;
var
  Mf: TMetafile;
  Mfc: TMetafileCanvas;
begin
  Mf := TMetafile.Create;
  Mfc := TMetafileCanvas.Create(Mf, 0);
  try
    Mfc.Font.PixelsPerInch := DRAWING_DPI;
    Mfc.Font.Assign(GetLargestFont);
    Result := FTempValue;
    Result.AsPixels[DRAWING_DPI] := Mfc.TextHeight(' ');
  finally
    Mfc.Free;
    Mf.Free;
  end;
end;

function TGmHeaderFooter.GetLargestFont: TFont;
begin
  // Return the largest font in the Header or Footer...
  Result := FCaptions[gmLeft].Font;
  if (FCaptions[gmCenter].Font.Size > Result.Size) then Result := FCaptions[gmCenter].Font;
  if (FCaptions[gmRight].Font.Size  > Result.Size) then Result := FCaptions[gmRight].Font;
end;

procedure TGmHeaderFooter.SetCaption(AIndex: TGmCaptionAlign; ACaption: TGmHeaderFooterCaption);
begin
  FCaptions[AIndex].Assign(ACaption);
end;

procedure TGmHeaderFooter.SetIndexCaption(AIndex: integer; ACaption: TGmHeaderFooterCaption);
begin
	SetCaption(TGmCaptionAlign(AIndex), ACaption);
end;

procedure TGmHeaderFooter.SetShowLine(AValue: Boolean);
begin
  if FShowLine <> AValue then
  begin
    FShowLine := AValue;
    Changed(Self);
  end;
end;

procedure TGmHeaderFooter.SetVisible(AValue: Boolean);
begin
  if FVisible <> AValue then
  begin
    FVisible := AValue;
    Changed(Self);
  end;
end;

procedure TGmHeaderFooter.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

//------------------------------------------------------------------------------

// *** TGmHeader ***

procedure TGmFooter.Draw(ACanvas: TCanvas; DrawDpi, PageNum: integer; MarginRgn:HRGN);
var
  ARect: TRect;
  PW, PH: integer;
  AText: string;
  MidPoint: integer;
  APreview: TGmPreview;
begin
  if not Visible then Exit;
  APreview := (FPreview as TGmPreview);
  PW := Round(FPageSizeInch.Width * DrawDpi);
  PH := Round(FPageSizeInch.Height * DrawDpi);
  ACanvas.Font.PixelsPerInch := DrawDpi;
  //ACanvas.Font.Assign(GetLargestFont);
  ARect.Left   := FMargins.Left.AsPixels[DrawDpi];
  ARect.Bottom := PH - FMargins.Bottom.AsPixels[DrawDpi];
  ARect.Right  := PW - FMargins.Right.AsPixels[DrawDpi];
  ARect.Top    := ARect.Bottom - Height.AsPixels[DrawDpi];
  with ACanvas do
  begin
    // clip the output...
    SelectClipRgn(Handle, MarginRgn);

    Brush.Style := bsClear;
    // left caption...
    AText :=  APreview.Tokenize(FCaptions[gmLeft].Caption, PageNum);
    Font.Assign(FCaptions[gmLeft].Font);
    TextOut(ARect.Left,
            ARect.Top,
            AText);

    // center caption...
    MidPoint := (ARect.Left + ARect.Right) div 2;
    AText :=  APreview.Tokenize(FCaptions[gmCenter].Caption, PageNum);
    Font.Assign(FCaptions[gmCenter].Font);
    TextOut(MidPoint -(TextWidth(AText) div 2),
            ARect.Top,
            AText);

    // right caption...
    AText :=  APreview.Tokenize(FCaptions[gmRight].Caption, PageNum);
    Font.Assign(FCaptions[gmRight].Font);

    ACanvas.TextOut(ARect.Right - TextWidth(AText),
                    ARect.Top,
                    AText);
  end;
  if not ShowLine then Exit;
  SelectPenIntoCanvas(FPen, ACanvas);
  ACanvas.Polyline([Point(ARect.Left, ARect.Top),
                    Point(ARect.Right, ARect.Top)]);
end;

procedure TGmFooter.Print(APrinter: TGmCustomPrinter; PageNum: integer);
var
  ARect: TGmRect;
  PW, PH: integer;
  GmPrinterObj: TGmPrinter;
  PpiX, PpiY: integer;
  AText: string;
  APreview: TGmPreview;
  MidPoint: Extended;
begin
  if not Visible then Exit;
  GmPrinterObj := (APrinter as TGmPrinter);
  PpiX := GmPrinterObj.PrinterPpiX;
  PpiY := GmPrinterObj.PrinterPpiY;
  PW := Round(FPageSizeInch.Width * PpiX);
  PH := Round(FPageSizeInch.Height * PpiY);

  ARect.Left   := (FMargins.Left.AsPixels[PpiX] / PpiX);
  ARect.Bottom    := ((PH - FMargins.Bottom.AsPixels[PpiY]) / PpiY);
  ARect.Right  := ((PW - FMargins.Right.AsPixels[PpiX]) / PpiX);
  ARect.Top := ARect.Bottom - (Height.AsPixels[PpiY] / PpiY);

  APreview := (FPreview as TGmPreview);
  with GmPrinterObj.Canvas do
  begin
    Brush.Style := bsClear;
    // left caption...
    AText :=  APreview.Tokenize(FCaptions[gmLeft].Caption, PageNum);
    Font.Assign(FCaptions[gmLeft].Font);
    TextOut(ARect.Left,
            ARect.Top,
            taLeftJustify,
            AText);

    // center caption...
    MidPoint := (ARect.Left + ARect.Right) / 2;
    AText :=  APreview.Tokenize(FCaptions[gmCenter].Caption, PageNum);
    Font.Assign(FCaptions[gmCenter].Font);
    TextOut(MidPoint -(TextWidthInch(AText) / 2),
            ARect.Top,
            taLeftJustify,
            AText);

    // right caption...
    AText :=  APreview.Tokenize(FCaptions[gmRight].Caption, PageNum);
    Font.Assign(FCaptions[gmRight].Font);

    TextOut(ARect.Right - TextWidthInch(AText),
            ARect.Top,
            taLeftJustify,
            AText);
  end;
  if not ShowLine then Exit;

  GmPrinterObj.Canvas.Pen.Assign(FPen);
  GmPrinterObj.Canvas.PolyLine([GmPoint(ARect.Left, ARect.Top),
                                GmPoint(ARect.Right, ARect.Top)]);
end;

// *** TGmHeader ***

procedure TGmHeader.Draw(ACanvas: TCanvas; DrawDpi, PageNum: integer; MarginRgn:HRGN);
var
  ARect: TRect;
  PW: integer;
  AText: string;
  MidPoint: integer;
  APreview: TGmPreview;
begin
  if not Visible then Exit;
  APreview := (FPreview as TGmPreview);
  PW := Round(FPageSizeInch.Width * DrawDpi);
  ACanvas.Font.PixelsPerInch := DrawDpi;
  //ACanvas.Font.Assign(GetLargestFont);
  ARect.Left   := FMargins.Left.AsPixels[DrawDpi];
  ARect.Top    := FMargins.Top.AsPixels[DrawDpi];
  ARect.Right  := PW - FMargins.Right.AsPixels[DrawDpi];
  ARect.Bottom := ARect.Top + Height.AsPixels[DrawDpi];
  with ACanvas do
  begin
    // clip the output...
    SelectClipRgn(Handle, MarginRgn);

    Brush.Style := bsClear;
    // left caption...
    AText :=  APreview.Tokenize(FCaptions[gmLeft].Caption, PageNum);
    Font.Assign(FCaptions[gmLeft].Font);
    TextOut(ARect.Left,
            ARect.Bottom - TextHeight(AText),
            AText);

    // center caption...
    MidPoint := (ARect.Left + ARect.Right) div 2;
    AText := APreview.Tokenize(FCaptions[gmCenter].Caption, PageNum);
    Font.Assign(FCaptions[gmCenter].Font);
    TextOut(MidPoint -(TextWidth(AText) div 2),
            ARect.Bottom - TextHeight(AText),
            AText);

    // right caption...
    AText := APreview.Tokenize(FCaptions[gmRight].Caption, PageNum);
    Font.Assign(FCaptions[gmRight].Font);
    TextOut(ARect.Right - TextWidth(AText),
            ARect.Bottom - TextHeight(AText),
            AText);
  end;
  if not ShowLine then Exit;
  SelectPenIntoCanvas(FPen, ACanvas);
  ACanvas.Polyline([Point(ARect.Left, ARect.Bottom),
                    Point(ARect.Right, ARect.Bottom)]);
end;

procedure TGmHeader.Print(APrinter: TGmCustomPrinter; PageNum: integer);
var
  ARect: TGmRect;
  GmPrinterObj: TGmPrinter;
  PpiX, PpiY: integer;
  PW: integer;
  AText: string;
  APreview: TGmPreview;
  MidPoint: Extended;
begin
  if not Visible then Exit;
  GmPrinterObj := (APrinter as TGmPrinter);
  PpiX := GmPrinterObj.PrinterPpiX;
  PpiY := GmPrinterObj.PrinterPpiY;
  PW := Round(FPageSizeInch.Width * PpiX);
  ARect.Left   := (FMargins.Left.AsPixels[PpiX] / PpiX);
  ARect.Top    := (FMargins.Top.AsPixels[PpiY] / PpiY);
  ARect.Right  := ((PW - FMargins.Right.AsPixels[PpiX]) / PpiX);
  ARect.Bottom := ARect.Top + (Height.AsPixels[PpiX] / PpiY);

  APreview := (FPreview as TGmPreview);
  with GmPrinterObj.Canvas do
  begin
    Brush.Style := bsClear;
    // left caption...
    AText :=  APreview.Tokenize(FCaptions[gmLeft].Caption, PageNum);
    Font.Assign(FCaptions[gmLeft].Font);
    TextOut(ARect.Left,
            ARect.Bottom - (TextHeightInch(AText)),
            taLeftJustify,
            AText);

    // center caption...
    MidPoint := (ARect.Left + ARect.Right) / 2;
    AText := APreview.Tokenize(FCaptions[gmCenter].Caption, PageNum);
    Font.Assign(FCaptions[gmCenter].Font);
    TextOut(MidPoint -(TextWidthInch(AText) / 2),
            ARect.Bottom - TextHeightInch(AText),
            taLeftJustify,
            AText);

    // right caption...
    AText := APreview.Tokenize(FCaptions[gmRight].Caption, PageNum);
    Font.Assign(FCaptions[gmRight].Font);

    TextOut(ARect.Right - TextWidthInch(AText),
            ARect.Bottom - TextHeightInch(AText),
            taLeftJustify,
            AText);
  end;
  if not ShowLine then Exit;
  GmPrinterObj.Canvas.Pen.Assign(FPen);
  GmPrinterObj.Canvas.PolyLine([GmPoint(ARect.Left, ARect.Bottom),
                                GmPoint(ARect.Right, ARect.Bottom)]);
end;

//------------------------------------------------------------------------------

// *** TGmMargins ***

constructor TGmMargins.Create;
begin
  inherited Create;
  FMargins := TGmValueRect.CreateValueEvent(Rect(DEFAULT_MARGIN,
                                                 DEFAULT_MARGIN,
                                                 DEFAULT_MARGIN,
                                                 DEFAULT_MARGIN),
                                            Changed);
  FPrinterMargins := TGmValueRect.Create;
  FPen := TPen.Create;
  FPrinterPen := TPen.Create;
  FPen.Color := clSilver;
  FPen.Style := psDot;
  FPrinterPen.Assign(FPen);
  FPen.OnChange := Changed;
  FPrinterPen.OnChange := Changed;
  FClipMargins := False;
end;

destructor TGmMargins.Destroy;
begin
  FMargins.Free;
  FPen.Free;
  FPrinterPen.Free;
  FPrinterMargins.Free;
  inherited Destroy;
end;

procedure TGmMargins.Assign(Source: TPersistent);
var
  AMargins: TGmMargins;
begin
  AMargins := (Source as TGmMargins);
  FMargins.Assign(AMargins.FMargins);
  FPrinterMargins.Assign(AMargins.FPrinterMargins);
  FPen.Assign(AMargins.FPen);
  FPrinterPen.Assign(AMargins.FPrinterPen);
  FShowPrintMargins := AMargins.FShowPrintMargins;
  FVisible := AMargins.FVisible;
  Changed(Self);
end;

procedure TGmMargins.LoadFromStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  // load the TGmMargins values from a stream...
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FMargins.LoadFromStream(GmStream);
    FVisible            := GmStream.ReadBoolean;
    FShowPrintMargins   := GmStream.ReadBoolean;
    FClipMargins := GmStream.ReadBoolean;
  finally
    GmStream.Free;
  end;
end;

procedure TGmMargins.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  // save the TGmMargins to a stream...
  GmStream := TGmExtStream.Create;
  try
    FMargins.SaveToStream(GmStream);
    GmStream.WriteBoolean(FVisible);
    GmStream.WriteBoolean(FShowPrintMargins);
    GmStream.WriteBoolean(FClipMargins);
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

procedure TGmMargins.UsePrinterMargins;
begin
  FMargins.Assign(GetPrinterMargins);
end;

function TGmMargins.GetAsInches: TGmRect;
begin
  Result.Left   := Left.AsInches;
  Result.Top    := Top.AsInches;
  Result.Right  := Right.AsInches;
  Result.Bottom := Bottom.AsInches;
end;

function TGmMargins.GetLeftMargin: TGmValue;
begin
  Result := FMargins.Left;
end;

function TGmMargins.GetTopMargin: TGmValue;
begin
  Result := FMargins.Top;
end;

function TGmMargins.GetRightMargin: TGmValue;
begin
  Result := FMargins.Right;
end;

function TGmMargins.GetBottomMargin: TGmValue;
begin
  Result := FMargins.Bottom;
end;

function TGmMargins.GetPrinterMargins: TGmValueRect;
begin
  UpdatePrinterMargins;
  Result := FPrinterMargins;
end;

procedure TGmMargins.Changed(Sender: TObject);
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TGmMargins.SetClipMargins(AValue: Boolean);
begin
  if AValue <> FClipMargins then
  begin
    FClipMargins := AValue;
    Changed(Self);
  end;
end;

procedure TGmMargins.SetPrinterPen(APen: TPen);
begin
  FPrinterPen.Assign(APen);
end;

procedure TGmMargins.SetShowPrinterMargins(const AValue: Boolean);
begin
  if FShowPrintMargins <> AValue then
  begin
    if not Assigned(FPrinter) then Exit;
    FShowPrintMargins := AValue;
    Changed(Self);
  end;
end;

procedure TGmMargins.SetVisible(const AValue: Boolean);
begin
  if FVisible <> AValue then
  begin
    FVisible := AValue;
    Changed(Self);
  end;
end;

procedure TGmMargins.UpdatePrinterMargins;
var
  APrinter: TGmPrinter;
begin
  if Assigned(FPrinter) then
  begin
    APrinter := TGmPrinter(FPrinter);
    FPrinterMargins.Left.AsInches   := APrinter.PrinterMargins.Left.AsInches;
    FPrinterMargins.Top.AsInches    := APrinter.PrinterMargins.Top.AsInches;
    FPrinterMargins.Right.AsInches  := APrinter.PrinterMargins.Right.AsInches;
    FPrinterMargins.Bottom.AsInches := APrinter.PrinterMargins.Bottom.AsInches;
  end;
end;

//------------------------------------------------------------------------------

// *** TGmPage Constructor/Destructor ***

constructor TGmPage.Create;
begin
  inherited Create;
  FMetafile := TMetafile.Create;
  FObjects  := TList.Create;
  FPageSize := TGmValueSize.Create;
  FPageSize.OnChange := Changed;
  FHasChanged := True;
  FShowFooter := True;
  FShowHeader := True;
  FIsUpdating := False;
end;

destructor TGmPage.Destroy;
begin
  Clear;
  FMetafile.Free;
  if Assigned(FMetafileRtf) then FMetafileRtf.Free;
  FPageSize.Free;
  FObjects.Free;
  inherited Destroy;
end;

//------------------------------------------------------------------------------

// *** Private functions ***

function TGmPage.GetBaseObject(index: integer): TGmCustomBaseObject;
begin
  Result := FObjects[index];
end;

function TGmPage.GetObjectCount: integer;
begin
  Result := FObjects.Count;
end;

function TGmPage.GetMetafile: TMetafile;
begin
  if FHasChanged then Redraw(DRAWING_DPI);
  Result := FMetafile;
end;

function TGmPage.GetMetafileDpi(dpi: integer): TMetafile;
begin
  FHasChanged := True;
  try
    Redraw(Dpi);
    Result := FMetafile;
  finally
    FHasChanged := True;
  end;
end;

function TGmPage.GetMetafileRtf: TMetafile;
begin
  if FRtfChanged then RedrawRtf;
  Result := FMetafileRtf;
end;

function TGmPage.GetPageHeight: TGmValue;
begin
  Result := PageSize.Height;
end;

function TGmPage.GetPageWidth: TGmValue;
begin
  Result := PageSize.Width;
  if not Assigned(Result) then Result := TGmValue.CreateValueEvent(0, Changed);
end;

procedure TGmPage.Changed(Sender: TObject);
begin
  FHasChanged := True;
end;

procedure TGmPage.DeleteGmObject(index: integer);
begin
  GmObject[index].Free;
  FObjects.Delete(index);
end;

procedure TGmPage.Redraw(DrawDpi: integer);
var
  ICount: integer;
  PW, PH: integer;
  APageSize: TGmSize;
  Mfc: TMetafileCanvas;
  Rgn: HRGN;
begin
  if (FIsUpdating) or (not FHasChanged) then Exit;

  FIsUpdating := True;
  try
    with FPageSize do
      APageSize := GmSize(Width.AsInches, Height.AsInches);

    PW := Round(DrawDpi * FPageSize.Width.AsInches);
    PH := Round(DrawDpi * FPageSize.Height.AsInches);
    FMetafile.Free;
    FMetafile := TMetafile.Create;
    FMetafile.Width  := PW;
    FMetafile.Height := PH;
    Mfc := TMetafileCanvas.Create(FMetafile, 0);

    try
      if FMargins.ClipMargins then
        Rgn := CreateRectRgn(FMargins.Left.AsPixels[DrawDpi],
                             FMargins.Top.AsPixels[DrawDpi],
                             FPageSize.Width.AsPixels[DrawDpi] - FMargins.Right.AsPixels[DrawDpi],
                             FPageSize.Height.AsPixels[DrawDpi] - FMargins.Bottom.AsPixels[DrawDpi])
      else
        Rgn := CreateRectRgn(0,
                             0,
                             FPageSize.Width.AsPixels[DrawDpi],
                             FPageSize.Height.AsPixels[DrawDpi]);

      // header...
      if FShowHeader then
      begin
        FHeader.PageSizeInch := APageSize;
        FHeader.Draw(Mfc, DrawDpi, FPageNum, Rgn);
      end;
      // footer...
      if FShowFooter then
      begin
        FFooter.PageSizeInch := APageSize;
        FFooter.Draw(Mfc, DrawDpi, FPageNum, Rgn);
      end;
      try
        for ICount := 0 to FObjects.Count-1 do
          TGmBaseObject(GmObject[ICount]).Draw(Mfc, DrawDpi, Rgn);
      finally
        DeleteObject(Rgn);
      end;
    finally
      Mfc.Free;
    end;
  finally
    FHasChanged := False;
    FIsUpdating := False;
  end;
end;

procedure TGmPage.RedrawRtf;
var
  APageSize: TGmSize;
  RtfOffset: TGmRtfOffset;
  RtfInfo: TGmRtfInformation;
  Mfc: TMetafileCanvas;
  DestPpi: integer;
  AMarginRect: TGmRect;
begin
  if  (FIsUpdating) or (not FRtfChanged) then Exit;
  FIsUpdating := True;
  try
    with FPageSize do
      APageSize := GmSize(Width.AsInches, Height.AsInches);

    RtfInfo := TGmRtfInformation(FPageList.RtfInformation);
    RtfOffset := RtfInfo.OffsetForPage[FPageNum];
    if RtfOffset <> nil then
    begin
      DestPpi := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
      if not Assigned(FMetafileRtf) then FMetafileRtf := TMetafile.Create;
      FMetafileRtf.Clear;
      FMetafileRtf.Width := Round(PageSize.Width.AsInches * DestPpi);
      FMetafileRtf.Height := Round(PageSize.Height.AsInches * DestPpi);
      Mfc := TMetafileCanvas.Create(FMetafileRtf, Printer.Handle);
      AMarginRect := FMargins.AsInches;
      with RtfOffset do
      begin
        AMarginRect.Top := MarginTop;
        AMarginRect.Bottom := MarginBottom;
        DrawRichText(Mfc, RtfInfo.RichEdit, StartChar, EndChar, AMarginRect, APageSize);
      end;
      Mfc.Free;
    end
    else
      FMetafileRtf := nil;
  finally
    FRtfChanged := False;
    FIsUpdating := False;
  end;
end;

procedure TGmPage.SetHasChanged(AValue: Boolean);
begin
  FHasChanged := AValue;
  FRtfChanged := AValue;
end;

procedure TGmPage.SetOrientation(AValue: TGmOrientation);
var
  TempVal: integer;
begin
  if AValue <> FOrientation then
  begin
    FOrientation := AValue;
    with PageSize do
    begin
      TempVal := Width.AsUnits;
      Width.AsUnits := Height.AsUnits;
      Height.AsUnits := TempVal;
    end;
    Changed(Self);
    if FOrientation <> FPageList.Orientation then
      PageOrientationChanged;
  end;
end;

procedure TGmPage.PageOrientationChanged;
begin
  if Assigned(FOnPageOrientationChange) then FOnPageOrientationChange(Self, FPageNum, FOrientation);
end;

//------------------------------------------------------------------------------

// *** Public functions ***

procedure TGmPage.AddObject(AObject: TGmCustomBaseObject);
begin
  FObjects.Add(AObject);
  AObject.OnChange := Changed;
  FHasChanged := True;
end;

procedure TGmPage.Assign(Source: TGmPage);

  function CreateObject(ASourceObject: TGmBaseObject): TGmBaseObject;
  begin
    Result := nil;
    if (ASourceObject is TGmTextObject) then Result := TGmTextObject.Create else
    if (ASourceObject is TGmTextBoxObject) then Result := TGmTextBoxObject.Create else
    if (ASourceObject is TGmLineObject) then Result := TGmLineObject.Create else
    if (ASourceObject is TGmEllipseShape) then Result := TGmEllipseShape.Create else
    if (ASourceObject is TGmRectangleShape) then Result := TGmRectangleShape.Create else
    if (ASourceObject is TGmRoundRectShape) then Result := TGmRoundRectShape.Create;
    if (ASourceObject is TGmGraphicObject) then Result := TGmGraphicObject.Create;
    if (ASourceObject is TGmArcShape) then Result := TGmArcShape.Create;
    if (ASourceObject is TGmChordShape) then Result := TGmChordShape.Create;
    if (ASourceObject is TGmPieShape) then Result := TGmPieShape.Create;
    Result.Assign(ASourceObject);
  end;

var
  ICount: integer;
begin
  Clear;
  // create & assign objects...
  for ICount := 0 to Source.Count-1 do
    FObjects.Add(CreateObject(Source.FObjects[ICount]));
  FShowFooter := Source.ShowFooter;
  FShowHeader := Source.ShowHeader;
  FPageSize.Assign(Source.PageSize);
  Changed(Self);
end;

procedure TGmPage.Clear;
var
  ICount: integer;
begin
  for ICount := FObjects.Count-1 downto 0 do
    DeleteGmObject(ICount);
  FMetafile.Clear;
  if Assigned(FMetafileRtf) then FMetafileRtf.Clear;
  FObjects.Clear;
end;

procedure TGmPage.LoadFromStream(AVersion: Extended; AStream: TStream);

  function CreateGmObject(FObjectID: integer): TGmBaseObject;
  begin
    case FObjectID of
      GM_GRAPHIC_ID     : Result := TGmGraphicObject.Create;
      GM_LINE_ID        : Result := TGmLineObject.Create;
      GM_TEXT_ID        : Result := TGmTextObject.Create;
      GM_TEXTBOX_ID     : Result := TGmTextBoxObject.Create;
      GM_ELLIPSE_ID     : Result := TGmEllipseShape.Create;
      GM_RECTANGLE_ID   : Result := TGmRectangleShape.Create;
      GM_ROUNDRECT_ID   : Result := TGmRoundRectShape.Create;
      GM_ARC_ID         : Result := TGmArcShape.Create;
      GM_CHORD_ID       : Result := TGmChordShape.Create;
      GM_PIE_ID         : Result := TGmPieShape.Create;
      {$IFDEF D4+}
      GM_POLYGON_ID     : Result := TGmPolygonObject.Create;
      GM_POLYLINE_ID    : Result := TGmPolyLineObject.Create;
      GM_POLYBEZIER_ID  : Result := TGmPolyBezierObject.Create;
      GM_POLYLINETO_ID  : Result := TGmPolyLineToObject.Create;
      GM_POLYBEZIERTO_ID: Result := TGmPolyBezierToObject.Create;
      {$ENDIF}
      GM_PATH_OBJECT_ID : Result := TGmPathObject.Create;
    else
      Result := nil;
    end;
  end;

var
  GmStream: TGmExtStream;
  NumObjects: integer;
  ICount: integer;
  AObjectID: integer;
  NewObject: TGmBaseObject;
begin
  // save the TGmPage to the passed AStream parameter...
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FOrientation := TGmOrientation(GmStream.ReadInteger);
    NumObjects := GmStream.ReadInteger;
    for ICount := 1 to NumObjects do
    begin
      GmStream.ReadBuffer(AObjectID, SizeOf(AObjectID));
      NewObject := CreateGmObject(AObjectID);
      if Assigned(NewObject) then
      begin
        AddObject(NewObject);
        NewObject.LoadFromStream(AVersion, GmStream);
      end;
    end;
    // introduced in v2.43...
    FShowHeader := True;
    FShowFooter := True;
    if (GmStream.Position < GmStream.Size) then
    begin
      FShowHeader := GmStream.ReadBoolean;
      FShowFooter := GmStream.ReadBoolean;
    end;
  finally
    GmStream.Free;
  end;
end;

procedure TGmPage.Print(APrinter: TGmCustomPrinter);
var
  GmPrinterObj: TGmPrinter;
  ICount: integer;
  //DC: HDC;
  ARect: TGmSize;
  RtfInfo: TGmRtfInformation;
  AOffset: TGmRtfOffset;
  AMarginRect: TGmRect;
  Rgn: HRGN;
  PpiX, PpiY: integer;
begin
  GmPrinterObj := (APrinter as TGmPrinter);
  ARect := GmSize(GmPrinterObj.PrinterWidth.AsInches, GmPrinterObj.PrinterHeight.AsInches);

  if GmPrinterObj.PagesPerSheet = gmOnePage then
  begin
    // draw the richtext...
    RtfInfo := TGmRtfInformation(FPageList.FRtfInformation);
    AOffset := RtfInfo.OffsetForPage[FPageNum];

    if Assigned(AOffset) then
    begin
      AMarginRect := FMargins.AsInches;
      AMarginRect.Top := AOffset.MarginTop;
      AMarginRect.Bottom := AOffset.MarginBottom;
      DrawRichText(Printer.Canvas,
                   RtfInfo.RichEdit,
                   AOffset.StartChar,
                   AOffset.EndChar,
                   AMarginRect,
                   ARect);
    end;
  end
  else
    GmPrinterObj.Canvas.StretchDraw(GmRect(0,0,ARect.Width, ARect.Height), MetafileRtf);

  PpiX := GmPrinterObj.PrinterPpiX;
  PpiY := GmPrinterObj.PrinterPpiY;
  if FMargins.ClipMargins then
    Rgn := CreateRectRgn(Round(FMargins.Left.AsInches * PpiX) - GmPrinterObj.Offset.x,
                         Round(FMargins.Top.AsInches * PpiY) - GmPrinterObj.Offset.y,
                         Round((FPageSize.Width.AsInches * PpiX) - (FMargins.Right.AsInches * PpiX)) - GmPrinterObj.Offset.x,
                         Round((FPageSize.Height.AsInches * PpiY) - (FMargins.Bottom.AsInches * PpiY))- GmPrinterObj.Offset.y)
  else
    Rgn := 0;

  // draw the objects...
  for ICount := 0 to FObjects.Count-1 do
    TGmBaseObject(GmObject[ICount]).Print(GmPrinterObj, Rgn);
  FHeader.Print(GmPrinterObj, FPageNum);
  FFooter.Print(GmPrinterObj, FPageNum);
end;

procedure TGmPage.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
  ICount: integer;
begin
  // load the TGmPage from the passed AStream parameter...
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteInteger(Ord(FOrientation));
    GmStream.WriteInteger(Self.Count);

    for ICount := 0 to Self.Count-1 do
      GmObject[ICount].SaveToStream(GmStream);

    // introduced in v2.43...
    GmStream.WriteBoolean(FShowHeader);
    GmStream.WriteBoolean(FShowFooter);
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

function TGmPage.RedrawPage: Boolean;
begin
  Result := (FHasChanged) or (FRtfChanged);
  //FHasChanged := True;
  //FRtfChanged := True;
  Redraw(DRAWING_DPI);
  RedrawRtf;
end;

//------------------------------------------------------------------------------

// *** TGmPageList Constructor/Destructor ***

constructor TGmPageList.Create;
begin
  inherited Create;
  FPages := TList.Create;
  FPageSize := TGmValueSize.Create;
  FRtfInformation := TGmRtfInformation.Create;
  FPageSize.OnChange := PageSizeChange;
  PaperSize := A4;
end;

destructor TGmPageList.Destroy;
begin
  Clear;
  FPages.Free;
  FPageSize.Free;
  FRtfInformation.Free;
  inherited Destroy;
end;

//------------------------------------------------------------------------------

// *** Private functions ***

function TGmPageList.GetOrientationType: TGmOrientationType;
var
  ICount: integer;
begin
  if FOrientation = gmPortrait then Result := gmPortraitReport
  else
    Result := gmLandscapeReport;
  for ICount := 1 to Count do
    if Page[ICount].Orientation <> FOrientation then Result := gmMixedOrientation;
end;

function TGmPageList.GetPage(index: integer): TGmPage;
begin
  Result := TGmPage(FPages[index-1]);
end;

function TGmPageList.GetPageCount: integer;
begin
  Result := FPages.Count;
end;

function TGmPageList.GetPageHeight: TGmValue;
begin
  Result := FPageSize.Height;
end;

function TGmPageList.GetPageWidth: TGmValue;
begin
  Result := FPageSize.Width;
end;

procedure TGmPageList.Repaginate;
var
  ICount: integer;
begin
  for ICount := 1 to Count do
    Page[ICount].FPageNum := ICount;
end;

procedure TGmPageList.SetOrientation(AOrientation: TGmOrientation);
var
  ICount: integer;
  PW, PH: integer;
begin
  if FOrientation <> AOrientation then
  begin
    FOrientation := AOrientation;
    if FOrientation = gmPortrait then
    begin
      PW := Min(PageWidth.AsUnits, PageHeight.AsUnits);
      PH := Max(PageWidth.AsUnits, PageHeight.AsUnits);
    end
    else
    begin
      PW := Max(PageWidth.AsUnits, PageHeight.AsUnits);
      PH := Min(PageWidth.AsUnits, PageHeight.AsUnits);
    end;
    FPageSize.Width.AsUnits := PW;
    FPageSize.Height.AsUnits := PH;
    for ICount := 1 to Count do
    begin
      Page[ICount].FOrientation := FOrientation;
      Page[ICount].FPageSize.Width.AsUnits := PW;
      Page[ICount].FPageSize.Height.AsUnits := PH;
    end;
    UpdateAll;
  end;
end;

procedure TGmPageList.SetPage(index: integer; APage: TGmPage);
begin
  FPages[index-1] := APage;
end;

procedure TGmPageList.SetPaperSize(APaperSize: TGmPaperSize);
var
  ASize: TGmSize;
  TempVal: Extended;
begin
  ASize := GetPaperDimensions(APaperSize);
  if FOrientation = gmLandscape then
  begin
    TempVal := ASize.Height;
    ASize.Height := ASize.Width;
    ASize.Width := TempVal;
  end;
  FPageSize.Height.AsInches := ASize.Height;
  FPageSize.Width.AsInches := ASize.Width;
end;

procedure TGmPageList.UpdatePageSizes;
var
  ICount: integer;
begin
  for ICount := 1 to Count do
    Page[ICount].PageSize.Assign(FPageSize);
end;

// *** Events ***

procedure TGmPageList.PageSizeChange(Sender: TObject);
begin
  UpdatePageSizes;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TGmPageList.PageOrientationChange(Sender: TObject; PageNum: integer; AOrientation: TGmOrientation);
begin
  if Assigned(FOnPageOrientationChanged) then FOnPageOrientationChanged(Sender, PageNum, AOrientation);
end;

//------------------------------------------------------------------------------

// *** Public functions ***

function TGmPageList.AddPage: TGmPage;
begin
  Result := TGmPage.Create;
  Result.FPageList := Self;
  Result.Orientation := FOrientation;
  Result.PageSize.Height.Assign(FPageSize.Height);
  Result.PageSize.Width.Assign(FPageSize.Width);
  Result.Header := FHeader;
  Result.Footer := FFooter;
  Result.Margins := FMargins;
  Result.OnPageOrientationChanged := PageOrientationChange;
  FPages.Add(Result);
  Repaginate;
  UpdateAll;
end;

procedure TGmPageList.Assign(Source: TGmPageList);
var
  ICount: integer;
begin
  Clear;
  while Count < Source.Count do AddPage;
  for ICount := 1 to Count do
    Page[ICount].Assign(Source.Page[ICount]);
end;

procedure TGmPageList.Clear;
var
  ICount: integer;
begin
  for ICount := FPages.Count downto 1 do
    DeletePage(ICount);
  FPages.Clear;
  //AddPage;
end;

procedure TGmPageList.DeletePage(APageNum: integer);
begin
  Page[APageNum].Free;
  Page[APageNum] := nil;
  FPages.Delete(APageNum-1);
  Repaginate;
  UpdateAll;
end;

procedure TGmPageList.UpdateAll;
var
  ICount: integer;
begin
  for ICount := 1 to Count do
    Page[ICount].FHasChanged := True;
end;

//------------------------------------------------------------------------------

// *** TGmShadow ***

constructor TGmShadow.Create;
begin
  inherited Create;
  FColor := clBlack;
  FVisible := True;
  FWidth := 5;
end;

procedure TGmShadow.Assign(Source: TPersistent);
var
  AShadow: TGmShadow;
begin
  AShadow := (Source as TGmShadow);
  FWidth := AShadow.Width;
  FColor := AShadow.Color;
  FVisible := AShadow.Visible;
  Changed;
end;

//------------------------------------------------------------------------------

// *** Private functions ***

procedure TGmShadow.Changed;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TGmShadow.SetColor(AColor: TColor);
begin
  if FColor <> AColor then
  begin
    FColor := AColor;
    Changed;
  end;
end;

procedure TGmShadow.SetVisible(AValue: Boolean);
begin
  if FVisible <> AValue then
  begin
    FVisible := AValue;
    Changed;
  end;
end;

procedure TGmShadow.SetWidth(AValue: integer);
begin
  if FWidth <> AValue then
  begin
    FWidth := AValue;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

// *** TGmPaperImage ***

constructor TGmPaperImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FValue1 := TGmValue.Create;
  FValue2 := TGmValue.Create;
  FGutter := DEFAULT_GUTTER;
  FZoom := DEFAULT_ZOOM;
  FBorders := Rect(0,0,0,0);
  FPaperSize := A4;
  FEnabled := True;
end;

destructor TGmPaperImage.Destroy;
begin
  FValue1.Free;
  FValue2.Free;
  inherited Destroy;
end;

function TGmPaperImage.GetPageRect: TRect;
begin
  Result := Rect(FGutter + Borders.Left,
                 FGutter + Borders.Top,
                 Width-FGutter - Borders.Right,
                 Height-FGutter - Borders.Bottom);
  {if Assigned(FShadow) then
  begin
    Result.Right := Result.Right - FShadow.Width;
    Result.Bottom := Result.Bottom - FShadow.Width;
  end;}
end;

function TGmPaperImage.GetScale: Extended;
begin
  Result := FZoom/ 100;
end;

function TGmPaperImage.MouseOverPage(x,y: integer): Boolean;
begin
  Result := (x > FGutter) and
            (y > FGutter) and
            (x < (Width - FGutter)) and
            (y < (Height - FGutter));
end;

procedure TGmPaperImage.SetMargins(AMargins: TGmMargins);
begin
  FMargins := AMargins;
  if Assigned(FMargins) then
    FMargins.OnChange := Changed;
end;

procedure TGmPaperImage.SetShadow(AShadow: TGmShadow);
begin
  FShadow := AShadow;
  if Assigned(FShadow) then
    FShadow.OnChange := Changed;
end;

procedure TGmPaperImage.Changed(Sender: TObject);
begin
  if HasParent then Invalidate;
end;

//------------------------------------------------------------------------------

// *** Protected functions ***

procedure TGmPaperImage.DragDrop(Source: TObject; X, Y: Integer);
var
  NewX,
  NewY: Extended;
begin
  inherited;
  if (MouseOverPage(X, Y)) and (Assigned(FOnPageDragDrop)) then
  begin
    NewX := ((X-FGutter) / GetScale);
    NewY := ((Y-FGutter) / GetScale);
    FValue1.AsInches := NewX / SCREEN_PPI;
    FValue2.AsInches := NewY / SCREEN_PPI;
    FOnPageDragDrop(Self, Source, FValue1, FValue2);
  end;
end;

procedure TGmPaperImage.DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
var
  NewX,
  NewY: Extended;
begin
  inherited;
  if (MouseOverPage(X, Y)) and (Assigned(FOnPageDragOver)) then
  begin
    NewX := ((X-FGutter) / GetScale);
    NewY := ((Y-FGutter) / GetScale);
    FValue1.AsInches := NewX / SCREEN_PPI;
    FValue2.AsInches := NewY / SCREEN_PPI;
    FOnPageDragOver(Self, Source, FValue1, FValue2, State, Accept);
  end;
end;

procedure TGmPaperImage.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  NewX,
  NewY: Extended;
begin
  inherited;
  if (MouseOverPage(X, Y)) and (Assigned(FOnPageMouseDown)) then
  begin
    NewX := ((X-FGutter) / GetScale);
    NewY := ((Y-FGutter) / GetScale);
    FValue1.AsInches := NewX / SCREEN_PPI;
    FValue2.AsInches := NewY / SCREEN_PPI;
    FOnPageMouseDown(Self, Button, Shift, FValue1, FValue2);
  end;
end;

procedure TGmPaperImage.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewX,
  NewY: Extended;
begin
  inherited;
  if (MouseOverPage(X, Y)) and (Assigned(FOnPageMouseMove)) then
  begin
    NewX := ((X-FGutter) / GetScale);
    NewY := ((Y-FGutter) / GetScale);
    FValue1.AsInches := NewX / SCREEN_PPI;
    FValue2.AsInches := NewY / SCREEN_PPI;
    FOnPageMouseMove(Self, Shift, FValue1, FValue2);
  end;
end;

procedure TGmPaperImage.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  NewX,
  NewY: Extended;
begin
  inherited;
  if (MouseOverPage(X, Y)) and (Assigned(FOnPageMouseUp)) then
  begin
    NewX := ((X-FGutter) / GetScale);
    NewY := ((Y-FGutter) / GetScale);
    FValue1.AsInches := NewX / SCREEN_PPI;
    FValue2.AsInches := NewY / SCREEN_PPI;
    FOnPageMouseUp(Self, Button, Shift, FValue1, FValue2);
  end;
end;

procedure TGmPaperImage.Paint;
var
  Sw: integer;
  MarginRect: TRect;
begin
  Canvas.Brush.Color := clWhite;
  Canvas.Pen.Color := clBlack;
  Canvas.Pen.Style := psSolid;
  Canvas.FillRect(PageRect);

  if (Assigned(Page)) and (FEnabled) then
  begin
    if Assigned(Page.MetafileRtf) then Canvas.StretchDraw(PageRect, Page.MetafileRtf);
    Canvas.StretchDraw(PageRect, Page.Metafile);
  end;


  Canvas.Brush.Style := bsClear;
  Canvas.Rectangle(PageRect.Left, PageRect.Top, PageRect.Right, PageRect.Bottom);

  if Assigned(FShadow) then
  begin
    if FShadow.Visible then
    begin
      Sw := FShadow.Width;
      Canvas.Pen.Color := FShadow.Color;
      Canvas.Brush.Color := FShadow.Color;
      Canvas.Rectangle(PageRect.Right, PageRect.Top+Sw, PageRect.Right+Sw, PageRect.Bottom+Sw);
      Canvas.Rectangle(PageRect.Left+Sw, PageRect.Bottom, PageRect.Right+Sw, PageRect.Bottom+Sw);
    end;
  end;

  if Assigned(FMargins) then
  begin
    if FMargins.Visible then
    begin
      MarginRect := PageRect;
      Canvas.Pen.Assign(FMargins.Pen);
      Canvas.Brush.Style := bsClear;
      MarginRect.Left   := (PageRect.Left   + Round(GetScale * FMargins.Left.AsPixels[SCREEN_PPI]))-1;
      MarginRect.Top    := (PageRect.Top    + Round(GetScale * FMargins.Top.AsPixels[SCREEN_PPI]))-1;
      MarginRect.Right  := (PageRect.Right  - Round(GetScale * FMargins.Right.AsPixels[SCREEN_PPI]));
      MarginRect.Bottom := (PageRect.Bottom - Round(GetScale * FMargins.Bottom.AsPixels[SCREEN_PPI]));
      Canvas.PolyLine([MarginRect.TopLeft,
                       Point(MarginRect.Right, MarginRect.Top),
                       MarginRect.BottomRight,
                       Point(MarginRect.Left, MarginRect.Bottom),
                       MarginRect.TopLeft]);
    end;
    if FMargins.ShowPrinterMargins then
    begin
      MarginRect := PageRect;
      Canvas.Pen.Assign(FMargins.FPrinterPen);
      Canvas.Brush.Style := bsClear;
      MarginRect.Left   := PageRect.Left   + Round(GetScale * FMargins.PrinterMargins.Left.AsPixels[SCREEN_PPI])-1;
      MarginRect.Top    := PageRect.Top    + Round(GetScale * FMargins.PrinterMargins.Top.AsPixels[SCREEN_PPI])-1;
      MarginRect.Right  := PageRect.Right  - Round(GetScale * FMargins.PrinterMargins.Right.AsPixels[SCREEN_PPI]);
      MarginRect.Bottom := PageRect.Bottom - Round(GetScale * FMargins.PrinterMargins.Bottom.AsPixels[SCREEN_PPI]);
      Canvas.PolyLine([MarginRect.TopLeft,
                       Point(MarginRect.Right, MarginRect.Top),
                       MarginRect.BottomRight,
                       Point(MarginRect.Left, MarginRect.Bottom),
                       MarginRect.TopLeft]);
    end;
  end;

end;

end.
