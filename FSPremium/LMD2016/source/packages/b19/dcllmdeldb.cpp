//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\pLMDElXGridColProp.pas", XColumnDefs);
USEFORM("..\..\pLMDElXRelationsDsgn.pas", RelationsEditor);
USEFORM("..\..\pLMDElXRelDataSourceDsgn.pas", ElRelDataSourceDsgn);
USEFORM("..\..\pLMDElXStylesProp.pas", NewStylesPropDlg);

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
