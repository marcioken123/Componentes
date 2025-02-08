//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\LMDIdeAlignPltte.pas", LMDAlignPaletteForm);
USEFORM("..\..\LMDIdeTabOrderDlg.pas", LMDTabOrderForm);
USEFORM("..\..\LMDIdeCreationOrderDlg.pas", LMDCreationOrderForm);
USEFORM("..\..\LMDIdeActListEditor.pas", LMDActionListEditorDialog);


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
