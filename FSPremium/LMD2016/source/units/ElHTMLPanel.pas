unit ElHTMLPanel;
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

ElHTMLPanel unit
----------------

Changes
-------
Release 6.05
 [+] WordWrap property.

 Release 6.0 (February 2007)
 - Initial Release
###############################################################################}

interface

uses
  Classes, SysUtils, ImgList, Menus, Windows, Graphics, Controls, StdCtrls, Forms,
  ExtCtrls, Messages,  Types,  
  LMDProcs, LMDTypes, LMDHTMLUnit, 
  ElPanel, ElVCLUtils, ElHTMLContainer;

type

  TCustomElHTMLPanel = class(TCustomElPanel)
  private
    FChangeLink:TElHTMLChangeLink;
    FCheck:Boolean;
    // Container support ElPack 5
    FContainer:TElHTMLContainer;
    FCursor: TCursor;
    FIndex:Integer;
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;
    // ----------------

    FOnImageNeeded: TElHTMLImageNeededEvent;
    FOnImageNeededEx : TLMDHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FOnLinkClick: TElHTMLLinkClickEvent;
    FOnTagFound: TLMDHTMLTagFoundEvent;

    FTextRect: TRect;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure DoCaptionChange(Sender: TObject);
    function GetCaptionText: TLMDString;
    procedure SetContainer(aValue: TElHTMLContainer);
    procedure SetCursor(newValue : TCursor);
    procedure SetIndex(aValue: Integer);
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
  protected
    FRender : TLMDHTMLRender;
    procedure Click; override;
    procedure DefineProperties(Filer: TFiler); override;
    procedure DoLinkPopup(MousePos : TPoint);
    // RM
    function  LinkEmpty:Boolean;
    // --
    procedure Loaded;override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent: TComponent; operation: TOperation);override;
    procedure SetCaption(newValue: TLMDString); override;
    procedure SetLinkColor(newValue : TColor); virtual;
    procedure SetLinkPopupMenu(newValue : TPopupMenu);virtual;
    procedure SetLinkStyle(newValue : TFontStyles); virtual;
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image: TBitmap); virtual;
    procedure TriggerImageNeededExEvent(Sender : TObject; Src : TLMDString; Image : TPicture); virtual;
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString);
    procedure TriggerTagFoundEvent(Sender : TObject; var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean);
    procedure TriggerLinkClickEvent(HRef : TLMDString); virtual;
    procedure TriggerPaintEvent; override;
    // RM
    property CheckContainerLinks: Boolean read FCheck write FCheck default true;
    property Container: TElHTMLContainer read FContainer write SetContainer;
    property ContainerIndex: Integer read FIndex write SetIndex default 0;
    // ----
    property Cursor: TCursor read FCursor write SetCursor;
    property LinkColor: TColor read FLinkColor write SetLinkColor default def_LMDLinkColor;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default def_LMDLinkStyle;
    property OnImageNeeded: TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnHTMLImageNeededEx : TLMDHTMLImageNeededEvent read FOnImageNeededEx write FOnImageNeededEx;
    property OnLinkClick: TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
    property OnTagFound : TLMDHTMLTagFoundEvent read FOnTagFound write FOnTagFound;
  public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  end;

  TElHTMLPanel = class(TCustomElHTMLPanel)
  published
    property WordWrap;
    property Align;
    property Alignment;
    property Anchors;
    property Background;
    property BackgroundType;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
    property BottomGrabHandle;
    property Caption;
    property CheckContainerLinks;
    property Color;
    property Constraints;
    property Container;
    property ContainerIndex;
    property Cursor;
    property DockOrientation;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property GradientEndColor;
    property GradientStartColor;
    property GradientSteps;

    property ImageForm;

    property Layout;
    property LeftGrabHandle;
    property LinkColor;
    property LinkPopupMenu;
    property LinkStyle;
    property Locked;
    property MouseCapture;
    property Movable;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnImageNeeded;
    property OnHTMLImageNeededEx;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnLinkClick;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnMove;
    property OnResize;
    property OnVariableNeeded;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property ParentThemeMode default true;
    property PopupMenu;
    property Resizable;
    property RightGrabHandle;
    property ShowFocus;
    property ShowHint;
    property SizeGrip;
    property TabStop;
    property TopGrabHandle;
    property Transparent;
    property TransparentXPThemes;
    property ThemeMode;
    property ThemeGlobalMode;
    property Visible;
  end;

implementation

const
  Margin = 1;

{ ******************** class TCustomElHTMLPanel ****************************** }
{ ------------------------------ private ------------------------------------- }
procedure TCustomElHTMLPanel.DoCaptionChange(Sender: TObject);
begin
  if csLoading in ComponentState then exit;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
function TCustomElHTMLPanel.GetCaptionText:TLMDString;
begin
  if LinkEmpty then
    result:=Caption
  else
    result:=FContainer.Items[FIndex].Caption;
