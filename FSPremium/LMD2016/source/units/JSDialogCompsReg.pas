//-----------------------------------------------------------------------------
//   Overview:  This unit contains the TJSCommandLinkButton class used for
//   displaying the Command Link Button control on the dialog.
//-----------------------------------------------------------------------------
unit JSDialogCompsReg;

interface

{ Summary
  Register specific components that are used within JSDialog Pack.
  Description
  The method registers a number of the components used internally by JSDialog Pack for use at design
  time in other applications.                                                                        }
procedure Register;

implementation

uses
  Classes, JSButton, JSLabel, JSRichEdit;

procedure Register;
begin
  RegisterComponents('LMD DialogPack', [TJSCommandLinkButton, TJSMoreLabel,
                                        TJSSymbolButton, TJSRichEdit]);
end;

end.
