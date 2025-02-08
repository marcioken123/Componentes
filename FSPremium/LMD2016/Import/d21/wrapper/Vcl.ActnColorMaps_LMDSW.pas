unit Vcl.ActnColorMaps_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Vcl.ActnColorMaps' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Types, System.SysUtils, System.Variants, System.TypInfo, LMDTypes,
  LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers, Winapi.Windows,
  System.Classes, Vcl.Graphics, Vcl.ActnMan, Vcl.ActnColorMaps,
  Winapi.Windows_LMDSW, System.Classes_LMDSW, Vcl.Graphics_LMDSW,
  Vcl.ActnMan_LMDSW;


{ Type wrappers }

type
  TStandardColorMap_sw = class;
  TXPColorMap_sw = class;
  TTwilightColorMap_sw = class;
  TThemedColorMap_sw = class;

  TStandardColorMap_sc = class of TStandardColorMap;
  TStandardColorMap_sw = class(TCustomActionBarColorMap_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TStandardColorMap): OleVariant;
    class function FromVar(const AValue: OleVariant): TStandardColorMap;
    class function ClassToVar(AClass: TStandardColorMap_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TStandardColorMap_sc;
  end;

  TXPColorMap_sc = class of TXPColorMap;
  TXPColorMap_sw = class(TCustomActionBarColorMap_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TXPColorMap): OleVariant;
    class function FromVar(const AValue: OleVariant): TXPColorMap;
    class function ClassToVar(AClass: TXPColorMap_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TXPColorMap_sc;
  end;

  TTwilightColorMap_sc = class of TTwilightColorMap;
  TTwilightColorMap_sw = class(TCustomActionBarColorMap_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TTwilightColorMap): OleVariant;
    class function FromVar(const AValue: OleVariant): TTwilightColorMap;
    class function ClassToVar(AClass: TTwilightColorMap_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TTwilightColorMap_sc;
  end;

  TThemedColorMap_sc = class of TThemedColorMap;
  TThemedColorMap_sw = class(TCustomActionBarColorMap_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TThemedColorMap): OleVariant;
    class function FromVar(const AValue: OleVariant): TThemedColorMap;
    class function ClassToVar(AClass: TThemedColorMap_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TThemedColorMap_sc;
  end;


{ Unit wrapper }

type
  ActnColorMaps_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TStandardColorMap_sw }

class function TStandardColorMap_sw.GetTypeName: WideString;
begin
  Result := 'TStandardColorMap';
end;

class function TStandardColorMap_sw.GetWrappedClass: TClass;
begin
  Result := TStandardColorMap;
end;

class procedure TStandardColorMap_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('HighlightColor', False);
  AData.AddPropertyRedecl('UnusedColor', False);
  AData.AddPropertyRedecl('BtnFrameColor', False);
  AData.AddPropertyRedecl('BtnSelectedColor', False);
  AData.AddPropertyRedecl('BtnSelectedFont', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('DisabledFontColor', False);
  AData.AddPropertyRedecl('DisabledFontShadow', False);
  AData.AddPropertyRedecl('FontColor', False);
  AData.AddPropertyRedecl('HotColor', False);
  AData.AddPropertyRedecl('HotFontColor', False);
  AData.AddPropertyRedecl('MenuColor', False);
  AData.AddPropertyRedecl('FrameTopLeftInner', False);
  AData.AddPropertyRedecl('FrameTopLeftOuter', False);
  AData.AddPropertyRedecl('FrameBottomRightInner', False);
  AData.AddPropertyRedecl('FrameBottomRightOuter', False);
  AData.AddPropertyRedecl('DisabledColor', False);
  AData.AddPropertyRedecl('SelectedColor', False);
  AData.AddPropertyRedecl('SelectedFontColor', False);
  AData.AddPropertyRedecl('ShadowColor', False);
  AData.AddPropertyRedecl('OnColorChange', False);
end;

class function TStandardColorMap_sw.ToVar(
  const AValue: TStandardColorMap): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TStandardColorMap_sw.FromVar(
  const AValue: OleVariant): TStandardColorMap;
begin
  Result := TStandardColorMap(ConvFromVar(AValue, TStandardColorMap));
end;

class function TStandardColorMap_sw.ClassToVar(
  AClass: TStandardColorMap_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TStandardColorMap_sw.ClassFromVar(
  const AClass: OleVariant): TStandardColorMap_sc;
begin
  Result := TStandardColorMap_sc(ConvClsFromVar(AClass, TStandardColorMap));
end;

{ TXPColorMap_sw }

class function TXPColorMap_sw.GetTypeName: WideString;
begin
  Result := 'TXPColorMap';
end;

class function TXPColorMap_sw.GetWrappedClass: TClass;
begin
  Result := TXPColorMap;
end;

class procedure TXPColorMap_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('ShadowColor', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('DisabledColor', False);
  AData.AddPropertyRedecl('DisabledFontColor', False);
  AData.AddPropertyRedecl('DisabledFontShadow', False);
  AData.AddPropertyRedecl('FontColor', False);
  AData.AddPropertyRedecl('HighlightColor', False);
  AData.AddPropertyRedecl('HotColor', False);
  AData.AddPropertyRedecl('HotFontColor', False);
  AData.AddPropertyRedecl('MenuColor', False);
  AData.AddPropertyRedecl('FrameTopLeftInner', False);
  AData.AddPropertyRedecl('FrameTopLeftOuter', False);
  AData.AddPropertyRedecl('FrameBottomRightInner', False);
  AData.AddPropertyRedecl('FrameBottomRightOuter', False);
  AData.AddPropertyRedecl('BtnFrameColor', False);
  AData.AddPropertyRedecl('BtnSelectedColor', False);
  AData.AddPropertyRedecl('BtnSelectedFont', False);
  AData.AddPropertyRedecl('SelectedColor', False);
  AData.AddPropertyRedecl('SelectedFontColor', False);
  AData.AddPropertyRedecl('UnusedColor', False);
  AData.AddPropertyRedecl('OnColorChange', False);
end;

class function TXPColorMap_sw.ToVar(const AValue: TXPColorMap): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TXPColorMap_sw.FromVar(const AValue: OleVariant): TXPColorMap;
begin
  Result := TXPColorMap(ConvFromVar(AValue, TXPColorMap));
end;

class function TXPColorMap_sw.ClassToVar(AClass: TXPColorMap_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TXPColorMap_sw.ClassFromVar(
  const AClass: OleVariant): TXPColorMap_sc;
begin
  Result := TXPColorMap_sc(ConvClsFromVar(AClass, TXPColorMap));
end;

{ TTwilightColorMap_sw }

class function TTwilightColorMap_sw.GetTypeName: WideString;
begin
  Result := 'TTwilightColorMap';
end;

class function TTwilightColorMap_sw.GetWrappedClass: TClass;
begin
  Result := TTwilightColorMap;
end;

class procedure TTwilightColorMap_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('DisabledFontColor', False);
  AData.AddPropertyRedecl('DisabledFontShadow', False);
  AData.AddPropertyRedecl('FontColor', False);
  AData.AddPropertyRedecl('HighlightColor', False);
  AData.AddPropertyRedecl('HotColor', False);
  AData.AddPropertyRedecl('HotFontColor', False);
  AData.AddPropertyRedecl('FrameTopLeftInner', False);
  AData.AddPropertyRedecl('FrameTopLeftOuter', False);
  AData.AddPropertyRedecl('FrameBottomRightInner', False);
  AData.AddPropertyRedecl('FrameBottomRightOuter', False);
  AData.AddPropertyRedecl('BtnFrameColor', False);
  AData.AddPropertyRedecl('BtnSelectedColor', False);
  AData.AddPropertyRedecl('BtnSelectedFont', False);
  AData.AddPropertyRedecl('MenuColor', False);
  AData.AddPropertyRedecl('DisabledColor', False);
  AData.AddPropertyRedecl('SelectedColor', False);
  AData.AddPropertyRedecl('SelectedFontColor', False);
  AData.AddPropertyRedecl('ShadowColor', False);
  AData.AddPropertyRedecl('UnusedColor', False);
  AData.AddPropertyRedecl('OnColorChange', False);
end;

class function TTwilightColorMap_sw.ToVar(
  const AValue: TTwilightColorMap): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TTwilightColorMap_sw.FromVar(
  const AValue: OleVariant): TTwilightColorMap;
begin
  Result := TTwilightColorMap(ConvFromVar(AValue, TTwilightColorMap));
end;

class function TTwilightColorMap_sw.ClassToVar(
  AClass: TTwilightColorMap_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TTwilightColorMap_sw.ClassFromVar(
  const AClass: OleVariant): TTwilightColorMap_sc;
begin
  Result := TTwilightColorMap_sc(ConvClsFromVar(AClass, TTwilightColorMap));
end;

{ TThemedColorMap_sw }

class function TThemedColorMap_sw.GetTypeName: WideString;
begin
  Result := 'TThemedColorMap';
end;

class function TThemedColorMap_sw.GetWrappedClass: TClass;
begin
  Result := TThemedColorMap;
end;

class procedure TThemedColorMap_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddPropertyRedecl('ShadowColor', False);
  AData.AddPropertyRedecl('Color', False);
  AData.AddPropertyRedecl('DisabledColor', False);
  AData.AddPropertyRedecl('DisabledFontColor', False);
  AData.AddPropertyRedecl('DisabledFontShadow', False);
  AData.AddPropertyRedecl('FontColor', False);
  AData.AddPropertyRedecl('HighlightColor', False);
  AData.AddPropertyRedecl('HotColor', False);
  AData.AddPropertyRedecl('HotFontColor', False);
  AData.AddPropertyRedecl('MenuColor', False);
  AData.AddPropertyRedecl('FrameTopLeftInner', False);
  AData.AddPropertyRedecl('FrameTopLeftOuter', False);
  AData.AddPropertyRedecl('FrameBottomRightInner', False);
  AData.AddPropertyRedecl('FrameBottomRightOuter', False);
  AData.AddPropertyRedecl('BtnFrameColor', False);
  AData.AddPropertyRedecl('BtnSelectedColor', False);
  AData.AddPropertyRedecl('BtnSelectedFont', False);
  AData.AddPropertyRedecl('SelectedColor', False);
  AData.AddPropertyRedecl('SelectedFontColor', False);
  AData.AddPropertyRedecl('UnusedColor', False);
  AData.AddPropertyRedecl('OnColorChange', False);
end;

class function TThemedColorMap_sw.ToVar(
  const AValue: TThemedColorMap): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TThemedColorMap_sw.FromVar(
  const AValue: OleVariant): TThemedColorMap;
begin
  Result := TThemedColorMap(ConvFromVar(AValue, TThemedColorMap));
end;

class function TThemedColorMap_sw.ClassToVar(
  AClass: TThemedColorMap_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TThemedColorMap_sw.ClassFromVar(
  const AClass: OleVariant): TThemedColorMap_sc;
begin
  Result := TThemedColorMap_sc(ConvClsFromVar(AClass, TThemedColorMap));
end;

{ ActnColorMaps_sw }

function ActnColorMaps_TStandardColorMap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStandardColorMap = class(TCustomActionBarColorMap);

  Result := TLMDUnitWrapper.TypeToVar(TStandardColorMap_sw);
end;

function ActnColorMaps_cXPFrameOuter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cXPFrameOuter = <value>;

  Result := cXPFrameOuter;
end;

function ActnColorMaps_cXPBtnFrameColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cXPBtnFrameColor = <value>;

  Result := cXPBtnFrameColor;
end;

function ActnColorMaps_cXPSelectedColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const cXPSelectedColor = <value>;

  Result := cXPSelectedColor;
end;

function ActnColorMaps_TXPColorMap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TXPColorMap = class(TCustomActionBarColorMap);

  Result := TLMDUnitWrapper.TypeToVar(TXPColorMap_sw);
end;

function ActnColorMaps_TTwilightColorMap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTwilightColorMap = class(TCustomActionBarColorMap);

  Result := TLMDUnitWrapper.TypeToVar(TTwilightColorMap_sw);
end;

function ActnColorMaps_TThemedColorMap_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TThemedColorMap = class(TCustomActionBarColorMap);

  Result := TLMDUnitWrapper.TypeToVar(TThemedColorMap_sw);
end;

class function ActnColorMaps_sw.GetUnitName: WideString;
begin
  Result := 'ActnColorMaps';
end;

class procedure ActnColorMaps_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TStandardColorMap_sw, ActnColorMaps_TStandardColorMap_si);
  AData.AddConstant('cXPFrameOuter', ActnColorMaps_cXPFrameOuter_si, nil, VarType(Vcl.ActnColorMaps.cXPFrameOuter));
  AData.AddConstant('cXPBtnFrameColor', ActnColorMaps_cXPBtnFrameColor_si, nil, VarType(Vcl.ActnColorMaps.cXPBtnFrameColor));
  AData.AddConstant('cXPSelectedColor', ActnColorMaps_cXPSelectedColor_si, nil, VarType(Vcl.ActnColorMaps.cXPSelectedColor));
  AData.AddType(TXPColorMap_sw, ActnColorMaps_TXPColorMap_si);
  AData.AddType(TTwilightColorMap_sw, ActnColorMaps_TTwilightColorMap_si);
  AData.AddType(TThemedColorMap_sw, ActnColorMaps_TThemedColorMap_si);
end;

class function ActnColorMaps_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ActnColorMaps_sw);
end;

initialization
  RegisterUnitWrapper(ActnColorMaps_sw);
  RegisterClassWrapper(TStandardColorMap_sw);
  RegisterClassWrapper(TXPColorMap_sw);
  RegisterClassWrapper(TTwilightColorMap_sw);
  RegisterClassWrapper(TThemedColorMap_sw);

end.
