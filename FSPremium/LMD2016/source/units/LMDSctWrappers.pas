unit LMDSctWrappers;
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

LMDSctWrappers unit (YB)
------------------------
LMD Script Pack base classes for wrapping Delphi types.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Variants, TypInfo, ActiveX, LMDStrings,
  LMDUnicode, LMDHashTable, LMDTypes, LMDSctClass;

type
  // NOTE: All wrappers uses WideString type to keep wrapper
  //       units format stable. Do not change it to TLMDString.

  {************************** Wrapper base classes ****************************}

  TLMDWrapper          = class;
  TLMDWrapperClass     = class of TLMDWrapper;
  TLMDWrapperData      = class;
  TLMDWrapperDataClass = class of TLMDWrapperData;
  TLMDTypeWrapper      = class;
  TLMDTypeWrapperClass = class of TLMDTypeWrapper;

  TLMDWrapperData = class
  protected
    FWrapperClass: TLMDWrapperClass;
  public
    constructor Create(AWrapperClass: TLMDWrapperClass); virtual;
  end;

  TLMDWrapper = class(TInterfacedObject)
  private
    class function  GetData: TLMDWrapperData;
    class function  GetDataClass: TLMDWrapperDataClass; virtual;
    class procedure InitData(AData: TLMDWrapperData); virtual;
  end;

  {********************* Dispatch wrapper base classes ************************}

  TLMDDispWrapper     = class;
  TLMDDispWrapperData = class;

  TLMDInvokeItemAttrs = set of (iiaHidden, iiaOptParams, iiaNoResult,
                                iiaMetaMember, iiaConstructor, iiaDefaultProp);
  TLMDDispArgs        = array[0..1024] of OleVariant;
  TLMDInvokeProc      = function(var AObj; const AArgs: TLMDDispArgs;
                                 AArgsSize: Integer; IsGet: Boolean): OleVariant;

  TLMDDebugTypeFunc = function: TVarType of object;

  TLMDInvokeItem = class
  public
    Index:         Integer;
    UppName:       WideString; // Upper-cased name.
    Name:          WideString;
    InvokeProc:    TLMDInvokeProc;
    DebugType:     TLMDDebugTypeFunc; // Can be nil.
    Attrs:         TLMDInvokeItemAttrs;
    ParamCount:    Integer;
    MinParamCount: Integer;
    InvokeFlags:   DWORD;
    ResMask:       DWORD; // Zero for 'void' procedures,
                          // otherwise - $FFFFFFFF.
  public
    procedure Assign(AItem: TLMDInvokeItem);
  end;

  TLMDAbstractDispInfo = class
  private
    FTypeInfo: ITypeInfo;

    function IndexOfInvokeItem(const AName: WideString;
                               AAllowHidden: Boolean = False): Integer; virtual; abstract;
    function GetInvokeItem(AIndex: Integer): TLMDInvokeItem; virtual; abstract;
    function GetInvokeItemCount: Integer; virtual; abstract;
  public
    constructor Create;
  end;

  TLMDDispInfo = class(TLMDAbstractDispInfo)
  private
    FItems:     array of TLMDInvokeItem; // Zero item is a default item which
                                         // is always exist and used to
                                         // handle DISPID_VALUE requirests.
    FCount:     Integer;
    FNameIndex: TLMDHashTable;

    procedure Clear;
    procedure AddItem(AItem: TLMDInvokeItem);
    procedure InitDispidValueItem;
    function  IndexOfInvokeItem(const AName: WideString;
                                AAllowHidden: Boolean = False): Integer; override;
    function  GetInvokeItem(AIndex: Integer): TLMDInvokeItem; override;
    function  GetInvokeItemCount: Integer; override;
    procedure AddInvokeItem(const AName: WideString; AType: TLMDDebugTypeFunc;
                            AAttrs: TLMDInvokeItemAttrs; AParamCount: Integer;
                            AInvokeFlags: Word; AInvokeProc: TLMDInvokeProc); overload;
    procedure AddInvokeItem(AItem: TLMDInvokeItem; AUnhide: Boolean = False;
                            AIsDefaultProp: Boolean = False); overload;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TLMDDispWrapperData = class(TLMDWrapperData)
  private
    FDispInfo: TLMDDispInfo;

    procedure AddDispMethod(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                            AParamCount: Integer; AResultType: TLMDDebugTypeFunc;
                            AHasOptParams, AIsMetaMember: Boolean;
                            AIsHidden: Boolean = False);
    procedure AddDispConstructor(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                                 AParamCount: Integer; AResultType: TLMDDebugTypeFunc;
                                 AHasOptParams: Boolean; AIsHidden: Boolean = False);
    procedure AddDispProp(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                          AType: TLMDDebugTypeFunc; AIsReadable, AIsWritable: Boolean;
                          AParamCount: Integer; AIsMetaMember: Boolean;
                          AIsHidden: Boolean = False; AIsDefault: Boolean = False);
  public
    constructor Create(AWrapperClass: TLMDWrapperClass); override;
    destructor Destroy; override;
  end;

  ILMDDispWrapper = interface
    ['{1ADE176B-20A5-4B78-8247-2FCDDCBAA38A}']
    function GetSelf: TLMDDispWrapper;
  end;

  TLMDDispWrapper = class(TLMDWrapper, ILMDDispWrapper, IDispatch)
  private
    function EncodeInvokeError(E: Exception; AEInfo: PExcepInfo): HRESULT;

    class function GetDataClass: TLMDWrapperDataClass; override;
    function       GetDispInfo: TLMDAbstractDispInfo; virtual;
    function       LowInvoke(AItem: TLMDInvokeItem; const AArgs: TLMDDispArgs;
                             AArgsSize: Integer; AIsGet: Boolean): OleVariant; virtual;
    { IDispatch }

    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
                           NameCount, LocaleID: Integer;
                           DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
                    Flags: Word; var Params; VarResult, ExcepInfo,
                    ArgErr: Pointer): HResult; stdcall;

    { ILMDDispWrapper }

    function GetSelf: TLMDDispWrapper;
  end;

  {***************** Type and metatype wrapper base classes *******************}

  TLMDTypeWrapperData = class(TLMDDispWrapperData)
  private
    FMetatypeWrapper: IDispatch; // Lazy inited. Use
                                 // TLMDTypeWrapper.GetMetatypeWrapper
                                 // instead.
  end;

  TLMDTypeWrapper = class(TLMDDispWrapper)
  private
    class function GetDataClass: TLMDWrapperDataClass; override;
    class function TypeToVariant: OleVariant; virtual;
    class function LowMetaInvoke(AItem: TLMDInvokeItem; const AArgs: TLMDDispArgs;
                                 AArgsSize: Integer; AIsGet: Boolean): OleVariant; virtual;
  protected
    class function GetTypeName: WideString; virtual;
    class function GetVarType: TVarType; virtual;
  public
    constructor Create; virtual;
  end;

  TLMDMetatypeDispInfo = class(TLMDAbstractDispInfo)
  private
    FOriginalInfo: TLMDAbstractDispInfo;

    function IndexOfInvokeItem(const AName: WideString;
                               AAllowHidden: Boolean = False): Integer; override;
    function GetInvokeItem(AIndex: Integer): TLMDInvokeItem; override;
    function GetInvokeItemCount: Integer; override;
  public
    constructor Create(AOriginalInfo: TLMDAbstractDispInfo);
  end;

  TLMDMetatypeWrapper = class(TLMDDispWrapper)
  private
    FType:     TLMDTypeWrapperClass;
    FDispInfo: TLMDMetatypeDispInfo;

    class function GetDataClass: TLMDWrapperDataClass; override;
    function       GetDispInfo: TLMDAbstractDispInfo; override;
    function       LowInvoke(AItem: TLMDInvokeItem; const AArgs: TLMDDispArgs;
                             AArgsSize: Integer; AIsGet: Boolean): OleVariant; override;
  public
    constructor Create(AType: TLMDTypeWrapperClass);
    destructor Destroy; override;
  end;

  {********************** Predefined Wrapper base classes *********************}

  TLMDPredTypeWrapper      = class(TLMDTypeWrapper);
  TLMDPredTypeWrapperClass = class of TLMDPredTypeWrapper;

  {********************** Class Wrapper base classes **************************}

  TLMDClassWrapper      = class;
  TLMDClassWrapperClass = class of TLMDClassWrapper;

  TLMDClassWrapperData = class(TLMDTypeWrapperData)
  private
    FRedecls: TStrings;

    function HasRedecls: Boolean;
    function GetRedecls: TStrings;
  public
    constructor Create(AWrapperClass: TLMDWrapperClass); override;
    destructor Destroy; override;

    procedure AddConstant(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                          AType: TLMDTypeWrapperClass; AVarType: TVarType = varEmpty);
    procedure AddField(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                       AType: TLMDTypeWrapperClass);
    procedure AddClassField(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                            AType: TLMDTypeWrapperClass);
    procedure AddConstructor(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                             AParamsCount: Integer; AHasOptionalParams: Boolean = False);
    procedure AddProcedure(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                           AParamsCount: Integer; AHasOptionalParams: Boolean = False);
    procedure AddFunction(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                          AResultType: TLMDTypeWrapperClass; AParamsCount: Integer;
                          AHasOptionalParams: Boolean = False);
    procedure AddClassProcedure(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                                AParamsCount: Integer; AHasOptionalParams: Boolean = False);
    procedure AddClassFunction(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                               AResultType: TLMDTypeWrapperClass; AParamsCount: Integer;
                               AHasOptionalParams: Boolean = False);
    procedure AddProperty(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                          AType: TLMDTypeWrapperClass; AIsReadable, AIsWritable: Boolean;
                          AParamsCount: Integer; AIsProtected: Boolean = False;
                          AIsDefault: Boolean = False);
    procedure AddClassProperty(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                               AType: TLMDTypeWrapperClass; AIsReadable, AIsWritable: Boolean;
                               AParamsCount: Integer; AIsProtected: Boolean = False);
    procedure AddPropertyRedecl(const AName: WideString; AIsDefault: Boolean = False);
  end;

  TLMDClassWrapper = class(TLMDTypeWrapper)
  private
    FValue: TObject;

    class function  GetDataClass: TLMDWrapperDataClass; override;
    class procedure InitData(AData: TLMDWrapperData); override;
    function        LowInvoke(AItem: TLMDInvokeItem; const AArgs: TLMDDispArgs;
                              AArgsSize: Integer; AIsGet: Boolean): OleVariant; override;
    class function  LowMetaInvoke(AItem: TLMDInvokeItem; const AArgs: TLMDDispArgs;
                                  AArgsSize: Integer; AIsGet: Boolean): OleVariant; override;
  protected
    class function  ConvToVar(AObject: TObject): OleVariant;
    class function  ConvFromVar(const AObject: OleVariant;
                                AReqClass: TClass = nil): TObject;
    class function  ConvClsToVar(AClass: TClass): OleVariant;
    class function  ConvClsFromVar(const AClass: OleVariant;
                                   AReqMetaclass: TClass = nil): TClass;

    class function  GetTypeName: WideString; override;
    class function  GetVarType: TVarType; override;
    class function  GetWrappedClass: TClass; virtual;
    class procedure DoInit(AData: TLMDClassWrapperData); virtual;
  public
    constructor Create(AValue: TObject);  reintroduce; virtual;
    destructor Destroy; override;
  end;

  {********************* Metaclass Wrapper base classes ***********************}

  TLMDMetaclassWrapper      = class;
  TLMDMetaclassWrapperClass = class of TLMDMetaclassWrapper;

  TLMDMetaclassWrapper = class(TLMDTypeWrapper)
  private
    class function TypeToVariant: OleVariant; override;
  protected
    class function ConvToVar(AClass: TClass): OleVariant;
    class function ConvFromVar(const AClass: OleVariant;
                               AReqMetaclass: TClass = nil): TClass;

    class function GetVarType: TVarType; override;
    class function GetWrappedBaseClass: TClass; virtual;
  end;

  {********************** Record Wrapper base classes *************************}

  TLMDRecordWrapper      = class;
  TLMDRecordWrapperClass = class of TLMDRecordWrapper;

  TLMDRecordWrapperData = class(TLMDTypeWrapperData)
  public
    procedure AddConstant(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                          AType: TLMDTypeWrapperClass; AVarType: TVarType = varEmpty);
    procedure AddField(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                       AType: TLMDTypeWrapperClass);
    procedure AddClassField(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                            AType: TLMDTypeWrapperClass);
    procedure AddConstructor(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                             AParamsCount: Integer; AHasOptionalParams: Boolean = False);
    procedure AddProcedure(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                           AParamsCount: Integer; AHasOptionalParams: Boolean = False);
    procedure AddFunction(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                          AResultType: TLMDTypeWrapperClass; AParamsCount: Integer;
                          AHasOptionalParams: Boolean = False);
    procedure AddClassProcedure(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                                AParamsCount: Integer; AHasOptionalParams: Boolean = False);
    procedure AddClassFunction(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                               AResultType: TLMDTypeWrapperClass; AParamsCount: Integer;
                               AHasOptionalParams: Boolean = False);
    procedure AddProperty(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                          AType: TLMDTypeWrapperClass; AIsReadable, AIsWritable: Boolean;
                          AParamsCount: Integer; AIsProtected: Boolean = False;
                          AIsDefault: Boolean = False);
    procedure AddClassProperty(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                               AType: TLMDTypeWrapperClass; AIsReadable, AIsWritable: Boolean;
                               AParamsCount: Integer; AIsProtected: Boolean = False);
  end;

  TLMDRecordWrapper = class(TLMDTypeWrapper)
  private
    class function  GetDataClass: TLMDWrapperDataClass; override;
    class procedure InitData(AData: TLMDWrapperData); override;
    function        LowInvoke(AItem: TLMDInvokeItem; const AArgs: TLMDDispArgs;
                              AArgsSize: Integer; AIsGet: Boolean): OleVariant; override;
    class function  LowMetaInvoke(AItem: TLMDInvokeItem; const AArgs: TLMDDispArgs;
                                  AArgsSize: Integer; AIsGet: Boolean): OleVariant; override;
  protected
    class function  ConvToVar(wrpr: TLMDRecordWrapper): OleVariant;
    class function  ConvFromVar(const ARecord: OleVariant): TLMDRecordWrapper;

    class function  GetVarType: TVarType; override;
    function        CloneVal: TLMDRecordWrapper; virtual;
    class procedure DoInit(AData: TLMDRecordWrapperData); virtual;
  public
    constructor Create; reintroduce; virtual;
  end;

  {*********************** Enum Wrapper base classes **************************}

  TLMDEnumWrapper      = class;
  TLMDEnumWrapperClass = class of TLMDEnumWrapper;

  PLMDEnumerator = ^TLMDEnumerator;
  TLMDEnumerator = record
    Name:  string;
    Value: Integer;
  end;

  TLMDEnumWrapper = class(TLMDTypeWrapper)
  private
    class procedure RegisterEnumerators(AUnitData: TLMDWrapperData);
  protected
    class function  GetEnumTypeInfo: TLMDTypeInfo; virtual;
    class procedure GetEnumerators(out AEnums: PLMDEnumerator;
                                   out ACount: Integer); virtual;
    class function  GetTypeName: WideString; override;
    class function  GetVarType: TVarType; override;
  end;

  {*********************** Set Wrapper base classes ***************************}

  TLMDSetWrapper      = class;
  TLMDSetWrapperClass = class of TLMDSetWrapper;

  TLMDSetWrapper = class(TLMDTypeWrapper)
  protected
    class function  ConvToVar(ASetPtr: Pointer): OleVariant;
    class procedure ConvFromVar(const ASet: OleVariant; AResPtr: Pointer);

    class function  GetVarType: TVarType; override;
    class function  GetSetSizeOf: Integer; virtual;
  end;

  {********************** Subrange Wrapper base classes ***********************}

  TLMDSubrangeWrapper      = class;
  TLMDSubrangeWrapperClass = class of TLMDSubrangeWrapper;

  TLMDSubrangeWrapper = class(TLMDTypeWrapper)
  protected
    class function GetVarType: TVarType; override;
  end;

  {********************** Event Type Wrapper base classes *********************}

  TLMDEventWrapper      = class;
  TLMDEventWrapperClass = class of TLMDEventWrapper;

  TLMDScriptHandlerWrapper = class(TLMDDispWrapper)
  private
    FScriptControl: TObject; // TLMDScriptControl
    FProcName:      WideString;
  public
    constructor Create(AScriptControl: TObject; const AProcName: WideString);
  end;

  TLMDEventWrapper = class(TLMDTypeWrapper)
  private
    FValue: TMethod;
  protected
    class function ConvToVar(AEvent: TMethod): OleVariant;
    class function ConvToVarS(AScriptControl: TObject;
                              const AProcName: WideString): OleVariant;
    class function ConvFromVar(const AEvent: OleVariant): TMethod;

    class function GetVarType: TVarType; override;
  public
    constructor Create(AValue: TMethod);  reintroduce; virtual;

    class function GetScriptHandlerClass: TClass; virtual; // TLMDScriptEventHandlerClass
    class function ToVar(AScriptControl: TObject;
                         const AProcName: WideString): OleVariant;
  end;

  {************************ Unit Wrapper base classes *************************}

  TLMDUnitWrapper      = class;
  TLMDUnitWrapperClass = class of TLMDUnitWrapper;

  TLMDUnitEnumerators = class
  private
    FCount:  Integer;
    FValues: TLMDIntArray;

    function GetValues(AIndex: Integer): Integer;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure Add(AValue: Integer);
    property Count: Integer read FCount;
    property Values[AIndex: Integer]: Integer read GetValues; default;
  end;

  TLMDUnitWrapperData = class(TLMDDispWrapperData)
  private
    FFoundEnums:   TList;
    FEnumerators:  TLMDUnitEnumerators;
    FNonEnumCount: Integer;

    procedure RegisterEnumerator(const AName: WideString;
                                 AType: TLMDTypeWrapperClass;
                                 AValue: Integer);
    procedure EnumFound(AWrapperClass: TLMDEnumWrapperClass);
    procedure PostprocessEnums;
  public
    constructor Create(AWrapperClass: TLMDWrapperClass); override;
    destructor Destroy; override;

    procedure AddConstant(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                          AType: TLMDTypeWrapperClass; AVarType: TVarType = varEmpty);
    procedure AddVariable(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                          AType: TLMDTypeWrapperClass);
    procedure AddProcedure(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                           AParamsCount: Integer; AHasOptionalParams: Boolean = False);
    procedure AddFunction(const AName: WideString; AInvokeProc: TLMDInvokeProc;
                          AResultType: TLMDTypeWrapperClass; AParamsCount: Integer;
                          AHasOptionalParams: Boolean = False);
    procedure AddType(AWrapperClass: TLMDTypeWrapperClass; AInvokeProc: TLMDInvokeProc);
  end;

  TLMDUnitWrapper = class(TLMDDispWrapper)
  private
    FScriptControl: TObject;

    class function  GetDataClass: TLMDWrapperDataClass; override;
    class procedure InitData(AData: TLMDWrapperData); override;
    function        LowInvoke(AItem: TLMDInvokeItem; const AArgs: TLMDDispArgs;
                              AArgsSize: Integer; AIsGet: Boolean): OleVariant; override;
  protected
    class function ConvToVar(AWrapperClass: TLMDTypeWrapperClass): OleVariant;
    class function ConvFromVar(const AType: OleVariant;
                               AAllowNil: Boolean): TLMDTypeWrapperClass;

    class procedure DoInit(AData: TLMDUnitWrapperData); virtual;
  public
    constructor    Create(AScriptControl: TObject); virtual;
    class function GetUnitName: WideString; virtual;
    class function TypeToVar(AWrapperClass: TLMDTypeWrapperClass): OleVariant;
    property       ScriptControl: TObject read FScriptControl; // TLMDScriptControl
  end;

