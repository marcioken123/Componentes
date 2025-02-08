unit LMDDBProgressFill;
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

LMDDBProgressFill unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, DB, DBCtrls, Messages, Classes, Controls,
  LMDTypes, LMDGraph, LMDCustomProgressFill, LMDDBBase;

type
  {------------------------- TLMDDBProgressFill -------------------------------}
  TLMDDBProgressFill=class(TLMDCustomProgressFill, IDataControl)
  private
    FDataLink: TFieldDataLink;
    FOnDataChange: TNotifyEvent;
    FPercentMode:Boolean;
    procedure SetDataField(const aValue:string);
    procedure SetDataSource(aValue:TDataSource);
    procedure SetPercentMode(aValue:Boolean);
    function GetDataField:string;
    function GetDataSource:TDataSource;
    function GetField:TField;
    function GetFieldValue:TLMDPercent;
    procedure DataChange(Sender:TObject);

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    function GetDrawValue:TLMDPercent; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property PercentMode: Boolean read FPercentMode write SetPercentMode default True;
    property OnDataChange:TNotifyEvent read FOnDataChange write FOnDataChange;
  end;

implementation

{-------------------------- Private -------------------------------------------}
procedure TLMDDBProgressFill.DataChange(Sender: TObject);
begin
  Position:=GetFieldValue;
  if Assigned(FOnDataChange) then FOnDataChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBProgressFill.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBProgressFill.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBProgressFill.SetPercentMode(aValue:Boolean);
begin
  if aValue<>FPercentMode then
    begin
      FPercentMode:=aValue;
      if FDataLink.Field<>nil then
        if FPercentMode then
          Position:=FDataLink.Field.AsInteger
        else
          Position:=GetPercentValue(FDataLink.Field.AsInteger)
    end;
end;

{------------------------------------------------------------------------------}
function TLMDDBProgressFill.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

{------------------------------------------------------------------------------}
function TLMDDBProgressFill.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{------------------------------------------------------------------------------}
function TLMDDBProgressFill.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{------------------------------------------------------------------------------}
function TLMDDBProgressFill.GetFieldValue:TLMDPercent;
begin
  if FDataLink.Field<>nil then
    begin
      if FPercentMode then
        result:=FDataLink.Field.AsInteger
      else
        result:=GetPercentValue(FDataLink.Field.AsInteger);
    end
  else
    result:=0;
end;

{------------------------------------------------------------------------------}
function TLMDDBProgressFill.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBProgressFill.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{------------------------------ Protected -------------------------------------}
function TLMDDBProgressFill.GetDrawValue:TLMDPercent;
begin
  if csPaintCopy in ControlState then
    Result:=GetFieldValue
  else
    Result:=Position;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBProgressFill.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBProgressFill.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------------------ Public ----------------------------------------}
constructor TLMDDBProgressFill.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDatalink.Control:=self;
  FDataLink.OnDataChange := DataChange;
  FPercentMode:=True;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBProgressFill.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBProgressFill.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBProgressFill.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
