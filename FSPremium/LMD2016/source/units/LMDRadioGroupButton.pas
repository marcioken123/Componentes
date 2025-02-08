unit LMDRadioGroupButton;
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

LMDRadioGroupButton unit ()
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Messages, Classes, LMDCustomRadioGroup, LMDCustomButtonGroup, LMDRadioButton;

type
  TLMDRadioGroupButton = class(TLMDRadioButton)
  private
    {FInClick: Boolean;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;}
    procedure WMKeyDown (var Msg : TWMKEYDOWN); message WM_KEYDOWN;
    procedure WMKeyUp (var Msg : TWMKEYUP); message WM_KEYUP;
    procedure WMKey (var Msg : TWMChar); message WM_CHAR;
    procedure WMLMouseDown (var Msg : TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMLMouseUp (var Msg : TWMLButtonUp); message WM_LBUTTONUP;
    procedure WMRMouseDown (var Msg : TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRMouseUp (var Msg : TWMRButtonUp); message WM_RBUTTONUP;
    procedure WMMouseMove (var Msg : TWMMouseMove); message WM_MOUSEMOVE;
  protected
    function CanModify: Boolean; override;
    procedure SetChecked(aValue:Boolean);override;
    procedure ChangeScale(M, D: Integer); override;
    procedure DblClick; override;
{    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;}
  public
    constructor CreateExt(Group: TLMDCustomRadioGroup);
    destructor Destroy; override;
    property Transparent default True;
  end;

implementation

uses
  Windows,
  Controls;

{ --------------------------------- private ---------------------------------- }
procedure TLMDRadioGroupButton.WMKeyDown (var Msg : TWMKEYDOWN);
begin
  inherited;
  SendMessage (TLMDCustomRadioGroup(Parent).Handle, Msg.Msg, Msg.CharCode, Msg.KeyData);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.WMKeyUp (var Msg : TWMKEYUP);
begin
  inherited;
  SendMessage (TLMDCustomRadioGroup(Parent).Handle, Msg.Msg, Msg.CharCode, Msg.KeyData);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.WMKey (var Msg : TWMChar);
begin
  inherited;
  SendMessage (TLMDCustomRadioGroup(Parent).Handle, Msg.Msg, Msg.CharCode, Msg.KeyData);
  if (Msg.CharCode = VK_BACK) or (Msg.CharCode = VK_SPACE) then
    begin
      if not TLMDCustomRadioGroup(Parent).CanModify then begin Msg.CharCode := 0; Msg.Result := 0; end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.WMLMouseDown (var Msg : TWMLButtonDown);
begin

  with  TMessage(Msg) do
    SendMessage(TLMDCustomRadioGroup(Parent).Handle, Msg, wParam, lParam);

  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.WMLMouseUp (var Msg : TWMLButtonUp);
begin
  if Assigned(TLMDCustomRadioGroup(Parent).OnMouseUp) then
    TLMDCustomRadioGroup(Parent).OnMouseUp(Self, mbLeft, [], Msg.XPos, Msg.YPos);
//  with  TMessage(Msg) do
//    SendMessage(TLMDCustomRadioGroup(Parent).Handle, Msg, wParam, lParam);

  inherited;
  if not (csDesigning in ComponentState) and Checked then
    with TLMDCustomRadioGroup(Parent) do
      if (ItemIndex=-1) or (TLMDRadioGroupButton(Buttons[ItemIndex])<>self) then Click;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.WMRMouseDown (var Msg : TWMRButtonDown);
begin

  with  TMessage(Msg) do
    SendMessage (TLMDCustomRadioGroup(Parent).Handle, Msg, wParam, lParam);

  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.WMRMouseUp (var Msg : TWMRButtonUp);
begin

  with  TMessage(Msg) do
    SendMessage (TLMDCustomRadioGroup(Parent).Handle, Msg, wParam, lParam);

  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.WMMouseMove (var Msg : TWMMouseMove);
begin

  with  TMessage(Msg) do
    SendMessage (TLMDCustomRadioGroup(Parent).Handle, Msg, wParam, lParam);

  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDRadioGroupButton.CanModify: Boolean;
begin
  result:=TLMDCustomRadioGroup(Parent).CanModify;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.SetChecked(aValue:Boolean);
begin
  inherited SetChecked(aValue)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.ChangeScale(M, D: Integer);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.DblClick;
begin
  inherited;
  //pass down dbl click events. Parent control will not dtermine itself the
  //double click, because the mouse is not above the control itself, its above
  //an item button!
  if Assigned (TLMDCustomRadioGroup(Parent).OnDblClick) then
    TLMDCustomRadioGroup(Parent).OnDblClick (TLMDCustomRadioGroup(Parent));
end;

(*{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  TLMDCustomRadioGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
    begin
      if not TLMDCustomRadioGroup(Parent).CanModify then Key := #0;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TLMDCustomRadioGroup(Parent).KeyDown(Key, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  TLMDCustomRadioGroup(Parent).KeyUp(Key, Shift);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TLMDCustomRadioGroup(Parent).MouseDown(Button, Shift, X, Y);
  inherited MouseDown(Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  TLMDCustomRadioGroup(Parent).MouseUp(Button, Shift, X, Y);
  inherited MouseDown(Button, Shift, X, Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDRadioGroupButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  TLMDCustomRadioGroup(Parent).MouseMove(Shift, X, Y);
  inherited MouseMove(Shift, X, Y);
end;
*)
{ ------------------------------- public ------------------------------------- }
constructor TLMDRadioGroupButton.CreateExt(Group:TLMDCustomRadioGroup);
begin
  inherited Create(Group);
  ControlStyle:=ControlStyle+[csReplicatable];
  Visible:=False;
  ParentShowHint := False;
  Transparent:=True;

  with Group do
    begin
      RegisterButton(Self);
      self.Enabled := Enabled;
    end;

  Parent := Group;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDRadioGroupButton.Destroy;
begin
  TLMDCustomRadioGroup(Owner).UnRegisterButton(Self);
  inherited Destroy;
end;

end.
