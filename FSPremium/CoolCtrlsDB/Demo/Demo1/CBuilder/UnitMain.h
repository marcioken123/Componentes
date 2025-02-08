//---------------------------------------------------------------------------
#ifndef UnitMainH
#define UnitMainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include "CoolDBUtils.hpp"
#include "CoolUtility.hpp"
#include <Buttons.hpp>
#include <ComCtrls.hpp>
#include <Db.hpp>
#include <DBTables.hpp>
#include <ExtCtrls.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
    TLabel *LabelProgress;
    TProgressBar *ProgressBar1;
    TBitBtn *BitBtn1;
    TBitBtn *BitBtn2;
    TPageControl *PageControl1;
    TTabSheet *TabSheet1;
    TLabel *Label1;
    TRadioGroup *RadioGroup2;
    TMemo *Memo1;
    TTabSheet *TabSheet2;
    TLabel *Label2;
    TRadioGroup *RadioGroup3;
    TMemo *Memo2;
    TTabSheet *TabSheet3;
    TLabel *LabelInfo;
    TTabSheet *TabSheet4;
    TLabel *Label3;
    TLabel *Label4;
    TLabel *Label5;
    TLabel *Label6;
    TLabel *Label7;
    TLabel *Label8;
    TLabel *Label9;
    TLabel *Label10;
    TLabel *Label11;
    TLabel *Label12;
    TLabel *Label13;
    TLabel *Label14;
    TLabel *Label15;
    TLabel *Label16;
    TLabel *Label17;
    TLabel *Label18;
    TLabel *Label19;
    TLabel *Label20;
    TLabel *Label21;
    TLabel *Label22;
    TLabel *Label23;
    TLabel *Label24;
    TLabel *Label25;
    TLabel *Label26;
    TLabel *Label27;
    TLabel *Label28;
    TLabel *Label29;
    TLabel *Label30;
    TLabel *Label31;
    TLabel *Label32;
    TLabel *Label33;
    TLabel *Label34;
    TRadioGroup *RadioGroup1;
    TCoolDBBackup *CoolDBBackup1;
    TCoolDBStructureRestorer *CoolDBStructureRestorer1;
    TCoolDBUpdater2 *CoolDBUpdater21;
    TCoolDBStructureExporter *CoolDBStructureExporter1;
    TCoolDBPack *CoolDBPack1;
    TCoolDBTablesCompare *CoolDBTablesCompare1;
    TCoolDBDatabasesCompare *CoolDBDatabasesCompare1;
    TCoolDBSort *CoolDBSort1;
    TCoolBDEInformant *CoolBDEInformant1;
    TTable *Table1;
    TTable *Table2;
    TCoolDBUtility *CoolDBUtility1;
    void __fastcall CoolDBBackup1ActionInProgress(TObject *Sender,
          int TablesNum, AnsiString CurName, int CurNum);
    void __fastcall CoolDBBackup1ExecuteEnd(TObject *Sender);
    void __fastcall FormCreate(TObject *Sender);
    void __fastcall BitBtn1Click(TObject *Sender);
    void __fastcall RadioGroup1Click(TObject *Sender);
private:	// User declarations
    AnsiString Folder_Service;
    AnsiString Folder_DB;
    AnsiString Folder_Backup;
    AnsiString Folder_DBNew;
    AnsiString Folder_DBModified;
    AnsiString File_Structure;
    AnsiString Folder_Sort;
public:		// User declarations
    __fastcall TForm1(TComponent* Owner);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
