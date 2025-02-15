unit LMDChartCTAreaSpline3D;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
� by LMD Innovative
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
TLMDChartCTAreaSpline3D unit
-----------------------

Changes
-------
Last (07-Aug-2006)

###############################################################################}

interface

uses
  Windows, Variants, SysUtils, Types, Math, Graphics, Classes,
  LMDXML, LMDXMLNodeNames, LMDChartData, LMDChartTypes, LMDChartPersistent,
  LMDChartUtils, LMDChartAxis, LMDChartMarker, LMDChartLabel, LMDChartLine,
  LMDChartBackground;

type
  { ******************* TLMDChartCTAreaSpline3D ********************************** }
  /// <summary>
  /// An area 3d spline chart displays data with splines
  /// </summary>
  TLMDChartCTAreaSpline3D = class(TLMDChartCTAbstract)
  private
    FAreaTransparency: byte;
    FAreaLabels: TLMDChartLabel;
    FShowAreaLabels: boolean;
    FLabelsYDeviation: integer;
    FLabelsXDeviation: integer;
    FLabelsMargin: integer;
    FChartDepth: integer;
    FLeftPlaneLine: TLMDChartLine;
    FBackPlaneLine: TLMDChartLine;
    FBottomPlaneLine: TLMDChartLine;
    FBottomPlaneFill: TLMDChartBackground;
    FLeftPlaneFill: TLMDChartBackground;
    FLeftZGrid: TLMDChartLine;
    FIndent3D: integer;
    FShaded: boolean;
    FNoEdge: boolean;
    FBackPlaneFill: TLMDChartBackground;
    FStacked: boolean;
    procedure SetAreaLabels(Value: TLMDChartLabel);
    procedure SetAreaTransparency(Value: byte);
    procedure SetLabelsMargin(Value: integer);
    procedure SetLabelsXDeviation(Value: integer);
    procedure SetLabelsYDeviation(Value: integer);
    procedure SetShowAreaLabels(Value: boolean);
    procedure SetChartDepth(const Value: integer);
    procedure SetBottomPlaneLine(Value: TLMDChartLine);
    procedure SetLeftPlaneLine(Value: TLMDChartLine);
    procedure SetBackPlaneLine(Value: TLMDChartLine);
    procedure SetBottomPlaneFill(Value: TLMDChartBackground);
    procedure SetLeftPlaneFill(Value: TLMDChartBackground);
    procedure SetLeftZGrid(Value: TLMDChartLine);
    procedure SetIndent3D(Value: integer);
    procedure SetShaded(Value: boolean);
    procedure SetNoEdge(Value: boolean);
    procedure SetBackPlaneFill(Value: TLMDChartBackground);
    procedure SetStacked(Value: boolean);
    procedure DrawPlaneLines(ATarget: TCanvas; Negative: boolean; leftPoly: TPointsArr; bottomPoly: TPointsArr; backRect: TRect; b, d, l: boolean);
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
    property LabelsXDeviation: integer read FLabelsXDeviation write SetLabelsXDeviation default 0;
    property LabelsYDeviation: integer read FLabelsYDeviation write SetLabelsYDeviation default 0;
    property LabelsMargin: integer read FLabelsMargin write SetLabelsMargin default 4;
    property ShowAreaLabels: boolean read FShowAreaLabels write SetShowAreaLabels default true;
    property AreaLabels: TLMDChartLabel read FAreaLabels write SetAreaLabels;
    property AreaTransparency: byte read FAreaTransparency write SetAreaTransparency default 200;
    property ChartDepth: integer read FChartDepth write SetChartDepth default 100;
    property BottomPlaneLine: TLMDChartLine read FBottomPlaneLine write SetBottomPlaneLine;
    property BackPlaneLine: TLMDChartLine read FBackPlaneLine write SetBackPlaneLine;
    property BottomPlaneFill: TLMDChartBackground read FBottomPlaneFill write SetBottomPlaneFill;
    property LeftPlaneLine: TLMDChartLine read FLeftPlaneLine write SetLeftPlaneLine;
    property LeftPlaneFill: TLMDChartBackground read FLeftPlaneFill write SetLeftPlaneFill;
    property LeftZGrid: TLMDChartLine read FLeftZGrid write SetLeftZGrid;
    property Indent3D: integer read FIndent3D write SetIndent3D default 10;
    property Shaded: boolean read FShaded write SetShaded default true;
    property NoEdge: boolean read FNoEdge write SetNoEdge default false;
    property Stacked: boolean read FStacked write SetStacked default false;
    property BackPlaneFill: TLMDChartBackground read FBackPlaneFill write SetBackPlaneFill;
  end;