{*************************** Wrappers Related Utils ***************************}

procedure RegisterUnitWrapper(AWrapperClass: TLMDUnitWrapperClass);
function  GetUnitWrapperClassList: TList;

procedure RegisterClassWrapper(AWrapperClass: TLMDClassWrapperClass);
procedure RegisterEventWrapper(AEventType: PTypeInfo;
                               AWrapperClass: TLMDEventWrapperClass);

function  GetEventWrapperClass(AEventType: PTypeInfo): TLMDEventWrapperClass;

function  MakeVarRef(var RefToVar: OleVariant): OleVariant;
procedure AssignRefParam(const ARefParam, AValue: OleVariant);

procedure WrongArgCountError(AMethodName: TLMDString); overload;
procedure WrongArgCountError(AIdx: Integer; AWrap: TLMDDispWrapper); overload;

function  VarObjectIs(const AObject, AClass: OleVariant): OleVariant; overload;
function  VarObjectIs(AObject: TObject; AClass: OleVariant): OleVariant; overload;
function  LMDVarNil: OleVariant;

function  VarRecIs(const ARecord, ARecType: OleVariant): OleVariant;
function  VarRecNew(const ARecType: OleVariant): OleVariant; overload;
function  VarRecNew(const ARecType: TLMDRecordWrapperClass): OleVariant; overload;
function  VarRecCopy(const ARecord: OleVariant): OleVariant; overload;
function  VarRecCopy(const ARecord: TLMDRecordWrapper): OleVariant; overload;

function  VarObjOrRecIs(const AVal, AType: OleVariant): OleVariant;
function  VarObjOrRecNew(const AType: OleVariant; AArgs: PLMDVarArray;
                         AArgCount: Integer): OleVariant;

function  VarSetEmpty: OleVariant;
function  VarSetInclude(const ASet, AElem: OleVariant): OleVariant;
function  VarSetExclude(const ASet, AElem: OleVariant): OleVariant;
function  VarSetIn(const AElem, ASet: OleVariant): OleVariant;
function  VarSetMake(const AElems: TLMDDispArgs; AElemsSize: Integer): OleVariant;
function  LMDSetToVar(ASizeOf: Integer; const ASet): OleVariant;

implementation

uses
  LMDSctCst, LMDSctMemMgr, LMDSctSysWrappers, LMDSctScripter, ComObj,
  SyncObjs, Math, Forms;

{ ---------------------------------------------------------------------------- }

type
  PNamesArray   = ^TNamesArray;
  TNamesArray   = array [0..0] of PWideChar;
  PDispIdsArray = ^TDispIdsArray;
  TDispIdsArray = array [0..0] of Integer;

  TDispInfoNameIndexTraits = class(TLMDHashTableTraits)
  public
    class function BeforeAdd(AItem: TObject;
                             ATable: TLMDHashTable): Boolean; override;
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

{ ---------------------------------------------------------------------------- }

  TWrapperDataListTraits = class(TLMDHashTableTraits)
  public
    class function BeforeAdd(AItem: TObject;
                             ATable: TLMDHashTable): Boolean; override;
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

{ ---------------------------------------------------------------------------- }

  TWrapperByObjectTraits = class(TLMDHashTableTraits)
  public
    class function BeforeAdd(AItem: TObject;
                             ATable: TLMDHashTable): Boolean; override;
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

{ ---------------------------------------------------------------------------- }

  TWrapperClassTraits = class(TLMDHashTableTraits) // Traits for
                                                   // WrapperClassByWrappedClass
                                                   // index.
  public
    class function BeforeAdd(AItem: TObject;
                             ATable: TLMDHashTable): Boolean; override;
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

  TEventWrapperTraits = class(TLMDHashTableTraits) // Traits for
                                                   // EventWrapperByTypeInfo
                                                   // index.
  public
    class function BeforeAdd(AItem: TObject;
                             ATable: TLMDHashTable): Boolean; override;
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

{ ---------------------------------------------------------------------------- }

  TWrapperClassItem = class // Item for
                            // WrapperClassByWrappedClass
                            // index.
  private
    FWrapperClass: TLMDClassWrapperClass;
  public
    constructor    Create(AWrapperClass: TLMDClassWrapperClass);
    class function Get(AObjectClass: TClass): TLMDClassWrapperClass;
  end;

{ ---------------------------------------------------------------------------- }

  TEventWrapperItem = class // Item for
                            // EventWrapperByTypeInfo
                            // index.
  private
    FEventType:    PTypeInfo;
    FWrapperClass: TLMDEventWrapperClass;
  public
    constructor Create(AEventType: PTypeInfo;
                       AWrapperClass: TLMDEventWrapperClass);
  end;

  TWrapperByObject = class
  private
    FMap:              TLMDHashTable; // Item: TLMDClassWrapper.
    FLock:             TCriticalSection;
    FOriginalItemProc: TLMDItemProc;

    procedure ObjDestroyedProc(AItem: TObject);
    procedure EnumWrappersProc(AItem: TObject);
    procedure ObjEnumerator(AItemProc: TLMDItemProc);
  public
    constructor Create;
    destructor Destroy; override;

    function  Find(AObject: TObject): TLMDClassWrapper;
    procedure Add(AWrapper: TLMDClassWrapper);
    procedure Remove(AObject: TObject);
  end;

{ ---------------------------------------------------------------------------- }

  TVarDebugTypesTraits = class(TLMDHashTableTraits) // Traits for VarDebugTypes
                                                    // table.
  public
    class function BeforeAdd(AItem: TObject;
                             ATable: TLMDHashTable): Boolean; override;
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

  TVarDebugType = class
  private
    FVarType: TVarType;
    function Func: TVarType;
  public
    class function Get(AType: TVarType): TLMDDebugTypeFunc;
  end;

{ ---------------------------------------------------------------------------- }

  TDispTypeInfo = class(TInterfacedObject, ITypeInfo)
  private
    FDispInfo: TLMDAbstractDispInfo;
  protected
    { ITypeInfo }

    function GetTypeAttr(out ptypeattr: PTypeAttr): HResult; stdcall;
    function GetTypeComp(out tcomp: ITypeComp): HResult; stdcall;
    function GetFuncDesc(index: Integer; out pfuncdesc: PFuncDesc): HResult; stdcall;
    function GetVarDesc(index: Integer; out pvardesc: PVarDesc): HResult; stdcall;
    function GetNames(memid: TMemberID; rgbstrNames: PBStrList;
                      cMaxNames: Integer; out cNames: Integer): HResult; stdcall;
    function GetRefTypeOfImplType(index: Integer;
                                  out reftype: HRefType): HResult; stdcall;
    function GetImplTypeFlags(index: Integer;
                              out impltypeflags: Integer): HResult; stdcall;
    function GetIDsOfNames(rgpszNames: POleStrList; cNames: Integer;
                           rgmemid: PMemberIDList): HResult; stdcall;
    function Invoke(pvInstance: Pointer; memid: TMemberID; flags: Word;
                    var dispParams: TDispParams; varResult: PVariant;
                    excepInfo: PExcepInfo; argErr: PInteger): HResult; stdcall;
    function GetDocumentation(memid: TMemberID; pbstrName: PWideString;
                              pbstrDocString: PWideString; pdwHelpContext: PLongint;
                              pbstrHelpFile: PWideString): HResult; stdcall;
    function GetDllEntry(memid: TMemberID; invkind: TInvokeKind;
                         bstrDllName, bstrName: PWideString;
                         wOrdinal: PWord): HResult; stdcall;
    function GetRefTypeInfo(reftype: HRefType;
                            out tinfo: ITypeInfo): HResult; stdcall;
    function AddressOfMember(memid: TMemberID; invkind: TInvokeKind;
                             out ppv: Pointer): HResult; stdcall;
    function CreateInstance(const unkOuter: IUnknown; const iid: TIID;
                            out vObj): HResult; stdcall;
    function GetMops(memid: TMemberID; out bstrMops: WideString): HResult; stdcall;
    function GetContainingTypeLib(out tlib: ITypeLib;
                                  out pindex: Integer): HResult; stdcall;
    procedure ReleaseTypeAttr(ptypeattr: PTypeAttr); stdcall;
    procedure ReleaseFuncDesc(pfuncdesc: PFuncDesc); stdcall;
    procedure ReleaseVarDesc(pvardesc: PVarDesc); stdcall;
  public
    constructor Create(ADispInfo: TLMDAbstractDispInfo);
  end;

