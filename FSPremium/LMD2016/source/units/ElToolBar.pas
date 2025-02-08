unit ElToolBar;
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

ElToolBar unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Variants, SysUtils, Classes, Windows, Math, Messages, Controls, Graphics, TypInfo,
  Forms, Buttons, ExtCtrls, Menus, Types, ImgList, ActnList, ToolWin,

  LMDProcs, LMDDebugUnit, LMDElConst, LMDThemes, Themes, LMDClass,  LMDObjectList,
  LMDSysIn, LMDGraph, LMDGlyphs, LMDPNGImageList, LMDTypes, LMDPngImage,

  ElImgFrm, ElIni, ElStrToken, ElXPThemedControl, ElPanel, ElStyleMan, ElSndMap,
  ElPopBtn, ElVCLUtils, ElMenus;

type
  TElBarOrientation = (eboHorz, eboVert);

  TElToolButtonType = (ebtButton, ebtSeparator, ebtDivider);

  TCustomElToolButton = class(TCustomElGraphicButton)
  private
    FIsMoreBtn: Boolean;
    FLargeGlyph: TLMDButtonGlyph;
    FGlyph: TLMDButtonGlyph;
    FButtonType : TElToolButtonType;
    FWrap : Boolean;
    ActionVisibleInverted,
    FSettingVisible,
    FRealVisible   : boolean;
    FFakeBoolProp  : boolean;
    FFakeIntProp   : integer;
    FFakeNotifyEvent : TNotifyEvent;
    FFakeBevelKind : TBevelKind;
    FButtonID: Integer;
    FOwnerSettings: Boolean;
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd); message WM_EraseBkgnd;
    procedure SetWrap(newValue : Boolean);
    procedure SetButtonType(newValue : TElToolButtonType);
    procedure SetLargeGlyph(newValue : TBitmap);
    procedure SetNumLargeGlyphs(newValue : Integer);
    procedure SetGlyph(newValue : TBitmap);
    procedure SetNumGlyphs(newValue : Integer);
    function GetNumGlyphs : integer;
    function GetNumLargeGlyphs : integer;
    function GetGlyph : TBitmap;
    function GetLargeGlyph : TBitmap;
    procedure GlyphChanged(Sender : TObject);
    procedure LargeGlyphChanged(Sender : TObject);
    procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
    function IsColorStored:Boolean;
  protected
    procedure SetUseArrow(newValue : boolean); override;
    procedure SwitchGlyphs(ToLarge : boolean);
    procedure SetFlat(Value : Boolean); override;
    procedure SetParent(AParent : TWinControl); override;
    procedure Paint; override;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;

    function GetDetails: TThemedElementDetails; override;
    function GetArrowDetails: TThemedElementDetails; override;

    procedure DrawThemedBackground(Canvas : TCanvas); override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadButtonID(Reader : TReader);
    procedure WriteButtonID(Writer : TWriter);
    procedure CMTextChanged(var Message : TMessage); message CM_TEXTCHANGED;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure ImagesChanged(Sender : TObject); override;
    procedure SetLayout(Value : TButtonLayout); override;
    procedure SetMargin(Value : Integer); override;
    procedure SetShowGlyph(newValue : Boolean); override;
    procedure SetShowText(newValue : Boolean); override;
    procedure SetSpacing(Value : Integer); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure Loaded; override;
    procedure SetOwnerSettings(Value: Boolean);
    procedure SetImageIndex(newValue : Integer); override;
    property Transparent;

    property Wrap : Boolean read FWrap write SetWrap default false;
    property ButtonType : TElToolButtonType read FButtonType write SetButtonType default ebtButton;
    property LargeGlyph : TBitmap read GetLargeGlyph write SetLargeGlyph; { Published }
    property NumLargeGlyphs : Integer read GetNumLargeGlyphs write SetNumLargeGlyphs default 1; { Protected }
    property Glyph : TBitmap read GetGlyph write SetGlyph; { Published }
    property NumGlyphs : Integer read GetNumGlyphs write SetNumGlyphs default 1; { Published }
    property OwnerSettings: Boolean read FOwnerSettings write SetOwnerSettings
        default true;

    property Default : boolean read FFakeBoolProp write FFakeBoolProp  stored false;
    property ShowFocus: boolean read FFakeBoolProp write FFakeBoolProp  stored false;
    property TabStop : boolean read FFakeBoolProp write FFakeBoolProp stored false;
    property TabOrder: integer read FFakeIntProp write FFakeIntProp stored false;
    property OnEnter : TNotifyEvent read FFakeNotifyEvent write FFakeNotifyEvent stored false;
    property OnExit : TNotifyEvent read FFakeNotifyEvent write FFakeNotifyEvent stored false;
    property Color stored IsColorStored;

  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    property RealVisible : boolean read FRealVisible default true;
  published

    property BevelKind : TBevelKind read FFakeBevelKind write FFakeBevelKind stored false;
    property DoubleBuffered : boolean read FFakeBoolProp write FFakeBoolProp stored false;
  end;

  TElToolButton = class(TCustomElToolButton)
  public
    constructor Create(AOwner : TComponent); override;
  published
    property GlyphMaskUsage;
    property UsePng;
    property PngGlyph;
    property Wrap;
    property ButtonType;
    property LargeGlyph;
    property NumLargeGlyphs;
    property Glyph;
    property NumGlyphs;
    property OwnerSettings;

    // ElGraphicButton properties
    property AdjustSpaceForGlyph;
    property PullDownMenu;
    property PopupPlace;
    property DisableAutoPopup;
    property Cancel;
    property ModalResult;
    property AllowAllUp;
    property GroupIndex;
    property Down;
    property Flat default True;
    property Layout;
    property Margin;
    property Spacing;
    property Alignment;
    property UseArrow;
    property ShadowFollowsColor;
    property ShowBorder;
    property ShowGlyph;
    property ShowText;
    property OnArrowClick;
    property Icon;
    property ImageIsAlphaBlended;
    property IsSwitch;
    property TextDrawType;
    property ThinFrame;

    property DownSound;
    property UpSound;
    property ClickSound;
    property ArrowClickSound;
    property SoundMap;

    property UseIcon;
    property ImageIndex;
    property UseImageList;
    property OldStyled;
    property Background;
    property DownBackground;
    property BackgroundDrawBorder;
    property Transparent;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
    // VCL properties
    property Caption;
    property Enabled;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;
    property Action;
    property Constraints;
    property OnContextPopup;
  end;

  TElToolButtonClass = class of TCustomElToolButton;

type
  TCustomElToolBar = class(TCustomElPanel)
  private
    FRightToLeft: boolean;
    FFirstTimeOrdered: boolean;
    FNoReAlign      : boolean;

    FMoreMenuDrawStyle: TDrawStyle;
    FMoreMenu       : TElPopupMenu;
    FMoreMenuItems  : TLMDObjectList;
    FMoreMenuVisible: Boolean;
