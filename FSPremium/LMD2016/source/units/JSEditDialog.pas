{ Summary
  This unit contains the TJSEditDialog class used for displaying a TJSDialog with editing capabilities. }
unit JSEditDialog;

interface

{$I lmddlgcmps.inc}

uses
  Controls, Classes, JSDialog, StdCtrls, Windows, JSTypes, CheckLst;

type
  { Summary
    Used to specify the alignment of captions that appear with edit controls. }
  TJSCaptionAlignment = (caLeft { Captions are left aligned. },
    caRight { Captions are right aligned. });

  { Summary
    Used to specify the type of control to create when the dialog is displayed. }
  TJSEditType = (etNone { No edit control is to be displayed },
                 etEdit { A TEdit control is to be displayed },
                 etMemo { A TMemo control is to be displayed },
                 etComboBox { A TComboBox control is to be displayed },
                 etListBox { A TListBox control is to be displayed },
                 etDate { A TDateTimePicker control is to be displayed in date mode },
                 etTime { A TDateTimePicker control is to be displayed in time mode },
                 etCalendar { A TMonthCalendar control is to be displayed },
                 etCustom { Set the control class to display by handling the OnGetEditControlClass event },
                 etCheckListBox { A TCheckListBox control is to be displayed },
                 etRTF { A TRichEdit control is to be displayed },
                 etHTML { A TWebBrowser control is to be displayed },
                 etEditComboBox { A editable drop down list }
                );

  { Summary
    Set the position of the edit controls label relative to the edit control. }
  TJSCaptionPosition = (cpLeft { The caption for the edit control is displayed to the left of the control },
                        cpTop { The caption for the edit control is displayed above the control });

  { Summary
    Specifies the coverage of the edit control within the dialog.
    Description
    TCoverage specifies how the Coverage value is interpreted for the edit control. }
  TCoverageType = (ctPercent,{ The Coverage value is a percentage of the dialogs calculated width. }
   ctPixels { The Coverage value specifies the width of the edit control. }
   );

  { Summary
    TEditProperties encapsulates all of the properties required to define a dialogs edit control.
    Description
    TEditProperties describes characteristics of the edit control. It defines the type of control to be
    created, as well as the caption associated with the label and also the placement of the label.<p />
    <p />
    Along with properties for defining the width for the edit control, the height of the edit control can
    also be specified.<p />
    If the edit control being created supports multiple items, such as the etListBox, etComboBox, etCheckListBox,
    etEditComboBox and etRTF then initial items can be defined in the Items property.<p />
    <p />
    The default text value for the control can be specified in the Value property. For EditType values of
    etCustom and the edit control class being used does not havDe a published Text property, then you can
    set the default value of the edit control by handling the OnSetDefaultValue event.                    }
  TJSEditProperties = class(TJSChangePersistent)
  private
    FEditType: TJSEditType;
    FCaption: TJSString;
    FCaptionPosition: TJSCaptionPosition;
    FValue: TJSString;
    FHeight: Integer;
    FItems: TJSStrings;
    FAllowDoubleClickToClose: Boolean;
    FCoverageType: TCoverageType;
    FCoverage: Integer;
    FAllowActiveControl: Boolean;
    FMaxLength: Integer;
    procedure SetEditType(const Value: TJSEditType);
    procedure SetCaption(const Value: TJSString);
    procedure SetCaptionPosition(const Value: TJSCaptionPosition);
    procedure SetValue(const Value: TJSString);
    procedure SetHeight(const Value: Integer);
    procedure SetItems(const Value: TJSStrings);
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    { Summary
      Specifies whether the edit control has a caption displayed.
      Description
      Specifies whether the edit control has a caption displayed.
      Returns
      Returns True if the edit control has a caption visible.    }
    function CaptionVisible: Boolean; {$IFDEF INLINE}inline;{$ENDIF INLINE}
  published
    { The text to display in the labels caption }
    property Caption: TJSString read FCaption write SetCaption;
    { The initial value of the edit control as a string.
      To use a different value handle the OnSetDefaultValue event }
    property Value: TJSString read FValue write SetValue;
    { Summary
      Use the EditType property to set the type of edit control you want to display.
      Description
      The default controls created are:
        etNone: TEdit
        etEdit: TEdit
        etMemo: TMemo
        etComboBox: TComboBox
        etListBox: TListBox
        etDate, etTime: TDateTimePicker
        etCalendar: TJSMonthCalendar
        etCustom: TEdit
        etCheckListBox: TCheckListBox
        etRTF: TJSRichEdit
        etHTML: TWebBrowser
        etEditComboBox: TComboBox

        Handle the OnGetEditControlClass event to override the use of a specific edit control class }
    property EditType: TJSEditType read FEditType write SetEditType default etEdit;
    { Summary
      Sets the height of the edit control
      Description
      Some controls heights are dependant on the Font size used (TEdit for example).
      You can also override the control height by handling the OnGetControlHeight event. }
    property Height: Integer read FHeight write SetHeight default 100;
    { Summary
      The items to display when the EditType requires a list of items
      Description
      Currently only the etListBox, etComboBox, etEditComboBox, etCheckListBox, etRTF and etHTML support a list of items }
    property Items: TJSStrings read FItems write SetItems;
    { Summary
      Determines the number of characters that can be input into the edit control.
      Description
      Not all valid EditType values support this property.
      etEdit Yes
      etDateTime No
      etMemo Yes }
    property MaxLength: Integer read FMaxLength write FMaxLength default 0;
    { Summary
      Double clicking on the edit control closes the dialog.
      Description
      Currently the only edit types that implement the AllowDoubleClickToClose property is etListBox and etCalendar. }
    property AllowDoubleClickToClose: Boolean read FAllowDoubleClickToClose write FAllowDoubleClickToClose default True;
    { Summary
      Position of the label that is associated with the edit control
      Description
      The label position can be either cpTop (on top of the edit control) or cpLeft (to the left of the
      control).

      The default value for the component version of TJSEditDialog is cpLeft                            }
    property CaptionPosition: TJSCaptionPosition read FCaptionPosition write SetCaptionPosition default cpLeft;
    { Summary
      Specifies the coverage value of the edit control.
      Description
      Use the Coverage property to specify the coverage value of the control. Depends on the value of the
      CoverageType property to determine the true meaning of the Coverage property.<p />
      <p />
      Modify the Coverage property to have the edit control not be shown as the width of the dialog.
      Remarks
      By default, the edit control expands the width of the dialog.
      See Also
      TCoverageType, Coverage                                                                             }
    property Coverage: Integer read FCoverage write FCoverage default 100;
    { Summary
      Specify the CoverageType for the edit control.
      Description
      The value of the CoverageType property is used to help interpret the Coverage value.
      Example
      <b>Percentage</b><p />
      To have an edit controls width on a TJSEditDialog by half the width of the dialog use the following
      Coverage and CoverageType values:
      <table>
      Coverage       50
      CoverageType   ctPercent
      </table>
      
      <b>Pixels</b><p />
      To have an edit controls width be 100 pixels, specify the following values:
      <table>
      Coverage       100
      CoverageType   ctPixels
      </table>
      See Also
      Coverage, TCoverageType                                                                             }
    property CoverageType: TCoverageType read FCoverageType write FCoverageType default ctPercent;
    { Summary
      Determines whether the edit control can be made the active control.
      Description
      Change this value to false to not allow the control to be the dialogs active control when created. To remove the
      control from the Tab Order, set the TabStop property to False in the OnInitialiseEdit event. }
    property AllowActiveControl: Boolean read FAllowActiveControl write FAllowActiveControl default True;
  end;

  { Summary
    Type used in the OnGetEditProperties method when using a properties class for the EditProperties
    property.                                                                        }
  TJSEditPropertiesClass = class of TJSEditProperties;

  { Event signature for the OnGetControlClass event. }
  TJSGetControlClassEvent = procedure (Sender: TObject; const Index: Integer; var ControlClass: TControlClass) of object;
  { Event signature for the OnGetEditValue event. }
  TJSGetEditValueEvent = procedure (Sender: TObject; AControl: TControl; const Index: Integer; var Value: TJSString) of object;
  { Event signature for the OnSetDefaultValue event. }
  TJSSetDefaultValueEvent = procedure (Sender: TObject; AControl: TControl; const Index: Integer; const Value: TJSString) of object;
  { Event signature for the OnGetControlHeight event. }
  TJSGetControlHeightEvent = procedure (Sender: TObject; AControl: TControl; const Index: Integer; var Height: Integer) of object;
  { Event signature for the OnInitialiseEdit event. }
  TJSInitialiseEditEvent = procedure (Sender: TObject; AControl: TControl; const Index: Integer) of object;
  { Event signature for the OnValidate event. }
  TJSValidateEvent = procedure (Sender: TObject; Control: TControl; var Valid: Boolean) of object;
  { Event signature for the OnAdjustTopValue event. } 
  TJSAdjustTopValueEvent = procedure (Sender: TObject; var ATop: Integer) of object;

  { Summary
    TJSCustomEditDialog is the base class for all dialogs that can specify an edit control.
    Description
    Use TJSCustomEditDialog as a base class when defining new dialogs that need to include an edit
    control.                                                                                       }
  TJSCustomEditDialog = class(TJSDialog)
  private
    FOnGetEditControlClass: TJSGetControlClassEvent;
    FEditProperties: TJSEditProperties;
    FOnSetDefaultValue: TJSSetDefaultValueEvent;
    FOnGetControlHeight: TJSGetControlHeightEvent;
    FOnGetEditValue: TJSGetEditValueEvent;
    FEditValue: TJSString;
    FOnInitialiseEdit: TJSInitialiseEditEvent;
    FEditInitialised: Boolean; // set to true once OnInitialiseEdit has been called
    FOnValidate: TJSValidateEvent;
    FOnAdjustTopValue: TJSAdjustTopValueEvent;
    FOnSetEditValue: TJSSetDefaultValueEvent;
    procedure CreateEditControl;
    procedure SetEditProperties(const Value: TJSEditProperties);
    function GetEditValue: TJSString;
    function GetEditControl(Index: Integer): TControl;
    procedure EditControlDblClickHandler(Sender: TObject);
    procedure SetEditValue(const AValue: TJSString);
  protected
    FEditControl: TControl;
    FEditLabel: TLabel;
    function CheckMinimumHeight: Boolean; override;
    function HeightAdjustment: Integer; override;
    function WidthAdjustment: Integer; override;
    { Summary
      Return a particular TJSEditProperties descendent class used to represent the EditProperties property
      for a TJSCustomEditDialog descendent.
      Description
      Override this method in your TJSCustomDialog descendents to add additional properties specific to
      your descendent classes EditProperties property.
      Returns
      The class type to use for the EditProperties property in a TJSCustomEditDialog descendent.           }
    function GetEditPropertiesClass: TJSEditPropertiesClass; virtual;
    procedure CreateEditControls; override;
    { Summary
      Calls the DoGetControlHeight method and returns the edit controls height. }
    function GetHeightForEditType: Integer; virtual;
    { Summary
      Method that calls the OnGetEditValue event. }
    function DoGetEditValue: TJSString; virtual;
    { Summary
      Method that sets the default value of the edit control.
      Description
      If the edit control has a published Text property, then this method sets that value to be the
      EditProperties.DefaultValue property.

      This method also triggers the OnSetDefaultValue event which can be used to handle etCustom edit types.

      Specific support for etMemo is also implemented. }
    procedure DoSetDefaultValue; virtual;
    { Summary
      Provides default setting of the edit controls values. }
    procedure DoUpdateEditControl(const AValue: TJSString; AItems: TJSStrings); virtual;
    { Summary
      Method that returns the default edit class to be used for the EditProperties.EditType value.
      Description
      If the OnGetEditControlClass event has been handled and the AControlClass value is defined, then the default
      method handling does not occur. }
    procedure DoGetEditControlClass(var AControlClass: TControlClass); virtual;
    { Summary
      Method that triggers the OnGetControlHeight event.
      Description
      If either the OnGetControlHeight event is not handled, or the height returned by the event is less than or equal
      to zero, then the default calculation for edit controls is used.

      When TJSEditType is etCustom, then the OnGetControlHeight event should be implemented or the
      EditProperties.Height property should be set to the desired height value for the custom control.
      Remarks
      The Height value is automatically adjusted for DPI changes. }
    function DoGetControlHeight: Integer; virtual;
    procedure DoDestroyed; override;
    { Summary
      Initialises the edit control on the dialog.
      Description
      If the edit control supports the IJSDialogControl interface then the SetDialog method of that interface is
      called within the InitialiseEditControl method. }
    procedure InitialiseEditControl(var AControl: TControl); virtual;
    procedure DoDialogConstructed; override;
    procedure DoDialogClose(Sender: TObject); override;
    function GetActiveControl: TWinControl; override;
    { Summary
      Method that calculates the edit controls width on the dialog.
      Description
      This method takes into account the EditProperties.Coverage and EditProperies.CoverageType values to calculated
      the required edit control width. }
    function GetEditControlWidth: Integer; virtual;
    procedure DoDialogCloseQuery(Sender: TObject; var CanClose: Boolean); override;
    { Summary
      Method that performs the dialogs validation.
      Description
      If the edit control used for the dialog implements the IJSDialogControl interface, then the ValidateInput
      method of the interface is called. If the ValidateInput method is successful, then the OnValidate event
      is triggered to allow for additional validation.
      Remarks
      If validation fails, the DoValidation method will also attempt to focus on the control causing the validation
      to fail. }
    function DoValidation: Boolean; virtual;
    { Summary
      Returns the default left position for the edit control layout.
      Description
      The default left position is for the label (if visible) associated with the edit control, or both the label and
      edit control when the label is aligned on top of the edit control. The left position also takes into account
      the coverage property details. }
    function GetLeftPosition: Integer; virtual;
    { Summary
      Method to call the OnAdjustTopValue event.
      Description
      Override this method to perform additional processing prior to calling the OnAdjustTopValue event. }
    procedure DoAdjustTopValue(var ATop: Integer); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Summary
      Method that allows to update the edit controls text on a dialog when the EditProperties.EditType value is etEdit.
      Description
      This method also allows the caller to focus on the dialogs edit control and also select the contents of the
      edit control. }
    procedure UpdateValue(const AValue: TJSString; const AFocus, ASelect: Boolean);
    procedure PositionControls; override;
    procedure Assign(Source: TPersistent); override;
    { Summary
      Returns true if the item at the index specified is checked.
      Description
      Determines if the item at the specified index of the etCheckListBox dialog is checked. }
    function ItemChecked(const AIndex: Integer): Boolean; overload;
    { Summary
      Returns true if the item is checked.
      Description
      Determines if the specific item in an etCheckListBox dialog is checked. }
    function ItemChecked(const AValue: string): Boolean; overload;
    { Summary
      Specifies the number of items in the list for etListBox and etCheckListBox controls. }
    function ItemCount: Integer;
    { Summary
      Returns a list of checked items
      Description
      Call this method in the OnValidate event when the EditType is etCheckListBox to find out which items
      have been checked by the user.

      See Also the ItemChecked and ItemCount methods for alternate ways to retrieve the checked items. }
    function GetCheckedItems(AItems: TJSStrings): Boolean;
    function Execute(aOwner: TComponent): Integer; overload; override;
    { The dialog result referenced as a string. }
    property EditValue: TJSString read FEditValue write SetEditValue;
    { Access to the created edit controls. Currently only one edit control is supported. }
    property EditControls[Index: Integer]: TControl read GetEditControl;
    { Contains the properties for changing the characteristics of the edit control on a dialog. }
    property EditProperties: TJSEditProperties read FEditProperties write SetEditProperties;
    { Handle this event to specify a custom edit control. }
    property OnGetEditControlClass: TJSGetControlClassEvent read FOnGetEditControlClass write FOnGetEditControlClass;
    { Handle this event to set specific properties on the edit control instance. }
    property OnInitialiseEdit: TJSInitialiseEditEvent read FOnInitialiseEdit write FOnInitialiseEdit;
    { Handle this event to set the default value of the edit control instance.
      Handle this event if your custom edit control class doesn't contain a 'Text' published property. }
    property OnSetDefaultValue: TJSSetDefaultValueEvent read FOnSetDefaultValue write FOnSetDefaultValue;
    { Handle this event to return the selected edit value of the edit control instance as a string.
      Handle this event if your custom edit control class doesn't contain a 'Text' published property. }
    property OnGetEditValue: TJSGetEditValueEvent read FOnGetEditValue write FOnGetEditValue;
    { Handle this event to set the edit control instance at a specific height. }
    property OnGetControlHeight: TJSGetControlHeightEvent read FOnGetControlHeight write FOnGetControlHeight;
    { Summary
      Handle this event to perform validation on dialog input when the dialog has been closed.
      Description
      The OnValidate event is triggered when the dialog has been closed with an ModalResult that is deemed successful.
      A successful outcome includes any on the following ModalResult values: mrOK, mrYes.
      The EditControl to be validated is passed in the Control parameter. To set the result of the validation, set
      the Valid parameter of the event. }
    property OnValidate: TJSValidateEvent read FOnValidate write FOnValidate;
    { Summary
      Handle this event to change the calculated Top position of the edit control and label associated with the dialog.
      It is recommended that small increments are trialed instead of overwriting the new value. The changed value is
      not validated so caution is encouraged when changing. }
    property OnAdjustTopValue: TJSAdjustTopValueEvent read FOnAdjustTopValue write FOnAdjustTopValue;
    { Summary
      Event called when EditValue is being assigned.
      Description
      Handle this event to populate the edit control displayed in the dialog with the content passed to the EditValue property. }
    property OnSetEditValue: TJSSetDefaultValueEvent read FOnSetEditValue write FOnSetEditValue;
  end;

  { Summary
    TJSEditDialog implements the ability to include an edit control on a dialog.
    Description
    Use the TJSEditDialog component to have a dialog that can display an edit control for the user to
    modify.                                                                                           }
  {$IFDEF DELPHI_XE2}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64{ or pidOSX32})]
  {$ENDIF}
  TJSEditDialog = class(TJSCustomEditDialog)
  published
    property EditProperties;
    property OnAdjustTopValue;
    property OnGetEditControlClass;
    property OnInitialiseEdit;
    property OnSetDefaultValue;
    property OnSetEditValue;
    property OnGetEditValue;
    property OnGetControlHeight;
    property OnValidate;
  end;

  TJSEditDialogClass = class of TJSEditDialog;

