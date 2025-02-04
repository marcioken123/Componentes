unit ArquivoBancario;

interface

uses
  SysUtils, Classes, Controls, Dialogs, Contnrs;

type
  TTipoArquivoBancario = (aOFC, aOFX, aQIF);
  TTipoMovimentacao = (opCredito, opDebito);

  TMovimentacao = class(TPersistent)
  private
    FValor: Real;                               
    FDataHora: TDateTime;
    FCodigoBancario: String;
    FOperacao: String;
    FTipoMovimentacao: TTipoMovimentacao;
    FDescricao: String;
    FDocumento: String;
    procedure SetDataHora(const Value: TDateTime);
    procedure SetValor(const Value: Real);
    procedure SetCodigoBancario(const Value: String);
    procedure SetOperacao(const Value: String);
    procedure SetTipoMovimentacao(const Value: TTipoMovimentacao);
    procedure SetDescricao(const Value: String);
    procedure SetDocumento(const Value: String);
    { Private declarations }
  protected
    { Protected declarations }
  public
    Constructor Create;
    procedure Assign(mMovimentacao: TMovimentacao);
    { Public declarations }
  published
     property CodigoBancario: String read FCodigoBancario write SetCodigoBancario;
     property Valor: Real read FValor write SetValor;
     property DataHora: TDateTime read FDataHora write SetDataHora;
     property TipoMovimentacao: TTipoMovimentacao read FTipoMovimentacao write SetTipoMovimentacao;
     property Operacao: String read FOperacao write SetOperacao;
     property Descricao: String read FDescricao write SetDescricao;
     property Documento: String read FDocumento write SetDocumento;
    { Published declarations }
  end;

  TMovimentacaoList = class(TObjectList)
  private
    function GetItem(Index: integer): TMovimentacao;
    procedure SetItem(Index: integer; const Value: TMovimentacao);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
     function    Add(mMovimentacao: TMovimentacao): Integer;
     property    Items[Index : integer] : TMovimentacao read GetItem write SetItem; default;
  published
    { Published declarations }
  end;

  TConta = class(TPersistent)
  private
    FAgencia: String;
    FConta: String;
    FSaldoAtual: Real;
    FDigitoAgencia: String;
    FDigitoConta: String;
    FDescricao: String;
    procedure SetAgencia(const Value: String);
    procedure SetConta(const Value: String);
    procedure SetSaldoAtual(const Value: Real);
    procedure SetDigitoAgencia(const Value: String);
    procedure SetDigitoConta(const Value: String);
    procedure SetDescricao(const Value: String);
    { Private declarations }
  published
    property Agencia: String read FAgencia write SetAgencia;
    property Conta: String read FConta write SetConta;
    property DigitoAgencia: String read FDigitoAgencia write SetDigitoAgencia;
    property DigitoConta: String read FDigitoConta write SetDigitoConta;
    property SaldoAtual: Real read FSaldoAtual write SetSaldoAtual;
    property Descricao: String read FDescricao write SetDescricao;
    { Published declarations }
  end;

  TBanco = class(TPersistent)
  private
    FNomeBanco: String;
    FCodigoBanco: String;
    FContaCorrente: TConta;
    procedure SetCodigoBanco(const Value: String);
    procedure SetNomeBanco(const Value: String);
    procedure SetContaCorrente(const Value: TConta);
    { Private declarations }
  protected
    { Protected declarations }
  public
    Constructor Create;
    procedure DefineAgenciaConta(cAgenciaConta: String);
    { Public declarations }
  published
    property CodigoBanco: String read FCodigoBanco write SetCodigoBanco;
    property NomeBanco: String read FNomeBanco write SetNomeBanco;
    property ContaCorrente: TConta read FContaCorrente write SetContaCorrente;
    { Published declarations }
  end;

  TArquivoBancario = class(TComponent)
  private
    FArquivoBancario: String;
    FDataArquivo: TDateTime;
    FDataInicio: TDateTime;
    FDataTermino: TDateTime;
    FBanco: TBanco;
    FMovimentacoes: TMovimentacaoList;
    FTipoArquivo: TTipoArquivoBancario;
    FFormatoArquivo: String;
    FPaginaCaracteres: String;
    FTipoCaracteres: String;
    FVersaoArquivo: String;
    FNivelSeguranca: String;
    FCompressao: String;
    procedure SetDataArquivo(const Value: TDateTime);
    procedure SetDataInicio(const Value: TDateTime);
    procedure SetDataTermino(const Value: TDateTime);
    procedure SetMovimentacoes(const Value: TMovimentacaoList);
    procedure SetTipoArquivo(const Value: TTipoArquivoBancario);
    procedure SetCompressao(const Value: String);
    procedure SetFormatoArquivo(const Value: String);
    procedure SetNivelSeguranca(const Value: String);
    procedure SetPaginaCaracteres(const Value: String);
    procedure SetTipoCaracteres(const Value: String);
    procedure SetVersaoArquivo(const Value: String);
    procedure LoadOFXSetup;
    procedure LoadOFCSetup;
    Function CheckFileOFX(ArquivoBancario: String): Boolean;
    Function CheckFileOFC(ArquivoBancario: String): Boolean;
    Function GetStartDate(ArquivoBancario: String): TDateTime;
    Function GetEndDate(ArquivoBancario: String): TDateTime;
    procedure CarregarMovimentao;
    { Private declarations }
  protected
    { Protected declarations }
  public
    Constructor Create(AWOner: TComponent); override;
    property Movimentacoes: TMovimentacaoList read FMovimentacoes write SetMovimentacoes;
    Function LoadFromFileOFC_OFX(pArquivoBancario: String): Integer;
    Function LoadFromFileTXT(pArquivoBancario: String; nBanco: Integer ): Integer;
    { Public declarations }
  published
    property Banco: TBanco read FBanco write fBanco;
    property DataArquivo: TDateTime read FDataArquivo write SetDataArquivo;
    property DataInicio: TDateTime read FDataInicio write SetDataInicio;
    property DataTermino: TDateTime read FDataTermino write SetDataTermino;
    property TipoArquivo: TTipoArquivoBancario read FTipoArquivo write SetTipoArquivo;
    property FormatoArquivo: String read FFormatoArquivo write SetFormatoArquivo;
    property VersaoArquivo: String read FVersaoArquivo write SetVersaoArquivo;
    property NivelSeguranca: String read FNivelSeguranca write SetNivelSeguranca;
    property TipoCaracteres: String read FTipoCaracteres write SetTipoCaracteres;
    property PaginaCaracteres: String read FPaginaCaracteres write SetPaginaCaracteres;
    property Compressao: String read FCompressao write SetCompressao;
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Protheus', [TArquivoBancario]);
end;

