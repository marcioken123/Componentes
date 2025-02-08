unit LMD_RegElCore;
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

_LMD_RegElCore unit
--------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

  {$R 'LMDElPack.dcr'}

interface

procedure Register;

implementation

uses
  Classes,
  SysUtils,
  Forms,
  Controls,
  ImgList,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  LMDTypes,
  LMDUnicodeStrings,
  ElHeader,
  ElTree,
  ElTreeInplaceEditors,
  ElXTree,
  ElXHeader,
  ElMathParser,
  ElRegExpr,
  ElExpressionEval,

  ElScrollBar,
  ElTreeGrids,
  ElTreeStdEditors,
  ElTreeModalEdit,
  ElStyleMan,
  ElTreeAdvEdit,
  ElTreeBtnEdit,
  ElTreeCheckBoxEdit,
  ElTreeComboBox,
  ElTreeCurrEdit,
  ElTreeDTPickEdit,
  ElTreeMaskEdit,
  ElTreeColorCombo,
  ElTreeMemoEdit,
  ElTreeSpinEdit,
  ElTreeTreeComboEdit,
  ElTreeMemoComboEdit,

  ElACtrls,
  ElAppBar,
  ElBiProgr,
  ElBtnEdit,
  ElHotKey,
  ElCalendar,
  ElCalendDlg,
  ElCaption,
  ElCheckCtl,
  ElClrCmb,
  ElClock,
  ElDailyTip,
  ElEdits,
  ElInputDlg,
  ElDragDrop,
  ElFlatCtl,
  ElFrmPers,
  ElGraphs,
  ElHook,
  ElHstgrm,
  ElGauge,
  ElImgLst,
  ElIni,
  ElMemoCombo,
  ElMRU,
  ElOneInst,
  ElPanel,
  ElPopBtn,
  ElCheckItemGrp,
  ElImgCombo,
  ElTopmost,
  ElTrackBar,
  ElDriveCombo,
  ElFontCombo,
  ElFontListBox,
  ElScrollBox,
  ElExpBar,
  ElListBox,
  ElSideBar,
  ElSndMap,
  ElSpinBtn,
  ElSpin,
  ElStatBar,
  ElSysHotKey,
  ElPgCtl,
  ElMenuBar,
  ElToolBar,
  ElTray,
  ElTreeCombo,
  ElVerInfo,
  ElURLLabel,
  ElTimers,
  ElMouseHint,
  ElSplit,
  ElImgFrm,
  ElMaskEdit,
  ElNameEdits,
  ElAdvPanel,
  ElHTMLPanel,
  ElCombos,
  ElStrPool,
  ElStrArray,
  ElPromptDlg,
  ElLabel,
  ElFolderDlg,
  ElTrayInfo,
  ElHTMLLbl,
  ElHTMLHint,
  HTMLLbx,
  ElHTMLView,
  ElDTPick,
  ElGroupBox,
  Menus,
  ElMenus,
  ElClipMon,
  ElIPEdit,
  ElCurrEdit,
  ElCalc,
  ElCalculatorEdit,
  ElPowerMan,
  ElHTMLContainer,
  pLMDElFormPers,
  pLMDElSoundMap,
  pLMDElImgListEdit,
  pLMDElStrPoolEdit,
  pLMDElMenuDsgn,
  pLMDElMlCapProp,
  pLMDElItemsProp,
  pLMDElXItemsProp,
  pLMDElSectProp,
  pLMDElStyleManProp,
  ElVCLUtils,
  ElFormContainer,
  ElFormDisplay,
  ElFormPgCtl,
  ElComponent,
  {$ifdef lmdcomp12}LMDPNGImage, PNGImage, pLMDDsgnCPGetX, pLMDPeX,{$endif}
  pLMDElCE,
  pLMDElPE;

