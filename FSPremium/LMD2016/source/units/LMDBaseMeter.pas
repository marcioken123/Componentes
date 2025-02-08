unit LMDBaseMeter;
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

LMDBaseMeter unit ()
--------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Controls, Messages, Classes, Graphics,
  LMDGraphicControl, LMD3DCaption, LMDGraph, LMDTypes;

type
  {-------------------------- TLMDBaseMeter -----------------------------------}
  TLMDBaseMeter = class(TLMDGraphicControl)
  private
    F3DCaption:TLMD3DCaption;
    FAlignment: TAlignment;
    FDirection:TLMDMeterDirection;
    FMaxValue,
    FMinValue:LongInt;
    FPercentValue,
    FOldValue:TLMDPercent;
    FStep:TLMDPercent;
    FTextOptions:TLMDMeterTextOptions;
    FUseFontColor:Boolean;
    FUserValue:LongInt;
    FDelta:Byte;
    procedure Set3DCaption(aValue:TLMD3DCaption);
    procedure SetAlignment(aValue:TAlignment);
    Procedure SetDirection(aValue:TLMDMeterDirection);
    procedure SetMinValue(aValue:LongInt);
    procedure SetMaxValue(aValue:LongInt);
    procedure SetPercentValue(aValue:TLMDPercent);
    procedure SetTextOptions(aValue:TLMDMeterTextOptions);
    procedure SetUserValue(aValue:LongInt);
    procedure SetUseFontColor(aValue:Boolean);
    procedure Synchronize(aFlag:Boolean);
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    FUpdate: Boolean;

    procedure DoThemeChanged; override;
    function  CorrectBounds:Boolean;virtual;
    procedure SetDelta(aValue:Byte);
    procedure DrawBar(aCancas:TCanvas; dest, notDest, aRect:TRect);virtual;
    procedure DrawCaption(aCanvas:TCanvas; dest, notdest, aRect:TRect;
                          flag:Boolean; second:TColor);
    procedure Draw;
    function  GetDrawValue:TLMDPercent;virtual;
    function  GetPercentValue(aValue:LongInt):TLMDPercent;
    function  CheckOptimized: Boolean; override;
    procedure Paint;override;

    {properties}
    property Alignment:TAlignment read FAlignment write SetAlignment default taCenter;
    property Direction:TLMDMeterDirection read FDirection write SetDirection default mdHorizontal;
    property Delta:Byte read FDelta write SetDelta default 1;
    property MaxValue:LongInt read FMaxValue write SetMaxValue default 100;
    property MinValue:LongInt read FMinValue write SetMinValue default 0;
    property OptionsText:TLMDMeterTextOptions read FTextOptions write SetTextOptions default toNoText;
    property PercentValue:TLMDPercent read FPercentValue write SetPercentValue default 0;
    property Position:TLMDPercent read FPercentValue write SetPercentValue default 0;
    property Step:TLMDPercent read FStep write FStep default 10;
    property UserValue:LongInt read FUserValue write SetUserValue default 0;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Add(aValue:TLMDPercent);
    procedure StepAdd;
    procedure Sub(aValue:TLMDPercent);
    procedure StepSub;
    function GetExtend(aPercent:Byte; aExtend:Integer):integer;

    property Bevel;
    property Caption;
    property Font;
    property Font3D:TLMD3DCaption read F3DCaption write Set3DCaption;
    property UseFontColor:Boolean read FUseFontColor write SetUseFontColor default False;
  end;

implementation

uses
  SysUtils, Types, Themes,
  LMDClass, LMDProcs, LMDUtils, LMDGraphUtils, LMDThemes;

{************************ Class TLMDBaseMeter *********************************}
{---------------------------- Private -----------------------------------------}
procedure TLMDBaseMeter.Set3DCaption(aValue:TLMD3DCaption);
begin
  F3DCaption.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.SetAlignment(aValue: TAlignment);
begin
  if FAlignment <> aValue then
    begin
      FAlignment := aValue;
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.SetDirection(aValue:TLMDMeterDirection);
begin
  if FDirection<>aValue then
    begin
      FDirection:=aValue;
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.SetMaxValue(aValue: LongInt);
var
  bValue:Longint;
begin
  if (FMaxValue<>aValue) and (aValue<>FMinValue) then
    begin
      bValue:=MinValue;
      FMinValue:=LMDMin([aValue, bValue]);
      FMaxValue:=LMDMax([aValue, bValue]);
      if not ((FUserValue>=FMinValue) and (FUserValue<=FMaxValue)) then FUserValue:=FMaxValue;
      Synchronize(False);
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.SetMinValue(aValue: LongInt);
var
  bValue:Longint;
