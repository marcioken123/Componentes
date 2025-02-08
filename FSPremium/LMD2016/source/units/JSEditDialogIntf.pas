{ Summary
  The JSEditDialogIntf contains interface declarations that the TJSEditDialog component recognizes.
  Description
  Interfaces declared in this unit can be implemented by descendant edit controls for greater
  integration when used within a TJSEditDialog.                                                     }
unit JSEditDialogIntf;

interface

{$I lmddlgcmps.inc}

uses
  {$IFDEF DELPHI5}Forms, {$ENDIF}Controls, JSEditDialog, JSTypes;

type
  { Summary
    Interface that custom controls can implement for special handling in TJSEditDialog.
    Description
    Implement this interface in a control to have extra control over the usage of a custom
    control used in a TJSEditDialog. }
  IJSEditDialogControl = interface
    ['{91E6FD85-AE20-4637-A524-5025A236E238}']
    { Summary
      Return the active control for the control.
      Description
      Implement this method to return which control is the active control. This method would be
      most useful if the control implementing the IJSEditDialogControl was a composite control. }
    function ActiveControl: TWinControl;
    { Summary
      Return the active control for the control.
      Description
      Implement this method to return which control is the active control when an error occurs. This method
      would be most useful if the control implementing the IJSEditDialogControl was a composite control.<p />
      <p />
      Call this method when you implement ValidateInput and the input fails for a control that is not the
      default ActiveControl.                                                                                  }
    function ActiveControlInError: TWinControl;
    { Summary
      Method to adjust the layout of the composite control to fit within the width allocated to the control. }
    procedure AdjustControlLayout(const AWidth: Integer);
    { Summary
      Method to set the ActiveControlInError reference to a certain control.
      Description
      Use the ActiveControlInError when validation of the control has failed because of a
      particular sub control. }
    procedure SetActiveControlInError(AControl: TWinControl);
    { Summary
      Return the required width for the composite control that implements the IJSEditDialogControl interface. }
    function GetRequiredWidth: Integer;
    { Summary
      Called to pass a reference of the dialog to the control. }
    procedure SetDialog(JSDialog: TJSCustomEditDialog);
    { Summary
      Called so the control can prevent a dialog from closing.
      Description
      Implement the CanClose method to provide validation on the control.
      If the method returns false then an appropriate error message should be returned in the Message parameter.
      The ModalResult parameter indicates what the result value of the dialog will be so you can perform any
      required validation that might prevent the dialog from being closed. If the user has cancelled the dialog,
      then there is no point in validating the dialogs contents. }
    function ValidateInput(out Message: TJSString; const ModalResult: TModalResult): Boolean;
  end;

implementation

end.
