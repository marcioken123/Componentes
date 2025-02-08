unit LMDThemedComboBox;
{$I lmdcmps.INC}

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

LMDThemedComboBox unit (VB)
---------------------------

Todo:

*  Artefacts in dropdownbutton (e.g. white corners in bluechrome.msstyles)
** .Net glitches

Changes
-------
Release 9.0 (July 2008)
 + ThemeMode property

Release 8.08 (21 April 2006)
 - Background color  fixed for dropdown listbox;

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, StdCtrls, Controls, Messages, Windows, Graphics, ExtCtrls, SysUtils,
  Themes, LMDClass, LMDTypes, intfLMDBase, LMDBoundLabel;

type
  {------------------------- TLMDThemedComboBox -------------------------}
  TLMDThemedComboBox = class(TCustomComboBox)
  private
    FAbout: TLMDAboutVar;
    FBtnWidth: integer;
    FPressed,
    FMouseAbove,
    FMouseAboveBtn: boolean;
    FListBoxHandle: THandle;
    FEditBrushHandle: HBRUSH;
    FBgrColor: TColor;
    FSbWidth: integer;
    FPainting: boolean;
    FFillListBoxBgr: boolean;
    FThemeMode: TLMDThemeMode;
    FParentThemeMode : boolean;
    FThemeGlobalMode: Boolean;
    FListBoxWndProcOld,
    FListBoxInstance: TFarProc;

    //support of bound labels, AH July 2010
    FHasBoundLabel: Boolean;
    FEditLabel: TLMDBoundLabel;
    FLabelPosition: TLabelPosition;
    FLabelSpacing: Integer;
    FLabelSync: Boolean;

    procedure SetLabelPosition(const Value: TLabelPosition);
    procedure SetLabelSpacing(const Value: Integer);
    procedure SetHasLabel(aValue: Boolean);
    procedure SetLabelSync(const Value: Boolean);
    procedure ReadEditLabel(Stream: TStream);

    procedure set_CtlXP(aValue: Boolean);
    function  get_CtlXP: Boolean;
    procedure ReadCtlXP(Reader: TReader);
    procedure SetThemeMode(const Value: TLMDThemeMode);
    procedure SetThemeGlobalMode(const Value: Boolean);
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMRecreateWnd(var Message: TMessage); message CM_RecreateWnd;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure WMThemeChanged(var Msg: TMessage); message WM_THEMECHANGED;
    procedure CMLMDBOUNDLABELCHANGE(var Message: TMessage); message CM_LMDBOUNDLABELCHANGE;
    procedure SetParentThemeMode(const Value: boolean);
  protected
    // XP Support
    // UseThemeMode returns active theme, depending on global settings etc.
    function  UseThemeMode: TLMDThemeMode;
    procedure DoThemeChanged; virtual;
    procedure Loaded; override;
    //support of bound labels, AH July 2010
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetName(const Value: TComponentName); override;
    procedure SetParent(AParent: TWinControl); override;

    procedure CallPrevListBoxWndProc(var Message: TMessage);
    procedure DefineProperties(Filer:TFiler); override;
    function  GetBtnRect: TRect;
    //function GetScrollBarRect: TRect;
    procedure ListBoxWndProc(var Message: TMessage);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseEnter; virtual;
    procedure MouseExit; virtual;
    procedure Paint(DestDC: HDC); virtual;
    function  GetThemedBkColor: TColor;
    function  GetThemedFontColor: TColor;
    procedure SetNewListBoxWndProc;
    procedure RestoreListBoxWndProc;
    procedure WndProc(var Message: TMessage); override;
    property  MouseAbove: boolean read FMouseAbove;
    property  CtlXP: Boolean read get_CtlXP write set_CtlXP default True;  // Compatibility

    //support of bound labels, AH July 2010
    property EditLabel: TLMDBoundLabel read FEditLabel;
    property LabelPosition: TLabelPosition read FLabelPosition write SetLabelPosition default lpAbove;
    property LabelSync:Boolean read FLabelSync write SetLabelSync default false;
    property LabelSpacing: Integer read FLabelSpacing write SetLabelSpacing default 3;
    property HasBoundLabel: Boolean read FHasBoundLabel write SetHasLabel;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
    procedure SetupEditLabel;
    function  IsThemed: Boolean; // any other than ttmNone
    property  About: TLMDAboutVar read FAbout write FAbout stored false;
    property  ListHandle;
    property  OnDropDown;
    property  ThemeMode:TLMDThemeMode read FThemeMode write SetThemeMode default ttmPlatform;  // 9.0
    property  ThemeGlobalMode: Boolean read FThemeGlobalMode write SetThemeGlobalMode default false;
    property  ParentThemeMode: boolean read FParentThemeMode write SetParentThemeMode;
  end;

