//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("CoolCtlsB4.res");
USEUNIT("CoolCtrls.pas");
USEUNIT("CoolCtrlsReg.pas");
USERES("CoolCtrlsReg.dcr");
USEUNIT("VclTracer.pas");
USEUNIT("VclTracerReg.pas");
USERES("VclTracerReg.dcr");
USEUNIT("CoolTools.pas");
USEUNIT("CoolPolygons.pas");
USEUNIT("PointListUnit.pas");
USEUNIT("CoolCtrlsDB.pas");
USEUNIT("CoolAboutUnit.pas");
USEPACKAGE("VCL40.bpi");
USEPACKAGE("VCLX40.bpi");
USEPACKAGE("VCLDB40.bpi");
USEPACKAGE("bcbsmp40.bpi");
USEUNIT("CoolUtils.pas");
USEUNIT("CoolCtrlsEx.pas");
USEPACKAGE("vcljpg40.bpi");
USEUNIT("CoolAppLock.pas");
USERES("CoolAppLock.dcr");
USEUNIT("CoolScrollBar.pas");
USERES("CoolScrollBar.dcr");
USERES("CoolWinDock.dcr");
USEUNIT("CoolSplitter.pas");
USERES("CoolSplitter.dcr");
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
