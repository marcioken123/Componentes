unit LMDChartRectangular2DCT;
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
LMDChartRectangular2DCT unit
-----------------------
Defines the base class for all the rectangular (Decart) 2D chart types

Changes
-------
Created 16 November 2007 (RS)

###############################################################################}

interface

uses
  Windows, Variants, SysUtils, Types, Math, Graphics, Classes,
  LMDXML, LMDXMLNodeNames, LMDChartData, LMDChartArea, LMDChartTypes, LMDChartPersistent,
  LMDChartUtils, LMDChartAxis, LMDChartMarker, LMDChartLine, LMDChartLabel;

type
  { ******************* TLMDChartRectangular2DCT ********************************** }
  /// <summary>
  /// The base class for all the rectangular (Decart) 2D chart types
  /// </summary>
  TLMDChartPoints = array of TPoint;
  TLMDChartRectangular2DCT = class(TLMDChartCTAbstract)
  protected
    FElementsTransparency: byte;
    FLabels: TLMDChartLabel;
    FShowLabels: boolean;
    FLabelsYDeviation: integer;
    FLabelsXDeviation: integer;
    FLabelsMargin: integer;
    FXLine: TLMDChartLine;
    FYLine: TLMDChartLine;

    FChartArea: TLMDChartArea;

    procedure SetLabels(Value: TLMDChartLabel);
    procedure SetElementsTransparency(Value: byte);
    procedure SetLabelsMargin(Value: integer);
    procedure SetLabelsXDeviation(Value: integer);
    procedure SetLabelsYDeviation(Value: integer);
    procedure SetShowLabels(Value: boolean);
    procedure SetXLine(Value: TLMDChartLine);
    procedure SetYLine(Value: TLMDChartLine);

    procedure DrawChart(ATarget: TCanvas;
      AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer;
      AYAxis: TLMDChartYAxis; AShowMarkers: boolean); virtual;
    function GenerateBasicElementsPoints(AValues: TLMDChartData; ASeriesIndex: integer; AStartX, AEndX, AStartY, AEndY: integer;
      AYAxis: TLMDChartYAxis): TLMDChartPoints; virtual;
    procedure DrawChartMarkers(ATarget: TCanvas;
      AValues: TLMDChartData; ASeriesIndex: integer; AElementsPoints: TLMDChartPoints); virtual;
    procedure DrawChartElements(ATarget: TCanvas;
      AValues: TLMDChartData; ASeriesIndex: integer; AElementsPoints: TLMDChartPoints;
        AStartX, AEndX, AStartY, AEndY: integer); virtual; abstract;        

  public
    procedure Assign(ASource: TPersistent); override;
    destructor Destroy; override;
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
    property ShowLabels: boolean read FShowLabels write SetShowLabels default true;
    property Labels: TLMDChartLabel read FLabels write SetLabels;
    property ElementsTransparency: byte read FElementsTransparency write SetElementsTransparency default 150;
  end;

implementation

{ ********************* TLMDChartRectangular2DCT ********************************** }
{ --------------------- private -----------------------------------------------}

procedure TLMDChartRectangular2DCT.SetYLine(Value: TLMDChartLine);
begin
  if Value <> FYLine then
  begin
    FYLine.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartRectangular2DCT.SetXLine(Value: TLMDChartLine);
begin
  if Value <> FXLine then
  begin
    FXLine.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartRectangular2DCT.SetLabels(Value: TLMDChartLabel);
begin
  FLabels.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartRectangular2DCT.SetElementsTransparency(Value: byte);
begin
  FElementsTransparency := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartRectangular2DCT.SetLabelsMargin(Value: integer);
begin
  FLabelsMargin := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartRectangular2DCT.SetLabelsXDeviation(Value: integer);
begin
  FLabelsXDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartRectangular2DCT.SetLabelsYDeviation(Value: integer);
begin
  FLabelsYDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartRectangular2DCT.SetShowLabels(Value: boolean);
begin
  FShowLabels := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ --------------------- protected ---------------------------------------------}

function TLMDChartRectangular2DCT.IsChanged: boolean;
begin
  if FLabels.IsChanged then
    FChanged := true;
  if FYLine.IsChanged then
    FChanged := true;
  if FXLine.IsChanged then
    FChanged := true;
  IsChanged := FChanged;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartRectangular2DCT.NoChanged;
begin
  FChanged := false;
  FLabels.NoChanged;
  FYLine.NoChanged;
  FXLine.NoChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartRectangular2DCT.ResetMainOwner(AmainOwner: TPersistent);
