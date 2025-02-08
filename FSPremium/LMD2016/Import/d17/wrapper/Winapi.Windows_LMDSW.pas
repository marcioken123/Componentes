unit Winapi.Windows_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Winapi.Windows' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Classes, System.SysUtils, System.Variants, System.TypInfo, LMDTypes,
  LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers, System.Types,
  System.UITypes, Winapi.Windows, System.Types_LMDSW, System.UITypes_LMDSW;


{ Type wrappers }

type

  DWORD_sw = System.Types_LMDSW.DWORD_sw;

  BOOL_sw = LongBool_sw;

  UINT_sw = LongWord_sw;

  LCID_sw = DWORD_sw;

  THandle_sw = LMDSctSysWrappers.THandle_sw;

  INT_PTR_sw = LMDSctSysWrappers.IntPtr_sw;

  UINT_PTR_sw = LMDSctSysWrappers.UIntPtr_sw;

  _FLOATING_SAVE_AREA_sw = class(TLMDRecordWrapper)
  private
    FValue: _FLOATING_SAVE_AREA;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _FLOATING_SAVE_AREA): OleVariant;
    class function FromVar(const AValue: OleVariant): _FLOATING_SAVE_AREA;
  end;

  TFloatingSaveArea_sw = _FLOATING_SAVE_AREA_sw;

  FLOATING_SAVE_AREA_sw = _FLOATING_SAVE_AREA_sw;

  _CONTEXT_sw = class(TLMDRecordWrapper)
  private
    FValue: _CONTEXT;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _CONTEXT): OleVariant;
    class function FromVar(const AValue: OleVariant): _CONTEXT;
  end;

  WPARAM_sw = UINT_PTR_sw;

  LPARAM_sw = INT_PTR_sw;

  LRESULT_sw = INT_PTR_sw;

  HWND_sw = class(UINT_PTR_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HWND): OleVariant;
    class function FromVar(const AValue: OleVariant): HWND;
  end;

  HACCEL_sw = class(UINT_PTR_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HACCEL): OleVariant;
    class function FromVar(const AValue: OleVariant): HACCEL;
  end;

  HBITMAP_sw = class(UINT_PTR_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HBITMAP): OleVariant;
    class function FromVar(const AValue: OleVariant): HBITMAP;
  end;

  HBRUSH_sw = class(UINT_PTR_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HBRUSH): OleVariant;
    class function FromVar(const AValue: OleVariant): HBRUSH;
  end;

  HDC_sw = class(UINT_PTR_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HDC): OleVariant;
    class function FromVar(const AValue: OleVariant): HDC;
  end;

  HFONT_sw = class(UINT_PTR_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HFONT): OleVariant;
    class function FromVar(const AValue: OleVariant): HFONT;
  end;

  HICON_sw = class(UINT_PTR_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HICON): OleVariant;
    class function FromVar(const AValue: OleVariant): HICON;
  end;

  HMENU_sw = class(UINT_PTR_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HMENU): OleVariant;
    class function FromVar(const AValue: OleVariant): HMENU;
  end;

  HINST_sw = LMDSctSysWrappers.HINST_sw;

  HMODULE_sw = LMDSctSysWrappers.HMODULE_sw;

  HPALETTE_sw = class(UINT_PTR_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HPALETTE): OleVariant;
    class function FromVar(const AValue: OleVariant): HPALETTE;
  end;

  HPEN_sw = class(UINT_PTR_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HPEN): OleVariant;
    class function FromVar(const AValue: OleVariant): HPEN;
  end;

  HKL_sw = class(UINT_PTR_sw)
  protected
    class function GetTypeName: WideString; override;
  public
    class function ToVar(const AValue: HKL): OleVariant;
    class function FromVar(const AValue: OleVariant): HKL;
  end;

  HCURSOR_sw = HICON_sw;

  COLORREF_sw = DWORD_sw;

  TPoint_sw = System.Types_LMDSW.TPoint_sw;

  TRect_sw = System.Types_LMDSW.TRect_sw;

  TSize_sw = System.Types_LMDSW.TSize_sw;

  _FILETIME_sw = class(TLMDRecordWrapper)
  private
    FValue: _FILETIME;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _FILETIME): OleVariant;
    class function FromVar(const AValue: OleVariant): _FILETIME;
  end;

  TFileTime_sw = _FILETIME_sw;

  _SYSTEMTIME_sw = class(TLMDRecordWrapper)
  private
    FValue: _SYSTEMTIME;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _SYSTEMTIME): OleVariant;
    class function FromVar(const AValue: OleVariant): _SYSTEMTIME;
  end;

  TSystemTime_sw = _SYSTEMTIME_sw;

  _WIN32_FIND_DATAW_sw = class(TLMDRecordWrapper)
  private
    FValue: _WIN32_FIND_DATAW;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _WIN32_FIND_DATAW): OleVariant;
    class function FromVar(const AValue: OleVariant): _WIN32_FIND_DATAW;
  end;

  TWin32FindDataW_sw = _WIN32_FIND_DATAW_sw;

  TWin32FindData_sw = TWin32FindDataW_sw;

  tagLOGFONTW_sw = class(TLMDRecordWrapper)
  private
    FValue: tagLOGFONTW;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: tagLOGFONTW): OleVariant;
    class function FromVar(const AValue: OleVariant): tagLOGFONTW;
  end;

  LOGFONTW_sw = tagLOGFONTW_sw;

  LOGFONT_sw = LOGFONTW_sw;

  tagWNDCLASSW_sw = class(TLMDRecordWrapper)
  private
    FValue: tagWNDCLASSW;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: tagWNDCLASSW): OleVariant;
    class function FromVar(const AValue: OleVariant): tagWNDCLASSW;
  end;

  TWndClassW_sw = tagWNDCLASSW_sw;

  TWndClass_sw = TWndClassW_sw;

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

{ _FLOATING_SAVE_AREA_sw }

function _FLOATING_SAVE_AREA_Cr0NpxState_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Cr0NpxState: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_FLOATING_SAVE_AREA_sw(AObj).FValue.Cr0NpxState)
  else
    _FLOATING_SAVE_AREA_sw(AObj).FValue.Cr0NpxState := DWORD_sw.FromVar(
      AArgs[0]);
end;

function _FLOATING_SAVE_AREA_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _FLOATING_SAVE_AREA_sw.Create as IDispatch;
end;