//    FMoreMenuActive : boolean;
//    FIgnoreMoreClick: boolean;
    FShowMoreMenuBtn: TElToolButton;
    FShowMoreMenu   : Boolean;
    FMoremenuItemsImageList: TLMDPNGImageList;

    FTransparentButtons : Boolean;
    FUseImageList : Boolean;
    FImages : TCustomImageList;
    FHotImages : TCustomImageList;
    FDisabledImages : TCustomImageList;
    FDownImages: TCustomImageList;
    FAlphaImages : TCustomImageList;
    FAlphaHotImages : TCustomImageList;
    FAlphaDisabledImages : TCustomImageList;
    FAlphaDownImages: TCustomImageList;
    FUpdateCount : integer;
    FUpdatingButtons: integer;
    FUseLargeGlyphs : Boolean;
    FHidden : Boolean;
    FHideable : Boolean;
    FOrientation : TElBarOrientation;
    FButtonColor : TColor;
    FMinSize : integer;
    FAutoSize : Boolean;
    FFlat : Boolean;
    FLargeBtnWidth : Integer;
    FLargeBtnHeight : Integer;
    FGlyphLayout : TButtonLayout;
    FSpacing : Integer;
    FMargin : Integer;
    FShowGlyph : Boolean;
    FShowCaption : Boolean;
    FLargeSize : Boolean;
    FBtnWidth : Integer;
    FBtnHeight : Integer;
    FBtnOffsHorz : Integer;
    FBtnOffsVert : Integer;
    FAutoWrap : Boolean;
    FCreating : boolean;
    FSaveAlign : TAlign;
    FSortByTag : boolean;
    FDragObject: TDragDockObject;
    FOwnResizable: Boolean;
    //    FSaveSize: integer;
    FDummy : string;
    FButtonImageForm : TElImageForm;
    FMouseInControl: Boolean;
    procedure WMNCPaint(var Msg : TWMNCPaint); message WM_NCPAINT;
    procedure WMNCHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDown(var Msg : TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMWindowPosChanged(var Msg : TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMEraseBkGnd(var Msg : TWMEraseBkGnd); message WM_EraseBkgnd;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
  protected
    FThinButtons: Boolean;
    FStorage: TElIniFile;
    FStoragePath: string;
    FAdjustButtonWidth: Boolean;
    FAdjustButtonHeight: Boolean;
    FButtons: TLMDObjectList;
    FFocusedButton: TElToolButton;
    FTransparent : boolean;
    FImageIsAlphaBlended: Boolean;
    FShowBorder: Boolean;
    procedure SetMoreMenuDrawStyle(Value: TDrawStyle);
    procedure SetRightToLeft(Value: Boolean);virtual;
    procedure ChangeScale(M, D: Integer); override;
    procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
    procedure StartMoreMenu;
    procedure PutMoreItemsToBar;
    procedure OnMoreItemClick(Sender : TObject);
    procedure SetButtonImageForm(newValue : TElImageForm); virtual;
    procedure SetSortByTag(newValue : boolean);
    procedure SetBtnWidth(newValue : Integer); virtual;
    procedure SetBtnHeight(newValue : Integer); virtual;
    procedure SetFlat(newValue : Boolean); virtual;
    procedure SetLargeSize(newValue : Boolean); virtual;
    procedure SetLargeBtnWidth(newValue : Integer); virtual;
    procedure SetLargeBtnHeight(newValue : Integer); virtual;
    procedure SetButtonColor(newValue : TColor); virtual;
    procedure SetAutoSize(newValue : Boolean);override;
    procedure SetResizable(newValue : Boolean); override;
    procedure SetTransparentButtons(newValue : Boolean); virtual;
    procedure SetBtnOffsHorz(newValue : Integer); virtual;
    procedure SetBtnOffsVert(newValue : Integer); virtual;
    procedure SetAutoWrap(newValue : Boolean);
    procedure SetShowGlyph(newValue : Boolean);
    procedure SetShowCaption(newValue : Boolean);
    procedure SetGlyphLayout(newValue : TButtonLayout); virtual;
    procedure SetSpacing(newValue : Integer); virtual;
    procedure SetMargin(newValue : Integer); virtual;
    function GetToolButton(index : integer) : TElToolButton;
    function GetCustomToolButton(index : integer) : TCustomElToolButton;
    procedure SetToolButton(index : integer; newValue : TElToolButton);
    function GetButtonCount : Integer;
    procedure CMControlListChange(var Msg : TMessage); message CM_CONTROLLISTCHANGE;
    procedure CMControlChange(var Msg : TCMControlChange); message CM_CONTROLCHANGE;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure SetMinSize(newValue : integer);
    procedure SetOrientation(newValue : TElBarOrientation); virtual;
    //procedure SetHideable(newValue : Boolean);
    //procedure SetHidden(newValue : Boolean);
    procedure SetUseLargeGlyphs(newValue : Boolean);
    procedure SetImages(newValue : TCustomImageList);
    procedure SetHotImages(newValue : TCustomImageList);
    procedure SetDisabledImages(newValue : TCustomImageList);
    procedure SetAlphaImages(newValue : TCustomImageList);
    procedure SetAlphaHotImages(newValue : TCustomImageList);
    procedure SetAlphaDisabledImages(newValue : TCustomImageList);
    procedure SetUseImageList(newValue : Boolean);

    procedure SetShowMoreMenu(newValue : Boolean); virtual;
//    procedure SetMoreMenuActive(newValue : Boolean); virtual;
    procedure AlignControls(AControl : TControl; var Rect : TRect); override;
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure RedrawMoreBtn;
    function GetRealClientWidth : integer;
    function GetRealClientHeight : integer;
    function GetMoreBtnRect : TRect;
    procedure SetThinButtons(Value: Boolean);
    function GetFreeButtonID: Integer;
    function GetButtonByID(ID : Integer): TElToolButton;
    procedure SetAdjustButtonWidth(Value: Boolean);
    function GetEffectiveButtonWidth(Button : TCustomElToolButton; IncludeArrow :
        boolean): Integer;
    procedure SetAdjustButtonHeight(Value: Boolean);
    function GetEffectiveButtonHeight(Button : TCustomElToolButton): Integer;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure WMMouseLeave(var Message: TMessage); message WM_MOUSELEAVE;
    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure StartLeaveTracking;
    function GetButtonClass: TElToolButtonClass; virtual;
    procedure SetFocusedButton(Value: TElToolButton);
    procedure SetTransparent(newValue : Boolean); override;
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetThemeGlobalMode(const Value: Boolean);override;
    procedure SetThemeMode(const Value: TLMDThemeMode);override;

    procedure DoEnter; override;
    procedure SetParent(AParent: TWinControl); override;
    procedure SetImageIsAlphaBlended(Value: Boolean);
    procedure SetShowBorder(Value: Boolean);
    procedure SetDownImages(newValue : TCustomImageList);
    procedure SetAlphaDownImages(newValue : TCustomImageList);
    procedure UpdateButton(Button : TCustomElToolButton);
    procedure DoStartDock(var DragObject: TDragObject); override;
    procedure DoEndDock(Target: TObject; X: Integer; Y: Integer); override;

    property FocusedButton: TElToolButton read FFocusedButton write
        SetFocusedButton;

    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadImageIsAlphaBlended(Reader : TReader);
    procedure MouseOut; virtual;

    property BtnWidth : Integer read FBtnWidth write SetBtnWidth default 24;
    property BtnHeight : Integer read FBtnHeight write SetBtnHeight default 24;
    property BtnOffsHorz : Integer read FBtnOffsHorz write SetBtnOffsHorz default 3;
    property BtnOffsVert : Integer read FBtnOffsVert write SetBtnOffsVert default 3;
    property AutoWrap : Boolean read FAutoWrap write SetAutoWrap default False;
    property ShowGlyph : Boolean read FShowGlyph write SetShowGlyph default True;
    property ShowCaption : Boolean read FShowCaption write SetShowCaption default False;
    property LargeSize : Boolean read FLargeSize write SetLargeSize default False;
    property LargeBtnWidth : Integer read FLargeBtnWidth write SetLargeBtnWidth default 48;
    property LargeBtnHeight : Integer read FLargeBtnHeight write SetLargeBtnHeight default 48;
    property GlyphLayout : TButtonLayout read FGlyphLayout write SetGlyphLayout default blGlyphLeft;
    property Spacing : Integer read FSpacing write SetSpacing default 4;
    property Margin : Integer read FMargin write SetMargin default -1;
    property Flat : Boolean read FFlat write SetFlat default True;
    property AutoSize : Boolean read FAutoSize write SetAutoSize default True;
    property MinSize : integer read FMinSize write SetMinSize default 24;
    property ButtonColor : TColor read FButtonColor write SetButtonColor default clBtnFace;
    property ButtonImageForm : TElImageForm read FButtonImageForm write SetButtonImageForm;
    property Orientation : TElBarOrientation read FOrientation write SetOrientation default eboHorz;

    property UseLargeGlyphs : Boolean read FUseLargeGlyphs write SetUseLargeGlyphs default False; { Published }
    property Images : TCustomImageList read FImages write SetImages;
    property HotImages : TCustomImageList read FHotImages write SetHotImages;
    property DisabledImages : TCustomImageList read FDisabledImages write SetDisabledImages;
    property DownImages: TCustomImageList read FDownImages write SetDownImages;
    property AlphaForImages : TCustomImageList read FAlphaImages write SetAlphaImages;
    property AlphaForHotImages : TCustomImageList read FAlphaHotImages write SetAlphaHotImages;
    property AlphaForDisabledImages : TCustomImageList read FAlphaDisabledImages write SetAlphaDisabledImages;
    property AlphaForDownImages: TCustomImageList read FAlphaDownImages write SetAlphaDownImages;
    property UseImageList : Boolean read FUseImageList write SetUseImageList default False; { Published }
    property TransparentButtons : Boolean read FTransparentButtons write SetTransparentButtons default False; { Published }
    property ThinButtons: Boolean read FThinButtons write SetThinButtons default False;
    property Storage: TElIniFile read FStorage write FStorage;
    property StoragePath: string read FStoragePath write FStoragePath;
    property AdjustButtonWidth: Boolean read FAdjustButtonWidth write
        SetAdjustButtonWidth default true;
    property AdjustButtonHeight: Boolean read FAdjustButtonHeight write
        SetAdjustButtonHeight default true;
{
    property ImageIsAlphaBlended: Boolean read FImageIsAlphaBlended write
        SetImageIsAlphaBlended default false;
}
    property ShowBorder: Boolean read FShowBorder write SetShowBorder default true;
    property ShowMoreMenu : boolean read FShowMoreMenu write SetShowMoreMenu default False;
    property MoreMenuDrawStyle: TDrawStyle read FMoreMenuDrawStyle write SetMoreMenuDrawStyle default tdsNormal;
    public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    function AddButton(ButtonType : TELToolButtonType) : TElToolButton; virtual;
    procedure OrderedControls(L : TLMDObjectList);

    procedure AlignButtons; virtual;
    procedure UpdateButtons; virtual;
    procedure BeginUpdate;
    procedure EndUpdate;
    procedure Save;
    procedure Restore;
{$ifndef LMDDISABLE_ELTOOLBAR_SETUP}
    function Setup(ShowTextOptions, ShowIconOptions : boolean): Boolean;
{$endif}
    function GetNextButton(CurrentButton : TCustomElToolButton; Forward :
             boolean; IncludeDisabled : boolean) : TCustomElToolButton;

    property SortByTag: boolean read FSortByTag write SetSortByTag;
    property ToolButton[index : integer] : TElToolButton read GetToolButton write SetToolButton;
    property CustomToolButton[index : integer] : TCustomElToolButton read GetCustomToolButton;
    property ButtonCount : Integer read GetButtonCount;
    property RightToLeft: Boolean read FRightToLeft write SetRightToLeft default false;
    property Caption : string read FDummy write FDummy;
  end;

  TElToolBar = class(TCustomElToolbar)
  published
  // from TElPanel
    property WordWrap;
    property BorderSides;
    property BorderColorDkShadow;
    property BorderColorFace;
    property BorderColorShadow;
    property BorderColorHighlight;
    property BorderColorWindow;
    property BorderType;
    property AlphaLevel;
    property AlwaysPaintBackground;
    property Background;
    property BackgroundType;
    property GradientEndColor;
    property GradientStartColor;
    property GradientSteps;
    property Alignment;
    property Layout;
    property OwnerDraw;
    property ImageForm;
    property TopGrabHandle;
    property RightGrabHandle;
    property LeftGrabHandle;
    property BottomGrabHandle;

    property Resizable;
    property Movable;
    property OnMove;
    property OnPaint;

    property SizeGrip;
    property Align nodefault;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelSpaceColor;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
    property TransparentXPThemes;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

    property Color;

    property DragCursor;

    property DragMode;
    property Enabled;
    property Font;

    property Locked;
    property MouseCapture default False;

    property ParentColor;

    property ParentCtl3D;

    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowFocus;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property OnClick;
    property OnDblClick;
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
    property OnMouseEnter;
    property OnMouseLeave;
    property OnDockOver;
    property OnDockDrop;
    property OnUnDock;
    property OnEndDock;
    property DockSite;
    property OnResize;
    property OnContextPopup;
  //
    property RightToLeft;
    property BtnWidth;
    property BtnHeight;
    property BtnOffsHorz;
    property BtnOffsVert;
    property AutoWrap;
    property ShowGlyph;
    property ShowCaption;
    property LargeSize;
    property LargeBtnWidth;
    property LargeBtnHeight;
    property GlyphLayout;
    property Spacing;
    property Margin;
    property Flat;
    property MinSize;
    property ButtonColor;
    property ButtonImageForm;
    property Orientation;

    property UseLargeGlyphs;
    property Images;
    property HotImages;
    property DisabledImages;
    property DownImages;
    property AlphaForImages;
    property AlphaForHotImages;
    property AlphaForDisabledImages;
    property AlphaForDownImages;
    property UseImageList;
    property TransparentButtons;
    property ThinButtons;
    property Storage;
    property StoragePath;
    property AdjustButtonWidth;
    property AdjustButtonHeight;

    property ShowBorder;
    property ShowMoreMenu;
    property MoreMenuDrawStyle;
    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;
  end;

  TElToolButtonActionLink = class(TElGraphicButtonActionLink)
  protected
    function IsVisibleLinked: Boolean; override;
    procedure SetVisible(Value: Boolean); override;
  end;
  const
  DEF_SepSize : integer = 4;

implementation
{$ifndef LMDDISABLE_ELTOOLBAR_SETUP}
uses
  frmTbrStp,
  LMDSysIn;
{$endif}

var
  FMoreGlyph : TBitmap;

procedure TCustomElToolButton.GlyphChanged(Sender : TObject);
begin
  if (Parent <> nil) and ((not TCustomElToolBar(Parent).FLargeSize) or (not TCustomElToolBar(Parent).UseLargeGlyphs)) then
  begin
    inherited Glyph := Glyph;
    inherited NumGlyphs := NumGlyphs;
    Invalidate;
    if (Parent <> nil) and (Parent is TCustomElToolBar) then TCustomElToolBar(Parent).AlignButtons;
  end;
end;

procedure TCustomElToolButton.LargeGlyphChanged(Sender : TObject);
begin
  if (Parent <> nil) and (TCustomElToolBar(Parent).FLargeSize) and (TCustomElToolBar(Parent).UseLargeGlyphs) then
  begin
    inherited Glyph := LargeGlyph;
    inherited NumGlyphs := NumLargeGlyphs;
    Invalidate;
    if (Parent <> nil) and (Parent is TCustomElToolBar) then TCustomElToolBar(Parent).AlignButtons;
  end;
end;

destructor TCustomElToolButton.Destroy;
begin
  FGlyph.Free;
  FLargeGlyph.Free;
  inherited;
end;

constructor TCustomElToolButton.Create(AOwner : TComponent);
begin
  inherited;
  FOwnerSettings := true;
  FGlyph := TLMDButtonGlyph.Create;
  FGlyph.OnChange := GlyphChanged;
  FLargeGlyph := TLMDButtonGlyph.Create;
  FLargeGlyph.OnChange := LargeGlyphChanged;
  FRealVisible := true;
  ShortcutsEnabled := true;
 // SetButtonType();
end;

procedure TCustomElToolButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var b : boolean;
begin
  b := not (FMouseInControl or FMouseInArrow);
  inherited;
  if b then
    TElToolbar(Parent).StartLeaveTracking;
end;

procedure TCustomElToolButton.MouseDown(Button : TMouseButton; Shift :
    TShiftState; X, Y : Integer);
begin
  inherited;
  //if (Parent is TElToolbar) and Parent.CanFocus {and Parent.TabStop} then
  //  Parent.SetFocus;
end;

procedure TCustomElToolButton.Paint;
var
  R : TRect;
  VO,
  HO : integer;
begin
  if ButtonType <> ebtButton then
    if Caption <> '' then
      Caption := '';
  if not ((FButtonType = ebtSeparator) and (not(csDesigning in ComponentState))) then
    inherited;
  if (ButtonType = ebtDivider) and (not IsThemed) then
  begin
    if not Transparent then
      if (FImgForm = nil) or (csDesigning in FImgForm.GetRealControl.ComponentState) then
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect(ClientRect);
      end;
    R := ClientRect;
    if Parent is TCustomElToolBar then
    begin
      VO := (Parent as TCustomElToolBar).FBtnOffsVert;
      HO := (Parent as TCustomElToolBar).FBtnOffsHorz;
      if (Parent as TCustomElToolBar).Align in [alLeft, alRight] then
      begin
        R := Rect(HO, (R.Bottom - R.Top) div 2 - 1, (R.Right - R.Left) - HO, (R.Bottom - R.Top) div 2 + 2);
//        DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_RAISEDINNER, BF_TOP);
        DrawEdgeEx(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_RAISEDINNER, BF_TOP, (Parent as TCustomElToolBar).BorderColorFace, (Parent as TCustomElToolBar).BorderColorDkShadow, (Parent as TCustomElToolBar).BorderColorHighlight, (Parent as TCustomElToolBar).BorderColorShadow);
      end
      else
      begin
        R := Rect((R.Right - R.Left) div 2 - 1, VO, (R.Right - R.Left) div 2 + 2, (R.Bottom - R.Top) - VO);
//        DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_RAISEDINNER, BF_LEFT);
        DrawEdgeEx(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_RAISEDINNER, BF_LEFT, (Parent as TCustomElToolBar).BorderColorFace, (Parent as TCustomElToolBar).BorderColorDkShadow, (Parent as TCustomElToolBar).BorderColorHighlight, (Parent as TCustomElToolBar).BorderColorShadow);
      end;
    end
    else
    begin
      R := Rect((R.Right - R.Left) div 2 - 1, 2, (R.Right - R.Left) div 2 + 2, (R.Bottom - R.Top) - 2);
//      DrawEdge(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_RAISEDINNER, BF_LEFT);
      DrawEdgeEx(Canvas.Handle, R, BDR_SUNKENOUTER or BDR_RAISEDINNER, BF_LEFT, (Parent as TCustomElToolBar).BorderColorFace, (Parent as TCustomElToolBar).BorderColorDkShadow, (Parent as TCustomElToolBar).BorderColorHighlight, (Parent as TCustomElToolBar).BorderColorShadow);
    end;
  end;
end;

procedure TCustomElToolButton.SetParent(AParent : TWinControl);
begin
  if (Parent <> nil) and not (csDestroying in Parent.ComponentState) then
    Parent.RemoveFreeNotification(Self);
  if Assigned(AParent) then FreeNotification(AParent);
  inherited;
  if Assigned(AParent) and (AParent is TCustomElToolBar) then
    TCustomElToolBar(AParent).UpdateButtons;
end;

procedure TCustomElToolButton.SetUseArrow(newValue : boolean);
begin
  if newValue <> UseArrow then
  begin
    inherited;
    if (Parent <> nil) and (Parent is TCustomElToolBar) then
      TCustomElToolBar(Parent).AlignButtons;
  end;
end;

procedure TCustomElToolButton.SetFlat(Value : Boolean);
begin
  if (Value) or (ButtonType = ebtButton) then
    inherited;
end;

procedure TCustomElToolButton.SetWrap(newValue : Boolean);
begin
  if (FWrap <> newValue) then
  begin
    FWrap := newValue;
    if (Parent <> nil) and (Parent is TCustomElToolBar) then TCustomElToolBar(Parent).AlignButtons;
  end; {if}
end;

procedure TCustomElToolButton.SetButtonType(newValue : TElToolButtonType);
begin
  if (FButtonType <> newValue) then
  begin
    FButtonType := newValue;
    if FButtonType = ebtSeparator then
    begin
      Glyph.Assign(nil);
      Enabled := false;
      Flat := true;
      Caption := '';
      if (Parent is TCustomElToolBar) then
      begin
        // Color := TElToolBar(Parent).Color;
        ParentColor := True;
      end;
      ImageIndex := -1;
    end
    else if FButtonType = ebtDivider then
    begin
      Glyph.Assign(nil);
      Enabled := false;
      Flat := true;
      Caption := '';
      if (Parent is TCustomElToolBar) then
        Color := TCustomElToolBar(Parent).ButtonColor;
      if (Color = TCustomElToolBar(Parent).Color) then
        ParentColor := True;
      ImageIndex := -1;
    end;
    if Parent is TCustomElToolBar then
      with TCustomElToolBar(Parent) do
      begin
        UpdateButtons;
        AlignButtons;
      end; // with
  end; {if}
end; {SetButtonType}

function TCustomElToolButton.GetLargeGlyph: TBitmap;
begin
  Result := FLargeGlyph.Glyph;
end;

procedure TCustomElToolButton.SetLargeGlyph;
{ Sets data member FLargeGlyph to newValue. }
begin
  FLargeGlyph.Glyph := NewValue;
  if (Parent <> nil) and (TCustomElToolBar(Parent).FLargeSize) and (TCustomElToolBar(Parent).UseLargeGlyphs) then inherited Glyph := newValue;
end; { SetLargeGlyph }

function TCustomElToolButton.GetNumLargeGlyphs: Integer;
begin
  Result := FLargeGlyph.NumGlyphs;
end;

procedure TCustomElToolButton.SetNumLargeGlyphs;
{ Sets data member FNumLargeGlyphs to newValue. }
begin
  if NewValue < 0 then
    NewValue := 1
  else if NewValue > 4 then
    NewValue := 4;
  if NewValue <> FLargeGlyph.NumGlyphs then
  begin
    FLargeGlyph.NumGlyphs := NewValue;
    if (Parent <> nil) and (TCustomElToolBar(Parent).FLargeSize) and (TCustomElToolBar(Parent).UseLargeGlyphs) then inherited NumGlyphs := newValue;
  end;
end; { SetNumLargeGlyphs }

function TCustomElToolButton.GetGlyph: TBitmap;
begin
  Result := FGlyph.Glyph;
end;

procedure TCustomElToolButton.SetGlyph;
begin
  FGlyph.Glyph := newValue;
  if (Parent <> nil) and (not TCustomElToolBar(Parent).FLargeSize) then
    inherited Glyph := newValue;
end; { SetGlyph }

function TCustomElToolButton.GetNumGlyphs: Integer;
begin
  Result := FGlyph.NumGlyphs;
end;

procedure TCustomElToolButton.SetNumGlyphs;
{ Sets data member FNumGlyphs to newValue. }
begin
  if NewValue < 0 then
    NewValue := 1
  else if NewValue > 4 then
    NewValue := 4;
  if NewValue <> FGlyph.NumGlyphs then
  begin
    FGlyph.NumGlyphs := NewValue;
    if (Parent <> nil) and (not TCustomElToolBar(Parent).FLargeSize) then inherited NumGlyphs := NewValue;
  end;
end; { SetNumGlyphs }

procedure TCustomElToolButton.SwitchGlyphs(ToLarge : boolean);
begin
  if (Parent <> nil) then
  begin
    if (not ToLarge) then
    begin
      inherited Glyph := Glyph;
      inherited NumGlyphs := NumGlyphs;
    end
    else
    if (TCustomElToolBar(Parent).UseLargeGlyphs) then
    begin
      inherited Glyph := LargeGlyph;
      inherited NumGlyphs := NumLargeGlyphs;
    end;
    if (Parent is TCustomElToolBar) then TCustomElToolBar(Parent).AlignButtons;
  end;
end;

procedure TCustomElToolButton.CMEnabledChanged(var Msg : TMessage);

begin
  inherited;
  if ButtonType <> ebtButton then Enabled := false;
end;  { CMEnabledChanged }

function TCustomElToolButton.IsColorStored:Boolean;
begin
  if (Parent is TCustomElToolBar) then
  begin
    if ParentColor then
      with TCustomElToolBar(Parent) do
      begin
        case FButtonType of
          ebtButton:
            Result := Self.Color <> ButtonColor;
          ebtSeparator:
            Result := False; // Self.Color <> Color;
          ebtDivider:
            Result := Self.Color <> ButtonColor;
          else
            Result := True;
        end;
      end
      else
        Result := True;
  end
  else
    Result := ParentColor;
end;

function TCustomElToolButton.GetDetails: TThemedElementDetails;
begin
  case Self.FButtonType of
    ebtSeparator:
      begin
        if not Enabled then
          result := ThemeServices.GetElementDetails(ttbSplitButtonDisabled)
        else
        if FState in [ebsDown, ebsExclusive] then
          result := ThemeServices.GetElementDetails(ttbSplitButtonPressed)
        else
        if (Down and IsSwitch) then
        begin
          if FMouseInControl or FMouseInArrow then
            result := ThemeServices.GetElementDetails(ttbSplitButtonCheckedHot)
          else
            result := ThemeServices.GetElementDetails(ttbSplitButtonChecked);
        end
        else
        if FMouseInControl or FMouseInArrow or FInMenu then
          result := ThemeServices.GetElementDetails(ttbSplitButtonHot)
        else
          result := ThemeServices.GetElementDetails(ttbSplitButtonNormal);
      end;
    ebtDivider:
      begin
        if (Parent as TCustomElToolBar).Orientation = eboVert then
        begin
          if not Enabled then
            result := ThemeServices.GetElementDetails(ttbSeparatorVertDisabled)
          else
          if FState in [ebsDown, ebsExclusive] then
            result := ThemeServices.GetElementDetails(ttbSeparatorVertPressed)
          else
          if (Down and IsSwitch) then
          begin
            if FMouseInControl or FMouseInArrow then
              result := ThemeServices.GetElementDetails(ttbSeparatorVertCheckedHot)
            else
              result := ThemeServices.GetElementDetails(ttbSeparatorVertChecked);
          end
          else
          if FMouseInControl or FMouseInArrow or FInMenu then
            result := ThemeServices.GetElementDetails(ttbSeparatorVertHot)
          else
            result := ThemeServices.GetElementDetails(ttbSeparatorVertNormal);
        end
        else
        begin
          if not Enabled then
            result := ThemeServices.GetElementDetails(ttbSeparatorDisabled)
          else
          if FState in [ebsDown, ebsExclusive] then
            result := ThemeServices.GetElementDetails(ttbSeparatorPressed)
          else
          if (Down and IsSwitch) then
          begin
            if FMouseInControl or FMouseInArrow then
              result := ThemeServices.GetElementDetails(ttbSeparatorCheckedHot)
            else
              result := ThemeServices.GetElementDetails(ttbSeparatorChecked);
          end
          else
          if FMouseInControl or FMouseInArrow or FInMenu then
            result := ThemeServices.GetElementDetails(ttbSeparatorHot)
          else
            result := ThemeServices.GetElementDetails(ttbSeparatorNormal);
        end;
      end;
    else
      begin
        if (not UseArrow) and (PulldownMenu <> nil) then
        begin
          if not Enabled then
            result := ThemeServices.GetElementDetails(ttbDropDownButtonDisabled)
          else
          if FState in [ebsDown, ebsExclusive] then
            result := ThemeServices.GetElementDetails(ttbDropDownButtonPressed)
          else
          if (Down and IsSwitch) then
          begin
            if FMouseInControl or FMouseInArrow then
              result := ThemeServices.GetElementDetails(ttbDropDownButtonCheckedHot)
            else
              result := ThemeServices.GetElementDetails(ttbDropDownButtonChecked);
          end
          else
          if FMouseInControl or FMouseInArrow or FInMenu then
            result := ThemeServices.GetElementDetails(ttbDropDownButtonHot)
          else
            result := ThemeServices.GetElementDetails(ttbDropDownButtonNormal);
        end
        else
        if UseArrow then
        begin
          if not Enabled then
            result := ThemeServices.GetElementDetails(ttbSplitButtonDisabled)
          else
          if FState in [ebsDown, ebsExclusive] then
            result := ThemeServices.GetElementDetails(ttbSplitButtonPressed)
          else
          if (Down and IsSwitch) then
          begin
            if FMouseInControl or FMouseInArrow then
              result := ThemeServices.GetElementDetails(ttbSplitButtonCheckedHot)
            else
              result := ThemeServices.GetElementDetails(ttbSplitButtonChecked);
          end
          else
          if FMouseInControl or FMouseInArrow or FInMenu then
            result := ThemeServices.GetElementDetails(ttbSplitButtonHot)
          else
            result := ThemeServices.GetElementDetails(ttbSplitButtonNormal);
        end
        else
        begin
          if not Enabled then
            result := ThemeServices.GetElementDetails(ttbButtonDisabled)
          else
          if FState in [ebsDown, ebsExclusive] then
            result := ThemeServices.GetElementDetails(ttbButtonPressed)
          else
          if (Down and IsSwitch) then
          begin
            if FMouseInControl or FMouseInArrow then
              result := ThemeServices.GetElementDetails(ttbButtonCheckedHot)
            else
              result := ThemeServices.GetElementDetails(ttbButtonChecked);
          end
          else
          if FMouseInControl or FMouseInArrow or FInMenu then
            result := ThemeServices.GetElementDetails(ttbButtonHot)
          else
            result := ThemeServices.GetElementDetails(ttbButtonNormal);
        end;
      end;
  end;
end;

function TCustomElToolButton.GetArrowDetails: TThemedElementDetails;
begin
  if not Enabled then
    result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownDisabled)
  else
  if FState in [ebsArrDown, ebsDown, ebsExclusive] then
    result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownPressed)
  else
  if FMouseInArrow or FMouseInControl then
    result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownHot)
  else
    result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownNormal);
