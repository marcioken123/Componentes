unit LMDTextDBViewLabel;
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

LMDTextDBViewLabel unit (JH)
----------------------------

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
  Graphics,
  LMDTextCustomLabel;

type
  TLMDTextDBViewLabel = class (TLMDTextCustomLabel)
  private
    FDataLink: TFieldDataLink;
    //procedure SetDataField(const aValue:string);
    procedure SetDataSource(aValue:TDataSource);
    //function GetDataField:string;
    function GetDataSource:TDataSource;
    function GetField:TField;
    //function GetFieldText:string;
    procedure DataChange(Sender:TObject);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    protected
    function GetLabelText:string; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    procedure DoGraphicError(Sender: TObject; aPicture: TPicture; const aFileName: String; aImageIndex: LongInt); override;
    function DoGetVariable(Sender: TObject; const aVarName: string): string; override;
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
  published
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Lines;
  end;

implementation

uses
  LMDText;

{ ------------------------- private ------------------------------------------ }
procedure TLMDTextDBViewLabel.DataChange(Sender: TObject);
begin
  ReParse;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDTextDBViewLabel.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextDBViewLabel.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
{function TLMDTextDBViewLabel.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{------------------------------------------------------------------------------}
function TLMDTextDBViewLabel.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{------------------------------------------------------------------------------}
{function TLMDTextDBViewLabel.GetFieldText:String;
begin
  if FDataLink.Field<>nil then
    Result:=FDataLink.Field.DisplayText
  else
    if csDesigning in ComponentState then Result := Name else Result := '';
end;

{------------------------------------------------------------------------------}
function TLMDTextDBViewLabel.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{------------------------------------------------------------------------------}

procedure TLMDTextDBViewLabel.CMGetDataLink(var Message: TMessage);

begin
  Message.Result:=LRESULT(FDataLink);
  end;

{------------------------------ Protected -------------------------------------}
function TLMDTextDBViewLabel.GetLabelText:string;
begin
  result := inherited GetLabelText;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextDBViewLabel.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBViewLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextDBViewLabel.UseRightToLeftAlignment: Boolean;
begin
  Result:=DBUseRightToLeftAlignment(Self, Field);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBViewLabel.DoGraphicError(Sender: TObject; aPicture: TPicture; const aFileName: String; aImageIndex: LongInt);
var
  f : TField;
begin
  //let's check whether we'll find the variable as field in the database
  if (FDataLink<>nil) and (FDataLink.DataSet <> nil) then
    begin
      f := FDataLink.DataSet.FindField (aFileName);
      if assigned (f) then
        begin
          if f.isBlob then //check whether we have a blob field here
            begin
              aPicture.Assign (f);
              exit;
            end;
        end;
     end;
  inherited DoGraphicError (Sender, aPicture, aFileName, aImageIndex);
end;

{ ---------------------------------------------------------------------------- }
function TLMDTextDBViewLabel.DoGetVariable(Sender: TObject; const aVarName: string): string;
var
  f : TField;
begin
  //let's check whether we'll find the variable as field in the database
  if (FDataLink<>nil) and (FDataLink.DataSet <> nil) then
    begin
      f := FDataLink.DataSet.FindField (aVarName);
      if assigned (f) then
        begin
          if f.isBlob then //check whether we have a blob field here
            if f.DataType = ftGraphic then
              result := aVarName
            else
              result := f.AsString
          else
            result := f.DisplayText;
          exit;
        end;
    end;
  //if not let's call the event
  result := inherited DoGetVariable (Sender, aVarName);
end;

{------------------------------ Public ----------------------------------------}
constructor TLMDTextDBViewLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnActiveChange := DataChange;
  DBControl:=True;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextDBViewLabel.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDTextDBViewLabel.Paint;
begin
  TextSettings.Parse (GetLabelText);
  inherited Paint;
end;

(*{------------------------------------------------------------------------------}
function TLMDTextDBViewLabel.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

{------------------------------------------------------------------------------}
function TLMDTextDBViewLabel.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;  *)

end.
