unit ElSpin;
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

ElSpin unit
-----------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils,
  Classes,
  Controls,
  Messages,
  Windows,
  Graphics,
  Forms,
  StdCtrls,
  Menus,
  Types,

  LMDClass,
  LMDThemes,
  LMDSysIn,
  LMDProcs,
  LMDTypes,

  ElVCLUtils,
  ElEdits,
  ElSpinBtn;

type

  TLMDCheckIntRangeEvent = procedure (Sender: TObject; AValue: Integer; var ASilent: Boolean) of object;
  TLMDCheckFloatRangeEvent = procedure (Sender: TObject; AValue: Double; var ASilent: Boolean) of object;

  TElSpinEditError = class(Exception)
  end;

  TElSpinEdit = class(TCustomElEdit)
  protected
    FModified: Boolean;
    FBtnWidth: Integer;
    FMouseOver: boolean;
    FLargeIncrement: Integer;
    FIncrement: Integer;
    FSaveValue: integer;
    FSavePos: integer;
    FSaveLen: integer;
    FChanging: boolean;
    FValue: Integer;
    FMaxValue: Integer;
    FMinValue: Integer;
    FAllowEdit: Boolean;
    FButton: TElSpinButton;
    FOnUpClick,
      FOnDownClick: TNotifyEvent;
    FButtonWidth: Integer;
    FUseButtonWidth: Boolean;
    FValueUndefined: Boolean;
    FCReadOnly: Boolean;
    FButtonFlat: Boolean;
    FAutoDisableSpinButtons: Boolean;

    FOnCheckRangeError: TLMDCheckIntRangeEvent;
    procedure SetButtonColor(newValue : TColor);
    function GetButtonColor : TColor;
    procedure SetValue(newValue: Integer); virtual;
    procedure SetMaxValue(newValue: Integer);
    procedure SetMinValue(newValue: Integer);
    procedure SetAllowEdit(newValue: Boolean);
    procedure SetIncrement(newValue: integer);
    procedure SetEditRect(Value: TRect); override;

    procedure WMKeyDown(var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure WMCreate(var Msg: TWMCreate); message WM_CREATE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure WMCut(var Msg: TMessage); message WM_CUT;
    procedure WMPaste(var Msg: TMessage); message WM_PASTE;
    procedure WMMButtonDown(var Msg: TWMMButtonDown); message WM_MBUTTONDOWN;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure WMContextMenu(var Msg: TWMContextMenu); message WM_CONTEXTMENU;
    procedure SpinUpClick(Sender: TObject; Increment: Double); virtual;
    procedure SpinDownClick(Sender: TObject; Increment: Double); virtual;
    procedure SpinDrag(Sender: TObject; NewValue: Double); virtual;
    procedure SpinStart(Sender: TObject; var StartValue: Double);
    procedure SetCReadOnly(Value: Boolean);

    procedure SetFlat(const Value: Boolean); override;

    procedure CreateParams(var Params: TCreateParams); override;

    procedure KeyPress(var Key: char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Click; override;
    function GetPopupMenu: TPopupMenu; override;

    procedure SetModified(newValue: Boolean); virtual;
    procedure SetButtonWidth(const Value: Integer);
    procedure SetUseButtonWidth(Value: Boolean);
    function GetButtonType: TElSpinBtnType;
    procedure SetButtonType(Value: TElSpinBtnType);
    function GetButtonDirection: TElSpinBtnDir;
    procedure SetButtonDirection(Value: TElSpinBtnDir);
    procedure SetValueUndefined(Value: Boolean); virtual;
    function GetUseXPThemes: Boolean;
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetThemeGlobalMode(const Value: Boolean);override;
    procedure SetThemeMode(const Value: TLMDThemeMode);override;
    procedure SetButtonThinFrame(Value: Boolean);
    procedure SetLineBorderActiveColor(Value: TColor); override;
    procedure SetLineBorderInactiveColor(Value: TColor); override;
    procedure SetButtonFlat(Value: Boolean);
    function GetButtonThinFrame: Boolean;
    function GetButtonOldStyled: Boolean;
    function GetButtonShowBorder: Boolean;
    procedure SetButtonOldStyled(Value: Boolean);
    procedure SetButtonShowBorder(Value: Boolean);
    procedure SetAutoDisableSpinButtons(Value: Boolean);
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CreateWnd; override;
    procedure Change; override;
    procedure Loaded; override;
    property MouseOver: boolean read FMouseOver;

    property Modified: Boolean read FModified write SetModified; { Published }
  published
    property Value: Integer read FValue write SetValue default 0;
    property MaxValue: Integer read FMaxValue write SetMaxValue default 100;
    property MinValue: Integer read FMinValue write SetMinValue default 0;
    property AllowEdit: Boolean read FAllowEdit write SetAllowEdit default True;
    property Increment: Integer read FIncrement write SetIncrement default 1;
    property LargeIncrement: Integer read FLargeIncrement write FLargeIncrement
      default 10;
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth stored
    FUseButtonWidth nodefault;
    property UseButtonWidth: Boolean read FUseButtonWidth write SetUseButtonWidth
    default false;
    property ButtonType: TElSpinBtnType read GetButtonType write SetButtonType
    default sbtUpDown;
    property ButtonColor : TColor read GetButtonColor write SetButtonColor default clBtnFace;
    property ButtonDirection: TElSpinBtnDir read GetButtonDirection write
    SetButtonDirection default sbdUpDown;
    property ValueUndefined: Boolean read FValueUndefined write SetValueUndefined
    default false;
    property ReadOnly: Boolean read FCReadOnly write SetCReadOnly default false;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes
      default true;
    property ButtonThinFrame: Boolean read GetButtonThinFrame write
    SetButtonThinFrame default true;
    property ButtonFlat: Boolean read FButtonFlat write SetButtonFlat default
      false;
    property ButtonOldStyled: Boolean read GetButtonOldStyled write
    SetButtonOldStyled default false;
    property ButtonShowBorder: Boolean read GetButtonShowBorder write
    SetButtonShowBorder default true;

    property OnUpClick: TNotifyEvent read FOnUpClick write FOnUpClick;
    property OnDownClick: TNotifyEvent read FOnDownClick write FOnDownClick;

//    property ReadOnly;
    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;

    property Alignment;
    property AlignBottom;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property BorderSides;
    property MaxLength;
    property Transparent;
    property HandleDialogKeys default false;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;
    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;

    property ImageForm;

    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property Anchors;

    property Constraints;

    property DragKind;

    property BiDiMode;

    property ActiveBorderType;
    property Align;
    property AutoSelect;
    property AutoSize;
    property Background;
    property BorderStyle default bsSingle;
    property Color;

    property Ctl3D default True;
    property DragCursor;

    property DragMode;
    property Enabled;
    property Font;
    property Flat;
    property InactiveBorderType;
    property LineBorderActiveColor default clBtnFace;
    property LineBorderInactiveColor default clBtnFace;

    property ParentColor default False;

    property ParentCtl3D default False;

    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property TabStop default True;
    property TabOrder;
    property ShowHint;
    property UseBackground;
    property UseSystemMenu;
    property Visible;

    property OnStartDock;
    property OnEndDock;

    property OnContextPopup;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnStartDrag;
    property AutoDisableSpinButtons: Boolean read FAutoDisableSpinButtons write
    SetAutoDisableSpinButtons default false;
    property OnCheckRangeError: TLMDCheckIntRangeEvent read FOnCheckRangeError write FOnCheckRangeError;
  end;

  TElFloatSpinEdit = class(TCustomElEdit)
  protected
    FNoTextUpdate: Boolean;
    FAllowEdit: Boolean;
    FBtnWidth: Integer;
    FButton: TElSpinButton;
    FButtonWidth: Integer;
    FChanging: Boolean;
    FIncrement: Double;
    FLargeIncrement: Double;
    FMaxValue: Double;
    FMinValue: Double;
    FPrecision: Integer;
    FModified: Boolean;
    FMouseOver: Boolean;
    FOnUpClick, FOnDownClick: TNotifyEvent;
    FCReadOnly: Boolean;
    FSaveLen: Integer;
    FSavePos: Integer;
    FSaveValue: Double;
    FUseButtonWidth: Boolean;
    FValue: Double;
    FValueUndefined: Boolean;
    FAutoDisableSpinButtons: Boolean;
    FDigits: Integer;
    FOnCheckRangeError: TLMDCheckFloatRangeEvent;
    procedure SetButtonColor(newValue : TColor);
    function GetButtonColor : TColor;
    procedure SetAllowEdit(newValue: Boolean);
    procedure SetIncrement(newValue: Double);
    procedure SetMaxValue(newValue: Double);
    procedure SetMinValue(newValue: Double);
    procedure SetCReadOnly(Value: Boolean);
    procedure SetValue(newValue: Double); virtual;
    procedure SetDigits(newValue: Integer); virtual;
    procedure SetPrecision(newValue: integer);
    procedure SpinDownClick(Sender: TObject; Increment: Double); virtual;
    procedure SpinDrag(Sender: TObject; NewValue: Double); virtual;
    procedure SpinStart(Sender: TObject; var StartValue: Double);
    procedure SpinUpClick(Sender: TObject; Increment: Double); virtual;

    procedure WMKeyDown(var Msg: TWMKeyDown); message WM_KEYDOWN;
    procedure CMEnter(var Msg: TCMEnter); message CM_ENTER;
    procedure CMExit(var Msg: TCMExit); message CM_EXIT;
    procedure WMCreate(var Msg: TWMCreate); message WM_CREATE;
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMMouseWheel(var Msg: TWMMouseWheel); message WM_MOUSEWHEEL;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure WMCut(var Msg: TMessage); message WM_CUT;
    procedure WMPaste(var Msg: TMessage); message WM_PASTE;
    procedure WMMButtonDown(var Msg: TWMMButtonDown); message WM_MBUTTONDOWN;
    procedure CMFontChanged(var Msg: TMessage); message CM_FONTCHANGED;
    procedure WMContextMenu(var Msg: TWMContextMenu); message WM_CONTEXTMENU;

    procedure Click; override;

    procedure CreateParams(var Params: TCreateParams); override;

    function GetButtonDirection: TElSpinBtnDir;
    function GetButtonType: TElSpinBtnType;
    function GetPopupMenu: TPopupMenu; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: char); override;
    procedure SetButtonDirection(Value: TElSpinBtnDir);
    procedure SetButtonType(Value: TElSpinBtnType);
    procedure SetButtonWidth(const Value: Integer);
    procedure SetFlat(const Value: Boolean); override;
    procedure SetModified(newValue: Boolean); virtual;
    procedure SetUseButtonWidth(Value: Boolean);
    procedure SetValueUndefined(Value: Boolean); virtual;
    function GetUseXPThemes: Boolean;
    procedure SetUseXPThemes(const Value: Boolean); override;
    procedure SetButtonThinFrame(Value: Boolean);
    procedure SetLineBorderActiveColor(Value: TColor); override;
    procedure SetLineBorderInactiveColor(Value: TColor); override;
    procedure SetEditRect(Value: TRect); override;
    function GetButtonThinFrame: Boolean;
    function GetButtonOldStyled: Boolean;
    procedure SetButtonOldStyled(Value: Boolean);
    function GetButtonFlat: Boolean;
    procedure SetButtonFlat(Value: Boolean);
    function GetButtonShowBorder: Boolean;
    function GetFloatFormat: TFloatFormat;
    procedure SetButtonShowBorder(Value: Boolean);
    procedure SetAutoDisableSpinButtons(Value: Boolean);
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Change; override;
    procedure CreateWnd; override;
    procedure Loaded; override;
    property Modified: Boolean read FModified write SetModified;
    property MouseOver: Boolean read FMouseOver;
  published
    property AllowEdit: Boolean read FAllowEdit write SetAllowEdit default True;
    property ButtonDirection: TElSpinBtnDir read GetButtonDirection write
    SetButtonDirection default sbdUpDown;
    property ButtonType: TElSpinBtnType read GetButtonType write SetButtonType
    default sbtUpDown;
    property ButtonWidth: Integer read FButtonWidth write SetButtonWidth stored
    FUseButtonWidth nodefault;
    property ButtonColor : TColor read GetButtonColor write SetButtonColor default clBtnFace;
    property Increment: Double read FIncrement write SetIncrement;
    property LargeIncrement: Double read FLargeIncrement write FLargeIncrement;
    property MaxValue: Double read FMaxValue write SetMaxValue;
    property MinValue: Double read FMinValue write SetMinValue;
    property OnDownClick: TNotifyEvent read FOnDownClick write FOnDownClick;
    property OnUpClick: TNotifyEvent read FOnUpClick write FOnUpClick;
    property ReadOnly: Boolean read FCReadOnly write SetCReadOnly default false;
    property UseButtonWidth: Boolean read FUseButtonWidth write SetUseButtonWidth
    default false;
    property Value: Double read FValue write SetValue;
    property Precision: integer read FPrecision write SetPrecision default 8;
    property ValueUndefined: Boolean read FValueUndefined write SetValueUndefined
    default false;
    property UseXPThemes: Boolean read GetUseXPThemes write SetUseXPThemes
      default
    true;
    property ButtonThinFrame: Boolean read GetButtonThinFrame write
    SetButtonThinFrame default true;
    property ButtonOldStyled: Boolean read GetButtonOldStyled write
    SetButtonOldStyled default false;
    property ButtonFlat: Boolean read GetButtonFlat write SetButtonFlat default
    false;
    property ButtonShowBorder: Boolean read GetButtonShowBorder write
    SetButtonShowBorder default true;

//    property ReadOnly;
    property VertScrollBarStyles;
    property HorzScrollBarStyles;
    property UseCustomScrollBars;

    property Alignment;
    property AlignBottom;
    property TopMargin;
    property LeftMargin;
    property RightMargin;
    property BorderSides;
    property MaxLength;
    property Transparent;
    property HandleDialogKeys default false;
    property FocusedSelectColor;
    property FocusedSelectTextColor;
    property HideSelection;
    property HideSelectColor;
    property HideSelectTextColor;
    property HighlightAlphaLevel;
    property LinkedControl;
    property LinkedControlPosition;
    property LinkedControlSpacing;

    property ImageForm;

    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;
    property OnSelectionChange;

    property Anchors;

    property Constraints;

    property DragKind;

    property BiDiMode;

    property ActiveBorderType;
    property Align;
    property AutoSelect;
    property AutoSize;
    property Background;
    property BorderStyle;
    property Color;

    property Ctl3D;
    property DragCursor;

    property DragMode;
    property Enabled;
    property Font;
    property Flat;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;

    property ParentColor;

    property ParentCtl3D;

    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property TabStop default True;
    property TabOrder;
    property ShowHint;
    property UseBackground;
    property UseSystemMenu;
    property Visible;

    property OnStartDock;
    property OnEndDock;

    property OnContextPopup;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnStartDrag;
    property AutoDisableSpinButtons: Boolean read FAutoDisableSpinButtons write
      SetAutoDisableSpinButtons default false;
    property Digits: Integer read FDigits write SetDigits default 3;
    property OnCheckRangeError: TLMDCheckFloatRangeEvent read FOnCheckRangeError write FOnCheckRangeError;
  end;

implementation

(*const
  FBtnWidth = 12;*)

function TElSpinEdit.GetPopupMenu: TPopupMenu;
var
  p: TPoint;
begin
  if FButton.SpinDragging then
  begin
    GetCursorPos(p);
    p := FButton.ScreenToClient(p);
    FButton.StopDragging;
  end;
  result := inherited GetPopupMenu;
end;

procedure TElSpinEdit.SetIncrement(newValue: integer);
begin
  FIncrement := newValue;
  FButton.Increment := newValue;
end;

procedure TElSpinEdit.SetValue(newValue: Integer);
begin
  if (FValue <> newValue) {and (not ReadOnly)} then
  begin
    if not (csLoading in ComponentState) then
    begin
      FValueUndefined := false;
      if (newValue < FMinValue) {and (not Focused) } then
        FValue := FMinValue
      else
        if newValue > FMaxValue then
        FValue := FMaxValue
      else
        FValue := newValue;
    end
    else
      FValue := newValue;

    if AutoDisableSpinButtons then
    begin
      FButton.UpArrowEnabled := FValue < MaxValue;
      FButton.DownArrowEnabled := FValue > MinValue;
    end;
    FChanging := true;
    Modified := true;
    FSaveValue := FValue;
    if not (csLoading in ComponentState) then
      Text := IntToStr(FValue);
    FChanging := false;
  end; {if}
end; {SetValue}

procedure TElSpinEdit.SetMaxValue(newValue: Integer);
begin
  if (FMaxValue <> newValue) then
  begin
    if (csLoading in ComponentState) or (newValue >= FMinValue) then
    begin
      FMaxValue := newValue;
      if FValue > FMaxValue then SetValue(FMaxValue);
    end;
  end; {if}
end; {SetMaxValue}

procedure TElSpinEdit.SetMinValue(newValue: Integer);
begin
  if (FMinValue <> newValue) and (newValue <= FMaxValue) then
  begin
    FMinValue := newValue;
    if FValue < FMinValue then SetValue(FMinValue);
  end; {if}
end; {SetMinValue}

procedure TElSpinEdit.SetAllowEdit(newValue: Boolean);
begin
  if (FAllowEdit <> newValue) then
  begin
    FAllowEdit := newValue;
    FIgnoreReadOnlyState := (FAllowEdit or not FReadOnly);
    inherited ReadOnly := not FAllowEdit;
  end; {if}
end; {SetAllowEdit}

procedure TElSpinEdit.WMKeyDown(var Msg: TWMKeyDown);
begin
  if Msg.CharCode <> 0 then
  begin
    FSavePos := SelStart;
    FSaveLen := SelLength;
  end;
  inherited;
end; {WMKeyDown}

procedure TElSpinEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited;
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN or
    Alignments[Alignment];
end; {CreateParams}

procedure TElSpinEdit.CreateWnd;
begin
  inherited;
end; {CreateWnd}

procedure TElSpinEdit.SetEditRect;
var
  R: TRect;
  LVistaAddX,
  LVistaAddY: Integer;
begin
  LVistaAddX := 0;
  LVistaAddY := 0;

  if LMDSIWindowsVistaUp then
  begin
    LVistaAddX := GetSystemMetrics(smXEdge[ctl3d]);
    LVistaAddY := GetSystemMetrics(smYEdge[ctl3d]);
  end;
  Dec(Value.Right, FBtnWidth);
  inherited SetEditRect(Value);
  if not HandleAllocated then exit;
  R := Value;

  R.Left := R.Right;
  R.Right := ClientWidth - LVistaAddX;
  R.Top := R.Top + LVistaAddY;
  R.Bottom := ClientHeight - LVistaAddY;
  if IsThemed and (FButtonWidth <> 0) then
    InflateRect(R, LVistaAddX + 1, LVistaAddY + 1);
  FButton.BoundsRect := R;
  FButton.Visible := true;
end; {SetEditRect}

procedure TElSpinEdit.CMEnter(var Msg: TCMEnter);
begin
  inherited;
end; {CMEnter}

procedure TElSpinEdit.CMExit(var Msg: TCMExit);
var
  i: integer;
  LSilent: Boolean;
begin
  inherited;
  if not LMDInRange(Value, MinValue, MaxValue) then
  begin
    LSilent := False;
    if Assigned(FOnCheckRangeError) then
      FOnCheckRangeError(Self, Value, LSilent);
    if not LSilent then
      raise TElSpinEditError.Create('Value out of range');
  end;
  try
    if (not FValueUndefined) then
    begin
      i := StrToInt(Text);
      if i > FMaxValue then
        Value := FMaxValue
      else
        if i < FMinValue then
        Value := FMinValue
      else
        Value := i;
    end
    else
    begin
      FChanging := true;
      Text := '';
      FChanging := false;
    end;
  except
    Value := FMinValue;
    FChanging := true;
    Text := IntToStr(FValue);
    FChanging := false;
  end;
  {
  if Flat and (not FMouseOver) then
  begin
    FButton.OldStyled := false;
    FButton.Invalidate;
  end;
  }
end; {CMExit}

procedure TElSpinEdit.Change;
var
  i: integer;
  a: integer;
  S: TLMDString;
begin
  if (Parent = nil) or (csLoading in ComponentState) then exit;

  if ((FChanging) or (Text = '')) then
    inherited
  else
  begin
    if Text <> '-' then
    try
      i := StrToInt(Text);
      (* //TODO
      if not LMDInRange(i, FMinValue, FMaxValue) then
        raise TElSpinEditError.Create('Value out of range');
      *)
      FSaveValue := i;
      FSavePos := SelStart;

      if (i > FMaxValue) then
      begin
        S := Text;
        Delete(S, FSavePos + 1, 1);
        i := StrToInt(S);
        if (i <= FMaxValue) then
        begin
          FValue := i;
          Text := S;
          SelStart := FSavePos;
          exit;
        end;
      end;

      // To prevent situation in 3000 delete first
      // digit and then we get 0 intead of 000
      if (Length(Text) > 1) and (i = 0) then
        FValue := 0
      else
        Value := i;

    except
      a := FSavePos;
      text := IntToStr(FSaveValue);
      FSavePos := a;
      SelStart := FSavePos;
    end
    else
      FSavepos := SelStart;
    inherited;
    SelStart := FSavePos;
  end;
end; {Change}

procedure TElSpinEdit.KeyPress(var Key: char);
const
  AllowedKeys = ['0'..'9', '-', #8];
begin
  if (not (AnsiChar(Key) in AllowedKeys)) or ((Key = '-') and (SelStart > 0) and (SelLength < Length(Text))) then
    Key := #0;
  inherited KeyPress(Key);
 end; {KeyPress}

procedure TElSpinEdit.WMCreate(var Msg: TWMCreate);
begin
  inherited;
  if ValueUndefined then
    Text := ''
  else
    Text := IntToStr(Value);
  Msg.Result := 0;
end;

procedure TElSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not ReadOnly then
  begin
    if (Key = VK_UP) and (Shift = []) then
    begin
      if Value + Increment <= MaxValue then
        Value := Value + Increment;
        if Assigned(FOnUpClick) then FOnUpClick(Self);
      Change;
      SelStart := Length(Text);
    end
    else
      if (Key = VK_DOWN) and (Shift = []) then
    begin
      if Value - Increment >= MinValue then
        Value := Value - Increment;
      if Assigned(FOnDownClick) then FOnDownClick(Self);
      Change;
      SelStart := Length(Text);
    end
    else
      if (Key = VK_PRIOR) and (Shift = []) then
    begin
      if Value + FLargeIncrement <= MaxValue then
        Value := Value + FLargeIncrement;
      if Assigned(FOnUpClick) then FOnUpClick(Self);
      Change;
      SelStart := Length(Text);
    end
    else
      if (Key = VK_NEXT) and (Shift = []) then
    begin
      if Value - FLargeIncrement >= MinValue then
        Value := Value - FLargeIncrement;
        if Assigned(FOnDownClick) then FOnDownClick(Self);
      Change;
      SelStart := Length(Text);
    end
    else
      inherited;
  end
  else
    inherited;
end;

procedure TElSpinEdit.Click;
begin
  FSavePos := SelStart;
  inherited;
end;

procedure TElSpinEdit.SetFlat(const Value: Boolean);
{ Sets data member FFlat to newValue. }
begin
  inherited;
  {
  if Value then
     FButton.OldStyled := (FMouseOver or Focused)
  else
     FButton.OldStyled := true;
  }
  FButton.MoneyFlat := Flat and (InactiveBorderType = fbtColorLineBorder) and
    (ActiveBorderType = fbtColorLineBorder);
  FButton.Invalidate;
end; { SetFlat }

procedure TElSpinEdit.CMMouseEnter(var Msg: TMessage); { private }
begin
  inherited;
  FMouseOver := true;
  //FButton.OldStyled := (not Flat) or (not ButtonThinFrame);
end; { CMMouseEnter }

procedure TElSpinEdit.CMMouseLeave(var Msg: TMessage); { private }
begin
  inherited;
  if (Msg.LParam = 0) or (Msg.LParam = TLMDPtrInt(Self)) then
    FMouseOver := false;
  FButton.Invalidate;
end; { CMMouseLeave }

procedure TElSpinEdit.WMSetFocus(var Msg: TWMSetFocus); { private }
begin
  inherited;
  //FButton.OldStyled := (not Flat) or (not ButtonThinFrame);
end; { WMSetFocus }

procedure TElSpinEdit.WMKillFocus(var Msg: TWMKillFocus); { private }
begin
  inherited;
  //FButton.OldStyled := (not Flat) or ((not ButtonThinFrame) and MouseOver);
end; { WMKillFocus }

procedure TElSpinEdit.WMMouseWheel(var Msg: TWMMouseWheel);
var
  Dy: integer;
  sl: integer;
begin
  if not ReadOnly then
  begin
    if LMDSIWindowsNT or LMDSIWindows98 then
      SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
    else
      sl := 3;
    if sl = 0 then sl := 1;
    Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
    if Dy <> 0 then
    begin
      if (FValue + Dy * FIncrement >= MinValue) or (Dy > 0) then
        SetValue(FValue + Dy * FIncrement);
      Change;
    end;
  end
  else
    inherited;
end; { WMMouseWheel }

procedure TElSpinEdit.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  invalidate;
  FButton.Enabled := Enabled;
end;

procedure TElSpinEdit.WMCut(var Msg: TMessage);
begin
  if not FAllowEdit then exit;
  inherited;
end;

procedure TElSpinEdit.WMPaste(var Msg: TMessage);
begin
  if not FAllowEdit then exit;
  inherited;
end;

procedure TElSpinEdit.Loaded; { public }
begin
  if FMaxValue < FMinValue then
    FMaxValue := FMinValue;
  if (FValue < FMinValue) then
    FValue := FMinValue;
  if (FValue > FMaxValue) then
    FValue := FMaxValue;
  if (not ValueUndefined) then
  begin
    FSaveValue := FValue;
    FChanging := true;
    Text := IntToStr(FValue);
    FChanging := false;
  end;
  inherited;
end; { Loaded }

procedure TElSpinEdit.WMSize(var Msg: TWMSize);
begin
  inherited;
end;

procedure TElSpinEdit.WMMButtonDown(var Msg: TWMMButtonDown); { private }
begin
  inherited;
  if CanFocus then SetFocus;
end; { WMMButtonDown }

procedure TElSpinEdit.CMFontChanged(var Msg: TMessage); { private }
begin
  inherited;
end; { CMFontChanged }

procedure TElSpinEdit.WMContextMenu(var Msg: TWMContextMenu); { private }
var
  p: TPoint;
begin
  if FButton.SpinDragging then
  begin
    GetCursorPos(p);
    p := FButton.ScreenToClient(p);
    FButton.StopDragging;
  end;
  inherited;
end; { WMContextMenu }

procedure TElSpinEdit.SpinUpClick(Sender: TObject; Increment: Double);
begin
  if not ReadOnly then
  begin
    Value := Value + Trunc(Increment);
    if CanFocus and (Windows.GetFocus <> Handle) then SetFocus;
    SelStart := 0;
    SelLength := Length(Text);
    if Assigned(FOnUpClick) then FOnUpClick(Self);
    Change;
  end;
end;

procedure TElSpinEdit.SpinDownClick(Sender: TObject; Increment: Double);
begin
  if not ReadOnly then
  begin
    if Value - Trunc(Increment) >= MinValue then
    Value := Value - Trunc(Increment);
    if CanFocus and (Windows.GetFocus <> Handle) then SetFocus;
    SelStart := 0;
    SelLength := Length(Text);
    if Assigned(FOnDownClick) then FOnDownClick(Self);
    Change;
  end;
end;

procedure TElSpinEdit.SpinDrag(Sender: TObject; NewValue: Double);
begin
  if not ReadOnly then
  begin
    Value := Trunc(NewValue);
    Change;
  end;
end;

procedure TElSpinEdit.SpinStart(Sender: TObject; var StartValue: Double);
begin
  StartValue := Value;
end;

procedure TElSpinEdit.SetModified(newValue: Boolean);
begin
  if (FModified <> newValue) then
  begin
    FModified := newValue;
    inherited Modified := newValue;
    // Change;
  end; { if }
end; { SetModified }

destructor TElSpinEdit.Destroy;
begin
  FButton.Free;
  FButton := nil;
  inherited Destroy;
end; {Destroy}

constructor TElSpinEdit.Create(AOwner: TComponent);
begin
  BeginCreate;
  inherited Create(AOwner);
  FBtnWidth := GetSystemMetrics(SM_CXVSCROLL);
  FButtonWidth := FBtnWidth;

  HandleDialogKeys := false;
  FValue := 0;
  FMaxValue := 100;
  FMinValue := 0;
  FSaveValue := 0;
  FAllowEdit := true;
  FIncrement := 1;
  FLargeIncrement := 10;
  FButton := TElSpinButton.Create(Self);
  FButton.StyleManager := nil;
  FButton.Parent := Self;
  FButton.DoubleBuffered := True;
  FButton.Increment := FIncrement;
  FButton.OnUpClick := SpinUpClick;
  FButton.OnDownClick := SpinDownClick;
  FButton.OnSpinDrag := SpinDrag;
  FButton.OnSpinStart := SpinStart;
  //FButton.Increment := 1;
  FButton.ThinFrame := true;
  //FButton.OldStyled := true;
  TabStop := true;
  AlignBottom := true;
  EndCreate;
end; {Create}

procedure TElSpinEdit.SetButtonWidth(const Value: Integer);
begin
  if FButtonWidth <> Value then
  begin
    FButtonWidth := Value;
    if FUSeButtonWidth then
    begin
      FBtnWidth := FButtonWidth;
      if HandleAllocated then
        SetEditRect(ClientRect);
    end;
  end;
end;

procedure TElSpinEdit.SetUseButtonWidth(Value: Boolean);
begin
  if FUseButtonWidth <> Value then
  begin
    FUseButtonWidth := Value;
    if Value then
      FBtnWidth := FButtonWidth
    else
      FBtnWidth := GetSystemMetrics(SM_CXVSCROLL);
    if HandleAllocated then
      SetEditRect(ClientRect);
  end;
end;

function TElSpinEdit.GetButtonType: TElSpinBtnType;
begin
  Result := FButton.ButtonType;
end;

procedure TElSpinEdit.SetButtonType(Value: TElSpinBtnType);
begin
  FButton.ButtonType := Value;
end;

function TElSpinEdit.GetButtonDirection: TElSpinBtnDir;
begin
  Result := FButton.ButtonDirection;
end;

procedure TElSpinEdit.SetButtonDirection(Value: TElSpinBtnDir);
begin
  FButton.ButtonDirection := Value;
end;

procedure TElSpinEdit.SetValueUndefined(Value: Boolean);
begin
  if FValueUndefined <> Value then
  begin
    FValueUndefined := Value;
    if csLoading in cOmponentState then
      exit;
    if FValueUndefined then
    begin
      FChanging := true;
      Text := '';
      FChanging := false;
    end
    else
    begin
      FChanging := true;
      Text := IntToStr(FValue);
      FChanging := false;
    end;
  end;
end;

procedure TElSpinEdit.SetCReadOnly(Value: Boolean);
begin
  if FCReadOnly <> Value then
  begin
    FCReadOnly := Value;
    FIgnoreReadOnlyState := (FAllowEdit or not FCReadOnly);
    if FCReadOnly then
    begin
      inherited ReadOnly := true;
//      FButton.Enabled := false;
    end
    else
    begin
      FButton.Enabled := true;
      inherited ReadOnly := not AllowEdit;
    end;
  end;
  invalidate;
end;

function TElSpinEdit.GetUseXPThemes: Boolean;
begin
  Result := FButton.ThemeMode = ttmPlatform;
end;

procedure TElSpinEdit.SetUseXPThemes(const Value: Boolean);
begin
  inherited;
  FButton.UseXPThemes := Value;
end;

procedure TElSpinEdit.SetThemeGlobalMode(const Value: Boolean);
begin
  inherited;
  FButton.ThemeGlobalMode := Value;
end;

procedure TElSpinEdit.SetThemeMode(const Value: TLMDThemeMode);
begin
  inherited;
  FButton.ThemeMode := Value;
end;

procedure TElSpinEdit.SetButtonThinFrame(Value: Boolean);
begin
  FButton.ThinFrame := Value;
end;

procedure TElSpinEdit.SetLineBorderActiveColor(Value: TColor);
begin
  if LineBorderActiveColor <> Value then
  begin
    inherited;
    FButton.MoneyFlatActiveColor := Value;
    FButton.MoneyFlat := Flat and (InactiveBorderType = fbtColorLineBorder) and
      (ActiveBorderType = fbtColorLineBorder);
  end;
end;

procedure TElSpinEdit.SetLineBorderInactiveColor(Value: TColor);
begin
  if LineBorderInactiveColor <> Value then
  begin
    inherited;
    FButton.MoneyFlatInactiveColor := Value;
    FButton.MoneyFlat := Flat and (InactiveBorderType = fbtColorLineBorder) and
      (ActiveBorderType = fbtColorLineBorder);
  end;
end;

procedure TElSpinEdit.SetButtonFlat(Value: Boolean);
begin
  if FButtonFlat <> Value then
  begin
    FButtonFlat := Value;
    FButton.Flat := Value;
  end;
end;

function TElSpinEdit.GetButtonThinFrame: Boolean;
begin
  Result := FButton.ThinFrame;
end;

function TElSpinEdit.GetButtonOldStyled: Boolean;
begin
  Result := FButton.OldStyled;
end;

function TElSpinEdit.GetButtonShowBorder: Boolean;
begin
  Result := FButton.ShowBorder;
end;

procedure TElSpinEdit.SetButtonOldStyled(Value: Boolean);
begin
  FButton.OldStyled := Value;
end;

procedure TElSpinEdit.SetButtonShowBorder(Value: Boolean);
begin
  FButton.ShowBorder := Value;
end;

procedure TElSpinEdit.SetAutoDisableSpinButtons(Value: Boolean);
begin
  if FAutoDisableSpinButtons <> Value then
  begin
    FAutoDisableSpinButtons := Value;
    if Value then
    begin
      FButton.UpArrowEnabled := FValue < MaxValue;
      FButton.DownArrowEnabled := FValue > MinValue;
    end
    else
    begin
      FButton.UpArrowEnabled := true;
      FButton.DownArrowEnabled := true;
    end;
  end;
end;

constructor TElFloatSpinEdit.Create(AOwner: TComponent);
begin
  BeginCreate;
  inherited Create(AOwner);
  FBtnWidth := GetSystemMetrics(SM_CXVSCROLL);
  FButtonWidth := FBtnWidth;

  HandleDialogKeys := false;
  FValue := 0;
  FMaxValue := 100;
  FMinValue := 0;
  FPrecision := 8;
  FSaveValue := 0;
  FDigits := 3;
  FAllowEdit := true;
  FIncrement := 1;
  FLargeIncrement := 10;
  FButton := TElSpinButton.Create(Self);
  FButton.Parent := Self;
  FButton.DoubleBuffered := True;
  FButton.Increment := FIncrement;
  FButton.OnUpClick := SpinUpClick;
  FButton.OnDownClick := SpinDownClick;
  FButton.OnSpinDrag := SpinDrag;
  FButton.OnSpinStart := SpinStart;
  FButton.ThinFrame := true;
  //FButton.OldStyled := true;
  TabStop := true;
  AlignBottom := true;

  EndCreate;
end; {Create}

destructor TElFloatSpinEdit.Destroy;
begin
  FButton.Free;
  FButton := nil;
  inherited Destroy;
end; {Destroy}

procedure TElFloatSpinEdit.Change;
var
  i: Double;
  a: integer;
  txt: string;
begin
  if (Parent = nil) or (csLoading in ComponentState) then exit;

  if ((FChanging) or (Text = '')) then
  begin
    inherited;
    exit;
  end;
  if Text <> '-' then
  try
    if Text = 'E' then
      i := 0
    else
      i := StrToFloat(Text);
    (* //TODO
    if not LMDInRangeF(i, FMinValue, FMaxValue) then
      raise TElSpinEditError.Create('Value out of range');
    *)
    FSaveValue := i;
    FSavePos := SelStart;

    FNoTextUpdate := true;
    Value := i;
    FNoTextUpdate := false;
  except
    a := FSavePos;

    txt := FloatToStrF(FValue, GetFloatFormat, FPrecision, FDigits);
    if Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, txt) > 0 then
    begin
      txt := copy(txt,1,Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, txt)+FDigits);
    end;
    Text := txt;

    FSavePos := a;
    SelStart := FSavePos;
  end
  else
    FSavepos := SelStart;
  inherited;
  SelStart := FSavePos;
