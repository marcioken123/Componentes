unit LMDThemesSGExtThemeRenderer;
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

LMDThemesSGThemeRenderer unit (VB)
----------------------------------

Thi unit implements simple two-part gradient theme renderer and
contains reference to LMDThemesSGExtThemeRenderer singleton

Changes
-------
Release 10.0 (January 2009)
- Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, Windows,
  UxTheme, Themes, Graphics, TypInfo,
  LMDTypes, LMDClass,  LMDThemes, LMDGraph, LMDGradient, LMDThemesCommonTypes, LMDThemesSGThemeBase, LMDThemesSGThemeRenderer;

const
  ColorBrightnessPercent = 20;

type
  TLMDSimpleGradientExtThemeRenderer = class(TLMDBaseSGThemeRenderer)
  private
    FColorBrightnessPercent: integer;
    procedure SetColorBrightnessPercent(const Value: integer);
  protected
    procedure DrawFrame(aDC: HDC; R: TRect; aColor: TColor; aFrame: TLMDFrameSides);
    procedure DrawGradientFramedRect(DC: HDC; R: TRect; ClipRect: TLMDRectPtr; AStartFillColor, AEndFillColor, AFrameColor: TColor; AGradientStyle: TLMDGradientStyle; AFlags: Word; AFrame: TLMDFrameSides = [fsLeft, fsRight, fsTop, fsBottom]); override;
  public
    class function Controller: TLMDThemesControllerBase; override;
    class procedure Init; override;
    class function GetThemeRendererName: TLMDString; override;
    constructor Create; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTab; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTab; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedScrollBar; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedScrollBar; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTrackBar; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedTrackBar; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedToolBar; const R: TRect); overload; override;
    procedure DrawElement(DC: HDC; Detail: TThemedToolBar; const R: TRect; ClipRect: TLMDRectPtr); overload; override;
    property ColorBrightnessPercent: integer read FColorBrightnessPercent write SetColorBrightnessPercent default 20;
  end;

  TLMDSimpleGradientExtThemeController = class (TLMDThemesControllerBase)
  private
    FOnDrawCheckMark: TLMDThemesOnDrawCheckMarkEvent;
    FOnDrawRadioBtn: TLMDThemesOnDrawCheckMarkEvent;
    FOnDrawScrollThumbGripper: TLMDThemesOnDrawScrollThumbGripperEvent;
    FOnDrawArrow: TLMDThemesOnDrawArrowEvent;
    FOnDrawGradientArrow: TLMDThemesOnDrawGradientArrowEvent;
    FOnDrawPlus: TLMDThemesOnDrawSimpleSignEvent;
    FOnDrawMinus: TLMDThemesOnDrawSimpleSignEvent;
    FOnDrawCross: TLMDThemesOnDrawSimpleSignEvent;
    FColorBrightnessPercent: integer;    
    function GetColorBrightnessPercent: integer;
    procedure SetColorBrightnessPercent(const Value: integer);
  protected
    function GetThemeRenderer: TLMDThemeRenderer; override;
    procedure RegisterController; override;
    procedure UnregisterController; override;
    procedure Loaded; override;
  public
    constructor Create (aOwner: TComponent); override;
  published
    property OnDrawCheckMark: TLMDThemesOnDrawCheckMarkEvent read FOnDrawCheckMark write FOnDrawCheckMark;
    property OnDrawScrollThumbGripper: TLMDThemesOnDrawScrollThumbGripperEvent read FOnDrawScrollThumbGripper write FOnDrawScrollThumbGripper;
    property OnDrawArrow: TLMDThemesOnDrawArrowEvent read FOnDrawArrow write FOnDrawArrow;
    property OnDrawGradientArrow: TLMDThemesOnDrawGradientArrowEvent read FOnDrawGradientArrow write FOnDrawGradientArrow;
    property OnDrawPlus: TLMDThemesOnDrawSimpleSignEvent read FOnDrawPlus write FOnDrawPlus;
    property OnDrawMinus: TLMDThemesOnDrawSimpleSignEvent read FOnDrawMinus write FOnDrawMinus;
    property OnDrawCross: TLMDThemesOnDrawSimpleSignEvent read FOnDrawCross write FOnDrawCross;
    property ColorBrightnessPercent: integer read GetColorBrightnessPercent write SetColorBrightnessPercent default 20;
  end;


var
  LMDSGExtThemeRenderer: TLMDSimpleGradientExtThemeRenderer;
  LMDSGExtThemeController: TLMDSimpleGradientExtThemeController;

