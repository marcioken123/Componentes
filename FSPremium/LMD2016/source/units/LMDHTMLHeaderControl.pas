unit LMDHTMLHeaderControl;
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

LMDHTMLHeaderControl unit (VB)
------------------------------

Changes
-------

Release 12.0 (October 2011)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Menus, StdCtrls, ExtCtrls, Controls, ComCtrls, Classes,
  Graphics, Forms, LMDTypes, LMDBase, LMDClass, LMDHeaderControl, LMDHTMLUnit;

type
  {------------------------- TLMDHTMLHeaderControl ----------------------------}
  TLMDHTMLHeaderControl = class(TLMDHeaderControl)
  private
    FCursor: TCursor;
    FIsHTML: Boolean;
    FOnLinkClick: TLMDHTMLLinkClickEvent;
    FOnImageNeeded: TLMDHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FRender: TLMDHTMLRender;
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;

    procedure SetIsHTML(const Value: boolean);
    procedure SetLinkColor(const Value: TColor);
    procedure SetLinkPopupMenu(const Value: TPopupMenu);
    procedure SetLinkStyle(const Value: TFontStyles);
  protected
    procedure DoLinkPopup(MousePos : TPoint);
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure TriggerLinkClickEvent(HRef : TLMDString);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; Image : TPicture);
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString);
    function  DrawThemedSection(ACanvas: TCanvas; ASection: THeaderSection; AActive, APressed: Boolean; ARect: TRect): TRect; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ActiveSection: integer read FActiveSection;
  published
    property IsHTML: boolean read FIsHTML write SetIsHTML default true;
    property OnLinkClick : TLMDHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded : TLMDHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
    property LinkColor: TColor read FLinkColor write SetLinkColor default def_LMDLinkColor;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default def_LMDLinkStyle;
  end;

implementation

uses
  Types, SysUtils, CommCtrl, Themes, LMDThemes;

{------------------------- TLMDHTMLHeaderControl ------------------------------}
constructor TLMDHTMLHeaderControl.Create(AOwner: TComponent);
begin
  inherited;
  FIsHTML := True;
  FLinkColor := def_LMDLinkColor;
  FLinkStyle := def_LMDLinkStyle;

  FRender := TLMDHTMLRender.Create;
  FRender.OnImageNeededEx := TriggerImageNeededEvent;
  FRender.OnVariableNeeded := TriggerVariableNeededEvent;
  FRender.Control := Self;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDHTMLHeaderControl.Destroy;
begin
  FreeAndNil(FRender);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLHeaderControl.DoLinkPopup(MousePos: TPoint);