end; {Change}

procedure TElFloatSpinEdit.Click;
begin
  FSavePos := SelStart;
  inherited;
end;

procedure TElFloatSpinEdit.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
  FButton.Enabled := Enabled;
end;

procedure TElFloatSpinEdit.CMEnter(var Msg: TCMEnter);
begin
  inherited;
end; {CMEnter}

procedure TElFloatSpinEdit.CMExit(var Msg: TCMExit);
var
  i: Double;
  LSilent: Boolean;
begin
  inherited;

  if not LMDInRangeF(Value, MinValue, MaxValue) then
  begin
    LSilent := False;
    if Assigned(FOnCheckRangeError) then
      FOnCheckRangeError(Self, Value, LSilent);
    if not LSilent then
      raise TElSpinEditError.Create('Value out of range');
  end;
  try
    if (not FValueUndefined) then
    begin
      i := StrToFloat(Text);
      if i > FMaxValue then
        Value := FMaxValue
      else
        if i < FMinValue then
        Value := FMinValue
      else
        Value := i;
    end
    else
    begin
      FChanging := true;
//      Text := ',';
      Text := '';
      FChanging := false;
    end;
  except
    Value := FMinValue;
    FChanging := true;
    Text := FloatToStrF(FValue, GetFloatFormat, FPrecision, FDigits);
    FChanging := false;
  end;
  {
  if Flat and (not FMouseOver) then
  begin
    FButton.OldStyled := false;
    FButton.Invalidate;
  end;
  }