begin
  FMainOwner := AMainOwner;
  FLabels.ResetOwner(FMainOwner);
  FYLine.ResetOwner(FMainOwner);
  FXLine.ResetOwner(FMainOwner);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartRectangular2DCT.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNCTAreaLine + NNSpace + Comment);

  FLabels.LoadStateFromXML(WorkNode, '');

  IterNode := WorkNode.NeedChild('ElementsTransparency');
  FElementsTransparency := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ShowLabels');
  FShowLabels := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('LabelsYDeviation');
  FLabelsYDeviation := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('LabelsXDeviation');
  FLabelsXDeviation := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('LabelsMargin');
  FLabelsMargin := IterNode.GetVarAttr('value', 0);
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartRectangular2DCT.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  IterNode := BaseNode.AppendElement('ChartType');
  IterNode.SetVarAttr('value', Variant(ChartAreaLineID));

  WorkNode := BaseNode.EnsureChild(NNCTAreaLine + NNSpace + Comment);

  FLabels.SaveStateToXML(WorkNode, '');

  IterNode := WorkNode.AppendElement('ElementsTransparency');
  IterNode.SetVarAttr('value', FElementsTransparency);

  IterNode := WorkNode.AppendElement('ShowLabels');
  IterNode.SetBoolAttr('value', FShowLabels);

  IterNode := WorkNode.AppendElement('LabelsYDeviation');
  IterNode.SetVarAttr('value', FLabelsYDeviation);

  IterNode := WorkNode.AppendElement('LabelsXDeviation');
  IterNode.SetVarAttr('value', FLabelsXDeviation);

  IterNode := WorkNode.AppendElement('LabelsMargin');
  IterNode.SetVarAttr('value', FLabelsMargin);
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartRectangular2DCT.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartRectangular2DCT then
  begin
    try
      FLabels.Assign(TLMDChartRectangular2DCT(ASource).FLabels);
      FShowLabels := TLMDChartRectangular2DCT(ASource).FShowLabels;
      ElementsTransparency := TLMDChartRectangular2DCT(ASource).FElementsTransparency;
      FLabelsYDeviation := TLMDChartRectangular2DCT(ASource).FLabelsYDeviation;
      FLabelsXDeviation := TLMDChartRectangular2DCT(ASource).FLabelsXDeviation;
      FLabelsMargin := TLMDChartRectangular2DCT(ASource).FLabelsMargin;
      FYLine := TLMDChartRectangular2DCT(ASource).FYLine;
      FXLine := TLMDChartRectangular2DCT(ASource).FXLine;
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ -----------------------------------------------------------------------------}

destructor TLMDChartRectangular2DCT.Destroy;
begin
  FLabels.Free;
  FYLine.Free;
  FXLine.Free;
  inherited;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartRectangular2DCT.Draw(ABuffer: TBitmap; AArea: TRect; AValues: TLMDChartData;
  AChartAr: TLMDChartPersistent);
var
  LBottomFld, LRightFld, LLeftFld, LTopFld: integer;
  i, j, LCalculationTempVar, LPositionOnAxis, LErrorBack, LYLabels, LXLabels: integer;
  LXAxisStart, LXAxisEnd: TPoint;
  LYAxisStart, LYAxisEnd: TPoint;
  LCalcZ, LCalcX: real;
  LTickSz: integer;
  LBlackBuf, LWhiteBuf: TBitmap;