begin
  if (FMinValue<>aValue) and (aValue<>FMaxValue) then
    begin
      bValue:=FMaxValue;
      FMinValue:=LMDMin([aValue, bValue]);
      FMaxValue:=LMDMax([aValue, bValue]);
      if not ((FUserValue>=FMinValue) and (FUserValue<=FMaxValue)) then FUserValue:=FMinValue;
      Synchronize(False);
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.SetPercentValue(aValue: TLMDPercent);
begin
  if (FPercentValue<>aValue) then
    begin
      FPercentValue:=aValue;
      //4.0
      if FPercentValue>100 then FPercentValue:=100;
      if FPercentValue<0 then FPercentValue:=0;
      //---
      Synchronize(True);
      Draw;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.Synchronize(aFlag:Boolean);
begin
  {aFlag: True, if PercentValue Changed - False if UserValue changed}
  If aFlag then
    FUserValue:=FMinValue+Round(((FPercentValue*0.01)*(FMaxValue-FMinValue)))
  else
    FPercentValue:=GetPercentValue(FUserValue);
//  FOldValue:=0;
//  if FOldValue=FPercentValue then FOldValue:=100;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.SetTextOptions(aValue:TLMDMeterTextOptions);
begin
  if FTextOptions<>aValue then
    begin
      FTextOptions:=aValue;
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.SetUseFontColor(aValue: Boolean);
begin
  if FUseFontColor <> aValue then
    begin
      FUseFontColor := aValue;
      InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.SetUserValue(aValue: LongInt);
begin
  if (FUserValue<>aValue) then
    begin
      // 7.01 RM
      if (aValue<FMinValue) then aValue:=FMinValue;
      if (aValue>FMaxValue) then aValue:=FMaxValue;
      // -------
      FUserValue:=aValue;
      Synchronize(False);
      Draw;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDBaseMeter.CheckOptimized: Boolean;
begin
  Result := BackBitmapCheck;
end;

procedure TLMDBaseMeter.CMTextChanged(var Message: TMessage);
begin
  InvalidateControl;
end;

{----------------------------- Protected --------------------------------------}
function TLMDBaseMeter.CorrectBounds:Boolean;
begin
  result:=False;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseMeter.DoThemeChanged;
begin
  inherited;
  Invalidate;
end;

{------------------------------------------------------------------------------}
// 6.1 --> include drawing of border here
procedure TLMDBaseMeter.Draw;
var
  tmp:TBitmap;
  dest, notDest, FRect:TRect;
  tmpv:TLMDPercent;
  ah, aw: Integer;
  Details: TThemedProgress;
  lThemeMode : TLMDThemeMode;
  cntr: TRect;
begin
  if Painting then
    Exit;
  tmpv := GetDrawValue;

  if (Abs(tmpv-FOldValue)<FDelta) and not
     ((tmpv<>FOldValue) and (tmpv in [0, 100])) then exit;

  Painting := True;
  try
    tmp := TBitmap.Create;
    with tmp do
      try
        FRect := ClientRect;
        LMDBmpCreateFromRect(tmp, FRect, Self.Color);

        //XP - Progress Bar look
        //support added Jan 2002, JH
        lThemeMode := UseThemeMode;

        if (lThemeMode <> ttmNone) or (LMDApplication.UseXPThemes and (Bevel.Mode = bmWindows)) then
        begin
          if lThemeMode = ttmNone then lThemeMode := ttmPlatform; // bmWindows compatibility
          if Direction in [mdVertical, mdVerticalReverse] then
            Details := tpBarVert
          else
            Details := tpBar;
          LMDThemeServices.DrawElement(lThemeMode, Canvas.Handle, Details, FRect);

          cntr := LMDThemeServices.ContentRect(lThemeMode, Canvas.Handle,
            ThemeServices.GetElementDetails(Details), FRect);
          if not IsRectEmpty(cntr) then
            FRect := cntr
          else
            InflateRect(FRect, -1, -1); // Like in standard VCL method: TProgressBarStyleHook.PaintBar.
        end
        else //default behaviour
          FRect:=Bevel.PaintBevel(Canvas, FRect, false);

        //full:=FRect;
        ah:=FRect.Bottom-FRect.Top;
        aw:=FRect.Right-FRect.Left;
        case FDirection of
          mdHorizontal: dest:=Rect(FRect.Left,FRect.Top,FRect.Left+GetExtend(tmpv, aw), FRect.Bottom);
          mdHorizontalReverse:dest:=Rect(FRect.Right-GetExtend(tmpv, aw), FRect.Top, FRect.Right, FRect.Bottom);
          mdVertical:dest:=Rect(FRect.Left,FRect.Top,FRect.Right,FRect.Top+GetExtend(tmpv, ah));
          mdVerticalReverse:dest:=Rect(FRect.Left,FRect.Bottom-GetExtend(tmpv, ah), FRect.Right, FRect.Bottom);
        end;
        notDest:=FRect;

        case FDirection of
          mdHorizontal: notDest.Left:=Dest.Right;
          mdHorizontalReverse:notdest.Right:=Dest.Left;
          mdVertical:notDest.Top:=Dest.Bottom;
          mdVerticalReverse:notdest.Bottom:=Dest.Top;
        end;

        {Meter malen}
        DrawBar(tmp.Canvas, dest, notDest, FRect);

        {vollständige Bitmap übertragen}
        Self.Canvas.Draw(0, 0, tmp)
    finally
      tmp.Free;
    end;
  finally
    Painting:=False;
    FOldValue:=tmpv;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.DrawBar(aCancas:TCanvas; dest, notDest, aRect:TRect);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.DrawCaption(aCanvas:TCanvas; dest, notdest, aRect:TRect;
                                    flag:Boolean; second:TColor);
