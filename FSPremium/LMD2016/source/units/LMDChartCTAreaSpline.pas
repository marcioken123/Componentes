unit LMDChartCTAreaSpline;
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
LMDChartCTAreaLine unit
-----------------------

Changes
-------
Last (07-June-2006)

###############################################################################}

interface

uses
  Windows, Variants, SysUtils, Types, Math, Graphics, Classes,
  LMDXML, LMDXMLNodeNames, LMDChartData, LMDChartTypes, LMDChartPersistent,
  LMDChartUtils, LMDChartAxis, LMDChartMarker, LMDChartLine, LMDChartLabel;

type
  { ******************* TLMDChartCTAreaSpline ********************************** }
  /// <summary>
  /// An area spline chart displays data with splines
  /// </summary>
  TLMDChartCTAreaSpline = class(TLMDChartCTAbstract)
  private
    FAreaTransparency: byte;
    FAreaLabels: TLMDChartLabel;
    FShowAreaLabels: boolean;
    FLabelsYDeviation: integer;
    FLabelsXDeviation: integer;
    FLabelsMargin: integer;
    FAreaStacked: boolean;
    FXLine: TLMDChartLine;
    FYLine: TLMDChartLine;
    procedure SetAreaLabels(Value: TLMDChartLabel);
    procedure SetAreaTransparency(Value: byte);
    procedure SetLabelsMargin(Value: integer);
    procedure SetLabelsXDeviation(Value: integer);
    procedure SetLabelsYDeviation(Value: integer);
    procedure SetShowAreaLabels(Value: boolean);
    procedure SetAreaStacked(const Value: boolean);
    procedure SetXLine(Value: TLMDChartLine);
    procedure SetYLine(Value: TLMDChartLine);
  protected
    procedure DrawAreaLines(ATarget: TCanvas;
      AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer;
      AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
    procedure DrawAreaLinesStacked(ATarget: TCanvas;
      AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
      AShowMarkers: boolean);
  public
    procedure Assign(ASource: TPersistent); override;
    destructor Destroy; override;
    /// <summary>
    /// Draws object on canvas
    /// </summary>
    procedure Draw(ABuffer: TBitmap; AArea: TRect; AValues: TLMDChartData; AChartAr: TLMDChartPersistent); override;
    constructor Create(AMainOwner: TComponent); override;
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string); override;
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string); override;
    function IsChanged: boolean; override;
    procedure NoChanged; override;
    procedure ResetMainOwner(AmainOwner: TPersistent); override;
  published
    property YLine: TLMDChartLine read FYLine write SetYLine;
    property XLine: TLMDChartLine read FXLine write SetXLine;
    property LabelsXDeviation: integer read FLabelsXDeviation write SetLabelsXDeviation default 0;
    property LabelsYDeviation: integer read FLabelsYDeviation write SetLabelsYDeviation default 0;
    property LabelsMargin: integer read FLabelsMargin write SetLabelsMargin default 4;
    property ShowAreaLabels: boolean read FShowAreaLabels write SetShowAreaLabels default true;
    property AreaLabels: TLMDChartLabel read FAreaLabels write SetAreaLabels;
    property AreaTransparency: byte read FAreaTransparency write SetAreaTransparency default 150;
    property AreaStacked: boolean read FAreaStacked write SetAreaStacked default false;
  end;

implementation
uses
  LMDChartArea;

{ ********************* TLMDChartCTAreaSpline ********************************** }
{ --------------------- private -----------------------------------------------}

procedure TLMDChartCTAreaSpline.SetYLine(Value: TLMDChartLine);
begin
  if Value <> FYLine then
  begin
    FYLine.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline.SetXLine(Value: TLMDChartLine);
begin
  if Value <> FXLine then
  begin
    FXLine.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline.SetAreaLabels(Value: TLMDChartLabel);
begin
  FAreaLabels.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline.SetAreaTransparency(Value: byte);
