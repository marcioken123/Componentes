unit EditorsStylesDemoData;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBTables, Db;

type
  TEditorsStylesDemoDataDM = class(TDataModule)
    tblProjects: TTable;
    tblItems: TTable;
    tblUsers: TTable;
    tblNoteBook: TTable;
    Database: TDatabase;
    dsProjects: TDataSource;
    dsItems: TDataSource;
    dsNoteBook: TDataSource;
    dsUsers: TDataSource;
    tblItemsID: TAutoIncField;
    tblItemsNAME: TStringField;
    tblItemsTYPE: TBooleanField;
    tblItemsPROJECTID: TIntegerField;
    tblItemsPRIORITY: TSmallintField;
    tblItemsSTATUS: TSmallintField;
    tblItemsCREATORID: TIntegerField;
    tblItemsCREATEDDATE: TDateTimeField;
    tblItemsOWNERID: TIntegerField;
    tblItemsLASTMODIFIEDDATE: TDateTimeField;
    tblItemsFIXEDDATE: TDateTimeField;
    tblItemsDESCRIPTION: TMemoField;
    tblItemsRESOLUTION: TMemoField;
    tblItemsPROGRESS: TIntegerField;
    tblItemsCHECKPROGRESS: TIntegerField;
    tblItemsFIRSTTARGET: TIntegerField;
    tblItemsNOTIFICATIONS: TStringField;
    tblItemsIDES: TStringField;
    tblProjectsID: TAutoIncField;
    tblProjectsNAME: TStringField;
    tblProjectsMANAGERID: TIntegerField;
    tblUsersID: TAutoIncField;
    tblUsersFNAME: TStringField;
    tblUsersMNAME: TStringField;
    tblUsersLNAME: TStringField;
    tblUsersCOUNTRY: TStringField;
    tblUsersPOSTALCODE: TStringField;
    tblUsersCITY: TStringField;
    tblUsersADDRESS: TStringField;
    tblUsersPHONE: TStringField;
    tblUsersFAX: TStringField;
    tblUsersEMAIL: TStringField;
    tblUsersHOMEPAGE: TStringField;
    tblNoteBookID: TAutoIncField;
    tblNoteBookNAME: TStringField;
    tblNoteBookDATE: TDateTimeField;
    tblNoteBookNOTE: TMemoField;
    tblNoteBookNOTEFONT: TStringField;
    tblNoteBookNOTEFONTCOLOR: TIntegerField;
    tblNoteBookNOTETEXTSIZE: TIntegerField;
    tblNoteBookNOTETEXTBKCOLOR: TIntegerField;
    tblUsersUserName: TStringField;
    procedure tblUsersCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  EditorsStylesDemoDataDM: TEditorsStylesDemoDataDM;

implementation

{$R *.DFM}

procedure TEditorsStylesDemoDataDM.tblUsersCalcFields(DataSet: TDataSet);
begin
  with EditorsStylesDemoDataDM do
  	tblUsersUserName.Value := tblUsersFNAME.Value + ' ' + tblUsersLNAME.Value; 
end;

end.
