unit Windows_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Windows' unit.
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
  LMDSctWrappers, LMDSctSysWrappers, Types, Windows, Types_LMDSW;


{ Type wrappers }

type

  WCHAR_sw = WideChar_sw;

  DWORD_sw = Types_LMDSW.DWORD_sw;

  BOOL_sw = LongBool_sw;

  UCHAR_sw = Byte_sw;

  SHORT_sw = Smallint_sw;

  UINT_sw = LongWord_sw;

  ULONG_sw = Cardinal_sw;

  LCID_sw = DWORD_sw;

  LANGID_sw = Word_sw;

  THandle_sw = LMDSctSysWrappers.THandle_sw;

  INT_PTR_sw = Integer_sw;

  LONG_PTR_sw = Integer_sw;

  UINT_PTR_sw = Cardinal_sw;

  ULONG_PTR_sw = Cardinal_sw;

  DWORD_PTR_sw = ULONG_PTR_sw;

  LONGLONG_sw = Int64_sw;

  WPARAM_sw = Longint_sw;

  LPARAM_sw = Longint_sw;

  LRESULT_sw = Longint_sw;

  LOWORD_sw = Word_sw;

  LOBYTE_sw = Byte_sw;

  HWND_sw = LongWord_sw;

  HHOOK_sw = LongWord_sw;

  ATOM_sw = Word_sw;

  TAtom_sw = Word_sw;

  HGLOBAL_sw = THandle_sw;

  HLOCAL_sw = THandle_sw;

  HGDIOBJ_sw = LongWord_sw;

  HACCEL_sw = LongWord_sw;

  HBITMAP_sw = LongWord_sw;

  HBRUSH_sw = LongWord_sw;

  HCOLORSPACE_sw = LongWord_sw;

  HDC_sw = LongWord_sw;

  HGLRC_sw = LongWord_sw;

  HDESK_sw = LongWord_sw;

  HENHMETAFILE_sw = LongWord_sw;

  HFONT_sw = LongWord_sw;

  HICON_sw = LongWord_sw;

  HMENU_sw = LongWord_sw;

  HMETAFILE_sw = LongWord_sw;

  HINST_sw = LMDSctSysWrappers.HINST_sw;

  HMODULE_sw = LMDSctSysWrappers.HMODULE_sw;

  HPALETTE_sw = LongWord_sw;

  HPEN_sw = LongWord_sw;

  HRGN_sw = LongWord_sw;

  HSTR_sw = LongWord_sw;

  HTASK_sw = LongWord_sw;

  HWINSTA_sw = LongWord_sw;

  HKL_sw = LongWord_sw;

  HFILE_sw = LongWord_sw;

  HCURSOR_sw = HICON_sw;

  COLORREF_sw = DWORD_sw;

  TColorRef_sw = DWORD_sw;

  TPoint_sw = Types_LMDSW.TPoint_sw;

  tagPoint_sw = Types_LMDSW.tagPoint_sw;

  TRect_sw = Types_LMDSW.TRect_sw;

  _POINTL_sw = class(TLMDRecordWrapper)
  private
    FValue: _POINTL;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _POINTL): OleVariant;
    class function FromVar(const AValue: OleVariant): _POINTL;
  end;

  TPointL_sw = _POINTL_sw;

  TSize_sw = Types_LMDSW.TSize_sw;

  SIZE_sw = Types_LMDSW.SIZE_sw;

  TSmallPoint_sw = Types_LMDSW.TSmallPoint_sw;

  _STARTUPINFOW_sw = class(TLMDRecordWrapper)
  private
    FValue: _STARTUPINFOW;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _STARTUPINFOW): OleVariant;
    class function FromVar(const AValue: OleVariant): _STARTUPINFOW;
  end;

  TStartupInfoW_sw = _STARTUPINFOW_sw;

  STARTUPINFOW_sw = _STARTUPINFOW_sw;

  tagMSG_sw = class(TLMDRecordWrapper)
  private
    FValue: tagMSG;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: tagMSG): OleVariant;
    class function FromVar(const AValue: OleVariant): tagMSG;
  end;

  TMsg_sw = tagMSG_sw;

  _HHN_NOTIFY_sw = class(TLMDRecordWrapper)
  private
    FValue: _HHN_NOTIFY;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _HHN_NOTIFY): OleVariant;
    class function FromVar(const AValue: OleVariant): _HHN_NOTIFY;
  end;

  THHN_Notify_sw = _HHN_NOTIFY_sw;

  HHN_NOTIFY_sw = _HHN_NOTIFY_sw;

  _HH_POPUP_sw = class(TLMDRecordWrapper)
  private
    FValue: _HH_POPUP;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _HH_POPUP): OleVariant;
    class function FromVar(const AValue: OleVariant): _HH_POPUP;
  end;

  THH_Popup_sw = _HH_POPUP_sw;

  HH_POPUP_sw = _HH_POPUP_sw;

  _HH_AKLINK_sw = class(TLMDRecordWrapper)
  private
    FValue: _HH_AKLINK;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _HH_AKLINK): OleVariant;
    class function FromVar(const AValue: OleVariant): _HH_AKLINK;
  end;

  THH_AKLink_sw = _HH_AKLINK_sw;

  HH_AKLINK_sw = _HH_AKLINK_sw;

  _HH_ENUM_IT_sw = class(TLMDRecordWrapper)
  private
    FValue: _HH_ENUM_IT;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _HH_ENUM_IT): OleVariant;
    class function FromVar(const AValue: OleVariant): _HH_ENUM_IT;
  end;

  THH_Enum_it_sw = _HH_ENUM_IT_sw;

  HH_ENUM_IT_sw = _HH_ENUM_IT_sw;

  _HH_ENUM_CAT_sw = class(TLMDRecordWrapper)
  private
    FValue: _HH_ENUM_CAT;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _HH_ENUM_CAT): OleVariant;
    class function FromVar(const AValue: OleVariant): _HH_ENUM_CAT;
  end;

  THH_Enum_Cat_sw = _HH_ENUM_CAT_sw;

  HH_ENUM_CAT_sw = _HH_ENUM_CAT_sw;

  _HH_SET_INFOTYPE_sw = class(TLMDRecordWrapper)
  private
    FValue: _HH_SET_INFOTYPE;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _HH_SET_INFOTYPE): OleVariant;
    class function FromVar(const AValue: OleVariant): _HH_SET_INFOTYPE;
  end;

  THH_Set_Infotype_sw = _HH_SET_INFOTYPE_sw;

  HH_SET_INFOTYPE_sw = _HH_SET_INFOTYPE_sw;

  THH_Infotype_sw = Dword_sw;

  HH_INFOTYPE_sw = THH_Infotype_sw;

  _HH_FTS_QUERY_sw = class(TLMDRecordWrapper)
  private
    FValue: _HH_FTS_QUERY;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _HH_FTS_QUERY): OleVariant;
    class function FromVar(const AValue: OleVariant): _HH_FTS_QUERY;
  end;

  THH_Fts_Query_sw = _HH_FTS_QUERY_sw;

  HH_FTS_QUERY_sw = _HH_FTS_QUERY_sw;

  _HH_WINTYPE_sw = class(TLMDRecordWrapper)
  private
    FValue: _HH_WINTYPE;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _HH_WINTYPE): OleVariant;
    class function FromVar(const AValue: OleVariant): _HH_WINTYPE;
  end;

  THH_WINTYPE_sw = _HH_WINTYPE_sw;

  HH_WINTYPE_sw = _HH_WINTYPE_sw;

  _HH_NTRACK_sw = class(TLMDRecordWrapper)
  private
    FValue: _HH_NTRACK;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _HH_NTRACK): OleVariant;
    class function FromVar(const AValue: OleVariant): _HH_NTRACK;
  end;

  THH_NTrack_sw = _HH_NTRACK_sw;

  HH_NTRACK_sw = _HH_NTRACK_sw;


{ Unit wrapper }

type
  Windows_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ _POINTL_sw }

function _POINTL_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _POINTL_sw.ToVar(_POINTL(AObj));
end;

function _POINTL_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _POINTL_sw.Create as IDispatch;
end;

function _POINTL_x_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var x: Longint;

  if IsGet then
    Result := _POINTL_sw(AObj).FValue.x
  else
    _POINTL_sw(AObj).FValue.x := Longint(AArgs[0]);
end;

function _POINTL_y_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var y: Longint;

  if IsGet then
    Result := _POINTL_sw(AObj).FValue.y
  else
    _POINTL_sw(AObj).FValue.y := Longint(AArgs[0]);
end;

class function _POINTL_sw.GetTypeName: WideString;
begin
  Result := '_POINTL';
end;

function _POINTL_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _POINTL_sw.Create;
  _POINTL_sw(Result).FValue := FValue;
end;

class procedure _POINTL_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _POINTL_Copy_si, _POINTL_sw, 0);
  AData.AddField('x', _POINTL_x_si, Longint_sw);
  AData.AddField('y', _POINTL_y_si, Longint_sw);

  { Class members }

  AData.AddConstructor('Create', _POINTL_Create_si, 0);
end;

class function _POINTL_sw.ToVar(const AValue: _POINTL): OleVariant;
var
  wrpr: _POINTL_sw;
begin
  wrpr        := _POINTL_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _POINTL_sw.FromVar(const AValue: OleVariant): _POINTL;
begin
  Result := _POINTL_sw(ConvFromVar(AValue)).FValue;
end;

{ _STARTUPINFOW_sw }

function _STARTUPINFOW_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _STARTUPINFOW_sw.ToVar(_STARTUPINFOW(AObj));
end;

function _STARTUPINFOW_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _STARTUPINFOW_sw.Create as IDispatch;
end;

function _STARTUPINFOW_cb_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cb: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.cb)
  else
    _STARTUPINFOW_sw(AObj).FValue.cb := DWORD_sw.FromVar(AArgs[0]);
end;

function _STARTUPINFOW_dwX_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwX: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.dwX)
  else
    _STARTUPINFOW_sw(AObj).FValue.dwX := DWORD_sw.FromVar(AArgs[0]);
end;

function _STARTUPINFOW_dwY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwY: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.dwY)
  else
    _STARTUPINFOW_sw(AObj).FValue.dwY := DWORD_sw.FromVar(AArgs[0]);
end;

function _STARTUPINFOW_dwXSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwXSize: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.dwXSize)
  else
    _STARTUPINFOW_sw(AObj).FValue.dwXSize := DWORD_sw.FromVar(AArgs[0]);
end;

function _STARTUPINFOW_dwYSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwYSize: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.dwYSize)
  else
    _STARTUPINFOW_sw(AObj).FValue.dwYSize := DWORD_sw.FromVar(AArgs[0]);
end;

function _STARTUPINFOW_dwXCountChars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwXCountChars: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.dwXCountChars)
  else
    _STARTUPINFOW_sw(AObj).FValue.dwXCountChars := DWORD_sw.FromVar(AArgs[0]);
end;

function _STARTUPINFOW_dwYCountChars_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwYCountChars: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.dwYCountChars)
  else
    _STARTUPINFOW_sw(AObj).FValue.dwYCountChars := DWORD_sw.FromVar(AArgs[0]);
end;

function _STARTUPINFOW_dwFillAttribute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwFillAttribute: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.dwFillAttribute)
  else
    _STARTUPINFOW_sw(AObj).FValue.dwFillAttribute := DWORD_sw.FromVar(AArgs[0]);
end;

function _STARTUPINFOW_dwFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwFlags: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.dwFlags)
  else
    _STARTUPINFOW_sw(AObj).FValue.dwFlags := DWORD_sw.FromVar(AArgs[0]);
end;

