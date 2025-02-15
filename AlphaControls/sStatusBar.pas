unit sStatusBar;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, ComCtrls,
  {$IFNDEF DELPHI5} Types, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFDEF TNTUNICODE} TntComCtrls, {$ENDIF}
  sConst, sCommonData;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsStatusBar = class(TTntStatusBar)
{$ELSE}
  TsStatusBar = class(TStatusBar)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FCommonData: TsCommonData;
  protected
    FSizeClick: boolean;
    FSizePoint: TPoint;
    TranspMode: byte;
    procedure PaintGrip;
    function GripPos: TPoint;
    function GripRect: TRect;
    procedure PaintPanels;
    function PanelOffset(ExceptNdx: integer): integer;
    procedure WMHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDown(var Message: TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNCMouseMove(var Message: TWMMouse); message WM_MOUSEMOVE;
    procedure WMNCLButtonUp(var Message: TWMNCLButtonUp); message WM_LBUTTONUP;
    procedure ChangeScale(M, D: Integer{$IFDEF DELPHI_10BERLIN}; isDpiChange: Boolean{$ENDIF}); override;
{$IFDEF TNTUNICODE}
    procedure DrawPanel(Panel: TTntStatusPanel; const Rect: TRect); reintroduce;
    procedure InternalDrawPanel(Panel: TTntStatusPanel; const Text: WideString; Rect: TRect);
{$ELSE}
    procedure DrawPanel(Panel: TStatusPanel; const Rect: TRect); reintroduce;
    procedure InternalDrawPanel(Panel: TStatusPanel; const Text: string; Rect: TRect);
{$ENDIF}
    procedure DoDrawText(const Text: acString; var Rect: TRect; Flags: Cardinal);
    function PrepareCache: boolean;
    procedure OurPaintHandler(MsgDC: hdc);
    procedure WndProc(var Message: TMessage); override;
    procedure PaintWindow(DC: HDC); override;
    procedure SendToForm(Destroying: boolean = False);
  public
    constructor Create(AOwner: TComponent); override;
    procedure ReflectPanels;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure AfterConstruction; override;
{$ENDIF} // NOTFORHELP
  published
    property SkinData: TsCommonData read FCommonData write FCommonData;
  end;


implementation

uses
  math, CommCtrl,
  sMessages, sStyleSimply, sMaskData, acntUtils, sVCLUtils, sGraphUtils, sSkinManager, sSkinProps, sAlphaGraph;


procedure TsStatusBar.AfterConstruction;
begin
  inherited;
  FCommonData.Loaded;
end;


procedure TsStatusBar.ChangeScale(M, D: Integer{$IFDEF DELPHI_10BERLIN}; isDpiChange: Boolean{$ENDIF});
var
  i: integer;
begin
//  if (SkinData.SkinManager = nil) or (SkinData.SkinManager.Options.ScaleMode = smVCL) then
//    Height := MulDiv(Height, M, D);
  if M <> D then
    for i := 0 to Panels.Count - 1 do
      Panels[i].Width := MulDiv(Panels[i].Width, M, D);

  inherited;
end;


constructor TsStatusBar.Create(AOwner: TComponent);
begin
  FCommonData := TsCommonData.Create(Self, True);
  FCommonData.COC := COC_TsStatusBar;
  inherited Create(AOwner);
  FSizeClick := False;
  ControlStyle := ControlStyle + [csOpaque, csAcceptsControls];
end;


destructor TsStatusBar.Destroy;
begin
  SendToForm(True);
  FreeAndNil(FCommonData);
  inherited Destroy;
end;


procedure TsStatusBar.DoDrawText(const Text: acString; var Rect: TRect; Flags: Cardinal);
begin
  Flags := DrawTextBiDiModeFlags(Flags) or DT_SINGLELINE or DT_VCENTER or DT_ALPHATEXT * integer(TranspMode = 2);
  if UseRightToLeftReading then
    Flags := Flags or DT_RIGHT;

  FCommonData.FCacheBMP.Canvas.Font.Assign(Self.Font);
  FCommonData.FCacheBmp.Canvas.Brush.Style := bsClear;
  acWriteTextEx(FCommonData.FCacheBMP.Canvas, PacChar(Text), True, Rect, Flags, FCommonData, ControlIsActive(FCommonData));
  if TranspMode = 1 then
    FillAlphaRect(FCommonData.FCacheBMP, Rect);
end;


procedure TsStatusBar.DrawPanel(Panel: {$IFDEF TNTUNICODE}TTntStatusPanel{$ELSE}TStatusPanel{$ENDIF}; const Rect: TRect);
var
  aRect: TRect;
begin
  if FCommonData.Skinned then begin
    aRect := Rect;
    InflateRect(aRect, -1, -1);
    InternalDrawPanel(Panel, '', aRect);
  end
  else
    inherited DrawPanel(Panel, Rect);
end;


function TsStatusBar.GripPos: TPoint;
begin
  if FCommonData.SkinManager <> nil then
    with FCommonData.SkinManager, SkinData.CommonSkinData do
      if IsValidImgIndex(GripRightBottom) then
        Result := Point(Width  - ma[GripRightBottom].Width - BorderWidth, Height - ma[GripRightBottom].Height - BorderWidth)
      else
        Result := MkPoint
  else
    Result := MkPoint;
end;


function TsStatusBar.GripRect: TRect;
begin
  Result.TopLeft := GripPos;
  Result.Right := Width;
  Result.Bottom := Height;
end;


procedure TsStatusBar.InternalDrawPanel(Panel: {$IFDEF TNTUNICODE}TTntStatusPanel{$ELSE}TStatusPanel{$ENDIF}; const Text: acString; Rect: TRect);
var
  index, si, mi, dx: integer;
  TempBmp: TBitmap;
  CI: TCacheInfo;
  SavedDC: hdc;
  aRect: TRect;
begin
  aRect := Rect;
  InflateRect(aRect, -1, -1);
  with FCommonData.SkinManager, FCommonData.CommonSkinData do begin
    index := GetMaskIndex(FCommonData.SkinIndex, s_StatusPanelMask, FCommonData.CommonSkinData);
    if IsValidSkinIndex(FCommonData.SkinIndex) then
      if IsValidImgIndex(index) then
        if SimplePanel or (Panels.Count = 0) then
          DrawSkinRect(FCommonData.FCacheBmp, MkRect(Self), EmptyCI, ma[index], 0, True)
        else
          DrawSkinRect(FCommonData.FCacheBmp, Rect, EmptyCI, ma[index], 0, True)
      else
        if not (SimplePanel or (Panels.Count = 0) or (Panel.Index = Panels.Count - 1) or (Panels[Panel.Index].Bevel = pbNone)) then begin
          si := SkinCommonInfo.Sections[ssDivider];
          if IsValidskinIndex(si) then begin
            mi := GetMaskIndex(si, s_BordersMask, FCommonData.CommonSkinData);
            if IsValidImgIndex(mi) then begin
              TempBmp := CreateBmp32(max(2, (ma[mi].WL + ma[mi].WR)), Height - 2);
              dx := TempBmp.Width div 2;
              CI := MakeCacheInfo(FCommonData.FCacheBmp);
              PaintItem(si, CI, True, 0, MkRect(TempBmp), Point(Rect.Right - dx - 1, 1), TempBmp, SkinData.CommonSkinData);
              BitBlt(FCommonData.FCacheBmp.Canvas.Handle, Rect.Right - dx - 1, 1, TempBmp.Width, TempBmp.Height, TempBmp.Canvas.Handle, 0, 0, SRCCOPY);
              FreeAndNil(TempBmp);
            end;
          end;
        end;
  end;
  if Assigned(Panel) and (Panel.Style = psOwnerDraw) and Assigned(OnDrawPanel) then begin
    SavedDC := SaveDC(FCommonData.FCacheBmp.Canvas.Handle);
    Canvas.Lock;
    Canvas.Handle := FCommonData.FCacheBmp.Canvas.Handle;
    Self.OnDrawPanel(TStatusBar(Self), Panel, Rect);
    Canvas.Handle := 0;
    Canvas.Unlock;
    RestoreDC(FCommonData.FCacheBmp.Canvas.Handle, SavedDC);
  end
  else begin
    dec(aRect.Bottom, 1);
    inc(aRect.Left, 2);
    dec(aRect.Right, 4);
    if Assigned(Panel) then
      DoDrawText(Panel.Text, aRect, GetStringFlags(Self, Panel.Alignment) or DT_END_ELLIPSIS)
    else
      DoDrawText(Text, aRect, GetStringFlags(Self, taLeftJustify) or DT_END_ELLIPSIS);
  end;
end;


procedure TsStatusBar.Loaded;
begin
  inherited;
  FCommonData.Loaded;
end;


procedure TsStatusBar.OurPaintHandler(MsgDC: hdc);
var
  DC, SavedDC: hdc;
  PS: TPaintStruct;
  bWidth: integer;
begin
  BeginPaint(Handle, PS);
  if MsgDC = 0 then
    DC := GetDC(Handle)
  else
    DC := MsgDC;

  SavedDC := SaveDC(DC);
  try
    if not InUpdating(FCommonData) then begin
      PrepareCache;
      bWidth := BorderWidth;
      CopyWinControlCache(Self, FCommonData, Rect(bWidth, bWidth, 0, 0), MkRect(Self), DC, True);
      sVCLUtils.PaintControls(DC, Self, FCommonData.BGChanged, MkPoint);
      SetParentUpdated(Self);
      FCommonData.BGChanged := False;
    end;
  finally
    RestoreDC(DC, SavedDC);
    if MsgDC = 0 then
      ReleaseDC(Handle, DC);
      
    EndPaint(Handle, PS);
  end;
end;


procedure TsStatusBar.PaintGrip;
begin
  if FCommonData.SkinManager <> nil then
    with FCommonData.SkinManager, SkinData.CommonSkinData do
      if IsValidImgIndex(GripRightBottom) then
        DrawSkinGlyph(FCommonData.FCacheBmp, GripPos, 0, 1, ma[GripRightBottom], MakeCacheInfo(FCommonData.FCacheBmp));
end;


procedure TsStatusBar.PaintPanels;
var
  i, MaxWidth: integer;
begin
  MaxWidth := Width;
  if SizeGrip then
    dec(MaxWidth, 18);

  if SimplePanel or (Panels.Count = 0) then
    InternalDrawPanel(nil, SimpleText, Rect(0, 1, MaxWidth - 1, Height - 1))
  else
    for i := 0 to Panels.Count - 1 do
      DrawPanel(Panels[i], Rect(PanelOffset(i), 0, iff(i <> Panels.Count - 1, PanelOffset(i) + Panels[i].Width, MaxWidth), Height));
end;


procedure TsStatusBar.PaintWindow(DC: HDC);
begin
  inherited;
  if FCommonData.Skinned then
    OurPaintHandler(DC);
end;


function TsStatusBar.PanelOffset(ExceptNdx: integer): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 0 to Panels.Count - 1 do
    if i <> ExceptNdx then
      inc(Result, Panels[i].Width)
    else
      break;
end;


function TsStatusBar.PrepareCache: boolean;
var
  CI: TCacheInfo;
  b: boolean;
begin
  Result := True;
  // If transparent and form resizing processed
  b := FCommonData.BGChanged or FCommonData.HalfVisible or GetBoolMsg(Parent, AC_GETHALFVISIBLE);
  FCommonData.HalfVisible := not (PtInRect(Parent.ClientRect, Point(Left, Top)) and PtInRect(Parent.ClientRect, Point(Left + Width, Top + Height)));
  if b then begin
    InitCacheBmp(SkinData);
    if not FCommonData.FCacheBMP.Empty then begin
      TranspMode := GetTransMode(SkinData);
      CI := GetParentCache(FCommonData);
      PaintItem(FCommonData, CI, False, 0, MkRect(Self), Point(Left, Top), FCommonData.FCacheBMP, False);
      PaintPanels;
      if SizeGrip then
        PaintGrip;

      FCommonData.BGChanged := False;
    end;
  end;
end;


procedure TsStatusBar.ReflectPanels;
var
  i: integer;
  PanArray: array of TStatusPanel;
begin
  SetLength(PanArray, Panels.Count);
  for i := Panels.Count - 1 downto 0 do
    PanArray[i] := Panels[Panels.Count - 1 - i];

  for i := 0 to Panels.Count - 1 do
    PanArray[i].Index := i;
end;


procedure TsStatusBar.SendToForm(Destroying: boolean);
var
  f: TCustomForm;
begin
  f := GetParentForm(Self{$IFDEF D2005}, False{$ENDIF});
  if (f <> nil) and (f.ComponentState * [csDestroying, csLoading] = []) then
    TrySendMessage(f.Handle, SM_ALPHACMD, MakeWParam(integer(not Destroying), AC_STATUSBAR), LParam(Self));
end;


procedure TsStatusBar.WMHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if SizeGrip and SkinData.Skinned and PtInRect(GripRect, acMousePos(Self)) then
    Message.Result := HTBOTTOMRIGHT;
end;


procedure TsStatusBar.WMNCLButtonDown(var Message: TWMNCLButtonDown);
begin
  if SizeGrip and PtInRect(GripRect, acMousePos(Self)) then begin
    FSizeClick := True;
    FSizePoint := acMousePos;
    SetCapture(Handle);
  end
  else
    inherited;
end;


procedure TsStatusBar.WMNCLButtonUp(var Message: TWMNCLButtonUp);
begin
  if FSizeClick then begin
    FSizeClick := False;
    ReleaseCapture;
  end
  else
    inherited;
end;


procedure TsStatusBar.WMNCMouseMove(var Message: TWMMouse);
var
  f: TCustomForm;
  prevPoint: TPoint;
begin
  if FSizeClick then begin
    prevPoint := FSizePoint;
    FSizePoint := acMousePos;
    if (FSizePoint.X <> prevPoint.X) or (FSizePoint.Y <> prevPoint.Y) then begin
      f := GetParentForm(Self);
      if f <> nil then
        f.SetBounds(f.Left, f.Top, f.Width + FSizePoint.X - prevPoint.X, f.Height + FSizePoint.Y - prevPoint.Y);
    end;
  end;
end;


procedure TsStatusBar.WndProc(var Message: TMessage);
var
  SaveIndex: Integer;
  cr: TRect;
  DC: HDC;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_CTRLHANDLED: begin
          Message.Result := AC_HANDLED;
          Exit
        end;

        AC_REMOVESKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            SetBkMode(Canvas.Handle, OPAQUE);
            CommonMessage(Message, FCommonData);
            RecreateWnd;
            AlphaBroadCast(Self, Message);
            Exit;
          end;

        AC_SETNEWSKIN: begin
          if (ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager)) then
            CommonMessage(Message, FCommonData);

          AlphaBroadCast(Self, Message);
          Exit
        end;

        AC_REFRESH: begin
          if RefreshNeeded(SkinData, Message) then begin
            CommonMessage(Message, FCommonData);
            if HandleAllocated and not (csLoading in ComponentState) and Visible then begin
              RedrawWindow(Handle, nil, 0, RDWA_ALLNOW);
              AlphaBroadCast(Self, Message);
            end;
          end
          else
            AlphaBroadCast(Self, Message);

          Exit;
        end;

        AC_GETDEFSECTION: begin
          Message.Result := 16 + 1;
          Exit;
        end;

        AC_GETDEFINDEX: begin
          if FCommonData.SkinManager <> nil then
            Message.Result := FCommonData.SkinManager.SkinCommonInfo.Sections[ssStatusBar] + 1;

          Exit;
        end

        else
          if CommonMessage(Message, FCommonData) then
            Exit;
      end;
  end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then
    inherited
  else begin
    case Message.Msg of
      WM_PAINT: begin
        if not InAnimationProcess then begin
          ControlState := ControlState + [csCustomPaint];
          OurPaintHandler(TWMPaint(Message).DC);
        end;
        Exit;
      end;

      WM_ERASEBKGND: begin
        if not InUpdating(SkinData) and not FCommonData.BGChanged then begin
          CopyWinControlCache(Self, FCommonData, Rect(BorderWidth, BorderWidth, 0, 0), MkRect(Self), TWMPaint(Message).DC, True);
          sVCLUtils.PaintControls(TWMPaint(Message).DC, Self, FCommonData.BGChanged, MkPoint);
        end;
        Exit;
      end;

      WM_MOVE:
        with FCommonData.CommonSkinData.gd[FCommonData.SkinIndex] do
          if (Props[0].Transparency > 0) or (Props[1].Transparency > 0) then begin
            FCommonData.BGChanged := True;
            if csDesigning in ComponentState then begin
              Repaint;
              Perform(WM_NCPAINT, 0, 0);
            end;
          end;

      WM_PRINT: begin
        if Visible or (csDesigning in ComponentState) then begin
