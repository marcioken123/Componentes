unit gbCob151;

interface

uses
   classes, SysUtils, {DateUtils,} gbCobranca, Variants
   {$IFDEF VER140}
      , MaskUtils, DateUtils, contnrs
   {$ELSE}
      {$IFDEF VER130}
         , Mask, contnrs
      {$ELSE}
         , Mask
      {$ENDIF}
   {$ENDIF}
   ;

const
   CodigoBanco = '151';
   NomeBanco = 'Nossa Caixa';

type

   TgbBanco151 = class(TPersistent)
   private

   published
      function  GetNomeBanco   : string; {Retorna o nome do banco}
      function  GetCampoLivreCodigoBarra(ATitulo: TgbTitulo) : string; {Retorna o conte�do da parte vari�vel do c�digo de barras}
      function  CalcularDigitoNossoNumero(ATitulo: TgbTitulo) : string; {Calcula o d�gito do NossoNumero, conforme crit�rios definidos por cada banco}
      procedure FormatarBoleto(ATitulo: TgbTitulo; var AAgenciaCodigoCedente, ANossoNumero, ACarteira, AEspecieDocumento: string); {Define o formato como alguns valores ser�o apresentados no boleto }
      function  Digito1ASBACE(Valor: String): string; {Calcula o 1 digito da CHAVE ASBACE}
      function  Digito2ASBACE(var Valor: String): string; {Calcula o 2 digito da CHAVE ASBACE}

      function  GerarRemessaCNAB240(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
      function  GerarRemessaCNAB400(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
      function  LerRetornoCNAB240(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
      function  LerRetornoCNAB400(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
{$IFNDEF VER120}
      function  LerRetorno(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean; {L� o arquivo retorno recebido do banco}
      function  GerarRemessa(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean; {Gerar arquivo remessa para enviar ao banco}
{$ENDIF}
   end;


implementation


function TgbBanco151.GetNomeBanco : string;
begin
   Result := NomeBanco;
end;

function TgbBanco151.CalcularDigitoNossoNumero(ATitulo: TgbTitulo) : string;
var
   ACodigoAgencia,
   AModalidadeConta,
   ANumeroConta,
   ADigitoConta,
   ANossoNumero,
   AComposicao,
   APesos: string;
   ASoma,
   AResto,
   AContador: integer;
begin
   Result := '0';

   ACodigoAgencia   := Formatar(ATitulo.Cedente.ContaBancaria.CodigoAgencia,4,false,'0');
//   AModalidadeConta := Formatar(ATitulo.Cedente.ContaBancaria.ModalidadeConta,2,false,'0');
   AModalidadeConta := '13';
   ANumeroConta     := Formatar(ATitulo.Cedente.ContaBancaria.NumeroConta,7,false,'0');
   ADigitoConta     := Formatar(ATitulo.Cedente.ContaBancaria.DigitoConta,1,false,'0');
   ANossoNumero     := Formatar(ATitulo.NossoNumero,9,false,'0');

   AComposicao := ACodigoAgencia + AModalidadeConta + ANumeroConta + ADigitoConta + ANossoNumero;
   {
    Multiplicar os algarismos da composi��o, iniciando da direita para a esquerda
    pelos pesos: 3, 7, 9, 1, com exce��o do campo "D�gito da Conta", que deve ser
    multiplicado sempre por 1
   }
   APesos := '31973197319731319731973';

   ASoma := 0;
   for AContador := 1 to Length(AComposicao) do
      ASoma := ASoma + ( StrToInt(AComposicao[AContador]) * StrToInt(APesos[AContador]) );

   AResto := (ASoma mod 10);
   if AResto = 0 then
      Result := '0'
   else
      Result := IntToStr(10 - AResto);
end;

function TgbBanco151.Digito1ASBACE(Valor: String) : string;
var
   Pesos: string;
   Soma,
   Produto,
   Resto,
   Contador: integer;
begin
   Result := '0';

   { Multiplicar os pesos 2 e 1 pelos n�meros da composi��o,
     iniciando da direita para a esquerda.
   }
   Pesos := '21212121212121212121212';

   Soma := 0;
   for Contador := 1 to Length(Valor) do begin
   {  Somar os resultados da muttiplica��o e da subtra��o; se o produto da multiplica��o
   de qualquer dos n�meros da composi��o for maior que 9, deve-se subtrair o produto de 9.
   }
      Produto := ( StrToInt(Valor[Contador]) * StrToInt(Pesos[Contador]) );
      If Produto > 9 then Produto := Produto - 9;
      Soma := Soma + Produto;
   end;

   Resto := (Soma mod 10);
   if Resto = 0 then {Quando o resto for "0" (zero), o d�gito tamb�m ser� zero.}
      Result := '0'
   else
      Result := IntToStr(10 - Resto);
end;

function TgbBanco151.Digito2ASBACE(var Valor: String) : string;
var
   Pesos: string;
   Soma,
   Resto,
   Contador: integer;
begin
   Result := '0';

   { Multiplicar posicao pela sequencia de 2 a 7
     iniciando da direita para a esquerda.
   }
   Pesos := '765432765432765432765432';

   Soma := 0;
   for Contador := 1 to Length(Valor) do
   {  Somar os resultados da muttiplica��o. }
      Soma := Soma + ( StrToInt(Valor[Contador]) * StrToInt(Pesos[Contador]) );

   Resto := (Soma mod 11);
   case Resto of
      1 : Begin
         Valor := Copy(Valor,1,23)+IntToStr(StrToInt(Copy(Valor,24,1))+1);
         Result := Digito2ASBACE(Valor);
      end;
      0 : Result := '0';
   else
      Result := IntToStr(11 - Resto);
   end;
end;

function TgbBanco151.GetCampoLivreCodigoBarra(ATitulo: TgbTitulo) : string;
var
   CampoLivre,
   ACarteira,
   ANossoNumero,
   ACodigoAgencia,
   AContaCorrente,
   AModalidadeConta,
   ABancoCedente : string;
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
      ACarteira := '9'; // Identifica��o do Sistema
//      ACarteira := Formatar(Carteira,1,false,'0');
      ANossoNumero := Copy(Formatar(NossoNumero,8,false,'0'),1,8);
      ACodigoAgencia := Formatar(Cedente.ContaBancaria.CodigoAgencia,4,false,'0');
//      AModalidadeConta := Copy(Formatar(Cedente.ContaBancaria.ModalidadeConta,2,false,'0'),2,1);
      AModalidadeConta := '3';
      AContaCorrente := Formatar(Cedente.ContaBancaria.NumeroConta,6,false,'0');
      ABancoCedente  := Formatar(Cedente.ContaBancaria.Banco.Codigo,3,false,'0');
   end;

   CampoLivre := ACarteira + ANossoNumero + ACodigoAgencia + AModalidadeConta + AContaCorrente + ABancoCedente;
   CampoLivre := CampoLivre + Digito1ASBACE(CampoLivre);
   Result     := CampoLivre + Digito2ASBACE(CampoLivre);
end;

procedure TgbBanco151.FormatarBoleto(ATitulo: TgbTitulo; var AAgenciaCodigoCedente, ANossoNumero, ACarteira, AEspecieDocumento: string);
begin
   with ATitulo do
   begin
      LocalPagamento := 'Pague preferencialmente na Nossa Caixa';
      AAgenciaCodigoCedente := Formatar(Cedente.ContaBancaria.CodigoAgencia,4,false,'0') + ' ' +
//                               Formatar(Cedente.ContaBancaria.ModalidadeConta,2,false,'0') + ' ' +
                               '13' + ' ' +
                               Formatar(Cedente.ContaBancaria.NumeroConta,7,false,'0') + ' ' +
                               Formatar(Cedente.ContaBancaria.DigitoConta,1,false,'0');
      ANossoNumero := Formatar(NossoNumero,9,false,'0') + ' ' + DigitoNossoNumero;
      ACarteira := Formatar(Carteira,6);
      case EspecieDocumento of
         edAluguel                      : AEspecieDocumento := 'AL';
         edApoliceSeguro                : AEspecieDocumento := 'AP';
         edContribuicaoConfederativa    : AEspecieDocumento := 'CC';
         edDuplicataMercantil           : AEspecieDocumento := 'DM';
         edDuplicataRural               : AEspecieDocumento := 'DR';
         edDuplicataServico             : AEspecieDocumento := 'DS';
         edFatura                       : AEspecieDocumento := 'FT';
         edLetraCambio                  : AEspecieDocumento := 'LC';
         edNotaDebito                   : AEspecieDocumento := 'ND';
         edNotaPromissoria              : AEspecieDocumento := 'NP';
         edNotaPromissoriaRural         : AEspecieDocumento := 'NPR';
         edNotaSeguro                   : AEspecieDocumento := 'NS';
         edRecibo                       : AEspecieDocumento := 'RC';
         edTriplicataMercantil          : AEspecieDocumento := 'TM';
         edTriplicataServico            : AEspecieDocumento := 'TS'
      else
         AEspecieDocumento := '';
      end;
   end;
end;


{$IFNDEF VER120}

function TgbBanco151.GerarRemessa(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
begin
   case ACobranca.LayoutArquivo of
      laCNAB240 : Result := GerarRemessaCNAB240(ACobranca, Remessa);
      laCNAB400 : Result := GerarRemessaCNAB400(ACobranca, Remessa);
   end;
end;

function TgbBanco151.GerarRemessaCNAB240(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
var
   ACedenteTipoInscricao, ASacadoTipoInscricao,
   Registro : string;
   NumeroRegistro, NumeroLote : integer;
begin
   Result := FALSE;
   NumeroRegistro := 0;
   NumeroLote := 1;
   Registro := '';
   Remessa.Clear;

   if ACobranca.Titulos.Count < 1 then
      Exception.Create('N�o h� t�tulos para gerar remessa');

   with ACobranca do
   begin

      { GERAR REGISTRO-HEADER DO ARQUIVO }

      case Titulos[NumeroRegistro].Cedente.TipoInscricao of
         tiPessoaFisica  : ACedenteTipoInscricao := '1';
         tiPessoaJuridica: ACedenteTipoInscricao := '2';
         tiOutro         : ACedenteTipoInscricao := '3';
      end;

      if Formatar(CodigoBanco,3,false,'0') <> Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0') then
         Raise Exception.CreateFmt('O t�tulo (Nosso N�mero: %s) n�o pertence ao banco %s (%s)',[Titulos[NumeroRegistro].NossoNumero,CodigoBanco,NomeBanco]);

      Registro := Formatar(CodigoBanco,3,false,'0'); {C�digo do banco}
      Registro := Registro + '0000'; {Lote de servi�o}
      Registro := Registro + '0'; {Tipo de registro - Registro header de arquivo}
      Registro := Registro + Formatar('',9); {Uso exclusivo FEBRABAN/CNAB}
      Registro := Registro + ACedenteTipoInscricao; {Tipo de inscri��o do cedente}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.NumeroCPFCGC,14,false,'0'); {N�mero de inscri��o do cedente}
      Registro := Registro + Formatar('',20); {Vago}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.CodigoAgencia,5,false,'0'); {C�digo da ag�ncia do cedente}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoAgencia,1,false,'0'); {D�gito da ag�ncia do cedente}
//      Registro := Registro + '0000'+Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.ModalidadeConta,2,false,'0'); {Modalidade da conta}
      Registro := Registro + '0000'+'13'; {Modalidade da conta}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.NumeroConta,6,false,'0'); {N�mero da conta do cedente}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoConta,1,false,'0'); {D�gito da conta do cedente}
      Registro := Registro + Formatar('',1); {Vago}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.Nome,30,true,' '); {Nome do cedente}
      Registro := Registro + Formatar('NOSSA CAIXA-NOSSO BANCO',30,true,' '); {Nome do banco}
      Registro := Registro + Formatar('',10); {Uso exclusivo FEBRABAN/CNAB}
      Registro := Registro + '1'; {C�digo de Remessa (1) / Retorno (2)}
      Registro := Registro + FormatDateTime('ddmmyyyy',DataArquivo); {Data do de gera��o do arquivo}
      Registro := Registro + FormatDateTime('hhmmss',DataArquivo);  {Hora de gera��o do arquivo}
      Registro := Registro + Formatar(IntToStr(NumeroArquivo),6,false,'0'); {N�mero seq�encial do arquivo}
      Registro := Registro + '020'; {N�mero da vers�o do layout do arquivo}
      Registro := Registro + Formatar('',5,false,'0'); {Vago}
      Registro := Registro + Formatar('',69); {Vago}
      Remessa.Add(Registro);
      Registro := '';

      {GERAR REGISTRO HEADER DO LOTE}
      Registro := Formatar(CodigoBanco,3,false,'0'); {C�digo do banco}
      Registro := Registro + Formatar(IntToStr(NumeroLote),4,false,'0'); {N�mero do lote de servi�o}
      Registro := Registro + '1'; {Tipo do registro - Registro header de lote}
      Registro := Registro + 'R'; {Tipo de opera��o: R (Remessa) ou T (Retorno)}
      Registro := Registro + '01'; {Tipo de servi�o: 01 (Cobran�a)}
      Registro := Registro + '00'; {Forma de lan�amento: preencher com ZEROS no caso de cobran�a}
      Registro := Registro + '020'; {N�mero da vers�o do layout do lote}
      Registro := Registro + ' '; {Uso exclusivo FEBRABAN/CNAB}
      Registro := Registro + ACedenteTipoInscricao; {Tipo de inscri��o do cedente}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.NumeroCPFCGC,15,false,'0'); {N�mero de inscri��o do cedente}
      Registro := Registro + Formatar('',20); {Vago}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.CodigoAgencia,5,false,'0'); {C�digo da ag�ncia do cedente}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoAgencia,1,false,'0'); {D�gito da ag�ncia do cedente}
