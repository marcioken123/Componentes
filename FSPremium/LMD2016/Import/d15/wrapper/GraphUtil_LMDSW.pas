unit GraphUtil_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'GraphUtil' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Types, SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Windows, Graphics, Classes, GraphUtil, Windows_LMDSW,
  Graphics_LMDSW, Classes_LMDSW;


{ Type wrappers }

type

  TScrollDirection_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TScrollDirection): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollDirection;
  end;

  TArrowType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TArrowType): OleVariant;
    class function FromVar(const AValue: OleVariant): TArrowType;
  end;

  TGradientDirection_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TGradientDirection): OleVariant;
    class function FromVar(const AValue: OleVariant): TGradientDirection;
  end;

  TColorArraySortType_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TColorArraySortType): OleVariant;
    class function FromVar(const AValue: OleVariant): TColorArraySortType;
  end;


{ Unit wrapper }

type
  GraphUtil_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TScrollDirection_sw }

class function TScrollDirection_sw.GetTypeName: WideString;
begin
  Result := 'TScrollDirection';
end;

class procedure TScrollDirection_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'sdLeft'; Value: Integer({$IFDEF LMDSCT_12}TScrollDirection.{$ENDIF}sdLeft)),
    (Name: 'sdRight'; Value: Integer({$IFDEF LMDSCT_12}TScrollDirection.{$ENDIF}sdRight)),
    (Name: 'sdUp'; Value: Integer({$IFDEF LMDSCT_12}TScrollDirection.{$ENDIF}sdUp)),
    (Name: 'sdDown'; Value: Integer({$IFDEF LMDSCT_12}TScrollDirection.{$ENDIF}sdDown))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TScrollDirection_sw.ToVar(
  const AValue: TScrollDirection): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TScrollDirection_sw.FromVar(
  const AValue: OleVariant): TScrollDirection;
begin
  Result := TScrollDirection(Integer(AValue));
end;

{ TArrowType_sw }

class function TArrowType_sw.GetTypeName: WideString;
begin
  Result := 'TArrowType';
end;

class procedure TArrowType_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'atSolid'; Value: Integer({$IFDEF LMDSCT_12}TArrowType.{$ENDIF}atSolid)),
    (Name: 'atArrows'; Value: Integer({$IFDEF LMDSCT_12}TArrowType.{$ENDIF}atArrows))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TArrowType_sw.ToVar(const AValue: TArrowType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TArrowType_sw.FromVar(const AValue: OleVariant): TArrowType;
begin
  Result := TArrowType(Integer(AValue));
end;

{ TGradientDirection_sw }

class function TGradientDirection_sw.GetTypeName: WideString;
begin
  Result := 'TGradientDirection';
end;

class procedure TGradientDirection_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'gdHorizontal'; Value: Integer({$IFDEF LMDSCT_12}TGradientDirection.{$ENDIF}gdHorizontal)),
    (Name: 'gdVertical'; Value: Integer({$IFDEF LMDSCT_12}TGradientDirection.{$ENDIF}gdVertical))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TGradientDirection_sw.ToVar(
  const AValue: TGradientDirection): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TGradientDirection_sw.FromVar(
  const AValue: OleVariant): TGradientDirection;
begin
  Result := TGradientDirection(Integer(AValue));
end;

{ TColorArraySortType_sw }

class function TColorArraySortType_sw.GetTypeName: WideString;
begin
  Result := 'TColorArraySortType';
end;

class procedure TColorArraySortType_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..6] of TLMDEnumerator = (
    (Name: 'stHue'; Value: Integer({$IFDEF LMDSCT_12}TColorArraySortType.{$ENDIF}stHue)),
    (Name: 'stSaturation'; Value: Integer({$IFDEF LMDSCT_12}TColorArraySortType.{$ENDIF}stSaturation)),
    (Name: 'stLuminance'; Value: Integer({$IFDEF LMDSCT_12}TColorArraySortType.{$ENDIF}stLuminance)),
    (Name: 'stRed'; Value: Integer({$IFDEF LMDSCT_12}TColorArraySortType.{$ENDIF}stRed)),
    (Name: 'stGreen'; Value: Integer({$IFDEF LMDSCT_12}TColorArraySortType.{$ENDIF}stGreen)),
    (Name: 'stBlue'; Value: Integer({$IFDEF LMDSCT_12}TColorArraySortType.{$ENDIF}stBlue)),
    (Name: 'stCombo'; Value: Integer({$IFDEF LMDSCT_12}TColorArraySortType.{$ENDIF}stCombo))
  );
begin
  AEnums := @ENUMS;
  ACount := 7;
end;

