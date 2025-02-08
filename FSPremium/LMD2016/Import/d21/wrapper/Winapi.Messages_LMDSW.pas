unit Winapi.Messages_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Winapi.Messages' unit.
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
  Winapi.Windows, Winapi.Messages, Winapi.Windows_LMDSW;


{ Type wrappers }

type

  TWordFiller_sw = class(TLMDRecordWrapper)
  private
    FValue: TWordFiller;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TWordFiller): OleVariant;
    class function FromVar(const AValue: OleVariant): TWordFiller;
  end;

  TDWordFiller_sw = class(TLMDRecordWrapper)
  private
    FValue: TDWordFiller;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TDWordFiller): OleVariant;
    class function FromVar(const AValue: OleVariant): TDWordFiller;
  end;

  TMessage_sw = class(TLMDRecordWrapper)
  private
    FValue: TMessage;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TMessage): OleVariant;
    class function FromVar(const AValue: OleVariant): TMessage;
  end;

  TWMNoParams_sw = class(TLMDRecordWrapper)
  private
    FValue: TWMNoParams;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TWMNoParams): OleVariant;
    class function FromVar(const AValue: OleVariant): TWMNoParams;
  end;

  TWMKey_sw = class(TLMDRecordWrapper)
  private
    FValue: TWMKey;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TWMKey): OleVariant;
    class function FromVar(const AValue: OleVariant): TWMKey;
  end;

  TWMMouse_sw = class(TLMDRecordWrapper)
  private
    FValue: TWMMouse;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TWMMouse): OleVariant;
    class function FromVar(const AValue: OleVariant): TWMMouse;
  end;

  TWMMenuChar_sw = class(TLMDRecordWrapper)
  private
    FValue: TWMMenuChar;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TWMMenuChar): OleVariant;
    class function FromVar(const AValue: OleVariant): TWMMenuChar;
  end;

  TWMNCHitTest_sw = class(TLMDRecordWrapper)
  private
    FValue: TWMNCHitTest;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TWMNCHitTest): OleVariant;
    class function FromVar(const AValue: OleVariant): TWMNCHitTest;
  end;


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

{ TWordFiller_sw }

function TWordFiller_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TWordFiller_sw.Create as IDispatch;
end;

function TWordFiller_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TWordFiller;

  // Implicit record copy method.
  Result := TWordFiller_sw.ToVar(TWordFiller(AObj));
end;

class function TWordFiller_sw.GetTypeName: WideString;
begin
  Result := 'TWordFiller';
end;

function TWordFiller_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TWordFiller_sw.Create;
  TWordFiller_sw(Result).FValue := FValue;
end;

class procedure TWordFiller_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TWordFiller_Copy_si, TWordFiller_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TWordFiller_Create_si, 0, False);
end;

class function TWordFiller_sw.ToVar(const AValue: TWordFiller): OleVariant;
var
  wrpr: TWordFiller_sw;
begin
  wrpr        := TWordFiller_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TWordFiller_sw.FromVar(const AValue: OleVariant): TWordFiller;
begin
  Result := TWordFiller_sw(ConvFromVar(AValue)).FValue;
end;

{ TDWordFiller_sw }

function TDWordFiller_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TDWordFiller_sw.Create as IDispatch;
end;

function TDWordFiller_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TDWordFiller;

  // Implicit record copy method.
  Result := TDWordFiller_sw.ToVar(TDWordFiller(AObj));
end;

class function TDWordFiller_sw.GetTypeName: WideString;
begin
  Result := 'TDWordFiller';
end;

function TDWordFiller_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TDWordFiller_sw.Create;
  TDWordFiller_sw(Result).FValue := FValue;
end;

class procedure TDWordFiller_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TDWordFiller_Copy_si, TDWordFiller_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TDWordFiller_Create_si, 0, False);
end;

class function TDWordFiller_sw.ToVar(const AValue: TDWordFiller): OleVariant;
var
  wrpr: TDWordFiller_sw;
begin
  wrpr        := TDWordFiller_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TDWordFiller_sw.FromVar(const AValue: OleVariant): TDWordFiller;
begin
  Result := TDWordFiller_sw(ConvFromVar(AValue)).FValue;
