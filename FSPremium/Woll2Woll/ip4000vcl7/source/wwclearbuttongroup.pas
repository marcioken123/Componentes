unit wwclearbuttongroup;
{
//
// Components : TwwCustomTransparentPanel
//              Supporting component for transparent navigator
//
// Copyright (c) 1999-2001 by Woll2Woll Software
//
}
{$i wwIfDef.pas}

interface

uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CommCtrl, StdCtrls, Buttons, ExtCtrls, wwcommon;

type
  TwwCustomTransparentGroupBox = class(TCustomGroupBox)
  private
    procedure WMEraseBkGnd(var Message:TWMEraseBkGnd); message WM_ERASEBKGND;
    procedure WMMove(var Message: TWMMove); Message WM_Move;
  protected
    // Property Storage Variables
    FTransparent: Boolean;
    FInEraseBkGnd: Boolean;

    procedure CreateWnd; override;
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
{
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
}

implementation

constructor TwwCustomTransparentGroupBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle;
  FTransparent := False;
  BevelOuter := bvRaised;
end;

procedure TwwCustomTransparentGroupBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  if IsTransparent then
     Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT;
end;

procedure TwwCustomTransparentGroupBox.CreateWnd;
//var origstyle, exStyle: longint;
begin
  inherited CreateWnd;
{  if FTransparent and (not IsTransparent) then
  begin
     OrigStyle:= Windows.GetWindowLong(handle, GWL_EXSTYLE);
     exStyle:= OrigStyle and not WS_EX_TRANSPARENT;
     if origStyle<>exStyle then
        Windows.SetWindowLong(handle, GWL_EXSTYLE, exStyle);
  end
}
end;

procedure TwwCustomTransparentGroupBox.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited;
  if IsTransparent then Invalidate;
end;

procedure TwwCustomTransparentGroupBox.Paint;
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
    inherited;
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

procedure TwwCustomTransparentGroupBox.WMEraseBkGnd(var Message: TWMEraseBkGnd);
begin
  if IsTransparent{ and not (Parent is TCustomGrid) }then Message.Result := 1
  else inherited;
end;

procedure TwwCustomTransparentGroupBox.WMMove(var Message: TWMMove);
begin
  inherited;
  if IsTransparent then Invalidate;
end;

procedure TwwCustomTransparentGroupBox.ClipChildren(Value: Boolean);
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

procedure TwwCustomTransparentGroupBox.SetParent(AParent:TWinControl);
begin
  inherited SetParent(AParent);

  // Without this, the panel would be transparent indeed, but you would see through the form into the background apps
//  ClipChildren(not FTransparent);
end;

procedure TwwCustomTransparentGroupBox.Invalidate;
var TempRect:TRect;
    i: Integer;
    r: TRect;
begin
  if IsTransparent and (Parent <> nil) and Parent.HandleAllocated then
  begin
    GetUpdateRect(Handle, r, False);
    tempRect:= BoundsRect;
    tempRect:= Rect(TempRect.Left + r.Left, TempRect.Top + r.Top,
                    TempRect.Left + r.Right, TempRect.Top + R.Bottom);
    InvalidateRect(Parent.Handle, @TempRect, False);

//    r:= ClientRect;
    if (r.left=r.right) and (r.top=r.bottom) then
      InvalidateRect(Handle, nil, False)
    else InvalidateRect(Handle, @r, False);
//    Parent.Update; { 8/5/99 - RSW - Calling this causes problem with TImage or TfcImager not being painted }
                     { This happened when you enter page/down in a scrollable region }
    for i := 0 to ControlCount - 1 do
    begin
//        if PtInRect(r, Point(Controls[i].Left, Controls[i].Top)) or
//           PtInRect(r, Point(Controls[i].Left+Controls[i].Width, Controls[i].Left+Controls[i].Height)) then
//           Controls[i].Invalidate;
    end
  end
  else inherited Invalidate;
end;

procedure TwwCustomTransparentGroupBox.SetTransparent(Value: Boolean);
begin
  if FTransparent <> Value then
  begin
    FTransparent := Value;

    if IsTransparent then ControlStyle := ControlStyle - [csOpaque]
    else begin
       ControlStyle := ControlStyle + [csOpaque];
    end;

    if not (csLoading in ComponentState) and HandleAllocated then { 4/30/99 }
      Invalidate;
//    ClipChildren(not Value);
//    RecreateWnd;
  end;
end;

Function TwwCustomTransparentGroupBox.IsTransparent: boolean;
begin
   result:= FTransparent and not (csDesigning in ComponentState);
   if result and (parent<>nil) and wwIsClass(parent.classtype, 'TCustomGrid') then
      result:=false;
end;

end.
