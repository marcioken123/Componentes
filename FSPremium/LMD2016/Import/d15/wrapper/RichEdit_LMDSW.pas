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
  Classes, SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Types, Messages, Windows, RichEdit,
  Messages_LMDSW, Windows_LMDSW;


{ Type wrappers }

type

  _CHARFORMAT2A_sw = class(TLMDRecordWrapper)
  private
    FValue: _CHARFORMAT2A;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _CHARFORMAT2A): OleVariant;
    class function FromVar(const AValue: OleVariant): _CHARFORMAT2A;
  end;

  _CHARFORMAT2W_sw = class(TLMDRecordWrapper)
  private
    FValue: _CHARFORMAT2W;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _CHARFORMAT2W): OleVariant;
    class function FromVar(const AValue: OleVariant): _CHARFORMAT2W;
  end;

  _CHARFORMAT2_sw = _CHARFORMAT2W_sw;

  TWMNotifyRE_sw = class(TLMDRecordWrapper)
  private
    FValue: TWMNotifyRE;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TWMNotifyRE): OleVariant;
    class function FromVar(const AValue: OleVariant): TWMNotifyRE;
  end;


{ Unit wrapper }

type
  RichEdit_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ _CHARFORMAT2A_sw }

function _CHARFORMAT2A_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _CHARFORMAT2A_sw.ToVar(_CHARFORMAT2A(AObj));
end;

function _CHARFORMAT2A_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _CHARFORMAT2A_sw.Create as IDispatch;
end;

function _CHARFORMAT2A_cbSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbSize: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(_CHARFORMAT2A_sw(AObj).FValue.cbSize)
  else
    _CHARFORMAT2A_sw(AObj).FValue.cbSize := UINT_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2A_dwMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwMask: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CHARFORMAT2A_sw(AObj).FValue.dwMask)
  else
    _CHARFORMAT2A_sw(AObj).FValue.dwMask := DWORD_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2A_dwEffects_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwEffects: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CHARFORMAT2A_sw(AObj).FValue.dwEffects)
  else
    _CHARFORMAT2A_sw(AObj).FValue.dwEffects := DWORD_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2A_yHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var yHeight: Longint;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.yHeight
  else
    _CHARFORMAT2A_sw(AObj).FValue.yHeight := Longint(AArgs[0]);
end;

function _CHARFORMAT2A_yOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var yOffset: Longint;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.yOffset
  else
    _CHARFORMAT2A_sw(AObj).FValue.yOffset := Longint(AArgs[0]);
end;

function _CHARFORMAT2A_crTextColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var crTextColor: TColorRef;

  if IsGet then
    Result := TColorRef_sw.ToVar(_CHARFORMAT2A_sw(AObj).FValue.crTextColor)
  else
    _CHARFORMAT2A_sw(AObj).FValue.crTextColor := TColorRef_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2A_bCharSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bCharSet: Byte;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.bCharSet
  else
    _CHARFORMAT2A_sw(AObj).FValue.bCharSet := Byte(AArgs[0]);
end;

function _CHARFORMAT2A_bPitchAndFamily_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bPitchAndFamily: Byte;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.bPitchAndFamily
  else
    _CHARFORMAT2A_sw(AObj).FValue.bPitchAndFamily := Byte(AArgs[0]);
end;

function _CHARFORMAT2A_wWeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wWeight: Word;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.wWeight
  else
    _CHARFORMAT2A_sw(AObj).FValue.wWeight := Word(AArgs[0]);
end;

function _CHARFORMAT2A_sSpacing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var sSpacing: Smallint;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.sSpacing
  else
    _CHARFORMAT2A_sw(AObj).FValue.sSpacing := Smallint(AArgs[0]);
end;

function _CHARFORMAT2A_crBackColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var crBackColor: TColorRef;

  if IsGet then
    Result := TColorRef_sw.ToVar(_CHARFORMAT2A_sw(AObj).FValue.crBackColor)
  else
    _CHARFORMAT2A_sw(AObj).FValue.crBackColor := TColorRef_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2A_lid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lid: LCID;

  if IsGet then
    Result := LCID_sw.ToVar(_CHARFORMAT2A_sw(AObj).FValue.lid)
  else
    _CHARFORMAT2A_sw(AObj).FValue.lid := LCID_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2A_dwReserved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwReserved: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CHARFORMAT2A_sw(AObj).FValue.dwReserved)
  else
    _CHARFORMAT2A_sw(AObj).FValue.dwReserved := DWORD_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2A_sStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var sStyle: Smallint;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.sStyle
  else
    _CHARFORMAT2A_sw(AObj).FValue.sStyle := Smallint(AArgs[0]);
