unit LMD_RegMain;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMD-Tools Core Controls registration unit (RM)
----------------------------------------------
Registers components and editors for the LMD-Tools Core controls, which
replaces LMD-Tools SE product line from LMD-Tools 2007 on.

Changes
-------
Release 8.0 (August 2006)
 - Initial Release

December 2007
 - Edit Print Task added

###############################################################################}
interface

procedure Register;

{------------------------------------------------------------------------------}
implementation

uses
   Classes, Actnlist,
   DesignIntf, DesignEditors, VCLEditors,
   LMDGraph,
   // Standard
   LMDFaceController, LMDStaticText, LMDStyleMan,
   // Extended
   LMDClock, LMDLED, LMDLEDLabel, LMDLEDCustomLabel, LMDTechnicalLine, LMDButtonBar,
   LMDCal, LMDButtonBarPopupMenu, LMDNotebook, LMDPopupMenu, LMDDlgButtonPanel,
   LMDHeaderPanel, LMDHeaderPanelButton, LMDHeader, LMDPageControl, LMDCustomSwitch,
   LMDSwitch, LMDCustomLight, LMDLight, LMDCaptionPanel, LMDCaptionPanelGroup,
   LMDPanelCaptionObject, LMDSplt, LMDCalendar, LMDCalculator, LMDAssist, LMDFill,
   LMDFlyoutController,
   // Container
   LMDGenericList, LMDStackComponent, LMDQueueComponent, LMDListComponent,
   LMDMMButtonFaceController,
   // Dialogs
   LMDAboutDlg, LMDDirDlg, LMDTipDlg, LMDWindowListDlg,
   LMDBaseDialog, LMDInputDlg, LMDCheckListDlg, LMDCalendarDlg, LMDCalculatorDlg,
   LMDTextEditDlg, LMDDlgEx, LMDMsg,
    // LMD HTML
    LMDHTMLHeaderControl, LMDHTMLExtListBox, LMDHTMLComboBox, LMDHTMLListBox, LMDHTMLListBoxExt,
   // Edit Controls
   LMDCalendarEdit, LMDCalculatorEdit, LMDExtSpinEdit, LMDEditActions, LMDEditAutoComplete, 
   LMDDateTimePicker,
   LMDTagEditor,
   // List controls
   LMDListComboBox, LMDHeaderListComboBox, LMDTreeComboBox, LMDCheckListComboBox,
   LMDTrackBarComboBox, LMDDriveComboBox,
   LMDCalendarComboBox, LMDCalculatorComboBox,
   LMDFormComboBox,
   // Form Controls
   LMDFormShape, LMDFormShadow, LMDCaptionButtons, LMDSysMenu, LMDFormA,
   LMDFormstyler, LMDBack, LMDFormFill, LMDCustomFormFill,
   // MM Controls
   LMDAniCtrl, LMDScrollText, LMDGraphicLabel, LMDLabelFill, LMDCustomLabelFill,
   LMDTeeth, LMDShape, LMDBaseShape, LMDShapeControl,  LMDSimpleBevel, LMDShapeButton,
   LMDWndButtonShape, LMDPanelShape, LMD3DEffectButton, LMDRepeatedShape,
   LMDCustom3DButton, LMDCustomMMButton, LMDMMButton, LMDTimer,
   // Sys Controls
   LMDExpressionEval, LMDRegExpr, LMDTxtPrinter, LMDCustomShapeHint,
   LMDSendKeys, LMDAlarmComponent, LMDHideNonVC, LMDGlobalHotkey,
   // Print Tasks
   LMDEditPrintTask,
   // Editors
   pLMDStyleManProp, pLMDCommon, pLMDCEMain, pLMDPEMain, pLMDPECore
   {$IFDEF LMDCOMP17},Actions{$ENDIF};

