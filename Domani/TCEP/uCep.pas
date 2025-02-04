unit uCep;

interface

uses
  SysUtils, Classes, udmCEP, Dialogs;

type
  TCepHost = class(TPersistent)
  private
    FHostname: String;
    FPassword: String;
    FDatabase: String;
    FUsername: String;
    procedure SetDatabase(const Value: String);
    procedure SetHostname(const Value: String);
    procedure SetPassword(const Value: String);
    procedure SetUsername(const Value: String);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create;
  published
    { Published declarations }
    property Hostname: String read FHostname write SetHostname;
    property Username: String read FUsername write SetUsername;
    property Password: String read FPassword write SetPassword;
    property Database: String read FDatabase write SetDatabase;
  end;


type
  TCep = class(TComponent)
  private
    FIDUF: Integer;
    FIDBairro: Integer;
    FIDCidade: Integer;
    FIDLogradouro: Integer;
    FCidade: String;
    FCEP: String;
    FUF: String;
    FBairro: String;
    FLogradouro: String;
    FIDPais: Integer;
    FPais: String;
    FServidor: TCepHost;
    FEstado: String;
    procedure SetBairro(const Value: String);
    procedure SetCEP(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetIDBairro(const Value: Integer);
    procedure SetIDCidade(const Value: Integer);
    procedure SetIDLogradouro(const Value: Integer);
    procedure SetIDUF(const Value: Integer);
    procedure SetLogradouro(const Value: String);
    procedure SetUF(const Value: String);
    procedure SetIDPais(const Value: Integer);
    procedure SetPais(const Value: String);
    procedure SetServidor(const Value: TCepHost);
    procedure SetEstado(const Value: String);
    { Private declarations }
  protected
    { Protected declarations }
    procedure LimparCampos;
    function GetNumber(Texto: String): String;
  public
    { Public declarations }
    constructor Create(AWOner: TComponent); override;
    function RemoverAcentos( str: String ): String;
  published
    { Published declarations }
    Function BuscaCEP(vCEP: String): Boolean;
    Function BuscaCidade(Cidade: String; UF: String): Boolean;
    property CEP: String read FCEP write SetCEP;
    property Logradouro: String read FLogradouro write SetLogradouro;
    property IDLogradouro: Integer read FIDLogradouro write SetIDLogradouro;
    property Bairro: String read FBairro write SetBairro;
    property IDBairro: Integer read FIDBairro write SetIDBairro;
    property Cidade: String read FCidade write SetCidade;
    property IDCidade: Integer read FIDCidade write SetIDCidade;
    property Estado: String read FEstado write SetEstado;
    property UF: String read FUF write SetUF;
    property IDUF: Integer read FIDUF write SetIDUF;
    property Pais: String read FPais write SetPais;
    property IDPais: Integer read FIDPais write SetIDPais;
    property Servidor: TCepHost read FServidor write SetServidor;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Tropicom', [TCep]);
end;

{ TCep }

function TCep.RemoverAcentos( str: String ): String;
var
i: Integer;
begin
for i := 1 to Length ( str ) do
case str[i] of
'á': str[i] := 'a';
'é': str[i] := 'e';
'í': str[i] := 'i';
'ó': str[i] := 'o';
'ú': str[i] := 'u';
'à': str[i] := 'a';
'è': str[i] := 'e';
'ì': str[i] := 'i';
'ò': str[i] := 'o';
'ù': str[i] := 'u';
'â': str[i] := 'a';
'ê': str[i] := 'e';
'î': str[i] := 'i';
'ô': str[i] := 'o';
'û': str[i] := 'u';
'ä': str[i] := 'a';
'ë': str[i] := 'e';
'ï': str[i] := 'i';
'ö': str[i] := 'o';
'ü': str[i] := 'u';
'ã': str[i] := 'a';
'õ': str[i] := 'o'; 
'ñ': str[i] := 'n'; 
'ç': str[i] := 'c'; 
'Á': str[i] := 'A'; 
'É': str[i] := 'E'; 
'Í': str[i] := 'I'; 
'Ó': str[i] := 'O'; 
'Ú': str[i] := 'U'; 
'À': str[i] := 'A'; 
'È': str[i] := 'E'; 
'Ì': str[i] := 'I'; 
'Ò': str[i] := 'O'; 
'Ù': str[i] := 'U'; 
'Â': str[i] := 'A'; 
'Ê': str[i] := 'E'; 
'Î': str[i] := 'I'; 
'Ô': str[i] := 'O'; 
'Û': str[i] := 'U'; 
'Ä': str[i] := 'A'; 
'Ë': str[i] := 'E'; 
'Ï': str[i] := 'I'; 
'Ö': str[i] := 'O'; 
'Ü': str[i] := 'U'; 
'Ã': str[i] := 'A'; 
'Õ': str[i] := 'O'; 
'Ñ': str[i] := 'N'; 
'Ç': str[i] := 'C'; 
end; 
Result := str; 
end;

function TCep.BuscaCEP(vCEP: String): Boolean;
begin
   LimparCampos;
   vCep := GetNumber(vCep);
   if Length(Trim(vCep)) = 8 then
      begin
         if dmCEP = nil then
            dmCEP := TdmCep.Create(Self);

         if not dmCEP.sqlCEP.Connected then
            begin
               dmCEP.sqlCEP.Params.Values['Hostname']  := Servidor.Hostname;
               dmCEP.sqlCEP.Params.Values['User_name'] := Servidor.Username;
               dmCEP.sqlCEP.Params.Values['Password']  := Servidor.Password;
               dmCEP.sqlCEP.Params.Values['Database']  := Servidor.DataBase;
               dmCEP.sqlCEP.Connected := True;
            end;

         try
            try
              dmCEP.qryCEP.Close;
              dmCEP.qryCEP.SQL.Clear;
              dmCEP.qryCEP.SQL.Add('SELECT');
              dmCEP.qryCEP.SQL.Add('ECT_LOGRADOURO.UFE_SG,');
              dmCEP.qryCEP.SQL.Add('ECT_LOGRADOURO.LOG_NU_SEQUENCIAL,');
              dmCEP.qryCEP.SQL.Add('ECT_LOGRADOURO.LOG_TIPO_LOGRADOURO,');
              dmCEP.qryCEP.SQL.Add('ECT_LOGRADOURO.LOG_NOME,');
              dmCEP.qryCEP.SQL.Add('ECT_CIDADES.LOC_NO,');
              dmCEP.qryCEP.SQL.Add('ECT_CIDADES.LOC_NU_SEQUENCIAL,');
              dmCEP.qryCEP.SQL.Add('ECT_CIDADES.LOC_IN_TIPO_LOCALIDADE,');
              dmCEP.qryCEP.SQL.Add('ECT_BAIRROS.BAI_NU_SEQUENCIAL,');
              dmCEP.qryCEP.SQL.Add('ECT_BAIRROS.BAI_NO,');
              dmCEP.qryCEP.SQL.Add('ECT_BAIRROS.BAI_NO_ABREV,');
              dmCEP.qryCEP.SQL.Add('ECT_ESTADOS.UFE_ID,');
              dmCEP.qryCEP.SQL.Add('ECT_ESTADOS.UFE_NO,');
              dmCEP.qryCEP.SQL.Add('ECT_PAISES.PAIS_ID,');
              dmCEP.qryCEP.SQL.Add('ECT_PAISES.PAIS_NOME');
              dmCEP.qryCEP.SQL.Add('FROM ECT_LOGRADOURO');
              dmCEP.qryCEP.SQL.Add('LEFT JOIN ECT_CIDADES ON ECT_CIDADES.LOC_NU_SEQUENCIAL = ECT_LOGRADOURO.LOC_NU_SEQUENCIAL');
              dmCEP.qryCEP.SQL.Add('LEFT JOIN ECT_BAIRROS ON ECT_BAIRROS.BAI_NU_SEQUENCIAL = ECT_LOGRADOURO.BAI_NU_SEQUENCIAL_INI');
              dmCEP.qryCEP.SQL.Add('LEFT JOIN ECT_ESTADOS ON ECT_ESTADOS.UFE_ID = ECT_CIDADES.EST_ID');
              dmCEP.qryCEP.SQL.Add('LEFT JOIN ECT_PAISES  ON ECT_PAISES.PAIS_ID = ECT_ESTADOS.PAIS_ID');
              dmCEP.qryCEP.SQL.Add('WHERE ECT_LOGRADOURO.CEP=' + vCep);
              dmCEP.qryCEP.Open;

              Logradouro   := dmCEP.qryCEP.FieldByName('LOG_NOME').asString;
              Bairro       := dmCEP.qryCEP.FieldByName('BAI_NO_ABREV').asString;
              Cidade       := dmCEP.qryCEP.FieldByName('LOC_NO').asString;
              Estado       := dmCEP.qryCEP.FieldByName('UFE_NO').asString;
              UF           := dmCEP.qryCEP.FieldByName('UFE_SG').asString;
              Pais         := dmCEP.qryCEP.FieldByName('PAIS_NOME').asString;

              IDLogradouro := dmCEP.qryCEP.FieldByName('LOG_NU_SEQUENCIAL').asInteger;
              IDBairro     := dmCEP.qryCEP.FieldByName('BAI_NU_SEQUENCIAL').asInteger;
              IDCidade     := dmCEP.qryCEP.FieldByName('LOC_NU_SEQUENCIAL').asInteger;
              IDUF         := dmCEP.qryCEP.FieldByName('UFE_ID').asInteger;
              IDPais       := dmCEP.qryCEP.FieldByName('PAIS_ID').asInteger;

              dmCEP.qryCEP.Close;
              Result := True;
            except
              on E:Exception do
                 begin
                    Result := False;
                    ShowMessage(E.Message);
                 end;
            end;
         finally
         end;
      end
   else
      Result := False;
end;

function TCep.BuscaCidade(Cidade, UF: String): Boolean;
begin
   LimparCampos;
   if (Length(Trim(Cidade)) > 0) and (Length(Trim(UF)) = 2) then
      begin
         if dmCEP = nil then
            dmCEP := TdmCep.Create(Self);

         if not dmCEP.sqlCEP.Connected then
            begin
               dmCEP.sqlCEP.Params.Values['Hostname']  := Servidor.Hostname;
               dmCEP.sqlCEP.Params.Values['User_name'] := Servidor.Username;
               dmCEP.sqlCEP.Params.Values['Password']  := Servidor.Password;
               dmCEP.sqlCEP.Params.Values['Database']  := Servidor.DataBase;
               dmCEP.sqlCEP.Connected := True;
            end;

         try
            try
              dmCEP.qryCEP.Close;
              dmCEP.qryCEP.SQL.Clear;
              dmCEP.qryCEP.SQL.Add('SELECT');
              dmCEP.qryCEP.SQL.Add('ECT_CIDADES.LOC_NO,');
              dmCEP.qryCEP.SQL.Add('ECT_CIDADES.LOC_NU_SEQUENCIAL,');
              dmCEP.qryCEP.SQL.Add('ECT_CIDADES.LOC_IN_TIPO_LOCALIDADE,');
              dmCEP.qryCEP.SQL.Add('ECT_ESTADOS.UFE_ID,');
              dmCEP.qryCEP.SQL.Add('ECT_ESTADOS.UFE_NO,');
              dmCEP.qryCEP.SQL.Add('ECT_PAISES.PAIS_ID,');
              dmCEP.qryCEP.SQL.Add('ECT_PAISES.PAIS_NOME');
              dmCEP.qryCEP.SQL.Add('FROM ECT_CIDADES');
              dmCEP.qryCEP.SQL.Add('LEFT JOIN ECT_ESTADOS ON ECT_ESTADOS.UFE_ID = ECT_CIDADES.EST_ID');
              dmCEP.qryCEP.SQL.Add('LEFT JOIN ECT_PAISES  ON ECT_PAISES.PAIS_ID = ECT_ESTADOS.PAIS_ID');
              dmCEP.qryCEP.SQL.Add('WHERE ECT_CIDADES.LOC_NO_SEM_ACENTO = ''' + RemoverAcentos(Uppercase(Trim(Cidade))) + '''');
              dmCEP.qryCEP.SQL.Add('AND ECT_CIDADES.UFE_SG=''' + RemoverAcentos(Uppercase(Trim(UF))) + '''');
              dmCEP.qryCEP.Open;

              if not dmCEP.qryCEP.isEmpty then
                 begin
                    Cidade       := dmCEP.qryCEP.FieldByName('LOC_NO').asString;
                    Estado       := dmCEP.qryCEP.FieldByName('UFE_NO').asString;
                    UF           := dmCEP.qryCEP.FieldByName('UFE_SG').asString;
                    Pais         := dmCEP.qryCEP.FieldByName('PAIS_NOME').asString;

                    IDCidade     := dmCEP.qryCEP.FieldByName('LOC_NU_SEQUENCIAL').asInteger;
                    IDUF         := dmCEP.qryCEP.FieldByName('UFE_ID').asInteger;
                    IDPais       := dmCEP.qryCEP.FieldByName('PAIS_ID').asInteger;

                    dmCEP.qryCEP.Close;
                    Result := True;
                 end
              else
                    Result := False;
            except
              on E:Exception do
                 begin
                    Result := False;
                    ShowMessage(E.Message);
                 end;
            end;
         finally
         end;
      end
   else
      Result := False;
end;

constructor TCep.Create(AWOner: TComponent);
begin
  inherited;
  Servidor := TCepHost.Create;
end;

function TCep.GetNumber(Texto: String): String;
Var
   nID: Integer;
begin
   Result := '';
   For nID := 1 to Length(Texto) do
      if Pos(Texto[nID],'0123456789') > 0 then
         Result := Result + Texto[nID];
end;

procedure TCep.LimparCampos;
begin
    CEP          := '';
    Logradouro   := '';
    Bairro       := '';
    Cidade       := '';
    UF           := '';
    Pais         := '';

    IDLogradouro := 0;
    IDBairro     := 0;
    IDCidade     := 0;
    IDUF         := 0;
    IDPais       := 0;
end;

procedure TCep.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TCep.SetCEP(const Value: String);
begin
  FCEP := Value;
end;

procedure TCep.SetCidade(const Value: String);
begin
  FCidade := Value;
end;

procedure TCep.SetEstado(const Value: String);
begin
  FEstado := Value;
end;

procedure TCep.SetIDBairro(const Value: Integer);
begin
  FIDBairro := Value;
end;

procedure TCep.SetIDCidade(const Value: Integer);
begin
  FIDCidade := Value;
end;

procedure TCep.SetIDLogradouro(const Value: Integer);
begin
  FIDLogradouro := Value;
end;

procedure TCep.SetIDPais(const Value: Integer);
begin
  FIDPais := Value;
end;

procedure TCep.SetIDUF(const Value: Integer);
begin
  FIDUF := Value;
end;

procedure TCep.SetLogradouro(const Value: String);
begin
  FLogradouro := Value;
end;

procedure TCep.SetPais(const Value: String);
begin
  FPais := Value;
end;

procedure TCep.SetServidor(const Value: TCepHost);
begin
  FServidor := Value;
end;

procedure TCep.SetUF(const Value: String);
begin
  FUF := Value;
end;

{ TCepHost }

constructor TCepHost.Create;
begin
   inherited Create;
end;

procedure TCepHost.SetDatabase(const Value: String);
begin
  FDatabase := Value;
end;

procedure TCepHost.SetHostname(const Value: String);
begin
  FHostname := Value;
end;

procedure TCepHost.SetPassword(const Value: String);
begin
  FPassword := Value;
end;

procedure TCepHost.SetUsername(const Value: String);
begin
  FUsername := Value;
end;

end.
 