begin
  if (FLinkPopupMenu <> nil) and FLinkPopupMenu.AutoPopup then
  begin
    SendCancelMode(nil);
    FLinkPopupMenu.PopupComponent := Self;
    if MousePos.X < 0 then
      MousePos := ClientToScreen(Point(0,0));
    FLinkPopupMenu.Popup(MousePos.X, MousePos.Y);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLHeaderControl.DrawThemedSection(ACanvas: TCanvas;
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

  lFlags    := DT_VCENTER or DT_SINGLELINE or DT_END_ELLIPSIS;
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

  if (Images <> nil) and (ASection.ImageIndex >= 0) and
     (ASection.ImageIndex < Images.Count) then
  begin
    lRect := lTextRect;
    lRect.Right := lRect.Left + Images.Width;
    OffsetRect(lRect, 0, (ARect.Top + ARect.Bottom - lRect.Top - lRect.Bottom) div 2);
    Images.Draw(ACanvas, lRect.Left, lRect.Top, ASection.ImageIndex, True);
    lTextRect.Left := lTextRect.Left + Images.Width + 1;
  end;

  if IsHTML then
  begin
    if lTextRect.Right > lTextRect.Left then
    begin
      with FRender.Data do
      begin
        DefaultStyle  := Font.Style;
        DefaultHeight := Font.Height;
        DefaultFont   := Font.Name;
        Charset       := Font.Charset;
        LinkColor     := FLinkColor;
        LinkStyle     := FLinkStyle;
      end;
      FRender.PrepareText(ASection.Text, lTextRect.Right-lTextRect.Left, True);
      FRender.DrawText(Canvas, Point(0,0), lTextRect, FRender.Data.DefaultBgColor);
    end;
  end
  else
    LMDThemeServices.DrawThemeText(UseThemeMode, ACanvas.Handle, lDetails,
      ASection.Text, length(ASection.Text), lFlags, 0, lTextRect);
  Result := ARect;
end;

procedure TLMDHTMLHeaderControl.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  href : TLMDString;
  R : TRect;
begin
  if IsHTML then
  begin
    if (ActiveSection >= 0) then
    begin
      R :=  GetItemRect(ActiveSection);
      if PtInRect(R, Point(X,Y)) then
      begin
        with FRender.Data do
        begin
          DefaultStyle := Font.Style;
          DefaultHeight := Font.Height;
          DefaultFont := Font.Name;
          Charset := Font.Charset;
          LinkColor := FLinkColor;
          LinkStyle := FLinkStyle;
        end;
        FRender.PrepareText(Sections[ActiveSection].Text, R.Right - R.Left, False);
        if FRender.IsCursorOverLink(Point(X - R.Left, Y), Point(0, 0), Rect(0, 0, R.Right - R.Left, R.Bottom - R.Top), href) then
        begin
          if (Button = mbRight) and (FLinkPopupMenu <> nil) then
            DoLinkPopup(ClientToScreen(Point(X, Y)))
          else
            TriggerLinkClickEvent(href);
        end;
        exit;
      end;
    end;
  end;
  inherited;
end;

procedure TLMDHTMLHeaderControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  href : TLMDString;
  R : TRect;
begin
  inherited;
  if IsHTML then
  begin
    if (ActiveSection >= 0) then
    begin
      R :=  GetItemRect(ActiveSection);
      if PtInRect(R, Point(X,Y)) then
      begin
        with FRender.Data do
        begin
          DefaultStyle := Font.Style;
          DefaultHeight := Font.Height;
          DefaultFont := Font.Name;
          Charset := Font.Charset;
          LinkColor := FLinkColor;
          LinkStyle := FLinkStyle;
        end;
        FRender.PrepareText(Sections[ActiveSection].Text, R.Right - R.Left, False);
        if FRender.IsCursorOverLink(Point(X - R.Left, Y), Point(0, 0), Rect(0, 0, R.Right - R.Left, R.Bottom - R.Top), href) then
           inherited Cursor := crHandPoint
        else
           inherited Cursor := FCursor;
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLHeaderControl.SetIsHTML(const Value: boolean);
begin
  FIsHTML := Value;
end;

procedure TLMDHTMLHeaderControl.SetLinkColor(const Value: TColor);
begin
  FLinkColor := Value;
end;

procedure TLMDHTMLHeaderControl.SetLinkPopupMenu(const Value: TPopupMenu);
begin
  if (FLinkPopupMenu <> Value) then
  begin
    if FLinkPopupMenu <> nil then
      if not (csDestroying in FLinkPopupMenu.ComponentState) then
        FLinkPopupMenu.RemoveFreeNotification(Self);
    FLinkPopupMenu := Value;
    if (Value <> nil) then
      Value.FreeNotification(Self);
  end;  { if }
end;

procedure TLMDHTMLHeaderControl.SetLinkStyle(const Value: TFontStyles);
begin
  FLinkStyle := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLHeaderControl.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLHeaderControl.TriggerImageNeededEvent(Sender: TObject;
  Src: TLMDString; Image: TPicture);
begin
  if (Assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src, Image);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLHeaderControl.TriggerLinkClickEvent(HRef: TLMDString);
begin
  if Assigned(FOnLinkClick) then
    FOnLinkClick(Self, HRef);
end;

end.