//      Registro := Registro + '0000'+Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.ModalidadeConta,2,false,'0'); {Modalidade da conta}
      Registro := Registro + '0000'+'13'; {Modalidade da conta}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.NumeroConta,6,false,'0'); {N�mero da conta do cedente}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoConta,1,false,'0'); {D�gito da conta do cedente}
      Registro := Registro + ' '; {Vago}
      Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.Nome,30,true,' '); {Nome do cedente}

      // VERIFICAR CODIFICA��O DA MENSAGENS NA AG�NCIA ORIGEM.
      Registro := Registro + Formatar('',3,false,'0'); {Mensagem 1 (Codificada)}
      Registro := Registro + Formatar('',3,false,'0'); {Mensagem 2 (Codificada)}

      Registro := Registro + Formatar('',40); {Instru��o Adicional (Mensagem Descritiva)}
      Registro := Registro + Formatar('',34); {Vago}
      Registro := Registro + Formatar(IntToStr(NumeroArquivo),8,false,'0'); {N�mero da remessa}
      Registro := Registro + FormatDateTime('ddmmyyyy',DataArquivo); {Data de gera��o do arquivo}
      Registro := Registro + Formatar('',8,false,'0'); {Vago}
      Registro := Registro + Formatar('',33); {Uso exclusivo FEBRABAN/CNAB}

      Remessa.Add(Registro);
      Registro := '';

      { GERAR TODOS OS REGISTROS DETALHE DA REMESSA }
      while NumeroRegistro <= (Titulos.Count - 1) do
      begin

         if Formatar(CodigoBanco,3,false,'0') <> Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0') then
            Raise Exception.CreateFmt('O t�tulo (Nosso N�mero: %s) n�o pertence ao banco %s (%s)',[Titulos[NumeroRegistro].NossoNumero,CodigoBanco,NomeBanco]);

         {SEGMENTO P}
         if Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.Banco.Codigo,3,false,'0') <> Formatar(CodigoBanco,3,false,'0') then
            Raise Exception.CreateFmt('Titulo n�o pertence ao banco %s - %s',[CodigoBanco,NomeBanco]);

         case Titulos[NumeroRegistro].Cedente.TipoInscricao of
            tiPessoaFisica  : ACedenteTipoInscricao := '1';
            tiPessoaJuridica: ACedenteTipoInscricao := '2';
            tiOutro         : ACedenteTipoInscricao := '9';
         end;

         Registro := Formatar(CodigoBanco,3,false,'0'); // C�digo do banco
         Registro := Registro + '0001'; // Lote de Servi�o
         Registro := Registro + '3'; // Tipo do registro: Registro transa��o
         Registro := Registro + Formatar(IntToStr(2*NumeroRegistro+1),5,false,'0'); // N�mero seq�encial do registro no lote - Cada t�tulo tem 2 registros (P e Q)
         Registro := Registro + 'P'; // C�digo do segmento do registro transa��o
         Registro := Registro + ' '; // Vago
         case Titulos[NumeroRegistro].TipoOcorrencia of // C�digo Movimento
            toRemessaRegistrar                 : Registro := Registro + '01';
            toRemessaBaixar                    : Registro := Registro + '02';
            toRemessaConcederAbatimento        : Registro := Registro + '04';
            toRemessaCancelarAbatimento        : Registro := Registro + '05';
            toRemessaAlterarVencimento         : Registro := Registro + '06';
