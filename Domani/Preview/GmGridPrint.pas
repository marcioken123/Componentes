{******************************************************************************}
{                                                                              }
{                        GmGridPrint.pas v2.61 Pro                             }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmGridPrint;

interface

  {$I GMPS.INC}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  GmPreview, GmTypes, grids, GmCanvas;

type
  TGmDrawCellEvent        = procedure (Sender: TObject; AGrid: TDrawGrid; Col, Row: Longint; ARect: TGmValueRect; ACanvas: TGmCanvas) of object;
  TGetCellAlignmentEvent  = procedure (Sender: TObject; AGrid: TDrawGrid; Col, Row: Longint; var Alignment: TAlignment; var VertAlignment: TGmVertAlignment) of object;
  TGridNewPageEvent       = procedure (Sender: TObject; var ATopMargin, ABottomMargin: TGmValue) of object;


  TGmColWidth = class
  private
    FColumn : integer;
    FWidth  : integer;                  
  public
    property Column: integer read FColumn write FColumn;
    property Width: integer read FWidth write FWidth;
  end;

  TGmColWidthList = class(TList)
  private
    FScale: Extended;
    function GetColWidth(ACol: integer): TGmColWidth;
    function GetTotalWidth: integer;
    procedure SetColWidth(ACol: integer; Value: TGmColWidth);
  public
    procedure AddColWidth(ACol, AWidth: integer);
    procedure Clear; {$IFDEF D4+} override; {$ENDIF}
    property ColWidth[ACol: integer]: TGmColWidth read GetColWidth write SetColWidth; default;
    property Scale: Extended read FScale write FScale;
    property TotalWidth: integer read GetTotalWidth;
  end;

  TGmGridOption = (gmVertLine, gmHorzLine, gmFixedRowPerPage);
  TGmGridOptions = set of TGmGridOption;

  TGmGridPrint = class(TGmCustomGridPrint)
  private
    FMonochrome: Boolean;
    FColWidths: TGmColWidthList;
    FDefaultCellAlign: TAlignment;
    FDefaultCellVertAlign: TGmVertAlignment;
    FGridOptions: TGmGridOptions;
    FPreview: TGmPreview;
    FScaleText: Boolean;
    FTopMargin: TGmValue;
    FBottomMargin: TGmValue;
    // events...
    FOnDrawCell: TGmDrawCellEvent;
    FOnGetCellAlignment: TGetCellAlignmentEvent;
    FOnGridNewPage: TGridNewPageEvent;
    function GetCellRect(AGrid: TDrawGrid; CurrLeft, CurrTop, ACol, ARow: integer): TRect;
    procedure DefaultDrawCellExt(AGrid: TDrawGrid; ARect: TGmValueRect;
      ACol, ARow: integer; Alignment: TAlignment; VertAlignment: TGmVertAlignment);
    procedure DrawBottomLine(ARow: integer; AGrid: TDrawGrid; ALeft: integer; ATop: integer);
    procedure DrawTopLine(ARow: integer; AGrid: TDrawGrid; ALeft: integer; ATop: integer);
    procedure DrawGridRow(ARow: integer; AGrid: TDrawGrid; ALeft: integer; var ATop: integer);
    procedure SetPreview(const Value: TGmPreview);
    { Private declarations }
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsFixedCell(AGrid: TDrawGrid; ACol, ARow: integer): Boolean;
    procedure DefaultDrawCell(AGrid: TDrawGrid; ARect: TGmValueRect; ACol, ARow: integer);
    procedure GridToPage(X, Y, AWidth: Extended; AUnits: TGmMeasurement;
      AGrid: TDrawGrid);
    property TopMargin: TGmValue read FTopMargin write FTopMargin;
    property BottomMargin: TGmValue read FBottomMargin write FBottomMargin;
    { Public declarations }
  published
    { Published declarations }
    property DefaultCellAlignment: TAlignment read FDefaultCellAlign write FDefaultCellAlign default taLeftJustify;
    property DefaultCellVertAlignment: TGmVertAlignment read FDefaultCellVertAlign write FDefaultCellVertAlign default gmTop;
    property GridOptions: TGmGridOptions read FGridOptions write FGridOptions
      default [gmVertLine, gmHorzLine, gmFixedRowPerPage];
    property Monochrome: Boolean read FMonochrome write FMonochrome default False;
    property Preview: TGmPreview read FPreview write SetPreview;
    property ScaleText: Boolean read FScaleText write FScaleText default False;
    // events...
    property OnDrawCell: TGmDrawCellEvent read FOnDrawCell write FOnDrawCell;
    property OnGetCellAlignment: TGetCellAlignmentEvent read FOnGetCellAlignment write FOnGetCellAlignment;
    property OnGridNewPage: TGridNewPageEvent read FOnGridNewPage write FOnGridNewPage;
  end;

