unit ElDBInspector;
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

ElDBInspector unit
------------------

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
  Forms,
  Controls,
  Dialogs,
  TypInfo,
  Variants,
  DB,
  DBConsts,
  LMDTypes,
  LMDUnicodeStrings,
  ElInspector,
  ElStack,
  ElVCLUtils,
  LMDObjectList,
  ElTree,
  ElEdits,
  ElHeader,
  ElTreeMemoEdit,
  ElTreeDTPickEdit,
  StdCtrls,
  ElTreeCurrEdit,
  ElDBTreeEditors,
  ElInspectorEditors;

type
  TIDBDataSourceDataLink = class;

  TElInspectorFieldType = class(TElInspectorRegister)
  protected
    FFieldType: TFieldType;
  public
    constructor Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData; const AFieldType: TFieldType);
    property FieldType: TFieldType read FFieldType write FFieldType;
  end;

  TElDBData = class (TElInspectorData)
  private
    function GetFieldType: TFieldType;
  protected
    FDataSource: TDataSource;
    FFieldName: TLMDString;
    FFieldDisplName: TLMDString;
    FFieldType: TFieldType;
    FReadOnly: Boolean;
    FFieldKind: TFieldKind;
    function GetIsEnumerable: Boolean; override;
    function GetAsString: TLMDString; override; abstract;
    function GetName: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override; abstract;
    function GetIsComplex: Boolean; override;
    function GetIsReadOnly: Boolean; override;
  public
    function CheckNotReadOnly: Boolean;
    function GetValuesList(const AList: TLMDStrings): Integer; override;
    property FieldType: TFieldType read GetFieldType;
    property Name: TLMDString read GetName;
    property Value: TLMDString read GetAsString write SetAsString;
  end;

  TElDBUnknowData = class(TElDBData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElDBDateTimeData = class(TElDBData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
    function GetAsDateTime: TDateTime; override;
    procedure SetAsDateTime(Value: TDateTime); override;
  end;

  TElDBCurrData = class(TElDBData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
    procedure SetAsCurrency(Value: Currency);
    function GetAsCurrency: Currency;
  end;

  TElDBBooleanData = class(TElDBData)
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

  TElDBLookupData = class(TElDBData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
    function GetIsEnumerable: Boolean; override;
    function GetMaxValue: Integer; override;
    function GetMinValue: Integer; override;
  public
    function GetValuesList(const AList: TLMDStrings): Integer; override;
  end;

  TElDBFloatData = class(TElDBData)
  protected
    function GetMaxValue: Integer; override;
    function GetMinValue: Integer; override;
    procedure SetAsFloat(Value: Double); override;
    function GetAsFloat: Double; override;
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElDBStringData = class(TElDBData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElDBGraphicData = class(TElDBData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElDBMemoData = class(TElDBData)
  protected
    function GetText: TLMDString;
    procedure SetText(Value: TLMDString);
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
  end;

  TElDBIntegerData = class(TElDBData)
  protected
    function GetAsString: TLMDString; override;
    procedure SetAsString(Value: TLMDString); override;
    function GetAsInteger: Integer; override;
    procedure SetAsInteger(Value: Integer); override;
    function GetMaxValue: Integer; override;
    function GetMinValue: Integer; override;
  end;

  TElDBClassesList = class(TElInspectorClassesList)
  protected
    function FindItemByFieldType(const AFieldType: TFieldType): TElInspectorFieldType;
  public
    function GetNeededData(const AFieldType: TFieldType): TElInspectorRegister;
    function GetNeededEditor(const AItem: TElInspectorItem): TElInspectorRegister; override;
  end;

  TElDBEnumerator = class(TElEnumerator)
  protected
    FCurrentField: Integer;
  public
    constructor Create(AOwner: TElInspectorDataSource);
    function GetFirstItem: TElInspectorData; override;
    function GetNextItem: TElInspectorData; override;
  end;

  TElInspectorDBDataSource = class(TElInspectorDataSource)
  protected
    FCategories: TElCategories;
    FDataSetIsUpdate: Boolean;
    FIDBDataSourceDataLink: TIDBDataSourceDataLink;
    FElRegClass: TElInspectorClassesList;
    function GetCategories: TElCategories; override;
    function GetRegClass: TElInspectorClassesList; override;
    procedure SetCategories(const Value: TElCategories); override;
    procedure SetDataSource(const Value: TDataSource);
    Function GetDataSource: TDataSource;
    procedure NeedCategory(Sender: TObject; AItem: TElInspectorData; var AIndex: Integer);
    procedure DBItemDeletion(Sender: TObject; Item: TElTreeItem);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateEnumerator(Item: TElInspectorData): TElEnumerator; override;
    procedure DestroyEnumerator(AEnum: TElEnumerator); override;
    property RegisterList: TElInspectorClassesList read GetRegClass;
    //property Categories: TElCategories read GetCategories write SetCategories;
    procedure ClearItemIndex; override;
    procedure RegisterDataLink(Value: TElInspectorDataLink);override;
    procedure UnregisterDataLink(Value: TElInspectorDataLink);override;
  published
    property Categories;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

  TIDBDataSourceDataLink = class(TDataLink)
  private
    FInspectorDataSource: TElInspectorDBDataSource;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
//    procedure FocusControl(Field: TFieldRef); override;
//    procedure EditingChanged; override;
//    procedure LayoutChanged; override;
//    procedure RecordChanged(Field: TField); override;
//    procedure UpdateData; override;
  public
    constructor Create(AInspectorDataSource: TElInspectorDBDataSource);
  end;

  TElDBInspectorInplaceMemoEdit = class(TElTreeInplaceMemoEdit)
  protected
    procedure TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  end;

  TElDBInspectorInplaceDateTimeEdit = class(TElTreeInplaceDateTimePicker)
  protected
    procedure TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  end;

  TElDBInspectorInplaceCurrEdit = class(TElTreeInplaceCurrencyEdit)
  protected
    procedure TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
//    procedure RefreshOnClose(Sender: TObject; var ModalResult : integer);
  public
    constructor Create(AOwner : TComponent); override;
  end;

implementation

{ TElInspectorDBDataSource }

procedure TElInspectorDBDataSource.ClearItemIndex;
var
  i: Integer;
begin
  for i := 0 to Categories.Count - 1 do
    Categories.Items[i].CategoryItem := nil;
end;

constructor TElInspectorDBDataSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCategories := TElCategories.Create(TElCategory);
  FDataSetIsUpdate := False;
  FElRegClass := TElDBClassesList.Create;
  FIDBDataSourceDataLink := TIDBDataSourceDataLink.Create(Self);
  with FElRegClass do
  begin
    Add(TElInspectorFieldType.Create(nil, TElDBUnknowData, ftUnknown));
    Add(TElInspectorFieldType.Create(TElInspectorInplaceEdit, TElDBStringData, ftString));
    Add(TElInspectorFieldType.Create(TElInspectorInplaceSpinEdit, TElDBIntegerData, ftInteger));
    Add(TElInspectorFieldType.Create(TElInspectorInplaceSpinEdit, TElDBIntegerData, ftSmallInt));
    Add(TElInspectorFieldType.Create(TElInspectorInplaceSpinEdit, TElDBIntegerData, ftWord));
    Add(TElInspectorFieldType.Create(TElInspectorInplaceFloatSpinEdit, TElDBFloatData, ftFloat));
    Add(TElInspectorFieldType.Create(TElInspectorInplaceComboBox, TElDBBooleanData, ftBoolean));
    Add(TElInspectorFieldType.Create(TElDBInspectorInplaceMemoEdit, TElDBMemoData, ftMemo));
    Add(TElInspectorFieldType.Create(TElDBInspectorInplaceDateTimeEdit, TElDBDateTimeData, ftDate));
    Add(TElInspectorFieldType.Create(TElDBInspectorInplaceDateTimeEdit, TElDBDateTimeData, ftDateTime));
    Add(TElInspectorFieldType.Create(TElDBInspectorInplaceDateTimeEdit, TElDBDateTimeData, ftTime));
    Add(TElInspectorFieldType.Create(TElDBInspectorInplaceCurrEdit, TElDBCurrData, ftCurrency));
    Add(TElInspectorFieldType.Create(TElInspectorInplaceComboBox, TElDBLookupData, ftIDispatch));
  end;
end;

function TElInspectorDBDataSource.CreateEnumerator(Item: TElInspectorData): TElEnumerator;
begin
  Result := nil;
  if (Assigned(FIDBDataSourceDataLink.DataSet)) and (FIDBDataSourceDataLink.DataSet.Active) then
  begin
    Result := TElDBEnumerator.Create(Self);
  end;
end;

procedure TElInspectorDBDataSource.DBItemDeletion(Sender: TObject;
  Item: TElTreeItem);
begin
  if not (csLoading in Item.TreeView.ComponentState) then
    if Item.StylesCount > 0 then
    begin
      if (Item.Styles[0].Style = ElhsPictureOnly) and Assigned(Item.Styles[0].Picture) then
        Item.Styles[0].Picture.Free;
    end;
end;

destructor TElInspectorDBDataSource.Destroy;
begin
  FElRegClass.Free;
  FCategories.Free;
  FIDBDataSourceDataLink.DataSource := nil;
  FIDBDataSourceDataLink.Free;
  inherited;
end;

procedure TElInspectorDBDataSource.DestroyEnumerator(AEnum: TElEnumerator);
begin
  AEnum.Free;
end;

function TElInspectorDBDataSource.GetCategories: TElCategories;
begin
  Result := FCategories;
end;

function TElInspectorDBDataSource.GetDataSource: TDataSource;
begin
  Result := FIDBDataSourceDataLink.DataSource;
end;

function TElInspectorDBDataSource.GetRegClass: TElInspectorClassesList;
begin
  Result := FElRegClass;
end;

procedure TElInspectorDBDataSource.NeedCategory(Sender: TObject;
  AItem: TElInspectorData; var AIndex: Integer);
begin

end;

procedure TElInspectorDBDataSource.RegisterDataLink(
  Value: TElInspectorDataLink);
begin
  inherited;
  TElInspector(Value.Inspector).OnItemDeletion := DBItemDeletion;
end;

procedure TElInspectorDBDataSource.SetCategories(const Value: TElCategories);
begin
  if FCategories <> Value then
  begin
    FCategories.Assign(Value);
    //DoRebuildInspector;
  end;
end;

procedure TElInspectorDBDataSource.SetDataSource(const Value: TDataSource);
begin
  if Value = FIDBDataSourceDataLink.DataSource then
    Exit;
  if Assigned(Value) then
    if Assigned(Value.DataSet) then
    if Value.DataSet.IsUnidirectional then
        DatabaseError(SDataSetUnidirectional);
    FIDBDataSourceDataLink.DataSource := Value;
  if Assigned(Value) then
  begin
    if (FInspectors.Count > 0) and (Assigned(Value.DataSet)) then
      NotifyInspectors(iRebuildInspector);
    Value.FreeNotification(Self);
  end;
end;

procedure TElInspectorDBDataSource.UnregisterDataLink(
  Value: TElInspectorDataLink);
begin
  TElInspector(Value.Inspector).OnItemDeletion := nil;
  inherited;
end;

{ TElDBEnumerator }

constructor TElDBEnumerator.Create(AOwner: TElInspectorDataSource);
begin
  Owner := AOwner;
end;

function TElDBEnumerator.GetFirstItem: TElInspectorData;
begin
  FCurrentField := -1;
  Result := GetNextItem;
end;

function TElDBEnumerator.GetNextItem: TElInspectorData;
begin
  Result := nil;
  if not Assigned((Owner as TElInspectorDBDataSource).FIDBDataSourceDataLink.DataSet) or (not (Owner as TElInspectorDBDataSource).FIDBDataSourceDataLink.DataSet.Active) then
    exit;
  inc(FCurrentField);
  if FCurrentField >= (Owner as TElInspectorDBDataSource).FIDBDataSourceDataLink.DataSet.FieldCount then
    exit;
  if (Owner as TElInspectorDBDataSource).FIDBDataSourceDataLink.DataSet.Fields[FCurrentField].FieldKind <> fkLookup then
    case (Owner as TElInspectorDBDataSource).FIDBDataSourceDataLink.DataSet.Fields[FCurrentField].DataType of
    ftBoolean:
      Result := TElDBBooleanData.Create;
    ftString:
      Result := TElDBStringData.Create;
    ftInteger, ftSmallint, ftWord:
      Result := TElDBIntegerData.Create;
    ftFloat:
      Result := TElDBFloatData.Create;
    ftMemo:
      Result := TElDBMemoData.Create;
    ftDate, ftDateTime, ftTime :
      Result := TElDBDateTimeData.Create;
    ftCurrency:
      Result := TElDBCurrData.Create;
    ftGraphic, ftTypedBinary:
      Result := TElDBGraphicData.Create;
    else
      Result := TElDBUnknowData.Create;
    end
  else
    begin
      Result := TElDBLookupData.Create;
    end;

  if Assigned(Result) then
    with TElDBData(Result) do
    begin
      FFieldType := (Owner as TElInspectorDBDataSource).FIDBDataSourceDataLink.DataSet.Fields[FCurrentField].DataType;
      FFieldDisplName := (Owner as TElInspectorDBDataSource).FIDBDataSourceDataLink.DataSet.Fields[FCurrentField].DisplayLabel;
      FFieldName := (Owner as TElInspectorDBDataSource).FIDBDataSourceDataLink.DataSet.Fields[FCurrentField].FieldName;
      FDataSource := TElInspectorDBDataSource(Owner).DataSource;
      FReadOnly := (Owner as TElInspectorDBDataSource).FIDBDataSourceDataLink.DataSet.Fields[FCurrentField].ReadOnly;
      FFieldKind := (Owner as TElInspectorDBDataSource).FIDBDataSourceDataLink.DataSet.Fields[FCurrentField].FieldKind;
      if FFieldKind = fkLookup then
        FFieldType := ftIDispatch;
    end;
end;

{ TElDBData }

function TElDBData.CheckNotReadOnly: Boolean;
begin
  Result := not GetIsReadOnly;
end;

function TElDBData.GetIsComplex: Boolean;
begin
  Result := false;
end;

function TElDBData.GetIsEnumerable: Boolean;
begin
  Result := false;
end;

function TElDBData.GetName: TLMDString;
begin
  Result := FFieldDisplName;
end;

function TElDBData.GetValuesList(const AList: TLMDStrings): Integer;
begin
  Result := 0;
end;

function TElDBData.GetFieldType: TFieldType;
begin
  Result := FFieldType;
end;

function TElDBData.GetIsReadOnly: Boolean;
begin
  Result := FReadOnly;
end;

{ TElInspectorFieldType }

constructor TElInspectorFieldType.Create(const AClass: TElClassInplaceEditor; const AInspData: TElClassInspectorData; const AFieldType: TFieldType);
begin
  inherited Create(AClass, AInspData);
  FFieldType := AFieldType;
end;

{ TElDBClassesList }

function TElDBClassesList.FindItemByFieldType(const AFieldType: TFieldType): TElInspectorFieldType;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if TElInspectorFieldType(Items[i]).FieldType = AFieldType then
    begin
      Result := TElInspectorFieldType(Items[i]);
      break;
    end;
end;

function TElDBClassesList.GetNeededData(const AFieldType: TFieldType): TElInspectorRegister;
begin
  Result := FindItemByFieldType(AFieldType)
end;

function TElDBClassesList.GetNeededEditor(const AItem: TElInspectorItem): TElInspectorRegister;
begin
  Result := nil;
  if (TElDBData(AItem.InspectorData).FFieldKind = fkLookup) and (TElDBData(AItem.InspectorData).FieldType = ftIDispatch) then
    Result := GetNeededData(ftIDispatch)
  else
    if (not TElDBData(AItem.InspectorData).FReadOnly) and (TElDBData(AItem.InspectorData).FFieldKind = fkData) then
      Result := GetNeededData(TElDBData(AItem.InspectorData).FieldType);
end;

{ TElDBUnknowData }

function TElDBUnknowData.GetAsString: TLMDString;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).Text;
end;

procedure TElDBUnknowData.SetAsString(Value: TLMDString);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsString <> Value) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsString := Value;
    FDataSource.DataSet.Post;
  end;
end;

{ ElDBBooleanData }

function TElDBBooleanData.GetAsBoolean: Boolean;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).asBoolean;
end;

function TElDBBooleanData.GetAsString: TLMDString;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).asString;
end;

function TElDBBooleanData.GetIsEnumerable: Boolean;
begin
  Result := true;
end;

function TElDBBooleanData.GetMaxValue: Integer;
begin
  Result := Integer(High(Boolean));
end;

function TElDBBooleanData.GetMinValue: Integer;
begin
  Result := Integer(Low(Boolean));
end;

function TElDBBooleanData.GetValuesList(const AList: TLMDStrings): Integer;
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

procedure TElDBBooleanData.SetAsBoolean(Value: Boolean);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsBoolean <> Value) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsBoolean := Value;
    FDataSource.DataSet.Post;
  end;
end;

procedure TElDBBooleanData.SetAsString(Value: TLMDString);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsString <> Value) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsBoolean := StrToBool(Value);
    FDataSource.DataSet.Post;
  end;
