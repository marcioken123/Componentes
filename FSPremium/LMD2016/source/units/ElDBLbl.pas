unit ElDBLbl;
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

ElDBLbl unit
------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  DB,
  DBCtrls,

  LMDTypes,
  LMDElDBConst,
  LMDUnicode,
  ElHTMLLbl,
  Forms,
  Windows,
  Controls,
  StdCtrls,
  Messages,

  Classes,
  SysUtils;

type

  TElDBLabel = class(TElHTMLLabel)
  private
    FDataLink: TFieldDataLink;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
  protected
    FUnicodeMode: TElDBUnicodeMode;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetFieldText: TLMDString;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;
  end;

implementation

constructor TElDBLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
end;

destructor TElDBLabel.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBLabel.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := TLMDPtrInt(FDataLink);
end;

procedure TElDBLabel.DataChange(Sender: TObject);
begin
  Caption := GetFieldText;
end;

function TElDBLabel.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBLabel.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBLabel.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBLabel.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TElDBLabel.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBLabel.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBLabel.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TElDBLabel.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

function TElDBLabel.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

function TElDBLabel.GetFieldText: TLMDString;
{$ifdef LMD_UNICODE}
var W : WideString;
{$endif}
begin
  if not FDataLink.Active then
  begin
    if csDesigning in ComponentState then
      Result := Name
    else
      Result := ''
  end
  else
  if FDataLink.Field <> nil then
  {$ifdef LMD_UNICODE}
    if FDataLink.Field.isNull then
      W := ''
    else
    if ((UnicodeMode = umForceUTF8) or ((FDataLink.Field.DataType <> ftWideString) and (UnicodeMode = umForceUnicode))) and
       (LMDConvertUTF8toUTF16({$ifdef lmdcomp12}AnsiString{$endif}(FDataLink.Field.DisplayText), W, strictConversion, false) <> sourceIllegal)
    then
    else
    begin
      if (FDataLink.Field.DataType = ftWideString) then
        W := FDataLink.Field.Value
      else
        W := FDataLink.Field.DisplayText;
    end;
    Result := W;
  {$else}
    Result := FDataLink.Field.DisplayText;
  {$endif}
end;

end.
