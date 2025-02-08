unit ElBtnEdit;
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

ElBtnEdit unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

 { TElButtonEdit component. }

interface

uses

  Windows,
  Messages,
  Graphics,
  Controls,
  StdCtrls,
  Forms,
  Math,
  Types,
  Menus,
  SysUtils,
  Classes,

  ElPopBtn,
  ElVCLUtils,
  ElImgFrm,
  ElSndMap,
  ElEdits,

  LMDPNGImage,
  LMDClass,
  LMDTypes,
  LMDProcs,
  LMDThemes,
  LMDGlyphs;

type

  TAltButtonPropHelper = class(TPersistent)
  protected
    FAltButtonGlyph: TLMDButtonGlyph;
    FAltButtonPngGlyph: TLMDPNGObject;
    FAltButtonUsePng: Boolean;
    FAltButtonEnabled: Boolean;
    FAltButtonCaption: TCaption;
    FAltButtonClickSound : TElSoundName;
    FAltButtonDownSound : TElSoundName;
    FAltButtonSoundMap : TElSoundMap;
    FAltButtonUpSound : TElSoundName;
    FAltButtonColor: TColor;
    FAltButtonFlat : Boolean;
    {$ifdef LMD_UNICODE}
    FAltButtonHint : TLMDString;
    {$else}
    FAltButtonHint : String;
    {$endif}
    FAltButtonNumGlyphs : integer; //1
    FAltButtonPopupPlace : TPopupPlace; // ppDown;
    FAltButtonPullDownMenu : TPopupMenu;
    FAltButtonUseIcon : Boolean; // false;
    FAltButtonWidth : Integer; // -1;
    FAltButtonIsSwitch: Boolean; // false;
    FAltButtonThinFrame: Boolean; // false;
    FAltButtonTransparent: Boolean; // false;
    FAltButtonShowBorder: Boolean; // true;
    FAltButtonOldStyled: Boolean; // false;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure TuneButton(ABtn: TCustomElGraphicButton);
  end;

  TCustomElButtonEdit = class(TCustomElEdit)
  private
    FOnAltButtonClick : TNotifyEvent;
    FButtonShortcut : TShortcut;
    FAltButtonShortcut : TShortcut;
    FOnButtonClick : TNotifyEvent;
    FButtonEnabled: Boolean;
    FAltButtonPropHelper: TAltButtonPropHelper;

    procedure MakeAltButton;
    procedure SetButtonClickSound(newValue : TElSoundName);
    function GetButtonClickSound : TElSoundName;
    procedure SetButtonDownSound(newValue : TElSoundName);
    function GetButtonDownSound : TElSoundName;
    procedure SetButtonSoundMap(newValue : TElSoundMap);
    function GetButtonSoundMap : TElSoundMap;
    procedure SetButtonUpSound(newValue : TElSoundName);
    function GetButtonUpSound : TElSoundName;
    procedure SetAltButtonClickSound(newValue : TElSoundName);
    function GetAltButtonClickSound : TElSoundName;
    procedure SetAltButtonUpSound(newValue : TElSoundName);
    function GetAltButtonUpSound : TElSoundName;
    procedure SetAltButtonSoundMap(newValue : TElSoundMap);
    function GetAltButtonSoundMap : TElSoundMap;

    procedure SetButtonColor(newValue : TColor);
    function GetButtonColor : TColor;
    procedure SetButtonDown(newValue : Boolean);
    function GetButtonDown : Boolean;
    function GetButtonGlyph : TBitmap;
    {$ifdef LMD_UNICODE}
    procedure SetButtonHint(newValue: TLMDString);
    function GetButtonHint: TLMDString;
    {$else}
    procedure SetButtonHint(newValue: string);
    function GetButtonHint: string;
    {$endif}
    procedure SetButtonIcon(newValue : TIcon);
    function GetButtonIcon : TIcon;
    procedure SetButtonNumGlyphs(newValue : integer);
    function GetButtonNumGlyphs : integer;
    procedure SetButtonUseIcon(newValue : Boolean);
    function GetButtonUseIcon : Boolean;
    procedure SetButtonWidth(newValue : Integer);
    function GetButtonWidth : Integer;
    procedure ButtonClickTransfer(Sender : TObject); { TNotifyEvent }
    procedure SetButtonVisible(newValue : Boolean);
    function GetButtonVisible : Boolean;
    procedure SetAltButtonDown(newValue : Boolean);
    function GetAltButtonDown : Boolean;

    procedure SetAltButtonDownSound(newValue : TElSoundName);
    function GetAltButtonDownSound : TElSoundName;

    procedure SetAltButtonFlat(newValue : Boolean);
    function GetAltButtonFlat : Boolean;
    procedure SetAltButtonGlyph(newValue : TBitmap);
    function GetAltButtonGlyph : TBitmap;
    procedure SetAltButtonIcon(newValue : TIcon);
    function GetAltButtonIcon : TIcon;
    procedure SetAltButtonNumGlyphs(newValue : integer);
    function GetAltButtonNumGlyphs : integer;
    procedure SetAltButtonUseIcon(newValue : Boolean);
    function GetAltButtonUseIcon : Boolean;
    procedure SetAltButtonVisible(newValue : Boolean);
    function GetAltButtonVisible : Boolean;
    procedure SetAltButtonWidth(newValue : Integer);
    function GetAltButtonWidth : Integer;
    procedure AltButtonClickTransfer(Sender : TObject); { TNotifyEvent }
    procedure SetButtonFlat(newValue : Boolean);
    function GetButtonFlat : Boolean;
    procedure SetAltButtonEnabled(newValue : Boolean);
    function GetAltButtonEnabled : Boolean;
    procedure SetButtonEnabled(newValue : Boolean);
    function GetButtonEnabled : Boolean;
    procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
    {$ifdef LMD_UNICODE}
    procedure SetAltButtonHint(newValue : TLMDString);
    function GetAltButtonHint : TLMDString;
    {$else}
    procedure SetAltButtonHint(newValue : String);
    function GetAltButtonHint : String;
    {$endif}
    procedure SetAltButtonPopupPlace(newValue : TPopupPlace);
    function GetAltButtonPopupPlace : TPopupPlace;
    procedure SetAltButtonPullDownMenu(newValue : TPopupMenu);
    function GetAltButtonPullDownMenu : TPopupMenu;
    procedure SetButtonPopupPlace(newValue : TPopupPlace);
    function GetButtonPopupPlace : TPopupPlace;
    procedure SetButtonPullDownMenu(newValue : TPopupMenu);
    function GetButtonPullDownMenu : TPopupMenu;
    procedure SetAltButtonCaption(newValue : TCaption);
    function GetAltButtonCaption : TCaption;
    procedure SetButtonCaption(newValue : TCaption);
    function GetButtonCaption : TCaption;
    procedure SetAltBtnAlign(newValue : TLeftRight);
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure OnDropDownButtonChange(Sender: TObject);
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    function GetAltButtonPngGlyph: TLMDPngObject;
    function GetAltButtonUsePng: Boolean;
    function GetButtonPngGlyph: TLMDPngObject;
    function GetButtonUsePng: Boolean;
    procedure SetAltButtonPngGlyph(const Value: TLMDPngObject);
    procedure SetAltButtonUsePng(const Value: Boolean);
    procedure SetButtonPngGlyph(const Value: TLMDPngObject);
    procedure SetButtonUsePng(const Value: Boolean);
  protected
    { Protected declarations }
    FAltButton : TCustomElGraphicButton;
    FButton    : TCustomElGraphicButton;
    FAltBtnAlign : TLeftRight;
    ButtonClass : TCustomElGraphicButtonClass;
    AltButtonClass : TCustomElGraphicButtonClass;
    FButtonIsSwitch: Boolean;
    FButtonWidth: Integer;
    procedure DoMouseEnter; override;
    procedure DoMouseLeave; override;
    procedure ChangeScale(M, D: Integer); override;
    procedure WMSize(var Msg : TWMSize); message WM_Size;
    procedure KeyPress(var Key : Char); override;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure SetEditRect(Value : TRect); override;
    procedure WMKeyDown(var Message: TWMKey); message WM_KEYDOWN;
    function GetAltButtonColor: TColor;
    procedure SetAltButtonColor(Value: TColor);
    function GetButtonThinFrame: Boolean;
    procedure SetButtonThinFrame(Value: Boolean);
    function GetAltButtonThinFrame: Boolean;
    procedure SetAltButtonThinFrame(Value: Boolean);
    procedure SetUseXPThemes(const Value : boolean); override;
    procedure SetThemeGlobalMode(const Value: Boolean); override;
    procedure SetThemeMode(const Value: TLMDThemeMode); override;
    procedure UpdateButtonStyles;
    procedure SetActiveBorderType(const Value: TElFlatBorderType); override;
    procedure SetFlat(const Value: boolean); override;
    procedure SetInactiveBorderType(const Value: TElFlatBorderType); override;
    procedure SetLineBorderActiveColor(Value: TColor); override;
    procedure SetLineBorderInactiveColor(Value: TColor); override;
    function GetButtonClass: TCustomElGraphicButtonClass; virtual;
    function GetAltButtonClass: TCustomElGraphicButtonClass; virtual;
    function GetButtonTransparent: Boolean;
    procedure SetButtonTransparent(Value: Boolean);
    function GetAltButtonTransparent: Boolean;
    procedure SetAltButtonTransparent(Value: Boolean);
    function GetButtonIsSwitch: Boolean;
    procedure SetButtonIsSwitch(Value: Boolean);
    function GetAltButtonIsSwitch: Boolean;
    procedure SetAltButtonIsSwitch(Value: Boolean);
    procedure SetButtonGlyph(newValue : TBitmap); virtual;
    function GetButtonShowBorder: Boolean;
    procedure SetButtonShowBorder(Value: Boolean);
    function GetAltButtonShowBorder: Boolean;
    procedure SetAltButtonShowBorder(Value: Boolean);
    function GetButtonOldStyled: Boolean;
    procedure SetButtonOldStyled(Value: Boolean);
    function GetAltButtonOldStyled: Boolean;
    procedure SetAltButtonOldStyled(Value: Boolean);
    property ButtonCaption : TCaption read GetButtonCaption write SetButtonCaption;
    property ButtonClickSound : TElSoundName read GetButtonClickSound write SetButtonClickSound;
    property ButtonDownSound : TElSoundName read GetButtonDownSound write SetButtonDownSound;
    property ButtonColor : TColor read GetButtonColor write SetButtonColor default clBtnFace;
    property ButtonDown : Boolean read GetButtonDown write SetButtonDown default false;
    property ButtonFlat : Boolean read GetButtonFlat write SetButtonFlat default false;
    property ButtonGlyph : TBitmap read GetButtonGlyph write SetButtonGlyph;
    {$ifdef LMD_UNICODE}
    property ButtonHint: TLMDString read GetButtonHint write SetButtonHint;
    {$else}
    property ButtonHint: string read GetButtonHint write SetButtonHint;
    {$endif}
    property ButtonIcon : TIcon read GetButtonIcon write SetButtonIcon;
    property ButtonNumGlyphs : integer read GetButtonNumGlyphs write SetButtonNumGlyphs default 1;
    property ButtonPngGlyph: TLMDPngObject read GetButtonPngGlyph write SetButtonPngGlyph;
    property ButtonUsePng: Boolean read GetButtonUsePng write SetButtonUsePng;
    property ButtonPopupPlace : TPopupPlace read GetButtonPopupPlace write SetButtonPopupPlace default ppDown;
    property ButtonPullDownMenu : TPopupMenu read GetButtonPullDownMenu write SetButtonPullDownMenu;

    property ButtonSoundMap : TElSoundMap read GetButtonSoundMap write SetButtonSoundMap;
    property ButtonUpSound : TElSoundName read GetButtonUpSound write SetButtonUpSound;

    property ButtonUseIcon : Boolean read GetButtonUseIcon write SetButtonUseIcon default false;
    property ButtonWidth : Integer read GetButtonWidth write SetButtonWidth default -1;
    property ButtonEnabled : Boolean read GetButtonEnabled write SetButtonEnabled default true;
    property ButtonThinFrame: Boolean read GetButtonThinFrame write
        SetButtonThinFrame default false;
    property ButtonTransparent: Boolean read GetButtonTransparent write
        SetButtonTransparent default false;
    property ButtonIsSwitch: Boolean read GetButtonIsSwitch write SetButtonIsSwitch
        default false;

    property OnButtonClick : TNotifyEvent read FOnButtonClick write FOnButtonClick;
    property OnAltButtonClick : TNotifyEvent read FOnAltButtonClick write FOnAltButtonClick;

    property ButtonShortcut : TShortcut read FButtonShortcut write FButtonShortcut default 0; { Published }
    property AltButtonShortcut : TShortcut read FAltButtonShortcut write FAltButtonShortcut default 0; { Published }
    property ButtonVisible : Boolean read GetButtonVisible write SetButtonVisible default true;
    property AltButtonCaption : TCaption read GetAltButtonCaption write SetAltButtonCaption;

    property AltButtonClickSound : TElSoundName read GetAltButtonClickSound write SetAltButtonClickSound;
    property AltButtonDownSound : TElSoundName read GetAltButtonDownSound write SetAltButtonDownSound;
    property AltButtonSoundMap : TElSoundMap read GetAltButtonSoundMap write SetAltButtonSoundMap;
    property AltButtonUpSound : TElSoundName read GetAltButtonUpSound write SetAltButtonUpSound;

    property AltButtonColor: TColor read GetAltButtonColor write SetAltButtonColor default clbtnface;
    property AltButtonDown : Boolean read GetAltButtonDown write SetAltButtonDown default false;
    property AltButtonFlat : Boolean read GetAltButtonFlat write SetAltButtonFlat default false;
    property AltButtonGlyph : TBitmap read GetAltButtonGlyph write SetAltButtonGlyph;
    {$ifdef LMD_UNICODE}
    property AltButtonHint : TLMDString read GetAltButtonHint write SetAltButtonHint;
    {$else}
    property AltButtonHint : String read GetAltButtonHint write SetAltButtonHint;
    {$endif}
    property AltButtonPngGlyph: TLMDPngObject read GetAltButtonPngGlyph write SetAltButtonPngGlyph;
    property AltButtonUsePng: Boolean read GetAltButtonUsePng write SetAltButtonUsePng;

    property AltButtonIcon : TIcon read GetAltButtonIcon write SetAltButtonIcon;
    property AltButtonNumGlyphs : integer read GetAltButtonNumGlyphs write SetAltButtonNumGlyphs default 1;
    property AltButtonPopupPlace : TPopupPlace read GetAltButtonPopupPlace write SetAltButtonPopupPlace default ppDown;
    property AltButtonPosition : TLeftRight read FAltBtnAlign write SetAltBtnAlign default taRightJustify;
    property AltButtonPullDownMenu : TPopupMenu read GetAltButtonPullDownMenu write SetAltButtonPullDownMenu;
    property AltButtonUseIcon : Boolean read GetAltButtonUseIcon write SetAltButtonUseIcon default false;
    property AltButtonVisible : Boolean read GetAltButtonVisible write SetAltButtonVisible default false;
    property AltButtonWidth : Integer read GetAltButtonWidth write SetAltButtonWidth default -1;
    property AltButtonEnabled : Boolean read GetAltButtonEnabled write SetAltButtonEnabled default true;
    property AltButtonIsSwitch: Boolean read GetAltButtonIsSwitch write
        SetAltButtonIsSwitch default false;
    property AltButtonThinFrame: Boolean read GetAltButtonThinFrame write
        SetAltButtonThinFrame default false;
    property AltButtonTransparent: Boolean read GetAltButtonTransparent write
        SetAltButtonTransparent default false;
    property ButtonShowBorder: Boolean read GetButtonShowBorder write
        SetButtonShowBorder default true;
    property AltButtonShowBorder: Boolean read GetAltButtonShowBorder write
        SetAltButtonShowBorder default true;
    property ButtonOldStyled: Boolean read GetButtonOldStyled write
        SetButtonOldStyled default false;
    property AltButtonOldStyled: Boolean read GetAltButtonOldStyled write
        SetAltButtonOldStyled default false;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  end; { TCustomElButtonEdit }

  TElButtonEdit = class(TCustomElButtonEdit)
  published
    property AlignBottom;
    property CharCase;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property AutoSize;
    property RightAlignedView;
    property BorderSides;
    property PasswordChar;
    property MaxLength;
    property Transparent;
    property FlatFocusedScrollBars;
    property WantTabs;
    property HandleDialogKeys;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;

    property Cursor default crIBeam;

    property TabSpaces;
    property Lines stored false;
    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

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
    property LineBorderActiveColor default clBtnFace;
    property LineBorderInactiveColor default clBtnFace;

    property UseBackground;
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
    property ButtonDown;
    property ButtonEnabled;
    property ButtonFlat;
    property ButtonGlyph;
    property ButtonHint;
    property ButtonIcon;
    property ButtonIsSwitch;
    property ButtonNumGlyphs;
    property ButtonOldStyled;
    property ButtonPopupPlace;
    property ButtonPngGlyph;
    property ButtonUsePng;
    property ButtonPullDownMenu;
    property ButtonShowBorder;
    property ButtonShortcut;
    property ButtonTransparent;
    property ButtonThinFrame;
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
    property AltButtonIsSwitch;
    property AltButtonIcon;
    property AltButtonNumGlyphs;
    property AltButtonOldStyled;
    property AltButtonPopupPlace;
    property AltButtonPosition;
    property AltButtonPullDownMenu;
    property AltButtonShortcut;
    property AltButtonThinFrame;
    property AltButtonTransparent;
    property AltButtonUseIcon;
    property AltButtonShowBorder;
    property AltButtonVisible;
    property AltButtonWidth;
    property AltButtonPngGlyph;
    property AltButtonUsePng;

    property OnAltButtonClick;

    // VCL properties
    property BorderStyle default bsSingle;
    property Ctl3D default True;
    property ParentCtl3D default False;
    property Enabled;
    property TabStop default True;
    property TabOrder;
    property PopupMenu;
    property Color;
    property ParentColor default False;
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
    property OnKeyPressEx;
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

    property OnContextPopup;
    property Anchors;
    property Constraints;
    property DockOrientation default doNoOrient;
    property Floating;
    property DoubleBuffered default False;
    property DragKind;

  end;

