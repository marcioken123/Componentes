{ Summary
  This unit contains the wrapper classes
  Description
  All of the wrapper classes for created TJSDialog dialogs are
  declared in this unit.                                       }
unit JSDialogs;

interface

{$I lmddlgcmps.inc}

uses
  Controls, Forms, ComCtrls{$IFDEF DELPHI5}, Windows{$ENDIF DELPHI5}, JSTypes;

type
  { Summary
    Type used to indicate which section the message string should be displayed in. }
  TMsgType = (
    mtNone { Display both content and instruction. Do not use this value in your code. },
    mtContent { Display message string in the content section of the dialog. },
    mtInstruction { Display message string in the instruction section of the dialog. }
  );

  { Summary
    Redeclared from the Dialogs.pas unit.
    Description
    This enables the JSDialogs unit to be a drop in replacement for most occurrences of Dialogs.pas. }
  TMsgDlgType = (
    { Summary
      A message box containing a yellow exclamation point symbol.<p /> }
    mtWarning,
    { Summary
      A message box containing a red stop sign. }
    mtError,
    { Summary
      A message box containing a blue "i". }
    mtInformation,
    { Summary
      A message box containing a green question mark.<p /> }
    mtConfirmation,
    { Summary
      A message box containing no bitmap. The caption of the message box is the name of the application's
      executable file.                                                                                    }
    mtCustom
    );

  { Summary
    Redeclared from the dialogs.pas unit.
    Description
    This enables the JSDialogs unit to be a drop in replacement for most occurrences of dialogs.pas. }
  TMsgDlgBtn = (
    { Summary
      A button with 'Yes' on its face. }
    mbYes,
    { Summary
      A button the text 'No' on its face. }
    mbNo,
    { Summary
      A button the text 'OK' on its face. }
    mbOK,
    { Summary
      A button with the text 'Cancel' on its face. }
    mbCancel,
    { Summary
      A button with the text 'Abort' on its face }
    mbAbort,
    { Summary
      A button with the text 'Retry' on its face }
    mbRetry,
    { Summary
      A button the text 'Ignore' on its face }
    mbIgnore,
    { Summary
      A button with the text 'All' on its face }
    mbAll,
    { Summary
      A button with the text 'No to All' on its face }
    mbNoToAll,
    { Summary
      A button with the text 'Yes to All' on its face }
    mbYesToAll,
    { Summary
      A button with the text 'Help' on its face }
    mbHelp,
    { Summary
      A button with the text 'Close' on its face }
    mbClose
  );

  { Summary
    Redeclared from the dialogs.pas unit.
    Description
    This enables the JSDialogs unit to be a drop in replacement for most occurrences of dialogs.pas. }
  TMsgDlgButtons = set of TMsgDlgBtn;

  { Summary
    Used to determine which operating system icon is displayed with the dialog. Set to tdiCustom to specify your own icon. }
  TTaskDialogIcon = (
    tdiNone { No icon is to be displayed. },
    tdiWarning { Display the operating systems warning icon. },
    tdiError { Display the operating systems error icon. },
    tdiInformation { Display the operating systems information icon. },
    tdiConfirmation { Display the operating systems confirmation icon. },
    tdiCustom { Display a user defined icon. Define the icon to use in the Glyph property of TJSDialog. },
    tdiShield { Display the operating systems shield icon. For non Microsoft Windows Vista systems the shield icons are stored in a resource file. }
   );

  { Summary
    Built in button types.
    Description
    Common buttons are buttons that you are most likely to use on
    a dialog. While the list of common buttons is extensive, you
    can still specify custom buttons by using the CustomButtons
    property.

    CustomButtons are displayed as normal buttons on the
    ButtonBar if neither the doCommandLinks or
    doCommandLinksNoIcon options are specified in the
    DialogOptions property. If custom buttons are being used,
    then common buttons are not displayed.                        }
  TCommonButton = (
    cbYes { Display a button with the caption <i>Yes</i> and has a modal result value of <i>mrYes</i>. },
    cbNo { Display a button with the caption <i>No</i> and has a modal result value of <i>mrNo</i>. },
    cbOK { Display a button with the caption <i>OK</i> and has a modal result value of <i>mrOK</i>. },
    cbCancel { Display a button with the caption <i>Cancel</i> and has a modal result value of <i>mrCancel</i>. },
    cbAbort { Display a button with the caption <i>Abort</i> and has a modal result value of <i>mrAbort</i>. },
    cbRetry { Display a button with the caption <i>Retry</i> and has a modal result value of <i>mrRetry</i>. },
    cbIgnore { Display a button with the caption <i>Ignore</i> and has a modal result value of <i>mrIgnore</i>. },
    cbAll { Display a button with the caption <i>All</i> and has a modal result value of <i>mrAll</i>. },
    cbNoToAll { Display a button with the caption <i>No to All</i> and has a modal result value of <i>mrNoToAll</i>. },
    cbYesToAll { Display a button with the caption <i>Yes to All</i> and has a modal result value of <i>mrYesToAll</i>. },
    cbHelp { Display a button with the caption <i>Help</i> and has a modal result value of <i>mrNone</i>. },
    cbClose { Display a button with the caption <i>Close</i> and has a modal result value of <i>mrNone</i>. }
  );

  { Summary
    Set of TCommonButton.
    Description
    Used to define which common buttons are to be displayed on a dialog. }
  TCommonButtons = set of TCommonButton;

  { Summary
    Controls where the dialog is to be displayed. }
  TDialogPosition = (
    dpScreenCenter { Display the dialog in the center of the screen. },
    dpDesktopCenter { Display the dialog in the center of the desktop. },
    dpMainFormCenter { Display the dialog in the center of the applications main form. },
    dpOwnerFormCenter { Display the dialog in the center of the dialogs owner. },
    dpDesigned { Dialog position is set by the caller using the Location method }
  );
  
const
  { Redeclared from the dialogs.pas unit. }
  mbYesNo = [mbYes, mbNo];
  { Redeclared from the dialogs.pas unit. }
  mbYesNoCancel = [mbYes, mbNo, mbCancel];
  { Redeclared from the dialogs.pas unit. }
  mbYesAllNoAllCancel = [mbYes, mbYesToAll, mbNo, mbNoToAll, mbCancel];
  { Redeclared from the dialogs.pas unit. }
  mbOKCancel = [mbOK, mbCancel];
  { Redeclared from the dialogs.pas unit. }
  mbAbortRetryIgnore = [mbAbort, mbRetry, mbIgnore];
  { Redeclared from the dialogs.pas unit. }
  mbAbortIgnore = [mbAbort, mbIgnore];

{ Summary
  Wrapper function for MessageDlg.
  Description
  For these functions to be used you must remove the Dialogs unit from the uses clause of the unit,
  otherwise you need to reference the unit when using the functions.
  Example
  <code lang="delphi">
  Dialogs.MessageDlg('Test', mtInformation, [mbOK], 0);
  JSDialogs.MessageDlg('Test', mtInformation, [mbOK], 0);
  </code>                                                                                           }
