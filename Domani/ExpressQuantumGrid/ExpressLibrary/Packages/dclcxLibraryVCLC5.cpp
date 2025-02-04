//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxLibraryVCLC5.res");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("dsnide50.bpi");
USEPACKAGE("Vcldb50.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEPACKAGE("dxGDIPlusC5.bpi");  
USEPACKAGE("dxThemeC5.bpi");
USEUNIT("cxClassesReg.pas");
USEFORMNS("cxDesignWindows.pas", Cxdesignwindows, cxDesignFormEditor);
USEUNIT("cxPropEditors.pas");
USEFORMNS("cxStyleRepositoryEditor.pas", Cxstylerepositoryeditor, cxStyleRepositoryEditor);
USEFORMNS("cxStyleSheetsLoad.pas", Cxstylesheetsload, frmcxStyleSheetsLoad);
USEUNIT("cxLibraryReg.pas");
USERES("cxLibraryReg.dcr");
USEUNIT("cxPropertiesStoreEditor.pas");
USEUNIT("cxImportDialog.pas");
USEUNIT("cxConverterFactory.pas");
USEFORMNS("cxComponentCollectionEditor.pas", Cxcomponentcollectioneditor, cxComponentCollectionEditor);
USEFORMNS("cxImageListEditor.pas", Cximagelisteditor, cxImageListEditor);
USEFORMNS("cxImageListEditorView.pas", Cximagelisteditorview, cxImageListEditorView);
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
