{******************************************************************************}
{                                                                              }
{                           TGmPreview 1.3  - Lite                                   }
{                                                                              }
{           Copyright (c) 2000 Graham Murt  - www.MurtSoft.com                 }
{                                                                              }
{      Feel free to e-mail me with any comments, suggestions or help at:       }
{                                                                              }
{                           info@murtsoft.com                                   }
{                                                                              }
{******************************************************************************}

{

This component's history including bug fixes are included in the documentation.

To purchase the full version with the extra features as explained in the documentation contact...

graham@murtsoft.com

}

unit GmPreview;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, Printers;

const
  ABOUT_GMREPORT = 'TGmPreview - (c) Graham Murt 2000';
  VERSION = '1.3';
  MmPerInch     = 25.403;  // I'm using 25.403 instead of 25.4 because I found that it gives better results.
  DefaultDPI    = 300;
  MaxPixelCount = 32768;

type
  TGmType = (gmRectangle, gmEllipse, gmText, gmPicture, gmLine, gmTable);

  TGmPagesPerSheet = (gmOnePage, gmTwoPages, gmFourPages);
  TGmFont = record
    Name  : string;
    Size  : integer;
    Color : TColor;
    Style : TFontStyles;
  end;

  // this is basically a TRect structure but it uses double's instead of longInt's
  TGmRect = record
    Left: double;
    Top: double;
    Right: double;
    Bottom: double;
  end;

  TGmPen = record
    Style : TPenStyle;
    Width : integer;
    Color : TColor;
  end;

  TGmBrush = record
    Color : TColor;
    Style : TBrushStyle;
  end;

// because of a bug that kept making an appereance when adding to a metafile where
// the more times you added to it, the slower it became, I keep
// all metafile objects in a list of the below record and redraw the whole page each time
// the display needs updating.

  PGmMetaFileRec = ^TGmMetaFileRec;
  TGmMetaFileRec = record
    alignment  : TAlignment;
    left       : integer;
    top        : integer;
    right      : integer;
    bottom     : integer;
    X3,Y3,X4,Y4: integer;   // used for Arcs and other constructs...
    rows       : integer;
    cols       : integer;
    Text       : string;
    gmType     : TGmType;
    gmFont     : TGmFont;
    gmBrush    : TGmBrush;
    gmPen      : TGmPen;
    Page       : integer;
    Graphic    : TPicture;
  end;

  TGmPreview = class;

  // record that holds header/footer information...

  TGmHeaderFooter = class(TPersistent)
  private
    FText: string;
    FFont: TFont;
    FBrush: TBrush;
    FLine: TPen;
    FParent: TGmPreview;
    FShowLine: Boolean;
    FVisible: Boolean;
    procedure SetText(Value: string);
    procedure SetFont(Value: TFont);
    procedure SetBrush(Value: TBrush);
    procedure SetLine(Value: TPen);
    procedure SetShowLine(Value: Boolean);
    procedure SetVisible(Value: Boolean);
    procedure OnFontChange(Sender: TObject);
    procedure OnBrushChange(Sender: TObject);
    procedure OnLineChange(Sender: TObject);
  public
    constructor Create(AOwner: TGmPreview; AInitialText: string);
    destructor Destroy; override;
  published
    property Text: string read FText write SetText;
    property Font: TFont read FFont write SetFont;
    property Brush: TBrush read FBrush write SetBrush;
    property Line: TPen read FLine write SetLine;
    property ShowLine: Boolean read FShowLine write SetShowLine default True;
    property Visible: Boolean read FVisible write SetVisible default True;
  end;

  // record that holds information on the page margins...

  TGmMargin = class(TPersistent)
  private
    FMarginColor: TColor;
    FParent: TGmPreview;
    FShowMargins: Boolean;
    procedure SetMarginColor(AColor: TColor);
    procedure SetShowMargins(AValue: Boolean);
  public
    constructor Create(AOwner: TGmPreview);
    destructor Destroy; override;
  published
    property MarginColor: TColor read FMarginColor write SetMarginColor default clSilver;
    property ShowMargins: Boolean read FShowMargins write SetShowMargins default True;
  end;

  TGmCanvas = TMetafileCanvas;

  // TGmPages is a list of metafiles (the pages)
  // TGmPageDefs is a list of all metafile objects on all pages (list of TGmMetafileRec)

  TGmPages = TList;
  TGmPageDefs = TList;

  TGmPreview = class(TScrollingWinControl)
  private
    // TGmPreview definition...
    FAbout: string;
    FAllowMouseZoom: boolean;
    FCanvas: TGmCanvas;
    FCanvasFont: TFont;
    FCanvasBrush: TBrush;
    FCanvasPen: TPen;
    FCurrentPage: integer;
    FFooter: TGmHeaderFooter;
    FHeader: TGmHeaderFooter;
    FLastCanvasPen: TPen;
    FMargin: TGmMargin;
    FMinZoom: integer;
    FMaxZoom: integer;
    FPage: TMetafile;
    FPages: TGmPages;
    FPageDefs: TGmPageDefs;
    FPaintBox: TPaintBox;
    FPreviewWidth: integer;
    FPreviewHeight: integer;
    FPrintCollate: Boolean;
    FPrintCopies: integer;
    FPrinter: TPrinter;
    FShadowColor: TColor;
    FShadowWidth: integer;
    FShowShadow: Boolean;
    FShowPrintProgress: Boolean;
    FZoom: integer;

    FAfterPrint: TNotifyEvent;
    FBeforePrint: TNotifyEvent;
    FOnAbortPrint: TNotifyEvent;
    FOnClear: TNotifyEvent;
    FOnPageChange: TNotifyEvent;
    FOnPageDraw: TNotifyEvent;
    FOnNewPage: TNotifyEvent;
    FOnZoom: TNotifyEvent;

    // private functions...
    function GetAvailablePageWidth: integer;
    function GetAvailablePageHeight: integer;
    function GetHeaderHeightMm: double;
    function GetFooterHeightMm: double;
    function GetMarginLeft: integer;
    function GetMarginTop: integer;
    function GetMarginRight: integer;
    function GetMarginBottom: integer;
    function GetMarginRect: TRect;
    function GetMmMarginRect: TGmRect;
    function GetMmAvailablePageWidth: double;
    function GetMmAvailablePageHeight: double;
    function GetMmPhysicalPageWidth: double;
    function GetMmPhysicalPageHeight: double;
    function GetNumPages: integer;
    function GetPhysicalPrinterWidth: integer;
    function GetPhysicalPrinterHeight: integer;


    // private procedures...
    procedure PaintPreview(Sender: TObject); // OnPaint handler for TPaintBox;
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure SetCanvasBrush(AValue: TBrush);
    procedure SetCanvasFont(AValue: TFont);
    procedure SetCanvasPen(AValue: TPen);

    procedure SetCurrentPage(APage: integer);
    procedure SetShadowColor(AValue: TColor);
    procedure SetShadowWidth(AValue: integer);
    procedure SetShowShadow(AValue: boolean);
    procedure SetZoom(AValue: integer);
    procedure UpdateDimensions(AScaleFactor: double);
  protected

    // protected functions...
    function GetPrinterToPreviewH(AValue: integer): integer;
    function GetPrinterToPreviewV(AValue: integer): integer;
    function PrinterMmToPixelsX(AValue: double): integer;
    function PrinterMmToPixelsY(AValue: double): integer;
    function PrinterPixelsToMmX(AValue: integer): double;
    function PrinterPixelsToMmY(AValue: integer): double;
    function GetPixelsPerInch: integer;

    // protected procedures...
    procedure ShowPrintProgress;
    procedure CanvasPropertiesToRec(ARec: PGmMetaFileRec);
    procedure WriteFooter;
    procedure WriteHeader;

    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // public functions...
    function MmTextHeight(AText: string): double;
    function MmTextWidth(AText: string): double;
    function NewPage: integer;    // returns the number of the page added...

    // public procedures...
    procedure FreeAllPages;
    procedure Clear;
    procedure RedrawPage(UpdatePreview: Boolean);

    // Millimeter drawing functions...
    procedure MmLine(X,Y, X2, Y2: double);
    procedure MmEllipse(X,Y,X2,Y2: double);
    procedure MmRectangle(X,Y,X2,Y2: double);
    procedure MmTable(X,Y,X2,Y2: double; ARows,ACols: integer);
    procedure MmDraw(X,Y: double; AGraphic: TPicture);
    procedure MmStretchDraw(ARect: TRect; AGraphic: TPicture);
    procedure MmTextOut(X,Y: double; AText: string);

    procedure FirstPage;
    procedure PrevPage;
    procedure NextPage;
    procedure LastPage;
    procedure Print;

    // public properties...
    property AvailablePageWidth: integer read GetAvailablePageWidth;
    property AvailablePageHeight: integer read GetAvailablePageHeight;
    property CanvasBrush: TBrush read FCanvasBrush write SetCanvasBrush;
    property CanvasFont: TFont read FCanvasFont write SetCanvasFont;
    property CanvasPen: TPen read FCanvasPen write SetCanvasPen;
    property NumCopies: integer read FPrintCopies write FPrintCopies;
    property CurrentPage: integer read FCurrentPage write SetCurrentPage;
    property MarginLeft: integer read GetMarginLeft;
    property MarginTop: integer read GetMarginTop;
    property MarginRight: integer read GetMarginRight;
    property MarginBottom: integer read GetMarginBottom;
    property MarginRect: TRect read GetMarginRect;
    property MmAvailablePageWidth: double read GetMmAvailablePageWidth;
    property MmAvailablePageHeight: double read GetMmAvailablePageHeight;
    property MmFooterHeight: double read GetFooterHeightMm;
    property MmHeaderHeight: double read GetHeaderHeightMm;
    property MmMarginRect: TGmRect read GetMmMarginRect;
    property MmPhysicalPageWidth: double read GetMmPhysicalPageWidth;
    property MmPhysicalPageHeight: double read GetMmPhysicalPageHeight;
    property NumPages: integer read GetNumPages;
    property PhysicalPrinterWidth: integer read GetPhysicalPrinterWidth;
    property PhysicalPrinterHeight: integer read GetPhysicalPrinterHeight;
    property PixelsPerInch: integer read GetPixelsPerInch;

    { Public declarations }
  published
    // published properties...
    property About: string read FAbout write FAbout stored False;
    property Align;
    property AllowMouseZoom: boolean read FAllowMouseZoom write FAllowMouseZoom default True;
    property AutoScroll;
    property Color;
    property Enabled;
    property Footer: TGmHeaderFooter read FFooter write FFooter;
    property Header: TGmHeaderFooter read FHeader write FHeader;
    property Margins: TGmMargin read FMargin write FMargin;
    property ParentColor;
    property PopupMenu;
    property ShadowColor: TColor read FShadowColor write SetShadowColor default clBlack;
    property ShadowWidth: integer read FShadowWidth write SetShadowWidth default 3;
    property ShowShadow: Boolean read FShowShadow write SetShowShadow default True;
    property PrintProgressBox: Boolean read FShowPrintProgress write FShowPrintProgress default True;
    property Tag;
    property Visible;
    property Zoom: integer read FZoom write SetZoom default 25;

    // published events...
    property BeforePrint: TNotifyEvent read FBeforePrint write FBeforePrint;
    property AfterPrint: TNotifyEvent read FAfterPrint write FAfterPrint;
    property OnAbortPrint: TNotifyEvent read FOnAbortPrint write FOnAbortPrint;
    property OnClear: TNotifyEvent read FOnClear write FOnClear;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnNewPage: TNotifyEvent read FOnNewPage write FOnNewPage;
    property OnPageChange: TNotifyEvent read FOnPageChange write FOnPageChange;
    property OnPageDraw: TNotifyEvent read FOnPageDraw write FOnPageDraw;
    //property OnPrintProgress: TNotifyEvent read FOnPrintProgress write FOnPrintProgress;
    property OnStartDrag;
    property OnZoom: TNotifyEvent read FOnZoom write FOnZoom;
{ Published declarations }
  end;

