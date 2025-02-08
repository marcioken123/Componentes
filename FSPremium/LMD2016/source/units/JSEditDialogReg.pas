{ Summary
  Unit that registers the TJSEditDialog class. }
unit JSEditDialogReg;

interface

uses
  Classes, JSEditDialog, JSPasswordDialog, JSDualEditDialog;

{ Summary
  Registers the components included in the unit so they appear of the Tool (Component) Palette. }
procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('LMD DialogPack', [TJSEditDialog, TJSPasswordDialog,
    TJSConfirmPasswordDialog, TJSChangePasswordDialog, TJSDualEditDialog]);
end;

end.
