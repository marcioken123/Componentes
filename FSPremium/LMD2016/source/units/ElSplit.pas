unit ElSplit;
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

ElSplit unit
------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

  { TElSplitter component. }

interface

uses
  ElHook,
  ExtCtrls,
  Windows,
  SysUtils,
  Messages,
  Math,
  Classes,
  Graphics,
  Controls,
  Forms,
  Themes, UxTheme,
  Types,

  ElPanel,

  LMDThemes,
  LMDClass, 
  LMDProcs,
  LMDGraph,
  LMDGraphUtils;

type

  TElResizeStyle = (ersLine, ersPattern);

  TElSplitterEvent = procedure(Sender : TObject; var NewPos : integer; var Accept : boolean) of object;

  TElSplitter = class(TCustomElPanel)
  private
    FSnapTopLeft,
    FSnapBottomRight: boolean;
    FAutoHide : Boolean;
    FOldFocused : HWND;
    FDragging   : boolean;
    FOffset     : integer;
    FControlTopLeft : TControl;
    FControlBottomRight : TControl;
    FMinSizeTopLeft : Integer;
    FMinSizeBottomRight : Integer;
    FAutoSnap : Boolean;
    FLineVisible : boolean;
    FLineDC : HDC;
    FCurPos : integer;
    FSizeBeforeSnap: Integer;
    FLSizeBeforeSnap: Integer;
    FRSizeBeforeSnap: Integer;
    FLeftSnapButtonPushed: Boolean;
    FLeftSnapButtonPushing: Boolean;

    FRightSnapButtonPushed: Boolean;
    FRightSnapButtonPushing: Boolean;

    FShowSnapButton: Boolean;
    FSnapButtonCursor: TCursor;
    FSnapButtonColor: TColor;
    FSnapButtonDotColor: TColor;
    FSnapButtonArrowColor: TColor;
    FLeftHook,
    FRightHook : TElHook;
    FOnPositionChanged : TNotifyEvent;  { Defined in Classes unit. }
    FOnPositionChanging : TElSplitterEvent;

    function GetControlTopLeft : TControl;
    function GetControlBottomRight : TControl;
    procedure AfterMessage(Sender: TObject; var Msg: TMessage; var Handled: boolean);
    procedure SetMinSizeTopLeft(newValue : Integer);
    procedure SetControlTopLeft(newValue : TControl);
    procedure SetControlBottomRight(newValue : TControl);
    procedure DrawLine;
    procedure AllocateLineDC;
    procedure ReleaseLineDC;
    procedure SetAutoHide(newValue : Boolean);
    procedure UpdateAutoVis;
    function GetLeftSnapButtonRect: TRect;
    procedure RecalcCurPos(X, Y: Integer);
    procedure StopMode;
    procedure UpdateShowSnapButton;
    procedure SetSnapBottomRight(const Value: boolean);
    procedure SetSnapTopLeft(const Value: boolean);
    procedure SetShowSnapButton(const Value: Boolean);
    procedure DoSizing(L: Integer);
    procedure SetSnapButtonArrowColor(const Value: TColor);
    procedure SetSnapButtonColor(const Value: TColor);
    procedure SetSnapButtonDotColor(const Value: TColor);
    function GetRightSnapButtonRect: TRect;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
  protected
    FSnappedLeft: Boolean;
    FSnappedRight: Boolean;
    FResizeStyle: TElResizeStyle;
    FInvertSnapButtons: Boolean;
    FSnapOnly: Boolean;
    function FindControl: TControl;
    procedure TriggerPositionChangedEvent; virtual;
    procedure TriggerPositionChangingEvent(var NewPos : integer; var Accept : boolean); virtual;
    procedure WMCancelMode(var Msg: TWMCancelMode); message WM_CANCELMODE;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure Notification(AComponent : TComponent; operation : TOperation); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
//    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure StopSizing(X, Y : integer; Accept : boolean); virtual;
    procedure Loaded; override;
    // function GetThemedClassName: TLMDThemedItem; override;
    procedure RequestAlign; override;
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetInvertSnapButtons(Value: Boolean);
    // function GetArrowTheme: HTheme;
  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure Snap(SnapLeft : boolean);

    // property ArrowTheme: HTheme read GetArrowTheme;
    property SnappedLeft: Boolean read FSnappedLeft;
    property SnappedRight: Boolean read FSnappedRight;
    property SizeBeforeSnap: Integer read FSizeBeforeSnap write FSizeBeforeSnap;
  published
    { Published properties and events }
    property MinSizeTopLeft : Integer read FMinSizeTopLeft write SetMinSizeTopLeft default 20;  { Published }
    property MinSizeBottomRight : Integer read FMinSizeBottomRight write FMinSizeBottomRight default 20;  { Published }
    property AutoSnap : Boolean read FAutoSnap write FAutoSnap default False;  { Published }
    property SnapTopLeft : boolean read FSnapTopLeft write SetSnapTopLeft default true;
    property SnapBottomRight : boolean read FSnapBottomRight write SetSnapBottomRight default true;
    property ControlTopLeft : TControl read FControlTopLeft write SetControlTopLeft;
    property ControlBottomRight : TControl read FControlBottomRight write SetControlBottomRight;

    property AutoHide : Boolean read FAutoHide write SetAutoHide default False;  { Published }
    property ResizeStyle: TElResizeStyle read FResizeStyle write FResizeStyle
        default ersLine;
    property InvertSnapButtons: Boolean read FInvertSnapButtons write
        SetInvertSnapButtons default false;
    property SnapOnly: Boolean read FSnapOnly write FSnapOnly default false;

    property ShowSnapButton: Boolean read FShowSnapButton write SetShowSnapButton default false;
    property SnapButtonCursor: TCursor read FSnapButtonCursor write FSnapButtonCursor default crDefault;
    property SnapButtonColor: TColor read FSnapButtonColor write SetSnapButtonColor default clBtnHighlight;
    property SnapButtonDotColor: TColor read FSnapButtonDotColor write SetSnapButtonDotColor default clBtnShadow;
    property SnapButtonArrowColor: TColor read FSnapButtonArrowColor write SetSnapButtonArrowColor default clBtnShadow;

    property Align;
    property Cursor default crHSplit;
    property DoubleBuffered default False;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Enabled;
    property ParentColor;
    property ParentShowHint;
    property ParentThemeMode default true;
    property PopupMenu;
    property ShowHint;
    property Visible;
    property ThemeMode;
    property ThemeGlobalMode;
    property TransparentXPThemes;
    property OnPositionChanged : TNotifyEvent read FOnPositionChanged write FOnPositionChanged;
    property OnPositionChanging : TElSplitterEvent read FOnPositionChanging write FOnPositionChanging;
    { Inherited events: }
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
  end;  { TElSplitter }

