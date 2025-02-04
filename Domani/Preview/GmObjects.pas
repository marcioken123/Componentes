{******************************************************************************}
{                                                                              }
{                          GmObjects.pas v2.61 Pro                             }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmObjects;

interface

uses Windows, Classes, GmTypes, Graphics, GmStream, GmPrinter;

type
  // Conditional define which gives information on the compiler version...

  {$I GMPS.INC}

  // *** GmObjects ***

  TGmBaseObject = class(TGmCustomBaseObject)
  private
    FShapeID: integer;
    FRect: TRect;
    FPreviewPage: integer;
    FPrintThisObject: Boolean;
    // clip properties...
    FClipObject: Boolean;
    FClipRect: TRect;
    // canvas properties...
    FBrush: TGmBrush;
    FFont: TGmFont;
    FPen: TGmPen;
    function GetX: integer;
    function GetX2: integer;
    function GetY: integer;
    function GetY2: integer;
    procedure SetX(const NewX: integer);
    procedure SetX2(const NewX2: integer);
    procedure SetY(const NewY: integer);
    procedure SetY2(const NewY2: integer);
  public
    constructor Create; virtual;
    procedure Assign(Source: TGmBaseObject); virtual;
    procedure Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN); virtual;
    procedure SaveToStream(AStream: TStream); override;
    procedure LoadFromStream(AVersion: Extended; AStream: TStream); override;
    procedure OffsetObject(inchX, inchY: Extended); virtual;
    procedure Print(APrinter: TGmPrinter; MarginRgn: HRGN); virtual;
    // properties...
    property ClipObject: Boolean read FClipObject write FClipObject;
    property ClipRect: TRect read FClipRect write FClipRect;
    property CoordsAsRect: TRect read FRect write FRect;
    property X: Integer read GetX write SetX;
    property Y: Integer read GetY write SetY;
    property X2: integer read GetX2 write SetX2;
    property Y2: integer read GetY2 write SetY2;
    property ShapeID: integer read FShapeID;
    property Page: integer read FPreviewPage write FPreviewPage;
    property PrintThisObject: Boolean read FPrintThisObject write FPrintThisObject default True;
    // canvas properties...
    property Brush: TGmBrush read FBrush write FBrush;
    property Font: TGmFont read FFont write FFont;
    property Pen: TGmPen read FPen write FPen;
  end;

  TGmTextObject = class(TGmBaseObject)
  private
    FAlignment: TAlignment;
    FCaption: string;
    FPreview: TGmCustomPreview;
  public
    constructor Create; override;
    procedure Assign(Source: TGmBaseObject); override;
    procedure SaveToStream(AStream: TStream); override;
    procedure LoadFromStream(AVersion: Extended; AStream: TStream); override;
    procedure Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN); override;
    procedure Print(APrinter: TGmPrinter; MarginRgn: HRGN); override;
    procedure SetFontColor(AColor: TColor);
    procedure SetBrushColor(AColor: TColor);
    procedure SetBrushStyle(AStyle: TBrushStyle);
    procedure SetTextAngle(AValue: Extended);
    // properties...
    property Alignment: TAlignment read FAlignment write FAlignment;
    property Caption: string read FCaption write FCaption;
    property Preview: TGmCustomPreview read FPreview write FPreview;
  end;

  TGmTextBoxObject = class(TGmTextObject)
  private
    FAlignment: TAlignment;
    FVertAlignment: TGmVertAlignment;
    FWordBreak: Boolean;
  public
    constructor Create; override;
    procedure Assign(Source: TGmBaseObject); override;
    procedure Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN); override;
    procedure LoadFromStream(AVersion: Extended; AStream: TStream); override;
    procedure Print(APrinter: TGmPrinter; MarginRgn: HRGN); override;
    procedure SaveToStream(AStream: TStream); override;
    property Alignment: TAlignment read FAlignment write FAlignment;
    property VertAlignment: TGmVertAlignment read FVertAlignment write FVertAlignment;
    property WordBreak: Boolean read FWordBreak write FWordBreak default True;
  end;

  TGmGraphicObject = class(TGmBaseObject)
  private
    FCopyMode: TCopyMode;
    FDrawAsBitmap: Boolean;
    FGraphic: TGraphic;
    FPrintAsBitmap: Boolean;
    FTransparentColor: TColor;
    function GetGraphicType: TGmGraphicType;
    procedure SetGraphic(const AGraphic: TGraphic);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN); override;
    procedure LoadFromStream(AVersion: Extended; AStream: TStream); override;
    procedure Print(APrinter: TGmPrinter; MarginRgn: HRGN); override;
    procedure SaveToStream(AStream: TStream); override;
    property CopyMode: TCopyMode read FCopyMode write FCopyMode;
    property DrawAsBitmap: Boolean read FDrawAsBitmap write FDrawAsBitmap default False;
    property Graphic: TGraphic read FGraphic write SetGraphic;
    property GraphicType: TGmGraphicType read GetGraphicType;
    property PrintAsBitmap: Boolean read FPrintAsBitmap write FPrintAsBitmap default False;
    property TransparentColor: TColor read FTransparentColor write FTransparentColor;
  end;
  
  TGmLineObject = class(TGmBaseObject)
  private
    FLineType: TGmLineType;
  public
    constructor Create; override;
    procedure Assign(Source: TGmBaseObject); override;
    procedure LoadFromStream(AVersion: Extended; AStream: TStream); override;
    procedure SaveToStream(AStream: TStream); override;
    procedure Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN); override;
    procedure Print(APrinter: TGmPrinter; MarginRgn: HRGN); override;
    property LineType: TGmLineType read FLineType write FLineType default GmLine;
  end;

  TGmSimpleShape = class(TGmBaseObject)
  public
    procedure SaveToStream(AStream: TStream); override;
    procedure LoadFromStream(AVersion: Extended; AStream: TStream); override;
    procedure AssignBrush(ABrush: TBrush);
    procedure AssignPen(APen: TPen);
    procedure SetBrushColor(AColor: TColor);
    procedure SetBrushStyle(AStyle: TBrushStyle);
    procedure SetPenColor(AColor: TColor);
    procedure SetPenStyle(AStyle: TPenStyle);
    procedure SetPenWidth(AWidth: Integer);
    procedure SetPenMode(AMode: TPenMode);
  end;

  TGmEllipseShape = class(TGmSimpleShape)
  public
    constructor Create; override;
    procedure Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN); override;
    procedure Print(APrinter: TGmPrinter; MarginRgn: HRGN); override;
  end;

  TGmRectangleShape = class(TGmSimpleShape)
  private
    FRectType: TGmRectType;
  public
    constructor Create; override;
    procedure Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN); override;
    procedure Print(APrinter: TGmPrinter; MarginRgn: HRGN); override;
    property RectType: TGmRectType read FRectType write FRectType;
  end;

  TGmRoundRectShape = class(TGmSimpleShape)
  private
    FX3: Integer;
    FY3: Integer;
  public
    constructor Create; override;
    procedure Assign(Source: TGmBaseObject); override;
    procedure SaveToStream(AStream: TStream); override;
    procedure LoadFromStream(AVersion: Extended; AStream: TStream); override;
    procedure Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN); override;
    procedure Print(APrinter: TGmPrinter; MarginRgn: HRGN); override;
    property X3: Integer read FX3 write FX3;
    property Y3: Integer read FY3 write FY3;
  end;

  TGmComplexShape = class(TGmSimpleShape)
  private
    FX3: Integer;
    FY3: Integer;
    FX4: Integer;
    FY4: Integer;
    function GetComplexPoints: TGmComplexPoints;
  public
    procedure Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN); override;
    procedure LoadFromStream(AVersion: Extended; AStream: TStream); override;
    procedure Print(APrinter: TGmPrinter; MarginRgn: HRGN); override;
    procedure SaveToStream(AStream: TStream); override;
    // properties...
    property X3: Integer read FX3 write FX3;
    property Y3: Integer read FY3 write FY3;
    property X4: Integer read FX4 write FX4;
    property Y4: Integer read FY4 write FY4;
  end;

  TGmArcShape = class(TGmComplexShape)
  public
    constructor Create; override;
  end;

  TGmChordShape = class(TGmComplexShape)
  public
    constructor Create; override;
  end;

  TGmPieShape = class(TGmComplexShape)
  public
    constructor Create; override;
  end;

  {$IFDEF D4+}

  TGmPolyBaseObject = class(TGmBaseObject)
  public
    Points: array of TPoint;
    procedure Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN); override;
    procedure SaveToStream(AStream: TStream); override;
    procedure LoadFromStream(AVersion: Extended; AStream: TStream); override;
    procedure Print(APrinter: TGmPrinter; MarginRgn: HRGN); override;
  end;

  TGmPolygonObject = class(TGmPolyBaseObject)
  public
    constructor Create; override;
  end;

  TGmPolyLineObject = class(TGmPolyBaseObject)
  public
    constructor Create; override;
  end;

  TGmPolyLineToObject = class(TGmPolyBaseObject)
  public
    constructor Create; override;
  end;

  TGmPolyBezierObject = class(TGmPolyBaseObject)
  public
    constructor Create; override;
  end;

  TGmPolyBezierToObject = class(TGmPolyBaseObject)
  public
    constructor Create; override;
  end;

  {$ENDIF}

  TGmPathObjectType = (gmBeginPath, gmEndPath, gmFillPath, gmStrokePath,
    gmStrokeAndFillPath, gmCloseFigure);

  TGmPathObject = class(TGmBaseObject)
  private
    FObjectType: TGmPathObjectType;
  public
    constructor Create; override;
    procedure Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN); override;
    procedure LoadFromStream(AVersion: Extended; AStream: TStream); override;
    procedure Print(APrinter: TGmPrinter; MarginRgn: HRGN); override;
    procedure SaveToStream(AStream: TStream); override;
    property ObjectType: TGmPathObjectType read FObjectType write FObjectType;
  end;

  procedure GmBrushToBrush(ABrush: TBrush; AGmBrush: TGmBrush);
  procedure GmFontToFont(AFont: TFont; AGmFont: TGmFont);
  procedure GmPenToPen(ACanvas: TCanvas; APen: TPen; AGmPen: TGmPen);