//            toRemessaConcederDesconto          : Registro := Registro + '07';
//            toRemessaCancelarDesconto          : Registro := Registro + '08';
            toRemessaProtestar                 : Registro := Registro + '09';
            toRemessaCancelarInstrucaoProtesto : Registro := Registro + '10';

//            toRemessaDispensarJuros            : Registro := Registro + '31';
            toRemessaAlterarNomeEnderecoSacado : Registro := Registro + '31';
         else
            Raise Exception.CreateFmt('Ocorr�ncia inv�lida em remessa - Nosso n�mero: %s / Seu n�mero: %s',[Titulos[NumeroRegistro].NossoNumero,Titulos[NumeroRegistro].SeuNumero]);
         end; {case Titulos[NumeroRegistro].TipoOcorrencia}

         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.CodigoAgencia,5,false,'0'); // Ag�ncia mantenedora da conta
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoAgencia,1,false,'0'); // D�gito verificador da ag�ncia
//         Registro := Registro + '0000'+Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.ModalidadeConta,2,false,'0'); // Modalidade da conta
         Registro := Registro + '0000'+'13'; // Modalidade da conta
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.NumeroConta,6,false,'0'); // N�mero da conta corrente
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Cedente.ContaBancaria.DigitoConta,1,false,'0'); // D�gito verificador da conta
         Registro := Registro + '00'; // Modelo do Bloquete - 00: JAC002, 03: JAC011, 08: JAC010
         Registro := Registro + Formatar('',3); // Vago
         Registro := Registro + Formatar('',6,false,'0'); // Vago
         Registro := Registro + Formatar(Titulos[NumeroRegistro].NossoNumero,9,false,'0'); // Nosso Numero
         Registro := Registro + Formatar(Titulos[NumeroRegistro].DigitoNossoNumero,1,false,'0'); // Digito Nosso Numero
         Registro := Registro + '06'; // Codigo da Carteira
         Registro := Registro + '2';  // Forma de cadastramento do t�tulo no banco 1-Com Registro; 2-Emiss�o de bloquete; 5-Registra e emite bloquete

         case Titulos[NumeroRegistro].EmissaoBoleto of // Quem emite e quem distribui o boleto?
            ebBancoEmite      : Registro := Registro + '1' + '0';
            ebClienteEmite    : Registro := Registro + '2' + '0';
