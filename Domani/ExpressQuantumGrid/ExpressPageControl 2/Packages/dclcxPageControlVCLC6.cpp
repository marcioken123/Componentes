//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxPageControlVCLC6.res");
USEPACKAGE("vcl.bpi");
USEPACKAGE("rtl.bpi");
USEPACKAGE("cxLibraryVCLC6.bpi");
USEPACKAGE("dxThemeC6.bpi");
USEPACKAGE("cxPageControlVCLC6.bpi");
USEPACKAGE("designide.bpi");
USEUNIT("cxPCReg.pas");
USERES("cxPCReg.dcr");
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
