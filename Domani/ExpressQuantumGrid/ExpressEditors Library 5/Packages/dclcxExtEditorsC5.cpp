//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("dclcxExtEditorsC5.res");
USERES("cxExtEditReg.dcr");
USEPACKAGE("vcl50.bpi");
USEPACKAGE("dclcxLibraryVCLC5.bpi");
USEPACKAGE("cxEditorsC5.bpi");
USEPACKAGE("cxExtEditorsC5.bpi");
USEPACKAGE("dclcxEditorsC5.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dcldb50.bpi");
USEPACKAGE("vclx50.bpi");
USEPACKAGE("dxThemeC5.bpi");
USEPACKAGE("cxLibraryVCLC5.bpi");
USEPACKAGE("cxDataC5.bpi");
USEUNIT("cxExtEditReg.pas");
USEUNIT("cxShellEditorsReg.pas");
USEFORMNS("cxHintEditor.pas", Cxhinteditor, cxHintStyleEditor);
USEFORMNS("cxSplitterEditor.pas", Cxsplittereditor, cxSplitEditor);
USEFORMNS("cxCheckGroupStatesEditor.pas", Cxcheckgroupstateseditor, cxCheckGroupStatesEditorDlg);
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
