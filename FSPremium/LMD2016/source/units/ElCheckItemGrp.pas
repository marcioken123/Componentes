unit ElCheckItemGrp;
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

ElCheckItemGrp unit
-------------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes,
  Types,
  Stdctrls,
  Messages,
  Controls,
  Windows,
  Graphics,
  Themes,
  ExtCtrls,
  Forms,
  ImgList,

  LMDClass,
  LMDThemes,
  LMDUnicodeStrings,
  LMDObjectList,
  LMDHTMLUnit,
  LMDProcs,
  LMDTypes,

  ElImgFrm,
  ElCheckCtl,
  ElGroupBox,
  ElSndMap;

type

  TElCheckItemClass = class of TElCheckItem;

  TElCheckItemGroup = class(TCustomElGroupBox)
  protected
    FCheckAlignment: TLeftRight;
    FButtons: TLMDObjectList;
    FColumns: Integer;
    FHints: TLMDStrings;
    FItems: TLMDStrings;
    FReading: Boolean;
    FUpdating: boolean;
    FHorzOffset: Integer;
    FItemHeight: Integer;
    FItemSpacing: Integer;
    FVertOffset: Integer;
    FEndEllipsis: Boolean;
    procedure NotifyChildsThatRepaint(AllChilds: Boolean = false);override;
    procedure ArrangeButtons;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure HintsChange(Sender: TObject);
    procedure ItemsChange(Sender: TObject); virtual;
    procedure SetCheckAlignment(newValue: TLeftRight);
    procedure SetButtonCount(Value: Integer);
    procedure SetColumns(Value: Integer);
    procedure SetFlat(newValue : boolean); override;
    procedure SetHints(Value: TLMDStrings);
    procedure SetItems(Value: TLMDStrings);
    procedure UpdateButtons; virtual;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure ReadState(Reader: TReader); override;
    procedure SetImageForm(Value : TElImageForm); override;
    procedure SetIsHTML(Value: Boolean); override;
    procedure SetTransparent(newValue : boolean); override;
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetThemeGlobalMode(const Value: Boolean); override;
    procedure SetThemeMode(const Value: TLMDThemeMode); override;
    procedure IntCreateItem; virtual; abstract;
    procedure ButtonClick(Sender: TObject); virtual;
    procedure SetCheckSound(Value: TElSoundName); override;
    procedure SetGlyph(Value: TBitmap); override;
    procedure SetImages(Value: TCustomImageList); override;
    procedure SetAlphaImages(Value: TCustomImageList); override;
    procedure SetSoundMap(Value: TElSoundMap); override;
    procedure SetUseCustomGlyphs(Value: Boolean); override;
    procedure SetUseImageList(Value: Boolean); override;
    procedure SetCheckBoxChecked(Value: Boolean); override;
    procedure SetFlatAlways(Value: Boolean);
    procedure SetMoneyFlatInactiveColor(Value: TColor); override;
    procedure SetMoneyFlatActiveColor(Value: TColor); override;
    procedure SetMoneyFlatDownColor(Value: TColor); override;
    procedure SetMoneyFlat(Value: Boolean); override;
    function GetItemEnabled(Index: Integer): Boolean;

    procedure SetItemEnabled(Index: Integer; Value: Boolean);
    procedure SetHorzOffset(Value: Integer);
    procedure SetItemHeight(Value: Integer);
    procedure SetItemSpacing(Value: Integer);
    procedure SetVertOffset(Value: Integer);
    procedure Loaded; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadAlignment(Reader: TReader);
    procedure SetEndEllipsis(Value: Boolean);

    property CheckAlignment: TLeftRight read FCheckAlignment write
        SetCheckAlignment default taRightJustify;
    property Columns: Integer read FColumns write SetColumns default 1;
    property Hints: TLMDStrings read FHints write SetHints;
    property Items: TLMDStrings read FItems write SetItems;
    property ItemEnabled[Index: Integer]: Boolean read GetItemEnabled write
        SetItemEnabled;
    property HorzOffset: Integer read FHorzOffset write SetHorzOffset default 0;
    property ItemHeight: Integer read FItemHeight write SetItemHeight default -1;
    property ItemSpacing: Integer read FItemSpacing write SetItemSpacing default -1;
    property VertOffset: Integer read FVertOffset write SetVertOffset default 0;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default false;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure FlipChildren(AllLevels: Boolean); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  end;

