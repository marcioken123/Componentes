unit wwpaintoptions;
{
//
// Description : Painting Options for Multi-Record Controls
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
}

interface

uses Messages, Windows, SysUtils, Classes, Graphics, Menus, Controls, Forms,
  StdCtrls, wwbitmap, grids, typinfo;

type
  TwwBackgroundOption = (
     coFillDataCells,
     coBlendFixedRow, coBlendFixedColumn,
     coBlendActiveRecord, coBlendAlternatingRow);
  TwwBackgroundOptions = set of TwwBackGroundOption;
  TwwBackgroundDrawStyle = (bdsTile, bdsStretch, bdsTopLeft, bdsCenter);
  TwwAlternatingRowRegion = (arrFixedColumns, arrDataColumns, arrActiveDataColumn);
  TwwAlternatingRowRegions = Set of TwwAlternatingRowRegion;

  TwwGridPaintOptions = class(TPersistent)
  private
     //FAlternateRowCaptionColors: boolean;
   //  FAlternateRowDataColors: boolean;
     FAlternatingRowColor: TColor;
     FActiveRecordColor: TColor;
     FBackgroundOptions: TwwBackgroundOptions;
     FBackgroundBitmap: TPicture;
     FBackgroundDrawStyle: TwwBackgroundDrawStyle;
     FAlternatingRowRegions: TwwAlternatingRowRegions;
     FFastRecordScrolling: boolean;
//     FActiveRecord3DLines: boolean;

//     FPaintCanvas: TCanvas;
     procedure PictureChanged(Sender: TObject);
  protected
     procedure SetAlternatingRowRegions(val: TwwAlternatingRowRegions); virtual;
     procedure SetAlternatingRowColor(Value: TColor); virtual;
     procedure SetActiveRecordColor(Value: TColor); virtual;
     procedure SetBackgroundOptions(Value: TwwBackgroundOptions); virtual;
     procedure SetBackgroundDrawStyle(Value: TwwBackgroundDrawStyle); virtual;
     procedure SetBackgroundBitmap(Value: TPicture); virtual;
     function GetCanvas: TCanvas; virtual;
  public
     Grid: TCustomGrid;
     InitBlendBitmapsFlag: boolean;
     Column1Color, Row1Color: TColor;

     FPaintBitmap: TBitmap;
     OrigBitmap: TBitmap;
     AlternatingColorBitmap, ActiveRecordBitmap,
     Column1Bitmap: TwwBitmap;
     Row1Bitmap: TwwBitmap;
     constructor Create(Owner: TComponent; APaintBitmap: TBitmap);
     destructor Destroy; override;
     procedure InitBlendBitmaps({Canvas: TCanvas; }ForceInit: boolean = False);
     property Canvas: TCanvas read GetCanvas;
     function HaveBackgroundForDataCells: boolean; virtual;

  published
     property BackgroundBitmap: TPicture read FBackgroundBitmap write SetBackgroundBitmap;
     property BackgroundDrawStyle: TwwBackgroundDrawStyle read FBackgroundDrawStyle write SetBackgroundDrawStyle default bdsTile;
     property AlternatingRowRegions: TwwAlternatingRowRegions read FAlternatingRowRegions write SetAlternatingRowRegions  default [arrFixedColumns, arrDataColumns, arrActiveDataColumn];
     property FastRecordScrolling: boolean read FFastRecordScrolling write FFastRecordScrolling default True;
     property AlternatingRowColor: TColor read FAlternatingRowColor write SetAlternatingRowColor default clNone;
     property ActiveRecordColor: TColor read FActiveRecordColor write SetActiveRecordColor default clNone;
     property BackgroundOptions: TwwBackgroundOptions read FBackgroundOptions write SetBackgroundOptions default [];
//     property ActiveRecord3DLines: boolean read FActiveRecord3DLines write FActiveRecord3DLines default false;
  end;


implementation

constructor TwwGridPaintOptions.Create(Owner: TComponent; APaintBitmap: TBitmap);
begin
  Grid:= Owner as TCustomGrid;
  FAlternatingRowColor:=clNone;
  FActiveRecordColor:= clNone;
  FBackgroundBitmap:= TPicture.create;
  FBackgroundBitmap.OnChange := PictureChanged;
  FAlternatingRowRegions:= [arrFixedColumns, arrDataColumns, arrActiveDataColumn];
  FFastRecordScrolling:=True;
  FPaintBitmap:= APaintBitmap;
  FBackgroundDrawStyle:= bdsTile;