implementation

uses
  ElVCLUtils;

procedure TElSplitter.SetMinSizeTopLeft(newValue : Integer);
{ Sets data member FMinSizeTopLeft to newValue. }
begin
  if (FMinSizeTopLeft <> newValue) then
  begin
    FMinSizeTopLeft := newValue;
  end;  { if }
end;  { SetMinSizeTopLeft }

{ Event triggers: }
procedure TElSplitter.TriggerPositionChangedEvent;
{ Triggers the OnPositionChanged event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnPositionChanged)) then
    FOnPositionChanged(Self);
end;  { TriggerPositionChangedEvent }

procedure TElSplitter.TriggerPositionChangingEvent(var NewPos : integer; var Accept : boolean);
{ Triggers the OnPositionChanging event. This is a virtual method (descendants of this component can override it). }
begin
  if (assigned(FOnPositionChanging)) then
    FOnPositionChanging(Self, NewPos , Accept );
end;  { TriggerPositionChangingEvent }

procedure TElSplitter.SetControlTopLeft(newValue : TControl);
begin
  if (FControlTopLeft <> newValue) then
  begin
    if (FControlTopLeft = Self) or (FControlTopLeft is TCustomForm) then
      newValue := nil;
    if FControlTopLeft <> nil then
      if not (csDestroying in FControlTopLeft.ComponentState) then
        FControlTopLeft.RemoveFreeNotification(Self);
    FControlTopLeft := newValue;
    if FControlTopLeft <> nil then
       FControlTopLeft.FreeNotification(Self);
    FLeftHook.Control := newValue;
    FLeftHook.Active := (NewValue <> nil);
  end;  { if }
end;  { SetControlTopLeft }

procedure TElSplitter.SetControlBottomRight(newValue : TControl);
begin
  if (FControlBottomRight <> newValue) then
  begin
    if (FControlBottomRight = Self) or (FControlBottomRight is TCustomForm) then newValue := nil;
    if FControlBottomRight <> nil then
      if not (csDestroying in FControlBottomRight.ComponentState) then
        FControlBottomRight.RemoveFreeNotification(Self);
    FControlBottomRight := newValue;
    if FControlBottomRight <> nil then
       FControlBottomRight.FreeNotification(Self);
    FRightHook.Control := newValue;
    FRightHook.Active := (NewValue <> nil);
  end;  { if }
end;  { SetControlBottomRight }

procedure TElSplitter.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
  begin
    if (AComponent = FControlTopLeft) then
       ControlTopLeft := nil;
    if (AComponent = FControlBottomRight) then
       ControlBottomRight := nil;
  end;  { if }
end;  { Notification }

procedure TElSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  { protected }
begin
  inherited MouseDown(Button, Shift, X, Y);
  if not (csDesigning in ComponentState) and (Button = mbLeft) then
  begin
    FOldFocused := GetFocus;
    SetCapture(Handle);
    if (not FShowSnapButton) or
       ((not PtInRect(GetLeftSnapButtonRect(), Point(X, Y))) and
        (not PtInRect(GetRightSnapButtonRect(), Point(X, Y)))) and
       (not SnapOnly) then
    begin
      FDragging := true;
      if Width > Height then
      begin
        FOffset := Y;
      end
      else
      begin
        FOffset := X;
      end;
      AllocateLineDC;
      RecalcCurPos(X, Y);
      DrawLine;
    end
    else
    begin
      if PtInRect(GetLeftSnapButtonRect(), Point(X, Y)) then
      begin
        FLeftSnapButtonPushing := True;
        FLeftSnapButtonPushed := True;
      end
      else
      if PtInRect(GetRightSnapButtonRect(), Point(X, Y)) then
      begin
        FRightSnapButtonPushing := True;
        FRightSnapButtonPushed := True;
      end;
      Invalidate;
    end;
  end;
end;  { MouseDown }

procedure TElSplitter.MouseMove(Shift: TShiftState; X, Y: Integer);  { protected }
var
  NewPushed: Boolean;
begin
  inherited MouseMove(Shift, X, Y);
  if FDragging then
  begin
    DrawLine;
    RecalcCurPos(X, Y);
    DrawLine;
  end;
  if FLeftSnapButtonPushing then
  begin
    NewPushed := PtInRect(GetLeftSnapButtonRect(), Point(X, Y));
    if NewPushed <> FLeftSnapButtonPushed then
    begin
      FLeftSnapButtonPushed := NewPushed;
      Invalidate;
    end;
  end
  else
  if FRightSnapButtonPushing then
  begin
    NewPushed := PtInRect(GetRightSnapButtonRect(), Point(X, Y));
    if NewPushed <> FRightSnapButtonPushed then
    begin
      FRightSnapButtonPushed := NewPushed;
      Invalidate;
    end;
  end;
