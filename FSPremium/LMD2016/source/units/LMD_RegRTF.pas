unit LMD_RegRTF;
{$I LMDCmps.inc}

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

_LMD_RegRTF unit (RM)
---------------------
Registration unit for LMD RichPack.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

December 2007
 - RichEdit print task added


###############################################################################}

interface

procedure Register;

implementation

uses
  Classes, Controls, ActnList,
  ActnMan, ActnCtrls, DesignIntf, DesignEditors, VCLEditors, ActnMenus,
  pLMDCommon, pLMDComAboutDlg, pLMDRTFPE, pLMDRTFCE, LMDRTFBase,
  LMDRTFFontComboBox, LMDRTFRichDialog, LMDRTFPageDialog,
  LMDRTFInsertDateTimeDlg, LMDRTFCharMapDialog, LMDRTFRichEdit, LMDRTFStorage,
  LMDRTFHyperTextStorage, LMDRTFLabel, LMDRTFActions, LMDRTFSyntaxEdit,
  LMDRichEditPrintTask,StFilSys{$IFDEF LMDCOMP17}, System.Actions{$ENDIF};

{------------------------------------------------------------------------------}
procedure Register;
begin
  // Connect TLMDSysBaseComponent with TWinControl, so that it no longer appears
  // on CLX palette.
  GroupDescendentsWith(TLMDRichComponent, TWinControl);

   RegisterComponents( 'LMD Rich',     [TLMDRichEdit,
                                        TLMDRichStorage,
                                        TLMDRichHyperTextStorage,
                                        TLMDRichLabel,
                                        TLMDRichScrollText,
                                        TLMDRichScrollBox,
                                        TLMDRichSyntaxEdit,
                                        TLMDRichFontComboBox,
                                        TLMDRichPageSetupDialog,
                                        TLMDRichFontSizeComboBox,
                                        //TLMDRichDialog,
                                        TLMDRichInsertDateTimeDialog,
                                        TLMDRichCharmapDialog,
                                        TLMDRichEditPrintTask
                                        ]);

   RegisterActions( 'LMDRichEdit',     [
                                        TLMDRichEditBaseEditAction,
                                        TLMDRichEditNew,
                                        TLMDRichEditLoad,
                                        TLMDRichEditSave,
                                        TLMDRichEditSaveAs,
                                        TLMDRichEditParagraph,
                                        TLMDRichEditTextAttributes,
                                        TLMDRichEditTextBold,
                                        TLMDRichEditTextItalic,
                                        TLMDRichEditTextUnderline,
                                        TLMDRichEditUndo,
                                        TLMDRichEditRedo,
                                        TLMDRichEditFind,
                                        TLMDRichEditReplace,
                                        TLMDRichEditParaAlign,
                                        TLMDRichEditNumbering,
                                        TLMDRichEditPrint,
                                        TLMDRichEditPreview,
                                        TLMDRichEditTextSubscript,
                                        TLMDRichEditTextSuperscript,
                                        TLMDRichEditCut,
                                        TLMDRichEditCopy,
                                        TLMDRichEditPaste,
                                        TLMDRichEditInsertObject,
                                        TLMDRichEditObjectProperties,
                                        TLMDRichEditPasteSpecial,
                                        TLMDRichEditSelectAll,
                                        TLMDRichEditDelete,
                                        TLMDRichEditIndent,
                                        TLMDRichEditUnindent,
                                        TLMDRichEditStatistics,
                                        TLMDRichEditInsertDateTime,
                                        TLMDRichEditInsertChar,
                                        TLMDRichEditPageSetting,
                                        TLMDRichEditNumberingArabicNumbers,
                                        TLMDRichEditNumberingBullet,
                                        TLMDRichEditParaAlignLeft,
                                        TLMDRichEditParaAlignCenter,
                                        TLMDRichEditParaAlignRight
                                        ], nil);

  // component editors
  RegisterComponentEditor(TLMDRichBaseDialog, TLMDRTFRichDialogEditor);
  RegisterComponentEditor(TLMDRichPageSetupDialog, TLMDRTFRichDialogEditor);
  RegisterComponentEditor(TLMDCustomRichEdit, TLMDRTFComponentEditor);
//  RegisterComponentEditor(TLMDCustomRichEdit, TLMDRTFLinesEditor);
  RegisterComponentEditor(TLMDCustomRichLabel, TLMDRTFComponentEditor);
  RegisterComponentEditor(TLMDRichStorage, TLMDRTFStorageEditor);

  // property editors
  RegisterPropertyEditor(TypeInfo(TStrings), TLMDCustomRichEdit, 'Lines', TRTFLinesProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TLMDRichStorageItem, 'Lines', TRTFLinesProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TLMDRichHyperTextStorageItem, 'Lines', TRTFHyperTextLinesProperty);
  RegisterPropertyEditor(TypeInfo(TStrings), TLMDCustomRichLabel, 'Lines', TRTFLinesProperty);
  RegisterPropertyEditor(TypeInfo(LongInt), TLMDCustomRichEdit, 'RichStorageItem', TRTFStorageItemProperty);
  RegisterPropertyEditor(TypeInfo(LongInt), TLMDCustomRichLabel, 'RichStorageItem', TRTFStorageItemProperty);
  RegisterPropertyEditor(TypeInfo(TLMDRichSyntaxDefinition), TLMDCustomRichSyntaxEdit, 'SyntaxDefinition', TRTFSyntaxDefsProperty);
 // ToDo
  RegisterPropertyEditor(TypeInfo(TCollection), TLMDRichStorage, 'Items', TRTFStorageItemsProperty);
  RegisterPropertyEditor(TypeInfo(TCollection), TLMDRichHyperTextStorage, 'Items', TRTFStorageItemsProperty);

end;

end.
