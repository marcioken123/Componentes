unit ElSpinBtn;
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

ElSpinBtn unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  Graphics,
  Controls,
  Forms,
  Menus,
  StdCtrls,
  ExtCtrls,
  Types,
  SysUtils,
  Classes,
  Themes,

  ElVCLUtils,
  ElXPThemedControl,

  LMDTypes,
  LMDUtils,
  LMDThemes,
  LMDClass,
  LMDProcs;

type

  TElSpinEvent = procedure(Sender : TObject; Distance : Double) of object;
  TElSpinStartEvent = procedure(Sender : TObject; var InitialDistance : Double) of object;

  TElSpinBtnDir  = (sbdUpDown, sbdLeftRight);
  TElSpinBtnType = (sbtUpDown, sbtLeftRight);

  TElSpinButton = class(TElXPThemedControl)
  private
    FFlat : Boolean;
    FUseDrag : Boolean;
    FOnUpClick,
    FOnDownClick,
    FOnSpinDrag : TElSpinEvent;
    FOnSpinStart: TElSpinStartEvent;
    FMouseInUpPart: Boolean;
    FMouseInDownPart: Boolean;

    procedure WMMouseMove(var Msg : TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMEnabledChanged(var Msg : TMessage); message CM_ENABLEDCHANGED;
    procedure WMContextMenu(var Msg : TWMContextMenu); message WM_CONTEXTMENU;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure WMCancelMode(var Message: TWMCancelMode); message WM_CANCELMODE;
  protected
    FTopBtnDown,
    FBottomBtnDown : boolean;
    FTimer : TTimer;
    SaveCursor  : TCursor;
    FCaptured,
    FDragging : boolean;
    FStartValue,
    FValue      : Double;
    FIncrement: Double;
    FButtonDirection: TElSpinBtnDir;
    FButtonType: TElSpinBtnType;
    FUpArrowEnabled: Boolean;
    FDownArrowEnabled: Boolean;

    FMoneyFlat: Boolean;
    FMoneyFlatActiveColor: TColor;
    FMoneyFlatDownColor: TColor;
    FMoneyFlatInactiveColor: TColor;
    FOldStyled: Boolean;
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FThinFrame: Boolean;
    FShowBorder: Boolean;

    procedure IntMouseMove(XPos, YPos : SmallInt);
    procedure Paint; override;
    procedure OnTimer(Sender : TObject);

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer); override;

    procedure CMExit(var Msg : TCMExit); message CM_EXIT;
    procedure MouseMove(Shift : TShiftState; X, Y : Integer); override;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    function GetPopupMenu: TPopupMenu; override;
    procedure SetUseDrag(newValue : Boolean); virtual;
    procedure SetFlat(newValue : Boolean); virtual;
    procedure SetButtonDirection(Value: TElSpinBtnDir);
    procedure SetButtonType(Value: TElSpinBtnType);
    function  GetThemedElement: TThemedElement; override;
    procedure SetUpArrowEnabled(Value: Boolean);
    procedure SetDownArrowEnabled(Value: Boolean);
    procedure SetMoneyFlat(Value: Boolean);
    procedure SetMoneyFlatActiveColor(Value: TColor);
    procedure SetMoneyFlatDownColor(Value: TColor);
    procedure SetMoneyFlatInactiveColor(Value: TColor);
    function GetMoneyFlat: Boolean;
    procedure SetOldStyled(Value: Boolean);

    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$endif}
    procedure SetThinFrame(Value: Boolean);
    procedure SetShowBorder(Value: Boolean);
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;

    procedure StopDragging;
    property SpinDragging : boolean read FDragging;

  published
    property Increment: Double read FIncrement write FIncrement;
    property UseDrag : Boolean read FUseDrag write SetUseDrag default true;  { Published }
    property Flat : Boolean read FFlat write SetFlat default false;  { Published }
    property ButtonDirection: TElSpinBtnDir read FButtonDirection write
        SetButtonDirection default sbdUpDown;
    property ButtonType: TElSpinBtnType read FButtonType write SetButtonType default sbtUpDown;
    property UpArrowEnabled: Boolean read FUpArrowEnabled write SetUpArrowEnabled default true;
    property DownArrowEnabled: Boolean read FDownArrowEnabled write SetDownArrowEnabled default true;
    property MoneyFlat: Boolean read GetMoneyFlat write SetMoneyFlat default false;
    property MoneyFlatActiveColor: TColor read FMoneyFlatActiveColor write
        SetMoneyFlatActiveColor stored GetMoneyFlat;
    property MoneyFlatDownColor: TColor read FMoneyFlatDownColor write
        SetMoneyFlatDownColor stored GetMoneyFlat;
    property MoneyFlatInactiveColor: TColor read FMoneyFlatInactiveColor write
        SetMoneyFlatInactiveColor stored GetMoneyFlat;
    property OldStyled: Boolean read FOldStyled write SetOldStyled default false;

    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property ThinFrame: Boolean read FThinFrame write SetThinFrame default false;
    property ShowBorder: Boolean read FShowBorder write SetShowBorder default true;

    property OnUpClick  : TElSpinEvent read FOnUpClick write FOnUpClick;
    property OnDownClick: TElSpinEvent read FOnDownClick write FOnDownClick;
    property OnSpinDrag : TElSpinEvent read FOnSpinDrag write FOnSpinDrag;
    property OnSpinStart: TElSpinStartEvent read FOnSpinStart write FOnSpinStart;

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
    property Visible;
    property ThemeMode;
    property ThemeGlobalMode;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;

    property Anchors;
    property Constraints;
    property DockOrientation;
    property Floating;
    property BevelKind;
    property DoubleBuffered default true;
    property DragKind;

    property OnStartDock;
    property OnEndDock;
    property OnContextPopup;

  end;

