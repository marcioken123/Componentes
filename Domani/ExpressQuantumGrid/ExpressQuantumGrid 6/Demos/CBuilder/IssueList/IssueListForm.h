//---------------------------------------------------------------------------

#ifndef IssueListFormH
#define IssueListFormH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <DBCtrls.hpp>
#include <ExtCtrls.hpp>
#include "cxControls.hpp"
#include "cxNavigator.hpp"

  class TIssueListGridForm;

//---------------------------------------------------------------------------
  class TfrmBasic : public TForm
  {
  __published:
    TLabel *lbCaption;
    TPanel *plTop;
    TcxNavigator *cxNavigator;
  private:
    TIssueListGridForm* FGridForm;
    String GetCaption();
    void SetCaption(String ACaption);
  public:
    __fastcall TfrmBasic(TComponent* Owner);
    __property String Caption = {read=GetCaption,write = SetCaption};
    __property TIssueListGridForm *GridForm = {read = FGridForm};
  };
//---------------------------------------------------------------------------
extern PACKAGE TfrmBasic *frmBasic;
//---------------------------------------------------------------------------
#endif
