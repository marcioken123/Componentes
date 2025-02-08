unit LMDChartCTColumn;
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
LMDChartCTColumn
----------------

Changes
-------
Last (08-June-2006)

###############################################################################}

interface

uses
  Windows, Variants, SysUtils, Types, Math, Graphics, Classes,
  LMDXML, LMDXMLNodeNames, LMDChartData, LMDChartTypes, LMDChartPersistent,
  LMDChartUtils, LMDChartAxis, LMDChartMarker, LMDChartLabel, LMDChartLine,
  LMDChartScaleBreak;

type
  { *************** TLMDChartCTColumn **************************************** }
  /// <summary>
  /// A column chart displays values and series groups as sets
  /// of vertical columns that are grouped by category. Values are
  /// represented by the height of the columns as measured by the y-axis.
  /// Category labels are displayed on the x-axis. Column charts are typically
  /// used to compare values between categories.
  /// </summary>
  TLMDChartCTColumn = class(TLMDChartCTAbstract)
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
    FColumnsStacked: boolean;
    FFullStacked: boolean;
    FXLine: TLMDChartLine;
    FYLine: TLMDChartLine;
    procedure SetColumnAutoSize(Value: boolean);
    procedure SetColumnAutoSizeValue(Value: integer);
    procedure SetColumnCustomSize(Value: integer);
    procedure SetColumnsTransparency(Value: byte);
    procedure SetColumnsLabels(Value: TLMDChartLabel);
    procedure SetShowColumnsLabels(Value: boolean);
    procedure SetLabelsMargin(Value: integer);
    procedure SetLabelsXDeviation(Value: integer);
    procedure SetLabelsYDeviation(Value: integer);
    procedure SetColumnsStacked(Value: boolean);
    procedure SetFullStacked(Value: boolean);
    procedure SetXLine(Value: TLMDChartLine);
    procedure SetYLine(Value: TLMDChartLine);
  protected
    procedure DrawColumns(ATarget: TCanvas; AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
    procedure DrawColumnsStacked(ATarget: TCanvas; AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
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
    function IsChanged: boolean; override;
    procedure NoChanged; override;
    procedure ResetMainOwner(AmainOwner: TPersistent); override;
  published
    property YLine: TLMDChartLine read FYLine write SetYLine;
    property XLine: TLMDChartLine read FXLine write SetXLine;
    property LabelsXDeviation: integer read FLabelsXDeviation write SetLabelsXDeviation default 0;
    property LabelsYDeviation: integer read FLabelsYDeviation write SetLabelsYDeviation default 05;
    property LabelsMargin: integer read FLabelsMargin write SetLabelsMargin default 4;
    property ShowColumnsLabels: boolean read FShowColumnsLabels write SetShowColumnsLabels default true;
    property ColumnsLabels: TLMDChartLabel read FColumnsLabels write SetColumnsLabels;
    property ColumnsTransparency: byte read FColumnsTransparency write SetColumnsTransparency default 150;
    property ColumnAutoSize: boolean read FColumnAutoSize write SetColumnAutoSize default true;
    property ColumnAutoSizeValue: integer read FColumnAutoSizeValue write SetColumnAutoSizeValue default 10;
    property ColumnCustomSize: integer read FColumnCustomSize write SetColumnCustomSize default 40;
    property ColumnsStacked: boolean read FColumnsStacked write SetColumnsStacked default false;
    property FullStacked: boolean read FFullStacked write SetFullStacked default false;
  end;

implementation

uses
  LMDChartArea;

{ *********************** TLMDChartCTColumn ********************************** }
{ ----------------------- private -------------------------------------------- }

procedure TLMDChartCTColumn.SetYLine(Value: TLMDChartLine);
begin
  if Value <> FYLine then
  begin
    FYLine.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetXLine(Value: TLMDChartLine);
begin
  if Value <> FXLine then
  begin
    FXLine.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetColumnAutoSize(Value: boolean);
begin
  FColumnAutoSize := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetColumnAutoSizeValue(Value: integer);
begin
  FColumnAutoSizeValue := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetColumnCustomSize(Value: integer);
begin
  FColumnCustomSize := value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetColumnsLabels(Value: TLMDChartLabel);
begin
  FColumnsLabels.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetColumnsTransparency(Value: byte);
begin
  FColumnsTransparency := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetLabelsMargin(Value: integer);
begin
  FLabelsMargin := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetLabelsXDeviation(Value: integer);
begin
  FLabelsXDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetLabelsYDeviation(Value: integer);
begin
  FLabelsYDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetShowColumnsLabels(Value: boolean);
begin
  FShowColumnsLabels := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetColumnsStacked(Value: boolean);
begin
  FColumnsStacked := Value;
  if Value = false then
    FFullStacked := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.SetFullStacked(Value: boolean);
begin
  FFullStacked := Value;
  if Value = true then
    FColumnsStacked := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ----------------------- protected ------------------------------------------ }

procedure TLMDChartCTColumn.DrawColumns(ATarget: TCanvas; AValues: TLMDChartData;
  AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  i, j: integer;
  LColumnPosition, LColumnWidth, LTempVar, LDelta, LPosX: integer;
  loaddata, labeldata: variant;
  OffSetNeg, OffSetPos: variant;
  fp, lp: TPoint;
begin
  OffSetPos := 0;
  OffSetNeg := 0;
  if AYAxis.ScaleBreak.Enabled then
  begin
    OffSetPos := AYAxis.ScaleBreak.PositiveLowLimit - AYAxis.ScaleBreak.PositiveHighLimit;
    OffSetNeg := AYAxis.ScaleBreak.NegativeLowLimit - AYAxis.ScaleBreak.NegativeHighLimit;
  end;
  LDelta := AEndX - AStartX;
  if (AValues.ColCount > 0) and (AValues.RowCount
    > 0) then
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
        AValues.GetRowsLines(j).SetupCanvasPen(ATarget.Pen);
        if AValues.GetTableValue(i div 2, j) = EmptyID then
          loaddata := 0
        else
          loaddata := AValues.GetTableValue(i div 2, j);
        labeldata := loaddata;
        if (loaddata > AYAxis.ScaleBreak.PositiveHighLimit) and
          ((AYAxis.ScaleBreak.Appearance = sbaPositive) or (AYAxis.ScaleBreak.Appearance = sbaBoth)) then
          loaddata := loaddata + OffSetPos;
        if (loaddata < AYAxis.ScaleBreak.NegativeHighLimit) and
          ((AYAxis.ScaleBreak.Appearance = sbaNegative) or (AYAxis.ScaleBreak.Appearance = sbaBoth)) then
          loaddata := loaddata + OffSetNeg;
        if loaddata < 0 then //if values is negative
        begin
          AValues.GetRowFill(j).DrawRectangle(ATarget, AValues.GetRowsLines(j), LPosx, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) + 1, LPosx + LColumnWidth, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LTempVar));
          if AShowMarkers then
            AValues.GetRowMarker(j).Draw(ATarget, trunc(LPosx + LColumnWidth / 2), AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar));
          if FShowColumnsLabels then //draw  columns labels
            ColumnsLabels.Draw(ATarget, floattostr(labeldata), trunc(LPosx + LColumnWidth / 2) + FLabelsXDeviation, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar) + FLabelsMargin - FLabelsYDeviation, claLeftTop, clcHorizontal);
        end
        else
          if loaddata > 0 then
          begin
            AValues.GetRowFill(j).DrawRectangle(ATarget, AValues.GetRowsLines(j), LPosx, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar), LPosx + LColumnWidth, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, LTempVar) + 1);
            if AShowMarkers then
              AValues.GetRowMarker(j).Draw(ATarget, trunc(LPosx + LColumnWidth / 2), AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, LTempVar));
            if FShowColumnsLabels then
              ColumnsLabels.Draw(ATarget, floattostr(labeldata),
                trunc(LPosx + LColumnWidth / 2) + FLabelsXDeviation,
                AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata,
                LTempVar) - FLabelsMargin + FLabelsYDeviation, claLeftBottom, clcHorizontal);
          end;
        LPosx := LPosx + LColumnWidth - 1;
      end;
    end;
  end;
  if AYAxis.ScaleBreak.Enabled then
  begin
    if (AYAxis.ScaleBreak.Appearance = sbaPositive) or (AYAxis.ScaleBreak.Appearance = sbaBoth) then
    begin
      fp.X := AStartX;
      lp.X := AEndX;
      fp.Y := AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, AYAxis.ScaleBreak.PositiveLowLimit, LTempVar);
      lp.Y := fp.Y;
      AYAxis.ScaleBreak.RenderBreak(ATarget, fp, lp, false, true);
    end;
    if (AYAxis.ScaleBreak.Appearance = sbaNegative) or (AYAxis.ScaleBreak.Appearance = sbaBoth) then
    begin
      fp.X := AStartX;
      lp.X := AEndX;
      fp.Y := AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, AYAxis.ScaleBreak.NegativeLowLimit, LTempVar);
      lp.Y := fp.Y;
      AYAxis.ScaleBreak.RenderBreak(ATarget, fp, lp, false, true);
    end;
  end;
