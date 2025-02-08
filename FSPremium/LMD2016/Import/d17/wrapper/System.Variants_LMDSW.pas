unit System.Variants_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'System.Variants' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  System.Classes, System.Variants, System.TypInfo, LMDTypes, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, System.Types, System.SysUtils,
  System.Types_LMDSW, System.SysUtils_LMDSW;


{ Type wrappers }

type
  TCustomVariantType_sw = class;
  TCustomVariantTypeClass_sw = class;
  TInvokeableVariantType_sw = class;
  EVariantInvalidOpError_sw = class;
  EVariantTypeCastError_sw = class;
  EVariantOverflowError_sw = class;
  EVariantInvalidArgError_sw = class;
  EVariantBadVarTypeError_sw = class;
  EVariantBadIndexError_sw = class;
  EVariantArrayLockedError_sw = class;
  EVariantNotAnArrayError_sw = class;
  EVariantArrayCreateError_sw = class;
  EVariantNotImplError_sw = class;
  EVariantOutOfMemoryError_sw = class;
  EVariantUnexpectedError_sw = class;
  EVariantDispatchError_sw = class;
  EVariantRangeCheckError_sw = class;
  EVariantInvalidNullOpError_sw = class;

  TVariantRelationship_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TVariantRelationship): OleVariant;
    class function FromVar(const AValue: OleVariant): TVariantRelationship;
  end;

  TVarCompareResult_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TVarCompareResult): OleVariant;
    class function FromVar(const AValue: OleVariant): TVarCompareResult;
  end;

  TCustomVariantType_sc = class of TCustomVariantType;
  TCustomVariantType_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TCustomVariantType): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomVariantType;
    class function ClassToVar(AClass: TCustomVariantType_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TCustomVariantType_sc;
  end;

  TCustomVariantTypeClass_sw = class(TLMDMetaclassWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetWrappedBaseClass: TClass; override;
  public
    class function ToVar(const AValue: TCustomVariantTypeClass): OleVariant;
    class function FromVar(const AValue: OleVariant): TCustomVariantTypeClass;
  end;

  TInvokeableVariantType_sc = class of TInvokeableVariantType;
  TInvokeableVariantType_sw = class(TCustomVariantType_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TInvokeableVariantType): OleVariant;
    class function FromVar(const AValue: OleVariant): TInvokeableVariantType;
    class function ClassToVar(AClass: TInvokeableVariantType_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TInvokeableVariantType_sc;
  end;

  EVariantInvalidOpError_sc = class of EVariantInvalidOpError;
  EVariantInvalidOpError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantInvalidOpError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantInvalidOpError;
    class function ClassToVar(AClass: EVariantInvalidOpError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantInvalidOpError_sc;
  end;

  EVariantTypeCastError_sc = class of EVariantTypeCastError;
  EVariantTypeCastError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantTypeCastError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantTypeCastError;
    class function ClassToVar(AClass: EVariantTypeCastError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantTypeCastError_sc;
  end;

  EVariantOverflowError_sc = class of EVariantOverflowError;
  EVariantOverflowError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantOverflowError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantOverflowError;
    class function ClassToVar(AClass: EVariantOverflowError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantOverflowError_sc;
  end;

  EVariantInvalidArgError_sc = class of EVariantInvalidArgError;
  EVariantInvalidArgError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantInvalidArgError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantInvalidArgError;
    class function ClassToVar(AClass: EVariantInvalidArgError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantInvalidArgError_sc;
  end;

  EVariantBadVarTypeError_sc = class of EVariantBadVarTypeError;
  EVariantBadVarTypeError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantBadVarTypeError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantBadVarTypeError;
    class function ClassToVar(AClass: EVariantBadVarTypeError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantBadVarTypeError_sc;
  end;

  EVariantBadIndexError_sc = class of EVariantBadIndexError;
  EVariantBadIndexError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantBadIndexError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantBadIndexError;
    class function ClassToVar(AClass: EVariantBadIndexError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantBadIndexError_sc;
  end;

  EVariantArrayLockedError_sc = class of EVariantArrayLockedError;
  EVariantArrayLockedError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantArrayLockedError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantArrayLockedError;
    class function ClassToVar(AClass: EVariantArrayLockedError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantArrayLockedError_sc;
  end;

  EVariantNotAnArrayError_sc = class of EVariantNotAnArrayError;
  EVariantNotAnArrayError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantNotAnArrayError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantNotAnArrayError;
    class function ClassToVar(AClass: EVariantNotAnArrayError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantNotAnArrayError_sc;
  end;

  EVariantArrayCreateError_sc = class of EVariantArrayCreateError;
  EVariantArrayCreateError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantArrayCreateError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantArrayCreateError;
    class function ClassToVar(AClass: EVariantArrayCreateError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantArrayCreateError_sc;
  end;

  EVariantNotImplError_sc = class of EVariantNotImplError;
  EVariantNotImplError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantNotImplError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantNotImplError;
    class function ClassToVar(AClass: EVariantNotImplError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantNotImplError_sc;
  end;

  EVariantOutOfMemoryError_sc = class of EVariantOutOfMemoryError;
  EVariantOutOfMemoryError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantOutOfMemoryError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantOutOfMemoryError;
    class function ClassToVar(AClass: EVariantOutOfMemoryError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantOutOfMemoryError_sc;
  end;

  EVariantUnexpectedError_sc = class of EVariantUnexpectedError;
  EVariantUnexpectedError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantUnexpectedError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantUnexpectedError;
    class function ClassToVar(AClass: EVariantUnexpectedError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantUnexpectedError_sc;
  end;

  EVariantDispatchError_sc = class of EVariantDispatchError;
  EVariantDispatchError_sw = class(EVariantError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantDispatchError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantDispatchError;
    class function ClassToVar(AClass: EVariantDispatchError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantDispatchError_sc;
  end;

  EVariantRangeCheckError_sc = class of EVariantRangeCheckError;
  EVariantRangeCheckError_sw = class(EVariantOverflowError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantRangeCheckError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantRangeCheckError;
    class function ClassToVar(AClass: EVariantRangeCheckError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantRangeCheckError_sc;
  end;

  EVariantInvalidNullOpError_sc = class of EVariantInvalidNullOpError;
  EVariantInvalidNullOpError_sw = class(EVariantInvalidOpError_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: EVariantInvalidNullOpError): OleVariant;
    class function FromVar(const AValue: OleVariant): EVariantInvalidNullOpError;
    class function ClassToVar(AClass: EVariantInvalidNullOpError_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): EVariantInvalidNullOpError_sc;
  end;

  TNullCompareRule_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TNullCompareRule): OleVariant;
    class function FromVar(const AValue: OleVariant): TNullCompareRule;
  end;

  TBooleanToStringRule_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TBooleanToStringRule): OleVariant;
    class function FromVar(const AValue: OleVariant): TBooleanToStringRule;
  end;

  TStringRef_sw = class(TLMDRecordWrapper)
  private
    FValue: TStringRef;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TStringRef): OleVariant;
    class function FromVar(const AValue: OleVariant): TStringRef;
  end;


{ Unit wrapper }

type
  Variants_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TVariantRelationship_sw }

class function TVariantRelationship_sw.GetTypeName: WideString;
begin
  Result := 'TVariantRelationship';
end;

class procedure TVariantRelationship_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'vrEqual'; Value: Integer({$IFDEF LMDSCT_12}TVariantRelationship.{$ENDIF}vrEqual)),
    (Name: 'vrLessThan'; Value: Integer({$IFDEF LMDSCT_12}TVariantRelationship.{$ENDIF}vrLessThan)),
    (Name: 'vrGreaterThan'; Value: Integer({$IFDEF LMDSCT_12}TVariantRelationship.{$ENDIF}vrGreaterThan)),
    (Name: 'vrNotEqual'; Value: Integer({$IFDEF LMDSCT_12}TVariantRelationship.{$ENDIF}vrNotEqual))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TVariantRelationship_sw.ToVar(
  const AValue: TVariantRelationship): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TVariantRelationship_sw.FromVar(
  const AValue: OleVariant): TVariantRelationship;
begin
  Result := TVariantRelationship(Integer(AValue));
end;

{ TVarCompareResult_sw }

class function TVarCompareResult_sw.GetTypeName: WideString;
begin
  Result := 'TVarCompareResult';
end;

class procedure TVarCompareResult_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'crLessThan'; Value: Integer({$IFDEF LMDSCT_12}TVarCompareResult.{$ENDIF}crLessThan)),
    (Name: 'crEqual'; Value: Integer({$IFDEF LMDSCT_12}TVarCompareResult.{$ENDIF}crEqual)),
    (Name: 'crGreaterThan'; Value: Integer({$IFDEF LMDSCT_12}TVarCompareResult.{$ENDIF}crGreaterThan))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TVarCompareResult_sw.ToVar(
  const AValue: TVarCompareResult): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TVarCompareResult_sw.FromVar(
  const AValue: OleVariant): TVarCompareResult;
begin
  Result := TVarCompareResult(Integer(AValue));
end;

{ TCustomVariantType_sw }

function TCustomVariantType_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function Create(...); overload;

  case AArgsSize of
    0:
    begin
      Result := TCustomVariantType_sw.ToVar(TCustomVariantType_sc(AObj).Create(
        ));
    end;
    1:
    begin
      Result := TCustomVariantType_sw.ToVar(TCustomVariantType_sc(AObj).Create(
        TVarType_sw.FromVar(AArgs[0])));
    end;
  else
    WrongArgCountError('Create');
  end;
end;

function TCustomVariantType_VarType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property VarType: TVarType read <getter>;

  Result := TVarType_sw.ToVar(TCustomVariantType(AObj).VarType);
end;

function TCustomVariantType_IsClear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function IsClear(const V: TVarData): Boolean;

  Result := TCustomVariantType(AObj).IsClear(TVarData_sw.FromVar(AArgs[0]));
end;

function TCustomVariantType_Cast_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TVarData;
begin
  // procedure Cast(var Dest: TVarData; const Source: TVarData);

  v_1 := TVarData_sw.FromVar(AArgs[0]);
  TCustomVariantType(AObj).Cast(v_1, TVarData_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], TVarData_sw.ToVar(v_1));
end;

function TCustomVariantType_CastTo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TVarData;
begin
  // procedure CastTo(var Dest: TVarData; const Source: TVarDa...

  v_1 := TVarData_sw.FromVar(AArgs[0]);
  TCustomVariantType(AObj).CastTo(v_1, TVarData_sw.FromVar(AArgs[1]), 
    TVarType_sw.FromVar(AArgs[2]));
  AssignRefParam(AArgs[0], TVarData_sw.ToVar(v_1));
end;

function TCustomVariantType_CastToOle_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TVarData;
begin
  // procedure CastToOle(var Dest: TVarData; const Source: TVa...

  v_1 := TVarData_sw.FromVar(AArgs[0]);
  TCustomVariantType(AObj).CastToOle(v_1, TVarData_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], TVarData_sw.ToVar(v_1));
end;

function TCustomVariantType_Clear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TVarData;
begin
  // procedure Clear(var V: TVarData);

  v_1 := TVarData_sw.FromVar(AArgs[0]);
  TCustomVariantType(AObj).Clear(v_1);
  AssignRefParam(AArgs[0], TVarData_sw.ToVar(v_1));
end;

function TCustomVariantType_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TVarData;
begin
  // procedure Copy(var Dest: TVarData; const Source: TVarData...

  v_1 := TVarData_sw.FromVar(AArgs[0]);
  TCustomVariantType(AObj).Copy(v_1, TVarData_sw.FromVar(AArgs[1]), Boolean(
    AArgs[2]));
  AssignRefParam(AArgs[0], TVarData_sw.ToVar(v_1));
end;

function TCustomVariantType_BinaryOp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TVarData;
begin
  // procedure BinaryOp(var Left: TVarData; const Right: TVarD...

  v_1 := TVarData_sw.FromVar(AArgs[0]);
  TCustomVariantType(AObj).BinaryOp(v_1, TVarData_sw.FromVar(AArgs[1]), 
    TVarOp_sw.FromVar(AArgs[2]));
  AssignRefParam(AArgs[0], TVarData_sw.ToVar(v_1));
end;

function TCustomVariantType_UnaryOp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TVarData;
begin
  // procedure UnaryOp(var Right: TVarData; const Operator: TV...

  v_1 := TVarData_sw.FromVar(AArgs[0]);
  TCustomVariantType(AObj).UnaryOp(v_1, TVarOp_sw.FromVar(AArgs[1]));
  AssignRefParam(AArgs[0], TVarData_sw.ToVar(v_1));
end;

function TCustomVariantType_CompareOp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function CompareOp(const Left: TVarData; const Right: TVa...

  Result := TCustomVariantType(AObj).CompareOp(TVarData_sw.FromVar(AArgs[0]), 
    TVarData_sw.FromVar(AArgs[1]), TVarOp_sw.FromVar(AArgs[2]));
end;

function TCustomVariantType_Compare_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TVarCompareResult;
begin
  // procedure Compare(const Left: TVarData; const Right: TVar...

  v_1 := TVarCompareResult_sw.FromVar(AArgs[2]);
  TCustomVariantType(AObj).Compare(TVarData_sw.FromVar(AArgs[0]), TVarData_sw.
    FromVar(AArgs[1]), v_1);
  AssignRefParam(AArgs[2], TVarCompareResult_sw.ToVar(v_1));
end;

class function TCustomVariantType_sw.GetTypeName: WideString;
begin
  Result := 'TCustomVariantType';
end;

class function TCustomVariantType_sw.GetWrappedClass: TClass;
begin
  Result := TCustomVariantType;
end;

class procedure TCustomVariantType_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('VarType', TCustomVariantType_VarType_si, TVarType_sw, True, False, 0, False, False);
  AData.AddFunction('IsClear', TCustomVariantType_IsClear_si, Boolean_sw, 1, False);
  AData.AddProcedure('Cast', TCustomVariantType_Cast_si, 2, False);
  AData.AddProcedure('CastTo', TCustomVariantType_CastTo_si, 3, False);
  AData.AddProcedure('CastToOle', TCustomVariantType_CastToOle_si, 2, False);
  AData.AddProcedure('Clear', TCustomVariantType_Clear_si, 1, False);
  AData.AddProcedure('Copy', TCustomVariantType_Copy_si, 3, False);
  AData.AddProcedure('BinaryOp', TCustomVariantType_BinaryOp_si, 3, False);
  AData.AddProcedure('UnaryOp', TCustomVariantType_UnaryOp_si, 2, False);
  AData.AddFunction('CompareOp', TCustomVariantType_CompareOp_si, Boolean_sw, 3, False);
  AData.AddProcedure('Compare', TCustomVariantType_Compare_si, 3, False);

  { Class members }

  AData.AddConstructor('Create', TCustomVariantType_Create_si, 0, True);
end;

class function TCustomVariantType_sw.ToVar(
  const AValue: TCustomVariantType): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomVariantType_sw.FromVar(
  const AValue: OleVariant): TCustomVariantType;
begin
  Result := TCustomVariantType(ConvFromVar(AValue, TCustomVariantType));
end;

class function TCustomVariantType_sw.ClassToVar(
  AClass: TCustomVariantType_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TCustomVariantType_sw.ClassFromVar(
  const AClass: OleVariant): TCustomVariantType_sc;
begin
  Result := TCustomVariantType_sc(ConvClsFromVar(AClass, TCustomVariantType));
end;

{ TCustomVariantTypeClass_sw }

class function TCustomVariantTypeClass_sw.GetTypeName: WideString;
begin
  Result := 'TCustomVariantTypeClass';
end;

class function TCustomVariantTypeClass_sw.GetWrappedBaseClass: TClass;
begin
  Result := TCustomVariantType;
end;

class function TCustomVariantTypeClass_sw.ToVar(
  const AValue: TCustomVariantTypeClass): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TCustomVariantTypeClass_sw.FromVar(
  const AValue: OleVariant): TCustomVariantTypeClass;
begin
  Result := TCustomVariantTypeClass(ConvFromVar(AValue, TCustomVariantType));
end;

{ TInvokeableVariantType_sw }

function TInvokeableVariantType_GetProperty_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TVarData;
begin
  // function GetProperty(var Dest: TVarData; const V: TVarDat...

  v_1 := TVarData_sw.FromVar(AArgs[0]);
  Result := TInvokeableVariantType(AObj).GetProperty(v_1, TVarData_sw.FromVar(
    AArgs[1]), string(AArgs[2]));
  AssignRefParam(AArgs[0], TVarData_sw.ToVar(v_1));
end;

function TInvokeableVariantType_SetProperty_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function SetProperty(const V: TVarData; const Name: strin...

  Result := TInvokeableVariantType(AObj).SetProperty(TVarData_sw.FromVar(
    AArgs[0]), string(AArgs[1]), TVarData_sw.FromVar(AArgs[2]));
end;

class function TInvokeableVariantType_sw.GetTypeName: WideString;
begin
  Result := 'TInvokeableVariantType';
end;

class function TInvokeableVariantType_sw.GetWrappedClass: TClass;
begin
  Result := TInvokeableVariantType;
end;

class procedure TInvokeableVariantType_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddFunction('GetProperty', TInvokeableVariantType_GetProperty_si, Boolean_sw, 3, False);
  AData.AddFunction('SetProperty', TInvokeableVariantType_SetProperty_si, Boolean_sw, 3, False);
end;

class function TInvokeableVariantType_sw.ToVar(
  const AValue: TInvokeableVariantType): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TInvokeableVariantType_sw.FromVar(
  const AValue: OleVariant): TInvokeableVariantType;
begin
  Result := TInvokeableVariantType(ConvFromVar(AValue, TInvokeableVariantType));
end;

class function TInvokeableVariantType_sw.ClassToVar(
  AClass: TInvokeableVariantType_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TInvokeableVariantType_sw.ClassFromVar(
  const AClass: OleVariant): TInvokeableVariantType_sc;
begin
  Result := TInvokeableVariantType_sc(ConvClsFromVar(AClass, 
    TInvokeableVariantType));
end;

{ EVariantInvalidOpError_sw }

class function EVariantInvalidOpError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantInvalidOpError';
end;

class function EVariantInvalidOpError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantInvalidOpError;
end;

class procedure EVariantInvalidOpError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantInvalidOpError_sw.ToVar(
  const AValue: EVariantInvalidOpError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantInvalidOpError_sw.FromVar(
  const AValue: OleVariant): EVariantInvalidOpError;
begin
  Result := EVariantInvalidOpError(ConvFromVar(AValue, EVariantInvalidOpError));
end;

class function EVariantInvalidOpError_sw.ClassToVar(
  AClass: EVariantInvalidOpError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantInvalidOpError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantInvalidOpError_sc;
begin
  Result := EVariantInvalidOpError_sc(ConvClsFromVar(AClass, 
    EVariantInvalidOpError));
end;

{ EVariantTypeCastError_sw }

class function EVariantTypeCastError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantTypeCastError';
end;

class function EVariantTypeCastError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantTypeCastError;
end;

class procedure EVariantTypeCastError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantTypeCastError_sw.ToVar(
  const AValue: EVariantTypeCastError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantTypeCastError_sw.FromVar(
  const AValue: OleVariant): EVariantTypeCastError;
begin
  Result := EVariantTypeCastError(ConvFromVar(AValue, EVariantTypeCastError));
end;

class function EVariantTypeCastError_sw.ClassToVar(
  AClass: EVariantTypeCastError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantTypeCastError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantTypeCastError_sc;
begin
  Result := EVariantTypeCastError_sc(ConvClsFromVar(AClass, 
    EVariantTypeCastError));
end;

{ EVariantOverflowError_sw }

class function EVariantOverflowError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantOverflowError';
end;

class function EVariantOverflowError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantOverflowError;
end;

class procedure EVariantOverflowError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantOverflowError_sw.ToVar(
  const AValue: EVariantOverflowError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantOverflowError_sw.FromVar(
  const AValue: OleVariant): EVariantOverflowError;
begin
  Result := EVariantOverflowError(ConvFromVar(AValue, EVariantOverflowError));
end;

class function EVariantOverflowError_sw.ClassToVar(
  AClass: EVariantOverflowError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantOverflowError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantOverflowError_sc;
begin
  Result := EVariantOverflowError_sc(ConvClsFromVar(AClass, 
    EVariantOverflowError));
end;

{ EVariantInvalidArgError_sw }

class function EVariantInvalidArgError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantInvalidArgError';
end;

class function EVariantInvalidArgError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantInvalidArgError;
end;

class procedure EVariantInvalidArgError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantInvalidArgError_sw.ToVar(
  const AValue: EVariantInvalidArgError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantInvalidArgError_sw.FromVar(
  const AValue: OleVariant): EVariantInvalidArgError;
begin
  Result := EVariantInvalidArgError(ConvFromVar(AValue, 
    EVariantInvalidArgError));
end;

class function EVariantInvalidArgError_sw.ClassToVar(
  AClass: EVariantInvalidArgError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantInvalidArgError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantInvalidArgError_sc;
begin
  Result := EVariantInvalidArgError_sc(ConvClsFromVar(AClass, 
    EVariantInvalidArgError));
end;

{ EVariantBadVarTypeError_sw }

class function EVariantBadVarTypeError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantBadVarTypeError';
end;

class function EVariantBadVarTypeError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantBadVarTypeError;
end;

class procedure EVariantBadVarTypeError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantBadVarTypeError_sw.ToVar(
  const AValue: EVariantBadVarTypeError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantBadVarTypeError_sw.FromVar(
  const AValue: OleVariant): EVariantBadVarTypeError;
begin
  Result := EVariantBadVarTypeError(ConvFromVar(AValue, 
    EVariantBadVarTypeError));
end;

class function EVariantBadVarTypeError_sw.ClassToVar(
  AClass: EVariantBadVarTypeError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantBadVarTypeError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantBadVarTypeError_sc;
begin
  Result := EVariantBadVarTypeError_sc(ConvClsFromVar(AClass, 
    EVariantBadVarTypeError));
end;

{ EVariantBadIndexError_sw }

class function EVariantBadIndexError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantBadIndexError';
end;

class function EVariantBadIndexError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantBadIndexError;
end;

class procedure EVariantBadIndexError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantBadIndexError_sw.ToVar(
  const AValue: EVariantBadIndexError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantBadIndexError_sw.FromVar(
  const AValue: OleVariant): EVariantBadIndexError;
begin
  Result := EVariantBadIndexError(ConvFromVar(AValue, EVariantBadIndexError));
end;

class function EVariantBadIndexError_sw.ClassToVar(
  AClass: EVariantBadIndexError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantBadIndexError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantBadIndexError_sc;
begin
  Result := EVariantBadIndexError_sc(ConvClsFromVar(AClass, 
    EVariantBadIndexError));
end;

{ EVariantArrayLockedError_sw }

class function EVariantArrayLockedError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantArrayLockedError';
end;

class function EVariantArrayLockedError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantArrayLockedError;
end;

class procedure EVariantArrayLockedError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantArrayLockedError_sw.ToVar(
  const AValue: EVariantArrayLockedError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantArrayLockedError_sw.FromVar(
  const AValue: OleVariant): EVariantArrayLockedError;
begin
  Result := EVariantArrayLockedError(ConvFromVar(AValue, 
    EVariantArrayLockedError));
end;

class function EVariantArrayLockedError_sw.ClassToVar(
  AClass: EVariantArrayLockedError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantArrayLockedError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantArrayLockedError_sc;
begin
  Result := EVariantArrayLockedError_sc(ConvClsFromVar(AClass, 
    EVariantArrayLockedError));
end;

{ EVariantNotAnArrayError_sw }

class function EVariantNotAnArrayError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantNotAnArrayError';
end;

class function EVariantNotAnArrayError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantNotAnArrayError;
end;

class procedure EVariantNotAnArrayError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantNotAnArrayError_sw.ToVar(
  const AValue: EVariantNotAnArrayError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantNotAnArrayError_sw.FromVar(
  const AValue: OleVariant): EVariantNotAnArrayError;
begin
  Result := EVariantNotAnArrayError(ConvFromVar(AValue, 
    EVariantNotAnArrayError));
end;

class function EVariantNotAnArrayError_sw.ClassToVar(
  AClass: EVariantNotAnArrayError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantNotAnArrayError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantNotAnArrayError_sc;
begin
  Result := EVariantNotAnArrayError_sc(ConvClsFromVar(AClass, 
    EVariantNotAnArrayError));
end;

{ EVariantArrayCreateError_sw }

class function EVariantArrayCreateError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantArrayCreateError';
end;

class function EVariantArrayCreateError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantArrayCreateError;
end;

class procedure EVariantArrayCreateError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantArrayCreateError_sw.ToVar(
  const AValue: EVariantArrayCreateError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantArrayCreateError_sw.FromVar(
  const AValue: OleVariant): EVariantArrayCreateError;
begin
  Result := EVariantArrayCreateError(ConvFromVar(AValue, 
    EVariantArrayCreateError));
end;

class function EVariantArrayCreateError_sw.ClassToVar(
  AClass: EVariantArrayCreateError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantArrayCreateError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantArrayCreateError_sc;
begin
  Result := EVariantArrayCreateError_sc(ConvClsFromVar(AClass, 
    EVariantArrayCreateError));
end;

{ EVariantNotImplError_sw }

class function EVariantNotImplError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantNotImplError';
end;

class function EVariantNotImplError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantNotImplError;
end;

class procedure EVariantNotImplError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantNotImplError_sw.ToVar(
  const AValue: EVariantNotImplError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantNotImplError_sw.FromVar(
  const AValue: OleVariant): EVariantNotImplError;
begin
  Result := EVariantNotImplError(ConvFromVar(AValue, EVariantNotImplError));
end;

class function EVariantNotImplError_sw.ClassToVar(
  AClass: EVariantNotImplError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantNotImplError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantNotImplError_sc;
begin
  Result := EVariantNotImplError_sc(ConvClsFromVar(AClass, 
    EVariantNotImplError));
end;

{ EVariantOutOfMemoryError_sw }

class function EVariantOutOfMemoryError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantOutOfMemoryError';
end;

class function EVariantOutOfMemoryError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantOutOfMemoryError;
end;

class procedure EVariantOutOfMemoryError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantOutOfMemoryError_sw.ToVar(
  const AValue: EVariantOutOfMemoryError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantOutOfMemoryError_sw.FromVar(
  const AValue: OleVariant): EVariantOutOfMemoryError;
begin
  Result := EVariantOutOfMemoryError(ConvFromVar(AValue, 
    EVariantOutOfMemoryError));
end;

class function EVariantOutOfMemoryError_sw.ClassToVar(
  AClass: EVariantOutOfMemoryError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantOutOfMemoryError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantOutOfMemoryError_sc;
begin
  Result := EVariantOutOfMemoryError_sc(ConvClsFromVar(AClass, 
    EVariantOutOfMemoryError));
end;

{ EVariantUnexpectedError_sw }

class function EVariantUnexpectedError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantUnexpectedError';
end;

class function EVariantUnexpectedError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantUnexpectedError;
end;

class procedure EVariantUnexpectedError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantUnexpectedError_sw.ToVar(
  const AValue: EVariantUnexpectedError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantUnexpectedError_sw.FromVar(
  const AValue: OleVariant): EVariantUnexpectedError;
begin
  Result := EVariantUnexpectedError(ConvFromVar(AValue, 
    EVariantUnexpectedError));
end;

class function EVariantUnexpectedError_sw.ClassToVar(
  AClass: EVariantUnexpectedError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantUnexpectedError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantUnexpectedError_sc;
begin
  Result := EVariantUnexpectedError_sc(ConvClsFromVar(AClass, 
    EVariantUnexpectedError));
end;

{ EVariantDispatchError_sw }

class function EVariantDispatchError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantDispatchError';
end;

class function EVariantDispatchError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantDispatchError;
end;

class procedure EVariantDispatchError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantDispatchError_sw.ToVar(
  const AValue: EVariantDispatchError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantDispatchError_sw.FromVar(
  const AValue: OleVariant): EVariantDispatchError;
begin
  Result := EVariantDispatchError(ConvFromVar(AValue, EVariantDispatchError));
end;

class function EVariantDispatchError_sw.ClassToVar(
  AClass: EVariantDispatchError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantDispatchError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantDispatchError_sc;
begin
  Result := EVariantDispatchError_sc(ConvClsFromVar(AClass, 
    EVariantDispatchError));
end;

{ EVariantRangeCheckError_sw }

class function EVariantRangeCheckError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantRangeCheckError';
end;

class function EVariantRangeCheckError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantRangeCheckError;
end;

class procedure EVariantRangeCheckError_sw.DoInit(AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantRangeCheckError_sw.ToVar(
  const AValue: EVariantRangeCheckError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantRangeCheckError_sw.FromVar(
  const AValue: OleVariant): EVariantRangeCheckError;
begin
  Result := EVariantRangeCheckError(ConvFromVar(AValue, 
    EVariantRangeCheckError));
end;

class function EVariantRangeCheckError_sw.ClassToVar(
  AClass: EVariantRangeCheckError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantRangeCheckError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantRangeCheckError_sc;
begin
  Result := EVariantRangeCheckError_sc(ConvClsFromVar(AClass, 
    EVariantRangeCheckError));
end;

{ EVariantInvalidNullOpError_sw }

class function EVariantInvalidNullOpError_sw.GetTypeName: WideString;
begin
  Result := 'EVariantInvalidNullOpError';
end;

class function EVariantInvalidNullOpError_sw.GetWrappedClass: TClass;
begin
  Result := EVariantInvalidNullOpError;
end;

class procedure EVariantInvalidNullOpError_sw.DoInit(
  AData: TLMDClassWrapperData);
begin
  // Do not call inherited.
end;

class function EVariantInvalidNullOpError_sw.ToVar(
  const AValue: EVariantInvalidNullOpError): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function EVariantInvalidNullOpError_sw.FromVar(
  const AValue: OleVariant): EVariantInvalidNullOpError;
begin
  Result := EVariantInvalidNullOpError(ConvFromVar(AValue, 
    EVariantInvalidNullOpError));
end;

class function EVariantInvalidNullOpError_sw.ClassToVar(
  AClass: EVariantInvalidNullOpError_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function EVariantInvalidNullOpError_sw.ClassFromVar(
  const AClass: OleVariant): EVariantInvalidNullOpError_sc;
begin
  Result := EVariantInvalidNullOpError_sc(ConvClsFromVar(AClass, 
    EVariantInvalidNullOpError));
end;

{ TNullCompareRule_sw }

class function TNullCompareRule_sw.GetTypeName: WideString;
begin
  Result := 'TNullCompareRule';
end;

class procedure TNullCompareRule_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'ncrError'; Value: Integer({$IFDEF LMDSCT_12}TNullCompareRule.{$ENDIF}ncrError)),
    (Name: 'ncrStrict'; Value: Integer({$IFDEF LMDSCT_12}TNullCompareRule.{$ENDIF}ncrStrict)),
    (Name: 'ncrLoose'; Value: Integer({$IFDEF LMDSCT_12}TNullCompareRule.{$ENDIF}ncrLoose))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TNullCompareRule_sw.ToVar(
  const AValue: TNullCompareRule): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TNullCompareRule_sw.FromVar(
  const AValue: OleVariant): TNullCompareRule;
begin
  Result := TNullCompareRule(Integer(AValue));
end;

{ TBooleanToStringRule_sw }

class function TBooleanToStringRule_sw.GetTypeName: WideString;
begin
  Result := 'TBooleanToStringRule';
end;

class procedure TBooleanToStringRule_sw.GetEnumerators(
  out AEnums: PLMDEnumerator; out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'bsrAsIs'; Value: Integer({$IFDEF LMDSCT_12}TBooleanToStringRule.{$ENDIF}bsrAsIs)),
    (Name: 'bsrLower'; Value: Integer({$IFDEF LMDSCT_12}TBooleanToStringRule.{$ENDIF}bsrLower)),
    (Name: 'bsrUpper'; Value: Integer({$IFDEF LMDSCT_12}TBooleanToStringRule.{$ENDIF}bsrUpper))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TBooleanToStringRule_sw.ToVar(
  const AValue: TBooleanToStringRule): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TBooleanToStringRule_sw.FromVar(
  const AValue: OleVariant): TBooleanToStringRule;
begin
  Result := TBooleanToStringRule(Integer(AValue));
end;

{ TStringRef_sw }

function TStringRef_Wide_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var Wide: WideString;

  if IsGet then
    Result := TStringRef_sw(AObj).FValue.Wide
  else
    TStringRef_sw(AObj).FValue.Wide := WideString(AArgs[0]);
end;

function TStringRef_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TStringRef_sw.Create as IDispatch;
end;

function TStringRef_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TStringRef;

  // Implicit record copy method.
  Result := TStringRef_sw.ToVar(TStringRef(AObj));
end;

class function TStringRef_sw.GetTypeName: WideString;
begin
  Result := 'TStringRef';
end;

function TStringRef_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TStringRef_sw.Create;
  TStringRef_sw(Result).FValue := FValue;
end;

class procedure TStringRef_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('Wide', TStringRef_Wide_si, WideString_sw);
  AData.AddFunction('Copy', TStringRef_Copy_si, TStringRef_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TStringRef_Create_si, 0, False);
end;

class function TStringRef_sw.ToVar(const AValue: TStringRef): OleVariant;
var
  wrpr: TStringRef_sw;
begin
  wrpr        := TStringRef_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TStringRef_sw.FromVar(const AValue: OleVariant): TStringRef;
begin
  Result := TStringRef_sw(ConvFromVar(AValue)).FValue;
end;

{ Variants_sw }

function Variants_VarType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarType(const V: Variant): TVarType;

  Result := TVarType_sw.ToVar(System.Variants.VarType(Variant(FindVarData(
    AArgs[0])^)));
end;

function Variants_VarAsType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarAsType(const V: Variant; AVarType: TVarType):...

  Result := System.Variants.VarAsType(Variant(FindVarData(AArgs[0])^), 
    TVarType_sw.FromVar(AArgs[1]));
end;

function Variants_VarIsType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function VarIsType(...); overload;

  Result := System.Variants.VarIsType(Variant(FindVarData(AArgs[0])^), 
    TVarType_sw.FromVar(AArgs[1]));
end;

function Variants_VarIsByRef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsByRef(const V: Variant): Boolean;

  Result := System.Variants.VarIsByRef(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsEmpty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsEmpty(const V: Variant): Boolean;

  Result := System.Variants.VarIsEmpty(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarCheckEmpty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure VarCheckEmpty(const V: Variant);

  System.Variants.VarCheckEmpty(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsNull_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsNull(const V: Variant): Boolean;

  Result := System.Variants.VarIsNull(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsClear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsClear(const V: Variant): Boolean;

  Result := System.Variants.VarIsClear(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsCustom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsCustom(const V: Variant): Boolean;

  Result := System.Variants.VarIsCustom(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsOrdinal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsOrdinal(const V: Variant): Boolean;

  Result := System.Variants.VarIsOrdinal(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsFloat(const V: Variant): Boolean;

  Result := System.Variants.VarIsFloat(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsNumeric_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsNumeric(const V: Variant): Boolean;

  Result := System.Variants.VarIsNumeric(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsStr(const V: Variant): Boolean;

  Result := System.Variants.VarIsStr(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarToStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarToStr(const V: Variant): string;

  Result := System.Variants.VarToStr(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarToStrDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarToStrDef(const V: Variant; const ADefault: st...

  Result := System.Variants.VarToStrDef(Variant(FindVarData(AArgs[0])^), string(
    AArgs[1]));
end;

function Variants_VarToWideStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarToWideStr(const V: Variant): WideString;

  Result := System.Variants.VarToWideStr(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarToWideStrDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarToWideStrDef(const V: Variant; const ADefault...

  Result := System.Variants.VarToWideStrDef(Variant(FindVarData(AArgs[0])^), 
    WideString(AArgs[1]));
end;

function Variants_VarToDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarToDateTime(const V: Variant): TDateTime;

  Result := TDateTime_sw.ToVar(System.Variants.VarToDateTime(Variant(
    FindVarData(AArgs[0])^)));
end;

function Variants_VarFromDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarFromDateTime(const DateTime: TDateTime): Vari...

  Result := System.Variants.VarFromDateTime(TDateTime_sw.FromVar(AArgs[0]));
end;

function Variants_VarInRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarInRange(const AValue: Variant; const AMin: Va...

  Result := System.Variants.VarInRange(Variant(FindVarData(AArgs[0])^), Variant(
    FindVarData(AArgs[1])^), Variant(FindVarData(AArgs[2])^));
end;

function Variants_VarEnsureRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarEnsureRange(const AValue: Variant; const AMin...

  Result := System.Variants.VarEnsureRange(Variant(FindVarData(AArgs[0])^), 
    Variant(FindVarData(AArgs[1])^), Variant(FindVarData(AArgs[2])^));
end;

function Variants_TVariantRelationship_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVariantRelationship = (vrEqual, vrLessThan, vrGreat...

  Result := TLMDUnitWrapper.TypeToVar(TVariantRelationship_sw);
end;

function Variants_VarSameValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarSameValue(const A: Variant; const B: Variant)...

  Result := System.Variants.VarSameValue(Variant(FindVarData(AArgs[0])^), 
    Variant(FindVarData(AArgs[1])^));
end;

function Variants_VarCompareValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarCompareValue(const A: Variant; const B: Varia...

  Result := TVariantRelationship_sw.ToVar(System.Variants.VarCompareValue(
    Variant(FindVarData(AArgs[0])^), Variant(FindVarData(AArgs[1])^)));
end;

function Variants_VarIsEmptyParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsEmptyParam(const V: Variant): Boolean;

  Result := System.Variants.VarIsEmptyParam(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: HRESULT;
begin
  // procedure/function VarIsError(...); overload;

  case AArgsSize of
    2:
    begin
      Result := System.Variants.VarIsError(Variant(FindVarData(AArgs[0])^), 
        v_1);
      AssignRefParam(AArgs[1], HRESULT_sw.ToVar(v_1));
    end;
    1:
    begin
      Result := System.Variants.VarIsError(Variant(FindVarData(AArgs[0])^));
    end;
  else
    WrongArgCountError('VarIsError');
  end;
end;

function Variants_VarAsError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarAsError(AResult: HRESULT): Variant;

  Result := System.Variants.VarAsError(HRESULT_sw.FromVar(AArgs[0]));
end;

function Variants_VarSupports_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function VarSupports(...); overload;

  Result := System.Variants.VarSupports(Variant(FindVarData(AArgs[0])^), 
    TGUID_sw.FromVar(AArgs[1]));
end;

function Variants_VarCopyNoInd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Variant;
begin
  // procedure VarCopyNoInd(var Dest: Variant; const Source: V...

  v_1 := Variant(FindVarData(AArgs[0])^);
  System.Variants.VarCopyNoInd(v_1, Variant(FindVarData(AArgs[1])^));
  AssignRefParam(AArgs[0], v_1);
end;

function Variants_VarIsArray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function VarIsArray(...); overload;

  case AArgsSize of
    1:
    begin
      Result := System.Variants.VarIsArray(Variant(FindVarData(AArgs[0])^));
    end;
    2:
    begin
      Result := System.Variants.VarIsArray(Variant(FindVarData(AArgs[0])^), 
        Boolean(AArgs[1]));
    end;
  else
    WrongArgCountError('VarIsArray');
  end;
end;

function Variants_VarArrayRef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarArrayRef(const A: Variant): Variant;

  Result := System.Variants.VarArrayRef(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarTypeIsValidArrayType_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarTypeIsValidArrayType(const AVarType: TVarType...

  Result := System.Variants.VarTypeIsValidArrayType(TVarType_sw.FromVar(
    AArgs[0]));
end;

function Variants_VarTypeIsValidElementType_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarTypeIsValidElementType(const AVarType: TVarTy...

  Result := System.Variants.VarTypeIsValidElementType(TVarType_sw.FromVar(
    AArgs[0]));
end;

function Variants_VarArrayDimCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarArrayDimCount(const A: Variant): Integer;

  Result := System.Variants.VarArrayDimCount(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarArrayLowBound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarArrayLowBound(const A: Variant; Dim: Integer)...

  Result := System.Variants.VarArrayLowBound(Variant(FindVarData(AArgs[0])^), 
    Integer(AArgs[1]));
end;

function Variants_VarArrayHighBound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarArrayHighBound(const A: Variant; Dim: Integer...

  Result := System.Variants.VarArrayHighBound(Variant(FindVarData(AArgs[0])^), 
    Integer(AArgs[1]));
end;

function Variants_VarArrayUnlock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure VarArrayUnlock(const A: Variant);

  System.Variants.VarArrayUnlock(Variant(FindVarData(AArgs[0])^));
end;

function Variants_Unassigned_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Unassigned: Variant;

  Result := System.Variants.Unassigned();
end;

function Variants_Null_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Null: Variant;

  Result := System.Variants.Null();
end;

function Variants_EmptyParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function EmptyParam: OleVariant;

  Result := System.Variants.EmptyParam();
end;

function Variants_TVarCompareResult_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TVarCompareResult = (crLessThan, crEqual, crGreaterT...

  Result := TLMDUnitWrapper.TypeToVar(TVarCompareResult_sw);
end;

function Variants_TCustomVariantType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomVariantType = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TCustomVariantType_sw);
end;

function Variants_TCustomVariantTypeClass_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCustomVariantTypeClass = class of TCustomVariantType;

  Result := TLMDUnitWrapper.TypeToVar(TCustomVariantTypeClass_sw);
end;

function Variants_TInvokeableVariantType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TInvokeableVariantType = class(TCustomVariantType);

  Result := TLMDUnitWrapper.TypeToVar(TInvokeableVariantType_sw);
end;

function Variants_FindCustomVariantType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TCustomVariantType;
begin
  // procedure/function FindCustomVariantType(...); overload;

  Result := System.Variants.FindCustomVariantType(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TCustomVariantType_sw.ToVar(v_1));
end;

function Variants_EVariantInvalidOpError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantInvalidOpError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantInvalidOpError_sw);
end;

function Variants_EVariantTypeCastError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantTypeCastError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantTypeCastError_sw);
end;

function Variants_EVariantOverflowError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantOverflowError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantOverflowError_sw);
end;

function Variants_EVariantInvalidArgError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantInvalidArgError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantInvalidArgError_sw);
end;

function Variants_EVariantBadVarTypeError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantBadVarTypeError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantBadVarTypeError_sw);
end;

function Variants_EVariantBadIndexError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantBadIndexError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantBadIndexError_sw);
end;

function Variants_EVariantArrayLockedError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantArrayLockedError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantArrayLockedError_sw);
end;

function Variants_EVariantNotAnArrayError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantNotAnArrayError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantNotAnArrayError_sw);
end;

function Variants_EVariantArrayCreateError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantArrayCreateError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantArrayCreateError_sw);
end;

function Variants_EVariantNotImplError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantNotImplError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantNotImplError_sw);
end;

function Variants_EVariantOutOfMemoryError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantOutOfMemoryError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantOutOfMemoryError_sw);
end;

function Variants_EVariantUnexpectedError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantUnexpectedError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantUnexpectedError_sw);
end;

function Variants_EVariantDispatchError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantDispatchError = class(EVariantError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantDispatchError_sw);
end;

function Variants_EVariantRangeCheckError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantRangeCheckError = class(EVariantOverflowError);

  Result := TLMDUnitWrapper.TypeToVar(EVariantRangeCheckError_sw);
end;

function Variants_EVariantInvalidNullOpError_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type EVariantInvalidNullOpError = class(EVariantInvalidOp...

  Result := TLMDUnitWrapper.TypeToVar(EVariantInvalidNullOpError_sw);
end;

function Variants_VarCastError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function VarCastError(...); overload;

  case AArgsSize of
    0:
    begin
      System.Variants.VarCastError();
    end;
    2:
    begin
      System.Variants.VarCastError(TVarType_sw.FromVar(AArgs[0]), TVarType_sw.
        FromVar(AArgs[1]));
    end;
  else
    WrongArgCountError('VarCastError');
  end;
end;

function Variants_VarInvalidOp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure VarInvalidOp;

  System.Variants.VarInvalidOp();
end;

function Variants_VarInvalidNullOp_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure VarInvalidNullOp;

  System.Variants.VarInvalidNullOp();
end;

function Variants_VarOverflowError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure VarOverflowError(const ASourceType: TVarType; c...

  System.Variants.VarOverflowError(TVarType_sw.FromVar(AArgs[0]), TVarType_sw.
    FromVar(AArgs[1]));
end;

function Variants_VarRangeCheckError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure VarRangeCheckError(const ASourceType: TVarType;...

  System.Variants.VarRangeCheckError(TVarType_sw.FromVar(AArgs[0]), TVarType_sw.
    FromVar(AArgs[1]));
end;

function Variants_VarArrayCreateError_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure VarArrayCreateError;

  System.Variants.VarArrayCreateError();
end;

function Variants_VarResultCheck_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function VarResultCheck(...); overload;

  case AArgsSize of
    1:
    begin
      System.Variants.VarResultCheck(HRESULT_sw.FromVar(AArgs[0]));
    end;
    3:
    begin
      System.Variants.VarResultCheck(HRESULT_sw.FromVar(AArgs[0]), TVarType_sw.
        FromVar(AArgs[1]), TVarType_sw.FromVar(AArgs[2]));
    end;
  else
    WrongArgCountError('VarResultCheck');
  end;
end;

function Variants_HandleConversionException_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure HandleConversionException(const ASourceType: TV...

  System.Variants.HandleConversionException(TVarType_sw.FromVar(AArgs[0]), 
    TVarType_sw.FromVar(AArgs[1]));
end;

function Variants_VarTypeAsText_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarTypeAsText(const AType: TVarType): string;

  Result := System.Variants.VarTypeAsText(TVarType_sw.FromVar(AArgs[0]));
end;

function Variants_TNullCompareRule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TNullCompareRule = (ncrError, ncrStrict, ncrLoose);

  Result := TLMDUnitWrapper.TypeToVar(TNullCompareRule_sw);
end;

function Variants_TBooleanToStringRule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TBooleanToStringRule = (bsrAsIs, bsrLower, bsrUpper);

  Result := TLMDUnitWrapper.TypeToVar(TBooleanToStringRule_sw);
end;

function Variants_NullEqualityRule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NullEqualityRule: TNullCompareRule;

  if IsGet then
    Result := TNullCompareRule_sw.ToVar(System.Variants.NullEqualityRule)
  else
    System.Variants.NullEqualityRule := TNullCompareRule_sw.FromVar(AArgs[0]);
end;

function Variants_NullMagnitudeRule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NullMagnitudeRule: TNullCompareRule;

  if IsGet then
    Result := TNullCompareRule_sw.ToVar(System.Variants.NullMagnitudeRule)
  else
    System.Variants.NullMagnitudeRule := TNullCompareRule_sw.FromVar(AArgs[0]);
end;

function Variants_NullStrictConvert_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NullStrictConvert: Boolean;

  if IsGet then
    Result := System.Variants.NullStrictConvert
  else
    System.Variants.NullStrictConvert := Boolean(AArgs[0]);
end;

function Variants_NullAsStringValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var NullAsStringValue: string;

  if IsGet then
    Result := System.Variants.NullAsStringValue
  else
    System.Variants.NullAsStringValue := string(AArgs[0]);
end;

function Variants_PackVarCreation_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var PackVarCreation: Boolean;

  if IsGet then
    Result := System.Variants.PackVarCreation
  else
    System.Variants.PackVarCreation := Boolean(AArgs[0]);
end;

function Variants_BooleanToStringRule_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var BooleanToStringRule: TBooleanToStringRule;

  if IsGet then
    Result := TBooleanToStringRule_sw.ToVar(System.Variants.BooleanToStringRule)
  else
    System.Variants.BooleanToStringRule := TBooleanToStringRule_sw.FromVar(
      AArgs[0]);
end;

function Variants_OleVariantInt64AsDouble_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OleVariantInt64AsDouble: Boolean;

  if IsGet then
    Result := System.Variants.OleVariantInt64AsDouble
  else
    System.Variants.OleVariantInt64AsDouble := Boolean(AArgs[0]);
end;

function Variants_MaxDispArgs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const MaxDispArgs = <value>;

  Result := MaxDispArgs;
end;

function Variants_TStringRef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TStringRef = record;

  Result := TLMDUnitWrapper.TypeToVar(TStringRef_sw);
end;

function Variants_DispatchUnsignedAsSigned_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DispatchUnsignedAsSigned: Boolean;

  if IsGet then
    Result := System.Variants.DispatchUnsignedAsSigned
  else
    System.Variants.DispatchUnsignedAsSigned := Boolean(AArgs[0]);
end;

class function Variants_sw.GetUnitName: WideString;
begin
  Result := 'Variants';
end;

class procedure Variants_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddFunction('VarType', Variants_VarType_si, TVarType_sw, 1, False);
  AData.AddFunction('VarAsType', Variants_VarAsType_si, Variant_sw, 2, False);
  AData.AddFunction('VarIsType', Variants_VarIsType_si, nil, 2, False);
  AData.AddFunction('VarIsByRef', Variants_VarIsByRef_si, Boolean_sw, 1, False);
  AData.AddFunction('VarIsEmpty', Variants_VarIsEmpty_si, Boolean_sw, 1, False);
  AData.AddProcedure('VarCheckEmpty', Variants_VarCheckEmpty_si, 1, False);
  AData.AddFunction('VarIsNull', Variants_VarIsNull_si, Boolean_sw, 1, False);
  AData.AddFunction('VarIsClear', Variants_VarIsClear_si, Boolean_sw, 1, False);
  AData.AddFunction('VarIsCustom', Variants_VarIsCustom_si, Boolean_sw, 1, False);
  AData.AddFunction('VarIsOrdinal', Variants_VarIsOrdinal_si, Boolean_sw, 1, False);
  AData.AddFunction('VarIsFloat', Variants_VarIsFloat_si, Boolean_sw, 1, False);
  AData.AddFunction('VarIsNumeric', Variants_VarIsNumeric_si, Boolean_sw, 1, False);
  AData.AddFunction('VarIsStr', Variants_VarIsStr_si, Boolean_sw, 1, False);
  AData.AddFunction('VarToStr', Variants_VarToStr_si, string_sw, 1, False);
  AData.AddFunction('VarToStrDef', Variants_VarToStrDef_si, string_sw, 2, False);
  AData.AddFunction('VarToWideStr', Variants_VarToWideStr_si, WideString_sw, 1, False);
  AData.AddFunction('VarToWideStrDef', Variants_VarToWideStrDef_si, WideString_sw, 2, False);
  AData.AddFunction('VarToDateTime', Variants_VarToDateTime_si, TDateTime_sw, 1, False);
  AData.AddFunction('VarFromDateTime', Variants_VarFromDateTime_si, Variant_sw, 1, False);
  AData.AddFunction('VarInRange', Variants_VarInRange_si, Boolean_sw, 3, False);
  AData.AddFunction('VarEnsureRange', Variants_VarEnsureRange_si, Variant_sw, 3, False);
  AData.AddType(TVariantRelationship_sw, Variants_TVariantRelationship_si);
  AData.AddFunction('VarSameValue', Variants_VarSameValue_si, Boolean_sw, 2, False);
  AData.AddFunction('VarCompareValue', Variants_VarCompareValue_si, TVariantRelationship_sw, 2, False);
  AData.AddFunction('VarIsEmptyParam', Variants_VarIsEmptyParam_si, Boolean_sw, 1, False);
  AData.AddFunction('VarIsError', Variants_VarIsError_si, nil, 1, True);
  AData.AddFunction('VarAsError', Variants_VarAsError_si, Variant_sw, 1, False);
  AData.AddFunction('VarSupports', Variants_VarSupports_si, nil, 2, False);
  AData.AddProcedure('VarCopyNoInd', Variants_VarCopyNoInd_si, 2, False);
  AData.AddFunction('VarIsArray', Variants_VarIsArray_si, nil, 1, True);
  AData.AddFunction('VarArrayRef', Variants_VarArrayRef_si, Variant_sw, 1, False);
  AData.AddFunction('VarTypeIsValidArrayType', Variants_VarTypeIsValidArrayType_si, Boolean_sw, 1, False);
  AData.AddFunction('VarTypeIsValidElementType', Variants_VarTypeIsValidElementType_si, Boolean_sw, 1, False);
  AData.AddFunction('VarArrayDimCount', Variants_VarArrayDimCount_si, Integer_sw, 1, False);
  AData.AddFunction('VarArrayLowBound', Variants_VarArrayLowBound_si, Integer_sw, 2, False);
  AData.AddFunction('VarArrayHighBound', Variants_VarArrayHighBound_si, Integer_sw, 2, False);
  AData.AddProcedure('VarArrayUnlock', Variants_VarArrayUnlock_si, 1, False);
  AData.AddFunction('Unassigned', Variants_Unassigned_si, Variant_sw, 0, False);
  AData.AddFunction('Null', Variants_Null_si, Variant_sw, 0, False);
  AData.AddFunction('EmptyParam', Variants_EmptyParam_si, OleVariant_sw, 0, False);
  AData.AddType(TVarCompareResult_sw, Variants_TVarCompareResult_si);
  AData.AddType(TCustomVariantType_sw, Variants_TCustomVariantType_si);
  AData.AddType(TCustomVariantTypeClass_sw, Variants_TCustomVariantTypeClass_si);
  AData.AddType(TInvokeableVariantType_sw, Variants_TInvokeableVariantType_si);
  AData.AddFunction('FindCustomVariantType', Variants_FindCustomVariantType_si, nil, 2, False);
  AData.AddType(EVariantInvalidOpError_sw, Variants_EVariantInvalidOpError_si);
  AData.AddType(EVariantTypeCastError_sw, Variants_EVariantTypeCastError_si);
  AData.AddType(EVariantOverflowError_sw, Variants_EVariantOverflowError_si);
  AData.AddType(EVariantInvalidArgError_sw, Variants_EVariantInvalidArgError_si);
  AData.AddType(EVariantBadVarTypeError_sw, Variants_EVariantBadVarTypeError_si);
  AData.AddType(EVariantBadIndexError_sw, Variants_EVariantBadIndexError_si);
  AData.AddType(EVariantArrayLockedError_sw, Variants_EVariantArrayLockedError_si);
  AData.AddType(EVariantNotAnArrayError_sw, Variants_EVariantNotAnArrayError_si);
  AData.AddType(EVariantArrayCreateError_sw, Variants_EVariantArrayCreateError_si);
  AData.AddType(EVariantNotImplError_sw, Variants_EVariantNotImplError_si);
  AData.AddType(EVariantOutOfMemoryError_sw, Variants_EVariantOutOfMemoryError_si);
  AData.AddType(EVariantUnexpectedError_sw, Variants_EVariantUnexpectedError_si);
  AData.AddType(EVariantDispatchError_sw, Variants_EVariantDispatchError_si);
  AData.AddType(EVariantRangeCheckError_sw, Variants_EVariantRangeCheckError_si);
  AData.AddType(EVariantInvalidNullOpError_sw, Variants_EVariantInvalidNullOpError_si);
  AData.AddProcedure('VarCastError', Variants_VarCastError_si, 0, True);
  AData.AddProcedure('VarInvalidOp', Variants_VarInvalidOp_si, 0, False);
  AData.AddProcedure('VarInvalidNullOp', Variants_VarInvalidNullOp_si, 0, False);
  AData.AddProcedure('VarOverflowError', Variants_VarOverflowError_si, 2, False);
  AData.AddProcedure('VarRangeCheckError', Variants_VarRangeCheckError_si, 2, False);
  AData.AddProcedure('VarArrayCreateError', Variants_VarArrayCreateError_si, 0, False);
  AData.AddProcedure('VarResultCheck', Variants_VarResultCheck_si, 1, True);
  AData.AddProcedure('HandleConversionException', Variants_HandleConversionException_si, 2, False);
  AData.AddFunction('VarTypeAsText', Variants_VarTypeAsText_si, string_sw, 1, False);
  AData.AddType(TNullCompareRule_sw, Variants_TNullCompareRule_si);
  AData.AddType(TBooleanToStringRule_sw, Variants_TBooleanToStringRule_si);
  AData.AddVariable('NullEqualityRule', Variants_NullEqualityRule_si, TNullCompareRule_sw);
  AData.AddVariable('NullMagnitudeRule', Variants_NullMagnitudeRule_si, TNullCompareRule_sw);
  AData.AddVariable('NullStrictConvert', Variants_NullStrictConvert_si, Boolean_sw);
  AData.AddVariable('NullAsStringValue', Variants_NullAsStringValue_si, string_sw);
  AData.AddVariable('PackVarCreation', Variants_PackVarCreation_si, Boolean_sw);
  AData.AddVariable('BooleanToStringRule', Variants_BooleanToStringRule_si, TBooleanToStringRule_sw);
  AData.AddVariable('OleVariantInt64AsDouble', Variants_OleVariantInt64AsDouble_si, Boolean_sw);
  AData.AddConstant('MaxDispArgs', Variants_MaxDispArgs_si, nil, VarType(System.Variants.MaxDispArgs));
  AData.AddType(TStringRef_sw, Variants_TStringRef_si);
  AData.AddVariable('DispatchUnsignedAsSigned', Variants_DispatchUnsignedAsSigned_si, Boolean_sw);
end;

class function Variants_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Variants_sw);
end;

initialization
  RegisterUnitWrapper(Variants_sw);
  RegisterClassWrapper(TCustomVariantType_sw);
  RegisterClassWrapper(TInvokeableVariantType_sw);
  RegisterClassWrapper(EVariantInvalidOpError_sw);
  RegisterClassWrapper(EVariantTypeCastError_sw);
  RegisterClassWrapper(EVariantOverflowError_sw);
  RegisterClassWrapper(EVariantInvalidArgError_sw);
  RegisterClassWrapper(EVariantBadVarTypeError_sw);
  RegisterClassWrapper(EVariantBadIndexError_sw);
  RegisterClassWrapper(EVariantArrayLockedError_sw);
  RegisterClassWrapper(EVariantNotAnArrayError_sw);
  RegisterClassWrapper(EVariantArrayCreateError_sw);
  RegisterClassWrapper(EVariantNotImplError_sw);
  RegisterClassWrapper(EVariantOutOfMemoryError_sw);
  RegisterClassWrapper(EVariantUnexpectedError_sw);
  RegisterClassWrapper(EVariantDispatchError_sw);
  RegisterClassWrapper(EVariantRangeCheckError_sw);
  RegisterClassWrapper(EVariantInvalidNullOpError_sw);

end.