implementation

uses
  SysUtils, TypInfo, CommCtrl, ComCtrls, Math, JSMonthCal, JSEditDialogIntf,
  JSDialogs, JSRichEdit, SHDocVw, Forms, ActiveX, Graphics, JSUnicode;

const
  URL_PREFIX = 'http';
  FILE_PREFIX = 'file';

{ TJSEditDialog }

procedure TJSCustomEditDialog.Assign(Source: TPersistent);
var
  lSrc: TJSCustomEditDialog;
begin
  inherited;
  if Source is TJSCustomEditDialog then
  begin
    lSrc := Source as TJSCustomEditDialog;
    EditProperties := lSrc.EditProperties;
  end;
end;

function TJSCustomEditDialog.CheckMinimumHeight: Boolean;
begin
  result := False;
end;

constructor TJSCustomEditDialog.Create(AOwner: TComponent);
begin
  inherited;
  FEditProperties := GetEditPropertiesClass.Create;
end;

procedure TJSCustomEditDialog.CreateEditControls;
begin
  inherited;
  CreateEditControl;
end;

destructor TJSCustomEditDialog.Destroy;
begin
  FreeAndNil(FEditProperties);
  FEditControl := nil;
  FEditLabel := nil;
  inherited;
end;

procedure TJSCustomEditDialog.DoGetEditControlClass(var AControlClass: TControlClass);
begin
  if Assigned(FOnGetEditControlClass) then
    FOnGetEditControlClass(Self, 0, AControlClass);
  if AControlClass = nil then
  begin
    case EditProperties.EditType of
      etNone: AControlClass := TEdit;
      etEdit: AControlClass := TEdit;
      etMemo: AControlClass := TMemo;
      etComboBox: AControlClass := TComboBox;
      etListBox: AControlClass := TListBox;
      etDate, etTime: AControlClass := TDateTimePicker;
      etCalendar: AControlClass := TJSMonthCalendar;
      etCustom: AControlClass := TEdit;
      etCheckListBox: AControlClass := TCheckListBox;
      etRTF: AControlClass := TJSRichEdit;
      etHTML: AControlClass := TWebBrowser;
      etEditComboBox: AControlClass := TComboBox;
    else
      AControlClass := TEdit;
    end;
  end;
