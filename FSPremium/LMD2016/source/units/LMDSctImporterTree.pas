unit LMDSctImporterTree;
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

LMDSctImporterTree unit (YB)
----------------------------
LMD Script Pack Importer Object Pascal parse tree.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, LMDHashTable;

type
  {************************ enum TLMDPasTreeNodeKind **************************}

  TLMDPasTreeNodeKind = (
    tnkUsedUnit, tnkUnit, tnkConstDecl, tnkTypeDecl, tnkVarDecl,
    tnkProcHeading, tnkOverloadGroup, tnkParameter, tnkProperty,
    tnkPropertyRedecl, tnkSubrangeType, tnkTypeId, tnkEnumType, tnkPointerType,
    tnkProcType, tnkClassRefType, tnkStaticArrayType, tnkDynamicArrayType,
    tnkSetType, tnkFileType, tnkRecordType, tnkClassType, tnkInterfaceType
  );

  {************************** class TLMDPasTreeNode ***************************}

  TLMDSupportKind = (skYes, skNo, skUnknown);

  TLMDPasTreeNode = class(TObject)
  private
    FC_Messages:    TStrings;
    FC_SupportKind: TLMDSupportKind;
    FV_Data:        TObject;
    FD_Data:        TObject;

    function GetC_Messages: TStrings;
  public
    constructor Create;
    destructor Destroy; override;

    function GetNodeKind: TLMDPasTreeNodeKind; virtual; abstract;
    function ToStr: string; virtual; abstract;    
  public
    property D_Data: TObject read FD_Data write FD_Data; // Document related.
    property V_Data: TObject read FV_Data write FV_Data; // View related.
  public
    { Compiler related }

    procedure C_Clear;
    property  C_SupportKind: TLMDSupportKind read FC_SupportKind write FC_SupportKind;
    property  C_Messages: TStrings read GetC_Messages;
  end;

  {************************** class TLMDPasTreeNodes **************************}

  TLMDPasTreeNodes = class
  private
    FItems:     TList;
    FFreeItems: Boolean;

    function GetCount: Integer;
    function GetItems(AIndex: Integer): TLMDPasTreeNode;
  protected
    procedure DoAdd(AItem: TLMDPasTreeNode); virtual;
    procedure DoClear; virtual;
  public
    constructor Create(AFreeItems: Boolean);
    destructor Destroy; override;

    procedure Add(AItem: TLMDPasTreeNode);
    procedure Clear;
    function  IndexOf(AItem: TLMDPasTreeNode): Integer;
    property  Count: Integer read GetCount;
    property  Items[AIndex: Integer]: TLMDPasTreeNode read GetItems; default;
  end;

  {************************** class TLMDPasNamedNode **************************}

  TLMDPasNamedNode = class(TLMDPasTreeNode)
  private
    FName:       string;
    FNameLocked: Boolean;
    procedure SetName(const Value: string);
  public
    constructor Create;
    property    Name: string read FName write SetName;
  end;

  {************************* class TLMDPasNamedNodes **************************}

  TLMDPasNamedNodes = class(TLMDPasTreeNodes)
  private
    FNameIndex: TLMDHashTable; // Lazy inited.

    function GetItems(AIndex: Integer): TLMDPasNamedNode;
  protected
    procedure DoAdd(AItem: TLMDPasTreeNode); override;
    procedure DoClear; override;
  public
    procedure Add(AItem: TLMDPasNamedNode);
    function  Find(const AName: string): TLMDPasNamedNode;
    property  Items[AIndex: Integer]: TLMDPasNamedNode read GetItems; default;
  end;

  {**************************** class TLMDPasType *****************************}

  TLMDPasUnit     = class;
  TLMDPasTypeDecl = class;

  TLMDPasTypeMember = class(TLMDPasNamedNode)
  public
    function MemberToStr(const ATypeName: string): string; virtual; abstract;
  end;

  TLMDPasType = class(TLMDPasTreeNode)
  private
    FOwner:      TLMDPasUnit;
    FParentDecl: TLMDPasTypeDecl;
  public
    constructor Create(AOwner: TLMDPasUnit); virtual;
    destructor Destroy; override;

    function Signature: string; virtual; abstract;
    property Owner: TLMDPasUnit read FOwner;                // A type is owned by
                                                            // unit. Other instances
                                                            // only refers to type.
    property ParentDecl: TLMDPasTypeDecl read FParentDecl
                                         write FParentDecl; // Optional. If type
                                                            // has no parent decl
                                                            // then it is implicitly
                                                            // defined unnamed type
                                                            // or just a type
                                                            // reference (type-id).
  end;

  {**************************** class TLMDPasTypes ****************************}

  TLMDPasTypes = class(TLMDPasTreeNodes)
  private
    function GetItems(AIndex: Integer): TLMDPasType;
  public
    procedure Add(AItem: TLMDPasType);
    property Items[AIndex: Integer]: TLMDPasType read GetItems; default;
  end;

  {************************** class TLMDPasUsedUnit ***************************}

  TLMDPasUsedUnit = class(TLMDPasNamedNode)
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
  public
    { Compiler related }
    C_FullName: string; // With prefixes.
  end;

  {************************** class TLMDPasUsedUnits **************************}

  TLMDPasUsedUnits = class(TLMDPasNamedNodes)
  private
    function GetItems(AIndex: Integer): TLMDPasUsedUnit;
  public
    procedure Add(AItem: TLMDPasUsedUnit);
    property  Items[AIndex: Integer]: TLMDPasUsedUnit read GetItems; default;
  end;

  {**************************** class TLMDPasUnit *****************************}

  TLMDPasUnit = class(TLMDPasNamedNode)
  private
    FDeclarations: TLMDPasNamedNodes;
    FUses: TLMDPasUsedUnits;
    FCreatedTypes: TList; // Private collection: only for types destruction.
                          // Not all types in this collection is actually exists
                          // in the unit. This is simplification of memory
                          // menegement when dealing with parser savepoints.
    procedure FreeCreatedTypes;
  public
    constructor Create;
    destructor Destroy; override;

    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    property Uses_: TLMDPasUsedUnits read FUses;
    property Declarations: TLMDPasNamedNodes read FDeclarations;
  end;

  {************************** class TLMDPasConstDecl **************************}

  TLMDPasConstKind = (ckUnknown,
                      ckTyped,
                      ckSimple, // Ord, Boolean, Float, String.
                      ckNil,
                      ckSet);

  TLMDPasConstDecl = class(TLMDPasTypeMember)
  private
    FKind: TLMDPasConstKind;
    FType: TLMDPasType;
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function MemberToStr(const ATypeName: string): string; override;
    property Kind:  TLMDPasConstKind read FKind write FKind;
    property Type_: TLMDPasType read FType write FType; // For ckTyped only.
  end;

  {************************** class TLMDPasTypeDecl ***************************}

  TLMDPasTypeDecl = class(TLMDPasTypeMember)
  private
    FTypeKwd:    Boolean;
    FType:       TLMDPasType;
    FIsTemplate: Boolean;
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function MemberToStr(const ATypeName: string): string; override;
    property TypeKwd: Boolean read FTypeKwd write FTypeKwd;
    property Type_: TLMDPasType read FType write FType;
    property IsTemplate: Boolean read FIsTemplate write FIsTemplate;
  end;

  {************************** class TLMDPasVarDecl ****************************}

  TLMDPasVarDecl = class(TLMDPasTypeMember)
  private
    FType:         TLMDPasType;
    FIsclassField: Boolean;
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function MemberToStr(const ATypeName: string): string; override;
    property Type_: TLMDPasType read FType write FType;
    property IsClassField: Boolean read FIsclassField write FIsclassField;
  end;

  {************************** class TLMDPasVarDecls ***************************}

  TLMDPasVarDecls = class(TLMDPasNamedNodes)
  private
    function GetItems(AIndex: Integer): TLMDPasVarDecl;
  public
    procedure Add(AItem: TLMDPasVarDecl);
    property  Items[AIndex: Integer]: TLMDPasVarDecl read GetItems; default;
  end;

  {************************* class TLMDPasProcHeading *************************}

  TLMDPasParameter  = class;
  TLMDPasParameters = class;

  TLMDPasProcKind = (ppkProcedure, ppkFunction, ppkClassProcedure,
                     ppkClassFunction, ppkConstructor, ppkDestructor);
  TLMDPasProcBody = (ppbNormal, ppbRecCreate, ppbRecCopy);

  TLMDPasProcHeading = class(TLMDPasTypeMember)
  private
    FParameters: TLMDPasParameters;
    FReturnType: TLMDPasType;
    FFuncKind:   TLMDPasProcKind;
    FBody:       TLMDPasProcBody;
    FIsTemplate: Boolean;
    FIsOverload: Boolean;
    FIsVirtual:  Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function MemberToStr(const ATypeName: string): string; override;

    property FuncKind: TLMDPasProcKind read FFuncKind write FFuncKind;
    property Body: TLMDPasProcBody read FBody write FBody;
    property Parameters: TLMDPasParameters read FParameters;
    property ReturnType: TLMDPasType read FReturnType write FReturnType; // nil for
                                                                         // procedures.
    property IsTemplate: Boolean read FIsTemplate write FIsTemplate;
    property IsOverload: Boolean read FIsOverload write FIsOverload;
    property IsVirtual: Boolean read FIsVirtual write FIsVirtual;
  end;

  {************************ class TLMDPasProcHeadings *************************}

  TLMDPasProcHeadings = class(TLMDPasNamedNodes)
  private
    function GetItems(AIndex: Integer): TLMDPasProcHeading;
  public
    procedure Add(AItem: TLMDPasProcHeading);
    property  Items[AIndex: Integer]: TLMDPasProcHeading read GetItems; default;
  end;

  {************************ class TLMDPasOverloadGroup ************************}

  TLMDPasOverloadGroup = class(TLMDPasTypeMember)
  private
    FProcs: TLMDPasProcHeadings;
  public
    constructor Create(const AName: string);
    destructor Destroy; override;

    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function MemberToStr(const ATypeName: string): string; override;

    property Procs: TLMDPasProcHeadings read FProcs;
  public
    { Compiler related }
    C_FuncKind:      TLMDPasProcKind;
    C_ParamCount:    Integer;
    C_OptionalCount: Integer;
  end;

  {************************* class TLMDPasParameters **************************}

  TLMDPasParameters = class(TLMDPasNamedNodes)
  private
    function GetItems(AIndex: Integer): TLMDPasParameter;
    function GetOptionalCount: Integer;
  public
    function ToStr: string;
    function Signature: string;

    procedure Add(AItem: TLMDPasParameter);
    property  Items[AIndex: Integer]: TLMDPasParameter read GetItems; default;
    property  OptionalCount: Integer read GetOptionalCount;
  end;

  {************************** class TLMDPasParameter **************************}

  TLMDPasParameterModifier = (ppmNone, ppmConst, ppmVar, ppmOut);

  TLMDPasParameter = class(TLMDPasNamedNode)
  private
    FIsArrayOfConst: Boolean;
    FIsOptional:     Boolean;
    FModifier:       TLMDPasParameterModifier;
    FType:           TLMDPasType;
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string;
    property Modifier: TLMDPasParameterModifier read FModifier write FModifier;
    property Type_: TLMDPasType read FType write FType; // nil for untyped 'var' or
                                                        // 'const' params. nil for
                                                        // 'array of const' params.
    property IsArrayOfConst: Boolean read FIsArrayOfConst write FIsArrayOfConst;
    property IsOptional: Boolean read FIsOptional write FIsOptional;
  public
    { Compiler related }
    C_VarName: string;
  end;

  {************************** class TLMDPasProperty ***************************}

  TLMDPasPropertyBase = class(TLMDPasTypeMember)
  private
    FIsDefault:   Boolean;
    FIsProtected: Boolean;
  public
    property IsProtected: Boolean read FIsProtected write FIsProtected;
    property IsDefault: Boolean read FIsDefault write FIsDefault;
  end;

  TLMDPasProperty = class(TLMDPasPropertyBase)
  private
    FIsReadable:  Boolean;
    FIsWritable:  Boolean;
    FParameters:  TLMDPasParameters;
    FType:        TLMDPasType;
    FIsClassProp: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function MemberToStr(const ATypeName: string): string; override;
    property Parameters: TLMDPasParameters read FParameters;
    property Type_: TLMDPasType read FType write FType;
    property IsClassProp: Boolean read FIsClassProp write FIsClassProp;
    property IsReadable: Boolean read FIsReadable write FIsReadable;
    property IsWritable: Boolean read FIsWritable write FIsWritable;
  end;

  TLMDPasPropertyRedecl = class(TLMDPasPropertyBase)
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function MemberToStr(const ATypeName: string): string; override;
  end;

  {************************ class TLMDPasSubrangeType *************************}

  TLMDPasSubrangeType = class(TLMDPasType)
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
  end;

  {*************************** class TLMDPasTypeId ****************************}

  TLMDPasTypeId = class(TLMDPasType)
  private
    FQualName:   string;
    FIsTemplate: Boolean;
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
    property QualName: string read FQualName write FQualName;
    property IsTemplate: Boolean read FIsTemplate write FIsTemplate;
  end;

  {************************** class TLMDPasEnumType ***************************}

  TLMDPasEnumType = class(TLMDPasType)
  private
    FEnumerators: TStrings;
  public
    constructor Create(AOwner: TLMDPasUnit); override;
    destructor Destroy; override;

    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
    property Enumerators: TStrings read FEnumerators;
  end;

  {************************ class TLMDPasPointerType **************************}

  TLMDPasPointerType = class(TLMDPasType)
  private
    FBaseType: TLMDPasType;
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
    property BaseType: TLMDPasType read FBaseType write FBaseType;
  end;

  {************************** class TLMDPasProcType ***************************}

  TLMDPasProcTypeKind = (ptkProcedure, ptkFunction);

  TLMDPasProcType = class(TLMDPasType)
  private
    FOfObject:     Boolean;
    FParameters:   TLMDPasParameters;
    FProcTypeKind: TLMDPasProcTypeKind;
    FReturnType:   TLMDPasType;
    FIsRefTo:      Boolean;
  public
    constructor Create(AOwner: TLMDPasUnit); override;
    destructor Destroy; override;

    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
    property ProcTypeKind: TLMDPasProcTypeKind read FProcTypeKind write FProcTypeKind;
    property Parameters: TLMDPasParameters read FParameters;
    property ReturnType: TLMDPasType read FReturnType write FReturnType; // nil for
                                                                         // procedures.
    property OfObject: Boolean read FOfObject write FOfObject;
    property IsRefTo: Boolean read FIsRefTo write FIsRefTo; // New Delphi 2009
                                                            // 'reference to function'
                                                            // type.
  end;

  {************************ class TLMDPasClassRefType *************************}

  TLMDPasClassRefType = class(TLMDPasType)
  private
    FBaseType: TLMDPasType;
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
    property BaseType: TLMDPasType read FBaseType write FBaseType;
  end;

  {************************ class TLMDPasArrayTypeBase ************************}

  TLMDPasArrayTypeBase = class(TLMDPasType)
  private
    FElemType: TLMDPasType;
  public
    property ElemType: TLMDPasType read FElemType write FElemType;
  end;

  {*********************** class TLMDPasStaticArrayType ***********************}

  TLMDPasStaticArrayType = class(TLMDPasArrayTypeBase)
  private
    FBounds: TLMDPasTypes;
  public
    constructor Create(AOwner: TLMDPasUnit); override;
    destructor Destroy; override;

    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
    property Bounds: TLMDPasTypes read FBounds;
  end;

  {********************** class TLMDPasDynamicArrayType ***********************}

  TLMDPasDynamicArrayType = class(TLMDPasArrayTypeBase)
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
  end;

  {*************************** class TLMDPasSetType ***************************}

  TLMDPasSetType = class(TLMDPasType)
  private
    FBaseType: TLMDPasType;
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
    property BaseType: TLMDPasType read FBaseType write FBaseType;
  end;

  {************************** class TLMDPasFileType ***************************}

  TLMDPasFileType = class(TLMDPasType)
  private
    FBaseType: TLMDPasType;
  public
    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
    property BaseType: TLMDPasType read FBaseType write FBaseType;
  end;

  {************************* class TLMDPasRecordType **************************}

  TLMDPasRecordType = class(TLMDPasType)
  private
    FMembers:   TLMDPasNamedNodes;
    FHelperFor: TLMDPasTypeId;
  public
    constructor Create(AOwner: TLMDPasUnit); override;
    destructor Destroy; override;

    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
    property Members: TLMDPasNamedNodes read FMembers;
    property HelperFor: TLMDPasTypeId read FHelperFor write FHelperFor;
  end;

  {************************* class TLMDPasClassType ***************************}

  TLMDPasClassType = class(TLMDPasType)
  private
    FAncestor:   TLMDPasTypeId;
    FMembers:    TLMDPasNamedNodes;
    FHelperFor:  TLMDPasTypeId;
  public
    constructor Create(AOwner: TLMDPasUnit); override;
    destructor Destroy; override;

    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
    property Ancestor: TLMDPasTypeId read FAncestor write FAncestor;
    property Members: TLMDPasNamedNodes read FMembers;
    property HelperFor: TLMDPasTypeId read FHelperFor write FHelperFor;
  end;

  {************************ class TLMDPasInterfaceType ************************}

  TLMDPasInterfaceType = class(TLMDPasType)
  private
    FInterfaces: TStrings;
    FMembers:    TLMDPasNamedNodes;
  public
    constructor Create(AOwner: TLMDPasUnit); override;
    destructor Destroy; override;

    function GetNodeKind: TLMDPasTreeNodeKind; override;
    function ToStr: string; override;
    function Signature: string; override;
    property Interfaces: TStrings read FInterfaces;           // Qual names.
    property Members: TLMDPasNamedNodes read FMembers;
  end;

