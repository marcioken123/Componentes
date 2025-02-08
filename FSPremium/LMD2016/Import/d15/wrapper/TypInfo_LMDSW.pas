unit TypInfo_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'TypInfo' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  Classes, TypInfo, LMDTypes, LMDSctScripter, LMDSctWrappers, LMDSctSysWrappers,
  Types, Variants, SysUtils, Variants_LMDSW, SysUtils_LMDSW;


{ Type wrappers }

type
  TPublishableVariantType_sw = class;
  EPropertyError_sw = class;
  EPropertyConvertError_sw = class;

  TTypeKind_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TTypeKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TTypeKind;
  end;

  TPublishableVariantType_sc = class of TPublishableVariantType;
  TPublishableVariantType_sw = class(TInvokeableVariantType_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TPublishableVariantType): OleVariant;
    class function FromVar(const AValue: OleVariant): TPublishableVariantType;
    class function ClassToVar(AClass: TPublishableVariantType_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TPublishableVariantType_sc;
  end;

  TTypeKinds_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TTypeKinds): OleVariant;
    class function FromVar(const AValue: OleVariant): TTypeKinds;
  end;

  TOrdType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TOrdType): OleVariant;
    class function FromVar(const AValue: OleVariant): TOrdType;
  end;

  TFloatType_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TFloatType): OleVariant;
    class function FromVar(const AValue: OleVariant): TFloatType;
  end;

  TMemberVisibility_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TMemberVisibility): OleVariant;
    class function FromVar(const AValue: OleVariant): TMemberVisibility;
  end;

  TMethodKind_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TMethodKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TMethodKind;
  end;

  TCallConv_sw = class(TLMDEnumWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetEnumTypeInfo: TLMDTypeInfo; override;
  public
    class function ToVar(const AValue: TCallConv): OleVariant;
    class function FromVar(const AValue: OleVariant): TCallConv;
  end;

  TAttrEntry_sw = class(TLMDRecordWrapper)
  private
    FValue: TAttrEntry;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TAttrEntry): OleVariant;
    class function FromVar(const AValue: OleVariant): TAttrEntry;
  end;

  TAttrData_sw = class(TLMDRecordWrapper)
  private
    FValue: TAttrData;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TAttrData): OleVariant;
    class function FromVar(const AValue: OleVariant): TAttrData;
  end;

  TFieldExEntry_sw = class(TLMDRecordWrapper)
  private
    FValue: TFieldExEntry;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TFieldExEntry): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldExEntry;
  end;

  TVmtFieldEntry_sw = class(TLMDRecordWrapper)
  private
    FValue: TVmtFieldEntry;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVmtFieldEntry): OleVariant;
    class function FromVar(const AValue: OleVariant): TVmtFieldEntry;
  end;

  TVmtFieldClassTab_sw = class(TLMDRecordWrapper)
  private
    FValue: TVmtFieldClassTab;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVmtFieldClassTab): OleVariant;
    class function FromVar(const AValue: OleVariant): TVmtFieldClassTab;
  end;

  TVmtFieldTable_sw = class(TLMDRecordWrapper)
  private
    FValue: TVmtFieldTable;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVmtFieldTable): OleVariant;
    class function FromVar(const AValue: OleVariant): TVmtFieldTable;
  end;

  TVmtMethodParam_sw = class(TLMDRecordWrapper)
  private
    FValue: TVmtMethodParam;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVmtMethodParam): OleVariant;
    class function FromVar(const AValue: OleVariant): TVmtMethodParam;
  end;

  TVmtMethodEntry_sw = class(TLMDRecordWrapper)
  private
    FValue: TVmtMethodEntry;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVmtMethodEntry): OleVariant;
    class function FromVar(const AValue: OleVariant): TVmtMethodEntry;
  end;

  TVmtMethodEntryTail_sw = class(TLMDRecordWrapper)
  private
    FValue: TVmtMethodEntryTail;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVmtMethodEntryTail): OleVariant;
    class function FromVar(const AValue: OleVariant): TVmtMethodEntryTail;
  end;

  TVmtMethodExEntry_sw = class(TLMDRecordWrapper)
  private
    FValue: TVmtMethodExEntry;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVmtMethodExEntry): OleVariant;
    class function FromVar(const AValue: OleVariant): TVmtMethodExEntry;
  end;

  TVmtMethodTable_sw = class(TLMDRecordWrapper)
  private
    FValue: TVmtMethodTable;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TVmtMethodTable): OleVariant;
    class function FromVar(const AValue: OleVariant): TVmtMethodTable;
  end;

  TManagedField_sw = class(TLMDRecordWrapper)
  private
    FValue: TManagedField;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TManagedField): OleVariant;
    class function FromVar(const AValue: OleVariant): TManagedField;
  end;

  TProcedureParam_sw = class(TLMDRecordWrapper)
  private
    FValue: TProcedureParam;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TProcedureParam): OleVariant;
    class function FromVar(const AValue: OleVariant): TProcedureParam;
  end;

  TProcedureSignature_sw = class(TLMDRecordWrapper)
  private
    FValue: TProcedureSignature;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TProcedureSignature): OleVariant;
    class function FromVar(const AValue: OleVariant): TProcedureSignature;
  end;

  TIntfMethodTable_sw = class(TLMDRecordWrapper)
  private
    FValue: TIntfMethodTable;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TIntfMethodTable): OleVariant;
    class function FromVar(const AValue: OleVariant): TIntfMethodTable;
  end;

  TIntfMethodEntry_sw = class(TLMDRecordWrapper)
  private
    FValue: TIntfMethodEntry;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TIntfMethodEntry): OleVariant;
    class function FromVar(const AValue: OleVariant): TIntfMethodEntry;
  end;

  TIntfMethodEntryTail_sw = class(TLMDRecordWrapper)
  private
    FValue: TIntfMethodEntryTail;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TIntfMethodEntryTail): OleVariant;
    class function FromVar(const AValue: OleVariant): TIntfMethodEntryTail;
  end;

  TIntfMethodParam_sw = class(TLMDRecordWrapper)
  private
    FValue: TIntfMethodParam;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TIntfMethodParam): OleVariant;
    class function FromVar(const AValue: OleVariant): TIntfMethodParam;
  end;

  TIntfMethodParamTail_sw = class(TLMDRecordWrapper)
  private
    FValue: TIntfMethodParamTail;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TIntfMethodParamTail): OleVariant;
    class function FromVar(const AValue: OleVariant): TIntfMethodParamTail;
  end;

  TArrayTypeData_sw = class(TLMDRecordWrapper)
  private
    FValue: TArrayTypeData;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TArrayTypeData): OleVariant;
    class function FromVar(const AValue: OleVariant): TArrayTypeData;
  end;

  TRecordTypeField_sw = class(TLMDRecordWrapper)
  private
    FValue: TRecordTypeField;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TRecordTypeField): OleVariant;
    class function FromVar(const AValue: OleVariant): TRecordTypeField;
  end;

  TPropDataEx_sw = class(TLMDRecordWrapper)
  private
    FValue: TPropDataEx;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPropDataEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TPropDataEx;
  end;

  TPropInfoEx_sw = class(TLMDRecordWrapper)
  private
    FValue: TPropInfoEx;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TPropInfoEx): OleVariant;
    class function FromVar(const AValue: OleVariant): TPropInfoEx;
  end;

  EPropertyError_sc = class of EPropertyError;
  EPropertyError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EPropertyError): OleVariant;
    class function FromVar(const AValue: OleVariant): EPropertyError;
    class function ClassToVar(AClass: EPropertyError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EPropertyError_sc;
  end;

  EPropertyConvertError_sc = class of EPropertyConvertError;
  EPropertyConvertError_sw = class(Exception_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EPropertyConvertError): OleVariant;
    class function FromVar(const AValue: OleVariant): EPropertyConvertError;
    class function ClassToVar(AClass: EPropertyConvertError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EPropertyConvertError_sc;
  end;


{ Unit wrapper }

type
  TypInfo_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TTypeKind_sw }

class function TTypeKind_sw.GetTypeName: WideString;
begin
  Result := 'TTypeKind';
end;

class function TTypeKind_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TTypeKind);
end;

