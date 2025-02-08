unit LMDDBRadioButton;
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

LMDDBRadioButton unit (JH)
--------------------------

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
  LMDRadioButton,
  LMDDBBase;

const
  tf : array [0..1] of string = ('false','true');

type
  {------------------------------- TLMDDBCheckBox -----------------------------}
  TLMDDBRadioButton = class(TLMDRadioButton, IDataControl)
  private
    FDataLink : TFieldDataLink;
    FValue    : String;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean; reintroduce;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValue(const Value: string);
    procedure UpdateData(Sender: TObject);
    function ValueMatch(const ValueList, Value: string): Boolean;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    procedure SetChecked(aValue: Boolean); override;
    function isSibling (aControl: TControl) : Boolean; override;
    function CanModify: Boolean;override;
    function GetFieldState: Boolean;
//    procedure Toggle; override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Checked;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField;
//    property State;
  published
    property About;
    property Alignment;
//    property AllowGrayed;
    property AutoSize;
    property Caption;
    property Color;
    property Ctl3D;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusStyle;
    property FocusColor;
    property UseFocusColor;
    property Font;
    property Font3D;
//    property GlyphNumber;
    property GlyphTransparent;
    property GlyphTransparentColor;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property UseBitmap;
    property Value: string read FValue write SetValue;
    property Visible;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

implementation

uses
  SysUtils,
  DBConsts;

{ ----------------------------------- private -------------------------------- }
function TLMDDBRadioButton.GetFieldState: Boolean;
var
  Text: string;
begin
  result := false;
  if FDatalink.Field <> nil then
    if FDataLink.Field.DataType = ftBoolean then
      result := AnsiCompareStr (tf[Ord(FDataLink.Field.AsBoolean)], FValue) = 0
    else
      begin
        Text := FDataLink.Field.Text;
        if ValueMatch(FValue, Text) then
          result := true
      end
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioButton.GetDataSource: TDataSource;
begin
  result := FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioButton.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioButton.GetDataField: string;
begin
  result := FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioButton.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioButton.GetReadOnly: Boolean;
begin
  result := FDataLink.ReadOnly;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioButton.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioButton.GetField: TField;
begin
  result := FDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioButton.DataChange(Sender: TObject);
begin
  Checked := GetFieldState;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioButton.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioButton.UpdateData(Sender: TObject);
var
  Pos: Integer;
  S: string;
begin
  if not Checked then exit; //other radiobutton will do the job
  if FDataLink.Field.DataType = ftBoolean then
    FDataLink.Field.AsBoolean := AnsiCompareStr (tf[Ord(FDataLink.Field.AsBoolean)], FValue) = 0
  else
    begin
      S := FValue;
      Pos := 1;
      FDataLink.Field.Text := ExtractFieldName(S, Pos);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioButton.ValueMatch(const ValueList, Value: string): Boolean;
var
  Pos: Integer;
begin
  result := False;
  Pos := 1;
  while Pos <= Length(ValueList) do
    if AnsiCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
    begin
      result := True;
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioButton.SetValue(const Value: string);
begin
  FValue := Value;
  DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioButton.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDBRadioButton.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioButton.WMPaint(var Message: TWMPaint);
begin
  inherited
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDDBRadioButton.SetChecked(aValue: Boolean);
begin
  if Checked <> aValue then
    begin
      inherited SetChecked (aValue);
      //if FDataLink.Edit then
      FDataLink.Modified;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioButton.isSibling (aControl: TControl) : Boolean;
begin
  result := (aControl <> Self) and (aControl is TLMDDBRadioButton);
  if result then
    result := (DataSource = (aControl as TLMDDBRadioButton).DataSource) and
              (Field = (aControl as TLMDDBRadioButton).Field);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRadioButton.CanModify: Boolean;
begin
  result:=FDataLink.Edit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioButton.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDDBRadioButton.Toggle;
begin
  if FDataLink.Edit then
    begin
      inherited Toggle;
      FDataLink.Modified;
    end;
end;}

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRadioButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #8, ' ':
      FDataLink.Edit;
    #27:
      FDataLink.Reset;
  end;
end;

{ --------------------------------------- public ----------------------------- }
constructor TLMDDBRadioButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle{+[csReplicatable]};
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBRadioButton.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;
function TLMDDBRadioButton.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }

function TLMDDBRadioButton.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
