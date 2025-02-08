{ Summary
  This unit contains the TJSCheckBox control. This custom check box control supports transparency and a
  unicode caption. }
unit JSCheckBox;

interface

{$I lmddlgcmps.inc}

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, StdCtrls, Math,
  {$IFNDEF DELPHI5}
  Types,
  {$ENDIF DELPHI5}
  {$IFDEF DELPHIXE3}
  System.UITypes,
  {$ENDIF DELPHIXE}
  {$IFDEF THEMES}
  Themes,
  {$ENDIF THEMES}
  JSTypes;

type
  { Base control used as the verification check box that appears
    in the ButtonBar section of the dialog.                      }
  TJSCustomCheckBox = class(TCustomControl)
  private
    FChecked: Boolean;
    FAlignment: TLeftRight;
    FCheckBitmap: TBitmap;
    FCaption: TJSString;
    FMouseInControl: Boolean;
    FState: TCheckBoxState; // cache check bitmap
    procedure SetTransparent(const Value: Boolean);
    procedure SetChecked(const Value: Boolean);
    procedure SetAlignment(const Value: TLeftRight);
    function CalculateCheckRect: TRect;{$IFDEF INLINE}inline;{$ENDIF}
    function CalculateCaptionRect: TRect;{$IFDEF INLINE}inline;{$ENDIF}
    procedure InitialiseCheckBitmap;
    procedure SetCaption(const Value: TJSString);
    procedure SetMouseInControl(const Value: Boolean);
    procedure SetState(const Value: TCheckBoxState);
    function GetTransparent: Boolean;
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMTextchanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure BMSetCheck(var Message: TMessage); message BM_SETCHECK;
    {$IFDEF THEMES}
    { Summary
      Returns the applicable theme element for the checkbox.
      Description
      Returns the applicable theme element to use when painting the control at a particular point in time.
      Returns
      The theme element to use for painting.                                                                }
    function GetThemeElement: TThemedElementDetails; virtual;
    {$ENDIF THEMES}
    procedure DrawCheck; virtual;
    procedure DrawCaption; virtual;
    procedure DrawBackground; virtual;
    { Summary
      Test to see if the X and Y coordinates are located within the
      controls caption.                                             }
    function HitTestCaption(const X, Y: Integer): Boolean; virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Paint; override;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    { Toggle the state of the control }
    procedure Toggle; virtual;
    procedure Click; override;
    procedure DoClick; virtual;
    { Is True if the mouse pointer is currently in the control bounds }
    property MouseInControl: Boolean read FMouseInControl write SetMouseInControl;
    { Current check box state of the control }
    property State: TCheckBoxState read FState write SetState default cbUnchecked;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Controls the horizontal placement of the check box caption. }
    property Alignment: TLeftRight read FAlignment write SetAlignment default taLeftJustify;
    { Use the WideCaption property if the caption text needs to
      support unicode.

      The value of WideCaption is only used when the UseWideCaption
      property is True.                                             }
    property Caption: TJSString read FCaption write SetCaption;
    { Specifies whether the check box control is checked. }
    property Checked: Boolean read FChecked write SetChecked default False;
    { Specifies whether controls that sit below the check box are
      visible through the label.                                  }
    property Transparent: Boolean read GetTransparent write SetTransparent default True;
  end;

  { Control used as the verification check box that appears in the ButtonBar section of the dialog. }
  TJSCheckBox = class(TJSCustomCheckBox)
  published
    { Designates the action associated with the control. }
    property Action;
    property Alignment;
    property BiDiMode;
    { Specifies a text string that identifies the control to the user. }
    property Caption;
    property Checked;
    { Specifies the background color of the check box. Value is
      ignored if the Transparent property is TRUE.              }
    property Color;
    { Controls whether the control responds to mouse, keyboard, and
      timer events.                                                 }
    property Enabled;
    { Controls the attributes of text written on or in the control. }
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property Transparent;
    { Occurs when the user clicks the control. }
    property OnClick;
  end;

implementation

uses
  ActnList, Forms, JSUnicode;

function IsMouseButtonPressed: Boolean;
begin
  Result := not (((GetAsyncKeyState(VK_RBUTTON)and $8000)=0) and
            ((GetAsyncKeyState(VK_LBUTTON)and $8000)=0));
end;

{ TJSCustomCheckBox }

procedure TJSCustomCheckBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  {$IFDEF THEMES}
  if {$IFNDEF DELPHIXE2}ThemeServices.ThemesEnabled{$ELSE}StyleServices.Enabled{$ENDIF} then
    Invalidate;
  {$ENDIF THEMES}
  inherited;
  if Button = mbLeft then
  begin
    SetFocus;
    Invalidate;
  end;
end;

procedure TJSCustomCheckBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and Enabled then
  begin
    if (PtInRect(CalculateCheckRect, Point(X, Y))) or HitTestCaption(X, Y) then
      Checked := not Checked;
  end;
  inherited;
  DoClick;
end;

procedure TJSCustomCheckBox.Paint;
begin
  Canvas.Font.Assign(Font);
  DrawBackground;
  DrawCheck;
  DrawCaption;
end;

