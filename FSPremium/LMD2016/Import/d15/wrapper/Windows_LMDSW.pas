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

  USHORT_sw = Word_sw;

  UINT_sw = LongWord_sw;

  ULONG_sw = Cardinal_sw;

  LCID_sw = DWORD_sw;

  LANGID_sw = Word_sw;

  THandle_sw = LMDSctSysWrappers.THandle_sw;

  INT_PTR_sw = Integer_sw;

  LONG_PTR_sw = Longint_sw;

  UINT_PTR_sw = Cardinal_sw;

  ULONG_PTR_sw = LongWord_sw;

  DWORD_PTR_sw = ULONG_PTR_sw;

  HANDLE_PTR_sw = LongWord_sw;

  LONGLONG_sw = Int64_sw;

  _LUID_sw = class(TLMDRecordWrapper)
  private
    FValue: _LUID;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _LUID): OleVariant;
    class function FromVar(const AValue: OleVariant): _LUID;
  end;

  TLUID_sw = _LUID_sw;

  LUID_sw = _LUID_sw;

  WPARAM_sw = INT_PTR_sw;

  LPARAM_sw = INT_PTR_sw;

  LRESULT_sw = INT_PTR_sw;

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

  VARIANT_BOOL_sw = SHORT_sw;

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

  MSG_sw = tagMSG_sw;


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

{ _LUID_sw }

function _LUID_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  Result := _LUID_sw.ToVar(_LUID(AObj));
end;

function _LUID_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := _LUID_sw.Create as IDispatch;
end;

function _LUID_LowPart_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var LowPart: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_LUID_sw(AObj).FValue.LowPart)
  else
    _LUID_sw(AObj).FValue.LowPart := DWORD_sw.FromVar(AArgs[0]);
end;

class function _LUID_sw.GetTypeName: WideString;
begin
  Result := '_LUID';
end;

function _LUID_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _LUID_sw.Create;
  _LUID_sw(Result).FValue := FValue;
end;

class procedure _LUID_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', _LUID_Copy_si, _LUID_sw, 0);
  AData.AddField('LowPart', _LUID_LowPart_si, DWORD_sw);

  { Class members }

  AData.AddConstructor('Create', _LUID_Create_si, 0);
end;

class function _LUID_sw.ToVar(const AValue: _LUID): OleVariant;
var
  wrpr: _LUID_sw;
begin
  wrpr        := _LUID_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _LUID_sw.FromVar(const AValue: OleVariant): _LUID;
begin
  Result := _LUID_sw(ConvFromVar(AValue)).FValue;
end;

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

function tagMSG_time_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var time: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(tagMSG_sw(AObj).FValue.time)
  else
    tagMSG_sw(AObj).FValue.time := DWORD_sw.FromVar(AArgs[0]);
end;

function tagMSG_pt_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var pt: TPoint;

  if IsGet then
    Result := TPoint_sw.ToVar(tagMSG_sw(AObj).FValue.pt)
  else
    tagMSG_sw(AObj).FValue.pt := TPoint_sw.FromVar(AArgs[0]);
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
  AData.AddField('time', tagMSG_time_si, DWORD_sw);
  AData.AddField('pt', tagMSG_pt_si, TPoint_sw);

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

function Windows_USHORT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type USHORT = Word;

  Result := TLMDUnitWrapper.TypeToVar(USHORT_sw);
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
  // type LONG_PTR = Longint;

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
  // type ULONG_PTR = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(ULONG_PTR_sw);
end;

function Windows_DWORD_PTR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type DWORD_PTR = ULONG_PTR;

  Result := TLMDUnitWrapper.TypeToVar(DWORD_PTR_sw);
end;

function Windows_HANDLE_PTR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HANDLE_PTR = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(HANDLE_PTR_sw);
end;

function Windows_LONGLONG_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LONGLONG = Int64;

  Result := TLMDUnitWrapper.TypeToVar(LONGLONG_sw);
end;

function Windows_LANG_INVARIANT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const LANG_INVARIANT = <value>;

  Result := LANG_INVARIANT;
end;

function Windows_SUBLANG_CUSTOM_DEFAULT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SUBLANG_CUSTOM_DEFAULT = <value>;

  Result := SUBLANG_CUSTOM_DEFAULT;
end;

function Windows_SUBLANG_CUSTOM_UNSPECIFIED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SUBLANG_CUSTOM_UNSPECIFIED = <value>;

  Result := SUBLANG_CUSTOM_UNSPECIFIED;
end;

function Windows_SUBLANG_UI_CUSTOM_DEFAULT_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SUBLANG_UI_CUSTOM_DEFAULT = <value>;

  Result := SUBLANG_UI_CUSTOM_DEFAULT;
end;

function Windows_LOCALE_NAME_MAX_LENGTH_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const LOCALE_NAME_MAX_LENGTH = <value>;

  Result := LOCALE_NAME_MAX_LENGTH;
end;

function Windows_NLS_VALID_LOCALE_MASK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const NLS_VALID_LOCALE_MASK = <value>;

  Result := NLS_VALID_LOCALE_MASK;
end;

function Windows_FILE_ATTRIBUTE_VIRTUAL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const FILE_ATTRIBUTE_VIRTUAL = <value>;

  Result := FILE_ATTRIBUTE_VIRTUAL;
end;

function Windows__LUID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _LUID = record;

  Result := TLMDUnitWrapper.TypeToVar(_LUID_sw);
end;

function Windows_TLUID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TLUID = _LUID;

  Result := TLMDUnitWrapper.TypeToVar(TLUID_sw);
end;

function Windows_LUID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LUID = _LUID;

  Result := TLMDUnitWrapper.TypeToVar(LUID_sw);
end;

function Windows_TOKEN_SOURCE_LENGTH_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOKEN_SOURCE_LENGTH = <value>;

  Result := TOKEN_SOURCE_LENGTH;
end;

function Windows_POLICY_AUDIT_SUBCATEGORY_COUNT_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const POLICY_AUDIT_SUBCATEGORY_COUNT = <value>;

  Result := POLICY_AUDIT_SUBCATEGORY_COUNT;
end;

function Windows_WPARAM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type WPARAM = INT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(WPARAM_sw);
end;

function Windows_LPARAM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LPARAM = INT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(LPARAM_sw);
end;

function Windows_LRESULT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LRESULT = INT_PTR;

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

function Windows_VARIANT_BOOL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type VARIANT_BOOL = SHORT;

  Result := TLMDUnitWrapper.TypeToVar(VARIANT_BOOL_sw);
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

function Windows_FILE_FLAG_FIRST_PIPE_INSTANCE_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const FILE_FLAG_FIRST_PIPE_INSTANCE = <value>;

  Result := FILE_FLAG_FIRST_PIPE_INSTANCE;
end;

function Windows_REPLACEFILE_WRITE_THROUGH_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const REPLACEFILE_WRITE_THROUGH = <value>;

  Result := REPLACEFILE_WRITE_THROUGH;
end;

function Windows_REPLACEFILE_IGNORE_MERGE_ERRORS_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const REPLACEFILE_IGNORE_MERGE_ERRORS = <value>;

  Result := REPLACEFILE_IGNORE_MERGE_ERRORS;
end;

function Windows_IS_TEXT_UNICODE_ASCII16_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_ASCII16 = <value>;

  Result := IS_TEXT_UNICODE_ASCII16;
end;

function Windows_IS_TEXT_UNICODE_REVERSE_ASCII16_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_REVERSE_ASCII16 = <value>;

  Result := IS_TEXT_UNICODE_REVERSE_ASCII16;
end;

function Windows_IS_TEXT_UNICODE_STATISTICS_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_STATISTICS = <value>;

  Result := IS_TEXT_UNICODE_STATISTICS;
end;

function Windows_IS_TEXT_UNICODE_REVERSE_STATISTICS_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_REVERSE_STATISTICS = <value>;

  Result := IS_TEXT_UNICODE_REVERSE_STATISTICS;
end;

function Windows_IS_TEXT_UNICODE_CONTROLS_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_CONTROLS = <value>;

  Result := IS_TEXT_UNICODE_CONTROLS;
end;

function Windows_IS_TEXT_UNICODE_REVERSE_CONTROLS_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_REVERSE_CONTROLS = <value>;

  Result := IS_TEXT_UNICODE_REVERSE_CONTROLS;
end;

function Windows_IS_TEXT_UNICODE_SIGNATURE_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_SIGNATURE = <value>;

  Result := IS_TEXT_UNICODE_SIGNATURE;
end;

function Windows_IS_TEXT_UNICODE_REVERSE_SIGNATURE_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_REVERSE_SIGNATURE = <value>;

  Result := IS_TEXT_UNICODE_REVERSE_SIGNATURE;
end;

function Windows_IS_TEXT_UNICODE_ILLEGAL_CHARS_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_ILLEGAL_CHARS = <value>;

  Result := IS_TEXT_UNICODE_ILLEGAL_CHARS;
end;

function Windows_IS_TEXT_UNICODE_ODD_LENGTH_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_ODD_LENGTH = <value>;

  Result := IS_TEXT_UNICODE_ODD_LENGTH;
end;

function Windows_IS_TEXT_UNICODE_DBCS_LEADBYTE_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_DBCS_LEADBYTE = <value>;

  Result := IS_TEXT_UNICODE_DBCS_LEADBYTE;
end;

function Windows_IS_TEXT_UNICODE_NULL_BYTES_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_NULL_BYTES = <value>;

  Result := IS_TEXT_UNICODE_NULL_BYTES;
end;

function Windows_IS_TEXT_UNICODE_UNICODE_MASK_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_UNICODE_MASK = <value>;

  Result := IS_TEXT_UNICODE_UNICODE_MASK;
end;

function Windows_IS_TEXT_UNICODE_REVERSE_MASK_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_REVERSE_MASK = <value>;

  Result := IS_TEXT_UNICODE_REVERSE_MASK;
end;

function Windows_IS_TEXT_UNICODE_NOT_UNICODE_MASK_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_NOT_UNICODE_MASK = <value>;

  Result := IS_TEXT_UNICODE_NOT_UNICODE_MASK;
end;

function Windows_IS_TEXT_UNICODE_NOT_ASCII_MASK_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const IS_TEXT_UNICODE_NOT_ASCII_MASK = <value>;

  Result := IS_TEXT_UNICODE_NOT_ASCII_MASK;
end;

function Windows_VER_BUILDNUMBER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VER_BUILDNUMBER = <value>;

  Result := VER_BUILDNUMBER;
end;

function Windows_VER_MAJORVERSION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VER_MAJORVERSION = <value>;

  Result := VER_MAJORVERSION;
end;

