unit LMDDBImageListBox;
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

LMDDBImageListBox unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DB,
  DBCtrls,
  Messages,
  Classes,
  Controls,
  Windows,
  LMDCustomImageListBox,
  LMDDBBase;

type
  {---------------------------- TLMDDBImageListBox ----------------------------}
  TLMDDBImageListBox = class (TLMDCustomImageListBox, IDataControl)
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
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure CMExit (var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure DoSelect;override;
    function GetFieldValue:Integer;override;
    procedure KeyDown(var Key: Word; Shift: TShiftState);override;
    procedure KeyPress(var Key: Char);override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    destructor Destroy; override;
  published
    property Columns;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property DataField: string read GetDataField write SetDataField;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;

    property ImageList;
    property ListIndex;
    property Items;
    property Layout;
    property ImagesOnly;
    property MultiLine;

    // 6.1 additions
    property AutoComplete;
    property LargeTextOptions;
  end;

  TLMDDBLabeledImageListBox = class(TLMDDBImageListBox)
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
  forms,
  LMDProcs;

{ ------------------------------- private -------------------------------------}
function TLMDDBImageListBox.GetDataField : String;
begin
  Result := FDataLink.FieldName;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBImageListBox.GetDataSource : TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBImageListBox.GetReadOnly : Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageListBox.SetReadOnly (aValue : Boolean);
begin
  FDataLink.ReadOnly := aValue;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageListBox.SetDataSource (aValue : TDataSource);
begin
  FDataLink.DataSource := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageListBox.SetDataField (const aValue : String);
begin
  FDataLink.FieldName := aValue;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageListBox.DataChange (Sender : TObject);
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
function TLMDDBImageListBox.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageListBox.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsInteger := ItemIndex; { Value, Text }
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageListBox.EditingChange(Sender: TObject);
begin
  { ReadOnly := not FDataLink.Editing; }
end;

function TLMDDBImageListBox.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBImageListBox.WMLButtonDown(var Message: TWMLButtonDown);
begin
  if FDataLink.Edit then
    inherited
  else
    begin
      SetFocus;
      with Message do
        MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBImageListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP,
    VK_RIGHT, VK_DOWN] then
    if not FDataLink.Edit then Key := 0;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBImageListBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #32..#255:
      if not FDataLink.Edit then Key := #0;
    #27:
      begin
        FDataLink.Reset;
        inherited DoSelect;
      end;
  end;
end;

{ ------------------------------- protected -----------------------------------}
procedure TLMDDBImageListBox.DoSelect;
begin
  if FDataLink.Edit then
    begin
      inherited DoSelect;
      FDataLink.Modified;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDDBImageListBox.GetFieldValue:Integer;
begin
  result:=-1;
  if (FDataLink.Field<>nil) and not FDataLink.Field.IsNull then
    if FDataLink.Field.AsInteger<Items.Count then result:=FDataLink.Field.AsInteger;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageListBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{ -----------------------------------------------------------------------------}

procedure TLMDDBImageListBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBImageListBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
{    SelectAll;}
    SetFocus;
    raise;
  end;
end;

{ ------------------------------- public --------------------------------------}
constructor TLMDDBImageListBox.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  ControlStyle:=ControlStyle{+[csReplicatable]};
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ -----------------------------------------------------------------------------}
destructor TLMDDBImageListBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBImageListBox.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDDBLabeledImageListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
