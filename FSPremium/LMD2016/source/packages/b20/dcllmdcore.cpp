//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\pLMDBevelEditorDlg.pas", LMDBevelEditorDlg);
USEFORM("..\..\pLMDBitmapEffectEditorDlg.pas", LMDBitmapEffectEditorDlg);
USEFORM("..\..\pLMDBitmapStyleEditorDlg.pas", LMDBitmapStyleEditorDlg);
USEFORM("..\..\pLMDButtonLayoutEditorDlg.pas", LMDButtonLayoutEditorDlg);
USEFORM("..\..\pLMDDateTimeFormatEditorDlg.pas", LMDFrmDateTimePropertyEditor);
USEFORM("..\..\pLMDFillObjectEditorDlg.pas", LMDFillEditorDlg);
USEFORM("..\..\pLMDFontFXEditorDlg.pas", LMDFxEditorDlg);
USEFORM("..\..\pLMDGlyphTextLayoutEditorDlg.pas", LMDGlyphTextLayoutEditorDlg);
USEFORM("..\..\pLMDGradientEditorDlg.pas", LMDGradientEditorDlg);
USEFORM("..\..\pLMDMaskEditorDlg.pas", LMDfrmMaskEditDlg);
USEFORM("..\..\pLMDSmallBarEditorDlg.pas", LMDSmallBarEditorDlg);
USEFORM("..\..\pLMDStatusBarEditorDlg.pas", LMDStatusBarEditorDlg);
USEFORM("..\..\pLMDStringsEditorDlg.pas", LMDFrmStringEditor);
USEFORM("..\..\pLMDTransparentEditorDlg.pas", LMDTransparentEditorDlg);
USEFORM("..\..\pLMDToolBarEditorDlg.pas", LMDToolbarEditorDlg);

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