implementation
uses
  LMDChartArea;

{ ********************* TLMDChartCTAreaSpline3D ********************************** }
{ --------------------- private -----------------------------------------------}

procedure TLMDChartCTAreaSpline3D.SetAreaLabels(Value: TLMDChartLabel);
begin
  FAreaLabels.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline3D.SetAreaTransparency(Value: byte);
begin
  FAreaTransparency := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline3D.SetStacked(Value: boolean);
begin
  FStacked := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline3D.SetLabelsMargin(Value: integer);
begin
  FLabelsMargin := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline3D.SetLabelsXDeviation(Value: integer);
begin
  FLabelsXDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline3D.SetLabelsYDeviation(Value: integer);
begin
  FLabelsYDeviation := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline3D.SetShowAreaLabels(Value: boolean);
begin
  FShowAreaLabels := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.SetBackPlaneLine(Value: TLMDChartLine);
begin
  FBackPlaneLine.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.SetBottomPlaneLine(Value: TLMDChartLine);
begin
  FBottomPlaneLine.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.SetLeftPlaneLine(Value: TLMDChartLine);
begin
  FLeftPlaneLine.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.SetBottomPlaneFill(Value: TLMDChartBackground);
begin
  FBottomPlaneFill.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.SetLeftPlaneFill(Value: TLMDChartBackground);
begin
  FLeftPlaneFill.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.SetLeftZGrid(Value: TLMDChartLine);
begin
  FLeftZGrid.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.SetIndent3D(Value: integer);
begin
  FIndent3D := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.SetShaded(Value: boolean);
begin
  FShaded := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.SetNoEdge(Value: boolean);
begin
  FNoEdge := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.SetBackPlaneFill(Value: TLMDChartBackground);
begin
  FBackPlaneFill := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;
{ --------------------- protected ---------------------------------------------}

procedure TLMDChartCTAreaSpline3D.DrawAreaLines(ATarget: TCanvas;
  AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
  AShowMarkers: boolean);
var
  a, i, j, c, l, k: integer;
  LAreaPoly: array of TPoint;
  LAreaCardinal: array of TPoint;
  PieceDepth, CurPos: integer;
  ColorB, ShadowColorV, ColorP: TColor;
  loaddata, tmp: variant;
  marker: TLMDChartMarker;