end;

procedure TwwGridPaintOptions.SetAlternatingRowColor(Value: TColor);
begin
   if Value<>AlternatingRowColor then
   begin
      FAlternatingRowColor:= Value;
      InitBlendBitmapsFlag:=True;
      Grid.Invalidate;
   end
end;

procedure TwwGridPaintOptions.SetBackgroundDrawStyle(Value: TwwBackgroundDrawStyle);
begin
   if Value<>FBackgroundDrawStyle then
   begin
      FBackgroundDrawStyle:= Value;
      InitBlendBitmapsFlag:=True;
      Grid.Invalidate;
   end
end;

procedure TwwGridPaintOptions.SetActiveRecordColor(Value: TColor);
begin
   if Value<>ActiveRecordColor then
   begin
      FActiveRecordColor:= Value;
      InitBlendBitmapsFlag:=True;
      Grid.Invalidate;
   end
end;

//procedure TwwInspectorPaintOptions.SetBackgroundBitmap(Value: TBitmap);
procedure TwwGridPaintOptions.SetBackgroundBitmap(Value: TPicture);
begin
   FBackgroundBitmap.assign(Value);
   if Grid<>nil then
   begin
      InitBlendBitmapsFlag:=True;
      Grid.Invalidate;
   end
end;

procedure TwwGridPaintOptions.SetBackgroundOptions(Value: TwwBackgroundOptions);
begin
  if FBackgroundOptions <> Value then
  begin
    FBackgroundOptions := Value;
    if Grid<>nil then
    begin
       InitBlendBitmapsFlag:=True;
       Grid.Invalidate;
    end
  end;
end;

procedure TwwGridPaintOptions.PictureChanged(Sender: TObject);
begin
end;

procedure TwwGridPaintOptions.SetAlternatingRowRegions(val: TwwAlternatingRowRegions);
begin
   if FAlternatingRowRegions <> val then
   begin
      FAlternatingRowRegions:= val;
      Grid.invalidate;
   end
end;

destructor TwwGridPaintOptions.Destroy;
begin
   FBackgroundBitmap.Free;
   FBackgroundBitmap:=nil;

   OrigBitmap.Free;
   OrigBitmap:= nil;

   AlternatingColorBitmap.Free;
   AlternatingColorBitmap:= nil;
   Column1Bitmap.Free;
   Column1Bitmap:= nil;
   Row1Bitmap.Free;
   Row1Bitmap:= nil;
   ActiveRecordBitmap.Free;
   ActiveRecordBitmap:=nil;

   inherited;
end;

procedure CalcFixedInfo(Grid: TCustomGrid; var DrawInfo: TGridDrawInfo);

  procedure CalcFixedAxis(var Axis: TGridAxisDrawInfo; LineOptions: TGridOptions;
    FixedCount, FirstCell, CellCount: Integer{; GetExtentFunc: TGetExtentsFunc});
  var
    I: Integer;
  begin
    with Axis do
    begin
      if LineOptions * TDrawGrid(Grid).Options = [] then
        EffectiveLineWidth := 0
      else
        EffectiveLineWidth := TDrawGrid(Grid).GridLineWidth;

      FixedBoundary := 0;
      for I := 0 to FixedCount - 1 do
        Inc(FixedBoundary, TDrawGrid(Grid).ColWidths[i]{GetExtentFunc(I) }+ EffectiveLineWidth);

      FixedCellCount := FixedCount;
      FirstGridCell := FirstCell;
      GridCellCount := CellCount;
//      GetExtent := GetExtentFunc;
    end;
  end;

begin
  CalcFixedAxis(DrawInfo.Horz, [goFixedVertLine, goVertLine], TDrawGrid(Grid).FixedCols,
    TDrawGrid(Grid).LeftCol, TDrawGrid(Grid).ColCount{, GetColWidths});
  CalcFixedAxis(DrawInfo.Vert, [goFixedHorzLine, goHorzLine], TDrawGrid(Grid).FixedRows,
    TDrawGrid(Grid).TopRow, TDrawGrid(Grid).RowCount{, GetColWidths});
//    TopRow, RowCount, GetRowHeights);
end;

