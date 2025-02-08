unit ElRTTIInspector;
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

ElRTTIInspector unit
--------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface
uses
  SysUtils,
  Windows,
  Messages,
  Classes,
  Graphics,
  Controls,
  TypInfo,
  Dialogs,
  LMDTypes,
  LMDElConst,
  ElInspector,
  LMDUnicodeStrings,
  ElStack,
  ElVCLUtils,
  LMDObjectList,
  ElPropTools,
  ElInspectorEditors;

type
  TElPropertyData = class;
  TElSetProperty = class;

  TElTypeKinds = (etkProperties, etkMethods, etkAny);

  TElInspectorProp = class(TElInspectorRegister)
  protected
    FName: string;
    FParentClass: TClass;
    FTypeInfo: PTypeInfo;
  public
    constructor Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData; const AParentClass: TClass; const AName: string; const ATypeInfo: PTypeInfo);
    property Name: string read FName write FName;
    property ParentClass: TClass read FParentClass write FParentClass;
    property TypeInfo: PTypeInfo read FTypeInfo write FTypeInfo;
  end;

  TElInspectorInherits = class(TElInspectorRegister)
  protected
    FParentClass: TClass;
  public
    constructor Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData; const AParent: TClass);
    property ParentClass: TClass read FParentClass write FParentClass;
  end;

  TElInspectorTypeKind = class(TElInspectorRegister)
  protected
    FTypeKind: TTypeKind;
  public
    constructor Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData; const ATypeKind: TTypeKind);
    property TypeKind: TTypeKind read FTypeKind write FTypeKind;
  end;

  TElInspectorTypeInfo = class(TElInspectorRegister)
  protected
    FTypeInfo: PTypeInfo;
  public
    constructor Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData; const ATypeinfo: PTypeInfo);
    property TypeInfo: PTypeInfo read FTypeInfo write FTypeInfo;
  end;

  TElRTTIClassList = class (TElInspectorClassesList)
  public
    function GetNeededData(const PropInfo: PPropInfo): TElInspectorRegister;
    function GetNeededEditor(const AItem: TElInspectorItem): TElInspectorRegister; override;
  end;

  TElRTTIClassEnumerator = class (TElEnumerator)
  protected
    FCurrent: Integer;
    FInstance: TObject;
    FPropCount: Integer;
    FPropList: PPropList;
    FTypeKinds: TTypeKinds;
  public
    constructor Create;
    function GetFirstItem: TElInspectorData; override;
    function GetNextItem: TElInspectorData; override;
    property Instance: TObject read FInstance write FInstance;
    property TypeKinds: TTypeKinds read FTypeKinds write FTypeKinds default tkProperties;
  end;

  TElRTTISetEnumerator = class (TElEnumerator)
  protected
    FCurrent: Integer;
    FInstance: TObject;
    FParentSet: TElSetProperty;
  public
    function GetFirstItem: TElInspectorData; override;
    function GetNextItem: TElInspectorData; override;
    property Instance: TObject read FInstance write FInstance;
  end;

  TElInspectorRTTIDataSource = class(TElInspectorDataSource)
  protected
    FCategories: TElCategories;
    FElRegClass: TElInspectorClassesList;
    FInstance: TComponent;
    FObjectInstance: TObject;
    FStack: TElStack;
    FTypeKinds: TTypeKinds;
    FTreeList: TLMDObjectList;
    FElTypeKinds: TElTypeKinds;
    function GetCategories: TElCategories; override;
    function GetRegClass: TElInspectorClassesList; override;
    function IsInStack(AInstance: TObject): Boolean;
    function PopInstance: TObject;
    procedure SetElTypeKind(const Value: TElTypeKinds);
    procedure PushInstance(AInstance: TObject);
    procedure SetCategories(const Value: TElCategories); override;
    procedure SetInspector(const Value: TElInspector);
    procedure SetInstance(const Value: TComponent);
    procedure SetObjectInstance(const Value: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearItemIndex; override;
    function CreateEnumerator(Item: TElInspectorData): TElEnumerator; override;
    procedure DestroyEnumerator(AEnum: TElEnumerator); override;
    property RegisterList: TElInspectorClassesList read GetRegClass;
    property TypeKinds: TTypeKinds read FTypeKinds write FTypeKinds;

    property ObjectInstance: TObject read FObjectInstance write SetObjectInstance;
  published
    property Categories;
    property Instance: TComponent read FInstance write SetInstance;
    property ElTypeKinds: TElTypeKinds read FElTypeKinds write SetElTypeKind;
  end;

  TElPropertyData = class(TElInspectorData)
  protected
    FDisplayName: TLMDString;
    FInstance: TObject;
    FName: TLMDString;
    FPropertyInfo: PPropInfo;
    FValue: TLMDString;
    function GetAsOrd: LongInt; virtual;
    function GetAsString: TLMDString; override; abstract;
    function GetIsDefault: Boolean; override;
    function GetIsReadOnly: Boolean; override;
    function GetName: TLMDString; override;
    function GetPropertyType: PTypeInfo;
    function GetTypeKind: TTypeKind;
    procedure SetAsOrd(Value: Longint); virtual;
    procedure SetAsString(Value: TLMDString); override; abstract;
  public
    function CheckNotReadOnly: Boolean;
    function GetValuesList(const AList: TLMDStrings): Integer; override;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInt64: Int64 read GetAsInt64 write SetAsInt64;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsMethod: TMethod read GetAsMethod write SetAsMethod;
    property AsObject: TObject read GetAsObject write SetAsObject;
    property AsString: TLMDString read GetAsString write SetAsString;
    property AsVariant: Variant read GetAsVariant write SetAsVariant;
    property DisplayName: TLMDString read GetDisplayName write SetDisplayName;
    property Instance: TObject read FInstance write FInstance;
    property IsComplex: Boolean read GetIsComplex;
    property IsDefault: Boolean read GetIsDefault;
    property IsEnumerable: Boolean read GetIsEnumerable;
    property IsReadOnly: Boolean read GetIsReadOnly;
    property MaxValue: Integer read GetMaxValue;
    property MinValue: Integer read GetMinValue;
    property Name: TLMDString read GetName;
    property PropertyInfo: PPropInfo read FPropertyInfo write FPropertyInfo;
    property PropertyType: PTypeInfo read GetPropertyType;
    property Value: TLMDString read GetAsString write SetAsString;
  end;

  TElUnknowProperty = class (TElPropertyData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElOrdProperty = class (TElPropertyData)
  protected
    function GetAsOrd: LongInt; override;
    function GetAsString: TLMDString; override;
    function GetMaxValue: Integer; override;
    function GetMinValue: Integer; override;
    procedure SetAsOrd(Value: Integer); override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElEnumProperty = class (TElOrdProperty)
  protected
    function GetAsString: TLMDString; override;
    function GetIsEnumerable: Boolean; override;
    procedure SetAsString(Value: TLMDString); override;
  public
    function GetValuesList(const AList: TLMDStrings): Integer; override;
  end;

  TElBooleanProperty = class (TElEnumProperty)
  end;

  TElCharProperty = class (TElOrdProperty)
  end;

  TElClassProperty = class (TElPropertyData)
  protected
    function GetAsObject: TObject; override;
    function GetAsString: TLMDString; override;
    function GetIsComplex: Boolean; override;
    procedure SetAsObject(Value: TObject); override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElComponentProperty = class (TElClassProperty)
  protected
    function GetIsComplex: Boolean; override;
    function GetIsEnumerable: Boolean; override;
    function GetAsString: TLMDString; override;
    function GetIsReference: Boolean; override;
    procedure SetAsObject(Value: TObject); override;
    procedure SetAsString(Value: TLMDString); override;
  public
    function GetValuesList(const AList: TLMDStrings): Integer; override;
  end;

  TElFontProperty = class (TElClassProperty)
  end;

  TElInt64Property = class (TElPropertyData)
  protected
    function GetAsInt64: Int64; override;
    function GetAsString: TLMDString; override;
    procedure SetAsInt64(Value: Int64); override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElStringProperty = class (TElPropertyData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElWideStringProperty = class (TElPropertyData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElCaptionProperty = class (TElStringProperty)
  end;

  TElIntegerProperty = class (TElOrdProperty)
  end;

  TElColorProperty = class (TElIntegerProperty)
  protected
    function GetAsString: TLMDString; override;
    function GetIsEnumerable: Boolean; override;
    procedure SetAsString(Value: TLMDString); override;
  public
    function GetValuesList(const AList: TLMDStrings): Integer; override;
  end;

  TElFloatProperty = class (TElPropertyData)
  protected
    function GetAsFloat: Double; override;
    function GetAsString: TLMDString; override;
    procedure SetAsFloat(Value: Double); override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElCharsetProperty = class (TElIntegerProperty)
  protected
    function GetAsString: TLMDString; override;
    function GetIsEnumerable: Boolean; override;
    procedure SetAsString(Value: TLMDString); override;
  public
    function GetValuesList(const AList: TLMDStrings): Integer; override;
  end;

  TElCursorProperty = class (TElIntegerProperty)
  protected
    function GetAsString: TLMDString; override;
    function GetIsEnumerable: Boolean; override;
    procedure SetAsString(Value: TLMDString); override;
  public
    function GetValuesList(const AList: TLMDStrings): Integer; override;
  end;

  TElSetProperty = class (TElOrdProperty)
  protected
    function GetAsString: TLMDString; override;
    function GetIsComplex: Boolean; override;
    function GetMaxValue: Integer; override;
    function GetMinValue: Integer; override;
    function GetTypeInfo: PTypeInfo;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElSetElementProperty = class (TElBooleanProperty)
  protected
    FParentSet: TElSetProperty;
    FSetIndex: Integer;
    function GetAsBoolean: Boolean; override;
    function GetAsString: TLMDString; override;
    function GetName: TLMDString; override;
    function GetTypeInfo: PTypeInfo;
    procedure SetAsBoolean(Value: Boolean); override;
    procedure SetAsString(Value: TLMDString); override;
  public
    function GetValuesList(const AList: TLMDStrings): Integer; override;
    property ParentSet: TElSetProperty read FParentSet write FParentSet;
    property SetIndex: Integer read FSetIndex write FSetIndex;
  end;

  TElMethodProperty = class (TElPropertyData)
  protected
    function GetAsMethod: TMethod; override;
    function GetAsString: TLMDString; override;
    function GetIsEnumerable: Boolean; override;
    procedure SetAsMethod(Value: TMethod); override;
    procedure SetAsString(Value: TLMDString); override;
  public
    function GetValuesList(const AList: TLMDStrings): Integer; override;
  end;

  TElIdentProperty = class (TElIntegerProperty)
  protected
    FIdentToInt: TIdentToInt;
    FIntToIdent: TIntToIdent;
    function GetAsString: TLMDString; override;
    function GetIsEnumerable: Boolean; override;
    procedure SetAsString(Value: TLMDString); override;
  public
    constructor Create; 
    function GetValuesList(const AList: TLMDStrings): Integer; override;
  end;

  TSetElement = class(TPersistent)
  public
    PropInfo: PPropInfo;
  end;

implementation
uses
  LMDUtils;
{-**********************************************************************
   Class:    TElInspectorInherits
***********************************************************************-}
constructor TElInspectorInherits.Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData; const AParent: TClass);
begin
  inherited Create(AClass, AInspData);
  FParentClass := AParent;
end;

{-**********************************************************************
   Class:    TElRTTISetEnumerator
***********************************************************************-}
function TElRTTISetEnumerator.GetFirstItem: TElInspectorData;
begin
  if not Assigned(FInstance) then
    raise EElInpectorError.Create(SElInstanceIsNotDefined);
  FCurrent := FParentSet.MinValue;
  Result := GetNextItem;
end;

function TElRTTISetEnumerator.GetNextItem: TElInspectorData;
var
  LTItem: TElPropertyData;
begin
  Result := nil;
  if FCurrent <= FParentSet.MaxValue then
  begin
    LTItem := TElSetElementProperty.Create;
    LTItem.Instance := FParentSet.FInstance;
    LTItem.PropertyInfo := FParentSet.FPropertyInfo;
    TElSetElementProperty(LTItem).FParentSet := FParentSet;
    TElSetElementProperty(LTItem).FSetIndex := FCurrent;
    Result := LTItem;
    Inc(FCurrent);
  end;
end;

{-**********************************************************************
   Class:    TElInspectorRTTIDataSource
***********************************************************************-}
constructor TElInspectorRTTIDataSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategories := TElCategories.Create(TElCategory);
  FElRegClass := TElRTTIClassList.Create;
  FElRegClass.AutoClearObjects := True;
  FElTypeKinds := etkProperties;
  FTreeList := TLMDObjectList.Create;
  FTreeList.AutoClearObjects := True;
  with FElRegClass do
  begin
    Add(TElInspectorTypeInfo.Create(nil, TElUnknowProperty, nil));

    Add(TElInspectorTypeInfo.Create(TElInspectorInplaceColorCombo, TElColorProperty, TypeInfo(TColor)));
    Add(TElInspectorTypeInfo.Create(TElInspectorInplaceComboBox, TElBooleanProperty, TypeInfo(Boolean)));
    Add(TElInspectorTypeInfo.Create(TElInspectorInplaceComboBox, TElBooleanProperty, TypeInfo(WordBool)));
    Add(TElInspectorTypeInfo.Create(TElInspectorInplaceComboBox, TElBooleanProperty, TypeInfo(LongBool)));
    Add(TElInspectorTypeInfo.Create(TElInspectorInplaceComboBox, TElCursorProperty, TypeInfo(TCursor)));

    Add(TElInspectorTypeInfo.Create(TElInspectorInplaceComboBox, TElSetElementProperty, TypeInfo(TSetElement)));
    Add(TElInspectorTypeInfo.Create(TElInspectorInplaceComboBox, TElCharsetProperty, TypeInfo(TFontCharset)));
    Add(TElInspectorTypeInfo.Create(TElInspectorInplaceFontEdit, TElFontProperty, TypeInfo(TFont)));
    Add(TElInspectorTypeInfo.Create(TElInspectorInplaceButtonEdit, TElCaptionProperty, TypeInfo(TCaption)));

    Add(TElInspectorInherits.Create(TElInspectorInplaceComboBox, TElComponentProperty, TComponent));
    Add(TElInspectorInherits.Create(TElInspectorInplaceStringsEdit, TElClassProperty, TStrings));
    {$ifdef LMD_UNICODE}
    Add(TElInspectorInherits.Create(TElInspectorInplaceStringsEdit, TElClassProperty, TLMDWideStrings));
    {$endif}
    Add(TElInspectorInherits.Create(TElInspectorInplacePictureEdit, TElClassProperty, TIcon));
    Add(TElInspectorInherits.Create(TElInspectorInplacePictureEdit, TElClassProperty, TPicture));
    Add(TElInspectorInherits.Create(TElInspectorInplacePictureEdit, TElClassProperty, TBitmap));

    Add(TElInspectorInherits.Create(nil, TElClassProperty, TObject));

    Add(TElInspectorTypeKind.Create(TElInspectorInplaceComboBox, TElMethodProperty, tkMethod));
    Add(TElInspectorTypeKind.Create(TElInspectorInplaceSpinEdit, TElIntegerProperty, tkInteger));
    Add(TElInspectorTypeKind.Create(TElInspectorInplaceFloatSpinEdit, TElFloatProperty, tkFloat));
    Add(TElInspectorTypeKind.Create(TElInspectorInplaceComboBox, TElEnumProperty, tkEnumeration));

    Add(TElInspectorTypeKind.Create(nil, TElSetProperty, tkSet));

    Add(TElInspectorTypeKind.Create(TElInspectorInplaceEdit, TElStringProperty, tkString));
    Add(TElInspectorTypeKind.Create(TElInspectorInplaceEdit, TElWideStringProperty, tkWString));
    Add(TElInspectorTypeKind.Create(TElInspectorInplaceEdit, TElWideStringProperty, tkLString));

//    Add(TElInspectorTypeInfo.Create(TElInspectorInplaceButtonEdit, TElCaptionProperty, TypeInfo(TLMDString)));
  end;
end;

procedure TElInspectorRTTIDataSource.SetInspector(const Value: TElInspector);
begin
  //
end;

destructor TElInspectorRTTIDataSource.Destroy;
begin
  inherited;
  FElRegClass.Free;
  FCategories.Free;
  FTreeList.Free;
end;

function TElInspectorRTTIDataSource.GetCategories: TElCategories;
begin
  Result := FCategories;
end;

function TElInspectorRTTIDataSource.GetRegClass: TElInspectorClassesList;
begin
  Result := FElRegClass;
end;

function TElInspectorRTTIDataSource.IsInStack(AInstance: TObject): Boolean;
var
  i: Integer;
begin
  Result := False;
  if Assigned(FStack) then
    for i := 0 to FStack.Count - 1 do
      if Ainstance = FStack.Items[i] then
      begin
        Result := True;
        break;
      end;
end;

function TElInspectorRTTIDataSource.PopInstance: TObject;
begin
  Result := nil;
  if Assigned(FStack) then
  begin
    Result := FStack.Pop;
    if FStack.Count = 0 then
      FreeAndNil(FStack);
  end;
end;

procedure TElInspectorRTTIDataSource.PushInstance(AInstance: TObject);
begin
  if not Assigned(FStack) then
    FStack := TElStack.Create;
  FStack.Push(AInstance);
end;

procedure TElInspectorRTTIDataSource.SetElTypeKind(const Value: TElTypeKinds);
begin
  case Value of
    etkProperties: FTypeKinds := tkProperties;
    etkMethods: FTypeKinds := tkMethods;
    etkAny: FTypeKinds := tkAny;
  end;
//  if Assigned(FInspector) then
//    FInspector.Rebuild(nil);
  if FInspectors.Count > 0 then
    NotifyInspectors(iRebuildInspector);
  FElTypeKinds := Value;
end;

procedure TElInspectorRTTIDataSource.SetCategories(const Value: TElCategories);
begin
  if FCategories <> Value then
  begin
    FCategories := Value;
    //DoRebuildInspector;
  end;
end;

procedure TElInspectorRTTIDataSource.SetInstance(const Value: TComponent);
begin
  if (Value <> nil) then
  begin
    FObjectInstance := nil;
    FInstance := Value;
    TComponent(FInstance).FreeNotification(Self);
    if FInspectors.Count > 0 then
      NotifyInspectors(iRebuildInspector);
  end;
end;

procedure TElInspectorRTTIDataSource.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = FInstance) and (Operation = opRemove) then
    FInstance := nil;
end;

procedure TElInspectorRTTIDataSource.ClearItemIndex;
var
  i: Integer;
begin
  for i := 0 to Categories.Count - 1 do
    Categories.Items[i].CategoryItem := nil;
end;

function TElInspectorRTTIDataSource.CreateEnumerator(Item: TElInspectorData): TElEnumerator;
var
  LInst: TObject;
begin
  Result := nil;

  if not Assigned(Item) or (TElPropertyData(Item).GetTypeKind = tkClass) then
  begin
    if Assigned(Item) then
      LInst := TElClassProperty(Item).AsObject
    else
      begin
      { TODO -oJAVIER : NEW CODE }
      if Assigned(FInstance) then
        LInst := FInstance
      else
        LInst := FObjectInstance;
      end;

    if not IsInStack(LInst) then
    begin
      Result := TElRTTIClassEnumerator.Create;
      Result.Owner := Self;
      TElRTTIClassEnumerator(Result).FInstance := LInst;
      TElRTTIClassEnumerator(Result).TypeKinds := TypeKinds;
      PushInstance(LInst);
    end;
  end;

  if (Item is TElSetProperty) then
  begin
    Result := TElRTTISetEnumerator.Create;
    Result.Owner := Self;
    { TODO -oJAVIER : NEW CODE }
    if Assigned( FInstance) then
      TElRTTISetEnumerator(Result).FInstance := FInstance
    else
      TElRTTISetEnumerator(Result).FInstance := FObjectInstance;

    TElRTTISetEnumerator(Result).FParentSet := TElSetProperty(Item);
  end;

end;

procedure TElInspectorRTTIDataSource.DestroyEnumerator(AEnum: TElEnumerator);
begin
  if (AEnum is TElRTTIClassEnumerator) then
    PopInstance;
  AEnum.Free;
end;

{-**********************************************************************
   Class:    TElPropertyData
***********************************************************************-}
function TElPropertyData.GetAsOrd: LongInt;
begin
  raise EElInpectorError.CreateFmt(SElCantGetThisPropAs, ['Ordinal type']);
end;

function TElPropertyData.GetIsDefault: Boolean;
begin
  Result := False;
  if (GetTypeKind = tkClass) then
  begin
    if (GetPropList(FPropertyInfo^.PropType^, tkProperties, nil) = 0) or (not Assigned(FInstance)) then
    begin
      Result := False;
      Exit;
    end;
  end;
  if not ((FPropertyInfo^.Default <> LongInt($80000000)) and (GetOrdProp(FInstance, FPropertyInfo) = FPropertyInfo^.Default)) then
  if IsStoredProp(FInstance, FPropertyInfo) then
      Result := True;
end;

function TElPropertyData.GetIsReadOnly: Boolean;
begin
  Result := (not Assigned(FPropertyInfo^.SetProc));
  end;

function TElPropertyData.GetName: TLMDString;
begin
  Result := TLMDString(FPropertyInfo^.Name);
end;

function TElPropertyData.GetPropertyType: PTypeInfo;
begin
  Result := FPropertyInfo^.PropType^;
end;

function TElPropertyData.GetTypeKind: TTypeKind;
begin
  Result := FPropertyInfo^.PropType^.Kind;
end;

procedure TElPropertyData.SetAsOrd(Value: Longint);
begin
  raise EElInpectorError.CreateFmt(SElCantSetThisPropAs, ['Ordinal type']);
end;

function TElPropertyData.CheckNotReadOnly: Boolean;
begin
  Result := not GetIsReadOnly;
  if not Result then
    raise EElInpectorError.CreateFmt(SElReadonly, [Name]);
end;

function TElPropertyData.GetValuesList(const AList: TLMDStrings): Integer;
begin
  raise EElInpectorError.CreateFmt(SElIsNotEnum, [Name]);
end;

{-**********************************************************************
   Class:    TElOrdProperty
***********************************************************************-}
function TElOrdProperty.GetAsOrd: LongInt;
begin
  Result := GetOrdProp(FInstance, PropertyInfo);
end;

function TElOrdProperty.GetAsString: TLMDString;
begin
  Result := IntToStr(GetAsOrd);
end;

function TElOrdProperty.GetMaxValue: Integer;
begin
  Result := GetTypeData(PropertyType)^.MaxValue;
end;

function TElOrdProperty.GetMinValue: Integer;
begin
  Result := GetTypeData(PropertyType)^.MinValue;
end;

procedure TElOrdProperty.SetAsOrd(Value: Integer);
begin
  if CheckNotReadOnly then
    SetOrdProp(FInstance, FPropertyInfo, Value);
end;

procedure TElOrdProperty.SetAsString(Value: TLMDString);
begin
  SetAsOrd(StrToInt(Value));
end;

{-**********************************************************************
   Class:    TElInspectorTypeKind
***********************************************************************-}
constructor TElInspectorTypeKind.Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData; const ATypeKind: TTypeKind);
begin
  inherited Create(AClass, AInspData);
  FTypeKind := ATypeKind;
end;

{-**********************************************************************
   Class:    TElInspectorTypeInfo
***********************************************************************-}
constructor TElInspectorTypeInfo.Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData; const ATypeinfo: PTypeInfo);
begin
  inherited Create(AClass, AInspData);
  FTypeInfo := ATypeinfo;