begin
  tmp:=0;
  marker := TLMDChartMarker.Create(self);
  PieceDepth := (FChartDepth - FIndent3D * (AValues.RowCount - 1)) div AValues.RowCount;
  a := AEndX - AStartX;
  SetLength(LAreaPoly, AValues.ColCount + 2);
  if ((AValues.ColCount - 1) > 0) and (AValues.RowCount > 0) then
  begin
    for i := 0 to AValues.RowCount - 1 do
    begin
      AValues.GetRowsLines(i).SetupCanvasPen(ATarget.Pen);
      ATarget.Brush.Color := AValues.GetRowFill(i).SolidColor;
      ColorB := ATarget.Brush.Color;

      if (FShaded) then
        ShadowColorV := ShadowColor(ATarget.Brush.Color, 100)
      else
        ShadowColorV := ColorB;

      if (FNoEdge) then
        ColorP := ShadowColor(ATarget.Brush.Color, 100)
      else
        ColorP := ATarget.Pen.Color;

      SetLength(LAreaCardinal, AValues.ColCount);
      CurPos := FChartDepth - PieceDepth * (i + 1) - FIndent3D * i;
      for k := PieceDepth downto 0 do
      begin
        if ((k <> 0) and (k <> PieceDepth)) or (FNoEdge) then
          ATarget.Pen.Color := ShadowColorV
        else
          ATarget.Pen.Color := ColorP;
        if k <> 0 then
          ATarget.Brush.Color := ShadowColorV
        else
          ATarget.Brush.Color := ColorB;
        for j := 0 to AValues.ColCount - 1 do
        begin
          if AValues.GetTableValue(j, i) = EmptyID then
            loaddata := 0
          else
            loaddata := AValues.GetTableValue(j, i);
          c := Trunc(a * ((1 / (AValues.ColCount - 1)) * j));
          LAreaPoly[j].X := AStartX + c + CurPos + k;
          LAreaPoly[j].Y := AEndY - CurPos - k - AYAxis.CalcPosFromBottom(AEndY - AStartY, loaddata, l);
          LAreaCardinal[j] := LAreaPoly[j];
          tmp := loaddata;
        end;
        HermitSplineExtArea(ATarget, LAreaCardinal, 50, 0.3, AEndY - CurPos - k - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l));
        if (not NoEdge) then
          ATarget.Pixels[AEndX + k + CurPos, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l) - CurPos - k - 1] := ColorP;
        if (not NoEdge) then
          ATarget.Pixels[AEndX + k + CurPos, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, tmp, l) - k - 1 - CurPos] := ColorP;
        if (not NoEdge) then
          ATarget.MoveTo(LAreaCardinal[0].X, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l) - CurPos - k - 1);
        if (not NoEdge) then
          DrawLineWithoutMove(LAreaCardinal[Length(LAreaCardinal) - 1].X, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l) - CurPos - k - 1, ATarget);
        if (not NoEdge) then
          ATarget.MoveTo(LAreaCardinal[Length(LAreaCardinal) - 1].X, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l) - CurPos - k - 1);
        if (not NoEdge) then
          DrawLineWithoutMove(LAreaCardinal[Length(LAreaCardinal) - 1].X, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, tmp, l) - CurPos - k - 1, ATarget);
      end;
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

procedure TLMDChartCTAreaSpline3D.DrawAreaLinesStacked(ATarget: TCanvas;
  AValues: TLMDChartData; AStartX, AEndX, AStartY, AEndY: integer; AYAxis: TLMDChartYAxis;
  AShowMarkers: boolean);
var
  a, i, j, c, l, k: integer;
  LAreaPoly: array of TPoint;
  LAreaCardinal: array of TPoint;
  LAccomulation: array of real;
  tmp: real;
  LIndent, LDepth: integer;
  ColorB, ShadowColorV, ColorP: TColor;
  loaddata: variant;
  marker: TLMDChartMarker;
