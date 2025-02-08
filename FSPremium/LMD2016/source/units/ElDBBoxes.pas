unit ElDBBoxes;
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

ElDBBoxes unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  DB,
  DBCtrls,
  ElDBCtrls,
  HTMLLbx,
  Forms,
  Windows,
  Controls,
  StdCtrls,
  Messages,
  Menus,

  Types,

  LMDTypes,
  LMDUnicodeStrings,
  Classes,
  SysUtils,
  ElVCLUtils;

type

  TElDBListBox = class(TCustomElHTMLListBox)

  private
    FDataLink: TFieldDataLink;
    FNullValueKey: TShortCut;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure DataChange(Sender: TObject);
    function GetReadOnly: Boolean;
    procedure SetItems(Value: TLMDStrings);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
  protected
    procedure Click; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
    property UseXPThemes;
  published
    property NullValueKey:TShortCut read FNullValueKey write FNullValueKey default 0;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
    property Items write SetItems;

    { Inherited properties }
    property AllowGrayed;
    property BorderStyle;
    property Columns;
    property ExtendedSelect;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection default False;
    property HideSelectColor;
    property HideSelectTextColor;
    property IntegralHeight;
    property IncrementalSearchTimeout;
    property ItemHeight;
    property MultiSelect;
    property ParentColor;
    property TabWidth;
    property ItemIndex;
    property SelCount;
    property TopIndex;
    property ShowCheckBox;
    property ThemeMode;
    property ThemeGlobalMode;

    property ActiveBorderType;
    property Background;
    property BorderSides;
    property Flat;
    property Ctl3D;
    property ParentCtl3D;
    property Font;
    property FlatFocusedScrollBars;
    property HighlightAlphaLevel;
    property HorizontalScroll;
    property Images;
    property AlphaForImages;
    property ImageForm;
    property InactiveBorderType;
    property InvertSelection;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property SelectedFont;
    property ShowLineHint;
    property Transparent;
    property TransparentSelection;
    property UseBackground;
    property UseSelectedFont;
    property TabStop;
    property ParentFont;

    property OnClick;
    property OnCheckStateChange;
    //@+ 2/5/03
    property OnCheckBoxChange;
    //@- 2/5/03
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;

    property Align;
    property Anchors;
    property BiDiMode;
    property Color;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ImeMode;
    property ImeName;
    property ParentBiDiMode;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;
    property Style;
    property OnDrawItem;
    property OnMeasureItem;
    {< ELSCROLLBAR}
    property UseCustomScrollBars;
    property HorzScrollBarStyles;
    property VertScrollBarStyles;
    {> ELSCROLLBAR}
    property RightAlignedView;
  end;

  TElDBComboBox = class(TCustomElHTMLComboBox)

  private
    FNullValueKey: TShortCut;
    FDataLink: TFieldDataLink;
    FValues: TLMDStrings;
    FUseValues: Boolean;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetCReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetCReadOnly(Value: Boolean);
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;

    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;

    procedure EditingChange(Sender: TObject);
//    procedure SetEditReadOnly;
    function GetDBReadOnlyState: Boolean;
  protected

    procedure CActiveChange(Sender: TObject);virtual;
    procedure UpdateData(Sender: TObject);virtual;
    procedure DataChange(Sender: TObject);virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure CreateWnd; override;
    procedure WndProc(var Message : TMessage); override;
    procedure Change; override;
    procedure SetItems(Value: TLMDStrings);
    procedure SetValues(Value: TLMDStrings);
    procedure DefineProperties(Filer: TFiler); override;
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
    procedure  CloseUp(AcceptValue: boolean); override;
  published
    property NullValueKey:TShortCut read FNullValueKey write FNullValueKey default 0;
    property Values: TLMDStrings read FValues write SetValues;
    property UseValues: Boolean read FUseValues write FUseValues default False;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property Items write SetItems;
    property ReadOnly: Boolean read GetCReadOnly write SetCReadOnly default False;
    property DisplayReadOnlyOptions;

    { Inherited properties }
    {< ELSCROLLBAR}
    property UseCustomScrollBars;
    property HorzScrollBarStyles;
    property VertScrollBarStyles;
    {> ELSCROLLBAR}
    property IsHTML default False;
    property Style default csDropDown;
    property LinkColor;
    property LinkStyle;
    property ShowGripper;

    property ButtonArrowColor;

    property CanDrop;
    property DropDownCount;
    property DropDownWidth;
    property ListTransparentSelection;
    property AutoCompletion;
    property ListColor;
    property ListImageForm;
    property ListInvertSelection;
    property UseBackground;
    property OnDropDown;
    property AdjustDropDownPos;
    property ItemIndex;
    property ShowLineHint;
    property HorizontalScroll;
    property ItemHeight;
    property DropDownAlignment;

    property AutoHistory;
    property AutoHistoryDirection;
    property AutoHistoryLimit;
    // property OnAutoCompletion;
    property OnAutoHistoryItemAdd;
    property OnAutoHistoryItemMove;

    // inherited from TCustomElButtonEdit
    property AlignBottom;
    property CharCase;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
    property MaxLength;
    property BorderSides;
    property Transparent;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

    property ImageForm;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property Text;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    // inherited from TCustomElEdit
    property StressShortCut;
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseSystemMenu;

    property Alignment;
    property AutoSelect;

    property Background;
    property ButtonCaption;

    property ButtonClickSound;
    property ButtonDownSound;
    property ButtonUpSound;
    property ButtonSoundMap;

    property ButtonColor;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonHint;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;
    property ButtonShowBorder;
    property ButtonVisible;
    property ButtonWidth;

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
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShowBorder;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonVisible;
    property AltButtonWidth;
    property OnAltButtonClick;

    // VCL properties
    property BorderStyle;
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
    property OnLinkClick;
    property OnImageNeeded;
    property OnDrawItem;
    property OnMeasureItem;
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

  end;

