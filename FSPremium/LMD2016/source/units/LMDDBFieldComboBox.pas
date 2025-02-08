unit LMDDBFieldComboBox;
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

LMDDBFieldComboBox unit (JH)
----------------------------

ComboBox for selecting a field from a database table

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DB, DBCtrls, Classes,
  LMDCustomExtCombo,
  LMDCustomListComboBox;

type
  TLMDDBFieldComboBox = class (TLMDCustomListComboBox)
  private
    FDataLink    : TFieldDataLink;
    procedure SetDataSource(aValue:TDataSource);
    function GetDataSource:TDataSource;
    procedure ActiveChange (Sender: TObject);
    function GetField: TField;
  protected
    procedure BeforeDropDown; override;
    procedure UpdateItems;
    procedure Accept; override;
    function CanDropDown: Boolean; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create (aOwner: TComponent); override;
    destructor Destroy; override;
    procedure SelectByFieldName (const aFieldName: String);
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnSelected;
  end;

implementation

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldComboBox.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
  UpdateItems;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBFieldComboBox.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldComboBox.ActiveChange (Sender: TObject);
begin
  if (Text <> '') then
    begin
      Text := '';
      FDataLink.FieldName := '';
      if Assigned (OnSelected) then OnSelected (self);
    end;
  UpdateItems;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBFieldComboBox.GetField: TField;
begin
  result:= FDataLink.Field;
end;

{ ------------------------------------- protected ---------------------------- }
procedure TLMDDBFieldComboBox.BeforeDropDown;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBFieldComboBox.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldComboBox.UpdateItems;
var
  AggList: TStringList;
begin
  Items.Clear;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
  begin
    DataSource.DataSet.GetFieldNames(Items);
    if DataSource.DataSet.AggFields.Count > 0 then
    begin
      AggList := TStringList.Create;
      try
        DataSource.DataSet.AggFields.GetFieldNames(AggList);
        Items.AddStrings(AggList);
      finally
        AggList.Free;
      end;
    end;
  end
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldComboBox.Accept;
begin
  if not NoneSelected then
    FDataLink.FieldName := GetSelectedText;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBFieldComboBox.CanDropDown: Boolean;
begin
  result := (FDataLink.DataSource <> nil) and (FDataLink.DataSource.DataSet <> nil);
  if result then
    result:=inherited CanDropDown;
end;

{ ------------------------------------- public ------------------------------- }
procedure TLMDDBFieldComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldComboBox.Loaded;
begin
  inherited;
  Style := csDropDownList;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDBFieldComboBox.Create (aOwner: TComponent);
begin
  inherited Create (aOwner);
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnActiveChange := ActiveChange;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBFieldComboBox.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBFieldComboBox.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBFieldComboBox.SelectByFieldName (const aFieldName: String);
begin
  SelectItem (aFieldName);  
end;

end.
