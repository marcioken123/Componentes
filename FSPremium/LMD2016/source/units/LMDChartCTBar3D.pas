unit LMDChartCTBar3D;
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
LMDChartCTBar unit
-----------------------

Changes
-------
Last (09-June-2006)

###############################################################################}

interface

uses
  Windows, SysUtils, Math, Graphics, Classes, Variants, Types,
  LMDXML, LMDXMLNodeNames, LMDChartData, LMDChartTypes, LMDChartPersistent,
  LMDChartUtils, LMDChartAxis, LMDChartMarker, LMDChartLabel, LMDChartLine,
  LMDChartBackground, LMDChartScaleBreak;

type
  { ************************ TLMDChartCTBar3D ********************************** }
  /// <summary>
  /// A bar 3d chart displays series as sets of horizontal bars that are grouped
  /// by category. Values are represented by the length of the bars as measured
  /// by the x-axis. Category labels are displayed on the y-axis. Bar charts
  /// are typically used to compare values between categories.
  /// </summary>
  TLMDChartCTBar3D = class(TLMDChartCTAbstract)
  private
    FColumnAutoSize: boolean;
    FColumnAutoSizeValue: integer;
    FColumnCustomSize: integer;
    FColumnsTransparency: byte;
    FColumnsLabels: TLMDChartLabel;
    FShowColumnsLabels: boolean;
    FLabelsYDeviation: integer;
    FLabelsXDeviation: integer;
    FLabelsMargin: integer;
    FChartDepth: integer;
    FLeftPlaneLine: TLMDChartLine;
    FBottomPlaneLine: TLMDChartLine;
    FBackPlaneLine: TLMDChartLine;
    FBottomPlaneFill: TLMDChartBackground;
    FLeftPlaneFill: TLMDChartBackground;
    FMultiRow: boolean;
    FMultiRowIndent: integer;
    FShadedBoxes: boolean;
    FNoEdge: boolean;
    FBackPlaneFill: TLMDChartBackground;
    FStacked: boolean;
    FFullStacked: boolean;
    procedure SetColumnAutoSize(Value: boolean);
    procedure SetColumnAutoSizeValue(Value: integer);
    procedure SetColumnCustomSize(Value: integer);
    procedure SetColumnsLabels(Value: TLMDChartLabel);
    procedure SetColumnsTransparency(Value: byte);
    procedure SetLabelsMargin(Value: integer);
    procedure SetLabelsXDeviation(Value: integer);
    procedure SetLabelsYDeviation(Value: integer);
    procedure SetChartDepth(Value: integer);
    procedure SetBottomPlaneLine(Value: TLMDChartLine);
    procedure SetLeftPlaneLine(Value: TLMDChartLine);
    procedure SetBackPlaneLine(Value: TLMDChartLine);
    procedure SetBottomPlaneFill(Value: TLMDChartBackground);
    procedure SetLeftPlaneFill(Value: TLMDChartBackground);
    procedure SetMultiRow(Value: boolean);
    procedure SetMultiRowIndent(Value: integer);
    procedure SetShadedBoxes(Value: boolean);
    procedure SetNoEdge(Value: boolean);
    procedure SetStacked(Value: boolean);
    procedure SetFullStacked(Value: boolean);
    procedure SetShowColumnsLabels(Value: boolean);
    procedure SetBackPlaneFill(Value: TLMDChartBackground);
    procedure DrawPlaneLines(ATarget: TCanvas; Negative: boolean; leftPoly: TPointsArr; bottomPoly: TPointsArr; backRect: TRect);
  protected
    procedure DrawBars(ATarget: TCanvas; AValues: TLMDChartData;
      AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
      AShowMarkers: boolean);
    procedure DrawBarsNegative(ATarget: TCanvas; AValues: TLMDChartData;
      AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
    procedure DrawMultiRowBars(ATarget: TCanvas; AValues: TLMDChartData;
      AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
    procedure DrawMultiRowBarsNegative(ATarget: TCanvas; AValues: TLMDChartData;
      AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
    procedure DrawBarsStacked(ATarget: TCanvas; AValues: TLMDChartData;
      AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
      AShowMarkers: boolean);
  public
    procedure Assign(ASource: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    /// Draws object on canvas
    /// </summary>
    procedure Draw(ABuffer: TBitmap; AArea: TRect; AValues: TLMDChartData;
      AChartArea: TLMDChartPersistent); override;
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
    property LabelsXDeviation: integer read FLabelsXDeviation write SetLabelsXDeviation default 0;
    property LabelsYDeviation: integer read FLabelsYDeviation write SetLabelsYDeviation default 0;
    property LabelsMargin: integer read FLabelsMargin write SetLabelsMargin default 4;
    property ColumnsLabels: TLMDChartLabel read FColumnsLabels write SetColumnsLabels;
    property ColumnsTransparency: byte read FColumnsTransparency write SetColumnsTransparency default 200;
    property ColumnAutoSize: boolean read FColumnAutoSize write SetColumnAutoSize default true;
    property ColumnAutoSizeValue: integer read FColumnAutoSizeValue write SetColumnAutoSizeValue default 10;
    property ColumnCustomSize: integer read FColumnCustomSize write SetColumnCustomSize default 20;
    property ChartDepth: integer read FChartDepth write SetChartDepth default 100;
    property BottomPlaneLine: TLMDChartLine read FBottomPlaneLine write SetBottomPlaneLine;
    property BackPlaneLine: TLMDChartLine read FBackPlaneLine write SetBackPlaneLine;
    property BottomPlaneFill: TLMDChartBackground read FBottomPlaneFill write SetBottomPlaneFill;
    property LeftPlaneLine: TLMDChartLine read FLeftPlaneLine write SetLeftPlaneLine;
    property LeftPlaneFill: TLMDChartBackground read FLeftPlaneFill write SetLeftPlaneFill;
    property MultiRow: boolean read FMultiRow write SetMultiRow default false;
    property MultiRowIndent: integer read FMultiRowIndent write SetMultiRowIndent default 5;
    property ShadedBoxes: boolean read FShadedBoxes write SetShadedBoxes default true;
    property NoEdge: boolean read FNoEdge write SetNoEdge default false;
    property Stacked: boolean read FStacked write SetStacked default false;
    property FullStacked: boolean read FFullStacked write SetFullStacked default false;
    property ShowColumnsLabels: boolean read FShowColumnsLabels write SetShowColumnsLabels default false;
    property BackPlaneFill: TLMDChartBackground read FBackPlaneFill write SetBackPlaneFill;
  end;

implementation

uses
  LMDChartArea;

{ ************************ TLMDChartCTBar3D ************************************ }
{ ------------------------ private ------------------------------------------- }

procedure TLMDChartCTBar3D.SetColumnAutoSize(Value: boolean);
begin
  FColumnAutoSize := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetColumnAutoSizeValue(Value: integer);
begin
  FColumnAutoSizeValue := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTBar3D.SetShowColumnsLabels(Value: boolean);
begin
  FShowColumnsLabels := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTBar3D.SetStacked(Value: boolean);
begin
  FStacked := Value;
  if Value = true then
    MultiRow := false;
  if Value = false then
    FFullStacked := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTBar3D.SetFullStacked(Value: boolean);
begin
  FFullStacked := Value;
  if Value = true then
  begin
    Stacked := Value;
    MultiRow := not Value;
  end;
  FChanged := true;
  HighestOwnerRepaint;
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetColumnCustomSize(Value: integer);
begin
  FColumnCustomSize := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetColumnsLabels(Value: TLMDChartLabel);
begin
  FColumnsLabels.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetColumnsTransparency(Value: byte);
begin
  FColumnsTransparency := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetLabelsMargin(Value: integer);
begin
  FLabelsMargin := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetLabelsXDeviation(Value: integer);
begin
  FLabelsXDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetLabelsYDeviation(Value: integer);
begin
  FLabelsYDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetChartDepth(Value: integer);
begin
  FChartDepth := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetBottomPlaneLine(Value: TLMDChartLine);
begin
  FBottomPlaneLine.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetLeftPlaneLine(Value: TLMDChartLine);
begin
  FLeftPlaneLine.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetBackPlaneLine(Value: TLMDChartLine);
begin
  FBackPlaneLine.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetBottomPlaneFill(Value: TLMDChartBackground);
begin
  FBottomPlaneFill.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetLeftPlaneFill(Value: TLMDChartBackground);
begin
  FLeftPlaneFill.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetMultiRow(Value: boolean);
begin
  FMultiRow := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetMultiRowIndent(Value: integer);
begin
  FMultiRowIndent := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetShadedBoxes(Value: boolean);
begin
  FShadedBoxes := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetNoEdge(Value: boolean);
begin
  FNoEdge := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.SetBackPlaneFill(Value: TLMDChartBackground);
begin
  FBackPlaneFill := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ------------------------ protected ----------------------------------------- }

procedure TLMDChartCTBar3D.DrawBars(ATarget: TCanvas; AValues: TLMDChartData;
  AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  LDelta, i, j, LPositionOnAxis, LBarWidth, LErrorBack, LBarDepth, LLabelOffset, LPosY: integer;
  loaddata, labeldata: variant;
  OffSetPos: variant;
  fp, lp: variant;
  bCol, pCol: TColor;
  pStyle: TPenStyle;
  bStyle: TBrushStyle;
begin
  OffSetPos := 0;
  // TODO: check this
  fp := 0;
  lp := 0;
  if AYAxis.ScaleBreak.Enabled then
    OffSetPos := AYAxis.ScaleBreak.PositiveLowLimit - AYAxis.ScaleBreak.PositiveHighLimit;
  LDelta := AEndX - AStartX;
  if (AValues.ColCount > 0) and (AValues.RowCount > 0) then
  begin
    for i := 0 to (AValues.ColCount * 2) - 1 do
    begin
      if not odd(i) then
        Continue;
      LPositionOnAxis := Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * i));
      //check column width
      if not FColumnAutoSize then
        LBarWidth := FColumnCustomSize
      else
        LBarWidth := (Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i + 1))) - Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i - 1))) - FColumnAutoSizeValue * 2) div AValues.RowCount;
      LBarDepth := FChartDepth - MultiRowIndent * 2;
      LLabelOffset := MultiRowIndent + LBarDepth div 2;
      //draw column
      LPosY := (AEndX - LPositionOnAxis) + (AValues.RowCount * LBarWidth div 2);
      for j := 0 to AValues.RowCount - 1 do
      begin
        if AValues.GetTableValue(i div 2, j) = EmptyID then
          loaddata := 0
        else
          loaddata := AValues.GetTableValue(i div 2, j);
        labeldata := loaddata;
        if (loaddata > AYAxis.ScaleBreak.PositiveHighLimit) and
          ((AYAxis.ScaleBreak.Appearance = sbaPositive) or (AYAxis.ScaleBreak.Appearance = sbaBoth)) then
          loaddata := loaddata + OffSetPos;
        if AYAxis.ScaleBreak.Enabled then
          if (AYAxis.ScaleBreak.Appearance = sbaPositive) or (AYAxis.ScaleBreak.Appearance = sbaBoth) then
            begin
              fp := AYAxis.ScaleBreak.PositiveLowLimit + round(AYAxis.ScaleBreak.PositiveLowLimit/20);
              lp := AYAxis.ScaleBreak.PositiveLowLimit + round(AYAxis.ScaleBreak.PositiveLowLimit/20)*2;
            end;
        AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen);
        if loaddata > 0 then
        begin
          AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen);
          ATarget.Brush.Color := AValues.GetRowFill(j).SolidColor;
          if NoEdge then
            ATarget.Pen.Color := ATarget.Brush.Color;

          if (AYAxis.ScaleBreak.Enabled) and (loaddata > AYAxis.ScaleBreak.PositiveLowLimit) and (AYAxis.ScaleBreak.Style3D <> sbt3DNone) then
          begin
            pStyle := ATarget.Pen.Style;
            bStyle := ATarget.Brush.Style;
            pCol := ATarget.Pen.Color;
            bCol := ATarget.Brush.Color;
            Box(ATarget,
              Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LErrorBack) + MultiRowIndent, //left
              LPosY - LBarWidth - MultiRowIndent, //top
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LErrorBack) + MultiRowIndent, //right
              LPosY - MultiRowIndent), //bottom
              FChartDepth - MultiRowIndent * 2,
              FShadedBoxes);

            // break
            if (AYAxis.ScaleBreak.Style3D = sbt3DEmpty) then
            begin
              ATarget.Brush.Style := bsClear;
              ATarget.Pen.Style := psClear;
            end
            else
            begin
              ATarget.Brush.Style := bsSolid;
              ATarget.Brush.Color := AYAxis.ScaleBreak.Color;
              ATarget.Pen.Style := psSolid;
              ATarget.Pen.Color := AYAxis.ScaleBreak.Color;
            end;
            Box(ATarget,
              Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LErrorBack) + MultiRowIndent, //left
              LPosY - LBarWidth - MultiRowIndent, //top
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LErrorBack) + MultiRowIndent, //right
              LPosY - MultiRowIndent), //bottom
              FChartDepth - MultiRowIndent * 2,
              false);

            ATarget.Pen.Style := pStyle;
            ATarget.Brush.Style := bStyle;
            ATarget.Pen.Color := pCol;
            ATarget.Brush.Color := bCol;
            Box(ATarget,
              Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LErrorBack) + MultiRowIndent, //left
              LPosY - LBarWidth - MultiRowIndent, //top
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + MultiRowIndent, //right
              LPosY - MultiRowIndent), //bottom
              FChartDepth - MultiRowIndent * 2,
              FShadedBoxes);

          end
          else
            Box(ATarget,
              Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LErrorBack) + MultiRowIndent, //left
              LPosY - LBarWidth - MultiRowIndent, //top
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + MultiRowIndent, //right
              LPosY - MultiRowIndent), //bottom
              FChartDepth - MultiRowIndent * 2,
              FShadedBoxes);

          if AShowMarkers then
            AValues.GetRowMarker(j).Draw(ATarget,
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + MultiRowIndent,
              LPosY - LBarWidth div 2 - MultiRowIndent);

          if FShowColumnsLabels then
            ColumnsLabels.Draw(ATarget,
              floattostr(labeldata),
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + FLabelsMargin + FLabelsXDeviation + LLabelOffset,
              trunc(LPosY - LBarWidth / 2) + FLabelsYDeviation - LLabelOffset,
              claLeftTop, clcVertical);
        end;
        LPosY := LPosY - LBarWidth;
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.DrawBarsStacked(ATarget: TCanvas;
  AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer;
  AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  i, j, k: integer;
  LColumnPosition, LColumnWidth, LErrorBack, LDelta, LPosY: integer;
  LAccomulation, SumVal: real;
  Factors: array of real;
  ColorB, ShadowColorV, ColorP: TColor;
  BGBuf: TLMDChartBackground;
  LineBuf: TLMDChartLine;
  loaddata: variant;
begin
  for k := FChartDepth downto 0 do
  begin
    LDelta := AEndX - AStartX;
    if (AValues.ColCount > 0) and (AValues.RowCount > 0) then
    begin
      SetLength(factors, AValues.ColCount);
      if (FFullStacked) then
      begin
        for i := 0 to AValues.ColCount - 1 do
        begin
          SumVal := 0;
          for j := 0 to AValues.RowCount - 1 do
          begin
            if AValues.GetTableValue(i, j) = EmptyID then
              loaddata := 0
            else
              loaddata := AValues.GetTableValue(i, j);
            SumVal := SumVal + abs(loaddata);
          end;
          Factors[i] := SumVal;
        end;
        for i := 0 to AValues.ColCount - 1 do
          Factors[i] := AYAxis.MaxValue / Factors[i];
      end
      else
        for i := 0 to AValues.ColCount - 1 do
          Factors[i] := 1;

      for i := 0 to (AValues.ColCount * 2) - 1 do
      begin

        if not odd(i) then
          Continue;
        LColumnPosition := Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * i));
        //check column width
        if not FColumnAutoSize then
          LColumnWidth := FColumnCustomSize
        else
          LColumnWidth := (Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i + 1))) -
            Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i - 1))) - FColumnAutoSizeValue * 2);
        //draw column
        LPosY := (AEndX - LColumnPosition) + LColumnWidth div 2;
        //negative
        LAccomulation := 0;
        for j := 0 to AValues.RowCount - 1 do
        begin
          if AValues.GetTableValue(i div 2, j) = EmptyID then
            loaddata := 0
          else
            loaddata := AValues.GetTableValue(i div 2, j);
          if loaddata < 0 then
          begin
            BGBuf := TLMDChartBackground.Create(nil);
            LineBuf := TLMDChartLine.Create(nil);
            BGBuf.SolidColor := AValues.GetRowFill(j).SolidColor;
            LineBuf.Color := AValues.GetRowsLines(j).Color;

            ColorB := BGBuf.SolidColor;
            if (FShadedBoxes) then
              ShadowColorV := ShadowColor(BGBuf.SolidColor, 100)
            else
              ShadowColorV := ColorB;
            if (FNoEdge) then
              ColorP := ShadowColorV
            else
              ColorP := LineBuf.Color;

            if ((k <> 0) and (k <> FChartDepth)) then
              LineBuf.Color := ShadowColorV
            else
              LineBuf.Color := ColorP;
            if (k = 0) and (FNoEdge) then
              LineBuf.Color := ColorB;
            if k <> 0 then
              BGBuf.SolidColor := ShadowColorV
            else
              BGBuf.SolidColor := ColorB;

            BGBuf.DrawRectangle(ATarget,
              LineBuf,
              AStartY + k + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation, LErrorBack),
              LPosY - k - LColumnWidth,
              AStartY + k + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack) + 1
              , LPosY - k
              );
            if (not NoEdge) then
              ATarget.Pixels[AStartY + k + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation, LErrorBack), LPosY - k - LColumnWidth] := ColorP;
            if (not NoEdge) then
              ATarget.Pixels[AStartY + k + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack) + 1, LPosY - k - 1] := ColorP;
            if (not NoEdge) then
              ATarget.Pixels[AStartY + k + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack) + 1, LPosY - k - LColumnWidth] := ColorP;
            if FShowColumnsLabels then
              ColumnsLabels.Draw(ATarget, floattostr(loaddata), AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata / 2, LErrorBack) + FLabelsMargin + FLabelsXDeviation,
                LPosY - LColumnWidth div 2 + FLabelsYDeviation, claLeftTop, clcHorzVert);
            LAccomulation := LAccomulation + loaddata * Factors[i div 2];
          end;
        end;
        //positive
        LAccomulation := 0;
        for j := 0 to AValues.RowCount - 1 do
        begin
          if AValues.GetTableValue(i div 2, j) = EmptyID then
            loaddata := 0
          else
            loaddata := AValues.GetTableValue(i div 2, j);
          if loaddata > 0 then
          begin
            BGBuf := TLMDChartBackground.Create(nil);
            LineBuf := TLMDChartLine.Create(nil);
            BGBuf.SolidColor := AValues.GetRowFill(j).SolidColor;
            LineBuf.Color := AValues.GetRowsLines(j).Color;

            ColorB := BGBuf.SolidColor;
            if (FShadedBoxes) then
              ShadowColorV := ShadowColor(BGBuf.SolidColor, 100)
            else
              ShadowColorV := ColorB;
            if (FNoEdge) then
              ColorP := ShadowColorV
            else
              ColorP := LineBuf.Color;

            if ((k <> 0) and (k <> FChartDepth)) then
              LineBuf.Color := ShadowColorV
            else
              LineBuf.Color := ColorP;
            if (k = 0) and (FNoEdge) then
              LineBuf.Color := ColorB;
            if k <> 0 then
              BGBuf.SolidColor := ShadowColorV
            else
              BGBuf.SolidColor := ColorB;

            BGBuf.DrawRectangle(ATarget,
              LineBuf,
              AStartY + k + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation, LErrorBack),
              LPosY - k - LColumnWidth,
              AStartY + k + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack) + 1
              , LPosY - k
              );
            if (not NoEdge) then
              ATarget.Pixels[AStartY + k + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation, LErrorBack), LPosY - k - LColumnWidth] := ColorP;
            if (not NoEdge) then
              ATarget.Pixels[AStartY + k + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack) + 1, LPosY - k - 1] := ColorP;
            if (not NoEdge) then
              ATarget.Pixels[AStartY + k + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack) + 1, LPosY - k - LColumnWidth] := ColorP;
            if FShowColumnsLabels then
              ColumnsLabels.Draw(ATarget, floattostr(loaddata), AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata / 2, LErrorBack) + FLabelsMargin + FLabelsXDeviation,
                LPosY - LColumnWidth div 2 + FLabelsYDeviation, claLeftTop, clcHorzVert);
            LAccomulation := LAccomulation + loaddata * Factors[i div 2];
            BGBuf.Free;
            LineBuf.Free;
          end;
        end;

      end;

    end;
  end; // for k
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.DrawBarsNegative(ATarget: TCanvas; AValues: TLMDChartData;
  AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  LDelta, i, j, LPositionOnAxis, LBarWidth, LErrorBack, LBarDepth, LLabelOffset, LPosY: integer;
  loaddata, labeldata: variant;
  OffSetNeg: variant;
  fp, lp: variant;
  bCol, pCol: TColor;
  pStyle: TPenStyle;
  bStyle: TBrushStyle;
begin
  OffSetNeg := 0;
  // TODO: check this
  fp := 0;
  lp := 0;
  if AYAxis.ScaleBreak.Enabled then
    OffSetNeg := AYAxis.ScaleBreak.NegativeLowLimit - AYAxis.ScaleBreak.NegativeHighLimit;
  LDelta := AEndX - AStartX;
  if (AValues.ColCount > 0) and (AValues.RowCount > 0) then
  begin
    for i := 0 to (AValues.ColCount * 2) - 1 do
    begin
      if not odd(i) then
        Continue;
      LPositionOnAxis := Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * i));
      //check column width
      if not FColumnAutoSize then
        LBarWidth := FColumnCustomSize
      else
        LBarWidth := (Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i + 1))) - Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i - 1))) - FColumnAutoSizeValue * 2) div AValues.RowCount;
      LBarDepth := FChartDepth - MultiRowIndent * 2;
      LLabelOffset := MultiRowIndent + LBarDepth div 2;
      //draw column
      LPosY := (AEndX - LPositionOnAxis) + (AValues.RowCount * LBarWidth div 2);
      for j := 0 to AValues.RowCount - 1 do
      begin
        AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen);
        if AValues.GetTableValue(i div 2, j) = EmptyID then
          loaddata := 0
        else
          loaddata := AValues.GetTableValue(i div 2, j);
        labeldata := loaddata;
        if (loaddata < AYAxis.ScaleBreak.NegativeHighLimit) and
          ((AYAxis.ScaleBreak.Appearance = sbaNegative) or (AYAxis.ScaleBreak.Appearance = sbaBoth)) then
          loaddata := loaddata + OffSetNeg;
        if AYAxis.ScaleBreak.Enabled then
          if (AYAxis.ScaleBreak.Appearance = sbaNegative) or (AYAxis.ScaleBreak.Appearance = sbaBoth) then
          begin
            fp := AYAxis.ScaleBreak.NegativeLowLimit + Round(AYAxis.ScaleBreak.NegativeLowLimit / 20) * 2;
            lp := AYAxis.ScaleBreak.NegativeLowLimit + Round(AYAxis.ScaleBreak.NegativeLowLimit / 20);
          end;
        if loaddata < 0 then
        begin
          AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen);
          ATarget.Brush.Color := AValues.GetRowFill(j).SolidColor;

          if (AYAxis.ScaleBreak.Enabled) and (loaddata < AYAxis.ScaleBreak.NegativeLowLimit) and (AYAxis.ScaleBreak.Style3D <> sbt3DNone) then
          begin
            pStyle := ATarget.Pen.Style;
            bStyle := ATarget.Brush.Style;
            pCol := ATarget.Pen.Color;
            bCol := ATarget.Brush.Color;
            Box(ATarget,
              Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + MultiRowIndent, //left
              LPosY - LBarWidth - MultiRowIndent, //top
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LErrorBack) + MultiRowIndent, //right
              LPosY - MultiRowIndent), //bottom
              FChartDepth - MultiRowIndent * 2,
              FShadedBoxes);

            // break
            if (AYAxis.ScaleBreak.Style3D = sbt3DEmpty) then
            begin
              ATarget.Brush.Style := bsClear;
              ATarget.Pen.Style := psClear;
            end
            else
            begin
              ATarget.Brush.Style := bsSolid;
              ATarget.Brush.Color := AYAxis.ScaleBreak.Color;
              ATarget.Pen.Style := psSolid;
              ATarget.Pen.Color := AYAxis.ScaleBreak.Color;
            end;
            Box(ATarget,
              Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LErrorBack) + MultiRowIndent, //left
              LPosY - LBarWidth - MultiRowIndent, //top
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LErrorBack) + MultiRowIndent, //right
              LPosY - MultiRowIndent), //bottom
              FChartDepth - MultiRowIndent * 2,
              false);

            ATarget.Pen.Style := pStyle;
            ATarget.Brush.Style := bStyle;
            ATarget.Pen.Color := pCol;
            ATarget.Brush.Color := bCol;
            Box(ATarget,
              Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LErrorBack) + MultiRowIndent, //left
              LPosY - LBarWidth - MultiRowIndent, //top
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LErrorBack) + MultiRowIndent, //right
              LPosY - MultiRowIndent), //bottom
              FChartDepth - MultiRowIndent * 2,
              FShadedBoxes);

          end
          else
            Box(ATarget,
              Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + MultiRowIndent, //left
              LPosY - LBarWidth - MultiRowIndent, //top
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LErrorBack) + MultiRowIndent, //right
              LPosY - MultiRowIndent), //bottom
              FChartDepth - MultiRowIndent * 2,
              FShadedBoxes);

          if AShowMarkers then
            AValues.GetRowMarker(j).Draw(ATarget,
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + MultiRowIndent,
              LPosY - LBarWidth div 2 - MultiRowIndent);

          if FShowColumnsLabels then
            ColumnsLabels.Draw(ATarget,
              floattostr(labeldata),
              AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) - FLabelsMargin + FLabelsXDeviation + LLabelOffset,
              LPosY - LBarWidth div 2 - FLabelsYDeviation - LLabelOffset,
              claRightTop, clcVertical);
        end;
        LPosY := LPosY - LBarWidth;
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.DrawMultiRowBars(ATarget: TCanvas; AValues: TLMDChartData;
  AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  LDelta, i, j, LPositionOnAxis, LBarWidth, LErrorBack, LBarDepth, LPosY, LPosZ, LGoodIndent: integer;
  loaddata, labeldata: variant;
  OffSetPos: variant;
  fp, lp: variant;
  bCol, pCol: TColor;
  pStyle: TPenStyle;
  bStyle: TBrushStyle;
begin
  OffSetPos := 0;
  // TODO: check this
  fp := 0;
  lp := 0;
  if AYAxis.ScaleBreak.Enabled then
    OffSetPos := AYAxis.ScaleBreak.PositiveLowLimit - AYAxis.ScaleBreak.PositiveHighLimit;
  LDelta := AEndX - AStartX;

  if (AValues.ColCount <= 0) and (AValues.RowCount <= 0) then
    exit;

  LGoodIndent := (ChartDepth div AValues.RowCount - 1) div 2;
  if MultiRowIndent > LGoodIndent then
    FMultiRowIndent := LGoodIndent;
  LBarDepth := (ChartDepth div AValues.RowCount) - (MultiRowIndent * 2);

  if LBarDepth <= 0 then
    exit;
  LPosZ := ChartDepth;

  if not FColumnAutoSize then
    LBarWidth := FColumnCustomSize
  else
    LBarWidth := 10;

  for j := AValues.RowCount - 1 downto 0 do
  begin
    LPosZ := LPosZ - MultiRowIndent - LBarDepth;
    for i := 0 to (AValues.ColCount * 2) - 1 do
    begin
      if not odd(i) then
        Continue;
      LPositionOnAxis := Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * i));

      //draw column
      LPosY := (AEndX - LPositionOnAxis) + (LBarWidth div 2);
      if AValues.GetTableValue(i div 2, j) = EmptyID then
        loaddata := 0
      else
        loaddata := AValues.GetTableValue(i div 2, j);
      labeldata := loaddata;
      if (loaddata > AYAxis.ScaleBreak.PositiveHighLimit) and
        ((AYAxis.ScaleBreak.Appearance = sbaPositive) or (AYAxis.ScaleBreak.Appearance = sbaBoth)) then
        loaddata := loaddata + OffSetPos;
      if AYAxis.ScaleBreak.Enabled then
        if (AYAxis.ScaleBreak.Appearance = sbaPositive) or (AYAxis.ScaleBreak.Appearance = sbaBoth) then
        begin
          fp := AYAxis.ScaleBreak.PositiveLowLimit + Round(AYAxis.ScaleBreak.PositiveLowLimit / 20);
          lp := AYAxis.ScaleBreak.PositiveLowLimit + Round(AYAxis.ScaleBreak.PositiveLowLimit / 20) * 2;
        end;
      if loaddata > 0 then
      begin
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := AValues.GetRowFill(j).SolidColor;
        if not FNoEdge then
          AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen)
        else
          ATarget.Pen.Style := psClear;
        //Bar
        if (AYAxis.ScaleBreak.Enabled) and (loaddata > AYAxis.ScaleBreak.PositiveLowLimit) and (AYAxis.ScaleBreak.Style3D <> sbt3DNone) then
        begin
          pStyle := ATarget.Pen.Style;
          bStyle := ATarget.Brush.Style;
          pCol := ATarget.Pen.Color;
          bCol := ATarget.Brush.Color;
          Box(ATarget,
            Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LErrorBack) + LPosZ, //left
            LPosY - LPosZ - LBarWidth, //top
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LErrorBack) + LPosZ, //right
            LPosY - LPosZ), //bottom
            LBarDepth,
            FShadedBoxes);

          // break
          if (AYAxis.ScaleBreak.Style3D = sbt3DEmpty) then
          begin
            ATarget.Brush.Style := bsClear;
            ATarget.Pen.Style := psClear;
          end
          else
          begin
            ATarget.Brush.Style := bsSolid;
            ATarget.Brush.Color := AYAxis.ScaleBreak.Color;
            ATarget.Pen.Style := psSolid;
            ATarget.Pen.Color := AYAxis.ScaleBreak.Color;
          end;
          Box(ATarget,
            Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LErrorBack) + LPosZ, //left
            LPosY - LPosZ - LBarWidth, //top
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LErrorBack) + LPosZ, //right
            LPosY - LPosZ), //bottom
            LBarDepth,
            false);

          ATarget.Pen.Style := pStyle;
          ATarget.Brush.Style := bStyle;
          ATarget.Pen.Color := pCol;
          ATarget.Brush.Color := bCol;
          Box(ATarget,
            Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LErrorBack) + LPosZ, //left
            LPosY - LPosZ - LBarWidth, //top
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + LPosZ, //right
            LPosY - LPosZ), //bottom
            LBarDepth,
            FShadedBoxes);
        end
        else
          Box(ATarget,
            Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LErrorBack) + LPosZ, //left
            LPosY - LPosZ - LBarWidth, //top
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + LPosZ, //right
            LPosY - LPosZ), //bottom
            LBarDepth,
            FShadedBoxes);

        //mark
        if AShowMarkers then
          AValues.GetRowMarker(j).Draw(ATarget,
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + LPosZ,
            LPosY - LPosZ - LBarWidth div 2);
        //lable
        if FShowColumnsLabels then
          ColumnsLabels.Draw(ATarget, floattostr(labeldata),
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + LPosZ + FLabelsMargin + FLabelsXDeviation + LBarDepth div 2,
            LPosY - LPosZ - LBarWidth div 2 - LBarDepth div 2,
            claLeftTop, clcVertical);
      end;
    end;
    LPosZ := LPosZ - MultiRowIndent;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.DrawMultiRowBarsNegative(ATarget: TCanvas; AValues: TLMDChartData;
  AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  LDelta, i, j, LPositionOnAxis, LBarWidth, LErrorBack, LBarDepth, LPosY, LPosZ, LGoodIndent: integer;
  loaddata, labeldata: variant;
  OffSetNeg: variant;
  fp, lp: variant;
  bCol, pCol: TColor;
  pStyle: TPenStyle;
  bStyle: TBrushStyle;
begin
  OffSetNeg := 0;
  // TODO: check this
  fp := 0;
  lp := 0;
  if AYAxis.ScaleBreak.Enabled then
    OffSetNeg := AYAxis.ScaleBreak.NegativeLowLimit - AYAxis.ScaleBreak.NegativeHighLimit;
  LDelta := AEndX - AStartX;

  if (AValues.ColCount <= 0) and (AValues.RowCount <= 0) then
    exit;

  LGoodIndent := (ChartDepth div AValues.RowCount - 1) div 2;
  if MultiRowIndent > LGoodIndent then
    FMultiRowIndent := LGoodIndent;
  LBarDepth := (ChartDepth div AValues.RowCount) - (MultiRowIndent * 2);

  if LBarDepth <= 0 then
    exit;
  LPosZ := ChartDepth;

  if not FColumnAutoSize then
    LBarWidth := FColumnCustomSize
  else
    LBarWidth := 10;

  for j := AValues.RowCount - 1 downto 0 do
  begin
    LPosZ := LPosZ - MultiRowIndent - LBarDepth;
    for i := 0 to (AValues.ColCount * 2) - 1 do
    begin
      if not odd(i) then
        Continue;
      LPositionOnAxis := Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * i));

      //draw column
      LPosY := (AEndX - LPositionOnAxis) + (LBarWidth div 2);
      if AValues.GetTableValue(i div 2, j) = EmptyID then
        loaddata := 0
      else
        loaddata := AValues.GetTableValue(i div 2, j);
      labeldata := loaddata;
      if (loaddata < AYAxis.ScaleBreak.NegativeHighLimit) and
        ((AYAxis.ScaleBreak.Appearance = sbaNegative) or (AYAxis.ScaleBreak.Appearance = sbaBoth)) then
        loaddata := loaddata + OffSetNeg;
      if AYAxis.ScaleBreak.Enabled then
        if (AYAxis.ScaleBreak.Appearance = sbaNegative) or (AYAxis.ScaleBreak.Appearance = sbaBoth) then
        begin
          fp := AYAxis.ScaleBreak.NegativeLowLimit + round(AYAxis.ScaleBreak.NegativeLowLimit / 20) * 2;
          lp := AYAxis.ScaleBreak.NegativeLowLimit + round(AYAxis.ScaleBreak.NegativeLowLimit / 20);
        end;
      if loaddata < 0 then
      begin
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := AValues.GetRowFill(j).SolidColor;
        if not FNoEdge then
          AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen)
        else
          ATarget.Pen.Style := psClear;
        //Bar
        if (AYAxis.ScaleBreak.Enabled) and (loaddata < AYAxis.ScaleBreak.NegativeLowLimit) and (AYAxis.ScaleBreak.Style3D <> sbt3DNone) then
        begin
          pStyle := ATarget.Pen.Style;
          bStyle := ATarget.Brush.Style;
          pCol := ATarget.Pen.Color;
          bCol := ATarget.Brush.Color;
          Box(ATarget,
            Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + LPosZ, //left
            LPosY - LPosZ - LBarWidth, //top
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LErrorBack) + LPosZ, //right
            LPosY - LPosZ), //bottom
            LBarDepth,
            FShadedBoxes);

          // break
          if (AYAxis.ScaleBreak.Style3D = sbt3DEmpty) then
          begin
            ATarget.Brush.Style := bsClear;
            ATarget.Pen.Style := psClear;
          end
          else
          begin
            ATarget.Brush.Style := bsSolid;
            ATarget.Brush.Color := AYAxis.ScaleBreak.Color;
            ATarget.Pen.Style := psSolid;
            ATarget.Pen.Color := AYAxis.ScaleBreak.Color;
          end;
          Box(ATarget,
            Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LErrorBack) + LPosZ, //left
            LPosY - LPosZ - LBarWidth, //top
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LErrorBack) + LPosZ, //right
            LPosY - LPosZ), //bottom
            LBarDepth,
            false);

          ATarget.Pen.Style := pStyle;
          ATarget.Brush.Style := bStyle;
          ATarget.Pen.Color := pCol;
          ATarget.Brush.Color := bCol;
          Box(ATarget,
            Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LErrorBack) + LPosZ, //left
            LPosY - LPosZ - LBarWidth, //top
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LErrorBack) + LPosZ, //right
            LPosY - LPosZ), //bottom
            LBarDepth,
            FShadedBoxes);

        end
        else
          Box(ATarget,
            Rect(AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + LPosZ, //left
            LPosY - LPosZ - LBarWidth, //top
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LErrorBack) + LPosZ, //right
            LPosY - LPosZ), //bottom
            LBarDepth,
            FShadedBoxes);

        //mark
        if AShowMarkers then
          AValues.GetRowMarker(j).Draw(ATarget,
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + LPosZ,
            LPosY - LPosZ - LBarWidth div 2);
        //lable
        if FShowColumnsLabels then
          ColumnsLabels.Draw(ATarget, floattostr(labeldata),
            AStartY + AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LErrorBack) + LPosZ - FLabelsMargin - FLabelsXDeviation - LBarDepth div 2,
            LPosY - LPosZ - LBarWidth div 2 - LBarDepth div 2,
            claRightTop, clcVertical);
      end;
    end;
    LPosZ := LPosZ - MultiRowIndent;
  end;
