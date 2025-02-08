unit ElCheckCtl;
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

ElCheckCtl unit
---------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses

  Types,

  Controls,
  Messages,
  Windows,
  Graphics,
  Forms,
  StdCtrls,
  Menus,
  CommCtrl,
  Math,
  ImgList,
  SysUtils,
  Classes,
  TypInfo,

  LMDHTMLUnit,
  LMDTypes,
  LMDThemes,
  Themes,
  LMDProcs,
  LMDSysIn,
  LMDGraphUtils,
  LMDClass,
  {$ifdef LMD_UNICODE}
  LMDUnicode,
  {$endif}
  LMDGraph,

  ElXPThemedControl,
  ElSndMap,
  ElVCLUtils,
  ElBtnCtl,
  ElImgFrm;

type
  TElCheckItem = class(TElButtonControl)
  private
    FFlat : Boolean;

    FSoundMap : TElSoundMap;
    FCheckSound : TElSoundName;

    FJustLooseFocus: Boolean;
    FWordWrap: Boolean;
    FUseCustomGlyphs : Boolean;
    FGlyph : TBitmap;
    FAlignment : TLeftRight;
    FMouseInControl : boolean;
    FPressed : boolean;
    FOldCapture : HWND;
    FChLink  : TChangeLink;
    FAChLink  : TChangeLink;
    // FDoFocus : boolean;
    FImgForm : TElImageForm;
    FImgFormChLink  : TImgFormChangeLink;
    FAutoSize       : boolean;

    FIsHTML  : Boolean;
    FRender  : TLMDHTMLRender;

    // FMultiLine: boolean;
    FModified : boolean;
    FImages  : TCustomImageList;
    FAlphaImages  : TCustomImageList;
    FUseImageList: Boolean;
    FCursor: TCursor;
    FTextPos: TPoint;
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;
    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    // procedure SetMultiLine(value : boolean);
    procedure AdjustAutoSize;
    procedure ImageFormChange(Sender: TObject);
    procedure ImagesChanged(Sender: TObject);
    procedure setImageForm(newValue : TElImageForm);
    procedure setUseCustomGlyphs(newValue : Boolean);
    procedure setGlyph(newValue : TBitmap);
    procedure setAlignment(newValue : TLeftRight);

    procedure setSoundMap(newValue : TElSoundMap);

    procedure SetIsHTML(Value: Boolean);

    procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Msg : TMessage); message CM_MOUSEENTER;
//    procedure CMExit(var Msg : TCMExit); message CM_EXIT;
//    procedure CMEnter(var Msg : TCMEnter); message CM_ENTER;
    procedure CMTextChanged(var Msg : TMessage); message CM_TEXTCHANGED;
    procedure CMFocusChanged(var Msg : TCMFocusChanged); message CM_FOCUSCHANGED;
    procedure CMKillFocus(var Message: TWMSetFocus); message WM_KILLFOCUS;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetFlat(newValue : Boolean);
    procedure SetImages(Value: TCustomImageList);
    procedure SetAlphaImages(Value: TCustomImageList);
    procedure SetUseImageList(Value: Boolean);
    procedure SetWordWrap(const Value: Boolean);
  protected
    { Protected declarations }
    FFlatAlways: Boolean;
    FHandleDialogKeys: Boolean;
    FEndEllipsis: Boolean;
    FReadOnly: Boolean;
    FCheckMargin: Integer;
    procedure ChangeScale(M, D: Integer); override;
    procedure TranslateClick;