end;  { MouseMove }

procedure TElSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);  { protected }
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDragging then
  begin
    ReleaseCapture;
    StopSizing(X, Y, true);
  end
  else
  if FLeftSnapButtonPushing then
  begin
    ReleaseCapture;
    if FLeftSnapButtonPushed then Snap(True);
    FLeftSnapButtonPushed := false;
    Invalidate;
  end
  else
  if FRightSnapButtonPushing then
  begin
    ReleaseCapture;
    if FRightSnapButtonPushed then Snap(false);
    FRightSnapButtonPushed := false;
    Invalidate;
  end;
  FDragging := false;
  FLeftSnapButtonPushing := false;
  FLeftSnapButtonPushed := false;
  FRightSnapButtonPushing := false;
  FRightSnapButtonPushed := false;
end;  { MouseUp }

procedure TElSplitter.StopSizing(X, Y : integer; Accept : boolean);
var l : integer;
    IsVertical : boolean;
begin
//  FRSizeBeforeSnap := -1;
  if FDragging then
  begin
    if ((Width > Height) and (FOffset = y)) or
       ((Width < Height) and (FOffset = x)) then
    begin
      ReleaseLineDC;
      Repaint;
      exit;
    end;
    DrawLine;
    ReleaseLineDC;
    if Accept then
    begin
      FSnappedLeft := False;
      FSnappedRight := False;

      isVertical := Width > Height;
      if IsVertical then
        l := FCurPos {Y} - FOffset + Top
      else
        l := FCurPos {X} - FOffset + Left;
      if (l < MinSizeTopLeft) then
      begin
        if FAutoSnap and FSnapTopLeft then
        begin
          l := 0;
          FSnappedLeft := True;
        end
        else
          l := MinSizeTopLeft;
      end
      else
      if  ((l > Parent.ClientWidth - FMinSizeBottomRight - Width) and (not IsVertical)) or
           ((l > Parent.ClientHeight - FMinSizeBottomRight - Height) and (IsVertical)) then
      begin
        if FAutoSnap and FSnapBottomRight then
        begin
          if IsVertical then
            l := Parent.ClientHeight - Height
          else
            l := Parent.ClientWidth - Width;
          FSnappedRight := True;
        end else
        begin
          if IsVertical then
             L := Parent.ClientHeight - FMinSizeBottomRight - Height
          else
             L := Parent.ClientWidth - FMinSizeBottomRight - Width;
        end;
      end;
      DoSizing(l);
    end;
    if GetControlTopLeft <> nil then
    begin
      if Width > Height then
        FLSizeBeforeSnap := GetControlTopLeft.Height
      else
        FLSizeBeforeSnap := GetControlTopLeft.Width;
    end;
    if GetControlBottomRight <> nil then
    begin
      if Width > Height then
        FRSizeBeforeSnap := GetControlBottomRight.Height
      else
        FRSizeBeforeSnap := GetControlBottomRight.Width;
    end;
    FDragging := false;
  end;
end;

procedure TElSplitter.AllocateLineDC;
begin
  FLineDC := GetDCEx(Handle, 0, DCX_CACHE {or DCX_CLIPSIBLINGS }or DCX_PARENTCLIP
    or DCX_LOCKWINDOWUPDATE);
end;

procedure TElSplitter.ReleaseLineDC;
begin
  ReleaseDC(Handle, FLineDC);
end;

procedure TElSplitter.DrawLine;
begin
  FLineVisible := not FLineVisible;
  if ResizeStyle = ersPattern then
  begin
    if Width > Height then
       PatBlt(FLineDC, 0, FCurPos, Width, Height, PATINVERT)
    else
       PatBlt(FLineDC, FCurPos, 0, Width, Height, PATINVERT);
  end
  else
  begin
    if Width > Height then
       PatBlt(FLineDC, 0, FCurPos + FOffset, Width, 1, PATINVERT)
    else
       PatBlt(FLineDC, FCurPos + FOffset, 0, 1, Height, PATINVERT);
  end;
end;

procedure TElSplitter.UpdateAutoVis;
begin
  if (FControlTopLeft <> nil) and (not FControlTopLeft.Visible) then Visible := false;
  if (FControlBottomRight <> nil) and (not FControlBottomRight.Visible) then Visible := false;
  if (FControlTopLeft <> nil) and (FControlBottomRight <> nil) and
     FControlTopLeft.Visible and FControlBottomRight.Visible then Visible := true;
end;

procedure TElSplitter.SetAutoHide(newValue : Boolean);
{ Sets data member FAutoHide to newValue. }
begin
  if (FAutoHide <> newValue) then
  begin
    FAutoHide := newValue;
    if FAutoHide then
    begin
      if not (csLoading in ComponentState) then
        UpdateAutoVis;
    end;
  end;  { if }
end;  { SetAutoHide }

procedure TElSplitter.AfterMessage(Sender: TObject; var Msg: TMessage; var Handled: boolean);
begin
  if (Msg.Msg = CM_VISIBLECHANGED) and AutoHide then
     UpdateAutoVis;
end;

procedure TElSplitter.Loaded;
begin
  inherited;
  if AutoHide then
  begin
    FAutoHide := false;
    AutoHide  := true;
  end;
  FSizeBeforeSnap := Max(MinSizeTopLeft, MinSizeBottomRight);
  FLSizeBeforeSnap := MinSizeTopLeft;
  FRSizeBeforeSnap := MinSizeBottomRight;
  if GetControlTopLeft <> nil then
  begin
    if Width > Height then
      FLSizeBeforeSnap := GetControlTopLeft.Height
    else
      FLSizeBeforeSnap := GetControlTopLeft.Width;
  end;
  if GetControlBottomRight <> nil then
  begin
    if Width > Height then
      FRSizeBeforeSnap := GetControlBottomRight.Height
    else
      FRSizeBeforeSnap := GetControlBottomRight.Width;
  end;
