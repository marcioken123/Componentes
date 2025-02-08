{
//
// Components : TwwSpeedButton
//
// Copyright (c) 1998-2001 by Woll2Woll Software
//
// 10/7/98 - Fix paint problem with speedbutton when it is displayed the first time
//
// Enhancement requests
//   Add ability to specify glyph/caption relative positioning.
}

unit wwSpeedButton;

interface

{$i wwIfDef.pas}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  wwCommon, actnlist;

type
  TwwSpeedButton = class;

  TwwDisabledTextColors = class(TPersistent)
  private
    FShadeColor: TColor;
    FHighlightColor: TColor;
  published
    property ShadeColor : TColor read FShadeColor write FShadeColor;
    property HighlightColor : TColor read FHighlightColor write FHighlightColor;
  end;

  TwwSpeedButton = class(TGraphicControl, IUnknown)
  private
    FTransparent: Boolean;
    FFlat: Boolean;
    FImageIndex: Integer;
    FImageList: TImageList;
    FMargin: Integer;
    FNumGlyphs: Integer;
    FShowText: Boolean;
    FSpacing: Integer;
    FDisabledTextColors: TwwDisabledTextColors;

    FMouseInControl: Boolean;

    procedure SetTransparent(Value: Boolean);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    function GetImageIndex: Integer; virtual;
    procedure SetFlat(Value: Boolean);
    procedure SetImageIndex(Value: Integer); virtual;
    procedure SetImageList(Value: TImageList);
    procedure SetMargin(Value: Integer);
    procedure SetNumGlyphs(Value: Integer);
    procedure SetShowText(Value: Boolean);
    procedure SetSpacing(Value: Integer);

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;

    // IUnknown
    {$ifdef ver110}
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; reintroduce; stdcall;
    {$else}
    function QueryInterface(const IID: TGUID; out Obj): {$ifdef wwDelphi4Up}HRESULT; reintroduce{$else}Integer{$endif}; stdcall;
    {$endif}
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ImageList: TImageList read FImageList write SetImageList;
    property Flat: Boolean read FFlat write SetFlat;
  published
    property Action;
    property ImageIndex: Integer read GetImageIndex write SetImageIndex;
    property Margin: Integer read FMargin write SetMargin default -1;
    property NumGlyphs: Integer read FNumGlyphs write SetNumGlyphs;
    property ShowText: Boolean read FShowText write SetShowText default False;
    property Spacing: Integer read FSpacing write SetSpacing;
    property Transparent: Boolean read FTransparent write SetTransparent default True;

    property Caption;
    property Enabled;
    property DisabledTextColors: TwwDisabledTextColors read FDisabledTextColors write FDisabledTextColors;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;

    property OnClick;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('IP Controls', [TwwSpeedButton]);
end;

// IUnknown

{$ifdef ver110}
function TwwSpeedButton.QueryInterface(const IID: TGUID; out Obj): HRESULT;
{$else}
function TwwSpeedButton.QueryInterface(const IID: TGUID; out Obj): {$ifdef wwDelphi4Up}HRESULT{$else}Integer{$endif};
{$endif}
const
  E_NOINTERFACE = $80004002;
begin
{$WARNINGS OFF}
  if GetInterface(IID, Obj) then Result := 0 else Result := E_NOINTERFACE;
{$WARNINGS ON}
end;

function TwwSpeedButton._AddRef: Integer;
begin
  Result := 1;
end;

function TwwSpeedButton._Release: Integer;
begin
  Result := 0;
end;

constructor TwwSpeedButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImageIndex := -1;
  FMargin := -1;
  FNumGlyphs := 1;
  FSpacing := 4;
  Width := 25;
  Height := 25;
  ControlStyle := ControlStyle - [csDoubleClicks];
  FDisabledTextColors:= TwwDisabledTextColors.create;
  FDisabledTextColors.HighlightColor:= clBtnHighlight;
  FDisabledTextColors.ShadeColor:= clGray;
end;

destructor TwwSpeedButton.Destroy;
begin
  FDisabledTextColors.Free;
  inherited Destroy;
end;

procedure TwwSpeedButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  FMouseInControl := True;
  Invalidate;
end;

procedure TwwSpeedButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FMouseInControl := False;
  Invalidate;
end;

function TwwSpeedButton.GetImageIndex: Integer;
begin
  result := FImageIndex;
end;

