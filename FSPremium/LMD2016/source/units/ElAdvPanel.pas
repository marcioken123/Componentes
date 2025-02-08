unit ElAdvPanel;
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

ElAdvPanel unit
---------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils,
  Classes,
  Windows,
  Graphics,
  Controls,
  StdCtrls,
  Menus,
  ExtCtrls,
  Buttons,
  Math,
  Forms,
  ImgList,
  Types,
  Messages,
  Themes,

  ElPanel,
  ElPopBtn,
  ElVCLUtils,
  ElHTMLPanel,
  ElImgFrm,
  ElStyleMan,
  ElCheckCtl,

  LMDProcs,
  LMDDebugUnit,
  LMDThemes,
  LMDClass,
  LMDElConst,
  LMDTypes,
  LMDGlyphs,
  LMDPNGImage,
  LMDPNGImageList,
  LMDGraphUtils,
  LMDGraph;

type
  TElMinButtonPosition = (mbpLeft, mbpRight);
  TElBeforeMinimizeRestoreEvent = procedure(Sender : TObject; var Accept : boolean) of object;
  TElRestoreHeightEvent = procedure(Sender : TObject; var AHeight : integer) of object;

  TCustomElAdvancedPanel = class;
  TElAdvCaptionButton = class;
  TElAdvCaptionPanel = class;

  // TElCloseQueryEvent = procedure(Sender : TObject; var CanClose : boolean) of object;

  TElPanelCaptionSettings = class(TPersistent)
  private
    FVisible: Boolean;
    FHeight: Integer;
    FShowCloseButton: Boolean;
    FOwner: TCustomElAdvancedPanel;
    FShowMinButton: Boolean;
    FMinButtonPos : TElMinButtonPosition;
    FButtonWidth: Integer;
    FAlignment: TAlignment;
    FLayout: TTextLayout;
    FButtonColor: TColor;
    FShowCheckBox: boolean;
    FCheckBoxChecked: Boolean;
    function GetGradientEndColor: TColor;
    function GetGradientStartColor: TColor;
    function GetGradientSteps: Integer;
    procedure SetGradientEndColor(const Value: TColor);
    procedure SetGradientStartColor(const Value: TColor);
    procedure SetGradientSteps(const Value: Integer);
    function GetBackgroundType: TLMDBackgroundType;
    procedure SetBackgroundType(const Value: TLMDBackgroundType);
    procedure SetText(Value: TLMDString);
    procedure SetVisible(Value: Boolean);
    procedure SetHeight(Value: Integer);
    procedure SetShowCloseButton(Value: Boolean);
    procedure SetShowMinButton(Value: Boolean);
    procedure SetMinButtonPos(Value: TElMinButtonPosition);
    function GetText: TLMDString;
    procedure SetButtonWidth(Value: Integer);
    procedure SetAlignment(Value: TAlignment);
    procedure SetLayout(newValue: TTextLayout);
    function GetFont: TFont;
    procedure SetFont(Value: TFont);
    function GetParentFont: Boolean;
    procedure SetParentFont(Value: Boolean);
    function GetColor: TColor;
    procedure SetColor(Value: TColor);
    procedure SetButtonColor(Value: TColor);
    function GetImageForm: TElImageForm;
    procedure SetImageForm(Value: TElImageForm);
    procedure SetShowCheckBox(Value: boolean);
    procedure SetCheckBoxChecked(Value: boolean);
    function GetCheckBoxChecked: boolean;
    function GetGlyph: TBitmap;
    procedure SetGlyph(const Value: TBitmap);
    function GetBackground: TBitmap;
    procedure SetBackground(const Value: TBitmap);
    function GetCloseButtonTransparent: Boolean;
    function GetMinButtonTransparent: Boolean;
    procedure SetCloseButtonTransparent(const Value: Boolean);
    procedure SetMinButtonTransparent(const Value: Boolean);
    function GetCloseButtonPngGlyph: TLMDPngObject;
    function GetMinButtonPngGlyph: TLMDPngObject;
    procedure SetCloseButtonPngGlyph(const Value: TLMDPngObject);
    procedure SetMinButtonPngGlyph(const Value: TLMDPngObject);
  protected
    FInvertMinButtonArrows: Boolean;
    FAutoSize: Boolean;
    FFlat: Boolean;
    FFlatAlways: Boolean;
    function GetMinButtonGlyph: TBitmap;
    procedure SetMinButtonGlyph(Value: TBitmap);
    function GetCloseButtonGlyph: TBitmap;
    procedure SetCloseButtonGlyph(Value: TBitmap);
    procedure SetInvertMinButtonArrows(Value: Boolean);
    procedure SetAutoSize(Value: Boolean);
    procedure FontChanged;
    procedure AdjustHeight;
    procedure SetFlat(Value: Boolean);
    procedure SetFlatAlways(Value: Boolean);
  public
    constructor Create(Owner : TCustomElAdvancedPanel);
    procedure LoadDefaultMinButton;
    procedure Assign(Source : TPersistent); override;
  published
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property Background: TBitmap read GetBackground write SetBackground;
    property BackgroundType: TLMDBackgroundType read GetBackgroundType write SetBackgroundType default bgtColorFill;
    property Text: TLMDString read GetText write SetText;
    property Visible: Boolean read FVisible write SetVisible default true;
    property Height: Integer read FHeight write SetHeight default 19;
    property ShowCloseButton: Boolean read FShowCloseButton write SetShowCloseButton nodefault;
    property ShowMinButton: Boolean read FShowMinButton write SetShowMinButton default true;
    property MinButtonPosition: TElMinButtonPosition read FMinButtonPos write SetMinButtonPos default mbpRight;
    property FlatButtons: Boolean read FFlat write SetFlat stored False default true;
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth default 15;
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property Layout: TTextLayout read FLayout write SetLayout default tlTop;
    property Font: TFont read GetFont write SetFont;
    property ParentFont: Boolean read GetParentFont write SetParentFont default true;
    property Color: TColor read GetColor write SetColor default clBtnFace;
    property ButtonColor: TColor read FButtonColor write SetButtonColor default clBtnFace;
    property ImageForm: TElImageForm read GetImageForm write SetImageForm;
    property MinButtonGlyph: TBitmap read GetMinButtonGlyph write SetMinButtonGlyph;
    property CloseButtonGlyph: TBitmap read GetCloseButtonGlyph write SetCloseButtonGlyph;
    property MinButtonPngGlyph: TLMDPngObject read GetMinButtonPngGlyph write SetMinButtonPngGlyph;
    property CloseButtonPngGlyph: TLMDPngObject read GetCloseButtonPngGlyph write SetCloseButtonPngGlyph;
    property GradientStartColor : TColor read GetGradientStartColor write SetGradientStartColor default clBlack;
    property GradientEndColor : TColor read GetGradientEndColor write SetGradientEndColor default clBlack;
    property GradientSteps : Integer read GetGradientSteps write SetGradientSteps default 16;
    property InvertMinButtonArrows: Boolean read FInvertMinButtonArrows write SetInvertMinButtonArrows default false;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default false;
    property ShowCheckBox: boolean read FShowCheckBox write SetShowCheckBox default false;
    property CheckBoxChecked: Boolean read GetCheckBoxChecked write SetCheckBoxChecked default false;
    property Flat: Boolean read FFlat write SetFlat default true;
    property FlatAlways: Boolean read FFlatAlways write SetFlatAlways default false;
    property MinButtonTransparent: Boolean read GetMinButtonTransparent write SetMinButtonTransparent default False;
    property CloseButtonTransparent: Boolean read GetCloseButtonTransparent write SetCloseButtonTransparent default False;
  end;

  TCustomElAdvancedPanel = class(TCustomElHTMLPanel)
  protected
    FMinButtonGlyph: TBitmap;
    FImages     : TCustomImageList;
    FSaveHeight : Integer;
    FMinimized: Boolean;
    FCaptionPanel: TElHTMLPanel;
    FCaptionSettings: TElPanelCaptionSettings;
    FMinButton: TElGraphicButton;
    FCloseButton: TElGraphicButton;
    FCheckBox: TElCheckBox;
    FOnBeforeMinimize: TElBeforeMinimizeRestoreEvent;
    FOnMinimize: TNotifyEvent;
    FOnBeforeRestore: TElBeforeMinimizeRestoreEvent;
    FOnRestore: TNotifyEvent;
    FOnRestoreHeight: TElRestoreHeightEvent;
    FOnClose: TNotifyEvent;
    FOnCloseQuery: TCloseQueryEvent;
    FOnCheckBoxClick: TNotifyEvent;
    procedure SetLinkPopupMenu(newValue : TPopupMenu); override;
    procedure SetLinkColor(newValue : TColor); override;
    procedure SetLinkStyle(newValue : TFontStyles); override;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    function TriggerBeforeMinimizeEvent : boolean; virtual;
    procedure TriggerMinimizeEvent; virtual;
    function TriggerBeforeRestoreEvent : boolean; virtual;
    procedure TriggerRestoreHeightEvent; virtual;
    procedure TriggerRestoreEvent; virtual;
    procedure AdjustButtonSize; virtual;
    procedure OnCaptionSize(Sender : TObject);
    procedure OnMinButtonClick(Sender : TObject);
    procedure OnCloseButtonClick(Sender : TObject);
    procedure TriggerCloseEvent; virtual;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure CreateWnd; override;
    procedure SetCaptionSettings(Value: TElPanelCaptionSettings);
    procedure WMNCHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
    procedure LinkClickEventTransfer(Sender : TObject; HRef : TLMDString);
    procedure SetImageForm(newValue : TElImageForm); override;
    procedure DoThemeChanged; override;
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetThemeMode(const Value: TLMDThemeMode);override;
    procedure AdjustInnerSize(var R : TRect); virtual;
    function GetBevelAdjustment: Integer;
    function GetBorderAdjustment: Integer; virtual;
    procedure UpdateMinButtonImages;
    procedure Loaded; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadExpHeight(Reader : TReader);
    procedure WriteExpHeight(Writer : TWriter);
    procedure SetTransparentXPThemes(Value: Boolean); override;
    function CreateButton: TElAdvCaptionButton; virtual;
    function CreateCheckbox: TElCheckBox; virtual;
    procedure SetMinimized(Value: Boolean); virtual;
    function CreatePanel: TElAdvCaptionPanel; virtual;