implementation

uses ElEdits;

function TElDBListBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBListBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBListBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

procedure TElDBListBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBListBox.SetDataSource(Value: TDataSource);
begin
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDataLink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TElDBListBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

constructor TElDBListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HideSelection := False;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
end;

destructor TElDBListBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBListBox.Click;
begin
//  if FDataLink.Edit then
  begin
    inherited Click;
//    FDataLink.Modified;
  end;
end;

procedure TElDBListBox.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    ItemIndex := Items.IndexOf(FDataLink.Field.Text)
  else
    ItemIndex := -1;
end;

function TElDBListBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBListBox.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBListBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FDataLink.Edit;
  if not (Key in [VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP,
    VK_RIGHT, VK_DOWN]) then
    if (not FDataLink.Edit) then
      Key := 0;
  inherited KeyDown(Key, Shift);
  if (not ReadOnly) and (FNullValueKey <> 0) and Assigned(FDataLink.DataSet) and Assigned(FDataLink.Field)
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
    ItemIndex := -1;
  end;
end;

procedure TElDBListBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    #32..#255:
      if not FDataLink.Edit then Key := #0;
    #27:
      FDataLink.Reset;
  end;
end;

procedure TElDBListBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

{$ifdef LMD_UNICODE}
procedure TElDBListBox.SetItems(Value: TLMDWideStrings);
{$else}
procedure TElDBListBox.SetItems(Value: TLMDStrings);
{$endif}
begin
  Items.Assign(Value);
  DataChange(Self);
end;

procedure TElDBListBox.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

function TElDBListBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElDBListBox.UpdateData(Sender: TObject);
begin
  if ItemIndex >= 0 then
    FDataLink.Field.Text := Items[ItemIndex] else
    FDataLink.Field.Text := '';
end;

function TElDBListBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElDBListBox.WMLButtonDown(var Message: TWMLButtonDown);
begin
//  if FDataLink.Edit then
    inherited
//  else
//  begin
//    SetFocus;
//    with Message do
//      MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
//  end;
end;

procedure TElDBListBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('Sorted', FakeBoolean, nil, false);
end;

constructor TElDBComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FValues := TLMDMemoryStrings.Create;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
  FDataLink.OnActiveChange := CActiveChange;
  inherited ReadOnly := true;
  IsHTML := False;
  FStyle := csDropDown;
  FIgnoreReadOnlyState := not DisplayReadOnlyOptions.Enabled;
end;

destructor TElDBComboBox.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  FValues.Free;
  inherited Destroy;
end;

procedure TElDBComboBox.Click;
begin
//  if FDataLink.Edit then
  begin
    inherited Click;
//    FDataLink.Modified;
  end;
end;

procedure TElDBComboBox.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SelectAll;
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBComboBox.DataChange(Sender: TObject);
begin
  if ((Style <> csSimple) or IsHTML) and FForm.Visible then
  else
    if FDataLink.Field <> nil then
  begin
    if FUseValues then
      ItemIndex := Values.IndexOf(FDataLink.Field.Text)
    else
      ItemIndex := Items.IndexOf(FDataLink.Field.Text);
    if (ItemIndex < 0) then
    begin
      if ((Style in [csDropDown, csSimple]) or IsHTML) then
        Text := FDataLink.Field.Text
      else
        Text := '';
    end;
  end
  else
    ItemIndex := -1;
  inherited ReadOnly := GetDBReadOnlyState;
end;

