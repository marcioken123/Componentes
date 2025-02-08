unit LMDChartArea;
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
LMDChartArea unit
-----------------------------------

Changes
-------
Last (10-June-2006)

###############################################################################}

interface

uses
  Windows, Variants, Math, SysUtils, Classes, Controls, Graphics, Types, ExtCtrls,
  LMDXML, LMDXMLNodeNames, LMDChartPersistent, LMDChartUtils, LMDChartBackground,
  LMDChartData, LMDChartLine, LMDChartAxis, LMDChartFont, LMDChartMarker, LMDChartTypes,
  LMDChartCTColumn, LMDChartCTColumn3D, LMDChartCTBar, LMDChartCTAreaLine,
  LMDChartCTAreaLine3D, LMDChartCTPie2D, LMDChartCTBar3D, LMDChartCTAreaSpline,
  LMDChartCTDoughnut, LMDChartCTAreaSpline3D, LMDChartScaleBreak;

type
  { ****************************** TLMDChart ********************************* }
  /// <summary>
  /// Represents chart area
  /// </summary>
  TLMDChartArea = class(TLMDChartPersistent)
  private
    FSaveBuffer: TBitmap;
    FMarginLeft: integer;
    FMarginTop: integer;
    FMarginBottom: integer;
    FMarginRight: integer;
    FInnerIndentLeft: integer;
    FInnerIndentRight: integer;
    FInnerIndentTop: integer;
    FInnerIndentBottom: integer;
    FBackground: TLMDChartBackground;
    FChartType: TLMDChartCTAbstract;
    FMajorGridVertical: boolean;
    FMajorGridHorizontal: boolean;
    FMajorGridLineVertical: TLMDChartLine;
    FMajorGridLineHorizontal: TLMDChartLine;
    FShadowTransparency: byte;
    FShadowColor: TColor;
    FShadowDepth: byte;
    FShadow: boolean;
    FXAxis: TLMDChartAxis;
    FYAxis: TLMDChartYAxis;
    FVerticalAxisLeftOrient: boolean;
    FElementsTransparency: byte;
    FElementsShowValue: integer;
    FEdge: TLMDChartLine;
    FShowMarkers: boolean;
    procedure SetBackground(Value: TLMDChartBackground);
    procedure SetMarginLeft(Value: integer);
    procedure SetMarginTop(Value: integer);
    procedure SetMarginRight(Value: integer);
    procedure SetMarginBottom(Value: integer);
    procedure SetXAxis(Value: TLMDChartAxis);
    procedure SetYAxis(Value: TLMDChartYAxis);
    procedure SetInnerIndentLeft(Value: integer);
    procedure SetInnerIndentTop(Value: integer);
    procedure SetInnerIndentRight(Value: integer);
    procedure SetInnerIndentBottom(Value: integer);
    procedure SetEdge(Value: TLMDChartLine);
    procedure SetMajorGridVertical(Value: boolean);
    procedure SetMajorGridHorizontal(Value: boolean);
    procedure SetMajorGridLineVertical(Value: TLMDChartLine);
    procedure SetMajorGridLineHorizontal(Value: TLMDChartLine);
    procedure SetChartType(Value: TLMDChartCTAbstract);
    procedure SetShadowTransparency(Value: byte);
    procedure SetShadowColor(Value: TColor);
    procedure SetShadowDepth(Value: byte);
    procedure SetShadow(Value: boolean);
    procedure SetShowMarkers(Value: boolean);
    procedure CheckStacked(AValues: TLMDChartData);
  public
    procedure Assign(ASource: TPersistent); override;
    constructor Create(AMainOwner: TPersistent); override;
    procedure SetChanged;
    destructor Destroy; override;
    /// <summary>
    /// Draws object on canvas
    /// </summary>
    procedure DrawChart(ATarget: TCanvas; AArea: TRect; AValues: TLMDChartData);
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
  published
    property ShowMarkers: boolean read FShowMarkers write SetShowMarkers default true;
    property ChartType: TLMDChartCTAbstract read FChartType write SetChartType;
    property MajorGridVertical: boolean read FMajorGridVertical write SetMajorGridVertical default true;
    property MajorGridHorizontal: boolean read FMajorGridHorizontal write SetMajorGridHorizontal default true;
    property MajorGridLineVertical: TLMDChartLine read FMajorGridLineVertical write SetMajorGridLineVertical;
    property MajorGridLineHorizontal: TLMDChartLine read FMajorGridLineHorizontal write SetMajorGridLineHorizontal;
    property YAxis: TLMDChartYAxis read FYAxis write SetYAxis;
    property Edge: TLMDChartLine read FEdge write SetEdge;
    property XAxis: TLMDChartAxis read FXAxis write SetXAxis;
    property Background: TLMDChartBackground read FBackground write SetBackground;
    property MarginLeft: integer read FMarginLeft write SetMarginLeft default 20;
    property MarginTop: integer read FMarginTop write SetMarginTop default 0;
    property MarginBottom: integer read FMarginBottom write SetMarginBottom default 0;
    property MarginRight: integer read FMarginRight write SetMarginRight default 20;
    property InnerIndentLeft: integer read FInnerIndentLeft write SetInnerIndentLeft default 30;
    property InnerIndentRight: integer read FInnerIndentRight write SetInnerIndentRight default 30;
    property InnerIndentTop: integer read FInnerIndentTop write SetInnerIndentTop default 30;
    property InnerIndentBottom: integer read FInnerIndentBottom write SetInnerIndentBottom default 30;
    property ShadowTransparency: byte read FShadowTransparency write SetShadowTransparency default 255;
    property ShadowColor: TColor read FShadowColor write SetShadowColor default clBlack;
    property ShadowDepth: byte read FShadowDepth write SetShadowDepth default 4;
    property Shadow: boolean read FShadow write SetShadow default false;
  end;

