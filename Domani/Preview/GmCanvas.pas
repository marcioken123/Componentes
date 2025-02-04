{******************************************************************************}
{                                                                              }
{                           GmCanvas.pas v2.61 Lite                            }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmCanvas;

interface

uses Windows, Graphics, Forms, Classes, GmPrinter, GmTypes, GmObjects;

type
  // Conditional define which gives information on the compiler version...

  {$I GMPS.INC}

  TGmCustomLabelPrinter = class(TGmComponent);
  TGmCustomGridPrint    = class(TGmComponent);

  TGmCanvas = class
  private
    FFont: TFont;
    FBrush: TBrush;
    FPen: TPen;
    FClipObjects: Boolean;
    FClipRect: TRect;
    FCopyMode: TCopyMode;
    FDefaultMeasurement: TGmMeasurement;
    FDrawOffset: TGmPoint;
    FLastObject: TGmBaseObject;
    FMetafile: TMetafile;
    FMetafileCanvas: TMetafileCanvas;
    FPage: TGmPage;
    FPenPos: TPoint;
    FPreview: TGmCustomPreview;
    FTempValueSize: TGmValueSize;
    // events...
    FOnChange: TNotifyEvent;
    function CalcTextBoxHeight(x, y, x2: integer; AText: string): integer;
    function GetBrush: TBrush;
    function GetFont: TFont;
    function GetGmValueSize: TGmValueSize;
    function GetOffsetAsUnits: TPoint;
    function GetPen: TPen;
    function GetPenPos: TPoint;
    {$IFDEF D4+}
    procedure DrawPolyShape(FPolyID: integer; Points: array of TGmPoint; GmMeasurement: TGmMeasurement);
    {$ENDIF}
    procedure SetBrush(ABrush: TBrush);
    procedure SetFont(AFont: TFont);
    procedure SetPen(APen: TPen);
  protected
    procedure AddObjectToPage(AObject: TGmBaseObject);
    procedure TextOutExt(x, y, Angle: Extended; AText: string; GmMeasurement: TGmMeasurement);
  public
    constructor Create(APreview: TGmCustomPreview);
    destructor Destroy; override;
    function GraphicExtent(AGraphic: TGraphic; GmMeasurement: TGmMeasurement): TGmSize;
    function GraphicHeight(AGraphic: TGraphic): TGmValue;
    function GraphicWidth(AGraphic: TGraphic): TGmValue;
    function TextExtent(AText: string): TGmValueSize;
    function TextHeight(AText: string): TGmValue;
    function TextWidth(AText: string): TGmValue;
    // drawing functions...
    function TextBox(x, y, x2, y2: Extended; AText: string; Alignment: TAlignment;
      Draw: Boolean; GmMeasurement: TGmMeasurement): Extended;
    function TextBoxExt(x, y, x2, y2: Extended; AText: string;
      Alignment: TAlignment; VertAlignment: TGmVertAlignment; Draw: Boolean; GmMeasurement: TGmMeasurement): Extended;

    procedure Arc(x, y, x2, y2, x3, y3, x4, y4: Extended; GmMeasurement: TGmMeasurement);               {$IFDEF D4+} overload; {$ENDIF}
    procedure Chord(x, y, x2, y2, x3, y3, x4, y4: Extended; GmMeasurement: TGmMeasurement);             {$IFDEF D4+} overload; {$ENDIF}
    procedure Draw(x, y: Extended; AGraphic: TGraphic; Scale: Extended; GmMeasurement: TGmMeasurement); {$IFDEF D4+} overload; {$ENDIF}
    procedure DrawTrans(x, y: Extended; AGraphic: TGraphic; Scale: Extended; GmMeasurement: TGmMeasurement;
      TransparentColor: TColor);                                                                        {$IFDEF D4+} overload; {$ENDIF}
    procedure Ellipse(x, y, x2, y2: Extended; GmMeasurement: TGmMeasurement);                           {$IFDEF D4+} overload; {$ENDIF}
    procedure FillRect(x, y, x2, y2: Extended; GmMeasurement: TGmMeasurement);                          {$IFDEF D4+} overload; {$ENDIF}
    procedure FloatOut(x, y, AValue: Extended; Format: string; GmMeasurement: TGmMeasurement);          {$IFDEF D4+} overload; {$ENDIF}
    procedure Line(x, y, x2, y2: Extended; GmMeasurement: TGmMeasurement);                              {$IFDEF D4+} overload; {$ENDIF}
    procedure MoveTo(x, y: Extended; GmMeasurement: TGmMeasurement);                                    {$IFDEF D4+} overload; {$ENDIF}
    procedure LineTo(x, y: Extended; GmMeasurement: TGmMeasurement);                                    {$IFDEF D4+} overload; {$ENDIF}
    procedure Pie(x, y, x2, y2, x3, y3, x4, y4: Extended; GmMeasurement: TGmMeasurement);               {$IFDEF D4+} overload; {$ENDIF}
    {$IFDEF D4+}
    procedure Polygon(Points: array of TGmPoint; GmMeasurement: TGmMeasurement); overload;
    procedure PolyLine(Points: array of TGmPoint; GmMeasurement: TGmMeasurement); overload;
    procedure PolyLineTo(Points: array of TGmPoint; GmMeasurement: TGmMeasurement); overload;
    procedure PolyBezier(Points: array of TGmPoint; GmMeasurement: TGmMeasurement); overload;
    procedure PolyBezierTo(Points: array of TGmPoint; GmMeasurement: TGmMeasurement); overload;
    {$ENDIF}
    procedure Rectangle(x, y, x2, y2: Extended; GmMeasurement: TGmMeasurement);                      {$IFDEF D4+} overload; {$ENDIF}
    procedure RotateOut(x, y, Angle: Extended; AText: string; GmMeasurement: TGmMeasurement);        {$IFDEF D4+} overload; {$ENDIF}
    procedure RoundRect(x, y, x2, y2, x3, y3: Extended; GmMeasurement: TGmMeasurement);              {$IFDEF D4+} overload; {$ENDIF}
    procedure SetDrawingOffset(inchX, inchY: Extended);
    procedure StretchDraw(x,y, x2, y2: Extended; AGraphic: TGraphic; GmMeasurement: TGmMeasurement); {$IFDEF D4+} overload; {$ENDIF}
    procedure StretchDrawTrans(x,y, x2, y2: Extended; AGraphic: TGraphic;
      GmMeasurement: TGmMeasurement; TransparentColor: TColor);                                      {$IFDEF D4+} overload; {$ENDIF}
    procedure TextOut(x, y: Extended; AText: string; GmMeasurement: TGmMeasurement);                 {$IFDEF D4+} overload; {$ENDIF}
    procedure TextOutCenter(x, y: Extended; AText: string; GmMeasurement: TGmMeasurement);           {$IFDEF D4+} overload; {$ENDIF}
    procedure TextOutLeft(x, y: Extended; AText: string; GmMeasurement: TGmMeasurement);             {$IFDEF D4+} overload; {$ENDIF}
    procedure TextOutRight(x, y: Extended; AText: string; GmMeasurement: TGmMeasurement);            {$IFDEF D4+} overload; {$ENDIF}

    {$IFDEF D4+}

    // *** overloaded canvas functions which use the DefaultMeasurement property ***

    procedure Arc(x, y, x2, y2, x3, y3, x4, y4: Extended); overload;
    procedure Chord(x, y, x2, y2, x3, y3, x4, y4: Extended); overload;
    procedure Draw(x, y: Extended; AGraphic: TGraphic; Scale: Extended); overload;
    procedure DrawTrans(x, y: Extended; AGraphic: TGraphic; Scale: Extended; TransparentColor: TColor); overload;
    procedure Ellipse(x, y, x2, y2: Extended); overload;
    procedure FillRect(x, y, x2, y2: Extended); overload;
    procedure FloatOut(x, y, AValue: Extended; Format: string);  overload;
    procedure Line(x, y, x2, y2: Extended); overload;
    procedure LineTo(x, y: Extended); overload;
    procedure MoveTo(x, y: Extended); overload;
    procedure Pie(x, y, x2, y2, x3, y3, x4, y4: Extended); overload;
    procedure Polygon(Points: array of TGmPoint); overload;
    procedure PolyLine(Points: array of TGmPoint); overload;
    procedure PolyLineTo(Points: array of TGmPoint); overload;
    procedure PolyBezier(Points: array of TGmPoint); overload;
    procedure PolyBezierTo(Points: array of TGmPoint); overload;
    procedure Rectangle(x, y, x2, y2: Extended); overload;
    procedure RotateOut(x, y, Angle: Extended; AText: string); overload;
    procedure RoundRect(x, y, x2, y2, x3, y3: Extended); overload;
    procedure StretchDraw(x,y, x2, y2: Extended; AGraphic: TGraphic); overload;
    procedure TextOut(x, y: Extended; AText: string); overload;
    procedure TextOutCenter(x, y: Extended; AText: string); overload;
    procedure TextOutLeft(x, y: Extended; AText: string); overload;
    procedure TextOutRight(x, y: Extended; AText: string); overload;

    {$ENDIF}

    // path functions...
    procedure BeginPath;
    procedure EndPath;
    procedure FillPath;
    procedure StrokePath;
    procedure StrokeAndFillPath;
    procedure CloseFigure;

    procedure SetBrushValues(AColor: TColor; AStyle: TBrushStyle);
    procedure SetFontValues(AName: string; ASize: integer; AColor: TColor; AStyle: TFontStyles);
    procedure SetPenValues(AWidth: integer; AColor: TColor; AStyle: TPenStyle);

    property Brush: TBrush read GetBrush write SetBrush;
    property ClipObjects: Boolean read FClipObjects write FClipObjects default False;
    property ClipRect: TRect read FClipRect write FClipRect;
    property CopyMode: TCopyMode read FCopyMode write FCopyMode default cmSrcCopy;
    property DefaultMeasurement: TGmMeasurement read FDefaultMeasurement write FDefaultMeasurement default GmMillimeters;
    property Font: TFont read GetFont write SetFont;
    property LastObject: TGmBaseObject read FLastObject;
    property Page: TGmPage read FPage write FPage;
    property Pen: TPen read GetPen write SetPen;
    property PenPos: TPoint read GetPenPos;
    // events...
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

