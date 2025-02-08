unit LMDDBHTMLLabel;
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

LMDDBLabel unit ()
------------------

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
  Classes,
  Messages,
  LMDCustomLabel,
  LMDHTMLLabel,
  LMDDBBase;

type
  {------------------------------- TLMDDBHTMLLabel --------------------------------}
  TLMDDBHTMLLabel = class(TLMDCustomHTMLLabel, IDataControl)
  private
    FDataLink: TFieldDataLink;
    FOnDataChange: TNotifyEvent;
    FDBControl: boolean;
    procedure SetDataField(const aValue:string);
    procedure SetDataSource(aValue:TDataSource);
    function GetDataField:string;
    function GetDataSource:TDataSource;
    function GetField:TField;
    function GetFieldText:string;
    procedure DataChange(Sender:TObject);

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    function GetLabelText:string; virtual;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DBControl:Boolean read FDBControl write FDBControl; {for internal use}    
    property Field: TField read GetField;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
  published
    //---------------------------- DB ----------------------------------------//
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnDataChange:TNotifyEvent read FOnDataChange write FOnDataChange;
    //------------------------------------------------------------------------//

    property Align;
    property AutoSize;
    property Bevel;

    property Alignment;
    property Layout;
    property LineGap;
    property WordWrap;

    property Transparent;

    property OnMouseEnter;
    property OnMouseExit;

    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    {4.0}
    //properties
    property Anchors;
    property BiDiMode;
    property DragKind;
    property Constraints;
    property ParentBiDiMode;
    //events
    property OnEndDock;
    property OnStartDock;

    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation

uses
  LMDProcs;

{-------------------------- Private -------------------------------------------}
procedure TLMDDBHTMLLabel.DataChange(Sender: TObject);
begin
  Caption:=GetFieldText;
  if Assigned(FOnDataChange) then FOnDataChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBHTMLLabel.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBHTMLLabel.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDDBHTMLLabel.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{------------------------------------------------------------------------------}
function TLMDDBHTMLLabel.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{------------------------------------------------------------------------------}
function TLMDDBHTMLLabel.GetFieldText:String;
begin
  if FDataLink.Field<>nil then
    Result:=FDataLink.Field.DisplayText
  else
    if csDesigning in ComponentState then Result := Name else Result := '';
end;

{------------------------------------------------------------------------------}
function TLMDDBHTMLLabel.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{------------------------------------------------------------------------------}

procedure TLMDDBHTMLLabel.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{------------------------------ Protected -------------------------------------}
function TLMDDBHTMLLabel.GetLabelText:String;
begin
  if csPaintCopy in ControlState then
    Result:=GetFieldText
  else
    Result:=Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBHTMLLabel.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDDBHTMLLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{------------------------------------------------------------------------------}
function TLMDDBHTMLLabel.UseRightToLeftAlignment: Boolean;
begin
  Result:=DBUseRightToLeftAlignment(Self, Field);
end;

{------------------------------ Public ----------------------------------------}
constructor TLMDDBHTMLLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := DataChange;
  DBControl:=True;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBHTMLLabel.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDDBHTMLLabel.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

{------------------------------------------------------------------------------}
function TLMDDBHTMLLabel.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBHTMLLabel.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