implementation

uses
  Forms, UxTheme, LMDSysIn, LMDThemes, TypInfo;

{**************************** Class TLMDThemedComboBox ************************}
{------------------------------- private --------------------------------------}
procedure TLMDThemedComboBox.SetLabelPosition(const Value: TLabelPosition);
var
  P: TPoint;
begin
  if not Assigned(FEditLabel) then exit;
  FLabelPosition := Value;
  if [csLoading, csReading]*ComponentState<>[] then exit;
  case Value of
    lpAbove: P := Point(Left, Top - FEditLabel.Height - FLabelSpacing);
    lpBelow: P := Point(Left, Top + Height + FLabelSpacing);
    lpLeft : P := Point(Left - FEditLabel.Width - FLabelSpacing, Top);
    lpRight: P := Point(Left + Width + FLabelSpacing, Top);
  end;
  if not FLabelSync then
    FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, FEditLabel.Height)
  else
    if Value in [lpAbove, lpBelow] then
      FEditLabel.SetBounds(P.x, P.y, self.Width, FEditLabel.Height)
    else
      FEditLabel.SetBounds(P.x, P.y, FEditLabel.Width, self.Height);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDThemedComboBox.SetLabelSpacing(const Value: Integer);
begin
  FLabelSpacing := Value;
  SetLabelPosition(FLabelPosition);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDThemedComboBox.SetLabelSync(const Value: Boolean);
begin
  if FLabelSync<>Value then
    begin
      FLabelSync := Value;
      if FLabelSync then
        if Assigned(FEditLabel) and FEditLabel.AutoSize then
          FEditLabel.AutoSize:=false;
      SetLabelPosition(FLabelPosition);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDThemedComboBox.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  SetLabelPosition(FLabelPosition);
end;

procedure TLMDThemedComboBox.SetHasLabel(aValue: Boolean);
begin
  if aValue <> FHasBoundLabel then
  begin
    if aValue then
      SetupEditLabel
    else
    begin
      FreeAndNil(FEditLabel);
      FHasBoundLabel:=false;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDThemedComboBox.ReadEditLabel(Stream:TStream{Reader});
begin
  Stream.ReadComponent(FEditLabel);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDThemedComboBox.SetupEditLabel;
begin
  if Assigned(FEditLabel) then exit;
  FHasBoundLabel:=true;
  FEditLabel := TLMDBoundLabel.Create(Self);
  FEditLabel.FreeNotification(Self);
  FEditLabel.FocusControl := Self;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDThemedComboBox.CMLMDBOUNDLABELCHANGE(var Message: TMessage);
begin
  SetLabelPosition(FLabelPosition);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDThemedComboBox.SetThemeGlobalMode(const Value: Boolean);
begin
  if FThemeGlobalMode <> Value then
    begin
      FThemeGlobalMode := Value;
      DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.SetThemeMode(const Value: TLMDThemeMode);
begin
  if Value <> FThemeMode then
    begin
      FThemeMode := Value;
      if IsThemed then
        begin
          SetNewListBoxWndProc;
          FBgrColor := Color;
        end
      else
        begin
          if FBgrColor <> clNone then
            Color := FBgrColor;
          RestoreListBoxWndProc;
        end;
      DoThemeChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.set_CtlXP(aValue: Boolean);
begin
  if aValue <> Get_CtlXP then
    ThemeMode := LMDCtlXP[aValue];
end;

{------------------------------------------------------------------------------}
function TLMDThemedComboBox.get_CtlXP: Boolean;
begin
  result := FThemeMode = ttmPlatForm;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.ReadCtlXP(Reader: TReader);
