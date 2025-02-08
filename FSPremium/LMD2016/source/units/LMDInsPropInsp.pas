unit LMDInsPropInsp;
{$I LmdCmps.inc}

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

LMDInsPropInsp unit (YB)
------------------------
TLMDPropertyInspector and Property Editors unit

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, Controls, Grids, Graphics, Windows, Messages, Forms,
  Dialogs, TypInfo, Menus, Masks, RTLConsts, Variants, Types, intfLMDBase,
  LMDUnicode, LMDUnicodeStrings, LMDTypes, LMDHashTable, LMDInsClass, LMDInsCst,
  LMDInsPropPage, LMDInsEditorUtils, LMDInsEditorWnds;

type
  ELMDPropertyInspector         = class(Exception);
  TLMDCustomPropertyInspector   = class;
  TLMDPropertyInspectorPageItem = class;

  ELMDPropEditor                = class(Exception);
  TLMDPropEditor                = class;
  TLMDPropEditorClass           = class of TLMDPropEditor;
               
  { ****************************** ILMDProperty ****************************** }

  ILMDProperty = class
  public
    function  Name: TLMDString; virtual; abstract;
    function  PropType: TLMDTypeInfo; virtual; abstract;
    function  RTTIPropInfo: TLMDPropInfo; virtual;
    function  IsReadable: Boolean; virtual; abstract;
    function  IsWritable: Boolean; virtual; abstract;
    function  IsDefaultValue(Instance: TPersistent): Boolean; virtual; abstract;
    function  GetFloatValue(Instance: TPersistent): Extended; virtual;
    function  GetInt64Value(Instance: TPersistent): Int64; virtual;
    function  GetOrdValue(Instance: TPersistent): Longint; virtual;
    function  GetStrValue(Instance: TPersistent): string; virtual;
    function  GetWideStrValue(Instance: TPersistent): WideString; virtual;
    function  GetVariantValue(Instance: TPersistent): Variant; virtual;
    function  GetObjectValue(Instance: TPersistent): TObject; virtual;
    procedure SetFloatValue(Instance: TPersistent; AValue: Extended); virtual;
    procedure SetInt64Value(Instance: TPersistent; AValue: Int64); virtual;
    procedure SetOrdValue(Instance: TPersistent; AValue: Longint); virtual;
    procedure SetStrValue(Instance: TPersistent; const AValue: string); virtual;
    procedure SetWideStrValue(Instance: TPersistent; const AValue: WideString); virtual;
    procedure SetVariantValue(Instance: TPersistent; const AValue: Variant); virtual;
    procedure SetObjectValue(Instance: TPersistent; AValue: TObject); virtual;
  end;

  { ***************************** TLMDPropEditor ***************************** }

  TLMDPropAttr  = (praValueList, praSubProperties, praDialog, praMultiSelect,
                   praSortList, praReadOnly, praVolatileSubProperties,
                   praNotNestable, praAutoUpdate, praOwnerDrawValues,
                   praComponentRef, praEditableByRef);
  TLMDPropAttrs = set of TLMDPropAttr;

  TLMDPropEditorPropListItem = record
    Instance: TPersistent;
    PropInfo: ILMDProperty;
  end;

  TLMDPropertyInspectorEditorDescr = record
    TypeInfo:    TLMDTypeInfo;
    ObjectClass: TClass;
    PropName:    TLMDString;
    EditorClass: TLMDPropEditorClass;
  end;

  PLMDPropEditorPropList = ^TLMDPropEditorPropList;
  TLMDPropEditorPropList = array[0..1023 { Range not used }] of TLMDPropEditorPropListItem;

  TLMDSetByRefProc = procedure(AInstance: TPersistent; AProp: ILMDProperty;
                               AData: Pointer) of object;

  TLMDPropEditor = class
  private
    FPropInsp:        TLMDCustomPropertyInspector;
    FPageItem:        TLMDPropertyInspectorPageItem;
    FPropList:        PLMDPropEditorPropList;
    FOwnPropList:     Boolean;
    FPropCount:       Integer;
    FTmpData:         TLMDDataTag;
    FParentObjEditor: TLMDPropEditor;

    function  DoGetValue: TLMDString;
    function  GetPropTypeInfo: TLMDTypeInfo;
  protected
    procedure Change;
    procedure SetPropEntry(AIndex: Integer; AInstance: TPersistent;
                           APropInfo: ILMDProperty);
    function  GetValue: TLMDString; virtual;
    procedure SetValue(const Value: TLMDString); virtual;
    function  GetAttrs: TLMDPropAttrs; virtual;
    procedure GetValues(AValues: TLMDStrings); virtual;
    procedure GetSubProps(AResult: TList); virtual; // Returns a list of TLMDPropEditor.
    function  GetPropName: TLMDString; virtual;
    function  AllEqual: Boolean; virtual;
    procedure Edit; virtual;
    procedure ValuesMeasureHeight(const AValue: TLMDString; ACanvas: TCanvas;
                                  var AHeight: Integer); virtual;
    procedure ValuesMeasureWidth(const AValue: TLMDString; ACanvas: TCanvas;
                                 var AWidth: Integer); virtual;
    procedure ValuesDrawValue(const AValue: TLMDString; ACanvas: TCanvas;
                              const ARect: TRect; ASelected: Boolean); virtual;
  protected
    function  GetFloatValue(AIndex: Integer): Extended;
    function  GetInt64Value(AIndex: Integer): Int64;
    function  GetOrdValue(AIndex: Integer): Longint;
    function  GetStrValue(AIndex: Integer): string;
    function  GetWideStrValue(AIndex: Integer): WideString;
    function  GetVarValue(AIndex: Integer): Variant;
    function  GetObjectValue(AIndex: Integer): TObject;
    function  GetEventValue(AIndex: Integer): TLMDString;
    function  GetDefaultEventHandlerName(AIndex: Integer): TLMDString;
    procedure GetExistingEventHandlers(AResult: TLMDStrings);
    function  GetCompRef(const ACompName: TLMDString): TComponent;
    function  GetCompRefName(AComponent: TComponent): TLMDString;
    procedure GetCompRefList(AClass: TComponentClass; AResult: TList);

    procedure SetFloatValue(Value: Extended);
    procedure SetInt64Value(Value: Int64);
    procedure SetOrdValue(Value: Longint);
    procedure SetStrValue(const Value: string);
    procedure SetWideStrValue(const Value: WideString);
    procedure SetVarValue(const Value: Variant);
    procedure SetObjectValue(const Value: TObject);
    procedure SetEventValue(const Value: TLMDString);
    procedure ShowEventHandler(const AValue: TLMDString);
    procedure SetByRef(const AProc: TLMDSetByRefProc; AData: Pointer);

    procedure GetPropEditors(AParentObjEditor: TLMDPropEditor; AObjList: TList;
                             AOnlyNestable, AIsSubProp: Boolean; AResult: TList);
  public
    constructor Create(APropInsp: TLMDCustomPropertyInspector;
                       AParentObjEditor: TLMDPropEditor; APropCount: Integer;
                       APropList: Pointer = nil); virtual;
    destructor Destroy; override;

    function CreateEditorWndCbs(AEditedObject: TPersistent;
              out AResult: TLMDEditorWindowCallbacks): Boolean;

    function GetPropInfo(AIndex: Integer): ILMDProperty;
    function GetInstance(AIndex: Integer): TPersistent;
    function IsWrittenProperty: Boolean;
    property PropInsp: TLMDCustomPropertyInspector read FPropInsp;
    property PropName: TLMDString read GetPropName;
    property PropTypeInfo: TLMDTypeInfo read GetPropTypeInfo;
    property PropCount: Integer read FPropCount;
    property Value: TLMDString read DoGetValue write SetValue;
    property ParentObjEditor: TLMDPropEditor read FParentObjEditor;
  end;

  { ************************* TLMDNestedPropEditor *************************** }

  TLMDNestedPropEditor = class(TLMDPropEditor)
  protected
    function GetPropName: TLMDString; override;
  public
    constructor Create(ANestedIn: TLMDPropEditor); reintroduce;
    destructor Destroy; override;
  end;

  { ********************* TLMDPropertyInspectorPageItem ********************** }

  TLMDPropertyInspectorPageItem = class(TLMDPropsPageItem)
  private
    FEditor:        TLMDPropEditor;
    FDisplayValue:  TLMDString;
    FEditValue:     TLMDString;

    procedure DeGetPickList(AResult: TLMDStrings);
    procedure SetEditor(const Value: TLMDPropEditor);
  protected
    function  GetDisplayValue: TLMDString; override;
    function  GetEditValue: TLMDString; override;
    procedure SetEditValue(const Value: TLMDString; AForce: Boolean); override;
    procedure GetEditPickList(APickList: TLMDStrings); override;
    procedure EditButtonClick; override;
    procedure EditDblClick; override;
    procedure PickListMeasureHeight(const AValue: TLMDString; ACanvas: TCanvas;
                                    var AHeight: Integer); override;
    procedure PickListMeasureWidth(const AValue: TLMDString; ACanvas: TCanvas;
                                   var AWidth: Integer); override;
    procedure PickListDrawValue(const AValue: TLMDString; ACanvas: TCanvas;
                                const ARect: TRect; ASelected: Boolean); override;
  public
    destructor Destroy; override;

    procedure UpdateParams;
    function  CanEdit: Boolean;
    procedure Edit;
    property  Editor: TLMDPropEditor read FEditor write SetEditor;
  end;

  { *********************** TLMDPropertyInspectorItem ************************ }

  TLMDPropertyInspectorItems      = class;
  TLMDPropertyInspectorItem       = class;
  TLMDPropertyInspectorCategory   = class;
  TLMDPropertyInspectorCategories = class;

  TLMDPropertyInspectorItem = class
  private
    FItems:      TList;
    FOwnerItems: TLMDPropertyInspectorItems;
    FParent:     TLMDPropertyInspectorItem;
    FPageItem:   TLMDPropertyInspectorPageItem;

    procedure InsertItem(AItem: TLMDPropertyInspectorItem);
    procedure RemoveItem(AItem: TLMDPropertyInspectorItem);
    procedure Clear;
    function  GetItems(AIndex: Integer): TLMDPropertyInspectorItem;
    function  GetActive: Boolean;
    function  GetExpanded: Boolean;
    function  GetLevel: Integer;
    function  GetOwner: TLMDCustomPropertyInspector;
    function  GetPropInfo(AIndex: Integer): ILMDProperty;
    procedure SetActive(const Value: Boolean);
    function  GetCount: Integer;
    function  GetTypeInfo: TLMDTypeInfo;
    function  GetPropName: TLMDString;
    function  GetValue: TLMDString;
    procedure SetValue(const Value: TLMDString);
    function  GetParentCategory: TLMDPropertyInspectorCategory;
    function  GetEditor: TLMDPropEditor;
  public
    constructor Create(AOwnerItems: TLMDPropertyInspectorItems;
                       AParent: TLMDPropertyInspectorItem;
                       APageItem: TLMDPropertyInspectorPageItem);
    destructor Destroy; override;

    procedure Expand;
    procedure Collapse;
    function  CanEdit: Boolean;
    procedure Edit;
    function  DisplayRect(ACaption, AValue: Boolean): TRect;
    function  IndexOf(AItem: TLMDPropertyInspectorItem): Integer;
    function  Find(const APropName: TLMDString;
                   ATypeInfo: TLMDTypeInfo = nil): TLMDPropertyInspectorItem;
    function  ItemBy(const APropName: TLMDString;
                     ATypeInfo: TLMDTypeInfo = nil): TLMDPropertyInspectorItem;
    property  PropName: TLMDString read GetPropName;
    property  TypeInfo: TLMDTypeInfo read GetTypeInfo;
    property  PropInfo[AIndex: Integer]: ILMDProperty read GetPropInfo;
    property  Editor: TLMDPropEditor read GetEditor;
    property  Value: TLMDString read GetValue write SetValue;
    property  Owner: TLMDCustomPropertyInspector read GetOwner;
    property  Parent: TLMDPropertyInspectorItem read FParent;
    property  ParentCategory: TLMDPropertyInspectorCategory read GetParentCategory;
    property  Active: Boolean read GetActive write SetActive;
    property  Expanded: Boolean read GetExpanded;
    property  Level: Integer read GetLevel;
    property  Count: Integer read GetCount;
    property  Items[AIndex: Integer]: TLMDPropertyInspectorItem read GetItems; default;
  end;

  { *********************** TLMDPropertyInspectorItems *********************** }

  TLMDPropertyInspectorItems = class
  private
    FItems: TList;
    FOwner: TLMDCustomPropertyInspector;

    procedure InsertItem(AItem: TLMDPropertyInspectorItem);
    procedure RemoveItem(AItem: TLMDPropertyInspectorItem);
    procedure Clear;
    function  GetCount: Integer;
    function  GetItems(AIndex: Integer): TLMDPropertyInspectorItem;
  public
    constructor Create(AOwner: TLMDCustomPropertyInspector);
    destructor Destroy; override;

    function IndexOf(AItem: TLMDPropertyInspectorItem): Integer;
    function Find(const APropName: TLMDString;
                  ATypeInfo: TLMDTypeInfo = nil): TLMDPropertyInspectorItem;
    function ItemBy(const APropName: TLMDString;
                    ATypeInfo: TLMDTypeInfo = nil): TLMDPropertyInspectorItem;
    property Owner: TLMDCustomPropertyInspector read FOwner;
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TLMDPropertyInspectorItem read GetItems; default;
  end;

  { ******************** TLMDPropertyInspectorCategory *********************** }

  TLMDPropertyInspectorCategory = class
  private
    FOwnerCategories: TLMDPropertyInspectorCategories;
    FPageItem:        TLMDPropertyInspectorPageItem;

    function  GetCount: Integer;
    function  GetItems(AIndex: Integer): TLMDPropertyInspectorItem;
    function  GetExpanded: Boolean;
    function  GetName: TLMDString;
    function  GetOwner: TLMDCustomPropertyInspector;
    function  GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
  public
    constructor Create(AOwnerCategories: TLMDPropertyInspectorCategories;
                       APageItem: TLMDPropertyInspectorPageItem);
    destructor Destroy; override;

    procedure Expand;
    procedure Collapse;
    function  DisplayRect: TRect;
    function  IndexOf(AItem: TLMDPropertyInspectorItem): Integer;
    function  Find(const APropName: TLMDString;
                   ATypeInfo: TLMDTypeInfo = nil): TLMDPropertyInspectorItem;
    function  ItemBy(const APropName: TLMDString;
                     ATypeInfo: TLMDTypeInfo = nil): TLMDPropertyInspectorItem;
    property  Count: Integer read GetCount;
    property  Items[AIndex: Integer]: TLMDPropertyInspectorItem read GetItems; default;
    property  Name: TLMDString read GetName;
    property  Owner: TLMDCustomPropertyInspector read GetOwner;
    property  Expanded: Boolean read GetExpanded;
    property  Active: Boolean read GetActive write SetActive;
  end;

  { ******************* TLMDPropertyInspectorCategories ********************** }

  TLMDPropertyInspectorCategories = class
  private
    FItems: TList;
    FOwner: TLMDCustomPropertyInspector;

    procedure InsertItem(AItem: TLMDPropertyInspectorCategory);
    procedure RemoveItem(AItem: TLMDPropertyInspectorCategory);
    procedure Clear;
    function  GetCount: Integer;
    function  GetItems(AIndex: Integer): TLMDPropertyInspectorCategory;
  public
    constructor Create(AOwner: TLMDCustomPropertyInspector);
    destructor Destroy; override;

    function IndexOf(AItem: TLMDPropertyInspectorCategory): Integer;
    function Find(const AName: TLMDString): TLMDPropertyInspectorCategory;
    function ItemBy(const AName: TLMDString): TLMDPropertyInspectorCategory;
    property Owner: TLMDCustomPropertyInspector read FOwner;
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TLMDPropertyInspectorCategory read GetItems; default;
  end;

  { ******************** TLMDPropertyInspectorDefiner ************************ }

  TLMDPropertyInspectorDefiner = class
  private
    FOwner:  TLMDCustomPropertyInspector;
    FResult: TList;
  public
    constructor Create(AOwner: TLMDCustomPropertyInspector; AResult: TList);
    procedure   DefineProperty(const AName: TLMDString; AType: TLMDTypeInfo;
                               AIsReadable: Boolean = True;
                               AIsWritable: Boolean = True;
                               AUserData: TLMDDataTag = nil);
  end;

  { ********************* TLMDPropertyInspectorDynValue ********************** }

  TLMDPropertyInspectorDynValue = class
  private
    FType:      TLMDTypeInfo;
    FBuffer:    Pointer;
    FIsDefault: PBoolean;

    procedure CheckType(AKinds: TTypeKinds);
    function  GetIsDefault: Boolean;
    function  GetAsFloat: Extended;
    function  GetAsInt64: Int64;
    function  GetAsObject: TObject;
    function  GetAsOrd: Longint;
    function  GetAsStr: string;
    function  GetAsVariant: Variant;
    function  GetAsWideStr: WideString;
    procedure SetIsDefault(AValue: Boolean);
    procedure SetAsFloat(AValue: Extended);
    procedure SetAsInt64(AValue: Int64);
    procedure SetAsOrd(AValue: Longint);
    procedure SetAsStr(const AValue: string);
    procedure SetAsWideStr(const AValue: WideString);
    procedure SetAsVariant(const AValue: Variant);
    procedure SetAsObject(AValue: TObject);
  public
    constructor Create(AType: TLMDTypeInfo; ABuffer: Pointer;
                       AIsDefault: PBoolean);

    property IsDefault: Boolean read GetIsDefault write SetIsDefault;
    property AsFloat: Extended read GetAsFloat write SetAsFloat;
    property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
    property AsOrd: Longint read GetAsOrd write SetAsOrd;
    property AsStr: string read GetAsStr write SetAsStr;
    property AsWideStr: WideString read GetAsWideStr write SetAsWideStr;
    property AsVariant: Variant read GetAsVariant write SetAsVariant;
    property AsObject: TObject read GetAsObject write SetAsObject;
  end;

  { *************** Other definitions for property inspector ***************** }

  TLMDPropertyInspectorOnFilterProp = procedure(Sender: TObject;
    AInstance: TPersistent; APropInfo: ILMDProperty; AIsSubProp: Boolean;
    var AIncludeProp: Boolean) of object;

  TLMDPropertyInspectorOnGetCaptionColor = procedure(Sender: TObject;
    AItem: TLMDPropertyInspectorItem; var AColor: TColor) of object;

  TLMDPropertyInspectorOnGetEditorClass = procedure(Sender: TObject;
    AInstance: TPersistent; APropInfo: ILMDProperty;
    var AEditorClass: TLMDPropEditorClass) of object;

  TLMDPropertyInspectorOnCompare = procedure(Sender: TObject;  AInstance: TPersistent;
    APropInfo1, APropInfo2: ILMDProperty; var ACompare: Integer) of object;

  TLMDPropertyInspectorItemEvent = procedure(Sender: TObject;
    AItem: TLMDPropertyInspectorItem) of object;

  TLMDPropertyInspectorCategoryEvent = procedure(Sender: TObject;
    ACategory: TLMDPropertyInspectorCategory) of object;

  TLMDPropertyInspectorOnTranslateProp = procedure(Sender: TObject;
    const APropName: TLMDString; var ATranslatedName: TLMDString) of object;

  TLMDPropertyInspectorOnGetCompRef = procedure(Sender: TObject;
    const ACompName: TLMDString; var AComponent: TComponent) of object;

  TLMDPropertyInspectorOnGetCompRefName = procedure(Sender: TObject;
    AComponent: TComponent; var AName: TLMDString) of object;
    TLMDPropertyInspectorOnGetCompRefList = procedure(Sender: TObject;
    AClass: TComponentClass; AResult: TList) of object;

  TLMDPropertyInspectorOnGetUniqueCompName = procedure(Sender: TObject;
    const ABaseName: TLMDString; var AUniqueName: TLMDString) of object;

  TLMDPropertyInspectorOnGetEventValue = procedure(Sender: TObject;
    AInstance: TPersistent; APropInfo: ILMDProperty;
    var AResult: TLMDString) of object;

  TLMDPropertyInspectorOnSetEventValue = procedure(Sender: TObject;
    AInstance: TPersistent; APropInfo: ILMDProperty;
    const AValue: TLMDString) of object;

  TLMDPropertyInspectorOnGetDefaultEventHandlerName = procedure(Sender: TObject;
    AInstance: TPersistent; const AEventName: TLMDString;
    AEventTypeInfo: TLMDTypeInfo; var AResult: TLMDString) of object;

  TLMDPropertyInspectorOnGetExistingEventHandlers = procedure(Sender: TObject;
    AEventTypeInfo: TLMDTypeInfo; AResult: TLMDStrings) of object;

  TLMDPropertyInspectorOnEnsureEventHandlerSource = procedure(Sender: TObject;
    const AName, AOldName: TLMDString; AEventTypeInfo: TLMDTypeInfo;
    AShowSource: Boolean) of object;

  TLMDPropertyInspectorOnDynPropsDefine = procedure(Sender: TObject;
    AInstance: TPersistent; ADefiner: TLMDPropertyInspectorDefiner) of object;

  TLMDPropertyInspectorOnDynPropGetValue = procedure(Sender: TObject;
    AInstance: TPersistent; AProperty: ILMDProperty; AUserData: TLMDDataTag;
    AResult: TLMDPropertyInspectorDynValue) of object;

  TLMDPropertyInspectorOnDynPropSetValue = procedure(Sender: TObject;
    AInstance: TPersistent; AProperty: ILMDProperty; AUserData: TLMDDataTag;
    AValue: TLMDPropertyInspectorDynValue) of object;

  TLMDPropertyInspectorState       = set of (pisObjectsLocked, pisVolatilingSubProperties);
  TLMDPropertyInspectorPropKind    = (pkProperties, pkEvents, pkReadOnly);
  TLMDPropertyInspectorPropKinds   = set of TLMDPropertyInspectorPropKind;
  TLMDPropertyInspectorSortType    = (stCaption, stNone, stCustom);
  TLMDPropertyInspectorArrangeKind = (akByName, akByCategory);
  TLMDPropertyInspectorMenuOptions = set of (pimoAddDefaultItems);

  { ********************* TLMDCustomPropertyInspector ************************ }

  TLMDCustomPropertyInspector = class(TLMDCustomPropsPage, ILMDComponent)
  private
    FState:                        TLMDPropertyInspectorState;
    FItems:                        TLMDPropertyInspectorItems;
    FCategories:                   TLMDPropertyInspectorCategories;
    FObjectsCategories:            TLMDStrings;
    FEditors:                      array of TLMDPropertyInspectorEditorDescr;
    FAutoCompRefs:                 Boolean;
    FAutoEvents:                   Boolean;
    FOnChange:                     TNotifyEvent;
    FPropKinds:                    TLMDPropertyInspectorPropKinds;
    FOnFilterProp:                 TLMDPropertyInspectorOnFilterProp;
    FComponentRefColor:            TColor;
    FComponentRefPropColor:        TColor;
    FExpandComponentRefs:          Boolean;
    FReadOnly:                     Boolean;
    FDesigner:                     TLMDDataTag;
    FCategoryList:                 TObject;
    FTempMenu:                     TPopupMenu;
    FOnGetCaptionColor:            TLMDPropertyInspectorOnGetCaptionColor;
    FOnGetEditorClass:             TLMDPropertyInspectorOnGetEditorClass;
    FSortType:                     TLMDPropertyInspectorSortType;
    FOnCompare:                    TLMDPropertyInspectorOnCompare;
    FOnExpanded:                   TLMDPropertyInspectorItemEvent;
    FOnCollapsed:                  TLMDPropertyInspectorItemEvent;
    FOnCategoryExpanded:           TLMDPropertyInspectorCategoryEvent;
    FOnTranslateProp:              TLMDPropertyInspectorOnTranslateProp;
    FArrangeKind:                  TLMDPropertyInspectorArrangeKind;
    FHighlightNonDefaultValues:    Boolean;
    FExpandedCategories:           Boolean;
    FMenuOptions:                  TLMDPropertyInspectorMenuOptions;
    FOnGetCompRef:                 TLMDPropertyInspectorOnGetCompRef;
    FOnGetCompRefList:             TLMDPropertyInspectorOnGetCompRefList;
    FOnGetCompRefName:             TLMDPropertyInspectorOnGetCompRefName;
    FOnGetEventValue:              TLMDPropertyInspectorOnGetEventValue;
    FOnSetEventValue:              TLMDPropertyInspectorOnSetEventValue;
    FOnGetExistingEventHandlers:   TLMDPropertyInspectorOnGetExistingEventHandlers;
    FOnEnsureEventHandlerSource:   TLMDPropertyInspectorOnEnsureEventHandlerSource;
    FOnGetDefaultEventHandlerName: TLMDPropertyInspectorOnGetDefaultEventHandlerName;
    FOnGetUniqueCompName:          TLMDPropertyInspectorOnGetUniqueCompName;
    FOnDynPropsDefine:             TLMDPropertyInspectorOnDynPropsDefine;
    FOnDynPropGetValue:            TLMDPropertyInspectorOnDynPropGetValue;
    FOnDynPropSetValue:            TLMDPropertyInspectorOnDynPropSetValue;

    procedure AddDefaultMenuItems(AMenu: TPopupMenu);
    procedure ClearTempMenuItems(AMenu: TPopupMenu);
    procedure RecreateItems(ARestoreState: Boolean = True);
    procedure CreateItemOrCategory(APageItem: TLMDPropertyInspectorPageItem);
    function  PageItems: TLMDPropsPageItems;
    function  ActivePageItem: TLMDPropsPageItem;
    procedure PageItemVolatileCollapses(AItem: TLMDPropertyInspectorPageItem);
    procedure EditorChange(AEditor: TLMDPropEditor);
    procedure RegisterStandatdEditors;
    procedure RegisterStandardCategories;
    function  GetTypeKindEditorClass(ATypeInfo: TLMDTypeInfo): TLMDPropEditorClass;
    function  IndexOfEditor(ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
                            const APropName: TLMDString;
                            AEditorClass: TLMDPropEditorClass): Integer;
    procedure DoRegisterPropCategory(const ACategoryName: TLMDString;
                                     ATypeInfo: TLMDTypeInfo;
                                     AObjectClass: TClass; const APropName: TLMDString);
    procedure DoUnregisterPropCategory(const ACategoryName: TLMDString;
                                       ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
                                       const APropName: TLMDString);
    procedure CheckObjectsLock;
    function  GetActiveItem: TLMDPropertyInspectorItem;
    function  GetActiveCategory: TLMDPropertyInspectorCategory;
    procedure SetPropKinds(const Value: TLMDPropertyInspectorPropKinds);
    procedure SetComponentRefColor(const Value: TColor);
    procedure SetComponentRefPropColor(const Value: TColor);
    procedure SetExpandComponentRefs(const Value: Boolean);
    procedure SetReadOnly(const Value: Boolean);
    procedure SetDesigner(const Value: TLMDDataTag);
    procedure SetSortType(const Value: TLMDPropertyInspectorSortType);
    procedure SetArrangeKind(const Value: TLMDPropertyInspectorArrangeKind);
    procedure SetHighlightNonDefaultValues(const Value: Boolean);
    procedure SetExpandedCategories(const Value: Boolean);
  protected
    function  CreateItem(AParent: TLMDPropsPageItem): TLMDPropsPageItem; override;
    procedure ItemDestroying(AItem: TLMDPropsPageItem); override;
    procedure ItemExpanded(AItem: TLMDPropsPageItem); override;
    procedure ItemCollapsed(AItem: TLMDPropsPageItem); override;
    function  GetItemCaptionColor(AItem: TLMDPropsPageItem): TColor; override;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    procedure GetObjects(AResult: TList); virtual; abstract;
    procedure SetObjects(AObjects: TList); virtual; abstract;
    function  DetectEditorWindowManager(AEditedObject: TPersistent): TLMDEditorWindowManager; virtual;
    procedure ObjectsChanged; virtual;
    procedure DoDynPropsDefine(AInstance: TPersistent; ADefiner: TLMDPropertyInspectorDefiner); virtual;
    procedure DoDynPropGetValue(AInstance: TPersistent; AProperty: ILMDProperty;
                                AUserData: TLMDDataTag;
                                AResult: TLMDPropertyInspectorDynValue); virtual;
    procedure DoDynPropSetValue(AInstance: TPersistent; AProperty: ILMDProperty;
                                AUserData: TLMDDataTag;
                                AValue: TLMDPropertyInspectorDynValue); virtual;
    procedure DoGetCompRef(AEditor: TLMDPropEditor; const ACompName: TLMDString;
                           var AComponent: TComponent); virtual;
    procedure DoGetCompRefName(AEditor: TLMDPropEditor; AComponent: TComponent;
                               var AName: TLMDString); virtual;
    procedure DoGetCompRefList(AEditor: TLMDPropEditor; AClass: TComponentClass;
                               AResult: TList); virtual;
    procedure DoGetEventValue(AEditor: TLMDPropEditor; AInstance: TPersistent;
                              APropInfo: ILMDProperty; var AResult: TLMDString); virtual;
    procedure DoSetEventValue(AEditor: TLMDPropEditor; AInstance: TPersistent;
                              APropInfo: ILMDProperty; const AValue: TLMDString); virtual;
    procedure DoGetDefaultEventHandlerName(AEditor: TLMDPropEditor; AInstance: TPersistent;
                                           const AEventName: TLMDString; AEventTypeInfo: TLMDTypeInfo;
                                           var AResult: TLMDString); virtual;
    procedure DoGetExistingEventHandlers(AEditor: TLMDPropEditor; AEventTypeInfo: TLMDTypeInfo;
                                         AResult: TLMDStrings); virtual;
    procedure DoEnsureEventHandlerSource(AEditor: TLMDPropEditor; const AName, AOldName: TLMDString;
                                         AEventTypeInfo: TLMDTypeInfo; AShowSource: Boolean); virtual;
    procedure DoGetUniqueCompName(AComponent: TComponent; var AUniqueName: TLMDString); virtual;
    procedure DoChange(AEditor: TLMDPropEditor); virtual;
    procedure GetEditorClass(AIsSubProp: Boolean; AInstance: TPersistent;
                             APropInfo: ILMDProperty;
                             var AEditorClass: TLMDPropEditorClass); virtual;
    procedure FilterProp(AInstance: TPersistent; APropInfo: ILMDProperty;
                         AIsSubProp: Boolean; var AIncludeProp: Boolean); virtual;
    function  TranslateProp(const APropName: TLMDString): TLMDString;
    procedure Expanded(AItem: TLMDPropertyInspectorItem); virtual;
    procedure Collapsed(AItem: TLMDPropertyInspectorItem); virtual;
    procedure CategoryExpanded(ACategory: TLMDPropertyInspectorCategory); virtual;
    procedure CategoryCollapsed(ACategory: TLMDPropertyInspectorCategory); virtual;
    procedure GetCaptionColor(AItem: TLMDPropertyInspectorItem; var AColor: TColor); virtual;
    procedure CustomCompare(AInstance: TPersistent; APropInfo1,
                            APropInfo2: ILMDProperty; var ACompare: Integer); virtual;
    property  State: TLMDPropertyInspectorState read FState;
    property  ActiveItem: TLMDPropertyInspectorItem read GetActiveItem;
    property  ActiveCategory: TLMDPropertyInspectorCategory read GetActiveCategory;
    property  Items: TLMDPropertyInspectorItems read FItems;
    property  Categories: TLMDPropertyInspectorCategories read FCategories;
    property  ObjectsCategories: TLMDStrings read FObjectsCategories;
    property  Designer: TLMDDataTag read FDesigner write SetDesigner;
    property  PropKinds: TLMDPropertyInspectorPropKinds read FPropKinds write SetPropKinds default [pkProperties];
    property  ComponentRefColor: TColor read FComponentRefColor write SetComponentRefColor default clMaroon;
    property  ComponentRefPropColor: TColor read FComponentRefPropColor write SetComponentRefPropColor default clGreen;
    property  ExpandComponentRefs: Boolean read FExpandComponentRefs write SetExpandComponentRefs default True;
    property  ReadOnly: Boolean read FReadOnly write SetReadOnly default False;
    property  SortType: TLMDPropertyInspectorSortType read FSortType write SetSortType default stCaption;
    property  ArrangeKind: TLMDPropertyInspectorArrangeKind read FArrangeKind write SetArrangeKind default akByName;
    property  HighlightNonDefaultValues: Boolean read FHighlightNonDefaultValues write SetHighlightNonDefaultValues default True;
    property  ExpandedCategories: Boolean read FExpandedCategories write SetExpandedCategories default False;
    property  MenuOptions: TLMDPropertyInspectorMenuOptions read FMenuOptions write FMenuOptions default [];
    property  OnFilterProp: TLMDPropertyInspectorOnFilterProp read FOnFilterProp write FOnFilterProp;
    property  OnTranslateProp: TLMDPropertyInspectorOnTranslateProp read FOnTranslateProp write FOnTranslateProp;
    property  OnChange: TNotifyEvent read FOnChange write FOnChange;
    property  OnGetCaptionColor: TLMDPropertyInspectorOnGetCaptionColor read FOnGetCaptionColor write FOnGetCaptionColor;
    property  OnGetEditorClass: TLMDPropertyInspectorOnGetEditorClass read FOnGetEditorClass write FOnGetEditorClass;
    property  OnCompare: TLMDPropertyInspectorOnCompare read FOnCompare write FOnCompare;
    property  OnExpanded: TLMDPropertyInspectorItemEvent read FOnExpanded write FOnExpanded;
    property  OnCollapsed: TLMDPropertyInspectorItemEvent read FOnCollapsed write FOnCollapsed;
    property  OnCategoryExpanded: TLMDPropertyInspectorCategoryEvent read FOnCategoryExpanded write FOnCategoryExpanded;
    property  OnCategoryCollapsed: TLMDPropertyInspectorCategoryEvent read FOnCategoryExpanded write FOnCategoryExpanded;
    property  OnGetCompRef: TLMDPropertyInspectorOnGetCompRef read FOnGetCompRef write FOnGetCompRef;
    property  OnGetCompRefName: TLMDPropertyInspectorOnGetCompRefName read FOnGetCompRefName write FOnGetCompRefName;
    property  OnGetCompRefList: TLMDPropertyInspectorOnGetCompRefList read FOnGetCompRefList write FOnGetCompRefList;
    property  OnGetEventValue: TLMDPropertyInspectorOnGetEventValue read FOnGetEventValue write FOnGetEventValue;
    property  OnSetEventValue: TLMDPropertyInspectorOnSetEventValue read FOnSetEventValue write FOnSetEventValue;
    property  OnGetDefaultEventHandlerName: TLMDPropertyInspectorOnGetDefaultEventHandlerName read FOnGetDefaultEventHandlerName write FOnGetDefaultEventHandlerName;
    property  OnGetExistingEventHandlers: TLMDPropertyInspectorOnGetExistingEventHandlers read FOnGetExistingEventHandlers write FOnGetExistingEventHandlers;
    property  OnEnsureEventHandlerSource: TLMDPropertyInspectorOnEnsureEventHandlerSource read FOnEnsureEventHandlerSource write FOnEnsureEventHandlerSource;
    property  OnGetUniqueCompName: TLMDPropertyInspectorOnGetUniqueCompName read FOnGetUniqueCompName write FOnGetUniqueCompName;
    property  OnDynPropsDefine: TLMDPropertyInspectorOnDynPropsDefine read FOnDynPropsDefine write FOnDynPropsDefine;
    property  OnDynPropGetValue: TLMDPropertyInspectorOnDynPropGetValue read FOnDynPropGetValue write FOnDynPropGetValue;
    property  OnDynPropSetValue: TLMDPropertyInspectorOnDynPropSetValue read FOnDynPropSetValue write FOnDynPropSetValue;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;    

    procedure UpdateContent;
    procedure UpdateItems;

    procedure RegisterPropEditor(ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
                                 const APropName: TLMDString;
                                 AEditorClass: TLMDPropEditorClass);
    procedure UnregisterPropEditor(ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
                                   const APropName: TLMDString;
                                   AEditorClass: TLMDPropEditorClass);

    procedure RegisterPropCategory(const ACategoryName: TLMDString;
                                   const APropName: TLMDString); overload;
    procedure UnregisterPropCategory(const ACategoryName: TLMDString;
                                     const APropName: TLMDString); overload;
    procedure RegisterPropCategory(const ACategoryName: TLMDString;
                                   AObjectClass: TClass;
                                   const APropName: TLMDString); overload;
    procedure UnregisterPropCategory(const ACategoryName: TLMDString;
                                     AObjectClass: TClass;
                                     const APropName: TLMDString); overload;
    procedure RegisterPropCategory(const ACategoryName: TLMDString;
                                   ATypeInfo: TLMDTypeInfo;
                                   const APropName: TLMDString); overload;
    procedure UnregisterPropCategory(const ACategoryName: TLMDString;
                                     ATypeInfo: TLMDTypeInfo;
                                     const APropName: TLMDString); overload;
    procedure RegisterPropCategory(const ACategoryName: TLMDString;
                                   ATypeInfo: TLMDTypeInfo); overload;
    procedure UnregisterPropCategory(const ACategoryName: TLMDString;
                                     ATypeInfo: TLMDTypeInfo); overload;
    function  HideCategory(const ACategoryName: TLMDString): Boolean;
    function  ShowCategory(const ACategoryName: TLMDString): Boolean;
    procedure ShowAllCategories;
    procedure HideAllCategories;
    procedure ExpandAllCategories;
    procedure CollapseAllCategories;
    function  IsRegisteredCategoryHidden(const ACategoryName: TLMDString): Boolean;

    function  ItemAtPos(AX, AY: Integer): TLMDPropertyInspectorItem;
    function  CategoryAtPos(AX, AY: Integer): TLMDPropertyInspectorCategory;
  end;

  { ************************ TLMDSimplePropInspector ************************* }

  TLMDSimplePropInspector = class;

  TLMDSimplePropInspObjects = class
  private
    FPropInsp:    TLMDSimplePropInspector;
    FItems:       TList;
    FUpdateCount: Integer;
    FChanged:     Boolean;

    function  GetCount: Integer;
    function  GetItem(AIndex: Integer): TPersistent;
    procedure Changed;
  public
    constructor Create(APropInsp: TLMDSimplePropInspector);
    destructor Destroy; override;

    procedure Clear;
    procedure Add(AItem: TPersistent);
    procedure Delete(AIndex: Integer);
    procedure Remove(AItem: TPersistent);
    function  IndexOf(AItem: TPersistent): Integer;
    procedure SetItems(AItems: TList);
    procedure GetItems(AResult: TList);
    procedure SetOne(AItem: TPersistent);
    procedure BeginUpdate;
    procedure EndUpdate;

    property  Count: Integer read GetCount;
    property  Item[AIndex: Integer]: TPersistent read GetItem; default;
  end;

  TLMDSimplePropInspector = class(TLMDCustomPropertyInspector, ILMDComponent)
  private
    FAbout:         TLMDAboutVar;
    FObjects:       TLMDSimplePropInspObjects;
    FEditorUtils:   TLMDEditorUtils;
    FEditorWindows: TLMDEditorWindowManager;

    procedure ReadDeprecatedEventProp(Reader: TReader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    function  DetectEditorWindowManager(AEditedObject: TPersistent): TLMDEditorWindowManager; override;
    procedure GetObjects(AResult: TList); override;
    procedure SetObjects(AObjects: TList); override;
    procedure DoChange(AEditor: TLMDPropEditor); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property Objects: TLMDSimplePropInspObjects read FObjects;
    property EditorWindows: TLMDEditorWindowManager read FEditorWindows;
    property State;
    property ActiveItem;
    property ActiveCategory;
    property Designer;
    property Items;
    property Categories;
    property ObjectsCategories;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property PropKinds;
    property ComponentRefColor;
    property ComponentRefPropColor;
    property ExpandComponentRefs;
    property MenuOptions;
    property ReadOnly;
    property SortType;
    property ArrangeKind;
    property ToolTips;
    property GridColor;
    property GridVisible;
    property GutterVisible;
    property GutterColor;
    property GutterLineColor;
    property CursorVisible;
    property SelectionStyle;
    property FlatSelectionBackgroundColor;
    property FlatSelectionColor;
    property FlatSplitterColor;
    property CategoryBackgroundColor;
    property CategoryFont;
    property DefaultPropName;
    property Splitter;
    property ValuesColor;
    property HighlightNonDefaultValues;
    property ExpandedCategories;
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;
    property OnExpanded;
    property OnCollapsed;
    property OnCategoryExpanded;
    property OnCategoryCollapsed;
    property OnFilterProp;
    property OnTranslateProp;
    property OnChange;
    property OnGetCaptionColor;
    property OnGetEditorClass;
    property OnCompare;
    property OnDynPropsDefine;
    property OnDynPropGetValue;
    property OnDynPropSetValue;
    property OnGetCompRef;
    property OnGetCompRefName;
    property OnGetCompRefList;
    property OnGetEventValue;
    property OnSetEventValue;
    property OnGetDefaultEventHandlerName;
    property OnGetExistingEventHandlers;
    property OnEnsureEventHandlerSource;
    property OnGetUniqueCompName;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  LMDStrings, LMDProcs, LMDInsPropEditors, Math;

type
  TCategory       = class;
  TPropInspAccess = class(TLMDCustomPropertyInspector);

  TPropInspFindItemData = record
    PropName: TLMDString;
    TypaInfo: TLMDTypeInfo;
  end;
  PPropInspFindItemData = ^TPropInspFindItemData;

  { *************************** TPropInspMenuItem **************************** }

  TPropInspMenuItemAction = (miaNone, miaArrangeByCat, miaArrangeByName,
                             miaViewAll, miaViewNone, miaToggleCats,
                             miaCategory);

  TPropInspMenuItem = class(TMenuItem)
  protected
    procedure UpdateState;
  public
    PropInsp: TLMDCustomPropertyInspector;
    Action:   TPropInspMenuItemAction;
    Category: TCategory;

    procedure Click; override;
  end;

  { ***************************** TCategoryFilter **************************** }

  TCategoryFilter = class
  private
    FMask:        TMask;
    FObjectClass: TClass;
    FTypeInfo:    TLMDTypeInfo;
    FPropName:    TLMDString;
  public
    constructor Create(ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
                       const APropName: TLMDString);
    destructor Destroy; override;

    property ObjectClass: TClass read FObjectClass;
    function Match(ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
                   const APropName: TLMDString): Boolean;
    property TypeInfo: TLMDTypeInfo read FTypeInfo;
    property PropName: TLMDString read FPropName;
  end;

  { ******************************* TCategory ******************************** }

  TCategory = class
  private
    FItems:       TList;
    FName:        TLMDString;
    FVisible:     Boolean;
    FWasExpanded: Boolean;

    function GetItems(Index: Integer): TCategoryFilter;
    function GetCount: Integer;
  public
    constructor Create(const AName: TLMDString; AExpanded: Boolean);
    destructor Destroy; override;

    procedure Clear;
    procedure Add(AItem: TCategoryFilter);
    procedure Delete(AIndex: Integer);
    function  IndexOf(ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
                      const APropName: TLMDString): Integer;
    function  Match(ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
                    const APropName: TLMDString): Boolean;
    property  Name: TLMDString read FName;
    property  Visible: Boolean read FVisible write FVisible;
    property  WasExpanded: Boolean read FWasExpanded write FWasExpanded;
    property  Count: Integer read GetCount;
    property  Items[Index: Integer]: TCategoryFilter read GetItems; default;
  end;

  { ****************************** TCategoryList ***************************** }

  TCategoryList = class
  private
    FItems:              TList;
    FMiscCategory:       TCategory;
    FExpandedCategories: Boolean;

    function GetItems(Index: Integer): TCategory;
    function GetCount: Integer;
    function GetMiscCategory: TCategory;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure Add(AItem: TCategory);
    procedure Delete(AIndex: Integer);
    function  Find(const ACategoryName: TLMDString): TCategory;
    function  IndexOf(const ACategoryName: TLMDString): Integer;
    function  FindCategory(ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
                           const APropName: TLMDString): TCategory;
    property  MiscCategory: TCategory read GetMiscCategory;
    property  ExpandedCategories: Boolean read FExpandedCategories write FExpandedCategories;
    property  Count: Integer read GetCount;
    property  Items[Index: Integer]: TCategory read GetItems; default;
  end;
                            
  { ***************************** TRTTIPropWrapper *************************** }

  TRTTIPropWrapper = class(ILMDProperty)
  private
    FOrigin: TLMDPropInfo;
  public
    constructor Create(AOrigin: TLMDPropInfo);
    destructor Destroy; override;

    function  Name: TLMDString; override;
    function  PropType: TLMDTypeInfo; override;
    function  RTTIPropInfo: TLMDPropInfo; override;
    function  IsReadable: Boolean; override;
    function  IsWritable: Boolean; override;
    function  IsDefaultValue(Instance: TPersistent): Boolean; override;
    function  GetFloatValue(Instance: TPersistent): Extended; override;
    function  GetInt64Value(Instance: TPersistent): Int64; override;
    function  GetOrdValue(Instance: TPersistent): Longint; override;
    function  GetStrValue(Instance: TPersistent): string; override;
    function  GetWideStrValue(Instance: TPersistent): WideString; override;
    function  GetVariantValue(Instance: TPersistent): Variant; override;
    function  GetObjectValue(Instance: TPersistent): TObject; override;
    procedure SetFloatValue(Instance: TPersistent; AValue: Extended); override;
    procedure SetInt64Value(Instance: TPersistent; AValue: Int64); override;
    procedure SetOrdValue(Instance: TPersistent; AValue: Longint); override;
    procedure SetStrValue(Instance: TPersistent; const AValue: string); override;
    procedure SetWideStrValue(Instance: TPersistent; const AValue: WideString); override;
    procedure SetVariantValue(Instance: TPersistent; const AValue: Variant); override;
    procedure SetObjectValue(Instance: TPersistent; AValue: TObject); override;
  end;

  TRTTIPropWrapperTraits = class(TLMDHashTableTraits)
  public
    class function MakeHashI(AItem: TObject): Integer; override;
    class function MakeHashK(const AKey): Integer; override;
    class function Compare(const AKey; AItem: TObject): Boolean; override;
  end;

  { ****************************** TDynPropWrapper *************************** }

  TDynPropWrapper = class(ILMDProperty)
  private
    FPropInsp:   TLMDCustomPropertyInspector;
    FName:       TLMDString;
    FType:       TLMDTypeInfo;
    FIsReadable: Boolean;
    FIsWritable: Boolean;
    FUserData:   TLMDDataTag;

    procedure GetValue(Instance: TPersistent; var AResult);
    procedure SetValue(Instance: TPersistent; const AValue);
  public
    constructor Create(APropInsp: TLMDCustomPropertyInspector;
                       const AName: TLMDString; AType: TLMDTypeInfo; AIsReadable,
                       AIsWritable: Boolean; AUserData: TLMDDataTag);

    function  Name: TLMDString; override;
    function  PropType: TLMDTypeInfo; override;
    function  IsReadable: Boolean; override;
    function  IsWritable: Boolean; override;
    function  IsDefaultValue(Instance: TPersistent): Boolean; override;
    function  GetFloatValue(Instance: TPersistent): Extended; override;
    function  GetInt64Value(Instance: TPersistent): Int64; override;
    function  GetOrdValue(Instance: TPersistent): Longint; override;
    function  GetStrValue(Instance: TPersistent): string; override;
    function  GetWideStrValue(Instance: TPersistent): WideString; override;
    function  GetVariantValue(Instance: TPersistent): Variant; override;
    function  GetObjectValue(Instance: TPersistent): TObject; override;
    procedure SetFloatValue(Instance: TPersistent; AValue: Extended); override;
    procedure SetInt64Value(Instance: TPersistent; AValue: Int64); override;
    procedure SetOrdValue(Instance: TPersistent; AValue: Longint); override;
    procedure SetStrValue(Instance: TPersistent; const AValue: string); override;
    procedure SetWideStrValue(Instance: TPersistent; const AValue: WideString); override;
    procedure SetVariantValue(Instance: TPersistent; const AValue: Variant); override;
    procedure SetObjectValue(Instance: TPersistent; AValue: TObject); override;
  end;

  { **************************** TPropListHandler **************************** }

  TObjProps = class
  public
    Instance: TPersistent;
    Props:    array of TLMDPropEditorPropListItem;
  end;

  TComparePropsProc = procedure(AInstance: TPersistent;
                                APropInfo1, APropInfo2: ILMDProperty;
                                var ACompare: Integer) of object;

  TComparePropsRec = record
    Item:        TObjProps;
    CompareProc: TComparePropsProc;
  end;
  PComparePropsRec = ^TComparePropsRec;

  TPropListHandler = class
  private
    FPropInsp:        TLMDCustomPropertyInspector;
    FParentObjEditor: TLMDPropEditor;

    procedure CaptionCompareProc(AInstance: TPersistent; APropInfo1,
                                 APropInfo2: ILMDProperty;
                                 var ACompare: Integer); 
    function  GetCompareProc: TComparePropsProc;
    procedure SortProps(AItem: TObjProps; ACompareProc: TComparePropsProc);
    procedure GetDynamicProps(AInstance: TPersistent; AItem: TObjProps);
    procedure GetRTTIProps(AInstance: TPersistent; AItem: TObjProps);
    function  GetRTTIPropWrapper(AOrigin: TLMDPropInfo): TRTTIPropWrapper;
    function  CreatePropLists(AInstances: TList): TList; // List of TObjProps.
    procedure FreePropLists(ALists: TList);
    procedure Intersect(ALists: TList);
    function  IsCompatible(const APropA, APropB: TLMDPropEditorPropListItem): Boolean;
    procedure CreateEditors(ALists: TList; AOnlyNestable, AIsSubProp: Boolean;
                            AResult: TList);
  public
    constructor     Create(APropInsp: TLMDCustomPropertyInspector;
                           AParentObjEditor: TLMDPropEditor);
    class procedure GetPropEditors(APropInsp: TLMDCustomPropertyInspector;
                                   AParentObjEditor: TLMDPropEditor;
                                   AInstances: TList; AOnlyNestable,
                                   AIsSubProp: Boolean; AResult: TList);
  end;

  function  PropListHandlerQSCompareProxy(AItemIndex1, AItemIndex2: Integer;
                                          AData: TLMDDataTag): Integer; forward;
  procedure PropListHandlerQSExchangeProxy(AItemIndex1, AItemIndex2: Integer;
                                           AData: TLMDDataTag); forward;

  { ********************** TSimplePropInspEditorUtils ************************ }

type
  TSimplePropInspEditorUtils = class(TLMDEditorUtils)
  private
    FPropInsp: TLMDCustomPropertyInspector;
  public
    constructor Create(APropInsp: TLMDCustomPropertyInspector);

    procedure GetObjects(AResult: TList); override;
    procedure SetObjects(AObjects: TList); override;
    procedure MarkModified; override;
    function  GetUniqueCompName(AComp: TComponent): TLMDString; override;
  end;

{------------------------------------------------------------------------------}

const
  SMiscCategoryName     = 'Miscellaneous';
  SDragAndDropCategory  = 'Drag, Drop and Docking';
  SHelpAndHintsCategory = 'Help and Hints';
  SLayoutCategory       = 'Layout';
  SLinkageCategory      = 'Linkage';
  SLocaleCategory       = 'Locale';
  SInputCategory        = 'Input';
  SVisualCategory       = 'Visual';

var
  RTTIPropWrapperMap: TLMDHashTable; // Key -  TLMDPropInfo,
                                     // Item - TRTTIPropWrapper.

{****************************** TPropInspMenuItem *****************************}
{ ---------------------------------------------------------------------------- }
procedure TPropInspMenuItem.Click;
var
  i:       Integer;
  catlist: TCategoryList;
begin
  catlist := TCategoryList(PropInsp.FCategoryList);

  PropInsp.BeginUpdate;
  try
    case Action of
      miaNone:            ; // Do nothing.
      miaArrangeByCat:    PropInsp.ArrangeKind := akByCategory;
      miaArrangeByName:   PropInsp.ArrangeKind := akByName;
      miaViewAll:         for i := 0 to catlist.Count - 1 do
                            catlist[i].Visible := True;
      miaViewNone:        for i := 0 to catlist.Count - 1 do
                            catlist[i].Visible := False;
      miaToggleCats:      for i := 0 to catlist.Count - 1 do
                            catlist[i].Visible := not catlist[i].Visible;
      miaCategory:        Category.Visible := not Category.Visible;
    else
      Assert(False);
    end;
  finally
    PropInsp.EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TPropInspMenuItem.UpdateState;
begin
  case Action of
    miaNone:            ; // Do nothing.
    miaArrangeByCat:    Checked := (PropInsp.ArrangeKind = akByCategory);
    miaArrangeByName:   Checked := (PropInsp.ArrangeKind = akByName);
    miaViewAll:         ; // Do nothing.
    miaViewNone:        ; // Do nothing.
    miaToggleCats:      ; // Do nothing.
    miaCategory:        Checked := Category.Visible;
  else
    Assert(False);
  end;
end;

{ ************************** class TCategoryFilter *************************** }
{ --------------------------------- public ----------------------------------- }
constructor TCategoryFilter.Create(
  ATypeInfo: TLMDTypeInfo; AObjectClass: TClass; const APropName: TLMDString);
begin
  inherited Create;
  FPropName := APropName;
  if APropName <> '' then
    FMask := TMask.Create(APropName);
  FObjectClass := AObjectClass;
  FTypeInfo := ATypeInfo;
end;

{ ---------------------------------------------------------------------------- }
destructor TCategoryFilter.Destroy;
begin
  FMask.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TCategoryFilter.Match(ATypeInfo: TLMDTypeInfo;
  AObjectClass: TClass; const APropName: TLMDString): Boolean;

  function _MatchName: Boolean;
  begin
    Result := (FMask = nil) or FMask.Matches(APropName);
  end;

  function _MatchClass: Boolean;
  begin
    Result := (AObjectClass <> nil) and
      ((FObjectClass = AObjectClass) or
      (AObjectClass.InheritsFrom(FObjectClass)));
  end;

  function _MatchType: Boolean;
  begin
    Result := (ATypeInfo <> nil) and
              ((FTypeInfo = ATypeInfo) or
               ((FTypeInfo.Kind = tkClass) and
                (ATypeInfo.Kind = tkClass) and
                GetTypeData(ATypeInfo).ClassType.InheritsFrom(
                                          GetTypeData(FTypeInfo).ClassType)));
  end;

begin
  if FObjectClass <> nil then
    if FTypeInfo <> nil then
      Result := _MatchClass and _MatchType and _MatchName
    else
      Result := _MatchClass and _MatchName
  else
    if FTypeInfo <> nil then
      Result := _MatchType and _MatchName
    else
      Result := _MatchName;
end;

{ ****************************** class TCategory ***************************** }
{ -------------------------------- private ----------------------------------- }
function TCategory.GetItems(
  Index: Integer): TCategoryFilter;
begin
  Result := TCategoryFilter(FItems[Index]);
end;

{ ---------------------------------------------------------------------------- }
function TCategory.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{ --------------------------------- public ----------------------------------- }
constructor TCategory.Create(const AName: TLMDString; AExpanded: Boolean);
begin
  inherited Create;
  FItems       := TList.Create;
  FName        := AName;
  FVisible     := True;
  FWasExpanded := AExpanded;
end;

{ ---------------------------------------------------------------------------- }
destructor TCategory.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TCategory.Clear;
begin
  while Count > 0 do
    Delete(0);
end;

{ ---------------------------------------------------------------------------- }
procedure TCategory.Add(AItem: TCategoryFilter);
begin
  if IndexOf(AItem.TypeInfo, AItem.ObjectClass, AItem.PropName) = -1 then
    FItems.Add(AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TCategory.Delete(AIndex: Integer);
var
  LItem: TCategoryFilter;
begin
  LItem := Items[AIndex];
  FItems.Delete(AIndex);
  LItem.Free;
end;

{ ---------------------------------------------------------------------------- }
function TCategory.IndexOf(ATypeInfo: TLMDTypeInfo;
  AObjectClass: TClass; const APropName: TLMDString): Integer;
var
  LI: Integer;
begin
  Result := -1;
  for LI := 0 to Count - 1 do
    if (Items[LI].TypeInfo = ATypeInfo) and
       (Items[LI].ObjectClass = AObjectClass) and
       LMDSameText(Items[LI].PropName, APropName) then
    begin
      Result := LI;
      break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TCategory.Match(ATypeInfo: TLMDTypeInfo;
  AObjectClass: TClass; const APropName: TLMDString): Boolean;
var
  LI:        Integer;
  LPropInfo: TLMDPropInfo;
begin
  if (ATypeInfo = nil) and
     (AObjectClass <> nil) then
  begin
    LPropInfo := GetPropInfo(TLMDTypeInfo(AObjectClass.ClassInfo), APropName);
    if LPropInfo <> nil then
      ATypeInfo := LPropInfo.PropType^;
  end;

  Result := False;
  for LI := 0 to Count - 1 do
    if Items[LI].Match(ATypeInfo, AObjectClass, APropName) then
    begin
      Result := True;
      Break;
    end;
end;

{ *************************** class TCategoryList **************************** }
{ -------------------------------- private ----------------------------------- }
function TCategoryList.GetItems(
  Index: Integer): TCategory;
begin
  Result := TCategory(FItems[Index]);
end;

{ ---------------------------------------------------------------------------- }
function TCategoryList.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{ ---------------------------------------------------------------------------- }
function TCategoryList.GetMiscCategory: TCategory;
begin
  if FMiscCategory = nil then
  begin
    FMiscCategory := Find(SMiscCategoryName);
    if FMiscCategory = nil then
    begin
      FMiscCategory := TCategory.Create(SMiscCategoryName,
                                           FExpandedCategories);
      Add(FMiscCategory);
    end;
  end;
  Result := FMiscCategory;
end;

{ ------------------------------ public -------------------------------------- }
constructor TCategoryList.Create;
begin
  inherited Create;
  FItems := TList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TCategoryList.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TCategoryList.Clear;
begin
  while Count > 0 do
    Delete(0);
end;

{ ---------------------------------------------------------------------------- }
procedure TCategoryList.Add(
  AItem: TCategory);
begin
  if IndexOf(AItem.Name) = -1 then
    FItems.Add(AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TCategoryList.Delete(AIndex: Integer);
var
  LItem: TCategory;
begin
  LItem := Items[AIndex];
  FItems.Delete(AIndex);
  LItem.Free;
end;

{ ---------------------------------------------------------------------------- }
function TCategoryList.Find(
  const ACategoryName: TLMDString): TCategory;
var
  LI: Integer;
begin
  LI := IndexOf(ACategoryName);
  if LI <> -1 then
    Result := Items[LI]
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TCategoryList.IndexOf(
  const ACategoryName: TLMDString): Integer;
var
  LI: Integer;
begin
  Result := -1;
  for LI := 0 to Count - 1 do
    if LMDSameText(ACategoryName, Items[LI].Name) then
    begin
      Result := LI;
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TCategoryList.FindCategory(ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
  const APropName: TLMDString): TCategory;
var
  LI: Integer;
  LMiscCat: TCategory;
begin
  Result := nil;
  LMiscCat := MiscCategory; // Force misc category creation.
  for LI := 0 to Count - 1 do
    if (Items[LI] <> LMiscCat) and
      (Items[LI].Match(ATypeInfo, AObjectClass, APropName)) then
    begin
      Result := Items[LI];
      Break;
    end;

  if Result = nil then
    Result := LMiscCat;
end;

{ ************************* class TLMDPropEditor ***************************** }
{ ------------------------------ private ------------------------------------- }
function TLMDPropEditor.GetPropTypeInfo: TLMDTypeInfo;
begin
  Result := FPropList[0].PropInfo.PropType;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.DoGetValue: TLMDString;
begin
  if AllEqual then
    Result := GetValue
  else
    Result := '';
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDPropEditor.SetPropEntry(AIndex: Integer; AInstance: TPersistent;
  APropInfo: ILMDProperty);
begin
  with FPropList[AIndex] do
    begin                      
      Instance := AInstance;
      PropInfo := APropInfo;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.Change;
begin
  FPropInsp.EditorChange(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetValue: TLMDString;
begin
  Result := '(Unknown)';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.SetValue(const Value: TLMDString);
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetAttrs: TLMDPropAttrs;
begin
  Result := [praMultiSelect];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.GetValues(AValues: TLMDStrings);
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.GetSubProps(AResult: TList);
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetPropName: TLMDString;
begin
  Result := {$IFDEF LMDCOMP12}TLMDString{$ENDIF}(FPropList[0].PropInfo.Name);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.AllEqual: Boolean;
begin
  Result := FPropCount = 1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.Edit;
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.ValuesMeasureHeight(const AValue: TLMDString;
  ACanvas: TCanvas; var AHeight: Integer);
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.ValuesMeasureWidth(const AValue: TLMDString;
  ACanvas: TCanvas; var AWidth: Integer);
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.ValuesDrawValue(const AValue: TLMDString;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  // Do nothing
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetFloatValue(AIndex: Integer): Extended;
begin
  with FPropList[AIndex] do Result := PropInfo.GetFloatValue(Instance);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetInt64Value(AIndex: Integer): Int64;
begin
  with FPropList[AIndex] do Result := PropInfo.GetInt64Value(Instance);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetOrdValue(AIndex: Integer): Longint;
begin
  with FPropList[AIndex] do Result := PropInfo.GetOrdValue(Instance);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetStrValue(AIndex: Integer): string;
begin
  with FPropList[AIndex] do Result := PropInfo.GetStrValue(Instance);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetWideStrValue(AIndex: Integer): WideString;
begin
  with FPropList[AIndex] do Result := PropInfo.GetWideStrValue(Instance);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetVarValue(AIndex: Integer): Variant;
begin
  with FPropList[AIndex] do Result := PropInfo.GetVariantValue(Instance);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetObjectValue(AIndex: Integer): TObject;
begin
  with FPropList[AIndex] do Result := PropInfo.GetObjectValue(Instance);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.SetByRef(const AProc: TLMDSetByRefProc;
  AData: Pointer);
var
  LI: Integer;
begin
  for LI := 0 to FPropCount - 1 do
    with FPropList[LI] do AProc(Instance, PropInfo, AData);
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.SetEventValue(const Value: TLMDString);
var
  LI: Integer;
begin
  if Value <> '' then
     FPropInsp.DoEnsureEventHandlerSource(Self, Value, GetValue, PropTypeInfo,
                                          False);

  for LI := 0 to FPropCount - 1 do
  begin
    with FPropList[LI] do
      FPropInsp.DoSetEventValue(Self, Instance, PropInfo, Value);
  end;
  Change;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetEventValue(AIndex: Integer): TLMDString;
begin
  Result := '';
  with FPropList[AIndex] do
    FPropInsp.DoGetEventValue(Self, Instance, PropInfo, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.SetFloatValue(Value: Extended);
var
  LI: Integer;
begin
  for LI := 0 to FPropCount - 1 do
    with FPropList[LI] do PropInfo.SetFloatValue(Instance, Value);
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.SetInt64Value(Value: Int64);
var
  LI: Integer;
begin
  for LI := 0 to FPropCount - 1 do
    with FPropList[LI] do PropInfo.SetInt64Value(Instance, Value);
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.SetOrdValue(Value: Integer);
var
  LI: Integer;
begin
  for LI := 0 to FPropCount - 1 do
    with FPropList[LI] do PropInfo.SetOrdValue(Instance, Value);
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.SetStrValue(const Value: string);
var
  LI: Integer;
begin
  for LI := 0 to FPropCount - 1 do
    with FPropList[LI] do PropInfo.SetStrValue(Instance, Value);
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.SetWideStrValue(const Value: WideString);
var
  LI: Integer;
begin
  for LI := 0 to FPropCount - 1 do
    with FPropList[LI] do PropInfo.SetWideStrValue(Instance, Value);
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.SetVarValue(const Value: Variant);
var
  LI: Integer;
begin
  for LI := 0 to FPropCount - 1 do
    with FPropList[LI] do PropInfo.SetVariantValue(Instance, Value);
  Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropEditor.SetObjectValue(const Value: TObject);
var
  LI: Integer;
begin
  for LI := 0 to FPropCount - 1 do
    with FPropList[LI] do PropInfo.SetObjectValue(Instance, Value);
  Change;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDPropEditor.Create(APropInsp: TLMDCustomPropertyInspector;
  AParentObjEditor: TLMDPropEditor; APropCount: Integer;
  APropList: Pointer);
begin
  inherited Create;

  if APropList <> nil then
    FPropList := APropList
  else
    GetMem(FPropList, APropCount * SizeOf(TLMDPropEditorPropListItem));

  FPropInsp        := APropInsp;
  FPropCount       := APropCount;
  FOwnPropList     := (APropList = nil);
  FParentObjEditor := AParentObjEditor;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPropEditor.Destroy;
begin
  if FOwnPropList then
  begin
    if FPropList <> nil then
      FreeMem(FPropList, FPropCount * SizeOf(TLMDPropEditorPropListItem));
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetPropInfo(AIndex: Integer): ILMDProperty;
begin
  Result := FPropList[AIndex].PropInfo;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.GetInstance(AIndex: Integer): TPersistent;
begin
  Result := FPropList[AIndex].Instance;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropEditor.IsWrittenProperty: Boolean;

  function _IsSubComponent(AItem: TLMDPropEditorPropListItem): Boolean;
  var
    obj: TObject;
  begin
    if AItem.PropInfo.PropType^.Kind = tkClass then
    begin
      obj    := AItem.PropInfo.GetObjectValue(AItem.Instance);
      Result := (obj is TComponent) and
                (csSubComponent in TComponent(obj).ComponentStyle);
    end
    else
      Result := False;
  end;

var
  LI: Integer;
begin
  Result := False;
  for LI := 0 to FPropCount - 1 do
    if FPropList[LI].PropInfo.IsReadable and
       (FPropList[LI].PropInfo.IsWritable or _IsSubComponent(FPropList[LI])) and
       (FPropList[LI].PropInfo.PropType^.Kind <> tkMethod) and
       not FPropList[LI].PropInfo.IsDefaultValue(FPropList[LI].Instance) then
    begin
      Result := True;
      Break;
    end;
end;

{ *********************** class TLMDNestedPropEditor ************************* }
{ ------------------------------ protected ----------------------------------- }
function TLMDNestedPropEditor.GetPropName: TLMDString;
begin
  Result := 'SubProp';
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDNestedPropEditor.Create(ANestedIn: TLMDPropEditor);
begin
  inherited Create(ANestedIn.PropInsp, ANestedIn.ParentObjEditor,
                   ANestedIn.PropCount, ANestedIn.FPropList);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDNestedPropEditor.Destroy;
begin
  // Do not call inherited
end;

{ ******************* class TLMDPropertyInspectorPageItem ******************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDPropertyInspectorPageItem.DeGetPickList(AResult: TLMDStrings);
var
  LList: TLMDMemoryStrings;
begin
  if not IsCategory and (FEditor <> nil) then
    begin
      LList := TLMDMemoryStrings.Create;
      try
        FEditor.GetValues(LList);
        if praSortList in FEditor.GetAttrs then
          LList.Sort;

        AResult.Assign(LList);
      finally
        LList.Free;
      end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorPageItem.SetEditor(const Value: TLMDPropEditor);
begin
  if not IsCategory then
  begin
    FEditor           := Value;
    FEditor.FPageItem := Self;
    UpdateParams;
  end;
end;

procedure TLMDPropertyInspectorPageItem.SetEditValue(const Value: TLMDString;
  AForce: Boolean);
begin
  if not IsCategory and ((Value <> FEditValue) or AForce) then
  begin
    Include(TLMDCustomPropertyInspector(Owner).FState, pisObjectsLocked);
    try
      FEditor.Value := Value; // May raise an exception
    except
      Application.HandleException(Self);
    end;
    Exclude(TLMDCustomPropertyInspector(Owner).FState, pisObjectsLocked);
  end;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDPropertyInspectorPageItem.GetDisplayValue: TLMDString;
begin
  if not IsCategory then
    Result := FDisplayValue
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorPageItem.GetEditPickList(
  APickList: TLMDStrings);
begin
  if not IsCategory then
    DeGetPickList(APickList);
end;

function TLMDPropertyInspectorPageItem.GetEditValue: TLMDString;
begin
  if not IsCategory then
    Result := FEditValue
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorPageItem.EditButtonClick;
begin
  if not IsCategory then
    Edit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorPageItem.EditDblClick;
var
  LAttrs:  TLMDPropAttrs;
  LValues: TLMDMemoryStrings;
  LIndex:  Integer;
begin
  if not IsCategory and (FEditor <> nil) and
     not TLMDCustomPropertyInspector(Owner).ReadOnly then
  begin
    LAttrs := FEditor.GetAttrs;

    if (praValueList in LAttrs) and not (praDialog in LAttrs) then
    begin
      LValues := TLMDMemoryStrings.Create;
      try
        DeGetPickList(LValues);

        if LValues.Count > 0 then
        begin
          LIndex := LValues.IndexOf(DisplayValue) + 1;
          if LIndex > LValues.Count - 1 then
            LIndex := 0;

          SetEditValue(LValues[LIndex], True);
        end;
      finally
        LValues.Free;
      end;
    end
    else if praDialog in LAttrs then
      EditButtonClick;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorPageItem.PickListMeasureHeight(
  const AValue: TLMDString; ACanvas: TCanvas; var AHeight: Integer);
begin
  if not IsCategory and (FEditor <> nil) then
    FEditor.ValuesMeasureHeight(AValue, ACanvas, AHeight);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorPageItem.PickListMeasureWidth(const AValue: TLMDString;
  ACanvas: TCanvas; var AWidth: Integer);
begin
  if not IsCategory and (FEditor <> nil) then
    FEditor.ValuesMeasureWidth(AValue, ACanvas, AWidth);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorPageItem.PickListDrawValue(const AValue: TLMDString;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  if not IsCategory and (FEditor <> nil) then
    FEditor.ValuesDrawValue(AValue, ACanvas, ARect, ASelected);
end;

{ ------------------------------ public -------------------------------------- }
destructor TLMDPropertyInspectorPageItem.Destroy;
begin
  Clear;
  inherited;
  if FEditor <> nil then
    FEditor.Free; // Mast be after inherited.
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorPageItem.UpdateParams;
const
  LExpandables: array[Boolean] of TLMDPropsPageItemExpandable = (ieNo, ieYes);
var
  LI:            Integer;
  LPropAttrs:    TLMDPropAttrs;
  LStr:          TLMDString;
  LReadOnlyProp: Boolean;
begin
  if not IsCategory and (FEditor <> nil) then
  begin
    Owner.BeginUpdate;
    try
      Caption    := TLMDCustomPropertyInspector(Owner).TranslateProp(
                                                            FEditor.PropName);
      LPropAttrs := FEditor.GetAttrs;

      if (praValueList in LPropAttrs) and
         not TLMDCustomPropertyInspector(Owner).ReadOnly then
        EditStyle := esPickList
      else if (praDialog in LPropAttrs) and
              not TLMDCustomPropertyInspector(Owner).ReadOnly then
        EditStyle := esEllipsis
      else
        EditStyle := esSimple;

      Expandable := LExpandables[(praSubProperties in LPropAttrs) and
                                 not ((praComponentRef in LPropAttrs) and
                                 not TLMDCustomPropertyInspector(Owner).
                                                        ExpandComponentRefs)];

      LReadOnlyProp := False;
      for LI := 0 to FEditor.PropCount - 1 do
      begin
        if not FEditor.GetPropInfo(LI).IsWritable then
        begin
          LReadOnlyProp := True;
          Break;
        end;
      end;

      ReadOnly    := (praReadOnly in LPropAttrs) or
                     TLMDCustomPropertyInspector(Owner).ReadOnly or
                     (LReadOnlyProp and not (praEditableByRef in LPropAttrs));
      AutoUpdate  := praAutoUpdate in LPropAttrs;
      Highlighted := FEditor.IsWrittenProperty and
                     TLMDCustomPropertyInspector(Owner).FHighlightNonDefaultValues;
      OwnerDrawPickList := praOwnerDrawValues in LPropAttrs;

      LStr := FEditor.Value;    // Respecting AllEquals.
      if FDisplayValue <> LStr then
      begin
        FDisplayValue := LStr;
        Change;
      end;

      LStr := FEditor.GetValue; // Without accounting AllEquals.
      if FEditValue <> LStr then
      begin
        FEditValue := LStr;
        Change;
      end;
    finally
      Owner.EndUpdate;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorPageItem.CanEdit: Boolean;
begin
  Result := not IsCategory and
            (FEditor <> nil) and
            (praDialog in FEditor.GetAttrs) and
            not (pisObjectsLocked in TLMDCustomPropertyInspector(Owner).FState) and
            not TLMDCustomPropertyInspector(Owner).ReadOnly;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorPageItem.Edit;
begin
  if CanEdit then
    FEditor.Edit;
end;

{ ******************** class TLMDPropertyInspectorItem *********************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDPropertyInspectorItem.InsertItem(
  AItem: TLMDPropertyInspectorItem);
begin
  AItem.FOwnerItems := FOwnerItems;
  AItem.FParent := Self;
  FItems.Add(AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorItem.RemoveItem(
  AItem: TLMDPropertyInspectorItem);
begin
  AItem.FOwnerItems := nil;
  AItem.FParent := nil;
  FItems.Remove(AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorItem.Clear;
begin
  while Count > 0 do
    Items[0].Free;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.GetItems(
  AIndex: Integer): TLMDPropertyInspectorItem;
begin
  Result := TLMDPropertyInspectorItem(FItems[AIndex]);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.GetActive: Boolean;
begin
  Result := FPageItem.Active;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.GetEditor: TLMDPropEditor;
begin
  if FPageItem <> nil then
    Result := FPageItem.FEditor
  else
    Result := nil;
end;

function TLMDPropertyInspectorItem.GetExpanded: Boolean;
begin
  Result := FPageItem.Expanded;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.GetLevel: Integer;
begin
  Result := FPageItem.Level;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.GetOwner: TLMDCustomPropertyInspector;
begin
  Result := FOwnerItems.FOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.GetPropInfo(AIndex: Integer): ILMDProperty;
begin
  if FPageItem.Editor <> nil then
    Result := FPageItem.Editor.GetPropInfo(AIndex)
  else
    raise EListError.CreateFmt(SListIndexError, [AIndex]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorItem.SetActive(const Value: Boolean);
begin
  FPageItem.Active := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.GetCount: Integer;
begin
  Result := FPageItem.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.GetTypeInfo: TLMDTypeInfo;
begin
  if FPageItem.Editor <> nil then
    Result := FPageItem.Editor.PropTypeInfo
  else
    Result := nil;
end;
         { ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.GetPropName: TLMDString;
begin
  if FPageItem.Editor <> nil then
    Result := FPageItem.Editor.PropName
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.GetValue: TLMDString;
begin
  if FPageItem.Editor <> nil then
    Result := FPageItem.Editor.Value
  else
    Result := '';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorItem.SetValue(const Value: TLMDString);
begin
  if FPageItem.Editor <> nil then
    FPageItem.Editor.Value := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.GetParentCategory: TLMDPropertyInspectorCategory;
begin
  if (FPageItem.Parent <> nil) and FPageItem.Parent.IsCategory then
    Result := TLMDPropertyInspectorCategory(FPageItem.Parent.Data)
  else
    Result := nil;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDPropertyInspectorItem.Create(
  AOwnerItems: TLMDPropertyInspectorItems;
  AParent: TLMDPropertyInspectorItem;
  APageItem: TLMDPropertyInspectorPageItem);
begin
  inherited Create;

  FItems    := TList.Create;
  FPageItem := APageItem;

  if AParent <> nil then
    AParent.InsertItem(Self)
  else
    AOwnerItems.InsertItem(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPropertyInspectorItem.Destroy;
begin
  Clear;
  FPageItem := nil;
  if FParent <> nil then
    FParent.RemoveItem(Self)
  else
    FOwnerItems.RemoveItem(Self);
  FItems.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorItem.Expand;
begin
  FPageItem.Expand;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorItem.Collapse;
begin
  FPageItem.Collapse;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.CanEdit: Boolean;
begin
  Result := FPageItem.CanEdit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorItem.Edit;
begin
  if not CanEdit then
    raise ELMDPropertyInspector.Create(SLMDPropInspEditError);
  Active := True;
  FPageItem.Edit;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.DisplayRect(ACaption,
  AValue: Boolean): TRect;
begin
  Result := FPageItem.DisplayRect(ACaption, AValue);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.IndexOf(
  AItem: TLMDPropertyInspectorItem): Integer;
var
  LI: Integer;
begin
  Result := -1;
  for LI := 0 to Count - 1 do
    if Items[LI] = AItem then
    begin
      Result := LI;
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.Find(const APropName: TLMDString;
  ATypeInfo: TLMDTypeInfo): TLMDPropertyInspectorItem;
var
  LI: Integer;
begin
  Result := nil;
  for LI := 0 to Count - 1 do
    if LMDSameText(APropName, Items[LI].PropName) and
       ((ATypeInfo = Items[LI].TypeInfo) or (ATypeInfo = nil)) then
    begin
      Result := Items[LI];
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItem.ItemBy(const APropName: TLMDString;
  ATypeInfo: TLMDTypeInfo): TLMDPropertyInspectorItem;
begin
  Result := Find(APropName, ATypeInfo);
  if Result = nil then
    ELMDPropertyInspector.Create(SLMDItemNotFound);
end;

{ ******************* class TLMDPropertyInspectorItems *********************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDPropertyInspectorItems.InsertItem(
  AItem: TLMDPropertyInspectorItem);
begin
  AItem.FOwnerItems := Self;
  AItem.FParent := nil;
  FItems.Add(AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorItems.RemoveItem(
  AItem: TLMDPropertyInspectorItem);
begin
  AItem.FOwnerItems := nil;
  AItem.FParent     := nil;
  FItems.Remove(AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorItems.Clear;
begin
  while Count > 0 do
    Items[0].Free;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItems.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItems.GetItems(
  AIndex: Integer): TLMDPropertyInspectorItem;
begin
  Result := TLMDPropertyInspectorItem(FItems[AIndex]);
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDPropertyInspectorItems.Create(
  AOwner: TLMDCustomPropertyInspector);
begin
  inherited Create;
  FOwner := AOwner;
  FItems := TList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPropertyInspectorItems.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItems.IndexOf(
  AItem: TLMDPropertyInspectorItem): Integer;
var
  LI: Integer;
begin
  Result := -1;
  for LI := 0 to Count - 1 do
    if Items[LI] = AItem then
      begin
        Result := LI;
        Break;
      end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItems.Find(const APropName: TLMDString;
  ATypeInfo: TLMDTypeInfo): TLMDPropertyInspectorItem;
var
  LI: Integer;
begin
  Result := nil;
  for LI := 0 to Count - 1 do
    if LMDSameText(APropName, Items[LI].PropName) and
      ((ATypeInfo = Items[LI].TypeInfo) or (ATypeInfo = nil)) then
    begin
      Result := Items[LI];
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorItems.ItemBy(const APropName: TLMDString;
  ATypeInfo: TLMDTypeInfo): TLMDPropertyInspectorItem;
begin
  Result := Find(APropName, ATypeInfo);
  if Result = nil then
    ELMDPropertyInspector.Create(SLMDItemNotFound);
end;

{ ****************** class TLMDPropertyInspectorCategory ********************* }
{ ------------------------------ private ------------------------------------- }
function TLMDPropertyInspectorCategory.GetCount: Integer;
begin
  Result := FPageItem.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategory.GetItems(
  AIndex: Integer): TLMDPropertyInspectorItem;
begin
  Result := TLMDPropertyInspectorItem(FPageItem[AIndex].Data);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategory.GetExpanded: Boolean;
begin
  Result := FPageItem.Expanded;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategory.GetName: TLMDString;
begin
  Result := FPageItem.Caption;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategory.GetOwner: TLMDCustomPropertyInspector;
begin
  Result := FOwnerCategories.FOwner;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategory.GetActive: Boolean;
begin
  Result := FPageItem.Active;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorCategory.SetActive(const Value: Boolean);
begin
  FPageItem.Active := Value;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDPropertyInspectorCategory.Create(
  AOwnerCategories: TLMDPropertyInspectorCategories;
  APageItem: TLMDPropertyInspectorPageItem);
begin
  inherited Create;

  FPageItem := APageItem;
  AOwnerCategories.InsertItem(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPropertyInspectorCategory.Destroy;
begin
  FOwnerCategories.RemoveItem(Self);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorCategory.Expand;
begin
  FPageItem.Expand;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorCategory.Collapse;
begin
  FPageItem.Collapse;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategory.DisplayRect: TRect;
begin
  Result := FPageItem.DisplayRect(True, True);
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategory.IndexOf(
  AItem: TLMDPropertyInspectorItem): Integer;
var
  LI: Integer;
begin
  Result := -1;
  for LI := 0 to Count - 1 do
    if Items[LI] = AItem then
    begin
      Result := LI;
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategory.Find(const APropName: TLMDString;
  ATypeInfo: TLMDTypeInfo): TLMDPropertyInspectorItem;
var
  LI: Integer;
begin
  Result := nil;
  for LI := 0 to Count - 1 do
    if LMDSameText(APropName, Items[LI].PropName) and
      ((ATypeInfo = Items[LI].TypeInfo) or (ATypeInfo = nil)) then
    begin
      Result := Items[LI];
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategory.ItemBy(const APropName: TLMDString;
  ATypeInfo: TLMDTypeInfo): TLMDPropertyInspectorItem;
begin
  Result := Find(APropName, ATypeInfo);
  if Result = nil then
    ELMDPropertyInspector.Create(SLMDItemNotFound);
end;

{ ***************** class TLMDPropertyInspectorCategories ******************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDPropertyInspectorCategories.InsertItem(
  AItem: TLMDPropertyInspectorCategory);
begin
  AItem.FOwnerCategories := Self;
  FItems.Add(AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorCategories.RemoveItem(
  AItem: TLMDPropertyInspectorCategory);
begin
  AItem.FOwnerCategories := nil;
  FItems.Remove(AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPropertyInspectorCategories.Clear;
begin
  while Count > 0 do
    Items[0].Free;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategories.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategories.GetItems(
  AIndex: Integer): TLMDPropertyInspectorCategory;
begin
  Result := TLMDPropertyInspectorCategory(FItems[AIndex]);
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDPropertyInspectorCategories.Create(
  AOwner: TLMDCustomPropertyInspector);
begin
  inherited Create;
  FOwner := AOwner;
  FItems := TList.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDPropertyInspectorCategories.Destroy;
begin
  Clear;
  FItems.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategories.IndexOf(
  AItem: TLMDPropertyInspectorCategory): Integer;
var
  LI: Integer;
begin
  Result := -1;
  for LI := 0 to Count - 1 do
    if Items[LI] = AItem then
    begin
      Result := LI;
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategories.Find(
  const AName: TLMDString): TLMDPropertyInspectorCategory;
var
  LI: Integer;
begin
  Result := nil;
  for LI := 0 to Count - 1 do
    if LMDSameText(AName, Items[LI].Name) then
    begin
      Result := Items[LI];
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDPropertyInspectorCategories.ItemBy(
  const AName: TLMDString): TLMDPropertyInspectorCategory;
begin
  Result := Find(AName);
  if Result = nil then
    ELMDPropertyInspector.Create(SLMDItemNotFound);
end;

{ ******************* class TLMDCustomPropertyInspector ********************** }
{ ---------------------------------- private --------------------------------- }
{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.ClearTempMenuItems(
  AMenu: TPopupMenu);

  procedure _Iterate(AParent: TMenuItem);
  var
    i:    Integer;
    item: TMenuItem;
  begin
    for i := AParent.Count - 1 downto 0 do
    begin
      item := AParent[i];

      if item is TPropInspMenuItem then
        item.Free
      else
        _Iterate(item);
    end;
  end;

begin
  _Iterate(AMenu.Items);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.AddDefaultMenuItems(
  AMenu: TPopupMenu);

  function _CreateItem(const S: TLMDString; AAction: TPropInspMenuItemAction;
    ACat: TCategory = nil): TPropInspMenuItem;
  begin
    Result := TPropInspMenuItem.Create(Self);
    try
      Result.PropInsp  := Self;
      Result.Caption   := S;
      Result.Action    := AAction;
      Result.Category  := ACat;

      Result.UpdateState;
    except
      Result.Free;
      raise;
    end;
  end;

var
  needsep: Boolean;
  viewitm: TMenuItem;
  arritm:  TMenuItem;
  i:       Integer;
  catlist: TCategoryList;
begin
  ClearTempMenuItems(AMenu);
  needsep := (AMenu.Items.Count > 0);
  catlist := TCategoryList(FCategoryList);

  { View }

  viewitm := _CreateItem('View', miaNone);
  AMenu.Items.Add(viewitm);

  for i := 0 to catlist.Count - 1 do
    viewitm.Add(_CreateItem(catlist[i].Name, miaCategory,
                            catlist[i]));
  if catlist.Count > 0 then
    viewitm.Add(_CreateItem('-', miaNone));
  viewitm.Add(_CreateItem('All', miaViewAll));
  viewitm.Add(_CreateItem('Toggle', miaToggleCats));
  viewitm.Add(_CreateItem('None', miaViewNone));

  { Arrange }

  arritm := _CreateItem('Arrange', miaNone);
  AMenu.Items.Add(arritm);

  arritm.Add(_CreateItem('by Category', miaArrangeByCat));
  arritm.Add(_CreateItem('by Name', miaArrangeByName));

  if needsep then
    AMenu.Items.Add(_CreateItem('-', miaNone));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.RecreateItems(ARestoreState: Boolean);
type
  PCategoryInfo = ^TCategoryInfo;
  TCategoryInfo = record
    Item: TLMDPropertyInspectorPageItem;
  end;

  procedure _DisposeCategories(ACategories: TStringList);
  var
    LI: Integer;
  begin
    for LI := 0 to ACategories.Count - 1 do
      Dispose(PCategoryInfo(ACategories.Objects[LI]));
    ACategories.Clear;
  end;

  procedure _SortCategories(ACategories: TStringList);
  begin
    ACategories.Sort;
  end;

var
  LEditors, LObjects: TList;
  LI, LJ: Integer;
  LCategories: TStringList;
  LCategory: TCategory;
  LCategoryItem: TLMDPropertyInspectorPageItem;
  LCatergoryInfo: PCategoryInfo;
  LStateObject: TLMDPropPageStateObject;
  LItem: TLMDPropertyInspectorPageItem;
begin
  BeginUpdate;
  try
    if ARestoreState then
      LStateObject := SaveState
    else
      LStateObject := nil;
    try
      { Save expanded state for all visible categories }

      for LI := 0 to PageItems.Count - 1 do
        if PageItems[LI].IsCategory then
        begin
          LCategory := TCategoryList(FCategoryList).Find(
            PageItems[LI].Caption);
          if LCategory <> nil then
            LCategory.WasExpanded := PageItems[LI].Expanded;
        end;

      { Recreate items }

      PageItems.Clear;
      FObjectsCategories.Clear;

      LEditors := TList.Create;
      try
        LObjects := TList.Create;
        try
          GetObjects(LObjects);
          TPropListHandler.GetPropEditors(Self, nil, LObjects, False,
                                          False, LEditors);
        finally
          LObjects.Free;
        end;

        LCategories := TStringList.Create;
        try
          { Create visible category list and associate editors }
          { with categories. Destroy hidden category editors.  }

          for LI := LEditors.Count - 1 downto 0 do
          begin
            LCategory := TCategoryList(FCategoryList).FindCategory(
              TLMDPropEditor(LEditors[LI]).PropTypeInfo,
              TLMDPropEditor(LEditors[LI]).GetInstance(0).ClassType,
              TLMDPropEditor(LEditors[LI]).PropName);

            if LCategory.Visible then
            begin
              LJ := LCategories.IndexOf(LCategory.Name);
              if LJ = -1 then
              begin
                New(LCatergoryInfo);
                LCategories.AddObject(LCategory.Name, TObject(LCatergoryInfo));
              end
              else
                LCatergoryInfo := PCategoryInfo(LCategories.Objects[LJ]);

              TLMDPropEditor(LEditors[LI]).FTmpData := LCatergoryInfo;
            end
            else
            begin
              TObject(LEditors[LI]).Free;
              LEditors.Delete(LI);
            end;

            if FObjectsCategories.IndexOf(LCategory.Name) = -1 then
              FObjectsCategories.Add(LCategory.Name);
          end;

          if FArrangeKind = akByCategory then
          begin
            { Sort categories }

            _SortCategories(LCategories);

            { Create category page items }

            for LI := 0 to LCategories.Count - 1 do
            begin
              LCategoryItem := TLMDPropertyInspectorPageItem(
                PageItems[PageItems.Add]);
              LCategoryItem.IsCategory := True;
              LCategoryItem.Caption := LCategories[LI];
              PCategoryInfo(LCategories.Objects[LI]).Item := LCategoryItem;

              CreateItemOrCategory(LCategoryItem);
            end;
          end;

          { Create non-category page items }

          for LI := 0 to LEditors.Count - 1 do
          begin
            if FArrangeKind = akByCategory then
              LCategoryItem := PCategoryInfo(TLMDPropEditor(
                LEditors[LI]).FTmpData).Item
            else
              LCategoryItem := nil;

            if LCategoryItem <> nil then
              LItem := TLMDPropertyInspectorPageItem(LCategoryItem[LCategoryItem.Add])
            else
              LItem := TLMDPropertyInspectorPageItem(PageItems[PageItems.Add]);
            LItem.Editor := TLMDPropEditor(LEditors[LI]);

            CreateItemOrCategory(LItem);
          end;
        finally
          _DisposeCategories(LCategories);
          LCategories.Free;
        end;
      finally
        LEditors.Free;
      end;

      { Restore expanded state for all visible categories }

      if FArrangeKind = akByCategory then
        for LI := 0 to PageItems.Count - 1 do
          if PageItems[LI].IsCategory then
          begin
            LCategory := TCategoryList(FCategoryList).Find(
              PageItems[LI].Caption);
            if (LCategory <> nil) and LCategory.WasExpanded then
              PageItems[LI].Expand;
          end;
    finally
      if LStateObject <> nil then  
        RestoreState(LStateObject);
    end;
  finally
    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.CreateItemOrCategory(
  APageItem: TLMDPropertyInspectorPageItem);
begin
  if not APageItem.IsCategory then
  begin
    if (APageItem.NonCategoryParent <> nil) then
      APageItem.Data := TLMDPropertyInspectorItem.Create(
        FItems,
        TLMDPropertyInspectorItem(APageItem.NonCategoryParent.Data),
        APageItem)
    else
      APageItem.Data := TLMDPropertyInspectorItem.Create(FItems,
        nil, APageItem);
  end
  else
    APageItem.Data := TLMDPropertyInspectorCategory.Create(
      FCategories, APageItem);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.PageItems: TLMDPropsPageItems;
begin
  Result := inherited Items;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.ActivePageItem: TLMDPropsPageItem;
begin
  Result := inherited ActiveItem;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.PageItemVolatileCollapses(
  AItem: TLMDPropertyInspectorPageItem);
begin
  Collapsed(TLMDPropertyInspectorItem(AItem.Data));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.EditorChange(AEditor: TLMDPropEditor);
var
  LPageItem: TLMDPropertyInspectorPageItem;
begin
  LPageItem := AEditor.FPageItem;
  if LPageItem = nil then
    Exit;

  if LPageItem.Expanded and (praVolatileSubProperties in AEditor.GetAttrs) then
  begin
    BeginUpdate;
    try
      Include(TLMDCustomPropertyInspector(Owner).FState,
              pisVolatilingSubProperties); // Do not Fire OnExpanded/OnCollapsed
                                           // events.
      try
        LPageItem.Collapse;
        LPageItem.Expand;
      finally
        Exclude(TLMDCustomPropertyInspector(Owner).FState,
                pisVolatilingSubProperties);
      end;
      if not LPageItem.Expanded then
      begin
        PageItemVolatileCollapses(LPageItem); // Fire OnCollapsed event.
      end;
    finally
      EndUpdate;
    end;
  end;

  UpdateContent;
  DoChange(AEditor);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.RegisterStandatdEditors;
begin
  BeginUpdate;
  try
    RegisterPropEditor(TypeInfo(TComponent), nil, '', TLMDComponentPropEditor);
    RegisterPropEditor(TypeInfo(TCollection), nil, '', TLMDCollectionPropEditor);
    RegisterPropEditor(TypeInfo(TMenuItem), nil, '', TLMDMenuItemPropEditor);
    RegisterPropEditor(TypeInfo(TComponentName), nil, '',
                       TLMDComponentNamePropEditor);
    RegisterPropEditor(TypeInfo(TDate), nil, '', TLMDDatePropEditor);
    RegisterPropEditor(TypeInfo(TTime), nil, '', TLMDTimePropEditor);
    RegisterPropEditor(TypeInfo(TDateTime), nil, '', TLMDDateTimePropEditor);
    RegisterPropEditor(TypeInfo(TCaption), nil, '', TLMDCaptionPropEditor);
    RegisterPropEditor(TypeInfo(TColor), nil, '', TLMDColorPropEditor);
    RegisterPropEditor(TypeInfo(TCursor), nil, '', TLMDCursorPropEditor);
    RegisterPropEditor(TypeInfo(TFontCharset), nil, '', TLMDFontCharsetPropEditor);
    RegisterPropEditor(TypeInfo(TFontName), nil, '', TLMDFontNamePropEditor);
    RegisterPropEditor(TypeInfo(TImeName), nil, '', TLMDImeNamePropEditor);
    RegisterPropEditor(TypeInfo(TFont), nil, '', TLMDFontPropEditor);
    RegisterPropEditor(TypeInfo(TModalResult), nil, '', TLMDModalResultPropEditor);
    RegisterPropEditor(TypeInfo(TPenStyle), nil, '', TLMDPenStylePropEditor);
    RegisterPropEditor(TypeInfo(TBrushStyle), nil, '', TLMDBrushStylePropEditor);
    RegisterPropEditor(TypeInfo(TTabOrder), nil, '', TLMDTabOrderPropEditor);
    RegisterPropEditor(TypeInfo(TShortCut), nil, '', TLMDShortCutPropEditor);
    RegisterPropEditor(TypeInfo(TStrings), nil, '', TLMDStringsPropEditor);
    RegisterPropEditor(TypeInfo(TLMDWideStrings), nil, '', TLMDWideStringsPropEditor);
  finally
    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.GetTypeKindEditorClass(
  ATypeInfo: TLMDTypeInfo): TLMDPropEditorClass;
begin
  case ATypeInfo.Kind of
    tkInteger:        Result := TLMDIntegerPropEditor;
    tkChar:           Result := TLMDCharPropEditor;
    tkEnumeration:    Result := TLMDEnumPropEditor;
    tkFloat:          Result := TLMDFloatPropEditor;
    tkString,
    {$IFDEF LMDCOMP12}
    tkUString,
    {$ENDIF}
    tkLString:        Result := TLMDStringPropEditor;
    tkWString:        Result := TLMDWideStringPropEditor;
    tkSet:            Result := TLMDSetPropEditor;
    tkClass:          Result := TLMDClassPropEditor;
    tkVariant:        Result := TLMDVariantPropEditor;
    tkInt64:          Result := TLMDInt64PropEditor;
    tkMethod:         Result := TLMDEventPropEditor;
  else
                      Result := TLMDPropEditor;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.IndexOfEditor(ATypeInfo: TLMDTypeInfo;
  AObjectClass: TClass; const APropName: TLMDString;
  AEditorClass: TLMDPropEditorClass): Integer;
var
  LI: Integer;
begin
  Result := -1;
  for LI := 0 to High(FEditors) do
    if (FEditors[LI].TypeInfo = ATypeInfo) and
       (FEditors[LI].ObjectClass = AObjectClass) and
       LMDSameText(FEditors[LI].PropName, APropName) and
       (FEditors[LI].EditorClass = AEditorClass) then
      begin
        Result := LI;
        Break;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.CheckObjectsLock;
begin
  if pisObjectsLocked in FState then
    raise ELMDPropsPage.Create(SLMDPropInspObjectsLocked);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.DoRegisterPropCategory(
  const ACategoryName: TLMDString; ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
  const APropName: TLMDString);
var
  LI:    Integer;
  LCats: TCategoryList;
begin
  CheckObjectsLock;

  LCats := TCategoryList(FCategoryList);
  LI    := LCats.IndexOf(ACategoryName);
  if LI = -1 then
  begin
    LCats.Add(TCategory.Create(ACategoryName, FExpandedCategories));
    LI := LCats.Count - 1;
  end;
  LCats[LI].Add(TCategoryFilter.Create(ATypeInfo, AObjectClass, APropName));
  RecreateItems;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.DoUnregisterPropCategory(
  const ACategoryName: TLMDString; ATypeInfo: TLMDTypeInfo; AObjectClass: TClass;
  const APropName: TLMDString);
var
  LI, LJ: Integer;
  LCats:  TCategoryList;
begin
  CheckObjectsLock;

  LCats := TCategoryList(FCategoryList);
  LI    := LCats.IndexOf(ACategoryName);
  if LI <> -1 then
  begin
    LJ := LCats[LI].IndexOf(ATypeInfo, AObjectClass, APropName);
    if LJ <> -1 then
      LCats[LI].Delete(LJ);
  end;
  RecreateItems;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.GetActiveItem: TLMDPropertyInspectorItem;
var
  LItem: TLMDPropertyInspectorPageItem;
begin
  LItem := TLMDPropertyInspectorPageItem(ActivePageItem);
  if (LItem <> nil) and not LItem.IsCategory then
    Result := TLMDPropertyInspectorItem(LItem.Data)
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.GetActiveCategory: TLMDPropertyInspectorCategory;
var
  LItem: TLMDPropertyInspectorPageItem;
begin
  LItem := TLMDPropertyInspectorPageItem(ActivePageItem);
  if (LItem <> nil) and LItem.IsCategory then
    Result := TLMDPropertyInspectorCategory(LItem.Data)
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.SetPropKinds(
  const Value: TLMDPropertyInspectorPropKinds);
begin
  if FPropKinds <> Value then
    begin
      FPropKinds := Value;
      RecreateItems;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.SetComponentRefColor(
  const Value: TColor);
begin
  if FComponentRefColor <> Value then
    begin
      FComponentRefColor := Value;
      Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.SetComponentRefPropColor(
  const Value: TColor);
begin
  if FComponentRefPropColor <> Value then
    begin
      FComponentRefPropColor := Value;
      Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.SetExpandComponentRefs(
  const Value: Boolean);
begin
  if FExpandComponentRefs <> Value then
    begin
      FExpandComponentRefs := Value;
      RecreateItems;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.SetReadOnly(const Value: Boolean);
begin
  if FReadOnly <> Value then
    begin
      FReadOnly := Value;
      RecreateItems;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.SetDesigner(const Value: TLMDDataTag);
begin
  if FDesigner <> Value then
    begin
      FDesigner := Value;
      RecreateItems;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.SetSortType(
  const Value: TLMDPropertyInspectorSortType);
begin
  if FSortType <> Value then
    begin
      FSortType := Value;
      RecreateItems;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.SetArrangeKind(
  const Value: TLMDPropertyInspectorArrangeKind);
begin
  if FArrangeKind <> Value then
    begin
      FArrangeKind := Value;
      RecreateItems;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.SetHighlightNonDefaultValues(
  const Value: Boolean);
begin
  FHighlightNonDefaultValues := Value;
  UpdateContent;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.SetExpandedCategories(
  const Value: Boolean); 
begin
  FExpandedCategories := Value;
  TCategoryList(FCategoryList).ExpandedCategories := Value;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDCustomPropertyInspector.CreateItem(
  AParent: TLMDPropsPageItem): TLMDPropsPageItem;
begin
  Result := TLMDPropertyInspectorPageItem.Create(Self, AParent);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.ItemDestroying(
  AItem: TLMDPropsPageItem);
begin
  inherited;
  TObject(AItem.Data).Free;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.ItemExpanded(AItem: TLMDPropsPageItem);
var
  LEditor: TLMDPropEditor;
  LSubProps: TList;
  LI: Integer;
  LItem: TLMDPropertyInspectorPageItem;
begin
  if not AItem.IsCategory then
  begin
    LEditor := TLMDPropertyInspectorPageItem(AItem).Editor;
    if LEditor <> nil then
      begin
        LSubProps := TList.Create;
        try
          if not ((praComponentRef in LEditor.GetAttrs) and
            not ExpandComponentRefs) then
            begin
              LEditor.GetSubProps(LSubProps);
              BeginUpdate;
              try
                for LI := 0 to LSubProps.Count - 1 do
                begin
                  LItem := TLMDPropertyInspectorPageItem(AItem[AItem.Add]);
                  LItem.Editor := TLMDPropEditor(LSubProps[LI]);
                  CreateItemOrCategory(LItem);
                end;
              finally
                EndUpdate;
              end;
            end;
        finally
           LSubProps.Free;
        end;
      end;
    if not (pisVolatilingSubProperties in FState) then
      Expanded(TLMDPropertyInspectorItem(TLMDPropertyInspectorPageItem(AItem).Data));
  end
  else
    CategoryExpanded(TLMDPropertyInspectorCategory(TLMDPropertyInspectorPageItem(AItem).Data));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.ItemCollapsed(AItem: TLMDPropsPageItem);
begin
  if not AItem.IsCategory then
  begin
    BeginUpdate;
    try
      AItem.Clear;
    finally
      EndUpdate;
    end;
    if not (pisVolatilingSubProperties in FState) then
      Collapsed(TLMDPropertyInspectorItem(TLMDPropertyInspectorPageItem(AItem).Data));
  end
  else
    CategoryCollapsed(TLMDPropertyInspectorCategory(TLMDPropertyInspectorPageItem(AItem).Data));
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.GetItemCaptionColor(
  AItem: TLMDPropsPageItem): TColor;
begin
  if not AItem.IsCategory and (TLMDPropertyInspectorPageItem(AItem).FEditor <> nil) and
    (praComponentRef in TLMDPropertyInspectorPageItem(AItem).FEditor.GetAttrs) then
    Result := ComponentRefColor
  else if (AItem.NonCategoryParent <> nil) and
    (TLMDPropertyInspectorPageItem(AItem.NonCategoryParent).FEditor <> nil) and
    (praComponentRef in TLMDPropertyInspectorPageItem(AItem.NonCategoryParent).FEditor.GetAttrs) then
    Result := ComponentRefPropColor
  else
    Result := inherited GetItemCaptionColor(AItem);

  if not AItem.IsCategory then
    GetCaptionColor(TLMDPropertyInspectorItem(TLMDPropertyInspectorPageItem(AItem).Data), Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.DoContextPopup(MousePos: TPoint;
  var Handled: Boolean);
var
  LPopupMenu:     TPopupMenu;
  LIsDefaultMenu: Boolean;
begin
  FTempMenu.Free;   // Destroy previous implicit menu.
  FTempMenu := nil; //

  if Assigned(OnContextPopup) then
    OnContextPopup(Self, MousePos, Handled);
  if Handled then
    Exit;

  LPopupMenu     := GetPopupMenu;
  LIsDefaultMenu := (LPopupMenu = nil);
  if LIsDefaultMenu then
  begin
    FTempMenu  := TPopupMenu.Create(nil);
    LPopupMenu := FTempMenu;
  end;

  if LPopupMenu.AutoPopup then
  begin
    { Adjust menu }

    if LIsDefaultMenu or (pimoAddDefaultItems in FMenuOptions) then
      AddDefaultMenuItems(LPopupMenu)
    else
      ClearTempMenuItems(LPopupMenu);

    { Do popup }

    MousePos := ClientToScreen(MousePos);

    LPopupMenu.PopupComponent := Self;
    LPopupMenu.Popup(MousePos.X, MousePos.Y);

    Handled := True;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.ObjectsChanged;
begin
  RecreateItems;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.GetEditorClass(AIsSubProp: Boolean;
  AInstance: TPersistent; APropInfo: ILMDProperty;
  var AEditorClass: TLMDPropEditorClass);
var
  LI, LBest:     Integer;
  LTypeInfo:     TLMDTypeInfo;
  LClass:        TClass;
  LFilterRes:    Boolean;
  LTypeInfoKind: TTypeKind;
begin
  AEditorClass := nil;

  if Assigned(FOnGetEditorClass) then
  begin
    FOnGetEditorClass(Self, AInstance, APropInfo, AEditorClass);
    if AEditorClass <> nil then
      Exit;
  end;

  LTypeInfo     := APropInfo.PropType;
  LTypeInfoKind := LTypeInfo.Kind;
  LClass        := AInstance.ClassType;

  if not (((pkProperties in PropKinds) and (LTypeInfoKind in tkProperties)) or
          ((pkEvents in PropKinds) and (LTypeInfoKind in tkMethods))) or
     not APropInfo.IsReadable or
     not ((pkReadOnly in PropKinds) or APropInfo.IsWritable or
          (APropInfo.PropType^.Kind = tkClass))
  then
    Exit;

  LFilterRes := True;
  FilterProp(AInstance, APropInfo, AIsSubProp, LFilterRes);
  if not LFilterRes then
    Exit;

  LBest := -1;
  for LI := High(FEditors) downto 0 do
    if (LTypeInfo = FEditors[LI].TypeInfo) or
       ((LTypeInfoKind = tkClass) and
        (FEditors[LI].TypeInfo.Kind = tkClass) and
        GetTypeData(LTypeInfo).ClassType.InheritsFrom(
                                GetTypeData(FEditors[LI].TypeInfo).ClassType))
    then
      if ((FEditors[LI].ObjectClass = nil) or
          LClass.InheritsFrom(FEditors[LI].ObjectClass)) and
         ((FEditors[LI].PropName = '') or
          LMDSameText(FEditors[LI].PropName, {$IFDEF LMDCOMP12}TLMDString{$ENDIF}(APropInfo.Name)))
      then
        if (LBest = -1) or
           ((FEditors[LBest].ObjectClass = nil) and
            (FEditors[LI].ObjectClass <> nil)) or
           ((FEditors[LBest].PropName = '') and
            (FEditors[LI].PropName <> '')) or
           ((FEditors[LBest].TypeInfo <> LTypeInfo) and
            (FEditors[LI].TypeInfo = LTypeInfo)) or
           ((FEditors[LBest].TypeInfo <> FEditors[LI].TypeInfo) and
            (FEditors[LBest].TypeInfo.Kind = tkClass) and
            (FEditors[LI].TypeInfo.Kind = tkClass) and
            GetTypeData(FEditors[LI].TypeInfo).ClassType.InheritsFrom(
                            GetTypeData(FEditors[LBest].TypeInfo).ClassType))
        then
          LBest := LI;

  if LBest <> -1 then
    AEditorClass := FEditors[LBest].EditorClass
  else
    AEditorClass := GetTypeKindEditorClass(LTypeInfo);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.FilterProp(AInstance: TPersistent;
  APropInfo: ILMDProperty; AIsSubProp: Boolean; var AIncludeProp: Boolean);
begin
  if Assigned(OnFilterProp) then
    OnFilterProp(Self, AInstance, APropInfo, AIsSubProp, AIncludeProp);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.TranslateProp(
  const APropName: TLMDString): TLMDString;
begin
  Result := APropName;
  if Assigned(FOnTranslateProp) then
    FOnTranslateProp(Self, APropName, Result);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.DoChange(AEditor: TLMDPropEditor);
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.Expanded(AItem: TLMDPropertyInspectorItem);
begin
  if Assigned(OnExpanded) then
    OnExpanded(Self, AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.Collapsed(
  AItem: TLMDPropertyInspectorItem);
begin
  if Assigned(OnCollapsed) then
    OnCollapsed(Self, AItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.CategoryExpanded(
  ACategory: TLMDPropertyInspectorCategory);
begin
  if Assigned(OnCategoryExpanded) then
    OnCategoryExpanded(Self, ACategory);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.CategoryCollapsed(
  ACategory: TLMDPropertyInspectorCategory);
begin
  if Assigned(OnCategoryCollapsed) then
    OnCategoryCollapsed(Self, ACategory);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.GetCaptionColor(
  AItem: TLMDPropertyInspectorItem; var AColor: TColor);
begin
  if Assigned(OnGetCaptionColor) then OnGetCaptionColor(Self, AItem, AColor);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.CustomCompare(AInstance: TPersistent;
  APropInfo1, APropInfo2: ILMDProperty; var ACompare: Integer);
begin
  if Assigned(OnCompare) then
    OnCompare(Self, AInstance, APropInfo1, APropInfo2, ACompare)
  else
    ACompare := CompareText({$IFDEF LMDCOMP12}TLMDString{$ENDIF}(APropInfo1.Name),
                            {$IFDEF LMDCOMP12}TLMDString{$ENDIF}(APropInfo2.Name));
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDCustomPropertyInspector.Create(AOwner: TComponent);
begin
  inherited;
  FItems                        := TLMDPropertyInspectorItems.Create(Self);
  FCategories                   := TLMDPropertyInspectorCategories.Create(Self);
  FObjectsCategories            := TLMDMemoryStrings.Create;
  FCategoryList                 := TCategoryList.Create;
  FPropKinds                    := [pkProperties];
  FComponentRefColor            := clMaroon;
  FComponentRefPropColor        := clGreen;
  FExpandComponentRefs          := True;
  FHighlightNonDefaultValues    := True;
  FAutoCompRefs                 := True;
  FAutoEvents                   := True;

  RegisterStandatdEditors;
  RegisterStandardCategories;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomPropertyInspector.Destroy;
begin
  BeginDestruction;

  PageItems.Clear;

  FItems.Free;
  FCategories.Free;
  FObjectsCategories.Free;
  FCategoryList.Free;
  FTempMenu.Free;

  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.UpdateContent;

  procedure _UpdateItems(AList: TLMDObjectList);
  var
    LI: Integer;
  begin
    for LI := 0 to AList.Count - 1 do
      begin
        TLMDPropertyInspectorPageItem(AList[LI]).UpdateParams;
        _UpdateItems(TLMDPropertyInspectorPageItem(AList[LI]));
      end;
  end;

begin
  BeginUpdate;
  try
    _UpdateItems(PageItems);
  finally
    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.UpdateItems;
begin
  CheckObjectsLock;
  RecreateItems;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.RegisterPropEditor(ATypeInfo: TLMDTypeInfo;
  AObjectClass: TClass; const APropName: TLMDString;
  AEditorClass: TLMDPropEditorClass);
var
  LI: Integer;
begin
  CheckObjectsLock;
  LI := IndexOfEditor(ATypeInfo, AObjectClass, APropName, AEditorClass);
  if LI = -1 then
    begin
      SetLength(FEditors, Length(FEditors) + 1);
      LI := High(FEditors);
    end;
  with FEditors[LI] do
    begin
      TypeInfo := ATypeInfo;
      ObjectClass := AObjectClass;
      PropName := APropName;
      EditorClass := AEditorClass;
    end;
  RecreateItems;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.UnregisterPropEditor(ATypeInfo: TLMDTypeInfo;
  AObjectClass: TClass; const APropName: TLMDString;
  AEditorClass: TLMDPropEditorClass);
var
  LI, LJ: Integer;
begin
  CheckObjectsLock;
  LI := IndexOfEditor(ATypeInfo, AObjectClass, APropName, AEditorClass);
  if LI <> -1 then
    begin
      for LJ := LI + 1 to High(FEditors) do
        FEditors[LJ - 1] := FEditors[LJ];
      SetLength(FEditors, Length(FEditors) - 1);
    end;
  RecreateItems;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.RegisterPropCategory(
  const ACategoryName, APropName: TLMDString);
begin
  DoRegisterPropCategory(ACategoryName, nil, nil, APropName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.UnregisterPropCategory(
  const ACategoryName, APropName: TLMDString);
begin
  DoUnregisterPropCategory(ACategoryName, nil, nil, APropName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.RegisterPropCategory(
  const ACategoryName: TLMDString; AObjectClass: TClass;
  const APropName: TLMDString);
begin
  DoRegisterPropCategory(ACategoryName, nil, AObjectClass, APropName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.UnregisterPropCategory(
  const ACategoryName: TLMDString; AObjectClass: TClass;
  const APropName: TLMDString);
begin
  DoUnregisterPropCategory(ACategoryName, nil, AObjectClass, APropName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.RegisterPropCategory(
  const ACategoryName: TLMDString; ATypeInfo: TLMDTypeInfo;
  const APropName: TLMDString);
begin
  DoRegisterPropCategory(ACategoryName, ATypeInfo, nil, APropName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.UnregisterPropCategory(
  const ACategoryName: TLMDString; ATypeInfo: TLMDTypeInfo;
  const APropName: TLMDString);
begin
  DoUnregisterPropCategory(ACategoryName, ATypeInfo, nil, APropName);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.RegisterPropCategory(
  const ACategoryName: TLMDString; ATypeInfo: TLMDTypeInfo);
begin
  DoRegisterPropCategory(ACategoryName, ATypeInfo, nil, '');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.UnregisterPropCategory(
  const ACategoryName: TLMDString; ATypeInfo: TLMDTypeInfo);
begin
  DoUnregisterPropCategory(ACategoryName, ATypeInfo, nil, '');
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.HideCategory(
  const ACategoryName: TLMDString): Boolean;
var
  LCategory: TCategory;
begin
  CheckObjectsLock;

  LCategory := TCategoryList(FCategoryList).Find(ACategoryName);
  if LCategory <> nil then
  begin
    Result             := True;
    LCategory.FVisible := False;
    RecreateItems;
  end
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.ShowCategory(
  const ACategoryName: TLMDString): Boolean;
var
  LCategory: TCategory;
begin
  CheckObjectsLock;

  LCategory := TCategoryList(FCategoryList).Find(ACategoryName);
  if LCategory <> nil then
  begin
    Result             := True;
    LCategory.FVisible := True;
    RecreateItems;
  end
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.ShowAllCategories;
var
  LI:    Integer;
  LCats: TCategoryList;
begin
  CheckObjectsLock;

  LCats := TCategoryList(FCategoryList);
  for LI := 0 to LCats.Count - 1 do
    LCats[LI].FVisible := True;
  RecreateItems;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.HideAllCategories;
var
  LI:    Integer;
  LCats: TCategoryList;
begin
  CheckObjectsLock;

  LCats := TCategoryList(FCategoryList);
  for LI := 0 to LCats.Count - 1 do
    LCats[LI].FVisible := False;

  RecreateItems;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.ExpandAllCategories;
var
  LI:    Integer;
  LCats: TCategoryList;
begin
  CheckObjectsLock;
  BeginUpdate;
  try
    for LI := 0 to FCategories.Count - 1 do
      FCategories[LI].Expand;

    LCats := TCategoryList(FCategoryList);
    for LI := 0 to LCats.Count - 1 do
      LCats[LI].FWasExpanded := True;
      RecreateItems;
  finally
    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomPropertyInspector.CollapseAllCategories;
var
  LI:    Integer;
  LCats: TCategoryList;
begin
  CheckObjectsLock;
  BeginUpdate;
  try
    for LI := 0 to FCategories.Count - 1 do
      FCategories[LI].Collapse;

    LCats := TCategoryList(FCategoryList);
    for LI := 0 to LCats.Count - 1 do
      LCats[LI].FWasExpanded := False;
      RecreateItems(False);
  finally
    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.IsRegisteredCategoryHidden(
  const ACategoryName: TLMDString): Boolean;
var
  LI:    Integer;
  LCats: TCategoryList;
begin
  LCats := TCategoryList(FCategoryList);
  LI    := LCats.IndexOf(ACategoryName);
  if LI <> -1 then
    Result := not LCats[LI].Visible
  else
    Result := False;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.ItemAtPos(AX,
  AY: Integer): TLMDPropertyInspectorItem;
var
  LPageItem: TLMDPropertyInspectorPageItem;
begin
  LPageItem := TLMDPropertyInspectorPageItem(inherited ItemAtPos(Ax, AY));
  if (LPageItem <> nil) and not LPageItem.IsCategory then
    Result := TLMDPropertyInspectorItem(LPageItem.Data)
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomPropertyInspector.CategoryAtPos(AX,
  AY: Integer): TLMDPropertyInspectorCategory;
var
  LPageItem: TLMDPropertyInspectorPageItem;
begin
  LPageItem := TLMDPropertyInspectorPageItem(inherited ItemAtPos(Ax, AY));
  if (LPageItem <> nil) and LPageItem.IsCategory then
    Result := TLMDPropertyInspectorCategory(LPageItem.Data)
  else
    Result := nil;
end;

{************************ TLMDSimplePropInspector *****************************}
{ ---------------------------------------------------------------------------- }
constructor TLMDSimplePropInspector.Create(AOwner: TComponent);
begin
  inherited;
  FObjects       := TLMDSimplePropInspObjects.Create(Self);
  FEditorUtils   := TSimplePropInspEditorUtils.Create(Self).AddRef;
  FEditorWindows := TLMDEditorWindowManager.Create(Self, FEditorUtils);
end;

procedure TLMDSimplePropInspector.DefineProperties(Filer: TFiler);
begin
  inherited;

  { Deprecated properties }

  Filer.DefineProperty('OnGetComponent', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnGetComponents', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnGetComponentName', ReadDeprecatedEventProp, nil, False);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSimplePropInspector.Destroy;
begin
  inherited;

  FEditorWindows.DestroyAll;
  FObjects.Free;
  FEditorWindows.Free;
  FEditorUtils.Release(True);
end;

function TLMDSimplePropInspector.DetectEditorWindowManager(
  AEditedObject: TPersistent): TLMDEditorWindowManager;
begin
  Result := FEditorWindows;
end;

procedure TLMDSimplePropInspector.DoChange(AEditor: TLMDPropEditor);
begin
  FEditorWindows.UpdateAll;
  inherited;
end;

procedure TLMDSimplePropInspector.GetObjects(AResult: TList);
begin
  if FObjects <> nil then
    FObjects.GetItems(AResult); 
end;

procedure TLMDSimplePropInspector.ReadDeprecatedEventProp(Reader: TReader);
begin
  if Reader.NextValue = vaNil then
    Reader.ReadValue
  else
    Reader.ReadIdent;
end;

function TLMDPropEditor.CreateEditorWndCbs(
  AEditedObject: TPersistent;
  out AResult: TLMDEditorWindowCallbacks): Boolean;
var
  wndmgr: TLMDEditorWindowManager;
begin
  wndmgr := FPropInsp.DetectEditorWindowManager(AEditedObject);

  if wndmgr <> nil then
  begin
    AResult := wndmgr.CreateCallbacks;
    Result := True;
  end
  else
  begin
    AResult := nil;
    Result  := False;
  end;
end;

function TLMDCustomPropertyInspector.DetectEditorWindowManager(
  AEditedObject: TPersistent): TLMDEditorWindowManager;
begin
  Result := nil;
end;

{ TPropListHandler }

procedure TPropListHandler.CaptionCompareProc(AInstance: TPersistent;
  APropInfo1, APropInfo2: ILMDProperty; var ACompare: Integer);
begin
  ACompare := CompareText({$IFDEF LMDCOMP12}TLMDString{$ENDIF}(APropInfo1.Name),
                          {$IFDEF LMDCOMP12}TLMDString{$ENDIF}(APropInfo2.Name));
end;

constructor TPropListHandler.Create(APropInsp: TLMDCustomPropertyInspector;
  AParentObjEditor: TLMDPropEditor);
begin
  inherited Create;
  FPropInsp        := APropInsp;
  FParentObjEditor := AParentObjEditor;
end;

procedure TPropListHandler.CreateEditors(ALists: TList; AOnlyNestable,
  AIsSubProp: Boolean; AResult: TList);

  function _GetEditorClass(APropIndex: Integer): TLMDPropEditorClass;
  var
    i:        Integer;
    othercls: TLMDPropEditorClass;
  begin
    FPropInsp.GetEditorClass(AIsSubProp, TObjProps(ALists[0]).Instance,
                             TObjProps(ALists[0]).Props[APropIndex].PropInfo,
                             Result);

    for i := 0 to ALists.Count - 1 do
    begin
      FPropInsp.GetEditorClass(AIsSubProp, TObjProps(ALists[i]).Instance,
                               TObjProps(ALists[i]).Props[APropIndex].PropInfo,
                               othercls);
      if Result <> othercls then
      begin
        Result := nil;
        Break; // for 
      end;
    end;
  end;

var
  i, j:    Integer;
  edtrcls: TLMDPropEditorClass;
  edtr:    TLMDPropEditor;
  attrs:   TLMDPropAttrs;
  item:    TObjProps;
begin
  for i := 0 to High(TObjProps(ALists[0]).Props) do
  begin
    edtrcls := _GetEditorClass(i);

    if edtrcls <> nil then
    begin
      edtr := edtrcls.Create(FPropInsp, FParentObjEditor, ALists.Count);
      try
        for j := 0 to ALists.Count - 1 do
        begin
          item := TObjProps(ALists[j]);
          edtr.SetPropEntry(j, item.Instance, item.Props[i].PropInfo);
        end;

        attrs := edtr.GetAttrs;
        if ((ALists.Count = 1) or (praMultiSelect in attrs)) and
           (not AOnlyNestable or not (praNotNestable in attrs)) then
          AResult.Add(edtr)
        else
        begin
          edtr.Free;
          edtr := nil;
        end;
      except
        edtr.Free;
        raise;
      end;
    end;
  end;
end;

function TPropListHandler.CreatePropLists(AInstances: TList): TList;
var
  i:        Integer;
  inst:     TPersistent;
  item:     TObjProps;
begin
  Result := TList.Create;
  try
    for i := 0 to AInstances.Count - 1 do
    begin
      inst := TPersistent(AInstances[i]);
      item := TObjProps.Create;

      item.Instance := inst;
      GetRTTIProps(inst, item);
      GetDynamicProps(inst, item);

      Result.Add(item);
    end;
  except
    FreePropLists(Result);
    raise;
  end;
end;

procedure TPropListHandler.FreePropLists(ALists: TList);
var
  i: Integer;
begin
  for i := 0 to ALists.Count - 1 do
    TObject(ALists[i]).Free;
  ALists.Free;
end;

function TPropListHandler.GetCompareProc: TComparePropsProc;
begin
  case FPropInsp.FSortType of
    stCaption: Result := CaptionCompareProc;
    stCustom:  Result := FPropInsp.CustomCompare;
  else
    Result := nil;
  end;
end;

procedure TPropListHandler.GetDynamicProps(AInstance: TPersistent;
  AItem: TObjProps);
var
  props:     TList;
  definer:   TLMDPropertyInspectorDefiner;
  oldlen, i: Integer;
begin
  props   := TList.Create;
  definer := TLMDPropertyInspectorDefiner.Create(FPropInsp, props);
  try
    FPropInsp.DoDynPropsDefine(AInstance, definer);

    oldlen := Length(AItem.Props);
    SetLength(AItem.Props, oldlen + props.Count);

    for i := 0 to props.Count - 1 do
    begin
      AItem.Props[oldlen + i].Instance := AInstance;
      AItem.Props[oldlen + i].PropInfo := ILMDProperty(props[i]);
    end;
  finally
    definer.Free;
    props.Free;
  end;
end;

class procedure TPropListHandler.GetPropEditors(
  APropInsp: TLMDCustomPropertyInspector; AParentObjEditor: TLMDPropEditor;
  AInstances: TList; AOnlyNestable, AIsSubProp: Boolean; AResult: TList);
var
  hdr:      TPropListHandler;
  proplsts: TList;
  compproc: TComparePropsProc;
begin
  hdr      := TPropListHandler.Create(APropInsp, AParentObjEditor);
  proplsts := hdr.CreatePropLists(AInstances);
  try
    if proplsts.Count = 0 then
      Exit;

    compproc := hdr.GetCompareProc();
    if Assigned(compproc) then
      hdr.SortProps(TObjProps(proplsts[0]), compproc);

    hdr.Intersect(proplsts);
    hdr.CreateEditors(proplsts, AOnlyNestable, AIsSubProp, AResult);
  finally
    hdr.FreePropLists(proplsts);
    hdr.Free;
  end;
end;

procedure TPropListHandler.GetRTTIProps(AInstance: TPersistent;
  AItem: TObjProps);
var
  props:     TLMDPropList;
  pcnt:      Integer;
  oldlen, i: Integer;
begin
  pcnt := GetPropList(AInstance.ClassInfo, tkAny, nil);
  GetMem(props, pcnt * SizeOf(Pointer));
  try
    GetPropList(AInstance.ClassInfo, tkAny, props, False);

    oldlen := Length(AItem.Props);
    SetLength(AItem.Props, oldlen + pcnt);

    for i := 0 to pcnt - 1 do
    begin
      AItem.Props[oldlen + i].Instance := AInstance;
      AItem.Props[oldlen + i].PropInfo := GetRTTIPropWrapper(props[i]);
    end;
  finally
    FreeMem(props);
  end;
end;

function TPropListHandler.GetRTTIPropWrapper(
  AOrigin: TLMDPropInfo): TRTTIPropWrapper;
begin
  Result := TRTTIPropWrapper(RTTIPropWrapperMap.Find(AOrigin));

  if Result = nil then
  begin
    Result := TRTTIPropWrapper.Create(AOrigin);
    RTTIPropWrapperMap.Add(Result);
  end;
end;

procedure TPropListHandler.Intersect(ALists: TList);

  procedure _MarkHole(AIndex: Integer);
  begin
    TObjProps(ALists[0]).Props[AIndex].Instance := nil;
  end;

  function _IsHole(AIndex: Integer): Boolean;
  begin
    Result := (AIndex > High(TObjProps(ALists[0]).Props)) or
              (TObjProps(ALists[0]).Props[AIndex].Instance = nil);
  end;

  procedure _Reorder(AItem: TObjProps);
  var
    base:  TObjProps;
    i, j:  Integer;
    found: Integer;
    tmp:   TLMDPropEditorPropListItem;
  begin
    base := TObjProps(ALists[0]);

    if Length(AItem.Props) < Length(base.Props) then // Expand item prop list.
      SetLength(AItem.Props, Length(base.Props));    //

    for i := 0 to High(base.Props) do
    begin
      found := -1;
      for j := 0 to High(AItem.Props) do
        if (AItem.Props[j].Instance <> nil) and      // Not from expanded slots.
           (_IsHole(j) or (j >= i)) and
           IsCompatible(base.Props[i], AItem.Props[j]) then
        begin
          found := j;
          Break;
        end;

      if found <> -1 then
      begin
        tmp                := AItem.Props[i];
        AItem.Props[i]     := AItem.Props[found];
        AItem.Props[found] := tmp;
      end
      else
        _MarkHole(i);
    end;
  end;

  procedure _Pack(AItem: TObjProps);
  var
    len, i: Integer;
  begin
    len := 0;
    for i := 0 to High(AItem.Props) do
      if not _IsHole(i) then
      begin
        if i <> len then
          AItem.Props[len] := AItem.Props[i];
        Inc(len);
      end;

    SetLength(AItem.Props, len);
  end;

var
  i: Integer;
begin
  for i := 1 to ALists.Count - 1 do     // All except base.
    _Reorder(TObjProps(ALists[i]));

  for i := ALists.Count - 1 downto 0 do // Pack base-list last
    _Pack(TObjProps(ALists[i]));        // to preserve hole marks.
end;

function TPropListHandler.IsCompatible(const APropA,
  APropB: TLMDPropEditorPropListItem): Boolean;
begin
  Result := (APropA.PropInfo.PropType = APropB.PropInfo.PropType) and
            SameText(TLMDString(APropA.PropInfo.Name),
                     TLMDString(APropB.PropInfo.Name));
end;

procedure TPropListHandler.SortProps(AItem: TObjProps;
  ACompareProc: TComparePropsProc);
var
  cmprec: TComparePropsRec;
begin
  cmprec.Item        := AItem;
  cmprec.CompareProc := ACompareProc;

  LMDQuickSort(0, High(AItem.Props), PropListHandlerQSCompareProxy,
               PropListHandlerQSExchangeProxy, @cmprec);
end;

function PropListHandlerQSCompareProxy(AItemIndex1, AItemIndex2: Integer;
  AData: TLMDDataTag): Integer;
var
  data: TComparePropsRec;
begin
  data := PComparePropsRec(AData)^;

  Result := 0;
  data.CompareProc(data.Item.Instance, data.Item.Props[AItemIndex1].PropInfo,
                   data.Item.Props[AItemIndex2].PropInfo, Result);
end;

procedure PropListHandlerQSExchangeProxy(AItemIndex1, AItemIndex2: Integer;
  AData: TLMDDataTag);
var
  data: TComparePropsRec;
  tmp:  TLMDPropEditorPropListItem;
begin
  data := PComparePropsRec(AData)^;

  tmp                          := data.Item.Props[AItemIndex1];
  data.Item.Props[AItemIndex1] := data.Item.Props[AItemIndex2];
  data.Item.Props[AItemIndex2] := tmp;
end;

procedure TLMDPropEditor.GetPropEditors(AParentObjEditor: TLMDPropEditor;
  AObjList: TList; AOnlyNestable, AIsSubProp: Boolean; AResult: TList);
begin
  TPropListHandler.GetPropEditors(FPropInsp, AParentObjEditor, AObjList,
                                  AOnlyNestable, AIsSubProp, AResult);
end;

{ TLMDSimplePropInspObjects }

procedure TLMDSimplePropInspObjects.Add(AItem: TPersistent);
begin
  FItems.Add(AItem);
  Changed;
end;

procedure TLMDSimplePropInspObjects.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TLMDSimplePropInspObjects.Changed;
begin
  FChanged := False;
  if FUpdateCount = 0 then
    FPropInsp.ObjectsChanged
  else
    FChanged := True;
end;

procedure TLMDSimplePropInspObjects.Clear;
begin
  FItems.Clear;
  Changed;
end;

constructor TLMDSimplePropInspObjects.Create(
  APropInsp: TLMDSimplePropInspector);
begin
  inherited Create;
  FPropInsp := APropInsp;
  FItems    := TList.Create;
end;

procedure TLMDSimplePropInspObjects.Delete(AIndex: Integer);
begin
  FItems.Delete(AIndex);
  Changed;
end;

destructor TLMDSimplePropInspObjects.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TLMDSimplePropInspObjects.EndUpdate;
begin
  Dec(FUpdateCount);
  if (FUpdateCount = 0) and FChanged then
    Changed;
end;

function TLMDSimplePropInspObjects.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TLMDSimplePropInspObjects.GetItem(
  AIndex: Integer): TPersistent;
begin
  Result := TPersistent(FItems[AIndex]);
end;

procedure TLMDSimplePropInspObjects.GetItems(AResult: TList);
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    AResult.Add(FItems[i]);
end;

function TLMDSimplePropInspObjects.IndexOf(
  AItem: TPersistent): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

procedure TLMDSimplePropInspObjects.Remove(AItem: TPersistent);
begin
  FItems.Remove(AItem);
  Changed;
end;

procedure TLMDSimplePropInspObjects.SetItems(AItems: TList);
var
  i: Integer;
begin
  FItems.Clear;
  for i := 0 to AItems.Count - 1 do
    FItems.Add(AItems[i]);
  Changed;
end;

procedure TLMDSimplePropInspObjects.SetOne(AItem: TPersistent);
begin
  FItems.Clear;
  if AItem <> nil then
    FItems.Add(AItem);
  Changed;
end;

procedure TLMDSimplePropInspector.SetObjects(AObjects: TList);
begin
  if FObjects <> nil then
    FObjects.SetItems(AObjects);
end;

{ TSimplePropInspEditorUtils }

constructor TSimplePropInspEditorUtils.Create(
  APropInsp: TLMDCustomPropertyInspector);
begin
  inherited Create;
  FPropInsp := APropInsp;
end;

procedure TSimplePropInspEditorUtils.GetObjects(AResult: TList);
begin
  if not IsReset then
    FPropInsp.GetObjects(AResult);
end;

function TSimplePropInspEditorUtils.GetUniqueCompName(
  AComp: TComponent): TLMDString;
begin
  Result := inherited GetUniqueCompName(AComp);
  FPropInsp.DoGetUniqueCompName(AComp, Result);
end;

procedure TSimplePropInspEditorUtils.MarkModified;
begin
  if not IsReset then
  begin
    FPropInsp.UpdateContent;
    FPropInsp.DoChange(nil);
  end;
end;

procedure TSimplePropInspEditorUtils.SetObjects(AObjects: TList);
begin
  if not IsReset then
    FPropInsp.SetObjects(AObjects);
end;

procedure TLMDCustomPropertyInspector.DoGetCompRef(AEditor: TLMDPropEditor;
  const ACompName: TLMDString; var AComponent: TComponent);
begin
  if Assigned(FOnGetCompRef) then
    FOnGetCompRef(Self, ACompName, AComponent);
end;

procedure TLMDCustomPropertyInspector.DoGetCompRefList(AEditor: TLMDPropEditor;
  AClass: TComponentClass; AResult: TList);
begin
  if Assigned(FOnGetCompRefList) then
    FOnGetCompRefList(Self, AClass, AResult);
end;

procedure TLMDCustomPropertyInspector.DoGetCompRefName(AEditor: TLMDPropEditor; 
  AComponent: TComponent; var AName: TLMDString);
begin
  if Assigned(FOnGetCompRefName) then
    FOnGetCompRefName(Self, AComponent, AName);
end;

function TLMDPropEditor.GetCompRef(const ACompName: TLMDString): TComponent;
begin
  Result := nil;
  FPropInsp.DoGetCompRef(Self, ACompName, Result);
end;

procedure TLMDPropEditor.GetCompRefList(AClass: TComponentClass;
  AResult: TList);
begin
  FPropInsp.DoGetCompRefList(Self, AClass, AResult);
end;

function TLMDPropEditor.GetCompRefName(AComponent: TComponent): TLMDString;
begin
  Result := '';
  FPropInsp.DoGetCompRefName(Self, AComponent, Result);
end;

procedure TLMDCustomPropertyInspector.DoEnsureEventHandlerSource(
  AEditor: TLMDPropEditor; const AName, AOldName: TLMDString;
  AEventTypeInfo: TLMDTypeInfo; AShowSource: Boolean);
begin
  if Assigned(FOnEnsureEventHandlerSource) then
    FOnEnsureEventHandlerSource(Self, AName, AOldName, AEventTypeInfo,
                                AShowSource);
end;

procedure TLMDCustomPropertyInspector.DoGetDefaultEventHandlerName(
  AEditor: TLMDPropEditor; AInstance: TPersistent;
  const AEventName: TLMDString; AEventTypeInfo: TLMDTypeInfo;
  var AResult: TLMDString);
begin
  if Assigned(FOnGetDefaultEventHandlerName) then
    FOnGetDefaultEventHandlerName(Self, AInstance, AEventName, AEventTypeInfo, AResult);
end;

procedure TLMDCustomPropertyInspector.DoGetEventValue(
  AEditor: TLMDPropEditor; AInstance: TPersistent; APropInfo: ILMDProperty;
  var AResult: TLMDString);
begin
  if Assigned(FOnGetEventValue) then
    FOnGetEventValue(Self, AInstance, APropInfo, AResult);
end;

procedure TLMDCustomPropertyInspector.DoGetExistingEventHandlers(
  AEditor: TLMDPropEditor; AEventTypeInfo: TLMDTypeInfo;
  AResult: TLMDStrings);
begin
  if Assigned(FOnGetExistingEventHandlers) then
    FOnGetExistingEventHandlers(Self, AEventTypeInfo, AResult);
end;

procedure TLMDCustomPropertyInspector.DoGetUniqueCompName(
  AComponent: TComponent; var AUniqueName: TLMDString);
begin
  if Assigned(FOnGetUniqueCompName) then
    FOnGetUniqueCompName(Self, AComponent.ClassName, AUniqueName);
end;

procedure TLMDCustomPropertyInspector.DoSetEventValue(
  AEditor: TLMDPropEditor; AInstance: TPersistent; APropInfo: ILMDProperty;
  const AValue: TLMDString);
begin
  if Assigned(FOnSetEventValue) then
    FOnSetEventValue(Self, AInstance, APropInfo, AValue);
end;

procedure TLMDPropEditor.GetExistingEventHandlers(AResult: TLMDStrings);
begin
  FPropInsp.DoGetExistingEventHandlers(Self, PropTypeInfo, AResult);
end;

procedure TLMDPropEditor.ShowEventHandler(const AValue: TLMDString);
begin
  FPropInsp.DoEnsureEventHandlerSource(Self, AValue, '', PropTypeInfo,
                                       True);
end;

function TLMDPropEditor.GetDefaultEventHandlerName(
  AIndex: Integer): TLMDString;
begin
  Result := '';
  FPropInsp.DoGetDefaultEventHandlerName(Self, GetInstance(0), PropName,
    PropTypeInfo, Result);
end;

procedure TLMDCustomPropertyInspector.RegisterStandardCategories;
begin
  BeginUpdate;
  try
    { Drag, Drop and Docking }

    RegisterPropCategory(SDragAndDropCategory, TControl, 'Drag*');
    RegisterPropCategory(SDragAndDropCategory, TControl, 'DockSite');
    RegisterPropCategory(SDragAndDropCategory, TControl, 'UseDockManager');

    { Help and Hints }

    RegisterPropCategory(SHelpAndHintsCategory, TControl, 'Help*');
    RegisterPropCategory(SHelpAndHintsCategory, TControl, 'Hint');
    RegisterPropCategory(SHelpAndHintsCategory, TControl, 'ShowHint');
    RegisterPropCategory(SHelpAndHintsCategory, TControl, 'ParentShowHint');

    { Layout }

    RegisterPropCategory(SLayoutCategory, TypeInfo(TAlign));
    RegisterPropCategory(SLayoutCategory, TypeInfo(TAnchors));
    RegisterPropCategory(SLayoutCategory, TControl, 'AutoSize');
    RegisterPropCategory(SLayoutCategory, TypeInfo(TSizeConstraints));
    RegisterPropCategory(SLayoutCategory, TControl, 'Left');
    RegisterPropCategory(SLayoutCategory, TControl, 'Top');
    RegisterPropCategory(SLayoutCategory, TControl, 'Width');
    RegisterPropCategory(SLayoutCategory, TControl, 'Height');
    RegisterPropCategory(SLayoutCategory, TControl, 'TabOrder');
    RegisterPropCategory(SLayoutCategory, TControl, 'TabStop');
    RegisterPropCategory(SLayoutCategory, TScrollingWinControl, 'AutoScroll');
    RegisterPropCategory(SLayoutCategory, TCustomForm, 'Scaled');

    { Linkage }

    RegisterPropCategory(SLinkageCategory, TypeInfo(TComponent));

    { Locale }

    RegisterPropCategory(SLocaleCategory, TypeInfo(TBiDiMode));
    RegisterPropCategory(SLocaleCategory, TControl, 'ParentBiDiMode');
    RegisterPropCategory(SLocaleCategory, TypeInfo(TImeMode));
    RegisterPropCategory(SLocaleCategory, TypeInfo(TImeName));

    { Input }

    RegisterPropCategory(SInputCategory, TControl, 'Enabled');
    RegisterPropCategory(SInputCategory, 'ReadOnly');
    RegisterPropCategory(SInputCategory, TCustomForm, 'KeyPreview');

    { Visual }

    RegisterPropCategory(SVisualCategory, TControl, 'Visible');
    RegisterPropCategory(SVisualCategory, TypeInfo(TBorderStyle));
    RegisterPropCategory(SVisualCategory, TypeInfo(TBevelEdges));
    RegisterPropCategory(SVisualCategory, TypeInfo(TBevelCut));
    RegisterPropCategory(SVisualCategory, TypeInfo(TBevelKind));
    RegisterPropCategory(SVisualCategory, TypeInfo(TBevelWidth));
    RegisterPropCategory(SVisualCategory, TypeInfo(TBorderWidth));
    RegisterPropCategory(SVisualCategory, TypeInfo(TFont));
    RegisterPropCategory(SVisualCategory, TypeInfo(TColor));
    RegisterPropCategory(SVisualCategory, TControl, 'ParentFont');
    RegisterPropCategory(SVisualCategory, TControl, 'ParentColor');
    RegisterPropCategory(SVisualCategory, TypeInfo(TCursor));
  finally
    EndUpdate;
  end;
end;

function ILMDProperty.GetFloatValue(Instance: TPersistent): Extended;
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

function ILMDProperty.GetInt64Value(Instance: TPersistent): Int64;
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

function ILMDProperty.GetObjectValue(Instance: TPersistent): TObject;
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

function ILMDProperty.GetOrdValue(Instance: TPersistent): Longint;
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

function ILMDProperty.GetStrValue(Instance: TPersistent): string;
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

function ILMDProperty.GetVariantValue(Instance: TPersistent): Variant;
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

function ILMDProperty.GetWideStrValue(Instance: TPersistent): WideString;
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

procedure ILMDProperty.SetFloatValue(Instance: TPersistent; AValue: Extended);
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

procedure ILMDProperty.SetInt64Value(Instance: TPersistent; AValue: Int64);
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

procedure ILMDProperty.SetObjectValue(Instance: TPersistent; AValue: TObject);
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

procedure ILMDProperty.SetOrdValue(Instance: TPersistent; AValue: Integer);
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

procedure ILMDProperty.SetStrValue(Instance: TPersistent;
  const AValue: string);
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

procedure ILMDProperty.SetVariantValue(Instance: TPersistent;
  const AValue: Variant);
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

procedure ILMDProperty.SetWideStrValue(Instance: TPersistent;
  const AValue: WideString);
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

{ TRTTIPropWrapper }

constructor TRTTIPropWrapper.Create(AOrigin: TLMDPropInfo);
begin
  inherited Create;
  FOrigin := AOrigin;
end;

destructor TRTTIPropWrapper.Destroy;
begin
  inherited;
end;

function TRTTIPropWrapper.GetFloatValue(Instance: TPersistent): Extended;
begin
  Result := GetFloatProp(Instance, FOrigin);
end;

function TRTTIPropWrapper.GetInt64Value(Instance: TPersistent): Int64;
begin
  Result := GetInt64Prop(Instance, FOrigin);
end;

function TRTTIPropWrapper.GetObjectValue(Instance: TPersistent): TObject;
begin
  Result := GetObjectProp(Instance, FOrigin);
end;

function TRTTIPropWrapper.GetOrdValue(Instance: TPersistent): Longint;
begin
  Result := GetOrdProp(Instance, FOrigin);
end;

function TRTTIPropWrapper.GetStrValue(Instance: TPersistent): string;
begin
  Result := GetStrProp(Instance, FOrigin);
end;

function TRTTIPropWrapper.GetVariantValue(Instance: TPersistent): Variant;
begin
  Result := GetVariantProp(Instance, FOrigin);
end;

function TRTTIPropWrapper.GetWideStrValue(Instance: TPersistent): WideString;
begin
  Result := GetWideStrProp(Instance, FOrigin);
end;

function TRTTIPropWrapper.IsDefaultValue(Instance: TPersistent): Boolean;
begin
  {$IFDEF LMDCOMP7}
  Result := not IsStoredProp(Instance, FOrigin) or
            IsDefaultPropertyValue(Instance, FOrigin, nil);
  {$ELSE}
  Result := True;
  {$ENDIF}
end;

function TRTTIPropWrapper.IsReadable: Boolean;
begin
  Result := (FOrigin.GetProc <> nil);
end;

function TRTTIPropWrapper.IsWritable: Boolean;
begin
  Result := (FOrigin.SetProc <> nil);
end;

function TRTTIPropWrapper.Name: TLMDString;
begin
  Result := {$IFDEF LMDCOMP12}UTF8ToString{$ENDIF}(FOrigin.Name);
end;

function TRTTIPropWrapper.PropType: TLMDTypeInfo;
begin
  Result := FOrigin.PropType^;
end;

function TRTTIPropWrapper.RTTIPropInfo: TLMDPropInfo;
begin
  Result := FOrigin;
end;

procedure TRTTIPropWrapper.SetFloatValue(Instance: TPersistent;
  AValue: Extended);
begin
  SetFloatProp(Instance, FOrigin, AValue);
end;

procedure TRTTIPropWrapper.SetInt64Value(Instance: TPersistent; AValue: Int64);
begin
  SetInt64Prop(Instance, FOrigin, AValue);
end;

procedure TRTTIPropWrapper.SetObjectValue(Instance: TPersistent;
  AValue: TObject);
begin
  SetObjectProp(Instance, FOrigin, AValue);
end;

procedure TRTTIPropWrapper.SetOrdValue(Instance: TPersistent; AValue: Integer);
begin
  SetOrdProp(Instance, FOrigin, AValue);
end;

procedure TRTTIPropWrapper.SetStrValue(Instance: TPersistent;
  const AValue: string);
begin
  SetStrProp(Instance, FOrigin, AValue);
end;

procedure TRTTIPropWrapper.SetVariantValue(Instance: TPersistent;
  const AValue: Variant);
begin
  SetVariantProp(Instance, FOrigin, AValue);
end;

procedure TRTTIPropWrapper.SetWideStrValue(Instance: TPersistent;
  const AValue: WideString);
begin
  SetWideStrProp(Instance, FOrigin, AValue);
end;

{ TRTTIPropWrapperTraits }

class function TRTTIPropWrapperTraits.Compare(const AKey;
  AItem: TObject): Boolean;
begin
  Result := (TLMDPropInfo(AKey) = TRTTIPropWrapper(AItem).FOrigin);
end;

class function TRTTIPropWrapperTraits.MakeHashI(AItem: TObject): Integer;
begin
  Result := MakeHashK(TRTTIPropWrapper(AItem).FOrigin);
end;

class function TRTTIPropWrapperTraits.MakeHashK(const AKey): Integer;
begin
  Result := TLMDHashTable.IntHash(TLMDPtrInt(TLMDPropInfo(AKey)));
end;

{ TLMDPropertyInspectorDefiner }

constructor TLMDPropertyInspectorDefiner.Create(
  AOwner: TLMDCustomPropertyInspector; AResult: TList);
begin
  inherited Create;
  FOwner    := AOwner;
  FResult   := AResult;
end;

procedure TLMDPropertyInspectorDefiner.DefineProperty(
  const AName: TLMDString; AType: TLMDTypeInfo; AIsReadable,
  AIsWritable: Boolean; AUserData: TLMDDataTag);
begin
  FResult.Add(TDynPropWrapper.Create(FOwner, AName, AType, AIsReadable,
                                     AIsWritable, AUserData));
end;

procedure TLMDCustomPropertyInspector.DoDynPropsDefine(
  AInstance: TPersistent; ADefiner: TLMDPropertyInspectorDefiner);
begin
  if Assigned(FOnDynPropsDefine) then
    FOnDynPropsDefine(Self, AInstance, ADefiner);
end;

{ TDynPropWrapper }

constructor TDynPropWrapper.Create(APropInsp: TLMDCustomPropertyInspector;
  const AName: TLMDString; AType: TLMDTypeInfo; AIsReadable,
  AIsWritable: Boolean; AUserData: TLMDDataTag);
begin
  inherited Create;
  
  FPropInsp   := APropInsp;;
  FName       := AName;
  FType       := AType;
  FIsReadable := AIsReadable;
  FIsWritable := AIsWritable;
  FUserData   := AUserData;
end;

function TDynPropWrapper.GetFloatValue(Instance: TPersistent): Extended;
begin
  Result := 0;
  GetValue(Instance, Result);
end;

function TDynPropWrapper.GetInt64Value(Instance: TPersistent): Int64;
begin
  Result := 0;
  GetValue(Instance, Result);
end;

function TDynPropWrapper.GetObjectValue(Instance: TPersistent): TObject;
begin
  Result := nil;
  GetValue(Instance, Result);
end;

function TDynPropWrapper.GetOrdValue(Instance: TPersistent): Longint;
begin
  Result := 0;
  GetValue(Instance, Result);
end;

function TDynPropWrapper.GetStrValue(Instance: TPersistent): string;
begin
  Result := '';
  GetValue(Instance, Result);
end;

procedure TDynPropWrapper.GetValue(Instance: TPersistent; var AResult);
var
  dres: TLMDPropertyInspectorDynValue;
begin
  dres := TLMDPropertyInspectorDynValue.Create(FType, @AResult, nil);
  try
    FPropInsp.DoDynPropGetValue(Instance, Self, FUserData, dres);
  finally
    dres.Free;
  end;
end;

function TDynPropWrapper.GetVariantValue(Instance: TPersistent): Variant;
begin
  Result := Unassigned;
  GetValue(Instance, Result);
end;

function TDynPropWrapper.GetWideStrValue(Instance: TPersistent): WideString;
begin
  Result := '';
  GetValue(Instance, Result);
end;

function TDynPropWrapper.IsDefaultValue(Instance: TPersistent): Boolean;
var
  buffer: packed array[0..16] of Byte;
  dval:   TLMDPropertyInspectorDynValue;
begin
  Result := True;

  FillChar(buffer, 16, 0);
  dval := TLMDPropertyInspectorDynValue.Create(FType, @buffer, @Result);
  try
    FPropInsp.DoDynPropGetValue(Instance, Self, FUserData, dval);
  finally
    dval.Free;
  end;

  // Buffered value is not needed, so we
  // should finalize the buffer.

  case FType.Kind of
    tkString:   string((@buffer)^)     := '';
    {$IFDEF LMDCOMP12}
    tkUString:  string((@buffer)^)     := '';
    {$ENDIF}
    tkLString:  string((@buffer)^)     := '';
    tkWString:  WideString((@buffer)^) := '';
    tkVariant:  Variant((@buffer)^)    := Unassigned;
  end;
end;

function TDynPropWrapper.IsReadable: Boolean;
begin
  Result := FIsReadable;
end;

function TDynPropWrapper.IsWritable: Boolean;
begin
  Result := FIsWritable;
end;

function TDynPropWrapper.Name: TLMDString;
begin
  Result := FName;
end;

function TDynPropWrapper.PropType: TLMDTypeInfo;
begin
  Result := FType;
end;

procedure TDynPropWrapper.SetFloatValue(Instance: TPersistent;
  AValue: Extended);
begin
  SetValue(Instance, AValue);
end;

procedure TDynPropWrapper.SetInt64Value(Instance: TPersistent; AValue: Int64);
begin
  SetValue(Instance, AValue);
end;

procedure TDynPropWrapper.SetObjectValue(Instance: TPersistent;
  AValue: TObject);
begin
  SetValue(Instance, AValue);
end;

procedure TDynPropWrapper.SetOrdValue(Instance: TPersistent; AValue: Integer);
begin
  SetValue(Instance, AValue);
end;

procedure TDynPropWrapper.SetStrValue(Instance: TPersistent;
  const AValue: string);
begin
  SetValue(Instance, AValue);
end;

procedure TDynPropWrapper.SetValue(Instance: TPersistent; const AValue);
var
  dval: TLMDPropertyInspectorDynValue;
begin
  dval := TLMDPropertyInspectorDynValue.Create(FType, @AValue, nil);
  try
    FPropInsp.DoDynPropSetValue(Instance, Self, FUserData, dval);
  finally
    dval.Free;
  end;
end;

procedure TDynPropWrapper.SetVariantValue(Instance: TPersistent;
  const AValue: Variant);
begin
  SetValue(Instance, AValue);
end;

procedure TDynPropWrapper.SetWideStrValue(Instance: TPersistent;
  const AValue: WideString);
begin
  SetValue(Instance, AValue);
end;

procedure TLMDPropertyInspectorDynValue.CheckType(AKinds: TTypeKinds);
begin
  if not (FType.Kind in AKinds) then
    raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [FType.Name]);
end;

constructor TLMDPropertyInspectorDynValue.Create(AType: TLMDTypeInfo;
  ABuffer: Pointer; AIsDefault: PBoolean);
begin
  inherited Create;

  FType      := AType;
  FBuffer    := ABuffer;
  FIsDefault := AIsDefault;
end;

function TLMDPropertyInspectorDynValue.GetAsFloat: Extended;
begin
  CheckType([tkFloat]);
  Result := Extended(FBuffer^);
end;

function TLMDPropertyInspectorDynValue.GetAsInt64: Int64;
begin
  CheckType([tkInt64]);
  Result := Int64(FBuffer^);
end;

function TLMDPropertyInspectorDynValue.GetAsObject: TObject;
begin
  CheckType([tkClass]);
  Result := TObject(FBuffer^);
end;

function TLMDPropertyInspectorDynValue.GetAsOrd: Longint;
begin
  CheckType([tkInteger, tkChar, tkWChar, tkEnumeration, tkSet]);
  Result := Longint(FBuffer^);
end;

function TLMDPropertyInspectorDynValue.GetAsStr: string;
begin
  Result := ''; // Initialize.
  CheckType([tkString, {$IFDEF LMDCOMP12}tkUString,{$ENDIF}
             tkLString, tkWString]);
  case FType.Kind of
    tkString,
    {$IFDEF LMDCOMP12}
    tkUString,
    {$ENDIF}
    tkLString: Result := string(FBuffer^);
    tkWString: Result := WideString(FBuffer^);
  end;
end;

function TLMDPropertyInspectorDynValue.GetAsVariant: Variant;
begin
  CheckType([tkVariant]);
  Result := Variant(FBuffer^);
end;

function TLMDPropertyInspectorDynValue.GetAsWideStr: WideString;
begin
  Result := ''; // Initialize.
  CheckType([tkString, {$IFDEF LMDCOMP12}tkUString,{$ENDIF}
             tkLString, tkWString]);
  case FType.Kind of
    tkString,
    {$IFDEF LMDCOMP12}
    tkUString,
    {$ENDIF}
    tkLString: Result := string(FBuffer^);
    tkWString: Result := WideString(FBuffer^);
  end;
end;

function TLMDPropertyInspectorDynValue.GetIsDefault: Boolean;
begin
  Result := True;
  if FIsDefault <> nil then
    Result := FIsDefault^;
end;

procedure TLMDPropertyInspectorDynValue.SetAsFloat(AValue: Extended);
begin
  CheckType([tkFloat]);
  Extended(FBuffer^) := AValue;
end;

procedure TLMDPropertyInspectorDynValue.SetAsInt64(AValue: Int64);
begin
  CheckType([tkInt64]);
  Int64(FBuffer^) := AValue;
end;

procedure TLMDPropertyInspectorDynValue.SetAsObject(AValue: TObject);
begin
  CheckType([tkClass]);
  TObject(FBuffer^) := AValue;
end;

procedure TLMDPropertyInspectorDynValue.SetAsOrd(AValue: Longint);
begin
  CheckType([tkInteger, tkChar, tkWChar, tkEnumeration, tkSet]);
  Longint(FBuffer^) := AValue;
end;

procedure TLMDPropertyInspectorDynValue.SetAsStr(const AValue: string);
begin
  CheckType([tkString, {$IFDEF LMDCOMP12}tkUString,{$ENDIF}
             tkLString, tkWString]);
  case FType.Kind of
    tkString,
    {$IFDEF LMDCOMP12}
    tkUString,
    {$ENDIF}
    tkLString: string(FBuffer^)     := AValue;
    tkWString: WideString(FBuffer^) := AValue;
  end;
end;

procedure TLMDPropertyInspectorDynValue.SetAsVariant(
  const AValue: Variant);
begin
  CheckType([tkVariant]);
  Variant(FBuffer^) := AValue;
end;

procedure TLMDPropertyInspectorDynValue.SetAsWideStr(
  const AValue: WideString);
begin
  CheckType([tkString, {$IFDEF LMDCOMP12}tkUString,{$ENDIF}
             tkLString, tkWString]);
  case FType.Kind of
    tkString,
    {$IFDEF LMDCOMP12}
    tkUString,
    {$ENDIF}
    tkLString: string(FBuffer^)     := AValue;
    tkWString: WideString(FBuffer^) := AValue;
  end;
end;

procedure TLMDCustomPropertyInspector.DoDynPropGetValue(
  AInstance: TPersistent; AProperty: ILMDProperty; AUserData: TLMDDataTag;
  AResult: TLMDPropertyInspectorDynValue);
begin
  if Assigned(FOnDynPropGetValue) then
    FOnDynPropGetValue(Self, AInstance, AProperty, AUserData, AResult);
end;

procedure TLMDPropertyInspectorDynValue.SetIsDefault(AValue: Boolean);
begin
  if FIsDefault <> nil then
    FIsDefault^ := AValue; 
end;

procedure TLMDCustomPropertyInspector.DoDynPropSetValue(
  AInstance: TPersistent; AProperty: ILMDProperty; AUserData: TLMDDataTag;
  AValue: TLMDPropertyInspectorDynValue);
begin
  if Assigned(FOnDynPropSetValue) then
    FOnDynPropSetValue(Self, AInstance, AProperty, AUserData, AValue);
end;

function ILMDProperty.RTTIPropInfo: TLMDPropInfo;
begin
  raise EPropertyConvertError.CreateResFmt(@SInvalidPropertyType, [Name]);
end;

initialization
  RTTIPropWrapperMap := TLMDHashTable.Create(TRTTIPropWrapperTraits, True);

finalization
  RTTIPropWrapperMap.Free;

end.