end;

function TJSCustomEditDialog.DoGetEditValue: TJSString;
begin
  Result := '';
  if Assigned(FOnGetEditValue) then
    FOnGetEditValue(Self, FEditControl, 0, Result);
end;

procedure LoadHtml(ABrowser: TWebBrowser; AContent: TJSStrings);
var
  LStream: TMemoryStream;
begin
  ABrowser.Navigate('about:blank') ;
  while ABrowser.ReadyState < READYSTATE_INTERACTIVE do
    Application.ProcessMessages;
  if Assigned(ABrowser.Document) then
  begin
    LStream := TMemoryStream.Create;
    try
      AContent.SaveToStream(LStream);
      LStream.Position := 0;
      (ABrowser.Document as IPersistStreamInit).Load(TStreamAdapter.Create(LStream));
    finally
      LStream.Free;
    end;
  end;
end;

procedure TJSCustomEditDialog.DoSetDefaultValue;
begin
  DoUpdateEditControl(EditProperties.Value, EditProperties.Items);
  if Assigned(FOnSetDefaultValue) then
    FOnSetDefaultValue(Self, FEditControl, 0, EditProperties.Value);
end;

procedure TJSCustomEditDialog.DoUpdateEditControl(const AValue: TJSString; AItems: TJSStrings);
var
  LTempList: TJSWideStringList;
  LStream: TStringStream;
