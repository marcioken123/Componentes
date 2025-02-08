unit LMDHTMLExtListBox;
{$I lmdcmps.INC}

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

LMDHTMLExtListBox unit (VB)
---------------------------

Changes
-------
Release 12.0 (October 2012)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  ComCtrls,
  Controls,
  Menus,
  Graphics,
  Messages,
  Windows,
  LMDTypes,
  LMDCustomListBox,
  LMDHTMLUnit;

type
  TLMDHTMLExtListBox = class (TLMDCustomListBox)
  private
    FCursor: TCursor;
    FIsHTML: boolean;

    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;

    FOnLinkClick: TLMDHTMLLinkClickEvent;
    FOnImageNeeded: TLMDHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;

    procedure SetIsHTML(const Value: boolean);
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure SetLinkColor(const Value: TColor);
    procedure SetLinkPopupMenu(const Value: TPopupMenu);
    procedure SetLinkStyle(const Value: TFontStyles);
    procedure SetCursor(const Value: TCursor);
  protected
    FRender: TLMDHTMLRender;
    procedure DoLinkPopup(MousePos : TPoint);
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure ModifyItemRect(var ItemRect: TREct); virtual;
    procedure ModifyItemText(var ItemText: string); virtual;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure TriggerLinkClickEvent(Sender: TObject; HRef : TLMDString);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; Image : TPicture);
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Count;
    property CtlXP;  // compatibility
    property HTMLRender: TLMDHTMLRender read FRender;
  published
    property AutoComplete;
    property VirtualMode;
    property Columns;
    property Cursor: TCursor read FCursor write SetCursor;
    property IsHTML: boolean read FIsHTML write SetIsHTML default true;
    property Items;
    property ItemAutoHeight;
    property EditOptions;
    property LargeTextOptions;
    property VerticalScrollBar;
    property Margin;
    property MultiLine;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
    property HorzGridColor;
    property HorzGridStyle;
    property HorzGridLine;

    //12.0
    property LinkColor: TColor read FLinkColor write SetLinkColor default def_LMDLinkColor;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default def_LMDLinkStyle;

    // Event for internal edit control
    property OnEditShow;
    property OnEditMeasure;
    property OnEditChange;
    property OnEditHide;

    property OnData;
    property OnDataObject;
    property OnDataFind;

    property OnLinkClick : TLMDHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded : TLMDHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
  end;

  TLMDHTMLLabeledExtListBox = class(TLMDHTMLExtListBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation

uses
  SysUtils;

{ ------------------------- public ------------------------------------------- }
constructor TLMDHTMLLabeledExtListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

{----------------------- TLMDHTMLExtListBox -----------------------------------}
procedure TLMDHTMLExtListBox.CMMouseLeave(var Msg: TMessage);
begin
  inherited Cursor := FCursor;
  inherited;
end;

{------------------------------------------------------------------------------}
constructor TLMDHTMLExtListBox.Create(AOwner: TComponent);
begin
  inherited;
  FIsHTML := true;
  FRender := TLMDHTMLRender.Create;
  FRender.OnImageNeededEx := TriggerImageNeededEvent;
  FRender.OnVariableNeeded := TriggerVariableNeededEvent;
  FRender.Control := Self;
  FLinkColor := def_LMDLinkColor;
  FLinkStyle := def_LMDLinkStyle;
end;

{------------------------------------------------------------------------------}
destructor TLMDHTMLExtListBox.Destroy;
begin
  FreeAndNil(FRender);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDHTMLExtListBox.DoLinkPopup(MousePos: TPoint);
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

{------------------------------------------------------------------------------}
procedure TLMDHTMLExtListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  Inc(Rect.Top, Margin);
  Dec(Rect.Right, Margin);
  Inc(Rect.Left, Margin);
  Dec(Rect.Bottom, Margin);

  if IsHTML and not Assigned(OnDrawItem) then
  begin
    with FRender.Data do
    begin
      DefaultStyle   := Font.Style;
      DefaultHeight  := Font.Height;
      DefaultFont    := Font.Name;
      Charset        := Font.Charset;
      LinkColor      := FLinkColor;
      LinkStyle      := FLinkStyle;
      if odSelected in State then
        DefaultColor := SelectedFontColor
      else
        DefaultColor := GetThemedTextColor;
    end;
    if Multiline then
      FRender.PrepareText(Items[Index], Rect.Right - Rect.Left, True)
    else
      FRender.PrepareText(Items[Index], 0, false);
    FRender.DrawText(Canvas, Point(0, 0), Rect, FRender.Data.DefaultBgColor);
  end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDHTMLExtListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if IsHTML then
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
    if Multiline then
      FRender.PrepareText(Items[Index], ClientWidth, True)
    else
      FRender.PrepareText(Items[Index], 0, false);
    Height := FRender.Data.TextSize.cy;
  end
  else
    inherited;
end;

procedure TLMDHTMLExtListBox.ModifyItemRect(var ItemRect: TREct);
begin
  //do nothing here
end;

{------------------------------------------------------------------------------}
procedure TLMDHTMLExtListBox.ModifyItemText(var ItemText: string);
begin
  //do nothing here
end;

{------------------------------------------------------------------------------}
procedure TLMDHTMLExtListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  href : TLMDString;
  i : integer;
  R : TRect;
  LItemText: string;
begin
  begin
    i := SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(X,Y));
    SendMessage(Handle, LB_GETITEMRECT, i, LPARAM(@R));
    ModifyItemRect(R);
    if PtInRect(R, Point(X,Y)) and (i >= 0) and (i < Items.Count) then
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
      LItemText := Items[i];
      ModifyItemText(LItemText);
      if Multiline then
        FRender.PrepareText(LItemText, R.Right - R.Left, false)
      else
        FRender.PrepareText(LItemText, 0, false);
      if FRender.IsCursorOverLink(Point(X - R.Left, Y - R.Top), Point(0, 0), Rect(0, 0, R.Right - R.Left, R.Bottom - R.Top), href) then
      begin
        if (Button = mbRight) and (FLinkPopupMenu <> nil) then
          DoLinkPopup(ClientToScreen(Point(X, Y)))
        else
          TriggerLinkClickEvent(Self, href);
        exit;
      end;
    end;
  end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDHTMLExtListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  href : TLMDString;
  i : integer;
  R : TRect;
  LItemText: string;
  lCursor: TCursor;
