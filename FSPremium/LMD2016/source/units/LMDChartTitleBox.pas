unit LMDChartTitleBox;
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
LMDChartTitleBox
-----------------------------------

Changes
-------
Last (10-June-2006)

###############################################################################}

interface

uses
  Windows, Graphics, Classes, Variants, Types, Math,
  LMDXML, LMDXMLNodeNames, LMDChartBackground, LMDChartPersistent, LMDChartLine,
  LMDChartData, LMDChartFont;

type
  TLMDChartAlignment = (caTop, caBottom, caLeft, caRigth);
  { ******************** TLMDChartTitleBox *********************************** }
  /// <summary>
  /// Represents title box
  /// </summary>
  TLMDChartTitleBox = class(TLMDChartPersistent)
  private
    FText: string;
    FFont: TLMDChartFont;
    FAlignment: TLMDChartAlignment;
    FBackground: TLMDChartBackground;
    FEdge: TLMDChartLine;
    FIcon: TPicture;
    FMarginEdge: integer;
    FMarginChart: integer;
    FIconAlignment: TLMDChartAlignment;
    FInnerIndentLeft: integer;
    FInnerIndentRight: integer;
    FInnerIndentTop: integer;
    FInnerIndentBottom: integer;
    FIconMargin: integer;
    procedure SetFont(Value: TLMDChartFont);
    procedure SetBackground(Value: TLMDChartBackground);
    procedure SetIcon(Value: TPicture);
    procedure SetEdge(Value: TLMDChartLine);
    procedure SetIconMargin(Value: integer);
    procedure SetIconAlignment(Value: TLMDChartAlignment);
    procedure SetInnerIndentBottom(Value: integer);
    procedure SetInnerIndentLeft(Value: integer);
    procedure SetInnerIndentRight(Value: integer);
    procedure SetInnerIndentTop(Value: integer);
    procedure SetAlignment(Value: TLMDChartAlignment);
    procedure SetMarginChart(Value: integer);
    procedure SetMarginEdge(Value: integer);
  protected
    procedure DrawIconTrnsp(ATarget: TCanvas; AX, AY: integer; ATranspColor: TColor);
  public
    procedure Assign(ASource: TPersistent); override;
    constructor Create(AMainOwner: TPersistent); override;
    destructor Destroy; override;
    /// <summary>
    /// Draws object on canvas
    /// </summary>
    function Draw(ATarget: TCanvas; AArea: TRect): TRect;
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
  published
    property Text: string read FText write FText;
    property Font: TLMDChartFont read FFont write SetFont;
    property Alignment: TLMDChartAlignment read FAlignment write SetAlignment default caBottom;
    property Background: TLMDChartBackground read FBackground write SetBackground;
    property Edge: TLMDChartLine read FEdge write SetEdge;
    property Icon: TPicture read FIcon write SetIcon;
    property MarginEdge: integer read FMarginEdge write SetMarginEdge default 5;
    property MarginChart: integer read FMarginChart write SetMarginChart default 5;
    property IconMargin: integer read FIconMargin write SetIconMargin default 5;
    property IconAlignment: TLMDChartAlignment read FIconAlignment write SetIconAlignment default caLeft;
    property InnerIndentLeft: integer read FInnerIndentLeft write SetInnerIndentLeft default 4;
    property InnerIndentRight: integer read FInnerIndentRight write SetInnerIndentRight default 4;
    property InnerIndentTop: integer read FInnerIndentTop write SetInnerIndentTop default 4;
    property InnerIndentBottom: integer read FInnerIndentBottom write SetInnerIndentBottom default 4;
  end;

implementation

{ ********************** TLMDChartTitleBox *********************************** }
{ ------------------------- private ------------------------------------------ }

procedure TLMDChartTitleBox.SetFont(Value: TLMDChartFont);
begin
  FFont.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetBackground(Value: TLMDChartBackground);
begin
  FBackground.Assign(Value);
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetIcon(Value: TPicture);
begin
  FIcon.Assign(Value);
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetEdge(Value: TLMDChartLine);
begin
  FEdge.Assign(Value);
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetIconMargin(Value: integer);
begin
  FIconMargin := Value;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetIconAlignment(Value: TLMDChartAlignment);
begin
  FIconAlignment := Value;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetInnerIndentBottom(Value: integer);
begin
  FInnerIndentBottom := Value;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetInnerIndentLeft(Value: integer);
begin
  FInnerIndentLeft := Value;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetInnerIndentRight(Value: integer);
begin
  FInnerIndentRight := Value;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetInnerIndentTop(Value: integer);
begin
  FInnerIndentTop := Value;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetAlignment(Value: TLMDChartAlignment);
begin
  FAlignment := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetMarginChart(Value: integer);
begin
  FMarginChart := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SetMarginEdge(Value: integer);
begin
  FMarginEdge := Value;
  FChanged := true;
  HighestOwnerRepaint;
end;

{ ------------------------------ protected ----------------------------------- }

procedure TLMDChartTitleBox.DrawIconTrnsp(ATarget: TCanvas; AX, AY: integer;
  ATranspColor: TColor);