begin
  Set_CtlXP(Reader.ReadBoolean);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.CMMouseEnter(var Message: TMessage);
begin
  MouseEnter;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  MouseExit;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.CMRecreateWnd(var Message: TMessage);
begin
  inherited;
  FListBoxHandle := 0;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.CMColorChanged(var Message: TMessage);
begin
  inherited;
  if (not FPainting) and (ComponentState * [csLoading, csReading] = []) then
    FBgrColor := Color;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.WMPaint(var Msg: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R: TRect;
  {$IFDEF LMDCOMP9}
  lFlags: integer;
  {$ENDIF}
begin
  if not IsThemed then
  begin
    inherited;
    {$IFDEF LMDCOMP9}
    R := ClientRect;
    if BidiMode = bdRightToLeft then
    begin
      R.Left := GetSystemMetrics(SM_CYEDGE);
      R.Right := R.Left + FBtnWidth;
    end
    else
    begin
      R.Right := R.Right - GetSystemMetrics(SM_CYEDGE);
      R.Left := R.Right - FBtnWidth;
    end;
    InflateRect(R, 0, -GetSystemMetrics(SM_CXEDGE));
    lFlags := DFCS_SCROLLCOMBOBOX;
    if FPressed then
      lFlags := lFlags or DFCS_PUSHED;
    if not Enabled then
      lFlags := lFlags or DFCS_INACTIVE;
    DrawFrameControl(Canvas.Handle, R, DFC_SCROLL, lFlags);
    {$ENDIF}
    Exit;
  end;

  DC := GetDC(0);
  MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
  ReleaseDC(0, DC);
  MemDC := CreateCompatibleDC(0);
  OldBitmap := SelectObject(MemDC, MemBitmap);
  try
    DC := BeginPaint(Handle, PS);
    Perform(WM_ERASEBKGND, MemDC, MemDC);
    Msg.DC := MemDC;
    inherited;
    Msg.DC := 0;
    Paint(DC);
    R := ClientRect;
    InflateRect(R, -2, -2);
    {$IFDEF LMDCOMP9}
    if BidiMode = bdRightToLeft then
      Inc(R.Left, FBtnWidth + 1)
    else
    {$ENDIF}
      Dec(R.Right, FBtnWidth + 1);
    BitBlt(DC, R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top, MemDC,
           R.Left, R.Top, SRCCOPY);
    EndPaint(Handle, PS);
  finally
    SelectObject(MemDC, OldBitmap);
    DeleteDC(MemDC);
    DeleteObject(MemBitmap);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.WMThemeChanged(var Msg: TMessage);
begin
  {$IFDEF LMDCOMP11}if (csDesigning in ComponentState) then exit;{$ENDIF}
  DoThemeChanged;
  Msg.Result:=1;
end;

{--------------------------- protected ----------------------------------------}
procedure TLMDThemedComboBox.CallPrevListBoxWndProc(var Message:
  TMessage);
begin
  if Assigned(FListBoxWndProcOld) then
    with TMessage(Message) do
      Result := CallWindowProc(FListBoxWndProcOld, FListBoxHandle, Msg, WParam,
        LParam);
end;

{------------------------------------------------------------------------------}
function TLMDThemedComboBox.UseThemeMode: TLMDThemeMode;
begin
  result := FThemeMode;
  if ParentThemeMode and Assigned(Parent) and IsPublishedProp(Parent, 'ThemeMode') then
    result := TLMDThemeMode(GetOrdProp(Parent, 'ThemeMode'))
  else
    if FThemeGlobalMode then
      result := LMDApplication.ThemeGlobalMode;
  result := LMDThemeServices.UseTheme(result);
end;

{------------------------------------------------------------------------------}
function TLMDThemedComboBox.IsThemed: Boolean;
begin
  result := UseThemeMode <> ttmNone;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.DoThemeChanged;
begin
  if {Showing and} (ComponentState * [csLoading, csReading] = []) then
  begin
    FBtnWidth := LMDThemeServices.GetThemeSysSize(UseThemeMode, teComboBox, 2);
    if FBtnWidth <= 0 then
      FBtnWidth := GetSystemMetrics(SM_CXHTHUMB);
    FFillListBoxBgr := true;
    RecreateWnd;
    if IsThemed then
      FBgrColor := Color
    else
      begin
        if  (FBgrColor <> clNone) then
          Color := FBgrColor;
      end;
    Invalidate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty(IDS_CtlXP, ReadCtlXP, nil, false);
  if FHasBoundLabel then
    Filer.DefineBinaryProperty('SubLabel', ReadEditLabel, nil, false);
end;

{------------------------------------------------------------------------------}
function TLMDThemedComboBox.GetBtnRect: TRect;
begin
  Result := ClientRect;
  InflateRect(Result, -1, -1);
  {$IFDEF LMDCOMP9}
  if BidiMode = bdRightToLeft then
    Result.Right := Result.Left + FBtnWidth
  else
  {$ENDIF}
    Result.Left := Result.Right - FBtnWidth
end;

{------------------------------------------------------------------------------}
function TLMDThemedComboBox.GetThemedBkColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleColor(scComboBox)
  else
  {$ENDIF}
    Result := Self.Color;
end;

{------------------------------------------------------------------------------}
function TLMDThemedComboBox.GetThemedFontColor: TColor;
begin
  {$IFDEF LMDCOMP16}
  if StyleServices.Enabled and TStyleManager.IsCustomStyleActive then
    Result := StyleServices.GetStyleFontColor(sfComboBoxItemNormal)
  else
  {$ENDIF}
    Result := Font.Color;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.ListBoxWndProc(var Message: TMessage);
var
  R: TRect;
  LDC: HDC;
begin
  if ((Message.Msg = WM_PRINTCLIENT) or (Message.Msg = WM_PAINT)) and FFillListBoxBgr then
    begin
      Canvas.Brush.Style := bsSolid;
      Canvas.Brush.Color := Color;
      LDC := 0;
      case Message.Msg of
        WM_PRINTCLIENT:
          begin
            {$IFNDEF LMDCOMP7}
            LDC := Message.wPARAM;
            {$ELSE}
            LDC := TWMPrintClient(Message).DC;
            {$ENDIF}
            end;
        WM_PAINT:
          begin
            LDC := GetWindowDC(FListBoxHandle);
            Windows.GetClientRect(FListBoxHandle, R);
            Inc(R.Top);
            Inc(R.Left);
            Inc(R.Right);
            Inc(R.Bottom);
          end;
      end;
      Windows.GetClientRect(FListBoxHandle, R);      
      FillRect(LDC, R, Canvas.Brush.Handle);
      if Message.Msg = WM_PAINT then
        ReleaseDC(FListBoxHandle, LDC);
      FFillListBoxBgr := false;
    end;
  CallPrevListBoxWndProc(Message);
end;

procedure TLMDThemedComboBox.Loaded;
begin
  inherited;
  SetLabelPosition(FLabelPosition);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if PtInRect(GetBtnRect, Point(X, Y)) then
    begin
      FPressed := true;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.MouseEnter;
begin
  FMouseAbove := true;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.MouseExit;
begin
  FMouseAbove := false;
  FMouseAboveBtn := false;
  FPressed := false;
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.MouseMove(Shift: TShiftState; X,
  Y: Integer);
var
  LOldMouseOver: boolean;
begin
  inherited;
  LOldMouseOver := FMouseAboveBtn;
  if PtInRect(GetBtnRect, Point(X, Y)) then
    FMouseAboveBtn := true
  else
    FMouseAboveBtn := false;
  if LOldMouseOver <> FMouseAboveBtn then
  Invalidate;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FPressed := false;
  Invalidate;
end;

procedure TLMDThemedComboBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = FEditLabel) and (Operation = opRemove) then
    FEditLabel := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.Paint(DestDC: HDC);