function _STARTUPINFOW_wShowWindow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wShowWindow: Word;

  if IsGet then
    Result := _STARTUPINFOW_sw(AObj).FValue.wShowWindow
  else
    _STARTUPINFOW_sw(AObj).FValue.wShowWindow := Word(AArgs[0]);
end;

function _STARTUPINFOW_cbReserved2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbReserved2: Word;

  if IsGet then
    Result := _STARTUPINFOW_sw(AObj).FValue.cbReserved2
  else
    _STARTUPINFOW_sw(AObj).FValue.cbReserved2 := Word(AArgs[0]);
end;

function _STARTUPINFOW_hStdInput_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hStdInput: THandle;

  if IsGet then
    Result := THandle_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.hStdInput)
  else
    _STARTUPINFOW_sw(AObj).FValue.hStdInput := THandle_sw.FromVar(AArgs[0]);
end;

function _STARTUPINFOW_hStdOutput_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hStdOutput: THandle;

  if IsGet then
    Result := THandle_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.hStdOutput)
  else
    _STARTUPINFOW_sw(AObj).FValue.hStdOutput := THandle_sw.FromVar(AArgs[0]);
end;

function _STARTUPINFOW_hStdError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hStdError: THandle;

  if IsGet then
    Result := THandle_sw.ToVar(_STARTUPINFOW_sw(AObj).FValue.hStdError)
  else
    _STARTUPINFOW_sw(AObj).FValue.hStdError := THandle_sw.FromVar(AArgs[0]);
end;

class function _STARTUPINFOW_sw.GetTypeName: WideString;
begin
  Result := '_STARTUPINFOW';
end;

function _STARTUPINFOW_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _STARTUPINFOW_sw.Create;
  _STARTUPINFOW_sw(Result).FValue := FValue;
end;

class procedure _STARTUPINFOW_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _STARTUPINFOW_Copy_si, _STARTUPINFOW_sw, 0);
  AData.AddField('cb', _STARTUPINFOW_cb_si, DWORD_sw);
  AData.AddField('dwX', _STARTUPINFOW_dwX_si, DWORD_sw);
  AData.AddField('dwY', _STARTUPINFOW_dwY_si, DWORD_sw);
  AData.AddField('dwXSize', _STARTUPINFOW_dwXSize_si, DWORD_sw);
  AData.AddField('dwYSize', _STARTUPINFOW_dwYSize_si, DWORD_sw);
  AData.AddField('dwXCountChars', _STARTUPINFOW_dwXCountChars_si, DWORD_sw);
  AData.AddField('dwYCountChars', _STARTUPINFOW_dwYCountChars_si, DWORD_sw);
  AData.AddField('dwFillAttribute', _STARTUPINFOW_dwFillAttribute_si, DWORD_sw);
  AData.AddField('dwFlags', _STARTUPINFOW_dwFlags_si, DWORD_sw);
  AData.AddField('wShowWindow', _STARTUPINFOW_wShowWindow_si, Word_sw);
  AData.AddField('cbReserved2', _STARTUPINFOW_cbReserved2_si, Word_sw);
  AData.AddField('hStdInput', _STARTUPINFOW_hStdInput_si, THandle_sw);
  AData.AddField('hStdOutput', _STARTUPINFOW_hStdOutput_si, THandle_sw);
  AData.AddField('hStdError', _STARTUPINFOW_hStdError_si, THandle_sw);

  { Class members }

  AData.AddConstructor('Create', _STARTUPINFOW_Create_si, 0);
end;

class function _STARTUPINFOW_sw.ToVar(const AValue: _STARTUPINFOW): OleVariant;
var
  wrpr: _STARTUPINFOW_sw;
begin
  wrpr        := _STARTUPINFOW_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _STARTUPINFOW_sw.FromVar(
  const AValue: OleVariant): _STARTUPINFOW;
begin
  Result := _STARTUPINFOW_sw(ConvFromVar(AValue)).FValue;
end;

{ tagMSG_sw }

function tagMSG_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  Result := tagMSG_sw.ToVar(tagMSG(AObj));
end;

function tagMSG_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := tagMSG_sw.Create as IDispatch;
end;

function tagMSG_hwnd_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var hwnd: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(tagMSG_sw(AObj).FValue.hwnd)
  else
    tagMSG_sw(AObj).FValue.hwnd := HWND_sw.FromVar(AArgs[0]);
end;

function tagMSG_message_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var message: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(tagMSG_sw(AObj).FValue.message)
  else
    tagMSG_sw(AObj).FValue.message := UINT_sw.FromVar(AArgs[0]);
end;

function tagMSG_wParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wParam: WPARAM;

  if IsGet then
    Result := WPARAM_sw.ToVar(tagMSG_sw(AObj).FValue.wParam)
  else
    tagMSG_sw(AObj).FValue.wParam := WPARAM_sw.FromVar(AArgs[0]);
end;

function tagMSG_lParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lParam: LPARAM;

  if IsGet then
    Result := LPARAM_sw.ToVar(tagMSG_sw(AObj).FValue.lParam)
  else
    tagMSG_sw(AObj).FValue.lParam := LPARAM_sw.FromVar(AArgs[0]);
end;

class function tagMSG_sw.GetTypeName: WideString;
begin
  Result := 'tagMSG';
end;

function tagMSG_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := tagMSG_sw.Create;
  tagMSG_sw(Result).FValue := FValue;
end;

class procedure tagMSG_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', tagMSG_Copy_si, tagMSG_sw, 0);
  AData.AddField('hwnd', tagMSG_hwnd_si, HWND_sw);
  AData.AddField('message', tagMSG_message_si, UINT_sw);
  AData.AddField('wParam', tagMSG_wParam_si, WPARAM_sw);
  AData.AddField('lParam', tagMSG_lParam_si, LPARAM_sw);

  { Class members }

  AData.AddConstructor('Create', tagMSG_Create_si, 0);
end;

class function tagMSG_sw.ToVar(const AValue: tagMSG): OleVariant;
var
  wrpr: tagMSG_sw;
begin
  wrpr        := tagMSG_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function tagMSG_sw.FromVar(const AValue: OleVariant): tagMSG;
begin
  Result := tagMSG_sw(ConvFromVar(AValue)).FValue;
end;

{ _HHN_NOTIFY_sw }

function _HHN_NOTIFY_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HHN_NOTIFY_sw.ToVar(_HHN_NOTIFY(AObj));
end;

function _HHN_NOTIFY_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HHN_NOTIFY_sw.Create as IDispatch;
end;

class function _HHN_NOTIFY_sw.GetTypeName: WideString;
begin
  Result := '_HHN_NOTIFY';
end;

function _HHN_NOTIFY_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _HHN_NOTIFY_sw.Create;
  _HHN_NOTIFY_sw(Result).FValue := FValue;
end;

class procedure _HHN_NOTIFY_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _HHN_NOTIFY_Copy_si, _HHN_NOTIFY_sw, 0);

  { Class members }

  AData.AddConstructor('Create', _HHN_NOTIFY_Create_si, 0);
end;

class function _HHN_NOTIFY_sw.ToVar(const AValue: _HHN_NOTIFY): OleVariant;
var
  wrpr: _HHN_NOTIFY_sw;
begin
  wrpr        := _HHN_NOTIFY_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _HHN_NOTIFY_sw.FromVar(const AValue: OleVariant): _HHN_NOTIFY;
begin
  Result := _HHN_NOTIFY_sw(ConvFromVar(AValue)).FValue;
end;

{ _HH_POPUP_sw }

function _HH_POPUP_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_POPUP_sw.ToVar(_HH_POPUP(AObj));
end;

function _HH_POPUP_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_POPUP_sw.Create as IDispatch;
end;

function _HH_POPUP_cbStruct_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbStruct: Integer;

  if IsGet then
    Result := _HH_POPUP_sw(AObj).FValue.cbStruct
  else
    _HH_POPUP_sw(AObj).FValue.cbStruct := Integer(AArgs[0]);
end;

function _HH_POPUP_hInst_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hInst: HINST;

  if IsGet then
    Result := HINST_sw.ToVar(_HH_POPUP_sw(AObj).FValue.hInst)
  else
    _HH_POPUP_sw(AObj).FValue.hInst := HINST_sw.FromVar(AArgs[0]);
end;

function _HH_POPUP_idString_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var idString: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(_HH_POPUP_sw(AObj).FValue.idString)
  else
    _HH_POPUP_sw(AObj).FValue.idString := UINT_sw.FromVar(AArgs[0]);
end;

function _HH_POPUP_pt_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var pt: TPoint;

  if IsGet then
    Result := TPoint_sw.ToVar(_HH_POPUP_sw(AObj).FValue.pt)
  else
    _HH_POPUP_sw(AObj).FValue.pt := TPoint_sw.FromVar(AArgs[0]);
end;

function _HH_POPUP_clrForeground_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var clrForeground: TColorRef;

  if IsGet then
    Result := TColorRef_sw.ToVar(_HH_POPUP_sw(AObj).FValue.clrForeground)
  else
    _HH_POPUP_sw(AObj).FValue.clrForeground := TColorRef_sw.FromVar(AArgs[0]);
end;

function _HH_POPUP_clrBackground_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var clrBackground: TColorRef;

  if IsGet then
    Result := TColorRef_sw.ToVar(_HH_POPUP_sw(AObj).FValue.clrBackground)
  else
    _HH_POPUP_sw(AObj).FValue.clrBackground := TColorRef_sw.FromVar(AArgs[0]);
end;

function _HH_POPUP_rcMargins_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var rcMargins: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(_HH_POPUP_sw(AObj).FValue.rcMargins)
  else
    _HH_POPUP_sw(AObj).FValue.rcMargins := TRect_sw.FromVar(AArgs[0]);
end;

class function _HH_POPUP_sw.GetTypeName: WideString;
begin
  Result := '_HH_POPUP';
end;

function _HH_POPUP_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _HH_POPUP_sw.Create;
  _HH_POPUP_sw(Result).FValue := FValue;
end;

class procedure _HH_POPUP_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _HH_POPUP_Copy_si, _HH_POPUP_sw, 0);
  AData.AddField('cbStruct', _HH_POPUP_cbStruct_si, Integer_sw);
  AData.AddField('hInst', _HH_POPUP_hInst_si, HINST_sw);
  AData.AddField('idString', _HH_POPUP_idString_si, UINT_sw);
  AData.AddField('pt', _HH_POPUP_pt_si, TPoint_sw);
  AData.AddField('clrForeground', _HH_POPUP_clrForeground_si, TColorRef_sw);
  AData.AddField('clrBackground', _HH_POPUP_clrBackground_si, TColorRef_sw);
  AData.AddField('rcMargins', _HH_POPUP_rcMargins_si, TRect_sw);

  { Class members }

  AData.AddConstructor('Create', _HH_POPUP_Create_si, 0);
end;

class function _HH_POPUP_sw.ToVar(const AValue: _HH_POPUP): OleVariant;
var
  wrpr: _HH_POPUP_sw;
begin
  wrpr        := _HH_POPUP_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _HH_POPUP_sw.FromVar(const AValue: OleVariant): _HH_POPUP;
begin
  Result := _HH_POPUP_sw(ConvFromVar(AValue)).FValue;
end;

{ _HH_AKLINK_sw }

function _HH_AKLINK_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_AKLINK_sw.ToVar(_HH_AKLINK(AObj));
end;

function _HH_AKLINK_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_AKLINK_sw.Create as IDispatch;
end;

function _HH_AKLINK_cbStruct_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbStruct: Integer;

  if IsGet then
    Result := _HH_AKLINK_sw(AObj).FValue.cbStruct
  else
    _HH_AKLINK_sw(AObj).FValue.cbStruct := Integer(AArgs[0]);
end;