end;

{ TElDBStringData }

function TElDBStringData.GetAsString: TLMDString;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).Text;
end;

procedure TElDBStringData.SetAsString(Value: TLMDString);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsString <> Value) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsString := Value;
    FDataSource.DataSet.Post;
  end;
end;

{ TElDBIntegerData }

function TElDBIntegerData.GetAsInteger: Integer;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).AsInteger;
end;

function TElDBIntegerData.GetAsString: TLMDString;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).AsString;
end;

function TElDBIntegerData.GetMaxValue: Integer;
begin
 case FFieldType of
  ftInteger : Result := High(Integer);
  ftSmallInt : Result := High(SmallInt);
  ftWord : Result := High(Word);
 else
   Result := High(Integer);
 end;
end;

function TElDBIntegerData.GetMinValue: Integer;
begin
 case FFieldType of
  ftInteger : Result := Low(Integer);
  ftSmallInt : Result := Low(SmallInt);
  ftWord : Result := Low(Word);
 else
   Result := Low(Integer);
 end;
end;

procedure TElDBIntegerData.SetAsInteger(Value: Integer);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsInteger <> Value) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsInteger := Value;
    FDataSource.DataSet.Post;
  end;
end;

procedure TElDBIntegerData.SetAsString(Value: TLMDString);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsString <> Value) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsInteger := StrToInt(Value);
    FDataSource.DataSet.Post;
  end;