implementation

type
  TNamedNodesTraits = class(TLMDHashTableTraits)
  public
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

{*************************** class TLMDPasTreeNode ****************************}
{ --------------------------------- private ---------------------------------- }

function TLMDPasTreeNode.GetC_Messages: TStrings;
begin
  if FC_Messages = nil then
    FC_Messages := TStringList.Create;
  Result := FC_Messages;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDPasTreeNode.Create;
begin
  inherited;
end;
                                                          
{ ---------------------------------------------------------------------------- }

destructor TLMDPasTreeNode.Destroy;
begin
  FC_Messages.Free;
  inherited;
end;

{ --------------------------------- public ----------------------------------- }

procedure TLMDPasTreeNode.C_Clear;
begin
  FC_SupportKind := skYes;
  FC_Messages.Free;
  FC_Messages := nil;
end;

{*************************** class TLMDPasTreeNodes ***************************}
{ --------------------------------- private ----------------------------------- }

function TLMDPasTreeNodes.GetCount: Integer;
begin
  Result := FItems.Count;
end;
                                                                  
{ ---------------------------------------------------------------------------- }

function TLMDPasTreeNodes.GetItems(AIndex: Integer): TLMDPasTreeNode;
begin
  Result := TLMDPasTreeNode(FItems[AIndex]);
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDPasTreeNodes.Create(AFreeItems: Boolean);
begin
  inherited Create;
  FItems     := TList.Create;
  FFreeItems := AFreeItems;