end;

procedure TCustomElToolButton.DrawThemedBackground;
var
  Details: TThemedElementDetails;
begin
  if not Transparent then
  begin
    Details.Element := teToolBar;
    LMDThemeServices.DrawElement(UseThemeMode, Canvas.Handle, Details, ClientRect);
    //DrawThemeBackground(Theme, Canvas.Handle, 0, 0, ClientRect, nil);
  end;
end;

procedure TCustomElToolButton.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ButtonID', ReadButtonID, WriteButtonID, FButtonID <> 0);
end;

procedure TCustomElToolButton.ReadButtonID(Reader : TReader);
begin
  FButtonID := Reader.ReadInteger;
end;

procedure TCustomElToolButton.WriteButtonID(Writer : TWriter);
var
  i: TValueType;
begin
  i := vaInt32;
  Writer.Write(i, SizeOf(i));
  Writer.Write(FButtonID, SizeOf(FButtonID));
end;

procedure TCustomElToolButton.CMTextChanged(var Message : TMessage);

begin
  inherited;
  if (Parent <> nil) and (Parent is TCustomElToolBar) then TCustomElToolBar(Parent).AlignButtons;
end;

procedure TCustomElToolButton.ImagesChanged(Sender : TObject);
begin
  inherited;
  if FUseImageList then
    if (Parent <> nil) and (Parent is TCustomElToolBar) then TCustomElToolBar(Parent).AlignButtons;
end;

procedure TCustomElToolButton.SetLayout(Value : TButtonLayout);
begin
  if Layout <> Value then
  begin
    inherited;
    if (Parent <> nil) and (Parent is TCustomElToolBar) then
    begin
      FOwnerSettings := FOwnerSettings and (Value = TCustomElToolBar(Parent).FGlyphLayout);
      TCustomElToolBar(Parent).AlignButtons;
    end;
  end;
end;

procedure TCustomElToolButton.SetMargin(Value : Integer);
begin
  if (Value <> FMargin) then
  begin
    inherited;
    if (Parent <> nil) and (Parent is TCustomElToolBar) then
    begin
      FOwnerSettings :=  FOwnerSettings and (Value = TCustomElToolBar(Parent).FMargin);
      TCustomElToolBar(Parent).AlignButtons;
    end;
  end;
end;

procedure TCustomElToolButton.SetShowGlyph(newValue : Boolean);
begin
  if (ShowGlyph <> newValue) then
  begin
    inherited;
    if (Parent <> nil) and (Parent is TCustomElToolBar) then
    begin
      FOwnerSettings :=  FOwnerSettings and (newValue = TCustomElToolBar(Parent).FShowGlyph);
      TCustomElToolBar(Parent).AlignButtons;
    end;
  end; { if }
end; { SetShowGlyph }

procedure TCustomElToolButton.SetShowText(newValue : Boolean);
begin
  if (ShowText <> newValue) then
  begin
    inherited;
    if (Parent <> nil) and (Parent is TCustomElToolBar) then
    begin
      FOwnerSettings :=  FOwnerSettings and (newValue = TCustomElToolBar(Parent).FShowCaption);
      TCustomElToolBar(Parent).AlignButtons;
    end;
  end; { if }
end; { SetShowText }

procedure TCustomElToolButton.SetSpacing(Value : Integer);
begin
  if Value <> Spacing then
  begin
    inherited;
    if (Parent <> nil) and (Parent is TCustomElToolBar) then
    begin
      FOwnerSettings :=  FOwnerSettings and (Value = TCustomElToolBar(Parent).FSpacing);
      TCustomElToolBar(Parent).AlignButtons;
    end;
  end;
end;

function TCustomElToolButton.GetActionLinkClass: TControlActionLinkClass;
begin
  result := TElToolButtonActionLink;
end;

procedure TCustomElToolButton.CMVisibleChanged(var Message: TMessage);

begin
  if (not FSettingVisible) then
  begin
    FRealVisible := Visible;
    if (Action <> nil) then
    begin
      if (not TAction(Action).Visible) xor ActionVisibleInverted then
      begin
        FSettingVisible := true;
        Visible := false;
        FSettingVisible := false;
      end;
    end;
    inherited;
  end;
end;

procedure TCustomElToolButton.Loaded;
begin
  inherited;
  // FRealVisible := Visible;
end;

procedure TCustomElToolButton.SetOwnerSettings(Value: Boolean);
begin
  if FOwnerSettings <> Value then
  begin
    FOwnerSettings := Value;
    if (Parent <> nil) and (Parent is TCustomElToolBar) then
      TCustomElToolBar(Parent).UpdateButton(Self);
  end;
end;

procedure TCustomElToolButton.SetImageIndex(newValue : Integer);
begin
  if ImageIndex <> newValue then
  begin
    if ButtonType = ebtButton then
    begin
      inherited;
      if (Parent <> nil) and (Parent is TCustomElToolBar) and UseImageList
         and (TCustomElToolBar(Parent).AdjustButtonWidth or TCustomElToolBar(Parent).AdjustButtonHeight) then
        TCustomElToolBar(Parent).AlignButtons;
    end;
  end;
end;

// =============================================================================

procedure TCustomElToolBar.SetButtonImageForm(newValue : TElImageForm);
begin
  if (FButtonImageForm <> nil) and (not (csDestroying in FButtonImageForm.ComponentState)) then
    FButtonImageForm.RemoveFreeNotification(Self);
  FButtonImageForm := newValue;
  if newValue <> nil then
     newValue.FreeNotification(Self);
  if csLoading in ComponentState then exit;
  UpdateButtons;
end;

procedure TCustomElToolBar.SetSortByTag(newValue : boolean);
begin
  if FSortByTag <> newValue then
  begin
    FSortByTag := newValue;
    AlignButtons;
  end;
end;

procedure TCustomElToolBar.SetBtnWidth(newValue : Integer);
begin
  if (FBtnWidth <> newValue) then
  begin
    FBtnWidth := newValue;
    if csLoading in ComponentState then exit;
    AlignButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetBtnHeight(newValue : Integer);
begin
  if (FBtnHeight <> newValue) then
  begin
    FBtnHeight := newValue;
    if csLoading in ComponentState then exit;
    AlignButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetBtnOffsHorz(newValue : Integer);
begin
  if (FBtnOffsHorz <> newValue) then
  begin
    FBtnOffsHorz := newValue;
    if csLoading in ComponentState then exit;
    AlignButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetBtnOffsVert(newValue : Integer);
begin
  if (FBtnOffsVert <> newValue) then
  begin
    FBtnOffsVert := newValue;
    if csLoading in ComponentState then exit;
    AlignButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetAutoWrap(newValue : Boolean);
begin
  if (FAutoWrap <> newValue) then
  begin
    FAutoWrap := newValue;
    if csLoading in ComponentState then exit;
    AlignButtons;
  end; {if}
end;

procedure TCustomElToolBar.UpdateButtons;
var
  i : integer;
  TB : TCustomElToolButton;
