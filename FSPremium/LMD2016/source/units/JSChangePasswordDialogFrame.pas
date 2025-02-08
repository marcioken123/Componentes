{ Summary
  This unit contains the custom frame control used in the TJSChangePasswordDialog implementation. }
unit JSChangePasswordDialogFrame;

interface

{$I lmddlgcmps.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, JSConfirmPasswordDialogFrame, StdCtrls, JSEditDialogIntf;

type
  { Summary
    TFrame descendant used as the custom control on the TJSChangePasswordDialog class.
    Description
    This is the frame control used in the TJSChangePasswordDialog to present the user with the interface in
    which to change an existing password that requires the Old Password to be verified at the same time. }
  TfmJSChangePasswordDialog = class(TfmJSConfirmPasswordDialog, IJSEditDialogControl)
    lOldPasswordLabel: TLabel;
    eOldPassword: TEdit;
  private
    function GetOldPassword: string;
  protected
    procedure LoadCaptions; override;
  public
    function ActiveControl: TWinControl;
    procedure AdjustControlLayout(const AWidth: Integer);
    property OldPassword: string read GetOldPassword;
  end;

var
  fmJSChangePasswordDialog: TfmJSChangePasswordDialog;

implementation

uses
  JSDialogStrs, Math;

{$R *.dfm}

{ TfmJSChangePasswordDialog }

function TfmJSChangePasswordDialog.ActiveControl: TWinControl;
begin
  result := eOldPassword;
end;

procedure TfmJSChangePasswordDialog.AdjustControlLayout(const AWidth: Integer);
var
  lAdjustment: Integer;
  lShift: Integer;
  lMargins: Integer;
  lLabel: TLabel; // largest label
begin
  if Width <> AWidth then
    Width := AWidth;
  lMargins := 3 * 6; // left margin + label / control margin + right margin
  if lConfirmPasswordLabel.Width > lNewPasswordLabel.Width then
  begin
    if lConfirmPasswordLabel.Width > lOldPasswordLabel.Width then
      lLabel := lConfirmPasswordLabel
    else
      lLabel := lOldPasswordLabel;
  end
  else
  begin
    if lNewPasswordLabel.Width > lOldPasswordLabel.Width then
      lLabel := lNewPasswordLabel
    else
      lLabel := lOldPasswordLabel;
  end;
  lAdjustment := Width - (lLabel.Width + lMargins);
  // All edit controls are the same width in the password user interface, so it
  // doesn't matter which edit control is used to calculate the shift amount
  lShift := eConfirmPassword.Width - lAdjustment;
  eOldPassword.Width := lAdjustment;
  eNewPassword.Width := lAdjustment;
  eConfirmPassword.Width := lAdjustment;
  eOldPassword.Left := eOldPassword.Left + lShift;
  eNewPassword.Left := eNewPassword.Left + lShift;
  eConfirmPassword.Left := eConfirmPassword.Left + lShift;
  lOldPasswordLabel.Left := lOldPasswordLabel.Left + lShift;
  lNewPasswordLabel.Left := lNewPasswordLabel.Left + lShift;
  lConfirmPasswordLabel.Left := lConfirmPasswordLabel.Left + lShift;
end;

function TfmJSChangePasswordDialog.GetOldPassword: string;
begin
  result := eOldPassword.Text;
end;

procedure TfmJSChangePasswordDialog.LoadCaptions;
begin
  inherited;
  lOldPasswordLabel.Caption := GetTranslatedString(StrOldPasswordCaption);
end;

end.
