unit ShadowWnd_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'ShadowWnd' unit.
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
  LMDSctSysWrappers, Windows, Messages, Classes, Controls, Forms, Graphics,
  ShadowWnd, Windows_LMDSW, Messages_LMDSW, Classes_LMDSW, Controls_LMDSW,
  Forms_LMDSW, Graphics_LMDSW;


{ Type wrappers }

type
  TShadowWindow_sw = class;

  TControlSide_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TControlSide): OleVariant;
    class function FromVar(const AValue: OleVariant): TControlSide;
  end;

  TShadowWindow_sc = class of TShadowWindow;
  TShadowWindow_sw = class(TCustomControl_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TShadowWindow): OleVariant;
    class function FromVar(const AValue: OleVariant): TShadowWindow;
    class function ClassToVar(AClass: TShadowWindow_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TShadowWindow_sc;
  end;


{ Unit wrapper }

type
  ShadowWnd_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TControlSide_sw }

class function TControlSide_sw.GetTypeName: WideString;
begin
  Result := 'TControlSide';
end;

class procedure TControlSide_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..1] of TLMDEnumerator = (
    (Name: 'csRight'; Value: Integer({$IFDEF LMDSCT_12}TControlSide.{$ENDIF}csRight)),
    (Name: 'csBottom'; Value: Integer({$IFDEF LMDSCT_12}TControlSide.{$ENDIF}csBottom))
  );
begin
  AEnums := @ENUMS;
  ACount := 2;
end;

class function TControlSide_sw.ToVar(const AValue: TControlSide): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TControlSide_sw.FromVar(const AValue: OleVariant): TControlSide;
begin
  Result := TControlSide(Integer(AValue));
end;

{ TShadowWindow_sw }

function TShadowWindow_CreateShadow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor CreateShadow(AOwner: TComponent; ControlSide:...

  Result := TShadowWindow_sw.ToVar(TShadowWindow_sc(AObj).CreateShadow(
    TComponent_sw.FromVar(AArgs[0]), TControlSide_sw.FromVar(AArgs[1])));
end;

function TShadowWindow_Control_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Control: TControl read <getter> write <setter>;

  if IsGet then
    Result := TControl_sw.ToVar(TShadowWindow(AObj).Control)
  else
    TShadowWindow(AObj).Control := TControl_sw.FromVar(AArgs[0]);
end;

function TShadowWindow_Side_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property Side: TControlSide read <getter> write <setter>;

  if IsGet then
    Result := TControlSide_sw.ToVar(TShadowWindow(AObj).Side)
  else
    TShadowWindow(AObj).Side := TControlSide_sw.FromVar(AArgs[0]);
end;

class function TShadowWindow_sw.GetTypeName: WideString;
begin
  Result := 'TShadowWindow';
end;

class function TShadowWindow_sw.GetWrappedClass: TClass;
begin
  Result := TShadowWindow;
end;

class procedure TShadowWindow_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('Control', TShadowWindow_Control_si, TControl_sw, True, True, 0, False, False);
  AData.AddProperty('Side', TShadowWindow_Side_si, TControlSide_sw, True, True, 0, False, False);

  { Class members }

  AData.AddConstructor('CreateShadow', TShadowWindow_CreateShadow_si, 2, False);
end;

class function TShadowWindow_sw.ToVar(const AValue: TShadowWindow): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TShadowWindow_sw.FromVar(
  const AValue: OleVariant): TShadowWindow;
begin
  Result := TShadowWindow(ConvFromVar(AValue, TShadowWindow));
end;

class function TShadowWindow_sw.ClassToVar(
  AClass: TShadowWindow_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TShadowWindow_sw.ClassFromVar(
  const AClass: OleVariant): TShadowWindow_sc;
begin
  Result := TShadowWindow_sc(ConvClsFromVar(AClass, TShadowWindow));
end;

{ ShadowWnd_sw }

function ShadowWnd_TControlSide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TControlSide = (csRight, csBottom);

  Result := TLMDUnitWrapper.TypeToVar(TControlSide_sw);
end;

function ShadowWnd_TShadowWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TShadowWindow = class(TCustomControl);

  Result := TLMDUnitWrapper.TypeToVar(TShadowWindow_sw);
end;

class function ShadowWnd_sw.GetUnitName: WideString;
begin
  Result := 'ShadowWnd';
end;

class procedure ShadowWnd_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TControlSide_sw, ShadowWnd_TControlSide_si);
  AData.AddType(TShadowWindow_sw, ShadowWnd_TShadowWindow_si);
end;

class function ShadowWnd_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ShadowWnd_sw);
end;

initialization
  RegisterUnitWrapper(ShadowWnd_sw);
  RegisterClassWrapper(TShadowWindow_sw);

end.
