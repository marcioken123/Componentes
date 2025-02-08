unit Winapi.CommDlg_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Winapi.CommDlg' unit.
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
  Winapi.Windows, Winapi.Messages, Winapi.ShlObj, Winapi.CommDlg,
  Winapi.Windows_LMDSW, Winapi.Messages_LMDSW, Winapi.ShlObj_LMDSW;


{ Type wrappers }

type

  _OFNOTIFYEXW_sw = class(TLMDRecordWrapper)
  private
    FValue: _OFNOTIFYEXW;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _OFNOTIFYEXW): OleVariant;
    class function FromVar(const AValue: OleVariant): _OFNOTIFYEXW;
  end;

  TOFNotifyExW_sw = _OFNOTIFYEXW_sw;

  TOFNotifyEx_sw = TOFNotifyExW_sw;

  tagFINDREPLACEW_sw = class(TLMDRecordWrapper)
  private
    FValue: tagFINDREPLACEW;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: tagFINDREPLACEW): OleVariant;
    class function FromVar(const AValue: OleVariant): tagFINDREPLACEW;
  end;

  TFindReplaceW_sw = tagFINDREPLACEW_sw;

  TFindReplace_sw = TFindReplaceW_sw;

  tagPSDW_sw = class(TLMDRecordWrapper)
  private
    FValue: tagPSDW;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: tagPSDW): OleVariant;
    class function FromVar(const AValue: OleVariant): tagPSDW;
  end;

  TPageSetupDlgW_sw = tagPSDW_sw;

  TPageSetupDlg_sw = TPageSetupDlgW_sw;


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

{ _OFNOTIFYEXW_sw }

function _OFNOTIFYEXW_hdr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hdr: TNMHdr;

  if IsGet then
    Result := TNMHdr_sw.ToVar(_OFNOTIFYEXW_sw(AObj).FValue.hdr)
  else
    _OFNOTIFYEXW_sw(AObj).FValue.hdr := TNMHdr_sw.FromVar(AArgs[0]);
end;

function _OFNOTIFYEXW_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _OFNOTIFYEXW_sw.Create as IDispatch;
end;

function _OFNOTIFYEXW_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _OFNOTIFYEXW;

  // Implicit record copy method.
  Result := _OFNOTIFYEXW_sw.ToVar(_OFNOTIFYEXW(AObj));
end;

class function _OFNOTIFYEXW_sw.GetTypeName: WideString;
begin
  Result := '_OFNOTIFYEXW';
end;

function _OFNOTIFYEXW_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _OFNOTIFYEXW_sw.Create;
  _OFNOTIFYEXW_sw(Result).FValue := FValue;
end;

class procedure _OFNOTIFYEXW_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('hdr', _OFNOTIFYEXW_hdr_si, TNMHdr_sw);
  AData.AddFunction('Copy', _OFNOTIFYEXW_Copy_si, _OFNOTIFYEXW_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _OFNOTIFYEXW_Create_si, 0, False);
end;

class function _OFNOTIFYEXW_sw.ToVar(const AValue: _OFNOTIFYEXW): OleVariant;
var
  wrpr: _OFNOTIFYEXW_sw;
begin
  wrpr        := _OFNOTIFYEXW_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _OFNOTIFYEXW_sw.FromVar(const AValue: OleVariant): _OFNOTIFYEXW;
begin
  Result := _OFNOTIFYEXW_sw(ConvFromVar(AValue)).FValue;
end;

{ tagFINDREPLACEW_sw }

function tagFINDREPLACEW_lStructSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lStructSize: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(tagFINDREPLACEW_sw(AObj).FValue.lStructSize)
  else
    tagFINDREPLACEW_sw(AObj).FValue.lStructSize := DWORD_sw.FromVar(AArgs[0]);
end;

function tagFINDREPLACEW_hWndOwner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hWndOwner: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(tagFINDREPLACEW_sw(AObj).FValue.hWndOwner)
  else
    tagFINDREPLACEW_sw(AObj).FValue.hWndOwner := HWND_sw.FromVar(AArgs[0]);
