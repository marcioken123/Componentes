unit uPrintCodBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TModeloImpressora = (impNone, impArgox, impRabbit, impCab, impZebra);

Type
  TCodBarRotacao = (cbr0, cbr90, cbr180, cbr270);

Type
  TCodBarType = (cbt2of5, cbtCode128);

Type
  TPrintCodBarLanguage = (lngDPL, lngEPL);

type
  TPrintCodBar = class(TComponent)
  private
    FMargemEsqDescricao: integer;
    FLinguagem: TPrintCodBarLanguage;
    FTemperaturaImpressao: Integer;
    FResolucao: Integer;
    FTipoCodigoBarras: TCodBarType;
    FRotacao: TCodBarRotacao;
    FLargura: integer;
    FTamanho: Integer;
    FAltura: Integer;
    FCodigoBarras: String;
    FDescricao: String;
    FEmpresa: String;
    FQuantidade: Integer;
    FModeloImpressora: TModeloImpressora;
    FMargemEsquerda: Integer;
    procedure SetLinguagem(const Value: TPrintCodBarLanguage);
    procedure SetResolucao(const Value: Integer);
    procedure SetTemperaturaImpressao(Value: Integer);
    procedure SetTipoCodigoBarras(const Value: TCodBarType);
    procedure SetRotacao(const Value: TCodBarRotacao);
    procedure SetTamanho(const Value: Integer);
    procedure SetAltura(const Value: Integer);
    procedure SetCodigoBarras(const Value: String);
    procedure SetDescricao(const Value: String);
    procedure SetEmpresa(const Value: String);
    procedure SetQuantidade(const Value: Integer);
    procedure SetModeloImpressora(const Value: TModeloImpressora);
    procedure SetMargemEsquerda(const Value: Integer);
    procedure SetLarguraEtq(const Value: integer);
    procedure SetFMargemEsqDescricao(const Value: integer);
    { Private declarations }
  protected
    { Protected declarations }
     function StrZero(Zeros:string;Quant:integer):String;
  public
    { Public declarations }
    constructor Create(AOWner: TComponent); override;
    procedure Imprimir;
  published
    { Published declarations }
    property MargemEsquerda: Integer read FMargemEsquerda write SetMargemEsquerda;
    property Linguagem: TPrintCodBarLanguage read FLinguagem write SetLinguagem;
    property Resolucao: Integer read FResolucao write SetResolucao;
    property TipoCodigoBarras: TCodBarType read FTipoCodigoBarras write SetTipoCodigoBarras;
    property TemperaturaImpressao: Integer read FTemperaturaImpressao write SetTemperaturaImpressao;
    property Rotacao:TCodBarRotacao read FRotacao write SetRotacao;
    property Tamanho: Integer read FTamanho write SetTamanho;
    property Altura: Integer read FAltura write SetAltura;
    property CodigoBarras: String read FCodigoBarras write SetCodigoBarras;
    property Descricao: String read FDescricao write SetDescricao;
    property Empresa: String read FEmpresa write SetEmpresa;
    property Quantidade: Integer read FQuantidade write SetQuantidade;
    property ModeloImpressora: TModeloImpressora read FModeloImpressora write SetModeloImpressora;
    property LarguraEtq: integer read FLargura write SetLarguraEtq;
    property MargemEsqDescricao: integer read FMargemEsqDescricao write SetFMargemEsqDescricao;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('RAG', [TPrintCodBar]);
end;

{ TPrintCodBar }

function TPrintCodBar.StrZero(Zeros:string;Quant:integer):String;
{Insere Zeros à frente de uma string}
var
I,Tamanho:integer;
aux: string;
begin
  aux := zeros;
  Tamanho := length(ZEROS);
  ZEROS:='';
  for I:=1 to quant-tamanho do
  ZEROS:=ZEROS + '0';
  aux := zeros + aux;
  StrZero := aux;
end;

constructor TPrintCodBar.Create(AOWner: TComponent);
begin
  inherited;
  Linguagem := lngDPL;
  Resolucao := 11;
  TipoCodigoBarras := cbtCode128;
  TemperaturaImpressao := 10;
  Rotacao := cbr0;
  Tamanho := 63;
  Altura  := 35;
  MargemEsqDescricao:=0;
  MargemEsquerda:= 0;
  LarguraEtq :=0;
  Quantidade := 1;