function MessageDlg(const Msg: TJSString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer; overload;

{ Summary
  Wrapper function for MessageDlg.
  Description
  For these functions to be used you must remove the Dialogs unit from the uses clause of the unit,
  otherwise you need to reference the unit when using the functions.
  Example
  <code lang="delphi">
  Dialogs.MessageDlg('Test', mtInformation, [mbOK], 0);
  JSDialogs.MessageDlg('Test', mtInformation, [mbOK], 0);
  </code>                                                                                           }
function MessageDlg(const Msg: TJSString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer; overload;

{ Summary
  Wrapper function for MessageDlgPos.
  Description
  Replacement function for the MessageDlgPos function from the Dialogs unit. }
function MessageDlgPos(const Msg: TJSString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer; overload;

{ Summary
  Wrapper function for MessageDlgPos.
  Description
  Replacement function for the MessageDlgPos function from the Dialogs unit. }
function MessageDlgPos(const Msg: TJSString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn): Integer; overload;

{ Summary
  Wrapper function for ShowMessagePos
  Description
  Replacement function for the ShowMessagePos function from the Dialogs unit. }
procedure ShowMessagePos(const Msg: TJSString; X, Y: Integer);

{ Summary
  Wrapper function for ShowMessage Wrapper around the commonly used ShowMessage function. If you
  require the Dialogs unit to be used by a unit, then you need to preface the ShowMessage call with the
  unit name you want referenced.
  Example
  To use the ShowMessage method within the JSDialog unit then you would use it like:
  <code lang="delphi">
  ShowMessage('My Message');
  </code>                                                                                               }
procedure ShowMessage(const Msg: TJSString); overload;
{ <copy JSDialogs.ShowMessage@string>
  
  \ \                                 }
procedure ShowMessage(const Msg: TJSString; AButton: TCommonButton); overload;

{ Summary
  Wrapper function for ShowMessageFmt Wrapper around the commonly used ShowMessageFmt function.
  Example
  To use the ShowMessageFmt method within the JSDialog unit then you would use it like:
  <code lang="delphi">
  JSDialog.ShowMessageFmt('My %d messages are accumulating', [3]);
  </code>
  Description
  If you require the Dialogs unit to be used by a unit, then you need to preface the ShowMessageFmt
  call with the unit name you want referenced.                                                      }
procedure ShowMessageFmt(const Msg: TJSString; Params: array of const);

{ Summary
  Wrapper function for VerifyMessage Creates a dialog with the verification checkbox visible.
  Description
  The verification result is passed through the aVerifyResult parameter.<p />
  Set the aVerifyResult parameter to True to have the checkbox checked when the dialog initially
  displays.
  Also allows the display of the footer section with a specific icon. }
function VerifyMessage(const aInstruction, aMsg: TJSString; const aIcon: TTaskDialogIcon;
  const aButtons: TCommonButtons; const aHelpIdx: Integer; const aVerifyText: TJSString;
  var aVerifyResult: Boolean; const AFooterText: string; AFooterIcon: TTaskDialogIcon): TModalResult; overload;
{ Summary
  Wrapper function for VerifyMessage Creates a dialog with the verification checkbox visible.
  Description
  The verification result is passed through the aVerifyResult parameter.<p />
  Set the aVerifyResult parameter to True to have the checkbox checked when the dialog initially
  displays.                                                                                      }
function VerifyMessage(const aInstruction, aMsg: TJSString; const aIcon: TTaskDialogIcon;
  const aButtons: TCommonButtons; const aHelpIdx: Integer; const aVerifyText: TJSString;
  var aVerifyResult: Boolean): TModalResult; overload;

{ Summary
  Wrapper function for VerifyMessage Creates a dialog with the verification checkbox visible.
  Description
  The verification result is passed through the aVerifyResult parameter.<p />
  Set the aVerifyResult parameter to True to have the checkbox checked when the dialog initially
  displays.
  Example
  <code lang="delphi">
  procedure MainForm.SaveAttachment;
  var
    lAlwaysUnzip: Boolean;
  begin
    if not GuiOptions.AlwaysUnzipAttachments then
    begin
      if VerifyMessage('Do you want to unzip the saved attachment?' tdiConfirmation, [cbYes, cbNo], 0,
        mtInstruction,  'Always unzip attachments', lAlwaysUnzip) = mrOK then
      begin
        GuiOptions.AlwaysUnzipAttachments := lAlwaysUnzip;
        // unzip attachment
      end;
    end;
  end;
  </code>                                                                                              }
function VerifyMessage(const aMsg: TJSString; const aIcon: TTaskDialogIcon;
  const aButtons: TCommonButtons; const aHelpIdx: Integer; const aMsgType: TMsgType; const aVerifyText: TJSString;
  var aVerifyResult: Boolean): TModalResult; overload;

{ Summary
  Wrapper function to display an error message dialog.
  Description
  Displays a dialog with the Error icon visible.
  Example
  <code lang="delphi">
  ShowErrorMessage('You must select an entry to delete');
  </code>                                                 }
procedure ShowErrorMessage(const aMsg: TJSString);

{ Summary
  Wrapper function to display an error message dialog
  Displays a dialog with a Title and the Error icon visible. }
procedure ShowErrorTitleMessage(const aTitle, aMsg: TJSString); overload;

{ Summary
  Display an error dialog with extended exception details.
  Description
  Wrapper method that allows an error message to be displayed. The content of the AException parameter is visible
  when the user selects the "Show Exception" expando button. }
procedure ShowErrorTitleMessageWithError(const ATitle, AMessage, AException: TJSString; const AShowText: TJSString = ''; AHideText: TJSString = '');

{ Summary
  Display an error dialog with extended exception details and a footer.
  Description
  Wrapper method that allows an error message to be displayed. The content of the AException parameter is visible
  when the user selects the "Show Exception" expando button.
  Also displays a footer with the icon specified. }
procedure ShowErrorTitleMessageWithErrorAndFooter(const ATitle, AMessage, AException: TJSString;
  const AFooter: TJSString; const AFooterIcon: TTaskDialogIcon;
  const AShowText: TJSString = ''; AHideText: TJSString = ''; const AAnimate: Boolean = False);

{ Summary
  Wrapper function to display an warning message dialog Displays a dialog with the Warning icon
  visible.
  Description
  Wrapper function to display an warning message dialog Displays a dialog with the Warning icon
  visible. The dialog displays with OK and Cancel buttons.
  Returns
  Result will either be mrYes or mrNo.                                                      }
function ShowWarningMessage(const aMsg: TJSString): TModalResult;

{ Summary
  Wrapper function to display an warning message dialog
  Displays a dialog with a Title and the Warning icon visible.
  Description
  Wrapper function to display an warning message dialog Displays a dialog with the Warning icon
  visible. The dialog displays with OK and Cancel buttons.
  Returns
  Result will either be mrYes or mrNo.                                                      }
function ShowWarningTitleMessage(const aTitle, aMsg: TJSString): TModalResult;

{ Summary
  Wrapper function to display an confirmation message dialog.
  Description
  Displays a dialog with the Confirmation icon visible.<p />
  <p />
  Has OK and Cancel buttons visible. Function result will either be mrOK or mrCancel.
  Example
  <code lang="delphi">
  if ShowConfirmMessage('Are you sure you want to exit the application?') = mrOK then
    close;
  </code>                                                                              }
function ShowConfirmMessage(const aMsg: TJSString; const AConfirm: TMsgDlgBtn = mbOK; const ACancel: TMsgDlgBtn = mbCancel): TModalResult;

{ Summary
  Wrapper function to display an confirmation message dialog
  Displays a dialog with a Title and the Confirmation icon visible.
  Description
  Displays a dialog with the Confirmation icon visible.<p />
  <p />
  By default a confirmation dialog has OK and Cancel buttons visible. When this is the case, the result will either be mrOK or mrCancel.
  If you change the default buttons by including different TMsgBtn values for either the AConfirm or ACancel parameters, then the
  result will be the modalresult equivalent of the button value.

  If you pass mbYes and mbNo as AConfirm and ACancel parameters, then the result value will be either mrYes or mrNo.

  Example
  <code lang="delphi">
  if ShowConfirmTitleMessage('Close Application', 'Are you sure you want to exit the application?', mbYes, mbNo) = mrOK then
    close;
  </code>                                                                              }
function ShowConfirmTitleMessage(const aTitle, aMsg: TJSString; const AConfirm: TMsgDlgBtn = mbOK; const ACancel: TMsgDlgBtn = mbCancel): TModalResult;

{ Summary
  Wrapper function to display an information message dialog.
  Description
  Displays a dialog with the Information icon visible.
  Example
  <code lang="delphi">
  ShowInfoMessage('This is an information message');
  </code>                                                    }
procedure ShowInfoMessage(const aMsg: TJSString); overload;

{ Summary
  Wrapper function to display an information message dialog that will automatically close once the ATimeOut value has been reached.
  Description
  Displays a dialog with the Information icon visible that will automatically time out.
  Example
  <code lang="delphi">
  ShowInfoMessage('This is Information', 'This is an informative message that will close about 3 seconds', 3000);
  </code>                                                    }
procedure ShowTimedInfoMessage(const AInstruction, AMessage: string; const ATimeOut: Integer;
  const AShowCountdown: Boolean = False; const ACountdownText: string = '');

{ Summary
  Wrapper function to display an information message dialog.
  Description
  Displays a dialog with a Title and the Information icon visible. }
procedure ShowInfoTitleMessage(const aTitle, aMsg: TJSString); overload;

{ Summary
  Wrapper function to display an information message dialog.
  Description
  Displays a dialog with the Information icon visible. The button visible is determined by the aButton
  parameter.                                                                                           }
procedure ShowInfoMessage(const aMsg: TJSString; aButton: TCommonButton); overload;

{ Summary
  Method that converts icon values.
  Description
  This method converts the different icon values for the MessageDialog API and the TaskDialog API. }
procedure ConvertIconValue(const MDtoTD: Boolean; var aMD, aTD: Integer);

{ Summary
  Wrapper function to display a dialog that can be expanded to display further details.
  Description
  Use this dialog to display a dialog that allows the user to see more details.<p />
  Set the aExpanded parameter to True to have the dialog automatically expanded when initially
  displayed. Set the aShowInFooter parameter to True to display the additional content in the dialogs
  footer section, otherwise the additional content will display under the dialogs normal content.     }
function ShowExpandableMessage(aOwner: TWinControl; const aTitle, aInstruction, aContent, aExpandedContent, aExpandText,
  aCollapseText: TJSString; aIcon: TTaskDialogIcon; aButtons: TCommonButtons; aHelpIdx: Integer; const aShowInFooter,
  aExpanded: Boolean): TModalResult; overload;

{ <copy JSDialogs.ShowExpandableMessage@TWinControl@string@string@string@string@string@string@TTaskDialogIcon@TCommonButtons@Integer@Boolean@Boolean>
  
  }
function ShowExpandableMessage(const aTitle, aInstruction, aContent, aExpandedContent, aExpandText,
  aCollapseText: TJSString; aIcon: TTaskDialogIcon; aButtons: TCommonButtons; aHelpIdx: Integer; const aShowInFooter,
  aExpanded: Boolean): TModalResult; overload;
  
const
  { Summary
    Value to specify to have no icon displayed in the dialog.
    Description
    Use this value when calling a Task Dialog specific method and you do not want an icon to be shown. }
  TD_ICON_BLANK = 0;
  { Summary
    Value to specify to have an Warning icon displayed on the dialog.
    Description
    Use this value when calling a Task Dialog specific method and you want an Warning icon to be shown. }
  TD_ICON_WARNING = 84;
  { Summary
    Value to specify to have an Question icon displayed on the dialog.
    Description
    Use this value when calling a Task Dialog specific method and you want an Question icon to be shown. }
  TD_ICON_QUESTION = 99;
  { Summary
    Value to specify to have an Error icon displayed on the dialog.
    Description
    Use this value when calling a Task Dialog specific method and you want an Error icon to be shown. }
  TD_ICON_ERROR = 98;
  { Summary
    Value to specify to have an Information icon displayed on the dialog.
    Description
    Use this value when calling a Task Dialog specific method and you want an Information icon to be
    shown.                                                                                           }
  TD_ICON_INFORMATION = 81;
  { Summary
    Value to specify to have an Shield Question icon displayed on the dialog.
    Description
    Use this value when calling a Task Dialog specific method and you want an Shield Question icon to be
    shown.                                                                                               }
  TD_ICON_SHIELD_QUESTION = 104;
  { Summary
    Value to specify to have an Shield Error icon displayed on the dialog.
    Description
    Use this value when calling a Task Dialog specific method and you want an Shield Error icon to be
    shown.                                                                                            }
  TD_ICON_SHIELD_ERROR = 105;
  { Summary
    Value to specify to have an Shield OK icon displayed on the dialog.
    Description
    Use this value when calling a Task Dialog specific method and you want an Shield OK icon to be shown. }
  TD_ICON_SHIELD_OK = 106;
  { Summary
    Value to specify to have an Shield Warning icon displayed on the dialog.
    Description
    Use this value when calling a Task Dialog specific method and you want an Shield Warning icon to be
    shown.                                                                                              }
  TD_ICON_SHIELD_WARNING = 107;

  { Summary
    Resource value of the Warning icon.
    Description
    Resource value of the Warning icon. }
  MD_ICON_WARNING = 101;
  { Summary
    Resource value of the Question icon.
    Description
    Resource value of the Question icon. }
  MD_ICON_QUESTION = 102;
  { Summary
    Resource value of the Error icon.
    Description
    Resource value of the Error icon. }
  MD_ICON_ERROR = 103;
  { Summary
    Resource value of the Information icon.
    Description
    Resource value of the Information icon. }
  MD_ICON_INFORMATION = 104;
  { Summary
    Resource value of the Shield icon.
    Description
    Resource value of the Shield icon. }
  MD_ICON_SHIELD = 106;

  { Summary
    Value to specify an OK button when calling a TaskDialog method.
    Description
    Value to specify an OK button when calling a TaskDialog method. }
  TD_BUTTON_OK = 1;
  { Summary
    Value to specify an Yes button when calling a TaskDialog method.
    Description
    Value to specify an Yes button when calling a TaskDialog method. }
  TD_BUTTON_YES = 2;
  { Summary
    Value to specify an No button when calling a TaskDialog method.
    Description
    Value to specify an No button when calling a TaskDialog method. }
  TD_BUTTON_NO = 4;
  { Summary
    Value to specify an Cancel button when calling a TaskDialog method.
    Description
    Value to specify an Cancel button when calling a TaskDialog method. }
  TD_BUTTON_CANCEL = 8;
  { Summary
    Value to specify an Retry button when calling a TaskDialog method.
    Description
    Value to specify an Retry button when calling a TaskDialog method. }
  TD_BUTTON_RETRY = 16;
  { Summary
    Value to specify an Close button when calling a TaskDialog method.
    Description
    Value to specify an Close button when calling a TaskDialog method. }
  TD_BUTTON_CLOSE = 32;

  { Summary
    Value returned when the OK button of the dialog has been clicked.
    Description
    Value returned when the OK button of the dialog has been clicked. }
  TD_RESULT_OK = 1;
  { Summary
    Value returned when the Cancel button of the dialog has been clicked.
    Description
    Value returned when the Cancel button of the dialog has been clicked.... }
  TD_RESULT_CANCEL = 2;
  { Summary
    Value returned when the Retry button of the dialog has been clicked.
    Description
    Value returned when the Retry button of the dialog has been clicked. }
  TD_RESULT_RETRY = 4;
  { Summary
    Value returned when the Yes button of the dialog has been clicked.
    Description
    Value returned when the Yes button of the dialog has been clicked. }
  TD_RESULT_YES = 6;
  { Summary
    Value returned when the No button of the dialog has been clicked.
    Description
    Value returned when the No button of the dialog has been clicked. }
  TD_RESULT_NO = 7;
  { Summary
    Value returned when the Close button of the dialog has been clicked.
    Description
    Value returned when the Close button of the dialog has been clicked. }
  TD_RESULT_CLOSE = 8;


{ Summary
  Wrapper function to display a TaskDialog.
  Description
  Create a dialog that displays like the real TaskDialog on a supported operating system. If the
  operating system does not support the TaskDialog API, then the TaskDialogEmulated function is called. }
function TaskDialog(aOwner: THandle; const aTitle, aMainInstruction, aContent: TJSString;
  aIcon, aButtons: Integer): Integer; overload;

{ Summary
  Wrapper function to display a TaskDialog.
  Description
  Create a dialog that displays like the real TaskDialog on a supported operating system. If the
  operating system does not support the TaskDialog API, then the TaskDialogEmulated function is called. }
function TaskDialog(aOwner: THandle; const aTitle, aMainInstruction, aContent: TJSString;
  aIcon, aButtons, aDefault: Integer): Integer; overload;

{ Summary
  Wrapper function to display a TaskDialog with specific TCustomButtons.
  Create a dialog that displays like the real TaskDialog on a supported operating
  system. If the operating system does not support the TaskDialog API, then the
  TaskDialogEmulated function is called. }
function TaskDialogEx(aOwner: TWinControl; const aTitle, aMainInstruction, aContent: TJSString;
  aIcon: Integer; aButtons: TCommonButtons): Integer;

var
  { Summary
    Global variable that controls the default position of dialogs.
    Default screen position for dialogs created from wrapper functions }
  JSDialogDefaultDialogPosition: TDialogPosition;
  { Summary
    Global variable that controls whether emulated dialogs are always used.
    Variable that forces Vista to always use JSDialog instead of the native TaskDialog }
  JSDialogAlwaysUseJSDialog: Boolean;
  { Summary
    Global variable that controls whether dialogs created using the wrapper functions
    are displayed Top Most in the application.

    This option can help when starting an application and you have a StayOnTop splash screen and
    an error is raised during your applications initialization. }
  JSDialogForceWrapperDialogsOnTop: Boolean;
  { Summary
    Global variable used to determine if system sounds are played when a dialog is shown.
    Description
    This variable only applies when using wrapper functions from the JSDialogs unit. The TJSDialog
    component has its own PlaySounds property which can be set to False to stop playing system
    sounds when a dialog is shown.
    Remarks
    The default value is True. }
  JSDialogPlaySounds: Boolean;

implementation

uses
  Consts{$IFNDEF DELPHI5}, Windows{$ENDIF DELPHI5}, Graphics, SysUtils, Classes{$IFDEF THEMES}, Themes{$ENDIF THEMES},
  Contnrs, JSDialog, JSDialogStrs;

function GetJSDialogClass: TJSDialogClass;{$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  result := JSDialogClass;
  if result = nil then
    result := TJSDialog;
end;

procedure ConvertIconValue(const MDtoTD: Boolean; var aMD, aTD: Integer);
begin
  if MDtoTD then
  begin
    case aMD of
      MD_ICON_WARNING: aTD := TD_ICON_WARNING;
      MD_ICON_QUESTION: aTD := TD_ICON_QUESTION;
      MD_ICON_ERROR: aTD := TD_ICON_ERROR;
      MD_ICON_INFORMATION: aTD := TD_ICON_INFORMATION;
      MD_ICON_SHIELD: aTD := TD_ICON_SHIELD_OK;
    else
      aTD := TD_ICON_BLANK;
    end;
  end
  else
  begin
    case aTD of
      TD_ICON_BLANK: aMD := 0;
      TD_ICON_WARNING: aMD := MD_ICON_WARNING;
      TD_ICON_QUESTION: aMD := MD_ICON_QUESTION;
      TD_ICON_ERROR: aMD := MD_ICON_ERROR;
      TD_ICON_INFORMATION: aMD := MD_ICON_INFORMATION;
      TD_ICON_SHIELD_QUESTION: aMD := 0;
      TD_ICON_SHIELD_ERROR: aMD := MD_ICON_ERROR;
      TD_ICON_SHIELD_OK: aMD := 0;
      TD_ICON_SHIELD_WARNING: aMD := 0;
    end;
  end;
end;

function FindDialogOwnerHandle: THandle;{$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  if Screen.ActiveForm <> nil then
    result := Screen.ActiveForm.Handle
  else if Application.MainForm <> nil then
    result := Application.MainForm.Handle
  else
    result := Application.Handle;
end;

function DlgTypeToTaskDialogIcon(const aDlgType: TMsgDlgType): Integer;{$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  case aDlgType of
    mtWarning: result := TD_ICON_WARNING;
    mtError: result := TD_ICON_ERROR;
    mtInformation: result := TD_ICON_INFORMATION;
    mtConfirmation: result := TD_ICON_QUESTION;
  else
    result := 0;
  end;
end;

function TDIconToIcon(const aIcon: Integer): TTaskDialogIcon;{$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  case aIcon of
    TD_ICON_BLANK: result := tdiNone;
    TD_ICON_WARNING: result := tdiWarning;
    TD_ICON_QUESTION: result := tdiConfirmation;
    TD_ICON_ERROR: result := tdiError;
    TD_ICON_INFORMATION: result := tdiInformation;
    TD_ICON_SHIELD_OK: result := tdiShield;
  else
    result := tdiCustom;
  end;
end;

function TDResultToResult(const aButton: Integer): TModalResult;{$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  result := mrNone;
  case aButton of
    TD_RESULT_OK: result := mrOK;
    TD_RESULT_YES: result := mrYes;
    TD_RESULT_NO: result := mrNo;
    TD_RESULT_CANCEL: result := mrCancel;
    TD_RESULT_RETRY: result := mrRetry;
    TD_RESULT_CLOSE: result := mrOK;
  end;
end;

function GetDialogMainIcon(const ADlgType: TMsgDlgType): TTaskDialogIcon;{$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  case ADlgType of
    mtWarning: result := tdiWarning;
    mtError: result := tdiError;
    mtInformation: result := tdiInformation;
    mtConfirmation: result := tdiConfirmation;
    mtCustom: result := tdiCustom;
  else
    result := tdiNone;
  end;
end;

function GetDialogTitle(const ADlgType: TMsgDlgType): string; overload; {$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  case ADlgType of
    mtWarning: result := GetTranslatedString(StrWarning);
    mtError: result := GetTranslatedString(StrError);
    mtInformation: result := GetTranslatedString(StrInformation);
    mtConfirmation: result := GetTranslatedString(StrConfirmation);
  else
    result := ExtractFileName(ParamStr(0));
  end;
end;

function GetDialogTitle(const ATaskIcon: TTaskDialogIcon): string; overload; {$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  case ATaskIcon of
    tdiNone: result := '';
    tdiWarning: result := GetTranslatedString(StrWarning);
    tdiError: result := GetTranslatedString(StrError);
    tdiInformation: result := GetTranslatedString(StrInformation);
    tdiConfirmation: result := GetTranslatedString(StrConfirmation);
    tdiCustom: result := '';
    tdiShield: result := GetTranslatedString(StrWarning);
  end;
end;

function MsgDlgButtonsToTaskDialogButtons(AButtons: TMsgDlgButtons): Integer;{$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  result := 0;
  if mbOK in AButtons then
    result := result + TD_BUTTON_OK;
  if mbNo in AButtons then
    result := result + TD_BUTTON_NO;
  if mbYes in AButtons then
    result := result + TD_BUTTON_YES;
  if mbCancel in AButtons then
    result := result + TD_BUTTON_CANCEL;
  if mbRetry in AButtons then
    result := result + TD_BUTTON_RETRY;
end;

function CommonButtonToTaskDialogButton(AButton: TCommonButton): Integer;{$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  case AButton of
    cbYes: result := TD_BUTTON_YES;
    cbNo: result := TD_BUTTON_NO;
    cbOK: result := TD_BUTTON_OK;
    cbCancel: result := TD_BUTTON_CANCEL;
    cbRetry: result := TD_BUTTON_RETRY;
    cbClose: result := TD_BUTTON_CLOSE;
  else
    result := 0;
  end;
end;

{ Method used internally when the TaskDialog function is called and the application
  is not running on an operating system that supports the TaskDialog API. }
function TaskDialogEmulated(aOwnerHandle: THandle; const aTitle, aMainInstruction, aContent: TJSString;
  Icon, Buttons, Default: Integer): Integer; overload;
var
  LDlg: TJSDialog;
  LButtons: TCommonButtons;
  LCtrl: TControl;
  LOwner: TComponent;
begin
  LCtrl := FindControl(aOwnerHandle);
  if (LCtrl <> nil) and (LCtrl is TCustomForm) then
    LOwner := LCtrl
  else
    LOwner := nil;
  LDlg := GetJSDialogClass.Create(LOwner);
  try
    LDlg.Title := aTitle;
    LDlg.Instruction.Text := aMainInstruction;
    LDlg.Content.Text := aContent;
    LButtons := [];
    if Buttons and TD_BUTTON_OK = TD_BUTTON_OK then
      Include(LButtons, cbOK);
    if Buttons and TD_BUTTON_YES = TD_BUTTON_YES then
      Include(LButtons, cbYes);
    if Buttons and TD_BUTTON_NO = TD_BUTTON_NO then
      Include(LButtons, cbNo);
    if Buttons and TD_BUTTON_CANCEL = TD_BUTTON_CANCEL then
      Include(LButtons, cbCancel);
    if Buttons and TD_BUTTON_RETRY = TD_BUTTON_RETRY then
      Include(LButtons, cbRetry);
    if Buttons and TD_BUTTON_CLOSE = TD_BUTTON_CLOSE then
      Include(LButtons, cbClose);
    LDlg.ButtonBar.Buttons := LButtons;
    // need to figure out the default and cancel buttons
    if Default = 0 then
    begin
      if cbOk in LDlg.ButtonBar.Buttons then
        LDlg.ButtonBar.Default := cbOk
      else if cbYes in LDlg.ButtonBar.Buttons then
        LDlg.ButtonBar.Default := cbYes
      else if cbRetry in LDlg.ButtonBar.Buttons then
        LDlg.ButtonBar.Default := cbRetry
      else if cbClose in LDlg.ButtonBar.Buttons then
        LDlg.ButtonBar.Default := cbClose;
    end
    else
    begin
      case Default of
        TD_BUTTON_OK: LDlg.ButtonBar.Default := cbOK;
        TD_BUTTON_YES: LDlg.ButtonBar.Default := cbYes;
        TD_BUTTON_NO: LDlg.ButtonBar.Default := cbNo;
        TD_BUTTON_CANCEL: LDlg.ButtonBar.Default := cbCancel;
        TD_BUTTON_RETRY: LDlg.ButtonBar.Default := cbRetry;
        TD_BUTTON_CLOSE: LDlg.ButtonBar.Default := cbClose;
      end;
    end;
    LDlg.AllowCancel := (cbCancel in LDlg.ButtonBar.Buttons);
    if LDlg.AllowCancel then
      LDlg.ButtonBar.Cancel := cbCancel;
    LDlg.MainIcon := TDIconToIcon(Icon);
    if JSDialogForceWrapperDialogsOnTop then
      LDlg.DialogOptions := LDlg.DialogOptions + [doTopMost];
    LDlg.Position := JSDialogDefaultDialogPosition;
    LDlg.PlaySounds := JSDialogPlaySounds;
    Result := LDlg.Execute;
  finally
    LDlg.Free;
  end;
end;

function TaskDialogEmulated(aOwnerHandle: THandle; const aTitle, aMainInstruction, aContent: TJSString;
  Icon, Buttons: Integer): Integer; overload;
begin
  result := TaskDialogEmulated(aOwnerHandle, aTitle, aMainInstruction, aContent, Icon, Buttons, 0);
end;

type
  TTaskDialogProc = function(hWndParent: THandle; _HInstance: THandle; pszWindowTitle,
    pszMainInstruction, pszContent: PWideChar; Buttons: Integer; Icon: PWideChar;
    ResButton: PInteger): Integer; stdcall;

const
  { Summary
    Name of the method that invokes the native task dialog.
    Description                                             }
  TaskDialogFunc = 'TaskDialog';
  { Summary
    Name of the method that invokes the native Task Dialog.
    Description
    This is the more advanced method that includes many other options for setting up the dialog when
    invoked.                                                                                         }
  TaskDialogIndirectFunc = 'TaskDialogIndirect';

var
  FTaskDialogProc: TTaskDialogProc;
  FUnloadLib: Boolean; // do we need to unload comctl32 (probably never)
  FLibHandle: THandle;
  // everytime TaskDialog loads, it also loads XMLLite. Save the OS the trouble
  // and load this DLL when TaskDialog is first loaded also. This makes calls to
  // TaskDialog more efficient
  FXmlLiteHandle: THandle;

procedure LoadTaskDialogProc;
var
  lModHandle: THandle;
begin
  lModHandle := GetModuleHandle(comctl32);
  FUnloadLib := lModHandle = 0;
  if FUnloadLib then
  begin
    FLibHandle := LoadLibrary(comctl32);
    if FLibHandle >= 32 then
    begin
      @FTaskDialogProc := GetProcAddress(FLibHandle, TaskDialogFunc);
      if not Assigned(FTaskDialogProc) then
        raise Exception.Create('Failed to load TaskDialog function');
    end
    else
      FUnloadLib := False;
  end
  else
    @FTaskDialogProc := GetProcAddress(lModHandle, TaskDialogFunc);
  if FXmlLiteHandle = 0 then
    FXmlLiteHandle := LoadLibrary('xmllite.dll');
end;

{ Method used internally when the MessageBox function is called and the application
  is running on an operating system that supports the TaskDialog API. }
function VistaTaskDialog(const Msg: TJSString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
var
  lTDResult: Integer;
  lTitle: array[0..1024] of WideChar;
  lContent: array[0..1024] of WideChar;
begin
  result := mrNone;
  if @FTaskDialogProc = nil then
    LoadTaskDialogProc;
  if @FTaskDialogProc <> nil then
  begin
    StringToWideChar(GetDialogTitle(DlgType), lTitle, SizeOf(lTitle));
    StringToWideChar(Msg, lContent, SizeOf(lContent));
    FTaskDialogProc(FindDialogOwnerHandle, 0, lTitle, '', lContent,
      MsgDlgButtonsToTaskDialogButtons(Buttons),
      PWideChar(MakeIntResource(DlgTypeToTaskDialogIcon(DlgType))), @lTDResult);
    result := TDResultToResult(lTDResult);
  end;
end;

function TaskDialog(aOwner: THandle; const aTitle, aMainInstruction, aContent: TJSString;
  aIcon, aButtons: Integer): Integer;
begin
  result := TaskDialog(aOwner, aTitle, aMainInstruction, aContent, aIcon, aButtons, 0);
end;

function TaskDialog(aOwner: THandle; const aTitle, aMainInstruction, aContent: TJSString;
  aIcon, aButtons, aDefault: Integer): Integer;
var
  lTDResult: Integer;
  lTitle: array[0..1024] of WideChar;
  lMainInstruction: array[0..1024] of WideChar;
  lContent: array[0..1024] of WideChar;
begin
  if IsVista and not JSDialogAlwaysUseJSDialog
    {$IFDEF THEMES}
    and {$IFNDEF DELPHIXE2}ThemeServices.ThemesEnabled{$ELSE}StyleServices.Enabled{$ENDIF}
    {$ENDIF THEMES}
    and (aButtons <> 0) then
  begin
    result := mrNone;
    if @FTaskDialogProc = nil then
      LoadTaskDialogProc;
    if @FTaskDialogProc <> nil then
    begin
      StringToWideChar(aTitle, lTitle, SizeOf(lTitle));
      StringToWideChar(aMainInstruction, lMainInstruction, SizeOf(lMainInstruction));
      StringToWideChar(aContent, lContent, SizeOf(lContent));
      FTaskDialogProc(aOwner, 0, lTitle, lMainInstruction, lContent,
        aButtons, PWideChar(MakeIntResource(aIcon)), @lTDResult);
      result := TDResultToResult(lTDResult);
    end;
  end
  else
  begin
    result := TaskDialogEmulated(aOwner, aTitle, aMainInstruction, aContent,
      aIcon, aButtons, aDefault);
  end;
end;

function TaskDialogEx(aOwner: TWinControl; const aTitle, aMainInstruction, aContent: TJSString;
  aIcon: Integer; aButtons: TCommonButtons): Integer;
var
  lDlg: TJSDialog;
begin
  lDlg := GetJSDialogClass.Create(aOwner);
  try
    lDlg.Title := aTitle;
    lDlg.Instruction.Text := aMainInstruction;
    lDlg.Content.Text := aContent;
    lDlg.ButtonBar.Buttons := aButtons;
    lDlg.AllowCancel := (cbCancel in lDlg.ButtonBar.Buttons);
    lDlg.MainIcon := TDIconToIcon(aIcon);
    if JSDialogForceWrapperDialogsOnTop then
      lDlg.DialogOptions := lDlg.DialogOptions + [doTopMost];
    lDlg.PlaySounds := JSDialogPlaySounds;
    result := lDlg.Execute;
  finally
    lDlg.Free;
  end;
end;

function CanUseTaskDialog(ABtns: TMsgDlgButtons): Boolean; {$IFDEF INLINE}inline;{$ENDIF INLINE}
var
  lBtn: TMsgDlgBtn;
begin
  result := False;
  for lBtn := low(TMsgDlgBtn) to high(TMsgDlgBtn) do
  begin
    if TMsgDlgBtn(lBtn) in ABtns then
    begin
      if not (lBtn in [mbOK, mbYes, mbNo, mbCancel, mbRetry, mbClose]) then
        exit;
    end;
  end;

  result := True;
end;

{$IFDEF BDS}
{$REGION 'Wrapper Functions'}
{$ENDIF BDS}
function MessageDlg(const Msg: TJSString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint; DefaultButton: TMsgDlgBtn): Integer; overload;
var
  lDlg: TJSDialog;
  i: TMsgDlgBtn;
begin
  if IsVista and not JSDialogAlwaysUseJSDialog and CanUseTaskDialog(Buttons)
    {$IFDEF THEMES}
    and {$IFNDEF DELPHIXE2}ThemeServices.ThemesEnabled{$ELSE}StyleServices.Enabled{$ENDIF}
    {$ENDIF THEMES} then
    result := VistaTaskDialog(Msg, DlgType, Buttons, HelpCtx)
  else
  begin
    lDlg := GetJSDialogClass.Create(nil);
    lDlg.Font.Charset := DefFontData.Charset;
    try
      lDlg.Content.Text := Msg;
      lDlg.Title := GetDialogTitle(DlgType);
      lDlg.MainIcon := GetDialogMainIcon(DlgType);
      lDlg.ButtonBar.Buttons := [];
      for i := low(TMsgDlgBtn) to high(TMsgDlgBtn) do
      begin
        if i in Buttons then
          lDlg.ButtonBar.Buttons := lDlg.ButtonBar.Buttons + [TCommonButton(ord(i))];
      end;

      if lDlg.ButtonBar.UseDefault then
        lDlg.ButtonBar.Default := TCommonButton(ord(DefaultButton));
      if lDlg.ButtonBar.UseCancel then
      begin
        if mbCancel in Buttons then
          lDlg.ButtonBar.Cancel := cbCancel
        else if mbNo in Buttons then
          lDlg.ButtonBar.Cancel := cbNo
        else
          lDlg.ButtonBar.Cancel := cbOk;
      end;
      lDlg.HelpContext := HelpCtx;
      lDlg.Position := JSDialogDefaultDialogPosition;
      if UseOldDialogStyle then
      begin
        lDlg.ButtonBar.ShowDivider := False;
        lDlg.Color := clBtnFace;
        lDlg.ButtonBar.Color := clBtnFace;
        lDlg.UseDefaultFonts := False;
        lDlg.Font.Height := DefFontData.Height;
        {$IFDEF DELPHI2009}
        {$WARN EXPLICIT_STRING_CAST OFF}
        {$ENDIF DELPHI2009}
        lDlg.Font.Name := string(DefFontData.Name);
        {$IFDEF DELPHI2009}
        {$WARN EXPLICIT_STRING_CAST ON}
        {$ENDIF DELPHI2009}
        lDlg.Font.Style := DefFontData.Style;
        lDlg.Font.Charset := DefFontData.Charset;
      end;
      lDlg.EmulateMessageDlg := UseOldDialogStyle;
      if JSDialogForceWrapperDialogsOnTop then
        lDlg.DialogOptions := lDlg.DialogOptions + [doTopMost];
      lDlg.PlaySounds := JSDialogPlaySounds;
      result := lDlg.Execute;
    finally
      lDlg.Free;
    end;
  end;
end;

function MessageDlg(const Msg: TJSString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer; overload;
var
  lDefault: TMsgDlgBtn;
begin
  if mbOk in Buttons then
    lDefault := mbOk
  else if mbYes in Buttons then
    lDefault := mbYes
  else
    lDefault := mbRetry;
  result := MessageDlg(Msg, DlgType, Buttons, HelpCtx, lDefault);
end;

function MessageDlgPos(const Msg: TJSString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer): Integer; overload;
var
  lDefault: TMsgDlgBtn;
begin
  if mbOk in Buttons then
    lDefault := mbOk
  else if mbYes in Buttons then
    lDefault := mbYes
  else
    lDefault := mbRetry;
  result := MessageDlgPos(Msg, DlgType, Buttons, HelpCtx, X, Y, lDefault);
end;

function MessageDlgPos(const Msg: TJSString; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  DefaultButton: TMsgDlgBtn): Integer; overload;
var
  lDlg: TJSDialog;
  i: TMsgDlgBtn;
begin
  lDlg := GetJSDialogClass.Create(nil);
  try
    lDlg.Content.Text := Msg;
    case DlgType of
      mtWarning:
        begin
          lDlg.MainIcon := tdiWarning;
          lDlg.Title := GetTranslatedString(SMsgDlgWarning);
        end;
      mtError:
        begin
          lDlg.MainIcon := tdiError;
          lDlg.Title := GetTranslatedString(SMsgDlgError);
        end;
      mtInformation:
        begin
          lDlg.MainIcon := tdiInformation;
          lDlg.Title := GetTranslatedString(SMsgDlgInformation);
        end;
      mtConfirmation:
        begin
          lDlg.MainIcon := tdiConfirmation;
          lDlg.Title := GetTranslatedString(SMsgDlgConfirm);
        end;
      mtCustom:
        begin
          lDlg.MainIcon := tdiCustom;
          lDlg.Title := ExtractFileName(ParamStr(0));
        end;
    end;
    lDlg.ButtonBar.Buttons := [];
    for i := low(TMsgDlgBtn) to high(TMsgDlgBtn) do
    begin
      if i in Buttons then
        lDlg.ButtonBar.Buttons := lDlg.ButtonBar.Buttons + [TCommonButton(ord(i))];
    end;

    if lDlg.ButtonBar.UseDefault then
      lDlg.ButtonBar.Default := TCommonButton(ord(DefaultButton));
    if lDlg.ButtonBar.UseCancel then
    begin
      if mbCancel in Buttons then
        lDlg.ButtonBar.Cancel := cbCancel
      else if mbNo in Buttons then
        lDlg.ButtonBar.Cancel := cbNo
      else
        lDlg.ButtonBar.Cancel := cbOk;
    end;
    lDlg.HelpContext := HelpCtx;
    if (X or Y) <> -1 then
    begin
      lDlg.Position := dpDesigned;
      lDlg.Location.Left := X;
      lDlg.Location.Top := Y;
    end
    else
      lDlg.Position := JSDialogDefaultDialogPosition;
    if UseOldDialogStyle then
    begin
      lDlg.ButtonBar.ShowDivider := False;
      lDlg.Color := clBtnFace;
      lDlg.ButtonBar.Color := clBtnFace;
      lDlg.Font.Height := DefFontData.Height;
      {$IFDEF DELPHI2009}
      {$WARN EXPLICIT_STRING_CAST OFF}
      {$ENDIF DELPHI2009}
      lDlg.Font.Name := string(DefFontData.Name);
      {$IFDEF DELPHI2009}
      {$WARN EXPLICIT_STRING_CAST ON}
      {$ENDIF DELPHI2009}
      lDlg.Font.Style := DefFontData.Style;
      lDlg.Font.Charset := DefFontData.Charset;
    end;
    lDlg.EmulateMessageDlg := UseOldDialogStyle;
    if JSDialogForceWrapperDialogsOnTop then
      lDlg.DialogOptions := lDlg.DialogOptions + [doTopMost];
    lDlg.PlaySounds := JSDialogPlaySounds;
    result := lDlg.Execute;
  finally
    lDlg.Free;
  end;
end;

procedure ShowMessagePos(const Msg: TJSString; X, Y: Integer);
begin
  MessageDlgPos(Msg, mtCustom, [mbOK], 0, X, Y);
end;

procedure ShowMessage(const Msg: TJSString);
begin
  ShowMessagePos(Msg, -1, -1);
end;

function ActiveFormHandle: HWND;{$IFDEF INLINE}inline;{$ENDIF INLINE}
begin
  {$IFDEF BDS}
  result := Application.ActiveFormHandle;
  {$ELSE}
  result := GetActiveWindow;
  if result = 0 then
    result := GetLastActivePopup(Application.Handle);
  {$ENDIF BDS}
end;

procedure ShowMessage(const Msg: TJSString; AButton: TCommonButton);
begin
  TaskDialog(ActiveFormHandle, Application.Title, '', Msg, TD_ICON_BLANK, CommonButtonToTaskDialogButton(AButton));
end;

procedure ShowMessageFmt(const Msg: TJSString; Params: array of const);
begin
  ShowMessage(Format(Msg, Params));
end;

function VerifyMessage(const aInstruction, aMsg: TJSString; const aIcon: TTaskDialogIcon;
  const aButtons: TCommonButtons; const aHelpIdx: Integer; const aVerifyText: TJSString;
  var aVerifyResult: Boolean; const AFooterText: string; AFooterIcon: TTaskDialogIcon): TModalResult;
var
  lDlg: TJSDialog;
begin
  lDlg := GetJSDialogClass.Create(nil);
  try
    lDlg.MainIcon := aIcon;
    lDlg.Title := GetDialogTitle(aIcon);
    lDlg.Content.Text := aMsg;
    lDlg.Instruction.Text := aInstruction;
    lDlg.ButtonBar.Buttons := aButtons;
    if not (cbCancel in aButtons) then
    begin
      if cbNo in aButtons then
        lDlg.ButtonBar.Cancel := cbNo;
    end;
    if not (cbOK in aButtons) then
    begin
      if cbYes in aButtons then
        lDlg.ButtonBar.Default := cbYes;
    end;
    lDlg.HelpContext := aHelpIdx;
    lDlg.Verification.Text := aVerifyText;
    lDlg.Verification.Visible := True;
    lDlg.Position := JSDialogDefaultDialogPosition;
    if UseOldDialogStyle then
    begin
      lDlg.ButtonBar.ShowDivider := False;
      lDlg.ButtonBar.Color := clBtnFace;
      lDlg.Color := clBtnFace;
      lDlg.Font.Height := DefFontData.Height;
      {$IFDEF DELPHI2009}
      {$WARN EXPLICIT_STRING_CAST OFF}
      {$ENDIF DELPHI2009}
      lDlg.Font.Name := string(DefFontData.Name);
      {$IFDEF DELPHI2009}
      {$WARN EXPLICIT_STRING_CAST ON}
      {$ENDIF DELPHI2009}
      lDlg.Font.Style := DefFontData.Style;
      lDlg.Font.Charset := DefFontData.Charset;
    end;
    lDlg.Verification.InitialState := aVerifyResult;
    if JSDialogForceWrapperDialogsOnTop then
      lDlg.DialogOptions := lDlg.DialogOptions + [doTopMost];
    lDlg.PlaySounds := JSDialogPlaySounds;
    LDlg.Footer.Visible := AFooterText <> '';
    LDlg.Footer.Text := AFooterText;
    LDlg.Footer.Icon := AFooterIcon;
    result := lDlg.Execute;
    aVerifyResult := lDlg.VerificationResult;
  finally
    lDlg.Free;
  end;
end;

function VerifyMessage(const aInstruction, aMsg: TJSString; const aIcon: TTaskDialogIcon;
  const aButtons: TCommonButtons; const aHelpIdx: Integer; const aVerifyText: TJSString;
  var aVerifyResult: Boolean): TModalResult;
begin
  Result := VerifyMessage(AInstruction, AMsg, AIcon, AButtons, AHelpIdx, AVerifyText, AVerifyResult, '', tdiNone);
end;

function VerifyMessage(const aMsg: TJSString; const aIcon: TTaskDialogIcon;
  const aButtons: TCommonButtons; const aHelpIdx: Integer; const aMsgType: TMsgType; const aVerifyText: TJSString;
  var aVerifyResult: Boolean): TModalResult;
var
  lMainInstruction: TJSString;
  lContent: TJSString;
begin
  if aMsgType = mtContent then
  begin
    lContent := aMsg;
    lMainInstruction := '';
  end
  else
  begin
    lMainInstruction := aMsg;
    lContent := '';
  end;
  result := VerifyMessage(lMainInstruction, lContent, aIcon, aButtons, aHelpIdx, aVerifyText, aVerifyResult, '', tdiNone);
end;

procedure ShowErrorMessage(const aMsg: TJSString);
begin
  {$IFNDEF DELPHI2010}
  MessageDlg(aMsg, mtError, [mbOK], 0);
  {$ELSE}
  MessageDlg(aMsg, mtError, [mbClose], 0);
  {$ENDIF DELPHI2010}
end;

procedure ShowErrorTitleMessage(const aTitle, aMsg: TJSString); overload;
begin
  TaskDialog(ActiveFormHandle, GetTranslatedString(StrError), aTitle, aMsg, TD_ICON_ERROR, TD_BUTTON_CLOSE);
end;

procedure ShowErrorTitleMessageWithError(const ATitle, AMessage, AException: TJSString; const AShowText: TJSString = ''; AHideText: TJSString = '');
var
  LDlg: TJSDialog;
begin
  LDlg := TJSDialog.Create(Application);
  try
    LDlg.Title := StrError;
    if AShowText = '' then
      LDlg.Expando.ShowText := 'Show Exception'
    else
      LDlg.Expando.ShowText := AShowText;
    if AHideText = '' then
      LDlg.Expando.HideText := 'Hide Exception'
    else
      LDlg.Expando.HideText := AHideText;
    LDlg.Expando.Lines.Text := AException;
    LDlg.Expando.Visible := True;
    LDlg.Expando.MoreFormat := mfRTF;
    LDlg.Expando.MoreHeight := 150;
    LDlg.Expando.ShowInFooter := True;
    if ATitle <> '' then
      LDlg.Instruction.Text := ATitle;
    LDlg.Content.Text := AMessage;
    LDlg.MainIcon := tdiError;
    LDlg.ButtonBar.Buttons := [cbClose];
    LDlg.ButtonBar.Default := cbClose;
    LDlg.ButtonBar.Cancel := cbClose;
    LDlg.Execute;
  finally
    LDlg.Free;
  end;
end;

procedure ShowErrorTitleMessageWithErrorAndFooter(const ATitle, AMessage, AException: TJSString;
  const AFooter: TJSString; const AFooterIcon: TTaskDialogIcon;
  const AShowText: TJSString = ''; AHideText: TJSString = '';
  const AAnimate: Boolean = False);
var
  LDlg: TJSDialog;
begin
  LDlg := TJSDialog.Create(Application);
  try
    LDlg.Title := StrError;
    if AShowText = '' then
      LDlg.Expando.ShowText := 'Show Exception'
    else
      LDlg.Expando.ShowText := AShowText;
    if AHideText = '' then
      LDlg.Expando.HideText := 'Hide Exception'
    else
      LDlg.Expando.HideText := AHideText;
    LDlg.Expando.Lines.Text := AException;
    LDlg.Expando.Visible := True;
    LDlg.Expando.MoreFormat := mfRTF;
    LDlg.Expando.MoreHeight := 150;
    LDlg.Expando.ShowInFooter := True;
    if ATitle <> '' then
      LDlg.Instruction.Text := ATitle;
    LDlg.Content.Text := AMessage;
    LDlg.MainIcon := tdiError;
    LDlg.ButtonBar.Buttons := [cbClose];
    LDlg.ButtonBar.Default := cbClose;
    LDlg.ButtonBar.Cancel := cbClose;
    LDlg.Footer.Text := AFooter;
    LDlg.Footer.Icon := AFooterIcon;
    LDlg.Footer.Visible := True;
    LDlg.Expando.Animate.Enabled := AAnimate;
    LDlg.Execute;
  finally
    LDlg.Free;
  end;
end;

function ShowWarningMessage(const aMsg: TJSString): TModalResult;
begin
  result := MessageDlg(aMsg, mtWarning, [mbYes, mbNo], 0);
end;

function ShowWarningTitleMessage(const aTitle, aMsg: TJSString): TModalResult;
begin
  result := TaskDialog(ActiveFormHandle, GetTranslatedString(StrWarning), aTitle, aMsg, TD_ICON_WARNING, TD_BUTTON_YES or TD_BUTTON_NO);
end;

function ShowConfirmMessage(const aMsg: TJSString; const AConfirm: TMsgDlgBtn = mbOK; const ACancel: TMsgDlgBtn = mbCancel): TModalResult;
begin
  result := MessageDlg(aMsg, mtConfirmation, [AConfirm, ACancel], 0);
end;

function ShowConfirmTitleMessage(const aTitle, aMsg: TJSString; const AConfirm: TMsgDlgBtn = mbOK; const ACancel: TMsgDlgBtn = mbCancel): TModalResult;
begin
  result := TaskDialog(ActiveFormHandle, GetTranslatedString(StrConfirmation), aTitle, aMsg, TD_ICON_QUESTION, MsgDlgButtonsToTaskDialogButtons([AConfirm, ACancel]));
end;

procedure ShowInfoMessage(const aMsg: TJSString);
begin
  MessageDlg(aMsg, mtInformation, [mbOK], 0);
end;

var
  _TimedDialogs: TObjectList;

type
  TJSTimedDialogsCloseClass = class
  public
    class procedure TimedDialogCloseHandler(Sender: TJSCustomDialog);
    class procedure TimedDialogTimerHandler(Sender: TObject; const TimeSince: Cardinal);
  end;

procedure ShowTimedInfoMessage(const AInstruction, AMessage: string; const ATimeOut: Integer;
  const AShowCountdown: Boolean = False; const ACountdownText: string = '');
var
  lDlg: TJSDialog;
begin
  lDlg := GetJSDialogClass.Create(nil);
  if AShowCountdown then
  begin
    // Store the original countdown text in the invisible header
    LDlg.Header.Text := ACountdownText;
    // Update the footer
    LDlg.Footer.Text := Format(ACountdownText, [ATimeOut div 1000]);
    LDlg.Footer.Visible := True;
    LDlg.Timer.Interval := 1000;
  end
  else
    LDlg.Timer.Interval := ATimeOut;
  LDlg.DialogOptions := [doTimer];
  LDlg.Instruction.Text := AInstruction;
  LDlg.Content.Text := AMessage;
  LDlg.ButtonBar.Buttons := [cbClose];
  LDlg.ButtonBar.Cancel := cbClose;
  LDlg.ButtonBar.Default := cbClose;
  LDlg.MainIcon := tdiInformation;
  LDlg.OnDialogClose := TJSTimedDialogsCloseClass.TimedDialogCloseHandler;
  LDlg.OnTimer := TJSTimedDialogsCloseClass.TimedDialogTimerHandler;
  LDlg.Tag := ATimeOut div 1000;
  LDlg.Execute;
  LDlg.Update;
end;

procedure ShowInfoTitleMessage(const aTitle, aMsg: TJSString); overload;
begin
  TaskDialog(ActiveFormHandle, GetTranslatedString(StrInformation), aTitle, aMsg, TD_ICON_INFORMATION, TD_BUTTON_CLOSE);
end;

procedure ShowInfoMessage(const aMsg: TJSString; aButton: TCommonButton);
begin
  TaskDialog(ActiveFormHandle, GetTranslatedString(StrInformation), '', aMsg, TD_ICON_INFORMATION, CommonButtonToTaskDialogButton(aButton));
end;

function ShowExpandableMessage(const aTitle, aInstruction, aContent, aExpandedContent, aExpandText, aCollapseText: TJSString;
  aIcon: TTaskDialogIcon; aButtons: TCommonButtons; aHelpIdx: Integer; const aShowInFooter, aExpanded: Boolean): TModalResult;
begin
  result := ShowExpandableMessage(nil, aTitle, aInstruction, aContent, aExpandedContent, aExpandText, aCollapseText,
    aIcon, aButtons, aHelpIdx, aShowInFooter, aExpanded);
end;

function ShowExpandableMessage(aOwner: TWinControl; const aTitle, aInstruction, aContent, aExpandedContent, aExpandText,
  aCollapseText: TJSString; aIcon: TTaskDialogIcon; aButtons: TCommonButtons; aHelpIdx: Integer; const aShowInFooter,
  aExpanded: Boolean): TModalResult; overload;
var
  lDlg: TJSDialog;
begin
  lDlg := GetJSDialogClass.Create(aOwner);
  try
    if aTitle <> '' then
      lDlg.Title := aTitle
    else
      lDlg.Title := GetDialogTitle(aIcon);
    lDlg.Instruction.Text := aInstruction;
    lDlg.Content.Add(aContent);
    lDlg.Expando.Lines.Add(aExpandedContent);
    lDlg.Expando.ShowText := aExpandText;
    lDlg.Expando.HideText := aCollapseText;
    lDlg.MainIcon := aIcon;
    lDlg.ButtonBar.Buttons := aButtons;
    lDlg.HelpContext := aHelpIdx;
    lDlg.Expando.ShowInFooter := aShowInFooter;
    lDlg.Expando.Showing := aExpanded;
    lDlg.Expando.Visible := True;
    lDlg.Position := JSDialogDefaultDialogPosition;
    if JSDialogForceWrapperDialogsOnTop then
      lDlg.DialogOptions := lDlg.DialogOptions + [doTopMost];
    lDlg.PlaySounds := JSDialogPlaySounds;
    result := lDlg.Execute;
  finally
    lDlg.Free;
  end;
end;

{$IFDEF BDS}
{$ENDREGION}
{$ENDIF BDS}

{ TJSTimedDialogsCloseClass }

class procedure TJSTimedDialogsCloseClass.TimedDialogCloseHandler(Sender: TJSCustomDialog);
var
  LIdx: Integer;
begin
  LIdx := _TimedDialogs.IndexOf(Sender);
  if LIdx > -1 then
    _TimedDialogs.Delete(LIdx);
end;

class procedure TJSTimedDialogsCloseClass.TimedDialogTimerHandler(Sender: TObject; const TimeSince: Cardinal);
var
  LDlg: TJSCustomDialog;
begin
  LDlg := TJSCustomDialog(Sender);
  if LDlg.Header.Text <> '' then
  begin
    LDlg.Tag := LDlg.Tag - 1;
    LDlg.Footer.Text := Format(LDlg.Header.Text, [LDlg.Tag]);
    if LDlg.Tag < 1 then
      LDlg.Close(0);
  end
  else
    LDlg.Close(0);
end;

initialization
  if IsVista then
    FXmlLiteHandle := 0;
  _TimedDialogs := TObjectList.Create;
  JSDialogDefaultDialogPosition := dpScreenCenter;
  JSDialogAlwaysUseJSDialog := False;
  JSDialogClass := TJSDialog;
  JSDialogForceWrapperDialogsOnTop := False;
  JSDialogPlaySounds := True;

finalization
  if FUnloadLib and (FLibHandle > 32) then
    FreeLibrary(FLibHandle);
  if IsVista and (FXmlLiteHandle <> 0) then
    FreeLibrary(FXmlLiteHandle);
  _TimedDialogs.Free;

end.