function _HH_AKLINK_fReserved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fReserved: Boolean;

  if IsGet then
    Result := _HH_AKLINK_sw(AObj).FValue.fReserved
  else
    _HH_AKLINK_sw(AObj).FValue.fReserved := Boolean(AArgs[0]);
end;

function _HH_AKLINK_fIndexOnFail_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fIndexOnFail: Boolean;

  if IsGet then
    Result := _HH_AKLINK_sw(AObj).FValue.fIndexOnFail
  else
    _HH_AKLINK_sw(AObj).FValue.fIndexOnFail := Boolean(AArgs[0]);
end;

class function _HH_AKLINK_sw.GetTypeName: WideString;
begin
  Result := '_HH_AKLINK';
end;

function _HH_AKLINK_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _HH_AKLINK_sw.Create;
  _HH_AKLINK_sw(Result).FValue := FValue;
end;

class procedure _HH_AKLINK_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _HH_AKLINK_Copy_si, _HH_AKLINK_sw, 0);
  AData.AddField('cbStruct', _HH_AKLINK_cbStruct_si, Integer_sw);
  AData.AddField('fReserved', _HH_AKLINK_fReserved_si, Boolean_sw);
  AData.AddField('fIndexOnFail', _HH_AKLINK_fIndexOnFail_si, Boolean_sw);

  { Class members }

  AData.AddConstructor('Create', _HH_AKLINK_Create_si, 0);
end;

class function _HH_AKLINK_sw.ToVar(const AValue: _HH_AKLINK): OleVariant;
var
  wrpr: _HH_AKLINK_sw;
begin
  wrpr        := _HH_AKLINK_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _HH_AKLINK_sw.FromVar(const AValue: OleVariant): _HH_AKLINK;
begin
  Result := _HH_AKLINK_sw(ConvFromVar(AValue)).FValue;
end;

{ _HH_ENUM_IT_sw }

function _HH_ENUM_IT_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_ENUM_IT_sw.ToVar(_HH_ENUM_IT(AObj));
end;

function _HH_ENUM_IT_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_ENUM_IT_sw.Create as IDispatch;
end;

function _HH_ENUM_IT_cbStruct_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbStruct: Integer;

  if IsGet then
    Result := _HH_ENUM_IT_sw(AObj).FValue.cbStruct
  else
    _HH_ENUM_IT_sw(AObj).FValue.cbStruct := Integer(AArgs[0]);
end;

function _HH_ENUM_IT_iType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var iType: Integer;

  if IsGet then
    Result := _HH_ENUM_IT_sw(AObj).FValue.iType
  else
    _HH_ENUM_IT_sw(AObj).FValue.iType := Integer(AArgs[0]);
end;

class function _HH_ENUM_IT_sw.GetTypeName: WideString;
begin
  Result := '_HH_ENUM_IT';
end;

function _HH_ENUM_IT_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _HH_ENUM_IT_sw.Create;
  _HH_ENUM_IT_sw(Result).FValue := FValue;
end;

class procedure _HH_ENUM_IT_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _HH_ENUM_IT_Copy_si, _HH_ENUM_IT_sw, 0);
  AData.AddField('cbStruct', _HH_ENUM_IT_cbStruct_si, Integer_sw);
  AData.AddField('iType', _HH_ENUM_IT_iType_si, Integer_sw);

  { Class members }

  AData.AddConstructor('Create', _HH_ENUM_IT_Create_si, 0);
end;

class function _HH_ENUM_IT_sw.ToVar(const AValue: _HH_ENUM_IT): OleVariant;
var
  wrpr: _HH_ENUM_IT_sw;
begin
  wrpr        := _HH_ENUM_IT_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _HH_ENUM_IT_sw.FromVar(const AValue: OleVariant): _HH_ENUM_IT;
begin
  Result := _HH_ENUM_IT_sw(ConvFromVar(AValue)).FValue;
end;

{ _HH_ENUM_CAT_sw }

function _HH_ENUM_CAT_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_ENUM_CAT_sw.ToVar(_HH_ENUM_CAT(AObj));
end;

function _HH_ENUM_CAT_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_ENUM_CAT_sw.Create as IDispatch;
end;

function _HH_ENUM_CAT_cbStruct_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbStruct: Integer;

  if IsGet then
    Result := _HH_ENUM_CAT_sw(AObj).FValue.cbStruct
  else
    _HH_ENUM_CAT_sw(AObj).FValue.cbStruct := Integer(AArgs[0]);
end;

class function _HH_ENUM_CAT_sw.GetTypeName: WideString;
begin
  Result := '_HH_ENUM_CAT';
end;

function _HH_ENUM_CAT_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _HH_ENUM_CAT_sw.Create;
  _HH_ENUM_CAT_sw(Result).FValue := FValue;
end;

class procedure _HH_ENUM_CAT_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _HH_ENUM_CAT_Copy_si, _HH_ENUM_CAT_sw, 0);
  AData.AddField('cbStruct', _HH_ENUM_CAT_cbStruct_si, Integer_sw);

  { Class members }

  AData.AddConstructor('Create', _HH_ENUM_CAT_Create_si, 0);
end;

class function _HH_ENUM_CAT_sw.ToVar(const AValue: _HH_ENUM_CAT): OleVariant;
var
  wrpr: _HH_ENUM_CAT_sw;
begin
  wrpr        := _HH_ENUM_CAT_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _HH_ENUM_CAT_sw.FromVar(const AValue: OleVariant): _HH_ENUM_CAT;
begin
  Result := _HH_ENUM_CAT_sw(ConvFromVar(AValue)).FValue;
end;

{ _HH_SET_INFOTYPE_sw }

function _HH_SET_INFOTYPE_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_SET_INFOTYPE_sw.ToVar(_HH_SET_INFOTYPE(AObj));
end;

function _HH_SET_INFOTYPE_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_SET_INFOTYPE_sw.Create as IDispatch;
end;

function _HH_SET_INFOTYPE_cbStruct_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbStruct: Integer;

  if IsGet then
    Result := _HH_SET_INFOTYPE_sw(AObj).FValue.cbStruct
  else
    _HH_SET_INFOTYPE_sw(AObj).FValue.cbStruct := Integer(AArgs[0]);
end;

class function _HH_SET_INFOTYPE_sw.GetTypeName: WideString;
begin
  Result := '_HH_SET_INFOTYPE';
end;

function _HH_SET_INFOTYPE_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _HH_SET_INFOTYPE_sw.Create;
  _HH_SET_INFOTYPE_sw(Result).FValue := FValue;
end;

class procedure _HH_SET_INFOTYPE_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _HH_SET_INFOTYPE_Copy_si, _HH_SET_INFOTYPE_sw, 0);
  AData.AddField('cbStruct', _HH_SET_INFOTYPE_cbStruct_si, Integer_sw);

  { Class members }

  AData.AddConstructor('Create', _HH_SET_INFOTYPE_Create_si, 0);
end;

class function _HH_SET_INFOTYPE_sw.ToVar(
  const AValue: _HH_SET_INFOTYPE): OleVariant;
var
  wrpr: _HH_SET_INFOTYPE_sw;
begin
  wrpr        := _HH_SET_INFOTYPE_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _HH_SET_INFOTYPE_sw.FromVar(
  const AValue: OleVariant): _HH_SET_INFOTYPE;
begin
  Result := _HH_SET_INFOTYPE_sw(ConvFromVar(AValue)).FValue;
end;

{ _HH_FTS_QUERY_sw }

function _HH_FTS_QUERY_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_FTS_QUERY_sw.ToVar(_HH_FTS_QUERY(AObj));
end;

function _HH_FTS_QUERY_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_FTS_QUERY_sw.Create as IDispatch;
end;

function _HH_FTS_QUERY_cbStruct_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbStruct: Integer;

  if IsGet then
    Result := _HH_FTS_QUERY_sw(AObj).FValue.cbStruct
  else
    _HH_FTS_QUERY_sw(AObj).FValue.cbStruct := Integer(AArgs[0]);
end;

function _HH_FTS_QUERY_fUniCodeStrings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fUniCodeStrings: Boolean;

  if IsGet then
    Result := _HH_FTS_QUERY_sw(AObj).FValue.fUniCodeStrings
  else
    _HH_FTS_QUERY_sw(AObj).FValue.fUniCodeStrings := Boolean(AArgs[0]);
end;

function _HH_FTS_QUERY_iProximity_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var iProximity: longint;

  if IsGet then
    Result := _HH_FTS_QUERY_sw(AObj).FValue.iProximity
  else
    _HH_FTS_QUERY_sw(AObj).FValue.iProximity := longint(AArgs[0]);
end;

function _HH_FTS_QUERY_fStemmedSearch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fStemmedSearch: Boolean;

  if IsGet then
    Result := _HH_FTS_QUERY_sw(AObj).FValue.fStemmedSearch
  else
    _HH_FTS_QUERY_sw(AObj).FValue.fStemmedSearch := Boolean(AArgs[0]);
end;

function _HH_FTS_QUERY_fTitleOnly_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fTitleOnly: Boolean;

  if IsGet then
    Result := _HH_FTS_QUERY_sw(AObj).FValue.fTitleOnly
  else
    _HH_FTS_QUERY_sw(AObj).FValue.fTitleOnly := Boolean(AArgs[0]);
end;

function _HH_FTS_QUERY_fExecute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fExecute: Boolean;

  if IsGet then
    Result := _HH_FTS_QUERY_sw(AObj).FValue.fExecute
  else
    _HH_FTS_QUERY_sw(AObj).FValue.fExecute := Boolean(AArgs[0]);
end;

class function _HH_FTS_QUERY_sw.GetTypeName: WideString;
begin
  Result := '_HH_FTS_QUERY';
end;

function _HH_FTS_QUERY_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _HH_FTS_QUERY_sw.Create;
  _HH_FTS_QUERY_sw(Result).FValue := FValue;
end;

class procedure _HH_FTS_QUERY_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _HH_FTS_QUERY_Copy_si, _HH_FTS_QUERY_sw, 0);
  AData.AddField('cbStruct', _HH_FTS_QUERY_cbStruct_si, Integer_sw);
  AData.AddField('fUniCodeStrings', _HH_FTS_QUERY_fUniCodeStrings_si, Boolean_sw);
  AData.AddField('iProximity', _HH_FTS_QUERY_iProximity_si, longint_sw);
  AData.AddField('fStemmedSearch', _HH_FTS_QUERY_fStemmedSearch_si, Boolean_sw);
  AData.AddField('fTitleOnly', _HH_FTS_QUERY_fTitleOnly_si, Boolean_sw);
  AData.AddField('fExecute', _HH_FTS_QUERY_fExecute_si, Boolean_sw);

  { Class members }

  AData.AddConstructor('Create', _HH_FTS_QUERY_Create_si, 0);
end;

class function _HH_FTS_QUERY_sw.ToVar(const AValue: _HH_FTS_QUERY): OleVariant;
var
  wrpr: _HH_FTS_QUERY_sw;
begin
  wrpr        := _HH_FTS_QUERY_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _HH_FTS_QUERY_sw.FromVar(
  const AValue: OleVariant): _HH_FTS_QUERY;
begin
  Result := _HH_FTS_QUERY_sw(ConvFromVar(AValue)).FValue;
end;

{ _HH_WINTYPE_sw }

function _HH_WINTYPE_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_WINTYPE_sw.ToVar(_HH_WINTYPE(AObj));
end;

function _HH_WINTYPE_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_WINTYPE_sw.Create as IDispatch;
end;

function _HH_WINTYPE_cbStruct_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbStruct: Integer;

  if IsGet then
    Result := _HH_WINTYPE_sw(AObj).FValue.cbStruct
  else
    _HH_WINTYPE_sw(AObj).FValue.cbStruct := Integer(AArgs[0]);
