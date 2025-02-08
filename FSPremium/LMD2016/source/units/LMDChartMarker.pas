unit LMDChartMarker;
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
LMDChartMarker
-----------------------------------

Changes
-------
Last (11-September-2006)

###############################################################################}

interface

uses
  Windows, Graphics, Classes, Variants, Types,
  LMDXML, LMDXMLNodeNames, LMDChartPersistent;

type
  TLMDChartMarkerTypes = (
    cmtNone,
    cmtCustomImage,
    cmtSquare,
    cmtTriangle,
    cmtCircle,
    cmtDiamond,
    cmtFourPointStar,
    cmtFivePointStar,
    cmtSixPointStar,
    cmtSevenPointStar
    );

  { *********************** TLMDChartMarker ********************************** }
  /// <summary>
  /// Represents chart marker
  /// </summary>
  TLMDChartMarker = class(TLMDChartSeriesCollectionAttribute)
  private
    FColor: TColor;
    FCustomImage: TPicture;
    FSize: integer;
    FStyle: TLMDChartMarkerTypes;
    procedure SetColor(Value: TColor);
    procedure SetCustomImage(Value: TPicture);
    procedure SetSize(Value: integer);
    procedure SetStyle(Value: TLMDChartMarkerTypes);
  public
    procedure Assign(ASource: TPersistent); override;
    constructor Create(AMainOwner: TPersistent); override;
    destructor Destroy; override;
    /// <summary>
    /// Draws object on canvas
    /// </summary>
    procedure Draw(ATarget: TCanvas; AX, AY: integer);
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
  published
    property Color: TColor read FColor write SetColor default clBlack;
    property CustomImage: TPicture read FCustomImage write SetCustomImage;
    property Size: integer read FSize write SetSize default 5;
    property Style: TLMDChartMarkerTypes read FStyle write SetStyle default cmtSquare;
  end;

implementation

{ ************************* TLMDChartMarker ********************************** }
{ ------------------------- private ------------------------------------------ }

procedure TLMDChartMarker.SetColor(Value: TColor);
begin
  if Value <> FColor then
  begin
    FColor := Value;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartMarker.SetCustomImage(Value: TPicture);
begin
  if Value <> FCustomImage then
  begin
    FCustomImage.Assign(Value);
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartMarker.SetSize(Value: integer);
begin
  if Value <> FSize then
  begin
    FSize := Value;
    HighestOwnerRepaint
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartMarker.SetStyle(Value: TLMDChartMarkerTypes);
begin
  if Value <> FStyle then
  begin
    FStyle := Value;
    HighestOwnerRepaint
  end;
end;

{ ------------------------- public ------------------------------------------- }

