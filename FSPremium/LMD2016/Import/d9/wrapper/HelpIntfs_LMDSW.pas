unit HelpIntfs_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'HelpIntfs' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Variants, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, SysUtils, Classes, HelpIntfs, SysUtils_LMDSW,
  Classes_LMDSW;


{ Unit wrapper }

type
  HelpIntfs_sw = class(TLMDUnitWrapper)
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ HelpIntfs_sw }

class function HelpIntfs_sw.GetUnitName: WideString;
begin
  Result := 'HelpIntfs';
end;

class function HelpIntfs_sw.ToVar(
  AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(HelpIntfs_sw);
end;

initialization
  RegisterUnitWrapper(HelpIntfs_sw);

end.