end;

{ TElDBFloatData }

function TElDBFloatData.GetAsFloat: Double;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).AsFloat;
end;

function TElDBFloatData.GetAsString: TLMDString;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).AsString;
end;

function TElDBFloatData.GetMaxValue: Integer;
begin
 Result := High(Integer);
end;

function TElDBFloatData.GetMinValue: Integer;
begin
  Result := Low(Integer);
end;

procedure TElDBFloatData.SetAsFloat(Value: Double);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsFloat <> Value) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsFloat := Value;
    FDataSource.DataSet.Post;
  end;
end;

procedure TElDBFloatData.SetAsString(Value: TLMDString);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsFloat <> StrToFloat(Value)) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsFloat := StrToFloat(Value);
    FDataSource.DataSet.Post;
  end;
end;

{ TElDBMemoData }

function TElDBMemoData.GetAsString: TLMDString;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).Text;
end;

function TElDBMemoData.GetText: TLMDString;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).AsString;
end;

procedure TElDBMemoData.SetAsString(Value: TLMDString);
begin
end;

procedure TElDBMemoData.SetText(Value: TLMDString);
begin
  FDataSource.DataSet.Edit;
  FDataSource.DataSet.FieldByName(FFieldName).AsString := Value;
  FDataSource.DataSet.Post;
