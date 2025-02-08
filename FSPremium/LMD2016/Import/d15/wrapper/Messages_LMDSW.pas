unit Messages_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Messages' unit.
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
  LMDSctWrappers, LMDSctSysWrappers, Types, Windows, Messages, Windows_LMDSW;


{ Unit wrapper }

type
  Messages_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ Messages_sw }

function Messages_SBM_GETSCROLLBARINFO_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SBM_GETSCROLLBARINFO = <value>;

  Result := SBM_GETSCROLLBARINFO;
end;

function Messages_SendGetIntMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Integer;
  v_2: Integer;
begin
  // function SendGetIntMessage(Handle: HWND; Msg: UINT; var W...

  v_1 := Integer(AArgs[2]);
  v_2 := Integer(AArgs[3]);
  Result := LRESULT_sw.ToVar(Messages.SendGetIntMessage(HWND_sw.FromVar(
    AArgs[0]), UINT_sw.FromVar(AArgs[1]), v_1, v_2));
  AssignRefParam(AArgs[2], v_1);
  AssignRefParam(AArgs[3], v_2);
end;

class function Messages_sw.GetUnitName: WideString;
begin
  Result := 'Messages';
end;

class procedure Messages_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('SBM_GETSCROLLBARINFO', Messages_SBM_GETSCROLLBARINFO_si, nil, VarType(Messages.SBM_GETSCROLLBARINFO));
  AData.AddFunction('SendGetIntMessage', Messages_SendGetIntMessage_si, LRESULT_sw, 4, False);
end;

class function Messages_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Messages_sw);
end;

initialization
  RegisterUnitWrapper(Messages_sw);

end.
