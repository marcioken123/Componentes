unit LMDChartCTColumn3D;
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
LMDChartCTColumn3d
----------------

Changes
-------
Last (15-June-2006)

###############################################################################}

interface

uses
  Windows, Variants, SysUtils, Types, Math, Graphics, Classes,
  LMDXML, LMDXMLNodeNames, LMDChartData, LMDChartTypes, LMDChartPersistent,
  LMDChartUtils, LMDChartAxis, LMDChartMarker, LMDChartLabel, LMDChartLine,
  LMDChartBackground, LMDChartScaleBreak;

type
  { *************** TLMDChartCTColumn3D **************************************** }
  /// <summary>
  /// A column 3d chart displays values and series groups as sets
  /// of vertical columns that are grouped by category. Values are
  /// represented by the height of the columns as measured by the y-axis.
  /// Category labels are displayed on the x-axis. Column charts are typically
  /// used to compare values between categories.
  /// </summary>
  TLMDChartCTColumn3D = class(TLMDChartCTAbstract)
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
    FBackPlaneLine: TLMDChartLine;
    FBottomPlaneLine: TLMDChartLine;
    FBottomPlaneFill: TLMDChartBackground;
    FLeftPlaneFill: TLMDChartBackground;
    FBottomZMajorGrid: TLMDChartLine;
    FBottomZMinorGrid: TLMDChartLine;
    FLeftZGrid: TLMDChartLine;
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
    procedure SetColumnsTransparency(Value: byte);
    procedure SetColumnsLabels(Value: TLMDChartLabel);
    procedure SetShowColumnsLabels(Value: boolean);
    procedure SetLabelsMargin(Value: integer);
    procedure SetLabelsXDeviation(Value: integer);
    procedure SetLabelsYDeviation(Value: integer);
    procedure SetChartDepth(Value: integer);
    procedure SetBottomPlaneLine(Value: TLMDChartLine);
    procedure SetLeftPlaneLine(Value: TLMDChartLine);
    procedure SetBackPlaneLine(Value: TLMDChartLine);
    procedure SetBottomPlaneFill(Value: TLMDChartBackground);
    procedure SetLeftPlaneFill(Value: TLMDChartBackground);
    procedure SetBottomZMajorGrid(Value: TLMDChartLine);
    procedure SetBottomZMinorGrid(Value: TLMDChartLine);
    procedure SetLeftZGrid(Value: TLMDChartLine);
    procedure SetMultiRow(Value: boolean);
    procedure SetMultiRowIndent(Value: integer);
    procedure SetShadedBoxes(Value: boolean);
    procedure SetNoEdge(Value: boolean);
    procedure SetStacked(Value: boolean);
    procedure SetFullStacked(Value: boolean);
    procedure SetBackPlaneFill(Value: TLMDChartBackground);
  protected
    procedure DrawColumns(ATarget: TCanvas; AValues: TLMDChartData;
      AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
      AShowMarkers: boolean);
    procedure DrawColumnsNegative(ATarget: TCanvas; AValues: TLMDChartData;
      AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
      AShowMarkers: boolean);
    procedure DrawMultiRowColumns(ATarget: TCanvas; AValues: TLMDChartData;
      AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
      AShowMarkers: boolean);
    procedure DrawMultiRowColumnsNegative(ATarget: TCanvas;
      AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer;
      AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
    procedure DrawPlaneLines(ATarget: TCanvas; Negative: boolean; leftPoly: TPointsArr; bottomPoly: TPointsArr; backRect: TRect; b, d, l: boolean);
  public
    procedure Assign(ASource: TPersistent); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>
    /// Draws object on canvas
    /// </summary>
    procedure Draw(ABuffer: TBitmap; AArea: TRect; AValues: TLMDChartData; AChartAr: TLMDChartPersistent); override;
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string); override;
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string); override;
    procedure DrawColumnsStacked(ATarget: TCanvas; AValues: TLMDChartData;
      AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
    function IsChanged: boolean; override;
    procedure NoChanged; override;
    procedure ResetMainOwner(AmainOwner: TPersistent); override;
  published
    property LabelsXDeviation: integer read FLabelsXDeviation write SetLabelsXDeviation default 0;
    property LabelsYDeviation: integer read FLabelsYDeviation write SetLabelsYDeviation default 0;
    property LabelsMargin: integer read FLabelsMargin write SetLabelsMargin default 4;
    property ShowColumnsLabels: boolean read FShowColumnsLabels write SetShowColumnsLabels default true;
    property ColumnsLabels: TLMDChartLabel read FColumnsLabels write SetColumnsLabels;
    property ColumnsTransparency: byte read FColumnsTransparency write SetColumnsTransparency default 200;
    property ColumnAutoSize: boolean read FColumnAutoSize write SetColumnAutoSize default true;
    property ColumnAutoSizeValue: integer read FColumnAutoSizeValue write SetColumnAutoSizeValue default 30;
    property ColumnCustomSize: integer read FColumnCustomSize write SetColumnCustomSize default 40;
    property ChartDepth: integer read FChartDepth write SetChartDepth default 100;
    property BottomPlaneLine: TLMDChartLine read FBottomPlaneLine write SetBottomPlaneLine;
    property BackPlaneLine: TLMDChartLine read FBackPlaneLine write SetBackPlaneLine;
    property BottomPlaneFill: TLMDChartBackground read FBottomPlaneFill write SetBottomPlaneFill;
    property LeftPlaneLine: TLMDChartLine read FLeftPlaneLine write SetLeftPlaneLine;
    property LeftPlaneFill: TLMDChartBackground read FLeftPlaneFill write SetLeftPlaneFill;
    property BottomZMajorGrid: TLMDChartLine read FBottomZMajorGrid write SetBottomZMajorGrid;
    property BottomZMinorGrid: TLMDChartLine read FBottomZMinorGrid write SetBottomZMinorGrid;
    property LeftZGrid: TLMDChartLine read FLeftZGrid write SetLeftZGrid;
    property MultiRow: boolean read FMultiRow write SetMultiRow default false;
    property MultiRowIndent: integer read FMultiRowIndent write SetMultiRowIndent default 5;
    property ShadedBoxes: boolean read FShadedBoxes write SetShadedBoxes default true;
    property NoEdge: boolean read FNoEdge write SetNoEdge default false;
    property Stacked: boolean read FStacked write SetStacked default false;
    property FullStacked: boolean read FFullStacked write SetFullStacked default false;
    property BackPlaneFill: TLMDChartBackground read FBackPlaneFill write SetBackPlaneFill;
  end;

implementation

uses
  LMDChartArea;

{ *********************** TLMDChartCTColumn3D ********************************** }
{ ----------------------- private -------------------------------------------- }

procedure TLMDChartCTColumn3D.SetColumnAutoSize(Value: boolean);
begin
  FColumnAutoSize := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetColumnAutoSizeValue(Value: integer);
begin
  FColumnAutoSizeValue := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTColumn3D.SetStacked(Value: boolean);
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

procedure TLMDChartCTColumn3D.SetFullStacked(Value: boolean);
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

procedure TLMDChartCTColumn3D.SetColumnCustomSize(Value: integer);
begin
  FColumnCustomSize := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetColumnsLabels(Value: TLMDChartLabel);
begin
  FColumnsLabels.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetColumnsTransparency(Value: byte);
begin
  FColumnsTransparency := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetShowColumnsLabels(Value: boolean);
begin
  FShowColumnsLabels := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetLabelsMargin(Value: integer);
begin
  FLabelsMargin := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetLabelsXDeviation(Value: integer);
begin
  FLabelsXDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetLabelsYDeviation(Value: integer);
begin
  FLabelsYDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetChartDepth(Value: integer);
begin
  FChartDepth := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetBottomPlaneLine(Value: TLMDChartLine);
begin
  FBottomPlaneLine.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetLeftPlaneLine(Value: TLMDChartLine);
begin
  FLeftPlaneLine.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetBackPlaneLine(Value: TLMDChartLine);
begin
  FBackPlaneLine.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetBottomPlaneFill(Value: TLMDChartBackground);
begin
  FBottomPlaneFill.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetLeftPlaneFill(Value: TLMDChartBackground);
begin
  FLeftPlaneFill.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetBottomZMajorGrid(Value: TLMDChartLine);
begin
  FBottomZMajorGrid.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetBottomZMinorGrid(Value: TLMDChartLine);
begin
  FBottomZMinorGrid.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetLeftZGrid(Value: TLMDChartLine);
begin
  FLeftZGrid.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetMultiRow(Value: boolean);
begin
  FMultiRow := Value;
  if Value = true then
  begin
    Stacked := false;
    FullStacked := false;
  end;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetMultiRowIndent(Value: integer);
begin
  FMultiRowIndent := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetShadedBoxes(Value: boolean);
begin
  FShadedBoxes := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetNoEdge(Value: boolean);
begin
  FNoEdge := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.SetBackPlaneFill(Value: TLMDChartBackground);
begin
  FBackPlaneFill := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ----------------------- protected ------------------------------------------ }