end;

{ TMessage_sw }

function TMessage_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TMessage_sw(AObj).FValue.Msg
  else
    TMessage_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TMessage_WParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WParam: WPARAM;

  if IsGet then
    Result := WPARAM_sw.ToVar(TMessage_sw(AObj).FValue.WParam)
  else
    TMessage_sw(AObj).FValue.WParam := WPARAM_sw.FromVar(AArgs[0]);
end;

function TMessage_LParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LParam: LPARAM;

  if IsGet then
    Result := LPARAM_sw.ToVar(TMessage_sw(AObj).FValue.LParam)
  else
    TMessage_sw(AObj).FValue.LParam := LPARAM_sw.FromVar(AArgs[0]);
end;

function TMessage_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: LRESULT;

  if IsGet then
    Result := LRESULT_sw.ToVar(TMessage_sw(AObj).FValue.Result)
  else
    TMessage_sw(AObj).FValue.Result := LRESULT_sw.FromVar(AArgs[0]);
end;

function TMessage_WParamLo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WParamLo: Word;

  if IsGet then
    Result := TMessage_sw(AObj).FValue.WParamLo
  else
    TMessage_sw(AObj).FValue.WParamLo := Word(AArgs[0]);
end;

function TMessage_WParamHi_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WParamHi: Word;

  if IsGet then
    Result := TMessage_sw(AObj).FValue.WParamHi
  else
    TMessage_sw(AObj).FValue.WParamHi := Word(AArgs[0]);
end;

function TMessage_WParamFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var WParamFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TMessage_sw(AObj).FValue.WParamFiller)
  else
    TMessage_sw(AObj).FValue.WParamFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TMessage_LParamLo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LParamLo: Word;

  if IsGet then
    Result := TMessage_sw(AObj).FValue.LParamLo
  else
    TMessage_sw(AObj).FValue.LParamLo := Word(AArgs[0]);
end;

function TMessage_LParamHi_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LParamHi: Word;

  if IsGet then
    Result := TMessage_sw(AObj).FValue.LParamHi
  else
    TMessage_sw(AObj).FValue.LParamHi := Word(AArgs[0]);
end;

function TMessage_LParamFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LParamFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TMessage_sw(AObj).FValue.LParamFiller)
  else
    TMessage_sw(AObj).FValue.LParamFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TMessage_ResultLo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResultLo: Word;

  if IsGet then
    Result := TMessage_sw(AObj).FValue.ResultLo
  else
    TMessage_sw(AObj).FValue.ResultLo := Word(AArgs[0]);
end;

function TMessage_ResultHi_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResultHi: Word;

  if IsGet then
    Result := TMessage_sw(AObj).FValue.ResultHi
  else
    TMessage_sw(AObj).FValue.ResultHi := Word(AArgs[0]);
end;

function TMessage_ResultFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ResultFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TMessage_sw(AObj).FValue.ResultFiller)
  else
    TMessage_sw(AObj).FValue.ResultFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TMessage_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TMessage_sw.Create as IDispatch;
end;

function TMessage_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TMessage;

  // Implicit record copy method.
  Result := TMessage_sw.ToVar(TMessage(AObj));
end;

class function TMessage_sw.GetTypeName: WideString;
begin
  Result := 'TMessage';
end;

function TMessage_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TMessage_sw.Create;
  TMessage_sw(Result).FValue := FValue;
end;

class procedure TMessage_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TMessage_Msg_si, Cardinal_sw);
  AData.AddField('WParam', TMessage_WParam_si, WPARAM_sw);
  AData.AddField('LParam', TMessage_LParam_si, LPARAM_sw);
  AData.AddField('Result', TMessage_Result_si, LRESULT_sw);
  AData.AddField('WParamLo', TMessage_WParamLo_si, Word_sw);
  AData.AddField('WParamHi', TMessage_WParamHi_si, Word_sw);
  AData.AddField('WParamFiller', TMessage_WParamFiller_si, TDWordFiller_sw);
  AData.AddField('LParamLo', TMessage_LParamLo_si, Word_sw);
  AData.AddField('LParamHi', TMessage_LParamHi_si, Word_sw);
  AData.AddField('LParamFiller', TMessage_LParamFiller_si, TDWordFiller_sw);
  AData.AddField('ResultLo', TMessage_ResultLo_si, Word_sw);
  AData.AddField('ResultHi', TMessage_ResultHi_si, Word_sw);
  AData.AddField('ResultFiller', TMessage_ResultFiller_si, TDWordFiller_sw);
  AData.AddFunction('Copy', TMessage_Copy_si, TMessage_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TMessage_Create_si, 0, False);
