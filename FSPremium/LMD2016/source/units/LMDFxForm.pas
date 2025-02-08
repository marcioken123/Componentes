unit LMDFxForm;
{$I LMDCmps.inc}

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

LMDFxForm unit (RM, AH)
----------------------

Note
----
LMD FxPack is based on code licensed from Eugene Kryukov

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Graphics, Controls, Forms, Classes, SysUtils,
  LMDFxBitmap, LMDFxEffect, LMDFxAnimation, LMDFxUtils, LMDFxImagelist,
  LMDFxBase;

const

  CM_FINISHANIMATION = CM_BASE + 432;

type

  { ************************ class TLMDFxAnimationForm *********************** }
  TLMDFxAnimationForm = class(TLMDFxComponent)
  private
    FMask: TPicture;
    FMaskColor: TColor;
    FMaskMode: TLMDFxMaskMode;
    FShowAnimation: TLMDFxAnimation;
    FShowAnimationComplete: boolean;
    FDesktopImage: TLMDFxBitmap;
    FRegion: HRgn;
    FCopyRegion: HRgn;
    FPrevWndProc: TWndMethod;
    procedure FormWndProc(var Msg: TMessage);
    procedure SetMask(const Value: TPicture);
    procedure SetShowAnimation(const Value: TLMDFxAnimation);
  protected
    procedure AdjustSizeByMask;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PrepareShowAnimation;
    procedure FinishShowAnimation;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Region: HRgn read FCopyRegion;
  published
    property Mask: TPicture read FMask write SetMask;
    property MaskColor: TColor read FMaskColor write FMaskColor;
    property MaskMode: TLMDFxMaskMode read FMaskMode write FMaskMode;
    property ShowAnimation: TLMDFxAnimation read FShowAnimation write SetShowAnimation;
  end;

function FindAnimationForm(AForm: TCustomForm): TLMDFxAnimationForm;

implementation
uses
  LMDFxGrab;

type
  THackForm = class(TCustomForm);

{ ---------------------------------------------------------------------------- }
function FindAnimationForm(AForm: TCustomForm): TLMDFxAnimationForm;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to THackForm(AForm).ComponentCount - 1 do
    if THackForm(AForm).Components[i] is TLMDFxAnimationForm then
    begin
      Result := TLMDFxAnimationForm(THackForm(AForm).Components[i]);
      Exit;
    end;
  end;

{ ************************ class TLMDFxAnimationForm ************************* }
{ ------------------------------ private ------------------------------------- }
procedure TLMDFxAnimationForm.SetMask(const Value: TPicture);
begin
  FMask.Assign(Value);
  AdjustSizeByMask;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxAnimationForm.SetShowAnimation(const Value: TLMDFxAnimation);
begin
  FShowAnimation := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxAnimationForm.FormWndProc(var Msg: TMessage);

begin
  { Prior }
  case Msg.Msg of
    WM_WINDOWPOSCHANGING:
      begin
        with TWMWindowPosChanging(Msg) do
        begin
          if WindowPos^.Flags and SWP_SHOWWINDOW <> 0 then
          begin
            { Start Animation }
            FRegion := CreateRegionFromPicture(FMask, TCustomForm(Owner).Width, TCustomForm(Owner).Height, FMaskColor, FMaskMode);
            if FRegion <> 0 then
            begin
              FCopyRegion := CreateRectRgn(0, 0, TCustomForm(Owner).Width, TCustomForm(Owner).Height);
              CombineRgn(FCopyRegion, FCopyRegion, FRegion, RGN_AND);
              SetWindowRgn(TCustomForm(Owner).Handle, FRegion, true);
            end;
            PrepareShowAnimation;
          end;
        end;
      end;
  end;
  FPrevWndProc(Msg);
  { Post }
  case Msg.Msg of
    WM_WINDOWPOSCHANGED:
      begin
        with TWMWindowPosChanging(Msg) do
        if WindowPos^.Flags and SWP_SHOWWINDOW <> 0 then
          { Start Animation }
            PostMessage(TCustomForm(Owner).Handle, CM_FINISHANIMATION, 0, 0);
      end;
    CM_FINISHANIMATION:
      begin
        { Finish Animation }
        FinishShowAnimation;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxAnimationForm.Loaded;
begin
  inherited Loaded;
  AdjustSizeByMask;
  if not (csDesigning in ComponentState) and (Owner is TCustomForm) then
  begin
    { Make region }
//    FRegion := CreateRegionFromPicture(FMask, TCustomForm(Owner).Width, TCustomForm(Owner).Height, FMaskColor, FMaskMode);
//    if FRegion <> 0 then
//    begin
//      FCopyRegion := CreateRectRgn(0, 0, TCustomForm(Owner).Width, TCustomForm(Owner).Height);
//      CombineRgn(FCopyRegion, FCopyRegion, FRegion, RGN_AND);
//      SetWindowRgn(TCustomForm(Owner).Handle, FRegion, true);
//    end;
    { Hack form }
    FPrevWndProc := TCustomForm(Owner).WindowProc;
    TCustomForm(Owner).WindowProc := FormWndProc;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxAnimationForm.AdjustSizeByMask;
var
  R: TRect;
begin
  if (FMask.Width <> 0) and (FMask.Height <> 0) then
  begin
    R := GetRealBoundsRect(TControl(Owner));

    TControl(Owner).Width := FMask.Width - (RectWidth(R) - TControl(Owner).Width);
    TControl(Owner).Height := FMask.Height - (RectHeight(R) - TControl(Owner).Height);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxAnimationForm.FinishShowAnimation;
begin
  if FShowAnimation = nil then Exit;
  if FShowAnimationComplete then Exit;
  if FShowAnimation.IsControlFrozen(TControl(Owner)) then
  begin
    FShowAnimation.Execute;
    FShowAnimation.Restore;
  end;
//  FShowAnimationComplete := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxAnimationForm.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FShowAnimation) then
    FShowAnimation := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxAnimationForm.PrepareShowAnimation;
var
  R: TRect;
begin
  if FShowAnimation = nil then Exit;
  if FShowAnimationComplete then Exit;
  if FShowAnimation.IsControlFrozen(TControl(Owner)) then Exit;
  R := GetRealBoundsRect(TControl(Owner));
  FDesktopImage := LMDFxGrabDesktopToKeBitmap(R);
  OffsetRect(R, -R.Left, -R.Top);
  FShowAnimation.FreezeControl(TControl(Owner), R, FDesktopImage);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxAnimationForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMask := TPicture.Create;
  FMaskColor := clBlack;
  FMaskMode := mmExclude;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFxAnimationForm.Destroy;
begin
  if FCopyRegion <> 0 then
    DeleteObject(FCopyRegion);
  FMask.Free;
  inherited Destroy;
end;

end.