{------------------------------------------------------------------------------}
procedure Register;
begin
  GroupDescendentsWith(TElHTMLHint, TWinControl);
  GroupDescendentsWith(TElMRU, TWinControl);
  GroupDescendentsWith(TElTreeInplaceEditor, TWinControl);
  // Component Registration
  // ======================

  // Tab ElPack Std
  RegisterComponents('ElPack Std',     [TElStyleManager,
                                        TElLabel,
                                        TElPanel,
                                        TElGroupBox,
                                        TElCheckBox,
                                        TElBiProgressBar,
                                        TElSpinButton,
                                        TElSpeedButton,
                                        TElPopupButton,
                                        TElGraphicButton,
                                        TElRadioButton,
                                        TElCheckGroup,
                                        TElRadioGroup,
                                        TElMenuBar,
                                        TElMainMenu,
                                        TElPopupMenu,
                                        TElScrollBar
                                       ]);

  RegisterComponents('ElPack Ext',      [
                                        TElHeader,
                                        TElXHeader,
                                        TElPageControl,
                                        TElCalendar,
                                        TElToolBar,
                                        TElStatusBar,
                                        TElSideBar,
                                        TElExplorerBar,
                                        TElGauge,
                                        TElHistogram,
                                        TElGraph,
                                        TElTrackBar,
                                        TElSplitter,
                                        TElDragDrop,
                                        TElClock,
                                        TElScrollBox,
                                        TElFormContainer,
                                        TElFormDisplay,
                                        TElFormPageControl
                                        ]);

  // Tab ElTree Editors
  RegisterComponents('ElPack Tree',    [
                                        TElXTree,
                                        TElTreeInplaceEdit,
                                        TElTreeInplaceMemo,
                                        TElTreeInplaceCheckBox,
                                        TElTreeInplaceComboBox,
                                        TElTreeInplaceDateTimePicker,
                                        TElTreeInplaceModalEdit,
                                        TElTreeInplaceAdvancedEdit,
                                        TElTreeInplaceButtonEdit,
                                        TElTreeInplaceCheckBoxEdit,
                                        TElTreeInplaceCurrencyEdit,
                                        TElTreeInplaceMaskEdit,
                                        TElTreeInplaceMemoEdit,
                                        TElTreeInplaceSpinEdit,
                                        TElTreeInplaceColorCombo,
                                        TElTreeInplaceFloatSpinEdit,
                                        TElTreeInplaceTreeComboEdit,
                                        TElTreeInplaceMemoComboEdit,
                                        TElTree,
                                        TElTreeStringGrid
                                        ]);

  // Tab ElPack Edit
  RegisterComponents('ElPack Edit',    [
                                        TElEdit,
                                        TElMemo,
                                        TElDateTimePicker,
                                        TElButtonEdit,
                                        TElSpinEdit,
                                        TElFloatSpinEdit,
                                        TElMaskEdit,
                                        TElCurrencyEdit,
                                        TElIPEdit,
                                        TElFileNameEdit,
                                        TElFolderNameEdit,
                                        TElHotKey,
                                        TElCalculatorEdit,
                                        TElAdvancedEdit,
                                        TElAdvancedMemo
                                        ]);
  // Tab ElPack List & Combo
  RegisterComponents('ElPack List',    [
                                        TElListBox,
                                        TElComboBox,
                                        TElColorCombo,
                                        TElDriveComboBox,
                                        TElImageComboBox,
                                        TElTreeCombo,
                                        TElMemoCombo,
                                        TElFontComboBox,
                                        TElFontListBox,
                                        TElAdvancedListBox,
                                        TElAdvancedComboBox
                                        ]);

  RegisterComponents('ElPack Tools',   [
                                        TElIniFile,
                                        TElMRU,
                                        TElStringPool,
                                        TElOneInstance,
                                        TElSysHotKey,
                                        TElTrayIcon,
                                        TElFormCaption,
                                        TElFormPersist,
                                        TElImageList,
                                        TElVersionInfo,
                                        TElSoundMap,
                                        TElMouseHint,
                                        TElExpressionEval,
                                        TElRegExpr,
                                        TElDropTarget,
                                        TElHook,
                                        TElTimerPool,
                                        TElImageForm,
                                        TElTrayInfo,
                                        TElClipboardMonitor,
                                        TElStyleController,
                                        TElFlatController,
                                        TElFlatMultiController,
                                        TElPowerManager,
                                        TElTopmost,
                                        TElAppBar,
                                        TElURLLabel
                                        ]);

  RegisterComponents('ElPack Dlg',     [
                                        TElPromptDialog,
                                        TElFolderDialog,
                                        TElDailyTipDialog,
                                        TElCalendarDialog,
                                        TElInputDialog,
                                        TElCalculatorDialog
                                       ]);

  RegisterComponents('ElPack HTML',    [
                                        TElHTMLHint,
                                        TElAdvancedPanel,
                                        TElHTMLLabel,
                                        TElHTMLListBox,
                                        TElHTMLComboBox,
                                        TElHTMLView,
                                        TElHTMLPanel,
                                        TElHTMLContainer
                                        ]);

  // Invisible Classes
  // ===========================================================================
  RegisterNoIcon([TElToolButton]);
  Classes.RegisterClass(TElToolButton);
  RegisterClass(TElTreeInplaceEditor);
  RegisterNoIcon([TElMenuItem]);
  RegisterComponentEditor(TElExplorerBar, TElExplorerBarEditor);
  RegisterNoIcon([TElExplorerBarGroup]);
  RegisterClass(TElExplorerBarGroup);

  // Property and Component Editors
  // ===========================================================================
  RegisterComponentEditor(TElStyleManager, TElStyleManEditor);

  // Specific control editors
  // ------------------------------------
  RegisterClass(TElTabSheet);
  RegisterPropertyEditor(TypeInfo(TElTabSheet), TElPageControl, 'ActivePage', TElActivePageProperty);
  RegisterComponentEditor(TElTabSheet, TElPageControlEditor);
  RegisterComponentEditor(TElToolBar, TElToolBarEditor);
  RegisterComponentEditor(TElPageControl, TElPageControlEditor);
  RegisterComponentEditor(TElStatusBar, TElStatusBarEditor);
  RegisterComponentEditor(TElSideBar, TElSideBarEditor);

  RegisterPropertyEditor(TypeInfo(TElStoredProps), TElFormPersist, 'StoredProps', TPropListProperty);
  RegisterPropertyEditor(TypeInfo(TElSoundName), nil, '', TSoundNameProperty);
  RegisterPropertyEditor(TypeInfo(TElTreeItems), TElTreeCombo, 'Items',  TElTreeItemsProperty);
  RegisterComponentEditor(TElStringPool, TStrPoolItemsEditor);
  {$ifdef LMD_UNICODE}
  RegisterPropertyEditor(TypeInfo(TLMDWideStringArray), nil, 'Items', TStrPoolItemsProperty);
  {$endif}
  RegisterPropertyEditor(TypeInfo(TElStringArray), nil, 'Items', TStrPoolItemsProperty);

  RegisterComponentEditor(TElFormPersist, TElPropListEditor);
  RegisterComponentEditor(TElMRU, TElMRUCollectionEditor);
  RegisterComponentEditor(TElSoundMap, TSoundMapEditor);
  RegisterComponentEditor(TElTimerPool, TElTimerPoolEditor);
  RegisterComponentEditor(TElImageList, TElImageListEditor);
  RegisterComponentEditor(TElSysHotKey, TElHotKeyEditor);

  // Caption, Hint Items property editors
  // ------------------------------------
  {$ifdef LMD_UNICODE}
  RegisterPropertyEditor(TypeInfo(TLMDWideStrings), nil, 'Items', TLMDWideStringsProperty);
  RegisterPropertyEditor(TypeInfo(WideString), nil, 'Hint', TElMlCaptionProperty);
  {$endif}
  // No need for Delphi 9+

  {$ifndef LMDCOMP9}
  RegisterPropertyEditor(TypeInfo(TLMDString), nil, 'Caption', TElMlCaptionProperty);
  RegisterPropertyEditor(TypeInfo(TLMDString), nil, 'Hint', TElMlCaptionProperty);
  RegisterPropertyEditor(TypeInfo(string), nil, 'Hint', TElMlCaptionProperty);
  {$endif}

  // Dialog editors
  // ------------------------------------
  RegisterComponentEditor(TElBaseDlgComponent, TElDlgEditor);
  RegisterComponentEditor(TElPromptDialog, TElDlgEditor);
  RegisterComponentEditor(TElFolderDialog, TElDlgEditor);

  // Menu Editors
  // ------------------------------------
  // RegisterClasses([TElMenuItem, TElMainMenu, TElPopupMenu]); //move to ElMenus.pas to initialization section
  RegisterComponentEditor(TElMainMenu, TElMenuEditor);
  RegisterComponentEditor(TElPopupMenu, TElMenuEditor);
  RegisterPropertyEditor(TypeInfo(TMenuItem), TElMainMenu, 'Items', TElMenuItemsProperty);
  RegisterPropertyEditor(TypeInfo(TMenuItem), TElPopupMenu, 'Items', TElMenuItemsProperty);

  // Menu Editors
  // ------------------------------------
  // RegisterClasses([TElMenuItem, TElMainMenu, TElPopupMenu]); //move to ElMenus.pas to initialization section
  RegisterComponentEditor(TElTree, TElTreeEditor);
  RegisterComponentEditor(TElXTree, TElXTreeEditor);
  RegisterComponentEditor(TElTreeStringGrid, TElTreeEditor);
  RegisterComponentEditor(TElHeader, TElHeaderEditor);
  RegisterComponentEditor(TElXHeader, TElHeaderEditor);
  RegisterPropertyEditor(TypeInfo(TElTreeItems), nil, 'Items', TElTreeItemsProperty);
  RegisterPropertyEditor(TypeInfo(TElXTreeItems), nil, 'Items', TElXTreeItemsProperty);
  RegisterPropertyEditor(TypeInfo(TElHeaderSections), nil, 'Sections', TElSectionsProperty);
  RegisterPropertyEditor(TypeInfo(TElXHeaderSections), nil, 'Sections', TElXSectionsProperty);

  // ImageIndex Property Editors
  // ------------------------------------
  //RegisterPropertyEditor(TypeInfo(Integer), TMenuItem, 'ImageIndex', TElImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TElSideBarSection, 'ImageIndex', TElSideBarSectionImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TElSideBarItem, 'ImageIndex', TElSideBarItemImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TElToolButton, 'ImageIndex', TElToolButtonImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TElPopupButton, 'ImageIndex', TElImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TElGraphicButton, 'ImageIndex', TElImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TElImageComboBox, 'ImageIndex', TElImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TElTabSheet, 'ImageIndex', TElTabSheetImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TElCurrencyEdit, 'ButtonImageIndex', TElCurrencyEditButtonImageIndexProperty);

  // HTML Property Editors
  // ------------------------------------
  RegisterPropertyEditor(TypeInfo({$IFDEF LMD_UNICODE}TLMDWideStrings{$ELSE}TStrings{$ENDIF}), TElHTMLListBox, 'Items', TElHTMLStringsProperty);
  RegisterPropertyEditor(TypeInfo(TLMDString), TElHTMLComboBox, 'Text', TElHTMLStringProperty);
  RegisterPropertyEditor(TypeInfo({$IFDEF LMD_UNICODE}TLMDWideStrings{$ELSE}TStrings{$ENDIF}), TElHTMLComboBox, 'Items', TElHTMLStringsProperty);
  RegisterPropertyEditor(TypeInfo(TLMDString), TElHTMLLabel, 'Caption', TElHTMLStringProperty);
  RegisterPropertyEditor(TypeInfo(TLMDString), TElAdvancedPanel, 'Caption', TElHTMLStringProperty);
  RegisterPropertyEditor(TypeInfo(TLMDString), TElHTMLView, 'Caption', TElHTMLStringProperty);
  RegisterPropertyEditor(TypeInfo(TLMDString), TElHTMLPanel, 'Caption', TElHTMLStringProperty);

  RegisterComponentEditor(TElHTMLContainer, TElHTMLContainerEditor);
  RegisterPropertyEditor(TypeInfo(TCollection), TElHTMLContainer, 'Items', TElHTMLContainerItemsProperty);
  RegisterPropertyEditor(TypeInfo(TLMDString), TElHTMLListItem, 'Caption', TElHTMLStringProperty);

  {$ifdef lmdcomp12}
  RegisterPropertyEditor( TypeInfo(TLMDPNGObject), TCustomElPopupButton , 'PngGlyph', TLMDPNGImageProperty);
  RegisterPropertyEditor( TypeInfo(TLMDPNGObject), TCustomElGraphicButton , 'PngGlyph', TLMDPNGImageProperty);
  RegisterPropertyEditor( TypeInfo(TLMDPNGObject), TElPanelCaptionSettings , 'MinButtonPngGlyph', TLMDPNGImageProperty);
  RegisterPropertyEditor( TypeInfo(TLMDPNGObject), TElPanelCaptionSettings , 'CloseButtonPngGlyph', TLMDPNGImageProperty);
  RegisterPropertyEditor( TypeInfo(TLMDPNGObject), TCustomElButtonEdit , 'ButtonPngGlyph', TLMDPNGImageProperty);
  RegisterPropertyEditor( TypeInfo(TLMDPNGObject), TCustomElButtonEdit , 'AltButtonPngGlyph', TLMDPNGImageProperty);
  RegisterPropertyEditor( TypeInfo(TLMDPNGObject), TCustomElComboBox , 'AltButtonPngGlyph', TLMDPNGImageProperty);
  RegisterPropertyEditor( TypeInfo(TLMDPNGObject), TElToolButton , 'PngGlyph', TLMDPNGImageProperty);
  {$endif}

end;

end.