end;

{-**********************************************************************
   Class:    TElEnumProperty
***********************************************************************-}
function TElEnumProperty.GetAsString: TLMDString;
begin
  Result := GetEnumName(PropertyType, GetAsOrd);
end;

function TElEnumProperty.GetIsEnumerable: Boolean;
begin
  Result := True;
end;

procedure TElEnumProperty.SetAsString(Value: TLMDString);
begin
  SetEnumProp(FInstance, FPropertyInfo, Value);
  end;

function TElEnumProperty.GetValuesList(const AList: TLMDStrings): Integer;
var
  i: Integer;
begin
  Result := -1;
  AList.Clear;
  for i := MinValue to MaxValue do
  begin
    AList.Add(GetEnumName(PropertyType, i));
    if i = GetAsOrd then
      Result := i;
  end;
end;

{-**********************************************************************
   Class:    TElRTTIClassEnumerator
***********************************************************************-}
constructor TElRTTIClassEnumerator.Create;
begin
  inherited;
end;

function TElRTTIClassEnumerator.GetFirstItem: TElInspectorData;
begin
  FCurrent := 0;
  FPropCount := 0;
  Result := nil;
  if Assigned(FInstance) and (FInstance.ClassInfo <> nil) then
  begin
    FPropCount := GetPropList(FInstance.ClassInfo, TypeKinds, nil);
    GetMem(FPropList, FPropCount * SizeOf(PPropInfo));
    GetPropList(FInstance.ClassInfo, TypeKinds, FPropList);
    Result := GetNextItem;
  end;
