unit LMDSctImporterCompiler;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDSctImporterCompiler unit (YB)
--------------------------------
 LMD Script Pack Importer semantic analizer and wrappers unit generator.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, Dialogs, LMDTypes, LMDSctImporterUnitDoc,
  LMDSctImporterTree;

type
  TLMDPasAnalizer = class;

  {************************** class TLMDUsedUnitItem **************************}

  TLMDUsedUnitItem = class
  public
    FullName:    string;
    Checked:     Boolean;
    SupportKind: TLMDSupportKind;
  end;

  {************************** class TLMDUsedUnitData **************************}

  TLMDUsedUnitData = class
  private
    FAnalizer: TLMDPasAnalizer;
    FPasUnit:  TLMDPasUsedUnit;
    FItems:    TList;

    function GetCount: Integer;
    function GetItems(AIndex: Integer): TLMDUsedUnitItem;
  public
    constructor Create(AAnalizer: TLMDPasAnalizer);
    destructor Destroy; override;

    procedure Clear;
    procedure Add(const AFullName: string; AChecked: Boolean;
                  ASupportKind: TLMDSupportKind);
    function  Find(const AFullName: string): TLMDUsedUnitItem;

    property PasUnit: TLMDPasUsedUnit read FPasUnit write FPasUnit;
    property Items[AIndex: Integer]: TLMDUsedUnitItem read GetItems; default;
    property Count: Integer read GetCount;
  end;

  {*************************** class TLMDPasAnalizer **************************}

  TLMDPasAnalizer = class
  private
    FDocument:       TLMDUnitDocument;
    FUnit:           TLMDPasUnit;
    FUnitErrorCount: Integer;
    FUsedUnits:      TList;

    procedure ClearUsedUnits;
    procedure ClearProc(C: TLMDUnitDocIterateContext; ANode: TLMDPasNamedNode;
                        AData: TLMDDataTag);
  protected
    procedure AddError(const AMsg: string; AObject: TLMDPasNamedNode);
    procedure AddWarning(const AMsg: string; AObject: TLMDPasNamedNode);
    procedure AddInfo(const AMsg: string; AObject: TLMDPasNamedNode);
    procedure AddUncheckedInfo(ANode: TLMDPasNamedNode;
                               const ATypeName: string = ''); overload;
    procedure AddUncheckedInfo(ANodes: TLMDPasNamedNodes;
                               const ATypeName: string = ''); overload;

    procedure AnalizeUnit;
    procedure AnalizeUsedUnit(AUUnit: TLMDPasUsedUnit);

    procedure AnalizeRecordMembers(const ATypeName: string; AType: TLMDPasRecordType);
    procedure AnalizeClassMembers(const ATypeName: string; AType: TLMDPasClassType);

    procedure AnalizeTypeDecl(ADecl: TLMDPasTypeDecl);
    procedure AnalizeConst(AConst: TLMDPasConstDecl);
    procedure AnalizeVar(AVar: TLMDPasVarDecl);
    procedure AnalizeProc(AProc: TLMDPasProcHeading);
    procedure AnalizeOverloadGroup(AGroup: TLMDPasOverloadGroup);
    function  IsOverloadPairSupported(AProcA, AProcB: TLMDPasProcHeading): Boolean;
    procedure AnalizeProperty(AProp: TLMDPasProperty);
    procedure AnalizePropRedecl(ARedecl: TLMDPasPropertyRedecl);
                                     
    function  GetParamsSupportKind(AParams: TLMDPasParameters;
                                   AMessageObject: TLMDPasNamedNode): TLMDSupportKind;
    function  GetParamSupportKind(AParam: TLMDPasParameter;
                                  AMessageObject: TLMDPasNamedNode): TLMDSupportKind;

    function  GetTypeDeclSupportKind(AType: TLMDPasType;
                                     const AMessagePrefix: string;
                                     AMessageObject: TLMDPasNamedNode): TLMDSupportKind;
    function  GetTypeRefSupportKind(AType: TLMDPasType;
                                    const AMessagePrefix: string;
                                    AMessageObject: TLMDPasNamedNode): TLMDSupportKind;
    function  GetTypeIdSupportKind(const AQualName: string;
                                   const AMessagePrefix: string;
                                   AMessageObject: TLMDPasNamedNode): TLMDSupportKind;

    function  FindIdInUsedUnits(const AFullName: string): TLMDUsedUnitItem;
    function  FindUsedUnit(const AUnitName: string): TLMDUsedUnitData;
  public
    constructor Create(ADocument: TLMDUnitDocument);
    destructor Destroy; override;

    function Analize:  Boolean;
    property Document: TLMDUnitDocument read FDocument;
    property Unit_:    TLMDPasUnit read FUnit;
  end;

  {************************* class TLMDUsedUnitWriter *************************}

  TLMDUsedUnitWriter = class
  private
    FDocument: TLMDUnitDocument;
    FUnit:     TLMDPasUnit;
    FLines:    TStrings;
  protected
    procedure WriteUnit;
    procedure WriteUnitDeclaration(ADecl: TLMDPasNamedNode);
    procedure WriteTypeDecl(ADecl: TLMDPasTypeDecl);
    procedure WriteProperty(AProp: TLMDPasProperty);
    procedure WritePropRedecl(ARedecl: TLMDPasPropertyRedecl);

    procedure AddLine(AIdent: Integer; const AElemKind: Char;
                      const AName: string; AChecked: Boolean;
                      ASupportKind: TLMDSupportKind);
  public
    constructor Create(ADocument: TLMDUnitDocument);
    destructor Destroy; override;

    procedure SaveToStream(AStream: TStream);
    procedure SaveToFile(const AFileName: string);
    property  Document: TLMDUnitDocument read FDocument;
    property  Unit_:    TLMDPasUnit read FUnit;
  end;

  {************************* class TLMDUsedUnitReader *************************}

  TLMDUsedUnitReaderLineKind = (lkType, lkProperty, lkUnknown);
  ELMDInvalidFileFormat      = class(Exception);

  TLMDUsedUnitReader = class
  private
    FAnalizer: TLMDPasAnalizer;
    FLines:    TStrings;
    FData:     TLMDUsedUnitData;
    FIndex:    Integer;
  protected
    function  CurLine: string;
    procedure SkipLine;
    function  Eof: Boolean;
    procedure InvalidFormatError;

    procedure ReadUnit;
    procedure ReadType;
    procedure ReadProperty(const AParentName: string);

    procedure SkipBlanks(const s: string; var i: Integer);
    function  LineKind(const ALine: string): TLMDUsedUnitReaderLineKind;
    procedure GetParams(const ALine: string; out AChecked: Boolean;
                        out ASupportKind: TLMDSupportKind; out AName: string);
  public
    constructor Create(AAnalizer: TLMDPasAnalizer);
    destructor Destroy; override;

    function LoadFromStream(AStream: TStream): TLMDUsedUnitData;
    function LoadFromFile(const AFileName: string): TLMDUsedUnitData;
  end;

  {********************** class TLMDPasWrapperGenerator ***********************}

  TLMDPasSplitKind = (skNone, skUses, skDecl, skBody);

  TLMDPasCall = record
    Proc:     TLMDPasProcHeading;
    ArgCount: Integer;
  end;
  TLMDPasCalls = array of TLMDPasCall;

  TLMDPasWrapperGenerator = class
  private
    FUnit:           TLMDPasUnit;
    FDocument:       TLMDUnitDocument;
    FLines:          TStrings;
    FCurIdent:       Integer;
    FCurEmptyLine:   Integer;
    FResultUnitName: string;
  protected
    { Working with text }

    procedure AddLine(const S: string; APasSplitKind: TLMDPasSplitKind = skNone);
    procedure EmptyLine;
    procedure BeginIdent;
    procedure EndIdent;

    function  GetSplitPos(const S: string; AMaxLength: Integer;
                          APasSplitKind: TLMDPasSplitKind): Integer;

    { Generation }

    // Unit level:

    procedure GenUnit;
    procedure GenInterfaceSection;
    procedure GenImplementationSection;

    procedure GenUsesClause;
    procedure AddUsesUnit(const AUnitName: string; var AUses: string);
    function  HasTypeWrappers: Boolean;

    // Unit wrapper:

    function  HasUnitLevelDecl: Boolean;

    function  GetUnitUnprefixedName: string;
    procedure GenIntfUnitWrapper;
    procedure GenImplUnitWrapper;
    procedure GenUnitWrapperReg;

    procedure GenUnitDoInitBody;

    // Protected asessor types:

    function  IsProtectedProp(AMember: TLMDPasNamedNode): Boolean;
    function  HasProtectedProps: Boolean;
    function  GetProtectedProps(AType: TLMDPasClassType; AResult: TList): Boolean;
    procedure GenProtectedPropHandlers;
    procedure GenProtectedAccessorType(AType: TLMDPasTypeDecl);

    // Class wrappers registration:

    function  HasClassWrapperRegs: Boolean;
    procedure GenClassWrapperRegs;

    // Event wrappers registration:

    function  HasEventWrapperRegs: Boolean;
    procedure GenEventWrapperRegs;

    // Type-declaration wrappers:

    procedure GenIntfTypeWrappers;
    procedure GenImplTypeWrappers;

    procedure GenIntfSubrangeTypeDecl(const AName: string; AType: TLMDPasSubrangeType);
    procedure GenIntfTypeIdDecl(const AName: string; ATypeKwd: Boolean;
                                AType: TLMDPasTypeId);
    procedure GenIntfEnumTypeDecl(const AName: string; AType: TLMDPasEnumType);
    procedure GenIntfClassRefTypeDecl(const AName: string; AType: TLMDPasClassRefType);
    procedure GenIntfSetTypeDecl(const AName: string; AType: TLMDPasSetType);
    procedure GenIntfRecordTypeDecl(const AName: string; AType: TLMDPasRecordType);
    procedure GenIntfClassTypeDecl(const AName: string; AType: TLMDPasClassType);
    procedure GenIntfProcTypeDecl(const AName: string; AType: TLMDPasProcType);

    procedure GenImplSubrangeTypeDecl(const AName: string; AType: TLMDPasSubrangeType);
    procedure GenImplTypeIdDecl(const AName: string; ATypeKwd: Boolean;
                                AType: TLMDPasTypeId);
    procedure GenImplEnumTypeDecl(const AName: string; AType: TLMDPasEnumType);
    procedure GenImplClassRefTypeDecl(const AName: string; AType: TLMDPasClassRefType);
    procedure GenImplSetTypeDecl(const AName: string; AType: TLMDPasSetType);
    procedure GenImplRecordTypeDecl(const AName: string; AType: TLMDPasRecordType);
    procedure GenImplClassTypeDecl(const AName: string; AType: TLMDPasClassType);
    procedure GenImplProcTypeDecl(const AName: string; AType: TLMDPasProcType);

    procedure GenTypeImplComment(const AClassName: string);

    procedure GenRecordDoInitBody(const AName: string; AType: TLMDPasRecordType);

    function  IsInstanceMember(AMember: TLMDPasNamedNode): Boolean;
    function  IsClassHasInstanceMembers(AType: TLMDPasClassType;
                                        AIncludePropRedecls: Boolean): Boolean;
    function  IsClassHasClassMembers(AType: TLMDPasClassType): Boolean;
    procedure GenClassDoInitBody(const AName: string; AType: TLMDPasClassType);

    procedure GenIntfScriptHandler(const AName: string; AType: TLMDPasProcType);
    procedure GenImplScriptHandler(const AName: string; AType: TLMDPasProcType);
    function  GenScriptHandlerProcHeading(AType: TLMDPasProcType;
                                          const AProcName: string): string;
    procedure GenScriptHandlerProcImpl(const AName: string;
                                       AType: TLMDPasProcType);
    procedure GenScriptHandlerProcVarSection(const AName: string;
                                             AType: TLMDPasProcType);

    // Members invokation utils (for types and for whole unit):

    procedure GenUnitMemberDoInit(AMember: TLMDPasNamedNode);
    procedure GenTypeMemberDoInit(const ATypeName: string;
                                  AMember: TLMDPasNamedNode);
    function  GenProcDoInit(const AProcName, AInvoker: string;
                            AKind: TLMDPasProcKind; AParamCount,
                            AOptionalParams: Integer;
                            AReturnType: TLMDPasType): string;
    procedure GenImplMembersInvokers(const AParentName,
                                     AInstanceInvokePrefix,
                                     AMetaInvokePrefix: string;
                                     AMembers: TLMDPasNamedNodes);
    procedure GenInvokerVarSection(AMember: TLMDPasNamedNode);
    procedure GenMemberInvoker(const AParentName, AInvokePrefix: string;
                               AMember: TLMDPasNamedNode);
    procedure GenTypeDeclInvoker(const AParentName, AInvokePrefix: string;
                                 ADecl: TLMDPasTypeDecl);
    procedure GenConstInvoker(const AParentName, AInvokePrefix: string;
                              ADecl: TLMDPasConstDecl);
    procedure GenVarInvoker(const AParentName, AInvokePrefix: string;
                            ADecl: TLMDPasVarDecl);
    procedure GenProcInvoker(const AParentName, AInvokePrefix: string;
                             AProc: TLMDPasProcHeading); overload;
    procedure GenProcInvoker(const AParentName, AName, AInvokePrefix: string;
                             const ACalls: TLMDPasCalls); overload;
    procedure GenOvarlodGroupInvoker(const AParentName, AInvokePrefix: string;
                                     AGroup: TLMDPasOverloadGroup);
    procedure GenPropInvoker(const AParentName, AInvokePrefix: string;
                             AProp: TLMDPasProperty);

    procedure GetAllVarOutParams(AType: TLMDPasProcType; Result: TList); overload;
    procedure GetAllVarOutParams(AMember: TLMDPasNamedNode; Result: TList); overload;
    procedure GenParamsPreExecute(AParams: TLMDPasParameters;
                                  AIncludeOnly: Integer = -1);
    procedure GenParamsPostExecute(AParams: TLMDPasParameters;
                                   AIncludeOnly: Integer = -1);
    function  GenParamsStr(AParams: TLMDPasParameters;
                           AIncludeOnly: Integer = -1): string;

    // Parameter utils:

    procedure ScriptHandlerGenParamsPreExecute(AParams: TLMDPasParameters);
    procedure ScriptHandlerGenParamsPostExecute(AParams: TLMDPasParameters);

    // Type-reference:

    function  GenTypeWrapperRef(const AType: TLMDPasType): string;
    function  GenTypeIdWrapperRef(const AQualName: string): string;
    function  GenTypeToVarStr(const AType: TLMDPasType; const AArg: string): string;
    function  GenTypeFromVarStr(const AType: TLMDPasType; const AArg: string): string;
    function  GenTypeIdToVarStr(const AQualName: string; const AArg: string): string;
    function  GenTypeIdFromVarStr(const AQualName: string; const AArg: string): string;

    // Type-reusage:

    function  GenTypeReuseStr(const AType: TLMDPasType): string;

    { Others }

    function  ConstraintString(const S: string; AMaxSize: Integer): string;

    function  GetWrapperUnitName(const AUnitName: string): string;
    function  GetWrapperTypeName(const ATypeName: string): string;
    function  GetMetaclassTypeName(const ATypeName: string): string;
    function  GetProtectedAccessorName(const ATypeName: string): string;
    function  GetEventHandlerClassName(const ATypeName: string): string;

    function  GetTypeWrapperFromQualTypeId(const AQualName: string): string;

    procedure AddCaseEntryBegin(Idx: Integer);
    procedure AddCaseEntryEnd;

    function GetIntfToVarHeader(const ATypeName: string): string;
    function GetIntfFromVarHeader(const ATypeName: string): string;
    function GetImplToVarHeader(const AClassName, ATypeName: string): string;
    function GetImplFromVarHeader(const AClassName, ATypeName: string): string;
  public
    constructor Create(ADocument: TLMDUnitDocument);
    destructor Destroy; override;

    procedure Generate;

    procedure SaveToStream(AStream: TStream);
    procedure SaveToFile(const AFileName: string);

    property Document: TLMDUnitDocument read FDocument;
    property Unit_:    TLMDPasUnit read FUnit;
    property ResultUnitName: string read FResultUnitName;
  end;

procedure ParseQualName(const AQualName: string; out AUnitName, AName: string);

implementation

uses
  Math, LMDSctCst, Windows;

