unit sFade;
{$I sDefs.inc}

interface
{$R+}

uses
  Windows, SysUtils, Classes, ExtCtrls, Graphics,
  sCommonData, sConst, acThdTimer, sSkinManager;


function EventEnabled(Event: TacAnimatEvent; CurrentProperty: TacAnimatEvents; SkinManager: TsSkinManager = nil): boolean;
procedure DoChangePaint(Data: TsCommonData; State: integer; AAnimProc: TacAnimProc; AllowAnimation: boolean; Fast: boolean; MakeGlowing: boolean = True);
function UpdateGlowing_CB (Data: TObject; iIteration: integer): boolean;
function UpdateGraphic_CB (Data: TObject; iIteration: integer): boolean;
function UpdateWindow_CB  (Data: TObject; iIteration: integer): boolean;


implementation

uses
  Forms, Controls, StdCtrls,
  sMessages, sStyleSimply, sVCLUtils, sGraphUtils, acGlow, acntUtils;


function EventEnabled(Event: TacAnimatEvent; CurrentProperty: TacAnimatEvents; SkinManager: TsSkinManager = nil): boolean;
begin
  if SkinManager = nil then
    SkinManager := DefaultManager;

  if SkinManager <> nil then
    Result := (Event in CurrentProperty) or ((aeGlobalDef in CurrentProperty) and (acBtnEvents[Event] in SkinManager.AnimEffects.Buttons.Events))
  else
    Result := True;
end;


function UpdateGlowing_CB(Data: TObject; iIteration: integer): boolean;
var
  sd: TsCommonData;
begin
  Result := False;
  if Data is TsCommonData then begin
    sd := TsCommonData(Data);
    if (sd.FOwnerControl <> nil) and not (csDestroying in sd.FOwnerControl.ComponentState) and (sd.AnimTimer.Iterations > 0) then
      with sd.AnimTimer do
        if sd.AnimTimer.Iteration >= sd.AnimTimer.Iterations then begin
          if State <> 1 then
            HideGlow(sd.GlowID);

          if State = 0 then
            StopTimer(sd);
        end
        else begin
          Result := True;
          if sd.GlowID >= 0 then begin
            if State = 1 then
              Glow := Glow + GlowStep
            else
              Glow := Glow - GlowStep;

            SetGlowAlpha(sd.GlowID, LimitIt(Round(sd.AnimTimer.Glow), 0, MaxByte));
          end;
        end;
  end;
end;


function UpdateGraphic_CB(Data: TObject; iIteration: integer): boolean;
var
  Alpha: byte;
  sd: TsCommonData;
  Ctrl: TGraphicControl;
begin
  Result := False;
  if Data is TsCommonData then begin
    sd := TsCommonData(Data);
    if (sd.FOwnerControl is TGraphicControl) and not (csDestroying in sd.FOwnerControl.ComponentState) and (sd.AnimTimer.Iterations <> 0) and not sd.AnimTimer.Destroyed then
      with sd.AnimTimer do
        if Iterations > 0 then begin
          Ctrl := TGraphicControl(sd.FOwnerControl);
          if BmpOut <> nil then begin
            BmpOut.Width  := Ctrl.Width;
            BmpOut.Height := Ctrl.Height;
          end
          else
            sd.AnimTimer.BmpOut := CreateBmp32(Ctrl);

          BitBlt(sd.AnimTimer.BmpOut.Canvas.Handle, 0, 0, BmpOut.Width, BmpOut.Height, BmpFrom.Canvas.Handle, 0, 0, SRCCOPY);
          case State of
            0, 2: Glow := Glow - GlowStep;
            1:    Glow := Glow + GlowStep
            else  Glow := MaxByte - (Iteration / Iterations) * MaxByte;
          end;
          Alpha := LimitIt(Round(Glow), 0, MaxByte);
          SumBmpRect(BmpOut, BmpTo, iff(State = 1, MaxByte - Alpha, Alpha), MkRect(BmpOut), MkPoint);
          SendAMessage(Ctrl, AC_UPDATING);
          SendAMessage(Ctrl, AC_INVALIDATE);
          if Assigned(acMagnForm) then
            SendAMessage(acMagnForm.Handle, AC_REFRESH);

          if sd.AnimTimer.Iteration >= sd.AnimTimer.Iterations then begin
            if (State = 0) and (Alpha > 0) then begin
              if sd.GlowID >= 0 then
                SetGlowAlpha(sd.GlowID, Alpha);

              Iteration := Iteration - 1;
              UpdateWindow_CB(Data, iIteration);
            end
            else begin
              if State = 0 then
                StopTimer(sd);

              if State <> 1 then
                HideGlow(sd.GlowID);
            end;
          end
          else begin
            Result := True;
            if sd.GlowID >= 0 then begin
              SetGlowAlpha(sd.GlowID, Alpha);
              if (State = 0) and (Alpha < 10) then begin
                Glow := 0;
                HideGlow(sd.GlowID);
              end;
            end;
          end;
        end;
  end;
