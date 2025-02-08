unit LMDChartLine;
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
LMDChartLegend
-----------------------------------

Changes
-------
Last (08-June-2006)

###############################################################################}

interface
uses

  Graphics,
  Classes,
  sysUtils,
  LMDXML,
  LMDXMLNodeNames,
  LMDChartPersistent;

type
  { ************************** TLMDChartLine ********************************* }
  /// <summary>
  /// Represents chart line
  /// </summary>
  TLMDChartLine = class(TLMDChartSeriesCollectionAttribute)
  private
    FWidth: integer;
    FColor: TColor;
    FStyle: TPenStyle;
    procedure SetWidth(Value: integer);
    procedure SetColor(Value: TColor);
    procedure SetStyle(Value: TPenStyle);
  public
    procedure Assign(ASource: TPersistent); override;
    constructor Create(AMainOwner: TPersistent); override;
    /// <summary>
    /// Setups canvas pen
    /// </summary>
    procedure SetupCanvasPen(ATarget: TPen);
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
  published
    property Width: integer read FWidth write SetWidth default 1;
    property Color: TColor read FColor write SetColor default clBlack;
    property Style: TPenStyle read FStyle write SetStyle default psSolid;
  end;

implementation

{ ************************** TLMDChartLine *********************************** }
{ -------------------------- private ----------------------------------------- }

procedure TLMDChartLine.SetWidth(Value: integer);
begin
  if Value <> FWidth then
  begin
    if Value <= 0 then
      Value := 1;
    FWidth := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartLine.SetColor(Value: TColor);
begin
  if Value <> FColor then
  begin
    FColor := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartLine.SetStyle(Value: TPenStyle);
begin
  if Value <> FStyle then
  begin
    FStyle := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ -------------------------- public ------------------------------------------ }

procedure TLMDChartLine.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNChartLine + Comment);

  IterNode := WorkNode.NeedChild('Width');
  FWidth := IterNode.GetIntAttr('value', 0);

  IterNode := WorkNode.NeedChild('Color');
  FColor := TColor(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('Style');
  FStyle := TPenStyle(IterNode.GetVarAttr('value', 0));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartLine.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.EnsureChild(NNChartLine + Comment);

  IterNode := WorkNode.AppendElement('Width');
  IterNode.SetIntAttr('value', FWidth);

  IterNode := WorkNode.AppendElement('Color');
  IterNode.SetVarAttr('value', FColor);

  IterNode := WorkNode.AppendElement('Style');
  IterNode.SetVarAttr('value', Variant(FStyle));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartLine.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartLine then
  begin
    try
      FWidth := TLMDChartLine(ASource).FWidth;
      FColor := TLMDChartLine(ASource).FColor;
      FStyle := TLMDChartLine(ASource).FStyle;
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartLine.Create(AMainOwner: TPersistent);
begin
  inherited Create(AMainOwner);
  //default values
  FColor := clBlack;
  FStyle := psSolid;
  FWidth := 1;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartLine.SetupCanvasPen(ATarget: TPen);
begin
  ATarget.Style := self.Style;
  ATarget.Width := self.Width;
  ATarget.Color := self.Color
end;

end.
