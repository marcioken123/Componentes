//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

USEFORM("..\..\pLMD3DEffectEditorDlg.pas", LMD3DEffectEditorDlg);
USEFORM("..\..\pLMDBmpRegionEditorDlg.pas", LMDfrmRegionFromBMPdlg);
USEFORM("..\..\pLMDButtonBarEditorDlg.pas", frmLMDButtonBarEditorDlg);
USEFORM("..\..\pLMDCaptionEditorDlg.pas", LMDCaptionEditorDlg);
USEFORM("..\..\pLMDDlgBtnEditorDlg.pas", LMDDlgButtonEditorDlg);
USEFORM("..\..\pLMDFilterPropertyEditorDlg.pas", LMDFilterPropsDlg);
USEFORM("..\..\pLMDGraphicLabelEditorDlg.pas", LMDFormGraphicLabelEditor);
USEFORM("..\..\pLMDHideNonVC.pas", LMDHideNonVCfrm);
USEFORM("..\..\pLMDLEDEditorDlg.pas", LMDLEDEditorDlg);
USEFORM("..\..\pLMDLightEditorDlg.pas", LMDLightEditorDlg);
USEFORM("..\..\pLMDMMButtonFaceEditorDlg.pas", LMDButtonFaceDlg);
USEFORM("..\..\pLMDOSPropForm.pas", LMDOSPropForm);
USEFORM("..\..\pLMDPointListEditorDlg.pas", frmTLMDPointListEditor);
USEFORM("..\..\pLMDSendKeyEditorDlg.pas", LMDSendKeysEditorDlg);
USEFORM("..\..\pLMDShadowEditorDlg.pas", LMDShadowEditorDlg);
USEFORM("..\..\pLMDShapeEditorDlg.pas", LMDShapeEditorDlg);
USEFORM("..\..\pLMDSimpleBevelEditorDlg.pas", LMDSimpleBevelEditorDlg);
USEFORM("..\..\pLMDTeethEditorDlg.pas", LMDTeethEditorDlg);
USEFORM("..\..\pLMDVldRegExpEditor.pas", LMDRegExprForm);
USEFORM("..\..\pLMDDateListEditorDlg.pas", LMDDateListEditorDlg);
USEFORM("..\..\pLMDControlFaceEditorDlg.pas", frmLMDControlFaceComponentEditor);
USEFORM("..\..\pLMDControlFaceEditorDlgAddState.pas", frmStateAddingDlg);

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