end;

procedure TPrintCodBar.Imprimir;
Var
   cFile: TextFile;
   cSTR: String;
   cRotacao: String;
   cTipoCodBar: String;
   cSubTipo: String;
begin
   if Linguagem = lngDPL then
      begin
         if ModeloImpressora = impRabbit then
            begin
               AssignFile(cFile, 'LPT1');

               try
                  try
                     Rewrite(cFile);
                     WriteLn(cFile, 'f285'); // Idica o ponto de parada após a impressão
                     WriteLn(cFile, 'L'); //Inicia Bloco de impressão
                     WriteLn(cFile, 'D' + IntToStr(Resolucao)); // Resolução do Pixel
                     WriteLn(cFile, 'H' + IntToStr(TemperaturaImpressao)); // Resolução do Pixel

                     if Rotacao = cbr0 then
                        cRotacao := '1'
                     else
                     if Rotacao = cbr90 then
                        cRotacao := '2'                             // + StrZero(IntToStr(MargemEsqDescricao),4)
                     else
                     if Rotacao = cbr180 then
                        cRotacao := '3'
                     else
                     if Rotacao = cbr270 then
                        cRotacao := '4';

                     cStr := cRotacao + '9' + IntToStr(Resolucao) + '002' + '0070' + StrZero(IntToStr(MargemEsqDescricao),4) + Descricao;
                     WriteLn(cFile, cStr);

                     if Length(Trim(Empresa)) > 0 then
                        begin
                             cStr := cRotacao + '9' + IntToStr(Resolucao) + '002' + '0060' + StrZero(IntToStr(MargemEsqDescricao),4) + Empresa;
                             WriteLn(cFile, cStr);

                             cStr := cRotacao + '9' + IntToStr(Resolucao) + '002' + '0050' + StrZero(IntToStr(MargemEsqDescricao),4) + 'SN ' + CodigoBarras;
                             WriteLn(cFile, cStr);
                        end
                     else
                        begin
                             cStr := cRotacao + '9' + IntToStr(Resolucao) + '002' + '0070' + StrZero(IntToStr(MargemEsqDescricao),4) + 'SN ' + CodigoBarras;
                             WriteLn(cFile, cStr);
                        end;

                     if TipoCodigoBarras = cbt2of5 then
                        begin
                           cSubTipo    := '';
                           cTipoCodBar := 'D'
                        end
                     else
                     if TipoCodigoBarras = cbtCode128 then
                        begin
                           cTipoCodBar := 'E';
                           cSubTipo := 'C';
                        end;

                     cStr := cRotacao + cTipoCodBar + StrZero(IntToStr(Tamanho),2) + StrZero(IntToStr(Altura),3) + '0015' + StrZero(IntToStr(0),4) + Trim(cSubTipo) + CodigoBarras;
                     WriteLn(cFile, cStr);
                     WriteLn(cFile, 'Q' + StrZero(IntToStr(Quantidade),4));
                     WriteLn(cFile, 'E');
                  except
                     On E:Exception do
                        ShowMessage('Erro de Impressão' + #13 + E.Message);
                  end;
               finally
                  CloseFile(cFile);
               end;
            end
         else
         if ModeloImpressora = impCab then
            begin
               AssignFile(cFile, 'c:\ImpTer.txt');

               try
                  try
                     Rewrite(cFile);
                     WriteLn(cFile, 'd');
                     WriteLn(cFile, 'e');
                     WriteLn(cFile, 'f260'); // Idica o ponto de parada após a impressão
                     WriteLn(cFile, 'L');

                     WriteLn(cFile, 'D' + IntToStr(Resolucao)); // Resolução do Pixel
                     WriteLn(cFile, 'SA');
                     WriteLn(cFile, 'H' + IntToStr(TemperaturaImpressao)); // Resolução do Pixel
                     WriteLn(cFile, 'z');

                     cStr := cRotacao + '9' + IntToStr(Resolucao) + '003' + '0070' + StrZero(IntToStr(MargemEsqDescricao),4) + Descricao;
                     WriteLn(cFile, cStr);

                     if Length(Trim(Empresa)) > 0 then
                        begin
                             cStr := cRotacao + '9' + IntToStr(Resolucao) + '002' + '0060' + StrZero(IntToStr(MargemEsqDescricao),4) + Empresa;
                             WriteLn(cFile, cStr);

                             cStr := cRotacao + '9' + IntToStr(Resolucao) + '002' + '0050' + StrZero(IntToStr(MargemEsqDescricao),4) + 'SN ' + CodigoBarras;
                             WriteLn(cFile, cStr);
                        end
                     else
                        begin
                             cStr := cRotacao + '9' + IntToStr(Resolucao) + '002' + '0070' + StrZero(IntToStr(MargemEsqDescricao),4) + 'SN ' + CodigoBarras;
                             WriteLn(cFile, cStr);
                        end;

                     if TipoCodigoBarras = cbt2of5 then
                        begin
                           cSubTipo    := '';
                           cTipoCodBar := 'D'
                        end
                     else
                     if TipoCodigoBarras = cbtCode128 then
                        begin
                           cTipoCodBar := 'E';
                           cSubTipo := 'C';
                        end;

                     cStr := cRotacao + cTipoCodBar + StrZero(IntToStr(Tamanho),2) + StrZero(IntToStr(Altura),3) + '0015' + StrZero(IntToStr(MargemEsquerda),4) + Trim(cSubTipo) + CodigoBarras;
                     WriteLn(cFile, cStr);
                     WriteLn(cFile, 'Q' + StrZero(IntToStr(Quantidade),4));
                     WriteLn(cFile, 'E');
                  except
                     On E:Exception do
                        ShowMessage('Erro de Impressão' + #13 + E.Message);
                  end;
               finally
                  CloseFile(cFile);
               end;
            end
         else
         if ModeloImpressora = impZebra then
            begin
               AssignFile(cFile, 'LPT1');
               Rewrite(cFile);
               WriteLn(cFile, '^XA');
               WriteLn(cFile, '^LH' + IntToStr(MargemEsquerda),'30');
               
               if Length(Trim(Empresa)) > 0 then
                  WriteLn(cFile, '^FO' + IntToStr(MargemEsquerda),',10^AD^FD' + Empresa + '^FS');

               if Length(Trim(Descricao)) > 0 then
                  WriteLn(cFile, '^FO' + IntToStr(MargemEsquerda),',30^AA^FD' + Descricao + '^FS');
                  
               WriteLn(cFile, '^FO' + IntToStr(MargemEsquerda),',60^B3^FD' + CodigoBarras + '^FS');
               WriteLn(cFile, '^XZ');
            end;
      end;
end;

procedure TPrintCodBar.SetAltura(const Value: Integer);
begin
  FAltura := Value;
end;

procedure TPrintCodBar.SetCodigoBarras(const Value: String);
begin
  FCodigoBarras := Value;
end;

procedure TPrintCodBar.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TPrintCodBar.SetEmpresa(const Value: String);
begin
  FEmpresa := Value;
end;

procedure TPrintCodBar.SetLinguagem(const Value: TPrintCodBarLanguage);
begin
  FLinguagem := Value;
end;

procedure TPrintCodBar.SetResolucao(const Value: Integer);
begin
  FResolucao := Value;
end;

procedure TPrintCodBar.SetRotacao(const Value: TCodBarRotacao);
begin
  FRotacao := Value;
end;

procedure TPrintCodBar.SetTamanho(const Value: Integer);
begin
  FTamanho := Value;
end;

procedure TPrintCodBar.SetTemperaturaImpressao(Value: Integer);
begin
  if Value > 20 then
     Value := 20
  else
  if Value < 0 then
     Value := 0;

  FTemperaturaImpressao := Value;
end;

procedure TPrintCodBar.SetTipoCodigoBarras(const Value: TCodBarType);
begin
  FTipoCodigoBarras := Value;
end;

procedure TPrintCodBar.SetQuantidade(const Value: Integer);
begin
  FQuantidade := Value;
end;

procedure TPrintCodBar.SetModeloImpressora(const Value: TModeloImpressora);
begin
  FModeloImpressora := Value;
end;

procedure TPrintCodBar.SetMargemEsquerda(const Value: Integer);
begin
  FMargemEsquerda := Value;
end;

procedure TPrintCodBar.SetLarguraEtq(const Value: integer);
begin
  FLargura := Value;
end;

procedure TPrintCodBar.SetFMargemEsqDescricao(const Value: integer);
begin
  FMargemEsqDescricao := Value;
end;

end.