procedure RegisterRenderer;

implementation

uses
  LMDStrings, LMDXML, LMDThemesConst, LMDProcs, LMDGraphUtils;

{------------------------------------------------------------------------------}
procedure RegisterRenderer;
begin
  if LMDSGExtThemeRenderer = nil then
  begin
    LMDSGExtThemeRenderer := TLMDSimpleGradientExtThemeRenderer.Create;
    LMDThemeServices.RegisterThemeRenderer(LMDSGExtThemeRenderer);
  end;  
end;

{------------------- TLMDSimpleGradientExtThemeRenderer -----------------------}
procedure TLMDSimpleGradientExtThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTab; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;
{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTab; const R: TRect; ClipRect: TLMDRectPtr);
var
  lFs :TLMDFrameSides;
  LR: TRect;
begin
  lFs := AllFrameSides;
  case Detail of
    ttTopTabItemSelected,
    ttTopTabItemNormal,
    ttTopTabItemHot:
      lFs := lFs - [fsBottom];
  end;
  LR := R;
  if Detail in [ttTopTabItemNormal, ttTopTabItemHot] then
    LR.Right := LR.Right + 1;
  if Detail = ttTopTabItemSelected then
    LR.Bottom := LR.Bottom - 1;
  inherited DrawGradientFramedRect(DC, LR, ClipRect, TabColors[Detail, ciStart], TabColors[Detail, ciEnd], TabColors[ttTopTabItemLeftEdgeNormal, ciStart], GradientSettings[teTab].GradientStyle, DSF_CLIPRECT, lFs);
  if(Detail <> ttPane) then
    begin
      InflateRect(LR, -1, -1);
      inc(LR.Bottom);
      DrawFrame(DC, LR, LMDColorLighter(TabColors[Detail, ciStart], ColorBrightnessPercent), lFs);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedScrollBar; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedScrollBar; const R: TRect; ClipRect: TLMDRectPtr);
var
  lR: TRect;
  gs: TLMDGradientStyle;
  x, y, i, width, n: integer;
  lPen, lOldPen: HPEN;
begin
  if Detail in [tsArrowBtnUpNormal..tsArrowBtnDownDisabled, tsLowerTrackHorzNormal..tsUpperTrackHorzDisabled] then
    gs := gstVertical
  else
    if Detail in [tsArrowBtnLeftNormal..tsArrowBtnRightDisabled,tsLowerTrackVertNormal..tsUpperTrackVertDisabled] then
      gs := gstHorizontal
    else
      gs := GradientSettings[teScrollBar].GradientStyle;
  if not (Detail in [tsGripperHorzNormal, tsGripperHorzHot, tsGripperHorzPressed, tsGripperHorzDisabled,
    tsGripperVertNormal, tsGripperVertHot, tsGripperVertPressed, tsGripperVertDisabled]) then
    //any part except grip on the thumb button
    begin
      lR := R;
      InflateRect(lR, -1, -1);
      inherited DrawGradientFramedRect(DC, R, ClipRect, ScrollBarFillColors[Detail, ciStart], ScrollBarFillColors[Detail, ciEnd], ScrollBarFrameColors[Detail], gs, 0, AllFrameSides);
      DrawFrame(DC, LR, LMDColorLighter(ScrollBarFillColors[Detail, ciStart], ColorBrightnessPercent*2), AllFrameSides);
    end
  else
    //grip
    begin
      lPen := CreatePen(PS_SOLID, 1, ScrollBarFrameColors[Detail]);
      lOldPen := SelectObject(DC, lPen);
      width := 0;
      case Detail of
        tsGripperHorzNormal..tsGripperHorzDisabled:
          width := Abs(R.Right - R.Left);
        tsGripperVertNormal..tsGripperVertDisabled:
          width := Abs(R.Top - R.Bottom);
      end;
      n := trunc(width / 2);
      for i := 0 to n do
        case Detail of
          tsGripperHorzNormal..tsGripperHorzDisabled:
             begin
               x := R.Left + i * 2;
               MoveToEx(DC, x, R.Top, nil);
               LineTo(DC, x, R.Bottom);
             end;
          tsGripperVertNormal..tsGripperVertDisabled:
             begin
               y := R.Top + i * 2;
               MoveToEx(DC, R.Left, y, nil);
               LineTo(DC, R.Right, y);
             end;
        end;
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
    end;

  case Detail of
    tsArrowBtnUpNormal..tsArrowBtnUpDisabled:
      DrawArrow(DC, R, tdUp);
    tsArrowBtnDownNormal..tsArrowBtnDownDisabled:
      DrawArrow(DC, R, tdDown);
    tsArrowBtnLeftNormal..tsArrowBtnLeftDisabled:
      DrawArrow(DC, R, tdLeft);
    tsArrowBtnRightNormal..tsArrowBtnRightDisabled:
      DrawArrow(DC, R, tdRight);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTrackBar; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