begin
  inherited;
  FChartArea := TLMDChartArea(AChartAr);

  FChartArea.YAxis.AutoScale := FChartArea.YAxis.AutoScale;

  LBlackBuf := TBitmap.Create;
  LBlackBuf.Height := AArea.Bottom - AArea.Top - FChartArea.MarginTop - FChartArea.MarginBottom;
  LBlackBuf.Width := AArea.Right - AArea.Left - FChartArea.MarginLeft - FChartArea.MarginRight;
  LWhiteBuf := TBitmap.Create;
  LWhiteBuf.Height := AArea.Bottom - AArea.Top - FChartArea.MarginTop - FChartArea.MarginBottom;
  LWhiteBuf.Width := AArea.Right - AArea.Left - FChartArea.MarginLeft - FChartArea.MarginRight;
  //column chart========================

  LTopFld := FChartArea.InnerIndentTop + FChartArea.Edge.Width;
  LLeftFld := FChartArea.InnerIndentLeft + FChartArea.Edge.Width;
  LRightFld := FChartArea.InnerIndentRight + FChartArea.Edge.Width;
  LBottomFld := FChartArea.InnerIndentBottom + FChartArea.Edge.Width;
  //calculate how much pixels ticks take
  LTickSz := 0;
  if (FChartArea.YAxis.MajorTick = ttOutside) or (FChartArea.YAxis.MajorTick = ttCross) then
    LTickSz := FChartArea.YAxis.MajorTickSize;
  if (FChartArea.YAxis.MinorTick = ttOutside) or (FChartArea.YAxis.MinorTick = ttCross) then
    if FChartArea.YAxis.MinorTickSize > LTickSz then
      LTickSz := FChartArea.YAxis.MinorTickSize;
  LLeftFld := LLeftFld + LTickSz;
  with ABuffer.Canvas do
  begin
    //without autoscale
    LCalcZ := FChartArea.YAxis.MaxValue - FChartArea.YAxis.MinValue;
    LCalcX := LCalcZ / FChartArea.YAxis.MajorStep; // step count
    Font.Assign(FChartArea.YAxis.Font);
    //calc YAxis labels max width
    LCalculationTempVar := TextWidth(floatToStr(FChartArea.YAxis.MinValue));
    if LCalcX > 0 then
      for i := 1 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
      begin
        LCalculationTempVar := Max(LCalculationTempVar, TextWidth(floatToStr(FChartArea.YAxis.MinValue + FChartArea.YAxis.MajorStep * i)))
      end;
    LCalculationTempVar := LCalculationTempVar + 4;
    LYLabels := LLeftFld - LTickSz;
    LLeftFld := LLeftFld + LCalculationTempVar;
    //calc max heigth XAxis labels
    Font.Assign(FChartArea.XAxis.Font);
    LBottomFld := LBottomFld + TextHeight('1') + 15;
    LXLabels := ABuffer.Height - 1 - LBottomFld + 15;
    //calc size of YAxis
    LYAxisStart.Y := LTopFld + 1;
    LYAxisStart.X := LLeftFld + 1;
    LYAxisEnd.Y := ABuffer.Height - 1 - LBottomFld;
    LYAxisEnd.X := LLeftFld + 1;
    //calc size of XAxis
    LXAxisStart.X := LLeftFld + 1;
    LXAxisStart.Y := LYAxisEnd.Y - FChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.Y - LYAxisStart.Y, 0, LErrorBack);
    LXAxisEnd.X := ABuffer.Width - 1 - LRightFld;
    LXAxisEnd.Y := LYAxisEnd.Y - FChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.Y - LYAxisStart.Y, 0, LErrorBack);
    //draw Y major grid
    FChartArea.MajorGridLineHorizontal.SetupCanvasPen(Pen);

    if FChartArea.MajorGridHorizontal then
    begin
      if LCalcX > 0 then
        for i := 0 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
        begin
          LPositionOnAxis := FChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.Y - LYAxisStart.Y, FChartArea.YAxis.MinValue + FChartArea.YAxis.MajorStep * i, LErrorBack);
          DrawLine(LYAxisStart.X + 1, LYAxisEnd.Y - LPositionOnAxis, LXAxisEnd.X, LYAxisEnd.Y - LPositionOnAxis, ABuffer.Canvas);
        end;
    end;

    //draw X major grid
    FChartArea.MajorGridLineVertical.SetupCanvasPen(Pen);
    if FChartArea.MajorGridVertical then
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
    Font.Assign(FChartArea.YAxis.Font);
    //draw YAxis  major labels and ticks
    Brush.Style := bsClear;
    if LCalcX > 0 then
      for i := 0 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
      begin
        LPositionOnAxis := FChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.Y - LYAxisStart.Y, FChartArea.YAxis.MinValue + FChartArea.YAxis.MajorStep * i, LErrorBack);
        DrawYTick(ABuffer.Canvas, LYAxisStart.X, LYAxisEnd.Y - LPositionOnAxis, FChartArea.YAxis.MajorTickSize, FChartArea.YAxis.MajorTick, FYLine);
        TextOut(LYLabels - 15, (LYAxisEnd.Y - LPositionOnAxis) - TextHeight(floattostr(FChartArea.YAxis.MinValue + FChartArea.YAxis.MajorStep * i)) div 2, floattostr(FChartArea.YAxis.MinValue + FChartArea.YAxis.MajorStep * i) + AValues.ValIndicator);
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

  //Drawing the chart itself
  Self.DrawChart(LWhiteBuf.Canvas, AValues, LXAxisStart.X, LXAxisend.X, LYAxisStart.Y, LYAxisEnd.Y, FChartArea.YAxis, FChartArea.ShowMarkers);
  Self.DrawChart(LBlackBuf.Canvas, AValues, LXAxisStart.X, LXAxisend.X, LYAxisStart.Y, LYAxisEnd.Y, FChartArea.YAxis, FChartArea.ShowMarkers);

  //Drawing possibly transparent bakground
  DrawTransparency(ABuffer, LWhiteBuf, LBlackBuf, FChartArea.Shadow, FChartArea.ShadowColor, FChartArea.ShadowDepth, FChartArea.ShadowTransparency, FElementsTransparency);

  //draw XAxis--------------
  with ABuffer.Canvas do
  begin
    Font.Assign(FChartArea.XAxis.Font);
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
        DrawXTick(ABuffer.Canvas, LXAxisStart.X + LPositionOnAxis, LXAxisStart.Y, FChartArea.XAxis.MajorTickSize, FChartArea.XAxis.MajorTick, FXLine);
      end;
      j := 1;
      for i := 0 to AValues.ColCount - 1 do
      begin
        LPositionOnAxis := Trunc(LCalculationTempVar * ((1 / (AValues.ColCount - 1)) * i));

        if AValues.GetColumnsNames(j - 1) = '' then
          TextOut(LXAxisStart.X + LPositionOnAxis - TextWidth(IntToStr(j)) div 2, LXLabels, IntToStr(j))
        else
          TextOut(LXAxisStart.X + LPositionOnAxis - TextWidth(AValues.GetColumnsNames(j - 1)) div 2, LXLabels, AValues.GetColumnsNames(j - 1));
        j := j + 1;
      end;
    end;
  end;

  LWhiteBuf.Free;
  LBlackBuf.Free;