procedure Register;

implementation

uses GmProgress;

//------------------------------------------------------------------------------

// header and footer procedures...

constructor TGmHeaderFooter.Create(AOwner: TGmPreview; AInitialText: string);
begin
  // create and initialize the values of the header and footer...
  inherited Create;
  FParent := AOwner;
  FText := AInitialText;
  // create font...
  FFont := TFont.Create;
  FFont.Name := 'Times New Roman';
  FFont.Size := 14;
  FFont.Style := [];
  FFont.Color := clBlack;
  FFont.OnChange := OnFontchange;
  // create brush...
  FBrush := TBrush.Create;
  FBrush.Color := clWhite;
  FBrush.Style := bsClear;
  FBrush.OnChange := OnBrushChange;
  // create pen...
  FLine := TPen.Create;
  FLine.Color := clBlack;
  FLine.Style := psSolid;
  FLine.Width := 1;
  FLine.OnChange := OnLineChange;
  FShowLine := True;
  FVisible := True;
end;

destructor TGmHeaderFooter.Destroy;
begin
  // free up the memory held by the header/footer and destroy the object...
  FFont.Free;
  FFont := nil;
  FBrush.Free;
  FBrush := nil;
  FLine.Free;
  FLine := nil;
  {header/footer destruction code...}
  inherited;
end;


procedure TGmHeaderFooter.SetBrush(Value: TBrush);
begin
  // change the text background color of the header/footer...
  if FBrush <> Value then
    FBrush.Assign(Value);
end;

procedure TGmHeaderFooter.SetFont(Value: TFont);
begin
  // change header/footer font...
  if FFont <> Value then
    FFont.Assign(Value);
end;

procedure TGmHeaderFooter.SetLine(Value: TPen);
begin
  // change header/footer line...
  if FLine <> Value then
    FLine.Assign(Value);
