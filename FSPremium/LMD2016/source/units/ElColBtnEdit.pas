unit ElColBtnEdit;
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

ElColBtnEdit unit
-----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}
 { TElButtonCollectionEdit component. }

{todo: add property editor for ShortCut, ImageIndex}

interface

uses

  Windows,
  Messages,
  Graphics,
  Controls,
  StdCtrls,
  Forms,
  Types,
  Menus,
  SysUtils,
  Classes,
  LMDHTMLUnit

  ElPopBtn,
  ElVCLUtils,
  ElImgFrm,
  ElSndMap,
  ElEdits;

type

  // Collection Button
  TElCollButton = class(TElGraphicButton)
  end;

  // Edit Button Collection Item
  TElEditBtnItem = class (TCollectionItem)
   private
    function GetOnArrowClick: TNotifyEvent;
    function GetCaption: TCaption;
    function GetClickSound: TElSoundName;
    function GetColor: TColor;
    function GetCursor: TCursor;
    function GetDown: Boolean;
    function GetDownSound: TElSoundName;
    function GetEnabled: Boolean;
    function GetFlat: Boolean;
    function GetGlyph: TBitmap;
    function GetHint: string;
    function GetIcon: TIcon;
    function GetImageIndex:Integer;
    function GetImages: TCustomImageList;
    function GetIsHTML: Boolean;
    function GetIsSwitch: Boolean;
    function GetLinkColor: TColor;
    function GetLinkPopupMenu: TPopupMenu;
    function GetLinkStyle: TFontStyles;
    function GetNumGlyphs: integer;
    function GetOnClick: TNotifyEvent;
    function GetOnImageNeeded: TElHTMLImageNeededEvent;
    function GetOnLinkClick: TElHTMLLinkClickEvent;
    function GetPopupPlace: TPopupPlace;
    function GetPullDownMenu: TPopupMenu;
    function GetSoundMap: TElSoundMap;
    function GetThinFrame: Boolean;
    function GetUpSound: TElSoundName;
    function GetUseArrow: Boolean;
    function GetUseIcon: Boolean;
    function GetVisible: Boolean;
    function GetWidth: Integer;
    procedure SetOnArrowClick(const Value: TNotifyEvent);
    procedure SetCaption(const Value: TCaption);
    procedure SetClickSound(const Value: TElSoundName);
    procedure SetColor(const Value: TColor);
    procedure SetCursor(const Value: TCursor);
    procedure SetDown(const Value: Boolean);
    procedure SetDownSound(const Value: TElSoundName);
    procedure SetEnabled(const Value: Boolean);
    procedure SetFlat(const Value: Boolean);
    procedure SetGlyph(const Value: TBitmap);
    procedure SetHint(const Value: string);
    procedure SetIcon(const Value: TIcon);
    procedure SetImageIndex(const Value:integer);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetIsHTML(const Value: Boolean);
    procedure SetIsSwitch(const Value: Boolean);
    procedure SetLinkColor(const Value: TColor);
    procedure SetLinkPopupMenu(const Value: TPopupMenu);
    procedure SetLinkStyle(const Value: TFontStyles);
    procedure SetNumGlyphs(const Value: integer);
    procedure SetOnClick(const Value: TNotifyEvent);
    procedure SetOnImageNeeded(const Value: TElHTMLImageNeededEvent);
    procedure SetOnLinkClick(const Value: TElHTMLLinkClickEvent);
    procedure SetPopupPlace(const Value: TPopupPlace);
    procedure SetPullDownMenu(const Value: TPopupMenu);
    procedure SetSoundMap(const Value: TElSoundMap);
    procedure SetThinFrame(const Value: Boolean);
    procedure SetUpSound(const Value: TElSoundName);
    procedure SetUseArrow(const Value: Boolean);
    procedure SetUseIcon(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Integer);
    function GetUseImageList: Boolean;
    procedure SetUseImageList(const Value: Boolean);
    function GetTextDrawType: TElTextDrawType;
    procedure SetTextDrawType(const Value: TElTextDrawType);
    procedure SetShortcut(const Value: TShortcut);
   protected
    fButton   :TElCollButton;
    fShortcut :TShortcut;
    procedure AdjustEditorPositions; {Recalc button sizes}
   public
     constructor Create(Collection: TCollection);override;
     destructor Destroy; override;

     procedure Assign(Source: TPersistent); override;
     property Button:TElCollButton read fButton;
   published
    property Caption : TCaption read GetCaption write SetCaption;
    property ClickSound : TElSoundName read GetClickSound write SetClickSound;
    property Color : TColor read GetColor write SetColor;
    property Down : Boolean read GetDown write SetDown default false;
    property DownSound : TElSoundName read GetDownSound write SetDownSound;
    property Flat : Boolean read GetFlat write SetFlat;
    property Glyph : TBitmap read GetGlyph write SetGlyph;
    property Hint : string read GetHint write SetHint;
    property Icon : TIcon read GetIcon write SetIcon;
    property ImageIndex : Integer read GetImageIndex write SetImageIndex default -1;
    property Images:TImageList read GetImages write SetImages;
    property NumGlyphs : integer read GetNumGlyphs write SetNumGlyphs;
    property PopupPlace : TPopupPlace read GetPopupPlace write SetPopupPlace;
    property PullDownMenu : TPopupMenu read GetPullDownMenu write SetPullDownMenu;

    property SoundMap : TElSoundMap read GetSoundMap write SetSoundMap;

    property UpSound : TElSoundName read GetUpSound write SetUpSound;
    property UseArrow: Boolean read GetUseArrow write SetUseArrow default false;
    property UseIcon : Boolean read GetUseIcon write SetUseIcon default false;
    property UseImageList : Boolean read GetUseImageList write SetUseImageList default false;
    property Width : Integer read GetWidth write SetWidth;
    property Enabled : Boolean read GetEnabled write SetEnabled default true;
    property ThinFrame: Boolean read GetThinFrame write SetThinFrame default false;
    property TextDrawType : TElTextDrawType read GetTextDrawType write SetTextDrawType default tdtNormal;
    property IsSwitch: Boolean read GetIsSwitch write SetIsSwitch default false;

    property OnClick : TNotifyEvent read GetOnClick write SetOnClick;
    property OnArrowClick: TNotifyEvent read GetOnArrowClick write SetOnArrowClick;

    property Shortcut : TShortcut read fShortcut write SetShortcut; { Published }
    property Visible : Boolean read GetVisible write SetVisible default true;

    property IsHTML : Boolean read GetIsHTML write SetIsHTML default false;

    property OnImageNeeded: TElHTMLImageNeededEvent read GetOnImageNeeded write SetOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read GetOnLinkClick write SetOnLinkClick;
    property LinkColor: TColor read GetLinkColor write SetLinkColor default clBlue;
    property LinkPopupMenu: TPopupMenu read GetLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read GetLinkStyle write SetLinkStyle;
    property Cursor: TCursor read GetCursor write SetCursor default crDefault;

  end; { TElEditBtnItem }

  TCustomElButtonCollectionEdit = class;

  // Edit Buttons Collection
  TElEditBtnItems = class (TCollection)
  private
    fOwner: TCustomElButtonCollectionEdit;
    function GetItem(Index: integer): TElEditBtnItem;
    procedure SetItem(Index: integer; const Value: TElEditBtnItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner: TCustomElButtonCollectionEdit);
    function Add: TElEditBtnItem;
    property Items[Index: integer]: TElEditBtnItem read GetItem write SetItem; default;
  end; { TElEditBtnItems }

  // TElButtonCollectionEdit
  TCustomElButtonCollectionEdit = class(TCustomElEdit)
  private
    { Private declarations }
    fButtons: TElEditBtnItems;
    FBWidth: integer;// all buttons width
    procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure SetButtonItems(const Value: TElEditBtnItems);
    function GetButtons(Index: Integer): TElCollButton;
    function GetTransparent:Boolean;
    procedure SetTransparent(Value:Boolean);
  protected
    { Protected declarations }
    procedure Resize; override;
    procedure KeyPress(var Key : Char); override;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure SetEditRect(Value : TRect); override;
    procedure WMKeyDown(var Message: TWMKey); message WM_KEYDOWN;
    procedure SetUseXPThemes(const Value : boolean); override;
    procedure UpdateButtonStyles;
    procedure SetActiveBorderType(const Value: TElFlatBorderType); override;
    procedure SetFlat(const Value: boolean); override;
    procedure SetInactiveBorderType(const Value: TElFlatBorderType); override;
    procedure SetLineBorderActiveColor(Value: TColor); override;
    procedure SetLineBorderInactiveColor(Value: TColor); override;
    procedure AdjustEditorPositions;

    property ButtonItems:TElEditBtnItems read fButtons write SetButtonItems;
    property Buttons[Index:Integer]:TElCollButton read GetButtons;
  public
    { Public declarations }
    procedure Update;override;
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    property Transparent:Boolean read GetTransparent write SetTransparent;
  end; { TCustomElButtonCollectionEdit }

  TElButtonCollectionEdit = class(TCustomElButtonCollectionEdit)
  public
    property Buttons;

  published

    property StressShortCut;
    property ButtonItems;

    property AlignBottom;
    property CharCase;
    property UseDisabledColors;
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
    property Lines stored false;
    property ImageForm;
    property WordWrap;
    property ScrollBars;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property Text;
    property Multiline;

    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;

    // inherited
    property Flat;
    property ActiveBorderType;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property UseBackground;
    property UseSystemMenu;

    property Alignment;
    property AutoSelect;

    property Background;

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
    property ReadOnly;

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

  end; { TElButtonCollectionEdit }