//    function GetThemePartID: Integer; virtual;
    procedure UpdateInterior; override;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    //vb oct 2005
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMTabStopChanged(var Message: TMessage); message CM_TABSTOPCHANGED;

    procedure DoClick(Sender : TObject); virtual;
    procedure DoCheckBoxClick(Sender: TObject); virtual;
    function GetShowFocus: Boolean;
    procedure SetShowFocus(Value: Boolean);
    procedure DoDblClick(Sender : TObject); virtual;
    procedure TriggerCloseQueryEvent(var CanClose : boolean); virtual;
    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    property Minimized: Boolean read FMinimized write SetMinimized default false;
    property CaptionSettings: TElPanelCaptionSettings read FCaptionSettings write SetCaptionSettings;
    property OnBeforeMinimize: TElBeforeMinimizeRestoreEvent read FOnBeforeMinimize write FOnBeforeMinimize;
    property OnMinimize: TNotifyEvent read FOnMinimize write FOnMinimize;
    property OnBeforeRestore: TElBeforeMinimizeRestoreEvent read FOnBeforeRestore write FOnBeforeRestore;
    property OnRestoreHeight: TElRestoreHeightEvent read FOnRestoreHeight write FOnRestoreHeight;
    property OnRestore: TNotifyEvent read FOnRestore write FOnRestore;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnCloseQuery: TCloseQueryEvent read FOnCloseQuery write FOnCloseQuery;
    property OnCheckBoxClick: TNotifyEvent read FOnCheckBoxClick write FOnCheckBoxClick;
    property ShowFocus: Boolean read GetShowFocus write SetShowFocus default true;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure ChangeScale(M, D: Integer); override;
    function GetCaptionHeight: Integer; virtual;
    function GetButtonWidth: Integer; virtual;

    property CaptionPanel : TElHTMLPanel read FCaptionPanel;
  end;

  TElAdvancedPanel = class(TCustomElAdvancedPanel)
  published
    property OnImageNeeded;
    property OnLinkClick;
    property OnTagFound;
    property Cursor;
    property LinkColor;
    property LinkPopupMenu;
    property LinkStyle;

    property Background;
    property BackgroundType;
    property GradientEndColor;
    property GradientStartColor;
    property GradientSteps;
    property Alignment;
    property Layout;
    property ImageForm;
    property TopGrabHandle;
    property RightGrabHandle;
    property LeftGrabHandle;
    property BottomGrabHandle;

    property Resizable;
    property Movable;
    property OnMove;

    property Align nodefault;
    property BevelInner nodefault;
    property BevelOuter nodefault;
    property BevelSpaceColor nodefault;
    property BevelWidth;
    property BorderSides;
    property BorderStyle;
    property BorderWidth;
    property Color;

    property DragCursor;

    property DragMode;
    property Enabled;
    property Font;

    property Locked;
    property MouseCapture;

    property ParentColor;

    property ParentCtl3D;

    property ParentFont;
    property ParentShowHint;
    property ParentThemeMode default true;
    property PopupMenu;
    property ShowHint;
    property ShowFocus;
    property TabStop;
    property Transparent;
    property TransparentXPThemes;
    property ThemeMode;
    property ThemeGlobalMode;
    property Visible;
    property SizeGrip;

    property Caption;
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
    property OnResize;

    property Anchors;
    property Constraints;

    property DockSite;
    property DockOrientation;
    property BevelKind;
    property DoubleBuffered;
    property DragKind;

    property Minimized;
    property CaptionSettings;
    property OnMinimize;
    property OnBeforeMinimize;
    property OnBeforeRestore;
    property OnRestore;
    property OnRestoreHeight;
    property OnClose;
    property OnCloseQuery;

    property OnCheckBoxClick;
  end;

  TElAdvCaptionPanel = class(TElHTMLPanel)
  private
    FDummyInt: integer;
    FDummyBool: boolean;
    //vb oct 2005 added to fix backward tab
    FShiftState: TShiftState;
    DoResize: boolean;
    FGlyphButton: TLMDButtonGlyph;
    procedure WMNCHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
    function GetGlyph: TBitmap;
    procedure SetGlyph(const Value: TBitmap);
  protected
    procedure TriggerPaintEvent; override;
    procedure CreateWnd; override;
    procedure AdjustClientRect(var Rect: TRect); override;
    procedure SetImageForm(newValue : TElImageForm); override;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner : TComponent); override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    destructor Destroy; override;
  published
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property TabStop: boolean read FDummyBool write FDummyBool;
    property TabOrder: integer read FDummyInt write FDummyInt;
  end;

  TElAdvCaptionButton = class(TElGraphicButton)
  public
    constructor Create(AOwner : TComponent); override;
  end;

  THackCheckBox = class(TElCheckBox)
  end;