{------------------------------------------------------------------------------}
procedure Register;
begin

  {Standard controls}
  {****************************************************************************}
  RegisterComponents('LMD Std', [
                     TLMDFaceController,
                     TLMDStaticText,
                     TLMDStyleManager
                    ]);

  {TLMDStyleManager}
  RegisterComponentEditor(TLMDStyleManager, TLMDStyleManEditor);
  {TLMDFaceController}
  RegisterComponentEditor(TLMDFaceController, TLMDFaceControllerEditor);

  {Extended controls}
  {****************************************************************************}
  RegisterComponents('LMD Ext', [
                     TLMDAssist,
                     TLMDClock,
                     TLMDButtonBar,
                     TLMDButtonBarPopupMenu,
                     // 6.X
                     TLMDDlgButtonPanel,
                     TLMDNoteBook,

                     // ---
                     TLMDCalendar,
                     TLMDCalculator,
                     // 7.0
                     TLMDCaptionPanelGroup,
                     TLMDCaptionPanel,
                     // ---
                     TLMDHeaderPanel,
                     TLMDHeaderPanelButton,
                     TLMDHeader,
                     TLMDTechnicalLine,
                     TLMDClock,
                     TLMDLEDLabel,
                     TLMDSwitch,
                     TLMDWSwitch,
                     TLMDLight,
	                 TLMDFlyoutController
                    ]);

  {TLMDAssist}
  RegisterComponentEditor(TLMDAssist, TLMDAssistComponentEditor);
  RegisterComponentEditor(TLMDAssistPage, TLMDAssistComponentEditor);
  {TLMDLED}
  RegisterPropertyEditor( TypeInfo( TLMDLED ), nil, '', TLMDLEDProperty);
  {TLMDLEDCustomLabel}
  RegisterComponentEditor(TLMDLEDCustomLabel, TLMDLEDLabelComponentEditor);
  {TLMDClock}
  RegisterComponentEditor(TLMDClock, TLMDClockComponentEditor);
  {TLMDTechnicalLine}
  RegisterComponentEditor (TLMDTechnicalLine, TLMDTechnicalLineComponentEditor);
  //4.1
  {TLMDButtonBar}
  RegisterPropertyEditor(TypeInfo(TCollection), TLMDButtonBar, 'Sections', TLMDButtonBarCollectionProperty);
  RegisterComponentEditor (TLMDButtonBar, TLMDButtonBarComponentEditor);
  //6.0
  //TLMDDlgButtonPanel
  RegisterComponentEditor(TLMDDlgButtonPanel, TLMDDlgButtonComponentEditor);
  //TLMDNoteBook
  RegisterPropertyEditor(TypeInfo( TLMDNoteBookPage), nil, '', TLMDNoteBookPageProperty);
  RegisterComponentEditor(TLMDNoteBook, TLMDNoteBookComponentEditor);
  RegisterComponentEditor(TLMDNoteBookPage, TLMDNoteBookComponentEditor);

  {TLMDCustomSwitch}
  RegisterComponentEditor(TLMDCustomSwitch, TLMDSwitchComponentEditor);
  {TLMDLightColor}
  RegisterPropertyEditor( TypeInfo( TLMDLightColor ), nil, '', TLMDLightColorProperty);
  {TLMDCustomLight}
  RegisterComponentEditor(TLMDCustomLight, TLMDLightComponentEditor);
  {TLMDFill}
  RegisterComponentEditor(TLMDFill, TLMDFillComponentEditor);
  // 7.0
  {TLMDCaptionPanel}
  RegisterPropertyEditor(TypeInfo(TLMDPanelCaptionObject), TLMDCaptionPanel, '', TLMDPanelCaptionProperty);
  RegisterComponentEditor(TLMDCaptionPanelGroup, TLMDCaptionPanelGroupEditor);
  RegisterComponentEditor(TLMDCaptionPanel, TLMDCaptionPanelGroupEditor);
  RegisterPropertyEditor(TypeInfo(Boolean), TLMDCaptionPanel, 'AutoSize', nil);  // Hide AutoSize property

  {Container controls}
  {****************************************************************************}
  RegisterComponents('LMD Cont', [
                      TLMDStackComponent,
                      TLMDQueueComponent,
                      TLMDListComponent,
                      TLMDMMButtonFaceController
                     ]);

  {TLMDButtonFaceController}
  RegisterComponentEditor(TLMDMMButtonFaceController, TLMDButtonFaceControllerEditor);

  {Dialog controls}
  {****************************************************************************}
  RegisterComponents('LMD Dlg', [
                      TLMDAboutDlg,
                      TLMDDirDlg,
                      TLMDTipDlg,
                      TLMDWindowListDlg,
                      TLMDMessageBoxDlg,
                      TLMDInputDlg,
                      TLMDCheckListDlg,
                      TLMDCalendarDlg,
                      TLMDCalculatorDlg,
                      TLMDTextEditDlg,
                      //4.01
                      TLMDFormOpenDialog,
                      TLMDFormSaveDialog,
                      TLMDFormColorDialog,
                      TLMDFormFontDialog,
                      TLMDFormPageSetupDialog,
                      TLMDFormPrinterSetupDialog,
                      TLMDFormPrintCommDialog,
                      TLMDFormFolderDialog
                      , TLMDFormChangeIconDialog
                       , TLMDFormInsertObjectDialog
                      ]);

  {TLMDMessage}
  RegisterComponentEditor(TLMDMessageBoxDlg, TLMDMessageBoxComponentEditor);
  {Editor for Dialog controls}
  RegisterComponentEditor(TLMDBaseDialog, TLMDExtDlgEditor);

  {Edit controls}
  {****************************************************************************}
  RegisterComponents('LMD Edit', [
                      TLMDCalendarEdit,
                      TLMDCalculatorEdit,
                      TLMDEditAutoComplete,
                      TLMDTagEditor,
                      TLMDEditControlPrintTask,
                      TLMDDateTimePicker,
                      TLMDFormComboBox
                     ]);

  if leoInstallLabeledControls in LMDTOOLSEDITOROPTIONS then
    RegisterComponents('LMD Labeled', [
                        TLMDLabeledCalendarEdit,
                        TLMDLabeledCalculatorEdit
                       ]);

  RegisterActions('LMDEdit', [ TLMDEditCut, TLMDEditCopy, TLMDEditPaste,
                               TLMDEditSelectAll, TLMDEditUndo, TLMDEditRedo,
                               TLMDEditDelete, TLMDEditFind, TLMDEditReplace] , nil);

  {ListBox Controls}
  {****************************************************************************}
  RegisterComponents('LMD List', [
                      TLMDDriveComboBox,
                      TLMDListComboBox,
                      TLMDTreeComboBox,
                      TLMDHeaderListComboBox,
                      TLMDCheckListComboBox,
                      TLMDCalculatorComboBox,
                      TLMDCalendarComboBox,
                      TLMDTrackBarComboBox
                     ]);

  if leoInstallLabeledControls in LMDTOOLSEDITOROPTIONS then
    RegisterComponents('LMD Labeled', [
                        TLMDLabeledListComboBox,
                        TLMDLabeledDriveComboBox,
                        TLMDLabeledCalculatorComboBox,
                        TLMDLabeledTrackBarComboBox,
                        TLMDLabeledCalendarComboBox,
                        TLMDLabeledHeaderListComboBox,
                        TLMDLabeledCheckListComboBox,
                        TLMDLabeledTreeComboBox
                        ]);

  {Form Controls}
  {****************************************************************************}
  RegisterComponents('LMD Form', [
                      TLMDForm,
                      TLMDBack,
                      TLMDFormFill,
                      TLMDFormStyler,
                      TLMDFormShadow,
                      TLMDFormShape,
                      TLMDSysMenu,
                      TLMDCaptionButtons
                     ]);

  {TLMDFormStyler}
  RegisterComponentEditor(TLMDFormStyler, TLMDFormStylerComponentEditor);
  {TLMDCustomFormFill}
  RegisterComponentEditor(TLMDCustomFormFill, TLMDFormFillComponentEditor);
  {TLMDShadow}
  RegisterComponentEditor(TLMDFormShadow, TLMDShadowComponentEditor);
  // 4.01
  RegisterComponentEditor (TLMDFormShape, TLMDFormShapeComponentEditor);

  {MM Controls}
  {****************************************************************************}
  RegisterComponents('LMD MM', [
                      TLMDLabelFill,
                      TLMDGraphicLabel,
                      TLMDScrollText,
                      TLMDMMButton,
                      TLMDShapeButton,
                      TLMD3DEffectButton,
                      TLMDHiTimer,
                      TLMDShapeControl,
                      TLMDRepeatedShape,
                      TLMDAniCtrl,
                      TLMDPanelShape,
                      TLMDWndButtonShape
                      ]);

  {TLMDLabelFill}
  RegisterComponentEditor(TLMDAniCtrl, TLMDAniCtrlComponentEditor);
  {TLMDLabelFill}
  RegisterComponentEditor(TLMDCustomLabelFill, TLMDLabelFillComponentEditor);
  {TLMDGraphicLabel}
  RegisterComponentEditor (TLMDGraphicLabel, TLMDGraphicLabelComponentEditor);
  {TLMDBaseShape}
  RegisterComponentEditor(TLMDBaseShape, TLMDCustomShapeComponentEditor);
  {TLMDWndButtonShape}
  RegisterComponentEditor (TLMDWndButtonShape, TLMDWndButtonShapeComponentEditor);
  {TLMDPanelShape}
  RegisterComponentEditor (TLMDPanelShape, TLMDPanelShapeComponentEditor);
  {TLMDScrollText}
  RegisterComponentEditor (TLMDScrollText, TLMDScrollTextComponentEditor);
  {Extended Button Editors}
  RegisterComponentEditor (TLMDCustom3DButton, TLMDExtGraphicButtonComponentEditor);
  RegisterComponentEditor (TLMDCustomMMButton, TLMDExtGraphicButtonComponentEditor);

  {System Controls}
  {****************************************************************************}
  RegisterComponents('LMD Sys', [
                      TLMDHideNonVC,
                      TLMDAlarmComponent,
                      TLMDSendKeys,
                      TLMDGlobalHotkey,
                      TLMDTxtPrinter,
                      TLMDPopupMenu,
                      TLMDRegExpr,
                      TLMDExpressionEval
                      ]);

  RegisterComponentEditor(TLMDHideNonVC, TLMDHideNonVCEditor);
  {TLMDShapeHint}
  RegisterComponentEditor(TLMDCustomShapeHint, TLMDShapeHintComponentEditor);
   // 5.0
  RegisterComponentEditor (TLMDSendKeys, TLMDSendKeyComponentEditor);

  {HTML Controls}
  {****************************************************************************}
  RegisterComponents('LMD HTML', [
                      TLMDHTMLExtListBox,
                      TLMDHTMLComboBox,
                      TLMDHTMLListBox,
                      TLMDHTMLListBoxExt,
                      TLMDHTMLHeaderControl
                    ]);

end ;

initialization

end.
