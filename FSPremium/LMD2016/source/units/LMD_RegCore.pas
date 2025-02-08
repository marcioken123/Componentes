unit LMD_RegCore;
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
Registers components and editors for the LMD-Tools Core controls set, which
replaces LMD-Tools SE product line from LMD-Tools 2007 on.


Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface

procedure Register;

{------------------------------------------------------------------------------}
implementation

uses
  Classes, Controls,
  FiltEdit, DesignIntf, DesignEditors, VCLEditors,
  {base unit for all versions}
  LMDBase, LMDClass, LMDGraph, LMDCustomComponent,
  // Standard
  LMDBaseLabel, LMDProgress, LMDBiProgressBar, LMDBaseGraphicButton, LMDCustomButton,
  LMDDrawEdge, LMDInformationLabel, LMDSimplePanel, LMDBackPanel, LMDFillObject,
  LMDGradient, LMDShapeFill, LMDBevel, LMDShadow, LMDGlyphTextLayout, LMDButtonLayout,
  LMD3DCaption, LMDFXCaption, LMDSmallBar, LMDSimpleLabel, LMDLabel, LMDDockLabel,
  LMDGlyphLabel, LMDSpeedButton, LMDDockSpeedButton, LMDButtonControl, LMDButton,
  LMDGroupBox, LMDRadioGroup, LMDCheckGroup, LMDCustomButtonGroup, LMDDockButton,
  LMDCheckBox, LMDRadioButton, LMDSBar, LMDBoundLabel, LMDHTMLLabel, LMDHeaderControl, LMDComboBoxExt, LMDToolBar,
  // Extended
  LMDProgressFill, LMDCustomTrackBar, LMDCustomBiTrackBar, LMDStatusBar, LMDButtonPanel,
  LMDFill, LMDTrackBar, LMDBiTrackBar, LMDPanelFill, LMDShadowFill, LMDFormDisplay,
  LMDCustomLImage, LMDCustomNImage, LMDFormTabControl, LMDNImage, LMDFlowPanel,
  LMDLImage, LMDTransparent, LMDScrollBox, LMDScrollBoxExt, LMDCaption, LMDSplt, LMDPageControl,
  // Container
  LMDStrList, LMDCont, LMDWave, LMDWaveComp, LMDImageList, LMDImageListConnector,
  LMDBitmapList,
  LMDStringList, LMDWaveList,
  LMDImageListVCLConnector,
  // Edit controls
  LMDCustomMemo, LMDMemo, LMDEdit, LMDBaseEdit, LMDCustomMaskEdit, LMDMaskEdit,
  LMDSpinEdit, LMDCustomFileEdit, LMDBrowseEdit, LMDColorEdit, LMDFileOpenEdit,
  LMDFileSaveEdit, LMDExtSpinEdit,
  // List Controls
  LMDListBox, LMDComboBox, LMDImageListBox, LMDImageComboBox, LMDFontComboBox, LMDListBoxExt,
  LMDPrinterComboBox, LMDColorComboBox, LMDFontSizeComboBox, LMDColorListBox,
  LMDCustomListBox, LMDExtListBox, LMDFontListBox, LMDCheckListBox, LMDFontSizeListBox,
  // MM Controls
  LMDButtonBase, LMDTimer,
  // LMD Sys
  LMDApplicationCtrl, LMDSysInfo, LMDStopWatch, LMDOneInstance,
  LMDIniCtrl, LMDMRUList, LMDMousePositioner, LMDTrayIcon,
  LMDMouseFencer, LMDHint, LMDShapeHint, LMDCustomShapeHint,
  LMDMessageHint, LMDMessageHintController, LMDTripleClick,
  // Validators
  LMDHintErrorProvider,
  // Component Editors
  pLMDCECore, pLMDPECore, pLMDCommon, pLMDToolBarEditorDlg;