begin
  marker := TLMDChartMarker.Create(self);
  tmp := 0;
  if (FChartDepth / 2 < FIndent3D) then
    LIndent := round(FChartDepth / 2)
  else
    LIndent := FIndent3D;
  LDepth := round(FChartDepth / 3);
  a := AEndX - AStartX;
  for k := LDepth downto 0 do
  begin
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

        ColorB := ATarget.Brush.Color;
        if (FShaded) then
          ShadowColorV := ShadowColor(ATarget.Brush.Color, 100)
        else
          ShadowColorV := ColorB;
        if (FNoEdge) then
          ColorP := ShadowColorV
        else
          ColorP := ATarget.Pen.Color;

        if ((k <> 0) and (k <> LDepth)) then
          ATarget.Pen.Color := ShadowColorV
        else
          ATarget.Pen.Color := ColorP;
        if (k = 0) and (FNoEdge) then
          ATarget.Pen.Color := ColorB;
        if k <> 0 then
          ATarget.Brush.Color := ShadowColorV
        else
          ATarget.Brush.Color := ColorB;

        SetLength(LAreaCardinal, AValues.ColCount);
        for j := 0 to AValues.ColCount - 1 do
        begin
          if AValues.GetTableValue(j, i) = EmptyID then
            loaddata := 0
          else
            loaddata := AValues.GetTableValue(j, i);
          c := Trunc(a * ((1 / (AValues.ColCount - 1)) * j));
          LAreaPoly[j].X := AStartX + c + LIndent + k;
          LAreaPoly[j].Y := AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, LAccomulation[j], l) - LIndent - k;

          LAreaCardinal[j] := LAreaPoly[j];
          tmp := LAccomulation[j];
          LAccomulation[j] := LAccomulation[j] - loaddata;
        end;
        HermitSplineExtArea(ATarget, LAreaCardinal, 50, 0.3, AEndY - k - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l) - LIndent);
        if (not NoEdge) then
          ATarget.Pixels[AEndX + LIndent + k, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l) - LIndent - k - 1] := ColorP;
        if (not NoEdge) then
          ATarget.Pixels[AEndX + LIndent + k, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, tmp, l) - LIndent - k - 1] := ColorP;
        if (not NoEdge) then
          ATarget.MoveTo(LAreaCardinal[0].X, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l) - LIndent - k - 1);
        if (not NoEdge) then
          DrawLineWithoutMove(LAreaCardinal[Length(LAreaCardinal) - 1].X, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l) - LIndent - k - 1, ATarget);
        if (not NoEdge) then
          ATarget.MoveTo(LAreaCardinal[Length(LAreaCardinal) - 1].X, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, 0, l) - LIndent - k - 1);
        if (not NoEdge) then
          DrawLineWithoutMove(LAreaCardinal[Length(LAreaCardinal) - 1].X, AEndY - AYAxis.CalcPosFromBottom(AEndY - AStartY, tmp, l) - LIndent - k - 1, ATarget);
        if FShowAreaLabels then
          //draw  columns labels
          for j := 0 to AValues.ColCount - 1 do
            if k = 0 then
            begin
              marker.Size := 5;
              marker.Style := TLMDChartMarkerTypes(i + 2);
              marker.Draw(ATarget, LAreaPoly[j].X + FLabelsMargin, LAreaPoly[j].Y);
              FAreaLabels.Draw(ATarget, AValues.GetRowsNames(i) + ': ' + floattostr(AValues.GetTableValue(j, i)), LAreaPoly[j].X + FLabelsMargin + FLabelsXDeviation + marker.Size + 25,
                LAreaPoly[j].Y + FLabelsYDeviation - round(marker.Size * 1.5), claLeftTop, clcHorizontal);
            end;
      end;
    end;
  end;
  marker.Free;
end;

{ --------------------- public ------------------------------------------------}

function TLMDChartCTAreaSpline3D.IsChanged: boolean;
begin
  if FAreaLabels.IsChanged then
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
  if FLeftZGrid.IsChanged then
    FChanged := true;
  if FBackPlaneFill.IsChanged then
    FChanged := true;
  IsChanged := FChanged;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline3D.NoChanged;
begin
  FChanged := false;
  FAreaLabels.NoChanged;
  FLeftPlaneLine.NoChanged;
  FBackPlaneLine.NoChanged;
  FBottomPlaneLine.NoChanged;
  FBottomPlaneFill.NoChanged;
  FLeftPlaneFill.NoChanged;
  FLeftZGrid.NoChanged;
  FBackPlaneFill.NoChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.ResetMainOwner(AmainOwner: TPersistent);
