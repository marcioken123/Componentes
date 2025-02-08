//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\pLMDRTFSyntaxDefEditor.pas", frmSyntaxDefEditor);
USEFORM("..\..\pLMDRTFHyperTextEditor.pas", frmLMDRTFHyperTextEditor);
USEFORM("..\..\pLMDRTFToolbarOptions.pas", ToolbarOptionsForm);
USEFORM("..\..\pLMDRTFRichEditor.pas", frmLMDRichDialogForm);


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
