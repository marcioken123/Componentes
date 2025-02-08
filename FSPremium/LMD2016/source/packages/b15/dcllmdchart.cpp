//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\pLMDChartValuesOptionsSelDlg.pas", LMDChartValuesOptionsSelDlg);
USEFORM("..\..\pLMDAreaFillEditor.pas", LMDAreaFillEditor);
USEFORM("..\..\pLMDAddSeriesDlg.pas", LMDAddSeriesDlg);
USEFORM("..\..\pLMDChartSeriesEditorDlg.pas", LMDChartSeriesEditorDlg);
USEFORM("..\..\pLMDChartEditorDlg.pas", LMDChartEditor);
USEFORM("..\..\pLMDDistanceAndPositionDlg.pas", LMDDistanceAndSizeEditor);
USEFORM("..\..\pLMDLineEditorDlg.pas", LMDLineEditor);

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
