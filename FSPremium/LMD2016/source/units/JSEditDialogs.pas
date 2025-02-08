{ Summary
  This unit contains the wrapper functions to use with TJSEditDialog }
unit JSEditDialogs;

interface

{$I lmddlgcmps.inc}

uses
  JSEditDialog, JSDialogs, JSEditEvents, Controls, Classes, Graphics, JSTypes;

type
  { Summary
    Simple type that encapsulates the values for setting a footer.
    Description
    Pass a TJSFooterRec type to wrapper functions that support displaying a footer on a dialog. }
  TJSFooterRec = record
    { Summary
      Specify the text of the footer section. }
    Text: string;
    { Summary
      Specify the icon to display in the footer section. }
    Icon: TTaskDialogIcon;
  end;

{ Summary
  Wrapper function for displaying a dialog with an edit control
  Description
  This function displays a dialog with a caption and an edit control. The caption is displayed above the edit control. }
function InputBox(const ACaption, APrompt, ADefault: TJSString): TJSString;
{ Summary
  Wrapper function for displaying a dialog with an edit control
  Description
  This function displays a dialog with a caption and an edit control.
  The caption is displayed according to the value set in the ACaptionPosition parameter. }
function InputBoxEx(const ACaption, APrompt, ADefault: TJSString; ACaptionPosition: TJSCaptionPosition = cpTop): TJSString;

{ Summary
  Wrapper function for displaying a dialog with an edit control
  Description
  This function displays a dialog with a caption and an edit control. The caption is displayed above the edit control.
  The function returns True if the OK button was clicked when the dialog was displayed.}
function InputQuery(const ACaption, APrompt: TJSString; var AValue: TJSString): Boolean; overload;
{ Summary
  Wrapper function for displaying a dialog with an edit control
  Description
  This function displays a dialog with a caption and an edit control.
  The caption is displayed according to the value set in the ACaptionPosition parameter.
  The function returns True if the OK button was clicked when the dialog was displayed.}