end;

function _CHARFORMAT2A_wKerning_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wKerning: Word;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.wKerning
  else
    _CHARFORMAT2A_sw(AObj).FValue.wKerning := Word(AArgs[0]);
end;

function _CHARFORMAT2A_bUnderlineType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bUnderlineType: Byte;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.bUnderlineType
  else
    _CHARFORMAT2A_sw(AObj).FValue.bUnderlineType := Byte(AArgs[0]);
end;

function _CHARFORMAT2A_bAnimation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bAnimation: Byte;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.bAnimation
  else
    _CHARFORMAT2A_sw(AObj).FValue.bAnimation := Byte(AArgs[0]);
end;

function _CHARFORMAT2A_bRevAuthor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bRevAuthor: Byte;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.bRevAuthor
  else
    _CHARFORMAT2A_sw(AObj).FValue.bRevAuthor := Byte(AArgs[0]);
end;

function _CHARFORMAT2A_bReserved1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bReserved1: Byte;

  if IsGet then
    Result := _CHARFORMAT2A_sw(AObj).FValue.bReserved1
  else
    _CHARFORMAT2A_sw(AObj).FValue.bReserved1 := Byte(AArgs[0]);
end;

class function _CHARFORMAT2A_sw.GetTypeName: WideString;
begin
  Result := '_CHARFORMAT2A';
end;

function _CHARFORMAT2A_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _CHARFORMAT2A_sw.Create;
  _CHARFORMAT2A_sw(Result).FValue := FValue;
end;

class procedure _CHARFORMAT2A_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _CHARFORMAT2A_Copy_si, _CHARFORMAT2A_sw, 0);
  AData.AddField('cbSize', _CHARFORMAT2A_cbSize_si, UINT_sw);
  AData.AddField('dwMask', _CHARFORMAT2A_dwMask_si, DWORD_sw);
  AData.AddField('dwEffects', _CHARFORMAT2A_dwEffects_si, DWORD_sw);
  AData.AddField('yHeight', _CHARFORMAT2A_yHeight_si, Longint_sw);
  AData.AddField('yOffset', _CHARFORMAT2A_yOffset_si, Longint_sw);
  AData.AddField('crTextColor', _CHARFORMAT2A_crTextColor_si, TColorRef_sw);
  AData.AddField('bCharSet', _CHARFORMAT2A_bCharSet_si, Byte_sw);
  AData.AddField('bPitchAndFamily', _CHARFORMAT2A_bPitchAndFamily_si, Byte_sw);
  AData.AddField('wWeight', _CHARFORMAT2A_wWeight_si, Word_sw);
  AData.AddField('sSpacing', _CHARFORMAT2A_sSpacing_si, Smallint_sw);
  AData.AddField('crBackColor', _CHARFORMAT2A_crBackColor_si, TColorRef_sw);
  AData.AddField('lid', _CHARFORMAT2A_lid_si, LCID_sw);
  AData.AddField('dwReserved', _CHARFORMAT2A_dwReserved_si, DWORD_sw);
  AData.AddField('sStyle', _CHARFORMAT2A_sStyle_si, Smallint_sw);
  AData.AddField('wKerning', _CHARFORMAT2A_wKerning_si, Word_sw);
  AData.AddField('bUnderlineType', _CHARFORMAT2A_bUnderlineType_si, Byte_sw);
  AData.AddField('bAnimation', _CHARFORMAT2A_bAnimation_si, Byte_sw);
  AData.AddField('bRevAuthor', _CHARFORMAT2A_bRevAuthor_si, Byte_sw);
  AData.AddField('bReserved1', _CHARFORMAT2A_bReserved1_si, Byte_sw);

  { Class members }

  AData.AddConstructor('Create', _CHARFORMAT2A_Create_si, 0);
end;