function _FLOATING_SAVE_AREA_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _FLOATING_SAVE_AREA;

  // Implicit record copy method.
  Result := _FLOATING_SAVE_AREA_sw.ToVar(_FLOATING_SAVE_AREA(AObj));
end;

class function _FLOATING_SAVE_AREA_sw.GetTypeName: WideString;
begin
  Result := '_FLOATING_SAVE_AREA';
end;

function _FLOATING_SAVE_AREA_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _FLOATING_SAVE_AREA_sw.Create;
  _FLOATING_SAVE_AREA_sw(Result).FValue := FValue;
end;

class procedure _FLOATING_SAVE_AREA_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Cr0NpxState', _FLOATING_SAVE_AREA_Cr0NpxState_si, DWORD_sw);
  AData.AddFunction('Copy', _FLOATING_SAVE_AREA_Copy_si, _FLOATING_SAVE_AREA_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _FLOATING_SAVE_AREA_Create_si, 0, False);
end;

class function _FLOATING_SAVE_AREA_sw.ToVar(
  const AValue: _FLOATING_SAVE_AREA): OleVariant;
var
  wrpr: _FLOATING_SAVE_AREA_sw;
begin
  wrpr        := _FLOATING_SAVE_AREA_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _FLOATING_SAVE_AREA_sw.FromVar(
  const AValue: OleVariant): _FLOATING_SAVE_AREA;
begin
  Result := _FLOATING_SAVE_AREA_sw(ConvFromVar(AValue)).FValue;
end;

{ _CONTEXT_sw }

function _CONTEXT_ContextFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ContextFlags: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.ContextFlags)
  else
    _CONTEXT_sw(AObj).FValue.ContextFlags := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Dr0_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Dr0: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Dr0)
  else
    _CONTEXT_sw(AObj).FValue.Dr0 := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Dr1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Dr1: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Dr1)
  else
    _CONTEXT_sw(AObj).FValue.Dr1 := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Dr2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Dr2: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Dr2)
  else
    _CONTEXT_sw(AObj).FValue.Dr2 := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Dr3_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Dr3: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Dr3)
  else
    _CONTEXT_sw(AObj).FValue.Dr3 := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Dr6_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Dr6: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Dr6)
  else
    _CONTEXT_sw(AObj).FValue.Dr6 := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Dr7_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Dr7: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Dr7)
  else
    _CONTEXT_sw(AObj).FValue.Dr7 := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_FloatSave_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FloatSave: TFloatingSaveArea;

  if IsGet then
    Result := TFloatingSaveArea_sw.ToVar(_CONTEXT_sw(AObj).FValue.FloatSave)
  else
    _CONTEXT_sw(AObj).FValue.FloatSave := TFloatingSaveArea_sw.FromVar(
      AArgs[0]);
end;

function _CONTEXT_SegGs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SegGs: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.SegGs)
  else
    _CONTEXT_sw(AObj).FValue.SegGs := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_SegFs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SegFs: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.SegFs)
  else
    _CONTEXT_sw(AObj).FValue.SegFs := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_SegEs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SegEs: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.SegEs)
  else
    _CONTEXT_sw(AObj).FValue.SegEs := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_SegDs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SegDs: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.SegDs)
  else
    _CONTEXT_sw(AObj).FValue.SegDs := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Edi_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Edi: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Edi)
  else
    _CONTEXT_sw(AObj).FValue.Edi := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Esi_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Esi: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Esi)
  else
    _CONTEXT_sw(AObj).FValue.Esi := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Ebx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Ebx: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Ebx)
  else
    _CONTEXT_sw(AObj).FValue.Ebx := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Edx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Edx: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Edx)
  else
    _CONTEXT_sw(AObj).FValue.Edx := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Ecx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Ecx: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Ecx)
  else
    _CONTEXT_sw(AObj).FValue.Ecx := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Eax_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Eax: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Eax)
  else
    _CONTEXT_sw(AObj).FValue.Eax := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Ebp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Ebp: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Ebp)
  else
    _CONTEXT_sw(AObj).FValue.Ebp := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Eip_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Eip: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Eip)
  else
    _CONTEXT_sw(AObj).FValue.Eip := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_SegCs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SegCs: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.SegCs)
  else
    _CONTEXT_sw(AObj).FValue.SegCs := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_EFlags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var EFlags: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.EFlags)
  else
    _CONTEXT_sw(AObj).FValue.EFlags := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Esp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Esp: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.Esp)
  else
    _CONTEXT_sw(AObj).FValue.Esp := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_SegSs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var SegSs: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_CONTEXT_sw(AObj).FValue.SegSs)
  else
    _CONTEXT_sw(AObj).FValue.SegSs := DWORD_sw.FromVar(AArgs[0]);
end;

function _CONTEXT_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _CONTEXT_sw.Create as IDispatch;
end;

function _CONTEXT_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _CONTEXT;

  // Implicit record copy method.
  Result := _CONTEXT_sw.ToVar(_CONTEXT(AObj));
end;

class function _CONTEXT_sw.GetTypeName: WideString;
begin
  Result := '_CONTEXT';
end;

function _CONTEXT_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _CONTEXT_sw.Create;
  _CONTEXT_sw(Result).FValue := FValue;
end;