implementation

constructor TElSpinButton.Create(AOwner : TComponent);
begin
  inherited;
  //ControlStyle := ControlStyle - [csCaptureMouse];
  ControlStyle := [csReflector, csSetCaption, csCaptureMouse, csDoubleClicks];
  if AOwner <> nil then
    SetDesigning(csDesigning in AOwner.ComponentState);
  FUseDrag := true;
  Width := 16;
  Height := 16;
  Color := clBtnFace;
  FUpArrowEnabled := true;
  FDownArrowEnabled := true;
  FShowBorder := true;
  TabStop := False;
  DoubleBuffered := true;
end;

destructor TElSpinButton.Destroy;
begin
  if FTimer <> nil then
  begin
    FTimer.Enabled := false;
    FTimer.Free;
    FTimer := nil;
  end;
  inherited;
end;

procedure TElSpinButton.Paint;
var
  R,
  R1,
  R2
  ,RClip
  : TRect;
  Clr   : TColor;
  AColor: TColor;
  Canvas: TCanvas;
  Bitmap: TBitmap;
  LDetail: TThemedSpin;
  LThemeMode: TLMDThemeMode;
begin
  // inherited;
  Bitmap := TBitmap.Create;
  Bitmap.Width := ClientWidth;
  Bitmap.Height := ClientHeight;
  Canvas := Bitmap.Canvas;
  Bitmap.Handle := CreateCompatibleBitmap(Canvas.Handle, ClientWidth, ClientHeight);
  LThemeMode := UseThemeMode;
  if FButtonType = sbtUpDown then
  begin
    R1 := Rect(0, 0, Width, Height div 2);
    R2 := Rect(0, Height div 2 + 1, Width, Height);
    R  := Rect(0, Height div 2, Width, Height div 2 + 1);
  end
  else
  begin
    R1 := Rect(0, 0, Width div 2, Height);
    R2 := Rect(Width div 2 + 1, 0, Width, Height);
    R  := Rect(Width div 2, 0, Width div 2 + 1, Height);
  end;

  Canvas.Brush.Color := Color;
  Canvas.FillRect(R1);
  Canvas.FillRect(R2);
  Canvas.FillRect(R);

  if LThemeMode = ttmNone then
  begin
    if MoneyFlat then
    begin
      if FTopBtnDown then
        AColor := MoneyFlatDownColor
      else
      if FMouseInUpPart then
        AColor := MoneyFlatActiveColor
      else
        AColor := MoneyFlatInactiveColor;
      DrawFlatFrameEx2(Canvas.Handle, R1, AColor, Color, (not Flat) or (csDesigning in ComponentState), Enabled, AllBorderSides, fbtColorLineBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
      if FBottomBtnDown then
        AColor := MoneyFlatDownColor
      else
      if FMouseInDownPart then
        AColor := MoneyFlatActiveColor
      else
        AColor := MoneyFlatInactiveColor;
      DrawFlatFrameEx2(Canvas.Handle, R2, AColor, Color, (not Flat) or (csDesigning in ComponentState), Enabled, AllBorderSides, fbtColorLineBorder, clBtnFace, cl3DDkShadow, clBtnShadow, clBtnHighlight, clWindow);
    end
    else
    begin
      //if not Flat or FTopBtnDown
      if (((not Flat) or (csDesigning in ComponentState) or FMouseInUpPart) and ShowBorder) or FTopBtnDown then
        DrawButtonFrameEx3(Canvas.Handle, R1, (not Flat) and (((FMouseInUpPart or Focused) and UpArrowEnabled) and (not ThinFrame)) or OldStyled {or FMouseInUpPart}, FTopBtnDown and UpArrowEnabled, Color, ThinFrame or Flat, AllBorderSides);
      if (((not Flat) or (csDesigning in ComponentState) or FMouseInDownPart) and ShowBorder) or FBottomBtnDown then
        DrawButtonFrameEx3(Canvas.Handle, R2, (not Flat) and (((FMouseInDownPart or Focused) and DownArrowEnabled) and (not ThinFrame)) or OldStyled {or FMouseInDownPart}, FBottomBtnDown and DownArrowEnabled, Color, ThinFrame or Flat, AllBorderSides);
      end;

    Dec(R1.Right);
    Dec(R2.Right);

    with Canvas do
    begin
      if FButtonDirection = sbdUpDown then
      begin
        if Enabled and UpArrowEnabled then
          Clr := clBtnText
        else
          Clr := clBtnShadow;

        Pixels[R1.Left + (R1.Right - R1.Left) shr 1, R1.Top + (R1.Bottom - r1.Top) shr 1 - 1] := Clr;
        Pixels[R1.Left + (R1.Right - R1.Left) shr 1 -1, R1.Top + (R1.Bottom - r1.Top) shr 1] := Clr;
        Pixels[R1.Left + (R1.Right - R1.Left) shr 1, R1.Top + (R1.Bottom - r1.Top) shr 1] := Clr;
        Pixels[R1.Left + (R1.Right - R1.Left) shr 1 + 1, R1.Top + (R1.Bottom - r1.Top) shr 1] := Clr;

        if Enabled and DownArrowEnabled then
          Clr := clBtnText
        else
          Clr := clBtnShadow;

        Pixels[R2.Left + (R2.Right - R2.Left) shr 1, R2.Top + (R2.Bottom - R2.Top) shr 1] := Clr;
        Pixels[R2.Left + (R2.Right - R2.Left) shr 1 -1, R2.Top + (R2.Bottom - R2.Top) shr 1 - 1] := Clr;
        Pixels[R2.Left + (R2.Right - R2.Left) shr 1, R2.Top + (R2.Bottom - R2.Top) shr 1 - 1] := Clr;
        Pixels[R2.Left + (R2.Right - R2.Left) shr 1 + 1, R2.Top + (R2.Bottom - R2.Top) shr 1 - 1] := Clr;
        end
      else
      begin
        if Enabled and UpArrowEnabled then
          Clr := clBtnText
        else
          Clr := clBtnShadow;

        Pixels[R1.Left + (R1.Right - R1.Left) shr 1 - 1, R1.Top + (R1.Bottom - r1.Top) shr 1] := Clr;
        Pixels[R1.Left + (R1.Right - R1.Left) shr 1, R1.Top + (R1.Bottom - r1.Top) shr 1 - 1] := Clr;
        Pixels[R1.Left + (R1.Right - R1.Left) shr 1, R1.Top + (R1.Bottom - r1.Top) shr 1] := Clr;
        Pixels[R1.Left + (R1.Right - R1.Left) shr 1, R1.Top + (R1.Bottom - r1.Top) shr 1 + 1] := Clr;

        if Enabled and DownArrowEnabled then
          Clr := clBtnText
        else
          Clr := clBtnShadow;

        Pixels[R2.Left + (R2.Right - R2.Left) shr 1, R2.Top + (R2.Bottom - R2.Top) shr 1] := Clr;
        Pixels[R2.Left + (R2.Right - R2.Left) shr 1 - 1, R2.Top + (R2.Bottom - R2.Top) shr 1 - 1] := Clr;
        Pixels[R2.Left + (R2.Right - R2.Left) shr 1 - 1, R2.Top + (R2.Bottom - R2.Top) shr 1] := Clr;
        Pixels[R2.Left + (R2.Right - R2.Left) shr 1 - 1, R2.Top + (R2.Bottom - R2.Top) shr 1 + 1] := Clr;
      end;
    end;
  end
  else
  begin
    if FButtonDirection = sbdUpDown then
    begin
      if not (Enabled and UpArrowEnabled) then
        LDetail := tsUpDisabled
      else
      if FTopBtnDown then
        LDetail := tsUpPressed
      else
      if FMouseInUpPart then
        LDetail := tsUpHot
      else
        LDetail := tsUpNormal;

      RClip := Canvas.ClipRect;
      LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
      if not (Enabled and DownArrowEnabled) then
        LDetail := tsDownDisabled
      else
      if FBottomBtnDown then
        LDetail := tsDownPressed
      else
      if FMouseInDownPart then
        LDetail := tsDownHot
      else
        LDetail := tsDownNormal;
      RClip := Canvas.ClipRect;
      LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, R2);//, LMDRectToPtr(RClip));
    end
    else
    begin
      if not (Enabled and UpArrowEnabled) then
        LDetail := tsDownHorzDisabled
      else
      if FTopBtnDown then
        LDetail := tsDownHorzPressed
      else
      if FMouseInUpPart then
        LDetail := tsDownHorzHot
      else
        LDetail := tsDownHorzNormal;
      RClip := Canvas.ClipRect;
      LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, R1, LMDRectToPtr(RClip));
      if not (Enabled and DownArrowEnabled) then
        LDetail := tsUpHorzDisabled
      else
      if FBottomBtnDown then
        LDetail := tsUpHorzPressed
      else
      if FMouseInDownPart then
        LDetail := tsUpHorzHot
      else
        LDetail := tsUpHorzNormal;
      RClip := Canvas.ClipRect;
      LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, R2, LMDRectToPtr(RClip));
    end;
  end;
  bitblt(Self.Canvas.Handle, 0, 0, ClientWidth, ClientHeight, Bitmap.Canvas.Handle, 0, 0, SRCCOPY);
  Bitmap.Free;
