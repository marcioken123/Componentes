//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "UnitMain.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "CoolDBUtils"
#pragma link "CoolUtility"
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
    : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::CoolDBBackup1ActionInProgress(TObject *Sender,
      int TablesNum, AnsiString CurName, int CurNum)
{
  LabelProgress->Caption = CurName;
  ProgressBar1->Max = TablesNum;
  ProgressBar1->Position = CurNum;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::CoolDBBackup1ExecuteEnd(TObject *Sender)
{
  LabelProgress->Caption = "";
  ProgressBar1->Max = 0;
  ProgressBar1->Position = 0;
}
//---------------------------------------------------------------------------

AnsiString BoolToStr(Boolean Value)
{
  if (Value)
    return "True";
  else
    return "False";
}

void __fastcall TForm1::FormCreate(TObject *Sender)
{
  Session->Active = True;

  LabelProgress->Caption = "";
  RadioGroup1Click(this);

  Label19->Caption = IntToStr(CoolBDEInformant1->BDEVersion);
  Label20->Caption = IntToStr(CoolBDEInformant1->BDEInterfaceLevel);
  Label21->Caption = TimeToStr(CoolBDEInformant1->BDEVersionTime);
  Label22->Caption = DateToStr(CoolBDEInformant1->BDEVersionDate);
  Label23->Caption = IntToStr(CoolBDEInformant1->BDEBufferSpace);
  Label24->Caption = IntToStr(CoolBDEInformant1->BDEHeapSpace);
  Label25->Caption = IntToStr(CoolBDEInformant1->BDEDrivers);
  Label26->Caption = IntToStr(CoolBDEInformant1->BDEClients);
  Label27->Caption = IntToStr(CoolBDEInformant1->BDESessions);
  Label28->Caption = IntToStr(CoolBDEInformant1->BDEDatabases);
  Label29->Caption = IntToStr(CoolBDEInformant1->BDECursors);
  Label30->Caption = BoolToStr(CoolBDEInformant1->BDELocalShare);
  Label31->Caption = CoolBDEInformant1->BDENetType;
  Label32->Caption = CoolBDEInformant1->BDEUserName;
  Label33->Caption = ExtractFileName(CoolBDEInformant1->BDEIniFile);
  Label34->Caption = CoolBDEInformant1->BDELangDriver;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::BitBtn1Click(TObject *Sender)
{
  Folder_DB = ExtractFilePath(ParamStr(0)) + "Database";
  Folder_Backup = ExtractFilePath(ParamStr(0)) + "Backup";
  Folder_DBNew = ExtractFilePath(ParamStr(0)) + "DatabaseNew";
  Folder_DBModified = ExtractFilePath(ParamStr(0)) + "DatabaseMod";
  Folder_Service = ExtractFilePath(ParamStr(0)) + "Service";
  File_Structure = ExtractFilePath(ParamStr(0)) + "Demo.dbs";
  Folder_Sort = ExtractFilePath(ParamStr(0)) + "Sort";

  Table1->DatabaseName = Folder_DB;
  Table2->DatabaseName = Folder_DBModified;
  Table1->TableName = "country.db";
  Table2->TableName = "country.db";

  int ActivePageIndex;

  #ifdef ver100
  if (PageControl1->ActivePage == TabSheet1)
  {
    ActivePageIndex = 1;
  }
  else
  {
    if (PageControl1->ActivePage == TabSheet2)
    {
      ActivePageIndex = 2;
    }
    else
    {
      ActivePageIndex = 3;
    }
  }
  #else
  ActivePageIndex = PageControl1->ActivePageIndex;
  #endif

  switch (ActivePageIndex)
  {
    case 1:
    {
      switch (RadioGroup2->ItemIndex)
      {
        case 0:
        {
          CoolDBDatabasesCompare1->DatabaseOneName = Folder_DB;
          CoolDBDatabasesCompare1->DatabaseTwoName = Folder_DBModified;
          CoolDBDatabasesCompare1->ResultType = dbrtTablesAlike;
          CoolDBDatabasesCompare1->Execute();
          Memo1->Lines->Assign(CoolDBDatabasesCompare1->ResultList);
          return;
        }
        case 1:
        {
          CoolDBDatabasesCompare1->DatabaseOneName = Folder_DB;
          CoolDBDatabasesCompare1->DatabaseTwoName = Folder_DBModified;
          CoolDBDatabasesCompare1->ResultType = dbrtTablesDifferent;
          CoolDBDatabasesCompare1->Execute();
          Memo1->Lines->Assign(CoolDBDatabasesCompare1->ResultList);
          return;
        }
        case 2:
        {
          CoolDBDatabasesCompare1->DatabaseOneName = Folder_DB;
          CoolDBDatabasesCompare1->DatabaseTwoName = Folder_DBModified;
          CoolDBDatabasesCompare1->ResultType = dbrtTablesUniqueOne;
          CoolDBDatabasesCompare1->Execute();
          Memo1->Lines->Assign(CoolDBDatabasesCompare1->ResultList);
          return;
        }
        case 3:
        {
          CoolDBDatabasesCompare1->DatabaseOneName = Folder_DB;
          CoolDBDatabasesCompare1->DatabaseTwoName = Folder_DBModified;
          CoolDBDatabasesCompare1->ResultType = dbrtTablesUniqueTwo;
          CoolDBDatabasesCompare1->Execute();
          Memo1->Lines->Assign(CoolDBDatabasesCompare1->ResultList);
          return;
        }
      }
      return;
    }
    case 2:
    {
      switch (RadioGroup3->ItemIndex)
      {
         case 0:
         {
           CoolDBTablesCompare1->ResultType = rtFieldsUniqueOne;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
         case 1:
         {
           CoolDBTablesCompare1->ResultType = rtFieldsUniqueTwo;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
         case 2:
         {
           CoolDBTablesCompare1->ResultType = rtFieldsAlike;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
         case 3:
         {
           CoolDBTablesCompare1->ResultType = rtFieldsDifferent;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
         case 4:
         {
           CoolDBTablesCompare1->ResultType = rtIndexesUniqueOne;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
         case 5:
         {
           CoolDBTablesCompare1->ResultType = rtIndexesUniqueTwo;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
         case 6:
         {
           CoolDBTablesCompare1->ResultType = rtIndexesAlike;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
         case 7:
         {
           CoolDBTablesCompare1->ResultType = rtIndexesDifferent;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
         case 8:
         {
           CoolDBTablesCompare1->ResultType = rtRIntsUniqueOne;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
         case 9:
         {
           CoolDBTablesCompare1->ResultType = rtRIntsUniqueTwo;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
         case 10:
         {
           CoolDBTablesCompare1->ResultType = rtRIntsAlike;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
         case 11:
         {
           CoolDBTablesCompare1->ResultType = rtRIntsDifferent;
           CoolDBTablesCompare1->Execute();
           Memo2->Lines->Assign(CoolDBTablesCompare1->ResultList);
           return;
         }
      }
      return;
    }
    case 3:
    {
      switch (RadioGroup1->ItemIndex)
      {
        case 0:
        {
          CoolDBBackup1->DatabaseName = Folder_DB;
          CoolDBBackup1->DatabaseBackupName = Folder_Backup;
          CoolDBBackup1->Execute();
          return;
        }
        case 1:
        {
          CoolDBPack1->DatabaseName = Folder_DB;
          CoolDBPack1->Execute();
          return;
        }
        case 2:
        {
          CoolDBStructureExporter1->DatabaseName = Folder_DBModified;
          CoolDBStructureExporter1->FileName = File_Structure;
          CoolDBStructureExporter1->Execute();
          return;
        }
        case 3:
        {
          CoolDBStructureRestorer1->DatabaseName = Folder_DBNew;
          CoolDBStructureRestorer1->FileName = File_Structure;
          CoolDBStructureRestorer1->Execute();
          return;
        }
        case 4:
        {
          CoolDBUpdater21->DatabaseName = Folder_DB;
          CoolDBUpdater21->DatabaseImporterName = Folder_DBNew;
          CoolDBUpdater21->Execute();
          return;
        }
        case 5:
        {
          if (FileExists("TUTIL32.DLL"))
          {
            CoolDBUtility1->DatabaseName = Folder_DB;
            CoolDBUtility1->ServiceDatabaseName = Folder_Service;
            CoolDBUtility1->DatabaseAction = daVerify;
            CoolDBUtility1->Execute();
          }
          else
          {
            ShowMessage("Unable to find TUTIL32.DLL in the current path");
          }
          return;
        }
        case 6:
        {
          if (FileExists("TUTIL32.DLL"))
          {
            CoolDBUtility1->DatabaseName = Folder_DB;
            CoolDBUtility1->ServiceDatabaseName = Folder_Service;
            CoolDBUtility1->DatabaseAction = daRepair;
            CoolDBUtility1->Execute();
          }
          else
          {
            ShowMessage("Unable to find TUTIL32.DLL in the current path");
          }
          return;
        }
        case 7:
        {
          CoolDBSort1->DatabaseName = Folder_DB;
          CoolDBSort1->DatabaseSortedName = Folder_Sort;
          CoolDBSort1->Execute();
          return;
        }
      }
      return;
    }
  }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::RadioGroup1Click(TObject *Sender)
{
  switch (RadioGroup1->ItemIndex)
  {
    case 0:
    {
      LabelInfo->Caption = "You can back up  existing DB you have in 'Database' folder...  Copy of the database will be placed to 'Backup' folder.";
      return;
    }
    case 1:
    {
      LabelInfo->Caption = "You can pack your database physically removing already deleted rows";
      return;
    }
    case 2:
    {
      LabelInfo->Caption = "Here you save structure of database from 'Database_Modified'0 folder on disk 'Demo.dbs' file...";
      return;
    }
    case 3:
    {
      LabelInfo->Caption = "Now restore database whose structure was previosly saved in 'Demo.dbs' file... Database will be placed to 'Database_New' folder.";
      return;
    }
    case 4:
    {
      LabelInfo->Caption = "Now update DB in 'Database' folder so that its structure will match to sttructure of DB from 'Database_New' folder...";
      return;
    }
    case 5:
    {
      LabelInfo->Caption = "Now verify tables in 'Database_New' folder to check if there are any broken tables there";
      return;
    }
    case 6:
    {
      LabelInfo->Caption = "Now repair broken tables in 'Database_New' folder (if any)";
      return;
    }
  }
}
//---------------------------------------------------------------------------