class function _CHARFORMAT2A_sw.ToVar(const AValue: _CHARFORMAT2A): OleVariant;
var
  wrpr: _CHARFORMAT2A_sw;
begin
  wrpr        := _CHARFORMAT2A_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _CHARFORMAT2A_sw.FromVar(
  const AValue: OleVariant): _CHARFORMAT2A;
begin
  Result := _CHARFORMAT2A_sw(ConvFromVar(AValue)).FValue;
end;

{ _CHARFORMAT2W_sw }

function _CHARFORMAT2W_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _CHARFORMAT2W_sw.ToVar(_CHARFORMAT2W(AObj));
end;

function _CHARFORMAT2W_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _CHARFORMAT2W_sw.Create as IDispatch;
end;

function _CHARFORMAT2W_cbSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbSize: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(_CHARFORMAT2W_sw(AObj).FValue.cbSize)
  else
    _CHARFORMAT2W_sw(AObj).FValue.cbSize := UINT_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2W_dwMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwMask: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CHARFORMAT2W_sw(AObj).FValue.dwMask)
  else
    _CHARFORMAT2W_sw(AObj).FValue.dwMask := DWORD_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2W_dwEffects_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwEffects: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CHARFORMAT2W_sw(AObj).FValue.dwEffects)
  else
    _CHARFORMAT2W_sw(AObj).FValue.dwEffects := DWORD_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2W_yHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var yHeight: Longint;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.yHeight
  else
    _CHARFORMAT2W_sw(AObj).FValue.yHeight := Longint(AArgs[0]);
end;

function _CHARFORMAT2W_yOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var yOffset: Longint;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.yOffset
  else
    _CHARFORMAT2W_sw(AObj).FValue.yOffset := Longint(AArgs[0]);
end;

function _CHARFORMAT2W_crTextColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var crTextColor: TColorRef;

  if IsGet then
    Result := TColorRef_sw.ToVar(_CHARFORMAT2W_sw(AObj).FValue.crTextColor)
  else
    _CHARFORMAT2W_sw(AObj).FValue.crTextColor := TColorRef_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2W_bCharSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bCharSet: Byte;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.bCharSet
  else
    _CHARFORMAT2W_sw(AObj).FValue.bCharSet := Byte(AArgs[0]);
end;

function _CHARFORMAT2W_bPitchAndFamily_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bPitchAndFamily: Byte;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.bPitchAndFamily
  else
    _CHARFORMAT2W_sw(AObj).FValue.bPitchAndFamily := Byte(AArgs[0]);
end;

function _CHARFORMAT2W_wWeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wWeight: Word;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.wWeight
  else
    _CHARFORMAT2W_sw(AObj).FValue.wWeight := Word(AArgs[0]);
end;

function _CHARFORMAT2W_sSpacing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var sSpacing: Smallint;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.sSpacing
  else
    _CHARFORMAT2W_sw(AObj).FValue.sSpacing := Smallint(AArgs[0]);
end;

function _CHARFORMAT2W_crBackColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var crBackColor: TColorRef;

  if IsGet then
    Result := TColorRef_sw.ToVar(_CHARFORMAT2W_sw(AObj).FValue.crBackColor)
  else
    _CHARFORMAT2W_sw(AObj).FValue.crBackColor := TColorRef_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2W_lid_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lid: LCID;

  if IsGet then
    Result := LCID_sw.ToVar(_CHARFORMAT2W_sw(AObj).FValue.lid)
  else
    _CHARFORMAT2W_sw(AObj).FValue.lid := LCID_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2W_dwReserved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwReserved: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CHARFORMAT2W_sw(AObj).FValue.dwReserved)
  else
    _CHARFORMAT2W_sw(AObj).FValue.dwReserved := DWORD_sw.FromVar(AArgs[0]);
end;

function _CHARFORMAT2W_sStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var sStyle: Smallint;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.sStyle
  else
    _CHARFORMAT2W_sw(AObj).FValue.sStyle := Smallint(AArgs[0]);
end;

function _CHARFORMAT2W_wKerning_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wKerning: Word;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.wKerning
  else
    _CHARFORMAT2W_sw(AObj).FValue.wKerning := Word(AArgs[0]);
end;