end;

{TIDBDataSourceDataLink}

procedure TIDBDataSourceDataLink.ActiveChanged;
begin
  inherited;
//  if Assigned(FInspectorDataSource.FInspector) and (not (csDestroying in FInspectorDataSource.ComponentState)) then
//    FInspectorDataSource.FInspector.Rebuild(nil);
  if (not (csDestroying in FInspectorDataSource.ComponentState)) and (FInspectorDataSource.FInspectors.Count > 0)  then
    FInspectorDataSource.NotifyInspectors(iRebuildInspector);
end;

constructor TIDBDataSourceDataLink.Create(AInspectorDataSource: TElInspectorDBDataSource);
begin
  inherited Create;
  FInspectorDataSource := AInspectorDataSource;
  VisualControl := false;
  end;

procedure TIDBDataSourceDataLink.DataSetChanged;
begin
  inherited;
  if (not (csDestroying in FInspectorDataSource.ComponentState)) and (FInspectorDataSource.FInspectors.Count > 0) then
    FInspectorDataSource.NotifyInspectors(iRebuildInspector);
end;

procedure TIDBDataSourceDataLink.DataSetScrolled(Distance: Integer);
begin
  inherited;
  if (not (csDestroying in FInspectorDataSource.ComponentState)) and (FInspectorDataSource.FInspectors.Count > 0)  then
    FInspectorDataSource.NotifyInspectors(iRebuildInspector);
