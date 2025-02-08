{ Summary
  This unit contains the custom frame control used in the TJSDualEditDialog implementation. }
unit JSDualEditDialogFrame;

interface

{$I lmddlgcmps.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, 
  JSEditDialog, JSEditDialogIntf, JSTypes, JSDualEditDialog;

type
  TfmDualEditDialog = class(TFrame, IJSEditDialogControl)
    Value1Label: TLabel;
    Value2Label: TLabel;
    eValue2: TEdit;
    eValue1: TEdit;
  private
    FDialog: TJSCustomEditDialog;
    function ActiveControl: TWinControl;
    function ActiveControlInError: TWinControl;
    procedure AdjustControlLayout(const AWidth: Integer);
    function GetRequiredWidth: Integer;
    procedure SetActiveControlInError(AControl: TWinControl);
    procedure SetDialog(JSDialog: TJSCustomEditDialog);
    function ValidateInput(out Message: TJSString; const ModalResult: TModalResult): Boolean;
    function GetEdit1: string;
    function GetEdit2: string;
  protected
    FActiveControlInError: TWinControl;
  public
    property Edit1: string read GetEdit1;
    property Edit2: string read GetEdit2;
  end;

implementation

uses
  Math;

{$R *.dfm}

{ TTfmDualEditDialog }

function TfmDualEditDialog.ActiveControl: TWinControl;
begin
  Result := eValue1;
end;

function TfmDualEditDialog.ActiveControlInError: TWinControl;
begin
  if FActiveControlInError <> nil then
    result := FActiveControlInError
  else
    result := ActiveControl;
end;

procedure TfmDualEditDialog.AdjustControlLayout(const AWidth: Integer);
begin

end;

function TfmDualEditDialog.GetEdit1: string;
begin
  Result := eValue1.Text;
end;

function TfmDualEditDialog.GetEdit2: string;
begin
  Result := eValue2.Text;
end;

function TfmDualEditDialog.GetRequiredWidth: Integer;
begin
  Result := MulDiv(320, Screen.PixelsPerInch, 96);
end;

procedure TfmDualEditDialog.SetActiveControlInError(AControl: TWinControl);
begin
  FActiveControlInError := AControl;
end;

procedure TfmDualEditDialog.SetDialog(JSDialog: TJSCustomEditDialog);
var
  LDialog: TJSDualEditDialog;
  LLeftPos: Integer;
begin
  FDialog := JSDialog;
  if FDialog <> nil then
  begin
    if FDialog is TJSDualEditDialog then
    begin
      LDialog := TJSDualEditDialog(FDialog);
      Value1Label.Caption := LDialog.DualEditProperties.Value1Caption;
      Value2Label.Caption := LDialog.DualEditProperties.Value2Caption;
      eValue1.Text := LDialog.DualEditProperties.Value1;
      eValue2.Text := LDialog.DualEditProperties.Value2;
      // The frame is setup for a default caption alignment of right, so if left
      // is selected, then changes to the position of controls is required.
      if LDialog.DualEditProperties.CaptionAlignment = caLeft then
      begin
        Value1Label.Alignment := taLeftJustify;
        Value2Label.Alignment := taLeftJustify;
        LLeftPos := Max(Value1Label.Width, Value2Label.Width);
        Value1Label.Left := MulDiv(3, Screen.PixelsPerInch, 96);
        Value2Label.Left := MulDiv(3, Screen.PixelsPerInch, 96);
        eValue1.Left := Value1Label.Left + LLeftPos + MulDiv(6, Screen.PixelsPerInch, 96);
        eValue2.Left := Value1Label.Left + LLeftPos + MulDiv(6, Screen.PixelsPerInch, 96);
        // Fill the area
        eValue1.Width := Width - MulDiv(3, Screen.PixelsPerInch, 96) - eValue1.Left;
        eValue2.Width := Width - MulDiv(3, Screen.PixelsPerInch, 96) - eValue1.Left;
      end
      else
      begin
        Value1Label.Alignment := taRightJustify;
        Value2Label.Alignment := taRightJustify;
        if Value1Label.Width > Value2Label.Width then
        begin
          Value1Label.Left := MulDiv(3, Screen.PixelsPerInch, 96);
          Value2Label.Left := MulDiv(3, Screen.PixelsPerInch, 96) + (Value1Label.Width - Value2Label.Width);
        end
        else
        begin
          Value1Label.Left := MulDiv(3, Screen.PixelsPerInch, 96) + (Value2Label.Width - Value1Label.Width);
          Value2Label.Left := MulDiv(3, Screen.PixelsPerInch, 96);
        end;
        eValue1.Left := Value1Label.Left + Value1Label.Width + MulDiv(6, Screen.PixelsPerInch, 96);
        eValue2.Left := Value1Label.Left + Value1Label.Width + MulDiv(6, Screen.PixelsPerInch, 96);
        // Fill the area
        eValue1.Width := Width - MulDiv(3, Screen.PixelsPerInch, 96) - eValue1.Left;
        eValue2.Width := Width - MulDiv(3, Screen.PixelsPerInch, 96) - eValue1.Left;
      end;
    end;
  end;
end;

function TfmDualEditDialog.ValidateInput(out Message: TJSString; const ModalResult: TModalResult): Boolean;
begin
  Result := True;
end;

end.