function _CHARFORMAT2W_bUnderlineType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bUnderlineType: Byte;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.bUnderlineType
  else
    _CHARFORMAT2W_sw(AObj).FValue.bUnderlineType := Byte(AArgs[0]);
end;

function _CHARFORMAT2W_bAnimation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bAnimation: Byte;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.bAnimation
  else
    _CHARFORMAT2W_sw(AObj).FValue.bAnimation := Byte(AArgs[0]);
end;

function _CHARFORMAT2W_bRevAuthor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bRevAuthor: Byte;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.bRevAuthor
  else
    _CHARFORMAT2W_sw(AObj).FValue.bRevAuthor := Byte(AArgs[0]);
end;

function _CHARFORMAT2W_bReserved1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bReserved1: Byte;

  if IsGet then
    Result := _CHARFORMAT2W_sw(AObj).FValue.bReserved1
  else
    _CHARFORMAT2W_sw(AObj).FValue.bReserved1 := Byte(AArgs[0]);
end;

class function _CHARFORMAT2W_sw.GetTypeName: WideString;
begin
  Result := '_CHARFORMAT2W';
end;

function _CHARFORMAT2W_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _CHARFORMAT2W_sw.Create;
  _CHARFORMAT2W_sw(Result).FValue := FValue;
end;

class procedure _CHARFORMAT2W_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _CHARFORMAT2W_Copy_si, _CHARFORMAT2W_sw, 0);
  AData.AddField('cbSize', _CHARFORMAT2W_cbSize_si, UINT_sw);
  AData.AddField('dwMask', _CHARFORMAT2W_dwMask_si, DWORD_sw);
  AData.AddField('dwEffects', _CHARFORMAT2W_dwEffects_si, DWORD_sw);
  AData.AddField('yHeight', _CHARFORMAT2W_yHeight_si, Longint_sw);
  AData.AddField('yOffset', _CHARFORMAT2W_yOffset_si, Longint_sw);
  AData.AddField('crTextColor', _CHARFORMAT2W_crTextColor_si, TColorRef_sw);
  AData.AddField('bCharSet', _CHARFORMAT2W_bCharSet_si, Byte_sw);
  AData.AddField('bPitchAndFamily', _CHARFORMAT2W_bPitchAndFamily_si, Byte_sw);
  AData.AddField('wWeight', _CHARFORMAT2W_wWeight_si, Word_sw);
  AData.AddField('sSpacing', _CHARFORMAT2W_sSpacing_si, Smallint_sw);
  AData.AddField('crBackColor', _CHARFORMAT2W_crBackColor_si, TColorRef_sw);
  AData.AddField('lid', _CHARFORMAT2W_lid_si, LCID_sw);
  AData.AddField('dwReserved', _CHARFORMAT2W_dwReserved_si, DWORD_sw);
  AData.AddField('sStyle', _CHARFORMAT2W_sStyle_si, Smallint_sw);
  AData.AddField('wKerning', _CHARFORMAT2W_wKerning_si, Word_sw);
  AData.AddField('bUnderlineType', _CHARFORMAT2W_bUnderlineType_si, Byte_sw);
  AData.AddField('bAnimation', _CHARFORMAT2W_bAnimation_si, Byte_sw);
  AData.AddField('bRevAuthor', _CHARFORMAT2W_bRevAuthor_si, Byte_sw);
  AData.AddField('bReserved1', _CHARFORMAT2W_bReserved1_si, Byte_sw);

  { Class members }

  AData.AddConstructor('Create', _CHARFORMAT2W_Create_si, 0);
end;

class function _CHARFORMAT2W_sw.ToVar(const AValue: _CHARFORMAT2W): OleVariant;
var
  wrpr: _CHARFORMAT2W_sw;
begin
  wrpr        := _CHARFORMAT2W_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _CHARFORMAT2W_sw.FromVar(
  const AValue: OleVariant): _CHARFORMAT2W;
begin
  Result := _CHARFORMAT2W_sw(ConvFromVar(AValue)).FValue;
end;

{ TWMNotifyRE_sw }

function TWMNotifyRE_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TWMNotifyRE_sw.ToVar(TWMNotifyRE(AObj));
end;

function TWMNotifyRE_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TWMNotifyRE_sw.Create as IDispatch;
end;

