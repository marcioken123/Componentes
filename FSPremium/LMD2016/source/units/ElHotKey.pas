unit ElHotKey;
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

ElHotKey unit
-------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,

  Types,

  LMDTypes,
  LMDGraphUtils,
  LMDElConst,
  ElVCLUtils,
  ElXPThemedControl,
  ElEdits;

type
  TElHKInvalidKey = (hcShift, hcAlt, hcCtrl, hcAltShift, hcAltCtrl, hcCtrlShift,
    hcCtrlAlftShift);
  TElHKInvalidKeys = set of TElHKInvalidKey;
  TElHKModifier = (hkShift, hkAlt, hkCtrl);
  TElHKModifiers = set of TElHKModifier;

  TElHotKey = class(TCustomElEdit)
  private
    { Private declarations }
    FText: TLMDString;
    FKeyPressed: boolean;
    FInvalidKeys: TElHKInvalidKeys;
    FModifiers: TElHKModifiers;
    FShiftState: TShiftState;
    procedure SetShortCut(newValue: TShortCut);
    procedure WMChar(var Message: TWMChar); message WM_CHAR;
    procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMSysKeyDown(var Message: TWMKeyDown); message WM_SYSKEYDOWN;
    procedure SetInvalidKeys(Value: TElHKInvalidKeys);
    procedure SetModifiers(Value: TElHKModifiers);
    function ShiftStateToText(state: TShiftState): TLMDString;
    function GetShortCut: TShortCut;
    function GetShiftState(state: TShiftState): TShiftState;
  protected
    { Protected declarations }
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

  published
    { Published declarations }
    property HotKey: TShortCut read GetShortCut write SetShortCut;
    property InvalidKeys: TElHKInvalidKeys read FInvalidKeys write
      SetInvalidKeys;
    property Modifiers: TElHKModifiers read FModifiers write SetModifiers;

    property AutoSize;
    property Alignment;
    property Background;
    property BorderSides;
    property UseBackground;
    property RightAlignedView;
    property Transparent;
    property ReadOnly;
    property LeftMargin;
    property RightMargin;
    property TopMargin;
    property BorderStyle;
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

    property ActiveBorderType;
    property Flat;
    property InactiveBorderType;
    property LineBorderActiveColor;
    property LineBorderInactiveColor;
    property UseDisabledColors;
    property DisabledColor;
    property DisabledFontColor;

    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnChange;

    property Align;

    property Anchors;

    property Color;

    property Constraints;

    property Ctl3D;
    property DragCursor;

    property DragKind;

    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;

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

    property OnStartDock;
    property OnEndDock;

    property OnContextPopup;

  end;

const
  nshift: array[0..6] of string = (SLMDShiftP,
    SLMDAltP,
    SLMDCtrlP,
    SLMDLeftP,
    SLMDRightP,
    SLMDMiddleP,
    SLMDDoubleP);

  VK_LEFTWINDOW = 91;
  VK_RIGHTWINDOW = 92;
  VK_APPLICATION = 93;

implementation

constructor TElHotKey.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FText := 'None';
  Text := 'None';
  FModifiers := [];
  FShiftState := [];
end;

function GetSpecialNameEx(ShortCut: TShortCut): string;
var
  ScanCode: Integer;
  KeyName: array[0..255] of Char;
  begin
  ScanCode := (MapVirtualKey(WordRec(ShortCut).Lo, 0) shl 16) or (1 shl 24);
  if ScanCode <> 0 then
  begin
    GetKeyNameText(ScanCode, KeyName, SizeOf(KeyName));
    Result := KeyName;
    end
  else
    Result := '';
end;

procedure TElHotKey.KeyDown(var Key: Word; Shift: TShiftState);
var
  newText: TLMDString;
  FKey: Word;