class function TTypeKind_sw.ToVar(const AValue: TTypeKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TTypeKind_sw.FromVar(const AValue: OleVariant): TTypeKind;
begin
  Result := TTypeKind(Integer(AValue));
end;

{ TPublishableVariantType_sw }

class function TPublishableVariantType_sw.GetTypeName: WideString;
begin
  Result := 'TPublishableVariantType';
end;

class function TPublishableVariantType_sw.GetWrappedClass: TClass;
begin
  Result := TPublishableVariantType;
end;

class procedure TPublishableVariantType_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function TPublishableVariantType_sw.ToVar(
  const AValue: TPublishableVariantType): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TPublishableVariantType_sw.FromVar(
  const AValue: OleVariant): TPublishableVariantType;
begin
  Result := TPublishableVariantType(ConvFromVar(AValue, 
    TPublishableVariantType));
end;

class function TPublishableVariantType_sw.ClassToVar(
  AClass: TPublishableVariantType_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TPublishableVariantType_sw.ClassFromVar(
  const AClass: OleVariant): TPublishableVariantType_sc;
begin
  Result := TPublishableVariantType_sc(ConvClsFromVar(AClass, 
    TPublishableVariantType));
end;

{ TTypeKinds_sw }

class function TTypeKinds_sw.GetTypeName: WideString;
begin
  Result := 'TTypeKinds';
end;

class function TTypeKinds_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TTypeKinds);
end;

class function TTypeKinds_sw.ToVar(const AValue: TTypeKinds): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TTypeKinds_sw.FromVar(const AValue: OleVariant): TTypeKinds;
begin
  ConvFromVar(AValue, @Result);
end;

{ TOrdType_sw }

class function TOrdType_sw.GetTypeName: WideString;
begin
  Result := 'TOrdType';
end;

class function TOrdType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TOrdType);
end;

class function TOrdType_sw.ToVar(const AValue: TOrdType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TOrdType_sw.FromVar(const AValue: OleVariant): TOrdType;
begin
  Result := TOrdType(Integer(AValue));
end;

{ TFloatType_sw }

class function TFloatType_sw.GetTypeName: WideString;
begin
  Result := 'TFloatType';
end;

class function TFloatType_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TFloatType);
end;

class function TFloatType_sw.ToVar(const AValue: TFloatType): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TFloatType_sw.FromVar(const AValue: OleVariant): TFloatType;
begin
  Result := TFloatType(Integer(AValue));
end;

{ TMemberVisibility_sw }

class function TMemberVisibility_sw.GetTypeName: WideString;
begin
  Result := 'TMemberVisibility';
end;

class function TMemberVisibility_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TMemberVisibility);
end;

class function TMemberVisibility_sw.ToVar(
  const AValue: TMemberVisibility): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMemberVisibility_sw.FromVar(
  const AValue: OleVariant): TMemberVisibility;
begin
  Result := TMemberVisibility(Integer(AValue));
end;

{ TMethodKind_sw }

class function TMethodKind_sw.GetTypeName: WideString;
begin
  Result := 'TMethodKind';
end;

class function TMethodKind_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TMethodKind);
end;

class function TMethodKind_sw.ToVar(const AValue: TMethodKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TMethodKind_sw.FromVar(const AValue: OleVariant): TMethodKind;
begin
  Result := TMethodKind(Integer(AValue));
end;

{ TCallConv_sw }

class function TCallConv_sw.GetTypeName: WideString;
begin
  Result := 'TCallConv';
end;

class function TCallConv_sw.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := TypeInfo(TCallConv);
end;

class function TCallConv_sw.ToVar(const AValue: TCallConv): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCallConv_sw.FromVar(const AValue: OleVariant): TCallConv;
begin
  Result := TCallConv(Integer(AValue));
end;

{ TAttrEntry_sw }

function TAttrEntry_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TAttrEntry_sw.ToVar(TAttrEntry(AObj));
end;

function TAttrEntry_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TAttrEntry_sw.Create as IDispatch;
end;

function TAttrEntry_ArgLen_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ArgLen: Word;

  if IsGet then
    Result := TAttrEntry_sw(AObj).FValue.ArgLen
  else
    TAttrEntry_sw(AObj).FValue.ArgLen := Word(AArgs[0]);
end;

class function TAttrEntry_sw.GetTypeName: WideString;
begin
  Result := 'TAttrEntry';
end;

function TAttrEntry_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TAttrEntry_sw.Create;
  TAttrEntry_sw(Result).FValue := FValue;
end;

class procedure TAttrEntry_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TAttrEntry_Copy_si, TAttrEntry_sw, 0);
  AData.AddField('ArgLen', TAttrEntry_ArgLen_si, Word_sw);

  { Class members }

  AData.AddConstructor('Create', TAttrEntry_Create_si, 0);
end;

class function TAttrEntry_sw.ToVar(const AValue: TAttrEntry): OleVariant;
var
  wrpr: TAttrEntry_sw;
begin
  wrpr        := TAttrEntry_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TAttrEntry_sw.FromVar(const AValue: OleVariant): TAttrEntry;
begin
  Result := TAttrEntry_sw(ConvFromVar(AValue)).FValue;
end;

{ TAttrData_sw }

function TAttrData_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TAttrData_sw.ToVar(TAttrData(AObj));
end;

function TAttrData_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TAttrData_sw.Create as IDispatch;
end;

function TAttrData_Len_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Len: Word;

  if IsGet then
    Result := TAttrData_sw(AObj).FValue.Len
  else
    TAttrData_sw(AObj).FValue.Len := Word(AArgs[0]);
end;

class function TAttrData_sw.GetTypeName: WideString;
begin
  Result := 'TAttrData';
end;

function TAttrData_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TAttrData_sw.Create;
  TAttrData_sw(Result).FValue := FValue;
end;

class procedure TAttrData_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TAttrData_Copy_si, TAttrData_sw, 0);
  AData.AddField('Len', TAttrData_Len_si, Word_sw);

  { Class members }

  AData.AddConstructor('Create', TAttrData_Create_si, 0);
end;

class function TAttrData_sw.ToVar(const AValue: TAttrData): OleVariant;
var
  wrpr: TAttrData_sw;
begin
  wrpr        := TAttrData_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TAttrData_sw.FromVar(const AValue: OleVariant): TAttrData;
begin
  Result := TAttrData_sw(ConvFromVar(AValue)).FValue;
end;

{ TFieldExEntry_sw }

function TFieldExEntry_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TFieldExEntry_sw.ToVar(TFieldExEntry(AObj));
end;

function TFieldExEntry_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TFieldExEntry_sw.Create as IDispatch;
end;

function TFieldExEntry_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: Byte;

  if IsGet then
    Result := TFieldExEntry_sw(AObj).FValue.Flags
  else
    TFieldExEntry_sw(AObj).FValue.Flags := Byte(AArgs[0]);
end;

function TFieldExEntry_Offset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Offset: Longword;

  if IsGet then
    Result := TFieldExEntry_sw(AObj).FValue.Offset
  else
    TFieldExEntry_sw(AObj).FValue.Offset := Longword(AArgs[0]);
end;

function TFieldExEntry_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Name: ShortString;

  if IsGet then
    Result := TFieldExEntry_sw(AObj).FValue.Name
  else
    TFieldExEntry_sw(AObj).FValue.Name := ShortString(AArgs[0]);
end;

class function TFieldExEntry_sw.GetTypeName: WideString;
begin
  Result := 'TFieldExEntry';
end;

function TFieldExEntry_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TFieldExEntry_sw.Create;
  TFieldExEntry_sw(Result).FValue := FValue;
end;

class procedure TFieldExEntry_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TFieldExEntry_Copy_si, TFieldExEntry_sw, 0);
  AData.AddField('Flags', TFieldExEntry_Flags_si, Byte_sw);
  AData.AddField('Offset', TFieldExEntry_Offset_si, Longword_sw);
  AData.AddField('Name', TFieldExEntry_Name_si, ShortString_sw);

  { Class members }

  AData.AddConstructor('Create', TFieldExEntry_Create_si, 0);
end;

class function TFieldExEntry_sw.ToVar(const AValue: TFieldExEntry): OleVariant;
var
  wrpr: TFieldExEntry_sw;
begin
  wrpr        := TFieldExEntry_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TFieldExEntry_sw.FromVar(
  const AValue: OleVariant): TFieldExEntry;