end;

destructor TElSplitter.Destroy;
begin
  FLeftHook.Free;
  FRighthook.Free;
  FLeftHook  := nil;
  FRightHook := nil;
  inherited Destroy;
end;  { Destroy }

constructor TElSplitter.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FSizeBeforeSnap := 20;
  FLSizeBeforeSnap := 20;
  FRSizeBeforeSnap := 20;
  FMinSizeTopLeft := 20;
  FMinSizeBottomRight := 20;
  FAutoSnap := False;
  FSnapTopLeft := true;
  FSnapBottomRight := true;
  FShowSnapButton := false;
  ControlStyle := ControlStyle - [csSetCaption, csCaptureMouse, csAcceptsControls];
  TabStop := false;
  Align := alLeft;
  Width := 5;
  Cursor := crHSplit;
  FSnapButtonCursor := crDefault;
  FSnapButtonColor := clBtnHighlight;
  FSnapButtonDotColor := clBtnShadow;
  FSnapButtonArrowColor := clBtnShadow;
  FLeftHook := TElHook.Create(nil);
  FLeftHook.OnAfterProcess := AfterMessage;
  FRightHook := TElHook.Create(nil);
  FRightHook.OnAfterProcess := AfterMessage;
end;  { Create }

procedure TElSplitter.WMCancelMode(var Msg: TWMCancelMode);
begin
  StopMode;
  Inherited;
  Msg.Result := 0;
end;

procedure TElSplitter.Paint;
var
  R1, R2: TRect;
  I, J: Integer;
  DC: HDC;
  Dir: TLMDArrowDir;
  ext: integer;
  RClip: TRect;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
  procedure IntDrawArrow(const R: TRect);
  const
    States: array[TLMDArrowDir] of Integer = (
      // eadLeft, eadUp, eadRight, eadDown
      ABS_LEFTNORMAL, ABS_UPNORMAL, ABS_RIGHTNORMAL, ABS_DOWNNORMAL
    );
  begin
    if LUseThemeMode <> ttmNone then
    begin
      LDetails.Element := teScrollBar;
      LDetails.Part := SBP_ARROWBTN;
      LDetails.State := States[Dir];
      LMDThemeServices.DrawElement(LUseThemeMode, DC, LDetails, R, LMDRectToPtr(RClip));
    end
    else
    begin
      LMDDrawArrow(Canvas, Dir, R, SnapButtonArrowColor, True);
    end;
  end;

  procedure DrawSnapButton(R1 : TRect; LeftButton : boolean);
  var b : boolean;
  begin
    if Width > Height then
    begin
      if (LeftButton and not FSnappedLeft) or
         ((not LeftButton) and FSnappedRight) then
      begin
        Dir := eadUp;
      end
      else
      begin
        Dir := eadDown;
      end;
    end
    else
    begin
      if (LeftButton and not FSnappedLeft) or
         ((not LeftButton) and FSnappedRight) then
      begin
        Dir := eadLeft;
      end
      else
      begin
        Dir := eadRight;
      end;
    end;
    if LUseThemeMode <> ttmNone then
    begin
      LMDThemeServices.DrawThemeEdge(LUseThemeMode, DC, teToolBar, TP_BUTTON, TS_HOT, R1,
        BDR_RAISEDOUTER, BF_ADJUST or BF_FLAT or BF_MONO or BF_RECT or BF_SOFT, LMDRectToPtr(R1));
    end
    else
    begin
      b := (LeftButton and FLeftSnapButtonPushed) or
           ((not LeftButton) and FRightSnapButtonPushed);

      DrawButtonFrameEx3(DC, R1, False, b, SnapButtonColor, False, AllBorderSides);
      InflateRect(R1, -1, -1);

      LMDFillSolidRect(DC, R1, ColorToRGB(SnapButtonColor));
      InflateRect(R1, -1, -1);
    end;

    if LUseThemeMode <> ttmNone then ext := 14 else ext := 7;

    R2 := R1;
    if Width > Height then
    begin
      if Width > (ext + 6) * 2 then
        InflateRect(R1, -12, 0);
    end
    else
    begin
      if Height > (ext + 6) * 2 then
        InflateRect(R1, 0, -12);
    end;

    if LUseThemeMode <> ttmNone then
    begin
      I := R1.Left;
      while I < R1.Right do
      begin
        J := R1.Top;
        while J < R1.Bottom do
        begin
          LMDThemeServices.DrawElement(LUseThemeMode, DC, ttbButtonHot, Bounds(I, J, 1, 1), LMDRectToPtr(RClip)); 

          Inc(J, 2);
        end;
        Inc(I, 3);
      end;
    end
    else
    begin
    Canvas.Pen.Color := SnapButtonDotColor;
    DC := Canvas.Handle;
    I := R1.Left;
    while I < R1.Right do
    begin
      J := R1.Top;
      while J < R1.Bottom do
      begin
        MoveToEx(DC, I, J, nil);
        LineTo(DC, I, Succ(J));
        Inc(J, 2);
      end;
      Inc(I, 2);
    end;
    end;

    R1 := R2;
    InflateRect(R1, 1, 1);
    R2 := R1;
    if Width > Height then
    begin
      if Width > (ext + 6) * 2 then
      begin
        if (R1.Bottom - R1.Top) shr 1 = 1 then
          dec(R1.Bottom);
        R1.Left := R2.Left + 3;
        R1.Right := R1.Left + ext;
        IntDrawArrow(R1);
        R1.Left := R2.Right - ext - 3;
        R1.Right := R2.Right - 3;
        IntDrawArrow(R1);
      end;
    end
    else
    begin
      if Height > (ext + 6) * 2 then
      begin
        if (R1.Right - R1.Left) shr 1 = 1 then
          dec(R1.Right);

        R1.Top := R2.Top + 3;
        R1.Bottom := R1.Top + ext;
        IntDrawArrow(R1);
        R1.Top := R2.Bottom - ext - 3;
        R1.Bottom := R2.Bottom - 3;
        IntDrawArrow(R1);
      end;
    end;
  end;