begin
  inherited;
  if IsHTML then
  begin
    i := SendMessage(Handle, LB_ITEMFROMPOINT, 0, MakeLParam(X,Y));
    SendMessage(Handle, LB_GETITEMRECT, i, LPARAM(@R));
    ModifyItemRect(R);
    if PtInRect(R, Point(X,Y)) and (i >= 0) and (i < Items.Count) then
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
      LItemText := Items[i];
      ModifyItemText(LItemText);
      if Multiline then
        FRender.PrepareText(LItemText, R.Right - R.Left, True)
      else
        FRender.PrepareText(LItemText, 0, false);
      if FRender.IsCursorOverLink(Point(X - R.Left, Y - R.Top), Point(0, 0), Rect(0, 0, R.Right - R.Left, R.Bottom - R.Top), href) then
         lCursor := crHandPoint
      else
         lCursor := FCursor;
      inherited Cursor := lCursor;
    end
    else
      inherited Cursor := FCursor;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBox.SetCursor(const Value: TCursor);
var
  P : TPoint;
begin
  if (FCursor <> Value) then
  begin
    FCursor := Value;
    GetCursorPos(P);
    P := ScreenToClient(P);
    SendMessage(Handle, WM_MOUSEMOVE, 0, MakeLParam(P.X, P.Y));
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBox.SetIsHTML(const Value: boolean);
begin
  FIsHTML := Value;
  GetChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBox.SetLinkColor(const Value: TColor);
begin
  FLinkColor := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBox.SetLinkPopupMenu(const Value: TPopupMenu);
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

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBox.SetLinkStyle(const Value: TFontStyles);
begin
  FLinkStyle := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBox.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBox.TriggerImageNeededEvent(Sender: TObject;
  Src: TLMDString; Image: TPicture);
begin
  if (Assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src, Image);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLExtListBox.TriggerLinkClickEvent(Sender: TObject; HRef: TLMDString);
begin
  if Assigned(FOnLinkClick) then
    FOnLinkClick(Self, HRef);
end;

end.