begin
  FAreaTransparency := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline.SetLabelsMargin(Value: integer);
begin
  FLabelsMargin := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline.SetLabelsXDeviation(Value: integer);
begin
  FLabelsXDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline.SetLabelsYDeviation(Value: integer);
begin
  FLabelsYDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline.SetShowAreaLabels(Value: boolean);
begin
  FShowAreaLabels := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline.SetAreaStacked(const Value: boolean);
begin
  FAreaStacked := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ --------------------- protected ---------------------------------------------}

procedure TLMDChartCTAreaSpline.DrawAreaLines(ATarget: TCanvas;
  AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
  AShowMarkers: boolean);
var
  a, i, j, c, l: integer;
  LAreaPoly: array of TPoint;
  LAreaCardinal: array of TPoint;
  loaddata: variant;
  marker: TLMDChartMarker;
begin
  marker := TLMDChartMarker.Create(self);
  a := AEndX - AStartX;
  SetLength(LAreaPoly, AValues.ColCount + 2);
  if ((AValues.ColCount - 1) > 0) and (AValues.RowCount > 0) then
  begin
    for i := 0 to AValues.RowCount - 1 do
    begin
      AValues.GetRowsLines(i).SetupCanvasPen(ATarget.Pen);
      ATarget.Brush.Color := AValues.GetRowFill(i).SolidColor;
      SetLength(LAreaCardinal, AValues.ColCount);
      for j := 0 to AValues.ColCount - 1 do
      begin
        if AValues.GetTableValue(j, i) = EmptyID then
          loaddata := 0
        else
          loaddata := AValues.GetTableValue(j, i);
        c := Trunc(a * ((1 / (AValues.ColCount - 1)) * j));
        LAreaPoly[j].X := AStartX + c;
        LAreaPoly[j].Y := AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, l);
        LAreaCardinal[j] := LAreaPoly[j];
      end;
      HermitSplineExtArea(ATarget, LAreaCardinal, 50, 0.3, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l));
      if FShowAreaLabels then //draw  columns labels
        for j := 0 to AValues.ColCount - 1 do
        begin
          marker.Size := 5;
          marker.Style := TLMDChartMarkerTypes(i + 2);
          marker.Draw(ATarget, LAreaPoly[j].X + FLabelsMargin, LAreaPoly[j].Y);
          FAreaLabels.Draw(ATarget, AValues.GetRowsNames(i) + ': ' + floattostr(AValues.GetTableValue(j, i)), LAreaPoly[j].X + FLabelsMargin + FLabelsXDeviation + marker.Size + 25,
            LAreaPoly[j].Y + FLabelsYDeviation - round(marker.Size * 1.5), claLeftTop, clcHorizontal);
        end;
    end;
  end;
  marker.Free;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline.DrawAreaLinesStacked(ATarget: TCanvas;
  AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
  AShowMarkers: boolean);
var
  a, i, j, c, l: integer;
  LAreaPoly: array of TPoint;
  LAreaCardinal: array of TPoint;
  LAccomulation: array of real;
  loaddata, tmp: variant;
  marker: TLMDChartMarker;