end;

function tagFINDREPLACEW_hInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hInstance: HINST;

  if IsGet then
    Result := HINST_sw.ToVar(tagFINDREPLACEW_sw(AObj).FValue.hInstance)
  else
    tagFINDREPLACEW_sw(AObj).FValue.hInstance := HINST_sw.FromVar(AArgs[0]);
end;

function tagFINDREPLACEW_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(tagFINDREPLACEW_sw(AObj).FValue.Flags)
  else
    tagFINDREPLACEW_sw(AObj).FValue.Flags := DWORD_sw.FromVar(AArgs[0]);
end;

function tagFINDREPLACEW_wFindWhatLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wFindWhatLen: Word;

  if IsGet then
    Result := tagFINDREPLACEW_sw(AObj).FValue.wFindWhatLen
  else
    tagFINDREPLACEW_sw(AObj).FValue.wFindWhatLen := Word(AArgs[0]);
end;

function tagFINDREPLACEW_wReplaceWithLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wReplaceWithLen: Word;

  if IsGet then
    Result := tagFINDREPLACEW_sw(AObj).FValue.wReplaceWithLen
  else
    tagFINDREPLACEW_sw(AObj).FValue.wReplaceWithLen := Word(AArgs[0]);
end;

function tagFINDREPLACEW_lCustData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lCustData: LPARAM;

  if IsGet then
    Result := LPARAM_sw.ToVar(tagFINDREPLACEW_sw(AObj).FValue.lCustData)
  else
    tagFINDREPLACEW_sw(AObj).FValue.lCustData := LPARAM_sw.FromVar(AArgs[0]);
end;

function tagFINDREPLACEW_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := tagFINDREPLACEW_sw.Create as IDispatch;
end;

function tagFINDREPLACEW_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: tagFINDREPLACEW;

  // Implicit record copy method.
  Result := tagFINDREPLACEW_sw.ToVar(tagFINDREPLACEW(AObj));
end;

class function tagFINDREPLACEW_sw.GetTypeName: WideString;
begin
  Result := 'tagFINDREPLACEW';
end;

function tagFINDREPLACEW_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := tagFINDREPLACEW_sw.Create;
  tagFINDREPLACEW_sw(Result).FValue := FValue;
end;