var
  WR, R: TRect;
  LDC: HDC;
  EditState: TThemedElementDetails;
  Button: TThemedComboBox;
  lThemeMode: TLMDThemeMode;
  lClr: TColor;
begin
  lThemeMode := UseThemeMode;
  if lThemeMode = ttmNone then
    Exit;

  FPainting := true;
  GetWindowRect(Handle, WR);
  R := ClientRect;
  LDC := DestDC;
  EditState.Element := teComboBox;
  EditState.Part := 0;
  EditState.State := CBXS_NORMAL;
  Button := tcDropDownButtonNormal;

  if not Enabled then
  begin
    EditState.State := CBXS_DISABLED;
    button := tcDropDownButtonDisabled;
    lClr   := LMDThemeServices.GetThemeColor(lThemeMode, teComboBox, 0,
                                             EditState.State, TMT_FILLCOLOR);

    // under Vista UxTheme.GetThemeColor always fails for Detail = teComboBox,
    // iPartId = 0, iStateID in [CBXS_DISABLED/Normal/Hot] and
    // iPropID = TMT_FILLCOLOR

    if lClr = clNone then
      lClr := clWindow;
    if Color <> lClr then
      Color := lClr;
  end
  else
  begin
    if FMouseAbove then
    begin
      EditState.State := CBXS_HOT;
      button := tcDropDownButtonHot;
    end;

    lClr := LMDThemeServices.GetThemeColor(lThemeMode, teComboBox, 0,
                                           EditState.State, TMT_FILLCOLOR);

    if lClr = clNone then
      lClr := clWindow;
    if Color <> lClr then
      Color := lClr;
  end;

  if FMouseAboveBtn then
    button := tcDropDownButtonHot;

  if FPressed then
    button := tcDropDownButtonPressed;

  LMDThemeServices.DrawElement(lThemeMode, LDC, EditState, r);
  if Style <> csSimple then
    LMDThemeServices.DrawElement(lThemeMode, LDC, button, GetBtnRect);
  FPainting := false;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.RestoreListBoxWndProc;
