unit RichEdit_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'RichEdit' unit.
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
  LMDSctWrappers, LMDSctSysWrappers, Messages, Windows, RichEdit,
  Messages_LMDSW, Windows_LMDSW;


{ Unit wrapper }

type
  RichEdit_sw = class(TLMDUnitWrapper)
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ RichEdit_sw }

class function RichEdit_sw.GetUnitName: WideString;
begin
  Result := 'RichEdit';
end;

class function RichEdit_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(RichEdit_sw);
end;

initialization
  RegisterUnitWrapper(RichEdit_sw);

end.
