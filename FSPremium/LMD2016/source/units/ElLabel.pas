unit ElLabel;
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

ElLabel unit
------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, StdCtrls, Messages, Controls, Forms, SysUtils,
  Types, UxTheme, Themes,

  ElCLabel, ElXPThemedControl,

  {$ifdef LMD_ELUNISCRIBE}LMDUsp10, LMDUniscribeStrings, {$ENDIF}
  LMDTypes, LMDThemes, LMDGraphUtils;

type
  TElLabelTextStyle = (ltsNormal, ltsEmbossed, ltsRecessed, ltsOutlined);
  TElLabelEffectStyle = (lesNone, lesShadow, lesExtrude);
  TElLabelExtrudePosition = (lepLeft, lepLeftTop, lepTop, lepRightTop, lepRight,
    lepRightBottom, lepBottom, lepLeftBottom);

  TElLabel = class(TCustomElLabel)
  private
    FAngle: integer;
    FBuffer: TBitmap;
    FDarkColor: TColor;
    FDepth: integer;
    FDisabledDarkColor: TColor;
    FDisabledLightColor: TColor;
    FEffect: TElLabelEffectStyle;
    FFarColor: TColor;
    FLightColor: TColor;
    FNearColor: TColor;
    FOutlineColor: TColor;
    FPosition: TElLabelExtrudePosition;
    FShadowColor: TColor;
    FStriated: boolean;
    FStyle: TElLabelTextStyle;
    FXOffset: integer;
    FYOffset: integer;
    {$ifdef LMD_UNICODE}
    {$ifdef LMD_ELUNISCRIBE}
    FUniscribeString: TLMDUniscribeStrings;
    {$endif}
    {$endif}
    procedure SetAngle(Value: integer);
    procedure SetDarkColor(const Value: TColor);
    procedure SetDepth(const Value: integer);
    procedure SetDisabledDarkColor(const Value: TColor);
    procedure SetDisabledLightColor(const Value: TColor);
    procedure SetEffect(const Value: TElLabelEffectStyle);
    procedure SetExtrudePosition(const Value: TElLabelExtrudePosition);
    procedure SetFarColor(const Value: TColor);
    procedure SetLightColor(const Value: TColor);
    procedure SetNearColor(const Value: TColor);
    procedure SetOutlineColor(const Value: TColor);
    procedure SetShadowColor(const Value: TColor);
    procedure SetStriated(const Value: boolean);
    procedure SetStyle(const Value: TElLabelTextStyle);
    procedure SetXOffset(const Value: integer);
    procedure SetYOffset(const Value: integer);
  protected
    procedure DoDrawText(var Rect: TRect; Flags: longint);override;

    procedure DrawDisabledText(Canvas: TCanvas; var Rect: TRect; Text: TLMDString;
        Flags: longint); virtual;
    procedure DrawEffect(Canvas: TCanvas; var Rect: TRect; Flags: longint); dynamic;
    procedure DrawExtrusion(Canvas: TCanvas; var Rect: TRect; Text: TLMDString;
        Flags: longint; NearColor, FarColor: TColor);
    procedure DrawNormalText(Canvas: TCanvas; var Rect: TRect; Text: TLMDString;
        Flags: longint);
    procedure DrawOutlinedText(Canvas: TCanvas; var Rect: TRect; Text: TLMDString;
        Flags: longint; OutlineColor: TColor);
    procedure DrawRaisedText(Canvas: TCanvas; var Rect: TRect; Text: TLMDString;
        Flags: longint; LeftTop, RightBottom: TColor);
    procedure DrawShadow(Canvas: TCanvas; var Rect: TRect; Text: TLMDString; Flags:
        longint; X, Y: integer; ShadowColor: TColor);
    procedure DrawText(Canvas: TCanvas; var Rect: TRect; Flags: longint); dynamic;
    procedure Paint; override;

    procedure SetName(const Value: TComponentName); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    property Angle: integer read FAngle write SetAngle default 0;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property DarkColor: TColor read FDarkColor write SetDarkColor default clBtnShadow;
    property Depth: integer read FDepth write SetDepth default 10;
    property DisabledDarkColor: TColor read FDisabledDarkColor write SetDisabledDarkColor default clBtnShadow;
    property DisabledLightColor: TColor read FDisabledLightColor write SetDisabledLightColor default clBtnHighlight;
    property Effect: TElLabelEffectStyle read FEffect write SetEffect default lesNone;
    property ExtrudePosition: TElLabelExtrudePosition read FPosition write SetExtrudePosition default lepRightBottom;
    property FarColor: TColor read FFarColor write SetFarColor default clBlack;
    property LightColor: TColor read FLightColor write SetLightColor default clBtnHighlight;
    property NearColor: TColor read FNearColor write SetNearColor default clBlack;
    property OutlineColor: TColor read FOutlineColor write SetOutlineColor default clWhite;
    property ShadowColor: TColor read FShadowColor write SetShadowColor default clBtnShadow;
    property Striated: boolean read FStriated write SetStriated default False;
    property Style: TElLabelTextStyle read FStyle write SetStyle default ltsNormal;
    property XOffset: integer read FXOffset write SetXOffset default 2;
    property YOffset: integer read FYOffset write SetYOffset default 2;
    property Transparent default true;
    property EndEllipsis;

    property Align;
    property Alignment;
    property AutoSize;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property Color;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Layout;
    property Visible;
    property WordWrap;

    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnStartDock;
    property OnStartDrag;

  end;

