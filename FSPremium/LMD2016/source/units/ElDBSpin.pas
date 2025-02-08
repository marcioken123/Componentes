unit ElDBSpin;
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

ElDBSpin unit
-------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
     DB,
     DBCtrls,
     ElDBCtrls,
     Menus,
     ElSpin,
     Forms,
     LMDTypes,
     Windows,
     Controls,
     StdCtrls,
     Messages,

Types,

     Classes,
     SysUtils;

type

  TElDBSpinEdit = class(TElSpinEdit)
  private
    FNullValueKey: TShortCut;
    FDataLink: TFieldDataLink;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure DataChange(Sender: TObject);

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    function  GetCReadOnly: Boolean;
    procedure SetCReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDBReadOnlyState: Boolean;
    procedure ActiveChange(Sender: TObject);
  protected

    procedure SetValueUndefined(Value: Boolean);override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SpinDownClick(Sender : TObject; Increment : Double); override;
    procedure SpinDrag(Sender : TObject; NewValue : Double); override;
    procedure SpinUpClick(Sender : TObject; Increment : Double); override;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property NullValueKey:TShortCut read FNullValueKey write FNullValueKey default 0;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetCReadOnly write SetCReadOnly default False;
    property DisplayReadOnlyOptions;
  end;

  TElDBFloatSpinEdit = class(TElFloatSpinEdit)
  private
    FNullValueKey: TShortCut;
    FDataLink: TFieldDataLink;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetCReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetCReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDBReadOnlyState: Boolean;
    procedure ActiveChange(Sender: TObject);
  protected

    procedure SetValueUndefined(Value: Boolean);override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SpinDownClick(Sender : TObject; Increment : Double); override;
    procedure SpinDrag(Sender : TObject; NewValue : Double); override;
    procedure SpinUpClick(Sender : TObject; Increment : Double); override;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property NullValueKey:TShortCut read FNullValueKey write FNullValueKey default 0;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetCReadOnly write SetCReadOnly default False;
    property DisplayReadOnlyOptions;
  end;

implementation

uses ElEdits;

function TElDBSpinEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBSpinEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBSpinEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TElDBSpinEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElDBSpinEdit.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElDBSpinEdit.DataChange(Sender: TObject);
begin
  if (FDataLink.Field <> nil) and (not FDataLink.Field.IsNull) then
  begin
    ValueUndefined := false;
    FValue := FDataLink.Field.AsInteger;
    if not (csLoading in ComponentState) then
    begin
      FValueUndefined := false;
      if FValue < FMinValue then
        FValue := FMinValue
      else
        if FValue > FMaxValue then
        FValue := FMaxValue;
    end;
    if AutoDisableSpinButtons then
    begin
      FButton.UpArrowEnabled := FValue < MaxValue;
      FButton.DownArrowEnabled := FValue > MinValue;
    end;
    FChanging := true;
    FSaveValue := FValue;
    if not (csLoading in ComponentState) then
      Text := IntToStr(FValue);
    FChanging := false;
  end
  else
  begin
    Value := 0;
    ValueUndefined := true;
  end;
end;

procedure TElDBSpinEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := TLMDPtrInt(FDataLink);
end;

constructor TElDBSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := true;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnActiveChange := ActiveChange;
  FIgnoreReadOnlyState := not DisplayReadOnlyOptions.Enabled;
end;

destructor TElDBSpinEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBSpinEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBSpinEdit.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not FDataLink.Editing;
//  Refresh;
end;

function TElDBSpinEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBSpinEdit.GetCReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBSpinEdit.KeyPress(var Key: Char);
var aValue : integer;
begin
  aValue := Value;
  if Key = #27 then
    FDataLink.Reset
  else
    FDataLink.Edit;
  inherited KeyPress(Key);
  if AValue <> Value then
    FDataLink.Modified;
end;

procedure TElDBSpinEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBSpinEdit.SetCReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
  inherited ReadOnly := GetDBReadOnlyState;
  Invalidate;
end;

function TElDBSpinEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElDBSpinEdit.UpdateData(Sender: TObject);
begin
  if Self.ValueUndefined then
    FDataLink.Field.Clear
  else
    FDataLink.Field.AsInteger := Self.Value;