constructor TLMDSimpleGradientExtThemeRenderer.Create;
begin
  inherited;
  FColorBrightnessPercent := 20;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedTrackBar; const R: TRect; ClipRect: TLMDRectPtr);
var
  gs: TLMDGradientStyle;
  lfs:  TLMDFrameSides;
  lEdge: integer;
  lPen, lOldPen: HPEN;
  lBrush, lOldBrush: HBRUSH;
  lRect, lR: TRect;
  lP: array[0..4] of TPoint;
  lColor: TColor;

  procedure BuildThumbFrame;
  begin
    if Detail in [ttbThumbBottomNormal..ttbThumbBottomDisabled] then
      begin
        lfs := lfs - [fsBottom];
        Dec(lRect.Bottom, ledge);
        lP[0] := Point(lRect.Left, lRect.Bottom);
        lP[1] := Point(lRect.Left + lEdge, lRect.Bottom + lEdge);
        lP[2] := Point(lRect.Right, lRect.Bottom);
        lP[3] := Point(lRect.Right, lRect.Top);
        lP[4] := Point(lRect.Left, lRect.Top);
      end;
    if Detail in [ttbThumbRightNormal..ttbThumbRightDisabled] then
      begin
        lfs := lfs - [fsRight];
        Dec(lRect.Right, ledge);
        lP[0] := Point(lRect.Right, lRect.Top);
        lP[1] := Point(lRect.Right + lEdge, lRect.Top + lEdge);
        lP[2] := Point(lRect.Right, lRect.Bottom);
        lP[3] := Point(lRect.Left, lRect.Bottom);
        lP[4] := Point(lRect.Left, lRect.Top);
      end;
    if Detail in [ttbThumbTopNormal..ttbThumbTopDisabled] then
      begin
        lfs := lfs - [fsTop];
        Inc(lRect.Top, ledge);
        lP[0] := Point(lRect.Left, lRect.Top);
        lP[1] := Point(lRect.Left + lEdge, lRect.Top - lEdge);
        lP[2] := Point(lRect.Right, lRect.Top);
        lP[3] := Point(lRect.Right, lRect.Bottom);
        lP[4] := Point(lRect.Left, lRect.Bottom);
      end;
    if Detail in [ttbThumbLeftNormal..ttbThumbLeftDisabled] then
      begin
        lfs := lfs - [fsLeft];
        Inc(lRect.Left, ledge);
        lP[0] := Point(lRect.Left, lRect.Bottom);
        lP[1] := Point(lRect.Left - lEdge, lRect.Bottom - lEdge);
        lP[2] := Point(lRect.Left, lRect.Top);
        lP[3] := Point(lRect.Right, lRect.Top);
        lP[4] := Point(lRect.Right, lRect.Bottom);
      end;
  end;