begin
  Result := TFieldExEntry_sw(ConvFromVar(AValue)).FValue;
end;

{ TVmtFieldEntry_sw }

function TVmtFieldEntry_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtFieldEntry_sw.ToVar(TVmtFieldEntry(AObj));
end;

function TVmtFieldEntry_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtFieldEntry_sw.Create as IDispatch;
end;

function TVmtFieldEntry_FieldOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FieldOffset: Longword;

  if IsGet then
    Result := TVmtFieldEntry_sw(AObj).FValue.FieldOffset
  else
    TVmtFieldEntry_sw(AObj).FValue.FieldOffset := Longword(AArgs[0]);
end;

function TVmtFieldEntry_TypeIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TypeIndex: Word;

  if IsGet then
    Result := TVmtFieldEntry_sw(AObj).FValue.TypeIndex
  else
    TVmtFieldEntry_sw(AObj).FValue.TypeIndex := Word(AArgs[0]);
end;

function TVmtFieldEntry_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Name: ShortString;

  if IsGet then
    Result := TVmtFieldEntry_sw(AObj).FValue.Name
  else
    TVmtFieldEntry_sw(AObj).FValue.Name := ShortString(AArgs[0]);
end;

class function TVmtFieldEntry_sw.GetTypeName: WideString;
begin
  Result := 'TVmtFieldEntry';
end;

function TVmtFieldEntry_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVmtFieldEntry_sw.Create;
  TVmtFieldEntry_sw(Result).FValue := FValue;
end;

class procedure TVmtFieldEntry_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TVmtFieldEntry_Copy_si, TVmtFieldEntry_sw, 0);
  AData.AddField('FieldOffset', TVmtFieldEntry_FieldOffset_si, Longword_sw);
  AData.AddField('TypeIndex', TVmtFieldEntry_TypeIndex_si, Word_sw);
  AData.AddField('Name', TVmtFieldEntry_Name_si, ShortString_sw);

  { Class members }

  AData.AddConstructor('Create', TVmtFieldEntry_Create_si, 0);
end;

class function TVmtFieldEntry_sw.ToVar(
  const AValue: TVmtFieldEntry): OleVariant;
var
  wrpr: TVmtFieldEntry_sw;
begin
  wrpr        := TVmtFieldEntry_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVmtFieldEntry_sw.FromVar(
  const AValue: OleVariant): TVmtFieldEntry;
begin
  Result := TVmtFieldEntry_sw(ConvFromVar(AValue)).FValue;
end;

{ TVmtFieldClassTab_sw }

function TVmtFieldClassTab_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtFieldClassTab_sw.ToVar(TVmtFieldClassTab(AObj));
end;

function TVmtFieldClassTab_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtFieldClassTab_sw.Create as IDispatch;
end;

function TVmtFieldClassTab_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Word;

  if IsGet then
    Result := TVmtFieldClassTab_sw(AObj).FValue.Count
  else
    TVmtFieldClassTab_sw(AObj).FValue.Count := Word(AArgs[0]);
end;

class function TVmtFieldClassTab_sw.GetTypeName: WideString;
begin
  Result := 'TVmtFieldClassTab';
end;

function TVmtFieldClassTab_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVmtFieldClassTab_sw.Create;
  TVmtFieldClassTab_sw(Result).FValue := FValue;
end;

class procedure TVmtFieldClassTab_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TVmtFieldClassTab_Copy_si, TVmtFieldClassTab_sw, 0);
  AData.AddField('Count', TVmtFieldClassTab_Count_si, Word_sw);

  { Class members }

  AData.AddConstructor('Create', TVmtFieldClassTab_Create_si, 0);
end;

class function TVmtFieldClassTab_sw.ToVar(
  const AValue: TVmtFieldClassTab): OleVariant;
var
  wrpr: TVmtFieldClassTab_sw;
begin
  wrpr        := TVmtFieldClassTab_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVmtFieldClassTab_sw.FromVar(
  const AValue: OleVariant): TVmtFieldClassTab;
begin
  Result := TVmtFieldClassTab_sw(ConvFromVar(AValue)).FValue;
end;

{ TVmtFieldTable_sw }

function TVmtFieldTable_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtFieldTable_sw.ToVar(TVmtFieldTable(AObj));
end;

function TVmtFieldTable_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtFieldTable_sw.Create as IDispatch;
end;

function TVmtFieldTable_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Word;

  if IsGet then
    Result := TVmtFieldTable_sw(AObj).FValue.Count
  else
    TVmtFieldTable_sw(AObj).FValue.Count := Word(AArgs[0]);
end;

class function TVmtFieldTable_sw.GetTypeName: WideString;
begin
  Result := 'TVmtFieldTable';
end;

function TVmtFieldTable_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVmtFieldTable_sw.Create;
  TVmtFieldTable_sw(Result).FValue := FValue;
end;

class procedure TVmtFieldTable_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TVmtFieldTable_Copy_si, TVmtFieldTable_sw, 0);
  AData.AddField('Count', TVmtFieldTable_Count_si, Word_sw);

  { Class members }

  AData.AddConstructor('Create', TVmtFieldTable_Create_si, 0);
end;

class function TVmtFieldTable_sw.ToVar(
  const AValue: TVmtFieldTable): OleVariant;
var
  wrpr: TVmtFieldTable_sw;
begin
  wrpr        := TVmtFieldTable_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVmtFieldTable_sw.FromVar(
  const AValue: OleVariant): TVmtFieldTable;
begin
  Result := TVmtFieldTable_sw(ConvFromVar(AValue)).FValue;
end;

{ TVmtMethodParam_sw }

function TVmtMethodParam_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtMethodParam_sw.ToVar(TVmtMethodParam(AObj));
end;

function TVmtMethodParam_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtMethodParam_sw.Create as IDispatch;
end;

function TVmtMethodParam_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: Byte;

  if IsGet then
    Result := TVmtMethodParam_sw(AObj).FValue.Flags
  else
    TVmtMethodParam_sw(AObj).FValue.Flags := Byte(AArgs[0]);
end;

function TVmtMethodParam_ParOff_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ParOff: Byte;

  if IsGet then
    Result := TVmtMethodParam_sw(AObj).FValue.ParOff
  else
    TVmtMethodParam_sw(AObj).FValue.ParOff := Byte(AArgs[0]);
end;

class function TVmtMethodParam_sw.GetTypeName: WideString;
begin
  Result := 'TVmtMethodParam';
end;

function TVmtMethodParam_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVmtMethodParam_sw.Create;
  TVmtMethodParam_sw(Result).FValue := FValue;
end;

class procedure TVmtMethodParam_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TVmtMethodParam_Copy_si, TVmtMethodParam_sw, 0);
  AData.AddField('Flags', TVmtMethodParam_Flags_si, Byte_sw);
  AData.AddField('ParOff', TVmtMethodParam_ParOff_si, Byte_sw);

  { Class members }

  AData.AddConstructor('Create', TVmtMethodParam_Create_si, 0);
end;

class function TVmtMethodParam_sw.ToVar(
  const AValue: TVmtMethodParam): OleVariant;
var
  wrpr: TVmtMethodParam_sw;
begin
  wrpr        := TVmtMethodParam_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVmtMethodParam_sw.FromVar(
  const AValue: OleVariant): TVmtMethodParam;
begin
  Result := TVmtMethodParam_sw(ConvFromVar(AValue)).FValue;
end;

{ TVmtMethodEntry_sw }

function TVmtMethodEntry_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtMethodEntry_sw.ToVar(TVmtMethodEntry(AObj));
end;

function TVmtMethodEntry_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtMethodEntry_sw.Create as IDispatch;
end;

function TVmtMethodEntry_Len_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Len: Word;

  if IsGet then
    Result := TVmtMethodEntry_sw(AObj).FValue.Len
  else
    TVmtMethodEntry_sw(AObj).FValue.Len := Word(AArgs[0]);
end;

function TVmtMethodEntry_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Name: ShortString;

  if IsGet then
    Result := TVmtMethodEntry_sw(AObj).FValue.Name
  else
    TVmtMethodEntry_sw(AObj).FValue.Name := ShortString(AArgs[0]);
end;

