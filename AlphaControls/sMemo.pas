unit sMemo;
{$I sDefs.inc}
//{$DEFINE LOGGED}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, StdCtrls,
  {$IFDEF TNTUNICODE} TntStdCtrls, TntClasses, TntSysUtils, TntActnList, TntControls, {$ENDIF}
  {$IFDEF LOGGED} sDebugMsgs, {$ENDIF}
  {$IFDEF DELPHI_XE2} UITypes, {$ENDIF}
  sConst, sCommonData, sDefaults, acSBUtils;


type
{$IFDEF DELPHI_XE3}[ComponentPlatformsAttribute(pidWin32 or pidWin64)]{$ENDIF}
{$IFDEF TNTUNICODE}
  TsMemo = class(TTntMemo)
{$ELSE}
  TsMemo = class(TMemo)
{$ENDIF}
{$IFNDEF NOTFORHELP}
  private
    FOnVScroll,
    FOnScrollCaret: TNotifyEvent;

    FBoundLabel: TsBoundLabel;
    FCommonData: TsScrollWndData;
    FDisabledKind: TsDisabledKind;
    procedure SetDisabledKind(const Value: TsDisabledKind);
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    function FontStored: boolean;
    function ColorStored: boolean;
  public
    ListSW: TacScrollWnd;
    procedure AfterConstruction; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure WndProc(var Message: TMessage); override;
  published
    property Text;
    property CharCase;
    Property OnScrollCaret: TNotifyEvent read FOnScrollCaret write FOnScrollCaret;
    Property OnVScroll:     TNotifyEvent read FOnVScroll     write FOnVScroll;
    property Color stored ColorStored;
    property Font stored FontStored;
    property ParentFont stored FontStored;
{$ENDIF} // NOTFORHELP
    property BoundLabel: TsBoundLabel read FBoundLabel write FBoundLabel;
    property SkinData: TsScrollWndData read FCommonData write FCommonData;
    property DisabledKind: TsDisabledKind read FDisabledKind write SetDisabledKind default DefDisabledKind;
{$IFDEF TNTUNICODE}
    property SelText;
    property SelStart;
    property SelLength;
{$ENDIF}
  end;


implementation

uses Menus, Graphics, ExtCtrls,
  {$IFDEF DELPHI7UP} Themes, UxTheme, {$ENDIF}
  sSkinProvider, sStyleSimply, sVCLUtils, sMessages, sGraphUtils, sAlphaGraph, acntUtils;


procedure TsMemo.AfterConstruction;
begin
  inherited AfterConstruction;
  FCommonData.Loaded(False);
  if HandleAllocated then
    RefreshEditScrolls(SkinData, ListSW);
end;


function TsMemo.FontStored: boolean;
begin
  Result := IsCustomFont(Self, Font, not SkinData.Skinned or SkinData.CustomFont);
end;


function TsMemo.ColorStored: boolean;
begin
  Result := not SkinData.Skinned or SkinData.CustomColor;
end;


constructor TsMemo.Create(AOwner: TComponent);
begin
  FCommonData := TsScrollWndData.Create(Self);
  FCommonData.COC := COC_TsMemo;
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque];
  FDisabledKind := DefDisabledKind;
  FBoundLabel := TsBoundLabel.Create(Self, FCommonData);
end;


destructor TsMemo.Destroy;
begin
  FreeAndNil(ListSW);
  FreeAndNil(FBoundLabel);
  FreeAndNil(FCommonData);
  inherited Destroy;
end;


procedure TsMemo.Loaded;
begin
  inherited Loaded;
  FCommonData.Loaded(False);
//  RefreshEditScrolls(SkinData, ListSW);
end;


procedure TsMemo.SetDisabledKind(const Value: TsDisabledKind);
begin
  if FDisabledKind <> Value then begin
    FDisabledKind := Value;
    FCommonData.Invalidate;
  end;
end;


procedure TsMemo.WndProc(var Message: TMessage);
var
  PS: TPaintStruct;
  State: integer;