end;

function TElRTTIClassEnumerator.GetNextItem: TElInspectorData;
var
  LTItem: TElPropertyData;
begin
  if FCurrent < FPropCount then
  begin
    LTItem := TElPropertyData(TElRTTIClassList(Owner.RegisterList).GetNeededData(FPropList^[FCurrent]).InspectorData.Create);

    LTItem.PropertyInfo := FPropList^[FCurrent];
    if TypeKinds = [tkMethod, tkClass] then
    begin
      while (FCurrent < FPropCount) do
      begin
        if (LTItem is TElComponentProperty) or (LTItem is TElMethodProperty) then
          break;
        Inc(FCurrent);
        LTItem.Free;
        LTItem := TElPropertyData(TElRTTIClassList(Owner.RegisterList).GetNeededData(FPropList^[FCurrent]).InspectorData.Create);
        LTItem.PropertyInfo := FPropList^[FCurrent];
      end;

      if FCurrent >= FPropCount then
      begin
        FreeAndNil(LTItem);
        FreeMem(FPropList);
      end;
    end;

    if Assigned(LTItem) then
      LTItem.FInstance := FInstance;

    Result := LTItem;
    Inc(FCurrent);
  end
  else
  begin
    Result := nil;
    if Assigned(FPropList) then
      FreeMem(FPropList);
  end;
