//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("CDBUb4.res");
USEPACKAGE("vcl40.bpi");
USEPACKAGE("vcldb40.bpi");
USEPACKAGE("vclx40.bpi");
USEUNIT("CompareRoutines.pas");
USEUNIT("CoolComparer.pas");
USEUNIT("CoolDBUtils.pas");
USEUNIT("CoolDBUtilsReg.pas");
USERES("CoolDBUtilsReg.dcr");
USEUNIT("CoolUtility.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