end; {CMExit}

procedure TElFloatSpinEdit.CMFontChanged(var Msg: TMessage);
begin
  inherited;
end; { CMFontChanged }

procedure TElFloatSpinEdit.CMMouseEnter(var Msg: TMessage);
begin
  inherited;
  FMouseOver := true;
  //FButton.OldStyled := (not Flat) or (not ButtonThinFrame);
end; { CMMouseEnter }

procedure TElFloatSpinEdit.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  if (Msg.LParam = 0) or (Msg.LParam = TLMDPtrInt(Self)) then
    FMouseOver := false;
  //FButton.OldStyled := (not Flat) or ((not ButtonThinFrame) and Focused);
  FButton.Invalidate;
end; { CMMouseLeave }

procedure TElFloatSpinEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of DWORD = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited;
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN or
    Alignments[Alignment];
end; {CreateParams}

procedure TElFloatSpinEdit.CreateWnd;
begin
  inherited;
end; {CreateWnd}

function TElFloatSpinEdit.GetButtonDirection: TElSpinBtnDir;
begin
  Result := FButton.ButtonDirection;
end;

function TElFloatSpinEdit.GetButtonType: TElSpinBtnType;
begin
  Result := FButton.ButtonType;
end;

function TElFloatSpinEdit.GetPopupMenu: TPopupMenu;
var
  p: TPoint;