{ TArquivoBancario }

function TArquivoBancario.CheckFileOFC(ArquivoBancario: String): Boolean;
Var
   ArqBan: TextFile;
   cLinha: String;
begin
   try
      AssignFile(ArqBan, fArquivoBancario);
      Reset(ArqBan);
      ReadLN(ArqBan, cLinha);
      if Copy(cLinha,1,9) = '<OFC>' then
         Result := True
      else
         Result := False;
   finally
      CloseFile(ArqBan);
   end;
end;

function TArquivoBancario.CheckFileOFX(ArquivoBancario: String): Boolean;
Var
   ArqBan: TextFile;
   cLinha: String;
begin
   try
      AssignFile(ArqBan, fArquivoBancario);
      Reset(ArqBan);
      ReadLN(ArqBan, cLinha);
      if Copy(cLinha,1,9) = 'OFXHEADER' then
         Result := True
      else
         Result := False;
   finally
      CloseFile(ArqBan);
   end;
end;

constructor TArquivoBancario.Create(AWOner: TComponent);
begin
   inherited;
   Movimentacoes := TMovimentacaoList.Create;
   Banco := TBanco.Create;
   TipoArquivo := aOFX;
end;

Function TArquivoBancario.GetStartDate(ArquivoBancario: String): TDateTime;
Var
   ArqBan: TextFile;
   cLinha: String;
   cData: String;
