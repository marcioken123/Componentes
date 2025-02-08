{ Summary
  This unit contains the TJSPasswordDialog implementation. }
unit JSPasswordDialog;

interface

{$I lmddlgcmps.inc}

uses
  Classes, Controls, Graphics, SysUtils, JSEditDialog, JSDialogs;

type
  { Summary
    Default exception class for any exceptions raised by the TJSCustomPasswordDialog control. }
  EPasswordDialogException = class(Exception);

  { Summary
    TJSCustomPasswordDialog implements the functionality required to validate a new password dialog. }
  TJSCustomPasswordDialog = class(TJSEditDialog)
  private
    FPassword: string;
    FExtendedValidation: Boolean;
    procedure SetAllowPlainTextInput(const Value: Boolean);
    function GetAllowPlainTextInput: Boolean;
  protected
    procedure DoGetEditControlClass(var AControlClass: TControlClass); override;
    function GetActiveControl: TWinControl; override;
    function DoGetControlHeight: Integer; override;
    procedure DoDialogClose(Sender: TObject); override;
    procedure DoVerificationClick(const Checked: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    { Summary
      Returns the value of the password edit box.
      Description
      Access the Password property to determine what the user input into the password edit box. }
    property Password: string read FPassword;
    { Summary
      Specifies that the verification check box is displayed allowing the user to show passwords as plain text.
      Description
      When AllowPlainTextInput is True, the verification check box is visible and can be selected to display
      the entered passwords as plain text instead of being masked.
      Remarks
      The default value is True.                                                                            }
    property AllowPlainTextInput: Boolean read GetAllowPlainTextInput write SetAllowPlainTextInput default True;
    { Summary
      Specifies that additional input validation occurs as the user types in the passwords.
      Description
      When ExtendedValidation is True if the Password and ConfirmedPassword values don't match, then the OK
      button of the dialog is disabled.
      Remarks
      The default value is True.                                                                            }
    property ExtendedValidation: Boolean read FExtendedValidation write FExtendedValidation default True;
  published
    property MainIcon default tdiCustom;
  end;

  { Summary
    Published version of the TJSCustomPasswordDialog component.
    Description
    Use the TJSPasswordDialog component to have a dialog that can easily validate a change of password
    circumstance.                                                                                      }
  {$IFDEF DELPHI_XE2}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64{ or pidOSX32})]
  {$ENDIF}
  TJSPasswordDialog = class(TJSCustomPasswordDialog)
  published
    property AllowPlainTextInput;
    property ExtendedValidation;
  end;

  { Summary
    TJSCustomConfirmPasswordDialog implements the functionality required to validate a new password
    dialog.
    Description                                                                                     }
  TJSCustomConfirmPasswordDialog = class(TJSPasswordDialog)
  private
    FConfirmedPassword: string;
  protected
    procedure DoDialogClose(Sender: TObject); override;
    function DoGetControlHeight: Integer; override;
    procedure DoGetEditControlClass(var AControlClass: TControlClass); override;
  public
    constructor Create(AOwner: TComponent); override;
    { Summary
      Returns the value of the confirmed edit box.
      Description
      Access the ConfirmedPassword property to determine what the user input into the confirmed password
      edit box.                                                                                          }
    property ConfirmedPassword: string read FConfirmedPassword;
  end;

  { Summary
    Published version of the TJSCustomConfirmPasswordDialog component.
    Description
    Use the TJSConfirmPasswordDialog component to have a dialog that can easily validate a change of
    password circumstance. Unlike the TJSChangePasswordDialog, the confirm password dialog does not
    prompt for the previous password.                                                                }
  {$IFDEF DELPHI_XE2}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64{ or pidOSX32})]
  {$ENDIF}
  TJSConfirmPasswordDialog = class(TJSCustomConfirmPasswordDialog)

  end;

  { Summary
    TJSCustomChangePasswordDialog implements the functionality required to validate a new password dialog
    when verification of the old password is required. }
  TJSCustomChangePasswordDialog = class(TJSConfirmPasswordDialog)
  private
    FOldPassword: string;
  protected
    procedure DoGetEditControlClass(var AControlClass: TControlClass); override;
    function DoGetControlHeight: Integer; override;
    procedure DoDialogClose(Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    { Summary
      Returns the value of the old password edit box.
      Description
      Access the OldPassword property to determine what the user input into the old password edit box.   }
    property OldPassword: string read FOldPassword;
  end;

  { Summary
    Published version of the TJSCustomChangePasswordDialog component.
    Description
    Use the TJSChangePasswordDialog component to have a dialog that can easily validate a change of password
    circumstance.                                                                                      }
  {$IFDEF DELPHI_XE2}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64{ or pidOSX32})]
  {$ENDIF}
  TJSChangePasswordDialog = class(TJSCustomChangePasswordDialog)

  end;

implementation

{$R JSPasswordDialog.res}

