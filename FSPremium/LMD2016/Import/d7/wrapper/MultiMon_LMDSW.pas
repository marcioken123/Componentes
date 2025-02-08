unit MultiMon_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'MultiMon' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  SysUtils, Classes, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Windows, MultiMon, Windows_LMDSW;


{ Type wrappers }

type

  HMONITOR_sw = class(Integer_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HMONITOR): OleVariant;
    class function FromVar(const AValue: OleVariant): HMONITOR;
  end;


{ Unit wrapper }

type
  MultiMon_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ HMONITOR_sw }

class function HMONITOR_sw.GetTypeName: WideString;
begin
  Result := 'HMONITOR';
end;

class function HMONITOR_sw.ToVar(const AValue: HMONITOR): OleVariant;
begin
  Result := Integer_sw.ToVar(Integer(AValue));
end;

class function HMONITOR_sw.FromVar(const AValue: OleVariant): HMONITOR;
begin
  Result := HMONITOR(Integer_sw.FromVar(AValue));
end;

{ MultiMon_sw }

function MultiMon_HMONITOR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HMONITOR = Integer;

  Result := TLMDUnitWrapper.TypeToVar(HMONITOR_sw);
end;

class function MultiMon_sw.GetUnitName: WideString;
begin
  Result := 'MultiMon';
end;

class procedure MultiMon_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(HMONITOR_sw, MultiMon_HMONITOR_si);
end;

class function MultiMon_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(MultiMon_sw);
end;

initialization
  RegisterUnitWrapper(MultiMon_sw);

end.