//            ebBancoReemite    : Registro := Registro + '4' + '0';
//            ebBancoNaoReemite : Registro := Registro + '5' + '0';
         else
            Raise Exception.CreateFmt('Identifica��o inv�lida de emiss�o de boleto em remessa - Nosso n�mero: %s / Seu n�mero: %s',[Titulos[NumeroRegistro].NossoNumero,Titulos[NumeroRegistro].SeuNumero]);
         end; //case Titulos[NumeroRegistro].EmissaoBoleto

         Registro := Registro + Formatar('',3); // Vago
         Registro := Registro + Formatar(Titulos[NumeroRegistro].SeuNumero,13,false,'0'); // N�mero que identifica o t�tulo na empresa
         Registro := Registro + FormatDateTime('ddmmyyyy',Titulos[NumeroRegistro].DataVencimento); // Data de vencimento do t�tulo
         Registro := Registro + FormatCurr('000000000000000',Titulos[NumeroRegistro].ValorDocumento * 100); // Valor nominal do t�tulo
         Registro := Registro + Formatar('',5,false,'0'); // Ag�ncia cobradora. Se ficar em branco, o banco determina automaticamente pelo CEP do sacado
         Registro := Registro + ' '; // D�gito da ag�ncia cobradora

         case Titulos[NumeroRegistro].EspecieDocumento of // C�digo do documento
//            edCheque                       : Registro := Registro + '01'; // CH  CHEQUE
            edDuplicataMercantil           : Registro := Registro + '02'; // DM  DUPLICATA MERCANTIL
//            edDuplicataMercantialIndicacao : Registro := Registro + '03'; // DMI DUPLICATA MERCANTIL P/ INDICA��O
            edDuplicataServico             : Registro := Registro + '04'; // DS  DUPLICATA DE SERVI�O
//            edDuplicataServicoIndicacao    : Registro := Registro + '05'; // DSI DUPLICATA DE SERVI�O P/ INDICA��O
            edDuplicataRural               : Registro := Registro + '06'; // DR  DUPLICATA RURAL
            edLetraCambio                  : Registro := Registro + '07'; // LC  LETRA DE C�MBIO
//            edNotaCreditoComercial         : Registro := Registro + '08'; // NCC NOTA DE CR�DITO COMERCIAL
//            edNotaCreditoExportacao        : Registro := Registro + '09'; // NCE NOTA DE CR�DITO A EXPORTA��O
//            edNotaCreditoIndustrial        : Registro := Registro + '10'; // NCI NOTA DE CR�DITO INDUSTRIAL
//            edNotaCreditoRural             : Registro := Registro + '11'; // NCR NOTA DE CR�DITO RURAL
            edNotaPromissoria              : Registro := Registro + '12'; // NP  NOTA PROMISS�RIA
            edNotaPromissoriaRural         : Registro := Registro + '13'; // NPR NOTA PROMISS�RIA RURAL
            edNotaSeguro                   : Registro := Registro + '16'; // NS  NOTA DE SEGURO
            edRecibo                       : Registro := Registro + '17'; // RC  RECIBO
            edFatura                       : Registro := Registro + '18'; // FAT FATURA
            edNotaDebito                   : Registro := Registro + '19'; // ND  NOTA DE D�BITO
            edApoliceSeguro                : Registro := Registro + '20'; // AP  AP�LICE DE SEGURO