begin
  if FButton.SpinDragging then
  begin
    GetCursorPos(p);
    p := FButton.ScreenToClient(p);
    FButton.StopDragging;
  end;
  result := inherited GetPopupMenu;
end;

procedure TElFloatSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not ReadOnly then
  begin
    if (Key = VK_UP) and (Shift = []) then
    begin
      if Value + Increment <= MaxValue then
        Value := Value + Increment;
      if Assigned(FOnUpClick) then FOnUpClick(Self);
      Change;
    end
    else
      if (Key = VK_DOWN) and (Shift = []) then
    begin
      if Value - Increment >= MinValue then
        Value := Value - Increment;
      if Assigned(FOnDownClick) then FOnDownClick(Self);
      Change;
    end
    else
      if (Key = VK_PRIOR) and (Shift = []) then
    begin
      if Value + FLargeIncrement <= MaxValue then
        Value := Value + FLargeIncrement;
      if Assigned(FOnUpClick) then FOnUpClick(Self);
      Change;
    end
    else
    if (Key = VK_NEXT) and (Shift = []) then
    begin
      if Value - FLargeIncrement >= MinValue then
        Value := Value - FLargeIncrement;
      if Assigned(FOnDownClick) then FOnDownClick(Self);
      Change;
    end
    else
      inherited;
  end
  else
    inherited;