function TWMNotifyRE_Msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Msg: Cardinal;

  if IsGet then
    Result := TWMNotifyRE_sw(AObj).FValue.Msg
  else
    TWMNotifyRE_sw(AObj).FValue.Msg := Cardinal(AArgs[0]);
end;

function TWMNotifyRE_IDCtrl_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var IDCtrl: Longint;

  if IsGet then
    Result := TWMNotifyRE_sw(AObj).FValue.IDCtrl
  else
    TWMNotifyRE_sw(AObj).FValue.IDCtrl := Longint(AArgs[0]);
end;

function TWMNotifyRE_Result_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Result: Longint;

  if IsGet then
    Result := TWMNotifyRE_sw(AObj).FValue.Result
  else
    TWMNotifyRE_sw(AObj).FValue.Result := Longint(AArgs[0]);
end;

class function TWMNotifyRE_sw.GetTypeName: WideString;
begin
  Result := 'TWMNotifyRE';
end;

function TWMNotifyRE_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TWMNotifyRE_sw.Create;
  TWMNotifyRE_sw(Result).FValue := FValue;
end;

class procedure TWMNotifyRE_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TWMNotifyRE_Copy_si, TWMNotifyRE_sw, 0);
  AData.AddField('Msg', TWMNotifyRE_Msg_si, Cardinal_sw);
  AData.AddField('IDCtrl', TWMNotifyRE_IDCtrl_si, Longint_sw);
  AData.AddField('Result', TWMNotifyRE_Result_si, Longint_sw);

  { Class members }

  AData.AddConstructor('Create', TWMNotifyRE_Create_si, 0);
end;

class function TWMNotifyRE_sw.ToVar(const AValue: TWMNotifyRE): OleVariant;
var
  wrpr: TWMNotifyRE_sw;
begin
  wrpr        := TWMNotifyRE_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TWMNotifyRE_sw.FromVar(const AValue: OleVariant): TWMNotifyRE;
begin
  Result := TWMNotifyRE_sw(ConvFromVar(AValue)).FValue;
end;

{ RichEdit_sw }

function RichEdit_SES_EMULATESYSEDIT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_EMULATESYSEDIT = <value>;

  Result := SES_EMULATESYSEDIT;
end;

function RichEdit_SES_BEEPONMAXTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_BEEPONMAXTEXT = <value>;

  Result := SES_BEEPONMAXTEXT;
end;

function RichEdit_SES_EXTENDBACKCOLOR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_EXTENDBACKCOLOR = <value>;

  Result := SES_EXTENDBACKCOLOR;
end;

function RichEdit_SES_MAPCPS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_MAPCPS = <value>;

  Result := SES_MAPCPS;
end;

function RichEdit_SES_EMULATE10_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_EMULATE10 = <value>;

  Result := SES_EMULATE10;
end;

function RichEdit_SES_USECRLF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_USECRLF = <value>;

  Result := SES_USECRLF;
end;

function RichEdit_SES_NOXLTSYMBOLRANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_NOXLTSYMBOLRANGE = <value>;

  Result := SES_NOXLTSYMBOLRANGE;
end;

function RichEdit_SES_USEAIMM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_USEAIMM = <value>;

  Result := SES_USEAIMM;
end;

function RichEdit_SES_NOIME_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_NOIME = <value>;

  Result := SES_NOIME;
end;

function RichEdit_SES_ALLOWBEEPS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_ALLOWBEEPS = <value>;

  Result := SES_ALLOWBEEPS;
end;

function RichEdit_SES_UPPERCASE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_UPPERCASE = <value>;

  Result := SES_UPPERCASE;
end;

function RichEdit_SES_LOWERCASE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_LOWERCASE = <value>;

  Result := SES_LOWERCASE;
end;

function RichEdit_SES_NOINPUTSEQUENCECHK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_NOINPUTSEQUENCECHK = <value>;

  Result := SES_NOINPUTSEQUENCECHK;
end;

function RichEdit_SES_BIDI_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_BIDI = <value>;

  Result := SES_BIDI;
end;

function RichEdit_SES_SCROLLONKILLFOCUS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_SCROLLONKILLFOCUS = <value>;

  Result := SES_SCROLLONKILLFOCUS;
end;