uses
  Windows, Forms, StdCtrls, JSEditDialogIntf, JSPasswordDialogFrame,
  JSConfirmPasswordDialogFrame, JSDialogStrs, JSChangePasswordDialogFrame,
  JSGraphUtil, Math;

{ TJSCustomPasswordDialog }

constructor TJSCustomPasswordDialog.Create(AOwner: TComponent);
begin
  inherited;
  EditProperties.EditType := etCustom;
  AllowPlainTextInput := True;
  ExtendedValidation := True;
  Title := GetTranslatedString(StrPasswordDialogTitle);
  Instruction.Text := GetTranslatedString(StrPasswordDialogInstruction);
  MainIcon := tdiCustom;
  {$IFNDEF DELPHI}
  Glyph.Icon.LoadFromResourceName(hInstance, 'ZJSD_PASSWORD');
  {$ENDIF}
end;

procedure TJSCustomPasswordDialog.DoDialogClose(Sender: TObject);
begin
  // Need to populate the properties using the values entered in on the custom control
  if EditControls[0] <> nil then
  begin
    FPassword := TfmJSPasswordDialog(EditControls[0]).Password;
  end;
  inherited;
end;

function TJSCustomPasswordDialog.DoGetControlHeight: Integer;
begin
  result := MulDiv(24, Screen.PixelsPerInch, 96);
end;

procedure TJSCustomPasswordDialog.DoGetEditControlClass(var AControlClass: TControlClass);
begin
  AControlClass := TfmJSPasswordDialog;
end;

procedure TJSCustomPasswordDialog.DoVerificationClick(const Checked: Boolean);
var
  i: Integer;
  lFrame: TFrame;
begin
  inherited;
  if AllowPlainTextInput then
  begin
    lFrame := TFrame(EditControls[0]);
    for i := 0 to lFrame.ControlCount - 1 do
    begin
      if lFrame.Controls[i] is TEdit then
      begin
        if Checked then
          TEdit(lFrame.Controls[i]).PasswordChar := #0
        else
          TEdit(lFrame.Controls[i]).PasswordChar := '*';
      end;
    end;
  end;
end;

function TJSCustomPasswordDialog.GetActiveControl: TWinControl;
var
  LIntf: IJSEditDialogControl;
begin
  if Supports(EditControls[0], IJSEditDialogControl, LIntf) then
    result := LIntf.ActiveControl
  else
    result := inherited GetActiveControl;
end;

function TJSCustomPasswordDialog.GetAllowPlainTextInput: Boolean;
begin
  result := Verification.Visible;
end;

procedure TJSCustomPasswordDialog.SetAllowPlainTextInput(const Value: Boolean);
begin
  Verification.Text := GetTranslatedString(StrAllowPlainTextPasswordsCaption);
  Verification.Visible := Value;
end;

{ TJSCustomChangePasswordDialog }

constructor TJSCustomChangePasswordDialog.Create(AOwner: TComponent);
begin
  inherited;
  Title := GetTranslatedString(StrChangePasswordDialogTitle);
  Instruction.Text := GetTranslatedString(StrChangePasswordDialogInstruction);
  Content.Text := GetTranslatedString(StrChangePasswordDialogContent);
end;

procedure TJSCustomChangePasswordDialog.DoDialogClose(Sender: TObject);
begin
  // Need to populate the properties using the values entered in on the custom control
  if EditControls[0] <> nil then
    FOldPassword := TfmJSChangePasswordDialog(EditControls[0]).OldPassword;
  inherited;
end;

function TJSCustomChangePasswordDialog.DoGetControlHeight: Integer;
begin
  result := MulDiv(78, Screen.PixelsPerInch, 96);
end;

procedure TJSCustomChangePasswordDialog.DoGetEditControlClass(var AControlClass: TControlClass);
begin
  AControlClass := TfmJSChangePasswordDialog;
end;

{ TJSCustomConfirmPasswordDialog }

constructor TJSCustomConfirmPasswordDialog.Create(AOwner: TComponent);
begin
  inherited;
  Title := GetTranslatedString(StrConfirmPasswordDialogTitle);
  Instruction.Text := GetTranslatedString(StrConfirmPasswordDialogInstruction);
  Content.Text := GetTranslatedString(StrConfirmPasswordDialogContent);
end;

procedure TJSCustomConfirmPasswordDialog.DoDialogClose(Sender: TObject);
begin
  inherited;
  // Need to populate the properties using the values entered in on the custom control
  if EditControls[0] <> nil then
  begin
    FConfirmedPassword := TfmJSConfirmPasswordDialog(EditControls[0]).ConfirmedPassword;
  end;
end;

function TJSCustomConfirmPasswordDialog.DoGetControlHeight: Integer;
begin
  result := MulDiv(54, Screen.PixelsPerInch, 96);
end;

procedure TJSCustomConfirmPasswordDialog.DoGetEditControlClass(
  var AControlClass: TControlClass);
begin
  AControlClass := TfmJSConfirmPasswordDialog;
end;

end.
