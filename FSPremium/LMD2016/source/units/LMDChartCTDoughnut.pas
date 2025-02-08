unit LMDChartCTDoughnut;
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
LMDChartCTPie2D
---------------

Changes
-------
Last (09-June-2006)

###############################################################################}

interface

uses
  Windows, Variants, SysUtils, Types, Math, Graphics, Classes,
  LMDXML, LMDXMLNodeNames, LMDChartData, LMDChartTypes, LMDChartPersistent,
  LMDChartUtils, LMDChartBackground, LMDChartMarker, LMDChartLabel;

type
  { *********************** TLMDChartCTPie2D ********************************* }
  /// <summary>
  /// A doughnut chart displays value data as percentages of the whole.
  /// Categories are represented by individual slices. Doughnut charts are
  /// typically used to show percentages. Doughnut charts are functionally
  /// identical to pie charts.
  /// </summary>
  TLMDChartCTDoughnut = class(TLMDChartCTAbstract)
  private
    LLabel: TLMDChartLabel;
    LMarker: TLMDChartMarker;
    FProportion: boolean;
    FPieTransparency: byte;
    FThisExplode: integer;
    FThisExplodeIndex: integer;
    FExplodes: array of integer;
    FExplodeAutoScale: boolean;
    FLabelsYDeviation: integer;
    FLabelsXDeviation: integer;
    FLabelsMargin: integer;
    FShowPercent: boolean;
    FLabelAlign: TLMDChartLabelAlign;
    procedure SetLabelAlign(Value: TLMDChartLabelAlign);
    procedure SetPieTransparency(Value: byte);
    procedure SetPiesLabels(Value: TLMDChartLabel);
    procedure SetLabelsMargin(Value: integer);
    procedure SetLabelsXDeviation(Value: integer);
    procedure SetLabelsYDeviation(Value: integer);
    procedure SetShowPercent(Value: boolean);
  protected
    procedure DrawPie(ATarget: TBitmap; AValues: TLMDChartData; AArea: TRect);
  public
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
    property LabelAlign: TLMDChartLabelAlign read FLabelAlign write SetLabelAlign default claSmart;
    property ShowPercent: boolean read FShowPercent write SetShowPercent default false;
    property LabelsXDeviation: integer read FLabelsXDeviation write SetLabelsXDeviation default 0;
    property LabelsYDeviation: integer read FLabelsYDeviation write SetLabelsYDeviation default 0;
    property LabelsMargin: integer read FLabelsMargin write SetLabelsMargin default 0;
    property PiesLabels: TLMDChartLabel read LLabel write SetPiesLabels;
    property PieTransparency: byte read FPieTransparency write SetPieTransparency default 250;
  end;

implementation

uses
  LMDChartArea;

{ ************************* TLMDChartCTPie2D ********************************* }
{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTDoughnut.SetShowPercent(Value: boolean);
begin
  FShowPercent := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTDoughnut.SetLabelAlign(Value: TLMDChartLabelAlign);
begin
  FLabelAlign := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTDoughnut.SetPiesLabels(Value: TLMDChartLabel);
begin
  LLabel.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTDoughnut.SetLabelsMargin(Value: integer);
begin
  FLabelsMargin := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTDoughnut.SetLabelsXDeviation(Value: integer);
begin
  FLabelsXDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTDoughnut.SetLabelsYDeviation(Value: integer);
begin
  FLabelsYDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;
{ ------------------------- private ------------------------------------------ }

procedure TLMDChartCTDoughnut.SetPieTransparency(Value: byte);
begin
  FPieTransparency := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ------------------------- protected ---------------------------------------- }

procedure TLMDChartCTDoughnut.DrawPie(ATarget: TBitmap; AValues: TLMDChartData;
  AArea: TRect);
var
  StrLabel: string;
  LSeriesSum: real;
  LLastAngleOnPie: real;
  i, j, k: integer;
  SliceWidth, SliceTab: integer;
  LSliceValue: real;
  LDelta, LMaxExplodeX, LMaxExplodeY, LExplodeY, LExplodeX, LSliceCount: integer;
  XScale, YScale, LabelX, LabelY, LabelXSt, LabelYSt, LInd: integer;
  PieRadiusX, PieRadiusY, PieCenterX, PieCenterY: real;
  MarkerAngleTab: real;
  loaddata, loaddata1: variant;