begin
  FMainOwner := AMainOwner;
  FAreaLabels.ResetOwner(FMainOwner);
  FLeftPlaneLine.ResetOwner(FMainOwner);
  FBackPlaneLine.ResetOwner(FMainOwner);
  FBottomPlaneLine.ResetOwner(FMainOwner);
  FBottomPlaneFill.ResetOwner(FMainOwner);
  FLeftPlaneFill.ResetOwner(FMainOwner);
  FLeftZGrid.ResetOwner(FMainOwner);
  FBackPlaneFill.ResetOwner(FMainOwner);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartCTAreaSpline3D.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNCTAreaSpline3D + NNSpace + Comment);

  FAreaLabels.LoadStateFromXML(WorkNode, '');
  FLeftPlaneLine.LoadStateFromXML(WorkNode, 'LeftPlaneLine');
  FBottomPlaneLine.LoadStateFromXML(WorkNode, 'BottomPlaneLine');
  FBottomPlaneFill.LoadStateFromXML(WorkNode, 'BottomPlaneFill');
  FLeftPlaneFill.LoadStateFromXML(WorkNode, 'LeftPlaneFill');
  FLeftZGrid.LoadStateFromXML(WorkNode, 'LeftZGrid');
  FBackPlaneFill.LoadStateFromXML(WorkNode, 'BackPlaneFill');

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

  IterNode := WorkNode.NeedChild('ChartDepth');
  FChartDepth := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('Indent3D');
  FIndent3D := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('Shaded');
  FShaded := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('NoLine');
  FNoEdge := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('Stacked');
  FStacked := IterNode.GetBoolAttr('value');
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline3D.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  IterNode := BaseNode.AppendElement('ChartType');
  IterNode.SetVarAttr('value', Variant(ChartAreaSpline3DID));

  WorkNode := BaseNode.EnsureChild(NNCTAreaSpline3D + NNSpace + Comment);

  FAreaLabels.SaveStateToXML(WorkNode, '');
  FLeftPlaneLine.SaveStateToXML(WorkNode, 'LeftPlaneLine');
  FBottomPlaneLine.SaveStateToXML(WorkNode, 'BottomPlaneLine');
  FBottomPlaneFill.SaveStateToXML(WorkNode, 'BottomPlaneFill');
  FLeftPlaneFill.SaveStateToXML(WorkNode, 'LeftPlaneFill');
  FLeftZGrid.SaveStateToXML(WorkNode, 'LeftZGrid');
  FBackPlaneFill.SaveStateToXML(WorkNode, 'BackPlaneFill');

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

  IterNode := WorkNode.AppendElement('ChartDepth');
  IterNode.SetVarAttr('value', FChartDepth);

  IterNode := WorkNode.AppendElement('Indent3D');
  IterNode.SetVarAttr('value', FIndent3D);

  IterNode := WorkNode.AppendElement('Shaded');
  IterNode.SetBoolAttr('value', FShaded);

  IterNode := WorkNode.AppendElement('NoLine');
  IterNode.SetBoolAttr('value', FNoEdge);

  IterNode := WorkNode.AppendElement('Stacked');
  IterNode.SetBoolAttr('value', FStacked);
