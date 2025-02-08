unit DBCommon_LMDSW;

{$WARNINGS OFF}
{$I LMDSctWrappers.inc}

{
  ##############################################################################
  #
  # LMD Script Pack wrappers for 'DBCommon' unit.
  #
  # WARNING:
  #  This file was generated automatically by LMD Script Pack Importer. If the
  #  unit will be reimported, the contents of this file will be regenerated
  #  and all manual modifications will be lost.
  ##############################################################################
}

interface

uses
  SysUtils, TypInfo, LMDTypes, LMDSctClass, LMDSctScripter, LMDSctWrappers,
  LMDSctSysWrappers, Windows, Variants, Classes, DB, DBCommon, Windows_LMDSW,
  Variants_LMDSW, Classes_LMDSW, DB_LMDSW;


{ Type wrappers }

type
  TFilterExpr_sw = class;
  TExprParser_sw = class;

  TCANOperator_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TCANOperator): OleVariant;
    class function FromVar(const AValue: OleVariant): TCANOperator;
  end;

  NODEClass_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: NODEClass): OleVariant;
    class function FromVar(const AValue: OleVariant): NODEClass;
  end;

  TParserOption_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TParserOption): OleVariant;
    class function FromVar(const AValue: OleVariant): TParserOption;
  end;

  TParserOptions_sw = class(TLMDSetWrapper)
  protected
    class function GetTypeName: WideString; override;
    class function GetSetSizeOf: Integer; override;
  public
    class function ToVar(const AValue: TParserOptions): OleVariant;
    class function FromVar(const AValue: OleVariant): TParserOptions;
  end;

  TExprNodeKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TExprNodeKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TExprNodeKind;
  end;

  TExprScopeKind_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TExprScopeKind): OleVariant;
    class function FromVar(const AValue: OleVariant): TExprScopeKind;
  end;

  TExprNode_sw = class(TLMDRecordWrapper)
  private
    FValue: TExprNode;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TExprNode): OleVariant;
    class function FromVar(const AValue: OleVariant): TExprNode;
  end;

  TFilterExpr_sc = class of TFilterExpr;
  TFilterExpr_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TFilterExpr): OleVariant;
    class function FromVar(const AValue: OleVariant): TFilterExpr;
    class function ClassToVar(AClass: TFilterExpr_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TFilterExpr_sc;
  end;

  TExprToken_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TExprToken): OleVariant;
    class function FromVar(const AValue: OleVariant): TExprToken;
  end;

  TExprParser_sc = class of TExprParser;
  TExprParser_sw = class(TObject_sw)
  protected
    class function  GetTypeName: WideString; override;
    class function  GetWrappedClass: TClass; override;
    class procedure DoInit(AData: TLMDClassWrapperData); override;
  public
    class function ToVar(const AValue: TExprParser): OleVariant;
    class function FromVar(const AValue: OleVariant): TExprParser;
    class function ClassToVar(AClass: TExprParser_sc): OleVariant;
    class function ClassFromVar(const AClass: OleVariant): TExprParser_sc;
  end;

  TFieldInfo_sw = class(TLMDRecordWrapper)
  private
    FValue: TFieldInfo;
  protected
    class function  GetTypeName: WideString; override;
    function        CloneVal: TLMDRecordWrapper; override;
    class procedure DoInit(AData: TLMDRecordWrapperData); override;
  public
    class function ToVar(const AValue: TFieldInfo): OleVariant;
    class function FromVar(const AValue: OleVariant): TFieldInfo;
  end;

  TSQLToken_sw = class(TLMDEnumWrapper)
  protected
    class function  GetTypeName: WideString; override;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); override;
  public
    class function ToVar(const AValue: TSQLToken): OleVariant;
    class function FromVar(const AValue: OleVariant): TSQLToken;
  end;


{ Unit wrapper }

type
  DBCommon_sw = class(TLMDUnitWrapper)
  protected
    class procedure DoInit(AData: TLMDUnitWrapperData); override;
  public
    class function  GetUnitName: WideString; override;
    class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;
  end;

implementation

{ TCANOperator_sw }