begin
  lRect := R;
  lEdge := 0;
  if Detail in [ttbThumbLeftNormal..ttbThumbRightDisabled] then
    begin
      InflateRect(lRect, -1, -1);
      if (lRect.Bottom - lRect.Top) mod 2 <> 0 then
        Dec(lRect.Bottom);
      ledge := (lRect.Bottom - lRect.Top) div 2;
    end;
  if Detail in [ttbThumbBottomNormal..ttbThumbTopDisabled] then
    begin
      InflateRect(lRect, -1, -1);
      if (lRect.Right - lRect.Left) mod 2 <> 0 then
        begin
          Inc(lRect.Right);
          OffsetRect(lRect, -1, 0);
        end;
      lEdge := (lRect.Right - lRect.Left) div 2;
    end;

  lfs := AllFrameSides;
  gs := gstVertical;

  if Detail in [ttbTrack,
                ttbThumbNormal..ttbThumbDisabled,
                //ttbThumbVertNormal..ttbThumbVertDisabled,
                ttbThumbLeftNormal..ttbThumbLeftDisabled,
                ttbThumbRightNormal..ttbThumbRightDisabled] then
    gs := gstHorizontal;

  lColor := TrackBarFillColors[Detail, ciEnd];
  if Detail in [ttbThumbLeftNormal..ttbThumbLeftDisabled, ttbThumbTopNormal..ttbThumbTopDisabled] then
    lColor := TrackBarFillColors[Detail, ciStart];

  if Detail in [ttbThumbBottomNormal..ttbThumbTopDisabled, ttbThumbLeftNormal..ttbThumbRightDisabled] then
    begin
      lr := lRect;
      lfs := AllFrameSides;
      BuildThumbFrame;
      lPen := CreatePen(PS_SOLID, 1, TrackBarFrameColors[Detail]);
      lOldPen := SelectObject(DC, lPen);
      Polygon(DC, lP, 5);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);

      lfs := AllFrameSides;
      lRect := lr;
      Dec(lEdge);
      InflateRect(lRect, -1, -1);
      BuildThumbFrame;
      lPen := CreatePen(PS_SOLID, 1, LMDColorLighter(TrackBarFillColors[Detail, ciStart], ColorBrightnessPercent));
      lOldPen := SelectObject(DC, lPen);
      lBrush := CreateSolidBrush(lColor);
      lOldBrush := SelectObject(DC, lBrush);
      Polygon(DC, lP, 5);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
      SelectObject(DC, lOldBrush);
      DeleteObject(lBrush);
      Inc(lRect.Left);
      Inc(lRect.Top);

      Inc(lRect.Left);
      Inc(lRect.Top);
      inherited DrawGradientFramedRect(DC, lRect, ClipRect, TrackBarFillColors[Detail, ciStart], TrackBarFillColors[Detail, ciEnd], TrackBarFrameColors[Detail], gs, 0, []);
    end
  else
    begin
      inherited DrawGradientFramedRect(DC, lRect, ClipRect, TrackBarFillColors[Detail, ciStart], TrackBarFillColors[Detail, ciEnd], TrackBarFrameColors[Detail], gs, 0, lfs);
      InflateRect(lRect, -1, -1);
      if gs = gstHorizontal then
        lColor := LMDColorLighter(TrackBarFillColors[Detail, ciStart], ColorBrightnessPercent)
      else
        lColor := LMDColorLighter(TrackBarFillColors[Detail, ciEnd], ColorBrightnessPercent);
      DrawFrame(DC, lRect, lColor, AllFrameSides);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeRenderer.DrawFrame(aDC: HDC; R: TRect; aColor: TColor; aFrame: TLMDFrameSides);
var
  lPen, lOldPen: HPEN;
begin
  lPen := CreatePen(PS_SOLID, 1, aColor);
  lOldPen := SelectObject(aDC, lPen);
  if fsLeft in AFrame then
    begin
      MoveToEx(aDC, R.Left, R.Top, nil);
      LineTo(aDC, R.Left, R.Bottom);
    end;
  if fsTop in AFrame then
    begin
      MoveToEx(aDC, R.Left, R.Top, nil);
      LineTo(aDC, R.Right - 1, R.Top);
    end;
  if fsRight in AFrame then
    begin
      MoveToEx(aDC, R.Right - 1, R.Top, nil);
      LineTo(aDC, R.Right - 1, R.Bottom);
    end;
  if fsBottom in AFrame then
    begin
      MoveToEx(aDC, R.Left, R.Bottom - 1, nil);
      LineTo(aDC, R.Right, R.Bottom - 1);
    end;
  SelectObject(aDC, lOldPen);
  DeleteObject(lPen);
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeRenderer.DrawGradientFramedRect(
  DC: HDC; R: TRect; ClipRect: TLMDRectPtr; AStartFillColor, AEndFillColor, AFrameColor: TColor;
  AGradientStyle: TLMDGradientStyle; AFlags: Word; AFrame: TLMDFrameSides);
var
  lw, lh, gbase, cc: integer;
  lBrush: HBRUSH;
  R1, R2: TRect;
  lCr: TRect;
  lOldClpRgn, lRgn: HRGN;