end;

procedure TGmHeaderFooter.SetShowLine(Value: Boolean);
begin
  // change header/footer line visibility...
  if FShowLine <> Value then
  begin
    FShowLine := Value;
    if FVisible then FParent.RedrawPage(True);
  end;
end;

procedure TGmHeaderFooter.SetText(Value: string);
begin
  // change header/footer text...
  if FText <> Value then
  begin
    FText := Value;
    if FVisible then FParent.RedrawPage(True);
  end;
end;

procedure TGmHeaderFooter.SetVisible(Value: Boolean);
begin
  // change header/footer visibility...
  if FVisible <> Value then
  begin
    FVisible := Value;
    FParent.RedrawPage(True);
  end;
end;

// header and footer change events...

procedure TGmHeaderFooter.OnBrushChange(Sender: TObject);
begin
  if FVisible then FParent.RedrawPage(True);
end;

procedure TGmHeaderFooter.OnFontChange(Sender: TObject);
begin
  if FVisible then FParent.RedrawPage(True);
end;

procedure TGmHeaderFooter.OnLineChange(Sender: TObject);
begin
  if FVisible then FParent.RedrawPage(True);
end;

//------------------------------------------------------------------------------

// *** Margins...  ***

// Margin construction/destruction...

constructor TGmMargin.Create(AOwner: TGmPreview);
begin
  inherited Create;
    // initialization code here...
  FParent := AOwner;
  FShowMargins := True;
  FMarginColor := clSilver;
end;

destructor TGmMargin.Destroy;
begin
  // destruction code here...
  inherited Destroy;
end;

procedure TGmMargin.SetMarginColor(AColor: TColor);
begin
  // change margin color...
  if FMarginColor <> AColor then
  begin
    FMarginColor := AColor;
    FParent.Invalidate;
  end;
end;

procedure TGmMargin.SetShowMargins(AValue: Boolean);
begin
  // change margin visibility...
  if FShowMargins <> AValue then
  begin
    FShowMargins := AValue;
    FParent.Invalidate;
  end;
end;



//------------------------------------------------------------------------------

// Pages container procedures...

function TGmPreview.NewPage: integer;    // returns the number of the page added...
begin
  // create a new metafile for the page...
  FPage := TMetaFile.Create;
  // set the metafile dimensions to that of the printer canvas and add it to the page list...
  FPage.Width := PhysicalPrinterWidth;
  FPage.Height := PhysicalPrinterHeight;
  FPages.Add(FPage);
  Result := FPages.Count;
  // set the current page to the page that has been added...
  CurrentPage := FPages.Count;
  RedrawPage(True);
  if Assigned(FOnNewPage) then FOnNewPage(Self);
end;

procedure TGmPreview.FreeAllPages;
var
  count: integer;
  AMetaFile: TMetafile;
  PRec: PGmMetaFileRec;
begin
  // this procedure frees all of the objects on all of the metafiles and then
  // deletes all of the metafiles...

  // free all of the objects...
  Count := 0;
  while count <> FPageDefs.count do
  begin
    PRec := PGmMetaFileRec(FPageDefs[count]);
    if PRec^.gmType = gmPicture then
    begin
      PRec^.Graphic.Free;
      PRec^.Graphic := nil;
    end;
    Dispose(FPageDefs[count]);
    FPageDefs[count] := nil;
    inc(count);
  end;
  FPageDefs.Pack;

  // free all of the metafiles in the pages list
  count := 0;
  while count <> FPages.Count do
  begin
    AMetaFile := TMetaFile(FPages[count]);
    AMetaFile.Free;
    FPages[count] := nil;
   inc(Count);
  end;
  FPages.Pack;
end;

procedure TGmPreview.Clear;
begin
  // calling clear calls the above procedure but leaves you with a blank
  // page...(page 1)
  FreeAllPages;
  NewPage;
  FOnPageChange(Self);
end;

procedure TGmPreview.LastPage;
begin
  // jump to the last page...
  if FCurrentPage < FPages.Count then
  begin
    CurrentPage := FPages.Count;
    FPaintBox.Invalidate;
  end;
end;

procedure TGmPreview.NextPage;
begin
  // move one page forward...
  if FCurrentPage < FPages.Count then
  begin
    CurrentPage := CurrentPage+1;
    FPaintBox.Invalidate;
  end;
end;

procedure TGmPreview.PrevPage;
begin
  // move one page back...
  if FCurrentPage > 1 then
  begin
    CurrentPage := CurrentPage-1;
    FPaintBox.Invalidate;
  end;
end;

procedure TGmPreview.FirstPage;
begin
  // jump to the first page...
  if FCurrentPage > 1 then
  begin
    CurrentPage := 1;
    FPaintBox.Invalidate;
  end;
end;

procedure TGmPreview.SetCurrentPage(APage: integer);
begin
  // this is the procedure that is called when the value of "Current Page" is changed...
  if FCurrentPage <> APage then
  begin
    FCurrentPage := APage;
    FPaintBox.Invalidate;
    if Assigned(FOnPageChange) then FOnPageChange(Self);
    RedrawPage(True);
  end;
end;

function TGmPreview.GetNumPages: integer;
begin
  // return the total number of pages in the preview...
  Result := FPages.Count;
end;

//------------------------------------------------------------------------------
//   ***  TGmPreview  ***

// construction/Destruction...

constructor TGmPreview.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  // create the header and footer objects...
  FHeader := TGmHeaderFooter.Create(Self, '<header text>');
  FFooter := TGmHeaderFooter.Create(Self, '<footer text>');

  // this line is because we dont want to accept
  ControlStyle := ControlStyle - [csAcceptsControls];

  // set up preview canvas...
  FPaintbox := TPaintbox.Create(Self);
  FPaintBox.Align := alClient;
  FPaintBox.Align := alClient;
  FPaintBox.Parent := Self;
  FPaintBox.OnPaint := PaintPreview;
  FPaintBox.OnMouseDown := PaintBoxMouseDown;

  // hold private pointer to printer...
  FPrinter := Printers.Printer;

  // create margins object...
  FMargin := TGmMargin.Create(Self);

  // create pages container and object list container...
  FPages := TGmPages.Create;
  FPageDefs := TGmPageDefs.Create;

  // create the canvas defaults...
  FCanvasFont := TFont.Create;
  FCanvasFont.Name := 'Times New Roman';
  FCanvasFont.Size := 14;
  FCanvasFont.Style := [fsBold];
  FCanvasBrush := TBrush.Create;
  FCanvasBrush.Style := bsSolid;
  FCanvasBrush.Color := clWhite;
  FCanvasPen := TPen.Create;
  FCanvasPen.Color := clBlack;
  FCanvasPen.Style := psSolid;
  FCanvasPen.Width := 1;

  // set the print defaults...
  FPrintCopies := 1;
  FPrintCollate := True;
  FShowPrintProgress := True;

  // set the default component size and properties...
  Height := 329;
  Width := 257;
  HorzScrollBar.Tracking := True;
  VertScrollBar.Tracking := True;
  FZoom := 25;
  FMinZoom := 0;
  FMaxZoom := 10000;
  FAllowMouseZoom := True;
  FShowShadow := True;
  FShadowColor := clBlack;
  FShadowWidth := 3;

  // set the on-screen preview size in pixels...
  FPreviewWidth  := Round((FZoom/100) * GetPrinterToPreviewH(PhysicalPrinterWidth));
  FPreviewHeight := Round((FZoom/100) * GetPrinterToPreviewV(PhysicalPrinterHeight));
  FPaintBox.Canvas.Pen.Color := clBtnFace;
  Color := clBtnFace;
  NewPage;
  FCurrentPage := 1;
