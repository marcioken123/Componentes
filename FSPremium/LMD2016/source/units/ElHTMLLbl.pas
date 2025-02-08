unit ElHTMLLbl;
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

ElHTMLLbl unit
--------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Graphics, Controls, StdCtrls, Forms, Menus, Classes,
  SysUtils, Types,

  LMDHTMLUnit,
  LMDTypes,
  LMDProcs,
  LMDGraphUtils,
  LMDUtils,
  LMDThemes,

  ElVCLUtils,
  ElCLabel,
  ElXPThemedControl,
  ElHTMLContainer;

type

  TElHTMLLabel = class(TCustomElLabel)
  private
    FAlreadyInSetBounds: Boolean;
    // Container support ElPack 5
    FContainer:TElHTMLContainer;
    FIndex:Integer;
    FChangeLink:TElHTMLChangeLink;
    FCheck:Boolean;
    // ----------------
    FCursor : TCursor;
    FRender : TLMDHTMLRender;
    FIsHTML : Boolean;
    FOnLinkClick : TElHTMLLinkClickEvent;
    FOnImageNeeded : TElHTMLImageNeededEvent;
    FOnImageNeededEx: TLMDHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FOnTagFound: TLMDHTMLTagFoundEvent;
    FLinkColor: TColor;
    FLinkPopupMenu: TPopupMenu;
    FLinkStyle: TFontStyles;
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    procedure DoCaptionChange(Sender: TObject);
    procedure SetCursor(newValue : TCursor);
    procedure SetLinkPopupMenu(newValue : TPopupMenu);
    procedure SetContainer(aValue: TElHTMLContainer);
    procedure SetIndex(aValue: Integer);
    procedure SetIsHTML(newValue : Boolean);
    procedure SetLinkColor(newValue : TColor);
    procedure SetLinkStyle(newValue : TFontStyles);
    procedure SetWordWrap(newValue : Boolean);
    function GetPlainText: TLMDString;
    function GetCaptionText: TLMDString;
    function GetWordWrap : Boolean;

    procedure CMTextChanged(var Msg : TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Msg : TMessage); message CM_FONTCHANGED;
    procedure CMMouseLeave(var Msg : TMessage); message CM_MOUSELEAVE;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMContextMenu(var Message: TWMContextMenu); message WM_CONTEXTMENU;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;

  protected
    procedure AdjustBounds;override;
    function CalcTextRect: TRect;
    procedure Click; override;
    procedure DoDrawText(var Rect: TRect; Flags: Longint);override;
    procedure DoLinkPopup(MousePos : TPoint);
    // RM
    function  GetEmpty:Boolean;
    function  LinkEmpty:Boolean;
    // --
    function GetTextRect : TRect;
    procedure Loaded; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Notification(AComponent : TComponent; operation : TOperation); override;
    procedure SetAutoSize(newValue : Boolean); override;
    procedure SetName(const Value: TComponentName); override;
    procedure TriggerLinkClickEvent(HRef : TLMDString); virtual;
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image : TBitmap);
    procedure TriggerImageNeededExEvent(Sender : TObject; Src : TLMDString; Image : TPicture);
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString);        
    procedure TriggerRenderChange(Sender : TObject);
    procedure TriggerTagFoundEvent(Sender : TObject; var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing:boolean; aSupported: boolean);
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    {$endif}
    public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); override;
    property TextRect : TRect read GetTextRect;
    property PlainText: TLMDString read GetPlainText;
  published
    // RM
    property Container:TElHTMLContainer read FContainer write SetContainer;
    property ContainerIndex:Integer read FIndex write SetIndex default 0;
    property CheckContainerLinks:Boolean read FCheck write FCheck default true;
    // ----

    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property Cursor   : TCursor read FCursor write SetCursor default crDefault;  { Published }
    property IsHTML   : Boolean read FIsHTML write SetIsHTML default true;  { Published }
    property WordWrap : Boolean read GetWordWrap write SetWordWrap  default False;  { Published }
    property LinkColor: TColor read FLinkColor write SetLinkColor default clBlue;
    property LinkPopupMenu: TPopupMenu read FLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read FLinkStyle write SetLinkStyle default def_LMDLinkStyle;

    property OnLinkClick : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnImageNeeded : TElHTMLImageNeededEvent read FOnImageNeeded write FOnImageNeeded;
    property OnImageNeededEx : TLMDHTMLImageNeededEvent read FOnImageNeededEx write FOnImageNeededEx;
    property OnVariableNeeded : TLMDHTMLVariableNeededEvent read FOnVariableNeeded write FOnVariableNeeded;
    property OnTagFound : TLMDHTMLTagFoundEvent read FOnTagFound write FOnTagFound;

    property EndEllipsis;

    property Align;
    property Alignment;
    property AutoSize;
    property Anchors;
    property BiDiMode;
    property Color nodefault;
    property Constraints;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentBiDiMode;

    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Transparent;
    property Layout;
    property Visible;
    property ShowAccelChar;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnEndDock;
    property OnStartDock;

    property OnStartDrag;
  end;  { TElHTMLLabel }

