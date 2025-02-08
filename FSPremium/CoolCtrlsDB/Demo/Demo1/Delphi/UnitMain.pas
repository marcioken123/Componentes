unit UnitMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, CoolDBUtils, StdCtrls, Db, DbTables, ExtCtrls, Buttons,
  CoolUtility;

type
  TForm1 = class(TForm)
    ProgressBar1: TProgressBar;
    LabelProgress: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    LabelInfo: TLabel;
    RadioGroup1: TRadioGroup;
    CoolDBBackup1: TCoolDBBackup;
    CoolDBStructureRestorer1: TCoolDBStructureRestorer;
    CoolDBUpdater21: TCoolDBUpdater2;
    CoolDBStructureExporter1: TCoolDBStructureExporter;
    CoolDBPack1: TCoolDBPack;
    CoolDBTablesCompare1: TCoolDBTablesCompare;
    CoolDBDatabasesCompare1: TCoolDBDatabasesCompare;
    RadioGroup2: TRadioGroup;
    Memo1: TMemo;
    RadioGroup3: TRadioGroup;
    Memo2: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Table1: TTable;
    Table2: TTable;
    CoolDBUtility1: TCoolDBUtility;
    CoolDBSort1: TCoolDBSort;
    CoolBDEInformant1: TCoolBDEInformant;
    TabSheet4: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure CoolDBBackup1ActionInProgress(Sender: TObject;
      TablesNum: Integer; CurName: String; CurNum: Integer);
    procedure CoolDBBackup1ExecuteEnd(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    Folder_Service,
    Folder_DB,
    Folder_Backup,
    Folder_DBNew,
    Folder_DBModified,
    Folder_Sort,
    File_Structure: TFileName;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

function BoolToStr(Value: Boolean): string;
begin
  if Value then
    Result := 'True'
  else
    Result := 'False';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Session.Active := True;

  Folder_DB := ExtractFilePath(ParamStr(0)) + 'Database';
  Folder_Backup := ExtractFilePath(ParamStr(0)) + 'Backup';
  Folder_DBNew := ExtractFilePath(ParamStr(0)) + 'DatabaseNew';
  Folder_DBModified := ExtractFilePath(ParamStr(0)) + 'DatabaseMod';
  Folder_Service := ExtractFilePath(ParamStr(0)) + 'Service';
  Folder_Sort := ExtractFilePath(ParamStr(0)) + 'Sort';
  File_Structure := ExtractFilePath(ParamStr(0)) + 'Demo.dbs';

  LabelProgress.Caption := '';
  RadioGroup1Click(Self);

  Table1.DatabaseName := Folder_DB;
  Table2.DatabaseName := Folder_DBModified;
  Table1.TableName := 'country.db';
  Table2.TableName := 'country.db';

  Label19.Caption := IntToStr(CoolBDEInformant1.BDEVersion div 100);
  Label20.Caption := IntToStr(CoolBDEInformant1.BDEInterfaceLevel);
  Label21.Caption := TimeToStr(CoolBDEInformant1.BDEVersionTime);
  Label22.Caption := DateToStr(CoolBDEInformant1.BDEVersionDate);
  Label23.Caption := IntToStr(CoolBDEInformant1.BDEBufferSpace);
  Label24.Caption := IntToStr(CoolBDEInformant1.BDEHeapSpace);
  Label25.Caption := IntToStr(CoolBDEInformant1.BDEDrivers);
  Label26.Caption := IntToStr(CoolBDEInformant1.BDEClients);
  Label27.Caption := IntToStr(CoolBDEInformant1.BDESessions);
  Label28.Caption := IntToStr(CoolBDEInformant1.BDEDatabases);
  Label29.Caption := IntToStr(CoolBDEInformant1.BDECursors);
  Label30.Caption := BoolToStr(CoolBDEInformant1.BDELocalShare);
  Label31.Caption := CoolBDEInformant1.BDENetType;
  Label32.Caption := CoolBDEInformant1.BDEUserName;
  Label33.Caption := ExtractFileName(CoolBDEInformant1.BDEIniFile);
  Label34.Caption := CoolBDEInformant1.BDELangDriver;
end;

procedure TForm1.CoolDBBackup1ActionInProgress(Sender: TObject;
  TablesNum: Integer; CurName: String; CurNum: Integer);
begin
  LabelProgress.Caption := CurName;
  ProgressBar1.Max := TablesNum;
  ProgressBar1.Position := CurNum;
end;

procedure TForm1.CoolDBBackup1ExecuteEnd(Sender: TObject);
begin
  LabelProgress.Caption := '';
  ProgressBar1.Max := 0;
  ProgressBar1.Position := 0;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  ActivePageIndex: Integer;
begin
{$IFDEF VER100}
  if PageControl1.ActivePage = TabSheet1 then
    ActivePageIndex := 1
  else
    if PageControl1.ActivePage = TabSheet2 then
      ActivePageIndex := 2
    else
      ActivePageIndex := 3;
{$ELSE}
  ActivePageIndex := PageControl1.ActivePageIndex;
{$ENDIF}
  case ActivePageIndex of
    1:
      case RadioGroup2.ItemIndex of
        0:
          with CoolDBDatabasesCompare1 do
          begin
            DatabaseOneName := Folder_DB;
            DatabaseTwoName := Folder_DBModified;
            ResultType := dbrtTablesAlike;
            Execute;
            Memo1.Lines.Assign(ResultList);
          end;
        1:
          with CoolDBDatabasesCompare1 do
          begin
            DatabaseOneName := Folder_DB;
            DatabaseTwoName := Folder_DBModified;
            ResultType := dbrtTablesDifferent;
            Execute;
            Memo1.Lines.Assign(ResultList);
          end;
        2:
          with CoolDBDatabasesCompare1 do
          begin
            DatabaseOneName := Folder_DB;
            DatabaseTwoName := Folder_DBModified;
            ResultType := dbrtTablesUniqueOne;
            Execute;
            Memo1.Lines.Assign(ResultList);
          end;
        3:
          with CoolDBDatabasesCompare1 do
          begin
            DatabaseOneName := Folder_DB;
            DatabaseTwoName := Folder_DBModified;
            ResultType := dbrtTablesUniqueTwo;
            Execute;
            Memo1.Lines.Assign(ResultList);
          end;
      end;
    2:
      case RadioGroup3.ItemIndex of
         0:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtFieldsUniqueOne;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
         1:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtFieldsUniqueTwo;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
         2:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtFieldsAlike;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
         3:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtFieldsDifferent;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
         4:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtIndexesUniqueOne;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
         5:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtIndexesUniqueTwo;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
         6:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtIndexesAlike;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
         7:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtIndexesDifferent;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
         8:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtRIntsUniqueOne;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
         9:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtRIntsUniqueTwo;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
        10:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtRIntsAlike;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
        11:
           with CoolDBTablesCompare1 do
           begin
             ResultType := rtRIntsDifferent;
             Execute;
             Memo2.Lines.Assign(ResultList);
           end;
      end;
    3:
      case RadioGroup1.ItemIndex of
        0:
          with CoolDBBackup1 do
          begin
            DatabaseName := Folder_DB;
            DatabaseBackupName := Folder_Backup;
            Execute;
          end;
        1:
          with CoolDBPack1 do
          begin
            DatabaseName := Folder_DB;
            Execute;
          end;
        2:
          with CoolDBStructureExporter1 do
          begin
            DatabaseName := Folder_DBModified;
            FileName := File_Structure;
            Execute;
          end;
        3:
          with CoolDBStructureRestorer1 do
          begin
            DatabaseName := Folder_DBNew;
            FileName := File_Structure;
            Execute;
          end;
        4:
          with CoolDBUpdater21 do
          begin
            DatabaseName := Folder_DB;
            DatabaseImporterName := Folder_DBNew;
            Execute;
          end;
        5:
          with CoolDBUtility1 do
          begin
            if FileExists('TUTIL32.DLL') then
            begin
              DatabaseName := Folder_DB;
              ServiceDatabaseName := Folder_Service;
              DatabaseAction := daVerify;
              Execute;
            end
            else
            ShowMessage('Unable to find TUTIL32.DLL in the current path');
          end;
        6:
          with CoolDBUtility1 do
          begin
            if FileExists('TUTIL32.DLL') then
            begin
              DatabaseName := Folder_DB;
              ServiceDatabaseName := Folder_Service;
              DatabaseAction := daRepair;
              Execute;
            end
            else
            ShowMessage('Unable to find TUTIL32.DLL in the current path');
          end;
        7:
          with CoolDBSort1 do
          begin
            DatabaseName := Folder_DB;
            DatabaseSortedName := Folder_Sort;
            Execute;
          end;
      end;
  end;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    0:
    LabelInfo.Caption := 'You can back up  existing DB you have in "Database" folder...  Copy of the database will be placed to "Backup" folder.';
    1:
    LabelInfo.Caption := 'You can pack your database physically removing already deleted rows';
    2:
    LabelInfo.Caption := 'Here you save structure of database from "Database_Modified" folder on disk "Demo.dbs"  file...';
    3:
    LabelInfo.Caption := 'Now restore database whose structure was previosly saved in "Demo.dbs" file... Database will be placed to "Database_New" folder.';
    4:
    LabelInfo.Caption := 'Now update DB in "Database" folder so that its structure will match to sttructure of DB from "Database_New" folder...';
    5:
    LabelInfo.Caption := 'Now verify tables in "Database_New" folder to check if there are any broken tables there';
    6:
    LabelInfo.Caption := 'Now repair broken tables in "Database_New" folder (if any)';
  end;
end;

end.