end;

destructor TGmPreview.Destroy;
begin
  // free up everything that was created in the above constructor...
  FreeAllPages;
  FHeader.Free;
  FHeader := nil;
  FFooter.Free;
  FFooter := nil;
  FCanvasFont.Free;
  FCanvasFont := nil;
  FCanvasBrush.Free;
  FCanvasBrush := nil;
  FCanvasPen.Free;
  FCanvasPen := nil;
  FMargin.Free;
  FMargin := nil;
  FPages.Free;
  FPages := nil;
  FPaintBox.Free;
  FPaintBox := nil;
  FLastCanvasPen.Free;
  FLastCanvasPen := nil;
  inherited Destroy;
end;

//------------------------------------------------------------------------------

// canvas drawing routines...

procedure CorrectFontSize(FCanvas: TMetaFileCanvas);
var
  FontSize: integer;
begin
  {This routine gets us around the Delphi tiny font bug.}
    FontSize := FCanvas.Font.Size;
    try
      FCanvas.Font.PixelsPerInch := GetDeviceCaps(Printer.Handle, LOGPIXELSY);
    except
      on EPrinter do FCanvas.Font.PixelsPerInch:=DefaultDPI;
    end;
    if FontSize < 144 then
      FCanvas.Font.Size := FontSize + 1
    else
      FCanvas.Font.Size := FontSize - 1;
    FCanvas.Font.Size := FontSize;
end;

procedure TGmPreview.RedrawPage(UpdatePreview: Boolean);
var
  count: integer;
  AMetaFileRec: PGmMetaFileRec;
  XInterval: Extended;
  YInterval: Extended;
  XPos: Extended;
  YPos: Extended;
  XCount: integer;
  YCount: integer;
  TempRec: TGmMetaFileRec;
begin
  // select the metafile that is the current page and clear it...
  FPage := TMetaFile(FPages[FCurrentPage-1]);
  FPage.Clear;
  // set it's width and height to that of the printer canvas...
  FPage.Width := PhysicalPrinterWidth;
  FPage.Height := PhysicalPrinterHeight;

  FCanvas := TMetaFileCanvas.Create(FPage, 0);

  for count := 0 to FPageDefs.Count-1 do
  begin
    // loop through the list of object definitions looking for objects that belong on the
    // current page...
    AMetaFileRec := PGmMetaFileRec(FPageDefs[count]);
    if AMetaFileRec^.Page = CurrentPage then
    begin                                                       
      // set the common properties... (font, brush and pen)

      // set brush...
      FCanvas.Brush.Color := AMetaFileRec^.gmBrush.Color;
      FCanvas.Brush.Style := AMetaFileRec^.gmBrush.Style;
      // set font...
      FCanvas.Font.Name  := AMetaFileRec^.gmFont.Name;
      FCanvas.Font.Size  := AMetaFileRec^.gmFont.Size;
      FCanvas.Font.Color := AMetaFileRec^.gmFont.Color;
      FCanvas.Font.Style := AMetaFileRec^.gmFont.Style;
      // set pen...
      FCanvas.Pen.Style := AMetaFileRec^.gmPen.Style;
      FCanvas.Pen.Width := AMetaFileRec^.gmPen.Width;
      FCanvas.Pen.Color := AMetaFileRec^.gmPen.Color;

      TempRec := AMetaFileRec^;

      case AMetaFileRec^.gmType of

        gmText:
        begin
          // code to draw the text...
          CorrectFontSize(FCanvas);
          FCanvas.TextOut(AMetaFileRec^.left, AMetaFileRec^.top, AMetaFileRec^.Text);
        end;

        gmRectangle:
        begin
          // code to draw a rectangle on the page...
          FCanvas.Rectangle(AMetaFileRec^.left, AMetaFileRec^.top, AMetaFileRec^.right, AMetaFileRec^.bottom);
        end;

        gmEllipse:
        begin
          // code to draw an ellipse on the page...
          FCanvas.Ellipse(AMetaFileRec^.left, AMetaFileRec^.top, AMetaFileRec^.right, AMetaFileRec^.bottom);
        end;

        gmLine:
        begin
          // code to draw a line on the page...
          FCanvas.MoveTo(AMetaFileRec^.left, AMetaFileRec^.top);
          FCanvas.LineTo(AMetaFileRec^.right, AMetaFileRec^.bottom);
        end;

        gmPicture:
        begin
          // code to draw an image on the page...
          FCanvas.StretchDraw(Rect(AMetaFileRec^.left,
                                   AMetaFileRec^.top,
                                   AMetaFileRec^.right,
                                   AMetaFileRec^.bottom),
                                   AMetaFileRec^.Graphic.Bitmap);
        end;

        gmTable:
        begin
          // code to draw a table on the page...
          FCanvas.Rectangle(AMetaFileRec^.left,
                            AMetaFileRec^.top,
                            AMetaFileRec^.right,
                            AMetaFileRec^.bottom);

          // work out the intervals for the horizontal and vertical grid lines...
          XInterval := (AMetaFileRec^.right - AMetaFileRec^.left) /AMetaFileRec^.cols;
          YInterval := (AMetaFileRec^.bottom - AMetaFileRec^.top) /AMetaFileRec^.rows;

          XPos := AMetaFileRec^.left + XInterval;
          YPos := AMetaFileRec^.top + YInterval;

          // draw the vertical lines...
          for XCount := 0 to AMetaFileRec^.cols-2 do
          begin
            with FCanvas do
            begin
              MoveTo(Round(XPos+0.5), AMetaFileRec^.top+Pen.Width);
              LineTo(Round(XPos+0.5), AMetaFileRec^.bottom-Pen.Width);
              XPos := XPos + XInterval;
            end;
          end;
          // draw the horizontal lines...
          for YCount := 0 to AMetaFileRec^.rows-2 do
          begin
            with FCanvas do
            begin
              MoveTo(AMetaFileRec^.left+Pen.Width, Round(YPos));
              LineTo(AMetaFileRec^.right-Pen.Width, Round(YPos));
              YPos := YPos + YInterval;
            end;
          end;
        end;
      end;
    end;

  end;
  if FHeader.Visible then  WriteHeader;
  if FFooter.Visible then WriteFooter;

  FCanvas.Free;
  FCanvas := nil;

  if UpdatePreview then FPaintBox.Invalidate;
