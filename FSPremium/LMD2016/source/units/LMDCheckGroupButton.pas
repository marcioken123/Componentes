unit LMDCheckGroupButton;
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

LMDCheckGroupButton unit ()
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Controls,
  Messages,
  LMDCustomCheckGroup,
  LMDCheckBox;

type
  TLMDCheckGroupButton = class(TLMDCheckBox)
  private
    procedure WMKeyDown (var Msg : TWMKEYDOWN); message WM_KEYDOWN;
    procedure WMKey (var Msg : TWMChar); message WM_CHAR;
  protected
    function CanModify:Boolean;override;
    procedure ChangeScale(M, D: Integer); override;
//    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
//    procedure KeyPress(var Key: Char); override;
    procedure Toggle; override;
    procedure WndProc(var Msg: TMessage); override;
  public
    constructor CreateExt(Group: TLMDCustomCheckGroup);
    destructor Destroy; override;
    property Transparent default True;
  end;

implementation

uses
  Windows,
  LMDCustomButtonGroup;

{ --------------------------------- private ---------------------------------- }
procedure TLMDCheckGroupButton.WMKeyDown (var Msg : TWMKEYDOWN);
begin
  inherited;
  SendMessage (TLMDCustomCheckGroup(Parent).Handle, Msg.Msg, Msg.CharCode, Msg.KeyData);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckGroupButton.WMKey (var Msg : TWMChar);
begin
  inherited;
  SendMessage (TLMDCustomCheckGroup(Parent).Handle, Msg.Msg, Msg.CharCode, Msg.KeyData);
  if (Msg.CharCode = VK_BACK) or (Msg.CharCode = VK_SPACE) then
    begin
      if not CanModify then begin Msg.CharCode := 0; Msg.Result := 0; end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCheckGroupButton.CanModify:Boolean;
begin
  result:=TLMDCustomCheckGroup(Parent).CanModify;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckGroupButton.ChangeScale(M, D: Integer);
begin
end;

(*{ ---------------------------------------------------------------------------- }
procedure TLMDCheckGroupButton.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  TLMDCustomCheckGroup(Parent).KeyPress(Key);
  if (Key = #8) or (Key = ' ') then
    begin
      if not CanModify then Key := #0;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckGroupButton.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  TLMDCustomCheckGroup(Parent).KeyDown(Key, Shift);
end;*)

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckGroupButton.Toggle;
begin
  inherited Toggle;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDCheckGroupButton.CreateExt(Group:TLMDCustomCheckGroup);
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
//      self.OnChange := ButtonClick;
    end;
  Parent := Group;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCheckGroupButton.Destroy;
begin

  TLMDCustomCheckGroup(Owner).UnregisterButton(Self);

  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCheckGroupButton.WndProc(var Msg: TMessage);
begin
  with Msg do
    begin
      if (msg >= WM_MOUSEFIRST) and (msg <= WM_MOUSELAST) and
        not (csDesigning in ComponentState) and
        Assigned(Parent) and (Parent is TLMDCustomButtonGroup)
      then
        TLMDCustomButtonGroup(Parent).Perform(msg, WParam, LParam);
    end;
  inherited;
end;

end.