begin
  if (ComponentState * [csDestroying, csLoading, csReading] <> []) or (FButtons = nil) or (FUpdateCount > 0) or (FUpdatingButtons > 0) then exit;
  Inc(FUpdatingButtons);
  for i := 0 to FButtons.Count - 1 do // Iterate
  begin
    TB := TCustomElToolButton(FButtons[i]);
    (*
    if FLargeSize then
    begin
      if TB.FButtonType = ebtButton then
      begin
        if TB.UseArrow and (Orientation <> eboVert)
           then TB.SetBounds(TB.Left, TB.Top, FLargeBtnWidth + 14, FLargeBtnHeight)
           else TB.SetBounds(TB.Left, TB.Top, FLargeBtnWidth, FLargeBtnHeight);
      end
      else
      begin
        if (Align in [alLeft, alRight])
           then TB.SetBounds(TB.Left, TB.Top, FLargeBtnWidth, FLargeBtnHeight div DEF_SepSize)
           else TB.SetBounds(TB.Left, TB.Top, FLargeBtnWidth  div DEF_SepSize, FLargeBtnHeight);
      end;
    end
    else
    begin
      if TB.FButtonType = ebtButton then
      begin
        if TB.UseArrow and (Orientation <> eboVert)
           then TB.SetBounds(TB.Left, TB.Top, FBtnWidth + 14, FBtnHeight)
           else TB.SetBounds(TB.Left, TB.Top, FBtnWidth, FBtnHeight);
      end
      else
      begin
        if Align in [alLeft, alRight]
           then TB.SetBounds(TB.Left, TB.Top, FBtnWidth, FBtnHeight div DEF_SepSize)
           else TB.SetBounds(TB.Left, TB.Top, FBtnWidth  div DEF_SepSize, FBtnHeight);
      end;
    end;
    *)
    UpdateButton(TB);
  end; // for
  Dec(FUpdatingButtons);
end;

procedure TCustomElToolBar.AlignControls(AControl : TControl; var Rect : TRect);
begin
  if FNoReAlign then exit;
  if (FUpdatingButtons > 0) then exit;
  inherited;
  if (([csLoading, csDestroying] * ComponentState) <> []) or (csCreating in ControlState) or (FCreating) then exit;
  UpdateButtons;
  AlignButtons;
end;

procedure TCustomElToolBar.AlignButtons;
var
  i, j : integer;
  List2 : TLMDObjectList;
  Control : TControl;
  CX, CY : integer;
  FMaxX,
    FMaxY : integer;
  b, b1: boolean;
  aoffs, toffs, loffs, boffs, roffs : integer;
  MaxButtonWidth,
  MaxButtonHeight : integer;
  R: TRect;
  LTmpBtn: TElToolButton;
  LCurrValue: integer;