var
  HadChanged: boolean;

implementation

{ ***************************** TLMDChartArea ******************************** }
{ ---------------------------- private --------------------------------------- }

procedure TLMDChartArea.SetBackground(Value: TLMDChartBackground);
begin
  if Value <> FBackground then
  begin
    FBackground.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetMarginLeft(Value: integer);
begin
  if Value <> FMarginLeft then
  begin
    FMarginLeft := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetMarginTop(Value: integer);
begin
  if Value <> FMarginTop then
  begin
    FMarginTop := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetMarginRight(Value: integer);
begin
  if Value <> FMarginRight then
  begin
    FMarginRight := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetMarginBottom(Value: integer);
begin
  if Value <> FMarginBottom then
  begin
    FMarginBottom := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetXAxis(Value: TLMDChartAxis);
begin
  if Value <> FXAxis then
  begin
    FXAxis.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetYAxis(Value: TLMDChartYAxis);
begin
  if Value <> FYAxis then
  begin
    FYAxis.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetInnerIndentLeft(Value: integer);
begin
  if Value <> FInnerIndentLeft then
  begin
    FInnerIndentLeft := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetInnerIndentTop(Value: integer);
begin
  if Value <> FInnerIndentTop then
  begin
    FInnerIndentTop := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetInnerIndentRight(Value: integer);
begin
  if Value <> FInnerIndentRight then
  begin
    FInnerIndentRight := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetInnerIndentBottom(Value: integer);
begin
  if Value <> FInnerIndentBottom then
  begin
    FInnerIndentBottom := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetEdge(Value: TLMDChartLine);
begin
  if Value <> FEdge then
  begin
    FEdge.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetMajorGridVertical(Value: boolean);
begin
  if Value <> FMajorGridVertical then
  begin
    FMajorGridVertical := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetMajorGridHorizontal(Value: boolean);
begin
  if Value <> FMajorGridHorizontal then
  begin
    FMajorGridHorizontal := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetMajorGridLineVertical(Value: TLMDChartLine);
