UNIT gbCobranca;

interface

uses
   Windows, classes, SysUtils, Graphics, extctrls, Dialogs
   {$IFDEF VER150}
      , Variants, MaskUtils, contnrs, IdMessage, IdBaseComponent, IdComponent,
        IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP, gbBoleto7
   {$ELSEIF VER140}
      , Variants, MaskUtils, contnrs, NMSMTP, gbBoleto6
   {$ELSE}
      {$IFDEF VER130}
         , Mask, contnrs, gbBoleto5
      {$ELSE}
         , Mask, gbBoleto4
      {$ENDIF}
   {$IFEND}
   ;              

type

   {TgbEndereco representa o endere�o de cedentes ou sacados}
   TEstado = string[2];
   TCEP = string[8];

   TgbEndereco = class(TPersistent)
   public
      fRua,
      fNumero,
      fComplemento,
      fBairro,
      fCidade,
      fEMail : string;
      fEstado : TEstado;
      fCEP : TCEP;
      procedure Assign(AEndereco: TgbEndereco); reintroduce;
   published
      property Rua : string read fRua write fRua;
      property Numero : string read fNumero write fNumero;
      property Complemento : string read fComplemento write fComplemento;
      property Bairro : string read fBairro write fBairro;
      property Cidade : string read fCidade write fCidade;
      property Estado : TEstado read fEstado write fEstado;
      property CEP : TCEP read fCEP write fCEP;
      property EMail : string read fEMail write fEMail;
   end;

   {Informa��es sobre o banco}
   TgbBanco = class(TPersistent)
   private
      fCodigo : string; {C�digo do banco na c�mara de compensa��o}
      procedure SetCodigo(ACodigoBanco : string);
      function GetDigito : string; {Retorna o d�gito do c�digo do banco}
      function GetNome   : string; {Retorna o nome do banco}
   public
      procedure   Assign(ABanco: TgbBanco); reintroduce;
   published
      property Codigo : string read fCodigo write SetCodigo;
      property Digito : string read GetDigito;
      property Nome   : string read GetNome;
   end;

   {Dados da conta banc�ria de cedentes ou sacados}
   TgbContaBancaria = class(TPersistent)
   public
      fBanco : TgbBanco; {Banco onde a pessoa tem conta}
      fCodigoAgencia, {C�digo da ag�ncia}
      fDigitoAgencia, {D�gito verificador do n�mero da ag�ncia}
      fNumeroConta,         {N�mero da conta}
      fDigitoConta,   {D�gito verificador do n�mero da conta}
      fNomeCliente : string; {Nome do cliente titular da conta}
      fNumContrato : string; {Numero do Contrato}
      fUsoBanco : string; {Numero do Contrato}
      constructor Create;
      destructor  Destroy; override;
      procedure Assign(AContaBancaria: TgbContaBancaria); reintroduce;
   published
      property Banco : TgbBanco read fBanco write fBanco;
      property CodigoAgencia : string read fCodigoAgencia write fCodigoAgencia;
      property DigitoAgencia : string read fDigitoAgencia write fDigitoAgencia;
      property NumeroConta : string read fNumeroConta write fNumeroConta;
      property DigitoConta : string read fDigitoConta write fDigitoConta;
      property NomeCliente : string read fNomeCliente write fNomeCliente;
      property NumContrato : string read fNumContrato write fNumContrato;
      property UsoBanco : string read fUsoBanco write fUsoBanco;
   end;

   TTipoInscricao = (tiPessoaFisica, tiPessoaJuridica, tiOutro);

   {Dados sobre os cedentes ou sacados}
   TgbPessoa = class(TPersistent)
   private
      fTipoInscricao: TTipoInscricao;
      fNumeroCPFCGC ,
      fNome         : string;
      fEndereco     : TgbEndereco;
      fContaBancaria: TgbContaBancaria;
   public
      constructor Create;
      destructor  Destroy; override;
      procedure   Assign(APessoa: TgbPessoa); reintroduce;
   published
      property TipoInscricao: TTipoInscricao read fTipoInscricao write fTipoInscricao;
      property NumeroCPFCGC : string read fNumeroCPFCGC write fNumeroCPFCGC;
      property Nome         : string read fNome write fNome;
      property Endereco     : TgbEndereco read fEndereco write fEndereco;
      property ContaBancaria: TgbContaBancaria read fContaBancaria write fContaBancaria;
   end;

   {Dados completos sobre o cedente - Classe derivada de TgbPessoa}
   TgbCedente = class(TgbPessoa)
   private
      fCodigoCedente,
      fDigitoCodigoCedente : string;
   public
      procedure Assign(ACedente: TgbCedente);
   published
      property CodigoCedente       : string read fCodigoCedente write fCodigoCedente;
      property DigitoCodigoCedente : string read fDigitoCodigoCedente write fDigitoCodigoCedente;
   end;

   {Classe para gerar c�digo de barras para boletos}
   TgbCobCodBar = class
   private
      fCodigo: string; {Dados que ser�o inclu�dos no c�digo de barras}
      Cedente: TgbCedente;
      function GetLinhaDigitavel : string; {Retorna a representa��o num�rica do c�digo de barras}
      function Define2de5 : string; {Define o formato do c�digo de barras INTERCALADO 2 DE 5, retornando a seq��ncia de 0 e 1 que ser� usada para gerar a imagem do c�digo de barras}
      function GetImagem    : TImage; {Gera a imagem do c�digo de barras}
   public
      property Codigo    : string  read fCodigo write fCodigo;
      property LinhaDigitavel : string read GetLinhaDigitavel;
      property Imagem    : TImage read GetImagem;
   end;

   {Especifica o tipo de documento que gerou o t�tulo}
   TEspecieDocumento =
   (
      edAluguel,
      edApoliceSeguro,
      edCheque,
      edContrato,
      edContribuicaoConfederativa,
      edCosseguros,
      edDividaAtivaEstado,
      edDividaAtivaMunicipio,
      edDividaAtivaUniao,
      edDuplicataMercantil,
      edDuplicataMercantialIndicacao,
      edDuplicataRural,
      edDuplicataServico,
      edDuplicataServicoIndicacao,
      edFatura,
      edLetraCambio,
      edMensalidadeEscolar,
      edNotaCreditoComercial,
      edNotaCreditoExportacao,
      edNotaCreditoIndustrial,
      edNotaCreditoRural,
      edNotaDebito,
      edNotaPromissoria,
      edNotaPromissoriaRural,
      edNotaSeguro,
      edOutros,
      edParcelaConsorcio,
      edRecibo,
      edTriplicataMercantil,
      edTriplicataServico,
      edWarrant
   );

   TAceiteDocumento = (adSim, adNao);

   {Indica quem emite o boleto: banco ou cliente}
   TEmissaoBoleto =
   (
      ebBancoEmite,
      ebClienteEmite,
      ebBancoReemite,
      ebBancoNaoReemite
   );

   {Tipos de ocorr�ncias permitidas no arquivos remessa / retorno}
   TTipoOcorrencia =
   (
      {Ocorr�ncias para arquivo remessa}
      toRemessaRegistrar, {Registrar o t�tulo no banco}
      toRemessaBaixar, {Baixar o t�tulo no banco}
      toRemessaDebitarEmConta,
      toRemessaConcederAbatimento,
      toRemessaCancelarAbatimento,
      toRemessaConcederDesconto,
      toRemessaCancelarDesconto,
      toRemessaAlterarVencimento,
      toRemessaProtestar,
      toRemessaCancelarInstrucaoProtesto,
      toRemessaDispensarJuros,
      toRemessaAlterarNomeEnderecoSacado,
      toRemessaAlterarNumeroControle,
      toRemessaOutrasOcorrencias,

      {Ocorr�ncias para arquivo retorno}
      toRetornoRegistroConfirmado,
      toRetornoRegistroRecusado,
      toRetornoComandoRecusado,
      toRetornoLiquidado,
      toRetornoLiquidadoEmCartorio,
      toRetornoLiquidadoParcialmente,
      toRetornoLiquidadoSaldoRestante,
      toRetornoLiquidadoSemRegistro,
      toRetornoLiquidadoPorConta,
      toRetornoBaixaSolicitada,
      toRetornoBaixado,
      toRetornoBaixadoPorDevolucao,
      toRetornoBaixadoFrancoPagamento,
      toRetornoBaixaPorProtesto,
      toRetornoRecebimentoInstrucaoBaixar,
      toRetornoBaixaOuLiquidacaoEstornada,
      toRetornoTituloEmSer,
      toRetornoRecebimentoInstrucaoConcederAbatimento,
      toRetornoAbatimentoConcedido,
      toRetornoRecebimentoInstrucaoCancelarAbatimento,
      toRetornoAbatimentoCancelado,
      toRetornoRecebimentoInstrucaoConcederDesconto,
      toRetornoDescontoConcedido,
      toRetornoRecebimentoInstrucaoCancelarDesconto,
      toRetornoDescontoCancelado,
      toRetornoRecebimentoInstrucaoAlterarDados,
      toRetornoDadosAlterados,
      toRetornoRecebimentoInstrucaoAlterarVencimento,
      toRetornoVencimentoAlterado,
      toRetornoAlteracaoDadosNovaEntrada,
      toRetornoAlteracaoDadosBaixa,
      toRetornoRecebimentoInstrucaoProtestar,
      toRetornoProtestado,
      toRetornoRecebimentoInstrucaoSustarProtesto,
      toRetornoProtestoSustado,
      toRetornoInstrucaoProtestoRejeitadaSustadaOuPendente,
      toRetornoDebitoEmConta,
      toRetornoRecebimentoInstrucaoAlterarNomeSacado,
      toRetornoNomeSacadoAlterado,
      toRetornoRecebimentoInstrucaoAlterarEnderecoSacado,
      toRetornoEnderecoSacadoAlterado,
      toRetornoEncaminhadoACartorio,
      toRetornoRetiradoDeCartorio,
      toRetornoRecebimentoInstrucaoDispensarJuros,
      toRetornoJurosDispensados,
      toRetornoManutencaoTituloVencido,
      toRetornoRecebimentoInstrucaoAlterarTipoCobranca,
      toRetornoTipoCobrancaAlterado,
      toRetornoDespesasProtesto,
      toRetornoDespesasSustacaoProtesto,
      toRetornoDebitoCustasAntecipadas,
      toRetornoCustasCartorioDistribuidor,
      toRetornoCustasEdital,
      toRetornoProtestoOuSustacaoEstornado,
      toRetornoDebitoTarifas,
      toRetornoAcertoDepositaria,
      toRetornoOutrasOcorrencias
   );

   {Representa um t�tulo e todas as rotinas associadas}
   TgbTitulo = class(TComponent)
   private
      fTipoOcorrencia : TTipoOcorrencia; {Tipo de ocorr�ncia: registro de t�tulo, liquida��o normal, pedido de baixa, etc...}
      fOcorrenciaOriginal : string; {Indica o c�digo da ocorr�ncia no banco}
      fDescricaoOcorrenciaOriginal : string;
      fMotivoRejeicaoComando : string; {Indica o c�digo do motivo porque o t�tulo / comando foi recusado. Usado apenas para receber informa��es do banco}
      fDescricaoMotivoRejeicaoComando : string;
      fCedente : TgbCedente; {Aquele que emitiu o t�tulo}
      fSacado : TgbPessoa; {Devedor}
      fLocalPagamento, {Local onde o t�tulo dever� ser pago}
      fSeuNumero, {N�mero que identifica o t�tulo na empresa}
      fNossoNumero, {N�mero que identifica o t�tulo no banco}
      fNumeroDocumento, {N�mero do documento que gerou o t�tulo (n�mero da nota fiscal, por exemplo)}
      fCarteira : string; {Carteira do t�tulo, conforme informado pelo banco}

      {Modificado por S�rgio �vila - INICIO - bcc-sergio@ig.com.br}
      fConvenio: string; {Conv�nio da Empresa, 6 ou 7 d�gitos, para carteiras 16, 17 e 18}
      {Modificado por S�rgio �vila - FIM - bcc-sergio@ig.com.br}

      fAceiteDocumento : TAceiteDocumento;
      fEspecieDocumento: TEspecieDocumento; {Tipo de documento que gerou o t�tulo}
      fDataProcessamento, {Data em que o boleto banc�rio foi gerado}
      fDataDocumento, {Data da emiss�o do documento que gerou o t�tulo (data da emiss�o da nota fiscal, por exemplo)}
      fDataVencimento, {Data do vencimento do t�tulo}
      fDataOcorrencia, {Data da ocorr�ncia em quest�o (pagamento do t�tulo, recebimento de instru��o, etc)}
      fDataCredito, {Data em que o banco liberar� o dinheiro para o cedente}
      fDataAbatimento, {Data at� a qual dever� ser concedido abatimento}
      fDataDesconto, {Data at� a qual dever� ser concedido desconto}
      fDataMoraJuros, {Data a partir da qual dever�o ser cobrados juros / mora}
      fDataMultaJuros, {Data a partir da qual dever�o ser cobrados juros / multa}
      fDataProtesto, {Data em que o t�tulo dever� ser protestado em caso de falta de pagamento}
      fDataBaixa: TDateTime; {Data em que o t�tulo dever� ser baixado}
      fValorDocumento, {Valor do t�tulo}
      fValorDespesaCobranca, {Valor que o banco cobrou pelo servi�o de cobran�a}
      fValorAbatimento, {Valor do abatimento a conceder / concedido ao sacado}
      fValorDesconto, {Valor do desconto di�rio a conceder (remessa) ou desconto total concedido (retorno) ao sacado}
      fValorMoraJuros, {Valor dos juros / mora cobrados do sacado}
      fValorMultaJuros, {Valor dos juros / multa cobrados do sacado}
      fValorIOF, {Valor do Imposto sobre Opera��es Financeiras}
      fValorOutrasDespesas, {Valor de outras despesas cobradas pelo banco: protesto de t�tulos, por exemplo}
      fValorOutrosCreditos : Currency; {Valor de outros cr�ditos que o banco repassar� ao cedente}
      fInstrucoes : TStringList; {Instru��es inclu�das no t�tulo}
      fEmissaoBoleto: TEmissaoBoleto; {Indica quem emite o boleto: banco ou cliente}
      fTipoDataProtesto: String; {Tipo de Data em que o t�tulo dever� ser protestado em caso de falta de pagamento: dias uteis ou corridos}
      fDiasProtesto: String; {Numero de dias em que o t�tulo dever� ser protestado em caso de falta de pagamento: dias uteis ou corridos}
      fDiasMulta: String; {Numero de dias em que o t�tulo dever� ser multado em caso de falta de pagamento: dias uteis ou corridos}
      fReciboSacado: String; {Tipo Recibo Sacado }
      procedure SetInstrucoes(Texto: TStringList);
      function   GerarCodigoBarra : TgbCobCodBar; {Retorna um objeto do tipo TgbCobCodBar contendo linha digit�vel e imagem do c�digo de barras baseados nos dados do t�tulo}
      function   CalcularDigitoNossoNumero : string; {Calcula o d�gito do NossoNumero, conforme crit�rios definidos por cada banco}
      procedure  PrepararBoleto(ABoleto: TBoleto); {Atribui valores aos campos do boleto antes que ele seja impresso }
      function   GetImagemBoleto : TImage; {Gera a imagem do boleto}
      function   GetImagemFichaCompensacao : TImage; {Gera a imagem da ficha de compensa��o}
   public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;
      procedure   Assign(ATitulo: TgbTitulo); reintroduce;
      procedure   EnviarPorEMail(Host, LoginUsuario : string; Porta :integer; Assunto : string; Mensagem : TStringList);
      procedure   Visualizar;
      procedure   Imprimir;
      property CodigoBarra : TgbCobCodBar read GerarCodigoBarra;
      property DigitoNossoNumero : string read CalcularDigitoNossoNumero;
      property ImagemBoleto : TImage read GetImagemBoleto;
      property ImagemFichaCompensacao : TImage read GetImagemFichaCompensacao;
   published
      property TipoOcorrencia : TTipoOcorrencia read fTipoOcorrencia write fTipoOcorrencia;
      property OcorrenciaOriginal : string read fOcorrenciaOriginal write fOcorrenciaOriginal;
      property DescricaoOcorrenciaOriginal : string read fDescricaoOcorrenciaOriginal write fDescricaoOcorrenciaOriginal;
      property MotivoRejeicaoComando : string read fMotivoRejeicaoComando write fMotivoRejeicaoComando;
      property DescricaoMotivoRejeicaoComando : string read fDescricaoMotivoRejeicaoComando write fMotivoRejeicaoComando;
      property LocalPagamento : string read fLocalPagamento write fLocalPagamento;
      property Cedente : TgbCedente read fCedente write fCedente;
      property Sacado : TgbPessoa read fSacado write fSacado;
      property SeuNumero : string read fSeuNumero write fSeuNumero;
      property NossoNumero : string read fNossoNumero write fNossoNumero;
      property NumeroDocumento : string read fNumeroDocumento write fNumeroDocumento;
      property Carteira : string read fCarteira write fCarteira;

      {Modificado por S�rgio �vila - INICIO - bcc-sergio@ig.com.br}
      property Convenio : string read fConvenio write fConvenio;
      {Modificado por S�rgio �vila - FIM - bcc-sergio@ig.com.br}
            
      property AceiteDocumento : TAceiteDocumento read fAceiteDocumento write fAceiteDocumento;
      property EspecieDocumento: TEspecieDocumento read fEspecieDocumento write fEspecieDocumento;
      property DataProcessamento : TDateTime read fDataProcessamento write fDataProcessamento;
      property DataDocumento : TDateTime read fDataDocumento write fDataDocumento;
      property DataVencimento : TDateTime read fDataVencimento write fDataVencimento;
      property DataOcorrencia : TDateTime read fDataOcorrencia write fDataOcorrencia;
      property DataCredito : TDateTime read fDataCredito write fDataCredito;
      property DataAbatimento : TDateTime read fDataAbatimento write fDataAbatimento;
      property DataDesconto : TDateTime read fDataDesconto write fDataDesconto;
      property DataMoraJuros : TDateTime read fDataMoraJuros write fDataMoraJuros;
      property DataMultaJuros : TDateTime read fDataMultaJuros write fDataMultaJuros;
      property DataProtesto : TDateTime read fDataProtesto write fDataProtesto;
      property DataBaixa : TDateTime read fDataBaixa write fDataBaixa;
      property ValorDocumento : Currency read fValorDocumento write fValorDocumento;
      property ValorDespesaCobranca : Currency read fValorDespesaCobranca write fValorDespesaCobranca;
      property ValorAbatimento : Currency read fValorAbatimento write fValorAbatimento;
      property ValorDesconto : Currency read fValorDesconto write fValorDesconto;
      property ValorMoraJuros : Currency read fValorMoraJuros write fValorMoraJuros;
      property ValorMultaJuros : Currency read fValorMultaJuros write fValorMultaJuros;
      property ValorIOF : Currency read fValorIOF write fValorIOF;
      property ValorOutrasDespesas : Currency read fValorOutrasDespesas write fValorOutrasDespesas;
      property ValorOutrosCreditos : Currency read fValorOutrosCreditos write fValorOutrosCreditos;
      property Instrucoes : TStringList read fInstrucoes write SetInstrucoes;
      property EmissaoBoleto : TEmissaoBoleto read fEmissaoBoleto write fEmissaoBoleto;
      property TipoDataProtesto : String read fTipoDataProtesto write fTipoDataProtesto;
      property DiasProtesto : String read fDiasProtesto write fDiasProtesto;
      property DiasMulta : String read fDiasMulta write fDiasMulta;
      property ReciboSacado : String read fReciboSacado write fReciboSacado;
   end;

