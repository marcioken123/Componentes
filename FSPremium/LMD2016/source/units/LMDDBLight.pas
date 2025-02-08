unit LMDDBLight;
{$I lmdcmps.Inc}

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

LMDDBLight unit (RM)
--------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, DB, DBCtrls, SysUtils,  Messages, Classes, Graphics, Controls, Menus,
  LMDClass, LMDGraph, LMDCustomLight, LMDDBBase;

type

  {------------------------------- TLMDDBLight --------------------------------}
  TLMDDBLight = class(TLMDCustomLight, IDataControl)
  private
    FDataLink:TFieldDatalink;
    FValueCheck: string;
    function GetDataField :string;
    function GetDataSource: TDataSource;
    procedure SetDataField(const aValue :string);
    procedure SetDataSource(aValue :TDatasource);
    procedure SetValueCheck(const Value: string);
    procedure DataChange(Sender :TObject);
    function ValueMatch(const ValueList, Value: string): Boolean;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner :TComponent); override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    destructor Destroy; override;
  published
    property DataField :string read GetDataField write SetDataField;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
    property ValueChecked: string read FValueCheck write SetValueCheck;
  end;

implementation

uses
  DBConsts,
  LMDProcs;

{************************ Class TLMDDBLight ***********************************}
{------------------------------- Private --------------------------------------}
function TLMDDBLight.GetDataField :string;
begin
  result := FDataLink.Fieldname;
end;

{------------------------------------------------------------------------------}
function TLMDDBLight.GetDataSource: TDataSource;
begin
  result := FDatalink.Datasource;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBLight.SetDataField(const aValue :string);
begin
  FDatalink.Fieldname := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBLight.SetDataSource(aValue :TDatasource);
begin
  FDatalink.Datasource := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBLight.SetValueCheck(const Value: string);
begin
  FValueCheck := Value;
  DataChange(Self);
end;

function TLMDDBLight.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBLight.DataChange(Sender :TObject);
begin
  if FDatalink.Field<> nil then
    begin
      if FDataLink.Field.DataType = ftBoolean then
        Active := FDatalink.Field.AsBoolean
       else
         Active:=ValueMatch(FValueCheck, FDataLink.Field.Text);
    end
  else
    Active:=False;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBLight.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBLight.ValueMatch(const ValueList, Value: string): Boolean;
var
  Pos: Integer;
begin
  Result := False;
  Pos := 1;
  while Pos <= Length(ValueList) do
    if AnsiCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
    begin
      Result := True;
      Break;
    end;
end;

{--------------- Protected ----------------------------------------------------}
procedure TLMDDBLight.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------  Public ---------------------------------------------------}
constructor TLMDDBLight.Create(AOwner :TComponent);
begin
  inherited Create(AOwner);
  FDatalink := TFieldDatalink.Create;
  FDatalink.OnDataChange := Datachange;
  FValueCheck := STextTrue;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBLight.Destroy;
begin
  FDatalink.Free;
  FDataLink:=nil;
  inherited Destroy;
end;

function TLMDDBLight.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBLight.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