//            edMensalidadeEscolar           : Registro := Registro + '21'; // ME  MENSALIDADE ESCOLAR
            edTriplicataMercantil          : Registro := Registro + '22'; // TM  TRIPLICATA MERCANTIL
            edTriplicataServico            : Registro := Registro + '23'  // TS  TRIPLICATA DE SERVI�O
         else
            Registro := Registro + '99'; // OUTROS
         end; // case Titulos[NumeroRegistro].EspecieDocumento

         case Titulos[NumeroRegistro].AceiteDocumento of // Identifica��o de t�tulo Aceito / N�o aceito
            adSim : Registro := Registro + 'A';
            adNao : Registro := Registro + 'N';
         end; // case Titulos[NumeroRegistro].AceiteDocumento

         Registro := Registro + FormatDateTime('ddmmyyyy',Titulos[NumeroRegistro].DataDocumento); // Data da emiss�o do documento

         // Posicao 119
         if Titulos[NumeroRegistro].ValorMoraJuros > 0 then
         begin
            Registro := Registro + '1'; // C�digo de juros de mora: Valor por dia
            Registro := Registro + Formatar('',8); // Vago
            Registro := Registro + FormatCurr('000000000000000',Titulos[NumeroRegistro].ValorMoraJuros * 100); //Valor de juros de mora por dia
         end
         else
         begin
            Registro := Registro + '3'; // C�digo de juros de mora: // 1-Valor di�rio; 2-Taxa mensal em percentagem; 3-Isento
            Registro := Registro + Formatar('',8); // Vago
            Registro := Registro + Formatar('',15,false,'0'); // Juros de Mora por Dia / Taxa Mensal
         end;

         // Posicao 143
         if Titulos[NumeroRegistro].ValorDesconto > 0 then
         begin
            Registro := Registro + '1'; // C�digo de desconto: Valor fixo at� a data informada
            if Titulos[NumeroRegistro].DataDesconto <> null then
               Registro := Registro + FormatDateTime('ddmmyyyy',Titulos[NumeroRegistro].DataDesconto) // Data do desconto
            else
               Registro := Registro + Formatar('',8,false,'0'); // Data at� a qual ser� concedido desconto
            Registro := Registro + FormatCurr('000000000000000',Titulos[NumeroRegistro].ValorDesconto * 100); // Valor do desconto por dia
         end
         else
         begin
            Registro := Registro + '1'; // C�digo de desconto: Sem desconto
            Registro := Registro + Formatar('',8,false,'0'); // Data at� a qual ser� concedido desconto
            Registro := Registro + Formatar('',15,false,'0'); // Valor do desconto por dia
         end;
         Registro := Registro + Formatar('',30); // Vago
         Registro := Registro + Formatar(Titulos[NumeroRegistro].SeuNumero,25); // Uso da Empresa - numero do registro

         // Posicao 223
         Registro := Registro + '00'; // Numero de dias para protesto - 00: Prazo de protesto negociado na Agencia.
         Registro := Registro + Formatar('',4); // Vago
         Registro := Registro + '00'; // C�digo da moeda: Real
         Registro := Registro + Formatar('',3); // Vago
         Registro := Registro + Formatar('',3,false,'0'); // Codigo de Investimento
         Registro := Registro + Formatar('',4); // Vago

         Remessa.Add(Registro);
         Registro := '';

         // TRANSA��O 3 - SEGMENTO Q (OBRIGAT�RIO PARA MOVIMENTO 01)
         case Titulos[NumeroRegistro].Sacado.TipoInscricao of
            tiPessoaFisica  : ASacadoTipoInscricao := '1';
            tiPessoaJuridica: ASacadoTipoInscricao := '2';
            tiOutro         : ASacadoTipoInscricao := '9';
         end;

         Registro := Formatar(CodigoBanco,3,false,'0'); {C�digo do banco}
         Registro := Registro + '0001'; {Lote de Servi�o}
         Registro := Registro + '3'; {Tipo do registro: Registro transa��o}
         Registro := Registro + Formatar(IntToStr(2*NumeroRegistro+2),5,false,'0'); {N�mero seq�encial do registro no lote - Cada t�tulo tem 2 registros (P e Q)}
         Registro := Registro + 'Q'; {C�digo do segmento do registro transa��o}
         Registro := Registro + ' '; {Uso exclusivo FEBRABAN/CNAB: Branco}

         case Titulos[NumeroRegistro].TipoOcorrencia of {C�digo de movimento}
            toRemessaRegistrar                 : Registro := Registro + '01';
            toRemessaBaixar                    : Registro := Registro + '02';
            toRemessaConcederAbatimento        : Registro := Registro + '04';
            toRemessaCancelarAbatimento        : Registro := Registro + '05';
            toRemessaAlterarVencimento         : Registro := Registro + '06';
//            toRemessaConcederDesconto          : Registro := Registro + '07';
//            toRemessaCancelarDesconto          : Registro := Registro + '08';
            toRemessaProtestar                 : Registro := Registro + '09';
            toRemessaCancelarInstrucaoProtesto : Registro := Registro + '10';

