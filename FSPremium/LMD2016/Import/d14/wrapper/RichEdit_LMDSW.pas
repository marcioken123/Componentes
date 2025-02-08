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
  Types, Classes, SysUtils, Variants, TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Messages, Windows, RichEdit,
  Messages_LMDSW, Windows_LMDSW;


{ Type wrappers }

type

  TCharFormatA_sw = class(TLMDRecordWrapper)
  private
    FValue: TCharFormatA;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCharFormatA): OleVariant;
    class function FromVar(const AValue: OleVariant): TCharFormatA;
  end;

  TCharFormatW_sw = class(TLMDRecordWrapper)
  private
    FValue: TCharFormatW;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TCharFormatW): OleVariant;
    class function FromVar(const AValue: OleVariant): TCharFormatW;
  end;

  TCharFormat_sw = TCharFormatW_sw;

  _charrange_sw = class(TLMDRecordWrapper)
  private
    FValue: _charrange;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _charrange): OleVariant;
    class function FromVar(const AValue: OleVariant): _charrange;
  end;

  TCharRange_sw = _charrange_sw;

  CHARRANGE_sw = _charrange_sw;

  TEXTRANGEA_sw = class(TLMDRecordWrapper)
  private
    FValue: TEXTRANGEA;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TEXTRANGEA): OleVariant;
    class function FromVar(const AValue: OleVariant): TEXTRANGEA;
  end;

  TTextRangeA_sw = TEXTRANGEA_sw;

  TEXTRANGEW_sw = class(TLMDRecordWrapper)
  private
    FValue: TEXTRANGEW;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TEXTRANGEW): OleVariant;
    class function FromVar(const AValue: OleVariant): TEXTRANGEW;
  end;

  TTextRangeW_sw = TEXTRANGEW_sw;

  TEXTRANGE_sw = TEXTRANGEW_sw;

  _editstream_sw = class(TLMDRecordWrapper)
  private
    FValue: _editstream;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _editstream): OleVariant;
    class function FromVar(const AValue: OleVariant): _editstream;
  end;

  TEditStream_sw = _editstream_sw;

  EDITSTREAM_sw = _editstream_sw;

  FINDTEXTA_sw = class(TLMDRecordWrapper)
  private
    FValue: FINDTEXTA;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: FINDTEXTA): OleVariant;
    class function FromVar(const AValue: OleVariant): FINDTEXTA;
  end;

  FINDTEXTW_sw = class(TLMDRecordWrapper)
  private
    FValue: FINDTEXTW;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: FINDTEXTW): OleVariant;
    class function FromVar(const AValue: OleVariant): FINDTEXTW;
  end;

  FINDTEXT_sw = FINDTEXTW_sw;

  TFindTextA_sw = FINDTEXTA_sw;

  TFindTextW_sw = FINDTEXTW_sw;

  TFindText_sw = TFindTextW_sw;

  FINDTEXTEXA_sw = class(TLMDRecordWrapper)
  private
    FValue: FINDTEXTEXA;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: FINDTEXTEXA): OleVariant;
    class function FromVar(const AValue: OleVariant): FINDTEXTEXA;
  end;

  FINDTEXTEXW_sw = class(TLMDRecordWrapper)
  private
    FValue: FINDTEXTEXW;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: FINDTEXTEXW): OleVariant;
    class function FromVar(const AValue: OleVariant): FINDTEXTEXW;
  end;

  FINDTEXTEX_sw = FINDTEXTEXW_sw;

  TFindTextExA_sw = FINDTEXTEXA_sw;

  TFindTextExW_sw = FINDTEXTEXW_sw;

  TFindTextEx_sw = TFindTextExW_sw;

  _formatrange_sw = class(TLMDRecordWrapper)
  private
    FValue: _formatrange;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _formatrange): OleVariant;
    class function FromVar(const AValue: OleVariant): _formatrange;
  end;

  TFormatRange_sw = _formatrange_sw;

  FORMATRANGE_sw = _formatrange_sw;

  _paraformat_sw = class(TLMDRecordWrapper)
  private
    FValue: _paraformat;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _paraformat): OleVariant;
    class function FromVar(const AValue: OleVariant): _paraformat;
  end;

  TParaFormat_sw = _paraformat_sw;

  PARAFORMAT_sw = _paraformat_sw;

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

  CHARFORMAT2A_sw = _CHARFORMAT2A_sw;

  CHARFORMAT2W_sw = _CHARFORMAT2W_sw;

  CHARFORMAT2_sw = CHARFORMAT2W_sw;

  TCharFormat2A_sw = _CHARFORMAT2A_sw;

  TCharFormat2W_sw = _CHARFORMAT2W_sw;

  TCharFormat2_sw = TCharFormat2W_sw;

  PARAFORMAT2_sw = class(TLMDRecordWrapper)
  private
    FValue: PARAFORMAT2;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: PARAFORMAT2): OleVariant;
    class function FromVar(const AValue: OleVariant): PARAFORMAT2;
  end;

  TParaFormat2_sw = PARAFORMAT2_sw;

  _msgfilter_sw = class(TLMDRecordWrapper)
  private
    FValue: _msgfilter;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _msgfilter): OleVariant;
    class function FromVar(const AValue: OleVariant): _msgfilter;
  end;

  TMsgFilter_sw = _msgfilter_sw;

  MSGFILTER_sw = _msgfilter_sw;

  TReqSize_sw = class(TLMDRecordWrapper)
  private
    FValue: TReqSize;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TReqSize): OleVariant;
    class function FromVar(const AValue: OleVariant): TReqSize;
  end;

  _selchange_sw = class(TLMDRecordWrapper)
  private
    FValue: _selchange;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _selchange): OleVariant;
    class function FromVar(const AValue: OleVariant): _selchange;
  end;

  TSelChange_sw = _selchange_sw;

  SELCHANGE_sw = _selchange_sw;

  TEndDropFiles_sw = class(TLMDRecordWrapper)
  private
    FValue: TEndDropFiles;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TEndDropFiles): OleVariant;
    class function FromVar(const AValue: OleVariant): TEndDropFiles;
  end;

  _enprotected_sw = class(TLMDRecordWrapper)
  private
    FValue: _enprotected;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _enprotected): OleVariant;
    class function FromVar(const AValue: OleVariant): _enprotected;
  end;

  TENProtected_sw = _enprotected_sw;

  ENPROTECTED_sw = _enprotected_sw;

  _ensaveclipboard_sw = class(TLMDRecordWrapper)
  private
    FValue: _ensaveclipboard;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _ensaveclipboard): OleVariant;
    class function FromVar(const AValue: OleVariant): _ensaveclipboard;
  end;

  TENSaveClipboard_sw = _ensaveclipboard_sw;

  ENSAVECLIPBOARD_sw = _ensaveclipboard_sw;

  ENOLEOPFAILED_sw = class(TLMDRecordWrapper)
  private
    FValue: ENOLEOPFAILED;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: ENOLEOPFAILED): OleVariant;
    class function FromVar(const AValue: OleVariant): ENOLEOPFAILED;
  end;

  TENOleOpFailed_sw = ENOLEOPFAILED_sw;

  OBJECTPOSITIONS_sw = class(TLMDRecordWrapper)
  private
    FValue: OBJECTPOSITIONS;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: OBJECTPOSITIONS): OleVariant;
    class function FromVar(const AValue: OleVariant): OBJECTPOSITIONS;
  end;

  TObjectPositions_sw = OBJECTPOSITIONS_sw;

  ENLINK_sw = class(TLMDRecordWrapper)
  private
    FValue: ENLINK;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: ENLINK): OleVariant;
    class function FromVar(const AValue: OleVariant): ENLINK;
  end;

  TENLink_sw = ENLINK_sw;

  _encorrecttext_sw = class(TLMDRecordWrapper)
  private
    FValue: _encorrecttext;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _encorrecttext): OleVariant;
    class function FromVar(const AValue: OleVariant): _encorrecttext;
  end;

  TENCorrectText_sw = _encorrecttext_sw;

  ENCORRECTTEXT_sw = _encorrecttext_sw;

  _punctuation_sw = class(TLMDRecordWrapper)
  private
    FValue: _punctuation;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _punctuation): OleVariant;
    class function FromVar(const AValue: OleVariant): _punctuation;
  end;

  TPunctuation_sw = _punctuation_sw;

  PUNCTUATION_sw = _punctuation_sw;

  _compcolor_sw = class(TLMDRecordWrapper)
  private
    FValue: _compcolor;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _compcolor): OleVariant;
    class function FromVar(const AValue: OleVariant): _compcolor;
  end;

  TCompColor_sw = _compcolor_sw;

  COMPCOLOR_sw = _compcolor_sw;

  _repastespecial_sw = class(TLMDRecordWrapper)
  private
    FValue: _repastespecial;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: _repastespecial): OleVariant;
    class function FromVar(const AValue: OleVariant): _repastespecial;
  end;

  TRepasteSpecial_sw = _repastespecial_sw;

  REPASTESPECIAL_sw = _repastespecial_sw;

  UNDONAMEID_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: UNDONAMEID): OleVariant;
    class function FromVar(const AValue: OleVariant): UNDONAMEID;
  end;

  GETTEXTEX_sw = class(TLMDRecordWrapper)
  private
    FValue: GETTEXTEX;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: GETTEXTEX): OleVariant;
    class function FromVar(const AValue: OleVariant): GETTEXTEX;
  end;

  TGetTextEx_sw = GETTEXTEX_sw;

  GETTEXTLENGTHEX_sw = class(TLMDRecordWrapper)
  private
    FValue: GETTEXTLENGTHEX;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: GETTEXTLENGTHEX): OleVariant;
    class function FromVar(const AValue: OleVariant): GETTEXTLENGTHEX;
  end;

  TGetTextLengthEx_sw = GETTEXTLENGTHEX_sw;

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

{ TCharFormatA_sw }

function TCharFormatA_cbSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbSize: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(TCharFormatA_sw(AObj).FValue.cbSize)
  else
    TCharFormatA_sw(AObj).FValue.cbSize := UINT_sw.FromVar(AArgs[0]);
end;

function TCharFormatA_dwMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwMask: Longint;

  if IsGet then
    Result := TCharFormatA_sw(AObj).FValue.dwMask
  else
    TCharFormatA_sw(AObj).FValue.dwMask := Longint(AArgs[0]);
end;

function TCharFormatA_dwEffects_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwEffects: Longint;

  if IsGet then
    Result := TCharFormatA_sw(AObj).FValue.dwEffects
  else
    TCharFormatA_sw(AObj).FValue.dwEffects := Longint(AArgs[0]);
end;

function TCharFormatA_yHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var yHeight: Longint;

  if IsGet then
    Result := TCharFormatA_sw(AObj).FValue.yHeight
  else
    TCharFormatA_sw(AObj).FValue.yHeight := Longint(AArgs[0]);
end;

function TCharFormatA_yOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var yOffset: Longint;

  if IsGet then
    Result := TCharFormatA_sw(AObj).FValue.yOffset
  else
    TCharFormatA_sw(AObj).FValue.yOffset := Longint(AArgs[0]);
end;

function TCharFormatA_crTextColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var crTextColor: TColorRef;

  if IsGet then
    Result := TColorRef_sw.ToVar(TCharFormatA_sw(AObj).FValue.crTextColor)
  else
    TCharFormatA_sw(AObj).FValue.crTextColor := TColorRef_sw.FromVar(AArgs[0]);
end;

function TCharFormatA_bCharSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bCharSet: Byte;

  if IsGet then
    Result := TCharFormatA_sw(AObj).FValue.bCharSet
  else
    TCharFormatA_sw(AObj).FValue.bCharSet := Byte(AArgs[0]);
end;

function TCharFormatA_bPitchAndFamily_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bPitchAndFamily: Byte;

  if IsGet then
    Result := TCharFormatA_sw(AObj).FValue.bPitchAndFamily
  else
    TCharFormatA_sw(AObj).FValue.bPitchAndFamily := Byte(AArgs[0]);
end;

function TCharFormatA_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCharFormatA_sw.Create as IDispatch;
end;

function TCharFormatA_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCharFormatA;

  // Implicit record copy method.
  Result := TCharFormatA_sw.ToVar(TCharFormatA(AObj));
end;

class function TCharFormatA_sw.GetTypeName: WideString;
begin
  Result := 'TCharFormatA';
end;

function TCharFormatA_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCharFormatA_sw.Create;
  TCharFormatA_sw(Result).FValue := FValue;
end;