procedure CalcDrawInfoXY(Grid: TCustomGrid; var DrawInfo: TGridDrawInfo;
  UseWidth, UseHeight: Integer);

  procedure CalcAxis(var AxisInfo: TGridAxisDrawInfo; UseExtent: Integer);
  var
    I: Integer;
  begin
    with AxisInfo do
    begin
      GridExtent := UseExtent;
      GridBoundary := FixedBoundary;
      FullVisBoundary := FixedBoundary;
      LastFullVisibleCell := FirstGridCell;
      for I := FirstGridCell to GridCellCount - 1 do
      begin
        Inc(GridBoundary, TDrawGrid(Grid).ColWidths[i] + EffectiveLineWidth);
        if GridBoundary > GridExtent + EffectiveLineWidth then
        begin
          GridBoundary := GridExtent;
          Break;
        end;
        LastFullVisibleCell := I;
        FullVisBoundary := GridBoundary;
      end;
    end;
  end;

begin
  with grid do
  begin
    CalcFixedInfo(Grid, DrawInfo);
    CalcAxis(DrawInfo.Horz, UseWidth);
    CalcAxis(DrawInfo.Vert, UseHeight);
  end
end;

{Function wwGetOnBeforePaint(Control: TWinControl): TNotifyEvent;
var PropInfo: PPropInfo;
    method: TMethod;
begin
   Result:= Nil;
   PropInfo:= Typinfo.GetPropInfo(Control.ClassInfo,'OnBeforePaint');
   if PropInfo<>Nil then begin
      method:= GetMethodProp(Control, PropInfo);
      if method.code<>Nil then
         result:= TNotifyEvent(method);
   end
end;
}
procedure TwwGridPaintOptions.InitBlendBitmaps({Canvas: TCanvas; }ForceInit: boolean = False);
var ARect: TRect;
    NewboundsRect: TRect;
    DrawInfo: TGridDrawInfo;
    HaveBackgroundBitmap: boolean;
    i,j: integer;
    MemDC: HDC;
//    PaintEvent: TNotifyEvent;
begin
   if (not ForceInit) and (not InitBlendBitmapsFlag) then exit;

   with Grid do begin
   NewboundsRect:= Rect(0, 0, BoundsRect.right-BoundsRect.left, BoundsRect.bottom-BoundsRect.top);

   CalcDrawInfoXY(Grid, DrawInfo, ClientWidth, ClientHeight);
   try
      FPaintBitmap.Width := NewBoundsRect.right;
      FPaintBitmap.Height:= NewBoundsRect.Bottom;

      Canvas.Brush.Color:= clWhite;
      Canvas.FillRect(newBoundsRect);

      if not (BackgroundBitmap.Width=0) then
      begin
         HaveBackgroundBitmap:=True;
         case BackgroundDrawStyle of
           bdsTile:
             begin
                with BackgroundBitmap do begin
                   for i := 0 to (Grid.Width div Width) do
                     for j := 0 to (Grid.Height div Height) do
                       Canvas.Draw(i*Width, j*Height,Graphic);
                end
             end;
           bdsTopLeft:
             begin
                with BackgroundBitmap do
                   Canvas.Draw(0, 0, Graphic);
             end;
           bdsCenter:
             begin
                with BackgroundBitmap do
                   Canvas.Draw((grid.width-Width)div 2,
                               (grid.Height-Height) div 2, Graphic);
             end;
           bdsStretch:
             begin
                with BackgroundBitmap do
                   Canvas.StretchDraw(Rect(0, 0, newBoundsRect.right, NewBoundsRect.bottom), Graphic);
             end;
         end;
      end
      else begin
{         PaintEvent:= wwGetOnBeforePaint(Grid);
         if Assigned(PaintEvent) then
         begin
            PaintEvent(Grid);
            HaveBackgroundBitmap:= True;
         end
         else}
            HaveBackgroundBitmap:=False;
      end;
{      begin
         wwGetOnBeforePaint(self);
         FOnBeforePaint(self);
      end
      else else HaveBackgroundBitmap:=False;
}
      // If 256 colors or less then no blending
      MemDC := GetDC(0);
      try
        if GetDeviceCaps(MemDC, BITSPIXEL)<=8 then exit;
      finally
        ReleaseDC(0, MemDC);
      end;

      if HaveBackgroundBitmap then
      begin
        if (OrigBitmap=nil) then
           OrigBitmap := TBitmap.Create;
        ARect:= NewBoundsRect;
        OrigBitmap.Assign(FPaintBitmap);
      end
      else begin
         OrigBitmap.Free;
         OrigBitmap:= nil;
      end;

      if (ActiveRecordColor<>clNone) and
         HaveBackgroundBitmap and (coBlendActiveRecord in BackgroundOptions) then
      begin
         if ActiveRecordBitmap = nil then
            ActiveRecordBitmap := TwwBitmap.Create;
         ARect:= newBoundsRect;//ClientRect;
         ActiveRecordBitmap.SetSize(ARect.Right, ARect.Bottom);
         ActiveRecordBitmap.canvas.CopyRect(ARect, Canvas, ARect);
         with wwGetColor(ColorToRGB(ActiveRecordColor)) do
            ActiveRecordBitmap.Colorize(r,g,b);
      end
      else begin
         ActiveRecordBitmap.Free;
         ActiveRecordBitmap:= nil;
      end;

      if (AlternatingRowColor<>clNone) and
         (AlternatingRowRegions<>[]) and
         HaveBackgroundBitmap and (coBlendAlternatingRow in BackgroundOptions) then
      begin
         if AlternatingColorBitmap = nil then
            AlternatingColorBitmap := TwwBitmap.Create;

         ARect:= NewBoundsRect;
         AlternatingColorBitmap.SetSize(ARect.Right, ARect.Bottom);
         AlternatingColorBitmap.canvas.CopyRect(ARect, Canvas, ARect);

         with wwGetColor(ColorToRGB(AlternatingRowColor)) do
            AlternatingColorBitmap.Colorize(r,g,b);
      end
      else begin
         AlternatingColorBitmap.Free;
         AlternatingColorBitmap:= nil;
      end;

      if {IndicatorRow.enabled and}
         HaveBackgroundBitmap and (coBlendFixedRow in BackgroundOptions) then
      begin
        if Row1Bitmap=nil then
           Row1Bitmap:= TwwBitmap.create;