begin
  FKey := Key;
  inherited KeyDown(Key, Shift);
  Key := FKey;
  if ReadOnly then exit;
  newText := '';
  fkeypressed := false;
  FShiftState := GetShiftState(shift);
  newText := ShiftStateToText(FShiftState);
  if (key < VK_SHIFT) or (key > VK_MENU) then
  begin
    case key of
//      VK_PAUSE:   newText := newText+'Pause';
//      VK_NUMLOCK: newText := newText+'NumLock';
      VK_BACK: newText := '';
      VK_LWIN, VK_RWIN: ;
    else
    begin
      newText := newText + ShortCutToText(ShortCut(Key, []));
      if newText = '' then
        newText := GetSpecialNameEx(Key);
    end;
    end;
    fkeypressed := true;
  end;
  if newText = '' then
  begin
    text := 'None';
    newText := 'None';
  end
  else
    if newText <> Text then
      text := newText;
end;

procedure TElHotKey.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if ReadOnly then exit;
  if FKeyPressed then
  begin
    FText := Text;
    Change;
  end;
//  OnChange(self);
end;

procedure TElHotKey.SetShortCut(newValue: TShortCut);
begin
  if not ReadOnly then
  begin
    FText := ShortCutToText(newValue);
    if FText = '' then
      FText := 'None';
    Text := FText;
  end;
end;

function TElHotKey.GetShortCut: TShortCut;
var
  LS: string;
begin
  if (Pos(sLMDLWinP, FText) > 0) then
  begin
    LS := FText;
    Delete(LS, Pos(SLMDLWinP, LS), Length(SLMDLWinP));
    Result := TextToShortCut(LS);
    Result := Result or scWin;
  end
  else
    Result := TextToShortCut(FText);
end;

procedure TElHotKey.WMChar(var Message: TWMChar);
begin
end;

procedure TElHotKey.WMKeyUp(var Message: TWMKeyUp);
var
  ShiftState: TShiftState;
  begin
  with Message do
    begin
      ShiftState := KeyDataToShiftState(KeyData);
    KeyUp(CharCode, ShiftState);
    end;
end;

procedure TElHotKey.WMKeyDown(var Message: TWMKeyDown);
var
  ShiftState: TShiftState;
 begin
  with Message do
    begin
      ShiftState := KeyDataToShiftState(KeyData);
    KeyDown(CharCode, ShiftState);
    end;
end;

procedure TElHotKey.WMSysKeyDown(var Message: TWMKeyDown);
begin
  WMKeyDown(Message);
end;

procedure TElHotKey.SetInvalidKeys(Value: TElHKInvalidKeys);
var
  key: word;
begin
  if ReadOnly then exit;
  FInvalidKeys := Value;
  if (hcAlt in FInvalidKeys) and (hkAlt in FModifiers) then
    exclude(FModifiers, hkAlt);
  if (hcCtrl in FInvalidKeys) and (hkCtrl in FModifiers) then
    exclude(FModifiers, hkCtrl);
  if (hcShift in FInvalidKeys) and (hkShift in FModifiers) then
    exclude(FModifiers, hkShift);
  if (hcAltShift in FInvalidKeys) and (hkAlt in FModifiers) and (hkShift in
    FModifiers) then FModifiers := FModifiers - [hkAlt, hkShift];
  if (hcAltCtrl in FInvalidKeys) and (hkAlt in FModifiers) and (hkCtrl in
    FModifiers) then FModifiers := FModifiers - [hkAlt, hkCtrl];
  if (hcCtrlShift in FInvalidKeys) and (hkShift in FModifiers) and (hkCtrl in
    FModifiers) then FModifiers := FModifiers - [hkShift, hkCtrl];
  if (hcCtrlAlftShift in FInvalidKeys) and (FModiFiers = [hkCtrl, hkAlt,
    hkShift]) then FModifiers := [];
  key := VK_Shift;
  KeyDown(key, []);
end;

function TElHotKey.ShiftStateToText(state: TShiftState): TLMDString;
var
  i: byte;