end;

class function TMessage_sw.ToVar(const AValue: TMessage): OleVariant;
var
  wrpr: TMessage_sw;
begin
  wrpr        := TMessage_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TMessage_sw.FromVar(const AValue: OleVariant): TMessage;
begin
  Result := TMessage_sw(ConvFromVar(AValue)).FValue;
end;

{ TWMNoParams_sw }

function TWMNoParams_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TWMNoParams_sw(AObj).FValue.Msg
  else
    TWMNoParams_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TWMNoParams_MsgFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MsgFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMNoParams_sw(AObj).FValue.MsgFiller)
  else
    TWMNoParams_sw(AObj).FValue.MsgFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TWMNoParams_UnusedFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var UnusedFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMNoParams_sw(AObj).FValue.UnusedFiller)
  else
    TWMNoParams_sw(AObj).FValue.UnusedFiller := TDWordFiller_sw.FromVar(
      AArgs[0]);
end;

function TWMNoParams_UnusedFiller2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var UnusedFiller2: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMNoParams_sw(AObj).FValue.UnusedFiller2)
  else
    TWMNoParams_sw(AObj).FValue.UnusedFiller2 := TDWordFiller_sw.FromVar(
      AArgs[0]);
end;

function TWMNoParams_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: LRESULT;

  if IsGet then
    Result := LRESULT_sw.ToVar(TWMNoParams_sw(AObj).FValue.Result)
  else
    TWMNoParams_sw(AObj).FValue.Result := LRESULT_sw.FromVar(AArgs[0]);
end;

function TWMNoParams_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TWMNoParams_sw.Create as IDispatch;
end;

function TWMNoParams_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TWMNoParams;

  // Implicit record copy method.
  Result := TWMNoParams_sw.ToVar(TWMNoParams(AObj));
end;

class function TWMNoParams_sw.GetTypeName: WideString;
begin
  Result := 'TWMNoParams';
end;

function TWMNoParams_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TWMNoParams_sw.Create;
  TWMNoParams_sw(Result).FValue := FValue;
end;

class procedure TWMNoParams_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TWMNoParams_Msg_si, Cardinal_sw);
  AData.AddField('MsgFiller', TWMNoParams_MsgFiller_si, TDWordFiller_sw);
  AData.AddField('UnusedFiller', TWMNoParams_UnusedFiller_si, TDWordFiller_sw);
  AData.AddField('UnusedFiller2', TWMNoParams_UnusedFiller2_si, TDWordFiller_sw);
  AData.AddField('Result', TWMNoParams_Result_si, LRESULT_sw);
  AData.AddFunction('Copy', TWMNoParams_Copy_si, TWMNoParams_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TWMNoParams_Create_si, 0, False);
end;

class function TWMNoParams_sw.ToVar(const AValue: TWMNoParams): OleVariant;
var
  wrpr: TWMNoParams_sw;
begin
  wrpr        := TWMNoParams_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TWMNoParams_sw.FromVar(const AValue: OleVariant): TWMNoParams;
begin
  Result := TWMNoParams_sw(ConvFromVar(AValue)).FValue;
end;

{ TWMKey_sw }

function TWMKey_Msg_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TWMKey_sw(AObj).FValue.Msg
  else
    TWMKey_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TWMKey_MsgFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MsgFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMKey_sw(AObj).FValue.MsgFiller)
  else
    TWMKey_sw(AObj).FValue.MsgFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TWMKey_CharCode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CharCode: Word;

  if IsGet then
    Result := TWMKey_sw(AObj).FValue.CharCode
  else
    TWMKey_sw(AObj).FValue.CharCode := Word(AArgs[0]);
end;