class procedure _CONTEXT_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('ContextFlags', _CONTEXT_ContextFlags_si, DWORD_sw);
  AData.AddField('Dr0', _CONTEXT_Dr0_si, DWORD_sw);
  AData.AddField('Dr1', _CONTEXT_Dr1_si, DWORD_sw);
  AData.AddField('Dr2', _CONTEXT_Dr2_si, DWORD_sw);
  AData.AddField('Dr3', _CONTEXT_Dr3_si, DWORD_sw);
  AData.AddField('Dr6', _CONTEXT_Dr6_si, DWORD_sw);
  AData.AddField('Dr7', _CONTEXT_Dr7_si, DWORD_sw);
  AData.AddField('FloatSave', _CONTEXT_FloatSave_si, TFloatingSaveArea_sw);
  AData.AddField('SegGs', _CONTEXT_SegGs_si, DWORD_sw);
  AData.AddField('SegFs', _CONTEXT_SegFs_si, DWORD_sw);
  AData.AddField('SegEs', _CONTEXT_SegEs_si, DWORD_sw);
  AData.AddField('SegDs', _CONTEXT_SegDs_si, DWORD_sw);
  AData.AddField('Edi', _CONTEXT_Edi_si, DWORD_sw);
  AData.AddField('Esi', _CONTEXT_Esi_si, DWORD_sw);
  AData.AddField('Ebx', _CONTEXT_Ebx_si, DWORD_sw);
  AData.AddField('Edx', _CONTEXT_Edx_si, DWORD_sw);
  AData.AddField('Ecx', _CONTEXT_Ecx_si, DWORD_sw);
  AData.AddField('Eax', _CONTEXT_Eax_si, DWORD_sw);
  AData.AddField('Ebp', _CONTEXT_Ebp_si, DWORD_sw);
  AData.AddField('Eip', _CONTEXT_Eip_si, DWORD_sw);
  AData.AddField('SegCs', _CONTEXT_SegCs_si, DWORD_sw);
  AData.AddField('EFlags', _CONTEXT_EFlags_si, DWORD_sw);
  AData.AddField('Esp', _CONTEXT_Esp_si, DWORD_sw);
  AData.AddField('SegSs', _CONTEXT_SegSs_si, DWORD_sw);
  AData.AddFunction('Copy', _CONTEXT_Copy_si, _CONTEXT_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _CONTEXT_Create_si, 0, False);
end;

class function _CONTEXT_sw.ToVar(const AValue: _CONTEXT): OleVariant;
var
  wrpr: _CONTEXT_sw;
begin
  wrpr        := _CONTEXT_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _CONTEXT_sw.FromVar(const AValue: OleVariant): _CONTEXT;
begin
  Result := _CONTEXT_sw(ConvFromVar(AValue)).FValue;
end;

{ HWND_sw }

class function HWND_sw.GetTypeName: WideString;
begin
  Result := 'HWND';
end;

class function HWND_sw.ToVar(const AValue: HWND): OleVariant;
begin
  Result := UINT_PTR_sw.ToVar(UINT_PTR(AValue));
end;

class function HWND_sw.FromVar(const AValue: OleVariant): HWND;
begin
  Result := HWND(UINT_PTR_sw.FromVar(AValue));
end;

{ HACCEL_sw }

class function HACCEL_sw.GetTypeName: WideString;
begin
  Result := 'HACCEL';
end;

class function HACCEL_sw.ToVar(const AValue: HACCEL): OleVariant;
begin
  Result := UINT_PTR_sw.ToVar(UINT_PTR(AValue));
end;

class function HACCEL_sw.FromVar(const AValue: OleVariant): HACCEL;
begin
  Result := HACCEL(UINT_PTR_sw.FromVar(AValue));
end;

{ HBITMAP_sw }

class function HBITMAP_sw.GetTypeName: WideString;
begin
  Result := 'HBITMAP';
end;

class function HBITMAP_sw.ToVar(const AValue: HBITMAP): OleVariant;
begin
  Result := UINT_PTR_sw.ToVar(UINT_PTR(AValue));
end;

class function HBITMAP_sw.FromVar(const AValue: OleVariant): HBITMAP;
begin
  Result := HBITMAP(UINT_PTR_sw.FromVar(AValue));
end;

{ HBRUSH_sw }

class function HBRUSH_sw.GetTypeName: WideString;
begin
  Result := 'HBRUSH';
end;

class function HBRUSH_sw.ToVar(const AValue: HBRUSH): OleVariant;
begin
  Result := UINT_PTR_sw.ToVar(UINT_PTR(AValue));
end;

class function HBRUSH_sw.FromVar(const AValue: OleVariant): HBRUSH;
begin
  Result := HBRUSH(UINT_PTR_sw.FromVar(AValue));
end;

{ HDC_sw }

class function HDC_sw.GetTypeName: WideString;
begin
  Result := 'HDC';
end;

class function HDC_sw.ToVar(const AValue: HDC): OleVariant;
begin
  Result := UINT_PTR_sw.ToVar(UINT_PTR(AValue));
end;

class function HDC_sw.FromVar(const AValue: OleVariant): HDC;
begin
  Result := HDC(UINT_PTR_sw.FromVar(AValue));
end;

{ HFONT_sw }

class function HFONT_sw.GetTypeName: WideString;
begin
  Result := 'HFONT';
end;

class function HFONT_sw.ToVar(const AValue: HFONT): OleVariant;
begin
  Result := UINT_PTR_sw.ToVar(UINT_PTR(AValue));
end;

class function HFONT_sw.FromVar(const AValue: OleVariant): HFONT;
begin
  Result := HFONT(UINT_PTR_sw.FromVar(AValue));
end;

{ HICON_sw }

class function HICON_sw.GetTypeName: WideString;
begin
  Result := 'HICON';
end;

class function HICON_sw.ToVar(const AValue: HICON): OleVariant;
begin
  Result := UINT_PTR_sw.ToVar(UINT_PTR(AValue));
end;

class function HICON_sw.FromVar(const AValue: OleVariant): HICON;
begin
  Result := HICON(UINT_PTR_sw.FromVar(AValue));
end;

{ HMENU_sw }

class function HMENU_sw.GetTypeName: WideString;
begin
  Result := 'HMENU';
end;

class function HMENU_sw.ToVar(const AValue: HMENU): OleVariant;
begin
  Result := UINT_PTR_sw.ToVar(UINT_PTR(AValue));
end;

class function HMENU_sw.FromVar(const AValue: OleVariant): HMENU;
begin
  Result := HMENU(UINT_PTR_sw.FromVar(AValue));
end;

{ HPALETTE_sw }

class function HPALETTE_sw.GetTypeName: WideString;
begin
  Result := 'HPALETTE';
end;

class function HPALETTE_sw.ToVar(const AValue: HPALETTE): OleVariant;
begin
  Result := UINT_PTR_sw.ToVar(UINT_PTR(AValue));
end;

class function HPALETTE_sw.FromVar(const AValue: OleVariant): HPALETTE;
begin
  Result := HPALETTE(UINT_PTR_sw.FromVar(AValue));
end;

{ HPEN_sw }

class function HPEN_sw.GetTypeName: WideString;
begin
  Result := 'HPEN';
end;

class function HPEN_sw.ToVar(const AValue: HPEN): OleVariant;
begin
  Result := UINT_PTR_sw.ToVar(UINT_PTR(AValue));
end;

class function HPEN_sw.FromVar(const AValue: OleVariant): HPEN;
begin
  Result := HPEN(UINT_PTR_sw.FromVar(AValue));