end;

function TElDBSpinEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElDBSpinEdit.SpinDownClick(Sender : TObject; Increment : Double);
var AValue : integer;
begin
  if not (ReadOnly or GetDBReadOnlyState) then
    FDataLink.Edit;
  AValue := Value;
  inherited;
  if AValue <> Value then
    FDataLink.Modified;
end;

procedure TElDBSpinEdit.SpinDrag(Sender : TObject; NewValue : Double);
var AValue : integer;
begin
  if not (ReadOnly or GetDBReadOnlyState) then
    FDataLink.Edit;
  AValue := Value;
  inherited;
  if AValue <> Value then
    FDataLink.Modified;
end;

procedure TElDBSpinEdit.SpinUpClick(Sender : TObject; Increment : Double);
var AValue : integer;
begin
  if not (ReadOnly or GetDBReadOnlyState) then
    FDataLink.Edit;
  AValue := Value;
  inherited;
  if AValue <> Value then
    FDataLink.Modified;
end;

procedure TElDBSpinEdit.KeyDown(var Key : Word; Shift : TShiftState);
var aValue : integer;
begin
  if (not (ReadOnly or GetDBReadOnlyState)) and (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
     and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))
     and (FDataLink.DataSet.Active)
     and (FNullValueKey = ShortCut(Key,Shift)) then
  begin
    if Assigned(FDataLink.Field) then
    begin
      FDataLink.DataSet.Edit;
      FDataLink.Field.Clear;
    end;
    Key := 0;
  end
  else
  begin
    if not (ReadOnly or GetDBReadOnlyState) then
      FDataLink.Edit;
    aValue := Value;
    inherited;
    if AValue <> Value then
      FDataLink.Modified;
  end;
end;

constructor TElDBFloatSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := true;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnActiveChange := ActiveChange;
  FIgnoreReadOnlyState := not DisplayReadOnlyOptions.Enabled;
end;

destructor TElDBFloatSpinEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBFloatSpinEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBFloatSpinEdit.WMMouseWheel(var Msg: TWMMouseWheel);
var
  AValue: Double;
begin
  if not (ReadOnly or GetDBReadOnlyState) and not (FDataLink.Editing) then
    FDataLink.Edit;
  AValue := Value;
  inherited;
  if AValue <> Value then
    FDataLink.Modified;
end;

procedure TElDBFloatSpinEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := TLMDPtrInt(FDataLink);
end;

procedure TElDBFloatSpinEdit.DataChange(Sender: TObject);
var
  txt: string;
begin
  if (FDataLink.Field <> nil) and (not FDataLink.Field.IsNull) then
  begin
    ValueUndefined := false;
    FValue := FDataLink.Field.AsFloat;
    if not (csLoading in ComponentState) then
    begin
      FValueUndefined := false;
      if FValue < FMinValue then
        FValue := FMinValue
      else
        if FValue > FMaxValue then
        FValue := FMaxValue;
    end;
    if AutoDisableSpinButtons then
    begin
      FButton.UpArrowEnabled := FValue < MaxValue;
      FButton.DownArrowEnabled := FValue > MinValue;
    end;
    FChanging := true;
    FSaveValue := FValue;
    if not (csLoading in ComponentState) then
    begin
      txt := FloatToStrF(FValue, GetFLoatFormat, FPrecision, FDigits);
      if Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, txt) > 0 then
      begin
        txt := copy(txt,1,Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, txt)+FDigits);
      end;
      Text := txt;
    end;
    FChanging := false;
  end
  else
  begin
    Value := 0;
    ValueUndefined := true;
  end;
end;

function TElDBFloatSpinEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBFloatSpinEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBFloatSpinEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBFloatSpinEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElDBFloatSpinEdit.GetCReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBFloatSpinEdit.KeyPress(var Key: Char);
var aValue : Double;
begin
  aValue := Value;
  if Key = #27 then
    FDataLink.Reset
  else
    FDataLink.Edit;
  inherited KeyPress(Key);
  if AValue <> Value then
    FDataLink.Modified;
end;

