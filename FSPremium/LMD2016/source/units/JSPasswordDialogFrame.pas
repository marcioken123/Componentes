{ Summary
  This unit contains the custom frame control used in the TJSPasswordDialog implementation. }
unit JSPasswordDialogFrame;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, JSEditDialog, JSEditDialogIntf, JSTypes, JSPasswordDialog;

type
  { Summary
    TFrame descendant used as the custom control on the TJSPasswordDialog class.
    Description
    This is the frame control used in the TJSPasswordDialog to present the user with the interface in
    which to change an existing password.                                                             }
  TfmJSPasswordDialog = class(TFrame, IJSEditDialogControl)
    lNewPasswordLabel: TLabel;
    eNewPassword: TEdit;
  private
    FDialog: TJSPasswordDialog;
    function GetPassword: string;
  protected
    FActiveControlInError: TWinControl;
    { Summary
      Loads the localised text for the frame.
      Description
      The LoadCaptions method is used to load the localised text that is displayed on the frame.
      See Also
      <link Localisation>                                                                        }
    procedure LoadCaptions; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    function ActiveControl: TWinControl;
    function ActiveControlInError: TWinControl;
    procedure AdjustControlLayout(const AWidth: Integer);
    function GetRequiredWidth: Integer;
    procedure SetActiveControlInError(AControl: TWinControl);
    procedure SetDialog(JSDialog: TJSCustomEditDialog);
    function ValidateInput(out Message: TJSString; const ModalResult: TModalResult): Boolean;
    { <copy JSPasswordDialog.TJSCustomPasswordDialog.Password>

      \ \                                                      }
    property Password: string read GetPassword;
  end;

implementation

uses
  JSDialogStrs, Math;

{$R *.dfm}

{ TfmJSConfirmPasswordDialog }

function TfmJSPasswordDialog.ActiveControl: TWinControl;
begin
  result := eNewPassword;
end;

function TfmJSPasswordDialog.ValidateInput(out Message: TJSString; const ModalResult: TModalResult): Boolean;
begin
  FActiveControlInError := nil;
  result := True;
end;

function TfmJSPasswordDialog.ActiveControlInError: TWinControl;
begin
  if FActiveControlInError <> nil then
    result := FActiveControlInError
  else
    result := ActiveControl;
end;

procedure TfmJSPasswordDialog.AdjustControlLayout(const AWidth: Integer);
var
  lAdjustment: Integer;
  lShift: Integer;
  lMargins: Integer;
begin
  if Width <> AWidth then
    Width := AWidth;
  lMargins := 3 * 6; // left margin + label / control margin + right margin
  lAdjustment := Width - (lNewPasswordLabel.Width + lMargins);
  lShift := eNewPassword.Width - lAdjustment;
  eNewPassword.Width := lAdjustment;
  eNewPassword.Left := eNewPassword.Left + lShift;
  lNewPasswordLabel.Left := lNewPasswordLabel.Left + lShift;
end;

constructor TfmJSPasswordDialog.Create(AOwner: TComponent);
begin
  inherited;
  FActiveControlInError := nil;
  LoadCaptions;
end;

function TfmJSPasswordDialog.GetPassword: string;
begin
  Result := eNewPassword.Text;
end;

function TfmJSPasswordDialog.GetRequiredWidth: Integer;
begin
  result := MulDiv(320, Screen.PixelsPerInch, 96);
end;

procedure TfmJSPasswordDialog.LoadCaptions;
begin
  lNewPasswordLabel.Caption := GetTranslatedString(StrEnterPasswordCaption);
end;

procedure TfmJSPasswordDialog.SetActiveControlInError(AControl: TWinControl);
begin
  FActiveControlInError := AControl;
end;

procedure TfmJSPasswordDialog.SetDialog(JSDialog: TJSCustomEditDialog);
begin
  if not (JSDialog is TJSPasswordDialog) then
    raise EPasswordDialogException.CreateFmt(StrJSPasswordDialogInvalidDialogType, [JSDialog.ClassName, ClassName])
  else
    FDialog := TJSPasswordDialog(JSDialog);
end;

end.