procedure TJSCustomCheckBox.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
var
  lAction: TCustomAction;
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
  begin
    lAction := TCustomAction(Sender);
    begin
      if not CheckDefaults or (Self.Checked = False) then
        Self.Checked := lAction.Checked;
    end;
    Caption := lAction.Caption;
  end;
end;

procedure TJSCustomCheckBox.BMSetCheck(var Message: TMessage);
begin
  FChecked := Boolean(Message.wParam);
  Invalidate;
end;

function TJSCustomCheckBox.CalculateCaptionRect: TRect;
begin
  result := ClientRect;
  if BidiMode = bdLeftToRight then
  begin
    case FAlignment of
      taLeftJustify: result.Left := result.Left + FCheckBitmap.Width + 4;
      taRightJustify:
        begin
          result.Left := result.Left + 2;
          result.Right := result.Right - FCheckBitmap.Width - 1;
        end;
    end;
  end
  else
  begin
    result.Left := result.Left + 2;
    result.Right := result.Right - FCheckBitmap.Width - 1;
  end;
end;

function TJSCustomCheckBox.CalculateCheckRect: TRect;
begin
  if BidiMode = bdLeftToRight then
  begin
    case FAlignment of
      taLeftJustify: result.Left := 0;
      taRightJustify: result.Left := Width - FCheckBitmap.Width;
    end;
    result.Top := Max(1, ((Height - FCheckBitmap.Height + 1) div 2));
    result.BottomRight := Point(result.Left + FCheckBitmap.Width, result.Top + FCheckBitmap.Height);
  end
  else
  begin
    Result.Left := Width - FCheckBitmap.Width;
    Result.Top := Max(1, ((Height - FCheckBitmap.Height + 1) div 2));
    Result.BottomRight := Point(result.Left + FCheckBitmap.Width, result.Top + FCheckBitmap.Height);
  end;
end;

procedure TJSCustomCheckBox.Click;
begin
  // inherited;
end;

procedure TJSCustomCheckBox.CMMouseenter(var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
end;

procedure TJSCustomCheckBox.CMMouseleave(var Message: TMessage);
begin
  inherited;
  MouseInControl := False;
end;

procedure TJSCustomCheckBox.CMTextchanged(var Message: TMessage);
begin
  Invalidate;
end;

constructor TJSCustomCheckBox.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csSetCaption];
  FAlignment := taLeftJustify;
  InitialiseCheckBitmap;
  Height := MulDiv(17, Screen.PixelsPerInch, 96);
  Width := 97;
  ParentFont := True;
  TabStop := True;
  {$IFDEF THEMES}
  if {$IFNDEF DELPHIXE2}ThemeServices.ThemesEnabled{$ELSE}StyleServices.Enabled{$ENDIF} then
    ControlStyle := ControlStyle - [csOpaque]
  else
  {$ELSE THEMES}
    ControlStyle := ControlStyle + [csOpaque];
  {$ENDIF THEMES}
  Color := clBtnFace;
  ParentColor := False;
end;

destructor TJSCustomCheckBox.Destroy;
begin
  FCheckBitmap.Free;
  inherited;
end;

procedure TJSCustomCheckBox.DoClick;
begin
  if Assigned(OnClick) then
    OnClick(Self);
end;

procedure TJSCustomCheckBox.InitialiseCheckBitmap;
begin
  FCheckBitmap := TBitmap.Create;
  FCheckBitmap.Transparent := True;
  FCheckBitmap.Handle := LoadBitmap(0, PChar(OBM_CHECK));
end;

procedure TJSCustomCheckBox.DrawBackground;
begin
  if not Transparent then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := Color;
    Canvas.FillRect(ClientRect);
  end
  else
    Canvas.Brush.Style := bsClear;
end;

procedure TJSCustomCheckBox.DrawCaption;
var
  lRect: TRect;
  lFlags: LongInt;
begin
  lRect := CalculateCaptionRect;
  inc(lRect.Top, 1);
  if Focused then
  begin
    Canvas.Pen.Color := clBlack;
    Canvas.Brush.Style := bsSolid;
    if BiDiMode = bdLeftToRight then
      inc(lRect.Left, 4);
    DrawFocusRect(Canvas.Handle, lRect);
    if BiDiMode = bdLeftToRight then
      dec(lRect.Left, 4);
    Canvas.Brush.Style := bsClear;
  end;
  Canvas.Brush.Style := bsClear;
  lFlags := DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER or DT_LEFT;
  lFlags := DrawTextBiDiModeFlags(lFlags);
  JSDrawText(Canvas.Handle, Caption, Font, lRect, lFlags);
end;

procedure TJSCustomCheckBox.DrawCheck;
var
  lPt: TPoint; // hit point to check for internal color of frame control
  lInternalColor: TColor;
  lRect: TRect;
  lDrawRect: TRect;
  lBitmapWidth: Integer;
  lBitmapHeight: Integer;
  {$IFDEF THEMES}
  LDetails: TThemedElementDetails;
  {$ENDIF THEMES}