type
  TCustomElRadioGroup = class (TElCheckItemGroup)
  private
    FItemIndex: Integer;

    procedure SetItemIndex(Value: Integer);
  protected
    procedure IntCreateItem; override;
    procedure UpdateButtons; override;
    procedure ButtonClick(Sender: TObject); override;
    procedure ItemsChange(Sender: TObject); override;

    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TElRadioGroup = class(TCustomElRadioGroup)
  public
    property ItemEnabled;
  published
    property Align;
    property Alignment;

    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property BorderSides;
    property Caption;
    property CaptionColor;
    property CheckBoxChecked;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property EndEllipsis;
    property Flat;
    property FlatAlways;
    property Font;
    property Hints;
    property HorzOffset;
    property ImageForm;
    property IsHTML;
    property ItemIndex;
    property Items;
    property ItemHeight;
    property ItemSpacing;
    property MoneyFlat;
    property MoneyFlatInactiveColor;
    property MoneyFlatActiveColor;
    property MoneyFlatDownColor;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowCheckBox;
    property ShowFocus;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property VertOffset;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
    property TransparentXPThemes;
    property CheckSound;
    property SoundMap;
    property Glyph;
    property Images;
    property AlphaForImages;
    property UseCustomGlyphs;
    property UseImageList;

    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnResize;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;

    property OnContextPopup;

  end;

type

  TCustomElCheckGroup = class(TElCheckItemGroup)
  private
    function GetChecked(Index: Integer): Boolean;
    procedure SetChecked(Index: Integer; Value: Boolean);
    function GetState(Index: Integer): TCheckBoxState;
    procedure SetState(Index: Integer; Value: TCheckBoxState);
  protected
    FAllowGrayed: Boolean;
    procedure SetAllowGrayed(Value: Boolean);
    procedure IntCreateItem; override;
  public
    constructor Create(AOwner: TComponent); override;
    property Checked[Index: Integer]: Boolean read GetChecked write SetChecked;
    property State[Index: Integer]: TCheckBoxState read GetState write SetState;
  published
    property AllowGrayed: Boolean read FAllowGrayed write SetAllowGrayed default true;
  end;

  TElCheckGroup = class(TCustomElCheckGroup)
  public
    property ItemEnabled;
  published
    property Align;
    property Alignment;

    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property BorderSides;
    property Caption;
    property CaptionColor;
    property CheckBoxChecked;
    property Color;
    property Columns;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property EndEllipsis;
    property Flat;
    property FlatAlways;
    property Font;
    property Hints;
    property HorzOffset;
    property ImageForm;
    property IsHTML;
    property Items;
    property ItemHeight;
    property ItemSpacing;
    property MoneyFlat;
    property MoneyFlatInactiveColor;
    property MoneyFlatActiveColor;
    property MoneyFlatDownColor;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowCheckBox;
    property ShowFocus;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
    property TransparentXPThemes;
    property VertOffset;
    property CheckSound;
    property SoundMap;
    property Glyph;
    property Images;
    property AlphaForImages;
    property UseCustomGlyphs;
    property UseImageList;

    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnResize;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;

    property OnContextPopup;

  end;

implementation

type
  TElGroupCheckItem = class(TElCheckItem);
  THackGroup=class(TElCheckItemGroup)
  public

    procedure KeyPress(var Key: Char); override;

  end;

procedure THackGroup.Keypress(var Key: Char);
begin
  inherited KeyPress(Key);
end;

constructor TElCheckItemGroup.Create(AOwner: TComponent);
begin
  FButtons := TLMDObjectList.Create;
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csSetCaption, csDoubleClicks];
  FHints := TLMDMemoryStrings.Create;
  TLMDMemoryStrings(FHints).OnChange := HintsChange;
  FItems := TLMDMemoryStrings.Create;
  TLMDMemoryStrings(FItems).OnChange := ItemsChange;
  FColumns := 1;
  FCheckAlignment := taRightJustify;
  FItemHeight := -1;
  FItemSpacing := -1;
end;