{ ---------------------------------------------------------------------------- }

const
  OBJ_VAR:      string = 'obj';
  CLASS_VAR_TP: string = 'TClsVarType';
  CLASS_VAR:    string = 'cls';

{ ---------------------------------------------------------------------------- }

type
  TLMDUnitDocumentAccess = class(TLMDUnitDocument);

  TConversionKind = (ckImplicit, ckVariant, ckCharConv, ckWrapper, ckError);

  PPredefinedSymbol = type Integer;
  TPredefinedSymbol = record
    Name:        string;
    IsSupported: Boolean;
    ConvKind:    TConversionKind;
  end;

{ ---------------------------------------------------------------------------- }

const
  PredefinedSymbols: array[0..35] of TPredefinedSymbol =
  (
    (Name: 'Boolean';      IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'ByteBool';     IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'WordBool';     IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'LongBool';     IsSupported: True;   ConvKind: ckImplicit),

    (Name: 'Integer';      IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'Cardinal';     IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'Int64';        IsSupported: True;   ConvKind: ckWrapper), // D5 workaround.
    (Name: 'UInt64';       IsSupported: True;   ConvKind: ckWrapper), // D5 workaround.
    (Name: 'NativeInt';    IsSupported: True;   ConvKind: ckWrapper), // D5 workaround.
    (Name: 'NativeUInt';   IsSupported: True;   ConvKind: ckWrapper), // D5 workaround.
    (Name: 'Single';       IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'Double';       IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'Extended';     IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'Comp';         IsSupported: True;   ConvKind: ckImplicit),

    (Name: 'Currency';     IsSupported: True;   ConvKind: ckImplicit),

    (Name: 'Byte';         IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'Smallint';     IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'Shortint';     IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'Word';         IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'Longword';     IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'Longint';      IsSupported: True;   ConvKind: ckImplicit),

    (Name: 'Char';         IsSupported: True;   ConvKind: ckCharConv),
    (Name: 'AnsiChar';     IsSupported: True;   ConvKind: ckCharConv),
    (Name: 'WideChar';     IsSupported: True;   ConvKind: ckCharConv),
    (Name: 'ShortString';  IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'AnsiString';   IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'WideString';   IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'UnicodeString';IsSupported: True;   ConvKind: ckImplicit),
    (Name: 'string';       IsSupported: True;   ConvKind: ckImplicit),

    (Name: 'Variant';      IsSupported: True;   ConvKind: ckVariant),
    (Name: 'OleVariant';   IsSupported: True;   ConvKind: ckVariant),

    (Name: 'Pointer';      IsSupported: False;  ConvKind: ckError),
    (Name: 'PChar';        IsSupported: False;  ConvKind: ckError),
    (Name: 'PAnsiChar';    IsSupported: False;  ConvKind: ckError),
    (Name: 'PWideChar';    IsSupported: False;  ConvKind: ckError),
    (Name: 'Text';         IsSupported: False;  ConvKind: ckError)
  );

{ ---------------------------------------------------------------------------- }

function FindPredefinedSymbol(const AName: string): PPredefinedSymbol;
var
  i: Integer;
begin
  for i := Low(PredefinedSymbols) to High(PredefinedSymbols) do
    if SameText(PredefinedSymbols[i].Name, AName) then
    begin
      Result := i;
      Exit;
    end;

  Result := -1;
end;

{ ---------------------------------------------------------------------------- }

function GetPredefinedSymbolSupportKind(const AName: string): TLMDSupportKind;
var
  s: PPredefinedSymbol;
begin
  s := FindPredefinedSymbol(AName);
  if s <> -1 then
  begin
    if PredefinedSymbols[s].IsSupported then
      Result := skYes
    else
      Result := skNo;
  end
  else
    Result := skUnknown;
end;

{ ---------------------------------------------------------------------------- }

function GetPredefinedSymbolConvKind(const AName: string): TConversionKind;
var
  s: PPredefinedSymbol;
begin
  s := FindPredefinedSymbol(AName);
  if s <> -1 then
    Result := PredefinedSymbols[s].ConvKind
  else
    Result := ckError;
end;

{ ---------------------------------------------------------------------------- }

procedure CombState(var AState: TLMDSupportKind;
  AVal: TLMDSupportKind); overload;
begin
  case AState of
    skNo:       AState := skNo;
    skYes:      AState := AVal;
    skUnknown:  case AVal of
                  skNo:       AState := skNo;
                  skYes:      AState := skUnknown;
                  skUnknown:  AState := skUnknown;
                end;
  end;
end;
    
{ ---------------------------------------------------------------------------- }

procedure CombState(ANode: TLMDPasTreeNode; AVal: TLMDSupportKind); overload;
var
  state: TLMDSupportKind;
begin
  state := ANode.C_SupportKind;
  CombState(state, AVal);
  ANode.C_SupportKind := state;
end;

{ ---------------------------------------------------------------------------- }

procedure ParseQualName(const AQualName: string;
  out AUnitName, AName: string);
var
  i:   Integer;
  dot: Integer;
begin
  dot := 0;
  
  for i := Length(AQualName) downto 1 do
    if AQualName[i] = '.' then
    begin
      dot := i;
      Break; // for
    end;

  if dot = 0 then
  begin
    AUnitName := '';
    AName     := AQualName;
  end
  else
  begin
    AUnitName := Copy(AQualName, 1, dot - 1);
    AName     := Copy(AQualName, dot + 1, MaxInt);
  end;
end;

{*************************** class TLMDUsedUnitData ***************************}
{ --------------------------------- private ---------------------------------- }

function TLMDUsedUnitData.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUsedUnitData.GetItems(AIndex: Integer): TLMDUsedUnitItem;
begin
  Result := TLMDUsedUnitItem(FItems[AIndex]);
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDUsedUnitData.Create(AAnalizer: TLMDPasAnalizer);
begin
  inherited Create;
  FAnalizer := AAnalizer;
  FItems    := TList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDUsedUnitData.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitData.Clear;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TLMDUsedUnitItem(FItems[i]).Free;
  FItems.Count := 0;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitData.Add(const AFullName: string; AChecked: Boolean;
  ASupportKind: TLMDSupportKind);
var
  item: TLMDUsedUnitItem;
begin
  item := TLMDUsedUnitItem.Create;

  item.FullName    := AFullName;
  item.Checked     := AChecked;
  item.SupportKind := ASupportKind;

  FItems.Add(item);
end;

{ ---------------------------------------------------------------------------- }

function TLMDUsedUnitData.Find(const AFullName: string): TLMDUsedUnitItem;
var
  i:   Integer;
  doc: TLMDUnitDocument;
begin
  for i := 0 to FItems.Count - 1 do
    if SameText(TLMDUsedUnitItem(FItems[i]).FullName, AFullName) then
    begin
      doc := FAnalizer.FDocument;
      TLMDUnitDocumentAccess(doc).UsedElemReferenced(PasUnit.C_FullName,
                                                     AFullName);
      Result := TLMDUsedUnitItem(FItems[i]);
      Exit;
    end;
  Result := nil;
end;

{**************************** class TLMDPasAnalizer ***************************}
{ --------------------------------- private ---------------------------------- }

procedure TLMDPasAnalizer.ClearProc(C: TLMDUnitDocIterateContext;
  ANode: TLMDPasNamedNode; AData: TLMDDataTag);
begin
  ANode.C_Clear;
  C.IterateChildren(nil);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.ClearUsedUnits;
var
  i: Integer;
begin
  for i := 0 to FUsedUnits.Count - 1 do
    TLMDUsedUnitData(FUsedUnits[i]).Free;
  FUsedUnits.Count := 0;
end;

{ -------------------------------- protected --------------------------------- }

procedure TLMDPasAnalizer.AddError(const AMsg: string;
  AObject: TLMDPasNamedNode);
var
  m: TLMDUnitDocMessage;
begin
  AObject.C_Messages.Add(Format(SLMDCompError, [AMsg]));

  if FDocument.NodeChecked[AObject] then
  begin
    m.Kind     := mkError;
    m.Text     := AMsg;
    m.FileName := ExtractFileName(FDocument.UnitPath);
    m.Node     := AObject;

    TLMDUnitDocumentAccess(FDocument).AddMessage(m);
    Inc(FUnitErrorCount); // Only for checked nodes.
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AddInfo(const AMsg: string;
  AObject: TLMDPasNamedNode);
var
  m: TLMDUnitDocMessage;
begin
  if FDocument.GenAdditionalInfo then
  begin
    m.Kind     := mkInfo;
    m.Text     := AMsg;
    m.FileName := ExtractFileName(FDocument.UnitPath);
    m.Node     := AObject;

    TLMDUnitDocumentAccess(FDocument).AddMessage(m);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AddUncheckedInfo(ANode: TLMDPasNamedNode;
  const ATypeName: string);
var
  s: string;
begin
  if (ANode.C_SupportKind = skYes) and not FDocument.NodeChecked[ANode] then
  begin
    if ANode is TLMDPasTypeMember then
      s := TLMDPasTypeMember(ANode).MemberToStr(ATypeName)
    else
      s := ANode.Name;

    AddInfo('Unchecked supported element: ' + s, ANode);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AddUncheckedInfo(ANodes: TLMDPasNamedNodes;
  const ATypeName: string);
var
  nd: TLMDPasNamedNode;
  i:  Integer;
begin
  if FDocument.GenAdditionalInfo then
    for i := 0 to ANodes.Count - 1 do
    begin
      nd := ANodes[i];
      AddUncheckedInfo(nd, ATypeName);
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AddWarning(const AMsg: string;
  AObject: TLMDPasNamedNode);
var
  m: TLMDUnitDocMessage;
begin
  AObject.C_Messages.Add(Format(SLMDCompWarning, [AMsg]));

  if FDocument.NodeChecked[AObject] then
  begin
    m.Kind     := mkWarning;
    m.Text     := AMsg;
    m.FileName := ExtractFileName(FDocument.UnitPath);
    m.Node     := AObject;

    TLMDUnitDocumentAccess(FDocument).AddMessage(m);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AnalizeUnit;
var
  i:   Integer;
  decl: TLMDPasNamedNode;
begin
  for i := 0 to FUnit.Uses_.Count - 1 do
    AnalizeUsedUnit(FUnit.Uses_[i]);

  for i := 0 to FUnit.Declarations.Count - 1 do
  begin
    decl := FUnit.Declarations[i];

    case decl.GetNodeKind of
      tnkConstDecl:     AnalizeConst(TLMDPasConstDecl(decl));
      tnkTypeDecl:      AnalizeTypeDecl(TLMDPasTypeDecl(decl));
      tnkVarDecl:       AnalizeVar(TLMDPasVarDecl(decl));
      tnkProcHeading:   AnalizeProc(TLMDPasProcHeading(decl));
      tnkOverloadGroup: AnalizeOverloadGroup(TLMDPasOverloadGroup(decl));
    else
      Assert(False);
    end;

    TLMDUnitDocumentAccess(FDocument).AnalizeProgress;
  end;

  AddUncheckedInfo(FUnit.Declarations);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AnalizeUsedUnit(AUUnit: TLMDPasUsedUnit);
var
  i:         Integer;
  usupath:   string;
  data:      TLMDUsedUnitData;
  reader:    TLMDUsedUnitReader;
  prefixes:  TStrings;
  pref:      string;
begin
  if not FDocument.NodeChecked[AUUnit] then
    Exit;

  if not TLMDUnitDocumentAccess(FDocument).PreprocessUsedUnit(AUUnit.Name,
                                                              usupath) and
     not FDocument.FileHandler.FindUsedUSUFile(AUUnit.Name, usupath) then
  begin
    usupath  := '';
    prefixes := FDocument.FileHandler.NamespacePrefixes;

    for i := 0 to prefixes.Count - 1 do
    begin
      pref := Trim(prefixes[i]);
      if pref[Length(pref)] = '.' then
        Delete(pref, Length(pref), 1);

      if (Pos(pref, AUUnit.Name) <> 1) and
         FDocument.FileHandler.FindUsedUSUFile(pref + '.' + AUUnit.Name,
                                               usupath) then
        Break; // for

      usupath := '';
    end;
  end;

  if usupath = '' then
  begin
    AUUnit.C_SupportKind := skUnknown;
    AddWarning(Format(SLMDCompAnalizeResNotFound, [AUUnit.Name]),
               AUUnit);
    Exit;
  end;
  AUUnit.C_FullName := ChangeFileExt(ExtractFileName(usupath), '');

  try
    reader := TLMDUsedUnitReader.Create(Self);
    try
      data          := reader.LoadFromFile(usupath);
      data.PasUnit  := AUUnit;

      FUsedUnits.Add(data);
    finally
      reader.Free;
    end;
  except
    on E: Exception do
    begin
      AUUnit.C_SupportKind := skUnknown;
      AddWarning(Format(SLMDCompFioleReadFailed, [ExtractFileName(usupath),
                                                  E.Message]), AUUnit);
      Exit;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AnalizeConst(AConst: TLMDPasConstDecl);
var
  s: string;
begin
  AConst.C_SupportKind := skYes;

  case AConst.Kind of
    ckTyped:    CombState(AConst, GetTypeRefSupportKind(AConst.Type_,
                          SLMDCompConstantType, AConst));
    ckSimple,
    ckNil,
    ckSet:      CombState(AConst, skYes);
  else // ckUnknown
    s := FDocument.ConstTypeRepl[AConst];

    if s <> '' then
    begin
      if not IsValidIdent(s) then
      begin
        AConst.C_SupportKind := skNo;
        AddError(Format(SLMDCompNotValidIdent, [s]), AConst);
      end
      else
        CombState(AConst, GetTypeIdSupportKind(s, 
                  SLMDCompConstantType, AConst));
    end
    else
    begin
      AConst.C_SupportKind := skNo;
      AddError(SLMDCompCantAnalizeUntpdCst, AConst);

      if not FDocument.NodeChecked[AConst] then
        AddInfo('Constant ' + AConst.Name + ' can be supported by ' +
                'specifying its type', AConst);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AnalizeTypeDecl(ADecl: TLMDPasTypeDecl);
begin
  if ADecl.IsTemplate then
  begin
    ADecl.C_SupportKind := skNo;
    AddError(SLMDCompTemplatesNotSupp, ADecl);
  end
  else
    ADecl.C_SupportKind := GetTypeDeclSupportKind(ADecl.Type_, '', ADecl);

  if ADecl.C_SupportKind <> skNo then
    case ADecl.Type_.GetNodeKind of
      tnkRecordType: AnalizeRecordMembers(ADecl.Name, TLMDPasRecordType(ADecl.Type_));
      tnkClassType:  AnalizeClassMembers(ADecl.Name, TLMDPasClassType(ADecl.Type_));
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AnalizeVar(AVar: TLMDPasVarDecl);
begin
  AVar.C_SupportKind := GetTypeRefSupportKind(AVar.Type_,
                        SLMDCompVariableType, AVar);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AnalizeProc(AProc: TLMDPasProcHeading);
begin
  if AProc.IsTemplate then
  begin
    AProc.C_SupportKind := skNo;
    AddError(SLMDCompTemplatesNotSupp, AProc);
  end;

  CombState(AProc, GetParamsSupportKind(AProc.Parameters, AProc));

  if AProc.ReturnType <> nil then
    CombState(AProc, GetTypeRefSupportKind(AProc.ReturnType,
              SLMDCompReturnType, AProc));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AnalizeOverloadGroup(
  AGroup: TLMDPasOverloadGroup);
var
  i, j:       Integer;
  checked:    TList;
  proc, cmp:  TLMDPasProcHeading;
  prmcnt:     Integer;
  nonopts:    Integer;
  supprd:    Boolean;
