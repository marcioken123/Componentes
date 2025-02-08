{ Summary
  Components and Component Editors registration unit for TJSCustomDialog descendant components. }
unit JSDialogReg;

interface

{ Summary
  Registers the components included in the unit so they appear of the Tool (Component) Palette. }
procedure Register;

implementation

uses
  {System.}Classes, {Vcl.}Controls, JSDialog, JSDialogCheck, JSDialogSheet;

{$R JSDialogCompIcon.dcr}

procedure Register;
begin
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  RegisterComponents('LMD DialogPack', [TJSDialog]);
  RegisterComponents('LMD DialogPack', [TJSDialogCheck]);
  RegisterComponents('LMD DialogPack', [TJSDialogSheet]);
  GroupDescendentsWith(TJSCustomDialog, {Vcl.Controls.}TControl);
end;

end.