//    function GetPartId: Integer;
    function GetCheckBoxSize: TSize;
    procedure SetAutoSize(newValue : boolean);override;
    procedure DoEnter; override;
    procedure DoExit; override;

    procedure WMEraseBkgnd(var Msg : TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure Notification(AComponent : TComponent; operation : TOperation);
        override;
    procedure GlyphChange(Sender : TObject); virtual;
    procedure DrawFlatFrame(Canvas : TCanvas; R : TRect); virtual; abstract;
    procedure DrawGlyph(Canvas : TCanvas; DestRect: TRect; SrcRect: TRect); virtual;
    procedure MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure Paint; override;
    procedure SetFlatAlways(Value: Boolean);
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message
        WM_WINDOWPOSCHANGED;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;

    procedure CreateWnd; override;
    function CalcAutoHeight(Multiline : boolean) : Integer; virtual;
    procedure SetCursor(newValue : TCursor); virtual;
    function CalcTextRect: TRect;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure SetLinkPopupMenu(newValue : TPopupMenu);
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    procedure DoLinkPopup(MousePos : TPoint);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image
        : TBitmap);
    procedure TriggerLinkClickEvent(HRef : TLMDString); virtual;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadAlignment(Reader: TReader);
    procedure SetEndEllipsis(Value: Boolean);
    function CalcAutoSize(var ax, ay : integer): Boolean;
    procedure SetCheckMargin(Value: Integer);
    public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Click; override;
    property CheckSound : TElSoundName read FCheckSound write FCheckSound; { Protected }
    property SoundMap   : TElSoundMap read FSoundMap write SetSoundMap;

    property CheckAlignment : TLeftRight read FAlignment write SetAlignment default taRightJustify; { Protected }
    property UseCustomGlyphs : Boolean read FUseCustomGlyphs write SetUseCustomGlyphs default false; { Protected }
    property Glyph : TBitmap read FGlyph write SetGlyph; { Published }
    property Flat : Boolean read FFlat write SetFlat default false; { Published }
    property ImageForm : TElImageForm read FImgForm write SetImageForm;
    property AutoSize : boolean read FAutoSize write SetAutoSize default true;

    property IsHTML : Boolean read FIsHTML write SetIsHTML default false;

    // property Multiline: boolean read FMultiline write SetMultiline default false;
    property FlatAlways: Boolean read FFlatAlways write SetFlatAlways default false;
    property Images: TCustomImageList read FImages write SetImages;
    property AlphaForImages: TCustomImageList read FAlphaImages write SetAlphaImages;
    property UseImageList: Boolean read FUseImageList write SetUseImageList default
        false;
    property EndEllipsis: Boolean read FEndEllipsis write SetEndEllipsis default
        false;

    property Modified : boolean read FModified write FModified;

    property Cursor: TCursor read FCursor write SetCursor default crDefault;
    property LinkColor: TColor read FLinkColor write SetLinkColor default def_LMDLinkColor;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default def_LMDLinkStyle;

    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
  published
    property CheckMargin: Integer read FCheckMargin write SetCheckMargin default 5;
    property HandleDialogKeys: Boolean read FHandleDialogKeys write FHandleDialogKeys default false;
    property ReadOnly: Boolean read FReadOnly write FReadOnly default false;
    property WordWrap: Boolean read FWordWrap write SetWordWrap default false;
  end; { TElCheckItem }

  TElCheckBox = class(TElCheckItem)
  private
    { Private declarations }
    FState : TCheckBoxState;
    FAllowGrayed : Boolean;
    procedure SetState(newValue : TCheckBoxState);
    procedure SetAllowGrayed(newValue : Boolean);
  protected
    function GetChecked : Boolean; override;
    procedure SetChecked(newValue : Boolean); override;
    procedure DrawFlatFrame(Canvas : TCanvas; R : TRect); override;
    procedure Toggle; virtual;
  published
    property CheckAlignment;
    property AllowGrayed : Boolean read FAllowGrayed write SetAllowGrayed default false; { Published }
    property State : TCheckBoxState read FState write SetState default cbUnchecked; { Published }

    property EndEllipsis;
    property AutoSize;
    property UseCustomGlyphs;
    property Checked;

    property CheckSound;
    property SoundMap;

    property Glyph;
    property ImageForm;
    // property Multiline;
    property TextDrawType;
    property Transparent;
    property Flat;
    property FlatAlways;

    property IsHTML;

    property Images;
    property AlphaForImages;

    property Cursor;
    property LinkColor;
    property LinkPopupMenu;
    property LinkStyle;
    property OnImageNeeded;
    property OnLinkClick;
    property MoneyFlat;
    property MoneyFlatActiveColor;
    property MoneyFlatInactiveColor;
    property MoneyFlatDownColor;
    property UseImageList;

    // VCL properties
    property Caption;
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
    property ParentThemeMode default true;
    property ShowHint;
    property ThemeMode;
    property ThemeGlobalMode;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;

    property Anchors;
    property Action;
    property Constraints;

    property DockOrientation default doNoOrient;
    property Floating;
    property DoubleBuffered default False;
    property DragKind;
    property OnStartDock;
    property OnEndDock;

    property OnContextPopup;

  end; { TElCheckBox }

  TElRadioButton = class(TElCheckItem)
  private
    FChecked : boolean;
  protected
    FClicked: Boolean;
    procedure DrawFlatFrame(Canvas : TCanvas; R : TRect); override;
    function GetChecked : Boolean; override;
    procedure SetChecked(newValue : Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AutoSize;
    property Checked;
    property EndEllipsis;
    property Cursor;
    property LinkColor;
    property LinkPopupMenu;
    property LinkStyle;

    property OnImageNeeded;
    property OnLinkClick;
    property UseCustomGlyphs;

    property CheckSound;
    property SoundMap;

    property CheckAlignment;
    property Glyph;
    property ImageForm;
    property MoneyFlat;
    property MoneyFlatActiveColor;
    property MoneyFlatInactiveColor;
    property MoneyFlatDownColor;
    // property Multiline;
    property Transparent;
    property TextDrawType;
    property Flat;
    property FlatAlways;

    property IsHTML;

    property Images;
    property AlphaForImages;
    property UseImageList;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
    // VCL properties
    property Caption;
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
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;

    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;

    property Anchors;
    property Action;
    property Constraints;

    property DockOrientation default doNoOrient;
    property Floating;
    property DoubleBuffered;
    property DragKind;

    property OnStartDock;
    property OnEndDock;

    property OnContextPopup;

  end; { TElRadioButton }

var
  DefCheckMargin, CheckBoxSize, InitCheckBoxSize: integer;

implementation

const EllipsisFlags : array [boolean] of integer = (0, DT_END_ELLIPSIS);

procedure TElCheckItem.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

function TElCheckItem.CalcAutoHeight(Multiline : boolean): Integer;
var ay : integer;
    R : TRect;
    al : integer;

begin
  result := GetCheckBoxSize.cy;
  if not HandleAllocated then exit;
  if FUseCustomGlyphs and (not FGlyph.Empty) then
  begin
    ay := FGlyph.Height;
  end
  else
  begin
    if FUSeImageList then
    begin
      ay := FImages.Height;
    end
    else
    begin
      ay := GetCheckBoxSize.cy;
    end;
    end;
  inc(ay, 4);
  Canvas.Font.Assign(Font);
  SetRectEmpty(R);
  if not Multiline then
    AL := DT_SINGLELINE
  else
    AL := 0;
  if IsHTML then
  begin
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultBgColor := clNone;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.LinkColor := LinkColor;
    FRender.Data.LinkStyle := LinkStyle;
    FRender.Data.Charset := Font.Charset;

    FRender.PrepareText(FCaption, 0, false);
    R.Right  := FRender.Data.TextSize.cx;
    R.Bottom := FRender.Data.TextSize.cy;
  end
  else
  begin
    LMDDrawText(Canvas.Handle, Caption, Length(Caption), R, AL or DT_LEFT or DT_CALCRECT);
  end;
  ay := Max(ay, R.Bottom - R.Top + CheckMargin div 2);
  if TextDrawType <> tdtNormal then
    inc(ay, 2);
  result := ay;
end;

procedure TElCheckItem.AdjustAutoSize;
var ax, ay : integer;
begin
  if CalcAutoSize(ax, ay) then
    if HandleAllocated then
       SetBounds(Left, Top, ax, ay);
end;

(*
procedure TElCheckItem.SetMultiLine(value : boolean);
begin
  if FMultiline <> Value then
  begin
    FMultiline := Value;
    if FAutoSize then AdjustAutoSize;
    if Pos(#13#10, Caption) > 0 then Invalidate;
  end;
end;
*)
procedure TElCheckItem.SetAutoSize(newValue : boolean);
begin
  if FAutoSize <> newValue then
  begin
    FAutoSize := newValue;
    if FAutoSize and not (ComponentState * [csLoading, csReading] <> []) then
      AdjustAutoSize;
  end;
end;

procedure TElCheckItem.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      FImgForm.UnRegisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then FImgForm.RegisterChanges(FImgFormChLink);
    Invalidate;
  end;
end;

procedure TElCheckItem.SetUseCustomGlyphs(newValue : Boolean);
{ Sets data member FUseCutomGlyphs to newValue. }
begin
  if (FUseCustomGlyphs <> newValue) then
  begin
    FUseCustomGlyphs := newValue;
    if AutoSize then AdjustAutoSize;
    Invalidate;
  end; { if }
end; { SetUseCutomGlyphs }

procedure TElCheckItem.SetGlyph(newValue : TBitmap);
{ Sets data member FGlyph to newValue. }
begin
  FGlyph.Assign(newValue);
  FGlyph.Transparent := True;
end; { SetGlyph }

procedure TElCheckItem.SetAlignment(newValue : TLeftRight);
{ Sets data member FAlignment to newValue. }
begin
  if (FAlignment <> newValue) then
  begin
    FAlignment := newValue;
    Invalidate;
  end; { if }
end; { SetAlignment }

{$IFNDEF LMDCOMP7}
{------------------------------------------------------------------------------}
procedure PerformEraseBackground(Control: TControl; DC: HDC);
var
  LastOrigin: TPoint;
begin
  GetWindowOrgEx(DC, LastOrigin);
  SetWindowOrgEx(DC, LastOrigin.X + Control.Left, LastOrigin.Y + Control.Top, nil);
  Control.Parent.Perform(WM_ERASEBKGND, TLMDPtrInt(DC), TLMDPtrInt(DC));
  SetWindowOrgEx(DC, LastOrigin.X, LastOrigin.Y, nil);
end;
{$ENDIF}

{------------------------------------------------------------------------------}
procedure TElCheckItem.WMEraseBkGnd(var Msg : TWMEraseBkGnd);
var
  cRect : TRect;
begin
  if IsThemed and Transparent then
  begin
    if Assigned(Parent) and Parent.DoubleBuffered then
      PerformEraseBackground(Self, Msg.DC)
    else
      begin
        cRect := ClientRect;
        if UseThemeMode = ttmPlatform then
          ThemeServices.DrawParentBackground(Handle, Msg.DC, nil, False, @cRect)
        else
          LMDThemeServices.DrawThemeParentBackground(ttmNative, Handle, Msg.DC, @cRect);
      end;
    Msg.Result:=1;
    exit;
  end;
  Msg.Result := 1; { Return non-zero so windows doesn't step on our work. }
end; { WMEraseBkGnd }

procedure TElCheckItem.SetSoundMap(newValue : TElSoundMap);
begin
  if (FSoundMap <> newValue) then
  begin
    if FSoundMap <> nil then
      if not (csDestroying in FSoundMap.ComponentState) then
        FSoundMap.RemoveFreeNotification(Self);
    FSoundMap := newValue;
    if FSoundMap <> nil then
      FSoundMap.FreeNotification(Self);
  end; { if }
end; { SetSoundMap }

procedure TElCheckItem.Notification(AComponent : TComponent; operation :
    TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin

    if (AComponent = FSoundMap) then FSoundMap := nil;

   if (AComponent = FImages) then
     Images := nil;
   if (AComponent = FAlphaImages) then
     AlphaForImages := nil;
   if AComponent = LinkPopupMenu then
     LinkPopupMenu := nil;
   if AComponent = FImgForm then
    begin
      ImageForm := nil;
      Invalidate;
    end;

  end; { if }
end; { Notification }

procedure TElCheckItem.GlyphChange(Sender : TObject);
begin
  if AutoSize then AdjustAutoSize;
  if UseCustomGlyphs then Invalidate;
end;
{$WARNINGS off}

procedure TElCheckItem.Paint; { public }
var
  FDefaultImageNeed: Boolean;
  XRect,
  BgRect,
  RClip,
  R1,
  ARect : TRect;
  SrcRect,
  CheckRect : TRect;
  cbh,
  cbw   : integer;
  i     : integer;
  ACtl  : TWinControl;
  OldP,
  P     : TPoint;
  ax, ay: integer;
  al
  ,al2
  : integer;
  ImgIdx: integer;

  Canvas: TCanvas;
  Bitmap: TBitmap;
  PX    : TSize;
  AColor: COLORREF;
  BMP, amBMP : TBitmap;
  LDetail: TThemedButton;
  LThemeMode: TLMDThemeMode;
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);

begin
  Bitmap := TBitmap.Create;
  Bitmap.Width := ClientWidth;
  Bitmap.Height := ClientHeight;
  Canvas := Bitmap.Canvas;
  Bitmap.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientWidth, ClientHeight);
  LThemeMode := UseThemeMode;
  if (LThemeMode <> ttmNone) then
  with Bitmap do
  begin
    begin
      P := Point(Left, Top);
      SetMapMode(Self.Canvas.Handle, MM_ANISOTROPIC);
      SetViewPortOrgEx(Self.Canvas.Handle, -P.x, -P.y, @OldP);
      SendMessage(Parent.Handle, WM_ERASEBKGND, Self.Canvas.Handle, Self.Canvas.Handle);
      SetViewPortOrgEx(Self.Canvas.Handle, OldP.x, OldP.y, nil);
      SetMapMode(Self.Canvas.Handle, MM_TEXT);
      ARect := ClientRect;
      bitblt(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top, Self.Canvas.Handle, ARect.Left, ARect.Top, SRCCOPY);
    end;
  end
  else
  if (not Self.Transparent) then
  begin
    if (FImgForm <> nil) and (not (csDesigning in FImgForm.ComponentState)) then
    begin
      if (FImgForm.Control <> Self) then
      begin
        ACtl := FImgForm.GetRealControl;
        BgRect := ClientRect;
        R1 := BgRect;
        BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);
        P := Parent.ClientToScreen(Point(Left, Top));
        ax := BgRect.Left - P.x;
        ay := BgRect.Top - P.y;

        BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
        BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
        BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

        FImgForm.PaintBkgnd(Canvas.Handle, R1, Point(BgRect.Left - ax, BgRect.Top - ay), false);
      end
    end
    else
    begin
      Canvas.Brush.Color := Color;
      Canvas.FillRect(ClientRect);
    end;
  end
  else
  begin
    GetClipBox(Self.Canvas.Handle, ARect);
    OffsetRect(ARect, Left, Top);
    if Assigned(parent) then
      SendMessage(parent.Handle, WM_ERASEBKGND, Canvas.Handle, 0);
//    RedrawWindow(Parent.Handle, @ARect, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);
    OffsetRect(ARect, -Left, -Top);
    bitblt(Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top, Self.Canvas.Handle, ARect.Left, ARect.Top, SRCCOPY);
  end;
  ARect := ClientRect;
  ImgIdx := 0;
  FDefaultImageNeed := false;
  if (not (LThemeMode <> ttmNone)) or ((FUseCustomGlyphs and (not FGlyph.Empty)) or FUseImageList) then
  begin
    if FUseCustomGlyphs and (not FGlyph.Empty) then
    begin
      cbh := FGlyph.Height;
      cbw := FGlyph.Width div 6;

      if Self is TElRadioButton then
      begin
        if not Checked then
        begin
          if Enabled and (not (FPressed and FMouseInControl))
          then
            SrcRect := Rect(0, 0, cbw, cbh)
          else
            SrcRect := Rect(cbw, 0, cbw * 2, cbh);
        end
        else
        begin
          if Enabled and (not (FPressed and FMouseInControl))
          then
            SrcRect := Rect(cbw * 2, 0, cbw * 3, cbh)
          else
            SrcRect := Rect(cbw * 3, 0, cbw * 4, cbh);
        end;
      end
      else
      if Self is TElCheckBox then
      begin
        case TElCheckBox(Self).State of
          cbUnchecked :
            if Enabled and (not (FPressed and FMouseInControl))
            then
              SrcRect := Rect(0, 0, cbw, cbh)
            else
              SrcRect := Rect(cbw, 0, cbw * 2, cbh);
          cbChecked :
            if Enabled and (not (FPressed and FMouseInControl))
            then
              SrcRect := Rect(cbw * 2, 0, cbw * 3, cbh)
            else
              SrcRect := Rect(cbw * 3, 0, cbw * 4, cbh);
          cbGrayed :
            if Enabled and (not (FPressed and FMouseInControl))
            then
              SrcRect := Rect(cbw * 4, 0, cbw * 5, cbh)
            else
              SrcRect := Rect(cbw * 5, 0, cbw * 6, cbh);
        end;
      end
      else
      begin
        cbh := 0;
        cbw := 0;
        SrcRect := Rect(0, 0, 0, 0);
      end;
    end
    else
    begin
      if FUseImageList and Assigned(FImages) then
      begin
        cbw := FImages.Width;
        cbh := FImages.Height;
        if Self is TElRadioButton then
        begin
          if not Checked then
          begin
            if Enabled and (not (FPressed and FMouseInControl))
            then
              ImgIdx := 0
            else
              ImgIdx := 1;
          end
          else
          begin
            if Enabled and (not (FPressed and FMouseInControl))
            then
              ImgIdx := 2
            else
              ImgIdx := 3;
          end;
        end
        else
        if Self is TElCheckBox then
        begin
          case TElCheckBox(Self).State of
            cbUnchecked :
              if Enabled and (not (FPressed and FMouseInControl))
              then
                ImgIdx := 0
              else
                ImgIdx := 1;
            cbChecked :
              if Enabled and (not (FPressed and FMouseInControl))
              then
                ImgIdx := 2
              else
                ImgIdx := 3;
            cbGrayed :
              if Enabled and (not (FPressed and FMouseInControl))
              then
                ImgIdx := 4
              else
                ImgIdx := 5;
          end;
        end;
      end
      else
      begin
        cbw := GetCheckBoxSize.cx;
        cbh := GetCheckBoxSize.cy;
        FDefaultImageNeed := True;
      end;
      i := DFCS_BUTTONCHECK or DFCS_CHECKED;
      if Self is TElRadioButton then
      begin
        if Checked
          then
          i := DFCS_BUTTONRADIO or DFCS_CHECKED
        else
          i := DFCS_BUTTONRADIO;
      end
      else if Self is TElCheckBox then
      begin
        case TElCheckBox(Self).State of
          cbChecked : i := DFCS_BUTTONCHECK or DFCS_CHECKED;
          cbUnchecked : i := DFCS_BUTTONCHECK;
          cbGrayed : i := DFCS_BUTTON3STATE or DFCS_CHECKED;
        end; // case
      end;
      if (not Enabled) or (FMouseInControl and FPressed) then
        i := i or DFCS_INACTIVE;
    end;

  if (CheckAlignment = taRightJustify) xor UseRightToLeftAlignment then
    begin
      {$ifdef LMD_UNICODE}
      if LMDWidePos(WideString(#13#10), Caption) = 0 then
      {$else}
      if Pos(#13#10, Caption) = 0 then
      {$endif}
      begin
        CheckRect := Rect(0, (ClientHeight div 2 - cbh div 2), cbw, 0);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end
      else
      begin
        CheckRect := Rect(0, 0, cbw, 0);
        CheckRect.Top := (CalcAutoHeight(false) div 2 - cbh div 2);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end;
    end
    else
    begin
      {$ifdef LMD_UNICODE}
      if LMDWidePos(WideString(#13#10), Caption) = 0 then
      {$else}
      if Pos(#13#10, Caption) = 0 then
      {$endif}
      begin
        CheckRect := Rect(Width - cbw, (ClientHeight div 2 - cbh div 2), Width, 0);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end
      else
      begin
        CheckRect        := Rect(Width - cbw, 0, Width, 0);
        CheckRect.Top    := (CalcAutoHeight(false)  div 2 - cbh div 2);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end;
    end;
    if UseCustomGlyphs and (not FGlyph.Empty) then DrawGlyph(Canvas, CheckRect, SrcRect)
    else
    begin
      if FUseImageList then
      begin
        if (FAlphaImages <> nil) and (FAlphaImages.Count > ImgIdx) then
        begin
          BMP := TBitmap.Create;
          BMP.Width := FImages.Width;
          BMP.Height := FImages.Height;
          ImageList_DrawEx(FImages.Handle, ImgIdx, BMP.Canvas.Handle, 0, 0, 0, 0,
            clNone, clNone, ILD_Normal);

          amBMP := TBitmap.Create;
          amBMP.Width := FAlphaImages.Width;
          amBMP.Height := FAlphaImages.Height;
          ImageList_DrawEx(FAlphaImages.Handle, ImgIdx, amBMP.Canvas.Handle, 0, 0, 0, 0,
            clNone, clNone, ILD_Normal);

          LMDAlphaCopyRect2(Canvas.Handle, CheckRect, BMP.Canvas.Handle,
            rect(0, 0, BMP.Width, BMP.Height), amBMP, 255);

          amBMP.Free;
          BMP.Free;
        end
        else
        FImages.Draw(Canvas, CheckRect.Left, CheckRect.Top, ImgIdx);
      end
      else
      begin
        FDefaultImageNeed := True;
        if not (LThemeMode <> ttmNone) then
        begin
          DrawFrameControl(Canvas.Handle, CheckRect, DFC_BUTTON, i);
          if MoneyFlat or (Flat and (not (Focused or FMouseInControl or FPressed) or FlatAlways)) {and Enabled} then
            DrawFlatFrame(Canvas, CheckRect);
        end;
      end;
    end;
  end
  else // XP-style checkmarks
    FDefaultImageNeed := True;
  if (LThemeMode <> ttmNone) then
  begin
    if Self is TElCheckBox then
    begin
      LDetail := tbCheckBoxUncheckedNormal;
      case TElCheckBox(Self).State of
        cbUnchecked :
          if not Enabled then
            LDetail := tbCheckBoxUncheckedDisabled
          else
          if FPressed then
            LDetail := tbCheckBoxUncheckedPressed
          else
          if FMouseInControl then
            LDetail := tbCheckBoxUncheckedHot
          else
            LDetail := tbCheckBoxUncheckedNormal;

        cbChecked :
          if not Enabled then
            LDetail := tbCheckBoxCheckedDisabled
          else
          if FPressed then
            LDetail := tbCheckBoxCheckedPressed
          else
          if FMouseInControl then
            LDetail := tbCheckBoxCheckedHot
          else
            LDetail := tbCheckBoxCheckedNormal;

        cbGrayed :
          if not Enabled then
            LDetail := tbCheckBoxMixedDisabled
          else
          if FPressed then
            LDetail := tbCheckBoxMixedPressed
          else
          if FMouseInControl then
            LDetail := tbCheckBoxMixedHot
          else
            LDetail := tbCheckBoxMixedNormal;
      end;
    end
    else
    begin
      if not Checked then
      begin
        if not Enabled then
          LDetail := tbRadioButtonUncheckedDisabled
        else
        if FPressed then
        begin
          if FMouseInControl then
            LDetail := tbRadioButtonUncheckedPressed
          else
            LDetail := tbRadioButtonUncheckedHot;
        end
        else
        if FMouseInControl then
          LDetail := tbRadioButtonUncheckedHot
        else
          LDetail := tbRadioButtonUncheckedNormal;
      end
      else
      begin
        if not Enabled then
          LDetail := tbRadioButtonCheckedDisabled
        else
        if FPressed then
          LDetail := tbRadioButtonCheckedPressed
        else
        if FMouseInControl then
          LDetail := tbRadioButtonCheckedHot
        else
          LDetail := tbRadioButtonCheckedNormal;
      end;
    end;
  end;
  if (LThemeMode <> ttmNone) and FDefaultImageNeed then
  begin
    PX.cx := 0;
    PX.cy := 0;

    ARect := ClientRect;
    cbw := GetCheckBoxSize.cx;
    cbh := GetCheckBoxSize.cy;

    if (CheckAlignment = taRightJustify) xor UseRightToLeftAlignment  then
    begin
      {$ifdef LMD_UNICODE}
      if LMDWidePos(WideString(#13#10), Caption) = 0 then
      {$else}
      if Pos(#13#10, Caption) = 0 then
      {$endif}
      begin
        CheckRect := Rect(0, (ClientHeight div 2 - cbh div 2), cbw, 0);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end
      else
      begin
        CheckRect := Rect(0, 0, cbw, 0);
        CheckRect.Top := (CalcAutoHeight(false) div 2 - cbh div 2);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end;
    end
    else
    begin
      {$ifdef LMD_UNICODE}
      if LMDWidePos(WideString(#13#10), Caption) = 0 then
      {$else}
      if Pos(#13#10, Caption) = 0 then
      {$endif}
      begin
        CheckRect := Rect(Width - cbw, (ClientHeight - cbh) div 2 + ClientHeight mod 2, Width, 0);
        CheckRect.Bottom := CheckRect.Top + cbh;
      end
      else
      begin
        CheckRect        := Rect(Width - cbw, 0, Width, 0);
        CheckRect.Top    := (CalcAutoHeight(false) div 2 - cbh div 2)  + ClientHeight mod 2;
        CheckRect.Bottom := CheckRect.Top + cbh;
      end;
    end;
    RClip := Canvas.ClipRect;
    LMDThemeServices.DrawElement(LThemeMode, Bitmap.Canvas.Handle, ThemeServices.GetElementDetails(LDetail), CheckRect, LMDRectToPtr(RClip));
  end;

  if (LThemeMode <> ttmNone) then
  begin
    AL := WordWraps[FWordWrap];
    Canvas.Font.Assign(Font);
    if IsHTML then
    begin
      AColor := LMDThemeServices.GetThemeSysColor(LThemeMode, teButton, COLOR_BTNTEXT);;

      FRender.Data.DefaultColor := AColor;
      FRender.Data.DefaultBgColor := clNone;
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := LinkColor;
      FRender.Data.LinkStyle := LinkStyle;

      XRect.Left := 0;
      XRect.Top  := 0;
      if FWordWrap then
        FRender.PrepareText(FCaption, Width, true)
      else
        FRender.PrepareText(FCaption, 0, false);
      XRect.Right := FRender.Data.TextSize.cx;
      XRect.Bottom := FRender.Data.TextSize.cy;
    end
    else
    begin
      ARect := ClientRect;
      if (CheckAlignment = taRightJustify) xor UseRightToLeftAlignment then
        ARect.Left := ARect.Left + cbw + CheckMargin
      else
        ARect.Right := ARect.Right - cbw - CheckMargin;

      LMDThemeServices.GetThemeTextExtent(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail), PWideChar(WideString(Caption)), Length(WideString(Caption)), Al, LMDRectToPtr(ARect), XRect);
    end;
    ARect := ClientRect;

    if (CheckAlignment = taRightJustify) xor UseRightToLeftAlignment then
      ARect.Left := ARect.Left + cbw + CheckMargin
    else
      ARect.Right := ARect.Right - cbw - CheckMargin;

    ARect.Bottom := XRect.Bottom;
    OffsetRect(ARect, 0, (ClientHeight - XRect.Bottom) div 2);

    Canvas.Brush.Style := bsClear;
    {if not FMultiLine then
       AL := DT_SINGLELINE
    else
       }//AL := 0;

    if IsHTML then
    begin
      FTextPos := ARect.TopLeft;
      if (ARect.Bottom > ARect.top) and (ARect.right > ARect.Left) then
        FRender.DrawText(Canvas, Point(0, 0), ARect, clNone);
    end
    else
    begin
      if not Enabled then
        AL2 := 1
      else
        AL2 := 0;
      LMDThemeServices.DrawThemeText(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail), PWideChar(WideString(Caption)), Length(WideString(Caption)), AL, AL2, ARect);
    end;

    if (Focused {and FDoFocus}) and Enabled and (Length(Caption) > 0) and (UIStateDrawFocus) then
    begin
      Canvas.Brush.Style := bsSolid;
      if IsHTML then
      begin
        // FRender.PrepareText(FCaption, 0, false);
        ARect.Right := ARect.Left + FRender.Data.TextSize.cx;
        ARect.Bottom := ARect.Top + FRender.Data.TextSize.cy;
      end
      else
      begin
        AL := WordWraps[FWordWrap];
        LMDThemeServices.GetThemeTextExtent(LThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(LDetail), PWideChar(WideString(Caption)), Length(Caption), AL, LMDRectToPtr(ARect), XRect);
        ARect.Right := ARect.Left + (XRect.Right - XRect.Left);
        ARect.Bottom := ARect.Top + (XRect.Bottom - XRect.Top);
      end;
      ARect.Bottom := ARect.Bottom - ARect.Top;//Canvas.TextHeight(Caption);
      ARect.Top := 0;
      OffsetRect(ARect, 0, (ClientHeight - ARect.Bottom) div 2);

      i := ARect.Right - ARect.Left;
      if (CheckAlignment = taRightJustify) xor UseRightToLeftAlignment then
      begin
        ARect.Right := ARect.Left + i;
        InflateRect(ARect, 1, 1);
      end
      else
      begin
        ARect.Left := ARect.Right - i;
        InflateRect(ARect, 1, 1);
        Inc(ARect.Left);
      end;

      case TextDrawType of
        tdtNormal: OffsetRect(ARect, 1, 0);
        tdtShadowed :
          begin
            OffsetRect(ARect, 1, 1);
            Inc(ARect.Right);
          end;
        tdtRaised :
            OffsetRect(ARect, 1, -1);
      end;
      OffsetRect(ARect, -1, 0);
      Canvas.DrawFocusRect(ARect);
    end;
  end
  else
  begin
    if (CheckAlignment = taRightJustify) xor UseRightToLeftAlignment
    then
      ARect.Left := ARect.Left + cbw + CheckMargin
    else
      ARect.Right := ARect.Right - cbw - CheckMargin;
    ARect.Top := 0;

    Canvas.Font.Assign(Font);

    SetRectEmpty(XRect);
    AL := WordWraps[FWordWrap];
    if IsHTML then
    begin
      FRender.Data.DefaultColor := Font.Color;
      FRender.Data.DefaultBgColor := clNone;
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultHeight := Font.Height;
      FRender.Data.DefaultFont := Font.Name;
      FRender.Data.Charset := Font.Charset;
      FRender.Data.LinkColor := LinkColor;
      FRender.Data.LinkStyle := LinkStyle;

      XRect.Left := 0;
      XRect.Top  := 0;
      if WordWrap then
        FRender.PrepareText(FCaption, Width, True)
      else
        FRender.PrepareText(FCaption, 0, false);
      XRect.Right := FRender.Data.TextSize.cx;
      XRect.Bottom := FRender.Data.TextSize.cy;
    end
    else
    begin
      XRect := ClientRect;
      LMDDrawText(Canvas.Handle, Caption, Length(Caption), XRect, AL or DT_LEFT or DT_CALCRECT);
    end;
    ARect.Bottom := XRect.Bottom;
    OffsetRect(ARect, 0, (ClientHeight - XRect.Bottom) div 2);
    Canvas.Brush.Style := bsClear;
    if not UIStateDrawAccel then
      AL := WordWraps[FWordWrap] or DT_HIDEPREFIX
    else
      AL := WordWraps[FWordWrap];
    if IsHTML then
    begin
      FTextPos := ARect.TopLeft;
      FRender.DrawText(Canvas, Point(0, 0), ARect, clNone);
      end
    else
    begin
      FTextPos := ARect.TopLeft;
      if not Enabled then
      begin
        OffsetRect(ARect, 1, 1);

        Canvas.Font.Color := clBtnHighlight;
        LMDDrawText(Canvas.Handle, Caption, Length(Caption), ARect, AL or DT_LEFT or DT_VCENTER or EllipsisFlags[EndEllipsis]);

        OffsetRect(ARect, -1, -1);
        Canvas.Font.Color := clBtnShadow;
        LMDDrawText(Canvas.Handle, Caption, Length(Caption), ARect, AL or DT_LEFT or DT_VCENTER or EllipsisFlags[EndEllipsis]);
      end
      else
      begin
        Canvas.Font.Color := Font.Color;
        {$ifdef LMD_UNICODE}
        LMDDrawTypedTextW(Canvas, ARect, Caption,
        {$else}
        LMDDrawTypedText(Canvas, ARect, Caption,
        {$endif}
        AL or DT_LEFT or DT_VCENTER or EllipsisFlags[EndEllipsis], TextDrawType);
      end;
    end;
    if (Focused or FJustLooseFocus{and FDoFocus}) and Enabled and (Length(Caption) > 0) and (UIStateDrawFocus) then
    begin
      Canvas.Brush.Style := bsSolid;

      // Recalculate text position
      AL := WordWraps[FWordWrap];
      if IsHTML then
      begin
        // FRender.PrepareText(FCaption, 0, false);
        ARect.Right := ARect.Left + FRender.Data.TextSize.cx;
        ARect.Bottom := ARect.Top + FRender.Data.TextSize.cy;
      end
      else
        LMDDrawText(Canvas.Handle, Caption, -1, ARect, AL or DT_LEFT or DT_VCENTER or DT_CALCRECT);

      ARect.Bottom := ARect.Bottom - ARect.Top;//Canvas.TextHeight(Caption);
      ARect.Top := 0;
      OffsetRect(ARect, 0, (ClientHeight - ARect.Bottom) div 2);
      i := ARect.Right - ARect.Left;

      if (CheckAlignment = taRightJustify) xor UseRightToLeftAlignment then
      begin
        ARect.Right := ARect.Left + i;
        InflateRect(ARect, 1, 1);
      end
      else
      begin
        ARect.Left := ARect.Right - i;
        InflateRect(ARect, 1, 1);
        Inc(ARect.Left);
      end;

      case TextDrawType of
        tdtNormal: OffsetRect(ARect, 1, 0);
        tdtShadowed :
          begin
            OffsetRect(ARect, 1, 1);
            Inc(ARect.Right);
          end;
        tdtRaised :
            OffsetRect(ARect, 1, -1);
      end;

        OffsetRect(ARect, -1, 0);
        if Focused then
          Canvas.DrawFocusRect(ARect);
      end;
    end;
    FJustLooseFocus := False;
    // FDoFocus := not FDoFocus;
    bitblt(Self.Canvas.Handle, 0, 0, ClientWidth, ClientHeight, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
    Bitmap.Free;
  end; { Paint }
{$WARNINGS on}

procedure TElCheckItem.DoEnter;
begin
  inherited;
  if Self is TElRadioButton then
  begin
    if (not Checked) and not TElRadioButton(Self).FClicked then
    begin
      Checked := true;
    end;
    TElRadioButton(Self).FClicked := False;
//    if Assigned(OnClick) then
//      OnClick(self);
    Invalidate;
  end
  else
    Invalidate;
end;

procedure TElCheckItem.DoExit;
begin
  inherited;
  if not HandleAllocated then exit;
  if Transparent then
    FJustLooseFocus := True;
  Invalidate;
end;

procedure TElCheckItem.SetFlat(newValue : Boolean);
{ Sets data member FFlat to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    if (not UseCustomGlyphs) then Invalidate;
  end; { if }
end; { SetFlat }

procedure TElCheckItem.CMMouseLeave(var Msg : TMessage); { private }
begin
  inherited Cursor := FCursor;
  inherited;
  FMouseInControl := false;
  if MoneyFlat or (Flat and (not FlatAlways) and (not UseCustomGlyphs)) or FPressed  or (IsThemed) then
  begin
    // FDoFocus := focused;
    Invalidate;
  end;
end; { CMMouseLeave }

procedure TElCheckItem.CMMouseEnter(var Msg : TMessage); { private }
begin
  inherited;
  FMouseInControl := true;
  if MoneyFlat or (Flat and (not FlatAlways) and (not UseCustomGlyphs)) or FPressed or (IsThemed) then
  begin
    // FDoFocus := focused;
    Invalidate;
  end;
end; { CMMouseEnter }

(*
procedure TElCheckItem.CMExit(var Msg : TCMExit); { private }
begin
  inherited;
  Invalidate;
end; { CMExit }

procedure TElCheckItem.CMEnter(var Msg : TCMEnter); { private }
begin
  inherited;
  {if Self is TElRadioButton then
  begin
    //FDoFocus := true;
    if not Checked then
      Checked := true
    else
      Invalidate;
  end
  else}
    Invalidate;
end; { CMEnter }
*)

procedure TElCheckItem.CMTextChanged(var Msg : TMessage); { private }
begin
  inherited;
  if AutoSize then
    AdjustAutoSize;
  Invalidate;
end; { CMTextChanged }

procedure TElCheckItem.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }

var
  P : TPoint;
  R : TRect;
  href : TLMDString;

begin
  if IsHTML then
  begin
    P.x := X;
    P.y := Y;
    R := CalcTextRect;
    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
      exit;
  end;
  if Button = mbLeft then
  begin
//    if CanFocus then
//      SetFocus;
    FPressed := true;
  end;
  FOldCapture := GetCapture;
  if FOldCapture = Handle then
    FOldCapture := 0;
  SetCapture(Handle);
  // FDoFocus := focused;
  Invalidate;
  inherited;
end; { MouseDown }

procedure TElCheckItem.MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); { protected }
begin
  if FPressed then
  begin
    if PtInRect(ClientRect, Point(X, Y)) then
    begin
      if Button = mbLeft then
      begin
        if CanFocus then
          SetFocus;
      end;
      FPressed := false;
  if not ReadOnly then
        if SoundMap <> nil then
          SoundMap.Play(FCheckSound);
  end
    else
    begin
      FPressed := false;
      if FOldCapture <> 0 then
        SetCapture(FOldCapture)
      else
        ReleaseCapture;
      FOldCapture := 0;
      end;
    // FDoFocus := Focused;
    Invalidate;
  end;
  inherited;
end; { MouseUp }

procedure TElCheckItem.KeyDown(var Key : Word; Shift : TShiftState); { protected }
begin
  inherited;
  if (Key = VK_SPACE) and (Shift = []) then
  begin
    if not ReadOnly then
    begin
      if (Self is TElCheckBox) then
      begin
        if SoundMap <> nil then SoundMap.Play(FCheckSound);
        // FDoFocus := true;
        Click;
      end
      else
      if Self is TElRadioButton then
        Click;
    end;
  end;
end; { KeyDown }

procedure TElCheckItem.Click;
var
  State : TCheckBoxState;
  P : TPoint;
  R : TRect;
  href : TLMDString;
begin
  if IsHTML then
  begin
    GetCursorPos(P);
    P := ScreenToClient(P);
    R := CalcTextRect;

    if IsHTML and FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
    begin
      TriggerLinkClickEvent(href);
      exit;
    end;
  end;
  if not ReadOnly then
  begin
    if Self is TElCheckBox then
    begin
      State := TElCheckBox(Self).State;
      case State of
        cbChecked : Checked := false;
        cbGrayed : Checked := true;
        cbUnchecked :
          if TElCheckBox(Self).AllowGrayed then
            TElCheckBox(Self).State := cbGrayed
          else
            Checked := true;
      end;
      Modified := true;
    end
    else if Self is TElRadioButton then
    begin
      // FDoFocus := focused;
      if not Checked then
      begin
        Checked := true;
        TElRadioButton(Self).FClicked := True;
//        if (not ClicksDisabled) then Click;
        Modified := true;
      end
      else
        Invalidate;
    end;
    inherited Changed;
//    inherited Click;
  end;
end;

procedure TElCheckItem.Loaded;
begin
  inherited;
  if AutoSize then
  begin
    FAutoSize := false;
    AutoSize := true;
  end;
  if UseImageList then
  if FImages = nil then
    UseImageList := false;
end;

procedure TElCheckItem.CMFocusChanged(var Msg : TCMFocusChanged);  { private }

begin
  inherited;
  if Msg.Sender = Self then
  begin
    // FDoFocus := Focused;
    Invalidate;
  end;
end;  { CMFocusChanged }

procedure TElCheckItem.CMFontChanged(var Message: TMessage);
begin
  inherited;
  if AutoSize then
    AdjustAutoSize;
end;

destructor TElCheckItem.Destroy;
begin

  if FRender <> nil then
    FRender.Free;
  FRender := nil;

  ImageForm := nil;
  FGlyph.Free;
  FImgFormChLink.Free;
  FChLink.Free;
  FAChLink.Free;
  inherited Destroy;
end; { Destroy }

constructor TElCheckItem.Create(AOwner : TComponent);
{ Creates an object of type TElCheckItem, and initializes properties. }
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csSetCaption] - [csDoubleClicks];
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := GlyphChange;
  Height := 17;
  Width := 60;
  FAlignment := taRightJustify;
  FImgFormChLink  := TImgFormChangeLink.Create; FImgFormChLink.OnChange := ImageFormChange;
  FChLink  := TChangeLink.Create; FChLink.OnChange := ImagesChanged;
  FAChLink  := TChangeLink.Create; FAChLink.OnChange := ImagesChanged;
  FAutoSize := true;

  FJustLooseFocus := False;

  FIsHTML:=false;
  FLinkStyle := def_LMDLinkStyle;
  FLinkColor := def_LMDLinkColor;

  TabStop := true;
  FCheckMargin := DefCheckMargin;
  ParentColor := True;
  //UseXPThemes := true;
end; { Create }

procedure TElCheckBox.DrawFlatFrame(Canvas : TCanvas; R : TRect);
var AColor, Color : TColor;
begin
  if MoneyFlat then
  begin
    if Enabled and not FPressed then
      Color := clWindow
    else
      Color := clBtnFace;
    if FPressed then
      AColor := Self.MoneyFlatDownColor
    else
    if Focused or FMouseInControl then
      AColor := MoneyFlatActiveColor
    else
      AColor := MoneyFlatInactiveColor;
    ELVCLUtils.DrawFlatFrameEx2(Canvas.Handle, R, AColor, Color, false, true, AllBorderSides, fbtColorLineBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
  end
  else
  if Enabled and not FPressed then
    ElVCLUtils.DrawFlatFrame(Canvas.Handle, R, clWindow, false)
  else
    ElVCLUtils.DrawFlatFrame(Canvas.Handle, R, clBtnFace, false);
end;

function TElCheckBox.GetChecked : Boolean;
{ Returns the value of data member FChecked. }
begin
  result := FState = cbChecked;
end; { GetChecked }

procedure TElCheckBox.SetChecked(newValue : Boolean);
{ Sets data member FChecked to newValue. }
begin
  if newValue then
    SetState(cbChecked)
  else
    SetState(cbUnchecked);
end; { SetChecked }

procedure TElCheckBox.SetState(newValue : TCheckBoxState);
{ Sets data member FState to newValue. }
begin
  if (FState <> newValue) then
  begin
    if AllowGrayed or (newValue <> cbGrayed) then
    begin
      FState := newValue;
      // FDoFocus := Focused;
      if not ClicksDisabled then TranslateClick;
      Invalidate;
    end;
  end; { if }
end; { SetState }

procedure TElCheckBox.SetAllowGrayed(newValue : Boolean);
{ Sets data member FAllowGrayed to newValue. }
begin
  if (FAllowGrayed <> newValue) then
  begin
    FAllowGrayed := newValue;
    if (not NewValue) and (FState = cbGrayed) then SetState(cbUnchecked);
  end; { if }
end; { SetAllowGrayed }

procedure TElCheckBox.Toggle;
begin
  case State of
    cbUnchecked:
      if AllowGrayed then State := cbGrayed else State := cbChecked;
    cbChecked: State := cbUnchecked;
    cbGrayed: State := cbChecked;
  end;
end;

constructor TElRadioButton.Create(AOwner: TComponent);
begin
  inherited;
  TabStop := False;
  FClicked := false;
end;

procedure TElRadioButton.DrawFlatFrame(Canvas : TCanvas; R : TRect);
var
  i : integer;
  Color : TColor;
  AColor: TColor;
  R1: TRect;
  MyRgn: HRGN;
const
  points : array[0..27] of TPoint = ((x : 1; y : 4), (x : 1; y : 5), (x : 1; y : 6), (x : 1; y : 7),
    (x : 2; y : 2), (x : 2; y : 3), (x : 2; y : 8),
    (x : 3; y : 2), (x : 4; y : 1), (x : 5; y : 1), (x : 6; y : 1), (x : 7; y : 1),
    (x : 8; y : 2), (x : 9; y : 2),

    (x : 2; y : 9), (x : 3; y : 9),
    (x : 4; y : 10), (x : 5; y : 10), (x : 6; y : 10), (x : 7; y : 10),
    (x : 8; y : 9), (x : 9; y : 9), (x : 9; y : 8),
    (x : 10; y : 7), (x : 10; y : 6), (x : 10; y : 5),
    (x : 10; y : 4), (x : 9; y : 3)
    );

  Apoints : array[0..31] of TPoint = ((x : 0; y : 4), (x : 0; y : 5), (x : 0; y : 6), (x : 0; y : 7),
    (x : 1; y : 2), (x : 1; y : 3), (x : 1; y : 8), (x : 1; y : 9),

    (x : 2; y : 1), (x : 3; y : 1), (x : 4; y : 0), (x : 5; y : 0), (x : 6; y : 0), (x : 7; y : 0),
    (x : 8; y : 1), (x : 9; y : 1),

    (x : 2; y : 10), (x : 3; y : 10),
    (x : 4; y : 11), (x : 5; y : 11), (x : 6; y : 11), (x : 7; y : 11),
    (x : 8; y : 10), (x : 9; y : 10),
    (x : 10; y : 9), (x : 10; y : 8),
    (x : 11; y : 7), (x : 11; y : 6), (x : 11; y : 5), (x : 11; y : 4),
    (x : 10; y : 3), (x : 10; y : 2)
    );

begin
  if MoneyFlat then
  begin
    if Enabled and not FPressed then
      Color := clWindow
    else
      Color := clBtnFace;
    if FPressed then
      AColor := Self.MoneyFlatDownColor
    else
    if Focused or FMouseInControl then
      AColor := MoneyFlatActiveColor
    else
      AColor := MoneyFlatInactiveColor;
    if Screen.PixelsPerInch = 96 then
    begin
      for i := 0 to 27 do
      begin
        Canvas.Pixels[R.Left + Points[i].x + 1, R.Top + Points[i].y] := Color;
      end;
      for i := 0 to 31 do
      begin
        Canvas.Pixels[R.Left + APoints[i].x + 1, R.Top + APoints[i].y] := AColor;
      end;
    end
    else
    begin
      Canvas.Brush.Color := Color;
      Canvas.Pen.Color := AColor;
      MyRgn := CreateRoundRectRgn(R.Left + 3, R.Top + 3 , R.Right - 3, R.Bottom - 3, R.Bottom - R.Top - 2, R.Bottom - R.Top - 2);
      ExtSelectClipRgn(Canvas.Handle, MyRgn, RGN_DIFF);
      Canvas.Ellipse(R);
      DeleteObject(MyRgn);
    end;
  end
  else
  begin
    if Enabled and not FPressed then
      AColor := clWindow
    else
      AColor := clBtnFace;

    if Screen.PixelsPerInch = 96 then
    begin
      for i := 0 to 27 do
      begin
        Canvas.Pixels[R.Left + Points[i].x + 1, R.Top + Points[i].y] := AColor;
      end;
    end
    else
    begin
      R1 := R;
      InflateRect(R1, -1, -1);
      Canvas.Brush.Color := AColor;
      Canvas.Pen.Color := AColor;
      Canvas.Pen.Style := psDash;
      MyRgn := CreateRoundRectRgn(R1.Left + 2, R1.Top + 2 , R1.Right - 2, R1.Bottom - 2, R1.Bottom-R1.Top - 2, R1.Bottom-R1.Top - 2);
      ExtSelectClipRgn(Canvas.Handle, MyRgn, RGN_DIFF);
      Canvas.Ellipse(R1.Left, R1.Top, R1.Right, R1.Bottom);
      Canvas.Pen.Color := clBtnShadow;
      Canvas.Arc(R1.Left, R1.Top, R1.Right, R1.Bottom, R1.Right, R1.Top, R1.Left, R1.Bottom);
      DeleteObject(MyRgn);
    end;
  end;
end;

function TElRadioButton.GetChecked : Boolean;
{ Returns the value of data member FChecked. }
begin
  result := FChecked;
end; { GetChecked }

procedure TElRadioButton.SetChecked(newValue : Boolean);
var
  i : Integer;
  C : TControl;
begin
  if FChecked <> newValue then
  begin
    FChecked := newValue;
    TabStop := newValue;
    if newValue then
    begin
      if Parent <> nil then
        with Parent do
          for i := 0 to ControlCount - 1 do
          begin
            C := Controls[i];
            if (C <> Self) and (C is TElRadioButton) then TElRadioButton(C).SetChecked(False);
          end; { for }
      if not ClicksDisabled then
      begin
        inherited Changed;
        if newValue then
          TranslateClick;
      end;
    end; { if }
    //FDoFocus := Focused;
    Invalidate;
    TabStop := newValue;
  end; { if }
end; { SetChecked }

procedure TElCheckItem.DrawGlyph(Canvas : TCanvas; DestRect: TRect; SrcRect:
    TRect);
begin
  LMDDrawTransparentBitmapEx(Canvas.Handle, FGlyph, DestRect.Left, DestRect.Top, SrcRect, FGlyph.Canvas.Pixels[SrcRect.Left, SrcRect.Bottom - 1]);
end;

procedure TElCheckItem.SetFlatAlways(Value: Boolean);
begin
  if FFlatAlways <> Value then
  begin
    FFlatAlways := Value;
    if not UseCustomGlyphs then
      Invalidate;
  end;
end;

procedure TElCheckItem.SetIsHTML(Value: Boolean);
begin
  if FIsHTML <> Value then
  begin
    FIsHTML := Value;
    if FIsHTML then
    begin
      FRender := TLMDHTMLRender.Create;
      FRender.OnImageNeeded := TriggerImageNeededEvent;
    end
    else
    begin
      FRender.Free;
      FRender := nil;
    end;
    if AutoSize then
      AdjustAutoSize;
    Invalidate;
  end;
end;

procedure TElCheckItem.SetImages(Value: TCustomImageList);
var b : boolean;
begin
  if FImages <> Value then
  begin
    b := FImages = nil;
    if not b then
    begin
      if not (csDestroying in FImages.ComponentState) then
        FImages.RemoveFreeNotification(Self);
      FImages.UnregisterChanges(FChLink);
    end;
    FImages := Value;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FChLink);
      FImages.FreeNotification(Self);
    end;
    if FImages = nil then
      UseImageList := false
    else
    if b and (not (csLoading in ComponentState)) then
      UseImageList := true;
    Invalidate;
  end;
end;

procedure TElCheckItem.SetAlphaImages(Value: TCustomImageList);
begin
  if FAlphaImages <> Value then
  begin
    if FAlphaImages <> nil then
    begin
      if not (csDestroying in FAlphaImages.ComponentState) then
        FAlphaImages.RemoveFreeNotification(Self);
      FAlphaImages.UnregisterChanges(FAChLink);
    end;
    FAlphaImages := Value;
    if FAlphaImages <> nil then
    begin
      FAlphaImages.RegisterChanges(FAChLink);
      FAlphaImages.FreeNotification(Self);
    end;
    Invalidate;
  end;
end;

procedure TElCheckItem.SetUseImageList(Value: Boolean);
begin
  if FUseImageList <> Value then
  begin
    if (Value and (FImages <> nil)) or (not Value) or (csLoading in ComponentState) then
    begin
      FUseImageList := Value;
      if AutoSize then
        AdjustAutoSize;
      Invalidate;
    end;
  end;
end;

procedure TElCheckItem.ImagesChanged(Sender: TObject);
begin
  if FUseImageList then
    Invalidate;
end;

procedure TElCheckItem.CMEnabledChanged(var Msg : TMessage); { private }
begin
  inherited;
  Invalidate;
end; { CMEnabledChanged }

procedure TElCheckItem.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TElCheckItem.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  Perform(IFM_REPAINTCHILDREN, 0, 0);
end;

procedure TElCheckItem.CreateWnd;

begin
  inherited;
  if Autosize then AdjustAutosize;
end;

function TElCheckItem.GetCheckBoxSize: TSize;
begin
  Result.cx := CheckBoxSize;
  Result.cy := CheckBoxSize;
  //if IsThemed() then
  //begin
  //  GetThemePartSize(Theme, Canvas.Handle, GetPartId, 1, nil, TS_TRUE, Result);
  //end;
end;

{function TElCheckItem.GetPartId: Integer;
begin
  if Self is TElRadioButton then
  begin
    Result := BP_RADIOBUTTON;
  end
  else
  begin
    if Self is TElCheckBox then
    begin
      Result := BP_CHECKBOX;
    end
    else
    begin
      Result := BP_USERBUTTON;
    end;
  end;
end;}

procedure TElCheckItem.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  with TMessage(Msg) do
  begin
    Result := DefWindowProc(Handle, Msg, wParam, lParam);
    Result := (Result and (not DLGC_WANTALLKEYS));
    if HandleDialogKeys then
      result := result or DLGC_WANTALLKEYS;
  end;
end;  { WMGetDlgCode }

procedure TElCheckItem.WMContextMenu(var Message: TWMContextMenu);

var
  R    : TRect;
  href : TLMDString;
  Handled: Boolean;
  Pt, Temp: TPoint;

begin
  if Message.Result <> 0 then Exit;
  if csDesigning in ComponentState then Exit;

  Pt := ScreenToClient(SmallPointToPoint(Message.Pos));
  if IsHTML then
  begin
    R := CalcTextRect;
    if (LinkPopupMenu <> nil) and FRender.IsCursorOverLink(Point(Pt.X - R.Left, Pt.Y - R.Top), Point(0, 0), R, href) then
    begin
      Handled := False;
      Temp := ClientToScreen(Pt);
      DoContextPopup(Temp, Handled);
      Message.Result := Ord(Handled);
      if Handled then Exit;

      DoLinkPopup(ClientToScreen(Pt));
      Message.Result := 1;
    end
    else
      inherited
  end
  else
  inherited;
end;

procedure TElCheckItem.WMRButtonUp(var Message: TWMRButtonUp);

begin
  inherited;
end;

procedure TElCheckItem.SetCursor(newValue : TCursor);
var P : TPoint;
    R : TRect;
    href : TLMDString;
begin
  if (FCursor <> newValue) then
  begin
    FCursor := newValue;
    if IsHTML then
    begin
      GetCursorPos(P);
      P := ScreenToClient(P);
      R := CalcTextRect;
      if FRender.IsCursorOverLink(Point(P.X - R.Left, P.Y - R.Top), Point(0, 0), R, href) then
        inherited Cursor := crHandPoint
      else
        inherited Cursor := FCursor;
    end
    else
      inherited Cursor := FCursor;
  end;  { if }
end;  { SetCursor }

function TElCheckItem.CalcTextRect: TRect;
begin
  Result.Left := FTextPos.x;
  Result.Top  := FTextPos.y;
  Result.Right  := FTextPos.x + FRender.Data.TextSize.cx;
  Result.Bottom := FTextPos.y + FRender.Data.TextSize.cy;
end;

procedure TElCheckItem.ChangeScale(M, D: Integer);
begin
  inherited;
  if LMDSIWindowsXPUp then
    if Assigned(Screen) then
      CheckBoxSize := MulDiv(InitCheckBoxSize,Screen.PixelsPerInch, 96);
//  CheckBoxSize := MulDiv(CheckBoxSize,D,M);
end;

procedure TElCheckItem.MouseMove(Shift: TShiftState; X, Y: Integer);

var href : TLMDString;
    R    : TRect;

begin

  if IsHTML then
  begin
    R := CalcTextRect;
    if FRender.IsCursorOverLink(Point(X - R.Left, Y - R.Top), Point(0, 0), R, href) then
       inherited Cursor := crHandPoint
    else
       inherited Cursor := FCursor;
  end;

  inherited MouseMove(Shift, X, Y);
end;  { MouseMove }

procedure TElCheckItem.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
  begin
    FLinkColor := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkColor }

procedure TElCheckItem.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
  begin
    if (FLinkPopupMenu <> nil) then
      if not (csDestroying in FLinkPopupMenu.ComponentState) then
        FLinkPopupMenu.RemoveFreeNotification(Self);
    FLinkPopupMenu := newValue;
    if (newValue <> nil) then
       newValue.FreeNotification(Self);
  end;  { if }
end;  { SetLinkPopupMenu }

procedure TElCheckItem.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
  begin
    FLinkStyle := newValue;
    if IsHTML then
    begin
      FIsHTML := false;
      IsHTML := true;
    end;
  end;  { if }
end;  { SetLinkStyle }

procedure TElCheckItem.DoLinkPopup(MousePos : TPoint);
begin
  if (FLinkPopupMenu <> nil) and FLinkPopupMenu.AutoPopup then
  begin
    SendCancelMode(nil);
    FLinkPopupMenu.PopupComponent := Self;
    if MousePos.X < 0 then
      MousePos := ClientToScreen(Point(0,0));
    FLinkPopupMenu.Popup(MousePos.X, MousePos.Y);
  end;
end;

procedure TElCheckItem.TriggerImageNeededEvent(Sender : TObject; Src :
    TLMDString; var Image : TBitmap);
begin
  Image := nil;
  if (assigned(FOnImageNeeded)) then
      FOnImageNeeded(Self, Src, Image);
end;  { TriggerImageNeededEvent }

procedure TElCheckItem.TriggerLinkClickEvent(HRef : TLMDString);
begin
  if (assigned(FOnLinkClick)) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

procedure TElCheckItem.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('Alignment', ReadAlignment, nil, false);
end;

procedure TElCheckItem.ReadAlignment(Reader: TReader);
var S : string;
begin
  s := Reader.ReadIdent;
  SetEnumProp(Self, 'CheckAlignment', s);
end;

procedure TElCheckItem.SetEndEllipsis(Value: Boolean);
begin
  if FEndEllipsis <> Value then
  begin
    FEndEllipsis := Value;
    Invalidate;
  end;
end;

function TElCheckItem.CalcAutoSize(var ax, ay : integer): Boolean;
var R : TRect;
    al : integer;

begin
  ax := 0;
  ay := 0;
  Result := False;
  if (ComponentState * [csDestroying, csLoading, csReading] <> []) or
     (Parent = nil) or (not HandleAllocated) then exit;
  if IsThemed then
  begin
    inc(ax, GetCheckBoxSize.cx);
    ay := GetCheckBoxSize.cy;
  end
  else
  if FUseCustomGlyphs and (not FGlyph.Empty) then
  begin
    inc(ax, FGlyph.Width div 6);
    ay := FGlyph.Height;
  end
  else
  begin
    if FUseImageList and Assigned(FImages) then
    begin
      inc(ax, FImages.Width);
      ay := FImages.Height;
    end
    else
    begin
      inc(ax, GetCheckBoxSize.cx);
      ay := GetCheckBoxSize.cy;
    end;
    end;
  inc(ax, CheckMargin + CheckMargin div 2);
  inc(ay, 4);
  Canvas.Font.Assign(Font);
  SetRectEmpty(R);
  if IsHTML then
  begin
    FRender.Data.DefaultColor := Font.Color;
    FRender.Data.DefaultBgColor := clNone;
    FRender.Data.DefaultStyle := Font.Style;
    FRender.Data.DefaultHeight := Font.Height;
    FRender.Data.DefaultFont := Font.Name;
    FRender.Data.Charset := Font.Charset;
    FRender.Data.LinkColor := LinkColor;
    FRender.Data.LinkStyle := LinkStyle;

    FRender.PrepareText(FCaption, 0, false);
    R.Right  := FRender.Data.TextSize.cx;
    R.Bottom := FRender.Data.TextSize.cy;
  end
  else
  begin
    {if not FMultiline then
      AL := DT_SINGLELINE
    else}
    AL := 0;
    LMDDrawText(Canvas.Handle, Caption, Length(Caption), R, AL or DT_LEFT or DT_CALCRECT);
  end;
  inc(ax, R.Right - R.Left + 2);
  ay := Max(ay, R.Bottom - R.Top + CheckMargin div 2);
  if TextDrawType <> tdtNormal then
    inc(ay, 2);
  Result := True;
end;

procedure TElCheckItem.SetCheckMargin(Value: Integer);
begin
  if (FCheckMargin <> Value) and (Value >= 0) then
  begin
    FCheckMargin := Value;
    AdjustAutoSize;
    Invalidate;
  end;
end;

procedure TElCheckItem.SetWordWrap(const Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    Invalidate;
  end;
end;

procedure TElCheckItem.TranslateClick;
begin
  inherited Click;
end;

procedure TElCheckItem.CMKillFocus(var Message: TWMSetFocus);
var
  ARect: TRect;
  LInst: ILMDElParentControlInterface;
begin
  if Transparent then
  begin
    if Supports(Parent, ILMDElParentControlInterface, LInst) then
    begin
      ARect := BoundsRect;
      InflateRect(ARect, 0, 3);
      LInst.RepaintRect(Arect)
    end
    else
    begin
      GetClipBox(Self.Canvas.Handle, ARect);
      OffsetRect(ARect, Left, Top);
      RedrawWindow(Parent.Handle, @ARect, 0, RDW_ERASE or RDW_INVALIDATE or RDW_NOCHILDREN or RDW_UPDATENOW);
    end;
  end;
end;

initialization
  DefCheckMargin := 5;
  CheckBoxSize := 13;
  InitCheckBoxSize := 13;
end.