class procedure TCharFormatA_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('cbSize', TCharFormatA_cbSize_si, UINT_sw);
  AData.AddField('dwMask', TCharFormatA_dwMask_si, Longint_sw);
  AData.AddField('dwEffects', TCharFormatA_dwEffects_si, Longint_sw);
  AData.AddField('yHeight', TCharFormatA_yHeight_si, Longint_sw);
  AData.AddField('yOffset', TCharFormatA_yOffset_si, Longint_sw);
  AData.AddField('crTextColor', TCharFormatA_crTextColor_si, TColorRef_sw);
  AData.AddField('bCharSet', TCharFormatA_bCharSet_si, Byte_sw);
  AData.AddField('bPitchAndFamily', TCharFormatA_bPitchAndFamily_si, Byte_sw);
  AData.AddFunction('Copy', TCharFormatA_Copy_si, TCharFormatA_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCharFormatA_Create_si, 0, False);
end;

class function TCharFormatA_sw.ToVar(const AValue: TCharFormatA): OleVariant;
var
  wrpr: TCharFormatA_sw;
begin
  wrpr        := TCharFormatA_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCharFormatA_sw.FromVar(const AValue: OleVariant): TCharFormatA;
begin
  Result := TCharFormatA_sw(ConvFromVar(AValue)).FValue;
end;

{ TCharFormatW_sw }

function TCharFormatW_cbSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbSize: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(TCharFormatW_sw(AObj).FValue.cbSize)
  else
    TCharFormatW_sw(AObj).FValue.cbSize := UINT_sw.FromVar(AArgs[0]);
end;

function TCharFormatW_dwMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwMask: Longint;

  if IsGet then
    Result := TCharFormatW_sw(AObj).FValue.dwMask
  else
    TCharFormatW_sw(AObj).FValue.dwMask := Longint(AArgs[0]);
end;

function TCharFormatW_dwEffects_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwEffects: Longint;

  if IsGet then
    Result := TCharFormatW_sw(AObj).FValue.dwEffects
  else
    TCharFormatW_sw(AObj).FValue.dwEffects := Longint(AArgs[0]);
end;

function TCharFormatW_yHeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var yHeight: Longint;

  if IsGet then
    Result := TCharFormatW_sw(AObj).FValue.yHeight
  else
    TCharFormatW_sw(AObj).FValue.yHeight := Longint(AArgs[0]);
end;

function TCharFormatW_yOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var yOffset: Longint;

  if IsGet then
    Result := TCharFormatW_sw(AObj).FValue.yOffset
  else
    TCharFormatW_sw(AObj).FValue.yOffset := Longint(AArgs[0]);
end;

function TCharFormatW_crTextColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var crTextColor: TColorRef;

  if IsGet then
    Result := TColorRef_sw.ToVar(TCharFormatW_sw(AObj).FValue.crTextColor)
  else
    TCharFormatW_sw(AObj).FValue.crTextColor := TColorRef_sw.FromVar(AArgs[0]);
end;

function TCharFormatW_bCharSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bCharSet: Byte;

  if IsGet then
    Result := TCharFormatW_sw(AObj).FValue.bCharSet
  else
    TCharFormatW_sw(AObj).FValue.bCharSet := Byte(AArgs[0]);
end;

function TCharFormatW_bPitchAndFamily_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bPitchAndFamily: Byte;

  if IsGet then
    Result := TCharFormatW_sw(AObj).FValue.bPitchAndFamily
  else
    TCharFormatW_sw(AObj).FValue.bPitchAndFamily := Byte(AArgs[0]);
end;

function TCharFormatW_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TCharFormatW_sw.Create as IDispatch;
end;

function TCharFormatW_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TCharFormatW;

  // Implicit record copy method.
  Result := TCharFormatW_sw.ToVar(TCharFormatW(AObj));
end;

class function TCharFormatW_sw.GetTypeName: WideString;
begin
  Result := 'TCharFormatW';
end;

function TCharFormatW_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TCharFormatW_sw.Create;
  TCharFormatW_sw(Result).FValue := FValue;
end;

class procedure TCharFormatW_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('cbSize', TCharFormatW_cbSize_si, UINT_sw);
  AData.AddField('dwMask', TCharFormatW_dwMask_si, Longint_sw);
  AData.AddField('dwEffects', TCharFormatW_dwEffects_si, Longint_sw);
  AData.AddField('yHeight', TCharFormatW_yHeight_si, Longint_sw);
  AData.AddField('yOffset', TCharFormatW_yOffset_si, Longint_sw);
  AData.AddField('crTextColor', TCharFormatW_crTextColor_si, TColorRef_sw);
  AData.AddField('bCharSet', TCharFormatW_bCharSet_si, Byte_sw);
  AData.AddField('bPitchAndFamily', TCharFormatW_bPitchAndFamily_si, Byte_sw);
  AData.AddFunction('Copy', TCharFormatW_Copy_si, TCharFormatW_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TCharFormatW_Create_si, 0, False);
end;

class function TCharFormatW_sw.ToVar(const AValue: TCharFormatW): OleVariant;
var
  wrpr: TCharFormatW_sw;
begin
  wrpr        := TCharFormatW_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TCharFormatW_sw.FromVar(const AValue: OleVariant): TCharFormatW;
begin
  Result := TCharFormatW_sw(ConvFromVar(AValue)).FValue;
end;

{ _charrange_sw }

function _charrange_cpMin_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cpMin: Longint;

  if IsGet then
    Result := _charrange_sw(AObj).FValue.cpMin
  else
    _charrange_sw(AObj).FValue.cpMin := Longint(AArgs[0]);
end;

function _charrange_cpMax_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cpMax: LongInt;

  if IsGet then
    Result := _charrange_sw(AObj).FValue.cpMax
  else
    _charrange_sw(AObj).FValue.cpMax := LongInt(AArgs[0]);
end;

function _charrange_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _charrange_sw.Create as IDispatch;
end;

function _charrange_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _charrange;

  // Implicit record copy method.
  Result := _charrange_sw.ToVar(_charrange(AObj));
end;

class function _charrange_sw.GetTypeName: WideString;
begin
  Result := '_charrange';
end;

function _charrange_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _charrange_sw.Create;
  _charrange_sw(Result).FValue := FValue;
end;

class procedure _charrange_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('cpMin', _charrange_cpMin_si, Longint_sw);
  AData.AddField('cpMax', _charrange_cpMax_si, LongInt_sw);
  AData.AddFunction('Copy', _charrange_Copy_si, _charrange_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _charrange_Create_si, 0, False);
end;

class function _charrange_sw.ToVar(const AValue: _charrange): OleVariant;
var
  wrpr: _charrange_sw;
begin
  wrpr        := _charrange_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _charrange_sw.FromVar(const AValue: OleVariant): _charrange;
begin
  Result := _charrange_sw(ConvFromVar(AValue)).FValue;
end;

{ TEXTRANGEA_sw }

function TEXTRANGEA_chrg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrg: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(TEXTRANGEA_sw(AObj).FValue.chrg)
  else
    TEXTRANGEA_sw(AObj).FValue.chrg := TCharRange_sw.FromVar(AArgs[0]);
end;

function TEXTRANGEA_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TEXTRANGEA_sw.Create as IDispatch;
end;

function TEXTRANGEA_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TEXTRANGEA;

  // Implicit record copy method.
  Result := TEXTRANGEA_sw.ToVar(TEXTRANGEA(AObj));
end;

class function TEXTRANGEA_sw.GetTypeName: WideString;
begin
  Result := 'TEXTRANGEA';
end;

function TEXTRANGEA_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TEXTRANGEA_sw.Create;
  TEXTRANGEA_sw(Result).FValue := FValue;
end;

class procedure TEXTRANGEA_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('chrg', TEXTRANGEA_chrg_si, TCharRange_sw);
  AData.AddFunction('Copy', TEXTRANGEA_Copy_si, TEXTRANGEA_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TEXTRANGEA_Create_si, 0, False);
end;

class function TEXTRANGEA_sw.ToVar(const AValue: TEXTRANGEA): OleVariant;
var
  wrpr: TEXTRANGEA_sw;
begin
  wrpr        := TEXTRANGEA_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TEXTRANGEA_sw.FromVar(const AValue: OleVariant): TEXTRANGEA;
begin
  Result := TEXTRANGEA_sw(ConvFromVar(AValue)).FValue;
end;

{ TEXTRANGEW_sw }

function TEXTRANGEW_chrg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrg: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(TEXTRANGEW_sw(AObj).FValue.chrg)
  else
    TEXTRANGEW_sw(AObj).FValue.chrg := TCharRange_sw.FromVar(AArgs[0]);
end;

function TEXTRANGEW_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TEXTRANGEW_sw.Create as IDispatch;
end;

function TEXTRANGEW_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TEXTRANGEW;

  // Implicit record copy method.
  Result := TEXTRANGEW_sw.ToVar(TEXTRANGEW(AObj));
end;

class function TEXTRANGEW_sw.GetTypeName: WideString;
begin
  Result := 'TEXTRANGEW';
end;

function TEXTRANGEW_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TEXTRANGEW_sw.Create;
  TEXTRANGEW_sw(Result).FValue := FValue;
end;

class procedure TEXTRANGEW_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('chrg', TEXTRANGEW_chrg_si, TCharRange_sw);
  AData.AddFunction('Copy', TEXTRANGEW_Copy_si, TEXTRANGEW_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TEXTRANGEW_Create_si, 0, False);
end;

class function TEXTRANGEW_sw.ToVar(const AValue: TEXTRANGEW): OleVariant;
var
  wrpr: TEXTRANGEW_sw;
begin
  wrpr        := TEXTRANGEW_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TEXTRANGEW_sw.FromVar(const AValue: OleVariant): TEXTRANGEW;
begin
  Result := TEXTRANGEW_sw(ConvFromVar(AValue)).FValue;
end;

{ _editstream_sw }

function _editstream_dwCookie_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwCookie: Longint;

  if IsGet then
    Result := _editstream_sw(AObj).FValue.dwCookie
  else
    _editstream_sw(AObj).FValue.dwCookie := Longint(AArgs[0]);
end;

function _editstream_dwError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwError: Longint;

  if IsGet then
    Result := _editstream_sw(AObj).FValue.dwError
  else
    _editstream_sw(AObj).FValue.dwError := Longint(AArgs[0]);
end;

function _editstream_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _editstream_sw.Create as IDispatch;
end;

function _editstream_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _editstream;

  // Implicit record copy method.
  Result := _editstream_sw.ToVar(_editstream(AObj));
end;

class function _editstream_sw.GetTypeName: WideString;
begin
  Result := '_editstream';
end;

function _editstream_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _editstream_sw.Create;
  _editstream_sw(Result).FValue := FValue;
end;

class procedure _editstream_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('dwCookie', _editstream_dwCookie_si, Longint_sw);
  AData.AddField('dwError', _editstream_dwError_si, Longint_sw);
  AData.AddFunction('Copy', _editstream_Copy_si, _editstream_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _editstream_Create_si, 0, False);
end;

class function _editstream_sw.ToVar(const AValue: _editstream): OleVariant;
var
  wrpr: _editstream_sw;
begin
  wrpr        := _editstream_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _editstream_sw.FromVar(const AValue: OleVariant): _editstream;
begin
  Result := _editstream_sw(ConvFromVar(AValue)).FValue;
end;

{ FINDTEXTA_sw }

function FINDTEXTA_chrg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrg: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(FINDTEXTA_sw(AObj).FValue.chrg)
  else
    FINDTEXTA_sw(AObj).FValue.chrg := TCharRange_sw.FromVar(AArgs[0]);
end;

function FINDTEXTA_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := FINDTEXTA_sw.Create as IDispatch;
end;

function FINDTEXTA_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: FINDTEXTA;

  // Implicit record copy method.
  Result := FINDTEXTA_sw.ToVar(FINDTEXTA(AObj));
end;

class function FINDTEXTA_sw.GetTypeName: WideString;
begin
  Result := 'FINDTEXTA';
end;

function FINDTEXTA_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := FINDTEXTA_sw.Create;
  FINDTEXTA_sw(Result).FValue := FValue;
end;