begin
  if Value <> FMajorGridLineVertical then
  begin
    FMajorGridLineVertical.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetMajorGridLineHorizontal(Value: TLMDChartLine);
begin
  if Value <> FMajorGridLineHorizontal then
  begin
    FMajorGridLineHorizontal.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetChartType(Value: TLMDChartCTAbstract);
begin
  if FChartType <> nil then
  begin
    FChartType.FChartArea := nil;
    FChartType.FMainOwner := nil;
    FChartType := nil;
  end;
  FChartType := Value;
  if FChartType <> nil then
  begin
    FChartType.ResetMainOwner(FMainOwner);
    FChartType.FChartArea := self;
  end;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetShadowTransparency(Value: byte);
begin
  if Value <> FShadowTransparency then
  begin
    FShadowTransparency := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetShadowColor(Value: TColor);
begin
  if Value <> FShadowColor then
  begin
    FShadowColor := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetShadowDepth(Value: byte);
begin
  if Value <> FShadowDepth then
  begin
    if Value > 20 then
      Value := 20;
    FShadowDepth := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetShadow(Value: boolean);
begin
  if Value <> FShadow then
  begin
    FShadow := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetShowMarkers(Value: boolean);
begin
  if Value <> FShowMarkers then
  begin
    FShowMarkers := value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------- public ---------------------------------------- }

procedure TLMDChartArea.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin

  WorkNode := BaseNode.EnsureChild(NNChartArea + Comment);

  FBackground.SaveStateToXML(WorkNode, '');
  FMajorGridLineVertical.SaveStateToXML(WorkNode, 'MajorGridLineVertical');
  FMajorGridLineHorizontal.SaveStateToXML(WorkNode, 'MajorGridLineHorizontal');
  FEdge.SaveStateToXML(WorkNode, 'Edge');
  FXAxis.SaveStateToXML(WorkNode, '');
  FYAxis.SaveStateToXML(WorkNode, '');

  IterNode := WorkNode.AppendElement('MarginLeft');
  IterNode.SetVarAttr('value', FMarginLeft);

  IterNode := WorkNode.AppendElement('MarginTop');
  IterNode.SetVarAttr('value', FMarginTop);

  IterNode := WorkNode.AppendElement('MarginBottom');
  IterNode.SetVarAttr('value', FMarginBottom);

  IterNode := WorkNode.AppendElement('MarginRight');
  IterNode.SetVarAttr('value', FMarginRight);

  IterNode := WorkNode.AppendElement('InnerIndentLeft');
  IterNode.SetVarAttr('value', FInnerIndentLeft);

  IterNode := WorkNode.AppendElement('InnerIndentRight');
  IterNode.SetVarAttr('value', FInnerIndentRight);

  IterNode := WorkNode.AppendElement('InnerIndentTop');
  IterNode.SetVarAttr('value', FInnerIndentTop);

  IterNode := WorkNode.AppendElement('InnerIndentBottom');
  IterNode.SetVarAttr('value', FInnerIndentBottom);

  IterNode := WorkNode.AppendElement('MajorGridVertical');
  IterNode.SetBoolAttr('value', FMajorGridVertical);

  IterNode := WorkNode.AppendElement('MajorGridHorizontal');
  IterNode.SetBoolAttr('value', FMajorGridHorizontal);

  IterNode := WorkNode.AppendElement('ShadowTransparency');
  IterNode.SetVarAttr('value', FShadowTransparency);

  IterNode := WorkNode.AppendElement('ShadowColor');
  IterNode.SetVarAttr('value', FShadowColor);

  IterNode := WorkNode.AppendElement('ShadowDepth');
  IterNode.SetVarAttr('value', FShadowDepth);

  IterNode := WorkNode.AppendElement('Shadow');
  IterNode.SetBoolAttr('value', FShadow);

  IterNode := WorkNode.AppendElement('VerticalAxisLeftOrient');
  IterNode.SetBoolAttr('value', FVerticalAxisLeftOrient);

  IterNode := WorkNode.AppendElement('ElementsTransparency');
  IterNode.SetVarAttr('value', FElementsTransparency);

  IterNode := WorkNode.AppendElement('ElementsShowValue');
  IterNode.SetVarAttr('value', FElementsShowValue);

  IterNode := WorkNode.AppendElement('ShowMarkers');
  IterNode.SetBoolAttr('value', FShowMarkers);

  FChartType.SaveStateToXML(WorkNode, ''); {!!!!!!!}
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
  FChartTypeID: TChartTypeID;
  CT: TLMDChartCTAbstract;
