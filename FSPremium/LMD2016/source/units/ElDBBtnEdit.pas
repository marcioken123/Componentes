unit ElDBBtnEdit;
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

ElDBBtnEdit unit
----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Forms, Windows, Controls, StdCtrls,  Messages, Menus, DB, DBCtrls,
  Classes, SysUtils, Types, LMDTypes,
  LMDUnicode, ElDBCtrls, ElBtnEdit, LMDElDBConst;

type

  TElDBButtonEdit = class(TCustomElButtonEdit)

  private
    FDataLink: TFieldDataLink;
    FNullValueKey: TShortCut;
    procedure ActiveChange(Sender: TObject);
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure ResetMaxLength;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure UpdateData(Sender: TObject);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    function GetDBReadOnlyState: Boolean;
  protected
    FUnicodeMode: TElDBUnicodeMode;

    procedure Change; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
    property Text;
    property Lines;
  published
    property NullValueKey:TShortCut read FNullValueKey write FNullValueKey default 0;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;

    property DisplayReadOnlyOptions;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
    property RightAlignedText;
    property RightAlignedView;
    property BorderSides;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property FlatFocusedScrollBars;
    property WantTabs;
    property HandleDialogKeys;
    property HideSelection;
    property TabSpaces;
    property ImageForm;
    property WordWrap;
    property ScrollBars;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property Multiline;

    // inherited
    property StressShortCut;
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseBackground;
    property Alignment;
    property AutoSelect;

    property Background;

    property ButtonCaption;
    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;

    property ButtonColor;
    property ButtonDown;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonGlyph;
    property ButtonHint;
    property ButtonIcon;
    property ButtonNumGlyphs;
    property ButtonPopupPlace;
    property ButtonPullDownMenu;
    property ButtonShortcut;
    property ButtonUseIcon;
    property ButtonVisible;
    property ButtonWidth;
    property OnButtonClick;

    property AltButtonCaption;

    property AltButtonClickSound;
    property AltButtonDownSound;
    property AltButtonUpSound;
    property AltButtonSoundMap;

    property AltButtonColor;
    property AltButtonDown;
    property AltButtonEnabled;
    property AltButtonFlat;
    property AltButtonGlyph;
    property AltButtonHint;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShortcut;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property OnAltButtonClick;

    // VCL properties
    property BorderStyle;
    property Ctl3D;
    property ParentCtl3D;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property ReadOnly default True;

    property OnEnter;
    property OnExit;
    property OnClick;
    property OnDblClick;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnStartDock;

    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DoubleBuffered;
    property DragKind;
    property UnicodeMode: TElDBUnicodeMode read FUnicodeMode write FUnicodeMode
        default umFieldType;

  end;

implementation

uses
 ElEdits;

constructor TElDBButtonEdit.Create(AOwner : TComponent);
begin
  inherited;
  inherited ReadOnly := true;
  FIgnoreReadOnlyState := not DisplayReadOnlyOptions.Enabled;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnActiveChange := ActiveChange;
end;

destructor TElDBButtonEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited;
end;

procedure TElDBButtonEdit.ActiveChange(Sender: TObject);
begin
  ResetMaxLength;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElDBButtonEdit.Change;
begin
  FDataLink.Modified;
  inherited Change;
end;

procedure TElDBButtonEdit.DataChange(Sender: TObject);
{$ifdef LMD_UNICODE}
var W : WideString;
{$endif}
begin
  if FDataLink.Field <> nil then
  begin
    if Alignment <> FDataLink.Field.Alignment then
    begin
      Text := '';  {forces update}
      Alignment := FDataLink.Field.Alignment;
    end;
    if not (csDesigning in ComponentState) then
    begin
      if (FDataLink.Field.DataType in [ftString, ftWideString]) and (MaxLength = 0) then
        MaxLength := FDataLink.Field.Size;
    end;

    {$ifdef LMD_UNICODE}
    if FDataLink.Field.isNull then
      W := ''
    else
    if (UnicodeMode = umForceUTF8) or ((FDataLink.Field.DataType <> ftWideString) and (UnicodeMode = umForceUnicode)) and
       (LMDConvertUTF8toUTF16({$ifdef lmdcomp12}FDataLink.Field.AsAnsiString{$else}FDataLink.Field.asString{$endif}, W, strictConversion, false) <> sourceIllegal)
    then
    else
    begin
      if (FDataLink.Field.DataType = ftWideString) then
      W := FDataLink.Field.Value
      else
        W := FDataLink.Field.AsString;
    end;
    Text := W;
    {$else}
    Text := FDataLink.Field.AsString;
    {$endif}
  end
  else
  begin
    Alignment := taLeftJustify;
    if csDesigning in ComponentState then
      Text := Name
    else
      Text := '';
  end;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElDBButtonEdit.EditingChange(Sender: TObject);
