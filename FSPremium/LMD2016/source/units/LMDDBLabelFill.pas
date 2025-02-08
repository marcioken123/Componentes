unit LMDDBLabelFill;
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

LMDDBLabelFill unit (??)
------------------------

database label with filled letters

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, DB,
  DBCtrls,
  Classes,
  Controls,
  Messages,
  LMDCustomLabelFill,
  LMDDBBase;

type
  {------------------------------- TLMDDBLabelFill ----------------------------}
  TLMDDBLabelFill = class(TLMDCustomLabelFill, IDataControl)
  private
    FDataLink:TFieldDatalink;
    procedure DataChange(Sender :TObject);
    function GetDataField :string;
    function GetDataSource: TDataSource;
    function GetField:TField;
    function GetFieldText:string;
    procedure SetDataField(const aValue :string);
    procedure SetDataSource(aValue :TDatasource);

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    function GetLabelText:string; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
  published
    property DataField:string read GetDataField write SetDataField;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
  end;

implementation

uses
  LMDProcs;

{------------------------------- Private --------------------------------------}
function TLMDDBLabelFill.GetDataField :string;
begin
  result := FDataLink.Fieldname;
end;

{------------------------------------------------------------------------------}
function TLMDDBLabelFill.GetDataSource: TDataSource;
begin
  result := FDatalink.Datasource;
end;

{------------------------------------------------------------------------------}
function TLMDDBLabelFill.GetField:TField;
begin
  if FDataLink <> nil then
    result := FDataLink.Field
  else
    result := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBLabelFill.SetDataField(const aValue :string);
begin
  FDatalink.Fieldname := aValue;
end;
{------------------------------------------------------------------------------}
procedure TLMDDBLabelFill.SetDataSource(aValue :TDatasource);
begin
  FDatalink.Datasource := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBLabelFill.DataChange(Sender :TObject);
begin
  Caption:=GetFieldText;
end;

{------------------------------------------------------------------------------}
function TLMDDBLabelFill.GetFieldText:String;
begin
  if FDataLink.Field<>nil then
    Result:=FDataLink.Field.DisplayText
  else
    if csDesigning in ComponentState then Result := Name else Result := '';
end;

{------------------------------------------------------------------------------}

procedure TLMDDBLabelFill.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{--------------- Protected ----------------------------------------------------}
function TLMDDBLabelFill.GetLabelText:String;
begin
  if csPaintCopy in ControlState then
    Result:=GetFieldText
  else
    Result:=Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBLabelFill.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBLabelFill.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------------------------------------------------------------------}
function TLMDDBLabelFill.UseRightToLeftAlignment: Boolean;
begin
  Result:=DBUseRightToLeftAlignment(Self, Field);
end;

{------------------  Public ---------------------------------------------------}
constructor TLMDDBLabelFill.Create(AOwner :TComponent);
begin
  inherited Create(AOwner);
    //4.01
  FillObject.OnChange:=nil;
  Painting:=True;
  ControlStyle:=ControlStyle+[csReplicatable];
  FDataLink:=TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
  DBControl:=True;
  //ShowAccelChar:=False;
  Painting:=False;
  //4.01
  FillObject.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBLabelFill.Destroy;
begin
  FDatalink.Free;
  FDataLink:=nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDDBLabelFill.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

{------------------------------------------------------------------------------}
function TLMDDBLabelFill.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBLabelFill.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
