//---------------------------------------------------------------------------

#ifndef ViewCardDemoDataH
#define ViewCardDemoDataH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxClasses.hpp"
#include "cxGridTableView.hpp"
#include "cxStyles.hpp"
#include <DB.hpp>
#include "cxDBEditRepository.hpp"
#include "cxEdit.hpp"
#include "cxEditRepositoryItems.hpp"
#include "cxGridCardView.hpp"
#include <ImgList.hpp>
#include <DBTables.hpp>
#include <Db.hpp>
//---------------------------------------------------------------------------
class TViewCardDemoDataDM : public TDataModule
{
__published:	// IDE-managed Components
  TDatabase *Database;
  TTable *tblPersons;
  TStringField *tblPersonsFullName;
  TAutoIncField *tblPersonsID;
  TStringField *tblPersonsFIRSTNAME;
  TStringField *tblPersonsSECONDNAME;
  TBooleanField *tblPersonsGENDER;
  TStringField *tblPersonsBIRTHNAME;
  TDateTimeField *tblPersonsDATEOFBIRTH;
  TIntegerField *tblPersonsBIRTHCOUNTRY;
  TStringField *tblPersonsLOCATIONOFBIRTH;
  TMemoField *tblPersonsBIOGRAPHY;
  TStringField *tblPersonsNICKNAME;
  TStringField *tblPersonsHOMEPAGE;
  TDataSource *dsPersons;
  TImageList *ilPics;
  TTable *tblCountries;
  TDataSource *dsCountries;
  void __fastcall tblPersonsCalcFields(TDataSet *DataSet);
private:	// User declarations
public:		// User declarations
  __fastcall TViewCardDemoDataDM(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TViewCardDemoDataDM *ViewCardDemoDataDM;
//---------------------------------------------------------------------------
#endif