end;

{ ------------------------ public -------------------------------------------- }

function TLMDChartCTBar3D.IsChanged: boolean;
begin
  if FColumnsLabels.IsChanged then
    FChanged := true;
  if FLeftPlaneLine.IsChanged then
    FChanged := true;
  if FBottomPlaneLine.IsChanged then
    FChanged := true;
  if FBackPlaneLine.IsChanged then
    FChanged := true;
  if FBottomPlaneFill.IsChanged then
    FChanged := true;
  if FLeftPlaneFill.IsChanged then
    FChanged := true;
  if FBackPlaneFill.IsChanged then
    FChanged := true;
  IsChanged := FChanged;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTBar3D.NoChanged;
begin
  FChanged := false;
  FColumnsLabels.NoChanged;
  FLeftPlaneLine.NoChanged;
  FBackPlaneLine.NoChanged;
  FBottomPlaneLine.NoChanged;
  FBottomPlaneFill.NoChanged;
  FLeftPlaneFill.NoChanged;
  FBackPlaneFill.NoChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.ResetMainOwner(AmainOwner: TPersistent);
begin
  FMainOwner := AMainOwner;
  FColumnsLabels.ResetOwner(FMainOwner);
  FLeftPlaneLine.ResetOwner(FMainOwner);
  FBackPlaneLine.ResetOwner(FMainOwner);
  FBottomPlaneLine.ResetOwner(FMainOwner);
  FBottomPlaneFill.ResetOwner(FMainOwner);
  FLeftPlaneFill.ResetOwner(FMainOwner);
  FBackPlaneFill.ResetOwner(FMainOwner);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNCTBar3D + NNSpace + Comment);

  FColumnsLabels.LoadStateFromXML(WorkNode, '');
  FLeftPlaneLine.LoadStateFromXML(WorkNode, 'LeftPlaneLine');
  FBottomPlaneLine.LoadStateFromXML(WorkNode, 'BottomPlaneLine');
  FBottomPlaneFill.LoadStateFromXML(WorkNode, 'BottomPlaneFill');
  FLeftPlaneFill.LoadStateFromXML(WorkNode, 'LeftPlaneFill');

  IterNode := WorkNode.NeedChild('ColumnsTransparency');
  FColumnsTransparency := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ShowColumnsLabels');
  FShowColumnsLabels := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('LabelsYDeviation');
  FLabelsYDeviation := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('LabelsXDeviation');
  FLabelsXDeviation := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('LabelsMargin');
  FLabelsMargin := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ColumnAutoSize');
  FColumnAutoSize := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ColumnAutoSizeValue');
  FColumnAutoSizeValue := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ColumnCustomSize');
  FColumnCustomSize := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ChartDepth');
  FChartDepth := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MultiRow');
  FMultiRow := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('MultiRowIndent');
  FMultiRowIndent := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ShadedBoxes');
  FShadedBoxes := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ColumnNoLine');
  FNoEdge := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('Stacked');
  FStacked := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('FullStacked');
  FFullStacked := IterNode.GetBoolAttr('value');
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartCTBar3D.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  IterNode := BaseNode.AppendElement('ChartType');
  IterNode.SetVarAttr('value', Variant(ChartBar3DID));

  WorkNode := BaseNode.EnsureChild(NNCTBar3D + NNSpace + Comment);

  FColumnsLabels.SaveStateToXML(WorkNode, '');
  FLeftPlaneLine.SaveStateToXML(WorkNode, 'LeftPlaneLine');
  FBottomPlaneLine.SaveStateToXML(WorkNode, 'BottomPlaneLine');
  FBottomPlaneFill.SaveStateToXML(WorkNode, 'BottomPlaneFill');
  FLeftPlaneFill.SaveStateToXML(WorkNode, 'LeftPlaneFill');

  IterNode := WorkNode.AppendElement('ColumnsTransparency');
  IterNode.SetVarAttr('value', FColumnsTransparency);

  IterNode := WorkNode.AppendElement('ShowColumnsLabels');
  IterNode.SetBoolAttr('value', FShowColumnsLabels);

  IterNode := WorkNode.AppendElement('LabelsYDeviation');
  IterNode.SetVarAttr('value', FLabelsYDeviation);

  IterNode := WorkNode.AppendElement('LabelsXDeviation');
  IterNode.SetVarAttr('value', FLabelsXDeviation);

  IterNode := WorkNode.AppendElement('LabelsMargin');
  IterNode.SetVarAttr('value', FLabelsMargin);

  IterNode := WorkNode.AppendElement('ColumnAutoSize');
  IterNode.SetBoolAttr('value', FColumnAutoSize);

  IterNode := WorkNode.AppendElement('ColumnAutoSizeValue');
  IterNode.SetVarAttr('value', FColumnAutoSizeValue);

  IterNode := WorkNode.AppendElement('ColumnCustomSize');
  IterNode.SetVarAttr('value', FColumnCustomSize);

  IterNode := WorkNode.AppendElement('ChartDepth');
  IterNode.SetVarAttr('value', FChartDepth);

  IterNode := WorkNode.AppendElement('MultiRow');
  IterNode.SetBoolAttr('value', FMultiRow);

  IterNode := WorkNode.AppendElement('MultiRowIndent');
  IterNode.SetVarAttr('value', FMultiRowIndent);

  IterNode := WorkNode.AppendElement('ShadedBoxes');
  IterNode.SetBoolAttr('value', FShadedBoxes);

  IterNode := WorkNode.AppendElement('ColumnNoLine');
  IterNode.SetBoolAttr('value', FNoEdge);

  IterNode := WorkNode.AppendElement('Stacked');
  IterNode.SetBoolAttr('value', FStacked);

  IterNode := WorkNode.AppendElement('FullStacked');
  IterNode.SetBoolAttr('value', FFullStacked);
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartCTBar3D.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartCTBar3D then
  begin
    try
      FColumnsLabels.Assign(TLMDChartCTBar3D(ASource).FColumnsLabels);
      FShowColumnsLabels := TLMDChartCTBar3D(ASource).FShowColumnsLabels;
      ColumnsTransparency := TLMDChartCTBar3D(ASource).FColumnsTransparency;
      FColumnAutoSize := TLMDChartCTBar3D(ASource).FColumnAutoSize;
      FColumnAutoSizeValue := TLMDChartCTBar3D(ASource).ColumnAutoSizeValue;
      FColumnCustomSize := TLMDChartCTBar3D(ASource).ColumnCustomSize;
      FLabelsYDeviation := TLMDChartCTBar3D(ASource).FLabelsYDeviation;
      FLabelsXDeviation := TLMDChartCTBar3D(ASource).FLabelsXDeviation;
      FLabelsMargin := TLMDChartCTBar3D(ASource).FLabelsMargin;
      FChartDepth := TLMDChartCTBar3D(ASource).FChartDepth;
      FShadedBoxes := TLMDChartCTBar3D(ASource).FShadedBoxes;
      FLeftPlaneLine.Assign(TLMDChartCTBar3D(ASource).FLeftPlaneLine);
      FBackPlaneLine.Assign(TLMDChartCTBar3D(ASource).FLeftPlaneLine);
      FBottomPlaneLine.Assign(TLMDChartCTBar3D(ASource).FBottomPlaneLine);
      FLeftPlaneFill.Assign(TLMDChartCTBar3D(ASource).FLeftPlaneFill);
      FBottomPlaneFill.Assign(TLMDChartCTBar3D(ASource).FBottomPlaneFill);
      FNoEdge := TLMDChartCTBar3D(ASource).FNoEdge;
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartCTBar3D.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColumnsLabels := TLMDChartLabel.Create(AOwner);
  FLeftPlaneLine := TLMDChartLine.Create(AOwner);
  FBottomPlaneLine := TLMDChartLine.Create(AOwner);
  FBackPlaneLine := TLMDChartLine.Create(AOwner);
  FLeftPlaneFill := TLMDChartBackground.Create(AOwner);
  FBottomPlaneFill := TLMDChartBackground.Create(AOwner);
  FBackPlaneFill := TLMDChartBackground.Create(AOwner);
  //default
  FShowColumnsLabels := true;
  FColumnAutoSize := true;
  FColumnAutoSizeValue := 10;
  FColumnCustomSize := 20;
  FColumnsTransparency := 200;
  ChartDepth := 100;
  MultiRow := false;
  MultiRowIndent := 5;
  ShadedBoxes := true;
  FNoEdge := false;
  FLabelsMargin := 4;
  FLabelsYDeviation := 0;
  FLabelsXDeviation := 0;
  FStacked := false;
  FFullStacked := false;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartCTBar3D.Destroy;