end;

{ -----------------------------------------------------------------------------}

constructor TLMDChartRectangular2DCT.Create(AMainOwner: TComponent);
begin
  inherited Create(AMainOwner);
  FLabels := TLMDChartLabel.Create(AMainOwner);
  FYLine := TLMDChartLine.Create(AMainOwner);
  FXLine := TLMDChartLine.Create(AMainOwner);
  //default
  FShowLabels := true;
  FElementsTransparency := 150;
  FLabelsMargin := 4;
  FLabelsYDeviation := 0;
  FLabelsXDeviation := 0;
end;

function TLMDChartRectangular2DCT.GenerateBasicElementsPoints(
  AValues: TLMDChartData; ASeriesIndex: integer; AStartX, AEndX, AStartY, AEndY: integer;
  AYAxis: TLMDChartYAxis): TLMDChartPoints;
var
  i, stepX, q: integer;
begin
  AValues.HighestForStacked := false;
  SetLength(Result, AValues.ColCount);
  if (AValues.ColCount = 0) or (ASeriesIndex < 0) or (ASeriesIndex >= AValues.RowCount) then
    Exit
  else
  begin
    if (AValues.ColCount = 1) then
      stepX := 0
    else
      stepX := Round((AEndX - AStartX) / (AValues.ColCount - 1));
    for i := 0 to AValues.ColCount - 1 do
    begin
      Result[i].x := AStartX + i * stepX;
      Result[i].y := AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, AValues.GetTableValue(i, ASeriesIndex), q);
    end;
  end;
end;

procedure TLMDChartRectangular2DCT.DrawChart(ATarget: TCanvas;
  AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer;
  AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  LElementsPoints: TLMDChartPoints;
  i: integer;
begin
  LElementsPoints := nil;
  for i := 0 to AValues.RowCount - 1 do
  begin
    LElementsPoints := Self.GenerateBasicElementsPoints(AValues, i, AStartX, AEndX, AStartY, AEndY, AYAxis);
    Self.DrawChartElements(ATarget, AValues, i, LElementsPoints, AStartX, AEndX, AStartY, AEndY);
    Self.DrawChartMarkers(ATarget, AValues, i, LElementsPoints);
  end;
end;

procedure TLMDChartRectangular2DCT.DrawChartMarkers(ATarget: TCanvas;
  AValues: TLMDChartData; ASeriesIndex: integer;
  AElementsPoints: TLMDChartPoints);
var
  j: integer;
  LMarker: TLMDChartMarker;
begin
  LMarker := AValues.GetRowMarker(ASeriesIndex);
  for j := 0 to AValues.ColCount - 1 do
  begin
    if Assigned(LMarker) and Assigned(Self.FChartArea) and (Self.FChartArea.ShowMarkers) then
      LMarker.Draw(ATarget, AElementsPoints[j].X, AElementsPoints[j].Y);
    if Self.ShowLabels then
      FLabels.Draw(ATarget, AValues.GetRowsNames(ASeriesIndex) + ': ' + floattostr(AValues.GetTableValue(j, ASeriesIndex)), AElementsPoints[j].X + FLabelsMargin + FLabelsXDeviation + LMarker.Size + 25,
        AElementsPoints[j].Y + FLabelsYDeviation - round(LMarker.Size * 1.5), claLeftTop, clcHorizontal);
  end;
end;

end.