begin
   try
      AssignFile(ArqBan, fArquivoBancario);
      Reset(ArqBan);
      Result := 0;

      While not Eof(ArqBan) do
         begin
            ReadLN(ArqBan, cLinha);
            if Pos('<DTSTART>', cLinha) > 0 then
               begin
                  cData := Copy(cLinha,Pos('>', cLinha) + 1, Length(cLinha));
                  Break;
               end;
         end;
      try
         if Length(Trim(cData)) > 0 then
            Result := StrToDateTime(Copy(cData,7,2) + '/' + Copy(cData,5,2) + '/' + Copy(cData,1,4));
      except
         Result := 0;
      end;
   finally
      CloseFile(ArqBan);
   end;
end;

function TArquivoBancario.GetEndDate(ArquivoBancario: String): TDateTime;
Var
   ArqBan: TextFile;
   cLinha: String;
   cData: String;
begin
   try
      AssignFile(ArqBan, fArquivoBancario);
      Reset(ArqBan);

      Result := 0;

      While not Eof(ArqBan) do
         begin
            ReadLN(ArqBan, cLinha);
            if Pos('<DTEND>', cLinha) > 0 then
               begin
                  cData := Copy(cLinha,Pos('>', cLinha) + 1, Length(cLinha));
                  Break;
               end;
         end;
      try
         if Length(Trim(cData)) > 0 then
            Result := StrToDateTime(Copy(cData,7,2) + '/' + Copy(cData,5,2) + '/' + Copy(cData, 1,4));
      except
         Result := 0;
      end;
   finally
      CloseFile(ArqBan);
   end;
end;

Function TArquivoBancario.LoadFromFileOFC_OFX(pArquivoBancario: String): Integer;
Var
   ArqBan: TextFile;
   cLinha: String;
   ArquivoIdentificado: Boolean;
begin
   FArquivoBancario := pArquivoBancario;
   Result := 0;
   ArquivoIdentificado := True;
   try
      Movimentacoes.Clear;
      Banco.ContaCorrente.Agencia := '';
      Banco.ContaCorrente.DigitoAgencia := '';
      Banco.Contacorrente.Conta   := '';
      Banco.ContaCorrente.DigitoConta := '';
      Banco.ContaCorrente.Descricao := '';
      Banco.CodigoBanco := '';
      Banco.NomeBanco := '';
      AssignFile(ArqBan, fArquivoBancario);
      Reset(ArqBan);

      Readln(ArqBan, cLinha);
      if CheckFileOFX(pArquivoBancario) then
         begin
            TipoArquivo := aOFX;
            LoadOFXSetup
         end
      else
      if CheckFileOFC(pArquivoBancario) then
         begin
            TipoArquivo := aOFC;
            LoadOFCSetup
         end
      else
         begin
            Result := 1;
            ArquivoIdentificado := False
         end;

   if ArquivoIdentificado then
      CarregarMovimentao;
   finally
      CloseFile(ArqBan);
   end;
end;

procedure TArquivoBancario.LoadOFXSetup;
Var
   ArqBan: TextFile;
   cLinha: String;
begin
   AssignFile(ArqBan, fArquivoBancario);
   try
      Reset(ArqBan);
      while not Eof(ArqBan) do
         begin
            Readln(ArqBan, cLinha);
            if Copy(cLinha,1,4) = 'DATA' then
               FormatoArquivo := Copy(cLinha,6,Length(cLinha))
            else
            if Copy(cLinha,1,7) = 'VERSION' then
               VersaoArquivo  := Copy(cLinha,9,Length(cLinha))
            else
            if Copy(cLinha,1,8) = 'SECURITY' then
               VersaoArquivo  := Copy(cLinha,10,Length(cLinha))
            else
            if Copy(cLinha,1,8) = 'ENCODING' then
               VersaoArquivo  := Copy(cLinha,10,Length(cLinha))
            else
            if Copy(cLinha,1,7) = 'CHARSET' then
               VersaoArquivo  := Copy(cLinha,9,Length(cLinha))
            else
            if Copy(cLinha,1,11) = 'COMPRESSION' then
               VersaoArquivo  := Copy(cLinha,13,Length(cLinha))
            else
            if Pos('<OFX>', cLinha) > 0 then
               Break;
         end;
   finally
      Closefile(ArqBan);
   end;
   DataInicio  := GetStartDate(fArquivoBancario);
   DataTermino := GetEndDate(fArquivoBancario);
end;