begin
  if not HandleAllocated then exit;
  if FNoReAlign then exit;
  if (([csLoading, csReading, csDestroying] * ComponentState) <> []) or (csCreating in ControlState) or (FCreating) or (FUpdateCount > 0) or (FUpdatingButtons > 0) then exit;
  if TopGrabHandle.Visible and TopGrabHandle.Enabled then toffs := TopGrabHandle.Size else toffs := 0;
  if LeftGrabHandle.Visible and LeftGrabHandle.Enabled then loffs := LeftGrabHandle.Size else loffs := 0;
  if RightGrabHandle.Visible and RightGrabHandle.Enabled then roffs := RightGrabHandle.Size else roffs := 0;
  if BottomGrabHandle.Visible and BottomGrabHandle.Enabled then boffs := BottomGrabHandle.Size else boffs := 0;
  aoffs := 0;
  b1 := false;
  if BorderWidth <> 0 then
  begin
    Inc(loffs, BorderWidth);
    Inc(toffs, BorderWidth);
    inc(roffs, BorderWidth);
    inc(boffs, BorderWidth);
  end;

  if BevelInner <> bvNone then
  begin
    //inc(aoffs, BevelWidth);
    Inc(loffs, BevelWidth);
    Inc(toffs, BevelWidth);
    inc(roffs, BevelWidth);
    inc(boffs, BevelWidth);
  end;
  if BevelOuter <> bvNone then
  begin
    //inc(aoffs, BevelWidth);
    Inc(loffs, BevelWidth);
    Inc(toffs, BevelWidth);
    inc(roffs, BevelWidth);
    inc(boffs, BevelWidth);
  end;

  PutMoreItemsToBar;
  Inc(FUpdatingButtons);

  // get the list of ordered controls
  List2 := TLMDObjectList.Create;
  OrderedControls(List2);

  CX := FBtnOffsHorz  + loffs;
  if FHideable and (FOrientation = eboHorz) then Inc(CX, 12);
  CY := FBtnOffsVert + toffs;
  if FHideable and (FOrientation = eboVert) then Inc(CY, 12);
  FMaxX := 0;
  FMaxY := 0;

  if FLargeSize then
    MaxButtonWidth := FLargeBtnWidth
  else
    MaxButtonWidth := FBtnWidth;

  if FLargeSize then
    MaxButtonHeight := FLargeBtnHeight
  else
    MaxButtonHeight := FBtnHeight;

  // if Orientation = eboVert then
    for i := 0 to List2.Count - 1 do // Iterate
    begin
      Control := TControl(List2[i]);
      if (Control is TCustomElToolButton) and (TCustomElToolButton(Control).ButtonType = ebtButton) and
         (not (csDestroying in ComponentState)) then
      begin
        MaxButtonWidth := Max(MaxButtonWidth, GetEffectiveButtonWidth(TCustomElToolButton(Control), Orientation = eboVert));
      end;
    end;

  for i := 0 to List2.Count - 1 do // Iterate
  begin
    Control := TControl(List2[i]);
    if (Control is TCustomElToolButton) and (TCustomElToolButton(Control).ButtonType = ebtButton) and
       (not (csDestroying in ComponentState)) then
    begin
      MaxButtonHeight := Max(MaxButtonHeight, GetEffectiveButtonHeight(TCustomElToolButton(Control)));
    end;
  end;

  for i := 0 to List2.Count - 1 do // Iterate
  begin
    Control := TControl(List2[i]);
    if Control is TCustomElToolButton then
    begin
      if TCustomElToolButton(Control).FIsMoreBtn then
        Continue;
      if TCustomElToolButton(Control).FButtonType = ebtButton then
      begin
        if TCustomElToolButton(Control).UseArrow and (Orientation <> eboVert) then
          R := Rect(Control.Left, Control.Top, Control.Left + Min(MaxButtonWidth, GetEffectiveButtonWidth(TCustomElToolButton(Control), true)), Control.Top + MaxButtonHeight)
        else
        begin
          if (Orientation = eboVert) then
            R := Rect(Control.Left, Control.Top, Control.Left + MaxButtonWidth, Control.Top + GetEffectiveButtonHeight(TCustomElToolButton(Control)))
          else
            R := Rect(Control.Left, Control.Top, Control.Left + Min(MaxButtonWidth, GetEffectiveButtonWidth(TCustomElToolButton(Control), true)), Control.Top + MaxButtonHeight);
        end;
        b1 := b1 or not EqualRect(Control.BoundsRect, R);
        Control.SetBounds(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
      end
      else
      begin
        if Orientation = eboVert then
          R := Rect(Control.Left, Control.Top, Control.Left + GetEffectiveButtonWidth(TCustomElToolButton(Control), false), Control.Top + GetEffectiveButtonHeight(TCustomElToolButton(Control)))
        else
          R := Rect(Control.Left, Control.Top, Control.Left + GetEffectiveButtonWidth(TCustomElToolButton(Control), false), Control.Top + MaxButtonHeight);
        b1 := b1 or not EqualRect(Control.BoundsRect, R);
        Control.SetBounds(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
      end;
    end;

    if FOrientation = eboHorz then
    begin
      LCurrValue := GetRealClientWidth;
      if Assigned(FShowMoreMenuBtn) then
        dec(LCurrValue, FShowMoreMenuBtn.Width);
      if Control.Visible and (((Control is TCustomElToolButton) and (Control as TCustomElToolButton).Wrap) or
          (FAutoWrap and ((not AutoSize) or (Align in [alTop, alBottom]))) or
          (FShowMoreMenu and not (csDesigning in ComponentState))) and
         ((CX + Control.Width) > LCurrValue) then
      begin
        if not FAutoWrap and FShowMoreMenu and not (csDesigning in ComponentState) then
        begin
          if (i <= List2.Count - 1) or ((CX + Control.Width) >= LCurrValue) then
          begin
            FNoReAlign := true;
            for j := List2.Count - 1 downto i do
            begin
              FMoreMenuItems.Insert(0, List2[j]);
              TControl(List2[j]).Parent := nil;
              // List2.Delete(j);
              //b := true;
            end;
            FNoReAlign := false;
//            SetMoreMenuActive(true);
            Break;
          end;
        end;
        b := FMoreMenuItems.Count > 0;
        if not b then
        begin
          CX := FBtnOffsHorz + loffs;

          if FHideable and (FOrientation = eboHorz) then Inc(CX, 12);

          Inc(CY, MaxButtonHeight + FBtnOffsVert);
        end;
      end;
      if FRightToLeft then
        R := Rect(Self.Left + self.Width - CX - Control.Width, CY, Self.Left + self.Width - CX - Control.Width + Control.Width, CY + MaxButtonHeight)
      else
        R := Rect(CX, CY, CX + Control.Width, CY + MaxButtonHeight);
      b1 := b1 or not EqualRect(Control.BoundsRect, R);
      Control.SetBounds(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
      if Control.Visible or (csDesigning in ComponentState) then
      begin
        Inc(CX, Control.Width + FBtnOffsHorz);
        FMaxX := Max(FMaxX, CX);
      end;
    end
    else
    begin
      LCurrValue := GetRealClientHeight;
      if Assigned(FShowMoreMenuBtn) then
        dec(LCurrValue, FShowMoreMenuBtn.Height);
      if (((Control is TCustomElToolButton) and (Control as TCustomElToolButton).Wrap) or
          (FAutoWrap and ((not AutoSize) or (Align in [alLeft, alRight]))) or
          (FShowMoreMenu and not (csDesigning in ComponentState))) and
         ((CY + Control.Height) > LCurrValue) then
      begin
        if not FAutoWrap and FShowMoreMenu and not (csDesigning in ComponentState) then
        begin
          if (i < List2.Count - 1) or ((CY + Control.Height) >= LCurrValue) then
          begin
            FNoReAlign := true;
            for j := List2.Count - 1 downto i do
            begin
              FMoreMenuItems.Insert(0, List2[j]);
              TControl(List2[j]).Parent := nil;
            end;
            FNoReAlign := false;
//            SetMoreMenuActive(true);
            Break;
          end;
        end;
        b := FMoreMenuItems.Count > 0;
        if not b then
        begin
          CY := FBtnOffsVert + toffs;
          if FHideable and (FOrientation = eboVert) then Inc(CY, 12);
          Inc(CX, MaxButtonWidth + FBtnOffsHorz);
        end;
      end;

      b1 := b1 or not EqualRect(Control.BoundsRect, Rect(CX, CY, CX + MaxButtonWidth, CY + Control.Height));
      Control.SetBounds(CX, CY, MaxButtonWidth, Control.Height);

      if Control.Visible or (csDesigning in ComponentState) then
      begin
        Inc(CY, Control.Height + FBtnOffsVert);
        FMaxY := Max(FMaxY, CY);
      end;
    end;
  end; // for

  if BevelKind <> bkNone then
    Inc(aoffs, 4);
  if AutoSize then
  begin
    if FOrientation = eboHorz then
    begin
      Height := Max(FMinSize, CY + MaxButtonHeight + FBtnOffsVert + {toffs + }boffs + aoffs);

      if not (Align in [alTop, alBottom]) then
      begin
        Width := Max(FMaxX - loffs, FMinSize) + loffs + roffs + aoffs;
        if FHideable and (Width = FMinSize) then Width := Width + 12;
      end;
    end
    else
    begin
      Width := Max(FMinSize, CX + MaxButtonWidth + FBtnOffsHorz + {loffs + }roffs + aoffs);

      if not (Align in [alLeft, alRight]) then
      begin
        Height := Max(FMaxY - toffs, FMinSize) + toffs + boffs + aoffs;
        if FHideable and (Height = FMinSize) then
          Height := Height + 12;
      end;
    end;
  end;
  b := FMoreMenuItems.Count > 0;
  if b then
  begin
    if not Assigned(FShowMoreMenuBtn) then
    begin
      FShowMoreMenuBtn := TElToolButton.Create(self);
      FShowMoreMenuBtn.FIsMoreBtn := True;
      FShowMoreMenuBtn.Parent := Self;
      FShowMoreMenuBtn.Glyph.Assign(FMoreGlyph);
      FShowMoreMenuBtn.ShowGlyph := True;
      FShowMoreMenuBtn.OwnerSettings := False;
    end;
      R := GetMoreBtnRect;
      FShowMoreMenuBtn.SetBounds(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
  end
  else
  begin
    if Assigned(FShowMoreMenuBtn) then
    begin
      LTmpBtn := FShowMoreMenuBtn;
      FShowMoreMenuBtn := nil;
      LTmpBtn.Destroy;
    end;
  end;
  List2.Free;
  //Repaint;
  dec(FUpdatingButtons);
  if b1 then
    Invalidate;
end;

procedure TCustomElToolBar.SetShowGlyph(newValue : Boolean);
begin
  if (FShowGlyph <> newValue) then
  begin
    FShowGlyph := newValue;
    if FUpdateCount > 0 then exit;
    if csLoading in ComponentState then exit;
    UpdateButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetShowCaption(newValue : Boolean);
begin
  if (FShowCaption <> newValue) then
  begin
    FShowCaption := newValue;
    if FUpdateCount > 0 then exit;
    if csLoading in ComponentState then exit;
    UpdateButtons;
    AlignButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetLargeSize(newValue : Boolean);
var
  i : integer;
begin
  if (FLargeSize <> newValue) then
  begin
    FLargeSize := newValue;
    if FUpdateCount > 0 then exit;
    if csLoading in ComponentState then exit;
    for i := 0 to FButtons.Count - 1 do // Iterate
    begin
      TCustomElToolButton(FButtons[i]).SwitchGlyphs(FLargeSize);
    end; // for
    UpdateButtons;
    AlignButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetLargeBtnWidth(newValue : Integer);
begin
  if (FLargeBtnWidth <> newValue) then
  begin
    FLargeBtnWidth := newValue;
    if FUpdateCount > 0 then exit;
    if csLoading in ComponentState then exit;
    if FLargeSize then
    begin
      UpdateButtons;
      AlignButtons;
    end;
  end; {if}
end;

procedure TCustomElToolBar.SetLargeBtnHeight(newValue : Integer);
begin
  if (FLargeBtnHeight <> newValue) then
  begin
    FLargeBtnHeight := newValue;
    if FUpdateCount > 0 then exit;
    if csLoading in ComponentState then exit;
    if FLargeSize then
    begin
      UpdateButtons;
      AlignButtons;
    end;
  end; {if}
end;

procedure TCustomElToolBar.SetGlyphLayout(newValue : TButtonLayout);
begin
  if (FGlyphLayout <> newValue) then
  begin
    FGlyphLayout := newValue;
    if FUpdateCount > 0 then exit;
    if csLoading in ComponentState then exit;
    UpdateButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetSpacing(newValue : Integer);
begin
  if (FSpacing <> newValue) then
  begin
    FSpacing := newValue;
    if FUpdateCount > 0 then exit;
    if csLoading in ComponentState then exit;
    UpdateButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetMargin(newValue : Integer);
begin
  if (FMargin <> newValue) then
  begin
    FMargin := newValue;
    if FUpdateCount > 0 then exit;
    if csLoading in ComponentState then exit;
    UpdateButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetFlat(newValue : Boolean);
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    if FUpdateCount > 0 then exit;
    if csLoading in ComponentState then exit;
    UpdateButtons;
  end; {if}
end;

function TCustomElToolBar.GetToolButton;
begin
  if (FButtons = nil) then
    result := nil
  else
    result := TElToolButton(FButtons[index]);
end;

function TCustomElToolBar.GetCustomToolButton(index : integer) : TCustomElToolButton;
begin
  if (FButtons = nil) then
    result := nil
  else
    result := TCustomElToolButton(FButtons[index]);
end;

procedure TCustomElToolBar.SetToolButton;
begin
  if (FButtons <> nil) then TCustomElToolButton(FButtons[index]).Assign(newValue);
end;

function TCustomElToolBar.GetButtonCount : Integer;
begin
  if (FButtons = nil) then
    result := 0
  else
    result := FButtons.Count;
end;

procedure TCustomElToolBar.Loaded;
var
  IL: TCustomImageList;
  ltm: TLMDThemeMode;
begin
  inherited;
  FFirstTimeOrdered := false;
  IL := FImages;
  FImages := nil;
  Images := IL;
  IL := FHotImages;
  FHotImages := nil;
  HotImages := IL;
  IL := FDisabledImages;
  FDisabledImages := nil;
  DisabledImages := IL;
  IL := FDownImages;
  FDownImages := nil;
  DownImages := IL;
  IL := FAlphaImages;
  FAlphaImages := nil;
  AlphaForImages := IL;
  IL := FAlphaHotImages;
  FAlphaHotImages := nil;
  AlphaForHotImages := IL;
  IL := FAlphaDisabledImages;
  FAlphaDisabledImages := nil;
  AlphaForDisabledImages := IL;
  IL := FAlphaDownImages;
  FAlphaDownImages := nil;
  AlphaForDownImages := IL;
  if UseImageList then
  begin
    if FImages <> nil then
    begin
      FUseImageList := false;
      UseImageList := true;
    end;
  end;
  if IsThemed then
    begin
      ltm := FThemeMode;
      FThemeMode := ttmNone;
      ThemeMode := ltm;
    end;
  if AutoSize then Resizable := false;
  UpdateButtons;
  AlignButtons;
end;

procedure TCustomElToolBar.CMControlListChange(var Msg : TMessage);

begin
  inherited;
  if not (boolean(Msg.LParam)) then
  AlignButtons;
end;

procedure TCustomElToolBar.CMControlChange(var Msg : TCMControlChange);

begin
  inherited;
  with Msg do
  begin
    if Inserting then
    begin
      if Control is TCustomElToolButton then
      begin
        FButtons.Add(Control);
        UpdateButtons;
      end;
      AlignButtons;
    end
    else
    begin
      if Control is TCustomElToolButton then
      begin
        FButtons.Remove(Control);
      end;
      (*
      if HandleAllocated and(not (csDestroying in ComponentState)) then
        AlignButtons;
      *)
    end;
  end;
end;

procedure TCustomElToolBar.WMSize(var Msg : TWMSize);
begin
  inherited;
  if FSaveAlign <> Align then
  begin
    if not (Align in [alClient, alNone]) then
    begin
      if Align in [alLeft, alRight] then
        Orientation := eboVert
      else
        Orientation := eboHorz;
      FSaveAlign := Align;
    end;
  end;
  if AutoWrap or AutoSize or FShowMoreMenu then
    AlignButtons;
end;

procedure TCustomElToolBar.SetAutoSize(newValue : Boolean);
begin
  if (FAutoSize <> newValue) then
  begin
    FAutoSize := newValue;

    if newValue and (ComponentState * [csReading, csLoading] = []) then
      Resizable := false;
    if (ComponentState * [csReading, csLoading] = []) then
    AlignButtons;
  end; {if}
end; {SetAutoSize}

function TCustomElToolBar.AddButton(ButtonType : TELToolButtonType) : TElToolButton;
begin
  Result := TElToolButton(GetButtonClass.Create(Self));

  Result.Parent := Self;
  Result.Left := 10000;
  Result.Top := 10000;
  Result.ButtonType := ButtonType;
  Result.FreeNotification(Self);
  Result.FButtonID := GetFreeButtonID + 1;
  Result.StyleManager := StyleManager;
  Result.StyleName := StyleName;
  UpdateButton(Result);
  {
  if UseImageList then
  begin
    Result.UseImageList := true;
    Result.Images := FImages;
    Result.HotImages := FHotImages;
    Result.DisabledImages := FDisabledImages;
    Result.DownImages := FDownImages;
    Result.Transparent := TransparentButtons;
    Result.ThinFrame := FThinButtons;
    Result.Flat := FFlat;
    Result.ImageIsAlphaBlended := ImageIsAlphaBlended;
  end;
  UpdateButtons;
  }
end;

procedure TCustomElToolBar.SetMinSize(newValue : integer);
begin
  if (FMinSize <> newValue) then
  begin
    FMinSize := newValue;
    if csLoading in ComponentState then exit;
    AlignButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetButtonColor(newValue : TColor);
begin
  if (FButtonColor <> newValue) then
  begin
    FButtonColor := newValue;
    if csLoading in ComponentState then exit;
    UpdateButtons;
  end; {if}
end;

procedure TCustomElToolBar.SetOrientation(newValue : TElBarOrientation);
begin
  if (FOrientation <> newValue) then
  begin
    FOrientation := newValue;
    if csLoading in ComponentState then exit;
    AlignButtons;
  end; {if}
end; {SetOrientation}
(*
procedure TElToolBar.SetHideable(newValue : Boolean);
begin
  if (FHideable <> newValue) then
  begin
    FHideable := newValue;
    AlignButtons;
    if FHidden then
    begin
      FHidden := false;
      SetHidden(true);
    end;
  end;  {if}
end;  {SetHideable}
*)

procedure TCustomElToolBar.Paint;
var
  R, R1, R2 : TRect;
  i: integer;
begin
  if FUpdateCount > 0 then exit;
  if Transparent and not IsThemed then
    begin
      R := Canvas.ClipRect;
      OffsetRect(R, Left, Top);
      if Assigned(Parent) then
    //      SendMessage(parent.Handle, WM_ERASEBKGND, Canvas.Handle, 0);
        RedrawWindow(Parent.Handle, @R, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);
      R := Canvas.ClipRect;
      for i := 0 to ButtonCount - 1 do
      begin
        R2 := ToolButton[i].ClientRect;
        OffsetRect(R2, ToolButton[i].Left, ToolButton[i].Top);
        if IntersectRect(R1, R2, R) then
          ToolButton[i].Paint;
      end;
    end
  else
    if not TransparentXPThemes and IsThemed then
      LMDThemeServices.DrawElement(UseThemeMode, Canvas.Handle, ttbToolBarRoot, ClientRect)
  else
    inherited;
end; {Paint}

procedure TCustomElToolBar.SetUseLargeGlyphs(newValue : Boolean);
{ Sets data member FUseLargeGlyphs to newValue. }
var
  i: integer;
begin
  if (FUseLargeGlyphs <> newValue) then
  begin
    FUseLargeGlyphs := newValue;
    if csLoading in ComponentState then exit;
    for i := 0 to FButtons.Count - 1 do // Iterate
    begin
      TCustomElToolButton(FButtons[i]).SwitchGlyphs(FLargeSize);
    end; // for
    if FLargeSize then
    begin
      UpdateButtons;
      AlignButtons;
    end;
  end; { if }
end; { SetUseLargeGlyphs }

procedure TCustomElToolBar.BeginUpdate; { public }
begin
  if (FUpdateCount = 0) and (HandleAllocated) then
  begin
    SendMessage(Handle, WM_SETREDRAW, 0, 0);
  end;
  inc(FUpdateCount);
end; { BeginUpdate }

procedure TCustomElToolBar.EndUpdate; { public }
begin
  dec(FUpdateCount);
  if FUpdateCount <= 0 then
  begin
    UpdateButtons;
    if (FUpdateCount = 0) and (HandleAllocated) then
    begin
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
      //Repaint;
    end;
    AlignButtons;
  end;
end; { EndUpdate }

procedure TCustomElToolBar.SetImages(newValue : TCustomImageList);
var
  i : integer;
  b, b1 : boolean;
begin
  if (FImages <> newValue) then
  begin
    if (FImages <> nil) and (not (csDestroying in FImages.ComponentState)) then
      FImages.RemoveFreeNotification(Self);
    b := (FImages = nil) and (newValue <> nil);
    FImages := newValue;
    if csLoading in ComponentState then exit;
    BeginUpdate;
    for i := 0 to FButtons.Count - 1 do // Iterate
    begin
      b1 := TCustomElToolButton(FButtons[i]).UseImageList;
      TCustomElToolButton(FButtons[i]).Images := FImages;
      TCustomElToolButton(FButtons[i]).UseImageList := b1;
    end;
    if FImages <> nil then FImages.FreeNotification(Self);
    if b and (not (csLoading in ComponentState)) then UseImageList := true;
    EndUpdate;
  end; { if }
end; { SetImages }

procedure TCustomElToolBar.SetAlphaImages(newValue : TCustomImageList);
var
  i : integer;
  //b,
  b1 : boolean;
begin
  if (FAlphaImages <> newValue) then
  begin
    if (FAlphaImages <> nil) and (not (csDestroying in FAlphaImages.ComponentState)) then
      FAlphaImages.RemoveFreeNotification(Self);
    // b := (FAlphaImages = nil) and (newValue <> nil);
    FAlphaImages := newValue;
    if csLoading in ComponentState then exit;
    BeginUpdate;
    for i := 0 to FButtons.Count - 1 do // Iterate
    begin
      b1 := TCustomElToolButton(FButtons[i]).UseImageList;
      TCustomElToolButton(FButtons[i]).AlphaForImages := FAlphaImages;
      TCustomElToolButton(FButtons[i]).UseImageList := b1;
    end;
    if FAlphaImages <> nil then FAlphaImages.FreeNotification(Self);
//    if b and (not (csLoading in ComponentState)) then UseImageList := true;
    EndUpdate;
  end; { if }
end; { SetAlphaImages }

procedure TCustomElToolBar.SetHotImages(newValue : TCustomImageList);
var
  I : Integer;
begin
  if (FHotImages <> newValue) then
  begin
    if (FHotImages <> nil) and (not (csDestroying in FHotImages.ComponentState)) then
      FHotImages.RemoveFreeNotification(Self);
    FHotImages := newValue;
    if csLoading in ComponentState then exit;
    for i := 0 to FButtons.Count - 1 do // Iterate
      TCustomElToolButton(FButtons[i]).HotImages := FHotImages;
    if FHotImages <> nil then FHotImages.FreeNotification(Self);
  end; { if }
end; { SetHotImages }

procedure TCustomElToolBar.SetAlphaHotImages(newValue : TCustomImageList);
var
  I : Integer;
begin
  if (FAlphaHotImages <> newValue) then
  begin
    if (FAlphaHotImages <> nil) and (not (csDestroying in FAlphaHotImages.ComponentState)) then
      FAlphaHotImages.RemoveFreeNotification(Self);
    FAlphaHotImages := newValue;
    if csLoading in ComponentState then exit;
    for i := 0 to FButtons.Count - 1 do // Iterate
      TCustomElToolButton(FButtons[i]).AlphaForHotImages := FAlphaHotImages;
    if FAlphaHotImages <> nil then FAlphaHotImages.FreeNotification(Self);
    end; { if }
end; { SetAlphaHotImages }

procedure TCustomElToolBar.SetDisabledImages(newValue : TCustomImageList);
var
  I : Integer;
begin
  if (FDisabledImages <> newValue) then
  begin
    if (FDisabledImages <> nil) and (not (csDestroying in FDisabledImages.ComponentState)) then
      FDisabledImages.RemoveFreeNotification(Self);
    FDisabledImages := newValue;
    if csLoading in ComponentState then exit;
    for i := 0 to FButtons.Count - 1 do // Iterate
    begin
      TCustomElToolButton(FButtons[i]).DisabledImages := FDisabledImages;
      TCustomElToolButton(FButtons[i]).IntEnabledChanged;
    end;
    if FDisabledImages <> nil then FDisabledImages.FreeNotification(Self);
  end; { if }
end; { SetDisabledImages }

procedure TCustomElToolBar.SetAlphaDisabledImages(newValue : TCustomImageList);
var
  I : Integer;
begin
  if (FAlphaDisabledImages <> newValue) then
  begin
    if (FAlphaDisabledImages <> nil) and (not (csDestroying in FAlphaDisabledImages.ComponentState)) then
      FAlphaDisabledImages.RemoveFreeNotification(Self);
    FAlphaDisabledImages := newValue;
    if csLoading in ComponentState then exit;
    for i := 0 to FButtons.Count - 1 do // Iterate
      TCustomElToolButton(FButtons[i]).AlphaForDisabledImages := FAlphaDisabledImages;
    if FAlphaDisabledImages <> nil then FAlphaDisabledImages.FreeNotification(Self);
  end; { if }
end; { SetAlphaDisabledImages }

procedure TCustomElToolBar.Notification(AComponent : TComponent; operation : TOperation);
 var i : integer;
begin
  inherited Notification(AComponent, operation);
  if AComponent is TCustomElToolButton then
  begin
    if (operation = opRemove) then
    begin
      if FButtons <> nil then
        FButtons.Remove(AComponent);
      if FMoreMenuItems <> nil then
      begin
        i := FMoreMenuItems.IndexOf(AComponent);
        if i >= 0 then
        begin
          FMoreMenuItems.Delete(i);
          if FMoreMenu <> nil then
            FMoreMenu.Items.Delete(i);
        end;
      end;
    end
    else
    begin
      // FButtons.Add();
    end;
  end;
  if (operation = opRemove) then
  begin
    if (AComponent = FImages) then Images := nil;
    if (AComponent = FHotImages) then HotImages := nil;
    if (AComponent = FDisabledImages) then DisabledImages := nil;
    if (AComponent = FDownImages) then DownImages := nil;
    if (AComponent = FAlphaImages) then AlphaForImages := nil;
    if (AComponent = FAlphaHotImages) then AlphaForHotImages := nil;
    if (AComponent = FAlphaDisabledImages) then AlphaForDisabledImages := nil;
    if (AComponent = FAlphaDownImages) then AlphaForDownImages := nil;
    if (AComponent = FButtonImageForm) then
    begin
      FButtonImageForm := nil;
      if not (csDestroying in ComponentState) then UpdateButtons;
    end;
    end; { if }
end; { Notification }

procedure TCustomElToolBar.SetUseImageList(newValue : Boolean);
var
  i : integer;
  B : TCustomElToolButton;
begin
  if (FUseImageList <> newValue) then
  begin
    FUseImageList := newValue;
    if csLoading in ComponentState then exit;
    if Images <> nil then
      for i := 0 to FButtons.Count - 1 do // Iterate
      begin
        B := TCustomElToolButton(FButtons[i]);
        if B.OwnerSettings then
        begin
          B.Images := FImages;
          B.HotImages := FHotImages;
          B.DisabledImages := FDisabledImages;
          B.DownImages := FDownImages;
          B.AlphaForImages := FAlphaImages;
          B.AlphaForHotImages := FAlphaHotImages;
          B.AlphaForDisabledImages := FAlphaDisabledImages;
          B.AlphaForDownImages := FAlphaDownImages;
          B.UseImageList := newValue;
        end;
      end; // for
  end; { if }
end; { SetUseImageList }

procedure TCustomElToolBar.SetTransparentButtons(newValue : Boolean);
var
  i : integer;
  B : TCustomElToolButton;
begin
  if (FTransparentButtons <> newValue) then
  begin
    FTransparentButtons := newValue;
    if csLoading in ComponentState then exit;
    for i := 0 to FButtons.Count - 1 do // Iterate
    begin
      B := TCustomElToolButton(FButtons[i]);
      if (B.OwnerSettings) then
        B.Transparent := newValue;
    end; // for
  end; { if }
end; { SetTransparentButtons }

{procedure TCustomElToolBar.SetMoreMenuActive(newValue : Boolean);
begin
  if (FMoreMenuActive <> newValue) then
  begin
    FMoreMenuActive := newValue;
    Invalidate;
  end;
end;}

procedure TCustomElToolBar.SetShowMoreMenu(newValue : Boolean);
{ Sets data member FShowMoreMenu to newValue. }
begin
  if (FShowMoreMenu <> newValue) then
  begin
     FShowMoreMenu := newValue;
    if HandleAllocated and (not (csLoading in ComponentState)) then
      Invalidate;
  end;  { if }
end;  { SetShowMoreMenu }

procedure TCustomElToolBar.WMNCPaint(var Msg : TWMNCPaint);  { private }
{var DC : HDC;

    procedure DrawMoreBtn(DC : HDC);
    var RC, RC1 : TRect;
        Canvas : TCanvas;
    begin
      RC := GetMoreBtnRect;
      Canvas := TCanvas.Create;
      Canvas.Handle := DC;
      Canvas.Brush.Color := Color;
      Canvas.FillRect(rc);
      DrawButtonFrameEx3(DC, rc, false, FMoreMenuVisible, Color, false, [ebsLeft, ebsRight, ebsTop, ebsBottom]);
      LMDCenterRects(9, RC.Right - RC.Left, 5, RC.Bottom - RC.Top, RC1);
      if Orientation = eboHorz then
      begin
        OffsetRect(RC1, RC.Left, 0);
        RC1.Top := RC.Top + 3;
      end
      else
      begin
        OffsetRect(RC1, 0, RC.Top);
        RC1.Left := RC.Left + 3;
      end;

      DrawTransparentBitmapEx(DC, FMoreGlyph, RC1.Left, RC1.Top, Rect(0, 0, 9, 5), FMoreGlyph.Canvas.Pixels[0, FMoreGlyph.Height - 1]);
      Canvas.Handle := 0;
      Canvas.Free;
    end;}
begin
  inherited;
{  if (FShowMoreMenu and FMoreMenuActive) and (not (csDesigning in ComponentState)) then
  begin
    DC := GetDCEx(Handle, Msg.RGN, DCX_WINDOW or DCX_INTERSECTRGN);
    if DC <> 0 then
       DrawMoreBtn(DC)
    else
    begin
      DC := GetWindowDC(Handle);
      DrawMoreBtn(DC);
    end;
    ReleaseDC(Handle, DC);
  end;
  Msg.Result := 0;}
end;  { WMNCPaint }

procedure TCustomElToolBar.WMNCHitTest(var Msg : TWMNCHitTest);  { private }
var rc : TRect;
    pt : TPoint;
begin
  inherited;
  if (FShowMoreMenu and (FMoreMenuItems.Count > 0)) then
  begin
    RC := GetMoreBtnRect;
    pt.x := Msg.XPos;
    pt.y := Msg.YPos;
    pt := ScreenToClient(pt);
    if PtInRect(rc, pt) then
    begin
      {if FIgnoreMoreClick then
      begin
        FIgnoreMoreClick := false;
        Msg.Result := HTNOWHERE;
      end
      else }
        Msg.result := HTBORDER;
    end;
  end;
end;  { WMNCHitTest }

procedure TCustomElToolBar.OnMoreItemClick(Sender : TObject);
var
  LBtn: TElToolButton;
begin
  if (Sender is TElMenuItem) and (TElMenuItem(Sender).Tag >= 0) then
  begin
     LBtn := TElToolButton(FMoreMenuItems[TElMenuItem(Sender).Tag]);
     if Assigned(LBtn) then
       LBtn.Click;
  end;
  FMoreMenuVisible := False;
  RedrawMoreBtn;
end;

procedure TCustomElToolBar.PutMoreItemsToBar;
begin
  if FNoRealign then exit;
  FNoReAlign := true;
  while FMoreMenuItems.Count > 0 do
  begin
    if TControl(FMoreMenuItems[0]) is TCustomElToolButton then
      FButtons.Add(TControl(FMoreMenuItems[0]));
    TControl(FMoreMenuItems[0]).Parent := Self;
    FMoreMenuItems.Delete(0);
  end;
  FNoReAlign := false;
end;

procedure TCustomElToolBar.SetMoreMenuDrawStyle(Value: TDrawStyle);
begin
  if FMoreMenuDrawStyle <> value then
  begin
    FMoreMenuDrawStyle := Value;
    if Assigned(FMoreMenu) then
      FMoreMenu.DrawStyle := Value;
  end;
end;

procedure TCustomElToolBar.StartMoreMenu;
  procedure CopyItems(Source: TMenuItem; Dest: TElMenuItem; SourceMnu: TPopupMenu);
  var
    i: integer;
    LItem, AItem: TElMenuItem;
    BItem: TMenuItem;
  begin
    if Source is TElMenuItem then
    begin
      for i := 0 to TElMenuItem(Source).Count - 1 do
      begin
        AItem := TElMenuItem(Source).Items[i];
        LItem := TElMenuItem.Create(AItem.Owner);
        LItem.Assign(AItem);
        if (AItem.ImageIndex > -1) and Assigned(TElPopupMenu(SourceMnu).Images) then
        begin
          FMoremenuItemsImageList.AddImage(TElPopupMenu(SourceMnu).Images, AItem.ImageIndex);
          LItem.ImageIndex := FMoremenuItemsImageList.Count - 1;
        end;
        Dest.Add(LItem);
        if AItem.Count > 0 then
          CopyItems(AItem, LItem, SourceMnu);
      end;
    end
    else
    begin
      for i := 0 to Source.Count - 1 do
      begin
        BItem := Source.Items[i];
        LItem := TElMenuItem.Create(BItem.Owner);
        LItem.Action := BItem.Action;
        LItem.Bitmap := BItem.Bitmap;
        LItem.Caption := BItem.Caption;
        LItem.Checked := BItem.Checked;
        LItem.Default := BItem.Default;
        LItem.Enabled := BItem.Enabled;
        LItem.GroupIndex := BItem.GroupIndex;
        LItem.Hint := BItem.Hint;
        LItem.Tag := BItem.Tag;
        LItem.RadioItem := BItem.RadioItem;
        LItem.ShortCut := BItem.Shortcut;
        LItem.Visible := BItem.Visible;
        LItem.OnClick := BItem.OnClick;
        LItem.OnDrawItem := BItem.OnDrawItem;
        LItem.OnMeasureItem := BItem.OnMeasureItem;
        LItem.HelpContext := BItem.HelpContext;
        LItem.AutoLineReduction := BItem.AutoLineReduction;
        LItem.AutoCheck := BItem.AutoCheck;
        LItem.AutoHotkeys := BItem.AutoHotkeys;
        if (BItem.ImageIndex > -1) and Assigned(SourceMnu.Images) then
        begin
          FMoremenuItemsImageList.AddImage(SourceMnu.Images, BItem.ImageIndex);
          LItem.ImageIndex := FMoremenuItemsImageList.Count - 1;
        end;
        Dest.Add(LItem);
        if BItem.Count > 0 then
          CopyItems(BItem, LItem, SourceMnu);
      end;
    end;
  end;

var i, j : integer;
    Item : TElMenuItem;
    pt   : TPoint;
    rc   : TRect;
    LTmpBtn: TCustomElToolButton;
    LMenuCaption: TLMDString;
    LPng: TLMDPngObject;
begin
  if FMoreMenuVisible and not Assigned(FMoreMenu) then
    exit;
  if FMoreMenu = nil then
  begin
    FMoreMenu := TElPopupMenu.Create(nil);
    FMoreMenu.UseXPThemes := UseXPThemes;
    FMoreMenu.TrackButton := tbLeftButton;
    FMoreMenu.Images := FMoremenuItemsImageList;
    FMoreMenu.HotImages := HotImages;
    FMoreMenu.RightToLeft := RightToLeft;
    FMoreMenu.DrawStyle := FMoreMenuDrawStyle;
  end;

  FMoreMenu.Items.Clear;
  FMoremenuItemsImageList.Clear;

  j := FMoreMenuItems.Count - 1;
  for i := 0 to j do
  begin
    if not (TObject(FMoreMenuItems[i]) is TCustomElToolButton) then
      continue;
    LTmpBtn := TCustomElToolButton(FMoreMenuItems[i]);
    if LTmpBtn.FButtonType = ebtButton then
    begin
       if LTmpBtn.Caption <> '' then
         LMenuCaption := LTmpBtn.Caption
       else
         LMenuCaption := LTmpBtn.Hint;

       Item := ElNewItem(LMenuCaption, 0, false, true, OnMoreItemClick, 0, '', TElMenuItem);
       Item.Tag := i;
       if Assigned(Images) and (LTmpBtn.ImageIndex > -1) then
       begin
         FMoremenuItemsImageList.AddImage(Images, LTmpBtn.ImageIndex);
         Item.ImageIndex := FMoremenuItemsImageList.Count - 1;
       end
       else
         if Assigned(LTmpBtn.Glyph) and not LTmpBtn.Glyph.Empty then
         begin
           FMoremenuItemsImageList.AddMasked(LTmpBtn.Glyph, LTmpBtn.Glyph.Canvas.Pixels[0,0]);
           Item.ImageIndex := FMoremenuItemsImageList.Count - 1;
         end
         else
           if LTmpBtn.UsePng and Assigned(LTmpBtn.PngGlyph) and not LTmpBtn.PngGlyph.Empty then
           begin
             LPng := TLMDPNGObject.Create;
             LPng.Assign(LTmpBtn.PngGlyph);
             FMoremenuItemsImageList.AddPng(LPng);
             Item.ImageIndex := FMoremenuItemsImageList.Count - 1;
           end;
       FMoreMenu.Items.Add(Item);
       if Assigned(LTmpBtn.PullDownMenu) then
         CopyItems(LTmpBtn.PullDownMenu.Items, Item, LTmpBtn.PullDownMenu);
       Item.Enabled := LTmpBtn.Enabled;
    end
    else
    begin
      Item := ElNewItem('-', 0, false, false, nil, 0, '', TElMenuItem);
      FMoreMenu.Items.Add(Item);
    end;
  end;
//  FMoreMenu.PopupComponent := Self;
  if Orientation = eboHorz then
  begin
    RC := GetMoreBtnRect;
    pt.x := Rc.Right;
    pt.y := Rc.Bottom;
    pt := ClientToScreen(pt);
    FMoreMenuVisible := true;
    OffsetRect(rc, -(Parent.ClientOrigin.X - ClientOrigin.X), - (Parent.ClientOrigin.X - ClientOrigin.X));
    RedrawWindow(Handle, @rc, 0, RDW_FRAME or RDW_INVALIDATE or RDW_NOERASE);
    dec(pt.X, GetSystemMetrics(SM_CXHSCROLL));
    FMoreMenu.Popup(pt.X, pt.Y);
    //TrackPopupMenu(FMoreMenu.Handle, TPM_RIGHTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON, pt.X, pt.Y, 0, Handle, nil);
  end else
  begin
    RC := GetMoreBtnRect;
    pt.x := Rc.Right;
    pt.y := Rc.Top;
    pt := ClientToScreen(pt);
    FMoreMenuVisible := true;
    OffsetRect(rc, -(Parent.ClientOrigin.X - ClientOrigin.X), - (Parent.ClientOrigin.X - ClientOrigin.X));
    RedrawWindow(Handle, @rc, 0, RDW_FRAME or RDW_INVALIDATE or RDW_NOERASE);
    dec(pt.Y, GetSystemMetrics(SM_CYHSCROLL));
    FMoreMenu.Popup(pt.X, pt.Y);
//    TrackPopupMenu(FMoreMenu.Handle, TPM_LEFTALIGN or TPM_LEFTBUTTON or TPM_RIGHTBUTTON, pt.X, pt.Y, 0, Handle, nil);
  end;
end;

procedure TCustomElToolBar.WMNCLButtonDown(var Msg : TWMNCLButtonDown);  { private }
var pt : TPoint;
    rc : TRect;
begin
  inherited;
  if FShowMoreMenu and (FMoreMenuItems.Count > 0) then
  begin
    rc := Self.GetMoreBtnRect;
    pt.x := Msg.XCursor;
    pt.y := Msg.YCursor;
    pt := ScreenToClient(pt);
    if PtInRect(rc, pt) and (not (csDesigning in ComponentState)) then
    begin
      StartMoreMenu;
    end;
  end;
end;  { WMNCLButtonDown }

{$WARNINGS OFF}
{$WARNINGS ON}

procedure TCustomElToolBar.RedrawMoreBtn;  { protected }
var rc : TRect;
begin
  RC := GetMoreBtnRect;
  OffsetRect(rc, -(Parent.ClientOrigin.X - ClientOrigin.X), - (Parent.ClientOrigin.X - ClientOrigin.X));
  RedrawWindow(Handle, @rc, 0, RDW_FRAME or RDW_INVALIDATE or RDW_NOERASE);
end;  { RedrawMoreBtn }

function TCustomElToolBar.GetRealClientWidth : integer;
var R : TRect;
begin
  R := ClientRect;
  AdjustClientRect(R);
  result := R.Right - R.Left;
end;

function TCustomElToolBar.GetRealClientHeight : integer;
var R : TRect;
begin
  R := ClientRect;
  AdjustClientRect(R);
  result := R.Bottom - R.Top;
end;

function TCustomElToolBar.GetMoreBtnRect : TRect;  { protected }
var rc : TRect;
    HT,
    VT : integer;
begin
  if Orientation = eboHorz then
  begin
    //HT := GetSystemMetrics(SM_CXHSCROLL);
    HT := BtnWidth;
    if FRightToLeft then
    begin
      RC.Left := 0;
      RC.Right := RC.Left + HT;
    end
    else
    begin
      RC.Left := Width - (Parent.ClientOrigin.X - ClientOrigin.X) - HT;
      RC.Right := RC.Left + HT;
    end;
    RC.Top := 0;
    RC.Bottom := RC.Top + ClientHeight;
{   RC.Top := Parent.ClientOrigin.Y - ClientOrigin.Y;
    RC.Bottom := RC.Top + ClientHeight;
    }
  end
  else
  begin
    VT := GetSystemMetrics(SM_CYVSCROLL);
    RC.Top := Height - (Parent.ClientOrigin.Y - ClientOrigin.Y) - VT;
    RC.Bottom := RC.Top + VT;
//    RC.Left := Parent.ClientOrigin.X - ClientOrigin.X;
//    RC.Right := RC.Left + ClientWidth;
    RC.Left := 0;
    RC.Right := RC.Left + ClientWidth;
  end;
  result := rc;
end;  { GetMoreBtnRect }

procedure TCustomElToolBar.WMWindowPosChanged(var Msg : TWMWindowPosChanged);  { private }
begin
  inherited;
end;  { WMWindowPosChanged }

(*
procedure TElToolBar.SetHidden(newValue : Boolean);
begin
  if (FHidden <> newValue) then
  begin
    FHidden := newValue;
    if FHideable then
    begin
      if FHidden then
      begin
        if Orientation = eboHorz then
        begin
          FSaveSize := Height;
          Height := FBtnOffsVert;
        end else
        begin
          FSaveSize := Width;
          Width := FBtnOffsHorz;
        end;
      end else
      begin
        if Orientation = eboHorz then Height := FSaveSize else Width := FSaveSize;
      end;
    end;
  end;  {if}
end;  {SetHidden}
*)

destructor TCustomElToolBar.Destroy;
begin
  if Assigned(FShowMoreMenuBtn) then
    FShowMoreMenuBtn.Free;
  FMoremenuItemsImageList.Free;
  FButtons.Free;
  FButtons := nil;
  if FMoreMenu <> nil then
     FMoreMenu.Free;
  FMoreMenu := nil;
  FMoreMenuItems.Free;
  FMoreMenuItems := nil;
  inherited Destroy;
end;

constructor TCustomElToolBar.Create(AOwner : TComponent);
begin
  BeginCreate;
  FCreating := true;
  FButtons := TLMDObjectList.Create;
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption];
  FCreating := false;
  FBtnWidth := 24;
  FBtnHeight := 24;
  FBtnOffsHorz := 3;
  FBtnOffsVert := 3;
  FShowGlyph := True;
  FShowCaption := False;
  FShowBorder := true;
  FLargeSize := False;
  FLargeBtnWidth := 48;
  FLargeBtnHeight := 48;
  FGlyphLayout := blGlyphLeft;
  FSpacing := 4;
  FMargin := -1;
  FFlat := True;
  Height := 28;
  FAutoSize := True;
  FMinSize := 24;
  FButtonColor := clBtnFace;
  FOrientation := eboHorz;
  TabStop := false;
  FSaveAlign := alTop;
  Align := alTop;
  FHidden := False;
  FAdjustButtonWidth := true;
  FAdjustButtonHeight := true;
  FSortByTag := false;
  FloatingDockSiteClass :=  TToolDockForm;
  FMoreMenuItems := TLMDObjectList.Create;
  FMoremenuItemsImageList := TLMDPngImageList.Create(nil);
  EndCreate;
end;

procedure TCustomElToolBar.SetThinButtons(Value: Boolean);
var
  i : integer;
  B : TCustomElToolButton;
begin
  if FThinButtons <> Value then
  begin
    FThinButtons := Value;
    if csLoading in ComponentState then exit;
    for i := 0 to FButtons.Count - 1 do // Iterate
    begin
      B := TCustomElToolButton(FButtons[i]);
      B.ThinFrame := Value;
    end; // for
  end;
end;

procedure TCustomElToolBar.ReadImageIsAlphaBlended(Reader : TReader);
begin
  Reader.ReadBoolean;
end;

procedure TCustomElToolBar.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ImageIsAlphaBlended', ReadImageIsAlphaBlended, nil, false);
end;

procedure TCustomElToolBar.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
//var
//  R: TRect;
begin
//  if IsThemed then
//  begin
//    if (not FTransparent) and (not TransparentXPThemes) then
//      DrawThemeBackground(Theme, Msg.DC, 0, 1, ClientRect, nil)
//    else
//    begin
//      R := ClientRect;
//      DrawThemeParentBackground(Handle, Msg.DC, @R);
//    end;
//  end
//  else
//  begin
//    if not Transparent then
//      inherited;
//  end;
  inherited;
  Msg.Result := 1;
end;

function TCustomElToolBar.GetFreeButtonID: Integer;
begin
  result := 0;
  while GetButtonByID(result) <> nil do
    Inc(Result);
end;

function TCustomElToolBar.GetButtonByID(ID : Integer): TElToolButton;
var i : integer;
begin
  i := 0;
  while i < FButtons.Count do
    if TCustomElToolButton(FButtons[i]).FButtonID = ID then
    begin
      Result := TElToolButton(FButtons[i]);
      exit;
    end
    else
      inc(i);
  Result := nil;
end;

procedure TCustomElToolBar.Save;
var
  SaveKey : string;
  i : integer;
  VisibleNames,
  HiddenNames   : string;
  AControl      : TControl;
  ControlName   : string;
  DividerCount,
  SeparatorCount: integer;
  List          : TLMDObjectList;
begin
  if Assigned(FStorage) then
  begin
    SaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(StoragePath + FStorage.Delimiter + 'Toolbar', true) then
    begin
      VisibleNames   := '';
      HiddenNames    := '';
      DividerCount   := 0;
      SeparatorCount := 0;
      FStorage.WriteBool('', 'LargeIcons', Self.LargeSize);
      FStorage.WriteBool('', 'ShowCaption', Self.ShowCaption);
      List := TLMDObjectList.Create;
      OrderedControls(List);

      for i := 0 to List.Count - 1 do
      begin
        AControl := TControl(List[i]);
        ControlName := AControl.Name;
        if AControl.Name = '' then
        begin
          if AControl is TCustomElToolButton then
          begin
            case TCustomElToolButton(AControl).ButtonType of
              ebtButton:
                Continue;
              ebtSeparator:
                begin
                  while FindComponent('Separator' + IntToStr(SeparatorCount)) <> nil do
                    inc(SeparatorCount);
                  ControlName := 'Separator' + IntToStr(SeparatorCount);
                  Inc(SeparatorCount);
                end;
              ebtDivider:
                begin
                  while FindComponent('Divider' + IntToStr(DividerCount)) <> nil do
                    inc(DividerCount);
                  ControlName := 'Divider' + IntToStr(DividerCount);
                  Inc(DividerCount);
                end;
            end;
          end
          else
            Continue;
        end;
        if ((AControl is TCustomElToolButton) and TCustomElToolButton(AControl).FRealVisible) or AControl.Visible then
        begin
          if VisibleNames = '' then
            VisibleNames := ControlName
          else
            VisibleNames := VisibleNames + ',' + ControlName;
        end
        else
        begin
          if HiddenNames = '' then
            HiddenNames := ControlName
          else
            HiddenNames := HiddenNames + ',' + ControlName;
        end;
      end;
      List.Free;
      FStorage.WriteString('', 'Visible', VisibleNames);
      FStorage.WriteString('', 'Hidden', HiddenNames);
    end;
  end;
end;

procedure TCustomElToolBar.Restore;
var
  SaveKey,
  S : string;
  i : integer;
  b : boolean;
  VisibleNames,
  HiddenNames   : TStringList;
  Parser        : TElStringTokenizer;
  AControl      : TControl;

  function ControlByName(Name : string) : TControl;
  var i : integer;
  begin
    for i := 0 to ControlCount - 1 do
    begin
      if Controls[i].Name = Name then
      begin
        result := Controls[i];
        exit;
      end;
    end;
    result := nil;
  end;

begin
  if Assigned(FStorage) then
  begin
    SaveKey := FStorage.CurrentKey;
    if FStorage.OpenKey(StoragePath + FStorage.Delimiter + 'Toolbar', false) then
    begin
      BeginUpdate;
      Parser := TElStringTokenizer.Create;
      Parser.Delimiters := ',';

      if FStorage.ReadBool('', 'LargeIcons', LargeSize, b) then
        LargeSize := b;
      if FStorage.ReadBool('', 'ShowCaption', ShowCaption, b) then
        ShowCaption := b;

      VisibleNames := TStringList.Create;
      HiddenNames  := TStringList.Create;

      FStorage.ReadString('', 'Visible', '', S);
      Parser.SourceString := S;
      Parser.FindAll(VisibleNames);

      FStorage.ReadString('', 'Hidden', '', S);
      Parser.SourceString := S;
      Parser.FindAll(HiddenNames);

      // first show/hide controls
      for i := 0 to ControlCount - 1 do // Iterate
      begin
        AControl := Controls[i];
        if AControl.Name = '' then
        begin
          if AControl is TCustomElToolButton then
          begin
            if TCustomElToolButton(AControl).ButtonType = ebtButton then
            begin
              TCustomElToolButton(AControl).Visible := false;
              TCustomElToolButton(AControl).FRealVisible := false;
            end
            else
              TCustomElToolButton(AControl).Free;
          end;
        end
        else
        begin
          if AControl is TCustomElToolButton then
          begin
            if VisibleNames.IndexOf(AControl.Name) <> -1 then
            begin
              TCustomElToolButton(AControl).Visible := (not (TCustomElToolButton(AControl).Action is TAction)) or ((TCustomElToolButton(AControl) <> nil) and (TAction(TCustomElToolButton(AControl).Action).Visible));
              TCustomElToolButton(AControl).FRealVisible := true;
            end
            else
            begin
              TCustomElToolButton(AControl).FRealVisible := false;
              TCustomElToolButton(AControl).Visible := false;
            end;
          end;
        end;
      end; // for

      // now reorder controls and add dividers/separators
      for i := 0 to VisibleNames.Count - 1 do
      begin
        AControl := ControlByName(VisibleNames[i]);
        if AControl = nil then
        begin
          // this might be a divider or separator
          if Pos('Divider', VisibleNames[i]) = 1 then
            AControl := AddButton(ebtDivider)
          else
          if Pos('Separator', VisibleNames[i]) = 1 then
            AControl := AddButton(ebtSeparator)
          else
            Continue;
        end;
        AControl.Left := 10000 + i;
        AControl.Top := 10000 + i;
      end;

      EndUpdate;
      Parser.Free;
      VisibleNames.Free;
      HiddenNames.Free;
      FStorage.OpenKey(SaveKey, false);
    end;
  end;
end;

{$ifndef LMDDISABLE_ELTOOLBAR_SETUP}
function TCustomElToolBar.Setup(ShowTextOptions, ShowIconOptions : boolean): Boolean;
var
  PropInfo   : PPropInfo;
  i          : integer;
begin
  result := false;
  with TfrmToolbarSetup.Create(nil) do
  begin
    try
      LoadToolbarControls(Self);

      IconOptionsLabel.Visible := ShowIconOptions;
      IconOptionsCombo.Visible := ShowIconOptions;
      TextOptionsLabel.Visible := ShowTextOptions;
      TextOptionsCombo.Visible := ShowTextOptions;

      for i := 0 to ComponentCount - 1 do
      begin
        PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleManager');
        if PropInfo <> nil then
          SetObjectProp(Components[i], PropInfo, Self.StyleManager);
        PropInfo := TypInfo.GetPropInfo(Components[i], 'StyleName');
        if PropInfo <> nil then
          SetStrProp(Components[i], PropInfo, Self.StyleName);
      end;

      if ShowModal = mrOk then
      begin
        SaveToolbarControls(Self);
        Result := true;
        AlignButtons;
      end;
    finally
      Free;
    end;
  end;
end;
{$endif}
procedure TCustomElToolBar.OrderedControls(L : TLMDObjectList);
const
  TmpArray : array[boolean, boolean] of integer = ((0, 1), (1, 0));
var
  np       : integer;
  CC1,
  CC2      : TControl;
  List1    : TLMDObjectList;
  i        : integer;
  b        : boolean;
begin
  List1 := TLMDObjectList.Create;
  // first arrange all controls in the proper order
  for i := 0 to ControlCount - 1 do // Iterate
    List1.Add(Controls[i]);
  while List1.Count > 0 do
  begin
    np := L.Count;
    if L.Count = 0 then
    begin
      L.Add(List1[0]);
      List1.Delete(0);
    end
    else
    begin
      CC1 := TControl(List1[0]);
      CC2 := TControl(L[np - 1]);
      if Orientation = eboHorz then
        if TmpArray[FRightToLeft, FFirstTimeOrdered] = 1 then
          b := (CC1.Top < CC2.Top) or ((CC1.Top = CC2.Top) and (CC1.Left > CC2.Left))
        else
          b := (CC1.Top < CC2.Top) or ((CC1.Top = CC2.Top) and (CC1.Left < CC2.Left))
      else
        b := (CC1.Left < CC2.Left) or ((CC1.Left = CC2.Left) and (CC1.Top < CC2.Top));
      if FSortByTag then
        b := CC1.Tag < CC2.Tag;
      while b do
      begin
        dec(np);
        if NP = 0 then break;
        CC2 := TControl(L[np - 1]);
        if Orientation = eboHorz then
          b := (CC1.Top < CC2.Top) or ((CC1.Top = CC2.Top) and (CC1.Left < CC2.Left))
        else
          b := (CC1.Left < CC2.Left) or ((CC1.Left = CC2.Left) and (CC1.Top < CC2.Top));
        if FSortByTag then
          b := CC1.Tag < CC2.Tag;
      end;
      L.Insert(np, CC1);
      List1.Delete(0);
    end;
  end;
  List1.Free;
  FFirstTimeOrdered := False;
end;

procedure TCustomElToolBar.SetAdjustButtonWidth(Value: Boolean);
begin
  if FAdjustButtonWidth <> Value then
  begin
    FAdjustButtonWidth := Value;
    if csLoading in ComponentState then exit;
    AlignButtons;
  end;
end;

function TCustomElToolBar.GetEffectiveButtonWidth(Button : TCustomElToolButton;
    IncludeArrow : boolean): Integer;
begin
  if Button.ButtonType = ebtButton then
  begin
    if AdjustButtonWidth then
    begin
      if Self.LargeSize then
        result := LargeBtnWidth
      else
        result := BtnWidth;
      result := Max(result, Button.MeasureButton(true).x + 4);
    end
    else
    begin
      if Self.LargeSize then
        result := LargeBtnWidth
      else
        result := BtnWidth;
    end;
    //if IncludeArrow and Button.UseArrow then
    //    inc(Result, Button.GetArrowSize);
  end
  else
  begin
    if Self.LargeSize then
      result := LargeBtnWidth div DEF_SepSize
    else
      result := BtnWidth div DEF_SepSize;
  end;
end;

procedure TCustomElToolBar.SetAdjustButtonHeight(Value: Boolean);
begin
  if FAdjustButtonHeight <> Value then
  begin
    FAdjustButtonHeight := Value;
    if csLoading in ComponentState then exit;
    AlignButtons;
  end;
end;

function TCustomElToolBar.GetEffectiveButtonHeight(Button : TCustomElToolButton):
    Integer;
begin
  if Button.ButtonType = ebtButton then
  begin
    if AdjustButtonHeight then
    begin
      if Self.LargeSize then
        result := LargeBtnHeight
      else
        result := BtnHeight;
      result := Max(result, Button.MeasureButton(false).y);
    end
    else
    begin
      if Self.LargeSize then
        result := LargeBtnHeight
      else
        result := BtnHeight;
    end;
  end
  else
  begin
    if Self.LargeSize then
      result := LargeBtnHeight div DEF_SepSize
    else
      result := BtnHeight div DEF_SepSize;
  end;
end;

type
  TTrackMouseEventProc = function (tme : PTrackMouseEvent) : bool; stdcall;

procedure TCustomElToolBar.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseInControl := true;
  StartLeaveTracking;
end;

procedure TCustomElToolBar.WMMouseLeave(var Message: TMessage);
var i : integer;
begin
  inherited;
  for i := 0 to ControlCount - 1 do
  begin
    if Controls[i] is TCustomElGraphicButton then
    begin
      with TCustomElGraphicButton(Controls[i]) do
        if MouseInControl or MouseInArrow then
       Perform(CM_MOUSELEAVE, 0, 0);
    end;
  end;
  MouseOut;
end;

procedure TCustomElToolBar.CMMouseLeave(var Message: TMessage);
begin
  if (Message.LParam = 0) or (Message.LParam = TLMDPtrInt(Self)) then
    MouseOut;
  inherited;
end;

procedure TCustomElToolBar.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  if not FMouseInControl then
  begin
    FMouseInControl := true;
    StartLeaveTracking;
  end;
end;

procedure TCustomElToolBar.StartLeaveTracking;
var
  TME : TTrackMouseEvent;
  Module : HModule;
  TrackMouseEvent: TTrackMouseEventProc;
  begin
  if LMDSIWindows98 or LMDSIWindowsNTUp then
  begin
    Module := GetModuleHandle('user32.dll');
    if Module <> 0 then
    begin
      TrackMouseEvent := GetProcAddress(Module, 'TrackMouseEvent');
      if @TrackMouseEvent <> nil then
      begin
        TME.cbSize := sizeof(TME);
        TME.dwFlags := TME_LEAVE;
        TME.hwndTrack := Handle;
        TME.dwHoverTime := 0;
        TrackMouseEvent(@tme);
        end;
    end;
  end;
end;

function TCustomElToolBar.GetButtonClass: TElToolButtonClass;
begin
  Result := TElToolButton;
end;

procedure TCustomElToolBar.SetFocusedButton(Value: TElToolButton);
begin
  if FFocusedButton <> Value then
  begin
    FFocusedButton := Value;
  end;
end;

procedure TCustomElToolBar.CMEnabledChanged(var Msg : TMessage);
var
  i : integer;
begin
  inherited;
  for i := 0 to FButtons.Count - 1 do
  begin
    TCustomElToolButton(FButtons[i]).IntEnabledChanged;
    TCustomElToolButton(FButtons[i]).Invalidate;
  end;
end;  { CMEnabledChanged }

procedure TCustomElToolBar.SetTransparent(newValue : Boolean);
{ Sets data member FTransparent to newValue. }
begin
  if not IsThemed then
    inherited
  else
  begin
    // FTransparent := newValue;
    TransparentXPThemes := true;
    RecreateWnd;
    end;
end; { SetTransparent }

procedure TCustomElToolBar.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    inherited;
    if ThemeServices.ThemesAvailable then
    begin
      if (not Value) and Transparent then
      begin
        FTransparent := false;
        Transparent := true;
      end
      else
      if (Value and Transparent) then
      begin
        Transparent := false;
        FTransparent := true;
      end;
      if csLoading in ComponentState then exit;
      UpdateButtons;
    end;
  end;
end;

procedure TCustomElToolBar.SetThemeGlobalMode(const Value: Boolean);
begin
  if ThemeGlobalMode <> Value then
  begin
    inherited;
    if ThemeServices.ThemesAvailable then
    begin
      if (not Value) and Transparent then
      begin
        FTransparent := false;
        Transparent := true;
      end
      else
      if (Value and Transparent) then
      begin
        Transparent := false;
        FTransparent := true;
      end;
      if csLoading in ComponentState then exit;
      UpdateButtons;
    end;
  end;
end;

procedure TCustomElToolBar.SetThemeMode(const Value: TLMDThemeMode);
begin
  if ThemeMode <> Value then
  begin
    inherited;
    if ThemeServices.ThemesAvailable then
    begin
      if (Value = ttmNone) and Transparent then
      begin
        FTransparent := false;
        Transparent := true;
      end
      else
      if ((Value <> ttmNone) and Transparent) then
      begin
        Transparent := false;
        FTransparent := true;
      end;
      if csLoading in ComponentState then exit;
      UpdateButtons;
    end;
  end;
end;

function TCustomElToolBar.GetNextButton(CurrentButton : TCustomElToolButton;
  Forward: boolean; IncludeDisabled : boolean): TCustomElToolButton;
var
  i: integer;
begin
  {$IFNDEF LMDCOMP24}Result := nil;{$ENDIF} // Initialize.

  if CurrentButton <> nil then
    i := FButtons.IndexOf(CurrentButton)
  else
    i := -1;
  if i = -1 then
  begin
    if not Forward then
      i := FButtons.Count;
  end;

  while true do
  begin
    if Forward then
    begin
      inc(i);
      if i >= FButtons.Count then
        i := 0;
    end
    else
    begin
      dec(i);
      if i < 0 then
        i := FButtons.Count - 1;
    end;
    if i >= FButtons.Count then
      result := nil
    else
      result := TCustomElToolButton(FButtons[i]);
    if result = nil then
      break;
    if (IncludeDisabled or Result.Enabled) and Result.Visible then
      break;
  end;
end;

procedure TCustomElToolBar.DoEndDock(Target: TObject; X, Y: Integer);
begin
  inherited;
  FDragObject.Free;
  FDragObject := nil;
  Resizable := FOwnResizable;
end;

procedure TCustomElToolBar.DoEnter;
var // i : integer;
    Control : TWinControl;
begin
  inherited;
  Control := FindNextControl(Self, true, true, true);
  if Control <> nil then
    Control.SetFocus;
end;

procedure TCustomElToolBar.DoStartDock(var DragObject: TDragObject);
begin
  inherited;
  FOwnResizable := Resizable;
  Resizable := True;
  FDragObject := TToolDockObject.Create(Self);
  DragObject := FDragObject;
end;

procedure TCustomElToolBar.SetParent(AParent: TWinControl);
begin
  inherited;
  if (AParent <> nil) and (AParent.ClassName = 'TCoolBar') then
    Self.AutoSize := false;
end;

procedure TCustomElToolBar.CMFontChanged(var Message: TMessage);

begin
  inherited;
  AlignButtons;
end;

procedure TCustomElToolBar.CMColorChanged(var Message: TMessage);
begin
  inherited;
  UpdateButtons;
end;

procedure TCustomElToolBar.SetImageIsAlphaBlended(Value: Boolean);
var i : integer;
begin
  if FImageIsAlphaBlended <> Value then
  begin
    FImageIsAlphaBlended := Value;
    if csLoading in ComponentState then exit;
    for i := 0 to FButtons.Count - 1 do
      TElToolButton(FButtons[i]).ImageIsAlphaBlended := Value;
  end;
end;

procedure TCustomElToolBar.SetShowBorder(Value: Boolean);
begin
  if FShowBorder <> Value then
  begin
    FShowBorder := Value;
    UpdateButtons;
  end;
end;

procedure TCustomElToolBar.SetDownImages(newValue : TCustomImageList);
var
  I : Integer;
begin
  if (FDownImages <> newValue) then
  begin
    if (FDownImages <> nil) and (not (csDestroying in FDownImages.ComponentState)) then
      FDownImages.RemoveFreeNotification(Self);
    FDownImages := newValue;
    if csLoading in ComponentState then exit;
    for i := 0 to FButtons.Count - 1 do // Iterate
      TCustomElToolButton(FButtons[i]).DownImages := FDownImages;
    if FDownImages <> nil then FDownImages.FreeNotification(Self);
  end; { if }
end; { SetDisabledImages }

procedure TCustomElToolBar.SetAlphaDownImages(newValue : TCustomImageList);
var
  I : Integer;
begin
  if (FAlphaDownImages <> newValue) then
  begin
    if (FAlphaDownImages <> nil) and (not (csDestroying in FAlphaDownImages.ComponentState)) then
      FAlphaDownImages.RemoveFreeNotification(Self);
    FAlphaDownImages := newValue;
    if csLoading in ComponentState then exit;
    for i := 0 to FButtons.Count - 1 do // Iterate
      TCustomElToolButton(FButtons[i]).AlphaForDisabledImages := FAlphaDownImages;
    if FAlphaDownImages <> nil then FAlphaDownImages.FreeNotification(Self);
  end; { if }
end; { SetAlphaDownImages }

function TElToolButtonActionLink.IsVisibleLinked: Boolean;
begin
  result := inherited IsVisibleLinked;
end;

procedure TElToolButtonActionLink.SetVisible(Value: Boolean);
var b : boolean;
begin
  inherited;
  if IsVisibleLinked then
  begin
    b := (FClient as TElToolButton).FRealVisible;
    (FClient as TElToolButton).ActionVisibleInverted := true;
    if Value and b then
      FClient.Visible := true
    else
      FClient.Visible := false;
    (FClient as TElToolButton).ActionVisibleInverted := false;
    (FClient as TElToolButton).FRealVisible := b;
  end;
end;

procedure TCustomElToolBar.UpdateButton(Button : TCustomElToolButton);
begin
  if Button.OwnerSettings then
  begin
    Button.ShowText := FShowCaption;
    Button.ShowGlyph := FShowGlyph;
    Button.ShowBorder := ShowBorder;
    Button.Layout := FGlyphLayout;
    if Button.ButtonType = ebtButton then
      Button.Flat := Self.FFlat;
    Button.Spacing := FSpacing;
    Button.Margin := FMargin;
    Button.Alignment := Alignment;
    if Button.FButtonType <> ebtSeparator then
    begin
      Button.Color := FButtonColor;
      if (Button.Color = Color) then
        TElToolButton(Button).ParentColor := True;
        end
    else
    begin
      //Button.Color := Color;
      TElToolButton(Button).ParentColor := True;
    end;
    Button.Transparent := TransparentButtons;
    Button.Images := FImages;
    Button.HotImages := FHotImages;
    Button.AlphaForImages := FAlphaImages;
    Button.AlphaForHotImages := FAlphaHotImages;
    Button.UseImageList := FUseImageList;
//    Button.SwitchGlyphs(FLargeSize);
    Button.DisabledImages := FDisabledImages;
    Button.DownImages := FDownImages;
    Button.AlphaForDisabledImages := FAlphaDisabledImages;
    Button.AlphaForDownImages := FAlphaDownImages;
    Button.ImageForm := FButtonImageForm;
    Button.ThinFrame := FThinButtons;
    Button.UseXPThemes := UseXPThemes;
    Button.ThemeMode := ThemeMode;
    Button.ThemeGlobalMode := ThemeGlobalMode;
//    Button.ImageIsAlphaBlended := ImageIsAlphaBlended;
  end;
end;

procedure TCustomElToolBar.SetResizable(newValue : Boolean);
begin
  inherited;
  if newValue and (ComponentState * [csReading, csLoading] = []) then
    AutoSize :=false;
end;

procedure TCustomElToolBar.MouseOut;
begin
  FMouseInControl := false;
end;

procedure TCustomElToolBar.ChangeScale(M, D: Integer);
begin
  inherited;
  BtnHeight := MulDiv(BtnHeight, M, D);
  BtnWidth := MulDiv(BtnWidth, M, D);
  LargeBtnWidth := MulDiv(LargeBtnWidth, M, D);
  LargeBtnHeight := MulDiv(LargeBtnHeight, M, D);
  if (M <> D) then
     Height := Height - MulDiv(BtnHeight, M-D, D);
end;

procedure TCustomElToolBar.SetRightToLeft(Value: Boolean);
begin
  if FRightToLeft <> Value then
  begin
    FRightToLeft := Value;
    FFirstTimeOrdered := True;
    AlignButtons;
  end;
end;

procedure TCustomElToolButton.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
  Msg.Result := 1;
end;

{ TElToolButton }

constructor TElToolButton.Create(AOwner: TComponent);
begin
  inherited;
  FParentThemeMode := true;
end;

initialization
  FMoreGlyph := TBitmap.Create;
  FMoreGlyph.LoadFromResourceName(HInstance, 'ELTOOLBARMOREARROW');
  finalization
  try
    FMoreGlyph.Free;
    FMoreGlyph := nil;
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElToolBar: ' + e.Message);
    end;
  end;

end.