implementation

var
  CloseBmp,
  UpArrowBmp,
  DownArrowBmp : TBitmap;

const
  Margin = 1;

type
  THackGraphicButton = TElAdvCaptionButton;

procedure TElAdvCaptionPanel.CreateWnd;
begin
  inherited;
  THackGraphicButton(TCustomElAdvancedPanel(Parent).FMinButton).SetDesigning(false);
  THackGraphicButton(TCustomElAdvancedPanel(Parent).FCloseButton).SetDesigning(false);
  if Assigned(TCustomElAdvancedPanel(Parent).FCheckBox) then
    THackCheckBox(TCustomElAdvancedPanel(Parent).FCheckBox).SetDesigning(false);
end;

procedure TElAdvCaptionPanel.AdjustClientRect(var Rect : TRect);
var
  ASettings : TElPanelCaptionSettings;
begin
  inherited;
  ASettings := TCustomElAdvancedPanel(Parent).FCaptionSettings;
// not sure that it is right
//  if (ASettings.Alignment <> taCenter) then
  begin
    if ASettings.FShowMinButton then
    begin
      if ASettings.FMinButtonPos = mbpRight then
        dec(Rect.Right, Margin + TCustomElAdvancedPanel(Parent).GetButtonWidth)
      else
        inc(Rect.Left, Margin + TCustomElAdvancedPanel(Parent).GetButtonWidth)
    end;
    if ASettings.FShowCloseButton then
      dec(Rect.Right, Margin + TCustomElAdvancedPanel(Parent).GetButtonWidth);
    if ASettings.ShowCheckbox and Assigned(TCustomElAdvancedPanel(Parent).FCheckBox) then
      inc(Rect.Left, Margin + TCustomElAdvancedPanel(Parent).FCheckBox.Width);
  end;
  InflateRect(Rect, - Margin * 2, 0);
end;

procedure TElAdvCaptionPanel.WMNCHitTest(var Msg : TWMNCHitTest);
begin
  inherited;
  if TCustomElAdvancedPanel(Parent).Movable or (csDesigning in Parent.ComponentState) then
    Msg.Result := HTTRANSPARENT;
end; {WMNCHitTest}

procedure TElAdvCaptionPanel.SetImageForm(newValue : TElImageForm);
begin
  inherited;
  if Parent = nil then exit;
  if TCustomElAdvancedPanel(Parent).FCloseButton <> nil then
    TCustomElAdvancedPanel(Parent).FCloseButton.ImageForm := newValue;
  if TCustomElAdvancedPanel(Parent).FMinButton <> nil then
    TCustomElAdvancedPanel(Parent).FMinButton.ImageForm := newValue;
end;

constructor TElAdvCaptionPanel.Create(AOwner : TComponent);
begin
  inherited;
  BevelInner   := bvNone;
  BevelOuter   := bvNone;
  BorderStyle  := bsNone;
  ShowFocus    := true;
  ControlStyle := [csClickEvents, csDoubleClicks];
  FGlyphButton := TLMDButtonGlyph.Create;
end;

destructor TElAdvCaptionPanel.Destroy;
begin
  FreeAndNil(FGlyphButton);
  inherited;
end;

procedure TElAdvCaptionPanel.CMFontChanged(var Message: TMessage);

begin
  inherited;
  TElAdvancedPanel(Parent).FCaptionSettings.FontChanged;
  end;

procedure TElAdvCaptionPanel.KeyDown(var Key: Word; Shift: TShiftState);

begin
  FShiftState := Shift;
  if (Key = VK_SPACE) and (Shift = []) and
  TElAdvancedPanel(Parent).FCaptionSettings.ShowMinButton then
  begin
    TElAdvancedPanel(Parent).Minimized := not TElAdvancedPanel(Parent).Minimized;
  Key := 0;
  end;
  inherited;
end;

type THackForm = class(TForm);

procedure TElAdvCaptionPanel.WMKillFocus(var Message: TWMKillFocus);
var
  CurControl: TWinControl;
  fwd: boolean;
begin
  inherited;
  if TElAdvancedPanel(Parent).Minimized then
  begin
    fwd := not (ssShift in FShiftState);
    Curcontrol := self;
    repeat
      CurControl := THackForm(GetParentForm(Self)).FindNextControl(Curcontrol, fwd, true, false);
      until (CurControl = nil) or ((CurControl.Parent <> Parent) and CurControl.Enabled and CurControl.Visible);
    if (CurControl <> nil) and CurControl.CanFocus and CurControl.Visible and GetParentForm(CurControl).Visible then
    try
     CurControl.SetFocus;
    except
    end;
  end;
end;

procedure TElAdvCaptionPanel.WMSetFocus(var Message: TWMSetFocus);
var CurControl : TWinControl;
begin
  inherited;
  if not TElAdvancedPanel(Parent).FCaptionSettings.ShowMinButton then
  begin
    Curcontrol := THackForm(GetParentForm(Self)).FindNextControl(Self, true, true, false);
    if (CurControl <> nil) and (Message.FocusedWnd = CurControl.Handle) then
      THackForm(GetParentForm(Self)).SelectNext(Parent, false, true)
      else
      THackForm(GetParentForm(Self)).SelectNext(Self, true, true)
      end;
end;