procedure TArquivoBancario.LoadOFCSetup;
Var
   ArqBan: TextFile;
   cLinha: String;
begin
   AssignFile(ArqBan, fArquivoBancario);
   try
      Reset(ArqBan);
      while not Eof(ArqBan) do
         begin
            Readln(ArqBan, cLinha);
            if Copy(cLinha,1,4) = 'DATA' then
               FormatoArquivo := ''
            else
            if Copy(cLinha,1,7) = 'VERSION' then
               VersaoArquivo  := ''
            else
            if Copy(cLinha,1,8) = 'SECURITY' then
               VersaoArquivo  := ''
            else
            if Copy(cLinha,1,8) = 'ENCODING' then
               VersaoArquivo  := ''
            else
            if Copy(cLinha,1,7) = 'CHARSET' then
               VersaoArquivo  := ''
            else
            if Copy(cLinha,1,11) = 'COMPRESSION' then
               VersaoArquivo  := ''
            else
            if Pos('<STMTRS>', cLinha) > 0 then
               Break;
         end;
   finally
      Closefile(ArqBan);
   end;

   DataInicio  := GetStartDate(fArquivoBancario);
   DataTermino := GetEndDate(fArquivoBancario);

end;

procedure TArquivoBancario.SetCompressao(const Value: String);
begin
  FCompressao := Value;
end;

procedure TArquivoBancario.SetDataArquivo(const Value: TDateTime);
begin
  FDataArquivo := Value;
end;

procedure TArquivoBancario.SetDataInicio(const Value: TDateTime);
begin
  FDataInicio := Value;
end;

procedure TArquivoBancario.SetDataTermino(const Value: TDateTime);
begin
  FDataTermino := Value;
end;

procedure TArquivoBancario.SetFormatoArquivo(const Value: String);
begin
  FFormatoArquivo := Value;
end;

procedure TArquivoBancario.SetMovimentacoes(
  const Value: TMovimentacaoList);
begin
  FMovimentacoes := Value;
end;

procedure TArquivoBancario.SetNivelSeguranca(const Value: String);
begin
  FNivelSeguranca := Value;
end;

procedure TArquivoBancario.SetPaginaCaracteres(const Value: String);
begin
  FPaginaCaracteres := Value;
end;

procedure TArquivoBancario.SetTipoArquivo(
  const Value: TTipoArquivoBancario);
begin
  FTipoArquivo := Value;
end;

procedure TArquivoBancario.SetTipoCaracteres(const Value: String);
begin
  FTipoCaracteres := Value;
end;

procedure TArquivoBancario.SetVersaoArquivo(const Value: String);
begin
  FVersaoArquivo := Value;
end;

procedure TArquivoBancario.CarregarMovimentao;

   Function RemoveCaracter(Texto: String; Caracteres: String): String;
   Var
      nCol: Integer;
   begin
      Result := '';
      Texto := Trim(Texto);
      For nCol := 1 to Length(Trim(Texto)) do
         if Pos(Copy(Texto,nCol,1), Caracteres) = 0 then
            Result := Result + Copy(Texto,nCol,1);
   end;

Var
   ArqBan: TextFile;
   cLinha: String;
   NovoMov: TMovimentacao;
