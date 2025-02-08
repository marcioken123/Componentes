unit LMDWndButtonShape;
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

LMDWndButtonShape unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, stdctrls,
  LMDClass, LMDGraph, LMDGlyph, LMDProcs, LMDRegion, LMDButtonBase,
  LMDCustomPanelFill, LMDFXCaption, LMDButtonLayout;

type
  TLMDWndButtonFocus = (bfNone, bfText, bfClient);
  TLMDWndButtonOffsetDirection = (wbOffsetUpLeft, wbOffsetDownRight);
  TLMDWndButtonStyle = (wbWin40, wbWin31, wbSimple);

  { -------------------------------------------------------------------------- }
  TLMDWndButtonShape = class (TLMDCustomPanelFill)
  private
    FRegion            : TLMDRegion;
    FFontFX            : TLMDFxCaption;
    FButtonLayout      : TLMDButtonLayout;
    FEnterColorChange,
    FFocused,
    FPressed,
    FMultiLine,
    FRepeatedClick     : Boolean;
    FTimerID           : TLMDTimer;
    FRepeatingDelay,
    FRepeatingInterval : Integer;
    FGlyph             : TObject;
    FStyle             : TLMDWndButtonStyle;
    FModalResult       : TModalResult;
    FFocusStyle        : TLMDWndButtonFocus;
    FEnterColor        : TColor;
    FCaptionStart      : TPoint;
    FOnDrawBorder      : TLMDBorderDrawEvent;
    FUseGlobalTimer    : Boolean;
    FOffsetDirection   : TLMDWndButtonOffsetDirection;

    procedure SetRegion (aValue : TLMDRegion);
    procedure SetFontFX (aValue : TLMDFxCaption);
    procedure SetBoolean (index : Integer; aValue : Boolean);
    procedure SetInteger (index : Integer; aValue : Integer);
    procedure SetNumGlyphs(aValue: TLMDNumGlyphs);
    procedure SetGlyph(aValue: TBitmap);
    procedure SetButtonLayout (aValue : TLMDButtonLayout);
    procedure SetStyle (aValue : TLMDWndButtonStyle);
    procedure SetModalResult (aValue : TModalResult);
