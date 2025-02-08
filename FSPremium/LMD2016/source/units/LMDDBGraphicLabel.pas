unit LMDDBGraphicLabel;
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

LMDDBGraphicLabel unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, DB,
  Controls,
  DBCtrls,
  Classes,
  Messages,
  LMDCustomGraphicLabel,
  LMDDBBase;

type
  {------------------------------- TLMDDBGraphicLabel -------------------------}
  TLMDDBGraphicLabel = class(TLMDCustomGraphicLabel, IDataControl)
  private
    FDataLink: TFieldDataLink;
    FOnDataChange: TNotifyEvent;
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
    property About;
    property Align;
    property Attributes;
    property AutoSize;
    property Color;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Factor;
    property FillObject;
    property Font;
    property FontFX;
    property InvertCaption;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property Perspective;
    property PerspectiveDepth;
    property PopupMenu;
    property ShowHint;
    property Toggle;
    property Transform;
    property Transparent;
    property Visible;

    property OnClick;
    property OnDataChange:TNotifyEvent read FOnDataChange write FOnDataChange;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    {3.0}
    property OnMouseEnter;
    property OnMouseExit;
    {---}
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

implementation

uses
  LMDProcs;

{-------------------------- Private -------------------------------------------}
procedure TLMDDBGraphicLabel.DataChange(Sender: TObject);
begin
  if FDataLink.Field<>nil then
    Caption := FDataLink.Field.DisplayText
  else
    if csDesigning in ComponentState then
      Caption := Name
    else
      Caption := '';
  if Assigned(FOnDataChange) then FOnDataChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBGraphicLabel.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBGraphicLabel.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDDBGraphicLabel.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{------------------------------------------------------------------------------}
function TLMDDBGraphicLabel.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{------------------------------------------------------------------------------}
function TLMDDBGraphicLabel.GetFieldText:String;
begin
  if FDataLink.Field<>nil then
    Result:=FDataLink.Field.DisplayText
  else
    if csDesigning in ComponentState then Result := Name else Result := '';
end;

{------------------------------------------------------------------------------}
function TLMDDBGraphicLabel.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBGraphicLabel.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{------------------------------ Protected -------------------------------------}
function TLMDDBGraphicLabel.GetLabelText:String;
begin
  if csPaintCopy in ControlState then
    Result:=GetFieldText
  else
    Result:=Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBGraphicLabel.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBGraphicLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------------------ Public ----------------------------------------}
constructor TLMDDBGraphicLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBGraphicLabel.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDDBGraphicLabel.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

{------------------------------------------------------------------------------}
function TLMDDBGraphicLabel.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBGraphicLabel.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
