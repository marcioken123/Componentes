unit LMDCustomProgress;
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

LMDCustomProgress unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Graphics, Classes, Windows,
  LMDGraph, LMDSmallBar, LMDBaseMeter;

type
  TLMDProgressStyle=(pgBar, pgSmallBar, pgSmallBarColor, pgOwnerDraw, pgXPBar);
  TLMDProgressPaintEvent=procedure(Sender:TObject; aCanvas:TCanvas; dest, notDest, aRect:TRect) of object;
  TLMDProgressColorEvent=procedure(Sender:TObject; nr:Byte; var aColor:TColor) of object;

  {-------------------------- TLMDProgress ------------------------------------}
  TLMDCustomProgress = class(TLMDBaseMeter)
  private
    FBarColor:TColor;
    FBar3D:TLMDBorderStyle;
    FSmBar:TLMDSmallBar;
    FStyle:TLMDProgressStyle;
    FOnPaint:TLMDProgressPaintEvent;
    FOnColor:TLMDProgressColorEvent;
    procedure SetBarColor(aColor:TColor);
    procedure SetBar3D(aValue:TLMDBorderStyle);
    procedure SetSmBarOptions(aValue:TLMDSmallBar);
    procedure SetStyle(aValue:TLMDProgressStyle);
  protected
    function  CorrectBounds: Boolean;override;
    procedure Loaded; override;
    procedure DrawBar(aCanvas:TCanvas; dest, notDest, aRect:TRect);override;
    procedure GetChange(Sender:TObject);override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property   CtlXP;  // compatibility
  published
    property About;
    property Align;
    property Alignment;
    property BarColor:TColor read FBarColor write SetBarColor default clNavy;
    property Bar3D:TLMDBorderStyle read FBar3D write SetBar3D default lsNone;
    property Bevel;
    property Delta;
    property Color;
    property Caption;
    property Direction;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Font3D;
    property MaxValue;
    property MinValue;
    property OptionsText;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property SmallBar:TLMDSmallBar read FSmBar write SetSmBarOptions;
    property Style:TLMDProgressStyle read FStyle write SetStyle default pgSmallBar;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
    property UseFontColor;
    property Visible;

    {Events}
    property OnGetColor:TLMDProgressColorEvent read FOnColor write FOnColor;
    property OnPaint:TLMDProgressPaintEvent read FOnPaint write FOnPaint;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {3.0}
    property OnMouseEnter;
    property OnMouseExit;
    {---}
    property OnStartDrag;

    {4.0}
    //properties
    property Anchors;

    property BiDiMode;

    property DragKind;
    property Constraints;

    property ParentBiDiMode;
    //events
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
   {$ENDIF}
  end;

implementation

uses
  Types, Controls, Themes,
  LMDThemes, LMDClass, LMDUtils, LMDGraphUtils;