destructor TElCheckItemGroup.Destroy;
begin
  SetButtonCount(0);
  TLMDMemoryStrings(FItems).OnChange := nil;
  FHints.Free;
  FHints := nil;
  FItems.Free;
  FItems := nil;
  FButtons.Free;
  FButtons := nil;
  inherited Destroy;
end;

procedure TElCheckItemGroup.ArrangeButtons;
var
  ButtonsPerCol, ButtonWidth, ButtonHeight, TopMargin, I: Integer;
  DeferHandle: THandle;
  ax, ay,
  //aTop : integer;
  ALeft: Integer;
  TopOffset : integer;
  TopPos, AHeight : integer;
begin
  if (FButtons.Count <> 0) and not FReading and HandleAllocated then
  begin
    TopOffset := GetTopOffset;
    ButtonsPerCol := (FButtons.Count + FColumns - 1) div FColumns;
    ButtonWidth := (Width - 10) div FColumns - HorzOffset;
    I := Self.Height - TopOffset - 5;
    ButtonHeight := I div ButtonsPerCol;
    TopMargin := GetTopOffset + 1;
    DeferHandle := BeginDeferWindowPos(FButtons.Count);
    try

      if (ItemSpacing = -1) or (ItemHeight = -1) then
      begin
        AHeight := ButtonHeight;
        inc(TopMargin, (I mod ButtonsPerCol) div 2);
      end
      else
      begin
        AHeight := ItemHeight;
        TopMargin := GetTopOffset + 1;
      end;

      for I := 0 to FButtons.Count - 1 do
      begin

        if (ItemSpacing = -1) or (ItemHeight = -1) then
        begin
          TopPos := AHeight * (I mod ButtonsPerCol);
        end
        else
        begin
          TopPos := (AHeight + ItemSpacing) * (I mod ButtonsPerCol);
        end;

        Inc(TopPos, TopMargin + VertOffset);

        with TElGroupCheckItem(FButtons[I]) do
        begin
          TElGroupCheckItem(FButtons[I]).ThemeMode := Self.UseThemeMode;
          HandleNeeded;
          Visible := True;
          ax := 0;
          ay := 0;
          CalcAutoSize(ax, ay);
          if (ItemSpacing = -1) or (ItemHeight = -1) then
          begin
            if ay > AHeight then
              ay := AHeight - 1;
          end
          else
          begin
            ay := aHeight;
          end;
          inc(TopPos, (AHeight - ay) shr 1);
          ALeft := (I div ButtonsPerCol) * ButtonWidth + HorzOffset + 5;
          BiDiMode := Self.BiDiMode;
          if UseRightToLeftAlignment then
            ALeft := Self.ClientWidth - ALeft - ButtonWidth - 5;
          DeferHandle := DeferWindowPos(DeferHandle, Handle, 0,
            ALeft, TopPos, ax {ButtonWidth}, ay,
            SWP_NOZORDER or SWP_NOACTIVATE);
          end;
      end;
    finally
      EndDeferWindowPos(DeferHandle);
    end;
    (*
    for I := 0 to FButtons.Count - 1 do
    begin
      with TElGroupCheckItem(FButtons[I]) do
        if AutoSize then
        begin
          OldR := BoundsRect;
          AutoSize := false;
          AutoSize := true;
          NewR := BoundsRect;
          OffsetRect
        end;
    end;
    *)
  end;
end;

procedure TElCheckItemGroup.CMEnabledChanged(var Message: TMessage);

var
 I: Integer;
begin
  inherited;
  if Assigned(FButtons) then
    for I := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[I]).Enabled := Enabled;
end;

procedure TElCheckItemGroup.CMFontChanged(var Message: TMessage);

begin
  inherited;
  if ComponentState * [csLoading, csReading] = [] then
    ArrangeButtons;
end;

procedure TElCheckItemGroup.FlipChildren(AllLevels: Boolean);
begin
end;

procedure TElCheckItemGroup.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
  inherited;
end;

procedure TElCheckItemGroup.HintsChange(Sender: TObject);
begin
  if not FReading then
  begin
    UpdateButtons;
  end;
end;

procedure TElCheckItemGroup.ItemsChange(Sender: TObject);
begin
  if not FReading then
  begin
    UpdateButtons;
    if ComponentState * [csLoading, csReading] = [] then
      ArrangeButtons;
  end;
end;

