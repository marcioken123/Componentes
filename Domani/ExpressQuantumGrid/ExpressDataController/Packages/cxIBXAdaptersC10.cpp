//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxIBXAdaptersC10.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("dbrtl.bpi");
USEPACKAGE("ibxpress.bpi");
USEPACKAGE("cxDataC10.bpi");
USEUNIT("cxIBXAdapters.pas");
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