function RichEdit_SES_XLTCRCRLFTOCR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_XLTCRCRLFTOCR = <value>;

  Result := SES_XLTCRCRLFTOCR;
end;

function RichEdit_SES_DRAFTMODE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_DRAFTMODE = <value>;

  Result := SES_DRAFTMODE;
end;

function RichEdit_SES_USECTF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_USECTF = <value>;

  Result := SES_USECTF;
end;

function RichEdit_SES_HIDEGRIDLINES_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_HIDEGRIDLINES = <value>;

  Result := SES_HIDEGRIDLINES;
end;

function RichEdit_SES_USEATFONT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_USEATFONT = <value>;

  Result := SES_USEATFONT;
end;

function RichEdit_SES_CUSTOMLOOK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_CUSTOMLOOK = <value>;

  Result := SES_CUSTOMLOOK;
end;

function RichEdit_SES_LBSCROLLNOTIFY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_LBSCROLLNOTIFY = <value>;

  Result := SES_LBSCROLLNOTIFY;
end;

function RichEdit_SES_CTFALLOWEMBED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_CTFALLOWEMBED = <value>;

  Result := SES_CTFALLOWEMBED;
end;

function RichEdit_SES_CTFALLOWSMARTTAG_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_CTFALLOWSMARTTAG = <value>;

  Result := SES_CTFALLOWSMARTTAG;
end;

function RichEdit_SES_CTFALLOWPROOFING_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SES_CTFALLOWPROOFING = <value>;

  Result := SES_CTFALLOWPROOFING;
end;

function RichEdit__CHARFORMAT2A_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _CHARFORMAT2A = record;

  Result := TLMDUnitWrapper.TypeToVar(_CHARFORMAT2A_sw);
end;

function RichEdit__CHARFORMAT2W_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _CHARFORMAT2W = record;

  Result := TLMDUnitWrapper.TypeToVar(_CHARFORMAT2W_sw);
end;

function RichEdit__CHARFORMAT2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _CHARFORMAT2 = _CHARFORMAT2W;

  Result := TLMDUnitWrapper.TypeToVar(_CHARFORMAT2_sw);
end;

function RichEdit_GT_SELECTION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GT_SELECTION = <value>;

  Result := GT_SELECTION;
end;

function RichEdit_GT_RAWTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GT_RAWTEXT = <value>;

  Result := GT_RAWTEXT;
end;

function RichEdit_GT_NOHIDDENTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GT_NOHIDDENTEXT = <value>;

  Result := GT_NOHIDDENTEXT;
end;

function RichEdit_TWMNotifyRE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWMNotifyRE = record;

  Result := TLMDUnitWrapper.TypeToVar(TWMNotifyRE_sw);
end;

class function RichEdit_sw.GetUnitName: WideString;
begin
  Result := 'RichEdit';
end;