end;

{ ----------------------- protected ------------------------------------------ }

procedure TLMDChartCTColumn.DrawColumnsStacked(ATarget: TCanvas; AValues: TLMDChartData;
  AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis; AShowMarkers: boolean);
var
  i, j: integer;
  LColumnPosition, LColumnWidth, LErrorBack, LDelta, LPosx: integer;
  LAccomulation, SumVal: real;
  Factors: array of real;
  loaddata: variant;
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
          AValues.GetRowFill(j).DrawRectangle(ATarget,
            AValues.GetRowsLines(j),
            LPosX,
            AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation, LErrorBack),
            LPosX + LColumnWidth,
            AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack) + 1
            );
          if FShowColumnsLabels then
            ColumnsLabels.Draw(ATarget, floattostr(AValues.GetTableValue(i div 2, j)), LPosX + LColumnWidth div 2 + FLabelsXDeviation,
              AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata / 2, LErrorBack) - FLabelsMargin + FLabelsYDeviation

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
          AValues.GetRowFill(j).DrawRectangle(ATarget,
            AValues.GetRowsLines(j),
            LPosX,
            AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata * Factors[i div 2], LErrorBack),
            LPosX + LColumnWidth,
            AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation, LErrorBack) + 1
            );
          if FShowColumnsLabels then
            ColumnsLabels.Draw(ATarget, floattostr(loaddata), LPosX + LColumnWidth div 2 + FLabelsXDeviation,
              AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation + loaddata / 2, LErrorBack) - FLabelsMargin + FLabelsYDeviation

              , claLeftTop, clcHorzVert);
          LAccomulation := LAccomulation + loaddata * Factors[i div 2];
        end;
      end;

    end;

  end;
