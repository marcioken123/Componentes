unit ElDBCurrEdit;
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

ElDBCurrEdit unit
----------------


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
     ElCurrEdit,
     LMDTypes,
     Forms,
     Windows,
     Controls,
     StdCtrls,
     Messages,
     Types,
     Classes,
     SysUtils;

type

  TElDBCurrencyEdit = class(TElCurrencyEdit)
  private
    FDataLink: TFieldDataLink;
    FNullValueKey: TShortCut;
    function SKey: Word;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDBReadOnlyState: Boolean;
    procedure ActiveChange(Sender: TObject);
  protected

    procedure SetValueUndefined(Value: Boolean);override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoOnChange; override;
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
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property DisplayReadOnlyOptions;
  end;

TElHackCurrPartEdit = class(TElCurrPartEdit);

implementation

constructor TElDBCurrencyEdit.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited Create(AOwner);
  inherited ReadOnly := true;
  FIgnoreReadOnlyState := not DisplayReadOnlyOptions.Enabled;
  for i := 1 to 2 do
  begin
    TElHackCurrPartEdit(FPartEditors[i]).SaveAlpha := True;
    end;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnActiveChange := ActiveChange;
end;

destructor TElDBCurrencyEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBCurrencyEdit.CMExit(var Message: TCMExit);
begin
  try
    if Modified then
      FDataLink.Modified;
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBCurrencyEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := TLMDPtrInt(FDataLink);
end;

procedure TElDBCurrencyEdit.DataChange(Sender: TObject);
begin
  if (FDataLink.Field <> nil) and (not FDataLink.Field.IsNull) then
  begin
    ValueUndefined := false;
    Value := FDataLink.Field.AsCurrency;
  end
  else
  begin
    Value := 0;
    ValueUndefined := true;
  end;
end;

function TElDBCurrencyEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBCurrencyEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBCurrencyEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBCurrencyEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElDBCurrencyEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBCurrencyEdit.KeyPress(var Key: Char);
begin
  if Key=#0 then
    exit;
  inherited KeyPress(Key);
  if (AnsiChar(Key) in ['0'..'9']) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end
  else
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
  end;
end;

procedure TElDBCurrencyEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
     and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))
     and (FDataLink.DataSet.Active)
     and (FNullValueKey = ShortCut(SKey,Shift)) then
  begin
    if Assigned(FDataLink.Field) then
    begin
      FDataLink.DataSet.Edit;
      FDataLink.Field.Clear;
    end;
    Key := 0;
  end;
  if Key in [VK_DELETE, VK_BACK] then
  begin
    FDataLink.Edit;
    inherited KeyDown(Key, Shift);
  end
  else
  if Key = VK_ESCAPE then
  begin
    FDataLink.Reset;
    //DataChange(Self);
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TElDBCurrencyEdit.DoOnChange;
begin
  inherited;
  UpdateData(Self);
end;

procedure TElDBCurrencyEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBCurrencyEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElDBCurrencyEdit.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElDBCurrencyEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
//  inherited ReadOnly := FDataLink.ReadOnly;
  inherited ReadOnly := GetDBReadOnlyState;
  Refresh;
end;

function TElDBCurrencyEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElDBCurrencyEdit.UpdateData(Sender: TObject);
  var NewValue:Currency;
begin
  if Self.ValueUndefined then
  begin
    if not FDataLink.Field.IsNull then
      FDataLink.Field.Clear;
  end
  else
    if FDataLink.Field.AsCurrency <> Value then
    begin
      NewValue := Value;
      FDataLink.Edit; // <- call DataChange ...
      FDataLink.Field.AsCurrency := NewValue;
    end
    else
      FDataLink.Edit;
end;

function TElDBCurrencyEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElDBCurrencyEdit.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not FDataLink.Editing;
//  Refresh;
end;

procedure TElDBCurrencyEdit.CMEnter(var Message: TCMEnter);
begin
  inherited;
//  if FDataLink.CanModify then
//    inherited ReadOnly := False;
//  Refresh;
end;

function TElDBCurrencyEdit.SKey: Word;
begin
  Result := TElHackCurrPartEdit(FPartEditors[1]).SKey;
  if TElHackCurrPartEdit(FPartEditors[2]).SKey > 0 then
    Result := TElHackCurrPartEdit(FPartEditors[2]).SKey;
  TElHackCurrPartEdit(FPartEditors[1]).SKey := 0;
  TElHackCurrPartEdit(FPartEditors[2]).SKey := 0;
  end;

procedure TElDBCurrencyEdit.SetValueUndefined(Value: Boolean);
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

procedure TElDBCurrencyEdit.ActiveChange(Sender: TObject);
begin
  inherited ReadOnly := GetDBReadOnlyState;
end;

function TElDBCurrencyEdit.GetDBReadOnlyState: Boolean;
begin
  Result := DBCheckReadOnlyState(FDataLink);
end;

end.
