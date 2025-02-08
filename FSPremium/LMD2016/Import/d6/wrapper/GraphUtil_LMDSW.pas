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
  SysUtils, Classes, Variants, TypInfo, LMDTypes, LMDSctClass, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Windows, Graphics, GraphUtil,
  Windows_LMDSW, Graphics_LMDSW;


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

function GraphUtil_GetHighLightColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetHighLightColor(const Color: TColor): TColor;

  Result := TColor_sw.ToVar(GraphUtil.GetHighLightColor(TColor_sw.FromVar(
    AArgs[0])));
end;

function GraphUtil_GetShadowColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetShadowColor(const Color: TColor): TColor;

  Result := TColor_sw.ToVar(GraphUtil.GetShadowColor(TColor_sw.FromVar(
    AArgs[0])));
end;

function GraphUtil_DrawCheck_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DrawCheck(ACanvas: TCanvas; Location: TPoint; S...

  case AArgsSize of
    3:
    begin
      GraphUtil.DrawCheck(TCanvas_sw.FromVar(AArgs[0]), TPoint_sw.FromVar(
        AArgs[1]), Integer(AArgs[2]));
    end;
    4:
    begin
      GraphUtil.DrawCheck(TCanvas_sw.FromVar(AArgs[0]), TPoint_sw.FromVar(
        AArgs[1]), Integer(AArgs[2]), Boolean(AArgs[3]));
    end;
  else
    WrongArgCountError('DrawCheck');
  end;
end;

function GraphUtil_DrawChevron_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DrawChevron(ACanvas: TCanvas; Direction: TScrol...

  GraphUtil.DrawChevron(TCanvas_sw.FromVar(AArgs[0]), TScrollDirection_sw.
    FromVar(AArgs[1]), TPoint_sw.FromVar(AArgs[2]), Integer(AArgs[3]));
end;

function GraphUtil_DrawArrow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure DrawArrow(ACanvas: TCanvas; Direction: TScrollD...

  GraphUtil.DrawArrow(TCanvas_sw.FromVar(AArgs[0]), TScrollDirection_sw.FromVar(
    AArgs[1]), TPoint_sw.FromVar(AArgs[2]), Integer(AArgs[3]));
end;

function GraphUtil_ColorRGBToHLS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Word;
  v_2: Word;
  v_3: Word;
begin
  // procedure ColorRGBToHLS(clrRGB: COLORREF; var Hue: Word; ...

  v_1 := Word(AArgs[1]);
  v_2 := Word(AArgs[2]);
  v_3 := Word(AArgs[3]);
  GraphUtil.ColorRGBToHLS(COLORREF_sw.FromVar(AArgs[0]), v_1, v_2, v_3);
  AssignRefParam(AArgs[1], v_1);
  AssignRefParam(AArgs[2], v_2);
  AssignRefParam(AArgs[3], v_3);
end;

function GraphUtil_ColorHLSToRGB_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ColorHLSToRGB(Hue: Word; Luminance: Word; Satura...

  Result := TColorRef_sw.ToVar(GraphUtil.ColorHLSToRGB(Word(AArgs[0]), Word(
    AArgs[1]), Word(AArgs[2])));
end;

function GraphUtil_ColorAdjustLuma_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function ColorAdjustLuma(clrRGB: TColorRef; n: Integer; f...

  Result := TColorRef_sw.ToVar(GraphUtil.ColorAdjustLuma(TColorRef_sw.FromVar(
    AArgs[0]), Integer(AArgs[1]), BOOL_sw.FromVar(AArgs[2])));
end;

class function GraphUtil_sw.GetUnitName: WideString;
begin
  Result := 'GraphUtil';
end;

class procedure GraphUtil_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TScrollDirection_sw, GraphUtil_TScrollDirection_si);
  AData.AddType(TArrowType_sw, GraphUtil_TArrowType_si);
  AData.AddFunction('GetHighLightColor', GraphUtil_GetHighLightColor_si, TColor_sw, 1, False);
  AData.AddFunction('GetShadowColor', GraphUtil_GetShadowColor_si, TColor_sw, 1, False);
  AData.AddProcedure('DrawCheck', GraphUtil_DrawCheck_si, 3, True);
  AData.AddProcedure('DrawChevron', GraphUtil_DrawChevron_si, 4, False);
  AData.AddProcedure('DrawArrow', GraphUtil_DrawArrow_si, 4, False);
  AData.AddProcedure('ColorRGBToHLS', GraphUtil_ColorRGBToHLS_si, 4, False);
  AData.AddFunction('ColorHLSToRGB', GraphUtil_ColorHLSToRGB_si, TColorRef_sw, 3, False);
  AData.AddFunction('ColorAdjustLuma', GraphUtil_ColorAdjustLuma_si, TColorRef_sw, 3, False);
end;

class function GraphUtil_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(GraphUtil_sw);
end;

initialization
  RegisterUnitWrapper(GraphUtil_sw);

end.