implementation

{TCustomElButtonCollectionEdit}

constructor TCustomElButtonCollectionEdit.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  TabStop := true;
  fButtons := TElEditBtnItems.Create(Self);
end;

destructor TCustomElButtonCollectionEdit.Destroy;
begin
  fButtons.Free;
  fButtons := nil;
  inherited;
end;

procedure TCustomElButtonCollectionEdit.AdjustEditorPositions;
var
  x: integer;
  h: integer;
  I: Integer;
  w: Integer;
begin
  if (not HandleAllocated) or (csDestroying in ComponentState) then
  begin
    inherited;
    exit;
  end;

  x := ClientWidth;
  h := ClientHeight;

  if UseCustomScrollbars and Multiline and scbVert.Visible then
    Dec(x, scbVert.Width);

  FBWidth := 0;
  for I := fButtons.Count-1 DownTo 0 do
  begin
    if fButtons[I].Visible then
    begin
      w := fButtons[I].Width;
      fButtons[I].fButton.BoundsRect := Rect(x - w, 0, x, h);
      Dec(x, w);
      Inc(FBWidth, w);
    end;
  end;

  Invalidate;
end;

procedure TCustomElButtonCollectionEdit.Resize;

begin
   inherited;
   if (HandleAllocated) and (not (csDestroying in ComponentState)) then
     SetEditRect(ClientRect);