function Windows_VER_MINORVERSION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VER_MINORVERSION = <value>;

  Result := VER_MINORVERSION;
end;

function Windows_VER_PLATFORMID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VER_PLATFORMID = <value>;

  Result := VER_PLATFORMID;
end;

function Windows_VER_SERVICEPACKMAJOR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VER_SERVICEPACKMAJOR = <value>;

  Result := VER_SERVICEPACKMAJOR;
end;

function Windows_VER_SERVICEPACKMINOR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VER_SERVICEPACKMINOR = <value>;

  Result := VER_SERVICEPACKMINOR;
end;

function Windows_VER_SUITENAME_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VER_SUITENAME = <value>;

  Result := VER_SUITENAME;
end;

function Windows_VER_PRODUCT_TYPE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const VER_PRODUCT_TYPE = <value>;

  Result := VER_PRODUCT_TYPE;
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

function Windows_SYSRGN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SYSRGN = <value>;

  Result := SYSRGN;
end;

function Windows_DC_STAPLE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DC_STAPLE = <value>;

  Result := DC_STAPLE;
end;

function Windows_DC_PRINTRATEPPM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DC_PRINTRATEPPM = <value>;

  Result := DC_PRINTRATEPPM;
end;

function Windows_DC_MEDIATYPENAMES_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DC_MEDIATYPENAMES = <value>;

  Result := DC_MEDIATYPENAMES;
end;

function Windows_DC_MEDIATYPES_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const DC_MEDIATYPES = <value>;

  Result := DC_MEDIATYPES;
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

function Windows_WH_KEYBOARD_LL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const WH_KEYBOARD_LL = <value>;

  Result := WH_KEYBOARD_LL;
end;

function Windows_WH_MOUSE_LL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const WH_MOUSE_LL = <value>;

  Result := WH_MOUSE_LL;
end;

function Windows_UOI_HEAPSIZE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const UOI_HEAPSIZE = <value>;

  Result := UOI_HEAPSIZE;
end;

function Windows_UOI_IO_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const UOI_IO = <value>;

  Result := UOI_IO;
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

function Windows_MSG_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type MSG = tagMSG;

  Result := TLMDUnitWrapper.TypeToVar(MSG_sw);
end;

function Windows_PBT_POWERSETTINGCHANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const PBT_POWERSETTINGCHANGE = <value>;

  Result := PBT_POWERSETTINGCHANGE;
end;

function Windows_SMTO_ERRORONEXIT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SMTO_ERRORONEXIT = <value>;

  Result := SMTO_ERRORONEXIT;
end;

function Windows_MOD_NOREPEAT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MOD_NOREPEAT = <value>;

  Result := MOD_NOREPEAT;
end;

function Windows_EWX_QUICKRESOLVE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EWX_QUICKRESOLVE = <value>;

  Result := EWX_QUICKRESOLVE;
end;

function Windows_EWX_RESTARTAPPS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EWX_RESTARTAPPS = <value>;

  Result := EWX_RESTARTAPPS;
end;

function Windows_WDA_NONE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const WDA_NONE = <value>;

  Result := WDA_NONE;
end;

function Windows_WDA_MONITOR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const WDA_MONITOR = <value>;

  Result := WDA_MONITOR;
end;

function Windows_KEYEVENTF_UNICODE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const KEYEVENTF_UNICODE = <value>;

  Result := KEYEVENTF_UNICODE;
end;

function Windows_KEYEVENTF_SCANCODE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const KEYEVENTF_SCANCODE = <value>;

  Result := KEYEVENTF_SCANCODE;
end;

function Windows_MOUSEEVENTF_HWHEEL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MOUSEEVENTF_HWHEEL = <value>;

  Result := MOUSEEVENTF_HWHEEL;
end;

function Windows_MOUSEEVENTF_MOVE_NOCOALESCE_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MOUSEEVENTF_MOVE_NOCOALESCE = <value>;

  Result := MOUSEEVENTF_MOVE_NOCOALESCE;
end;

function Windows_TOUCHEVENTF_MOVE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOUCHEVENTF_MOVE = <value>;

  Result := TOUCHEVENTF_MOVE;
end;

function Windows_TOUCHEVENTF_DOWN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOUCHEVENTF_DOWN = <value>;

  Result := TOUCHEVENTF_DOWN;
end;

function Windows_TOUCHEVENTF_UP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOUCHEVENTF_UP = <value>;

  Result := TOUCHEVENTF_UP;
end;

function Windows_TOUCHEVENTF_INRANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOUCHEVENTF_INRANGE = <value>;

  Result := TOUCHEVENTF_INRANGE;
end;

function Windows_TOUCHEVENTF_PRIMARY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOUCHEVENTF_PRIMARY = <value>;

  Result := TOUCHEVENTF_PRIMARY;
end;

function Windows_TOUCHEVENTF_NOCOALESCE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOUCHEVENTF_NOCOALESCE = <value>;

  Result := TOUCHEVENTF_NOCOALESCE;
end;

function Windows_TOUCHEVENTF_PEN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOUCHEVENTF_PEN = <value>;

  Result := TOUCHEVENTF_PEN;
end;

function Windows_TOUCHEVENTF_PALM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOUCHEVENTF_PALM = <value>;

  Result := TOUCHEVENTF_PALM;
end;

function Windows_TOUCHINPUTMASKF_TIMEFROMSYSTEM_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOUCHINPUTMASKF_TIMEFROMSYSTEM = <value>;

  Result := TOUCHINPUTMASKF_TIMEFROMSYSTEM;
end;

function Windows_TOUCHINPUTMASKF_EXTRAINFO_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOUCHINPUTMASKF_EXTRAINFO = <value>;

  Result := TOUCHINPUTMASKF_EXTRAINFO;
end;

function Windows_TOUCHINPUTMASKF_CONTACTAREA_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TOUCHINPUTMASKF_CONTACTAREA = <value>;

  Result := TOUCHINPUTMASKF_CONTACTAREA;
end;

function Windows_TWF_FINETOUCH_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TWF_FINETOUCH = <value>;

  Result := TWF_FINETOUCH;
end;

function Windows_TWF_WANTPALM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TWF_WANTPALM = <value>;

  Result := TWF_WANTPALM;
end;

function Windows_MAPVK_VK_TO_VSC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MAPVK_VK_TO_VSC = <value>;

  Result := MAPVK_VK_TO_VSC;
end;

function Windows_MAPVK_VSC_TO_VK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MAPVK_VSC_TO_VK = <value>;

  Result := MAPVK_VSC_TO_VK;
end;

function Windows_MAPVK_VK_TO_CHAR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MAPVK_VK_TO_CHAR = <value>;

  Result := MAPVK_VK_TO_CHAR;
end;

function Windows_MAPVK_VSC_TO_VK_EX_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MAPVK_VSC_TO_VK_EX = <value>;

  Result := MAPVK_VSC_TO_VK_EX;
end;

function Windows_MAPVK_VK_TO_VSC_EX_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MAPVK_VK_TO_VSC_EX = <value>;

  Result := MAPVK_VK_TO_VSC_EX;
end;

function Windows_SM_TABLETPC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SM_TABLETPC = <value>;

  Result := SM_TABLETPC;
end;

function Windows_SM_MEDIACENTER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SM_MEDIACENTER = <value>;

  Result := SM_MEDIACENTER;
end;

function Windows_SM_STARTER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SM_STARTER = <value>;

  Result := SM_STARTER;
end;

function Windows_SM_SERVERR2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SM_SERVERR2 = <value>;

  Result := SM_SERVERR2;
end;

function Windows_SM_MOUSEHORIZONTALWHEELPRESENT_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SM_MOUSEHORIZONTALWHEELPRESENT = <value>;

  Result := SM_MOUSEHORIZONTALWHEELPRESENT;
end;

function Windows_SM_CXPADDEDBORDER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SM_CXPADDEDBORDER = <value>;

  Result := SM_CXPADDEDBORDER;
end;

function Windows_SM_DIGITIZER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SM_DIGITIZER = <value>;

  Result := SM_DIGITIZER;
end;

function Windows_SM_MAXIMUMTOUCHES_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SM_MAXIMUMTOUCHES = <value>;

  Result := SM_MAXIMUMTOUCHES;
end;

function Windows_SM_SHUTTINGDOWN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SM_SHUTTINGDOWN = <value>;

  Result := SM_SHUTTINGDOWN;
end;

function Windows_SM_REMOTECONTROL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SM_REMOTECONTROL = <value>;

  Result := SM_REMOTECONTROL;
end;

function Windows_SM_CARETBLINKINGENABLED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SM_CARETBLINKINGENABLED = <value>;

  Result := SM_CARETBLINKINGENABLED;
end;

function Windows_TPM_LAYOUTRTL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TPM_LAYOUTRTL = <value>;

  Result := TPM_LAYOUTRTL;
end;

function Windows_TPM_WORKAREA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const TPM_WORKAREA = <value>;

  Result := TPM_WORKAREA;
end;

function Windows_SCF_ISSECURE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SCF_ISSECURE = <value>;

  Result := SCF_ISSECURE;
end;

function Windows_OIC_SHIELD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const OIC_SHIELD = <value>;

  Result := OIC_SHIELD;
end;

function Windows_GR_GDIOBJECTS_PEAK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GR_GDIOBJECTS_PEAK = <value>;

  Result := GR_GDIOBJECTS_PEAK;
end;

function Windows_GR_USEROBJECTS_PEAK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GR_USEROBJECTS_PEAK = <value>;

  Result := GR_USEROBJECTS_PEAK;
end;

function Windows_SPI_SETSCREENSAVERRUNNING_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETSCREENSAVERRUNNING = <value>;

  Result := SPI_SETSCREENSAVERRUNNING;
end;

function Windows_SPI_GETWHEELSCROLLCHARS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETWHEELSCROLLCHARS = <value>;

  Result := SPI_GETWHEELSCROLLCHARS;
end;

function Windows_SPI_SETWHEELSCROLLCHARS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETWHEELSCROLLCHARS = <value>;

  Result := SPI_SETWHEELSCROLLCHARS;
end;

function Windows_SPI_GETDESKWALLPAPER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETDESKWALLPAPER = <value>;

  Result := SPI_GETDESKWALLPAPER;
end;

function Windows_SPI_GETAUDIODESCRIPTION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETAUDIODESCRIPTION = <value>;

  Result := SPI_GETAUDIODESCRIPTION;
end;

function Windows_SPI_SETAUDIODESCRIPTION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETAUDIODESCRIPTION = <value>;

  Result := SPI_SETAUDIODESCRIPTION;
end;