end;

procedure TElFloatSpinEdit.KeyPress(var Key: char);
const
  AllowedKeys = ['0'..'9', '-', #8, '.', ',', 'E'];
begin
  if (not (AnsiChar(Key) in AllowedKeys)) or ((Key = '-') and (SelStart > 0) and (SelLength
    < Length(Text))) then Key := #0;

  if (Key = {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator) and
            (Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, Text) > 0) then
  begin
    SelStart := Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, Text);
    Key := #0;
  end;

  inherited KeyPress(Key);
end; {KeyPress}

procedure TElFloatSpinEdit.Loaded;
begin
  if FMaxValue < FMinValue then
    FMaxValue := FMinValue;
  if (FValue < FMinValue) then
    FValue := FMinValue;
  if (FValue > FMaxValue) then
    FValue := FMaxValue;
  if (not ValueUndefined) then
  begin
    FSaveValue := FValue;
    FChanging := true;
    Text := FloatToStrF(FValue, GetFloatFormat, FPrecision, FDigits);
    FChanging := false;
  end;
  inherited;
end; { Loaded }

procedure TElFloatSpinEdit.SetAllowEdit(newValue: Boolean);
begin
  if (FAllowEdit <> newValue) then
  begin
    FAllowEdit := newValue;
    inherited ReadOnly := not FAllowEdit;
  end; {if}
