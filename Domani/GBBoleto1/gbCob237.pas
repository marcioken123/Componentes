unit gbCob237;

interface

uses
   classes, SysUtils, gbCobranca
   {$IFDEF VER150}
      , Variants, MaskUtils, contnrs, DateUtils
   {$ELSEIF VER140}
      , Variants, MaskUtils, contnrs, DateUtils
   {$ELSE}
      {$IFDEF VER130}
         , Mask, contnrs
      {$ELSE}
         , Mask
      {$ENDIF}
   {$IFEND}
   ;

const
   CodigoBanco = '237';
   NomeBanco = 'BRADESCO';

type

   TgbBanco237 = class(TPersistent)
{$IFNDEF VER120}
   private
      function VerificaOcorrenciaOriginal(sOcorrenciaOriginal: String): String;
      function VerificaMotivoRejeicaoComando(sMotivoRejeicaoComando: String): String;
    //function GerarRemessaCNAB240(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
      function GerarRemessaCNAB400(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
    //function LerRetornoCNAB240(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
      function LerRetornoCNAB400(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
{$ENDIF}
   published
      function  GetNomeBanco   : string; {Retorna o nome do banco}
      function  GetCampoLivreCodigoBarra(ATitulo: TgbTitulo) : string; {Retorna o conte�do da parte vari�vel do c�digo de barras}
      function  CalcularDigitoNossoNumero(ATitulo: TgbTitulo) : string; {Calcula o d�gito do NossoNumero, conforme crit�rios definidos por cada banco}
      procedure FormatarBoleto(ATitulo: TgbTitulo; var AAgenciaCodigoCedente, ANossoNumero, ACarteira, AEspecieDocumento: string); {Define o formato como alguns valores ser�o apresentados no boleto }
{$IFNDEF VER120}
      function  LerRetorno(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean; {L� o arquivo retorno recebido do banco}
      function  GerarRemessa(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean; {Gerar arquivo remessa para enviar ao banco}
{$ENDIF}
   end;


implementation


function TgbBanco237.GetNomeBanco : string;
begin
   Result := NomeBanco;
end;

function TgbBanco237.CalcularDigitoNossoNumero(ATitulo: TgbTitulo) : string;
var
   ACarteira,
   ANossoNumero,
   ADigitoNossoNumero : string;
begin
   Result := '0';

   with ATitulo do
   begin
      ACarteira := Formatar(Carteira,2,false,'0');
      ANossoNumero := Formatar(NossoNumero,11,false,'0');
      ADigitoNossoNumero := Modulo11(ACarteira + ANossoNumero,7,true);
   end;
   if StrToInt(ADigitoNossoNumero) = 1 then
      ADigitoNossoNumero := 'P'
   else if StrToInt(ADigitoNossoNumero) > 1 then
      ADigitoNossoNumero := IntToStr(11 - StrToInt(ADigitoNossoNumero));

   Result := ADigitoNossoNumero;
end;

function TgbBanco237.GetCampoLivreCodigoBarra(ATitulo: TgbTitulo) : string;
var
   AAnoAtual,
   ACarteira,
   ANossoNumero,
   ACodigoAgencia,
   ANumeroConta: string;
begin

   {
    A primeira parte do c�digo de barras ser� calculada automaticamente.
    Ela � composta por:
    C�digo do banco (3 posi��es)
    C�digo da moeda = 9 (1 posi��o)
    D�gito do c�digo de barras (1 posi��o) - Ser� calculado e inclu�do pelo componente
    Fator de vencimento (4 posi��es) - Obrigat�rio a partir de 03/07/2000
    Valor do documento (10 posi��es) - Sem v�rgula decimal e com ZEROS � esquerda

    A segunda parte do c�digo de barras � um campo livre, que varia de acordo
    com o banco. Esse campo livre ser� calculado por esta fun��o (que voc� dever�
    alterar de acordo com as informa��es fornecidas pelo banco).
   }

   {Segunda parte do c�digo de barras - Campo livre - Varia de acordo com o banco}

   with ATitulo do
   begin
      ACarteira := Formatar(Carteira,2,false,'0');
      AAnoAtual := FormatDateTime('yy',Now());
      ANossoNumero := Formatar(NossoNumero,9,false,'0');
      ACodigoAgencia := Formatar(Cedente.ContaBancaria.CodigoAgencia,4,false,'0');
      ANumeroConta := Formatar(Cedente.ContaBancaria.NumeroConta,7,false,'0');
   end;

   Result := ACodigoAgencia + ACarteira + AAnoAtual + ANossoNumero + ANumeroConta + '0';
end;

procedure TgbBanco237.FormatarBoleto(ATitulo: TgbTitulo; var AAgenciaCodigoCedente, ANossoNumero, ACarteira, AEspecieDocumento: string);
begin
   with ATitulo do
   begin
      if CodigoBanco <> '237' then
         AAgenciaCodigoCedente := Formatar(Cedente.ContaBancaria.CodigoAgencia,4,false,'0') + '/' + Formatar(Cedente.CodigoCedente,7,false,'0') + '-' + Cedente.DigitoCodigoCedente;

      ANossoNumero := Formatar(Carteira,3,false,'0') + '/' + Formatar(Cedente.ContaBancaria.CodigoAgencia,4,false,'0') + '/' + Formatar(NossoNumero,7,false,'0') + '-' + DigitoNossoNumero;
      ACarteira := Formatar(Carteira,3,false,'0');
      //AEspecieDocumento := '01';  // estava em branco   01 = duplicata mercantil p/Bradesco
   end;
end;

{$IFNDEF VER120}

function TgbBanco237.GerarRemessaCNAB400(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
var
   ACedenteTipoInscricao, ASacadoTipoInscricao,
   Registro : string;
   NumeroRegistro : integer;
begin
   Result := FALSE;
   NumeroRegistro := 0;
   Remessa.Clear;

   with ACobranca do
   begin

      { GERAR REGISTRO-HEADER DA REMESSA }

      Remessa.Add('01REMESSA01'+
                  Formatar('COBRANCA',15)+
                  '000'+
                  Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.NumContrato,17,false,'0')+
                  {Formatar(Titulos[NumeroRegistro].Carteira,4,false,'0')+
                  Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.CodigoAgencia,5,false,'0')+
                  Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.NumeroConta,7,false,'0')+
                  Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoConta,1)+}
                  Formatar(Titulos[NumeroRegistro].Cedente.Nome,30,true,' ')+
                  Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0')+
                  Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Nome,15,true,' ')+
                  FormatDateTime('ddmmyy',DataArquivo)+
                  Formatar('',8)+'MX'+
                  Formatar(IntToStr(NumeroArquivo),7,false,'0')+
                  Formatar('',277)+
                  '000001');

      { GERAR TODOS OS REGISTROS DETALHE DA REMESSA }
      while NumeroRegistro <= (Titulos.Count - 1) do
      begin
         if Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0') <> Formatar(CodigoBanco,3,false,'0') then
            Raise Exception.CreateFmt('Titulo n�o pertence ao banco %s - %s',[CodigoBanco,NomeBanco]);

         case Titulos[NumeroRegistro].Cedente.TipoInscricao of
            tiPessoaFisica  : ACedenteTipoInscricao := '01';
            tiPessoaJuridica: ACedenteTipoInscricao := '02';
            tiOutro         : ACedenteTipoInscricao := '03';
         end;
         case Titulos[NumeroRegistro].Sacado.TipoInscricao of
            tiPessoaFisica  : ASacadoTipoInscricao := '01';
            tiPessoaJuridica: ASacadoTipoInscricao := '02';
            tiOutro         : ASacadoTipoInscricao := '03';
         end;

         Registro := '1';
         Registro := Registro + Formatar('',19,false,'0'); // 2 a 20
         Registro := Registro + '0'+Formatar(Titulos[NumeroRegistro].Carteira,3,false,'0'); // 21 a 23
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.CodigoAgencia,5,false,'0');
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.NumeroConta,7,false,'0');
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoConta,1);
         Registro := Registro + Formatar(Titulos[NumeroRegistro].SeuNumero,25,true,' '); // 38 a 62