begin
  checked := TList.Create;
  try
    for i := 0 to AGroup.Procs.Count - 1 do
    begin
      proc := AGroup.Procs[i];
      AnalizeProc(proc);

      if FDocument.NodeChecked[proc] then
        checked.Add(proc);
    end;

    if checked.Count = 0 then
    begin
      AGroup.C_SupportKind := skNo;
      AddError(SLMDCompOverlGroupIsEmpty, AGroup);
    end
    else
    begin
      nonopts := MaxInt;
      prmcnt  := 0;

      for i := 0 to checked.Count - 1 do
      begin
        proc := TLMDPasProcHeading(checked[i]);
        CombState(AGroup, proc.C_SupportKind);

        for j := i + 1 to checked.Count - 1 do
        begin
          cmp := TLMDPasProcHeading(checked[j]);
          CombState(AGroup, cmp.C_SupportKind);

          if not IsOverloadPairSupported(proc, cmp) then
            AGroup.C_SupportKind := skNo;
        end;

        prmcnt  := Max(prmcnt, proc.Parameters.Count);
        nonopts := Min(nonopts, proc.Parameters.Count -
                       proc.Parameters.OptionalCount);
      end;

      if AGroup.C_SupportKind <> skNo then
      begin
        AGroup.C_FuncKind      := TLMDPasProcHeading(checked[0]).FuncKind;
        AGroup.C_ParamCount    := prmcnt;
        AGroup.C_OptionalCount := prmcnt - nonopts;
      end
      else
        AddError(SLMDCompOverlGroupNotSupp, AGroup);
    end;

    { Info }

    if AGroup.C_SupportKind = skNo then
    begin
      supprd := False;
      for i := 0 to AGroup.Procs.Count - 1 do
        if AGroup.Procs[i].C_SupportKind <> skNo then
        begin
          supprd := True;
          Break; // for
        end;

      if supprd then
        AddInfo('Overload group ' + AGroup.Name + ' can be supported by ' +
                'unchecking some of its members.', AGroup);
    end
    else
    begin
      for i := 0 to AGroup.Procs.Count - 1 do
        if (AGroup.Procs[i].C_SupportKind <> skNo) and
           not FDocument.NodeChecked[AGroup.Procs[i]] then
        begin
          proc   := AGroup.Procs[i];
          supprd := True;

          for j := 0 to checked.Count - 1 do
          begin
            cmp := TLMDPasProcHeading(checked[j]);
            if not IsOverloadPairSupported(proc, cmp) then
            begin
              supprd := False;
              Break; // for
            end;
          end;

          if supprd then
            AddUncheckedInfo(proc);
        end;
    end;
  finally
    checked.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AnalizeRecordMembers(const ATypeName: string;
  AType: TLMDPasRecordType);
var
  i:      Integer;
  member: TLMDPasNamedNode;
begin
  for i := 0 to AType.Members.Count - 1 do
  begin
    member := AType.Members[i];

    case member.GetNodeKind of
      tnkConstDecl:     AnalizeConst(TLMDPasConstDecl(member));
      tnkVarDecl:       AnalizeVar(TLMDPasVarDecl(member));
      tnkProcHeading:   AnalizeProc(TLMDPasProcHeading(member));
      tnkOverloadGroup: AnalizeOverloadGroup(TLMDPasOverloadGroup(member));
      tnkProperty:      AnalizeProperty(TLMDPasProperty(member));
    else
      Assert(False);
    end;
  end;

  AddUncheckedInfo(AType.Members, ATypeName);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AnalizeClassMembers(const ATypeName: string;
  AType: TLMDPasClassType);
var
  i:      Integer;
  member: TLMDPasNamedNode;
begin
  for i := 0 to AType.Members.Count - 1 do
  begin
    member := AType.Members[i];

    case member.GetNodeKind of
      tnkConstDecl:         AnalizeConst(TLMDPasConstDecl(member));
      tnkVarDecl:           AnalizeVar(TLMDPasVarDecl(member));
      tnkProcHeading:       AnalizeProc(TLMDPasProcHeading(member));

      tnkOverloadGroup:     AnalizeOverloadGroup(TLMDPasOverloadGroup(member));
      tnkProperty:          AnalizeProperty(TLMDPasProperty(member));
      tnkPropertyRedecl:    AnalizePropRedecl(TLMDPasPropertyRedecl(member));
    else
      Assert(False);
    end;
  end;

  AddUncheckedInfo(AType.Members, ATypeName);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AnalizeProperty(AProp: TLMDPasProperty);
begin
  AProp.C_SupportKind := GetTypeRefSupportKind(AProp.Type_, SLMDCompPropertyType,
                                               AProp);
  CombState(AProp, GetParamsSupportKind(AProp.Parameters, AProp));
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasAnalizer.AnalizePropRedecl(ARedecl: TLMDPasPropertyRedecl);
begin
  ARedecl.C_SupportKind := skYes; // No analize.
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasAnalizer.GetParamsSupportKind(AParams: TLMDPasParameters;
  AMessageObject: TLMDPasNamedNode): TLMDSupportKind;
var
  i: Integer;
begin
  Result := skYes;
  for i := 0 to AParams.Count - 1 do
    CombState(Result, GetParamSupportKind(AParams[i], AMessageObject));
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasAnalizer.GetParamSupportKind(AParam: TLMDPasParameter;
  AMessageObject: TLMDPasNamedNode): TLMDSupportKind;
begin
  Result := skYes;

  if AParam.IsArrayOfConst then
  begin
    Result := skNo;
    AddError(Format(SLMDCompParameter, [AParam.Name]) +
             SLMDCompOpenArraysNotSupp,
             AMessageObject);
    Exit;
  end;

  if not AParam.IsArrayOfConst and (AParam.Type_ = nil) then
  begin
    Result := skNo;
    AddError(Format(SLMDCompParameter, [AParam.Name]) +
             SLMDCompUntypedParamNotSupp,
             AMessageObject);
    Exit;
  end;

  if AParam.Type_ <> nil then 
  begin
    CombState(Result, GetTypeRefSupportKind(AParam.Type_,
                                            Format(SLMDCompParameter, [AParam.Name]),
                                            AMessageObject));
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasAnalizer.GetTypeDeclSupportKind(AType: TLMDPasType;
  const AMessagePrefix: string; AMessageObject: TLMDPasNamedNode): TLMDSupportKind;
var
  rec:  TLMDPasRecordType;
  cls:  TLMDPasClassType;
  proc: TLMDPasProcType;
  tpid: TLMDPasTypeId;
begin
  case AType.GetNodeKind of
    tnkSubrangeType:      Result := skYes;
    tnkTypeId:            begin
                            tpid := AType as TLMDPasTypeId;

                            if tpid.IsTemplate then
                            begin
                              Result := skNo;
                              AddError(AMessagePrefix + SLMDCompTemplatesNotSupp,
                                       AMessageObject);
                            end
                            else
                              Result := GetTypeIdSupportKind(tpid.QualName,
                                                             AMessagePrefix +
                                                             SLMDCompTypeAlias,
                                                             AMessageObject);
                          end;
    tnkEnumType:          Result := skYes;
    tnkClassRefType:      Result := GetTypeRefSupportKind(
                                        (AType as TLMDPasClassRefType).BaseType,
                                        AMessagePrefix,
                                        AMessageObject);
    tnkSetType:           Result := GetTypeRefSupportKind(
                                        (AType as TLMDPasSetType).BaseType,
                                        AMessagePrefix,
                                        AMessageObject);
    tnkRecordType:        begin
                            Result := skYes;
                            rec    := AType as TLMDPasRecordType;

                            if rec.HelperFor <> nil then
                            begin
                              Result := skNo;
                              AddError(AMessagePrefix + SLMDCompHelpersNotSupp,
                                       AMessageObject);
                            end;
                          end;
    tnkClassType:         begin
                            Result := skYes;
                            cls    := AType as TLMDPasClassType;

                            if cls.HelperFor <> nil then
                            begin
                              Result := skNo;
                              AddError(AMessagePrefix + SLMDCompHelpersNotSupp,
                                       AMessageObject);
                            end
                            else if cls.Ancestor <> nil then
                            begin
                              if cls.Ancestor.IsTemplate then
                              begin
                                Result := skNo;
                                AddError(AMessagePrefix + SLMDCompAncestorType +
                                         SLMDCompTemplatesNotSupp, AMessageObject);
                              end
                              else
                                Result := GetTypeIdSupportKind(cls.Ancestor.QualName,
                                                               AMessagePrefix +
                                                               SLMDCompAncestorType,
                                                               AMessageObject);
                            end;
                          end;
    tnkProcType:          begin
                            Result := skYes;
                            proc   := AType as TLMDPasProcType;

                            if not proc.OfObject then
                            begin
                              Result := skNo;
                              AddError(AMessagePrefix + SLMDCompNObjProcTypesNotSupp,
                                       AMessageObject);
                            end
                            else if proc.IsRefTo then
                            begin
                              Result := skNo;
                              AddError(AMessagePrefix + SLMDCompRefToTypesNotSupp,
                                       AMessageObject);
                            end;

                            CombState(Result, GetParamsSupportKind(
                                            (AType as TLMDPasProcType).Parameters,
                                            AMessageObject));

                            if (AType as TLMDPasProcType).ReturnType <> nil then
                            begin
                              CombState(Result, GetTypeRefSupportKind(
                                              (AType as TLMDPasProcType).ReturnType,
                                              AMessagePrefix + SLMDCompReturnType,
                                              AMessageObject));
                            end;
                          end;
    tnkPointerType:       begin
                            Result := skNo;
                            AddError(AMessagePrefix + SLMDCompPointersNotSupp,
                                     AMessageObject);
                          end;
    tnkFileType:          begin
                            Result := skNo;
                            AddError(AMessagePrefix + SLMDCompFileTypesNotSupp,
                                     AMessageObject);
                          end;
    tnkStaticArrayType,
    tnkDynamicArrayType:  begin
                            Result := skNo;
                            AddError(AMessagePrefix + SLMDCompArraysNotSupp,
                                     AMessageObject);
                          end;
    tnkInterfaceType:     begin
                            Result := skNo;
                            AddError(AMessagePrefix + SLMDCompInterfacesNotSupp,
                                     AMessageObject);
                          end;
  else
    Assert(False);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasAnalizer.GetTypeRefSupportKind(AType: TLMDPasType;
  const AMessagePrefix: string;
  AMessageObject: TLMDPasNamedNode): TLMDSupportKind;
var
  s:    string;
  tpid: TLMDPasTypeId;
begin
  case AType.GetNodeKind of
    tnkTypeId:            begin
                            tpid := AType as TLMDPasTypeId;

                            if tpid.IsTemplate then
                            begin
                              Result := skNo;
                              AddError(AMessagePrefix + SLMDCompTemplatesNotSupp,
                                       AMessageObject);
                            end
                            else
                              Result := GetTypeIdSupportKind(tpid.QualName,
                                                             AMessagePrefix,
                                                             AMessageObject);
                          end;
    tnkPointerType:       begin
                            Result := skNo;
                            AddError(AMessagePrefix + SLMDCompPointersNotSupp,
                                     AMessageObject);
                          end;
    tnkFileType:          begin
                            Result := skNo;
                            AddError(AMessagePrefix + SLMDCompFileTypesNotSupp,
                                     AMessageObject);
                          end;
    tnkStaticArrayType,
    tnkDynamicArrayType:  begin
                            Result := skNo;
                            AddError(AMessagePrefix + SLMDCompArraysNotSupp,
                                     AMessageObject);
                          end;
    tnkInterfaceType:     begin
                            Result := skNo;
                            AddError(AMessagePrefix + SLMDCompInterfacesNotSupp,
                                     AMessageObject);
                          end;
  else
    s := '';
    case AType.GetNodeKind of
      tnkSubrangeType:   s := 'subrange';
      tnkEnumType:       s := 'enum';
      tnkProcType:       s := 'procedural';
      tnkClassRefType:   s := 'class-ref';
      tnkSetType:        s := 'set';
      tnkRecordType:     s := 'record';
      tnkClassType:      s := 'class';
    else
      Assert(False);
    end;
    Result := skNo;
    AddError(AMessagePrefix + Format(SLMDCompUnnamedTypesNotSupp, [s]),
             AMessageObject);
  end;
end;
{ ---------------------------------------------------------------------------- }


function TLMDPasAnalizer.IsOverloadPairSupported(AProcA,
  AProcB: TLMDPasProcHeading): Boolean;
var
  pmin, pmax: Integer;
  cmin, cmax: Integer;
begin
  Result := True;
  pmax   := AProcA.Parameters.Count;
  pmin   := pmax - AProcA.Parameters.OptionalCount;
  cmax   := AProcB.Parameters.Count;
  cmin   := cmax - AProcB.Parameters.OptionalCount;

  if (pmax >= cmin) and (pmin <= cmax) then
    Result := False;
  if AProcA.FuncKind <> AProcB.FuncKind then
    Result := False;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasAnalizer.GetTypeIdSupportKind(const AQualName: string;
  const AMessagePrefix: string; AMessageObject: TLMDPasNamedNode): TLMDSupportKind;
var
  pasnd:  TLMDPasNamedNode;
  uudata: TLMDUsedUnitData;
  uuitem: TLMDUsedUnitItem;
  uname,
  tname:  string;
begin
  ParseQualName(AQualName, uname, tname);
  pasnd := nil;

  { Search in current unit }

  if SameText(uname, FUnit.Name) or (uname = '') then
    pasnd := FUnit.Declarations.Find(tname);

  if pasnd <> nil then
  begin
    { Declaration is found in current unit }

    if pasnd is TLMDPasTypeDecl then
    begin
      { Declaration is a type }

      if FDocument.NodeChecked[pasnd] then
      begin
        Result := pasnd.C_SupportKind;
        case Result of
          skNo:       AddError(AMessagePrefix + Format(SLMDCompDeclHasErrors,
                               [AQualName]), AMessageObject);
          skUnknown:  AddWarning(AMessagePrefix + Format(SLMDCompDeclHasWarnings,
                                 [AQualName]), AMessageObject);
        end;
      end
      else
      begin
        Result := skNo;
        AddError(AMessagePrefix + Format(SLMDCompDeclHasBeenUnchecked,
                 [AQualName]), AMessageObject);
      end;
    end
    else
    begin
      { Declaration is not a type }

      Result := skNo;
      AddError(AMessagePrefix + Format(SLMDCompDeclNotType, [AQualName]),
               AMessageObject);
    end;

    Exit; // Handled.
  end;

  { Declaration is not found. Search in used units }

  if uname <> '' then
  begin
    uudata := FindUsedUnit(uname);
    if uudata <> nil then
      uuitem := uudata.Find(tname)
    else
      uuitem := nil;
  end
  else
    uuitem := FindIdInUsedUnits(tname);

  if uuitem <> nil then
  begin
    if uuitem.Checked then
    begin
      Result := uuitem.SupportKind;

      case Result of
        skNo:       AddError(AMessagePrefix + Format(SLMDCompDeclHasErrors,
                             [AQualName]), AMessageObject);
        skUnknown:  AddWarning(AMessagePrefix + Format(SLMDCompDeclHasWarnings,
                               [AQualName]), AMessageObject);
      end;
    end
    else
    begin
      Result := skNo;
      AddError(AMessagePrefix + Format(SLMDCompDeclHasBeenUnchecked,
               [AQualName]), AMessageObject);
    end;

    Exit; // Handled.
  end;

  { Declaration is not found. Check in predefined symbols }

  if SameText(uname, 'System') or (uname = '') then
    Result := GetPredefinedSymbolSupportKind(tname)
  else
    Result := skUnknown; // Not found anywhere.

  case Result of
    skNo:       AddError(AMessagePrefix + Format(SLMDCompDeclNotSupp,
                         [AQualName]), AMessageObject);
    skUnknown:  AddWarning(AMessagePrefix + Format(SLMDCompDeclNotFound,
                           [AQualName]), AMessageObject);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasAnalizer.FindIdInUsedUnits(
  const AFullName: string): TLMDUsedUnitItem;
var
  i: Integer;
begin
  for i := FUsedUnits.Count - 1 downto 0 do // Reverse scanning.
  begin
    Result := TLMDUsedUnitData(FUsedUnits[i]).Find(AFullName);
    if Result <> nil then
      Exit;
  end;
  Result := nil;
end;
    
{ ---------------------------------------------------------------------------- }

function TLMDPasAnalizer.FindUsedUnit(
  const AUnitName: string): TLMDUsedUnitData;
var
  i: Integer;
begin
  for i := FUsedUnits.Count - 1 downto 0 do // Reverse scanning.
    if SameText(TLMDUsedUnitData(FUsedUnits[i]).PasUnit.Name, AUnitName) or
       SameText(TLMDUsedUnitData(FUsedUnits[i]).PasUnit.C_FullName, AUnitName) then
    begin
      Result := TLMDUsedUnitData(FUsedUnits[i]);
      Exit;
    end;
  Result := nil;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDPasAnalizer.Create(ADocument: TLMDUnitDocument);
