unit LMDDBColorComboBox;
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

LMDDBColorComboBox unit ()
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
  Graphics,
  LMDCustomColorComboBox,
  LMDDBBase;

type
  {----------------------------- TLMDDBColorComboBox --------------------------}
  TLMDDBColorComboBox = class (TLMDCustomColorComboBox, IDataControl)
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
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMExit (var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure Change; override;
    function GetColorValue:TColor;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
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
function TLMDDBColorComboBox.GetDataField : String;
begin
  Result := FDataLink.FieldName;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBColorComboBox.GetDataSource : TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBColorComboBox.GetReadOnly : Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBColorComboBox.SetReadOnly (aValue : Boolean);
begin
  FDataLink.ReadOnly := aValue;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBColorComboBox.SetDataSource (aValue : TDataSource);
begin
  FDataLink.DataSource := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBColorComboBox.SetDataField (const aValue : String);
begin
  FDataLink.FieldName := aValue;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBColorComboBox.DataChange (Sender : TObject);
begin
  If DroppedDown then exit;
  SelectedColor:=GetColorValue;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBColorComboBox.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

procedure TLMDDBColorComboBox.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsInteger := SelectedColor;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBColorComboBox.EditingChange(Sender: TObject);
begin
{  ReadOnly := not FDataLink.Editing;}
end;

function TLMDDBColorComboBox.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBColorComboBox.CNCommand(var Message: TWMCommand);
var
  h : longint;
begin
  if (FDataLink.Field = nil) or not (FDataLink.CanModify) then exit;
  if message.NotifyCode = CBN_SELCHANGE then
    begin
      h := SelectedColor;
      FDataLink.Edit;
      SelectedColor := h;
    end;
  inherited;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDDBColorComboBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBColorComboBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
end;

{ ------------------------------- protected -----------------------------------}
procedure TLMDDBColorComboBox.Change;
begin
  //FDataLink.Edit;
  inherited Change;
  FDataLink.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDDBColorComboBox.GetColorValue;
begin
  result:=clNone;
  if (FDataLink.Field<>nil) and not FDataLink.Field.IsNull then
    result:=TColor(FDataLink.Field.AsInteger)
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBColorComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{ ------------------------------- public --------------------------------------}
constructor TLMDDBColorComboBox.Create(AOwner: TComponent);
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
destructor TLMDDBColorComboBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;
{ ---------------------------------------------------------------------------- }

function TLMDDBColorComboBox.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