begin
  SetWindowLong(FListBoxHandle, GWL_WNDPROC, TLMDPtrInt(FListBoxWndProcOld));
  if FListBoxInstance<>nil then
    Classes.FreeObjectInstance(FListBoxInstance);
  FListBoxInstance := nil;
  FListBoxWndProcOld := nil;
  end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.SetName(const Value: TComponentName);
begin
  if Assigned (FEditLabel) and (csDesigning in ComponentState) and ((FEditlabel.GetTextLen = 0) or
     (CompareText(FEditLabel.Caption, Name) = 0)) then
    FEditLabel.Caption := Value;
  inherited SetName(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.SetNewListBoxWndProc;
begin
  FListBoxWndProcOld := TFarProc(GetWindowLong(FListBoxHandle,
    GWL_WNDPROC));
  FListBoxInstance :=
    Classes.MakeObjectInstance(ListBoxWndProc);
  SetWindowLong(FListBoxHandle, GWL_WNDPROC, TLMDPtrInt(FListBoxInstance));
  end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FEditLabel) then
  begin
    FEditLabel.Parent := AParent;
    FEditLabel.Visible := True;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.SetParentThemeMode(const Value: boolean);
begin
  if FParentThemeMode <> Value then
  begin
    FParentThemeMode := Value;
    DoThemeChanged;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemedComboBox.WndProc(var Message: TMessage);
begin
  if (FListBoxHandle = 0) and (Message.Msg = WM_CTLCOLORLISTBOX) and IsThemed then
  begin
    FListBoxHandle := Message.LParam;
    SetNewListBoxWndProc;
  end
  else
    inherited;
end;

{------------------------- public ---------------------------------------------}
constructor TLMDThemedComboBox.Create(aOwner: TComponent);
begin
  inherited;
  FParentThemeMode := true;
  FThemeMode := ttmPlatform;
  FFillListBoxBgr := true;
  FBtnWidth := LMDThemeServices.GetThemeSysSize(UseThemeMode, teComboBox, 2);
  if FBtnWidth <= 0 then
    FBtnWidth := GetSystemMetrics(SM_CXHTHUMB);
  FSbWidth := FBtnWidth{19};
  FMouseAbove := false;
  FMouseAboveBtn := false;
  FPressed := false;
  FListBoxHandle := 0;
  FEditBrushHandle := 0;
  FBgrColor := clNone;
end;

{------------------------------------------------------------------------------}
destructor TLMDThemedComboBox.Destroy;
begin
  inherited;
end;

end.