uses Sysutils, GmPreview, GmConst, JPeg, GmErrors;

//------------------------------------------------------------------------------

// *** Global functions ***

function IconToBitmap(AIcon: TIcon): TBitmap;
begin
  Result := TBitmap.Create;
  Result.Width := AIcon.Width;
  Result.Height := AIcon.Height;
  Result.PixelFormat := pf24Bit;
  Result.Canvas.Draw(0,0,AIcon);
end;

//------------------------------------------------------------------------------

// TGmCanvas Constructor/Destructor...

constructor TGmCanvas.Create(APreview: TGmCustomPreview);
begin
  inherited Create;
  FBrush := TBrush.Create;
  FFont := TFont.Create;
  FPen := TPen.Create;
  FPreview := APreview;
  FMetafile := TMetafile.Create;
  FMetafileCanvas := TMetafileCanvas.Create(FMetafile, 0);
  FFont.PixelsPerInch := DRAWING_DPI;
  FMetafileCanvas.Font.PixelsPerInch := DRAWING_DPI;
  FFont.Name := DEFAULT_FONT;
  FFont.Color := clBlack;
  FFont.Size := DEFAULT_FONT_SIZE;
  FMetafileCanvas.Font.Assign(FFont);
  Brush.Style := bsClear;
  FDrawOffset := GmPoint(0,0);
  FPenPos := Point(0,0);
  FCopyMode := cmSrcCopy;
  FClipObjects := False;
  FDefaultMeasurement := GmMillimeters;