//         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0'); // 63 a 65
         Registro := Registro + Formatar('0',3,false,'0'); // 63 a 65

         //**// estavam faltando estes cinco zeros...
         Registro := Registro + '00000';

         Registro := Registro + Formatar(Titulos[NumeroRegistro].NossoNumero,11,false,'0'); // 71 a 82
         Registro := Registro + Formatar(Titulos[NumeroRegistro].DigitoNossoNumero,1,false,'0');
         Registro := Registro + Formatar('',10,false,'0');
         //*********** Emiss�o Boleto *****************************************
         case Titulos[NumeroRegistro].EmissaoBoleto of // 93 Quem emite e quem distribui o boleto?
            ebBancoEmite      : Registro := Registro + '1' ;
            ebClienteEmite    : Registro := Registro + '2' ;
         else
            Raise Exception.CreateFmt('Identifica��o inv�lida de emiss�o de boleto em remessa - Nosso n�mero: %s / Seu n�mero: %s',[Titulos[NumeroRegistro].NossoNumero,Titulos[NumeroRegistro].SeuNumero]);
         end; //case Titulos[NumeroRegistro].EmissaoBoleto
         //*********************************************************************
         Registro := Registro + 'N'; // 94
         Registro := Registro + Formatar('',11); // 95 a 105
         Registro := Registro + '0'; // 106 - aviso de debito automatico (0 = sem aviso)
         Registro := Registro + Formatar('',2); // 107 a 108
         Registro := Registro + '01'; // 109 a 110
         Registro := Registro + Formatar(Titulos[NumeroRegistro].SeuNumero,10);
         Registro := Registro + FormatDateTime('ddmmyy',Titulos[NumeroRegistro].DataVencimento);
         Registro := Registro + FormatCurr('0000000000000',Titulos[NumeroRegistro].ValorDocumento * 100);