implementation


uses GmPreview, JPeg, GmConst;

//------------------------------------------------------------------------------



procedure GmBrushToBrush(ABrush: TBrush; AGmBrush: TGmBrush);
begin
  ABrush.Color  := AGmBrush.Color;
  ABrush.Style  := AGmBrush.Style;
end;

procedure GmFontToFont(AFont: TFont; AGmFont: TGmFont);
begin
  AFont.Size  := AGmFont.Size;
  AFont.Color := AGmFont.Color;
  AFont.Name  := AGmFont.Name;
  AFont.Style := AGmFont.Style;
end;

procedure GmPenToPen(ACanvas: TCanvas; APen: TPen; AGmPen: TGmPen);
begin
  APen.Color := AGmPen.Color;
  APen.Style := AGmPen.Style;
  APen.Width := AGmPen.Width;
  APen.Mode  := AGmPen.Mode;
  //ACanvas.Pen.Assign(APen);
  if ACanvas <> nil then SelectPenIntoCanvas(APen, ACanvas);
end;

function SelectFontIntoCanvas(AFont: TFont; Angle: Extended; ACanvas: TCanvas): HFont;
var
  lf: TLogFont;
begin
  GetObject(ACanvas.font.Handle, sizeof(lf), @lf);
  lf.lfEscapement := Round(Angle * 10);
  lf.lfOrientation := Round(Angle * 10);
  if fsBold in ACanvas.font.Style then lf.lfWeight := FW_ULTRABOLD;
  if fsItalic in ACanvas.font.Style then lf.lfItalic := Integer(True);
  if fsUnderline in ACanvas.font.Style then lf.lfUnderline := Integer(True);
  Result := CreateFontIndirect(lf);
end;

function MetafileToBitmap(W, H: integer; AMetafile: TMetafile): TBitmap;
begin
  Result := TBitmap.Create;
  Result.Width := W;
  Result.Height := H;
  Result.PixelFormat := pf24Bit;
  PlayEnhMetaFile(Result.Canvas.Handle, AMetafile.Handle, Rect(0,0,W,H));
end;

//------------------------------------------------------------------------------

{$IFDEF D4+}

// polygon object drawing routines...

type
  PPoints = ^TPoints;
  TPoints = array[0..0] of TPoint;

procedure DrawPolygon(ACanvas: TCanvas; const Points: array of TPoint);
begin
  Windows.Polygon(ACanvas.Handle, PPoints(@Points)^, High(Points) + 1);
end;

procedure DrawPolyline(ACanvas: TCanvas; const Points: array of TPoint);
begin
  Windows.Polyline(ACanvas.Handle, PPoints(@Points)^, High(Points) + 1);
end;

procedure DrawPolyBezier(ACanvas: TCanvas; const Points: array of TPoint);
begin
  Windows.PolyBezier(ACanvas.Handle, PPoints(@Points)^, High(Points) + 1);
end;

procedure DrawPolyLineTo(ACanvas: TCanvas; const Points: array of TPoint);
begin
  Windows.PolylineTo(ACanvas.Handle, PPoints(@Points)^, High(Points) + 1);
end;

