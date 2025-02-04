//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxEditorsC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEPACKAGE("cxDataC5.bpi");
USEPACKAGE("dxGDIPlusC5.bpi");
USEPACKAGE("dxThemeC5.bpi");
USEPACKAGE("vcljpg50.bpi");
USEPACKAGE("Vcldb50.bpi");
USEUNIT("cxBlobEdit.pas");
USEUNIT("cxButtonEdit.pas");
USEUNIT("cxButtons.pas");
USEUNIT("cxCalc.pas");
USEUNIT("cxCalendar.pas");
USEUNIT("cxCheckBox.pas");
USEUNIT("cxCurrencyEdit.pas");
USEUNIT("cxDateUtils.pas");
USEUNIT("cxDBEdit.pas");
USEUNIT("cxDBEditRepository.pas");
USEUNIT("cxDBLookupEdit.pas");
USEUNIT("cxDropDownEdit.pas");
USEUNIT("cxEdit.pas");
USEUNIT("cxEditConsts.pas");
USEUNIT("cxListBox.pas");
USEUNIT("cxEditDataRegisteredRepositoryItems.pas");
USEUNIT("cxEditDBRegisteredRepositoryItems.pas");
USEUNIT("cxEditPaintUtils.pas");
USEUNIT("cxEditRepositoryItems.pas");
USEUNIT("cxEditUtils.pas");
USEUNIT("cxFormats.pas");
USEUNIT("cxHyperLinkEdit.pas");
USEUNIT("cxImage.pas");
USEUNIT("cxImageComboBox.pas");
USEUNIT("cxLookupDBGrid.pas");
USEUNIT("cxLookupEdit.pas");
USEUNIT("cxLookupGrid.pas");
USEUNIT("cxMaskEdit.pas");
USEUNIT("cxMemo.pas");
USEUNIT("cxMRUEdit.pas");
USEUNIT("cxRegExpr.pas");
USEUNIT("cxSpinEdit.pas");
USEUNIT("cxStandardMask.pas");
USEUNIT("cxTextEdit.pas");
USEUNIT("cxTimeEdit.pas");
USEUNIT("cxDBLookupComboBox.pas");
USEUNIT("cxRadioGroup.pas");
USEUNIT("cxFilterControl.pas");
USEUNIT("cxFilterControlUtils.pas");
USEUNIT("cxNavigator.pas");
USEUNIT("cxFilterControlStrs.pas");
USEUNIT("cxDBNavigator.pas");
USEUNIT("cxDBFilterControl.pas");
USEUNIT("cxInplaceContainer.pas");
USEFORMNS("cxEditMaskEditor.pas", Cxeditmaskeditor, cxEditMaskEditorDlg);
USEFORMNS("cxFilterControlDialog.pas", fmfiltercontroldialog, fmFilterControlDialog);
USEUNIT("cxEditRegisteredRepositoryItems.pas");
USEUNIT("cxPropertiesConverters.pas");
USEUNIT("cxGroupBox.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------

//   Package source.
//---------------------------------------------------------------------------

#pragma argsused
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