procedure TLMDChartCTColumn3D.DrawColumns(ATarget: TCanvas; AValues: TLMDChartData;
  AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  i, j: integer;
  LColumnPosition, LColumnWidth, LTempVar, LDelta, LPosx: integer;
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
      LColumnPosition := Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * i));
      //check column width
      if not FColumnAutoSize then
        LColumnWidth := FColumnCustomSize
      else
        LColumnWidth := (Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i + 1))) -
          Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i - 1))) - FColumnAutoSizeValue * 2)
          div AValues.RowCount;
      //draw column
      LPosx := (AStartX + LColumnPosition) - (AValues.RowCount * LColumnWidth div 2 - AValues.RowCount div 2);
      for j := 0 to AValues.RowCount - 1 do
      begin
        if not FNoEdge then
          AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen)
        else
          ATarget.Pen.Style := psClear;
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
            fp := AYAxis.ScaleBreak.PositiveLowLimit + Round(AYAxis.ScaleBreak.PositiveLowLimit / 20) * 2;
            lp := AYAxis.ScaleBreak.PositiveLowLimit + Round(AYAxis.ScaleBreak.PositiveLowLimit / 20);
          end;
        if loaddata > 0 then
        begin
          ATarget.Brush.Style := bsSolid;
          ATarget.Brush.Color := AValues.GetRowFill(j).SolidColor;

          if (AYAxis.ScaleBreak.Enabled) and (loaddata > AYAxis.ScaleBreak.PositiveLowLimit) and (AYAxis.ScaleBreak.Style3D <> sbt3DNone) then
          begin
            pStyle := ATarget.Pen.Style;
            bStyle := ATarget.Brush.Style;
            pCol := ATarget.Pen.Color;
            bCol := ATarget.Brush.Color;
            Box(ATarget, Rect(LPosX + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LTempVar) - FMultiRowIndent, LPosx + LColumnWidth + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LTempVar) - FMultiRowIndent), ChartDepth - FMultiRowIndent * 2, ShadedBoxes);

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
            Box(ATarget, Rect(LPosX + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LTempVar) - FMultiRowIndent, LPosx + LColumnWidth + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LTempVar) - FMultiRowIndent), ChartDepth - FMultiRowIndent * 2, false);

            ATarget.Pen.Style := pStyle;
            ATarget.Brush.Style := bStyle;
            ATarget.Pen.Color := pCol;
            ATarget.Brush.Color := bCol;
            Box(ATarget, Rect(LPosX + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - FMultiRowIndent, LPosx + LColumnWidth + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LTempVar) - FMultiRowIndent), ChartDepth - FMultiRowIndent * 2, ShadedBoxes);
          end
          else
            Box(ATarget, Rect(LPosX + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - FMultiRowIndent, LPosx + LColumnWidth + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LTempVar) - FMultiRowIndent), ChartDepth - FMultiRowIndent * 2, ShadedBoxes);

          if AShowMarkers then
            AValues.GetRowMarker(j).Draw(ATarget, trunc(LPosx + FMultiRowIndent + LColumnWidth / 2), AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - FMultiRowIndent);
          if FShowColumnsLabels then //draw  columns labels
            ColumnsLabels.Draw(ATarget, floattostr(labeldata),
              trunc(LPosx + FMultiRowIndent + LColumnWidth / 2) + FLabelsXDeviation,
              AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - FLabelsMargin + FLabelsYDeviation - FMultiRowIndent,
              claLeftBottom, clcHorizontal);
        end;
        LPosx := LPosx + LColumnWidth
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.DrawColumnsNegative(ATarget: TCanvas; AValues: TLMDChartData;
  AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  i, j: integer;
  LColumnPosition, LColumnWidth, LTempVar, LDelta, LPosx: integer;
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
      LColumnPosition := Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * i));
      //check column width
      if not FColumnAutoSize then
        LColumnWidth := FColumnCustomSize
      else
        LColumnWidth := (Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i + 1))) -
          Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * (i - 1))) - FColumnAutoSizeValue * 2)
          div AValues.RowCount;
      //draw column
      LPosx := (AStartX + LColumnPosition) - (AValues.RowCount * LColumnWidth div 2 - AValues.RowCount div 2);

      for j := 0 to AValues.RowCount - 1 do
      begin
        if not FNoEdge then
          AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen)
        else
          ATarget.Pen.Style := psClear;
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
            fp := AYAxis.ScaleBreak.NegativeLowLimit + Round(AYAxis.ScaleBreak.NegativeLowLimit / 20);
            lp := AYAxis.ScaleBreak.NegativeLowLimit + Round(AYAxis.ScaleBreak.NegativeLowLimit / 20) * 2;
          end;
        if loaddata < 0 then
        begin
          ATarget.Brush.Style := bsSolid;
          ATarget.Brush.Color := AValues.GetRowFill(j).SolidColor;
          if (AYAxis.ScaleBreak.Enabled) and (loaddata < AYAxis.ScaleBreak.NegativeLowLimit) and (AYAxis.ScaleBreak.Style3D <> sbt3DNone) then
          begin
            pStyle := ATarget.Pen.Style;
            bStyle := ATarget.Brush.Style;
            pCol := ATarget.Pen.Color;
            bCol := ATarget.Brush.Color;
            Box(ATarget, Rect(LPosx + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LTempVar) - FMultiRowIndent, LPosx + LColumnWidth + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - FMultiRowIndent), ChartDepth - FMultiRowIndent * 2, ShadedBoxes);

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
            Box(ATarget, Rect(LPosx + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LTempVar) - FMultiRowIndent, LPosx + LColumnWidth + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LTempVar) - FMultiRowIndent), ChartDepth - FMultiRowIndent * 2, false);

            ATarget.Pen.Style := pStyle;
            ATarget.Brush.Style := bStyle;
            ATarget.Pen.Color := pCol;
            ATarget.Brush.Color := bCol;
            Box(ATarget, Rect(LPosx + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LTempVar) - FMultiRowIndent, LPosx + LColumnWidth + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LTempVar) - FMultiRowIndent), ChartDepth - FMultiRowIndent * 2, ShadedBoxes);

          end
          else
            Box(ATarget, Rect(LPosx + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LTempVar) - FMultiRowIndent, LPosx + LColumnWidth + FMultiRowIndent, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - FMultiRowIndent), ChartDepth - FMultiRowIndent * 2, ShadedBoxes);

          if AShowMarkers then
            AValues.GetRowMarker(j).Draw(ATarget, trunc(LPosx + FMultiRowIndent + LColumnWidth / 2), AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - FMultiRowIndent);
          if FShowColumnsLabels then //draw  columns labels
            ColumnsLabels.Draw(ATarget, floattostr(labeldata), trunc(LPosx + FMultiRowIndent + LColumnWidth / 2) + FLabelsXDeviation, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) + FLabelsMargin - FLabelsYDeviation - FMultiRowIndent, claLeftTop, clcHorizontal);
        end;
        LPosx := LPosx + LColumnWidth
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.DrawMultiRowColumns(ATarget: TCanvas;
  AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer;
  AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  i, j, LColumnDepth, LGoodIndent: integer;
  LColumnPosition, LColumnWidth, LTempVar, LDelta, LPosX, LPosZ: integer;
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
  LColumnDepth := (ChartDepth div AValues.RowCount) - (MultiRowIndent * 2);

  if LColumnDepth <= 0 then
    exit;
  LPosZ := ChartDepth;

  for j := AValues.RowCount - 1 downto 0 do
  begin
    LPosZ := LPosZ - MultiRowIndent - LColumnDepth;
    for i := 0 to (AValues.ColCount * 2) - 1 do
    begin
      if not odd(i) then
        Continue;
      LColumnPosition := Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * i));
      //check column width
      if not FColumnAutoSize then
        LColumnWidth := FColumnCustomSize
      else
        LColumnWidth := 40;
      //draw column
      LPosX := (AStartX + LColumnPosition) - LColumnWidth div 2;
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
          fp := AYAxis.ScaleBreak.PositiveLowLimit + Round(AYAxis.ScaleBreak.PositiveLowLimit / 20) * 2;
          lp := AYAxis.ScaleBreak.PositiveLowLimit + Round(AYAxis.ScaleBreak.PositiveLowLimit / 20);
        end;
      if loaddata > 0 then
      begin
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := AValues.GetRowFill(j).SolidColor;
        if not FNoEdge then
          AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen)
        else
          ATarget.Pen.Style := psClear;

        if (AYAxis.ScaleBreak.Enabled) and (loaddata > AYAxis.ScaleBreak.PositiveLowLimit) and (AYAxis.ScaleBreak.Style3D <> sbt3DNone) then
        begin
          pStyle := ATarget.Pen.Style;
          bStyle := ATarget.Brush.Style;
          pCol := ATarget.Pen.Color;
          bCol := ATarget.Brush.Color;
          Box(ATarget, Rect(LPosX + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LTempVar) - LPosZ, LPosx + LColumnWidth + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LTempVar) - LPosZ), LColumnDepth, ShadedBoxes);

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
          Box(ATarget, Rect(LPosX + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LTempVar) - LPosZ, LPosx + LColumnWidth + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LTempVar) - LPosZ), LColumnDepth, false);

          ATarget.Pen.Style := pStyle;
          ATarget.Brush.Style := bStyle;
          ATarget.Pen.Color := pCol;
          ATarget.Brush.Color := bCol;
          Box(ATarget, Rect(LPosX + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - LPosZ, LPosx + LColumnWidth + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LTempVar) - LPosZ), LColumnDepth, ShadedBoxes);
        end
        else
          Box(ATarget, Rect(LPosX + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - LPosZ, LPosx + LColumnWidth + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LTempVar) - LPosZ), LColumnDepth, ShadedBoxes);

        if AShowMarkers then
          AValues.GetRowMarker(j).Draw(ATarget, trunc(LPosx + LPosZ + LColumnWidth / 2), AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - LPosZ);
        if FShowColumnsLabels then
          ColumnsLabels.Draw(ATarget, floattostr(labeldata),
            LPosX + LPosZ + LColumnDepth div 2 + LColumnWidth div 2 + FLabelsXDeviation,
            AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - FLabelsMargin + FLabelsYDeviation - LPosZ - LColumnDepth div 2,
            claLeftBottom, clcHorizontal);
      end;

    end;
    LPosZ := LPosZ - MultiRowIndent;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.DrawMultiRowColumnsNegative(ATarget: TCanvas;
  AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer;
  AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  i, j, LColumnDepth, LGoodIndent: integer;
  LColumnPosition, LColumnWidth, LTempVar, LDelta, LPosX, LPosZ: integer;
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
  if (AValues.ColCount <= 0) or (AValues.RowCount <= 0) then
    exit;

  LGoodIndent := (ChartDepth div AValues.RowCount - 1) div 2;
  if MultiRowIndent > LGoodIndent then
    FMultiRowIndent := LGoodIndent;
  LColumnDepth := (ChartDepth div AValues.RowCount) - (MultiRowIndent * 2);

  if LColumnDepth <= 0 then
    exit;
  LPosZ := ChartDepth;

  for j := AValues.RowCount - 1 downto 0 do
  begin
    LPosZ := LPosZ - MultiRowIndent - LColumnDepth;
    for i := 0 to (AValues.ColCount * 2) - 1 do
    begin
      if not odd(i) then
        Continue;
      LColumnPosition := Trunc(LDelta * ((1 / (AValues.ColCount * 2)) * i));
      //check column width
      if not FColumnAutoSize then
        LColumnWidth := FColumnCustomSize
      else
        LColumnWidth := 40; //
      //draw column
      LPosX := (AStartX + LColumnPosition) - LColumnWidth div 2;
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
          fp := AYAxis.ScaleBreak.NegativeLowLimit + round(AYAxis.ScaleBreak.NegativeLowLimit / 20);
          lp := AYAxis.ScaleBreak.NegativeLowLimit + round(AYAxis.ScaleBreak.NegativeLowLimit / 20) * 2;
        end;
      if loaddata < 0 then
      begin
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := AValues.GetRowFill(j).SolidColor;
        if not FNoEdge then
          AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen)
        else
          ATarget.Pen.Style := psClear;
        if (AYAxis.ScaleBreak.Enabled) and (loaddata < AYAxis.ScaleBreak.NegativeLowLimit) and (AYAxis.ScaleBreak.Style3D <> sbt3DNone) then
        begin
          pStyle := ATarget.Pen.Style;
          bStyle := ATarget.Brush.Style;
          pCol := ATarget.Pen.Color;
          bCol := ATarget.Brush.Color;
          Box(ATarget, Rect(LPosX + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LTempVar) - LPosZ, LPosx + LColumnWidth + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - LPosZ), LColumnDepth, ShadedBoxes);

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
          Box(ATarget, Rect(LPosX + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LTempVar) - LPosZ, LPosx + LColumnWidth + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, lp, LTempVar) - LPosZ), LColumnDepth, false);

          ATarget.Pen.Style := pStyle;
          ATarget.Brush.Style := bStyle;
          ATarget.Pen.Color := pCol;
          ATarget.Brush.Color := bCol;
          Box(ATarget, Rect(LPosX + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LTempVar) - LPosZ, LPosx + LColumnWidth + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, fp, LTempVar) - LPosZ), LColumnDepth, ShadedBoxes);

        end
        else
          Box(ATarget, Rect(LPosX + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LTempVar) - LPosZ, LPosx + LColumnWidth + LPosZ, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - LPosZ), LColumnDepth, ShadedBoxes);

        if AShowMarkers then
          AValues.GetRowMarker(j).Draw(ATarget, trunc(LPosx + LPosZ + LColumnWidth / 2), AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) - LPosZ);
        if FShowColumnsLabels then
          ColumnsLabels.Draw(ATarget, floattostr(labeldata), LPosX + LPosZ + LColumnDepth div 2 + LColumnWidth div 2 + FLabelsXDeviation, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) + FLabelsMargin - FLabelsYDeviation - FMultiRowIndent - LPosZ, claLeftTop, clcHorizontal);
      end;

    end;
    LPosZ := LPosZ - MultiRowIndent;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.DrawColumnsStacked(ATarget: TCanvas; AValues: TLMDChartData;
  AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  i, j, k: integer;
  LColumnPosition, LColumnWidth, LErrorBack, LDelta, LPosx: integer;
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
        LPosX := (AStartX + LColumnPosition) - LColumnWidth div 2;
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

            ColorB := ATarget.Brush.Color;
            if (FShadedBoxes) then
              ShadowColorV := ShadowColor(ATarget.Brush.Color, 100)
            else
              ShadowColorV := ColorB;
            if (FNoEdge) then
              ColorP := ShadowColor(ATarget.Brush.Color, 100)
            else
              ColorP := ATarget.Pen.Color;

            if ((k <> 0) and (k <> FChartDepth)) or (FNoEdge) then
              ATarget.Pen.Color := ShadowColorV
            else
              ATarget.Pen.Color := ColorP;
            if k <> 0 then
              ATarget.Brush.Color := ShadowColorV
            else
              ATarget.Brush.Color := ColorB;

            AValues.GetRowFill(j).DrawRectangle(ATarget,
              AValues.GetRowsLines(j),
              LPosX + k,
              AEndY - k - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation, LErrorBack),
              LPosX + k + LColumnWidth,
              AEndY - k - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack) + 1
              );
            if FShowColumnsLabels then
              ColumnsLabels.Draw(ATarget, floattostr(loaddata), LPosX + LColumnWidth div 2 + FLabelsXDeviation,
                AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata / 2 + FLabelsMargin - FLabelsYDeviation, LErrorBack)

                , claLeftTop, clcHorzVert);
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
              ColorP := ShadowColor(BGBuf.SolidColor, 100)
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
              LPosX + k,
              AEndY - k - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack),
              LPosX + k + LColumnWidth,
              AEndY - k - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation, LErrorBack) + 1
              );
            if (not NoEdge) then
              ATarget.Pixels[LPosX + k, AEndY - k - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack)] := ColorP;
            if (not NoEdge) then
              ATarget.Pixels[LPosX + k + LColumnWidth, AEndY - k - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation, LErrorBack)] := ColorP;
            if (not NoEdge) then
              ATarget.Pixels[LPosX + k + LColumnWidth, AEndY - k - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack)] := ColorP;
            if FShowColumnsLabels then
              ColumnsLabels.Draw(ATarget, floattostr(loaddata), LPosX + LColumnWidth div 2 + FLabelsXDeviation,
                AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata / 2 + FLabelsMargin - FLabelsYDeviation, LErrorBack)

                , claLeftTop, clcHorzVert);
            LAccomulation := LAccomulation + loaddata * Factors[i div 2];
            BGBuf.Free;
            LineBuf.Free;
          end;
        end;

      end;

    end;
  end; // for k