//            toRemessaDispensarJuros            : Registro := Registro + '31';
            toRemessaAlterarNomeEnderecoSacado : Registro := Registro + '31';
         else
            Raise Exception.CreateFmt('Ocorr�ncia inv�lida em remessa - Nosso n�mero: %s / Seu n�mero: %s',[Titulos[NumeroRegistro].NossoNumero,Titulos[NumeroRegistro].SeuNumero]);
         end; {case Titulos[NumeroRegistro].TipoOcorrencia}

         // Dados do sacado - Posicao 18
         Registro := Registro + Formatar(ASacadoTipoInscricao,1,false,'0');
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.NumeroCPFCGC,15,false,'0');
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Nome,40);
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Rua+' '+Titulos[NumeroRegistro].Sacado.Endereco.Numero+' '+Titulos[NumeroRegistro].Sacado.Endereco.Complemento,40);
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Bairro,15);
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.CEP,8,true,'0');
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Cidade,15,true);
         Registro := Registro + Formatar(Titulos[NumeroRegistro].Sacado.Endereco.Estado,2,false);
         // Dados do sacador/avalista - Posicao 154
         Registro := Registro + '0'; {Tipo de inscri��o: N�o informado}
         Registro := Registro + Formatar('',15,false,'0'); {N�mero de inscri��o}
         Registro := Registro + Formatar('',40); {Nome do sacador/avalista}
         Registro := Registro + Formatar('',31); // Vago

         Remessa.Add(Registro);
         NumeroRegistro := NumeroRegistro + 1;
      end; {GERAR TODOS OS REGISTROS DETALHE DA REMESSA}

      {REGISTRO TRAILER DO LOTE}
      Registro := Formatar(CodigoBanco,3,false,'0'); {C�digo do banco}
      Registro := Registro + '0001'; {Lote de Servi�o}
      Registro := Registro + '5'; {Tipo do registro: Registro trailer do lote}
      Registro := Registro + Formatar('',9); // Vago
      {Quantidade de registros do lote, incluindo header e trailer do lote.
       At� este momento Remessa cont�m:
       1 registro header de arquivo - � preciso exclu�-lo desta contagem
       1 registro header de lote
       Diversos registros detalhe
       Falta incluir 1 registro trailer de lote
       Ou seja Quantidade = Remessa.Count - 1 header de arquivo + 1 trailer de lote = Remessa.Count}
      Registro := Registro + Formatar(IntToStr(Remessa.Count),6,false,'0');
      Registro := Registro + Formatar('',217); // Vago

      Remessa.Add(Registro);
      Registro := '';

      {GERAR REGISTRO TRAILER DO ARQUIVO}
      Registro := Formatar(CodigoBanco,3,false,'0'); {C�digo do banco}
      Registro := Registro + '9999'; {Lote de servi�o}
      Registro := Registro + '9'; {Tipo do registro: Registro trailer do arquivo}
      Registro := Registro + Formatar('',9); {Uso exclusivo FEBRABAN/CNAB}
      Registro := Registro + Formatar(IntToStr(NumeroLote),6,false,'0'); {Quantidade de lotes do arquivo}
      Registro := Registro + Formatar(IntToStr(Remessa.Count + 1),6,false,'0'); {Quantidade de registros do arquivo, inclusive este registro que est� sendo criado agora}
      Registro := Registro + Formatar('',6,false,'0'); // Vago
      Registro := Registro + Formatar('',205); // Vago

      Remessa.Add(Registro);
   end;

   Result := TRUE;
end;

function TgbBanco151.GerarRemessaCNAB400(var ACobranca: TgbCobranca; var Remessa: TStringList) : boolean;
begin
   Raise Exception.CreateFmt('Processamento de arquivo remessa CNAB400 n�o est� dispon�vel para o banco %s - %s',[CodigoBanco, NomeBanco]);
end;

function TgbBanco151.LerRetorno(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
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
         Titulos.Clear; // Zera o conjunto de t�tulos, antes de incluir os t�tulos do arquivo retorno

         if Retorno.Count <= 0 then
            Raise Exception.Create('O retorno est� vazio. N�o h� dados para processar');

         case length(Retorno[0]) of
            240 :
               begin
                  LayoutArquivo := laCNAB240;
                  Result := LerRetornoCNAB240(ACobranca, Retorno);
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

         NumeroArquivo := StrToInt(Trim(Copy(Retorno.Strings[NumeroRegistro],390,5)));

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

               SeuNumero := Copy(Retorno.Strings[NumeroRegistro],38,25);
{               if StrToInt(Copy(Retorno.Strings[NumeroRegistro],115,2)) <= 69 then
                  DataRecebimento := EncodeDate(StrToInt('20'+Copy(Retorno.Strings[NumeroRegistro],115,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],113,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],111,2)))
               else
                  DataRecebimento := EncodeDate(StrToInt('19'+Copy(Retorno.Strings[NumeroRegistro],115,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],113,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],111,2)));}
               ValorDocumento := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],153,13))/100;
               ValorIOF := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],215,13))/100;
               ValorAbatimento := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],228,13))/100;
               ValorDesconto := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],241,13))/100;
               ValorMoraJuros := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],267,13))/100;
               ValorOutrosCreditos := StrToFloat(Trim(Copy(Retorno.Strings[NumeroRegistro],280,13)))/100;

               {Dados que variam de acordo com o banco}

               {Nosso n�mero SEM D�GITO}
               NossoNumero := Copy(Retorno.Strings[NumeroRegistro],63,10);
               Cedente.ContaBancaria.CodigoAgencia := Copy(Retorno.Strings[NumeroRegistro],18,4);
               Cedente.ContaBancaria.NumeroConta := Copy(Retorno.Strings[NumeroRegistro],22,11);
               Cedente.ContaBancaria.DigitoConta := Copy(Retorno.Strings[NumeroRegistro],33,1);
               Carteira := Copy(Retorno.Strings[NumeroRegistro],107,2);
               ValorDespesaCobranca := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],176,13))/100;
               if StrToInt(Copy(Retorno.Strings[NumeroRegistro],298,2)) <= 69 then
                  DataCredito := EncodeDate(StrToInt('20'+Copy(Retorno.Strings[NumeroRegistro],298,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],296,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],294,2)))
               else
                  DataCredito := EncodeDate(StrToInt('19'+Copy(Retorno.Strings[NumeroRegistro],298,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],296,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],294,2)));
               Sacado.Nome := Copy(Retorno.Strings[NumeroRegistro],325,30);

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

