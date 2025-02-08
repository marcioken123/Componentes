unit LMDChartScaleBreak;
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
LMDChartScaleBreak unit
-----------------------------------
TLMDChartScaleBreak

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Controls, Graphics, ExtCtrls, Math, Types, Variants,
  LMDXML, LMDXMLNodeNames, LMDChartPersistent, LMDChartData, LMDChartUtils;

type
  TLMDScaleBreakStyle2D = (sbt2DNone, sbt2DStraight, sbt2DWave, sbt2DRagged);
  TLMDScaleBreakStyle3D = (sbt3DNone, sbt3DEmpty, sbt3DFill);
  TLMDScaleBreakAppearance = (sbaNone, sbaPositive, sbaNegative, sbaBoth);

  TLMDChartScaleBreak = class(TLMDChartPersistent)
  private
    FEnabled: boolean;
    FAutoAppearance: boolean;
    FAppearance: TLMDScaleBreakAppearance;
    FAutoLimits: boolean;
    FPositiveLowLimit: variant;
    FPositiveHighLimit: variant;
    FNegativeLowLimit: variant;
    FNegativeHighLimit: variant;
    FStyle2D: TLMDScaleBreakStyle2D;
    FStyle3D: TLMDScaleBreakStyle3D;
    FColor: TColor;
    FSpacing: integer;
    FData: TLMDChartData;
    procedure SetEnabled(Value: boolean);
    procedure SetColor(Value: TColor);
    procedure SetSpacing(Value: integer);
    procedure SetStyle2D(Value: TLMDScaleBreakStyle2D);
    procedure SetStyle3D(Value: TLMDScaleBreakStyle3D);
    procedure SetAutoAppearance(Value: boolean);
    procedure SetAppearance(Value: TLMDScaleBreakAppearance);
    procedure SetAutoLimits(Value: boolean);
    procedure SetPositiveLowLimit(Value: variant);
    procedure SetPositiveHighLimit(Value: variant);
    procedure SetNegativeLowLimit(Value: variant);
    procedure SetNegativeHighLimit(Value: variant);

  public
    function ProcessAutoAppearance(FData: TLMDChartData): boolean;
    procedure ProcessAutoLimits(FData: TLMDChartData);
    constructor Create(AMainOwner: TPersistent); override;
    procedure Assign(ASource: TPersistent); override;
    procedure SetData(AData: TLMDChartData);
    procedure RenderBreak(ATarget: TCanvas; AStart, AEnd: TPoint; IsVertical: boolean; IsPositive: boolean);
  published
    property Enabled: boolean read FEnabled write SetEnabled default false;
    property Color: TColor read FColor write SetColor default clYellow;
    property Spacing: integer read FSpacing write SetSpacing default 3;
    property Style2D: TLMDScaleBreakStyle2D read FStyle2D write SetStyle2D default sbt2DWave;
    property Style3D: TLMDScaleBreakStyle3D read FStyle3D write SetStyle3D default sbt3DEmpty;
    property AutoAppearance: boolean read FAutoAppearance write SetAutoAppearance default true;
    property Appearance: TLMDScaleBreakAppearance read FAppearance write SetAppearance default sbaNone;
    property AutoLimits: boolean read FAutoLimits write SetAutoLimits default true;
    property PositiveLowLimit: variant read FPositiveLowLimit write SetPositiveLowLimit;
    property PositiveHighLimit: variant read FPositiveHighLimit write SetPositiveHighLimit;
    property NegativeLowLimit: variant read FNegativeLowLimit write SetNegativeLowLimit;
    property NegativeHighLimit: variant read FNegativeHighLimit write SetNegativeHighLimit;
  end;

implementation
{ ************************** TLMDChartScaleBreak ***************************** }
{ -------------------------- private ----------------------------------------- }