end;

{ TElInspectorInplaceMemoEdit }

procedure TElDBInspectorInplaceMemoEdit.TriggerAfterOperation(var Accepted,
  DefaultConversion: boolean);
begin
  if Accepted then
   TElDBMemoData(TElInspectorItem(Item).InspectorData).SetText(Editor.Text);
  Editor.Text := TElDBMemoData(TElInspectorItem(Item).InspectorData).GetAsString;
  inherited;
  (Tree as TCustomElTree).IsUpdating := False;
end;

procedure TElDBInspectorInplaceMemoEdit.TriggerBeforeOperation(
  var DefaultConversion: boolean);
begin
  inherited;
  (Tree as TCustomElTree).IsUpdating := True;
  Editor.Text := TElDBMemoData(TElInspectorItem(Item).InspectorData).GetText;
  Editor.WordWrap := True;
  if (Editor.Lines.Count > Round(Editor.Width/(Item as TElTreeItem).Height)) then
    Editor.ScrollBars := ssVertical;
end;

{ TElDBDateTimeData }

function TElDBDateTimeData.GetAsDateTime: TDateTime;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).AsDateTime;
end;

function TElDBDateTimeData.GetAsString: TLMDString;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).AsString;
end;

procedure TElDBDateTimeData.SetAsDateTime(Value: TDateTime);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsDateTime <> Value) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsDateTime := Value;
    FDataSource.DataSet.Post;
  end;