end; {SetAllowEdit}

procedure TElFloatSpinEdit.SetButtonDirection(Value: TElSpinBtnDir);
begin
  FButton.ButtonDirection := Value;
end;

procedure TElFloatSpinEdit.SetButtonType(Value: TElSpinBtnType);
begin
  FButton.ButtonType := Value;
end;

procedure TElFloatSpinEdit.SetButtonWidth(const Value: Integer);
begin
  if FButtonWidth <> Value then
  begin
    FButtonWidth := Value;
    if FUSeButtonWidth then
    begin
      FBtnWidth := FButtonWidth;
      if HandleAllocated then
        SetEditRect(ClientRect);
    end;
  end;
end;

procedure TElFloatSpinEdit.SetFlat(const Value: Boolean);
{ Sets data member FFlat to newValue. }
begin
  inherited;
  {
  if Value then
     FButton.OldStyled := (FMouseOver or Focused)
  else
     FButton.OldStyled := true;
  }
  FButton.MoneyFlat := Flat and (InactiveBorderType = fbtColorLineBorder) and
    (ActiveBorderType = fbtColorLineBorder);
  FButton.Invalidate;
end; { SetFlat }

procedure TElFloatSpinEdit.SetIncrement(newValue: Double);
begin
  FIncrement := newValue;
  FButton.Increment := newValue;