end;

{ HKL_sw }

class function HKL_sw.GetTypeName: WideString;
begin
  Result := 'HKL';
end;

class function HKL_sw.ToVar(const AValue: HKL): OleVariant;
begin
  Result := UINT_PTR_sw.ToVar(UINT_PTR(AValue));
end;

class function HKL_sw.FromVar(const AValue: OleVariant): HKL;
begin
  Result := HKL(UINT_PTR_sw.FromVar(AValue));
end;

{ _FILETIME_sw }

function _FILETIME_dwLowDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwLowDateTime: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_FILETIME_sw(AObj).FValue.dwLowDateTime)
  else
    _FILETIME_sw(AObj).FValue.dwLowDateTime := DWORD_sw.FromVar(AArgs[0]);
end;

function _FILETIME_dwHighDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwHighDateTime: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_FILETIME_sw(AObj).FValue.dwHighDateTime)
  else
    _FILETIME_sw(AObj).FValue.dwHighDateTime := DWORD_sw.FromVar(AArgs[0]);
end;

function _FILETIME_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _FILETIME_sw.Create as IDispatch;
end;

function _FILETIME_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _FILETIME;

  // Implicit record copy method.
  Result := _FILETIME_sw.ToVar(_FILETIME(AObj));
end;

class function _FILETIME_sw.GetTypeName: WideString;
begin
  Result := '_FILETIME';
end;

function _FILETIME_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _FILETIME_sw.Create;
  _FILETIME_sw(Result).FValue := FValue;
end;

class procedure _FILETIME_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('dwLowDateTime', _FILETIME_dwLowDateTime_si, DWORD_sw);
  AData.AddField('dwHighDateTime', _FILETIME_dwHighDateTime_si, DWORD_sw);
  AData.AddFunction('Copy', _FILETIME_Copy_si, _FILETIME_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _FILETIME_Create_si, 0, False);
end;

class function _FILETIME_sw.ToVar(const AValue: _FILETIME): OleVariant;
var
  wrpr: _FILETIME_sw;
begin
  wrpr        := _FILETIME_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _FILETIME_sw.FromVar(const AValue: OleVariant): _FILETIME;
begin
  Result := _FILETIME_sw(ConvFromVar(AValue)).FValue;
end;

{ _SYSTEMTIME_sw }

function _SYSTEMTIME_wYear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wYear: Word;

  if IsGet then
    Result := _SYSTEMTIME_sw(AObj).FValue.wYear
  else
    _SYSTEMTIME_sw(AObj).FValue.wYear := Word(AArgs[0]);
end;

function _SYSTEMTIME_wMonth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wMonth: Word;

  if IsGet then
    Result := _SYSTEMTIME_sw(AObj).FValue.wMonth
  else
    _SYSTEMTIME_sw(AObj).FValue.wMonth := Word(AArgs[0]);
end;

function _SYSTEMTIME_wDayOfWeek_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wDayOfWeek: Word;

  if IsGet then
    Result := _SYSTEMTIME_sw(AObj).FValue.wDayOfWeek
  else
    _SYSTEMTIME_sw(AObj).FValue.wDayOfWeek := Word(AArgs[0]);
end;

function _SYSTEMTIME_wDay_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wDay: Word;

  if IsGet then
    Result := _SYSTEMTIME_sw(AObj).FValue.wDay
  else
    _SYSTEMTIME_sw(AObj).FValue.wDay := Word(AArgs[0]);
end;

function _SYSTEMTIME_wHour_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wHour: Word;

  if IsGet then
    Result := _SYSTEMTIME_sw(AObj).FValue.wHour
  else
    _SYSTEMTIME_sw(AObj).FValue.wHour := Word(AArgs[0]);
end;

function _SYSTEMTIME_wMinute_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wMinute: Word;

  if IsGet then
    Result := _SYSTEMTIME_sw(AObj).FValue.wMinute
  else
    _SYSTEMTIME_sw(AObj).FValue.wMinute := Word(AArgs[0]);
end;

function _SYSTEMTIME_wSecond_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wSecond: Word;

  if IsGet then
    Result := _SYSTEMTIME_sw(AObj).FValue.wSecond
  else
    _SYSTEMTIME_sw(AObj).FValue.wSecond := Word(AArgs[0]);
end;

function _SYSTEMTIME_wMilliseconds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wMilliseconds: Word;

  if IsGet then
    Result := _SYSTEMTIME_sw(AObj).FValue.wMilliseconds
  else
    _SYSTEMTIME_sw(AObj).FValue.wMilliseconds := Word(AArgs[0]);
end;

function _SYSTEMTIME_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _SYSTEMTIME_sw.Create as IDispatch;
end;

function _SYSTEMTIME_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _SYSTEMTIME;

  // Implicit record copy method.
  Result := _SYSTEMTIME_sw.ToVar(_SYSTEMTIME(AObj));
end;

class function _SYSTEMTIME_sw.GetTypeName: WideString;
begin
  Result := '_SYSTEMTIME';
end;

function _SYSTEMTIME_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _SYSTEMTIME_sw.Create;
  _SYSTEMTIME_sw(Result).FValue := FValue;
end;

class procedure _SYSTEMTIME_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('wYear', _SYSTEMTIME_wYear_si, Word_sw);
  AData.AddField('wMonth', _SYSTEMTIME_wMonth_si, Word_sw);
  AData.AddField('wDayOfWeek', _SYSTEMTIME_wDayOfWeek_si, Word_sw);
  AData.AddField('wDay', _SYSTEMTIME_wDay_si, Word_sw);
  AData.AddField('wHour', _SYSTEMTIME_wHour_si, Word_sw);
  AData.AddField('wMinute', _SYSTEMTIME_wMinute_si, Word_sw);
  AData.AddField('wSecond', _SYSTEMTIME_wSecond_si, Word_sw);
  AData.AddField('wMilliseconds', _SYSTEMTIME_wMilliseconds_si, Word_sw);
  AData.AddFunction('Copy', _SYSTEMTIME_Copy_si, _SYSTEMTIME_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _SYSTEMTIME_Create_si, 0, False);
end;

class function _SYSTEMTIME_sw.ToVar(const AValue: _SYSTEMTIME): OleVariant;
var
  wrpr: _SYSTEMTIME_sw;
begin
  wrpr        := _SYSTEMTIME_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _SYSTEMTIME_sw.FromVar(const AValue: OleVariant): _SYSTEMTIME;