begin
  lw := R.Right - R.Left + 1;
  lh := R.Bottom - R.Top + 1;

  lCr := R;
  lRgn := 0;
  lOldClpRgn := 0;
  if ClipRect <>  LMDNullRectPtr then
    begin
      lCr := ClipRect^;
      lRgn := CreateRectRgn(lCr.Left, lCr.Top, lCr.Right, lCr.Bottom);
      lOldClpRgn := SelectClipRgn(DC, lRGn);
    end;

  if (AStartFillColor = AEndFillColor) and
    (AStartFillColor <> clNone) then
    begin
      lBrush := CreateSolidBrush(AStartFillColor);
      R1 := R;
      InflateRect(R1, -1, -1);
      FillRect(DC, R1, lBrush);
      DeleteObject(lBrush);
    end
  else
    if not ((AStartFillColor = clNone) and
            (AEndFillColor = clNone)) then
       begin
         R1 := R;
         R2 := R;
         case AGradientStyle of
           gstVertical:
             begin
               gbase := lh;
               R1.Bottom := (R1.Bottom + R1.Top) div 2;
               R2.Top := (R2.Bottom + R2.Top) div 2;
             end;
           gstHorizontal:
             begin
               gbase := lw;
               R1.Right := (R1.Left + R1.Right) div 2;
               R2.Right := (R2.Left + R2.Right) div 2;
             end
           else
             begin
               gbase := (lw + lh) div 2;
               R1.Bottom := (R1.Bottom + R1.Top) div 2;
               R2.Top := (R2.Bottom + R2.Top) div 2;
             end;
          end;
         if GradientSettings[teButton].CountType = gccCalculated then
           cc := gbase div GradientSettings[teButton].CalcDivizor
         else
           cc := GradientSettings[teButton].FixedNumber;
         LMDGradientPaint(DC, R1, LMDColorLighter(AStartFillColor, ColorBrightnessPercent), LMDColorLighter(AStartFillColor, 100-ColorBrightnessPercent), cc, aGradientStyle, AFlags, 0);
         LMDGradientPaint(DC, R2, AEndFillColor, AStartFillColor, cc, aGradientStyle, AFlags, 0);
       end;
  if (AFrameColor <> clNone) then
    begin
      R1 := R;
      InflateRect(R1, -1, -1);
      DrawFrame(DC, R1, LMDColorLighter(AStartFillColor, ColorBrightnessPercent), aFrame);
      DrawFrame(DC, R, aFrameColor, aFrame);
    end;

  if ClipRect <>  LMDNullRectPtr then
    begin
      SelectClipRgn(DC, lOldClpRgn);
      DeleteObject(lRgn);
    end;
end;

{------------------------------------------------------------------------------}
class function TLMDSimpleGradientExtThemeRenderer.GetThemeRendererName: TLMDString;
begin
  result := 'LMD Extended Simple Gradient Themes Renderer';
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeRenderer.SetColorBrightnessPercent(
  const Value: integer);
begin
  if ColorBrightnessPercent <> Value then
    begin
      FColorBrightnessPercent := Value;
      DoUpdateTheme;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedToolBar; const R: TRect);
