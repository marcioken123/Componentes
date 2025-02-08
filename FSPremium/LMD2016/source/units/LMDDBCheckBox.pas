unit LMDDBCheckBox;
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

LMDDBCheckBox unit ()
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
  Controls,
  StdCtrls,
  Classes,
  Messages,
  LMDCustomCheckBox,
  LMDDBBase;

type
  {------------------------------- TLMDDBCheckBox -----------------------------}
  TLMDDBCheckBox = class(TLMDCustomCheckBox, IDataControl)
  private
    FDataLink: TFieldDataLink;
    FValueCheck: string;
    FValueUncheck: string;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean; reintroduce;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure SetValueCheck(const Value: string);
    procedure SetValueUncheck(const Value: string);
    procedure UpdateData(Sender: TObject);
    function ValueMatch(const ValueList, Value: string): Boolean;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
  protected
    //  Implement   IDataControl.GetDataLink
    function GetDataLink: TDataLink;
    function CanModify: Boolean;override;
    function GetFieldState: TCheckBoxState;override;
    procedure Toggle; override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent;Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Checked;
    function ExecuteAction(AAction: TBasicAction): Boolean; override;
    function UpdateAction(AAction: TBasicAction): Boolean; override;
    property Field: TField read GetField;
    property State;
  published
    property About;
    property Alignment;
    property AllowGrayed;
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
    property GlyphNumber;
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
    property ValueChecked: string read FValueCheck write SetValueCheck;
    property ValueUnchecked: string read FValueUncheck write SetValueUncheck;
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
  DBConsts,
  LMDProcs;

{ ----------------------------------- private -------------------------------- }
function TLMDDBCheckBox.GetFieldState: TCheckBoxState;
var
  Text: string;
begin
  if FDatalink.Field <> nil then
    if FDataLink.Field.IsNull then
      Result := cbGrayed
    else
      if FDataLink.Field.DataType = ftBoolean then
        if FDataLink.Field.AsBoolean then
          Result := cbChecked
        else
          Result := cbUnchecked
      else
        begin
          Result := cbGrayed;
          Text := FDataLink.Field.Text;
          if ValueMatch(FValueCheck, Text) then
            Result := cbChecked
          else
            if ValueMatch(FValueUncheck, Text) then
              Result := cbUnchecked;
        end
  else
    Result := cbUnchecked;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCheckBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckBox.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCheckBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCheckBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCheckBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckBox.DataChange(Sender: TObject);
begin
  State:=GetFieldState;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCheckBox.UpdateAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(AAction) or (FDataLink <> nil) and
    FDataLink.UpdateAction(AAction);
end;

procedure TLMDDBCheckBox.UpdateData(Sender: TObject);
var
  Pos: Integer;
  S: string;
begin
  if State = cbGrayed then
    FDataLink.Field.Clear
  else
    if FDataLink.Field.DataType = ftBoolean then
      FDataLink.Field.AsBoolean := Checked
    else
    begin
      if Checked then S := FValueCheck else S := FValueUncheck;
      Pos := 1;
      FDataLink.Field.Text := ExtractFieldName(S, Pos);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCheckBox.ValueMatch(const ValueList, Value: string): Boolean;
var
  Pos: Integer;
begin
  Result := False;
  Pos := 1;
  while Pos <= Length(ValueList) do
    if AnsiCompareText(ExtractFieldName(ValueList, Pos), Value) = 0 then
    begin
      Result := True;
      Break;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckBox.SetValueCheck(const Value: string);
begin
  FValueCheck := Value;
  DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckBox.SetValueUncheck(const Value: string);
begin
  FValueUncheck := Value;
  DataChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckBox.CMExit(var Message: TCMExit);
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

procedure TLMDDBCheckBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := LRESULT(GetDataLink);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckBox.WMPaint(var Message: TWMPaint);
begin
  inherited
end;

{ --------------------------------- protected -------------------------------- }
function TLMDDBCheckBox.CanModify: Boolean;
begin
  Result:=FDataLink.Edit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckBox.Toggle;
begin
  if FDataLink.Edit then
    begin
      inherited Toggle;
      FDataLink.Modified;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBCheckBox.KeyPress(var Key: Char);
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
constructor TLMDDBCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle:=ControlStyle+[csReplicatable];
  State := cbUnchecked;
  FValueCheck := STextTrue;
  FValueUncheck := STextFalse;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBCheckBox.Destroy;
begin
{  FPaintControl.Free;}
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

function TLMDDBCheckBox.ExecuteAction(AAction: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(AAction) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(AAction);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBCheckBox.GetDataLink: TDataLink;
begin
  Result := FDataLink;
end;

end.