end;

procedure TElDBDateTimeData.SetAsString(Value: TLMDString);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsString <> Value) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsDateTime := StrToDateTime(Value);
    FDataSource.DataSet.Post;
  end;
end;

{ TElInspectorInplaceDateTimeEdit }

procedure TElDBInspectorInplaceDateTimeEdit.TriggerAfterOperation(
  var Accepted, DefaultConversion: boolean);
begin
  if Accepted then
  begin
   TElDBDateTimeData(TElInspectorItem(Item).InspectorData).AsDateTime := Editor.DateTime;
   TElInspectorItem(Item).InspectorData.InspectorItem.ColumnText.Strings[0] := Editor.Text;
  end;
  inherited;
  (Tree as TCustomElTree).IsUpdating := False;
  Accepted := false;
end;

procedure TElDBInspectorInplaceDateTimeEdit.TriggerBeforeOperation(
  var DefaultConversion: boolean);
begin
  (Tree as TCustomElTree).IsUpdating := True;
  Editor.DateTime := StrToDateTime(TElInspectorItem(Item).InspectorData.Value);
  Editor.Flat := True;
  Editor.BorderStyle := bsNone;
  inherited;
end;

{ TElDBCurrData }

function TElDBCurrData.GetAsCurrency: Currency;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).AsCurrency;
end;

function TElDBCurrData.GetAsString: TLMDString;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).DisplayText;
end;

procedure TElDBCurrData.SetAsCurrency(Value: Currency);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsCurrency <> Value) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsCurrency := Value;
    FDataSource.DataSet.Post;
  end;
end;

procedure TElDBCurrData.SetAsString(Value: TLMDString);
begin
  if (FDataSource.DataSet.FieldByName(FFieldName).AsString <> Value) then
  begin
    FDataSource.DataSet.Edit;
    FDataSource.DataSet.FieldByName(FFieldName).AsCurrency := StrToCurr(Value);
    FDataSource.DataSet.Post;
  end;
end;

{ TElInspectorInplaceCurrEdit }

constructor TElDBInspectorInplaceCurrEdit.Create(AOwner: TComponent);
begin
  inherited;
//  Editor.CalcDlgOnDeactivate := RefreshOnClose;
end;

//procedure TElDBInspectorInplaceCurrEdit.RefreshOnClose(Sender: TObject; var ModalResult : integer);
//begin
//end;

procedure TElDBInspectorInplaceCurrEdit.TriggerAfterOperation(var Accepted,
  DefaultConversion: boolean);
begin
  if Accepted then
  begin
   TElDBCurrData(TElInspectorItem(Item).InspectorData).SetAsCurrency(Editor.Value);
   TElInspectorItem(Item).InspectorData.InspectorItem.ColumnText.Strings[0] := TElDBCurrData(TElInspectorItem(Item).InspectorData).GetAsString;
  end;
  inherited;
  (Tree as TCustomElTree).IsUpdating := False;
  Accepted := false;
end;

procedure TElDBInspectorInplaceCurrEdit.TriggerBeforeOperation(
  var DefaultConversion: boolean);