class function TCANOperator_sw.GetTypeName: WideString;
begin
  Result := 'TCANOperator';
end;

class procedure TCANOperator_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..37] of TLMDEnumerator = (
    (Name: 'coNOTDEFINED'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coNOTDEFINED)),
    (Name: 'coISBLANK'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coISBLANK)),
    (Name: 'coNOTBLANK'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coNOTBLANK)),
    (Name: 'coEQ'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coEQ)),
    (Name: 'coNE'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coNE)),
    (Name: 'coGT'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coGT)),
    (Name: 'coLT'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coLT)),
    (Name: 'coGE'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coGE)),
    (Name: 'coLE'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coLE)),
    (Name: 'coNOT'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coNOT)),
    (Name: 'coAND'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coAND)),
    (Name: 'coOR'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coOR)),
    (Name: 'coTUPLE2'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coTUPLE2)),
    (Name: 'coFIELD2'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coFIELD2)),
    (Name: 'coCONST2'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coCONST2)),
    (Name: 'coMINUS'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coMINUS)),
    (Name: 'coADD'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coADD)),
    (Name: 'coSUB'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coSUB)),
    (Name: 'coMUL'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coMUL)),
    (Name: 'coDIV'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coDIV)),
    (Name: 'coMOD'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coMOD)),
    (Name: 'coREM'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coREM)),
    (Name: 'coSUM'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coSUM)),
    (Name: 'coCOUNT'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coCOUNT)),
    (Name: 'coMIN'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coMIN)),
    (Name: 'coMAX'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coMAX)),
    (Name: 'coAVG'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coAVG)),
    (Name: 'coCONT'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coCONT)),
    (Name: 'coUDF2'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coUDF2)),
    (Name: 'coCONTINUE2'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coCONTINUE2)),
    (Name: 'coLIKE'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coLIKE)),
    (Name: 'coIN'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coIN)),
    (Name: 'coLIST2'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coLIST2)),
    (Name: 'coUPPER'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coUPPER)),
    (Name: 'coLOWER'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coLOWER)),
    (Name: 'coFUNC2'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coFUNC2)),
    (Name: 'coLISTELEM2'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coLISTELEM2)),
    (Name: 'coASSIGN'; Value: Integer({$IFDEF LMDSCT_12}TCANOperator.{$ENDIF}coASSIGN))
  );
begin
  AEnums := @ENUMS;
  ACount := 38;
end;

class function TCANOperator_sw.ToVar(const AValue: TCANOperator): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TCANOperator_sw.FromVar(const AValue: OleVariant): TCANOperator;
begin
  Result := TCANOperator(Integer(AValue));
end;

{ NODEClass_sw }

class function NODEClass_sw.GetTypeName: WideString;
begin
  Result := 'NODEClass';
end;

class procedure NODEClass_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..11] of TLMDEnumerator = (
    (Name: 'nodeNULL'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeNULL)),
    (Name: 'nodeUNARY'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeUNARY)),
    (Name: 'nodeBINARY'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeBINARY)),
    (Name: 'nodeCOMPARE'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeCOMPARE)),
    (Name: 'nodeFIELD'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeFIELD)),
    (Name: 'nodeCONST'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeCONST)),
    (Name: 'nodeTUPLE'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeTUPLE)),
    (Name: 'nodeCONTINUE'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeCONTINUE)),
    (Name: 'nodeUDF'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeUDF)),
    (Name: 'nodeLIST'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeLIST)),
    (Name: 'nodeFUNC'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeFUNC)),
    (Name: 'nodeLISTELEM'; Value: Integer({$IFDEF LMDSCT_12}NODEClass.{$ENDIF}nodeLISTELEM))
  );
begin
  AEnums := @ENUMS;
  ACount := 12;
end;

class function NODEClass_sw.ToVar(const AValue: NODEClass): OleVariant;
begin
  Result := Integer(AValue);
end;

class function NODEClass_sw.FromVar(const AValue: OleVariant): NODEClass;
begin
  Result := NODEClass(Integer(AValue));
end;

{ TParserOption_sw }

class function TParserOption_sw.GetTypeName: WideString;
begin
  Result := 'TParserOption';
