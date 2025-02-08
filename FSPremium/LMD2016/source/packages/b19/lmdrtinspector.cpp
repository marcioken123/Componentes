//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\LMDInsStrsEditor.pas", LMDStringsEditorDialog);
USEFORM("..\..\LMDInsWideStrsEditor.pas", LMDWideStringsEditorDialog);
USEFORM("..\..\LMDInsCollectionEditor.pas", LMDCollectionEditorDialog);
USEFORM("..\..\LMDInsMenuEditor.pas", LMDMenuEditorDialog);


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