implementation

uses
  LMDSysIn;

type
  TElEditBtn = class(TCustomElGraphicButton);

procedure TCustomElButtonEdit.SetButtonClickSound(newValue : TElSoundName);
{ Sets the FButton subcomponent's ClickSound property to newValue. }
begin
  TElEditBtn(FButton).ClickSound := newValue;
end; { SetButtonClickSound }

function TCustomElButtonEdit.GetButtonClickSound : TElSoundName;
{ Returns the ClickSound property from the FButton subcomponent. }
begin
  GetButtonClickSound := TElEditBtn(FButton).ClickSound;
end; { GetButtonClickSound }

procedure TCustomElButtonEdit.SetButtonColor(newValue : TColor);
{ Sets the FButton subcomponent's Color property to newValue. }
begin
  TElEditBtn(FButton).Color := newValue;
end; { SetButtonColor }

function TCustomElButtonEdit.GetButtonColor : TColor;
{ Returns the Color property from the FButton subcomponent. }
begin
  GetButtonColor := TElEditBtn(FButton).Color;
end; { GetButtonColor }

procedure TCustomElButtonEdit.SetButtonDown(newValue : Boolean);
{ Sets the FButton subcomponent's Down property to newValue. }
begin
  TElEditBtn(FButton).Down := newValue;
end; { SetButtonDown }

function TCustomElButtonEdit.GetButtonDown : Boolean;
{ Returns the Down property from the FButton subcomponent. }
begin
  GetButtonDown := TElEditBtn(FButton).Down;
end; { GetButtonDown }

procedure TCustomElButtonEdit.SetButtonDownSound(newValue : TElSoundName);
{ Sets the FButton subcomponent's DownSound property to newValue. }
begin
  TElEditBtn(FButton).DownSound := newValue;
end; { SetButtonDownSound }

function TCustomElButtonEdit.GetButtonDownSound : TElSoundName;
{ Returns the DownSound property from the FButton subcomponent. }
begin
  GetButtonDownSound := TElEditBtn(FButton).DownSound;
end; { GetButtonDownSound }

procedure TCustomElButtonEdit.SetButtonGlyph(newValue : TBitmap);
{ Sets the FButton subcomponent's Glyph property to newValue. }
begin
  TElEditBtn(FButton).Glyph := newValue;
end; { SetButtonGlyph }

function TCustomElButtonEdit.GetButtonGlyph : TBitmap;
{ Returns the Glyph property from the FButton subcomponent. }
begin
  GetButtonGlyph := TElEditBtn(FButton).Glyph;
end; { GetButtonGlyph }

{$ifdef LMD_UNICODE}
procedure TCustomElButtonEdit.SetButtonHint(newValue: TLMDString);
{$else}
procedure TCustomElButtonEdit.SetButtonHint(newValue: string);
{$endif}
{ Sets the FButton subcomponent's Hint property to newValue. }
begin
  TElEditBtn(FButton).Hint := newValue;
end; { SetButtonHint }

{$ifdef LMD_UNICODE}
function TCustomElButtonEdit.GetButtonHint: TLMDString;
{$else}
function TCustomElButtonEdit.GetButtonHint: string;
{$endif}
{ Returns the Hint property from the FButton subcomponent. }
begin
  GetButtonHint := TElEditBtn(FButton).Hint;
end; { GetButtonHint }

procedure TCustomElButtonEdit.SetButtonIcon(newValue : TIcon);
{ Sets the FButton subcomponent's Icon property to newValue. }
begin
  TElEditBtn(FButton).Icon := newValue;
end; { SetButtonIcon }

function TCustomElButtonEdit.GetButtonIcon : TIcon;
{ Returns the Icon property from the FButton subcomponent. }
begin
  GetButtonIcon := TElEditBtn(FButton).Icon;
end; { GetButtonIcon }

procedure TCustomElButtonEdit.SetButtonNumGlyphs(newValue : integer);
{ Sets the FButton subcomponent's NumGlyphs property to newValue. }
begin
  TElEditBtn(FButton).NumGlyphs := newValue;
end; { SetButtonNumGlyphs }

function TCustomElButtonEdit.GetButtonNumGlyphs : integer;
{ Returns the NumGlyphs property from the FButton subcomponent. }
begin
  GetButtonNumGlyphs := TElEditBtn(FButton).NumGlyphs;
end; { GetButtonNumGlyphs }

procedure TCustomElButtonEdit.SetButtonSoundMap(newValue : TElSoundMap);
{ Sets the FButton subcomponent's SoundMap property to newValue. }
begin
  TElEditBtn(FButton).SoundMap := newValue;
end; { SetButtonSoundMap }

function TCustomElButtonEdit.GetButtonSoundMap : TElSoundMap;
{ Returns the SoundMap property from the FButton subcomponent. }
begin
  GetButtonSoundMap := TElEditBtn(FButton).SoundMap;
end; { GetButtonSoundMap }

procedure TCustomElButtonEdit.SetButtonUpSound(newValue : TElSoundName);
{ Sets the FButton subcomponent's UpSound property to newValue. }
begin
  TElEditBtn(FButton).UpSound := newValue;
end; { SetButtonUpSound }

function TCustomElButtonEdit.GetButtonUpSound : TElSoundName;
{ Returns the UpSound property from the FButton subcomponent. }
begin
  GetButtonUpSound := TElEditBtn(FButton).UpSound;
end; { GetButtonUpSound }

procedure TCustomElButtonEdit.SetButtonUseIcon(newValue : Boolean);
{ Sets the FButton subcomponent's UseIcon property to newValue. }
begin
  TElEditBtn(FButton).UseIcon := newValue;
end;

procedure TCustomElButtonEdit.SetButtonUsePng(const Value: Boolean);
begin
  TElEditBtn(FButton).UsePng := Value;
end;

{ SetButtonUseIcon }

function TCustomElButtonEdit.GetButtonUseIcon : Boolean;
{ Returns the UseIcon property from the FButton subcomponent. }
begin
  GetButtonUseIcon := TElEditBtn(FButton).UseIcon;
end;

function TCustomElButtonEdit.GetButtonUsePng: Boolean;
begin
  Result := TElEditBtn(FButton).UsePng;
end;

{ GetButtonUseIcon }

procedure TCustomElButtonEdit.SetButtonWidth(newValue : Integer);
{ Sets the FButton subcomponent's Width property to newValue. }
begin
  FButtonWidth := newValue;
  if FButtonWidth = -1 then
  begin
    FButton.Width := GetSystemMetrics(SM_CXVSCROLL)
  end
  else
    FButton.Width := newValue;
    if FButton.Visible and HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end; { SetButtonWidth }

function TCustomElButtonEdit.GetButtonWidth : Integer;
{ Returns the Width property from the FButton subcomponent. }
begin
  result := FButtonWidth;
end; { GetButtonWidth }

procedure TCustomElButtonEdit.ButtonClickTransfer(Sender : TObject);
{ Transfers FButton OnClick event to the outside world. }
begin
  if (assigned(FOnButtonClick)) then
    FOnButtonClick(Self); { Substitute Self for subcomponent's Sender. }
end; { ButtonClickTransfer }

procedure TCustomElButtonEdit.WMSize(var Msg : TWMSize);
begin
  inherited;
end; { WMSize }

procedure TCustomElButtonEdit.SetEditRect(Value : TRect);
var
  R, Loc : TRect;
  HOffs,
  VOffs: integer;

  function ShiftToSide(ARect: TRect): TRect;
  begin
    Result := ARect;
    if FRightAlignedView then
      OffsetRect(Result, -ARect.Left, 0);
  end;

  function ShiftAltToSide(ARect: TRect): TRect;
  begin
    Result := ARect;
    if FRightAlignedView then
      OffsetRect(Result, FButton.Width, 0);
  end;

  procedure AdjustBoundsRect(aThemed: boolean; aIsAlignLeft: boolean);
  var
    lThemeMode: TLMDThemeMode;
  begin
    lThemeMode := UseThemeMode;
    if (lThemeMode = ttmNative) or ((lThemeMode = ttmPlatform) and not LMDSIWindowsVistaUp) then
      begin
        InflateRect(R, 0, 1);
        if aIsAlignLeft then
          OffsetRect(R, -1, 0)
        else
          OffsetRect(R, 1, 0);
      end;
  end;

begin
  if (not HandleAllocated) or (csDestroying in ComponentState) then
  begin
    inherited;
    exit;
  end;

  HOffs := 0;
  VOffs := 0;
  if ((BorderStyle = bsSingle) and (not Ctl3D)) then
  begin
    Hoffs := GetSystemMetrics(SM_CYBORDER);
    Voffs := GetSystemMetrics(SM_CXBORDER);
  end;

  if FButton.Visible then
  begin
    if FMultiLine then
      R := ShiftToSide(Rect(ClientWidth - FButton.Width - HOffs, VOffs, ClientWidth - HOffs, Min(FButton.Width, ClientHeight - VOffs)))
    else
      R := ShiftToSide(Rect(ClientWidth - FButton.Width - HOffs, VOffs, ClientWidth - HOffs, ClientHeight - VOffs));
    AdjustBoundsRect(FButton.IsThemed, RightAlignedView);
    FButton.BoundsRect := R;
  end;
  if Assigned(FAltButton) and FAltButton.Visible then
  begin
    if FButton.Visible then
      begin
        if FMultiLine then
          if FAltBtnAlign = taLeftJustify then
            R := ShiftAltToSide(Rect(HOffs, VOffs, HOffs + FAltButton.Width, Min(FAltButton.Width, ClientHeight - VOffs)))
          else
            R := ShiftAltToSide(Rect(ClientWidth - FButton.Width - FAltButton.Width - HOffs, VOffs, ClientWidth - FButton.Width - HOffs, Min(FAltButton.Width, ClientHeight - VOffs)))
        else
          if FAltBtnAlign = taLeftJustify then
            R := ShiftAltToSide(Rect(HOffs, VOffs, HOffs + FAltButton.Width, ClientHeight - VOffs))
          else
            R := ShiftAltToSide(Rect(ClientWidth - FButton.Width - FAltButton.Width - HOffs, VOffs, ClientWidth - FButton.Width - HOffs, ClientHeight- VOffs));
      end
    else
    begin
      if FMultiLine then
        if FAltBtnAlign = taLeftJustify then
          R := Rect(HOffs, VOffs, FButton.Width, Min(FAltButton.Width, ClientHeight- VOffs))
        else
          R := Rect(ClientWidth - FButton.Width - hOffs, VOffs, ClientWidth, Min(FAltButton.Width, ClientHeight- VOffs))
      else
        if FAltBtnAlign = taLeftJustify then
          R := Rect(HOffs, VOffs, FAltButton.Width, ClientHeight - VOffs)
        else
          R := Rect(ClientWidth - FAltButton.Width - HOffs, VOffs, ClientWidth, ClientHeight - VOffs);
    end;
    AdjustBoundsRect(FAltButton.IsThemed, FAltBtnAlign = taLeftJustify);
    FAltButton.BoundsRect := R;
  end;
  SetRect(Loc, HOffs, VOffs, ClientWidth - HOffs, ClientHeight - VOffs);

  // SetRect(Loc, HOffs, VOffs, Width - HOffs, Height - VOffs);
  if FButton.Visible then
  begin
   if not FRightAlignedView then
     Dec(Loc.Right, FButton.Width)
   else
     Inc(Loc.Left, FButton.Width);
  end;
  if Assigned(FAltButton) and FAltButton.Visible then
  begin
    if FAltBtnAlign = taLeftJustify then
      inc(Loc.Left, FAltButton.Width)
    else
      Dec(Loc.Right, FAltButton.Width);
  end;
  inherited SetEditRect(Loc);
end;

procedure TCustomElButtonEdit.KeyPress(var Key : Char); { protected }
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

{ Exposed properties' Read/Write methods: }

procedure TCustomElButtonEdit.SetButtonVisible(newValue : Boolean);
{ Sets the FButton subcomponent's Visible property to newValue. }
begin
  FButton.Visible := newValue;
  if HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end; { SetButtonVisible }

function TCustomElButtonEdit.GetButtonVisible : Boolean;
{ Returns the Visible property from the FButton subcomponent. }
begin
  GetButtonVisible := FButton.Visible;
end; { GetButtonVisible }

procedure TCustomElButtonEdit.SetAltButtonClickSound(newValue : TElSoundName);
begin
  FAltButtonPropHelper.FAltButtonClickSound := newValue;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).ClickSound := newValue;
end; { SetAltButtonClickSound }

function TCustomElButtonEdit.GetAltButtonClickSound : TElSoundName;
{ Returns the ClickSound property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonClickSound;
end; { GetAltButtonClickSound }

procedure TCustomElButtonEdit.SetAltButtonDown(newValue : Boolean);
{ Sets the FAltButton subcomponent's Down property to newValue. }
begin
  if Assigned(FAltButton) then
    TElEditBtn(FButton).Down := newValue;
end; { SetAltButtonDown }

function TCustomElButtonEdit.GetAltButtonDown : Boolean;
{ Returns the Down property from the FAltButton subcomponent. }
begin
  Result := False;
  if Assigned(FAltButton) then
    GetAltButtonDown := TElEditBtn(FAltButton).Down;
end; { GetAltButtonDown }

procedure TCustomElButtonEdit.SetAltButtonDownSound(newValue : TElSoundName);
{ Sets the FAltButton subcomponent's DownSound property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonDownSound := newValue;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).DownSound := newValue;
end; { SetAltButtonDownSound }

function TCustomElButtonEdit.GetAltButtonDownSound : TElSoundName;
{ Returns the DownSound property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonDownSound;
end; { GetAltButtonDownSound }

procedure TCustomElButtonEdit.SetAltButtonFlat(newValue : Boolean);
{ Sets the FAltButton subcomponent's Flat property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonFlat := newValue;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).Flat := newValue;
end; { SetAltButtonFlat }

function TCustomElButtonEdit.GetAltButtonFlat : Boolean;
{ Returns the Flat property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonFlat;
end; { GetAltButtonFlat }

procedure TCustomElButtonEdit.SetAltButtonGlyph(newValue : TBitmap);
{ Sets the FAltButton subcomponent's Glyph property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonGlyph.Glyph := newValue;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).Glyph := newValue;
end; { SetAltButtonGlyph }

function TCustomElButtonEdit.GetAltButtonGlyph : TBitmap;
{ Returns the Glyph property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonGlyph.Glyph;
end; { GetAltButtonGlyph }

procedure TCustomElButtonEdit.SetAltButtonIcon(newValue : TIcon);
{ Sets the FAltButton subcomponent's Icon property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonGlyph.Icon.Assign(newValue);
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).Icon := newValue;
end; { SetAltButtonIcon }

function TCustomElButtonEdit.GetAltButtonIcon : TIcon;
{ Returns the Icon property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonGlyph.Icon;
end; { GetAltButtonIcon }

procedure TCustomElButtonEdit.SetAltButtonNumGlyphs;
{ Sets the FAltButton subcomponent's NumGlyphs property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonNumGlyphs := newValue;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).NumGlyphs := newValue;
end; { SetAltButtonNumGlyphs }

function TCustomElButtonEdit.GetAltButtonNumGlyphs: Integer;
{ Returns the NumGlyphs property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonNumGlyphs;
end; { GetAltButtonNumGlyphs }

procedure TCustomElButtonEdit.SetAltButtonSoundMap(newValue : TElSoundMap);
{ Sets the FAltButton subcomponent's SoundMap property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonSoundMap := newValue;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).SoundMap := newValue;
end; { SetAltButtonSoundMap }

function TCustomElButtonEdit.GetAltButtonSoundMap : TElSoundMap;
{ Returns the SoundMap property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonSoundMap;
end; { GetAltButtonSoundMap }

procedure TCustomElButtonEdit.SetAltButtonUpSound(newValue : TElSoundName);
{ Sets the FAltButton subcomponent's UpSound property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonUpSound := newValue;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).UpSound := newValue;
end; { SetAltButtonUpSound }

function TCustomElButtonEdit.GetAltButtonUpSound : TElSoundName;
{ Returns the UpSound property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonUpSound;
end; { GetAltButtonUpSound }

procedure TCustomElButtonEdit.SetAltButtonUseIcon(newValue : Boolean);
{ Sets the FAltButton subcomponent's UseIcon property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonUseIcon := newValue;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).UseIcon := newValue;
end;

procedure TCustomElButtonEdit.SetAltButtonUsePng(const Value: Boolean);
begin
  FAltButtonPropHelper.FAltButtonUsePng := Value;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).UsePng := Value;
end;

{ SetAltButtonUseIcon }

function TCustomElButtonEdit.GetAltButtonUseIcon : Boolean;
{ Returns the UseIcon property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonUseIcon;
end;

function TCustomElButtonEdit.GetAltButtonUsePng: Boolean;
begin
  Result := FAltButtonPropHelper.FAltButtonUsePng;
end;

{ GetAltButtonUseIcon }

procedure TCustomElButtonEdit.SetAltButtonVisible(newValue : Boolean);
{ Sets the FAltButton subcomponent's Visible property to newValue. }
begin
  if newValue then
    MakeAltButton
  else
    FreeAndNil(FAltButton);

  if HandleAllocated then
  begin
    SetEditRect(ClientRect);
    Invalidate;
  end;
end; { SetAltButtonVisible }

function TCustomElButtonEdit.GetAltButtonVisible : Boolean;
{ Returns the Visible property from the FAltButton subcomponent. }
begin
  if Assigned(FAltButton) then
    GetAltButtonVisible := FAltButton.Visible
  else
    Result := False;
end; { GetAltButtonVisible }

procedure TCustomElButtonEdit.SetAltButtonWidth(newValue : Integer);
{ Sets the FAltButton subcomponent's Width property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonWidth := newValue;
  if Assigned(FAltButton) then
  begin
    if FAltButtonPropHelper.FAltButtonWidth = -1 then
    begin
      FAltButton.Width := GetSystemMetrics(SM_CXVSCROLL)
    end
    else
      FAltButton.Width := newValue;
    if FAltButton.Visible and HandleAllocated then
    begin
      SetEditRect(ClientRect);
      Invalidate;
    end;
  end;
end; { SetAltButtonWidth }

function TCustomElButtonEdit.GetAltButtonWidth : Integer;
{ Returns the Width property from the FAltButton subcomponent. }
begin
  result := FAltButtonPropHelper.FAltButtonWidth;
end; { GetAltButtonWidth }

procedure TCustomElButtonEdit.AltButtonClickTransfer(Sender : TObject);
{ Transfers FAltButton OnClick event to the outside world. }
begin
  if (assigned(FOnAltButtonClick)) then
    FOnAltButtonClick(Self); { Substitute Self for subcomponent's Sender. }
end; { AltButtonClickTransfer }

{ Exposed properties' Read/Write methods: }

procedure TCustomElButtonEdit.SetButtonFlat(newValue : Boolean);
{ Sets the FButton subcomponent's Flat property to newValue. }
begin
  TElEditBtn(FButton).Flat := newValue;
end; { SetButtonFlat }

function TCustomElButtonEdit.GetButtonFlat : Boolean;
{ Returns the Flat property from the FButton subcomponent. }
begin
  GetButtonFlat := TElEditBtn(FButton).Flat;
end; { GetButtonFlat }

procedure TCustomElButtonEdit.SetAltButtonEnabled(newValue : Boolean);
{ Sets the FAltButton subcomponent's Enabled property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonEnabled := newValue;
  if Assigned(FAltButton) then
    FAltButton.Enabled := newValue;
end; { SetAltButtonEnabled }

function TCustomElButtonEdit.GetAltButtonEnabled : Boolean;
{ Returns the Enabled property from the FAltButton subcomponent. }
begin
  GetAltButtonEnabled := FAltButtonPropHelper.FAltButtonEnabled;
end; { GetAltButtonEnabled }

procedure TCustomElButtonEdit.SetButtonEnabled(newValue : Boolean);
{ Sets the FButton subcomponent's Enabled property to newValue. }
begin
  FButton.Enabled := newValue;
  FButtonEnabled := newValue;
end; { SetButtonEnabled }

function TCustomElButtonEdit.GetButtonEnabled : Boolean;
{ Returns the Enabled property from the FButton subcomponent. }
begin
  GetButtonEnabled := FButtonEnabled;
end; { GetButtonEnabled }

procedure TCustomElButtonEdit.ChangeScale(M, D: Integer);
begin
  inherited;

  if Assigned(FAltButton) then
  begin
    if FAltButtonPropHelper.FAltButtonWidth = -1 then
      FAltButton.Width := GetSystemMetrics(SM_CXVSCROLL)
    else
      FAltButton.Width := FAltButtonPropHelper.FAltButtonWidth;
  end;
  if FButtonWidth = -1 then
    FButton.Width := GetSystemMetrics(SM_CXVSCROLL)
  else
    FButton.Width := FButtonWidth;
end;

procedure TCustomElButtonEdit.CMEnabledChanged(var Msg : TMessage); { private }
begin
  inherited;
  FButton.Enabled := Enabled and FButtonEnabled;
  if Assigned(FAltButton) then
    FAltButton.Enabled := Enabled and FAltButtonPropHelper.FAltButtonEnabled;
  NotifyControls(CM_ENABLEDCHANGED);
end; { CMEnabledChanged }

procedure TCustomElButtonEdit.KeyDown(var Key : Word; Shift : TShiftState); { protected }
var
  SC : TShortcut;
begin
  if Key = 0 then
  begin
    inherited;
    exit;
  end;
  SC := Shortcut(Key, Shift);
  if (SC = FButtonShortcut) and (FButton.Visible) and (FButton.Enabled) then
   FButton.Click
  else
  if (SC = FAltButtonShortcut) and Assigned(FAltButton) and (FAltButton.Visible) and (FAltButton.Enabled) then
    FAltButton.Click
  else
    inherited;
end; { KeyDown }

{ Exposed properties' Read/Write methods: }
{$ifdef LMD_UNICODE}
procedure TCustomElButtonEdit.SetAltButtonHint(newValue : TLMDString);
{$else}
procedure TCustomElButtonEdit.SetAltButtonHint(newValue : String);
{$endif}
{ Sets the FAltButton subcomponent's Hint property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonHint := newValue;
  if Assigned(FAltButton) then
    FAltButton.Hint := newValue;
end;  { SetAltButtonHint }

{$ifdef LMD_UNICODE}
function TCustomElButtonEdit.GetAltButtonHint : TLMDString;
{$else}
function TCustomElButtonEdit.GetAltButtonHint : String;
{$endif}
{ Returns the Hint property from the FAltButton subcomponent. }
begin
  GetAltButtonHint := FAltButtonPropHelper.FAltButtonHint;
end;  { GetAltButtonHint }

{ Exposed properties' Read/Write methods: }
procedure TCustomElButtonEdit.SetAltButtonPngGlyph(const Value: TLMDPngObject);
begin
  FAltButtonPropHelper.FAltButtonPngGlyph.Assign(Value);
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).PngGlyph := Value;
end;

procedure TCustomElButtonEdit.SetAltButtonPopupPlace(newValue : TPopupPlace);
{ Sets the FAltButton subcomponent's PopupPlace property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonPopupPlace := newValue;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).PopupPlace := newValue;
end;  { SetAltButtonPopupPlace }

function TCustomElButtonEdit.GetAltButtonPngGlyph: TLMDPngObject;
begin
  Result := FAltButtonPropHelper.FAltButtonPngGlyph;
end;

function TCustomElButtonEdit.GetAltButtonPopupPlace : TPopupPlace;
{ Returns the PopupPlace property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonPopupPlace;
end;  { GetAltButtonPopupPlace }

procedure TCustomElButtonEdit.SetAltButtonPullDownMenu(newValue : TPopupMenu);
{ Sets the FAltButton subcomponent's PullDownMenu property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonPullDownMenu := newValue;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).PullDownMenu := newValue;
end;  { SetAltButtonPullDownMenu }

function TCustomElButtonEdit.GetAltButtonPullDownMenu : TPopupMenu;
{ Returns the PullDownMenu property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonPullDownMenu;
end;  { GetAltButtonPullDownMenu }

procedure TCustomElButtonEdit.SetButtonPngGlyph(const Value: TLMDPngObject);
begin
  TElEditBtn(FButton).PngGlyph := Value;
end;

procedure TCustomElButtonEdit.SetButtonPopupPlace(newValue : TPopupPlace);
{ Sets the FButton subcomponent's PopupPlace property to newValue. }
begin
  TElEditBtn(FButton).PopupPlace := newValue;
end;  { SetButtonPopupPlace }

function TCustomElButtonEdit.GetButtonPngGlyph: TLMDPngObject;
begin
  Result := TElEditBtn(FButton).PngGlyph;
end;

function TCustomElButtonEdit.GetButtonPopupPlace : TPopupPlace;
{ Returns the PopupPlace property from the FButton subcomponent. }
begin
  GetButtonPopupPlace := TElEditBtn(FButton).PopupPlace;
end;  { GetButtonPopupPlace }

procedure TCustomElButtonEdit.SetButtonPullDownMenu(newValue : TPopupMenu);
{ Sets the FButton subcomponent's PullDownMenu property to newValue. }
begin
  TElEditBtn(FButton).PullDownMenu := newValue;
end;  { SetButtonPullDownMenu }

function TCustomElButtonEdit.GetButtonPullDownMenu : TPopupMenu;
{ Returns the PullDownMenu property from the FButton subcomponent. }
begin
  GetButtonPullDownMenu := TElEditBtn(FButton).PullDownMenu;
end;  { GetButtonPullDownMenu }

{ Exposed properties' Read/Write methods: }
procedure TCustomElButtonEdit.SetAltButtonCaption(newValue : TCaption);
{ Sets the FAltButton subcomponent's Caption property to newValue. }
begin
  FAltButtonPropHelper.FAltButtonCaption := newValue;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).Caption := newValue;
end;  { SetAltButtonCaption }

function TCustomElButtonEdit.GetAltButtonCaption : TCaption;
{ Returns the Caption property from the FAltButton subcomponent. }
begin
  Result := FAltButtonPropHelper.FAltButtonCaption;
end;  { GetAltButtonCaption }

procedure TCustomElButtonEdit.SetButtonCaption(newValue : TCaption);
{ Sets the FButton subcomponent's Caption property to newValue. }
begin
  TElEditBtn(FButton).Caption := newValue;
end;  { SetButtonCaption }

function TCustomElButtonEdit.GetButtonCaption : TCaption;
{ Returns the Caption property from the FButton subcomponent. }
begin
  GetButtonCaption := TElEditBtn(FButton).Caption;
end;  { GetButtonCaption }

procedure TCustomElButtonEdit.WMGetDlgCode(var Msg : TWMGetDlgCode);  { private }
begin
  inherited;
  if Multiline then
    Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
end;  { WMGetDlgCode }

procedure TCustomElButtonEdit.WMPaint(var Msg: TWMPaint);
begin
  if Assigned(FAltButtonPropHelper) then
    if Assigned(FAltButton) then
      FAltButtonPropHelper.TuneButton(FAltButton);
  inherited
end;

procedure TCustomElButtonEdit.SetAltBtnAlign(newValue : TLeftRight);
begin
  if newValue <> FAltBtnAlign then
  begin
    FAltBtnAlign := newValue;
    if HandleAllocated then
    begin
      SetEditRect(ClientRect);
      Invalidate;
    end;
  end;
end;

procedure TCustomElButtonEdit.DoMouseEnter;
begin
  inherited;
  if LMDSIWindowsVistaUp then
    FButton.Invalidate;
end;

procedure TCustomElButtonEdit.DoMouseLeave;
begin
  inherited;
  if LMDSIWindowsVistaUp then
    FButton.Invalidate;
end;

procedure TCustomElButtonEdit.OnDropDownButtonChange(Sender: TObject);
begin
  if  LMDSIWindowsVistaUp then
    Paint();
end;

destructor TCustomElButtonEdit.Destroy;
begin
  FButton.Free;
  if Assigned(FAltButton) then
    FAltButton.Free;
  FButton := nil;
  FAltButton := nil;
  FAltButtonPropHelper.Free;
  inherited;
end; { Destroy }

constructor TCustomElButtonEdit.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  BeginCreate;
  ButtonClass := GetButtonClass;
  AltButtonClass := GetAltButtonClass;
  FButton := ButtonClass.Create(nil);
    TElGraphicButton(FButton).OnMouseEnter := OnDropDownButtonChange;
    TElGraphicButton(FButton).OnMouseLeave := OnDropDownButtonChange;
  FButtonEnabled := true;
  FAltButtonPropHelper := TAltButtonPropHelper.Create;
  with TElEditBtn(FButton) do
  begin
    StyleManager := nil;
    Cursor := crArrow;
    ParentColor := false;
    Color := clBtnFace;
    Parent := Self;
    UseXPThemes := false;
    UseXPThemes := true;
    OnClick := ButtonClickTransfer;
    Width := GetSystemMetrics(SM_CXVSCROLL);
    Flat := false;
    Visible := true;
    AdjustSpaceForGlyph := false;
    if csDesigning in ComponentState then
      Enabled := false;
  end; { FButton }
  FAltBtnAlign := taRightJustify;
  TabStop := true;
  FButtonWidth := -1;
  EndCreate;
end; { Create }

procedure TCustomElButtonEdit.WMKeyDown(var Message: TWMKey);
begin
  with Message do
    if (CharCode = VK_ESCAPE) and (KeyDataToShiftState(KeyData) = []) then
    begin
      GetParentForm(Self).Perform(CM_DIALOGKEY, CharCode, KeyData);
      inherited;
    end
    else
      inherited;
end;

function TCustomElButtonEdit.GetAltButtonColor: TColor;
begin
  Result := FAltButtonPropHelper.FAltButtonColor;
end;

procedure TCustomElButtonEdit.SetAltButtonColor(Value: TColor);
begin
  FAltButtonPropHelper.FAltButtonColor := Value;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).Color := Value;
end;

function TCustomElButtonEdit.GetButtonThinFrame: Boolean;
begin
  Result := TElGraphicButton(FButton).ThinFrame;
end;

procedure TCustomElButtonEdit.SetButtonThinFrame(Value: Boolean);
begin
  TElGraphicButton(FButton).ThinFrame := Value;
end;

function TCustomElButtonEdit.GetAltButtonThinFrame: Boolean;
begin
  Result := FAltButtonPropHelper.FAltButtonThinFrame;
end;

procedure TCustomElButtonEdit.SetAltButtonThinFrame(Value: Boolean);
begin
  FAltButtonPropHelper.FAltButtonThinFrame := Value;
  if Assigned(FAltButton) then
    TElGraphicButton(FAltButton).ThinFrame := Value;
end;

procedure TCustomElButtonEdit.SetThemeGlobalMode(const Value: Boolean);
begin
  inherited;
  TElEditBtn(FButton).ThemeGlobalMode := Value;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).ThemeGlobalMode := Value;
end;

procedure TCustomElButtonEdit.SetThemeMode(const Value: TLMDThemeMode);
begin
  inherited;
  TElEditBtn(FButton).ThemeMode := Value;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).ThemeMode := Value;
end;

procedure TCustomElButtonEdit.SetUseXPThemes(const Value : boolean);
begin
  inherited;
  TElEditBtn(FButton).UseXPThemes := Value;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).UseXPThemes := Value;
end;

procedure TCustomElButtonEdit.UpdateButtonStyles;
begin
  TElEditBtn(FButton).MoneyFlat := Flat and (InactiveBorderType = fbtColorLineBorder) and (ActiveBorderType = fbtColorLineBorder);
  TElEditBtn(FButton).MoneyFlatActiveColor := LineBorderActiveColor;
  TElEditBtn(FButton).MoneyFlatInactiveColor := LineBorderInactiveColor;
  TElEditBtn(FButton).MoneyFlatDownColor := LineBorderActiveColor;
  if Assigned(FAltButton) then
    begin
      TElEditBtn(FAltButton).MoneyFlat := TElEditBtn(FButton).MoneyFlat;
      TElEditBtn(FAltButton).MoneyFlatActiveColor := LineBorderActiveColor;
      TElEditBtn(FAltButton).MoneyFlatInactiveColor := LineBorderInactiveColor;
      TElEditBtn(FAltButton).MoneyFlatDownColor := LineBorderActiveColor;
    end;
end;

procedure TCustomElButtonEdit.SetActiveBorderType(const Value:
    TElFlatBorderType);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonEdit.SetFlat(const Value: boolean);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonEdit.SetInactiveBorderType(const Value:
    TElFlatBorderType);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonEdit.SetLineBorderActiveColor(Value: TColor);
begin
  inherited;
  UpdateButtonStyles;
end;

procedure TCustomElButtonEdit.SetLineBorderInactiveColor(Value: TColor);
begin
  inherited;
  UpdateButtonStyles;
end;

function TCustomElButtonEdit.GetButtonClass: TCustomElGraphicButtonClass;
begin
  Result := TElEditBtn;
end;

function TCustomElButtonEdit.GetAltButtonClass: TCustomElGraphicButtonClass;
begin
  Result := TElEditBtn;
end;

function TCustomElButtonEdit.GetButtonTransparent: Boolean;
begin
  Result := TElEditBtn(FButton).Transparent;
end;

procedure TCustomElButtonEdit.SetButtonTransparent(Value: Boolean);
begin
  TElEditBtn(FButton).Transparent := Value;
end;

function TCustomElButtonEdit.GetAltButtonTransparent: Boolean;
begin
  Result := FAltButtonPropHelper.FAltButtonTransparent;
end;

procedure TCustomElButtonEdit.SetAltButtonTransparent(Value: Boolean);
begin
  FAltButtonPropHelper.FAltButtonTransparent := Value;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).Transparent := Value;
end;

function TCustomElButtonEdit.GetButtonIsSwitch: Boolean;
begin
  Result := TElEditBtn(FButton).IsSwitch;
end;

procedure TCustomElButtonEdit.SetButtonIsSwitch(Value: Boolean);
begin
  TElEditBtn(FButton).IsSwitch := Value;
end;

function TCustomElButtonEdit.GetAltButtonIsSwitch: Boolean;
begin
   Result := FAltButtonPropHelper.FAltButtonIsSwitch;
end;

procedure TCustomElButtonEdit.SetAltButtonIsSwitch(Value: Boolean);
begin
  FAltButtonPropHelper.FAltButtonIsSwitch := Value;
  if Assigned(FaltButton) then
    TElEditBtn(FAltButton).IsSwitch := Value;
end;

function TCustomElButtonEdit.GetButtonShowBorder: Boolean;
begin
  Result := TElEditBtn(FButton).ShowBorder;
end;

procedure TCustomElButtonEdit.SetButtonShowBorder(Value: Boolean);
begin
  TElEditBtn(FButton).ShowBorder := Value;
end;

function TCustomElButtonEdit.GetAltButtonShowBorder: Boolean;
begin
  Result := FAltButtonPropHelper.FAltButtonShowBorder;
end;

procedure TCustomElButtonEdit.SetAltButtonShowBorder(Value: Boolean);
begin
   FAltButtonPropHelper.FAltButtonShowBorder := Value;
   if Assigned(FAltButton) then
    TElEditBtn(FAltButton).ShowBorder := Value;
end;

function TCustomElButtonEdit.GetButtonOldStyled: Boolean;
begin
  Result := TElEditBtn(FButton).OldStyled;
end;

procedure TCustomElButtonEdit.SetButtonOldStyled(Value: Boolean);
begin
  TElEditBtn(FButton).OldStyled := Value;
end;

function TCustomElButtonEdit.GetAltButtonOldStyled: Boolean;
begin
  Result := FAltButtonPropHelper.FAltButtonOldStyled;
end;

procedure TCustomElButtonEdit.SetAltButtonOldStyled(Value: Boolean);
begin
  FAltButtonPropHelper.FAltButtonOldStyled := Value;
  if Assigned(FAltButton) then
    TElEditBtn(FAltButton).OldStyled := Value;
end;

procedure TCustomElButtonEdit.MakeAltButton;
begin
  if not Assigned(FAltButton) then
    FAltButton := AltButtonClass.Create(nil);
  with TElEditBtn(FAltButton) do
  begin
    StyleManager := nil;
    Cursor := crArrow;
    ParentColor := false;
    Parent := Self;
    ThemeMode := Self.ThemeMode;
    if ThemeMode <> ttmNative then
      begin
        UseXPThemes := false;
        UseXPThemes := Self.UseXPThemes;
      end;
    OnClick := AltButtonClickTransfer;
    Width := GetSystemMetrics(SM_CXVSCROLL);
    Flat := false;
    AdjustSpaceForGlyph := false;
    if csDesigning in ComponentState then
      Enabled := false;
  end;
  TElEditBtn(FAltButton).MoneyFlat := TElEditBtn(FButton).MoneyFlat;
  TElEditBtn(FAltButton).MoneyFlatActiveColor := LineBorderActiveColor;
  TElEditBtn(FAltButton).MoneyFlatInactiveColor := LineBorderInactiveColor;
  TElEditBtn(FAltButton).MoneyFlatDownColor := LineBorderActiveColor;
  FAltButtonPropHelper.TuneButton(FAltButton);
  FAltButton.Enabled := FAltButton.Enabled and Enabled;
end;

{ TAltButtonPropHelper }

constructor TAltButtonPropHelper.Create;
begin
  inherited;
  FAltButtonColor := clBtnFace;
  FAltButtonFlat := False;
  FAltButtonNumGlyphs := 1;
  FAltButtonPopupPlace := ppDown;
  FAltButtonUseIcon := false;
  FAltButtonWidth := -1;
  FAltButtonEnabled := true;
  FAltButtonIsSwitch := false;
  FAltButtonThinFrame := false;
  FAltButtonTransparent := false;
  FAltButtonShowBorder := true;
  FAltButtonOldStyled := false;
  FAltButtonEnabled := True;
  FAltButtonWidth := -1;
  FAltButtonGlyph := TLMDButtonGlyph.Create;
  FAltButtonPngGlyph := TLMDPNGObject.Create;
end;

destructor TAltButtonPropHelper.Destroy;
begin
  FreeAndNil(FAltButtonPngGlyph);
  FreeAndNil(FAltButtonGlyph);
  inherited;
end;

procedure TAltButtonPropHelper.TuneButton(ABtn: TCustomElGraphicButton);
begin
  with ABtn do
  begin
    TElEditBtn(ABtn).Caption := FAltButtonCaption;
    TElEditBtn(ABtn).ClickSound := FAltButtonClickSound;
    TElEditBtn(ABtn).Color := FAltButtonColor;
    TElEditBtn(ABtn).Flat := FAltButtonFlat;
    TElEditBtn(ABtn).NumGlyphs := FAltButtonNumGlyphs;
    TElEditBtn(ABtn).SoundMap := FAltButtonSoundMap;
    TElEditBtn(ABtn).UpSound := FAltButtonUpSound;
    TElEditBtn(ABtn).UseIcon := FAltButtonUseIcon;
    TElEditBtn(ABtn).DownSound := FAltButtonDownSound;
    TElEditBtn(ABtn).Glyph := FAltButtonGlyph.Glyph;
    TElEditBtn(ABtn).Icon := FAltButtonGlyph.Icon;
    TElEditBtn(ABtn).PopupPlace := FAltButtonPopupPlace;
    TElEditBtn(ABtn).PullDownMenu := FAltButtonPullDownMenu;
    TElGraphicButton(ABtn).ThinFrame := FAltButtonThinFrame;
    TElEditBtn(ABtn).Transparent := FAltButtonTransparent;
    TElEditBtn(ABtn).IsSwitch := FAltButtonIsSwitch;
    TElEditBtn(ABtn).ShowBorder := FAltButtonShowBorder;
    TElEditBtn(ABtn).PngGlyph := FAltButtonPngGlyph;
    TElEditBtn(ABtn).UsePng := FAltButtonUsePng;
    TElEditBtn(ABtn).OldStyled := FAltButtonOldStyled;
    if FAltButtonWidth = -1 then
      ABtn.Width := GetSystemMetrics(SM_CXVSCROLL)
    else
      ABtn.Width := FAltButtonWidth;
    ABtn.Enabled := FAltButtonEnabled;
    ABtn.Hint := FAltButtonHint;
  end;
end;

end.