function InputQueryEx(const ACaption, APrompt: TJSString; var AValue: TJSString; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean; overload;

{ Summary
  Wrapper function for displaying a dialog with an edit control and the verification checkbox.
  Description
  This function displays a dialog with a caption, an edit control and the verification checkbox. The caption is displayed above the edit control.
  The function returns True if the OK button was clicked when the dialog was displayed. When the function returns true, read the verification checkboxes
  value using the AVerificationResult parameter. }
function InputQueryVerification(const ACaption, APrompt, AVerification: TJSString; var AValue: TJSString; var AVerificationResult: Boolean): Boolean;

{ Summary
  Wrapper function for displaying a dual edit dialog with an edit control
  Description
  This function displays a dual edit dialog with a caption and two edit controls. The caption is displayed above the edit control.
  The function returns True if the OK button was clicked when the dialog was displayed.}
function InputQuery(const ACaption, APrompt1, APrompt2: TJSString; var AValue1, AValue2: TJSString; const ACaptionAlignment: TJSCaptionAlignment = caRight): Boolean; overload;
{ Summary
  Wrapper function for displaying a dual edit dialog with an edit control
  Description
  This function displays a dialog with a caption and two edit controls.
  The caption is displayed according to the value set in the ACaptionPosition parameter.
  The function returns True if the OK button was clicked when the dialog was displayed.}
function InputQueryEx(const ACaption, APrompt1, APrompt2: TJSString; var AValue1, AValue2: TJSString; const ACaptionAlignment: TJSCaptionAlignment = caRight): Boolean; overload;

{ Summary
  Wrapper function for displaying a dialog with a combobox control
  Description
  This function displays a dialog with a caption and a combobox control. The caption is displayed above the edit control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected item from the combobox is returned in the AValue parameter.
  Set the AFixedList parameter to True to make the user select an item from the list. Setting the AFixedList parameter to False means the user can type in their own value.}
function InputCombo(const ACaption, APrompt: TJSString; var AValue: TJSString; const AFixedList: Boolean; AItems: TJSStrings): Boolean; overload;
{ Summary
  Wrapper function for displaying a dialog with a combobox control
  Description
  This function displays a dialog with a caption and a combobox control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected item from the combobox is returned in the AValue parameter.
  Set the AFixedList parameter to True to make the user select an item from the list. Setting the AFixedList parameter to False means the user can type in their own value.
  The caption is displayed according to the value set in the ACaptionPosition parameter.
  Optionally you can specify Content and Instruction text for the dialog as well. }
function InputComboEx(const ACaption, APrompt: TJSString; var AValue: TJSString; const AFixedList: Boolean; AItems: TJSStrings;
  ACaptionPosition: TJSCaptionPosition = cpTop; const AInstruction: TJSString = ''; AContent: TJSString = ''; AGlyph: TGraphic = nil): Boolean; overload;
{ Summary
  Wrapper function for displaying a dialog with a combobox control
  Description
  This function displays a dialog with a caption and a combobox control. The caption is displayed above the edit control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected items index is returned in the AItemIndex parameter.
  Set the AFixedList parameter to True to make the user select an item from the list. Setting the AFixedList parameter to False means the user can type in their own value.}
function InputCombo(const ACaption, APrompt: TJSString; var AItemIndex: Integer; const AFixedList: Boolean; AItems: TJSStrings): Boolean; overload;
{ Summary
  Wrapper function for displaying a dialog with a combobox control
  Description
  This function displays a dialog with a caption and a combobox control. The caption is displayed above the edit control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected items index is returned in the AItemIndex parameter.
  Set the AFixedList parameter to True to make the user select an item from the list. Setting the AFixedList parameter to False means the user can type in their own value.
  The caption is displayed according to the value set in the ACaptionPosition parameter.}
function InputComboEx(const ACaption, APrompt: TJSString; var AItemIndex: Integer; const AFixedList: Boolean; AItems: TJSStrings; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean; overload;
{ Summary
  Wrapper function for displaying a dialog with a combobox control
  Description
  This function displays a dialog with a caption and a combobox control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected item from the combobox is returned in the AValue parameter.
  Set the AFixedList parameter to True to make the user select an item from the list. Setting the AFixedList parameter to False means the user can type in their own value.
  The caption is displayed according to the value set in the ACaptionPosition parameter.
  To include a footer in your dialog, set the properties of the TJSFooterRec type and pass the structure in the AFooter parameter
  Optionally you can specify Content and Instruction text for the dialog as well. }
function InputComboEx(const ACaption, APrompt: TJSString; var AValue: TJSString; const AFixedList: Boolean; AItems: TJSStrings;
  AFooter: TJSFooterRec; ACaptionPosition: TJSCaptionPosition = cpTop; const AInstruction: TJSString = ''; AContent: TJSString = ''; AGlyph: TGraphic = nil): Boolean; overload;

{ Summary
  Wrapper function for displaying a dialog with a date picker control
  Description
  This function displays a dialog with a caption and a date picker control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected date is returned in the AValue parameter.}
function InputDate(const ACaption, APrompt: TJSString; var AValue: TDate): Boolean;
{ Summary
  Wrapper function for displaying a dialog with a date picker control
  Description
  This function displays a dialog with a caption and a date picker control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected date is returned in the AValue parameter.}
function InputDateEx(const ACaption, APrompt: TJSString; var AValue: TDate; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean;
{ Summary
  Wrapper function for displaying a dialog with a time control
  Description
  This function displays a dialog with a caption and a time control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected time is returned in the AValue parameter.}
function InputTime(const ACaption, APrompt: TJSString; var AValue: TTime): Boolean;
{ Summary
  Wrapper function for displaying a dialog with a time control
  Description
  This function displays a dialog with a caption and a time control.
  The caption is displayed according to the value set in the ACaptionPosition parameter.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected time is returned in the AValue parameter.}
function InputTimeEx(const ACaption, APrompt: TJSString; var AValue: TTime; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean;
{ Summary
  Wrapper function for displaying a dialog with a month calendar control
  Description
  This function displays a dialog with a caption and a month calendar control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected date is returned in the AValue parameter.}
function InputCalendar(const ACaption, APrompt: TJSString; var AValue: TDate): Boolean;
{ Summary
  Wrapper function for displaying a dialog with a month calendar control
  Description
  This function displays a dialog with a caption and a month calendar control.
  The caption is displayed according to the value set in the ACaptionPosition parameter.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected date is returned in the AValue parameter.}
function InputCalendarEx(const ACaption, APrompt: TJSString; var AValue: TDate; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean;

{ Summary
  Wrapper function for displaying a dialog with a listbox control
  Description
  This function displays a dialog with a caption and a listbox control. The caption is displayed above the edit control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected item from the listbox is returned in the AValue parameter. }
function InputList(const ACaption, APrompt: TJSString; var AValue: TJSString; AItems: TJSStrings): Boolean; overload;
{ Summary
  Wrapper function for displaying a dialog with a combobox control
  Description
  This function displays a dialog with a caption and a combobox control. The caption is displayed above the edit control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected item from the combobox is returned in the AValue parameter.
  The caption is displayed according to the value set in the ACaptionPosition parameter.}
function InputListEx(const ACaption, APrompt: TJSString; var AValue: TJSString; AItems: TJSStrings; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean; overload;

{ Summary
  Wrapper function for displaying a dialog with a listbox control
  Description
  This function displays a dialog with a caption and a listbox control. The caption is displayed above the edit control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected items index is returned in the AItemIndex parameter. }
function InputList(const ACaption, APrompt: TJSString; var AItemIndex: Integer; AItems: TJSStrings): Boolean; overload;
{ Summary
  Wrapper function for displaying a dialog with a listbox control
  Description
  This function displays a dialog with a caption and a listbox control.
  The function returns True if the OK button was clicked when the dialog was displayed.
  The selected items index is returned in the AItemIndex parameter.
  The caption is displayed according to the value set in the ACaptionPosition parameter.}
function InputListEx(const ACaption, APrompt: TJSString; var AItemIndex: Integer; AItems: TJSStrings; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean; overload;

var
  JSEditDialogClass: TJSEditDialogClass;

implementation

uses
  SysUtils, ComCtrls, StdCtrls, CommCtrl, JSDualEditDialog;

resourcestring
  StrCalendarDoubleClickPrompt = 'You can also double click the date to select it';

function InputBoxEx(const ACaption, APrompt, ADefault: TJSString; ACaptionPosition: TJSCaptionPosition = cpTop): TJSString;
var
  lDlg: TJSEditDialog;
  lEvents: TJSEditEvents;
begin
  lDlg := JSEditDialogClass.Create(nil);
  try
    lDlg.EditProperties.EditType := etEdit;
    lDlg.EditProperties.Value := ADefault;
    lDlg.EditProperties.Caption := APrompt;
    lDlg.EditProperties.CaptionPosition := ACaptionPosition;
    lDlg.Title := ACaption;
    lEvents := GetEventClass(etEdit).Create;
    try
      lDlg.OnGetEditControlClass := lEvents.GetEditControlClass;
      lDlg.OnGetControlHeight := lEvents.GetControlHeightHandler;
      lDlg.Execute;
      result := lDlg.EditValue;
    finally
      lEvents.Free;
    end;
  finally
    lDlg.Free;
  end;
end;

function InputBox(const ACaption, APrompt, ADefault: TJSString): TJSString;
begin
  result := InputBoxEx(ACaption, APrompt, ADefault);
end;

function InputDateEx(const ACaption, APrompt: TJSString; var AValue: TDate; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean;
var
  lDlg: TJSEditDialog;
  lEvents: TJSEditEvents;
begin
  lDlg := JSEditDialogClass.Create(nil);
  try
    lDlg.EditProperties.EditType := etDate;
    lDlg.EditProperties.Value := DateToStr(AValue);
    lDlg.EditProperties.Caption := APrompt;
    lDlg.EditProperties.CaptionPosition := ACaptionPosition;
    lDlg.Title := ACaption;
    lEvents := GetEventClass(etDate).Create;
    try
      lDlg.OnGetEditValue := lEvents.GetEditValueHandler;
      lDlg.OnSetDefaultValue := lEvents.SetDefaultValueHandler;
      lDlg.OnGetEditControlClass := lEvents.GetEditControlClass;
      lDlg.OnGetControlHeight := lEvents.GetControlHeightHandler;
      result := lDlg.Execute = mrOK;
      if result then
        AValue := StrToDate(lDlg.EditValue);
    finally
      lEvents.Free;
    end;
  finally
    lDlg.Free;
  end;
end;

function InputDate(const ACaption, APrompt: TJSString; var AValue: TDate): Boolean;
begin
  result := InputDateEx(ACaption, APrompt, AValue);
end;

function InputTimeEx(const ACaption, APrompt: TJSString; var AValue: TTime; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean;
var
  lDlg: TJSEditDialog;
  lEvents: TJSEditEvents;
begin
  lDlg := JSEditDialogClass.Create(nil);
  try
    lDlg.EditProperties.EditType := etTime;
    lDlg.EditProperties.Value := DateTimeToStr(AValue);
    lDlg.EditProperties.Caption := APrompt;
    lDlg.EditProperties.CaptionPosition := ACaptionPosition;
    lDlg.Title := ACaption;
    lEvents := GetEventClass(etTime).Create;
    try
      lDlg.OnGetEditValue := lEvents.GetEditValueHandler;
      lDlg.OnSetDefaultValue := lEvents.SetDefaultValueHandler;
      lDlg.OnGetEditControlClass := lEvents.GetEditControlClass;
      lDlg.OnGetControlHeight := lEvents.GetControlHeightHandler;
      result := lDlg.Execute = mrOK;
      if result then
        AValue := StrToDateTime(lDlg.EditValue);
    finally
      lEvents.Free;
    end;
  finally
    lDlg.Free;
  end;
end;

function InputTime(const ACaption, APrompt: TJSString; var AValue: TTime): Boolean;
begin
  result := InputTimeEx(ACaption, APrompt, AValue);
end;

function InputCalendarEx(const ACaption, APrompt: TJSString; var AValue: TDate; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean;
var
  lDlg: TJSEditDialog;
  lEvents: TJSEditEvents;
begin
  lDlg := JSEditDialogClass.Create(nil);
  try
    lDlg.EditProperties.EditType := etCalendar;
    lDlg.EditProperties.Value := DateToStr(AValue);
    lDlg.EditProperties.Caption := APrompt;
    lDlg.EditProperties.CaptionPosition := ACaptionPosition;
    lDlg.Title := ACaption;
    lEvents := GetEventClass(etCalendar).Create;
    try
      lDlg.OnGetEditValue := lEvents.GetEditValueHandler;
      lDlg.OnSetDefaultValue := lEvents.SetDefaultValueHandler;
      lDlg.OnGetEditControlClass := lEvents.GetEditControlClass;
      lDlg.OnGetControlHeight := lEvents.GetControlHeightHandler;
      lDlg.Footer.Icon := JSDialogs.tdiInformation;
      lDlg.Footer.Text := StrCalendarDoubleClickPrompt;
      lDlg.Footer.Visible := True;
      result := lDlg.Execute = mrOK;
      if result then
        AValue := StrToDate(lDlg.EditValue);
    finally
      lEvents.Free;
    end;
  finally
    lDlg.Free;
  end;
end;

function InputCalendar(const ACaption, APrompt: TJSString; var AValue: TDate): Boolean;
begin
  result := InputCalendarEx(ACaption, APrompt, AValue);
end;

function InputQueryEx(const ACaption, APrompt: TJSString; var AValue: TJSString; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean;
var
  lDlg: TJSEditDialog;
  lEvents: TJSEditEvents;
begin
  lDlg := JSEditDialogClass.Create(nil);
  try
    lDlg.EditProperties.EditType := etEdit;
    lDlg.EditProperties.Value := AValue;
    lDlg.EditProperties.Caption := APrompt;
    lDlg.EditProperties.CaptionPosition := ACaptionPosition;
    lDlg.Title := ACaption;
    lEvents := GetEventClass(etEdit).Create;
    try
      lDlg.OnGetEditControlClass := lEvents.GetEditControlClass;
      lDlg.OnGetControlHeight := lEvents.GetControlHeightHandler;
      result := lDlg.Execute = mrOK;
      if result then
        AValue := lDlg.EditValue;
    finally
      lEvents.Free;
    end;
  finally
    lDlg.Free;
  end;
end;

function InputQuery(const ACaption, APrompt: TJSString; var AValue: TJSString): Boolean;
begin
  result := InputQueryEx(ACaption, APrompt, AValue);
end;

function InputQueryVerification(const ACaption, APrompt, AVerification: TJSString; var AValue: TJSString; var AVerificationResult: Boolean): Boolean;
var
  LDlg: TJSEditDialog;
  LEvents: TJSEditEvents;
begin
  LDlg := JSEditDialogClass.Create(nil);
  try
    LDlg.EditProperties.EditType := etEdit;
    LDlg.EditProperties.Value := AValue;
    LDlg.EditProperties.Caption := APrompt;
    LDlg.EditProperties.CaptionPosition := cpTop;
    LDlg.Verification.Visible := True;
    LDlg.Verification.Text := AVerification;
    LDlg.Verification.InitialState := AVerificationResult;
    LDlg.Title := ACaption;
    LEvents := GetEventClass(etEdit).Create;
    try
      LDlg.OnGetEditControlClass := LEvents.GetEditControlClass;
      LDlg.OnGetControlHeight := LEvents.GetControlHeightHandler;
      Result := LDlg.Execute = mrOK;
      if Result then
      begin
        AValue := LDlg.EditValue;
        AVerificationResult := LDlg.VerificationResult;
      end;
    finally
      LEvents.Free;
    end;
  finally
    LDlg.Free;
  end;
end;

function InputQueryEx(const ACaption, APrompt1, APrompt2: TJSString; var AValue1, AValue2: TJSString; const ACaptionAlignment: TJSCaptionAlignment = caRight): Boolean;
var
  lDlg: TJSDualEditDialog;
begin
  lDlg := TJSDualEditDialog.Create(nil);
  try
    lDlg.EditProperties.EditType := etEdit;
    lDlg.Title := ACaption;
    LDlg.DualEditProperties.Value1 := AValue1;
    LDlg.DualEditProperties.Value1Caption := APrompt1;
    LDlg.DualEditProperties.Value2 := AValue2;
    LDlg.DualEditProperties.Value2Caption := APrompt2;
    Result := LDlg.Execute = mrOK;
    if Result then
    begin
      AValue1 := lDlg.EditValue1;
      AValue2 := lDlg.EditValue2;
    end;
  finally
    lDlg.Free;
  end;
end;

function InputQuery(const ACaption, APrompt1, APrompt2: TJSString; var AValue1, AValue2: TJSString; const ACaptionAlignment: TJSCaptionAlignment = caRight): Boolean;
begin
  Result := InputQueryEx(ACaption, APrompt1, APrompt2, AValue1, AValue2, ACaptionAlignment);
end;

function InputComboEx(const ACaption, APrompt: TJSString; var AValue: TJSString; const AFixedList: Boolean; AItems: TJSStrings;
  AFooter: TJSFooterRec; ACaptionPosition: TJSCaptionPosition = cpTop; const AInstruction: TJSString = ''; AContent: TJSString = '';
  AGlyph: TGraphic = nil): Boolean; overload;
var
  lDlg: TJSEditDialog;
  lEvents: TJSComboEvents;
begin
  lDlg := JSEditDialogClass.Create(nil);
  try
    if trim(AInstruction) <> '' then
      lDlg.Instruction.Text := AInstruction;
    if trim(AContent) <> '' then
      lDlg.Content.Text := AContent;
    if trim(AFooter.Text) <> '' then
    begin
      lDlg.Footer.Visible := True;
      lDlg.Footer.Text := AFooter.Text;
      lDlg.Footer.Icon := AFooter.Icon;
    end;
    if AFixedList then
      lDlg.EditProperties.EditType := etComboBox
    else
      lDlg.EditProperties.EditType := etEditComboBox;
    lDlg.EditProperties.Value := AValue;
    lDlg.EditProperties.Caption := APrompt;
    lDlg.EditProperties.CaptionPosition := ACaptionPosition;
    lDlg.EditProperties.Items := AItems;
    lDlg.Title := ACaption;
    if AGlyph <> nil then
    begin
      lDlg.MainIcon := tdiCustom;
      lDlg.Glyph.Assign(AGlyph);
    end;
    lEvents := TJSComboEventClass(GetEventClass(etComboBox)).Create(AFixedList, JSED_IGNORE_INDEX);
    try
      lDlg.OnInitialiseEdit := lEvents.InitialiseEditHandler;
      result := lDlg.Execute = mrOK;
      if result then
        AValue := lDlg.EditValue;
    finally
      lEvents.Free;
    end;
  finally
    lDlg.Free;
  end;
end;

function InputComboEx(const ACaption, APrompt: TJSString; var AValue: TJSString; const AFixedList: Boolean; AItems: TJSStrings;
  ACaptionPosition: TJSCaptionPosition = cpTop; const AInstruction: TJSString = ''; AContent: TJSString = ''; AGlyph: TGraphic = nil): Boolean;
var
  lFooter: TJSFooterRec;
begin
  lFooter.Text := '';
  lFooter.Icon := tdiNone;
  result := InputComboEx(ACaption, APrompt, AValue, AFixedList, AItems, lFooter, ACaptionPosition, AInstruction, AContent, AGlyph);
end;

function InputCombo(const ACaption, APrompt: TJSString; var AValue: TJSString; const AFixedList: Boolean; AItems: TJSStrings): Boolean;
begin
  result := InputComboEx(ACaption, APrompt, AValue, AFixedList, AItems);
end;

function InputComboEx(const ACaption, APrompt: TJSString; var AItemIndex: Integer; const AFixedList: Boolean; AItems: TJSStrings; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean;
var
  lDlg: TJSEditDialog;
  lEvents: TJSComboEvents;
begin
  lDlg := JSEditDialogClass.Create(nil);
  try
    if AFixedList then
      lDlg.EditProperties.EditType := etComboBox
    else
      lDlg.EditProperties.EditType := etEditComboBox;
    lDlg.EditProperties.Caption := APrompt;
    lDlg.EditProperties.CaptionPosition := ACaptionPosition;
    lDlg.EditProperties.Items := AItems;
    lDlg.Title := ACaption;
    lEvents := TJSComboEventClass(GetEventClass(etComboBox)).Create(AFixedList, AItemIndex);
    try
      lDlg.OnInitialiseEdit := lEvents.InitialiseEditHandler;
      lDlg.OnSetDefaultValue := lEvents.SetDefaultValueHandler;
      lDlg.OnGetEditValue := lEvents.GetEditValueHandler;
      lDlg.OnGetEditControlClass := lEvents.GetEditControlClass;
      lDlg.OnGetControlHeight := lEvents.GetControlHeightHandler;
      result := lDlg.Execute = mrOK;
      if result then
        AItemIndex := lEvents.SelectedIndex;
    finally
      lEvents.Free;
    end;
  finally
    lDlg.Free;
  end;
end;

function InputCombo(const ACaption, APrompt: TJSString; var AItemIndex: Integer; const AFixedList: Boolean; AItems: TJSStrings): Boolean;
begin
  result := InputComboEx(ACaption, APrompt, AItemIndex, AFixedList, AItems);
end;

function InputList(const ACaption, APrompt: TJSString; var AValue: TJSString; AItems: TJSStrings): Boolean; overload;
begin
  result := InputListEx(ACaption, APrompt, AValue, AItems, cpTop);
end;

function InputListEx(const ACaption, APrompt: TJSString; var AValue: TJSString; AItems: TJSStrings; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean; overload;
var
  lDlg: TJSEditDialog;
  lEvents: TJSListEvents;
begin
  lDlg := JSEditDialogClass.Create(nil);
  try
    lDlg.EditProperties.EditType := etListBox;
    lDlg.EditProperties.Caption := APrompt;
    lDlg.EditProperties.CaptionPosition := ACaptionPosition;
    lDlg.EditProperties.Items := AItems;
    lDlg.Title := ACaption;
    lEvents := TJSListEventClass(GetEventClass(etListBox)).Create(JSED_IGNORE_INDEX);
    try
      lDlg.OnInitialiseEdit := lEvents.InitialiseEditHandler;
      lDlg.OnSetDefaultValue := lEvents.SetDefaultValueHandler;
      lDlg.OnGetEditValue := lEvents.GetEditValueHandler;
      lDlg.OnGetEditControlClass := lEvents.GetEditControlClass;
      lDlg.OnGetControlHeight := lEvents.GetControlHeightHandler;
      result := lDlg.Execute = mrOK;
      if result then
        AValue := lDlg.EditValue;
    finally
      lEvents.Free;
    end;
  finally
    lDlg.Free;
  end;
end;

function InputList(const ACaption, APrompt: TJSString; var AItemIndex: Integer; AItems: TJSStrings): Boolean; overload;
begin
  result := InputListEx(ACaption, APrompt, AItemIndex, AItems, cpTop);
end;

function InputListEx(const ACaption, APrompt: TJSString; var AItemIndex: Integer; AItems: TJSStrings; ACaptionPosition: TJSCaptionPosition = cpTop): Boolean; overload;
var
  lDlg: TJSEditDialog;
  lEvents: TJSListEvents;
begin
  lDlg := JSEditDialogClass.Create(nil);
  try
    lDlg.EditProperties.EditType := etListBox;
    lDlg.EditProperties.Caption := APrompt;
    lDlg.EditProperties.CaptionPosition := ACaptionPosition;
    lDlg.EditProperties.Items := AItems;
    lDlg.Title := ACaption;
    lEvents := TJSListEventClass(GetEventClass(etListBox)).Create(AItemIndex);
    try
      lDlg.OnInitialiseEdit := lEvents.InitialiseEditHandler;
      lDlg.OnSetDefaultValue := lEvents.SetDefaultValueHandler;
      lDlg.OnGetEditValue := lEvents.GetEditValueHandler;
      lDlg.OnGetEditControlClass := lEvents.GetEditControlClass;
      lDlg.OnGetControlHeight := lEvents.GetControlHeightHandler;
      result := lDlg.Execute = mrOK;
      if result then
        AItemIndex := lEvents.SelectedIndex;
    finally
      lEvents.Free;
    end;
  finally
    lDlg.Free;
  end;
end;

initialization
  JSEditDialogClass := TJSEditDialog;

end.
