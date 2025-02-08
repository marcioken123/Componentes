unit LMDChartBackground;
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
LMDChartBackground unit
-----------------------------------

ToDo
----

Changes
-------
Last (07-June-2006)

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Controls, Graphics, Variants, Types, ExtCtrls,
  LMDXML, LMDXMLNodeNames, LMDChartPersistent,  LMDChartUtils, LMDChartLine;

type

  TLMDChartBackgroundStyle = (cbsNone, cbsGradient, cbsImageStretched, cbsImageTiled, cbsSolid);

  { ************************ TLMDChartBackground ***************************** }
  /// <summary>
  /// Represents chart background
  /// </summary>
  TLMDChartBackground = class(TLMDChartSeriesCollectionAttribute)
  private
    FStyle: TLMDChartBackgroundStyle;
    FImage: TPicture;
    FSolidColor: TColor;
    FGradientColorBegin: TColor;
    FGradientColorEnd: TColor;
    FGradientAngle: integer;
    FGradientMaxLOD: integer;
    FGradientArray: array of TColor;
    procedure SetImage(Value: TPicture);
    procedure SetStyle(Value: TLMDChartBackgroundStyle);
    procedure SetSolidColor(Value: TColor);
    procedure SetGradientColorBegin(Value: TColor);
    procedure SetGradientColorEnd(Value: TColor);
    procedure SetGradientAngle(Value: integer);
    procedure SetGradientMaxLOD(Value: integer);
    function GetBoundedRect(AReg: array of TPoint): TRect;
  public
    procedure Assign(ASource: TPersistent); override;
    constructor Create(AOwner: TPersistent); override;
    destructor Destroy; override;
    /// <summary>
    /// Draws background on canvas
    /// </summary>
    procedure DrawBackgroundReg(ATarget: TCanvas; AAreaReg: array of TPoint);
    procedure DrawBackground(ATarget: TCanvas; AArea: TRect);
    /// <summary>
    /// Draws rectangle on canvas
    /// </summary>
    procedure DrawRectangle(ATarget: TCanvas; ALine: TLMDChartLine; AArea: TRect); overload;
    /// <summary>
    /// Draws recntangle on canvas
    /// </summary>
    procedure DrawRectangle(ATarget: TCanvas; ALine: TLMDChartLine; Ax0, Ay0, Ax1, Ay1: integer); overload;
    /// <summary>
    /// Saves inner object state to xml format
    /// </summary>
    procedure SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
    /// <summary>
    /// Loads inner object state from xml format
    /// </summary>
    procedure LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
  published
    property Style: TLMDChartBackgroundStyle read FStyle write SetStyle default cbsNone;
    property Image: TPicture read FImage write SetImage;
    property SolidColor: TColor read FSolidColor write SetSolidColor default clWhite;
    property GradientColorBegin: TColor read FGradientColorBegin write SetGradientColorBegin default clWhite;
    property GradientColorEnd: TColor read FGradientColorEnd write SetGradientColorEnd default clGray;
    property GradientAngle: integer read FGradientAngle write SetGradientAngle default 0;
    property GradientMaxLOD: integer read FGradientMaxLOD write SetGradientMaxLOD default 50;
  end;

implementation

{ ************************* TLMDChartBackground ****************************** }
{ ---------------------------- private --------------------------------------- }

procedure TLMDChartBackground.SetImage(Value: TPicture);
begin
  if Value <> FImage then
  begin
    FImage.Assign(Value);
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartBackground.SetStyle(Value: TLMDChartBackgroundStyle);
begin
  if Value <> FStyle then
  begin
    FStyle := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartBackground.SetSolidColor(Value: TColor);
begin
  if Value <> FSolidColor then
  begin
    FSolidColor := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartBackground.SetGradientColorBegin(Value: TColor);
begin
  if Value <> FGradientColorBegin then
  begin
    FGradientColorBegin := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartBackground.SetGradientColorEnd(Value: TColor);
begin
  if Value <> FGradientColorEnd then
  begin
    FGradientColorEnd := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartBackground.SetGradientAngle(Value: integer);
begin
  if Value <> FGradientAngle then
  begin
    FGradientAngle := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartBackground.SetGradientMaxLOD(Value: integer);
