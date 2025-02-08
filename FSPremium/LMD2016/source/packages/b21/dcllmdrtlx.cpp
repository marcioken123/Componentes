//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\pLMDActnListEditor.pas", frmActionListEditor);
USEFORM("..\..\pLMDStdActnList.pas", frmStdActionList);
USEFORM("..\..\pLMDHTMLEditDlg.pas", frmLMDMiniHTMLEditor);
USEFORM("..\..\pLMDStdListEditorDlg.pas", TLMDStdListEditorDlg);
USEFORM("..\..\pLMDStdItemPropertiesEditorDlg.pas", TLMDStdItemForm);
USEFORM("..\..\pLMDExtImageListEditorDlg.pas", LMDExtImageListEditorDlg);
USEFORM("..\..\pLMDCustomImageListSelectDlg.pas", LMDCustImgListSelectDlg);
USEFORM("..\..\pLMDPicturePropertyEditor.pas", LMDPicturePropertyEditorDlg);

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