end;

class procedure TParserOption_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..5] of TLMDEnumerator = (
    (Name: 'poExtSyntax'; Value: Integer({$IFDEF LMDSCT_12}TParserOption.{$ENDIF}poExtSyntax)),
    (Name: 'poAggregate'; Value: Integer({$IFDEF LMDSCT_12}TParserOption.{$ENDIF}poAggregate)),
    (Name: 'poDefaultExpr'; Value: Integer({$IFDEF LMDSCT_12}TParserOption.{$ENDIF}poDefaultExpr)),
    (Name: 'poUseOrigNames'; Value: Integer({$IFDEF LMDSCT_12}TParserOption.{$ENDIF}poUseOrigNames)),
    (Name: 'poFieldNameGiven'; Value: Integer({$IFDEF LMDSCT_12}TParserOption.{$ENDIF}poFieldNameGiven)),
    (Name: 'poFieldDepend'; Value: Integer({$IFDEF LMDSCT_12}TParserOption.{$ENDIF}poFieldDepend))
  );
begin
  AEnums := @ENUMS;
  ACount := 6;
end;

class function TParserOption_sw.ToVar(const AValue: TParserOption): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TParserOption_sw.FromVar(
  const AValue: OleVariant): TParserOption;
begin
  Result := TParserOption(Integer(AValue));
end;

{ TParserOptions_sw }

class function TParserOptions_sw.GetTypeName: WideString;
begin
  Result := 'TParserOptions';
end;

class function TParserOptions_sw.GetSetSizeOf: Integer;
begin
  Result := SizeOf(TParserOptions);
end;

class function TParserOptions_sw.ToVar(
  const AValue: TParserOptions): OleVariant;
begin
  Result := ConvToVar(@AValue);
end;

class function TParserOptions_sw.FromVar(
  const AValue: OleVariant): TParserOptions;
begin
  ConvFromVar(AValue, @Result);
end;

{ TExprNodeKind_sw }

class function TExprNodeKind_sw.GetTypeName: WideString;
begin
  Result := 'TExprNodeKind';
end;

class procedure TExprNodeKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..3] of TLMDEnumerator = (
    (Name: 'enField'; Value: Integer({$IFDEF LMDSCT_12}TExprNodeKind.{$ENDIF}enField)),
    (Name: 'enConst'; Value: Integer({$IFDEF LMDSCT_12}TExprNodeKind.{$ENDIF}enConst)),
    (Name: 'enOperator'; Value: Integer({$IFDEF LMDSCT_12}TExprNodeKind.{$ENDIF}enOperator)),
    (Name: 'enFunc'; Value: Integer({$IFDEF LMDSCT_12}TExprNodeKind.{$ENDIF}enFunc))
  );
begin
  AEnums := @ENUMS;
  ACount := 4;
end;

class function TExprNodeKind_sw.ToVar(const AValue: TExprNodeKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TExprNodeKind_sw.FromVar(
  const AValue: OleVariant): TExprNodeKind;
begin
  Result := TExprNodeKind(Integer(AValue));
end;

{ TExprScopeKind_sw }

class function TExprScopeKind_sw.GetTypeName: WideString;
begin
  Result := 'TExprScopeKind';
end;

class procedure TExprScopeKind_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..2] of TLMDEnumerator = (
    (Name: 'skField'; Value: Integer({$IFDEF LMDSCT_12}TExprScopeKind.{$ENDIF}skField)),
    (Name: 'skAgg'; Value: Integer({$IFDEF LMDSCT_12}TExprScopeKind.{$ENDIF}skAgg)),
    (Name: 'skConst'; Value: Integer({$IFDEF LMDSCT_12}TExprScopeKind.{$ENDIF}skConst))
  );
begin
  AEnums := @ENUMS;
  ACount := 3;
end;

class function TExprScopeKind_sw.ToVar(
  const AValue: TExprScopeKind): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TExprScopeKind_sw.FromVar(
  const AValue: OleVariant): TExprScopeKind;
begin
  Result := TExprScopeKind(Integer(AValue));
end;

{ TExprNode_sw }