class function TColorArraySortType_sw.ToVar(
  const AValue: TColorArraySortType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TColorArraySortType_sw.FromVar(
  const AValue: OleVariant): TColorArraySortType;
begin
  Result := TColorArraySortType(Integer(AValue));
end;

{ GraphUtil_sw }

function GraphUtil_TScrollDirection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TScrollDirection = (sdLeft, sdRight, sdUp, sdDown);

  Result := TLMDUnitWrapper.TypeToVar(TScrollDirection_sw);
end;

function GraphUtil_TArrowType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TArrowType = (atSolid, atArrows);

  Result := TLMDUnitWrapper.TypeToVar(TArrowType_sw);
end;

function GraphUtil_TGradientDirection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGradientDirection = (gdHorizontal, gdVertical);

  Result := TLMDUnitWrapper.TypeToVar(TGradientDirection_sw);
end;

function GraphUtil_GradientFillCanvas_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure GradientFillCanvas(const ACanvas: TCanvas; cons...

  GraphUtil.GradientFillCanvas(TCanvas_sw.FromVar(AArgs[0]), TColor_sw.FromVar(
    AArgs[1]), TColor_sw.FromVar(AArgs[2]), TRect_sw.FromVar(AArgs[3]),
    TGradientDirection_sw.FromVar(AArgs[4]));
end;

function GraphUtil_ScaleImage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure ScaleImage(const SourceBitmap: TBitmap; const R...

  GraphUtil.ScaleImage(TBitmap_sw.FromVar(AArgs[0]), TBitmap_sw.FromVar(
    AArgs[1]), Double(AArgs[2]));
end;

function GraphUtil_ColorToWebColorStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ColorToWebColorStr(Color: TColor): string;

  Result := GraphUtil.ColorToWebColorStr(TColor_sw.FromVar(AArgs[0]));
end;

function GraphUtil_ColorToWebColorName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ColorToWebColorName(Color: TColor): string;

  Result := GraphUtil.ColorToWebColorName(TColor_sw.FromVar(AArgs[0]));
end;

function GraphUtil_WebColorToRGB_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function WebColorToRGB(WebColor: Integer): Integer;

  Result := GraphUtil.WebColorToRGB(Integer(AArgs[0]));
end;

function GraphUtil_RGBToWebColorStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RGBToWebColorStr(RGB: Integer): string;

  Result := GraphUtil.RGBToWebColorStr(Integer(AArgs[0]));
end;

function GraphUtil_RGBToWebColorName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RGBToWebColorName(RGB: Integer): string;

  Result := GraphUtil.RGBToWebColorName(Integer(AArgs[0]));
end;

function GraphUtil_WebColorNameToColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function WebColorNameToColor(WebColorName: string): TColor;

  Result := TColor_sw.ToVar(GraphUtil.WebColorNameToColor(string(AArgs[0])));
end;

function GraphUtil_WebColorStrToColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function WebColorStrToColor(WebColor: string): TColor;

  Result := TColor_sw.ToVar(GraphUtil.WebColorStrToColor(string(AArgs[0])));
end;

function GraphUtil_TColorArraySortType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorArraySortType = (stHue, stSaturation, stLumina...

  Result := TLMDUnitWrapper.TypeToVar(TColorArraySortType_sw);
end;

function GraphUtil_SplitTransparentBitmap_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SplitTransparentBitmap(Source: TBitmap; SourceRe...

  Result := TBitmap_sw.ToVar(GraphUtil.SplitTransparentBitmap(TBitmap_sw.
    FromVar(AArgs[0]), TRect_sw.FromVar(AArgs[1])));
end;

function GraphUtil_LoadCompressedResourceBitmap_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function LoadCompressedResourceBitmap(ResID: string): TBi...

  Result := TBitmap_sw.ToVar(GraphUtil.LoadCompressedResourceBitmap(string(
    AArgs[0])));
end;

class function GraphUtil_sw.GetUnitName: WideString;
begin
  Result := 'GraphUtil';
end;

class procedure GraphUtil_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TScrollDirection_sw, GraphUtil_TScrollDirection_si);
  AData.AddType(TArrowType_sw, GraphUtil_TArrowType_si);
  AData.AddType(TGradientDirection_sw, GraphUtil_TGradientDirection_si);
  AData.AddProcedure('GradientFillCanvas', GraphUtil_GradientFillCanvas_si, 5, False);
  AData.AddProcedure('ScaleImage', GraphUtil_ScaleImage_si, 3, False);
  AData.AddFunction('ColorToWebColorStr', GraphUtil_ColorToWebColorStr_si, string_sw, 1, False);
  AData.AddFunction('ColorToWebColorName', GraphUtil_ColorToWebColorName_si, string_sw, 1, False);
  AData.AddFunction('WebColorToRGB', GraphUtil_WebColorToRGB_si, Integer_sw, 1, False);
  AData.AddFunction('RGBToWebColorStr', GraphUtil_RGBToWebColorStr_si, string_sw, 1, False);
  AData.AddFunction('RGBToWebColorName', GraphUtil_RGBToWebColorName_si, string_sw, 1, False);
  AData.AddFunction('WebColorNameToColor', GraphUtil_WebColorNameToColor_si, TColor_sw, 1, False);
  AData.AddFunction('WebColorStrToColor', GraphUtil_WebColorStrToColor_si, TColor_sw, 1, False);
  AData.AddType(TColorArraySortType_sw, GraphUtil_TColorArraySortType_si);
  AData.AddFunction('SplitTransparentBitmap', GraphUtil_SplitTransparentBitmap_si, TBitmap_sw, 2, False);
  AData.AddFunction('LoadCompressedResourceBitmap', GraphUtil_LoadCompressedResourceBitmap_si, TBitmap_sw, 1, False);
end;

class function GraphUtil_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(GraphUtil_sw);
end;

initialization
  RegisterUnitWrapper(GraphUtil_sw);

end.
