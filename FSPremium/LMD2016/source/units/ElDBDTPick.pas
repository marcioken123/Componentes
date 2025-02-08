unit ElDBDTPick;
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

ElDBDTPick unit
---------------


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
   Variants,
   ElDTPick,
   Forms,
     Windows,
     Controls,
     StdCtrls,
     Messages,
   LMDTypes,
   Types,
   ElVCLUtils,
     Menus,
     Classes,
     SysUtils;

type

  TElDBDateTimePicker = class(TElDateTimePicker)
  private
    FNullValueKey: TShortCut;
    FDataLink: TFieldDataLink;
    FNowForNULLValues: Boolean;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    procedure DataChange(Sender: TObject);
    procedure ActiveChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure UpdateData(Sender: TObject);
    function GetDBReadOnlyState: Boolean;
  protected

    procedure SetDateTime(newValue: TDateTime); override;
    function DataLink_GetReadOnly: Boolean;
    procedure DataLink_SetReadOnly(Value: Boolean);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetModified(newValue : Boolean); override;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CloseUp(AcceptValue : boolean); override;
    procedure DropDown; override;
    procedure SpinUpClick(Sender : TObject; Increment : Double);
    procedure SpinDownClick(Sender : TObject; Increment : Double);
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
    property ReadOnly: Boolean read DataLink_GetReadOnly write DataLink_SetReadOnly
      default False;
    property NowForNULLValues: Boolean read FNowForNULLValues write
        FNowForNULLValues default False;
    property UnassignedAllowed default True;
    property DisplayReadOnlyOptions;
  end;

implementation

constructor TElDBDateTimePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  UnassignedAllowed := true;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnActiveChange := ActiveChange;
  FButton.OnUpClick := SpinUpClick;
  FButton.OnDownClick := SpinDownClick;
  FIgnoreReadOnlyState := not DisplayReadOnlyOptions.Enabled;
end;

destructor TElDBDateTimePicker.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

procedure TElDBDateTimePicker.SpinUpClick(Sender : TObject; Increment : Double);
begin
  if not (ReadOnly or GetDBReadOnlyState) then
    FDataLink.Edit;
  inherited SpinUpClick(Sender, Increment);
end;

procedure TElDBDateTimePicker.SpinDownClick(Sender : TObject; Increment : Double);
begin
  if not (ReadOnly or GetDBReadOnlyState) then
    FDataLink.Edit;
  inherited SpinDownClick(Sender, Increment);
end;

procedure TElDBDateTimePicker.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not FDataLink.Editing;
  Refresh;
end;

procedure TElDBDateTimePicker.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBDateTimePicker.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := TLMDPtrInt(FDataLink);
end;

procedure TElDBDateTimePicker.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FDataLink.Field.IsNull then
    begin
      if not NowForNullValues then
      begin
        Unassigned := true;
        DateTime := FDataLink.Field.AsDateTime;
      end
      else
      begin
        Unassigned := true;
        DateTime := Now;
      end;
    end
    else
    begin
      Unassigned := false;
      DateTime := FDataLink.Field.AsDateTime;
    end;
  end;
  Modified := false;
end;

function TElDBDateTimePicker.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBDateTimePicker.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBDateTimePicker.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBDateTimePicker.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElDBDateTimePicker.DataLink_GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBDateTimePicker.DataLink_SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
  inherited ReadOnly := GetDBReadOnlyState;
  Refresh;
end;

procedure TElDBDateTimePicker.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBDateTimePicker.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElDBDateTimePicker.SetDataSource(Value: TDataSource);
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

function TElDBDateTimePicker.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElDBDateTimePicker.UpdateData(Sender: TObject);
begin
  if (not ReadOnly) and Assigned(FDataLink) and (FDataLink.Editing) then
  begin
   if Unassigned then
      FDataLink.Field.Clear
    else
      FDataLink.Field.AsDateTime := DateTime;
  end;
end;

function TElDBDateTimePicker.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElDBDateTimePicker.SetModified(newValue : Boolean);
begin
  if FModified <> newValue then
  begin
    inherited;
    if newValue then
    begin
      UpdateData(Self);
      FDataLink.Modified;
    end;
  end
  else
    inherited;
end;

procedure TElDBDateTimePicker.KeyDown(var Key : Word; Shift : TShiftState);
begin
  if not (ReadOnly and GetDBReadOnlyState) then
  begin
    if (Shift = []) then
    begin
      case Key of
        VK_UP, VK_DOWN,
        VK_NUMPAD0..VK_NUMPAD9,
        VK_BACK,
        VK_SPACE,
        VK_DELETE:
          FDataLink.Edit;
        VK_ESCAPE:
          FDataLink.Reset;
        else
         if (AnsiChar(Key) in
         ['0'..'9', 'a', 'A', 'p', 'P',
          AnsiChar(GetTimeAMChar),
          AnsiChar(GetTimePMChar),
          AnsiChar(Upcase(GetTimeAMChar)),
          AnsiChar(Upcase(GetTimePMChar)),
          AnsiChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DateSeparator),
          AnsiChar({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}TimeSeparator)]) then
              FDataLink.Edit;
      end;
    end
    else
    if (ssCtrl in Shift) then
    begin
      if not (ssShift in Shift) then
      case Key of
        Ord('V'), Ord('v'),
        Ord('X'), Ord('x'):
          FDataLink.Edit;
      end;
    end
    else
    if (ssShift in Shift) and (Key = VK_INSERT) then
      FDataLink.Edit;
    if (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
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
    end;
  end;
  inherited;
end;

procedure TElDBDateTimePicker.CMEnter(var Message: TCMEnter);
begin
  inherited;
  FDataLink.Reset;
  Modified := false;
end;

procedure TElDBDateTimePicker.CloseUp(AcceptValue : boolean);
begin
  if Assigned(FForm) {and FForm.Visible} then
  begin
    if AcceptValue then
      FDataLink.Edit;
    inherited;
  end;
end;

procedure TElDBDateTimePicker.DropDown;
begin
  if DroppedDown then
    inherited
  else
  begin
    if not (ReadOnly or GetDBReadOnlyState) then
    begin
      FDataLink.Edit;
      inherited;
    end
    else
      FCalButton.Down := false;
  end;
end;

procedure TElDBDateTimePicker.SetDateTime(newValue: TDateTime);
begin
  if not (ReadOnly or GetDBReadOnlyState) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
    and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))
    and (FDataLink.DataSet.Active) and ((newValue <> FDataLink.Field.Value) and (not Unassigned)) then
  begin
    FDataLink.DataSet.Edit;
    inherited;
    if newValue = 0 then
    inherited SetDateTime(2);
    SetModified(True);
  end
  else
    inherited;
end;

procedure TElDBDateTimePicker.ActiveChange(Sender: TObject);
begin
  inherited ReadOnly := GetDBReadOnlyState;
end;

function TElDBDateTimePicker.GetDBReadOnlyState: Boolean;
begin
  Result := DBCheckReadOnlyState(FDataLink);
end;

end.
