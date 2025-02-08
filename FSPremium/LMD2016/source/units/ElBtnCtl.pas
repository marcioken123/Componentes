unit ElBtnCtl;
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

ElBtnCtl unit
-------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses

  Controls,
  Messages,
  Windows,
  TypInfo,
  Graphics,
  Menus,
  Types,
  Themes,
  Forms,
  ActnList,
  Classes,

  ElVCLUtils,
  ElXPThemedControl,

  LMDSysIn,
  LMDGraph,
  LMDTypes,
  LMDUtils;

type
  TElButtonControl = class(TElXPThemedControl)
  private
    function IsCaptionStored: Boolean;
    procedure CMDialogChar(var Message : TCMDialogChar); message CM_DIALOGCHAR;
  protected
    FTransparent  : boolean;
    FTextDrawType : TLMDTextDrawType;
    F2000DrawFocus: boolean;
    F2000DrawAccel: boolean;

    procedure WMMove(var Msg : TWMMove); message WM_MOVE;

    procedure SetTextDrawType(newValue : TLMDTextDrawType);
  protected
    ClicksDisabled : boolean;
    FCaption: TLMDString;
    {$ifdef LMD_UNICODE}
    FHint: TLMDString;
    {$endif}
    FMoneyFlat: Boolean;
    FMoneyFlatActiveColor: TColor;
    FMoneyFlatInactiveColor: TColor;
    FMoneyFlatDownColor: TColor;
    {$ifdef LMD_UNICODE}
    function IsHintStored: Boolean;
    {$endif}
    function GetChecked : Boolean; virtual; abstract;
    procedure SetChecked(newValue : Boolean); virtual; abstract;
    procedure WndProc(var Message : TMessage); override;
    procedure SetTransparent(newValue : Boolean); virtual;

    function GetActionLinkClass : TControlActionLinkClass; override;
    procedure ActionChange(Sender : TObject; CheckDefaults : Boolean); override;

    property Checked : Boolean read GetChecked write SetChecked default false; { Protected }
    property TextDrawType : TLMDTextDrawType read FTextDrawType write SetTextDrawType default tdtNormal; { Published }
    procedure CreateParams(var Params : TCreateParams); override;
    procedure SetCaption(Value: TLMDString);

    function GetThemedElement: TThemedElement; override;
    function GetUIStateDrawFocus: Boolean;
    function GetUIStateDrawAccel: Boolean;
    procedure WMUpdateUIState(var Message: TMessage); message WM_UPDATEUISTATE;
    procedure WMChangeUIState(var Message: TMessage); message WM_CHANGEUISTATE;
    procedure SetMoneyFlat(Value: Boolean);
    procedure SetMoneyFlatActiveColor(Value: TColor);
    procedure SetMoneyFlatInactiveColor(Value: TColor);
    procedure SetMoneyFlatDownColor(Value: TColor);
    function GetMoneyFlat: Boolean;
    {$ifdef LMD_UNICODE}
    procedure SetHint(Value: TLMDString);

    procedure CMHintShow(var Message:TMessage); message CM_HINTSHOW;
    {$endif}
    procedure Notification(AComponent: TComponent; operation: TOperation); override;

  public
    constructor Create(Owner : TComponent); override;
    destructor Destroy; override;
    property Color nodefault;
    property Caption: TLMDString read FCaption write SetCaption stored IsCaptionStored;
    property MoneyFlat: Boolean read GetMoneyFlat write SetMoneyFlat default false;
    property MoneyFlatActiveColor: TColor read FMoneyFlatActiveColor write
        SetMoneyFlatActiveColor stored GetMoneyFlat;
    property MoneyFlatInactiveColor: TColor read FMoneyFlatInactiveColor write
        SetMoneyFlatInactiveColor stored GetMoneyFlat;
    property MoneyFlatDownColor: TColor read FMoneyFlatDownColor write
        SetMoneyFlatDownColor stored GetMoneyFlat;
    property UIStateDrawFocus: Boolean read GetUIStateDrawFocus;
    property UIStateDrawAccel: Boolean read GetUIStateDrawAccel;
    property Transparent : boolean read FTransparent write SetTransparent default false;
  published
    {$ifdef LMD_UNICODE}
    property Hint: TLMDString read FHint write SetHint stored IsHintStored;
    {$endif}
    property DoubleBuffered;
  end;

  TElButtonActionLink = class(TWinControlActionLink)
  protected
    FClient : TElButtonControl;
    procedure SetCaption(const Value: string); override;
    procedure AssignClient(AClient : TObject); override;
    function IsCheckedLinked : Boolean; override;
    function IsImageIndexLinked : Boolean; override;
    procedure SetChecked(Value : Boolean); override;
    procedure SetHint(const Value: string); override;
    function IsCaptionLinked: Boolean; override;
    function IsHintLinked: Boolean; override;
  end;

implementation

procedure TElButtonActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then
    FClient.Caption := Value;
  inherited;
end;

