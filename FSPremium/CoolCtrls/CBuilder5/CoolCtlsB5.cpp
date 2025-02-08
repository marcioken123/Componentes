//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("CoolCtlsB5.res");
USEUNIT("CoolCtrls.pas");
USEUNIT("CoolCtrlsReg.pas");
USERES("CoolCtrlsReg.dcr");
USEUNIT("VclTracer.pas");
USEUNIT("VclTracerReg.pas");
USERES("VclTracerReg.dcr");
USEUNIT("CoolTools.pas");
USEUNIT("CoolUtils.pas");
USEUNIT("CoolPolygons.pas");
USEUNIT("PointListUnit.pas");
USEUNIT("CoolCtrlsDB.pas");
USEUNIT("CoolAboutUnit.pas");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("vclbde50.bpi");
USEPACKAGE("bcbsmp50.bpi");
USEUNIT("CoolCtrlsEx.pas");
USEPACKAGE("vcljpg50.bpi");
USEUNIT("CoolAppLock.pas");
USERES("CoolAppLock.dcr");
USEUNIT("CoolScrollbar.pas");
USERES("CoolScrollbar.dcr");
USEUNIT("CoolWinDock.pas");
USERES("CoolWinDock.dcr");
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