begin
  inherited Create;
  FUsedUnits := TList.Create;;
  FDocument  := ADocument;
  FUnit      := ADocument.ParseTree;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDPasAnalizer.Destroy;
begin
  ClearUsedUnits;
  FUsedUnits.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasAnalizer.Analize: Boolean;
begin
  FDocument.Iterate(ClearProc, nil);
  FUnitErrorCount := 0;
  ClearUsedUnits;

  AnalizeUnit;

  Result := (FUnitErrorCount = 0);
end;

{************************** class TLMDUsedUnitWriter **************************}
{ --------------------------------- protected -------------------------------- }

procedure TLMDUsedUnitWriter.WriteUnit;
var
  i: Integer;
begin
  for i := 0 to FUnit.Declarations.Count - 1 do
    WriteUnitDeclaration(FUnit.Declarations[i]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitWriter.WriteUnitDeclaration(ADecl: TLMDPasNamedNode);
begin
  case ADecl.GetNodeKind of
    tnkConstDecl:     ; // Do nothing.
    tnkTypeDecl:      WriteTypeDecl(TLMDPasTypeDecl(ADecl));
    tnkVarDecl:       ; // Do nothing.
    tnkProcHeading:   ; // Do nothing.
    tnkOverloadGroup: ; // Do nothing.
  else
    Assert(False);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitWriter.WriteTypeDecl(ADecl: TLMDPasTypeDecl);
var
  i:       Integer;
  members: TLMDPasNamedNodes;
begin
  AddLine(0, 'T', ADecl.Name, FDocument.NodeChecked[ADecl],
          ADecl.C_SupportKind);

  if ADecl.Type_ is TLMDPasClassType then
  begin
    members := TLMDPasClassType(ADecl.Type_).Members;

    for i := 0 to members.Count - 1 do
      case members[i].GetNodeKind of
        tnkProperty:        WriteProperty(TLMDPasProperty(members[i]));
        tnkPropertyRedecl:  WritePropRedecl(TLMDPasPropertyRedecl(members[i]));
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitWriter.WriteProperty(AProp: TLMDPasProperty);
begin
  AddLine(1, 'P', AProp.Name, FDocument.NodeChecked[AProp],
          AProp.C_SupportKind);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitWriter.WritePropRedecl(ARedecl: TLMDPasPropertyRedecl);
begin
  AddLine(1, 'P', ARedecl.Name, FDocument.NodeChecked[ARedecl],
          ARedecl.C_SupportKind);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitWriter.AddLine(AIdent: Integer; const AElemKind: Char;
  const AName: string; AChecked: Boolean; ASupportKind: TLMDSupportKind);
var
  i:    Integer;
  line: string;
  c:    Char;
begin
  line := '';
  for i := 0 to AIdent - 1 do
    line := line + '        ';

  line := line + AElemKind;

  c := ' '; // Initialize.
  if (ASupportKind = skYes) and not AChecked then
    c := '-'
  else
    case ASupportKind of
      skYes:      c := '+';
      skNo:       c := 'E';
      skUnknown:  c := 'W';
    end;

  line := line + c + ': ' + AName;

  FLines.Add(line);
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDUsedUnitWriter.Create(ADocument: TLMDUnitDocument);
begin
  inherited Create;
  FLines    := TStringList.Create;
  FDocument := ADocument;
  FUnit     := ADocument.ParseTree;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDUsedUnitWriter.Destroy;
begin
  FLines.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitWriter.SaveToStream(AStream: TStream);
begin
  FLines.Clear;
  WriteUnit;
  FLines.SaveToStream(AStream);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitWriter.SaveToFile(const AFileName: string);
var
  stream: TFileStream;
begin
  stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(stream);
  finally
    stream.Free;
  end;
end;

{************************** class TLMDUsedUnitReader **************************}

{ --------------------------------- protected -------------------------------- }

function TLMDUsedUnitReader.CurLine: string;
begin
  Result := Trim(FLines[FIndex]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitReader.SkipLine;
begin
  Inc(FIndex);
end;

{ ---------------------------------------------------------------------------- }

function TLMDUsedUnitReader.Eof: Boolean;
begin
  Result := (FIndex >= FLines.Count);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitReader.InvalidFormatError;
begin
  raise ELMDInvalidFileFormat.Create(SLMDDocInvalidFileFormat);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitReader.ReadUnit;
begin
  while not Eof do
    ReadType;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitReader.ReadType;
var
  line:        string;
  checked:     Boolean;
  supportKind: TLMDSupportKind;
  name:        string;
begin
  line := CurLine;
  if LineKind(line) <> lkType then
    InvalidFormatError;

  GetParams(line, checked, supportKind, name);
  FData.Add(name, checked, supportKind);
  SkipLine;

  while not Eof and (LineKind(CurLine) = lkProperty) do
    ReadProperty(name);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitReader.ReadProperty(const AParentName: string);
var
  line:        string;
  checked:     Boolean;
  supportKind: TLMDSupportKind;
  name:        string;
begin
  line := CurLine;
  if LineKind(line) <> lkProperty then
    InvalidFormatError;

  GetParams(line, checked, supportKind, name);
  FData.Add(AParentName + '.' + name, checked, supportKind);
  SkipLine;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitReader.SkipBlanks(const s: string; var i: Integer);
begin
  while (Length(s) >= i) and (s[i] = ' ') do
    Inc(i);
end;

{ ---------------------------------------------------------------------------- }

function TLMDUsedUnitReader.LineKind(
  const ALine: string): TLMDUsedUnitReaderLineKind;
begin
  Result := lkUnknown;
  if Length(ALine) <> 0 then
    case ALine[1] of
      'T': Result := lkType;
      'P': Result := lkProperty;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUsedUnitReader.GetParams(const ALine: string;
  out AChecked: Boolean; out ASupportKind: TLMDSupportKind; out AName: string);
var
  i: Integer;
  c: Char;
begin
  if Length(ALine) < 2 then
    InvalidFormatError;
  c := ALine[2];

  if c = '-' then
  begin
    AChecked     := False;
    ASupportKind := skYes;
  end
  else
  begin
    AChecked := True;
    case c of
      '+': ASupportKind := skYes;
      'E': ASupportKind := skNo;
      'W': ASupportKind := skUnknown;
    else
      InvalidFormatError;
    end;
  end;

  i := 3;
  SkipBlanks(ALine, i);

  if (i > Length(ALine)) or (ALine[i] <> ':') then
    InvalidFormatError;
  Inc(i);
  SkipBlanks(ALine, i);

  AName := Trim(Copy(ALine, i, MaxInt));
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDUsedUnitReader.Create(AAnalizer: TLMDPasAnalizer);
begin
  inherited Create;
  FAnalizer := AAnalizer;
  FLines    := TStringList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDUsedUnitReader.Destroy;
begin
  FLines.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUsedUnitReader.LoadFromStream(AStream: TStream): TLMDUsedUnitData;
begin
  FLines.Clear;
  FLines.LoadFromStream(AStream);
  FIndex := 0;

  FData := TLMDUsedUnitData.Create(FAnalizer);
  try
    ReadUnit;
  except
    FData.Free;
    FData := nil;
    raise;
  end;

  Result := FData;

  FLines.Clear; // Free memory.
  FData := nil;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUsedUnitReader.LoadFromFile(
  const AFileName: string): TLMDUsedUnitData;
var
  stream: TFileStream;
begin
  stream := TFileStream.Create(AFileName, fmOpenRead);
  try
    Result := LoadFromStream(stream);
  finally
    stream.Free;
  end;
end;

{*********************** class TLMDPasWrapperGenerator ************************}
{ --------------------------------- protected -------------------------------- }

procedure TLMDPasWrapperGenerator.AddLine(const S: string;
  APasSplitKind: TLMDPasSplitKind);
const
  RIGHT_MARGIN = 80;
var
  i:          Integer;
  ident:      string;
  cur:        string;
  line:       string;
  splitidx:   Integer;
  linesAdded: Integer;
begin
  SetLength(ident, FCurIdent * 2);
  for i := 1 to FCurIdent * 2 do
    ident[i] := ' ';

  if APasSplitKind = skNone then
  begin
    FLines.Add(ident + S);
  end
  else
  begin
    cur        := S;
    splitidx   := GetSplitPos(cur, RIGHT_MARGIN - Length(ident), APasSplitKind);
    linesAdded := 0;

    while splitidx <> -1 do
    begin
      line := Copy(cur, 1, splitidx - 1);
      if linesAdded <> 0 then // Do not trim first line, it
                              // can begin with spaces.
        line := Trim(line);

      FLines.Add(ident + line);

      cur       := Copy(cur, splitidx, MaxInt);
      splitidx  := GetSplitPos(cur, RIGHT_MARGIN - Length(ident), APasSplitKind);

      if (linesAdded = 0) and (APasSplitKind in [skDecl, skBody]) then
        ident := ident + '  '; // Next lines wil be shifted.

      Inc(linesAdded);
    end;

    line := cur;
    if linesAdded <> 0 then // Do not trim first line, it
                            // can begin with spaces.
      line := Trim(line);
    if line <> '' then
      FLines.Add(ident + line);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.EmptyLine;
begin
  if FLines.Count <> FCurEmptyLine then
  begin
    FLines.Add('');
    FCurEmptyLine := FLines.Count;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.BeginIdent;
begin
  Inc(FCurIdent);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.EndIdent;
begin
  Dec(FCurIdent);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetSplitPos(const S: string;
  AMaxLength: Integer; APasSplitKind: TLMDPasSplitKind): Integer;
const
  USES_CHARS = [',']; // Space is not delimiter here, becouse of IFDEFs.
  DECL_CHARS = [',', ';', '('];
  BODY_CHARS = [' ', ',', ';', '.', '+', '-', '*', '/', '(', '<', '>', '='];
var
  i:    Integer;
  cset: set of AnsiChar;
begin
  if Length(S) <= AMaxLength then
  begin
    Result := -1;
    Exit;
  end;

  case APasSplitKind of
    skUses: cset := USES_CHARS;
    skDecl: cset := DECL_CHARS;
    skBody: cset := BODY_CHARS;
  else
    cset := []; // Initialize.
  end;


  for i := AMaxLength downto 1 do
    if AnsiChar(S[i]) in cset then
    begin
      Result := i + 1; // Split starting from next char.
      Exit;
    end;
  Result := -1;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenUnit;
begin
  FResultUnitName := GetWrapperUnitName(Unit_.Name);

  AddLine('unit ' + FResultUnitName + ';');

  EmptyLine;
  AddLine('{$WARNINGS OFF}');
  AddLine('{$I LMDSctWrappers.inc}');

  if SameText(Unit_.Name, 'System') then
  begin
    EmptyLine;
    AddLine('  ##############################################################################');
    AddLine('  #');
    AddLine('  # ERROR: This is a dummy placeholder for Delphi ''System'' unit wrappers.');
    AddLine('  #        Do not use this file. Use ''LMDSctSysWrappers'' unit instead.');
    AddLine('  ##############################################################################');
  end;

  EmptyLine;
  AddLine('{');
  AddLine('  ##############################################################################');
  AddLine('  #');
  AddLine('  # LMD Script Pack wrappers for ''' + Unit_.Name + ''' unit.');
  AddLine('  #');
  AddLine('  # WARNING:');
  AddLine('  #  This file was generated automatically by LMD Script Pack Importer. If the');
  AddLine('  #  unit will be reimported, the contents of this file will be regenerated');
  AddLine('  #  and all manual modifications will be lost.');
  AddLine('  ##############################################################################');
  AddLine('}');

  EmptyLine;
  GenInterfaceSection;

  EmptyLine;
  GenImplementationSection;

  EmptyLine;
  AddLine('initialization');
  BeginIdent;
  GenUnitWrapperReg;
  if HasClassWrapperRegs then
    GenClassWrapperRegs;
  if HasEventWrapperRegs then
    GenEventWrapperRegs;
  EndIdent;

  EmptyLine;
  AddLine('end.');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenInterfaceSection;
begin
  AddLine('interface');
  EmptyLine;
  GenUsesClause;
  if HasTypeWrappers then
  begin
    EmptyLine;
    AddLine('');
    AddLine('{ Type wrappers }');
    EmptyLine;
    GenIntfTypeWrappers;
  end;

  EmptyLine;
  AddLine('');
  AddLine('{ Unit wrapper }');
  EmptyLine;
  GenIntfUnitWrapper;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplementationSection;
begin
  AddLine('implementation');

  if HasProtectedProps then
  begin
    EmptyLine;
    GenProtectedPropHandlers;
  end;

  if HasTypeWrappers then
  begin
    EmptyLine;
    GenImplTypeWrappers;
  end;

  EmptyLine;
  GenImplUnitWrapper;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenUsesClause;

  function _IsInList(const AUnitName: string; List: TStrings): Boolean;
  var
    i: Integer;
  begin
    for i := 0 to List.Count - 1 do
      if SameText(List[i], AUnitName) then
      begin
        Result := True;
        Exit;
      end;
    Result := False;
  end;

var
  i, j:     Integer;
  uunit:    TLMDPasUsedUnit;
  stdunits: TStrings;
  unitlist: TStrings;
  line:     string;
  found:    Boolean;
begin
  stdunits := TStringList.Create;
  unitlist := TStringList.Create;
  FDocument.GetStandardWrapperUsedUnits(stdunits);
  try
    { Generate uses clause }

    AddLine('uses');
    BeginIdent;

    for i := 0 to stdunits.Count - 1 do
    begin
      found := false;
      for j := 0 to Unit_.Uses_.Count - 1 do
      begin
        uunit := Unit_.Uses_[j];
        if not FDocument.NodeChecked[uunit] then
          Continue;

        found := SameText(uunit.C_FullName, stdunits[i]);
        if found then
          Break;
      end;

      if not found then
        unitlist.Add(stdunits[i]);
    end;

    stdunits.Assign(unitlist);
    line := '';

    for i := 0 to stdunits.Count - 1 do
      AddUsesUnit(stdunits[i], line);

    for i := 0 to Unit_.Uses_.Count - 1 do
    begin
      uunit := Unit_.Uses_[i];
      if not FDocument.NodeChecked[uunit] then
        Continue;

      if not SameText(uunit.Name, 'System') then
        AddUsesUnit(uunit.Name, line);
    end;

    if not _IsInList(FUnit.Name, stdunits) then // Add itself last.
      AddUsesUnit(FUnit.Name, line);

    for i := 0 to Unit_.Uses_.Count - 1 do
    begin
      uunit := Unit_.Uses_[i];
      if not FDocument.NodeChecked[uunit] then
        Continue;

      if not SameText(uunit.Name, 'System') then
        AddUsesUnit(GetWrapperUnitName(uunit.Name), line);
    end;

    AddLine(line + ';', skUses);

    EndIdent;
  finally
    stdunits.Free;
    unitlist.Free;
  end;
end;
    
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.AddUsesUnit(const AUnitName: string;
  var AUses: string);
begin
  if AUses <> '' then
    AUses := AUses + ', ';
  AUses := AUses + AUnitName;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.HasTypeWrappers: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Unit_.Declarations.Count - 1 do
  begin
    if (Unit_.Declarations[i].GetNodeKind = tnkTypeDecl) and
       Document.NodeChecked[Unit_.Declarations[i]] then
    begin
      Result := True;
      Break;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.HasUnitLevelDecl: Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Unit_.Declarations.Count - 1 do
  begin
    if Document.NodeChecked[Unit_.Declarations[i]] then
    begin
      Result := True;
      Break;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenIntfUnitWrapper;
begin
  AddLine('type');
  BeginIdent;

  AddLine(GetWrapperTypeName(GetUnitUnprefixedName) + ' = class(TLMDUnitWrapper)');
  if HasUnitLevelDecl then
  begin
    AddLine('protected');
    AddLine('  class procedure DoInit(AData: TLMDUnitWrapperData); override;');
  end;
  AddLine('public');
  AddLine('  class function  GetUnitName: WideString; override;');
  AddLine('  class function  ToVar(AScriptControl: TLMDScriptControl): OleVariant;');
  AddLine('end;');

  EndIdent;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenInvokerVarSection(
  AMember: TLMDPasNamedNode);
var
  i:      Integer;
  params: TList;
  param:  TLMDPasParameter;
  idx:    Integer;
begin
  params := TList.Create;
  try
    GetAllVarOutParams(AMember, params);

    if params.Count <> 0 then
    begin
      AddLine('var');
      BeginIdent;

      idx := 1;
      for i := 0 to params.Count - 1 do
      begin
        param           := TLMDPasParameter(params[i]);
        param.C_VarName := 'v_' + IntToStr(idx);
        Inc(idx);

        AddLine(param.C_VarName + ': ' + GenTypeReuseStr(param.Type_) + ';');
      end;

      EndIdent;
    end;
  finally
    params.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplUnitWrapper;
var
  wname: string;
begin
  wname := GetWrapperTypeName(GetUnitUnprefixedName);

  GenTypeImplComment(wname);
  GenImplMembersInvokers(GetUnitUnprefixedName, FUnit.Name, '', FUnit.Declarations);

  EmptyLine;

  AddLine('class function ' + wname + '.GetUnitName: WideString;', skDecl);
  AddLine('begin');
  AddLine('  Result := ''' + GetUnitUnprefixedName + ''';');
  AddLine('end;');

  if HasUnitLevelDecl then
  begin
    EmptyLine;

    AddLine('class procedure ' + wname + '.DoInit(AData: TLMDUnitWrapperData);',
            skDecl);
    GenUnitDoInitBody;
  end;

  EmptyLine;

  AddLine('class function ' + wname +
          '.ToVar(AScriptControl: TLMDScriptControl): OleVariant;', skDecl);
  AddLine('begin');
  BeginIdent;
  AddLine('Result := AScriptControl.GetUnitInstance(' +
          GetWrapperTypeName(GetUnitUnprefixedName) + ');',
          skDecl);
  EndIdent;
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenUnitWrapperReg;
begin
  AddLine('RegisterUnitWrapper(' +
    GetWrapperTypeName(GetUnitUnprefixedName) + ');');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenUnitDoInitBody;
var
  i:      Integer;
  member: TLMDPasNamedNode;
begin
  AddLine('begin');
  BeginIdent;

  for i := 0 to FUnit.Declarations.Count - 1 do
  begin
    member := FUnit.Declarations[i];
    if FDocument.NodeChecked[member] then
      GenUnitMemberDoInit(member);
  end;

  EndIdent;
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenUnitMemberDoInit(
  AMember: TLMDPasNamedNode);
const
  BOOLS: array[Boolean] of string = ('False', 'True');
var
  s:     string;
  proc:  TLMDPasProcHeading;
  group: TLMDPasOverloadGroup;
  cst:   TLMDPasConstDecl;
  var_:  TLMDPasVarDecl;
  tpr:   string;
  invr:  string;
begin
  invr := GetUnitUnprefixedName + '_' + AMember.Name + '_si';

  case AMember.GetNodeKind of
    tnkConstDecl:       begin
                          cst := TLMDPasConstDecl(AMember);
                          s   := '';

                          case cst.Kind of
                            ckTyped:  s := 'AData.AddConstant(''' + cst.Name +
                                           ''', ' + invr + ', ' +
                                           GenTypeWrapperRef(cst.Type_) + ');';
                            ckSimple: s := 'AData.AddConstant(''' + cst.Name +
                                           ''', ' + invr + ', nil, VarType(' +
                                           FUnit.Name + '.' + cst.Name + '));';
                            ckNil:    s := 'AData.AddConstant(''' + cst.Name +
                                           ''', ' + invr + ', nil, varDispatch);';
                            ckSet:    s := 'AData.AddConstant(''' + cst.Name +
                                           ''', ' + invr + ', nil, varInteger);';
                          else // ckUnknown
                            tpr := FDocument.ConstTypeRepl[cst];
                            if tpr <> '' then
                              s := 'AData.AddConstant(''' + cst.Name +
                                    ''', ' + invr + ', ' +
                                    GenTypeIdWrapperRef(tpr) + ');';
                          end;

                          AddLine(s);
                        end;
    tnkVarDecl:         begin
                          var_ := TLMDPasVarDecl(AMember);
                          s    := 'AData.AddVariable(''' + var_.Name + ''', ' +
                                  invr + ', ' + GenTypeWrapperRef(var_.Type_) +
                                  ');';
                          AddLine(s);
                        end;
    tnkProcHeading:     begin
                          proc := TLMDPasProcHeading(AMember);
                          s    := GenProcDoInit(proc.Name, invr, proc.FuncKind,
                                                proc.Parameters.Count,
                                                proc.Parameters.OptionalCount,
                                                proc.ReturnType);
                          AddLine(s);
                        end;
    tnkOverloadGroup:   begin
                          group := TLMDPasOverloadGroup(AMember);
                          s     := GenProcDoInit(group.Name, invr,
                                                 group.C_FuncKind,
                                                 group.C_ParamCount,
                                                 group.C_OptionalCount,
                                                 nil);
                           AddLine(s);
                        end;
    tnkTypeDecl:        AddLine('AData.AddType(' + GetWrapperTypeName(AMember.
                                Name) + ', ' + invr + ');');
  else
    Assert(False);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetProtectedProps(
  AType: TLMDPasClassType; AResult: TList): Boolean;
var
  i: Integer;
begin
  Result := False;

  for i := 0 to AType.Members.Count - 1 do
    if FDocument.NodeChecked[AType.Members[i]] and
       IsProtectedProp(AType.Members[i]) then
    begin
      Result := True;
      if AResult <> nil then
        AResult.Add(AType.Members[i]);
    end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.HasProtectedProps: Boolean;
var
  i: Integer;
  decl: TLMDPasNamedNode;
  tpd:  TLMDPasTypeDecl;
begin
  for i := 0 to FUnit.Declarations.Count - 1 do
  begin
    decl := FUnit.Declarations[i];
    if FDocument.NodeChecked[decl] and (decl.GetNodeKind = tnkTypeDecl) then
    begin
      tpd := TLMDPasTypeDecl(decl);
      if (tpd.Type_.GetNodeKind = tnkClassType) and
         GetProtectedProps(TLMDPasClassType(tpd.Type_), nil) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;
  Result := False;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenProtectedAccessorType(
  AType: TLMDPasTypeDecl);
begin
  AddLine(GetProtectedAccessorName(AType.Name) + ' = class(' +
          AType.Name + ');');
end;
                               
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenProtectedPropHandlers;
var
  i:    Integer;
  decl: TLMDPasNamedNode;
  tpd:  TLMDPasTypeDecl;
begin
  AddLine('{ Protected property accessors }');
  EmptyLine;

  AddLine('type');
  BeginIdent;

  for i := 0 to FUnit.Declarations.Count - 1 do
  begin
    decl := FUnit.Declarations[i];
    if FDocument.NodeChecked[decl] and (decl.GetNodeKind = tnkTypeDecl) then
    begin
      tpd := TLMDPasTypeDecl(decl);

      if (tpd.Type_.GetNodeKind = tnkClassType) and
         GetProtectedProps(TLMDPasClassType(tpd.Type_), nil) then
        GenProtectedAccessorType(tpd);
    end;
  end;

  EndIdent; // type
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.HasClassWrapperRegs: Boolean;
var
  i:    Integer;
  decl: TLMDPasNamedNode;
begin
  for i := 0 to FUnit.Declarations.Count - 1 do
  begin
    decl := FUnit.Declarations[i];
    if FDocument.NodeChecked[decl] and (decl.GetNodeKind = tnkTypeDecl) and
       (TLMDPasTypeDecl(decl).Type_.GetNodeKind = tnkClassType) then
    begin
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenClassWrapperRegs;
var
  i:    Integer;
  decl: TLMDPasNamedNode;
begin
  for i := 0 to FUnit.Declarations.Count - 1 do
  begin
    decl := FUnit.Declarations[i];
    if FDocument.NodeChecked[decl] and (decl.GetNodeKind = tnkTypeDecl) and
       (TLMDPasTypeDecl(decl).Type_.GetNodeKind = tnkClassType) then
    begin
      AddLine('RegisterClassWrapper(' + GetWrapperTypeName(decl.Name) + ');');
    end;
  end;
end;
                    
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.HasEventWrapperRegs: Boolean;
var
  i:    Integer;
  decl: TLMDPasNamedNode;
begin
  for i := 0 to FUnit.Declarations.Count - 1 do
  begin
    decl := FUnit.Declarations[i];
    if FDocument.NodeChecked[decl] and (decl.GetNodeKind = tnkTypeDecl) and
       (TLMDPasTypeDecl(decl).Type_.GetNodeKind = tnkProcType) then
    begin
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;
                                     
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenEventWrapperRegs;
var
  i:    Integer;
  decl: TLMDPasNamedNode;
begin
  for i := 0 to FUnit.Declarations.Count - 1 do
  begin
    decl := FUnit.Declarations[i];
    if FDocument.NodeChecked[decl] and (decl.GetNodeKind = tnkTypeDecl) and
       (TLMDPasTypeDecl(decl).Type_.GetNodeKind = tnkProcType) then
    begin
      AddLine('RegisterEventWrapper(TypeInfo(' + decl.Name +
              '), ' + GetWrapperTypeName(decl.Name) + ');');
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenIntfTypeWrappers;
var
  i:        Integer;
  decl:     TLMDPasNamedNode;
  type_:    TLMDPasType;
  s:        string;
  needline: Boolean;
  wrr:      string;
begin
  { Does we have types to generate? }

  if not HasTypeWrappers then
    Exit;

  { Generate type section }

  AddLine('type');
  BeginIdent;

  needline := False;

  for i := 0 to Unit_.Declarations.Count - 1 do
  begin
    decl := Unit_.Declarations[i];

    if (decl.GetNodeKind = tnkTypeDecl) and Document.NodeChecked[decl] then
    begin
      type_ := TLMDPasTypeDecl(decl).Type_;

      if (type_ is TLMDPasClassType) or (type_ is TLMDPasClassRefType) then
      begin
        wrr := GetTypeWrapperFromQualTypeId(TLMDPasTypeDecl(decl).Name);
        AddLine(wrr + ' = class;');
      end;

      needline := True;
    end;
  end;

  for i := 0 to Unit_.Declarations.Count - 1 do
  begin
    decl := Unit_.Declarations[i];

    if (decl.GetNodeKind = tnkTypeDecl) and Document.NodeChecked[decl] then
    begin
      if needline then
        EmptyLine;

      type_ := TLMDPasTypeDecl(decl).Type_;
      s     := TLMDPasTypeDecl(decl).Name;

      case type_.GetNodeKind of
        tnkSubrangeType:    GenIntfSubrangeTypeDecl(s, TLMDPasSubrangeType(type_));
        tnkTypeId:          GenIntfTypeIdDecl(s, TLMDPasTypeDecl(decl).TypeKwd,
                                              TLMDPasTypeId(type_));
        tnkEnumType:        GenIntfEnumTypeDecl(s, TLMDPasEnumType(type_));
        tnkClassRefType:    GenIntfClassRefTypeDecl(s, TLMDPasClassRefType(type_));
        tnkSetType:         GenIntfSetTypeDecl(s, TLMDPasSetType(type_));
        tnkRecordType:      GenIntfRecordTypeDecl(s, TLMDPasRecordType(type_));
        tnkClassType:       GenIntfClassTypeDecl(s, TLMDPasClassType(type_));
        tnkProcType:        GenIntfProcTypeDecl(s, TLMDPasProcType(type_));
        tnkPointerType,
        tnkFileType,
        tnkStaticArrayType,
        tnkDynamicArrayType,
        tnkInterfaceType:   Assert(False);
      else
        Assert(False);
      end;

      needline := True;
    end;
  end;

  EndIdent;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplTypeWrappers;
var
  i:        Integer;
  decl:     TLMDPasNamedNode;
  type_:    TLMDPasType;
  s:        string;
  needline: Boolean;
begin
  { Does we have types to generate? }

  if not HasTypeWrappers then
    Exit;

  { Generate type implementations }

  needline := False;
  for i := 0 to Unit_.Declarations.Count - 1 do
  begin
    decl := Unit_.Declarations[i];
    if (decl.GetNodeKind = tnkTypeDecl) and Document.NodeChecked[decl] then
    begin
      if needline then
        EmptyLine;

      type_ := TLMDPasTypeDecl(decl).Type_;
      s     := TLMDPasTypeDecl(decl).Name;

      case type_.GetNodeKind of
        tnkSubrangeType:    GenImplSubrangeTypeDecl(s, TLMDPasSubrangeType(type_));
        tnkTypeId:          GenImplTypeIdDecl(s, TLMDPasTypeDecl(decl).TypeKwd,
                                              TLMDPasTypeId(type_));
        tnkEnumType:        GenImplEnumTypeDecl(s, TLMDPasEnumType(type_));
        tnkClassRefType:    GenImplClassRefTypeDecl(s, TLMDPasClassRefType(type_));
        tnkSetType:         GenImplSetTypeDecl(s, TLMDPasSetType(type_));
        tnkRecordType:      GenImplRecordTypeDecl(s, TLMDPasRecordType(type_));
        tnkClassType:       GenImplClassTypeDecl(s, TLMDPasClassType(type_));
        tnkProcType:        GenImplProcTypeDecl(s, TLMDPasProcType(type_));
        tnkPointerType,
        tnkFileType,
        tnkStaticArrayType,
        tnkDynamicArrayType,
        tnkInterfaceType:   Assert(False);
      else
        Assert(False);
      end;

      needline := True;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenIntfSubrangeTypeDecl(const AName: string;
  AType: TLMDPasSubrangeType);
begin
  AddLine(GetWrapperTypeName(AName) + ' = class(TLMDSubrangeWrapper)');
  AddLine('protected');
  AddLine('  class function GetTypeName: WideString; override;');
  AddLine('public');
  AddLine('  ' + GetIntfToVarHeader(AName));
  AddLine('  ' + GetIntfFromVarHeader(AName));
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenIntfTypeIdDecl(const AName: string;
  ATypeKwd: Boolean; AType: TLMDPasTypeId);
var
  wrrname: string;
begin
  wrrname := GetTypeWrapperFromQualTypeId(AType.QualName);

  if not ATypeKwd then
    AddLine(GetWrapperTypeName(AName) + ' = ' + wrrname + ';')
  else
  begin
    AddLine(GetWrapperTypeName(AName) + ' = class(' + wrrname + ')');
    AddLine('protected');
    AddLine('  class function GetTypeName: WideString; override;');
    AddLine('public');
    AddLine('  ' + GetIntfToVarHeader(AName));
    AddLine('  ' + GetIntfFromVarHeader(AName));
    AddLine('end;');
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenIntfEnumTypeDecl(const AName: string;
  AType: TLMDPasEnumType);
begin
  AddLine(GetWrapperTypeName(AName) + ' = class(TLMDEnumWrapper)');
  AddLine('protected');
  AddLine('  class function  GetTypeName: WideString; override;');
  AddLine('  class procedure GetEnumerators(out AEnums: PLMDEnumerator;');
  AddLine('                                 out ACount: Integer); override;');
  AddLine('public');
  AddLine('  ' + GetIntfToVarHeader(AName));
  AddLine('  ' + GetIntfFromVarHeader(AName));
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenIntfClassRefTypeDecl(
  const AName: string; AType: TLMDPasClassRefType);
begin
  AddLine(GetWrapperTypeName(AName) + ' = class(TLMDMetaclassWrapper)');
  AddLine('protected');
  AddLine('  class function GetTypeName: WideString; override;');
  AddLine('  class function GetWrappedBaseClass: TClass; override;');
  AddLine('public');
  AddLine('  ' + GetIntfToVarHeader(AName));
  AddLine('  ' + GetIntfFromVarHeader(AName));
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenIntfSetTypeDecl(const AName: string;
  AType: TLMDPasSetType);
begin
  AddLine(GetWrapperTypeName(AName) + ' = class(TLMDSetWrapper)');
  AddLine('protected');
  AddLine('  class function GetTypeName: WideString; override;');
  AddLine('  class function GetSetSizeOf: Integer; override;');
  AddLine('public');
  AddLine('  ' + GetIntfToVarHeader(AName));
  AddLine('  ' + GetIntfFromVarHeader(AName));
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenIntfRecordTypeDecl(const AName: string;
  AType: TLMDPasRecordType);
begin
  AddLine(GetWrapperTypeName(AName) + ' = class(TLMDRecordWrapper)');
  AddLine('private');
  AddLine('  FValue: ' + AName + ';');
  AddLine('protected');
  AddLine('  class function  GetTypeName: WideString; override;');
  AddLine('  function        CloneVal: TLMDRecordWrapper; override;');
  AddLine('  class procedure DoInit(AData: TLMDRecordWrapperData); override;');
  AddLine('public');
  AddLine('  ' + GetIntfToVarHeader(AName));
  AddLine('  ' + GetIntfFromVarHeader(AName));
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenIntfClassTypeDecl(const AName: string;
  AType: TLMDPasClassType);
var
  ancwr: string;
begin
  if AType.Ancestor = nil then // For 'TObject'
    ancwr := 'TLMDClassWrapper'
  else
    ancwr := GetWrapperTypeName(AType.Ancestor.QualName);

  AddLine(GetMetaclassTypeName(AName) + ' = class of ' + AName + ';');
  AddLine(GetWrapperTypeName(AName) + ' = class(' + ancwr + ')');

  AddLine('protected');
  AddLine('  class function  GetTypeName: WideString; override;');
  AddLine('  class function  GetWrappedClass: TClass; override;');
  AddLine('  class procedure DoInit(AData: TLMDClassWrapperData); override;');
  AddLine('public');
  AddLine('  ' + GetIntfToVarHeader(AName));
  AddLine('  ' + GetIntfFromVarHeader(AName));
  AddLine('  class function ClassToVar(AClass: ' +
          GetMetaclassTypeName(AName) + '): OleVariant;');
  AddLine('  class function ClassFromVar(const AClass: OleVariant): ' +
          GetMetaclassTypeName(AName) + ';');
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenIntfProcTypeDecl(const AName: string;
  AType: TLMDPasProcType);
begin
  GenIntfScriptHandler(AName, AType);
  EmptyLine;

  AddLine(GetWrapperTypeName(AName) + ' = class(TLMDEventWrapper)');
  AddLine('protected');
  AddLine('  class function GetTypeName: WideString; override;');
  AddLine('public');
  AddLine('  ' + GetIntfToVarHeader(AName));
  AddLine('  ' + GetIntfFromVarHeader(AName));
  AddLine('  class function GetScriptHandlerClass: TClass; override;');
  AddLine('  class function GetHandler(AScriptControl: TLMDScriptControl;');
  AddLine('                            const AProcName: string): ' + AName + ';');
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplSubrangeTypeDecl(const AName: string;
  AType: TLMDPasSubrangeType);
var
  wname: string;
begin
  wname := GetWrapperTypeName(AName);

  GenTypeImplComment(wname);
  EmptyLine;

  AddLine('class function ' + wname + '.GetTypeName: WideString;', skDecl);
  AddLine('begin');
  AddLine('  Result := ''' + AName + ''';');
  AddLine('end;');

  EmptyLine;

  AddLine(GetImplToVarHeader(wname, AName), skDecl);
  AddLine('begin');
  AddLine('  Result := Integer(AValue);');
  AddLine('end;');

  EmptyLine;

  AddLine(GetImplFromVarHeader(wname, AName), skDecl);
  AddLine('begin');
  BeginIdent;
  AddLine('Result := ' + AName + '(Integer(AValue));', skBody);
  EndIdent;
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplTypeIdDecl(const AName: string;
  ATypeKwd: Boolean; AType: TLMDPasTypeId);
var
  wname: string;
begin
  if ATypeKwd then
  begin
    wname := GetWrapperTypeName(AName);

    GenTypeImplComment(wname);
    EmptyLine;

    AddLine('class function ' + wname + '.GetTypeName: WideString;', skDecl);
    AddLine('begin');
    AddLine('  Result := ''' + AName + ''';');
    AddLine('end;');

    EmptyLine;

    AddLine(GetImplToVarHeader(wname, AName), skDecl);
    AddLine('begin');
    AddLine('  Result := ' + GetTypeWrapperFromQualTypeId(AType.QualName) +
            '.ToVar(' + AType.QualName + '(AValue));', skBody);
    AddLine('end;');

    EmptyLine;

    AddLine(GetImplFromVarHeader(wname, AName), skDecl);
    AddLine('begin');
    BeginIdent;
    AddLine('Result := ' + AName + '(' +
            GetTypeWrapperFromQualTypeId(AType.QualName) +
            '.FromVar(AValue));', skBody);
    EndIdent;
    AddLine('end;');
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplEnumTypeDecl(const AName: string;
  AType: TLMDPasEnumType);
var
  wname: string;
  i:     Integer;
  s:     string;
  cnt:   Integer;
begin
  wname := GetWrapperTypeName(AName);

  GenTypeImplComment(wname);
  EmptyLine;

  AddLine('class function ' + wname + '.GetTypeName: WideString;', skDecl);
  AddLine('begin');
  AddLine('  Result := ''' + AName + ''';');
  AddLine('end;');

  EmptyLine;

  AddLine('class procedure ' + wname + '.GetEnumerators(out ' +
          'AEnums: PLMDEnumerator; out ACount: Integer);', skDecl);
  AddLine('const');

  cnt := AType.Enumerators.Count;
  AddLine('  ENUMS: array[0..' + IntToStr(cnt - 1) +
          '] of TLMDEnumerator = (');
  for i := 0 to cnt - 1 do
  begin
    s := '(Name: ''' + AType.Enumerators[i] + '''; Value: Integer(' +
         '{$IFDEF LMDSCT_12}' + AName + '.{$ENDIF}' + AType.Enumerators[i] +
         '))';
    if i <> cnt - 1 then
      s := s + ',';
    AddLine('    ' + s);
  end;
  AddLine('  );');

  AddLine('begin');
  AddLine('  AEnums := @ENUMS;');
  AddLine('  ACount := ' + IntToStr(cnt) + ';');
  AddLine('end;');

  EmptyLine;

  AddLine(GetImplToVarHeader(wname, AName), skDecl);
  AddLine('begin');
  AddLine('  Result := Integer(AValue);');
  AddLine('end;');

  EmptyLine;

  AddLine(GetImplFromVarHeader(wname, AName), skDecl);
  AddLine('begin');
  BeginIdent;
  AddLine('Result := ' + AName + '(Integer(AValue));', skBody);
  EndIdent;
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplMembersInvokers(
  const AParentName, AInstanceInvokePrefix, AMetaInvokePrefix: string;
  AMembers: TLMDPasNamedNodes);
var
  i:    Integer;
  mr:   TLMDPasNamedNode;
  pref: string;
begin
  for i := 0 to AMembers.Count - 1 do
  begin
    mr := AMembers[i];

    if FDocument.NodeChecked[mr] and not (mr is TLMDPasPropertyRedecl) then
    begin
      if IsInstanceMember(mr) then
        pref := AInstanceInvokePrefix
      else
        pref := AMetaInvokePrefix;

      EmptyLine;
      AddLine('function ' + AParentName + '_' + mr.Name +
              '_si(var AObj; const AArgs: TLMDDispArgs; AArgsSize: Integer; ' +
              'IsGet: Boolean): OleVariant;', skDecl);
      GenInvokerVarSection(mr);
      AddLine('begin');
      BeginIdent;
      GenMemberInvoker(AParentName, pref, mr);
      EndIdent;
      AddLine('end;');
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplClassRefTypeDecl(const AName: string;
  AType: TLMDPasClassRefType);
var
  wname:     string;
  baseclsnm: string;
begin
  wname     := GetWrapperTypeName(AName);
  baseclsnm := GenTypeReuseStr(AType.BaseType);

  GenTypeImplComment(wname);
  EmptyLine;

  AddLine('class function ' + wname + '.GetTypeName: WideString;', skDecl);
  AddLine('begin');
  AddLine('  Result := ''' + AName + ''';');
  AddLine('end;');

  EmptyLine;

  AddLine('class function ' + wname + '.GetWrappedBaseClass: TClass;', skDecl);
  AddLine('begin');
  AddLine('  Result := ' + baseclsnm + ';');
  AddLine('end;');

  EmptyLine;

  AddLine(GetImplToVarHeader(wname, AName), skDecl);
  AddLine('begin');
  AddLine('  Result := ConvToVar(AValue);');
  AddLine('end;');

  EmptyLine;

  AddLine(GetImplFromVarHeader(wname, AName), skDecl);
  AddLine('begin');
  BeginIdent;
  AddLine('Result := ' + AName + '(ConvFromVar(AValue, ' + baseclsnm + '));',
          skBody);
  EndIdent;
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplSetTypeDecl(const AName: string;
  AType: TLMDPasSetType);
var
  wname: string;
begin
  wname := GetWrapperTypeName(AName);

  GenTypeImplComment(wname);
  EmptyLine;

  AddLine('class function ' + wname + '.GetTypeName: WideString;', skDecl);
  AddLine('begin');
  AddLine('  Result := ''' + AName + ''';');
  AddLine('end;');

  EmptyLine;

  AddLine('class function ' + wname + '.GetSetSizeOf: Integer;', skDecl);
  AddLine('begin');
  AddLine('  Result := SizeOf(' + AName + ');');
  AddLine('end;');

  EmptyLine;

  AddLine(GetImplToVarHeader(wname, AName), skDecl);
  AddLine('begin');
  AddLine('  Result := ConvToVar(@AValue);');

  AddLine('end;');

  EmptyLine;

  AddLine(GetImplFromVarHeader(wname, AName), skDecl);
  AddLine('begin');
  AddLine('  ConvFromVar(AValue, @Result);');
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplRecordTypeDecl(const AName: string;
  AType: TLMDPasRecordType);
var
  wname: string;
begin
  wname := GetWrapperTypeName(AName);
  GenTypeImplComment(wname);

  EmptyLine;

  GenImplMembersInvokers(AName, wname + '(AObj).FValue', AName, AType.Members);

  EmptyLine;

  AddLine('class function ' + wname + '.GetTypeName: WideString;', skDecl);
  AddLine('begin');
  AddLine('  Result := ''' + AName + ''';');
  AddLine('end;');

  EmptyLine;

  AddLine('function ' + wname + '.CloneVal: TLMDRecordWrapper;',
          skDecl);
  AddLine('begin');
  BeginIdent;
  AddLine('Result := ' + wname + '.Create;', skBody);
  AddLine(wname + '(Result).FValue := FValue;', skBody);
  EndIdent;
  AddLine('end;');

  EmptyLine;

  AddLine('class procedure ' + wname + '.DoInit(AData: TLMDRecordWrapperData);',
          skDecl);
  GenRecordDoInitBody(AName, AType);

  EmptyLine;

  AddLine(GetImplToVarHeader(wname, AName), skDecl);
  AddLine('var');
  AddLine('  wrpr: ' + wname + ';');
  AddLine('begin');
  BeginIdent;
  AddLine('wrpr        := ' + wname + '.Create;', skBody);
  AddLine('wrpr.FValue := AValue;');
  AddLine('');
  AddLine('Result := ConvToVar(wrpr);');
  EndIdent;
  AddLine('end;');

  EmptyLine;

  AddLine(GetImplFromVarHeader(wname, AName), skDecl);
  AddLine('begin');
  BeginIdent;
  AddLine('Result := ' + wname + '(ConvFromVar(AValue)).FValue;', skBody);
  EndIdent;
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplClassTypeDecl(const AName: string;
  AType: TLMDPasClassType);
var
  wname:       string;
  mtname:      string;
  hasinstmrs:  Boolean;
  hasclassmrs: Boolean;
begin
  wname  := GetWrapperTypeName(AName);
  mtname := GetMetaclassTypeName(AName);

  hasinstmrs       := IsClassHasInstanceMembers(AType, True);
  hasclassmrs      := IsClassHasClassMembers(AType);

  GenTypeImplComment(wname);
  GenImplMembersInvokers(AName, AName + '(AObj)', mtname + '(AObj)',
                         AType.Members);

  EmptyLine;

  AddLine('class function ' + wname + '.GetTypeName: WideString;', skDecl);
  AddLine('begin');
  AddLine('  Result := ''' + AName + ''';');
  AddLine('end;');

  EmptyLine;

  AddLine('class function ' + wname + '.GetWrappedClass: TClass;', skDecl);
  AddLine('begin');
  AddLine('  Result := ' + AName + ';');
  AddLine('end;');

  EmptyLine;

  AddLine('class procedure ' + wname + '.DoInit(AData: TLMDClassWrapperData);',
          skDecl);
  if hasinstmrs or hasclassmrs then
    GenClassDoInitBody(AName, AType)
  else
  begin
    AddLine('begin');
    AddLine('  // Do not call inherited.');
    AddLine('end;');
  end;

  EmptyLine;

  AddLine(GetImplToVarHeader(wname, AName), skDecl);
  AddLine('begin');
  AddLine('  Result := ConvToVar(AValue);');
  AddLine('end;');

  EmptyLine;

  AddLine(GetImplFromVarHeader(wname, AName), skDecl);
  AddLine('begin');
  BeginIdent;
  AddLine('Result := ' + AName + '(ConvFromVar(AValue, ' + AName + '));',
          skBody);
  EndIdent;
  AddLine('end;');

  EmptyLine;

  AddLine('class function ' + wname + '.ClassToVar(AClass: ' +
          mtname + '): OleVariant;', skDecl);
  AddLine('begin');
  AddLine('  Result := ConvClsToVar(AClass);');
  AddLine('end;');

  EmptyLine;

  AddLine('class function ' + wname + '.ClassFromVar(const AClass: OleVariant): ' +
          mtname + ';', skDecl);
  AddLine('begin');
  BeginIdent;
  AddLine('Result := ' + mtname + '(ConvClsFromVar(AClass, ' + AName + '));',
          skBody);
  EndIdent;
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplProcTypeDecl(const AName: string;
  AType: TLMDPasProcType);
var
  wname: string;
  ename: string;
begin
  GenImplScriptHandler(AName, AType);
  EmptyLine;

  wname := GetWrapperTypeName(AName);
  ename := GetEventHandlerClassName(AName);

  GenTypeImplComment(wname);
  EmptyLine;

  AddLine('class function ' + wname + '.GetTypeName: WideString;', skDecl);
  AddLine('begin');
  AddLine('  Result := ''' + AName + ''';');
  AddLine('end;');

  EmptyLine;

  AddLine('class function ' + wname + '.GetScriptHandlerClass: TClass;', skDecl);
  AddLine('begin');
  AddLine('  Result := ' + ename + ';');
  AddLine('end;');

  EmptyLine;

  AddLine(GetImplToVarHeader(wname, AName), skDecl);
  AddLine('begin');
  BeginIdent;
  AddLine('Result := ConvToVar(TMethod(AValue));', skBody);
  EndIdent;
  AddLine('end;');

  EmptyLine;

  AddLine(GetImplFromVarHeader(wname, AName), skDecl);
  AddLine('begin');
  BeginIdent;
  AddLine('Result := ' + AName + '(ConvFromVar(AValue));', skBody);
  EndIdent;
  AddLine('end;');

  EmptyLine;

  AddLine('class function ' + wname + '.GetHandler(AScriptControl: ' +
          'TLMDScriptControl; const AProcName: string): ' + AName + ';', skDecl);
  AddLine('var');
  AddLine('  hdlr: ' + ename + ';');
  AddLine('begin');
  BeginIdent;
  AddLine('hdlr   := ' + ename + '(AScriptControl.GetEventHandler(' +
          'AProcName, ' + wname + '));', skBody);
  AddLine('Result := hdlr.Handler;');
  EndIdent;
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenTypeImplComment(const AClassName: string);
begin
  AddLine('{ ' + AClassName + ' }');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenTypeMemberDoInit(const ATypeName: string;
  AMember: TLMDPasNamedNode);
const
  BOOL_STR: array[Boolean] of string = ('False', 'True');
var
  s:     string;
  prop:  TLMDPasProperty;
  predl: TLMDPasPropertyRedecl;
  proc:  TLMDPasProcHeading;
  group: TLMDPasOverloadGroup;
  fld:   TLMDPasVarDecl;
  cst:   TLMDPasConstDecl;
  tpr:   string;
  invr:  string;
begin
  invr := ATypeName + '_' + AMember.Name + '_si';

  case AMember.GetNodeKind of
    tnkVarDecl:         begin
                          fld := TLMDPasVarDecl(AMember);

                          if fld.IsClassField then
                            s := 'AData.AddClassField'
                          else
                            s := 'AData.AddField';
                          s := s + '(''' + fld.Name + ''', ' + invr + ', ' +
                               GenTypeWrapperRef(fld.Type_) + ');';

                          AddLine(s);
                        end;
    tnkProcHeading:     begin
                          proc := TLMDPasProcHeading(AMember);
                          s    := GenProcDoInit(proc.Name, invr, proc.FuncKind,
                                                proc.Parameters.Count,
                                                proc.Parameters.OptionalCount,
                                                proc.ReturnType);
                          AddLine(s);
                        end;
    tnkOverloadGroup:   begin
                          group := TLMDPasOverloadGroup(AMember);
                          s     := GenProcDoInit(group.Name, invr,
                                                 group.C_FuncKind,
                                                 group.C_ParamCount,
                                                 group.C_OptionalCount,
                                                 nil);
                           AddLine(s);
                        end;
    tnkProperty:        begin
                          prop := TLMDPasProperty(AMember);

                          if prop.IsClassProp then
                            s := 'AData.AddClassProperty'
                          else
                            s := 'AData.AddProperty';

                          s := s + '(''' + prop.Name + ''', ' + invr + ', ' +
                               GenTypeWrapperRef(prop.Type_) + ', ' +
                               BOOL_STR[prop.IsReadable] + ', ' +
                               BOOL_STR[prop.IsWritable] + ', ' +
                               IntToStr(prop.Parameters.Count) + ', ' +
                               BOOL_STR[prop.IsProtected];
                          if not prop.IsClassProp then
                            s := s + ', ' + BOOL_STR[prop.IsDefault];
                          s := s + ');';

                          AddLine(s);
                        end;
    tnkPropertyRedecl:  begin
                          predl := TLMDPasPropertyRedecl(AMember);

                          s := 'AData.AddPropertyRedecl(''' + predl.Name +
                                ''', ' + BOOL_STR[predl.IsDefault] + ');';
                          AddLine(s);
                        end;
    tnkConstDecl:       begin
                          cst := TLMDPasConstDecl(AMember);
                          s   := '';

                          case cst.Kind of
                            ckTyped:  s := 'AData.AddConstant(''' + cst.Name +
                                           ''', ' + invr + ', ' +
                                           GenTypeWrapperRef(cst.Type_) + ');';
                            ckSimple: s := 'AData.AddConstant(''' + cst.Name +
                                           ''', ' + invr + ', nil, VarType(' +
                                           ATypeName + '.' + cst.Name + '));';
                            ckNil:    s := 'AData.AddConstant(''' + cst.Name +
                                           ''', ' + invr + ', nil, varDispatch);';
                            ckSet:    s := 'AData.AddConstant(''' + cst.Name +
                                           ''', ' + invr + ', nil, varInteger);';
                          else // ckUnknown
                            tpr := FDocument.ConstTypeRepl[cst];
                            if tpr <> '' then
                              s := 'AData.AddConstant(''' + cst.Name +
                                    ''', ' + invr + ', ' +
                                    GenTypeIdWrapperRef(tpr) + ');';
                          end;

                          AddLine(s);
                        end;
  else
    Assert(False);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenRecordDoInitBody(const AName: string;
  AType: TLMDPasRecordType);
var
  i:      Integer;
  member: TLMDPasNamedNode;
  wname:  string;
begin
  wname := GetWrapperTypeName(AName);

  AddLine('begin');
  BeginIdent;

  { Add instance members first }

  AddLine('{ Instance members }');
  EmptyLine;

  for i := 0 to AType.Members.Count - 1 do
  begin
    member := AType.Members[i];
    if FDocument.NodeChecked[member] and
       IsInstanceMember(member) then
      GenTypeMemberDoInit(AName, member);
  end;

  { Add class members then }

  EmptyLine;
  AddLine('{ Class members }');
  EmptyLine;

  for i := 0 to AType.Members.Count - 1 do
  begin
    member := AType.Members[i];
    if FDocument.NodeChecked[member] and
       not IsInstanceMember(member) then
      GenTypeMemberDoInit(AName, member);
  end;

  EndIdent;
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.IsInstanceMember(
  AMember: TLMDPasNamedNode): Boolean;
begin
  case AMember.GetNodeKind of
    tnkVarDecl:        Result := not TLMDPasVarDecl(AMember).IsClassField;
    tnkProcHeading:    Result := TLMDPasProcHeading(AMember).FuncKind in
                                 [ppkProcedure, ppkFunction, ppkDestructor];
    tnkOverloadGroup:  Result := TLMDPasOverloadGroup(AMember).C_FuncKind in
                                 [ppkProcedure, ppkFunction, ppkDestructor];
    tnkProperty:       Result := not TLMDPasProperty(AMember).IsClassProp;
    tnkPropertyRedecl: Result := True;
  else
    Result := False;
  end;
end;
             
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.IsProtectedProp(
  AMember: TLMDPasNamedNode): Boolean;
begin
  Result := (AMember.GetNodeKind = tnkProperty) and
             TLMDPasProperty(AMember).IsProtected;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.IsClassHasInstanceMembers(
  AType: TLMDPasClassType; AIncludePropRedecls: Boolean): Boolean;
var
  i:   Integer;
  mrs: TLMDPasNamedNodes;
begin
  Result := False;
  mrs    := AType.Members;

  for i := 0 to mrs.Count - 1 do
    if FDocument.NodeChecked[mrs[i]] and IsInstanceMember(mrs[i]) and
       (AIncludePropRedecls or (mrs[i].GetNodeKind <> tnkPropertyRedecl)) then
    begin
      Result := True;
      Break; // for
    end;
end;
            
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.IsClassHasClassMembers(
  AType: TLMDPasClassType): Boolean;
var
  i: Integer;
begin
  for i := 0 to AType.Members.Count - 1 do
    if FDocument.NodeChecked[AType.Members[i]] and
       not IsInstanceMember(AType.Members[i]) then
    begin
      Result := True;
      Exit;
    end;
  Result := False;
end;
                    
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenClassDoInitBody(const AName: string;
  AType: TLMDPasClassType);
var
  i:      Integer;
  member: TLMDPasNamedNode;
begin
  AddLine('begin');
  BeginIdent;

  { Add instance members first }

  if IsClassHasInstanceMembers(AType, True) then
  begin
    AddLine('{ Instance members }');
    EmptyLine;

    for i := 0 to AType.Members.Count - 1 do
    begin
      member := AType.Members[i];
      if FDocument.NodeChecked[member] and
         IsInstanceMember(member) then
        GenTypeMemberDoInit(AName, member);
    end;
  end;

  { Add class members then }

  if IsClassHasClassMembers(AType) then
  begin
    EmptyLine;
    AddLine('{ Class members }');
    EmptyLine;

    for i := 0 to AType.Members.Count - 1 do
    begin
      member := AType.Members[i];
      if FDocument.NodeChecked[member] and
         not IsInstanceMember(member) then
        GenTypeMemberDoInit(AName, member);
    end;
  end;

  EndIdent;
  AddLine('end;');
end;
                     
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenIntfScriptHandler(const AName: string;
  AType: TLMDPasProcType);
begin
  AddLine(GetEventHandlerClassName(AName) + ' = class(TLMDScriptEventHandler)');
  AddLine('public');
  AddLine('  function  GetHandler: TMethod; override;');
  BeginIdent;
  AddLine(GenScriptHandlerProcHeading(AType, 'Handler') + ';', skDecl);
  EndIdent;
  AddLine('end;');
end;
                              
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenImplScriptHandler(const AName: string;
  AType: TLMDPasProcType);
var
  ename: string;
begin
  ename := GetEventHandlerClassName(AName);

  GenTypeImplComment(ename);
  EmptyLine;

  AddLine('function ' + ename + '.GetHandler: TMethod;');
  AddLine('var');
  AddLine('  hdr: ' + AName + ';');
  AddLine('begin');
  AddLine('  hdr    := Handler;');
  AddLine('  Result := TMethod(hdr);');
  AddLine('end;');

  EmptyLine;

  GenScriptHandlerProcImpl(AName, AType);
end;
                             
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GenScriptHandlerProcHeading(
  AType: TLMDPasProcType; const AProcName: string): string;
var
  i:     Integer;
  param: TLMDPasParameter;
begin
  if AType.ProcTypeKind = ptkProcedure then
    Result := 'procedure '
  else
    Result := 'function ';

  Result := Result + AProcName;

  if AType.Parameters.Count <> 0 then
  begin
    Result := Result + '(';

    for i := 0 to AType.Parameters.Count - 1 do
    begin
      param := AType.Parameters[i];

      if i <> 0 then
        Result := Result + '; ';

      case param.Modifier of
        ppmConst: Result := Result + 'const ';
        ppmVar:   Result := Result + 'var ';
        ppmOut:   Result := Result + 'out ';
      end;
      Result := Result + param.Name + ': ' + GenTypeReuseStr(param.Type_);
    end;

    Result := Result + ')';
  end;

  if AType.ProcTypeKind = ptkFunction then
    Result := Result + ': ' + GenTypeReuseStr(AType.ReturnType);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenScriptHandlerProcImpl(
  const AName: string; AType: TLMDPasProcType);
var
  i:     Integer;
  ename: string;
  s:     string;
begin
  ename := GetEventHandlerClassName(AName);

  AddLine(GenScriptHandlerProcHeading(AType, ename + '.Handler') + ';', skDecl);
  GenScriptHandlerProcVarSection(AName, AType);

  AddLine('begin');
  BeginIdent;

  AddLine('// ' + ConstraintString(AType.ToStr, 60));
  if AType.C_Messages.Count <> 0 then
  begin
    AddLine('//');
    AddLine('// Warnings:');
    for i := 0 to AType.C_Messages.Count - 1 do
      AddLine('//   ' + ConstraintString(AType.C_Messages[i], 58));
  end;

  EmptyLine;

  if AType.Parameters.Count = 0 then // Runtime speed optimization.
    s := 'Self.Owner.RunProc(Self.ProcName)'
  else
    s := 'Self.Owner.RunProc(Self.ProcName, args)';

  if AType.ProcTypeKind = ptkFunction then
    s := 'Result := ' + GenTypeFromVarStr(AType.ReturnType, s);

  ScriptHandlerGenParamsPreExecute(AType.Parameters);
  AddLine(s + ';', skBody);
  ScriptHandlerGenParamsPostExecute(AType.Parameters);

  EndIdent;
  AddLine('end;');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenScriptHandlerProcVarSection(
  const AName: string; AType: TLMDPasProcType);
var
  i, idx: Integer;
  param:  TLMDPasParameter;
  params: TList;
begin
  params := TList.Create;
  try
    if AType.Parameters.Count > 0 then
    begin
      AddLine('var');
      BeginIdent;
      AddLine('args: array[0..' + IntToStr(AType.Parameters.Count - 1) +
              '] of OleVariant;');

      GetAllVarOutParams(AType, params);

      idx := 1;
      for i := 0 to params.Count - 1 do
      begin
        param := TLMDPasParameter(params[i]);
        param.C_VarName := 'v_' + IntToStr(idx);
        Inc(idx);

        AddLine(param.C_VarName + ': OleVariant;');
      end;

      EndIdent;
    end;
  finally
    params.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenMemberInvoker(
  const AParentName, AInvokePrefix: string; AMember: TLMDPasNamedNode);
var
  i: Integer;
begin
  AddLine('// ' + ConstraintString(AMember.ToStr, 60));
  if AMember.C_Messages.Count <> 0 then
  begin
    AddLine('//');
    AddLine('// Warnings:');
    for i := 0 to AMember.C_Messages.Count - 1 do
      AddLine('//   ' + ConstraintString(AMember.C_Messages[i], 58));
  end;

  EmptyLine;

  case AMember.GetNodeKind of
    tnkTypeDecl:        GenTypeDeclInvoker(AParentName, AInvokePrefix,
                                           TLMDPasTypeDecl(AMember));
    tnkConstDecl:       GenConstInvoker(AParentName, AInvokePrefix,
                                        TLMDPasConstDecl(AMember));
    tnkVarDecl:         GenVarInvoker(AParentName, AInvokePrefix,
                                      TLMDPasVarDecl(AMember));
    tnkProcHeading:     GenProcInvoker(AParentName, AInvokePrefix,
                                       TLMDPasProcHeading(AMember));
    tnkOverloadGroup:   GenOvarlodGroupInvoker(AParentName, AInvokePrefix,
                                               TLMDPasOverloadGroup(AMember));
    tnkProperty:        GenPropInvoker(AParentName, AInvokePrefix,
                                       TLMDPasProperty(AMember));
    // Property redeclarations must
    // not be here.
  else
    Assert(False);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenOvarlodGroupInvoker(const AParentName,
  AInvokePrefix: string; AGroup: TLMDPasOverloadGroup);
var
  opts:   Integer;
  prmcnt: Integer;
  calls:  TLMDPasCalls;
  ccnt:   Integer;
  i, j:   Integer;
  base:   Integer;
  proc:   TLMDPasProcHeading;
begin
  for i := 0 to AGroup.Procs.Count - 1 do
    if FDocument.NodeChecked[AGroup.Procs[i]] then
    begin
      proc   := AGroup.Procs[i];
      prmcnt := proc.Parameters.Count;
      opts   := proc.Parameters.OptionalCount;

      base := Length(calls);
      ccnt := opts + 1;
      SetLength(calls, base + ccnt);

      for j := 0 to ccnt - 1 do
      begin
        calls[base + j].Proc     := proc;
        calls[base + j].ArgCount := (prmcnt - opts) + j;
      end;
    end;

  GenProcInvoker(AParentName, AGroup.Name, AInvokePrefix, calls);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenTypeDeclInvoker(const AParentName,
  AInvokePrefix: string; ADecl: TLMDPasTypeDecl);
begin
  AddLine('Result := TLMDUnitWrapper.TypeToVar(' +
          GetWrapperTypeName(ADecl.Name) + ');');
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenConstInvoker(const AParentName,
  AInvokePrefix: string; ADecl: TLMDPasConstDecl);
var
  s:   string;
  obj: string;
  tpr: string;
begin
  obj := AInvokePrefix;
  s   := '';

  if obj <> '' then
    obj := obj + '.';

  case ADecl.Kind of
    ckTyped:    s := GenTypeToVarStr(ADecl.Type_, obj + ADecl.Name);
    ckSimple:   s := obj + ADecl.Name;
    ckNil:      s := 'LMDVarNil';
    ckSet:      s := 'LMDSetToVar(SizeOf(' + obj + ADecl.Name + '), ' +
                     obj + ADecl.Name + ')';
  else // ckUnknown
    tpr := FDocument.ConstTypeRepl[ADecl];
    if tpr <> '' then
      s := GenTypeIdToVarStr(FDocument.ConstTypeRepl[ADecl],
                             obj + ADecl.Name);
  end;

  AddLine('Result := ' + s + ';', skBody);
end;
                                 
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenVarInvoker(
  const AParentName, AInvokePrefix: string; ADecl: TLMDPasVarDecl);
var
  obj: string;
begin
  obj := AInvokePrefix;
  if obj <> '' then
    obj := obj + '.';

  AddLine('if IsGet then');
  BeginIdent;
  AddLine('Result := ' + GenTypeToVarStr(ADecl.Type_, obj + ADecl.Name),
          skBody);
  EndIdent;
  AddLine('else');
  BeginIdent;
  AddLine(obj + ADecl.Name + ' := ' +
          GenTypeFromVarStr(ADecl.Type_, 'AArgs[0]') + ';', skBody);
  EndIdent;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GenProcDoInit(const AProcName,
  AInvoker: string; AKind: TLMDPasProcKind; AParamCount,
  AOptionalParams: Integer; AReturnType: TLMDPasType): string;
const
  BOOL_STR: array[Boolean] of string = ('False', 'True');
var
  s:     string;
  rettp: string;
begin
  s := 'AData.';

  case AKind of
    ppkProcedure:       s := s + 'AddProcedure(';
    ppkFunction:        s := s + 'AddFunction(';
    ppkClassProcedure:  s := s + 'AddClassProcedure(';
    ppkClassFunction:   s := s + 'AddClassFunction(';
    ppkConstructor:     s := s + 'AddConstructor(';
    ppkDestructor:      s := s + 'AddDestructor(';
  end;

  s := s + '''' + AProcName + ''', ' + AInvoker;

  if AKind in [ppkFunction, ppkClassFunction] then
  begin
    if AReturnType <> nil then
      rettp := GenTypeWrapperRef(AReturnType)
    else
      rettp := 'nil';
    s := s + ', ' + rettp;
  end;

  s := s + ', ' + IntToStr(AParamCount - AOptionalParams) +
       ', ' + BOOL_STR[AOptionalParams > 0] + ');';

  Result := s;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenProcInvoker(const AParentName,
  AName, AInvokePrefix: string; const ACalls: TLMDPasCalls);
var
  i:        Integer;
  wname:    string;
  needcase: Boolean;
  proc:     TLMDPasProcHeading;
  argcnt:   Integer;
  s:        string;
begin
  needcase := (Length(ACalls) > 1);

  if needcase then
  begin
    AddLine('case AArgsSize of', skBody);
    BeginIdent;
  end;

  for i := 0 to High(ACalls) do
  begin
    proc   := ACalls[i].Proc;
    argcnt := ACalls[i].ArgCount;

    if needcase then
    begin
      AddLine(IntToStr(argcnt) + ':');
      AddLine('begin');
      BeginIdent;
    end;

    case proc.Body of
      ppbNormal:
      begin
        GenParamsPreExecute(proc.Parameters, argcnt);

        s := AInvokePrefix;
        if s <> '' then
          s := s + '.';
        s := s + proc.Name;

        if argcnt <> 0 then
          s := s + '(' + GenParamsStr(proc.Parameters, argcnt) + ')'
        else
          s := s + '()'; // Required for functions, returning events.

        if proc.FuncKind in [ppkFunction, ppkClassFunction] then
          s := 'Result := ' + GenTypeToVarStr(proc.ReturnType, s) + ';'
        else if proc.FuncKind = ppkConstructor then
          s := 'Result := ' + GenTypeIdToVarStr(AParentName, s) + ';'
        else
          s := s + ';';

        AddLine(s, skBody);

        GenParamsPostExecute(proc.Parameters, argcnt);
      end;
      ppbRecCreate:
      begin
        wname := GetWrapperTypeName(AParentName);
        AddLine('// Implicit parameterless constructor.');
        AddLine('Result := ' + wname + '.Create as IDispatch;', skBody);
      end;
      ppbRecCopy:
      begin
        wname := GetWrapperTypeName(AParentName);
        AddLine('// Implicit record copy method.');
        AddLine('Result := ' + wname + '.ToVar(' + AParentName +
                '(AObj));', skBody);
      end;
    else
      Assert(False);
    end;

    if needcase then
    begin
      EndIdent;
      AddLine('end;');
    end;
  end;

  if needcase then
  begin
    EndIdent;
    AddLine('else', skBody);
    AddLine('  WrongArgCountError(''' + AName + ''');', skBody);
    AddLine('end;', skBody);
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenProcInvoker(
  const AParentName, AInvokePrefix: string; AProc: TLMDPasProcHeading);
var
  opts:   Integer;
  prmcnt: Integer;
  calls:  TLMDPasCalls;
  ccnt:   Integer;
  i:      Integer;
begin
  prmcnt := AProc.Parameters.Count;
  opts   := AProc.Parameters.OptionalCount;

  ccnt := opts + 1;
  SetLength(calls, ccnt);

  for i := 0 to ccnt - 1 do
  begin
    calls[i].Proc     := AProc;
    calls[i].ArgCount := (prmcnt - opts) + i;
  end;

  GenProcInvoker(AParentName, AProc.Name, AInvokePrefix, calls);
end;
                              
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenPropInvoker(
  const AParentName, AInvokePrefix: string; AProp: TLMDPasProperty);
var
  readstr:    string;
  writestr:   string;
  obj:        string;
begin
  obj := AInvokePrefix;
    
  if (obj <> '') and AProp.IsProtected then
    obj := GetProtectedAccessorName(AParentName) + '(' + obj + ')';
    
  readstr  := '';
  writestr := '';

  if AProp.IsReadable then
  begin
    readstr := obj + '.' + AProp.Name;
    if AProp.Parameters.Count <> 0 then
      readstr := readstr + '[' + GenParamsStr(AProp.Parameters) + ']';

    readstr := 'Result := ' + GenTypeToVarStr(AProp.Type_, readstr);
  end;

  if AProp.IsWritable then
  begin
    writestr := obj + '.' + AProp.Name;
    if AProp.Parameters.Count <> 0 then
      writestr := writestr + '[' + GenParamsStr(AProp.Parameters) + ']';
    writestr   := writestr + ' := ' + GenTypeFromVarStr(AProp.Type_,
                           'AArgs[' + IntToStr(AProp.Parameters.Count) + ']');
  end;

  GenParamsPreExecute(AProp.Parameters);
  if AProp.IsWritable and AProp.IsReadable then
  begin
    AddLine('if IsGet then');
    BeginIdent;
    AddLine(readstr, skBody);
    EndIdent;
    AddLine('else');
    BeginIdent;
    AddLine(writestr + ';', skBody);
    EndIdent;
  end
  else if AProp.IsWritable then
    AddLine(writestr + ';', skBody)
  else
    AddLine(readstr + ';', skBody);
  GenParamsPostExecute(AProp.Parameters);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GetAllVarOutParams(
  AType: TLMDPasProcType; Result: TList);
var
  i:      Integer;
  params: TLMDPasParameters;
begin
  params := AType.Parameters;

  for i := 0 to params.Count - 1 do
    if params[i].Modifier in [ppmVar, ppmOut] then
      Result.Add(params[i]);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenParamsPreExecute(
  AParams: TLMDPasParameters; AIncludeOnly: Integer);
var
  i:   Integer;
  cnt: Integer;
begin
  if AIncludeOnly = -1 then
    cnt := AParams.Count
  else
    cnt := AIncludeOnly;

  for i := 0 to cnt - 1 do
    if AParams[i].Modifier = ppmVar then
    begin
      AddLine(AParams[i].C_VarName + ' := ' +
              GenTypeFromVarStr(AParams[i].Type_,
                                'AArgs[' + IntToStr(i) + ']') +
              ';');
    end;
end;
                                
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.GenParamsPostExecute(
  AParams: TLMDPasParameters; AIncludeOnly: Integer);
var
  i:   Integer;
  cnt: Integer;
begin
  if AIncludeOnly = -1 then
    cnt := AParams.Count
  else
    cnt := AIncludeOnly;

  for i := 0 to cnt - 1 do
    if AParams[i].Modifier in [ppmVar, ppmOut] then
    begin
      AddLine('AssignRefParam(AArgs[' + IntToStr(i) + '], ' +
              GenTypeToVarStr(AParams[i].Type_, AParams[i].C_VarName) + ');');
    end;
end;
                                
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GenParamsStr(
  AParams: TLMDPasParameters; AIncludeOnly: Integer): string;
var
  i:   Integer;
  cnt: Integer;
begin
  Result := '';

  if AIncludeOnly = -1 then
    cnt := AParams.Count
  else
    cnt := AIncludeOnly;

  for i := 0 to cnt - 1 do
  begin
    if i <> 0 then
      Result := Result + ', ';

    if AParams[i].Modifier in [ppmVar, ppmOut] then
      Result := Result + AParams[i].C_VarName
    else
      Result := Result + GenTypeFromVarStr(AParams[i].Type_,
                                           'AArgs[' + IntToStr(i) + ']');
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.ScriptHandlerGenParamsPreExecute(
  AParams: TLMDPasParameters);
var
  i: Integer;
  s: WideString;
begin
  for i := 0 to AParams.Count - 1 do
    if AParams[i].Modifier = ppmVar then
    begin
      s := GenTypeToVarStr(AParams[i].Type_, AParams[i].Name);
      AddLine(Format('%s := %s;', [AParams[i].C_VarName, s]));
    end;

  for i := 0 to AParams.Count - 1 do
    if AParams[i].Modifier in [ppmVar, ppmOut] then
    begin
      AddLine(Format('args[%d] := MakeVarRef(%s);', [i, AParams[i].C_VarName]));
    end
    else
    begin
      s := GenTypeToVarStr(AParams[i].Type_, AParams[i].Name);
      AddLine(Format('args[%d] := %s;', [i, s]));
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.ScriptHandlerGenParamsPostExecute(
  AParams: TLMDPasParameters);
var
  i: Integer;
  s: WideString;
begin
  for i := 0 to AParams.Count - 1 do
    if AParams[i].Modifier in [ppmVar, ppmOut] then
    begin
      s := GenTypeFromVarStr(AParams[i].Type_, AParams[i].C_VarName);
      AddLine(AParams[i].Name + ' := ' + s + ';');
    end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GenTypeToVarStr(const AType: TLMDPasType;
  const AArg: string): string;
begin
  if AType.GetNodeKind = tnkTypeId then
    Result := GenTypeIdToVarStr(TLMDPasTypeId(AType).QualName, AArg)
  else
    Assert(False);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GenTypeFromVarStr(const AType: TLMDPasType;
  const AArg: string): string;
begin
  if AType.GetNodeKind = tnkTypeId then
    Result := GenTypeIdFromVarStr(TLMDPasTypeId(AType).QualName, AArg)
  else
    Assert(False);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GenTypeIdToVarStr(const AQualName: string;
  const AArg: string): string;
var
  wrrname: string;
begin
  wrrname := GetTypeWrapperFromQualTypeId(AQualName);

  case GetPredefinedSymbolConvKind(AQualName) of
    ckImplicit,
    ckVariant:   Result := AArg;
    ckCharConv:  Result := 'Ord(' + AArg + ')'; // Different Delphi versions
                                                // have different Char to
                                                // Variant conversion semantics.
                                                // We keep numeric semantic when
                                                // working with Char values.
    ckWrapper,
    ckError:
      Result := wrrname + '.ToVar(' + AArg + ')';
  end;
end;
                                      
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GenTypeIdFromVarStr(const AQualName,
  AArg: string): string;
var
  wrrname: string;
begin
  // [1]: Explicit conversion required for passing params to overloaded
  //      functions for proper overload resolution.
  // [2]: FindVarData is required while converting Variant to Variant,
  //      because in all other conversions var-ref dereferencings are
  //      performed automatically by Delphi, but in this case is NOT.
  //      So, without this, var/out parameters of Variant type will not
  //      work properly.

  wrrname := GetTypeWrapperFromQualTypeId(AQualName);

  case GetPredefinedSymbolConvKind(AQualName) of
    ckImplicit:  Result := AQualName + '(' + AArg + ')';                // [1]
    ckVariant:   Result := AQualName + '(FindVarData(' + AArg + ')^)';  // [2]
    ckCharConv:  Result := AQualName + '(Integer(' + AArg + '))';
    ckWrapper,
    ckError:     Result := wrrname + '.FromVar(' + AArg + ')';
  end;
end;
                                  
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GenTypeReuseStr(
  const AType: TLMDPasType): string;
begin
  if AType.GetNodeKind = tnkTypeId then
    Result := TLMDPasTypeId(AType).QualName
  else
    Assert(False);
end;
                                 
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.ConstraintString(const S: string;
  AMaxSize: Integer): string;
begin
  Result := S;
  if Length(Result) > AMaxSize then
    Result := Copy(Result, 1, AMaxSize - 3) + '...';
end;
                                
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetWrapperUnitName(
  const AUnitName: string): string;
begin
  Result := FDocument.FileHandler.GetWrapperUnitName(AUnitName);
end;
                                
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetWrapperTypeName(
  const ATypeName: string): string;
begin
  Result := ATypeName + '_sw';
end;
                               
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetMetaclassTypeName(
  const ATypeName: string): string;
begin
  Result := ATypeName + '_sc';
end;
                                  
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetProtectedAccessorName(
  const ATypeName: string): string;
begin
  Result := ATypeName + '_sacc';
end;
                                   
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetEventHandlerClassName(
  const ATypeName: string): string;
begin
  Result := ATypeName + '_sh';
end;
    
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetTypeWrapperFromQualTypeId(
  const AQualName: string): string;
var
  uname,
  tname: string;
begin
  ParseQualName(AQualName, uname, tname);

  Result := GetWrapperTypeName(tname);
  if uname <> '' then
  begin
    if SameText(uname, 'System') then
      Result := 'LMDSctSysWrappers.' + Result // Fuck me.
    else
      Result := GetWrapperUnitName(uname) + '.' + Result;
  end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.AddCaseEntryBegin(Idx: Integer);
var
  i:      Integer;
  s:      string;
  oldlen: Integer;
begin
  s := IntToStr(Idx) + ':';
  oldlen := Length(s);
  Assert(oldlen <= 6);

  SetLength(s, 6);
  for i := oldlen + 1 to Length(s) do
    s[i] := ' ';

  s := s + 'begin';

  AddLine(s);
  BeginIdent;
  BeginIdent;
  BeginIdent;
  BeginIdent;
end;
                                  
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.AddCaseEntryEnd;
begin
  EndIdent;
  EndIdent;
  EndIdent;
  EndIdent;
  AddLine('      end;');
end;
                                    
{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetIntfToVarHeader(
  const ATypeName: string): string;
begin
  Result := 'class function ToVar(const AValue: ' +
            ATypeName + '): OleVariant;';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetIntfFromVarHeader(
  const ATypeName: string): string;
begin
  Result := 'class function FromVar(const AValue: OleVariant): ' +
            ATypeName + ';';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetImplToVarHeader(const AClassName,
  ATypeName: string): string;
begin
  Result := 'class function ' + AClassName + '.ToVar(const AValue: ' +
            ATypeName + '): OleVariant;';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetImplFromVarHeader(const AClassName,
  ATypeName: string): string;
begin
  Result := 'class function ' + AClassName +
            '.FromVar(const AValue: OleVariant): ' +
            ATypeName + ';';
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDPasWrapperGenerator.Create(ADocument: TLMDUnitDocument);
begin
  inherited Create;
  FDocument := ADocument;
  FUnit     := ADocument.ParseTree;
  FLines    := TStringList.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDPasWrapperGenerator.Destroy;
begin
  FLines.Free;
  inherited;
end;
                                    
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.Generate;
begin
  FLines.Clear;
  FCurIdent     := 0;
  FCurEmptyLine := -1;
  GenUnit;
end;
                                     
{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.SaveToStream(AStream: TStream);
begin
  FLines.SaveToStream(AStream);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasWrapperGenerator.SaveToFile(const AFileName: string);
var
  stream: TFileStream;
begin
  stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(stream);
  finally
    stream.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasWrapperGenerator.GetUnitUnprefixedName: string;
var
  i:   Integer;
  dot: Integer;
begin
  dot := 0;
  for i := Length(FUnit.Name) downto 1 do
    if FUnit.Name[i] = '.' then
    begin
      dot := i;
      Break; // for
    end;

  if dot = 0 then
    Result := FUnit.Name
  else
    Result := Copy(FUnit.Name, dot + 1, MaxInt);
end;

function TLMDPasWrapperGenerator.GenTypeWrapperRef(
  const AType: TLMDPasType): string;
begin
  if AType.GetNodeKind = tnkTypeId then
    Result := GetTypeWrapperFromQualTypeId(TLMDPasTypeId(AType).QualName)
  else
    Assert(False);
end;

function TLMDPasWrapperGenerator.GenTypeIdWrapperRef(
  const AQualName: string): string;
begin
  Result := GetTypeWrapperFromQualTypeId(AQualName);
end;

procedure TLMDPasWrapperGenerator.GetAllVarOutParams(
  AMember: TLMDPasNamedNode; Result: TList);
var
  i:     Integer;
  prms:  TLMDPasParameters;
  group: TLMDPasOverloadGroup;
begin
  prms := nil;

  case AMember.GetNodeKind of
    tnkProcHeading:   prms := TLMDPasProcHeading(AMember).Parameters;
    tnkOverloadGroup: begin
                        group := TLMDPasOverloadGroup(AMember);
                        for i := 0 to group.Procs.Count - 1 do
                        begin
                          if FDocument.NodeChecked[group.Procs[i]] then
                            GetAllVarOutParams(group.Procs[i], Result);
                        end;
                      end;
    tnkProperty:      prms := TLMDPasProperty(AMember).Parameters;
  end;

  if prms <> nil then
  begin
    for i := 0 to prms.Count - 1 do
      if prms[i].Modifier in [ppmVar, ppmOut] then
        Result.Add(prms[i]);
  end;
end;

end.