procedure TLMDChartScaleBreak.SetEnabled(Value: boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetColor(Value: TColor);
begin
  if Value <> FColor then
  begin
    FColor := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetSpacing(Value: integer);
begin
  if Value <> FSpacing then
  begin
    if Value <= 0 then
      Value := 1;
    FSpacing := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetStyle2D(Value: TLMDScaleBreakStyle2D);
begin
  if Value <> FStyle2D then
  begin
    FStyle2D := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetStyle3D(Value: TLMDScaleBreakStyle3D);
begin
  if Value <> FStyle3D then
  begin
    FStyle3D := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetAutoAppearance(Value: boolean);
begin
  if Value <> FAutoAppearance then
  begin
    FAutoAppearance := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetAppearance(Value: TLMDScaleBreakAppearance);
begin
  if Value <> FAppearance then
  begin
    FAppearance := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetAutoLimits(Value: boolean);
begin
  if Value <> FAutoLimits then
  begin
    FAutoLimits := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetPositiveLowLimit(Value: variant);
begin
  if (Value <> FPositiveLowLimit) and (Value > 0) and (Value < FPositiveHighLimit) then
  begin
    FPositiveLowLimit := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetPositiveHighLimit(Value: variant);
begin
  if (Value <> FPositiveHighLimit) and (Value > 0) and (Value > FPositiveLowLimit) then
  begin
    FPositiveHighLimit := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetNegativeLowLimit(Value: variant);
begin
  if (Value <> FNegativeLowLimit) and (Value < 0) and (Value > FNegativeHighLimit) then
  begin
    FNegativeLowLimit := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetNegativeHighLimit(Value: variant);
begin
  if (Value <> FNegativeHighLimit) and (Value < 0) and (Value < FNegativeLowLimit) then
  begin
    FNegativeHighLimit := Value;
    FChanged := true;
    HighestOwnerRepaint;
  end;
end;

{ -------------------------- public ------------------------------------------ }

procedure TLMDChartScaleBreak.Assign(ASource: TPersistent);
begin
  if ASource is TLMDChartScaleBreak then
  begin
    try
      FColor := TLMDChartScaleBreak(ASource).FColor;
      FStyle2D := TLMDChartScaleBreak(ASource).FStyle2D;
      FStyle3D := TLMDChartScaleBreak(ASource).FStyle3D;
      FEnabled := TLMDChartScaleBreak(ASource).FEnabled;
      FSpacing := TLMDChartScaleBreak(ASource).FSpacing;
    finally
    end;
  end;
  inherited Assign(ASource);
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDChartScaleBreak.Create(AMainOwner: TPersistent);
begin
  inherited Create(AMainOwner);
  //default values
  FChanged := true;
  FEnabled := false;
  FAutoAppearance := true;
  FAppearance := sbaNone;
  FAutoLimits := true;
  FPositiveLowLimit := 100;
  FPositiveHighLimit := 1000;
  FNegativeLowLimit := -100;
  FNegativeHighLimit := -1000;
  FStyle2D := sbt2Dwave;
  FStyle3D := sbt3DEmpty;
  FColor := clYellow;
  FSpacing := 3;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.SetData(AData: TLMDChartData);
begin
  FData := AData;
end;

{ ---------------------------------------------------------------------------- }

function TLMDChartScaleBreak.ProcessAutoAppearance(FData: TLMDChartData): boolean;
const
  koef = 5;
var
  mas: array of double;
  i, j: integer;
  swap: double;
  negkoef, poskoef: double;
  ineg, ipos: integer;
begin
  Result := false;
  ineg := 0;
  ipos := 0;
  // Get data for calculations
  SetLength(mas, FData.ColCount * FData.RowCount);
  if Length(mas) = 0 then
    Exit;

  for i := 0 to FData.ColCount - 1 do
    for j := 0 to FData.RowCount - 1 do
      mas[(i * FData.RowCount) + j] := FData.GetTableValue(i, j);
  // Sorting data for calculations
  for i := 0 to Length(mas) - 2 do
    for j := i + 1 to Length(mas) - 1 do
      if mas[i] > mas[j] then
      begin
        swap := mas[i];
        mas[i] := mas[j];
        mas[j] := swap;
      end;
  // Ñalculate koefficient for negative values
  swap := mas[0];
  i := 0;
  negkoef := 0;
  while swap < 0 do
  begin
    i := i + 1;
    if (mas[i] < 0) and ((max(abs(swap), abs(mas[i])) / min(abs(swap), abs(mas[i]))) > negkoef) then
    begin
      negkoef := max(abs(swap), abs(mas[i])) / min(abs(swap), abs(mas[i]));
      ineg := i;
    end;
    swap := mas[i];
  end;
  // Ñalculate koefficient for positive values
  poskoef := 0;
  while i < length(mas) - 1 do
  begin
    i := i + 1;
    if (mas[i] >= 0) and (min(swap, mas[i]) <> 0) and
      (max(swap, mas[i]) / min(swap, mas[i]) > poskoef) then
    begin
      poskoef := max(swap, mas[i]) / min(swap, mas[i]);
      ipos := i;
    end;
    swap := mas[i];
  end;
  // Set Appearance
  if FAutoAppearance then
  begin
    if (negkoef < koef) and (poskoef < koef) then
      FAppearance := sbaNone;
    if (negkoef > koef) and (poskoef > koef) then
      FAppearance := sbaBoth;
    if (negkoef > koef) and (poskoef < koef) then
      FAppearance := sbaNegative;
    if (negkoef < koef) and (poskoef > koef) then
      FAppearance := sbaPositive;
  end;

  // Set Limits
  if FAutoLimits then
  begin
    if (ineg >= 1) and (ineg - 1 < Length(mas)) then
      FNegativeHighLimit := mas[ineg - 1] - mas[ineg - 1] / 100;
    if (ineg >= 0) and (ineg < Length(mas)) then
      FNegativeLowLimit := mas[ineg] + mas[ineg] / 100;
    if (ipos >= 0) and (ipos < Length(mas)) then
      FPositiveHighLimit := mas[ipos] - mas[ipos] / 100;
    if (ipos >= 1) and (ipos - 1 < Length(mas)) then
      FPositiveLowLimit := mas[ipos - 1] + mas[ipos - 1] / 100;
  end;

  Result := (FAppearance <> sbaNone);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.ProcessAutoLimits(FData: TLMDChartData);
const
  koef = 5;
var
  mas: array of double;
  i, j: integer;
  swap: double;
  negkoef, poskoef: double;
begin
  if FAutoAppearance then
  begin
    // Get data for calculations
    SetLength(mas, FData.ColCount * FData.RowCount);
    for i := 0 to FData.ColCount - 1 do
      for j := 0 to FData.RowCount - 1 do
        mas[(i * FData.RowCount) + j] := FData.GetTableValue(i, j);
    // Sorting data for calculations
    for i := 0 to Length(mas) - 2 do
      for j := i + 1 to Length(mas) - 1 do
        if mas[i] > mas[j] then
        begin
          swap := mas[i];
          mas[i] := mas[j];
          mas[j] := swap;
        end;
    // Ñalculate koefficient for negative values
    swap := mas[0];
    i := 0;
    negkoef := 0;
    while swap < 0 do
    begin
      i := i + 1;
      if (mas[i] < 0) and ((max(abs(swap), abs(mas[i])) / min(abs(swap), abs(mas[i]))) > negkoef) then
        negkoef := max(abs(swap), abs(mas[i])) / min(abs(swap), abs(mas[i]));
      swap := mas[i];
    end;
    // Ñalculate koefficient for positive values
    poskoef := 0;
    while i < length(mas) - 1 do
    begin
      i := i + 1;
      if (mas[i] >= 0) and (max(swap, mas[i]) / min(swap, mas[i]) > poskoef) then
        poskoef := max(swap, mas[i]) / min(swap, mas[i]);
      swap := mas[i];
    end;
    // Set Appearance
    if (negkoef < koef) and (poskoef < koef) then
      FAppearance := sbaNone;
    if (negkoef > koef) and (poskoef > koef) then
      FAppearance := sbaBoth;
    if (negkoef > koef) and (poskoef < koef) then
      FAppearance := sbaNegative;
    if (negkoef < koef) and (poskoef > koef) then
      FAppearance := sbaPositive;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDChartScaleBreak.RenderBreak(ATarget: TCanvas; AStart, AEnd: TPoint; IsVertical: boolean; IsPositive: boolean);
var
  {low break} x1_1, y1_1, x2_1, y2_1: integer;
  i: integer;
begin
  // calculate points of break line
  x1_1 := AStart.X;
  y1_1 := AStart.Y;
  x2_1 := AEnd.X;
  y2_1 := AEnd.Y;

  ATarget.Pen.Style := psSolid;
  ATarget.Pen.Color := FColor;
  ATarget.Pen.Width := FSpacing;
  case FStyle2D of

    sbt2DNone:
      begin
        ATarget.Pen.Style := psClear;

        DrawLine(x1_1, y1_1, x2_1, y2_1, ATarget);
      end;

    sbt2DStraight:
      begin

        DrawLine(x1_1, y1_1, x2_1, y2_1, ATarget);

      end;

    sbt2DWave:
      begin
        if IsVertical then
          for i := y1_1 to y2_1 do
          begin

            DrawLine(x1_1 + round(5 * sin(i mod 360 / 180 * pi * 5)), i, x1_1 + round(5 * sin((i + 1) mod 360 / 180 * pi * 5)), i, ATarget);

          end;
        if not IsVertical then
          for i := x1_1 to x2_1 do
          begin

            DrawLine(i, y1_1 + round(5 * sin(i mod 360 / 180 * pi * 5)), i, y1_1 + round(5 * sin((i + 1) mod 360 / 180 * pi * 5)), ATarget);

          end;
      end;

    sbt2DRagged:
      begin
        Randomize;
        if IsVertical then
        begin
          i := y1_1 - 7;
          while i < y2_1 do
          begin
            DrawLine(x1_1 + random(7) - 3, i - 7, x1_1 + random(7) - 3, i, ATarget);

            i := i + 7;
          end;
        end;
        if not IsVertical then
        begin
          i := x1_1 + 7;
          while i < x2_1 do
          begin
            DrawLine(i - 7, y1_1 + random(7) - 3, i, y1_1 + random(7) - 3, ATarget);

            i := i + 7;
          end;
        end;
      end;
  end;
end;

end.