begin
  LSeriesSum := 0;
  for i := 0 to AValues.RowCount - 1 do
  begin
    if AValues.GetTableValue(0, i) = EmptyID then
      loaddata := 0
    else
      loaddata := AValues.GetTableValue(0, i);
    if loaddata > 0 then
      LSeriesSum := LSeriesSum + loaddata;
  end;
  //check proportion
  if FProportion then
    if (AArea.Right - AArea.Left) > (AArea.Bottom - AArea.Top) then
    begin
      LDelta := (AArea.Right - AArea.Left) - (AArea.Bottom - AArea.Top);
      AArea.Right := AArea.Right - LDelta div 2;
      AArea.Left := AArea.Left + LDelta div 2;
    end
    else
      if (AArea.Right - AArea.Left) < (AArea.Bottom - AArea.Top) then
      begin
        LDelta := (AArea.Bottom - AArea.Top) - (AArea.Right - AArea.Left);
        AArea.Bottom := AArea.Bottom - LDelta div 2;
        AArea.Top := AArea.Top + LDelta div 2;
      end;

  //check slice width (depend on number of columns)
  SliceWidth := trunc((AArea.Right - AArea.Left) / 2 / (AValues.ColCount + 1));

  LLastAngleOnPie := 0;
  //get max explode
  LSliceCount := 0;
  LMaxExplodeX := 0;
  LMaxExplodeY := 0;
  for i := 0 to AValues.RowCount - 1 do
  begin
    if AValues.GetTableValue(0, i) = EmptyID then
      loaddata := 0
    else
      loaddata := AValues.GetTableValue(0, i);
    if loaddata > 0 then
    begin
      LSliceValue := (loaddata / LSeriesSum) * 360;
      if FExplodeAutoScale then
        if (Length(FExplodes) > LSliceCount) then
        begin
          LMaxExplodeX := max(LMaxExplodeX, abs(trunc(sin(DegToRad(LLastAngleOnPie + LSliceValue / 2)) * FExplodes[LSliceCount])));
          LMaxExplodeY := max(LMaxExplodeY, abs(trunc(cos(DegToRad(LLastAngleOnPie + LSliceValue / 2)) * FExplodes[LSliceCount])));
        end;
      LLastAngleOnPie := LLastAngleOnPie + LSliceValue;
      if LLastAngleOnPie >= 360 then
        LLastAngleOnPie := LLastAngleOnPie - 360;
    end;
    LSliceCount := LSliceCount + 1;
  end;

  if FExplodeAutoScale then
  begin
    if FProportion then
      if LMaxExplodeX > LMaxExplodeY then
        LMaxExplodeY := LMaxExplodeX
      else
        LMaxExplodeX := LMaxExplodeY;
    AArea.Left := AArea.Left + LMaxExplodeX;
    AArea.Right := AArea.Right - LMaxExplodeX;
    AArea.Top := AArea.Top + LMaxExplodeY;
    AArea.Bottom := AArea.Bottom - LMaxExplodeY;
  end;

  LSliceCount := 0;
  LLastAngleOnPie := 0;
  //draw
  SliceTab := 0;
  for j := 0 to AValues.ColCount - 1 do
  begin
    for i := 0 to AValues.RowCount - 1 do
    begin
      if AValues.GetTableValue(j, i) = EmptyID then
        loaddata := 0
      else
        loaddata := AValues.GetTableValue(j, i);
      if loaddata > 0 then
      begin
        LSeriesSum := 0;
        for k := 0 to AValues.RowCount - 1 do
        begin
          if AValues.GetTableValue(j, k) = EmptyID then
            loaddata1 := 0
          else
            loaddata1 := AValues.GetTableValue(j, k);
          if loaddata1 > 0 then
            LSeriesSum := LSeriesSum + loaddata1;
        end; // k
        ATarget.Canvas.Brush.Color := AValues.GetRowFill(i).SolidColor;
        AValues.GetRowsLines(i).SetupCanvasPen(ATarget.Canvas.Pen);
        LSliceValue := (loaddata / LSeriesSum) * 360;
        //explode
        if Length(FExplodes) > LSliceCount then
        begin
          if FExplodes[LSliceCount] <> 0 then
          begin
            LExplodeY := trunc(cos(DegToRad(LLastAngleOnPie + LSliceValue / 2)) * FExplodes[LSliceCount]);
            LExplodeX := trunc(sin(DegToRad(LLastAngleOnPie + LSliceValue / 2)) * FExplodes[LSliceCount]);
          end
          else
          begin
            LExplodeY := 0;
            LExplodeX := 0;
          end;
        end
        else
        begin
          LExplodeY := 0;
          LExplodeX := 0;
        end;
        ATarget.Canvas.Brush.Color := AValues.GetRowFill(i).SolidColor;
        LMDChartUtils.DnutSlice(ATarget.Canvas, Rect(AArea.Left + LExplodeX + SliceTab,
          AArea.Top + LExplodeY + SliceTab, AArea.Right + LExplodeX - SliceTab,
          AArea.Bottom + LExplodeY - SliceTab), LLastAngleOnPie,
          LLastAngleOnPie + LSliceValue, SliceWidth);

        MarkerAngleTab := SliceTab div SliceWidth * 5;

        XScale := AArea.Right - AArea.Left;
        YScale := AArea.Bottom - AArea.Top;
        PieRadiusX := XScale / 2;
        PieRadiusY := YScale / 2;
        PieCenterX := AArea.Left + PieRadiusX + LExplodeX;
        PieCenterY := AArea.Top + PieRadiusY + LExplodeY;
        LabelXSt := trunc(PieCenterX + (PieRadiusX - SliceTab - SliceWidth / 3 - lMarker.Size * 3) * sin(DegToRad(LLastAngleOnPie + LSliceValue / 2)) + FLabelsXDeviation);
        LabelYSt := trunc(PieCenterY + (PieRadiusY - SliceTab - SliceWidth / 3 - lMarker.Size * 3) * cos(DegToRad(LLastAngleOnPie + LSliceValue / 2)) + FLabelsYDeviation);

        LabelX := trunc(PieCenterX + (PieRadiusX + 30 - lMarker.Size * 3) * sin(DegToRad(LLastAngleOnPie + LSliceValue / 2 + MarkerAngleTab)) + FLabelsXDeviation);
        LabelY := trunc(PieCenterY + (PieRadiusY + 30 - lMarker.Size * 3) * cos(DegToRad(LLastAngleOnPie + LSliceValue / 2 + MarkerAngleTab)) + FLabelsYDeviation);

        ATarget.Canvas.Pen.Color := clgray;
        ATarget.Canvas.Pen.Width := 1;

        DrawLine(LabelXSt, LabelYSt, LabelX, LabelY, ATarget.Canvas);

        LMarker := AValues.GetRowMarker(i);
        LMarker.Draw(ATarget.Canvas, LabelX, LabelY);

        if (FShowPercent) then
          StrLabel := FloatToStrF(AValues.GetTableValue(j, i), ffFixed, 7, 2) + AValues.ValIndicator + '; ' + FloatToStrF(LSliceValue / 360 * 100, ffFixed, 7, 2) + '%'
        else
          StrLabel := FloatToStrF(AValues.GetTableValue(j, i), ffFixed, 7, 2) + AValues.ValIndicator;

        LInd := ATarget.Canvas.TextWidth(StrLabel) div 2 + 4;

        if (LabelAlign = claRightSide) then
          LabelX := LabelX + LMarker.Size + FLabelsMargin + LInd;
        if (LabelAlign = claLeftSide) then
          LabelX := LabelX - LMarker.Size - FLabelsMargin - LInd;
        if (LabelAlign = claSmart) then
        begin
          if (((LLastAngleOnPie + LSliceValue / 2) >= 0) and
            ((LLastAngleOnPie + LSliceValue / 2) < 180)) then
            LabelX := LabelX + LMarker.Size + FLabelsMargin + LInd;
          if (((LLastAngleOnPie + LSliceValue / 2) >= 180) and
            ((LLastAngleOnPie + LSliceValue / 2) < 360)) then
            LabelX := LabelX - LMarker.Size - FLabelsMargin - LInd;
        end;

        LLabel.Draw(ATarget.Canvas, StrLabel, LabelX, LabelY, claLeftTop, clcHorzVert);

        LLastAngleOnPie := LLastAngleOnPie + LSliceValue;
        LSliceCount := LSliceCount + 1;
        if LLastAngleOnPie >= 360 then
          LLastAngleOnPie := LLastAngleOnPie - 360;
      end;
    end; // for i
    SliceTab := SliceTab + SliceWidth;
  end; // for j