//        ARect:= TDrawGrid(Grid).CellRect(0,0);
        ARect.Left:= 0;
        ARect.Right:= NewBoundsRect.Right;
        ARect.Top:= 0;
        ARect.Bottom:= TDrawGrid(Grid).RowHeights[0];

        Row1Bitmap.SetSize(ARect.Right, ARect.Bottom);
        Row1Bitmap.Canvas.CopyRect(ARect, Canvas, ARect);

        with wwGetColor(ColorToRGB(Row1Color)) do
           Row1Bitmap.Colorize(r,g,b);
      end;
{      else begin
         IndicatorRowBitmap.Free;
         IndicatorRowBitmap:= nil;
      end;
}
      if HaveBackgroundBitmap and (coBlendFixedColumn in BackgroundOptions) then
      begin
        if Column1Bitmap=nil then
           Column1Bitmap:= TwwBitmap.create;
//        ARect:= CellRect(0,0);
//        ARect.Bottom:= NewBoundsRect.bottom;
//        if ovFillNonCellArea in Options then ARect:= NewBoundsRect;
        ARect:= NewBoundsRect;

        Column1Bitmap.SetSize(ARect.Right, ARect.Bottom);
        Column1Bitmap.Canvas.CopyRect(ARect, Canvas, ARect);

        if (TDrawGrid(Grid).FixedColor<>clNone) then
        begin
           with wwGetColor(ColorToRGB(Column1Color)) do
              Column1Bitmap.Colorize(r,g,b);
//          with wwGetColor(ColorToRGB(TDrawGrid(Grid).FixedColor)) do
//             Column1Bitmap.Colorize(r,g,b);
        end
      end
      else begin
         Column1Bitmap.Free;
         Column1Bitmap:= nil;
      end;
   finally
//      UseTempCanvas:= False;
      InitBlendBitmapsFlag:= False;
   end
   end
end;

function TwwGridPaintOptions.GetCanvas: TCanvas;
begin
   result:= FPaintBitmap.Canvas;
end;

function TwwGridPaintOptions.HaveBackgroundForDataCells: boolean;
begin
   result:= (OrigBitmap<>nil) and (coFillDataCells in BackgroundOptions)
end;

end.