end;

procedure TCustomElButtonCollectionEdit.SetEditRect(Value : TRect);
var
  Loc   : TRect;
  HOffs : integer;
begin
  if (not HandleAllocated) or (csDestroying in ComponentState) then
  begin
    inherited;
    exit;
  end;

  if (BorderStyle = bsSingle) and (not Ctl3D) then
    Hoffs := GetSystemMetrics(SM_CYBORDER)
  else
    HOffs := 0;

   AdjustEditorPositions;

  SetRect(Loc, HOffs, 0, ClientWidth - HOffs - FBWidth - 1, ClientHeight);

  inherited SetEditRect(Loc);
end;

procedure TCustomElButtonCollectionEdit.Update;
begin
  if not ( (not HandleAllocated) or (csDestroying in ComponentState) ) then
    SetEditRect(ClientRect);
  inherited;
end;

procedure TCustomElButtonCollectionEdit.KeyPress(var Key : Char); { protected } //???
begin
  if (Key = Char(VK_RETURN)) or (Key = Char(VK_ESCAPE)) then
  begin
    {if HandleDialogKeys then
       GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
    }if Key = Char(VK_RETURN) then
    begin
      inherited KeyPress(Key);
      if not Multiline then
         Key := #0;
      Exit;
    end;
  end;
  inherited KeyPress(Key);
end; { KeyPress }