procedure TElCheckItemGroup.ReadState(Reader: TReader);
begin
  FReading := True;
  inherited ReadState(Reader);
  FReading := False;
  UpdateButtons;
end;

procedure TElCheckItemGroup.SetCheckAlignment(newValue: TLeftRight);
var
  i : integer;
begin
  if (newValue <> FCheckAlignment) then
  begin
    FCheckAlignment:= newValue;
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).CheckAlignment := FCheckAlignment;
  end;
end;

procedure TElCheckItemGroup.SetButtonCount(Value: Integer);
begin
  while FButtons.Count < Value do
    IntCreateItem;

  while FButtons.Count > Value do
    TElGroupCheckItem(FButtons.Last).Free;
end;

procedure TElCheckItemGroup.SetColumns(Value: Integer);
begin
  if Value < 1 then Value := 1;
  if Value > 16 then Value := 16;
  if FColumns <> Value then
  begin
    FColumns := Value;
    ArrangeButtons;
    Invalidate;
  end;
end;

procedure TElCheckItemGroup.SetFlat(newValue : boolean);
var
  i : integer;
begin
  if (newValue <> FFlat) then
  begin
    inherited;
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).Flat := FFlat;
  end;
end;

procedure TElCheckItemGroup.SetHints(Value: TLMDStrings);
begin
  FHints.Assign(Value);
end;

procedure TElCheckItemGroup.SetImageForm(Value : TElImageForm);
var i : integer;
begin
  inherited;
  if Assigned(FButtons) then
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).ImageForm := Value;
end;

procedure TElCheckItemGroup.SetIsHTML(Value: Boolean);
var i : integer;
begin
  if IsHTML <> Value then
  begin
    inherited;
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).IsHTML := IsHTML;
  end;
end;

procedure TElCheckItemGroup.SetItems(Value: TLMDStrings);
begin
  FItems.Assign(Value);
end;

procedure TElCheckItemGroup.SetTransparent(newValue: Boolean);
var i : integer;
begin
  if (Transparent <> newValue) then
  begin
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).Transparent := newValue;
    inherited;
  end;
end;

procedure TElCheckItemGroup.SetUseXPThemes(const Value: Boolean);
var i : integer;
begin
  inherited;
  for i := 0 to FButtons.Count - 1 do
    TElGroupCheckItem(FButtons[i]).UseXPThemes := UseXPThemes;
    end;

procedure TElCheckItemGroup.SetThemeGlobalMode(const Value: Boolean);
var i : integer;
begin
  inherited;
  for i := 0 to FButtons.Count - 1 do
    TElGroupCheckItem(FButtons[i]).ThemeGlobalMode := ThemeGlobalMode;
    end;

procedure TElCheckItemGroup.SetThemeMode(const Value: TLMDThemeMode);
var
  i : integer;
begin
  inherited;
  for i := 0 to FButtons.Count - 1 do
    begin
      TElGroupCheckItem(FButtons[i]).ThemeMode := ThemeMode;
    end;
end;

procedure TElCheckItemGroup.WMSetFocus(var Msg : TWMSetFocus);

begin
  inherited;
end;

procedure TElCheckItemGroup.UpdateButtons;
var
  I: Integer;
  Btn : TElGroupCheckItem;
  Ob  : integer;
begin
  Ob := FButtons.Count;
  SetButtonCount(FItems.Count);
  for I := 0 to FButtons.Count - 1 do
  begin
    Btn := TElGroupCheckItem(FButtons[I]);
    Btn.Caption := FItems[I];
    Btn.CheckAlignment := CheckAlignment;
    Btn.Flat := Flat;
    Btn.IsHTML := IsHTML;
    Btn.SoundMap := SoundMap;
    Btn.Checksound := CheckSound;
    Btn.AlphaForImages := AlphaForImages;
    Btn.Images := Images;
    Btn.UseCustomGlyphs := UseCustomGlyphs;
    Btn.UseImageList := UseImageList;
    Btn.Glyph := Glyph;
    Btn.FlatAlways := FlatAlways;
    Btn.EndEllipsis := EndEllipsis;
    Btn.MoneyFlat := MoneyFlat;
    Btn.MoneyFlatActiveColor := MoneyFlatActiveColor;
    Btn.MoneyFlatInactiveColor := MoneyFlatInactiveColor;
    Btn.MoneyFlatDownColor := MoneyFlatDownColor;
    Btn.ImageForm := ImageForm;
    Btn.UseXPThemes := UseXPThemes;
    Btn.Transparent := Transparent;
    if FHints.Count > I then
      Btn.Hint := FHints[I];
    if i >= OB then
      Btn.Enabled := Enabled and ((not ShowCheckBox) or CheckboxChecked);
  end;