end;

{-**********************************************************************
   Class:    TElClassProperty
***********************************************************************-}
function TElClassProperty.GetAsObject: TObject;
begin
  Result := GetObjectProp(FInstance, FPropertyInfo);
  end;

function TElClassProperty.GetAsString: TLMDString;
var
  LObj: TObject;
begin
  LObj := GetAsObject;
  if Assigned(LObj) then
    Result := GetTypeData(PropertyType).ClassType.ClassName
  else
    Result := TLMDString(PropertyType.Name);
  Result := '('+Result+')';
end;

function TElClassProperty.GetIsComplex: Boolean;
begin
  Result := True;
end;

procedure TElClassProperty.SetAsObject(Value: TObject);
begin
  if CheckNotReadOnly then
    SetObjectProp(FInstance, FPropertyInfo, Value);
    end;

procedure TElClassProperty.SetAsString(Value: TLMDString);
begin
  raise EElInpectorError.CreateFmt(SElCantSetThisPropAs, ['String']);
end;

{-**********************************************************************
   Class:    TElComponentProperty
***********************************************************************-}
function TElComponentProperty.GetIsComplex: Boolean;
begin
  Result := True and not IsReadOnly;
end;

function TElComponentProperty.GetIsEnumerable: Boolean;
begin
  Result := True;