procedure TwwSpeedButton.SetFlat(Value: Boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    Invalidate;
  end;
end;

procedure TwwSpeedButton.SetImageIndex(Value: Integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Invalidate;
  end;
end;

procedure TwwSpeedButton.SetImageList(Value: TImageList);
begin
  if FImageList <> Value then
  begin
    FImageList := Value;
    Invalidate;
  end;
end;

procedure TwwSpeedButton.SetMargin(Value: Integer);
begin
  if FMargin <> Value then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TwwSpeedButton.SetNumGlyphs(Value: Integer);
begin
  if FNumGlyphs <> Value then
  begin
    FNumGlyphs := Value;
    Invalidate;
  end;
end;

procedure TwwSpeedButton.SetShowText(Value: Boolean);
begin
  if FShowText <> Value then
  begin
    FShowText := Value;
    Invalidate;
  end;
end;

procedure TwwSpeedButton.SetSpacing(Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TwwSpeedButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Invalidate;
end;

procedure TwwSpeedButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Invalidate;
end;

type TwwBtnCanvas = class(TCanvas)
//  procedure DrawText(Caption: string; var Rect: TRect; Style: Integer);
end;

{procedure TwwBtnCanvas.DrawText(Caption: string; var Rect: TRect; Style: Integer);
begin
  // Used by DrawText API Function when "Item" has focus.
  SetBkColor(Handle, ColorToRGB(Brush.Color));
  SetTextColor(Handle, ColorToRGB(Font.Color));
  Refresh;
  Windows.DrawTextEx(Handle, PChar(Caption), Length(Caption), Rect, Style, nil);
end;
}
procedure TwwSpeedButton.Paint;
var CurImageIndex: Integer;
  function UseCaption: Boolean;
  begin
    result := (Caption <> '') and FShowText;
  end;
  function UseGlyph: Boolean;
  begin
    result := ((FImageList <> nil) and (CurImageIndex <> -1));
  end;
  function ButtonDown: Boolean;
  begin
    result := (csLButtonDown in ControlState) and FMouseInControl;
  end;
  function CenterRect(r: TRect; AWidth, AHeight: Integer): TRect;
  begin
    result := r;

    result.Left := ((r.Right - r.Left) - AWidth) div 2;
    result.Right := result.Right - result.Left;
    result.Left := result.Left + r.Left;
    result.Top := ((r.Bottom - r.Top) - AHeight) div 2;
    result.Bottom := result.Bottom - result.Top;
    result.Top := result.Top + r.Top;
  end;
const
    DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
    FillStyles: array[Boolean] of Integer = (BF_MIDDLE, 0);
var CaptionRect: TRect;
    GlyphRect: TRect;
    DrawFlags: Integer;
    r: TRect;
    OffSet: Integer;
begin
  CurImageIndex := FImageIndex;
  if not Enabled then inc(CurImageIndex, ord(FNumGlyphs > 1))
  else if ButtonDown and (FNumGlyphs > 2) then
    inc(CurImageIndex, 2)
  else if FMouseInControl and (FNumGlyphs > 3) then
    inc(CurImageIndex, 3);

  r := ClientRect;

  if not FFlat then
  begin
    DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
    if ButtonDown then DrawFlags := DrawFlags or DFCS_PUSHED;
    DrawFrameControl(Canvas.Handle, r, DFC_BUTTON, DrawFlags);
    Offset := 2;
  end else begin
    if FMouseInControl and Enabled or (csDesigning in ComponentState) then
      DrawEdge(Canvas.Handle, r, DownStyles[ButtonDown],
        FillStyles[FFlat] or BF_RECT);
    OffSet := 1;
  end;

  Canvas.Brush.Style := bsClear;

  if FMargin <> -1 then OffsetRect(r, FMargin, FMargin);
  if ButtonDown then
    OffsetRect(r, Offset, Offset);
  if FMargin = -1 then
  begin
    if (FImageList <> nil) then GlyphRect := CenterRect(r, FImageList.Width, FImageList.Height);
  end else GlyphRect := r;

  OffsetRect(GlyphRect, ord(odd(GlyphRect.Right - GlyphRect.Left)), 1);
  if UseCaption then begin
     Canvas.Font.Assign(Font); { 10/7/98 - Assign canvas.font immediately instead of later }
     OffsetRect(GlyphRect, 0, -((Canvas.TextHeight(Caption) div 2) + (FSpacing div 2)));
  end;
  if FMargin = -1 then CaptionRect := CenterRect(r, Canvas.TextWidth(Caption), Canvas.TextHeight(Caption))
  else CaptionRect := r;
  if UseGlyph then OffsetRect(CaptionRect, 0, (Canvas.TextHeight(Caption) div 2) + (FSpacing div 2));

  if UseGlyph then
    FImageList.Draw(Canvas, GlyphRect.Left, GlyphRect.Top, CurImageIndex);
  if UseCaption then
  begin
//    Canvas.Font.Assign(Font); { 10/7/98 - Already have set this with fix above }
    if Enabled then
      DrawText(Canvas.Handle, PChar(Caption), Length(Caption), CaptionRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE)
    else begin
      OffsetRect(CaptionRect, 1, 1);
      Canvas.Font.Color:= DisabledTextColors.HighlightColor;
      DrawText(Canvas.Handle, PChar(Caption), Length(Caption), CaptionRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
      OffsetRect(CaptionRect, -1, -1);
      Canvas.Font.Color:= DisabledTextColors.ShadeColor;
      DrawText(Canvas.Handle, PChar(Caption), Length(Caption), CaptionRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE)
    end
  end;
end;

procedure TwwSpeedButton.SetTransparent(Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    if Value then
      ControlStyle := ControlStyle - [csOpaque] else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;

procedure TwwSpeedButton.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      { Copy image from action's imagelist }
      if (ActionList <> nil) and (ActionList.Images <> nil) and
        (ActionList.Images=self.ImageList) and
        (ImageIndex >= 0) and (ImageIndex < ActionList.Images.Count) then
        self.ImageIndex:= ImageIndex;
    end;
end;

end.