function TExprNode_FKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FKind: TExprNodeKind;

  if IsGet then
    Result := TExprNodeKind_sw.ToVar(TExprNode_sw(AObj).FValue.FKind)
  else
    TExprNode_sw(AObj).FValue.FKind := TExprNodeKind_sw.FromVar(AArgs[0]);
end;

function TExprNode_FPartial_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FPartial: Boolean;

  if IsGet then
    Result := TExprNode_sw(AObj).FValue.FPartial
  else
    TExprNode_sw(AObj).FValue.FPartial := Boolean(AArgs[0]);
end;

function TExprNode_FOperator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FOperator: TCANOperator;

  if IsGet then
    Result := TCANOperator_sw.ToVar(TExprNode_sw(AObj).FValue.FOperator)
  else
    TExprNode_sw(AObj).FValue.FOperator := TCANOperator_sw.FromVar(AArgs[0]);
end;

function TExprNode_FData_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FData: Variant;

  if IsGet then
    Result := TExprNode_sw(AObj).FValue.FData
  else
    TExprNode_sw(AObj).FValue.FData := Variant(FindVarData(AArgs[0])^);
end;

function TExprNode_FDataType_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FDataType: TFieldType;

  if IsGet then
    Result := TFieldType_sw.ToVar(TExprNode_sw(AObj).FValue.FDataType)
  else
    TExprNode_sw(AObj).FValue.FDataType := TFieldType_sw.FromVar(AArgs[0]);
end;

function TExprNode_FDataSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FDataSize: Integer;

  if IsGet then
    Result := TExprNode_sw(AObj).FValue.FDataSize
  else
    TExprNode_sw(AObj).FValue.FDataSize := Integer(AArgs[0]);
end;

function TExprNode_FArgs_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FArgs: TList;

  if IsGet then
    Result := TList_sw.ToVar(TExprNode_sw(AObj).FValue.FArgs)
  else
    TExprNode_sw(AObj).FValue.FArgs := TList_sw.FromVar(AArgs[0]);
end;

function TExprNode_FScopeKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var FScopeKind: TExprScopeKind;

  if IsGet then
    Result := TExprScopeKind_sw.ToVar(TExprNode_sw(AObj).FValue.FScopeKind)
  else
    TExprNode_sw(AObj).FValue.FScopeKind := TExprScopeKind_sw.FromVar(AArgs[0]);
end;

function TExprNode_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TExprNode_sw.Create as IDispatch;
end;

function TExprNode_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TExprNode;

  // Implicit record copy method.
  Result := TExprNode_sw.ToVar(TExprNode(AObj));
end;

class function TExprNode_sw.GetTypeName: WideString;
begin
  Result := 'TExprNode';
end;

function TExprNode_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TExprNode_sw.Create;
  TExprNode_sw(Result).FValue := FValue;
end;

class procedure TExprNode_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('FKind', TExprNode_FKind_si, TExprNodeKind_sw);
  AData.AddField('FPartial', TExprNode_FPartial_si, Boolean_sw);
  AData.AddField('FOperator', TExprNode_FOperator_si, TCANOperator_sw);
  AData.AddField('FData', TExprNode_FData_si, Variant_sw);
  AData.AddField('FDataType', TExprNode_FDataType_si, TFieldType_sw);
  AData.AddField('FDataSize', TExprNode_FDataSize_si, Integer_sw);
  AData.AddField('FArgs', TExprNode_FArgs_si, TList_sw);
  AData.AddField('FScopeKind', TExprNode_FScopeKind_si, TExprScopeKind_sw);
  AData.AddFunction('Copy', TExprNode_Copy_si, TExprNode_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TExprNode_Create_si, 0, False);
end;

class function TExprNode_sw.ToVar(const AValue: TExprNode): OleVariant;
var
  wrpr: TExprNode_sw;
begin
  wrpr        := TExprNode_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TExprNode_sw.FromVar(const AValue: OleVariant): TExprNode;
begin
  Result := TExprNode_sw(ConvFromVar(AValue)).FValue;
end;

{ TFilterExpr_sw }