end;

function TElComponentProperty.GetIsReference: Boolean;
begin
  Result := True;
end;

function TElComponentProperty.GetAsString: TLMDString;
var
  LObj: TObject;
begin
  Result := SElClassUnassignedValue;
  LObj := GetAsObject;
  if Assigned(LObj) then
    Result := TComponent(LObj).Name;
end;

function TElComponentProperty.GetValuesList(const AList: TLMDStrings): Integer;
var
  LOwnerForm: TComponent;
  i: Integer;
begin
  Result := -1;
  AList.Clear;
  LOwnerForm := LMDGetOwnerForm(TComponent(FInstance));
  if Assigned(LOwnerForm) then
    for i := 0 to LOwnerForm.ComponentCount - 1 do
      if (LOwnerForm.Components[i] is GetTypeData(PropertyType).ClassType) and (LOwnerForm.Components[i] is TComponent) then
      begin
        AList.Add(LOwnerForm.Components[i].Name);
        if Value = LOwnerForm.Components[i].Name then
          Result := AList.Count - 1;
      end;
end;

procedure TElComponentProperty.SetAsObject(Value: TObject);
begin
  if CheckNotReadOnly then
  begin
    if not (Value is TComponent) and Assigned(Value) then
      raise EElInpectorError.CreateFmt(SElInvalidType, [Value.ClassName]);
    SetObjectProp(FInstance, FPropertyInfo, Value, False);
    end;
