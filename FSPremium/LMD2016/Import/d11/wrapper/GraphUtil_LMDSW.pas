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
  SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Types, Windows, Graphics, Classes, GraphUtil,
  Windows_LMDSW, Graphics_LMDSW, Classes_LMDSW;


{ Type wrappers }

type

  TScrollDirection_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TScrollDirection): OleVariant;
    class function FromVar(const AValue: OleVariant): TScrollDirection;
  end;

  TArrowType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TArrowType): OleVariant;
    class function FromVar(const AValue: OleVariant): TArrowType;
  end;

  TGradientDirection_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TGradientDirection): OleVariant;
    class function FromVar(const AValue: OleVariant): TGradientDirection;
  end;

  TColorArraySortType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
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

class function TScrollDirection_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TScrollDirection);
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

class function TArrowType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TArrowType);
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

class function TGradientDirection_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TGradientDirection);
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

class function TColorArraySortType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TColorArraySortType);
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
  // type TScrollDirection = (sdRight, sdUp, sdDown);

  Result := TLMDUnitWrapper.TypeToVar(TScrollDirection_sw);
end;

function GraphUtil_TArrowType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TArrowType = (atArrows);

  Result := TLMDUnitWrapper.TypeToVar(TArrowType_sw);
end;

function GraphUtil_TGradientDirection_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGradientDirection = (gdVertical);

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
  // type TColorArraySortType = (stSaturation, stLuminance, st...

  Result := TLMDUnitWrapper.TypeToVar(TColorArraySortType_sw);
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
end;

class function GraphUtil_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(GraphUtil_sw);
end;

initialization
  RegisterUnitWrapper(GraphUtil_sw);

end.