//         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0'); // 140 a 142 - num.do banco encarregado da cobranca
         Registro := Registro + Formatar('0',3,false,'0'); // 140 a 142 - num.do banco encarregado da cobranca
         Registro := Registro + Formatar('',5,false,'0'); // 143 a 147

         //*************** Especie do documento  *******************************
         case Titulos[NumeroRegistro].EspecieDocumento of {//148 a 149 - Esp�cie do documento}
            edDuplicataMercantil           : Registro := Registro + '01'; {DM  DUPLICATA MERCANTIL}
            edNotaPromissoria              : Registro := Registro + '02'; {NP  NOTA PROMISS�RIA}
            edNotaSeguro                   : Registro := Registro + '03'; {NS  NOTA DE SEGURO}
            edRecibo                       : Registro := Registro + '05'; {RC  RECIBO}
            edLetraCambio                  : Registro := Registro + '10'; {LC  LETRA DE C�MBIO}
            edNotaDebito                   : Registro := Registro + '11'; {ND  NOTA DE D�BITO}
            edDuplicataServico             : Registro := Registro + '12'; {DS  DUPLICATA DE SERVI�O}
         else
            Registro := Registro + '99'; {OUTROS}
         end; //case Titulos[NumeroRegistro].EspecieDocumento
         //*********************************************************************

         //**************Aceite Documento **************************************
         case Titulos[NumeroRegistro].AceiteDocumento of // 150 - Identifica��o de t�tulo Aceito / N�o aceito
            adSim : Registro := Registro + 'A';
            adNao : Registro := Registro + 'N';
         end; //case Titulos[NumeroRegistro].AceiteDocumento
         //*********************************************************************
         Registro := Registro + FormatDateTime('ddmmyy',Titulos[NumeroRegistro].DataDocumento); // 151 a 156

         if (Titulos[NumeroRegistro].Instrucoes.Count > 0) and (length(Titulos[NumeroRegistro].Instrucoes.strings[0]) = 2) then  // 157 a 158 - Primeira Instrucao
            Registro := Registro + Formatar(Titulos[NumeroRegistro].Instrucoes.strings[0],2,false,'0')
         else
            Registro := Registro + '00';
         if Trim(Titulos[NumeroRegistro].DiasProtesto) <> '' then
           Registro := Registro + Formatar(Titulos[NumeroRegistro].DiasProtesto,2,false,'0')
         else
           begin
             if (Titulos[NumeroRegistro].Instrucoes.Count > 1) and (length(Titulos[NumeroRegistro].Instrucoes.strings[1]) = 2) then  // 159 a 160 - Segunda Instrucao
                Registro := Registro + Formatar(Titulos[NumeroRegistro].Instrucoes.strings[1],2,false,'0')
             else
                Registro := Registro + '00';
           end;
         //Registro := Registro + Formatar(' ',4);

         Registro := Registro + FormatCurr('0000000000000',Titulos[NumeroRegistro].ValorMoraJuros*100); // 161 a 173 -  VALOR DE MORA POR DIA DE ATRASO
         //Registro := Registro + Formatar(' ',13,false,'0'); 161 a 173 - valor a ser cobrado por dia de atraso

         if Titulos[NumeroRegistro].DataDesconto <> 0 then // DATA LIMITE PARA CONCESS�O DE DESCONTO
            Registro := Registro + FormatDateTime('ddmmyy',Titulos[NumeroRegistro].DataDesconto)
         else
            Registro := Registro + Formatar(' ',6,false,'0');
         //Registro := Registro + Formatar(' ',6);

         Registro := Registro + Formatar(' ',13,false,'0');
         Registro := Registro + Formatar(' ',13,false,'0');
         Registro := Registro + Formatar(' ',13,false,'0');
         Registro := Registro + Formatar(ASacadoTipoInscricao,2,false,'0');
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.NumeroCPFCGC,14,false,'0');
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Nome,40);
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Rua+' '+Titulos[NumeroRegistro].Sacado.Endereco.Numero+' '+Titulos[NumeroRegistro].Sacado.Endereco.Complemento+' '+Titulos[NumeroRegistro].Sacado.Endereco.Bairro+' '+Titulos[NumeroRegistro].Sacado.Endereco.Cidade+' '+Titulos[NumeroRegistro].Sacado.Endereco.Estado,40);
         Registro := Registro + Formatar('',12);
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.CEP,8,true,'0');
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Instrucoes.Text,60);
         Registro := Registro + Formatar(IntToStr(NumeroRegistro+2),6,false,'0');
          Remessa.Add(Registro);
         NumeroRegistro := NumeroRegistro + 1;
      end;

      { GERAR REGISTRO TRAILER DA REMESSA }

      Remessa.Add('9'+Formatar('',393,true,' ')+Formatar(IntToStr(NumeroRegistro+2),6,false,'0'));
   end;

   Result := TRUE;