end;

{ ----------------------- public --------------------------------------------- }

function TLMDChartCTColumn3D.IsChanged: boolean;
begin
  if FColumnsLabels.IsChanged then
    FChanged := true;
  if FLeftPlaneLine.IsChanged then
    FChanged := true;
  if FBackPlaneLine.IsChanged then
    FChanged := true;
  if FBottomPlaneLine.IsChanged then
    FChanged := true;
  if FBottomPlaneFill.IsChanged then
    FChanged := true;
  if FLeftPlaneFill.IsChanged then
    FChanged := true;
  if FBottomZMajorGrid.IsChanged then
    FChanged := true;
  if FBottomZMinorGrid.IsChanged then
    FChanged := true;
  if FLeftZGrid.IsChanged then
    FChanged := true;
  if FBackPlaneFill.IsChanged then
    FChanged := true;
  IsChanged := FChanged;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTColumn3D.NoChanged;
begin
  FChanged := false;
  FColumnsLabels.NoChanged;
  FLeftPlaneLine.NoChanged;
  FBackPlaneLine.NoChanged;
  FBottomPlaneLine.NoChanged;
  FBottomPlaneFill.NoChanged;
  FLeftPlaneFill.NoChanged;
  FBottomZMajorGrid.NoChanged;
  FBottomZMinorGrid.NoChanged;
  FLeftZGrid.NoChanged;
  FBackPlaneFill.NoChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.ResetMainOwner(AmainOwner: TPersistent);