end;

// RM
{ ---------------------------------------------------------------------------- }
procedure TCustomElHTMLPanel.SetContainer(aValue:TElHTMLContainer);
begin
  if FContainer<>nil then
    FContainer.UnRegisterChanges(FChangeLink);
  FContainer:=aValue;
  if FContainer<>nil then
    begin
      FContainer.RegisterChanges(FChangeLink);
      FContainer.FreeNotification(Self);
    end;
  DoCaptionChange(nil);
end;

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.SetCursor(newValue : TCursor);
var P : TPoint;
    href : TLMDString;
begin
  if (FCursor <> newValue) then
    begin
      FCursor := newValue;
      GetCursorPos(P);
      P := ScreenToClient(P);
      if FRender.IsCursorOverLink(Point(P.X - FTextRect.Left, P.Y - FTextRect.Top), Point(0, 0), FTextRect, href) then
        inherited Cursor := crHandPoint
      else
        inherited Cursor := FCursor;
    end;  { if }
end;  { SetCursor }

{ ---------------------------------------------------------------------------- }
procedure TCustomElHTMLPanel.SetIndex(aValue:Integer);
begin
  if aValue<>FIndex then
    begin
      FIndex:=aValue;
      if Assigned(FContainer) then DoCaptionChange(nil);
    end;
end;

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.CMMouseLeave(var Msg : TMessage);
begin
  inherited Cursor := FCursor;
  inherited;
end;  { CMMouseLeave }

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
  href : TLMDString;
begin
  if Message.Result <> 0 then Exit;
  if csDesigning in ComponentState then Exit;

  Pt := ScreenToClient(SmallPointToPoint(Message.Pos));

  if (LinkPopupMenu <> nil) and FRender.IsCursorOverLink(Point(Pt.X - FTextRect.Left, Pt.Y - FTextRect.Top), Point(0, 0), FTextRect, href) then
    begin
      Handled := False;
      Temp := ClientToScreen(Pt);
      DoContextPopup(Temp, Handled);
      Message.Result := Ord(Handled);
      if Handled then Exit;

      DoLinkPopup(ClientToScreen(Pt));
      Message.Result := 1;
    end
  else
    inherited;
end;

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.WMRButtonUp(var Message: TWMRButtonUp);
var P : TPoint;
    href : TLMDString;
begin
  P := SmallPointToPoint(Message.Pos);
  if (LinkPopupMenu <> nil) and FRender.IsCursorOverLink(Point(P.X - FTextRect.Left, P.Y - FTextRect.Top), Point(0, 0), ClientRect, href) then
    begin
      if not (csNoStdEvents in ControlStyle) then
        with Message do
          MouseUp(mbRight, KeysToShiftState(Keys), XPos, YPos);
      if Message.Result = 0 then
        DoLinkPopup(P);
    end
  else
    inherited;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TCustomElHTMLPanel.Click;
var P : TPoint;
    href : TLMDString;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if FRender.IsCursorOverLink(Point(P.X - FTextRect.Left, P.Y - FTextRect.Top), Point(0, 0), FTextRect, href) then
    TriggerLinkClickEvent(href)
  else
    inherited;
end;  { Click }

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('Canvas', FakeValue, nil, false);
end;

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.DoLinkPopup(MousePos : TPoint);
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

{ -----------------------------------------------------------------------------}
function TCustomElHTMLPanel.LinkEmpty: Boolean;
begin
  result:=not ((FContainer<>nil) and (FIndex<FContainer.Count));
end;

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.Loaded;
begin
  inherited Loaded;
end;    { Loaded }

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  href : TLMDString;
begin
  if FRender.IsCursorOverLink(Point(X - FTextRect.Left, Y - FTextRect.Top), Point(0, 0), FTextRect, href) then
     inherited Cursor := crHandPoint
  else
     inherited Cursor := FCursor;
  inherited MouseMove(Shift, X, Y);
end;  { MouseMove }

{ ---------------------------------------------------------------------------- }
procedure TCustomElHTMLPanel.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
    begin
      if (AComponent = FLinkPopupMenu) then
        LinkPopupMenu := nil;
      if (AComponent = FContainer) then
        Container := nil;
    end;  { if }
end;  { Notification }

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.SetCaption(newValue: TLMDString);
{ Sets data member FCaption to newValue. }
begin
  inherited;
  Invalidate;
end; { SetCaption }

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
    begin
      FLinkColor := newValue;
      Invalidate;
    end;  { if }
end;  { SetLinkColor }

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.SetLinkPopupMenu(newValue : TPopupMenu);
begin
  if (FLinkPopupMenu <> newValue) then
    begin
      if FLinkPopupMenu <> nil then
        if not (csDestroying in FLinkPopupMenu.ComponentState) then
          FLinkPopupMenu.RemoveFreeNotification(Self);
      FLinkPopupMenu := newValue;
      if (newValue <> nil) then
         newValue.FreeNotification(Self);
    end;  { if }