begin
  Result := _SYSTEMTIME_sw(ConvFromVar(AValue)).FValue;
end;

{ _WIN32_FIND_DATAW_sw }

function _WIN32_FIND_DATAW_dwFileAttributes_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwFileAttributes: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_WIN32_FIND_DATAW_sw(AObj).FValue.dwFileAttributes)
  else
    _WIN32_FIND_DATAW_sw(AObj).FValue.dwFileAttributes := DWORD_sw.FromVar(
      AArgs[0]);
end;

function _WIN32_FIND_DATAW_ftCreationTime_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ftCreationTime: TFileTime;

  if IsGet then
    Result := TFileTime_sw.ToVar(_WIN32_FIND_DATAW_sw(AObj).FValue.
      ftCreationTime)
  else
    _WIN32_FIND_DATAW_sw(AObj).FValue.ftCreationTime := TFileTime_sw.FromVar(
      AArgs[0]);
end;

function _WIN32_FIND_DATAW_ftLastAccessTime_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ftLastAccessTime: TFileTime;

  if IsGet then
    Result := TFileTime_sw.ToVar(_WIN32_FIND_DATAW_sw(AObj).FValue.
      ftLastAccessTime)
  else
    _WIN32_FIND_DATAW_sw(AObj).FValue.ftLastAccessTime := TFileTime_sw.FromVar(
      AArgs[0]);
end;

function _WIN32_FIND_DATAW_ftLastWriteTime_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ftLastWriteTime: TFileTime;

  if IsGet then
    Result := TFileTime_sw.ToVar(_WIN32_FIND_DATAW_sw(AObj).FValue.
      ftLastWriteTime)
  else
    _WIN32_FIND_DATAW_sw(AObj).FValue.ftLastWriteTime := TFileTime_sw.FromVar(
      AArgs[0]);
end;

function _WIN32_FIND_DATAW_nFileSizeHigh_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nFileSizeHigh: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_WIN32_FIND_DATAW_sw(AObj).FValue.nFileSizeHigh)
  else
    _WIN32_FIND_DATAW_sw(AObj).FValue.nFileSizeHigh := DWORD_sw.FromVar(
      AArgs[0]);
end;

function _WIN32_FIND_DATAW_nFileSizeLow_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nFileSizeLow: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_WIN32_FIND_DATAW_sw(AObj).FValue.nFileSizeLow)
  else
    _WIN32_FIND_DATAW_sw(AObj).FValue.nFileSizeLow := DWORD_sw.FromVar(
      AArgs[0]);
end;

function _WIN32_FIND_DATAW_dwReserved0_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwReserved0: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_WIN32_FIND_DATAW_sw(AObj).FValue.dwReserved0)
  else
    _WIN32_FIND_DATAW_sw(AObj).FValue.dwReserved0 := DWORD_sw.FromVar(AArgs[0]);
end;

function _WIN32_FIND_DATAW_dwReserved1_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwReserved1: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_WIN32_FIND_DATAW_sw(AObj).FValue.dwReserved1)
  else
    _WIN32_FIND_DATAW_sw(AObj).FValue.dwReserved1 := DWORD_sw.FromVar(AArgs[0]);
end;

function _WIN32_FIND_DATAW_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _WIN32_FIND_DATAW_sw.Create as IDispatch;
end;

function _WIN32_FIND_DATAW_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _WIN32_FIND_DATAW;

  // Implicit record copy method.
  Result := _WIN32_FIND_DATAW_sw.ToVar(_WIN32_FIND_DATAW(AObj));
end;

class function _WIN32_FIND_DATAW_sw.GetTypeName: WideString;
begin
  Result := '_WIN32_FIND_DATAW';
end;

function _WIN32_FIND_DATAW_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _WIN32_FIND_DATAW_sw.Create;
  _WIN32_FIND_DATAW_sw(Result).FValue := FValue;
end;

class procedure _WIN32_FIND_DATAW_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('dwFileAttributes', _WIN32_FIND_DATAW_dwFileAttributes_si, DWORD_sw);
  AData.AddField('ftCreationTime', _WIN32_FIND_DATAW_ftCreationTime_si, TFileTime_sw);
  AData.AddField('ftLastAccessTime', _WIN32_FIND_DATAW_ftLastAccessTime_si, TFileTime_sw);
  AData.AddField('ftLastWriteTime', _WIN32_FIND_DATAW_ftLastWriteTime_si, TFileTime_sw);
  AData.AddField('nFileSizeHigh', _WIN32_FIND_DATAW_nFileSizeHigh_si, DWORD_sw);
  AData.AddField('nFileSizeLow', _WIN32_FIND_DATAW_nFileSizeLow_si, DWORD_sw);
  AData.AddField('dwReserved0', _WIN32_FIND_DATAW_dwReserved0_si, DWORD_sw);
  AData.AddField('dwReserved1', _WIN32_FIND_DATAW_dwReserved1_si, DWORD_sw);
  AData.AddFunction('Copy', _WIN32_FIND_DATAW_Copy_si, _WIN32_FIND_DATAW_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _WIN32_FIND_DATAW_Create_si, 0, False);
end;

class function _WIN32_FIND_DATAW_sw.ToVar(
  const AValue: _WIN32_FIND_DATAW): OleVariant;
var
  wrpr: _WIN32_FIND_DATAW_sw;
begin
  wrpr        := _WIN32_FIND_DATAW_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _WIN32_FIND_DATAW_sw.FromVar(
  const AValue: OleVariant): _WIN32_FIND_DATAW;
begin
  Result := _WIN32_FIND_DATAW_sw(ConvFromVar(AValue)).FValue;
end;

{ tagLOGFONTW_sw }

function tagLOGFONTW_lfHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfHeight: Longint;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfHeight
  else
    tagLOGFONTW_sw(AObj).FValue.lfHeight := Longint(AArgs[0]);
end;

function tagLOGFONTW_lfWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfWidth: Longint;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfWidth
  else
    tagLOGFONTW_sw(AObj).FValue.lfWidth := Longint(AArgs[0]);
end;

function tagLOGFONTW_lfEscapement_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfEscapement: Longint;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfEscapement
  else
    tagLOGFONTW_sw(AObj).FValue.lfEscapement := Longint(AArgs[0]);
end;