function Windows_SPI_GETSCREENSAVESECURE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETSCREENSAVESECURE = <value>;

  Result := SPI_GETSCREENSAVESECURE;
end;

function Windows_SPI_SETSCREENSAVESECURE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETSCREENSAVESECURE = <value>;

  Result := SPI_SETSCREENSAVESECURE;
end;

function Windows_SPI_GETHUNGAPPTIMEOUT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETHUNGAPPTIMEOUT = <value>;

  Result := SPI_GETHUNGAPPTIMEOUT;
end;

function Windows_SPI_SETHUNGAPPTIMEOUT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETHUNGAPPTIMEOUT = <value>;

  Result := SPI_SETHUNGAPPTIMEOUT;
end;

function Windows_SPI_GETWAITTOKILLTIMEOUT_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETWAITTOKILLTIMEOUT = <value>;

  Result := SPI_GETWAITTOKILLTIMEOUT;
end;

function Windows_SPI_SETWAITTOKILLTIMEOUT_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETWAITTOKILLTIMEOUT = <value>;

  Result := SPI_SETWAITTOKILLTIMEOUT;
end;

function Windows_SPI_GETWAITTOKILLSERVICETIMEOUT_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETWAITTOKILLSERVICETIMEOUT = <value>;

  Result := SPI_GETWAITTOKILLSERVICETIMEOUT;
end;

function Windows_SPI_SETWAITTOKILLSERVICETIMEOUT_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETWAITTOKILLSERVICETIMEOUT = <value>;

  Result := SPI_SETWAITTOKILLSERVICETIMEOUT;
end;

function Windows_SPI_GETMOUSEDOCKTHRESHOLD_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETMOUSEDOCKTHRESHOLD = <value>;

  Result := SPI_GETMOUSEDOCKTHRESHOLD;
end;

function Windows_SPI_SETMOUSEDOCKTHRESHOLD_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETMOUSEDOCKTHRESHOLD = <value>;

  Result := SPI_SETMOUSEDOCKTHRESHOLD;
end;

function Windows_SPI_GETPENDOCKTHRESHOLD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETPENDOCKTHRESHOLD = <value>;

  Result := SPI_GETPENDOCKTHRESHOLD;
end;

function Windows_SPI_SETPENDOCKTHRESHOLD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETPENDOCKTHRESHOLD = <value>;

  Result := SPI_SETPENDOCKTHRESHOLD;
end;

function Windows_SPI_GETWINARRANGING_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETWINARRANGING = <value>;

  Result := SPI_GETWINARRANGING;
end;

function Windows_SPI_SETWINARRANGING_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETWINARRANGING = <value>;

  Result := SPI_SETWINARRANGING;
end;

function Windows_SPI_GETMOUSEDRAGOUTTHRESHOLD_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETMOUSEDRAGOUTTHRESHOLD = <value>;

  Result := SPI_GETMOUSEDRAGOUTTHRESHOLD;
end;

function Windows_SPI_SETMOUSEDRAGOUTTHRESHOLD_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETMOUSEDRAGOUTTHRESHOLD = <value>;

  Result := SPI_SETMOUSEDRAGOUTTHRESHOLD;
end;

function Windows_SPI_GETPENDRAGOUTTHRESHOLD_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETPENDRAGOUTTHRESHOLD = <value>;

  Result := SPI_GETPENDRAGOUTTHRESHOLD;
end;

function Windows_SPI_SETPENDRAGOUTTHRESHOLD_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETPENDRAGOUTTHRESHOLD = <value>;

  Result := SPI_SETPENDRAGOUTTHRESHOLD;
end;

function Windows_SPI_GETMOUSESIDEMOVETHRESHOLD_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETMOUSESIDEMOVETHRESHOLD = <value>;

  Result := SPI_GETMOUSESIDEMOVETHRESHOLD;
end;

function Windows_SPI_SETMOUSESIDEMOVETHRESHOLD_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETMOUSESIDEMOVETHRESHOLD = <value>;

  Result := SPI_SETMOUSESIDEMOVETHRESHOLD;
end;

function Windows_SPI_GETPENSIDEMOVETHRESHOLD_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETPENSIDEMOVETHRESHOLD = <value>;

  Result := SPI_GETPENSIDEMOVETHRESHOLD;
end;

function Windows_SPI_SETPENSIDEMOVETHRESHOLD_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETPENSIDEMOVETHRESHOLD = <value>;

  Result := SPI_SETPENSIDEMOVETHRESHOLD;
end;

function Windows_SPI_GETDRAGFROMMAXIMIZE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETDRAGFROMMAXIMIZE = <value>;

  Result := SPI_GETDRAGFROMMAXIMIZE;
end;

function Windows_SPI_SETDRAGFROMMAXIMIZE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETDRAGFROMMAXIMIZE = <value>;

  Result := SPI_SETDRAGFROMMAXIMIZE;
end;

function Windows_SPI_GETSNAPSIZING_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETSNAPSIZING = <value>;

  Result := SPI_GETSNAPSIZING;
end;

function Windows_SPI_SETSNAPSIZING_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETSNAPSIZING = <value>;

  Result := SPI_SETSNAPSIZING;
end;

function Windows_SPI_GETDOCKMOVING_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETDOCKMOVING = <value>;

  Result := SPI_GETDOCKMOVING;
end;

function Windows_SPI_SETDOCKMOVING_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETDOCKMOVING = <value>;

  Result := SPI_SETDOCKMOVING;
end;

function Windows_SPI_GETBLOCKSENDINPUTRESETS_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETBLOCKSENDINPUTRESETS = <value>;

  Result := SPI_GETBLOCKSENDINPUTRESETS;
end;

function Windows_SPI_SETBLOCKSENDINPUTRESETS_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETBLOCKSENDINPUTRESETS = <value>;

  Result := SPI_SETBLOCKSENDINPUTRESETS;
end;

function Windows_SPI_GETDISABLEOVERLAPPEDCONTENT_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETDISABLEOVERLAPPEDCONTENT = <value>;

  Result := SPI_GETDISABLEOVERLAPPEDCONTENT;
end;

function Windows_SPI_SETDISABLEOVERLAPPEDCONTENT_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETDISABLEOVERLAPPEDCONTENT = <value>;

  Result := SPI_SETDISABLEOVERLAPPEDCONTENT;
end;

function Windows_SPI_GETCLIENTAREAANIMATION_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETCLIENTAREAANIMATION = <value>;

  Result := SPI_GETCLIENTAREAANIMATION;
end;

function Windows_SPI_SETCLIENTAREAANIMATION_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETCLIENTAREAANIMATION = <value>;

  Result := SPI_SETCLIENTAREAANIMATION;
end;

function Windows_SPI_GETCLEARTYPE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETCLEARTYPE = <value>;

  Result := SPI_GETCLEARTYPE;
end;

function Windows_SPI_SETCLEARTYPE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETCLEARTYPE = <value>;

  Result := SPI_SETCLEARTYPE;
end;

function Windows_SPI_GETSPEECHRECOGNITION_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETSPEECHRECOGNITION = <value>;

  Result := SPI_GETSPEECHRECOGNITION;
end;

function Windows_SPI_SETSPEECHRECOGNITION_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETSPEECHRECOGNITION = <value>;

  Result := SPI_SETSPEECHRECOGNITION;
end;

function Windows_SPI_GETFONTSMOOTHINGORIENTATION_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETFONTSMOOTHINGORIENTATION = <value>;

  Result := SPI_GETFONTSMOOTHINGORIENTATION;
end;

function Windows_SPI_SETFONTSMOOTHINGORIENTATION_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETFONTSMOOTHINGORIENTATION = <value>;

  Result := SPI_SETFONTSMOOTHINGORIENTATION;
end;

function Windows_FE_FONTSMOOTHINGORIENTATIONBGR_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const FE_FONTSMOOTHINGORIENTATIONBGR = <value>;

  Result := FE_FONTSMOOTHINGORIENTATIONBGR;
end;

function Windows_FE_FONTSMOOTHINGORIENTATIONRGB_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const FE_FONTSMOOTHINGORIENTATIONRGB = <value>;

  Result := FE_FONTSMOOTHINGORIENTATIONRGB;
end;

function Windows_SPI_GETMINIMUMHITRADIUS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETMINIMUMHITRADIUS = <value>;

  Result := SPI_GETMINIMUMHITRADIUS;
end;

function Windows_SPI_SETMINIMUMHITRADIUS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETMINIMUMHITRADIUS = <value>;

  Result := SPI_SETMINIMUMHITRADIUS;
end;

function Windows_SPI_GETMESSAGEDURATION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_GETMESSAGEDURATION = <value>;

  Result := SPI_GETMESSAGEDURATION;
end;

function Windows_SPI_SETMESSAGEDURATION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SPI_SETMESSAGEDURATION = <value>;

  Result := SPI_SETMESSAGEDURATION;
end;

function Windows_HCF_LOGONDESKTOP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const HCF_LOGONDESKTOP = <value>;

  Result := HCF_LOGONDESKTOP;
end;

function Windows_HCF_DEFAULTDESKTOP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const HCF_DEFAULTDESKTOP = <value>;

  Result := HCF_DEFAULTDESKTOP;
end;

function Windows_CDS_VIDEOPARAMETERS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CDS_VIDEOPARAMETERS = <value>;

  Result := CDS_VIDEOPARAMETERS;
end;

function Windows_CDS_ENABLE_UNSAFE_MODES_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CDS_ENABLE_UNSAFE_MODES = <value>;

  Result := CDS_ENABLE_UNSAFE_MODES;
end;

function Windows_CDS_DISABLE_UNSAFE_MODES_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CDS_DISABLE_UNSAFE_MODES = <value>;

  Result := CDS_DISABLE_UNSAFE_MODES;
end;

function Windows_CDS_RESET_EX_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CDS_RESET_EX = <value>;

  Result := CDS_RESET_EX;
end;

function Windows_EDD_GET_DEVICE_INTERFACE_NAME_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EDD_GET_DEVICE_INTERFACE_NAME = <value>;

  Result := EDD_GET_DEVICE_INTERFACE_NAME;
end;

function Windows_EVENT_SYSTEM_DESKTOPSWITCH_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_SYSTEM_DESKTOPSWITCH = <value>;

  Result := EVENT_SYSTEM_DESKTOPSWITCH;
end;

function Windows_EVENT_SYSTEM_END_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_SYSTEM_END = <value>;

  Result := EVENT_SYSTEM_END;
end;

function Windows_EVENT_OEM_DEFINED_START_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_OEM_DEFINED_START = <value>;

  Result := EVENT_OEM_DEFINED_START;