{ ---------------------------------------------------------------------------- }

var
  WrapperDataList:            TLMDHashTable; // Item: TLMDWrapperData.
  UnitWrapperClassList:       TList;
  WrapperByObject:            TWrapperByObject;
  WrapperClassByWrappedClass: TLMDHashTable; // Item: TWrapperClassItem.
  EventWrapperByTypeInfo:     TLMDHashTable; // Item: TEventWrapperItem.
  VarDebugTypes:              TLMDHashTable; // Item: TVarDebugType.

{ ---------------------------------------------------------------------------- }

procedure RegisterUnitWrapper(AWrapperClass: TLMDUnitWrapperClass);
begin
  if UnitWrapperClassList.IndexOf(AWrapperClass) = -1 then
    UnitWrapperClassList.Add(AWrapperClass);
end;

{ ---------------------------------------------------------------------------- }

function GetUnitWrapperClassList: TList;
begin
  Result := UnitWrapperClassList;
end;

{ ---------------------------------------------------------------------------- }

procedure RegisterClassWrapper(AWrapperClass: TLMDClassWrapperClass);
var
  item: TWrapperClassItem;
begin
  item := TWrapperClassItem.Create(AWrapperClass);
  if not WrapperClassByWrappedClass.Add(item) then // Already registered.
    item.Free;
end;

{ ---------------------------------------------------------------------------- }

procedure RegisterEventWrapper(AEventType: PTypeInfo;
  AWrapperClass: TLMDEventWrapperClass);
var
  item: TEventWrapperItem;
begin
  item := TEventWrapperItem.Create(AEventType, AWrapperClass);
  if not EventWrapperByTypeInfo.Add(item) then // Already registered.
    item.Free;
end;

{ ---------------------------------------------------------------------------- }

function GetEventWrapperClass(AEventType: PTypeInfo): TLMDEventWrapperClass;
var
  item: TEventWrapperItem;
  s:    string; 
begin
  item := TEventWrapperItem(EventWrapperByTypeInfo.Find(AEventType));
  
  if item <> nil then
    Result := item.FWrapperClass
  else
  begin
    s := {$IFDEF LMDCOMP12}string{$ENDIF}(AEventType.Name); // Convert from ShortString.
    raise EOleSysError.Create(Format(SLMDUnregisteredEventType, [s]),
                              E_FAIL, -1);
  end;
end;

{ ---------------------------------------------------------------------------- }

function MakeVarRef(var RefToVar: OleVariant): OleVariant;
begin
  TVarData(Result).VType    := (varByRef or varVariant);
  TVarData(Result).VPointer := @RefToVar;
end;

{ ---------------------------------------------------------------------------- }

procedure AssignRefParam(const ARefParam, AValue: OleVariant);
begin
  if VarIsByRef(ARefParam) then
    OleVariant(FindVarData(ARefParam)^) := AValue;
end;

{ ---------------------------------------------------------------------------- }

procedure WrongArgCountError(AMethodName: TLMDString);
begin
  raise EOleSysError.Create(Format(SLMDWrongArgCount, [AMethodName]),
                            DISP_E_BADPARAMCOUNT, -1);
end;

{ ---------------------------------------------------------------------------- }

procedure WrongArgCountError(AIdx: Integer; AWrap: TLMDDispWrapper); overload;
var
  dinfo: TLMDAbstractDispInfo;
  itm:   TLMDInvokeItem;
begin
  dinfo := AWrap.GetDispInfo;
  itm   := dinfo.GetInvokeItem(AIdx);
  Assert(itm <> nil);

  WrongArgCountError(itm.UppName);
end;

{ ---------------------------------------------------------------------------- }

function WrapperToVariant(const AWrapper: TLMDDispWrapper): OleVariant;
begin
  if AWrapper = nil then
    Result := LMDVarNil
  else
    Result := AWrapper as IDispatch;
end;

{ ---------------------------------------------------------------------------- }

function VariantToWrapper(const AWrapper: OleVariant;
  AAllowNil: Boolean): TLMDDispWrapper;
var
  vtp:   TVarType;
  disp:  IDispatch;
  idwrr: ILMDDispWrapper;
begin
  Result := nil;
  vtp    := VarType(AWrapper);

  if (vtp = varEmpty) or (vtp = varNull) then
  begin
    if not AAllowNil then
      VarCastError;
    Exit;
  end;

  disp := OleVariant(FindVarData(AWrapper)^); // FindVarData fixes Delphi
                                              // OleVariant to IDispatch
                                              // conversion bug.
  if disp = nil then
  begin
    if not AAllowNil then
      VarCastError;
    Exit;
  end;

  if disp.QueryInterface(ILMDDispWrapper, idwrr) <> S_OK then // Variant is an
                                                              // object, but not
                                                              // from our package.
    VarCastError;

  Result := idwrr.GetSelf;
end;

{ ---------------------------------------------------------------------------- }

function VarObjectIs(const AObject, AClass: OleVariant): OleVariant;
var
  obj: TObject;
  cls: TClass;
begin
  obj := TLMDClassWrapper.ConvFromVar(AObject);
  cls := TLMDMetaclassWrapper.ConvFromVar(AClass);

  Result := (obj is cls);
end;

{ ---------------------------------------------------------------------------- }

function VarObjectIs(AObject: TObject; AClass: OleVariant): OleVariant;
var
  cls: TClass;
begin
  cls := TLMDMetaclassWrapper.ConvFromVar(AClass);
  Result := (AObject is cls);
end;

{ ---------------------------------------------------------------------------- }

function LMDVarNil: OleVariant;
begin
  Result := Unassigned; // Clear.
  with TVarData(Result) do
  begin
    VType     := varDispatch;
    VDispatch := nil;
  end;
end;

{ ---------------------------------------------------------------------------- }

function VarRecIs(const ARecord, ARecType: OleVariant): OleVariant;
var
  swrr:  TLMDDispWrapper;
  dwcls: TLMDTypeWrapperClass;
  swcls: TLMDRecordWrapperClass;
begin
  swrr  := VariantToWrapper(ARecord, True);
  dwcls := TLMDUnitWrapper.ConvFromVar(ARecType, True);

  if (swrr <> nil) and
     not (swrr is TLMDRecordWrapper) then           // Variant is not a record.
    VarCastError;

  if (dwcls <> nil) and
     not dwcls.InheritsFrom(TLMDRecordWrapper) then // Variant is not a record
                                                    // type.
    VarCastError;

  if (swrr = nil) or (dwcls = nil) then // Only after previous checks.
  begin
    Result := False;
    Exit;
  end;

  swcls := TLMDRecordWrapperClass(swrr.ClassType);

  Result := (dwcls = swcls);
end;

{ ---------------------------------------------------------------------------- }

function VarRecNew(const ARecType: OleVariant): OleVariant;
var
  rectp: TLMDTypeWrapperClass;
begin
  rectp := TLMDUnitWrapper.ConvFromVar(ARecType, True);
  if (rectp = nil) or not rectp.InheritsFrom(TLMDRecordWrapper) then
    VarCastError;

  Result := WrapperToVariant(rectp.Create);
end;

{ ---------------------------------------------------------------------------- }

function VarRecNew(const ARecType: TLMDRecordWrapperClass): OleVariant;
begin
  Result := WrapperToVariant(ARecType.Create);
end;

{ ---------------------------------------------------------------------------- }

function VarRecCopy(const ARecord: OleVariant): OleVariant;
var
  swrr:  TLMDDispWrapper;
  dwrr:  TLMDRecordWrapper;
begin
  swrr := VariantToWrapper(ARecord, False);

  if not (swrr is TLMDRecordWrapper) then // Variant is not a record.
    VarCastError;

  dwrr   := TLMDRecordWrapper(swrr).CloneVal;
  Result := WrapperToVariant(dwrr);
end;

{ ---------------------------------------------------------------------------- }

function VarRecCopy(const ARecord: TLMDRecordWrapper): OleVariant;
begin
  Result := WrapperToVariant(ARecord);
end;

{ ---------------------------------------------------------------------------- }

function VarObjOrRecIs(const AVal, AType: OleVariant): OleVariant;
var
  dwcls: TLMDTypeWrapperClass;
begin
  dwcls := TLMDUnitWrapper.ConvFromVar(AType, True);

  if dwcls <> nil then
  begin
    if dwcls.InheritsFrom(TLMDRecordWrapper) then
      Result := VarRecIs(AVal, AType)
    else
      Result := VarObjectIs(AVal, AType);
  end
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }

function VarObjOrRecNew(const AType: OleVariant; AArgs: PLMDVarArray;
  AArgCount: Integer): OleVariant;
var
  dwcls: TLMDTypeWrapperClass;
  dt:    TLMDClassWrapperData;
  idx:   Integer;
  itm:   TLMDInvokeItem;
begin
  dwcls := TLMDUnitWrapper.ConvFromVar(AType, True);

  if dwcls <> nil then
  begin
    if dwcls.InheritsFrom(TLMDRecordWrapper) then
    begin
      if AArgCount <> 0 then
        WrongArgCountError('New');

      Result := VarRecNew(AType);
    end
    else if dwcls.InheritsFrom(TLMDClassWrapper) then
    begin
      dt  := TLMDClassWrapperData(dwcls.GetData);
      idx := dt.FDispInfo.IndexOfInvokeItem('CREATE');
      itm := nil;

      if idx <> -1 then
      begin
        itm := dt.FDispInfo.GetInvokeItem(idx);
        if not (iiaConstructor in itm.Attrs) then
          itm := nil;
      end;

      if itm = nil then
        raise EOleSysError.Create('No constructor found.', E_FAIL, -1);
      if (AArgCount <> itm.ParamCount) and (AArgCount < itm.MinParamCount) then
        WrongArgCountError('New');

      Result := dwcls.LowMetaInvoke(itm, TLMDDispArgs(AArgs^),
                                    AArgCount, False);
    end;
  end
  else
    VarCastError;
end;

{ ---------------------------------------------------------------------------- }

function VarSetEmpty: OleVariant;
begin
  Result := 0;
end;

{ ---------------------------------------------------------------------------- }

function VarSetInclude(const ASet, AElem: OleVariant): OleVariant;
var
  val:  Integer;
  elem: Integer;
begin
  val    := Integer(ASet);
  elem   := Integer(AElem);
  Result := val or (1 shl elem);
end;

{ ---------------------------------------------------------------------------- }

function VarSetExclude(const ASet, AElem: OleVariant): OleVariant;
var
  val:  Integer;
  elem: Integer;
begin
  val    := Integer(ASet);
  elem   := Integer(AElem);
  Result := val and not (1 shl elem);
end;

{ ---------------------------------------------------------------------------- }

function VarSetIn(const AElem, ASet: OleVariant): OleVariant;
var
  val:  Integer;
  elem, m: Integer;
begin
  val := Integer(ASet);
  elem := Integer(AElem);
  m := 1 shl elem;

  Result := (val and m)<>0;
end;

{ ---------------------------------------------------------------------------- }

function VarSetMake(const AElems: TLMDDispArgs; AElemsSize: Integer): OleVariant;
var
  i:       Integer;
  val:     Integer;
  elem, m: Integer;
begin
  val := 0;

  for i := 0 to AElemsSize - 1 do
  begin
    elem := Integer(AElems[i]);
    m    := 1 shl elem;
    val  := val or m;
  end;

  Result := val;
end;

{ ---------------------------------------------------------------------------- }

function LMDSetToVar(ASizeOf: Integer; const ASet): OleVariant;
var
  val: Integer;
begin
  case ASizeOf of
    1:  val := Byte(ASet);
    2:  val := Word(ASet);
    4:  val := LongWord(ASet);
  else
    raise EOleSysError.Create(SLMDUnsupportedSetType, E_FAIL, -1);
  end;

  Result := val;
end;

{**************************** class TLMDWrapperData ***************************}
{ --------------------------------- public ----------------------------------- }

constructor TLMDWrapperData.Create(AWrapperClass: TLMDWrapperClass);
begin
  inherited Create;

  FWrapperClass := AWrapperClass;
end;

{****************************** class TLMDWrapper *****************************}
{ --------------------------------- protected -------------------------------- }

class function TLMDWrapper.GetData: TLMDWrapperData;
var
  datacls: TLMDWrapperDataClass;
begin
  Result := TLMDWrapperData(WrapperDataList.Find(
    TLMDWrapperClass(Self)));

  if Result = nil then
  begin
    datacls := GetDataClass;
    if datacls = nil then
      Exit;

    Result := datacls.Create(Self);
    try
      InitData(Result);
    except
      Result.Free;
      raise;
    end;
    WrapperDataList.Add(Result);
  end;
end;
                                                             
{ ---------------------------------------------------------------------------- }

class function TLMDWrapper.GetDataClass: TLMDWrapperDataClass;
begin
  Result := nil;