procedure TCustomElButtonCollectionEdit.CMEnabledChanged(var Msg : TMessage); { private }
begin
  inherited;
  NotifyControls(CM_ENABLEDCHANGED);
end; { CMEnabledChanged }

procedure TCustomElButtonCollectionEdit.KeyDown(var Key : Word; Shift : TShiftState); { protected }
var
  SC  :TShortcut;
  I   :Integer;
begin
  if (Key = 0)or(fButtons.Count=0) then
  begin
    inherited;
    exit;
  end;
  SC := Shortcut(Key, Shift);
  for I:=0 to fButtons.Count-1 do
  begin
      if (SC=fButtons[i].fShortcut) and (fButtons[i].fButton.Visible) and
         (fButtons[i].fButton.Enabled) and Assigned(fButtons[i].fButton.OnClick)
      then begin
          fButtons[i].fButton.Click;
          exit;
      end;
  end;
  inherited;
end; { KeyDown }

procedure TCustomElButtonCollectionEdit.WMGetDlgCode(var Msg : TWMGetDlgCode);  { private }
begin
  inherited;
  if Multiline then
    Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
end;  { WMGetDlgCode }

procedure TCustomElButtonCollectionEdit.WMKeyDown(var Message: TWMKey);//???
begin
  with Message do
    if (CharCode = VK_ESCAPE) and (KeyDataToShiftState(KeyData) = []) then
      GetParentForm(Self).Perform(CM_DIALOGKEY, CharCode, KeyData)
    else
    if (CharCode = VK_RETURN) and (KeyDataToShiftState(KeyData) = [ssCtrl]) then
    begin
      SendMessage(Handle, WM_CHAR, TMessage(Message).wParam, TMessage(Message).lParam);
      CharCode := 0;
    end
    else
      inherited;
end;

procedure TCustomElButtonCollectionEdit.SetUseXPThemes(const Value : boolean);
 var i:integer;
begin
  inherited;
  for i:=fButtons.Count-1 DownTo 0 do
    fButtons[i].fButton.UseXPThemes := Value;
end;

procedure TCustomElButtonCollectionEdit.UpdateButtonStyles;
 var i:integer;
begin
  for i:=fButtons.Count-1 DownTo 0 do
  begin
    fButtons[i].fButton.MoneyFlat := Flat and (InactiveBorderType = fbtColorLineBorder) and (ActiveBorderType = fbtColorLineBorder);
    fButtons[i].fButton.MoneyFlatActiveColor := LineBorderActiveColor;
    fButtons[i].fButton.MoneyFlatInactiveColor := LineBorderInactiveColor;
    fButtons[i].fButton.MoneyFlatDownColor := LineBorderActiveColor;
  end;
end;

procedure TCustomElButtonCollectionEdit.SetActiveBorderType(const Value:
    TElFlatBorderType);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonCollectionEdit.SetFlat(const Value: boolean);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonCollectionEdit.SetInactiveBorderType(const Value:
    TElFlatBorderType);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonCollectionEdit.SetLineBorderActiveColor(Value: TColor);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonCollectionEdit.SetLineBorderInactiveColor(Value: TColor);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonCollectionEdit.SetButtonItems(const Value: TElEditBtnItems);
begin
  fButtons.Assign(Value);
end;

function TCustomElButtonCollectionEdit.GetButtons(Index: Integer): TElCollButton;
begin
    Result := fButtons[Index].fButton;
end;

function TCustomElButtonCollectionEdit.GetTransparent:Boolean;
begin
    Result := inherited Transparent;
end;

procedure TCustomElButtonCollectionEdit.SetTransparent(Value:Boolean);
 var i:integer;
begin
    if Value<>inherited Transparent then
    begin
      inherited Transparent := Value;
      Value := inherited Transparent;
      for i:=fButtons.Count-1 DownTo 0 do
        fButtons[i].fButton.Transparent := Value;
    end;
end;

{ TElEditBtnItem }

procedure TElEditBtnItem.AdjustEditorPositions;
begin
   with TElEditBtnItems(Collection) do
   begin
      if (fOwner.HandleAllocated) and (not (csDestroying in fOwner.ComponentState)) then
        fOwner.SetEditRect(fOwner.ClientRect);
   end;
end;