procedure TElDBFloatSpinEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBFloatSpinEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElDBFloatSpinEdit.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElDBFloatSpinEdit.SetCReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
  inherited ReadOnly := GetDBReadOnlyState;
  Invalidate;
end;

function TElDBFloatSpinEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElDBFloatSpinEdit.UpdateData(Sender: TObject);
begin
  if Self.ValueUndefined then
    FDataLink.Field.Clear
  else
    FDataLink.Field.AsFloat := Value;
end;

function TElDBFloatSpinEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElDBFloatSpinEdit.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not FDataLink.Editing;
//  Refresh;
end;

procedure TElDBFloatSpinEdit.SpinDownClick(Sender : TObject; Increment :
    Double);
var AValue : Double;
begin
  if not (ReadOnly or GetDBReadOnlyState) then
    FDataLink.Edit;
  AValue := Value;
  inherited;
  if AValue <> Value then
    FDataLink.Modified;
end;

procedure TElDBFloatSpinEdit.SpinDrag(Sender : TObject; NewValue : Double);
var AValue : Double;
begin
  if not (ReadOnly or GetDBReadOnlyState) then
    FDataLink.Edit;
  AValue := Value;
  inherited;
  if AValue <> Value then
    FDataLink.Modified;
end;

procedure TElDBFloatSpinEdit.SpinUpClick(Sender : TObject; Increment : Double);
var AValue : Double;
begin
  if not (ReadOnly or GetDBReadOnlyState) then
    FDataLink.Edit;
  AValue := Value;
  inherited;
  if AValue <> Value then
    FDataLink.Modified;
end;

procedure TElDBFloatSpinEdit.KeyDown(var Key : Word; Shift : TShiftState);
var aValue : Double;
begin
  if (not (ReadOnly or GetDBReadOnlyState)) and (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
     and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))
     and (FDataLink.DataSet.Active)
     and (FNullValueKey = ShortCut(Key,Shift)) then
  begin
    if Assigned(FDataLink.Field) then
    begin
      FDataLink.DataSet.Edit;
      FDataLink.Field.Clear;
    end;
    Key := 0;
  end
  else
  begin
    if not (ReadOnly or GetDBReadOnlyState) then
      FDataLink.Edit;
    aValue := Value;
    inherited;
    if AValue <> Value then
      FDataLink.Modified;
  end;
end;

procedure TElDBFloatSpinEdit.SetValueUndefined(Value: Boolean);
begin
  inherited;
  if Value then
    if Assigned(Field) and (not Field.IsNull) then
    begin
      if not (DataSource.DataSet.State = dsEdit) then
        DataSource.DataSet.Edit;
      Field.Clear;
      if Assigned(OnChange) then
        OnChange(Self);
    end;
end;

procedure TElDBSpinEdit.SetValueUndefined(Value: Boolean);
begin
  inherited;
  if Value then
    if Assigned(Field) and (not Field.IsNull) then
    begin
      if not (DataSource.DataSet.State = dsEdit) then
        DataSource.DataSet.Edit;
      Field.Clear;
      if Assigned(OnChange) then
        OnChange(Self);
    end;
end;

procedure TElDBFloatSpinEdit.ActiveChange(Sender: TObject);
begin
  inherited ReadOnly := GetDBReadOnlyState;
  DataChange(Self);
end;

function TElDBFloatSpinEdit.GetDBReadOnlyState: Boolean;
begin
  Result := DBCheckReadOnlyState(FDataLink);
end;

procedure TElDBSpinEdit.ActiveChange(Sender: TObject);
begin
  inherited ReadOnly := GetDBReadOnlyState;
  DataChange(Self);
end;

function TElDBSpinEdit.GetDBReadOnlyState: Boolean;
begin
  Result := DBCheckReadOnlyState(FDataLink);
end;

procedure TElDBSpinEdit.WMMouseWheel(var Msg: TWMMouseWheel);
var
  AValue: Double;
begin
  if not (ReadOnly or GetDBReadOnlyState) and not (FDataLink.Editing) then
    FDataLink.Edit;
  AValue := Value;
  inherited;
  if AValue <> Value then
    FDataLink.Modified;
end;

end.