procedure TLMDChartMarker.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartMarker then
  begin
    try
      FColor := TLMDChartMarker(ASource).FColor;
      FCustomImage.Assign(TLMDChartMarker(ASource).CustomImage);
      FSize := TLMDChartMarker(ASource).FSize;
      FStyle := TLMDChartMarker(ASource).FStyle;
    finally
    end;
  end;
  inherited Assign(ASource);
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartMarker.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin

  WorkNode := BaseNode.EnsureChild(NNChartMarker + Comment);
  IterNode := WorkNode.AppendElement('Color');
  IterNode.SetVarAttr('value', FColor);
  IterNode := WorkNode.AppendElement('Size');
  IterNode.SetVarAttr('value', FSize);
  IterNode := WorkNode.AppendElement('Style');
  IterNode.SetVarAttr('value', Variant(Style));
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartMarker.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode: ILMDXmlNode;
begin
  WorkNode := BaseNode.NeedChild(NNChartMarker + Comment);

  IterNode := WorkNode.NeedChild('Color');
  FColor := TColor(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('Size');
  FSize := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('Style');
  FStyle := TLMDChartMarkerTypes(IterNode.GetVarAttr('value', 0));
end;
{ ---------------------------------------------------------------------------- }

constructor TLMDChartMarker.Create(AMainOwner: TPersistent);
begin
  inherited Create(AMainOwner);
  FCustomImage := TPicture.Create;
  //default
  FColor := clBlack;
  FSize := 6;
  FStyle := cmtSquare;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartMarker.Destroy;
begin
  FCustomImage.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartMarker.Draw(ATarget: TCanvas; AX, AY: integer);
var
  LPoly: array of TPoint;
begin
  case FStyle of
    cmtNone: exit;

    cmtCustomImage:
      begin
        ATarget.Draw(AX - FCustomImage.Width div 2, AY - FCustomImage.Height div 2,
          FCustomImage.Bitmap);
      end;

    cmtSquare:
      begin
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := FColor;
        Atarget.Pen.Style := psClear;
        ATarget.Rectangle(Ax - FSize, Ay - FSize, Ax + FSize + 1, Ay + FSize + 1);
      end;

    cmtTriangle:
      begin
        Setlength(LPoly, 3);
        LPoly[0].X := AX;
        LPoly[0].Y := AY - FSize;
        LPoly[1].X := AX + FSize;
        LPoly[1].Y := AY + FSize;
        LPoly[2].X := AX - FSize;
        LPoly[2].Y := AY + FSize;
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := FColor;
        Atarget.Pen.Style := psClear;
        ATarget.Polygon(LPoly);
      end;

    cmtCircle:
      begin
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := FColor;
        Atarget.Pen.Style := psClear;
        ATarget.Ellipse(Ax - FSize, Ay - FSize, Ax + FSize + 1, Ay + FSize + 1);
      end;

    cmtDiamond:
      begin
        Setlength(LPoly, 4);
        LPoly[0].X := AX;
        LPoly[0].Y := AY - FSize;
        LPoly[1].X := AX + FSize;
        LPoly[1].Y := AY;
        LPoly[2].X := AX;
        LPoly[2].Y := AY + FSize;
        LPoly[3].X := AX - FSize;
        LPoly[3].Y := AY;
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := FColor;
        Atarget.Pen.Style := psClear;
        ATarget.Polygon(LPoly);
      end;

    cmtFourPointStar:
      begin
        Setlength(LPoly, 8);
        LPoly[0].X := AX;
        LPoly[0].Y := AY - FSize;
        LPoly[1].X := round(AX + FSize / 3);
        LPoly[1].Y := round(AY - FSize / 3);
        LPoly[2].X := AX + FSize;
        LPoly[2].Y := AY;
        LPoly[3].X := round(AX + FSize / 3);
        LPoly[3].Y := round(AY + FSize / 3);
        LPoly[4].X := AX;
        LPoly[4].Y := AY + FSize;
        LPoly[5].X := round(AX - FSize / 3);
        LPoly[5].Y := round(AY + FSize / 3);
        LPoly[6].X := AX - FSize;
        LPoly[6].Y := AY;
        LPoly[7].X := round(AX - FSize / 3);
        LPoly[7].Y := round(AY - FSize / 3);
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := FColor;
        Atarget.Pen.Style := psClear;
        ATarget.Polygon(LPoly);
      end;

    cmtFivePointStar:
      begin
        Setlength(LPoly, 10);
        LPoly[0].X := AX;
        LPoly[0].Y := AY - FSize;
        LPoly[1].X := round(AX + FSize / 3);
        LPoly[1].Y := round(AY - FSize / 2);
        LPoly[2].X := AX + FSize;
        LPoly[2].Y := round(AY - FSize / 2);
        LPoly[3].X := round(AX + FSize / 2);
        LPoly[3].Y := AY;
        LPoly[4].X := round(AX + FSize * 2 / 3);
        LPoly[4].Y := round(AY + FSize * 2 / 3);
        LPoly[5].X := AX;
        LPoly[5].Y := round(AY + FSize / 3);
        LPoly[6].X := round(AX - FSize * 2 / 3);
        LPoly[6].Y := round(AY + FSize * 2 / 3);
        LPoly[7].X := round(AX - FSize / 2);
        LPoly[7].Y := AY;
        LPoly[8].X := AX - FSize;
        LPoly[8].Y := round(AY - FSize / 2);
        LPoly[9].X := round(AX - FSize / 3);
        LPoly[9].Y := round(AY - FSize / 2);
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := FColor;
        Atarget.Pen.Style := psClear;
        ATarget.Polygon(LPoly);
      end;

    cmtSixPointStar:
      begin
        Setlength(LPoly, 3);
        LPoly[0].X := AX;
        LPoly[0].Y := AY - FSize;
        LPoly[1].X := round(AX + FSize * 2 / 3);
        LPoly[1].Y := round(AY + FSize / 2);
        LPoly[2].X := round(AX - FSize * 2 / 3);
        LPoly[2].Y := round(AY + FSize / 2);
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := FColor;
        Atarget.Pen.Style := psClear;
        ATarget.Polygon(LPoly);

        Setlength(LPoly, 3);
        LPoly[0].X := AX;
        LPoly[0].Y := AY + FSize;
        LPoly[1].X := round(AX + FSize * 2 / 3);
        LPoly[1].Y := round(AY - FSize / 2);
        LPoly[2].X := round(AX - FSize * 2 / 3);
        LPoly[2].Y := round(AY - FSize / 2);
        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := FColor;
        Atarget.Pen.Style := psClear;
        ATarget.Polygon(LPoly);
      end;

    cmtSevenPointStar:
      begin
        Setlength(LPoly, 14);
        LPoly[0].X := AX;
        LPoly[0].Y := AY - FSize;
        LPoly[1].X := round(AX + FSize / 4);
        LPoly[1].Y := round(AY - FSize / 4);
        LPoly[2].X := round(AX + FSize * 3 / 4);
        LPoly[2].Y := round(AY - FSize / 2);
        LPoly[3].X := round(AX + FSize / 2);
        LPoly[3].Y := AY;
        LPoly[4].X := round(AX + FSize * 3 / 4);
        LPoly[4].Y := round(AY + FSize / 2);
        LPoly[5].X := round(AX + FSize / 4);
        LPoly[5].Y := round(AY + FSize / 4);
        LPoly[6].X := round(AX + FSize / 2);
        LPoly[6].Y := round(AY + FSize * 3 / 4);
        LPoly[7].X := AX;
        LPoly[7].Y := round(AY + FSize / 2);

        LPoly[8].X := round(AX - FSize / 2);
        LPoly[8].Y := round(AY + FSize * 3 / 4);
        LPoly[9].X := round(AX - FSize / 4);
        LPoly[9].Y := round(AY + FSize / 4);
        LPoly[10].X := round(AX - FSize * 3 / 4);
        LPoly[10].Y := round(AY + FSize / 2);
        LPoly[11].X := round(AX - FSize / 2);
        LPoly[11].Y := AY;
        LPoly[12].X := round(AX - FSize * 3 / 4);
        LPoly[12].Y := round(AY - FSize / 2);
        LPoly[13].X := round(AX - FSize / 4);
        LPoly[13].Y := round(AY - FSize / 4);

        ATarget.Brush.Style := bsSolid;
        ATarget.Brush.Color := FColor;
        Atarget.Pen.Style := psClear;
        ATarget.Polygon(LPoly);
      end;

  end;
  LPoly := nil;
end;

end.