{------------------------------------------------------------------------------}
procedure Register;
begin

  // Connect TLMDCustomComponent with TWinControl -> no longer appears on CLX palette.
  GroupDescendentsWith(TLMDCustomComponent, TWinControl);

  {Standard controls}
  {****************************************************************************}
  RegisterComponents('LMD Std', [
                     TLMDSimpleLabel,
                     TLMDLabel,
                     TLMDDockLabel,
                     TLMDGlyphLabel,
                     TLMDInformationLabel,
                     TLMDSpeedButton,
                     TLMDDockSpeedButton,
                     TLMDButton,
                     TLMDDockButton,
                     TLMDSimplePanel,
                     TLMDBackPanel,
                     TLMDDrawEdge,
                     TLMDProgress,
                     TLMDGroupBox,
                     TLMDCheckBox,
                     TLMDRadioButton,
                     TLMDRadioGroup,
                     TLMDCheckGroup,
                     TLMDScrollBar,
                     TLMDHeaderControl
                    ]);

  {Labels}
  RegisterComponentEditor(TLMDBaseLabel, TLMDLabelComponentEditor);
  {TLMDInformationLabel}
  RegisterComponentEditor (TLMDInformationLabel, TLMDInfoLabelComponentEditor);
  {TLMDBaseGraphicButton}
  RegisterComponentEditor(TLMDBaseGraphicButton, TLMDBaseGraphicButtonComponentEditor);
  {HTML-Labels}
  RegisterComponentEditor(TLMDHTMLLabel, TLMDHTMLLabelComponentEditor);
  {TLMDCustomButton}
  RegisterComponentEditor(TLMDCustomButton, TLMDCustomButtonComponentEditor);
  {TLMDDrawEdge}
  RegisterComponentEditor(TLMDDrawEdge, TLMDDrawEdgeComponentEditor);
  {TLMDSimplePanel}
  RegisterComponentEditor(TLMDSimplePanel, TLMDSimplePanelComponentEditor);
  {TLMDBackPanel}
  RegisterComponentEditor(TLMDBackPanel, TLMDBackPanelComponentEditor);
  {TLMDProgress}
  RegisterComponentEditor(TLMDProgress, TLMDProgressComponentEditor);
  {TLMDCustomButtonGroup}
  RegisterComponentEditor (TLMDCustomButtonGroup, TLMDCustomButtonGroupComponentEditor);
  {TLMDGroupBox}
  RegisterComponentEditor (TLMDGroupBox, TLMDGroupBoxComponentEditor);
  {TLMDRadioButton, TLMDCheckBox}
  RegisterComponentEditor (TLMDButtonControl, TLMDButtonControlComponentEditor);
  {TLMDScrollBar}
  RegisterComponentEditor(TLMDScrollBar, TLMDScrollBarComponentEditor);

  {Extended controls}
  {****************************************************************************}
  RegisterComponents('LMD Ext', [
                     TLMDToolBar,
                     TLMDTrackBar,
                     TLMDBiTrackBar,
                     TLMDStatusBar,
                     TLMDPageControl,
                     TLMDTabControl,
                     TLMDSplitterPanel,
                     TLMDButtonPanel,
                     TLMDScrollBox,
                     TLMDFormDisplay,
                     TLMDFormTabControl,
                     TLMDLImage,
                     TLMDNImage,
                     TLMDFlowPanel,
                     TLMDFill,
                     TLMDPanelFill,
                     TLMDShadowFill,
                     TLMDProgressFill,
                     TLMDBiProgressBar,
                     TLMDScrollBoxExt
                     ]);

  // TLMDFlowPanel
  RegisterNoIcon([TLMDFlowPanelSeparator]);
  RegisterComponentEditor(TLMDFlowPanel, TLMDFlowPanelEditor);
  {TLMDCustomTrackBar}
  RegisterComponentEditor (TLMDCustomTrackBar, TLMDTrackBarComponentEditor);
  {TLMDCustomLImage}
  RegisterComponentEditor(TLMDCustomLImage, TLMDCustomLImageComponentEditor);
  {TLMDCustomNImage}
  RegisterComponentEditor(TLMDCustomNImage, TLMDNImageComponentEditor);
  {TLMDPanelFill}
  RegisterComponentEditor(TLMDPanelFill, TLMDPanelFillComponentEditor);
  {TLMDStatusBar}
  RegisterComponentEditor (TLMDStatusBar, TLMDStatusBarComponentEditor);
  {TLMDFormDisplay}
  RegisterComponentEditor(TLMDFormDisplay, TLMDFormDisplayComponentEditor);
  {TLMDProgressFill}
  RegisterComponentEditor(TLMDProgressFill, TLMDProgressFillComponentEditor);
  {TLMDShadowFill}
  RegisterComponentEditor(TLMDShadowFill, TLMDShadowFillComponentEditor);
  {TLMDSplitter}
  RegisterComponentEditor(TLMDSplitterPane, TLMDSplitterPaneEditor);
  RegisterComponentEditor(TLMDSplitterPanel, TLMDSplitterPanelEditor);
  {TLMDButtonPanel}
  RegisterComponentEditor(TLMDButtonPanel, TLMDButtonPanelEditor);
  {TLMDToolbar}
  RegisterComponentEditor(TLMDToolBar, TLMDToolBarEditor);
  // 6.1
  // TLMDPageControl
  RegisterNoIcon([TLMDTabSheet]);
  RegisterPropertyEditor(TypeInfo( TLMDTabSheet), nil, '', TLMDTabSheetProperty);
  RegisterComponentEditor(TLMDPageControl, TLMDPageControlEditor);
  RegisterComponentEditor(TLMDTabSheet, TLMDPageControlEditor);

  {Container controls}
  {****************************************************************************}
  RegisterComponents('LMD Cont', [
                      TLMDImageListVCLConnector,
                      TLMDStrList,
                      TLMDWaveComp
                     ]);
  {TLMDWaveComp}
  RegisterComponentEditor(TLMDWaveComp, TLMDWaveEditor);

  {Edit controls}
  {****************************************************************************}
  RegisterComponents('LMD Edit', [
                      TLMDEdit,
                      TLMDMemo,
                      TLMDMaskEdit,
                      TLMDSpinEdit,
                      TLMDExtSpinEdit,
                      TLMDBrowseEdit,
                      TLMDColorEdit,
                      TLMDFileOpenEdit,
                      TLMDFileSaveEdit
                     ]);

  {TLMDBaseEdit}
  RegisterComponentEditor(TLMDBaseEdit, TLMDEditComponentEditor);
  {TLMDCustomMemo}
  RegisterComponentEditor(TLMDCustomMemo, TLMDMemoComponentEditor);
  {TLMDCustomFileEdit}
  RegisterPropertyEditor(TypeInfo(String), TLMDCustomFileEdit, 'Filter', TFilterProperty);

  if leoInstallLabeledControls in LMDTOOLSEDITOROPTIONS then
    RegisterComponents('LMD Labeled', [
                        TLMDLabeledEdit,
                        TLMDLabeledMaskEdit,
                        TLMDLabeledExtSpinEdit,
                        TLMDLabeledMemo,
                        TLMDLabeledColorEdit,
                        TLMDLabeledBrowseEdit,
                        TLMDLabeledFileOpenEdit,
                        TLMDLabeledFileSaveEdit
                       ]);

  {ListBox Controls}
  {****************************************************************************}
  RegisterComponents('LMD List', [
                      TLMDListBox,
                      TLMDImageListBox,
                      TLMDExtListBox,
                      TLMDCheckListBox,
                      TLMDColorListBox,
                      TLMDComboBox,
                      TLMDImageComboBox,
                      TLMDColorComboBox,
                      TLMDFontComboBox,
                      TLMDFontSizeComboBox,
                      TLMDPrinterComboBox,
                      TLMDFontListBox,
                      TLMDFontSizeListBox,
                      TLMDListBoxExt,
                      TLMDComboBoxExt
                     ]);

  {TLMDColorComboBox}
  RegisterComponentEditor(TLMDColorComboBox, TLMDColorComboBoxComponentEditor);
  {TLMDFontComboBox}
  RegisterComponentEditor(TLMDFontComboBox, TLMDFontComboBoxComponentEditor);
  {TLMDFontSizeComboBox}
  RegisterComponentEditor(TLMDFontSizeComboBox, TLMDFontSizeComboBoxComponentEditor);
  {TLMDImageComboBox}
  RegisterComponentEditor(TLMDImageComboBox, TLMDImageComboBoxComponentEditor);
  {TLMDImageListBox}
  RegisterComponentEditor(TLMDImageListBox, TLMDImageListBoxComponentEditor);
  {TLMDCustomListBox}
  RegisterComponentEditor(TLMDCustomListBox, TLMDCustomListBoxComponentEditor);
  {TLMDListBox}
  RegisterComponentEditor(TLMDListBox, TLMDListBoxComponentEditor);

  if leoInstallLabeledControls in LMDTOOLSEDITOROPTIONS then
    RegisterComponents('LMD Labeled', [
                        TLMDLabeledComboBoxExt,
                        TLMDLabeledColorComboBox,
                        TLMDLabeledFontComboBox,
                        TLMDLabeledFontSizeComboBox,
                        TLMDLabeledImageComboBox,
                        TLMDLabeledPrinterComboBox,
                        TLMDLabeledCheckListBox,
                        TLMDLabeledExtListBox,
                        TLMDLabeledImageListBox,
                        TLMDLabeledFontListBox,
                        TLMDLabeledFontSizeListBox
                        ]);

  {System controls}
  {****************************************************************************}
  RegisterComponents('LMD Sys', [
                      TLMDTimerPool,
                      TLMDMRUList,
                      TLMDStopWatch,
                      TLMDOneInstance,
                      TLMDSysInfo,
                      TLMDHint,
                      TLMDShapeHint,
                      TLMDMessageHint,
                      TLMDMessageHintController,
                      TLMDMousePositioner,
                      TLMDMouseFencer,
                      TLMDTripleClick,
                      TLMDTrayIcon
                    ]);

  {TLMDMousePositioner}
  RegisterComponentEditor(TLMDMousePositioner, TLMDMousePosEditor);
  {TLMDHint}
  RegisterComponentEditor(TLMDHint, TLMDHintComponentEditor);

  {Validator Controls}
  {****************************************************************************}
  RegisterComponents('LMD Validators', [
                      TLMDHintErrorProvider
                    ]);

  {HTML Controls}
  {****************************************************************************}
  RegisterComponents('LMD HTML', [
                      TLMDHTMLLabel
                    ]);
end ;
initialization

end.