end;

function _HH_WINTYPE_fUniCodeStrings_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fUniCodeStrings: Boolean;

  if IsGet then
    Result := _HH_WINTYPE_sw(AObj).FValue.fUniCodeStrings
  else
    _HH_WINTYPE_sw(AObj).FValue.fUniCodeStrings := Boolean(AArgs[0]);
end;

function _HH_WINTYPE_fsValidMembers_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fsValidMembers: DWord;

  if IsGet then
    Result := DWord_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.fsValidMembers)
  else
    _HH_WINTYPE_sw(AObj).FValue.fsValidMembers := DWord_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_fsWinProperties_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fsWinProperties: DWord;

  if IsGet then
    Result := DWord_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.fsWinProperties)
  else
    _HH_WINTYPE_sw(AObj).FValue.fsWinProperties := DWord_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_dwStyles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwStyles: DWord;

  if IsGet then
    Result := DWord_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.dwStyles)
  else
    _HH_WINTYPE_sw(AObj).FValue.dwStyles := DWord_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_dwExStyles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwExStyles: DWord;

  if IsGet then
    Result := DWord_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.dwExStyles)
  else
    _HH_WINTYPE_sw(AObj).FValue.dwExStyles := DWord_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_rcWindowPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var rcWindowPos: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.rcWindowPos)
  else
    _HH_WINTYPE_sw(AObj).FValue.rcWindowPos := TRect_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_nShowState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nShowState: Integer;

  if IsGet then
    Result := _HH_WINTYPE_sw(AObj).FValue.nShowState
  else
    _HH_WINTYPE_sw(AObj).FValue.nShowState := Integer(AArgs[0]);
end;

function _HH_WINTYPE_hwndHelp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hwndHelp: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.hwndHelp)
  else
    _HH_WINTYPE_sw(AObj).FValue.hwndHelp := HWND_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_hwndCaller_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hwndCaller: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.hwndCaller)
  else
    _HH_WINTYPE_sw(AObj).FValue.hwndCaller := HWND_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_hwndToolBar_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hwndToolBar: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.hwndToolBar)
  else
    _HH_WINTYPE_sw(AObj).FValue.hwndToolBar := HWND_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_hwndNavigation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hwndNavigation: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.hwndNavigation)
  else
    _HH_WINTYPE_sw(AObj).FValue.hwndNavigation := HWND_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_hwndHTML_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hwndHTML: HWND;

  if IsGet then
    Result := HWND_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.hwndHTML)
  else
    _HH_WINTYPE_sw(AObj).FValue.hwndHTML := HWND_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_iNavWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var iNavWidth: Integer;

  if IsGet then
    Result := _HH_WINTYPE_sw(AObj).FValue.iNavWidth
  else
    _HH_WINTYPE_sw(AObj).FValue.iNavWidth := Integer(AArgs[0]);
end;

function _HH_WINTYPE_rcHTML_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var rcHTML: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.rcHTML)
  else
    _HH_WINTYPE_sw(AObj).FValue.rcHTML := TRect_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_fsToolBarFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fsToolBarFlags: DWord;

  if IsGet then
    Result := DWord_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.fsToolBarFlags)
  else
    _HH_WINTYPE_sw(AObj).FValue.fsToolBarFlags := DWord_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_fNotExpanded_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fNotExpanded: Boolean;

  if IsGet then
    Result := _HH_WINTYPE_sw(AObj).FValue.fNotExpanded
  else
    _HH_WINTYPE_sw(AObj).FValue.fNotExpanded := Boolean(AArgs[0]);
end;

function _HH_WINTYPE_curNavType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var curNavType: Integer;

  if IsGet then
    Result := _HH_WINTYPE_sw(AObj).FValue.curNavType
  else
    _HH_WINTYPE_sw(AObj).FValue.curNavType := Integer(AArgs[0]);
end;

function _HH_WINTYPE_tabPos_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var tabPos: Integer;

  if IsGet then
    Result := _HH_WINTYPE_sw(AObj).FValue.tabPos
  else
    _HH_WINTYPE_sw(AObj).FValue.tabPos := Integer(AArgs[0]);
end;

function _HH_WINTYPE_idNotify_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var idNotify: Integer;

  if IsGet then
    Result := _HH_WINTYPE_sw(AObj).FValue.idNotify
  else
    _HH_WINTYPE_sw(AObj).FValue.idNotify := Integer(AArgs[0]);
end;

function _HH_WINTYPE_cHistory_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cHistory: Integer;

  if IsGet then
    Result := _HH_WINTYPE_sw(AObj).FValue.cHistory
  else
    _HH_WINTYPE_sw(AObj).FValue.cHistory := Integer(AArgs[0]);
end;

function _HH_WINTYPE_rcMinSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var rcMinSize: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(_HH_WINTYPE_sw(AObj).FValue.rcMinSize)
  else
    _HH_WINTYPE_sw(AObj).FValue.rcMinSize := TRect_sw.FromVar(AArgs[0]);
end;

function _HH_WINTYPE_cbInfoTYpes_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbInfoTYpes: Integer;

  if IsGet then
    Result := _HH_WINTYPE_sw(AObj).FValue.cbInfoTYpes
  else
    _HH_WINTYPE_sw(AObj).FValue.cbInfoTYpes := Integer(AArgs[0]);
end;

function _HH_WINTYPE_pszCustomTabs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var pszCustomTabs: Integer;

  if IsGet then
    Result := _HH_WINTYPE_sw(AObj).FValue.pszCustomTabs
  else
    _HH_WINTYPE_sw(AObj).FValue.pszCustomTabs := Integer(AArgs[0]);
end;

class function _HH_WINTYPE_sw.GetTypeName: WideString;
begin
  Result := '_HH_WINTYPE';
end;

function _HH_WINTYPE_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _HH_WINTYPE_sw.Create;
  _HH_WINTYPE_sw(Result).FValue := FValue;
end;

class procedure _HH_WINTYPE_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _HH_WINTYPE_Copy_si, _HH_WINTYPE_sw, 0);
  AData.AddField('cbStruct', _HH_WINTYPE_cbStruct_si, Integer_sw);
  AData.AddField('fUniCodeStrings', _HH_WINTYPE_fUniCodeStrings_si, Boolean_sw);
  AData.AddField('fsValidMembers', _HH_WINTYPE_fsValidMembers_si, DWord_sw);
  AData.AddField('fsWinProperties', _HH_WINTYPE_fsWinProperties_si, DWord_sw);
  AData.AddField('dwStyles', _HH_WINTYPE_dwStyles_si, DWord_sw);
  AData.AddField('dwExStyles', _HH_WINTYPE_dwExStyles_si, DWord_sw);
  AData.AddField('rcWindowPos', _HH_WINTYPE_rcWindowPos_si, TRect_sw);
  AData.AddField('nShowState', _HH_WINTYPE_nShowState_si, Integer_sw);
  AData.AddField('hwndHelp', _HH_WINTYPE_hwndHelp_si, HWND_sw);
  AData.AddField('hwndCaller', _HH_WINTYPE_hwndCaller_si, HWND_sw);
  AData.AddField('hwndToolBar', _HH_WINTYPE_hwndToolBar_si, HWND_sw);
  AData.AddField('hwndNavigation', _HH_WINTYPE_hwndNavigation_si, HWND_sw);
  AData.AddField('hwndHTML', _HH_WINTYPE_hwndHTML_si, HWND_sw);
  AData.AddField('iNavWidth', _HH_WINTYPE_iNavWidth_si, Integer_sw);
  AData.AddField('rcHTML', _HH_WINTYPE_rcHTML_si, TRect_sw);
  AData.AddField('fsToolBarFlags', _HH_WINTYPE_fsToolBarFlags_si, DWord_sw);
  AData.AddField('fNotExpanded', _HH_WINTYPE_fNotExpanded_si, Boolean_sw);
  AData.AddField('curNavType', _HH_WINTYPE_curNavType_si, Integer_sw);
  AData.AddField('tabPos', _HH_WINTYPE_tabPos_si, Integer_sw);
  AData.AddField('idNotify', _HH_WINTYPE_idNotify_si, Integer_sw);
  AData.AddField('cHistory', _HH_WINTYPE_cHistory_si, Integer_sw);
  AData.AddField('rcMinSize', _HH_WINTYPE_rcMinSize_si, TRect_sw);
  AData.AddField('cbInfoTYpes', _HH_WINTYPE_cbInfoTYpes_si, Integer_sw);
  AData.AddField('pszCustomTabs', _HH_WINTYPE_pszCustomTabs_si, Integer_sw);

  { Class members }

  AData.AddConstructor('Create', _HH_WINTYPE_Create_si, 0);
end;

class function _HH_WINTYPE_sw.ToVar(const AValue: _HH_WINTYPE): OleVariant;
var
  wrpr: _HH_WINTYPE_sw;
begin
  wrpr        := _HH_WINTYPE_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _HH_WINTYPE_sw.FromVar(const AValue: OleVariant): _HH_WINTYPE;
begin
  Result := _HH_WINTYPE_sw(ConvFromVar(AValue)).FValue;
end;

{ _HH_NTRACK_sw }

function _HH_NTRACK_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_NTRACK_sw.ToVar(_HH_NTRACK(AObj));
end;

function _HH_NTRACK_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _HH_NTRACK_sw.Create as IDispatch;
end;

function _HH_NTRACK_idAction_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var idAction: Integer;

  if IsGet then
    Result := _HH_NTRACK_sw(AObj).FValue.idAction
  else
    _HH_NTRACK_sw(AObj).FValue.idAction := Integer(AArgs[0]);
end;

class function _HH_NTRACK_sw.GetTypeName: WideString;
begin
  Result := '_HH_NTRACK';
end;

function _HH_NTRACK_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _HH_NTRACK_sw.Create;
  _HH_NTRACK_sw(Result).FValue := FValue;
end;

class procedure _HH_NTRACK_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _HH_NTRACK_Copy_si, _HH_NTRACK_sw, 0);
  AData.AddField('idAction', _HH_NTRACK_idAction_si, Integer_sw);

  { Class members }

  AData.AddConstructor('Create', _HH_NTRACK_Create_si, 0);
end;

class function _HH_NTRACK_sw.ToVar(const AValue: _HH_NTRACK): OleVariant;
var
  wrpr: _HH_NTRACK_sw;
begin
  wrpr        := _HH_NTRACK_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _HH_NTRACK_sw.FromVar(const AValue: OleVariant): _HH_NTRACK;
begin
  Result := _HH_NTRACK_sw(ConvFromVar(AValue)).FValue;
end;

{ Windows_sw }

function Windows_WCHAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type WCHAR = WideChar;

  Result := TLMDUnitWrapper.TypeToVar(WCHAR_sw);
end;

function Windows_DWORD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type DWORD = Types.DWORD;

  Result := TLMDUnitWrapper.TypeToVar(DWORD_sw);
end;

function Windows_BOOL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type BOOL = LongBool;

  Result := TLMDUnitWrapper.TypeToVar(BOOL_sw);
end;

function Windows_UCHAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UCHAR = Byte;

  Result := TLMDUnitWrapper.TypeToVar(UCHAR_sw);
end;

function Windows_SHORT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type SHORT = Smallint;

  Result := TLMDUnitWrapper.TypeToVar(SHORT_sw);
end;

function Windows_UINT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UINT = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(UINT_sw);
end;

function Windows_ULONG_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ULONG = Cardinal;

  Result := TLMDUnitWrapper.TypeToVar(ULONG_sw);
end;

function Windows_LCID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LCID = DWORD;

  Result := TLMDUnitWrapper.TypeToVar(LCID_sw);
end;

