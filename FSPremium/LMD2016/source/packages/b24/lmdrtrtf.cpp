//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\LMDRTFBookMarkDialog.pas", LMDRTFBookMarkDialog);
USEFORM("..\..\LMDRTFCharmapDialog.pas", LMDRTFCharmapDialog);
USEFORM("..\..\LMDRTFLinkDialog.pas", LMDRichfrmLinkDialog);
USEFORM("..\..\LMDRTFParagraphProp.pas", LMDRichfrmParagraph);
USEFORM("..\..\LMDRTFPrintPreview.pas", LMDRichfrmPrintPreview);
USEFORM("..\..\LMDRTFPrintPreviewMode.pas", RTFPrintPreviewMode);
USEFORM("..\..\LMDRTFStatisticsDialog.pas", LMDRTFStatisticsDlg);
USEFORM("..\..\LMDRTFTabsProp.pas", LMDRichfrmTabs);
USEFORM("..\..\LMDRTFInsertDateTimeDlg.pas", frmLMDRichInsertDateTimeDlg);


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