begin
  Result := '';
  for i := 0 to 6 do
    {$ifdef LMDCOMP14}
    if ((word(1) shl i) and word(state)) > 0 then
    {$else}
    if ((byte(1) shl i) and byte(state)) > 0 then
    {$endif} 
      Result := Result + nshift[i];

  if (GetKeyState(VK_LWIN) and $8000) = $8000 then
    Result := Result + SLMDLWinP;

  if (GetKeyState(VK_RWIN) and $8000) = $8000 then
    Result := Result + SLMDRWinP;
end;

procedure TElHotKey.SetModifiers(Value: TElHKModifiers);
var
  key: word;
begin
  if ReadOnly then exit;
  FModifiers := Value;
  if (hcAlt in FInvalidKeys) and (hkAlt in FModifiers) then
    exclude(FInvalidKeys, hcAlt);
  if (hcCtrl in FInvalidKeys) and (hkCtrl in FModifiers) then
    exclude(FInvalidKeys, hcCtrl);
  if (hcShift in FInvalidKeys) and (hkShift in FModifiers) then
    exclude(FInvalidKeys, hcShift);
  if (hcAltShift in FInvalidKeys) and (hkAlt in FModifiers) and (hkShift in
    FModifiers) then exclude(FInvalidKeys, hcAltShift);
  if (hcAltCtrl in FInvalidKeys) and (hkAlt in FModifiers) and (hkCtrl in
    FModifiers) then exclude(FInvalidKeys, hcAltCtrl);
  if (hcCtrlShift in FInvalidKeys) and (hkShift in FModifiers) and (hkCtrl in
    FModifiers) then exclude(FInvalidKeys, hcCtrlShift);
  if FModiFiers = [hkCtrl, hkAlt, hkShift] then
    exclude(FInvalidKeys, hcCtrlAlftShift);
  key := VK_Shift;
  KeyDown(key, []);
end;

function TElHotKey.GetShiftState(state: TShiftState): TShiftState;
var
{$ifdef LMDCOMP14}
  b: word;
{$else}
  b: byte;
{$endif} 
begin
  {$ifdef LMDCOMP14}
  b := word(state);
  b := b or byte(FModifiers);
  {$else}
  b := byte(state);
  b := b or byte(FModifiers);
  {$endif} 
  Result := TShiftState(b);
  if ([ssShift, ssAlt, ssCtrl] * Result) <> [] then
  begin
    if (hcCtrlAlftShift in FInvalidKeys) and
      (ssAlt in Result) and (ssCtrl in Result) and
      (ssShift in Result) then
      if (ssAlt in FShiftState) and (ssCtrl in FShiftState) then
        Exclude(Result, ssShift)
      else
        if (ssAlt in FShiftState) and (ssShift in FShiftState) then
        Exclude(Result, ssCtrl)
      else
        if (ssCtrl in FShiftState) and (ssShift in FShiftState) then
        Exclude(Result, ssAlt);

    if (hcAltShift in FInvalidKeys) and (ssAlt in Result) and (ssShift in Result)
      then
      if ssShift in FShiftState then
        Exclude(Result, ssAlt)
      else
        Exclude(Result, ssShift);

    if (hcAltCtrl in FInvalidKeys) and (ssAlt in Result) and (ssCtrl in Result)
      then
      if ssCtrl in FShiftState then
        Exclude(Result, ssAlt)
      else
        Exclude(Result, ssCtrl);

    if (hcCtrlShift in FInvalidKeys) and (ssCtrl in Result) and
      (ssShift in Result) then
      if ssCtrl in FShiftState then
        Exclude(Result, ssShift)
      else
        Exclude(Result, ssCtrl);

    if (hcAlt in FInvalidKeys) then Exclude(Result, ssAlt);
    if (hcCtrl in FInvalidKeys) then Exclude(Result, ssCtrl);
    if (hcShift in FInvalidKeys) then Exclude(Result, ssShift);
  end;
end;

end.