class function TVmtMethodEntry_sw.GetTypeName: WideString;
begin
  Result := 'TVmtMethodEntry';
end;

function TVmtMethodEntry_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVmtMethodEntry_sw.Create;
  TVmtMethodEntry_sw(Result).FValue := FValue;
end;

class procedure TVmtMethodEntry_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TVmtMethodEntry_Copy_si, TVmtMethodEntry_sw, 0);
  AData.AddField('Len', TVmtMethodEntry_Len_si, Word_sw);
  AData.AddField('Name', TVmtMethodEntry_Name_si, ShortString_sw);

  { Class members }

  AData.AddConstructor('Create', TVmtMethodEntry_Create_si, 0);
end;

class function TVmtMethodEntry_sw.ToVar(
  const AValue: TVmtMethodEntry): OleVariant;
var
  wrpr: TVmtMethodEntry_sw;
begin
  wrpr        := TVmtMethodEntry_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVmtMethodEntry_sw.FromVar(
  const AValue: OleVariant): TVmtMethodEntry;
begin
  Result := TVmtMethodEntry_sw(ConvFromVar(AValue)).FValue;
end;

{ TVmtMethodEntryTail_sw }

function TVmtMethodEntryTail_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtMethodEntryTail_sw.ToVar(TVmtMethodEntryTail(AObj));
end;

function TVmtMethodEntryTail_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtMethodEntryTail_sw.Create as IDispatch;
end;

function TVmtMethodEntryTail_Version_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Version: Byte;

  if IsGet then
    Result := TVmtMethodEntryTail_sw(AObj).FValue.Version
  else
    TVmtMethodEntryTail_sw(AObj).FValue.Version := Byte(AArgs[0]);
end;

function TVmtMethodEntryTail_CC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CC: TCallConv;

  if IsGet then
    Result := TCallConv_sw.ToVar(TVmtMethodEntryTail_sw(AObj).FValue.CC)
  else
    TVmtMethodEntryTail_sw(AObj).FValue.CC := TCallConv_sw.FromVar(AArgs[0]);
end;

function TVmtMethodEntryTail_ParOff_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ParOff: Word;

  if IsGet then
    Result := TVmtMethodEntryTail_sw(AObj).FValue.ParOff
  else
    TVmtMethodEntryTail_sw(AObj).FValue.ParOff := Word(AArgs[0]);
end;

function TVmtMethodEntryTail_ParamCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ParamCount: Byte;

  if IsGet then
    Result := TVmtMethodEntryTail_sw(AObj).FValue.ParamCount
  else
    TVmtMethodEntryTail_sw(AObj).FValue.ParamCount := Byte(AArgs[0]);
end;

class function TVmtMethodEntryTail_sw.GetTypeName: WideString;
begin
  Result := 'TVmtMethodEntryTail';
end;

function TVmtMethodEntryTail_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVmtMethodEntryTail_sw.Create;
  TVmtMethodEntryTail_sw(Result).FValue := FValue;
end;

class procedure TVmtMethodEntryTail_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TVmtMethodEntryTail_Copy_si, TVmtMethodEntryTail_sw, 0);
  AData.AddField('Version', TVmtMethodEntryTail_Version_si, Byte_sw);
  AData.AddField('CC', TVmtMethodEntryTail_CC_si, TCallConv_sw);
  AData.AddField('ParOff', TVmtMethodEntryTail_ParOff_si, Word_sw);
  AData.AddField('ParamCount', TVmtMethodEntryTail_ParamCount_si, Byte_sw);

  { Class members }

  AData.AddConstructor('Create', TVmtMethodEntryTail_Create_si, 0);
end;

class function TVmtMethodEntryTail_sw.ToVar(
  const AValue: TVmtMethodEntryTail): OleVariant;
var
  wrpr: TVmtMethodEntryTail_sw;
begin
  wrpr        := TVmtMethodEntryTail_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVmtMethodEntryTail_sw.FromVar(
  const AValue: OleVariant): TVmtMethodEntryTail;
begin
  Result := TVmtMethodEntryTail_sw(ConvFromVar(AValue)).FValue;
end;

{ TVmtMethodExEntry_sw }

function TVmtMethodExEntry_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtMethodExEntry_sw.ToVar(TVmtMethodExEntry(AObj));
end;

function TVmtMethodExEntry_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtMethodExEntry_sw.Create as IDispatch;
end;

function TVmtMethodExEntry_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: Word;

  if IsGet then
    Result := TVmtMethodExEntry_sw(AObj).FValue.Flags
  else
    TVmtMethodExEntry_sw(AObj).FValue.Flags := Word(AArgs[0]);
end;

function TVmtMethodExEntry_VirtualIndex_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var VirtualIndex: Smallint;

  if IsGet then
    Result := TVmtMethodExEntry_sw(AObj).FValue.VirtualIndex
  else
    TVmtMethodExEntry_sw(AObj).FValue.VirtualIndex := Smallint(AArgs[0]);
end;

class function TVmtMethodExEntry_sw.GetTypeName: WideString;
begin
  Result := 'TVmtMethodExEntry';
end;

function TVmtMethodExEntry_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVmtMethodExEntry_sw.Create;
  TVmtMethodExEntry_sw(Result).FValue := FValue;
end;

class procedure TVmtMethodExEntry_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TVmtMethodExEntry_Copy_si, TVmtMethodExEntry_sw, 0);
  AData.AddField('Flags', TVmtMethodExEntry_Flags_si, Word_sw);
  AData.AddField('VirtualIndex', TVmtMethodExEntry_VirtualIndex_si, Smallint_sw);

  { Class members }

  AData.AddConstructor('Create', TVmtMethodExEntry_Create_si, 0);
end;

class function TVmtMethodExEntry_sw.ToVar(
  const AValue: TVmtMethodExEntry): OleVariant;
var
  wrpr: TVmtMethodExEntry_sw;
begin
  wrpr        := TVmtMethodExEntry_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVmtMethodExEntry_sw.FromVar(
  const AValue: OleVariant): TVmtMethodExEntry;
begin
  Result := TVmtMethodExEntry_sw(ConvFromVar(AValue)).FValue;
end;

{ TVmtMethodTable_sw }

function TVmtMethodTable_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtMethodTable_sw.ToVar(TVmtMethodTable(AObj));
end;

function TVmtMethodTable_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TVmtMethodTable_sw.Create as IDispatch;
end;

function TVmtMethodTable_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Word;

  if IsGet then
    Result := TVmtMethodTable_sw(AObj).FValue.Count
  else
    TVmtMethodTable_sw(AObj).FValue.Count := Word(AArgs[0]);
end;

class function TVmtMethodTable_sw.GetTypeName: WideString;
begin
  Result := 'TVmtMethodTable';
end;

function TVmtMethodTable_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TVmtMethodTable_sw.Create;
  TVmtMethodTable_sw(Result).FValue := FValue;
end;

class procedure TVmtMethodTable_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TVmtMethodTable_Copy_si, TVmtMethodTable_sw, 0);
  AData.AddField('Count', TVmtMethodTable_Count_si, Word_sw);

  { Class members }

  AData.AddConstructor('Create', TVmtMethodTable_Create_si, 0);
end;

class function TVmtMethodTable_sw.ToVar(
  const AValue: TVmtMethodTable): OleVariant;
var
  wrpr: TVmtMethodTable_sw;
begin
  wrpr        := TVmtMethodTable_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TVmtMethodTable_sw.FromVar(
  const AValue: OleVariant): TVmtMethodTable;
begin
  Result := TVmtMethodTable_sw(ConvFromVar(AValue)).FValue;
end;

{ TManagedField_sw }

function TManagedField_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TManagedField_sw.ToVar(TManagedField(AObj));
end;

function TManagedField_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TManagedField_sw.Create as IDispatch;
end;

function TManagedField_FldOffset_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FldOffset: Integer;

  if IsGet then
    Result := TManagedField_sw(AObj).FValue.FldOffset
  else
    TManagedField_sw(AObj).FValue.FldOffset := Integer(AArgs[0]);
end;

class function TManagedField_sw.GetTypeName: WideString;
begin
  Result := 'TManagedField';
end;

function TManagedField_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TManagedField_sw.Create;
  TManagedField_sw(Result).FValue := FValue;
end;