implementation

{ TElLabel }

constructor TElLabel.Create(AOwner: TComponent);
begin
  inherited;
  FAngle := 0;
  FDarkColor := clBtnShadow;
  FDepth := 10;
  FDisabledDarkColor := clBtnShadow;
  FDisabledLightColor := clBtnHighlight;
  FEffect := lesNone;
  FFarColor := clBlack;
  FLightColor := clBtnHighlight;
  FNearColor := clBlack;
  FOutlineColor := clWhite;
  FPosition := lepRightBottom;
  FShadowColor := clBtnShadow;
  FStriated := False;
  FStyle := ltsNormal;
  FXOffset := 2;
  FYOffset := 2;
  Transparent := true;
  {$ifdef LMD_UNICODE}
  {$ifdef LMD_ELUNISCRIBE}
  FUniscribeString := TLMDUniscribeStrings.Create;
  {$endif}
  {$endif}
end;

destructor TElLabel.Destroy;
begin
  {$ifdef LMD_UNICODE}
  {$ifdef LMD_ELUNISCRIBE}
  FreeAndNil(FUniscribeString);
  {$endif}
  {$endif}
  FreeAndNil(FBuffer);
  inherited;
end;

procedure TElLabel.DoDrawText(var Rect: TRect; Flags: longint);
var
  EffectRect, TextRect: TRect;
begin
  if FEffect <> lesNone then
  begin
    EffectRect := Rect;
    if DT_CALCRECT and Flags = 0 then
      DrawEffect(FBuffer.Canvas, EffectRect, Flags)
    else
      DrawEffect(Canvas, EffectRect, Flags);
  end;
  TextRect := Rect;
  if DT_CALCRECT and Flags = 0 then
    DrawText(FBuffer.Canvas, TextRect, Flags)
  else
    DrawText(Canvas, TextRect, Flags);
  if FEffect <> lesNone then
    UnionRect(Rect, TextRect, EffectRect)
  else
    Rect := TextRect;
end;

procedure TElLabel.DrawDisabledText(Canvas: TCanvas; var Rect: TRect; Text:
    TLMDString; Flags: longint);
begin
  if DT_CALCRECT and Flags <> 0 then
    LMDDrawText(Canvas.Handle, Text, Length(Text), Rect, Flags)
  else
  begin
    if IsThemed then
      LMDThemeServices.DrawThemeText(UseThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(tbCheckBoxUncheckedDisabled), Text, Length(WideString(Text)), Flags, DTT_GRAYED, Rect)
    else
    begin
      Canvas.Font.Color := clBtnHighlight;
      OffsetRect(Rect, 1, 1);
      LMDDrawText(Canvas.Handle, Text, Length(Text), Rect, Flags);
      Canvas.Font.Color := clBtnShadow;
      OffsetRect(Rect, -1, -1);
      LMDDrawText(Canvas.Handle, Text, Length(Text), Rect, Flags)
    end;
  end;
end;

procedure TElLabel.DrawEffect(Canvas: TCanvas; var Rect: TRect; Flags: longint);
var
  Text: TLMDString;
begin
  Text := Caption;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;

  Flags := DrawTextBiDiModeFlags(Flags);

  Canvas.Font := Font;
  case FEffect of
    lesShadow : DrawShadow(Canvas, Rect, Text, Flags, FXOffset, FYOffset, FShadowColor);
    lesExtrude: DrawExtrusion(Canvas, Rect, Text, Flags, FNearColor, FFarColor);
  end;
end;

procedure TElLabel.DrawExtrusion(Canvas: TCanvas; var Rect: TRect; Text:
    TLMDString; Flags: longint; NearColor, FarColor: TColor);