procedure TElButtonActionLink.AssignClient(AClient : TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TElButtonControl;
end;

function TElButtonActionLink.IsCaptionLinked: Boolean;
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
{$ifdef LMD_UNICODE}
  PropInfo := TypInfo.GetPropInfo(Action.ClassInfo, 'Caption');
  if (PropInfo <> nil) then
    Result := (Action is TCustomAction) and (FClient.Caption = GetWideStrProp(Action, 'Caption'))
  else
{$endif}
    Result := inherited IsCaptionLinked;
end;

function TElButtonActionLink.IsHintLinked: Boolean;
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
{$ifdef LMD_UNICODE}
  PropInfo := TypInfo.GetPropInfo(Action.ClassInfo, 'Hint');
  if (PropInfo <> nil) then
    Result := (Action is TCustomAction) and (FClient.Hint = GetWideStrProp(Action, 'Hint'))
  else
{$endif}
    Result := inherited IsHintLinked;
end;

function TElButtonActionLink.IsCheckedLinked : Boolean;
begin
  Result := inherited IsCheckedLinked and
    (FClient.Checked = (Action as TCustomAction).Checked);
end;

function TElButtonActionLink.IsImageIndexLinked : Boolean;
begin
  result := true;
end;

procedure TElButtonActionLink.SetChecked(Value : Boolean);
begin
  if IsCheckedLinked then
  begin
    FClient.ClicksDisabled := True;
    try
      FClient.Checked := Value;
    finally
      FClient.ClicksDisabled := False;
    end;
  end;
end;

procedure TElButtonActionLink.SetHint;
begin
  if IsHintLinked then
    FClient.Hint := Value;
  inherited;
end;

procedure TElButtonControl.ActionChange(Sender : TObject; CheckDefaults : Boolean);
{$ifdef LMD_UNICODE}
var
  PropInfo: PPropInfo;
{$endif}
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
  begin
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Checked = False) then
        Self.Checked := Checked;
    end;
    if Sender is TAction then
    begin
      if not CheckDefaults or (Caption = '') or (Caption = Name) then
      begin
    {$ifdef LMD_UNICODE}
        PropInfo := TypInfo.GetPropInfo(Sender.ClassInfo, 'Caption');
        if (PropInfo <> nil) then
          Self.Caption := GetWideStrProp(Sender, 'Caption')
        else
    {$endif}
          Self.Caption := TAction(Sender).Caption;
      end;
      if not CheckDefaults or (Enabled = True) then
        Enabled := TAction(Sender).Enabled;
      if not CheckDefaults or (Self.Visible = True) then
        Visible := TAction(Sender).Visible;
      if not CheckDefaults or (HelpContext = 0) then
        HelpContext := TAction(Sender).HelpContext;
      if not CheckDefaults or (Hint = '') then
      begin
    {$ifdef LMD_UNICODE}
        PropInfo := TypInfo.GetPropInfo(Sender.ClassInfo, 'Hint');
        if (PropInfo <> nil) then
          Hint := GetWideStrProp(Sender, 'Hint')
        else
    {$endif}
          Hint := TAction(Sender).Hint;
      end;
    end;
  end;
end;

function TElButtonControl.GetActionLinkClass : TControlActionLinkClass;
begin
  Result := TElButtonActionLink;
end;

procedure TElButtonControl.WndProc(var Message : TMessage); { protected }
begin
  inherited;
  if Message.Msg in [WM_KILLFOCUS, WM_SETFOCUS] then
    Invalidate;
  if (TLMDPtrUInt(Message.Msg) = ParentControlRepaintedMessage) {and Transparent} and
     (Message.lParam <> TLMDPtrInt(Self)) then
    begin
      Invalidate;
    end;
end; { WndProc }

procedure TElButtonControl.SetTransparent(newValue : Boolean);
begin
  if (FTransparent <> newValue) then
  begin
    FTransparent := newValue;
    if FTransparent then
      ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    RecreateWnd;
    end; { if }
end; { SetTransparent }

procedure TElButtonControl.CreateParams(var Params : TCreateParams);
begin
  inherited;
  if Transparent then
    Params.ExStyle := Params.ExStyle or WS_EX_TRANSPARENT
  else
    Params.ExStyle := Params.ExStyle and not WS_EX_TRANSPARENT;
end;

procedure TElButtonControl.WMMove(var Msg : TWMMove);  { private }
begin
  inherited;
  if Transparent then Repaint;
end;  { WMMove }

procedure TElButtonControl.SetTextDrawType(newValue : TLMDTextDrawType);
begin
  if (FTextDrawType <> newValue) then
  begin
    FTextDrawType := newValue;
    Repaint;
  end; { if }
end; { SetTextDrawType }

type PInteger = ^Integer;

constructor TElButtonControl.Create(Owner : TComponent);
begin
  inherited;
  ControlStyle := ControlStyle - [csSetCaption];

  PInteger(@Color)^ := clBtnFace;
  PInteger(@Font.Color)^ := clBtnText;

  F2000DrawFocus := true;
  F2000DrawAccel := F2000DrawFocus;
end;

{$ifdef LMD_UNICODE}
function TElButtonControl.IsHintStored: Boolean;
begin
  Result := (ActionLink = nil) or (not TElButtonActionLink(ActionLink).IsHintLinked);