begin
  if Value <> FGradientMaxLOD then
  begin
    if Value < 1 then
      value := 1;
    if value > 1000 then
      Value := 1000;
    FGradientMaxLOD := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ----------------------------- public --------------------------------------- }

procedure TLMDChartBackground.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartBackground then
  begin
    try
      FStyle := TLMDChartBackground(ASource).Style;
      FImage.Assign(TLMDChartBackground(ASource).Image);
      FSolidColor := TLMDChartBackground(ASource).GradientColorBegin;
      FGradientColorBegin := TLMDChartBackground(ASource).GradientColorBegin;
      FGradientColorEnd := TLMDChartBackground(ASource).GradientColorEnd;
      FGradientAngle := TLMDChartBackground(ASource).GradientAngle;
      FGradientMaxLOD := TLMDChartBackground(ASource).GradientMaxLOD;
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartBackground.LoadStateFromXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode, ArrayNode: ILMDXmlNode;
  i: integer;
begin
  WorkNode := BaseNode.NeedChild(NNChartBackground + Comment);

  IterNode := WorkNode.NeedChild('Style');
  FStyle := TLMDChartBackgroundStyle(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('SolidColor');
  FSolidColor := TColor(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('GradientColorBegin');
  FGradientColorBegin := TColor(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('GradientColorEnd');
  FGradientColorEnd := TColor(IterNode.GetVarAttr('value', 0));

  IterNode := WorkNode.NeedChild('GradientAngle');
  FGradientAngle := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('GradientMaxLOD');
  FGradientMaxLOD := IterNode.GetVarAttr('value', 0);

  IterNode := WorkNode.NeedChild('GradientArray');
  SetLength(FGradientArray, IterNode.ChildNodes.Count);
  for i := 0 to IterNode.ChildNodes.Count - 1 do
  begin
    ArrayNode := IterNode.NeedChild('i' + inttostr(i));
    FGradientArray[i] := TColor(ArrayNode.GetVarAttr('value', FGradientArray[i]));
  end;
end;
{ ---------------------------------------------------------------------------- }

procedure TLMDChartBackground.SaveStateToXML(BaseNode: ILMDXmlNode; Comment: string);
var
  WorkNode, IterNode, ArrayNode: ILMDXmlNode;
  i: integer;
begin
  WorkNode := BaseNode.EnsureChild(NNChartBackground + Comment);
  IterNode := WorkNode.AppendElement('Style');
  IterNode.SetVarAttr('value', Variant(FStyle));
  IterNode := WorkNode.AppendElement('SolidColor');
  IterNode.SetVarAttr('value', Variant(FSolidColor));
  IterNode := WorkNode.AppendElement('GradientColorBegin');
  IterNode.SetVarAttr('value', FGradientColorBegin);
  IterNode := WorkNode.AppendElement('GradientColorEnd');
  IterNode.SetVarAttr('value', FGradientColorEnd);
  IterNode := WorkNode.AppendElement('GradientAngle');
  IterNode.SetVarAttr('value', FGradientAngle);
  IterNode := WorkNode.AppendElement('GradientMaxLOD');
  IterNode.SetVarAttr('value', FGradientMaxLOD);
  IterNode := WorkNode.AppendElement('GradientArray');
  for i := 0 to length(FGradientArray) - 1 do
  begin
    ArrayNode := IterNode.AppendElement('i' + inttostr(i));
    ArrayNode.SetVarAttr('value', FGradientArray[i]);
  end;
end;
{ ---------------------------------------------------------------------------- }

constructor TLMDChartBackground.Create(AOwner: TPersistent);
begin
  inherited Create(AOwner);
  FImage := TPicture.Create;
  FStyle := cbsNone;
  FSolidColor := clWhite;
  SetLength(FGradientArray, 1);
  FGradientmaxLOD := 50;
  FGradientColorBegin := clWhite;
  FGradientColorEnd := clGray;
  FGradientAngle := 0;
  FChanged := true;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDChartBackground.Destroy;
begin
  FImage.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartBackground.DrawBackground(ATarget: TCanvas; AArea: TRect);
type
  mytype = array[1..4] of TPoint;
var
  LvTileCount, LhTileCount, i, j: integer;
  LGradLOD: integer;
  LGradSize: integer;
  LBuffer: TBitmap;
begin
  LBuffer := TBitmap.Create;

  LBuffer.Height := Abs(AArea.Bottom - AArea.Top);
  LBuffer.Width := Abs(AArea.Right - AArea.Left);

  ATarget.Brush.Style := bsSolid;
  ATarget.Pen.Style := psClear;

  case Style of
    cbsNone:
      begin
        ATarget.Brush.Style := bsClear;
        ATarget.FillRect(AArea);
      end;

    cbsSolid:
      begin
        ATarget.Brush.Color := SolidColor;
        ATarget.FillRect(AArea);
      end;

    cbsImageTiled:
      begin
        if (Image.Height > 0) and (Image.Width > 0) then
        begin
          LhTileCount := LBuffer.Width div Image.Width;
          LvTileCount := LBuffer.Height div Image.Height;
          for i := 0 to LhTileCount do
          begin
            for j := 0 to LvTileCount do
            begin
              LBuffer.Canvas.Draw(i * Image.Width, j * Image.Height, Image.Graphic);
            end;
          end;
          ATarget.Draw(AArea.Left, AArea.Top, LBuffer);
        end
        else
        begin
          ATarget.Brush.Color := rgb(255, 255, 255);
          ATarget.FillRect(AArea);
        end;
      end;

    cbsGradient:
      begin
        if LBuffer.Width < GradientMaxLOD then
          LGradLOD := LBuffer.Width
        else
          LGradLOD := GradientMaxLOD;
        if LGradLOD < 2 then
          LGradLOD := 2;
        SetLength(FGradientArray, LGradLOD);
        HGradienCalc(GradientColorBegin, GradientColorEnd, FGradientArray);
        with LBuffer.Canvas do
        begin
          Brush.Style := bsSolid;
          Pen.Style := psClear;
          LGradSize := LBuffer.Width div LGradLOD;
          for i := 0 to LGradLOD - 1 do
          begin
            Brush.Color := FGradientArray[i];
            Rectangle(LGradSize * i, 0, LGradSize * i + LBuffer.Width, LBuffer.Height + 1);
          end;
        end;
        ATarget.Draw(AArea.Left, AArea.Top, LBuffer);
      end;

    cbsImageStretched:
      begin
        ATarget.StretchDraw(AArea, Image.Graphic);
      end;

  else
    ATarget.Brush.Color := rgb(255, 255, 255);
    ATarget.FillRect(AArea);
  end;

  LBuffer.Free;
end;

procedure TLMDChartBackground.DrawBackgroundReg(ATarget: TCanvas; AAreaReg: array of TPoint);
var
  LvTileCount, LhTileCount, i, j: integer;
  LGradLOD: integer;
  LGradSize: integer;
  LBuffer: TBitmap;
  AArea: TRect;
//  reg: array of Tpoint;
begin
  if SelectClipRgn(Atarget.Handle, CreatePolygonRgn(AAreaReg, Length(AAreaReg), 1)) <> ERROR then
  begin
    AArea := GetBoundedRect(AAreaReg);
    LBuffer := TBitmap.Create;

    LBuffer.Height := Abs(AArea.Bottom - AArea.Top);
    LBuffer.Width := Abs(AArea.Right - AArea.Left);

    ATarget.Brush.Style := bsSolid;

    case Style of
      cbsNone:
        begin
          ATarget.Brush.Style := bsClear;
          ATarget.Polygon(AAreaReg);
        end;

      cbsSolid:
        begin
          ATarget.Brush.Color := SolidColor;
          ATarget.Polygon(AAreaReg);
        end;

      cbsImageTiled:
        begin
          if (Image.Height > 0) and (Image.Width > 0) then
          begin
            LhTileCount := LBuffer.Width div Image.Width;
            LvTileCount := LBuffer.Height div Image.Height;
            for i := 0 to LhTileCount do
            begin
              for j := 0 to LvTileCount do
              begin
                LBuffer.Canvas.Draw(i * Image.Width, j * Image.Height, Image.Graphic);
              end;
            end;
            ATarget.Draw(AArea.Left, AArea.Top, LBuffer);
            ATarget.Brush.Style := bsClear;
            ATarget.Polygon(AAreaReg);
          end
          else
          begin
            ATarget.Brush.Color := rgb(255, 255, 255);
            ATarget.Polygon(AAreaReg);
          end;
        end;

      cbsGradient:
        begin
          if LBuffer.Width < GradientMaxLOD then
            LGradLOD := LBuffer.Width
          else
            LGradLOD := GradientMaxLOD;
          if LGradLOD < 2 then
            LGradLOD := 2;
          SetLength(FGradientArray, LGradLOD);
          HGradienCalc(GradientColorBegin, GradientColorEnd, FGradientArray);
          with LBuffer.Canvas do
          begin
            Brush.Style := bsSolid;
            Pen.Style := psClear;
            LGradSize := LBuffer.Width div LGradLOD;
            for i := 0 to LGradLOD - 1 do
            begin
              Brush.Color := FGradientArray[i];
              Rectangle(LGradSize * i, 0, LGradSize * i + LBuffer.Width, LBuffer.Height + 1);
            end;
          end;
          ATarget.Draw(AArea.Left, AArea.Top, LBuffer);
          ATarget.Pen.Style := psSolid;
          ATarget.Brush.Style := bsClear;
          ATarget.Polygon(AAreaReg);
        end;

      cbsImageStretched:
        begin
          ATarget.StretchDraw(AArea, Image.Graphic);
          ATarget.Brush.Style := bsClear;
          ATarget.Polygon(AAreaReg);
        end;

    else
      ATarget.Brush.Color := rgb(255, 255, 255);
      ATarget.Polygon(AAreaReg);
    end;
    LBuffer.Free;
  end;
//  SetLength(reg, 4);
//  reg[0] := point(0, 0);
//  reg[1] := point(1000, 0);
//  reg[2] := point(1000, 1000);
//  reg[3] := point(0, 1000);
//  SelectClipRgn(Atarget.Handle, CreatePolygonRgn(reg, 4, 1));
  SelectClipRgn(Atarget.Handle, 0);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartBackground.DrawRectangle(ATarget: TCanvas; ALine: TLMDChartLine; AArea: TRect);
begin
  DrawBackground(ATarget, AArea);
  ALine.SetupCanvasPen(ATarget.Pen);
  ATarget.Brush.Style := bsClear;
  ATarget.Rectangle(AArea);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartBackground.DrawRectangle(ATarget: TCanvas; ALine: TLMDChartLine; Ax0, Ay0, Ax1, Ay1: integer);
var
  LArea: TRect;
begin
  LArea.Top := Ay0;
  LArea.Left := Ax0;
  LArea.Right := Ax1;
  LArea.Bottom := Ay1;
  DrawBackground(ATarget, LArea);
  ALine.SetupCanvasPen(ATarget.Pen);
  ATarget.Brush.Style := bsClear;
  ATarget.Rectangle(LArea);
end;

function TLMDChartBackground.GetBoundedRect(AReg: array of TPoint): TRect;
var
  LArea: TRect;
  i: integer;
  tmp: TPoint;
begin
  tmp.X := AReg[0].X;
  for i := 1 to Length(AReg) - 1 do
    if (AReg[i].X > tmp.X) then
      tmp.X := AReg[i].X;
  tmp.Y := AReg[0].Y;
  for i := 1 to Length(AReg) - 1 do
    if (AReg[i].Y > tmp.Y) then
      tmp.Y := AReg[i].Y;
  LArea.BottomRight := tmp;

  tmp.X := AReg[0].X;
  for i := 1 to Length(AReg) - 1 do
    if (AReg[i].X < tmp.X) then
      tmp.X := AReg[i].X;
  tmp.Y := AReg[0].Y;
  for i := 1 to Length(AReg) - 1 do
    if (AReg[i].Y < tmp.Y) then
      tmp.Y := AReg[i].Y;
  LArea.TopLeft := tmp;
  LArea.Left := LArea.TopLeft.X;
  LArea.Right := LArea.BottomRight.X;
  LArea.Top := LArea.TopLeft.Y;
  LArea.Bottom := LArea.BottomRight.Y;
  GetBoundedRect := LArea;
end;

end.