implementation

{------------------------------------------------------------------------------}
procedure TElHTMLLabel.AdjustBounds;
begin
  if FIsHTML then
    begin
      if (not (csLoading in ComponentState)) and AutoSize then
      begin
        if (FRender.Data.TextSize.CX = 0) and (not FAlreadyInSetBounds) then
          DoCaptionChange(Self);
        SetBounds(Left, Top, FRender.Data.TextSize.CX + BorderWidth * 2, FRender.Data.TextSize.CY + BorderWidth * 2);
      end;
    end
  else
    inherited;
end;

procedure TElHTMLLabel.SetIsHTML(newValue : Boolean);
begin
  if (FIsHTML <> newValue) then
    begin
      FIsHTML := newValue;
      DoCaptionChange(nil);
    end;  { if }
end;  { SetIsHTML }

procedure TElHTMLLabel.DoDrawText;
var
  Text: TLMDString;
begin
  if not Visible then //VB Mar 2009
    exit;
  // RM
  Text := GetCaptionText;
  // ----

  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or (ShowAccelChar and
     (Text[1] = '&') and (Text[2] = #0))) then
    Text := Text + ' ';
  if not ShowAccelChar then
    Flags := Flags or DT_NOPREFIX;

  if EndEllipsis then
    Flags := Flags or DT_END_ELLIPSIS;

  Flags := DrawTextBiDiModeFlags(Flags);
  Canvas.Font := Font;
  if not Enabled then
    begin
      OffsetRect(Rect, 1, 1);
      Canvas.Font.Color := clBtnHighlight;
      LMDDrawText(Canvas.Handle, Text, Length(Text), Rect, Flags);
      OffsetRect(Rect, -1, -1);
      Canvas.Font.Color := clBtnShadow;
      LMDDrawText(Canvas.Handle, Text, Length(Text), Rect, Flags);
    end
  else
    LMDDrawText(Canvas.Handle, Text, Length(Text), Rect, Flags);
end;

procedure TElHTMLLabel.Paint;  { public }
var R, RB : TRect;
  OldP, P : TPoint;
    Bmp   : TBitmap;
    ARect : TRect;
begin
  if not IsHTML then
    inherited
  else
    begin
      Canvas.Font := Font;
      with Canvas do
        begin
          if IsThemed then
            begin
              // copy parent's background
              P := Point(Left, Top);
              SetMapMode(Canvas.Handle, MM_ANISOTROPIC);
              SetViewPortOrgEx(Canvas.Handle, -P.x, -P.y, @OldP);
              SendMessage(Parent.Handle, WM_ERASEBKGND, Self.Canvas.Handle, Self.Canvas.Handle);
              SetViewPortOrgEx(Canvas.Handle, OldP.x, OldP.y, nil);
              SetMapMode(Self.Canvas.Handle, MM_TEXT);
              ARect := ClientRect;
              InflateRect(ARect, -BorderWidth, -BorderWidth);
              //bitblt(FBuffer.Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top, Self.Canvas.Handle, ARect.Left, ARect.Top, SRCCOPY);
            end
          else
            begin
              if not Transparent then
                begin
                  Brush.Color := Self.Color;
                  Brush.Style := bsSolid;
                  FillRect(ClientRect);
                end;
            end;
          Brush.Style := bsClear;
        end;
        if Layout = tlCenter then
          begin
            LMDCenterRects(ClientWidth - BorderWidth * 2, ClientWidth - BorderWidth * 2, FRender.Data.TextSize.cy, ClientHeight - BorderWidth * 2, R);
            OffsetRect(R, BorderWidth, BorderWidth);
          end
        else
          if Layout = tlBottom then
            begin
              R := ClientRect;
              InflateRect(R, -BorderWidth, -BorderWidth);
              R.Top := R.Bottom - 1 - FRender.Data.TextSize.cy;
            end
          else
            begin
              R := ClientRect;
              InflateRect(R, -BorderWidth, -BorderWidth);
            end;
      if Alignment = taRightJustify then
        begin
          R.Right := ClientWidth - BorderWidth;
          R.Left := R.Right - FRender.Data.TextSize.cx;
        end
      else
        if Alignment = taCenter then
          begin
            R.Left := (ClientWidth - FRender.Data.TextSize.cx) div 2;
            R.Right := R.Left + FRender.Data.TextSize.cx;
          end;
      Bmp := TBitmap.Create;
      try
        Bmp.Handle := CreateCompatibleBitmap(Canvas.Handle, R.Right - R.Left, R.Bottom - R.Top);
        bitblt(Bmp.Canvas.Handle, 0, 0, R.Right - R.Left, R.Bottom - R.Top, Canvas.Handle, R.Left, R.Top, SRCCOPY);
        RB := R;
        OffsetRect(RB, -RB.Left, -RB.Top);
        if RectVisible(bmp.Canvas, RB) then
        begin
          if Enabled then
             FRender.DrawText(Bmp.Canvas, Point(0, 0), RB, clNone)
           else
             FRender.DrawTextEx(Bmp.Canvas, Point(0, 0), RB, True, clGrayText, clNone, clNone, clNone, clBlack);
          bitblt(Canvas.Handle, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
        end;
      finally
        Bmp.Free;
      end;
    end;
end;  { Paint }

{ Event triggers: }
procedure TElHTMLLabel.TriggerLinkClickEvent(HRef : TLMDString);
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
  if Assigned(FOnLinkClick) then FOnLinkClick(Self, HRef );
end;  { TriggerLinkClickEvent }

procedure TElHTMLLabel.TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; var Image : TBitmap);
begin
  Image := nil;
  if (assigned(FOnImageNeeded)) then FOnImageNeeded(Self, Src, Image);
end;  { TriggerImageNeededEvent }

procedure TElHTMLLabel.Loaded;
begin
  inherited Loaded;
  DoCaptionChange(nil);
end;    { Loaded }

procedure TElHTMLLabel.CMTextChanged(var Msg : TMessage);
begin
  inherited;
  if FIsHTML then
    begin
      FIsHTML := false;
      IsHTML  := true;
    end;
end;  { CMTextChanged }

procedure TElHTMLLabel.CMMouseLeave(var Msg : TMessage);  { private }
begin
  inherited Cursor := FCursor;
  inherited;
end;  { CMMouseLeave }

procedure TElHTMLLabel.SetCursor(newValue : TCursor);
var P : TPoint;
    R : TRect;
    href : TLMDString;
begin
  if (FCursor <> newValue) then
  begin
    FCursor := newValue;
    GetCursorPos(P);
    P := ScreenToClient(P);
    R := CalcTextRect;
    if IsHTML then
    begin
      if FRender.IsCursorOverLink(P, Point(0, 0), R, href) then
        inherited Cursor := crHandPoint
      else
        inherited Cursor := FCursor;
    end
    else
      inherited Cursor := FCursor;
  end;  { if }
end;  { SetCursor }

procedure TElHTMLLabel.MouseMove(Shift: TShiftState; X, Y: Integer);  { protected }
var href : TLMDString;
    R    : TRect;
begin
  if IsHTML then
    begin
      R := CalcTextRect;
      if IsHTML then
        if FRender.IsCursorOverLink(Point(X - R.Left - BorderWidth, Y - R.Top - BorderWidth), Point(0, 0), R, href) then
          inherited Cursor := crHandPoint
        else
        begin
          inherited Cursor := FCursor;
          FRender.MouseMoveTransfer(Shift, X, Y, R);
        end
      else
        inherited Cursor := FCursor;
    end;
  inherited MouseMove(Shift, X, Y);
end;  { MouseMove }

procedure TElHTMLLabel.CMFontChanged(var Msg : TMessage);  { private }
begin
  inherited;
  {if FIsHTML then} DoCaptionChange(nil);
end;  { CMFontChanged }

procedure TElHTMLLabel.Click;
var P : TPoint;
    R : TRect;
    href : TLMDString;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if IsHTML then
    begin
      R := CalcTextRect;

      dec(P.x, R.Left + BorderWidth);
      dec(P.y, R.Top + BorderWidth);
      if IsHTML then
      begin
        if FRender.IsCursorOverLink(P, Point(0, 0), R, href) then
         TriggerLinkClickEvent(href)
        else
          FRender.ClickTransfer(P.X, P.Y, R);
      end
      else
        inherited;
    end
  else
    inherited;
end;  { Click }

function TElHTMLLabel.GetWordWrap : Boolean;
{ Returns the value for the WordWrap property. }
begin
  result := inherited WordWrap;
end;  { GetWordWrap }

procedure TElHTMLLabel.SetWordWrap(newValue : Boolean);
{ Sets the value for the WordWrap property. }
begin
  if WordWrap <> newValue then
  begin
    inherited WordWrap := newValue;
    DoCaptionChange(nil);
  end;
end;  { SetWordWrap }

function TElHTMLLabel.GetTextRect : TRect;
var S : TSize;
    AL: integer;
begin
  if IsHTML then
    begin
      S := FRender.Data.TextSize;
      result := Rect(0, 0, S.cx, S.cy);
    end
  else
    begin
      Canvas.Font.Assign(Font);
      if WordWrap then
        AL := DT_WORDBREAK
      else
        AL := 0;
      {$ifdef LMD_UNICODE}
      SetRectEmpty(Result);
      {$endif}
      LMDDrawText(Canvas.Handle, Caption, Length(Caption), Result, DT_EXPANDTABS or DT_CALCRECT or AL
        or DrawTextBiDiModeFlagsReadingOnly);
    end;
end;

procedure TElHTMLLabel.SetAutoSize(newValue : Boolean);
{ Sets the value for the AutoSize property. }
begin
  if inherited AutoSize <> newValue then
  begin
    inherited SetAutoSize(newValue);
    DoCaptionChange(nil);
    if FIsHTML then
      begin
        if newValue then
          begin
            inherited SetAutoSize(false);
            inherited SetAutoSize(true);
          end;
      end;
  end;
end;  { SetAutoSize }

constructor TElHTMLLabel.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  //ControlStyle := ControlStyle - [csSetCaption];
  FRender := TLMDHTMLRender.Create;
  FRender.OnImageNeeded := TriggerImageNeededEvent;
  FRender.OnImageNeededEx := TriggerImageNeededExEvent;
  FRender.OnVariableNeeded := TriggerVariableNeededEvent;  
  FRender.OnTagFound := TriggerTagFoundEvent;

  FRender.OnChange := TriggerRenderChange;
  FRender.Control := Self;

  FIsHTML:=True;
  FLinkColor := def_LMDLinkColor;
  FLinkStyle := def_LMDLinkStyle;

  FAlreadyInSetBounds := False;

  // RM
  FChangeLink:=TELHTMLChangeLink.Create;
  FChangeLink.OnChange:=DoCaptionChange;
  FCheck:=True;
end;  { Create }

destructor TElHTMLLabel.Destroy;
begin
  FreeAndNil(FChangeLink);
  FreeAndNil(FRender);
  inherited Destroy;
end;  { Destroy }

procedure TElHTMLLabel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited;
  if WordWrap and IsHTML and (not FAlreadyInSetBounds) then
    DoCaptionChange(nil);
end;  { WMSize }

procedure TElHTMLLabel.SetLinkColor(newValue : TColor);
{ Sets data member FLinkColor to newValue. }
begin
  if (FLinkColor <> newValue) then
    begin
      FLinkColor := newValue;
      if IsHTML then DoCaptionChange(nil);
    end;  { if }
end;  { SetLinkColor }

procedure TElHTMLLabel.SetLinkPopupMenu(newValue : TPopupMenu);
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

procedure TElHTMLLabel.SetLinkStyle(newValue : TFontStyles);
{ Sets data member FLinkStyle to newValue. }
begin
  if (FLinkStyle <> newValue) then
    begin
      FLinkStyle := newValue;
      if IsHTML then DoCaptionChange(nil);
    end;  { if }
end;  { SetLinkStyle }

procedure TElHTMLLabel.WMRButtonUp(var Message: TWMRButtonUp);
var P : TPoint;
    R : TRect;
    href : TLMDString;
begin
  P := SmallPointToPoint(Message.Pos);
  P := Point(P.X - BorderWidth, P.Y - BorderWidth);

  R := CalcTextRect;
  if IsHTML and (LinkPopupMenu <> nil) and FRender.IsCursorOverLink(P, Point(0, 0), ClientRect, href) then
    begin
      if not (csNoStdEvents in ControlStyle) then
        with Message do
          MouseUp(mbRight, KeysToShiftState(Keys), XPos, YPos);
      if Message.Result = 0 then
        begin
          P := Point(P.X + BorderWidth, P.Y + BorderWidth);
          DoLinkPopup(P);
        end;
    end
  else
    inherited;
end;

procedure TElHTMLLabel.DoLinkPopup(MousePos : TPoint);
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

procedure TElHTMLLabel.WMContextMenu(var Message: TWMContextMenu);
var
  Pt, Temp: TPoint;
  Handled: Boolean;
  href : TLMDString;
begin
  if Message.Result <> 0 then Exit;
  if csDesigning in ComponentState then Exit;

  Pt := ScreenToClient(SmallPointToPoint(Message.Pos));
  Pt := Point(Pt.X - BorderWidth, Pt.Y - BorderWidth);

  if IsHTML and (LinkPopupMenu <> nil) and FRender.IsCursorOverLink(Pt, Point(0, 0), ClientRect, href) then
    begin
      Pt := Point(Pt.X + BorderWidth, Pt.Y + BorderWidth);
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

function TElHTMLLabel.CalcTextRect: TRect;
begin
  if Layout = tlCenter then
    begin
      LMDCenterRects(ClientWidth, ClientWidth, FRender.Data.TextSize.cy, ClientHeight, Result);
    end
  else
    if Layout = tlBottom then
      begin
        Result := ClientRect;
        Result.Top := Result.Bottom - 1 - FRender.Data.TextSize.cy;
      end
    else
      Result := ClientRect;
  if Alignment = taRightJustify then
    begin
      Result.Right := ClientWidth;
      Result.Left := Result.Right - FRender.Data.TextSize.cx;
    end
  else
    if Alignment = taCenter then
      begin
        Result.Left := (ClientWidth - FRender.Data.TextSize.cx) div 2;
        Result.Right := Result.Left + FRender.Data.TextSize.cx;
      end;
end;

{$ifdef LMD_UNICODE}
procedure TElHTMLLabel.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  {$IFNDEF LMD_NATIVEUNICODE}
  LMDConvertVCLHintShow(inherited Hint, FHint, Message);
  {$ENDIF}
end;

procedure TElHTMLLabel.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TElHTMLLabel.SetName(const Value: TComponentName);
var
  ChangeText: Boolean;
begin
  ChangeText := (csSetCaption in ControlStyle) and
    not (csLoading in ComponentState) and (Name = Text) and
    ((Owner = nil) or not (Owner is TControl) or
    not (csLoading in TControl(Owner).ComponentState));
  inherited SetName(Value);
  if ChangeText then
    Caption := Value;
end;

function TElHTMLLabel.GetPlainText: TLMDString;
begin
  if not IsHTML then
    Result := Caption
  else
    Result := FRender.AsText;
end;

// RM
{ ---------------------------------------------------------------------------- }
procedure TElHTMLLabel.SetContainer(aValue:TElHTMLContainer);
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

{ ---------------------------------------------------------------------------- }
procedure TElHTMLLabel.SetIndex(aValue:Integer);
begin
  if aValue<>FIndex then
    begin
      FIndex:=aValue;
      if Assigned(FContainer) then DoCaptionChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElHTMLLabel.Notification(AComponent : TComponent; operation : TOperation);
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

{ ---------------------------------------------------------------------------- }
function TElHTMLLabel.GetCaptionText: TLMDString;
begin
  if LinkEmpty then
    result:=FCaption
  else
    result:=FContainer.Items[FIndex].Caption;
end;

{------------------------------------------------------------------------------}
function TElHTMLLabel.GetEmpty:Boolean;
begin
  result:=Transparent and (GetLabelText='');
end;

{ ---------------------------------------------------------------------------- }
function  TElHTMLLabel.LinkEmpty:Boolean;
begin
  result:=not ((FContainer<>nil) and (FIndex<FContainer.Count));
end;

{ ---------------------------------------------------------------------------- }
procedure TElHTMLLabel.DoCaptionChange (Sender: TObject);
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  Rect: TRect;
begin
  if csLoading in ComponentState then exit;
  if FIsHTML then
    begin
      FRender.Data.DefaultStyle := Font.Style;
      FRender.Data.DefaultFont  := Font.Name;
      FRender.Data.Charset      := Font.Charset;
      FRender.Data.DefaultColor := Font.Color;
      FRender.Data.DefaultHeight:= Font.Height;
      FRender.Data.LinkColor    := LinkColor;
      FRender.Data.LinkStyle    := LinkStyle;
      if WordWrap then
      begin
        FRender.PrepareText(GetCaptionText, Width - BorderWidth * 2, True);
        FAlreadyInSetBounds := True;
        AdjustBounds;
        FAlreadyInSetBounds := False;
      end
      else
      begin
        FRender.PrepareText(GetCaptionText, Width - BorderWidth * 2, False);
        FAlreadyInSetBounds := True;
        if AutoSize then
          AdjustBounds;
        FAlreadyInSetBounds := False;
      end;
    end
  else
    if AutoSize then
      AdjustBounds
    else
    begin
      Rect := ClientRect;
      DoDrawText(Rect, WordWraps[WordWrap])
    end;
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TElHTMLLabel.CMEnabledChanged(var Message: TMessage);
begin
  DoCaptionChange(nil);
end;

procedure TElHTMLLabel.TriggerRenderChange(Sender: TObject);
begin
  Invalidate;
end;

{ ---------------------------------------------------------------------------- }
procedure TElHTMLLabel.TriggerImageNeededExEvent(Sender: TObject;
  Src: TLMDString; Image: TPicture);
begin
  if (Assigned(FOnImageNeededEx)) then
    FOnImageNeededEx(Self, Src, Image);
end;

{ ---------------------------------------------------------------------------- }
procedure TElHTMLLabel.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

{ ---------------------------------------------------------------------------- }
procedure TElHTMLLabel.TriggerTagFoundEvent(Sender: TObject;
  var Tag: TLMDString; var Item: TLMDHTMLItem; var Params: TLMDMemoryStrings; aClosing,
  aSupported: boolean);
begin
  if Assigned(FOnTagFound) then
    FOnTagFound(Self, Tag, Item, Params, aClosing, aSupported);
end;

end.