end;

{ ------------------------- public ------------------------------------------- }

function TLMDChartCTDoughnut.IsChanged: boolean;
begin
  if LLabel.IsChanged then
    FChanged := true;
  if LMarker.IsChanged then
    FChanged := true;
  IsChanged := FChanged;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTDoughnut.NoChanged;
begin
  FChanged := false;
  LLabel.NoChanged;
  LMarker.NoChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTDoughnut.ResetMainOwner(AmainOwner: TPersistent);
begin
  FMainOwner := AMainOwner;
  LLabel.ResetOwner(FMainOwner);
  LMarker.ResetOwner(FMainOwner);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTDoughnut.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode, ArrayNode: ILMDXmlNode;
  i: integer;
begin
  WorkNode := BaseNode.NeedChild(NNCTDoughnut + NNSpace + Comment);

  LLabel.LoadStateFromXML(WorkNode, '');
  LMarker.LoadStateFromXML(WorkNode, '');

  IterNode := WorkNode.NeedChild('PieTransparency');
  FPieTransparency := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('LabelsYDeviation');
  FLabelsYDeviation := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('LabelsXDeviation');
  FLabelsXDeviation := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('LabelsMargin');
  FLabelsMargin := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('Proportion');
  FProportion := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ExplodeAutoScale');
  FExplodeAutoScale := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ShowPercent');
  FShowPercent := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ThisExplode');
  FThisExplode := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ThisExplodeIndex');
  FThisExplodeIndex := IterNode.GetVarAttr('value', 0);

  SetLength(FExplodes, IterNode.ChildNodes.Count);
  IterNode := WorkNode.NeedChild('Explodes');
  for i := 0 to IterNode.ChildNodes.Count - 1 do
  begin
    ArrayNode := IterNode.NeedChild('i' + inttostr(i));
    FExplodes[i] := ArrayNode.GetVarAttr('value', 0);
  end;
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartCTDoughnut.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode, ArrayNode: ILMDXmlNode;
  i: integer;
