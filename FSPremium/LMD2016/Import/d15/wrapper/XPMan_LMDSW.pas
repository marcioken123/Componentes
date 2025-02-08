unit XPMan_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'XPMan' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Types, Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, SysUtils, Classes, XPMan, SysUtils_LMDSW, Classes_LMDSW;


{ Type wrappers }

type
  TXPManifest_sw = class;

  TXPManifest_sc = class of TXPManifest;
  TXPManifest_sw = class(TComponent_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TXPManifest): OleVariant;
    class function FromVar(const AValue: OleVariant): TXPManifest;
    class function ClassToVar(AClass: TXPManifest_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TXPManifest_sc;
  end;


{ Unit wrapper }

type
  XPMan_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TXPManifest_sw }

class function TXPManifest_sw.GetTypeName: WideString;
begin
  Result := 'TXPManifest';
end;

class function TXPManifest_sw.GetWrappedClass: TClass;
begin
  Result := TXPManifest;
end;

class procedure TXPManifest_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TXPManifest_sw.ToVar(const AValue: TXPManifest): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TXPManifest_sw.FromVar(const AValue: OleVariant): TXPManifest;
begin
  Result := TXPManifest(ConvFromVar(AValue, TXPManifest));
end;

class function TXPManifest_sw.ClassToVar(AClass: TXPManifest_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TXPManifest_sw.ClassFromVar(
  const AClass: OleVariant): TXPManifest_sc;
begin
  Result := TXPManifest_sc(ConvClsFromVar(AClass, TXPManifest));
end;

{ XPMan_sw }

function XPMan_TXPManifest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TXPManifest = class(TComponent);

  Result := TLMDUnitWrapper.TypeToVar(TXPManifest_sw);
end;

class function XPMan_sw.GetUnitName: WideString;
begin
  Result := 'XPMan';
end;

class procedure XPMan_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TXPManifest_sw, XPMan_TXPManifest_si);
end;

class function XPMan_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(XPMan_sw);
end;

initialization
  RegisterUnitWrapper(XPMan_sw);
  RegisterClassWrapper(TXPManifest_sw);

end.