end;

function Windows_EVENT_OEM_DEFINED_END_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_OEM_DEFINED_END = <value>;

  Result := EVENT_OEM_DEFINED_END;
end;

function Windows_EVENT_UIA_EVENTID_START_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_UIA_EVENTID_START = <value>;

  Result := EVENT_UIA_EVENTID_START;
end;

function Windows_EVENT_UIA_EVENTID_END_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_UIA_EVENTID_END = <value>;

  Result := EVENT_UIA_EVENTID_END;
end;

function Windows_EVENT_UIA_PROPID_START_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_UIA_PROPID_START = <value>;

  Result := EVENT_UIA_PROPID_START;
end;

function Windows_EVENT_UIA_PROPID_END_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_UIA_PROPID_END = <value>;

  Result := EVENT_UIA_PROPID_END;
end;

function Windows_EVENT_CONSOLE_CARET_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_CONSOLE_CARET = <value>;

  Result := EVENT_CONSOLE_CARET;
end;

function Windows_EVENT_CONSOLE_UPDATE_REGION_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_CONSOLE_UPDATE_REGION = <value>;

  Result := EVENT_CONSOLE_UPDATE_REGION;
end;

function Windows_EVENT_CONSOLE_UPDATE_SIMPLE_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_CONSOLE_UPDATE_SIMPLE = <value>;

  Result := EVENT_CONSOLE_UPDATE_SIMPLE;
end;

function Windows_EVENT_CONSOLE_UPDATE_SCROLL_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_CONSOLE_UPDATE_SCROLL = <value>;

  Result := EVENT_CONSOLE_UPDATE_SCROLL;
end;

function Windows_EVENT_CONSOLE_LAYOUT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_CONSOLE_LAYOUT = <value>;

  Result := EVENT_CONSOLE_LAYOUT;
end;

function Windows_EVENT_CONSOLE_START_APPLICATION_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_CONSOLE_START_APPLICATION = <value>;

  Result := EVENT_CONSOLE_START_APPLICATION;
end;

function Windows_EVENT_CONSOLE_END_APPLICATION_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_CONSOLE_END_APPLICATION = <value>;

  Result := EVENT_CONSOLE_END_APPLICATION;
end;

function Windows_CONSOLE_APPLICATION_16BIT_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CONSOLE_APPLICATION_16BIT = <value>;

  Result := CONSOLE_APPLICATION_16BIT;
end;

function Windows_CONSOLE_CARET_SELECTION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CONSOLE_CARET_SELECTION = <value>;

  Result := CONSOLE_CARET_SELECTION;
end;

function Windows_CONSOLE_CARET_VISIBLE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CONSOLE_CARET_VISIBLE = <value>;

  Result := CONSOLE_CARET_VISIBLE;
end;

function Windows_EVENT_CONSOLE_END_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_CONSOLE_END = <value>;

  Result := EVENT_CONSOLE_END;
end;

function Windows_EVENT_OBJECT_INVOKED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_OBJECT_INVOKED = <value>;

  Result := EVENT_OBJECT_INVOKED;
end;

function Windows_EVENT_OBJECT_TEXTSELECTIONCHANGED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_OBJECT_TEXTSELECTIONCHANGED = <value>;

  Result := EVENT_OBJECT_TEXTSELECTIONCHANGED;
end;

function Windows_EVENT_OBJECT_CONTENTSCROLLED_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_OBJECT_CONTENTSCROLLED = <value>;

  Result := EVENT_OBJECT_CONTENTSCROLLED;
end;

function Windows_EVENT_SYSTEM_ARRANGMENTPREVIEW_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_SYSTEM_ARRANGMENTPREVIEW = <value>;

  Result := EVENT_SYSTEM_ARRANGMENTPREVIEW;
end;

function Windows_EVENT_OBJECT_END_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_OBJECT_END = <value>;

  Result := EVENT_OBJECT_END;
end;

function Windows_EVENT_AIA_START_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_AIA_START = <value>;

  Result := EVENT_AIA_START;
end;

function Windows_EVENT_AIA_END_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const EVENT_AIA_END = <value>;

  Result := EVENT_AIA_END;
end;

function Windows_GUI_16BITTASK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GUI_16BITTASK = <value>;

  Result := GUI_16BITTASK;
end;

function Windows_USER_DEFAULT_SCREEN_DPI_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const USER_DEFAULT_SCREEN_DPI = <value>;

  Result := USER_DEFAULT_SCREEN_DPI;
end;

function Windows_MB_ERR_INVALID_CHARS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MB_ERR_INVALID_CHARS = <value>;

  Result := MB_ERR_INVALID_CHARS;
end;

function Windows_WC_NO_BEST_FIT_CHARS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const WC_NO_BEST_FIT_CHARS = <value>;

  Result := WC_NO_BEST_FIT_CHARS;
end;

function Windows_WC_ERR_INVALID_CHARS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const WC_ERR_INVALID_CHARS = <value>;

  Result := WC_ERR_INVALID_CHARS;
end;

function Windows_GWLP_WNDPROC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GWLP_WNDPROC = <value>;

  Result := GWLP_WNDPROC;
end;

function Windows_GWLP_HINSTANCE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GWLP_HINSTANCE = <value>;

  Result := GWLP_HINSTANCE;
end;

function Windows_GWLP_HWNDPARENT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GWLP_HWNDPARENT = <value>;

  Result := GWLP_HWNDPARENT;
end;

function Windows_GWLP_USERDATA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GWLP_USERDATA = <value>;

  Result := GWLP_USERDATA;
end;

function Windows_GWLP_ID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GWLP_ID = <value>;

  Result := GWLP_ID;
end;

function Windows_GF_BEGIN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GF_BEGIN = <value>;

  Result := GF_BEGIN;
end;

function Windows_GF_INERTIA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GF_INERTIA = <value>;

  Result := GF_INERTIA;
end;

function Windows_GF_END_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GF_END = <value>;

  Result := GF_END;
end;

function Windows_GID_BEGIN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GID_BEGIN = <value>;

  Result := GID_BEGIN;
end;

function Windows_GID_END_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GID_END = <value>;

  Result := GID_END;
end;

function Windows_GID_ZOOM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GID_ZOOM = <value>;

  Result := GID_ZOOM;
end;

function Windows_GID_PAN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GID_PAN = <value>;

  Result := GID_PAN;
end;

function Windows_GID_ROTATE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GID_ROTATE = <value>;

  Result := GID_ROTATE;
end;

function Windows_GID_TWOFINGERTAP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GID_TWOFINGERTAP = <value>;

  Result := GID_TWOFINGERTAP;
end;

function Windows_GID_PRESSANDTAP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GID_PRESSANDTAP = <value>;

  Result := GID_PRESSANDTAP;
end;

function Windows_GC_ALLGESTURES_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GC_ALLGESTURES = <value>;

  Result := GC_ALLGESTURES;
end;

function Windows_GC_ZOOM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GC_ZOOM = <value>;

  Result := GC_ZOOM;
end;

function Windows_GC_PAN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GC_PAN = <value>;

  Result := GC_PAN;
end;

function Windows_GC_PAN_WITH_SINGLE_FINGER_VERTICALLY_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GC_PAN_WITH_SINGLE_FINGER_VERTICALLY = <value>;

  Result := GC_PAN_WITH_SINGLE_FINGER_VERTICALLY;
end;

function Windows_GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY = <value>;

  Result := GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY;
end;

function Windows_GC_PAN_WITH_GUTTER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GC_PAN_WITH_GUTTER = <value>;

  Result := GC_PAN_WITH_GUTTER;
end;

function Windows_GC_PAN_WITH_INERTIA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GC_PAN_WITH_INERTIA = <value>;

  Result := GC_PAN_WITH_INERTIA;
end;

function Windows_GC_ROTATE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GC_ROTATE = <value>;

  Result := GC_ROTATE;
end;

function Windows_GC_TWOFINGERTAP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GC_TWOFINGERTAP = <value>;

  Result := GC_TWOFINGERTAP;
end;

function Windows_GC_PRESSANDTAP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GC_PRESSANDTAP = <value>;

  Result := GC_PRESSANDTAP;
end;

function Windows_GESTURECONFIGMAXCOUNT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GESTURECONFIGMAXCOUNT = <value>;

  Result := GESTURECONFIGMAXCOUNT;
end;

function Windows_GCF_INCLUDE_ANCESTORS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const GCF_INCLUDE_ANCESTORS = <value>;

  Result := GCF_INCLUDE_ANCESTORS;
end;

function Windows_NID_INTEGRATED_TOUCH_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const NID_INTEGRATED_TOUCH = <value>;

  Result := NID_INTEGRATED_TOUCH;
end;

function Windows_NID_EXTERNAL_TOUCH_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const NID_EXTERNAL_TOUCH = <value>;

  Result := NID_EXTERNAL_TOUCH;
end;

function Windows_NID_INTEGRATED_PEN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const NID_INTEGRATED_PEN = <value>;

  Result := NID_INTEGRATED_PEN;
end;

function Windows_NID_EXTERNAL_PEN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const NID_EXTERNAL_PEN = <value>;

  Result := NID_EXTERNAL_PEN;
end;

function Windows_NID_MULTI_INPUT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const NID_MULTI_INPUT = <value>;

  Result := NID_MULTI_INPUT;
end;