//    procedure SetFocusStyle (aValue : TLMDWndButtonFocus);
    procedure SetEnterColor (aValue : TColor);
    procedure SetCaptionStart (aValue : TPoint);
    procedure SetOffsetDirection(Value: TLMDWndButtonOffsetDirection);

    function GetNumGlyphs : TLMDNumGlyphs;
    function GetGlyph : TBitmap;

    procedure WMSize (var Msg : TWMSize); message WM_SIZE;
    procedure WMSetFocus (var Message : TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus (var Message : TWMKillFocus); message WM_KILLFOCUS;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMMouseEnter (var Message: TMessage); message CM_MOUSEENTER;
    procedure WMDestroy (var Message : TWMDestroy); message WM_DESTROY;

    procedure DoTimer(Sender:TObject);
    procedure DeActivateTimer;

    procedure ReadPoint (Reader:TStream);
    procedure WritePoint (Writer : TStream);
  protected
    procedure DefineProperties (Filer : TFiler); override;
    procedure GetChange (Sender : TObject); override;
    function CheckOptimized:Boolean; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure OffsetInnerRect(var ARect: TRect); virtual;
    procedure Paint; override;
    procedure RestoreBorderBack; override;
    procedure RestoreBorderFront; override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    property Pressed : Boolean read FPressed;
    property CaptionStart : TPoint read FCaptionStart write SetCaptionStart;

  published
    property About;
    property ButtonLayout : TLMDButtonLayout read FButtonLayout write SetButtonLayout;
//    property Cancel;
    property Caption;
    property Color;
    property Cursor;
//    property Default;
    property DragCursor;
    property DragMode;
    property Enabled;
    property EnterColor : TColor read FEnterColor write SetEnterColor default clCaptionText;
    property EnterColorChange : Boolean index 2 read FEnterColorChange write SetBoolean default false;
    property FillObject;
    property Flat;
//    property FocusStyle : TLMDWndButtonFocus read FFocusStyle write SetFocusStyle default bfClient;
    property Font;
    property FontFX : TLMDFxCaption read FFontFX write SetFontFX;
    property Glyph : TBitmap read GetGlyph write SetGlyph;
//    property HideHint;
    property ImageIndex;
    property ImageList;
    property ListIndex;
    property ModalResult : TModalResult read FModalResult write SetModalResult default mrNone;
    property MultiLine : Boolean index 0 read FMultiLine write SetBoolean default true;
    property NumGlyphs : TLMDNumGlyphs read GetNumGlyphs write SetNumGlyphs;
    property OffsetDirection : TLMDWndButtonOffsetDirection read  FOffsetDirection write SetOffsetDirection default wbOffsetUpLeft;
//    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property Region : TLMDRegion read FRegion write SetRegion;
    property RepeatedClick : Boolean index 1 read FRepeatedClick write SetBoolean default false;
    property RepeatingInterval : Integer index 1 read FRepeatingInterval write SetInteger default 10;
    property RepeatingDelay : Integer index 2 read FRepeatingDelay write SetInteger default 500;
    property ShowHint;
    property Style : TLMDWndButtonStyle read FStyle write SetStyle default wbSimple;
    property TabOrder;
    property TabStop;
    property Transparent;
    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write FUseGlobalTimer default false;
    // ---
    property Visible;

    property OnDrawBorder: TLMDBorderDrawEvent read FOnDrawBorder write FOnDrawBorder;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
//    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation

uses
  Types,
  LMDShadow, LMDGraphUtils;

{ ---------------------------------------------------------------------------- }
{ ---------------------------------------------------------------------------- }
{ ---------------------------------------------------------------------------- }
{procedure LMDChangeColors (var col1, col2 : TColor);
var
  c : TColor;
begin
  c := col1;
  col1 := col2;
  col2 := c;
end;

{ @@@@@@@@@@@@@@@@@@@@@@@@@@@ TLMDWndButtonShape @@@@@@@@@@@@@@@@@@@@@@@@@@@@@ }
{ --------------------------- private ---------------------------------------- }
procedure TLMDWndButtonShape.SetRegion (aValue : TLMDRegion);
begin
  FRegion.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.SetFontFX (aValue : TLMDFxCaption);
begin
  FFontFX.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.SetBoolean (index : Integer; aValue : Boolean);
begin
  case index of
    0 : FMultiLine := aValue;
    1 : FRepeatedClick := aValue;
    2 : FEnterColorChange := aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.SetInteger (index : Integer; aValue : Integer);
begin
  case index of
    0 : ;
    1 : FRepeatingInterval := aValue;
    2 : FRepeatingDelay := aValue;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.SetNumGlyphs(aValue: TLMDNumGlyphs);
begin
  if aValue<>TLMDGlyph(FGlyph).NumGlyphs then
    begin
      TLMDGlyph(FGlyph).NumGlyphs:=aValue;
      Paint;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.SetGlyph (aValue : TBitmap);
begin
  if not (csLoading in ComponentState) then
    if ImageList<>nil then ImageList:=nil;
  TLMDGlyph(FGlyph).Glyph:=aValue;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.SetButtonLayout(aValue : TLMDButtonLayout);
begin
  FButtonLayout.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.SetStyle (aValue : TLMDWndButtonStyle);
begin
  if aValue <> FStyle then
    begin
      FStyle := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.SetModalResult (aValue : TModalResult);
begin
  FModalResult := aValue;
end;

{ ---------------------------------------------------------------------------- }
{procedure TLMDWndButtonShape.SetFocusStyle (aValue : TLMDWndButtonFocus);
begin
  if aValue <> FFocusStyle then
    begin
      FFocusStyle := aValue;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.SetEnterColor (aValue : TColor);
begin
  FEnterColor := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.SetCaptionStart (aValue : TPoint);
begin
  FCaptionStart := aValue;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDWndButtonShape.GetNumGlyphs : TLMDNumGlyphs;
begin
  Result:=TLMDGlyph(FGlyph).NumGlyphs;
end;

{ ---------------------------------------------------------------------------- }
function TLMDWndButtonShape.GetGlyph : TBitmap;
begin
  Result:=TLMDGlyph(FGlyph).Glyph;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SetFocus;
  inherited MouseDown (Button, Shift, X, Y);
  if Button = mbLeft then
    begin
      FPressed := true;
      if FRepeatedClick then
        begin
          if not Assigned(FTimerId) then
            FTimerId := TLMDTimer.Create(FRepeatingDelay, DoTimer, True, FUseGlobalTimer);
        end;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp (Button, Shift, X, Y);
  if FPressed then
    begin
      DeActivateTimer;
      FPressed := false;
      GetChange (nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown (Key, Shift);
  case key of
    VK_SPACE : if not FPressed then
                 begin
                   FPressed := true;
                   Paint;
                 end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp (Key, Shift);
  case key of
    VK_SPACE : begin
                 FPressed := false;
                 Paint;
                 if Assigned(OnClick) then
                   OnClick(self);
               end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.WMSetFocus (var Message : TWMSetFocus);
var aRect : TRect;
begin
  inherited;
  aRect := ClientRect;
  FFocused := true;
  Repaint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.WMKillFocus (var Message : TWMKillFocus);
begin
  inherited;
  if Assigned(FTimerID) and FTimerID.Enabled then
     DeActivateTimer;
  FFocused := false;
  FPressed := false;
  Repaint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
(*  if (MK_RBUTTON and Message.Keys=MK_RBUTTON) and
     (MK_LBUTTON and Message.Keys=MK_LBUTTON) then
    begin
      ShowMessage ('Caption XY Pos set!');
      CaptionStart := Point (Message.XPos, Message.YPos);
      Message.result := 1;
{      PostMessage (self.Handle, CM_DesignHitTest, MK_LBUTTON, 0);
      PostMessage (self.Handle, CM_DesignHitTest, MK_RBUTTON, 0);}
    end
  else*)
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.CMMouseEnter (var Message: TMessage);
begin
  SetMouseAbove (true);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.WMDestroy (var Message : TWMDestroy);
begin
  inherited;
  if Assigned(FRegion) then
    FRegion.FreeRegion;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.WMSize (var Msg : TWMSize);
begin
  inherited;
  FRegion.CreateRegion (ClientRect);
  FRegion.SetRegion;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.DoTimer(Sender:TObject);
begin
  FTimerId.Interval := FRepeatingInterval;
  Click;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.DeActivateTimer;
begin
  if Assigned(FTimerId) then
    begin
      FTimerId.Enabled := false;
      FreeAndNil(FTimerId);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.ReadPoint (Reader:TStream);
begin

  Reader.Read (FCaptionStart, sizeof (FCaptionStart));

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.WritePoint (Writer : TStream);
begin

  Writer.Write (FCaptionStart, sizeof(FCaptionStart));

end;

{ -------------------------- protected --------------------------------------- }
procedure TLMDWndButtonShape.DefineProperties (Filer : TFiler);
begin
  inherited DefineProperties (Filer);
  Filer.DefineBinaryProperty ('CaptionStart', ReadPoint, WritePoint, true);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.GetChange (Sender : TObject);
begin
  inherited GetChange (Sender);
  if Sender is TLMDRegion then
    begin
      FRegion.CreateRegion (ClientRect);
      FRegion.SetRegion;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDWndButtonShape.CheckOptimized:Boolean;
begin
  result:=(inherited CheckOptimized) or (FRegion.Shape = rsBitmap);
end;

{ -------------------------- public ------------------------------------------ }
constructor TLMDWndButtonShape.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  ControlStyle := [csOpaque, csSetCaption, csCaptureMouse, csClickEvents, csDoubleClicks];
  TabStop := true;
  FRegion := TLMDRegion.Create;
  FRegion.Owner := self;
  FRegion.OnChange := GetChange;

  FFontFX := TLMDFxCaption.Create;
  FFontFX.OnChange := GetChange;

  FButtonLayout := TLMDButtonLayout.Create;
  FButtonLayout.OnChange := GetChange;

  FMultiLine := true;
  FRepeatedClick := false;
  FRepeatingInterval := 10;
  FRepeatingDelay := 500;
  FGlyph := nil;
  FPressed := false;
  FTimerId := nil;
  FStyle := wbSimple;
  FModalResult := mrNone;
  FFocused := false;
  FFocusStyle := bfText;
  FEnterColor := clCaptionText;
  FEnterColorChange := false;

  FGlyph := TLMDGlyph.Create;
  TLMDGlyph(FGlyph).OnChange := GetChange;

  FCaptionStart := Point (-1, -1);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDWndButtonShape.Destroy;
begin
  DeactivateTimer;
  FRegion.OnChange := nil;
  FButtonLayout.OnChange := nil;
  FFontFX.OnChange := nil;

  TLMDGlyph(FGlyph).OnChange:=nil;
  TLMDGlyph(FGlyph).Free;

  FreeAndNil(FButtonLayout);
  FreeAndNil(FFontFX);

  FRegion.FreeRegion;
//  FRegion.Owner := nil;
  FreeAndNil(FRegion);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.OffsetInnerRect(var ARect: TRect);
begin
  case FStyle of
    wbSimple,
    wbWin40  : if FOffsetDirection = wbOffsetUpLeft then
                 OffsetRect (aRect, -1, -1)
               else
                 OffsetRect (aRect, 1, 1);
    wbWin31  : if FOffsetDirection = wbOffsetUpLeft then
                 OffsetRect (aRect, -2, -2)
               else
                 OffsetRect (aRect, 2, 2);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.Paint;
var
  bRect,
  aRect : TRect;
  flags:Longint;
  bs : TLMDButtonState;
begin
  if csLoading in ComponentState then exit;
{  if csDestroying in ComponentState then exit;
  if not HandleAllocated then exit;}
  try

    //get the client rect
    bRect := ClientRect;

    //InflateRect (aRect, -2, -2);
  //  if not (csDesigning in ComponentState) then
      if FPressed and not (csDesigning in ComponentState) then
        case FStyle of
          wbSimple : FRegion.Border.Style := rbLowered;
          wbWin40  : FRegion.Border.Style := rbSingleLowered;
          wbWin31  : FRegion.Border.Style := rbLoweredpsb;
        end
      else
        if (Flat) and (not MouseAbove) and (not FFocused) then
          FRegion.Border.Style := rbNone //rbSingle
        else
          case FStyle of
            wbSimple : FRegion.Border.Style := rbRaised;
            wbWin40  : FRegion.Border.Style := rbSingleRaised;
            wbWin31  : FRegion.Border.Style := rbRaisedpsb;
          end;
  {  else
      FRegion.Border.Style := rbSingle;}

    if FPressed and (FRegion.Shadow.Style <> hssNone) then
      begin
        FRegion.OffsetRegion := Point (FRegion.Shadow.Depth, FRegion.Shadow.Depth);
        FRegion.TurnOffShadow := true;
      end;

{
und nu?

 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    FRegion.CreateRegion (ClientRect);
    FRegion.SetRegion;
!!!!!!!!!!!!!!!!!!!!!!!!!!!}

    if (FRegion.Shape <> rsBitmap) then
      FillControl;

    Canvas.Pen.Style := psSolid;
    Canvas.Brush.Style := bsClear;
    //paint the border
    if FRegion.Shape <> rsBitmap then
      if (FRegion.Shape = rsUserRegion) and (Assigned(FOnDrawBorder)) then
        FOnDrawBorder (self, Canvas, ClientRect)
      else
        FRegion.PaintRegionShape (Canvas, ClientRect)
    else
      begin
        case FRegion.Border.Style of
          rbSingle : Canvas.Draw (0, 0, FRegion.Mask.BorderBmp);
          rbLowered,
          rbSingleLowered,
          rbLoweredpsb : Canvas.Draw (0, 0, FRegion.Mask.BorderDnBmp);
        else
          Canvas.Draw (0, 0, FRegion.Mask.BorderUpBmp);
        end;
      end;

    Canvas.Font.Assign(Self.Font);

    flags:=0;
    flags:=DrawTextBiDiModeFlags(flags);

    if FPressed then
      bs := bsDown
    else
      bs := bsUp;

    //calculate text dimens
    LMDDrawTextCalcExt(Canvas, Caption, FFontFX, bRect, Font, FMultiLine, true,0,flags);
    if TLMDGlyph(FGlyph).Glyph <> nil then
      begin
        bRect.Right := bRect.Right + TLMDGlyph(FGlyph).Glyph.Width;
        //hier sollte ich vielleicht noch layout beachten :-)
        if TLMDGlyph(FGlyph).Glyph.Height > bRect.Bottom then
          bRect.Bottom := TLMDGlyph(FGlyph).Glyph.Height;
      end;

    //bRect = size text + size glyph
    if (FCaptionStart.X = -1) then
      begin //center text
        aRect := ClientRect;
      end
    else
      begin
        aRect := bRect;
        OffsetRect (aRect, FCaptionStart.X, FCaptionStart.Y-aRect.Bottom);
      end;

    //move the text and focus rect by Shadow Depth (only done if shadow and pressed, otherwise OffSetRegion = (0,0)
    OffsetRect (aRect, FRegion.OffsetRegion.X, FRegion.OffsetRegion.Y);

    if Pressed then
      OffsetInnerRect(aRect);

    If (FEnterColorChange) and (FFocused) then
      Canvas.Font.Color:=FEnterColor;

    //paint the text
    TLMDGlyph(FGlyph).DrawButtonGlyphAndText(Canvas, Caption, FFontFx, aRect, bs, ButtonLayout,
                                 [TLMDDrawTextStyle(Enabled), dt3DDisabled], FMultiLine, flags);
    if (FCaptionStart.X = -1) then
      begin
        aRect := LMDAlignRect (ButtonLayout.Alignment, bRect, ClientRect);
        //move the text and focus rect by Shadow Depth (only done if shadow and pressed, otherwise OffSetRegion = (0,0)
        OffsetRect (aRect, FRegion.OffsetRegion.X, FRegion.OffsetRegion.Y);

        if Pressed then
          OffsetInnerRect(aRect);

      end;

    OffsetRect (aRect, FButtonLayout.OffsetX, FButtonLayout.OffsetY);

    if FFocused then
      begin
        Canvas.Pen.Color := clBtnShadow;
        Canvas.Pen.Width := 0;
        Canvas.Pen.Style := psDot;
        Canvas.Brush.Style := bsClear;//bsSolid;
        case FFocusStyle of
          bfNone :;
          bfText :begin
                    Canvas.PolyLine ([Point(aRect.Left, aRect.Top),
                                      Point(aRect.Right, aRect.Top),
                                      Point(aRect.Right, aRect.Bottom),
                                      Point(aRect.Left, aRect.Bottom),
                                      Point(aRect.Left, aRect.Top)]);
                  end;
          bfClient:begin
                     case FRegion.Shape of
                       rsRect :
                         begin
                           InflateRect (aRect, -4, -4);
                           DrawFocusRect(Canvas.Handle, aRect);
                         end;
                       rsRoundRect :
                         begin
                           InflateRect (aRect, -FRegion.RoundX div 4, -FRegion.RoundY div 4);
                           DrawFocusRect(Canvas.Handle, aRect);
                         end;
                       rsOctagon :
                         begin
                           InflateRect (aRect, -FRegion.RoundX div 4, -FRegion.RoundY div 4);
                           DrawFocusRect(Canvas.Handle, aRect);
                         end;
                     end;
                   end;
        end;
    end;
  finally
    //reset Region helpers to defaults
    FRegion.TurnOffShadow := false;
    FRegion.OffsetRegion := Point (0,0);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.RestoreBorderBack;
begin
  Repaint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.RestoreBorderFront;
begin
  Repaint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDWndButtonShape.SetOffsetDirection(Value: TLMDWndButtonOffsetDirection);
begin
  FOffsetDirection := Value;
end;

end.