end;
                                                                 
{ ---------------------------------------------------------------------------- }

destructor TLMDPasTreeNodes.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasTreeNodes.DoAdd(AItem: TLMDPasTreeNode);
begin
  FItems.Add(AItem);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasTreeNodes.DoClear;
var
  i: Integer;
begin
  if FFreeItems then
  begin
    for i := 0 to FItems.Count - 1 do
      TLMDPasTreeNode(FItems[i]).Free;
  end;
  FItems.Count := 0;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasTreeNodes.Add(AItem: TLMDPasTreeNode);
begin
  DoAdd(AItem);
end;
                                                                 
{ ---------------------------------------------------------------------------- }

procedure TLMDPasTreeNodes.Clear;
begin
  DoClear;
end;
                                                               
{ ---------------------------------------------------------------------------- }

function TLMDPasTreeNodes.IndexOf(AItem: TLMDPasTreeNode): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

{*************************** class TLMDPasNamedNode ***************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDPasNamedNode.Create;
begin
  inherited;
end;

{************************** class TLMDPasNamedNodes ***************************}
{ --------------------------------- private ---------------------------------- }

function TLMDPasNamedNodes.GetItems(AIndex: Integer): TLMDPasNamedNode;
begin
  Result := TLMDPasNamedNode(inherited items[AIndex]);
end;

{ --------------------------------- public ----------------------------------- }

procedure TLMDPasNamedNodes.Add(AItem: TLMDPasNamedNode);
begin
  DoAdd(AItem);
end;
                                                                 
{ ---------------------------------------------------------------------------- }

procedure TLMDPasNamedNodes.DoAdd(AItem: TLMDPasTreeNode);
var
  i: Integer;
begin
  if Count >= 16 then
  begin
    if FNameIndex = nil then
    begin
      FNameIndex := TLMDHashTable.Create(TNamedNodesTraits);
      for i := 0 to Count - 1 do
        FNameIndex.Add(Items[i]);
    end;

    FNameIndex.Add(AItem);
    TLMDPasNamedNode(AItem).FNameLocked := True;
  end;

  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDPasNamedNodes.DoClear;
begin
  if FNameIndex <> nil then
  begin
    FNameIndex.Clear;
    FNameIndex := nil;
  end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasNamedNodes.Find(const AName: string): TLMDPasNamedNode;
var
  i: Integer;
begin
  if FNameIndex <> nil then
    Result := TLMDPasNamedNode(FNameIndex.Find(AName))
  else
  begin
    for i := 0 to FItems.Count - 1 do
      if SameText(TLMDPasNamedNode(FItems[i]).Name, AName) then
      begin
        Result := TLMDPasNamedNode(FItems[i]);
        Exit;
      end;

    Result := nil;
  end;
end;

{***************************** class TLMDPasType ******************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDPasType.Create(AOwner: TLMDPasUnit);
begin
  inherited Create;
  FOwner := AOwner;
  FOwner.FCreatedTypes.Add(Self);
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDPasType.Destroy;
begin
  FOwner.FCreatedTypes.Remove(Self);
  inherited;
end;

{***************************** class TLMDPasTypes *****************************}
{ --------------------------------- private ---------------------------------- }

function TLMDPasTypes.GetItems(AIndex: Integer): TLMDPasType;
begin
  Result := TLMDPasType(inherited Items[AIndex]);
end;

{ --------------------------------- public ----------------------------------- }

procedure TLMDPasTypes.Add(AItem: TLMDPasType);
begin
  inherited Add(AItem);
end;

{*************************** class TLMDPasUsedUnit ****************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasUsedUnit.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkUsedUnit;
end;
                                                           
{ ---------------------------------------------------------------------------- }

function TLMDPasUsedUnit.ToStr: string;
begin
  Result := 'uses ' + Name + ';';
end;

{*************************** class TLMDPasUsedUnits ***************************}
{ --------------------------------- private ---------------------------------- }

function TLMDPasUsedUnits.GetItems(AIndex: Integer): TLMDPasUsedUnit;
begin
  Result := TLMDPasUsedUnit(inherited Items[AIndex]);
end;

{ --------------------------------- public ----------------------------------- }

procedure TLMDPasUsedUnits.Add(AItem: TLMDPasUsedUnit);
begin
  inherited Add(AItem);
end;

{***************************** class TLMDPasUnit ******************************}
{ --------------------------------- private ---------------------------------- }

procedure TLMDPasUnit.FreeCreatedTypes;
begin
  while FCreatedTypes.Count > 0 do
    TLMDPasType(FCreatedTypes[0]).Free;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDPasUnit.Create;
begin
  inherited;
  FDeclarations := TLMDPasNamedNodes.Create(True);
  FUses         := TLMDPasUsedUnits.Create(True);
  FCreatedTypes := TList.Create;
end;
                                                              
{ ---------------------------------------------------------------------------- }

destructor TLMDPasUnit.Destroy;
begin
  FDeclarations.Free;
  FUses.Free;
  FreeCreatedTypes;
  inherited;
end;
                                                              
{ ---------------------------------------------------------------------------- }

function TLMDPasUnit.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkUnit;
end;
                                                           
{ ---------------------------------------------------------------------------- }

function TLMDPasUnit.ToStr: string;
begin
  Result := 'unit ' + Name + ';';
end;

{*************************** class TLMDPasConstDecl ***************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasConstDecl.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkConstDecl;
end;
                                                             
{ ---------------------------------------------------------------------------- }

function TLMDPasConstDecl.MemberToStr(const ATypeName: string): string;
begin
  Result := 'const ';
  if ATypeName <> '' then
    Result := Result + ATypeName + '.';
  Result := Result + Name;
  if Type_ <> nil then
    Result := Result + ': ' + Type_.ToStr;
  Result := Result + ' = <value>;';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasConstDecl.ToStr: string;
begin
  Result := MemberToStr('');
end;

{*************************** class TLMDPasTypeDecl ****************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasTypeDecl.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkTypeDecl;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasTypeDecl.MemberToStr(const ATypeName: string): string;
begin
  Result := 'type ';
  if ATypeName <> '' then
    Result := Result + ATypeName + '.';
  Result := Result + Name;

  if FIsTemplate then
    Result := Result + '<...>';

   Result := Result + ' = ' + Type_.ToStr + ';';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasTypeDecl.ToStr: string;
begin
  Result := MemberToStr('');
end;

{*************************** class TLMDPasVarDecl *****************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasVarDecl.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkVarDecl;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasVarDecl.MemberToStr(const ATypeName: string): string;
begin
  Result := 'var ';
  if ATypeName <> '' then
    Result := Result + ATypeName + '.';
  Result := Result + Name + ': ' + Type_.ToStr + ';';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasVarDecl.ToStr: string;
begin
  Result := 'var ' + Name + ': ' + Type_.ToStr + ';';
end;

{*************************** class TLMDPasVarDecls ****************************}
{ --------------------------------- private ---------------------------------- }

function TLMDPasVarDecls.GetItems(AIndex: Integer): TLMDPasVarDecl;
begin
  Result := TLMDPasVarDecl(inherited Items[AIndex]);
end;

{ --------------------------------- public ----------------------------------- }

procedure TLMDPasVarDecls.Add(AItem: TLMDPasVarDecl);
begin
  inherited Add(AItem);
end;

{************************** class TLMDPasProcHeading **************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDPasProcHeading.Create;
begin
  inherited;
  FParameters := TLMDPasParameters.Create(True);
  FBody       := ppbNormal;
end;
                                                                   
{ ---------------------------------------------------------------------------- }

destructor TLMDPasProcHeading.Destroy;
begin
  FParameters.Free;
  inherited;
end;
                                                                     
{ ---------------------------------------------------------------------------- }

function TLMDPasProcHeading.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkProcHeading;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasProcHeading.MemberToStr(const ATypeName: string): string;
begin
  Result := '';
  case FuncKind of
    ppkProcedure:       Result := 'procedure ';
    ppkFunction:        Result := 'function ';
    ppkClassProcedure:  Result := 'class procedure ';
    ppkClassFunction:   Result := 'class function ';
    ppkConstructor:     Result := 'constructor ';
    ppkDestructor:      Result := 'destructor ';
  end;

  if ATypeName <> '' then
    Result := Result + ATypeName + '.';
  Result := Result + Name;

  if FIsTemplate then
    Result := Result + '<...>';

  if Parameters.Count <> 0 then
    Result := Result + '(' + Parameters.ToStr + ')';
  if ReturnType <> nil then
    Result := Result + ': ' + ReturnType.ToStr;

  Result := Result + ';';
  if IsOverload then
    Result := Result + ' overload;';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasProcHeading.ToStr: string;
begin
  Result := MemberToStr('');
end;

{************************** class TLMDPasParameters ***************************}
{ --------------------------------- private ---------------------------------- }

function TLMDPasParameters.GetItems(AIndex: Integer): TLMDPasParameter;
begin
  Result := TLMDPasParameter(inherited Items[AIndex]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParameters.GetOptionalCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Count - 1 downto 0 do
  begin
    if not Items[i].IsOptional then
      Break; // for
    Inc(Result);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParameters.Signature: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
    Result := Result + Items[i].Signature + ';';
end;

{ --------------------------------- public ----------------------------------- }

function TLMDPasParameters.ToStr: string;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
  begin
    if i <> 0 then
      Result := Result + '; ';
    Result := Result + items[i].ToStr;
  end;
end;
                                                                      
{ ---------------------------------------------------------------------------- }

procedure TLMDPasParameters.Add(AItem: TLMDPasParameter);
begin
  inherited Add(AItem);
end;

{*************************** class TLMDPasParameter ***************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasParameter.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkParameter;
end;
                                                                         
{ ---------------------------------------------------------------------------- }

function TLMDPasParameter.Signature: string;
begin
  if IsArrayOfConst then
  begin
    Result := 'AOC';
    Exit;
  end;

  Result := '';
  case Modifier of
    ppmNone:      Result := '';
    ppmConst:     Result := 'C#';
    ppmVar:       Result := 'V#';
    ppmOut:       Result := 'O#';
  end;

  Result := Result + Name;
  if Type_ <> nil then
    Result := Result + ':' + Type_.Signature;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasParameter.ToStr: string;
begin
  if IsArrayOfConst then
  begin
    Result := 'array of const';
    Exit;
  end;

  Result := '';
  case Modifier of
    ppmNone:      Result := '';
    ppmConst:     Result := 'const ';
    ppmVar:       Result := 'var ';
    ppmOut:       Result := 'out ';
  end;

  Result := Result + Name;
  if Type_ <> nil then
    Result := Result + ': ' + Type_.ToStr;
end;

{*************************** class TLMDPasProperty ****************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDPasProperty.Create;
begin
  inherited;
  FParameters := TLMDPasParameters.Create(True);
end;
                                                              
{ ---------------------------------------------------------------------------- }

destructor TLMDPasProperty.Destroy;
begin
  FParameters.Free;
  inherited;
end;
                                                                
{ ---------------------------------------------------------------------------- }

function TLMDPasProperty.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkProperty;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasProperty.MemberToStr(const ATypeName: string): string;
begin
  Result := '';
  if IsProtected then
    Result := Result + 'protected ';
  Result := Result + 'property ';
  if ATypeName <> '' then
    Result := Result + ATypeName + '.';
  Result := Result + Name;
  if Parameters.Count <> 0 then
    Result := Result + '[' + Parameters.ToStr + ']';
  Result := Result + ': ' + Type_.ToStr;
  if IsReadable then
    Result := Result + ' read <getter>';
  if IsWritable then
    Result := Result + ' write <setter>';
  Result := Result + ';';
  if IsDefault then
    Result := Result + ' default;';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasProperty.ToStr: string;
begin
  Result := MemberToStr('');
end;

{************************ class TLMDPasPropertyRedecl *************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasPropertyRedecl.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkPropertyRedecl;
end;
                                                                    
{ ---------------------------------------------------------------------------- }

function TLMDPasPropertyRedecl.MemberToStr(const ATypeName: string): string;
begin
  Result := '';
  if IsProtected then
    Result := Result + 'protected ';
  Result := Result + 'property ';
  if ATypeName <> '' then
    Result := Result + ATypeName + '.';
  Result := Result + Name + ';';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasPropertyRedecl.ToStr: string;
begin
  Result := '';
  if IsProtected then
    Result := Result + 'protected ';
  Result := Result + 'property ' + Name + ';';
end;

{************************* class TLMDPasSubrangeType **************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasSubrangeType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkSubrangeType;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasSubrangeType.Signature: string;
begin
  Result := 'SR';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasSubrangeType.ToStr: string;
begin
  Result := '<min>..<max>';
end;

{**************************** class TLMDPasTypeId *****************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasTypeId.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkTypeId;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasTypeId.Signature: string;
begin
  Result := QualName;
  if FIsTemplate then
    Result := Result + '<>';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasTypeId.ToStr: string;
begin
  Result := QualName;
  if FIsTemplate then
    Result := Result + '<...>';
end;

{*************************** class TLMDPasEnumType ****************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDPasEnumType.Create;
begin
  inherited;
  FEnumerators := TStringList.Create;
end;
                                                                   
{ ---------------------------------------------------------------------------- }

destructor TLMDPasEnumType.Destroy;
begin
  FEnumerators.Free;
  inherited;
end;
                                                                   
{ ---------------------------------------------------------------------------- }

function TLMDPasEnumType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkEnumType;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasEnumType.Signature: string;
begin
  Result := 'E';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasEnumType.ToStr: string;
var
  i: Integer;
begin
  Result := '(';
  for i := 0 to Enumerators.Count - 1 do
  begin
    if i <> 0 then
      Result := Result + ', ';
    Result := Result + Enumerators[i];
  end;
  Result := Result + ')';
end;

{************************* class TLMDPasPointerType ***************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasPointerType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkPointerType;
end;
                                                                   
{ ---------------------------------------------------------------------------- }

function TLMDPasPointerType.Signature: string;
begin
  Result := '^' + BaseType.Signature;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasPointerType.ToStr: string;
begin
  Result := '^' + BaseType.ToStr;
end;

{*************************** class TLMDPasProcType ****************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDPasProcType.Create;
begin
  inherited;
  FParameters := TLMDPasParameters.Create(True);
end;
                                                                      
{ ---------------------------------------------------------------------------- }

destructor TLMDPasProcType.Destroy;
begin
  FParameters.Free;
  inherited;
end;
                                                                     
{ ---------------------------------------------------------------------------- }

function TLMDPasProcType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkProcType;
end;

function TLMDPasProcType.Signature: string;
begin
  Result := '';
  case ProcTypeKind of
    ptkProcedure:   Result := 'P';
    ptkFunction:    Result := 'F';
  end;

  if Parameters.Count <> 0 then
    Result := Result + '(' + Parameters.Signature + ')';
  if ReturnType <> nil then
    Result := Result + ':' + ReturnType.ToStr;

  if OfObject then
    Result := Result + '#O';
end;

function TLMDPasProcType.ToStr: string;
begin
  Result := '';
  case ProcTypeKind of
    ptkProcedure:   Result := 'procedure ';
    ptkFunction:    Result := 'function ';
  end;

  if Parameters.Count <> 0 then
    Result := Result + '(' + Parameters.ToStr + ')';
  if ReturnType <> nil then
    Result := Result + ': ' + ReturnType.ToStr;

  if OfObject then
    Result := Result + ' of object';
end;

{************************* class TLMDPasClassRefType **************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasClassRefType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkClassRefType;
end;
                                                                     
{ ---------------------------------------------------------------------------- }

function TLMDPasClassRefType.Signature: string;
begin
  Result := 'CR:' + BaseType.Signature;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasClassRefType.ToStr: string;
begin
  Result := 'class of ' + BaseType.ToStr;
end;

{************************ class TLMDPasStaticArrayType ************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDPasStaticArrayType.Create;
begin
  inherited;
  FBounds := TLMDPasTypes.Create(False);
end;
                                                                    
{ ---------------------------------------------------------------------------- }

destructor TLMDPasStaticArrayType.Destroy;
begin
  FBounds.Free;
  inherited;
end;
                                                                     
{ ---------------------------------------------------------------------------- }

function TLMDPasStaticArrayType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkStaticArrayType;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasStaticArrayType.Signature: string;
var
  i: Integer;
begin
  Result := 'A[';
  for i := 0 to Bounds.Count - 1 do
  begin
    if i <> 0 then
      Result := Result + ',';
    Result := Result + Bounds[i].Signature;
  end;
  Result := Result + ']:' + ElemType.Signature;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasStaticArrayType.ToStr: string;
var
  i: Integer;
begin
  Result := 'array[';
  for i := 0 to Bounds.Count - 1 do
  begin
    if i <> 0 then
      Result := Result + ', ';
    Result := Result + Bounds[i].ToStr;
  end;
  Result := Result + '] of ' + ElemType.ToStr;
end;

{*********************** class TLMDPasDynamicArrayType ************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasDynamicArrayType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkDynamicArrayType;
end;
                                                                       
{ ---------------------------------------------------------------------------- }

function TLMDPasDynamicArrayType.Signature: string;
begin
  Result := 'A:' + ElemType.Signature;
end;

function TLMDPasDynamicArrayType.ToStr: string;
begin
  Result := 'array of ' + ElemType.ToStr;
end;

{**************************** class TLMDPasSetType ****************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasSetType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkSetType;
end;
                                                                      
{ ---------------------------------------------------------------------------- }

function TLMDPasSetType.Signature: string;
begin
  Result := 'S:' + BaseType.ToStr;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasSetType.ToStr: string;
begin
  Result := 'set of ' + BaseType.ToStr;
end;

{*************************** class TLMDPasFileType ****************************}
{ --------------------------------- public ----------------------------------- }

function TLMDPasFileType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkFileType;
end;
                                                                      
{ ---------------------------------------------------------------------------- }

function TLMDPasFileType.Signature: string;
begin
  Result := 'F:' + BaseType.Signature;
end;

function TLMDPasFileType.ToStr: string;
begin
  Result := 'file of ' + BaseType.ToStr;
end;

{************************** class TLMDPasRecordType ***************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDPasRecordType.Create;
begin
  inherited;
  FMembers := TLMDPasNamedNodes.Create(True);
end;
                                                                   
{ ---------------------------------------------------------------------------- }

destructor TLMDPasRecordType.Destroy;
begin
  FMembers.Free;
  inherited;
end;
                                                                       
{ ---------------------------------------------------------------------------- }

function TLMDPasRecordType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkRecordType;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasRecordType.Signature: string;
begin
  Result := 'R';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasRecordType.ToStr: string;
begin
  Result := 'record';
end;

{************************** class TLMDPasClassType ****************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDPasClassType.Create;
begin
  inherited;
  FMembers := TLMDPasNamedNodes.Create(True);
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDPasClassType.Destroy;
begin
  FAncestor.Free;
  FMembers.Free;
  inherited;
end;
                                                                   
{ ---------------------------------------------------------------------------- }

function TLMDPasClassType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkClassType;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasClassType.Signature: string;
begin
  Result := 'C';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasClassType.ToStr: string;
begin
  Result := 'class';
  if Ancestor <> nil then
    Result := Result + '(' + Ancestor.ToStr + ')';
end;

{************************* class TLMDPasInterfaceType *************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDPasInterfaceType.Create;
begin
  inherited;
  FInterfaces := TStringList.Create;
  FMembers    := TLMDPasNamedNodes.Create(True);
end;
                                                                     
{ ---------------------------------------------------------------------------- }

destructor TLMDPasInterfaceType.Destroy;
begin
  FInterfaces.Free;
  FMembers.Free;
  inherited;
end;
                                                                      
{ ---------------------------------------------------------------------------- }

function TLMDPasInterfaceType.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkInterfaceType;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasInterfaceType.Signature: string;
begin
  Result := 'I';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasInterfaceType.ToStr: string;
var
  i: Integer;
begin
  Result := 'interface';
  if Interfaces.Count <> 0 then
  begin
    Result := Result + '(';
    for i := 0 to Interfaces.Count - 1 do
    begin
      if i <> 0 then
        Result := Result + ', ';
      Result := Result + Interfaces[i];
    end;
    Result := Result + ')';
  end;
end;
                                            
{ ---------------------------------------------------------------------------- }

procedure TLMDPasNamedNode.SetName(const Value: string);
begin
  Assert(not FNameLocked);
  FName := Value;
end;

{ ---------------------------------------------------------------------------- }

class function TNamedNodesTraits.Compare(const AKey; AItem: TObject): Boolean;
begin
  Result := SameText(TLMDPasNamedNode(AItem).FName, string(AKey));
end;

{ ---------------------------------------------------------------------------- }

class function TNamedNodesTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := MakeHashK(TLMDPasNamedNode(AItem).FName);
end;

{ ---------------------------------------------------------------------------- }

class function TNamedNodesTraits.MakeHashK(const AKey): Integer;
begin
  Result := TLMDHashTable.StrHash(UpperCase(string(AKey)));
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDPasOverloadGroup.Create(const AName: string);
begin
  inherited Create;
  FProcs := TLMDPasProcHeadings.Create(True);
  Name   := AName;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDPasOverloadGroup.Destroy;
begin
  FProcs.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasOverloadGroup.GetNodeKind: TLMDPasTreeNodeKind;
begin
  Result := tnkOverloadGroup;
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasOverloadGroup.MemberToStr(const ATypeName: string): string;
begin
  Result := 'procedure/function ';
  if ATypeName <> '' then
    Result := Result + ATypeName + '.';
  Result := Result + Name + '(...); overload;';
end;

{ ---------------------------------------------------------------------------- }

function TLMDPasOverloadGroup.ToStr: string;
begin
  Result := MemberToStr('');
end;

{ ---------------------------------------------------------------------------- }

{ TLMDPasProcHeadings }

procedure TLMDPasProcHeadings.Add(AItem: TLMDPasProcHeading);
begin
  inherited Add(AItem);
end;

function TLMDPasProcHeadings.GetItems(AIndex: Integer): TLMDPasProcHeading;
begin
  Result := TLMDPasProcHeading(inherited Items[AIndex]);
end;

end.
