{ Summary
  This unit contains the custom frame control used in the TJSConfirmPasswordDialog implementation. }
unit JSConfirmPasswordDialogFrame;

interface

{$I lmddlgcmps.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, JSEditDialog, JSEditDialogIntf, JSTypes, JSPasswordDialog,
  JSPasswordDialogFrame;

type
  { Summary
    TFrame descendant used as the custom control on the TJSPasswordDialog class.
    Description
    This is the frame control used in the TJSPasswordDialog to present the user with the interface in
    which to change an existing password.                                                             }
  TfmJSConfirmPasswordDialog = class(TfmJSPasswordDialog, IJSEditDialogControl)
    lConfirmPasswordLabel: TLabel;
    eConfirmPassword: TEdit;
    procedure eNewPasswordChange(Sender: TObject);
    procedure eConfirmPasswordChange(Sender: TObject);
  private
    FDialog: TJSPasswordDialog;
    function GetConfirmedPassword: string;
  protected
    FActiveControlInError: TWinControl;
    procedure LoadCaptions; override;
  public
    constructor Create(AOwner: TComponent); override;
    function ActiveControl: TWinControl;
    function ActiveControlInError: TWinControl;
    procedure AdjustControlLayout(const AWidth: Integer);
    function GetRequiredWidth: Integer;
    procedure SetActiveControlInError(AControl: TWinControl);
    procedure SetDialog(JSDialog: TJSCustomEditDialog);
    function ValidateInput(out Message: TJSString; const ModalResult: TModalResult): Boolean;
    { <copy JSPasswordDialog.TJSCustomPasswordDialog.ConfirmedPassword>
      
      \ \                                                               }
    property ConfirmedPassword: string read GetConfirmedPassword;
  end;

implementation

uses
  JSDialogStrs, Math;

{$R *.dfm}

{ TfmJSConfirmPasswordDialog }

function TfmJSConfirmPasswordDialog.ActiveControl: TWinControl;
begin
  result := eNewPassword;
end;

function TfmJSConfirmPasswordDialog.ValidateInput(out Message: TJSString; const ModalResult: TModalResult): Boolean;
begin
  FActiveControlInError := nil;
  if ModalResult = mrOK then
  begin
    result := SameText(eNewPassword.Text, eConfirmPassword.Text);
    if not result then
    begin
      Message := StrPasswordsMustBeTheSame;
      FActiveControlInError := eConfirmPassword;
    end
    else
      Message := '';
  end
  else
    result := True;
end;

function TfmJSConfirmPasswordDialog.ActiveControlInError: TWinControl;
begin
  if FActiveControlInError <> nil then
    result := FActiveControlInError
  else
    result := ActiveControl;
end;

procedure TfmJSConfirmPasswordDialog.AdjustControlLayout(const AWidth: Integer);
var
  lAdjustment: Integer;
  lShift: Integer;
  lMargins: Integer;
begin
  if Width <> AWidth then
    Width := AWidth;
  lMargins := 3 * 6; // left margin + label / control margin + right margin
  if lConfirmPasswordLabel.Width > lNewPasswordLabel.Width then
  begin
    lAdjustment := Width - (lConfirmPasswordLabel.Width + lMargins);
    lShift := eConfirmPassword.Width - lAdjustment;
  end
  else
  begin
    lAdjustment := Width - (lNewPasswordLabel.Width + lMargins);
    lShift := eNewPassword.Width - lAdjustment;
  end;
  eNewPassword.Width := lAdjustment;
  eConfirmPassword.Width := lAdjustment;
  eNewPassword.Left := eNewPassword.Left + lShift;
  eConfirmPassword.Left := eConfirmPassword.Left + lShift;
  lNewPasswordLabel.Left := lNewPasswordLabel.Left + lShift;
  lConfirmPasswordLabel.Left := lConfirmPasswordLabel.Left + lShift;
end;

constructor TfmJSConfirmPasswordDialog.Create(AOwner: TComponent);
begin
  inherited;
  FActiveControlInError := nil;
  LoadCaptions;
end;

procedure TfmJSConfirmPasswordDialog.eConfirmPasswordChange(Sender: TObject);
begin
  if (FDialog <> nil) and FDialog.ExtendedValidation then
  begin
    FDialog.EnableButton(mrOK, SameText(eNewPassword.Text, eConfirmPassword.Text));
  end;
end;

procedure TfmJSConfirmPasswordDialog.eNewPasswordChange(Sender: TObject);
begin
  if (FDialog <> nil) and FDialog.ExtendedValidation then
  begin
    FDialog.EnableButton(mrOK, SameText(eNewPassword.Text, eConfirmPassword.Text));
  end;
end;

function TfmJSConfirmPasswordDialog.GetConfirmedPassword: string;
begin
  Result := eConfirmPassword.Text;
end;

function TfmJSConfirmPasswordDialog.GetRequiredWidth: Integer;
begin
  result := MulDiv(320, Screen.PixelsPerInch, 96);
end;

procedure TfmJSConfirmPasswordDialog.LoadCaptions;
begin
  lNewPasswordLabel.Caption := GetTranslatedString(StrNewPasswordCaption);
  lConfirmPasswordLabel.Caption := GetTranslatedString(StrConfirmPasswordCaption);
end;

procedure TfmJSConfirmPasswordDialog.SetActiveControlInError(AControl: TWinControl);
begin
  FActiveControlInError := AControl;
end;

procedure TfmJSConfirmPasswordDialog.SetDialog(JSDialog: TJSCustomEditDialog);
begin
  if not (JSDialog is TJSPasswordDialog) then
    raise EPasswordDialogException.CreateFmt(StrJSPasswordDialogInvalidDialogType, [JSDialog.ClassName, ClassName])
  else
    FDialog := TJSPasswordDialog(JSDialog);
end;

end.