function TWMKey_Unused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Unused: Word;

  if IsGet then
    Result := TWMKey_sw(AObj).FValue.Unused
  else
    TWMKey_sw(AObj).FValue.Unused := Word(AArgs[0]);
end;

function TWMKey_CharCodeUnusedFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CharCodeUnusedFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMKey_sw(AObj).FValue.CharCodeUnusedFiller)
  else
    TWMKey_sw(AObj).FValue.CharCodeUnusedFiller := TDWordFiller_sw.FromVar(
      AArgs[0]);
end;

function TWMKey_KeyData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var KeyData: Longint;

  if IsGet then
    Result := TWMKey_sw(AObj).FValue.KeyData
  else
    TWMKey_sw(AObj).FValue.KeyData := Longint(AArgs[0]);
end;

function TWMKey_KeyDataFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var KeyDataFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMKey_sw(AObj).FValue.KeyDataFiller)
  else
    TWMKey_sw(AObj).FValue.KeyDataFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TWMKey_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: LRESULT;

  if IsGet then
    Result := LRESULT_sw.ToVar(TWMKey_sw(AObj).FValue.Result)
  else
    TWMKey_sw(AObj).FValue.Result := LRESULT_sw.FromVar(AArgs[0]);
end;

function TWMKey_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TWMKey_sw.Create as IDispatch;
end;

function TWMKey_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Copy: TWMKey;

  // Implicit record copy method.
  Result := TWMKey_sw.ToVar(TWMKey(AObj));
end;

class function TWMKey_sw.GetTypeName: WideString;
begin
  Result := 'TWMKey';
end;

function TWMKey_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TWMKey_sw.Create;
  TWMKey_sw(Result).FValue := FValue;
end;

class procedure TWMKey_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TWMKey_Msg_si, Cardinal_sw);
  AData.AddField('MsgFiller', TWMKey_MsgFiller_si, TDWordFiller_sw);
  AData.AddField('CharCode', TWMKey_CharCode_si, Word_sw);
  AData.AddField('Unused', TWMKey_Unused_si, Word_sw);
  AData.AddField('CharCodeUnusedFiller', TWMKey_CharCodeUnusedFiller_si, TDWordFiller_sw);
  AData.AddField('KeyData', TWMKey_KeyData_si, Longint_sw);
  AData.AddField('KeyDataFiller', TWMKey_KeyDataFiller_si, TDWordFiller_sw);
  AData.AddField('Result', TWMKey_Result_si, LRESULT_sw);
  AData.AddFunction('Copy', TWMKey_Copy_si, TWMKey_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TWMKey_Create_si, 0, False);
end;

class function TWMKey_sw.ToVar(const AValue: TWMKey): OleVariant;
var
  wrpr: TWMKey_sw;
begin
  wrpr        := TWMKey_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TWMKey_sw.FromVar(const AValue: OleVariant): TWMKey;
begin
  Result := TWMKey_sw(ConvFromVar(AValue)).FValue;
end;

{ TWMMouse_sw }

function TWMMouse_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TWMMouse_sw(AObj).FValue.Msg
  else
    TWMMouse_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TWMMouse_MsgFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MsgFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMMouse_sw(AObj).FValue.MsgFiller)
  else
    TWMMouse_sw(AObj).FValue.MsgFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TWMMouse_Keys_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Keys: Longint;

  if IsGet then
    Result := TWMMouse_sw(AObj).FValue.Keys
  else
    TWMMouse_sw(AObj).FValue.Keys := Longint(AArgs[0]);
end;

function TWMMouse_KeysFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var KeysFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMMouse_sw(AObj).FValue.KeysFiller)
  else
    TWMMouse_sw(AObj).FValue.KeysFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TWMMouse_XPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var XPos: Smallint;

  if IsGet then
    Result := TWMMouse_sw(AObj).FValue.XPos
  else
    TWMMouse_sw(AObj).FValue.XPos := Smallint(AArgs[0]);
end;

function TWMMouse_YPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var YPos: Smallint;

  if IsGet then
    Result := TWMMouse_sw(AObj).FValue.YPos
  else
    TWMMouse_sw(AObj).FValue.YPos := Smallint(AArgs[0]);
