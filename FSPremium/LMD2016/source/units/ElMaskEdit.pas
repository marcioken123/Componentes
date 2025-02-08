unit ElMaskEdit;
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

ElMaskEdit unit
---------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

12 February, 2008 (EK)
 - Validation support added;

###############################################################################}

interface

uses
  Windows, StdCtrls, Messages, Controls, ExtCtrls, Forms, Graphics, Clipbrd,
  Types, Mask, SysUtils, Classes,
  Themes,

  LMDThemes, LMDVldBase, LMDClass, LMDGraph, LMDUtils, LMDTypes, intfLMDBase,

  ElStyleMan, ElXPThemedControl, ElImgFrm, ElVCLUtils;

type
  TCustomElMaskEdit = class(TCustomMaskEdit, ILMDComponent, ILMDValidatedControl)
  private
    FWantTabs : Boolean;
    FAbout: TLMDAboutVar;
    FActiveBorderType: TElFlatBorderType;
    FAlignment: TAlignment;
    FBackground: TBitmap;
    FBorderSides: TLMDBorderSides;
    FFlat: Boolean;
    FHandleDialogKeys: Boolean;
    FImgForm: TElImageForm;
    FImgFormChLink: TImgFormChangeLink;
    FInactiveBorderType: TElFlatBorderType;
    FMouseOver: Boolean;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FPainting: Boolean;
    FPaintingTo: Boolean;
    FReturnPressed: Boolean;
    FTransparent: Boolean;
    FUseBackground: Boolean;
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FStyleMgrLink : TElStyleMgrChangeLink;
    FStyleManager: TElStyleManager;
    FStyleName: string;

    FThemeGlobalMode: Boolean;

    function GetUseXPThemes: Boolean;
    procedure ReadUseXPThemes(Reader: TReader);

    procedure BackgroundChanged(Sender: TObject);
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure CMParentColorChanged(var Msg: TMessage); message
        CM_PARENTCOLORCHANGED;
    procedure CNCtlColorEdit(var Msg: TWMCtlColorEdit); message CN_CTLCOLOREDIT;
    procedure CNCtlColorStatic(var Msg: TWMCtlColorStatic); message
        CN_CTLCOLORSTATIC;
    procedure DrawBackground(DC: HDC; R: TRect);
    procedure DrawFlatBorder(DC: HDC);
    procedure DrawParentControl(DC: HDC);
    procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMSize(var Msg : TWMSize); message WM_SIZE;
    procedure ImageFormChange(Sender : TObject);
    procedure SetActiveBorderType(const Value: TElFlatBorderType);
    procedure SetAlignment(const Value: TAlignment);
    procedure SetBackground(const Value: TBitmap);
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure SetInactiveBorderType(const Value: TElFlatBorderType);
    procedure SetTransparent(const Value: boolean);
    procedure SetUseBackground(const Value: boolean);
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FNoHandleEnter: Boolean;
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;
    FValidator: TLMDValidationEntity;
    FValidationMsgString: TLMDString;
    FErrorIndication: Boolean;
    FOnValidationError: TLMDValidationErrorEvent;

    FParentThemeMode: boolean;
    FThemeMode : TLMDThemeMode;
    FPreventStyleChange :Boolean;

    procedure SetThemeGlobalMode(const Value: Boolean);virtual;
    procedure SetThemeMode(const Value: TLMDThemeMode);virtual;
    procedure SetUseXPThemes(const Value: Boolean);virtual;
    procedure DefineProperties(Filer:TFiler);override;

    procedure DoThemeChanged; virtual;
    function UseThemeMode: TLMDThemeMode;
    procedure UpdateStyle;
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
    //new V9
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes;

    procedure SetValidationMsgString(val : TLMDString);
    function GetValidationMsgString : TLMDString;
    function GetControl : TControl;
    function GetControlBackBrush : TBrush;
    function GetControlFont : TFont;
    function GetValueToValidate: TLMDString;

    procedure Change; override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DoMouseEnter; dynamic;
    procedure DoMouseLeave; dynamic;
    procedure DoPaint; dynamic;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetFlat(const Value: boolean); virtual;
    procedure SetImageForm(newValue : TElImageForm); virtual;
    procedure IFMRepaintChildren(var Message: TMessage); message
        IFM_REPAINTCHILDREN;