{$IFNDEF VER120}

   {Representa uma lista de t�tulos - Objetos do tipo gbTitulo}

   TgbTituloList = class(TObjectList)
   protected
      function    GetItem(Index: Integer): TgbTitulo; {Retorna o objeto TgbTitulo que est� na posi��o definida por Index}
      procedure   SetItem(Index: Integer; ATitulo : TgbTitulo); {Altera o objeto TgbTitulo que est� na posi��o definida por Index}
   public
      constructor Create;
      function    Add(ATitulo : TgbTitulo) : integer; {Insere o t�tulo no final da cole��o}
      function    Remove(ATitulo : TgbTitulo): Integer; {Remove da cole��o o t�tulo}
      function    IndexOf(ATitulo : TgbTitulo): Integer; {Retorna a posi��o onde est� localizado o t�tulo na cole��o}
      function    FindInstanceOf(AClass: TClass; AExact: Boolean = True; AStartAt: Integer = 0): Integer;
      procedure   Insert(Index: Integer; ATitulo : TgbTitulo); {Insere o t�tulo no final da cole��o na posi��o indicada por Index}
      property    Items[Index : integer] : TgbTitulo read GetItem write SetItem; default;
   end;

   {Indica o layout do arquivo remessa / retorno, incluindo tamanho de cada registro, o
    os tipos de registros permitidos e o significado dos campos contidos no arquivo}
   TLayoutArquivo = (laCNAB240, laCNAB400, laOutro);

   {Indica o tipo de movimento desejado}
   TTipoMovimento  = (tmRemessa, tmRetorno, tmRemessaTeste, tmRetornoTeste, tmOutro);

   {Representa um conjunto de t�tulos que ser�o tratados juntos em alguma rotina.
    Por exemplo: processamento de arquivo retorno e gera��o de arquivo remessa}
   TgbCobranca = class(TComponent)
   private
      fNomeArquivo : string; {Nome do arquivo remessa ou retorno}
      fNumeroArquivo : integer; {N�mero seq�encial do arquivo remessa ou retorno}
      fDataArquivo : TDateTime; {Data da gera��o do arquivo remessa ou retorno}
      fLayoutArquivo: TLayoutArquivo; {Layout do arquivo remessa / retorno}
      fTipoMovimento: TTipoMovimento; {Tipo de movimento desejado: remessa, retorno, etc...}
      fTitulos : TgbTituloList; {T�tulos inclu�dos no arquivo remessa ou retorno}
   public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      function LerRetorno : boolean; {L� o arquivo retorno recebido do banco}
      function GerarRemessa : boolean; {Gerar arquivo remessa para enviar ao banco}
      function GerarBoletos : bool;
      function GerarRelatorio : TStringList; {Gera as informa��es que ser�o apresentadas na propriedade Relat�rio}
      property Titulos       : TgbTituloList read fTitulos write fTitulos;
      property Relatorio     : TStringList read GerarRelatorio;
   published
      property NomeArquivo   : string read fNomeArquivo write fNomeArquivo;
      property NumeroArquivo : integer read fNumeroArquivo write fNumeroArquivo;
      property DataArquivo   : TDateTime read fDataArquivo write fDataArquivo;
      property LayoutArquivo : TLayoutArquivo read fLayoutArquivo write fLayoutArquivo;
      property TipoMovimento : TTipoMovimento read fTipoMovimento write fTipoMovimento;
   end;

{$ENDIF}   

procedure Register; {Registra os componentes no Delphi}
function Modulo11BB(Valor: String; Base: Integer = 9) : string;
function Formatar(Texto : string; TamanhoDesejado : integer; AcrescentarADireita : boolean = true; CaracterAcrescentar : char = ' ') : string;
function FormatarComMascara(StringFormato, Texto: string): string;
function Modulo10(Valor: String) : string;
function Modulo11(Valor: String; Base: Integer = 9; Resto : boolean = false; CodigoBanco : string = '') : string;
function CalcularFatorVencimento(DataDesejada : TDateTime) : string;

{$IFDEF VER130}
{Calcula a diferen�a de dias entre duas datas. No Delphi 6 a fun��o j� existe na unit DATEUTILS}
function DaysBetween(DataMaior, DataMenor: TDateTime): integer;
{$ENDIF}

implementation

uses gbCob001, gbCob021, gbCob033, gbCob038, gbCob104, gbCob151, gbCob237, gbCob244, gbCob275, gbCob291, gbCob320, gbCob341, gbCob347, gbCob353, gbCob389, gbCob394, gbCob399, gbCob409, gbCob422, gbCob479, gbCob745, gbCob356, gbBoleto7B;

Procedure Register;
begin
   RegisterComponents('GBSoft',[TgbTitulo]);
{$IFNDEF VER120}
   RegisterComponents('GBSoft',[TgbCobranca]);
{$ENDIF}
end;

{Rotinas auxiliares}

