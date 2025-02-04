//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("cxLibraryVCLC5.res");
USEPACKAGE("dxGDIPlusC5.bpi");  
USEPACKAGE("dxThemeC5.bpi");
USEPACKAGE("vcl50.bpi");
USEFORMNS("cxStyleSheetEditor.pas", Cxstylesheeteditor, frmcxStyleSheetEditor);
USEUNIT("cxContainer.pas");
USEUNIT("cxControls.pas");
USEUNIT("cxGraphics.pas");
USEUNIT("cxLookAndFeelPainters.pas");
USEUNIT("cxLookAndFeels.pas");
USEUNIT("cxScrollBar.pas");
USEUNIT("cxStorage.pas");
USEUNIT("cxStyles.pas");
USEUNIT("cxClasses.pas");
USEUNIT("cxLibraryStrs.pas");
USEUNIT("cxPropertiesStore.pas");
USEUNIT("cxConverterUtils.pas");
USEUNIT("cxCustomConverter.pas");
USEUNIT("cxGeometry.pas");
USEUNIT("cxDrawTextUtils.pas");
USEUNIT("cxAccessibility.pas");
USEUNIT("cxDWMApi.pas");
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