end;
                                                            
{ ---------------------------------------------------------------------------- }

class procedure TLMDWrapper.InitData(AData: TLMDWrapperData);
begin
  // Do nothing.
end;

{****************************** class TLMDDispInfo ****************************}
{ --------------------------------- private ---------------------------------- }

procedure TLMDDispInfo.Clear;
var
  i: Integer;
begin
  FNameIndex.Clear;

  for i := 0 to FCount - 1 do
    FItems[i].Free;
  FCount := 0;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDispInfo.AddItem(AItem: TLMDInvokeItem);
begin
  if Length(FItems) = FCount then          // Grow.
    SetLength(FItems, Max(FCount * 2, 4)); //

  if FCount = 0 then
    InitDispidValueItem;

  AItem.Index    := FCount;
  FItems[FCount] := AItem;
  Inc(FCount);

  if AItem.UppName <> '' then         // Item is not unnamed.
  begin
    FNameIndex.Remove(AItem.UppName); // Last added items have
    FNameIndex.Add(AItem);            // higher priority.
  end;

  if not (iiaHidden in AItem.Attrs) and (iiaDefaultProp in AItem.Attrs) then
    FItems[DISPID_VALUE].Assign(AItem);
end;

{ --------------------------------- protected -------------------------------- }

function TLMDDispInfo.IndexOfInvokeItem(const AName: WideString;
  AAllowHidden: Boolean): Integer;
var
  item:  TLMDInvokeItem;
  uppnm: WideString;
begin
  uppnm := LMDWideUpperCase(AName);
  item  := TLMDInvokeItem(FNameIndex.Find(uppnm));

  if (item = nil) or
     (not AAllowHidden and (iiaHidden in item.Attrs)) then
  begin
    Result := -1;
    Exit;
  end;

  Result := item.Index;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDispInfo.InitDispidValueItem;
var
  item: TLMDInvokeItem;
begin
  // This procedure creates a dummy item, which just reserves space and
  // DISPID_VALUE index (which is zero). Eventually the content of this
  // item can be overwritten with real default property item.

  item := TLMDInvokeItem.Create;

  item.Index         := DISPID_VALUE;
  item.UppName       := '';
  item.Name          := '';
  item.DebugType     := nil;
  item.Attrs         := [];
  item.ParamCount    := 0;
  item.MinParamCount := MaxInt;
  item.InvokeFlags   := 0; // No way to invoke; should be zero.
  item.ResMask       := $FFFFFFFF;
  item.InvokeProc    := nil;

  Assert((FCount = 0) and (DISPID_VALUE = 0));

  FItems[DISPID_VALUE] := item; // DISPID_VALUE = 0.
  FCount               := 1;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDispInfo.GetInvokeItem(AIndex: Integer): TLMDInvokeItem;
begin
  Result := TLMDInvokeItem(FItems[AIndex]);
end;

{ ---------------------------------------------------------------------------- }

function TLMDDispInfo.GetInvokeItemCount: Integer;
begin
  Result := FCount;
end;
                                                                   
{ ---------------------------------------------------------------------------- }

procedure TLMDDispInfo.AddInvokeItem(const AName: WideString;
  AType: TLMDDebugTypeFunc; AAttrs: TLMDInvokeItemAttrs;
  AParamCount: Integer; AInvokeFlags: Word; AInvokeProc: TLMDInvokeProc);
var
  item: TLMDInvokeItem;
begin
  item := TLMDInvokeItem.Create;

  item.UppName       := LMDWideUpperCase(AName);
  item.Name          := AName;
  item.DebugType     := AType;
  item.Attrs         := AAttrs;
  item.ParamCount    := AParamCount;
  item.MinParamCount := MaxInt - ((MaxInt - AParamCount) *
                        Ord(iiaOptParams in AAttrs));
  item.InvokeFlags   := AInvokeFlags;
  item.ResMask       := $FFFFFFFF * DWORD(Ord(not (iiaNoResult in AAttrs)));
  item.InvokeProc    := AInvokeProc;

  AddItem(item);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDispInfo.AddInvokeItem(AItem: TLMDInvokeItem;
  AUnhide, AIsDefaultProp: Boolean);
var
  item: TLMDInvokeItem;
begin
  item := TLMDInvokeItem.Create;

  item.Assign(AItem);
  if AUnhide then
    Exclude(item.Attrs, iiaHidden);
  if AIsDefaultProp then
    Include(item.Attrs, iiaDefaultProp);

  AddItem(item);
end;
          
{ --------------------------------- public ----------------------------------- }

constructor TLMDDispInfo.Create;
begin
  inherited Create;
  FNameIndex := TLMDHashTable.Create(TDispInfoNameIndexTraits, False);
end;
                                                             
{ ---------------------------------------------------------------------------- }

destructor TLMDDispInfo.Destroy;
begin
  Clear;
  FNameIndex.Free;
  inherited;
end;

{************************** class TLMDDispWrapperData *************************}
{ --------------------------------- protected -------------------------------- }

procedure TLMDDispWrapperData.AddDispConstructor(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AParamCount: Integer;
  AResultType: TLMDDebugTypeFunc; AHasOptParams, AIsHidden: Boolean);
var
  attrs: TLMDInvokeItemAttrs;
begin
  attrs := [iiaConstructor, iiaMetaMember];
  if not Assigned(AResultType) then
    Include(attrs, iiaNoResult);
  if AHasOptParams then
    Include(attrs, iiaOptParams);
  if AIsHidden then
    Include(attrs, iiaHidden);

  FDispInfo.AddInvokeItem(AName, AResultType, attrs, AParamCount,
                          DISPATCH_METHOD, AInvokeProc);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDispWrapperData.AddDispMethod(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AParamCount: Integer;
  AResultType: TLMDDebugTypeFunc; AHasOptParams, AIsMetaMember,
  AIsHidden: Boolean);
var
  attrs: TLMDInvokeItemAttrs;
begin
  attrs := [];
  if not Assigned(AResultType) then
    Include(attrs, iiaNoResult);
  if AHasOptParams then
    Include(attrs, iiaOptParams);
  if AIsMetaMember then
    Include(attrs, iiaMetaMember);
  if AIsHidden then
    Include(attrs, iiaHidden);

  FDispInfo.AddInvokeItem(AName, AResultType, attrs, AParamCount,
                          DISPATCH_METHOD, AInvokeProc);
end;
                                                              
{ ---------------------------------------------------------------------------- }

procedure TLMDDispWrapperData.AddDispProp(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDDebugTypeFunc; AIsReadable,
  AIsWritable: Boolean; AParamCount: Integer; AIsMetaMember, AIsHidden,
  AIsDefault: Boolean);
var
  invflag: Word;
  attrs:   TLMDInvokeItemAttrs;
begin
  attrs := [];
  if AIsMetaMember then
    Include(attrs, iiaMetaMember);
  if AIsHidden then
    Include(attrs, iiaHidden);
  if AIsDefault then
    Include(attrs, iiaDefaultProp);

  invflag := 0;
  if AIsReadable then
    invflag := invflag or DISPATCH_PROPERTYGET;
  if AIsWritable then
  begin
    if AType() = varDispatch then
      invflag := invflag or DISPATCH_PROPERTYPUTREF
    else
      invflag := invflag or DISPATCH_PROPERTYPUT;
  end;

  FDispInfo.AddInvokeItem(AName, AType, attrs, AParamCount,
                          invflag, AInvokeProc);
end;
                 
{ --------------------------------- public ----------------------------------- }

constructor TLMDDispWrapperData.Create(AWrapperClass: TLMDWrapperClass);
begin
  inherited;
  FDispInfo := TLMDDispInfo.Create;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDDispWrapperData.Destroy;
begin
  FDispInfo.Free;
  inherited;
end;

{**************************** class TLMDDispWrapper ***************************}
{ --------------------------------- private ---------------------------------- }

function TLMDDispWrapper.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count  := 1;
  Result := S_OK;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDispWrapper.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  ITypeInfo(TypeInfo) := GetDispInfo.FTypeInfo;
  Result              := S_OK;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDispWrapper.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
var
  i:   Integer;
  idx: Integer;
begin
  idx := GetDispInfo.IndexOfInvokeItem(PNamesArray(Names)[0]);

  if idx > 0 then
  begin
    PDispIdsArray(DispIds)[0] := idx;
    Result                    := S_OK;
  end
  else
  begin
    for i := 0 to NameCount - 1 do
      PDispIdsArray(DispIds)[i] := DISPID_UNKNOWN;
    Result := DISP_E_UNKNOWNNAME;
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDispWrapper.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
type
  TState = (sMeth, sPGet, sPPut, sTpMis, sNoMr, sNotUsed);
const
  MAX_ARG_COUNT = 64;
  STATES:         array[0..15, Boolean] of TState =
  (
    (sNoMr, sNoMr),   // 0  - No valid flag
    (sMeth, sTpMis),  // 1  - DISPATCH_METHOD
    (sPGet, sTpMis),  // 2  - DISPATCH_PROPERTYGET
    (sNoMr, sNoMr),   // 3  - No valid flag
    (sPPut, sTpMis),  // 4  - DISPATCH_PROPERTYPUT
    (sNoMr, sNoMr),   // 5  - No valid flag
    (sNoMr, sNoMr),   // 6  - No valid flag
    (sNoMr, sNoMr),   // 7  - No valid flag
    (sPPut, sTpMis),  // 8  - DISPATCH_PROPERTYPUTREF
    (sNoMr, sNoMr),   // 9  - No valid flag
    (sNoMr, sNoMr),   // 10 - No valid flag
    (sNoMr, sNoMr),   // 11 - No valid flag
    (sPPut, sTpMis),  // 12 - DISPATCH_PROPERTYPUT or DISPATCH_PROPERTYPUTREF
    (sNoMr, sNoMr),   // 13 - No valid flag
    (sNoMr, sNoMr),   // 14 - No valid flag
    (sNoMr, sNoMr)    // 15 - No valid flag
  );
var
  i:     Integer;
  idx:   Integer;
  dinfo: TLMDAbstractDispInfo;
  item:  TLMDInvokeItem;
  argsz: Integer;
  dargs: TDispParams absolute Params;
  vargs: array[0..MAX_ARG_COUNT - 1] of TVariantArg;
  vres:  OleVariant;

  function _InvokeDefaultProp(AItem: TLMDInvokeItem): HResult;
  var
    obj: OleVariant;
  begin
    obj := LowInvoke(AItem, TLMDDispArgs(nil^), 0, True);

    if (TVarData(obj).VType = varDispatch) and
       (TVarData(obj).VDispatch <> nil) then
    begin
      Result := IDispatch(TVarData(obj).VDispatch).Invoke(
                                      DISPID_VALUE, GUID_NULL, 0,
                                      Flags, Params, VarResult,
                                      ExcepInfo, ArgErr);
    end
    else
      Result := DISP_E_TYPEMISMATCH;
  end;

begin
  Result := S_OK;
  idx    := DispId;
  dinfo  := GetDispInfo;

  { Detect invoke item }

  // Unsigned comparison will automatically process
  // the (idx < 0) case.

  if (Cardinal(idx) >= Cardinal(dinfo.GetInvokeItemCount)) then
  begin
    Result := DISP_E_MEMBERNOTFOUND;
    Exit;
  end;

  item  := dinfo.GetInvokeItem(idx);
  argsz := dargs.cArgs;

  try
    case STATES[item.InvokeFlags and DWORD(Flags) and DWORD($0F), // $0F - is 4-bits mask.
                (DWORD(VarResult) and not item.ResMask) <> 0] of
      sMeth:
      begin
        if (argsz <> item.ParamCount) and (argsz < item.MinParamCount) then
        begin
          Result := DISP_E_BADPARAMCOUNT;
          Exit;
        end;
      end;
      sPGet:
      begin
        if (argsz <> item.ParamCount) and (argsz < item.MinParamCount) then
        begin
          if (argsz > 0) and (item.ParamCount = 0) then
            Result := _InvokeDefaultProp(item)
          else
            Result := DISP_E_BADPARAMCOUNT;
          Exit;
        end;
      end;
      sPPut:
      begin
        if argsz <> item.ParamCount + 1 then // 'Value' parameter.
        begin
          if (argsz > 1) and (item.ParamCount = 0) then
            Result := _InvokeDefaultProp(item)
          else
            Result := DISP_E_BADPARAMCOUNT;
          Exit;
        end;
      end;
      sTpMis:
      begin
        Result := DISP_E_TYPEMISMATCH; // Cannot convert void to any possible
                                       // Variant.
        Exit;
      end;
      sNoMr:
      begin
        if item.Index = DISPID_VALUE then
          Result := DISP_E_MEMBERNOTFOUND
        else
        begin
          // We are here when invoke flags does not compatible with invoked
          // item kind (attempt to assign to a method, or a property read
          // without result). It probably more descriptive to raise TYPEMISMATCH
          // error, instead of MEMBERNOTFOUND.

          Result := DISP_E_TYPEMISMATCH;
        end;

        Exit;
      end;
      sNotUsed:
        Exit; // Prevents Delphi compiler from
              // transforming case to ifs.
    end;

    { Create arguments array }

    // Dispatch should treat arguments as read-only. So the wrappers
    // will never change the value of the argument. Thus we just copy
    // the memory, without add-refs/releases.

    for i := 0 to argsz - 1 do
      vargs[i] := dargs.rgvarg[argsz - 1 - i]; // Reverse args.

    { Invoke }

    vres := LowInvoke(item, TLMDDispArgs(Pointer(@vargs)^), argsz,
                      (Flags and DISPATCH_PROPERTYPUT) = 0);

    if VarResult <> nil then
      POleVariant(VarResult)^ := vres;
  except
    on e: Exception do
      Result := EncodeInvokeError(e, ExcepInfo);
  end;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDispWrapper.GetSelf: TLMDDispWrapper;