end;

procedure TElCheckItemGroup.WMSize(var Message: TWMSize);

begin
  inherited;
  if ComponentState * [csLoading, csReading] = [] then
    ArrangeButtons;
end;

procedure TElCheckItemGroup.ButtonClick(Sender: TObject);
begin
  if not FUpdating then
  begin
    // Changed;
    Click;
  end;
end;

procedure TElCheckItemGroup.SetCheckSound(Value: TElSoundName);
var i : integer;
begin
  if FCheckSound <> Value then
  begin
    inherited;
    FCheckSound := Value;
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).CheckSound := Value;
  end;
end;

procedure TElCheckItemGroup.SetGlyph(Value: TBitmap);
var i : integer;
begin
  inherited;
  for i := 0 to FButtons.Count - 1 do
    TElGroupCheckItem(FButtons[i]).Glyph := Value;
end;

procedure TElCheckItemGroup.SetImages(Value: TCustomImageList);
var i : integer;
begin
  if FImages <> Value then
  begin
    inherited;
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).Images := Value;
  end;
end;

procedure TElCheckItemGroup.SetAlphaImages(Value: TCustomImageList);
var i : integer;
begin
  if FAlphaImages <> Value then
  begin
    inherited;
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).AlphaForImages := Value;
  end;
end;

procedure TElCheckItemGroup.SetSoundMap(Value: TElSoundMap);
var i : integer;
begin
  if FSoundMap <> Value then
  begin
    inherited;
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).SoundMap := Value;
  end;
end;

procedure TElCheckItemGroup.SetUseCustomGlyphs(Value: Boolean);
var i : integer;
begin
  if FUseCustomGlyphs <> Value then
  begin
    inherited;
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).UseCustomGlyphs := Value;
  end;
end;

procedure TElCheckItemGroup.SetUseImageList(Value: Boolean);
var i : integer;
begin
  if FUseImageList <> Value then
  begin
    inherited;
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).UseImageList := Value;
  end;
end;

procedure TElCheckItemGroup.SetCheckBoxChecked(Value: Boolean);
var i : integer;
begin
  if FCheckboxChecked <> Value then
  begin
    inherited;
    for I := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[I]).Enabled := Enabled and ((not ShowCheckBox) or CheckboxChecked);
  end;
end;

procedure TElCheckItemGroup.SetFlatAlways(Value: Boolean);
var i : integer;
begin
  if FFlatAlways <> Value then
  begin
    inherited;
    for I := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[I]).FlatAlways := Value;
  end;
end;

procedure TElCheckItemGroup.SetMoneyFlatInactiveColor(Value: TColor);
var i : integer;
begin
  if FMoneyFlatInactiveColor <> Value then
  begin
    inherited;
    for I := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[I]).MoneyFlatInactiveColor := Value;
  end;
end;

procedure TElCheckItemGroup.SetMoneyFlatActiveColor(Value: TColor);
var i : integer;
begin
  if MoneyFlatActiveColor <> Value then
  begin
    inherited;
    for I := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[I]).MoneyFlatActiveColor := Value;
  end;
end;

procedure TElCheckItemGroup.SetMoneyFlatDownColor(Value: TColor);
var i : integer;
begin
  if MoneyFlatDownColor <> Value then
  begin
    inherited;
    for I := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[I]).MoneyFlatDownColor := Value;
  end;
end;

procedure TElCheckItemGroup.SetMoneyFlat(Value: Boolean);
var i : integer;
begin
  if MoneyFlat <> Value then
  begin
    inherited;
    for I := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[I]).MoneyFlat := Value;
  end;
end;

function TElCheckItemGroup.GetItemEnabled(Index: Integer): Boolean;
begin
  if (Index >= 0) and (Index < Items.Count) then
    result := TElCheckItem(FButtons[Index]).Enabled
  else
    result := false;