end;

destructor TGmCanvas.Destroy;
begin
  FBrush.Free;
  FFont.Free;
  FPen.Free;
  FMetafileCanvas.Free;
  FMetafile.Free;
  if FTempValueSize <> nil then FTempValueSize.Free;
  inherited Destroy;
end;

//------------------------------------------------------------------------------

// *** Private functions ***

function TGmCanvas.CalcTextBoxHeight(x, y, x2: Integer; AText: string): integer;
var
  CalcRect: TRect;
  AsPixels: integer;
begin
  CalcRect.Left   := Round(ConvertValue(x, GmUnits, GmInches) * DRAWING_DPI);
  CalcRect.Top    := Round(ConvertValue(y, GmUnits, GmInches) * DRAWING_DPI);
  CalcRect.Right  := Round(ConvertValue(x2, GmUnits, GmInches) * DRAWING_DPI);
  FMetafileCanvas.Font.PixelsPerInch := DRAWING_DPI;
  FMetafileCanvas.Font.Assign(Font);
  AsPixels := Windows.DrawText(FMetafileCanvas.Handle,
              PChar(AText),
              Length(AText),
              CalcRect,
              DT_NOPREFIX+
              DT_WORDBREAK+
              DT_EXPANDTABS+
              DT_CALCRECT);
  Result := Round(((AsPixels / DRAWING_DPI) * MM_PER_INCH) * 100);
end;

function TGmCanvas.GetBrush: TBrush;
begin
  Result := FBrush;
end;

function TGmCanvas.GetFont: TFont;
begin
  Result := FFont;
end;

function TGmCanvas.GetGmValueSize: TGmValueSize;
begin
  if not Assigned(FTempValueSize) then FTempValueSize := TGmValueSize.Create;
  Result := FTempValueSize;
end;

function TGmCanvas.GetOffsetAsUnits: TPoint;
begin
  Result.x := Round(ConvertValue(FDrawOffset.x, GmInches, GmUnits));
  Result.y := Round(ConvertValue(FDrawOffset.y, GmInches, GmUnits));
end;

function TGmCanvas.GetPen: TPen;
begin
  Result := FPen;
end;

function TGmCanvas.GetPenPos: TPoint;
var
  AOffset: TPoint;
begin
  AOffset := GetOffsetAsUnits;
  Result.x := FPenPos.x - AOffset.x;
  Result.y := FPenPos.y - AOffset.y;
end;

{$IFDEF D4+}

procedure TGmCanvas.DrawPolyShape(FPolyID: integer; Points: array of TGmPoint; GmMeasurement: TGmMeasurement);
var
  APolyObject: TGmPolyBaseObject;
  ICount: integer;
