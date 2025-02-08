unit ElIniInspector;
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

ElIniInspector unit
-------------------

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
  Dialogs,
  TypInfo,
  LMDTypes,
  LMDElConst,
  ElIni,
  ElInspector,
  LMDUnicodeStrings,
  ElStack,
  ElVCLUtils,
  LMDObjectList,
  LMDStrings,
  ElInspectorEditors;

type
  TElInspectorValueType = class(TElInspectorRegister)
  protected
    FValueType: TElValueType;
  public
    constructor Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData; const AValueType: TElValueType);
    property ValueType: TElValueType read FValueType write FValueType;
  end;

  TElIniData = class (TElInspectorData)
  private
    function GetValueType: TElValueType;
  protected
    FIniFile: TElIniFIle;
    FValueName: TLMDString;
    FKey: TLMDString;
    FCategoryIndex: integer;
    FValueType: TElValueType;
    function GetIsEnumerable: Boolean; override;
    function GetAsString: TLMDString; override; abstract;
    function GetName: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override; abstract;
    function GetIsComplex: Boolean; override;
  public
    function CheckNotReadOnly: Boolean;
    function GetValuesList(const AList: TLMDStrings): Integer; override;
    property ValueType: TElValueType read GetValueType;
    property Category: Integer read FCategoryIndex;
    property Name: TLMDString read GetName;
    property Value: TLMDString read GetAsString write SetAsString;
  end;

  TElUnknowData = class(TElIniData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElBooleanData = class(TElIniData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
    procedure SetAsBoolean(Value: Boolean); override;
    function GetAsBoolean: Boolean; override;
    function GetIsEnumerable: Boolean; override;
    function GetMaxValue: Integer; override;
    function GetMinValue: Integer; override;
  public
    function GetValuesList(const AList: TLMDStrings): Integer; override;
  end;

  TElFloatData = class(TElIniData)
  protected
    procedure SetAsFloat(Value: Double); override;
    function GetAsFloat: Double; override;
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElStringData = class(TElIniData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElMultiStringData = class(TElIniData)
  protected
    FCache: TLMDStrings;
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
    function GetAsObject: TObject; override;
    procedure SetAsObject(Value: TObject); override;
  public
    destructor Destroy; override;
    procedure AfterConstruction; override;
  end;

  TElIntegerData = class(TElIniData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
    function GetAsInteger: Integer; override;
    procedure SetAsInteger(Value: Integer); override;
    function GetMaxValue: Integer; override;
    function GetMinValue: Integer; override;
  end;

  TElIniClassesList = class(TElInspectorClassesList)
  protected
    function FindItemByValueType(const AValueType: TElValueType): TElInspectorValueType;
  public
    function GetNeededData(const AValueType: TElValueType): TElInspectorRegister;
    function GetNeededEditor(const AItem: TElInspectorItem): TElInspectorRegister; override;
  end;

  TElIniEnumerator = class(TElEnumerator)
  protected
    FCurrentKey: Integer;
    FCurrentValue: Integer;
    FStrings: TStrings;
    FValues: TStrings;
  public
    constructor Create(AOwner: TElInspectorDataSource);
    destructor Destroy; override;
    function GetFirstItem: TElInspectorData; override;
    function GetNextItem: TElInspectorData; override;
  end;

  TElInspectorIniDataSource = class (TElInspectorDataSource)
  protected
    FIniFile: TElIniFile;
    FCategories: TElCategories;
    FElRegClass: TElInspectorClassesList;
    FSubKeys: TStringList;
    function GetCategories: TElCategories; override;
    function GetRegClass: TElInspectorClassesList; override;
    procedure SetCategories(const Value: TElCategories); override;
    procedure SetInspector(const Value: TElInspector);
    procedure SetIniFile(const Value: TElIniFile);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure NeedCategory(Sender: TObject; AItem: TElInspectorData; var AIndex: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClearItemIndex; override;
    function CreateEnumerator(Item: TElInspectorData): TElEnumerator; override;
    procedure DestroyEnumerator(AEnum: TElEnumerator); override;
    property RegisterList: TElInspectorClassesList read GetRegClass;
    property Categories: TElCategories read GetCategories write SetCategories;
  published
//    property Inspector: TElInspector Write SetInspector;
    property IniFile: TElIniFile read FIniFile write SetIniFile;
  end;

implementation

{ TElInspectorIniDataSource }

procedure TElInspectorIniDataSource.ClearItemIndex;
var
  i: Integer;
begin
  for i := 0 to Categories.Count - 1 do
    Categories.Items[i].CategoryItem := nil;
end;

constructor TElInspectorIniDataSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategories := TElCategories.Create(TElCategory);
  FSubKeys := TStringList.Create;
  FElRegClass := TElIniClassesList.Create;
  FElRegClass.AutoClearObjects := True;
  FNeedCategory := NeedCategory;
  with FElRegClass do
  begin
    Add(TElInspectorValueType.Create(nil, TElUnknowData, evtUnknown));
    Add(TElInspectorValueType.Create(TElInspectorInplaceEdit, TElStringData, evtString));
    Add(TElInspectorValueType.Create(TElInspectorInplaceSpinEdit, TElIntegerData, evtInt));
    Add(TElInspectorValueType.Create(TElInspectorInplaceFloatSpinEdit, TElFloatData, evtInt));
    Add(TElInspectorValueType.Create(TElInspectorInplaceComboBox, TElIntegerData, evtBoolean));
    Add(TElInspectorValueType.Create(TElInspectorInplaceStringsEdit, TElMultiStringData, evtMultiString));
  end;
end;

function TElInspectorIniDataSource.CreateEnumerator(Item: TElInspectorData): TElEnumerator;
var
  LTemp: TStrings;
begin
  Result := nil;
  if Assigned(FIniFile) then
  begin
    Result := TElIniEnumerator.Create(Self);
    if not Assigned(Item) then
      TElIniEnumerator(Result).FStrings := FSubKeys
    else
    begin
      LTemp := TStringList.Create;
      FIniFile.CurrentKey := FIniFile.CurrentKey + TElIniData(Item).FKey + FIniFile.Delimiter;
      FIniFile.EnumSubKeys(FIniFile.CurrentKey, LTemp);
      TElIniEnumerator(Result).FStrings := LTemp;
    end;
  end;
end;

destructor TElInspectorIniDataSource.Destroy;
begin
  FElRegClass.Free;
  FSubKeys.Free;
  FCategories.Free;
  inherited;
end;

procedure TElInspectorIniDataSource.DestroyEnumerator(AEnum: TElEnumerator);
var
  LStr: String;
begin
  if TElIniEnumerator(AEnum).FStrings <> FSubKeys then
  begin
    TElIniEnumerator(AEnum).FStrings.Free;
    LStr := FIniFile.CurrentKey;
    Delete(LStr, LMDAnsiLastPos(FIniFile.Delimiter, LStr), Length(LStr));
    FIniFile.CurrentKey := LStr;
  end;
  AEnum.Free;
end;

function TElInspectorIniDataSource.GetCategories: TElCategories;
begin
  Result := FCategories;
end;

function TElInspectorIniDataSource.GetRegClass: TElInspectorClassesList;
begin
  Result := FElRegClass;
end;

procedure TElInspectorIniDataSource.NeedCategory(Sender: TObject;
  AItem: TElInspectorData; var AIndex: Integer);
begin
  AIndex := TElIniData(AItem).Category;
end;

procedure TElInspectorIniDataSource.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FIniFile then
    begin
      FIniFile := nil;
      if FInspectors.Count > 0 then
        NotifyInspectors(iRebuildInspector);
    end;
  end;
end;

procedure TElInspectorIniDataSource.SetCategories(const Value: TElCategories);
begin
  inherited;

end;

procedure TElInspectorIniDataSource.SetIniFile(const Value: TElIniFile);
var
  i: integer;
begin
  FIniFile := Value;
  FCategories.Clear;
  if Assigned(Value) then
  begin
    FIniFile.FreeNotification(Self);
    try
      if FileExists(FIniFile.Path) then
        FIniFile.Load;
      FIniFile.EnumSubKeys('\', FSubKeys);
      for i := 0 to FSubKeys.Count - 1 do
        FCategories.Add.Name := FSubKeys.Strings[i];
    except
    end;
  end;
  if FInspectors.Count > 0 then
    NotifyInspectors(iRebuildInspector);
end;

procedure TElInspectorIniDataSource.SetInspector(const Value: TElInspector);
begin
  // TODO:
end;

{ TElIniEnumerator }

constructor TElIniEnumerator.Create(AOwner: TElInspectorDataSource);
begin
  Owner := AOwner;
  FValues := TStringList.Create;
end;

destructor TElIniEnumerator.Destroy;
begin
  FValues.Free;
end;

function TElIniEnumerator.GetFirstItem: TElInspectorData;
begin
  FCurrentKey := -1;
  FCurrentValue := -1;
  Result := GetNextItem;
end;

function TElIniEnumerator.GetNextItem: TElInspectorData;
begin
  Result := nil;
  inc(FCurrentValue);
  while FCurrentValue >= FValues.Count do
  begin
    inc(FCurrentKey);
    if FCurrentKey >= FStrings.Count then
      exit;
    FValues.Clear;
    TElInspectorIniDataSource(Owner).FIniFile.EnumValues(FStrings[FCurrentKey], FValues);
    FCurrentValue := 0;
  end;

  case TElInspectorIniDataSource(Owner).FIniFile.GetValueType(FStrings.Strings[FCurrentKey], FValues.Strings[FCurrentValue]) of
  evtBoolean:
    Result := TElBooleanData.Create;
  evtString:
    Result := TElStringData.Create;
  evtInt:
    Result := TElIntegerData.Create;
  evtDouble:
    Result := TElFloatData.Create;
  evtMultiString:
    Result := TElMultiStringData.Create;
  else
    Result := TElUnknowData.Create;
  end;

  if Assigned(Result) then
    with TElIniData(Result) do
    begin
      FCategoryIndex := FCurrentKey;
      FKey := FStrings.Strings[FCurrentKey];
      FValueName := FValues.Strings[FCurrentValue];
      FIniFile := TElInspectorIniDataSource(Owner).FIniFile;
    end;
end;

{ TElIniData }

function TElIniData.CheckNotReadOnly: Boolean;
begin
  Result := not GetIsReadOnly;
end;

function TElIniData.GetIsComplex: Boolean;
begin
  Result := (FIniFile.SubKeysCount(FKey) > 0);// and (FValueName = ''));
end;

function TElIniData.GetIsEnumerable: Boolean;
begin
  Result := false;
end;

function TElIniData.GetName: TLMDString;
begin
  Result := FValueName;
end;

function TElIniData.GetValuesList(const AList: TLMDStrings): Integer;
begin
  Result := 0;
end;

function TElIniData.GetValueType: TElValueType;
begin
  Result := FIniFile.GetValueType(FKey, FValueName);
end;

{ TElInspectorValueType }

constructor TElInspectorValueType.Create(const AClass: TElClassInplaceEditor;
  const AInspData: TElClassInspectorData; const AValueType: TElValueType);
begin
  inherited Create(AClass, AInspData);
  FValueType := AValueType;
end;

{ TElIniClassesList }

function TElIniClassesList.FindItemByValueType(const AValueType: TElValueType): TElInspectorValueType;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if TElInspectorValueType(Items[i]).ValueType = AValueType then
    begin
      Result := TElInspectorValueType(Items[i]);
      break;
    end;
end;

function TElIniClassesList.GetNeededData(const AValueType: TElValueType): TElInspectorRegister;
begin
  Result := FindItemByValueType(AValueType)
end;

function TElIniClassesList.GetNeededEditor(const AItem: TElInspectorItem): TElInspectorRegister;
begin
  Result := GetNeededData(TElIniData(AItem.InspectorData).ValueType);
end;

{ TElUnknowData }

function TElUnknowData.GetAsString: TLMDString;
begin
  Result := '';
end;

procedure TElUnknowData.SetAsString(Value: TLMDString);
begin
  raise EElInpectorError.Create(SLMDElCantSetThisEntryAs);
end;

{ TElBooleanData }

function TElBooleanData.GetAsBoolean: Boolean;
begin
  FIniFile.ReadBool(FKey, FValueName, true, Result);
end;

function TElBooleanData.GetAsString: TLMDString;
begin
  Result := BoolToStr(GetAsBoolean, true);
end;

function TElBooleanData.GetIsEnumerable: Boolean;
begin
  Result := true;
end;

function TElBooleanData.GetMaxValue: Integer;
begin
  Result := Integer(High(Boolean));
end;

function TElBooleanData.GetMinValue: Integer;
begin
  Result := Integer(Low(Boolean));
end;

function TElBooleanData.GetValuesList(const AList: TLMDStrings): Integer;
var
  i: byte;
begin
  Result := -1;
  AList.Clear;
  for i := MinValue to MaxValue do
  begin
    AList.Add(BoolToStr(Boolean(i), true));
    if Boolean(i) = GetAsBoolean then
      Result := i;
  end;
end;

procedure TElBooleanData.SetAsBoolean(Value: Boolean);
begin
  FIniFile.WriteBool(FKey, FValueName, Value);
end;

procedure TElBooleanData.SetAsString(Value: TLMDString);
var
  LBool: Boolean;
begin
  TryStrToBool(Value, LBool);
  SetAsBoolean(LBool);
end;

{ TElStringData }

function TElStringData.GetAsString: TLMDString;
var
  LTemp: string;
begin
  FIniFile.ReadString(FKey, FValueName, '', LTemp);
  Result := LTemp;
end;

procedure TElStringData.SetAsString(Value: TLMDString);
begin
  FIniFile.WriteString(FKey, FValueName, Value);
end;

{ TElIntegerData }

function TElIntegerData.GetAsInteger: Integer;
begin
  FIniFile.ReadInteger(FKey, FValueName, 0, Result);
end;

function TElIntegerData.GetAsString: TLMDString;
begin
  Result := IntToStr(GetAsInteger);
end;

function TElIntegerData.GetMaxValue: Integer;
begin
  Result := High(Integer);
end;

function TElIntegerData.GetMinValue: Integer;
begin
  Result := Low(Integer);
end;

procedure TElIntegerData.SetAsInteger(Value: Integer);
begin
  FIniFile.WriteInteger(FKey, FValueName, Value);
end;

procedure TElIntegerData.SetAsString(Value: TLMDString);
begin
  SetAsInteger(StrToInt(Value));
end;

{ TElFloatData }

function TElFloatData.GetAsFloat: Double;
begin
  FIniFile.ReadDouble(FKey, FValueName, 0.0, Result);
end;

function TElFloatData.GetAsString: TLMDString;
begin
  Result := FloatToStr(GetAsFloat);
end;

procedure TElFloatData.SetAsFloat(Value: Double);
begin
  FIniFile.WriteDouble(FKey, FValueName, Value);
end;

procedure TElFloatData.SetAsString(Value: TLMDString);
begin
  SetAsFloat(StrToFloat(Value));
end;

{ TElMultiStringData }

procedure TElMultiStringData.AfterConstruction;
begin
  inherited;
  FCache := nil;
end;

destructor TElMultiStringData.Destroy;
begin
  if Assigned(FCache) then
    FreeAndNil(FCache);
  inherited;
end;

function TElMultiStringData.GetAsObject: TObject;
begin
  if not Assigned(FCache) then
  begin
    FCache := TLMDMemoryStrings.Create;
    FIniFile.ReadMultiString(FKey, FValueName, FCache);
  end;
  Result := FCache;
end;

function TElMultiStringData.GetAsString: TLMDString;
begin
  if not Assigned(FCache) then
  begin
    FCache := TLMDMemoryStrings.Create;
    FIniFile.ReadMultiString(FKey, FValueName, FCache);
  end;
  Result := FCache.Text;
end;

procedure TElMultiStringData.SetAsObject(Value: TObject);
begin
  if not Assigned(FCache) then
    FCache := TLMDMemoryStrings.Create;
  FCache.Assign(TPersistent(Value));
  FIniFile.WriteMultiString(FKey, FValueName, FCache);
end;

procedure TElMultiStringData.SetAsString(Value: TLMDString);
begin
  if not Assigned(FCache) then
    FCache := TLMDMemoryStrings.Create;

  FCache.Text := Value;
  FIniFile.WriteMultiString(FKey, FValueName, FCache);
end;

end.