begin
  DrawElement(DC, Detail, R, nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeRenderer.DrawElement(DC: HDC;
  Detail: TThemedToolBar; const R: TRect; ClipRect: TLMDRectPtr);
var
  lR: TRect;
  lFs: TLMDFrameSides;
  lPen, lOldPen: HPEN;
begin
  lR := R;
  lFs := AllFrameSides;
  if Detail in [ttbDropDownButtonHot..ttbDropDownButtonCheckedHot] then
    lFs := lFs - [fsLeft];
  if Detail in [ttbSplitButtonNormal..ttbSplitButtonCheckedHot] then
    begin
      lFs  := lFs - [fsRight];
      lR.Right := lR.Right + 1;
    end;
  if Detail in [ttbSplitButtonDropDownNormal..ttbSplitButtonDropDownCheckedHot] then
    lFs  := lFs - [fsLeft];

  if Detail in  [ttbSeparatorNormal..ttbSeparatorCheckedHot] then
    begin
      lPen := CreatePen(PS_SOLID, 1, ToolbarFillColors[Detail, ciEnd]);
      lOldPen := SelectObject(DC, lPen);
      MoveToEx(DC, lR.Left, lR.Top, nil);
      LineTo(DC, lR.Left, lR.Bottom);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
      lPen := CreatePen(PS_SOLID, 1, ToolbarFillColors[Detail, ciStart]);
      lOldPen := SelectObject(DC, lPen);
      MoveToEx(DC, lR.Left + 1, lR.Top, nil);
      LineTo(DC, lR.Left + 1, lR.Bottom);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
    end
  else
  if Detail in  [ttbSeparatorVertNormal..ttbSeparatorVertCheckedHot] then
    begin
      lPen := CreatePen(PS_SOLID, 1, ToolbarFillColors[Detail, ciEnd]);
      lOldPen := SelectObject(DC, lPen);
      MoveToEx(DC, lR.Left, lR.Top, nil);
      LineTo(DC, lR.Right, lR.Top);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
      lPen := CreatePen(PS_SOLID, 1, ToolbarFillColors[Detail, ciStart]);
      lOldPen := SelectObject(DC, lPen);
      MoveToEx(DC, lR.Left, lR.Top + 1, nil);
      LineTo(DC, lR.Right, lR.Top + 1);
      SelectObject(DC, lOldPen);
      DeleteObject(lPen);
    end
  else
    begin
      if Detail in  [ttbToolBarDontCare,ttbToolBarRoot] then
        inherited DrawGradientFramedRect(DC, lR, ClipRect, ToolbarFillColors[Detail, ciStart], ToolbarFillColors[Detail, ciEnd], ToolbarFrameColors[Detail], GradientSettings[teToolBar].GradientStyle, DSF_CLIPRECT, lFs)
      else
        DrawGradientFramedRect(DC, lR, ClipRect, ToolbarFillColors[Detail, ciStart], ToolbarFillColors[Detail, ciEnd], ToolbarFrameColors[Detail], GradientSettings[teToolBar].GradientStyle, DSF_CLIPRECT, lFs);
    end;
  if Detail in [ttbDropDownButtonNormal..ttbDropDownButtonDisabled] then
    DrawArrow(DC, lR, tdDown);
  if Detail in [ttbSplitButtonDropDownNormal..ttbSplitButtonDropDownCheckedHot] then
    DrawArrow(DC, lR, tdDown);
end;

{------------------ TLMDSimpleGradientExtThemeController ----------------------}
constructor TLMDSimpleGradientExtThemeController.Create(
  aOwner: TComponent);
begin
  if Assigned(LMDSGExtThemeController) then
    raise Exception.Create('An instance of ' + ClassName +' already exists (owner: ' + LMDSGExtThemeController.Owner.Name +')');
  inherited;
  if not Assigned(LMDSGExtThemeRenderer) and not (csDesigning in ComponentState) then
    TLMDSimpleGradientExtThemeRenderer.Init;
  FColorBrightnessPercent := 20;
end;

{------------------------------------------------------------------------------}
function TLMDSimpleGradientExtThemeController.GetColorBrightnessPercent: integer;
begin
  result := FColorBrightnessPercent;
end;

{------------------------------------------------------------------------------}
function TLMDSimpleGradientExtThemeController.GetThemeRenderer: TLMDThemeRenderer;
begin
  result := LMDSGExtThemeRenderer;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeController.Loaded;
begin
  inherited;
  if GetThemeRenderer <> nil then
    with TLMDSimpleGradientExtThemeRenderer(GetThemeRenderer) do
    begin
      OnDrawCheckMark := FOnDrawCheckMark;
      OnDrawRadioBtn := FOnDrawRadioBtn;
      OnDrawScrollThumbGripper := FOnDrawScrollThumbGripper;
      OnDrawArrow := FOnDrawArrow;
      OnDrawGradientArrow := FOnDrawGradientArrow;
      OnDrawPlus := FOnDrawPlus;
      OnDrawMinus := FOnDrawMinus;
      OnDrawCross := FOnDrawCross;
      ColorBrightnessPercent := FColorBrightnessPercent;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeController.SetColorBrightnessPercent(
  const Value: integer);
begin
  if (FColorBrightnessPercent <> Value) then
  begin
    FColorBrightnessPercent := Value;
    if GetThemeRenderer <> nil then
      TLMDSimpleGradientExtThemeRenderer(GetThemeRenderer).ColorBrightnessPercent := Value;
  end;
end;

{------------------------------------------------------------------------------}
class procedure TLMDSimpleGradientExtThemeRenderer.Init;
begin
  RegisterRenderer;
end;

{------------------------------------------------------------------------------}
class function TLMDSimpleGradientExtThemeRenderer.Controller: TLMDThemesControllerBase;
begin
  result := LMDSGExtThemeController;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeController.RegisterController;
begin
  LMDSGExtThemeController := Self;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientExtThemeController.UnregisterController;
begin
  LMDSGExtThemeController := nil;
end;

initialization

  LMDSGExtThemeRenderer := nil;
  LMDSGExtThemeController := nil;

finalization

  if LMDSGExtThemeRenderer <> nil then
    FreeAndNil(LMDSGExtThemeRenderer);

end.
