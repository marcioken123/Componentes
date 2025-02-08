unit LMDDBListComboBox;
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

LMDDBListComboBox unit (JH)
---------------------------

Combobox with a drop down list, combo box is a base edit descendant (effects)

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Messages,
  Controls,
  db, dbctrls,
  LMDListComboBox,
  LMDDBBase;

type
  TLMDDBListComboBox = class (TLMDListComboBox, IDataControl)
  private
    FDataLink     : TFieldDataLink;
    FOnDataChange : TNotifyEvent;
    procedure SetDataField(const aValue:string);
    procedure SetDataSource(aValue:TDataSource);
    function GetDataField:string;
    function GetDataSource:TDataSource;
    function GetField:TField;
    procedure DataChange (Sender: TObject);
    procedure EditingChange (Sender: TObject);
    procedure UpDateData (Sender: TObject);
    procedure CMEnter (var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit (var Msg: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure ChangedText (At : Integer); override;
    procedure BeforeChangeText; override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure DrawEditText(from : Integer); override;
    procedure Accept; override;
    function CanDropDown: Boolean; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property Alignment;
    property ReadOnly;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnDataChange:TNotifyEvent read FOnDataChange write FOnDataChange;
    property OnBtnClick;
  end;

  TLMDDBLabeledListComboBox = class(TLMDDBListComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

uses
  LMDProcs;

{ ------------------------- Private ------------------------------------------ }
procedure TLMDDBListComboBox.DataChange(Sender: TObject);
begin
  if FDataLink.Field<>nil then
    begin
      MaxLength := FDataLink.Field.Size;
      if Focused and FDataLink.CanModify then
        Text := FDataLink.Field.Text
      else
      begin
        Text := FDataLink.Field.DisplayText;
        if FDataLink.Editing {and FDataLink.Modified} then
          Modified := True;
      end;
    end
  else
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';

  if Assigned(FOnDataChange) then FOnDataChange(Sender);

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBListComboBox.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

function TLMDDBListComboBox.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBListComboBox.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

procedure TLMDDBListComboBox.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := Text;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBListComboBox.CMEnter (var Msg : TCMEnter);
begin
  FDataLink.Reset;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBListComboBox.CMExit (var Msg : TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  FDataLink.Reset;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBListComboBox.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBListComboBox.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBListComboBox.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBListComboBox.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBListComboBox.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBListComboBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ----------------------------- Protected ------------------------------------ }
procedure TLMDDBListComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBListComboBox.BeforeChangeText;
begin
  FDatalink.Edit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBListComboBox.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBListComboBox.ChangedText (At : Integer);
begin
  inherited ChangedText(At);
  if [csReading, csLoading]*ComponentState<>[] then exit;
  FDataLink.Modified;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBListComboBox.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
begin
  case KeyCode of
    VK_ESCAPE : begin
                  FDataLink.Reset;
                  SelectAll;
                  KeyCode := 0;
                end;
{    VK_BACK,
    ^H, ^V, ^X,
    VK_DELETE : begin
                  FDataLink.Edit;
                end;}

    VK_SPACE,
    VK_BACK,
    41..255: if not ((ssCtrl in Shift) and (KeyCode in [65,67,97,99])) then //vb
               FDataLink.Edit;
    end;
  inherited GetCommandKey (Keycode, Shift);
end;

{ ----------------------------- Public --------------------------------------- }
constructor TLMDDBListComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := true;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBListComboBox.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBListComboBox.DrawEditText (from : Integer);
begin
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) and not (csDesigning in ComponentState) then
    Text := FDataLink.Field.DisplayText;
  inherited DrawEditText (from);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBListComboBox.Accept;
begin
  FDataLink.Edit;
  inherited Accept;
  FDataLink.Modified;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBListComboBox.CanDropDown: Boolean;
begin
  result := (GetField <> nil);
  if result then
    result:=inherited CanDropDown;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBListComboBox.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDDBLabeledListComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
