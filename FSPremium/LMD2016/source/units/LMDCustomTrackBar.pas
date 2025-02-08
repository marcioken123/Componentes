unit LMDCustomTrackBar;
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

LMDCustomTrackBar unit (RM)
---------------------------
TrackBar control

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Graphics, Controls, StdCtrls,
  LMDClass, LMDGraph, LMDFillObject, LMDCustomPanel;

type
  {---------------------------- TLMDCustomTrackBar ----------------------------}
  TLMDThumbStyle = (tsStandard, tsCustom);
  TLMDTickStyle=(tsAuto, tsOwnerDraw, tsNone);
  TLMDTickMarks=(tmBoth, tmBottomRight, tmTopLeft);
  TLMDDrawTickEvent=procedure(Sender:TObject;aCanvas:TCanvas;aValue:Integer;
                              pos:TPoint) of object;
  TLMDTrackBarFocusStyle=(tbFocus, tbInvisibleFocus, tbNoFocus);

  TLMDCustomTrackBar = class(TLMDCustomPanel)
  private
    {internal}
    procedure SetColor(Index:Integer; aValue:TColor);
    procedure SetInteger(Index, aValue:Integer);
    procedure SetOrientation(aValue:TLMDOrientation);
    procedure SetPosition(aValue:Integer);
    procedure SetThumb(aValue:TBitmap);
    procedure SetThumbStyle(aValue:TLMDThumbStyle);
    procedure SetTickMarks(aValue:TLMDTickMarks);
    procedure SetTickStyle(aValue:TLMDTickStyle);
    procedure SetTrackBorderStyle(aValue:TLMDBorderStyle);
    procedure SetUseFocusColor(aValue:Boolean);
    procedure SetFillObject (aValue : TLMDFillObject);
    procedure SetBoolean (aValue : Boolean);
    function GetThumb:TBitmap;
    function IsCustom:Boolean;
    procedure SetUseGlobalTimer(const Value: Boolean);
    procedure WMGetDlgCode(var Msg:TWMGetDlgCode ); message WM_GetDlgCode;
    procedure CMEnabledChanged(var Msg:TMessage); message CM_EnabledChanged;
    procedure WMSetFocus (var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus (var Message: TWMKillFocus); message WM_KILLFOCUS;
  protected
    FOnDrawFrame:TNotifyEvent;
    FMax,
    FMin,
    FLineSize,
    FPageSize,
    FPosition,
    FTickLength,
    FMargin           : Integer;
    FTimerId          : TLMDTimer;   {ident for global timer}
    FTickStyle        : TLMDTickStyle;
    FTickMarks        : TLMDTickMarks;
    FTickGap          : Integer;
    FFocusColor,
    FTickColor        : TColor;

    FTrackTransparent,
    FUseFocusColor    : Boolean;
    FDirection        : Byte;
    FFocusStyle       : TLMDTrackBarFocusStyle;

    {track manipulation}
    FTrackBorderStyle : TLMDBorderStyle;
    FTrackBorder      : Integer;
    FTrackColor,
    FThumbColor       : TColor;
    FTrackWidth       : Integer;
    FTrackRect,
    FBRect,
    FCRect            : TRect;
    FThumbStyle       : TLMDThumbStyle;
    FThumb            : TBitmap;
    FTrackFillObject  : TLMDFillObject;
    FOrientation      : TLMDOrientation;
    FMousePos         : TPoint;
    FSliding          : Boolean;
    FThumbHeight,
    FThumbWidth,
    fh,
    fmyw,
    fmyh              : Integer;
    FBack             : TBitmap;
    FBuff             : TBitmap;

    FOnChange         : TNotifyEvent;
    FOnDrawTick       : TLMDDrawTickEvent;
    FOnTrack          : TScrollEvent;
    FUseGlobalTimer: Boolean;

    procedure CreateThumb;
    procedure Change; dynamic;
    procedure DoEnter; override;
    procedure DoExit; override;
    function IsMouseOnTrack(const AMousePos: TPoint): Boolean; virtual;
    procedure DoThemeChanged; override;
    function DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    function DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean; override;
    procedure RestoreThumbBack(const ABRect: TRect; const ABack: TBitmap); virtual;
    procedure DrawFocus(aRect:TRect);
    procedure DrawThumb(fpos:Integer; var ABRect: TRect; var ABack: TBitmap; AActiveSlider: Boolean); virtual;
    procedure TimerExpired(Sender:TObject); virtual;
    procedure DrawTicks; virtual;
    procedure DoDrawTick(aCanvas:TCanvas;aValue:Integer;pos:TPoint); dynamic;
    procedure GetChange(Sender:TObject);override;
    procedure GetIMLChange(Sender:TObject);override;
    function GetPosition:Integer;virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure CalcThumbRect(fpos: Integer; var ABRect: TRect); virtual;
    procedure MouseDown(Button:TMouseButton;Shift:TShiftState; x,y:Integer);override;
    procedure MouseMove(Shift:TShiftState; x,y:Integer);override;
    procedure MouseUp(Button:TMouseButton;Shift:TShiftState;X,Y:Integer);override;
    procedure PaintPos; virtual;
    procedure Paint; override;
    procedure PrepareBuff;
    property OnDrawFrame:TNotifyEvent read FOnDrawFrame write FOnDrawFrame;
  public
    constructor Create(AOwner:TComponent);override;
    procedure Init;
    destructor Destroy; override;
    procedure Assign (Source : TPersistent); override;
    function isTransparentSet:Boolean; override;
    procedure SetRange(MinValue, MaxValue:Integer); // silent settings if Min/Max Value
    property Position:Integer read FPosition write SetPosition;
    property CtlXP default false;  // compatibility
  published
    property FocusColor:TColor index 3 read FFocusColor write SetColor default clGray;
    property FocusStyle : TLMDTrackBarFocusStyle read FFocusStyle write FFocusStyle default tbFocus;
    property UseFocusColor:Boolean read FUseFocusColor write SetUseFocusColor default false;
    property MaxValue:Integer index 0 read FMax write SetInteger default 10;
    property MinValue:Integer index 1 read FMin write SetInteger default 0;
    property Margin:Integer index 7 read FMargin write SetInteger default 1;
    property LineSize:Integer index 2 read FLineSize write SetInteger default 1;
    property PageSize:Integer index 3 read FPageSize write SetInteger default 2;
    property Orientation:TLMDOrientation read FOrientation write SetOrientation default toHorizontal;

    property Thumb:TBitmap read GetThumb write SetThumb stored IsCustom;
    property ThumbColor:TColor index 0 read FThumbColor write SetColor default clbtnface;
    property ThumbStyle:TLMDThumbStyle read FThumbStyle write SetThumbStyle default tsStandard;
    property TickColor:TColor index 2 read FTickColor write SetColor default clBlack;
    property TickGap:Integer index 8 read FTickGap write SetInteger default -1;
    property TickLength:Integer index 6 read FTickLength write SetInteger default 6;
    property TickMarks:TLMDTickMarks read FTickMarks write SetTickMarks default tmBottomRight;
    property TickStyle:TLMDTickStyle read FTickStyle write SetTickStyle default tsAuto;
    property TrackBorderStyle:TLMDBorderStyle read FTrackBorderStyle write SetTrackBorderStyle default lsLoweredExt;
    property TrackBorder:Integer index 4 read FTrackBorder write SetInteger default 0;
    property TrackColor:TColor index 1 read FTrackColor write SetColor default clWhite;
    property TrackWidth:Integer index 5 read FTrackWidth write SetInteger default 10;
    property TrackFillObject : TLMDFillObject read FTrackFillObject write SetFillObject;
    property TrackTransparent : Boolean read FTrackTransparent write SetBoolean default false;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
    property OnDrawTick:TLMDDrawTickEvent read FOnDrawTick write FOnDrawTick;
    property OnTrack:TScrollEvent read FOnTrack write FOnTrack;

    property About;
    {inherited properties}
    property Align;
    property BackFX;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ImageList;
    property ImageIndex;
    property ListIndex;

    property ParentBackground default false;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;

    // 7.0
    property UseGlobalTimer:Boolean read FUseGlobalTimer write SetUseGlobalTimer default false;
    // 9.0
    property ThemeMode default ttmNone;
    property ThemeGlobalMode;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnStartDrag;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
    {4.0}
    //properties
    property Anchors;
    property DragKind;
    property Constraints;
    //events
    property OnEndDock;
    property OnStartDock;
    property OnMouseWheelDown;
    Property OnMouseWheelUp;
  end;

implementation
uses
  Types, Forms, Consts, SysUtils, Themes,
  LMDUtils, LMDProcs, LMDGraphUtils, LMDCont, LMDCustomControl,
  LMDCustomImageList, LMDThemes;

const
  LMDRepInit=300;

{************************* class TLMDCustomTrackBar ***************************}
{--------------------------- private ------------------------------------------}
procedure TLMDCustomTrackBar.SetInteger(Index, aValue:Integer);
begin
  case Index of
    0: if (aValue<>FMax) and (aValue>FMin) then
         begin
           FMax:=aValue;
           if FPosition > FMax then
             Position:=FMax;
           Invalidate;
         end;
    1: if (aValue<>FMin) and (aValue<FMax) then
         begin
           FMin:=aValue;
           if FPosition < FMin then
             Position:=FMin;
           Invalidate;
         end;
    2: FLineSize:=aValue;
    3: FPageSize:=aValue;
    4: if aValue<>FTrackBorder then
         begin
           FTrackBorder:=aValue;
           Invalidate;
         end;
    5: if (aValue<>FTrackWidth) and (aValue>2) then
         begin
           FTrackWidth:=aValue;
           CreateThumb;
           Invalidate;
         end;
    6: if aValue<>FTickLength then
         begin
           FTickLength:=aValue;
           Invalidate;
         end;
    7: if (aValue<>FMargin) and (aValue>0) then
         begin
           FMargin:=aValue;
           Invalidate;
         end;
    8: if (aValue<>FTickGap) and (aValue>-2) then
         begin
           FTickGap:=aValue;
           Invalidate;
         end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetUseGlobalTimer(const Value: Boolean);
begin
  if FUseGlobalTimer<>Value then
    begin
      FUseGlobalTimer := Value;
      FTimerID.GlobalMode:=FUseGlobalTimer;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetThumb(aValue:TBitmap);
begin
  FThumb.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetThumbStyle(aValue:TLMDThumbStyle);
begin
  if aValue<>FThumbStyle then
    begin
      FThumbStyle:=aValue;
      CreateThumb;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetTickMarks(aValue:TLMDTickMarks);
begin
  if aValue<>FTickMarks then
    begin
      FTickMarks:=aValue;
      CreateThumb;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetTickStyle(aValue:TLMDTickStyle );
begin
  if aValue<>FTickStyle then
    begin
      FTickStyle:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetTrackBorderStyle(aValue:TLMDBorderStyle);
begin
  if aValue<>FTrackBorderStyle then
    begin
      FTrackBorderStyle:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetColor(Index:Integer; aValue:TColor);
begin
  case Index of
    0:if aValue<>FThumbColor then
        begin
          FThumbColor:=aValue;
          CreateThumb;
          Invalidate;
        end;
    1:if aValue<>FTrackColor then
        begin
          FTrackColor:=aValue;
          Invalidate;
        end;
    2:if aValue<>FTickColor then
        begin
          FTickColor:=aValue;
          Invalidate;
        end;
    3:if aValue<>FFocusColor then
        begin
          FFocusColor:=aValue;
          Invalidate;
        end;
  end;

  FreeAndNil(FBuff); // Bitmaps need to be updated.
  FreeAndNil(FBack); //
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetOrientation(aValue:TLMDOrientation);
begin
  if aValue <> FOrientation then
    begin
      FOrientation:=aValue;
      CreateThumb;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetPosition(aValue:Integer);
begin
  if aValue<FMin then aValue:=FMin else if aValue > FMax then aValue:=FMax;
  if aValue<>FPosition then
    begin
      if (aValue = FMax) and Assigned (FOnTrack) then
        FOnTrack (self, scBottom, FMax);
      if (aValue = FMin) and Assigned (FOnTrack) then
        FOnTrack (self, scTop, FMin);
      FPosition:=aValue;
      if csDesigning in ComponentState then
        Invalidate
      else
        begin
          // --> changed 01-07-2002, to avoid flicker in key/wheel mode
          RestoreThumbBack(FBRect, FBack);
          DrawThumb(FPosition, FBRect, FBack, FSliding);
          Change;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetUseFocusColor(aValue:Boolean);
begin
  if aValue<>FUseFocusColor then
    begin
      FUseFocusColor:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetFillObject (aValue : TLMDFillObject);
begin
  FTrackFillObject.Assign (aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetBoolean (aValue : Boolean);
begin
  if aValue <> FTrackTransparent then
    begin
      FTrackTransparent := aValue;
      GetChange (nil);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTrackBar.GetThumb:TBitmap;
begin
  if csLoading in ComponentState then
    result:=FThumb
  else
    if IsCustom and (ImageList=nil) then
      result:=FThumb
    else
      result:=nil;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTrackBar.IsCustom:Boolean;
begin
  result:=FThumbStyle=tsCustom;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.TimerExpired(Sender: TObject);
var
  px, py:Integer;
  tmp:Extended;
begin
  if IsMouseOnTrack(FMousePos) then
    try
      if FOrientation = toVertical then
        begin
          tmp:=(fmyh-FThumbWidth)/(FMax - FMin);
          py:=Trunc(tmp*((FMax - FPosition) - FMin));
          if FMousePos.Y<py then
            if FDirection=2 then
              Position := FPosition + FPageSize
            else
              FTimerID.Enabled:=False;
          if FMousePos.Y>=py then
            if FDirection=1 then
              Position:=FPosition-FPageSize
            else
              FTimerID.Enabled:=False;
        end
      else
        begin
          tmp:=(fmyw-FThumbWidth)/(FMax-FMin);
          px:=Trunc(tmp*(FPosition - FMin));
          if FMousePos.X<px then
            if FDirection=2 then
              Position:=FPosition-FPageSize
            else
              FTimerID.Enabled:=False;
          if FMousePos.X>=px then
            if FDirection=1 then
              Position:=FPosition+FPageSize
            else
             FTimerID.Enabled:=False;
        end;
    except
      FTimerID.Enabled:=False;
      raise;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.CMEnabledChanged(var Msg:TMessage);
begin
  inherited;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.WMGetDlgCode(var Msg:TWMGetDlgCode);
begin
  inherited;
  Msg.Result:=DLGC_WANTARROWS;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomTrackBar.WMSetFocus (var Message: TWMSetFocus);
begin
  inherited;
  RePaint;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomTrackBar.WMKillFocus (var Message: TWMKillFocus);
begin
  inherited;
  RePaint;
end;

{--------------------------- protected ----------------------------------------}
procedure TLMDCustomTrackBar.CreateThumb;
var
  aRect,
  bRect  : TRect;
  tb     : TBitmap;
  part   : TThemedTrackBar;
  lTheme : TLMDThemeMode;

  procedure BuildPointer(aValue:Boolean);
  var
    tmp:Byte;
  begin
    with tb do
      begin
        Canvas.Brush.Style:=bsSolid;
        Canvas.Brush.Color:=clOlive;
        Canvas.FillRect(Rect(0,0,Width, Height));
        bRect := Rect(0,0,Width, Height);

        if (lTheme<>ttmNone) and (Parent <> nil) then
          begin
            if Orientation <> toVertical then
              begin
                if FTickMarks=tmTopLeft then
                  begin
                    if aValue then
                      part := ttbThumbTopHot
                    else
                      part := ttbThumbTopNormal;
                  end
                else
                  begin
                    if aValue then
                      part := ttbThumbBottomHot
                    else
                      part := ttbThumbBottomNormal;
                  end
              end
            else
              begin
                if FTickMarks=tmTopLeft then
                  begin
                    if aValue then
                      part := ttbThumbLeftHot
                    else
                      part := ttbThumbLeftNormal;
                  end
                else
                  begin
                    if aValue then
                      part := ttbThumbRightHot
                    else
                      part := ttbThumbRightNormal;
                  end;
              end;
            LMDThemeServices.DrawElement(lTheme, tb.Canvas.Handle, part, bRect);
            exit;
          end;

        if aValue then
          Canvas.Brush.Bitmap:=LMDApplication.GetBrushBitmap(FThumbColor)
        else
          begin
            Canvas.Brush.Bitmap:=nil;
            Canvas.Brush.Color:=FThumbColor;
          end;

        with Canvas, aRect do
          if FOrientation=toVertical then
            begin
              tmp:=Bottom div 2;
              Pen.Color:=clWhite;
              Pen.Width:=1;
              if FTickMarks=tmTopLeft then
                begin
                  Polygon([Point(Right-2,0), Point(Right-2, Bottom-1), Point(tmp, Bottom-1),
                           Point(0, tmp), Point(tmp,0)]);
                  MoveTo(0, tmp-1);
                  LineTo(tmp-1, 0);
                  LineTo(tmp, 0);
                end
              else
                Polygon([Point(2,0), Point(2, Bottom-1), Point(Right-tmp, Bottom-1),
                         Point(Right, tmp), Point(Right-tmp,0), Point(2,0)]);
              Pen.Color:=clBlack;
              if FTickMarks=tmTopLeft then
                begin
                  PolyLine([Point(Right-2, 0), Point(Right-2, Bottom-1), Point(tmp, Bottom-1), Point(0, tmp)]);
                  Pixels[0, tmp]:=clBlack;
                end
              else
                begin
                  PolyLine([Point(2, Bottom-1), Point(Right-tmp, Bottom-1), Point(Right, tmp)]);
                  Pixels[Right, tmp]:=clBlack;
                end;
              Pen.Color:=clGray;
              if FTickMarks=tmTopLeft then
                PolyLine([Point(Right-3, 1), Point(Right-3, Bottom-2), Point(tmp, Bottom-2), Point(1, tmp)])
              else
                PolyLine([Point(3, Bottom-2), Point(Right-tmp, Bottom-2), Point(Right-1, tmp)]);
            end
          else
            begin
              tmp:=Right div 2;
              Pen.Color:=clWhite;
              if FTickMarks=tmBottomRight then
                begin
                  Polygon([Point(0,2), Point(0, Bottom-tmp), Point(tmp, Bottom),
                           Point(Right-1, Bottom-tmp), Point(Right-1,2)]);
                  MoveTo(0, Bottom-tmp);
                  LineTo(tmp+1,Height);
                end
              else
                begin
                  Polygon([Point(0,Bottom-2), Point(0, tmp), Point(tmp, 0),
                           Point(Right-1, tmp), Point(Right-1,Bottom-2)]);
                  MoveTo(0, tmp);
                  LineTo(tmp,0);
                 end;
              Pen.Color:=clBlack;
              if FTickMarks=tmBottomRight then
                begin
                  PolyLine([Point(Right-1, 2), Point(Right-1, Bottom-tmp), Point(tmp, Bottom)]);
                  Pixels[tmp, Bottom]:=clBlack;
                end
              else
                begin
                  PolyLine([Point(0, Bottom-2), Point(Right-1, Bottom-2), Point(Right-1, tmp), Point(tmp, 0)]);
                  Pixels[tmp, 0]:=clBlack;
                end;
              Pen.Color:=clGray;
              if FTickMarks=tmBottomRight then
                PolyLine([Point(Right-2, 3), Point(Right-2, Bottom-tmp), Point(tmp, Bottom-1)])
              else
                PolyLine([Point(1, Bottom-3), Point(Right-2, Bottom-3), Point(Right-2, tmp), Point(tmp, 1)]);
            end;
      end;
  end;

begin
  if (csLoading in ComponentState) or (FThumbStyle=tsCustom) then exit;
  FThumb.OnChange:=nil;
  if FOrientation=toVertical then
    aRect:=Rect(0,0,FTrackWidth+8, FTrackWidth)
  else
    aRect:=Rect(0,0, FTrackWidth, FTrackWidth+8);

  lTheme := UseThemeMode;
  tb:=TBitmap.Create;
  try
    case FTickMarks of
      tmBottomRight, tmTopLeft:
        begin
          if (aRect.Right mod 2)=0 then Inc(aRect.Right);
          if (aRect.Bottom mod 2)=0 then Inc(aRect.Bottom);

          tb.Width:=aRect.Right;
          tb.Height:=aRect.Bottom+1;

          FThumb.Height:=tb.Height;
          FThumb.Width:=2*tb.Width;

          BuildPointer(false);
          FThumb.Canvas.Draw(0,0, tb);

          BuildPointer(True);
          FThumb.Canvas.Draw(tb.Width,0, tb);
        end;
      tmBoth:
        begin
          tb.Width:=aRect.Right;
          tb.Height:=aRect.Bottom;

          FThumb.Height:=tb.Height;
          FThumb.Width:=2*tb.Width;

          with tb do
            begin
              if lTheme<>ttmNone then
                begin
                  bRect := Rect (0,0,tb.Width, tb.Height);
                  LMDThemeServices.DrawElement(lTheme, tb.Canvas.Handle, ttbThumbNormal, bRect);
                  FThumb.Canvas.Draw(0,0, tb);
                  //FThumb.Canvas.Draw(tb.Width,0, tb);
                end
              else
                begin
                  Canvas.Brush.Color:=FThumbColor;
                  Canvas.FillRect(aRect);
                  LMDDrawStdFrame(Canvas, aRect, lsRaisedExt, 0);
                  FThumb.Canvas.Draw(0,0, tb);
                  Canvas.Brush.Bitmap:=LMDApplication.GetBrushBitmap(FThumbColor);
                  aRect:=Rect(0,0, Width, Height);
                  Canvas.FillRect(aRect);
                  LMDDrawStdFrame(Canvas, aRect, lsRaisedExt, 0);
                  FThumb.Canvas.Draw(tb.Width,0, tb);
                end;
            end;
        end;
      end;
  finally
    tb.Free;
  end;

  if FOrientation = toVertical then
    begin
      FThumbHeight:=FThumb.Width div 2;
      FThumbWidth:=FThumb.Height;
    end
  else
    begin
      FThumbHeight:=FThumb.Height;
      FThumbWidth:=FThumb.Width div 2;
    end;

  fh:=(FThumbWidth div 2);
  FThumb.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.DoDrawTick(aCanvas:TCanvas;aValue:Integer;pos:TPoint);
begin
  if Assigned(FOnDrawTick) then
    FOnDrawTick(Self, aCanvas, aValue, pos);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomTrackBar.DoEnter;
begin
  inherited DoEnter;
  
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomTrackBar.DoExit;
begin
  inherited DoExit;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.DoThemeChanged;
begin
  //on theme change: rebuild thumb
  FreeAndNil(FBuff);
  CreateThumb;
  Invalidate;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTrackBar.DoMouseWheelDown(Shift: TShiftState; MousePos: TPoint): Boolean;
var
  tmp:Word;
begin
  inherited DoMouseWheelDown(Shift, MousePos);
  tmp:=VK_DOWN;
  KeyDown(tmp, []);
  result:=True;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTrackBar.DoMouseWheelUp(Shift: TShiftState; MousePos: TPoint): Boolean;
var
  tmp:Word;
begin
  inherited DoMouseWheelUp(Shift, MousePos);
  tmp:=VK_UP;
  KeyDown(tmp, []);
  result:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.RestoreThumbBack(const ABRect: TRect;
  const ABack: TBitmap);
begin
  if not Assigned (ABack) then
    exit;
  Canvas.Draw(ABRect.Left, ABRect.Top, ABack);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.DrawFocus(aRect:TRect);
begin
  if FFocusStyle in [tbNoFocus, tbInvisibleFocus] then exit;
  if FUseFocusColor then
    with Canvas do
      begin
        {Brush.Color:=Color;}
        Brush.Style:=bsClear;
        Pen.Style:=psDot;
        Pen.Width:=1;
        Pen.Color:=FFocusColor;
        with aRect do
         Canvas.Rectangle(Left, Top, Right, Bottom);
       Canvas.pen.Style:=psSolid;
     end
   else
     begin
       Canvas.DrawFocusRect(aRect);
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.DrawThumb(fpos:Integer; var ABRect: TRect;
  var ABack: TBitmap; AActiveSlider: Boolean);
var
  aRect:TRect;
  tmp:Integer;
  lCanvas: TCanvas;
begin
  if not Visible then exit;

  CalcThumbRect(fpos, ABRect);

  tmp:=FThumb.Width div 2;
  aRect:=Rect(0,0, tmp, FThumb.Height);

  if not Assigned (ABack) then
    ABack := TBitmap.Create;
  ABack.Width:=tmp;
  ABack.Height:=FThumb.Height;

  if FBuff = nil then
    lCanvas := Canvas
  else
    lCanvas := FBuff.Canvas;
  ABack.Canvas.CopyRect(aRect, lCanvas, ABRect);

  if (FThumbStyle=tsStandard) and (FTickMarks=tmBoth)  then
  begin
    if Enabled and not AActiveSlider then
      Canvas.CopyRect(ABRect,FThumb.Canvas,aRect)
    else
      Canvas.CopyRect(ABRect,FThumb.Canvas,Rect(tmp, 0, FThumb.Width, FThumb.Height));
  end
  else
  begin
    if FThumb.Empty then exit;

    with TBitmap.Create do
      try
        Height:=FThumb.Height;
        Width:=tmp;

        case FThumbStyle of
          tsStandard:
            begin
              LMDBmpDraw(Canvas, aRect, ABack, 0, clNone);
              if Enabled and not AActiveSlider then
                LMDBmpDrawExt(Canvas, aRect, FThumb.Canvas, aRect,
                              DSF_TRANSPARENCY, clOlive, 0, nil)
              else
                LMDBmpDrawExt(Canvas, aRect, FThumb.Canvas, Rect(tmp, 0, FThumb.Width, FThumb.Height),
                              DSF_TRANSPARENCY, clOlive, 0, nil);

            end;
          tsCustom:
            begin
              LMDBmpDraw(Canvas, aRect, ABack, 0, clNone);
              if Enabled and not AActiveSlider then
                LMDBmpDrawExt(Canvas, aRect, FThumb.Canvas, aRect,
                              DSF_TRANSPARENCY, FThumb.TransparentColor, 0, nil)
              else
                LMDBmpDrawExt(Canvas, aRect, FThumb.Canvas, Rect(tmp, 0, FThumb.Width, FThumb.Height),
                              DSF_TRANSPARENCY, FThumb.TransparentColor, 0, nil);

            end
        end;

        self.Canvas.CopyRect(ABRect, Canvas, aRect );
      finally
        Free;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.DrawTicks;
var
  i,x,y, wi:Integer;
  delta:Extended;
  lCanvas: TCanvas;
begin
  wi:=FTickLength;
  lCanvas := Canvas;
  lCanvas.Font:=self.Font;
  lCanvas.Pen.Color:=FTickColor;
//  with FTrackRect do
  begin
    if FOrientation = toVertical then
      begin
        delta:=(fmyh-FThumbWidth)/(FMax-FMin);
        i:=FMin;
        while i<=FMax do
          begin
            y:=Trunc(delta*(i-FMin))+FCRect.Top;

            if FTickStyle=tsAuto then
              begin
                if FTickMarks in [tmTopLeft, tmBoth] then
{                  if UseXPTics then
                    drawTick (Rect (FCRect.Left,y+fh, FCRect.Left+wi,y+fh+1))
                  else}
                    begin
                      lCanvas.MoveTo(FCRect.Left,y+fh);
                      lCanvas.LineTo(FCRect.Left+wi,y+fh);
                    end;
                if FTickMarks in [tmBottomRight, tmBoth] then
{                  if UseXPTics then
                    drawTick (Rect (FCRect.Right-wi,y+fh, FCRect.Right,y+fh+1))
                  else}
                    begin
                      lCanvas.MoveTo(FCRect.Right-wi,y+fh);
                      lCanvas.LineTo(FCRect.Right,y+fh);
                    end;
              end
            else
              begin
                if FTickMarks in [tmTopLeft, tmBoth] then DoDrawTick(lCanvas, i, Point(FCRect.Left,y+fh));
                if FTickMarks in [tmBottomRight, tmBoth] then DoDrawTick(lCanvas, i, Point(FCRect.Right-wi,y+fh));
              end;
            if FTickGap<2 then Inc(i) else Inc(i, FTickGap);
          end;
      end
    else
      begin
        delta:=(fmyw-FThumbWidth)/(FMax-FMin);
        i:=FMin;
        while i<=Fmax do
          begin
            x:=Trunc(delta*(i-FMin))+FCRect.Left;
            if FTickStyle=tsAuto then
              begin
                if FTickMarks in [tmTopLeft, tmBoth] then
{                  if UseXPTics then
                    drawTick (Rect (x+fh, FCRect.Top, x+fh+1, FCRect.Top+wi))
                  else }
                    begin
                      lCanvas.MoveTo(x+fh, FCRect.Top);
                      lCanvas.LineTo(x+fh, FCRect.Top+wi);
                    end;
                if FTickMarks in [tmBottomRight,tmBoth] then
{                  if UseXPTics then
                    drawTick (Rect (x+fh, FCRect.Bottom-wi, x+fh+1, FCRect.Bottom))
                  else}
                    begin
                      lCanvas.MoveTo(x+fh, FCRect.Bottom-wi);
                      lCanvas.LineTo(x+fh, FCRect.Bottom);
                    end;
              end
            else
              begin
                if FTickMarks in [tmTopLeft, tmBoth] then DoDrawTick(lCanvas, i, Point(x+fh, FCRect.Top));
                if FTickMarks in [tmBottomRight, tmBoth] then DoDrawTick(lCanvas, i, Point(x+fh, FCRect.Bottom-wi));
              end;
            if FTickGap<2 then Inc(i) else Inc(i, FTickGap);
          end;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.GetChange(Sender:TObject);
begin
  if sender=FThumb then
    if FThumb.Empty then
      begin
       FThumbStyle:=tsCustom;
       ThumbStyle:=tsStandard;
      end
    else
      begin
        FThumb.OnChange:=nil;
        if not IMLEmpty then
          LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FThumb);
        FThumbStyle :=tsCustom;
        FThumbHeight:=FThumb.Height;
        FThumbWidth:=FThumb.Width div 2;
        fh:=(FThumbWidth div 2);
        FThumb.OnChange:=GetChange;
      end;
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.GetIMLChange(Sender:TObject);
begin
  if not IMLEmpty then
    begin
      LMDIMLItemBitmap(ImageList, ListIndex, ImageIndex, FThumb);
      FThumbStyle:=tsCustom;
      FThumbHeight:=FThumb.Height;
      FThumbWidth:=FThumb.Width div 2;
      fh:=(FThumbWidth div 2);
    end
  else
    ThumbStyle:=tsStandard;
  Invalidate;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTrackBar.GetPosition:Integer;
begin
  result:=FPosition;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  v:Integer;
begin
  inherited KeyDown(Key, Shift);
  case key of
    VK_UP,
    VK_RIGHT: begin
                v := LMDMin([FPosition+FLineSize, FMax]);
                if Assigned (FOnTrack) then FOnTrack (self, scLineUp, v);
                Position:=v;
              end;
    VK_DOWN,
    VK_LEFT : begin
                v := LMDMax([FPosition-FLineSize, FMin]);
                if Assigned (FOnTrack) then FOnTrack (self, scLineDown, v);
                Position:=v;
              end;
    VK_PRIOR: begin
                v := LMDMin([FPosition+FPageSize, FMax]);
                if Assigned (FOnTrack) then FOnTrack (self, scPageUp, v);
                Position:=v;
              end;
    VK_NEXT : begin
                v := LMDMax([FPosition-FPageSize, FMin]);
                if Assigned (FOnTrack) then FOnTrack (self, scPageDown, v);
                Position:=v;
              end;
    VK_END  : Position := FMax;
    VK_HOME : Position := FMin;
  end;
  if key in [VK_UP, VK_RIGHT, VK_DOWN, VK_LEFT, VK_PRIOR, VK_NEXT] then
    if Assigned (FOnTrack) then FOnTrack (self, scEndScroll, FPosition);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.Loaded;
begin
  inherited Loaded;
  Init;
  if FFocusStyle = tbNoFocus then
    TabStop := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  v,
  px, py:Integer;
  tmp:Extended;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if FFocusStyle <> tbNoFocus then
    SetFocus;
  if (Button=mbLeft) and PtInRect(FBRect, Point(X,Y)) then
  begin
    FSliding:=true;
    RestoreThumbBack(FBRect, FBack);
    DrawThumb(FPosition, FBRect, FBack, FSliding);
  end
  else
    if (Button=mbLeft) and IsMouseOnTrack(Point(X, Y)) then
    begin
      FTimerId.Enabled:=True;
      if FOrientation = toVertical then
      begin
        tmp:=(fmyh-FThumbWidth)/(FMax - FMin);
        py:=Trunc(tmp*((FMax-FPosition)-FMin));
        FDirection:=Ord(Y<py)+1;
        if FDirection=2 then
          begin
            v:=LMDMin([FPosition+FPageSize, FMax]);
            if Assigned (FOnTrack) then FOnTrack (self, scPageUp, v);
            if Position<>v then
            begin
              Application.CancelHint;
              Position:=v;
            end;
          end
        else
        begin
          v := LMDMax([FPosition-FPageSize, FMin]);
          if Assigned (FOnTrack) then FOnTrack (self, scPageDown, v);
          if Position<>v then
          begin
            Application.CancelHint;
            Position:=v;
          end;
        end;
      end
      else
      begin
        tmp:=(fmyw-FThumbWidth)/(FMax-FMin);
        px:=Trunc(tmp*(FPosition - FMin));
        FDirection:=Ord(X<px)+1;
        if FDirection=2 then
        begin
          v := LMDMax([FPosition-FPageSize, FMin]);
          if Assigned (FOnTrack) then FOnTrack (self, scPageDown, v);
          if Position<>v then
          begin
            Application.CancelHint;
            Position:=v;
          end;
        end
        else
        begin
          v := LMDMin([FPosition+FPageSize, FMax]);
          if Assigned (FOnTrack) then
            FOnTrack (self, scPageUp, v);
          if Position<>v then
          begin
            Application.CancelHint;
            Position:=v;
          end;
        end;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  p,w,h:Integer;
begin
  inherited MouseMove(Shift, X, Y );
  FMousePos:=Point(X,Y);
  if FSliding then
  begin
    if FOrientation=toVertical then
      begin
        H:=fmyh-fh;
        p:=Round(((H-y)/H)*(FMax-FMin)+FMin);
      end
    else
      begin
        W:=fmyw-fh;
        p:=Round(((X-fh)/W)*(FMax-FMin)+FMin);
      end;
    if Assigned (FOnTrack) then
      FOnTrack (self, scTrack, p);
    if p<>Position then
      begin
        Application.CancelHint;
        Position:=p;
      end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp( Button, Shift, X, Y );
  FTimerId.Enabled:=False;
  if Button=mbLeft then
    begin
      if FSliding and Assigned (FOnTrack) then
        FOnTrack (self, scPosition, FPosition);
      FSliding:=false;
      RestoreThumbBack(FBRect, FBack);
      DrawThumb(FPosition, FBRect, FBack, FSliding);
    end;
  if Assigned (FOnTrack) then
    FOnTrack (self, scEndScroll, FPosition);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.PaintPos;
var
  aRect:TRect;
  part : TThemedTrackBar;
  lTheme : TLMDThemeMode;
  lCanvas: TCanvas;
begin
   FillControl;
   lCanvas := Canvas;

   FCRect:=ClientRect;
   InflateRect(FCRect,-FMargin,-FMargin);

   with FCRect do
   begin
     fmyw:=Right-Left;
     fmyh:=Bottom-Top;
   end;

   if FOrientation=toVertical then
   begin
     if (FTickStyle=tsNone) or (FTickMarks=tmBottomRight) then
        FTrackRect:=Bounds(FCRect.Left+FTrackWidth div 2, FCRect.Top+fh, FTrackWidth, fmyh-2*fh)
     else
       if FTickMarks=tmTopLeft then
         // changed to avoid collision focus frame and thumb
         FTrackRect:=Bounds(FCRect.Left+fmyw-FTrackWidth-(FTrackWidth div 2), FCRect.Top+fh,
                            FTrackWidth, fmyh-2*fh)
       else
         FTrackRect:=Bounds(FCRect.Left+((fmyw-FTrackWidth) div 2), FCRect.Top+fh,
                            FTrackWidth, fmyh-2*fh);
   end
   else
   begin
     if (FTickStyle=tsNone) or (FTickMarks=tmBottomRight) then
       FTrackRect:=Bounds(FCRect.Left+fh, FCRect.Top+(FTrackWidth div 2)+1,
                          fmyw-2*fh,FTrackWidth)
     else
       if FTickMarks=tmTopLeft then
         FTrackRect:=Bounds(FCRect.Left+fh, FCRect.Top+fmyh-FTrackWidth-(FTrackWidth div 2),
                            fmyw-2*fh,FTrackWidth)
       else
         FTrackRect:=Bounds(FCRect.Left+fh, FCRect.Top+(fmyh-FTrackWidth) div 2,
                            fmyw-2*fh,FTrackWidth);
   end;

  {draw track}
  aRect:=FTrackRect;
  lTheme := UseThemeMode;
  with lCanvas do
  begin
    if lTheme=ttmNone then
      begin
        LMDDrawStdFrame(lCanvas, aRect, FTrackBorderStyle, 0);
        InflateRect(aRect, -FTrackBorder, -FTrackBorder);
      end
    else
      begin
        if Orientation <> toVertical then
          part := ttbTrack
        else
          part := ttbTrackVert;
        LMDThemeServices.DrawElement(lTheme, lCanvas.Handle, part, aRect);
        aRect := LMDThemeServices.ContentRect(lTHeme, lCanvas.Handle, ThemeServices.GetElementDetails(part), aRect);
      end;
    if not FTrackTransparent then
      if (FTrackFillObject.Style = TLMDFillStyle(sfNone)) and (lTheme=ttmNone) then
        begin
          Brush.Color:=FTrackColor;
          FillRect(aRect);
        end
      else
        FTrackFillObject.FillCanvas (lCanvas, aRect, Color)
    else //trans track
      if not Transparent or (lTheme<>ttmNone) {XP -> we need to restore back} then
        BackDrawArea (lCanvas, aRect, Point(aRect.Left, aRect.Top), 0);
    Brush.Color:=Color;
  end;
  if FTickStyle<>tsNone then
    DrawTicks;
  PrepareBuff;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.Paint;
begin
  PaintPos;
  DrawThumb(Position, FBRect, FBack, FSliding);
  if Focused then
    DrawFocus(ClientRect);
  if Assigned(FOnDrawFrame) then
    FOnDrawFrame(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.SetRange(MinValue, MaxValue:Integer);
begin
  // silent settings if Min/Max Value, used e.g. in TrackBarComboBox controls
  FMin:=MinValue;
  FMax:=MaxValue;
  FPosition:=FMin;  // set FPosition to lowest possible value
end;

procedure TLMDCustomTrackBar.CalcThumbRect(fpos: Integer; var ABRect: TRect);
var
  tmp: Integer;
begin
  if FOrientation = toVertical then
  begin
    tmp := (fmyh - FThumbWidth) * (fpos - FMin) div (FMax - FMin);
    ABRect := Bounds(FTrackRect.Left - ((FThumbHeight - FTrackWidth) div 2), FCRect.Top + (fmyh - tmp) - FThumbWidth, FThumbHeight, FThumbWidth);
  end
  else
  begin
    tmp := (fmyw - FThumbWidth) * (fpos - FMin) div (FMax - FMin);
    ABRect := Bounds(FCRect.Left + tmp, FTrackRect.Top - ((FThumbHeight - FTrackWidth) div 2), FThumbWidth, FThumbHeight);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomTrackBar.IsMouseOnTrack(const AMousePos: TPoint): Boolean;
begin
  Result := PtInRect(FTrackRect, AMousePos);
end;

{------------------------------------------------------------------------------}
function TLMDCustomTrackBar.isTransparentSet:Boolean;
begin
  result:=(Transparent or FTrackTransparent);
end;

{--------------------------- public -------------------------------------------}
constructor TLMDCustomTrackBar.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  //ControlStyle:=ControlStyle + [csOpaque] - [csAcceptsControls, csParentBackground];
  ControlStyle:=ControlStyle + [csOpaque] - [csAcceptsControls{$IFDEF LMDCOMP7}, csParentBackground{$ENDIF}];
  {$IFNDEF LMDCOMP7}
  BeginUpdate;
  ParentBackground := false;
  EndUpdate;
  {$ENDIF}
  FBuff := nil;

  FThemeMode := ttmNone;
  FMin:=0;
  FMargin:=1;
  FMax:=10;
  FOrientation:=toHorizontal;
  FPosition:=0;
  FLineSize:=1;
  FPageSize:=2;

  FThumbColor:=clBtnFace;
  FTrackBorderStyle:=lsLoweredExt;
  FTrackColor:=clWhite;
  FTrackWidth:=10;
  FTickGap:=-1;
  FTickColor:=clBlack;
  FTickLength:=6;
  FSliding:=False;
  FTrackBorder:=0;
  FThumbStyle:=tsStandard;
  FTickMarks:=tmBottomRight;

  FThumb:=TBitmap.Create;
  FThumb.OnChange:=GetChange;

  FUseFocusColor:=false;
  FFocusColor:=clGray;

  TabStop:=True;
  Width:=220;
  Height:=35;

  FTrackTransparent := false;
  FTrackFillObject := TLMDFillObject.Create;
  FTrackFillObject.OnChange := GetChange;

  FFocusStyle := tbFocus;

  {get a global timer-id}
  FTimerId:=TLMDTimer.Create(LMDRepInit, TimerExpired, false);

  if csDesigning in ComponentState then CreateThumb;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.Init;
begin
  CreateThumb;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomTrackBar.Destroy;
begin
  FTrackFillObject.OnChange := nil;
  FreeAndNil(FTrackFillObject);
  FreeAndNil(FTimerId);
  FreeAndNil(FThumb);
  if Assigned (FBack) then
    FreeAndNil(FBack);
  if (FBuff <> nil) then
    FreeAndNil(FBuff);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.Assign (Source : TPersistent);
begin
  if source = self then exit;
  if source is TLMDCustomTrackBar then
    with Source as TLMDCustomTrackBar do
      begin
        self.FTrackFillObject.Assign (TrackFillObject);
        self.FTrackTransparent := TrackTransparent;
        self.FThumbStyle := ThumbStyle;
        self.FFocusColor := FocusColor;
        self.FFocusStyle := FocusStyle;
        self.FThumb.Assign (Thumb);
        self.FPageSize := PageSize;
        self.FTickLength := TickLength;
        self.FThumbColor := ThumbColor;
        self.FMin := MinValue;
        self.FMax := MaxValue;
        self.FPageSize := Pagesize;
        self.FTrackWidth := TrackWidth;
        self.FLineSize := LineSize;
        self.FOrientation := Orientation;
        self.FPosition := Position;
        self.FTickColor := TickColor;
        self.FTickMarks := TickMarks;
        self.FTickStyle := TickStyle;
        self.FTickLength := TickLength;
        self.TrackBorder := TrackBorder;
        self.FUseFocusColor := UseFocusColor;

        self.Transparent := Transparent;
        self.BackFX.Assign (BackFX);
        self.Cursor := Cursor;
        self.Enabled := Enabled;
        self.Font.Assign (Font);
        self.Color := Color;
        exit;
      end;
  inherited Assign (Source);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomTrackBar.PrepareBuff;
var
  lw, lh: integer;
begin
  lw := ClientRect.Right - ClientRect.Left;
  lh := ClientRect.Bottom - ClientRect.Top;
  if (FBuff <> nil) and ((FBuff.Width <> lw) or (FBuff.Height <> lh)) then
    FreeAndNil(FBuff);
  if FBuff = nil then
  begin
    FBuff := TBitmap.Create;
    FBuff.PixelFormat := pf24bit;
    FBuff.Width := lw;
    FBuff.Height := lh;
    FBuff.Canvas.CopyRect(Rect(0, 0, Width, Height), Canvas, ClientRect);
  end;
end;

end.