end;

function TWMMouse_XYPosFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var XYPosFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMMouse_sw(AObj).FValue.XYPosFiller)
  else
    TWMMouse_sw(AObj).FValue.XYPosFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TWMMouse_PosFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PosFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMMouse_sw(AObj).FValue.PosFiller)
  else
    TWMMouse_sw(AObj).FValue.PosFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TWMMouse_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: LRESULT;

  if IsGet then
    Result := LRESULT_sw.ToVar(TWMMouse_sw(AObj).FValue.Result)
  else
    TWMMouse_sw(AObj).FValue.Result := LRESULT_sw.FromVar(AArgs[0]);
end;

function TWMMouse_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TWMMouse_sw.Create as IDispatch;
end;

function TWMMouse_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TWMMouse;

  // Implicit record copy method.
  Result := TWMMouse_sw.ToVar(TWMMouse(AObj));
end;

class function TWMMouse_sw.GetTypeName: WideString;
begin
  Result := 'TWMMouse';
end;

function TWMMouse_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TWMMouse_sw.Create;
  TWMMouse_sw(Result).FValue := FValue;
end;

class procedure TWMMouse_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TWMMouse_Msg_si, Cardinal_sw);
  AData.AddField('MsgFiller', TWMMouse_MsgFiller_si, TDWordFiller_sw);
  AData.AddField('Keys', TWMMouse_Keys_si, Longint_sw);
  AData.AddField('KeysFiller', TWMMouse_KeysFiller_si, TDWordFiller_sw);
  AData.AddField('XPos', TWMMouse_XPos_si, Smallint_sw);
  AData.AddField('YPos', TWMMouse_YPos_si, Smallint_sw);
  AData.AddField('XYPosFiller', TWMMouse_XYPosFiller_si, TDWordFiller_sw);
  AData.AddField('PosFiller', TWMMouse_PosFiller_si, TDWordFiller_sw);
  AData.AddField('Result', TWMMouse_Result_si, LRESULT_sw);
  AData.AddFunction('Copy', TWMMouse_Copy_si, TWMMouse_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TWMMouse_Create_si, 0, False);
end;

class function TWMMouse_sw.ToVar(const AValue: TWMMouse): OleVariant;
var
  wrpr: TWMMouse_sw;
begin
  wrpr        := TWMMouse_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TWMMouse_sw.FromVar(const AValue: OleVariant): TWMMouse;
begin
  Result := TWMMouse_sw(ConvFromVar(AValue)).FValue;
end;

{ TWMMenuChar_sw }

function TWMMenuChar_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TWMMenuChar_sw(AObj).FValue.Msg
  else
    TWMMenuChar_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TWMMenuChar_MsgFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MsgFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMMenuChar_sw(AObj).FValue.MsgFiller)
  else
    TWMMenuChar_sw(AObj).FValue.MsgFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TWMMenuChar_User_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var User: Char;

  if IsGet then
    Result := Ord(TWMMenuChar_sw(AObj).FValue.User)
  else
    TWMMenuChar_sw(AObj).FValue.User := Char(Integer(AArgs[0]));
end;

function TWMMenuChar_MenuFlag_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MenuFlag: Word;

  if IsGet then
    Result := TWMMenuChar_sw(AObj).FValue.MenuFlag
  else
    TWMMenuChar_sw(AObj).FValue.MenuFlag := Word(AArgs[0]);
end;

function TWMMenuChar_UserMenuFlagFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var UserMenuFlagFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMMenuChar_sw(AObj).FValue.
      UserMenuFlagFiller)
  else
    TWMMenuChar_sw(AObj).FValue.UserMenuFlagFiller := TDWordFiller_sw.FromVar(
      AArgs[0]);
end;

function TWMMenuChar_Menu_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Menu: HMENU;

  if IsGet then
    Result := HMENU_sw.ToVar(TWMMenuChar_sw(AObj).FValue.Menu)
  else
    TWMMenuChar_sw(AObj).FValue.Menu := HMENU_sw.FromVar(AArgs[0]);
end;