//    function IsThemeApplied: Boolean;
    procedure WMNCPaint(var Msg : TWMNCPaint); message WM_NCPAINT;
    procedure ELThemeChanged(var Message: TMessage); message WM_THEMECHANGED;
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$endif}
    procedure SetStyleManager(Value: TElStyleManager); virtual;
    procedure SetStyleName(const Value: string); virtual;
    procedure StyleMgrChange(Sender : TObject);
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);

    procedure Loaded; override;

    property ActiveBorderType: TElFlatBorderType read FActiveBorderType write
        SetActiveBorderType default fbtSunken;
    property Alignment: TAlignment read FAlignment write SetAlignment default
        taLeftJustify;
    property Background: TBitmap read FBackground write SetBackground;
    property Flat: Boolean read FFlat write SetFlat default False;
    property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write
        SetInactiveBorderType default fbtSunkenOuter;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
    property Transparent: Boolean read FTransparent write SetTransparent default
        False;
    property UseBackground: Boolean read FUseBackground write SetUseBackground
        default False;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides;
    property HandleDialogKeys: Boolean read FHandleDialogKeys write
        FHandleDialogKeys default true;
    property ImageForm: TElImageForm read FImgForm write SetImageForm;
    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor;
    property WantTabs: Boolean read FWantTabs write FWantTabs default false;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsThemed: Boolean; // any other than ttmNone  -> Use LMDThemeServices
    property MouseOver: Boolean read FMouseOver default false;
    function getLMDPackage:TLMDPackageID;
    function SupportsDefaultIndication: boolean;
    property ControlFont : TFont read GetControlFont;
    property ControlBackBrush : TBrush read GetControlBackBrush;
    procedure RespondToError(ErrorLevel: TLMDErrorLevel);
    procedure SetValidator(Validator:TLMDValidationEntity);
    function GetValidator: TLMDValidationEntity;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property DoubleBuffered;
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property StyleManager: TElStyleManager read FStyleManager write SetStyleManager;
    property StyleName: string read FStyleName write SetStyleName;
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;
    property BorderColorWindow: TColor read FBorderColorWindow write
        SetBorderColorWindow default clWindow;
    property ValidationMsgString : TLMDString read GetValidationMsgString write SetValidationMsgString;
    property Validator: TLMDValidationEntity read GetValidator write SetValidator;
    property OnValidationError: TLMDValidationErrorEvent read FOnValidationError write FOnValidationError;
  end;

  TElMaskEdit = class(TCustomElMaskEdit)
  published
    property WantTabs;
    property ActiveBorderType;
    property Alignment;
    property Background;
    property Flat;
    property InactiveBorderType;
    property OnMouseEnter;
    property OnMouseLeave;
    property Transparent;
    property UseBackground;
    property BorderSides;
    property HandleDialogKeys;
    property ImageForm;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property Align;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property BiDiMode;
    property BorderStyle;
    property CharCase;
    property Color;
    property Constraints;
    property Ctl3D;
    property Cursor;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property EditMask;
    property Font;
    property HideSelection;
    property ImeMode;
    property ImeName;
    property MaxLength;
    property OEMConvert;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PasswordChar;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property Text;

    property Visible;
    property OnChange;
    property OnClick;
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
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  TypInfo, LMDSysIn, UxTheme;

  type
    THackWinControl = class(TWinControl)
  end;

constructor TCustomElMaskEdit.Create(AOwner: TComponent);
begin
  inherited;
  FActiveBorderType := fbtSunken;
  FAlignment := taLeftJustify;
  FHandleDialogKeys := true;
  FBackground := TBitmap.Create;
  FBackground.OnChange := BackgroundChanged;
  FFlat := False;
  FInactiveBorderType := fbtSunkenOuter;
  FMouseOver := False;
  FPainting := False;
  FPaintingTo := False;
  FTransparent := False;
  FUseBackground := False;
  FImgFormChLink := TImgFormChangeLink.Create;
  FImgFormChLink.OnChange := ImageFormChange;
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
  UseXPThemes := true;
  FStyleMgrLink := TElStyleMgrChangeLink.Create;
  FStyleMgrLink.OnChange := StyleMgrChange;
  if not (csDesigning in ComponentState) then
    StyleManager := DefaultStyleManager;