function TFilterExpr_DataSet_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSet: TDataSet write <setter>;

  TFilterExpr(AObj).DataSet := TDataSet_sw.FromVar(AArgs[0]);
end;

class function TFilterExpr_sw.GetTypeName: WideString;
begin
  Result := 'TFilterExpr';
end;

class function TFilterExpr_sw.GetWrappedClass: TClass;
begin
  Result := TFilterExpr;
end;

class procedure TFilterExpr_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProperty('DataSet', TFilterExpr_DataSet_si, TDataSet_sw, False, True, 0, False, False);
end;

class function TFilterExpr_sw.ToVar(const AValue: TFilterExpr): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TFilterExpr_sw.FromVar(const AValue: OleVariant): TFilterExpr;
begin
  Result := TFilterExpr(ConvFromVar(AValue, TFilterExpr));
end;

class function TFilterExpr_sw.ClassToVar(AClass: TFilterExpr_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TFilterExpr_sw.ClassFromVar(
  const AClass: OleVariant): TFilterExpr_sc;
begin
  Result := TFilterExpr_sc(ConvClsFromVar(AClass, TFilterExpr));
end;

{ TExprToken_sw }

class function TExprToken_sw.GetTypeName: WideString;
begin
  Result := 'TExprToken';
end;

class procedure TExprToken_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..20] of TLMDEnumerator = (
    (Name: 'etEnd'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etEnd)),
    (Name: 'etSymbol'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etSymbol)),
    (Name: 'etName'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etName)),
    (Name: 'etLiteral'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etLiteral)),
    (Name: 'etLParen'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etLParen)),
    (Name: 'etRParen'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etRParen)),
    (Name: 'etEQ'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etEQ)),
    (Name: 'etNE'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etNE)),
    (Name: 'etGE'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etGE)),
    (Name: 'etLE'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etLE)),
    (Name: 'etGT'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etGT)),
    (Name: 'etLT'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etLT)),
    (Name: 'etADD'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etADD)),
    (Name: 'etSUB'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etSUB)),
    (Name: 'etMUL'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etMUL)),
    (Name: 'etDIV'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etDIV)),
    (Name: 'etComma'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etComma)),
    (Name: 'etLIKE'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etLIKE)),
    (Name: 'etISNULL'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etISNULL)),
    (Name: 'etISNOTNULL'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etISNOTNULL)),
    (Name: 'etIN'; Value: Integer({$IFDEF LMDSCT_12}TExprToken.{$ENDIF}etIN))
  );
begin
  AEnums := @ENUMS;
  ACount := 21;
end;

class function TExprToken_sw.ToVar(const AValue: TExprToken): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TExprToken_sw.FromVar(const AValue: OleVariant): TExprToken;
begin
  Result := TExprToken(Integer(AValue));
end;

{ TExprParser_sw }

function TExprParser_SetExprParams_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // procedure SetExprParams(const Text: string; Options: TFil...

  TExprParser(AObj).SetExprParams(string(AArgs[0]), TFilterOptions_sw.FromVar(
    AArgs[1]), TParserOptions_sw.FromVar(AArgs[2]), string(AArgs[3]));
end;

function TExprParser_DataSize_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // property DataSize: Integer read <getter>;

  Result := TExprParser(AObj).DataSize;
end;

class function TExprParser_sw.GetTypeName: WideString;
begin
  Result := 'TExprParser';
end;

class function TExprParser_sw.GetWrappedClass: TClass;
begin
  Result := TExprParser;
end;

class procedure TExprParser_sw.DoInit(AData: TLMDClassWrapperData);
begin
  { Instance members }

  AData.AddProcedure('SetExprParams', TExprParser_SetExprParams_si, 4, False);
  AData.AddProperty('DataSize', TExprParser_DataSize_si, Integer_sw, True, False, 0, False, False);
end;

class function TExprParser_sw.ToVar(const AValue: TExprParser): OleVariant;
begin
  Result := ConvToVar(AValue);
end;

class function TExprParser_sw.FromVar(const AValue: OleVariant): TExprParser;
begin
  Result := TExprParser(ConvFromVar(AValue, TExprParser));
end;