class procedure TManagedField_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TManagedField_Copy_si, TManagedField_sw, 0);
  AData.AddField('FldOffset', TManagedField_FldOffset_si, Integer_sw);

  { Class members }

  AData.AddConstructor('Create', TManagedField_Create_si, 0);
end;

class function TManagedField_sw.ToVar(const AValue: TManagedField): OleVariant;
var
  wrpr: TManagedField_sw;
begin
  wrpr        := TManagedField_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TManagedField_sw.FromVar(
  const AValue: OleVariant): TManagedField;
begin
  Result := TManagedField_sw(ConvFromVar(AValue)).FValue;
end;

{ TProcedureParam_sw }

function TProcedureParam_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TProcedureParam_sw.ToVar(TProcedureParam(AObj));
end;

function TProcedureParam_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TProcedureParam_sw.Create as IDispatch;
end;

function TProcedureParam_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: Byte;

  if IsGet then
    Result := TProcedureParam_sw(AObj).FValue.Flags
  else
    TProcedureParam_sw(AObj).FValue.Flags := Byte(AArgs[0]);
end;

class function TProcedureParam_sw.GetTypeName: WideString;
begin
  Result := 'TProcedureParam';
end;

function TProcedureParam_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TProcedureParam_sw.Create;
  TProcedureParam_sw(Result).FValue := FValue;
end;

class procedure TProcedureParam_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TProcedureParam_Copy_si, TProcedureParam_sw, 0);
  AData.AddField('Flags', TProcedureParam_Flags_si, Byte_sw);

  { Class members }

  AData.AddConstructor('Create', TProcedureParam_Create_si, 0);
end;

class function TProcedureParam_sw.ToVar(
  const AValue: TProcedureParam): OleVariant;
var
  wrpr: TProcedureParam_sw;
begin
  wrpr        := TProcedureParam_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TProcedureParam_sw.FromVar(
  const AValue: OleVariant): TProcedureParam;
begin
  Result := TProcedureParam_sw(ConvFromVar(AValue)).FValue;
end;

{ TProcedureSignature_sw }

function TProcedureSignature_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TProcedureSignature_sw.ToVar(TProcedureSignature(AObj));
end;

function TProcedureSignature_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TProcedureSignature_sw.Create as IDispatch;
end;

function TProcedureSignature_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: Byte;

  if IsGet then
    Result := TProcedureSignature_sw(AObj).FValue.Flags
  else
    TProcedureSignature_sw(AObj).FValue.Flags := Byte(AArgs[0]);
end;

function TProcedureSignature_CC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CC: TCallConv;

  if IsGet then
    Result := TCallConv_sw.ToVar(TProcedureSignature_sw(AObj).FValue.CC)
  else
    TProcedureSignature_sw(AObj).FValue.CC := TCallConv_sw.FromVar(AArgs[0]);
end;

function TProcedureSignature_ParamCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ParamCount: Byte;

  if IsGet then
    Result := TProcedureSignature_sw(AObj).FValue.ParamCount
  else
    TProcedureSignature_sw(AObj).FValue.ParamCount := Byte(AArgs[0]);
end;

class function TProcedureSignature_sw.GetTypeName: WideString;
begin
  Result := 'TProcedureSignature';
end;

function TProcedureSignature_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TProcedureSignature_sw.Create;
  TProcedureSignature_sw(Result).FValue := FValue;
end;

class procedure TProcedureSignature_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TProcedureSignature_Copy_si, TProcedureSignature_sw, 0);
  AData.AddField('Flags', TProcedureSignature_Flags_si, Byte_sw);
  AData.AddField('CC', TProcedureSignature_CC_si, TCallConv_sw);
  AData.AddField('ParamCount', TProcedureSignature_ParamCount_si, Byte_sw);

  { Class members }

  AData.AddConstructor('Create', TProcedureSignature_Create_si, 0);
end;

class function TProcedureSignature_sw.ToVar(
  const AValue: TProcedureSignature): OleVariant;
var
  wrpr: TProcedureSignature_sw;
begin
  wrpr        := TProcedureSignature_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TProcedureSignature_sw.FromVar(
  const AValue: OleVariant): TProcedureSignature;
begin
  Result := TProcedureSignature_sw(ConvFromVar(AValue)).FValue;
end;

{ TIntfMethodTable_sw }

function TIntfMethodTable_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIntfMethodTable_sw.ToVar(TIntfMethodTable(AObj));
end;

function TIntfMethodTable_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIntfMethodTable_sw.Create as IDispatch;
end;

function TIntfMethodTable_Count_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Count: Word;

  if IsGet then
    Result := TIntfMethodTable_sw(AObj).FValue.Count
  else
    TIntfMethodTable_sw(AObj).FValue.Count := Word(AArgs[0]);
end;

function TIntfMethodTable_RttiCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var RttiCount: Word;

  if IsGet then
    Result := TIntfMethodTable_sw(AObj).FValue.RttiCount
  else
    TIntfMethodTable_sw(AObj).FValue.RttiCount := Word(AArgs[0]);
end;

class function TIntfMethodTable_sw.GetTypeName: WideString;
begin
  Result := 'TIntfMethodTable';
end;

function TIntfMethodTable_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TIntfMethodTable_sw.Create;
  TIntfMethodTable_sw(Result).FValue := FValue;
end;

class procedure TIntfMethodTable_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TIntfMethodTable_Copy_si, TIntfMethodTable_sw, 0);
  AData.AddField('Count', TIntfMethodTable_Count_si, Word_sw);
  AData.AddField('RttiCount', TIntfMethodTable_RttiCount_si, Word_sw);

  { Class members }

  AData.AddConstructor('Create', TIntfMethodTable_Create_si, 0);
end;

class function TIntfMethodTable_sw.ToVar(
  const AValue: TIntfMethodTable): OleVariant;
var
  wrpr: TIntfMethodTable_sw;
begin
  wrpr        := TIntfMethodTable_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TIntfMethodTable_sw.FromVar(
  const AValue: OleVariant): TIntfMethodTable;
begin
  Result := TIntfMethodTable_sw(ConvFromVar(AValue)).FValue;
end;

{ TIntfMethodEntry_sw }

function TIntfMethodEntry_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIntfMethodEntry_sw.ToVar(TIntfMethodEntry(AObj));
end;

function TIntfMethodEntry_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIntfMethodEntry_sw.Create as IDispatch;
end;

function TIntfMethodEntry_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Name: ShortString;

  if IsGet then
    Result := TIntfMethodEntry_sw(AObj).FValue.Name
  else
    TIntfMethodEntry_sw(AObj).FValue.Name := ShortString(AArgs[0]);
end;

class function TIntfMethodEntry_sw.GetTypeName: WideString;
begin
  Result := 'TIntfMethodEntry';
end;

function TIntfMethodEntry_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TIntfMethodEntry_sw.Create;
  TIntfMethodEntry_sw(Result).FValue := FValue;
end;

class procedure TIntfMethodEntry_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TIntfMethodEntry_Copy_si, TIntfMethodEntry_sw, 0);
  AData.AddField('Name', TIntfMethodEntry_Name_si, ShortString_sw);

  { Class members }

  AData.AddConstructor('Create', TIntfMethodEntry_Create_si, 0);
end;

class function TIntfMethodEntry_sw.ToVar(
  const AValue: TIntfMethodEntry): OleVariant;
var
  wrpr: TIntfMethodEntry_sw;
begin
  wrpr        := TIntfMethodEntry_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TIntfMethodEntry_sw.FromVar(
  const AValue: OleVariant): TIntfMethodEntry;
begin
  Result := TIntfMethodEntry_sw(ConvFromVar(AValue)).FValue;
end;

{ TIntfMethodEntryTail_sw }

function TIntfMethodEntryTail_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIntfMethodEntryTail_sw.ToVar(TIntfMethodEntryTail(AObj));
end;

function TIntfMethodEntryTail_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIntfMethodEntryTail_sw.Create as IDispatch;
end;

function TIntfMethodEntryTail_Kind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Kind: Byte;

  if IsGet then
    Result := TIntfMethodEntryTail_sw(AObj).FValue.Kind
  else
    TIntfMethodEntryTail_sw(AObj).FValue.Kind := Byte(AArgs[0]);
end;