class procedure RichEdit_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddConstant('SES_EMULATESYSEDIT', RichEdit_SES_EMULATESYSEDIT_si, nil, VarType(RichEdit.SES_EMULATESYSEDIT));
  AData.AddConstant('SES_BEEPONMAXTEXT', RichEdit_SES_BEEPONMAXTEXT_si, nil, VarType(RichEdit.SES_BEEPONMAXTEXT));
  AData.AddConstant('SES_EXTENDBACKCOLOR', RichEdit_SES_EXTENDBACKCOLOR_si, nil, VarType(RichEdit.SES_EXTENDBACKCOLOR));
  AData.AddConstant('SES_MAPCPS', RichEdit_SES_MAPCPS_si, nil, VarType(RichEdit.SES_MAPCPS));
  AData.AddConstant('SES_EMULATE10', RichEdit_SES_EMULATE10_si, nil, VarType(RichEdit.SES_EMULATE10));
  AData.AddConstant('SES_USECRLF', RichEdit_SES_USECRLF_si, nil, VarType(RichEdit.SES_USECRLF));
  AData.AddConstant('SES_NOXLTSYMBOLRANGE', RichEdit_SES_NOXLTSYMBOLRANGE_si, nil, VarType(RichEdit.SES_NOXLTSYMBOLRANGE));
  AData.AddConstant('SES_USEAIMM', RichEdit_SES_USEAIMM_si, nil, VarType(RichEdit.SES_USEAIMM));
  AData.AddConstant('SES_NOIME', RichEdit_SES_NOIME_si, nil, VarType(RichEdit.SES_NOIME));
  AData.AddConstant('SES_ALLOWBEEPS', RichEdit_SES_ALLOWBEEPS_si, nil, VarType(RichEdit.SES_ALLOWBEEPS));
  AData.AddConstant('SES_UPPERCASE', RichEdit_SES_UPPERCASE_si, nil, VarType(RichEdit.SES_UPPERCASE));
  AData.AddConstant('SES_LOWERCASE', RichEdit_SES_LOWERCASE_si, nil, VarType(RichEdit.SES_LOWERCASE));
  AData.AddConstant('SES_NOINPUTSEQUENCECHK', RichEdit_SES_NOINPUTSEQUENCECHK_si, nil, VarType(RichEdit.SES_NOINPUTSEQUENCECHK));
  AData.AddConstant('SES_BIDI', RichEdit_SES_BIDI_si, nil, VarType(RichEdit.SES_BIDI));
  AData.AddConstant('SES_SCROLLONKILLFOCUS', RichEdit_SES_SCROLLONKILLFOCUS_si, nil, VarType(RichEdit.SES_SCROLLONKILLFOCUS));
  AData.AddConstant('SES_XLTCRCRLFTOCR', RichEdit_SES_XLTCRCRLFTOCR_si, nil, VarType(RichEdit.SES_XLTCRCRLFTOCR));
  AData.AddConstant('SES_DRAFTMODE', RichEdit_SES_DRAFTMODE_si, nil, VarType(RichEdit.SES_DRAFTMODE));
  AData.AddConstant('SES_USECTF', RichEdit_SES_USECTF_si, nil, VarType(RichEdit.SES_USECTF));
  AData.AddConstant('SES_HIDEGRIDLINES', RichEdit_SES_HIDEGRIDLINES_si, nil, VarType(RichEdit.SES_HIDEGRIDLINES));
  AData.AddConstant('SES_USEATFONT', RichEdit_SES_USEATFONT_si, nil, VarType(RichEdit.SES_USEATFONT));
  AData.AddConstant('SES_CUSTOMLOOK', RichEdit_SES_CUSTOMLOOK_si, nil, VarType(RichEdit.SES_CUSTOMLOOK));
  AData.AddConstant('SES_LBSCROLLNOTIFY', RichEdit_SES_LBSCROLLNOTIFY_si, nil, VarType(RichEdit.SES_LBSCROLLNOTIFY));
  AData.AddConstant('SES_CTFALLOWEMBED', RichEdit_SES_CTFALLOWEMBED_si, nil, VarType(RichEdit.SES_CTFALLOWEMBED));
  AData.AddConstant('SES_CTFALLOWSMARTTAG', RichEdit_SES_CTFALLOWSMARTTAG_si, nil, VarType(RichEdit.SES_CTFALLOWSMARTTAG));
  AData.AddConstant('SES_CTFALLOWPROOFING', RichEdit_SES_CTFALLOWPROOFING_si, nil, VarType(RichEdit.SES_CTFALLOWPROOFING));
  AData.AddType(_CHARFORMAT2A_sw, RichEdit__CHARFORMAT2A_si);
  AData.AddType(_CHARFORMAT2W_sw, RichEdit__CHARFORMAT2W_si);
  AData.AddType(_CHARFORMAT2_sw, RichEdit__CHARFORMAT2_si);
  AData.AddConstant('GT_SELECTION', RichEdit_GT_SELECTION_si, nil, VarType(RichEdit.GT_SELECTION));
  AData.AddConstant('GT_RAWTEXT', RichEdit_GT_RAWTEXT_si, nil, VarType(RichEdit.GT_RAWTEXT));
  AData.AddConstant('GT_NOHIDDENTEXT', RichEdit_GT_NOHIDDENTEXT_si, nil, VarType(RichEdit.GT_NOHIDDENTEXT));
  AData.AddType(TWMNotifyRE_sw, RichEdit_TWMNotifyRE_si);
end;

class function RichEdit_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(RichEdit_sw);
end;

initialization
  RegisterUnitWrapper(RichEdit_sw);

end.