class function TExprParser_sw.ClassToVar(AClass: TExprParser_sc): OleVariant;
begin
  Result := ConvClsToVar(AClass);
end;

class function TExprParser_sw.ClassFromVar(
  const AClass: OleVariant): TExprParser_sc;
begin
  Result := TExprParser_sc(ConvClsFromVar(AClass, TExprParser));
end;

{ TFieldInfo_sw }

function TFieldInfo_DatabaseName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var DatabaseName: string;

  if IsGet then
    Result := TFieldInfo_sw(AObj).FValue.DatabaseName
  else
    TFieldInfo_sw(AObj).FValue.DatabaseName := string(AArgs[0]);
end;

function TFieldInfo_TableName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var TableName: string;

  if IsGet then
    Result := TFieldInfo_sw(AObj).FValue.TableName
  else
    TFieldInfo_sw(AObj).FValue.TableName := string(AArgs[0]);
end;

function TFieldInfo_OriginalFieldName_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // var OriginalFieldName: string;

  if IsGet then
    Result := TFieldInfo_sw(AObj).FValue.OriginalFieldName
  else
    TFieldInfo_sw(AObj).FValue.OriginalFieldName := string(AArgs[0]);
end;

function TFieldInfo_Create_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // constructor Create;

  // Implicit parameterless constructor.
  Result := TFieldInfo_sw.Create as IDispatch;
end;

function TFieldInfo_Copy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function Copy: TFieldInfo;

  // Implicit record copy method.
  Result := TFieldInfo_sw.ToVar(TFieldInfo(AObj));
end;

class function TFieldInfo_sw.GetTypeName: WideString;
begin
  Result := 'TFieldInfo';
end;

function TFieldInfo_sw.CloneVal: TLMDRecordWrapper;
begin
  Result := TFieldInfo_sw.Create;
  TFieldInfo_sw(Result).FValue := FValue;
end;

class procedure TFieldInfo_sw.DoInit(AData: TLMDRecordWrapperData);
begin
  { Instance members }

  AData.AddField('DatabaseName', TFieldInfo_DatabaseName_si, string_sw);
  AData.AddField('TableName', TFieldInfo_TableName_si, string_sw);
  AData.AddField('OriginalFieldName', TFieldInfo_OriginalFieldName_si, string_sw);
  AData.AddFunction('Copy', TFieldInfo_Copy_si, TFieldInfo_sw, 0, False);

  { Class members }

  AData.AddConstructor('Create', TFieldInfo_Create_si, 0, False);
end;

class function TFieldInfo_sw.ToVar(const AValue: TFieldInfo): OleVariant;
var
  wrpr: TFieldInfo_sw;
begin
  wrpr        := TFieldInfo_sw.Create;
  wrpr.FValue := AValue;
  
  Result := ConvToVar(wrpr);
end;

class function TFieldInfo_sw.FromVar(const AValue: OleVariant): TFieldInfo;
begin
  Result := TFieldInfo_sw(ConvFromVar(AValue)).FValue;
end;

{ TSQLToken_sw }

class function TSQLToken_sw.GetTypeName: WideString;
begin
  Result := 'TSQLToken';
end;

class procedure TSQLToken_sw.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
const
  ENUMS: array[0..25] of TLMDEnumerator = (
    (Name: 'stUnknown'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stUnknown)),
    (Name: 'stTableName'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stTableName)),
    (Name: 'stFieldName'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stFieldName)),
    (Name: 'stAscending'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stAscending)),
    (Name: 'stDescending'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stDescending)),
    (Name: 'stSelect'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stSelect)),
    (Name: 'stFrom'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stFrom)),
    (Name: 'stWhere'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stWhere)),
    (Name: 'stGroupBy'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stGroupBy)),
    (Name: 'stHaving'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stHaving)),
    (Name: 'stUnion'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stUnion)),
    (Name: 'stPlan'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stPlan)),
    (Name: 'stOrderBy'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stOrderBy)),
    (Name: 'stForUpdate'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stForUpdate)),
    (Name: 'stEnd'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stEnd)),
    (Name: 'stPredicate'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stPredicate)),
    (Name: 'stValue'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stValue)),
    (Name: 'stIsNull'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stIsNull)),
    (Name: 'stIsNotNull'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stIsNotNull)),
    (Name: 'stLike'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stLike)),
    (Name: 'stAnd'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stAnd)),
    (Name: 'stOr'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stOr)),
    (Name: 'stNumber'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stNumber)),
    (Name: 'stAllFields'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stAllFields)),
    (Name: 'stComment'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stComment)),
    (Name: 'stDistinct'; Value: Integer({$IFDEF LMDSCT_12}TSQLToken.{$ENDIF}stDistinct))
  );