begin
  if (EditProperties.EditType in [etEdit]) and
    (GetPropInfo(FEditControl, 'Text', tkProperties) <> nil) then
    SetPropValue(FEditControl, 'Text', AValue)
  else
  begin
    if EditProperties.EditType = etMemo then
    begin
      if (AItems <> nil) and (AItems.Text <> '') then
        TMemo(FEditControl).Lines.Assign(AItems)
      else
        TMemo(FEditControl).Lines.Text := AValue;
    end
    else if EditProperties.EditType in [etComboBox, etEditComboBox] then
    begin
      if (AItems <> nil) and (AItems.Text <> '') then
        TComboBox(FEditControl).Items.Assign(AItems)
      else
        TComboBox(FEditControl).Items.Text := AValue;
      if AValue <> '' then
        TComboBox(FEditControl).ItemIndex := TComboBox(FEditControl).Items.IndexOf(AValue);
    end
    else if EditProperties.EditType in [etListBox, etCheckListBox] then
    begin
      if (AItems <> nil) and (AItems.Text <> '') then
        TCustomListBox(FEditControl).Items.Assign(AItems)
      else
        TCustomListBox(FEditControl).Items.Text := AValue;
      if AValue <> '' then
        TCustomListBox(FEditControl).ItemIndex := TCustomListBox(FEditControl).Items.IndexOf(AValue);
    end
    else if EditProperties.EditType = etRTF then
    begin
      if (AItems <> nil) and (AItems.Text <> '') then
        TJSRichEdit(FEditControl).Lines.Assign(AItems)
      else
      begin
        if TJSRichEdit(FEditControl).PlainText then
          TJSRichEdit(FEditControl).Text := AValue
        else
        begin
          LStream := TStringStream.Create(AValue);
          try
            LStream.Position := 0;
            TJSRichEdit(FEditControl).Lines.LoadFromStream(LStream);
          finally
            LStream.Free;
          end;
        end;
      end;
    end
    else if EditProperties.EditType = etHTML then
    begin
      if (AItems <> nil) and (AItems.Text <> '') then
      begin
        if AItems.Count = 1 then
        begin
          if (POS(URL_PREFIX, lowercase(AItems.Text)) = 1) or (POS(FILE_PREFIX, lowercase(AItems.Text)) = 1) then
            TWebBrowser(FEditControl).Navigate(AItems.Text)
          else
            LoadHtml(TWebBrowser(FEditControl), AItems);
        end
        else
          LoadHtml(TWebBrowser(FEditControl), AItems);
      end
      else
      begin
        if (POS(URL_PREFIX, lowercase(AValue)) = 1) or (POS(FILE_PREFIX, lowercase(AItems.Text)) = 1) then
          TWebBrowser(FEditControl).Navigate(AValue)
        else
        begin
          LTempList := TJSWideStringList.Create;
          try
            LTempList.Text := AValue;
            LoadHtml(TWebBrowser(FEditControl), LTempList);
          finally
            LTempList.Free;
          end;
        end;
      end;
    end;
  end;
