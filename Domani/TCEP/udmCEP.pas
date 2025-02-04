unit udmCEP;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, DB, SqlExpr;

type
  TdmCEP = class(TDataModule)
    sqlCEP: TSQLConnection;
    qryCEP: TSQLQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmCEP: TdmCEP;

implementation

{$R *.dfm}

end.