//          CheckLastError;
          DC := TWMPaint(Message).DC;
          cr := Rect(1, 1, 1, 1);
          GetClipBox(DC, cR);
          if not InUpdating(SkinData, True) then begin
            PrepareCache;
            if (BorderWidth <> 0) then
              BitBltBorder(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, BorderWidth);

            MoveWindowOrg(DC, BorderWidth, BorderWidth);
            cR := GetClientRect;
            IntersectClipRect(DC, 0, 0, WidthOf(cR), HeightOf(cR));
            OurPaintHandler(DC);
          end;
        end;
        Exit;
      end;

      WM_NCPAINT: begin
        if Visible or (csDesigning in ComponentState) then
          if not InAnimationProcess and not  InUpdating(FCommonData) then begin
            PrepareCache;
            if (BorderWidth <> 0) then begin
              DC := GetWindowDC(Handle);
              SaveIndex := SaveDC(DC);
              try
                BitBltBorder(DC, 0, 0, Width, Height, FCommonData.FCacheBmp.Canvas.Handle, 0, 0, BorderWidth);
              finally
                RestoreDC(DC, SaveIndex);
                ReleaseDC(Handle, DC)
              end;
            end;
          end;
          
        Exit;
      end;

    end;
    if not CommonWndProc(Message, FCommonData) then begin
      inherited;
      case Message.Msg of
        WM_USER + 11 {Text changed}, DM_SETDEFID, 1033, 1034:
          SkinData.BGChanged := True;

        WM_PAINT:
          ControlState := ControlState - [csCustomPaint];

        WM_SIZE:
          if Visible then begin
            SendToForm;
            if (BorderWidth <> 0) then
              Perform(WM_NCPAINT, 0, 0);
          end;

        CM_VISIBLECHANGED:
          SendToForm;
      end;
    end;
  end
end;

end.
