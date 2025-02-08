//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\JSPasswordDialogFrame.pas", fmJSPasswordDialog);
USEFORM("..\..\JSConfirmPasswordDialogFrame.pas", fmJSConfirmPasswordDialog);
USEFORM("..\..\JSChangePasswordDialogFrame.pas", fmJSChangePasswordDialog);
USEFORM("..\..\JSDualEditDialogFrame.pas", fmDualEditDialog);


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