end;  { SetLinkPopupMenu }

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
    begin
      FLinkStyle := newValue;
      Invalidate;
    end;  { if }
end;  { SetLinkStyle }

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.TriggerImageNeededEvent(Sender : TObject; Src :
    TLMDString; var Image : TBitmap);
begin
  Image := nil;
  if Assigned(FOnImageNeeded) then
    FOnImageNeeded(Self, Src, Image);
end;

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.TriggerImageNeededExEvent(Sender: TObject;
  Src: TLMDString; Image: TPicture);
begin
  if (Assigned(FOnImageNeededEx)) then
    FOnImageNeededEx(Self, Src, Image);
end;

{ TriggerImageNeededEvent }

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.TriggerLinkClickEvent(HRef : TLMDString);
var
  tmp:Integer;
begin
  // RM !!
  if FCheck and not LinkEmpty then
    begin
      tmp:=FContainer.ItemByName[HRef];
      if tmp>-1 then
        begin
          ContainerIndex:=tmp;
          Exit;
        end;
    end;
  // ---
  if Assigned(FOnLinkClick) then
    FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.TriggerPaintEvent;
var
  Rect : TRect;
  R1   : TRect;
  tmp  : TLMDString;
begin
  Rect := ClientRect;
  AdjustClientRect(Rect);
  InflateRect(Rect, - Margin * 2, 0);

  FRender.Data.DefaultBgColor := clNone;
  FRender.Data.DefaultColor  := Font.Color;
  FRender.Data.DefaultHeight := Font.Height;
  FRender.Data.DefaultStyle := Font.Style;
  FRender.Data.DefaultFont := Font.Name;
  FRender.Data.Charset := Font.Charset;
  FRender.Data.LinkColor := LinkColor;
  FRender.Data.LinkStyle := LinkStyle;

  tmp := GetCaptionText;
  FRender.PrepareText(tmp, Rect.Right - Rect.Left, WordWrap);
  if tmp = '' then exit;

  case Alignment of
    taRightJustify:
      Rect.Left := Rect.Right - FRender.Data.TextSize.cx;
    taCenter:
      begin
        LMDCenterRects(FRender.Data.TextSize.cx, Rect.Right- Rect.Left,
                    FRender.Data.TextSize.cy, Rect.Bottom - Rect.Top, R1);
        OffsetRect(R1, Rect.Left, Rect.Top);
        Rect.Left := R1.Left;
        Rect.Right := R1.Right;
      end;
  end;
  case Layout of
    tlBottom:
      Rect.Top := Rect.Bottom - FRender.Data.TextSize.cy;
    tlCenter:
      begin
        LMDCenterRects(FRender.Data.TextSize.cx, Rect.Right- Rect.Left,
                    FRender.Data.TextSize.cy, Rect.Bottom - Rect.Top, R1);
        OffsetRect(R1, Rect.Left, Rect.Top);
        Rect.Top := R1.Top;
        Rect.Bottom := R1.Bottom;
      end;
  end;
  FTextRect := Rect;
  with Rect do
    if (Top < bottom) and (Left < Right) then
      begin
        FRender.DrawText(Canvas, Point(0, 0), Rect, clNone);
        if (ShowFocus) and (GetFocus = Self.Handle) then
          begin
            InflateRect(Rect, 1, 1);
            OffsetRect(Rect, 0, 1);
            Canvas.DrawFocusRect(Rect);
          end;
      end;
end;

{ ------------------------------ public -------------------------------------- }
constructor TCustomElHTMLPanel.Create(AOwner : TComponent);
begin
  BeginCreate;
  inherited;
  FRender := TLMDHTMLRender.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
  FRender.OnImageNeededEx := TriggerImageNeededExEvent;
  FRender.OnVariableNeeded := TriggerVariableNeededEvent;
  FRender.OnTagFound := TriggertagFoundEvent;

  FCheck:=True;
  OwnerDraw := true;
  FIntPaint := true;
  AlwaysPaintBackground := true;
  FLinkColor := def_LMDLinkColor;
  FLinkStyle := def_LMDLinkStyle;

  // RM
  FChangeLink:=TELHTMLChangeLink.Create;
  FChangeLink.OnChange:=DoCaptionChange;
  EndCreate;
end;

{ -----------------------------------------------------------------------------}
destructor TCustomElHTMLPanel.Destroy;
begin
  FreeAndNil(FChangeLink);
  FreeAndNil(FRender);
  inherited;
end;

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

{ -----------------------------------------------------------------------------}
procedure TCustomElHTMLPanel.TriggerTagFoundEvent(Sender: TObject;
  var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing,
  aSupported: boolean);
begin
  if Assigned(FOnTagFound) then
    FOnTagFound(Self, Tag, Item, Params, aClosing, aSupported);
end;

end.