begin
  FMainOwner := AMainOwner;
  FColumnsLabels.ResetOwner(FMainOwner);
  FLeftPlaneLine.ResetOwner(FMainOwner);
  FBackPlaneLine.ResetOwner(FMainOwner);
  FBottomPlaneLine.ResetOwner(FMainOwner);
  FBottomPlaneFill.ResetOwner(FMainOwner);
  FLeftPlaneFill.ResetOwner(FMainOwner);
  FBottomZMajorGrid.ResetOwner(FMainOwner);
  FBottomZMinorGrid.ResetOwner(FMainOwner);
  FLeftZGrid.ResetOwner(FMainOwner);
  FBackPlaneFill.ResetOwner(FMainOwner);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn3D.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNCTColumn3D + NNSpace + Comment);

  FColumnsLabels.LoadStateFromXML(WorkNode, '');
  FLeftPlaneLine.LoadStateFromXML(WorkNode, 'LeftPlaneLine');
  FBottomPlaneLine.LoadStateFromXML(WorkNode, 'BottomPlaneLine');
  FBottomPlaneFill.LoadStateFromXML(WorkNode, 'BottomPlaneFill');
  FLeftPlaneFill.LoadStateFromXML(WorkNode, 'LeftPlaneFill');
  FBottomZMajorGrid.LoadStateFromXML(WorkNode, 'BottomZMajorGrid');
  FBottomZMinorGrid.LoadStateFromXML(WorkNode, 'BottomZMinorGrid');
  FLeftZGrid.LoadStateFromXML(WorkNode, 'LeftZGrid');

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