end;

procedure TGmPreview.WriteHeader;
var
  XPos: integer;
  AHeight: Integer;
begin
  XPos := MarginLeft;

  // set the header font and brush properties
  FCanvas.Font := FHeader.Font;
  FCanvas.Brush := FHeader.Brush;
  FCanvas.Pen := FHeader.Line;

  CorrectFontSize(FCanvas);

  // calculate the text position depending on the alignment...
  AHeight := FCanvas.TextHeight('0');
  with FCanvas do
  begin
    // write the header text onto the page...
    TextOut(XPos,MarginTop, FHeader.Text);

    // set the properties and draw the line...
    if FHeader.ShowLine then
    begin
      MoveTo(MarginLeft, MarginTop+AHeight);
      LineTo(PhysicalPrinterWidth-MarginRight, MarginTop+AHeight);
    end;
  end;    // with
end;

procedure TGmPreview.WriteFooter;
var
  XPos: integer;
  AHeight: Integer;
begin
  XPos := MarginLeft;
  FCanvas.Font.Color := FFooter.Font.Color;
  FCanvas.Font.Size := FFooter.Font.Size;
  FCanvas.Font.Name := FFooter.Font.Name;
  FCanvas.Font.Style := FFooter.Font.Style;
  FCanvas.Brush.Color := FFooter.Brush.Color;
  FCanvas.Brush.Style := FFooter.Brush.Style;
  FCanvas.Pen.Color := FFooter.Line.Color;
  FCanvas.Pen.Width := FFooter.Line.Width;
  FCanvas.Pen.Style := FFooter.Line.Style;

  CorrectFontSize(FCanvas);

  AHeight := FCanvas.TextHeight('0');
  with FCanvas do
  begin
    // write the footer onto the page...
    TextOut(XPos,PhysicalPrinterHeight-(MarginBottom+AHeight),  FFooter.Text);

    // set the properties and draw the line...
    if FFooter.ShowLine then
    begin
      MoveTo(MarginLeft, PhysicalPrinterHeight-(MarginBottom+AHeight));
      LineTo(PhysicalPrinterWidth-MarginRight, PhysicalPrinterHeight-(MarginBottom+AHeight));
    end;
  end;    // with
end;


procedure TGmPreview.SetCanvasBrush(AValue: TBrush);
begin
  FCanvasBrush.Assign(AValue);
end;

procedure TGmPreview.SetCanvasFont(AValue: TFont);
begin
  FCanvasFont.Assign(AValue);
end;

procedure TGmPreview.SetCanvasPen(AValue: TPen);
begin
  FCanvasPen.Assign(AValue);
end;

procedure TGmPreview.SetShadowColor(AValue: TColor);
begin
  // change the shadow color...
  if FShadowColor <> AValue then
  begin
    FShadowColor := AValue;
    FPaintBox.Invalidate;
  end;
end;

procedure TGmPreview.SetShadowWidth(AValue: integer);
begin
  // change the shadow width...
  if FShadowWidth <> AValue then
  begin
    FShadowWidth := AValue;
    FPaintBox.Invalidate;
  end;
end;

//------------------------------------------------------------------------------

// drawing routines...

procedure TGmPreview.CanvasPropertiesToRec(ARec: PGmMetaFileRec);
begin
  // place the common properties into a metafile object record...

  // ( because these lines need to be called for most objects, I have
  //   created a procedure and just call the procedure each time )

  ARec^.gmPen.Style := FCanvasPen.Style;
  ARec^.gmPen.Color := FCanvasPen.Color;
  ARec^.gmPen.Width := FCanvasPen.Width;
  ARec^.gmBrush.Color := FCanvasBrush.Color;
  ARec^.gmBrush.Style := FCanvasBrush.Style;
  ARec^.gmFont.Name := FCanvasFont.Name;
  ARec^.gmFont.Size := FCanvasFont.Size;
  ARec^.gmFont.Style := FCanvasFont.Style;
  ARec^.gmFont.Color := FCanvasFont.Color;
end;

procedure TGmPreview.MmLine(X,Y, X2, Y2: double);   // X and Y are the desired millimeter positions...
var
  ALineRec: PGmMetaFileRec;
begin
  // create a line object and add it to the list...
  New(ALineRec);
  CanvasPropertiesToRec(ALineRec);
  ALineRec^.gmType := gmLine;
  ALineRec^.Page   := FCurrentPage;
  ALineRec^.left   := PrinterMmToPixelsX(X);
  ALineRec^.top    := PrinterMmToPixelsX(Y);
  ALineRec^.right  := PrinterMmToPixelsX(X2);
  ALineRec^.bottom := PrinterMmToPixelsX(Y2);
  FPageDefs.Add(ALineRec);
  RedrawPage(True);
  if Assigned(FOnPageDraw) then FOnPageDraw(Self);
end;

procedure TGmPreview.MmEllipse(X,Y,X2,Y2: double);
var
  EllipseRec: PGmMetaFileRec;
begin
  // create an ellipse object and add it to the list...
  New(EllipseRec);
  CanvasPropertiesToRec(EllipseRec);
  EllipseRec^.gmType := gmEllipse;
  EllipseRec^.Page   := CurrentPage;
  EllipseRec^.left   := PrinterMmToPixelsX(X);
  EllipseRec^.top    := PrinterMmToPixelsY(Y);
  EllipseRec^.right  := PrinterMmToPixelsX(X2);
  EllipseRec^.bottom := PrinterMmToPixelsY(Y2);
  FPageDefs.Add(EllipseRec);
  RedrawPage(True);
  if Assigned(FOnPageDraw) then FOnPageDraw(Self);
end;

procedure TGmPreview.MmRectangle(X,Y,X2,Y2: double);
var
  RectangleRec: PGmMetaFileRec;
begin
  // create a rectangle object and add it to the list...
  New(RectangleRec);
  CanvasPropertiesToRec(RectangleRec);
  RectangleRec^.gmType := gmRectangle;
  RectangleRec^.Page   := CurrentPage;
  RectangleRec^.left   := PrinterMmToPixelsX(X);
  RectangleRec^.top    := PrinterMmToPixelsY(Y);
  RectangleRec^.right  := PrinterMmToPixelsX(X2);
  RectangleRec^.bottom := PrinterMmToPixelsY(Y2);
  FPageDefs.Add(RectangleRec);
  RedrawPage(True);
  if Assigned(FOnPageDraw) then FOnPageDraw(Self);
end;

procedure TGmPreview.MmDraw(X,Y:double; AGraphic: TPicture);
var
  GraphicRec: PGmMetaFileRec;
