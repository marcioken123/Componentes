//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\pLMDElFormPers.pas", PersPropsForm);
USEFORM("..\..\pLMDElItemCol.pas", ItemColDlg);
USEFORM("..\..\pLMDElItemsProp.pas", ItemsPropDlg);
USEFORM("..\..\pLMDElMlCapProp.pas", MlCapEditDialog);
USEFORM("..\..\pLMDElSectEdit.pas", SectEdit);
USEFORM("..\..\pLMDElSectProp.pas", ElSectionsPropDlg);
USEFORM("..\..\pLMDElSoundMap.pas", SoundMapForm);
USEFORM("..\..\pLMDElHTMLEditorDlg.pas", frmLMDElHTMLEditor);
USEFORM("..\..\pLMDElXItemCol.pas", XItemColDlg);
USEFORM("..\..\pLMDElXItemsProp.pas", XItemsPropDlg);
USEFORM("..\..\pLMDElXSectEdit.pas", XSectEdit);
USEFORM("..\..\pLMDElXSectProp.pas", ElXSectionsPropDlg);

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