end;

destructor TCustomElMaskEdit.Destroy;
begin
  StyleManager := nil;
  FreeAndNil(FStyleMgrLink);
  ImageForm := nil;
  FImgFormChLink.Free;
  FBackground.Free;
  inherited;
end;

procedure TCustomElMaskEdit.BackgroundChanged(Sender: TObject);
begin
  Invalidate;
  Perform(CM_COLORCHANGED, 0, 0);
  end;

procedure TCustomElMaskEdit.Change;
begin
  DoPaint;
  inherited;
  if Assigned(Self.FValidator) then
    Self.FValidator.Validate(Self);
end;

procedure TCustomElMaskEdit.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := True;
  if IsThemed or
     (Flat and (not Focused)) then DrawFlatBorder(0);
  DoMouseEnter;
end;

procedure TCustomElMaskEdit.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  FMouseOver := False;
  if IsThemed or (Flat and (not Focused)) then
    DrawFlatBorder(0);
  DoMouseLeave;
end;

procedure TCustomElMaskEdit.CMParentColorChanged(var Msg: TMessage);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or
     ((FImgForm <> nil) and (not (csDesigning in Componentstate)))
  then
    Invalidate;
end;

procedure TCustomElMaskEdit.CNCtlColorEdit(var Msg: TWMCtlColorEdit);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or
     ((FImgForm <> nil) and (not (csDesigning in Componentstate)))
  then
    SetBkMode(Msg.ChildDC, Windows.TRANSPARENT);
end;

procedure TCustomElMaskEdit.CNCtlColorStatic(var Msg: TWMCtlColorStatic);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or
     ((FImgForm <> nil) and (not (csDesigning in Componentstate)))
  then
    SetBkMode(Msg.ChildDC, Windows.TRANSPARENT);
end;