function TWMMenuChar_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: LRESULT;

  if IsGet then
    Result := LRESULT_sw.ToVar(TWMMenuChar_sw(AObj).FValue.Result)
  else
    TWMMenuChar_sw(AObj).FValue.Result := LRESULT_sw.FromVar(AArgs[0]);
end;

function TWMMenuChar_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TWMMenuChar_sw.Create as IDispatch;
end;

function TWMMenuChar_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TWMMenuChar;

  // Implicit record copy method.
  Result := TWMMenuChar_sw.ToVar(TWMMenuChar(AObj));
end;

class function TWMMenuChar_sw.GetTypeName: WideString;
begin
  Result := 'TWMMenuChar';
end;

function TWMMenuChar_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TWMMenuChar_sw.Create;
  TWMMenuChar_sw(Result).FValue := FValue;
end;

class procedure TWMMenuChar_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TWMMenuChar_Msg_si, Cardinal_sw);
  AData.AddField('MsgFiller', TWMMenuChar_MsgFiller_si, TDWordFiller_sw);
  AData.AddField('User', TWMMenuChar_User_si, Char_sw);
  AData.AddField('MenuFlag', TWMMenuChar_MenuFlag_si, Word_sw);
  AData.AddField('UserMenuFlagFiller', TWMMenuChar_UserMenuFlagFiller_si, TDWordFiller_sw);
  AData.AddField('Menu', TWMMenuChar_Menu_si, HMENU_sw);
  AData.AddField('Result', TWMMenuChar_Result_si, LRESULT_sw);
  AData.AddFunction('Copy', TWMMenuChar_Copy_si, TWMMenuChar_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TWMMenuChar_Create_si, 0, False);
end;

class function TWMMenuChar_sw.ToVar(const AValue: TWMMenuChar): OleVariant;
var
  wrpr: TWMMenuChar_sw;
begin
  wrpr        := TWMMenuChar_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TWMMenuChar_sw.FromVar(const AValue: OleVariant): TWMMenuChar;
begin
  Result := TWMMenuChar_sw(ConvFromVar(AValue)).FValue;
end;

{ TWMNCHitTest_sw }

function TWMNCHitTest_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TWMNCHitTest_sw(AObj).FValue.Msg
  else
    TWMNCHitTest_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TWMNCHitTest_MsgFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var MsgFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMNCHitTest_sw(AObj).FValue.MsgFiller)
  else
    TWMNCHitTest_sw(AObj).FValue.MsgFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TWMNCHitTest_Unused_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Unused: WPARAM;

  if IsGet then
    Result := WPARAM_sw.ToVar(TWMNCHitTest_sw(AObj).FValue.Unused)
  else
    TWMNCHitTest_sw(AObj).FValue.Unused := WPARAM_sw.FromVar(AArgs[0]);
end;

function TWMNCHitTest_XPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var XPos: Smallint;

  if IsGet then
    Result := TWMNCHitTest_sw(AObj).FValue.XPos
  else
    TWMNCHitTest_sw(AObj).FValue.XPos := Smallint(AArgs[0]);
end;

function TWMNCHitTest_YPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var YPos: Smallint;

  if IsGet then
    Result := TWMNCHitTest_sw(AObj).FValue.YPos
  else
    TWMNCHitTest_sw(AObj).FValue.YPos := Smallint(AArgs[0]);
end;

function TWMNCHitTest_XYPosFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var XYPosFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMNCHitTest_sw(AObj).FValue.XYPosFiller)
  else
    TWMNCHitTest_sw(AObj).FValue.XYPosFiller := TDWordFiller_sw.FromVar(
      AArgs[0]);
end;

function TWMNCHitTest_PosFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PosFiller: TDWordFiller;

  if IsGet then
    Result := TDWordFiller_sw.ToVar(TWMNCHitTest_sw(AObj).FValue.PosFiller)
  else
    TWMNCHitTest_sw(AObj).FValue.PosFiller := TDWordFiller_sw.FromVar(AArgs[0]);
end;

function TWMNCHitTest_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: LRESULT;

  if IsGet then
    Result := LRESULT_sw.ToVar(TWMNCHitTest_sw(AObj).FValue.Result)
  else
    TWMNCHitTest_sw(AObj).FValue.Result := LRESULT_sw.FromVar(AArgs[0]);