begin
   AssignFile(ArqBan, fArquivoBancario);
   try
      Reset(ArqBan);
      while not Eof(ArqBan) do
         begin
            ReadLN(ArqBan, cLinha);
            cLinha := Trim(cLinha);
            if TipoArquivo = aOFX then
               begin
                  if Pos('<STMTTRN>', cLinha) > 0 then
                     NovoMov := TMovimentacao.Create
                  else
                  if Pos('<TRNTYPE>', cLinha) > 0 then
                     begin
                        if Pos('DEBIT', cLinha) > 0 then
                          NovoMov.TipoMovimentacao := opDebito
                        else
                        if Pos('CREDIT', cLinha) > 0 then
                          NovoMov.TipoMovimentacao := opCredito;
                     end
                  else
                  if Pos('<DTPOSTED>', cLinha) > 0 then
                     NovoMov.DataHora := StrToDateTime(Copy(cLinha,17,2) + '/' + Copy(cLinha,15,2) + '/' + Copy(cLinha,11,4))
                  else
                  if Pos('<TRNAMT>', cLinha) > 0 then
                     NovoMov.Valor := StrToFloat(RemoveCaracter(Copy(cLinha,9,Length(cLinha)), '.,'))/100
                  else
                  if Pos('<FITID>', cLinha) > 0 then
                     NovoMov.CodigoBancario := Copy(cLinha, 8, Length(cLinha))
                  else
                  if Pos('<CHKNUM>', cLinha) > 0 then
                     NovoMov.Documento := Copy(cLinha, 9, Length(cLinha))
                  else
                  if Pos('<MEMO>', cLinha) > 0 then
                     NovoMov.Descricao := Copy(cLinha, 7, Length(cLinha))
                  else
                  if Pos('</STMTTRN>', cLinha) > 0 then
                     Movimentacoes.Add(NovoMov)
                  else
                  if Pos('<BALAMT>', cLinha) > 0 then
                     Banco.ContaCorrente.SaldoAtual := StrToFloat(RemoveCaracter(Copy(cLinha,9,Length(cLinha)), '.,'))/100
                  else
                  if Pos('<BANKID>', cLinha) > 0 then
                     Banco.CodigoBanco := Copy(cLinha,9,Length(cLinha))
                  else
                  if Pos('<ACCTID>', cLinha) > 0 then
                     Banco.DefineAgenciaConta(Copy(cLinha,9,Length(cLinha)));
               end
            else
            if TipoArquivo = aOFC then
               begin
                  if Pos('<STMTTRN>', cLinha) > 0 then
                     NovoMov := TMovimentacao.Create
                  else
                  if Pos('<DTPOSTED>', cLinha) > 0 then
                     NovoMov.DataHora := StrToDateTime(Copy(cLinha,17,2) + '/' + Copy(cLinha,15,2) + '/' + Copy(cLinha,11,4))
                  else
                  if Pos('<CHKNUM>', cLinha) > 0 then
                     NovoMov.Documento := Copy(cLinha, 9, Length(cLinha))
                  else
                  if Pos('<TRNAMT>', cLinha) > 0 then
                     begin
                        NovoMov.Valor := StrToFloat(RemoveCaracter(Copy(cLinha,9,Length(cLinha)), '.,'))/100;
                        if NovoMov.Valor > 0 then
                           NovoMov.TipoMovimentacao := opDebito
                        else
                           NovoMov.TipoMovimentacao := opCredito;
                     end
                  else
                  if Pos('<MEMO>', cLinha) > 0 then
                     NovoMov.Descricao := Copy(cLinha, 7, Length(cLinha))
                  else
                  if Pos('</STMTTRN>', cLinha) > 0 then
                     Movimentacoes.Add(NovoMov)
                  else
                  if Pos('<BALAMT>', cLinha) > 0 then
                     Banco.ContaCorrente.SaldoAtual := StrToFloat(RemoveCaracter(Copy(cLinha,9,Length(cLinha)), '.,'))/100
                  else
                  if Pos('<BANKID>', cLinha) > 0 then
                     Banco.CodigoBanco := Copy(cLinha,9,Length(cLinha))
                  else
                  if Pos('<ACCTID>', cLinha) > 0 then
                     Banco.DefineAgenciaConta(Copy(cLinha,9,Length(cLinha)));
               end;
         end;
   finally
      CloseFile(ArqBan);
   end;
end;

function TArquivoBancario.LoadFromFileTXT(pArquivoBancario: String; nBanco: Integer ): Integer;
Var
   ArqBan: TextFile;
   cLinha: String;
begin
   Result := 0;
   AssignFile(ArqBan, fArquivoBancario);
   try
      Reset(ArqBan);
      while not Eof(ArqBan) do
         begin
            ReadLN(ArqBan, cLinha);
            if Length(Trim(cLinha)) = 0 then
               Continue;
         end
   finally
      CloseFile(ArqBan);
   end;
end;

{ TBanco }

constructor TBanco.Create;
begin
   ContaCorrente := TConta.Create;
end;

