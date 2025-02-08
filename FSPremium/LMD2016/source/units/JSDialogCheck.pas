{ Summary
  Unit that contains the implementation of the TJSDialogCheck component.
  Description
  The TJSDialogCheck component is a TJSDialog descendant. This dialog is an example of how to customise
  the TJSDialog to suit different requirements.<p />
  <p />
  Instead of showing Radio Buttons, the TJSDialogCheck component displays Check Boxes. The component
  also declares a number of helper functions to return the checked state of a Check Box.                }
unit JSDialogCheck;

interface

{$I lmddlgcmps.inc}

uses
    JSDialog
  , StdCtrls
  , Controls
  , Classes
  ;

type
  { Summary
    Class that replaces radio buttons with check boxes.
    Description
    The TJSDialogCheck component is a TJSDialog descendant class that replaces the standard Radio Buttons
    with Check Boxes. This implementation shows how to customise a TJSDialog descendant to add, replace
    and extend functionality.

    Added methods to this TJSDialog descendant allows the user to determine which check boxes the user
    has checked and react accordingly.                                                                    }
  {$IFDEF DELPHI_XE2}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64{ or pidOSX32})]
  {$ENDIF}
  TJSDialogCheck = class(TJSDialog)
  private
    FCheckResult: array of Boolean;
  protected
    procedure DoCreated; override;
    procedure DoDialogClose(Sender: TObject); override;
    function DoGetRadioButtonChecked(AControl: TControl): Boolean; override;
    procedure InitialiseControl(AControlType: TControlType; AControl: TControl; AControlItem: TCollectionItem); override;
    procedure InitialiseControlClass(AControlType: TControlType; var AControlClass: TControlClass); override;
  public
    constructor Create(AOwner: TComponent); override;
    { Summary
      Returns the Checked state of a specific check box on the dialog.
      Description
      Call the GetCheckResult method to return the checked state for a specific check box. Pass the unique
      ID in the AValue parameter.

      To determine the appropriate ID for the check box control, the first check box control on the dialog
      has a value of 200. Each subsequent check box controls ID increments by 1.                           }
    function GetCheckResult(const aValue: Integer): Boolean;
  published
    property DialogOptions default [doRadioButtons, doModal];
  end;

implementation

{ TJSDialogCheck }

constructor TJSDialogCheck.Create(AOwner: TComponent);
begin
  inherited;
  DialogOptions := [doRadioButtons, doModal];
end;

procedure TJSDialogCheck.DoCreated;
begin
  inherited;
  SetLength(FCheckResult, RadioButtons.Count);
end;

procedure TJSDialogCheck.DoDialogClose(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to RadioButtons.Count - 1 do
    FCheckResult[i] := IsChecked(200 + i);
  inherited;
end;

function TJSDialogCheck.DoGetRadioButtonChecked(AControl: TControl): Boolean;
begin
  result := TCheckBox(AControl).Checked;
end;

function TJSDialogCheck.GetCheckResult(const aValue: Integer): Boolean;
begin
  if ((aValue - 200) >= 0) and (aValue - 200 < RadioButtons.Count) then
    result := FCheckResult[aValue - 200]
  else
    result := False;
end;

procedure TJSDialogCheck.InitialiseControl(AControlType: TControlType; AControl: TControl;
  AControlItem: TCollectionItem);
var
  lRI: TJSRadioButtonItem;
begin
  if AControlType = ctRadioButton then
  begin
    lRI := TJSRadioButtonItem(AControlItem);
    TCheckBox(AControl).Caption := lRI.Caption;
    TCheckBox(AControl).Enabled := lRI.Enabled;
    TCheckBox(AControl).Checked := lRI.Checked;
  end
  else
    inherited;
end;

procedure TJSDialogCheck.InitialiseControlClass(AControlType: TControlType; var AControlClass: TControlClass);
begin
  if AControlType = ctRadioButton then
    AControlClass := TCheckBox
  else
    inherited;
end;

end.
