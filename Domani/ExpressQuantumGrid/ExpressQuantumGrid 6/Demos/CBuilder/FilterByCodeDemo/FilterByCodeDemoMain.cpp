//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "FilterByCodeDemoMain.h"
#include "FilterByCodeDemoData.h"
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
#pragma link "cxCalendar"
#pragma link "cxDataStorage"
#pragma link "cxSpinEdit"
#pragma link "cxLookAndFeels"
#pragma resource "*.dfm"
TFilterByCodeDemoMainForm *FilterByCodeDemoMainForm;

const cOnlyGrids = 100;
const cExpressQuantumGridID = 3;
const cExtraGridID = 7;
const cASPXGridID = 9;
const cXpressQuantumGridID = 14;

const cCopiesCount = 3;
const cCashID = 1;
const cVisaID = 2;
const cAmExID = 4;

//---------------------------------------------------------------------------
__fastcall TFilterByCodeDemoMainForm::TFilterByCodeDemoMainForm(TComponent* Owner)
  : TForm(Owner)
{
}

//---------------------------------------------------------------------------

void __fastcall TFilterByCodeDemoMainForm::miAboutClick(TObject *Sender)
{
  ShowAboutDemoForm();
}
//---------------------------------------------------------------------------

void __fastcall TFilterByCodeDemoMainForm::miExitClick(TObject *Sender)
{
  Close();
}
//---------------------------------------------------------------------------

void __fastcall TFilterByCodeDemoMainForm::miFilterBoxPosClick(TObject *Sender)
{
  ((TMenuItem*)Sender)->Checked = true;
  tvCustomers->Filtering->Position =
    (TcxGridFilterPosition)((TMenuItem*)Sender)->MenuIndex;
}
//---------------------------------------------------------------------------

void __fastcall TFilterByCodeDemoMainForm::FormCreate(TObject *Sender)
{
  PopulateFilterList();
}
//---------------------------------------------------------------------------

void __fastcall TFilterByCodeDemoMainForm::tvCustomersDataControllerFilterChanged(TObject *Sender)
{
  if (ComponentState.Contains(csDestroying)) return;
  if (!FLock)
    if (tvCustomers->DataController->Filter->IsFiltering())
     cbFilters->ItemIndex = GetFilterIndex(ufCustom);
    else
     cbFilters->ItemIndex = GetFilterIndex(ufNone);
}
//---------------------------------------------------------------------------

void __fastcall TFilterByCodeDemoMainForm::cbFiltersChange(TObject *Sender)
{
  SetFilter(
    (TUserFiltering)(((TComboBox*)Sender)->Items->Objects[((TComboBox*)Sender)->ItemIndex]));
}
//---------------------------------------------------------------------------

void __fastcall TFilterByCodeDemoMainForm::tvCustomersPRODUCTIDUserFiltering(
      TcxCustomGridTableItem *Sender, const Variant &AValue,
      const AnsiString ADisplayText)
{
  if (AValue == cOnlyGrids)
    SetOnlyGridsFilter(tvCustomers->DataController->Filter->Root);
}
//---------------------------------------------------------------------------

void __fastcall TFilterByCodeDemoMainForm::tvCustomersPRODUCTIDGetFilterValues(
    TcxCustomGridTableItem *Sender, TcxDataFilterValueList *AValueList)
{
  AValueList->Add(fviUser, cOnlyGrids, "ONLY GRIDS", true);
}
//---------------------------------------------------------------------------

TDate TFilterByCodeDemoMainForm::GetDate(TDateType ADateType)
{
  TDate ADate = Date();
  switch (ADateType){
    case dtFirstOfYear:
      ADate =  EncodeDate(2000, 1, 1);
      break;
    case dtLastOfYear:
      ADate =  EncodeDate(2000, 12, 31);
  }
  return ADate;
}
//---------------------------------------------------------------------------

int TFilterByCodeDemoMainForm::GetFilterIndex(const TUserFiltering AFiltering)
{
  for (int I = 0; I < cbFilters->Items->Count; I++)
    if ((TUserFiltering)(cbFilters->Items->Objects[I]) == AFiltering)
      return I;
  return -1;
}
//---------------------------------------------------------------------------