end;

procedure TElFloatSpinEdit.SetMaxValue(newValue: Double);
begin
  if (FMaxValue <> newValue) then
  begin
    if (csLoading in ComponentState) or (newValue >= FMinValue) then
    begin
      FMaxValue := newValue;
      if FValue > FMaxValue then SetValue(FMaxValue);
    end;
  end; {if}
end; {SetMaxValue}

procedure TElFloatSpinEdit.SetMinValue(newValue: Double);
begin
  if (FMinValue <> newValue) and (newValue <= FMaxValue) then
  begin
    FMinValue := newValue;
    if FValue < FMinValue then SetValue(FMinValue);
  end; {if}
end; {SetMinValue}

procedure TElFloatSpinEdit.SetModified(newValue: Boolean);
begin
  if (FModified <> newValue) then
  begin
    FModified := newValue;
    inherited Modified := newValue;
    // Change;
  end; { if }
end; { SetModified }

procedure TElFloatSpinEdit.SetCReadOnly(Value: Boolean);
begin
  if FCReadOnly <> Value then
  begin
    FCReadOnly := Value;
    if FCReadOnly then
    begin
      inherited ReadOnly := true;
//      FButton.Enabled := false;
    end
    else
    begin
      FButton.Enabled := true;
      inherited ReadOnly := not AllowEdit;
    end;
  end;
  invalidate;
end;

procedure TElFloatSpinEdit.SetUseButtonWidth(Value: Boolean);
begin
  if FUseButtonWidth <> Value then
  begin
    FUseButtonWidth := Value;
    if Value then
      FBtnWidth := FButtonWidth
    else
      FBtnWidth := GetSystemMetrics(SM_CXVSCROLL);
    if HandleAllocated then
      SetEditRect(ClientRect);
  end;
end;

procedure TElFloatSpinEdit.SetDigits(newValue: Integer);
var
  txt: string;
begin
  if FDigits <> newValue then
  begin
    FDigits := newValue;
    if (not (csLoading in ComponentState)) and (not FNoTextUpdate) then
    begin
      txt := FloatToStrF(FValue, GetFloatFormat, FPrecision, FDigits);
      if Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, txt) > 0 then
      begin
        txt := copy(txt,1,Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, txt)+FDigits);
      end;
      Text := txt;
    end;
  end;
end;

procedure TElFloatSpinEdit.SetValue(newValue: Double);
var
  txt: string;
//  i: integer;
begin
  if (FValue <> newValue) {and (not ReadOnly)} then
  begin
    if not (csLoading in ComponentState) then
    begin
      FValueUndefined := false;

      if (newValue < FMinValue) {and (not Focused) } then
        FValue := FMinValue
      else
        if newValue > FMaxValue then
        FValue := FMaxValue
      else
        FValue := newValue;
    end
    else
      FValue := newValue;

    if AutoDisableSpinButtons then
    begin
      FButton.UpArrowEnabled := FValue < MaxValue;
      FButton.DownArrowEnabled := FValue > MinValue;
    end;
    FChanging := true;
    Modified := true;
    FSaveValue := FValue;
    if (not (csLoading in ComponentState)) {and (not FNoTextUpdate)} then
    begin
      txt := FloatToStrF(FValue, GetFloatFormat, FPrecision, FDigits);
      if Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, txt) > 0 then
      begin
        txt := copy(txt,1,Pos({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}DecimalSeparator, txt)+FDigits);
      end;
      Text := txt;
    end;
    FChanging := false;
  end; {if}
end; {SetValue}

procedure TElFloatSpinEdit.SetPrecision(newValue: integer);
begin
  if (newValue <> FPrecision) and (newValue >= 0) and (newValue <= 15) then
  begin
    if FDigits = FPrecision then
      Digits := newValue;
    FPrecision := newValue;
  end;
end;

procedure TElFloatSpinEdit.SetValueUndefined(Value: Boolean);
begin
  if FValueUndefined <> Value then
  begin
    FValueUndefined := Value;
    if csLoading in cOmponentState then
      exit;
    if FValueUndefined then
    begin
      FChanging := true;
      FValue := 0;
//      Text := ',';
      Text := '';
      FChanging := false;
    end
    else
    begin
      FChanging := true;
      Text := FloatToStrF(FValue, GetFloatFormat, FPrecision, FDigits);
      FChanging := false;
    end;
  end;
end;

procedure TElFloatSpinEdit.SpinDownClick(Sender: TObject; Increment: Double);
begin
  if not ReadOnly then
  begin
    if Value - Increment >= MinValue then
      Value := Value - Increment;
      if CanFocus and (Windows.GetFocus <> Handle) then SetFocus;
    SelStart := 0;
    SelLength := Length(Text);
    if Assigned(FOnDownClick) then FOnDownClick(Self);
    Change;
  end;
end;

procedure TElFloatSpinEdit.SpinDrag(Sender: TObject; NewValue: Double);
begin
  if not ReadOnly then
  begin
    Value := NewValue;
    Change;
  end;
end;

procedure TElFloatSpinEdit.SpinStart(Sender: TObject; var StartValue:
  Double);
begin
  StartValue := Value;
end;