function Windows_LANGID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LANGID = Word;

  Result := TLMDUnitWrapper.TypeToVar(LANGID_sw);
end;

function Windows_THandle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THandle = System.THandle;

  Result := TLMDUnitWrapper.TypeToVar(THandle_sw);
end;

function Windows_INT_PTR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type INT_PTR = Integer;

  Result := TLMDUnitWrapper.TypeToVar(INT_PTR_sw);
end;

function Windows_LONG_PTR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LONG_PTR = Integer;

  Result := TLMDUnitWrapper.TypeToVar(LONG_PTR_sw);
end;

function Windows_UINT_PTR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UINT_PTR = Cardinal;

  Result := TLMDUnitWrapper.TypeToVar(UINT_PTR_sw);
end;

function Windows_ULONG_PTR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ULONG_PTR = Cardinal;

  Result := TLMDUnitWrapper.TypeToVar(ULONG_PTR_sw);
end;

function Windows_DWORD_PTR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type DWORD_PTR = ULONG_PTR;

  Result := TLMDUnitWrapper.TypeToVar(DWORD_PTR_sw);
end;

function Windows_LONGLONG_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LONGLONG = Int64;

  Result := TLMDUnitWrapper.TypeToVar(LONGLONG_sw);
end;

function Windows_WPARAM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type WPARAM = Longint;

  Result := TLMDUnitWrapper.TypeToVar(WPARAM_sw);
end;

function Windows_LPARAM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LPARAM = Longint;

  Result := TLMDUnitWrapper.TypeToVar(LPARAM_sw);
end;

function Windows_LRESULT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LRESULT = Longint;

  Result := TLMDUnitWrapper.TypeToVar(LRESULT_sw);
end;

function Windows_LOWORD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LOWORD = Word;

  Result := TLMDUnitWrapper.TypeToVar(LOWORD_sw);
end;

function Windows_LOBYTE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LOBYTE = Byte;

  Result := TLMDUnitWrapper.TypeToVar(LOBYTE_sw);
end;

function Windows_HWND_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HWND = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HWND_sw);
end;

function Windows_HHOOK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HHOOK = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HHOOK_sw);
end;

function Windows_ATOM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ATOM = Word;

  Result := TLMDUnitWrapper.TypeToVar(ATOM_sw);
end;

function Windows_TAtom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAtom = Word;

  Result := TLMDUnitWrapper.TypeToVar(TAtom_sw);
end;

function Windows_HGLOBAL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HGLOBAL = THandle;

  Result := TLMDUnitWrapper.TypeToVar(HGLOBAL_sw);
end;

function Windows_HLOCAL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HLOCAL = THandle;

  Result := TLMDUnitWrapper.TypeToVar(HLOCAL_sw);
end;

function Windows_HGDIOBJ_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HGDIOBJ = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HGDIOBJ_sw);
end;

function Windows_HACCEL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HACCEL = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HACCEL_sw);
end;

function Windows_HBITMAP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HBITMAP = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HBITMAP_sw);
end;

function Windows_HBRUSH_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HBRUSH = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HBRUSH_sw);
end;

function Windows_HCOLORSPACE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HCOLORSPACE = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HCOLORSPACE_sw);
end;

function Windows_HDC_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type HDC = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HDC_sw);
end;

function Windows_HGLRC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HGLRC = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HGLRC_sw);
end;

function Windows_HDESK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HDESK = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HDESK_sw);
end;

function Windows_HENHMETAFILE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HENHMETAFILE = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HENHMETAFILE_sw);
end;

function Windows_HFONT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HFONT = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HFONT_sw);
end;

function Windows_HICON_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HICON = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HICON_sw);
end;

function Windows_HMENU_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HMENU = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HMENU_sw);
end;

function Windows_HMETAFILE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HMETAFILE = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HMETAFILE_sw);
end;

function Windows_HINST_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HINST = System.HINST;

  Result := TLMDUnitWrapper.TypeToVar(HINST_sw);
end;

function Windows_HMODULE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HMODULE = System.HMODULE;

  Result := TLMDUnitWrapper.TypeToVar(HMODULE_sw);
end;

function Windows_HPALETTE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HPALETTE = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HPALETTE_sw);
end;

function Windows_HPEN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HPEN = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HPEN_sw);
end;

function Windows_HRGN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HRGN = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HRGN_sw);
end;

function Windows_HSTR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HSTR = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HSTR_sw);
end;

function Windows_HTASK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HTASK = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HTASK_sw);
end;

function Windows_HWINSTA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HWINSTA = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HWINSTA_sw);
end;

function Windows_HKL_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type HKL = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HKL_sw);
end;

function Windows_HFILE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HFILE = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HFILE_sw);
end;

function Windows_HCURSOR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HCURSOR = HICON;

  Result := TLMDUnitWrapper.TypeToVar(HCURSOR_sw);
end;

function Windows_COLORREF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type COLORREF = DWORD;

  Result := TLMDUnitWrapper.TypeToVar(COLORREF_sw);
end;

function Windows_TColorRef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TColorRef = DWORD;

  Result := TLMDUnitWrapper.TypeToVar(TColorRef_sw);
end;

function Windows_TPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPoint = Types.TPoint;

  Result := TLMDUnitWrapper.TypeToVar(TPoint_sw);
end;

function Windows_tagPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagPoint = Types.tagPoint;

  Result := TLMDUnitWrapper.TypeToVar(tagPoint_sw);
end;

function Windows_TRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRect = Types.TRect;

  Result := TLMDUnitWrapper.TypeToVar(TRect_sw);
end;

function Windows__POINTL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _POINTL = record;

  Result := TLMDUnitWrapper.TypeToVar(_POINTL_sw);
end;

function Windows_TPointL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPointL = _POINTL;

  Result := TLMDUnitWrapper.TypeToVar(TPointL_sw);
end;

function Windows_TSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSize = Types.TSize;

  Result := TLMDUnitWrapper.TypeToVar(TSize_sw);
end;

function Windows_SIZE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type SIZE = Types.SIZE;

  Result := TLMDUnitWrapper.TypeToVar(SIZE_sw);
end;

function Windows_TSmallPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSmallPoint = Types.TSmallPoint;

  Result := TLMDUnitWrapper.TypeToVar(TSmallPoint_sw);
end;

function Windows__STARTUPINFOW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _STARTUPINFOW = record;

  Result := TLMDUnitWrapper.TypeToVar(_STARTUPINFOW_sw);
end;

function Windows_TStartupInfoW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStartupInfoW = _STARTUPINFOW;

  Result := TLMDUnitWrapper.TypeToVar(TStartupInfoW_sw);
end;

function Windows_STARTUPINFOW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type STARTUPINFOW = _STARTUPINFOW;

  Result := TLMDUnitWrapper.TypeToVar(STARTUPINFOW_sw);
end;

function Windows_S_OK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const S_OK = <value>;

  Result := S_OK;
end;

function Windows_S_FALSE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const S_FALSE = <value>;

  Result := S_FALSE;
end;

function Windows_VK_LBUTTON_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_LBUTTON = <value>;

  Result := VK_LBUTTON;
end;

function Windows_VK_RBUTTON_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_RBUTTON = <value>;

  Result := VK_RBUTTON;
end;

function Windows_VK_CANCEL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_CANCEL = <value>;

  Result := VK_CANCEL;
end;

function Windows_VK_MBUTTON_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_MBUTTON = <value>;

  Result := VK_MBUTTON;
end;

function Windows_VK_BACK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_BACK = <value>;

  Result := VK_BACK;
end;

function Windows_VK_TAB_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_TAB = <value>;

  Result := VK_TAB;
end;

function Windows_VK_CLEAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_CLEAR = <value>;

  Result := VK_CLEAR;
end;

function Windows_VK_RETURN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_RETURN = <value>;

  Result := VK_RETURN;
end;

function Windows_VK_SHIFT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_SHIFT = <value>;

  Result := VK_SHIFT;
end;

function Windows_VK_CONTROL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_CONTROL = <value>;

  Result := VK_CONTROL;
end;

function Windows_VK_MENU_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_MENU = <value>;

  Result := VK_MENU;
end;

function Windows_VK_PAUSE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_PAUSE = <value>;

  Result := VK_PAUSE;
end;

function Windows_VK_CAPITAL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_CAPITAL = <value>;

  Result := VK_CAPITAL;
end;

function Windows_VK_KANA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_KANA = <value>;

  Result := VK_KANA;
end;

function Windows_VK_HANGUL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_HANGUL = <value>;

  Result := VK_HANGUL;
end;

function Windows_VK_JUNJA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_JUNJA = <value>;

  Result := VK_JUNJA;
end;

function Windows_VK_FINAL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_FINAL = <value>;

  Result := VK_FINAL;
end;

function Windows_VK_HANJA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_HANJA = <value>;

  Result := VK_HANJA;
end;

function Windows_VK_KANJI_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_KANJI = <value>;

  Result := VK_KANJI;
end;

function Windows_VK_CONVERT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_CONVERT = <value>;

  Result := VK_CONVERT;
end;

function Windows_VK_NONCONVERT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NONCONVERT = <value>;

  Result := VK_NONCONVERT;
end;

function Windows_VK_ACCEPT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_ACCEPT = <value>;

  Result := VK_ACCEPT;
end;

function Windows_VK_MODECHANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_MODECHANGE = <value>;

  Result := VK_MODECHANGE;
end;

function Windows_VK_ESCAPE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_ESCAPE = <value>;

  Result := VK_ESCAPE;
end;

function Windows_VK_SPACE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_SPACE = <value>;

  Result := VK_SPACE;
end;

function Windows_VK_PRIOR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_PRIOR = <value>;

  Result := VK_PRIOR;
end;

function Windows_VK_NEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NEXT = <value>;

  Result := VK_NEXT;
end;

function Windows_VK_END_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_END = <value>;

  Result := VK_END;
end;

function Windows_VK_HOME_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_HOME = <value>;

  Result := VK_HOME;
end;

function Windows_VK_LEFT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_LEFT = <value>;

  Result := VK_LEFT;
end;

function Windows_VK_UP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_UP = <value>;

  Result := VK_UP;
end;

function Windows_VK_RIGHT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_RIGHT = <value>;

  Result := VK_RIGHT;
end;

function Windows_VK_DOWN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_DOWN = <value>;

  Result := VK_DOWN;
end;

function Windows_VK_SELECT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_SELECT = <value>;

  Result := VK_SELECT;
end;

function Windows_VK_PRINT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_PRINT = <value>;

  Result := VK_PRINT;
end;

function Windows_VK_EXECUTE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_EXECUTE = <value>;

  Result := VK_EXECUTE;
end;

function Windows_VK_SNAPSHOT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_SNAPSHOT = <value>;

  Result := VK_SNAPSHOT;
end;

function Windows_VK_INSERT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_INSERT = <value>;

  Result := VK_INSERT;
end;

function Windows_VK_DELETE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_DELETE = <value>;

  Result := VK_DELETE;
end;

function Windows_VK_HELP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_HELP = <value>;

  Result := VK_HELP;
end;

function Windows_VK_LWIN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_LWIN = <value>;

  Result := VK_LWIN;
end;

function Windows_VK_RWIN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_RWIN = <value>;

  Result := VK_RWIN;
end;

function Windows_VK_APPS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_APPS = <value>;

  Result := VK_APPS;
end;

function Windows_VK_NUMPAD0_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NUMPAD0 = <value>;

  Result := VK_NUMPAD0;
end;

function Windows_VK_NUMPAD1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NUMPAD1 = <value>;

  Result := VK_NUMPAD1;
end;

function Windows_VK_NUMPAD2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NUMPAD2 = <value>;

  Result := VK_NUMPAD2;
end;

