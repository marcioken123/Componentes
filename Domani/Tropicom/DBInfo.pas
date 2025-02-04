unit DBInfo;

interface

uses
  SysUtils, Classes, Windows, Forms;

type
  TDBInfo = class(TComponent)
  private
    FIncrement: Integer;
    FPrimaryKey: String;
    FTableName: String;
    FAjudaHTML: String;
    FAutoQuery: Boolean;
    procedure SetIncrement(const Value: Integer);
    procedure SetPrimaryKey(const Value: String);
    procedure SetTableName(const Value: String);
    procedure SetAjudaHTML(const Value: String);
    procedure SetAutoQuery(const Value: Boolean);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AWOner: TComponent); override;
  published
    { Published declarations }
    property Increment: Integer read FIncrement write SetIncrement;
    property PrimaryKey: String read FPrimaryKey write SetPrimaryKey;
    property TableName: String read FTableName write SetTableName;
    property AjudaHTML: String read FAjudaHTML write SetAjudaHTML;
    property AutoQuery: Boolean read FAutoQuery write SetAutoQuery;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Tropicom', [TDBInfo]);
end;

{ TDBInfo }

constructor TDBInfo.Create(AWOner: TComponent);
begin
  inherited;
  Increment := 1;
  AutoQuery  := True;
end;

procedure TDBInfo.SetAjudaHTML(const Value: String);
begin
  FAjudaHTML := Value;
end;

procedure TDBInfo.SetAutoQuery(const Value: Boolean);
begin
  FAutoQuery := Value;
end;

procedure TDBInfo.SetIncrement(const Value: Integer);
begin
  FIncrement := Value;
end;

procedure TDBInfo.SetPrimaryKey(const Value: String);
begin
  FPrimaryKey := Value;
end;

procedure TDBInfo.SetTableName(const Value: String);
begin
  FTableName := Value;
end;

end.