begin
  // create a new polygon object and set its values...
  case FPolyID of
    GM_POLYGON_ID     : APolyObject := TGmPolygonObject.Create;
    GM_POLYLINE_ID    : APolyObject := TGmPolyLineObject.Create;
    GM_POLYBEZIER_ID  : APolyObject := TGmPolyBezierObject.Create;
    GM_POLYLINETO_ID  : APolyObject := TGmPolyLineToObject.Create;
    GM_POLYBEZIERTO_ID: APolyObject := TGmPolyBezierToObject.Create;
  else
    Exit;
  end;
  if not Assigned(APolyObject) then Exit;
  SetLength(APolyObject.Points, High(Points)+1);
  for ICount := 0 to High(Points) do
  begin
    APolyObject.Points[ICount].x := Round(ConvertValue(Points[ICount].x, GmMeasurement, GmUnits));
    APolyObject.Points[ICount].y := Round(ConvertValue(Points[ICount].y, GmMeasurement, GmUnits));
  end;
  APolyObject.Brush  := BrushToGmBrush(Brush);
  APolyObject.Pen    := PenToGmPen(Pen);
  AddObjectToPage(APolyObject);
end;

{$ENDIF}

procedure TGmCanvas.SetBrush(ABrush: TBrush);
begin
  FBrush.Assign(ABrush);
end;

procedure TGmCanvas.SetFont(AFont: TFont);
begin
  FFont.Assign(AFont);
end;

procedure TGmCanvas.SetPen(APen: TPen);
begin
  FPen.Assign(APen);
end;

//------------------------------------------------------------------------------

// *** Protected functions ***

procedure TGmCanvas.AddObjectToPage(AObject: TGmBaseObject);
begin
  // add the TGmBaseObject to the list of objects for the current page...
  AObject.OffsetObject(FDrawOffset.x, FDrawOffset.y);
  AObject.Page := TGmPreview(FPreview).CurrentPage;
  AObject.ClipObject := FClipObjects;
  AObject.ClipRect := FClipRect;
  Page.AddObject(AObject);
  FLastObject := AObject;
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TGmCanvas.TextOutExt(x, y, Angle: Extended; AText: string; GmMeasurement: TGmMeasurement);
var
  ATextObject: TGmTextObject;
begin
  // Create a text object and add it to the page objects list...
  ATextObject := TGmTextObject.Create;
  ATextObject.Preview := FPreview;
  ATextObject.Font  := FontToGmFont(Font);
  ATextObject.Page := Page.PageNum;
  ATextObject.SetTextAngle(Angle);
  ATextObject.Brush := BrushToGmBrush(Brush);
  ATextObject.X := Round(ConvertValue(x, GmMeasurement, GmUnits));
  ATextObject.Y := Round(ConvertValue(y, GmMeasurement, GmUnits));
  ATextObject.Alignment := taLeftJustify;
  ATextObject.Caption := AText;
  AddObjectToPage(ATextObject);
  FPenPos.y := ATextObject.y;
  FPenPos.x := ATextObject.x + TextWidth(AText).AsUnits;
end;

//------------------------------------------------------------------------------

// Public functions...

function TGmCanvas.GraphicExtent(AGraphic: TGraphic; GmMeasurement: TGmMeasurement): TGmSize;
begin
  Result.Height := GraphicHeight(AGraphic).AsGmValue[GmMeasurement];
  Result.Width  := GraphicWidth(AGraphic).AsGmValue[GmMeasurement];
end;

function TGmCanvas.GraphicHeight(AGraphic: TGraphic): TGmValue;
begin
  Result := GetGmValueSize.Height;
  Result.AsPixels[SCREEN_PPI] := AGraphic.Height;
end;

function TGmCanvas.GraphicWidth(AGraphic: TGraphic): TGmValue;
begin
  Result := GetGmValueSize.Width;
  Result.AsPixels[SCREEN_PPI] := AGraphic.Width;
end;

function TGmCanvas.TextExtent(AText: string): TGmValueSize;
begin
  Result := GetGmValueSize;
  Result.Height.AsInches := TextHeight(AText).AsInches;
  Result.Width.AsInches  := TextWidth(AText).AsInches;
end;

function TGmCanvas.TextHeight(AText: string): TGmValue;
begin
  Result := GetGmValueSize.Height;
  FMetafileCanvas.Font.PixelsPerInch := DRAWING_DPI;
  FMetafileCanvas.Font.Assign(Font);
  Result.AsInches := FMetafileCanvas.TextHeight(AText) / DRAWING_DPI;
end;

function TGmCanvas.TextWidth(AText: string): TGmValue;
begin
  Result := GetGmValueSize.Width;
  FMetafileCanvas.Font.PixelsPerInch := DRAWING_DPI;
  FMetafileCanvas.Font.Assign(Font);
  Result.AsInches := FMetafileCanvas.TextWidth(AText) / DRAWING_DPI;
end;

//------------------------------------------------------------------------------

