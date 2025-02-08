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
  SysUtils, Classes, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Windows, Messages, CommDlg, Windows_LMDSW,
  Messages_LMDSW;


{ Type wrappers }

type

  _OFNOTIFYEXA_sw = class(TLMDRecordWrapper)
  private
    FValue: _OFNOTIFYEXA;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _OFNOTIFYEXA): OleVariant;
    class function FromVar(const AValue: OleVariant): _OFNOTIFYEXA;
  end;

  TOFNotifyExA_sw = _OFNOTIFYEXA_sw;

  TOFNotifyEx_sw = TOFNotifyExA_sw;

  tagFINDREPLACEA_sw = class(TLMDRecordWrapper)
  private
    FValue: tagFINDREPLACEA;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: tagFINDREPLACEA): OleVariant;
    class function FromVar(const AValue: OleVariant): tagFINDREPLACEA;
  end;

  TFindReplaceA_sw = tagFINDREPLACEA_sw;

  TFindReplace_sw = TFindReplaceA_sw;

  tagPSDA_sw = class(TLMDRecordWrapper)
  private
    FValue: tagPSDA;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: tagPSDA): OleVariant;
    class function FromVar(const AValue: OleVariant): tagPSDA;
  end;

  TPageSetupDlgA_sw = tagPSDA_sw;

  TPageSetupDlg_sw = TPageSetupDlgA_sw;


{ Unit wrapper }

type
  CommDlg_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ _OFNOTIFYEXA_sw }

function _OFNOTIFYEXA_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _OFNOTIFYEXA_sw.Create as IDispatch;
end;

function _OFNOTIFYEXA_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _OFNOTIFYEXA;

  // Implicit record copy method.
  Result := _OFNOTIFYEXA_sw.ToVar(_OFNOTIFYEXA(AObj));
end;

class function _OFNOTIFYEXA_sw.GetTypeName: WideString;
begin
  Result := '_OFNOTIFYEXA';
end;

function _OFNOTIFYEXA_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _OFNOTIFYEXA_sw.Create;
  _OFNOTIFYEXA_sw(Result).FValue := FValue;
end;

class procedure _OFNOTIFYEXA_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _OFNOTIFYEXA_Copy_si, _OFNOTIFYEXA_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _OFNOTIFYEXA_Create_si, 0, False);
end;

class function _OFNOTIFYEXA_sw.ToVar(const AValue: _OFNOTIFYEXA): OleVariant;
var
  wrpr: _OFNOTIFYEXA_sw;
begin
  wrpr        := _OFNOTIFYEXA_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _OFNOTIFYEXA_sw.FromVar(const AValue: OleVariant): _OFNOTIFYEXA;
begin
  Result := _OFNOTIFYEXA_sw(ConvFromVar(AValue)).FValue;
end;

{ tagFINDREPLACEA_sw }

function tagFINDREPLACEA_lStructSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lStructSize: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(tagFINDREPLACEA_sw(AObj).FValue.lStructSize)
  else
    tagFINDREPLACEA_sw(AObj).FValue.lStructSize := DWORD_sw.FromVar(AArgs[0]);
end;

function tagFINDREPLACEA_hWndOwner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hWndOwner: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(tagFINDREPLACEA_sw(AObj).FValue.hWndOwner)
  else
    tagFINDREPLACEA_sw(AObj).FValue.hWndOwner := HWND_sw.FromVar(AArgs[0]);
end;

function tagFINDREPLACEA_hInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hInstance: HINST;

  if IsGet then
    Result := HINST_sw.ToVar(tagFINDREPLACEA_sw(AObj).FValue.hInstance)
  else
    tagFINDREPLACEA_sw(AObj).FValue.hInstance := HINST_sw.FromVar(AArgs[0]);
end;

function tagFINDREPLACEA_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(tagFINDREPLACEA_sw(AObj).FValue.Flags)
  else
    tagFINDREPLACEA_sw(AObj).FValue.Flags := DWORD_sw.FromVar(AArgs[0]);
end;

function tagFINDREPLACEA_wFindWhatLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wFindWhatLen: Word;

  if IsGet then
    Result := tagFINDREPLACEA_sw(AObj).FValue.wFindWhatLen
  else
    tagFINDREPLACEA_sw(AObj).FValue.wFindWhatLen := Word(AArgs[0]);
end;

function tagFINDREPLACEA_wReplaceWithLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wReplaceWithLen: Word;

  if IsGet then
    Result := tagFINDREPLACEA_sw(AObj).FValue.wReplaceWithLen
  else
    tagFINDREPLACEA_sw(AObj).FValue.wReplaceWithLen := Word(AArgs[0]);