end;

function  TgbBanco237.GerarRemessa(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
begin
   case ACobranca.LayoutArquivo of
      laCNAB240 : Raise Exception.CreateFmt('A gera��o de arquivo de remessa para o %s n�o est� est� dispon�vel para o layout laCNAB240',[NomeBanco]);
      laCNAB400 : Result := GerarRemessaCNAB400(ACobranca, Remessa)
   else
      begin
         Result := FALSE;
         Raise Exception.Create('Layout de arquivo inv�lido. Diferente de laCNAB400');
      end; {else}
   end; {case}
end;


function TgbBanco237.LerRetornoCNAB400(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
var
   ACodigoBanco,
   ANomeCedente,
   ATipoInscricao : string;
   NumeroRegistro : integer;
   ATitulo : TgbTitulo;
begin
   NumeroRegistro := 0;
   ATitulo := TgbTitulo.Create(nil);

   TRY

      with ACobranca do
      begin
         Titulos.Clear; {Zera o conjunto de t�tulos, antes de incluir os t�tulos do arquivo retorno}

         if Retorno.Count <= 0 then
            Raise Exception.Create('O retorno est� vazio. N�o h� dados para processar');

         {Ver se o arquivo � mesmo RETORNO DE COBRAN�A}
         if Copy(Retorno.Strings[NumeroRegistro],1,19) <> '02RETORNO01COBRANCA' then
            Raise Exception.Create(NomeArquivo+' n�o � um arquivo de retorno de cobran�a');

         { L� registro HEADER}
         ACodigoBanco := Copy(Retorno.Strings[NumeroRegistro],77,3);
         if ACodigoBanco <> CodigoBanco then
            Raise Exception.CreateFmt('Este n�o � um retorno de cobran�a do banco %s - %s',[CodigoBanco,NomeBanco]);

         ANomeCedente := Trim(Copy(Retorno.Strings[NumeroRegistro],47,30));
         if StrToInt(Copy(Retorno.Strings[NumeroRegistro],99,2)) <= 69 then
            DataArquivo := EncodeDate(StrToInt('20'+Copy(Retorno.Strings[NumeroRegistro],99,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],97,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],95,2)))
         else
            DataArquivo := EncodeDate(StrToInt('19'+Copy(Retorno.Strings[NumeroRegistro],99,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],97,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],95,2)));

         NumeroArquivo := StrToInt(Trim(Copy(Retorno.Strings[NumeroRegistro],109,5)));

         {L� os registros DETALHE}
         {Processa at� o pen�ltimo registro porque o �ltimo cont�m apenas o TRAILLER}
         for NumeroRegistro := 1 to (Retorno.Count - 2) do
         begin
            {Confirmar se o tipo do registro � 1}
            if Copy(Retorno.Strings[NumeroRegistro],1,1) <> '1' then
               Continue; {N�o processa o registro atual}

            { Ler t�tulos do arquivo retorno}
            {Dados do titulo}
            with ATitulo do
            begin
               {Dados do cedente do t�tulo}
               with Cedente do
               begin
                  ATipoInscricao := Copy(Retorno.Strings[NumeroRegistro],2,2);
                  if ATipoInscricao = '01' then
                     TipoInscricao := tiPessoaFisica
                  else if ATipoInscricao = '02' then
                     TipoInscricao := tiPessoaJuridica
                  else
                     TipoInscricao := tiOutro;
                  NumeroCPFCGC := Copy(Retorno.Strings[NumeroRegistro],4,14);
                  ContaBancaria.Banco.Codigo := ACodigoBanco;
                  Nome := ANomeCedente;
               end; {with ACedente}

               NumeroDocumento := Copy(Retorno.Strings[NumeroRegistro],38,25);

               {Tipo de ocorr�ncia}
               OcorrenciaOriginal := Copy(Retorno.Strings[NumeroRegistro],109,2); //@w
               DescricaoOcorrenciaOriginal := VerificaOcorrenciaOriginal(OcorrenciaOriginal); //@w               
               case StrToInt(OcorrenciaOriginal) of
                  02: TipoOcorrencia := toRetornoRegistroConfirmado;
                  03: TipoOcorrencia := toRetornoRegistroRecusado;
                  06: TipoOcorrencia := toRetornoLiquidado;
                  09: TipoOcorrencia := toRetornoBaixado;
                  10: TipoOcorrencia := toRetornoBaixado;
                  11: TipoOcorrencia := toRetornoTituloEmSer;
                  12: TipoOcorrencia := toRetornoAbatimentoConcedido;
                  13: TipoOcorrencia := toRetornoAbatimentoCancelado;
                  14: TipoOcorrencia := toRetornoVencimentoAlterado;
                  15: TipoOcorrencia := toRetornoLiquidadoEmCartorio;
                  17: TipoOcorrencia := toRetornoLiquidadoSemRegistro;
                  18: TipoOcorrencia := toRetornoAcertoDepositaria;
                  19: TipoOcorrencia := toRetornoRecebimentoInstrucaoProtestar;
                  20: TipoOcorrencia := toRetornoRecebimentoInstrucaoSustarProtesto;
                  21: TipoOcorrencia := toRetornoDadosAlterados;
                  23: TipoOcorrencia := toRetornoEncaminhadoACartorio;
                  24: TipoOcorrencia := toRetornoRegistroRecusado;
                  27: TipoOcorrencia := toRetornoComandoRecusado;
                  28: TipoOcorrencia := toRetornoDebitoTarifas;
                  30: TipoOcorrencia := toRetornoComandoRecusado;
                  32: TipoOcorrencia := toRetornoComandoRecusado;
                  33: TipoOcorrencia := toRetornoRecebimentoInstrucaoAlterarDados;
                  34: TipoOcorrencia := toRetornoRetiradoDeCartorio;
                  99: TipoOcorrencia := toRetornoRegistroRecusado;
               else
                  TipoOcorrencia := toRetornoOutrasOcorrencias;
               end; {case StrToInt(ATipoOcorrencia)}

               if (TipoOcorrencia = toRetornoRegistroRecusado) or (TipoOcorrencia = toRetornoComandoRecusado) then
               begin
                  MotivoRejeicaoComando := Copy(Retorno.Strings[NumeroRegistro],319,2);
                  case StrToInt(MotivoRejeicaoComando) of
                     00 : DescricaoMotivoRejeicaoComando := '00 - Ocorrencia aceita';
                     17 : DescricaoMotivoRejeicaoComando := '17 - Data de vencimento anterior a data de emiss�o';
                     21 : DescricaoMotivoRejeicaoComando := '21 - Esp�cie do T�tulo inv�lido';
                     24 : DescricaoMotivoRejeicaoComando := '24 - Data da emiss�o inv�lida';
                     38 : DescricaoMotivoRejeicaoComando := '38 - Prazo para protesto inv�lido';
                     39 : DescricaoMotivoRejeicaoComando := '39 - Pedido para protesto n�o permitido para t�tulo';
                     43 : DescricaoMotivoRejeicaoComando := '43 - Prazo para baixa e devolu��o inv�lido';
                     45 : DescricaoMotivoRejeicaoComando := '45 - Nome do Sacado inv�lido';
                     46 : DescricaoMotivoRejeicaoComando := '46 - Tipo/num. de inscri��o do Sacado inv�lidos';
                     47 : DescricaoMotivoRejeicaoComando := '47 - Endere�o do Sacado n�o informado';
                     48 : DescricaoMotivoRejeicaoComando := '48 - CEP irregular';
                     50 : DescricaoMotivoRejeicaoComando := '50 - CEP referente a Banco correspondente';
                     53 : DescricaoMotivoRejeicaoComando := '53 - N� de inscri��o do Sacador/avalista inv�lidos  (CPF/CGC)';
                     54 : DescricaoMotivoRejeicaoComando := '54 - Sacador/avalista n�o informado';
                     67 : DescricaoMotivoRejeicaoComando := '67 - D�bito autom�tico agendado';
                     68 : DescricaoMotivoRejeicaoComando := '68 - D�bito n�o agendado - erro nos dados de remessa';
                     69 : DescricaoMotivoRejeicaoComando := '69 - D�bito n�o agendado - Sacado n�o consta no cadastro de autorizante';
                     70 : DescricaoMotivoRejeicaoComando := '70 - D�bito n�o agendado - Cedente n�o autorizado pelo Sacado';
                     71 : DescricaoMotivoRejeicaoComando := '71 - D�bito n�o agendado - Cedente n�o participa da modalidade de d�bito autom�tico';
                     72 : DescricaoMotivoRejeicaoComando := '72 - D�bito n�o agendado - C�digo de moeda diferente de R$';
                     73 : DescricaoMotivoRejeicaoComando := '73 - D�bito n�o agendado -  Data de vencimento inv�lida';
                     75 : DescricaoMotivoRejeicaoComando := '75 - D�bito n�o agendado - Tipo do n�mero de inscri��o do sacado debitado inv�lido';
                     86 : DescricaoMotivoRejeicaoComando := '86 - Seu n�mero do documento inv�lido'
                  else
                     MotivoRejeicaoComando := MotivoRejeicaoComando + ' - Outros motivos'
                  end; {case MotivoRejeicaoComando of}
               end; {if TipoOcorrencia...}

               if StrToInt(Copy(Retorno.Strings[NumeroRegistro],115,2)) <= 69 then
                  DataOcorrencia := EncodeDate(StrToInt('20'+Copy(Retorno.Strings[NumeroRegistro],115,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],113,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],111,2)))
               else
                  DataOcorrencia := EncodeDate(StrToInt('19'+Copy(Retorno.Strings[NumeroRegistro],115,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],113,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],111,2)));
               ValorDocumento := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],153,13))/100;
               ValorIOF := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],215,13))/100;
               ValorAbatimento := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],228,13))/100;
               ValorDesconto := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],241,13))/100;
               ValorMoraJuros := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],267,13))/100;
               ValorOutrosCreditos := StrToFloat(Trim(Copy(Retorno.Strings[NumeroRegistro],280,13)))/100;

               {Dados que variam de acordo com o banco}

               {Nosso n�mero SEM D�GITO}
               NossoNumero := Copy(Retorno.Strings[NumeroRegistro],71,11);
               Carteira := Copy(Retorno.Strings[NumeroRegistro],22,3);

               //**// estava ,24,5
               Cedente.ContaBancaria.CodigoAgencia := Copy(Retorno.Strings[NumeroRegistro],25,5);

               //**// estava ,29,7
               Cedente.ContaBancaria.NumeroConta := Copy(Retorno.Strings[NumeroRegistro],30,7);

               //**// estava ,30,1
               Cedente.ContaBancaria.DigitoConta := Copy(Retorno.Strings[NumeroRegistro],37,1);

               ValorDespesaCobranca := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],176,13))/100;
               ValorOutrasDespesas := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],189,13))/100;
               if Formatar(Copy(Retorno.Strings[NumeroRegistro],296,6),6,false,'0') <> '000000' then
                  if StrToInt(Copy(Retorno.Strings[NumeroRegistro],300,2)) <= 69 then
                     DataCredito := EncodeDate(StrToInt('20'+Copy(Retorno.Strings[NumeroRegistro],300,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],298,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],296,2)))
                  else
                     DataCredito := EncodeDate(StrToInt('19'+Copy(Retorno.Strings[NumeroRegistro],300,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],298,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],296,2)));

            end; {with ATitulo}

            {Insere o t�tulo}
            Titulos.Add(ATitulo);
         end;
      end;

      ATitulo.Free;
      Result := TRUE
   EXCEPT
      ATitulo.Free;
      Result := FALSE;
      Raise; {Propaga o erro}
   END;