const
  XOffsets: array [TElLabelExtrudePosition] of shortint =
    (-1, -1, 0, 1, 1, 1, 0, -1);
  YOffsets: array [TElLabelExtrudePosition] of shortint =
    (0, -1, -1, -1, 0, 1, 1, 1);
var
  CalcRect, R: TRect;
  NearR, NearG, NearB, FarR, FarG, FarB: byte;
  I: integer;
begin
  if DT_CALCRECT and Flags <> 0 then
  begin
    CalcRect := Rect;
    LMDDrawText(Canvas.Handle, Text, Length(Text), CalcRect, Flags);
    R := CalcRect;
    OffsetRect(R, XOffsets[FPosition] * FDepth, YOffsets[FPosition] * FDepth);
    UnionRect(Rect, CalcRect, R);
  end
  else begin
    NearColor := ColorToRGB(NearColor);
    FarColor := ColorToRGB(FarColor);
    NearR := GetRValue(NearColor); NearG := GetGValue(NearColor); NearB := GetBValue(NearColor);
    FarR := GetRValue(FarColor); FarG := GetGValue(FarColor); FarB := GetBValue(FarColor);
    for I := FDepth downto 1 do
    begin
      R := Rect;
      OffsetRect(R, XOffsets[FPosition] * I, YOffsets[FPosition] * I);
      if not FStriated then
        Canvas.Font.Color := RGB(
          Round(NearR + ((FarR - NearR) / (FDepth / I))),
          Round(NearG + ((FarG - NearG) / (FDepth / I))),
          Round(NearB + ((FarB - NearB) / (FDepth / I))))
      else
        Canvas.Font.Color := RGB(
          I * (NearR + ((FarR - NearR) div FDepth)) div (Ord(I mod 2 = 0) * 3 + 1),
          I * (NearG + ((FarG - NearG) div FDepth)) div (Ord(I mod 2 = 0) * 3 + 1),
          I * (NearB + ((FarB - NearB) div FDepth)) div (Ord(I mod 2 = 0) * 3 + 1));
      LMDDrawText(Canvas.Handle, Text, Length(Text), R, Flags);
    end;
  end;
end;

procedure TElLabel.DrawNormalText(Canvas: TCanvas; var Rect: TRect; Text: TLMDString; Flags: longint);
{$ifdef LMD_UNICODE}
{$ifdef LMD_ELUNISCRIBE}
var
  FPlainText: TLMDString;
{$endif}
{$endif}
begin
  {$ifdef LMD_UNICODE}
  {$ifdef LMD_ELUNISCRIBE}
  FUniscribeString.Text := Text;
  FPlainText := FUniscribeString.PlainText;
  if ScriptIsComplex(PWideChar(FPlainText), Length(FPlainText), SIC_COMPLEX) = S_FALSE then
  begin
  {$endif}
  {$endif}
    LMDDrawText(Canvas.Handle, Text, Length(Text), Rect, Flags);
  {$ifdef LMD_UNICODE}
  {$ifdef LMD_ELUNISCRIBE}
  end
  else
  begin
//    if WordWrap {and not ((Flags and DT_CALCRECT) = DT_CALCRECT)} then
    FUniscribeString.PrepareText(Canvas,Width, WordWrap);
    FUniscribeString.DrawText(Canvas, Rect, Flags);
  end;
  {$endif}
  {$endif}
end;

procedure TElLabel.DrawOutlinedText(Canvas: TCanvas; var Rect: TRect; Text:
    TLMDString; Flags: longint; OutlineColor: TColor);
const
  XOffsets: array [0..3] of integer = (-1, -1, 1, 1);
  YOffsets: array [0..3] of integer = (-1, 1, -1, 1);
var
  R: TRect;
  I: integer;
begin
  if DT_CALCRECT and Flags <> 0 then
  begin
    R := Rect;
    LMDDrawText(Canvas.Handle, Text, Length(Text), R, Flags)
  end;
  Canvas.Font.Color := OutlineColor;
  for I := Low(XOffsets) to High(XOffsets) do
  begin
    R := Rect;
    OffsetRect(R, XOffsets[I], YOffsets[I]);
    LMDDrawText(Canvas.Handle, Text, Length(Text), R, Flags);
  end;
  Canvas.Font.Color := Font.Color;
// check here  
//  {$ifdef LMD_UNICODE}
//  Windows.DrawTextW(Canvas.Handle, PWideChar(Text), Length(Text), Rect, Flags);
//  {$else}
//  Windows.DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
//  {$endif}
  LMDDrawText(Canvas.Handle, Text, Length(Text), Rect, Flags);
  if DT_CALCRECT and Flags <> 0 then InflateRect(Rect, 1, 1);
end;