begin
  // create a graphic object and add it to the list...
  New(GraphicRec);
  GraphicRec^.Graphic := TPicture.Create;

  GraphicRec^.Graphic.Assign(AGraphic);
  GraphicRec^.gmType := gmPicture;
  GraphicRec^.Page   := FCurrentPage;
  GraphicRec^.left   := PrinterMmToPixelsX(X);
  GraphicRec^.top    := PrinterMmToPixelsY(Y);
  GraphicRec^.right  := PrinterMmToPixelsX(X)+AGraphic.Width * Round(PixelsPerInch/Screen.PixelsPerInch);
  GraphicRec^.bottom := PrinterMmToPixelsY(Y)+AGraphic.Height * Round(PixelsPerInch/Screen.PixelsPerInch);
  FPageDefs.Add(GraphicRec);
  RedrawPage(True);
  if Assigned(FOnPageDraw) then FOnPageDraw(Self);
end;

procedure TGmPreview.MmStretchDraw(ARect: TRect; AGraphic: TPicture);
var
  GraphicRec: PGmMetaFileRec;
begin
  // create a graphic object using the StretchDraw method and add it to the list...
  New(GraphicRec);
  GraphicRec^.Graphic := TPicture.Create;

  GraphicRec^.Graphic.Assign(AGraphic);
  GraphicRec^.gmType := gmPicture;
  GraphicRec^.Page   := FCurrentPage;
  GraphicRec^.left   := PrinterMmToPixelsX(ARect.Left);
  GraphicRec^.top    := PrinterMmToPixelsY(ARect.Top);
  GraphicRec^.right  := PrinterMmToPixelsX(ARect.Right);
  GraphicRec^.bottom := PrinterMmToPixelsY(ARect.Bottom);
  FPageDefs.Add(GraphicRec);
  RedrawPage(True);
  if Assigned(FOnPageDraw) then FOnPageDraw(Self);
end;

procedure TGmPreview.MmTextOut(X,Y:Double; AText: string);
var
  TextRec: PGmMetaFileRec;
begin
  // create a text object and add it to the list...
  New(TextRec);
  CanvasPropertiesToRec(TextRec);
  TextRec^.gmType := gmText;
  TextRec^.Page   := FCurrentPage;
  TextRec^.left   := PrinterMmToPixelsX(X);
  TextRec^.top    := PrinterMmToPixelsY(Y);
  TextRec^.Text   := AText;
  FPageDefs.Add(TextRec);
  RedrawPage(True);
  if Assigned(FOnPageDraw) then FOnPageDraw(Self);
end;

procedure TGmPreview.MmTable(X,Y,X2,Y2: double; ARows,ACols: integer);
var
  TableRect: TRect;
  TableRec: PGmMetaFileRec;
begin
  // create a table object and add it to the list...
  New(TableRec);
  CanvasPropertiesToRec(TableRec);
  TableRec^.gmType := gmTable;
  TableRec^.Page := FCurrentPage;

  TableRect.Left   := PrinterMmToPixelsX(X);
  TableRect.Top    := PrinterMmToPixelsY(Y);
  TableRect.Right  := PrinterMmToPixelsY(X2);
  TableRect.Bottom := PrinterMmToPixelsY(Y2);

  TableRec^.left := TableRect.Left;
  TableRec^.top := TableRect.top;
  TableRec^.right := TableRect.right;
  TableRec^.bottom := TableRect.bottom;
  TableRec^.rows := ARows;
  TableRec^.cols := ACols;

  FPageDefs.Add(TableRec);
  RedrawPage(True);
  if Assigned(FOnPageDraw) then FOnPageDraw(Self);
end;

function TGmPreview.MmTextHeight(AText: string): double;
var
  LastFont: TFont;
begin
  LastFont := FPrinter.Canvas.Font;
  FPrinter.Canvas.Font := FCanvasFont;
  Result := PrinterPixelsToMmY(FPrinter.Canvas.TextHeight(AText));
  FPrinter.Canvas.Font := LastFont;
end;

function TGmPreview.MmTextWidth(AText: string): double;
var
  LastFont: TFont;
begin
  LastFont := FPrinter.Canvas.Font;
  FPrinter.Canvas.Font := FCanvasFont;
  Result := PrinterPixelsToMmX(FPrinter.Canvas.TextWidth(AText));
  FPrinter.Canvas.Font := LastFont;
end;

//------------------------------------------------------------------------------

// unit/measurement conversion functions...

function TGmPreview.GetPixelsPerInch: integer;
begin
  // return the selected printer's pixels per inch value...
  Result := GetDeviceCaps(FPrinter.Handle, LOGPIXELSX);
end;

function TGmPreview.PrinterMmToPixelsX(AValue: double): integer;
var
  Ppi: integer;
begin
  // convert Millimeters to Pixels using the printers horizontal resolution -
  // 1 mm = PixelsPerInch / 25.4

  Ppi := GetDeviceCaps(FPrinter.Handle, LOGPIXELSX);

  Result := Round((Ppi/MmPerInch) * AValue);
end;

function TGmPreview.PrinterMmToPixelsY(AValue: double): integer;
var
  Ppi: integer;
begin
  // convert Millimeters to Pixels using the printers vertical resolution -
  // 1 mm = PixelsPerInch / 25.4

  Ppi := GetDeviceCaps(FPrinter.Handle, LOGPIXELSY);

  Result := Round((Ppi/MmPerInch) * AValue);
end;

function TGmPreview.PrinterPixelsToMmX(AValue: integer): double;
var
  Mm: double;
begin
  // do the opposite to the above two functions by converting Mm to Pixels
  // using the horizontal resolutuon and returns the result to 2 decimal places...
  Mm := GetDeviceCaps(FPrinter.Handle, LOGPIXELSX)/MmPerInch;
  Result := StrToFloat(FormatFloat('0.00',AValue/mm));
end;

function TGmPreview.PrinterPixelsToMmY(AValue: integer): double;
var
  Mm: double;
begin
  // convert Mm to Pixels using the vertical resolutuon...
  // returns the result to 2 decimal places...
  Mm := GetDeviceCaps(FPrinter.Handle, LOGPIXELSY)/MmPerInch;
  Result := StrToFloat(FormatFloat('0.00',AValue/mm));
end;

function TGmPreview.GetPrinterToPreviewH(AValue: integer): integer;   // printer pixels to screen pixels
var
  ScreenPerInch: integer;
  PrinterPerInch: integer;
  ARatio: double;
begin
  // work out the equvilant screen and printer and screen horizontal distances by
  // looking at the Screen.PixelsPerInch and the printer pixels per inch value...

  ScreenPerInch := Screen.PixelsPerInch;
  PrinterPerInch := GetDeviceCaps(FPrinter.Handle, LOGPIXELSX);
  ARatio := ScreenPerInch/PrinterPerInch;
  Result := Round(ARatio * AValue);
end;

function TGmPreview.GetPrinterToPreviewV(AValue: integer): integer;
var
  ScreenPerInch: integer;
  PrinterPerInch: integer;
  ARatio: double;
begin
  // work out the equvilant screen and printer and screen vertical distances by
  // looking at the Screen.PixelsPerInch and the printer pixels per inch value...

  ScreenPerInch := Screen.PixelsPerInch;
  PrinterPerInch := GetDeviceCaps(FPrinter.Handle, LOGPIXELSY);
  ARatio := ScreenPerInch/PrinterPerInch;
  Result := Round(ARatio * AValue);
