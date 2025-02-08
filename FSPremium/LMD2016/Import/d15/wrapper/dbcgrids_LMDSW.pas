unit DBCGrids_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'DBCGrids' unit.
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
  LMDSctSysWrappers, SysUtils, Windows, Messages, Classes, Controls, Forms,
  Graphics, Menus, DB, DBCGrids, SysUtils_LMDSW, Windows_LMDSW, Messages_LMDSW,
  Classes_LMDSW, Controls_LMDSW, Forms_LMDSW, Graphics_LMDSW, Menus_LMDSW,
  DB_LMDSW;


{ Unit wrapper }

type
  DBCGrids_sw = class(TLMDUnitWrapper)
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ DBCGrids_sw }

class function DBCGrids_sw.GetUnitName: WideString;
begin
  Result := 'DBCGrids';
end;

class function DBCGrids_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(DBCGrids_sw);
end;

initialization
  RegisterUnitWrapper(DBCGrids_sw);

end.