procedure TElEditBtnItem.Assign(Source: TPersistent);
 var src:TElEditBtnItem;
begin
  if Source is TElEditBtnItem then
  begin
      src := TElEditBtnItem(Source);

      Caption      := src.Caption;
      ClickSound   := src.ClickSound;
      Color        := src.Color;
      Down         := src.Down;
      DownSound    := src.DownSound;
      Flat         := src.Flat;
      Glyph        := src.Glyph;
      Hint         := src.Hint;
      Icon         := src.Icon;
      ImageIndex   := src.ImageIndex;
      Images       := src.Images;
      NumGlyphs    := src.NumGlyphs;
      PopupPlace   := src.PopupPlace;
      PullDownMenu := src.PullDownMenu;
      SoundMap     := src.SoundMap;
      UpSound      := src.UpSound;
      UseArrow     := src.UseArrow;
      UseIcon      := src.UseIcon;
      UseImageList := src.UseImageList;
      Width        := src.Width;
      Enabled      := src.Enabled;
      ThinFrame    := src.ThinFrame;
      TextDrawType := src.TextDrawType;
      IsSwitch     := src.IsSwitch;

      OnClick      := src.OnClick;
      OnArrowClick := src.OnArrowClick;

      Shortcut     := src.Shortcut;
      Visible      := src.Visible;
      IsHTML       := src.IsHTML;

      OnImageNeeded:= src.OnImageNeeded;
      OnLinkClick  := src.OnLinkClick;
      LinkColor    := src.LinkColor;
      LinkPopupMenu:= src.LinkPopupMenu;
      LinkStyle    := src.LinkStyle;
      Cursor       := src.Cursor;
  end
  else inherited;
end;

constructor TElEditBtnItem.Create(Collection: TCollection);
begin
  fButton := TElCollButton.Create(nil);
  inherited;
  with fButton, TElEditBtnItems(Collection) do
  begin
    fButton.Parent := fOwner;
    Cursor := crArrow;
    ParentColor := false;
    Color := clBtnFace;
    Width := GetSystemMetrics(SM_CXVSCROLL);
    Flat := false;
    Visible := true;
    AdjustSpaceForGlyph := false;
    if csDesigning in ComponentState then
      Enabled := false;
    UseXPThemes :=  fOwner.UseXPThemes;
    Transparent :=  fOwner.Transparent;
  end;

  AdjustEditorPositions;
end;

destructor TElEditBtnItem.Destroy;
begin
  Visible := False; // auto update. D3: when remove one(last) button Collection don't generate Update event
  fButton.Free;
  inherited;
end;

function TElEditBtnItem.GetOnArrowClick: TNotifyEvent;
begin
    Result := fButton.OnArrowClick;
end;

function TElEditBtnItem.GetCaption: TCaption;
begin
    Result := fButton.Caption;
end;

function TElEditBtnItem.GetClickSound: TElSoundName;
begin
    Result := fButton.ClickSound;
end;

function TElEditBtnItem.GetColor: TColor;
begin
    Result := fButton.Color;
end;

function TElEditBtnItem.GetCursor: TCursor;
begin
    Result := fButton.Cursor;
end;

function TElEditBtnItem.GetDown: Boolean;
begin
    Result := fButton.Down;
end;

function TElEditBtnItem.GetDownSound: TElSoundName;
begin
    Result := fButton.DownSound;
end;

function TElEditBtnItem.GetEnabled: Boolean;
begin
    Result := fButton.Enabled;
end;

function TElEditBtnItem.GetFlat: Boolean;
begin
    Result := fButton.Flat;
end;

function TElEditBtnItem.GetGlyph: TBitmap;
begin
    Result := fButton.Glyph;
end;

function TElEditBtnItem.GetHint: string;
begin
    Result := fButton.Hint;
end;

function TElEditBtnItem.GetImageIndex:Integer;
begin
    Result := fButton.ImageIndex;
end;

function TElEditBtnItem.GetImages: TCustomImageList;
begin
    Result := fButton.Images;
end;

function TElEditBtnItem.GetIcon: TIcon;
begin
    Result := fButton.Icon;
end;

function TElEditBtnItem.GetIsHTML: Boolean;
begin
    Result := fButton.IsHTML;