implementation

uses GmErrors, Dialogs, GmConst, GmObjects;

//------------------------------------------------------------------------------

procedure TGmColWidthList.AddColWidth(ACol, AWidth: integer);
var
  NewColWidth: TGmColWidth;
begin
  NewColWidth := TGmColWidth.Create;
  NewColWidth.Column := ACol;
  NewColWidth.Width := AWidth;
  Add(NewColWidth);
end;

procedure TGmColWidthList.Clear;
var
  ICount: integer;
begin
  for ICount := Count-1 downto 0 do
  begin
    TGmColWidth(Self[ICount]).Free;
  end;
  {$IFDEF D4+}
  inherited Clear;
  {$ENDIF}
end;

function TGmColWidthList.GetColWidth(ACol: integer): TGmColWidth;
begin
  Result := TGmColWidth(Items[ACol]);
end;

function TGmColWidthList.GetTotalWidth: integer;
var
  ICount: integer;
begin
  Result := 0;
  for ICount := 0 to Count-1 do
    Inc(Result, ColWidth[ICount].Width);
end;

procedure TGmColWidthList.SetColWidth(ACol: integer; Value: TGmColWidth);
begin
  Items[ACol] := Value;
end;

//------------------------------------------------------------------------------

constructor TGmGridPrint.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColWidths := TGmColWidthList.Create;
  FGridOptions := [gmVertLine, gmHorzLine, gmFixedRowPerPage];
  FMonochrome := False;
  FTopMargin    := TGmValue.CreateValue(3500);
  FBottomMargin := TGmValue.CreateValue(3500);
  FScaleText := False;
  FDefaultCellAlign := taLeftJustify;
  FDefaultCellVertAlign := gmTop;
end;

destructor TGmGridPrint.Destroy;
begin
  // free TGmPrintSuite objects...
  FTopMargin.Free;
  FBottomMargin.Free;
  FColWidths.Free;
  inherited;
end;

function TGmGridPrint.IsFixedCell(AGrid: TDrawGrid; ACol, ARow: integer): Boolean;
begin
  Result := (ACol < AGrid.FixedCols) or (ARow < AGrid.FixedRows);
end;

procedure TGmGridPrint.DefaultDrawCell(AGrid: TDrawGrid; ARect: TGmValueRect; ACol, ARow: integer);
begin
  DefaultDrawCellExt(AGrid, ARect, ACol, ARow, FDefaultCellAlign, FDefaultCellVertAlign);
end;

procedure TGmGridPrint.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FPreview) then
    FPreview := nil;
end;

procedure TGmGridPrint.DefaultDrawCellExt(AGrid: TDrawGrid; ARect: TGmValueRect;
  ACol, ARow: integer; Alignment: TAlignment; VertAlignment: TGmVertAlignment);
var
  FontSize: integer;
  CellAlign: TAlignment;
  CellVertAlign: TGmVertAlignment;