procedure DrawPolyBezierTo(ACanvas: TCanvas; const Points: array of TPoint);
begin
  Windows.PolyBezierTo(ACanvas.Handle, PPoints(@Points)^, High(Points) + 1);
end;

{$ENDIF}

//------------------------------------------------------------------------------

// *** TGmBaseObject ***

constructor TGmBaseObject.Create;
begin
  inherited Create;
  FPrintThisObject := True;
end;

procedure TGmBaseObject.Assign(Source: TGmBaseObject);
begin
  FShapeID := Source.FShapeID;
  FRect := Source.FRect;
  FPrintThisObject := Source.PrintThisObject;
  FBrush := Source.FBrush;
  FFont := Source.FFont;
  FPen := Source.FPen;
end;

procedure TGmBaseObject.Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN);
var
  ClipRgn: HRGN;
begin
  if FClipObject then
  begin
    with FClipRect do
      ClipRgn := CreateRectRgn(Round(ConvertValue(Left, gmUnits, GmInches)  * DrawDpi),
                               Round(ConvertValue(Top, gmUnits, GmInches)   * DrawDpi),
                               Round(ConvertValue(Right, gmUnits, GmInches) * DrawDpi),
                               Round(ConvertValue(Bottom, gmUnits, GmInches)* DrawDpi));
    try
      if MarginRgn <> 0 then
        CombineRgn(ClipRgn, MarginRgn, ClipRgn, RGN_AND);
      SelectClipRgn(ACanvas.Handle, ClipRgn);
    finally
      DeleteObject(ClipRgn);
    end;
  end
  else
    SelectClipRgn(ACanvas.Handle, MarginRgn);
end;

procedure TGmBaseObject.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  AStream.WriteBuffer(FShapeID, SizeOf(FShapeID));
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteInteger(X);
    GmStream.WriteInteger(Y);
    GmStream.WriteBoolean(FPrintThisObject);
    GmStream.WriteBoolean(FClipObject);
    if FClipObject then GmStream.WriteRect(FClipRect);
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