end;

function TJSCustomEditDialog.DoValidation: Boolean;
var
  lIntf: IJSEditDialogControl;
  lMsg: TJSString;
begin
  result := True;
  if FButtonClicked and Supports(EditControls[0], IJSEditDialogControl, lIntf) then
  begin
    result := lIntf.ValidateInput(lMsg, ModalResult);
    if not result and (lMsg <> '') then
      ShowErrorMessage(lMsg);
  end;
  // Don't trigger the OnValidate event if the call to ValidateInput has returned False
  if result and (ModalResult in [mrYes, mrOK]) and Assigned(FOnValidate) then
    FOnValidate(Self, EditControls[0], result);
  if not result then
  begin
    if Supports(EditControls[0], IJSEditDialogControl, lIntf) then
      FForm.ActiveControl := lIntf.ActiveControlInError
    else
      FForm.ActiveControl := GetActiveControl;
  end;
end;

procedure TJSCustomEditDialog.EditControlDblClickHandler(Sender: TObject);
begin
  FButtonClicked := True;
  ModalResult := mrOk;
  FForm.Close;
end;

function TJSCustomEditDialog.Execute(aOwner: TComponent): Integer;
begin
  FEditInitialised := False;
  result := inherited Execute(aOwner);
end;

procedure TJSCustomEditDialog.DoAdjustTopValue(var ATop: Integer);
begin
  if Assigned(FOnAdjustTopValue) then
    FOnAdjustTopValue(Self, ATop);