begin
  Result := Self;
end;

{ --------------------------------- protected -------------------------------- }

class function TLMDDispWrapper.GetDataClass: TLMDWrapperDataClass;
begin
  Result := TLMDDispWrapperData;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDispWrapper.GetDispInfo: TLMDAbstractDispInfo;
begin
  Result := (GetData as TLMDDispWrapperData).FDispInfo;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDispWrapper.LowInvoke(AItem: TLMDInvokeItem;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; AIsGet: Boolean): OleVariant;
begin
  Result := Unassigned; // Do nothing.
end;

{**************************** class TLMDTypeWrapper ***************************}
{ --------------------------------- protected -------------------------------- }

class function TLMDTypeWrapper.GetDataClass: TLMDWrapperDataClass;
begin
  Result := TLMDTypeWrapperData;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDTypeWrapper.TypeToVariant: OleVariant;
var
  data: TLMDTypeWrapperData;
  mtwr: TLMDMetatypeWrapper;
begin
  data := GetData as TLMDTypeWrapperData;

  if data.FMetatypeWrapper = nil then
  begin
    mtwr := TLMDMetatypeWrapper.Create(TLMDTypeWrapperClass(Self));
    data.FMetatypeWrapper := mtwr as IDispatch;
  end;

  Result := data.FMetatypeWrapper;
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDTypeWrapper.Create;
begin
  inherited Create;
end;

class function TLMDTypeWrapper.GetTypeName: WideString;
begin
  Assert(False); // This method is not abstract only for
                 // C++ Builder compatibility.
end;

{************************* class TLMDMetatypeDispInfo *************************}
{ --------------------------------- protected -------------------------------- }

function TLMDMetatypeDispInfo.IndexOfInvokeItem(
  const AName: WideString; AAllowHidden: Boolean): Integer;
var
  item: TLMDInvokeItem;
begin
  Result := FOriginalInfo.IndexOfInvokeItem(AName, AAllowHidden);
  if Result = -1 then
    Exit;

  item := FOriginalInfo.GetInvokeItem(Result);
  if not (iiaMetaMember in item.Attrs) then
    Result := -1;
end;

{ ---------------------------------------------------------------------------- }

function TLMDMetatypeDispInfo.GetInvokeItem(AIndex: Integer): TLMDInvokeItem;
begin
  Result := FOriginalInfo.GetInvokeItem(AIndex);
end;

{ ---------------------------------------------------------------------------- }

function TLMDMetatypeDispInfo.GetInvokeItemCount: Integer;
begin
  Result := FOriginalInfo.GetInvokeItemCount;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDMetatypeDispInfo.Create(AOriginalInfo: TLMDAbstractDispInfo);
begin
  inherited Create;
  FOriginalInfo := AOriginalInfo;
end;

{************************** class TLMDMetatypeWrapper *************************}
{ --------------------------------- protected -------------------------------- }

class function TLMDMetatypeWrapper.GetDataClass: TLMDWrapperDataClass;
begin
  Result := nil; // Data is not used.
end;

{ ---------------------------------------------------------------------------- }

function TLMDMetatypeWrapper.GetDispInfo: TLMDAbstractDispInfo;
begin
  Result := FDispInfo;
end;

{ ---------------------------------------------------------------------------- }

function TLMDMetatypeWrapper.LowInvoke(AItem: TLMDInvokeItem;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; AIsGet: Boolean): OleVariant;
begin
  Result := FType.LowMetaInvoke(AItem, AArgs, AArgsSize, AIsGet);
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDMetatypeWrapper.Create(AType: TLMDTypeWrapperClass);
begin
  inherited Create;
  FType     := AType;
  FDispInfo := TLMDMetatypeDispInfo.Create(
    (AType.GetData as TLMDDispWrapperData).FDispInfo);
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDMetatypeWrapper.Destroy;
begin
  FDispInfo.Free;
  inherited;
end;

{************************* class TLMDClassWrapperData *************************}
{ --------------------------------- private ---------------------------------- }

function TLMDClassWrapperData.HasRedecls: Boolean;
begin
  Result := (FRedecls <> nil);
end;

{ ---------------------------------------------------------------------------- }

function TLMDClassWrapperData.GetRedecls: TStrings;
begin
  if FRedecls = nil then
    FRedecls := TStringList.Create;
  Result := FRedecls;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDClassWrapperData.Create(AWrapperClass: TLMDWrapperClass);
begin
  inherited;
  FRedecls := nil;
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDClassWrapperData.Destroy;
begin
  FRedecls.Free;
  inherited;
end;
                                                         
{ ---------------------------------------------------------------------------- }

procedure TLMDClassWrapperData.AddField(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass);
begin
  AddDispProp(AName, AInvokeProc, AType.GetVarType,
              True, True, 0, False);
end;
                                                            
{ ---------------------------------------------------------------------------- }

procedure TLMDClassWrapperData.AddConstant(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass;
  AVarType: TVarType);
var
  dbgtp: TLMDDebugTypeFunc;
begin
  if AType <> nil then
    dbgtp := AType.GetVarType
  else
    dbgtp := TVarDebugType.Get(AVarType);

  AddDispProp(AName, AInvokeProc, dbgtp, True, False, 0, True);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDClassWrapperData.AddConstructor(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AParamsCount: Integer;
  AHasOptionalParams: Boolean);
begin
  AddDispConstructor(AName, AInvokeProc, AParamsCount,
                     TLMDTypeWrapperClass(FWrapperClass).GetVarType,
                     AHasOptionalParams)
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDClassWrapperData.AddProcedure(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AParamsCount: Integer;
  AHasOptionalParams: Boolean);
begin
  AddDispMethod(AName, AInvokeProc, AParamsCount, nil,
                AHasOptionalParams, False);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDClassWrapperData.AddFunction(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AResultType: TLMDTypeWrapperClass;
  AParamsCount: Integer; AHasOptionalParams: Boolean);
var
  dbgtp: TLMDDebugTypeFunc;
begin
  if AResultType <> nil then // Can be nil due to old overload
                             // groups implementation.
    dbgtp := AResultType.GetVarType
  else
    dbgtp := TVarDebugType.Get(varVariant);

  AddDispMethod(AName, AInvokeProc, AParamsCount, dbgtp,
                AHasOptionalParams, False);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDClassWrapperData.AddClassProcedure(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AParamsCount: Integer;
  AHasOptionalParams: Boolean);
begin
  AddDispMethod(AName, AInvokeProc, AParamsCount, nil,
                AHasOptionalParams, True);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDClassWrapperData.AddClassProperty(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass;
  AIsReadable, AIsWritable: Boolean; AParamsCount: Integer;
  AIsProtected: Boolean);
begin
  AddDispProp(AName, AInvokeProc, AType.GetVarType, AIsReadable,
              AIsWritable, AParamsCount, True, AIsProtected);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDClassWrapperData.AddClassField(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass);
begin
  AddDispProp(AName, AInvokeProc, AType.GetVarType,
              True, True, 0, True);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDClassWrapperData.AddClassFunction(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AResultType: TLMDTypeWrapperClass;
  AParamsCount: Integer; AHasOptionalParams: Boolean);
var
  dbgtp: TLMDDebugTypeFunc;
begin
  if AResultType <> nil then // Can be nil due to old overload
                             // groups implementation.
    dbgtp := AResultType.GetVarType
  else
    dbgtp := TVarDebugType.Get(varVariant);

  AddDispMethod(AName, AInvokeProc, AParamsCount, dbgtp,
                AHasOptionalParams, True);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDClassWrapperData.AddProperty(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass;
  AIsReadable, AIsWritable: Boolean; AParamsCount: Integer;
  AIsProtected, AIsDefault: Boolean);
begin
  AddDispProp(AName, AInvokeProc, AType.GetVarType, AIsReadable, AIsWritable,
              AParamsCount, False, AIsProtected, AIsDefault);
end;
                                                   
{ ---------------------------------------------------------------------------- }

procedure TLMDClassWrapperData.AddPropertyRedecl(const AName: WideString;
  AIsDefault: Boolean);
begin
  GetRedecls.AddObject(AName, TObject(Ord(AIsDefault)));
end;

{*************************** class TLMDClassWrapper ***************************}
{ --------------------------------- protected -------------------------------- }

class function TLMDClassWrapper.GetDataClass: TLMDWrapperDataClass;
begin
  Result := TLMDClassWrapperData;
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDClassWrapper.InitData(AData: TLMDWrapperData);
var
  i:       Integer;
  data:    TLMDClassWrapperData;
  pntdata: TLMDClassWrapperData;
  redecls: TStrings;
  idx:     Integer;
  item:    TLMDInvokeItem;
  isdef:   Boolean;
begin
  data := AData as TLMDClassWrapperData;

  { Get base class data }

  if (ClassParent <> nil) and (ClassParent <> TLMDClassWrapper) then
    pntdata := TLMDClassWrapperClass(ClassParent).GetData as TLMDClassWrapperData
  else
    pntdata := nil;

  { Copy all base class items to self data }

  if pntdata <> nil then
  begin
    for i := 0 to pntdata.FDispInfo.GetInvokeItemCount - 1 do
    begin
      item := pntdata.FDispInfo.GetInvokeItem(i);
      if item.Index <> DISPID_VALUE then
        data.FDispInfo.AddInvokeItem(item);
    end;
  end;

  { Init self members }

  DoInit(data);

  { Process property redeclarations }

  if data.HasRedecls and (pntdata <> nil) then
  begin
    redecls := data.GetRedecls;

    for i := 0 to redecls.Count - 1 do
    begin
      idx := pntdata.FDispInfo.IndexOfInvokeItem(redecls[i], True);

      if idx <> -1 then // If property really exists in base classes.
      begin
        item  := pntdata.FDispInfo.GetInvokeItem(idx);
        isdef := (redecls.Objects[i] <> nil);

        data.FDispInfo.AddInvokeItem(item, True, isdef);
      end;
    end;
  end;
end;
                                                         
{ ---------------------------------------------------------------------------- }

function TLMDClassWrapper.LowInvoke(AItem: TLMDInvokeItem;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; AIsGet: Boolean): OleVariant;
var
  cls: TClass;
  obj: TObject;
begin
  if FValue = nil then
    raise EOleSysError.Create('Object has been destroyed.', E_FAIL, -1);

  if iiaMetaMember in AItem.Attrs then
  begin
    cls    := Self.FValue.ClassType;
    Result := AItem.InvokeProc(cls, AArgs, AArgsSize, AIsGet);
  end
  else
  begin
    obj    := Self.FValue;
    Result := AItem.InvokeProc(obj, AArgs, AArgsSize, AIsGet);
  end;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDClassWrapper.LowMetaInvoke(AItem: TLMDInvokeItem;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; AIsGet: Boolean): OleVariant;
var
  cls: TClass;
begin
  cls    := GetWrappedClass;
  Result := AItem.InvokeProc(cls, AArgs, AArgsSize, AIsGet)
end;

{ ---------------------------------------------------------------------------- }

class function TLMDClassWrapper.ConvToVar(AObject: TObject): OleVariant;
var
  wrrcls:  TLMDClassWrapperClass;
  wrapper: TLMDClassWrapper;
begin
  if AObject = nil then
  begin
    Result := LMDVarNil;
    Exit;
  end;

  wrapper := TLMDClassWrapper(WrapperByObject.Find(AObject));
  if wrapper = nil then
  begin
    wrrcls  := TWrapperClassItem.Get(AObject.ClassType);
    wrapper := wrrcls.Create(AObject);
  end;

  Result := WrapperToVariant(wrapper);
end;
    
{ ---------------------------------------------------------------------------- }

class function TLMDClassWrapper.ConvFromVar(const AObject: OleVariant;
  AReqClass: TClass): TObject;
var
  dwrr: TLMDDispWrapper;
begin
  dwrr := VariantToWrapper(AObject, True);

  if dwrr = nil then
  begin
    Result := nil;
    Exit;
  end;

  if not (dwrr is TLMDClassWrapper) then // Variant is a wrapper, but does not
                                         // represent a reference to Delphi object.
    VarCastError;

  Result := TLMDClassWrapper(dwrr).FValue;
  if (AReqClass <> nil) and
     (Result <> nil) and
     not (Result is AReqClass) then // Delphi object is not an instance of
                                    // required class.
    VarCastError;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDClassWrapper.ConvClsToVar(AClass: TClass): OleVariant;
begin
  Result := TLMDMetaclassWrapper.ConvToVar(AClass);
end;

{ ---------------------------------------------------------------------------- }

class function TLMDClassWrapper.ConvClsFromVar(const AClass: OleVariant;
  AReqMetaclass: TClass): TClass;
begin
  Result := TLMDMetaclassWrapper.ConvFromVar(AClass, AReqMetaclass);
end;

{ ---------------------------------------------------------------------------- }

class function TLMDClassWrapper.GetWrappedClass: TClass;
begin
  Result := nil;
  Assert(False); // This method is not abstract only for
                 // C++ Builder compatibility.
end;

{ --------------------------------- protected -------------------------------- }

class function TLMDClassWrapper.GetTypeName: WideString;
begin
  Result := GetWrappedClass.ClassName;
end;
                                                       
{ ---------------------------------------------------------------------------- }

class procedure TLMDClassWrapper.DoInit(AData: TLMDClassWrapperData);
begin
  // Do nothing
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDClassWrapper.Create(AValue: TObject);
begin
  inherited Create;
  FValue := AValue;

  Assert(WrapperByObject <> nil);
  WrapperByObject.Add(Self);
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDClassWrapper.Destroy;
begin
  if WrapperByObject <> nil then
    WrapperByObject.Remove(FValue);
  inherited;
