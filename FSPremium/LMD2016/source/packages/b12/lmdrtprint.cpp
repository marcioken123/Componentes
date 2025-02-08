//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\LMDPrintResModule.pas", LMDPrintResDataModule);
USEFORM("..\..\LMDPrintPreviewDlg.pas", LMDPrintPreviewForm);
USEFORM("..\..\LMDPrintPreviewModeDlg.pas", LMDPrintPreviewModeDialog);
USEFORM("..\..\LMDPrintTemplateEditDlg.pas", LMDPrintTemplateEditDialog);

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