function TElDBComboBox.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TElDBComboBox.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBComboBox.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBComboBox.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElDBComboBox.GetCReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  FDataLink.Edit;
  if not (Key in [VK_PRIOR, VK_NEXT, VK_END, VK_HOME, VK_LEFT, VK_UP,
    VK_RIGHT, VK_DOWN]) then
    if (not FDataLink.Edit) then
      Key := 0;
  inherited KeyDown(Key, Shift);

  if Style = csDropDownList then
    UpdateData(Self);
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
    ItemIndex := -1;
  end;
end;

procedure TElDBComboBox.KeyPress(var Key: Char);
begin
  case Key of
    #32..#255:
      if not FDataLink.Edit then
        Key := #0
      else
        inherited KeyPress(Key);
    #27:
      FDataLink.Reset;
    else
      inherited KeyPress(Key);
  end;
end;

procedure TElDBComboBox.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBComboBox.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
  inherited ReadOnly := GetDBReadOnlyState;
end;

procedure TElDBComboBox.SetDataSource(Value: TDataSource);
begin
  if (FDataLink.DataSource <> nil) and
     (not (csDestroying in FDatALink.DataSource.ComponentState)) then
    FDataLink.DataSource.RemoveFreeNotification(Self);
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
  inherited ReadOnly := GetDBReadOnlyState;
end;

{$ifdef LMD_UNICODE}
procedure TElDBComboBox.SetItems(Value: TLMDWideStrings);
{$else}
procedure TElDBComboBox.SetItems(Value: TLMDStrings);
{$endif}
begin
  Items.Assign(Value);
  DataChange(Self);
end;

procedure TElDBComboBox.SetValues(Value: TLMDStrings);
begin
  Values.Assign(Value);
  DataChange(Self);
end;

procedure TElDBComboBox.SetCReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
  inherited ReadOnly := GetDBReadOnlyState;
  Invalidate;
end;

function TElDBComboBox.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

procedure TElDBComboBox.UpdateData(Sender: TObject);
begin
  if (Style in [csSimple, csDropDown]) and (not IsHTML) then
  begin
    if (not FUseValues) or (ItemIndex < 0) then
      FDataLink.Field.Text := Text
    else
      FDataLink.Field.Text := Values[ItemIndex];
  end
  else
  if ItemIndex >= 0 then
  begin
    if FUseValues and (ItemIndex < FValues.Count) then
      FDataLink.Field.Text := Values[ItemIndex]
    else
      FDataLink.Field.Text := Items[ItemIndex];
  end
  else
    FDataLink.Field.Text := '';
end;

function TElDBComboBox.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

procedure TElDBComboBox.WMLButtonDown(var Message: TWMLButtonDown);
begin
//  if FDataLink.Edit then
    inherited
{  else
  begin
    SetFocus;
    with Message do
      MouseDown(mbLeft, KeysToShiftState(Keys), XPos, YPos);
  end;}
end;

procedure TElDBComboBox.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := TLMDPtrInt(FDataLink);
end;

procedure TElDBComboBox.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := GetDBReadOnlyState;
  if not FReadOnly and (FDataLink.DataSet.State in [dsEdit{, dsInsert}]) then
    UpdateData(Self);
//  SetEditReadOnly;
end;

procedure TElDBComboBox.CreateWnd;
begin
  inherited;
//  if (Style in [csDropDown, csSimple]) and HandleAllocated and (not IsHTML) then
//    inherited ReadOnly := not FDataLink.Editing;
end;

procedure TElDBComboBox.WndProc(var Message : TMessage);
begin
  if not (csDesigning in ComponentState) then
    case Message.Msg of
{
      WM_COMMAND:
        if TWMCommand(Message).NotifyCode = CBN_SELCHANGE then
          if not FDataLink.Edit then
          begin
            if Style <> csSimple then
              PostMessage(Handle, CB_SHOWDROPDOWN, 0, 0);
            Exit;
          end;
{}
      CB_SHOWDROPDOWN:
        if Message.WParam <> 0 then
          FDataLink.Edit
        else
          if not FDataLink.Editing then DataChange(Self); {Restore text}
    end;
  inherited;
end;

procedure TElDBComboBox.Change;
begin
  inherited;
  if FDataLink.Edit then
    FDataLink.Modified;
end;

procedure TElDBComboBox.CloseUp(AcceptValue: boolean);
begin
  inherited CloseUp(AcceptValue);
  if AcceptValue and (Style = csDropDownList) then
    UpdateData(Self);
  end;

procedure TElDBComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('Sorted', FakeBoolean, nil, false);
end;

procedure TElDBComboBox.CActiveChange(Sender: TObject);
begin
  inherited ReadOnly := GetDBReadOnlyState;
end;

function TElDBComboBox.GetDBReadOnlyState: Boolean;
begin
//  if (Style in [csDropDown, csSimple]) and HandleAllocated then
    Result := DBCheckReadOnlyState(FDataLink)
//  else
//    Result := true;
end;

end.