end;

{ ----------------------- public --------------------------------------------- }

function TLMDChartCTColumn.IsChanged: boolean;
begin
  if FColumnsLabels.IsChanged then
    FChanged := true;
  if FYLine.IsChanged then
    FChanged := true;
  if FXLine.IsChanged then
    FChanged := true;
  IsChanged := FChanged;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTColumn.NoChanged;
begin
  FChanged := false;
  FColumnsLabels.NoChanged;
  FYLine.NoChanged;
  FXLine.NoChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.ResetMainOwner(AmainOwner: TPersistent);
begin
  FMainOwner := AMainOwner;
  FYLine.ResetOwner(FMainOwner);
  FXLine.ResetOwner(FMainOwner);
  FColumnsLabels.ResetOwner(FMainOwner);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin

  WorkNode := BaseNode.NeedChild(NNCTColumn + NNSpace + Comment);

  FColumnsLabels.LoadStateFromXML(WorkNode, '');

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

  IterNode := WorkNode.NeedChild('ColumnsStacked');
  FColumnsStacked := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('FullStacked');
  FFullStacked := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ColumnAutoSize');
  FColumnAutoSize := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ColumnAutoSizeValue');
  FColumnAutoSizeValue := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ColumnCustomSize');
  FColumnCustomSize := IterNode.GetVarAttr('value', 0);
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartCTColumn.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  IterNode := BaseNode.AppendElement('ChartType');
  IterNode.SetVarAttr('value', Variant(ChartColumnID));

  WorkNode := BaseNode.EnsureChild(NNCTColumn + NNSpace + Comment);

  FColumnsLabels.SaveStateToXML(WorkNode, '');

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

  IterNode := WorkNode.AppendElement('ColumnsStacked');
  IterNode.SetBoolAttr('value', FColumnsStacked);

  IterNode := WorkNode.AppendElement('FullStacked');
  IterNode.SetBoolAttr('value', FFullStacked);

  IterNode := WorkNode.AppendElement('ColumnAutoSize');
  IterNode.SetBoolAttr('value', FColumnAutoSize);

  IterNode := WorkNode.AppendElement('ColumnAutoSizeValue');
  IterNode.SetVarAttr('value', FColumnAutoSizeValue);

  IterNode := WorkNode.AppendElement('ColumnCustomSize');
  IterNode.SetVarAttr('value', FColumnCustomSize);
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartCTColumn.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartCTColumn then
  begin
    try
      FColumnsLabels.Assign(TLMDChartCTColumn(ASource).FColumnsLabels);
      FShowColumnsLabels := TLMDChartCTColumn(ASource).FShowColumnsLabels;
      ColumnsTransparency := TLMDChartCTColumn(ASource).FColumnsTransparency;
      FColumnAutoSize := TLMDChartCTColumn(ASource).FColumnAutoSize;
      FColumnAutoSizeValue := TLMDChartCTColumn(ASource).ColumnAutoSizeValue;
      FColumnCustomSize := TLMDChartCTColumn(ASource).ColumnCustomSize;
      FLabelsYDeviation := TLMDChartCTColumn(ASource).FLabelsYDeviation;
      FLabelsXDeviation := TLMDChartCTColumn(ASource).FLabelsXDeviation;
      FLabelsMargin := TLMDChartCTColumn(ASource).FLabelsMargin;
      FYLine := TLMDChartCTColumn(ASource).FYLine;
      FXLine := TLMDChartCTColumn(ASource).FXLine;
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartCTColumn.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FColumnsLabels := TLMDChartLabel.Create(AOwner);
  FYLine := TLMDChartLine.Create(AOwner);
  FXLine := TLMDChartLine.Create(AOwner);
  //default
  FShowColumnsLabels := true;
  FColumnAutoSize := true;
  FColumnAutoSizeValue := 10;
  FColumnCustomSize := 40;
  FColumnsTransparency := 150;
  FLabelsMargin := 4;
  FLabelsYDeviation := 0;
  FLabelsXDeviation := 0;
  FFullStacked := false;
  ColumnsStacked := false;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartCTColumn.Destroy;
