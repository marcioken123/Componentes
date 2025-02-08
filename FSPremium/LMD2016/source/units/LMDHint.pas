unit LMDHint;
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

LMDHint unit (RM)
-----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Windows, Graphics, LMDCustomHint, LMDCustomShapeHint,
  LMDShapeHint;

type
  { ******************************** TLMDHint *********************************}

  TLMDHint = class(TLMDCustomShapeHint)
  private
    FBackgroundedBevel: Boolean;
    procedure SetBackgroundedBevel(const Value: boolean);
  protected
    function GetHintClass: THintWindowClass; override;
  public
    constructor Create(AOwner:TComponent); override;
  published
    property About;
    property Bevel;
    property Color;
    property DefaultTitle;
    property DefaultIcon;
    property Enabled;
    property Font3D;
    property Gradient;
    property IsBalloon default false;
    property HideAccelChar;
    property Options;
    property ThemeMode;
    property ThemeGlobalMode;
    property TitleFont;
    property TitleFont3D;
    property BackgroundedBevel: boolean read FBackgroundedBevel write SetBackgroundedBevel default true;
    property UseGradient;
  end;

  { *************************** TLMDHintWindow*********************************}

  TLMDHintWindow = class(TLMDShapeHintWindow)
  protected
    procedure AdjustTextRect(var aRect: TRect; aShowIcon,
                             aShowCloseBtn: boolean); override;
    procedure Draw(ACanvas: TCanvas; AHintPosition: TLMDHintPosition;
                   var TxRect: TRect; Pos: TPoint); override;
    procedure AdjustHintRect(var aRect: TRect); override;
  public
    function  HintControl: TLMDHint;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
  end;

implementation

uses
  SysUtils, Forms, LMDGraph, LMDGraphUtils, LMDSysIn;

{ ******************************** TLMDHint ***********************************}
{--------------------------------- Protected ----------------------------------}
procedure TLMDHint.SetBackgroundedBevel(const Value: boolean);
begin
  if FBackgroundedBevel <> Value then
    FBackgroundedBevel := Value;
end;

{--------------------------- Public -------------------------------------------}
Constructor TLMDHint.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  UseSystemShadow := true;
  IsBalloon := false;
  Options := Options + [hoRightAngledNose];
  BackGroundedBevel := true;
end;

{------------------------------------------------------------------------------}
function TLMDHint.GetHintClass: THintWindowClass;
begin
  Result := TLMDHintWindow;
end;

{ ****************************** TLMDHintWindow ****************************** }
procedure TLMDHintWindow.Draw(ACanvas: TCanvas;
  AHintPosition: TLMDHintPosition; var TxRect: TRect; Pos: TPoint);
var
  LWidth: integer;
  lUseGrad, lDrawCb, lDrawIcon: boolean;
  lHrzDelta: integer;
  lOpt: TLMDHintOptions;
begin
  if HintControl = nil then
    Exit;
  Color := HintControl.Color;
  if HintControl.IsBalloon then
    inherited
  else
  begin
    lOpt := HintControl.Options;
    lUseGrad := HintControl.UseGradient;
    lDrawCb := (hoShowCloseButton in lOpt);
    lDrawIcon := (hoShowIcon in lOpt);

    if IsHTML then
      LWidth := HintControl.Bevel.BevelExtend
    else
      LWidth := HintControl.Bevel.BevelExtend - 2;

    lHrzDelta := 0;
    if lDrawCb then
      inc(lHrzDelta, FCloseBtnSize.cx);
    if lDrawIcon then
      inc(lHrzDelta, Icon.Width);
    if lHrzDelta <> 0 then
      inc(lHrzDelta, 4);

    SetWindowPos(Handle, HWND_TOPMOST, pos.X + LWidth, pos.Y - LWidth*2,
                 TxRect.Right - TxRect.Left + LWidth*2 + 1 + lHrzDelta,
                 TxRect.Bottom - TxRect.Top + LWidth*2,  SWP_SHOWWINDOW or
                 SWP_NOACTIVATE);

    if (LMDSIWindowsXPUp and HintControl.IsThemed) or lUseGrad then
      PaintBgr(aCanvas, ClientRect)
    else
    begin
      aCanvas.Brush.Style := bsSolid;
      aCanvas.Brush.Color := HintControl.Color;
      aCanvas.FillRect(ClientRect);
    end;

    with HintControl do
      TxRect := Bevel.PaintBevel(aCanvas, ClientRect, BackgroundedBevel);

    if lDrawIcon then
    begin
      OffsetRect(TxRect, Icon.Width + 1, 0);
      Dec(TxRect.Right, Icon.Width);
    end;

    if lDrawCb then
      Dec(TxRect.Right, FCloseBtnSize.cx );
  end;
end;

function TLMDHintWindow.HintControl: TLMDHint;
begin
  Result := (inherited HintControl) as TLMDHint;
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.AdjustHintRect(var aRect: TRect);
begin
  if (HintControl <> nil) and HintControl.IsBalloon then
    inherited; // Otherwise we have to skip inherited AdjustHintRect.
end;

{------------------------------------------------------------------------------}
procedure TLMDHintWindow.AdjustTextRect(var aRect: TRect; aShowIcon,
  aShowCloseBtn: boolean);
begin
  if HintControl <> nil then
    if HintControl.IsBalloon then
      inherited;
end;

procedure TLMDHintWindow.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (HintControl <> nil) and HintControl.IsBalloon then
    inherited;
end;

end.
