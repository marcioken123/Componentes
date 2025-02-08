//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("CDBUb5.res");
USEPACKAGE("vcl50.bpi");
USEUNIT("CompareRoutines.pas");
USEUNIT("CoolComparer.pas");
USEUNIT("CoolDBUtils.pas");
USEUNIT("CoolDBUtilsReg.pas");
USERES("CoolDBUtilsReg.dcr");
USEUNIT("CoolUtility.pas");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("vclbde50.bpi");
USEPACKAGE("vclx50.bpi");
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