begin
  LUseThemeMode := UseThemeMode; 
  DC := Canvas.Handle;
  RClip := Canvas.ClipRect;
  if LUseThemeMode <> ttmNone then
  begin
    LMDThemeServices.DrawElement(LUseThemeMode, DC, ttbButtonHot, ClientRect, LMDRectToPtr(RClip));
  end
  else
  begin
    inherited;
  end;
  if FShowSnapButton then
  begin
    R1 := GetLeftSnapButtonRect();
    if not IsRectEmpty(R1) then
      DrawSnapButton(R1, true);

    R1 := GetRightSnapButtonRect();
    if not IsRectEmpty(R1) then
      DrawSnapButton(R1, false);
  end;
end;

function TElSplitter.GetLeftSnapButtonRect: TRect;
var
  aBW: Integer;
begin
  SetRectEmpty(Result);
  if FShowSnapButton and SnapTopLeft then
  begin
    if (BevelInner = bvNone) and (BevelOuter = bvNone) then
      aBW := 0
    else
    if (BevelInner = bvNone) xor (BevelOuter = bvNone) then
      aBW := 2 * BevelWidth
    else
      aBW := 4 * BevelWidth;

    if Width > Height then
    begin
      if (Width shr 1 >= aBW) and (Height - aBW > 1) then
      begin
        if SnapBottomRight then
        begin
          if InvertSnapButtons then
            Result := Bounds(Width shr 1, aBW shr 1, Width shr 2, Height - aBW)
          else
            Result := Bounds(Width shr 2, aBW shr 1, Width shr 2, Height - aBW)
        end
        else
          Result := Bounds(Width shr 2, aBW shr 1, Width shr 1, Height - aBW);
      end;
    end
    else
    begin
      if (Height shr 1 >= aBW) and (Width - aBW > 1) then
      begin
        if SnapBottomRight then
        begin
          if InvertSnapButtons then
            Result := Bounds(aBW shr 1, Height shr 2, Width - aBW, Height shr 2)
          else
            Result := Bounds(aBW shr 1, Height shr 2, Width - aBW, Height shr 2);
        end
        else
          Result := Bounds(aBW shr 1, Height shr 2, Width - aBW, Height shr 1);
      end;
    end;
  end;
end;

procedure TElSplitter.StopMode;
begin
  if MouseCapture then
  begin
    ReleaseCapture;
  end;
  if FDragging then
    StopSizing(0, 0, False);

  if FLeftSnapButtonPushing then
  begin
    FLeftSnapButtonPushed := False;
    FLeftSnapButtonPushing := False;
    Invalidate;
  end;
  if FRightSnapButtonPushing then
  begin
    FRightSnapButtonPushed := False;
    FRightSnapButtonPushing := False;
    Invalidate;
  end;
end;

procedure TElSplitter.SetSnapBottomRight(const Value: boolean);
begin
  FSnapBottomRight := Value;
  UpdateShowSnapButton;
end;

procedure TElSplitter.SetSnapTopLeft(const Value: boolean);
begin
  FSnapTopLeft := Value;
  UpdateShowSnapButton;
end;

procedure TElSplitter.UpdateShowSnapButton;
begin
  if not (FSnapTopLeft or FSnapBottomRight) then
    FShowSnapButton := false;
  Invalidate;
end;

procedure TElSplitter.SetShowSnapButton(const Value: Boolean);
begin
  FShowSnapButton := Value;
  UpdateShowSnapButton;
end;

procedure TElSplitter.Snap(SnapLeft : boolean);
var
  l, i, k : integer;
  LControl: TControl;
begin
  if FShowSnapButton then
  begin
    if ((not FSnappedLeft) and
       (not FSnappedRight)) or
       ((FSnappedLeft and (not SnapLeft)) or
       (FSnappedRight and (SnapLeft))) then
    begin
      if FSnappedLeft or FSnappedRight then
      begin
        FSnappedLeft := false;
        FSnappedRight:= false;
        DoSizing(FSizeBeforeSnap);
      end;
      if SnapLeft then
        FSnappedLeft := true
      else
        FSnappedRight := true;

      if Width > Height then
      begin
        if SnapLeft then
        begin
          l := 0;
          if Assigned(FControlTopLeft) and (FControlTopLeft.Constraints.MinHeight > 0) then
            L := FControlTopLeft.Constraints.MinHeight;
        end
        else
        begin
          LControl := GetControlBottomRight;
          if Assigned(LControl) then
            l := LControl.Top + LControl.Height - LControl.Constraints.MaxHeight - Height
          else
          begin
            k := 0;
            for i := 0 to Parent.ControlCount - 1 do
            begin
              if Parent.Controls[i] <> FControlTopLeft then
                k := k + Parent.Controls[i].Constraints.MinHeight;
              if Parent.Controls[i] is TElSplitter then
                inc(k, Parent.Controls[i].Height);
            end;
            l := Parent.ClientHeight - k;
          end;
          if Assigned(FControlTopLeft) and (FControlTopLeft.Constraints.MaxHeight > 0) then
            l := min(l, FControlTopLeft.Constraints.MaxHeight);
        end;
      end
      else
      begin
        if SnapLeft then
        begin
          l := 0;
          if Assigned(FControlTopLeft) and (FControlTopLeft.Constraints.MinWidth > 0) then
            L := FControlTopLeft.Constraints.MinWidth;
        end
        else
        begin
          LControl := GetControlBottomRight;
          if Assigned(LControl) then
            l := LControl.Left + LControl.Width - LControl.Constraints.MaxWidth - Width
          else
          begin
            k := 0;
            for i := 0 to Parent.ControlCount - 1 do
            begin
              if Parent.Controls[i] <> FControlTopLeft then
                k := k + Parent.Controls[i].Constraints.MinWidth;
              if Parent.Controls[i] is TElSplitter then
                inc(k, Parent.Controls[i].Width);
            end;
            l := Parent.ClientWidth - k;
          end;
          if Assigned(FControlTopLeft) and (FControlTopLeft.Constraints.MaxWidth > 0) then
            l := min(l, FControlTopLeft.Constraints.MaxWidth);
        end;
      end;
    end
    else
    begin
      FSnappedLeft := false;
      FSnappedRight:= false;
      l := FSizeBeforeSnap;
    end;
    DoSizing(l);
  end;
