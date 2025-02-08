unit LMDHeaderControl;
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

LMDHeadeControl unit (VB)
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, StdCtrls, ExtCtrls, Controls, ComCtrls, Classes, Graphics,
  Forms, LMDTypes, LMDClass;

type
  TLMDHeaderControl = class(THeaderControl)
  private
    function GetSectionWidth(Index:Integer):Integer;
    procedure SetSectionWidth(Index:Integer; aValue:Integer);
    procedure SetThemeGlobalMode(const Value: Boolean);
    procedure SetThemeMode(const Value: TLMDThemeMode);
    procedure SetParentThemeMode(const Value: boolean);
  protected
    FMouseDown: Boolean;
    FMouseDownOnDivider: Boolean;
    FMouseOnDivider: Boolean;
    FDragging: Boolean;
    FActiveSection, FOldActiveSection: Integer;
    FThemeGlobalMode: Boolean;
    FThemeMode     : TLMDThemeMode;
    FParentThemeMode: boolean;
    procedure CheckActiveSection(APosX, APosY: Integer; ARepaintSection: boolean = true);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure DoThemeChanged; virtual;
    procedure DrawSection(Section: THeaderSection; const Rect: TRect;
      Pressed: Boolean); override;
    function DrawThemedSection(ACanvas: TCanvas; AIndex: Integer; AActive, APressed: Boolean): TRect; overload; virtual;
    function DrawThemedSection(ACanvas: TCanvas; ASection: THeaderSection; AActive, APressed: Boolean; ARect: TRect): TRect; overload; virtual;
    function GetItemRect(Index: Integer): TRect;
    function IsThemed: Boolean;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                        X, Y: Integer); override;
    procedure PaintWindow(DC: HDC); override;
    function UseThemeMode: TLMDThemeMode;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WndProc(var Message:TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    property SectionWidth[Index:Integer]:Integer read GetSectionWidth write SetSectionWidth;
  published
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;
    property ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode default true;
    {$IFDEF LMDCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

implementation

uses
  TypInfo, Types, SysUtils, CommCtrl, Themes, LMDThemes;


{********************* Class TLMDHeaderControl ********************************}
{------------------ Private ---------------------------------------------------}
function TLMDHeaderControl.GetSectionWidth(Index:Integer):Integer;
begin
  result:=Sections[index].Width;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.SetSectionWidth(Index:Integer;aValue:Integer);
begin
  if Sections[index].Width <> aValue then
    begin
      Sections[index].Width := aValue;
      Self.OnSectionResize(Self, Sections[Index]);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
    begin
      FThemeGlobalMode := Value;
      DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.SetThemeMode(const Value: TLMDThemeMode);
begin
  if (FThemeMode <> Value) then
    begin
      FThemeMode := Value;
      if not FThemeGlobalMode then
        DoThemeChanged;
    end;
end;

{------------------ Protected--------------------------------------------------}
procedure TLMDHeaderControl.CheckActiveSection(APosX, APosY: Integer; ARepaintSection: boolean);
var
  i: Integer;
  lRect: TRect;
begin
  FOldActiveSection := FActiveSection;
  FActiveSection := -1;
  for i := 0 to Sections.Count - 1 do
  begin
    lRect := GetItemRect(i);
    if PtInRect(lRect, Point(APosX, APosY))
    then
      begin
        FActiveSection := i;
        Break;
      end;
  end;
  if ARepaintSection and (FOldActiveSection <> FActiveSection)
  then
    begin
      if (FOldActiveSection <> - 1) and not FDragging then
        DrawThemedSection(Canvas, FOldActiveSection, False, False);
      if (FActiveSection <> -1) and not FDragging then
        DrawThemedSection(Canvas, FActiveSection, True, False);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.CMMouseEnter(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then
    exit;
  if not FMouseDown then
    Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.CMMouseLeave(var Message: TMessage);
begin
  if (csDesigning in ComponentState) then
    exit;
  FActiveSection := -1;
  FOldActiveSection := -1;
  if not FMouseDown then
    Invalidate;
end;

{---------------------- Public ------------------------------------------------}
constructor TLMDHeaderControl.Create(AOwner: TComponent);
begin
  inherited;
  FThemeGlobalMode := false;
  FParentThemeMode := true;
  FThemeMode := ttmPlatform;
  FOldActiveSection := -1;
  FActiveSection := -1;
  FMouseDownOnDivider := False;
  FMouseOnDivider := False;
  FMouseDown := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.DoThemeChanged;
begin
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.DrawSection(Section: THeaderSection;
  const Rect: TRect; Pressed: Boolean);
var
  SectionOrder: array of Integer;
  i, lIndex: Integer;
begin
  inherited;
  if IsThemed then
    begin
      if Self.DragReorder then
        begin
          SetLength(SectionOrder, Sections.Count);
          Header_GetOrderArray(Handle, Sections.Count, PInteger(SectionOrder));
          for i := 0 to Sections.Count - 1 do
           if SectionOrder[i] = Section.Index then Break;
          lIndex := i;
        end
      else
        lIndex := Section.Index;
      DrawThemedSection(Canvas, Sections[lIndex], False, Pressed, Rect);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDHeaderControl.DrawThemedSection(ACanvas: TCanvas; AIndex: Integer;
  AActive, APressed: Boolean): TRect;
var
  lRect: TRect;
begin
  lRect := GetItemRect(AIndex);
  Result := lRect;
  DrawThemedSection(ACanvas, Sections[AIndex], AACtive, APressed, lRect);
end;

{------------------------------------------------------------------------------}
function TLMDHeaderControl.DrawThemedSection(ACanvas: TCanvas;
  ASection: THeaderSection; AActive, APressed: Boolean; ARect: TRect): TRect;
var
  lDetails: TThemedElementDetails;
  lRect, lTextRect: TRect;
  lFlags: integer;
begin
  lDetails := ThemeServices.GetElementDetails(thHeaderItemNormal);
  if not FMouseDownOnDivider then
    begin
      if APressed then
        lDetails := ThemeServices.GetElementDetails(thHeaderItemPressed)
      else
        if AActive then
          lDetails := ThemeServices.GetElementDetails(thHeaderItemHot);
    end;
  LMDThemeServices.DrawElement(UseThemeMode, ACanvas.Handle, lDetails, aRect);
  lFlags := DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS;
  lTextRect := aRect;
  InflateRect(lTextRect, -2, 0);
  OffsetRect(lTextRect, 0, -1);
  case ASection.Alignment of
    taLeftJustify:
      lFlags := lFlags or DT_LEFT;
    taRightJustify:
      lFlags := lFlags or DT_RIGHT;
    taCenter:
      lFlags := lFlags or DT_CENTER;
  end;

  if (Images <> nil) and (ASection.ImageIndex >= 0) and (ASection.ImageIndex < Images.Count) then
    begin
      lRect := lTextRect;
      lRect.Right := lRect.Left + Images.Width;
      OffsetRect(lRect, 0, (ARect.Top + ARect.Bottom - lRect.Top - lRect.Bottom) div 2);
      Images.Draw(ACanvas, lRect.Left, lRect.Top, ASection.ImageIndex, True);
      lTextRect.Left := lTextRect.Left + Images.Width + 1;
    end;

  LMDThemeServices.DrawThemeText(UseThemeMode, ACanvas.Handle, lDetails, ASection.Text, length(ASection.Text), lFlags, 0, lTextRect);
  Result := ARect;
end;

{------------------------------------------------------------------------------}
function TLMDHeaderControl.GetItemRect(Index: Integer): TRect;
var
  lSectionOrder: array of Integer;
  lRect: TRect;
begin
  if Self.DragReorder
  then
    begin
      SetLength(lSectionOrder, Sections.Count);
      Header_GetOrderArray(Handle, Sections.Count, PInteger(lSectionOrder));
      Header_GETITEMRECT(Handle, lSectionOrder[Index] , @lRect);
    end
  else
    Header_GETITEMRECT(Handle, Index, @lRect);
  Result := lRect;
end;

{------------------------------------------------------------------------------}
function TLMDHeaderControl.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  if IsThemed then
    begin
    if (Button = mbLeft) and not FMouseOnDivider and (Style = hsButtons) then
      begin
        FMouseDown := True;
        Invalidate;
      end;
    if (Button = mbLeft) and FMouseOnDivider then
      FMouseDownOnDivider := True
    else
      FMouseDownOnDivider := False;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
 inherited;
 if IsThemed then
   begin
     if FMouseDown and DragReorder then
       FDragging := True
     else
       FDragging := False;
     if not (csDesigning in ComponentState) and not FDragging then
       CheckActiveSection(X, Y);
     if FMouseDownOnDivider then
       Invalidate;
   end;
end;

procedure TLMDHeaderControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  FDragging := False;
  FMouseDownOnDivider := False;
  FActiveSection := -1;
  FOldActiveSection := -1;
  if (Button = mbLeft) and not (csDesigning in ComponentState) and (Style = hsButtons) then
    begin
      CheckActiveSection(X, Y);
      Invalidate;
      FMouseDown := False;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.PaintWindow(DC: HDC);
var
  i, lSaveDC: Integer;
  lRightOffset: Integer;
  lRect, lBgrRect: TRect;
  lDetails: TThemedElementDetails;
begin
  if not HandleAllocated or (Handle = 0) then
    exit;
  if (Width <= 0) or (Height <=0) then
    exit;
  lSaveDC := SaveDC(DC);
  try
    Canvas.Handle := DC;
    lRightOffset := 0;
    for I := 0 to Sections.Count - 1 do
      begin
        lRect := DrawThemedSection(Canvas, I, (I = FActiveSection) and not FMouseDown, (I = FActiveSection) and FMouseDown);
        if lRightOffset < lRect.Right then
          lRightOffset := lRect.Right;
      end;
    lBgrRect := Rect(lRightOffset, 0, Width + 2, Height);
    if lBgrRect.Left < lBgrRect.Right then
      begin
        lDetails := ThemeServices.GetElementDetails(thHeaderItemNormal);
        LMDThemeServices.DrawElement(UseThemeMode, Canvas.Handle, lDetails, lBgrRect);
      end;
    Canvas.Handle := 0;
  finally
    RestoreDC(DC, lSaveDC);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDHeaderControl.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if IsThemed then
    Message.Result := 1
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.WMPaint(var Msg: TWMPaint);
begin
  if IsThemed then
    PaintHandler(Msg)
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDHeaderControl.WndProc(var Message: TMessage);
begin
  inherited;
  case Message.Msg of
     HDM_HITTEST:
        begin
          if PHDHitTestInfo(Message.LParam)^.Flags = HHT_ONDIVIDER
          then
            FMouseOnDivider := True
          else
            FMouseOnDivider := False;
        end;
    end;
end;

end.