function TIntfMethodEntryTail_CC_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var CC: TCallConv;

  if IsGet then
    Result := TCallConv_sw.ToVar(TIntfMethodEntryTail_sw(AObj).FValue.CC)
  else
    TIntfMethodEntryTail_sw(AObj).FValue.CC := TCallConv_sw.FromVar(AArgs[0]);
end;

function TIntfMethodEntryTail_ParamCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ParamCount: Byte;

  if IsGet then
    Result := TIntfMethodEntryTail_sw(AObj).FValue.ParamCount
  else
    TIntfMethodEntryTail_sw(AObj).FValue.ParamCount := Byte(AArgs[0]);
end;

class function TIntfMethodEntryTail_sw.GetTypeName: WideString;
begin
  Result := 'TIntfMethodEntryTail';
end;

function TIntfMethodEntryTail_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TIntfMethodEntryTail_sw.Create;
  TIntfMethodEntryTail_sw(Result).FValue := FValue;
end;

class procedure TIntfMethodEntryTail_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TIntfMethodEntryTail_Copy_si, TIntfMethodEntryTail_sw, 0);
  AData.AddField('Kind', TIntfMethodEntryTail_Kind_si, Byte_sw);
  AData.AddField('CC', TIntfMethodEntryTail_CC_si, TCallConv_sw);
  AData.AddField('ParamCount', TIntfMethodEntryTail_ParamCount_si, Byte_sw);

  { Class members }

  AData.AddConstructor('Create', TIntfMethodEntryTail_Create_si, 0);
end;

class function TIntfMethodEntryTail_sw.ToVar(
  const AValue: TIntfMethodEntryTail): OleVariant;
var
  wrpr: TIntfMethodEntryTail_sw;
begin
  wrpr        := TIntfMethodEntryTail_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TIntfMethodEntryTail_sw.FromVar(
  const AValue: OleVariant): TIntfMethodEntryTail;
begin
  Result := TIntfMethodEntryTail_sw(ConvFromVar(AValue)).FValue;
end;

{ TIntfMethodParam_sw }

function TIntfMethodParam_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIntfMethodParam_sw.ToVar(TIntfMethodParam(AObj));
end;

function TIntfMethodParam_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIntfMethodParam_sw.Create as IDispatch;
end;

function TIntfMethodParam_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: Byte;

  if IsGet then
    Result := TIntfMethodParam_sw(AObj).FValue.Flags
  else
    TIntfMethodParam_sw(AObj).FValue.Flags := Byte(AArgs[0]);
end;

function TIntfMethodParam_ParamName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ParamName: ShortString;

  if IsGet then
    Result := TIntfMethodParam_sw(AObj).FValue.ParamName
  else
    TIntfMethodParam_sw(AObj).FValue.ParamName := ShortString(AArgs[0]);
end;

class function TIntfMethodParam_sw.GetTypeName: WideString;
begin
  Result := 'TIntfMethodParam';
end;

function TIntfMethodParam_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TIntfMethodParam_sw.Create;
  TIntfMethodParam_sw(Result).FValue := FValue;
end;

class procedure TIntfMethodParam_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TIntfMethodParam_Copy_si, TIntfMethodParam_sw, 0);
  AData.AddField('Flags', TIntfMethodParam_Flags_si, Byte_sw);
  AData.AddField('ParamName', TIntfMethodParam_ParamName_si, ShortString_sw);

  { Class members }

  AData.AddConstructor('Create', TIntfMethodParam_Create_si, 0);
end;

class function TIntfMethodParam_sw.ToVar(
  const AValue: TIntfMethodParam): OleVariant;
var
  wrpr: TIntfMethodParam_sw;
begin
  wrpr        := TIntfMethodParam_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TIntfMethodParam_sw.FromVar(
  const AValue: OleVariant): TIntfMethodParam;
begin
  Result := TIntfMethodParam_sw(ConvFromVar(AValue)).FValue;
end;

{ TIntfMethodParamTail_sw }

function TIntfMethodParamTail_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIntfMethodParamTail_sw.ToVar(TIntfMethodParamTail(AObj));
end;

function TIntfMethodParamTail_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TIntfMethodParamTail_sw.Create as IDispatch;
end;

function TIntfMethodParamTail_AttrData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var AttrData: TAttrData;

  if IsGet then
    Result := TAttrData_sw.ToVar(TIntfMethodParamTail_sw(AObj).FValue.AttrData)
  else
    TIntfMethodParamTail_sw(AObj).FValue.AttrData := TAttrData_sw.FromVar(
      AArgs[0]);
end;

class function TIntfMethodParamTail_sw.GetTypeName: WideString;
begin
  Result := 'TIntfMethodParamTail';
end;

function TIntfMethodParamTail_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TIntfMethodParamTail_sw.Create;
  TIntfMethodParamTail_sw(Result).FValue := FValue;
end;

class procedure TIntfMethodParamTail_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TIntfMethodParamTail_Copy_si, TIntfMethodParamTail_sw, 0);
  AData.AddField('AttrData', TIntfMethodParamTail_AttrData_si, TAttrData_sw);

  { Class members }

  AData.AddConstructor('Create', TIntfMethodParamTail_Create_si, 0);
end;

class function TIntfMethodParamTail_sw.ToVar(
  const AValue: TIntfMethodParamTail): OleVariant;
var
  wrpr: TIntfMethodParamTail_sw;
begin
  wrpr        := TIntfMethodParamTail_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TIntfMethodParamTail_sw.FromVar(
  const AValue: OleVariant): TIntfMethodParamTail;
begin
  Result := TIntfMethodParamTail_sw(ConvFromVar(AValue)).FValue;
end;

{ TArrayTypeData_sw }

function TArrayTypeData_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TArrayTypeData_sw.ToVar(TArrayTypeData(AObj));
end;

function TArrayTypeData_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TArrayTypeData_sw.Create as IDispatch;
end;

function TArrayTypeData_Size_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Size: Integer;

  if IsGet then
    Result := TArrayTypeData_sw(AObj).FValue.Size
  else
    TArrayTypeData_sw(AObj).FValue.Size := Integer(AArgs[0]);
end;

function TArrayTypeData_ElCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var ElCount: Integer;

  if IsGet then
    Result := TArrayTypeData_sw(AObj).FValue.ElCount
  else
    TArrayTypeData_sw(AObj).FValue.ElCount := Integer(AArgs[0]);
end;

function TArrayTypeData_DimCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DimCount: Byte;

  if IsGet then
    Result := TArrayTypeData_sw(AObj).FValue.DimCount
  else
    TArrayTypeData_sw(AObj).FValue.DimCount := Byte(AArgs[0]);
end;

class function TArrayTypeData_sw.GetTypeName: WideString;
begin
  Result := 'TArrayTypeData';
end;

function TArrayTypeData_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TArrayTypeData_sw.Create;
  TArrayTypeData_sw(Result).FValue := FValue;
end;

class procedure TArrayTypeData_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TArrayTypeData_Copy_si, TArrayTypeData_sw, 0);
  AData.AddField('Size', TArrayTypeData_Size_si, Integer_sw);
  AData.AddField('ElCount', TArrayTypeData_ElCount_si, Integer_sw);
  AData.AddField('DimCount', TArrayTypeData_DimCount_si, Byte_sw);

  { Class members }

  AData.AddConstructor('Create', TArrayTypeData_Create_si, 0);
end;

class function TArrayTypeData_sw.ToVar(
  const AValue: TArrayTypeData): OleVariant;
var
  wrpr: TArrayTypeData_sw;
begin
  wrpr        := TArrayTypeData_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TArrayTypeData_sw.FromVar(
  const AValue: OleVariant): TArrayTypeData;
begin
  Result := TArrayTypeData_sw(ConvFromVar(AValue)).FValue;
end;

{ TRecordTypeField_sw }

function TRecordTypeField_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TRecordTypeField_sw.ToVar(TRecordTypeField(AObj));
end;

function TRecordTypeField_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TRecordTypeField_sw.Create as IDispatch;
end;

function TRecordTypeField_Field_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Field: TManagedField;

  if IsGet then
    Result := TManagedField_sw.ToVar(TRecordTypeField_sw(AObj).FValue.Field)
  else
    TRecordTypeField_sw(AObj).FValue.Field := TManagedField_sw.FromVar(
      AArgs[0]);