begin
  CellAlign := Alignment;
  CellVertAlign := VertAlignment;
  if Assigned(FOnGetCellAlignment) then FOnGetCellAlignment(Self, AGrid, ACol, ARow, CellAlign, CellVertAlign);

  with FPreview.Canvas do
  begin
    if not FMonochrome then
    begin
      Rectangle(ARect.Left.AsUnits,
                ARect.Top.AsUnits,
                ARect.Right.AsUnits,
                ARect.Bottom.AsUnits,
                GmUnits);
    end;
    if (AGrid is TStringGrid) then
    begin
      Pen.Style := psClear;
      Brush.Style := bsClear;
      FontSize := Font.Size;
      Font.Size := AGrid.Font.Size;
      if FScaleText then Font.Size := Round(FColWidths.Scale * Font.Size);
      try
        TextBoxExt(ARect.Left.AsUnits+50, // 0.5 mm margin
                   ARect.Top.AsUnits+50,
                   ARect.Right.AsUnits-50, // 0.5 mm margin
                   ARect.Bottom.AsUnits-50,
                   TStringGrid(AGrid).Cells[ACol, ARow],
                   CellAlign,
                   CellVertAlign,
                   True,
                   GmUnits);
        TGmTextBoxObject(LastObject).WordBreak := False;
      finally
        Font.Size := FontSize;
      end;
    end;
    Pen.Style := psSolid;
  end;
end;

function TGmGridPrint.GetCellRect(AGrid: TDrawGrid; CurrLeft, CurrTop, ACol, ARow: integer): TRect;
begin
  Result.Left   := CurrLeft;
  Result.Top    := CurrTop;
  Result.Right  := CurrLeft + FColWidths[ACol].Width;
  Result.Bottom := CurrTop  + Round(ConvertValue(AGrid.RowHeights[ARow], GmPixels, GmUnits));
end;

procedure TGmGridPrint.DrawBottomLine(ARow: integer; AGrid: TDrawGrid; ALeft: integer; ATop: integer);
var
  ICount: integer;
  ARect: TRect;
begin
  for ICount := 0 to AGrid.ColCount-1 do
  begin
    ARect := GetCellRect(AGrid, ALeft, ATop, ICount, ARow);
    FPreview.Canvas.Pen.Style := psSolid;
    FPreview.Canvas.Line(ARect.Left, ARect.Bottom, ARect.Right, ARect.Bottom, GmPixels);
    Inc(ALeft, FColWidths[ICount].Width);
  end;
end;

procedure TGmGridPrint.DrawTopLine(ARow: integer; AGrid: TDrawGrid; ALeft: integer; ATop: integer);
var
  ICount: integer;
  ARect: TRect;
begin
  for ICount := 0 to AGrid.ColCount-1 do
  begin
    ARect := GetCellRect(AGrid, ALeft, ATop, ICount, ARow);
    FPreview.Canvas.Pen.Style := psSolid;
    FPreview.Canvas.Line(ARect.Left, ARect.Top, ARect.Right, ARect.Top, GmPixels);
    Inc(ALeft, FColWidths[ICount].Width);
  end;
end;

procedure TGmGridPrint.DrawGridRow(ARow: integer; AGrid: TDrawGrid; ALeft: integer; var ATop: integer);
var
  ICount: integer;
  ARect: TRect;
  AGmRect: TGmValueRect;
begin
  for ICount := 0 to AGrid.ColCount-1 do
  begin
    ARect := GetCellRect(AGrid, ALeft, ATop, ICount, ARow);

    FPreview.Canvas.Pen.Style := psSolid;
    FPreview.Canvas.Pen.Color := clBlack;
    FPreview.Canvas.Brush.Style := bsClear;

    // draw the grid's horizontal lines...
    if (ARow = 0) or (gmHorzLine in FGridOptions) then
      FPreview.Canvas.Line(ARect.Left, ARect.Top, ARect.Right, ARect.Top, GmUnits);

    // draw the grid's vertical lines...
    if (ICount = 0) or (gmVertLine in FGridOptions) then
      FPreview.Canvas.Line(ARect.Left, ARect.Top, ARect.Left, ARect.Bottom, GmUnits);

    // draw the right border...
    if (ICount = AGrid.ColCount-1)  then
      FPreview.Canvas.Line(ARect.Right, ARect.Top, ARect.Right, ARect.Bottom, GmUnits);
    // draw the bottom border...
    if ARow = AGrid.RowCount-1 then
      FPreview.Canvas.Line(ARect.Left, ARect.Bottom, ARect.Right, ARect.Bottom, GmUnits);

    AGmRect := TGmValueRect.Create;
    try
      AGmRect.Left.AsUnits  := ARect.Left;
      AGmRect.Top.AsUnits   := ARect.Top;
      AGmRect.Right.AsUnits := ARect.Right;
      AGmRect.Bottom.AsUnits:= ARect.Bottom;
      FPreview.Canvas.Font.Color := clBlack;
      if IsFixedCell(AGrid, ICount, ARow) then
        FPreview.Canvas.Brush.Color := AGrid.FixedColor
      else
        FPreview.Canvas.Brush.Color := AGrid.Color;
      if Assigned(FOnDrawCell) then
        FOnDrawCell(Self, AGrid, ICount, ARow, AGmRect, FPreview.Canvas)
      else
        DefaultDrawCellExt(AGrid, AGmRect, ICount, ARow, FDefaultCellAlign, FDefaultCellVertAlign);
    finally
      AGmRect.Free;
    end;
    Inc(ALeft, ARect.Right-ARect.Left);
  end;
  Inc(ATop, ARect.Bottom-ARect.Top);