procedure TElFloatSpinEdit.SpinUpClick(Sender: TObject; Increment: Double);
begin
  if not ReadOnly then
  begin
    Value := Value + Increment;
    if CanFocus and (Windows.GetFocus <> Handle) then SetFocus;
    SelStart := 0;
    SelLength := Length(Text);
    if Assigned(FOnUpClick) then FOnUpClick(Self);
    Change;
  end;
end;

procedure TElFloatSpinEdit.WMContextMenu(var Msg: TWMContextMenu);
var
  p: TPoint;
begin
  if FButton.SpinDragging then
  begin
    GetCursorPos(p);
    p := FButton.ScreenToClient(p);
    FButton.StopDragging;
  end;
  inherited;
end; { WMContextMenu }

procedure TElFloatSpinEdit.WMCreate(var Msg: TWMCreate);
begin
  inherited;
  if ValueUndefined then
    Text := ''
  else
    Text := FloatToStrF(FValue, GetFloatFormat, FPrecision, FDigits);
  Msg.Result := 0;
end;

procedure TElFloatSpinEdit.WMCut(var Msg: TMessage);
begin
  if not FAllowEdit then exit;
  inherited;
end;

procedure TElFloatSpinEdit.WMKeyDown(var Msg: TWMKeyDown);
begin
  if Msg.CharCode <> 0 then
  begin
    FSavePos := SelStart;
    FSaveLen := SelLength;
  end;
  inherited;
end; {WMKeyDown}

procedure TElFloatSpinEdit.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  //FButton.OldStyled := (not Flat) or ((not ButtonThinFrame) and MouseOver);
end; { WMKillFocus }

procedure TElFloatSpinEdit.WMMButtonDown(var Msg: TWMMButtonDown);
begin
  inherited;
  if CanFocus then SetFocus;
end; { WMMButtonDown }

procedure TElFloatSpinEdit.WMMouseWheel(var Msg: TWMMouseWheel);
var
  Dy: integer;
  sl: integer;
begin
  if not ReadOnly then
  begin
    if LMDSIWindowsNT or LMDSIWindows98 then
      SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @sl, SPIF_SENDCHANGE)
    else
      sl := 3;
    if sl = 0 then sl := 1;
    Dy := Msg.WheelDelta div (MOUSE_WHEEL_DELTA div sl);
    if Dy <> 0 then
    begin
      if (FValue + Dy * FIncrement >= MinValue) or (Dy > 0) then
        SetValue(FValue + Dy * FIncrement);
      Change;
    end;
  end;
end; { WMMouseWheel }

procedure TElFloatSpinEdit.WMPaste(var Msg: TMessage);
begin
  if not FAllowEdit then exit;
  inherited;
end;

procedure TElFloatSpinEdit.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  // FButton.OldStyled := (not Flat) or (not ButtonThinFrame);
end; { WMSetFocus }

procedure TElFloatSpinEdit.WMSize(var Msg: TWMSize);
begin
  inherited;
end;

function TElFloatSpinEdit.GetUseXPThemes: Boolean;
begin
  Result := FButton.ThemeMode = ttmPlatform;
end;

procedure TElFloatSpinEdit.SetUseXPThemes(const Value: Boolean);
begin
  inherited;
  FButton.UseXPThemes := value;
end;

procedure TElFloatSpinEdit.SetButtonThinFrame(Value: Boolean);
begin
  FButton.ThinFrame := Value;
end;

procedure TElFloatSpinEdit.SetLineBorderActiveColor(Value: TColor);
begin
  if LineBorderActiveColor <> Value then
  begin
    inherited;
    FButton.MoneyFlatActiveColor := Value;
    FButton.MoneyFlat := Flat and (InactiveBorderType = fbtColorLineBorder) and
      (ActiveBorderType = fbtColorLineBorder);
  end;
end;

procedure TElFloatSpinEdit.SetLineBorderInactiveColor(Value: TColor);
begin
  if LineBorderInactiveColor <> Value then
  begin
    inherited;
    FButton.MoneyFlatInactiveColor := Value;
    FButton.MoneyFlat := Flat and (InactiveBorderType = fbtColorLineBorder) and
      (ActiveBorderType = fbtColorLineBorder);
  end;
end;

procedure TElFloatSpinEdit.SetEditRect;
var
  R: TRect;
  LVistaAddX,
  LVistaAddY: Integer;
begin
  LVistaAddX := 0;
  LVistaAddY := 0;

  if LMDSIWindowsVistaUp then
  begin
    LVistaAddX := GetSystemMetrics(smXEdge[ctl3d]);
    LVistaAddY := GetSystemMetrics(smYEdge[ctl3d]);
  end;
  Dec(Value.Right, FBtnWidth);
  inherited SetEditRect(Value);
  if not HandleAllocated then exit;
  R := Value;
  R.Left := R.Right;
  R.Right := ClientWidth - LVistaAddX;
  R.Top := R.Top + LVistaAddY;
  R.Bottom := ClientHeight - LVistaAddY;
  if IsThemed and (FButtonWidth <> 0) then
    InflateRect(R, LVistaAddX + 1, LVistaAddY + 1);
  FButton.BoundsRect := R;
  FButton.Visible := true;
end; {SetEditRect}

function TElFloatSpinEdit.GetButtonThinFrame: Boolean;
begin
  Result := FButton.ThinFrame;
end;

function TElFloatSpinEdit.GetButtonOldStyled: Boolean;
begin
  Result := FButton.OldStyled;
end;

procedure TElFloatSpinEdit.SetButtonOldStyled(Value: Boolean);
begin
  FButton.OldStyled := Value;
end;

function TElFloatSpinEdit.GetButtonFlat: Boolean;
begin
  Result := FButton.Flat;
end;

procedure TElFloatSpinEdit.SetButtonFlat(Value: Boolean);
begin
  FButton.Flat := Value;
end;

function TElFloatSpinEdit.GetButtonShowBorder: Boolean;
begin
  Result := FButton.ShowBorder;
end;

function TElFloatSpinEdit.GetFloatFormat: TFloatFormat;
begin
  if Precision = 0 then
    Result := ffGeneral
  else
    Result := ffFixed;
end;

procedure TElFloatSpinEdit.SetButtonShowBorder(Value: Boolean);
begin
  FButton.ShowBorder := Value;
end;

procedure TElFloatSpinEdit.SetAutoDisableSpinButtons(Value: Boolean);
begin
  if FAutoDisableSpinButtons <> Value then
  begin
    FAutoDisableSpinButtons := Value;
    if Value then
    begin
      FButton.UpArrowEnabled := FValue < MaxValue;
      FButton.DownArrowEnabled := FValue > MinValue;
    end
    else
    begin
      FButton.UpArrowEnabled := true;
      FButton.DownArrowEnabled := true;
    end;
  end;
end;

function TElFloatSpinEdit.GetButtonColor: TColor;
begin
  Result := FButton.Color;
end;

procedure TElFloatSpinEdit.SetButtonColor(newValue: TColor);
begin
  FButton.Color := newValue;
end;

function TElSpinEdit.GetButtonColor: TColor;
begin
  Result := FButton.Color;
end;

procedure TElSpinEdit.SetButtonColor(newValue: TColor);
begin
  FButton.Color := newValue;
end;

end.