function Modulo11BB(Valor: String; Base: Integer = 9) : string;
{
   Rotina muito usada para calcular d�gitos verificadores
   Pega-se cada um dos d�gitos contidos no par�metro VALOR, da direita para a
   esquerda e multiplica-se pela seq��ncia de pesos 2, 3, 4 ... at� BASE.
   Por exemplo: se a base for 9, os pesos ser�o 2,3,4,5,6,7,8,9,2,3,4,5...
   Se a base for 7, os pesos ser�o 2,3,4,5,6,7,2,3,4...
   Soma-se cada um dos subprodutos.
   Divide-se a soma por 11.
   Faz-se a opera��o 11-Resto da divis�o e devolve-se o resultado dessa opera��o
   como resultado da fun��o Modulo11.
   Obs.: Caso o resultado seja maior que 9, dever� ser substitu�do por 0 (ZERO).
}
var
   Soma :integer;
   vCodigo : string;
   vCod01  :integer;
   vCod02  :integer;
   vCod03  :integer;
   vCod04  :integer;
   vCod05  :integer;
   vCod06  :integer;
   vCod07  :integer;
   vCod08  :integer;
   vCod09  :integer;
   vCod10  :integer;
   vCod11  :integer;
begin
   vCodigo := Valor;
   vCod01  := 0;
   vCod02  := 0;
   vCod03  := 0;
   vCod04  := 0;
   vCod05  := 0;
   vCod06  := 0;
   vCod07  := 0;
   vCod08  := 0;
   vCod09  := 0;
   vCod10  := 0;
   vCod11  := 0;
   Soma    := 0;
   vCod01  := StrToInt(vCodigo[01]);
   vCod02  := StrToInt(vCodigo[02]);
   vCod03  := StrToInt(vCodigo[03]);
   vCod04  := StrToInt(vCodigo[04]);
   vCod05  := StrToInt(vCodigo[05]);
   vCod06  := StrToInt(vCodigo[06]);
   vCod07  := StrToInt(vCodigo[07]);
   vCod08  := StrToInt(vCodigo[08]);
   vCod09  := StrToInt(vCodigo[09]);
   vCod10  := StrToInt(vCodigo[10]);
   vCod11  := StrToInt(vCodigo[11]);


   Soma := (vCod01 *7 + vCod02 *8+ vCod03 *9+ vCod04 *2 + vCod05 *3+ vCod06 *4+
            vCod07 *5 + vCod08 *6+ vCod09 *7+ vCod10 *8 + vCod11 *9);

      Result := IntToStr(Soma mod 11);
end;

function CalcularFatorVencimento(DataDesejada : TDateTime) : string;
{O fator de vencimento � a quantidade de dias entre 07/Nov/1997 e a data de vencimento do t�tulo}
begin
   Result := IntToStr( Trunc(DataDesejada - EncodeDate(1997,10,07)));
end;

function Modulo10(Valor: String) : string;
{
   Rotina usada para c�lculo de alguns d�gitos verificadores
   Pega-se cada um dos d�gitos contidos no par�metro VALOR, da direita para a
   esquerda e multiplica-se por 2121212...
   Soma-se cada um dos subprodutos. Caso algum dos subprodutos tenha mais de um
   d�gito, deve-se somar cada um dos d�gitos. (Exemplo: 7*2 = 14 >> 1+4 = 5)
   Divide-se a soma por 10.
   Faz-se a opera��o 10-Resto da divis�o e devolve-se o resultado dessa opera��o
   como resultado da fun��o Modulo10.
   Obs.: Caso o resultado seja maior que 9, dever� ser substitu�do por 0 (ZERO).
}
var
   Auxiliar : string;
   Contador, Peso : integer;
   Digito : integer;
begin
   Auxiliar := '';
   Peso := 2;
   for Contador := Length(Valor) downto 1 do
   begin
      Auxiliar := IntToStr(StrToInt(Valor[Contador]) * Peso) + Auxiliar;
      if Peso = 1 then
         Peso := 2
      else
         Peso := 1;
   end;

   Digito := 0;
   for Contador := 1 to Length(Auxiliar) do
   begin
      Digito := Digito + StrToInt(Auxiliar[Contador]);
   end;
   Digito := 10 - (Digito mod 10);
   if (Digito > 9) then
      Digito := 0;
   Result := IntToStr(Digito);
end;

function Modulo11(Valor: String; Base: Integer = 9; Resto : boolean = false; CodigoBanco : string = '') : string;
{
   Rotina muito usada para calcular d�gitos verificadores
   Pega-se cada um dos d�gitos contidos no par�metro VALOR, da direita para a
   esquerda e multiplica-se pela seq��ncia de pesos 2, 3, 4 ... at� BASE.
   Por exemplo: se a base for 9, os pesos ser�o 2,3,4,5,6,7,8,9,2,3,4,5...
   Se a base for 7, os pesos ser�o 2,3,4,5,6,7,2,3,4...
   Soma-se cada um dos subprodutos.
   Divide-se a soma por 11.
   Faz-se a opera��o 11-Resto da divis�o e devolve-se o resultado dessa opera��o
   como resultado da fun��o Modulo11.
   Obs.: Caso o resultado seja maior que 9, dever� ser substitu�do por 0 (ZERO).
}
var
   Soma : integer;
   Contador, Peso, Digito, xResto : integer;
begin
   Soma := 0;
   Peso := 2;
   for Contador := Length(Valor) downto 1 do
   begin
      Soma := Soma + (StrToInt(Valor[Contador]) * Peso);
      if Peso < Base then
         Peso := Peso + 1
      else
         Peso := 2;
   end;

   if Resto then
      Result := IntToStr(Soma mod 11)
   else
   begin
      xResto := (Soma mod 11);
      Digito := 11 - xResto;
      if (Digito = 11) and (CodigoBanco = '422') then      // safra
         Digito := 1
      else if (Digito = 1) and (CodigoBanco = '422') then  // safra
         Digito := 0
      else if (Digito > 9) then
         Digito := 0
      else  if ((Digito = 0) or (Digito = 1) or (Digito = 10)) and (CodigoBanco = '409') then      // unibanco
         Digito := 1
      else  if ((xResto = 0) or (xResto = 10)) and (CodigoBanco = '409') then      // unibanco
         Digito := 0;

      Result := IntToStr(Digito);
   end
end;

function Formatar(Texto : string; TamanhoDesejado : integer; AcrescentarADireita : boolean = true; CaracterAcrescentar : char = ' ') : string;
{
   OBJETIVO: Eliminar caracteres inv�lidos e acrescentar caracteres � esquerda ou � direita do texto original para que a string resultante fique com o tamanho desejado

   Texto : Texto original
   TamanhoDesejado: Tamanho que a string resultante dever� ter
   AcrescentarADireita: Indica se o car�cter ser� acrescentado � direita ou � esquerda
      TRUE - Se o tamanho do texto for MENOR que o desejado, acrescentar car�cter � direita
             Se o tamanho do texto for MAIOR que o desejado, eliminar �ltimos caracteres do texto
      FALSE - Se o tamanho do texto for MENOR que o desejado, acrescentar car�cter � esquerda
             Se o tamanho do texto for MAIOR que o desejado, eliminar primeiros caracteres do texto
   CaracterAcrescentar: Car�cter que dever� ser acrescentado
}
var
   QuantidadeAcrescentar,
   TamanhoTexto,
   PosicaoInicial,
   i : integer;

begin
   case CaracterAcrescentar of
      '0'..'9','a'..'z','A'..'Z' : ;{N�o faz nada}
      else
         CaracterAcrescentar := ' ';
   end;

   Texto := Trim(AnsiUpperCase(Texto));
   TamanhoTexto := Length(Texto);
   for i := 1 to (TamanhoTexto) do
   begin
      if Pos(Texto[i],' 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ`~''"!@#$%^&*()_-+=|/\{}[]:;,.<>') = 0 then
      begin
         case Texto[i] of
            '�','�','�','�','�' : Texto[i] := 'A';
            '�','�','�','�' : Texto[i] := 'E';
            '�','�','�','�' : Texto[i] := 'I';
            '�','�','�','�','�' : Texto[i] := 'O';
            '�','�','�','�' : Texto[i] := 'U';
            '�' : Texto[i] := 'C';
            '�' : Texto[i] := 'N';
            else Texto[i] := ' ';
         end;
      end;
   end;

   QuantidadeAcrescentar := TamanhoDesejado - TamanhoTexto;
   if QuantidadeAcrescentar < 0 then
      QuantidadeAcrescentar := 0;
   if CaracterAcrescentar = '' then
      CaracterAcrescentar := ' ';
   if TamanhoTexto >= TamanhoDesejado then
      PosicaoInicial := TamanhoTexto - TamanhoDesejado + 1
   else
      PosicaoInicial := 1;

   if AcrescentarADireita then
      Texto := Copy(Texto,1,TamanhoDesejado) + StringOfChar(CaracterAcrescentar,QuantidadeAcrescentar)
   else
      Texto := StringOfChar(CaracterAcrescentar,QuantidadeAcrescentar) + Copy(Texto,PosicaoInicial,TamanhoDesejado);

   Result := AnsiUpperCase(Texto);
end;

function FormatarComMascara(StringFormato, Texto: string): string;
begin
   Result := FormatMaskText(StringFormato,Texto);
end;

{$IFDEF VER130}
{Calcula a diferen�a entre duas datas. No Delphi 6 a fun��o j� existe na unit DATEUTILS}
function DaysBetween(DataMaior, DataMenor: TDateTime): integer;
begin
   Result := Trunc(DataMaior - DataMenor);
end;
{$ENDIF}

{TgbCobCodBar}

function TgbCobCodBar.Define2de5 : string;
{Traduz d�gitos do c�digo de barras para valores de 0 e 1, formando um c�digo do tipo Intercalado 2 de 5}
var
   CodigoAuxiliar : string;
   Start   : string;
   Stop    : string;
   T2de5   : array[0..9] of string;
   Codifi  : string;
   I       : integer;

begin
   Result := 'Erro';
   Start    := '0000';
   Stop     := '100';
   T2de5[0] := '00110';
   T2de5[1] := '10001';
   T2de5[2] := '01001';
   T2de5[3] := '11000';
   T2de5[4] := '00101';
   T2de5[5] := '10100';
   T2de5[6] := '01100';
   T2de5[7] := '00011';
   T2de5[8] := '10010';
   T2de5[9] := '01010';

   { Digitos }
   for I := 1 to length(Codigo) do
   begin
      if pos(Codigo[I],'0123456789') <> 0 then
         Codifi := Codifi + T2de5[StrToInt(Codigo[I])]
      else
         Exit;
   end;

   {Se houver um n�mero �mpar de d�gitos no C�digo, acrescentar um ZERO no in�cio}
   if odd(length(Codigo)) then
      Codifi := T2de5[0] + Codifi;

   {Intercalar n�meros - O primeiro com o segundo, o terceiro com o quarto, etc...}
   I := 1;
   CodigoAuxiliar := '';
   while I <= (length(Codifi) - 9)do
   begin
      CodigoAuxiliar := CodigoAuxiliar + Codifi[I] + Codifi[I+5] + Codifi[I+1] + Codifi[I+6] + Codifi[I+2] + Codifi[I+7] + Codifi[I+3] + Codifi[I+8] + Codifi[I+4] + Codifi[I+9];
      I := I + 10;
   end;

   { Acrescentar caracteres Start e Stop }
   Result := Start + CodigoAuxiliar + Stop;
end;


function TgbCobCodBar.GetLinhaDigitavel : string;
{
   A linha digit�vel � baseada na informa��es do c�digo de barras.
   As informa��es que fazem parte do c�digo de barras s�o:
   Posi��o         Conte�do
   1 a 3           N�mero do banco
   4               C�digo da Moeda - 9 para Real
   5               Digito verificador do C�digo de Barras
   6 a 19          Valor (12 inteiros e 2 decimais)
   20 a 44         Campo Livre definido por cada banco
}
var
   p1, p2, p3, p4, p5, p6,
   Campo1, Campo2, Campo3, Campo4, Campo5 : string;
   xNossoNumero,
   xDigitoNossoNumero,
   xCodBanco : String;
   xCarteira : String;
   xNumContrato: string;
   xCodBarra  : string;