end;

function TWMNCHitTest_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TWMNCHitTest_sw.Create as IDispatch;
end;

function TWMNCHitTest_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TWMNCHitTest;

  // Implicit record copy method.
  Result := TWMNCHitTest_sw.ToVar(TWMNCHitTest(AObj));
end;

class function TWMNCHitTest_sw.GetTypeName: WideString;
begin
  Result := 'TWMNCHitTest';
end;

function TWMNCHitTest_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TWMNCHitTest_sw.Create;
  TWMNCHitTest_sw(Result).FValue := FValue;
end;

class procedure TWMNCHitTest_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Msg', TWMNCHitTest_Msg_si, Cardinal_sw);
  AData.AddField('MsgFiller', TWMNCHitTest_MsgFiller_si, TDWordFiller_sw);
  AData.AddField('Unused', TWMNCHitTest_Unused_si, WPARAM_sw);
  AData.AddField('XPos', TWMNCHitTest_XPos_si, Smallint_sw);
  AData.AddField('YPos', TWMNCHitTest_YPos_si, Smallint_sw);
  AData.AddField('XYPosFiller', TWMNCHitTest_XYPosFiller_si, TDWordFiller_sw);
  AData.AddField('PosFiller', TWMNCHitTest_PosFiller_si, TDWordFiller_sw);
  AData.AddField('Result', TWMNCHitTest_Result_si, LRESULT_sw);
  AData.AddFunction('Copy', TWMNCHitTest_Copy_si, TWMNCHitTest_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TWMNCHitTest_Create_si, 0, False);
end;

class function TWMNCHitTest_sw.ToVar(const AValue: TWMNCHitTest): OleVariant;
var
  wrpr: TWMNCHitTest_sw;
begin
  wrpr        := TWMNCHitTest_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TWMNCHitTest_sw.FromVar(const AValue: OleVariant): TWMNCHitTest;
begin
  Result := TWMNCHitTest_sw(ConvFromVar(AValue)).FValue;
end;

{ Messages_sw }

function Messages_TWordFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWordFiller = record;

  Result := TLMDUnitWrapper.TypeToVar(TWordFiller_sw);
end;

function Messages_TDWordFiller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TDWordFiller = record;

  Result := TLMDUnitWrapper.TypeToVar(TDWordFiller_sw);
end;

function Messages_TMessage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMessage = record;

  Result := TLMDUnitWrapper.TypeToVar(TMessage_sw);
end;

function Messages_TWMNoParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWMNoParams = record;

  Result := TLMDUnitWrapper.TypeToVar(TWMNoParams_sw);
end;

function Messages_TWMKey_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWMKey = record;

  Result := TLMDUnitWrapper.TypeToVar(TWMKey_sw);
end;

function Messages_TWMMouse_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWMMouse = record;

  Result := TLMDUnitWrapper.TypeToVar(TWMMouse_sw);
end;

function Messages_TWMMenuChar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWMMenuChar = record;

  Result := TLMDUnitWrapper.TypeToVar(TWMMenuChar_sw);
end;

function Messages_TWMNCHitTest_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWMNCHitTest = record;

  Result := TLMDUnitWrapper.TypeToVar(TWMNCHitTest_sw);
end;

class function Messages_sw.GetUnitName: WideString;
begin
  Result := 'Messages';
end;

class procedure Messages_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TWordFiller_sw, Messages_TWordFiller_si);
  AData.AddType(TDWordFiller_sw, Messages_TDWordFiller_si);
  AData.AddType(TMessage_sw, Messages_TMessage_si);
  AData.AddType(TWMNoParams_sw, Messages_TWMNoParams_si);
  AData.AddType(TWMKey_sw, Messages_TWMKey_si);
  AData.AddType(TWMMouse_sw, Messages_TWMMouse_si);
  AData.AddType(TWMMenuChar_sw, Messages_TWMMenuChar_si);
  AData.AddType(TWMNCHitTest_sw, Messages_TWMNCHitTest_si);
end;

class function Messages_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Messages_sw);
end;

initialization
  RegisterUnitWrapper(Messages_sw);

end.