begin
  AEnums := @ENUMS;
  ACount := 26;
end;

class function TSQLToken_sw.ToVar(const AValue: TSQLToken): OleVariant;
begin
  Result := Integer(AValue);
end;

class function TSQLToken_sw.FromVar(const AValue: OleVariant): TSQLToken;
begin
  Result := TSQLToken(Integer(AValue));
end;

{ DBCommon_sw }

function DBCommon_TCANOperator_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TCANOperator = (coNOTDEFINED, coISBLANK, coNOTBLANK,...

  Result := TLMDUnitWrapper.TypeToVar(TCANOperator_sw);
end;

function DBCommon_NODEClass_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type NODEClass = (nodeNULL, nodeUNARY, nodeBINARY, nodeCO...

  Result := TLMDUnitWrapper.TypeToVar(NODEClass_sw);
end;

function DBCommon_CANEXPRSIZE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CANEXPRSIZE = <value>;

  Result := CANEXPRSIZE;
end;

function DBCommon_CANHDRSIZE_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CANHDRSIZE = <value>;

  Result := CANHDRSIZE;
end;

function DBCommon_CANEXPRVERSION_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const CANEXPRVERSION = <value>;

  Result := CANEXPRVERSION;
end;

function DBCommon_TParserOption_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParserOption = (poExtSyntax, poAggregate, poDefault...

  Result := TLMDUnitWrapper.TypeToVar(TParserOption_sw);
end;

function DBCommon_TParserOptions_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TParserOptions = set of TParserOption;

  Result := TLMDUnitWrapper.TypeToVar(TParserOptions_sw);
end;

function DBCommon_TExprNodeKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExprNodeKind = (enField, enConst, enOperator, enFunc);

  Result := TLMDUnitWrapper.TypeToVar(TExprNodeKind_sw);
end;

function DBCommon_TExprScopeKind_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExprScopeKind = (skField, skAgg, skConst);

  Result := TLMDUnitWrapper.TypeToVar(TExprScopeKind_sw);
end;

function DBCommon_TExprNode_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExprNode = record;

  Result := TLMDUnitWrapper.TypeToVar(TExprNode_sw);
end;

function DBCommon_TFilterExpr_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFilterExpr = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TFilterExpr_sw);
end;

function DBCommon_TExprToken_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExprToken = (etEnd, etSymbol, etName, etLiteral, et...

  Result := TLMDUnitWrapper.TypeToVar(TExprToken_sw);
end;

function DBCommon_TExprParser_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TExprParser = class(TObject);

  Result := TLMDUnitWrapper.TypeToVar(TExprParser_sw);
end;

function DBCommon_TFieldInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TFieldInfo = record;

  Result := TLMDUnitWrapper.TypeToVar(TFieldInfo_sw);
end;

function DBCommon_GetFieldInfo_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
var
  v_1: TFieldInfo;
begin
  // function GetFieldInfo(const Origin: string; var FieldInfo...

  v_1 := TFieldInfo_sw.FromVar(AArgs[1]);
  Result := DBCommon.GetFieldInfo(string(AArgs[0]), v_1);
  AssignRefParam(AArgs[1], TFieldInfo_sw.ToVar(v_1));
end;

function DBCommon_TSQLToken_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // type TSQLToken = (stUnknown, stTableName, stFieldName, st...

  Result := TLMDUnitWrapper.TypeToVar(TSQLToken_sw);
end;

function DBCommon_SQLSections_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // const SQLSections = <value>;

  Result := LMDSetToVar(SizeOf(SQLSections), SQLSections);
end;

function DBCommon_GetIndexForOrderBy_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetIndexForOrderBy(const SQL: string; DataSet: T...

  Result := TIndexDef_sw.ToVar(DBCommon.GetIndexForOrderBy(string(AArgs[0]), 
    TDataSet_sw.FromVar(AArgs[1])));
end;

function DBCommon_GetTableNameFromSQL_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetTableNameFromSQL(const SQL: string): string;

  Result := DBCommon.GetTableNameFromSQL(string(AArgs[0]));
end;

function DBCommon_GetTableNameFromQuery_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function GetTableNameFromQuery(const SQL: string): string;

  Result := DBCommon.GetTableNameFromQuery(string(AArgs[0]));
end;

function DBCommon_AddParamSQLForDetail_si(var AObj; const AArgs: TLMDDispArgs;
  AArgsSize: Integer; IsGet: Boolean): OleVariant;
begin
  // function AddParamSQLForDetail(Params: TParams; SQL: strin...

  Result := DBCommon.AddParamSQLForDetail(TParams_sw.FromVar(AArgs[0]), string(
    AArgs[1]), Boolean(AArgs[2]));
end;

class function DBCommon_sw.GetUnitName: WideString;
begin
  Result := 'DBCommon';
end;

class procedure DBCommon_sw.DoInit(AData: TLMDUnitWrapperData);
begin
  AData.AddType(TCANOperator_sw, DBCommon_TCANOperator_si);
  AData.AddType(NODEClass_sw, DBCommon_NODEClass_si);
  AData.AddConstant('CANEXPRSIZE', DBCommon_CANEXPRSIZE_si, nil, VarType(DBCommon.CANEXPRSIZE));
  AData.AddConstant('CANHDRSIZE', DBCommon_CANHDRSIZE_si, nil, VarType(DBCommon.CANHDRSIZE));
  AData.AddConstant('CANEXPRVERSION', DBCommon_CANEXPRVERSION_si, nil, VarType(DBCommon.CANEXPRVERSION));
  AData.AddType(TParserOption_sw, DBCommon_TParserOption_si);
  AData.AddType(TParserOptions_sw, DBCommon_TParserOptions_si);
  AData.AddType(TExprNodeKind_sw, DBCommon_TExprNodeKind_si);
  AData.AddType(TExprScopeKind_sw, DBCommon_TExprScopeKind_si);
  AData.AddType(TExprNode_sw, DBCommon_TExprNode_si);
  AData.AddType(TFilterExpr_sw, DBCommon_TFilterExpr_si);
  AData.AddType(TExprToken_sw, DBCommon_TExprToken_si);
  AData.AddType(TExprParser_sw, DBCommon_TExprParser_si);
  AData.AddType(TFieldInfo_sw, DBCommon_TFieldInfo_si);
  AData.AddFunction('GetFieldInfo', DBCommon_GetFieldInfo_si, Boolean_sw, 2, False);
  AData.AddType(TSQLToken_sw, DBCommon_TSQLToken_si);
  AData.AddConstant('SQLSections', DBCommon_SQLSections_si, nil, varInteger);
  AData.AddFunction('GetIndexForOrderBy', DBCommon_GetIndexForOrderBy_si, TIndexDef_sw, 2, False);
  AData.AddFunction('GetTableNameFromSQL', DBCommon_GetTableNameFromSQL_si, string_sw, 1, False);
  AData.AddFunction('GetTableNameFromQuery', DBCommon_GetTableNameFromQuery_si, string_sw, 1, False);
  AData.AddFunction('AddParamSQLForDetail', DBCommon_AddParamSQLForDetail_si, string_sw, 3, False);
end;

class function DBCommon_sw.ToVar(AScriptControl: TLMDScriptControl): OleVariant;
begin
  Result := AScriptControl.GetUnitInstance(DBCommon_sw);
end;

initialization
  RegisterUnitWrapper(DBCommon_sw);
  RegisterClassWrapper(TFilterExpr_sw);
  RegisterClassWrapper(TExprParser_sw);

end.