end;

{************************* class TLMDMetaclassWrapper *************************}
{ --------------------------------- protected -------------------------------- }

class function TLMDMetaclassWrapper.TypeToVariant: OleVariant;
begin
  Result := ConvToVar(GetWrappedBaseClass); // Return wrapper for base
                                            // class, so all class members
                                            // will be accessible.
end;
                           
{ ---------------------------------------------------------------------------- }

class function TLMDMetaclassWrapper.ConvToVar(AClass: TClass): OleVariant;
var
  wrrcls: TLMDClassWrapperClass;
begin
  if AClass = nil then
  begin
    Result := LMDVarNil;
    Exit;
  end;

  wrrcls := TWrapperClassItem.Get(AClass);
  Result := TLMDUnitWrapper.ConvToVar(wrrcls);
end;
             
{ ---------------------------------------------------------------------------- }

class function TLMDMetaclassWrapper.ConvFromVar(const AClass: OleVariant;
  AReqMetaclass: TClass): TClass;
var
  tpcls: TLMDTypeWrapperClass;
begin
  tpcls := TLMDUnitWrapper.ConvFromVar(AClass, True);

  if tpcls = nil then
  begin
    Result := nil;
    Exit;
  end;

  if not tpcls.InheritsFrom(TLMDClassWrapper) then // Variant is metatype, but
                                                   // not a class metatype.
    VarCastError;

  Result := TLMDClassWrapperClass(tpcls).GetWrappedClass;
  if (AReqMetaclass <> nil) and (Result <> nil) and
     not Result.InheritsFrom(AReqMetaclass) then // Delphi metaclass is not
                                                 // compatible with
                                                 // required metaclass.
    VarCastError;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDMetaclassWrapper.GetWrappedBaseClass: TClass;
begin
  Result := nil;
  Assert(False); // This method is not abstract only for
                 // C++ Builder compatibility.
end;

{************************ class TLMDRecordWrapperData *************************}
{ --------------------------------- public ----------------------------------- }

procedure TLMDRecordWrapperData.AddField(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass);
begin
  AddDispProp(AName, AInvokeProc, AType.GetVarType,
              True, True, 0, False);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRecordWrapperData.AddConstant(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass;
  AVarType: TVarType);
var
  dbgtp: TLMDDebugTypeFunc;
begin
  if AType <> nil then
    dbgtp := AType.GetVarType
  else
    dbgtp := TVarDebugType.Get(AVarType);

  AddDispProp(AName, AInvokeProc, dbgtp, True, False, 0, True);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRecordWrapperData.AddConstructor(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AParamsCount: Integer;
  AHasOptionalParams: Boolean);
begin
  AddDispMethod(AName, AInvokeProc, AParamsCount,
                TLMDTypeWrapperClass(FWrapperClass).GetVarType,
                AHasOptionalParams, True);
end;
                                                     
{ ---------------------------------------------------------------------------- }

procedure TLMDRecordWrapperData.AddProcedure(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AParamsCount: Integer;
  AHasOptionalParams: Boolean);
begin
  AddDispMethod(AName, AInvokeProc, AParamsCount, nil,
                AHasOptionalParams, False);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRecordWrapperData.AddFunction(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AResultType: TLMDTypeWrapperClass;
  AParamsCount: Integer; AHasOptionalParams: Boolean);
var
  dbgtp: TLMDDebugTypeFunc;
begin
  if AResultType <> nil then // Can be nil due to old overload
                             // groups implementation.
    dbgtp := AResultType.GetVarType
  else
    dbgtp := TVarDebugType.Get(varVariant);

  AddDispMethod(AName, AInvokeProc, AParamsCount, dbgtp,
                AHasOptionalParams, False);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRecordWrapperData.AddClassProcedure(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AParamsCount: Integer;
  AHasOptionalParams: Boolean);
begin
  AddDispMethod(AName, AInvokeProc, AParamsCount, nil,
                AHasOptionalParams, True);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRecordWrapperData.AddClassProperty(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass; AIsReadable,
  AIsWritable: Boolean; AParamsCount: Integer; AIsProtected: Boolean);
begin
    // AIsProtected - Is present here for consistency with class wrappers;
    //                not really used.

  AddDispProp(AName, AInvokeProc, AType.GetVarType, AIsReadable,
              AIsWritable, AParamsCount, True);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRecordWrapperData.AddClassField(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass);
begin
  AddDispProp(AName, AInvokeProc, AType.GetVarType,
              True, True, 0, True);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRecordWrapperData.AddClassFunction(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AResultType: TLMDTypeWrapperClass;
  AParamsCount: Integer; AHasOptionalParams: Boolean);
var
  dbgtp: TLMDDebugTypeFunc;
begin
  if AResultType <> nil then // Can be nil due to old overload
                             // groups implementation.
    dbgtp := AResultType.GetVarType
  else
    dbgtp := TVarDebugType.Get(varVariant);

  AddDispMethod(AName, AInvokeProc, AParamsCount, dbgtp,
                AHasOptionalParams, True);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRecordWrapperData.AddProperty(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass;
  AIsReadable, AIsWritable: Boolean; AParamsCount: Integer;
  AIsProtected, AIsDefault: Boolean);
begin
  // AIsProtected - Is present here for consistency with class wrappers;
  //                not really used.

  AddDispProp(AName, AInvokeProc, AType.GetVarType, AIsReadable,
              AIsWritable, AParamsCount, False, False, AIsDefault);
end;

{************************** class TLMDRecordWrapper ***************************}
{ --------------------------------- protected -------------------------------- }

class function TLMDRecordWrapper.GetDataClass: TLMDWrapperDataClass;
begin
  Result := TLMDRecordWrapperData;
end;
                                                           
{ ---------------------------------------------------------------------------- }

class procedure TLMDRecordWrapper.InitData(AData: TLMDWrapperData);
var
  data: TLMDRecordWrapperData;
begin
  data := AData as TLMDRecordWrapperData;
  DoInit(data);
end;
                                                          
{ ---------------------------------------------------------------------------- }

function TLMDRecordWrapper.LowInvoke(AItem: TLMDInvokeItem;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; AIsGet: Boolean): OleVariant;
begin
  if iiaMetaMember in AItem.Attrs then
    Result := AItem.InvokeProc(nil^, AArgs, AArgsSize, AIsGet)
  else
    Result := AItem.InvokeProc(Self, AArgs, AArgsSize, AIsGet);
end;
                                                          
{ ---------------------------------------------------------------------------- }

class function TLMDRecordWrapper.LowMetaInvoke(AItem: TLMDInvokeItem;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; AIsGet: Boolean): OleVariant;
begin
  Result := AItem.InvokeProc(nil^, AArgs, AArgsSize, AIsGet);
end;
    
{ ---------------------------------------------------------------------------- }

class function TLMDRecordWrapper.ConvToVar(
  wrpr: TLMDRecordWrapper): OleVariant;
begin
  Result := WrapperToVariant(wrpr);
end;
    
{ ---------------------------------------------------------------------------- }

class function TLMDRecordWrapper.ConvFromVar(
  const ARecord: OleVariant): TLMDRecordWrapper;
var
  dwrr: TLMDDispWrapper;
begin
  dwrr := VariantToWrapper(ARecord, False);

  if dwrr.ClassType <> Self then // Variant is not a record or
                                 // a record of different type.
    VarCastError;

  Result := TLMDRecordWrapper(dwrr);
end;

{ ---------------------------------------------------------------------------- }

function TLMDRecordWrapper.CloneVal: TLMDRecordWrapper;
begin
  Result := nil;
  Assert(False); // This method is not abstract only for
                 // C++ Builder compatibility.
end;

{ --------------------------------- protected -------------------------------- }

class procedure TLMDRecordWrapper.DoInit(AData: TLMDRecordWrapperData);
begin
  // Do nothing.
end;
                                                            
{ ---------------------------------- public ---------------------------------- }

constructor TLMDRecordWrapper.Create;
begin
  inherited Create;
end;

{**************************** class TLMDEnumWrapper ***************************}
{ --------------------------------- protected -------------------------------- }

class procedure TLMDEnumWrapper.RegisterEnumerators(
  AUnitData: TLMDWrapperData);
var
  i:      Integer;
  tpinfo: LMDTypes.TLMDTypeInfo;
  tpdata: TLMDTypeData;
  name:   WideString;
  udata:  TLMDUnitWrapperData;
  penm:   PLMDEnumerator;
  cnt:    Integer;
begin
  udata  := AUnitData as TLMDUnitWrapperData;
  tpinfo := GetEnumTypeInfo;

  if tpinfo <> nil then // Old, deprecated way.
  begin
    tpdata := GetTypeData(tpinfo);

    for i := tpdata.MinValue to tpdata.MaxValue do
    begin
      name := GetEnumName(tpinfo, i);
      if name <> '' then
        udata.RegisterEnumerator(name, Self, i);
    end;
  end
  else // New way.
  begin
    GetEnumerators(penm, cnt);

    for i := 0 to cnt - 1 do
    begin
      udata.RegisterEnumerator(penm.Name, Self, penm.Value);
      Inc(penm);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDEnumWrapper.GetEnumerators(out AEnums: PLMDEnumerator;
  out ACount: Integer);
begin
  // This method is a new way for retrieving enumerators,
  // because not every enum type has a type info.
end;

{ ---------------------------------------------------------------------------- }

class function TLMDEnumWrapper.GetEnumTypeInfo: TLMDTypeInfo;
begin
  Result := nil; // This method is deprecated, new
                 // wrappers should use GetEnumerators
                 // method.
end;

{ --------------------------------- protected -------------------------------- }

class function TLMDEnumWrapper.GetTypeName: WideString;
begin
  Result :=  {$IFDEF LMDCOMP12}string{$ENDIF}(PTypeInfo(GetEnumTypeInfo).Name);
end;

{*************************** class TLMDSetWrapper *****************************}
{ -------------------------------- protected --------------------------------- }

class function TLMDSetWrapper.ConvToVar(ASetPtr: Pointer): OleVariant;
begin
  Result := LMDSetToVar(GetSetSizeOf, ASetPtr^);
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDSetWrapper.ConvFromVar(const ASet: OleVariant;
  AResPtr: Pointer);
var
  val: Integer;
begin
  val := ASet;
  case GetSetSizeOf of
    1:  Byte(AResPtr^)    := val;
    2:  Word(AResPtr^)    := val;
    4:  Longint(AResPtr^) := val;
  else
    raise EOleSysError.Create(SLMDUnsupportedSetType, E_FAIL, -1);
  end;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDSetWrapper.GetSetSizeOf: Integer;
begin
  Result := 0;
  Assert(False); // This method is not abstract only for
                 // C++ Builder compatibility.
end;

{*************************** class TLMDEventWrapper ***************************}
{ -------------------------------- protected --------------------------------- }

class function TLMDEventWrapper.ConvToVar(AEvent: TMethod): OleVariant;
type
  TEventStub = procedure of object;
var
  wrapper: TLMDEventWrapper;
begin
  if not Assigned(TEventStub(AEvent)) then
  begin
    Result := LMDVarNil;
    Exit;
  end;

  wrapper := Create(AEvent);
  Result  := WrapperToVariant(wrapper);
end;

{ ---------------------------------------------------------------------------- }

class function TLMDEventWrapper.ConvToVarS(AScriptControl: TObject;
  const AProcName: WideString): OleVariant;
begin
  Result := TLMDScriptHandlerWrapper.Create(AScriptControl,
                                            AProcName) as IDispatch;
end;
    
{ ---------------------------------------------------------------------------- }

class function TLMDEventWrapper.ConvFromVar(
  const AEvent: OleVariant): TMethod;
type
  TEventStub = procedure of object;
var
  dwrr: TLMDDispWrapper;
  sctl: TLMDScriptControl;
  shlr: TLMDScriptEventHandler;
begin
  dwrr := VariantToWrapper(AEvent, True);
  if dwrr = nil then
  begin
    Result.Data := nil;
    Result.Code := nil;
    Exit;
  end;

  if dwrr.ClassType = TLMDScriptHandlerWrapper then
  begin
    sctl := TLMDScriptControl(TLMDScriptHandlerWrapper(dwrr).FScriptControl);
    shlr := sctl.GetEventHandler(TLMDScriptHandlerWrapper(dwrr).FProcName,
                                 Self);
    Result := shlr.GetHandler;
  end
  else
  begin
    if dwrr.ClassType <> Self then // Variant is not an event or
                                   // an event of different type.
      VarCastError;
    Result := TLMDEventWrapper(dwrr).FValue;
  end;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDEventWrapper.GetScriptHandlerClass: TClass;
begin
  Result := nil;
  Assert(False); // This method is not abstract only for
                 // C++ Builder compatibility.
end;

{ ---------------------------------- public ---------------------------------- }

constructor TLMDEventWrapper.Create(AValue: TMethod);
begin
  inherited Create;

  FValue := AValue;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDEventWrapper.ToVar(AScriptControl: TObject;
  const AProcName: WideString): OleVariant;
begin
  Result := ConvToVarS(AScriptControl, AProcName);
end;

{*********************** class TLMDScriptHandlerWrapper ***********************}
{ ---------------------------------- public ---------------------------------- }

constructor TLMDScriptHandlerWrapper.Create(AScriptControl: TObject;
  const AProcName: WideString);
begin
  inherited Create;
  FScriptControl := AScriptControl;
  FProcName      := AProcName;
end;

{************************* class TLMDUnitEnumerators **************************}
{ --------------------------------- private ---------------------------------- }

function TLMDUnitEnumerators.GetValues(AIndex: Integer): Integer;
begin
  Result := FValues[AIndex];