function Windows_VK_NUMPAD3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NUMPAD3 = <value>;

  Result := VK_NUMPAD3;
end;

function Windows_VK_NUMPAD4_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NUMPAD4 = <value>;

  Result := VK_NUMPAD4;
end;

function Windows_VK_NUMPAD5_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NUMPAD5 = <value>;

  Result := VK_NUMPAD5;
end;

function Windows_VK_NUMPAD6_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NUMPAD6 = <value>;

  Result := VK_NUMPAD6;
end;

function Windows_VK_NUMPAD7_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NUMPAD7 = <value>;

  Result := VK_NUMPAD7;
end;

function Windows_VK_NUMPAD8_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NUMPAD8 = <value>;

  Result := VK_NUMPAD8;
end;

function Windows_VK_NUMPAD9_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NUMPAD9 = <value>;

  Result := VK_NUMPAD9;
end;

function Windows_VK_MULTIPLY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_MULTIPLY = <value>;

  Result := VK_MULTIPLY;
end;

function Windows_VK_ADD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_ADD = <value>;

  Result := VK_ADD;
end;

function Windows_VK_SEPARATOR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_SEPARATOR = <value>;

  Result := VK_SEPARATOR;
end;

function Windows_VK_SUBTRACT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_SUBTRACT = <value>;

  Result := VK_SUBTRACT;
end;

function Windows_VK_DECIMAL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_DECIMAL = <value>;

  Result := VK_DECIMAL;
end;

function Windows_VK_DIVIDE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_DIVIDE = <value>;

  Result := VK_DIVIDE;
end;

function Windows_VK_F1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F1 = <value>;

  Result := VK_F1;
end;

function Windows_VK_F2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F2 = <value>;

  Result := VK_F2;
end;

function Windows_VK_F3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F3 = <value>;

  Result := VK_F3;
end;

function Windows_VK_F4_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F4 = <value>;

  Result := VK_F4;
end;

function Windows_VK_F5_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F5 = <value>;

  Result := VK_F5;
end;

function Windows_VK_F6_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F6 = <value>;

  Result := VK_F6;
end;

function Windows_VK_F7_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F7 = <value>;

  Result := VK_F7;
end;

function Windows_VK_F8_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F8 = <value>;

  Result := VK_F8;
end;

function Windows_VK_F9_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F9 = <value>;

  Result := VK_F9;
end;

function Windows_VK_F10_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F10 = <value>;

  Result := VK_F10;
end;

function Windows_VK_F11_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F11 = <value>;

  Result := VK_F11;
end;

function Windows_VK_F12_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F12 = <value>;

  Result := VK_F12;
end;

function Windows_VK_F13_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F13 = <value>;

  Result := VK_F13;
end;

function Windows_VK_F14_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F14 = <value>;

  Result := VK_F14;
end;

function Windows_VK_F15_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F15 = <value>;

  Result := VK_F15;
end;

function Windows_VK_F16_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F16 = <value>;

  Result := VK_F16;
end;

function Windows_VK_F17_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F17 = <value>;

  Result := VK_F17;
end;

function Windows_VK_F18_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F18 = <value>;

  Result := VK_F18;
end;

function Windows_VK_F19_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F19 = <value>;

  Result := VK_F19;
end;

function Windows_VK_F20_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F20 = <value>;

  Result := VK_F20;
end;

function Windows_VK_F21_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F21 = <value>;

  Result := VK_F21;
end;

function Windows_VK_F22_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F22 = <value>;

  Result := VK_F22;
end;

function Windows_VK_F23_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F23 = <value>;

  Result := VK_F23;
end;

function Windows_VK_F24_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_F24 = <value>;

  Result := VK_F24;
end;

function Windows_VK_NUMLOCK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NUMLOCK = <value>;

  Result := VK_NUMLOCK;
end;

function Windows_VK_SCROLL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_SCROLL = <value>;

  Result := VK_SCROLL;
end;

function Windows_VK_LSHIFT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_LSHIFT = <value>;

  Result := VK_LSHIFT;
end;

function Windows_VK_RSHIFT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_RSHIFT = <value>;

  Result := VK_RSHIFT;
end;

function Windows_VK_LCONTROL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_LCONTROL = <value>;

  Result := VK_LCONTROL;
end;

function Windows_VK_RCONTROL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_RCONTROL = <value>;

  Result := VK_RCONTROL;
end;

function Windows_VK_LMENU_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_LMENU = <value>;

  Result := VK_LMENU;
end;

function Windows_VK_RMENU_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_RMENU = <value>;

  Result := VK_RMENU;
end;

function Windows_VK_PROCESSKEY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_PROCESSKEY = <value>;

  Result := VK_PROCESSKEY;
end;

function Windows_VK_ATTN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_ATTN = <value>;

  Result := VK_ATTN;
end;

function Windows_VK_CRSEL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_CRSEL = <value>;

  Result := VK_CRSEL;
end;

function Windows_VK_EXSEL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_EXSEL = <value>;

  Result := VK_EXSEL;
end;

function Windows_VK_EREOF_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_EREOF = <value>;

  Result := VK_EREOF;
end;

function Windows_VK_PLAY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_PLAY = <value>;

  Result := VK_PLAY;
end;

function Windows_VK_ZOOM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_ZOOM = <value>;

  Result := VK_ZOOM;
end;

function Windows_VK_NONAME_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_NONAME = <value>;

  Result := VK_NONAME;
end;

function Windows_VK_PA1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_PA1 = <value>;

  Result := VK_PA1;
end;

function Windows_VK_OEM_CLEAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VK_OEM_CLEAR = <value>;

  Result := VK_OEM_CLEAR;
end;

function Windows_GET_APPCOMMAND_LPARAM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GET_APPCOMMAND_LPARAM(const lParam: LongInt): Sh...

  Result := Windows.GET_APPCOMMAND_LPARAM(LongInt(AArgs[0]));
end;

function Windows_GET_DEVICE_LPARAM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GET_DEVICE_LPARAM(const lParam: LongInt): Word;

  Result := Windows.GET_DEVICE_LPARAM(LongInt(AArgs[0]));
end;

function Windows_GET_MOUSEORKEY_LPARAM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GET_MOUSEORKEY_LPARAM(const lParam: LongInt): Word;

  Result := Windows.GET_MOUSEORKEY_LPARAM(LongInt(AArgs[0]));
end;

function Windows_GET_FLAGS_LPARAM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GET_FLAGS_LPARAM(const lParam: LongInt): Word;

  Result := Windows.GET_FLAGS_LPARAM(LongInt(AArgs[0]));
end;

function Windows_GET_KEYSTATE_LPARAM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GET_KEYSTATE_LPARAM(const lParam: LongInt): Word;

  Result := Windows.GET_KEYSTATE_LPARAM(LongInt(AArgs[0]));
end;

function Windows_tagMSG_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagMSG = record;

  Result := TLMDUnitWrapper.TypeToVar(tagMSG_sw);
end;

function Windows_TMsg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMsg = tagMSG;

  Result := TLMDUnitWrapper.TypeToVar(TMsg_sw);
end;

function Windows_PointToLParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function PointToLParam(P: TPoint): LPARAM;

  Result := LPARAM_sw.ToVar(Windows.PointToLParam(TPoint_sw.FromVar(AArgs[0])));
end;

function Windows__HHN_NOTIFY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _HHN_NOTIFY = record;

  Result := TLMDUnitWrapper.TypeToVar(_HHN_NOTIFY_sw);
end;

function Windows_THHN_Notify_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THHN_Notify = _HHN_NOTIFY;

  Result := TLMDUnitWrapper.TypeToVar(THHN_Notify_sw);
end;

function Windows_HHN_NOTIFY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HHN_NOTIFY = _HHN_NOTIFY;

  Result := TLMDUnitWrapper.TypeToVar(HHN_NOTIFY_sw);
end;

function Windows__HH_POPUP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _HH_POPUP = record;

  Result := TLMDUnitWrapper.TypeToVar(_HH_POPUP_sw);
end;

function Windows_THH_Popup_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THH_Popup = _HH_POPUP;

  Result := TLMDUnitWrapper.TypeToVar(THH_Popup_sw);
end;

function Windows_HH_POPUP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HH_POPUP = _HH_POPUP;

  Result := TLMDUnitWrapper.TypeToVar(HH_POPUP_sw);
end;

function Windows__HH_AKLINK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _HH_AKLINK = record;

  Result := TLMDUnitWrapper.TypeToVar(_HH_AKLINK_sw);
end;

function Windows_THH_AKLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THH_AKLink = _HH_AKLINK;

  Result := TLMDUnitWrapper.TypeToVar(THH_AKLink_sw);
end;

function Windows_HH_AKLINK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HH_AKLINK = _HH_AKLINK;

  Result := TLMDUnitWrapper.TypeToVar(HH_AKLINK_sw);
end;

function Windows__HH_ENUM_IT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _HH_ENUM_IT = record;

  Result := TLMDUnitWrapper.TypeToVar(_HH_ENUM_IT_sw);
end;

function Windows_THH_Enum_it_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THH_Enum_it = _HH_ENUM_IT;

  Result := TLMDUnitWrapper.TypeToVar(THH_Enum_it_sw);
end;

function Windows_HH_ENUM_IT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HH_ENUM_IT = _HH_ENUM_IT;

  Result := TLMDUnitWrapper.TypeToVar(HH_ENUM_IT_sw);
end;

function Windows__HH_ENUM_CAT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _HH_ENUM_CAT = record;

  Result := TLMDUnitWrapper.TypeToVar(_HH_ENUM_CAT_sw);
end;

function Windows_THH_Enum_Cat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THH_Enum_Cat = _HH_ENUM_CAT;

  Result := TLMDUnitWrapper.TypeToVar(THH_Enum_Cat_sw);
end;

function Windows_HH_ENUM_CAT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HH_ENUM_CAT = _HH_ENUM_CAT;

  Result := TLMDUnitWrapper.TypeToVar(HH_ENUM_CAT_sw);
end;

function Windows__HH_SET_INFOTYPE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _HH_SET_INFOTYPE = record;

  Result := TLMDUnitWrapper.TypeToVar(_HH_SET_INFOTYPE_sw);
end;

function Windows_THH_Set_Infotype_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THH_Set_Infotype = _HH_SET_INFOTYPE;

  Result := TLMDUnitWrapper.TypeToVar(THH_Set_Infotype_sw);
end;

function Windows_HH_SET_INFOTYPE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HH_SET_INFOTYPE = _HH_SET_INFOTYPE;

  Result := TLMDUnitWrapper.TypeToVar(HH_SET_INFOTYPE_sw);
end;

function Windows_THH_Infotype_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THH_Infotype = Dword;

  Result := TLMDUnitWrapper.TypeToVar(THH_Infotype_sw);
end;

function Windows_HH_INFOTYPE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HH_INFOTYPE = THH_Infotype;

  Result := TLMDUnitWrapper.TypeToVar(HH_INFOTYPE_sw);
end;

function Windows__HH_FTS_QUERY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _HH_FTS_QUERY = record;

  Result := TLMDUnitWrapper.TypeToVar(_HH_FTS_QUERY_sw);
end;

function Windows_THH_Fts_Query_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THH_Fts_Query = _HH_FTS_QUERY;

  Result := TLMDUnitWrapper.TypeToVar(THH_Fts_Query_sw);
end;

function Windows_HH_FTS_QUERY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HH_FTS_QUERY = _HH_FTS_QUERY;

  Result := TLMDUnitWrapper.TypeToVar(HH_FTS_QUERY_sw);
end;

function Windows__HH_WINTYPE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _HH_WINTYPE = record;

  Result := TLMDUnitWrapper.TypeToVar(_HH_WINTYPE_sw);
end;