begin
  IterNode := BaseNode.AppendElement('ChartType');
  IterNode.SetVarAttr('value', Variant(ChartDoughnutID));

  WorkNode := BaseNode.EnsureChild(NNCTDoughnut + NNSpace + Comment);

  LLabel.SaveStateToXML(WorkNode, '');
  LMarker.SaveStateToXML(WorkNode, '');

  IterNode := WorkNode.AppendElement('PieTransparency');
  IterNode.SetVarAttr('value', FPieTransparency);

  IterNode := WorkNode.AppendElement('LabelsYDeviation');
  IterNode.SetVarAttr('value', FLabelsYDeviation);

  IterNode := WorkNode.AppendElement('LabelsXDeviation');
  IterNode.SetVarAttr('value', FLabelsXDeviation);

  IterNode := WorkNode.AppendElement('LabelsMargin');
  IterNode.SetVarAttr('value', FLabelsMargin);

  IterNode := WorkNode.AppendElement('Proportion');
  IterNode.SetBoolAttr('value', FProportion);

  IterNode := WorkNode.AppendElement('ExplodeAutoScale');
  IterNode.SetBoolAttr('value', FExplodeAutoScale);

  IterNode := WorkNode.AppendElement('ShowPercent');
  IterNode.SetBoolAttr('value', FShowPercent);

  IterNode := WorkNode.AppendElement('ThisExplode');
  IterNode.SetVarAttr('value', FThisExplode);

  IterNode := WorkNode.AppendElement('ThisExplodeIndex');
  IterNode.SetVarAttr('value', FThisExplodeIndex);

  IterNode := WorkNode.AppendElement('Explodes');
  for i := 0 to length(FExplodes) - 2 do
  begin
    ArrayNode := IterNode.AppendElement('i' + inttostr(i));
    ArrayNode.SetVarAttr('value', FExplodes[i]);
  end;
