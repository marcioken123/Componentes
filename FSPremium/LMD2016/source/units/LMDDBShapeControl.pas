unit LMDDBShapeControl;
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

LMDDBShapeControl unit ()
-------------------------

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
  LMDShapeControl,
  LMDDBBase;

type
  {------------------------------- TLMDDBShapeControl -------------------------}
  TLMDDBShapeControl=class(TLMDShapeControl, IDataControl)
  private
    FDataLink: TFieldDataLink;
    FOnDataChange: TNotifyEvent;
    procedure SetCaption(aValue:Boolean);
    procedure SetDataField(const aValue:string);
    procedure SetDataSource(aValue:TDataSource);
    function GetDataField:string;
    function GetDataSource:TDataSource;
    function GetField:TField;
    function GetFieldText:String;
    procedure DataChange(Sender:TObject);

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure GetChange(Sender:TObject);override;
    function GetLabelText:string; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnDataChange:TNotifyEvent read FOnDataChange write FOnDataChange;
  end;

implementation

{-------------------------- Private -------------------------------------------}
procedure TLMDDBShapeControl.DataChange(Sender: TObject);
begin
  SetCaption(True);
  if Assigned(FOnDataChange) then FOnDataChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBShapeControl.SetCaption(aValue:Boolean);
begin
  Caption.BeginUpdate;
  try
    Caption.Caption:=GetFieldText;
  finally
    Caption.EndUpdate(aValue);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBShapeControl.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBShapeControl.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDDBShapeControl.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{------------------------------------------------------------------------------}
function TLMDDBShapeControl.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{------------------------------------------------------------------------------}
function TLMDDBShapeControl.GetFieldText:String;
begin
  if FDataLink.Field<>nil then
    Result:=FDataLink.Field.DisplayText
 else
   if csDesigning in ComponentState then Result := Name else Result := '';
end;

{------------------------------------------------------------------------------}
function TLMDDBShapeControl.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBShapeControl.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{------------------------------ Protected -------------------------------------}
procedure TLMDDBShapeControl.GetChange(Sender: TObject);
begin
  if Sender=Caption then SetCaption(false);
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
function TLMDDBShapeControl.GetLabelText:String;
begin
  if csPaintCopy in ControlState then
    Result:=GetFieldText
  else
    Result:=Caption.Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBShapeControl.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBShapeControl.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------------------ Public ----------------------------------------}
constructor TLMDDBShapeControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control:=self;
  FDataLink.OnDataChange := DataChange;
  SetCaption(false);
end;

{------------------------------------------------------------------------------}
destructor TLMDDBShapeControl.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDDBShapeControl.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

{------------------------------------------------------------------------------}
function TLMDDBShapeControl.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBShapeControl.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