function Windows_THH_WINTYPE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THH_WINTYPE = _HH_WINTYPE;

  Result := TLMDUnitWrapper.TypeToVar(THH_WINTYPE_sw);
end;

function Windows_HH_WINTYPE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HH_WINTYPE = _HH_WINTYPE;

  Result := TLMDUnitWrapper.TypeToVar(HH_WINTYPE_sw);
end;

function Windows__HH_NTRACK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _HH_NTRACK = record;

  Result := TLMDUnitWrapper.TypeToVar(_HH_NTRACK_sw);
end;

function Windows_THH_NTrack_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type THH_NTrack = _HH_NTRACK;

  Result := TLMDUnitWrapper.TypeToVar(THH_NTrack_sw);
end;

function Windows_HH_NTRACK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HH_NTRACK = _HH_NTRACK;

  Result := TLMDUnitWrapper.TypeToVar(HH_NTRACK_sw);
end;

function Windows_RegDisablePredefinedCache_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function RegDisablePredefinedCache: Longint;

  Result := Windows.RegDisablePredefinedCache();
end;

class function Windows_sw.GetUnitName: WideString;
begin
  Result := 'Windows';
end;

class procedure Windows_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(WCHAR_sw, Windows_WCHAR_si);
  AData.AddType(DWORD_sw, Windows_DWORD_si);
  AData.AddType(BOOL_sw, Windows_BOOL_si);
  AData.AddType(UCHAR_sw, Windows_UCHAR_si);
  AData.AddType(SHORT_sw, Windows_SHORT_si);
  AData.AddType(UINT_sw, Windows_UINT_si);
  AData.AddType(ULONG_sw, Windows_ULONG_si);
  AData.AddType(LCID_sw, Windows_LCID_si);
  AData.AddType(LANGID_sw, Windows_LANGID_si);
  AData.AddType(THandle_sw, Windows_THandle_si);
  AData.AddType(INT_PTR_sw, Windows_INT_PTR_si);
  AData.AddType(LONG_PTR_sw, Windows_LONG_PTR_si);
  AData.AddType(UINT_PTR_sw, Windows_UINT_PTR_si);
  AData.AddType(ULONG_PTR_sw, Windows_ULONG_PTR_si);
  AData.AddType(DWORD_PTR_sw, Windows_DWORD_PTR_si);
  AData.AddType(LONGLONG_sw, Windows_LONGLONG_si);
  AData.AddType(WPARAM_sw, Windows_WPARAM_si);
  AData.AddType(LPARAM_sw, Windows_LPARAM_si);
  AData.AddType(LRESULT_sw, Windows_LRESULT_si);
  AData.AddType(LOWORD_sw, Windows_LOWORD_si);
  AData.AddType(LOBYTE_sw, Windows_LOBYTE_si);
  AData.AddType(HWND_sw, Windows_HWND_si);
  AData.AddType(HHOOK_sw, Windows_HHOOK_si);
  AData.AddType(ATOM_sw, Windows_ATOM_si);
  AData.AddType(TAtom_sw, Windows_TAtom_si);
  AData.AddType(HGLOBAL_sw, Windows_HGLOBAL_si);
  AData.AddType(HLOCAL_sw, Windows_HLOCAL_si);
  AData.AddType(HGDIOBJ_sw, Windows_HGDIOBJ_si);
  AData.AddType(HACCEL_sw, Windows_HACCEL_si);
  AData.AddType(HBITMAP_sw, Windows_HBITMAP_si);
  AData.AddType(HBRUSH_sw, Windows_HBRUSH_si);
  AData.AddType(HCOLORSPACE_sw, Windows_HCOLORSPACE_si);
  AData.AddType(HDC_sw, Windows_HDC_si);
  AData.AddType(HGLRC_sw, Windows_HGLRC_si);
  AData.AddType(HDESK_sw, Windows_HDESK_si);
  AData.AddType(HENHMETAFILE_sw, Windows_HENHMETAFILE_si);
  AData.AddType(HFONT_sw, Windows_HFONT_si);
  AData.AddType(HICON_sw, Windows_HICON_si);
  AData.AddType(HMENU_sw, Windows_HMENU_si);
  AData.AddType(HMETAFILE_sw, Windows_HMETAFILE_si);
  AData.AddType(HINST_sw, Windows_HINST_si);
  AData.AddType(HMODULE_sw, Windows_HMODULE_si);
  AData.AddType(HPALETTE_sw, Windows_HPALETTE_si);
  AData.AddType(HPEN_sw, Windows_HPEN_si);
  AData.AddType(HRGN_sw, Windows_HRGN_si);
  AData.AddType(HSTR_sw, Windows_HSTR_si);
  AData.AddType(HTASK_sw, Windows_HTASK_si);
  AData.AddType(HWINSTA_sw, Windows_HWINSTA_si);
  AData.AddType(HKL_sw, Windows_HKL_si);
  AData.AddType(HFILE_sw, Windows_HFILE_si);
  AData.AddType(HCURSOR_sw, Windows_HCURSOR_si);
  AData.AddType(COLORREF_sw, Windows_COLORREF_si);
  AData.AddType(TColorRef_sw, Windows_TColorRef_si);
  AData.AddType(TPoint_sw, Windows_TPoint_si);
  AData.AddType(tagPoint_sw, Windows_tagPoint_si);
  AData.AddType(TRect_sw, Windows_TRect_si);
  AData.AddType(_POINTL_sw, Windows__POINTL_si);
  AData.AddType(TPointL_sw, Windows_TPointL_si);
  AData.AddType(TSize_sw, Windows_TSize_si);
  AData.AddType(SIZE_sw, Windows_SIZE_si);
  AData.AddType(TSmallPoint_sw, Windows_TSmallPoint_si);
  AData.AddType(_STARTUPINFOW_sw, Windows__STARTUPINFOW_si);
  AData.AddType(TStartupInfoW_sw, Windows_TStartupInfoW_si);
  AData.AddType(STARTUPINFOW_sw, Windows_STARTUPINFOW_si);
  AData.AddConstant('S_OK', Windows_S_OK_si, nil, VarType(Windows.S_OK));
  AData.AddConstant('S_FALSE', Windows_S_FALSE_si, nil, VarType(Windows.S_FALSE));
  AData.AddConstant('VK_LBUTTON', Windows_VK_LBUTTON_si, nil, VarType(Windows.VK_LBUTTON));
  AData.AddConstant('VK_RBUTTON', Windows_VK_RBUTTON_si, nil, VarType(Windows.VK_RBUTTON));
  AData.AddConstant('VK_CANCEL', Windows_VK_CANCEL_si, nil, VarType(Windows.VK_CANCEL));
  AData.AddConstant('VK_MBUTTON', Windows_VK_MBUTTON_si, nil, VarType(Windows.VK_MBUTTON));
  AData.AddConstant('VK_BACK', Windows_VK_BACK_si, nil, VarType(Windows.VK_BACK));
  AData.AddConstant('VK_TAB', Windows_VK_TAB_si, nil, VarType(Windows.VK_TAB));
  AData.AddConstant('VK_CLEAR', Windows_VK_CLEAR_si, nil, VarType(Windows.VK_CLEAR));
  AData.AddConstant('VK_RETURN', Windows_VK_RETURN_si, nil, VarType(Windows.VK_RETURN));
  AData.AddConstant('VK_SHIFT', Windows_VK_SHIFT_si, nil, VarType(Windows.VK_SHIFT));
  AData.AddConstant('VK_CONTROL', Windows_VK_CONTROL_si, nil, VarType(Windows.VK_CONTROL));
  AData.AddConstant('VK_MENU', Windows_VK_MENU_si, nil, VarType(Windows.VK_MENU));
  AData.AddConstant('VK_PAUSE', Windows_VK_PAUSE_si, nil, VarType(Windows.VK_PAUSE));
  AData.AddConstant('VK_CAPITAL', Windows_VK_CAPITAL_si, nil, VarType(Windows.VK_CAPITAL));
  AData.AddConstant('VK_KANA', Windows_VK_KANA_si, nil, VarType(Windows.VK_KANA));
  AData.AddConstant('VK_HANGUL', Windows_VK_HANGUL_si, nil, VarType(Windows.VK_HANGUL));
  AData.AddConstant('VK_JUNJA', Windows_VK_JUNJA_si, nil, VarType(Windows.VK_JUNJA));
  AData.AddConstant('VK_FINAL', Windows_VK_FINAL_si, nil, VarType(Windows.VK_FINAL));
  AData.AddConstant('VK_HANJA', Windows_VK_HANJA_si, nil, VarType(Windows.VK_HANJA));
  AData.AddConstant('VK_KANJI', Windows_VK_KANJI_si, nil, VarType(Windows.VK_KANJI));
  AData.AddConstant('VK_CONVERT', Windows_VK_CONVERT_si, nil, VarType(Windows.VK_CONVERT));
  AData.AddConstant('VK_NONCONVERT', Windows_VK_NONCONVERT_si, nil, VarType(Windows.VK_NONCONVERT));
  AData.AddConstant('VK_ACCEPT', Windows_VK_ACCEPT_si, nil, VarType(Windows.VK_ACCEPT));
  AData.AddConstant('VK_MODECHANGE', Windows_VK_MODECHANGE_si, nil, VarType(Windows.VK_MODECHANGE));
  AData.AddConstant('VK_ESCAPE', Windows_VK_ESCAPE_si, nil, VarType(Windows.VK_ESCAPE));
  AData.AddConstant('VK_SPACE', Windows_VK_SPACE_si, nil, VarType(Windows.VK_SPACE));
  AData.AddConstant('VK_PRIOR', Windows_VK_PRIOR_si, nil, VarType(Windows.VK_PRIOR));
  AData.AddConstant('VK_NEXT', Windows_VK_NEXT_si, nil, VarType(Windows.VK_NEXT));
  AData.AddConstant('VK_END', Windows_VK_END_si, nil, VarType(Windows.VK_END));
  AData.AddConstant('VK_HOME', Windows_VK_HOME_si, nil, VarType(Windows.VK_HOME));
  AData.AddConstant('VK_LEFT', Windows_VK_LEFT_si, nil, VarType(Windows.VK_LEFT));
  AData.AddConstant('VK_UP', Windows_VK_UP_si, nil, VarType(Windows.VK_UP));
  AData.AddConstant('VK_RIGHT', Windows_VK_RIGHT_si, nil, VarType(Windows.VK_RIGHT));
  AData.AddConstant('VK_DOWN', Windows_VK_DOWN_si, nil, VarType(Windows.VK_DOWN));
  AData.AddConstant('VK_SELECT', Windows_VK_SELECT_si, nil, VarType(Windows.VK_SELECT));
  AData.AddConstant('VK_PRINT', Windows_VK_PRINT_si, nil, VarType(Windows.VK_PRINT));
  AData.AddConstant('VK_EXECUTE', Windows_VK_EXECUTE_si, nil, VarType(Windows.VK_EXECUTE));
  AData.AddConstant('VK_SNAPSHOT', Windows_VK_SNAPSHOT_si, nil, VarType(Windows.VK_SNAPSHOT));
  AData.AddConstant('VK_INSERT', Windows_VK_INSERT_si, nil, VarType(Windows.VK_INSERT));
  AData.AddConstant('VK_DELETE', Windows_VK_DELETE_si, nil, VarType(Windows.VK_DELETE));
  AData.AddConstant('VK_HELP', Windows_VK_HELP_si, nil, VarType(Windows.VK_HELP));
  AData.AddConstant('VK_LWIN', Windows_VK_LWIN_si, nil, VarType(Windows.VK_LWIN));
  AData.AddConstant('VK_RWIN', Windows_VK_RWIN_si, nil, VarType(Windows.VK_RWIN));
  AData.AddConstant('VK_APPS', Windows_VK_APPS_si, nil, VarType(Windows.VK_APPS));
  AData.AddConstant('VK_NUMPAD0', Windows_VK_NUMPAD0_si, nil, VarType(Windows.VK_NUMPAD0));
  AData.AddConstant('VK_NUMPAD1', Windows_VK_NUMPAD1_si, nil, VarType(Windows.VK_NUMPAD1));
  AData.AddConstant('VK_NUMPAD2', Windows_VK_NUMPAD2_si, nil, VarType(Windows.VK_NUMPAD2));
  AData.AddConstant('VK_NUMPAD3', Windows_VK_NUMPAD3_si, nil, VarType(Windows.VK_NUMPAD3));
  AData.AddConstant('VK_NUMPAD4', Windows_VK_NUMPAD4_si, nil, VarType(Windows.VK_NUMPAD4));
  AData.AddConstant('VK_NUMPAD5', Windows_VK_NUMPAD5_si, nil, VarType(Windows.VK_NUMPAD5));
  AData.AddConstant('VK_NUMPAD6', Windows_VK_NUMPAD6_si, nil, VarType(Windows.VK_NUMPAD6));
  AData.AddConstant('VK_NUMPAD7', Windows_VK_NUMPAD7_si, nil, VarType(Windows.VK_NUMPAD7));
  AData.AddConstant('VK_NUMPAD8', Windows_VK_NUMPAD8_si, nil, VarType(Windows.VK_NUMPAD8));
  AData.AddConstant('VK_NUMPAD9', Windows_VK_NUMPAD9_si, nil, VarType(Windows.VK_NUMPAD9));
  AData.AddConstant('VK_MULTIPLY', Windows_VK_MULTIPLY_si, nil, VarType(Windows.VK_MULTIPLY));
  AData.AddConstant('VK_ADD', Windows_VK_ADD_si, nil, VarType(Windows.VK_ADD));
  AData.AddConstant('VK_SEPARATOR', Windows_VK_SEPARATOR_si, nil, VarType(Windows.VK_SEPARATOR));
  AData.AddConstant('VK_SUBTRACT', Windows_VK_SUBTRACT_si, nil, VarType(Windows.VK_SUBTRACT));
  AData.AddConstant('VK_DECIMAL', Windows_VK_DECIMAL_si, nil, VarType(Windows.VK_DECIMAL));
  AData.AddConstant('VK_DIVIDE', Windows_VK_DIVIDE_si, nil, VarType(Windows.VK_DIVIDE));
  AData.AddConstant('VK_F1', Windows_VK_F1_si, nil, VarType(Windows.VK_F1));
  AData.AddConstant('VK_F2', Windows_VK_F2_si, nil, VarType(Windows.VK_F2));
  AData.AddConstant('VK_F3', Windows_VK_F3_si, nil, VarType(Windows.VK_F3));
  AData.AddConstant('VK_F4', Windows_VK_F4_si, nil, VarType(Windows.VK_F4));
  AData.AddConstant('VK_F5', Windows_VK_F5_si, nil, VarType(Windows.VK_F5));
  AData.AddConstant('VK_F6', Windows_VK_F6_si, nil, VarType(Windows.VK_F6));
  AData.AddConstant('VK_F7', Windows_VK_F7_si, nil, VarType(Windows.VK_F7));
  AData.AddConstant('VK_F8', Windows_VK_F8_si, nil, VarType(Windows.VK_F8));
  AData.AddConstant('VK_F9', Windows_VK_F9_si, nil, VarType(Windows.VK_F9));
  AData.AddConstant('VK_F10', Windows_VK_F10_si, nil, VarType(Windows.VK_F10));
  AData.AddConstant('VK_F11', Windows_VK_F11_si, nil, VarType(Windows.VK_F11));
  AData.AddConstant('VK_F12', Windows_VK_F12_si, nil, VarType(Windows.VK_F12));
  AData.AddConstant('VK_F13', Windows_VK_F13_si, nil, VarType(Windows.VK_F13));
  AData.AddConstant('VK_F14', Windows_VK_F14_si, nil, VarType(Windows.VK_F14));
  AData.AddConstant('VK_F15', Windows_VK_F15_si, nil, VarType(Windows.VK_F15));
  AData.AddConstant('VK_F16', Windows_VK_F16_si, nil, VarType(Windows.VK_F16));
  AData.AddConstant('VK_F17', Windows_VK_F17_si, nil, VarType(Windows.VK_F17));
  AData.AddConstant('VK_F18', Windows_VK_F18_si, nil, VarType(Windows.VK_F18));
  AData.AddConstant('VK_F19', Windows_VK_F19_si, nil, VarType(Windows.VK_F19));
  AData.AddConstant('VK_F20', Windows_VK_F20_si, nil, VarType(Windows.VK_F20));
  AData.AddConstant('VK_F21', Windows_VK_F21_si, nil, VarType(Windows.VK_F21));
  AData.AddConstant('VK_F22', Windows_VK_F22_si, nil, VarType(Windows.VK_F22));
  AData.AddConstant('VK_F23', Windows_VK_F23_si, nil, VarType(Windows.VK_F23));
  AData.AddConstant('VK_F24', Windows_VK_F24_si, nil, VarType(Windows.VK_F24));
  AData.AddConstant('VK_NUMLOCK', Windows_VK_NUMLOCK_si, nil, VarType(Windows.VK_NUMLOCK));
  AData.AddConstant('VK_SCROLL', Windows_VK_SCROLL_si, nil, VarType(Windows.VK_SCROLL));
  AData.AddConstant('VK_LSHIFT', Windows_VK_LSHIFT_si, nil, VarType(Windows.VK_LSHIFT));
  AData.AddConstant('VK_RSHIFT', Windows_VK_RSHIFT_si, nil, VarType(Windows.VK_RSHIFT));
  AData.AddConstant('VK_LCONTROL', Windows_VK_LCONTROL_si, nil, VarType(Windows.VK_LCONTROL));
  AData.AddConstant('VK_RCONTROL', Windows_VK_RCONTROL_si, nil, VarType(Windows.VK_RCONTROL));
  AData.AddConstant('VK_LMENU', Windows_VK_LMENU_si, nil, VarType(Windows.VK_LMENU));
  AData.AddConstant('VK_RMENU', Windows_VK_RMENU_si, nil, VarType(Windows.VK_RMENU));
  AData.AddConstant('VK_PROCESSKEY', Windows_VK_PROCESSKEY_si, nil, VarType(Windows.VK_PROCESSKEY));
  AData.AddConstant('VK_ATTN', Windows_VK_ATTN_si, nil, VarType(Windows.VK_ATTN));
  AData.AddConstant('VK_CRSEL', Windows_VK_CRSEL_si, nil, VarType(Windows.VK_CRSEL));
  AData.AddConstant('VK_EXSEL', Windows_VK_EXSEL_si, nil, VarType(Windows.VK_EXSEL));
  AData.AddConstant('VK_EREOF', Windows_VK_EREOF_si, nil, VarType(Windows.VK_EREOF));
  AData.AddConstant('VK_PLAY', Windows_VK_PLAY_si, nil, VarType(Windows.VK_PLAY));
  AData.AddConstant('VK_ZOOM', Windows_VK_ZOOM_si, nil, VarType(Windows.VK_ZOOM));
  AData.AddConstant('VK_NONAME', Windows_VK_NONAME_si, nil, VarType(Windows.VK_NONAME));
  AData.AddConstant('VK_PA1', Windows_VK_PA1_si, nil, VarType(Windows.VK_PA1));
  AData.AddConstant('VK_OEM_CLEAR', Windows_VK_OEM_CLEAR_si, nil, VarType(Windows.VK_OEM_CLEAR));
  AData.AddFunction('GET_APPCOMMAND_LPARAM', Windows_GET_APPCOMMAND_LPARAM_si, Shortint_sw, 1, False);
  AData.AddFunction('GET_DEVICE_LPARAM', Windows_GET_DEVICE_LPARAM_si, Word_sw, 1, False);
  AData.AddFunction('GET_MOUSEORKEY_LPARAM', Windows_GET_MOUSEORKEY_LPARAM_si, Word_sw, 1, False);
  AData.AddFunction('GET_FLAGS_LPARAM', Windows_GET_FLAGS_LPARAM_si, Word_sw, 1, False);
  AData.AddFunction('GET_KEYSTATE_LPARAM', Windows_GET_KEYSTATE_LPARAM_si, Word_sw, 1, False);
  AData.AddType(tagMSG_sw, Windows_tagMSG_si);
  AData.AddType(TMsg_sw, Windows_TMsg_si);
  AData.AddFunction('PointToLParam', Windows_PointToLParam_si, LPARAM_sw, 1, False);
  AData.AddType(_HHN_NOTIFY_sw, Windows__HHN_NOTIFY_si);
  AData.AddType(THHN_Notify_sw, Windows_THHN_Notify_si);
  AData.AddType(HHN_NOTIFY_sw, Windows_HHN_NOTIFY_si);
  AData.AddType(_HH_POPUP_sw, Windows__HH_POPUP_si);
  AData.AddType(THH_Popup_sw, Windows_THH_Popup_si);
  AData.AddType(HH_POPUP_sw, Windows_HH_POPUP_si);
  AData.AddType(_HH_AKLINK_sw, Windows__HH_AKLINK_si);
  AData.AddType(THH_AKLink_sw, Windows_THH_AKLink_si);
  AData.AddType(HH_AKLINK_sw, Windows_HH_AKLINK_si);
  AData.AddType(_HH_ENUM_IT_sw, Windows__HH_ENUM_IT_si);
  AData.AddType(THH_Enum_it_sw, Windows_THH_Enum_it_si);
  AData.AddType(HH_ENUM_IT_sw, Windows_HH_ENUM_IT_si);
  AData.AddType(_HH_ENUM_CAT_sw, Windows__HH_ENUM_CAT_si);
  AData.AddType(THH_Enum_Cat_sw, Windows_THH_Enum_Cat_si);
  AData.AddType(HH_ENUM_CAT_sw, Windows_HH_ENUM_CAT_si);
  AData.AddType(_HH_SET_INFOTYPE_sw, Windows__HH_SET_INFOTYPE_si);
  AData.AddType(THH_Set_Infotype_sw, Windows_THH_Set_Infotype_si);
  AData.AddType(HH_SET_INFOTYPE_sw, Windows_HH_SET_INFOTYPE_si);
  AData.AddType(THH_Infotype_sw, Windows_THH_Infotype_si);
  AData.AddType(HH_INFOTYPE_sw, Windows_HH_INFOTYPE_si);
  AData.AddType(_HH_FTS_QUERY_sw, Windows__HH_FTS_QUERY_si);
  AData.AddType(THH_Fts_Query_sw, Windows_THH_Fts_Query_si);
  AData.AddType(HH_FTS_QUERY_sw, Windows_HH_FTS_QUERY_si);
  AData.AddType(_HH_WINTYPE_sw, Windows__HH_WINTYPE_si);
  AData.AddType(THH_WINTYPE_sw, Windows_THH_WINTYPE_si);
  AData.AddType(HH_WINTYPE_sw, Windows_HH_WINTYPE_si);
  AData.AddType(_HH_NTRACK_sw, Windows__HH_NTRACK_si);
  AData.AddType(THH_NTrack_sw, Windows_THH_NTrack_si);
  AData.AddType(HH_NTRACK_sw, Windows_HH_NTRACK_si);
  AData.AddFunction('RegDisablePredefinedCache', Windows_RegDisablePredefinedCache_si, Longint_sw, 0, False);
end;

class function Windows_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Windows_sw);
end;

initialization
  RegisterUnitWrapper(Windows_sw);

end.
