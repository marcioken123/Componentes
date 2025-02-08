unit LMDDBEditDBLookup;
{$I lmdcmps.INC}

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

LMDDBEditDBLookup unit (JH)
---------------------------

db connected edit control. Possible text can be looked up in connected database 

inherits lookup functionality from TLMDEditDBLookup rest similar to TLMDDBEdit

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  db, dbctrls,
  LMDBaseEdit, LMDCustomEdit, LMDEditDBLookup, LMDDBBase;

type
  TLMDDBEditDBLookup = class(TLMDEditDBLookup, IDataControl)
  private
    FDataLink      : TFieldDataLink;
    FOnDataChange  : TNotifyEvent;
    procedure SetDataField(const aValue:string);
    procedure SetDataSource(aValue:TDataSource);
    function GetDataField:string;
    function GetDataSource:TDataSource;
    function GetField:TField;
    procedure EditingChange (Sender : TObject);
    procedure UpDateData (Sender : TObject);
    procedure CMEnter (var Msg : TCMEnter); message CM_ENTER;
    procedure CMExit (var Msg : TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure DataChange (Sender : TObject); override;
    procedure lookup; override;
    procedure ChangedText (At : Integer); override;
    procedure BeforeChangeText; override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure DrawEditText(from : Integer); override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property Alignment;
    property CustomButtons;
    property CustomButtonWidth;
    property CustomButtonsStyle;
    property ReadOnly;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnDataChange:TNotifyEvent read FOnDataChange write FOnDataChange;
    property OnBtnClick;
  end;

implementation

uses
  LMDProcs;

{ ------------------------- Private ------------------------------------------ }
procedure TLMDDBEditDBLookup.DataChange(Sender: TObject);
begin
  if FDataLink.Field<>nil then
    begin
      MaxLength := FDataLink.Field.Size;
      if Focused and FDataLink.CanModify then
        Text := FDataLink.Field.Text
      else
      begin
        Text := FDataLink.Field.DisplayText;
        if FDataLink.Editing {and FDataLink.Modified} then
          Modified := True;
      end;
    end
  else
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';

  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.lookup;
begin
  inherited;
  FDataLink.Modified;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBEditDBLookup.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBEditDBLookup.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := Text;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.CMEnter (var Msg : TCMEnter);
begin
  FDataLink.Reset;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.CMExit (var Msg : TCMExit);
begin
  inherited;
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  FDataLink.Reset;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.SetDataField(const aValue: string);
begin
  if aValue<>FDataLink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBEditDBLookup.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBEditDBLookup.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBEditDBLookup.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBEditDBLookup.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ----------------------------- Protected ------------------------------------ }
procedure TLMDDBEditDBLookup.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.BeforeChangeText;
begin
  FDataLink.Edit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.ChangedText (At : Integer);
begin
  inherited ChangedText(At);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
begin
  case KeyCode of
    VK_ESCAPE : begin
                  FDataLink.Reset;
                  SelectAll;
                  KeyCode := 0;
                end;
 {   VK_BACK,
    ^H, ^V, ^X,
    VK_DELETE : begin
                  FDataLink.Edit;
                end;}
    VK_UP,
    VK_DOWN, {added June 02 by JH}
    VK_SPACE,
    VK_BACK,
    41..255: FDataLink.Edit;
    end;
  inherited GetCommandKey (Keycode, Shift);
end;

{ ----------------------------- Public --------------------------------------- }
constructor TLMDDBEditDBLookup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBEditDBLookup.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.Paint;
begin
  inherited Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBEditDBLookup.DrawEditText (from : Integer);
begin
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) and not (csDesigning in ComponentState) then
    Text := FDataLink.Field.DisplayText;
  inherited DrawEditText (from);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBEditDBLookup.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