function TgbBanco151.LerRetornoCNAB240(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
var
   ACodigoBanco,
   ANomeCedente,
   ATipoInscricao,
   ANumeroCPFCGC,
   ACodigoCedente,
   ACodigoAgencia,
   ADigitoCodigoAgencia,
   AModalidade,
   ANumeroConta,
   ADigitoNumeroConta,
   ATipoOcorrencia : string;
   NumeroRegistro : integer;
   ATitulo : TgbTitulo;
begin
   Raise Exception.CreateFmt('Processamento de arquivo retorno CNAB240 n�o est� dispon�vel para o banco %s - %s',[CodigoBanco, NomeBanco]);

   NumeroRegistro := 0;
   ATitulo := TgbTitulo.Create(nil);

   TRY

      with ACobranca do
      begin
         Titulos.Clear; {Zera o conjunto de t�tulos, antes de incluir os t�tulos do arquivo retorno}

         if Retorno.Count <= 0 then
            Raise Exception.Create('O retorno est� vazio. N�o h� dados para processar');

         if length(Retorno[0]) <> 240 then
         begin
            LayoutArquivo := laOutro;
            Raise Exception.CreateFmt('Tamanho de registro diferente de 240 bytes. Tamanho = %d bytes',[length(Retorno[0])]);
         end;

         LayoutArquivo := laCNAB240;

         {Ver se o arquivo � mesmo RETORNO DE COBRAN�A}
         if Copy(Retorno.Strings[NumeroRegistro],143,1) <> '2' then
            Raise Exception.Create(NomeArquivo+' n�o � um arquivo de retorno de cobran�a com layout CNAB240');

         { L� registro HEADER}
         ACodigoBanco := Copy(Retorno.Strings[NumeroRegistro],1,3);
         if ACodigoBanco <> CodigoBanco then
            Raise Exception.CreateFmt('Este n�o � um retorno de cobran�a do banco %s - %s',[CodigoBanco,NomeBanco]);

         if Copy(Retorno.Strings[NumeroRegistro],8,1) <> '0' then
            Raise Exception.Create('Este n�o � um registro HEADER v�lido para arquivo de retorno de cobran�a com layout CNAB240');

         {Dados do cedente do t�tulo}
         ATipoInscricao := Copy(Retorno.Strings[NumeroRegistro],18,1); // C�digo do tipo de Inscri��o
         ANumeroCPFCGC := Copy(Retorno.Strings[NumeroRegistro],19,14); // Numero Inscri��o da Empresa
//         ACodigoCedente := Copy(Retorno.Strings[NumeroRegistro],33,16);
         ACodigoAgencia := Copy(Retorno.Strings[NumeroRegistro],53,5); // C�digo da Ag�ncia da Empresa
         ADigitoCodigoAgencia := Copy(Retorno.Strings[NumeroRegistro],58,1); // Digito da Ag�ncia
         AModalidade  := Copy(Retorno.Strings[NumeroRegistro],63,2); // Modalidade da Conta
         ANumeroConta := Copy(Retorno.Strings[NumeroRegistro],65,6); // Numero da Conta
         ADigitoNumeroConta := Copy(Retorno.Strings[NumeroRegistro],71,1); // Digito da Conta
         ANomeCedente := Trim(Copy(Retorno.Strings[NumeroRegistro],73,30)); // Nome da Empresa

         NumeroRegistro := 1;

         {L� registro HEADER DE LOTE}
         {Verifica se � um lote de retorno de cobran�a}
         if Copy(Retorno.Strings[NumeroRegistro],9,3) <> 'T01' then
            Raise Exception.Create('Este n�o � um lote de retorno de cobran�a');

         DataArquivo := EncodeDate(StrToInt(Copy(Retorno.Strings[NumeroRegistro],196,4)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],194,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],192,2)));
         NumeroArquivo := StrToInt(Trim(Copy(Retorno.Strings[NumeroRegistro],184,8)));

         {L� os registros DETALHE}
         NumeroRegistro := NumeroRegistro + 1;
         {L� at� o antepen�ltimo registro porque o pen�ltimo cont�m apenas o TRAILER DO LOTE e o �ltimo cont�m apenas o TRAILER DO ARQUIVO}
         while (NumeroRegistro < Retorno.Count - 2) do
         begin
            {Registro detalhe com tipo de segmento = T}
            if Copy(Retorno.Strings[NumeroRegistro],14,1) = 'T' then
            begin
               {Dados do titulo}
               with ATitulo do
               begin
                  {Tipo de ocorr�ncia}
                  ATipoOcorrencia := Copy(Retorno.Strings[NumeroRegistro],16,2);
                  case StrToInt(ATipoOcorrencia) of
                     2 : TipoOcorrencia := toRetornoRegistroConfirmado;
                     3 : TipoOcorrencia := toRetornoRegistroRecusado;
                     6 : TipoOcorrencia := toRetornoLiquidado;
                     9 : TipoOcorrencia := toRetornoBaixado;
                     12: TipoOcorrencia := toRetornoRecebimentoInstrucaoConcederAbatimento;
                     13: TipoOcorrencia := toRetornoRecebimentoInstrucaoCancelarAbatimento;
                     14: TipoOcorrencia := toRetornoRecebimentoInstrucaoAlterarVencimento;
                     17: TipoOcorrencia := toRetornoLiquidado;
                     19: TipoOcorrencia := toRetornoRecebimentoInstrucaoProtestar;
                     20: TipoOcorrencia := toRetornoRecebimentoInstrucaoSustarProtesto;
                     23: TipoOcorrencia := toRetornoEncaminhadoACartorio;
                     24: TipoOcorrencia := toRetornoRetiradoDeCartorio;
                     25: TipoOcorrencia := toRetornoProtestado;
                     26: TipoOcorrencia := toRetornoComandoRecusado;
                     27: TipoOcorrencia := toRetornoRecebimentoInstrucaoAlterarDados;
                     28: TipoOcorrencia := toRetornoDebitoTarifas;
                     30: TipoOcorrencia := toRetornoRegistroRecusado;
                     36: TipoOcorrencia := toRetornoRecebimentoInstrucaoConcederDesconto;
                     37: TipoOcorrencia := toRetornoRecebimentoInstrucaoCancelarDesconto;
                     43: TipoOcorrencia := toRetornoProtestoOuSustacaoEstornado;
                     44: TipoOcorrencia := toRetornoBaixaOuLiquidacaoEstornada;
                     45: TipoOcorrencia := toRetornoDadosAlterados;
                  else
                     TipoOcorrencia := toRetornoOutrasOcorrencias;
                  end; {case StrToInt(ATipoOcorrencia)}
                  
                  {Nosso n�mero SEM D�GITO}
                  NossoNumero := Copy(Retorno.Strings[NumeroRegistro],47,10);
                  SeuNumero := Copy(Retorno.Strings[NumeroRegistro],59,11);
                  DataVencimento := EncodeDate(StrToInt(Copy(Retorno.Strings[NumeroRegistro],76,4)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],74,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],72,2)));
                  ValorDocumento := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],80,15))/100;

                  {Dados do cedente do t�tulo}
                  with Cedente do
                  begin
                     if ATipoInscricao = '1' then
                        TipoInscricao := tiPessoaFisica
                     else if ATipoInscricao = '2' then
                        TipoInscricao := tiPessoaJuridica
                     else
                        TipoInscricao := tiOutro;
                     NumeroCPFCGC := ANumeroCPFCGC;
                     CodigoCedente := ACodigoCedente;
                     with ContaBancaria do
                     begin
                        Banco.Codigo := ACodigoBanco;
                        CodigoAgencia := ACodigoAgencia;
                        DigitoAgencia := ADigitoCodigoAgencia;
                        NumeroConta := ANumeroConta;
                        DigitoConta := ADigitoNumeroConta;
                     end;
                     Nome := ANomeCedente;
                  end; {with ACedente}

                  {Dados do sacado do t�tulo}
                  with Sacado do
                  begin
                     if Copy(Retorno.Strings[NumeroRegistro],131,1) = '1' then
                        TipoInscricao := tiPessoaFisica
                     else if Copy(Retorno.Strings[NumeroRegistro],131,1) = '2' then
                        TipoInscricao := tiPessoaJuridica
                     else
                        TipoInscricao := tiOutro;
                     NumeroCPFCGC := Copy(Retorno.Strings[NumeroRegistro],132,15);
                     Nome := Trim(Copy(Retorno.Strings[NumeroRegistro],147,40));
                  end; {with ACedente}

