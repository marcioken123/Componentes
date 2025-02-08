unit Winapi.ShlObj_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Winapi.ShlObj' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Types, System.Classes, System.SysUtils, System.Variants,
  System.TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers,
  Winapi.Windows, Winapi.CommCtrl, Winapi.Messages, Winapi.ShlObj,
  Winapi.Windows_LMDSW, Winapi.CommCtrl_LMDSW, Winapi.Messages_LMDSW;


{ Unit wrapper }

type
  ShlObj_sw = class(TLMDUnitWrapper)
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ ShlObj_sw }

class function ShlObj_sw.GetUnitName: WideString;
begin
  Result := 'ShlObj';
end;

class function ShlObj_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(ShlObj_sw);
end;

initialization
  RegisterUnitWrapper(ShlObj_sw);

end.
