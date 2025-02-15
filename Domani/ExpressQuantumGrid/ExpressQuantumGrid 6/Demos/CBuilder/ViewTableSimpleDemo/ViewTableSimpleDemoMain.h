//---------------------------------------------------------------------------

#ifndef ViewTableSimpleDemoMainH
#define ViewTableSimpleDemoMainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "cxClasses.hpp"
#include "cxControls.hpp"
#include "cxCustomData.hpp"
#include "cxData.hpp"
#include "cxDBData.hpp"
#include "cxEdit.hpp"
#include "cxFilter.hpp"
#include "cxGraphics.hpp"
#include "cxGrid.hpp"
#include "cxGridCustomTableView.hpp"
#include "cxGridCustomView.hpp"
#include "cxGridDBTableView.hpp"
#include "cxGridLevel.hpp"
#include "cxGridTableView.hpp"
#include "cxStyles.hpp"
#include <ActnList.hpp>
#include <ComCtrls.hpp>
#include <DB.hpp>
#include <ExtCtrls.hpp>
#include <ImgList.hpp>
#include <Menus.hpp>
#include "cxLookAndFeels.hpp"
//---------------------------------------------------------------------------
class TViewTableSimpleDemoMainForm : public TForm
{
__published:	// IDE-managed Components
  TSplitter *Splitter;
  TLabel *lbDescription;
  TPanel *pnGenres;
  TPanel *pnGenresCaption;
  TcxGrid *cxgGenras;
  TcxGridDBTableView *cxgGenrasDBTableView;
  TcxGridDBColumn *cxgGenrasDBTableViewNAME;
  TcxGridLevel *cxgGenrasLevel;
  TPanel *pnFilms;
  TPanel *pnFilmsCaption;
  TcxGrid *cxgFilms;
  TcxGridDBTableView *cxgFilmsDBTableView;
  TcxGridDBColumn *cxgFilmsDBTableViewICON;
  TcxGridDBColumn *cxgFilmsDBTableViewCAPTION;
  TcxGridDBColumn *cxgFilmsDBTableViewYEAR;
  TcxGridDBColumn *cxgFilmsDBTableViewTAGLINE;
  TcxGridDBColumn *cxgFilmsDBTableViewPLOTOUTLINE;
  TcxGridDBColumn *cxgFilmsDBTableViewRUNTIME;
  TcxGridDBColumn *cxgFilmsDBTableViewCOLOR;
  TcxGridDBColumn *cxgFilmsDBTableViewPHOTO;
  TcxGridDBColumn *cxgFilmsDBTableViewWEBSITE;
  TcxGridLevel *cxgFilmsLevel;
  TStatusBar *sbMain;
  TMainMenu *mmMain;
  TMenuItem *miFile;
  TMenuItem *miExit;
  TMenuItem *miOptions;
  TMenuItem *miMultiSelect;
  TMenuItem *miShowIndicator;
  TMenuItem *miSeparator5;
  TMenuItem *miIncSearch;
  TMenuItem *miImmediateEditor;
  TMenuItem *miFocusCellOnTab;
  TMenuItem *miShowPreviewRow;
  TMenuItem *miAbout;
  TMenuItem *miShowNavigator;
  TcxLookAndFeelController *LookAndFeelController;
  void __fastcall FormShow(TObject *Sender);
  void __fastcall miAboutClick(TObject *Sender);
  void __fastcall miExitClick(TObject *Sender);
  void __fastcall miShowPreviewRowClick(TObject *Sender);
  void __fastcall miFocusCellOnTabClick(TObject *Sender);
  void __fastcall miIncSearchClick(TObject *Sender);
  void __fastcall miImmediateEditorClick(TObject *Sender);
  void __fastcall miMultiSelectClick(TObject *Sender);
  void __fastcall miShowIndicatorClick(TObject *Sender);
  void __fastcall miShowNavigatorClick(TObject *Sender);
private:	// User declarations
  void __fastcall FocusRomanceCategory();
public:		// User declarations
  __fastcall TViewTableSimpleDemoMainForm(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TViewTableSimpleDemoMainForm *ViewTableSimpleDemoMainForm;
//---------------------------------------------------------------------------
#endif