begin

  WorkNode := BaseNode.NeedChild(NNChartArea + Comment);

  FBackground.LoadStateFromXML(WorkNode, '');
  FMajorGridLineVertical.LoadStateFromXML(WorkNode, 'MajorGridLineVertical');
  FMajorGridLineHorizontal.LoadStateFromXML(WorkNode, 'MajorGridLineHorizontal');
  FEdge.LoadStateFromXML(WorkNode, 'Edge');
  FXAxis.LoadStateFromXML(WorkNode, '');
  FYAxis.LoadStateFromXML(WorkNode, '');

  IterNode := WorkNode.NeedChild('MarginLeft');
  FMarginLeft := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MarginTop');
  FMarginTop := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MarginBottom');
  FMarginBottom := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MarginRight');
  FMarginRight := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('InnerIndentLeft');
  FInnerIndentLeft := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('InnerIndentRight');
  FInnerIndentRight := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('InnerIndentTop');
  FInnerIndentTop := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('InnerIndentBottom');
  FInnerIndentBottom := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MajorGridVertical');
  FMajorGridVertical := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('MajorGridHorizontal');
  FMajorGridHorizontal := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ShadowTransparency');
  FShadowTransparency := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ShadowColor');
  FShadowColor := TColor(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('ShadowDepth');
  FShadowDepth := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('Shadow');
  FShadow := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('VerticalAxisLeftOrient');
  FVerticalAxisLeftOrient := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ElementsTransparency');
  FElementsTransparency := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ElementsShowValue');
  FElementsShowValue := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('ShowMarkers');
  FShowMarkers := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('ChartType');
  FChartTypeID := TChartTypeID(IterNode.GetVarAttr('value', 0));

  case FChartTypeID of

    ChartAreaLineID:
      begin
        CT := TLMDChartCTAreaLine.Create(nil);
        CT.LoadStateFromXML(WorkNode, '');
        FChartType := CT;
      end;

    ChartAreaLine3DID:
      begin
        CT := TLMDChartCTAreaLine3D.Create(nil);
        CT.LoadStateFromXML(WorkNode, '');
        FChartType := CT;
      end;

    ChartAreaSplineID:
      begin
        CT := TLMDChartCTAreaSpline.Create(nil);
        CT.LoadStateFromXML(WorkNode, '');
        FChartType := CT;
      end;

    ChartAreaSpline3DID:
      begin
        CT := TLMDChartCTAreaSpline3D.Create(nil);
        CT.LoadStateFromXML(WorkNode, '');
        FChartType := CT;
      end;

    ChartBarID:
      begin
        CT := TLMDChartCTBar.Create(nil);
        CT.LoadStateFromXML(WorkNode, '');
        FChartType := CT;
      end;

    ChartBar3DID:
      begin
        CT := TLMDChartCTBar3d.Create(nil);
        CT.LoadStateFromXML(WorkNode, '');
        FChartType := CT;
      end;

    ChartColumnID:
      begin
        CT := TLMDChartCTColumn.Create(nil);
        CT.LoadStateFromXML(WorkNode, '');
        FChartType := CT;
      end;

    ChartColumn3DID:
      begin
        CT := TLMDChartCTColumn3D.Create(nil);
        CT.LoadStateFromXML(WorkNode, '');
        FChartType := CT;
      end;

    ChartPieID:
      begin
        CT := TLMDChartCTPie2D.Create(nil);
        CT.LoadStateFromXML(WorkNode, '');
        FChartType := CT;
      end;

    ChartDoughnutID:
      begin
        CT := TLMDChartCTDoughnut.Create(nil);
        CT.LoadStateFromXML(WorkNode, '');
        FChartType := CT;
      end;
  end;
  FChanged := true;
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartArea then
  begin
    try
      FMarginLeft := TLMDChartArea(ASource).FMarginLeft;
      FMarginTop := TLMDChartArea(ASource).FMarginTop;
      FMarginBottom := TLMDChartArea(ASource).FMarginTop;
      FMarginRight := TLMDChartArea(ASource).FMarginRight;
      FBackground.Assign(TLMDChartArea(ASource));
      FChartType := TLMDChartArea(ASource).FChartType;
      FMajorGridVertical := TLMDChartArea(ASource).FMajorGridVertical;
      FMajorGridHorizontal := TLMDChartArea(ASource).FMajorGridHorizontal;
      FMajorGridLineVertical.Assign(TLMDChartArea(ASource).FMajorGridLineVertical);
      FMajorGridLineHorizontal.Assign(TLMDChartArea(ASource).FMajorGridLineHorizontal);
      FXAxis.Assign(TLMDChartArea(ASource).FXAxis);
      FYAxis.Assign(TLMDChartArea(ASource).FYAxis);
      FVerticalAxisLeftOrient := TLMDChartArea(ASource).FVerticalAxisLeftOrient;
      FElementsTransparency := TLMDChartArea(ASource).FElementsTransparency;
      FElementsShowValue := TLMDChartArea(ASource).FElementsShowValue;
      FShadowColor := TLMDChartArea(ASource).FShadowColor;
      FShadowTransparency := TLMDChartArea(ASource).FShadowTransparency;
      FShadowDepth := TLMDChartArea(ASource).FShadowColor;
      FShadow := TLMDChartArea(ASource).FShadow;
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartArea.Create(AMainOwner: TPersistent);
begin
  inherited Create(AMainOwner);
  FChartType := nil;
  FBackground := TLMDChartBackground.Create(AMainOwner);
  FmajorGridLineVertical := TLMDChartLine.Create(AMainOwner);
  FMajorGridLineHorizontal := TLMDChartLine.Create(AMainOwner);
  FmajorGridVertical := true;
  FMajorGridHorizontal := true;
  FXAxis := TLMDChartAxis.Create(AMainOwner);
  FYAxis := TLMDChartYAxis.Create(AMainOwner);
  FEdge := TLMDChartLine.Create(AMainOwner);
  FChanged := true;
  FSaveBuffer := TBitmap.Create;

  //  default property values.

  FMarginLeft := 10;
  FMarginTop := 10;
  FMarginBottom := 10;
  FMarginRight := 10;
  FInnerIndentLeft := 20;
  FInnerIndentRight := 20;
  FInnerIndentTop := 20;
  FInnerIndentBottom := 20;
  FMajorGridVertical := true;
  FMajorGridHorizontal := true;
  FShadowTransparency := 255;
  FShadowColor := clBlack;
  FShadowDepth := 4;
  FShadow := false;
  ShowMarkers := true;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartArea.Destroy;
begin
  FEdge.Free;
  FBackground.Free;
  FMajorGridLineVertical.Free;
  FMajorGridLineHorizontal.Free;
  FXAxis.Free;
  FYAxis.Free;
  if FChartType <> nil then
  begin
    FChartType.FChartArea := nil;
    FChartType.FMainOwner := nil;
    FChartType := nil;
  end;
  FSaveBuffer.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.DrawChart(ATarget: TCanvas; AArea: TRect; AValues: TLMDChartData);
var
  LTempBitmap, LBuffer: TBitmap;
  HiForStakedStore: boolean;
  HiValueStore: double;
  flagScaleBreak: boolean;
  autoflag: boolean;
begin
  autoflag := False;
  if (AValues.IsChanged or FBackground.IsChanged or FMajorGridLineVertical.IsChanged or
    FMajorGridLineHorizontal.IsChanged or FEdge.IsChanged or
    FXAxis.IsChanged or FYAxis.IsChanged or FChartType.IsChanged) then
    FChanged := true;
  if FChanged then
  begin
    if AValues.IsChanged then
      if YAxis.AutoScale = true then
      begin
        YAxis.AutoScale := not YAxis.AutoScale;
        YAxis.AutoScale := not YAxis.AutoScale;
      end;
    flagScaleBreak := false;

    CheckStacked(AValues);
    if FYAxis.ScaleBreak.ProcessAutoAppearance(AValues) then
    begin
      if (YAxis.ScaleBreak.Enabled) then
      begin
        if (FChartType is TLMDChartCTColumn) then
          if not TLMDChartCTColumn(FChartType).ColumnsStacked then
            flagScaleBreak := true;
        if (FChartType is TLMDChartCTBar) then
          if not TLMDChartCTBar(FChartType).BarsStacked then
            flagScaleBreak := true;
        if (FChartType is TLMDChartCTColumn3D) then
          if not TLMDChartCTColumn3D(FChartType).Stacked then
            flagScaleBreak := true;
        if (FChartType is TLMDChartCTBar3D) then
          if not TLMDChartCTBar3D(FChartType).Stacked then
            flagScaleBreak := true;
      end;
      if flagScaleBreak then
      begin
        autoflag := FYAxis.AutoScale;
        FYAxis.AutoScale := false;
        if (FYAxis.MaxValue <= AValues.HighestValue) then
          FYAxis.MaxValue := AValues.HighestValue - FYAxis.ScaleBreak.PositiveHighLimit + FYAxis.ScaleBreak.PositiveLowLimit;
        if (-FYAxis.MaxValue >= AValues.LowestValue) then
          FYAxis.MinValue := AValues.LowestValue - FYAxis.ScaleBreak.NegativeHighLimit + FYAxis.ScaleBreak.NegativeLowLimit;
        FYAxis.MajorStep := 10;
        FYAxis.MinorStep := 5;
      end;
    end;
    //checking the size of drawing area
    HiForStakedStore := AValues.HighestForStacked;
    HiValueStore := YAxis.MaxValue;
    if (AArea.Bottom - AArea.Top - FMarginTop - FMarginBottom <= 0)
      or
      (AArea.Right - AArea.Left - FMarginLeft - FMarginRight <= 0) then
      exit;

    //buffer initialize
    LBuffer := TBitmap.Create;
    LBuffer.Height := AArea.Bottom - AArea.Top - FMarginTop - FMarginBottom;
    LBuffer.Width := AArea.Right - AArea.Left - FMarginLeft - FMarginRight;

    FSaveBuffer.Height := AArea.Bottom - AArea.Top;
    FSaveBuffer.Width := AArea.Right - AArea.Left;

    //chart area background drawing
    if Background.Style = cbsNone then
      LBuffer.Canvas.CopyRect(LBuffer.Canvas.ClipRect,
        ATarget, rect(AArea.Left + FMarginLeft, AArea.Top + FMarginTop,
        AArea.Left + FMarginLeft + LBuffer.Canvas.ClipRect.Right,
        AArea.Top + FMarginTop + LBuffer.Canvas.ClipRect.Bottom));

    Background.DrawBackground(LBuffer.Canvas, LBuffer.Canvas.ClipRect);

    //chart edge
    FEdge.SetupCanvasPen(LBuffer.Canvas.Pen);
    LBuffer.Canvas.Brush.Style := bsClear;
    LBuffer.Canvas.Rectangle(0, 0, LBuffer.Width, LBuffer.Height);

    if (FYAxis.InvertedChanged) then
    begin
      AValues.InvertedRecalculate;
      FYAxis.ChangeInverted;
    end;

    if ChartType <> nil then
      ChartType.Draw(LBuffer, ATarget.ClipRect, AValues, self);
    //draw result on target canvas
    ATarget.Draw(AArea.Left + FMarginLeft, AArea.Top + FMarginTop, LBuffer);
    LBuffer.Free;

    if FShadow and (FShadowTransparency > 0) then
    begin
      LTempBitMap := TBitmap.Create;
      LTempBitMap.Width := ATarget.ClipRect.Right - ATarget.ClipRect.Left;
      LTempBitMap.Height := ATarget.ClipRect.Bottom - ATarget.ClipRect.Top;
      LTempBitMap.Canvas.CopyRect(LTempBitMap.Canvas.ClipRect, ATarget, ATarget.ClipRect);
      DrawRectangleShadow(FMarginLeft + AArea.Left, FMarginTop + AArea.Top, AArea.Right - AArea.Left - FMarginLeft - FMarginRight, AArea.Bottom - AArea.Top - FMarginTop - FMarginBottom, LTempBitMap, FShadowColor, FShadowDepth, FShadowTransparency, FShadow);
      ATarget.CopyRect(ATarget.ClipRect, LTempBitMap.Canvas, LTempBitMap.Canvas.ClipRect);
      LTempBitMap.Free;
    end;

    FSaveBuffer.Canvas.CopyRect(rect(0, 0, FSaveBuffer.Width, FSaveBuffer.Height), ATarget,
      rect(AArea.Left, AArea.Top, FSaveBuffer.Width + AArea.Left, FSaveBuffer.Height + AArea.Top));

    AValues.HighestForStacked := HiForStakedStore;
    YAxis.MaxValue := HiValueStore;
    if flagScaleBreak then
      FYAxis.AutoScale := autoflag;
    FChanged := false;
    AValues.NoChanged;
    FBackground.NoChanged;
    FEdge.NoChanged;
    FMajorGridLineHorizontal.NoChanged;
    FMajorGridLineVertical.NoChanged;
    FXAxis.NoChanged;
    FYAxis.NoChanged;
    FChartType.NoChanged;
  end
  else
    ATarget.Draw(AArea.Left, AArea.Top, FSaveBuffer);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartArea.SetChanged;
begin
  FChanged := true;
end;

procedure TLMDChartArea.CheckStacked(AValues: TLMDChartData);
var
  flag: boolean;
begin
  flag := AValues.HighestForStacked;
  AValues.HighestForStacked := false;
  if FChartType is TLMDChartCTColumn then
    if TLMDChartCTColumn(FChartType).ColumnsStacked then
      AValues.HighestForStacked := true;
  if FChartType is TLMDChartCTColumn3D then
    if TLMDChartCTColumn3D(FChartType).Stacked then
      AValues.HighestForStacked := true;
  if FChartType is TLMDChartCTBar then
    if TLMDChartCTBar(FChartType).BarsStacked then
      AValues.HighestForStacked := true;
  if FChartType is TLMDChartCTBar3D then
    if TLMDChartCTBar3D(FChartType).Stacked then
      AValues.HighestForStacked := true;
  if FChartType is TLMDChartCTAreaLine then
    if TLMDChartCTAreaLine(FChartType).AreaStacked then
      AValues.HighestForStacked := true;
  if FChartType is TLMDChartCTAreaLine3D then
    if TLMDChartCTAreaLine3D(FChartType).Stacked then
      AValues.HighestForStacked := true;
  if FChartType is TLMDChartCTAreaSpline then
    if TLMDChartCTAreaSpline(FChartType).AreaStacked then
      AValues.HighestForStacked := true;
  if FChartType is TLMDChartCTAreaSpline3D then
    if TLMDChartCTAreaSpline3D(FChartType).Stacked then
      AValues.HighestForStacked := true;
  if flag <> AValues.HighestForStacked then
    if YAxis.AutoScale = true then
    begin
      YAxis.AutoScale := not YAxis.AutoScale;
      YAxis.AutoScale := not YAxis.AutoScale;
    end;
end;

end.