begin
  lRect := CalculateCheckRect;
  {$IFDEF THEMES}
  if {$IFNDEF DELPHIXE2}ThemeServices.ThemesEnabled{$ELSE}StyleServices.Enabled{$ENDIF} then
  begin
    LDetails := GetThemeElement;
    {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.DrawElement(Canvas.Handle, LDetails, lRect);
  end
  else
  {$ENDIF THEMES}
  begin
    DrawFrameControl(Canvas.Handle, lRect, DFC_BUTTON, DFCS_BUTTONCHECK);
    if Enabled then
      Canvas.Brush.Color := clWindow
    else
      Canvas.Brush.Color := clBtnFace;
    lBitmapWidth := MulDiv(FCheckBitmap.Width, Screen.PixelsPerInch, 96);
    lBitmapHeight := MulDiv(FCheckBitmap.Height, Screen.PixelsPerInch, 96);
    lPt.X := lRect.Left + lBitmapWidth div 2;
    lPt.Y := lRect.Top + lBitmapHeight div 2;
    lInternalColor := Canvas.Pixels[lPt.X, lPt.Y];
    if lInternalColor <> Canvas.Brush.Color then
      Canvas.FloodFill(lPt.X, lPt.Y, lInternalColor, fsSurface);
    if Checked then
    begin
      lDrawRect := Rect(lRect.Left + 1, lRect.Top,
        lRect.Left + 1 + lBitmapWidth,
        lRect.Top + lBitmapHeight);
      Canvas.StretchDraw(lDrawRect, FCheckBitmap);
//      Canvas.Draw(lRect.Left + 1, lRect.Top, FCheckBitmap);
    end;
  end;
end;

{$IFDEF THEMES}
function TJSCustomCheckBox.GetThemeElement: TThemedElementDetails;
begin
  if not Checked then
  begin
    if Enabled then
    begin
      if IsMouseButtonPressed then
        Result := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.GetElementDetails(tbCheckBoxUncheckedPressed)
      else if not MouseInControl then
        Result := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.GetElementDetails(tbCheckBoxUncheckedNormal)
      else
        Result := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.GetElementDetails(tbCheckBoxUncheckedHot)
    end
    else
      Result := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.GetElementDetails(tbCheckBoxUncheckedDisabled)
  end
  else
  begin
    if Enabled then
    begin
      if IsMouseButtonPressed then
        Result := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.GetElementDetails(tbCheckBoxCheckedPressed)
      else if not MouseInControl then
        Result := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.GetElementDetails(tbCheckBoxCheckedNormal)
      else
        Result := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.GetElementDetails(tbCheckBoxCheckedHot)
    end
    else
      Result := {$IFNDEF DELPHIXE2}ThemeServices{$ELSE}StyleServices{$ENDIF}.GetElementDetails(tbCheckBoxCheckedDisabled);
  end;
end;
{$ENDIF THEMES}

function TJSCustomCheckBox.GetTransparent: Boolean;
begin
  result := not (csOpaque in ControlStyle);
end;

function TJSCustomCheckBox.HitTestCaption(const X, Y: Integer): Boolean;
var
  lRect: TRect;
begin
  lRect := CalculateCaptionRect;
  result := PtInRect(lRect, Point(X, Y));
end;

procedure TJSCustomCheckBox.SetAlignment(const Value: TLeftRight);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TJSCustomCheckBox.SetChecked(const Value: Boolean);
begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    if FChecked then
      FState := cbChecked
    else
      FState := cbUnchecked;
    Invalidate;
  end;
end;

procedure TJSCustomCheckBox.SetMouseInControl(const Value: Boolean);
begin
  if FMouseInControl <> Value then
  begin
    FMouseInControl := Value;
    {$IFDEF THEMES}
    // only invalidate when control is themed
    if {$IFNDEF DELPHIXE2}ThemeServices.ThemesEnabled{$ELSE}StyleServices.Enabled{$ENDIF} then
      Invalidate;
    {$ENDIF THEMES}
  end;
end;

procedure TJSCustomCheckBox.SetState(const Value: TCheckBoxState);
begin
  if FState <> Value then
  begin
    FState := Value;
    if HandleAllocated then
      SendMessage(Handle, BM_SETCHECK, WPARAM(FState), 0);
//    if not ClicksDisabled then Click;
  end;
end;

procedure TJSCustomCheckBox.SetTransparent(const Value: Boolean);
begin
  if Transparent <> Value then
  begin
    if Value then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;

procedure TJSCustomCheckBox.SetCaption(const Value: TJSString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Invalidate;
  end;
end;

procedure TJSCustomCheckBox.Toggle;
begin
  case State of
    cbUnchecked: State := cbChecked;
    cbChecked: State := cbUnchecked;
    cbGrayed: State := cbChecked;
  end;
end;

procedure TJSCustomCheckBox.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TJSCustomCheckBox.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TJSCustomCheckBox.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  SetFocus;
  Invalidate;
end;

procedure TJSCustomCheckBox.CMDialogChar(var Message: TCMDialogChar);
begin
  if IsAccel(Message.CharCode, Caption) and CanFocus then
  begin
    SetFocus;
    if Focused then
      Toggle;
    Message.Result := 1;
  end
  else
    inherited;
end;

end.
