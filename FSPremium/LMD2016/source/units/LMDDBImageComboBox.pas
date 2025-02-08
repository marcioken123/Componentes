unit LMDDBImageComboBox;
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

LMDDBImageComboBox unit ()
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, DB,
  DBCtrls,
  Messages,
  Classes,
  Controls,
  LMDCustomImageComboBox,
  LMDDBBase;

type
  {---------------------------- TLMDDBImageComboBox ---------------------------}
  TLMDDBImageComboBox = class (TLMDCustomImageComboBox, IDataControl)
  private
    FDataLink : TFieldDataLink;
    function GetDataField : String;
    function GetDataSource : TDataSource;
    function GetReadOnly : Boolean;
    procedure SetReadOnly (aValue : Boolean);
    procedure SetDataSource (aValue : TDataSource);
    procedure SetDataField (const aValue : String);
    procedure DataChange (Sender : TObject);
    procedure UpdateData(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure CMExit (var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure Change; override;
    function GetFieldValue:Integer;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    destructor Destroy; override;
  published
    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property DataField: string read GetDataField write SetDataField;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  end;

implementation

uses
  LMDProcs;

{ ------------------------------- private -------------------------------------}
function TLMDDBImageComboBox.GetDataField : String;
begin
  Result := FDataLink.FieldName;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBImageComboBox.GetDataSource : TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBImageComboBox.GetReadOnly : Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageComboBox.SetReadOnly (aValue : Boolean);
begin
  FDataLink.ReadOnly := aValue;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageComboBox.SetDataSource (aValue : TDataSource);
begin
  FDataLink.DataSource := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageComboBox.SetDataField (const aValue : String);
begin
  FDataLink.FieldName := aValue;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageComboBox.DataChange (Sender : TObject);
begin
  if (FDataLink.Field<>nil) and not FDataLink.Field.IsNull then
    if (FDataLink.Field.AsInteger>-1) and (FDataLink.Field.AsInteger<Items.Count) then
      begin
        ItemIndex:=FDataLink.Field.AsInteger;
        exit;
      end;
  ItemIndex:=-1
end;

{ -----------------------------------------------------------------------------}
function TLMDDBImageComboBox.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

procedure TLMDDBImageComboBox.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsInteger := ItemIndex; { Value, Text }
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageComboBox.EditingChange(Sender: TObject);
begin
  { inherited ReadOnly := not FDataLink.Editing; }
end;

function TLMDDBImageComboBox.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ------------------------------- protected -----------------------------------}
procedure TLMDDBImageComboBox.CNCommand(var Message: TWMCommand);
var
  h : longint;
begin
  if message.NotifyCode = CBN_SELCHANGE then
    begin
      h := ItemIndex;
      FDataLink.Edit;
      ItemIndex := h;
    end;
  inherited;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageComboBox.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

{------------------------------------------------------------------------------}
function TLMDDBImageComboBox.GetFieldValue:Integer;
begin
  result:=-1;
  if (FDataLink.Field<>nil) and not FDataLink.Field.IsNull then
    if FDataLink.Field.AsInteger<Items.Count then result:=FDataLink.Field.AsInteger;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDDBImageComboBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageComboBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
end;

{ ------------------------------- public --------------------------------------}
constructor TLMDDBImageComboBox.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ -----------------------------------------------------------------------------}
destructor TLMDDBImageComboBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBImageComboBox.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