end;

procedure TJSCustomEditDialog.DoDestroyed;
begin
  inherited;
  FEditControl := nil;
  FEditLabel := nil;
end;

procedure TJSCustomEditDialog.DoDialogClose(Sender: TObject);
begin
  FEditValue := GetEditValue;
  inherited;
end;

procedure TJSCustomEditDialog.DoDialogCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := DoValidation;
end;

procedure TJSCustomEditDialog.DoDialogConstructed;
begin
  inherited;
  DoSetDefaultValue;
end;

function TJSCustomEditDialog.DoGetControlHeight: Integer;
  function DefaultControlHeight: Integer;
  begin
    if FForm <> nil then
      result := FForm.Canvas.TextHeight('Sample') + 8
    else
      result := AFFS(23);
  end;
begin
  result := 0;
  if Assigned(FOnGetControlHeight) then
    FOnGetControlHeight(Self, FEditControl, 0, result);
  if result <= 0 then
  begin
    case EditProperties.EditType of
      etNone: result := DefaultControlHeight;
      etEdit: result := DefaultControlHeight;
      etMemo: result := AFFS(EditProperties.Height);
      etComboBox: result := DefaultControlHeight;
      etListBox: result := AFFS(EditProperties.Height);
      etDate, etTime: result := DefaultControlHeight;
      etCalendar: result := AFFS(Max(EditProperties.Height, 164));
      etCheckListBox: result := AFFS(EditProperties.Height);
      etRTF: result := AFFS(EditProperties.Height);
      etHTML: result := AFFS(EditProperties.Height);
      etEditComboBox: result := DefaultControlHeight;
    else
      // etCustom should be handled in the OnGetControlHeightEvent, otherwise default the height
      result := AFFS(EditProperties.Height);
    end;
  end;
end;

function TJSCustomEditDialog.GetActiveControl: TWinControl;
var
  lIntf: IJSEditDialogControl;
begin
  if Supports(FEditControl, IJSEditDialogControl, lIntf) then
    result := lIntf.ActiveControl
  else if (ActiveControlType = ctButton) and EditProperties.AllowActiveControl and (FEditControl is TWinControl) then
    result := FEditControl as TWinControl
  else
    result := inherited GetActiveControl;
end;

function TJSCustomEditDialog.GetCheckedItems(AItems: TJSStrings): Boolean;
var
  I: Integer;
begin
  AItems.Clear;
  if (EditProperties.EditType in [etListBox, etCheckListBox]) and (FEditControl <> nil) then
  begin
    for I := 0 to ItemCount - 1 do
    begin
      if ItemChecked(I) then
        AItems.Add(TCustomListBox(FEditControl).Items[I]);
    end;
  end;
  Result := AItems.Count > 0;
end;

function TJSCustomEditDialog.GetEditControl(Index: Integer): TControl;
begin
  result := FEditControl;
end;

function TJSCustomEditDialog.GetEditControlWidth: Integer;
var
  lControl: IJSEditDialogControl;
begin
  result := FForm.ClientWidth - LeftMargin - RightMargin;
  if (EditProperties.Coverage < 100) and (EditProperties.CoverageType = ctPercent) then
  begin
    result := Round((result) * (EditProperties.Coverage / 100));
  end
  else if EditProperties.CoverageType = ctPixels then
    result := EditProperties.Coverage;
  if Supports(FEditControl, IJSEditDialogControl, lControl) then
  begin
    result := Max(result, lControl.GetRequiredWidth);
    lControl.AdjustControlLayout(result);
  end;
end;

function TJSCustomEditDialog.GetEditPropertiesClass: TJSEditPropertiesClass;
begin
  Result := TJSEditProperties;
end;

function TJSCustomEditDialog.GetEditValue: TJSString;
begin
  if (FEditControl <> nil) then
  begin
    if (EditProperties.EditType <> etCustom) and
      (GetPropInfo(FEditControl, 'Text') <> nil) then
      Result := GetPropValue(FEditControl, 'Text')
    else if (EditProperties.EditType = etMemo) then
      Result := TMemo(FEditControl).Lines.Text
    else
      Result := DoGetEditValue;
  end
  else
    Result := '';
end;

function TJSCustomEditDialog.GetHeightForEditType: Integer;
begin
  result := DoGetControlHeight;
end;

function TJSCustomEditDialog.GetLeftPosition: Integer;
begin
  result := LeftMargin + 1;
  if (EditProperties.CoverageType = ctPercent) then
  begin
    if EditProperties.Coverage < 100 then
    begin
      result := FForm.ClientWidth - RightMargin - GetEditControlWidth;
    end;
  end
  else
  begin
    result := FForm.ClientWidth - RightMargin - EditProperties.Coverage;
  end;
end;