function tagLOGFONTW_lfOrientation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfOrientation: Longint;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfOrientation
  else
    tagLOGFONTW_sw(AObj).FValue.lfOrientation := Longint(AArgs[0]);
end;

function tagLOGFONTW_lfWeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfWeight: Longint;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfWeight
  else
    tagLOGFONTW_sw(AObj).FValue.lfWeight := Longint(AArgs[0]);
end;

function tagLOGFONTW_lfItalic_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfItalic: Byte;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfItalic
  else
    tagLOGFONTW_sw(AObj).FValue.lfItalic := Byte(AArgs[0]);
end;

function tagLOGFONTW_lfUnderline_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfUnderline: Byte;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfUnderline
  else
    tagLOGFONTW_sw(AObj).FValue.lfUnderline := Byte(AArgs[0]);
end;

function tagLOGFONTW_lfStrikeOut_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfStrikeOut: Byte;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfStrikeOut
  else
    tagLOGFONTW_sw(AObj).FValue.lfStrikeOut := Byte(AArgs[0]);
end;

function tagLOGFONTW_lfCharSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfCharSet: Byte;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfCharSet
  else
    tagLOGFONTW_sw(AObj).FValue.lfCharSet := Byte(AArgs[0]);
end;

function tagLOGFONTW_lfOutPrecision_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfOutPrecision: Byte;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfOutPrecision
  else
    tagLOGFONTW_sw(AObj).FValue.lfOutPrecision := Byte(AArgs[0]);
end;

function tagLOGFONTW_lfClipPrecision_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfClipPrecision: Byte;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfClipPrecision
  else
    tagLOGFONTW_sw(AObj).FValue.lfClipPrecision := Byte(AArgs[0]);
end;

function tagLOGFONTW_lfQuality_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfQuality: Byte;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfQuality
  else
    tagLOGFONTW_sw(AObj).FValue.lfQuality := Byte(AArgs[0]);
end;

function tagLOGFONTW_lfPitchAndFamily_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lfPitchAndFamily: Byte;

  if IsGet then
    Result := tagLOGFONTW_sw(AObj).FValue.lfPitchAndFamily
  else
    tagLOGFONTW_sw(AObj).FValue.lfPitchAndFamily := Byte(AArgs[0]);
end;

function tagLOGFONTW_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := tagLOGFONTW_sw.Create as IDispatch;
end;

function tagLOGFONTW_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: tagLOGFONTW;

  // Implicit record copy method.
  Result := tagLOGFONTW_sw.ToVar(tagLOGFONTW(AObj));
end;

class function tagLOGFONTW_sw.GetTypeName: WideString;
begin
  Result := 'tagLOGFONTW';
end;

function tagLOGFONTW_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := tagLOGFONTW_sw.Create;
  tagLOGFONTW_sw(Result).FValue := FValue;
end;