end;
{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline3D.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartCTAreaSpline3D then
  begin
    try
      FAreaLabels.Assign(TLMDChartCTAreaSpline3D(ASource).FAreaLabels);
      FShowAreaLabels := TLMDChartCTAreaSpline3D(ASource).FShowAreaLabels;
      AreaTransparency := TLMDChartCTAreaSpline3D(ASource).FAreaTransparency;
      FLabelsYDeviation := TLMDChartCTAreaSpline3D(ASource).FLabelsYDeviation;
      FLabelsXDeviation := TLMDChartCTAreaSpline3D(ASource).FLabelsXDeviation;
      FLabelsMargin := TLMDChartCTAreaSpline3D(ASource).FLabelsMargin;
      FChartDepth := TLMDChartCTAreaSpline3D(ASource).FChartDepth;
      FShaded := TLMDChartCTAreaSpline3D(ASource).FShaded;
      FLeftPlaneLine.Assign(TLMDChartCTAreaSpline3D(ASource).FLeftPlaneLine);
      FBottomPlaneLine.Assign(TLMDChartCTAreaSpline3D(ASource).FBottomPlaneLine);
      FbackPlaneLine.Assign(TLMDChartCTAreaSpline3D(ASource).FbackPlaneLine);
      FLeftPlaneFill.Assign(TLMDChartCTAreaSpline3D(ASource).FLeftPlaneFill);
      FBottomPlaneFill.Assign(TLMDChartCTAreaSpline3D(ASource).FBottomPlaneFill);
      FLeftZGrid.Assign(TLMDChartCTAreaSpline3D(ASource).FLeftZGrid);
      FNoEdge := TLMDChartCTAreaSpline3D(ASource).FNoEdge;
      FBackPlaneFill.Assign(TLMDChartCTAreaSpline3D(ASource).FBackPlaneFill)
    finally
    end;
  end;
  inherited Assign(ASource);
end;
{ -----------------------------------------------------------------------------}

destructor TLMDChartCTAreaSpline3D.Destroy;
begin
  FAreaLabels.Free;
  FLeftZGrid.Free;
  FLeftPlaneLine.Free;
  FBackPlaneLine.Free;
  FBottomPlaneLine.Free;
  FLeftPlaneFill.Free;
  FBottomPlaneFill.Free;
  FBackPlaneFill.Free;
  inherited;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDChartCTAreaSpline3D.Draw(ABuffer: TBitmap; AArea: TRect; AValues: TLMDChartData;
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
  LPointArrBottom: TPointsArr;
  LPointArrLeft: TPointsArr;
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
  //column chart========================
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
      LCalculationTempVar := LXAxisEnd.X - LXAxisStart.X;
      if AValues.ColCount > 1 then
      begin
        for i := 0 to AValues.ColCount - 1 do
        begin
          LPositionOnAxis := Trunc(LCalculationTempVar * ((1 / (AValues.ColCount - 1)) * i));
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
        TextOut(LYLabes - 15, (LYAxisEnd.Y - LPositionOnAxis) - TextHeight(floattostr(LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i)) div 2, floattostr(LChArea.YAxis.MinValue + LChArea.YAxis.MajorStep * i) + AValues.ValIndicator);
      end;
    //draw planes
    DrawPlaneLines(ABuffer.Canvas, true, LPointArrLeft, LPointArrBottom, LRectBack, false, false, true);
    DrawPlaneLines(ABuffer.Canvas, false, LPointArrLeft, LPointArrBottom, LRectBack, false, false, true);
    DrawPlaneLines(ABuffer.Canvas, true, LPointArrLeft, LPointArrBottom, LRectBack, true, false, false);
    DrawPlaneLines(ABuffer.Canvas, false, LPointArrLeft, LPointArrBottom, LRectBack, true, false, false);

    // bottom
    if FBottomPlaneFill.Style = cbsNone then
      ABuffer.Canvas.Brush.Style := bsClear
    else
      ABuffer.Canvas.Brush.Color := FBottomPlaneFill.SolidColor;
    FBottomPlaneLine.SetupCanvasPen(ABuffer.Canvas.Pen);
    ABuffer.Canvas.Pen.Style := psClear;
    LMDChartUtils.Plane(ABuffer.Canvas, LXAxisStart, LXAxisEnd, FChartDepth, LPointArrBottom);
    FBottomPlaneFill.DrawBackgroundReg(ABuffer.Canvas, LPointArrBottom);
    ABuffer.Canvas.Pen.Style := psSolid;
  end;
  DrawPlaneLines(ABuffer.Canvas, true, LPointArrLeft, LPointArrBottom, LRectBack, false, true, false);
  DrawPlaneLines(ABuffer.Canvas, false, LPointArrLeft, LPointArrBottom, LRectBack, false, true, false);
  LWhiteBuf.Canvas.Brush.Color := clWhite;
  LWhiteBuf.Canvas.Pen.Style := psClear;
  LWhiteBuf.Canvas.FillRect(LWhiteBuf.Canvas.ClipRect);
  LBlackBuf.Canvas.Brush.Color := clBlack;
  LBlackBuf.Canvas.Pen.Style := psClear;
  LBlackBuf.Canvas.FillRect(LBlackBuf.Canvas.ClipRect);
  if (FStacked) then
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
  //DrawAreaLines(ABuffer.Canvas ,val,XAxisStart.X,XAxisend.X,YAxisStart.Y,YAxisEnd.Y,ChArea.YAxis, ChArea.ShowMarkers);
   // part of bottom plane
  if FBottomPlaneFill.Style = cbsNone then
    ABuffer.Canvas.Brush.Style := bsClear
  else
    ABuffer.Canvas.Brush.Color := FBottomPlaneFill.SolidColor;
  FBottomPlaneLine.SetupCanvasPen(ABuffer.Canvas.Pen);
  ABuffer.Canvas.Pen.Style := psClear;
  if not FStacked then
    LMDChartUtils.Plane(ABuffer.Canvas, LXAxisStart, LXAxisEnd,
      FChartDepth -
      ((FChartDepth - FIndent3D * (AValues.RowCount - 1)) div AValues.RowCount * (AValues.RowCount)
      + (FIndent3D) * (AValues.RowCount - 1)) + 1, LPointArrBottom)
  else
    LMDChartUtils.Plane(ABuffer.Canvas, LXAxisStart, LXAxisEnd, FIndent3D, LPointArrBottom);
  FBottomPlaneFill.DrawBackgroundReg(ABuffer.Canvas, LPointArrBottom);
  ABuffer.Canvas.Pen.Style := psSolid;
  //draw XAxis--------------
  with ABuffer.Canvas do
  begin
    Font.Assign(LChArea.XAxis.Font);
    LCalculationTempVar := LXAxisEnd.X - LXAxisStart.X;
    //draw all ticks and labels
    brush.Style := bsClear;
    if (AValues.ColCount - 1) > 0 then
    begin
      //major ticks
      for i := 0 to AValues.ColCount - 1 do
      begin
        LPositionOnAxis := Trunc(LCalculationTempVar * ((1 / (AValues.ColCount - 1)) * i));
        DrawXTick(ABuffer.Canvas, LXAxisStart.X + LPositionOnAxis, LXAxisStart.Y, LChArea.XAxis.MajorTickSize, LChArea.XAxis.MajorTick, FBottomPlaneLine);
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
  LMDChartUtils.Line(ABuffer.Canvas, LXAxisEnd, FChartDepth);
  LWhiteBuf.Free;
  LBlackBuf.Free;
end;

{ -----------------------------------------------------------------------------}

constructor TLMDChartCTAreaSpline3D.Create(AMainOwner: TComponent);
begin
  inherited Create(AMainOwner);
  FAreaLabels := TLMDChartLabel.Create(AMainOwner);
  FLeftZGrid := TLMDChartLine.Create(AMainOwner);
  FLeftPlaneLine := TLMDChartLine.Create(AMainOwner);
  FBackPlaneLine := TLMDChartLine.Create(AMainOwner);
  FBottomPlaneLine := TLMDChartLine.Create(AMainOwner);
  FLeftPlaneFill := TLMDChartBackground.Create(AMainOwner);
  FBottomPlaneFill := TLMDChartBackground.Create(AMainOwner);
  FBackPlaneFill := TLMDChartBackground.Create(AMainOwner);
  //default
  FShowAreaLabels := true;
  FAreaTransparency := 200;
  FLabelsMargin := 4;
  FLabelsYDeviation := 0;
  FLabelsXDeviation := 0;
  ChartDepth := 100;
  Indent3D := 10;
  Shaded := true;
  NoEdge := false;
  FStacked := false;
end;

procedure TLMDChartCTAreaSpline3D.SetChartDepth(const Value: integer);
begin
  FChartDepth := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

procedure TLMDChartCTAreaSpline3D.DrawPlaneLines(ATarget: TCanvas; Negative: boolean; leftPoly: TPointsArr; bottomPoly: TPointsArr; backRect: TRect; b, d, l: boolean);
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

    DrawLines(tmpBottom[0].x, tmpBottom[0].y - 1, tmpBottom[1].x - 1, tmpBottom[1].y - 1, tmpBottom[2].x - 1, tmpBottom[2].y, tmpBottom[3].x, tmpBottom[3].y, ATarget);
  end;
  if l then
  begin
    FLeftPlaneLine.SetupCanvasPen(ATarget.Pen);
    ATarget.Polyline(LeftPoly);
  end;
  if b then
  begin
    FBackPlaneLine.SetupCanvasPen(ATarget.Pen);

    DrawLines(tmpBack[0].x, tmpBack[0].y, tmpBack[1].x, tmpBack[1].y, tmpBack[2].x, tmpBack[2].y, tmpBack[3].x, tmpBack[3].y, ATarget);
  end;
end;

end.