end;

function TRecordTypeField_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: Byte;

  if IsGet then
    Result := TRecordTypeField_sw(AObj).FValue.Flags
  else
    TRecordTypeField_sw(AObj).FValue.Flags := Byte(AArgs[0]);
end;

function TRecordTypeField_Name_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Name: ShortString;

  if IsGet then
    Result := TRecordTypeField_sw(AObj).FValue.Name
  else
    TRecordTypeField_sw(AObj).FValue.Name := ShortString(AArgs[0]);
end;

class function TRecordTypeField_sw.GetTypeName: WideString;
begin
  Result := 'TRecordTypeField';
end;

function TRecordTypeField_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TRecordTypeField_sw.Create;
  TRecordTypeField_sw(Result).FValue := FValue;
end;

class procedure TRecordTypeField_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TRecordTypeField_Copy_si, TRecordTypeField_sw, 0);
  AData.AddField('Field', TRecordTypeField_Field_si, TManagedField_sw);
  AData.AddField('Flags', TRecordTypeField_Flags_si, Byte_sw);
  AData.AddField('Name', TRecordTypeField_Name_si, ShortString_sw);

  { Class members }

  AData.AddConstructor('Create', TRecordTypeField_Create_si, 0);
end;

class function TRecordTypeField_sw.ToVar(
  const AValue: TRecordTypeField): OleVariant;
var
  wrpr: TRecordTypeField_sw;
begin
  wrpr        := TRecordTypeField_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TRecordTypeField_sw.FromVar(
  const AValue: OleVariant): TRecordTypeField;
begin
  Result := TRecordTypeField_sw(ConvFromVar(AValue)).FValue;
end;

{ TPropDataEx_sw }

function TPropDataEx_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TPropDataEx_sw.ToVar(TPropDataEx(AObj));
end;

function TPropDataEx_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TPropDataEx_sw.Create as IDispatch;
end;

function TPropDataEx_PropCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PropCount: Word;

  if IsGet then
    Result := TPropDataEx_sw(AObj).FValue.PropCount
  else
    TPropDataEx_sw(AObj).FValue.PropCount := Word(AArgs[0]);
end;

class function TPropDataEx_sw.GetTypeName: WideString;
begin
  Result := 'TPropDataEx';
end;

function TPropDataEx_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPropDataEx_sw.Create;
  TPropDataEx_sw(Result).FValue := FValue;
end;

class procedure TPropDataEx_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TPropDataEx_Copy_si, TPropDataEx_sw, 0);
  AData.AddField('PropCount', TPropDataEx_PropCount_si, Word_sw);

  { Class members }

  AData.AddConstructor('Create', TPropDataEx_Create_si, 0);
end;

class function TPropDataEx_sw.ToVar(const AValue: TPropDataEx): OleVariant;
var
  wrpr: TPropDataEx_sw;
begin
  wrpr        := TPropDataEx_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPropDataEx_sw.FromVar(const AValue: OleVariant): TPropDataEx;
begin
  Result := TPropDataEx_sw(ConvFromVar(AValue)).FValue;
end;

{ TPropInfoEx_sw }

function TPropInfoEx_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TPropInfoEx_sw.ToVar(TPropInfoEx(AObj));
end;

function TPropInfoEx_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  Result := TPropInfoEx_sw.Create as IDispatch;
end;

function TPropInfoEx_Flags_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Flags: Byte;

  if IsGet then
    Result := TPropInfoEx_sw(AObj).FValue.Flags
  else
    TPropInfoEx_sw(AObj).FValue.Flags := Byte(AArgs[0]);
end;

function TPropInfoEx_AttrData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var AttrData: TAttrData;

  if IsGet then
    Result := TAttrData_sw.ToVar(TPropInfoEx_sw(AObj).FValue.AttrData)
  else
    TPropInfoEx_sw(AObj).FValue.AttrData := TAttrData_sw.FromVar(AArgs[0]);
end;

class function TPropInfoEx_sw.GetTypeName: WideString;
begin
  Result := 'TPropInfoEx';
end;

function TPropInfoEx_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TPropInfoEx_sw.Create;
  TPropInfoEx_sw(Result).FValue := FValue;
end;

class procedure TPropInfoEx_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddFunction('Copy', TPropInfoEx_Copy_si, TPropInfoEx_sw, 0);
  AData.AddField('Flags', TPropInfoEx_Flags_si, Byte_sw);
  AData.AddField('AttrData', TPropInfoEx_AttrData_si, TAttrData_sw);

  { Class members }

  AData.AddConstructor('Create', TPropInfoEx_Create_si, 0);
end;

class function TPropInfoEx_sw.ToVar(const AValue: TPropInfoEx): OleVariant;
var
  wrpr: TPropInfoEx_sw;
begin
  wrpr        := TPropInfoEx_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TPropInfoEx_sw.FromVar(const AValue: OleVariant): TPropInfoEx;
begin
  Result := TPropInfoEx_sw(ConvFromVar(AValue)).FValue;
end;

{ EPropertyError_sw }

class function EPropertyError_sw.GetTypeName: WideString;
begin
  Result := 'EPropertyError';
end;

class function EPropertyError_sw.GetWrappedClass: TClass;
begin
  Result := EPropertyError;
end;