end;

procedure TElCheckItemGroup.SetItemEnabled(Index: Integer; Value: Boolean);
begin
  if (Index >= 0) and (Index < Items.Count) then
    TElCheckItem(FButtons[Index]).Enabled := Value;
end;

procedure TElCheckItemGroup.SetHorzOffset(Value: Integer);
begin
  if FHorzOffset <> Value then
  begin
    FHorzOffset := Value;
    if ComponentState * [csLoading, csReading] = [] then
      ArrangeButtons;
  end;
end;

procedure TElCheckItemGroup.SetItemHeight(Value: Integer);
begin
  if FItemHeight <> Value then
  begin
    FItemHeight := Value;
    if ComponentState * [csLoading, csReading] = [] then
      ArrangeButtons;
  end;
end;

procedure TElCheckItemGroup.SetItemSpacing(Value: Integer);
begin
  if FItemSpacing <> Value then
  begin
    FItemSpacing := Value;
    if ComponentState * [csLoading, csReading] = [] then
      ArrangeButtons;
  end;
end;

procedure TElCheckItemGroup.SetVertOffset(Value: Integer);
begin
  if FVertOffset <> Value then
  begin
    FVertOffset := Value;
    if ComponentState * [csLoading, csReading] = [] then
      ArrangeButtons;
  end;
end;

procedure TElCheckItemGroup.Loaded;
begin
  inherited;
  ArrangeButtons;
  UpdateButtons;
  NotifyChildsThatRepaint(true);
end;

procedure TElCheckItemGroup.NotifyChildsThatRepaint(AllChilds: Boolean);
begin
  inherited NotifyChildsThatRepaint(True);
end;

procedure TElCheckItemGroup.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Alignment', ReadAlignment, nil, false);
end;

procedure TElCheckItemGroup.ReadAlignment(Reader: TReader);
var i : integer;
begin
  i := Reader.ReadInteger;
  CheckAlignment := TLeftRight(i);
end;

procedure TElCheckItemGroup.SetEndEllipsis(Value: Boolean);
var
  i : integer;
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    for i := 0 to FButtons.Count - 1 do
      TElGroupCheckItem(FButtons[i]).EndEllipsis := FEndEllipsis;
  end;
end;

type
  TElGroupButton = class(TElRadioButton)
  private
//    FInClick: Boolean;
    FOwner: TComponent;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure SetChecked(newValue : Boolean); override;
  public
    constructor InternalCreate(ElRadioGroup: TCustomElRadioGroup);
    destructor Destroy; override;
    procedure Click; override;
  end;

constructor TElGroupButton.InternalCreate(ElRadioGroup: TCustomElRadioGroup);
begin
  BeginCreate;
  inherited Create(ElRadioGroup);
  ElRadioGroup.FButtons.Add(Self);
  FOwner:= ElRadioGroup;
  Visible := False;
  Enabled := ElRadioGroup.Enabled;
  ParentShowHint := true;
  OnClick := ElRadioGroup.ButtonClick;
  Parent := ElRadioGroup;
  TabStop := false;
  StyleManager := nil;
  EndCreate;
end;

destructor TElGroupButton.Destroy;

begin
  TElRadioGroup(Owner).FButtons.Remove(Self);
  inherited Destroy;
end;

procedure TElGroupButton.SetChecked(newValue: Boolean);
begin
  inherited;
end;

procedure TElGroupButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  THackGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
  begin
    if not TElRadioGroup(Parent).CanModify then
    Key := #0;
  end;
end;

procedure TElGroupButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TElRadioGroup(Parent).KeyDown(Key, Shift);
  end;

procedure TElGroupButton.Click;
begin
  if TElRadioGroup(Parent).CanModify then
  inherited;
end;

constructor TCustomElRadioGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItemIndex := -1;
end;

procedure TCustomElRadioGroup.ButtonClick(Sender: TObject);
var i : integer;
begin
  i := FButtons.IndexOf(Sender);
  if not FUpdating then
  begin
    if FItemIndex <> i then
    begin
      FItemIndex := i;
    end;
    for i := 0 to FButtons.Count - 1 do
    begin
      TElGroupButton(FButtons[i]).FClicked := False;
    end;
    inherited;
  end
  else
    inherited;
end;