function GetTextHeight(AFont: TFont; const AWidth: Integer; const ACaption: string): Integer;
var
  LDC: HDC;
  LCanvas: TCanvas;
  LRect: TRect;
begin
  LCanvas := TCanvas.Create;
  try
    LDC := GetDC(0);
    try
      LCanvas.Handle := LDC;
      LCanvas.Font.Assign(AFont);
      LRect := Rect(0, 0, AWidth, 0);
      JSDrawText(LCanvas.Handle, ACaption, AFont, LRect, DT_LEFT or DT_WORDBREAK or DT_CALCRECT);
      Result := LRect.Bottom;
    finally
      ReleaseDC(0, LDC);
    end;
  finally
    LCanvas.Handle := 0;
    LCanvas.Free;
  end;
end;

function TJSCustomEditDialog.HeightAdjustment: Integer;
var
  LTextHeight: Integer;
begin
  result := inherited HeightAdjustment;
  if FForm <> nil then
  begin
    inc(result, GetHeightForEditType);
    inc(result, VertMargin);
    LTextHeight := GetTextHeight(Font, FForm.ClientWidth - LeftMargin - RightMargin, EditProperties.Caption);
    if FEditProperties.CaptionPosition = cpTop then
    begin
      inc(result, LTextHeight);
    end
    else
    begin
      if LTextHeight > GetHeightForEditType then
        inc(result, LTextHeight - GetHeightForEditType);
    end;
    if (doProgressBar in DialogOptions) or (doProgressBarMarquee in DialogOptions) or
      (doRadioButtons in DialogOptions) then
      inc(result, AFFS(8));
  end;
end;

procedure TJSCustomEditDialog.InitialiseEditControl(var AControl: TControl);
var
  lIntf: IJSEditDialogControl;
begin
  AControl.Height := GetHeightForEditType;
  if EditProperties.EditType = etComboBox then
  begin
    (AControl as TComboBox).Style := csDropDownList;
  end
  else if EditProperties.EditType = etListBox then
  begin
    if EditProperties.AllowDoubleClickToClose then
      (AControl as TListBox).OnDblClick := EditControlDblClickHandler;
  end
  else if EditProperties.EditType in [etDate, etTime, etCalendar] then
  begin
    if EditProperties.EditType = etCalendar then
    begin
      if EditProperties.AllowDoubleClickToClose then
        (AControl as TMonthCalendar).OnDblClick := EditControlDblClickHandler;
    end
    else if EditProperties.EditType = etTime then
    begin
      (AControl as TDateTimePicker).Kind := dtkTime;
    end;
  end;
  if GetPropInfo(AControl, 'MaxLength', tkProperties) <> nil then
    SetPropValue(AControl, 'MaxLength', EditProperties.MaxLength);
  if Supports(AControl, IJSEditDialogControl, lIntf) then
    lIntf.SetDialog(Self);
end;

function TJSCustomEditDialog.ItemChecked(const AValue: string): Boolean;
var
  LIdx: Integer;
begin
  result := False;
  if (EditProperties.EditType in [etListBox, etCheckListBox]) and (FEditControl <> nil) then
  begin
    LIdx := TCustomListBox(FEditControl).Items.IndexOf(AValue);
    result := ItemChecked(LIdx);
  end;
end;

function TJSCustomEditDialog.ItemCount: Integer;
begin
  result := 0;
  if (FEditControl <> nil) and (EditProperties.EditType in [etListBox, etCheckListBox]) then
  begin
    result := TCustomListBox(FEditControl).Items.Count;
  end;
end;

function TJSCustomEditDialog.ItemChecked(const AIndex: Integer): Boolean;
begin
  result := False;
  if (EditProperties.EditType in [etListBox, etCheckListBox]) and (FEditControl <> nil) and
    (TCustomListBox(FEditControl).Items.Count > AIndex) then
  begin
    result := TCheckListBox(FEditControl).Checked[AIndex];
  end;
end;

procedure TJSCustomEditDialog.PositionControls;
var
  lLeftPos: Integer;
  lTop: Integer;
  LControlHeight: Integer;
