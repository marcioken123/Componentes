unit LMDTextDBLabel;
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

LMDTextDBLabel unit (JH)
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
  Windows, DB,
  DBCtrls,
  Controls,
  StdCtrls,
  Classes,
  Messages,
  LMDTextCustomLabel;

type
  TLMDTextDBLabel = class (TLMDTextCustomLabel)
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
    function GetLabelText : String; override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Field: TField read GetField;
    function UseRightToLeftAlignment: Boolean; override;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

implementation

{ ------------------------- private ------------------------------------------ }
procedure TLMDTextDBLabel.DataChange(Sender: TObject);
begin
  Caption:=GetFieldText;
  ReParse;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBLabel.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextDBLabel.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDTextDBLabel.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{------------------------------------------------------------------------------}
function TLMDTextDBLabel.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{------------------------------------------------------------------------------}
function TLMDTextDBLabel.GetFieldText:String;
begin
  if FDataLink.Field<>nil then
    begin
      if FDataLink.Field.IsBlob then
        Result:=FDataLink.Field.AsString+#13
      else
        Result:=FDataLink.Field.DisplayText + #13;
    end
  else
    if csDesigning in ComponentState then Result := Name else Result := '';
end;

{------------------------------------------------------------------------------}
function TLMDTextDBLabel.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{------------------------------------------------------------------------------}

procedure TLMDTextDBLabel.CMGetDataLink(var Message: TMessage);

begin
  Message.Result:=LRESULT(FDataLink);
  end;

{------------------------------ Protected -------------------------------------}
function TLMDTextDBLabel.GetLabelText:String;
begin
  if csPaintCopy in ControlState then
    Result:=GetFieldText
  else
    Result:=Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextDBLabel.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDTextDBLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------------------------------------------------------------------}
function TLMDTextDBLabel.UseRightToLeftAlignment: Boolean;
begin
  Result:=DBUseRightToLeftAlignment(Self, Field);
end;

{------------------------------ Public ----------------------------------------}
constructor TLMDTextDBLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextDBLabel.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBLabel.Paint;
begin
  TextSettings.Parse (GetLabelText);
  inherited Paint;
end;

(*{------------------------------------------------------------------------------}
function TLMDTextDBLabel.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

{------------------------------------------------------------------------------}
function TLMDTextDBLabel.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end; *)

end.