procedure TBanco.DefineAgenciaConta(cAgenciaConta: String);
begin
   if CodigoBanco = '0341' then
      begin
         ContaCorrente.Agencia := Copy(cAgenciaConta, 1, 4);
         Contacorrente.Conta   := Copy(cAgenciaConta, 5, 4);
         ContaCorrente.DigitoAgencia := '';
         ContaCorrente.DigitoConta := Copy(cAgenciaConta, 10, 1);

         ContaCorrente.Descricao := '(' + ContaCorrente.Agencia;

         if Length(ContaCorrente.DigitoAgencia) > 0 then
            ContaCorrente.Descricao := ContaCorrente.Descricao + '-' + ContaCorrente.DigitoAgencia;

         ContaCorrente.Descricao := ContaCorrente.Descricao + ') ';

         ContaCorrente.Descricao := ContaCorrente.Descricao + ContaCorrente.Conta;

         if Length(ContaCorrente.DigitoConta) > 0 then
            ContaCorrente.Descricao := ContaCorrente.Descricao + ' - ' + ContaCorrente.DigitoConta;
      end
   else
   if CodigoBanco = '001' then
      begin
         ContaCorrente.Agencia := '';
         ContaCorrente.DigitoAgencia := '';
         Contacorrente.Conta   := Copy(cAgenciaConta, 1, 4);
         ContaCorrente.DigitoConta := Copy(cAgenciaConta, 6, 1);
         ContaCorrente.Descricao := Contacorrente.Conta + ' - ' + ContaCorrente.DigitoConta;
      end;
end;

procedure TBanco.SetCodigoBanco(const Value: String);
begin
  FCodigoBanco := Value;
  if Pos('341', FCodigoBanco) > 0 then
     NomeBanco := 'BANCO ITAU'
  else
  if Pos('001', FCodigoBanco) > 0 then
     NomeBanco := 'BANCO DO BRASIL';
end;

procedure TBanco.SetContaCorrente(const Value: TConta);
begin
  FContaCorrente := Value;
end;

procedure TBanco.SetNomeBanco(const Value: String);
begin
  FNomeBanco := Value;
end;

{ TMovimentacao }

procedure TMovimentacao.Assign(mMovimentacao: TMovimentacao);
begin
   Valor :=  mMovimentacao.Valor;
   DataHora := mMovimentacao.DataHora;
   CodigoBancario := mMovimentacao.CodigoBancario;
   TipoMovimentacao := mMovimentacao.TipoMovimentacao;
   Operacao := mMovimentacao.Operacao;
   Descricao := mMovimentacao.Descricao;
end;

constructor TMovimentacao.Create;
begin

end;

procedure TMovimentacao.SetCodigoBancario(const Value: String);
begin
  FCodigoBancario := Value;
end;

procedure TMovimentacao.SetDataHora(const Value: TDateTime);
begin
  FDataHora := Value;
end;

procedure TMovimentacao.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TMovimentacao.SetDocumento(const Value: String);
begin
  FDocumento := Value;
end;

procedure TMovimentacao.SetOperacao(const Value: String);
begin
  FOperacao := Value;
end;

procedure TMovimentacao.SetTipoMovimentacao(
  const Value: TTipoMovimentacao);
begin
  FTipoMovimentacao := Value;
end;

procedure TMovimentacao.SetValor(const Value: Real);
begin
  FValor := Value;
end;

{ TConta }

procedure TConta.SetAgencia(const Value: String);
begin
  FAgencia := Value;
end;

procedure TConta.SetConta(const Value: String);
begin
  FConta := Value;
end;

procedure TConta.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TConta.SetDigitoAgencia(const Value: String);
begin
  FDigitoAgencia := Value;
end;

procedure TConta.SetDigitoConta(const Value: String);
begin
  FDigitoConta := Value;
end;

procedure TConta.SetSaldoAtual(const Value: Real);
begin
  FSaldoAtual := Value;
end;

{ TMovimentacaoList }

function TMovimentacaoList.Add(mMovimentacao: TMovimentacao): Integer;
begin
//   NovaMovimentacao.Assign(mMovimentacao);
   Result := inherited Add(mMovimentacao);
end;

function TMovimentacaoList.GetItem(Index: integer): TMovimentacao;
begin
   Result := inherited Items[Index] as TMovimentacao;
end;

procedure TMovimentacaoList.SetItem(Index: integer;
  const Value: TMovimentacao);
begin
  inherited Items[Index] := Value;
end;

end.