end;

function TElEditBtnItem.GetIsSwitch: Boolean;
begin
    Result := fButton.IsSwitch;
end;

function TElEditBtnItem.GetLinkColor: TColor;
begin
    Result := fButton.LinkColor;
end;

function TElEditBtnItem.GetLinkPopupMenu: TPopupMenu;
begin
    Result := fButton.PopupMenu;
end;

function TElEditBtnItem.GetLinkStyle: TFontStyles;
begin
    Result := fButton.LinkStyle;
end;

function TElEditBtnItem.GetNumGlyphs: integer;
begin
    Result := fButton.NumGlyphs;
end;

function TElEditBtnItem.GetOnClick: TNotifyEvent;
begin
    Result := fButton.OnClick;
end;

function TElEditBtnItem.GetOnImageNeeded: TElHTMLImageNeededEvent;
begin
    Result := fButton.OnImageNeeded;
end;

function TElEditBtnItem.GetOnLinkClick: TElHTMLLinkClickEvent;
begin
    Result := fButton.OnLinkClick;
end;

function TElEditBtnItem.GetPopupPlace: TPopupPlace;
begin
    Result := fButton.PopupPlace;
end;

function TElEditBtnItem.GetPullDownMenu: TPopupMenu;
begin
    Result := fButton.PullDownMenu;
end;

function TElEditBtnItem.GetSoundMap: TElSoundMap;
begin
    Result := fButton.SoundMap;
end;

function TElEditBtnItem.GetTextDrawType: TElTextDrawType;
begin
    Result := fButton.TextDrawType;
end;

function TElEditBtnItem.GetThinFrame: Boolean;
begin
    Result := fButton.ThinFrame;
end;

function TElEditBtnItem.GetUpSound: TElSoundName;
begin
    Result := fButton.UpSound;
end;

function TElEditBtnItem.GetUseArrow: Boolean;
begin
    Result := fButton.UseArrow;
end;

function TElEditBtnItem.GetUseIcon: Boolean;
begin
    Result := fButton.UseIcon;
end;

function TElEditBtnItem.GetUseImageList: Boolean;
begin
    Result := fButton.UseImageList;
end;

function TElEditBtnItem.GetVisible: Boolean;
begin
    Result := fButton.Visible;
end;

function TElEditBtnItem.GetWidth: Integer;
begin
    Result := fButton.Width;
end;

procedure TElEditBtnItem.SetOnArrowClick(const Value: TNotifyEvent);
begin
    fButton.OnArrowClick := Value;
end;

procedure TElEditBtnItem.SetCaption(const Value: TCaption);
begin
    fButton.Caption := Value;
end;

procedure TElEditBtnItem.SetClickSound(const Value: TElSoundName);
begin
    fButton.ClickSound := Value;
end;

procedure TElEditBtnItem.SetColor(const Value: TColor);
begin
    fButton.Color := Value;
end;

procedure TElEditBtnItem.SetCursor(const Value: TCursor);
begin
    fButton.Cursor := Value;
end;

procedure TElEditBtnItem.SetDown(const Value: Boolean);
begin
    fButton.Down := Value;
end;

procedure TElEditBtnItem.SetDownSound(const Value: TElSoundName);
begin
    fButton.DownSound := Value;
end;

procedure TElEditBtnItem.SetEnabled(const Value: Boolean);
begin
    fButton.Enabled := Value;
end;

procedure TElEditBtnItem.SetFlat(const Value: Boolean);
begin
    fButton.Flat := Value;
end;

procedure TElEditBtnItem.SetGlyph(const Value: TBitmap);
begin
    fButton.Glyph := Value;
end;

procedure TElEditBtnItem.SetHint(const Value: string);
begin
    fButton.Hint := Value;
end;

procedure TElEditBtnItem.SetIcon(const Value: TIcon);
begin
    fButton.Icon := Value;
end;

procedure TElEditBtnItem.SetImageIndex(const Value:integer);
begin
    fButton.ImageIndex := Value;
end;

procedure TElEditBtnItem.SetImages(const Value: TCustomImageList);
begin
    fButton.Images := Value;
end;