end;


function UpdateWindow_CB(Data: TObject; iIteration: integer): boolean;
var
  DC: HDC;
  R: TRect;
  i: integer;
  Alpha: byte;
  Bmp: TBitmap;
  Ctrl: TControl;
  Handle: THandle;
  sd: TsCommonData;
begin
  Result := False;
  if Data is TsCommonData then begin
    sd := TsCommonData(Data);
    if Assigned(sd.AnimTimer) and not sd.AnimTimer.Destroyed then begin
      if sd.FOwnerControl is TWinControl then begin
        R := TWinControl(sd.FOwnerControl).BoundsRect;
        if (TWinControl(sd.FOwnerControl).HandleAllocated) then
          Handle := TWinControl(sd.FOwnerControl).Handle
        else
          Handle := 0;
      end
      else
        if sd.OwnerHandle <> 0 then begin
          GetWindowRect(sd.OwnerHandle, R);
          Handle := sd.OwnerHandle;
        end
        else
          Handle := 0;

      with sd.AnimTimer do
        if (Iterations > 0) and (Handle <> 0) then begin
          if BmpOut = nil then
            BmpOut := CreateBmp32(R)
          else begin
            BmpOut.Width  := sd.FCacheBmp.Width;
            BmpOut.Height := sd.FCacheBmp.Height;
          end;
          BitBlt(BmpOut.Canvas.Handle, 0, 0, BmpOut.Width, BmpOut.Height, BmpFrom.Canvas.Handle, 0, 0, SRCCOPY);
          case State of
            0, 2: Glow := Glow - GlowStep;
            1:    Glow := Glow + GlowStep
            else  Glow := MaxByte - (Iteration / Iterations) * MaxByte;
          end;
          Alpha := LimitIt(Round(Glow), 0, MaxByte);

          SumBmpRect(BmpOut, BmpTo, iff(State = 1, MaxByte - Alpha, Alpha), MkRect(BmpOut), MkPoint);

          if (sd.FOwnerControl is TWinControl) and (TWinControl(sd.FOwnerControl).ControlCount > 0) then begin
            Bmp := TBitmap.Create;
            try
              Bmp.Assign(BmpOut);
              for i := 0 to TWinControl(sd.FOwnerControl).ControlCount - 1 do begin
                Ctrl := TWinControl(sd.FOwnerControl).Controls[i];
                MoveWindowOrg(Bmp.Canvas.Handle, Ctrl.Left, Ctrl.Top);
                SkinPaintTo(Bmp, Ctrl);
                MoveWindowOrg(Bmp.Canvas.Handle, -Ctrl.Left, -Ctrl.Top);
              end;
              CopyBmp(BmpOut, Bmp);
            finally
              Bmp.Free;
            end;
          end;

          DC := GetWindowDC(Handle);
          try
            if Application.BiDiMode = bdRightToLeft then
              acSetLayout(DC, 0);

            BitBlt(DC, 0, 0, BmpOut.Width, BmpOut.Height, BmpOut.Canvas.Handle, 0, 0, SRCCOPY);
          finally
            ReleaseDC(Handle, DC);
          end;

          if (sd.AnimTimer.Iteration >= sd.AnimTimer.Iterations) then
            if (State = 0) and (Alpha > 0) then begin
              if sd.GlowID >= 0 then
                SetGlowAlpha(sd.GlowID, Alpha);

              Iteration := Iteration - 1;
              UpdateWindow_CB(Data, iIteration);
            end
            else begin
              if State = 0 then
                StopTimer(sd);

              if State <> 1 then
                HideGlow(sd.GlowID);
            end
          else begin
            Result := True;
            if sd.GlowID >= 0 then begin
              SetGlowAlpha(sd.GlowID, Alpha);
              if (State = 0) and (Alpha < 10) then begin
                Glow := 0;
                HideGlow(sd.GlowID);
              end;
            end;
          end;
        end;
    end;
  end;