procedure TLMDChartCTColumn3D.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  IterNode := BaseNode.AppendElement('ChartType');
  IterNode.SetVarAttr('value', Variant(ChartColumn3DID));

  WorkNode := BaseNode.EnsureChild(NNCTColumn3D + NNSpace + Comment);

  FColumnsLabels.SaveStateToXML(WorkNode, '');
  FLeftPlaneLine.SaveStateToXML(WorkNode, 'LeftPlaneLine');
  FBottomPlaneLine.SaveStateToXML(WorkNode, 'BottomPlaneLine');
  FBottomPlaneFill.SaveStateToXML(WorkNode, 'BottomPlaneFill');
  FLeftPlaneFill.SaveStateToXML(WorkNode, 'LeftPlaneFill');
  FBottomZMajorGrid.SaveStateToXML(WorkNode, 'BottomZMajorGrid');
  FBottomZMinorGrid.SaveStateToXML(WorkNode, 'BottomZMinorGrid');
  FLeftZGrid.SaveStateToXML(WorkNode, 'LeftZGrid');

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

procedure TLMDChartCTColumn3D.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartCTColumn3D then
  begin
    try
      FColumnsLabels.Assign(TLMDChartCTColumn3D(ASource).FColumnsLabels);
      FShowColumnsLabels := TLMDChartCTColumn3D(ASource).FShowColumnsLabels;
      ColumnsTransparency := TLMDChartCTColumn3D(ASource).FColumnsTransparency;
      FColumnAutoSize := TLMDChartCTColumn3D(ASource).FColumnAutoSize;
      FColumnAutoSizeValue := TLMDChartCTColumn3D(ASource).ColumnAutoSizeValue;
      FColumnCustomSize := TLMDChartCTColumn3D(ASource).ColumnCustomSize;
      FLabelsYDeviation := TLMDChartCTColumn3D(ASource).FLabelsYDeviation;
      FLabelsXDeviation := TLMDChartCTColumn3D(ASource).FLabelsXDeviation;
      FLabelsMargin := TLMDChartCTColumn3D(ASource).FLabelsMargin;
      FChartDepth := TLMDChartCTColumn3D(ASource).FChartDepth;
      FShadedBoxes := TLMDChartCTColumn3D(ASource).FShadedBoxes;
      FLeftPlaneLine.Assign(TLMDChartCTColumn3D(ASource).FLeftPlaneLine);
      FBackPlaneLine.Assign(TLMDChartCTColumn3D(ASource).FBackPlaneLine);
      FBottomPlaneLine.Assign(TLMDChartCTColumn3D(ASource).FBottomPlaneLine);
      FLeftPlaneFill.Assign(TLMDChartCTColumn3D(ASource).FLeftPlaneFill);
      FBottomPlaneFill.Assign(TLMDChartCTColumn3D(ASource).FBottomPlaneFill);
      FBottomZMajorGrid.Assign(TLMDChartCTColumn3D(ASource).FBottomZMajorGrid);
      FBottomZMinorGrid.Assign(TLMDChartCTColumn3D(ASource).FBottomZMinorGrid);
      FLeftZGrid.Assign(TLMDChartCTColumn3D(ASource).FLeftZGrid);
      FNoEdge := TLMDChartCTColumn3D(ASource).FNoEdge;
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartCTColumn3D.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBottomZMajorGrid := TLMDChartLine.Create(AOwner);
  FBottomZMinorGrid := TLMDChartLine.Create(AOwner);
  FLeftZGrid := TLMDChartLine.Create(AOwner);
  FColumnsLabels := TLMDChartLabel.Create(AOwner);
  FLeftPlaneLine := TLMDChartLine.Create(AOwner);
  FBackPlaneLine := TLMDChartLine.Create(AOwner);
  FBottomPlaneLine := TLMDChartLine.Create(AOwner);
  FLeftPlaneFill := TLMDChartBackground.Create(AOwner);
  FBottomPlaneFill := TLMDChartBackground.Create(AOwner);
  FBackPlaneFill := TLMDChartBackground.Create(AOwner);
  //default
  FShowColumnsLabels := true;
  FColumnAutoSize := true;
  FColumnAutoSizeValue := 30;
  FColumnCustomSize := 40;
  FColumnsTransparency := 200;
  FLabelsMargin := 4;
  FLabelsYDeviation := 0;
  FLabelsXDeviation := 0;
  ChartDepth := 100;
  MultiRow := false;
  MultiRowIndent := 5;
  ShadedBoxes := true;
  NoEdge := false;
  FStacked := false;
  FFullStacked := false;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartCTColumn3D.Destroy;