end;

procedure TElComponentProperty.SetAsString(Value: TLMDString);
var
  LObj: TObject;
begin
  if Value <> '' then
  begin
    LObj := GetComponentByName(TComponent(FInstance), Value);
    if LObj = nil then
      raise EElInpectorError.CreateFmt(SElNotFound, ['Component', Value]);
  end
  else
    LObj := nil;
  SetAsObject(LObj);
end;

{-**********************************************************************
   Class:    TElInt64Property
***********************************************************************-}
function TElInt64Property.GetAsInt64: Int64;
begin
  Result := GetInt64Prop(FInstance, FPropertyInfo);
end;

function TElInt64Property.GetAsString: TLMDString;
begin
  Result := IntToStr(GetAsInt64);
end;

procedure TElInt64Property.SetAsInt64(Value: Int64);
begin
  if CheckNotReadOnly then
    SetInt64Prop(FInstance, FPropertyInfo, Value);
end;

procedure TElInt64Property.SetAsString(Value: TLMDString);
begin
  SetAsInt64(StrToInt(Value));
end;

{-**********************************************************************
   Class:    TElStringProperty
***********************************************************************-}
function TElStringProperty.GetAsString: TLMDString;
begin
  Result := GetStrProp(FInstance, FPropertyInfo);
end;

procedure TElStringProperty.SetAsString(Value: TLMDString);
begin
  if CheckNotReadOnly then
    SetStrProp(FInstance, FPropertyInfo, Value);
end;

{-**********************************************************************
   Class:    TElWideStringProperty
***********************************************************************-}
function TElWideStringProperty.GetAsString: TLMDString;
begin
  Result := GetWideStrProp(FInstance, FPropertyInfo);
end;

procedure TElWideStringProperty.SetAsString(Value: TLMDString);
begin
  if CheckNotReadOnly then
    SetWideStrProp(FInstance, FPropertyInfo, Value);
end;

{-**********************************************************************
   Class:    TElCharsetProperty
***********************************************************************-}
function TElCharsetProperty.GetAsString: TLMDString;
var
  LIdent: string;
begin
  Result := '';
  if CharsetToIdent(GetAsOrd, LIdent) then
    Result := LIdent;
end;

function TElCharsetProperty.GetIsEnumerable: Boolean;
begin
  Result := True;
end;

procedure TElCharsetProperty.SetAsString(Value: TLMDString);
var
  LInt: Integer;
begin
  if IdentToCharset(Value, LInt) then
    SetAsOrd(LInt);
end;

function TElCharsetProperty.GetValuesList(const AList: TLMDStrings): Integer;
var
  i: Integer;
  LIdent: string;
begin
  Result := -1;
  AList.Clear;
  for i := MinValue to MaxValue do
    if CharsetToIdent(i, LIdent) then
    begin
      AList.Add(LIdent);
      if i = GetAsOrd then
        Result := AList.Count - 1;
    end;
end;

{-**********************************************************************
   Class:    TElCursorProperty
***********************************************************************-}
function TElCursorProperty.GetAsString: TLMDString;
begin
  Result := CursorToString(GetAsOrd);
end;

function TElCursorProperty.GetIsEnumerable: Boolean;
begin
  Result := True;
end;

procedure TElCursorProperty.SetAsString(Value: TLMDString);
begin
  SetAsOrd(StringToCursor(Value));
end;

function TElCursorProperty.GetValuesList(const AList: TLMDStrings): Integer;
var
  i: Integer;
  LCursor: string;
begin
  Result := -1;
  AList.Clear;
  for i := MinValue to MaxValue do
    if CursorToIdent(i, LCursor) then
    begin
      AList.Add(LCursor);
      if i = GetAsOrd then
        Result := AList.Count - 1;
    end;
end;

function SetToString(PropInfo: PPropInfo; Value: Integer; Brackets: Boolean): string;
var
  S: TIntegerSet;
  I: Integer;
  TypeInfo: PTypeInfo;
begin
  Result := '';
  TypeInfo := GetTypeData(PropInfo^.PropType^)^.CompType^;
  Integer(S) := Value;
  for I := 0 to SizeOf(Integer) * 8 - 1 do
    if I in S then
      begin
        if Result <> '' then Result := Result + ',';
        Result := Result + GetEnumName(TypeInfo, I);
      end;
  if Brackets then Result := '[' + Result + ']';
  end;