begin
  marker := TLMDChartMarker.Create(self);
  a := AEndX - AStartX;

  SetLength(LAccomulation, AValues.ColCount);
  for i := 0 to AValues.RowCount - 1 do
  begin
    for j := 0 to AValues.ColCount - 1 do
    begin
      if AValues.GetTableValue(j, i) = EmptyID then
        loaddata := 0
      else
        loaddata := AValues.GetTableValue(j, i);
      LAccomulation[j] := LAccomulation[j] + loaddata;
    end;
  end;

  SetLength(LAreaPoly, AValues.ColCount + 2);
  if ((AValues.ColCount - 1) > 0) and (AValues.RowCount > 0) then
  begin
    for i := 0 to AValues.RowCount - 1 do
    begin
      AValues.GetRowsLines(i).SetupCanvasPen(ATarget.Pen);
      ATarget.Brush.Color := AValues.GetRowFill(i).SolidColor;
      SetLength(LAreaCardinal, AValues.ColCount);
      for j := 0 to AValues.ColCount - 1 do
      begin
        if AValues.GetTableValue(j, i) = EmptyID then
          loaddata := 0
        else
          loaddata := AValues.GetTableValue(j, i);
        c := Trunc(a * ((1 / (AValues.ColCount - 1)) * j));
        LAreaPoly[j].X := AStartX + c;
        LAreaPoly[j].Y := AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation[j], l);

        LAreaPoly[j].Y := AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation[j], l);
        LAreaCardinal[j] := LAreaPoly[j];
        tmp := LAccomulation[j];
        LAccomulation[j] := LAccomulation[j] - loaddata;
      end;
      HermitSplineExtArea(ATarget, LAreaCardinal, 50, 0.3, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l));
      if FShowAreaLabels then //draw  columns labels
        for j := 0 to AValues.ColCount - 1 do
        begin
          marker.Size := 5;
          marker.Style := TLMDChartMarkerTypes(i + 2);
          marker.Draw(ATarget, LAreaPoly[j].X + FLabelsMargin, LAreaPoly[j].Y);
          FAreaLabels.Draw(ATarget, AValues.GetRowsNames(i) + ': ' + floattostr(AValues.GetTableValue(j, i)), LAreaPoly[j].X + FLabelsMargin + FLabelsXDeviation + marker.Size + 25,
            LAreaPoly[j].Y + FLabelsYDeviation - round(marker.Size * 1.5), claLeftTop, clcHorizontal);
        end;
    end;
  end;
  marker.Free;
end;

{ --------------------- public ------------------------------------------------}

function TLMDChartCTAreaSpline.IsChanged: boolean;
begin
  if FAreaLabels.IsChanged then
    FChanged := true;
  if FYLine.IsChanged then
    FChanged := true;
  if FXLine.IsChanged then
    FChanged := true;
  IsChanged := FChanged;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline.NoChanged;
begin
  FChanged := false;
  FAreaLabels.NoChanged;
  FYLine.NoChanged;
  FXLine.NoChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline.ResetMainOwner(AmainOwner: TPersistent);
begin
  FMainOwner := AMainOwner;
  FAreaLabels.ResetOwner(FMainOwner);
  FYLine.ResetOwner(FMainOwner);
  FXLine.ResetOwner(FMainOwner);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNCTAreaSpline + NNSpace + Comment);

  FAreaLabels.LoadStateFromXML(WorkNode, '');

  IterNode := WorkNode.NeedChild('AreaTransparency');
  FAreaTransparency := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ShowAreaLabels');
  FShowAreaLabels := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('LabelsYDeviation');
  FLabelsYDeviation := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('LabelsXDeviation');
  FLabelsXDeviation := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('LabelsMargin');
  FLabelsMargin := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('AreaStacked');
  FAreaStacked := IterNode.GetVarAttr('value', 0);
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  IterNode := BaseNode.AppendElement('ChartType');
  IterNode.SetVarAttr('value', Variant(ChartAreaSplineID));

  WorkNode := BaseNode.EnsureChild(NNCTAreaSpline + NNSpace + Comment);

  FAreaLabels.SaveStateToXML(WorkNode, '');

  IterNode := WorkNode.AppendElement('AreaTransparency');
  IterNode.SetVarAttr('value', FAreaTransparency);

  IterNode := WorkNode.AppendElement('ShowAreaLabels');
  IterNode.SetBoolAttr('value', FShowAreaLabels);

  IterNode := WorkNode.AppendElement('LabelsYDeviation');
  IterNode.SetVarAttr('value', FLabelsYDeviation);

  IterNode := WorkNode.AppendElement('LabelsXDeviation');
  IterNode.SetVarAttr('value', FLabelsXDeviation);

  IterNode := WorkNode.AppendElement('LabelsMargin');
  IterNode.SetVarAttr('value', FLabelsMargin);

  IterNode := WorkNode.AppendElement('AreaStacked');
  IterNode.SetVarAttr('value', FAreaStacked);
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartCTAreaSpline then
  begin
    try
      FAreaLabels.Assign(TLMDChartCTAreaSpline(ASource).FAreaLabels);
      FShowAreaLabels := TLMDChartCTAreaSpline(ASource).FShowAreaLabels;
      AreaTransparency := TLMDChartCTAreaSpline(ASource).FAreaTransparency;
      FLabelsYDeviation := TLMDChartCTAreaSpline(ASource).FLabelsYDeviation;
      FLabelsXDeviation := TLMDChartCTAreaSpline(ASource).FLabelsXDeviation;
      FLabelsMargin := TLMDChartCTAreaSpline(ASource).FLabelsMargin;
      FAreaStacked := TLMDChartCTAreaSpline(ASource).FAreaStacked;
      FYLine := TLMDChartCTAreaSpline(ASource).FYLine;
      FXLine := TLMDChartCTAreaSpline(ASource).FXLine;
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ -----------------------------------------------------------------------------}