procedure TElLabel.DrawRaisedText(Canvas: TCanvas; var Rect: TRect; Text:
    TLMDString; Flags: longint; LeftTop, RightBottom: TColor);
var
  R: TRect;
begin
  if DT_CALCRECT and Flags <> 0 then
  begin
    R := Rect;
    LMDDrawText(Canvas.Handle, Text, Length(Text), R, Flags);
  end;
  R := Rect;
  Canvas.Font.Color := LeftTop;
  OffsetRect(R, -1, -1);
  LMDDrawText(Canvas.Handle, Text, Length(Text), R, Flags);
  Canvas.Font.Color := RightBottom;
  OffsetRect(R, 2, 2);
  LMDDrawText(Canvas.Handle, Text, Length(Text), R, Flags);
  Canvas.Font.Color := Font.Color;
  LMDDrawText(Canvas.Handle, Text, Length(Text), Rect, Flags);
  if DT_CALCRECT and Flags <> 0 then InflateRect(Rect, 1, 1);
end;

procedure TElLabel.DrawShadow(Canvas: TCanvas; var Rect: TRect; Text:
    TLMDString; Flags: longint; X, Y: integer; ShadowColor: TColor);
begin
  OffsetRect(Rect, X, Y);
  Canvas.Font.Color := ShadowColor;
  LMDDrawText(Canvas.Handle, Text, Length(Text), Rect, Flags)
end;

procedure TElLabel.DrawText(Canvas: TCanvas; var Rect: TRect; Flags: longint);
var
  Text: TLMDString;
begin
  Text := Caption;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  if EndEllipsis then
    Flags := Flags or DT_END_ELLIPSIS;

  Flags := DrawTextBiDiModeFlags(Flags);

  Canvas.Font := Font;
  if Enabled then
    case FStyle of
      ltsNormal  : DrawNormalText(Canvas, Rect, Text, Flags);
      ltsEmbossed: DrawRaisedText(Canvas, Rect, Text, Flags, FLightColor, FDarkColor);
      ltsRecessed: DrawRaisedText(Canvas, Rect, Text, Flags, FDarkColor, FLightColor);
      ltsOutlined: DrawOutlinedText(Canvas, Rect, Text, Flags, FOutlineColor);
    end
  else
    DrawDisabledText(Canvas, Rect, Text, Flags);
end;

procedure TElLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  ARect,
  Rect,
  CalcRect: TRect;
  DrawStyle: longint;
  OldP, P : TPoint;

  {$IFNDEF LMDDISABLE_LMDTHEMES}
//  function ParentIsThemed : boolean;
//  begin
//    result := (SendMessage(Parent.Handle, WM_ISTHEMEDCONTROL, 0, 0) <> 0) or (GetWindowTheme(Parent.Handle) <> 0);
//  end;
  {$ENDIF}
begin
  if FBuffer = nil then
  FBuffer := TBitmap.Create;
  try
    if (FBuffer.Height <> Height) or (FBuffer.Width <> Width) then
    begin
      if (Height > High(Word)) or (Width > High(Word)) then
        exit;      
      {$ifdef LMDCOMP11}
      FBuffer.SetSize(Width, Height);
      {$else}
      FBuffer.Height := Height;
      FBuffer.Width := Width;
      {$endif}
    end;
  with FBuffer.Canvas do
  begin
    if IsThemed and ParentColor{ParentIsThemed }then
    begin
      // copy parent's background
      P := Point(Left, Top);
      SetMapMode(Self.Canvas.Handle, MM_ANISOTROPIC);
      SetViewPortOrgEx(Self.Canvas.Handle, -P.x, -P.y, @OldP);
      SendMessage(Parent.Handle, WM_ERASEBKGND, Self.Canvas.Handle, Self.Canvas.Handle);
      SetViewPortOrgEx(Self.Canvas.Handle, OldP.x, OldP.y, nil);
      SetMapMode(Self.Canvas.Handle, MM_TEXT);
      ARect := ClientRect;
      bitblt(FBuffer.Canvas.Handle, ARect.Left, ARect.Top, ARect.Right - ARect.Left, ARect.Bottom - ARect.Top, Self.Canvas.Handle, ARect.Left, ARect.Top, SRCCOPY);
      Brush.Style := bsClear;
    end
    else
    begin
      if not Transparent then
      begin
        Brush.Color := Self.Color;
        Brush.Style := bsSolid;
        FillRect(ClientRect);
        Brush.Style := bsClear;
      end
      else
      begin
        BitBlt(FBuffer.Canvas.Handle, 0, 0, Width, Height, Canvas.Handle, 0, 0, SRCCOPY);
        Brush.Style := bsClear;
      end;
    end;

    Rect := Self.ClientRect;
    InflateRect(Rect, -BorderWidth, -BorderWidth);
    { DoDrawText takes care of BiDi alignments }
    DrawStyle := DT_EXPANDTABS or WordWraps[WordWrap] or Alignments[Alignment];
    { Calculate vertical layout }
    if Layout <> tlTop then
    begin
      CalcRect := Rect;
      DoDrawText(CalcRect, DrawStyle or DT_CALCRECT);
      if Layout = tlBottom then
        OffsetRect(Rect, 0, Height - CalcRect.Bottom)
      else
        if (Height - CalcRect.Bottom) > 0 then
          OffsetRect(Rect, 0, (Height - CalcRect.Bottom) div 2);
    end;
    DoDrawText(Rect, DrawStyle);
  end;
  BitBlt(Canvas.Handle, 0, 0, Width, Height, FBuffer.Canvas.Handle, 0, 0, SRCCOPY);
  except
    FreeAndNil(FBuffer);
  end;