begin
  (Tree as TCustomElTree).IsUpdating := True;
  with TElDBCurrData(TElInspectorItem(Item).InspectorData) do
  begin
    Editor.Value := TElDBCurrData(TElInspectorItem(Item).InspectorData).GetAsCurrency;
    Editor.UseSystemCurrencySymbol := (FDataSource.DataSet.FieldByName(FFieldName) as TCurrencyField).Currency;
  end;
  Editor.Flat := True;
  Editor.BorderStyle := bsNone;
  Editor.CalcDlgDefZeroValue := False;
  {$ifndef NO_CALC_IN_CURREDIT}
  CalcDlgButtonVisible := True;
  {$endif}
  inherited;
end;

{ TElDBGraphicData }

function TElDBGraphicData.GetAsString: TLMDString;
var
  CS: TElCellStyle;
begin
  Result := '';
  if FDataSource.DataSet.FieldByName(FFieldName).IsBlob then
  begin
    if InspectorItem.StylesCount = 0 then
       CS := InspectorItem.AddStyle
     else
       CS := InspectorItem.Styles[0];
    CS.CellType := sftPicture;
    if FDataSource.DataSet.FieldByName(FFieldName).IsBlob then
    begin
      CS.Style := ElhsPictureOnly;
      if not Assigned(CS.Picture) then
        CS.Picture := TBitmap.Create;
      CS.Picture.Assign(FDataSource.DataSet.FieldByName(FFieldName));
      InspectorItem.OwnerHeight := false;
      InspectorItem.Height := CS.Picture.Height;
    end;
  end;
end;

procedure TElDBGraphicData.SetAsString(Value: TLMDString);
begin
//
end;

{ TElDBLookupData }

function TElDBLookupData.GetAsString: TLMDString;
begin
  Result := FDataSource.DataSet.FieldByName(FFieldName).asString;
end;

function TElDBLookupData.GetIsEnumerable: Boolean;
begin
  Result := True;
end;

function TElDBLookupData.GetMaxValue: Integer;
var
  FField : TField;
begin
  Result := -1;
  if Assigned(FDataSource.DataSet) and FDataSource.DataSet.Active and (FFieldName <> '') then
  begin
    FField := FDataSource.DataSet.FieldByName(FFieldName);
    FField.RefreshLookupList;
    Result := FField.LookupDataSet.RecordCount - 1;
  end;
end;

function TElDBLookupData.GetMinValue: Integer;
begin
  Result := 0;
end;

function TElDBLookupData.GetValuesList(const AList: TLMDStrings): Integer;
var
  FField : TField;
begin
  Result := -1;
  AList.Clear;
  if Assigned(FDataSource.DataSet) and FDataSource.DataSet.Active and (FFieldName <> '') then
  begin
    FField := FDataSource.DataSet.FieldByName(FFieldName);
    FField.RefreshLookupList;
    FField.LookupDataSet.First;
    while not FField.LookupDataSet.eof do
    begin
      AList.Add(FField.LookupDataSet.FieldByName(FField.LookupResultField).AsString);
      if FField.LookupDataSet.FieldByName(FField.LookupResultField).AsString = FField.Text then
        Result := FField.LookupDataSet.RecNo - 1;
      FField.LookupDataSet.Next;
    end;
  end;
end;

procedure TElDBLookupData.SetAsString(Value: TLMDString);
var
  FField: TField;
  FValue: variant;
  FItem: TElTreeItem;
begin
  if Assigned(FDataSource.DataSet) and FDataSource.DataSet.Active and (FFieldName <> '') then
  begin
    FField := FDataSource.DataSet.FieldByName(FFieldName);
    FValue := FField.LookupDataSet.Lookup(FField.LookupResultField,Value,FField.LookupKeyFields);
    if not (VarType(FValue) = varEmpty) then
    begin
      FDataSource.DataSet.Edit;
      FDataSource.DataSet.FieldByName(FField.KeyFields).Value := FValue;
      FDataSource.DataSet.Post;
      FItem := InspectorItem.TreeView.Items.LookForItem(nil,FDataSource.DataSet.FieldByName(FField.KeyFields).DisplayLabel,nil,-1,false,false,false,false,true);
      if Assigned(FItem) then
      begin
        FItem.ColumnText[0] := FValue;
      end
    end;
  end;
end;

end.