destructor TLMDChartCTAreaSpline.Destroy;
begin
  FAreaLabels.Free;
  FYLine.Free;
  FXLine.Free;
  inherited;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline.Draw(ABuffer: TBitmap; AArea: TRect; AValues: TLMDChartData;
  AChartAr: TLMDChartPersistent);
var
  LBottomFld, LRightFld, LLeftFld, LTopFld: integer;
  i, j, LCalculationTempVar, LPositionOnAxis, LErrorBack, LYLabes, LXLabes: integer;
  LXAxisStart, LXAxisEnd: TPoint;
  LYAxisStart, LYAxisEnd: TPoint;
  LCalcZ, LCalcX: real;
  LTickSz: integer;
  LChArea: TLMDChartArea;
  LBlackBuf, LWhiteBuf: TBitmap;
begin
  inherited;
  LChArea := TLMDChartArea(AChartAr);
  if AreaStacked then
    AValues.HighestForStacked := true
  else
    AValues.HighestForStacked := false;
  LChArea.YAxis.AutoScale := LChArea.YAxis.AutoScale;

  LBlackBuf := TBitmap.Create;
  LBlackBuf.Height := AArea.Bottom - AArea.Top - LChArea.MarginTop - LChArea.MarginBottom;
  LBlackBuf.Width := AArea.Right - AArea.Left - LChArea.MarginLeft - LChArea.MarginRight;
  LWhiteBuf := TBitmap.Create;
  LWhiteBuf.Height := AArea.Bottom - AArea.Top - LChArea.MarginTop - LChArea.MarginBottom;
  LWhiteBuf.Width := AArea.Right - AArea.Left - LChArea.MarginLeft - LChArea.MarginRight;
  //column chart========================
  LTopFld := LChArea.InnerIndentTop + LChArea.Edge.Width;
  LLeftFld := LChArea.InnerIndentLeft + LChArea.Edge.Width;
  LRightFld := LChArea.InnerIndentRight + LChArea.Edge.Width;
  LBottomFld := LChArea.InnerIndentBottom + LChArea.Edge.Width;
  //calculate how much pixels ticks take
  LTickSz := 0;
  if (LChArea.YAxis.MajorTick = ttOutside) or (LChArea.YAxis.MajorTick = ttCross) then
    LTickSz := LChArea.YAxis.MajorTickSize;
  if (LChArea.YAxis.MinorTick = ttOutside) or (LChArea.YAxis.MinorTick = ttCross) then
    if LChArea.YAxis.MinorTickSize > LTickSz then
      LTickSz := LChArea.YAxis.MinorTickSize;
  LLeftFld := LLeftFld + LTickSz;
  with ABuffer.Canvas do
  begin
    //without autoscale
    LCalcZ := LChArea.YAxis.MaxValue - LChArea.YAxis.MinValue;
    LCalcX := LCalcZ / LChArea.YAxis.MajorStep; // step count
    Font.Assign(LChArea.YAxis.Font);
    //calc YAxis labels max width
    LCalculationTempVar := TextWidth(floatToStr(LChArea.YAxis.MinValue));
    if LCalcX > 0 then
      for i := 1 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
      begin
        LCalculationTempVar := Max(LCalculationTempVar, TextWidth(floatToStr(LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i)))
      end;
    LCalculationTempVar := LCalculationTempVar + 4;
    LYLabes := LLeftFld - LTickSz;
    LLeftFld := LLeftFld + LCalculationTempVar;
    //calc max heigth XAxis labels
    Font.Assign(LChArea.XAxis.Font);
    LBottomFld := LBottomFld + TextHeight('1') + 15;
    LXlabes := ABuffer.Height - 1 - LBottomFld + 15;
    //calc size of YAxis
    LYAxisStart.Y := LTopFld + 1;
    LYAxisStart.X := LLeftFld + 1;
    LYAxisEnd.Y := ABuffer.Height - 1 - LBottomFld;
    LYAxisEnd.X := LLeftFld + 1;
    //calc size of XAxis
    LXAxisStart.X := LLeftFld + 1;
    LXAxisStart.Y := LYAxisEnd.Y - LChArea.YAxis.CalcPosFromBottom(LYAxisEnd.Y - LYAxisStart.Y, 0, LErrorBack);
    LXAxisEnd.X := ABuffer.Width - 1 - LRightFld;
    LXAxisEnd.Y := LYAxisEnd.Y - LChArea.YAxis.CalcPosFromBottom(LYAxisEnd.Y - LYAxisStart.Y, 0, LErrorBack);
    //draw Y major grid
    LChArea.MajorGridLineHorizontal.SetupCanvasPen(Pen);

    if LChArea.MajorGridHorizontal then
    begin
      if LCalcX > 0 then
        for i := 0 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
        begin
          LPositionOnAxis := LChArea.YAxis.CalcPosFromBottom(LYAxisEnd.Y - LYAxisStart.Y, LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i, LErrorBack);
          DrawLine(LYAxisStart.X + 1, LYAxisEnd.Y - LPositionOnAxis, LXAxisEnd.X, LYAxisEnd.Y - LPositionOnAxis, ABuffer.Canvas);
        end;
    end;

    //draw X major grid
    LChArea.MajorGridLineVertical.SetupCanvasPen(Pen);
    if LChArea.MajorGridVertical then
    begin
      LCalculationTempVar := LXAxisEnd.X - LXAxisStart.X;
      if AValues.ColCount > 1 then
      begin
        for i := 0 to AValues.ColCount - 1 do
        begin
          LPositionOnAxis := Trunc(LCalculationTempVar * ((1 / (AValues.ColCount - 1)) * i));
          DrawLine(LXAxisStart.X + LPositionOnAxis, LYAxisEnd.Y, LXAxisStart.X + LPositionOnAxis, LYAxisStart.Y, ABuffer.Canvas);
        end;
      end;
    end;
    //draw YAxis--------------
    Font.Assign(LChArea.YAxis.Font);
    //draw YAxis  major labels and ticks
    Brush.Style := bsClear;
    if LCalcX > 0 then
      for i := 0 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
      begin
        LPositionOnAxis := LChArea.YAxis.CalcPosFromBottom(LYAxisEnd.Y - LYAxisStart.Y, LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i, LErrorBack);
        DrawYTick(ABuffer.Canvas, LYAxisStart.X, LYAxisEnd.Y - LPositionOnAxis, LChArea.YAxis.MajorTickSize, LChArea.YAxis.MajorTick, FYLine);
        TextOut(LYLabes - 15, (LYAxisEnd.Y - LPositionOnAxis) - TextHeight(floattostr(LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i)) div 2, floattostr(LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i) + AValues.ValIndicator);
      end;
    FYLine.SetupCanvasPen(Pen);
    DrawLine(LYAxisStart.X, LYAxisStart.Y, LYAxisEnd.X, LYAxisEnd.Y, ABuffer.Canvas);
  end;
  LWhiteBuf.Canvas.Brush.Color := clWhite;
  LWhiteBuf.Canvas.Pen.Style := psClear;
  LWhiteBuf.Canvas.FillRect(LWhiteBuf.Canvas.ClipRect);
  LBlackBuf.Canvas.Brush.Color := clBlack;
  LBlackBuf.Canvas.Pen.Style := psClear;
  LBlackBuf.Canvas.FillRect(LBlackBuf.Canvas.ClipRect);

  if FAreaStacked then
  begin
    DrawAreaLinesStacked(LWhiteBuf.Canvas, AValues, LXAxisStart.X, LXAxisend.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
    DrawAreaLinesStacked(LBlackBuf.Canvas, AValues, LXAxisStart.X, LXAxisend.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
  end
  else
  begin
    DrawAreaLines(LWhiteBuf.Canvas, AValues, LXAxisStart.X, LXAxisend.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
    DrawAreaLines(LBlackBuf.Canvas, AValues, LXAxisStart.X, LXAxisend.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
  end;

  DrawTransparency(ABuffer, LWhiteBuf, LBlackBuf, LChArea.Shadow, LChArea.ShadowColor, LChArea.ShadowDepth, LChArea.ShadowTransparency, FAreaTransparency);

  //draw XAxis--------------
  with ABuffer.Canvas do
  begin
    Font.Assign(LChArea.XAxis.Font);
    FXLine.SetupCanvasPen(Pen);
    DrawLine(LXAxisStart.X, LXAxisStart.Y, LXAxisEnd.X, LXAxisEnd.Y, ABuffer.Canvas);
    // length of x axis
    LCalculationTempVar := LXAxisEnd.X - LXAxisStart.X;
    //draw all ticks and labels
    brush.Style := bsClear;
    if (AValues.ColCount - 1) > 0 then
    begin
      //major ticks
      for i := 0 to AValues.ColCount - 1 do
      begin
        LPositionOnAxis := Trunc(LCalculationTempVar * ((1 / (AValues.ColCount - 1)) * i));
        DrawXTick(ABuffer.Canvas, LXAxisStart.X + LPositionOnAxis, LXAxisStart.Y, LChArea.XAxis.MajorTickSize, LChArea.XAxis.MajorTick, FXLine);
      end;
      j := 1;
      for i := 0 to AValues.ColCount - 1 do
      begin
        LPositionOnAxis := Trunc(LCalculationTempVar * ((1 / (AValues.ColCount - 1)) * i));

        if AValues.GetColumnsNames(j - 1) = '' then
          TextOut(LXAxisStart.X + LPositionOnAxis - TextWidth(IntToStr(j)) div 2, LXLabes, IntToStr(j))
        else
          TextOut(LXAxisStart.X + LPositionOnAxis - TextWidth(AValues.GetColumnsNames(j - 1)) div 2, LXLabes, AValues.GetColumnsNames(j - 1));
        j := j + 1;
      end;
    end;
  end;
  LWhiteBuf.Free;
  LBlackBuf.Free;
end;

{ -----------------------------------------------------------------------------}

constructor TLMDChartCTAreaSpline.Create(AMainOwner: TComponent);
begin
  inherited Create(AMainOwner);
  FAreaLabels := TLMDChartLabel.Create(AMainOwner);
  FYLine := TLMDChartLine.Create(AMainOwner);
  FXLine := TLMDChartLine.Create(AMainOwner);
  //default
  FShowAreaLabels := true;
  FAreaTransparency := 150;
  FLabelsMargin := 4;
  FLabelsYDeviation := 0;
  FLabelsXDeviation := 0;
  FAreaStacked := false;

end;

end.