procedure TCustomElMaskEdit.CreateParams(var Params: TCreateParams);
const
   Alignments: array [TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited;
  Params.Style := Params.Style or Alignments[FAlignment];
end;

procedure TCustomElMaskEdit.DoMouseEnter;
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TCustomElMaskEdit.DoMouseLeave;
begin
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TCustomElMaskEdit.DoPaint;
const
  BorderOffsets: array [TBorderStyle] of integer = (1, -1);
var
  CtlDC, TempDC: HDC;
  OldBmp, TempBmp: HBITMAP;
begin
  FPainting := True;
  try
    if FTransparent or (FUseBackground and not FBackground.Empty)
    or ((FImgForm <> nil) and (not (csDesigning in Componentstate)))
    then
    begin
      HideCaret(Handle);
      CtlDC := GetDC(Handle);
      try
        TempDC := CreateCompatibleDC(CtlDC);
        try
          TempBmp := CreateCompatibleBitmap(CtlDC, ClientWidth +1, ClientHeight +1);
          try
            OldBmp := SelectObject(TempDC, TempBmp);
            FPaintingTo := True;
            try
              PaintTo(TempDC, 0, 0);
            finally
              FPainting := False;
            end;
            if FFlat  then
               DrawFlatBorder(TempDC);
            BitBlt(CtlDC, BorderOffsets[BorderStyle], BorderOffsets[BorderStyle], ClientWidth, ClientHeight, TempDC, 1, 1, SRCCOPY);
            SelectObject(TempDC, OldBmp);
          finally
            DeleteObject(TempBmp);
          end;
        finally
          DeleteDC(TempDC);
        end;
      finally
        ReleaseDC(Handle, CtlDC);
      end;
      ShowCaret(Handle);
    end;
  finally
    FPainting := False;
  end;
end;

procedure TCustomElMaskEdit.DrawBackground(DC: HDC; R: TRect);
var
  X, Y: integer;
begin
  if FUseBackground and not FBackground.Empty then
  begin
    X := R.Left; Y := R.Top;
    while Y < R.Bottom do
    begin
      while X < R.Right do
      begin
        BitBlt(DC, X, Y, R.Right - X, R.Bottom - Y,
          FBackground.Canvas.Handle, 0, 0, SRCCOPY);
        Inc(X, FBackground.Width);
      end;
      X := R.Left;
      Inc(Y, FBackground.Height);
    end;
  end;
end;

procedure TCustomElMaskEdit.DrawFlatBorder(DC: HDC);
var
  BorderType: TElFlatBorderType;
  MustRelease: boolean;
  R: TRect;
  AColor : TColor;
begin
  if (not FFlat) or (BorderStyle = bsNone) or (not HandleAllocated) then exit;
  if IsThemed then
  begin
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_UPDATENOW);
    exit;
  end;

  MustRelease := (DC = 0);
  if MustRelease then DC := GetWindowDC(Handle);
  try
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);

    if Focused or FMouseOver then
      BorderType := FActiveBorderType
    else
      BorderType := FInactiveBorderType;

    if Focused or FMouseOver then
      AColor := LineBorderActiveColor
    else
      AColor := LineBorderInactiveColor;

    DrawFlatFrameEx2(DC, R, AColor, Color, Focused or FMouseOver, Enabled, FBorderSides, BorderType, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
  finally
    if MustRelease then ReleaseDC(Handle, DC);
  end;
end;

procedure TCustomElMaskEdit.DrawParentControl(DC: HDC);
var
  SavedDC: integer;
  P: TPoint;
begin
  if Assigned(Parent) then
  begin
    SavedDC := SaveDC(DC);
    try
      P := Parent.ScreenToClient(ClientOrigin);
      MoveWindowOrg(DC, -P.X, -P.Y);
      Parent.Perform(WM_ERASEBKGND, DC, 0);
      Parent.Perform(WM_PAINT, DC, 0);
      THackWinControl(Parent).PaintControls(DC, nil);
    finally
      RestoreDC(DC, SavedDC);
    end;
  end;
end;

procedure TCustomElMaskEdit.ImageFormChange(Sender : TObject);
begin
  Invalidate;
end;

procedure TCustomElMaskEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FReturnPressed := ((Key = VK_RETURN) and (Shift = [ssCtrl])) or (Key = VK_UP)
                    or (Key = VK_DOWN) or (Key = VK_PRIOR) or (Key = VK_NEXT);
end;

procedure TCustomElMaskEdit.KeyPress(var Key: Char);
begin
  inherited;
  if ((Key = Char(VK_RETURN)) or FReturnPressed) and (not FNoHandleEnter) then
  begin
    Key := #0;
    MessageBeep(0);
    end;
end;

procedure TCustomElMaskEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FImgForm then
    begin
      FImgForm := nil;
      Invalidate;
    end;
    if  Assigned(Self.FValidator) and (AComponent = Self.FValidator) then
      Self.SetValidator(nil);
  end;
end;

procedure TCustomElMaskEdit.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if Focused or FMouseOver then DrawFlatBorder(0);
    end;
end;

procedure TCustomElMaskEdit.SetAlignment(const Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
    end;
end;

procedure TCustomElMaskEdit.SetBackground(const Value: TBitmap);
begin
  FBackground.Assign(Value);
end;

procedure TCustomElMaskEdit.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TCustomElMaskEdit.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    if HandleAllocated then
      if Flat then
        Invalidate
      else
        RecreateWnd;
    end;
end;

procedure TCustomElMaskEdit.SetImageForm(newValue : TElImageForm);
begin
  if FImgForm <> newValue then
  begin
    if FImgForm <> nil then
    begin
      if not (csDestroying in FImgForm.ComponentState) then
        FImgForm.RemoveFreeNotification(Self);
      FImgForm.UnregisterChanges(FImgFormChLink);
    end;
    if newValue <> nil then
       newValue.FreeNotification(Self);
    FImgForm := newValue;
    if FImgForm <> nil then FImgForm.RegisterChanges(FImgFormChLink);
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
    end;
end;

procedure TCustomElMaskEdit.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if not Focused and not FMouseOver then DrawFlatBorder(0);
    end;
end;

procedure TCustomElMaskEdit.SetTransparent(const Value: boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
    end;
end;

procedure TCustomElMaskEdit.SetUseBackground(const Value: boolean);
begin
  if FUseBackground <> Value then
  begin
    FUseBackground := Value;
    RecreateWnd;
    Perform(CM_COLORCHANGED, 0, 0);
    end;
end;

procedure TCustomElMaskEdit.WMEraseBkgnd(var Msg: TWMEraseBkgnd);

var
  R1, BgRect : TRect;
  ACtl       : TWinControl;

begin
  if (FImgForm <> nil) and (not (csDesigning in FImgForm.Componentstate)) then
  begin
    if (FImgForm.Control <> Self) then
    begin
      ACtl := FImgForm.GetRealControl;
      R1 := ClientRect;
      BgRect := ClientRect;
      BgRect.TopLeft := ClientToScreen(BgRect.TopLeft);

      BgRect.BottomRight := ClientToScreen(BgRect.BottomRight);
      BgRect.TopLeft := ACtl.ScreenToClient(BgRect.TopLeft);
      BgRect.BottomRight := ACtl.ScreenToClient(BgRect.BottomRight);

      FImgForm.PaintBkgnd(Msg.DC, R1, Point(BgRect.Left, BgRect.Top), false);
    end
  end
  else
  if FTransparent then
    DrawParentControl(Msg.DC)
  else
  if FUseBackground and not FBackground.Empty then
    DrawBackground(Msg.DC, ClientRect)
  else inherited;
end;

procedure TCustomElMaskEdit.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
//  Msg.Result := DefWindowProc(Handle, Msg.Msg, Msg.wParam, Msg.lParam);

  Msg.Result := DefWindowProc(Handle, Msg.Msg, TMessage(Msg).LParam, TMessage(Msg).WParam);

  Msg.Result := (Msg.Result and (not DLGC_WANTALLKEYS)) or DLGC_WANTARROWS or DLGC_WANTCHARS;
  if WantTabs then
    Msg.Result := Msg.Result or DLGC_WANTTAB;
  if HandleDialogKeys then Msg.Result := Msg.Result or DLGC_WANTALLKEYS;
end;

procedure TCustomElMaskEdit.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if not HandleAllocated then exit;
  if Flat and not FMouseOver then DrawFlatBorder(0);
end;

procedure TCustomElMaskEdit.WMMove(var Msg: TWMMove);
begin
  inherited;
  Invalidate;
end;

procedure TCustomElMaskEdit.WMNCCalcSize(var Message : TWMNCCalcSize);

begin
  inherited;
  if (BorderStyle = bsSingle) and (not (IsThemed and UseXPThemes)) then
    begin
      if not (ebsLeft in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
      if not (ebsTop in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
      if not (ebsRight in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
      if not (ebsBottom in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
      end;
end;

procedure TCustomElMaskEdit.WMPaint(var Msg: TWMPaint);
begin
  inherited;
  if FTransparent or (FUseBackground and not FBackground.Empty)
  or ((FImgForm <> nil) and (not (csDesigning in Componentstate)))then
    if not FPainting and not FPaintingTo then
      DoPaint;
  if Flat then
    DrawFlatBorder(0);
end;

procedure TCustomElMaskEdit.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if AutoSelect and not (csLButtonDown in ControlState) then SelectAll;
  if Flat and not FMouseOver then DrawFlatBorder(0);
end;

procedure TCustomElMaskEdit.IFMRepaintChildren(var Message: TMessage);
begin
  inherited;
  if (not (csDesigning in ComponentState)) and (ImageForm <> nil) then
    Invalidate;
  Broadcast(Message);
end;

procedure TCustomElMaskEdit.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
  begin
    ThemeMode := LMDCtlXP[Value];
    if HandleAllocated then
      RecreateWnd;
  end;
end;

{------------------------------------------------------------------------------}
procedure TCustomElMaskEdit.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
  begin
    FThemeGlobalMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TCustomElMaskEdit.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
  begin
    FThemeMode:= Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
function TCustomElMaskEdit.GetUseXPThemes: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
procedure TCustomElMaskEdit.ReadUseXPThemes(Reader: TReader);
begin
  SetUseXPThemes(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TCustomElMaskEdit.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UseXPThemes', ReadUseXPThemes, nil, false);
end;

{------------------------------------------------------------------------------}
procedure TCustomElMaskEdit.DoThemeChanged;
begin
  // Delphi 2k7 fix
  if (UseThemeMode <> ttmNone) and HandleAllocated and not (csDestroying in ComponentState) then
  begin
    if Showing and (ComponentState * [csLoading, csReading] = []) then
      begin
        // Recalculate frame size
        SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER);
        // Repaint frame
        RedrawWindow(Handle, nil, 0, {RDW_FRAME or }RDW_INVALIDATE or RDW_ERASE);
      end;
  end
  else
    Invalidate;
end;

{------------------------------------------------------------------------------}
function TCustomElMaskEdit.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
function TCustomElMaskEdit.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
   if FThemeGlobalMode then
     result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

procedure TCustomElMaskEdit.WMNCPaint(var Msg : TWMNCPaint);
var DC : HDC;
    RW,
    RC : TRect;
    LDetails: TThemedElementDetails;
begin
  if IsThemed and (BorderStyle = bsSingle) then
  begin
    //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    //if DC = 0 then
    begin
      DC := GetWindowDC(Handle);
    end;

    Windows.GetClientRect(Handle, RC);
    GetWindowRect(Handle, RW);
    MapWindowPoints(0, Handle, RW, 2);
    OffsetRect(RC, -RW.Left, -RW.Top);
    ExcludeClipRect(DC, RC.Left, RC.Top, RC.Right, RC.Bottom);
    OffsetRect(RW, -RW.Left, -RW.Top);
    if LMDSIWindowsVistaUp then
    begin
      LDetails.Element := teEdit;
      LDetails.Part := EP_EDITBORDER_NOSCROLL;
      LDetails.State := ETS_NORMAL;
      if not Enabled then
        LDetails.State := ETS_DISABLED
      else
      if Focused then
        LDetails.State := ETS_SELECTED
      else
      if FMouseOver then
        LDetails.State := ETS_HOT;
      LMDThemeServices.DrawElement(UseThemeMode, DC, LDetails, RW, nil);
      end
    else
      LMDThemeServices.DrawElement(UseThemeMode, DC, teEditDontCare, RW, nil);
    ReleaseDC(Handle, DC);
  end
  else
  if not Flat and (BorderStyle = bsSingle) then
    inherited;
end;

procedure TCustomElMaskEdit.ELThemeChanged(var Message: TMessage);
begin
  if IsThemed and UseXPThemes then
  begin
    SetWindowPos(
      Handle,
      0,
      0, 0, 0, 0,
      SWP_FRAMECHANGED or SWP_NOMOVE or SWP_NOSIZE or SWP_NOZORDER
      );
    RedrawWindow(Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ERASE);
  end;
  Message.Result := 1;
end;

procedure TCustomElMaskEdit.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
      if HandleAllocated then
        Invalidate;
  end;
end;

procedure TCustomElMaskEdit.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
      if HandleAllocated then
        Invalidate;
  end;
end;

procedure TCustomElMaskEdit.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

procedure TCustomElMaskEdit.WMPaste(var Message: TMessage);
var Clip  : TClipboard;
    Piece : String;
begin
  if ReadOnly then exit;
  Clip := Clipboard;
  Clip.Open;
  Piece := Clip.AsText;
  while (Pos(#10, Piece) > 0) do
    Delete(Piece, Pos(#10, Piece), 1);
  while (Pos(#13, Piece) > 0) do
    Delete(Piece, Pos(#13, Piece), 1);
  Clip.AsText := Piece;
  Clip.Close;
  inherited;
end;

{$ifdef LMD_UNICODE}
{------------------------------------------------------------------------------}
procedure TCustomElMaskEdit.CMHintShow(var Message:TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message); //outcommented VB Dec 2008
end;

{------------------------------------------------------------------------------}
procedure TCustomElMaskEdit.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TCustomElMaskEdit.SetStyleManager(Value: TElStyleManager);
begin
  if FStyleManager <> Value then
  begin
    if (FStyleManager <> nil) and (not (csDestroying in FStyleManager.ComponentState)) then
      FStyleManager.RemoveFreeNotification(Self);
    if FStyleManager <> nil then
       FStyleManager.UnregisterChanges(FStyleMgrLink);
    FStyleManager := Value;
    if FStyleManager <> nil then
    begin
      FStyleManager.FreeNotification(Self);
      FStyleManager.RegisterChanges(FStyleMgrLink);
      UpdateStyle;
    end;
  end;
end;

procedure TCustomElMaskEdit.SetStyleName(const Value: string);
begin
  if FStyleName <> Value then
  begin
    FStyleName := Value;
    UpdateStyle;
  end;
end;

procedure TCustomElMaskEdit.StyleMgrChange(Sender : TObject);
begin
  UpdateStyle;
end;

procedure TCustomElMaskEdit.UpdateStyle;
begin
  if ComponentState * [csLoading, csReading] <> [] then
    exit;
  if FStyleManager <> nil then
  begin
    if HandleAllocated and Visible then
      SendMessage(Handle, WM_SETREDRAW, 0, 0);
    FStyleManager.ApplyStyle(Self, StyleName);
    if HandleAllocated and Visible then
    begin
      SendMessage(Handle, WM_SETREDRAW, 1, 0);
      Invalidate;
    end;
  end;
end;

procedure TCustomElMaskEdit.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TCustomElMaskEdit.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TCustomElMaskEdit.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TCustomElMaskEdit.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TCustomElMaskEdit.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TCustomElMaskEdit.WMSize(var Msg : TWMSize);  { private }
begin
  inherited;
  if IsThemed or (Flat and (BorderStyle <> bsNone)) then
    DrawFlatBorder(0);
end;  { WMSize }

procedure TCustomElMaskEdit.Loaded;
begin
  inherited;
  UpdateStyle;
end;

function TCustomElMaskEdit.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_ELCORE;
end;

function TCustomElMaskEdit.GetControlBackBrush: TBrush;
begin
  Result := Self.Brush;
end;

function TCustomElMaskEdit.GetControl: TControl;
begin
  Result := Self;
end;

function TCustomElMaskEdit.GetControlFont: TFont;
begin
  Result := Self.Font;
end;

function TCustomElMaskEdit.GetValidationMsgString: TLMDString;
begin
  Result := Self.FValidationMsgString;
end;

function TCustomElMaskEdit.GetValueToValidate: TLMDString;
begin
  Result := Self.Text;
end;

procedure TCustomElMaskEdit.RespondToError(ErrorLevel: TLMDErrorLevel);
begin
  FErrorIndication := ErrorLevel > 0;
  if Assigned(FOnValidationError) and FErrorIndication then
    FOnValidationError(self, ErrorLevel);
end;

procedure TCustomElMaskEdit.SetValidationMsgString(val: TLMDString);
begin
  Self.FValidationMsgString := val;
end;

procedure TCustomElMaskEdit.SetValidator(Validator: TLMDValidationEntity);
begin
  if Self.FValidator = Validator then Exit;
//  if Assigned(Self.FValidator) then
//    Self.FValidator.ReleaseControl(Self);
  Self.FValidator := Validator;
  if Assigned(Self.FValidator) then
    begin
      Validator.FreeNotification(Self);
//      Self.FValidator.AcceptControl(Self);
    end;
end;

function TCustomElMaskEdit.SupportsDefaultIndication: boolean;
begin
  Result := false;
end;

function TCustomElMaskEdit.GetValidator: TLMDValidationEntity;
begin
  Result := Self.FValidator;
end;

end.