{************************ Class TLMDCustomProgress ****************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDCustomProgress.SetBarColor(aColor: TColor);
begin
  if FBarColor<>aColor then
    begin
      FBarColor:=aColor;
      if FStyle=pgBar then InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomProgress.SetBar3D(aValue: TLMDBorderStyle);
begin
  if FBar3D<>aValue then
    begin
      FBar3D:=aValue;
      if FStyle=pgBar then InvalidateControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomProgress.SetSmBarOptions(aValue: TLMDSmallBar);
begin
  FSmBar.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomProgress.SetStyle(aValue: TLMDProgressStyle);
begin
  if FStyle<>aValue then
    begin
      FStyle:=aValue;
      if not (csLoading in ComponentState) then
        Case FStyle of
          pgSmallBar, pgSmallBarColor:
            SetDelta((100 Div FSmBar.BarCount) Div 2)
        end;
      InvalidateControl;
    end;
end;

{-------------------------------- Protected -----------------------------------}
function TLMDCustomProgress.CorrectBounds:Boolean;
var
  smW:Integer;
begin

  result:=false;
  if FUpdate or IsUpdating then exit;
  if (FStyle in [pgSmallBar, pgSmallBarColor]) and (Align=alNone) and FSmBar.AutoSize then
    with FSmBar do
      case Direction of
        mdHorizontal, mdHorizontalReverse:
          begin
            smw:=BarCount*(HSpace+GetBarExtend(Direction, Width-DblBevelExt, Height-DblBevelExt))
                 +HSpace+DblBevelExt;
            if width<>smw then
              begin
                Width:=smw;
                result:=true;
              end;
          end;
        mdVertical, mdVerticalReverse:
           begin
              smw:=BarCount*(HSpace+GetBarExtend(Direction, Width-DblBevelExt, Height-DblBevelExt))
                   +VSpace+DblBevelExt;
              if Height<>smw then
                begin
                  Height:=smw;
                  result:=true;
                end;
          end;
      end;
  FUpdate:=Result;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomProgress.DrawBar(aCanvas:TCanvas; dest, notDest, aRect:TRect);
var
  flags:Word;
  tmp:TColor;
  smw, i:Integer;
  FTempStyle: TLMDProgressStyle;
  lThemeMode: TLMDThemeMode;
  dtls: TThemedElementDetails;
begin
  //JH, added Jan 2002
  //handles XP style bar, if non XP choose small bar as default, otherwise
  //proceed as before
  FTempStyle := FStyle;

  lThemeMode := UseThemeMode;
  if IsThemed then
    FTempStyle := pgXPBar
  else if (FTempStyle = pgXPBar) and (not LMDApplication.UseXPThemes) then
    FTempStyle := pgSmallBar;

  with aCanvas do
    case FTempStyle of
      pgBar:
      begin
        Brush.Style:=bsSolid;
        Brush.Color:=FBarColor;
        FillRect(dest);
        if Position>0 then LMDDrawStdFrame(aCanvas, dest, FBar3D, 0);
        DrawCaption(aCanvas, dest, notDest, aRect, True, FBarColor);
      end;
      pgOwnerDraw:
        if Assigned(FOnPaint) then
          FOnPaint(self, aCanvas, dest, notDest, aRect);
      pgSmallbar, pgSmallBarColor:
        with FSmBar, aRect do
        begin
          smw := FSmBar.GetBarExtend(Direction, Right-Left, Bottom-Top);

          {todraw...}
          flags:=Word(Round((GetDrawValue*0.01)*BarCount));
          Brush.Style:=bsSolid;
          Brush.Color:=BarColor;
          if smw=0 then
            with dest do FillRect(Rect(Left+HSpace, Top+VSpace, Right-HSpace, Bottom-VSpace))
          else
            for i:=0 to Pred(flags) do
            begin
              if (FStyle=pgSmallBarColor) and Assigned(FonColor) then
              begin
                tmp:=BarColor;
                FOnColor(Self, i, Tmp);
                Brush.Color:=tmp;
              end;

              case Direction of
                mdHorizontal       :FillRect(Rect(aRect.Left+i*(smW+HSpace)+HSpace, dest.Top+VSpace, aRect.Left+(i+1)*(smW+HSpace), Bottom-VSpace));
                mdHorizontalReverse:FillRect(Rect(aRect.Left+((Barcount-i-1)*(smW+HSpace))+HSpace, dest.Top+VSpace,
                                                  aRect.Left+((BarCount-i)*(smW+HSpace)), Bottom-VSpace));
                mdVertical         :FillRect(Rect(aRect.Left+HSpace, aRect.Top+i*(smW+VSpace)+VSpace, Right-HSpace,aRect.Top+((i+1)* (smW+VSpace))));
                mdVerticalReverse  :FillRect(Rect(aRect.Left+HSpace, aRect.Top+(BarCount-i-1)*(smW+VSpace)+VSpace,Right-HSpace,
                                                 aRect.Top+((Barcount-i)*(smW+VSpace))));
              end;
            end;
          DrawCaption(aCanvas, dest, notDest, aRect, True, FSmBar.BarColor);
        end;
      pgXPBar: //JH, added Jan 2002
        with FSmBar, aRect do
        begin
          case Direction of
            mdHorizontal,
            mdHorizontalReverse:
              dtls := LMDThemeServices.GetDetails(teProgress, Ord(tpChunk));
            mdVertical,
            mdVerticalReverse:
              dtls := LMDThemeServices.GetDetails(teProgress, Ord(tpChunkVert));
          end;
          LMDThemeServices.DrawElement(lThemeMode, Handle, dtls, dest);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomProgress.GetChange(Sender:TObject);
begin
  {if Sender=FSmBar then
    begin
      SetDelta(1);
      Case FStyle of
        pgSmallBar, pgSmallBarColor:
        if OptionsText<>toPercent then SetDelta((100 Div FSmBar.BarCount) Div 2);
      end;
    end;}
  inherited GetChange(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomProgress.Loaded;
begin
  inherited;
  //CreateXPThemeHandles;
end;

{************************ Public Routines *************************************}
{------------------------------------------------------------------------------}
constructor TLMDCustomProgress.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FSmBar:=TLMDSmallBar.Create;
  FSmBar.OnChange:=GetChange;

  FBarColor:=clNavy;
  FBar3D:=lsNone;
  FStyle:=pgSmallBar;
  Transparent := True;
  SetDelta(1);
end;

{------------------------------------------------------------------------------}
Destructor TLMDCustomProgress.Destroy;
begin
  FSmBar.OnChange:=nil;
  FSmBar.Free;
  inherited Destroy;
end;

end.