end;

{ ---------------------------------- public ---------------------------------- }

constructor TLMDUnitEnumerators.Create;
begin
  inherited Create;

  FCount := 0;
  SetLength(FValues, 0);
end;

{ ---------------------------------------------------------------------------- }

destructor TLMDUnitEnumerators.Destroy;
begin
  Clear;
  inherited;
end;
                                                      
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitEnumerators.Clear;
begin
  FCount := 0;
  SetLength(FValues, 0);
end;
                                                         
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitEnumerators.Add(AValue: Integer);
var
  newcnt: Integer;
begin
  newcnt := FCount + 1;

  if newcnt > Length(FValues) then
    SetLength(FValues, Trunc(newcnt * 1.5)); // Grow.

  FValues[newcnt - 1] := AValue;
  FCount := newcnt;
end;

{************************* class TLMDUnitWrapperData **************************}
{ --------------------------------- protected -------------------------------- }

procedure TLMDUnitWrapperData.RegisterEnumerator(const AName: WideString;
  AType: TLMDTypeWrapperClass; AValue: Integer);
begin
  AddDispProp(AName, nil, AType.GetVarType, True, False, 0, False);
  FEnumerators.Add(AValue);
end;
                                                      
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitWrapperData.EnumFound(AWrapperClass: TLMDEnumWrapperClass);
begin
  if FFoundEnums = nil then
    FFoundEnums := TList.Create;

  FFoundEnums.Add(AWrapperClass);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitWrapperData.PostprocessEnums;
var
  i: Integer;
begin
  if FFoundEnums <> nil then
  begin
    for i := 0 to FFoundEnums.Count - 1 do
      TLMDEnumWrapperClass(FFoundEnums[i]).RegisterEnumerators(Self);

    FreeAndNil(FFoundEnums);
  end;
end;

{ ---------------------------------- public ---------------------------------- }

constructor TLMDUnitWrapperData.Create(AWrapperClass: TLMDWrapperClass);
begin
  inherited;
  FFoundEnums  := nil;
  FEnumerators := TLMDUnitEnumerators.create;
end;
                                                     
{ ---------------------------------------------------------------------------- }

destructor TLMDUnitWrapperData.Destroy;
begin
  FEnumerators.Free;
  FFoundEnums.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitWrapperData.AddConstant(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass;
  AVarType: TVarType);
var
  dbgtp: TLMDDebugTypeFunc;
begin
  if AType <> nil then
    dbgtp := AType.GetVarType
  else
    dbgtp := TVarDebugType.Get(AVarType);

  AddDispProp(AName, AInvokeProc, dbgtp, True, False, 0, False);
end;
                                                      
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitWrapperData.AddVariable(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AType: TLMDTypeWrapperClass);
begin
  AddDispProp(AName, AInvokeProc, AType.GetVarType,
              True, True, 0, False);
end;
                                                       
{ ---------------------------------------------------------------------------- }

procedure TLMDUnitWrapperData.AddProcedure(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AParamsCount: Integer;
  AHasOptionalParams: Boolean);
begin
  AddDispMethod(AName, AInvokeProc, AParamsCount, nil,
                AHasOptionalParams, False);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitWrapperData.AddFunction(const AName: WideString;
  AInvokeProc: TLMDInvokeProc; AResultType: TLMDTypeWrapperClass;
  AParamsCount: Integer; AHasOptionalParams: Boolean);
var
  dbgtp: TLMDDebugTypeFunc;
begin
  if AResultType <> nil then // Can be nil due to old overload
                             // groups implementation.
    dbgtp := AResultType.GetVarType
  else
    dbgtp := TVarDebugType.Get(varVariant);

  AddDispMethod(AName, AInvokeProc, AParamsCount, dbgtp,
                AHasOptionalParams, False);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitWrapperData.AddType(AWrapperClass: TLMDTypeWrapperClass;
  AInvokeProc: TLMDInvokeProc);
begin
  AddDispProp(AWrapperClass.GetTypeName, AInvokeProc,
              AWrapperClass.GetVarType, True, False, 0, False);

  if AWrapperClass.InheritsFrom(TLMDEnumWrapper) then
    EnumFound(TLMDEnumWrapperClass(AWrapperClass));
end;
             
{**************************** class TLMDUnitWrapper ***************************}
{ --------------------------------- protected -------------------------------- }

class function TLMDUnitWrapper.GetDataClass: TLMDWrapperDataClass;
begin
  Result := TLMDUnitWrapperData;
end;
                                                                
{ ---------------------------------------------------------------------------- }

class procedure TLMDUnitWrapper.InitData(AData: TLMDWrapperData);
var
  data: TLMDUnitWrapperData;
begin
  data := AData as TLMDUnitWrapperData;
  DoInit(data);
  data.FNonEnumCount := data.FDispInfo.GetInvokeItemCount;
  data.PostprocessEnums;
end;

{ ---------------------------------------------------------------------------- }

function TLMDUnitWrapper.LowInvoke(AItem: TLMDInvokeItem;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; AIsGet: Boolean): OleVariant;
var
  data:     TLMDUnitWrapperData;
  nenumcnt: Integer;
begin
  data     := GetData as TLMDUnitWrapperData;
  nenumcnt := data.FNonEnumCount;

  if AItem.Index < nenumcnt then
    Result := AItem.InvokeProc(Self, AArgs, AArgsSize, AIsGet)
  else
    Result := data.FEnumerators[AItem.Index - nenumcnt];
end;

class function TLMDUnitWrapper.TypeToVar(
  AWrapperClass: TLMDTypeWrapperClass): OleVariant;
begin
  Result := ConvToVar(AWrapperClass);
end;

{ --------------------------------- protected -------------------------------- }

class function TLMDUnitWrapper.ConvToVar(
  AWrapperClass: TLMDTypeWrapperClass): OleVariant;
begin
  if AWrapperClass = nil then
    Result := LMDVarNil
  else
    Result := AWrapperClass.TypeToVariant;
end;
    
{ ---------------------------------------------------------------------------- }

class function TLMDUnitWrapper.ConvFromVar(const AType: OleVariant;
  AAllowNil: Boolean): TLMDTypeWrapperClass;
var
  dwrr: TLMDDispWrapper;
begin
  dwrr := VariantToWrapper(AType, AAllowNil);

  if dwrr = nil then
  begin
    Result := nil;
    Exit;
  end;

  if not (dwrr is TLMDMetatypeWrapper) then // Variant is a wrapper, but does not
                                            // represent a reference to metatype.
    VarCastError;

  Result := TLMDMetatypeWrapper(dwrr).FType;
end;

{ ---------------------------------------------------------------------------- }

class procedure TLMDUnitWrapper.DoInit(AData: TLMDUnitWrapperData);
begin
  // Do nothing.
end;
                                                           
{ ---------------------------------- public ---------------------------------- }

constructor TLMDUnitWrapper.Create(AScriptControl: TObject);
begin
  inherited Create;
  FScriptControl := AScriptControl;
end;
                                                           
{ ---------------------------------------------------------------------------- }

class function TLMDUnitWrapper.GetUnitName: WideString;
begin
  Assert(False); // This method is not abstract only for
                 // C++ Builder compatibility.
end;

{************************ clas TDispInfoNameIndexTraits ***********************}
{ ---------------------------------- public ---------------------------------- }

class function TDispInfoNameIndexTraits.BeforeAdd(AItem: TObject;
  ATable: TLMDHashTable): Boolean;
begin
  Result := (ATable.Find(TLMDInvokeItem(AItem).UppName) = nil);
end;

{ ---------------------------------------------------------------------------- }

class function TDispInfoNameIndexTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := MakeHashK(TLMDInvokeItem(AItem).UppName);
end;

{ ---------------------------------------------------------------------------- }

class function TDispInfoNameIndexTraits.MakeHashK(const AKey): Integer;
begin
  Result := TLMDHashTable.StrHash(WideString(AKey));
end;

{ ---------------------------------------------------------------------------- }

class function TDispInfoNameIndexTraits.Compare(const AKey;
  AItem: TObject): Boolean;
begin
  Result := (WideString(AKey) = TLMDInvokeItem(AItem).UppName);
end;                                                         

{************************* clas TWrapperDataListTraits ************************}
{ ---------------------------------- public ---------------------------------- }

class function TWrapperDataListTraits.BeforeAdd(AItem: TObject;
  ATable: TLMDHashTable): Boolean;
begin
  Result := (ATable.Find(TLMDWrapperData(AItem).FWrapperClass) = nil);
end;

{ ---------------------------------------------------------------------------- }

class function TWrapperDataListTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := MakeHashK(TLMDWrapperData(AItem).FWrapperClass);
end;

{ ---------------------------------------------------------------------------- }

class function TWrapperDataListTraits.MakeHashK(const AKey): Integer;
var
  wk: TLMDWrapperClass;
begin
  wk     := TLMDWrapperClass(AKey);
  Result := TLMDHashTable.PtrHash(wk);
end;

{ ---------------------------------------------------------------------------- }

class function TWrapperDataListTraits.Compare(const AKey;
  AItem: TObject): Boolean;
begin
  Result := (TLMDWrapperClass(AKey) = TLMDWrapperData(AItem).FWrapperClass);
end;

{************************* clas TWrapperByObjectTraits ************************}
{ ---------------------------------- public ---------------------------------- }

class function TWrapperByObjectTraits.BeforeAdd(AItem: TObject;
  ATable: TLMDHashTable): Boolean;
begin
  Result := (ATable.Find(TLMDClassWrapper(AItem).FValue) = nil);
end;

{ ---------------------------------------------------------------------------- }

class function TWrapperByObjectTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := MakeHashK(TLMDClassWrapper(AItem).FValue);
end;

{ ---------------------------------------------------------------------------- }

class function TWrapperByObjectTraits.MakeHashK(const AKey): Integer;
begin
  Result := TLMDHashTable.PtrHash(TObject(AKey));
end;

{ ---------------------------------------------------------------------------- }

class function TWrapperByObjectTraits.Compare(const AKey;
  AItem: TObject): Boolean;
begin
  Result := (TObject(AKey) = TLMDClassWrapper(AItem).FValue);
end;

{*************************** clas TWrapperClassTraits *************************}
{ ----------------------------------- public --------------------------------- }

class function TWrapperClassTraits.BeforeAdd(AItem: TObject;
  ATable: TLMDHashTable): Boolean;
var
  key: TClass;
begin
  key    := TWrapperClassItem(AItem).FWrapperClass.GetWrappedClass;
  Result := (ATable.Find(key) = nil);
end;

{ ---------------------------------------------------------------------------- }

class function TWrapperClassTraits.MakeHashI(AItem: TObject): Integer;
var
  key: TClass;
begin
  key    := TWrapperClassItem(AItem).FWrapperClass.GetWrappedClass;
  Result := MakeHashK(key);
end;

{ ---------------------------------------------------------------------------- }

class function TWrapperClassTraits.MakeHashK(const AKey): Integer;
var
  cls: TClass;
begin
  cls    := TClass(AKey);
  Result := TLMDHashTable.PtrHash(cls);
end;

{ ---------------------------------------------------------------------------- }

class function TWrapperClassTraits.Compare(const AKey;
  AItem: TObject): Boolean;
var
  key: TClass;
begin
  key    := TWrapperClassItem(AItem).FWrapperClass.GetWrappedClass;
  Result := (TClass(AKey) = key);
end;

{****************************** TEventWrapperTraits ***************************}
{ ---------------------------------------------------------------------------- }

class function TEventWrapperTraits.BeforeAdd(AItem: TObject;
  ATable: TLMDHashTable): Boolean;
var
  key: PTypeInfo;
begin
  key    := TEventWrapperItem(AItem).FEventType;
  Result := (ATable.Find(key) = nil);
end;
            
{ ---------------------------------------------------------------------------- }

class function TEventWrapperTraits.MakeHashI(AItem: TObject): Integer;
var
  key: PTypeInfo;
begin
  key    := TEventWrapperItem(AItem).FEventType;
  Result := MakeHashK(key);
end;
          
{ ---------------------------------------------------------------------------- }

class function TEventWrapperTraits.MakeHashK(const AKey): Integer;
var
  ty: TLMDTypeInfo;
begin
  ty     := TLMDTypeInfo(AKey);
  Result := TLMDHashTable.PtrHash(ty);
end;
         
{ ---------------------------------------------------------------------------- }

class function TEventWrapperTraits.Compare(const AKey;
  AItem: TObject): Boolean;
var
  key: PTypeInfo;
begin
  key    := TEventWrapperItem(AItem).FEventType;
  Result := (PTypeInfo(AKey) = key);
end;

{**************************** clas TWrapperClassItem **************************}
{ ----------------------------------- public --------------------------------- }

constructor TWrapperClassItem.Create(AWrapperClass: TLMDClassWrapperClass);
begin
  inherited Create;
  FWrapperClass := AWrapperClass;
end;

{ ---------------------------------------------------------------------------- }

class function TWrapperClassItem.Get(AObjectClass: TClass):
  TLMDClassWrapperClass;
var
  cls:  TClass;
  item: TWrapperClassItem;
begin
  cls  := AObjectClass;
  item := nil; // Initialize
  while cls <> nil do
  begin
    item := TWrapperClassItem(WrapperClassByWrappedClass.Find(cls));
    if item <> nil then
      Break; // while

    cls := cls.ClassParent;
  end;

  Assert(item <> nil);
  Result := item.FWrapperClass;
end;

{***************************** TEventWrapperItem ******************************}
{ ---------------------------------------------------------------------------- }

constructor TEventWrapperItem.Create(AEventType: PTypeInfo;
  AWrapperClass: TLMDEventWrapperClass);