end;
{ -----------------------------------------------------------------------------}

constructor TLMDChartCTDoughnut.Create(AOwner: TComponent);
begin
  inherited;
  SetLength(FExplodes, 0);
  LLabel := TLMDChartLabel.Create(AOwner);
  LMarker := TLMDChartMarker.Create(AOwner);
  //default design
  FPieTransparency := 150;
  FShowPercent := false;
  FLabelsMargin := 0;
  FLabelsYDeviation := 0;
  FLabelsXDeviation := 0;
  FProportion := true;
  LabelAlign := claSmart;
  FThisExplode := 0;
  FThisExplodeIndex := 0;
  FExplodeAutoScale := true;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartCTDoughnut.Destroy;
begin
  //TLMDChartArea(.Owner
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTDoughnut.Draw(ABuffer: TBitmap; AArea: TRect;
  AValues: TLMDChartData; AChartArea: TLMDChartPersistent);
var
  LLeftFld, LTopFld, LBottomFld, LRightFld: integer;
  LChArea: TLMDChartArea;
  ABlackBuf, AWhiteBuf: TBitmap;
begin
  inherited;
  LChArea := TLMDChartArea(AChartArea);

  ABlackBuf := TBitmap.Create;
  ABlackBuf.Height := AArea.Bottom - AArea.Top - LChArea.MarginTop - LChArea.MarginBottom;
  ABlackBuf.Width := AArea.Right - AArea.Left - LChArea.MarginLeft - LChArea.MarginRight;

  AWhiteBuf := TBitmap.Create;
  AWhiteBuf.Height := AArea.Bottom - AArea.Top - LChArea.MarginTop - LChArea.MarginBottom;
  AWhiteBuf.Width := AArea.Right - AArea.Left - LChArea.MarginLeft - LChArea.MarginRight;

  //pie chart========================
  LTopFld := LChArea.InnerIndentTop + LChArea.Edge.Width;
  LLeftFld := LChArea.InnerIndentLeft + LChArea.Edge.Width;
  LRightFld := LChArea.InnerIndentRight + LChArea.Edge.Width;
  LBottomFld := LChArea.InnerIndentBottom + LChArea.Edge.Width;

  AWhiteBuf.Canvas.Brush.Color := clWhite;
  AWhiteBuf.Canvas.Pen.Style := psClear;
  AWhiteBuf.Canvas.FillRect(AWhiteBuf.Canvas.ClipRect);
  ABlackBuf.Canvas.Brush.Color := clBlack;
  ABlackBuf.Canvas.Pen.Style := psClear;
  ABlackBuf.Canvas.FillRect(ABlackBuf.Canvas.ClipRect);

  DrawPie(AWhiteBuf, AValues, Rect(LLeftFld, LTopFld, ABuffer.Width - LRightFld, ABuffer.Height - LBottomFld));
  DrawPie(ABlackBuf, AValues, Rect(LLeftFld, LTopFld, ABuffer.Width - LRightFld, ABuffer.Height - LBottomFld));
  DrawTransparency(ABuffer, AWhiteBuf, ABlackBuf, LChArea.Shadow, LChArea.ShadowColor, LChArea.ShadowDepth, LChArea.ShadowTransparency, FPieTransparency);

  AWhiteBuf.Free;
  ABlackBuf.Free;
end;

end.
