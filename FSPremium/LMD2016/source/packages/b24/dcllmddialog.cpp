//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\CustomiseDialog.pas", frmCustomiseDialog);
USEFORM("..\..\CustomiseEditDialog.pas", frmCustomiseEditDialog);
USEFORM("..\..\CADForm.pas", frmCAD);


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
