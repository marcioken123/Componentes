unit LMDCustomBiTrackBar;
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

LMDCustomBiTrackBar unit (AH)
-----------------------------
TrackBar control with two thumbs and option to draw diapason bar 

Changes
-------
Release 10.0 (August 2009)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Graphics, Messages, SysUtils, Controls, Forms, StdCtrls,
  LMDProcs, LMDCustomTrackBar, LMDFillObject, LMDThemes{, LMDLogMessage};

type
  TLMDCustomBiTrackBar = class(TLMDCustomTrackBar)
  private
    FDiapasonVerticalMargin: Integer;
    procedure SetLeftPosition(Value: integer);
    procedure SetRightPosition(Value: integer);
    procedure SetDiapasonPosition(const Value: Integer);
    procedure NormalizePosition(var Value: Integer);
    procedure SetDiapasonFillObject(const Value: TLMDFillObject);
    procedure SetDiapasonMargin(const Value: Integer);
  protected
    FRightPosition: integer;
    FLeftPosition: integer;
    FLeftBRect: TRect;
    FRightBRect: TRect;
    FDiapasonBack: TBitmap;
    FLeftBack: TBitmap;
    FRightBack: TBitmap;
    FLeftSliding: Boolean;
    FRightSliding: Boolean;
    FDiapasonFillObject: TLMDFillObject;
    FDiapasonRect: TRect;
    FDiapasonSliding: Boolean;
    FDiapasonLength: Integer;
    FDiapasonPosition: Integer;
    FLengthToLeft: Integer;
    function MousePosToThumbPos(x: Integer; y: Integer): Integer; virtual;
    procedure TimerExpired(Sender: TObject); override;
    procedure Paint; override;
    procedure DrawDiapason; virtual;
    procedure RestoreDiapasonBack; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; x,y: Integer); override;
    procedure MouseMove(Shift: TShiftState; x,y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X,Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function SetScrolledPosition(X, Y: Integer): boolean; virtual;
    property DiapasonPosition: Integer read FDiapasonPosition write SetDiapasonPosition;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property DiapasonMargin: Integer read FDiapasonVerticalMargin write SetDiapasonMargin default 3;
    property DiapasonFillObject: TLMDFillObject read FDiapasonFillObject write SetDiapasonFillObject;
    property RightPosition: integer read FRightPosition write SetRightPosition;
    property LeftPosition: integer read FLeftPosition write SetLeftPosition;
  end;

implementation

uses
  LMDGraph;

{ TLMDCustomBiTrackBar }

constructor TLMDCustomBiTrackBar.Create(AOwner: TComponent);
begin
  inherited;
  FDiapasonFillObject := TLMDFillObject.Create();
  FDiapasonVerticalMargin := 3;
end;

destructor TLMDCustomBiTrackBar.Destroy;
begin
  inherited;
  if Assigned(FDiapasonBack) then
    FreeAndNil(FDiapasonBack);
  if Assigned(FLeftBack) then
    FreeAndNil(FLeftBack);
  if Assigned(FRightBack) then
    FreeAndNil(FRightBack);
  FDiapasonFillObject.Free;
end;

procedure TLMDCustomBiTrackBar.NormalizePosition(var Value: Integer);
begin
  if Value < FMin then
    Value := FMin
  else if Value > FMax then
    Value := FMax;
end;

function TLMDCustomBiTrackBar.MousePosToThumbPos(x: Integer; y: Integer): Integer;
var
  h: Integer;
  w: Integer;
begin
  if FOrientation = toVertical then
  begin
    H := fmyh - fh;
    Result := Round(((H - y) / H) * (FMax - FMin) + FMin);
  end
  else
  begin
    W := fmyw - fh;
    Result := Round(((X - fh) / W) * (FMax - FMin) + FMin);
  end;
end;

procedure TLMDCustomBiTrackBar.DrawDiapason;
begin
  CalcThumbRect(LeftPosition, FLeftBRect);
  CalcThumbRect(RightPosition, FRightBRect);
  FDiapasonRect := Rect(FLeftBRect.Left + (FThumbWidth div 2), FLeftBRect.Top + FDiapasonVerticalMargin, FRightBRect.Left + (FThumbWidth div 2), FRightBRect.Bottom - FDiapasonVerticalMargin);

  if (LMDRectWidth(FDiapasonRect) > 0) and (LMDRectHeight(FDiapasonRect) > 0) then
  begin
    if not Assigned(FDiapasonBack) then
      FDiapasonBack := TBitmap.Create;
    FDiapasonBack.Width := LMDRectWidth(FDiapasonRect);
    FDiapasonBack.Height := LMDRectHeight(FDiapasonRect);
    FDiapasonBack.Canvas.CopyRect(Rect(0, 0, LMDRectWidth(FDiapasonRect), LMDRectHeight(FDiapasonRect)), Canvas, FDiapasonRect);
    FDiapasonFillObject.FillCanvas(Canvas, FDiapasonRect, clRed);
  end
end;

procedure TLMDCustomBiTrackBar.KeyDown(var Key: Word; Shift: TShiftState);
var
  v:Integer;
begin
  case key of
    VK_UP,
    VK_RIGHT: begin
                v := LMDMin([FDiapasonPosition + FLineSize, FMax]);
                if Assigned (FOnTrack) then
                  FOnTrack (self, scLineUp, v);
                DiapasonPosition := v;
              end;
    VK_DOWN,
    VK_LEFT : begin
                v := LMDMax([FDiapasonPosition - FLineSize, FMin]);
                if Assigned (FOnTrack) then
                  FOnTrack (self, scLineDown, v);
                DiapasonPosition := v;
              end;
    VK_PRIOR: begin
                v := LMDMin([FDiapasonPosition + FPageSize, FMax]);
                if Assigned (FOnTrack) then
                  FOnTrack (self, scPageUp, v);
                DiapasonPosition := v;
              end;
    VK_NEXT : begin
                v := LMDMax([FDiapasonPosition - FPageSize, FMin]);
                if Assigned (FOnTrack) then
                  FOnTrack (self, scPageDown, v);
                DiapasonPosition := v;
              end;
    VK_END  : DiapasonPosition := FMax;
    VK_HOME : DiapasonPosition := FMin;
  end;
  if key in [VK_UP, VK_RIGHT, VK_DOWN, VK_LEFT, VK_PRIOR, VK_NEXT] then
    if Assigned (FOnTrack) then
      FOnTrack(self, scEndScroll, FDiapasonPosition);
end;

procedure TLMDCustomBiTrackBar.MouseDown(Button: TMouseButton; Shift: TShiftState; x, y: Integer);
begin
  if FFocusStyle <> tbNoFocus then
    SetFocus;
  if (Button=mbLeft) and PtInRect(FLeftBRect, Point(X,Y)) then
  begin
    FLeftSliding := true;
  end
  else if (Button=mbLeft) and PtInRect(FRightBRect, Point(X,Y)) then
  begin
    FRightSliding := true;
  end
  else if (Button=mbLeft) and (PtInRect(FDiapasonRect, Point(X, Y))) then
  begin
    FDiapasonSliding := True;
    FDiapasonPosition := MousePosToThumbPos(x, y);
    FLengthToLeft := FDiapasonPosition - FLeftPosition;
  end
  else if (Button=mbLeft) and (IsMouseOnTrack(Point(X, Y))) then
  begin
    FTimerId.Enabled:=True;
    SetScrolledPosition(X, Y);
  end;

end;

procedure TLMDCustomBiTrackBar.MouseMove(Shift: TShiftState; x, y: Integer);
var
  p:Integer;
begin
  inherited MouseMove(Shift, X, Y );
  FMousePos := Point(X,Y);
  if FLeftSliding or FRightSliding or FDiapasonSliding then
  begin
    p := MousePosToThumbPos(x, y);

    if Assigned (FOnTrack) then
      FOnTrack (self, scTrack, p);

    if FLeftSliding then
    begin
      if p <> LeftPosition then
      begin
        Application.CancelHint;
        LeftPosition := p;
      end;
    end;
    if FRightSliding then
    begin
      if p <> FRightPosition then
      begin
        Application.CancelHint;
        RightPosition := p;
      end;
    end;
    if FDiapasonSliding then
    begin
      if p <> FRightPosition then
      begin
        Application.CancelHint;
        DiapasonPosition := p;
      end;
    end;
  end;
end;

procedure TLMDCustomBiTrackBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  FTimerId.Enabled:=False;
  if Button=mbLeft then
  begin
    if FLeftSliding and FRightSliding and Assigned (FOnTrack) then
      FOnTrack (self, scPosition, FPosition);
    if FLeftSliding then
    begin
      FLeftSliding := false;
    end;
    if FRightSliding then
    begin
      FRightSliding := false;
    end;
    if FDiapasonSliding then
    begin
      FDiapasonSliding := false;
    end;
  end;
  if Assigned (FOnTrack) then
    FOnTrack (self, scEndScroll, FPosition);
end;

procedure TLMDCustomBiTrackBar.Paint;
begin
  PaintPos;
  DrawDiapason;
  DrawThumb(LeftPosition, FLeftBRect, FLeftBack, False);
  DrawThumb(RightPosition, FRightBRect, FRightBack, False);
  if Focused then
    DrawFocus(ClientRect);
  if Assigned(FOnDrawFrame) then
    FOnDrawFrame(self);
end;

procedure TLMDCustomBiTrackBar.RestoreDiapasonBack;
begin
  if not Assigned (FDiapasonBack) then
    exit;
  Canvas.Draw(FDiapasonRect.Left, FDiapasonRect.Top, FDiapasonBack);
end;

procedure TLMDCustomBiTrackBar.SetDiapasonFillObject(
  const Value: TLMDFillObject);
begin
  FDiapasonFillObject.Assign(Value);
  if HandleAllocated then
    Invalidate;
end;

procedure TLMDCustomBiTrackBar.SetDiapasonMargin(const Value: Integer);
begin
  if FDiapasonVerticalMargin <> Value then
  begin
    FDiapasonVerticalMargin := Value;
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TLMDCustomBiTrackBar.SetDiapasonPosition(const Value: Integer);
begin
  if FDiapasonPosition <> Value then
  begin
    FDiapasonPosition := Value;
    FLeftPosition := FDiapasonPosition - FLengthToLeft;
    NormalizePosition(FLeftPosition);

    if (FLeftPosition + FDiapasonLength) > FMax then
    begin
      FLeftPosition := FMax - FDiapasonLength;
      RightPosition := FMax;
    end
    else
      RightPosition := FLeftPosition + FDiapasonLength;
  end;
end;

procedure TLMDCustomBiTrackBar.SetLeftPosition(Value: integer);
begin
  NormalizePosition(Value);

  if Value > FRightPosition then
    Value := FRightPosition;

  if Value <> FLeftPosition then
  begin
    if (Value = FMax) and Assigned (FOnTrack) then
      FOnTrack (self, scBottom, FMax);
    if (Value = FMin) and Assigned (FOnTrack) then
      FOnTrack (self, scTop, FMin);

    FLeftPosition := Value;
    FDiapasonLength := FRightPosition - FLeftPosition;

    if csDesigning in ComponentState then
      Invalidate
    else
    begin
      // --> changed 01-07-2002, to avoid flicker in key/wheel mode
      RestoreThumbBack(FLeftBRect, FLeftBack);
      RestoreThumbBack(FRightBRect, FRightBack);
      RestoreDiapasonBack;
      DrawDiapason;
      DrawThumb(FLeftPosition, FLeftBRect, FLeftBack, False);
      DrawThumb(FRightPosition, FRightBRect, FRightBack, False);
      Change;
    end;
  end;
end;

procedure TLMDCustomBiTrackBar.SetRightPosition(Value: integer);
begin
  NormalizePosition(Value);

  if Value < FLeftPosition then
    Value := FLeftPosition;

  if Value <> FRightPosition then
  begin
    if (Value = FMax) and Assigned (FOnTrack) then
      FOnTrack (self, scBottom, FMax);
    if (Value = FMin) and Assigned (FOnTrack) then
      FOnTrack (self, scTop, FMin);

    FRightPosition := Value;
    FDiapasonLength := FRightPosition - FLeftPosition;

    if csDesigning in ComponentState then
      Invalidate
    else
    begin
      // --> changed 01-07-2002, to avoid flicker in key/wheel mode
      RestoreThumbBack(FLeftBRect, FLeftBack);
      RestoreThumbBack(FRightBRect, FRightBack);
      RestoreDiapasonBack;
      DrawDiapason;
      DrawThumb(FLeftPosition, FLeftBRect, FLeftBack, False);
      DrawThumb(FRightPosition, FRightBRect, FRightBack, False);
      Change;
    end;
  end;
end;

function TLMDCustomBiTrackBar.SetScrolledPosition(X, Y: Integer): Boolean;
var
  v, px, py: Integer;
  tmp: Extended;
  LLeftSlide: Boolean;
  LRightSlide: Boolean;
  LMiddle: Integer;
  LPosition: Integer;
  LClickPoint: Integer;
begin
  Result := True;
  LLeftSlide := False;
  LRightSlide := False;
  if FOrientation = toVertical then
  begin
    tmp:=(fmyh - FThumbWidth)/(FMax - FMin);
    LMiddle := (FLeftBRect.Top + FRightBRect.Bottom) div 2;
    LClickPoint := Y;
  end
  else
  begin
    tmp := (fmyw - FThumbWidth) / (FMax - FMin);
    LMiddle := (FLeftBRect.Left + FRightBRect.Right) div 2;
    LClickPoint := X;
  end;

  LPosition := 0;
  if (LClickPoint < LMiddle) then
  begin
    LLeftSlide := True;
    LPosition := FLeftPosition;
  end
  else if (LClickPoint >= LMiddle) then
  begin
    LRightSlide := True;
    LPosition := FRightPosition;
  end;

  if FOrientation = toVertical then
  begin
    py := Trunc(tmp * ((FMax - LPosition) - FMin));
    FDirection := Ord(Y < py) + 1;
  end
  else
  begin
    px := Trunc(tmp * (LPosition - FMin));
    if (FDirection = 2) and (X < px) then
    begin
      Result := False;
      FDirection := 1;
      exit;
    end;
    if (FDirection = 1) and (X > px) then
    begin
      Result := False;
      FDirection := 2;
      exit;
    end;

    FDirection := Ord(X > px) + 1;
  end;

  if FDirection = 2 then
  begin
    v := LMDMin([LPosition + FPageSize, FMax]);
    if Assigned(FOnTrack) then
      FOnTrack(self, scPageUp, v);
  end
  else if FDirection = 1 then
  begin
    v := LMDMax([LPosition - FPageSize, FMin]);
    if Assigned(FOnTrack) then
      FOnTrack(self, scPageDown, v);
  end
  else
    Result := False;

//  if Position <> v then
  begin
    Application.CancelHint;
    if LLeftSlide then
      LeftPosition := v;
    if LRightSlide then
      RightPosition := v;
  end;
end;

procedure TLMDCustomBiTrackBar.TimerExpired(Sender: TObject);
begin
  if IsMouseOnTrack(FMousePos) then
  begin
    try
      FTimerId.Enabled := SetScrolledPosition(FMousePos.X, FMousePos.Y);
    except
      FTimerID.Enabled:=False;
      raise;
    end;
  end;
end;

end.