function Windows_NID_READY_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const NID_READY = <value>;

  Result := NID_READY;
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
  AData.AddType(USHORT_sw, Windows_USHORT_si);
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
  AData.AddType(HANDLE_PTR_sw, Windows_HANDLE_PTR_si);
  AData.AddType(LONGLONG_sw, Windows_LONGLONG_si);
  AData.AddConstant('LANG_INVARIANT', Windows_LANG_INVARIANT_si, nil, VarType(Windows.LANG_INVARIANT));
  AData.AddConstant('SUBLANG_CUSTOM_DEFAULT', Windows_SUBLANG_CUSTOM_DEFAULT_si, nil, VarType(Windows.SUBLANG_CUSTOM_DEFAULT));
  AData.AddConstant('SUBLANG_CUSTOM_UNSPECIFIED', Windows_SUBLANG_CUSTOM_UNSPECIFIED_si, nil, VarType(Windows.SUBLANG_CUSTOM_UNSPECIFIED));
  AData.AddConstant('SUBLANG_UI_CUSTOM_DEFAULT', Windows_SUBLANG_UI_CUSTOM_DEFAULT_si, nil, VarType(Windows.SUBLANG_UI_CUSTOM_DEFAULT));
  AData.AddConstant('LOCALE_NAME_MAX_LENGTH', Windows_LOCALE_NAME_MAX_LENGTH_si, nil, VarType(Windows.LOCALE_NAME_MAX_LENGTH));
  AData.AddConstant('NLS_VALID_LOCALE_MASK', Windows_NLS_VALID_LOCALE_MASK_si, nil, VarType(Windows.NLS_VALID_LOCALE_MASK));
  AData.AddConstant('FILE_ATTRIBUTE_VIRTUAL', Windows_FILE_ATTRIBUTE_VIRTUAL_si, nil, VarType(Windows.FILE_ATTRIBUTE_VIRTUAL));
  AData.AddType(_LUID_sw, Windows__LUID_si);
  AData.AddType(TLUID_sw, Windows_TLUID_si);
  AData.AddType(LUID_sw, Windows_LUID_si);
  AData.AddConstant('TOKEN_SOURCE_LENGTH', Windows_TOKEN_SOURCE_LENGTH_si, nil, VarType(Windows.TOKEN_SOURCE_LENGTH));
  AData.AddConstant('POLICY_AUDIT_SUBCATEGORY_COUNT', Windows_POLICY_AUDIT_SUBCATEGORY_COUNT_si, nil, VarType(Windows.POLICY_AUDIT_SUBCATEGORY_COUNT));
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
  AData.AddType(VARIANT_BOOL_sw, Windows_VARIANT_BOOL_si);
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
  AData.AddConstant('FILE_FLAG_FIRST_PIPE_INSTANCE', Windows_FILE_FLAG_FIRST_PIPE_INSTANCE_si, nil, VarType(Windows.FILE_FLAG_FIRST_PIPE_INSTANCE));
  AData.AddConstant('REPLACEFILE_WRITE_THROUGH', Windows_REPLACEFILE_WRITE_THROUGH_si, nil, VarType(Windows.REPLACEFILE_WRITE_THROUGH));
  AData.AddConstant('REPLACEFILE_IGNORE_MERGE_ERRORS', Windows_REPLACEFILE_IGNORE_MERGE_ERRORS_si, nil, VarType(Windows.REPLACEFILE_IGNORE_MERGE_ERRORS));
  AData.AddConstant('IS_TEXT_UNICODE_ASCII16', Windows_IS_TEXT_UNICODE_ASCII16_si, nil, VarType(Windows.IS_TEXT_UNICODE_ASCII16));
  AData.AddConstant('IS_TEXT_UNICODE_REVERSE_ASCII16', Windows_IS_TEXT_UNICODE_REVERSE_ASCII16_si, nil, VarType(Windows.IS_TEXT_UNICODE_REVERSE_ASCII16));
  AData.AddConstant('IS_TEXT_UNICODE_STATISTICS', Windows_IS_TEXT_UNICODE_STATISTICS_si, nil, VarType(Windows.IS_TEXT_UNICODE_STATISTICS));
  AData.AddConstant('IS_TEXT_UNICODE_REVERSE_STATISTICS', Windows_IS_TEXT_UNICODE_REVERSE_STATISTICS_si, nil, VarType(Windows.IS_TEXT_UNICODE_REVERSE_STATISTICS));
  AData.AddConstant('IS_TEXT_UNICODE_CONTROLS', Windows_IS_TEXT_UNICODE_CONTROLS_si, nil, VarType(Windows.IS_TEXT_UNICODE_CONTROLS));
  AData.AddConstant('IS_TEXT_UNICODE_REVERSE_CONTROLS', Windows_IS_TEXT_UNICODE_REVERSE_CONTROLS_si, nil, VarType(Windows.IS_TEXT_UNICODE_REVERSE_CONTROLS));
  AData.AddConstant('IS_TEXT_UNICODE_SIGNATURE', Windows_IS_TEXT_UNICODE_SIGNATURE_si, nil, VarType(Windows.IS_TEXT_UNICODE_SIGNATURE));
  AData.AddConstant('IS_TEXT_UNICODE_REVERSE_SIGNATURE', Windows_IS_TEXT_UNICODE_REVERSE_SIGNATURE_si, nil, VarType(Windows.IS_TEXT_UNICODE_REVERSE_SIGNATURE));
  AData.AddConstant('IS_TEXT_UNICODE_ILLEGAL_CHARS', Windows_IS_TEXT_UNICODE_ILLEGAL_CHARS_si, nil, VarType(Windows.IS_TEXT_UNICODE_ILLEGAL_CHARS));
  AData.AddConstant('IS_TEXT_UNICODE_ODD_LENGTH', Windows_IS_TEXT_UNICODE_ODD_LENGTH_si, nil, VarType(Windows.IS_TEXT_UNICODE_ODD_LENGTH));
  AData.AddConstant('IS_TEXT_UNICODE_DBCS_LEADBYTE', Windows_IS_TEXT_UNICODE_DBCS_LEADBYTE_si, nil, VarType(Windows.IS_TEXT_UNICODE_DBCS_LEADBYTE));
  AData.AddConstant('IS_TEXT_UNICODE_NULL_BYTES', Windows_IS_TEXT_UNICODE_NULL_BYTES_si, nil, VarType(Windows.IS_TEXT_UNICODE_NULL_BYTES));
  AData.AddConstant('IS_TEXT_UNICODE_UNICODE_MASK', Windows_IS_TEXT_UNICODE_UNICODE_MASK_si, nil, VarType(Windows.IS_TEXT_UNICODE_UNICODE_MASK));
  AData.AddConstant('IS_TEXT_UNICODE_REVERSE_MASK', Windows_IS_TEXT_UNICODE_REVERSE_MASK_si, nil, VarType(Windows.IS_TEXT_UNICODE_REVERSE_MASK));
  AData.AddConstant('IS_TEXT_UNICODE_NOT_UNICODE_MASK', Windows_IS_TEXT_UNICODE_NOT_UNICODE_MASK_si, nil, VarType(Windows.IS_TEXT_UNICODE_NOT_UNICODE_MASK));
  AData.AddConstant('IS_TEXT_UNICODE_NOT_ASCII_MASK', Windows_IS_TEXT_UNICODE_NOT_ASCII_MASK_si, nil, VarType(Windows.IS_TEXT_UNICODE_NOT_ASCII_MASK));
  AData.AddConstant('VER_BUILDNUMBER', Windows_VER_BUILDNUMBER_si, nil, VarType(Windows.VER_BUILDNUMBER));
  AData.AddConstant('VER_MAJORVERSION', Windows_VER_MAJORVERSION_si, nil, VarType(Windows.VER_MAJORVERSION));
  AData.AddConstant('VER_MINORVERSION', Windows_VER_MINORVERSION_si, nil, VarType(Windows.VER_MINORVERSION));
  AData.AddConstant('VER_PLATFORMID', Windows_VER_PLATFORMID_si, nil, VarType(Windows.VER_PLATFORMID));
  AData.AddConstant('VER_SERVICEPACKMAJOR', Windows_VER_SERVICEPACKMAJOR_si, nil, VarType(Windows.VER_SERVICEPACKMAJOR));
  AData.AddConstant('VER_SERVICEPACKMINOR', Windows_VER_SERVICEPACKMINOR_si, nil, VarType(Windows.VER_SERVICEPACKMINOR));
  AData.AddConstant('VER_SUITENAME', Windows_VER_SUITENAME_si, nil, VarType(Windows.VER_SUITENAME));
  AData.AddConstant('VER_PRODUCT_TYPE', Windows_VER_PRODUCT_TYPE_si, nil, VarType(Windows.VER_PRODUCT_TYPE));
  AData.AddConstant('S_OK', Windows_S_OK_si, nil, VarType(Windows.S_OK));
  AData.AddConstant('S_FALSE', Windows_S_FALSE_si, nil, VarType(Windows.S_FALSE));
  AData.AddConstant('SYSRGN', Windows_SYSRGN_si, nil, VarType(Windows.SYSRGN));
  AData.AddConstant('DC_STAPLE', Windows_DC_STAPLE_si, nil, VarType(Windows.DC_STAPLE));
  AData.AddConstant('DC_PRINTRATEPPM', Windows_DC_PRINTRATEPPM_si, nil, VarType(Windows.DC_PRINTRATEPPM));
  AData.AddConstant('DC_MEDIATYPENAMES', Windows_DC_MEDIATYPENAMES_si, nil, VarType(Windows.DC_MEDIATYPENAMES));
  AData.AddConstant('DC_MEDIATYPES', Windows_DC_MEDIATYPES_si, nil, VarType(Windows.DC_MEDIATYPES));
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
  AData.AddConstant('WH_KEYBOARD_LL', Windows_WH_KEYBOARD_LL_si, nil, VarType(Windows.WH_KEYBOARD_LL));
  AData.AddConstant('WH_MOUSE_LL', Windows_WH_MOUSE_LL_si, nil, VarType(Windows.WH_MOUSE_LL));
  AData.AddConstant('UOI_HEAPSIZE', Windows_UOI_HEAPSIZE_si, nil, VarType(Windows.UOI_HEAPSIZE));
  AData.AddConstant('UOI_IO', Windows_UOI_IO_si, nil, VarType(Windows.UOI_IO));
  AData.AddType(tagMSG_sw, Windows_tagMSG_si);
  AData.AddType(TMsg_sw, Windows_TMsg_si);
  AData.AddType(MSG_sw, Windows_MSG_si);
  AData.AddConstant('PBT_POWERSETTINGCHANGE', Windows_PBT_POWERSETTINGCHANGE_si, nil, VarType(Windows.PBT_POWERSETTINGCHANGE));
  AData.AddConstant('SMTO_ERRORONEXIT', Windows_SMTO_ERRORONEXIT_si, nil, VarType(Windows.SMTO_ERRORONEXIT));
  AData.AddConstant('MOD_NOREPEAT', Windows_MOD_NOREPEAT_si, nil, VarType(Windows.MOD_NOREPEAT));
  AData.AddConstant('EWX_QUICKRESOLVE', Windows_EWX_QUICKRESOLVE_si, nil, VarType(Windows.EWX_QUICKRESOLVE));
  AData.AddConstant('EWX_RESTARTAPPS', Windows_EWX_RESTARTAPPS_si, nil, VarType(Windows.EWX_RESTARTAPPS));
  AData.AddConstant('WDA_NONE', Windows_WDA_NONE_si, nil, VarType(Windows.WDA_NONE));
  AData.AddConstant('WDA_MONITOR', Windows_WDA_MONITOR_si, nil, VarType(Windows.WDA_MONITOR));
  AData.AddConstant('KEYEVENTF_UNICODE', Windows_KEYEVENTF_UNICODE_si, nil, VarType(Windows.KEYEVENTF_UNICODE));
  AData.AddConstant('KEYEVENTF_SCANCODE', Windows_KEYEVENTF_SCANCODE_si, nil, VarType(Windows.KEYEVENTF_SCANCODE));
  AData.AddConstant('MOUSEEVENTF_HWHEEL', Windows_MOUSEEVENTF_HWHEEL_si, nil, VarType(Windows.MOUSEEVENTF_HWHEEL));
  AData.AddConstant('MOUSEEVENTF_MOVE_NOCOALESCE', Windows_MOUSEEVENTF_MOVE_NOCOALESCE_si, nil, VarType(Windows.MOUSEEVENTF_MOVE_NOCOALESCE));
  AData.AddConstant('TOUCHEVENTF_MOVE', Windows_TOUCHEVENTF_MOVE_si, nil, VarType(Windows.TOUCHEVENTF_MOVE));
  AData.AddConstant('TOUCHEVENTF_DOWN', Windows_TOUCHEVENTF_DOWN_si, nil, VarType(Windows.TOUCHEVENTF_DOWN));
  AData.AddConstant('TOUCHEVENTF_UP', Windows_TOUCHEVENTF_UP_si, nil, VarType(Windows.TOUCHEVENTF_UP));
  AData.AddConstant('TOUCHEVENTF_INRANGE', Windows_TOUCHEVENTF_INRANGE_si, nil, VarType(Windows.TOUCHEVENTF_INRANGE));
  AData.AddConstant('TOUCHEVENTF_PRIMARY', Windows_TOUCHEVENTF_PRIMARY_si, nil, VarType(Windows.TOUCHEVENTF_PRIMARY));
  AData.AddConstant('TOUCHEVENTF_NOCOALESCE', Windows_TOUCHEVENTF_NOCOALESCE_si, nil, VarType(Windows.TOUCHEVENTF_NOCOALESCE));
  AData.AddConstant('TOUCHEVENTF_PEN', Windows_TOUCHEVENTF_PEN_si, nil, VarType(Windows.TOUCHEVENTF_PEN));
  AData.AddConstant('TOUCHEVENTF_PALM', Windows_TOUCHEVENTF_PALM_si, nil, VarType(Windows.TOUCHEVENTF_PALM));
  AData.AddConstant('TOUCHINPUTMASKF_TIMEFROMSYSTEM', Windows_TOUCHINPUTMASKF_TIMEFROMSYSTEM_si, nil, VarType(Windows.TOUCHINPUTMASKF_TIMEFROMSYSTEM));
  AData.AddConstant('TOUCHINPUTMASKF_EXTRAINFO', Windows_TOUCHINPUTMASKF_EXTRAINFO_si, nil, VarType(Windows.TOUCHINPUTMASKF_EXTRAINFO));
  AData.AddConstant('TOUCHINPUTMASKF_CONTACTAREA', Windows_TOUCHINPUTMASKF_CONTACTAREA_si, nil, VarType(Windows.TOUCHINPUTMASKF_CONTACTAREA));
  AData.AddConstant('TWF_FINETOUCH', Windows_TWF_FINETOUCH_si, nil, VarType(Windows.TWF_FINETOUCH));
  AData.AddConstant('TWF_WANTPALM', Windows_TWF_WANTPALM_si, nil, VarType(Windows.TWF_WANTPALM));
  AData.AddConstant('MAPVK_VK_TO_VSC', Windows_MAPVK_VK_TO_VSC_si, nil, VarType(Windows.MAPVK_VK_TO_VSC));
  AData.AddConstant('MAPVK_VSC_TO_VK', Windows_MAPVK_VSC_TO_VK_si, nil, VarType(Windows.MAPVK_VSC_TO_VK));
  AData.AddConstant('MAPVK_VK_TO_CHAR', Windows_MAPVK_VK_TO_CHAR_si, nil, VarType(Windows.MAPVK_VK_TO_CHAR));
  AData.AddConstant('MAPVK_VSC_TO_VK_EX', Windows_MAPVK_VSC_TO_VK_EX_si, nil, VarType(Windows.MAPVK_VSC_TO_VK_EX));
  AData.AddConstant('MAPVK_VK_TO_VSC_EX', Windows_MAPVK_VK_TO_VSC_EX_si, nil, VarType(Windows.MAPVK_VK_TO_VSC_EX));
  AData.AddConstant('SM_TABLETPC', Windows_SM_TABLETPC_si, nil, VarType(Windows.SM_TABLETPC));
  AData.AddConstant('SM_MEDIACENTER', Windows_SM_MEDIACENTER_si, nil, VarType(Windows.SM_MEDIACENTER));
  AData.AddConstant('SM_STARTER', Windows_SM_STARTER_si, nil, VarType(Windows.SM_STARTER));
  AData.AddConstant('SM_SERVERR2', Windows_SM_SERVERR2_si, nil, VarType(Windows.SM_SERVERR2));
  AData.AddConstant('SM_MOUSEHORIZONTALWHEELPRESENT', Windows_SM_MOUSEHORIZONTALWHEELPRESENT_si, nil, VarType(Windows.SM_MOUSEHORIZONTALWHEELPRESENT));
  AData.AddConstant('SM_CXPADDEDBORDER', Windows_SM_CXPADDEDBORDER_si, nil, VarType(Windows.SM_CXPADDEDBORDER));
  AData.AddConstant('SM_DIGITIZER', Windows_SM_DIGITIZER_si, nil, VarType(Windows.SM_DIGITIZER));
  AData.AddConstant('SM_MAXIMUMTOUCHES', Windows_SM_MAXIMUMTOUCHES_si, nil, VarType(Windows.SM_MAXIMUMTOUCHES));
  AData.AddConstant('SM_SHUTTINGDOWN', Windows_SM_SHUTTINGDOWN_si, nil, VarType(Windows.SM_SHUTTINGDOWN));
  AData.AddConstant('SM_REMOTECONTROL', Windows_SM_REMOTECONTROL_si, nil, VarType(Windows.SM_REMOTECONTROL));
  AData.AddConstant('SM_CARETBLINKINGENABLED', Windows_SM_CARETBLINKINGENABLED_si, nil, VarType(Windows.SM_CARETBLINKINGENABLED));
  AData.AddConstant('TPM_LAYOUTRTL', Windows_TPM_LAYOUTRTL_si, nil, VarType(Windows.TPM_LAYOUTRTL));
  AData.AddConstant('TPM_WORKAREA', Windows_TPM_WORKAREA_si, nil, VarType(Windows.TPM_WORKAREA));
  AData.AddConstant('SCF_ISSECURE', Windows_SCF_ISSECURE_si, nil, VarType(Windows.SCF_ISSECURE));
  AData.AddConstant('OIC_SHIELD', Windows_OIC_SHIELD_si, nil, VarType(Windows.OIC_SHIELD));
  AData.AddConstant('GR_GDIOBJECTS_PEAK', Windows_GR_GDIOBJECTS_PEAK_si, nil, VarType(Windows.GR_GDIOBJECTS_PEAK));
  AData.AddConstant('GR_USEROBJECTS_PEAK', Windows_GR_USEROBJECTS_PEAK_si, nil, VarType(Windows.GR_USEROBJECTS_PEAK));
  AData.AddConstant('SPI_SETSCREENSAVERRUNNING', Windows_SPI_SETSCREENSAVERRUNNING_si, nil, VarType(Windows.SPI_SETSCREENSAVERRUNNING));
  AData.AddConstant('SPI_GETWHEELSCROLLCHARS', Windows_SPI_GETWHEELSCROLLCHARS_si, nil, VarType(Windows.SPI_GETWHEELSCROLLCHARS));
  AData.AddConstant('SPI_SETWHEELSCROLLCHARS', Windows_SPI_SETWHEELSCROLLCHARS_si, nil, VarType(Windows.SPI_SETWHEELSCROLLCHARS));
  AData.AddConstant('SPI_GETDESKWALLPAPER', Windows_SPI_GETDESKWALLPAPER_si, nil, VarType(Windows.SPI_GETDESKWALLPAPER));
  AData.AddConstant('SPI_GETAUDIODESCRIPTION', Windows_SPI_GETAUDIODESCRIPTION_si, nil, VarType(Windows.SPI_GETAUDIODESCRIPTION));
  AData.AddConstant('SPI_SETAUDIODESCRIPTION', Windows_SPI_SETAUDIODESCRIPTION_si, nil, VarType(Windows.SPI_SETAUDIODESCRIPTION));
  AData.AddConstant('SPI_GETSCREENSAVESECURE', Windows_SPI_GETSCREENSAVESECURE_si, nil, VarType(Windows.SPI_GETSCREENSAVESECURE));
  AData.AddConstant('SPI_SETSCREENSAVESECURE', Windows_SPI_SETSCREENSAVESECURE_si, nil, VarType(Windows.SPI_SETSCREENSAVESECURE));
  AData.AddConstant('SPI_GETHUNGAPPTIMEOUT', Windows_SPI_GETHUNGAPPTIMEOUT_si, nil, VarType(Windows.SPI_GETHUNGAPPTIMEOUT));
  AData.AddConstant('SPI_SETHUNGAPPTIMEOUT', Windows_SPI_SETHUNGAPPTIMEOUT_si, nil, VarType(Windows.SPI_SETHUNGAPPTIMEOUT));
  AData.AddConstant('SPI_GETWAITTOKILLTIMEOUT', Windows_SPI_GETWAITTOKILLTIMEOUT_si, nil, VarType(Windows.SPI_GETWAITTOKILLTIMEOUT));
  AData.AddConstant('SPI_SETWAITTOKILLTIMEOUT', Windows_SPI_SETWAITTOKILLTIMEOUT_si, nil, VarType(Windows.SPI_SETWAITTOKILLTIMEOUT));
  AData.AddConstant('SPI_GETWAITTOKILLSERVICETIMEOUT', Windows_SPI_GETWAITTOKILLSERVICETIMEOUT_si, nil, VarType(Windows.SPI_GETWAITTOKILLSERVICETIMEOUT));
  AData.AddConstant('SPI_SETWAITTOKILLSERVICETIMEOUT', Windows_SPI_SETWAITTOKILLSERVICETIMEOUT_si, nil, VarType(Windows.SPI_SETWAITTOKILLSERVICETIMEOUT));
  AData.AddConstant('SPI_GETMOUSEDOCKTHRESHOLD', Windows_SPI_GETMOUSEDOCKTHRESHOLD_si, nil, VarType(Windows.SPI_GETMOUSEDOCKTHRESHOLD));
  AData.AddConstant('SPI_SETMOUSEDOCKTHRESHOLD', Windows_SPI_SETMOUSEDOCKTHRESHOLD_si, nil, VarType(Windows.SPI_SETMOUSEDOCKTHRESHOLD));
  AData.AddConstant('SPI_GETPENDOCKTHRESHOLD', Windows_SPI_GETPENDOCKTHRESHOLD_si, nil, VarType(Windows.SPI_GETPENDOCKTHRESHOLD));
  AData.AddConstant('SPI_SETPENDOCKTHRESHOLD', Windows_SPI_SETPENDOCKTHRESHOLD_si, nil, VarType(Windows.SPI_SETPENDOCKTHRESHOLD));
  AData.AddConstant('SPI_GETWINARRANGING', Windows_SPI_GETWINARRANGING_si, nil, VarType(Windows.SPI_GETWINARRANGING));
  AData.AddConstant('SPI_SETWINARRANGING', Windows_SPI_SETWINARRANGING_si, nil, VarType(Windows.SPI_SETWINARRANGING));
  AData.AddConstant('SPI_GETMOUSEDRAGOUTTHRESHOLD', Windows_SPI_GETMOUSEDRAGOUTTHRESHOLD_si, nil, VarType(Windows.SPI_GETMOUSEDRAGOUTTHRESHOLD));
  AData.AddConstant('SPI_SETMOUSEDRAGOUTTHRESHOLD', Windows_SPI_SETMOUSEDRAGOUTTHRESHOLD_si, nil, VarType(Windows.SPI_SETMOUSEDRAGOUTTHRESHOLD));
  AData.AddConstant('SPI_GETPENDRAGOUTTHRESHOLD', Windows_SPI_GETPENDRAGOUTTHRESHOLD_si, nil, VarType(Windows.SPI_GETPENDRAGOUTTHRESHOLD));
  AData.AddConstant('SPI_SETPENDRAGOUTTHRESHOLD', Windows_SPI_SETPENDRAGOUTTHRESHOLD_si, nil, VarType(Windows.SPI_SETPENDRAGOUTTHRESHOLD));
  AData.AddConstant('SPI_GETMOUSESIDEMOVETHRESHOLD', Windows_SPI_GETMOUSESIDEMOVETHRESHOLD_si, nil, VarType(Windows.SPI_GETMOUSESIDEMOVETHRESHOLD));
  AData.AddConstant('SPI_SETMOUSESIDEMOVETHRESHOLD', Windows_SPI_SETMOUSESIDEMOVETHRESHOLD_si, nil, VarType(Windows.SPI_SETMOUSESIDEMOVETHRESHOLD));
  AData.AddConstant('SPI_GETPENSIDEMOVETHRESHOLD', Windows_SPI_GETPENSIDEMOVETHRESHOLD_si, nil, VarType(Windows.SPI_GETPENSIDEMOVETHRESHOLD));
  AData.AddConstant('SPI_SETPENSIDEMOVETHRESHOLD', Windows_SPI_SETPENSIDEMOVETHRESHOLD_si, nil, VarType(Windows.SPI_SETPENSIDEMOVETHRESHOLD));
  AData.AddConstant('SPI_GETDRAGFROMMAXIMIZE', Windows_SPI_GETDRAGFROMMAXIMIZE_si, nil, VarType(Windows.SPI_GETDRAGFROMMAXIMIZE));
  AData.AddConstant('SPI_SETDRAGFROMMAXIMIZE', Windows_SPI_SETDRAGFROMMAXIMIZE_si, nil, VarType(Windows.SPI_SETDRAGFROMMAXIMIZE));
  AData.AddConstant('SPI_GETSNAPSIZING', Windows_SPI_GETSNAPSIZING_si, nil, VarType(Windows.SPI_GETSNAPSIZING));
  AData.AddConstant('SPI_SETSNAPSIZING', Windows_SPI_SETSNAPSIZING_si, nil, VarType(Windows.SPI_SETSNAPSIZING));
  AData.AddConstant('SPI_GETDOCKMOVING', Windows_SPI_GETDOCKMOVING_si, nil, VarType(Windows.SPI_GETDOCKMOVING));
  AData.AddConstant('SPI_SETDOCKMOVING', Windows_SPI_SETDOCKMOVING_si, nil, VarType(Windows.SPI_SETDOCKMOVING));
  AData.AddConstant('SPI_GETBLOCKSENDINPUTRESETS', Windows_SPI_GETBLOCKSENDINPUTRESETS_si, nil, VarType(Windows.SPI_GETBLOCKSENDINPUTRESETS));
  AData.AddConstant('SPI_SETBLOCKSENDINPUTRESETS', Windows_SPI_SETBLOCKSENDINPUTRESETS_si, nil, VarType(Windows.SPI_SETBLOCKSENDINPUTRESETS));
  AData.AddConstant('SPI_GETDISABLEOVERLAPPEDCONTENT', Windows_SPI_GETDISABLEOVERLAPPEDCONTENT_si, nil, VarType(Windows.SPI_GETDISABLEOVERLAPPEDCONTENT));
  AData.AddConstant('SPI_SETDISABLEOVERLAPPEDCONTENT', Windows_SPI_SETDISABLEOVERLAPPEDCONTENT_si, nil, VarType(Windows.SPI_SETDISABLEOVERLAPPEDCONTENT));
  AData.AddConstant('SPI_GETCLIENTAREAANIMATION', Windows_SPI_GETCLIENTAREAANIMATION_si, nil, VarType(Windows.SPI_GETCLIENTAREAANIMATION));
  AData.AddConstant('SPI_SETCLIENTAREAANIMATION', Windows_SPI_SETCLIENTAREAANIMATION_si, nil, VarType(Windows.SPI_SETCLIENTAREAANIMATION));
  AData.AddConstant('SPI_GETCLEARTYPE', Windows_SPI_GETCLEARTYPE_si, nil, VarType(Windows.SPI_GETCLEARTYPE));
  AData.AddConstant('SPI_SETCLEARTYPE', Windows_SPI_SETCLEARTYPE_si, nil, VarType(Windows.SPI_SETCLEARTYPE));
  AData.AddConstant('SPI_GETSPEECHRECOGNITION', Windows_SPI_GETSPEECHRECOGNITION_si, nil, VarType(Windows.SPI_GETSPEECHRECOGNITION));
  AData.AddConstant('SPI_SETSPEECHRECOGNITION', Windows_SPI_SETSPEECHRECOGNITION_si, nil, VarType(Windows.SPI_SETSPEECHRECOGNITION));
  AData.AddConstant('SPI_GETFONTSMOOTHINGORIENTATION', Windows_SPI_GETFONTSMOOTHINGORIENTATION_si, nil, VarType(Windows.SPI_GETFONTSMOOTHINGORIENTATION));
  AData.AddConstant('SPI_SETFONTSMOOTHINGORIENTATION', Windows_SPI_SETFONTSMOOTHINGORIENTATION_si, nil, VarType(Windows.SPI_SETFONTSMOOTHINGORIENTATION));
  AData.AddConstant('FE_FONTSMOOTHINGORIENTATIONBGR', Windows_FE_FONTSMOOTHINGORIENTATIONBGR_si, nil, VarType(Windows.FE_FONTSMOOTHINGORIENTATIONBGR));
  AData.AddConstant('FE_FONTSMOOTHINGORIENTATIONRGB', Windows_FE_FONTSMOOTHINGORIENTATIONRGB_si, nil, VarType(Windows.FE_FONTSMOOTHINGORIENTATIONRGB));
  AData.AddConstant('SPI_GETMINIMUMHITRADIUS', Windows_SPI_GETMINIMUMHITRADIUS_si, nil, VarType(Windows.SPI_GETMINIMUMHITRADIUS));
  AData.AddConstant('SPI_SETMINIMUMHITRADIUS', Windows_SPI_SETMINIMUMHITRADIUS_si, nil, VarType(Windows.SPI_SETMINIMUMHITRADIUS));
  AData.AddConstant('SPI_GETMESSAGEDURATION', Windows_SPI_GETMESSAGEDURATION_si, nil, VarType(Windows.SPI_GETMESSAGEDURATION));
  AData.AddConstant('SPI_SETMESSAGEDURATION', Windows_SPI_SETMESSAGEDURATION_si, nil, VarType(Windows.SPI_SETMESSAGEDURATION));
  AData.AddConstant('HCF_LOGONDESKTOP', Windows_HCF_LOGONDESKTOP_si, nil, VarType(Windows.HCF_LOGONDESKTOP));
  AData.AddConstant('HCF_DEFAULTDESKTOP', Windows_HCF_DEFAULTDESKTOP_si, nil, VarType(Windows.HCF_DEFAULTDESKTOP));
  AData.AddConstant('CDS_VIDEOPARAMETERS', Windows_CDS_VIDEOPARAMETERS_si, nil, VarType(Windows.CDS_VIDEOPARAMETERS));
  AData.AddConstant('CDS_ENABLE_UNSAFE_MODES', Windows_CDS_ENABLE_UNSAFE_MODES_si, nil, VarType(Windows.CDS_ENABLE_UNSAFE_MODES));
  AData.AddConstant('CDS_DISABLE_UNSAFE_MODES', Windows_CDS_DISABLE_UNSAFE_MODES_si, nil, VarType(Windows.CDS_DISABLE_UNSAFE_MODES));
  AData.AddConstant('CDS_RESET_EX', Windows_CDS_RESET_EX_si, nil, VarType(Windows.CDS_RESET_EX));
  AData.AddConstant('EDD_GET_DEVICE_INTERFACE_NAME', Windows_EDD_GET_DEVICE_INTERFACE_NAME_si, nil, VarType(Windows.EDD_GET_DEVICE_INTERFACE_NAME));
  AData.AddConstant('EVENT_SYSTEM_DESKTOPSWITCH', Windows_EVENT_SYSTEM_DESKTOPSWITCH_si, nil, VarType(Windows.EVENT_SYSTEM_DESKTOPSWITCH));
  AData.AddConstant('EVENT_SYSTEM_END', Windows_EVENT_SYSTEM_END_si, nil, VarType(Windows.EVENT_SYSTEM_END));
  AData.AddConstant('EVENT_OEM_DEFINED_START', Windows_EVENT_OEM_DEFINED_START_si, nil, VarType(Windows.EVENT_OEM_DEFINED_START));
  AData.AddConstant('EVENT_OEM_DEFINED_END', Windows_EVENT_OEM_DEFINED_END_si, nil, VarType(Windows.EVENT_OEM_DEFINED_END));
  AData.AddConstant('EVENT_UIA_EVENTID_START', Windows_EVENT_UIA_EVENTID_START_si, nil, VarType(Windows.EVENT_UIA_EVENTID_START));
  AData.AddConstant('EVENT_UIA_EVENTID_END', Windows_EVENT_UIA_EVENTID_END_si, nil, VarType(Windows.EVENT_UIA_EVENTID_END));
  AData.AddConstant('EVENT_UIA_PROPID_START', Windows_EVENT_UIA_PROPID_START_si, nil, VarType(Windows.EVENT_UIA_PROPID_START));
  AData.AddConstant('EVENT_UIA_PROPID_END', Windows_EVENT_UIA_PROPID_END_si, nil, VarType(Windows.EVENT_UIA_PROPID_END));
  AData.AddConstant('EVENT_CONSOLE_CARET', Windows_EVENT_CONSOLE_CARET_si, nil, VarType(Windows.EVENT_CONSOLE_CARET));
  AData.AddConstant('EVENT_CONSOLE_UPDATE_REGION', Windows_EVENT_CONSOLE_UPDATE_REGION_si, nil, VarType(Windows.EVENT_CONSOLE_UPDATE_REGION));
  AData.AddConstant('EVENT_CONSOLE_UPDATE_SIMPLE', Windows_EVENT_CONSOLE_UPDATE_SIMPLE_si, nil, VarType(Windows.EVENT_CONSOLE_UPDATE_SIMPLE));
  AData.AddConstant('EVENT_CONSOLE_UPDATE_SCROLL', Windows_EVENT_CONSOLE_UPDATE_SCROLL_si, nil, VarType(Windows.EVENT_CONSOLE_UPDATE_SCROLL));
  AData.AddConstant('EVENT_CONSOLE_LAYOUT', Windows_EVENT_CONSOLE_LAYOUT_si, nil, VarType(Windows.EVENT_CONSOLE_LAYOUT));
  AData.AddConstant('EVENT_CONSOLE_START_APPLICATION', Windows_EVENT_CONSOLE_START_APPLICATION_si, nil, VarType(Windows.EVENT_CONSOLE_START_APPLICATION));
  AData.AddConstant('EVENT_CONSOLE_END_APPLICATION', Windows_EVENT_CONSOLE_END_APPLICATION_si, nil, VarType(Windows.EVENT_CONSOLE_END_APPLICATION));
  AData.AddConstant('CONSOLE_APPLICATION_16BIT', Windows_CONSOLE_APPLICATION_16BIT_si, nil, VarType(Windows.CONSOLE_APPLICATION_16BIT));
  AData.AddConstant('CONSOLE_CARET_SELECTION', Windows_CONSOLE_CARET_SELECTION_si, nil, VarType(Windows.CONSOLE_CARET_SELECTION));
  AData.AddConstant('CONSOLE_CARET_VISIBLE', Windows_CONSOLE_CARET_VISIBLE_si, nil, VarType(Windows.CONSOLE_CARET_VISIBLE));
  AData.AddConstant('EVENT_CONSOLE_END', Windows_EVENT_CONSOLE_END_si, nil, VarType(Windows.EVENT_CONSOLE_END));
  AData.AddConstant('EVENT_OBJECT_INVOKED', Windows_EVENT_OBJECT_INVOKED_si, nil, VarType(Windows.EVENT_OBJECT_INVOKED));
  AData.AddConstant('EVENT_OBJECT_TEXTSELECTIONCHANGED', Windows_EVENT_OBJECT_TEXTSELECTIONCHANGED_si, nil, VarType(Windows.EVENT_OBJECT_TEXTSELECTIONCHANGED));
  AData.AddConstant('EVENT_OBJECT_CONTENTSCROLLED', Windows_EVENT_OBJECT_CONTENTSCROLLED_si, nil, VarType(Windows.EVENT_OBJECT_CONTENTSCROLLED));
  AData.AddConstant('EVENT_SYSTEM_ARRANGMENTPREVIEW', Windows_EVENT_SYSTEM_ARRANGMENTPREVIEW_si, nil, VarType(Windows.EVENT_SYSTEM_ARRANGMENTPREVIEW));
  AData.AddConstant('EVENT_OBJECT_END', Windows_EVENT_OBJECT_END_si, nil, VarType(Windows.EVENT_OBJECT_END));
  AData.AddConstant('EVENT_AIA_START', Windows_EVENT_AIA_START_si, nil, VarType(Windows.EVENT_AIA_START));
  AData.AddConstant('EVENT_AIA_END', Windows_EVENT_AIA_END_si, nil, VarType(Windows.EVENT_AIA_END));
  AData.AddConstant('GUI_16BITTASK', Windows_GUI_16BITTASK_si, nil, VarType(Windows.GUI_16BITTASK));
  AData.AddConstant('USER_DEFAULT_SCREEN_DPI', Windows_USER_DEFAULT_SCREEN_DPI_si, nil, VarType(Windows.USER_DEFAULT_SCREEN_DPI));
  AData.AddConstant('MB_ERR_INVALID_CHARS', Windows_MB_ERR_INVALID_CHARS_si, nil, VarType(Windows.MB_ERR_INVALID_CHARS));
  AData.AddConstant('WC_NO_BEST_FIT_CHARS', Windows_WC_NO_BEST_FIT_CHARS_si, nil, VarType(Windows.WC_NO_BEST_FIT_CHARS));
  AData.AddConstant('WC_ERR_INVALID_CHARS', Windows_WC_ERR_INVALID_CHARS_si, nil, VarType(Windows.WC_ERR_INVALID_CHARS));
  AData.AddConstant('GWLP_WNDPROC', Windows_GWLP_WNDPROC_si, nil, VarType(Windows.GWLP_WNDPROC));
  AData.AddConstant('GWLP_HINSTANCE', Windows_GWLP_HINSTANCE_si, nil, VarType(Windows.GWLP_HINSTANCE));
  AData.AddConstant('GWLP_HWNDPARENT', Windows_GWLP_HWNDPARENT_si, nil, VarType(Windows.GWLP_HWNDPARENT));
  AData.AddConstant('GWLP_USERDATA', Windows_GWLP_USERDATA_si, nil, VarType(Windows.GWLP_USERDATA));
  AData.AddConstant('GWLP_ID', Windows_GWLP_ID_si, nil, VarType(Windows.GWLP_ID));
  AData.AddConstant('GF_BEGIN', Windows_GF_BEGIN_si, nil, VarType(Windows.GF_BEGIN));
  AData.AddConstant('GF_INERTIA', Windows_GF_INERTIA_si, nil, VarType(Windows.GF_INERTIA));
  AData.AddConstant('GF_END', Windows_GF_END_si, nil, VarType(Windows.GF_END));
  AData.AddConstant('GID_BEGIN', Windows_GID_BEGIN_si, nil, VarType(Windows.GID_BEGIN));
  AData.AddConstant('GID_END', Windows_GID_END_si, nil, VarType(Windows.GID_END));
  AData.AddConstant('GID_ZOOM', Windows_GID_ZOOM_si, nil, VarType(Windows.GID_ZOOM));
  AData.AddConstant('GID_PAN', Windows_GID_PAN_si, nil, VarType(Windows.GID_PAN));
  AData.AddConstant('GID_ROTATE', Windows_GID_ROTATE_si, nil, VarType(Windows.GID_ROTATE));
  AData.AddConstant('GID_TWOFINGERTAP', Windows_GID_TWOFINGERTAP_si, nil, VarType(Windows.GID_TWOFINGERTAP));
  AData.AddConstant('GID_PRESSANDTAP', Windows_GID_PRESSANDTAP_si, nil, VarType(Windows.GID_PRESSANDTAP));
  AData.AddConstant('GC_ALLGESTURES', Windows_GC_ALLGESTURES_si, nil, VarType(Windows.GC_ALLGESTURES));
  AData.AddConstant('GC_ZOOM', Windows_GC_ZOOM_si, nil, VarType(Windows.GC_ZOOM));
  AData.AddConstant('GC_PAN', Windows_GC_PAN_si, nil, VarType(Windows.GC_PAN));
  AData.AddConstant('GC_PAN_WITH_SINGLE_FINGER_VERTICALLY', Windows_GC_PAN_WITH_SINGLE_FINGER_VERTICALLY_si, nil, VarType(Windows.GC_PAN_WITH_SINGLE_FINGER_VERTICALLY));
  AData.AddConstant('GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY', Windows_GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY_si, nil, VarType(Windows.GC_PAN_WITH_SINGLE_FINGER_HORIZONTALLY));
  AData.AddConstant('GC_PAN_WITH_GUTTER', Windows_GC_PAN_WITH_GUTTER_si, nil, VarType(Windows.GC_PAN_WITH_GUTTER));
  AData.AddConstant('GC_PAN_WITH_INERTIA', Windows_GC_PAN_WITH_INERTIA_si, nil, VarType(Windows.GC_PAN_WITH_INERTIA));
  AData.AddConstant('GC_ROTATE', Windows_GC_ROTATE_si, nil, VarType(Windows.GC_ROTATE));
  AData.AddConstant('GC_TWOFINGERTAP', Windows_GC_TWOFINGERTAP_si, nil, VarType(Windows.GC_TWOFINGERTAP));
  AData.AddConstant('GC_PRESSANDTAP', Windows_GC_PRESSANDTAP_si, nil, VarType(Windows.GC_PRESSANDTAP));
  AData.AddConstant('GESTURECONFIGMAXCOUNT', Windows_GESTURECONFIGMAXCOUNT_si, nil, VarType(Windows.GESTURECONFIGMAXCOUNT));
  AData.AddConstant('GCF_INCLUDE_ANCESTORS', Windows_GCF_INCLUDE_ANCESTORS_si, nil, VarType(Windows.GCF_INCLUDE_ANCESTORS));
  AData.AddConstant('NID_INTEGRATED_TOUCH', Windows_NID_INTEGRATED_TOUCH_si, nil, VarType(Windows.NID_INTEGRATED_TOUCH));
  AData.AddConstant('NID_EXTERNAL_TOUCH', Windows_NID_EXTERNAL_TOUCH_si, nil, VarType(Windows.NID_EXTERNAL_TOUCH));
  AData.AddConstant('NID_INTEGRATED_PEN', Windows_NID_INTEGRATED_PEN_si, nil, VarType(Windows.NID_INTEGRATED_PEN));
  AData.AddConstant('NID_EXTERNAL_PEN', Windows_NID_EXTERNAL_PEN_si, nil, VarType(Windows.NID_EXTERNAL_PEN));
  AData.AddConstant('NID_MULTI_INPUT', Windows_NID_MULTI_INPUT_si, nil, VarType(Windows.NID_MULTI_INPUT));
  AData.AddConstant('NID_READY', Windows_NID_READY_si, nil, VarType(Windows.NID_READY));
end;

class function Windows_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Windows_sw);
end;

initialization
  RegisterUnitWrapper(Windows_sw);

end.
