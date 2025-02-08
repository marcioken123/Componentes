//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\LMDSedFindDialog.pas", LMDSedFindDlg);
USEFORM("..\..\LMDSedGotoLineDialog.pas", LMDSedGotoLineDlg);
USEFORM("..\..\LMDSedColorSchemeDialog.pas", TLMDSedColorSchemeDlg);
USEFORM("..\..\LMDSedKeyBindingsDialog.pas", TLMDSedKeyBindingsDlg);
USEFORM("..\..\LMDSedSchemeEditDialog.pas", LMDSedGotoLineDlg);

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