begin
  FBottomZMajorGrid.Free;
  FBottomZMinorGrid.Free;
  FLeftZGrid.Free;
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

procedure TLMDChartCTColumn3D.Draw(ABuffer: TBitmap; AArea: TRect; AValues: TLMDChartData; AChartAr: TLMDChartPersistent);
var
  LLeftFld, LTopFld, LBottomFld, LRightFld: integer;
  i, j, LCalculationTempVar1, LPositionOnAxis, LErrorBack, LYLabes, LXLabes: integer;
  LXAxisStart, LXAxisEnd: TPoint;
  LYAxisStart, LYAxisEnd: TPoint;
  LCalcZ, LCalcX: real;
  LTickSz: integer;
  LChArea: TLMDChartArea;
  LBlackBuf, LWhiteBuf: TBitmap;
  LPointArrBottom: TPointsArr;
  LPointArrLeft: TPointsArr;
  labeldata: variant;
  LRectBack: TRect;
begin
  inherited;
  LChArea := TLMDChartArea(AChartAr);
  if Stacked then
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
  LTopFld := LChArea.InnerIndentTop + LChArea.Edge.Width;
  LLeftFld := LChArea.InnerIndentLeft + LChArea.Edge.Width;
  LRightFld := LChArea.InnerIndentRight + LChArea.Edge.Width;
  LBottomFld := LChArea.InnerIndentBottom + LChArea.Edge.Width;
  LTopFld := LTopFld + FChartDepth;
  LRightFld := LRightFld + FChartDepth;
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
    LCalculationTempVar1 := TextWidth(floatToStr(LChArea.YAxis.MinValue));
    if LCalcX > 0 then
      for i := 1 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
      begin
        LCalculationTempVar1 := Max(LCalculationTempVar1, TextWidth(floatToStr(LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i)))
      end;
    LCalculationTempVar1 := LCalculationTempVar1 + 4;
    LYLabes := LLeftFld - LTickSz;
    LLeftFld := LLeftFld + LCalculationTempVar1;
    //calc max heigth XAxis labels
    Font.Assign(LChArea.XAxis.Font);
    LBottomFld := LBottomFld + TextHeight('1') + 2;
    LXLabes := ABuffer.Height - 1 - LBottomFld + 2;

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

    //draw back
     //draw back
    LRectBack := Rect(LYAxisStart.X + FChartDepth, LYAxisStart.Y - FChartDepth, LXAxisEnd.X + FChartDepth, LYAxisEnd.Y - FChartDepth);
    FBackPlaneFill.DrawBackground(ABuffer.Canvas, LRectBack);
    //draw planes
      //left
    if FLeftPlaneFill.Style = cbsNone then
      ABuffer.Canvas.Brush.Style := bsClear
    else
      ABuffer.Canvas.Brush.Color := FLeftPlaneFill.SolidColor;
    FLeftPlaneLine.SetupCanvasPen(ABuffer.Canvas.Pen);
    LMDChartUtils.Plane(ABuffer.Canvas, LYAxisStart, LYAxisEnd, FChartDepth, LPointArrLeft);
    FLeftPlaneFill.DrawBackgroundReg(ABuffer.Canvas, LPointArrLeft);
    ABuffer.Canvas.Brush.Style := bsClear;
    //draw Y major grid
    LChArea.MajorGridLineHorizontal.SetupCanvasPen(Pen);
    if LChArea.MajorGridHorizontal then
    begin
      if LCalcX > 0 then
        for i := 0 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
        begin
          LPositionOnAxis := LChArea.YAxis.CalcPosFromBottom(LYAxisEnd.Y - LYAxisStart.Y, LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i, LErrorBack);
          DrawLine(LYAxisStart.X + 1 + FChartDepth, LYAxisEnd.Y - LPositionOnAxis - FChartDepth, LXAxisEnd.X + FChartDepth, LYAxisEnd.Y - LPositionOnAxis - FChartDepth, ABuffer.Canvas);
        end;
    end;
    //draw X major grid
    LChArea.MajorGridLineVertical.SetupCanvasPen(Pen);
    if LChArea.MajorGridVertical then
    begin
      LCalculationTempVar1 := LXAxisEnd.X - LXAxisStart.X;
      if AValues.ColCount > 1 then
      begin
        for i := 0 to AValues.ColCount do
        begin
          LPositionOnAxis := Trunc(LCalculationTempVar1 * ((1 / AValues.ColCount) * i));
          BottomZMajorGrid.SetupCanvasPen(ABuffer.Canvas.Pen);
          DrawLine(LXAxisStart.X + LPositionOnAxis + FChartDepth, LYAxisEnd.Y - FChartDepth, LXAxisStart.X + LPositionOnAxis + FChartDepth, LYAxisStart.Y - FChartDepth, ABuffer.Canvas);
        end;
      end;
    end;
    //draw YAxis--------------
    Font.Assign(LChArea.YAxis.Font);
    //draw YAxis  major labels and ticks
    Brush.Style := bsClear;
    if LCalcX > 0 then
      for i := 0 to Trunc(StrToFloat(FloatToStr(LCalcX))) - 1 do
      begin
        LPositionOnAxis := LChArea.YAxis.CalcPosFromBottom(LYAxisEnd.Y - LYAxisStart.Y, LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i, LErrorBack);
        DrawYTick(ABuffer.Canvas, LYAxisStart.X, LYAxisEnd.Y - LPositionOnAxis, LChArea.YAxis.MajorTickSize, LChArea.YAxis.MajorTick, FLeftPlaneLine);
        //draw z grid of y axis
        LeftZGrid.SetupCanvasPen(ABuffer.Canvas.Pen);
        Line(ABuffer.Canvas, Point(LYAxisStart.X, LYAxisEnd.Y - LPositionOnAxis), FChartDepth);
        //labels
        labeldata := LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i;
        if not Stacked then
        begin
          if (LChArea.YAxis.ScaleBreak.Enabled) and (labeldata > LChArea.YAxis.ScaleBreak.PositiveLowLimit) and
            ((LChArea.YAxis.ScaleBreak.Appearance = sbaPositive) or (LChArea.YAxis.ScaleBreak.Appearance = sbaBoth)) then
            labeldata := labeldata + LChArea.YAxis.ScaleBreak.PositiveHighLimit - LChArea.YAxis.ScaleBreak.PositiveLowLimit;
          if (LChArea.YAxis.ScaleBreak.Enabled) and (labeldata < LChArea.YAxis.ScaleBreak.NegativeLowLimit) and
            ((LChArea.YAxis.ScaleBreak.Appearance = sbaNegative) or (LChArea.YAxis.ScaleBreak.Appearance = sbaBoth)) then
            labeldata := labeldata + LChArea.YAxis.ScaleBreak.NegativeHighLimit - LChArea.YAxis.ScaleBreak.NegativeLowLimit;
        end;
        labeldata := Round(labeldata);
        TextOut(LYLabes - 15, (LYAxisEnd.Y - LPositionOnAxis) - TextHeight(labeldata) div 2, floattostr(labeldata) + AValues.ValIndicator);
      end;
  end;

  DrawPlaneLines(ABuffer.Canvas, true, LPointArrLeft, LPointArrBottom, LRectBack, false, false, true);
  DrawPlaneLines(ABuffer.Canvas, false, LPointArrLeft, LPointArrBottom, LRectBack, false, false, true);
  DrawPlaneLines(ABuffer.Canvas, true, LPointArrLeft, LPointArrBottom, LRectBack, true, false, false);
  DrawPlaneLines(ABuffer.Canvas, false, LPointArrLeft, LPointArrBottom, LRectBack, true, false, false);

  LWhiteBuf.Canvas.Brush.Color := clWhite;
  LWhiteBuf.Canvas.Pen.Style := psClear;
  LWhiteBuf.Canvas.FillRect(LWhiteBuf.Canvas.ClipRect);
  LBlackBuf.Canvas.Brush.Color := clBlack;
  LBlackBuf.Canvas.Pen.Style := psClear;
  LBlackBuf.Canvas.FillRect(LBlackBuf.Canvas.ClipRect);
  if MultiRow then
  begin
    DrawMultiRowColumnsNegative(LWhiteBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
    DrawMultiRowColumnsNegative(LBlackBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
  end
  else
    if not FStacked then
    begin
      DrawColumnsNegative(LWhiteBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
      DrawColumnsNegative(LBlackBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
    end;
  DrawTransparency(ABuffer, LWhiteBuf, LBlackBuf, LChArea.Shadow, LChArea.ShadowColor, LChArea.ShadowDepth, LChArea.ShadowTransparency, FColumnsTransparency);
  //draw bottom plane
  if FBottomPlaneFill.Style = cbsNone then
    ABuffer.Canvas.Brush.Style := bsClear
  else
    ABuffer.Canvas.Brush.Color := FBottomPlaneFill.SolidColor;
  FBottomPlaneLine.SetupCanvasPen(ABuffer.Canvas.Pen);
  LMDChartUtils.Plane(ABuffer.Canvas, LXAxisStart, LXAxisEnd, FChartDepth, LPointArrBottom);
  FBottomPlaneFill.DrawBackgroundReg(ABuffer.Canvas, LPointArrBottom);
  //draw XAxis--------------
  with ABuffer.Canvas do
  begin
    Font.Assign(LChArea.XAxis.Font);
    // length of x axis
    LCalculationTempVar1 := LXAxisEnd.X - LXAxisStart.X;
    //draw all ticks and labels
    brush.Style := bsClear;
    if AValues.ColCount > 1 then
    begin
      //major ticks
      for i := 0 to AValues.ColCount do
      begin
        LPositionOnAxis := Trunc(LCalculationTempVar1 * ((1 / AValues.ColCount) * i));
        //draw z grid on x axis
        BottomZMajorGrid.SetupCanvasPen(ABuffer.Canvas.Pen);
        Line(ABuffer.Canvas, Point(LXAxisStart.X + LPositionOnAxis, LXAxisStart.Y), FChartDepth);
        //draw tick
        DrawXTick(ABuffer.Canvas, LXAxisStart.X + LPositionOnAxis, LXAxisStart.Y, LChArea.XAxis.MajorTickSize, LChArea.XAxis.MajorTick, FBottomPlaneLine);
      end;
      //minor ticks
      for i := 1 to AValues.ColCount * 2 do
      begin
        if not odd(i) then
          Continue;
        LPositionOnAxis := Trunc(LCalculationTempVar1 * ((1 / (AValues.ColCount * 2)) * i));
        //draw z grid on x axis
        BottomZMinorGrid.SetupCanvasPen(ABuffer.Canvas.Pen);
        Line(ABuffer.Canvas, Point(LXAxisStart.X + LPositionOnAxis, LXAxisStart.Y), FChartDepth);
        //draw tick
        DrawXTick(ABuffer.Canvas, LXAxisStart.X + LPositionOnAxis, LXAxisStart.Y, LChArea.XAxis.MinorTickSize, LChArea.XAxis.MinorTick, FBottomPlaneLine);
      end;
      //labels
      j := 1;
      for i := 1 to AValues.ColCount * 2 do
      begin
        if not odd(i) then
          Continue;
        LPositionOnAxis := Trunc(LCalculationTempVar1 * ((1 / (AValues.ColCount * 2)) * i));
        if AValues.GetColumnsNames(j - 1) = '' then
          TextOut(LXAxisStart.X + LPositionOnAxis - TextWidth(IntToStr(j)) div 2, LXLabes, IntToStr(j))
        else
          TextOut(LXAxisStart.X + LPositionOnAxis - TextWidth(AValues.GetColumnsNames(j - 1)) div 2, LXLabes, AValues.GetColumnsNames(j - 1));
        j := j + 1;
      end;
    end;
  end;
  DrawPlaneLines(ABuffer.Canvas, true, LPointArrLeft, LPointArrBottom, LRectBack, false, true, false);
  DrawPlaneLines(ABuffer.Canvas, false, LPointArrLeft, LPointArrBottom, LRectBack, false, true, false);
  LWhiteBuf.Canvas.Brush.Color := clWhite;
  LWhiteBuf.Canvas.Pen.Style := psClear;
  LWhiteBuf.Canvas.FillRect(LWhiteBuf.Canvas.ClipRect);
  LBlackBuf.Canvas.Brush.Color := clBlack;
  LBlackBuf.Canvas.Pen.Style := psClear;
  LBlackBuf.Canvas.FillRect(LBlackBuf.Canvas.ClipRect);
  if MultiRow then
  begin
    DrawMultiRowColumns(LWhiteBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
    DrawMultiRowColumns(LBlackBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
  end
  else
    if FStacked then
    begin
      DrawColumnsStacked(LWhiteBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
      DrawColumnsStacked(LBlackBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
    end
    else
    begin
      DrawColumns(LWhiteBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
      DrawColumns(LBlackBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
    end;
  DrawTransparency(ABuffer, LWhiteBuf, LBlackBuf, LChArea.Shadow, LChArea.ShadowColor, LChArea.ShadowDepth, LChArea.ShadowTransparency, FColumnsTransparency);
  LWhiteBuf.Free;
  LBlackBuf.Free;
end;

procedure TLMDChartCTColumn3D.DrawPlaneLines(ATarget: TCanvas; Negative: boolean; leftPoly: TPointsArr; bottomPoly: TPointsArr; backRect: TRect; b, d, l: boolean);
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
    tmpBack[1] := Point(backRect.Left + 1, backRect.Bottom);
    tmpBack[2] := Point(backRect.Left + 1, backRect.Top);
    tmpBack[3] := Point(backRect.Right, backRect.Top);
  end;
  if d then
  begin
    FBottomPlaneLine.SetupCanvasPen(ATarget.Pen);
    DrawLines(tmpBottom, ATarget);
  end;
  if l then
  begin
    FLeftPlaneLine.SetupCanvasPen(ATarget.Pen);
    ATarget.Polyline(LeftPoly);
  end;
  if b then
  begin
    FBackPlaneLine.SetupCanvasPen(ATarget.Pen);
    DrawLines(tmpBack, ATarget);
  end;
end;

end.