end;

procedure TGmGridPrint.GridToPage(X, Y, AWidth: Extended; AUnits: TGmMeasurement;
  AGrid: TDrawGrid);
var
  StartXY : TPoint;
  CurrLeft: integer;
  CurrTop : integer;
  ICount  : integer;
  DesiredWidth: integer;
  LastTop,
  LastLeft: integer;
begin
  // draw the string-grid to the TGmPreview...
  if not Assigned(FPreview) then
  begin
    ShowGmError(Self, NO_PREVIEW_ASSIGNED);
    Exit;
  end;

  FPreview.MessagesEnabled := False;

  StartXY.x := Round(ConvertValue(X, AUnits, GmUnits));
  StartXY.y := Round(ConvertValue(Y, AUnits, GmUnits));

  CurrLeft := StartXY.x;
  CurrTop  := StartXY.y;

  FColWidths.Clear;

  for ICount := 0 to AGrid.ColCount-1 do
    FColWidths.AddColWidth(ICount, Round(ConvertValue(AGrid.ColWidths[ICount], GmPixels, GmUnits)));

  FColWidths.Scale := 1;
  if AWidth <> 0 then
  begin
    DesiredWidth := Round(ConvertValue(AWidth, AUnits, GmUnits));
    FColWidths.Scale := DesiredWidth / FColWidths.TotalWidth;

    for ICount := 0 to FColWidths.Count-1 do
      FColWidths[ICount].Width := Round(FColWidths[ICount].Width * FColWidths.Scale);
  end;

  // draw the grid...
  FPreview.Canvas.Pen.Width := 0;
  for ICount := 0 to AGrid.RowCount-1 do
  begin
    LastTop := CurrTop;
    LastLeft := CurrLeft;
    DrawGridRow(ICount, AGrid, CurrLeft, CurrTop);

    if ICount < (AGrid.RowCount-1) then
    begin
      with FPreview do
      if ((CurrTop + ConvertValue(AGrid.RowHeights[ICount+1], GmPixels, GmUnits)) >
         (PageHeight.AsUnits - FBottomMargin.AsUnits)) then
      begin
        DrawBottomLine(ICount, AGrid, LastLeft, LastTop);
        FPreview.NewPage;
        CurrTop := StartXY.Y;
        FTopMargin.AsUnits := CurrTop;
        if Assigned(FOnGridNewPage) then FOnGridNewPage(Self, FTopMargin, FBottomMargin);

        CurrTop := FTopMargin.AsUnits;
        if (gmFixedRowPerPage in FGridOptions) then
          DrawGridRow(0, AGrid, CurrLeft, CurrTop)
        else
          DrawTopLine(ICount, AGrid, CurrLeft, CurrTop);
      end;
    end;
  end;
  FPreview.MessagesEnabled := True;
  if FPreview.MessagesEnabled then
    FPreview.UpdatePreview;
end;

procedure TGmGridPrint.SetPreview(const Value: TGmPreview);
begin
  FPreview := Value;
end;

end.