procedure TGmBaseObject.LoadFromStream(AVersion: Extended; AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    X := GmStream.ReadInteger;
    Y := GmStream.ReadInteger;
    if AVersion < 2.60 then Exit;
    FPrintThisObject := GmStream.ReadBoolean;
    FClipObject := GmStream.ReadBoolean;
    if FClipObject then FClipRect := GmStream.ReadRect;
  finally
    GmStream.Free;
  end;
end;

procedure TGmBaseObject.OffsetObject(inchX, inchY: Extended);
begin
  X := X   + Round(ConvertValue(inchX, GmInches, GmUnits));
  Y := Y   + Round(ConvertValue(inchY, GmInches, GmUnits));
  X2 := X2 + Round(ConvertValue(inchX, GmInches, GmUnits));
  Y2 := Y2 + Round(ConvertValue(inchY, GmInches, GmUnits));
end;

procedure TGmBaseObject.Print(APrinter: TGmPrinter; MarginRgn: HRGN);
var
  ClipRgn: HRGN;
  PpiX, PPiY: integer;
begin
  PpiX := APrinter.PrinterPpiX;
  PpiY := APrinter.PrinterPpiY;
  if FClipObject then
  begin
    with FClipRect do
      ClipRgn := CreateRectRgn(Round(ConvertValue(Left, gmUnits, GmInches)  * PpiX) - APrinter.Offset.x,
                               Round(ConvertValue(Top, gmUnits, GmInches)   * PpiY) - APrinter.Offset.y,
                               Round(ConvertValue(Right, gmUnits, GmInches) * PpiX) - APrinter.Offset.x,
                               Round(ConvertValue(Bottom, gmUnits, GmInches)* PpiY) - APrinter.Offset.y);
    try
      if MarginRgn <> 0 then
        CombineRgn(ClipRgn, MarginRgn, ClipRgn, RGN_AND);
      SelectClipRgn(APrinter.Canvas.Canvas.Handle, ClipRgn);
    finally
      DeleteObject(ClipRgn);
    end;
  end
  else
    SelectClipRgn(APrinter.Canvas.Canvas.Handle, MarginRgn);
end;

function TGmBaseObject.GetX: integer;
begin
  Result := FRect.Left;
end;

function TGmBaseObject.GetX2: integer;
begin
  Result := FRect.Right;
end;

function TGmBaseObject.GetY: integer;
begin
  Result := FRect.Top;
end;

function TGmBaseObject.GetY2: integer;
begin
  Result := FRect.Bottom;
end;

procedure TGmBaseObject.SetX(const NewX: integer);
begin
  FRect.Left := NewX;
end;

procedure TGmBaseObject.SetX2(const NewX2: integer);
begin
  FRect.Right := NewX2;
end;

procedure TGmBaseObject.SetY(const NewY: integer);
begin
  FRect.Top := NewY;
end;

procedure TGmBaseObject.SetY2(const NewY2: integer);
begin
  FRect.Bottom := NewY2;
end;

//------------------------------------------------------------------------------

// *** TGmTextObject ***

constructor TGmTextObject.Create;
begin
  inherited Create;
  FShapeID := GM_TEXT_ID;
end;

procedure TGmTextObject.Assign(Source: TGmBaseObject);
var
  ATextObject: TGmTextObject;
begin
  inherited Assign(Source);
  ATextObject := (Source as TGmTextObject);
  FCaption := ATextObject.FCaption;
end;

procedure TGmTextObject.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited SaveToStream(AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteBrush(FBrush);
    GmStream.WriteStr(FCaption);
    GmStream.WriteFont(FFont);
    GmStream.WriteByte(Ord(FAlignment));
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

procedure TGmTextObject.LoadFromStream(AVersion: Extended; AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited LoadFromStream(AVersion, AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FBrush    := GmStream.ReadBrush;
    FCaption  := GmStream.ReadStr;
    FFont     := GmStream.ReadFont;
    FAlignment := taLeftJustify;
    if AVersion >= 2.60 then GmStream.ReadByte;
  finally
    GmStream.Free;
  end;
end;

procedure TGmTextObject.Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN);
var
  Top, Left: integer;
  ACaption: string;
  NewFont: HFont;
  OldFont: HFont;
begin
  Left  := Round(ConvertValue(X, GmUnits, GmInches)*DrawDpi);
  Top   := Round(ConvertValue(Y, GmUnits, GmInches)*DrawDpi);
  ACanvas.Font.PixelsPerInch := DrawDpi;
  GmFontToFont(ACanvas.Font, FFont);
  GmBrushToBrush(ACanvas.Brush, FBrush);

  inherited Draw(ACanvas, DrawDpi, MarginRgn);

  ACaption := TGmPreview(FPreview).Tokenize(FCaption, FPreviewPage);

  if FFont.Angle = 0 then
  begin
  	case FAlignment of
      taLeftJustify : ACanvas.TextOut(Left, Top, ACaption);
      taCenter      : ACanvas.TextOut(Left - (ACanvas.TextWidth(ACaption) div 2), Top, ACaption);
      taRightJustify: ACanvas.TextOut(Left - ACanvas.TextWidth(ACaption), Top, ACaption);
    end;
    Exit;
  end;

  NewFont := SelectFontIntoCanvas(ACanvas.Font, Font.Angle, ACanvas);
  try
	  OldFont := SelectObject(ACanvas.Handle, NewFont);

  	case FAlignment of
      taLeftJustify : ACanvas.TextOut(Left, Top, ACaption);
      taCenter      : ACanvas.TextOut(Left - (ACanvas.TextWidth(ACaption) div 2), Top, ACaption);
      taRightJustify: ACanvas.TextOut(Left - ACanvas.TextWidth(ACaption), Top, ACaption);
    end;
   	SelectObject(ACanvas.Handle, OldFont);
  finally
    DeleteObject(NewFont);
  end;
end;

procedure TGmTextObject.Print(APrinter: TGmPrinter; MarginRgn: HRGN);
var
  inchX, inchY: Extended;
begin
  if not FPrintThisObject then Exit;
  inherited Print(APrinter, MarginRgn);
  if (Self is TGmTextBoxObject) then Exit;
  inchX := ConvertValue(X, GmUnits, GmInches);
  inchY := ConvertValue(Y, GmUnits, GmInches);
  APrinter.Canvas.FontAngle := FFont.Angle;
  try
    GmFontToFont(APrinter.Canvas.Font, FFont);
    GmBrushToBrush(APrinter.Canvas.Brush, FBrush);
    APrinter.Canvas.TextOut(inchX, inchY, FAlignment, FCaption);
  finally
    APrinter.Canvas.FontAngle := 0;
  end;
end;

procedure TGmTextObject.SetBrushColor(AColor: TColor);
begin
  if FBrush.Color <> AColor then
  begin
    FBrush.Style := bsSolid;
    FBrush.Color := AColor;
    Changed;
  end;
end;

procedure TGmTextObject.SetBrushStyle(AStyle: TBrushStyle);
begin
  if FBrush.Style <> AStyle then
  begin
    FBrush.Style := AStyle;
    Changed;
  end;
end;

procedure TGmTextObject.SetTextAngle(AValue: Extended);
begin
  if FFont.Angle <> AValue then
  begin
    FFont.Angle := AValue;
    Changed;
  end;
end;

procedure TGmTextObject.SetFontColor(AColor: TColor);
begin
  if FFont.Color <> AColor then
  begin
    FFont.Color := AColor;
    Changed;
  end;
end;

//------------------------------------------------------------------------------

// *** TGmTextBoxObject ***

constructor TGmTextBoxObject.Create;
begin
  inherited Create;
  FShapeID := GM_TEXTBOX_ID;
  FWordBreak := True;
end;

//------------------------------------------------------------------------------

procedure TGmTextBoxObject.Assign(Source: TGmBaseObject);
var
  ATextObject: TGmTextObject;
begin
  inherited Assign(Source);
  ATextObject := (Source as TGmTextObject);
  FCaption := ATextObject.FCaption;
end;

procedure TGmTextBoxObject.Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN);
var
  ARect: TRect;
  AWordBreak: Byte;
begin
  if not FWordBreak then AWordBreak := 0 else AWordBreak := DT_WORDBREAK;
  with ACanvas do
  begin
    ACanvas.Font.PixelsPerInch := DrawDpi;
    GmBrushToBrush(Brush, FBrush);
    GmFontToFont(Font, FFont);
    GmPenToPen(ACanvas, Pen, FPen);

    // calculate the destination rectangle...
    ARect.Left    := Round(ConvertValue(X, GmUnits, GmInches) * DrawDpi);
    ARect.Top     := Round(ConvertValue(Y, GmUnits, GmInches) * DrawDpi);
    ARect.Right   := Round(ConvertValue(X2, GmUnits, GmInches) * DrawDpi);
    ARect.Bottom  := Round(ConvertValue(Y2, GmUnits, GmInches) * DrawDpi);
    Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    Brush.Style := bsClear;
    Windows.DrawText(Handle,
                     PChar(FCaption),
  	                 Length(FCaption),
    	               ARect,
      	             DT_NOPREFIX+
                     AWordBreak+
                     ConvertAlignment(FAlignment)+
                     ConvertVertAlignment(FVertAlignment)+
                     DT_EXPANDTABS);
  end;
end;

procedure TGmTextBoxObject.LoadFromStream(AVersion: Extended; AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited LoadFromStream(AVersion, AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FAlignment := TAlignment(GmStream.ReadInteger);
    X2        := GmStream.ReadInteger;
    Y2        := GmStream.ReadInteger;
    FPen       := GmStream.ReadPen;
  finally
    GmStream.Free;
  end;
end;

procedure TGmTextBoxObject.Print(APrinter: TGmPrinter; MarginRgn: HRGN);
var
  AWordBreak: Byte;
  inchRect: TGmRect;
begin
  if not FPrintThisObject then Exit;
  inherited Print(APrinter, MarginRgn);
  if not FWordBreak then AWordBreak := 0 else AWordBreak := DT_WORDBREAK;
  inchRect.Left   := ConvertValue(X, GmUnits, GmInches);
  inchRect.Top    := ConvertValue(Y, GmUnits, GmInches);
  inchRect.Right  := ConvertValue(X2, GmUnits, GmInches);
  inchRect.Bottom := ConvertValue(Y2, GmUnits, GmInches);
  GmBrushToBrush(APrinter.Canvas.Brush, FBrush);
  GmFontToFont(APrinter.Canvas.Font, FFont);
  GmPenToPen(nil, APrinter.Canvas.Pen, FPen);
  APrinter.Canvas.TextBoxOut(inchRect, FAlignment, FVertAlignment, AWordBreak, FCaption);
end;

procedure TGmTextBoxObject.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited SaveToStream(AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteInteger(Ord(FAlignment));
    GmStream.WriteInteger(X2);
    GmStream.WriteInteger(Y2);
    GmStream.WritePen(FPen);
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

//------------------------------------------------------------------------------

constructor TGmGraphicObject.Create;
begin
  inherited Create;
  FShapeID := GM_GRAPHIC_ID;
  FDrawAsBitmap := False;
  FPrintAsBitmap := False;
  FCopyMode := SRCCOPY;
end;

destructor TGmGraphicObject.Destroy;
begin
  if Assigned(FGraphic) then FGraphic.Free;
  inherited;
end;

//------------------------------------------------------------------------------

// *** Private functions ***

function TGmGraphicObject.GetGraphicType: TGmGraphicType;
begin
  if (FGraphic is TBitmap)    then Result := gtBitmap else
  if (FGraphic is TIcon)      then Result := gtIcon else
  if (FGraphic is TJPEGImage) then Result := gtJPeg else
    Result := gtMetafile;
end;

procedure TGmGraphicObject.SetGraphic(const AGraphic: TGraphic);
begin
  if (AGraphic is TBitmap) then
  begin
    FGraphic := TBitmap.Create;
    (FGraphic as TBitmap).PixelFormat := pf24Bit;
  end;
  if (AGraphic is TMetafile)  then FGraphic := TMetafile.Create;
  if (AGraphic is TJPegImage) then FGraphic := TJPEGImage.Create;
  FGraphic.Assign(AGraphic);
end;

//------------------------------------------------------------------------------

// *** Public functions ***

procedure TGmGraphicObject.Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN);
var
  ARect: TRect;
  ABitmap: TBitmap;
begin
  ARect.Left    := Round(ConvertValue(X, GmUnits, GmInches) * DrawDpi);
  ARect.Top     := Round(ConvertValue(Y, GmUnits, GmInches) * DrawDpi);
  ARect.Right   := Round(ConvertValue(X2, GmUnits, GmInches) * DrawDpi);
  ARect.Bottom  := Round(ConvertValue(Y2, GmUnits, GmInches) * DrawDpi);
  ACanvas.CopyMode := FCopyMode;
  ACanvas.Brush.Style := bsSolid;
  if (FDrawAsBitmap) and (FGraphic is TMetafile) then
  begin
    ABitmap := MetafileToBitmap(ARect.Right-ARect.Left,
                                ARect.Bottom-ARect.Top,
                                (FGraphic as TMetafile));
    try
      ACanvas.StretchDraw(ARect, ABitmap);
    finally
      ABitmap.Free;
    end;
  end
  else
    ACanvas.StretchDraw(ARect, FGraphic);
end;

procedure TGmGraphicObject.LoadFromStream(AVersion: Extended; AStream: TStream);
var
  GmStream: TGmExtStream;
  AType: TGmGraphicType;
begin
  inherited LoadFromStream(AVersion, AStream);
  GmStream := TGmExtStream.Create;
  try
  	GmStream.LoadFromStream(AStream);
  	X2 := GmStream.ReadInteger;
  	Y2 := GmStream.ReadInteger;
  	FDrawAsBitmap := GmStream.ReadBoolean;
  	AType := TGmGraphicType(GmStream.ReadInteger);

  	case AType of
    	gtMetafile: FGraphic := TMetafile.Create;
	    gtBitmap  : FGraphic := TBitmap.Create;
  	  gtJPeg    : FGraphic := TJPEGImage.Create;
    	gtIcon    : FGraphic := TIcon.Create;
	  end;
  	FGraphic.LoadFromStream(GmStream);

	  // bug-fix introduced in v2.32...
  	FCopyMode := cmSrcCopy;
	  if AVersion >= 2.32 then FCopyMode := GmStream.ReadInteger;
  	if AVersion >= 2.42 then FPrintAsBitmap := GmStream.ReadBoolean;
	finally
    GmStream.Free;
  end;
end;

procedure TGmGraphicObject.Print(APrinter: TGmPrinter; MarginRgn: HRGN);
var
  ARect: TGmRect;
begin
  if not FPrintThisObject then Exit;
  inherited Print(APrinter, MarginRgn);
  ARect.Left    := ConvertValue(X, GmUnits, GmInches);
  ARect.Top     := ConvertValue(Y, GmUnits, GmInches);
  ARect.Right   := ConvertValue(X2, GmUnits, GmInches);
  ARect.Bottom  := ConvertValue(Y2, GmUnits, GmInches);
  APrinter.Canvas.CopyMode := FCopyMode;
  APrinter.Canvas.StretchDraw(ARect, FGraphic);
end;

procedure TGmGraphicObject.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited SaveToStream(AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteInteger(X2);
    GmStream.WriteInteger(Y2);
    GmStream.WriteBoolean(FDrawAsBitmap);
    GmStream.WriteInteger(Ord(GetGraphicType));
    Graphic.SaveToStream(GmStream);
    GmStream.WriteInteger(FCopyMode);
    GmStream.WriteBoolean(FPrintAsBitmap);
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

//------------------------------------------------------------------------------

// *** TGmLineObject ***

constructor TGmLineObject.Create;
begin
  inherited Create;
  FShapeID := GM_LINE_ID;
  FLineType:= GmLine;
end;

procedure TGmLineObject.Assign(Source: TGmBaseObject);
var
  ALineObject: TGmLineObject;
begin
  inherited Assign(Source);
  ALineObject := (Source as TGmLineObject);
  FLineType := ALineObject.FLineType;
end;

procedure TGmLineObject.LoadFromStream(AVersion: Extended; AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited LoadFromStream(AVersion, AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FPen      := GmStream.ReadPen;
    X2       := GmStream.ReadInteger;
    Y2       := GmStream.ReadInteger;
    FLineType := TGmLineType(GmStream.ReadInteger);
  finally
    GmStream.Free;
  end;
end;

procedure TGmLineObject.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited SaveToStream(AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.WritePen(FPen);
    GmStream.WriteInteger(X2);
    GmStream.WriteInteger(Y2);
    GmStream.WriteInteger(Ord(FLineType));
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

procedure TGmLineObject.Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN);
var
  MoveTo, LineTo: TPoint;
begin
  MoveTo.X := Round(ConvertValue(X, GmUnits, GmInches) * DrawDpi);
  MoveTo.Y := Round(ConvertValue(Y, GmUnits, GmInches) * DrawDpi);
  LineTo.X := Round(ConvertValue(X2, GmUnits, GmInches) * DrawDpi);
  LineTo.Y := Round(ConvertValue(Y2, GmUnits, GmInches) * DrawDpi);
  GmPenToPen(ACanvas, ACanvas.Pen, FPen);
  //SelectPenIntoCanvas(ACanvas.Pen, ACanvas);
  ACanvas.Polyline([MoveTo, LineTo]);
end;

procedure TGmLineObject.Print(APrinter: TGmPrinter; MarginRgn: HRGN);
var
  AMoveTo, ALineTo: TGmPoint;
begin
  if not FPrintThisObject then Exit;
  inherited Print(APrinter, MarginRgn);
  AMoveTo.x := ConvertValue(X, GmUnits, GmInches);
  AMoveTo.y := ConvertValue(Y, GmUnits, GmInches);
  ALineTo.x := ConvertValue(X2, GmUnits, GmInches);
  ALineTo.y := ConvertValue(Y2, GmUnits, GmInches);
  GmPenToPen(nil, APrinter.Canvas.Pen, FPen);
  APrinter.Canvas.MoveTo(AMoveTo.x, AMoveTo.y);
  APrinter.Canvas.LineTo(ALineTo.x, ALineTo.y);
end;

//------------------------------------------------------------------------------

// *** TGmSimpleShape ***

procedure TGmSimpleShape.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited SaveToStream(AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteBrush(FBrush);
    GmStream.WritePen(FPen);
    GmStream.WriteInteger(X2);
    GmStream.WriteInteger(Y2);
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

procedure TGmSimpleShape.LoadFromStream(AVersion: Extended; AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited LoadFromStream(AVersion, AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FBrush := GmStream.ReadBrush;
    FPen   := GmStream.ReadPen;
    X2    := GmStream.ReadInteger;
    Y2    := GmStream.ReadInteger;
  finally
    GmStream.Free;
  end;
end;

procedure TGmSimpleShape.AssignBrush(ABrush: TBrush);
begin
  FBrush.Color := ABrush.Color;
  FBrush.Style := ABrush.Style;
end;

procedure TGmSimpleShape.AssignPen(APen: TPen);
begin
  FPen.Color := APen.Color;
  FPen.Style := APen.Style;
  FPen.Width := APen.Width;
  FPen.Mode  := APen.Mode;
end;

procedure TGmSimpleShape.SetBrushColor(AColor: TColor);
begin
  FBrush.Color := AColor;
end;

procedure TGmSimpleShape.SetBrushStyle(AStyle: TBrushStyle);
begin
  FBrush.Style := AStyle;
end;

procedure TGmSimpleShape.SetPenColor(AColor: TColor);
begin
  FPen.Color := AColor;
end;

procedure TGmSimpleShape.SetPenStyle(AStyle: TPenStyle);
begin
  FPen.Style := AStyle;
end;

procedure TGmSimpleShape.SetPenWidth(AWidth: Integer);
begin
  FPen.Width := AWidth;
end;

procedure TGmSimpleShape.SetPenMode(AMode: TPenMode);
begin
  FPen.Mode := AMode;
end;

//------------------------------------------------------------------------------

// *** TGmEllipseShape ***

constructor TGmEllipseShape.Create;
begin
  inherited;
  FShapeID := GM_ELLIPSE_ID;
end;

procedure TGmEllipseShape.Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN);
var
  ARect: TRect;
begin
  ARect.Left  := Round(ConvertValue(X, GmUnits, GmInches) * DrawDpi);
  ARect.Top   := Round(ConvertValue(Y, GmUnits, GmInches) * DrawDpi);
  ARect.Right := Round(ConvertValue(X2, GmUnits, GmInches) * DrawDpi);
  ARect.Bottom:= Round(ConvertValue(Y2, GmUnits, GmInches) * DrawDpi);
  GmBrushToBrush(ACanvas.Brush, FBrush);
  GmPenToPen(ACanvas, ACanvas.Pen, FPen);
  inherited Draw(ACanvas, DrawDpi, MarginRgn);
  with ARect do ACanvas.Ellipse(Left, Top, Right, Bottom);
end;

procedure TGmEllipseShape.Print(APrinter: TGmPrinter; MarginRgn: HRGN);
var
  ARect: TGmRect;
begin
  if not FPrintThisObject then Exit;
  inherited Print(APrinter, MarginRgn);
  ARect.Left   := ConvertValue(X, GmUnits, GmInches);
  ARect.Top    := ConvertValue(Y, GmUnits, GmInches);
  ARect.Right  := ConvertValue(X2, GmUnits, GmInches);
  ARect.Bottom := ConvertValue(Y2, GmUnits, GmInches);
  GmPenToPen(nil, APrinter.Canvas.Pen, FPen);
  GmBrushToBrush(APrinter.Canvas.Brush, FBrush);
  APrinter.Canvas.Ellipse(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
end;

//------------------------------------------------------------------------------

// *** TGmRectangleShape ***

constructor TGmRectangleShape.Create;
begin
  inherited Create;
  FShapeID := GM_RECTANGLE_ID;
  FRectType := gmRectangle;
end;

procedure TGmRectangleShape.Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN);
var
  ARect: TRect;
begin
  ARect.Left  := Round(ConvertValue(X, GmUnits, GmInches) * DrawDpi);
  ARect.Top   := Round(ConvertValue(Y, GmUnits, GmInches) * DrawDpi);
  ARect.Right := Round(ConvertValue(X2, GmUnits, GmInches) * DrawDpi);
  ARect.Bottom:= Round(ConvertValue(Y2, GmUnits, GmInches) * DrawDpi);

  GmBrushToBrush(ACanvas.Brush, FBrush);
  GmPenToPen(ACanvas, ACanvas.Pen, FPen);
  inherited Draw(ACanvas, DrawDpi, MarginRgn);

  if (FRectType = gmRectangle)  then
  begin
    ACanvas.Polygon([Point(ARect.Left, ARect.Top),
                     Point(ARect.Right, ARect.Top),
                     Point(ARect.Right, ARect.Bottom),
                     Point(ARect.Left, ARect.Bottom)]);
  end
    else if FRectType = gmFillRect then
      ACanvas.FillRect(ARect);
end;

procedure TGmRectangleShape.Print(APrinter: TGmPrinter; MarginRgn: HRGN);
var
  ARect: TGmRect;
begin
  if not FPrintThisObject then Exit;
  inherited Print(APrinter, MarginRgn);
  ARect.Left   := ConvertValue(X, GmUnits, GmInches);
  ARect.Top    := ConvertValue(Y, GmUnits, GmInches);
  ARect.Right  := ConvertValue(X2, GmUnits, GmInches);
  ARect.Bottom := ConvertValue(Y2, GmUnits, GmInches);
  GmPenToPen(nil, APrinter.Canvas.Pen, FPen);
  GmBrushToBrush(APrinter.Canvas.Brush, FBrush);
  APrinter.Canvas.Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
end;

//------------------------------------------------------------------------------

// *** TGmRoundRectShape ***

constructor TGmRoundRectShape.Create;
begin
  inherited;
  FShapeID := GM_ROUNDRECT_ID;
end;

procedure TGmRoundRectShape.Assign(Source: TGmBaseObject);
var
  ARoundRect: TGmRoundRectShape;
begin
  inherited Assign(Source);
  ARoundRect := (Source as TGmRoundRectShape);
  FX3 := ARoundRect.FX3;
  FY3 := ARoundRect.FY3;
end;

procedure TGmRoundRectShape.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited SaveToStream(AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteInteger(FX3);
    GmStream.WriteInteger(FY3);
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

procedure TGmRoundRectShape.LoadFromStream(AVersion: Extended; AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited LoadFromStream(AVersion, AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FX3 := GmStream.ReadInteger;
    FY3 := GmStream.ReadInteger;
  finally
    GmStream.Free;
  end;
end;

procedure TGmRoundRectShape.Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN);
var
  ARect: TRect;
  ACorner: TPoint;
begin
  ARect.Left  := Round(ConvertValue(X, GmUnits, GmInches) * DrawDpi);
  ARect.Top   := Round(ConvertValue(Y, GmUnits, GmInches) * DrawDpi);
  ARect.Right := Round(ConvertValue(X2, GmUnits, GmInches) * DrawDpi);
  ARect.Bottom:= Round(ConvertValue(Y2, GmUnits, GmInches) * DrawDpi);
  ACorner.X   := Round(ConvertValue(X3, GmUnits, GmInches) * DrawDpi);
  ACorner.Y   := Round(ConvertValue(Y3, GmUnits, GmInches) * DrawDpi);
  GmBrushToBrush(ACanvas.Brush, FBrush);
  GmPenToPen(ACanvas, ACanvas.Pen, FPen);
  inherited Draw(ACanvas, DrawDpi, MarginRgn);
  with ARect do ACanvas.RoundRect(Left, Top, Right, Bottom, ACorner.X, ACorner.Y);
end;

procedure TGmRoundRectShape.Print(APrinter: TGmPrinter; MarginRgn: HRGN);
var
  ARect: TGmRect;
  ACorner: TGmPoint;
begin
  if not FPrintThisObject then Exit;
  inherited Print(APrinter, MarginRgn);
  ARect.Left   := ConvertValue(X, GmUnits, GmInches);
  ARect.Top    := ConvertValue(Y, GmUnits, GmInches);
  ARect.Right  := ConvertValue(X2, GmUnits, GmInches);
  ARect.Bottom := ConvertValue(Y2, GmUnits, GmInches);
  ACorner.x    := ConvertValue(X3, GmUnits, GmInches);
  ACorner.y    := ConvertValue(Y3, GmUnits, GmInches);
  GmPenToPen(nil, APrinter.Canvas.Pen, FPen);
  GmBrushToBrush(APrinter.Canvas.Brush, FBrush);
  with ARect do
    APrinter.Canvas.RoundRect(Left, Top, Right, Bottom, ACorner.x, ACorner.y);
end;

//------------------------------------------------------------------------------

// *** TGmComplexShape ***

function TGmComplexShape.GetComplexPoints: TGmComplexPoints;
begin
  Result[1] := X;
  Result[2] := Y;
  Result[3] := X2;
  Result[4] := Y2;
  Result[5] := X3;
  Result[6] := Y3;
  Result[7] := X4;
  Result[8] := Y4;
end;

procedure TGmComplexShape.Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN);
var
  I1, I2, I3, I4, I5, I6, I7, I8: integer;
begin
  GmPenToPen(ACanvas, ACanvas.Pen, FPen);
  GmBrushToBrush(ACanvas.Brush, FBrush);
  inherited Draw(ACanvas, DrawDpi, MarginRgn);
  I1 := Round(ConvertValue(X, GmUnits, GmInches) * DrawDpi);
  I2 := Round(ConvertValue(Y, GmUnits, GmInches) * DrawDpi);
  I3 := Round(ConvertValue(X2, GmUnits, GmInches) * DrawDpi);
  I4 := Round(ConvertValue(Y2, GmUnits, GmInches) * DrawDpi);
  I5 := Round(ConvertValue(X3, GmUnits, GmInches) * DrawDpi);
  I6 := Round(ConvertValue(Y3, GmUnits, GmInches) * DrawDpi);
  I7 := Round(ConvertValue(X4, GmUnits, GmInches) * DrawDpi);
  I8 := Round(ConvertValue(Y4, GmUnits, GmInches) * DrawDpi);
  case FShapeID of
    GM_ARC_ID   : ACanvas.Arc(I1, I2, I3, I4, I5, I6, I7, I8);
    GM_CHORD_ID : ACanvas.Chord(I1, I2, I3, I4, I5, I6, I7, I8);
    GM_PIE_ID   : ACanvas.Pie(I1, I2, I3, I4, I5, I6, I7, I8);
  end;
end;

procedure TGmComplexShape.LoadFromStream(AVersion: Extended; AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited LoadFromStream(AVersion, AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FX3 := GmStream.ReadInteger;
    FY3 := GmStream.ReadInteger;
    FX4 := GmStream.ReadInteger;
    FY4 := GmStream.ReadInteger;
  finally
    GmStream.Free;
  end;
end;

procedure TGmComplexShape.Print(APrinter: TGmPrinter; MarginRgn: HRGN);
var
  inchPoints: TGmComplexPoints;
begin
  if not FPrintThisObject then Exit;
  inherited Print(APrinter, MarginRgn);
  inchPoints := ConvertComplexPoints(GetComplexPoints, GmUnits, GmInches);
  GmPenToPen(nil, APrinter.Canvas.Pen, FPen);
  GmBrushToBrush(APrinter.Canvas.Brush, FBrush);
  case FShapeID of
    GM_ARC_ID   : APrinter.Canvas.Arc(inchPoints);
    GM_CHORD_ID : APrinter.Canvas.Chord(inchPoints);
    GM_PIE_ID   : APrinter.Canvas.Pie(inchPoints);
  end;
end;

procedure TGmComplexShape.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited SaveToStream(AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteInteger(FX3);
    GmStream.WriteInteger(FY3);
    GmStream.WriteInteger(FX4);
    GmStream.WriteInteger(FY4);
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

//------------------------------------------------------------------------------

// *** TGmArcShape ***

constructor TGmArcShape.Create;
begin
  inherited Create;
  FShapeID := GM_ARC_ID;
end;

//------------------------------------------------------------------------------

// *** TGmChordShape ***

constructor TGmChordShape.Create;
begin
  inherited Create;
  FShapeID := GM_CHORD_ID;
end;

//------------------------------------------------------------------------------

// *** TGmPieShape ***

constructor TGmPieShape.Create;
begin
  inherited Create;
  FShapeID := GM_PIE_ID;
end;

//------------------------------------------------------------------------------

{$IFDEF D4+}

// *** TGmPolyBaseObject ***

procedure TGmPolyBaseObject.Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN);

var
  count: integer;
  CanvasPoints: array of TPoint;
begin
  GmBrushToBrush(ACanvas.Brush, FBrush);
  GmPenToPen(ACanvas, ACanvas.Pen, FPen);
  SetLength(CanvasPoints, High(Points)+1);

  for count := 0 to High(Points) do
  begin
    CanvasPoints[count].x := Round(ConvertValue(Points[count].x, GmUnits, GmInches) * DrawDpi);
    CanvasPoints[count].y := Round(ConvertValue(Points[count].y, GmUnits, GmInches) * DrawDpi);
  end;
  inherited Draw(ACanvas, DrawDpi, MarginRgn);
  case FShapeID of
    GM_POLYGON_ID     : DrawPolygon(ACanvas, CanvasPoints);
    GM_POLYLINE_ID    : DrawPolyLine(ACanvas, CanvasPoints);
    GM_POLYBEZIER_ID  : DrawPolyBezier(ACanvas, CanvasPoints);
    GM_POLYLINETO_ID  : DrawPolyLineTo(ACanvas, CanvasPoints);
    GM_POLYBEZIERTO_ID: DrawPolyBezierTo(ACanvas, CanvasPoints);
  end;
end;

procedure TGmPolyBaseObject.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
  ICount: integer;
begin
  inherited SaveToStream(AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteBrush(FBrush);
    GmStream.WritePen(FPen);
    GmStream.WriteInteger(High(Points));
    for ICount := 0 to High(Points) do
    begin
      GmStream.WriteInteger(Points[ICount].X);
      GmStream.WriteInteger(Points[ICount].Y);
    end;
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

procedure TGmPolyBaseObject.LoadFromStream(AVersion: Extended; AStream: TStream);
var
  GmStream: TGmExtStream;
  ICount: integer;
begin
  inherited LoadFromStream(AVersion, AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FBrush := GmStream.ReadBrush;
    FPen   := GmStream.ReadPen;
    SetLength(Points, GmStream.ReadInteger+1);
    for ICount := 0 to High(Points) do
    begin
      Points[ICount].X := GmStream.ReadInteger;
      Points[ICount].Y := GmStream.ReadInteger;
    end;
  finally
    GmStream.Free;
  end;
end;

procedure TGmPolyBaseObject.Print(APrinter: TGmPrinter; MarginRgn: HRGN);
var
  ICount: integer;
  CanvasPoints: array of TGmPoint;
begin
  if not FPrintThisObject then Exit;
  inherited Print(APrinter, MarginRgn);
  GmBrushToBrush(APrinter.Canvas.Brush, FBrush);
  GmPenToPen(nil, APrinter.Canvas.Pen, FPen);

  SetLength(CanvasPoints, High(Points)+1);
  for ICount := 0 to High(Points) do
  begin
    CanvasPoints[ICount].x := ConvertValue(Points[ICount].x, GmUnits, GmInches);
    CanvasPoints[ICount].y := ConvertValue(Points[ICount].y, GmUnits, GmInches);
  end;

  case FShapeID of
    GM_POLYGON_ID     : APrinter.Canvas.Polygon(CanvasPoints);
    GM_POLYLINE_ID    : APrinter.Canvas.Polyline(CanvasPoints);
    GM_POLYBEZIER_ID  : APrinter.Canvas.PolyBezier(CanvasPoints);
    GM_POLYLINETO_ID  : APrinter.Canvas.PolylineTo(CanvasPoints);
    GM_POLYBEZIERTO_ID: APrinter.Canvas.PolyBezierTo(CanvasPoints);
  end;
end;

//------------------------------------------------------------------------------

constructor TGmPolygonObject.Create;
begin
  inherited Create;
  FShapeID := GM_POLYGON_ID;
end;

//------------------------------------------------------------------------------

// *** TPolylineObject ***

constructor TGmPolyLineObject.Create;
begin
  inherited Create;
  FShapeID := GM_POLYLINE_ID;
end;

// *** TPolylineToObject ***

constructor TGmPolyLineToObject.Create;
begin
  inherited Create;
  FShapeID := GM_POLYLINETO_ID;
end;

// *** TGmPolyBezierTo ***

constructor TGmPolyBezierObject.Create;
begin
  inherited;
  FShapeID := GM_POLYBEZIER_ID;
end;

// *** TGmPolyBezierTo ***

constructor TGmPolyBezierToObject.Create;
begin
  inherited;
  FShapeID := GM_POLYBEZIERTO_ID;
end;

{$ENDIF}

// *** TGmPathObject ***

constructor TGmPathObject.Create;
begin
  inherited;
  FShapeID := GM_PATH_OBJECT_ID;
end;

procedure TGmPathObject.Draw(ACanvas: TCanvas; DrawDpi: integer; MarginRgn:HRGN);
begin
  GmBrushToBrush(ACanvas.Brush, FBrush);
  GmPenToPen(ACanvas, ACanvas.Pen, FPen);
  case FObjectType of
    gmBeginPath        : BeginPath(ACanvas.Handle);
    gmEndPath          : EndPath(ACanvas.Handle);
    gmFillPath         : FillPath(ACanvas.Handle);
    gmStrokePath       : StrokePath(ACanvas.Handle);
    gmStrokeAndFillPath: StrokeAndFillPath(ACanvas.Handle);
    gmCloseFigure      : CloseFigure(ACanvas.Handle);
  end;
end;

procedure TGmPathObject.LoadFromStream(AVersion: Extended; AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited LoadFromStream(AVersion, AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.LoadFromStream(AStream);
    FBrush := GmStream.ReadBrush;
    FPen   := GmStream.ReadPen;
    FObjectType := TGmPathObjectType(GmStream.ReadByte);
  finally
    GmStream.Free;
  end;
end;

procedure TGmPathObject.Print(APrinter: TGmPrinter; MarginRgn: HRGN);
begin
  if not FPrintThisObject then Exit;
  inherited Print(APrinter, MarginRgn);
  GmPenToPen(nil, APrinter.Canvas.Pen, FPen);
  GmBrushToBrush(APrinter.Canvas.Brush, FBrush);
  case FObjectType of
    gmBeginPath:        APrinter.Canvas.BeginPath;
    gmEndPath:          APrinter.Canvas.EndPath;
    gmFillPath:         APrinter.Canvas.FillPath;
    gmStrokePath:       APrinter.Canvas.StrokePath;
    gmStrokeAndFillPath:APrinter.Canvas.StrokeAndFillPath;
    gmCloseFigure:      APrinter.Canvas.CloseFigure;
  end;
end;

procedure TGmPathObject.SaveToStream(AStream: TStream);
var
  GmStream: TGmExtStream;
begin
  inherited SaveToStream(AStream);
  GmStream := TGmExtStream.Create;
  try
    GmStream.WriteBrush(FBrush);
    GmStream.WritePen(FPen);
    GmStream.WriteByte(Ord(FObjectType));
  finally
    GmStream.SaveToStream(AStream);
    GmStream.Free;
  end;
end;

end.