var
  tx: String;

const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);

begin
  if FTextOptions=toNoText then exit;
  with aCanvas do
    begin
      Font:=self.font;
      Brush.Color:=Color;
      brush.Style:=bsClear;
      if FTextOptions=toCaption then
        tx:=Caption
      else
        tx:=Format('%d%%', [GetDrawValue]);
      if FUseFontColor then
        begin
          LMDDrawTextExt(aCanvas, tx, F3DCaption, aRect,
                         DT_SINGLELINE or Alignments[FAlignment] or DT_VCENTER or DT_NOPREFIX,
                         [TLMDDrawTextStyle(Enabled)], nil);
        end
      else
        begin
          Font.Color:=Self.Color;
          LMDDrawTextExt(aCanvas, tx, F3DCaption, aRect,
                         DT_SINGLELINE or Alignments[FAlignment] or DT_VCENTER or DT_NOPREFIX,
                         [TLMDDrawTextStyle(Enabled), dtClip], @dest);
          if flag then Font.Color:=Second else Font.Color:=Self.Font.Color;
          LMDDrawTextExt(aCanvas, tx, F3DCaption, aRect,
                         DT_SINGLELINE or Alignments[FAlignment] or DT_VCENTER or DT_NOPREFIX,
                         [TLMDDrawTextStyle(Enabled), dtClip],  @notdest);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.Paint;
begin
  if (csLoading in ComponentState) then exit;
  BeginUpdate;
  try
    if CorrectBounds then exit;
    if FOldValue=0 then
      FOldValue:=100
    else
      FOldValue:=0;
    Draw;
  finally
    FUpdate:=False;
  end;
  EndUpdate(false);
end;

{------------------------------------------------------------------------------}
function TLMDBaseMeter.GetDrawValue:TLMDPercent;
begin
  result:=FPercentValue;
end;

{------------------------------------------------------------------------------}
function TLMDBaseMeter.GetPercentValue(aValue:LongInt):TLMDPercent;
var
  temp:Integer;
begin
  temp:=Round((aValue-FMinValue)/(FMaxValue-FMinValue)*100);
  if temp<0 then temp:=0;
  if temp>100 then temp:=100;
  result:=TLMDPercent(temp);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.SetDelta(aValue:Byte);
begin
  FDelta:=aValue;
  if (FDelta=0) then FDelta:=1;
end;

{----------------------------- Public -----------------------------------------}
constructor TLMDBaseMeter.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  DisableTransMode;
  ControlStyle:=ControlStyle-[csSetCaption]+[csReplicatable] + [csOpaque];
  FAlignment:=taCenter;
  Bevel.BeginUpdate;
  Bevel.StyleOuter:=bvLowered;
  Bevel.EndUpdate(false);

  FUpdate:=False;
  FOldValue:=0;
  FDelta:=1;
  F3DCaption:=TLMD3DCaption.Create;
  F3DCaption.OnChange:=GetChange;
  FDirection:=mdHorizontal;
  FUseFontColor:=False;

  FUserValue:=0;
  FMinValue:=0;
  FMaxValue:=100;
  FStep:=10;
  FPercentValue:=0;

  Width:=80;
  Height:=20;
end;

{------------------------------------------------------------------------------}
destructor TLMDBaseMeter.Destroy;
begin
  F3DCaption.OnChange:=nil;
  F3DCaption.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.Add(aValue:TLMDPercent);
begin
  if aValue=0 then exit;
  if FPercentValue+aValue<100 then inc(FPercentValue, aValue) else FPercentValue:=100;
  Draw;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.StepAdd;
begin
  Add(FStep);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.Sub(aValue:TLMDPercent);
begin
  if aValue=0 then exit;
  if FPercentValue-aValue>0 then Dec(FPercentValue, aValue) else FPercentValue:=100;
  Draw;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseMeter.StepSub;
begin
  Sub(FStep);
end;

{------------------------------------------------------------------------------}
function TLMDBaseMeter.GetExtend(aPercent:Byte; aExtend:Integer):Integer;
begin
  result:= Trunc((aPercent*0.01) * aExtend);
  if Result>aExtend then Result:=aExtend;
end;

end.