end;


procedure AnimChange(SkinData: TsCommonData; State: integer; AAnimProc: TacAnimProc; Fast: boolean);
var
  i: integer;
begin
  with SkinData do begin
    i := GetNewTimer(AnimTimer, FOwnerControl, State);
    if (AnimTimer.State = -1) or (State <> AnimTimer.State) then begin // If not started already
      if (AnimTimer.BmpOut = nil) or (SkinData.FCacheBmp.Width <> SkinData.AnimTimer.BmpOut.Width) or (SkinData.FCacheBmp.Height <> SkinData.AnimTimer.BmpOut.Height) then
        FreeAndNil(AnimTimer.BmpOut);

      AnimTimer.CopyFrom(AnimTimer.BmpFrom, FCacheBmp, MkRect(FCacheBmp));
      if BGChanged then
        if FOwnerControl <> nil then begin
          if SendAMessage(FOwnerControl, AC_PREPARECACHE) <> 0 then // BG is not ready
            AnimTimer.Enabled := False;

          if (FOwnerControl is TButtonControl) and (TWinControl(FOwnerControl).ControlCount > 0) then begin
            FCacheBmp.Canvas.Lock;
            sVCLUtils.PaintControls(FCacheBmp.Canvas.Handle, TWinControl(FOwnerControl), True, MkPoint);
            FCacheBmp.Canvas.UnLock;
          end;
        end
        else
          if SendAMessage(OwnerHandle, AC_PREPARECACHE) <> 0 then // BG is not ready
            AnimTimer.Enabled := False;

      AnimTimer.CopyFrom(AnimTimer.BmpTo, FCacheBmp, MkRect(FCacheBmp));
      AnimTimer.InitData(SkinData, i, AAnimProc, State, Fast);
      AnimTimer.TimeHandler;
    end;
  end;
end;


procedure DoChangePaint(Data: TsCommonData; State: integer; AAnimProc: TacAnimProc; AllowAnimation: boolean; Fast: boolean; MakeGlowing: boolean = True);
begin
ResetLastError;
  if Data.Skinned then
    if not SkinIsChanging(Data) and AllowAnimation and not FadingForbidden and (Data.FCacheBmp <> nil) and not Data.BGChanged and (Data.SkinManager <> nil) and Data.SkinManager.Effects.AllowAnimation then begin // Animated
      if MakeGlowing and (State < 100) and (Data.GlowID < 0) then
        ShowGlowingIfNeeded(Data, False, Data.OwnerHandle, 0);

      Data.BGChanged := True;
      AnimChange(Data, State, AAnimProc, Fast);
    end
    else begin // Without animation
      Data.BGChanged := True;
      Data.Invalidate;
      if MakeGlowing and Data.FMouseAbove then begin
        if (State < 100) and (Data.GlowID < 0) then
          ShowGlowingIfNeeded(Data, False, Data.OwnerHandle)
      end
      else
        if not Data.FMouseAbove then
          HideGlow(Data.GlowID);
    end
  else
    Data.Invalidate;

  CheckLastError;
end;

end.