class procedure FINDTEXTA_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('chrg', FINDTEXTA_chrg_si, TCharRange_sw);
  AData.AddFunction('Copy', FINDTEXTA_Copy_si, FINDTEXTA_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', FINDTEXTA_Create_si, 0, False);
end;

class function FINDTEXTA_sw.ToVar(const AValue: FINDTEXTA): OleVariant;
var
  wrpr: FINDTEXTA_sw;
begin
  wrpr        := FINDTEXTA_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function FINDTEXTA_sw.FromVar(const AValue: OleVariant): FINDTEXTA;
begin
  Result := FINDTEXTA_sw(ConvFromVar(AValue)).FValue;
end;

{ FINDTEXTW_sw }

function FINDTEXTW_chrg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrg: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(FINDTEXTW_sw(AObj).FValue.chrg)
  else
    FINDTEXTW_sw(AObj).FValue.chrg := TCharRange_sw.FromVar(AArgs[0]);
end;

function FINDTEXTW_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := FINDTEXTW_sw.Create as IDispatch;
end;

function FINDTEXTW_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: FINDTEXTW;

  // Implicit record copy method.
  Result := FINDTEXTW_sw.ToVar(FINDTEXTW(AObj));
end;

class function FINDTEXTW_sw.GetTypeName: WideString;
begin
  Result := 'FINDTEXTW';
end;

function FINDTEXTW_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := FINDTEXTW_sw.Create;
  FINDTEXTW_sw(Result).FValue := FValue;
end;

class procedure FINDTEXTW_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('chrg', FINDTEXTW_chrg_si, TCharRange_sw);
  AData.AddFunction('Copy', FINDTEXTW_Copy_si, FINDTEXTW_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', FINDTEXTW_Create_si, 0, False);
end;

class function FINDTEXTW_sw.ToVar(const AValue: FINDTEXTW): OleVariant;
var
  wrpr: FINDTEXTW_sw;
begin
  wrpr        := FINDTEXTW_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function FINDTEXTW_sw.FromVar(const AValue: OleVariant): FINDTEXTW;
begin
  Result := FINDTEXTW_sw(ConvFromVar(AValue)).FValue;
end;

{ FINDTEXTEXA_sw }

function FINDTEXTEXA_chrg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrg: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(FINDTEXTEXA_sw(AObj).FValue.chrg)
  else
    FINDTEXTEXA_sw(AObj).FValue.chrg := TCharRange_sw.FromVar(AArgs[0]);
end;

function FINDTEXTEXA_chrgText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrgText: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(FINDTEXTEXA_sw(AObj).FValue.chrgText)
  else
    FINDTEXTEXA_sw(AObj).FValue.chrgText := TCharRange_sw.FromVar(AArgs[0]);
end;

function FINDTEXTEXA_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := FINDTEXTEXA_sw.Create as IDispatch;
end;

function FINDTEXTEXA_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: FINDTEXTEXA;

  // Implicit record copy method.
  Result := FINDTEXTEXA_sw.ToVar(FINDTEXTEXA(AObj));
end;

class function FINDTEXTEXA_sw.GetTypeName: WideString;
begin
  Result := 'FINDTEXTEXA';
end;

function FINDTEXTEXA_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := FINDTEXTEXA_sw.Create;
  FINDTEXTEXA_sw(Result).FValue := FValue;
end;

class procedure FINDTEXTEXA_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('chrg', FINDTEXTEXA_chrg_si, TCharRange_sw);
  AData.AddField('chrgText', FINDTEXTEXA_chrgText_si, TCharRange_sw);
  AData.AddFunction('Copy', FINDTEXTEXA_Copy_si, FINDTEXTEXA_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', FINDTEXTEXA_Create_si, 0, False);
end;

class function FINDTEXTEXA_sw.ToVar(const AValue: FINDTEXTEXA): OleVariant;
var
  wrpr: FINDTEXTEXA_sw;
begin
  wrpr        := FINDTEXTEXA_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function FINDTEXTEXA_sw.FromVar(const AValue: OleVariant): FINDTEXTEXA;
begin
  Result := FINDTEXTEXA_sw(ConvFromVar(AValue)).FValue;
end;

{ FINDTEXTEXW_sw }

function FINDTEXTEXW_chrg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrg: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(FINDTEXTEXW_sw(AObj).FValue.chrg)
  else
    FINDTEXTEXW_sw(AObj).FValue.chrg := TCharRange_sw.FromVar(AArgs[0]);
end;

function FINDTEXTEXW_chrgText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrgText: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(FINDTEXTEXW_sw(AObj).FValue.chrgText)
  else
    FINDTEXTEXW_sw(AObj).FValue.chrgText := TCharRange_sw.FromVar(AArgs[0]);
end;

function FINDTEXTEXW_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := FINDTEXTEXW_sw.Create as IDispatch;
end;

function FINDTEXTEXW_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: FINDTEXTEXW;

  // Implicit record copy method.
  Result := FINDTEXTEXW_sw.ToVar(FINDTEXTEXW(AObj));
end;

class function FINDTEXTEXW_sw.GetTypeName: WideString;
begin
  Result := 'FINDTEXTEXW';
end;

function FINDTEXTEXW_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := FINDTEXTEXW_sw.Create;
  FINDTEXTEXW_sw(Result).FValue := FValue;
end;

class procedure FINDTEXTEXW_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('chrg', FINDTEXTEXW_chrg_si, TCharRange_sw);
  AData.AddField('chrgText', FINDTEXTEXW_chrgText_si, TCharRange_sw);
  AData.AddFunction('Copy', FINDTEXTEXW_Copy_si, FINDTEXTEXW_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', FINDTEXTEXW_Create_si, 0, False);
end;

class function FINDTEXTEXW_sw.ToVar(const AValue: FINDTEXTEXW): OleVariant;
var
  wrpr: FINDTEXTEXW_sw;
begin
  wrpr        := FINDTEXTEXW_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function FINDTEXTEXW_sw.FromVar(const AValue: OleVariant): FINDTEXTEXW;
begin
  Result := FINDTEXTEXW_sw(ConvFromVar(AValue)).FValue;
end;

{ _formatrange_sw }

function _formatrange_hdc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hdc: HDC;

  if IsGet then
    Result := HDC_sw.ToVar(_formatrange_sw(AObj).FValue.hdc)
  else
    _formatrange_sw(AObj).FValue.hdc := HDC_sw.FromVar(AArgs[0]);
end;

function _formatrange_hdcTarget_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hdcTarget: HDC;

  if IsGet then
    Result := HDC_sw.ToVar(_formatrange_sw(AObj).FValue.hdcTarget)
  else
    _formatrange_sw(AObj).FValue.hdcTarget := HDC_sw.FromVar(AArgs[0]);
end;

function _formatrange_rc_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var rc: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(_formatrange_sw(AObj).FValue.rc)
  else
    _formatrange_sw(AObj).FValue.rc := TRect_sw.FromVar(AArgs[0]);
end;

function _formatrange_rcPage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var rcPage: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(_formatrange_sw(AObj).FValue.rcPage)
  else
    _formatrange_sw(AObj).FValue.rcPage := TRect_sw.FromVar(AArgs[0]);
end;

function _formatrange_chrg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrg: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(_formatrange_sw(AObj).FValue.chrg)
  else
    _formatrange_sw(AObj).FValue.chrg := TCharRange_sw.FromVar(AArgs[0]);
end;

function _formatrange_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _formatrange_sw.Create as IDispatch;
end;

function _formatrange_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _formatrange;

  // Implicit record copy method.
  Result := _formatrange_sw.ToVar(_formatrange(AObj));
end;

class function _formatrange_sw.GetTypeName: WideString;
begin
  Result := '_formatrange';
end;

function _formatrange_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _formatrange_sw.Create;
  _formatrange_sw(Result).FValue := FValue;
end;

class procedure _formatrange_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('hdc', _formatrange_hdc_si, HDC_sw);
  AData.AddField('hdcTarget', _formatrange_hdcTarget_si, HDC_sw);
  AData.AddField('rc', _formatrange_rc_si, TRect_sw);
  AData.AddField('rcPage', _formatrange_rcPage_si, TRect_sw);
  AData.AddField('chrg', _formatrange_chrg_si, TCharRange_sw);
  AData.AddFunction('Copy', _formatrange_Copy_si, _formatrange_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _formatrange_Create_si, 0, False);
end;

class function _formatrange_sw.ToVar(const AValue: _formatrange): OleVariant;
var
  wrpr: _formatrange_sw;
begin
  wrpr        := _formatrange_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _formatrange_sw.FromVar(const AValue: OleVariant): _formatrange;
begin
  Result := _formatrange_sw(ConvFromVar(AValue)).FValue;
end;

{ _paraformat_sw }

function _paraformat_cbSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbSize: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(_paraformat_sw(AObj).FValue.cbSize)
  else
    _paraformat_sw(AObj).FValue.cbSize := UINT_sw.FromVar(AArgs[0]);
end;

function _paraformat_dwMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwMask: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_paraformat_sw(AObj).FValue.dwMask)
  else
    _paraformat_sw(AObj).FValue.dwMask := DWORD_sw.FromVar(AArgs[0]);
end;

function _paraformat_wNumbering_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wNumbering: Word;

  if IsGet then
    Result := _paraformat_sw(AObj).FValue.wNumbering
  else
    _paraformat_sw(AObj).FValue.wNumbering := Word(AArgs[0]);
end;

function _paraformat_wReserved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wReserved: Word;

  if IsGet then
    Result := _paraformat_sw(AObj).FValue.wReserved
  else
    _paraformat_sw(AObj).FValue.wReserved := Word(AArgs[0]);
end;

function _paraformat_dxStartIndent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dxStartIndent: Longint;

  if IsGet then
    Result := _paraformat_sw(AObj).FValue.dxStartIndent
  else
    _paraformat_sw(AObj).FValue.dxStartIndent := Longint(AArgs[0]);
end;

function _paraformat_dxRightIndent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dxRightIndent: Longint;

  if IsGet then
    Result := _paraformat_sw(AObj).FValue.dxRightIndent
  else
    _paraformat_sw(AObj).FValue.dxRightIndent := Longint(AArgs[0]);
end;

function _paraformat_dxOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dxOffset: Longint;

  if IsGet then
    Result := _paraformat_sw(AObj).FValue.dxOffset
  else
    _paraformat_sw(AObj).FValue.dxOffset := Longint(AArgs[0]);
end;

function _paraformat_wAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wAlignment: Word;

  if IsGet then
    Result := _paraformat_sw(AObj).FValue.wAlignment
  else
    _paraformat_sw(AObj).FValue.wAlignment := Word(AArgs[0]);
end;

function _paraformat_cTabCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cTabCount: Smallint;

  if IsGet then
    Result := _paraformat_sw(AObj).FValue.cTabCount
  else
    _paraformat_sw(AObj).FValue.cTabCount := Smallint(AArgs[0]);
end;

function _paraformat_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _paraformat_sw.Create as IDispatch;
end;

function _paraformat_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _paraformat;

  // Implicit record copy method.
  Result := _paraformat_sw.ToVar(_paraformat(AObj));
end;

class function _paraformat_sw.GetTypeName: WideString;
begin
  Result := '_paraformat';
end;

function _paraformat_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _paraformat_sw.Create;
  _paraformat_sw(Result).FValue := FValue;
end;

class procedure _paraformat_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('cbSize', _paraformat_cbSize_si, UINT_sw);
  AData.AddField('dwMask', _paraformat_dwMask_si, DWORD_sw);
  AData.AddField('wNumbering', _paraformat_wNumbering_si, Word_sw);
  AData.AddField('wReserved', _paraformat_wReserved_si, Word_sw);
  AData.AddField('dxStartIndent', _paraformat_dxStartIndent_si, Longint_sw);
  AData.AddField('dxRightIndent', _paraformat_dxRightIndent_si, Longint_sw);
  AData.AddField('dxOffset', _paraformat_dxOffset_si, Longint_sw);
  AData.AddField('wAlignment', _paraformat_wAlignment_si, Word_sw);
  AData.AddField('cTabCount', _paraformat_cTabCount_si, Smallint_sw);
  AData.AddFunction('Copy', _paraformat_Copy_si, _paraformat_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _paraformat_Create_si, 0, False);
end;

class function _paraformat_sw.ToVar(const AValue: _paraformat): OleVariant;
var
  wrpr: _paraformat_sw;
begin
  wrpr        := _paraformat_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _paraformat_sw.FromVar(const AValue: OleVariant): _paraformat;
begin
  Result := _paraformat_sw(ConvFromVar(AValue)).FValue;
end;

{ _CHARFORMAT2A_sw }

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

function _CHARFORMAT2A_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _CHARFORMAT2A_sw.Create as IDispatch;
end;

function _CHARFORMAT2A_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _CHARFORMAT2A;

  // Implicit record copy method.
  Result := _CHARFORMAT2A_sw.ToVar(_CHARFORMAT2A(AObj));
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
  AData.AddFunction('Copy', _CHARFORMAT2A_Copy_si, _CHARFORMAT2A_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _CHARFORMAT2A_Create_si, 0, False);
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

function _CHARFORMAT2W_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _CHARFORMAT2W_sw.Create as IDispatch;
end;

function _CHARFORMAT2W_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _CHARFORMAT2W;

  // Implicit record copy method.
  Result := _CHARFORMAT2W_sw.ToVar(_CHARFORMAT2W(AObj));
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
  AData.AddFunction('Copy', _CHARFORMAT2W_Copy_si, _CHARFORMAT2W_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _CHARFORMAT2W_Create_si, 0, False);
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

{ PARAFORMAT2_sw }

function PARAFORMAT2_cbSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cbSize: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(PARAFORMAT2_sw(AObj).FValue.cbSize)
  else
    PARAFORMAT2_sw(AObj).FValue.cbSize := UINT_sw.FromVar(AArgs[0]);
end;

function PARAFORMAT2_dwMask_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwMask: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(PARAFORMAT2_sw(AObj).FValue.dwMask)
  else
    PARAFORMAT2_sw(AObj).FValue.dwMask := DWORD_sw.FromVar(AArgs[0]);
end;

function PARAFORMAT2_wNumbering_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wNumbering: Word;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.wNumbering
  else
    PARAFORMAT2_sw(AObj).FValue.wNumbering := Word(AArgs[0]);
end;

function PARAFORMAT2_wReserved_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wReserved: Word;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.wReserved
  else
    PARAFORMAT2_sw(AObj).FValue.wReserved := Word(AArgs[0]);
end;

function PARAFORMAT2_dxStartIndent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dxStartIndent: Longint;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.dxStartIndent
  else
    PARAFORMAT2_sw(AObj).FValue.dxStartIndent := Longint(AArgs[0]);
end;

function PARAFORMAT2_dxRightIndent_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dxRightIndent: Longint;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.dxRightIndent
  else
    PARAFORMAT2_sw(AObj).FValue.dxRightIndent := Longint(AArgs[0]);
end;

function PARAFORMAT2_dxOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dxOffset: Longint;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.dxOffset
  else
    PARAFORMAT2_sw(AObj).FValue.dxOffset := Longint(AArgs[0]);
end;

function PARAFORMAT2_wAlignment_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wAlignment: Word;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.wAlignment
  else
    PARAFORMAT2_sw(AObj).FValue.wAlignment := Word(AArgs[0]);
end;

function PARAFORMAT2_cTabCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cTabCount: Smallint;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.cTabCount
  else
    PARAFORMAT2_sw(AObj).FValue.cTabCount := Smallint(AArgs[0]);
end;

function PARAFORMAT2_dySpaceBefore_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dySpaceBefore: Longint;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.dySpaceBefore
  else
    PARAFORMAT2_sw(AObj).FValue.dySpaceBefore := Longint(AArgs[0]);
end;

function PARAFORMAT2_dySpaceAfter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dySpaceAfter: Longint;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.dySpaceAfter
  else
    PARAFORMAT2_sw(AObj).FValue.dySpaceAfter := Longint(AArgs[0]);
end;

function PARAFORMAT2_dyLineSpacing_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dyLineSpacing: Longint;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.dyLineSpacing
  else
    PARAFORMAT2_sw(AObj).FValue.dyLineSpacing := Longint(AArgs[0]);
end;

function PARAFORMAT2_sStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var sStyle: Smallint;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.sStyle
  else
    PARAFORMAT2_sw(AObj).FValue.sStyle := Smallint(AArgs[0]);
end;

function PARAFORMAT2_bLineSpacingRule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bLineSpacingRule: Byte;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.bLineSpacingRule
  else
    PARAFORMAT2_sw(AObj).FValue.bLineSpacingRule := Byte(AArgs[0]);
end;

function PARAFORMAT2_bCRC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var bCRC: Byte;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.bCRC
  else
    PARAFORMAT2_sw(AObj).FValue.bCRC := Byte(AArgs[0]);
end;

function PARAFORMAT2_wShadingWeight_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wShadingWeight: Word;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.wShadingWeight
  else
    PARAFORMAT2_sw(AObj).FValue.wShadingWeight := Word(AArgs[0]);
end;

function PARAFORMAT2_wShadingStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wShadingStyle: Word;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.wShadingStyle
  else
    PARAFORMAT2_sw(AObj).FValue.wShadingStyle := Word(AArgs[0]);
end;

function PARAFORMAT2_wNumberingStart_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wNumberingStart: Word;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.wNumberingStart
  else
    PARAFORMAT2_sw(AObj).FValue.wNumberingStart := Word(AArgs[0]);
end;

function PARAFORMAT2_wNumberingStyle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wNumberingStyle: Word;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.wNumberingStyle
  else
    PARAFORMAT2_sw(AObj).FValue.wNumberingStyle := Word(AArgs[0]);
end;

function PARAFORMAT2_wNumberingTab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wNumberingTab: Word;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.wNumberingTab
  else
    PARAFORMAT2_sw(AObj).FValue.wNumberingTab := Word(AArgs[0]);
end;

function PARAFORMAT2_wBorderSpace_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wBorderSpace: Word;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.wBorderSpace
  else
    PARAFORMAT2_sw(AObj).FValue.wBorderSpace := Word(AArgs[0]);
end;

function PARAFORMAT2_wBorderWidth_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wBorderWidth: Word;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.wBorderWidth
  else
    PARAFORMAT2_sw(AObj).FValue.wBorderWidth := Word(AArgs[0]);
end;

function PARAFORMAT2_wBorders_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wBorders: Word;

  if IsGet then
    Result := PARAFORMAT2_sw(AObj).FValue.wBorders
  else
    PARAFORMAT2_sw(AObj).FValue.wBorders := Word(AArgs[0]);
end;

function PARAFORMAT2_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := PARAFORMAT2_sw.Create as IDispatch;
end;

function PARAFORMAT2_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: PARAFORMAT2;

  // Implicit record copy method.
  Result := PARAFORMAT2_sw.ToVar(PARAFORMAT2(AObj));
end;

class function PARAFORMAT2_sw.GetTypeName: WideString;
begin
  Result := 'PARAFORMAT2';
end;

function PARAFORMAT2_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := PARAFORMAT2_sw.Create;
  PARAFORMAT2_sw(Result).FValue := FValue;
end;

class procedure PARAFORMAT2_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('cbSize', PARAFORMAT2_cbSize_si, UINT_sw);
  AData.AddField('dwMask', PARAFORMAT2_dwMask_si, DWORD_sw);
  AData.AddField('wNumbering', PARAFORMAT2_wNumbering_si, Word_sw);
  AData.AddField('wReserved', PARAFORMAT2_wReserved_si, Word_sw);
  AData.AddField('dxStartIndent', PARAFORMAT2_dxStartIndent_si, Longint_sw);
  AData.AddField('dxRightIndent', PARAFORMAT2_dxRightIndent_si, Longint_sw);
  AData.AddField('dxOffset', PARAFORMAT2_dxOffset_si, Longint_sw);
  AData.AddField('wAlignment', PARAFORMAT2_wAlignment_si, Word_sw);
  AData.AddField('cTabCount', PARAFORMAT2_cTabCount_si, Smallint_sw);
  AData.AddField('dySpaceBefore', PARAFORMAT2_dySpaceBefore_si, Longint_sw);
  AData.AddField('dySpaceAfter', PARAFORMAT2_dySpaceAfter_si, Longint_sw);
  AData.AddField('dyLineSpacing', PARAFORMAT2_dyLineSpacing_si, Longint_sw);
  AData.AddField('sStyle', PARAFORMAT2_sStyle_si, Smallint_sw);
  AData.AddField('bLineSpacingRule', PARAFORMAT2_bLineSpacingRule_si, Byte_sw);
  AData.AddField('bCRC', PARAFORMAT2_bCRC_si, Byte_sw);
  AData.AddField('wShadingWeight', PARAFORMAT2_wShadingWeight_si, Word_sw);
  AData.AddField('wShadingStyle', PARAFORMAT2_wShadingStyle_si, Word_sw);
  AData.AddField('wNumberingStart', PARAFORMAT2_wNumberingStart_si, Word_sw);
  AData.AddField('wNumberingStyle', PARAFORMAT2_wNumberingStyle_si, Word_sw);
  AData.AddField('wNumberingTab', PARAFORMAT2_wNumberingTab_si, Word_sw);
  AData.AddField('wBorderSpace', PARAFORMAT2_wBorderSpace_si, Word_sw);
  AData.AddField('wBorderWidth', PARAFORMAT2_wBorderWidth_si, Word_sw);
  AData.AddField('wBorders', PARAFORMAT2_wBorders_si, Word_sw);
  AData.AddFunction('Copy', PARAFORMAT2_Copy_si, PARAFORMAT2_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', PARAFORMAT2_Create_si, 0, False);
end;

class function PARAFORMAT2_sw.ToVar(const AValue: PARAFORMAT2): OleVariant;
var
  wrpr: PARAFORMAT2_sw;
begin
  wrpr        := PARAFORMAT2_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function PARAFORMAT2_sw.FromVar(const AValue: OleVariant): PARAFORMAT2;
begin
  Result := PARAFORMAT2_sw(ConvFromVar(AValue)).FValue;
end;

{ _msgfilter_sw }

function _msgfilter_nmhdr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nmhdr: TNMHdr;

  if IsGet then
    Result := TNMHdr_sw.ToVar(_msgfilter_sw(AObj).FValue.nmhdr)
  else
    _msgfilter_sw(AObj).FValue.nmhdr := TNMHdr_sw.FromVar(AArgs[0]);
end;

function _msgfilter_msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var msg: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(_msgfilter_sw(AObj).FValue.msg)
  else
    _msgfilter_sw(AObj).FValue.msg := UINT_sw.FromVar(AArgs[0]);
end;

function _msgfilter_wParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wParam: WPARAM;

  if IsGet then
    Result := WPARAM_sw.ToVar(_msgfilter_sw(AObj).FValue.wParam)
  else
    _msgfilter_sw(AObj).FValue.wParam := WPARAM_sw.FromVar(AArgs[0]);
end;

function _msgfilter_lParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lParam: LPARAM;

  if IsGet then
    Result := LPARAM_sw.ToVar(_msgfilter_sw(AObj).FValue.lParam)
  else
    _msgfilter_sw(AObj).FValue.lParam := LPARAM_sw.FromVar(AArgs[0]);
end;

function _msgfilter_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _msgfilter_sw.Create as IDispatch;
end;

function _msgfilter_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _msgfilter;

  // Implicit record copy method.
  Result := _msgfilter_sw.ToVar(_msgfilter(AObj));
end;

class function _msgfilter_sw.GetTypeName: WideString;
begin
  Result := '_msgfilter';
end;

function _msgfilter_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _msgfilter_sw.Create;
  _msgfilter_sw(Result).FValue := FValue;
end;

class procedure _msgfilter_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('nmhdr', _msgfilter_nmhdr_si, TNMHdr_sw);
  AData.AddField('msg', _msgfilter_msg_si, UINT_sw);
  AData.AddField('wParam', _msgfilter_wParam_si, WPARAM_sw);
  AData.AddField('lParam', _msgfilter_lParam_si, LPARAM_sw);
  AData.AddFunction('Copy', _msgfilter_Copy_si, _msgfilter_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _msgfilter_Create_si, 0, False);
end;

class function _msgfilter_sw.ToVar(const AValue: _msgfilter): OleVariant;
var
  wrpr: _msgfilter_sw;
begin
  wrpr        := _msgfilter_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _msgfilter_sw.FromVar(const AValue: OleVariant): _msgfilter;
begin
  Result := _msgfilter_sw(ConvFromVar(AValue)).FValue;
end;

{ TReqSize_sw }

function TReqSize_nmhdr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nmhdr: TNMHdr;

  if IsGet then
    Result := TNMHdr_sw.ToVar(TReqSize_sw(AObj).FValue.nmhdr)
  else
    TReqSize_sw(AObj).FValue.nmhdr := TNMHdr_sw.FromVar(AArgs[0]);
end;

function TReqSize_rc_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var rc: TRect;

  if IsGet then
    Result := TRect_sw.ToVar(TReqSize_sw(AObj).FValue.rc)
  else
    TReqSize_sw(AObj).FValue.rc := TRect_sw.FromVar(AArgs[0]);
end;

function TReqSize_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TReqSize_sw.Create as IDispatch;
end;

function TReqSize_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TReqSize;

  // Implicit record copy method.
  Result := TReqSize_sw.ToVar(TReqSize(AObj));
end;

class function TReqSize_sw.GetTypeName: WideString;
begin
  Result := 'TReqSize';
end;

function TReqSize_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TReqSize_sw.Create;
  TReqSize_sw(Result).FValue := FValue;
end;

class procedure TReqSize_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('nmhdr', TReqSize_nmhdr_si, TNMHdr_sw);
  AData.AddField('rc', TReqSize_rc_si, TRect_sw);
  AData.AddFunction('Copy', TReqSize_Copy_si, TReqSize_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TReqSize_Create_si, 0, False);
end;

class function TReqSize_sw.ToVar(const AValue: TReqSize): OleVariant;
var
  wrpr: TReqSize_sw;
begin
  wrpr        := TReqSize_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TReqSize_sw.FromVar(const AValue: OleVariant): TReqSize;
begin
  Result := TReqSize_sw(ConvFromVar(AValue)).FValue;
end;

{ _selchange_sw }

function _selchange_nmhdr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nmhdr: TNMHdr;

  if IsGet then
    Result := TNMHdr_sw.ToVar(_selchange_sw(AObj).FValue.nmhdr)
  else
    _selchange_sw(AObj).FValue.nmhdr := TNMHdr_sw.FromVar(AArgs[0]);
end;

function _selchange_chrg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrg: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(_selchange_sw(AObj).FValue.chrg)
  else
    _selchange_sw(AObj).FValue.chrg := TCharRange_sw.FromVar(AArgs[0]);
end;

function _selchange_seltyp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var seltyp: Word;

  if IsGet then
    Result := _selchange_sw(AObj).FValue.seltyp
  else
    _selchange_sw(AObj).FValue.seltyp := Word(AArgs[0]);
end;

function _selchange_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _selchange_sw.Create as IDispatch;
end;

function _selchange_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _selchange;

  // Implicit record copy method.
  Result := _selchange_sw.ToVar(_selchange(AObj));
end;

class function _selchange_sw.GetTypeName: WideString;
begin
  Result := '_selchange';
end;

function _selchange_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _selchange_sw.Create;
  _selchange_sw(Result).FValue := FValue;
end;

class procedure _selchange_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('nmhdr', _selchange_nmhdr_si, TNMHdr_sw);
  AData.AddField('chrg', _selchange_chrg_si, TCharRange_sw);
  AData.AddField('seltyp', _selchange_seltyp_si, Word_sw);
  AData.AddFunction('Copy', _selchange_Copy_si, _selchange_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _selchange_Create_si, 0, False);
end;

class function _selchange_sw.ToVar(const AValue: _selchange): OleVariant;
var
  wrpr: _selchange_sw;
begin
  wrpr        := _selchange_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _selchange_sw.FromVar(const AValue: OleVariant): _selchange;
begin
  Result := _selchange_sw(ConvFromVar(AValue)).FValue;
end;

{ TEndDropFiles_sw }

function TEndDropFiles_nmhdr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nmhdr: TNMHdr;

  if IsGet then
    Result := TNMHdr_sw.ToVar(TEndDropFiles_sw(AObj).FValue.nmhdr)
  else
    TEndDropFiles_sw(AObj).FValue.nmhdr := TNMHdr_sw.FromVar(AArgs[0]);
end;

function TEndDropFiles_hDrop_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hDrop: THandle;

  if IsGet then
    Result := THandle_sw.ToVar(TEndDropFiles_sw(AObj).FValue.hDrop)
  else
    TEndDropFiles_sw(AObj).FValue.hDrop := THandle_sw.FromVar(AArgs[0]);
end;

function TEndDropFiles_cp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cp: Longint;

  if IsGet then
    Result := TEndDropFiles_sw(AObj).FValue.cp
  else
    TEndDropFiles_sw(AObj).FValue.cp := Longint(AArgs[0]);
end;

function TEndDropFiles_fProtected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var fProtected: Bool;

  if IsGet then
    Result := Bool_sw.ToVar(TEndDropFiles_sw(AObj).FValue.fProtected)
  else
    TEndDropFiles_sw(AObj).FValue.fProtected := Bool_sw.FromVar(AArgs[0]);
end;

function TEndDropFiles_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TEndDropFiles_sw.Create as IDispatch;
end;

function TEndDropFiles_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TEndDropFiles;

  // Implicit record copy method.
  Result := TEndDropFiles_sw.ToVar(TEndDropFiles(AObj));
end;

class function TEndDropFiles_sw.GetTypeName: WideString;
begin
  Result := 'TEndDropFiles';
end;

function TEndDropFiles_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TEndDropFiles_sw.Create;
  TEndDropFiles_sw(Result).FValue := FValue;
end;

class procedure TEndDropFiles_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('nmhdr', TEndDropFiles_nmhdr_si, TNMHdr_sw);
  AData.AddField('hDrop', TEndDropFiles_hDrop_si, THandle_sw);
  AData.AddField('cp', TEndDropFiles_cp_si, Longint_sw);
  AData.AddField('fProtected', TEndDropFiles_fProtected_si, Bool_sw);
  AData.AddFunction('Copy', TEndDropFiles_Copy_si, TEndDropFiles_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TEndDropFiles_Create_si, 0, False);
end;

class function TEndDropFiles_sw.ToVar(const AValue: TEndDropFiles): OleVariant;
var
  wrpr: TEndDropFiles_sw;
begin
  wrpr        := TEndDropFiles_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TEndDropFiles_sw.FromVar(
  const AValue: OleVariant): TEndDropFiles;
begin
  Result := TEndDropFiles_sw(ConvFromVar(AValue)).FValue;
end;

{ _enprotected_sw }

function _enprotected_nmhdr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nmhdr: TNMHdr;

  if IsGet then
    Result := TNMHdr_sw.ToVar(_enprotected_sw(AObj).FValue.nmhdr)
  else
    _enprotected_sw(AObj).FValue.nmhdr := TNMHdr_sw.FromVar(AArgs[0]);
end;

function _enprotected_msg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var msg: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(_enprotected_sw(AObj).FValue.msg)
  else
    _enprotected_sw(AObj).FValue.msg := UINT_sw.FromVar(AArgs[0]);
end;

function _enprotected_wParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wParam: WPARAM;

  if IsGet then
    Result := WPARAM_sw.ToVar(_enprotected_sw(AObj).FValue.wParam)
  else
    _enprotected_sw(AObj).FValue.wParam := WPARAM_sw.FromVar(AArgs[0]);
end;

function _enprotected_lParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lParam: LPARAM;

  if IsGet then
    Result := LPARAM_sw.ToVar(_enprotected_sw(AObj).FValue.lParam)
  else
    _enprotected_sw(AObj).FValue.lParam := LPARAM_sw.FromVar(AArgs[0]);
end;

function _enprotected_chrg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrg: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(_enprotected_sw(AObj).FValue.chrg)
  else
    _enprotected_sw(AObj).FValue.chrg := TCharRange_sw.FromVar(AArgs[0]);
end;

function _enprotected_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _enprotected_sw.Create as IDispatch;
end;

function _enprotected_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _enprotected;

  // Implicit record copy method.
  Result := _enprotected_sw.ToVar(_enprotected(AObj));
end;

class function _enprotected_sw.GetTypeName: WideString;
begin
  Result := '_enprotected';
end;

function _enprotected_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _enprotected_sw.Create;
  _enprotected_sw(Result).FValue := FValue;
end;

class procedure _enprotected_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('nmhdr', _enprotected_nmhdr_si, TNMHdr_sw);
  AData.AddField('msg', _enprotected_msg_si, UINT_sw);
  AData.AddField('wParam', _enprotected_wParam_si, WPARAM_sw);
  AData.AddField('lParam', _enprotected_lParam_si, LPARAM_sw);
  AData.AddField('chrg', _enprotected_chrg_si, TCharRange_sw);
  AData.AddFunction('Copy', _enprotected_Copy_si, _enprotected_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _enprotected_Create_si, 0, False);
end;

class function _enprotected_sw.ToVar(const AValue: _enprotected): OleVariant;
var
  wrpr: _enprotected_sw;
begin
  wrpr        := _enprotected_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _enprotected_sw.FromVar(const AValue: OleVariant): _enprotected;
begin
  Result := _enprotected_sw(ConvFromVar(AValue)).FValue;
end;

{ _ensaveclipboard_sw }

function _ensaveclipboard_nmhdr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nmhdr: TNMHdr;

  if IsGet then
    Result := TNMHdr_sw.ToVar(_ensaveclipboard_sw(AObj).FValue.nmhdr)
  else
    _ensaveclipboard_sw(AObj).FValue.nmhdr := TNMHdr_sw.FromVar(AArgs[0]);
end;

function _ensaveclipboard_cObjectCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cObjectCount: Longint;

  if IsGet then
    Result := _ensaveclipboard_sw(AObj).FValue.cObjectCount
  else
    _ensaveclipboard_sw(AObj).FValue.cObjectCount := Longint(AArgs[0]);
end;

function _ensaveclipboard_cch_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cch: Longint;

  if IsGet then
    Result := _ensaveclipboard_sw(AObj).FValue.cch
  else
    _ensaveclipboard_sw(AObj).FValue.cch := Longint(AArgs[0]);
end;

function _ensaveclipboard_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _ensaveclipboard_sw.Create as IDispatch;
end;

function _ensaveclipboard_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _ensaveclipboard;

  // Implicit record copy method.
  Result := _ensaveclipboard_sw.ToVar(_ensaveclipboard(AObj));
end;

class function _ensaveclipboard_sw.GetTypeName: WideString;
begin
  Result := '_ensaveclipboard';
end;

function _ensaveclipboard_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _ensaveclipboard_sw.Create;
  _ensaveclipboard_sw(Result).FValue := FValue;
end;

class procedure _ensaveclipboard_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('nmhdr', _ensaveclipboard_nmhdr_si, TNMHdr_sw);
  AData.AddField('cObjectCount', _ensaveclipboard_cObjectCount_si, Longint_sw);
  AData.AddField('cch', _ensaveclipboard_cch_si, Longint_sw);
  AData.AddFunction('Copy', _ensaveclipboard_Copy_si, _ensaveclipboard_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _ensaveclipboard_Create_si, 0, False);
end;

class function _ensaveclipboard_sw.ToVar(
  const AValue: _ensaveclipboard): OleVariant;
var
  wrpr: _ensaveclipboard_sw;
begin
  wrpr        := _ensaveclipboard_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _ensaveclipboard_sw.FromVar(
  const AValue: OleVariant): _ensaveclipboard;
begin
  Result := _ensaveclipboard_sw(ConvFromVar(AValue)).FValue;
end;

{ ENOLEOPFAILED_sw }

function ENOLEOPFAILED_nmhdr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nmhdr: TNMHdr;

  if IsGet then
    Result := TNMHdr_sw.ToVar(ENOLEOPFAILED_sw(AObj).FValue.nmhdr)
  else
    ENOLEOPFAILED_sw(AObj).FValue.nmhdr := TNMHdr_sw.FromVar(AArgs[0]);
end;

function ENOLEOPFAILED_iob_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var iob: Longint;

  if IsGet then
    Result := ENOLEOPFAILED_sw(AObj).FValue.iob
  else
    ENOLEOPFAILED_sw(AObj).FValue.iob := Longint(AArgs[0]);
end;

function ENOLEOPFAILED_lOper_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lOper: Longint;

  if IsGet then
    Result := ENOLEOPFAILED_sw(AObj).FValue.lOper
  else
    ENOLEOPFAILED_sw(AObj).FValue.lOper := Longint(AArgs[0]);
end;

function ENOLEOPFAILED_hr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var hr: HRESULT;

  if IsGet then
    Result := HRESULT_sw.ToVar(ENOLEOPFAILED_sw(AObj).FValue.hr)
  else
    ENOLEOPFAILED_sw(AObj).FValue.hr := HRESULT_sw.FromVar(AArgs[0]);
end;

function ENOLEOPFAILED_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := ENOLEOPFAILED_sw.Create as IDispatch;
end;

function ENOLEOPFAILED_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: ENOLEOPFAILED;

  // Implicit record copy method.
  Result := ENOLEOPFAILED_sw.ToVar(ENOLEOPFAILED(AObj));
end;

class function ENOLEOPFAILED_sw.GetTypeName: WideString;
begin
  Result := 'ENOLEOPFAILED';
end;

function ENOLEOPFAILED_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := ENOLEOPFAILED_sw.Create;
  ENOLEOPFAILED_sw(Result).FValue := FValue;
end;

class procedure ENOLEOPFAILED_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('nmhdr', ENOLEOPFAILED_nmhdr_si, TNMHdr_sw);
  AData.AddField('iob', ENOLEOPFAILED_iob_si, Longint_sw);
  AData.AddField('lOper', ENOLEOPFAILED_lOper_si, Longint_sw);
  AData.AddField('hr', ENOLEOPFAILED_hr_si, HRESULT_sw);
  AData.AddFunction('Copy', ENOLEOPFAILED_Copy_si, ENOLEOPFAILED_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', ENOLEOPFAILED_Create_si, 0, False);
end;

class function ENOLEOPFAILED_sw.ToVar(const AValue: ENOLEOPFAILED): OleVariant;
var
  wrpr: ENOLEOPFAILED_sw;
begin
  wrpr        := ENOLEOPFAILED_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function ENOLEOPFAILED_sw.FromVar(
  const AValue: OleVariant): ENOLEOPFAILED;
begin
  Result := ENOLEOPFAILED_sw(ConvFromVar(AValue)).FValue;
end;

{ OBJECTPOSITIONS_sw }

function OBJECTPOSITIONS_nmhdr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nmhdr: TNMHdr;

  if IsGet then
    Result := TNMHdr_sw.ToVar(OBJECTPOSITIONS_sw(AObj).FValue.nmhdr)
  else
    OBJECTPOSITIONS_sw(AObj).FValue.nmhdr := TNMHdr_sw.FromVar(AArgs[0]);
end;

function OBJECTPOSITIONS_cObjectCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cObjectCount: Longint;

  if IsGet then
    Result := OBJECTPOSITIONS_sw(AObj).FValue.cObjectCount
  else
    OBJECTPOSITIONS_sw(AObj).FValue.cObjectCount := Longint(AArgs[0]);
end;

function OBJECTPOSITIONS_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := OBJECTPOSITIONS_sw.Create as IDispatch;
end;

function OBJECTPOSITIONS_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: OBJECTPOSITIONS;

  // Implicit record copy method.
  Result := OBJECTPOSITIONS_sw.ToVar(OBJECTPOSITIONS(AObj));
end;

class function OBJECTPOSITIONS_sw.GetTypeName: WideString;
begin
  Result := 'OBJECTPOSITIONS';
end;

function OBJECTPOSITIONS_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := OBJECTPOSITIONS_sw.Create;
  OBJECTPOSITIONS_sw(Result).FValue := FValue;
end;

class procedure OBJECTPOSITIONS_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('nmhdr', OBJECTPOSITIONS_nmhdr_si, TNMHdr_sw);
  AData.AddField('cObjectCount', OBJECTPOSITIONS_cObjectCount_si, Longint_sw);
  AData.AddFunction('Copy', OBJECTPOSITIONS_Copy_si, OBJECTPOSITIONS_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', OBJECTPOSITIONS_Create_si, 0, False);
end;

class function OBJECTPOSITIONS_sw.ToVar(
  const AValue: OBJECTPOSITIONS): OleVariant;
var
  wrpr: OBJECTPOSITIONS_sw;
begin
  wrpr        := OBJECTPOSITIONS_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function OBJECTPOSITIONS_sw.FromVar(
  const AValue: OleVariant): OBJECTPOSITIONS;
begin
  Result := OBJECTPOSITIONS_sw(ConvFromVar(AValue)).FValue;
end;

{ ENLINK_sw }

function ENLINK_nmhdr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nmhdr: TNMHdr;

  if IsGet then
    Result := TNMHdr_sw.ToVar(ENLINK_sw(AObj).FValue.nmhdr)
  else
    ENLINK_sw(AObj).FValue.nmhdr := TNMHdr_sw.FromVar(AArgs[0]);
end;

function ENLINK_msg_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var msg: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(ENLINK_sw(AObj).FValue.msg)
  else
    ENLINK_sw(AObj).FValue.msg := UINT_sw.FromVar(AArgs[0]);
end;

function ENLINK_wParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var wParam: WPARAM;

  if IsGet then
    Result := WPARAM_sw.ToVar(ENLINK_sw(AObj).FValue.wParam)
  else
    ENLINK_sw(AObj).FValue.wParam := WPARAM_sw.FromVar(AArgs[0]);
end;

function ENLINK_lParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var lParam: LPARAM;

  if IsGet then
    Result := LPARAM_sw.ToVar(ENLINK_sw(AObj).FValue.lParam)
  else
    ENLINK_sw(AObj).FValue.lParam := LPARAM_sw.FromVar(AArgs[0]);
end;

function ENLINK_chrg_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // var chrg: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(ENLINK_sw(AObj).FValue.chrg)
  else
    ENLINK_sw(AObj).FValue.chrg := TCharRange_sw.FromVar(AArgs[0]);
end;

function ENLINK_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := ENLINK_sw.Create as IDispatch;
end;

function ENLINK_Copy_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer;
  IsGet: Boolean): OleVariant;
begin
  // function Copy: ENLINK;

  // Implicit record copy method.
  Result := ENLINK_sw.ToVar(ENLINK(AObj));
end;

class function ENLINK_sw.GetTypeName: WideString;
begin
  Result := 'ENLINK';
end;

function ENLINK_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := ENLINK_sw.Create;
  ENLINK_sw(Result).FValue := FValue;
end;

class procedure ENLINK_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('nmhdr', ENLINK_nmhdr_si, TNMHdr_sw);
  AData.AddField('msg', ENLINK_msg_si, UINT_sw);
  AData.AddField('wParam', ENLINK_wParam_si, WPARAM_sw);
  AData.AddField('lParam', ENLINK_lParam_si, LPARAM_sw);
  AData.AddField('chrg', ENLINK_chrg_si, TCharRange_sw);
  AData.AddFunction('Copy', ENLINK_Copy_si, ENLINK_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', ENLINK_Create_si, 0, False);
end;

class function ENLINK_sw.ToVar(const AValue: ENLINK): OleVariant;
var
  wrpr: ENLINK_sw;
begin
  wrpr        := ENLINK_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function ENLINK_sw.FromVar(const AValue: OleVariant): ENLINK;
begin
  Result := ENLINK_sw(ConvFromVar(AValue)).FValue;
end;

{ _encorrecttext_sw }

function _encorrecttext_nmhdr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var nmhdr: TNMHdr;

  if IsGet then
    Result := TNMHdr_sw.ToVar(_encorrecttext_sw(AObj).FValue.nmhdr)
  else
    _encorrecttext_sw(AObj).FValue.nmhdr := TNMHdr_sw.FromVar(AArgs[0]);
end;

function _encorrecttext_chrg_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var chrg: TCharRange;

  if IsGet then
    Result := TCharRange_sw.ToVar(_encorrecttext_sw(AObj).FValue.chrg)
  else
    _encorrecttext_sw(AObj).FValue.chrg := TCharRange_sw.FromVar(AArgs[0]);
end;

function _encorrecttext_seltyp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var seltyp: Word;

  if IsGet then
    Result := _encorrecttext_sw(AObj).FValue.seltyp
  else
    _encorrecttext_sw(AObj).FValue.seltyp := Word(AArgs[0]);
end;

function _encorrecttext_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _encorrecttext_sw.Create as IDispatch;
end;

function _encorrecttext_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _encorrecttext;

  // Implicit record copy method.
  Result := _encorrecttext_sw.ToVar(_encorrecttext(AObj));
end;

class function _encorrecttext_sw.GetTypeName: WideString;
begin
  Result := '_encorrecttext';
end;

function _encorrecttext_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _encorrecttext_sw.Create;
  _encorrecttext_sw(Result).FValue := FValue;
end;

class procedure _encorrecttext_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('nmhdr', _encorrecttext_nmhdr_si, TNMHdr_sw);
  AData.AddField('chrg', _encorrecttext_chrg_si, TCharRange_sw);
  AData.AddField('seltyp', _encorrecttext_seltyp_si, Word_sw);
  AData.AddFunction('Copy', _encorrecttext_Copy_si, _encorrecttext_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _encorrecttext_Create_si, 0, False);
end;

class function _encorrecttext_sw.ToVar(
  const AValue: _encorrecttext): OleVariant;
var
  wrpr: _encorrecttext_sw;
begin
  wrpr        := _encorrecttext_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _encorrecttext_sw.FromVar(
  const AValue: OleVariant): _encorrecttext;
begin
  Result := _encorrecttext_sw(ConvFromVar(AValue)).FValue;
end;

{ _punctuation_sw }

function _punctuation_iSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var iSize: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(_punctuation_sw(AObj).FValue.iSize)
  else
    _punctuation_sw(AObj).FValue.iSize := UINT_sw.FromVar(AArgs[0]);
end;

function _punctuation_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _punctuation_sw.Create as IDispatch;
end;

function _punctuation_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _punctuation;

  // Implicit record copy method.
  Result := _punctuation_sw.ToVar(_punctuation(AObj));
end;

class function _punctuation_sw.GetTypeName: WideString;
begin
  Result := '_punctuation';
end;

function _punctuation_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _punctuation_sw.Create;
  _punctuation_sw(Result).FValue := FValue;
end;

class procedure _punctuation_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('iSize', _punctuation_iSize_si, UINT_sw);
  AData.AddFunction('Copy', _punctuation_Copy_si, _punctuation_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _punctuation_Create_si, 0, False);
end;

class function _punctuation_sw.ToVar(const AValue: _punctuation): OleVariant;
var
  wrpr: _punctuation_sw;
begin
  wrpr        := _punctuation_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _punctuation_sw.FromVar(const AValue: OleVariant): _punctuation;
begin
  Result := _punctuation_sw(ConvFromVar(AValue)).FValue;
end;

{ _compcolor_sw }

function _compcolor_crText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var crText: TColorRef;

  if IsGet then
    Result := TColorRef_sw.ToVar(_compcolor_sw(AObj).FValue.crText)
  else
    _compcolor_sw(AObj).FValue.crText := TColorRef_sw.FromVar(AArgs[0]);
end;

function _compcolor_crBackground_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var crBackground: TColorRef;

  if IsGet then
    Result := TColorRef_sw.ToVar(_compcolor_sw(AObj).FValue.crBackground)
  else
    _compcolor_sw(AObj).FValue.crBackground := TColorRef_sw.FromVar(AArgs[0]);
end;

function _compcolor_dwEffects_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwEffects: Longint;

  if IsGet then
    Result := _compcolor_sw(AObj).FValue.dwEffects
  else
    _compcolor_sw(AObj).FValue.dwEffects := Longint(AArgs[0]);
end;

function _compcolor_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _compcolor_sw.Create as IDispatch;
end;

function _compcolor_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _compcolor;

  // Implicit record copy method.
  Result := _compcolor_sw.ToVar(_compcolor(AObj));
end;

class function _compcolor_sw.GetTypeName: WideString;
begin
  Result := '_compcolor';
end;

function _compcolor_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _compcolor_sw.Create;
  _compcolor_sw(Result).FValue := FValue;
end;

class procedure _compcolor_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('crText', _compcolor_crText_si, TColorRef_sw);
  AData.AddField('crBackground', _compcolor_crBackground_si, TColorRef_sw);
  AData.AddField('dwEffects', _compcolor_dwEffects_si, Longint_sw);
  AData.AddFunction('Copy', _compcolor_Copy_si, _compcolor_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _compcolor_Create_si, 0, False);
end;

class function _compcolor_sw.ToVar(const AValue: _compcolor): OleVariant;
var
  wrpr: _compcolor_sw;
begin
  wrpr        := _compcolor_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _compcolor_sw.FromVar(const AValue: OleVariant): _compcolor;
begin
  Result := _compcolor_sw(ConvFromVar(AValue)).FValue;
end;

{ _repastespecial_sw }

function _repastespecial_dwAspect_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwAspect: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_repastespecial_sw(AObj).FValue.dwAspect)
  else
    _repastespecial_sw(AObj).FValue.dwAspect := DWORD_sw.FromVar(AArgs[0]);
end;

function _repastespecial_dwParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var dwParam: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(_repastespecial_sw(AObj).FValue.dwParam)
  else
    _repastespecial_sw(AObj).FValue.dwParam := DWORD_sw.FromVar(AArgs[0]);
end;

function _repastespecial_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := _repastespecial_sw.Create as IDispatch;
end;

function _repastespecial_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: _repastespecial;

  // Implicit record copy method.
  Result := _repastespecial_sw.ToVar(_repastespecial(AObj));
end;

class function _repastespecial_sw.GetTypeName: WideString;
begin
  Result := '_repastespecial';
end;

function _repastespecial_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := _repastespecial_sw.Create;
  _repastespecial_sw(Result).FValue := FValue;
end;

class procedure _repastespecial_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('dwAspect', _repastespecial_dwAspect_si, DWORD_sw);
  AData.AddField('dwParam', _repastespecial_dwParam_si, DWORD_sw);
  AData.AddFunction('Copy', _repastespecial_Copy_si, _repastespecial_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', _repastespecial_Create_si, 0, False);
end;

class function _repastespecial_sw.ToVar(
  const AValue: _repastespecial): OleVariant;
var
  wrpr: _repastespecial_sw;
begin
  wrpr        := _repastespecial_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function _repastespecial_sw.FromVar(
  const AValue: OleVariant): _repastespecial;
begin
  Result := _repastespecial_sw(ConvFromVar(AValue)).FValue;
end;

{ UNDONAMEID_sw }

class function UNDONAMEID_sw.GetTypeName: WideString;
begin
  Result := 'UNDONAMEID';
end;

class procedure UNDONAMEID_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'UID_UNKNOWN'; Value: Integer({$IFDEF LMDSCT_12}UNDONAMEID.{$ENDIF}UID_UNKNOWN)),
    (Name: 'UID_TYPING'; Value: Integer({$IFDEF LMDSCT_12}UNDONAMEID.{$ENDIF}UID_TYPING)),
    (Name: 'UID_DELETE'; Value: Integer({$IFDEF LMDSCT_12}UNDONAMEID.{$ENDIF}UID_DELETE)),
    (Name: 'UID_DRAGDROP'; Value: Integer({$IFDEF LMDSCT_12}UNDONAMEID.{$ENDIF}UID_DRAGDROP)),
    (Name: 'UID_CUT'; Value: Integer({$IFDEF LMDSCT_12}UNDONAMEID.{$ENDIF}UID_CUT)),
    (Name: 'UID_PASTE'; Value: Integer({$IFDEF LMDSCT_12}UNDONAMEID.{$ENDIF}UID_PASTE))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function UNDONAMEID_sw.ToVar(const AValue: UNDONAMEID): OleVariant;
begin
  Result := Integer(AValue);
end;

class function UNDONAMEID_sw.FromVar(const AValue: OleVariant): UNDONAMEID;
begin
  Result := UNDONAMEID(Integer(AValue));
end;

{ GETTEXTEX_sw }

function GETTEXTEX_cb_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var cb: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(GETTEXTEX_sw(AObj).FValue.cb)
  else
    GETTEXTEX_sw(AObj).FValue.cb := DWORD_sw.FromVar(AArgs[0]);
end;

function GETTEXTEX_flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var flags: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(GETTEXTEX_sw(AObj).FValue.flags)
  else
    GETTEXTEX_sw(AObj).FValue.flags := DWORD_sw.FromVar(AArgs[0]);
end;

function GETTEXTEX_codepage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var codepage: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(GETTEXTEX_sw(AObj).FValue.codepage)
  else
    GETTEXTEX_sw(AObj).FValue.codepage := UINT_sw.FromVar(AArgs[0]);
end;

function GETTEXTEX_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := GETTEXTEX_sw.Create as IDispatch;
end;

function GETTEXTEX_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: GETTEXTEX;

  // Implicit record copy method.
  Result := GETTEXTEX_sw.ToVar(GETTEXTEX(AObj));
end;

class function GETTEXTEX_sw.GetTypeName: WideString;
begin
  Result := 'GETTEXTEX';
end;

function GETTEXTEX_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := GETTEXTEX_sw.Create;
  GETTEXTEX_sw(Result).FValue := FValue;
end;

class procedure GETTEXTEX_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('cb', GETTEXTEX_cb_si, DWORD_sw);
  AData.AddField('flags', GETTEXTEX_flags_si, DWORD_sw);
  AData.AddField('codepage', GETTEXTEX_codepage_si, UINT_sw);
  AData.AddFunction('Copy', GETTEXTEX_Copy_si, GETTEXTEX_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', GETTEXTEX_Create_si, 0, False);
end;

class function GETTEXTEX_sw.ToVar(const AValue: GETTEXTEX): OleVariant;
var
  wrpr: GETTEXTEX_sw;
begin
  wrpr        := GETTEXTEX_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function GETTEXTEX_sw.FromVar(const AValue: OleVariant): GETTEXTEX;
begin
  Result := GETTEXTEX_sw(ConvFromVar(AValue)).FValue;
end;

{ GETTEXTLENGTHEX_sw }

function GETTEXTLENGTHEX_flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var flags: DWORD;

  if IsGet then
    Result := DWORD_sw.ToVar(GETTEXTLENGTHEX_sw(AObj).FValue.flags)
  else
    GETTEXTLENGTHEX_sw(AObj).FValue.flags := DWORD_sw.FromVar(AArgs[0]);
end;

function GETTEXTLENGTHEX_codepage_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var codepage: UINT;

  if IsGet then
    Result := UINT_sw.ToVar(GETTEXTLENGTHEX_sw(AObj).FValue.codepage)
  else
    GETTEXTLENGTHEX_sw(AObj).FValue.codepage := UINT_sw.FromVar(AArgs[0]);
end;

function GETTEXTLENGTHEX_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := GETTEXTLENGTHEX_sw.Create as IDispatch;
end;

function GETTEXTLENGTHEX_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: GETTEXTLENGTHEX;

  // Implicit record copy method.
  Result := GETTEXTLENGTHEX_sw.ToVar(GETTEXTLENGTHEX(AObj));
end;

class function GETTEXTLENGTHEX_sw.GetTypeName: WideString;
begin
  Result := 'GETTEXTLENGTHEX';
end;

function GETTEXTLENGTHEX_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := GETTEXTLENGTHEX_sw.Create;
  GETTEXTLENGTHEX_sw(Result).FValue := FValue;
end;

class procedure GETTEXTLENGTHEX_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('flags', GETTEXTLENGTHEX_flags_si, DWORD_sw);
  AData.AddField('codepage', GETTEXTLENGTHEX_codepage_si, UINT_sw);
  AData.AddFunction('Copy', GETTEXTLENGTHEX_Copy_si, GETTEXTLENGTHEX_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', GETTEXTLENGTHEX_Create_si, 0, False);
end;

class function GETTEXTLENGTHEX_sw.ToVar(
  const AValue: GETTEXTLENGTHEX): OleVariant;
var
  wrpr: GETTEXTLENGTHEX_sw;
begin
  wrpr        := GETTEXTLENGTHEX_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function GETTEXTLENGTHEX_sw.FromVar(
  const AValue: OleVariant): GETTEXTLENGTHEX;
begin
  Result := GETTEXTLENGTHEX_sw(ConvFromVar(AValue)).FValue;
end;

{ TWMNotifyRE_sw }

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

function TWMNotifyRE_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TWMNotifyRE_sw.Create as IDispatch;
end;

function TWMNotifyRE_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TWMNotifyRE;

  // Implicit record copy method.
  Result := TWMNotifyRE_sw.ToVar(TWMNotifyRE(AObj));
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

  AData.AddField('Msg', TWMNotifyRE_Msg_si, Cardinal_sw);
  AData.AddField('IDCtrl', TWMNotifyRE_IDCtrl_si, Longint_sw);
  AData.AddField('Result', TWMNotifyRE_Result_si, Longint_sw);
  AData.AddFunction('Copy', TWMNotifyRE_Copy_si, TWMNotifyRE_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TWMNotifyRE_Create_si, 0, False);
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

function RichEdit_TCharFormatA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCharFormatA = record;

  Result := TLMDUnitWrapper.TypeToVar(TCharFormatA_sw);
end;

function RichEdit_TCharFormatW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCharFormatW = record;

  Result := TLMDUnitWrapper.TypeToVar(TCharFormatW_sw);
end;

function RichEdit_TCharFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCharFormat = TCharFormatW;

  Result := TLMDUnitWrapper.TypeToVar(TCharFormat_sw);
end;

function RichEdit__charrange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _charrange = record;

  Result := TLMDUnitWrapper.TypeToVar(_charrange_sw);
end;

function RichEdit_TCharRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCharRange = _charrange;

  Result := TLMDUnitWrapper.TypeToVar(TCharRange_sw);
end;

function RichEdit_CHARRANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type CHARRANGE = _charrange;

  Result := TLMDUnitWrapper.TypeToVar(CHARRANGE_sw);
end;

function RichEdit_TEXTRANGEA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEXTRANGEA = record;

  Result := TLMDUnitWrapper.TypeToVar(TEXTRANGEA_sw);
end;

function RichEdit_TTextRangeA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTextRangeA = TEXTRANGEA;

  Result := TLMDUnitWrapper.TypeToVar(TTextRangeA_sw);
end;

function RichEdit_TEXTRANGEW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEXTRANGEW = record;

  Result := TLMDUnitWrapper.TypeToVar(TEXTRANGEW_sw);
end;

function RichEdit_TTextRangeW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTextRangeW = TEXTRANGEW;

  Result := TLMDUnitWrapper.TypeToVar(TTextRangeW_sw);
end;

function RichEdit_TEXTRANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEXTRANGE = TEXTRANGEW;

  Result := TLMDUnitWrapper.TypeToVar(TEXTRANGE_sw);
end;

function RichEdit__editstream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _editstream = record;

  Result := TLMDUnitWrapper.TypeToVar(_editstream_sw);
end;

function RichEdit_TEditStream_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEditStream = _editstream;

  Result := TLMDUnitWrapper.TypeToVar(TEditStream_sw);
end;

function RichEdit_EDITSTREAM_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EDITSTREAM = _editstream;

  Result := TLMDUnitWrapper.TypeToVar(EDITSTREAM_sw);
end;

function RichEdit_FINDTEXTA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type FINDTEXTA = record;

  Result := TLMDUnitWrapper.TypeToVar(FINDTEXTA_sw);
end;

function RichEdit_FINDTEXTW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type FINDTEXTW = record;

  Result := TLMDUnitWrapper.TypeToVar(FINDTEXTW_sw);
end;

function RichEdit_FINDTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type FINDTEXT = FINDTEXTW;

  Result := TLMDUnitWrapper.TypeToVar(FINDTEXT_sw);
end;

function RichEdit_TFindTextA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindTextA = FINDTEXTA;

  Result := TLMDUnitWrapper.TypeToVar(TFindTextA_sw);
end;

function RichEdit_TFindTextW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindTextW = FINDTEXTW;

  Result := TLMDUnitWrapper.TypeToVar(TFindTextW_sw);
end;

function RichEdit_TFindText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindText = TFindTextW;

  Result := TLMDUnitWrapper.TypeToVar(TFindText_sw);
end;

function RichEdit_FINDTEXTEXA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type FINDTEXTEXA = record;

  Result := TLMDUnitWrapper.TypeToVar(FINDTEXTEXA_sw);
end;

function RichEdit_FINDTEXTEXW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type FINDTEXTEXW = record;

  Result := TLMDUnitWrapper.TypeToVar(FINDTEXTEXW_sw);
end;

function RichEdit_FINDTEXTEX_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type FINDTEXTEX = FINDTEXTEXW;

  Result := TLMDUnitWrapper.TypeToVar(FINDTEXTEX_sw);
end;

function RichEdit_TFindTextExA_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindTextExA = FINDTEXTEXA;

  Result := TLMDUnitWrapper.TypeToVar(TFindTextExA_sw);
end;

function RichEdit_TFindTextExW_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindTextExW = FINDTEXTEXW;

  Result := TLMDUnitWrapper.TypeToVar(TFindTextExW_sw);
end;

function RichEdit_TFindTextEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFindTextEx = TFindTextExW;

  Result := TLMDUnitWrapper.TypeToVar(TFindTextEx_sw);
end;

function RichEdit__formatrange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _formatrange = record;

  Result := TLMDUnitWrapper.TypeToVar(_formatrange_sw);
end;

function RichEdit_TFormatRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFormatRange = _formatrange;

  Result := TLMDUnitWrapper.TypeToVar(TFormatRange_sw);
end;

function RichEdit_FORMATRANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type FORMATRANGE = _formatrange;

  Result := TLMDUnitWrapper.TypeToVar(FORMATRANGE_sw);
end;

function RichEdit__paraformat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _paraformat = record;

  Result := TLMDUnitWrapper.TypeToVar(_paraformat_sw);
end;

function RichEdit_TParaFormat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParaFormat = _paraformat;

  Result := TLMDUnitWrapper.TypeToVar(TParaFormat_sw);
end;

function RichEdit_PARAFORMAT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type PARAFORMAT = _paraformat;

  Result := TLMDUnitWrapper.TypeToVar(PARAFORMAT_sw);
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

function RichEdit_CHARFORMAT2A_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type CHARFORMAT2A = _CHARFORMAT2A;

  Result := TLMDUnitWrapper.TypeToVar(CHARFORMAT2A_sw);
end;

function RichEdit_CHARFORMAT2W_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type CHARFORMAT2W = _CHARFORMAT2W;

  Result := TLMDUnitWrapper.TypeToVar(CHARFORMAT2W_sw);
end;

function RichEdit_CHARFORMAT2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type CHARFORMAT2 = CHARFORMAT2W;

  Result := TLMDUnitWrapper.TypeToVar(CHARFORMAT2_sw);
end;

function RichEdit_TCharFormat2A_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCharFormat2A = _CHARFORMAT2A;

  Result := TLMDUnitWrapper.TypeToVar(TCharFormat2A_sw);
end;

function RichEdit_TCharFormat2W_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCharFormat2W = _CHARFORMAT2W;

  Result := TLMDUnitWrapper.TypeToVar(TCharFormat2W_sw);
end;

function RichEdit_TCharFormat2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCharFormat2 = TCharFormat2W;

  Result := TLMDUnitWrapper.TypeToVar(TCharFormat2_sw);
end;

function RichEdit_PARAFORMAT2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type PARAFORMAT2 = record;

  Result := TLMDUnitWrapper.TypeToVar(PARAFORMAT2_sw);
end;

function RichEdit_TParaFormat2_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParaFormat2 = PARAFORMAT2;

  Result := TLMDUnitWrapper.TypeToVar(TParaFormat2_sw);
end;

function RichEdit__msgfilter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _msgfilter = record;

  Result := TLMDUnitWrapper.TypeToVar(_msgfilter_sw);
end;

function RichEdit_TMsgFilter_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMsgFilter = _msgfilter;

  Result := TLMDUnitWrapper.TypeToVar(TMsgFilter_sw);
end;

function RichEdit_MSGFILTER_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type MSGFILTER = _msgfilter;

  Result := TLMDUnitWrapper.TypeToVar(MSGFILTER_sw);
end;

function RichEdit_TReqSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TReqSize = record;

  Result := TLMDUnitWrapper.TypeToVar(TReqSize_sw);
end;

function RichEdit__selchange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _selchange = record;

  Result := TLMDUnitWrapper.TypeToVar(_selchange_sw);
end;

function RichEdit_TSelChange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSelChange = _selchange;

  Result := TLMDUnitWrapper.TypeToVar(TSelChange_sw);
end;

function RichEdit_SELCHANGE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type SELCHANGE = _selchange;

  Result := TLMDUnitWrapper.TypeToVar(SELCHANGE_sw);
end;

function RichEdit_TEndDropFiles_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TEndDropFiles = record;

  Result := TLMDUnitWrapper.TypeToVar(TEndDropFiles_sw);
end;

function RichEdit__enprotected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _enprotected = record;

  Result := TLMDUnitWrapper.TypeToVar(_enprotected_sw);
end;

function RichEdit_TENProtected_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TENProtected = _enprotected;

  Result := TLMDUnitWrapper.TypeToVar(TENProtected_sw);
end;

function RichEdit_ENPROTECTED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ENPROTECTED = _enprotected;

  Result := TLMDUnitWrapper.TypeToVar(ENPROTECTED_sw);
end;

function RichEdit__ensaveclipboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _ensaveclipboard = record;

  Result := TLMDUnitWrapper.TypeToVar(_ensaveclipboard_sw);
end;

function RichEdit_TENSaveClipboard_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TENSaveClipboard = _ensaveclipboard;

  Result := TLMDUnitWrapper.TypeToVar(TENSaveClipboard_sw);
end;

function RichEdit_ENSAVECLIPBOARD_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ENSAVECLIPBOARD = _ensaveclipboard;

  Result := TLMDUnitWrapper.TypeToVar(ENSAVECLIPBOARD_sw);
end;

function RichEdit_ENOLEOPFAILED_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ENOLEOPFAILED = record;

  Result := TLMDUnitWrapper.TypeToVar(ENOLEOPFAILED_sw);
end;

function RichEdit_TENOleOpFailed_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TENOleOpFailed = ENOLEOPFAILED;

  Result := TLMDUnitWrapper.TypeToVar(TENOleOpFailed_sw);
end;

function RichEdit_OBJECTPOSITIONS_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type OBJECTPOSITIONS = record;

  Result := TLMDUnitWrapper.TypeToVar(OBJECTPOSITIONS_sw);
end;

function RichEdit_TObjectPositions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TObjectPositions = OBJECTPOSITIONS;

  Result := TLMDUnitWrapper.TypeToVar(TObjectPositions_sw);
end;

function RichEdit_ENLINK_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ENLINK = record;

  Result := TLMDUnitWrapper.TypeToVar(ENLINK_sw);
end;

function RichEdit_TENLink_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TENLink = ENLINK;

  Result := TLMDUnitWrapper.TypeToVar(TENLink_sw);
end;

function RichEdit__encorrecttext_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _encorrecttext = record;

  Result := TLMDUnitWrapper.TypeToVar(_encorrecttext_sw);
end;

function RichEdit_TENCorrectText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TENCorrectText = _encorrecttext;

  Result := TLMDUnitWrapper.TypeToVar(TENCorrectText_sw);
end;

function RichEdit_ENCORRECTTEXT_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type ENCORRECTTEXT = _encorrecttext;

  Result := TLMDUnitWrapper.TypeToVar(ENCORRECTTEXT_sw);
end;

function RichEdit__punctuation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _punctuation = record;

  Result := TLMDUnitWrapper.TypeToVar(_punctuation_sw);
end;

function RichEdit_TPunctuation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPunctuation = _punctuation;

  Result := TLMDUnitWrapper.TypeToVar(TPunctuation_sw);
end;

function RichEdit_PUNCTUATION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type PUNCTUATION = _punctuation;

  Result := TLMDUnitWrapper.TypeToVar(PUNCTUATION_sw);
end;

function RichEdit__compcolor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _compcolor = record;

  Result := TLMDUnitWrapper.TypeToVar(_compcolor_sw);
end;

function RichEdit_TCompColor_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCompColor = _compcolor;

  Result := TLMDUnitWrapper.TypeToVar(TCompColor_sw);
end;

function RichEdit_COMPCOLOR_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type COMPCOLOR = _compcolor;

  Result := TLMDUnitWrapper.TypeToVar(COMPCOLOR_sw);
end;

function RichEdit__repastespecial_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type _repastespecial = record;

  Result := TLMDUnitWrapper.TypeToVar(_repastespecial_sw);
end;

function RichEdit_TRepasteSpecial_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRepasteSpecial = _repastespecial;

  Result := TLMDUnitWrapper.TypeToVar(TRepasteSpecial_sw);
end;

function RichEdit_REPASTESPECIAL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type REPASTESPECIAL = _repastespecial;

  Result := TLMDUnitWrapper.TypeToVar(REPASTESPECIAL_sw);
end;

function RichEdit_UNDONAMEID_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type UNDONAMEID = (UID_UNKNOWN, UID_TYPING, UID_DELETE, U...

  Result := TLMDUnitWrapper.TypeToVar(UNDONAMEID_sw);
end;

function RichEdit_GETTEXTEX_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type GETTEXTEX = record;

  Result := TLMDUnitWrapper.TypeToVar(GETTEXTEX_sw);
end;

function RichEdit_TGetTextEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetTextEx = GETTEXTEX;

  Result := TLMDUnitWrapper.TypeToVar(TGetTextEx_sw);
end;

function RichEdit_GETTEXTLENGTHEX_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type GETTEXTLENGTHEX = record;

  Result := TLMDUnitWrapper.TypeToVar(GETTEXTLENGTHEX_sw);
end;

function RichEdit_TGetTextLengthEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TGetTextLengthEx = GETTEXTLENGTHEX;

  Result := TLMDUnitWrapper.TypeToVar(TGetTextLengthEx_sw);
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
  AData.AddType(TCharFormatA_sw, RichEdit_TCharFormatA_si);
  AData.AddType(TCharFormatW_sw, RichEdit_TCharFormatW_si);
  AData.AddType(TCharFormat_sw, RichEdit_TCharFormat_si);
  AData.AddType(_charrange_sw, RichEdit__charrange_si);
  AData.AddType(TCharRange_sw, RichEdit_TCharRange_si);
  AData.AddType(CHARRANGE_sw, RichEdit_CHARRANGE_si);
  AData.AddType(TEXTRANGEA_sw, RichEdit_TEXTRANGEA_si);
  AData.AddType(TTextRangeA_sw, RichEdit_TTextRangeA_si);
  AData.AddType(TEXTRANGEW_sw, RichEdit_TEXTRANGEW_si);
  AData.AddType(TTextRangeW_sw, RichEdit_TTextRangeW_si);
  AData.AddType(TEXTRANGE_sw, RichEdit_TEXTRANGE_si);
  AData.AddType(_editstream_sw, RichEdit__editstream_si);
  AData.AddType(TEditStream_sw, RichEdit_TEditStream_si);
  AData.AddType(EDITSTREAM_sw, RichEdit_EDITSTREAM_si);
  AData.AddType(FINDTEXTA_sw, RichEdit_FINDTEXTA_si);
  AData.AddType(FINDTEXTW_sw, RichEdit_FINDTEXTW_si);
  AData.AddType(FINDTEXT_sw, RichEdit_FINDTEXT_si);
  AData.AddType(TFindTextA_sw, RichEdit_TFindTextA_si);
  AData.AddType(TFindTextW_sw, RichEdit_TFindTextW_si);
  AData.AddType(TFindText_sw, RichEdit_TFindText_si);
  AData.AddType(FINDTEXTEXA_sw, RichEdit_FINDTEXTEXA_si);
  AData.AddType(FINDTEXTEXW_sw, RichEdit_FINDTEXTEXW_si);
  AData.AddType(FINDTEXTEX_sw, RichEdit_FINDTEXTEX_si);
  AData.AddType(TFindTextExA_sw, RichEdit_TFindTextExA_si);
  AData.AddType(TFindTextExW_sw, RichEdit_TFindTextExW_si);
  AData.AddType(TFindTextEx_sw, RichEdit_TFindTextEx_si);
  AData.AddType(_formatrange_sw, RichEdit__formatrange_si);
  AData.AddType(TFormatRange_sw, RichEdit_TFormatRange_si);
  AData.AddType(FORMATRANGE_sw, RichEdit_FORMATRANGE_si);
  AData.AddType(_paraformat_sw, RichEdit__paraformat_si);
  AData.AddType(TParaFormat_sw, RichEdit_TParaFormat_si);
  AData.AddType(PARAFORMAT_sw, RichEdit_PARAFORMAT_si);
  AData.AddType(_CHARFORMAT2A_sw, RichEdit__CHARFORMAT2A_si);
  AData.AddType(_CHARFORMAT2W_sw, RichEdit__CHARFORMAT2W_si);
  AData.AddType(_CHARFORMAT2_sw, RichEdit__CHARFORMAT2_si);
  AData.AddType(CHARFORMAT2A_sw, RichEdit_CHARFORMAT2A_si);
  AData.AddType(CHARFORMAT2W_sw, RichEdit_CHARFORMAT2W_si);
  AData.AddType(CHARFORMAT2_sw, RichEdit_CHARFORMAT2_si);
  AData.AddType(TCharFormat2A_sw, RichEdit_TCharFormat2A_si);
  AData.AddType(TCharFormat2W_sw, RichEdit_TCharFormat2W_si);
  AData.AddType(TCharFormat2_sw, RichEdit_TCharFormat2_si);
  AData.AddType(PARAFORMAT2_sw, RichEdit_PARAFORMAT2_si);
  AData.AddType(TParaFormat2_sw, RichEdit_TParaFormat2_si);
  AData.AddType(_msgfilter_sw, RichEdit__msgfilter_si);
  AData.AddType(TMsgFilter_sw, RichEdit_TMsgFilter_si);
  AData.AddType(MSGFILTER_sw, RichEdit_MSGFILTER_si);
  AData.AddType(TReqSize_sw, RichEdit_TReqSize_si);
  AData.AddType(_selchange_sw, RichEdit__selchange_si);
  AData.AddType(TSelChange_sw, RichEdit_TSelChange_si);
  AData.AddType(SELCHANGE_sw, RichEdit_SELCHANGE_si);
  AData.AddType(TEndDropFiles_sw, RichEdit_TEndDropFiles_si);
  AData.AddType(_enprotected_sw, RichEdit__enprotected_si);
  AData.AddType(TENProtected_sw, RichEdit_TENProtected_si);
  AData.AddType(ENPROTECTED_sw, RichEdit_ENPROTECTED_si);
  AData.AddType(_ensaveclipboard_sw, RichEdit__ensaveclipboard_si);
  AData.AddType(TENSaveClipboard_sw, RichEdit_TENSaveClipboard_si);
  AData.AddType(ENSAVECLIPBOARD_sw, RichEdit_ENSAVECLIPBOARD_si);
  AData.AddType(ENOLEOPFAILED_sw, RichEdit_ENOLEOPFAILED_si);
  AData.AddType(TENOleOpFailed_sw, RichEdit_TENOleOpFailed_si);
  AData.AddType(OBJECTPOSITIONS_sw, RichEdit_OBJECTPOSITIONS_si);
  AData.AddType(TObjectPositions_sw, RichEdit_TObjectPositions_si);
  AData.AddType(ENLINK_sw, RichEdit_ENLINK_si);
  AData.AddType(TENLink_sw, RichEdit_TENLink_si);
  AData.AddType(_encorrecttext_sw, RichEdit__encorrecttext_si);
  AData.AddType(TENCorrectText_sw, RichEdit_TENCorrectText_si);
  AData.AddType(ENCORRECTTEXT_sw, RichEdit_ENCORRECTTEXT_si);
  AData.AddType(_punctuation_sw, RichEdit__punctuation_si);
  AData.AddType(TPunctuation_sw, RichEdit_TPunctuation_si);
  AData.AddType(PUNCTUATION_sw, RichEdit_PUNCTUATION_si);
  AData.AddType(_compcolor_sw, RichEdit__compcolor_si);
  AData.AddType(TCompColor_sw, RichEdit_TCompColor_si);
  AData.AddType(COMPCOLOR_sw, RichEdit_COMPCOLOR_si);
  AData.AddType(_repastespecial_sw, RichEdit__repastespecial_si);
  AData.AddType(TRepasteSpecial_sw, RichEdit_TRepasteSpecial_si);
  AData.AddType(REPASTESPECIAL_sw, RichEdit_REPASTESPECIAL_si);
  AData.AddType(UNDONAMEID_sw, RichEdit_UNDONAMEID_si);
  AData.AddType(GETTEXTEX_sw, RichEdit_GETTEXTEX_si);
  AData.AddType(TGetTextEx_sw, RichEdit_TGetTextEx_si);
  AData.AddType(GETTEXTLENGTHEX_sw, RichEdit_GETTEXTLENGTHEX_si);
  AData.AddType(TGetTextLengthEx_sw, RichEdit_TGetTextLengthEx_si);
  AData.AddType(TWMNotifyRE_sw, RichEdit_TWMNotifyRE_si);
end;

class function RichEdit_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(RichEdit_sw);
end;

initialization
  RegisterUnitWrapper(RichEdit_sw);

end.