end;

//------------------------------------------------------------------------------

// page dimension functions...

function TGmPreview.GetPhysicalPrinterWidth: integer; // returns physical width in printer pixels
begin
  Result := GetDeviceCaps(FPrinter.Handle, PHYSICALWIDTH);
end;

function TGmPreview.GetPhysicalPrinterHeight: integer; // returns physical height in printer pixels
begin
  Result := GetDeviceCaps(FPrinter.Handle, PHYSICALHEIGHT);
end;

function TGmPreview.GetAvailablePageWidth: integer; // returns printable width in printer pixels
begin
  Result := GetDeviceCaps(FPrinter.Handle, HORZRES);
end;

function TGmPreview.GetAvailablePageHeight: integer; // returns printable height in printer pixels
begin
  Result := GetDeviceCaps(FPrinter.Handle, VERTRES);
end;

function TGmPreview.GetMmPhysicalPageWidth: double;
begin
  Result := PrinterPixelsToMmX(GetPhysicalPrinterWidth);
end;

function TGmPreview.GetMmPhysicalPageHeight: double;
begin
  Result := PrinterPixelsToMmY(GetPhysicalPrinterHeight);
end;

function TGmPreview.GetMmAvailablePageWidth: double;
begin
  Result := PrinterPixelsToMmX(GetAvailablePageWidth);
end;

function TGmPreview.GetMmAvailablePageHeight: double;
begin
  Result := PrinterPixelsToMmY(GetAvailablePageHeight);
end;

function TGmPreview.GetHeaderHeightMm: double;
var
  LastFont: TFont;
begin
  LastFont := FPrinter.Canvas.Font;
  FPrinter.Canvas.Font := FHeader.Font;
  Result := PrinterPixelsToMmY(FPrinter.Canvas.TextHeight('0') + MarginTop);
  FPrinter.Canvas.Font := LastFont;
end;

function TGmPreview.GetFooterHeightMm: double;
var
  LastFont: TFont;
begin
  LastFont := FPrinter.Canvas.Font;
  FPrinter.Canvas.Font := Footer.Font;
  Result := PrinterPixelsToMmY(FPrinter.Canvas.TextHeight('0') + MarginBottom);
  FPrinter.Canvas.Font := LastFont;
end;

//------------------------------------------------------------------------------

// non-printable margin functions...

function TGmPreview.GetMarginLeft: integer; // returns left margin in printer pixels
begin
  Result := Round(GetDeviceCaps(FPrinter.Handle, PHYSICALOFFSETX));
end;

function TGmPreview.GetMarginTop: integer; // returns top margin in pixels
begin
  Result := Round(GetDeviceCaps(FPrinter.Handle, PHYSICALOFFSETY));
end;

function TGmPreview.GetMarginRight: integer; // returns right margin in pixels (measured from left of physical page)
begin
  Result := GetPhysicalPrinterWidth - (GetMarginLeft + GetAvailablePageWidth);
end;

function TGmPreview.GetMarginBottom: integer; // returns bottom margin in pixels (measured from top of physical page)
begin
  Result := GetPhysicalPrinterHeight - (GetMarginTop + GetAvailablePageHeight);
end;

function TGmPreview.GetMarginRect: TRect; // returns all four margins in a TRect
begin
  Result.Left   := GetMarginLeft;
  Result.Top    := GetMarginTop;
  Result.Right  := GetMarginRight;
  Result.Bottom := GetMarginBottom;
end;

function TGmPreview.GetMmMarginRect: TGmRect;
begin
  Result.Left := PrinterPixelsToMmX(GetMarginLeft);
  Result.Top := PrinterPixelsToMmY(GetMarginTop);
  Result.Right := PrinterPixelsToMmX(GetMarginRight);
  Result.Bottom := PrinterPixelsToMmY(GetMarginBottom);
end;

//------------------------------------------------------------------------------

procedure TGmPreview.UpdateDimensions(AScaleFactor: double);
var
  AScale: double;
begin
  // update the preview page dimensions based upon the zoom value...

  AScale := AScaleFactor/100;
  FPaintBox.Hide;

  HorzScrollBar.Position := 1;
  VertScrollBar.Position := 1;
  HorzScrollBar.Range := Round(AScale * GetPrinterToPreviewH(PhysicalPrinterWidth) + 50);
  VertScrollBar.Range := Round(AScale * GetPrinterToPreviewV(PhysicalPrinterHeight) + 50);

  // get the on-screen preview size in pixels...
  FPreviewWidth  := Round(AScale * GetPrinterToPreviewH(PhysicalPrinterWidth));
  FPreviewHeight := Round(AScale * GetPrinterToPreviewV(PhysicalPrinterHeight));

  HorzScrollBar.Position := 0;
  VertScrollBar.Position := 0;
  FPaintBox.Show;
end;

//------------------------------------------------------------------------------

// paintbox events...

procedure TGmPreview.PaintPreview(Sender: TObject); // OnPaint handler for TPaintBox;
var
  PageOffsetX: integer;
  PageOffsetY: integer;
  PreviewPage: TRect;
  PreviewMargins: TRect;
  FScaleFactor: double;
  AMetaFile: TMetaFile;
begin
  FPaintBox.Color := Color;
  FScaleFactor := FZoom/100;
  with FPaintBox.Canvas do
    begin

      Pen.Color := clBlack;
      Pen.Style := psSolid;

      // calculate the screen preview offset...

      PageOffsetX:=(fPaintBox.Width - FPreviewWidth) div 2;
      PageOffsetY:=(fPaintBox.Height  - FPreviewHeight) div 2;

      if PageOffsetX <= 0 then PageOffsetX := 0;
      if PageOffsetY <= 0 then PageOffsetY := 0;


      {Calculate the page area.}
      PreviewPage.Left := PageOffsetX;
      PreviewPage.Top := PageOffsetY;
      PreviewPage.Right := FPreviewWidth + PageOffsetX;
      PreviewPage.Bottom := FPreviewHeight + PageOffsetY;

      // draw the white page with a black outline...
      Brush.Color := clWhite;
      Rectangle(PreviewPage.Left, PreviewPage.Top, PreviewPage.Right, PreviewPage.Bottom);


      AMetaFile := TMetaFile(FPages[FCurrentPage-1]);

      // draw the metafile onto the paintbox...
      Windows.PlayEnhMetaFile(FPaintBox.Canvas.Handle,AMetaFile.Handle,PreviewPage);

    if FMargin.FShowMargins = True then
    begin
      PreviewMargins := PreviewPage;

      // scale the margins from printer pixel values to preview page values...
      PreviewMargins.Left :=   PreviewMargins.Left + Round(GetPrinterToPreviewH(MarginLeft)*FScaleFactor);
      PreviewMargins.Top :=    PreviewMargins.Top + Round(GetPrinterToPreviewV(MarginTop)*FScaleFactor);
      PreviewMargins.Right :=  PreviewMargins.Right - Round(GetPrinterToPreviewH(MarginRight)*FScaleFactor);
      PreviewMargins.Bottom := PreviewMargins.Bottom - Round(GetPrinterToPreviewV(MarginBottom)*FScaleFactor);


      // set the pen properties and draw the page margin...
      Brush.Style := bsClear;
      Pen.Color := FMargin.FMarginColor;
      Pen.Style := psDot;
      Rectangle(PreviewMargins.Left,
                PreviewMargins.Top,
                PreviewMargins.right,
                PreviewMargins.Bottom );
    end;

    if FShowShadow = True then
    begin
      Brush.Color := FShadowColor;
      Pen.Color := FShadowColor;
      // draw the right bit of the shadow...
      Rectangle(PreviewPage.Right,
                PreviewPage.Top + FShadowWidth,
                PreviewPage.Right + FShadowWidth,
                PreviewPage.Bottom + FShadowWidth);
      // draw the bottom bit of the shadow...
      Rectangle(PreviewPage.Left + FShadowWidth,
                PreviewPage.Bottom,
                PreviewPage.Right,
                PreviewPage.Bottom + FShadowWidth);
    end;
    Pen.Color:=Color;
  end;