begin
  inherited;
  if FEditControl <> nil then
  begin
    lLeftPos := GetLeftPosition;
    LControlHeight := DoGetControlHeight;
    lTop := GetRect(psButtonBar).Top - LControlHeight - AFFS(8);
    DoAdjustTopValue(LTop);
    if EditProperties.CaptionVisible then
    begin
      // Calculate required height of label
      FEditLabel.Height := Max(GetTextHeight(FEditLabel.Font, FEditLabel.Width, FEditProperties.Caption), FEditLabel.Height);
      FEditLabel.Caption := FEditProperties.Caption;
      if EditProperties.CaptionPosition = cpTop then
        dec(lTop, FEditLabel.Height + AFFS(3))
      else
        inc(lTop, AFFS(3));
      if EditProperties.CaptionPosition = cpTop then
        FEditLabel.SetBounds(lLeftPos, lTop, FEditLabel.Width, FEditLabel.Height)
      else
      begin
        if FEditLabel.Height > LControlHeight then
          FEditLabel.SetBounds(lLeftPos, GetRect(psButtonBar).Top - FEditLabel.Height - AFFS(8), FEditLabel.Width, FEditLabel.Height)
        else
          FEditLabel.SetBounds(lLeftPos, lTop, FEditLabel.Width, FEditLabel.Height);
      end;
      inc(lLeftPos, AFFS(8) + FEditLabel.Width);
    end;
    if EditProperties.CaptionVisible and (EditProperties.CaptionPosition = cpTop) then
    begin
      inc(lTop, FEditLabel.Height + AFFS(3));
      lLeftPos := GetLeftPosition;
    end
    else
      dec(lTop, AFFS(3));

    if EditProperties.EditType = etHTML then
      (FEditControl as TWebBrowser).Navigate('about:blank');

    if EditProperties.CaptionVisible and (EditProperties.CaptionPosition = cpLeft) then
      FEditControl.SetBounds(lLeftPos, lTop, FForm.ClientWidth - RightMargin - lLeftPos, LControlHeight)
    else
      FEditControl.SetBounds(lLeftPos, lTop, GetEditControlWidth, LControlHeight);

    if (FEditLabel <> nil) and (FEditControl is TWinControl) then
      FEditLabel.FocusControl := FEditControl as TWinControl;
    if not FEditInitialised and Assigned(FOnInitialiseEdit) then
    begin
      FOnInitialiseEdit(Self, FEditControl, 0);
      FEditInitialised := True;
    end;
  end;
end;

procedure TJSCustomEditDialog.SetEditProperties(const Value: TJSEditProperties);
begin
  FEditProperties.Assign(Value);
end;

procedure TJSCustomEditDialog.SetEditValue(const AValue: TJSString);
begin
  DoUpdateEditControl(AValue, nil);
  if Assigned(OnSetEditValue) then
    OnSetEditValue(Self, FEditControl, -1, AValue);
end;

procedure TJSCustomEditDialog.UpdateValue(const AValue: TJSString; const AFocus, ASelect: Boolean);
begin
  if EditProperties.EditType = etEdit then
  begin
    (FEditControl as TEdit).Text := AValue;
    if AFocus then
      FForm.ActiveControl := FEditControl as TWinControl;
    if ASelect then
      (FEditControl as TEdit).SelectAll;
  end;
end;

function TJSCustomEditDialog.WidthAdjustment: Integer;
begin
  Result := LeftMargin + RightMargin + GetEditControlWidth;
end;

procedure TJSCustomEditDialog.CreateEditControl;
var
  lControlClass: TControlClass;
begin
  lControlClass := nil;
  DoGetEditControlClass(lControlClass);
  if lControlClass = nil then
    lControlClass := TEdit;
  FEditControl := lControlClass.Create(FForm);
  if FEditControl <> nil then
  begin
    FEditControl.Parent := FForm;
//    DoSetDefaultValue;
  end;
  if EditProperties.CaptionVisible then
  begin
    FEditLabel := TLabel.Create(FForm);
    if FEditControl is TWinControl then
      FEditLabel.FocusControl := FEditControl as TWinControl;
  end;
  if FEditLabel <> nil then
    FEditLabel.Parent := FForm;
  InitialiseEditControl(FEditControl);
//  DoSetDefaultValue;
end;

procedure TJSEditProperties.Assign(Source: TPersistent);
var
  lSrc: TJSEditProperties;
begin
  if Source is TJSEditProperties then
    lSrc := Source as TJSEditProperties
  else
    lSrc := nil;
  if lSrc = nil then
    inherited
  else
  begin
    FEditType := lSrc.EditType;
    FCaption := lSrc.Caption;
    FCaptionPosition := lSrc.CaptionPosition;
    FHeight := lSrc.Height;
    Items := lSrc.Items;
    FAllowDoubleClickToClose := lSrc.AllowDoubleClickToClose;
    FCoverageType := lSrc.CoverageType;
    FCoverage := lSrc.Coverage;
    FAllowActiveControl := LSrc.AllowActiveControl;
    DoChange;
  end;
end;

function TJSEditProperties.CaptionVisible: Boolean;
begin
  result := Length(trim(Caption)) > 0;
end;

constructor TJSEditProperties.Create;
begin
  inherited;
  FAllowDoubleClickToClose := True;
  FEditType := etEdit;
  FHeight := 100;
  FItems := TJSWideStringList.Create;
  FCoverageType := ctPercent;
  FCoverage := 100;
  FAllowActiveControl := True;
  FMaxLength := 0;
end;

destructor TJSEditProperties.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TJSEditProperties.SetCaption(const Value: TJSString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    DoChange;
  end;
end;

procedure TJSEditProperties.SetCaptionPosition(const Value: TJSCaptionPosition);
begin
  if FCaptionPosition <> Value then
  begin
    FCaptionPosition := Value;
    DoChange;
  end;
end;

procedure TJSEditProperties.SetEditType(const Value: TJSEditType);
begin
  if FEditType <> Value then
  begin
    FEditType := Value;
  end;
end;

procedure TJSEditProperties.SetHeight(const Value: Integer);
begin
  if FHeight <> Value then
  begin
    FHeight := Value;
    DoChange;
  end;
end;

procedure TJSEditProperties.SetItems(const Value: TJSStrings);
begin
  FItems.Assign(Value);
end;

procedure TJSEditProperties.SetValue(const Value: TJSString);
begin
  if FValue <> Value then
  begin
    FValue := Value;
    DoChange;
  end;
end;

end.