begin
  inherited Create;
  FEventType    := AEventType;
  FWrapperClass := AWrapperClass;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDispWrapper.EncodeInvokeError(E: Exception;
  AEInfo: PExcepInfo): HRESULT;
begin
  if E is EVariantTypeCastError then
  begin
    Result := DISP_E_TYPEMISMATCH;
    Exit;
  end;

  if AEInfo <> nil then
  begin
    FillChar(AEInfo^, SizeOf(TExcepInfo), 0);
    
    with AEInfo^ do
    begin
      bstrSource      := 'LMD-ScriptPack wrappers.';
      bstrDescription := e.Message;
      scode           := E_FAIL;
    end;
  end;
  
  Result := DISP_E_EXCEPTION;
end;

{ TWrapperByObject }

procedure TWrapperByObject.Add(AWrapper: TLMDClassWrapper);
begin
  FLock.Acquire;
  try
    FMap.Add(AWrapper);
    InternalObjectWrapped(AWrapper.FValue, ObjEnumerator);
  finally
    FLock.Release;
  end;
end;

constructor TWrapperByObject.Create;
begin
  inherited Create;

  FMap  := TLMDHashTable.Create(TWrapperByObjectTraits, False);
  FLock := TCriticalSection.Create;

  InternalSetObjDestroyedProc(ObjDestroyedProc);
end;

destructor TWrapperByObject.Destroy;
begin
  InternalSetObjDestroyedProc(nil);

  FLock.Free;
  FMap.Free;
  inherited;
end;

procedure TWrapperByObject.EnumWrappersProc(AItem: TObject);
var
  obj: TObject;
begin
  obj := TLMDClassWrapper(AItem).FValue;
  if obj <> nil then
    FOriginalItemProc(obj);
end;

function TWrapperByObject.Find(AObject: TObject): TLMDClassWrapper;
begin
  FLock.Acquire;
  try
    Result := TLMDClassWrapper(FMap.Find(AObject));
  finally
    FLock.Release;
  end;
end;

procedure TWrapperByObject.ObjDestroyedProc(AItem: TObject);
var
  cw: TLMDClassWrapper;
begin
  FLock.Acquire;
  try
    cw := TLMDClassWrapper(FMap.Find(AItem));
    if cw <> nil then
      cw.FValue := nil; 
  finally
    FLock.Release;
  end;
end;

procedure TWrapperByObject.ObjEnumerator(AItemProc: TLMDItemProc);
begin
  FLock.Acquire;
  try
    FOriginalItemProc := AItemProc;
    FMap.GetAll(EnumWrappersProc);
  finally
    FLock.Release;
  end;
end;

procedure TWrapperByObject.Remove(AObject: TObject);
begin
  FLock.Acquire;
  try
    FMap.Remove(AObject);
  finally
    FLock.Release;
  end;
end;

{ TDispTypeInfo }

function TDispTypeInfo.AddressOfMember(memid: TMemberID;
  invkind: TInvokeKind; out ppv: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

constructor TLMDAbstractDispInfo.Create;
begin
  inherited Create;
  FTypeInfo := TDispTypeInfo.Create(Self);
end;

function TDispTypeInfo.CreateInstance(const unkOuter: IInterface;
  const iid: TIID; out vObj): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDispTypeInfo.GetContainingTypeLib(out tlib: ITypeLib;
  out pindex: Integer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDispTypeInfo.GetDllEntry(memid: TMemberID;
  invkind: TInvokeKind; bstrDllName, bstrName: PWideString;
  wOrdinal: PWord): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDispTypeInfo.GetDocumentation(memid: TMemberID; pbstrName,
  pbstrDocString: PWideString; pdwHelpContext: PLongint;
  pbstrHelpFile: PWideString): HResult;
var
  item: TLMDInvokeItem;
begin
  if (memid < 0) or (memid >= FDispInfo.GetInvokeItemCount) then
  begin
    Result := E_INVALIDARG;
    Exit;
  end;
  item := FDispInfo.GetInvokeItem(memid);

  if pbstrName <> nil then
    pbstrName^ := item.Name;
  if pbstrDocString <> nil then
    pbstrDocString^ := item.Name;
  if pdwHelpContext <> nil then
    pdwHelpContext^ := -1;
  if pbstrHelpFile <> nil then
    pbstrHelpFile^ := '';

  Result := S_OK;
end;

function TDispTypeInfo.GetFuncDesc(index: Integer;
  out pfuncdesc: PFuncDesc): HResult;
var
  item:   TLMDInvokeItem;
  vtype:  TVarType;
  itmcnt: Integer;
begin
  itmcnt := Max(FDispInfo.GetInvokeItemCount - 1, 0); // Zero-id default item
                                                      // should not be included
                                                      // here.
  if (index < 0) or (index >= itmcnt) then
  begin
    Result := E_INVALIDARG;
    Exit;
  end;
  item := FDispInfo.GetInvokeItem(index + 1); // Skip zero-id default item.

  if Assigned(item.DebugType) then
    vtype := item.DebugType()
  else
    vtype := varEmpty;

  New(pfuncdesc);
  FillChar(pfuncdesc^, SizeOf(TFuncDesc), 0);

  pfuncdesc.memid                 := item.Index;
  pfuncdesc.lprgelemdescParam     := nil;
  pfuncdesc.funckind              := FUNC_DISPATCH;
  pfuncdesc.invkind               := item.InvokeFlags;
  pfuncdesc.callconv              := CC_SAFECALL;
  pfuncdesc.cParams               := item.ParamCount;
  pfuncdesc.cParamsOpt            := 0;
  pfuncdesc.elemdescFunc.tdesc.vt := vtype;
  pfuncdesc.wFuncFlags            := 0;

  Result := S_OK;
end;

function TDispTypeInfo.GetIDsOfNames(rgpszNames: POleStrList;
  cNames: Integer; rgmemid: PMemberIDList): HResult;
var
  i:    Integer;
  name: WideString;
  idx:  Integer;
  item: TLMDInvokeItem;
begin
  if (rgpszNames = nil) or (cNames = 0) or
     (rgmemid = nil) then
  begin
    Result := E_INVALIDARG;
    Exit;
  end;

  if cNames > 1 then
    for i := 1 to cNames - 1 do
      rgmemid[i] := DISPID_UNKNOWN;

  name := rgpszNames[0];
  idx  := FDispInfo.IndexOfInvokeItem(name, True);
  item := FDispInfo.GetInvokeItem(idx);

  if idx <= 0 then
  begin
    Result := DISP_E_UNKNOWNNAME;
    Exit;
  end;

  rgmemid[0] := item.Index;
  Result     := S_OK;
end;

function TDispTypeInfo.GetImplTypeFlags(index: Integer;
  out impltypeflags: Integer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDispTypeInfo.GetMops(memid: TMemberID;
  out bstrMops: WideString): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDispTypeInfo.GetNames(memid: TMemberID;
  rgbstrNames: PBStrList; cMaxNames: Integer;
  out cNames: Integer): HResult;
var
  item: TLMDInvokeItem;
begin
  if (memid < 0) or (memid >= FDispInfo.GetInvokeItemCount) then
  begin
    Result := E_INVALIDARG;
    Exit;
  end;
  item := FDispInfo.GetInvokeItem(memid);

  if (cMaxNames > 0) and (rgbstrNames <> nil) then
  begin
    rgbstrNames[0] := SysAllocString(PWideChar(item.Name));
    cNames         := 1;
  end;
  
  Result := S_OK;
end;

function TDispTypeInfo.GetRefTypeInfo(reftype: HRefType;
  out tinfo: ITypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDispTypeInfo.GetRefTypeOfImplType(index: Integer;
  out reftype: HRefType): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDispTypeInfo.GetTypeAttr(
  out ptypeattr: PTypeAttr): HResult;
var
  itmcnt: Integer;
begin
  New(ptypeattr);
  FillChar(ptypeattr^, SizeOf(TTypeAttr), 0);

  itmcnt := Max(FDispInfo.GetInvokeItemCount - 1, 0); // Zero-id default item
                                                      // should not be included
                                                      // here.
  ptypeattr.memidConstructor := -1;
  ptypeattr.memidDestructor  := -1;
  ptypeattr.typekind         := TKIND_DISPATCH;
  ptypeattr.cFuncs           := itmcnt;
  ptypeattr.wTypeFlags       := TYPEFLAG_FNONEXTENSIBLE or
                                TYPEFLAG_FDISPATCHABLE;

  Result := S_OK;
end;

function TDispTypeInfo.GetTypeComp(out tcomp: ITypeComp): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDispTypeInfo.GetVarDesc(index: Integer;
  out pvardesc: PVarDesc): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDispTypeInfo.Invoke(pvInstance: Pointer; memid: TMemberID;
  flags: Word; var dispParams: TDispParams; varResult: PVariant;
  excepInfo: PExcepInfo; argErr: PInteger): HResult;
begin
  Result := E_NOTIMPL;
end;

procedure TDispTypeInfo.ReleaseFuncDesc(pfuncdesc: PFuncDesc);
begin
  Dispose(pfuncdesc);
end;

procedure TDispTypeInfo.ReleaseTypeAttr(ptypeattr: PTypeAttr);
begin
  Dispose(ptypeattr);
end;

procedure TDispTypeInfo.ReleaseVarDesc(pvardesc: PVarDesc);
begin
  // Do nothing.
end;

class function TLMDTypeWrapper.GetVarType: TVarType;
begin
  Result := varEmpty;
end;

class function TLMDTypeWrapper.LowMetaInvoke(AItem: TLMDInvokeItem;
  const AArgs: TLMDDispArgs; AArgsSize: Integer; AIsGet: Boolean): OleVariant;
begin
  Result := Unassigned; // Do nothing.
end;

class function TLMDClassWrapper.GetVarType: TVarType;
begin
  Result := varDispatch;
end;

class function TLMDMetaclassWrapper.GetVarType: TVarType;
begin
  Result := varDispatch;
end;

class function TLMDRecordWrapper.GetVarType: TVarType;
begin
  Result := varDispatch;
end;

class function TLMDEnumWrapper.GetVarType: TVarType;
begin
  Result := varInteger;
end;

class function TLMDSetWrapper.GetVarType: TVarType;
begin
  Result := varInteger;
end;

class function TLMDEventWrapper.GetVarType: TVarType;
begin
  Result := varDispatch;
end;

{ TLMDSubrangeWrapper }

class function TLMDSubrangeWrapper.GetVarType: TVarType;
begin
  Result := varInteger;
end;

{ TDispTypeInfo }

constructor TDispTypeInfo.Create(ADispInfo: TLMDAbstractDispInfo);
begin
  inherited Create;
  FDispInfo := ADispInfo;
end;

{ TLMDInvokeItem }

procedure TLMDInvokeItem.Assign(AItem: TLMDInvokeItem);
begin
  UppName       := AItem.UppName;
  Name          := AItem.Name;
  DebugType     := AItem.DebugType;
  Attrs         := AItem.Attrs;
  ParamCount    := AItem.ParamCount;
  MinParamCount := AItem.MinParamCount;
  InvokeFlags   := AItem.InvokeFlags;
  ResMask       := AItem.ResMask;
  InvokeProc    := AItem.InvokeProc;
end;

{ TVarDebugType }

function TVarDebugType.Func: TVarType;
begin
  Result := FVarType;
end;

class function TVarDebugType.Get(AType: TVarType): TLMDDebugTypeFunc;
var
  dbgtp: TVarDebugType;
begin
  dbgtp := TVarDebugType(VarDebugTypes.Find(AType));

  if dbgtp = nil then
  begin
    dbgtp          := TVarDebugType.Create;
    dbgtp.FVarType := AType;
    VarDebugTypes.Add(dbgtp);
  end;

  Result := dbgtp.Func;
end;

{ TVarDebugTypesTraits }

class function TVarDebugTypesTraits.BeforeAdd(AItem: TObject;
  ATable: TLMDHashTable): Boolean;
var
  key: TVarType;
begin
  key    := TVarDebugType(AItem).FVarType;
  Result := (ATable.Find(key) = nil);
end;

class function TVarDebugTypesTraits.Compare(const AKey;
  AItem: TObject): Boolean;
var
  key: TVarType;
begin
  key    := TVarDebugType(AItem).FVarType;
  Result := (TVarType(AKey) = key);
end;

class function TVarDebugTypesTraits.MakeHashI(AItem: TObject): Integer;
var
  key: TVarType;
begin
  key    := TVarDebugType(AItem).FVarType;
  Result := MakeHashK(key);
end;

class function TVarDebugTypesTraits.MakeHashK(const AKey): Integer;
var
  vtp: TVarType;
begin
  vtp    := TVarType(AKey);
  Result := TLMDHashTable.IntHash(vtp);
end;

initialization
  WrapperDataList            := TLMDHashTable.Create(TWrapperDataListTraits, True);
  UnitWrapperClassList       := TList.Create;
  WrapperByObject            := TWrapperByObject.Create;
  WrapperClassByWrappedClass := TLMDHashTable.Create(TWrapperClassTraits, True);
  EventWrapperByTypeInfo     := TLMDHashTable.Create(TEventWrapperTraits, True);
  VarDebugTypes              := TLMDHashTable.Create(TVarDebugTypesTraits, True);

  _RegisterSysWrappers;

{ ---------------------------------------------------------------------------- }

finalization
  FreeAndNil(WrapperByObject);
  FreeAndNil(WrapperClassByWrappedClass);
  FreeAndNil(EventWrapperByTypeInfo);
  FreeAndNil(UnitWrapperClassList);
  FreeAndNil(WrapperDataList);
  FreeAndNil(VarDebugTypes);

{ ---------------------------------------------------------------------------- }

end.

