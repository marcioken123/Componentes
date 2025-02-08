unit LMDSBar;
{$I lmdcmps.Inc}

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

LMDSBar unit (JH)
-----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  LMDObject, LMDSpinButton, LMDClass, LMDCaret, LMDFillObject, LMDBevel,
  LMDCustomBevelPanel, LMDCustomPanelFill;

type
  TLMDScrollBarThumb = class (TLMDCustomPanelFill)
  private
    FMousePressed: Boolean;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseExit; override;
    procedure MouseEnter; override;
    public
    procedure CreateGripBmp (vertical: Boolean);
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    property Bevel;
    property Color;
    property Ctl3D;
    property FillObject;
    property Flat;
    property ParentCtl3D;
    property Visible;
    property Transparent;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
  end;

  TLMDScrollBarKind = (skVertical, skHorizontal);
  TLMDThumbMode = (tmFixed, tmAuto);
  TLMDBackStyle = (bsDefault, bsUser);
  { -------------------------------------------------------------------------- }
  TLMDScrollBar = class(TLMDCustomBevelPanel)
  private
    FTimerId    : TLMDTimer;
    MX, MY,
    FMin,
    FMax,
    FSmall,
    FLarge,
    FThumbLength,
    FButtonWidth,
    FBarWidth,
    FPosition   : Integer;
    FOldPosition: Integer;

    FKind       : TLMDScrollBarKind;
    FBack       : TLMDFillObject;
    FThumbMode  : TLMDThumbMode;
    FBackStyle  : TLMDBackStyle;
    FOnScroll   : TScrollEvent;
    FThumbCursor: TCursor;
    FThumbBevel : TLMDBevel;
    FThumbFlat,
    FAllowMousePos,
    FCanBeFocused : Boolean;
    //internal Variables
    FCaret      : TLMDCaret;
    FBtnS       : TLMDScrollBarThumb;
    FBtn1,
    FBtn2       : TLMDSpinButton;
    FPaintRect  : TRect;
    FB          : TBitmap;
    FMoveThumb  : Boolean;

    FMousePos   : TPoint;
    FThumbColor : TColor;
    FTrackLength: integer;

    // 7.0
    FUseGlobalTimer: Boolean;
    FHideFocus: Boolean;
    // ---
    procedure SetBack (aValue : TLMDFillObject);
    procedure SetKind (aValue: TLMDScrollBarKind);
    procedure SetInteger (index, aValue : Integer);
    procedure SetCanBeFocused (aValue : Boolean);
    procedure SetBoolean (aValue : Boolean);
    procedure SetThumbBevel (aValue : TLMDBevel);
    procedure SetColor(aValue : TColor);
    procedure SetBackStyle(aValue: TLMDBackStyle);

    procedure DoThumbMouseDown (Sender : TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoThumbMouseUp (Sender : TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoThumbMouseMove (Sender : TObject; Shift : TShiftState; X, Y : Integer);

    procedure CMEnabledChanged (var Msg : TMessage); message CM_ENABLEDCHANGED;
    {$IFDEF LMDCOMP16}
    procedure CMStyleChanged(var Msg:TMessage); message CM_STYLECHANGED;
    {$ENDIF}

    procedure WMGetDlgCode(var Msg : TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMSetFocus(var Msg : TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    procedure WMKeyDown(var Msg : TWMKeyDown); message WM_KEYDOWN;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
    procedure DoTimerEvent (Sender : TObject);
    function  GetDelta: integer;
  protected
    // 6.1
    procedure DoThemeChanged;override;
    // ---
    procedure ExecuteEvent (event : TScrollCode);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove (Shift : TShiftState; X, Y : Integer); override;
    procedure MouseExit; override;
    function  GetFillObject: TLMDFillObject; override;

    procedure SetButtons;
    procedure RefreshBackground;
    procedure DrawThemeBevel(aTheme: TLMDThemeMode; aCanvas: TCanvas; aRect: TRect); override;
    procedure DoInc(Sender : TObject);
    procedure DoDec(Sender : TObject);
    //<-- VB Nov 2006
    procedure DoSpinBtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoSpinBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CheckBounds;
    //-->
    procedure EnableTimer;
    procedure RemoveTimer;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    procedure Loaded; override;
    procedure Paint; override;
    procedure CalcTrackLength; virtual;
    procedure CalcPaintRect; virtual;
    property  Delta: integer read GetDelta;

    // 7.0: public access to internal caret - use with care!
    property Caret:TLMDCaret read FCaret;
    // ---
    property CanBeFocused : Boolean read FCanBeFocused write SetCanBeFocused;
    property CtlXP;  // compatibility
  published
    property About;
    property Align;
    property BackFX;
    property FaceController;
    property Bevel;
    property Color;
    property Flat;
    property Hint;
    property ParentColor;

    // 7.0
    property HideFocus:Boolean read FHideFocus write FHideFocus default false;
    // ---
    property Max : Integer index 0 read FMax write SetInteger default 100;
    property Min : Integer index 1 read FMin write SetInteger default 0;
    property Position    : Integer index 2 read FPosition write SetInteger default 0;
    property SmallChange : Integer read FSmall write FSmall default 1;
    property LargeChange : Integer read FLarge write FLarge default 10;
    property ThumbLength : Integer index 4 read FThumbLength write SetInteger default 16;
    property TrackLength: integer read FTrackLength;
    property BarWidth : Integer index 5 read FBarWidth write SetInteger default 16;

    property BackStyle   : TLMDBackStyle read FBackStyle write SetBackStyle default bsDefault;
    property ThumbMode   : TLMDThumbMode read FThumbMode write FThumbMode default tmFixed;
    property ThumbFlat   : Boolean read FThumbFlat write SetBoolean default false;
    property ThumbColor  : TColor read FThumbColor write SetColor default clBtnFace;
    property ThumbBevel  : TLMDBevel read FThumbBevel write SetThumbBevel;
    property ThumbCursor : TCursor read FThumbCursor write FThumbCursor default crDefault;
    property Kind        : TLMDScrollBarKind read FKind write SetKind default skHorizontal;
    property ButtonWidth : Integer index 3 read FButtonWidth write SetInteger default 16;
    property Back        : TLMDFillObject read FBack write SetBack;
    property AllowMousePos : Boolean read FAllowMousePos write FAllowMousePos default true;
    property TabOrder;
    property TabStop default true;
    property Ctl3D;
    property ParentCtl3D;
    property Transparent;
    property Enabled;
    property Cursor;
    property DragCursor;
    property DragMode;
    property HelpContext;
    property ShowHint;
    property ParentShowHint;
    property PopupMenu;

    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write FUseGlobalTimer default false;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;    
    // ---

    //    property TabStop;
    property Visible;

    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnMouseWheel;
    property OnMouseEnter;
    property OnMouseExit;
//    property OnChange;
    property OnEndDrag;
    property OnDragOver;
    property OnStartDrag;
    property OnDragDrop;
    property OnAfterEnter;
    property OnAfterExit;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;

    property OnScroll : TScrollEvent read FOnSCroll write FOnScroll;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

  { -------------------------------------------------------------------------- }
  TLMDScrollBarObject = class(TLMDObject)
  private
    FBack             : TLMDFillObject;
    FBevel            : TLMDBevel;
    FAllowMousePos,
    FTransparent,
    FCtl3D,
    FParentCtl3D      : Boolean;
    FButtonWidth,
    FLargeChange,
    FSmallChange      : Integer;
    FCursor           : TCursor;
    FColor,
    FThumbColor       : TColor;
    FBackStyle        : TLMDBackStyle;
    FBarWidth         : Integer;

    //procedure SetBackStyle (aValue : TLMDBackStyle);
    procedure SetBack (aValue : TLMDFillObject);
    procedure SetBevel (aValue : TLMDBevel);
    procedure SetBoolean (index : Integer;aValue : Boolean);
    procedure SetInteger (index : Integer;aValue : Integer);
    procedure SetColor (index : Integer; aColor : TColor);
    procedure SetBarWidth(const Value: Integer);

  public
    constructor Create(Owner: TPersistent=nil); override;
    destructor Destroy; override;
    procedure AssignToScrollBar (aValue : TLMDScrollBar);
    procedure Assign (Source : TPersistent);override;
  published
    property Back : TLMDFillObject read FBack write SetBack;
    property Color : TColor index 0 read FColor write SetColor default clBtnFace;
    property ThumbColor : TColor index 1 read FThumbColor write SetColor default clBtnFace;
    property Cursor : TCursor read FCursor write FCursor default crDefault;
    property Bevel : TLMDBevel read FBevel write SetBevel;
    property ButtonWidth : Integer index 0 read FButtonWidth write SetInteger default 16;
    property SmallChange : Integer index 1 read FSmallChange write SetInteger default 1;
    property LargeChange : Integer index 2 read FLargeChange write SetInteger default 10;
    property Transparent : Boolean index 0 read FTransparent write SetBoolean default false;
    property Ctl3D : Boolean index 1 read FCtl3D write SetBoolean default true;
    property ParentCtl3D : Boolean index 2 read FParentCtl3D write SetBoolean default true;
    property AllowMousePos : Boolean index 3 read FAllowMousePos write FAllowMousePos default true;
    property BackStyle  : TLMDBackStyle read FBackStyle write FBackStyle default bsDefault;
    property BarWidth   : Integer read FBarWidth write SetBarWidth default 16;

    property OnChange;
  end;

implementation

uses
  Types, Themes,
  LMDGraph, LMDUtils, LMDProcs, LMDThemes;

{ ---------------------------------------------------------------------------- }
procedure TLMDSCrollBarThumb.WMSetFocus(var Msg : TWMSetFocus);
begin
  if (not (TLMDScrollBar (Parent).Focused)) and
     (TLMDScrollBar (Parent).CanBeFocused) then
    TLMDScrollBar (Parent).SetFocus;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarThumb.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if not (TLMDScrollBar (Parent).Focused) and
     (TLMDScrollBar (Parent).CanBeFocused) then
    TLMDScrollBar (Parent).SetFocus;
  FMousePressed := true;
  Paint;
  inherited MouseDown (Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarThumb.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
  FMousePressed:=false;
  Paint;
  TLMDScrollBar (Parent).ExecuteEvent (scPosition);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarThumb.MouseExit;
begin
  inherited;
  Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarThumb.MouseEnter;
begin
  inherited;
  Paint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarThumb.CreateGripBmp(vertical: Boolean);
var
  gripLines,
  i     : Integer;
  myBmp : TBitmap;
  aRect : TRect;
  sb    : TThemedScrollBar;
begin
  myBmp := TBitmap.Create;
  try
    myBmp.Canvas.Brush.Style := bsSolid;
    myBmp.Canvas.Brush.Color := Color;

    gripLines := 5;
    myBmp.Width := Width;
    myBmp.Height := Height;

    if  (Owner as TLMDScrollBar).IsThemed  then
      begin
        aRect := Rect (0, 0, myBmp.Width, myBmp.Height);
        if vertical then
          sb := tsThumbBtnVertHot
        else
          sb := tsThumbBtnHorzHot;
        LMDThemeServices.DrawElement(UseThemeMode, myBmp.Canvas.Handle, sb, aRect);
      end
    else
      begin
        if vertical then
          begin
            myBmp.Canvas.FillRect (Rect (0, 0, Width - 2, (gripLines+1)*2));
            myBmp.Canvas.Pen.Color := clGray;
            for i := 0 to gripLines - 1 do
              begin
                myBmp.Canvas.MoveTo (1, 1 + i*2);
                myBmp.Canvas.LineTo (Width - 1, 1 + i*2);
              end;
          end
        else
          begin
            myBmp.Canvas.FillRect (Rect (0, 0, (gripLines+1)*2, Height - 2));
            myBmp.Canvas.Pen.Color := clGray;
            for i := 0 to gripLines - 1 do
              begin
                myBmp.Canvas.MoveTo (1 + i * 2, 1);
                myBmp.Canvas.LineTo (1 + i*2, Height - 1);
              end;
          end;
    end;
    FillObject.Bitmap.Assign (myBmp);
  finally
    myBmp.Free;
  end;
  FillObject.TileMode := tmCenter;
  FillObject.Style := sfBitmap;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDScrollBarThumb.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  ControlStyle := ControlStyle - [csAcceptsControls, csOpaque];
  Bevel.Mode := bmStandard;
  Bevel.StandardStyle := lsRaised;
  TabStop := False;
  FillObject.Style := sfBitmap;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDScrollBarThumb.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarThumb.Paint;
const
  VERT_STATES: array[0..3] of TThemedScrollBar = (
    tsThumbBtnVertNormal,
    tsThumbBtnVertHot,
    tsThumbBtnVertPressed,
    tsThumbBtnVertDisabled
  );
  HORZ_STATES: array[0..3] of TThemedScrollBar = (
    tsThumbBtnHorzNormal,
    tsThumbBtnHorzHot,
    tsThumbBtnHorzPressed,
    tsThumbBtnHorzDisabled
  );
var
  aRect   :TRect;
  sb      :TThemedScrollbar;
  stateID : Integer;
  lThemeMode : TLMDThemeMode;
begin
  if IsUpdating then
    Exit;

  if  (Owner as TLMDScrollBar).IsThemed  then
  begin
    FillControl;

    aRect := Rect (0, 0, Width, Height);
    lThemeMode := UseThemeMode;

//    Canvas.Brush.Color := clRed;
//    Canvas.FillRect(aRect);

    stateID := 0;
    if self.MouseAbove then stateID := 1; // Hot
    if FMousePressed then stateID := 2;   // Pressed
    if not Enabled then stateID := 3;     // Disabled

    if (Owner as TLMDScrollBar).Kind = skVertical then
      sb := TThemedScrollBar(VERT_STATES[stateID])
    else
      sb := TThemedScrollBar(HORZ_STATES[stateID]);

    LMDThemeServices.DrawElement(lThemeMode, Canvas.Handle, sb, aRect);

    if (Owner as TLMDScrollBar).Kind = skVertical then
      sb := tsGripperVertNormal
    else
      sb := tsGripperHorzNormal;

    aRect := Rect (aRect.Left + (aRect.Right - aRect.Left) div 2 - 2,
                   aRect.Top + (aRect.Bottom - aRect.Top) div 2 - 2,
                   aRect.Left + (aRect.Right - aRect.Left) div 2 + 2,
                   aRect.Top + (aRect.Bottom - aRect.Top) div 2 + 2);
    if aRect.Top - 4 > 0 then
      InflateRect (aRect, 0, 2);
    if aRect.Left - 4 > 0 then
      InflateRect (aRect, 2, 0);

    LMDThemeServices.DrawElement(lThemeMode, Canvas.Handle, sb, aRect);
  end
  else
    inherited Paint;
end;

{ *************************** class TLMDScrollBar **************************** }
{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.SetButtons;
var
  lDelta: integer;
const
   ThumbMinSize = 8;

   function RelPos (l : Integer) : Integer;
   var
     ma, mi,
     f:Double;
   begin
     //type conversions are done in this method 'cause of possible huge int
     //values (e.g. -2000000000 .. 2000000000) which exceeds the integer range
     result := l - FThumbLength; //forget the needed space for the thumb
     if result = 0 then result := 1;
     //FMax > FMin and FMax <> FMin and result >= 1
     ma := FMax;
     mi := fMin;
     if FMax > FMin then
       f := (ma - mi) / result
     else
       f := 1;
     //result = value per points
     if f = 0 then f := 1;
     ma := FPosition;
     result := Round((ma - mi) / f);
   end;

begin
  if IsUpdating then exit;

  if UseThemeMode in [ttmPlatform, ttmNative] then
    lDelta := 0
  else
    lDelta := 1;

  BeginUpdate;
  try
    if (Parent <> nil) and (Focused) then
      FCaret.Disable;

    FBtns.BeginUpdate;
    try
      FBtnS.Flat := FThumbFlat;
      FBtnS.Bevel.Assign (FThumbBevel);
      FBtnS.Color := FThumbColor;
      FBtnS.Cursor := FThumbCursor;
    finally
      FBtns.EndUpdate;
    end;

    CalcPaintRect;
    with FPaintRect do
    begin
      case FKind of
        skVertical :   begin
                         FBtn1.SetBounds (FPaintRect.Left, FPaintRect.Top {+ 1}, Right - FPaintRect.Left, FButtonWidth - 1);
                         FBtn1.OnTopClick := DoDec;
                         FBtn1.SpinButtons := [sbUp];
                         FBtn2.SetBounds (FPaintRect.Left, Bottom - FButtonWidth + 1, Right - FPaintRect.Left, FButtonWidth - 1);
                         FBtn2.SpinButtons := [sbDown];
                         FBtn2.OnBottomClick := DoInc;
                         CalcTrackLength;
                         if FThumbMode = tmAuto then
                            begin
  //                            if FMax - double(FMin) < High (Integer) then
                                begin
                                  FThumbLength := FTrackLength - (FMax - FMin);
                                  if FThumbLength < ThumbMinSize then
                                    FThumbLength := ThumbMinSize //MinSize
                                end
  //                            else
  //                              FThumbLength := ThumbMinSize
                            end;
                         FBtnS.SetBounds (FPaintRect.Left, FPaintRect.Top + FButtonWidth + RelPos (FTrackLength) - 1, Right - FPaintRect.Left, FThumbLength);
                       end;
        skHorizontal : begin
                         FBtn1.SetBounds (FPaintRect.Left, FPaintRect.Top, FButtonWidth, Bottom - FPaintRect.Top + lDelta); //VB May 2009
                         FBtn1.OnLeftClick := DoDec;
                         FBtn1.SpinButtons := [sbLeft];
                         FBtn2.SetBounds (Right - FButtonWidth, FPaintRect.Top, FButtonWidth, Bottom - FPaintRect.Top + lDelta);
                         FBtn2.OnRightClick := DoInc;
                         FBtn2.SpinButtons := [sbRight];
                         CalcTrackLength;
                         if FThumbMode = tmAuto then
                            begin
  //                            if double (FMax) - double(FMin) < High (Integer) then
                                begin
                                  FThumbLength := FTrackLength - (FMax - FMin);
                                  if FThumbLength < ThumbMinSize then
                                    FThumbLength := ThumbMinSize //MinSize
                                end
  //                            else
  //                              FThumbLength := ThumbMinSize
                            end;
                         FBtnS.SetBounds (FPaintRect.Left + FButtonWidth + RelPos (Right - FPaintRect.Left - 2 * FButtonWidth),
                                          FPaintRect.Top, FThumbLength, Bottom - FPaintRect.Top);
                       end;
      end;
      FBtn1.OnMouseUp := DoSpinBtnMouseUp;
      FBtn1.OnMouseDown := DoSpinBtnMouseDown;
      FBtn2.OnMouseUp := DoSpinBtnMouseUp;
      FBtn2.OnMouseDown := DoSpinBtnMouseDown;
    end;
    //FBtnS.CreateGripBmp (FKind = skVertical);

    if FBtnS.Width > 2 then
      FCaret.Width := FBtnS.Width-3
    else
      FCaret.Width := 0;
    if FBtnS.Height > 2 then
      FCaret.Height := FBtnS.Height-3
    else
      FCaret.Height := 0;
    if (Focused) and not (IsThemed or FHideFocus) then
    begin
      FCaret.BuildCaret;
      FCaret.Enable;
      SetCaretPos (1, 1);
    end;
  finally
    EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.RefreshBackground;
var
  sb:         TThemedScrollBar;
  aRect:      TRect;
  lThemeMode: TLMDThemeMode;
begin
  // 6.1
  lThemeMode := UseThemeMode;

  if (lThemeMode <> ttmNone) and Parent.HandleAllocated then
  begin
    FB.Width  := Width;
    FB.Height := Height;
    aRect := Rect (0, 0, FB.Width, FB.Height);

    if FKind = skVertical then
      sb := tsLowerTrackVertNormal
    else
      sb := tsLowerTrackHorzNormal;

    LMDThemeServices.DrawElement(lThemeMode, FB.Canvas.Handle, sb, aRect);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.DrawThemeBevel(aTheme:TLMDThemeMode;
  aCanvas: TCanvas; aRect: TRect);
begin
  LMDThemeServices.DrawElement(aTheme, aCanvas.Handle,
                               tsSizeBoxRightAlign, aRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.DoInc(Sender : TObject);
begin
  if (not Focused) and (CanBeFocused) then
    SetFocus;
  if FPosition = FMax then exit;
  Position := FPosition + FSmall;
  ExecuteEvent (scLineDown);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.DoDec(Sender : TObject);
begin
  if (not Focused) and (CanBeFocused) then
    SetFocus;
  if FPosition = FMin then exit;
  Position := FPosition - FSmall;
  ExecuteEvent (scLineUp);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.DoSpinBtnMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CheckBounds;
  inherited MouseUp(Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.DoSpinBtnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  CheckBounds;
  inherited MouseDown(Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.CheckBounds;
begin
  if FPosition <= FMin then
    ExecuteEvent (scTop);
  if FPosition >= FMax then
    ExecuteEvent (scBottom);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.EnableTimer;
begin
  if Assigned(FTimerId) then exit;
  //the timer is needed for repeated Mouse action
  FTimerId:=TLMDTimer.Create(100, DoTimerEvent, true,FUseGlobalTimer);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.RemoveTimer;
begin
  if Assigned(FTimerID) then
    begin
      FTimerId.Enabled := false;
      FreeAndNil(FTimerID);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.SetBack (aValue : TLMDFillObject);
begin
  FBack.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.SetKind(aValue: TLMDScrollBarKind);
var
  i : Integer;
begin
  if aValue <> FKind then
    begin
      FKind := aValue;

      if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
        begin
          i := Width;
          Width := Height;
          Height := i;
        end;

      if not IsUpdating then
        RefreshBackground;

      SetButtons;

      if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
        Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.SetInteger (index, aValue : Integer);
begin
  case index of
    0 : if FMax <> aValue then
          begin
            FMax := aValue;
            if FMax < FMin then
              FMax := FMin;
            if FPosition > FMax then
              Position := FMax;
            SetButtons;
          end;
    1 : if FMin <> aValue then
          begin
            FMin := aValue;
            if FMin > FMax then
              FMin := FMax;
            if FPosition < FMin then
              Position := FMin;
            SetButtons;
          end;
    2 : if FPosition <> aValue then
          begin
            FPosition := aValue;
            if FPosition > FMax then
              FPosition := FMax;
            if FPosition < FMin then
              FPosition := FMin;
            SetButtons;
          end;
    3 : if FButtonWidth <> aValue then
          begin
            FButtonWidth := aValue;
            SetButtons;
          end;
    4 : if (FThumbLength <> aValue) and (FThumbMode = tmFixed) then
          begin
            FThumbLength := aValue;
            SetButtons;
          end;
    5: if (FBarWidth <> aValue) then
          begin
            FBarWidth := aValue;
            if FKind = skVertical then
            begin
              if FBarWidth > 0 then
                Width := FBarWidth
              else
                Width := GetSystemMetrics(SM_CXVSCROLL);
            end
            else
            begin
              if FBarWidth > 0 then
                Height := FBarWidth
              else
                Height := GetSystemMetrics(SM_CYHSCROLL);
            end;
            SetButtons;
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.SetCanBeFocused (aValue : Boolean);
begin
  FCanBeFocused := aValue;
  FBtnS.TabStop := FCanBeFocused;
  TabStop := FCanBeFocused;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.SetBoolean (aValue : Boolean);
begin
  FThumbFlat := aValue;
//  FBtns.Flat := FThumbFlat;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.SetThumbBevel (aValue : TLMDBevel);
begin
  FThumbBevel.Assign (aValue);
  SetButtons;
//  FBtns.Bevel.Assign (FThumbBevel);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.SetColor(aValue : TColor);
begin
  if aValue <> FThumbColor then
    begin
      FThumbColor := aValue;
      SetButtons;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.SetBackStyle(aValue: TLMDBackStyle);
begin
  if aValue <> FbackStyle then
    begin
      FBackStyle := aValue;
      GetChange(self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.DoThumbMouseDown (Sender : TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (FAllowMousePos) then
    begin
      FOldPosition := FPosition;
      FMoveThumb := true;
      FMousePos := Point (FBtnS.Left + X, FBtnS.Top + Y);
    end;
  inherited MouseDown(Button, Shift, X, Y); //VB Nov 2006
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.DoThumbMouseUp (Sender : TObject;Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) then
    begin
      FMoveThumb := false;
    end;
  inherited MouseUp(Button, Shift, X, Y); //VB Nov 2006
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.DoThumbMouseMove (Sender : TObject; Shift : TShiftState; X, Y : Integer);
begin
  x := x + FBtnS.Left;
  y := y + FBtnS.Top;
  MouseMove (Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.CMEnabledChanged (var Msg : TMessage);
begin
  inherited;
  FBtnS.Visible := Enabled;
  FBtn1.Enabled := Enabled;
  FBtn2.Enabled := Enabled;
end;

{$IFDEF LMDCOMP16}
procedure TLMDScrollBar.CMStyleChanged(var Msg: TMessage);
begin
  RefreshBackground;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.ExecuteEvent (event : TScrollCode);
begin
  if Assigned (FOnScroll) then
    begin
      FOnScroll (self, scEndScroll, FPosition);
      FOnScroll (self, event, FPosition);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  FBlackSpace : Boolean;
  FSaveBack   : TBitmap;

  procedure Black (X1, Y1, X2, Y2 : Integer);
  begin
    if FBlackSpace then
      begin
        FSaveBack := TBitmap.Create;
        try
          FSaveBack.Width := X2 - X1;
          FSaveBack.Height := Y2 - Y1;
          FSaveBack.Canvas.CopyRect (Rect (0, 0, X2 - X1, Y2 - Y1), Canvas, Rect (X1, Y1, X2, Y2));
          Canvas.Brush.Color := clBlack;
          Canvas.Brush.Style := bsSolid;
          Canvas.FillRect (Rect (X1,Y1,X2,Y2));
          Canvas.CopyRect (Rect (X1,Y1,X2,Y2), FSaveBack.Canvas,Rect (0, 0, X2 - X1, Y2 - Y1));
        finally
          FSaveBack.Free;
        end;
      end;
  end;

begin
  FBlackSpace := false;
  if (not (Focused)) and (CanBeFocused) then
    SetFocus;

  inherited MouseDown (Button, Shift, X, Y);
  if Button = mbLeft then
    begin
      EnableTimer;
      case FKind of
          skVertical : begin
                         if y < FBtnS.Top then
                           begin
                             Black(FPaintRect.Left, FPaintRect.Top + FButtonWidth,
                                   FPaintRect.Right, FBtnS.Top);

                             Position := Position - FLarge;
                             ExecuteEvent (scPageUp);
                           end
                         else
                           if y > FBtnS.Top + FBtnS.Height then
                             begin
                               Black (FPaintRect.Left, FBtnS.Top + FBtnS.Height,
                                      FPaintRect.Right, FPaintRect.Bottom - FButtonWidth);
                               Position := Position + FLarge;
                               ExecuteEvent (scPageDown);
                             end;
                       end;
        skHorizontal : begin
                         if x < FBtnS.Left then
                           begin
                             Black (FPaintRect.Left + FButtonWidth,
                                    FPaintRect.Top,
                                    FBtnS.Left, FPaintRect.Bottom);
                             Position := Position - FLarge;
                             ExecuteEvent (scPageUp);
                           end
                         else
                           if x > FBtnS.Left + FBtnS.Width then
                             begin
                               Black (FBtnS.Left + FBtnS.Width, FPaintRect.Top,
                                      FPaintRect.Right - FButtonWidth,
                                      FPaintRect.Bottom);
                               Position := Position + FLarge;
                               ExecuteEvent (scPageDown);
                             end;
                       end;
      end;
      if ((x > FBtnS.Left) and (x < FBtnS.Left + FBtnS.Width) and (FKind = skHorizontal))
       or ((y > FBtnS.Top) and (y < FBtnS.Top + FBtnS.Height) and (FKind = skVertical)) then
        RemoveTimer;
    end;
  CheckBounds;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.MouseMove (Shift : TShiftState; X, Y : Integer);
var
  m{, i} : Integer;
  lTl, ma, mi : double;
begin
  //save actual mouse coordinates in global component vars (for timer event)
  MX := X;
  MY := Y;
  ma := FMax;
  mi := FMin;

  if (ssLeft in Shift) and (FMoveThumb) {and PtInRect (FPaintRect, Point(X,Y)) JH 19.09.00 -> thumb moveable if mouse leaves control} then
    begin
      case FKind of
        skVertical   : if y <> FMousePos.Y then
                         begin
                           m := Abs(FMousePos.y - y);
                           lTl := TrackLength;
                           if lTl <> FThumbLength then
                             m := Round (m * ((ma - mi) /
                                        (lTl - FThumbLength)))
                           else
                             m := 1;
                           if y < FMousePos.y then
                             begin
                               //i := FPosition;
                               Position := FPosition - m;
                             end
                           else
                             begin
                               //i := FPosition;
                               Position := FPosition + m;
                             end;
                         end;
        skHorizontal : if x <> FMousePos.x then
                         begin
                           m := Abs(FMousePos.x - x);
                           lTl := TrackLength;
                           if TrackLength <> FThumbLength then
                             m := Round (m * ((ma - mi) /
                                        (lTl - FThumbLength)))
                           else
                             m := 1;
                           if x < FMousePos.x then
                             begin
                               //i := FPosition;
                               Position := FPosition - m;
                             end
                           else
                             begin
                               //i := FPosition;
                               Position := FPosition + m;
                             end;
                         end;
      end;
      If Assigned (FOnScroll) then FOnScroll (self, scTrack, FPosition);
      //save current mouse pos
      FMousePos := Point (X,Y);
      if FPosition = FMin then
        ExecuteEvent (scTop);
      if FPosition = FMax then
        ExecuteEvent (scBottom);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.MouseExit;
begin
  inherited;
  FBtn1.MouseLeave;
  FBtn2.MouseLeave;
end;

{ ---------------------------------------------------------------------------- }
function TLMDScrollBar.GetFillObject  : TLMDFillObject;
begin
  result := inherited GetFillObject;
  if result = nil then
    result := FBack;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
  RemoveTimer;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.WMGetDlgCode(var Msg : TWMGetDlgCode);
begin
  inherited;

  Msg.Result := Msg.Result or DLGC_WANTCHARS or DLGC_WANTARROWS
                and not DLGC_WANTTAB;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.WMSetFocus(var Msg : TWMSetFocus);
begin
  if (csLoading in ComponentState) then exit;
  if (CanBeFocused) then
    begin
      inherited;
      FBtnS.Entered := true;
      SetButtons;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.WMKillFocus(var Msg : TWMKillFocus);
begin
  FCaret.DestroyCaret;
  FBtnS.Entered := false;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.WMKeyDown(var Msg : TWMKeyDown);
begin
  inherited;
  case Msg.CharCode of
    VK_DOWN, VK_RIGHT : DoInc(nil);
    VK_UP, VK_LEFT : DoDec(nil);
    VK_PRIOR : begin
                 Position := FPosition - FLarge;
                 if Assigned (FOnScroll) then FOnSCroll (self, scPageUp, FPosition);
               end;
    VK_NEXT : begin
                Position := FPosition + FLarge;
                if Assigned (FOnScroll) then FOnSCroll (self, scPageDown, FPosition);
              end;
  end;
  if Msg.CharCode in [VK_DOWN, VK_RIGHT, VK_UP, VK_LEFT, VK_PRIOR, VK_NEXT] then
    begin
      if FPosition = FMin then
        ExecuteEvent (scTop);
      if FPosition = FMax then
        ExecuteEvent (scBottom);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.DoTimerEvent (Sender : TObject);
begin
  MouseDown (mbLeft, [], MX, MY);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.DoThemeChanged;
begin
  FBtn1.ThemeMode := self.ThemeMode;
  FBtn1.Perform(WM_THEMECHANGED,0,0);
  FBtn1.Invalidate;
  FBtn2.ThemeMode := self.ThemeMode;
  FBtn2.Perform(WM_THEMECHANGED,0,0);
  FBtn2.Invalidate;
  FBtnS.ThemeMode := self.ThemeMode;
  FBtnS.Perform(WM_THEMECHANGED,0,0);
  FBtnS.Invalidate;
  RefreshBackground;
  inherited;
end;

{ ------------------------ public -------------------------------------------- }
constructor TLMDScrollBar.Create (aOwner : TComponent);
var
  i, j : Integer;
begin
  inherited Create (aOwner);
  //ControlStyle:=ControlStyle-[csAcceptsControls, csParentBackground]+[csOpaque];
  ControlStyle:=ControlStyle-[csAcceptsControls{$IFDEF LMDCOMP7},csParentBackground{$ENDIF}]
                            +[csOpaque];
  {$IFNDEF LMDCOMP7}
  BeginUpdate; 
  ParentBackground := false; 
  EndUpdate;
  {$ENDIF}
  TabStop := true;
  FAllowMousePos := true;
  FButtonWidth := 16;
  FKind := skHorizontal;
  FThumbLength := 16;
  FThumbMode := tmFixed;
  FThumbCursor := crDefault;
  FMin := 0;
  FMax := 100;
  FSmall := 1;
  FLarge := 10;
  FPosition := 0;
  FMoveThumb := false;
  FThumbFlat := false;
  FThumbColor := clBtnFace;
  FTrackLength := 100;
  FCanBeFocused := true;

  FBackStyle := bsDefault;

  FBack := TLMDFillObject.Create;
  FBack.OnChange := GetChange;
  FBack.Style := sfBrushBitmap;
//  FBack.Brush.Style := bsDiagCross;
//  FBack.Brush.Color := clWhite;

  FB := TBitmap.Create;
  FB.Width := 8;
  FB.Height := 8;

  for j := 0 to 7 do
    if j mod 2 <> 0 then
      for i := 0 to 7 do
        if i mod 2 <> 0 then
          FB.Canvas.Pixels[i, j] := clWhite
        else
          FB.Canvas.Pixels[i, j] := Color
    else
      for i := 0 to 7 do
        if i mod 2 <> 0 then
          FB.Canvas.Pixels[i, j] := Color
        else
          FB.Canvas.Pixels[i, j] := clWhite;

  FBtn1 := TLMDSpinButton.Create (Self);
  FBtn1.Parent := self;//FBtnP1;
  FBtn1.ThemeMode := self.ThemeMode;
  //  FBtn1.Font.Name := 'Symbol';
  FBtn1.ExtStyle := seSpinScrollBar;
  FBtn2 := TLMDSpinButton.Create (self);
  FBtn2.Parent := self;//FBtnP2;
  FBtn2.ThemeMode := self.ThemeMode;
//  FBtn2.Font.Name := 'Symbol';
  FBtn2.ExtStyle := seSpinScrollBar;
  FBtnS := TLMDScrollBarThumb.Create (self);
  FBtnS.Parent := self;
//  FBtnS.Enabled := false;
  FBtnS.ThemeMode := self.ThemeMode;
  FBtnS.OnMouseDown := DoThumbMouseDown;
  FBtnS.OnMouseUp := DoThumbMouseUp;
  FBtnS.OnMouseMove := DoThumbMouseMove;
  //  FBtnS.Transparent := false;

  FCaret := TLMDCaret.CreateExt (FBtnS);
  FCaret.Width := Width;
  FCaret.Height := Height;
  //make a copy of the Bitmap for the Caret
  FCaret.Bitmap.Assign (FB);
  FCaret.Style := csBitmap;
  FCaret.CaretBmpMode := cbTile;

  Bevel.Mode := bmStandard;
  Bevel.StandardStyle := lsSingleLowered;
  Height := 16;

  FThumbBevel := TLMDBevel.Create;
  FThumbBevel.StyleOuter := bvRaised;

  FTimerId:=nil;

  SetButtons;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDScrollBar.Destroy;
begin
  RemoveTimer;
  FreeAndNil(FThumbBevel);
  FreeAndNil(FCaret);
  FreeAndNil(FBtnS);
  FreeAndNil(FB);
  FreeAndNil(FBtn2);
  FreeAndNil(FBtn1);
  FreeAndNil(FBack);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.Loaded;
begin
  inherited Loaded;
  FBtnS.Flat := FThumbFlat;
  RefreshBackground;
  SetButtons;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.Paint;
var
  os:         TLMDFillStyle;
  lThemeMode: TLMDThemeMode;
begin
  if IsUpdating then
    Exit;

  FillControl;

  lThemeMode := UseThemeMode;
  if ((lThemeMode = ttmNative) and (GetBevel.Mode = bmWindows)) or
     (lThemeMode = ttmPlatform) then
    DrawThemeBevel(lThemeMode, Canvas, GetClientRect)
  else
    GetBevel.PaintBevel(Canvas, GetClientRect, Transparent);

  CalcPaintRect;
  if (GetFillObject.Style <> sfNone) and not Transparent then
    if FBackStyle = bsDefault then
    begin
      FBack.OnChange := nil;
      FBack.Bitmap := FB;
      os := FBack.Style;
      FBack.Style := sfBrushBitmap;
      FBack.FillCanvas (Canvas, FPaintRect, Color);
      FBack.Style := os;
      FBack.Bitmap := nil;
      FBack.OnChange := GetChange;
    end
    else
      GetFillObject.FillCanvas(Canvas, FPaintRect, Color);
  SetButtons;
end;

{ @@@@@@@@@@@@@@@@@@@@@@ TLMDScrollBarObject @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ }
{ -------------------------- private ----------------------------------------- }
{procedure TLMDScrollBarObject.SetBackStyle (aValue : TLMDBackStyle);
begin
  if aValue <> FBackStyle then
    begin
      FBackStyle := aValue;
      GetChange (self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarObject.SetBack (aValue : TLMDFillObject);
begin
  FBack.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarObject.SetBevel (aValue : TLMDBevel);
begin
  FBevel.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarObject.SetBoolean (index : Integer;aValue : Boolean);
begin
  case index of
    0 : if aValue <> FTransparent then
          begin
            FTransparent := aValue;
            GetChange (self);
          end;
    1 : if aValue <> FCtl3D then
          begin
            FCtl3D := aValue;
            GetChange (self);
          end;
    2 : if aValue <> FParentCtl3D then
          begin
            FParentCtl3D := aValue;
            GetChange (self);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarObject.SetInteger (index : Integer;aValue : Integer);
begin
  case index of
    0 : if aValue <> FButtonWidth then
          begin
            FButtonWidth := aValue;
            GetChange (self);
          end;
    1 : if aValue <> FSmallChange then
          begin
            FSmallChange := aValue;
            GetChange (self);
          end;
    2 : if aValue <> FLargeChange then
          begin
            FLargeChange := aValue;
            GetChange (self);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarObject.SetColor (index : Integer; aColor : TColor);
begin
  case index of
    0: if FColor <> aColor then
         begin
           FColor := aColor;
           GetChange (self);
         end;
    1: if FThumbColor <> aColor then
         begin
           FThumbColor := aColor;
           GetChange (self);
         end;
  end;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDScrollBarObject.Create;
begin
  inherited Create;
  FBack := TLMDFillObject.Create;
  FBack.OnChange := GetChange;
  FBack.Style := sfBrush;
  FBack.Brush.Style := bsSolid;
  FBack.Brush.Color := clBlue;

  FBevel := TLMDBevel.Create;
  FBevel.OnChange := GetChange;
  FBevel.Mode := bmStandard;
  FBevel.StandardStyle := lsSingleLowered;

  FTransparent := false;
  FCtl3D := true;
  FParentCtl3D := true;
  FAllowMousePos := true;
  FButtonWidth := 16;
  FSmallChange := 1;
  FLargeChange := 10;
  FCursor := crDefault;
  FBackStyle := bsDefault;
  FColor := clBtnFace;
  FThumbColor := clBtnFace;

  FBarWidth := 16;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDScrollBarObject.Destroy;
begin
  FBevel.OnChange := nil;
  FBevel.Free;
  FBack.OnChange := nil;
  FBack.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarObject.AssignToScrollBar (aValue : TLMDScrollBar);
begin
  aValue.Back.Assign (FBack);
  aValue.Bevel.Assign (FBevel);
  aValue.Transparent := FTransparent;
  aValue.Ctl3D := FCtl3D;
  aValue.ParentCtl3D := FParentCtl3D;
  aValue.ButtonWidth := FButtonWidth;
  aValue.SmallChange := FSmallChange;
  aValue.LargeChange := FLargeChange;
  aValue.AllowMousePos := FAllowMousePos;
  aValue.BackStyle := FBackStyle;
  aValue.Color := FColor;
  aValue.ThumbColor := FThumbColor;
  aValue.BarWidth := FBarWidth;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarObject.Assign (Source : TPersistent);
begin
  if Source is TLMDScrollBarObject then
    with  TLMDScrollBarObject(Source) do
      begin
        self.FBack.Assign (Back);
        self.FBevel.Assign (Bevel);
        self.FTransparent := Transparent;
        self.FCtl3D := Ctl3D;
        self.FParentCtl3D := ParentCtl3D;
        self.FButtonWidth := ButtonWidth;
        self.FLargeChange := LargeChange;
        self.FSmallChange := SmallChange;
        self.FAllowMousePos := AllowMousePos;
        self.FBackStyle := BackStyle;
        self.FColor := Color;
        self.FThumbColor := ThumbColor;
        self.FBarWidth := BarWidth;
      end
  else
    inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBarObject.SetBarWidth(const Value: Integer);
begin
  if FBarWidth <> Value then
    begin
      FBarWidth := Value;
      GetChange(self);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.WMSIZE(var Message: TWMSIZE);
begin
  inherited;
  SetButtons;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.CalcPaintRect;
begin
  if HandleAllocated then
  begin
    FPaintRect := ClientRect;
    InflateRect (FPaintRect, -GetBevel.BevelExtend, -GetBevel.BevelExtend);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDScrollBar.CalcTrackLength;
begin
  with FPaintRect do
    case FKind of
      skVertical  : FTrackLength := Bottom - Top - 2 * FButtonWidth + 2;
      skHorizontal: FTrackLength := Right - Left - 2 * FButtonWidth;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDScrollBar.GetDelta: integer;
begin
  result := FPosition - FOldPosition;
end;

end.
