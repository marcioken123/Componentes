unit CommCtrl_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'CommCtrl' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Types, Classes, SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Messages, Windows, CommCtrl,
  Messages_LMDSW, Windows_LMDSW;


{ Type wrappers }

type

  HIMAGELIST_sw = THandle_sw;


{ Unit wrapper }

type
  CommCtrl_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ CommCtrl_sw }

function CommCtrl_HIMAGELIST_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HIMAGELIST = THandle;

  Result := TLMDUnitWrapper.TypeToVar(HIMAGELIST_sw);
end;

class function CommCtrl_sw.GetUnitName: WideString;
begin
  Result := 'CommCtrl';
end;

class procedure CommCtrl_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(HIMAGELIST_sw, CommCtrl_HIMAGELIST_si);
end;

class function CommCtrl_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(CommCtrl_sw);
end;

initialization
  RegisterUnitWrapper(CommCtrl_sw);

end.