var
  LBuffer: TBitmap;
  i, j: integer;
begin
  LBuffer := TBitmap.Create;
  LBuffer.Height := FIcon.Height;
  LBuffer.Width := FIcon.Width;
  LBuffer.Canvas.Draw(0, 0, FIcon.Bitmap);
  for j := 0 to FIcon.Height - 1 do
  begin
    if ((j + AY) > ATarget.ClipRect.Bottom) or ((j + AY) < ATarget.ClipRect.Top) then
      continue;
    for i := 0 to FIcon.Width do
    begin
      if ((j + AX) > ATarget.ClipRect.Right) or ((j + AX) < ATarget.ClipRect.Left) then
        continue;
      if LBuffer.Canvas.Pixels[i, j] = ATranspColor then
        LBuffer.Canvas.Pixels[i, j] := ATarget.Pixels[i + AX, j + AY]
    end;
  end;
  ATarget.Draw(AX, AY, LBuffer);
  LBuffer.Free;
end;

{ ------------------------- public ------------------------------------------- }

procedure TLMDChartTitleBox.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartTitleBox then
  begin
    try
      Text := TLMDChartTitleBox(ASource).Text;
      Font.Assign(TLMDChartTitleBox(ASource).Font);
      Alignment := TLMDChartTitleBox(ASource).Alignment;
      Background.Assign(TLMDChartTitleBox(ASource));
      Edge := TLMDChartTitleBox(ASource).Edge;
      Icon.Assign(TLMDChartTitleBox(ASource).Icon);
      MarginEdge := TLMDChartTitleBox(ASource).MarginEdge;
      MarginChart := TLMDChartTitleBox(ASource).MarginChart;
      IconAlignment := TLMDChartTitleBox(ASource).IconAlignment;
    finally
    end;
  end;
  inherited Assign(ASource);
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.EnsureChild(NNChartTitleBox + Comment);
  FFont.SaveStateToXML(WorkNode, '');
  FBackground.SaveStateToXML(WorkNode, '');
  FEdge.SaveStateToXML(WorkNode, '');

  IterNode := WorkNode.AppendElement('Text');
  IterNode.SetVarAttr('value', FText);
  IterNode := WorkNode.AppendElement('Alignment');
  IterNode.SetVarAttr('value', Variant(FAlignment));
  IterNode := WorkNode.AppendElement('MarginEdge');
  IterNode.SetVarAttr('value', FMarginEdge);
  IterNode := WorkNode.AppendElement('MarginChart');
  IterNode.SetVarAttr('value', FMarginChart);
  IterNode := WorkNode.AppendElement('IconAlignment');
  IterNode.SetVarAttr('value', Variant(FIconAlignment));
  IterNode := WorkNode.AppendElement('InnerIndentLeft');
  IterNode.SetVarAttr('value', FInnerIndentLeft);
  IterNode := WorkNode.AppendElement('InnerIndentRight');
  IterNode.SetVarAttr('value', FInnerIndentRight);
  IterNode := WorkNode.AppendElement('InnerIndentTop');
  IterNode.SetVarAttr('value', FInnerIndentTop);
  IterNode := WorkNode.AppendElement('InnerIndentBottom');
  IterNode.SetVarAttr('value', FInnerIndentBottom);
  IterNode := WorkNode.AppendElement('IconMargin');
  IterNode.SetVarAttr('value', FIconMargin);
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartTitleBox.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNChartTitleBox + Comment);
  FEdge.LoadStateFromXML(WorkNode, '');
  FFont.LoadStateFromXML(WorkNode, '');
  FBackground.LoadStateFromXML(WorkNode, '');

  IterNode := WorkNode.NeedChild('Text');
  FText := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('Alignment');
  FAlignment := TLMDChartAlignment(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('MarginEdge');
  FMarginEdge := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('MarginChart');
  FMarginChart := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('IconAlignment');
  FIconAlignment := TLMDChartAlignment(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('InnerIndentLeft');
  FInnerIndentLeft := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('InnerIndentRight');
  FInnerIndentRight := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('InnerIndentTop');
  FInnerIndentTop := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('InnerIndentBottom');
  FInnerIndentBottom := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('IconMargin');
  FIconMargin := IterNode.GetVarAttr('value', 0);
end;
{ ---------------------------------------------------------------------------- }

constructor TLMDChartTitleBox.Create(AMainOwner: TPersistent);
begin
  inherited Create(AMainOwner);
  FFont := TLMDChartFont.Create(AMainOwner);
  FEdge := TLMDChartLine.Create(AMainOwner);
  FBackground := TLMDChartBackground.Create(AMainOwner);
  FIcon := TPicture.Create;
  Alignment := caBottom;
  MarginEdge := 5;
  MarginChart := 5;
  IconMargin := 5;
  IconAlignment := caLeft;
  InnerIndentLeft := 4;
  InnerIndentRight := 4;
  InnerIndentTop := 4;
  InnerIndentBottom := 4;
  Text := 'LMDChartPackage';
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartTitleBox.Destroy;
begin
  inherited Destroy;
  FFont.Free;
  FBackground.Free;
  FIcon.Free;
  FEdge.Free;
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartTitleBox.Draw(ATarget: TCanvas; AArea: TRect): TRect;
var
  LBoxHeight, LBoxWidth: integer;
  LTextPoint, LIconPoint, LBoxPoint: TPoint;
  LTextHeight, LTextWidth: integer;
begin

  //calculate
  ATarget.Font.Assign(FFont);
  LTextHeight := ATarget.TextHeight(FText);
  LTextWidth := ATarget.TextWidth(FText);

  LBoxHeight := InnerIndentTop + InnerIndentBottom + Edge.Width * 2;
  LBoxWidth := InnerIndentLeft + InnerIndentRight + Edge.Width * 2;

  case FIconAlignment of
    caTop:
      begin
        LBoxHeight := LBoxHeight + IconMargin + LTextHeight + FIcon.Height;
        LBoxWidth := LBoxWidth + Max(LTextWidth, FIcon.Width);
        LIconPoint.X := LBoxWidth div 2 - FIcon.Width div 2;
        LIconPoint.Y := InnerIndentTop;
        LTextPoint.Y := InnerIndentTop + IconMargin + FIcon.Height;
        LTextPoint.X := LBoxWidth div 2 - LTextWidth div 2;
      end;
    caBottom:
      begin
        LBoxHeight := LBoxHeight + IconMargin + LTextHeight + FIcon.Height;
        LBoxWidth := LBoxWidth + Max(LTextWidth, FIcon.Width);
        LIconPoint.X := LBoxWidth div 2 - FIcon.Width div 2;
        LIconPoint.Y := InnerIndentTop + IconMargin + LTextHeight;
        LTextPoint.Y := InnerIndentTop;
        LTextPoint.X := LBoxWidth div 2 - LTextWidth div 2;
      end;
    caLeft:
      begin
        LBoxHeight := LBoxHeight + Max(LTextHeight, FIcon.Height);
        LBoxWidth := LBoxWidth + IconMargin + LTextWidth + FIcon.Width;
        LIconPoint.X := InnerIndentLeft;
        LIconPoint.Y := LBoxHeight div 2 - FIcon.Height div 2;
        LTextPoint.Y := LBoxHeight div 2 - LTextHeight div 2;
        LTextPoint.X := InnerIndentLeft + FIcon.Width + IconMargin;
      end;
    caRigth:
      begin
        LBoxHeight := LBoxHeight + Max(LTextHeight, FIcon.Height);
        LBoxWidth := LBoxWidth + IconMargin + LTextWidth + FIcon.Width;
        LIconPoint.X := InnerIndentLeft + LTextWidth + IconMargin;
        LIconPoint.Y := LBoxHeight div 2 - FIcon.Height div 2;
        LTextPoint.Y := LBoxHeight div 2 - LTextHeight div 2;
        LTextPoint.X := InnerIndentLeft;
      end;
  end;

  case FAlignment of
    caRigth:
      begin
        LBoxPoint.X := AArea.Right - FMarginEdge - LBoxWidth;
        LBoxPoint.Y := AArea.Top + (AArea.Bottom - AArea.Top) div 2 - LBoxHeight div 2;
        AArea.Right := AArea.Right - (LBoxWidth + FMarginEdge + FMarginChart);
      end;
    caLeft:
      begin
        LBoxPoint.X := AArea.Left + FMarginEdge;
        LBoxPoint.Y := AArea.Top + (AArea.Bottom - AArea.Top) div 2 - LBoxHeight div 2;
        AArea.Left := AArea.Left + (LBoxWidth + FMarginEdge + FMarginChart);
      end;
    caBottom:
      begin
        LBoxPoint.X := AArea.Left + (AArea.Right - AArea.Left) div 2 - LBoxWidth div 2;
        LBoxPoint.Y := AArea.Bottom - FMarginEdge - LBoxHeight;
        AArea.Bottom := AArea.Bottom - (LBoxHeight + FMarginEdge + FMarginChart);
      end;
    caTop:
      begin
        LBoxPoint.X := AArea.Left + (AArea.Right - AArea.Left) div 2 - LBoxWidth div 2;
        LBoxPoint.Y := AArea.Top + FMarginEdge;
        AArea.Top := AArea.Top + (LBoxHeight + FMarginEdge + FMarginChart);
      end;
  end;
  result := AArea;
  //draw  back
  FBackground.DrawRectangle(ATarget, FEdge, LBoxPoint.X, LBoxPoint.Y, LBoxPoint.X + LBoxWidth, LBoxPoint.Y + LBoxHeight);
  //draw eiele box text
  ATarget.TextOut(LBoxPoint.X + LTextPoint.X, LBoxPoint.Y + LTextPoint.Y, FText);
  //draw icon
  DrawIconTrnsp(ATarget, LBoxPoint.X + LIconPoint.X, LBoxPoint.Y + LIconPoint.Y, Ficon.Bitmap.Canvas.Pixels[0, 0]);
end;

end.
