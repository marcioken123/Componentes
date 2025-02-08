//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\pLMDSysCheckListDlg.pas", frmLMDSysOptionsEditor);
USEFORM("..\..\pLMDSysViewDlg.pas", frmLMDSysViewDlg);
USEFORM("..\..\pLMDSysNetEnumDlg.pas", frmLMDSysEnumDlg);

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
