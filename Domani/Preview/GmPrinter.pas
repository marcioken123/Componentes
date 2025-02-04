{******************************************************************************}
{                                                                              }
{                          GmPrinter.pas v2.61 Lite                            }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmPrinter;

interface

uses Windows, Classes, Printers, Graphics, Messages, JPeg, GmTypes, Dialogs;

{$I GMPS.INC}

type
  TGmPrinterCanvas = class
  private
    FActive: Boolean;
    FCopyMode: TCopyMode;
    FFontAngle: Extended;
    FHFont: HFONT;
    FHPen: HPEN;
    FOffset: TPoint;
    FPenPos: TGmPoint;
    FPpiX: integer;
    FPpiY: integer;
    FPrintColor: TGmPrintColor;
    FPrinterCanvas: TCanvas;
    FPrintScale: Extended;
    FSaveBrush: TBrush;
    function GetBrush: TBrush;
    function GetFont: TFont;
    function GetHandle: THandle;
    function GetPen: TPen;
    function GraphicExtent(AGraphic: TGraphic): TGmSize;
    function TextExtent(AText: string): TGmSize;
    procedure DeleteFont;
    procedure DeletePen;
    procedure PrintBitmap(ARect: TGmRect; Bitmap: TBitmap);
    procedure PrintJpeg(ARect: TGmRect; JPeg: TJPegImage);
    procedure PrintMetafile(ARect: TGmRect; AMetafile: TMetafile);
    procedure PrintPolyShape(AShapeID: integer; const inchPoints: array of TGmPoint);
    procedure SelectFont(AScale: Extended);
    procedure SelectPen;
    procedure SetActive(AValue: Boolean);
  protected
    property PpiX: integer read FPpiX;
    property PpiY: integer read FPpiY;
  public
    constructor Create;
    destructor Destroy; override;
    function GraphicHeightInch(AGraphic: TGraphic): Extended;
    function GraphicWidthInch(AGraphic: TGraphic): Extended;
    function TextHeight(AText: string): integer;
    function TextWidth(AText: string): integer;
    function TextHeightInch(AText: string): Extended;
    function TextWidthInch(AText: string): Extended;
    procedure Arc(inchPoints: TGmComplexPoints);
    procedure Chord(inchPoints: TGmComplexPoints);
    procedure Draw(inchX, inchY: Extended; AGraphic: TGraphic);
    procedure Ellipse(inchX, inchY, inchX2, inchY2: Extended);
    procedure MoveTo(inchX, inchY: Extended);
    procedure LineTo(inchX, inchY: Extended);
    procedure Pie(inchPoints: TGmComplexPoints);
    procedure Polygon(const inchPoints: array of TGmPoint);
    procedure Polyline(const inchPoints: array of TGmPoint);
    procedure PolylineTo(const inchPoints: array of TGmPoint);
    procedure PolyBezier(const inchPoints: array of TGmPoint);
    procedure PolyBezierTo(const inchPoints: array of TGmPoint);
    procedure Rectangle(inchX, inchY, inchX2, inchY2: Extended);
    procedure Refresh;
    procedure RoundRect(inchX, inchY, inchX2, inchY2, inchCornerX, inchCornerY: Extended);
    procedure StretchDraw(inchRect: TGmRect; AGraphic: TGraphic);
    procedure TextBoxOut(inchRect: TGmRect; Align: TAlignment; VertAlign: TGmVertAlignment; AWordBreak: Byte; AText: string);
    procedure TextOut(inchX, inchY: Extended; Alignment: TAlignment; AText: string);
    procedure TextOutRotate(inchX, inchY, Angle: Extended; AText: string);
    // path functions...
    procedure BeginPath;
    procedure EndPath;
    procedure StrokePath;
    procedure FillPath;
    procedure StrokeAndFillPath;
    procedure CloseFigure;
    // properties...
    property Canvas: TCanvas read FPrinterCanvas;
    property CopyMode: TCopyMode read FCopyMode write FCopyMode default cmSrcCopy;
    property Handle: THandle read GetHandle;
    property Brush: TBrush read GetBrush;
    property Font: TFont read GetFont;
    property FontAngle: Extended read FFontAngle write FFontAngle;
    property PenPos: TGmPoint read FPenPos;
    property Pen: TPen read GetPen;
  end;

  TGmPrinter = class(TGmCustomPrinter)
  private
    FAvailableWidth: Extended;
    FAvailableHeight: Extended;
    FCanvas: TGmPrinterCanvas;
    FDevice, FDriver, FPort: array[0..80] of Char;
    FDitherType: TGmDitherType;
    FDuplexType: TGmDuplexType;
    FFileName: string;
    FOffset: TPoint;
    FOrientation: TPrinterOrientation;
    FOrientationSwapped: Boolean;
    FPageCount: integer;
    FPageHeight: Extended;
    FPageWidth: Extended;
    FPagesPerSheet: TGmPagesPerSheet;
    FPpiX: integer;
    FPpiY: integer;
    FPrintColor: TGmPrintColor;
    FPrintCopies: integer;
    FPrintDialog: TPrintDialog;
    FPrinterBins: TStrings;
    FPrinters: TStrings;
    FPrinting: Boolean;
    FPrintQuality: TGmPrintQuality;
    FReversePrintOrder: Boolean;
    FShowPrintDialog: Boolean;
    FTempValue: TGmValue;
    FTempValueRect: TGmValueRect;
    FTitle: string;
    DeviceMode: THandle;
    DevMode: PDeviceMode;
    // events...
    FOnPrinterChanged: TNotifyEvent;
    function GetAborted: Boolean;
    function GetAvailableHeight: integer;
    function GetAvailableHeightGmValue: TGmValue;
    function GetAvailableWidth: integer;
    function GetAvailableWidthGmValue: TGmValue;
    function GetGmValue: TGmValue;
    function GetGmValueRect: TGmValueRect;
    function GetHandle: THandle;
    function GetIndexOf(const APrinter: string): integer;
    function GetIsColorPrinter: Boolean;
    function GetMarginsInch: TGmRect;
    function GetOffset: TPoint;
    function GetPixelOffsetX: integer;
    function GetPixelOffsetY: integer;
    function GetOffsetInchXY: TGmPoint;
    function GetOrientation: TPrinterOrientation;
    function GetPageHeight: integer;
    function GetPageWidth: integer;
    function GetPageHeightGmValue: TGmValue;
    function GetPageWidthGmValue: TGmValue;
    //function GetPageHeightInch: Extended;
    //function GetPageWidthInch: Extended;
    function GetPaperSize: TGmPaperSize;
    function GetPpiX: integer;
    function GetPpiY: integer;
    function GetPrinterBinIndex: integer;
    function GetPrinterBins: TStrings;
    function GetPrinterIndex: integer;
    function GetPrinterMargins: TGmValueRect;
    function GetPrinters: TStrings;
    function GetPrinterSelected: Boolean;
    procedure PrintToFile(AFileName: string);
    procedure LockPrinter;
    procedure OffsetCanvas;
    //procedure ReloadDevMode;
    procedure ResetPrinter;
    procedure SetDitherType(const AValue: TGmDitherType);
    procedure SetDuplexType(const AValue: TGmDuplexType);
    procedure SetOrientation(AOrientation: TPrinterOrientation);
    procedure SetPaperSize(APaperSize: TGmPaperSize);
    procedure SetPrintColor(AColor: TGmPrintColor);
    procedure SetPrintDialog(const ADialog: TPrintDialog);
    procedure SetPrinterBinIndex(const AValue: integer);
    procedure SetPrinterIndex(const AValue: integer);
    procedure SetPrintQuality(const AValue: TGmPrintQuality);
    procedure SetTitle(const ATitle: string);
    procedure SwapOrientation;
    procedure UnlockPrinter;
    // event procedures...
    procedure PrinterChanged(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Abort;
    procedure Assign(Source: TPersistent); override;
    procedure BeginDoc;
    procedure EndDoc;
    procedure NewPage(AOrientation: TGmOrientation);
    procedure RefreshPrinters;
    property Aborted: Boolean read GetAborted;
    property AvailableHeight: TGmValue read GetAvailableHeightGmValue;
    property AvailableWidth: TGmValue read GetAvailableWidthGmValue;
    property Canvas: TGmPrinterCanvas read FCanvas;
    property FileName: string read FFileName write FFileName;
    property Handle: THandle read GetHandle;
    property IndexOf[const Printer: string]: integer read GetIndexOf;
    property IsColorPrinter: Boolean read GetIsColorPrinter;
    property Orientation: TPrinterOrientation read GetOrientation write SetOrientation;
    property PagesPerSheet: TGmPagesPerSheet read FPagesPerSheet write FPagesPerSheet default gmOnePage;
    property Printing: Boolean read FPrinting;
    property Offset: TPoint read GetOffset;
    property PrinterBinIndex: integer read GetPrinterBinIndex write SetPrinterBinIndex;
    property PrinterBins: TStrings read GetPrinterBins;
    property PrinterMargins: TGmValueRect read GetPrinterMargins;
    property PrinterPaperSize: TGmPaperSize read GetPaperSize write SetPaperSize;
    property PrinterHeight: TGmValue read GetPageHeightGmValue;
    property PrinterIndex: integer read GetPrinterIndex write SetPrinterIndex;
    property Printers: TStrings read GetPrinters;
    property PrinterSelected: Boolean read GetPrinterSelected;
    property PrinterWidth: TGmValue read GetPageWidthGmValue;
    property PrinterPpiX: integer read GetPpiX;
    property PrinterPpiY: integer read GetPpiY;
    property OnPrinterChanged: TNotifyEvent read FOnPrinterChanged write FOnPrinterChanged;
  published
    property PrintColor: TGmPrintColor read FPrintColor write FPrintColor stored True default gmColor;
    property PrintCopies: integer read FPrintCopies write FPrintCopies default 1;
    property DitherType: TGmDitherType read FDitherType write FDitherType default gmGrayScale;
    property Duplex: TGmDuplexType read FDuplexType write FDuplexType default gmSimplex;
    property PrintDialog: TPrintDialog read FPrintDialog write SetPrintDialog;
    property PrintQuality: TGmPrintQuality read FPrintQuality write FPrintQuality default gmMedium;
    property ReversePrintOrder: Boolean read FReversePrintOrder write FReversePrintOrder default True;
    property ShowPrintDialog: Boolean read FShowPrintDialog write FShowPrintDialog default True;
    property Title: string read FTitle write SetTitle;
  end;

  function AsGmOrientation(AOrientation: TPrinterOrientation): TGmOrientation;
  function AsPrinterOrientation(AOrientation: TGmOrientation): TPrinterOrientation;
  function AsGmPaperSize(APaperSize: SmallInt): TGmPaperSize;
  function AsPrinterPaperSize(APaperSize: TGmPaperSize): SmallInt;
  function ConvertPenStyle(APenStyle: TPenStyle): Byte;
  function PrinterPpiX: Extended;
  function PrinterPpiY: Extended;


implementation

uses GmConst, Math, SysUtils, WinSpool;

//------------------------------------------------------------------------------

// *** Global functions ***

function AsGmOrientation(AOrientation: TPrinterOrientation): TGmOrientation;
begin
  if AOrientation = poPortrait then
    Result := gmPortrait
  else
    Result := gmLandscape;
end;

function AsPrinterOrientation(AOrientation: TGmOrientation): TPrinterOrientation;
begin
  if AOrientation = gmPortrait then
    Result := poPortrait
  else
    Result := poLandscape;
end;

function AsGmPaperSize(APaperSize: SmallInt): TGmPaperSize;
begin
  case APaperSize of
    DMPAPER_LETTER  : Result := Letter;
    DMPAPER_LEGAL   : Result := Legal;
    DMPAPER_A3      : Result := A3;
    DMPAPER_A4      : Result := A4;
    DMPAPER_A5      : Result := A5;
    DMPAPER_A6      : Result := A6;
    DMPAPER_B5      : Result := B5;
    DMPAPER_ENV_C5  : Result := C5;
  else
    Result := Custom;
  end
end;

function AsPrinterPaperSize(APaperSize: TGmPaperSize): SmallInt;
begin
  Result := -1;
  case APaperSize of
    A3    : Result := DMPAPER_A3;
    A4    : Result := DMPAPER_A4;
    A5    : Result := DMPAPER_A5;
    A6    : Result := DMPAPER_A6;
    B5    : Result := DMPAPER_B5;
    C5    : Result := DMPAPER_ENV_C5;
    Legal : Result := DMPAPER_LEGAL;
    Letter: Result := DMPAPER_LETTER;
  end;
end;

function ConvertPenStyle(APenStyle: TPenStyle): Byte;
begin
 Result := 0;
  case APenStyle of
 	  psSolid: 			Result := PS_SOLID;
    psDash:  			Result := PS_DASH;
	  psDot:	 			Result := PS_DOT;
 	  psDashDot:		Result := PS_DASHDOT;
    psDashDotDot:	Result := PS_DASHDOTDOT;
    psClear:			Result := PS_NULL;
  end;
end;

function PrinterPpiX: Extended;
begin
  if Printer.Printers.Count > 0 then
    Result := GetDeviceCaps(Printer.Handle, LOGPIXELSX)
  else
    Result := DEFAULT_DRAW_DPI;
end;

function PrinterPpiY: Extended;
begin
  if Printer.Printers.Count > 0 then
    Result := GetDeviceCaps(Printer.Handle, LOGPIXELSY)
  else
    Result := DEFAULT_DRAW_DPI;
end;

// *** Local functions ***

function InchesToPixels(AValue: Extended; Ppi: integer): integer;
begin
  Result := Round(AValue * Ppi);
end;

function GmPointToPixels(APoint: TGmPoint; PpiX, PpiY: integer): TPoint;
begin
  Result.x := InchesToPixels(APoint.x, PpiX);
  Result.y := InchesToPixels(APoint.y, PpiY);
end;

function GmRectToPixels(ARect: TGmRect; PpiX, PpiY: integer): TRect;
begin
  Result.Left     := InchesToPixels(ARect.Left, PpiX);
  Result.Top      := InchesToPixels(ARect.Top, PpiY);
  Result.Right    := InchesToPixels(ARect.Right, PpiX);
  Result.Bottom   := InchesToPixels(ARect.Bottom, PpiY);
end;

function PixelsToInches(AValue: Integer; Ppi: integer): Extended;
begin
  Result := AValue / Ppi;
end;

function ScaleValue(AValue, AScale: Extended): Extended;
begin
  Result := AValue * AScale;
end;

function ScaleGmPoint(APoint: TGmPoint; AScale: Extended): TGmPoint;
begin
  Result.x := APoint.x * AScale;
  Result.y := APoint.y * AScale;
end;

function ScaleGmRect(ARect: TGmRect; AScale: Extended): TGmRect;
begin
  Result.Left   := ScaleValue(ARect.Left, AScale);
  Result.Top    := ScaleValue(ARect.Top, AScale);
  Result.Right  := ScaleValue(ARect.Right, AScale);
  Result.Bottom := ScaleValue(ARect.Bottom, AScale);
end;

//------------------------------------------------------------------------------

{$IFDEF D4+}

// *** Polygon object printing routines ***

type
  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;

procedure PrintPolygon(ACanvas: TCanvas; const Points: array of TPoint);
begin
  Windows.Polygon(ACanvas.Handle, PPoints(@Points)^, High(Points) + 1);
end;

procedure PrintPolyline(ACanvas: TCanvas; const Points: array of TPoint);
begin
  Windows.Polyline(ACanvas.Handle, PPoints(@Points)^, High(Points) + 1);
end;

procedure PrintPolylineTo(ACanvas: TCanvas; const Points: array of TPoint);
begin
  Windows.PolylineTo(ACanvas.Handle, PPoints(@Points)^, High(Points) + 1);
end;

procedure PrintPolyBezier(ACanvas: TCanvas; const Points: array of TPoint);
begin
  Windows.PolyBezier(ACanvas.Handle, PPoints(@Points)^, High(Points) + 1);
end;

procedure PrintPolyBezierTo(ACanvas: TCanvas; const Points: array of TPoint);
begin
  Windows.PolyBezierTo(ACanvas.Handle, PPoints(@Points)^, High(Points) + 1);
end;

{$ENDIF}

//------------------------------------------------------------------------------

// *** TGmPrinterCanvas ***

constructor TGmPrinterCanvas.Create;
begin
  inherited Create;
  FSaveBrush := TBrush.Create;
  FFontAngle := 0;
  FHPen := 0;
  FPenPos := GmPoint(0,0);
  FCopyMode := cmSrcCopy;
  FPrintScale := 0.5;
end;

destructor TGmPrinterCanvas.Destroy;
begin
  DeleteFont;
  DeletePen;
  FSaveBrush.Free;
  inherited Destroy;
end;

//------------------------------------------------------------------------------

// *** Private functions ***

function TGmPrinterCanvas.GetBrush: TBrush;
begin
  Result := FPrinterCanvas.Brush;
end;

function TGmPrinterCanvas.GetFont: TFont;
begin
  Result := FPrinterCanvas.Font;
end;

function TGmPrinterCanvas.GetHandle: THandle;
begin
  Result := FPrinterCanvas.Handle;
end;

function TGmPrinterCanvas.GetPen: TPen;
begin
  Result := FPrinterCanvas.Pen;
end;

function TGmPrinterCanvas.GraphicExtent(AGraphic: TGraphic): TGmSize;
begin
  Result.Height := PixelsToInches(AGraphic.Height, PpiY);
  Result.Width  := PixelsToInches(AGraphic.Width, PpiX);
end;

function TGmPrinterCanvas.TextExtent(AText: string): TGmSize;
begin
  Result.Height := PixelsToInches(Canvas.TextHeight(AText), PpiY);
  Result.Width  := PixelsToInches(Canvas.TextWidth(AText), PpiX);
end;

procedure TGmPrinterCanvas.DeleteFont;
begin
  if FHFont <> 0 then DeleteObject(FHFont);
end;

procedure TGmPrinterCanvas.DeletePen;
begin
  if FHPen <> 0 then DeleteObject(FHPen);
end;

procedure TGmPrinterCanvas.PrintBitmap(ARect: TGmRect; Bitmap: TBitmap);
var
  BitmapHeader: pBitmapInfo;
  BitmapImage : POINTER;
  HeaderSize : DWORD; // Use DWORD for D3-D5 compatibility
  ImageSize : DWORD;
  CM : LongInt;
  DestRect: TRect;
begin
  DestRect := GmRectToPixels(ScaleGmRect(ARect, FPrintScale), PpiX, PpiY);
  CM := SRCCOPY;
  case FCopyMode of
    cmBlackness:  CM := BLACKNESS;
    cmDstInvert:  CM := DSTINVERT;
    cmMergeCopy:  CM := MERGECOPY;
    cmMergePaint: CM := MERGEPAINT;
    cmNotSrcCopy: CM := NOTSRCCOPY;
    cmNotSrcErase:CM := NOTSRCERASE;
    cmPatCopy:    CM := PATCOPY;
    cmPatInvert:  CM := PATINVERT;
    cmPatPaint:   CM := PATPAINT;
    cmSrcAnd:     CM := SRCAND;
    cmSrcCopy:    CM := SRCCOPY;
    cmSrcErase:   CM := SRCERASE;
    cmSrcInvert:  CM := SRCINVERT;
    cmSrcPaint:   CM := SRCPAINT;
    cmWhiteness:  CM := WHITENESS;
  end;
  GetDIBSizes(Bitmap.Handle, HeaderSize, ImageSize);
  GetMem(BitmapHeader, HeaderSize);
  GetMem(BitmapImage, ImageSize);
  GetDIB(Bitmap.Handle, Bitmap.Palette, BitmapHeader^, BitmapImage^);
  try
    StretchDIBits(Handle,
                  DestRect.Left, DestRect.Top,    // Destination Origin
                  DestRect.Right - DestRect.Left, // Destination Width
                  DestRect.Bottom - DestRect.Top, // Destination Height
                  0, 0,                           // Source Origin
                  Bitmap.Width, Bitmap.Height,    // Source Width & Height
                  BitmapImage,
                  TBitmapInfo(BitmapHeader^),
                  DIB_RGB_COLORS,
                  CM);
  finally
    FreeMem(BitmapHeader);
    FreeMem(BitmapImage)
  end;
end;

procedure TGmPrinterCanvas.PrintJpeg(ARect: TGmRect; JPeg: TJPegImage);
var
  ABitmap: TBitmap;
begin
  ABitmap := TBitmap.Create;
  try
    ABitmap.PixelFormat := pf24Bit;
    ABitmap.Height := JPeg.Height;
    ABitmap.Width := JPeg.Width;
    ABitmap.Canvas.Draw(0, 0, JPeg);
    PrintBitmap(ARect, ABitmap);
  finally
    ABitmap.Free;
  end;
end;

procedure TGmPrinterCanvas.PrintMetafile(ARect: TGmRect; AMetafile: TMetafile);
var
  DestRect: TRect;
begin
  DestRect := GmRectToPixels(ARect, PpiX, PpiY);
  //Canvas.stretchDraw(DestRect, AMetafile);
  PlayEnhMetaFile(Handle, AMetafile.Handle, DestRect);
end;

procedure TGmPrinterCanvas.PrintPolyShape(AShapeID: integer; const inchPoints: array of TGmPoint);
{$IFDEF D4+}
var
  NewPoints: array of TPoint;
  ICount: integer;
{$ENDIF}
begin
	{$IFDEF D4+}
  if not FActive then Exit;
  SelectPen;
  SetLength(NewPoints, High(inchPoints)+1);
  for ICount := 0 to High(inchPoints) do
    NewPoints[ICount] := GmPointToPixels(ScaleGmPoint(inchPoints[ICount], FPrintScale), PpiX, PpiY);

  case AShapeID of
    GM_POLYGON_ID     : PrintPolygon(Canvas, NewPoints);
    GM_POLYLINE_ID    : PrintPolyline(Canvas, NewPoints);
    GM_POLYBEZIER_ID  : PrintPolyBezier(Canvas, NewPoints);
    GM_POLYLINETO_ID  : PrintPolylineTo(Canvas, NewPoints);
    GM_POLYBEZIERTO_ID: PrintPolyBezierTo(Canvas, NewPoints);
  end;
  {$ENDIF}
end;

procedure TGmPrinterCanvas.SelectFont(AScale: Extended);
var
  lf: TLogFont;
  //AFont: TFont;
begin
  //DeleteFont;

  //AFont := TFont.Create;
	//AFont.Assign(Canvas.Font);

  //GetObject(AFont.Handle, sizeof(lf), @lf);
  GetObject(Canvas.Font.Handle, sizeof(lf), @lf);
  lf.lfEscapement := Round(FFontAngle * 10);
  lf.lfOrientation := Round(FFontAngle * 10);
  if fsBold in Canvas.Font.Style then lf.lfWeight := FW_ULTRABOLD;
  if fsItalic in Canvas.Font.Style then lf.lfItalic := Integer(True);
  if fsUnderline in Canvas.Font.Style then lf.lfUnderline := Integer(True);
  lf.lfHeight := Round(lf.lfHeight * AScale);
  //lf.
  //AFont.Handle := CreateFontIndirect(lf);
  FHFont := CreateFontIndirect(lf);

  SelectObject(Canvas.Handle, FHFont);
  //SelectObject(Canvas.Handle, AFont.Handle);
  //Canvas.Font.Assign(AFont);
//  AFont.Free;
end;

procedure TGmPrinterCanvas.SelectPen;
var
  LB: TLogBrush;
  APenStyle: Byte;
  APenWidth: integer;
  OnePt: Extended;
begin
  if (Canvas.Pen.Width * FPrintScale) <= 1 then
  begin
    Canvas.Pen.Width := 1;
    Exit;
  end;
  OnePt := (PpiY / 72);
  LB.lbColor := Pen.Color;
  LB.lbStyle := BS_SOLID;
  LB.lbHatch := 0;
  APenStyle := ConvertPenStyle(Pen.Style);
  APenWidth := Round(((Pen.Width * OnePt)/4) * FPrintScale);
	Canvas.Pen.Handle := ExtCreatePen(PS_GEOMETRIC or APenStyle or PS_ENDCAP_SQUARE, APenWidth, LB, 0, nil);
end;

procedure TGmPrinterCanvas.SetActive(AValue: Boolean);
begin
  SetWindowOrgEx(Handle,
                 FOffset.x,
                 FOffset.y,
                 nil);
  FActive := AValue;
end;

//------------------------------------------------------------------------------

// *** Public functions ***

function TGmPrinterCanvas.GraphicHeightInch(AGraphic: TGraphic): Extended;
begin
  Result := GraphicExtent(AGraphic).Height;
end;

function TGmPrinterCanvas.GraphicWidthInch(AGraphic: TGraphic): Extended;
begin
  Result := GraphicExtent(AGraphic).Width;
end;

function TGmPrinterCanvas.TextHeight(AText: string): integer;
begin
	Result := Round(TextHeightInch(AText) * PrinterPpiY);
end;

function TGmPrinterCanvas.TextWidth(AText: string): integer;
begin
	Result := Round(TextWidthInch(AText) * PrinterPpiX);
end;

function TGmPrinterCanvas.TextHeightInch(AText: string): Extended;
begin
  Result := TextExtent(AText).Height;
end;

function TGmPrinterCanvas.TextWidthInch(AText: string): Extended;
begin
  Result := TextExtent(AText).Width;
end;

procedure TGmPrinterCanvas.Arc(inchPoints: TGmComplexPoints);
begin
  if not FActive then Exit;
//  ConvertColors;
  SelectPen;
  Windows.Arc(Handle,
              InchesToPixels(ScaleValue(inchPoints[1], FPrintScale), PpiX),
              InchesToPixels(ScaleValue(inchPoints[2], FPrintScale), PpiY),
              InchesToPixels(ScaleValue(inchPoints[3], FPrintScale), PpiX),
              InchesToPixels(ScaleValue(inchPoints[4], FPrintScale), PpiY),
              InchesToPixels(ScaleValue(inchPoints[5], FPrintScale), PpiX),
              InchesToPixels(ScaleValue(inchPoints[6], FPrintScale), PpiY),
              InchesToPixels(ScaleValue(inchPoints[7], FPrintScale), PpiX),
              InchesToPixels(ScaleValue(inchPoints[8], FPrintScale), PpiY));
end;

procedure TGmPrinterCanvas.Chord(inchPoints: TGmComplexPoints);
begin
  if not FActive then Exit;
//  ConvertColors;
  SelectPen;
  Windows.Chord(Handle,
                InchesToPixels(ScaleValue(inchPoints[1], FPrintScale), PpiX),
                InchesToPixels(ScaleValue(inchPoints[2], FPrintScale), PpiY),
                InchesToPixels(ScaleValue(inchPoints[3], FPrintScale), PpiX),
                InchesToPixels(ScaleValue(inchPoints[4], FPrintScale), PpiY),
                InchesToPixels(ScaleValue(inchPoints[5], FPrintScale), PpiX),
                InchesToPixels(ScaleValue(inchPoints[6], FPrintScale), PpiY),
                InchesToPixels(ScaleValue(inchPoints[7], FPrintScale), PpiX),
                InchesToPixels(ScaleValue(inchPoints[8], FPrintScale), PpiY));
end;

procedure TGmPrinterCanvas.Draw(inchX, inchY: Extended; AGraphic: TGraphic);
var
  ARect: TGmRect;
begin
  ARect.Left := inchX;
  ARect.Top  := inchY;
  ARect.Right := ARect.Left + (AGraphic.Width div SCREEN_PPI);
  ARect.Bottom := ARect.Top + (AGraphic.Height div SCREEN_PPI);
  StretchDraw(ARect, AGraphic);
end;

procedure TGmPrinterCanvas.Ellipse(inchX, inchY, inchX2, inchY2: Extended);
begin
  if not FActive then Exit;
//  ConvertColors;
  SelectPen;
  Windows.Ellipse(Handle,
                  InchesToPixels(ScaleValue(inchX, FPrintScale), PpiX),
                  InchesToPixels(ScaleValue(inchY, FPrintScale), PpiY),
                  InchesToPixels(ScaleValue(inchX2, FPrintScale), PpiX),
                  InchesToPixels(ScaleValue(inchY2, FPrintScale), PpiY));
end;

procedure TGmPrinterCanvas.MoveTo(inchX, inchY: Extended);
begin
  if not FActive then Exit;
  FPenPos := GmPoint(inchX, inchY);
  Windows.MoveToEx(Handle,
                   InchesToPixels(ScaleValue(inchX, FPrintScale), PpiX),
                   InchesToPixels(ScaleValue(inchY, FPrintScale), PpiY),
                   nil);
end;

procedure TGmPrinterCanvas.LineTo(inchX, inchY: Extended);
var
  Points: array[1..2] of TPoint;
begin
  if not FActive then Exit;
//  ConvertColors;
  SelectPen;
  Points[1] := GmPointToPixels(ScaleGmPoint(FPenPos, FPrintScale), PpiX, PpiY);
  Points[2] := GmPointToPixels(ScaleGmPoint(GmPoint(inchX, inchY), FPrintScale), PpiX, PpiY);
  Windows.Polyline(Handle, Points, High(Points));
  FPenPos := GmPoint(inchX, inchY);
end;

procedure TGmPrinterCanvas.Pie(inchPoints: TGmComplexPoints);
begin
  if not FActive then Exit;
//  ConvertColors;
  SelectPen;
  Windows.Pie(Handle,
              InchesToPixels(ScaleValue(inchPoints[1], FPrintScale), PpiX),
              InchesToPixels(ScaleValue(inchPoints[2], FPrintScale), PpiY),
              InchesToPixels(ScaleValue(inchPoints[3], FPrintScale), PpiX),
              InchesToPixels(ScaleValue(inchPoints[4], FPrintScale), PpiY),
              InchesToPixels(ScaleValue(inchPoints[5], FPrintScale), PpiX),
              InchesToPixels(ScaleValue(inchPoints[6], FPrintScale), PpiY),
              InchesToPixels(ScaleValue(inchPoints[7], FPrintScale), PpiX),
              InchesToPixels(ScaleValue(inchPoints[8], FPrintScale), PpiY));
end;


procedure TGmPrinterCanvas.Polygon(const inchPoints: array of TGmPoint);
begin
  PrintPolyShape(GM_POLYGON_ID, inchPoints);
end;

procedure TGmPrinterCanvas.Polyline(const inchPoints: array of TGmPoint);
begin
  PrintPolyShape(GM_POLYLINE_ID, inchPoints);
end;


procedure TGmPrinterCanvas.PolylineTo(const inchPoints: array of TGmPoint);
begin
  PrintPolyShape(GM_POLYLINETO_ID, inchPoints);
end;

procedure TGmPrinterCanvas.PolyBezier(const inchPoints: array of TGmPoint);
begin
  PrintPolyShape(GM_POLYBEZIER_ID, inchPoints);
end;

procedure TGmPrinterCanvas.PolyBezierTo(const inchPoints: array of TGmPoint);
begin
  PrintPolyShape(GM_POLYBEZIERTO_ID, inchPoints);
end;

procedure TGmPrinterCanvas.Rectangle(inchX, inchY, inchX2, inchY2: Extended);
begin
  if not FActive then Exit;
//  ConvertColors;
  SelectPen;
  Windows.Rectangle(Handle,
                    InchesToPixels(ScaleValue(inchX, FPrintScale), PpiX),
                    InchesToPixels(ScaleValue(inchY, FPrintScale), PpiY),
                    InchesToPixels(ScaleValue(inchX2, FPrintScale), PpiX),
                    InchesToPixels(ScaleValue(inchY2, FPrintScale), PpiY));
end;

procedure TGmPrinterCanvas.Refresh;
begin
  Canvas.Refresh;
  SetActive(True);
end;

procedure TGmPrinterCanvas.RoundRect(inchX, inchY, inchX2, inchY2, inchCornerX, inchCornerY: Extended);
begin
  if not FActive then Exit;
//  ConvertColors;
  SelectPen;
  Windows.RoundRect(Handle,
                    InchesToPixels(ScaleValue(inchX, FPrintScale), PpiX),
                    InchesToPixels(ScaleValue(inchY, FPrintScale), PpiY),
                    InchesToPixels(ScaleValue(inchX2, FPrintScale), PpiX),
                    InchesToPixels(ScaleValue(inchY2, FPrintScale), PpiY),
                    InchesToPixels(ScaleValue(inchCornerX, FPrintScale), PpiX),
                    InchesToPixels(ScaleValue(inchCornerY, FPrintScale), PpiY));
end;

procedure TGmPrinterCanvas.StretchDraw(inchRect: TGmRect; AGraphic: TGraphic);
begin
  if (AGraphic is TBitmap) then PrintBitmap(inchRect, (AGraphic as TBitmap));
  if (AGraphic is TJPegImage) then PrintJPeg(inchRect, (AGraphic as TJPegImage));
  if (AGraphic is TMetafile) then PrintMetafile(inchRect, (AGraphic as TMetafile));
end;

procedure TGmPrinterCanvas.TextBoxOut(inchRect: TGmRect; Align: TAlignment; VertAlign: TGmVertAlignment; AWordBreak: Byte; AText: string);
var
  ARect: TRect;
begin
  if not FActive then Exit;
  Canvas.Font.PixelsPerInch := Round(Canvas.Font.PixelsPerInch / FPrintScale);
  ARect.Left    := InchesToPixels(ScaleValue(inchRect.Left, FPrintScale), PpiX);
  ARect.Top     := InchesToPixels(ScaleValue(inchRect.Top, FPrintScale), PpiX);
  ARect.Right   := InchesToPixels(ScaleValue(inchRect.Right, FPrintScale), PpiX);
  ARect.Bottom  := InchesToPixels(ScaleValue(inchRect.Bottom, FPrintScale), PpiX);
  SelectPen;
  Windows.Rectangle(Handle,
                    ARect.Left,
                    ARect.Top,
                    ARect.Right,
                    ARect.Bottom);
  Canvas.Brush.Style := bsClear;
  Windows.DrawText(Handle,
                   PChar(AText),
                   Length(AText),
                   ARect,
     	             DT_NOPREFIX+
                   AWordBreak+
                   ConvertAlignment(Align)+
                   ConvertVertAlignment(VertAlign)+
                   DT_EXPANDTABS);
end;

procedure TGmPrinterCanvas.TextOut(inchX, inchY: Extended; Alignment: TAlignment; AText: string);
var
  x, y: integer;
begin
  if not FActive then Exit;

  Canvas.Font.PixelsPerInch := Round(Canvas.Font.PixelsPerInch / FPrintScale);
  Canvas.Font.Assign(Canvas.Font);
  if FFontAngle <> 0 then SelectFont(FPrintScale);

  x := InchesToPixels(ScaleValue(inchX, FPrintScale), PpiX);
  y := InchesToPixels(ScaleValue(inchY, FPrintScale), PpiY);

  if Canvas.Font.Color <> clBlack then
  begin
    if (Brush.Style <> bsClear) then
    begin
    	BeginPath;
	    case Alignment of
  	    taLeftJustify : Canvas.TextOut(x, y, AText);
    	  taCenter      : Canvas.TextOut(x-(TextWidth(AText) div 2), y, AText);
      	taRightJustify: Canvas.TextOut(x-TextWidth(AText), y, AText);
    	end;
    	EndPath;
    	FillPath;
    end;
    if (Canvas.Font.Color <> clWhite) then
    begin
    	BeginPath;
    	SetBkMode(Canvas.Handle, TRANSPARENT);
    	case Alignment of
      	taLeftJustify : Canvas.TextOut(x, y, AText);
      	taCenter      : Canvas.TextOut(x-(TextWidth(AText) div 2), y, AText);
      	taRightJustify: Canvas.TextOut(x-TextWidth(AText), y, AText);
    	end;
    	EndPath;
    	FSaveBrush.Assign(Brush);
    	Brush.Color := Font.Color;
    	FillPath;
    	Brush.Assign(FSaveBrush);
    	SetBkMode(Handle, OPAQUE);
    end;
  end
  else
    case Alignment of
      taLeftJustify : Canvas.TextOut(x, y, AText);
      taCenter      : Canvas.TextOut(x-(Round(Canvas.TextWidth(AText)*FPrintScale) div 2), y, AText);
      taRightJustify: Canvas.TextOut(x-Round(Canvas.TextWidth(AText)*FPrintScale), y, AText);
    end;
end;

procedure TGmPrinterCanvas.TextOutRotate(inchX, inchY, Angle: Extended; AText: string);
begin
  FFontAngle := Angle;
  try
    TextOut(inchX, inchY, taLeftJustify, AText);
  finally
    FFontAngle := 0;
  end;
end;

procedure TGmPrinterCanvas.BeginPath;
begin
  if not FActive then Exit;
  Windows.BeginPath(Canvas.Handle);
end;

procedure TGmPrinterCanvas.EndPath;
begin
  if not FActive then Exit;
  Windows.EndPath(Canvas.Handle);
end;

procedure TGmPrinterCanvas.StrokePath;
begin
  if not FActive then Exit;
  Windows.StrokePath(Canvas.Handle);
end;

procedure TGmPrinterCanvas.FillPath;
begin
  if not FActive then Exit;
  Windows.FillPath(Canvas.Handle);
end;

procedure TGmPrinterCanvas.StrokeAndFillPath;
begin
  if not FActive then Exit;
  Windows.StrokeAndFillPath(Canvas.Handle);
end;

procedure TGmPrinterCanvas.CloseFigure;
begin
  if not FActive then Exit;
  Windows.CloseFigure(Canvas.Handle);
end;

//------------------------------------------------------------------------------

// *** TGmPrinter ***

constructor TGmPrinter.Create;
begin
  inherited Create;
  FPrinters := TStringList.Create;
  FPrinterBins := TStringList.Create;
  FCanvas := TGmPrinterCanvas.Create;
  FTempValue := TGmValue.Create;

  //GetMem(FDevice, 80);
	//G/etMem(FDriver, 80);
	//GetMem(FPort, 80);

  ResetPrinter;
  FDuplexType := gmSimplex;
  FDitherType := gmGrayScale;
  FPagesPerSheet := gmOnePage;
  FPrintColor := gmColor;
  FTitle := DEFAULT_TITLE;
  FFileName := '';
  FOrientation := poPortrait;
  FPrintCopies := 1;
  FPrintQuality := gmMedium;
  FShowPrintDialog := True;
  FReversePrintOrder := True;
end;

destructor TGmPrinter.Destroy;
begin
  FPrinterBins.Free;
  FPrinters.Free;
  FCanvas.Free;
  //FreeMem(FDevice, 80);
  //FreeMem(FDriver, 80);
  //FreeMem(FPort, 80);
  if Assigned(FTempValue) then FTempValue.Free;
  inherited Destroy;
end;

//------------------------------------------------------------------------------

// *** Private functions ***

function TGmPrinter.GetAborted: Boolean;
begin
  Result := Printer.Aborted;
end;

function TGmPrinter.GetAvailableHeight: integer;
begin
  Result := GetDeviceCaps(Handle, VERTRES);
end;

function TGmPrinter.GetAvailableHeightGmValue: TGmValue;
begin
  Result := GetGmValue;
  if FAvailableHeight = -1 then
    FAvailableHeight := PixelsToInches(GetAvailableHeight, PrinterPpiY);
  Result.AsInches := FAvailableHeight;
end;

function TGmPrinter.GetAvailableWidth: integer;
begin
  Result := GetDeviceCaps(Handle, HORZRES);
end;

function TGmPrinter.GetAvailableWidthGmValue: TGmValue;
begin
  Result := GetGmValue;
  if FAvailableWidth = -1 then
    FAvailableWidth := PixelsToInches(GetAvailableWidth, PrinterPpiX);
  Result.AsInches := FAvailableWidth;
end;

function TGmPrinter.GetGmValue: TGmValue;
begin
  if not Assigned(FTempValue) then
    FTempValue := TGmValue.Create;
  Result := FTempValue;
end;

function TGmPrinter.GetGmValueRect: TGmValueRect;
begin
  if not Assigned(FTempValueRect) then
    FTempValueRect := TGmValueRect.Create;
  Result := FTempValueRect;
end;

function TGmPrinter.GetHandle: THandle;
begin
  if PrinterSelected then
    Result := Printer.Handle
  else
    Result := 0;
end;

function TGmPrinter.GetIndexOf(const APrinter: string): integer;
begin
  Result := FPrinters.IndexOf(APrinter);
end;

function TGmPrinter.GetIsColorPrinter: Boolean;
begin
  Result := False;
  LockPrinter;
  try
    if ((DevMode^.dmFields and dm_Color) = dm_Color) then Result := True;
  finally
    UnlockPrinter;
  end;
end;

function TGmPrinter.GetMarginsInch: TGmRect;
begin
  Result.Left   := GetOffsetInchXY.x;
  Result.Top    := GetOffsetInchXY.y;
  Result.Right  := (PrinterWidth.AsInches - AvailableWidth.AsInches) - Result.Left;
  Result.Bottom := (PrinterHeight.AsInches - AvailableHeight.AsInches) - Result.Top;
end;

function TGmPrinter.GetOffset: TPoint;
begin
  Result.x := GetPixelOffsetX;
  Result.y := GetPixelOffsetY;
end;

function TGmPrinter.GetPixelOffsetX: integer;
begin
  if FOffset.x = -1 then
  begin
    Result := GetDeviceCaps(Handle, PHYSICALOFFSETX);
    FOffset.x := Result;
  end
  else
    Result := FOffset.x;
end;

function TGmPrinter.GetPixelOffsetY: integer;
begin
  if FOffset.y = -1 then
  begin
    Result := GetDeviceCaps(Handle, PHYSICALOFFSETY);
    FOffset.y := Result;
  end
  else
    Result := FOffset.y;
end;

function TGmPrinter.GetOffsetInchXY: TGmPoint;
begin
  Result.x := PixelsToInches(GetPixelOffsetX, PrinterPpiX);
  Result.y := PixelsToInches(GetPixelOffsetY, PrinterPpiY);
end;

function TGmPrinter.GetOrientation: TPrinterOrientation;
begin
  if Printer.Printing then
  begin
    Result := FOrientation;
    Exit;
  end
  else
    Result := Printer.Orientation;
end;

function TGmPrinter.GetPageHeight: integer;
begin
  Result := GetDeviceCaps(Handle, PHYSICALHEIGHT);
end;

function TGmPrinter.GetPageWidth: integer;
begin
   Result := GetDeviceCaps(Handle, PHYSICALWIDTH);
end;

{function TGmPrinter.GetPageHeightInch: Extended;
begin
  if FPageHeight = -1 then
  begin
    Result := PixelsToInches(GetPageHeight, PrinterPpiY);
    FPageHeight := Result;
  end
  else
    Result := FPageHeight;
end;
       }
{function TGmPrinter.GetPageWidthInch: Extended;
begin
  if FPageWidth = -1 then
  begin
    Result := PixelsToInches(GetPageWidth, PrinterPpiX);
    FPageWidth := Result;
  end
  else
    Result := FPageWidth;
end; }

function TGmPrinter.GetPageHeightGmValue: TGmValue;
begin
  Result := GetGmValue;
  if FPageHeight = -1 then
    FPageHeight := PixelsToInches(GetPageHeight, PrinterPpiX);
  Result.AsInches := FPageHeight;
end;

function TGmPrinter.GetPageWidthGmValue: TGmValue;
begin
  Result := GetGmValue;
  if FPageWidth = -1 then
    FPageWidth := PixelsToInches(GetPageWidth, PrinterPpiX);
  Result.AsInches := FPageWidth;
end;

function TGmPrinter.GetPaperSize: TGmPaperSize;
begin
  LockPrinter;
  try
    if DevMode <> nil then Result :=  AsGmPaperSize(DevMode^.dmPaperSize)
    else Result := Custom;
  finally
    UnlockPrinter;
  end;
end;

function TGmPrinter.GetPpiX: integer;
begin
  if FPpiX = -1 then
  begin
    Result := GetDeviceCaps(Handle, LOGPIXELSX);
    FCanvas.FPpiX := Result;
  end
  else
    Result := FPpiX;
end;

function TGmPrinter.GetPpiY: integer;
begin
  if FPpiY = -1 then
  begin
    Result := GetDeviceCaps(Handle, LOGPIXELSY);
    FCanvas.FPpiY := Result;
  end
  else
    Result := FPpiX;
end;

function TGmPrinter.GetPrinterBinIndex: integer;
begin
  // get the current printer bin index of the selected printer...
  LockPrinter;
  try
    Result := DevMode^.dmDefaultSource;
  finally
    UnlockPrinter;
  end;
end;

function TGmPrinter.GetPrinterBins: TStrings;
var
  ICount: integer;
  ABin : array[0..255] of Char;
begin
  LockPrinter;
  try
    FPrinterBins.Clear;
    for ICount := 1 to DeviceCapabilities(FDevice,FPort,DC_BINNAMES,ABin,nil) do
      FPrinterBins.Add(ABin+24*(ICount-1));
  finally
    UnlockPrinter;
    Result := FPrinterBins;
  end;
end;

function TGmPrinter.GetPrinterIndex: integer;
begin
  if PrinterSelected then
    Result := Printer.PrinterIndex
  else
    Result := -1;
end;

function TGmPrinter.GetPrinterMargins: TGmValueRect;
var
  ARect: TGmRect;
begin
  Result := GetGmValueRect;
  ARect := GetMarginsInch;
 /// Result.Left.AsPixels[600] := GetPixelOffsetX;
 // Result.Top.AsPixels[600] := GetPixelOffsetY;
 // Result.Right.AsPixels[600] := (GetPageWidth-GetPixelOffsetX)-GetAvailableWidth;
 // Result.Bottom.AsPixels[600] := (GetPageHeight-GetPixelOffsetY)-GetAvailableHeight;
  Result.Left.AsInches := ARect.Left;
  Result.Top.AsInches := ARect.Top;
  Result.Right.AsInches := ARect.Right;
  Result.Bottom.AsInches := ARect.Bottom;
end;

procedure TGmPrinter.PrintToFile(AFileName: string);
var
  CTitle: array[0..31] of Char;
  DocInfo: TDocInfo;
begin
  with Printer do
  begin
    BeginDoc;
    { Abort job just started on API level. }
    EndPage( Canvas.handle );
    Windows.AbortDoc( Canvas.handle );
    { Restart it with a print file as destination. }
    StrPLCopy(CTitle, FTitle, SizeOf(CTitle) - 1);
    FillChar(DocInfo, SizeOf(DocInfo), 0);
    with DocInfo do
    begin
      cbSize := SizeOf(DocInfo);
      lpszDocName := CTitle;
      lpszOutput := PChar(FFileName);
    end;
    StartDoc(Canvas.handle, DocInfo);
    StartPage(Canvas.handle);
  end;
end;

function TGmPrinter.GetPrinters: TStrings;
begin
  Result := Printer.Printers;
end;

function TGmPrinter.GetPrinterSelected: Boolean;
begin
  Result := Printer.Printers.Count > 0;
end;

procedure TGmPrinter.LockPrinter;
begin
  ResetPrinter;
  // Reload the printer DEVMODE structure...
  //ReloadDevMode;
  DevMode := GlobalLock(DeviceMode);
end;

procedure TGmPrinter.OffsetCanvas;
begin
  FCanvas.Refresh;
  if FPagesPerSheet = gmTwoPage then
  begin
    if Printer.Orientation = poLandscape then
    begin
      case (FPageCount mod 2) of
        0: SetWindowOrgEx(Canvas.Handle, FOffset.x, FOffset.y, nil);
        1: SetWindowOrgEx(Canvas.Handle, FOffset.x + (0-(GetPageWidth div 2)), FOffset.y, nil);
      end
    end
    else
    begin
      case (FPageCount mod 2) of
        0: SetWindowOrgEx(Canvas.Handle, FOffset.x, FOffset.y, nil);
        1: SetWindowOrgEx(Canvas.Handle, FOffset.x, FOffset.y + (GetPageHeight div 2), nil);
      end;
    end;
  end;
  if FPagesPerSheet = gmFourPage then
  begin
    case (FPageCount mod 4) of
      0: SetWindowOrgEx(Canvas.Handle, FOffset.x, FOffset.y, nil);
      1: SetWindowOrgEx(Canvas.Handle, FOffset.x + (0-(GetPageWidth div 2)), FOffset.y, nil);
      2: SetWindowOrgEx(Canvas.Handle, FOffset.x, FOffset.y + (0-(GetPageHeight div 2)), nil);
      3: SetWindowOrgEx(Canvas.Handle, FOffset.x + (0-(GetPageWidth div 2)), FOffset.y + (0-(GetPageHeight div 2)), nil);
    end;
  end;
end;

procedure TGmPrinter.ResetPrinter;
begin
  // reset the printer...
  //ReloadDevMode;
  Printer.GetPrinter(FDevice, FDriver, FPort, DeviceMode);
  Printer.SetPrinter(FDevice, FDriver, FPort, 0);
  FOffset := Point(-1, -1);
  FAvailableWidth := -1;
  FAvailableHeight := -1;
  FPageHeight := -1;
  FPageWidth := -1;
  FPpiX := -1;
  FPpiY := -1;
  FPrintCopies := 1;
end;

procedure TGmPrinter.SetDitherType(const AValue: TGmDitherType);
begin
  LockPrinter;
  try
    if DevMode <> nil then
    begin
      case AValue of
        gmNone      : DevMode^.dmDitherType := DMDITHER_NONE;
        gmCourse    : DevMode^.dmDitherType := DMDITHER_COARSE;
        gmFine      : DevMode^.dmDitherType := DMDITHER_FINE;
        gmLineArt   : DevMode^.dmDitherType := DMDITHER_LINEART;
        gmGrayScale : DevMode^.dmDitherType := DMDITHER_GRAYSCALE;
      end;
    end;
  finally
    UnlockPrinter;
  end;
end;

procedure TGmPrinter.SetDuplexType(const AValue: TGmDuplexType);
begin
  // set the printer duplex printing option...
  LockPrinter;
  try
    if DevMode <> nil then
    begin
      case AValue of
        gmSimplex     : DevMode^.dmDuplex := DMDUP_SIMPLEX;
        gmHorzDuplex  : DevMode^.dmDuplex := DMDUP_HORIZONTAL;
        gmVertDuplex  : DevMode^.dmDuplex := DMDUP_VERTICAL;
      end;
    end;
  finally
    UnlockPrinter;
  end;
end;

procedure TGmPrinter.SetOrientation(AOrientation: TPrinterOrientation);
const
  Orientations: array [TPrinterOrientation] of Integer = (
    DMORIENT_PORTRAIT, DMORIENT_LANDSCAPE);
begin
  LockPrinter;
  try
    if ((DevMode^.dmFields and DM_ORIENTATION) = DM_ORIENTATION) then
      DevMode^.dmOrientation := Orientations[AOrientation];
  finally
    FOrientation := AOrientation;
    UnlockPrinter;
  end;
end;

procedure TGmPrinter.SetPaperSize(APaperSize: TGmPaperSize);
var
  ASize: SmallInt;
begin
  ASize := AsPrinterPaperSize(APaperSize);
  if ASize = -1 then Exit;
  LockPrinter;
  try
    if DevMode <> nil then DevMode^.dmPaperSize := ASize;
  finally
    UnlockPrinter;
  end;
end;

procedure TGmPrinter.SetPrintColor(AColor: TGmPrintColor);
begin
  LockPrinter;
  try
    if DevMode <> nil then
    begin
      FPrintColor := gmMonochrome;
      DevMode^.dmColor := DMCOLOR_MONOCHROME;
      if AColor = gmColor then
      begin
        if (DevMode^.dmFields and dm_Color) = DM_COLOR then
        begin
          DevMode^.dmColor := DMCOLOR_COLOR;
          FPrintColor := gmColor;
        end;
      end;
    end;
  finally
    UnlockPrinter;
  end;
end;

procedure TGmPrinter.SetPrintDialog(const ADialog: TPrintDialog);
begin
  FPrintDialog := ADialog;
end;

procedure TGmPrinter.SetPrinterBinIndex(const AValue: integer);
begin
  LockPrinter;
  try
    if DevMode <> nil then DevMode^.dmDefaultSource := AValue;
  finally
    UnlockPrinter;
  end;
end;

procedure TGmPrinter.SetPrinterIndex(const AValue: integer);
begin
  if Printer.PrinterIndex <> AValue then
  begin
    Printer.PrinterIndex := AValue;
    ResetPrinter;
    PrinterChanged(Self);
  end;
end;

procedure TGmPrinter.SetPrintQuality(const AValue: TGmPrintQuality);
begin
  LockPrinter;
  try
    if (DevMode^.dmFields and dm_printquality) = dm_printquality then
    begin
      case AValue of
        gmDraft : DevMode^.dmPrintQuality := Short(DMRES_DRAFT);
        gmLow   : DevMode^.dmPrintQuality := Short(DMRES_LOW);
        gmMedium: DevMode^.dmPrintQuality := Short(DMRES_MEDIUM);
        gmHigh  : DevMode^.dmPrintQuality := Short(DMRES_HIGH);
      end;
      FPrintQuality := AValue;
    end;
  finally
    UnlockPrinter;
  end;
end;

procedure TGmPrinter.SetTitle(const ATitle: string);
begin
  if FTitle <> ATitle then
    FTitle := ATitle;
end;

procedure TGmPrinter.SwapOrientation;
begin
  with Printer do
  begin
    if Orientation = poPortrait then Orientation := poLandscape
    else Orientation := poPortrait;
  end;
end;

procedure TGmPrinter.UnlockPrinter;
begin
  GlobalUnlock(DeviceMode);
end;

procedure TGmPrinter.PrinterChanged(Sender: TObject);
begin
  if Assigned(FOnPrinterChanged) then FOnPrinterChanged(Self);
end;

//------------------------------------------------------------------------------

// *** Public functions ***

procedure TGmPrinter.Abort;
begin
  // Aborts the print job during printing...
  if (FPrinting) then
  begin
    Printer.Abort;
    FPrinting := False;
  end;
end;

procedure TGmPrinter.Assign(Source: TPersistent);
var
  APrinter: TGmPrinter;
begin
  APrinter := (Source as TGmPrinter);
  FPagesPerSheet := APrinter.FPagesPerSheet;
  FPrintColor := APrinter.FPrintColor;
end;

procedure TGmPrinter.BeginDoc;
var
  Ph, Pw: integer;
begin
  ResetPrinter;
	SetDitherType(FDitherType);
  SetDuplexType(FDuplexType);
  SetPrintQuality(FPrintQuality);
  SetPrintColor(FPrintColor);
  SetOrientation(FOrientation);

  if (Assigned(FPrintDialog)) and (FShowPrintDialog) then
    if not FPrintDialog.Execute then Exit;

  Ph := GetPageHeight;
  Pw := GetPageWidth;
  case FPagesPerSheet of
    gmOnePage : Canvas.FPrintScale := 1;
    gmTwoPage : Canvas.FPrintScale := Min(Ph, Pw) / Max(Ph, Pw);
    gmFourPage: Canvas.FPrintScale := 0.5;
  end;

  FOrientationSwapped := False;
  if FPagesPerSheet = gmTwoPage then
  begin
    SwapOrientation;
    FOrientationSwapped := True;
  end;
  FPageCount := 0;
  Printer.Title := Title;

  if FFileName <> '' then PrintToFile(FFileName)
  else
    Printer.BeginDoc;
  FCanvas.FPrinterCanvas := Printer.Canvas;
  FCanvas.FPpiX := PrinterPpiX;
  FCanvas.FPpiY := PrinterPpiY;
  FCanvas.FOffset.x := GetPixelOffsetX;
  FCanvas.FOffset.y := GetPixelOffsetY;
  FCanvas.FPrintColor := FPrintColor;
  FCanvas.SetActive(True);
  FPrinting := True;
end;

procedure TGmPrinter.EndDoc;
begin
  FCanvas.SetActive(False);

  Printer.EndDoc;
  if FOrientationSwapped then SwapOrientation;
  FPrinting  := False;
end;

{  hDeviceMode: THandle;
  pDevMode: PDeviceMode;
begin

end;    }

procedure TGmPrinter.NewPage(AOrientation: TGmOrientation);

  procedure NewPage(AOrientation: TGmOrientation);
  var
    Device, Driver, Port: array[0..80] of char;
    hDeviceMode: THandle;
    pDevMode: PDeviceMode;
  begin
    // start a new printer page of the desired orientation...
    Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
    pDevMode := GlobalLock( hDevicemode );
    with pDevMode^ do
    begin
      dmFields := dmFields or DM_ORIENTATION;
      case AOrientation of
        gmPortrait  : dmOrientation := DMORIENT_PORTRAIT;
        gmLandscape : dmOrientation := DMORIENT_LANDSCAPE;
      end;
    end;
    Windows.EndPage(GetHandle);
    ResetDC(Handle, pDevMode^);
    GlobalUnlock(hDeviceMode);
    Windows.StartPage(GetHandle);
    FCanvas.Canvas.Refresh;
  end;

var
  AddPage: Boolean;
begin
  Inc(FPageCount);
  AddPage := False;
  if (FPagesPerSheet = gmOnePage) then AddPage := True;
  if (FPagesPerSheet = gmTwoPage) and (FPageCount mod 2 = 0) then AddPage := True;
  if (FPagesPerSheet = gmFourPage) and (FPageCount mod 4 = 0) then AddPage := True;
  if AddPage then
  begin
    if AOrientation = AsGmOrientation(Orientation) then
      Printer.NewPage
    else
      NewPage(AOrientation);
  end;

  OffsetCanvas;
end;

procedure TGmPrinter.RefreshPrinters;
begin
  // refresh the list of printers...
  FPrinters.Clear;
  FPrinters.Assign(GetPrinters);
end;


end.
