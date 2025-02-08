unit CommDlg_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'CommDlg' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Classes, SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Types, Windows, Messages, CommDlg,
  Windows_LMDSW, Messages_LMDSW;


{ Unit wrapper }

type
  CommDlg_sw = class(TLMDUnitWrapper)
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ CommDlg_sw }

class function CommDlg_sw.GetUnitName: WideString;
begin
  Result := 'CommDlg';
end;

class function CommDlg_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(CommDlg_sw);
end;

initialization
  RegisterUnitWrapper(CommDlg_sw);

end.