class procedure tagLOGFONTW_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('lfHeight', tagLOGFONTW_lfHeight_si, Longint_sw);
  AData.AddField('lfWidth', tagLOGFONTW_lfWidth_si, Longint_sw);
  AData.AddField('lfEscapement', tagLOGFONTW_lfEscapement_si, Longint_sw);
  AData.AddField('lfOrientation', tagLOGFONTW_lfOrientation_si, Longint_sw);
  AData.AddField('lfWeight', tagLOGFONTW_lfWeight_si, Longint_sw);
  AData.AddField('lfItalic', tagLOGFONTW_lfItalic_si, Byte_sw);
  AData.AddField('lfUnderline', tagLOGFONTW_lfUnderline_si, Byte_sw);
  AData.AddField('lfStrikeOut', tagLOGFONTW_lfStrikeOut_si, Byte_sw);
  AData.AddField('lfCharSet', tagLOGFONTW_lfCharSet_si, Byte_sw);
  AData.AddField('lfOutPrecision', tagLOGFONTW_lfOutPrecision_si, Byte_sw);
  AData.AddField('lfClipPrecision', tagLOGFONTW_lfClipPrecision_si, Byte_sw);
  AData.AddField('lfQuality', tagLOGFONTW_lfQuality_si, Byte_sw);
  AData.AddField('lfPitchAndFamily', tagLOGFONTW_lfPitchAndFamily_si, Byte_sw);
  AData.AddFunction('Copy', tagLOGFONTW_Copy_si, tagLOGFONTW_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', tagLOGFONTW_Create_si, 0, False);
end;

class function tagLOGFONTW_sw.ToVar(const AValue: tagLOGFONTW): OleVariant;
var
  wrpr: tagLOGFONTW_sw;
begin
  wrpr        := tagLOGFONTW_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function tagLOGFONTW_sw.FromVar(const AValue: OleVariant): tagLOGFONTW;
begin
  Result := tagLOGFONTW_sw(ConvFromVar(AValue)).FValue;
end;

{ tagWNDCLASSW_sw }

function tagWNDCLASSW_style_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var style: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(tagWNDCLASSW_sw(AObj).FValue.style)
  else
    tagWNDCLASSW_sw(AObj).FValue.style := UINT_sw.FromVar(AArgs[0]);
end;

function tagWNDCLASSW_cbClsExtra_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbClsExtra: Integer;

  if IsGet then
    Result := tagWNDCLASSW_sw(AObj).FValue.cbClsExtra
  else
    tagWNDCLASSW_sw(AObj).FValue.cbClsExtra := Integer(AArgs[0]);
end;

function tagWNDCLASSW_cbWndExtra_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbWndExtra: Integer;

  if IsGet then
    Result := tagWNDCLASSW_sw(AObj).FValue.cbWndExtra
  else
    tagWNDCLASSW_sw(AObj).FValue.cbWndExtra := Integer(AArgs[0]);
end;

function tagWNDCLASSW_hInstance_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hInstance: HINST;

  if IsGet then
    Result := HINST_sw.ToVar(tagWNDCLASSW_sw(AObj).FValue.hInstance)
  else
    tagWNDCLASSW_sw(AObj).FValue.hInstance := HINST_sw.FromVar(AArgs[0]);
end;

function tagWNDCLASSW_hIcon_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hIcon: HICON;

  if IsGet then
    Result := HICON_sw.ToVar(tagWNDCLASSW_sw(AObj).FValue.hIcon)
  else
    tagWNDCLASSW_sw(AObj).FValue.hIcon := HICON_sw.FromVar(AArgs[0]);
end;

function tagWNDCLASSW_hCursor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hCursor: HCURSOR;

  if IsGet then
    Result := HCURSOR_sw.ToVar(tagWNDCLASSW_sw(AObj).FValue.hCursor)
  else
    tagWNDCLASSW_sw(AObj).FValue.hCursor := HCURSOR_sw.FromVar(AArgs[0]);
end;

function tagWNDCLASSW_hbrBackground_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hbrBackground: HBRUSH;

  if IsGet then
    Result := HBRUSH_sw.ToVar(tagWNDCLASSW_sw(AObj).FValue.hbrBackground)
  else
    tagWNDCLASSW_sw(AObj).FValue.hbrBackground := HBRUSH_sw.FromVar(AArgs[0]);
end;

function tagWNDCLASSW_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := tagWNDCLASSW_sw.Create as IDispatch;
end;

function tagWNDCLASSW_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: tagWNDCLASSW;

  // Implicit record copy method.
  Result := tagWNDCLASSW_sw.ToVar(tagWNDCLASSW(AObj));
end;

class function tagWNDCLASSW_sw.GetTypeName: WideString;
begin
  Result := 'tagWNDCLASSW';
end;

function tagWNDCLASSW_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := tagWNDCLASSW_sw.Create;
  tagWNDCLASSW_sw(Result).FValue := FValue;
end;

class procedure tagWNDCLASSW_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('style', tagWNDCLASSW_style_si, UINT_sw);
  AData.AddField('cbClsExtra', tagWNDCLASSW_cbClsExtra_si, Integer_sw);
  AData.AddField('cbWndExtra', tagWNDCLASSW_cbWndExtra_si, Integer_sw);
  AData.AddField('hInstance', tagWNDCLASSW_hInstance_si, HINST_sw);
  AData.AddField('hIcon', tagWNDCLASSW_hIcon_si, HICON_sw);
  AData.AddField('hCursor', tagWNDCLASSW_hCursor_si, HCURSOR_sw);
  AData.AddField('hbrBackground', tagWNDCLASSW_hbrBackground_si, HBRUSH_sw);
  AData.AddFunction('Copy', tagWNDCLASSW_Copy_si, tagWNDCLASSW_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', tagWNDCLASSW_Create_si, 0, False);
end;

class function tagWNDCLASSW_sw.ToVar(const AValue: tagWNDCLASSW): OleVariant;
var
  wrpr: tagWNDCLASSW_sw;
begin
  wrpr        := tagWNDCLASSW_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function tagWNDCLASSW_sw.FromVar(const AValue: OleVariant): tagWNDCLASSW;
begin
  Result := tagWNDCLASSW_sw(ConvFromVar(AValue)).FValue;
end;

{ tagMSG_sw }

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

function tagMSG_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := tagMSG_sw.Create as IDispatch;
end;

function tagMSG_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Copy: tagMSG;

  // Implicit record copy method.
  Result := tagMSG_sw.ToVar(tagMSG(AObj));
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

  AData.AddField('hwnd', tagMSG_hwnd_si, HWND_sw);
  AData.AddField('message', tagMSG_message_si, UINT_sw);
  AData.AddField('wParam', tagMSG_wParam_si, WPARAM_sw);
  AData.AddField('lParam', tagMSG_lParam_si, LPARAM_sw);
  AData.AddField('time', tagMSG_time_si, DWORD_sw);
  AData.AddField('pt', tagMSG_pt_si, TPoint_sw);
  AData.AddFunction('Copy', tagMSG_Copy_si, tagMSG_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', tagMSG_Create_si, 0, False);
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

function Windows_DWORD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type DWORD = System.Types.DWORD;

  Result := TLMDUnitWrapper.TypeToVar(DWORD_sw);
end;

function Windows_BOOL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type BOOL = LongBool;

  Result := TLMDUnitWrapper.TypeToVar(BOOL_sw);
end;

function Windows_UINT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UINT = LongWord;

  Result := TLMDUnitWrapper.TypeToVar(UINT_sw);
end;

function Windows_LCID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LCID = DWORD;

  Result := TLMDUnitWrapper.TypeToVar(LCID_sw);
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
  // type INT_PTR = System.IntPtr;

  Result := TLMDUnitWrapper.TypeToVar(INT_PTR_sw);
end;

function Windows_UINT_PTR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UINT_PTR = System.UIntPtr;

  Result := TLMDUnitWrapper.TypeToVar(UINT_PTR_sw);
end;

function Windows__FLOATING_SAVE_AREA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _FLOATING_SAVE_AREA = record;

  Result := TLMDUnitWrapper.TypeToVar(_FLOATING_SAVE_AREA_sw);
end;

function Windows_TFloatingSaveArea_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFloatingSaveArea = _FLOATING_SAVE_AREA;

  Result := TLMDUnitWrapper.TypeToVar(TFloatingSaveArea_sw);
end;

function Windows_FLOATING_SAVE_AREA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type FLOATING_SAVE_AREA = _FLOATING_SAVE_AREA;

  Result := TLMDUnitWrapper.TypeToVar(FLOATING_SAVE_AREA_sw);
end;

function Windows__CONTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _CONTEXT = record;

  Result := TLMDUnitWrapper.TypeToVar(_CONTEXT_sw);
end;

function Windows_WPARAM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type WPARAM = UINT_PTR;

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

function Windows_HWND_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HWND = UINT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(HWND_sw);
end;

function Windows_HACCEL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HACCEL = UINT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(HACCEL_sw);
end;

function Windows_HBITMAP_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HBITMAP = UINT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(HBITMAP_sw);
end;

function Windows_HBRUSH_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HBRUSH = UINT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(HBRUSH_sw);
end;

function Windows_HDC_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type HDC = UINT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(HDC_sw);
end;

function Windows_HFONT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HFONT = UINT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(HFONT_sw);
end;

function Windows_HICON_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HICON = UINT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(HICON_sw);
end;

function Windows_HMENU_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HMENU = UINT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(HMENU_sw);
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
  // type HPALETTE = UINT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(HPALETTE_sw);
end;

function Windows_HPEN_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type HPEN = UINT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(HPEN_sw);
end;

function Windows_HKL_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // type HKL = UINT_PTR;

  Result := TLMDUnitWrapper.TypeToVar(HKL_sw);
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

function Windows_TPoint_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPoint = System.Types.TPoint;

  Result := TLMDUnitWrapper.TypeToVar(TPoint_sw);
end;

function Windows_TRect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRect = System.Types.TRect;

  Result := TLMDUnitWrapper.TypeToVar(TRect_sw);
end;

function Windows_TSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSize = System.Types.TSize;

  Result := TLMDUnitWrapper.TypeToVar(TSize_sw);
end;

function Windows__FILETIME_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _FILETIME = record;

  Result := TLMDUnitWrapper.TypeToVar(_FILETIME_sw);
end;

function Windows_TFileTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFileTime = _FILETIME;

  Result := TLMDUnitWrapper.TypeToVar(TFileTime_sw);
end;

function Windows__SYSTEMTIME_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _SYSTEMTIME = record;

  Result := TLMDUnitWrapper.TypeToVar(_SYSTEMTIME_sw);
end;

function Windows_TSystemTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSystemTime = _SYSTEMTIME;

  Result := TLMDUnitWrapper.TypeToVar(TSystemTime_sw);
end;

function Windows__WIN32_FIND_DATAW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _WIN32_FIND_DATAW = record;

  Result := TLMDUnitWrapper.TypeToVar(_WIN32_FIND_DATAW_sw);
end;

function Windows_TWin32FindDataW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWin32FindDataW = _WIN32_FIND_DATAW;

  Result := TLMDUnitWrapper.TypeToVar(TWin32FindDataW_sw);
end;

function Windows_TWin32FindData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWin32FindData = TWin32FindDataW;

  Result := TLMDUnitWrapper.TypeToVar(TWin32FindData_sw);
end;

function Windows_tagLOGFONTW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagLOGFONTW = record;

  Result := TLMDUnitWrapper.TypeToVar(tagLOGFONTW_sw);
end;

function Windows_LOGFONTW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LOGFONTW = tagLOGFONTW;

  Result := TLMDUnitWrapper.TypeToVar(LOGFONTW_sw);
end;

function Windows_LOGFONT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type LOGFONT = LOGFONTW;

  Result := TLMDUnitWrapper.TypeToVar(LOGFONT_sw);
end;

function Windows_tagWNDCLASSW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type tagWNDCLASSW = record;

  Result := TLMDUnitWrapper.TypeToVar(tagWNDCLASSW_sw);
end;

function Windows_TWndClassW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWndClassW = tagWNDCLASSW;

  Result := TLMDUnitWrapper.TypeToVar(TWndClassW_sw);
end;

function Windows_TWndClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TWndClass = TWndClassW;

  Result := TLMDUnitWrapper.TypeToVar(TWndClass_sw);
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

class function Windows_sw.GetUnitName: WideString;
begin
  Result := 'Windows';
end;

class procedure Windows_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(DWORD_sw, Windows_DWORD_si);
  AData.AddType(BOOL_sw, Windows_BOOL_si);
  AData.AddType(UINT_sw, Windows_UINT_si);
  AData.AddType(LCID_sw, Windows_LCID_si);
  AData.AddType(THandle_sw, Windows_THandle_si);
  AData.AddType(INT_PTR_sw, Windows_INT_PTR_si);
  AData.AddType(UINT_PTR_sw, Windows_UINT_PTR_si);
  AData.AddType(_FLOATING_SAVE_AREA_sw, Windows__FLOATING_SAVE_AREA_si);
  AData.AddType(TFloatingSaveArea_sw, Windows_TFloatingSaveArea_si);
  AData.AddType(FLOATING_SAVE_AREA_sw, Windows_FLOATING_SAVE_AREA_si);
  AData.AddType(_CONTEXT_sw, Windows__CONTEXT_si);
  AData.AddType(WPARAM_sw, Windows_WPARAM_si);
  AData.AddType(LPARAM_sw, Windows_LPARAM_si);
  AData.AddType(LRESULT_sw, Windows_LRESULT_si);
  AData.AddType(HWND_sw, Windows_HWND_si);
  AData.AddType(HACCEL_sw, Windows_HACCEL_si);
  AData.AddType(HBITMAP_sw, Windows_HBITMAP_si);
  AData.AddType(HBRUSH_sw, Windows_HBRUSH_si);
  AData.AddType(HDC_sw, Windows_HDC_si);
  AData.AddType(HFONT_sw, Windows_HFONT_si);
  AData.AddType(HICON_sw, Windows_HICON_si);
  AData.AddType(HMENU_sw, Windows_HMENU_si);
  AData.AddType(HINST_sw, Windows_HINST_si);
  AData.AddType(HMODULE_sw, Windows_HMODULE_si);
  AData.AddType(HPALETTE_sw, Windows_HPALETTE_si);
  AData.AddType(HPEN_sw, Windows_HPEN_si);
  AData.AddType(HKL_sw, Windows_HKL_si);
  AData.AddType(HCURSOR_sw, Windows_HCURSOR_si);
  AData.AddType(COLORREF_sw, Windows_COLORREF_si);
  AData.AddType(TPoint_sw, Windows_TPoint_si);
  AData.AddType(TRect_sw, Windows_TRect_si);
  AData.AddType(TSize_sw, Windows_TSize_si);
  AData.AddType(_FILETIME_sw, Windows__FILETIME_si);
  AData.AddType(TFileTime_sw, Windows_TFileTime_si);
  AData.AddType(_SYSTEMTIME_sw, Windows__SYSTEMTIME_si);
  AData.AddType(TSystemTime_sw, Windows_TSystemTime_si);
  AData.AddType(_WIN32_FIND_DATAW_sw, Windows__WIN32_FIND_DATAW_si);
  AData.AddType(TWin32FindDataW_sw, Windows_TWin32FindDataW_si);
  AData.AddType(TWin32FindData_sw, Windows_TWin32FindData_si);
  AData.AddType(tagLOGFONTW_sw, Windows_tagLOGFONTW_si);
  AData.AddType(LOGFONTW_sw, Windows_LOGFONTW_si);
  AData.AddType(LOGFONT_sw, Windows_LOGFONT_si);
  AData.AddType(tagWNDCLASSW_sw, Windows_tagWNDCLASSW_si);
  AData.AddType(TWndClassW_sw, Windows_TWndClassW_si);
  AData.AddType(TWndClass_sw, Windows_TWndClass_si);
  AData.AddType(tagMSG_sw, Windows_tagMSG_si);
  AData.AddType(TMsg_sw, Windows_TMsg_si);
end;

class function Windows_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Windows_sw);
end;

initialization
  RegisterUnitWrapper(Windows_sw);

end.
