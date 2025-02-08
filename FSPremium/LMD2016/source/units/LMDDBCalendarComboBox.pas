unit LMDDBCalendarComboBox;
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

LMDDBCalendarComboBox unit (JH)
-------------------------------

DBCombobox with a drop calendar, combo box is a base edit descendant (effects)

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Messages,
  Controls,
  db, dbctrls,
  LMDCalendarComboBox,
  LMDDBBase;

type

  TLMDDBCalendarComboBox = class (TLMDCalendarComboBox, IDataControl)
  private
    FDataLink     : TFieldDataLink;
    FOnDataChange : TNotifyEvent;
    Fdatesub      : Boolean;
    FReadOnly     : Boolean;
    procedure SetDataField(const aValue:string);
    procedure SetDataSource(aValue:TDataSource);
    function GetDataField:string;
    function GetDataSource:TDataSource;
    function GetField:TField;
    procedure DataChange (Sender: TObject);
    procedure EditingChange (Sender: TObject);
    procedure UpDateData (Sender: TObject);
    procedure CMEnter (var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit (var Msg: TCMExit); message CM_EXIT;
    procedure WMChar (var Msg: TWMChar); message WM_CHAR;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure ChangedText (At : Integer); override;
    procedure BeforeChangeText; override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure DoDateSel(Sender: TObject; Date: TDateTime); override;
    procedure DrawEditText(from : Integer); override;
    procedure Accept; override;
    procedure Cancel; override;
    procedure BeforeDropDown; override;
    function CanDropDown: Boolean; override;
    procedure Loaded; override;
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField;
  published
    property Alignment;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnDataChange:TNotifyEvent read FOnDataChange write FOnDataChange;
    property OnBtnClick;
  end;

  TLMDDBLabeledCalendarComboBox = class(TLMDDBCalendarComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

uses
  SysUtils,
  LMDCalendar;

{ ------------------------- Private ------------------------------------------ }
procedure TLMDDBCalendarComboBox.DataChange(Sender: TObject);
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
{    if csDesigning in ComponentState then
      Text := Name
    else!! -> otherwise we'll run into problems!!}
      Text := '';

  if Assigned(FOnDataChange) then FOnDataChange(Sender);

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing or FReadOnly;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCalendarComboBox.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCalendarComboBox.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.UpdateData(Sender: TObject);
begin
  FDataLink.Field.Text := Text;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.CMEnter (var Msg : TCMEnter);
begin
  FDataLink.Reset;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.CMExit (var Msg : TCMExit);
begin
  try
    if FDataLink.Edit and not FReadOnly then
      FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  FDataLink.Reset;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.WMChar (var Msg: TWMChar);
begin
  //if not FReadOnly then FDataLink.Edit;   //vb
  if GetPureText = '' then Text := DateSettings.DateToStr (Date);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.SetDataField(const aValue: string);
begin
  if aValue<>FDatalink.FieldName then
    FDataLink.FieldName:=aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCalendarComboBox.GetDataField:string;
begin
  result:=FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCalendarComboBox.GetField:TField;
begin
  result:=FDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCalendarComboBox.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBCalendarComboBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ----------------------------- Protected ------------------------------------ }
procedure TLMDDBCalendarComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.BeforeChangeText;
begin
  if not FReadOnly then FDatalink.Edit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.ChangedText (At : Integer);
begin
  inherited ChangedText(At);
  if ([csReading, csLoading]*ComponentState<>[]) then exit;
  FDataLink.Modified;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
begin
  case KeyCode of
    VK_ESCAPE : begin
                  FDataLink.Reset;
                  SelectAll;
                  KeyCode := 0;
                end;
{    VK_BACK,
    ^H, ^V, ^X,
    VK_DELETE : begin
                  FDataLink.Edit;
                end;}

    VK_UP,
    VK_DOWN: if FReadOnly then exit;

    VK_SPACE,
    VK_BACK,
    41..255: if not FReadOnly then
               if not ((ssCtrl in Shift) and (KeyCode in [65,67,97,99])) then //vb
                 FDataLink.Edit;
    end;
  inherited GetCommandKey (Keycode, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.DoDateSel(Sender: TObject; Date: TDateTime);
begin
  FDataLink.Edit;
  inherited DoDateSel(Sender, Date);
  FDataLink.Modified;
end;

{ ----------------------------- Public --------------------------------------- }
constructor TLMDDBCalendarComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  FReadOnly := false;
  ControlStyle := ControlStyle + [csReplicatable];
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBCalendarComboBox.Destroy;
begin
  FDataLink.OnDataChange:=nil;
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.DrawEditText (from : Integer);
begin
  if (csPaintCopy in ControlState) and (FDataLink.Field <> nil) and not (csDesigning in ComponentState) then
    Text := FDataLink.Field.DisplayText;
  inherited DrawEditText (from);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.Accept;
begin
  inherited Accept;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.Cancel;
begin
  inherited Cancel;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCalendarComboBox.BeforeDropDown;
begin
  //FDataLink.Edit;
  Fdatesub := false;
  if Text = '' then
    begin
      Text := DateSettings.DateToStr (Date);
      Fdatesub := true;
    end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCalendarComboBox.CanDropDown: Boolean;
begin
  result:=false;
  if FReadOnly then exit;
  FDatalink.Edit;
  result := FDataLink.Editing ;
  if result then
    result:=inherited CanDropDown;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCalendarComboBox.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDDBLabeledCalendarComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
