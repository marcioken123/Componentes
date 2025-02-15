//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "MasterDetailChartDemoMain.h"
#include "AboutDemoForm.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxControls"
#pragma link "cxCustomData"
#pragma link "cxData"
#pragma link "cxDataStorage"
#pragma link "cxDBData"
#pragma link "cxEdit"
#pragma link "cxFilter"
#pragma link "cxGraphics"
#pragma link "cxGrid"
#pragma link "cxGridChartView"
#pragma link "cxGridCustomTableView"
#pragma link "cxGridCustomView"
#pragma link "cxGridDBChartView"
#pragma link "cxGridDBTableView"
#pragma link "cxGridLevel"
#pragma link "cxGridTableView"
#pragma link "cxLookAndFeels"
#pragma link "cxStyles"
#pragma resource "*.dfm"
TfrmMain *frmMain;
//---------------------------------------------------------------------------
__fastcall TfrmMain::TfrmMain(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

AnsiString TfrmMain::GetProductName(int AID)
{
  if (tblProducts->FindKey(ARRAYOFCONST((AID))))
    return tblProducts->FieldValues["Name"];
  else
    return "";
}

void __fastcall TfrmMain::miExitClick(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::miAboutClick(TObject *Sender)
{
  ShowAboutDemoForm();
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::FormCreate(TObject *Sender)
{
  tvCustomers->ViewData->Rows[0]->Expanded = true;
  tvCustomers->ViewData->Rows[1]->Expanded = true;
  ((TcxGridMasterDataRow*)(tvCustomers->ViewData->Rows[1]))->ActiveDetailIndex = 1;
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::chvOrdersGetValueHint(TcxGridChartView *Sender,
      TcxGridChartSeries *ASeries, int AValueIndex, AnsiString &AHint)
{
  AHint = Format("Order %s (%d copies of %s) for %s",
    ARRAYOFCONST((Sender->Categories->VisibleDisplayTexts[AValueIndex],
      (int)(Sender->FindSeriesByID(chvOrdersQuantitySeries->ID)->VisibleValues[AValueIndex]),
      GetProductName((int)Sender->FindSeriesByID(chvOrdersProductIDSeries->ID)->VisibleValues[AValueIndex]),
      ASeries->VisibleDisplayTexts[AValueIndex])));
}
//---------------------------------------------------------------------------

void __fastcall TfrmMain::chvOrdersCategoriesGetValueDisplayText(
      TObject *Sender, const Variant &AValue, AnsiString &ADisplayText)
{
  ADisplayText = "#" + ADisplayText;
}
//---------------------------------------------------------------------------

