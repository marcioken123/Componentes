unit LMDTextDBPanel;
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

LMDTextDBPanel unit (JH)
------------------------

ToDo
----

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DB,
  DBCtrls,
  LMDText;

type
  TLMDTextDB = class (TLMDText)
  private
    FDataLink: TFieldDataLink;
    procedure SetDataField(const aValue:string);
    procedure SetDataSource(aValue:TDataSource);
    function GetDataField:string;
    function GetDataSource:TDataSource;
    function GetField:TField;
    function GetFieldText:string;
    procedure DataChange(Sender:TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    function UseRightToLeftAlignment: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

implementation

{ ------------------------- private ------------------------------------------ }
procedure TLMDTextDB.DataChange(Sender: TObject);
begin
  Caption:=GetFieldText;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDB.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextDB.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDTextDB.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{------------------------------------------------------------------------------}
function TLMDTextDB.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{------------------------------------------------------------------------------}
function TLMDTextDB.GetFieldText:String;
begin
  if FDataLink.Field<>nil then
    Result:=FDataLink.Field.DisplayText
  else
    if csDesigning in ComponentState then Result := Name else Result := '';
end;

{------------------------------------------------------------------------------}
function TLMDTextDB.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextDB.CMGetDataLink(var Message: TMessage);
begin
  Message.Result:=Integer(FDataLink);
end;

{------------------------------ Protected -------------------------------------}
function TLMDTextDB.GetLabelText:String;
begin
  if csPaintCopy in ControlState then
    Result:=GetFieldText
  else
    Result:=Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextDB.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDTextDB.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------------------------------------------------------------------}
function TLMDTextDB.UseRightToLeftAlignment: Boolean;
begin
  Result:=DBUseRightToLeftAlignment(Self, Field);
end;

{------------------------------ Public ----------------------------------------}
constructor TLMDTextDB.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDTextDB.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDTextDB.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

{------------------------------------------------------------------------------}
function TLMDTextDB.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

end.
