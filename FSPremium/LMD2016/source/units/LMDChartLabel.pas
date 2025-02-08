unit LMDChartLabel;
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
LMDChartLabel
------------

Changes
-------
Last (07-June-2006)

###############################################################################}

interface

uses
  Windows, Graphics, Classes, Variants, Types,
  LMDXML, LMDXMLNodeNames, LMDChartPersistent, LMDChartBackground, LMDChartLine,
  LMDChartFont;

type
  TLMDChartLableAlign = (claLeftTop, claLeftBottom, claRightTop, claRightBottom);
  TLMDChartLableCentring = (clcNone, clcHorizontal, clcVertical, clcHorzVert);
  TLMDChartLabelAlign = (claRightSide, claLeftSide, claSmart);

  { *********************** TLMDChartLabel *********************************** }
  /// <summary>
  /// Represents label
  /// </summary>
  TLMDChartLabel = class(TLMDChartPersistent)
  private
    FShowBackground: boolean;
    FBackground: TLMDChartBackground;
    FEdge: TLMDChartLine;
    FFont: TLMDChartFont;
    FIndent: integer;
    procedure SetBackground(Value: TLMDChartBackground);
    procedure SetEdge(Value: TLMDChartLine);
    procedure SetFont(Value: TLMDChartFont);
    procedure SetIndent(Value: integer);
    procedure SetShowBackground(Value: boolean);
  public
    procedure Assign(ASource: TPersistent); override;
    constructor Create(AMainOwner: TPersistent); override;
    destructor Destroy; override;
    /// <summary>
    /// Draws object on canvas
    /// </summary>
    procedure Draw(ATarget: TCanvas; AText: string; AX, AY: integer;
      AAlign: TLMDChartLableAlign; ACentring: TLMDChartLableCentring);
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
    function IsChanged: boolean; override;
    procedure NoChanged; override;
    procedure ResetOwner(AMainOwner: TPersistent);
  published
    property Indent: integer read FIndent write SetIndent default 5;
    property ShowBackground: boolean read FShowBackground write SetShowBackground stored true default true;
    property Edge: TLMDChartLine read FEdge write SetEdge;
    property Font: TLMDChartFont read FFont write SetFont;
    property Background: TLMDChartBackground read FBackground write SetBackground;
  end;

implementation

{ *********************** TLMDChartLabel ************************************* }
{ ---------------------------------------------------------------------------- }

procedure TLMDChartLabel.SetBackground(Value: TLMDChartBackground);
begin
  if Value <> FBackground then
  begin
    FBackground.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartLabel.SetEdge(Value: TLMDChartLine);
begin
  if Value <> FEdge then
  begin
    FEdge.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartLabel.SetFont(Value: TLMDChartFont);
begin
  if Value <> FFont then
  begin
    FFont.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartLabel.SetIndent(Value: integer);
begin
  if Value <> FIndent then
  begin
    FIndent := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartLabel.SetShowBackground(Value: boolean);
begin
  if Value <> FShowBackground then
  begin
    FShowBackground := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ----------------------- public --------------------------------------------- }

procedure TLMDChartLabel.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartLabel then
  begin
    try
      FIndent := TLMDChartLabel(ASource).FIndent;
      FShowBackground := TLMDChartLabel(ASource).FShowBackground;
      FBackground.Assign(TLMDChartLabel(ASource).FBackground);
      FEdge.Assign(TLMDChartLabel(ASource).FEdge);
      FFont.Assign(TLMDChartLabel(ASource).FFont);
    finally
    end;
  end;
  inherited Assign(ASource);
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartLabel.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin

  WorkNode := BaseNode.EnsureChild(NNChartLabel + Comment);

  FFont.SaveStateToXML(WorkNode, '');
  FEdge.SaveStateToXML(WorkNode, '');
  FBackground.SaveStateToXML(WorkNode, '');

  IterNode := WorkNode.AppendElement('ShowBackground');
  IterNode.SetBoolAttr('value', FShowBackground);

  IterNode := WorkNode.AppendElement('Indent');
  IterNode.SetVarAttr('value', Variant(FIndent));
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartLabel.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin

  WorkNode := BaseNode.NeedChild(NNChartLabel + Comment);

  FFont.LoadStateFromXML(WorkNode, '');
  FEdge.LoadStateFromXML(WorkNode, '');
  FBackground.LoadStateFromXML(WorkNode, '');

  IterNode := WorkNode.NeedChild('ShowBackground');
  FShowBackground := IterNode.GetBoolAttr('value');

  IterNode := WorkNode.NeedChild('Indent');
  FIndent := IterNode.GetVarAttr('value', 0);
end;
{ ---------------------------------------------------------------------------- }

constructor TLMDChartLabel.Create(AMainOwner: TPersistent);
begin
  inherited Create(AMainOwner);
  FBackground := TLMDChartBackground.Create(AMainOwner);
  FEdge := TLMDChartLine.Create(AMainOwner);
  FFont := TLMDChartFont.Create(AMainOwner);
  FIndent := 2;
  FShowBackground := true;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartLabel.Destroy;
begin
  FBackground.Free;
  FEdge.Free;
  FFont.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartLabel.Draw(ATarget: TCanvas; AText: string; AX, AY: integer;
  AAlign: TLMDChartLableAlign; ACentring: TLMDChartLableCentring);
begin
  ATarget.Font.Assign(FFont);
  case AAlign of
    claLeftTop: ;
    claLeftBottom:
      AY := AY - (FIndent * 2 + ATarget.TextHeight(AText));
    claRightTop:
      AX := AX - (FIndent * 2 + ATarget.TextWidth(AText));
    claRightBottom:
      begin
        AX := AX - (FIndent * 2 + ATarget.TextWidth(AText));
        AY := AY - (FIndent * 2 + ATarget.TextHeight(AText));
      end;
  end;
  if (ACentring = clcHorzVert) and (AAlign = claLeftTop) then
  begin
    AX := AX - (FIndent + ATarget.TextWidth(AText) div 2);
    AY := AY - (FIndent + ATarget.TextHeight(AText) div 2);
  end;
  if (ACentring = clcHorizontal) and ((AAlign = claLeftTop) or (AAlign = claLeftBottom)) then
  begin
    AX := AX - (FIndent + ATarget.TextWidth(AText) div 2);
  end;
  if (ACentring = clcVertical) and ((AAlign = claLeftTop) or (AAlign = claRightTop)) then
  begin
    AY := AY - (FIndent + ATarget.TextHeight(AText) div 2);
  end;
  if FShowBackground then
    FBackground.DrawRectangle(ATarget, FEdge,
      AX,
      AY,
      AX + FIndent * 2 + ATarget.TextWidth(AText) + 1,
      AY + FIndent * 2 + ATarget.TextHeight(AText));
  ATarget.Brush.Style := bsClear;
  ATarget.TextOut(AX + FIndent, AY + FIndent, AText);
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartLabel.IsChanged: boolean;
begin
  if FBackground.IsChanged = true then
    FChanged := true;
  if FEdge.IsChanged = true then
    FChanged := true;

  IsChanged := FChanged;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartLabel.NoChanged;
begin
  FChanged := false;
  FBackground.NoChanged;
  FEdge.NoChanged;
end;

{ ------------------------- public ------------------------------------------- }

procedure TLMDChartLabel.ResetOwner(AMainOwner: TPersistent);
begin
  FMainOwner := AMainOwner;
  FBackground.ResetOwner(FMainOwner);
  FEdge.ResetOwner(FMainOwner);
end;

end.