end;

procedure TElLabel.SetAngle(Value: integer);
begin
  if (Value < 0) or (Value > 359) then
  begin
    Value := Value mod 360;
    if Value < 0 then
      Value := 360 + Value;
  end;
  if FAngle <> Value then
  begin
    FAngle := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TElLabel.SetDarkColor(const Value: TColor);
begin
  if FDarkColor <> Value then
  begin
    FDarkColor := Value;
    if (FStyle = ltsEmbossed) or (FStyle = ltsRecessed) then Invalidate;
  end;
end;

procedure TElLabel.SetDepth(const Value: integer);
begin
  if (FDepth <> Value) and (Value >= 0) then
  begin
    FDepth := Value;
    if FEffect = lesExtrude then
    begin
      AdjustBounds;
      Invalidate;
    end;
  end;
end;

procedure TElLabel.SetDisabledDarkColor(const Value: TColor);
begin
  if FDisabledDarkColor <> Value then
  begin
    FDisabledDarkColor := Value;
    if not Enabled then Invalidate;
  end;
end;

procedure TElLabel.SetDisabledLightColor(const Value: TColor);
begin
  if FDisabledLightColor <> Value then
  begin
    FDisabledLightColor := Value;
    if not Enabled then Invalidate;
  end;
end;

procedure TElLabel.SetEffect(const Value: TElLabelEffectStyle);
begin
  if FEffect <> Value then
  begin
    FEffect := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TElLabel.SetExtrudePosition(const Value: TElLabelExtrudePosition);
begin
  if FPosition <> Value then
  begin
    FPosition := Value;
    if FEffect = lesExtrude then
    begin
      AdjustBounds;
      Invalidate;
    end;
  end;
end;

procedure TElLabel.SetFarColor(const Value: TColor);
begin
  if FFarColor <> Value then
  begin
    FFarColor := Value;
    if FEffect = lesExtrude then Invalidate;
  end;
end;

procedure TElLabel.SetLightColor(const Value: TColor);
begin
  if FLightColor <> Value then
  begin
    FLightColor := Value;
    if (FStyle = ltsEmbossed) or (FStyle = ltsRecessed) then Invalidate;
  end;
end;

procedure TElLabel.SetNearColor(const Value: TColor);
begin
  if FNearColor <> Value then
  begin
    FNearColor := Value;
    if FEffect = lesExtrude then Invalidate;
  end;
end;

procedure TElLabel.SetOutlineColor(const Value: TColor);
begin
  if FOutlineColor <> Value then
  begin
    FOutlineColor := Value;
    if FStyle = ltsOutlined then Invalidate;
  end;
end;

procedure TElLabel.SetShadowColor(const Value: TColor);
begin
  if FShadowColor <> Value then
  begin
    FShadowColor := Value;
    if FEffect = lesShadow then Invalidate;
  end;
end;

procedure TElLabel.SetStriated(const Value: boolean);
begin
  if FStriated <> Value then
  begin
    FStriated := Value;
    if FEffect = lesExtrude then Invalidate;
  end;
end;

procedure TElLabel.SetStyle(const Value: TElLabelTextStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TElLabel.SetXOffset(const Value: integer);
begin
  if FXOffset <> Value then
  begin
    FXOffset := Value;
    if FEffect = lesShadow then Invalidate;
  end;
end;

procedure TElLabel.SetYOffset(const Value: integer);
begin
  if FYOffset <> Value then
  begin
    FYOffset := Value;
    if FEffect = lesShadow then Invalidate;
  end;
end;

procedure TElLabel.SetName(const Value: TComponentName);
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

procedure TElLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
end; { Notification }

end.
