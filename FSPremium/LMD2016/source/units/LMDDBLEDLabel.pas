unit LMDDBLEDLabel;
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

LMDDBLEDLabel unit ()
---------------------

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
  Messages,
  Controls,
  LMDLEDCustomLabel,
  LMDDBBase;

type
  {------------------------------- TLMDDBLEDLabel -----------------------------}
  TLMDDBLEDLabel = class(TLMDLEDCustomLabel, IDataControl)
  private
    FDataLink:TFieldDatalink;
    function GetDataField :string;
    function GetFieldText:String;
    function GetDataSource: TDataSource;
    procedure SetDataField(const aValue :string);
    procedure SetDataSource(aValue :TDatasource);
    procedure DataChange(Sender :TObject);

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    function GetLabelText:string; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
  published
    property DataField:string read GetDataField write SetDataField;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
  end;

implementation

uses
  LMDLED,
  LMDProcs;

{************************ Class TLMDDBLEDLabel*********************************}
{--------------------------- Private ------------------------------------------}
function TLMDDBLEDLabel.GetDataSource: TDataSource;
begin
  result := FDatalink.Datasource;
end;

{------------------------------------------------------------------------------}
{data link}
procedure TLMDDBLEDLabel.SetDataField(const aValue :string);
begin
  FDatalink.Fieldname := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBLEDLabel.SetDataSource(aValue :TDatasource);
begin
  FDatalink.Datasource := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDDBLEDLabel.GetDataField :string;
begin
  result := FDataLink.Fieldname;
end;

{------------------------------------------------------------------------------}
function TLMDDBLEDLabel.GetFieldText:String;
begin
  if FDataLink.Field<>nil then
    begin
      if Style=lsString then
        Result:=FDataLink.Field.DisplayText
      else
        result:=ValueString(FDataLink.Field.AsInteger);
    end
  else
    if csDesigning in ComponentState then Result := Name else Result := '';
end;

{------------------------------------------------------------------------------}
procedure TLMDDBLEDLabel.DataChange(Sender :TObject);
begin
  Caption:=GetFieldText;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBLEDLabel.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{---------------------- Protected ---------------------------------------------}
function TLMDDBLEDLabel.GetLabelText:String;
begin
  if csPaintCopy in ControlState then
    Result:=GetFieldText
  else
    Result:=Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBLEDLabel.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBLEDLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{----------------------- Public -----------------------------------------------}
constructor TLMDDBLEDLabel.Create(AOwner :TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  FDatalink := TFieldDatalink.Create;
  FDatalink.Control:=self;
  FDatalink.OnDataChange := DataChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBLEDLabel.Destroy;
begin
  FDatalink.Free;
  FDataLink:=nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDDBLEDLabel.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

{------------------------------------------------------------------------------}
function TLMDDBLEDLabel.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBLEDLabel.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
