//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\LMDShListDlg.pas", LMDShellfrmListDialog);
USEFORM("..\..\LMDShBrwDlg.pas", LMDShellfrmBrowseDialog);
USEFORM("..\..\LMDShListFilterDlg.pas", LMDfrmShellListFilterDialog);
USEFORM("..\..\LMDShPathFrame.pas", LMDShellPathFrame);
USEFORM("..\..\LMDShDriveSelectDlg.pas", LMDShfrmSelectDriveDialog);


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