class procedure tagFINDREPLACEW_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('lStructSize', tagFINDREPLACEW_lStructSize_si, DWORD_sw);
  AData.AddField('hWndOwner', tagFINDREPLACEW_hWndOwner_si, HWND_sw);
  AData.AddField('hInstance', tagFINDREPLACEW_hInstance_si, HINST_sw);
  AData.AddField('Flags', tagFINDREPLACEW_Flags_si, DWORD_sw);
  AData.AddField('wFindWhatLen', tagFINDREPLACEW_wFindWhatLen_si, Word_sw);
  AData.AddField('wReplaceWithLen', tagFINDREPLACEW_wReplaceWithLen_si, Word_sw);
  AData.AddField('lCustData', tagFINDREPLACEW_lCustData_si, LPARAM_sw);
  AData.AddFunction('Copy', tagFINDREPLACEW_Copy_si, tagFINDREPLACEW_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', tagFINDREPLACEW_Create_si, 0, False);
end;

class function tagFINDREPLACEW_sw.ToVar(
  const AValue: tagFINDREPLACEW): OleVariant;
var
  wrpr: tagFINDREPLACEW_sw;
begin
  wrpr        := tagFINDREPLACEW_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function tagFINDREPLACEW_sw.FromVar(
  const AValue: OleVariant): tagFINDREPLACEW;
begin
  Result := tagFINDREPLACEW_sw(ConvFromVar(AValue)).FValue;
end;

{ tagPSDW_sw }

function tagPSDW_lStructSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lStructSize: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(tagPSDW_sw(AObj).FValue.lStructSize)
  else
    tagPSDW_sw(AObj).FValue.lStructSize := DWORD_sw.FromVar(AArgs[0]);
end;

function tagPSDW_hwndOwner_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hwndOwner: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(tagPSDW_sw(AObj).FValue.hwndOwner)
  else
    tagPSDW_sw(AObj).FValue.hwndOwner := HWND_sw.FromVar(AArgs[0]);
end;

function tagPSDW_hDevMode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hDevMode: HGLOBAL;

  if IsGet then
    Result := HGLOBAL_sw.ToVar(tagPSDW_sw(AObj).FValue.hDevMode)
  else
    tagPSDW_sw(AObj).FValue.hDevMode := HGLOBAL_sw.FromVar(AArgs[0]);
end;

function tagPSDW_hDevNames_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hDevNames: HGLOBAL;

  if IsGet then
    Result := HGLOBAL_sw.ToVar(tagPSDW_sw(AObj).FValue.hDevNames)
  else
    tagPSDW_sw(AObj).FValue.hDevNames := HGLOBAL_sw.FromVar(AArgs[0]);
end;

function tagPSDW_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(tagPSDW_sw(AObj).FValue.Flags)
  else
    tagPSDW_sw(AObj).FValue.Flags := DWORD_sw.FromVar(AArgs[0]);
end;

function tagPSDW_ptPaperSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ptPaperSize: TPoint;

  if IsGet then
    Result := TPoint_sw.ToVar(tagPSDW_sw(AObj).FValue.ptPaperSize)
  else
    tagPSDW_sw(AObj).FValue.ptPaperSize := TPoint_sw.FromVar(AArgs[0]);
end;

function tagPSDW_rtMinMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var rtMinMargin: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(tagPSDW_sw(AObj).FValue.rtMinMargin)
  else
    tagPSDW_sw(AObj).FValue.rtMinMargin := TRect_sw.FromVar(AArgs[0]);
end;

function tagPSDW_rtMargin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var rtMargin: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(tagPSDW_sw(AObj).FValue.rtMargin)
  else
    tagPSDW_sw(AObj).FValue.rtMargin := TRect_sw.FromVar(AArgs[0]);
end;

function tagPSDW_hInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hInstance: HINST;

  if IsGet then
    Result := HINST_sw.ToVar(tagPSDW_sw(AObj).FValue.hInstance)
  else
    tagPSDW_sw(AObj).FValue.hInstance := HINST_sw.FromVar(AArgs[0]);
end;

function tagPSDW_lCustData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lCustData: LPARAM;

  if IsGet then
    Result := LPARAM_sw.ToVar(tagPSDW_sw(AObj).FValue.lCustData)
  else
    tagPSDW_sw(AObj).FValue.lCustData := LPARAM_sw.FromVar(AArgs[0]);
end;

function tagPSDW_hPageSetupTemplate_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hPageSetupTemplate: HGLOBAL;

  if IsGet then
    Result := HGLOBAL_sw.ToVar(tagPSDW_sw(AObj).FValue.hPageSetupTemplate)
  else
    tagPSDW_sw(AObj).FValue.hPageSetupTemplate := HGLOBAL_sw.FromVar(AArgs[0]);
end;

function tagPSDW_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := tagPSDW_sw.Create as IDispatch;
end;

function tagPSDW_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: tagPSDW;

  // Implicit record copy method.
  Result := tagPSDW_sw.ToVar(tagPSDW(AObj));
end;

class function tagPSDW_sw.GetTypeName: WideString;
begin
  Result := 'tagPSDW';
end;

function tagPSDW_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := tagPSDW_sw.Create;
  tagPSDW_sw(Result).FValue := FValue;
end;

class procedure tagPSDW_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('lStructSize', tagPSDW_lStructSize_si, DWORD_sw);
  AData.AddField('hwndOwner', tagPSDW_hwndOwner_si, HWND_sw);
  AData.AddField('hDevMode', tagPSDW_hDevMode_si, HGLOBAL_sw);
  AData.AddField('hDevNames', tagPSDW_hDevNames_si, HGLOBAL_sw);
  AData.AddField('Flags', tagPSDW_Flags_si, DWORD_sw);
  AData.AddField('ptPaperSize', tagPSDW_ptPaperSize_si, TPoint_sw);
  AData.AddField('rtMinMargin', tagPSDW_rtMinMargin_si, TRect_sw);
  AData.AddField('rtMargin', tagPSDW_rtMargin_si, TRect_sw);
  AData.AddField('hInstance', tagPSDW_hInstance_si, HINST_sw);
  AData.AddField('lCustData', tagPSDW_lCustData_si, LPARAM_sw);
  AData.AddField('hPageSetupTemplate', tagPSDW_hPageSetupTemplate_si, HGLOBAL_sw);
  AData.AddFunction('Copy', tagPSDW_Copy_si, tagPSDW_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', tagPSDW_Create_si, 0, False);
end;

class function tagPSDW_sw.ToVar(const AValue: tagPSDW): OleVariant;
var
  wrpr: tagPSDW_sw;
begin
  wrpr        := tagPSDW_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function tagPSDW_sw.FromVar(const AValue: OleVariant): tagPSDW;
begin
  Result := tagPSDW_sw(ConvFromVar(AValue)).FValue;
end;

{ CommDlg_sw }

function CommDlg__OFNOTIFYEXW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _OFNOTIFYEXW = record;

  Result := TLMDUnitWrapper.TypeToVar(_OFNOTIFYEXW_sw);
end;

function CommDlg_TOFNotifyExW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOFNotifyExW = _OFNOTIFYEXW;

  Result := TLMDUnitWrapper.TypeToVar(TOFNotifyExW_sw);
end;

function CommDlg_TOFNotifyEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOFNotifyEx = TOFNotifyExW;

  Result := TLMDUnitWrapper.TypeToVar(TOFNotifyEx_sw);
end;

function CommDlg_tagFINDREPLACEW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagFINDREPLACEW = record;

  Result := TLMDUnitWrapper.TypeToVar(tagFINDREPLACEW_sw);
end;

function CommDlg_TFindReplaceW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindReplaceW = tagFINDREPLACEW;

  Result := TLMDUnitWrapper.TypeToVar(TFindReplaceW_sw);
end;

function CommDlg_TFindReplace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindReplace = TFindReplaceW;

  Result := TLMDUnitWrapper.TypeToVar(TFindReplace_sw);
end;

function CommDlg_tagPSDW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagPSDW = record;

  Result := TLMDUnitWrapper.TypeToVar(tagPSDW_sw);
end;

function CommDlg_TPageSetupDlgW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDlgW = tagPSDW;

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDlgW_sw);
end;

function CommDlg_TPageSetupDlg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPageSetupDlg = TPageSetupDlgW;

  Result := TLMDUnitWrapper.TypeToVar(TPageSetupDlg_sw);
end;

class function CommDlg_sw.GetUnitName: WideString;
begin
  Result := 'CommDlg';
end;

class procedure CommDlg_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(_OFNOTIFYEXW_sw, CommDlg__OFNOTIFYEXW_si);
  AData.AddType(TOFNotifyExW_sw, CommDlg_TOFNotifyExW_si);
  AData.AddType(TOFNotifyEx_sw, CommDlg_TOFNotifyEx_si);
  AData.AddType(tagFINDREPLACEW_sw, CommDlg_tagFINDREPLACEW_si);
  AData.AddType(TFindReplaceW_sw, CommDlg_TFindReplaceW_si);
  AData.AddType(TFindReplace_sw, CommDlg_TFindReplace_si);
  AData.AddType(tagPSDW_sw, CommDlg_tagPSDW_si);
  AData.AddType(TPageSetupDlgW_sw, CommDlg_TPageSetupDlgW_si);
  AData.AddType(TPageSetupDlg_sw, CommDlg_TPageSetupDlg_si);
end;

class function CommDlg_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(CommDlg_sw);
end;

initialization
  RegisterUnitWrapper(CommDlg_sw);

end.