end;
{$endif}

procedure TElButtonControl.SetCaption(Value: TLMDString);
begin
  if FCaption <> Value then
  begin
    inherited Caption := '';
    FCaption := Value;
    inherited Caption := Value;
  end;
end;

function TElButtonControl.IsCaptionStored: Boolean;
begin
  Result := (ActionLink = nil) or not TElButtonActionLink(ActionLink).IsCaptionLinked;
end;

procedure TElButtonControl.CMDialogChar(var Message : TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
    begin
      SetFocus;
      Click;
      Result := 1;
    end
    else
      inherited;
end;

function TElButtonControl.GetThemedElement: TThemedElement;
begin
  Result := teButton;
end;

function TElButtonControl.GetUIStateDrawFocus: Boolean;
begin
  if not LMDSIWindows2000Up then
    result := true
  else
    Result := F2000DrawFocus; //(SendMessage(Handle, WM_QUERYUISTATE, 0, 0) and UISF_HIDEFOCUS = 0);
end;

function TElButtonControl.GetUIStateDrawAccel: Boolean;
begin
  if not LMDSIWindows2000Up then
    result := true
  else
    Result := F2000DrawAccel; // (SendMessage(Handle, WM_QUERYUISTATE, 0, 0) and UISF_HIDEACCEL) = 0;
end;

procedure TElButtonControl.WMUpdateUIState(var Message: TMessage);
begin
  inherited;
  (*
  case LOWORD(Message.wParam) of
    UIS_CLEAR:
      begin
        if HIWORD(Message.wParam) and UISF_HIDEACCEL <> 0 then
        begin
          F2000DrawAccel := false;
        end;
        if HIWORD(Message.wParam) and UISF_HIDEFOCUS <> 0 then
        begin
          F2000DrawAccel := false;
        end;
        Invalidate;
      end;
    // UIS_INITIALIZE:
    UIS_SET:
      begin
        if HIWORD(Message.wParam) and UISF_HIDEACCEL <> 0 then
        begin
          F2000DrawAccel := true;
        end;
        if HIWORD(Message.wParam) and UISF_HIDEFOCUS <> 0 then
        begin
          F2000DrawAccel := true;
        end;
        Invalidate;
      end;
  end;
  *)
end;

procedure TElButtonControl.WMChangeUIState(var Message: TMessage);
begin
  inherited;
end;

procedure TElButtonControl.SetMoneyFlat(Value: Boolean);
begin
  if FMoneyFlat <> Value then
  begin
    FMoneyFlat := Value;
    Invalidate;
  end;
end;

procedure TElButtonControl.SetMoneyFlatActiveColor(Value: TColor);
begin
  if FMoneyFlatActiveColor <> Value then
  begin
    FMoneyFlatActiveColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

procedure TElButtonControl.SetMoneyFlatInactiveColor(Value: TColor);
begin
  if FMoneyFlatInactiveColor <> Value then
  begin
    FMoneyFlatInactiveColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

procedure TElButtonControl.SetMoneyFlatDownColor(Value: TColor);
begin
  if FMoneyFlatDownColor <> Value then
  begin
    FMoneyFlatDownColor := Value;
    if MoneyFlat then Invalidate;
  end;
end;

function TElButtonControl.GetMoneyFlat: Boolean;
begin
  Result := FMoneyFlat;
end;

{$ifdef LMD_UNICODE}
procedure TElButtonControl.CMHintShow(var Message: TMessage);
var
  HintInfo : PHintInfo;
  //T: WideChar;
  //l : integer;
  S : String;
  WS: WideString;

  function AddShortcutToHint(WS : WideString) : WideString;
  begin
    if (WS <> '') and (ActionLink.Action is TCustomAction) and (TCustomAction(ActionLink.Action).ShortCut <> scNone) then
    begin
      result := WS + ' (' + ShortCutToText(TCustomAction(ActionLink.Action).ShortCut) + ')';
    end
    else
      result := WS;
  end;

begin

  inherited;
  HintInfo := PHintInfo(Message.lParam);

  if Length(FHint) = 0 then
  begin
    HintInfo.hintStr := '';
    exit;
  end;

  S := GetShortHint(inherited Hint);
  if HintInfo.HintStr = S then
  begin
    WS := LMDWideGetShortHint(FHint);
    if Application.HintShortCuts and (ActionLink <> nil) then
      WS := AddShortcutToHint(WS);
    end
  else
  begin
    if Application.HintShortCuts and (ActionLink <> nil) then
      WS := AddShortcutToHint(FHint)
    else
    WS := FHint;

    S := WS;
  end;
  (*
  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));*)

end;

procedure TElButtonControl.SetHint(Value: TLMDString);
begin
  FHint := Value;
  inherited Hint := LMDConvertVCLHint(FHint);
end;
{$endif}

procedure TElButtonControl.Notification(AComponent: TComponent; operation:
    TOperation);
begin
  inherited Notification(AComponent, operation);
end; {Notification}

destructor TElButtonControl.Destroy;
begin
  inherited;
end;

end.