end;

function tagFINDREPLACEA_lCustData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lCustData: LPARAM;

  if IsGet then
    Result := LPARAM_sw.ToVar(tagFINDREPLACEA_sw(AObj).FValue.lCustData)
  else
    tagFINDREPLACEA_sw(AObj).FValue.lCustData := LPARAM_sw.FromVar(AArgs[0]);
end;

function tagFINDREPLACEA_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := tagFINDREPLACEA_sw.Create as IDispatch;
end;

function tagFINDREPLACEA_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: tagFINDREPLACEA;

  // Implicit record copy method.
  Result := tagFINDREPLACEA_sw.ToVar(tagFINDREPLACEA(AObj));
end;

class function tagFINDREPLACEA_sw.GetTypeName: WideString;
begin
  Result := 'tagFINDREPLACEA';
end;

function tagFINDREPLACEA_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := tagFINDREPLACEA_sw.Create;
  tagFINDREPLACEA_sw(Result).FValue := FValue;
end;

class procedure tagFINDREPLACEA_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('lStructSize', tagFINDREPLACEA_lStructSize_si, DWORD_sw);
  AData.AddField('hWndOwner', tagFINDREPLACEA_hWndOwner_si, HWND_sw);
  AData.AddField('hInstance', tagFINDREPLACEA_hInstance_si, HINST_sw);
  AData.AddField('Flags', tagFINDREPLACEA_Flags_si, DWORD_sw);
  AData.AddField('wFindWhatLen', tagFINDREPLACEA_wFindWhatLen_si, Word_sw);
  AData.AddField('wReplaceWithLen', tagFINDREPLACEA_wReplaceWithLen_si, Word_sw);
  AData.AddField('lCustData', tagFINDREPLACEA_lCustData_si, LPARAM_sw);
  AData.AddFunction('Copy', tagFINDREPLACEA_Copy_si, tagFINDREPLACEA_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', tagFINDREPLACEA_Create_si, 0, False);
end;

class function tagFINDREPLACEA_sw.ToVar(
  const AValue: tagFINDREPLACEA): OleVariant;
var
  wrpr: tagFINDREPLACEA_sw;
begin
  wrpr        := tagFINDREPLACEA_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function tagFINDREPLACEA_sw.FromVar(
  const AValue: OleVariant): tagFINDREPLACEA;
begin
  Result := tagFINDREPLACEA_sw(ConvFromVar(AValue)).FValue;
end;

{ tagPSDA_sw }

function tagPSDA_lStructSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lStructSize: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(tagPSDA_sw(AObj).FValue.lStructSize)
  else
    tagPSDA_sw(AObj).FValue.lStructSize := DWORD_sw.FromVar(AArgs[0]);
end;

function tagPSDA_hwndOwner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hwndOwner: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(tagPSDA_sw(AObj).FValue.hwndOwner)
  else
    tagPSDA_sw(AObj).FValue.hwndOwner := HWND_sw.FromVar(AArgs[0]);
end;

function tagPSDA_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(tagPSDA_sw(AObj).FValue.Flags)
  else
    tagPSDA_sw(AObj).FValue.Flags := DWORD_sw.FromVar(AArgs[0]);
end;

function tagPSDA_ptPaperSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ptPaperSize: TPoint;

  if IsGet then
    Result := TPoint_sw.ToVar(tagPSDA_sw(AObj).FValue.ptPaperSize)
  else
    tagPSDA_sw(AObj).FValue.ptPaperSize := TPoint_sw.FromVar(AArgs[0]);
end;

function tagPSDA_rtMinMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var rtMinMargin: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(tagPSDA_sw(AObj).FValue.rtMinMargin)
  else
    tagPSDA_sw(AObj).FValue.rtMinMargin := TRect_sw.FromVar(AArgs[0]);
end;

function tagPSDA_rtMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var rtMargin: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(tagPSDA_sw(AObj).FValue.rtMargin)
  else
    tagPSDA_sw(AObj).FValue.rtMargin := TRect_sw.FromVar(AArgs[0]);
end;

function tagPSDA_hInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hInstance: HINST;

  if IsGet then
    Result := HINST_sw.ToVar(tagPSDA_sw(AObj).FValue.hInstance)
  else
    tagPSDA_sw(AObj).FValue.hInstance := HINST_sw.FromVar(AArgs[0]);
end;

function tagPSDA_lCustData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lCustData: LPARAM;

  if IsGet then
    Result := LPARAM_sw.ToVar(tagPSDA_sw(AObj).FValue.lCustData)
  else
    tagPSDA_sw(AObj).FValue.lCustData := LPARAM_sw.FromVar(AArgs[0]);
end;

function tagPSDA_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := tagPSDA_sw.Create as IDispatch;
end;

function tagPSDA_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: tagPSDA;

  // Implicit record copy method.
  Result := tagPSDA_sw.ToVar(tagPSDA(AObj));
end;

class function tagPSDA_sw.GetTypeName: WideString;
begin
  Result := 'tagPSDA';
end;

function tagPSDA_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := tagPSDA_sw.Create;
  tagPSDA_sw(Result).FValue := FValue;
end;

class procedure tagPSDA_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('lStructSize', tagPSDA_lStructSize_si, DWORD_sw);
  AData.AddField('hwndOwner', tagPSDA_hwndOwner_si, HWND_sw);
  AData.AddField('Flags', tagPSDA_Flags_si, DWORD_sw);
  AData.AddField('ptPaperSize', tagPSDA_ptPaperSize_si, TPoint_sw);
  AData.AddField('rtMinMargin', tagPSDA_rtMinMargin_si, TRect_sw);
  AData.AddField('rtMargin', tagPSDA_rtMargin_si, TRect_sw);
  AData.AddField('hInstance', tagPSDA_hInstance_si, HINST_sw);
  AData.AddField('lCustData', tagPSDA_lCustData_si, LPARAM_sw);
  AData.AddFunction('Copy', tagPSDA_Copy_si, tagPSDA_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', tagPSDA_Create_si, 0, False);
end;

class function tagPSDA_sw.ToVar(const AValue: tagPSDA): OleVariant;
var
  wrpr: tagPSDA_sw;
begin
  wrpr        := tagPSDA_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function tagPSDA_sw.FromVar(const AValue: OleVariant): tagPSDA;
begin
  Result := tagPSDA_sw(ConvFromVar(AValue)).FValue;
end;

{ CommDlg_sw }

function CommDlg__OFNOTIFYEXA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _OFNOTIFYEXA = record;

  Result := TLMDUnitWrapper.TypeToVar(_OFNOTIFYEXA_sw);
end;

function CommDlg_TOFNotifyExA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOFNotifyExA = _OFNOTIFYEXA;

  Result := TLMDUnitWrapper.TypeToVar(TOFNotifyExA_sw);
end;

function CommDlg_TOFNotifyEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOFNotifyEx = TOFNotifyExA;

  Result := TLMDUnitWrapper.TypeToVar(TOFNotifyEx_sw);
end;

function CommDlg_tagFINDREPLACEA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagFINDREPLACEA = record;

  Result := TLMDUnitWrapper.TypeToVar(tagFINDREPLACEA_sw);
end;

function CommDlg_TFindReplaceA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindReplaceA = tagFINDREPLACEA;

  Result := TLMDUnitWrapper.TypeToVar(TFindReplaceA_sw);
end;

function CommDlg_TFindReplace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindReplace = TFindReplaceA;

  Result := TLMDUnitWrapper.TypeToVar(TFindReplace_sw);
end;

function CommDlg_tagPSDA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagPSDA = record;

  Result := TLMDUnitWrapper.TypeToVar(tagPSDA_sw);
end;

function CommDlg_TPageSetupDlgA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDlgA = tagPSDA;

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDlgA_sw);
end;

function CommDlg_TPageSetupDlg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDlg = TPageSetupDlgA;

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDlg_sw);
end;

class function CommDlg_sw.GetUnitName: WideString;
begin
  Result := 'CommDlg';
end;

class procedure CommDlg_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(_OFNOTIFYEXA_sw, CommDlg__OFNOTIFYEXA_si);
  AData.AddType(TOFNotifyExA_sw, CommDlg_TOFNotifyExA_si);
  AData.AddType(TOFNotifyEx_sw, CommDlg_TOFNotifyEx_si);
  AData.AddType(tagFINDREPLACEA_sw, CommDlg_tagFINDREPLACEA_si);
  AData.AddType(TFindReplaceA_sw, CommDlg_TFindReplaceA_si);
  AData.AddType(TFindReplace_sw, CommDlg_TFindReplace_si);
  AData.AddType(tagPSDA_sw, CommDlg_tagPSDA_si);
  AData.AddType(TPageSetupDlgA_sw, CommDlg_TPageSetupDlgA_si);
  AData.AddType(TPageSetupDlg_sw, CommDlg_TPageSetupDlg_si);
end;

class function CommDlg_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(CommDlg_sw);
end;

initialization
  RegisterUnitWrapper(CommDlg_sw);

end.
