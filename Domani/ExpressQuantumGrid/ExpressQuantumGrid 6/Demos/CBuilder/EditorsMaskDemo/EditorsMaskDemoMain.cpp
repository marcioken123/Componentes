//---------------------------------------------------------------------------

#include <vcl.h>
#include "shellapi.hpp"
#pragma hdrstop

#include "EditorsMaskDemoMain.h"
#include "EditorsMaskDemoData.h"
#include "AboutDemoForm.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxControls"
#pragma link "cxCustomData"
#pragma link "cxData"
#pragma link "cxDBData"
#pragma link "cxEdit"
#pragma link "cxFilter"
#pragma link "cxGraphics"
#pragma link "cxGrid"
#pragma link "cxGridCustomTableView"
#pragma link "cxGridCustomView"
#pragma link "cxGridDBTableView"
#pragma link "cxGridLevel"
#pragma link "cxGridTableView"
#pragma link "cxStyles"
#pragma link "cxButtonEdit"
#pragma link "cxContainer"
#pragma link "cxDBEdit"
#pragma link "cxMaskEdit"
#pragma link "cxTextEdit"
#pragma link "cxLookAndFeels"
#pragma link "cxNavigator"
#pragma link "cxDBNavigator"
#pragma resource "*.dfm"
TEditorsMaskDemoMainForm *EditorsMaskDemoMainForm;
//---------------------------------------------------------------------------
__fastcall TEditorsMaskDemoMainForm::TEditorsMaskDemoMainForm(TComponent* Owner)
  : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void __fastcall TEditorsMaskDemoMainForm::miAboutClick(TObject *Sender)
{
  ShowAboutDemoForm();
}
//---------------------------------------------------------------------------

void __fastcall TEditorsMaskDemoMainForm::miExitClick(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------

void TEditorsMaskDemoMainForm::ChangeLabel(TLabel* ALabel, TcxCustomEditProperties* AProperties)
{
  AnsiString AText;
  if(((TcxCustomMaskEditPropertiesAccessor*)AProperties)->EmptyMaskAccess(
    ((TcxCustomMaskEditPropertiesAccessor*)AProperties)->EditMaskAccess()))
    AText = "No mask";
  else
    AText = GetMaskKindLabel(((TcxCustomMaskEditPropertiesAccessor*)AProperties)->MaskKindAccess());
  ALabel->Caption = AText;
}
//---------------------------------------------------------------------------

AnsiString TEditorsMaskDemoMainForm::GetMaskKindLabel(const TcxEditMaskKind AMaskKind)
{                               
  switch(AMaskKind)
  {
    case emkStandard:
      return "Delphi Standard Mask";
    case emkRegExpr:
      return "Regular Expression";
    case emkRegExprEx:
      return "Regular Expression with Auto Complete Function";
    default:
      return "Unknown";
  };
}
//---------------------------------------------------------------------------

void __fastcall TEditorsMaskDemoMainForm::miShowEditMaskButtonsClick(
      TObject *Sender)
{
  ((TMenuItem*)Sender)->Checked = !((TMenuItem*)Sender)->Checked;
  edtPostalCode->Properties->Buttons->Items[0]->Visible = ((TMenuItem*)Sender)->Checked;
  edtPhone->Properties->Buttons->Items[0]->Visible = ((TMenuItem*)Sender)->Checked;
  edtFax->Properties->Buttons->Items[0]->Visible = ((TMenuItem*)Sender)->Checked;
  edtHomePage->Properties->Buttons->Items[0]->Visible = ((TMenuItem*)Sender)->Checked;
  edtEmail->Properties->Buttons->Items[0]->Visible = ((TMenuItem*)Sender)->Checked;
}
//---------------------------------------------------------------------------

void __fastcall TEditorsMaskDemoMainForm::miDefaultMaskClick(
      TObject *Sender)
{
  edtPostalCode->Properties->MaskKind = cxDefaultPostalCodeMaskKind;
  edtPostalCode->Properties->EditMask = cxDefaultPostalCodeEditMask;
  ChangeLabel(lbInfoPostalCode, edtPostalCode->Properties);
  edtPhone->Properties->MaskKind = cxDefaultPhoneMaskKind;
  edtPhone->Properties->EditMask = cxDefaultPhoneEditMask;
  ChangeLabel(lbInfoPhone, edtPhone->Properties);
  edtFax->Properties->MaskKind = cxDefaultFaxMaskKind;
  edtFax->Properties->EditMask = cxDefaultFaxEditMask;
  ChangeLabel(lbInfoFax, edtFax->Properties);
  edtHomePage->Properties->MaskKind = cxDefaultHomePageMaskKind;
  edtHomePage->Properties->EditMask = cxDefaultHomePageEditMask;
  ChangeLabel(lbInfoHomePage, edtHomePage->Properties);
  edtEmail->Properties->MaskKind = cxDefaultEmailMaskKind;
  edtEmail->Properties->EditMask = cxDefaultEmailEditMask;
  ChangeLabel(lbInfoEmail, edtEmail->Properties);
}
//---------------------------------------------------------------------------

void __fastcall TEditorsMaskDemoMainForm::edtPostalCodePropertiesButtonClick(
      TObject *Sender, int AButtonIndex)
{

  ShowEditMaskDialog(((TcxDBButtonEdit*)Sender)->Properties);
  ChangeLabel(lbInfoPostalCode, ((TcxDBButtonEdit*)Sender)->Properties);
}
//---------------------------------------------------------------------------

void TEditorsMaskDemoMainForm::ShowEditMaskDialog(TcxCustomEditProperties* AProperties)
{
  TcxEditMaskEditorDlg* ADialog = new TcxEditMaskEditorDlg((void*)0);
  try {
    ADialog->MaskEditProperties = (TcxCustomMaskEditProperties*)AProperties;
    ADialog->ShowModal();
  }
  __finally {
    delete ADialog;
  }
}
//---------------------------------------------------------------------------
void __fastcall TEditorsMaskDemoMainForm::edtPhonePropertiesButtonClick(
      TObject *Sender, int AButtonIndex)
{
  ShowEditMaskDialog(((TcxDBButtonEdit*)Sender)->Properties);
  ChangeLabel(lbInfoPhone, ((TcxDBButtonEdit*)Sender)->Properties);
}
//---------------------------------------------------------------------------

void __fastcall TEditorsMaskDemoMainForm::edtFaxPropertiesButtonClick(
      TObject *Sender, int AButtonIndex)
{
  ShowEditMaskDialog(((TcxDBButtonEdit*)Sender)->Properties);
  ChangeLabel(lbInfoFax, ((TcxDBButtonEdit*)Sender)->Properties);
}
//---------------------------------------------------------------------------

void __fastcall TEditorsMaskDemoMainForm::edtHomePagePropertiesButtonClick(
      TObject *Sender, int AButtonIndex)
{
  ShowEditMaskDialog(((TcxDBButtonEdit*)Sender)->Properties);
  ChangeLabel(lbInfoHomePage, ((TcxDBButtonEdit*)Sender)->Properties);
}
//---------------------------------------------------------------------------

void __fastcall TEditorsMaskDemoMainForm::edtEmailPropertiesButtonClick(
      TObject *Sender, int AButtonIndex)
{
  ShowEditMaskDialog(((TcxDBButtonEdit*)Sender)->Properties);
  ChangeLabel(lbInfoEmail, ((TcxDBButtonEdit*)Sender)->Properties);
}
//---------------------------------------------------------------------------