end;

function TgbBanco237.LerRetorno(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
var
   ACodigoBanco,
   ANomeCedente,
   ATipoInscricao : string;
   NumeroRegistro : integer;
   ATitulo : TgbTitulo;
begin
   NumeroRegistro := 0;
   ATitulo := TgbTitulo.Create(nil);

   TRY

      with ACobranca do
      begin
         Titulos.Clear; {Zera o conjunto de t�tulos, antes de incluir os t�tulos do arquivo retorno}

         if Retorno.Count <= 0 then
            Raise Exception.Create('O retorno est� vazio. N�o h� dados para processar');

         case length(Retorno[0]) of
            240 :
               begin
                  Raise Exception.CreateFmt('A leitura de arquivo de retorno para o %s n�o est� est� dispon�vel para o layout laCNAB240',[NomeBanco]);
{
                  LayoutArquivo := laCNAB240;
                  Result := LerRetornoCNAB240(ACobranca, Retorno);
}
               end;
            400 :
               begin
                  LayoutArquivo := laCNAB400;
                  Result := LerRetornoCNAB400(ACobranca, Retorno);
               end
         else
            begin
               LayoutArquivo := laOutro;
               Raise Exception.CreateFmt('Tamanho de registro inv�lido: %d',[length(Retorno[0])]);
            end;
         end;
      end;

      ATitulo.Free;
      Result := TRUE
   EXCEPT
      ATitulo.Free;
      Result := FALSE;
      Raise; //Propaga o erro
   END;
end;



function TgbBanco237.VerificaOcorrenciaOriginal(sOcorrenciaOriginal: String): String;
begin
  if sOcorrenciaOriginal='  ' then begin
     Result:='';
     Exit;
  end;

  case StrToInt(sOcorrenciaOriginal) of
    02: Result:='02-Entrada Confirmada' ;
    03: Result:='03-Entrada Rejeitada' ;
    06: Result:='06-Liquida��o  normal' ;
    09: Result:='09-Baixado Automaticamente via Arquivo' ;
    10: Result:='10-Baixado conforme instru��es da Ag�ncia' ;
    11: Result:='11-Em Ser - Arquivo de T�tulos pendentes' ;
    12: Result:='12-Abatimento Concedido' ;
    13: Result:='13-Abatimento Cancelado' ;
    14: Result:='14-Vencimento Alterado' ;
    15: Result:='15-Liquida��o em Cart�rio' ;
    17: Result:='17-Liquida��o ap�s baixa ou T�tulo n�o registrado' ;
    18: Result:='18-Acerto de Deposit�ria' ;
    19: Result:='19-Confirma��o Recebimento Instru��o de Protesto' ;
    20: Result:='20-Confirma��o Recebimento Instru��o Susta��o de Protesto' ;
    21: Result:='21-Acerto do Controle do Participante' ;
    23: Result:='22-Entrada do T�tulo em Cart�rio' ;
    24: Result:='23-Entrada rejeitada por CEP Irregular' ;
    27: Result:='27-Baixa Rejeitada' ;
    28: Result:='28-D�bito de tarifas/custas' ;
    30: Result:='30-Altera��o de Outros Dados Rejeitados' ;
    32: Result:='32-Instru��o Rejeitada' ;
    33: Result:='33-Confirma��o Pedido Altera��o Outros Dados' ;
    34: Result:='34-Retirado de Cart�rio e Manuten��o Carteira' ;
    35: Result:='35-Desagendamento do d�bito autom�tico' ;
    68: Result:='68-Acerto dos dados do rateio de Cr�dito' ;
    69: Result:='69-Cancelamento dos dados do rateio' ;
  end;
end;

function TgbBanco237.VerificaMotivoRejeicaoComando(sMotivoRejeicaoComando: String): String;
begin
if sMotivoRejeicaoComando='  ' then begin
    Result:='';
    Exit;
end;

case StrToInt(sMotivoRejeicaoComando) of
   02: Result:='02-C�digo do registro detalhe inv�lido' ;
   03: Result:='03-C�digo da ocorr�ncia inv�lida' ;
   04: Result:='04-C�digo de ocorr�ncia n�o permitida para a carteira' ;
   05: Result:='05-C�digo de ocorr�ncia n�o num�rico' ;
   07: Result:='07-Ag�ncia/conta/Digito - Inv�lido' ;
   08: Result:='08-Nosso n�mero inv�lido' ;
   09: Result:='09-Nosso n�mero duplicado' ;
   10: Result:='10-Carteira inv�lida' ;
   16: Result:='16-Data de vencimento inv�lida' ;
   18: Result:='18-Vencimento fora do prazo de opera��o' ;
   20: Result:='19-Valor do T�tulo inv�lido' ;
   21: Result:='21-Esp�cie do T�tulo inv�lida' ;
   22: Result:='22-Esp�cie n�o permitida para a carteira' ;
   24: Result:='24-Data de emiss�o inv�lida' ;
   38: Result:='38-Prazo para protesto inv�lido' ;
   44: Result:='44-Ag�ncia Cedente n�o prevista' ;
   50: Result:='50-CEP irregular - Banco Correspondente' ;
   63: Result:='63-Entrada para T�tulo j� cadastrado' ;
   68: Result:='68-D�bito n�o agendado - erro nos dados de remessa' ;
   69: Result:='69-D�bito n�o agendado - Sacado n�o consta no cadastro de autorizante' ;
   70: Result:='70-D�bito n�o agendado - Cedente n�o autorizado pelo Sacado' ;
   71: Result:='71-D�bito n�o agendado - Cedente n�o participa da modalidade de d�bito autom�tico' ;
   72: Result:='72-�bito n�o agendado - C�digo de moeda diferente de R$' ;
   73: Result:='73-D�bito n�o agendado - Data de vencimento inv�lida' ;
   74: Result:='74-D�bito n�o agendado - Conforme seu pedido, T�tulo n�o registrado' ;
   75: Result:='75-D�bito n�o agendado - Tipo de n�mero de inscri��o do debitado inv�lido' ;
end;
end;

{$ENDIF}

initialization
RegisterClass(TgbBanco237);

end.