end;

procedure TElSplitter.DoSizing(L: Integer);
var
  Accept  : Boolean;
  CtlRect : TRect;
  LOffset: integer;
begin
  Accept := True;
  LOffset := 0;
  TriggerPositionChangingEvent(L, Accept);
  if Accept then
  begin
    Parent.DisableAlign;
    if Width > Height then
    begin
      if FSnappedLeft or FSnappedRight then
        FSizeBeforeSnap := Top;
      if FSnappedLeft and (GetControlTopLeft <> nil) then
        FLSizeBeforeSnap := GetControlTopLeft.Height;
//      else
//        if FSnappedRight and Assigned(FControlBottomRight) then
//          FLSizeBeforeSnap := FControlBottomRight.Top - Height;
      if FSnappedRight and (GetControlBottomRight <> nil) then
       FRSizeBeforeSnap := GetControlBottomRight.Height;

      if (FControlTopLeft <> nil) then
      begin
        FControlTopLeft.Height := min(Parent.Height, max(0, L - FControlTopLeft.Top));
        L := FControlTopLeft.Top + FControlTopLeft.Height;
      end;

      if Assigned(FControlTopLeft) and Assigned(FControlBottomRight) then
      begin
        if FControlTopLeft.Align = alClient then
        begin
          Top := L - FControlTopLeft.Top;
          LOffset := FControlBottomRight.Height + FControlBottomRight.Top - Top - Height - FRSizeBeforeSnap;
        end
        else
          if FControlBottomRight.Align = alClient then
            Top := FControlTopLeft.Top + FControlTopLeft.Height + 1
          else
            Top := FControlTopLeft.Top + FControlTopLeft.Height;
      end
      else
        Top := L;

      if (FControlBottomRight <> nil) then
      begin
        if FSnappedLeft or FSnappedRight then
          CtlRect := Rect(FControlBottomRight.Left, L + Height, FControlBottomRight.Width, FControlBottomRight.Height - ((L + Height) - FControlBottomRight.Top))
        else
          if FRSizeBeforeSnap > 0 then
            CtlRect := Rect(FControlBottomRight.Left, L + Height, FControlBottomRight.Width, FRSizeBeforeSnap + LOffset)
          else
            CtlRect := Rect(FControlBottomRight.Left, L + Height, FControlBottomRight.Width, FControlBottomRight.Height - (L + Height - FControlBottomRight.Top));

        with CtlRect do
          FControlBottomRight.SetBounds(Left, Top, Right, Bottom);
      end;
    end
    else
    begin
      if FSnappedLeft or FSnappedRight then
        FSizeBeforeSnap := Left;
      if FSnappedLeft and (GetControlTopLeft <> nil) then
       FLSizeBeforeSnap := GetControlTopLeft.Width
      else
        if FSnappedRight and Assigned(FControlBottomRight) then
          FLSizeBeforeSnap := FControlBottomRight.Left - Width;
      if FSnappedRight and (GetControlBottomRight <> nil) then
        FRSizeBeforeSnap := GetControlBottomRight.Width;
      if (FControlTopLeft <> nil) then
      begin
        FControlTopLeft.Width := min(Parent.Width, max(0, L - FControlTopLeft.Left));
        L := FControlTopLeft.Width + FControlTopLeft.Left;
      end;
      if Assigned(FControlTopLeft) and Assigned(FControlBottomRight) then
      begin
        if FControlTopLeft.Align = alClient then
        begin
          Left := FControlTopLeft.Left + FControlTopLeft.Width - 1;
          LOffset := FControlBottomRight.Width + FControlBottomRight.Left - Left - Width - FRSizeBeforeSnap;
        end
        else
          if FControlBottomRight.Align = alClient then
            Left := FControlTopLeft.Left + FControlTopLeft.Width + 1
          else
            Left := FControlTopLeft.Left + FControlTopLeft.Width;
      end
      else
        Left := L;
      if (FControlBottomRight <> nil) then
      begin
        if FSnappedLeft or FSnappedRight then
          CtlRect := Rect(L + Width, FControlBottomRight.Top, FControlBottomRight.Width - (L + Width - FControlBottomRight.Left), FControlBottomRight.Height)
        else
          if FRSizeBeforeSnap > 0 then
            CtlRect := Rect(L + Width, FControlBottomRight.Top, LOffset + FRSizeBeforeSnap, FControlBottomRight.Height)
          else
            CtlRect := Rect(L + Width, FControlBottomRight.Top, FControlBottomRight.Width - (L + Width - FControlBottomRight.Left), FControlBottomRight.Height);

        with CtlRect do
          FControlBottomRight.SetBounds(Left, Top, Right, Bottom);
      end;
    end;