begin
{$IFDEF LOGGED}
  AddToLog(Message);
{$ENDIF}
  case Message.Msg of
    SM_ALPHACMD:
      case Message.WParamHi of
        AC_CTRLHANDLED: begin
          Message.Result := 1;
          Exit;
        end; // AlphaSkins supported

        AC_SETNEWSKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            CommonMessage(Message, FCommonData);
            Exit;
          end;

        AC_REMOVESKIN:
          if ACUInt(Message.LParam) = ACUInt(SkinData.SkinManager) then begin
            if ListSW <> nil then begin
              FreeAndNil(ListSW);
              RecreateWnd;
            end;
            Exit;
          end;

        AC_REFRESH:
          if RefreshNeeded(SkinData, Message) then begin
            RefreshEditScrolls(SkinData, ListSW);
            CommonMessage(Message, FCommonData);
            if HandleAllocated and Visible then
              RedrawWindow(Handle, nil, 0, RDWA_REPAINT);

            Exit;
          end;

        AC_GETDEFSECTION: begin
          Message.Result := 0 + 1;
          Exit;
        end;

        AC_GETDEFINDEX: begin
          if FCommonData.SkinManager <> nil then
            Message.Result := FCommonData.SkinManager.SkinCommonInfo.Sections[ssEdit] + 1;

          Exit;
        end;

        AC_SETGLASSMODE: begin
          CommonMessage(Message, FCommonData);
          Exit;
        end;
      end;

    CM_FONTCHANGED:
      if Showing and HandleAllocated then
        RedrawWindow(Handle, nil, 0, RDWA_REPAINT);
  end;

  if not ControlIsReady(Self) or not FCommonData.Skinned then
    inherited
  else begin
    case Message.Msg of
      WM_ERASEBKGND:
        if (SkinData.SkinIndex >= 0) and InUpdating(FCommonData) then
          Exit;
(*
        else
          if not DoubleBuffered and not (StyleServices.Enabled and Assigned(Parent) and (csParentBackground in ControlStyle)) then begin
            if (SkinData.TranspMode = TM_PARTIAL) and not IsFluentOS and IsWinVistaUp {$IFNDEF FLUENTCOMP}and Assigned(BeginBufferedPaint){$ENDIF} then begin
              PaintBuffer := BeginBufferedPaint(TWMPaint(Message).DC, MkRect(SkinData.FCacheBmp), BPBF_TOPDOWNDIB, nil, TWMPaint(Message).DC);
              BitBlt(TWMPaint(Message).DC, 0, 0, Width, Height, SkinData.FCacheBmp.Canvas.Handle, 0, 0, SRCCOPY);
              EndBufferedPaint(PaintBuffer, False);
              Message.Result := 1;
              Exit;
            end
            else
              PaintBuffer := 0;
          end;
*)
      WM_PAINT: begin
        if (SkinData.TranspMode = TM_PARTIAL) and not DoubleBuffered and not IsFluentOS and IsWinVistaUp {$IFNDEF FLUENTCOMP}and Assigned(BeginBufferedPaint){$ENDIF} then begin
          DoubleBuffered := True; // Avoiding a problem of painting when bluring on form used and memo is opaque under old Windows
        end;

        // Correction of used color if not equal
        if not SkinData.CustomColor and SkinData.Skinned then
          with SkinData.CommonSkinData.gd[SkinData.SkinIndex] do begin
            State := integer(SkinData.FFocused or SkinData.FMouseAbove and MayBeHot(SkinData));
            if Color <> Props[State].Color then begin
              SkinData.SavedColor := Color;
              SkinData.BGChanged := True;
              Color := Props[State].Color;
            end;
          end;

        if not SkinData.CustomFont and SkinData.Skinned then
          with SkinData.CommonSkinData.gd[SkinData.SkinIndex] do begin
            State := integer(SkinData.FFocused or SkinData.FMouseAbove and MayBeHot(SkinData));
            if Font.Color <> Props[State].FontColor.Color then begin
              SkinData.SavedFontColor := Font.Color;
              SkinData.BGChanged := True;
              Font.Color := Props[State].FontColor.Color;
            end;
          end;

        if InUpdating(FCommonData) then begin // Exit if parent is not ready yet
          BeginPaint(Handle, PS);
          EndPaint  (Handle, PS);
        end
        else
          inherited;

        Exit;
      end;
    end;
    if CommonWndProc(Message, FCommonData) then
      Exit;

    inherited;
    case Message.Msg of
      CM_SHOWINGCHANGED:
        RefreshEditScrolls(SkinData, ListSW);

      CM_VISIBLECHANGED, CM_ENABLEDCHANGED, WM_SETFONT:
        FCommonData.Invalidate;

      CM_TEXTCHANGED, CM_CHANGED:
        if Assigned(ListSW) then
          UpdateScrolls(ListSW, True);

      EM_SETSEL:
        if Assigned(FOnScrollCaret) then
          FOnScrollCaret(Self);

      WM_HSCROLL, WM_VSCROLL:
        if (Message.Msg = WM_VSCROLL) and Assigned(FOnVScroll) then
          FOnVScroll(Self);
    end;
  end;
  if Assigned(BoundLabel) then
    BoundLabel.HandleOwnerMsg(Message, Self);
end;


procedure TsMemo.KeyDown(var Key: Word; Shift: TShiftState);
var
  M: tagMsg;
begin
  inherited KeyDown(Key, Shift);
  if ShortCut(Key, Shift) = scCtrl + ord('A') then begin
    SelectAll;
    Key := 0;
    PeekMessage(M, Handle, WM_CHAR, WM_CHAR, PM_REMOVE);
  end;
end;

end.

