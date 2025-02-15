unit ElIPEdit;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
� by LMD Innovative
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

ElIPEdit unit
-------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Types, Windows, Math, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls,
  Forms,  WinSock,  Menus, UxTheme,

  ElXPThemedControl, ElEdits,  ElVCLUtils,

  LMDTypes, LMDUtils, Themes, LMDThemes, LMDProcs, LMDGraph, LMDGraphUtils,
  LMDClass, LMDElConst;

const
  IPPARTMIN = 1;
  IPPARTMAX = 4;

type
  TElIPPartEdit = class(TElEdit)
  private
    OnPoint : TNotifyEvent;
    OnLeftPoint: TNotifyEvent;
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMGetDlgCode(var Message: TWMGetDlgCode); message WM_GETDLGCODE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  IntEditClass  = TElIPPartEdit;

  TElIPEdit = class (TElXPThemedControl)
  private
    FBorderStyle: TBorderStyle;
    FFlat : boolean;
    FActiveBorderType: TElFlatBorderType;
    FInactiveBorderType: TElFlatBorderType;
    FMouseOver : boolean;
    FModified  : boolean;
    FHideSelection : Boolean;
    FFocusedSelectColor: TColor;
    FFocusedSelectTextColor: TColor;
    FHideSelectColor: TColor;
    FHideSelectTextColor: TColor;

    FOnChange: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;

    FPartCanEdit: array [IPPARTMIN..IPPARTMAX] of boolean;
    FPartEditors: array[IPPARTMIN..IPPARTMAX] of IntEditClass;
    FParts: array[IPPARTMIN..IPPARTMAX] of byte;
    FBorderSides: TLMDBorderSides;
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    function GetThemedElementDetails: TThemedElementDetails;
    function FindPart(Editor : IntEditClass) : integer;
    function GetPart(Index: Integer): Byte;
    function GetPartCanEdit(Index: Integer): Boolean;
    procedure SetPart(Index: Integer; Value: Byte);
    procedure SetPartCanEdit(Index: Integer; Value: Boolean);
    function GetIPAddress : DWORD;
    procedure SetIPAddress(Value: DWORD);
    procedure SetFlat(const Value: boolean);
    procedure SetActiveBorderType(const Value: TElFlatBorderType);
    procedure SetInactiveBorderType(const Value: TElFlatBorderType);
    procedure SetBorderStyle(Value : TBorderStyle);
    procedure UpdateFrame;
    procedure SetModified(Value : boolean);

    procedure SetIPString(value : string);
    function  GetIPString : string;
    procedure SetBorderSides(Value: TLMDBorderSides);
    procedure WMNCCalcSize(var Message : TWMNCCalcSize); message WM_NCCALCSIZE;

    procedure ClickHandler(Sender: TObject);
    procedure ContextPopupHandler(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure DblClickHandler(Sender: TObject);
    procedure DragDropHandler(Sender: TObject; Source: TObject; X: Integer; Y: Integer);
    procedure DragOverHandler(Sender: TObject; Source: TObject; X: Integer; Y: Integer; State: TDragState; var Accept: Boolean);
    procedure EndDragHandler(Sender: TObject; Target: TObject; X: Integer; Y: Integer);
    procedure KeyDownHandler(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure KeyPressHandler(Sender: TObject; var Key: Char);
    procedure KeyUpHandler(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MouseDownHandler(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
    procedure MouseEnterHandler(Sender: TObject);
    procedure MouseLeaveHandler(Sender: TObject);
    procedure MouseMoveHandler(Sender: TObject; Shift: TShiftState; X: Integer; Y: Integer);
    procedure MouseUpHandler(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
    procedure StartDragHandler(Sender: TObject; var DragObject: TDragObject);
  protected
    FLineBorderActiveColor: TColor;
    FLineBorderInactiveColor: TColor;
    FHighlightAlphaLevel: Integer;
    FLinkedControlPosition: TElLinkCtlPos;
    FLinkedControl: TControl;
    FLinkedControlSpacing: Integer;
    FDisabledColor: TColor;
    FDisabledFontColor: TColor;
    FUseDisabledColors: Boolean;
    FBorderColorDkShadow: TColor;
    FBorderColorFace: TColor;
    FBorderColorHighlight: TColor;
    FBorderColorShadow: TColor;
    FBorderColorWindow: TColor;

    procedure DrawFlatBorder(DC: HDC);
    //function IsThemeApplied: boolean;

    procedure AdjustEditorPositions; virtual;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMEraseBkgnd(var Msg : TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;

    procedure DoMouseEnter; dynamic;
    procedure DoMouseLeave; dynamic;

    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure OnEditorChange(Sender : TObject);
    procedure OnEditorEnter(Sender :TObject);
    procedure OnEditorExit(Sender :TObject);
    procedure OnEditorPoint(Sender : TObject);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure OnEditorLeftPoint(Sender : TObject);
    procedure TriggerChangeEvent; virtual;
//    function GetThemedClassName: TLMDThemedItem; override;
    function GetThemedElement: TThemedElement; override;
    procedure Loaded; override;
    procedure SetLineBorderActiveColor(Value: TColor);
    procedure SetLineBorderInactiveColor(Value: TColor);
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);
    procedure CMHintShow(var Message:TCMHintShow); message CM_HINTSHOW;
    {$endif}
    function GetHideSelection: Boolean;
    procedure SetHideSelection(Value: Boolean);
    procedure SetFocusedSelectColor(Value: TColor);
    procedure SetFocusedSelectTextColor(Value: TColor);
    procedure SetHideSelectColor(Value: TColor);
    procedure SetHideSelectTextColor(Value: TColor);
    procedure SetHighlightAlphaLevel(Value: Integer);
    procedure SetLinkedControlPosition(Value: TElLinkCtlPos);
    procedure SetLinkedControl(Value: TControl);
    procedure SetLinkedControlSpacing(Value: Integer);
    procedure UpdateLinkedControl;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetDisabledColor(Value: TColor);
    procedure SetDisabledFontColor(Value: TColor);
    procedure SetUseDisabledColors(Value: Boolean);
    procedure SetBorderColorDkShadow(Value: TColor);
    procedure SetBorderColorFace(Value: TColor);
    procedure SetBorderColorHighlight(Value: TColor);
    procedure SetBorderColorShadow(Value: TColor);
    procedure SetBorderColorWindow(Value: TColor);
    public
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    property IPAddress : DWORD read GetIPAddress write SetIPAddress;
    property MouseOver : boolean read FMouseOver;
    property Modified  : boolean read FModified write SetModified;
  published
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint;
    {$endif}
    property BorderStyle : TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Flat : boolean read FFlat write SetFlat default false;
    property ActiveBorderType: TElFlatBorderType read FActiveBorderType write SetActiveBorderType default fbtSunken;
    property InactiveBorderType: TElFlatBorderType read FInactiveBorderType write SetInactiveBorderType default fbtSunkenOuter;

    property Part1: Byte index 1 read GetPart write SetPart default 0;
    property Part2: Byte index 2 read GetPart write SetPart default 0;
    property Part3: Byte index 3 read GetPart write SetPart default 0;
    property Part4: Byte index 4 read GetPart write SetPart default 0;

    property Part1CanEdit: Boolean index 1 read GetPartCanEdit write SetPartCanEdit default true;
    property Part2CanEdit: Boolean index 2 read GetPartCanEdit write SetPartCanEdit default true;
    property Part3CanEdit: Boolean index 3 read GetPartCanEdit write SetPartCanEdit default true;
    property Part4CanEdit: Boolean index 4 read GetPartCanEdit write SetPartCanEdit default true;

    property IPString  : string read GetIPString write SetIPString;
    property BorderSides: TLMDBorderSides read FBorderSides write SetBorderSides;
    property BorderColorDkShadow: TColor read FBorderColorDkShadow write
        SetBorderColorDkShadow default cl3DDkShadow;
    property BorderColorFace: TColor read FBorderColorFace write SetBorderColorFace
        default clBtnFace;
    property BorderColorHighlight: TColor read FBorderColorHighlight write
        SetBorderColorHighlight default clBtnHighlight;
    property BorderColorShadow: TColor read FBorderColorShadow write
        SetBorderColorShadow default clBtnShadow;
    property BorderColorWindow: TColor read FBorderColorWindow write
        SetBorderColorWindow default clWindow;

    property LineBorderActiveColor: TColor read FLineBorderActiveColor write
        SetLineBorderActiveColor;
    property LineBorderInactiveColor: TColor read FLineBorderInactiveColor write
        SetLineBorderInactiveColor;
    property HideSelection: Boolean read GetHideSelection write SetHideSelection
        default true;
    property FocusedSelectColor: TColor read FFocusedSelectColor write
        SetFocusedSelectColor default clHighlight;
    property FocusedSelectTextColor: TColor read FFocusedSelectTextColor write
        SetFocusedSelectTextColor default clHighlightText;
    property HideSelectColor: TColor read FHideSelectColor write SetHideSelectColor
        default clBtnFace;
    property HideSelectTextColor: TColor read FHideSelectTextColor write
        SetHideSelectTextColor default LMDElHideSelectTextColor;
    property HighlightAlphaLevel: Integer read FHighlightAlphaLevel write
        SetHighlightAlphaLevel default 255;
    property LinkedControlPosition: TElLinkCtlPos read FLinkedControlPosition write
        SetLinkedControlPosition default lcpTopLeft;
    property LinkedControl: TControl read FLinkedControl write SetLinkedControl;
    property LinkedControlSpacing: Integer read FLinkedControlSpacing write
        SetLinkedControlSpacing default 0;
    property DisabledColor: TColor read FDisabledColor write SetDisabledColor
        default clBtnFace;
    property DisabledFontColor: TColor read FDisabledFontColor write
        SetDisabledFontColor default clGrayText;
    property UseDisabledColors: Boolean read FUseDisabledColors write
        SetUseDisabledColors default false;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;

    property Anchors;
    property Color;
    property Constraints;
    property Ctl3D default true;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor default False;
    property ParentCtl3D default False;
    property ParentFont;
    property ParentShowHint;
    property ParentThemeMode default true;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default true;
    property Visible;
    property ThemeMode;
    property ThemeGlobalMode;

    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
    end;

implementation

uses
  LMDSysIn;
{
********************************** TElIPPartEdit ***********************************
}

constructor TElIPPartEdit.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TElIPPartEdit.CreateParams(var Params: TCreateParams);
begin
  FBorderStyle := bsNone;
  inherited;
end;

procedure TElIPPartEdit.WMChar(var Message: TWMChar);
begin
  if (Message.CharCode = Ord('.')) or
     (Message.CharCode = Ord(' ')) then
    if Assigned(OnPoint) then
      OnPoint(Self)
    else
  else
    inherited;
end;

procedure TElIPPartEdit.WMGetDlgCode(var Message: TWMGetDlgCode);
begin
  inherited;
  Message.Result := {DLGC_WANTCHARS or }DLGC_WANTARROWS;
end;

procedure TElIPPartEdit.WMKeyDown(var Message: TWMKeyDown);
begin
  if (Message.CharCode = VK_LEFT) and (KeyDataToShiftState(Message.KeyData) = []) and (Self.SelStart = 0) then
    if Assigned(OnLeftPoint) then
      OnLeftPoint(Self)
    else

  else
  if (Message.CharCode = VK_RIGHT) and (KeyDataToShiftState(Message.KeyData) = []) and (Self.SelStart = Length(Text)) then
    if Assigned(OnPoint) then
      OnPoint(Self)
    else

  else
    inherited;
end;

procedure TElIPPartEdit.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  with Parent as TElIPEdit do
    if FFlat or IsThemed then
      DrawFlatBorder(0);
end;

procedure TElIPPartEdit.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  with Parent as TElIPEdit do
    if FFlat or IsThemed then
      DrawFlatBorder(0);
end;

{
********************************** TElIPEdit ***********************************
}
constructor TElIPEdit.Create(AOwner : TComponent);
var
  I: Integer;
begin
  inherited Create(AOwner);
  FBorderStyle := bsSingle;
  FBorderSides := [ebsLeft, ebsTop, ebsRight, ebsBottom];
  FBorderColorFace := clBtnFace;
  FBorderColorShadow := clBtnShadow;
  FBorderColorDkShadow := cl3DDkShadow;
  FBorderColorHighlight := clBtnHighlight;
  FBorderColorWindow := clWindow;
  Ctl3D := true;
  for i :=  IPPARTMIN to IPPARTMAX do
  begin
    FPartEditors[i] := IntEditClass.Create(Self);
    with FPartEditors[i] do
    begin
      //BorderStyle := bsNone;
      StyleManager := nil;
      Parent := Self;
      OnChange := OnEditorChange;
      OnExit   := OnEditorExit;
      OnPoint  := OnEditorPoint;
      OnLeftPoint  := OnEditorLeftPoint;
      OnClick := ClickHandler;
      OnContextPopup := ContextPopupHandler;
      OnDblClick := DblClickHandler;
      OnDragDrop := DragDropHandler;
      OnDragOver := DragOverHandler;
      OnEndDrag := EndDragHandler;
      OnKeyDown := KeyDownHandler;
      OnKeyPress := KeyPressHandler;
      OnKeyUp := KeyUpHandler;
      OnMouseDown := MouseDownHandler;
      OnMouseEnter := MouseEnterHandler;
      OnMouseLeave := MouseLeaveHandler;
      OnMouseMove := MouseMoveHandler;
      OnMouseUp := MouseUpHandler;
      OnStartDrag := StartDragHandler;

      AutoSelect := true;
      AutoSize := false;
      MaxLength := 3;
      Text := '0';
      Alignment := taCenter;
      ParentColor := True;
      TabStop := false;
      Font := Self.Font;
      LeftMargin := 0;
      RightMargin := 0;
    end;
    FPartCanEdit[i] := true;
  end;
  TabStop := true;
  Width := 100;
  Height := 21;
  ParentColor := false;
  Color := clWindow;
  HighlightAlphaLevel := 255;
  FInactiveBorderType := fbtSunkenOuter;
  FActiveBorderType := fbtSunken;

  FHideSelection := true;
  FFocusedSelectColor := clHighlight;
  FFocusedSelectTextColor := clHighlightText;
  FHideSelectColor := clBtnFace;
  FHideSelectTextColor := LMDElHideSelectTextColor;
  FDisabledColor := clBtnFace;
  FDisabledFontColor := clGrayText;
  FLinkedControlPosition := lcpTopLeft;
end;

destructor TElIPEdit.Destroy;
begin
  Destroying;
  inherited;
end;

{function TElIPEdit.IsThemeApplied: boolean;
begin
  Result := False;
end;}

procedure TElIPEdit.DrawFlatBorder(DC: HDC);
var
  BorderType: TElFlatBorderType;
  MustRelease: boolean;
  R,
  R1 : TRect;
  b  : boolean;
  ax,
  ay : integer;
  AColor : TColor;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  if ((not FFlat) and (not IsThemed)) or (BorderStyle = bsNone) then
    exit;

  if LThemeMode <> ttmNone then
  begin
    DC := GetWindowDC(Handle);
    GetWindowRect(Handle, R);
    OffsetRect(R, -R.Left, -R.Top);
    (*
    R1 := ClientRect;
    OffsetRect(R1, ClientOrigin.X - Left, ClientOrigin.Y - Top);
    *)
    R1 := ClientRect;
    R1.TopLeft := Parent.ScreenToClient(ClientToScreen(R1.TopLeft));

    ax := Left - R1.Left;
    ay := Top  - R1.Top;

    R1 := ClientRect;
    OffsetRect(R1, -ax, -ay);

    with R1 do
      ExcludeClipRect(DC, Left, Top, Right, Bottom);
    if LMDSiWindowsVistaUp then
      LMDThemeServices.DrawElement(LThemeMode, DC, GetThemedElementDetails, R)
    else
      LMDThemeServices.DrawElement(LThemeMode, DC, teEditDontCare, R);
    ReleaseDC(Handle, DC);
  end
  else
  begin
    MustRelease := (DC = 0);
    if MustRelease then
      DC := GetWindowDC(Handle);
    try
      GetWindowRect(Handle, R);
      OffsetRect(R, -R.Left, -R.Top);
      b := Focused or (GetParent(Getfocus) = Handle) or FMouseOver;
      if b then
        BorderType := FActiveBorderType
      else
        BorderType := FInactiveBorderType;
      if b then
        AColor := LineBorderActiveColor
      else
        AColor := LineBorderInactiveColor;

      DrawFlatFrameEx2(DC, R, Acolor, Color, b, Enabled, FBorderSides, BorderType, FBorderColorFace, FBorderColorDkShadow, FBorderColorShadow, FBorderColorHighlight, FBorderColorWindow);
    finally
      if MustRelease then
        ReleaseDC(Handle, DC);
    end;
  end;
end;

procedure TElIPEdit.Paint;
var i,
    cy, cx,
    w : integer;
    s : string;
    RW: TRect;
    LDetail: TThemedEdit;
    LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  if FFlat and (not IsThemed) then
    DrawFlatBorder(Canvas.Handle);

  if (not LMDApplication.ThemeUseColorProperty) and (LThemeMode <> ttmNone) then
  begin
    RW := BoundsRect;
    if Parent <> nil then
      MapWindowPoints(Parent.Handle, Handle, RW, 2)
    else
    if ParentWindow <> 0 then
      MapWindowPoints(ParentWindow, Handle, RW, 2);
    if not Enabled then
      LDetail := teEditTextDisabled
    else
      if Focused then
        LDetail := teEditTextFocused
      else
        LDetail := teEditTextNormal;
    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, LDetail, RW, nil);
  end
  else
  begin
    if Enabled or (not UseDisabledColors) then
      Canvas.Brush.Color := Color
    else
      Canvas.Brush.Color := DisabledColor;
    Canvas.FillRect(ClientRect);
  end;
  Canvas.Brush.Style := bsClear;
  Canvas.Font.Assign(Font);
  if (not Enabled) and UseDisabledColors then
    Canvas.Font.Color := DisabledFontColor;

  w := (ClientWidth - 15) div (IPPARTMAX - IPPARTMIN + 1);
  cx := w + 2;
  S := '.';
  SetTextAlign(Canvas.Handle, TA_BASELINE);

  cy := (Abs(Font.Height) + 2);// + TopMargin; // to implement: make TopMargin visble fo ElIPEdit.
  for i := IPPARTMIN to IPPARTMAX - 1 do
  begin
    TextOut(Canvas.Handle, cx, cy{(ClientHeight + Abs(Font.Height)) div 2 - 1}, PChar(S), 1);
    inc(cx, w + 5);
  end;
end;

procedure TElIPEdit.AdjustEditorPositions;
var cx, w,
    i  : integer;
    tm : TLMDTextMetric;
begin
  cx := 0;
  w := (ClientWidth - 15) div (IPPARTMAX - IPPARTMIN + 1);
  LMDGetTextMetrics(Canvas.Handle, tm);
  for i := IPPARTMIN to IPPARTMAX do
  begin
    FPartEditors[i].SetBounds(cx, 0, w, ClientHeight);
    FPartEditors[i].AlignBottom := false;
//    FPartEditors[i].TopMargin := (ClientHeight - Abs(Font.Height)) div 2;
    inc(cx, w + 5);
  end;
end;

procedure TElIPEdit.CMColorChanged(var Message: TMessage);
var i : integer;
begin
  inherited;
  for i := IPPARTMIN to IPPARTMAX do
    FPartEditors[i].Color := Color;
end;

procedure TElIPEdit.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := True;
  if FFlat and (not Focused) and (not IsThemed) then
    DrawFlatBorder(0);
  if LMDSIWindowsVistaUp then
    DrawFlatBorder(0);
  DoMouseEnter;
end;

procedure TElIPEdit.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  if (Msg.LParam = 0) or (Msg.LParam = TLMDPtrInt(Self)) then
    begin
      FMouseOver := False;

      if LMDSIWindowsVistaUp then
        DrawFlatBorder(0);

      if FFlat and (not Focused) and (not IsThemed) then
        DrawFlatBorder(0);
      DoMouseLeave;
    end;
end;

procedure TElIPEdit.CMEnabledChanged(var Message: TMessage);
var i : integer;
begin
  inherited;
  Invalidate;
  for i := IPPARTMIN to IPPARTMAX do
    FPartEditors[i].Enabled := Enabled;
  UpdateFrame;
end;

procedure TElIPEdit.CMFontChanged(var Message: TMessage);
var i : integer;
begin
  inherited;
  for i := IPPARTMIN to IPPARTMAX do
    FPartEditors[i].Font.Assign(Font);
  AdjustEditorPositions;
  UpdateFrame;
end;

procedure TElIPEdit.CMSysColorChange(var Message: TMessage);
var i : integer;
begin
  inherited;
  for i := IPPARTMIN to IPPARTMAX do
    FPartEditors[i].Color := Color;
  Invalidate;
  UpdateFrame;
end;

procedure TElIPEdit.WMEraseBkgnd(var Msg : TWMEraseBkgnd);
begin
  Msg.result := 1;
end;

procedure TElIPEdit.WMNCPaint(var Msg: TWMNCPaint);
var DC : HDC;
begin
  if not Flat and (BorderStyle = bsSingle) then
    inherited;
  if Flat or IsThemed then
  begin
    //DC := GetDCEx(Handle, HRGN(Msg.wParam), DCX_WINDOW or DCX_INTERSECTRGN);
    //if DC <> 0 then
    //   DrawFlatBorder(DC)
    //else
    begin
      DC := GetWindowDC(Handle);
      DrawFlatBorder(DC);
    end;
    ReleaseDC(Handle, DC);
    Msg.Result := 0;
  end;
end;

type
  THackWinControl = class(TWinControl)
  end;

procedure TElIPEdit.WMSetFocus(var Msg: TWMSetFocus);
var R, C : TWinControl;
begin
  inherited;
  R := FindControl(Msg.FocusedWnd);
  if (R <> nil) and (FindPart(TElIPPartEdit(R)) <> -1) then
  begin
   C := THackWinControl(Parent).FindNextControl(Self, false, true, true);
   if C <> nil then
     C.SetFocus;
  end
  else
    FPartEditors[1].SetFocus;
  if FFlat or IsThemed then
    DrawFlatBorder(0);
end;

procedure TElIPEdit.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if not HandleAllocated then exit;
  if FFlat or IsThemed then
    DrawFlatBorder(0);
  if LMDSIWindowsVistaUp then
    DrawFlatBorder(0);
end;

procedure TElIPEdit.WMSize(var Message: TWMSize);
begin
  inherited;
  AdjustEditorPositions;
  if IsThemed or (Flat and (BorderStyle <> bsNone)) then
    DrawFlatBorder(0);
end;

procedure TElIPEdit.CreateWindowHandle(const Params: TCreateParams);
var i : integer;
begin
  inherited;
  for i := IPPARTMIN to IPPARTMAX do
    SetWindowLong(FPartEditors[i].Handle, GWL_STYLE, GetWindowLong(
      FPartEditors[i].Handle, GWL_STYLE) or ES_NUMBER);
end;

function TElIPEdit.GetPart(Index: Integer): Byte;
begin
  result := FParts[Index];
end;

function TElIPEdit.GetPartCanEdit(Index: Integer): Boolean;
begin
  result := FPartCanEdit[Index];
end;
function TElIPEdit.GetThemedElementDetails: TThemedElementDetails;
begin
  Result.Element := GetThemedElement;
  Result.Part := EP_EDITBORDER_NOSCROLL;
  Result.State := ETS_NORMAL;
  if not Enabled then
    Result.State := ETS_DISABLED
  else
  if Focused then
    Result.State := ETS_FOCUSED
  else
  if FMouseOver then
    Result.State := ETS_HOT;
end;

function TElIPEdit.FindPart(Editor : IntEditClass) : integer;
var i : integer;
begin
  result := -1;
  for i := IPPARTMIN to IPPARTMAX do
  begin
    if Editor = FPartEditors[i] then
    begin
      result := i;
      break;
    end;
  end;
end;

procedure TElIPEdit.OnEditorChange(Sender : TObject);
var i, j : integer;
    p    : integer;
    s    : string;
begin
  p := FindPart(IntEditClass(Sender));
  S := IntEditClass(Sender).Text;

  val(S, i, j);
  if (j = 0) then
  begin
    if (i <= 255) then
    begin
      FParts[p] := i;
      SetModified(true);
      TriggerChangeEvent;
      exit;
    end
    else
    if Length(S) >= 2 then
    begin
      i := StrToIntDef(Copy(S, Length(S) - 2, 3), 256);
      if i < 255 then
        FParts[p] := i
      else
      begin
        i := StrToIntDef(Copy(S, Length(S) - 1, 2), 256);
        if i < 255 then
          FParts[p] := i;
      end;
      SetModified(true);
      TriggerChangeEvent;
    end;
  end;
  if Length(s) > 0 then
  begin
    if IntEditClass(Sender).HandleAllocated then
      i := IntEditClass(Sender).SelStart
    else
      i := 0;
    IntEditClass(Sender).Text := IntToStr(FParts[p]);
    if IntEditClass(Sender).HandleAllocated then
      IntEditClass(Sender).SelStart := Min(i, Length(IntEditClass(Sender).Text));
  end;
end;

procedure TElIPEdit.OnEditorEnter(Sender :TObject);
begin
  IntEditClass(Sender).SelLength := 0;
  IntEditClass(Sender).SelStart := 0;
end;

procedure TElIPEdit.OnEditorExit(Sender :TObject);
begin
  IntEditClass(Sender).SelLength := 0;
  if IntEditClass(Sender).Text = '' then
  begin
    IntEditClass(Sender).Text := IntToStr(FParts[FindPart(IntEditClass(Sender))]);
    OnEditorChange(Sender);
  end;
end;

procedure TElIPEdit.OnEditorPoint(Sender : TObject);
var p : integer;
begin
  p := FindPart(IntEditClass(Sender));
  if (p < IPPARTMAX) then
    FPartEditors[p + 1].SetFocus;
end;

procedure TElIPEdit.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

procedure TElIPEdit.SetInactiveBorderType(const Value: TElFlatBorderType);
begin
  if FInactiveBorderType <> Value then
  begin
    FInactiveBorderType := Value;
    if not Focused and not FMouseOver then UpdateFrame;
  end;
end;

procedure TElIPEdit.SetActiveBorderType(const Value: TElFlatBorderType);
begin
  if FActiveBorderType <> Value then
  begin
    FActiveBorderType := Value;
    if (Focused or FMouseOver) then UpdateFrame;
  end;
end;

procedure TElIPEdit.SetFlat(const Value: boolean);
begin
  if FFlat <> Value then
  begin
    FFlat := Value;
    if HandleAllocated then
      if Flat then
        Invalidate
      else
        RecreateWnd;
  end;
end;

procedure TElIPEdit.SetBorderStyle(Value : TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

function TElIPEdit.GetIPAddress : DWORD;
begin
  Result := PInteger(@FParts[IPPARTMIN])^;
  end;

procedure TElIPEdit.SetIPAddress(Value: DWORD);
begin
  Value := LMDSwapInt32(Value);
  Part1 := Value shr 24;
  Part2 := Value shr 16 and $FF;
  Part3 := Value shr 8 and $FF;
  Part4 := Value and $FF;
  SetModified(false);
end;

procedure TElIPEdit.SetIPString(value : string);
var
  i: DWORD;
begin
  i := inet_addr(PAnsiChar(AnsiString(value)));
  if Value = '255.255.255.255' then
     SetIPAddress($FFFFFFFF)
  else
  if i = DWORD(INADDR_NONE) then
  Raise Exception.Create('Invalid IP address string')
  else
    SetIPAddress(i);
end;

function  TElIPEdit.GetIPString : string;
var

  ina: TInAddr;

begin
  ina.S_addr := IPAddress;
  result := String(StrPas(inet_ntoa(ina)));
  end;

procedure TElIPEdit.SetPart(Index: Integer; Value: Byte);
begin
  with FPartEditors[Index] do
  begin
    FParts[index] := Value;
    Text := IntToStr(Value);
    SelStart := 0;
  end;
end;

procedure TElIPEdit.SetPartCanEdit(Index: Integer; Value: Boolean);
begin
  FPartCanEdit[Index] := Value;
  FPartEditors[Index].ReadOnly := not Value;
end;

procedure TElIPEdit.SetModified(Value : boolean);
begin
  FModified := Value;
end;

procedure TElIPEdit.DoMouseEnter;
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TElIPEdit.DoMouseLeave;
begin
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TElIPEdit.UpdateFrame;
var R : TRect;
begin
  if Flat then
  begin
    R := Rect(0, 0, Width, Height);
    if (BorderStyle = bsSingle) and (not (csDestroying in ComponentState)) and (HandleAllocated) then
       RedrawWindow( Handle, @R, 0, rdw_Invalidate or rdw_UpdateNow or rdw_Frame );
  end;
end;

procedure TElIPEdit.OnEditorLeftPoint(Sender : TObject);
var p : integer;
begin
  p := FindPart(IntEditClass(Sender));
  if (p > 1) then
    FPartEditors[p - 1].SetFocus;
end;
procedure TElIPEdit.SetBorderSides(Value: TLMDBorderSides);
begin
  if FBorderSides <> Value then
  begin
    FBorderSides := Value;
    if HandleAllocated then
      RecreateWnd;
  end;
end;

procedure TElIPEdit.WMNCCalcSize(var Message : TWMNCCalcSize);

begin
  inherited;
  if (BorderStyle = bsSingle) and IsThemed then // and (not (IsThemed and UseXPThemes)) then
    begin
      if LMDSIWindowsVistaUp then
        dec(Message.CalcSize_Params.rgrc[0].Top, Round(GetSystemMetrics(smYEdge[Ctl3D]) / 2));
            if not (ebsLeft in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Left, GetSystemMetrics(SM_CYEDGE));
      if not (ebsTop in BorderSides) then
        dec(Message.CalcSize_Params.rgrc[0].Top, GetSystemMetrics(SM_CXEDGE));
      if not (ebsRight in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Right, GetSystemMetrics(SM_CYEDGE));
      if not (ebsBottom in BorderSides) then
        Inc(Message.CalcSize_Params.rgrc[0].Bottom, GetSystemMetrics(SM_CXEDGE));
      end;
end;

procedure TElIPEdit.TriggerChangeEvent;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TElIPEdit.ClickHandler(Sender: TObject);
begin
  Click;
end;  { ClickHandler }

procedure TElIPEdit.ContextPopupHandler(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  DoContextPopup(MousePos, Handled);
end;  { ContextPopupHandler }

procedure TElIPEdit.DblClickHandler(Sender: TObject);
begin
  DblClick;
end;  { DblClickHandler }

procedure TElIPEdit.DragDropHandler(Sender: TObject; Source: TObject; X: Integer; Y: Integer);
begin
  DragDrop(Source, X, Y);
end;  { DragDropHandler }

procedure TElIPEdit.DragOverHandler(Sender: TObject; Source: TObject; X: Integer; Y: Integer; State: TDragState; var Accept: Boolean);
begin
  DragOver(Source, X, Y, State, Accept);
end;  { DragOverHandler }

procedure TElIPEdit.EndDragHandler(Sender: TObject; Target: TObject; X: Integer; Y: Integer);
begin
  DoEndDrag(Target, X, Y);
end;  { EndDragHandler }

procedure TElIPEdit.KeyDownHandler(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  KeyDown(Key, Shift);
end;  { KeyDownHandler }

procedure TElIPEdit.KeyPressHandler(Sender: TObject; var Key: Char);
begin
  KeyPress(Key);
end;  { KeyPressHandler }

procedure TElIPEdit.KeyUpHandler(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  KeyUp(Key, Shift);
end;  { KeyUpHandler }

procedure TElIPEdit.MouseDownHandler(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
begin
  MouseDown(Button, Shift, X, Y);
end;  { MouseDownHandler }

procedure TElIPEdit.MouseEnterHandler(Sender: TObject);
begin
  DoMouseEnter;
end;  { MouseEnterHandler }

procedure TElIPEdit.MouseLeaveHandler(Sender: TObject);
begin
  DoMouseLeave;
end;  { MouseLeaveHandler }

procedure TElIPEdit.MouseMoveHandler(Sender: TObject; Shift: TShiftState; X: Integer; Y: Integer);
begin
  MouseMove(Shift, X, Y);
end;  { MouseMoveHandler }

procedure TElIPEdit.MouseUpHandler(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer);
begin
  MouseUp(Button, Shift, X, Y);
end;  { MouseUpHandler }

procedure TElIPEdit.StartDragHandler(Sender: TObject; var DragObject: TDragObject);
begin
  DoStartDrag(DragObject);
end;  { StartDragHandler }

function TElIPEdit.GetThemedElement: TThemedElement;
begin
  Result := teEdit;
end;

procedure TElIPEdit.Loaded;
begin
  inherited;
  AdjustEditorPositions;
  UpdateLinkedControl;
end;

procedure TElIPEdit.SetLineBorderActiveColor(Value: TColor);
begin
  if FLineBorderActiveColor <> Value then
  begin
    FLineBorderActiveColor := Value;
    if Flat and (Focused or FMouseOver) then
    if HandleAllocated then
      Invalidate;
  end;
end;

procedure TElIPEdit.SetLineBorderInactiveColor(Value: TColor);
begin
  if FLineBorderInactiveColor <> Value then
  begin
    FLineBorderInactiveColor := Value;
    if Flat and not (Focused or FMouseOver) then
    if HandleAllocated then
      Invalidate;
  end;
end;

{$ifdef LMD_UNICODE}
{------------------------------------------------------------------------------}
procedure TElIPEdit.CMHintShow(var Message:TCMHintShow);
begin
  inherited;
  LMDConvertVCLHintShow(inherited Hint, FHint, Message);
end;

{------------------------------------------------------------------------------}
procedure TElIPEdit.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$ENDIF}

procedure TElIPEdit.SetFocusedSelectColor(Value: TColor);
var i : integer;
begin
  if FFocusedSelectColor <> Value then
  begin
    FFocusedSelectColor := Value;
    for i := IPPARTMIN to IPPARTMAX do
      FPartEditors[i].FocusedSelectColor := Value;
  end;
end;

procedure TElIPEdit.SetFocusedSelectTextColor(Value: TColor);
var i : integer;
begin
  if FFocusedSelectTextColor <> Value then
  begin
    FFocusedSelectTextColor := Value;
    for i := IPPARTMIN to IPPARTMAX do
      FPartEditors[i].FocusedSelectTextColor := Value;
  end;
end;

procedure TElIPEdit.SetHideSelectColor(Value: TColor);
var i : integer;
begin
  if FHideSelectColor <> Value then
  begin
    FHideSelectColor := Value;
    for i := IPPARTMIN to IPPARTMAX do
      FPartEditors[i].HideSelectColor := Value;
  end;
end;

procedure TElIPEdit.SetHideSelectTextColor(Value: TColor);
var i : integer;
begin
  if (FHideSelectTextColor <> Value) then
  begin
    FHideSelectTextColor := Value;
    for i := IPPARTMIN to IPPARTMAX do
      FPartEditors[i].FHideSelectTextColor := Value;
  end;  {if}
end;

function TElIPEdit.GetHideSelection: Boolean;
begin
  Result := FHideSelection;
end;

procedure TElIPEdit.SetHideSelection(Value: Boolean);
var i : integer;
begin
  if FHideSelection <> Value then
  begin
    FHideSelection := Value;
    for i := IPPARTMIN to IPPARTMAX do
      FPartEditors[i].HideSelection := Value;
  end;
end;

procedure TElIPEdit.SetHighlightAlphaLevel(Value: Integer);
var i : integer;
begin
  if FHighlightAlphaLevel <> Value then
  begin
    FHighlightAlphaLevel := Value;
    for i := IPPARTMIN to IPPARTMAX do
      FPartEditors[i].HighlightAlphaLevel := Value;
  end;
end;

procedure TElIPEdit.SetLinkedControlPosition(Value: TElLinkCtlPos);
begin
  if FLinkedControlPosition <> Value then
  begin
    FLinkedControlPosition := Value;
    UpdateLinkedControl;
  end;
end;

procedure TElIPEdit.SetLinkedControl(Value: TControl);
begin
  if (FLinkedControl <> Value) and (Value <> Self) then
  begin
    if FLinkedControl <> nil then
      if not (csDestroying in FLinkedControl.ComponentState) then
        FLinkedControl.RemoveFreeNotification(Self);
    FLinkedControl := Value;
    if FLinkedControl <> nil then
      FLinkedControl.FreeNotification(Self);
    UpdateLinkedControl;
  end;
end;

procedure TElIPEdit.SetLinkedControlSpacing(Value: Integer);
begin
  if FLinkedControlSpacing <> Value then
  begin
    FLinkedControlSpacing := Value;
    UpdateLinkedControl;
  end;
end;

procedure TElIPEdit.UpdateLinkedControl;
begin
  if FLinkedControl <> nil then
  begin
    case FLinkedControlPosition of
      lcpLeftTop:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top, FLinkedControl.Width, FLinkedControl.Height);
      lcpLeftBottom:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top + Height - FLinkedControl.Height, FLinkedControl.Width, FLinkedControl.Height);
      lcpLeftCenter:
        FLinkedControl.SetBounds(Left - FLinkedControl.Width - FLinkedControlSpacing, Top + (Height - FLinkedControl.Height) div 2, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopLeft:
        FLinkedControl.SetBounds(Left, Top - FLinkedControl.Height - FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopRight:
        FLinkedControl.SetBounds(Left + Width - FLinkedControl.Width, Top - FLinkedControl.Height - FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpTopCenter:
        FLinkedControl.SetBounds(Left + (Width - FLinkedControl.Width) div 2, Top - FLinkedControl.Height - FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightTop:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightBottom:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top + Height - FLinkedControl.Height, FLinkedControl.Width, FLinkedControl.Height);
      lcpRightCenter:
        FLinkedControl.SetBounds(Left + Width + FLinkedControlSpacing, Top + (Height - FLinkedControl.Height) div 2, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomLeft:
        FLinkedControl.SetBounds(Left, Top + Height + FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomRight:
        FLinkedControl.SetBounds(Left + Width - FLinkedControl.Width, Top + Height + FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
      lcpBottomCenter:
        FLinkedControl.SetBounds(Left + (Width - FLinkedControl.Width) div 2, Top + Height + FLinkedControlSpacing, FLinkedControl.Width, FLinkedControl.Height);
    end;
  end;
end;

procedure TElIPEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if FLinkedControl = AComponent then
      LinkedControl := nil;
  end;
end;

procedure TElIPEdit.SetDisabledColor(Value: TColor);
var i : integer;
begin
  if FDisabledColor <> Value then
  begin
    FDisabledColor := Value;
    for I := IPPARTMIN to IPPARTMAX do
    begin
      FPartEditors[I].DisabledColor := Value;
    end;
  end;
end;

procedure TElIPEdit.SetDisabledFontColor(Value: TColor);
var i : integer;
begin
  if FDisabledFontColor <> Value then
  begin
    FDisabledFontColor := Value;
    for I := IPPARTMIN to IPPARTMAX do
    begin
      FPartEditors[I].DisabledFontColor := Value;
    end;
  end;
end;

procedure TElIPEdit.SetUseDisabledColors(Value: Boolean);
var
  i: integer;
begin
  if FUseDisabledColors <> Value then
  begin
    FUseDisabledColors := Value;
    for I := IPPARTMIN to IPPARTMAX do
      FPartEditors[I].UseDisabledColors := Value;
    Invalidate;
  end;
end;

procedure TElIPEdit.SetBorderColorDkShadow(Value: TColor);
begin
  if FBorderColorDkShadow <> Value then
  begin
    FBorderColorDkShadow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElIPEdit.SetBorderColorFace(Value: TColor);
begin
  if FBorderColorFace <> Value then
  begin
    FBorderColorFace := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElIPEdit.SetBorderColorHighlight(Value: TColor);
begin
  if FBorderColorHighlight <> Value then
  begin
    FBorderColorHighlight := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElIPEdit.SetBorderColorShadow(Value: TColor);
begin
  if FBorderColorShadow <> Value then
  begin
    FBorderColorShadow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

procedure TElIPEdit.SetBorderColorWindow(Value: TColor);
begin
  if FBorderColorWindow <> Value then
  begin
    FBorderColorWindow := Value;
    if Flat then
      DrawFlatBorder(0);
    end;
end;

end.
