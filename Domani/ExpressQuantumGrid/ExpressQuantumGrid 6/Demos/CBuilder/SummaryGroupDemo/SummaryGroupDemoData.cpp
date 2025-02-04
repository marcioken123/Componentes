//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "SummaryGroupDemoData.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "cxClasses"
#pragma link "cxGridTableView"
#pragma link "cxStyles"
#pragma resource "*.dfm"
TSummaryGroupDemoDataDM *SummaryGroupDemoDataDM;
//---------------------------------------------------------------------------
__fastcall TSummaryGroupDemoDataDM::TSummaryGroupDemoDataDM(TComponent* Owner)
  : TDataModule(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TSummaryGroupDemoDataDM::tblCarsCalcFields(
      TDataSet *DataSet)
{
  tblCarsCarName->AsString = tblCarsTrademark->AsString + " " +
    tblCarsModel->AsString;
}
//---------------------------------------------------------------------------

void __fastcall TSummaryGroupDemoDataDM::tblOrdersCalcFields(
      TDataSet *DataSet)
{
  AnsiString s;
  DateTimeToString(s, "mmmm", tblOrdersPurchaseDate->AsDateTime);
  tblOrdersPurchaseMonth->AsString = s;
}
//---------------------------------------------------------------------------