// *** Drawing functions ***

function TGmCanvas.TextBox(x, y, x2, y2: Extended; AText: string;
  Alignment: TAlignment; Draw: Boolean; GmMeasurement: TGmMeasurement): Extended;
begin
  Result := TextBoxExt(x, y, x2, y2, AText, Alignment, gmTop, Draw, GmMeasurement);
end;

function TGmCanvas.TextBoxExt(x, y, x2, y2: Extended; AText: string;
  Alignment: TAlignment; VertAlignment: TGmVertAlignment; Draw: Boolean; GmMeasurement: TGmMeasurement): Extended;
var
  ATextBox: TGmTextBoxObject;
  ARect: TRect;
begin
  // create a textbox object and set its values...
  ARect.Left  := Round(ConvertValue(x,  GmMeasurement, GmUnits));
  ARect.Top   := Round(ConvertValue(y,  GmMeasurement, GmUnits));
  ARect.Right := Round(ConvertValue(x2, GmMeasurement, GmUnits));
  if y2 <> 0 then
    ARect.Bottom := Round(ConvertValue(y2, GmMeasurement, GmUnits))
  else
    ARect.Bottom := ARect.Top + CalcTextBoxHeight(ARect.Left, ARect.Top, ARect.Right, AText);
  Result := ConvertValue(ARect.Bottom-ARect.Top, GmUnits, GmMeasurement);
  if not Draw then Exit;
  ATextBox := TGmTextBoxObject.Create;
  ATextBox.CoordsAsRect := ARect;
  ATextBox.Alignment := Alignment;
  ATextBox.VertAlignment := VertAlignment;
  ATextBox.Brush := BrushToGmBrush(Brush);
  ATextBox.Font  := FontToGmFont(Font);
  ATextBox.Pen   := PenToGmPen(Pen);
  ATextBox.Caption := AText;
  AddObjectToPage(ATextBox);
end;