begin
   {
      Campo 1 - composto pelo c�digo do banco, c�digo da moeda, as cinco primeiras posi��es
      do campo livre e DV (modulo10) desse campo
   }

   xCodBanco := Cedente.ContaBancaria.Banco.Codigo;
   xNumContrato := Cedente.ContaBancaria.NumContrato;

   if (xCodBanco = '001') and (StrToInt(xNumContrato) > 1000000) then
      begin
         //xNossoNumero := FormatFloat('0000000', StrToFloat(xNumContrato)) + FormatFloat('0000000000', StrToFloat(Copy(Codigo, 38, 4)));
         xNossoNumero := FormatFloat('0000000', StrToFloat(xNumContrato)) + FormatFloat('0000000000', 0);

         xCarteira := Copy(Codigo, 43, 2);

         xCodBarra := Copy(Codigo, 1, 5) + FloatToStr(Round(Date - StrToDate('07/10/1997'))) + Copy(Codigo, 10, 10) + '000000' + xNossoNumero + xCarteira;

         Campo1 := Copy(xCodBarra, 1, 5)+'.'+Copy(xCodBarra, 6, 5);
         Campo2 := Copy(xCodBarra, 11, 5)+'.'+Copy(xCodBarra, 16, 6);
         Campo3 := Copy(xCodBarra, 22, 5)+'.'+Copy(xCodBarra, 27, 6);
         Campo4 := Copy(xCodBarra, 33, 1);
         Campo5 := Copy(xCodBarra, 34, 15);

         Result := Campo1+' '+Campo2+' '+Campo3+' '+Campo4+' '+Campo5;

         //Result := Copy(Codigo, 1, 5) + FloatToStr(Round(Date - StrToDate('07/10/1997'))) + Copy(Codigo, 10, 10) + '000000' + xNossoNumero + xCarteira;
      end
   else
      begin
         p1 := Copy(Codigo,1,4);
         p2 := Copy(Codigo,20,5);
         p3 := Modulo10(p1+p2);
         p4 := p1+p2+p3;
         p5 := Copy(p4,1,5);
         p6 := Copy(p4,6,5);
         Campo1 := p5+'.'+p6;

         {
            Campo 2 - composto pelas posi�oes 6 a 15 do campo livre
            e DV (modulo10) deste campo
         }
         p1 := Copy(Codigo,25,10);
         p2 := Modulo10(p1);
         p3 := p1+p2;
         p4 := Copy(p3,1,5);
         p5 := Copy(p3,6,6);
         Campo2 := p4+'.'+p5;

         // Unibanco
         // Carteira = 4 e 5 e 6 -> Com Registro
         // Carteira = 20, 'ESP' ou 'ESPECIAL' -> Sem Registro
         xCarteira := Copy(Codigo,19,2);
         xCodBanco := Copy(Codigo,1,3);

      //   if ( (xCodBanco = '409') and ((xCarteira = '04') or (xCarteira = '05') or (xCarteira = '06')) ) then  // Unibanco

      //       xNossoNumero := Copy(Codigo,35,10);
             {
             p1 := copy(xNossoNumero,Length(xNossoNumero)-7,8);
             xDigitoNossoNumero := Modulo10(xNossoNumero);
             p1 := p1 + xDigitoNossoNumero;
             }
             {
             p1 := xNossoNumero;
      //       p1 := p1 + Modulo11(p1,9);
      //       p1 := Copy(p1,2,Length(p1));
             p2 := Copy(p1,1,5);
             p3 := Copy(p1,6,Length(p1));
             p2 := p2+'.'+p3;
      //       p3 := Modulo11('1'+xNossoNumero+xDigitoNossoNumero);
             p3 := Modulo11(p1);
      //       p3 := Modulo11(xNossoNumero+DigitoNossoNumero);
             p4 := Modulo10(p1+p3);
             Campo3 := p2+p4;
              }
      //     end
           {
         else


      //        begin

             {
                Campo 3 - composto pelas posicoes 16 a 25 do campo livre
                e DV (modulo10) deste campo
             }

             p1 := Copy(Codigo,35,10); // aki
             p2 := Modulo10(p1);
             p3 := p1+p2;
             p4 := Copy(p3,1,5);
             p5 := Copy(p3,6,6);
             Campo3 := p4+'.'+p5;


      //     end;

         {
            Campo 4 - digito verificador do codigo de barras
         }
         Campo4 := Copy(Codigo,5,1);

         {
            Campo 5 - composto pelo valor nominal do documento, sem indicacao
            de zeros a esquerda e sem edicao (sem ponto e virgula). Quando se
            tratar de valor zerado, a representacao deve ser 000 (tres zeros).
         }
         Campo5 := Copy(Codigo,6,14);

         Result := Campo1 + ' ' + Campo2 + ' ' + Campo3 + ' ' + Campo4 + ' ' + Campo5;
      end;
end;

function TgbCobCodBar.GetImagem : TImage;
const
   CorBarra           = clBlack;
   CorEspaco          = clWhite;
   LarguraBarraFina   = 1;
   LarguraBarraGrossa = 3;
   AlturaBarra        = 50;
var
   X            : integer;
   Col          : integer;
   Lar          : integer;
   CodigoAuxiliar : string;
begin
   CodigoAuxiliar := Define2de5;
   Result := TImage.Create(nil);
   Result.Height := AlturaBarra;
   Result.Width := 0;
   For X := 1 to Length(CodigoAuxiliar) do
      case CodigoAuxiliar[X] of
         '0' : Result.Width := Result.Width + LarguraBarraFina;
         '1' : Result.Width := Result.Width + LarguraBarraGrossa;
      end;

   Col    := 0;

   if CodigoAuxiliar <> 'Erro' then
   begin
      for X := 1 to length(CodigoAuxiliar) do
      begin
         {Desenha barra}
         with Result.Canvas do
         begin
            if Odd(X) then
               Pen.Color := CorBarra
            else
               Pen.Color := CorEspaco;

            if CodigoAuxiliar[X] = '0' then
            begin
               for Lar := 1 to LarguraBarraFina do
               begin
                  MoveTo(Col,0);
                  LineTo(Col,AlturaBarra);
                  Col := Col + 1;
               end;
            end
            else
            begin
               for Lar := 1 to LarguraBarraGrossa do
               begin
                  MoveTo(Col,0);
                  LineTo(Col,AlturaBarra);
                  Col := Col + 1;
               end;
            end;
         end;
      end;
   end
   else
      Result.Canvas.TextOut(0,0,'Erro');
end;

{TgbEndereco}
procedure TgbEndereco.Assign(AEndereco: TgbEndereco);
begin
   Rua := AEndereco.Rua;
   Numero := AEndereco.Numero;
   Complemento := AEndereco.Complemento;
   Bairro := AEndereco.Bairro;
   Cidade := AEndereco.Cidade;
   Estado := AEndereco.Estado;
   CEP := AEndereco.CEP;
   EMail := AEndereco.EMail;
end;

{TgbBanco}
procedure TgbBanco.SetCodigo(ACodigoBanco: string);
begin
   ACodigoBanco := Formatar(ACodigoBanco,3,false,'0');
   if (ACodigoBanco = '000') then
      fCodigo := ''
   else if (ACodigoBanco <> fCodigo) then
      fCodigo := ACodigoBanco;
end;

procedure TgbBanco.Assign(ABanco : TgbBanco);
begin
   Codigo := ABanco.Codigo;
end;

function TgbBanco.GetDigito : string;
begin
   if Codigo = '' then
      Result := ''
   else
      Result := Modulo11(Codigo,9);
end;

function TgbBanco.GetNome : string;
var
   ACodigoBanco: string;
   AClasseBanco: TPersistentClass;
   ABanco: TPersistent;
   GetNomeBanco: function: string of object;
begin
   ACodigoBanco := Formatar(Codigo,3,false,'0');
   GetNomeBanco := nil;
   AClasseBanco := GetClass('TgbBanco'+ACodigoBanco);
   if AClasseBanco <> nil then
   begin
      ABanco := AClasseBanco.Create;
      TRY
         @GetNomeBanco := ABanco.MethodAddress('GetNomeBanco');
         if @GetNomeBanco <> nil then
            Result :=  GetNomeBanco
         else
            Raise Exception.CreateFmt('O nome do banco %s n�o est� dispon�vel',[ACodigoBanco]);
         ABanco.Free;
      EXCEPT
         ABanco.Free;
         Raise;
      END;
   end
   else
      Raise Exception.CreateFmt('O banco %s n�o est� dispon�vel',[ACodigoBanco]);
end;

{TgbContaBancaria}
constructor TgbContaBancaria.Create;
begin
   inherited Create;
   Banco := TgbBanco.Create;
end;

destructor TgbContaBancaria.Destroy;
begin
   Banco.Destroy;
   inherited Destroy;
end;

procedure TgbContaBancaria.Assign(AContaBancaria: TgbContaBancaria);
begin
   Banco.Assign(AContaBancaria.Banco);
   CodigoAgencia := AContaBancaria.CodigoAgencia;
   DigitoAgencia := AContaBancaria.DigitoAgencia;
   NumeroConta := AContaBancaria.NumeroConta;
   DigitoConta := AContaBancaria.DigitoConta;
   NomeCliente := AContaBancaria.NomeCliente;
   NumContrato := AContaBancaria.NumContrato;
   UsoBanco := AContaBancaria.UsoBanco;
end;

{TgbPessoa}

constructor TgbPessoa.Create;
begin
   inherited Create;
   Endereco := TgbEndereco.Create;
   ContaBancaria := TgbContaBancaria.Create;
end;

destructor TgbPessoa.Destroy;
begin
   Endereco.Destroy;
   ContaBancaria.Destroy;
   inherited Destroy;
end;

procedure TgbPessoa.Assign(APessoa: TgbPessoa);
begin
   TipoInscricao := APessoa.TipoInscricao;
   NumeroCPFCGC := APessoa.NumeroCPFCGC;
   Nome := APessoa.Nome;
   Endereco.Assign(APessoa.Endereco);
   ContaBancaria.Assign(APessoa.ContaBancaria)
end;

procedure TgbCedente.Assign(ACedente: TgbCedente);
begin
   inherited Assign(ACedente);
   CodigoCedente := ACedente.CodigoCedente;
   DigitoCodigoCedente := ACedente.DigitoCodigoCedente;
end;

{TgbTitulo}
constructor TgbTitulo.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   fCedente := TgbCedente.Create;
   fSacado := TgbPessoa.Create;
   fInstrucoes := TStringList.Create;
   fLocalPagamento := 'PAG�VEL EM QUALQUER BANCO AT� O VENCIMENTO';
   fOcorrenciaOriginal := '';
   fTipoOcorrencia := toRemessaRegistrar;
   fEspecieDocumento := edDuplicataMercantil;
   fAceiteDocumento := adNao;
   fEmissaoBoleto := ebClienteEmite;
end;

destructor TgbTitulo.Destroy;
begin
   Cedente.Destroy;
   Sacado.Destroy;
   Instrucoes.Destroy;
   inherited Destroy;
end;

procedure TgbTitulo.SetInstrucoes(Texto: TStringList);
begin
   fInstrucoes.Assign(Texto);
end;

procedure TgbTitulo.Assign(ATitulo: TgbTitulo);
begin
   OcorrenciaOriginal := ATitulo.OcorrenciaOriginal;
   DescricaoOcorrenciaOriginal := ATitulo.DescricaoOcorrenciaOriginal;
   TipoOcorrencia := ATitulo.TipoOcorrencia;
   MotivoRejeicaoComando := ATitulo.MotivoRejeicaoComando;
   DescricaoMotivoRejeicaoComando := ATitulo.DescricaoMotivoRejeicaoComando;
   Cedente.Assign(ATitulo.Cedente);
   Sacado.Assign(ATitulo.Sacado);
   LocalPagamento := ATitulo.LocalPagamento;
   SeuNumero := ATitulo.SeuNumero;
   NossoNumero := ATitulo.NossoNumero;
   NumeroDocumento := ATitulo.NumeroDocumento;
   Carteira := ATitulo.Carteira;
   AceiteDocumento := ATitulo.AceiteDocumento;
   EspecieDocumento:= ATitulo.EspecieDocumento;
   DataProcessamento := ATitulo.DataProcessamento;
   DataDocumento := ATitulo.DataDocumento;
   DataVencimento := ATitulo.DataVencimento;
   DataOcorrencia := ATitulo.DataOcorrencia;
   DataCredito := ATitulo.DataCredito;
   DataAbatimento := ATitulo.DataAbatimento;
   DataDesconto := ATitulo.DataDesconto;
   DataMoraJuros := ATitulo.DataMoraJuros;
   DataMultaJuros := ATitulo.DataMultaJuros;
   DataProtesto := ATitulo.DataProtesto;
   DataBaixa := ATitulo.DataBaixa;
   ValorDocumento := ATitulo.ValorDocumento;
   ValorDespesaCobranca := ATitulo.ValorDespesaCobranca;
   ValorAbatimento := ATitulo.ValorAbatimento;
   ValorDesconto := ATitulo.ValorDesconto;
   ValorMoraJuros := ATitulo.ValorMoraJuros;
   ValorMultaJuros := ATitulo.ValorMultaJuros;
   ValorIOF := ATitulo.ValorIOF;
   ValorOutrasDespesas := ATitulo.ValorOutrasDespesas;
   ValorOutrosCreditos := ATitulo.ValorOutrosCreditos;
   Instrucoes.Assign(ATitulo.Instrucoes);
   EmissaoBoleto := ATitulo.EmissaoBoleto;
   TipoDataProtesto := ATitulo.TipoDataProtesto;
   DiasProtesto := ATitulo.DiasProtesto;
   DiasMulta := ATitulo.DiasMulta;
end;

function TgbTitulo.CalcularDigitoNossoNumero : string;
var
   ACodigoBanco: string;
   AClasseBanco: TPersistentClass;
   ABanco: TPersistent;
   GetDigitoNossoNumero: function(ATitulo: TgbTitulo): string of object;
begin
   ACodigoBanco := Formatar(Cedente.ContaBancaria.Banco.Codigo,3,false,'0');
   GetDigitoNossoNumero := nil;
   AClasseBanco := GetClass('TgbBanco'+ACodigoBanco);
   if AClasseBanco <> nil then
   begin
      ABanco := AClasseBanco.Create;
      TRY
         @GetDigitoNossoNumero := ABanco.MethodAddress('CalcularDigitoNossoNumero');
         if @GetDigitoNossoNumero <> nil then
           Result :=  GetDigitoNossoNumero(Self)
         else
            Raise Exception.CreateFmt('O c�lculo do d�gito do nosso n�mero para o banco %s n�o est� dispon�vel',[ACodigoBanco]);
         ABanco.Free;
      EXCEPT
         ABanco.Free;
         Raise;
      END;
   end
   else
      Raise Exception.CreateFmt('Os boletos para o banco %s n�o est�o dispon�veis',[ACodigoBanco]);
end;

function TgbTitulo.GerarCodigoBarra : TgbCobCodBar;
var
   ACodigoBanco,
   ACodigoMoeda,
   ADigitoCodigoBarras,
   AFatorVencimento,
   AValorDocumento,
   ACampoLivre,
   ACodigoBarras: string;
   AClasseBanco: TPersistentClass;
   ABanco: TPersistent;
   GetCampoLivreCodigoBarra: function(ATitulo: TgbTitulo): string of object;
begin
   Result := TgbCobCodBar.Create;

   Result.Cedente := Cedente;

   GetCampoLivreCodigoBarra := nil;

   {
    A primeira parte do c�digo de barras � composta por:
    C�digo do banco (3 posi��es)
    C�digo da moeda = 9 (1 posi��o)
    D�gito do c�digo de barras (1 posi��o) - Ser� calculado e inclu�do pelo componente
    Fator de vencimento (4 posi��es) - Obrigat�rio a partir de 03/07/2000
    Valor do documento (10 posi��es) - Sem v�rgula decimal e com ZEROS � esquerda

    A segunda parte do c�digo de barras � um campo livre, que varia de acordo
    com o banco
   }

   {Primeira parte do c�digo de barras}
   ACodigoBanco := Formatar(Cedente.ContaBancaria.Banco.Codigo,3,false,'0');
   ACodigoMoeda := '9';
   AFatorVencimento := Formatar(CalcularFatorVencimento(DataVencimento),4,false,'0');
   AValorDocumento := FormatCurr('0000000000',ValorDocumento*100); {Formata o valor com 10 d�gitos, incluindo as casas decimais, mas n�o mostra o ponto decimal}
//   AValorDocumento := FormatCurr('0000000000',ValorDocumento); {Formata o valor com 10 d�gitos, incluindo as casas decimais, mas n�o mostra o ponto decimal}

   {Segunda parte do c�digo de barras - Campo livre - Varia de acordo com o banco}

   AClasseBanco := GetClass('TgbBanco'+ACodigoBanco);
   if AClasseBanco <> nil then
   begin
      ABanco := AClasseBanco.Create;
      TRY
         @GetCampoLivreCodigoBarra := ABanco.MethodAddress('GetCampoLivreCodigoBarra');
         if @GetCampoLivreCodigoBarra <> nil then
            ACampoLivre :=  GetCampoLivreCodigoBarra(Self)
         else
            Raise Exception.CreateFmt('A gera��o de c�digo de barras para t�tulos do banco %s n�o est� dispon�vel',[ACodigoBanco]);
         ABanco.Free;
      EXCEPT
         ABanco.Free;
         Raise;
      END
   end
   else
      Raise Exception.CreateFmt('Os boletos para o banco %s n�o est�o dispon�veis',[ACodigoBanco]);

   {Calcula o d�gito e completa o c�digo de barras}
//   if ACodigoBanco = '409' then // UNIBANCO         aki
//     ACodigoBarras := ACodigoBanco + ACodigoMoeda + copy(Cedente.ContaBancaria.NumContrato,1,4) + AValorDocumento + ACampoLivre
//   else
   if ACodigoBanco = '001' then // Banco do Brasil c/convenio acima de 1.000.000       aki
     ACodigoBarras := ACodigoBanco + ACodigoMoeda + AFatorVencimento + AValorDocumento + ACampoLivre
   else
     ACodigoBarras := ACodigoBanco + ACodigoMoeda + AFatorVencimento + AValorDocumento + ACampoLivre;

   ADigitoCodigoBarras := Modulo11(ACodigoBarras,9);
   if ADigitoCodigoBarras = '0' then
      ADigitoCodigoBarras := '1';

   Result.Codigo := Copy(ACodigoBarras,1,4) + ADigitoCodigoBarras + Copy(ACodigoBarras,5,length(ACodigoBarras)-4);

//   ShowMessage(Result.Codigo+#13+IntToStr(Length(Result.Codigo)));

end;

procedure TgbTitulo.PrepararBoleto(ABoleto: TBoleto);
var
   AAgenciaCodigoCedente,
   ANossoNumero,
   ACarteira,
   AEspecieDocumento,
   ACodigoBanco,
   AUsoBanco : string;
   AInstrucoes: TStringList;
   AClasseBanco: TPersistentClass;
   ABanco: TPersistent;
   GetFormatoBoleto: procedure(ATitulo: TgbTitulo; var AAgenciaCodigoCedente, ANossoNumero, ACarteira, AEspecieDocumento: string) of object;
   xNossoNumeroAnt : String;
begin
   AInstrucoes := TStringList.Create;
   GetFormatoBoleto := nil;

   ACodigoBanco := Formatar(Cedente.ContaBancaria.Banco.Codigo,3,false,'0');

   xNossoNumeroAnt := NossoNumero;

   // aqui = s/ registro
   if ((ACodigoBanco = '409') and ((UpperCase(Carteira) = 'ESP') or (UpperCase(Carteira) = 'ESPECIAL') or (Carteira = '20'))) then
     begin
       NossoNumero := Formatar(NossoNumero,10,false,'0');
       NossoNumero := NossoNumero + Modulo11(NossoNumero,9);
     end;

   ANossoNumero := NossoNumero + '-' + DigitoNossoNumero;

   ACarteira := Carteira;
   if (ACodigoBanco = '001') then
     begin
       AAgenciaCodigoCedente := Cedente.ContaBancaria.CodigoAgencia +'-'+Cedente.ContaBancaria.DigitoAgencia+ '/' + Cedente.ContaBancaria.NumeroConta+'-'+Cedente.ContaBancaria.DigitoConta;
       AEspecieDocumento := '01'
     end
   else if (ACodigoBanco = '237') then
     begin
       AAgenciaCodigoCedente := Cedente.ContaBancaria.CodigoAgencia +'-'+Cedente.ContaBancaria.DigitoAgencia+ '/' + Cedente.CodigoCedente;
       AEspecieDocumento := '01'
     end
   else if ACodigoBanco = '341' then
     begin
       AAgenciaCodigoCedente := Cedente.ContaBancaria.CodigoAgencia + '/' + Cedente.CodigoCedente;
       case EspecieDocumento of
           edDuplicataMercantil : aEspecieDocumento := '01';
           edNotaPromissoria :    aEspecieDocumento := '02';
           edNotaSeguro :         aEspecieDocumento := '03';
           edMensalidadeEscolar : aEspecieDocumento := '04';
           edRecibo :             aEspecieDocumento := '05';
           edContrato :           aEspecieDocumento := '06';
           edCosseguros :         aEspecieDocumento := '07';
           edDuplicataServico :   aEspecieDocumento := '08';
           edLetraCambio :        aEspecieDocumento := '09';
           edNotaDebito :         aEspecieDocumento := '13';
       end;
     end
   else if ACodigoBanco = '422' then
     begin
       AAgenciaCodigoCedente := Cedente.ContaBancaria.CodigoAgencia+Cedente.ContaBancaria.DigitoAgencia+ '/' + Cedente.CodigoCedente+ '-' + Cedente.DigitoCodigoCedente;
       AEspecieDocumento := '01'
     end
   else if ACodigoBanco = '409' then // Unibanco
     begin
       AAgenciaCodigoCedente := Cedente.ContaBancaria.CodigoAgencia +'/'+Cedente.ContaBancaria.NumeroConta+Cedente.ContaBancaria.DigitoConta;
       AEspecieDocumento := '01'
     end
   else
     begin
       AAgenciaCodigoCedente := Cedente.ContaBancaria.CodigoAgencia + '/' + Cedente.CodigoCedente;
       AEspecieDocumento := '01';
     end;

   if ACodigoBanco = '001' then // Banco do Brasil
     begin
       If Length(Cedente.ContaBancaria.NumContrato) = 4 then
         xNossoNumeroAnt := Cedente.ContaBancaria.NumContrato + Formatar(NossoNumero,7,false,'0')
       else
       If Length(Cedente.ContaBancaria.NumContrato) = 6 then
         xNossoNumeroAnt := Cedente.ContaBancaria.NumContrato + Formatar(NossoNumero,5,false,'0');
     end;

   AUsoBanco := Cedente.ContaBancaria.UsoBanco;

   NossoNumero := xNossoNumeroAnt;

   AClasseBanco := GetClass('TgbBanco'+ACodigoBanco);
   if AClasseBanco <> nil then
   begin
      ABanco := AClasseBanco.Create;
      TRY
         @GetFormatoBoleto := ABanco.MethodAddress('FormatarBoleto');
         if @GetFormatoBoleto <> nil then
            GetFormatoBoleto(Self,AAgenciaCodigoCedente,ANossoNumero,ACarteira, AEspecieDocumento);
         ABanco.Free;
      EXCEPT
         ABanco.Free;
         Raise;
      END
   end;

   if (DataProtesto <> 0) then
      AInstrucoes.Add('Protestar em ' + FormatDateTime('dd/mm/yyyy',DataProtesto));

   if ValorAbatimento <> 0 then
      if DataAbatimento <> 0 then
         AInstrucoes.Add('Conceder abatimento de ' + FormatCurr('R$ #,##0.00',ValorAbatimento) + ' para pagamento at� ' + FormatDateTime('dd/mm/yyyy',DataAbatimento))
      else
         AInstrucoes.Add('Conceder abatimento de ' + FormatCurr('R$ #,##0.00',ValorAbatimento) + ' para pagamento at� ' + FormatDateTime('dd/mm/yyyy',DataVencimento));

   if ValorDesconto <> 0 then
      if DataDesconto <> 0 then
         AInstrucoes.Add('Conceder desconto de ' + FormatCurr('R$ #,##0.00',ValorDesconto) + ' por dia de antecipa��o para pagamento at� ' + FormatDateTime('dd/mm/yyyy',DataDesconto))
      else
         AInstrucoes.Add('Conceder desconto de ' + FormatCurr('R$ #,##0.00',ValorDesconto) + ' por dia de antecipa��o');

   if ValorMoraJuros <> 0 then
      if DataMoraJuros <> 0 then
         AInstrucoes.Add('Cobrar juros de ' + FormatCurr('R$ #,##0.00',ValorMoraJuros) + ' por dia de atraso para pagamento a partir de ' + FormatDateTime('dd/mm/yyyy',DataMoraJuros))
      else
         AInstrucoes.Add('Cobrar juros de ' + FormatCurr('R$ #,##0.00',ValorMoraJuros) + ' por dia de atraso');

   if ValorMultaJuros <> 0 then
      AInstrucoes.Add('Ap�s ' + FormatDateTime('dd/mm/yyyy',DataMultaJuros) + ' multa de ' + FormatCurr('R$ #,##0.00',ValorMultaJuros));

   AInstrucoes.AddStrings(Instrucoes);

   with ABoleto do
   begin
      ReportTitle := 'Cobran�a - ' + Cedente.ContaBancaria.Banco.Nome + ' - Sacado: ' + Sacado.Nome;

      {Primeira via do boleto}
      txtNomeBanco.Caption := Cedente.ContaBancaria.Banco.Nome;
      txtCodigoBanco.Caption := Cedente.ContaBancaria.Banco.Codigo + '-' + Cedente.ContaBancaria.Banco.Digito;
      txtLocalPagamento.Caption := AnsiUpperCase(LocalPagamento);
      txtDataVencimento.Caption := FormatDateTime('dd/mm/yyyy',DataVencimento);
      txtNomeCedente.Caption := AnsiUpperCase(Cedente.Nome);
      txtAgenciaCodigoCedente.Caption := AAgenciaCodigoCedente;
      txtDataDocumento.Caption := FormatDateTime('dd/mm/yyyy',DataDocumento);
      txtNumeroDocumento.Caption := NumeroDocumento;
      lblReciboSacado.Caption := ReciboSacado;

      //txtEspecieDocumento.Caption := AEspecieDocumento;
      if EspecieDocumento = edDuplicataMercantil then
         txtEspecieDocumento.Caption := 'DM'
      else if EspecieDocumento = edDuplicataServico then
         txtEspecieDocumento.Caption := 'DS'
      else
         txtEspecieDocumento.Caption := AEspecieDocumento;

      if AceiteDocumento = adSim then
         txtAceite.Caption := 'S'
      else
         txtAceite.Caption := 'N';
      txtDataProcessamento.Caption := FormatDateTime('dd/mm/yyyy',Now);
      txtNossoNumero.Caption := ANossoNumero;
      txtUsoBanco.Caption := AUsoBanco;
      txtCarteira.Caption := ACarteira;
      txtEspecieMoeda.Caption := 'R$';
      txtQuantidadeMoeda.Caption := '';
      txtValorMoeda.Caption := '';
      txtValorDocumento.Caption := FormatCurr('#,##0.00',ValorDocumento);
      txtInstrucoes.Lines.Clear;
      txtInstrucoes.Lines.AddStrings(AInstrucoes);
      txtValorDescontoAbatimento.Caption := '';
      txtValorDescontoAbatimentoB.Caption := '';
      txtValorMoraMulta.Caption := '';
      txtValorMoraMultaB.Caption := '';
      txtValorCobrado.Caption := '';
      txtSacadoNome.Caption := AnsiUpperCase(Sacado.Nome);
      case Sacado.TipoInscricao of
         tiPessoaFisica  : txtSacadoCPFCGC.Caption := 'CPF: ' + FormatarComMascara('!000\.000\.000\-00;0; ',Sacado.NumeroCPFCGC);
         tiPessoaJuridica: txtSacadoCPFCGC.Caption := 'CNPJ: ' + FormatarComMascara('!00\.000\.000\/0000\-00;0; ',Sacado.NumeroCPFCGC);
         tiOutro         : txtSacadoCPFCGC.Caption := Sacado.NumeroCPFCGC;
      end;
      txtSacadoRuaNumeroComplemento.Caption := AnsiUpperCase(Sacado.Endereco.Rua + ', ' + Sacado.Endereco.Numero + '   ' + Sacado.Endereco.Complemento);
      txtSacadoCEPBairroCidadeEstado.Caption := AnsiUpperCase(FormatarComMascara('00000-000;0; ',Sacado.Endereco.CEP) + '    ' + Sacado.Endereco.Bairro + '    ' + Sacado.Endereco.Cidade + '    ' + Sacado.Endereco.Estado);
      txtCodigoBaixa.Caption := ANossoNumero;

      {Segunda via do boleto}
      txtNomeBanco2.Caption := Cedente.ContaBancaria.Banco.Nome;
      txtCodigoBanco2.Caption := Cedente.ContaBancaria.Banco.Codigo + '-' + Cedente.ContaBancaria.Banco.Digito;
      txtLocalPagamento2.Caption := AnsiUpperCase(LocalPagamento);
      txtDataVencimento2.Caption := FormatDateTime('dd/mm/yyyy',DataVencimento);
      txtNomeCedente2.Caption := AnsiUpperCase(Cedente.Nome);
      txtAgenciaCodigoCedente2.Caption := AAgenciaCodigoCedente;
      txtDataDocumento2.Caption := FormatDateTime('dd/mm/yyyy',DataDocumento);
      txtNumeroDocumento2.Caption := NumeroDocumento;
      txtEspecieDocumento2.Caption := txtEspecieDocumento.Caption;
      if AceiteDocumento = adSim then
         txtAceite2.Caption := 'S'
      else
         txtAceite2.Caption := 'N';
      txtDataProcessamento2.Caption := FormatDateTime('dd/mm/yyyy',Now);
      txtNossoNumero2.Caption := ANossoNumero;
      txtUsoBanco2.Caption := AUsoBanco;
      txtCarteira2.Caption := ACarteira;
      txtEspecieMoeda2.Caption := 'R$';
      txtQuantidadeMoeda2.Caption := '';
      txtValorMoeda2.Caption := '';
      txtValorDocumento2.Caption := FormatCurr('#,##0.00',ValorDocumento);
      txtInstrucoes2.Lines.Clear;
      txtInstrucoes2.Lines.AddStrings(AInstrucoes);
      txtValorDescontoAbatimento2.Caption := '';
      txtValorDescontoAbatimentoB2.Caption := '';
      txtValorMoraMulta2.Caption := '';
      txtValorMoraMultaB2.Caption := '';
      txtValorCobrado2.Caption := '';
      txtSacadoNome2.Caption := AnsiUpperCase(Sacado.Nome);
      case Sacado.TipoInscricao of
         tiPessoaFisica  : txtSacadoCPFCGC2.Caption := 'CPF: ' + FormatarComMascara('!000\.000\.000\-00;0; ',Sacado.NumeroCPFCGC);
         tiPessoaJuridica: txtSacadoCPFCGC2.Caption := 'CNPJ: ' + FormatarComMascara('!00\.000\.000\/0000\-00;0; ',Sacado.NumeroCPFCGC);
         tiOutro         : txtSacadoCPFCGC2.Caption := Sacado.NumeroCPFCGC;
      end;
      txtSacadoRuaNumeroComplemento2.Caption := AnsiUpperCase(Sacado.Endereco.Rua + ', ' + Sacado.Endereco.Numero + '   ' + Sacado.Endereco.Complemento);
      txtSacadoCEPBairroCidadeEstado2.Caption := AnsiUpperCase(FormatarComMascara('00000-000;0; ',Sacado.Endereco.CEP) + '    ' + Sacado.Endereco.Bairro + '    ' + Sacado.Endereco.Cidade + '    ' + Sacado.Endereco.Estado);
      txtCodigoBaixa2.Caption := ANossoNumero;

      {Terceira via do boleto}
      txtNomeBanco3.Caption := Cedente.ContaBancaria.Banco.Nome;
      txtCodigoBanco3.Caption := Cedente.ContaBancaria.Banco.Codigo + '-' + Cedente.ContaBancaria.Banco.Digito;
      txtLocalPagamento3.Caption := AnsiUpperCase(LocalPagamento);
      txtDataVencimento3.Caption := FormatDateTime('dd/mm/yyyy',DataVencimento);
      txtNomeCedente3.Caption := AnsiUpperCase(Cedente.Nome);
      txtAgenciaCodigoCedente3.Caption := AAgenciaCodigoCedente;
      txtDataDocumento3.Caption := FormatDateTime('dd/mm/yyyy',DataDocumento);
      txtNumeroDocumento3.Caption := NumeroDocumento;
      txtEspecieDocumento3.Caption := txtEspecieDocumento.Caption;
      if AceiteDocumento = adSim then
         txtAceite3.Caption := 'S'
      else
         txtAceite3.Caption := 'N';
      txtDataProcessamento3.Caption := FormatDateTime('dd/mm/yyyy',Now);
      txtNossoNumero3.Caption := ANossoNumero;
      txtUsoBanco3.Caption := AUsoBanco;
      txtCarteira3.Caption := ACarteira;
      txtEspecieMoeda3.Caption := 'R$';
      txtQuantidadeMoeda3.Caption := '';
      txtValorMoeda3.Caption := '';
      txtValorDocumento3.Caption := FormatCurr('#,##0.00',ValorDocumento);
      txtInstrucoes3.Lines.Clear;
      txtInstrucoes3.Lines.AddStrings(AInstrucoes);
      txtValorDescontoAbatimento3.Caption := '';
      txtValorDescontoAbatimentoB3.Caption := '';
      txtValorMoraMulta3.Caption := '';
      txtValorMoraMultaB3.Caption := '';
      txtValorCobrado3.Caption := '';
      txtSacadoNome3.Caption := AnsiUpperCase(Sacado.Nome);
      case Sacado.TipoInscricao of
         tiPessoaFisica  : txtSacadoCPFCGC3.Caption := 'CPF: ' + FormatarComMascara('!000\.000\.000\-00;0; ',Sacado.NumeroCPFCGC);
         tiPessoaJuridica: txtSacadoCPFCGC3.Caption := 'CNPJ: ' + FormatarComMascara('!00\.000\.000\/0000\-00;0; ',Sacado.NumeroCPFCGC);
         tiOutro         : txtSacadoCPFCGC3.Caption := Sacado.NumeroCPFCGC;
      end;
      txtSacadoRuaNumeroComplemento3.Caption := AnsiUpperCase(Sacado.Endereco.Rua + ', ' + Sacado.Endereco.Numero + '   ' + Sacado.Endereco.Complemento);
      txtSacadoCEPBairroCidadeEstado3.Caption := AnsiUpperCase(FormatarComMascara('00000-000;0; ',Sacado.Endereco.CEP) + '    ' + Sacado.Endereco.Bairro + '    ' + Sacado.Endereco.Cidade + '    ' + Sacado.Endereco.Estado);
      txtCodigoBaixa3.Caption := ANossoNumero;
      txtLinhaDigitavel3.Caption := CodigoBarra.LinhaDigitavel;
      imgCodigoBarras3.Picture.Assign(CodigoBarra.Imagem.Picture);
   end;

   AInstrucoes.Free;
end;

procedure TgbTitulo.EnviarPorEMail(Host, LoginUsuario: string; Porta : integer; Assunto : string; Mensagem : TStringList);
var
   {$IFDEF VER150}
     Mail : TIdMessage;
     SMTP : TIdSMTP;
   {$ELSE}
     Mail : TNMSMTP;
   {$ENDIF}
   NomeArquivo : string;
begin
   if Host = '' then
      Raise Exception.Create('O host n�o foi informado');
   if Assunto = '' then
      Raise Exception.Create('O assunto da mensagem n�o foi informado');


   {$IFDEF VER150}
     Mail := TIdMessage.Create(nil);
     SMTP := TIdSMTP.Create(nil);

     TRY
        NomeArquivo := 'ImagemBoleto.bmp';
        ImagemBoleto.Picture.SaveToFile(NomeArquivo);
        with Mail do
        begin
           if Cedente.Endereco.EMail <> '' then
              From.Address := Cedente.Endereco.EMail
           else
              Raise Exception.Create('O e-mail do cedente n�o foi informado');

           if Cedente.Nome <> '' then
              From.Name := Cedente.Nome
           else
              From.Name := From.Address;

           ReplyTo.EMailAddresses := From.Address;

           if Sacado.Endereco.EMail <> '' then
              Recipients.EMailAddresses := Sacado.Endereco.EMail
           else
              Raise Exception.Create('O e-mail do sacado n�o foi informado');

           Subject  := Assunto;
           Body.Text:= Mensagem.Text;
           TIdAttachment.Create(Mail.MessageParts, NomeArquivo);
        end;
        SMTP.Host := Host;
        SMTP.Username := LoginUsuario;
        SMTP.Port := Porta;
        SMTP.Connect;
        SMTP.Send(Mail);
        SMTP.Disconnect;
     EXCEPT
        if SMTP.Connected then SMTP.Disconnect;
        Raise;
     END;
     Mail.Free;
     SMTP.Free;
     if FileExists(NomeArquivo) then DeleteFile(NomeArquivo);

   {$ELSE}

     Mail := TNMSMTP.Create(nil);

     TRY
        NomeArquivo := 'ImagemBoleto.bmp';
        ImagemBoleto.Picture.SaveToFile(NomeArquivo);
        with Mail.PostMessage do
        begin
           if Cedente.Endereco.EMail <> '' then
              FromAddress := Cedente.Endereco.EMail
           else
              Raise Exception.Create('O e-mail do cedente n�o foi informado');

           if Cedente.Nome <> '' then
              FromName := Cedente.Nome
           else
              FromName := FromAddress;

           ReplyTo := FromAddress;

           if Sacado.Endereco.EMail <> '' then
              ToAddress.Add(Sacado.Endereco.EMail)
           else
              Raise Exception.Create('O e-mail do sacado n�o foi informado');

           Subject := Assunto;
           Body.Assign(Mensagem);
           Attachments.Add(NomeArquivo);
        end;
        Mail.Host := Host;
        Mail.UserID := LoginUsuario;
        Mail.Port := Porta;
        Mail.Connect;
        Mail.SendMail;
        Mail.Disconnect;
     EXCEPT
        if Mail.Connected then Mail.Disconnect;
        Raise;
     END;
     Mail.Free;
     if FileExists(NomeArquivo) then DeleteFile(NomeArquivo);

   {$ENDIF}
end;

procedure TgbTitulo.Visualizar;
var
   ABoleto : TBoleto;
begin
   ABoleto := TBoleto.Create(nil);
   TRY
      PrepararBoleto(ABoleto);
      ABoleto.Preview;
      ABoleto.Free;
   EXCEPT
      ABoleto.Free;
      Raise;
   END;
end;

procedure TgbTitulo.Imprimir;
var
   ABoleto : TBoleto;
begin
   ABoleto := TBoleto.Create(nil);
   TRY
      PrepararBoleto(ABoleto);
      ABoleto.Print;
      ABoleto.Free;
   EXCEPT
      ABoleto.Free;
      Raise;
   END;
end;

function TgbTitulo.GetImagemBoleto : TImage;
var
   ABoleto : TBoleto;
   AImagem : TMetafile;
begin
   ABoleto := TBoleto.Create(nil);
   AImagem := TMetafile.Create;
   Result := TImage.Create(nil);
   TRY
      PrepararBoleto(ABoleto);
      ABoleto.Prepare;

      AImagem := ABoleto.QRPrinter.GetPage(1);
      Result.Height := AImagem.Height;
      Result.Width := AImagem.Width;
      Result.Canvas.Draw(0,0,AImagem);

      Result.Picture.Bitmap.Monochrome := TRUE;
      AImagem.Free;
      ABoleto.QRPrinter.Free;
      ABoleto.Free;
   EXCEPT
      AImagem.Free;
      ABoleto.QRPrinter.Free;
      ABoleto.Free;
      Raise;
   END;
   ABoleto.QRPrinter := nil;
end;

function TgbTitulo.GetImagemFichaCompensacao : TImage;
var
   AImagem : TImage;
   RectOrigem, RectDestino : TRect;
begin
   Result := TImage.Create(nil);
   AImagem := TImage.Create(nil);
   AImagem := ImagemBoleto;

   with RectOrigem do
   begin
      Left   := 35;
      Top    := 720;
      Right  := 762;
      Bottom := AImagem.Height;
   end;

   with RectDestino do
   begin
      Left   := 0;
      Top    := 0;
      Right  := AImagem.Width;
      Bottom := AImagem.Height - 719;
   end;

   Result.Height := RectDestino.Bottom;
   Result.Width  := RectDestino.Right;

   Result.Canvas.CopyRect(RectDestino, AImagem.Canvas, RectOrigem);
end;

{$IFNDEF VER120}

{TgbTituloList}

constructor TgbTituloList.Create;
begin
   {$IFDEF VER140}
      inherited Create(true);
   {$ELSE}
      {$IFDEF VER130}
         inherited Create(true);
      {$ELSE}
         inherited Create;
      {$ENDIF}
   {$ENDIF}
end;

function TgbTituloList.FindInstanceOf(AClass: TClass; AExact: Boolean;
  AStartAt: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := AStartAt to Count - 1 do
    if (AExact and
        (Items[I].ClassType = AClass)) or
       (not AExact and
        Items[I].InheritsFrom(AClass)) then
    begin
      Result := I;
      break;
    end;
end;

function TgbTituloList.GetItem(Index: Integer): TgbTitulo;
begin
   Result := inherited Items[Index] as TgbTitulo;
end;

function TgbTituloList.Add(ATitulo : TgbTitulo) : integer;
var
   NovoTitulo : TgbTitulo;
begin
   NovoTitulo := TgbTitulo.Create(nil);
   NovoTitulo.Assign(ATitulo);
   Result := inherited Add(NovoTitulo);
end;

function TgbTituloList.IndexOf(ATitulo : TgbTitulo): Integer;
begin
  Result := inherited IndexOf(ATitulo);
end;

procedure TgbTituloList.Insert(Index: Integer; ATitulo: TgbTitulo);
begin
  inherited Insert(Index, ATitulo);
end;

function TgbTituloList.Remove(ATitulo: TgbTitulo): Integer;
begin
  Result := inherited Remove(ATitulo);
end;

procedure TgbTituloList.SetItem(Index: Integer; ATitulo: TgbTitulo);
begin
  inherited Items[Index] := ATitulo;
end;

{TgbCobranca}

constructor TgbCobranca.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   LayoutArquivo := laCNAB400;
   TipoMovimento := tmRetorno;
   Titulos := TgbTituloList.Create;
end;

destructor TgbCobranca.Destroy;
begin
   Titulos.Destroy;
   inherited Destroy;
end;

function TgbCobranca.GerarRemessa : boolean;
var
   Remessa: TStringList;
   ACodigoBanco: string;
   AClasseBanco: TPersistentClass;
   ABanco: TPersistent;
   GetRemessa: function(var ACobranca: TgbCobranca; var Remessa: TStringList): boolean of object;
begin
   Result := FALSE;
   GetRemessa := nil;

   if Titulos.Count <= 0 then
      Raise Exception.Create('N�o h� t�tulos para gerar arquivo remessa. A cole��o de t�tulos est� vazia');

   Remessa := TStringList.Create;
   TRY

      if (TipoMovimento <> tmRemessa) and (TipoMovimento <> tmRemessaTeste) then
         TipoMovimento := tmRemessa;

      ACodigoBanco := Formatar(Titulos[0].Cedente.ContaBancaria.Banco.Codigo,3,false,'0');
      AClasseBanco := GetClass('TgbBanco'+ACodigoBanco);
      if AClasseBanco <> nil then
      begin
         ABanco := AClasseBanco.Create;
         TRY
            @GetRemessa := ABanco.MethodAddress('GerarRemessa');
            if @GetRemessa <> nil then
            begin
               Result := GetRemessa(Self, Remessa);
               if Result then
                  Remessa.SaveToFile(NomeArquivo); {Grava o arquivo remessa}
            end
            else
               Raise Exception.CreateFmt('A gera��o de arquivo remessa para o banco %s n�o est� dispon�vel',[ACodigoBanco]);
            ABanco.Free;
         EXCEPT
            ABanco.Free;
            Raise;
         END
      end
      else
         Raise Exception.CreateFmt('Processamento de arquivos remessa / retorno para o banco %s n�o est� dispon�vel',[ACodigoBanco]);

      Remessa.Free;

   EXCEPT
      Remessa.Free;
      Raise;
   END;
end;


function TgbCobranca.LerRetorno : boolean;
var
   ACodigoBanco: string;
   Retorno : TStringList;
   AClasseBanco: TPersistentClass;
   ABanco: TPersistent;
   GetRetorno: function(var ACobranca: TgbCobranca; Retorno: TStringList): boolean of object;
begin
   Result := FALSE;
   GetRetorno := nil;
   Retorno := TStringList.Create;
   Self.Titulos.Clear; {Zera o conjunto de t�tulos, antes de incluir os t�tulos do arquivo retorno}

   TRY
      if not FileExists(NomeArquivo) then
         Raise Exception.CreateFmt('O arquivo %s n�o foi localizado',[NomeArquivo]);

      Retorno.LoadFromFile(NomeArquivo);

      if Retorno.Count < 3 then
      begin
         Result := FALSE;
         Exit;
      end;

      case length(Retorno[0]) of
         240 :
            begin
               LayoutArquivo := laCNAB240;
               {Ver se o arquivo � mesmo RETORNO DE COBRAN�A}
               if Copy(Retorno.Strings[0],143,1) <> '2' then
                  Raise Exception.Create(NomeArquivo+' n�o � um arquivo de retorno de cobran�a com layout CNAB240');
               ACodigoBanco := Copy(Retorno.Strings[0],1,3);
            end;

         400 :
            begin
               LayoutArquivo := laCNAB400;
               {Ver se o arquivo � mesmo RETORNO DE COBRAN�A}
               if Copy(Retorno.Strings[0],1,19) <> '02RETORNO01COBRANCA' then
                  Raise Exception.Create(NomeArquivo+' n�o � um arquivo de retorno de cobran�a com layout CNAB400');
               ACodigoBanco := Copy(Retorno.Strings[0],77,3);
            end;
         else
         begin
            LayoutArquivo := laOutro;
            Raise Exception.Create(NomeArquivo+' n�o � um arquivo de retorno de cobran�a com layout CNAB240 ou CNAB400');
         end;
      end;

      TipoMovimento := tmRetorno;

      AClasseBanco := GetClass('TgbBanco'+ACodigoBanco);
      if AClasseBanco <> nil then
      begin
         ABanco := AClasseBanco.Create;
         TRY
            @GetRetorno := ABanco.MethodAddress('LerRetorno');
            if @GetRetorno <> nil then
               Result := GetRetorno(Self, Retorno)
            else
               Raise Exception.CreateFmt('O processamento de arquivo retorno do banco %s n�o est� dispon�vel',[ACodigoBanco]);
            ABanco.Free;
         EXCEPT
            ABanco.Free;
            Raise;
         END
      end
      else
         Raise Exception.CreateFmt('Processamento de arquivos remessa / retorno para o banco %s n�o est� dispon�vel',[ACodigoBanco]);

      Retorno.Free;
      Result := TRUE;
   EXCEPT
      Retorno.Free;
      Raise;
   END;
end;


function TgbCobranca.GerarRelatorio : TStringList;
var
   i : integer;
begin
   Result := TStringList.Create;

   with Result do
   begin
      Add(StringOfChar('=',80));
      Add('');
      Add('Nome do arquivo  : ' + NomeArquivo);
      Add('N�mero do arquivo: ' + IntToStr(NumeroArquivo));
      Add('Data do arquivo  : ' + DateTimeToStr(DataArquivo));

      case LayoutArquivo of
         laCNAB240 : Add('Layout do arquivo: CNAB240');
         laCNAB400 : Add('Layout do arquivo: CNAB400');
      else
         Add('Layout do arquivo: Outro');
      end; {case LayoutArquivo}

      case TipoMovimento of
         tmRemessa      : Add('Tipo de movimento: Remessa');
         tmRetorno      : Add('Tipo de movimento: Retorno');
         tmRemessaTeste : Add('Tipo de movimento: Remessa - Teste');
         tmRetornoTeste : Add('Tipo de movimento: Retorno - Teste');
      else
         Add('Tipo de movimento: Outro');
      end; {case TipoMovimento}

      Add('');
      Add(StringOfChar('=',80));

      for i := 0 to (Titulos.Count - 1) do
      begin
         with Titulos[i] do
         begin
            Add('');
            case TipoOcorrencia of
               {Ocorr�ncias para arquivo remessa}
               toRemessaRegistrar : Add('Tipo ocorr�ncia  : Registrar o t�tulo no banco');
               toRemessaBaixar : Add('Tipo ocorr�ncia  : Baixar o t�tulo no banco');
               toRemessaDebitarEmConta : Add('Tipo ocorr�ncia  : Debitar em conta');
               toRemessaConcederAbatimento : Add('Tipo ocorr�ncia  : Conceder abatimento');
               toRemessaCancelarAbatimento : Add('Tipo ocorr�ncia  : Cancelar abatimento');
               toRemessaConcederDesconto : Add('Tipo ocorr�ncia  : Conceder desconto');
               toRemessaCancelarDesconto : Add('Tipo ocorr�ncia  : Cancelar desconto');
               toRemessaAlterarVencimento : Add('Tipo ocorr�ncia  : Alterar vencimento');
               toRemessaProtestar : Add('Tipo ocorr�ncia  : Protestar o t�tulo');
               toRemessaCancelarInstrucaoProtesto : Add('Tipo ocorr�ncia  : Cancelar instru��o de protesto');
               toRemessaDispensarJuros : Add('Tipo ocorr�ncia  : Dispensar juros');
               toRemessaAlterarNomeEnderecoSacado : Add('Tipo ocorr�ncia  : Alterar nome e endere�o do sacado');
               toRemessaOutrasOcorrencias : Add('Tipo ocorr�ncia  : Outras ocorr�ncias de remessa');

               {Ocorr�ncias para arquivo retorno}
               toRetornoRegistroConfirmado : Add('Tipo ocorr�ncia  : Registro do t�tulo foi confirmado');
               toRetornoRegistroRecusado : Add('Tipo ocorr�ncia  : Registro do t�tulo foi recusado');
               toRetornoComandoRecusado : Add('Tipo ocorr�ncia  : Comando recusado');
               toRetornoLiquidado : Add('Tipo ocorr�ncia  : O t�tulo foi liquidado');
               toRetornoBaixado : Add('Tipo ocorr�ncia  : O t�tulo foi baixado');
               toRetornoRecebimentoInstrucaoBaixar : Add('Tipo ocorr�ncia  : Recebimento de instru��o para baixar t�tulo');
               toRetornoBaixaOuLiquidacaoEstornada : Add('Tipo ocorr�ncia  : Baixa / liquida��o estornada');
               toRetornoTituloEmSer : Add('Tipo ocorr�ncia  : T�tulo em ser');
               toRetornoRecebimentoInstrucaoConcederAbatimento : Add('Tipo ocorr�ncia  : Recebimento de instru��o para conceder abatimento');
               toRetornoAbatimentoConcedido : Add('Tipo ocorr�ncia  : Abatimento concedido');
               toRetornoRecebimentoInstrucaoCancelarAbatimento : Add('Tipo ocorr�ncia  : Recebimento de instru��o para cancelar abatimento');
               toRetornoAbatimentoCancelado : Add('Tipo ocorr�ncia  : Abatimento cancelado');
               toRetornoRecebimentoInstrucaoConcederDesconto : Add('Tipo ocorr�ncia  : Recebimento de instru��o para conceder desconto');
               toRetornoDescontoConcedido : Add('Tipo ocorr�ncia  : Desconto concedido');
               toRetornoRecebimentoInstrucaoCancelarDesconto : Add('Tipo ocorr�ncia  : Recebimento de instru��o para cancelar desconto');
               toRetornoDescontoCancelado : Add('Tipo ocorr�ncia  : Desconto cancelado');
               toRetornoRecebimentoInstrucaoAlterarDados : Add('Tipo ocorr�ncia  : Recebimento de instru��o para alterar dados');
               toRetornoDadosAlterados : Add('Tipo ocorr�ncia  : Dados alterados');
               toRetornoRecebimentoInstrucaoAlterarVencimento : Add('Tipo ocorr�ncia  : Recebimento de instru��o para alterar vencimento');
               toRetornoVencimentoAlterado : Add('Tipo ocorr�ncia  : Vencimento alterado');
               toRetornoRecebimentoInstrucaoProtestar : Add('Tipo ocorr�ncia  : Recebimento de instru��o para protestar t�tulo');
               toRetornoProtestado : Add('Tipo ocorr�ncia  : T�tulo protestado');
               toRetornoRecebimentoInstrucaoSustarProtesto : Add('Tipo ocorr�ncia  : Recebimento de instru��o para sustar protesto');
               toRetornoProtestoSustado : Add('Tipo ocorr�ncia  : Protesto sustado');
               toRetornoDebitoEmConta : Add('Tipo ocorr�ncia  : Debitado em conta');
               toRetornoRecebimentoInstrucaoAlterarNomeSacado : Add('Tipo ocorr�ncia  : Recebimento de instru��o para alterar nome do sacado');
               toRetornoNomeSacadoAlterado : Add('Tipo ocorr�ncia  : Nome do sacado alterado');
               toRetornoRecebimentoInstrucaoAlterarEnderecoSacado : Add('Tipo ocorr�ncia  : Recebimento instru��o para alterar endere�o do sacado');
               toRetornoEnderecoSacadoAlterado : Add('Tipo ocorr�ncia  : Endere�o do sacado alterado');
               toRetornoEncaminhadoACartorio : Add('Tipo ocorr�ncia  : T�tulo encaminhado para cart�rio');
               toRetornoRetiradoDeCartorio : Add('Tipo ocorr�ncia  : T�tulo retirado do cart�rio');
               toRetornoRecebimentoInstrucaoDispensarJuros : Add('Tipo ocorr�ncia  : Recebimento de instruc�o para dispensar juros');
               toRetornoJurosDispensados : Add('Tipo ocorr�ncia  : Juros dispensados');
               toRetornoManutencaoTituloVencido : Add('Tipo ocorr�ncia  : Manuten��o de t�tulo vencido');
               toRetornoRecebimentoInstrucaoAlterarTipoCobranca : Add('Tipo ocorr�ncia  : Recebimento de instru��o para alterar tipo de cobran�a');
               toRetornoTipoCobrancaAlterado : Add('Tipo ocorr�ncia  : Tipo de cobran�a alterado');
               toRetornoDespesasProtesto : Add('Tipo ocorr�ncia  : Despesas com protesto');
               toRetornoDespesasSustacaoProtesto : Add('Tipo ocorr�ncia  : Despesas com susta��o de protesto');
               toRetornoProtestoOuSustacaoEstornado : Add('Tipo ocorr�ncia  : Protesto ou susta��o estornado');
               toRetornoDebitoTarifas : Add('Tipo ocorr�ncia  : D�bito de tarifas');
               toRetornoOutrasOcorrencias : Add('Tipo ocorr�ncia  : Outra ocorr�ncia de retorno');
            else
               Add('Tipo ocorr�ncia  : Outra ocorr�ncia n�o identificada');
            end; {case TipoOcorrencia}

            if trim(OcorrenciaOriginal) <> '' then
              if trim(DescricaoOcorrenciaOriginal) <> '' then
                 Add('Ocorr�nc original: ' + DescricaoOcorrenciaOriginal )
              else
                 Add('Ocorr�nc original: ' + OcorrenciaOriginal);
            if trim(MotivoRejeicaoComando) <> '' then
               Add('Motivo rejei��o  : ' + MotivoRejeicaoComando);
            if trim(SeuNumero) <> '' then
               Add('Seu n�mero       : ' + SeuNumero);
            if trim(NossoNumero) <> '' then
               Add('Nosso n�mero     : ' + NossoNumero + '-' + DigitoNossoNumero);
            if trim(Carteira) <> '' then
               Add('Carteira         : ' + Carteira);
            if trim(NumeroDocumento) <> '' then
               Add('N�mero documento : ' + NumeroDocumento);
            if DataDocumento <> 0 then
               Add('Data documento   : ' + DateToStr(DataDocumento));
            if DataVencimento <> 0 then
               Add('Data vencimento  : ' + DateToStr(DataVencimento));
            if DataOcorrencia <> 0 then
               Add('Data ocorr�ncia  : ' + DateToStr(DataOcorrencia));
            if DataCredito <> 0 then
               Add('Data cr�dito     : ' + DateToStr(DataCredito));
            Add('Valor documento  : ' + FormatCurr('#,##0.00',ValorDocumento));
            if ValorDespesaCobranca > 0 then
               Add('Despesa cobran�a : ' + FormatCurr('#,##0.00',ValorDespesaCobranca));
            if DataAbatimento <> 0 then
               Add('Abatimento at�   : ' + DateToStr(DataAbatimento));
            if ValorAbatimento > 0 then
               Add('Valor abatimento : ' + FormatCurr('#,##0.00',ValorAbatimento));
            if ValorDesconto > 0 then
               if DataDesconto <> 0 then
               begin
                  Add('Desconto at�     : ' + DateToStr(DataDesconto));
                  Add('Vr. desconto/dia : ' + FormatCurr('#,##0.00',ValorDesconto));
               end
               else
                  Add('Valor desconto   : ' + FormatCurr('#,##0.00',ValorDesconto));
            if ValorMoraJuros > 0 then
               if DataMoraJuros <> 0 then
               begin
                  Add('Juros a partir de: ' + DateToStr(DataMoraJuros));
                  Add('Valor juros/dia  : ' + FormatCurr('#,##0.00',ValorMoraJuros));
               end
               else
                  Add('Valor mora/juros : ' + FormatCurr('#,##0.00',ValorMoraJuros));
            if ValorMultaJuros > 0 then
              begin
                Add('Ap�s ' + DateToStr(DataMultaJuros) + ' multa de '+FormatCurr('#,##0.00',ValorMultaJuros));
              end;
            if ValorOutrosCreditos > 0 then
               Add('Outros acr�scimos: ' + FormatCurr('#,##0.00',ValorOutrosCreditos));
            if ValorIOF > 0 then
               Add('Valor IOF        : ' + FormatCurr('#,##0.00',ValorIOF));
            if (DataCredito <> 0) then
               Add('Valor do cr�dito : ' + FormatCurr('#,##0.00',ValorDocumento-ValorDespesaCobranca-ValorAbatimento-ValorDesconto+ValorMoraJuros+ValorOutrosCreditos-ValorOutrasDespesas));
            if DataProtesto <> 0 then
               Add('Protestar em     : ' + DateToStr(DataProtesto));
            if DataBaixa <> 0 then
               Add('Baixar em        : ' + DateToStr(DataBaixa));


            with Cedente do
            begin
               Add('CEDENTE');
               case TipoInscricao of
                  tiPessoaFisica  : Add(' Nome / CPF      : ' + Nome + ' / ' + FormatarComMascara('!###\.###\.###\.###\-##;0; ',NumeroCPFCGC));
                  tiPessoaJuridica: Add(' Nome / CNPJ     : ' + Nome + ' / ' + FormatarComMascara('!##\.###\.###\/####\-##;0; ',NumeroCPFCGC));
                  tiOutro         : Add(' Nome / Inscri��o: ' + Nome + ' / ' + NumeroCPFCGC);
               end;

               with Endereco do
                  if Trim(Rua + Numero + Complemento + Bairro + Cidade + Estado + CEP) <> '' then
                     Add(' Endere�o        : ' + Rua + ' ' + Numero + ' ' + Complemento + ' - ' + Bairro + ' - ' + Cidade + ' - ' + Estado + ' - ' + FormatMaskText('#####\-##;0; ',CEP));

               with ContaBancaria do
                  if trim(Banco.Codigo) <> '' then
                     Add(' Banco/Ag./Conta : ' + Banco.Codigo + '-' + Banco.Digito + ' - ' + Banco.Nome  + ' / ' + Trim(CodigoAgencia) + ' / ' + Trim(NumeroConta) + '-' + Trim(DigitoConta));

               if Trim(CodigoCedente + DigitoCodigoCedente) <> '' then
                  Add(' C�digo cedente  : ' + Trim(CodigoCedente) + '-' + Trim(DigitoCodigoCedente));
            end; {with Cedente}

            with Sacado do
            begin
               Add('SACADO');
               case TipoInscricao of
                  tiPessoaFisica  : Add(' Nome / CPF      : ' + Nome + ' / ' + FormatMaskText('!###\.###\.###\.###\-##;0; ',NumeroCPFCGC));
                  tiPessoaJuridica: Add(' Nome / CNPJ     : ' + Nome + ' / ' + FormatMaskText('!##\.###\.###\/####\-##;0; ',NumeroCPFCGC));
                  tiOutro         : Add(' Nome / Inscri��o: ' + Nome + ' / ' + NumeroCPFCGC);
               end;

               with Endereco do
                  if Trim(Rua + Numero + Complemento + Bairro + Cidade + Estado + CEP) <> '' then
                     Add(' Endere�o        : ' + Rua + ' ' + Numero + ' ' + Complemento + ' - ' + Bairro + ' - ' + Cidade + ' - ' + Estado + ' - ' + FormatMaskText('#####\-##;0; ',CEP));

               with ContaBancaria do
                  if trim(Banco.Codigo) <> '' then
                     Add(' Banco/Ag./Conta : ' + Banco.Codigo + '-' + Banco.Digito + ' - ' + Banco.Nome  + ' / ' + Trim(CodigoAgencia) + ' / ' + Trim(NumeroConta) + '-' + Trim(DigitoConta));
            end; {with Sacado}

            if Trim(Instrucoes.Text) <> '' then
            begin
               Add('<INSTRU��ES>     :');
               Add(Instrucoes.Text);
            end;
         end; {with Titulos[i]}

         Add('');
         Add(StringOfChar('-',80));
      end; {for I := 0 to (Count - 1)}
   end;
end;

function TgbCobranca.GerarBoletos: bool;
begin
  ImprimeBoletosB(Self);
end;

{$ENDIF}

end.