//    Parent.ControlState := ControlState - [csAlignmentNeeded];
    if Assigned(FControlTopLeft) then
    begin
      if (FControlTopLeft.Left = 0) then
      begin
        Parent.EnableAlign;
        FControlTopLeft.Left := 0;
      end
      else
        Parent.EnableAlign;
    end;
    TriggerPositionChangedEvent;
  end;
end;

procedure TElSplitter.WMSetCursor(var Msg: TWMSetCursor);
var
  C: TCursor;
  CP: TPoint;
begin
  Msg.Result := 1;
  if Msg.CursorWnd = Handle then
  begin
    C := Screen.Cursor;
    if (C = crDefault) and not (csDesigning in ComponentState) then
    begin
      GetCursorPos(CP);
      if FShowSnapButton and
       (PtInRect(GetLeftSnapButtonRect(), ScreenToClient(CP)) or
        PtInRect(GetRightSnapButtonRect(), ScreenToClient(CP))) then
      begin
        C := SnapButtonCursor;
      end
      else
      begin
        C := Cursor;
      end;
    end;
    SetCursor(Screen.Cursors[C]);
  end
  else
    Inherited;
end;

procedure TElSplitter.SetSnapButtonArrowColor(const Value: TColor);
begin
  if FSnapButtonArrowColor <> Value then
  begin
    FSnapButtonArrowColor := Value;
    if FShowSnapButton then
    begin
      Invalidate;
    end;
  end;
end;

procedure TElSplitter.SetSnapButtonColor(const Value: TColor);
begin
  if FSnapButtonColor <> Value then
  begin
    FSnapButtonColor := Value;
    if FShowSnapButton then
    begin
      Invalidate;
    end;
  end;
end;

procedure TElSplitter.SetSnapButtonDotColor(const Value: TColor);
begin
  if FSnapButtonDotColor <> Value then
  begin
    FSnapButtonDotColor := Value;
    if FShowSnapButton then
    begin
      Invalidate;
    end;
  end;
end;

procedure TElSplitter.RecalcCurPos(X, Y: Integer);
var Mrg1,
    Mrg2  : integer;
    i, k: integer;
    LControl: TControl;
begin
  if AutoSnap then
  begin
    Mrg1 := 0;
    Mrg2 := 0;
  end else
  begin
    Mrg1 := MinSizeTopLeft;
    Mrg2 := MinSizeBottomRight;
  end;
  if Width <= Height then
  begin
    k := 0;
    if x > 0 then
    begin
      LControl := GetControlBottomRight;
      if Assigned(LControl) then
        FCurPos := Min(X - FOffset, LControl.Left + LControl.Width - LControl.Constraints.MinWidth - Left - Width)
      else
      begin
        for i := 0 to Parent.ControlCount - 1 do
        begin
          if Parent.Controls[i].Left > Left then
          begin
            k := k + Parent.Controls[i].Constraints.MinWidth;
            if Parent.Controls[i] is TElSplitter then
              inc(k, Parent.Controls[i].Width);
          end;
        end;
        FCurPos := Min(Max(Mrg1-Left, X - FOffset), Parent.ClientWidth - Left - Width - Mrg2 - k);
      end;
    end
    else
    begin
      LControl := GetControlTopLeft;
      if Assigned(LControl) then
        FCurPos := Max(LControl.Left + LControl.Constraints.MinWidth - Mrg1 - Left, X - FOffset)
      else
        FCurPos := Max(Mrg1 - Left, X - FOffset);
    end;
  end
  else
  begin
    k := 0;
    if x > 0 then
    begin
      LControl := GetControlBottomRight;
      if Assigned(LControl) then
        FCurPos := Min(Max(Mrg1 -Top, Y - FOffset), LControl.Top + LControl.Height - LControl.Constraints.MinHeight - Top - Height)
      else
      begin
        for i := 0 to Parent.ControlCount - 1 do
        begin
          if (Parent.Controls[i].Top > Top + Height) then
          begin
            k := k + Parent.Controls[i].Constraints.MinHeight;
            if Parent.Controls[i] is TElSplitter then
              inc(k, Parent.Controls[i].Height);
          end;
        end;
        FCurPos := Min(Max(Mrg1 -Top, Y - FOffset), Parent.ClientHeight - Top - Height - Mrg2 - k);
      end;
    end
    else
    begin
      LControl := GetControlTopLeft;
      if Assigned(LControl) then
        FCurPos := Max(LControl.Top + LControl.Constraints.MinHeight - Mrg1 - Top, Y - FOffset)
      else
        FCurPos := Max(Mrg1 -Top, Y - FOffset);
    end;
  end;
end;

procedure TElSplitter.RequestAlign;
begin
  inherited;
  if (Cursor = crHSplit) or (Cursor = crVSplit)then
  begin
    if Align in [alBottom, alTop] then
      Cursor := crVSplit
    else
      Cursor := crHSplit;
  end;
end;

procedure TElSplitter.SetUseXPThemes(const Value: Boolean);
begin
  if UseXPThemes <> Value then
    inherited;
end;

{
function TElSplitter.GetThemedClassName: TLMDThemedItem;
begin
  Result := tiToolBar;
end;
}

function TElSplitter.GetRightSnapButtonRect: TRect;
var
  aBW: Integer;