function StringToSet(PropInfo: PPropInfo; const Value: string): Integer;
var
  EnumInfo: PTypeInfo;

  P: PChar;
  EnumName: string;
  EnumValue: Longint;

  function NextWord(var P: PChar): string;
  var
    i: Integer;
  begin
    i := 0;
    while not ({$IFDEF LMDCOMP12}CharInSet(P[i], [',', ' ', #0,']']){$ELSE}P[i] in [',', ' ', #0,']']{$ENDIF}) do
      Inc(i);
                                                SetString(Result, P, i);
    {$IFDEF LMDCOMP12}
    while CharInSet(P[i], [',', ' ',']']) do
    {$ELSE}
    while P[i] in [',', ' ',']'] do
    {$ENDIF}
      Inc(i);            
    Inc(P, i);
  end;

begin
  Result := 0;
  if Value = '' then Exit;
  EnumInfo := GetTypeData(PropInfo^.PropType^)^.CompType^;
  P := PChar(Value);
  while {$IFDEF LMDCOMP12}CharInSet(P^, ['[',' ']){$ELSE}P^ in ['[',' ']{$ENDIF} do Inc(P);
  EnumName := NextWord(P);
  while EnumName <> '' do
    begin
      EnumValue := GetEnumValue(EnumInfo, EnumName);
      if EnumValue < 0 then
        raise EPropertyConvertError.CreateFmt('Invalid property element: %s', [EnumName]);
        Include(TIntegerSet(Result), EnumValue);
      EnumName := NextWord(P);
    end;
  end;

{-**********************************************************************
   Class:    TElSetProperty
***********************************************************************-}
function TElSetProperty.GetAsString: TLMDString;
begin
  Result := SetToString(FPropertyInfo, GetAsOrd, true);
end;

function TElSetProperty.GetIsComplex: Boolean;
begin
  Result := True;
end;

function TElSetProperty.GetMaxValue: Integer;
begin
  Result := GetTypeData(GetTypeInfo).MaxValue;
end;

function TElSetProperty.GetMinValue: Integer;
begin
  Result := GetTypeData(GetTypeInfo).MinValue;
end;

function TElSetProperty.GetTypeInfo: PTypeInfo;
begin
  Result := GetTypeData(PropertyType)^.CompType^;
end;

procedure TElSetProperty.SetAsString(Value: TLMDString);
begin
  StringToSet(FPropertyInfo, Value);
end;

{-**********************************************************************
   Class:    TElSetElementProperty
***********************************************************************-}
function TElSetElementProperty.GetAsBoolean: Boolean;

var
  LS: TIntegerSet;
begin
  Integer(LS) := FParentSet.GetAsOrd;
  Result := (FSetIndex in LS);
end;

function TElSetElementProperty.GetAsString: TLMDString;
begin
  Result := BoolToStr(GetAsBoolean, true);
end;

function TElSetElementProperty.GetName: TLMDString;
begin
  Result := GetEnumName(GetTypeInfo, FSetIndex);
end;

function TElSetElementProperty.GetTypeInfo: PTypeInfo;
begin
  Result := GetTypeData(FParentSet.PropertyType)^.CompType^;
end;

procedure TElSetElementProperty.SetAsBoolean(Value: Boolean);

var
  LS: TIntegerSet;
begin
  Integer(LS) := FParentSet.GetAsOrd;
  if Value then
    Include(LS, FSetIndex)
  else
    Exclude(LS, FSetIndex);
  SetAsOrd(Integer(LS));
end;

procedure TElSetElementProperty.SetAsString(Value: TLMDString);
var
  LVal: Boolean;
begin
  TryStrToBool(Value, LVal);
  SetAsBoolean(LVal);
end;

function TElSetElementProperty.GetValuesList(const AList: TLMDStrings): Integer;
begin
  Result := 1;
  AList.Clear;
  AList.Add('True');
  AList.Add('False');
  if GetAsBoolean then
    Result := 0
end;

{-**********************************************************************
   Class:    TElMethodProperty
***********************************************************************-}
function TElMethodProperty.GetAsMethod: TMethod;
begin
  Result := GetMethodProp(FInstance, FPropertyInfo);
end;

function TElMethodProperty.GetAsString: TLMDString;
begin
  Result := FInstance.MethodName(GetAsMethod.Code);
end;

function TElMethodProperty.GetIsEnumerable: Boolean;
begin
  Result := true
end;

procedure TElMethodProperty.SetAsMethod(Value: TMethod);
begin
  if CheckNotReadOnly then
    SetMethodProp(FInstance, FPropertyInfo, Value);
end;

procedure TElMethodProperty.SetAsString(Value: TLMDString);
var
  LMethod: TMethod;
begin
  LMethod.Data := FInstance;
  LMethod.Code := FInstance.MethodAddress(Value);
  SetAsMethod(LMethod);
end;

function TElMethodProperty.GetValuesList(const AList: TLMDStrings): Integer;
begin
  Result := -1;
  AList.Clear;
  if Value <> '' then
    AList.Add(Value);
end;

// Only for Delphi 5, becourse in earlier RTL versions, functions
// FindIdentToInt and FindIntToIdent are absent
{-**********************************************************************
   Class:    TElIdentProperty
***********************************************************************-}
constructor TElIdentProperty.Create;
begin
  inherited;
  FIdentToInt := FindIdentToInt(PropertyType);
  FIntToIdent := FindIntToIdent(PropertyType);
  if not ((Assigned(FIdentToInt)) and (Assigned(FIntToIdent))) then
    raise EElInpectorError.Create(SElNotIdent);
end;

function TElIdentProperty.GetAsString: TLMDString;
var
  LIdent: string;
begin
  Result := '';
  if FIntToIdent(GetAsOrd, LIdent) then
    Result := LIdent;
end;

function TElIdentProperty.GetIsEnumerable: Boolean;
begin
  Result := True;
end;

procedure TElIdentProperty.SetAsString(Value: TLMDString);
var
  LInt: Integer;
begin
  if FIdentToInt(Value, LInt) then
    SetAsOrd(LInt);
end;

function TElIdentProperty.GetValuesList(const AList: TLMDStrings): Integer;
var
  i: Integer;
  LIdent: string;
begin
  Result := -1;
  AList.Clear;
  for i := MinValue to MaxValue do
    if FIntToIdent(i, LIdent) then
    begin
      AList.Add(LIdent);
      if i = GetAsOrd then
        Result := i;
    end;
end;

{-**********************************************************************
   Class:    TElColorProperty
***********************************************************************-}
function TElColorProperty.GetAsString: TLMDString;
begin
  Result := ColorToString(GetAsOrd);
end;

function TElColorProperty.GetIsEnumerable: Boolean;
begin
  Result := True;
end;

procedure TElColorProperty.SetAsString(Value: TLMDString);
var
  i, j: Integer;
begin
  if Pos('$', Value) = 1 then
  begin
    Val(Value, i, j);
    if j = 0 then
      SetAsOrd(i)
    else
      SetAsOrd(0);
  end
  else
    if Pos('cl', Value) = 1 then
      SetAsOrd(StringToColor(Value));
end;

function TElColorProperty.GetValuesList(const AList: TLMDStrings): Integer;
var
  i: Integer;
begin
  Result := -1;
  AList.Clear;
  for i := MinValue to MaxValue do
  begin
    AList.Add(ColorToString(i));
    if i = GetAsOrd then
      Result := i;
  end;
end;

{-**********************************************************************
   Class:    TElFloatProperty
***********************************************************************-}
function TElFloatProperty.GetAsFloat: Double;
begin
  Result := GetFloatProp(FInstance, FPropertyInfo);
end;

function TElFloatProperty.GetAsString: TLMDString;
begin
  Result := FloatToStr(GetAsFloat);
end;

procedure TElFloatProperty.SetAsFloat(Value: Double);
begin
  CheckNotReadOnly;
  SetFloatProp(FInstance, FPropertyInfo, Value);
end;

procedure TElFloatProperty.SetAsString(Value: TLMDString);
begin
  SetAsFloat(StrToFloat(Value));
end;

{-**********************************************************************
   Class:    TElInspectorProp
***********************************************************************-}
constructor TElInspectorProp.Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData; const AParentClass: TClass; const AName: string; const ATypeInfo:
        PTypeInfo);
begin
  inherited Create(AClass, AInspData);
  FParentClass := AParentClass;
  FName := AName;
  FTypeInfo := ATypeInfo;
end;

{-**********************************************************************
   Class:    TElRTTIClassList
***********************************************************************-}
function TElRTTIClassList.GetNeededData(const PropInfo: PPropInfo): TElInspectorRegister;
var
  i: Integer;
  LT: TElInspectorRegister;
  LTP: TTypeKind;
  begin
  Result := TElInspectorRegister(Items[0]);

  for i := 1 to Count - 1 do
  begin
    LT := TElInspectorRegister(Items[i]);
    if (LT is TElInspectorProp) then
    begin
      if String(PropInfo.Name) = TElInspectorProp(LT).Name then
      begin
        if PropInfo.PropType^ = TElInspectorProp(LT).TypeInfo then
          if GetTypeData(PropInfo.PropType^)^.ClassType = TElInspectorProp(LT).ParentClass then
          begin
            Result := TElInspectorRegister(LT);
            Exit;
          end;
      end;
    end;

    if (LT is TElInspectorTypeInfo) then
    begin
      if PropInfo.PropType^ = TElInspectorTypeInfo(LT).TypeInfo then
      begin
        Result := TElInspectorRegister(LT);
        Exit;
      end;
    end;

    if (LT is TElInspectorInherits) then
    begin
      if Assigned(GetTypeData(PropInfo.PropType^)^.ClassType) and (PropInfo.PropType^.Kind = tkClass) then
      if GetTypeData(PropInfo^.PropType^)^.ClassType.InheritsFrom(TElInspectorInherits(LT).ParentClass) then
        begin
          Result := TElInspectorRegister(LT);
          Exit;
        end;
    end;

    if (LT is TElInspectorTypeKind) then
    begin
      LTP := PropInfo^.PropType^.Kind;
      if LTP = tkInteger then
        if Pointer(FindIdentToInt(PropInfo^.PropType^)) <> nil then
        LTP := tkEnumeration;
      if  LTP = TElInspectorTypeKind(LT).TypeKind then
      begin
        Result := TElInspectorRegister(LT);
        break;
      end;
    end;
  end;
end;

function TElRTTIClassList.GetNeededEditor(const AItem: TElInspectorItem): TElInspectorRegister;

var
  LProp: PPropInfo;

begin
  if (TElPropertyData(AItem.InspectorData) is TElSetElementProperty) then
  begin
    New(LProp);
    New(LProp^.PropType);
    LProp^.PropType^ := TypeInfo(TSetElement);
    Result := GetNeededData(LProp);
    Dispose(LProp^.PropType);
    Dispose(LProp);
    end
  else
    Result := GetNeededData(TElPropertyData(AItem.InspectorData).PropertyInfo);
end;

{-**********************************************************************
   Class:    TElUnknowProperty
***********************************************************************-}
function TElUnknowProperty.GetAsString: TLMDString;
begin
  Result := '';
end;

procedure TElUnknowProperty.SetAsString(Value: TLMDString);
begin
  raise EElInpectorError.Create(SElCantSetThisPropAs);
end;

procedure TElInspectorRTTIDataSource.SetObjectInstance( const Value: TObject);
begin
  if (Value <> nil) then
  begin
    if Assigned( FInstance) then
      begin
      TComponent(FInstance).RemoveFreeNotification(Self);
      FInstance := nil;
      end;

    FObjectInstance := Value;
//    if Assigned(FInspector) then
//      FInspector.Rebuild(nil);
    if FInspectors.Count > 0 then
      NotifyInspectors(iRebuildInspector);
  end;
end;

end.