procedure TElAdvCaptionPanel.MouseDown(Button: TMouseButton; Shift: TShiftState;
    X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  SetFocus;
end;

procedure TElAdvCaptionPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
//var
//  SaveHeight : integer;
begin
//  SaveHeight := Height;
  if DoResize then
    inherited;
{  if SaveHeight <> AHeight then
  begin
  end;}
end;

function TElAdvCaptionPanel.GetGlyph: TBitmap;
begin
  Result := FGlyphButton.Glyph;
end;

procedure TElAdvCaptionPanel.SetGlyph(const Value: TBitmap);
begin
  FGlyphButton.Glyph := Value;
  Invalidate;
end;

procedure TElAdvCaptionPanel.TriggerPaintEvent;
var
  LRect: TRect;
  LCaptionSettings: TElPanelCaptionSettings;
  LDetails: TThemedElementDetails;
begin
  LRect := ClientRect;
  AdjustClientRect(LRect);
  InflateRect(LRect, -2, 0);
  LCaptionSettings := TElAdvancedPanel(Parent).FCaptionSettings;
  FRender.Data.DefaultFont := LCaptionSettings.Font.Name;
  FRender.Data.DefaultStyle := LCaptionSettings.Font.Style;
  FRender.Data.DefaultColor := LCaptionSettings.Font.Color;
  FRender.Data.DefaultHeight:= LCaptionSettings.Font.Height;
  FRender.Data.Charset := LCaptionSettings.Font.Charset;
  Canvas.Font.Assign(LCaptionSettings.Font);
  FGlyphButton.Draw(Canvas, LRect, Point(0, 0), Caption, blGlyphLeft, -2, -2, ebsUp,
                    ebsUp, Alignment, True, False, True, True, True, 0, tdtNormal,
                    TElAdvancedPanel(Parent).Font.Color, ttmNone, LDetails, False, True, (Copy(Caption, 1, 6) = '<html>'), FRender, False);
                    end;

procedure TElPanelCaptionSettings.SetText(Value: TLMDString);
begin
  FOwner.FCaptionPanel.Caption := Value;
end;

procedure TElPanelCaptionSettings.SetVisible(Value: Boolean);
var R : TRect;
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if not Visible and FOwner.Minimized then
      FOwner.Minimized := false;
    FOwner.FCaptionPanel.Visible := Value;
    R := FOwner.ClientRect;
    FOwner.AlignControls(nil, R);
    FOwner.Invalidate;
  end;
end;

procedure TElPanelCaptionSettings.SetHeight(Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    if FOwner.FMinimized then
      FOwner.Height := Value;
    with TElAdvCaptionPanel(FOwner.FCaptionPanel) do
    begin
      DoResize := true;
      Height := Value;
      DoResize := false;
    end;
    FOwner.Invalidate;
  end;
end;

procedure TElPanelCaptionSettings.SetShowCloseButton(Value: Boolean);
begin
  if FShowCloseButton <> Value then
  begin
    FShowCloseButton := Value;
    FOwner.FCloseButton.Visible := Value;
    FOwner.AdjustButtonSize;
    FOwner.FCaptionPanel.Invalidate;
  end;
end;

procedure TElPanelCaptionSettings.SetShowMinButton(Value: Boolean);
begin
  if FShowMinButton <> Value then
  begin
    FShowMinButton := Value;
    FOwner.FMinButton.Visible := Value;
    FOwner.AdjustButtonSize;
    FOwner.FCaptionPanel.Invalidate;
  end;
end;

procedure TElPanelCaptionSettings.SetMinButtonPngGlyph(const Value: TLMDPngObject);
var
  LTemp: TBitmap;
begin
  FOwner.FMinButton.PngGlyph.Assign(Value);
  FOwner.FMinButton.UseImageList := True;
  FOwner.FImages.Clear;
  if Assigned(Value) and (not Value.Empty) then
  begin
    LTemp := TBitmap.Create;
    try
      Value.AssignTo(LTemp);
      FOwner.FImages.Width := Value.Width div 2;
      FOwner.FImages.Height := Value.Height;
      FOwner.FImages.AddMasked(LTemp, Value.Canvas.Pixels[0, Value.Height - 1]);
    finally
      LTemp.Free;
    end;
  end
  else
  begin
    FOwner.FImages.Width := 7;
    FOwner.FImages.Height := 5;
    FOwner.FImages.AddMasked(UpArrowBmp, clWhite);
    FOwner.FImages.AddMasked(DownArrowBmp, clWhite);
  end;
end;

procedure TElPanelCaptionSettings.SetMinButtonPos(Value: TElMinButtonPosition);
begin
  if FMinButtonPos <> Value then
  begin
    FMinButtonPos := Value;
    FOwner.AdjustButtonSize;
  end;
end;

procedure TElPanelCaptionSettings.SetShowCheckBox(Value: boolean);
begin
  if Value <> FShowCheckBox then
  begin
    FShowCheckBox := Value;
    if Value then
    begin
      FOwner.FCheckBox := FOwner.CreateCheckbox;
      FOwner.FCheckBox.Checked := FCheckBoxChecked;
      FOwner.FCheckBox.Flat := FFlat;
      FOwner.FCheckBox.FlatAlways := FFlatAlways;
//      if (csDesigning in FOwner.ComponentState) then
//      begin
//        THackCheckBox(FOwner.FCheckBox).SetDesigning(false);
//      end;
//      with FOwner do
//      begin
//        FCaptionPanel.BoundsRect := Rect(0, 0, Width, GetCaptionHeight);
//        AdjustButtonSize;
//      end;
    end
    else
      FreeAndNil(FOwner.FCheckBox);
    FOwner.AdjustButtonSize;
    FOwner.FCaptionPanel.Invalidate;
  end;
end;

procedure TElPanelCaptionSettings.SetCheckBoxChecked(Value: boolean);
begin
  if Value <> FCheckBoxChecked then
  begin
    FCheckBoxChecked := Value;
    if Assigned(FOwner.FCheckBox) then
      FOwner.FCheckBox.Checked := Value;
  end;
end;

function TElPanelCaptionSettings.GetCheckBoxChecked: boolean;
begin
  if Assigned(FOwner.FCheckBox) then
    Result := FOwner.FCheckBox.Checked
  else
    Result := FCheckBoxChecked;
end;

function TElPanelCaptionSettings.GetBackground: TBitmap;
begin
  Result := TElAdvCaptionPanel(FOwner.FCaptionPanel).Background;
end;

procedure TElPanelCaptionSettings.SetBackground(const Value: TBitmap);
begin
  TElAdvCaptionPanel(FOwner.FCaptionPanel).Background := Value;
end;

function TElPanelCaptionSettings.GetGlyph: TBitmap;
begin
  Result := TElAdvCaptionPanel(FOwner.FCaptionPanel).Glyph;
end;

procedure TElPanelCaptionSettings.SetGlyph(const Value: TBitmap);
begin
  TElAdvCaptionPanel(FOwner.FCaptionPanel).Glyph := Value;
end;

function TElPanelCaptionSettings.GetBackgroundType: TLMDBackgroundType;
begin
  Result := FOwner.FCaptionPanel.BackgroundType;
end;

procedure TElPanelCaptionSettings.SetBackgroundType(const Value: TLMDBackgroundType);
begin
  if Value <> FOwner.FCaptionPanel.BackgroundType then
    FOwner.FCaptionPanel.BackgroundType := Value;
end;

function TElPanelCaptionSettings.GetGradientEndColor: TColor;
begin
  Result := FOwner.FCaptionPanel.GradientEndColor;
end;

function TElPanelCaptionSettings.GetGradientStartColor: TColor;
begin
  Result := FOwner.FCaptionPanel.GradientStartColor;
end;

function TElPanelCaptionSettings.GetGradientSteps: Integer;
begin
  Result := FOwner.FCaptionPanel.GradientSteps;
end;

procedure TElPanelCaptionSettings.SetGradientEndColor(const Value: TColor);
begin
  if Value <> FOwner.FCaptionPanel.GradientEndColor then
    FOwner.FCaptionPanel.GradientEndColor := Value;
end;

procedure TElPanelCaptionSettings.SetGradientStartColor(const Value: TColor);
begin
  if Value <> FOwner.FCaptionPanel.GradientStartColor then
    FOwner.FCaptionPanel.GradientStartColor := Value;
end;

procedure TElPanelCaptionSettings.SetGradientSteps(const Value: Integer);
begin
  if Value <> FOwner.FCaptionPanel.GradientSteps then
    FOwner.FCaptionPanel.GradientSteps := Value;
end;

constructor TElPanelCaptionSettings.Create(Owner : TCustomElAdvancedPanel);
begin
  inherited Create;
  FOwner := Owner;
  FVisible := true;
  FHeight := 19;
  FButtonWidth := 15;
  FShowCloseButton := true;
  FShowMinButton := true;
  FMinButtonPos := mbpRight;
  FFlat := true;
  //FColor := clBtnFace;
  FButtonColor := clBtnFace;
  FAlignment := taLeftJustify;
  FShowCheckBox := false;
  FCheckBoxChecked := false;
end;

procedure TElPanelCaptionSettings.SetButtonWidth(Value: Integer);
begin
  if FButtonWidth <> Value then
  begin
    FButtonWidth := Value;
    if AutoSize then
      AdjustHeight;
    FOwner.AdjustButtonSize;
  end;
end;

procedure TElPanelCaptionSettings.SetAlignment(Value: TAlignment);
begin
  FAlignment := Value;
  FOwner.FCaptionPanel.Alignment := Value;
end;

procedure TElPanelCaptionSettings.SetLayout(newValue: TTextLayout);
{ Sets data member FLayout to newValue. }
begin
  if (FLayout <> newValue) then
  begin
    FLayout := newValue;
    FOwner.FCaptionPanel.Layout := newValue;
  end;  { if }
end;  { SetLayout }

function TElPanelCaptionSettings.GetFont: TFont;
begin
  Result := FOwner.FCaptionPanel.Font;
end;

procedure TElPanelCaptionSettings.SetFont(Value: TFont);
begin
  FOwner.FCaptionPanel.Font := Value;
end;

function TElPanelCaptionSettings.GetParentFont: Boolean;
begin
  Result := FOwner.FCaptionPanel.ParentFont;
end;

procedure TElPanelCaptionSettings.SetParentFont(Value: Boolean);
begin
  FOwner.FCaptionPanel.ParentFont := Value;
end;

function TElPanelCaptionSettings.GetColor: TColor;
begin
  Result := FOwner.FCaptionPanel.Color;
end;

procedure TElPanelCaptionSettings.SetColor(Value: TColor);
begin
  FOwner.FCaptionPanel.Color := Value;
end;

procedure TElPanelCaptionSettings.SetButtonColor(Value: TColor);
begin
  if FButtonColor <> Value then
  begin
    FButtonColor := Value;
    FOwner.FMinButton.Color := FButtonColor;
    FOwner.FCloseButton.Color := FButtonColor;
  end;
end;

function TElPanelCaptionSettings.GetImageForm: TElImageForm;
begin
  Result := FOwner.FCaptionPanel.ImageForm;
end;

procedure TElPanelCaptionSettings.SetImageForm(Value: TElImageForm);
begin
  FOwner.FCaptionPanel.ImageForm := Value;
end;

function TElPanelCaptionSettings.GetMinButtonGlyph: TBitmap;
begin
  Result := FOwner.FMinButton.Glyph;
//  FOwner.FMinButtonGlyph.Width := 0;
//  FOwner.FMinButtonGlyph.Width := FOwner.FImages.Width * 2;
//  FOwner.FMinButtonGlyph.Height := FOwner.FImages.Height;
//  if FOwner.FImages.Count>0 then
//  begin
//    FOwner.FImages.Draw(FOwner.FMinButtonGlyph.Canvas, 0, 0, 0);
//    FOwner.FImages.Draw(FOwner.FMinButtonGlyph.Canvas, FOwner.FImages.Width, 0, 1);
//  end;
//  Result := FOwner.FMinButtonGlyph;
end;

function TElPanelCaptionSettings.GetMinButtonPngGlyph: TLMDPngObject;
begin
  Result := FOwner.FMinButton.PngGlyph;
end;

procedure TElPanelCaptionSettings.LoadDefaultMinButton;
begin
  with FOwner do
  begin
    FImages.Width := 7;
    FImages.Height := 5;
    FImages.AddMasked(UpArrowBmp, clWhite);
    FImages.AddMasked(DownArrowBmp, clWhite);
    FMinButton.Images := FImages;
    FMinButton.UseImageList := true;
    FMinButton.ImageIndex := 0;
  end;
end;

procedure TElPanelCaptionSettings.Assign(Source : TPersistent);

 var
   Src :TElPanelCaptionSettings absolute Source;
begin
  if Source is TElPanelCaptionSettings then
  begin
    Text                  := Src.Text;
    Visible               := Src.Visible;
    Height                := Src.Height;
    ShowCloseButton       := Src.ShowCloseButton;
    ShowMinButton         := Src.ShowMinButton;
    FlatButtons           := Src.FlatButtons;
    ButtonWidth           := Src.ButtonWidth;
    Alignment             := Src.Alignment;
    Layout                := Src.Layout;
    Font                  := Src.Font;
    ParentFont            := Src.ParentFont;
    Color                 := Src.Color;
    ButtonColor           := Src.ButtonColor;
    ImageForm             := Src.ImageForm;
    MinButtonGlyph        := Src.MinButtonGlyph;
    CloseButtonGlyph      := Src.CloseButtonGlyph;
    InvertMinButtonArrows := Src.InvertMinButtonArrows;
    AutoSize              := Src.AutoSize;
    ShowCheckBox          := Src.ShowCheckBox;
    CheckBoxChecked       := Src.CheckBoxChecked;
    Flat                  := Src.Flat;
    FlatAlways            := Src.FlatAlways;
  end
  else inherited Assign(Source);
end;

procedure TElPanelCaptionSettings.SetMinButtonGlyph(Value: TBitmap);
begin
  FOwner.FMinButton.Glyph.Assign(Value);
  FOwner.FMinButton.UseImageList := True;
  FOwner.FImages.Clear;
  if Assigned(Value) and (not Value.Empty) then
  begin
    FOwner.FImages.Width := Value.Width div 2;
    FOwner.FImages.Height := Value.Height;
    FOwner.FImages.AddMasked(Value, Value.Canvas.Pixels[0, Value.Height - 1]);
  end
  else
  begin
    FOwner.FImages.Width := 7;
    FOwner.FImages.Height := 5;
    FOwner.FImages.AddMasked(UpArrowBmp, clWhite);
    FOwner.FImages.AddMasked(DownArrowBmp, clWhite);
  end;
end;

function TElPanelCaptionSettings.GetCloseButtonGlyph: TBitmap;
begin
  Result := FOwner.FCloseButton.Glyph;
end;

function TElPanelCaptionSettings.GetCloseButtonPngGlyph: TLMDPngObject;
begin
  Result := FOwner.FCloseButton.PngGlyph;
end;

procedure TElPanelCaptionSettings.SetCloseButtonGlyph(Value: TBitmap);
begin
  FOwner.FCloseButton.Glyph := Value;
  FOwner.FCloseButton.UsePng := False;
end;

procedure TElPanelCaptionSettings.SetCloseButtonPngGlyph(
  const Value: TLMDPngObject);
begin
  FOwner.FCloseButton.PngGlyph := Value;
  FOwner.FCloseButton.UsePng := True;
end;

procedure TElPanelCaptionSettings.SetInvertMinButtonArrows(Value: Boolean);
begin
  if FInvertMinButtonArrows <> Value then
  begin
    FInvertMinButtonArrows := Value;
    if not (csLoading in FOwner.ComponentState) then
      FOwner.UpdateMinButtonImages;
  end;
end;

procedure TElPanelCaptionSettings.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if AutoSize then
      AdjustHeight;
  end;
end;

procedure TElPanelCaptionSettings.FontChanged;
begin
  if AutoSize then AdjustHeight;
end;

procedure TElPanelCaptionSettings.AdjustHeight;
var
  DC: HDC;
  SaveFont: HFont;
  SysMetrics, Metrics: TLMDTextMetric;
begin
  DC := GetDC(0);
  LMDGetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  LMDGetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);

  Height := Max(Metrics.tmHeight, FOwner.GetButtonWidth) + Margin * 2;
end;

procedure TElPanelCaptionSettings.SetFlat(Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    FOwner.FMinButton.Flat := Value;
    FOwner.FCloseButton.Flat := Value;
    if Assigned(FOwner.FCheckBox) then
      FOwner.FCheckBox.flat := Value;
  end;
end;

procedure TElPanelCaptionSettings.SetFlatAlways(Value: Boolean);
begin
  if FFlatAlways <> Value then
  begin
    FFlatAlways := Value;
    FOwner.FMinButton.ThinFrame := Value;
    FOwner.FCloseButton.ThinFrame := Value;
    if Assigned(FOwner.FCheckBox) then
      FOwner.FCheckBox.FlatAlways := Value;
  end;
end;

function TElPanelCaptionSettings.GetText: TLMDString;
begin
  Result := FOwner.FCaptionPanel.Caption;
end;

procedure TCustomElAdvancedPanel.SetMinimized(Value: Boolean);
//var R : TRect;
begin
  if FMinimized <> Value then
  begin
    if FCaptionSettings.Visible or Value then
    begin
      if Value then
      begin
        if not TriggerBeforeMinimizeEvent then Exit;
        {
        R := ClientRect;
        inherited AdjustClientRect(R);
        }
        FSaveHeight := Height;
        FMinimized := true;
        if (Parent <> nil) and (Parent.ClassType = TCustomDockForm) then
          Parent.Height := GetCaptionHeight + GetBevelAdjustment + (Parent.Height - Parent.ClientHeight)
        else
          Height := GetCaptionHeight + GetBevelAdjustment;
        TriggerMinimizeEvent;
      end
      else
      begin
        if not TriggerBeforeRestoreEvent then Exit;
        FMinimized := false;
        TriggerRestoreHeightEvent;
        if (Parent <> nil) and (Parent.ClassType = TCustomDockForm) then
          Parent.Height := FSaveHeight + (Parent.Height - Parent.ClientHeight)
        else
        begin
          if Align = alBottom then
            SetBounds(Left,
                      Top - (FSaveHeight - Height),
                      Width,
                      FSaveHeight)
          else
            Height := FSaveHeight;
        end;
        TriggerRestoreEvent;
      end;
      UpdateMinButtonImages;
      Realign;
    end;
  end;
end;

procedure TCustomElAdvancedPanel.WMSize(var Message: TWMSize);
var
  R : TRect;
begin
  inherited;

  R := ClientRect;
  inherited AdjustClientRect(R);
  AdjustInnerSize(R);

  if not Minimized and (Message.Height < GetCaptionHeight + GetBevelAdjustment) then
  begin
    FMinimized := True;
    if (Parent <> nil) and (Parent.ClassType = TCustomDockForm) then
      Parent.Height := GetCaptionHeight + GetBevelAdjustment + (Parent.Height - Parent.ClientHeight)
    else
      Height := GetCaptionHeight + GetBevelAdjustment;
    UpdateMinButtonImages;
    TriggerMinimizeEvent;
    exit;
  end;
  if Minimized then
    if (Height > GetCaptionHeight + GetBevelAdjustment + GetBorderAdjustment) then
    begin
      if not (csDesigning in ComponentState) then
      begin
//        FMinimized := false;
//        FSaveHeight := Height;
        UpdateMinButtonImages;
        TriggerRestoreEvent;
      end;
    end
    else
      Height := GetCaptionHeight + GetBevelAdjustment + GetBorderAdjustment;
end;

procedure TCustomElAdvancedPanel.WMWindowPosChanged(
  var Message: TWMWindowPosChanged);
begin
  inherited;
  //<-- EK&VB 13 Oct 2008 transparency issue fix
  //    for cases ElAdvPanel on ElPanel (ElAdvPanel caption does not repaint
  //    otherwise) -->
  if Assigned(FCaptionPanel) and (Transparent or TransparentXPThemes)  then
    FCaptionPanel.Repaint;
end;

procedure TCustomElAdvancedPanel.SetCaptionSettings(Value: TElPanelCaptionSettings);
begin
  FCaptionSettings.Assign(Value);
end;

constructor TCustomElAdvancedPanel.Create(AOwner : TComponent);
begin

  BeginCreate;
  inherited;

  FCaptionSettings := TElPanelCaptionSettings.Create(Self);

  FCaptionPanel := CreatePanel;
  FCaptionPanel.Alignment := FCaptionSettings.FAlignment;
  FCaptionPanel.StyleManager := nil;
  FCaptionPanel.Parent := Self;
  FCaptionPanel.TabStop := true;
  FCaptionPanel.OnImageNeeded := TriggerImageNeededEvent;
  FCaptionPanel.OnLinkClick := LinkClickEventTransfer;
  FCaptionPanel.OnClick := DoClick;
  FCaptionPanel.OnDblClick := DoDblClick;

  BevelInner := bvNone;
  BevelOuter := bvNone;

  FMinButton := CreateButton;

  FCloseButton := CreateButton;

  FMinButton.StyleManager := nil;
  FMinButton.Parent := FCaptionPanel;
  FMinButton.OnClick := OnMinButtonClick;
  FMinButton.Flat := true;
  FMinButton.ThinFrame := true;

  FCloseButton.StyleManager := nil;
  FCloseButton.Parent := FCaptionPanel;
  FCloseButton.OnClick := OnCloseButtonClick;
  FCloseButton.Flat := true;
  FCloseButton.ThinFrame := true;

  FCaptionPanel.OnResize := OnCaptionSize;
  FCaptionPanel.Height := 19;

  FImages := TCustomImageList.Create(Self);
  FMinButtonGlyph := TBitmap.Create;

  FCloseButton.Glyph := CloseBmp;
  CaptionSettings.LoadDefaultMinButton;

  FCaptionPanel.BoundsRect := Rect(0, 0, Width, GetCaptionHeight);

  AdjustButtonSize;

  EndCreate;
end;

destructor TCustomElAdvancedPanel.Destroy;
begin
  FCloseButton.Free;
  FCloseButton := nil;
  FMinButton.Free;
  FMinButton := nil;
  if Assigned(FCheckBox) then
    FCheckBox.Free;
  FCheckBox := nil;
  FCaptionSettings.Free;
  FCaptionSettings := nil;
  FMinButtonGlyph.Free;
  FMinButtonGlyph := nil;
  inherited;
end;

procedure TCustomElAdvancedPanel.ChangeScale(M, D: Integer);
begin
  inherited;
  CaptionSettings.Height := MulDiv(CaptionSettings.Height, M, D);
end;

function TCustomElAdvancedPanel.TriggerBeforeMinimizeEvent : boolean;
begin
  Result := true;
  if assigned(FOnBeforeMinimize) then FOnBeforeMinimize(Self, Result);
end;

procedure TCustomElAdvancedPanel.TriggerMinimizeEvent;
begin
  if assigned(FOnMinimize) then FOnMinimize(Self);
end;

function TCustomElAdvancedPanel.TriggerBeforeRestoreEvent : boolean;
begin
  Result := true;
  if assigned(FOnBeforeRestore) then FOnBeforeRestore(Self, Result);
end;

procedure TCustomElAdvancedPanel.TriggerRestoreHeightEvent;
begin
  if assigned(FOnRestoreHeight) then FOnRestoreHeight(Self, FSaveHeight);
end;

procedure TCustomElAdvancedPanel.TriggerRestoreEvent;
begin
  if assigned(FOnRestore) then FOnRestore(Self);
end;

procedure TCustomElAdvancedPanel.OnMinButtonClick(Sender : TObject);
begin
  if not (csDesigning in ComponentState) then
    Minimized := not Minimized;
end;

procedure TCustomElAdvancedPanel.OnCloseButtonClick(Sender : TObject);
var CanClose : boolean;
begin
  if not (csDesigning in ComponentState) then
  begin
    CanClose := true;
    TriggerCloseQueryEvent(CanClose);
    if CanClose then
    begin
      TriggerCloseEvent;
      Hide;
    end;
  end;
end;

procedure TCustomElAdvancedPanel.OnCaptionSize(Sender : TObject);
begin
  AdjustButtonSize;
end;

procedure TCustomElAdvancedPanel.AdjustButtonSize;
var
  R : TRect;
  bw : integer;
  LTop: Integer;
begin
  bw := GetButtonWidth;
  LTop := Margin;
  case Layout of
    tlTop: LTop := Margin;
    tlCenter: LTop := (FCaptionPanel.Height - bw) div 2;
    tlBottom: LTop := FCaptionPanel.Height - bw - Margin;
  end;

  R := Rect(FCaptionPanel.Width - bw - Margin, LTop,
            FCaptionPanel.Width - Margin, LTop + bw);

  FCloseButton.BoundsRect := R;

  if CaptionSettings.FMinButtonPos = mbpRight then
  begin
    R := Rect(FCaptionPanel.Width - bw - Margin, LTop,
              FCaptionPanel.Width - Margin, LTop + bw);

    if FCaptionSettings.ShowCloseButton then
      OffsetRect(R, - (bw + Margin), 0);

    FMinButton.BoundsRect := R;
  end;

  if Assigned(FCheckBox) then
  begin
    R := Rect(0, 0, CheckBoxSize, CheckBoxSize);
    OffsetRect(R, Margin, (FCaptionPanel.Height - Margin * 2 - CheckBoxSize) div 2);
    FCheckBox.BoundsRect := R;
    if CaptionSettings.FMinButtonPos = mbpLeft then
    begin
      R := Rect(CheckBoxSize + 2 * Margin,
                LTop,
                CheckBoxSize + 2 * Margin + bw,
                LTop + bw);
      FMinButton.BoundsRect := R;
    end;
  end                    else
  if CaptionSettings.FMinButtonPos = mbpLeft then
  begin
    R := Rect(Margin, Ltop, Margin + bw, LTop + bw);
    FMinButton.BoundsRect := R;
  end;
end;

procedure TCustomElAdvancedPanel.TriggerCloseEvent;
begin
  if assigned(FOnClose) then FOnClose(Self);
end;

procedure TCustomElAdvancedPanel.AdjustClientRect(var Rect : TRect);
begin
  inherited;
  if FCaptionSettings.Visible then
  begin
    inc(Rect.Top, GetCaptionHeight);
  end;
end;

procedure TCustomElAdvancedPanel.CreateWnd;
var R : TRect;
begin
  inherited;
  TElAdvCaptionPanel(FCaptionPanel).SetDesigning(false);
  if IsThemed then
  begin
    R := ClientRect;
    inherited AdjustClientRect(R);
    AdjustInnerSize(R);
  end;
end;

procedure TCustomElAdvancedPanel.WMNCHitTest(var Msg : TWMNCHitTest);
var P : TPoint;
begin
  inherited;
  if Movable and FCaptionSettings.Visible and (not (csDesigning in ComponentState)) then
  begin
    P := ScreenToClient(SmallPointToPoint(Msg.Pos));
    if (P.Y >= GetCaptionHeight) and (Msg.Result = HTCAPTION) then
      Msg.Result := HTNOWHERE;
  end;
end; {WMNCHitTest}

procedure TCustomElAdvancedPanel.LinkClickEventTransfer(Sender : TObject; HRef : TLMDString);
begin
  TriggerLinkClickEvent(HRef);
end;

procedure TCustomElAdvancedPanel.SetImageForm(newValue : TElImageForm);
begin
  inherited;
  // FCaptionPanel.ImageForm := newValue;
end;

procedure TCustomElAdvancedPanel.SetThemeMode(const Value: TLMDThemeMode);
begin
  FCaptionPanel.ThemeMode := Value;
  FCloseButton.ThemeMode := Value;
  FMinButton.ThemeMode := Value;
  inherited;
end;

procedure TCustomElAdvancedPanel.SetUseXPThemes(const Value: Boolean);
begin
  FCaptionPanel.UseXPThemes := Value;
  FCloseButton.UseXPThemes := Value;
  FMinButton.UseXPThemes := Value;
  inherited;
end;

procedure TCustomElAdvancedPanel.DoThemeChanged;
begin
  FCaptionPanel.ThemeGlobalMode := FThemeGlobalMode;
  FCloseButton.ThemeGlobalMode := FThemeGlobalMode;
  FMinButton.ThemeGlobalMode := FThemeGlobalMode;
  inherited;
  if IsThemed then
    SetBounds(Left, Top, Width, Height);
end;

procedure TCustomElAdvancedPanel.AdjustInnerSize(var R : TRect);
var
  Details: TThemedElementDetails;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  if IsThemed then
  begin
    Details.Element := teWindow;
    Details.Part := GP_BORDER;
    if BevelOuter <> bvNone then
    begin
      InflateRect(R, BevelWidth, BevelWidth);
      Details.State := BSS_SUNKEN;
      R := LMDThemeServices.ContentRect(LThemeMode, 0, Details, R);
    end;
    if BevelInner <> bvNone then
    begin
      InflateRect(R, BevelWidth, BevelWidth);
      Details.State := BSS_SUNKEN;
      R := LMDThemeServices.ContentRect(LThemeMode, 0, Details, R);
    end;
  end;
  //KindOffs := 0;

  InflateRect(R, BorderWidth, BorderWidth);
  if IsThemed and ((BevelInner <> bvNone) or (bvNone <> bvNone)) then
    InflateRect(R, - BevelWidth, - BevelWidth);
  TElAdvCaptionPanel(FCaptionPanel).DoResize := true;
  FCaptionPanel.BoundsRect := Rect(R.Left, R.Top, R.Right, R.Top + Min(GetCaptionHeight, R.Bottom - R.Top));
  TElAdvCaptionPanel(FCaptionPanel).DoResize := false;
  InflateRect(R, -BorderWidth, -BorderWidth);
end;

function TCustomElAdvancedPanel.GetBevelAdjustment: Integer;
begin
  Result := 0;
  if BevelOuter <> bvNone then
    inc(result, 2 * BevelWidth);
  if BevelInner <> bvNone then
    inc(result, 2 * BevelWidth);
end;

procedure TCustomElAdvancedPanel.UpdateMinButtonImages;
begin
  if Minimized xor FCaptionSettings.InvertMinButtonArrows then
    FMinButton.ImageIndex := 1
  else
    FMinButton.ImageIndex := 0;
end;

procedure TCustomElAdvancedPanel.Loaded;
begin
  inherited;
  FCaptionPanel.TabStop := Self.TabStop;
  if Assigned(FCaptionSettings.MinButtonGlyph) then
    FCaptionSettings.SetMinButtonGlyph(FCaptionSettings.MinButtonGlyph);
  UpdateMinButtonImages;
end;

procedure TCustomElAdvancedPanel.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ExpandedHeight', ReadExpHeight, WriteExpHeight, true);
  with GetElReader do
   Filer.DefineProperty('Canvas', FakeValue, nil, False);
end;

procedure TCustomElAdvancedPanel.ReadExpHeight(Reader : TReader);
begin
  FSaveHeight := Reader.ReadInteger;
end;

procedure TCustomElAdvancedPanel.WriteExpHeight(Writer : TWriter);
var
  i: TValueType;
begin
  i := vaInt32;
  Writer.Write(i, SizeOf(i));
  Writer.Write(FSaveHeight, SizeOf(FSaveHeight));
end;

procedure TCustomElAdvancedPanel.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  inherited;
  FCaptionPanel.LinkPopupMenu := newValue;
end;

procedure TCustomElAdvancedPanel.SetLinkColor(newValue : TColor);
begin
  inherited;
  FCaptionPanel.LinkColor := newValue;
end;

procedure TCustomElAdvancedPanel.SetLinkStyle(newValue : TFontStyles);
begin
  inherited;
  FCaptionPanel.LinkStyle := newValue;
end;

procedure TCustomElAdvancedPanel.SetTransparentXPThemes(Value: Boolean);
begin
  inherited;
  FCaptionPanel.TransparentXPThemes := Value;
end;

function TCustomElAdvancedPanel.CreateButton: TElAdvCaptionButton;
begin
  Result := TElAdvCaptionButton.Create(FCaptionPanel);
end;

function TCustomElAdvancedPanel.CreateCheckbox: TElCheckBox;
begin
  Result := THackCheckBox.Create(FCaptionPanel);
  Result.Parent := FCaptionPanel;
  Result.Visible := True;
  Result.Left := Margin;
  Result.Top:= Margin;
  Result.Width := Result.Height;
  Result.Flat := true;
  Result.OnDblClick := DoDblClick;
  Result.StyleManager := nil;
  Result.OnClick := DoCheckBoxClick;
end;

function TCustomElAdvancedPanel.CreatePanel: TElAdvCaptionPanel;
begin
  Result := TElAdvCaptionPanel.Create(Self);
end;

{function TCustomElAdvancedPanel.GetThemePartID: Integer;
begin
  result := GP_BORDER;
end;}

function TCustomElAdvancedPanel.GetButtonWidth: Integer;
begin
  Result := FCaptionSettings.FButtonWidth;
end;

function TCustomElAdvancedPanel.GetCaptionHeight: Integer;
begin
  if FCaptionSettings <> nil then
    result := FCaptionSettings.Height
  else
    result := 0;
end;

procedure TCustomElAdvancedPanel.UpdateInterior;
var R : TRect;
begin
  inherited;
  if HandleAllocated then
  begin
    R := ClientRect;
    inherited AdjustClientRect(R);
    AdjustInnerSize(R);
  end;
end;

procedure TCustomElAdvancedPanel.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if Message.FocusedWnd = FCaptionPanel.Handle then
    THackForm(GetParentForm(Self)).SelectNext(Self, false, True)
  else
    if CanFocus then
      FCaptionPanel.SetFocus;
end;

procedure TCustomElAdvancedPanel.DoClick(Sender : TObject);
begin
  Click;
end;

procedure TCustomElAdvancedPanel.DoCheckBoxClick(Sender: TObject);
begin
  if Assigned(FOnCheckBoxClick) then
    FOnCheckBoxClick(Sender);
end;

function TCustomElAdvancedPanel.GetShowFocus: Boolean;
begin
  Result := FCaptionPanel.ShowFocus;
end;

procedure TCustomElAdvancedPanel.SetShowFocus(Value: Boolean);
begin
  FCaptionPanel.ShowFocus := Value;
end;

procedure TCustomElAdvancedPanel.DoDblClick(Sender : TObject);
begin
  DblClick;
end;

procedure TCustomElAdvancedPanel.TriggerCloseQueryEvent(var CanClose : boolean);
begin
  if assigned(FOnCloseQuery) then FOnCloseQuery(Self, CanClose);
end;

procedure TCustomElAdvancedPanel.ELThemeChanged(var Message: TMessage);
begin
  inherited;
  with FCaptionSettings do
    if AutoSize then
      AdjustHeight;
  AdjustButtonSize;
end;

constructor TElAdvCaptionButton.Create(AOwner : TComponent);
begin
  inherited;
  ParentColor := false;
end;

procedure TElAdvCaptionPanel.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FShiftState := Shift;
end;

procedure TCustomElAdvancedPanel.CMEnter(var Message: TCMEnter);
begin
  if FMinimized then
    FCaptionPanel.SetFocus;
  inherited;
end;

procedure TCustomElAdvancedPanel.CMTabStopChanged(var Message: TMessage);
begin
  FCaptionPanel.TabStop := Self.TabStop;
end;

function TCustomElAdvancedPanel.GetBorderAdjustment: Integer;
begin
  if (BorderStyle <> bsNone) and UseXPThemes and TransparentXPThemes then
    Result := 2
  else
    Result := 0;
end;

function TElPanelCaptionSettings.GetCloseButtonTransparent: Boolean;
begin
  Result := FOwner.FCloseButton.Transparent;
end;

function TElPanelCaptionSettings.GetMinButtonTransparent: Boolean;
begin
  Result := FOwner.FMinButton.Transparent;
end;

procedure TElPanelCaptionSettings.SetCloseButtonTransparent(
  const Value: Boolean);
begin
  FOwner.FCloseButton.Transparent := Value;
end;

procedure TElPanelCaptionSettings.SetMinButtonTransparent(
  const Value: Boolean);
begin
  FOwner.FMinButton.Transparent := Value;
end;

initialization

  CloseBmp := TBitmap.Create;
  UpArrowBmp := TBitmap.Create;
  DownArrowBmp:= TBitmap.Create;

  CloseBmp.LoadFromResourceName(HInstance, 'ELADVPANELCLOSEBUTTON');
  UpArrowBmp.LoadFromResourceName(HInstance, 'ELADVPANELUPARROW');
  DownArrowBmp.LoadFromResourceName(HInstance, 'ELADVPANELDOWNARROW');

finalization

  try
    CloseBmp.Free;
    UpArrowBmp.Free;
    DownArrowBmp.Free;
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElAdvPanel: ' + e.Message);
    end;
  end;

end.
