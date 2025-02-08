//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\pLMDComAboutDlg.pas", LMDAboutDlg);
USEFORM("..\..\pLMDComBrushDlg.pas", LMDComBrushEditorDlg);
USEFORM("..\..\pLMDDateTimeEditorDlg.pas", LMDFrmDateTimeEditor);
USEFORM("..\..\pLMDConfigDlg.pas", LMDConfigDlg);
USEFORM("..\..\pLMDHotkeyEditorDlg.pas", LMDfrmHotkeyEditor);
USEFORM("..\..\pLMDWideStringsEditDlg.pas", FrmLMDWideStringsEditor);

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