//                  ValorDespesaCobranca := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],199,15))/100;
//                  MotivoRejeicaoComando := Copy(Retorno.Strings[NumeroRegistro],214,10);
               end; {with ATitulo}

               NumeroRegistro := NumeroRegistro + 1;
            end; {if Copy(Retorno.Strings[NumeroRegistro],14,1) = 'T'}

            {Registro detalhe com tipo de segmento = U}
            if Copy(Retorno.Strings[NumeroRegistro],14,1) = 'U' then
            begin
               with ATitulo do
               begin
                  ValorMoraJuros := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],18,15))/100;
                  ValorDesconto := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],33,16))/100;
                  ValorAbatimento := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],49,16))/100;
                  ValorIOF := StrToFloat(Copy(Retorno.Strings[NumeroRegistro],65,15))/100;
                  ValorOutrasDespesas := StrToFloat(Trim(Copy(Retorno.Strings[NumeroRegistro],110,16)))/100;
                  ValorOutrosCreditos := StrToFloat(Trim(Copy(Retorno.Strings[NumeroRegistro],126,15)))/100;
//                  DataRecebimento := EncodeDate(StrToInt(Copy(Retorno.Strings[NumeroRegistro],145,4)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],143,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],141,2)));
                  DataCredito := EncodeDate(StrToInt(Copy(Retorno.Strings[NumeroRegistro],153,4)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],151,2)),StrToInt(Copy(Retorno.Strings[NumeroRegistro],149,2)))
               end; {with ATitulo}

               NumeroRegistro := NumeroRegistro + 1;
            end; {if Copy(Retorno.Strings[NumeroRegistro],14,1) = 'U'}


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

function TgbBanco151.LerRetornoCNAB400(var ACobranca: TgbCobranca; Retorno: TStringList) : boolean;
begin
   Raise Exception.CreateFmt('Processamento de arquivo retorno CNAB400 n�o est� dispon�vel para o banco %s - %s',[CodigoBanco, NomeBanco]);
end;

{$ENDIF}

initialization
RegisterClass(TgbBanco151);

end.
