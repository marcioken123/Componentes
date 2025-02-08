unit ElShadowWindow;
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

ElShadowWindow unit
-------------------
TElShadow component for create window shadow in OSes that doens't support
CS_DROPSHADOW style

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface
uses
  Classes,
  Controls,
  Windows,
  Graphics,
  Forms,
  Messages,
  LMDProcs,
  LMDGraphUtils,
  ElVCLUtils;

type
  TElShadowRect = class(TCustomControl)
  protected
    FShadowMask: TBitmap;
    FSavedBack: TBitmap;
    FShadowIntensity: Integer;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMMouseActivate(var Message: TWMMouseActivate); message WM_MOUSEACTIVATE;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  end;

  TElVerticalShadow = class(TElShadowRect)
  public
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  end;

  TElHorizontalShadow = class(TElShadowRect)
  public
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  end;

  TElShadow = class(TComponent)
  private
    FControl: TControl;
    FVertShadow: TElShadowRect;
    FHorzShadow: TElShadowRect;
    FShadowWidth: Integer;
    FTopLeftPoint: TPoint;
    FShadowIntensity: Byte;
    FVisibleHorzShadow: Boolean;
    function GetVisibleHorizontalShadow: boolean;
    procedure SetVisibleHorizontalShadow(const Value: boolean);
    procedure SetShadowIntensity(const Value: Byte);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetBounds(LTopLeftPoint: TPoint); virtual;
    procedure SetShadowWidth(const Value: Integer); virtual;
    procedure SetControl(const Value: TControl); virtual;
    function GetVisible: Boolean;
    procedure SetVisble(const Value: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Show;
    procedure Hide;
    destructor Destroy; override;
    property VisibleHorizontalShadow: boolean read GetVisibleHorizontalShadow write SetVisibleHorizontalShadow default True;
    property Visible: Boolean read GetVisible write SetVisble;
    property Control: TControl read FControl write SetControl;
    property ShadowWidth: Integer read FShadowWidth write SetShadowWidth default 4;
    property ShadowIntensity: Byte read FShadowIntensity write SetShadowIntensity default 49;
  end;

implementation

{ TElShadowRect }

constructor TElShadowRect.Create(Owner: TComponent);
begin
  inherited;
  FSavedBack := TBitmap.Create;
  FSavedBack.PixelFormat := pf24bit;
  TabStop := False;
  Hide;
  ParentWindow := Forms.Application.Handle;
end;

destructor TElShadowRect.Destroy;
begin
  FSavedBack.Free;
  inherited;
end;

procedure TElShadowRect.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
  begin
    if ParentWindow <> 0 then
      Style := Style and not WS_CHILD or WS_POPUP or WS_OVERLAPPED;
    WindowClass.Style := CS_SAVEBITS or CS_DBLCLKS or not (CS_HREDRAW or not CS_VREDRAW);
    ExStyle := ExStyle or WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
  end;
end;

procedure TElShadowRect.WMNCHitTest(var Message: TWMNCHitTest);
begin
  Message.Result := HTTRANSPARENT;
end;

procedure TElShadowRect.Paint;
begin
  inherited Paint;
  Canvas.StretchDraw(Rect(0, 0, Width, Height), FSavedBack);
end;

procedure TElShadowRect.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  LDesktopDC: HDC;
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if Visible then
    exit;
  FSavedBack.Width := Width;
  FSavedBack.Height := Height;
  LDesktopDC := GetDC(GetDeskTopWindow());
  BitBlt(FSavedBack.Canvas.Handle, 0, 0, Width, Height, LDesktopDC, Left, Top, SRCCOPY);
  ReleaseDC(GetDeskTopWindow, LDesktopDC);
end;

procedure TElShadowRect.WMMouseActivate(var Message: TWMMouseActivate);
begin
  Message.Result := MA_NOACTIVATE;
end;

procedure TElShadowRect.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 0;
end;

{ TElShadow }

constructor TElShadow.Create(AOwner: TComponent);
begin
  inherited;
  FShadowWidth := 4;
  FVertShadow := TElVerticalShadow.Create(AOwner);
  FHorzShadow := TElHorizontalShadow.Create(AOwner);
  FShadowIntensity := 58;
  FVertShadow.FShadowIntensity := FShadowIntensity;
  FHorzShadow.FShadowIntensity := FShadowIntensity;

  FVisibleHorzShadow := True;

  Visible := False;
end;

destructor TElShadow.Destroy;
begin
  Hide;
  FVertShadow.Free;
  FHorzShadow.Free;
  inherited;
end;

procedure TElShadow.SetBounds(LTopLeftPoint: TPoint);
begin
  Hide;
  FVertShadow.SetBounds(LTopLeftPoint.X + Control.Width, LTopLeftPoint.Y + FShadowWidth, FShadowWidth, Control.Height - FShadowWidth);
  FHorzShadow.SetBounds(LTopLeftPoint.X + FShadowWidth, LTopLeftPoint.Y + Control.Height, Control.Width, FShadowWidth);
  Show;
end;

function TElShadow.GetVisible: Boolean;
begin
  Result := FVertShadow.Visible and FHorzShadow.Visible;
end;

function TElShadow.GetVisibleHorizontalShadow: boolean;
begin
  Result := FHorzShadow.Visible;
end;

procedure TElShadow.Hide;
begin
  FVertShadow.Visible := False;
  if FVisibleHorzShadow then
    FHorzShadow.Visible := False;
end;

procedure TElShadow.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then
  begin
    FControl := nil;
    Visible := False;
  end;
end;

procedure TElShadow.SetControl(const Value: TControl);
begin
  if FControl <> Value then
  begin
    if Assigned(FControl) then
      FControl.RemoveFreeNotification(Self);

    FControl := Value;

    if not Assigned(FControl) then
      exit;

    FControl.FreeNotification(Self);
    FTopLeftPoint := FControl.BoundsRect.TopLeft;

    if FControl.Parent <> nil then
      FTopLeftPoint := FControl.ClientToScreen(FControl.ClientRect.TopLeft);

    SetBounds(FTopLeftPoint);
  end;
end;

procedure TElShadow.SetShadowIntensity(const Value: Byte);
begin
  FShadowIntensity := Value;
  FVertShadow.FShadowIntensity := FShadowIntensity;
  FHorzShadow.FShadowIntensity := FShadowIntensity;
  if Assigned(FControl) then
    SetBounds(FTopLeftPoint);
end;

procedure TElShadow.SetShadowWidth(const Value: Integer);
begin
  FShadowWidth := Value;
  if Assigned(FControl) then
    SetBounds(FTopLeftPoint);
end;

procedure TElShadow.SetVisble(const Value: Boolean);
begin
  if Value then
    Show
  else
    Hide;
end;

procedure TElShadow.SetVisibleHorizontalShadow(const Value: boolean);
begin
  if FVisibleHorzShadow <> Value then
  begin
    FVisibleHorzShadow := Value;
    FHorzShadow.Visible := FVisibleHorzShadow;
  end;
end;

procedure TElShadow.Show;
begin
  if FVertShadow.HandleAllocated then
    SetWindowPos(FVertShadow.Handle, HWND_TOPMOST, 0, 0, 0, 0,
      SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_SHOWWINDOW or SWP_NOREPOSITION);

  if FHorzShadow.HandleAllocated then
    if FVisibleHorzShadow then
      SetWindowPos(FHorzShadow.Handle, HWND_TOPMOST, 0, 0, 0, 0,
        SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOMOVE or SWP_SHOWWINDOW or SWP_NOREPOSITION);
end;

{ TElVerticalShadow }

procedure TElVerticalShadow.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  LX, LY: Integer;
  LFadeValue: Integer;
  H, L, S: Word;
  LTemp: Integer;
  LMemory: TLMDRawMemory;
begin
  inherited;
  LMemory := TLMDRawMemory.Create;
  try
    for LY := 0 to Height - 1 do
    begin
      LMemory.Memory := FSavedBack.ScanLine[LY];
      for LX := 0 to Width - 1 do
      begin
        if LY - LX < 0 then
          continue;

        LMemory.BaseOffset := LX * SizeOf(TRGBTriple);
        LTemp := LMDRGBtoHLS(RGB(LMemory.Byte[2], LMemory.Byte[1], LMemory.Byte[0]));
        H := GetRValue(LTemp);
        L := GetGValue(LTemp);
        S := GetBValue(LTemp);

        if L < FShadowIntensity then
          Continue;
        if (LY <= Width) then
          LFadeValue := -FShadowIntensity + (LX * 15) + (Width - LY) * 10
        else
        if (LY >= Height) then
          LFadeValue := -FShadowIntensity - ((Width - LX) * 15) - ((Height - 8)- LY) * 15
        else
          LFadeValue := -FShadowIntensity + LX * 15;

        LTemp := LMDHLStoRGB(HLS(H, L + LFadeValue, S));

        LMemory.Byte[2] := GetRValue(LTemp);
        LMemory.Byte[1] := GetGValue(LTemp);
        LMemory.Byte[0] := GetBValue(LTemp);
      end;
    end;
  finally
    LMemory.Free;
  end;
end;

{ TElHorizontalShadow }

procedure TElHorizontalShadow.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  LX, LY: Integer;
  LFadeValue: Integer;
  H, L, S: Word;
  LTemp: Integer;
  LMemory: TLMDRawMemory;
begin
  inherited;
  LMemory := TLMDRawMemory.Create;
  try
    for LY := 0 to Height - 1 do
    begin
      LMemory.Memory := FSavedBack.ScanLine[LY];
      for LX := LY to Width - 1 - LY do
      begin
        LMemory.BaseOffset := LX * SizeOf(TRGBTriple);

        LTemp := LMDRGBtoHLS(RGB(LMemory.Byte[2], LMemory.Byte[1], LMemory.Byte[0]));
        H := GetRValue(LTemp);
        L := GetGValue(LTemp);
        S := GetBValue(LTemp);

        if L < FShadowIntensity then
          Continue;
        if (LX <= Height) then
          LFadeValue := -FShadowIntensity + (LY * 15) + (Height - LX) * 10
        else
        if (LX >= Width - Height) then
          LFadeValue := -FShadowIntensity - ((Height - LY) * 15) - ((Width - 8)- LX) * 15
        else
          LFadeValue := -FShadowIntensity + LY * 15;

        LTemp := LMDHLStoRGB(HLS(H, L + LFadeValue, S));

        LMemory.Byte[2] := GetRValue(LTemp);
        LMemory.Byte[1] := GetGValue(LTemp);
        LMemory.Byte[0] := GetBValue(LTemp);
      end;
    end;
  finally
    LMemory.Free;
  end;
end;

end.
