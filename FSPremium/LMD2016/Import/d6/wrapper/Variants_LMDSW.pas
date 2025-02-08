unit Variants_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'Variants' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  SysUtils, Classes, Variants, TypInfo, LMDTypes, LMDSctClass, LMDSctScripter,
  LMDSctWrappers, LMDSctSysWrappers, Types, Types_LMDSW;


{ Type wrappers }

type
  TCustomVariantType_sw = class;
  TCustomVariantTypeClass_sw = class;
  TInvokeableVariantType_sw = class;

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

{ Variants_sw }

function Variants_VarType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarType(const V: Variant): TVarType;

  Result := TVarType_sw.ToVar(Variants.VarType(Variant(FindVarData(
    AArgs[0])^)));
end;

function Variants_VarAsType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarAsType(const V: Variant; AVarType: TVarType):...

  Result := Variants.VarAsType(Variant(FindVarData(AArgs[0])^), TVarType_sw.
    FromVar(AArgs[1]));
end;

function Variants_VarIsType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function VarIsType(...); overload;

  Result := Variants.VarIsType(Variant(FindVarData(AArgs[0])^), TVarType_sw.
    FromVar(AArgs[1]));
end;

function Variants_VarIsByRef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsByRef(const V: Variant): Boolean;

  Result := Variants.VarIsByRef(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsEmpty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsEmpty(const V: Variant): Boolean;

  Result := Variants.VarIsEmpty(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarCheckEmpty_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure VarCheckEmpty(const V: Variant);

  Variants.VarCheckEmpty(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsNull_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsNull(const V: Variant): Boolean;

  Result := Variants.VarIsNull(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsClear_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsClear(const V: Variant): Boolean;

  Result := Variants.VarIsClear(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsCustom_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsCustom(const V: Variant): Boolean;

  Result := Variants.VarIsCustom(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsOrdinal_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsOrdinal(const V: Variant): Boolean;

  Result := Variants.VarIsOrdinal(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsFloat_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsFloat(const V: Variant): Boolean;

  Result := Variants.VarIsFloat(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsNumeric_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsNumeric(const V: Variant): Boolean;

  Result := Variants.VarIsNumeric(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarIsStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsStr(const V: Variant): Boolean;

  Result := Variants.VarIsStr(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarToStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarToStr(const V: Variant): string;

  Result := Variants.VarToStr(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarToStrDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarToStrDef(const V: Variant; const ADefault: st...

  Result := Variants.VarToStrDef(Variant(FindVarData(AArgs[0])^), string(
    AArgs[1]));
end;

function Variants_VarToWideStr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarToWideStr(const V: Variant): WideString;

  Result := Variants.VarToWideStr(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarToWideStrDef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarToWideStrDef(const V: Variant; const ADefault...

  Result := Variants.VarToWideStrDef(Variant(FindVarData(AArgs[0])^), 
    WideString(AArgs[1]));
end;

function Variants_VarToDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarToDateTime(const V: Variant): TDateTime;

  Result := TDateTime_sw.ToVar(Variants.VarToDateTime(Variant(FindVarData(
    AArgs[0])^)));
end;

function Variants_VarFromDateTime_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarFromDateTime(const DateTime: TDateTime): Vari...

  Result := Variants.VarFromDateTime(TDateTime_sw.FromVar(AArgs[0]));
end;

function Variants_VarInRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarInRange(const AValue: Variant; const AMin: Va...

  Result := Variants.VarInRange(Variant(FindVarData(AArgs[0])^), Variant(
    FindVarData(AArgs[1])^), Variant(FindVarData(AArgs[2])^));
end;

function Variants_VarEnsureRange_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarEnsureRange(const AValue: Variant; const AMin...

  Result := Variants.VarEnsureRange(Variant(FindVarData(AArgs[0])^), Variant(
    FindVarData(AArgs[1])^), Variant(FindVarData(AArgs[2])^));
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

  Result := Variants.VarSameValue(Variant(FindVarData(AArgs[0])^), Variant(
    FindVarData(AArgs[1])^));
end;

function Variants_VarCompareValue_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarCompareValue(const A: Variant; const B: Varia...

  Result := TVariantRelationship_sw.ToVar(Variants.VarCompareValue(Variant(
    FindVarData(AArgs[0])^), Variant(FindVarData(AArgs[1])^)));
end;

function Variants_VarIsEmptyParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarIsEmptyParam(const V: Variant): Boolean;

  Result := Variants.VarIsEmptyParam(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarSupports_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function VarSupports(...); overload;

  Result := Variants.VarSupports(Variant(FindVarData(AArgs[0])^), TGUID_sw.
    FromVar(AArgs[1]));
end;

function Variants_VarCopyNoInd_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: Variant;
begin
  // procedure VarCopyNoInd(var Dest: Variant; const Source: V...

  v_1 := Variant(FindVarData(AArgs[0])^);
  Variants.VarCopyNoInd(v_1, Variant(FindVarData(AArgs[1])^));
  AssignRefParam(AArgs[0], v_1);
end;

function Variants_VarIsArray_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure/function VarIsArray(...); overload;

  case AArgsSize of
    1:
    begin
      Result := Variants.VarIsArray(Variant(FindVarData(AArgs[0])^));
    end;
    2:
    begin
      Result := Variants.VarIsArray(Variant(FindVarData(AArgs[0])^), Boolean(
        AArgs[1]));
    end;
  else
    WrongArgCountError('VarIsArray');
  end;
end;

function Variants_VarArrayRef_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarArrayRef(const A: Variant): Variant;

  Result := Variants.VarArrayRef(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarTypeIsValidArrayType_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarTypeIsValidArrayType(const AVarType: TVarType...

  Result := Variants.VarTypeIsValidArrayType(TVarType_sw.FromVar(AArgs[0]));
end;

function Variants_VarTypeIsValidElementType_si(var AObj;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarTypeIsValidElementType(const AVarType: TVarTy...

  Result := Variants.VarTypeIsValidElementType(TVarType_sw.FromVar(AArgs[0]));
end;

function Variants_VarArrayDimCount_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarArrayDimCount(const A: Variant): Integer;

  Result := Variants.VarArrayDimCount(Variant(FindVarData(AArgs[0])^));
end;

function Variants_VarArrayLowBound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarArrayLowBound(const A: Variant; Dim: Integer)...

  Result := Variants.VarArrayLowBound(Variant(FindVarData(AArgs[0])^), Integer(
    AArgs[1]));
end;

function Variants_VarArrayHighBound_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function VarArrayHighBound(const A: Variant; Dim: Integer...

  Result := Variants.VarArrayHighBound(Variant(FindVarData(AArgs[0])^), Integer(
    AArgs[1]));
end;

function Variants_VarArrayUnlock_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure VarArrayUnlock(const A: Variant);

  Variants.VarArrayUnlock(Variant(FindVarData(AArgs[0])^));
end;

function Variants_Unassigned_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Unassigned: Variant;

  Result := Variants.Unassigned();
end;

function Variants_Null_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Null: Variant;

  Result := Variants.Null();
end;

function Variants_EmptyParam_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var EmptyParam: OleVariant;

  if IsGet then
    Result := Variants.EmptyParam
  else
    Variants.EmptyParam := OleVariant(FindVarData(AArgs[0])^);
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

  Result := Variants.FindCustomVariantType(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TCustomVariantType_sw.ToVar(v_1));
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
  AData.AddVariable('EmptyParam', Variants_EmptyParam_si, OleVariant_sw);
  AData.AddType(TVarCompareResult_sw, Variants_TVarCompareResult_si);
  AData.AddType(TCustomVariantType_sw, Variants_TCustomVariantType_si);
  AData.AddType(TCustomVariantTypeClass_sw, Variants_TCustomVariantTypeClass_si);
  AData.AddType(TInvokeableVariantType_sw, Variants_TInvokeableVariantType_si);
  AData.AddFunction('FindCustomVariantType', Variants_FindCustomVariantType_si, nil, 2, False);
end;

class function Variants_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(Variants_sw);
end;

initialization
  RegisterUnitWrapper(Variants_sw);
  RegisterClassWrapper(TCustomVariantType_sw);
  RegisterClassWrapper(TInvokeableVariantType_sw);

end.