void TFilterByCodeDemoMainForm::PopulateFilterList()
{
  String AFilterDesc[] = {
    "No filter",
    "Custom filter",
    "COPIES > 3",
    "COMPANY contains ""&"" symbol",
    "Only CUSTOMERs with PRODUCT = ExpressQuantumGrid",
    "All PURCHASEDATEs of 2000 year",
    "Only grid components",
    "Only grid components paid by VISA or AmericanExpress",
    "PAYMENTTYPE is CASH or AMERICANEXPRESS"
  };

  cbFilters->Clear();
  for (int I = 0; I < sizeof(AFilterDesc)/sizeof (AFilterDesc[0]); I++)
    cbFilters->Items->AddObject(AFilterDesc[I], (TObject*)I);
  cbFilters->ItemIndex = GetFilterIndex(ufSimple);
  SetFilter(ufSimple);

}
//---------------------------------------------------------------------------

void TFilterByCodeDemoMainForm::SetFilter(const TUserFiltering AFiltering)
{
  FLock = True;
  try {
    TDate ADate;

    TcxFilterCriteriaItemList *AList = tvCustomers->DataController->Filter->Root;
    AList->Clear();
    int Bounds[2] = {0, 1};
    Variant A;
    switch (AFiltering){
      case ufCustom:
        MessageDlg("Please click the filter arrow in a corresponding column header",
          mtInformation, TMsgDlgButtons()<<mbOK, 0);
        break;
      case ufSimple:
        AList->AddItem(tvCustomersCOPIES, foGreater, cCopiesCount, "3");
        break;
      case ufLike:
        AList->AddItem(tvCustomersCOMPANYNAME, foLike, "%&%", """&""");
        break;
      case ufTwoField:
        AList->BoolOperatorKind = fboAnd;
        AList->AddItem(tvCustomersCUSTOMER, foEqual, true, "true");
        AList->AddItem(tvCustomersPRODUCTID, foEqual, cExpressQuantumGridID,
          "ExpressQuantumGrid");
        break;
      case ufBetween:
        AList->BoolOperatorKind = fboAnd;
        ADate = GetDate(dtFirstOfYear);
        AList->AddItem(tvCustomersPURCHASEDATE, foGreaterEqual, ADate, DateToStr(ADate));
        ADate = GetDate(dtLastOfYear);
        AList->AddItem( tvCustomersPURCHASEDATE, foLessEqual, ADate, DateToStr(ADate));
        break;
      case ufUserFilter:
        SetOnlyGridsFilter(tvCustomers->DataController->Filter->Root);
        break;
      case ufGroup:
        AList->BoolOperatorKind = fboAnd;
        SetOnlyGridsFilter(AList->AddItemList(fboOr));
        A = VarArrayCreate(Bounds, 1, varVariant);
        A.PutElement(cVisaID, 0);
        A.PutElement(cAmExID, 1);
        AList->AddItem( tvCustomersPAYMENTTYPE, foInList, A, "Visa, American Express");
        break;
      case ufList:
        AList->BoolOperatorKind = fboOr;
        AList->AddItem(tvCustomersPAYMENTTYPE, foEqual, cCashID, "Cash");
        AList->AddItem( tvCustomersPAYMENTTYPE, foEqual, cAmExID, "American Express");
    }
      tvCustomers->DataController->Filter->Active = True;
  }
  __finally {
    FLock = false;
  }
}
//---------------------------------------------------------------------------

void TFilterByCodeDemoMainForm::SetOnlyGridsFilter(
  TcxFilterCriteriaItemList *AFilterCriteriaList)
{
  AFilterCriteriaList->Clear();
  AFilterCriteriaList->BoolOperatorKind = fboOr;
  AFilterCriteriaList->
    AddItem(tvCustomersPRODUCTID, foEqual, cExpressQuantumGridID, "ExpressQuantumGrid");
  AFilterCriteriaList->
    AddItem(tvCustomersPRODUCTID, foEqual, cXpressQuantumGridID,  "XpressQuantumGrid");
  AFilterCriteriaList->
    AddItem(tvCustomersPRODUCTID, foEqual, cExtraGridID, "XtraGrid");
  AFilterCriteriaList->
    AddItem(tvCustomersPRODUCTID, foEqual, cASPXGridID, "ASPX Grid");
}
//---------------------------------------------------------------------------