end;

procedure TElSpinButton.StopDragging;
begin
  MouseUp(mbLeft, [], 0, 0);
end;

procedure TElSpinButton.OnTimer(Sender : TObject);
begin
  if FTimer <> nil then
    FTimer.Interval := 100;
  if FTopBtnDown then
  begin
    if FButtonType = sbtLeftRight then
    begin
      if Assigned(FOnDownClick) then FOnDownClick(Self, FIncrement);
    end
    else
    begin
      if Assigned(FOnUpClick) then FOnUpClick(Self, FIncrement);
    end;
  end
  else
  if FBottomBtnDown then
  begin
    if FButtonType = sbtUpDown then
    begin
      if Assigned(FOnDownClick) then FOnDownClick(Self, FIncrement);
    end
    else
    begin
      if Assigned(FOnUpClick) then FOnUpClick(Self, FIncrement);
    end;
  end;
end;

procedure TElSpinButton.MouseDown(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
begin
  inherited;
  if (csDesigning in ComponentState) or (Button <> mbLeft) then exit;

  if ((FButtonType = sbtUpDown) and
      (Y < ClientHeight div 2)) or
     ((FButtonType = sbtLeftRight) and
      (X < ClientWidth div 2)) then
  begin
    if UpArrowEnabled then
    begin
      FTopBtnDown := true;
      FValue := 0;
      if FButtonType = sbtLeftRight then
      begin
        if Assigned(FOnDownClick) then FOnDownClick(Self, FIncrement);
      end
      else
      begin
        if Assigned(FOnUpClick) then FOnUpClick(Self, FIncrement);
      end;
    end;
  end
  else
  if ((FButtonType = sbtUpDown) and
      (Y > ClientHeight div 2 + 1)) or
     ((FButtonType = sbtLeftRight) and
      (X > ClientWidth div 2 + 1)) then
  begin
    if DownArrowEnabled then
    begin
      FBottomBtnDown := true;
      FValue := 0;
      if FButtonType = sbtUpDown then
      begin
        if Assigned(FOnDownClick) then FOnDownClick(Self, FIncrement);
      end
      else
      begin
        if Assigned(FOnUpClick) then FOnUpClick(Self, FIncrement);
      end;
    end;
  end
  else
  begin
    if not UseDrag then exit;
    if (not (csDesigning in ComponentState)) and
       (((FButtonType = sbtUpDown) and
         (Screen.Cursor <> crSizeNS)) or
        ((FButtonType = sbtLeftRight) and
         (Screen.Cursor <> crSizeWE))) then
    begin
      SaveCursor := Screen.Cursor;
      if FButtonType = sbtLeftRight then
        Screen.Cursor := crSizeWE
      else
        Screen.Cursor := crSizeNS;
    end;
    FDragging := true;
    FStartValue := 0;
    if Assigned(FOnSpinStart) then
      FOnSpinStart(Self, FStartValue);
    SetCapture(Handle);
    exit;
  end;
  SetCapture(Handle);
  FCaptured := true;
  FTimer := TTimer.Create(nil);
  FTimer.OnTimer := OnTimer;
  FTimer.Interval := 400;
  Invalidate;
end;

procedure TElSpinButton.MouseUp(Button : TMouseButton; Shift : TShiftState; X, Y : Integer);
var P : TPoint;
begin
  inherited;
  if (csDesigning in ComponentState) or (Button <> mbLeft) then exit;
  if (Screen.Cursor = crSizeNS) or (Screen.Cursor = crSizeWE) then
     Screen.Cursor := SaveCursor;
  if FTimer <> nil then
  begin
    FTimer.Enabled := false;
    FTimer.Free;
    FTimer := nil;
  end;
  if FDragging then
  begin
    ReleaseCapture;
    FDragging := false;
    FMouseInUpPart := false;
    FMouseInDownPart := false;
    exit;
  end;
  ReleaseCapture;
  GetCursorPos(P);
  P := ScreenToClient(P);
  if not PtInRect(ClientRect, P) then
  begin
    FMouseInUpPart := false;
    FMouseInDownPart := false;
  end;
  FTopBtnDown := false;
  FBottomBtnDown := false;
  Invalidate;
end;

function TElSpinButton.GetPopupMenu: TPopupMenu;
var p : TPoint;
begin
  if FDragging then
  begin
    GetCursorPos(p);
    p := ScreenToClient(p);
    MouseUp(mbLeft, [], p.x, p.y);
  end;
  result := inherited GetPopupMenu;
end;

procedure TElSpinButton.WMMouseWheel(var Msg: TWMMouseWheel);
begin
  with TMessage(Msg) do
  SendMessage(Parent.Handle, Msg, wParam, lParam);
end;

procedure TElSpinButton.MouseMove(Shift : TShiftState; X, Y : Integer);
var b : boolean;
begin
  inherited;
  if FDragging then
  begin
    if Assigned(FOnSpinDrag) then
    begin
      if FButtonType = sbtUpDown then
        FOnSpinDrag(self, FStartValue + (ClientHeight div 2 - Y) * FIncrement)
      else
        FOnSpinDrag(self, FStartValue + (X - ClientWidth div 2) * FIncrement);
    end;
  end
  else
  begin
    if ((FButtonType = sbtUpDown) and
      (Y < ClientHeight div 2)) or
     ((FButtonType = sbtLeftRight) and
      (X < ClientWidth div 2)) then
    begin
      if UpArrowEnabled then
      begin
        b := FMouseInUpPart;
        FMouseInUpPart := true;
        FMouseInDownPart := false;
        if not b then Invalidate;
      end;
    end
    else
    if ((FButtonType = sbtUpDown) and
      (Y > ClientHeight div 2 + 1)) or
     ((FButtonType = sbtLeftRight) and
      (X > ClientWidth div 2 + 1)) then
    begin
      if DownArrowEnabled then
      begin
        b := FMouseInDownPart;
        FMouseInUpPart := false;
        FMouseInDownPart := true;
        if not b then Invalidate;
      end;
    end
    else
    begin
      b := FMouseInUpPart or FMouseInDownPart;
      FMouseInUpPart := false;
      FMouseInDownPart := false;
      if b then Invalidate;
    end;
  end;
end;

procedure TElSpinButton.CMExit(var Msg : TCMExit);

begin
  inherited;
  Invalidate;
end; {CMExit}

procedure TElSpinButton.IntMouseMove(XPos, YPos : SmallInt);
begin
  if ((FButtonType = sbtUpDown) and
     (((YPos = ClientHeight div 2) or (YPos = ClientHeight div 2 + 1))
      and LMDInRange(XPos, 0, Width))) or
     ((FButtonType = sbtLeftRight) and
     (((XPos = ClientWidth div 2) or (XPos = ClientWidth div 2 + 1))
      and LMDInRange(YPos, 0, Height))) then
  begin
    if (not FCaptured) and (not FDragging) and UseDrag then
    begin
      SetCapture(Handle);
      FCaptured := true;

      if (not (csDesigning in ComponentState)) and
       (((FButtonType = sbtUpDown) and
         (Screen.Cursor <> crSizeNS)) or
        ((FButtonType = sbtLeftRight) and
        (Screen.Cursor <> crSizeWE)))
       then
      begin
        SaveCursor := Screen.Cursor;
        if FButtonType = sbtUpDown then
          Screen.Cursor := crSizeNS
        else
          Screen.Cursor := crSizeWE;
      end;
    end;
  end
  else
  if (not FDragging) and (FCaptured) then
  begin
    if (FTimer = nil) then
    begin
      ReleaseCapture;
      FCaptured := false;
    end;
    if (Screen.Cursor = crSizeNS) or (Screen.Cursor = crSizeWE) then
       Screen.Cursor := SaveCursor;
  end;
end;

procedure TElSpinButton.WMMouseMove(var Msg : TWMMouseMove);
begin
  IntMouseMove(Msg.XPos, Msg.YPos);
  inherited;
end; {WMMouseMove}

procedure TElSpinButton.SetUseDrag(newValue : Boolean);
{ Sets data member FUseDrag to newValue. }
begin
  if (FUseDrag <> newValue) then
    FUseDrag := newValue;
end;  { SetUseDrag }

procedure TElSpinButton.SetFlat(newValue : Boolean);
{ Sets data member FFlat to newValue. }
begin
  if (FFlat <> newValue) then
  begin
    FFlat := newValue;
    Invalidate;
  end;  { if }
end;  { SetFlat }

procedure TElSpinButton.CMEnabledChanged(var Msg : TMessage);  { private }

begin
  inherited;
  Invalidate;
end;  { CMEnabledChanged }

procedure TElSpinButton.SetButtonDirection(Value: TElSpinBtnDir);
begin
  if FButtonDirection <> Value then
  begin
    FButtonDirection := Value;
    if (not (csLoading in ComponentState)) then Invalidate;
  end;
end;

procedure TElSpinButton.SetButtonType(Value: TElSpinBtnType);
begin
  if FButtonType <> Value then
  begin
    FButtonType := Value;
    if (not (csLoading in ComponentState)) then Invalidate;
  end;
end;

procedure TElSpinButton.WMContextMenu(var Msg : TWMContextMenu);
begin
  if FTimer <> nil then
//    MouseUp(mbLeft, [], Msg.lParam and $FFFF, Msg.lParam shr 16);
    MouseUp(mbLeft, [], Msg.XPos, Msg.YPos);
  inherited;
end;  { WMContextMenu }

procedure TElSpinButton.CMMouseLeave(var Msg : TMessage);
begin
  inherited;
  if (Msg.LParam = 0) or (Msg.LParam = TLMDPtrInt(Self)) then
    begin
      FMouseInUpPart := false;
      FMouseInDownPart := false;
      Invalidate;
    end;
end; { CMMouseLeave }

procedure TElSpinButton.WMCancelMode(var Message: TWMCancelMode);
begin
  inherited;
  if FDragging or FTopBtnDown or FBottomBtnDown then
    MouseUp(mbLeft, [ssLeft], 0, 0);
end;

procedure TElSpinButton.SetUpArrowEnabled(Value: Boolean);
begin
  if FUpArrowEnabled <> Value then
  begin
    FUpArrowEnabled := Value;
    if Enabled then Invalidate;
  end;
end;

procedure TElSpinButton.SetDownArrowEnabled(Value: Boolean);
begin
  if FDownArrowEnabled <> Value then
  begin
    FDownArrowEnabled := Value;
    if Enabled then Invalidate;
  end;
end;

procedure TElSpinButton.SetMoneyFlat(Value: Boolean);
begin
  if FMoneyFlat <> Value then
  begin
    FMoneyFlat := Value;
    Invalidate;
  end;
end;

procedure TElSpinButton.SetMoneyFlatActiveColor(Value: TColor);
begin
  if FMoneyFlatActiveColor <> Value then
  begin
    FMoneyFlatActiveColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

procedure TElSpinButton.SetMoneyFlatDownColor(Value: TColor);
begin
  if FMoneyFlatDownColor <> Value then
  begin
    FMoneyFlatDownColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

procedure TElSpinButton.SetMoneyFlatInactiveColor(Value: TColor);
begin
  if FMoneyFlatInactiveColor <> Value then
  begin
    FMoneyFlatInactiveColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

function TElSpinButton.GetMoneyFlat: Boolean;
begin
  Result := FMoneyFlat;
end;

procedure TElSpinButton.SetOldStyled(Value: Boolean);
begin
  if FOldStyled <> Value then
  begin
    FOldStyled := Value;
    Invalidate;
  end;
end;

{$ifdef LMD_UNICODE}
{------------------------------------------------------------------------------}
procedure TElSpinButton.CMHintShow(var Message:TCMHintShow);
begin
  inherited;
  //LMDConvertVCLHintShow(inherited Hint, FHint, Message);//outcommented VB Dec 2008
end;

{------------------------------------------------------------------------------}
procedure TElSpinButton.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TElSpinButton.SetThinFrame(Value: Boolean);
begin
  if FThinFrame <> Value then
  begin
    FThinFrame := Value;
  end;
end;

procedure TElSpinButton.SetShowBorder(Value: Boolean);
begin
  if FShowBorder <> Value then
  begin
    FShowBorder := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElSpinButton.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('Caption', FakeStr, nil, false);
end;

function TElSpinButton.GetThemedElement: TThemedElement;
begin
  Result := teSpin;
end;

end.