end;

procedure TGmPreview.PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  HorzPercent: integer;
  VertPercent: integer;
begin
  if FAllowMouseZoom then
  begin
    // record the current scroll-bar positions as a percentage...
    HorzPercent := Round((X/FPaintBox.Width)*100);
    VertPercent := Round((Y/FPaintBox.Height)*100);

    // Left button = Zoom in...
    // Right button = Zoom out

    if Button = mbLeft then SetZoom(FZoom+10);
    if Button = mbRight then SetZoom(FZoom-10);

    // after zooming, set the scroll-bar positions to the recorded percent values to
    // zoom in or out on the point at which the mouse button was pressed...
    if HorzScrollBar.Visible then
    begin
      HorzScrollBar.Position := Round(((HorzScrollBar.Range-ClientWidth) /100)*HorzPercent);
    end;
    if VertScrollBar.Visible then
    begin
      VertScrollBar.Position := Round(((VertScrollBar.Range-ClientHeight) /100)*VertPercent);
    end;
  end;
end;

//------------------------------------------------------------------------------

// internal property functions/procedures...

procedure TGmPreview.SetShowShadow(AValue: boolean);
begin
  // change the shadow visibility...
  if FShowShadow <> AValue then
  begin
    FShowShadow := AValue;
    FPaintBox.Invalidate;
  end;
end;

procedure TGmPreview.SetZoom(AValue: integer);
begin
  // change the zoom...
  if (FZoom <> AValue) then
  begin
    // but don't let the zoom fall below MinZoom or exceed MaxZoom...
    if (AValue < FMinZoom) then AValue := FMinZoom;
    if (AValue > FMaxZoom) then AValue := FMaxZoom;

    FZoom := AValue;
    UpdateDimensions(AValue);
    FPaintBox.Invalidate;

    if Assigned(FOnZoom) then FOnZoom(Self);
  end;
end;

//------------------------------------------------------------------------------

// printing...

procedure TGmPreview.ShowPrintProgress;
begin
  // create the print progress form, initialize and display it...
  frmProgress := TfrmProgress.Create(Self);
  if FPrintCollate then
    frmProgress.Initialize(FPages.Count, FPages.Count*FPrintCopies)
  else
    frmProgress.Initialize(FPages.Count, FPages.Count);
  if FShowPrintProgress then frmProgress.Show;
end;


procedure TGmPreview.Print;
var
  FirstPage: Boolean;
  copyCount: integer;
  count: integer;
  ACurrentPage: integer;
begin
  ACurrentPage := FCurrentPage;

  // if the option is selected, show the print progress...
  if FShowPrintProgress then ShowPrintProgress;

  // keep a first page variable to prevent calling Printer.NewPage before the first page
  // has been drawn...
  FirstPage := True;

  if FPrintCopies < 1 then Exit;

  if Assigned(FBeforePrint) then FBeforePrint(Self);

  // start the printing...
  FPrinter.BeginDoc;

  if FPrintCollate then
  begin
    // collate the copies...
    for copyCount := 1 to FPrintCopies do
    begin
      frmProgress.barProgress.Position := 0;
      with FPrinter do
      begin
        for count := 0 to FPages.Count-1 do
        begin
            FPage := TMetaFile(FPages[count]);

          // redraw the page about to be printed to account for any tokens
          // which may need to be updated...
          FCurrentPage := count+1;
          RedrawPage(False);
            begin
              if FirstPage = False then FPrinter.NewPage;
              // draw the standard - one preview page per printed sheet.
              Canvas.Draw(0-MarginLeft,0-MarginTop,FPage);
            end;
          Application.ProcessMessages;

          // if the user clicks on 'Abort' then stop the printing...
          if frmProgress.DoAbort then
          begin
            FPrinter.Abort;
            Exit;
            if Assigned(FOnAbortPrint) then FOnAbortPrint(Self);
          end;

          if FShowPrintProgress then
          begin
            frmProgress.Increment;
            // slow the process down slightly to allow the user to abort...
            Sleep(30);
          end;
          FirstPage := False;
        end;
      end;
    end;
  end
  else
  begin
    // dont collate the copies...
    for count := 0 to FPages.Count-1 do
    begin
      FPage := TMetaFile(FPages[count]);

      for copyCount := 1 to FPrintCopies do
      with FPrinter do
      begin
        // print either 1, 2 or 4 pages per sheet...

            begin
              if FirstPage = False then FPrinter.NewPage;
              // draw the standard - one preview page per printed sheet.
              Canvas.Draw(0-MarginLeft,0-MarginTop,FPage);
            end;

        Application.ProcessMessages;

        // if the user clicks the 'Abort' button then stopthe printing...
        if frmProgress.DoAbort then
        begin
          FPrinter.Abort;
          Exit;
          if Assigned(FOnAbortPrint) then FOnAbortPrint(Self);
        end;
        FirstPage := False;
      end;

      if FShowPrintProgress then
      begin
        frmProgress.Increment;
        // slow the process down slightly to allow the user to abort...
        Sleep(30);
      end;
    end
  end;

  // perform one last check that the abort button hasn't been clicked...
  Application.ProcessMessages;
  if frmProgress.DoAbort then
  begin
    FPrinter.Abort;
    Exit;
  end;

  FPrinter.EndDoc;

  // call the AfterPrint event...
  if Assigned(FAfterPrint) then FAfterPrint(Self);

  // free up the progress form...
  if FShowPrintProgress then
  begin
    frmProgress.Free;
    frmProgress := nil;
  end;
  FCurrentPage := ACurrentPage;
end;

//------------------------------------------------------------------------------

procedure Register;
begin
  // stick this excellent component under a big, fat tab called "Murtsoft"!!!
  // hope you like it!!!

  RegisterComponents('Murtsoft', [TGmPreview]);

end;

end.