begin
  FColumnsLabels.Free;
  FLeftPlaneLine.Free;
  FBackPlaneLine.Free;
  FBottomPlaneLine.Free;
  FLeftPlaneFill.Free;
  FBottomPlaneFill.Free;
  FBackPlaneFill.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTBar3D.Draw(ABuffer: TBitmap; AArea: TRect;
  AValues: TLMDChartData; AChartArea: TLMDChartPersistent);
var
  LLeftFld, LTopFld, LRightFld, LBottomFld: integer;
  i, j, LTempVar, LPositionOnAxis, LErrorBack, LYLabels, LXLabels: integer;
  LXAxisStart, LXAxisEnd: TPoint;
  LYAxisStart, LYAxisEnd: TPoint;
  LCalcZ, LCalcX: real;
  LTickSz: integer;
  LChartArea: TLMDChartArea;
  LBlackBuf, LWhiteBuf: TBitmap;
  LXLabelsWidth, LYLabelsHeight: integer;
  LPointArrBottom: TPointsArr;
  LPointArrLeft: TPointsArr;
  labeldata: variant;
  LRectBack: TRect;
begin
  inherited;
  LChartArea := TLMDChartArea(AChartArea);
  if Stacked then
    AValues.HighestForStacked := true
  else
    AValues.HighestForStacked := false;
  LChartArea.YAxis.AutoScale := LChartArea.YAxis.AutoScale;

  LBlackBuf := TBitmap.Create;
  LBlackBuf.Height := AArea.Bottom - AArea.Top - LChartArea.MarginTop - LChartArea.MarginBottom;
  LBlackBuf.Width := AArea.Right - AArea.Left - LChartArea.MarginLeft - LChartArea.MarginRight;
  LWhiteBuf := TBitmap.Create;
  LWhiteBuf.Height := AArea.Bottom - AArea.Top - LChartArea.MarginTop - LChartArea.MarginBottom;
  LWhiteBuf.Width := AArea.Right - AArea.Left - LChartArea.MarginLeft - LChartArea.MarginRight;
  //in this type of chart X axis - vertical (!)
  LTopFld := LChartArea.InnerIndentTop + LChartArea.Edge.Width;
  LLeftFld := LChartArea.InnerIndentLeft + LChartArea.Edge.Width;
  LRightFld := LChartArea.InnerIndentRight + LChartArea.Edge.Width;
  LBottomFld := LChartArea.InnerIndentBottom + LChartArea.Edge.Width;

  LTopFld := LTopFld + FChartDepth;
  LRightFld := LRightFld + FChartDepth;
  //without autoscale
  LCalcZ := LChartArea.YAxis.MaxValue - LChartArea.YAxis.MinValue;
  LCalcX := LCalcZ / LChartArea.YAxis.MajorStep; // step count
  with ABuffer.Canvas do
  begin
    //calculate max width of XAxis labels
    Font.Assign(LChartArea.XAxis.Font);
    LXLabelsWidth := 0;
    if AValues.ColCount > 0 then
      for i := 0 to AValues.ColCount - 1 do
        LXLabelsWidth := max(LXLabelsWidth, TextWidth(AValues.GetColumnsNames(i)));
    LXLabels := LLeftFld + 1;

    //XAxis ticks size
    LTickSz := 0;
    if (LChartArea.XAxis.MajorTick = ttOutside) or (LChartArea.XAxis.MajorTick = ttCross) then
      LTickSz := LChartArea.XAxis.MajorTickSize + 4;
    if (LChartArea.XAxis.MinorTick = ttOutside) or (LChartArea.XAxis.MinorTick = ttCross) then
      if LChartArea.XAxis.MinorTickSize > LTickSz then
        LTickSz := LChartArea.XAxis.MinorTickSize + 4;
    LLeftFld := LLeftFld + LTickSz;

    //calculate position of YAxis (in this type of chart - horizontal) (!)
    Font.Assign(LChartArea.XAxis.Font);
    LYLabelsHeight := TextHeight('0,0');
    LTickSz := 0;
    LYLabels := ABuffer.Height - LBottomFld - LYLabelsHeight;
    if (LChartArea.YAxis.MajorTick = ttOutside) or (LChartArea.YAxis.MajorTick = ttCross) then
      LTickSz := LChartArea.YAxis.MajorTickSize + 4;
    if (LChartArea.YAxis.MinorTick = ttOutside) or (LChartArea.YAxis.MinorTick = ttCross) then
      if LChartArea.YAxis.MinorTickSize > LTickSz then
        LTickSz := LChartArea.YAxis.MinorTickSize + 4;
    LBottomFld := LBottomFld + LTickSz;
    LYAxisStart.Y := ABuffer.Height - LBottomFld - LYLabelsHeight;
    LYAxisStart.X := LXLabelsWidth + LLeftFld + 1;
    LYAxisEnd.Y := ABuffer.Height - LBottomFld - LYLabelsHeight;
    LYAxisEnd.X := ABuffer.Width - 1 - LRightFld;

    //calc position of XAxis
    LXAxisStart.X := LYAxisStart.X + LChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.X - LYAxisStart.X, 0, LErrorBack);
    LXAxisStart.Y := LTopFld + 1;
    LXAxisEnd.X := LYAxisStart.X + LChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.X - LYAxisStart.X, 0, LErrorBack);
    LXAxisEnd.Y := LYAxisStart.Y;
    //draw planes
    LRectBack := Rect(LYAxisStart.X + FChartDepth, LxAxisStart.Y - FChartDepth, LYAxisEnd.X + FChartDepth, LYAxisEnd.Y - FChartDepth);
    FBackplaneFill.DrawBackground(ABuffer.Canvas, LRectBack);
    //draw X major grid
    LChartArea.MajorGridLineHorizontal.SetupCanvasPen(Pen);
    if LChartArea.MajorGridHorizontal then
    begin
      LTempVar := LXAxisEnd.Y - LXAxisStart.Y;
      if AValues.ColCount > 1 then
      begin
        for i := 0 to AValues.ColCount do
        begin
          LPositionOnAxis := Trunc(LTempVar * ((1 / AValues.ColCount) * i));
          DrawLine(LYAxisStart.X + FChartDepth, LXAxisEnd.Y - LPositionOnAxis - FChartDepth, LYAxisEnd.X + FChartDepth, LXAxisEnd.Y - LPositionOnAxis - FChartDepth, ABuffer.Canvas);
        end;
      end;
    end;

    //draw Y major grid
    LChartArea.MajorGridLineVertical.SetupCanvasPen(Pen);
    if LChartArea.MajorGridVertical then
    begin
      if LCalcX > 0 then
        for i := 0 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
        begin
          LPositionOnAxis := LChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.X - LYAxisStart.X, LChartArea.YAxis.MinValue + LChartArea.YAxis.MajorStep * i, LErrorBack);
          DrawLine(LYAxisStart.X + LPositionOnAxis + FChartDepth, LYAxisEnd.Y - FChartDepth, LYAxisStart.X + LPositionOnAxis + FChartDepth, LXAxisStart.Y - FChartDepth, ABuffer.Canvas);
        end;
    end;
  end;

  //bottom
  if FBottomPlaneFill.Style = cbsNone then
    ABuffer.Canvas.Brush.Style := bsClear
  else
    ABuffer.Canvas.Brush.Color := FBottomPlaneFill.SolidColor;
  FBottomPlaneLine.SetupCanvasPen(ABuffer.Canvas.Pen);
  Plane(ABuffer.Canvas, LYAxisStart, LYAxisEnd, FChartDepth, LPointArrBottom);
  FBottomPlaneFill.DrawBackgroundReg(ABuffer.Canvas, LPointArrBottom);
  //draw YAxis  major labels and ticks
  with ABuffer.Canvas do
  begin
    Brush.Style := bsClear;
    Font.Assign(LChartArea.YAxis.Font);
    if LCalcX > 0 then
      for i := 1 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
      begin
        LPositionOnAxis := LChartArea.YAxis.CalcPosFromBottom(LYAxisEnd.X - LYAxisStart.X, LChartArea.YAxis.MinValue + LChartArea.YAxis.MajorStep * i, LErrorBack);
        DrawXTick(ABuffer.Canvas,
          LYAxisStart.X + LPositionOnAxis,
          LYAxisEnd.Y,
          LChartArea.YAxis.MajorTickSize,
          LChartArea.YAxis.MajorTick,
          FLeftPlaneLine);
        LChartArea.MajorGridLineVertical.SetupCanvasPen(Pen);
        DrawLine(LYAxisStart.X + LPositionOnAxis, LYAxisEnd.Y, LYAxisStart.X + LPositionOnAxis + FChartDepth, LYAxisEnd.Y - FChartDepth, ABuffer.Canvas);
        labeldata := LChartArea.YAxis.MinValue + LChartArea.YAxis.MajorStep * i;
        if not Stacked then
        begin
          if (LChartArea.YAxis.ScaleBreak.Enabled) and (labeldata > LChartArea.YAxis.ScaleBreak.PositiveLowLimit) and
            ((LChartArea.YAxis.ScaleBreak.Appearance = sbaPositive) or (LChartArea.YAxis.ScaleBreak.Appearance = sbaBoth)) then
            labeldata := labeldata + LChartArea.YAxis.ScaleBreak.PositiveHighLimit - LChartArea.YAxis.ScaleBreak.PositiveLowLimit;
          if (LChartArea.YAxis.ScaleBreak.Enabled) and (labeldata < LChartArea.YAxis.ScaleBreak.NegativeLowLimit) and
            ((LChartArea.YAxis.ScaleBreak.Appearance = sbaNegative) or (LChartArea.YAxis.ScaleBreak.Appearance = sbaBoth)) then
            labeldata := labeldata + LChartArea.YAxis.ScaleBreak.NegativeHighLimit - LChartArea.YAxis.ScaleBreak.NegativeLowLimit;
        end;
        labeldata := Round(labeldata);
        TextOut((LYAxisStart.X + LPositionOnAxis) - TextWidth(labeldata) div 2,
          LYLabels,
          floattostr(labeldata) + AValues.ValIndicator);
      end;
  end;
  DrawPlaneLines(ABuffer.Canvas, true, LPointArrLeft, LPointArrBottom, LRectBack);
  LWhiteBuf.Canvas.Brush.Color := clWhite;
  LWhiteBuf.Canvas.Pen.Style := psClear;
  LWhiteBuf.Canvas.FillRect(LWhiteBuf.Canvas.ClipRect);
  LBlackBuf.Canvas.Brush.Color := clBlack;
  LBlackBuf.Canvas.Pen.Style := psClear;
  LBlackBuf.Canvas.FillRect(LBlackBuf.Canvas.ClipRect);
  if MultiRow then
  begin
    DrawMultiRowBarsNegative(LWhiteBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
    DrawMultiRowBarsNegative(LBlackBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
  end
  else
    if not FStacked then
    begin
      DrawBarsNegative(LWhiteBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
      DrawBarsNegative(LBlackBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
    end;
  DrawTransparency(ABuffer, LWhiteBuf, LBlackBuf, LChartArea.Shadow, LChartArea.ShadowColor, LChartArea.ShadowDepth, LChartArea.ShadowTransparency, FColumnsTransparency);
  //draw XAxis plane (left)
  if FLeftPlaneFill.Style = cbsNone then
    ABuffer.Canvas.Brush.Style := bsClear
  else
    ABuffer.Canvas.Brush.Color := FLeftPlaneFill.SolidColor;
  FLeftPlaneLine.SetupCanvasPen(ABuffer.Canvas.Pen);
  LMDChartUtils.Plane(ABuffer.Canvas, LXAxisStart, LXAxisEnd, FChartDepth, LPointArrLeft);
  FLeftPlaneFill.DrawBackgroundReg(ABuffer.Canvas, LPointArrLeft);
  //draw XAxis--------------
  with ABuffer.Canvas do
  begin

    Font.Assign(LChartArea.XAxis.Font);
    // length of X axis
    LTempVar := LXAxisEnd.Y - LXAxisStart.Y;
    //draw all ticks and labels
    brush.Style := bsClear;
    if AValues.ColCount > 1 then
    begin
      //major ticks
      for i := 0 to AValues.ColCount do
      begin
        LPositionOnAxis := Trunc(LTempVar * ((1 / AValues.ColCount) * i));
        DrawYTick(ABuffer.Canvas, LXAxisStart.X, LXAxisEnd.Y - LPositionOnAxis, LChartArea.XAxis.MajorTickSize, LChartArea.XAxis.MajorTick, FBottomPlaneLine);
      end;

      //minor ticks
      for i := 1 to AValues.ColCount * 2 do
      begin
        if not odd(i) then
          Continue;
        LPositionOnAxis := Trunc(LTempVar * ((1 / (AValues.ColCount * 2)) * i));
        DrawYTick(ABuffer.Canvas, LXAxisStart.X, LXAxisEnd.Y - LPositionOnAxis, LChartArea.XAxis.MinorTickSize, LChartArea.XAxis.MinorTick, FBottomPlaneLine);
      end;
      //labels
      j := 1;
      for i := 1 to AValues.ColCount * 2 do
      begin
        if not odd(i) then
          Continue;
        LPositionOnAxis := Trunc(LTempVar * ((1 / (AValues.ColCount * 2)) * i));
        if AValues.GetColumnsNames(j - 1) = '' then
          TextOut(LXLabels, LXAxisEnd.Y - LPositionOnAxis - TextHeight(IntToStr(j)) div 2, IntToStr(j))
        else
          TextOut(LXLabels, LXAxisEnd.Y - LPositionOnAxis - TextHeight(AValues.GetColumnsNames(j - 1)) div 2, AValues.GetColumnsNames(j - 1));
        j := j + 1;
      end;
    end;
  end;
  DrawPlaneLines(ABuffer.Canvas, false, LPointArrLeft, LPointArrBottom, LRectBack);
  //draw bars
  LWhiteBuf.Canvas.Brush.Color := clWhite;
  LWhiteBuf.Canvas.Pen.Style := psClear;
  LWhiteBuf.Canvas.FillRect(LWhiteBuf.Canvas.ClipRect);
  LBlackBuf.Canvas.Brush.Color := clBlack;
  LBlackBuf.Canvas.Pen.Style := psClear;
  LBlackBuf.Canvas.FillRect(LBlackBuf.Canvas.ClipRect);
  if MultiRow then
  begin
    DrawMultiRowBars(LWhiteBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
    DrawMultiRowBars(LBlackBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
  end
  else
    if FStacked then
    begin
      DrawBarsStacked(LWhiteBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
      DrawBarsStacked(LBlackBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
    end
    else
    begin
      DrawBars(LWhiteBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
      DrawBars(LBlackBuf.Canvas, AValues, LXAxisStart.Y, LXAxisEnd.Y, LYAxisStart.X, LYAxisEnd.X, LChartArea.YAxis, LChartArea.ShowMarkers);
    end;

  DrawTransparency(ABuffer, LWhiteBuf, LBlackBuf, LChartArea.Shadow, LChartArea.ShadowColor, LChartArea.ShadowDepth, LChartArea.ShadowTransparency, FColumnsTransparency);
  //after transp draw
  LWhiteBuf.Free;
  LBlackBuf.Free;
end;

procedure TLMDChartCTBar3D.DrawPlaneLines(ATarget: TCanvas; Negative: boolean; leftPoly: TPointsArr; bottomPoly: TPointsArr; backRect: TRect);
var
  tmpBottom, tmpBack: TPointsArr;
begin
  if not Negative then
  begin
    bottomPoly[0].X := bottomPoly[0].X + (bottomPoly[1].X - bottomPoly[0].X) div 2;
    bottomPoly[3].X := bottomPoly[3].X + (bottomPoly[2].X - bottomPoly[3].X) div 2;
    backRect.Left := backRect.Left + (backRect.Right - backRect.Left) div 2;
    tmpBottom := bottomPoly;
    tmpBack[0] := Point(backRect.Left, backRect.Bottom);
    tmpBack[1] := Point(backRect.Right, backRect.Bottom);
    tmpBack[2] := Point(backRect.Right, backRect.Top);
    tmpBack[3] := Point(backRect.Left, backRect.Top);
  end
  else
  begin
    bottomPoly[1].X := bottomPoly[1].X - (bottomPoly[1].X - bottomPoly[0].X) div 2;
    bottomPoly[2].X := bottomPoly[2].X - (bottomPoly[2].X - bottomPoly[3].X) div 2;
    backRect.Right := backRect.Right - (backRect.Right - backRect.Left) div 2;
    tmpBottom[0] := bottomPoly[1];
    tmpBottom[1] := bottomPoly[0];
    tmpBottom[2] := bottomPoly[3];
    tmpBottom[3] := bottomPoly[2];
    tmpBack[0] := Point(backRect.Right, backRect.Bottom);
    tmpBack[1] := Point(backRect.Left, backRect.Bottom);
    tmpBack[2] := Point(backRect.Left, backRect.Top);
    tmpBack[3] := Point(backRect.Right, backRect.Top);
  end;
  FBottomPlaneLine.SetupCanvasPen(ATarget.Pen);
  DrawLines(tmpBottom[0].x, tmpBottom[0].y, tmpBottom[1].x, tmpBottom[1].y, tmpBottom[2].x, tmpBottom[2].y, tmpBottom[3].x, tmpBottom[3].y, ATarget);
  FLeftPlaneLine.SetupCanvasPen(ATarget.Pen);
  ATarget.Polyline(LeftPoly);
  FBackPlaneLine.SetupCanvasPen(ATarget.Pen);
  DrawLines(tmpBack[0].x, tmpBack[0].y - 1, tmpBack[1].x, tmpBack[1].y - 1, tmpBack[2].x, tmpBack[2].y, tmpBack[3].x, tmpBack[3].y, ATarget);
end;

end.
