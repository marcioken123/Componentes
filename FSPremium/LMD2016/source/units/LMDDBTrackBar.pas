unit LMDDBTrackBar;
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

LMDDBTrackBar unit ()
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
  Messages,
  Classes,
  Controls,
  LMDCustomTrackBar,
  LMDDBBase;

type
  {----------------------------- TLMDDBTrackBar -------------------------------}
  TLMDDBTrackBar = class (TLMDCustomTrackBar, IDataControl)
  private
    FDataLink : TFieldDataLink;
    function GetDataField : String;
    function GetDataSource : TDataSource;
    function GetReadOnly : Boolean;reintroduce;
    procedure SetReadOnly (aValue : Boolean);
    procedure SetDataSource (aValue : TDataSource);
    procedure SetDataField (const aValue : String);
    procedure DataChange (Sender : TObject);
    procedure UpdateData(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    procedure CMExit (var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure Change; override;
    procedure DoEnter; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
    function GetPosition:Integer;override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure MouseDown(Button:TMouseButton;Shift:TShiftState; x,y:Integer);override;
    procedure MouseMove(Shift:TShiftState; x,y:Integer);override;
    procedure Paint;override;
  public
    constructor Create(AOwner: TComponent); override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    destructor Destroy; override;
  published
    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property DataField: string read GetDataField write SetDataField;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  end;

implementation
uses
  sysutils;
{ ------------------------------- private -------------------------------------}
function TLMDDBTrackBar.GetDataField : String;
begin
  Result := FDataLink.FieldName;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBTrackBar.GetDataSource : TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBTrackBar.GetReadOnly : Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.SetReadOnly (aValue : Boolean);
begin
  FDataLink.ReadOnly := aValue;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.SetDataSource (aValue : TDataSource);
begin
  FDataLink.DataSource := aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.SetDataField (const aValue : String);
begin
  FDataLink.FieldName := aValue;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.DataChange (Sender : TObject);
begin
  if FDataLink.Field <> nil then
    begin
      if {FFocused and} FDataLink.CanModify then
        begin
          Position := FDataLink.Field.AsInteger;
        end
      else
        begin
          Position := FDataLink.Field.AsInteger;
        end;
    end
  else
    Position:=MinValue;
end;

{ -----------------------------------------------------------------------------}
function TLMDDBTrackBar.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

procedure TLMDDBTrackBar.UpdateData(Sender: TObject);
begin
  FDataLink.Field.AsInteger := Position;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.EditingChange(Sender: TObject);
begin
  {ReadOnly := not FDataLink.Editing;}
end;

function TLMDDBTrackBar.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ -----------------------------------------------------------------------------}

procedure TLMDDBTrackBar.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
end;

{ ------------------------------- protected -----------------------------------}
procedure TLMDDBTrackBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  p : LongInt;
begin
  if not FDataLink.Edit then exit;
  p := Position;
  inherited KeyDown(Key, Shift);
  if p <> Position then
    FDataLink.Edit;
end;

{------------------------------------------------------------------------------}
function TLMDDBTrackBar.GetPosition:Integer;
begin
  if not (csPaintCopy in ControlState) then
    result:=Position
  else
    if FDataLink.Field<>nil then
      result:=FDataLink.Field.AsInteger
    else
      result:=0;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p : LongInt;
begin
  if not FDataLink.Edit then exit;
  p := Position;
  inherited MouseDown(Button, Shift, X, Y);
  if p <> Position then
    FDataLink.Edit;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  p: LongInt;
begin
  //if not FDataLink.Edit then exit;  // RM Oct 2003
  p := Position;
  inherited MouseMove(Shift, X, Y );
  if p <> Position then
    FDataLink.Edit;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.DoEnter;
begin
  if Parent.ClassName = 'TDBCtrlPanel' then
    Paint
  else
    inherited DoEnter;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDDBTrackBar.Paint;
begin
  if csPaintCopy in ControlState then
  begin
    PaintPos; //(GetPosition)
    DrawThumb(GetPosition, FBRect, FBack, FSliding);
  end
  else
    inherited Paint;
end;

{ ------------------------------- public --------------------------------------}
constructor TLMDDBTrackBar.Create(AOwner: TComponent);
begin
  inherited Create (AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ -----------------------------------------------------------------------------}
destructor TLMDDBTrackBar.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBTrackBar.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