begin
//  inherited ReadOnly := not FDataLink.Editing;
  inherited ReadOnly := GetDBReadOnlyState;
  Refresh;
end;

function TElDBButtonEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBButtonEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBButtonEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBButtonEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TElDBButtonEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (not (ReadOnly or GetDBReadOnlyState)) and (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
     and ((DataSource.AutoEdit) or (DataSource.State in [dsEdit, dsInsert]))
     and (FDataLink.DataSet.Active)
     and (FNullValueKey = ShortCut(Key,Shift)) then
  begin
    if Assigned(FDataLink.Field) then
    begin
      FDataLink.DataSet.Edit;
      FDataLink.Field.Clear;
    end;
    Key := 0;
  end;
  if (Key = VK_DELETE) or ((Key = VK_INSERT) and (ssShift in Shift)) or (Key = VK_BACK) then
    FDataLink.Edit;
  inherited KeyDown(Key, Shift);
end;

procedure TElDBButtonEdit.KeyPress(var Key: Char);
begin
  if (AnsiChar(Key) in [#32..#255]) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end;
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
    #27:
      begin
        FDataLink.Reset;
        SelectAll;
        Key := #0;
      end;
  end;
  inherited KeyPress(Key);
end;

procedure TElDBButtonEdit.Loaded;
begin
  inherited Loaded;
  ResetMaxLength;
  if (csDesigning in ComponentState) then DataChange(Self);
end;

procedure TElDBButtonEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBButtonEdit.ResetMaxLength;
var
  F: TField;
begin
  if (MaxLength > 0) and Assigned(DataSource) and Assigned(DataSource.DataSet) then
  begin
    F := DataSource.DataSet.FindField(DataField);
    if Assigned(F) and (F.DataType in [ftString, ftWideString]) and (F.Size = MaxLength) then
      MaxLength := 0;
  end;
end;

procedure TElDBButtonEdit.SetDataField(const Value: string);
begin
  if not (csDesigning in ComponentState) then
    ResetMaxLength;
  FDataLink.FieldName := Value;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElDBButtonEdit.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  inherited ReadOnly := GetDBReadOnlyState;
end;

function TElDBButtonEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElDBButtonEdit.UpdateData(Sender: TObject);
{$ifdef LMD_UNICODE}
var
  W : WideString;
  st: AnsiString;
{$endif}
begin
  {$ifdef LMD_UNICODE}
  if UnicodeMode = umForceUTF8 then
  begin
    LMDConvertUTF16toUTF8(Text, st, strictConversion, false);
    FDataLink.Field.Text := String(st);
  end
  else
  if UnicodeMode = umFieldType then
  begin
    if (FDataLink.Field.DataType = ftWideString) and (not FDataLink.Field.IsNull) then
    begin
      W := Text;
      FDataLink.Field.Value := W;
      end
    else
      FDataLink.Field.Text := Text;
  end
  else
  if UnicodeMode = umForceUnicode then
  begin
    if (FDataLink.Field.DataType = ftWideString) and (not FDataLink.Field.IsNull) then
    begin
      W := Text;
      FDataLink.Field.Value := W;
    end
    else
    begin
      LMDConvertUTF16toUTF8(Text, st, strictConversion, false);
      FDataLink.Field.Text := String(st);
    end;
  end;
  {$else}
    FDataLink.Field.Text := Text;
  {$endif}
end;

function TElDBButtonEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElDBButtonEdit.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBButtonEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := TLMDPtrInt(FDataLink);
end;

function TElDBButtonEdit.GetDBReadOnlyState: Boolean;
begin
  Result := DBCheckReadOnlyState(FDataLink);
end;

end.
