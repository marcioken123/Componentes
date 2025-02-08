unit LMDDBSwitch;
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

LMDDBSwitch unit ()
-------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, DB, DBCtrls, SysUtils,  Messages, Classes, Graphics, Controls, menus,
  LMDClass, LMDGraph, LMDCustomSwitch, LMDDBBase;

type

  {------------------------------- TLMDDBSwitch -------------------------------}
  TLMDDBSwitch = class(TLMDCustomSwitch, IDataControl)
  private
    FDataLink:TFieldDatalink;
    FValueCheck: string;
    FValueUncheck: string;

    function GetDataField :string;
    function GetDataSource: TDataSource;

    function GetReadOnly: Boolean;

    procedure SetDataField(const aValue :string);
    procedure SetDataSource(aValue :TDatasource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValueCheck(const Value: string);
    procedure SetValueUncheck(const Value: string);

    procedure DataChange(Sender :TObject);
    procedure UpdateData(Sender: TObject);
    function ValueMatch(const ValueList, Value: string): Boolean;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
   protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    procedure Toggle;override;
  public
    constructor Create(AOwner :TComponent); override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    destructor Destroy; override;
  published
    property DataField :string read GetDataField write SetDataField;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ValueChecked: string read FValueCheck write SetValueCheck;
    property ValueUnchecked: string read FValueUncheck write SetValueUncheck;
  end;

  {------------------------------- TLMDDBWSwitch -------------------------------}
  TLMDDBWSwitch = class(TLMDWCustomSwitch, IDataControl)
  private
    FDataLink:TFieldDatalink;
    FValueCheck: string;
    FValueUncheck: string;

    function GetDataField :string;
    function GetDataSource: TDataSource;

    procedure SetDataField(const aValue :string);
    procedure SetDataSource(aValue :TDatasource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValueCheck(const Value: string);
    procedure SetValueUncheck(const Value: string);

    procedure DataChange(Sender :TObject);
    procedure UpdateData(Sender: TObject);
    function ValueMatch(const ValueList, Value: string): Boolean;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
   protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    procedure Toggle;override;
    function GetReadOnly: Boolean; override;
  public
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
  published
    property DataField :string read GetDataField write SetDataField;
    property DataSource:TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ValueChecked: string read FValueCheck write SetValueCheck;
    property ValueUnchecked: string read FValueUncheck write SetValueUncheck;
  end;

implementation
uses
  DBConsts;

{************************ Class TLMDDBSwitch **********************************}
{------------------------------- Private --------------------------------------}
function TLMDDBSwitch.GetDataField :string;
begin
  result := FDataLink.Fieldname;
end;

{------------------------------------------------------------------------------}
function TLMDDBSwitch.GetDataSource: TDataSource;
begin
  result := FDatalink.Datasource;
end;

{------------------------------------------------------------------------------}
function TLMDDBSwitch.GetReadOnly:Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSwitch.SetDataField(const aValue:string);
begin
  FDatalink.Fieldname := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSwitch.SetDataSource(aValue:TDatasource);
begin
  FDatalink.Datasource := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSwitch.SetReadOnly(Value:Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSwitch.SetValueCheck(const Value: string);
begin
  FValueCheck := Value;
  DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBSwitch.SetValueUncheck(const Value: string);
begin
  FValueUncheck := Value;
  DataChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSwitch.DataChange(Sender:TObject);
begin
  if FDatalink.Field<> nil then
    begin
      if FDataLink.Field.DataType = ftBoolean then
        Checked := FDatalink.Field.AsBoolean
       else
         Checked:=ValueMatch(FValueCheck, FDataLink.Field.Text);
    end
  else
    Checked:=False;
end;

{------------------------------------------------------------------------------}
function TLMDDBSwitch.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

procedure TLMDDBSwitch.UpdateData(Sender: TObject);
var
  Pos: Integer;
  S: string;
begin
  if FDataLink.Field.DataType = ftBoolean then
    FDataLink.Field.AsBoolean := Checked
  else
    begin
      if Checked then S := FValueCheck else S := FValueUncheck;
      Pos:=1;
      FDataLink.Field.Text := ExtractFieldName(S, Pos);
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBSwitch.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBSwitch.ValueMatch(const ValueList, Value: string): Boolean;
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
procedure TLMDDBSwitch.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSwitch.Toggle;
begin
  if FDataLink.Edit then
    begin
      inherited Toggle;
      FDataLink.Modified;
      //FDataLink.UpdateRecord;
    end;
end;

{------------------  Public ---------------------------------------------------}
constructor TLMDDBSwitch.Create(AOwner :TComponent);
begin
  inherited Create(AOwner);
  FValueCheck := STextTrue;
  FValueUncheck := STextFalse;
  FDatalink := TFieldDatalink.Create;
  FDatalink.OnDataChange := Datachange;
  FDataLink.OnUpdateData := UpdateData;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBSwitch.Destroy;
begin
  FDatalink.Free;
  FDataLink:=nil;
  inherited Destroy;
end;

function TLMDDBSwitch.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBSwitch.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

{************************ Class TLMDDBWSwitch **********************************}
{------------------------------- Private --------------------------------------}
function TLMDDBWSwitch.GetDataField :string;
begin
  result := FDataLink.Fieldname;
end;

{------------------------------------------------------------------------------}
function TLMDDBWSwitch.GetDataSource: TDataSource;
begin
  result := FDatalink.Datasource;
end;

{------------------------------------------------------------------------------}
function TLMDDBWSwitch.GetReadOnly:Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBWSwitch.SetDataField(const aValue:string);
begin
  FDatalink.Fieldname := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBWSwitch.SetDataSource(aValue:TDatasource);
begin
  FDatalink.Datasource := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBWSwitch.SetReadOnly(Value:Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBWSwitch.SetValueCheck(const Value: string);
begin
  FValueCheck := Value;
  DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBWSwitch.SetValueUncheck(const Value: string);
begin
  FValueUncheck := Value;
  DataChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBWSwitch.DataChange(Sender:TObject);
begin
  if FDatalink.Field<> nil then
    begin
      if FDataLink.Field.DataType = ftBoolean then
        Checked := FDatalink.Field.AsBoolean
       else
         Checked:=ValueMatch(FValueCheck, FDataLink.Field.Text);
    end
  else
    Checked:=False;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBWSwitch.UpdateData(Sender: TObject);
var
  Pos: Integer;
  S: string;
begin
  if FDataLink.Field.DataType = ftBoolean then
    FDataLink.Field.AsBoolean := Checked
  else
    begin
      if Checked then S := FValueCheck else S := FValueUncheck;
      Pos:=1;
      FDataLink.Field.Text := ExtractFieldName(S, Pos);
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBWSwitch.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBWSwitch.ValueMatch(const ValueList, Value: string): Boolean;
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
procedure TLMDDBWSwitch.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBWSwitch.Toggle;
begin
  if FDataLink.Edit then
    begin
      inherited Toggle;
      FDataLink.Modified;
      //FDataLink.UpdateRecord;
    end;
end;

{------------------  Public ---------------------------------------------------}
constructor TLMDDBWSwitch.Create(AOwner :TComponent);
begin
  inherited Create(AOwner);
  FValueCheck := STextTrue;
  FValueUncheck := STextFalse;
  FDatalink := TFieldDatalink.Create;
  FDatalink.OnDataChange := Datachange;
  FDataLink.OnUpdateData := UpdateData;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBWSwitch.Destroy;
begin
  FDatalink.Free;
  FDataLink:=nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBWSwitch.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