procedure TElEditBtnItem.SetIsHTML(const Value: Boolean);
begin
    fButton.IsHTML := Value;
end;

procedure TElEditBtnItem.SetIsSwitch(const Value: Boolean);
begin
    fButton.IsSwitch := Value;
end;

procedure TElEditBtnItem.SetLinkColor(const Value: TColor);
begin
    fButton.LinkColor := Value;
end;

procedure TElEditBtnItem.SetLinkPopupMenu(const Value: TPopupMenu);
begin
    fButton.LinkPopupMenu := Value;
end;

procedure TElEditBtnItem.SetLinkStyle(const Value: TFontStyles);
begin
    fButton.LinkStyle := Value;
end;

procedure TElEditBtnItem.SetNumGlyphs(const Value: integer);
begin
    fButton.NumGlyphs := Value;
end;

procedure TElEditBtnItem.SetOnClick(const Value: TNotifyEvent);
begin
    fButton.OnClick := Value;
end;

procedure TElEditBtnItem.SetOnImageNeeded(const Value: TElHTMLImageNeededEvent);
begin
    fButton.OnImageNeeded := Value;
end;

procedure TElEditBtnItem.SetOnLinkClick(const Value: TElHTMLLinkClickEvent);
begin
    fButton.OnLinkClick := Value;
end;

procedure TElEditBtnItem.SetPopupPlace(const Value: TPopupPlace);
begin
    fButton.PopupPlace := Value;
end;

procedure TElEditBtnItem.SetPullDownMenu(const Value: TPopupMenu);
begin
    fButton.PullDownMenu := Value;
end;

procedure TElEditBtnItem.SetShortcut(const Value: TShortcut);
 var I:Integer;
begin
  if fShortcut <> Value then
  begin
    // Clear other references to same shortcut
    for I:=Collection.Count-1 DownTo 0 do
        if Value=TElEditBtnItems(Collection)[i].fShortcut then
           TElEditBtnItems(Collection)[i].fShortcut := 0;
    fShortcut := Value;
  end;
end;

procedure TElEditBtnItem.SetSoundMap(const Value: TElSoundMap);
begin
    fButton.SoundMap := Value;
end;

procedure TElEditBtnItem.SetTextDrawType(const Value: TElTextDrawType);
begin
    fButton.TextDrawType := Value;
end;

procedure TElEditBtnItem.SetThinFrame(const Value: Boolean);
begin
    fButton.ThinFrame := Value;
end;

procedure TElEditBtnItem.SetUpSound(const Value: TElSoundName);
begin
    fButton.UpSound := Value;
end;

procedure TElEditBtnItem.SetUseArrow(const Value: Boolean);
begin
    fButton.UseArrow := Value;
end;

procedure TElEditBtnItem.SetUseIcon(const Value: Boolean);
begin
    fButton.UseIcon := Value;
end;

procedure TElEditBtnItem.SetUseImageList(const Value: Boolean);
begin
    fButton.UseImageList := Value;
end;

procedure TElEditBtnItem.SetVisible(const Value: Boolean);
begin
    if fButton.Visible <> Value then
    begin
      fButton.Visible := Value;
      AdjustEditorPositions;
    end;
end;

procedure TElEditBtnItem.SetWidth(const Value: Integer);
begin
    if fButton.Width <> Value then
    begin
      fButton.Width := Value;
      AdjustEditorPositions;
    end;
end;

{ TElEditBtnItems }

function TElEditBtnItems.Add: TElEditBtnItem;
begin
  Result := TElEditBtnItem(inherited Add);
end;

constructor TElEditBtnItems.Create(AOwner: TCustomElButtonCollectionEdit);
begin
  inherited Create(TElEditBtnItem);
  fOwner := AOwner;
end;

function TElEditBtnItems.GetItem(Index: integer): TElEditBtnItem;
begin
  Result := TElEditBtnItem(inherited GetItem(Index));
end;

function TElEditBtnItems.GetOwner: TPersistent;
begin
  Result := fOwner;
end;

procedure TElEditBtnItems.SetItem(Index: integer; const Value: TElEditBtnItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TElEditBtnItems.Update(Item: TCollectionItem);
begin
   fOwner.Update;// need update when changed order
end;

end.
