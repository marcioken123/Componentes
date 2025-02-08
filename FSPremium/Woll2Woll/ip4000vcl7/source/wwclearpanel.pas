unit wwclearpanel;
{
//
// Components : TwwCustomTransparentPanel
//              Supporting component for transparent navigator
//
// Copyright (c) 1999 by Woll2Woll Software
//
}
{$i wwIfDef.pas}

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CommCtrl, StdCtrls, Buttons, ExtCtrls;

type
  TwwCustomTransparentPanel = class(TCustomPanel)
  private
    procedure WMEraseBkGnd(var Message:TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMMove(var Message: TWMMove); Message WM_Move;
  protected
    // Property Storage Variables
    FTransparent: Boolean;
    FInEraseBkGnd: Boolean;

    procedure ClipChildren(Value: Boolean);

    // Property Access Methods
    procedure SetTransparent(Value: Boolean); virtual;

    // Overridden methods
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure SetParent(AParent:TWinControl); override;
    function IsTransparent: boolean; virtual;
  public
    BasePatch: Variant;
    constructor Create(AOwner: TComponent); override;
    procedure Invalidate; override;

    property Transparent: Boolean read FTransparent write SetTransparent default False;
  end;

  TfcTransparentPanel = class(TwwCustomTransparentPanel)
  published
    property Align;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
    property Color;
    property Transparent;
  end;


implementation

constructor TwwCustomTransparentPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csSetCaption];
  FTransparent := False;
  BevelOuter := bvRaised;
end;

procedure TwwCustomTransparentPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if IsTransparent then
     Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;

procedure TwwCustomTransparentPanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited;
  if IsTransparent then Invalidate;
end;

procedure TwwCustomTransparentPanel.Paint;
var
  ARect: TRect;
  TopColor, BottomColor: TColor;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;

begin
  if IsTransparent then
  begin
    ARect := GetClientRect;

    // For BevelOuter property
    if BevelOuter <> bvNone then
    begin
      AdjustColors(BevelOuter);
      Frame3D(Canvas, ARect, TopColor, BottomColor, BevelWidth);
    end;

    // For BorderWidth property
    Frame3D(Canvas, ARect, Color, Color, BorderWidth);

    // For BevelInner Property
    if BevelInner <> bvNone then
    begin
      AdjustColors(BevelInner);
      Frame3D(Canvas, ARect, TopColor, BottomColor, BevelWidth);
    end;
    Update;
  end else inherited;
end;

procedure TwwCustomTransparentPanel.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  if IsTransparent then Message.Result := 1
  else inherited;
end;

procedure TwwCustomTransparentPanel.WMMove(var Message: TWMMove);
begin
  inherited;
  if IsTransparent then Invalidate;
end;

procedure TwwCustomTransparentPanel.ClipChildren(Value: Boolean);
begin
  if (Parent <> nil) then
  begin
    if Value then
      SetWindowLong(Parent.Handle, GWL_STYLE,
        GetWindowLong(Parent.Handle, GWL_STYLE) or WS_CLIPCHILDREN)
    else
      SetWindowLong(Parent.Handle, GWL_STYLE,
        GetWindowLong(Parent.Handle, GWL_STYLE) and not WS_CLIPCHILDREN);
    end;
end;

procedure TwwCustomTransparentPanel.SetParent(AParent:TWinControl);
begin
  inherited SetParent(AParent);

  // Without this, the panel would be transparent indeed, but you would see through the form into the background apps
//  ClipChildren(not FTransparent);
end;

procedure TwwCustomTransparentPanel.Invalidate;
var Rect :TRect;
    i: Integer;
begin
  if IsTransparent and (Parent <> nil) and Parent.HandleAllocated then
  begin
    Rect:= BoundsRect;
    InvalidateRect(Parent.Handle, @Rect, True);
//    Parent.Update; { 8/5/99 - RSW - Calling this causes problem with TImage or TfcImager not being painted }
                     { This happened when you enter page/down in a scrollable region }
    for i := 0 to ControlCount - 1 do Controls[i].Invalidate;
  end
  else inherited Invalidate;
end;

procedure TwwCustomTransparentPanel.SetTransparent(Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;
    if FTransparent then ControlStyle := ControlStyle - [csOpaque]
    else ControlStyle := ControlStyle + [csOpaque];

    if not (csLoading in ComponentState) and HandleAllocated then { 4/30/99 }
      Invalidate;
//    ClipChildren(not Value);
//    RecreateWnd;
  end;
end;

Function TwwCustomTransparentPanel.IsTransparent: boolean;
begin
   result:= FTransparent and not (csDesigning in ComponentState);
end;

end.