procedure TGmCanvas.Arc(x, y, x2, y2, x3, y3, x4, y4: Extended; GmMeasurement: TGmMeasurement);
begin
  ShowGmMessage(nil, '"TGmPreview.Canvas.Arc"'+#13+#13+PRO_VERSION_ONLY);
end;

procedure TGmCanvas.Chord(x, y, x2, y2, x3, y3, x4, y4: Extended; GmMeasurement: TGmMeasurement);
begin
  ShowGmMessage(nil, '"TGmPreview.Canvas.Chord"'+#13+#13+PRO_VERSION_ONLY);
end;

procedure TGmCanvas.Draw(x, y: Extended; AGraphic: TGraphic; Scale: Extended; GmMeasurement: TGmMeasurement);
var
  ARect: TGmRect;
  GraphicSize: TGmSize;
begin
  // Create an Graphic object and add it to the page objects list...
  GraphicSize := GraphicExtent(AGraphic, GmMeasurement);
  ARect.Left    := x;
  ARect.Top     := y;
  ARect.Right   := x + (GraphicSize.Width * Scale);
  ARect.Bottom  := y + (GraphicSize.Height * Scale);
  StretchDraw(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom, AGraphic, GmMeasurement);
end;

procedure TGmCanvas.DrawTrans(x, y: Extended; AGraphic: TGraphic; Scale: Extended; GmMeasurement: TGmMeasurement;
  TransparentColor: TColor);
begin
  Draw(x, y, AGraphic, Scale, GmMeasurement);
  TGmGraphicObject(LastObject).TransparentColor := TransparentColor;
end;

procedure TGmCanvas.Ellipse(x, y, x2, y2: Extended; GmMeasurement: TGmMeasurement);
var
  AEllipseShape: TGmEllipseShape;
begin
  // Create a Line object and add it to the page objects list...
  AEllipseShape := TGmEllipseShape.Create;
  AEllipseShape.Pen   := PenToGmPen(Pen);
  AEllipseShape.Brush := BrushToGmBrush(Brush);
  AEllipseShape.X     := Round(ConvertValue(x, GmMeasurement, GmUnits));
  AEllipseShape.Y     := Round(ConvertValue(y, GmMeasurement, GmUnits));
  AEllipseShape.X2    := Round(ConvertValue(x2, GmMeasurement, GmUnits));
  AEllipseShape.Y2    := Round(ConvertValue(y2, GmMeasurement, GmUnits));
  AddObjectToPage(AEllipseShape);
end;

procedure TGmCanvas.FillRect(x, y, x2, y2: Extended; GmMeasurement: TGmMeasurement);
begin
  ShowGmMessage(nil, '"TGmPreview.Canvas.FillRect"'+#13+#13+PRO_VERSION_ONLY);
end;

procedure TGmCanvas.FloatOut(x, y, AValue: Extended; Format: string; GmMeasurement: TGmMeasurement);
var
  AStrValue: string;
begin
  // draw a float value to the page with a specific format...
  AStrValue := FormatFloat(Format, AValue);
  TextOutRight(x, y, AStrValue, GmMeasurement);
end;

procedure TGmCanvas.Line(x, y, x2, y2: Extended; GmMeasurement: TGmMeasurement);
var
  ALineObject: TGmLineObject;
begin
  // Create a Line object and add it to the page objects list...
  ALineObject := TGmLineObject.Create;
  ALineObject.Pen := PenToGmPen(Pen);
  ALineObject.X   := Round(ConvertValue(x, GmMeasurement, GmUnits));
  ALineObject.Y   := Round(ConvertValue(y, GmMeasurement, GmUnits));
  ALineObject.X2  := Round(ConvertValue(x2, GmMeasurement, GmUnits));
  ALineObject.Y2  := Round(ConvertValue(y2, GmMeasurement, GmUnits));
  AddObjectToPage(ALineObject);
end;

procedure TGmCanvas.MoveTo(x, y: Extended; GmMeasurement: TGmMeasurement);
begin
  FPenPos.x := Round(ConvertValue(x, GmMeasurement, GmUnits));
  FPenPos.y := Round(ConvertValue(y, GmMeasurement, GmUnits));
end;

procedure TGmCanvas.Pie(x, y, x2, y2, x3, y3, x4, y4: Extended; GmMeasurement: TGmMeasurement);
begin
  ShowGmMessage(nil, '"TGmPreview.Canvas.Pie"'+#13+#13+PRO_VERSION_ONLY);
end;

procedure TGmCanvas.LineTo(x, y: Extended; GmMeasurement: TGmMeasurement);
var
  StartPos: TPoint;
begin
  StartPos := FPenPos;
  MoveTo(x, y, GmMeasurement);
  Line(StartPos.x,
       StartPos.y,
       FPenPos.x,
       FPenPos.y,
       GmUnits);
end;

{$IFDEF D4+}

procedure TGmCanvas.Polygon(Points: array of TGmPoint; GmMeasurement: TGmMeasurement);
begin
  DrawPolyShape(GM_POLYGON_ID, Points, GmMeasurement);
end;

procedure TGmCanvas.PolyLine(Points: array of TGmPoint; GmMeasurement: TGmMeasurement);
begin
  DrawPolyShape(GM_POLYLINE_ID, Points, GmMeasurement);
end;

procedure TGmCanvas.PolyLineTo(Points: array of TGmPoint; GmMeasurement: TGmMeasurement);
begin
  DrawPolyShape(GM_POLYLINETO_ID, Points, GmMeasurement);
end;

procedure TGmCanvas.PolyBezier(Points: array of TGmPoint; GmMeasurement: TGmMeasurement);
begin
  DrawPolyShape(GM_POLYBEZIER_ID, Points, GmMeasurement);
end;

procedure TGmCanvas.PolyBezierTo(Points: array of TGmPoint; GmMeasurement: TGmMeasurement);
begin
  DrawPolyShape(GM_POLYBEZIERTO_ID, Points, GmMeasurement);
end;

{$ENDIF} 

procedure TGmCanvas.Rectangle(x, y, x2, y2: Extended; GmMeasurement: TGmMeasurement);
var
  ARectangleShape: TGmRectangleShape;
begin
  // Create a Rectangle object and add it to the page objects list...
  ARectangleShape := TGmRectangleShape.Create;
  ARectangleShape.Pen   := PenToGmPen(Pen);
  ARectangleShape.Brush := BrushToGmBrush(Brush);
  ARectangleShape.X     := Round(ConvertValue(x, GmMeasurement, GmUnits));
  ARectangleShape.Y     := Round(ConvertValue(y, GmMeasurement, GmUnits));
  ARectangleShape.X2    := Round(ConvertValue(x2, GmMeasurement, GmUnits));
  ARectangleShape.Y2    := Round(ConvertValue(y2, GmMeasurement, GmUnits));
  AddObjectToPage(ARectangleShape);
end;

procedure TGmCanvas.RotateOut(x, y, Angle: Extended; AText: string; GmMeasurement: TGmMeasurement);
begin
  ShowGmMessage(nil, '"TGmPreview.Canvas.RotateOut"'+#13+#13+PRO_VERSION_ONLY);
end;

procedure TGmCanvas.RoundRect(x, y, x2, y2, x3, y3: Extended; GmMeasurement: TGmMeasurement);
var
  ARoundRectShape: TGmRoundRectShape;
begin
  // Create a Round Rect object and add it to the page objects list...
  ARoundRectShape := TGmRoundRectShape.Create;
  ARoundRectShape.Pen   := PenToGmPen(Pen);
  ARoundRectShape.Brush := BrushToGmBrush(Brush);
  ARoundRectShape.X     := Round(ConvertValue(x, GmMeasurement, GmUnits));
  ARoundRectShape.Y     := Round(ConvertValue(y, GmMeasurement, GmUnits));
  ARoundRectShape.X2    := Round(ConvertValue(x2, GmMeasurement, GmUnits));
  ARoundRectShape.Y2    := Round(ConvertValue(y2, GmMeasurement, GmUnits));
  ARoundRectShape.X3    := Round(ConvertValue(x3, GmMeasurement, GmUnits));
  ARoundRectShape.Y3    := Round(ConvertValue(y3, GmMeasurement, GmUnits));
  AddObjectToPage(ARoundRectShape);
end;

procedure TGmCanvas.SetDrawingOffset(inchX, inchY: Extended);
begin
  FDrawOffset := GmPoint(inchX, inchY);
end;

procedure TGmCanvas.StretchDraw(x,y, x2, y2: Extended; AGraphic: TGraphic; GmMeasurement: TGmMeasurement);
var
  AObject: TGmGraphicObject;
  ARect: TRect;
  ABitmap: TBitmap;
begin
  // create a new graphic object and set its values...
  if Assigned(AGraphic) then
  begin
    ARect.Left    := Round(ConvertValue(x, GmMeasurement, GmUnits));
    ARect.Top     := Round(ConvertValue(y, GmMeasurement, GmUnits));
    ARect.Right   := Round(ConvertValue(x2, GmMeasurement, GmUnits));
    ARect.Bottom  := Round(ConvertValue(y2, GmMeasurement, GmUnits));
    AObject := TGmGraphicObject.Create;
    AObject.CopyMode := FCopyMode;
    AObject.CoordsAsRect := ARect;
    if (AGraphic is TIcon)      then
    begin
      ABitmap := IconToBitmap(TIcon(AGraphic));
      try
        AObject.Graphic := ABitmap;
      finally
        ABitmap.Free;
      end;
    end;
    if (AGraphic is TBitmap)    then AObject.Graphic := (AGraphic as TBitmap);
    if (AGraphic is TMetafile)  then AObject.Graphic := (AGraphic as TMetafile);
    if (AGraphic is TJPEGImage) then AObject.Graphic := (AGraphic as TJPEGImage);
    AddObjectToPage(AObject);
  end;
end;

procedure TGmCanvas.StretchDrawTrans(x,y, x2, y2: Extended; AGraphic: TGraphic;
      GmMeasurement: TGmMeasurement; TransparentColor: TColor);
begin
{ TODO : stretchdrawtrans }
end;

procedure TGmCanvas.TextOut(x, y: Extended; AText: string; GmMeasurement: TGmMeasurement);
begin
  TextOutExt(x, y, 0, AText, GmMeasurement);
end;

procedure TGmCanvas.TextOutCenter(x, y: Extended; AText: string; GmMeasurement: TGmMeasurement);
begin
  TextOut(x, y, AText, GmMeasurement);
  (LastObject as TGmTextObject).Alignment := taCenter;
end;

procedure TGmCanvas.TextOutLeft(x, y: Extended; AText: string; GmMeasurement: TGmMeasurement);
begin
  TextOut(x, y, AText, GmMeasurement);
end;

procedure TGmCanvas.TextOutRight(x, y: Extended; AText: string; GmMeasurement: TGmMeasurement);
begin
  TextOut(x, y, AText, GmMeasurement);
  TGmTextObject(LastObject).Alignment := taRightJustify;
end;

{$IFDEF D4+}

// *** overloaded canvas functions which use the DefaultMeasurement property ***

procedure TGmCanvas.Arc(x, y, x2, y2, x3, y3, x4, y4: Extended);
begin
  Arc(x, y, x2, y2, x3, y3, x4, y4, FDefaultMeasurement);
end;

procedure TGmCanvas.Chord(x, y, x2, y2, x3, y3, x4, y4: Extended);
begin
  Chord(x, y, x2, y2, x3, y3, x4, y4, FDefaultMeasurement);
end;

procedure TGmCanvas.Draw(x, y: Extended; AGraphic: TGraphic; Scale: Extended);
begin
  Draw(x, y, AGraphic, Scale, FDefaultMeasurement);
end;

procedure TGmCanvas.DrawTrans(x, y: Extended; AGraphic: TGraphic; Scale: Extended; TransparentColor: TColor);
begin
  DrawTrans(x, y, AGraphic, Scale, FDefaultMeasurement, TransparentColor);
end;

procedure TGmCanvas.Ellipse(x, y, x2, y2: Extended);
begin
  Ellipse(x, y, x2, y2, FDefaultMeasurement);
end;

procedure TGmCanvas.FillRect(x, y, x2, y2: Extended);
begin
  FillRect(x, y, x2, y2, FDefaultMeasurement);
end;

procedure TGmCanvas.FloatOut(x, y, AValue: Extended; Format: string);
begin
  FloatOut(x, y, AValue, Format, FDefaultMeasurement);
end;

procedure TGmCanvas.Line(x, y, x2, y2: Extended);
begin
  Line(x, y, x2, y2, FDefaultMeasurement);
end;

procedure TGmCanvas.LineTo(x, y: Extended);
begin
  LineTo(x, y, FDefaultMeasurement);
end;

procedure TGmCanvas.MoveTo(x, y: Extended);
begin
  MoveTo(x, y, FDefaultMeasurement);
end;

procedure TGmCanvas.Pie(x, y, x2, y2, x3, y3, x4, y4: Extended);
begin
  Pie(x, y, x2, y2, x3, y3, x4, y4, FDefaultMeasurement);
end;

procedure TGmCanvas.Polygon(Points: array of TGmPoint);
begin
  Polygon(Points, FDefaultMeasurement);
end;

procedure TGmCanvas.PolyLine(Points: array of TGmPoint);
begin
  Polyline(Points, FDefaultMeasurement);
end;

procedure TGmCanvas.PolyLineTo(Points: array of TGmPoint);
begin
  PolylineTo(Points, FDefaultMeasurement);
end;

procedure TGmCanvas.PolyBezier(Points: array of TGmPoint);
begin
  PolyBezier(Points, FDefaultMeasurement);
end;

procedure TGmCanvas.PolyBezierTo(Points: array of TGmPoint);
begin
  PolyBezierTo(Points, FDefaultMeasurement);
end;

procedure TGmCanvas.Rectangle(x, y, x2, y2: Extended);
begin
  Rectangle(x, y, x2, y2, FDefaultMeasurement);
end;

procedure TGmCanvas.RotateOut(x, y, Angle: Extended; AText: string);
begin
  RotateOut(x, y, Angle, AText, FDefaultMeasurement);
end;

procedure TGmCanvas.RoundRect(x, y, x2, y2, x3, y3: Extended);
begin
  RoundRect(x, y, x2, y2, x3, y3, FDefaultMeasurement);
end;

procedure TGmCanvas.StretchDraw(x,y, x2, y2: Extended; AGraphic: TGraphic);
begin
  StretchDraw(x,y, x2, y2, AGraphic, FDefaultMeasurement);
end;

procedure TGmCanvas.TextOut(x, y: Extended; AText: string);
begin
  TextOut(x, y, AText, FDefaultMeasurement);
end;

procedure TGmCanvas.TextOutCenter(x, y: Extended; AText: string);
begin
  TextOutCenter(x, y, AText, FDefaultMeasurement);
end;

procedure TGmCanvas.TextOutLeft(x, y: Extended; AText: string);
begin
  TextOut(x, y, AText);
end;

procedure TGmCanvas.TextOutRight(x, y: Extended; AText: string);
begin
  TextOutRight(x, y, AText, FDefaultMeasurement);
end;

{$ENDIF}

procedure TGmCanvas.BeginPath;
var
  AObject: TGmPathObject;
begin
  AObject := TGmPathObject.Create;
  AObject.ObjectType := gmBeginPath;
  AddObjectToPage(AObject);
end;

procedure TGmCanvas.EndPath;
var
  AObject: TGmPathObject;
begin
  AObject := TGmPathObject.Create;
  AObject.ObjectType := gmEndPath;
  AddObjectToPage(AObject);
end;

procedure TGmCanvas.FillPath;
var
  AObject: TGmPathObject;
begin
  AObject := TGmPathObject.Create;
  AObject.ObjectType := gmFillPath;
  AddObjectToPage(AObject);
end;

procedure TGmCanvas.StrokePath;
var
  AObject: TGmPathObject;
begin
  AObject := TGmPathObject.Create;
  AObject.ObjectType := gmStrokePath;
  AddObjectToPage(AObject);
end;

procedure TGmCanvas.StrokeAndFillPath;
var
  AObject: TGmPathObject;
begin
  AObject := TGmPathObject.Create;
  AObject.ObjectType := gmStrokeAndFillPath;
  AddObjectToPage(AObject);
end;

procedure TGmCanvas.CloseFigure;
var
  AObject: TGmPathObject;
begin
  AObject := TGmPathObject.Create;
  AObject.ObjectType := gmCloseFigure;
  AddObjectToPage(AObject);
end;

procedure TGmCanvas.SetBrushValues(AColor: TColor; AStyle: TBrushStyle);
begin
  // assign brush properties...
  Brush.Color := AColor;
  Brush.Style := AStyle;
end;

procedure TGmCanvas.SetFontValues(AName: string; ASize: integer; AColor: TColor; AStyle: TFontStyles);
begin
  // assign font properties...
  if AName <> '' then
    Font.Name := AName;
  Font.Size := ASize;
  Font.Color := AColor;
  Font.Style := AStyle;
end;

procedure TGmCanvas.SetPenValues(AWidth: integer; AColor: TColor; AStyle: TPenStyle);
begin
  // assign pen properties...
  Pen.Color := AColor;
  Pen.Style := AStyle;
  Pen.Width := AWidth;
end;

end.