begin
  FColumnsLabels.Free;
  FYLine.Free;
  FXLine.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTColumn.Draw(ABuffer: TBitmap; AArea: TRect; AValues: TLMDChartData; AChartAr: TLMDChartPersistent);
var
  LLeftFld, LTopFld, LBottomFld, LRightFld: integer;
  i, j, LCalculationTempVar1, LPositionOnAxis, LErrorBack, LYLabes, LXLabes: integer;
  LXAxisStart, LXAxisEnd: TPoint;
  LYAxisStart, LYAxisEnd: TPoint;
  LCalcZ, LCalcX: single;
  LTickSz: integer;
  LChArea: TLMDChartArea;
  LBlackBuf, LWhiteBuf: TBitmap;
  labeldata: variant;
begin
  inherited;
  LChArea := TLMDChartArea(AChartAr);
  if ColumnsStacked then
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
    LCalculationTempVar1 := TextWidth(floatToStr(LChArea.YAxis.MinValue));
    if LCalcX > 0 then
      for i := 1 to Trunc(StrToFloat(FloatToStr(LCalcX))) do
      begin
        //   LCalculationTempVar1 := Max(LCalculationTempVar1, TextWidth(floatToStr(LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep*i)));
        LCalculationTempVar1 := Max(LCalculationTempVar1, TextWidth('100000'));
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
      LCalculationTempVar1 := LXAxisEnd.X - LXAxisStart.X;
      if AValues.ColCount > 1 then
      begin
        for i := 0 to AValues.ColCount do
        begin
          LPositionOnAxis := Trunc(LCalculationTempVar1 * ((1 / AValues.ColCount) * i));
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
        labeldata := LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i;
        if not ColumnsStacked then
        begin
          if (LChArea.YAxis.ScaleBreak.Enabled) and (labeldata > LChArea.YAxis.ScaleBreak.PositiveLowLimit) and
            ((LChArea.YAxis.ScaleBreak.Appearance = sbaPositive) or (LChArea.YAxis.ScaleBreak.Appearance = sbaBoth)) then
            labeldata := labeldata + LChArea.YAxis.ScaleBreak.PositiveHighLimit - LChArea.YAxis.ScaleBreak.PositiveLowLimit;
          if (LChArea.YAxis.ScaleBreak.Enabled) and (labeldata < LChArea.YAxis.ScaleBreak.NegativeLowLimit) and
            ((LChArea.YAxis.ScaleBreak.Appearance = sbaNegative) or (LChArea.YAxis.ScaleBreak.Appearance = sbaBoth)) then
            labeldata := labeldata + LChArea.YAxis.ScaleBreak.NegativeHighLimit - LChArea.YAxis.ScaleBreak.NegativeLowLimit;
        end;
        labeldata := Round(labeldata);
        TextOut(LYLabes - 15, (LYAxisEnd.Y - LPositionOnAxis) - TextHeight(floattostr(labeldata)) div 2, floattostr(labeldata) + AValues.ValIndicator);
      end;
    FYLine.SetupCanvasPen(Pen);
    DrawLine(LYAxisStart.X, LYAxisStart.Y, LYAxisEnd.X, LYAxisEnd.Y, ABuffer.Canvas);
    DrawLine(LYAxisStart.X, LYAxisStart.Y, LYAxisEnd.X, LYAxisEnd.Y, ABuffer.Canvas);
  end;
  LWhiteBuf.Canvas.Brush.Color := clWhite;
  LWhiteBuf.Canvas.Pen.Style := psClear;
  LWhiteBuf.Canvas.FillRect(LWhiteBuf.Canvas.ClipRect);
  LBlackBuf.Canvas.Brush.Color := clBlack;
  LBlackBuf.Canvas.Pen.Style := psClear;
  LBlackBuf.Canvas.FillRect(LBlackBuf.Canvas.ClipRect);
  if ColumnsStacked then
  begin
    DrawColumnsStacked(LWhiteBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
    DrawColumnsStacked(LBlackBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
    DrawTransparency(ABuffer, LWhiteBuf, LBlackBuf, LChArea.Shadow, LChArea.ShadowColor, LChArea.ShadowDepth, LChArea.ShadowTransparency, FColumnsTransparency);
  end
  else
  begin
    DrawColumns(LWhiteBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
    DrawColumns(LBlackBuf.Canvas, AValues, LXAxisStart.X, LXAxisEnd.X, LYAxisStart.Y, LYAxisEnd.Y, LChArea.YAxis, LChArea.ShowMarkers);
    DrawTransparency(ABuffer, LWhiteBuf, LBlackBuf, LChArea.Shadow, LChArea.ShadowColor, LChArea.ShadowDepth, LChArea.ShadowTransparency, FColumnsTransparency);
  end;

  //  DrawColumns(buffer.Canvas ,val,XAxisStart.X,XAxisend.X,YAxisStart.Y,YAxisEnd.Y,ChArea.YAxis, ChArea.ShowMarkers);
 //draw XAxis--------------
  with ABuffer.Canvas do
  begin
    Font.Assign(LChArea.XAxis.Font);
    FXLine.SetupCanvasPen(Pen);
    DrawLine(LXAxisStart.X, LXAxisStart.Y, LXAxisEnd.X, LXAxisEnd.Y, ABuffer.Canvas);
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
        DrawXTick(ABuffer.Canvas, LXAxisStart.X + LPositionOnAxis, LXAxisStart.Y, LChArea.XAxis.MajorTickSize, LChArea.XAxis.MajorTick, FXLine);
      end;
      //minor ticks
      for i := 1 to AValues.ColCount * 2 do
      begin
        if not odd(i) then
          Continue;
        LPositionOnAxis := Trunc(LCalculationTempVar1 * ((1 / (AValues.ColCount * 2)) * i));
        DrawXTick(ABuffer.Canvas, LXAxisStart.X + LPositionOnAxis, LXAxisStart.Y, LChArea.XAxis.MinorTickSize, LChArea.XAxis.MinorTick, FXLine);
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
  LWhiteBuf.Free;
  LBlackBuf.Free;
end;

end.