class procedure EPropertyError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EPropertyError_sw.ToVar(
  const AValue: EPropertyError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EPropertyError_sw.FromVar(
  const AValue: OleVariant): EPropertyError;
begin
  Result := EPropertyError(ConvFromVar(AValue, EPropertyError));
end;

class function EPropertyError_sw.ClassToVar(
  AClass: EPropertyError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EPropertyError_sw.ClassFromVar(
  const AClass: OleVariant): EPropertyError_sc;
begin
  Result := EPropertyError_sc(ConvClsFromVar(AClass, EPropertyError));
end;

{ EPropertyConvertError_sw }

class function EPropertyConvertError_sw.GetTypeName: WideString;
begin
  Result := 'EPropertyConvertError';
end;

class function EPropertyConvertError_sw.GetWrappedClass: TClass;
begin
  Result := EPropertyConvertError;
end;

class procedure EPropertyConvertError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EPropertyConvertError_sw.ToVar(
  const AValue: EPropertyConvertError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EPropertyConvertError_sw.FromVar(
  const AValue: OleVariant): EPropertyConvertError;
begin
  Result := EPropertyConvertError(ConvFromVar(AValue, EPropertyConvertError));
end;

class function EPropertyConvertError_sw.ClassToVar(
  AClass: EPropertyConvertError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EPropertyConvertError_sw.ClassFromVar(
  const AClass: OleVariant): EPropertyConvertError_sc;
begin
  Result := EPropertyConvertError_sc(ConvClsFromVar(AClass, 
    EPropertyConvertError));
end;

{ TypInfo_sw }

function TypInfo_TTypeKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTypeKind = (tkInteger, tkChar, tkEnumeration, tkFlo...

  Result := TLMDUnitWrapper.TypeToVar(TTypeKind_sw);
end;

function TypInfo_TPublishableVariantType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPublishableVariantType = class(TInvokeableVariantTy...

  Result := TLMDUnitWrapper.TypeToVar(TPublishableVariantType_sw);
end;

function TypInfo_TTypeKinds_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TTypeKinds = set of TTypeKind;

  Result := TLMDUnitWrapper.TypeToVar(TTypeKinds_sw);
end;

function TypInfo_TOrdType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TOrdType = (otUByte, otSWord, otUWord, otSLong, otUL...

  Result := TLMDUnitWrapper.TypeToVar(TOrdType_sw);
end;

function TypInfo_TFloatType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFloatType = (ftDouble, ftExtended, ftComp, ftCurr);

  Result := TLMDUnitWrapper.TypeToVar(TFloatType_sw);
end;

function TypInfo_TMemberVisibility_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMemberVisibility = (mvProtected, mvPublic, mvPublis...

  Result := TLMDUnitWrapper.TypeToVar(TMemberVisibility_sw);
end;

function TypInfo_TMethodKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TMethodKind = (mkFunction, mkConstructor, mkDestruct...

  Result := TLMDUnitWrapper.TypeToVar(TMethodKind_sw);
end;

function TypInfo_TCallConv_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCallConv = (ccCdecl, ccPascal, ccStdCall, ccSafeCall);

  Result := TLMDUnitWrapper.TypeToVar(TCallConv_sw);
end;

function TypInfo_TAttrEntry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAttrEntry = record;

  Result := TLMDUnitWrapper.TypeToVar(TAttrEntry_sw);
end;

function TypInfo_TAttrData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TAttrData = record;

  Result := TLMDUnitWrapper.TypeToVar(TAttrData_sw);
end;

function TypInfo_TFieldExEntry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldExEntry = record;

  Result := TLMDUnitWrapper.TypeToVar(TFieldExEntry_sw);
end;

function TypInfo_TVmtFieldEntry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVmtFieldEntry = record;

  Result := TLMDUnitWrapper.TypeToVar(TVmtFieldEntry_sw);
end;

function TypInfo_TVmtFieldClassTab_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVmtFieldClassTab = record;

  Result := TLMDUnitWrapper.TypeToVar(TVmtFieldClassTab_sw);
end;

function TypInfo_TVmtFieldTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVmtFieldTable = record;

  Result := TLMDUnitWrapper.TypeToVar(TVmtFieldTable_sw);
end;

function TypInfo_TVmtMethodParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVmtMethodParam = record;

  Result := TLMDUnitWrapper.TypeToVar(TVmtMethodParam_sw);
end;

function TypInfo_TVmtMethodEntry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVmtMethodEntry = record;

  Result := TLMDUnitWrapper.TypeToVar(TVmtMethodEntry_sw);
end;

function TypInfo_TVmtMethodEntryTail_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVmtMethodEntryTail = record;

  Result := TLMDUnitWrapper.TypeToVar(TVmtMethodEntryTail_sw);
end;

function TypInfo_TVmtMethodExEntry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVmtMethodExEntry = record;

  Result := TLMDUnitWrapper.TypeToVar(TVmtMethodExEntry_sw);
end;

function TypInfo_TVmtMethodTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVmtMethodTable = record;

  Result := TLMDUnitWrapper.TypeToVar(TVmtMethodTable_sw);
end;

function TypInfo_TManagedField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TManagedField = record;

  Result := TLMDUnitWrapper.TypeToVar(TManagedField_sw);
end;

function TypInfo_TProcedureParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProcedureParam = record;

  Result := TLMDUnitWrapper.TypeToVar(TProcedureParam_sw);
end;

function TypInfo_TProcedureSignature_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TProcedureSignature = record;

  Result := TLMDUnitWrapper.TypeToVar(TProcedureSignature_sw);
end;

function TypInfo_TIntfMethodTable_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIntfMethodTable = record;

  Result := TLMDUnitWrapper.TypeToVar(TIntfMethodTable_sw);
end;

function TypInfo_TIntfMethodEntry_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIntfMethodEntry = record;

  Result := TLMDUnitWrapper.TypeToVar(TIntfMethodEntry_sw);
end;

function TypInfo_TIntfMethodEntryTail_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIntfMethodEntryTail = record;

  Result := TLMDUnitWrapper.TypeToVar(TIntfMethodEntryTail_sw);
end;

function TypInfo_TIntfMethodParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIntfMethodParam = record;

  Result := TLMDUnitWrapper.TypeToVar(TIntfMethodParam_sw);
end;

function TypInfo_TIntfMethodParamTail_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TIntfMethodParamTail = record;

  Result := TLMDUnitWrapper.TypeToVar(TIntfMethodParamTail_sw);
end;

function TypInfo_TArrayTypeData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TArrayTypeData = record;

  Result := TLMDUnitWrapper.TypeToVar(TArrayTypeData_sw);
end;

function TypInfo_TRecordTypeField_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TRecordTypeField = record;

  Result := TLMDUnitWrapper.TypeToVar(TRecordTypeField_sw);
end;

function TypInfo_TPropDataEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPropDataEx = record;

  Result := TLMDUnitWrapper.TypeToVar(TPropDataEx_sw);
end;

function TypInfo_TPropInfoEx_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TPropInfoEx = record;

  Result := TLMDUnitWrapper.TypeToVar(TPropInfoEx_sw);
end;

function TypInfo_EPropertyError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EPropertyError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EPropertyError_sw);
end;

function TypInfo_EPropertyConvertError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EPropertyConvertError = class(Exception);

  Result := TLMDUnitWrapper.TypeToVar(EPropertyConvertError_sw);
end;

function TypInfo_SamePropTypeName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SamePropTypeName(const Name1: ShortString; const...

  Result := TypInfo.SamePropTypeName(ShortString(AArgs[0]), ShortString(
    AArgs[1]));
end;

class function TypInfo_sw.GetUnitName: WideString;
begin
  Result := 'TypInfo';
end;

class procedure TypInfo_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TTypeKind_sw, TypInfo_TTypeKind_si);
  AData.AddType(TPublishableVariantType_sw, TypInfo_TPublishableVariantType_si);
  AData.AddType(TTypeKinds_sw, TypInfo_TTypeKinds_si);
  AData.AddType(TOrdType_sw, TypInfo_TOrdType_si);
  AData.AddType(TFloatType_sw, TypInfo_TFloatType_si);
  AData.AddType(TMemberVisibility_sw, TypInfo_TMemberVisibility_si);
  AData.AddType(TMethodKind_sw, TypInfo_TMethodKind_si);
  AData.AddType(TCallConv_sw, TypInfo_TCallConv_si);
  AData.AddType(TAttrEntry_sw, TypInfo_TAttrEntry_si);
  AData.AddType(TAttrData_sw, TypInfo_TAttrData_si);
  AData.AddType(TFieldExEntry_sw, TypInfo_TFieldExEntry_si);
  AData.AddType(TVmtFieldEntry_sw, TypInfo_TVmtFieldEntry_si);
  AData.AddType(TVmtFieldClassTab_sw, TypInfo_TVmtFieldClassTab_si);
  AData.AddType(TVmtFieldTable_sw, TypInfo_TVmtFieldTable_si);
  AData.AddType(TVmtMethodParam_sw, TypInfo_TVmtMethodParam_si);
  AData.AddType(TVmtMethodEntry_sw, TypInfo_TVmtMethodEntry_si);
  AData.AddType(TVmtMethodEntryTail_sw, TypInfo_TVmtMethodEntryTail_si);
  AData.AddType(TVmtMethodExEntry_sw, TypInfo_TVmtMethodExEntry_si);
  AData.AddType(TVmtMethodTable_sw, TypInfo_TVmtMethodTable_si);
  AData.AddType(TManagedField_sw, TypInfo_TManagedField_si);
  AData.AddType(TProcedureParam_sw, TypInfo_TProcedureParam_si);
  AData.AddType(TProcedureSignature_sw, TypInfo_TProcedureSignature_si);
  AData.AddType(TIntfMethodTable_sw, TypInfo_TIntfMethodTable_si);
  AData.AddType(TIntfMethodEntry_sw, TypInfo_TIntfMethodEntry_si);
  AData.AddType(TIntfMethodEntryTail_sw, TypInfo_TIntfMethodEntryTail_si);
  AData.AddType(TIntfMethodParam_sw, TypInfo_TIntfMethodParam_si);
  AData.AddType(TIntfMethodParamTail_sw, TypInfo_TIntfMethodParamTail_si);
  AData.AddType(TArrayTypeData_sw, TypInfo_TArrayTypeData_si);
  AData.AddType(TRecordTypeField_sw, TypInfo_TRecordTypeField_si);
  AData.AddType(TPropDataEx_sw, TypInfo_TPropDataEx_si);
  AData.AddType(TPropInfoEx_sw, TypInfo_TPropInfoEx_si);
  AData.AddType(EPropertyError_sw, TypInfo_EPropertyError_si);
  AData.AddType(EPropertyConvertError_sw, TypInfo_EPropertyConvertError_si);
  AData.AddFunction('SamePropTypeName', TypInfo_SamePropTypeName_si, Boolean_sw, 2, False);
end;

class function TypInfo_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(TypInfo_sw);
end;

initialization
  RegisterUnitWrapper(TypInfo_sw);
  RegisterClassWrapper(TPublishableVariantType_sw);
  RegisterClassWrapper(EPropertyError_sw);
  RegisterClassWrapper(EPropertyConvertError_sw);

end.