begin
  SetRectEmpty(Result);
  if FShowSnapButton  and SnapBottomRight then
  begin
    if (BevelInner = bvNone) and (BevelOuter = bvNone) then
      aBW := 0
    else
    if (BevelInner = bvNone) xor (BevelOuter = bvNone) then
      aBW := 2 * BevelWidth
    else
      aBW := 4 * BevelWidth;

    if Width > Height then
    begin
      if (Width shr 1 >= aBW) and (Height - aBW > 1) then
      begin
        if SnapTopLeft then
        begin
          if InvertSnapButtons then
            Result := Bounds(Width shr 2, aBW shr 1, Width shr 2, Height - aBW)
          else
            Result := Bounds(Width shr 1, aBW shr 1, Width shr 2, Height - aBW)
        end
        else
          Result := Bounds(Width shr 2, aBW shr 1, Width shr 1, Height - aBW);
      end;
    end
    else
    begin
      if (Height shr 1 >= aBW) and (Width - aBW > 1) then
      begin
        if SnapTopLeft then
        begin
          if InvertSnapButtons then
            Result := Bounds(aBW shr 1, Height shr 2, Width - aBW, Height shr 2)
          else
            Result := Bounds(aBW shr 1, Height shr 1, Width - aBW, Height shr 2);
        end
        else
          Result := Bounds(aBW shr 1, Height shr 2, Width - aBW, Height shr 1);
      end;
    end;
  end;
end;

procedure TElSplitter.SetInvertSnapButtons(Value: Boolean);
begin
  if FInvertSnapButtons <> Value then
  begin
    FInvertSnapButtons := Value;
    Invalidate;
  end;
end;

procedure TElSplitter.WMSize(var Msg: TWMSize);
begin
  if Width > Height then
  begin
    if FSnappedRight then
    begin
      if Assigned(FControlBottomRight) and (FSizeBeforeSnap > Parent.Height) then
        FSizeBeforeSnap := Parent.ClientHeight - FRSizeBeforeSnap
      else
       if Assigned(FControlTopLeft) and (FSizeBeforeSnap < Parent.ClientHeight) then
       begin
         if FControlTopLeft.Align <> alClient then
         begin
           if Top + Height < Parent.ClientHeight then
           begin
             FSnappedLeft := False;
             FSnappedRight := False;
           end
           else
           begin
             FSizeBeforeSnap := max(Parent.ClientHeight - FRSizeBeforeSnap - FControlTopLeft.Top, FMinSizeBottomRight);
             FControlTopLeft.Height := Parent.ClientHeight - Height - FControlTopLeft.Top;
             Top := Parent.ClientHeight - Height;
           end;
         end;
       end;
    end;
    if FSnappedLeft and Assigned(FControlTopLeft) and (FSizeBeforeSnap > Parent.Height) then
      FSizeBeforeSnap := max(Parent.ClientHeight - FLSizeBeforeSnap, FMinSizeTopLeft);
  end
  else
  begin
    if FSnappedRight then
    begin
      if Assigned(FControlBottomRight) and (FSizeBeforeSnap > Parent.ClientWidth) then
        FSizeBeforeSnap := Parent.ClientWidth - FRSizeBeforeSnap
      else
       if Assigned(FControlTopLeft) and (FSizeBeforeSnap < Parent.ClientWidth) then
       begin
         if FControlTopLeft.Align <> alClient then
         begin
           if Left + Width < Parent.ClientWidth then
           begin
             FSnappedLeft := False;
             FSnappedRight := False;
           end
           else
           begin
             FSizeBeforeSnap := max(Parent.ClientWidth - FRSizeBeforeSnap - FControlTopLeft.Left, FMinSizeBottomRight);
             if FControlTopLeft.Constraints.MinWidth > 0 then
             begin
               FControlTopLeft.Width := max(FControlTopLeft.Constraints.MinWidth ,Parent.ClientWidth - Width - FControlTopLeft.Left);
               Left := Parent.ClientWidth - Width;
             end
             else
             begin
               FControlTopLeft.Width := Parent.ClientWidth - Width - FControlTopLeft.Left;
               Left := Parent.ClientWidth - Width;
             end;
           end;
         end;
       end;
    end;
    if FSnappedLeft and Assigned(FControlTopLeft) and (FSizeBeforeSnap > Parent.Width) then
      FSizeBeforeSnap := max(Parent.ClientWidth - FLSizeBeforeSnap, FMinSizeTopLeft);
  end;
end;

{function TElSplitter.GetArrowTheme: HTheme;
begin
  result := LMDThemeService.Theme[tiScrollBar];
end;}

function TElSplitter.GetControlBottomRight: TControl;
begin
  if Assigned(FControlBottomRight) then
    Result := FControlBottomRight
  else
    Result := FindControl;
end;

function TElSplitter.GetControlTopLeft: TControl;
begin
  if Assigned(FControlTopLeft) then
    Result := FControlTopLeft
  else
    Result := FindControl;
end;

function TElSplitter.FindControl: TControl;
var
  P: TPoint;
  I: Integer;
  R: TRect;
begin
// same for TSplitter
  Result := nil;
  if not Assigned(Parent) then
    exit;
  P := Point(Left, Top);
  case Align of
    alLeft: Dec(P.X);
    alRight: Inc(P.X, Width);
    alTop: Dec(P.Y);
    alBottom: Inc(P.Y, Height);
  else
    Exit;
  end;
  for I := 0 to Parent.ControlCount - 1 do
  begin
    Result := Parent.Controls[I];
    if Result.Visible and Result.Enabled then
    begin
      R := Result.BoundsRect;
      if (R.Right - R.Left) = 0 then
        if Align in [alTop, alLeft] then
          Dec(R.Left)
        else
          Inc(R.Right);
      if (R.Bottom - R.Top) = 0 then
        if Align in [alTop, alLeft] then
          Dec(R.Top)
        else
          Inc(R.Bottom);
      if PtInRect(R, P) then Exit;
    end;
  end;
  Result := nil;
end;

end.