procedure TCustomElRadioGroup.SetItemIndex(Value: Integer);
begin
  if ComponentState * [csReading, csLoading, csDestroying] <> [] then
    FItemIndex := Value
  else
  begin
    if Value < -1 then Value := -1;
    if Value >= FButtons.Count then Value := FButtons.Count - 1;
    if FItemIndex <> Value then
    begin
      if FItemIndex >= 0 then
        TElGroupButton(FButtons[FItemIndex]).Checked := False;
      FItemIndex := Value;
      if FItemIndex >= 0 then
      begin
        TElGroupButton(FButtons[FItemIndex]).Checked := True;
        Click;
        if Focused and TElGroupButton(FButtons[FItemIndex]).CanFocus then
           TElGroupButton(FButtons[FItemIndex]).SetFocus;
      end;
    end;
  end;
end;

procedure TCustomElRadioGroup.UpdateButtons;
var
  Btn : TElGroupButton;
begin
  inherited;

  if FItemIndex >= 0 then
  begin
    FUpdating := True;
    Btn := TElGroupButton(FButtons[FItemIndex]);
    Btn.Checked := True;
    FUpdating := False;
  end;
  if ComponentState * [csLoading, csReading] = [] then
    ArrangeButtons;
  if HandleAllocated then
    Invalidate;
end;

procedure TCustomElRadioGroup.IntCreateItem;
begin
  TElGroupButton.InternalCreate(Self);
end;

procedure TCustomElRadioGroup.ItemsChange(Sender: TObject);
begin
  if ItemIndex >= Items.Count then
    ItemIndex := -1;
  inherited;
end;

type
  TElCheckGroupBox = class(TElCheckBox)
  private
    FOwner: TComponent;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure SetChecked(newValue : Boolean); override;
  public
    constructor InternalCreate(ElCheckGroup: TCustomElCheckGroup);
    destructor Destroy; override;
  end;

constructor TElCheckGroupBox.InternalCreate(ElCheckGroup : TCustomElCheckGroup);
begin
  BeginCreate;
  inherited Create(ElCheckGroup);
  ElCheckGroup.FButtons.Add(Self);
  FOwner:= ElCheckGroup;
  Visible := False;
  Enabled := ElCheckGroup.Enabled;
  ParentShowHint := true;
  OnClick := ElCheckGroup.ButtonClick;
  Parent := ElCheckGroup;
//  TabStop := false;  // AH Removed.
  StyleManager := nil;
  EndCreate;
end;

destructor TElCheckGroupBox.Destroy;
begin
  TElCheckGroup(Owner).FButtons.Remove(Self);
  inherited Destroy;
end;

procedure TElCheckGroupBox.SetChecked(newValue: Boolean);
begin
  if TElCheckGroup(Parent).CanModify then inherited;
end;

procedure TElCheckGroupBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  THackGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
    if not TElCheckGroup(Parent).CanModify then Key := #0;
end;

procedure TElCheckGroupBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TElCheckGroup(Parent).KeyDown(Key, Shift);
end;

constructor TCustomElCheckGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAllowGrayed := true;
end;

function TCustomElCheckGroup.GetChecked(Index: Integer): Boolean;
begin
  Result := TElCheckGroupBox(FButtons[Index]).Checked;
end;

procedure TCustomElCheckGroup.SetChecked(Index: Integer; Value: Boolean);
begin
  TElCheckGroupBox(FButtons[Index]).Checked := Value;
end;

function TCustomElCheckGroup.GetState(Index: Integer): TCheckBoxState;
begin
  Result := TElCheckGroupBox(FButtons[Index]).State;
end;

procedure TCustomElCheckGroup.SetState(Index: Integer; Value: TCheckBoxState);
begin
  TElCheckGroupBox(FButtons[Index]).State := Value;
end;

procedure TCustomElCheckGroup.SetAllowGrayed(Value: Boolean);
var i : integer;
begin
  if FAllowGrayed <> Value then
  begin
    FAllowGrayed := Value;
    for i := 0 to FButtons.Count - 1 do
      TElCheckGroupBox(FButtons[i]).AllowGrayed := Value;
  end;
end;

procedure TCustomElCheckGroup.IntCreateItem;
begin
  TElCheckGroupBox.InternalCreate(Self);
end;

end.
