{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2005 Airton Stodulski                       }
{                                                                              }
{ Colaboradores nesse arquivo:          Daniel Simoes de Almeida               }
{                                                                              }
{  Você pode obter a última versão desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Simões de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Praça Anita Costa, 34 - Tatuí - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 20/06/2005:  Airton Stodulski
|*   Inicio do desenvolvimento  baseada na yanco

* 23-6     function AchaIndiceTipo( chrTipo:char ) : TACBrECFAliquota;

******************************************************************************}

{$I ACBr.inc}

unit ACBrECFDataRegis ;

interface
uses ACBrECFClass, ACBrUtil,
     SysUtils, DateUtils, Classes, Math,
     {$IFDEF VisualCLX} QDialogs, QControls, QForms {$ENDIF}
     {$IFDEF VCL} Dialogs, Controls, Forms {$ENDIF} ;

      //CONFORME MANUAL PARA VERSOES X.03
const STX = #02 ;
      ETX = #03 ;
	   _START = #254 ;
	   _ACKN	 = #004 ;
	   _NAKN	 = #006 ;
	   _ACKC	 = #008 ;
	   _EOM	 = #026 ;
	   _END	 = #013 ;

 //********************************************************
 //        Lista de mensagem de aviso
 //********************************************************  
   MEMORIAFISCALTROCADA                  = 'A';
   SEMNUMEROFABRICACAO                   = 'a';
   BUFFERIMPRESSAOCHEIA                  = 'B';
   ITEMCANCELAMENTONAOENCONTRADO         = 'b';
   COMANDONAOEXECUTADO                   = 'C';
   CANCELAMENTOACIMALIMITE               = 'c';
   DESCONTOACIMATOTAL                    = 'D';
   DATAINVALIDA                          = 'd';
   EPROMFISCALDESCONECTADA               = 'E';
   VERSAOINCORRETA                       = 'e';
   ERROFISCAL                            = 'F';
   SEMCLICHE                             = 'f';
   SEMCNPJIECCM                          = 'G';
   NUMEROCOMPROVANTESINVALIDO            = 'g';
   NUMERORELATORIOGERENCIALINVALIDO      = 'H';
   ESGOTADONUMEROVIASVINCULADO           = 'h';
   COMANDOINVALIDO                       = 'I';
   DADOSCOMANDOINVALIDO                  = 'i';
   VENDASUJEITAICMSSEMIE                 = 'J';
   IMPRESSORAOK                          = 'K';
   MFSEMLOGOTIPO                         = 'M';
   ERROGRAVACAOMF                        = 'm';
   ESTADOINVALIDO                        = 'N';
   NUMEROFINALIZADORAINVALIDO            = 'n';
   FIMPAPEL                              = 'P';
   FALHAIMPRESSORA                       = 'p';
   REDUCAOZOBRIGATORIA                   = 'R';
   VENDASUJEITAISSQNSEMIM                = 'S';
   DESCONTOSUBTOTALICMSISSQNNAOPERMITIDO = 's';
   INDICETRIBUTOINVALIDO                 = 'T';
   ENCONTRADOPALAVRATOTAL                = 't';
   UNIDADEMEDIDAINVALIDA                 = 'U';
   VALORITEMACIMAPERMITIDO               = 'V';
   CANCELAMENTOCUPOMTOTALIZADOEMZERO     = 'v';
   FALTASENHA                            = 'W';
   LEITURAXOBRIGATORIAABERTURACAIXA      = 'X';
   DATAREDUCAOZRETROATIVA                = 'Y';
   AJUSTERETROATIVORELOGIO               = 'y';
   REDUCAOZREALIZADA                     = 'Z';
   ESGOTAMENTOMEMORIAFISCAL              = 'z'; 

type

{ Classe filha de TACBrECFClass com implementaçao para DataRegis }
TACBrECFDataRegis = class( TACBrECFClass )
 private
    fsNumVersao : String ;
    fsNumSerie  : String ;
    fsNumECF    : String ;

    fsSEQ       : Integer ;

    fsDescontoAcrescimo :double;

    Function PreparaCmd( cmd : String ) : String ;
 protected
    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumECF: String; override ;
    function GetNumSerie: String; override ;
    function GetNumVersao: String; override ;
    function GetNumCRO: String; override;
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetGavetaAberta: Boolean; override ;
    function GetPoucoPapel : Boolean; override ;
    function GetChequePronto: Boolean; override ;

    procedure ListaRelatorioGerencial(Relatorio : TStrings; Vias : Integer = 1);
       override ;
    Procedure ListaCupomVinculado( Relatorio : TStrings; Vias : Integer = 1) ;
      override ;

    Function VerificaFimLeitura : Boolean ; override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;
    Function EnviaComando( cmd : String ) : String ; override ;

    Procedure AbreCupom( CPF_CNPJ : String = '') ; override ;
    Procedure VendeItem( Codigo, Descricao : String; AliquotaICMS : String;
       Qtd : Double ; ValorUnitario : Double; DescontoPorc : Double = 0;
       Unidade : String = '') ; override ;
    Procedure SubtotalizaCupom( DescontoAcrescimo : Double = 0 ) ; override ;
    Procedure EfetuaPagamento( CodFormaPagto : String; Valor : Double;
       Observacao : String = ''; ImprimeVinculado : Boolean = false) ;
       override ;
    Procedure FechaCupom( Observacao : String = '') ; override ;
    Procedure CancelaCupom ; override ;
    Procedure CancelaItemVendido( NumItem : Integer ) ; override ;

    function AchaIndiceTipo( chrTipo:char ) : TACBrECFAliquota;
    Procedure LeituraX ; override ;
    Procedure ReducaoZ(DataHora : TDateTime) ; override ;
    Procedure AbreRelatorioGerencial ; override ;
    Procedure LinhaRelatorioGerencial( Linha : String ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : String ) ; override ;
    Procedure FechaRelatorio ; override ;

    Procedure CancelaImpressaoCheque ; override ;

    Procedure MudaHorarioVerao  ; override ;
    Procedure PreparaTEF ; override ;

    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    procedure CarregaFormasPagamento ; override ;
 end ;

implementation
Uses ACBrBase ;

{ ----------------------------- TDJECFDataRegis ------------------------------ }

constructor TACBrECFDataRegis.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.HandShake := hsDTR_DSR ;
  { Variaveis internas dessa classe }
  fsNumVersao := '' ;
  fsNumSerie  := '' ;
  fsNumECF    := '' ;
  fpModeloStr := 'Dataregis' ;
  fsSEQ       := 0 ;
end;

destructor TACBrECFDataRegis.Destroy;
begin
  inherited Destroy ;
end;

procedure TACBrECFDataRegis.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create('Esse modelo de impressora requer'+#10+
                            'Porta Serial:  (COM1, COM2, COM3, ...)');

  fpDevice.HandShake := hsDTR_DSR ;
  inherited Ativar ; { Abre porta serial }

  fsNumVersao := '' ;
  fsNumSerie  := '' ;
  fsNumECF    := '' ;

  try
     { Testando a comunicaçao com a porta }
//     if NumVersao = '' then
 //       raise EACBrECFNaoInicializado.Create(
   //              'Erro inicializando a impressora '+ModeloStr );

  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFDataRegis.EnviaComando( cmd : String ) : String ;
Var ErroMsg : String ;
    ACK : Byte ;
    Erro : String ;
    charAviso:char;
    strRetorno:string;
begin

  Erro    := '' ;
  result  := '' ;
  ErroMsg := '' ;
  ACK     := 0 ;
  fpComandoEnviado   := '' ;
  fpRespostaComando  := '' ;
  AguardandoResposta := true ;
  result := '';
  try
     if (not fpDevice.Ativo) then
        raise EACBrECFNaoInicializado.create(
                 'Componente ACBrECF não está Ativo');

     { Codificando CMD de acordo com o protocolo da DataRegis }
     cmd := PreparaCmd( cmd ) ;

     while  not EmLinha( 1 ) do  { Impressora está em-linha ? }
     begin
        if Retentar and
           (MessageDlg('A impressora '+ModeloStr+' não está pronta.'+#10+#10+
                       'Deseja tentar novamente ?',mtConfirmation,
                       [mbYes,mbNo],0) = mrYes) then
           Continue ;

         raise EACBrECFSemResposta.create(
                 'Impressora '+ModeloStr+' não está em linha') ;
     end ;

     fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }
     fpDevice.Serial.Purge ;                   { Limpa a Porta }

     //ATE RECEBER ACKN = COMANDO OK, MAS SEM RETORNO
     //            ACKC = COMANDO OK, COM RETORNO
     //DEVERA VIR UM BYTE SENDO ACKN, ACKC OU NACK
     while NOT ((ACK = Ord(_ACKN)) OR (ACK = Ord(_ACKC)) OR (ACK = Ord(_NAKN))) do
     begin
        ACK := 0 ;

        try
           fpDevice.Serial.SendString( cmd );   { Eviando o comando }
        except
           if (not Retentar) or (MessageDlg(
              'Camandos não estão sendo enviados para Impressora '+ModeloStr+
              #10+'Deseja tentar novamente ?',
              mtConfirmation,[mbYes,mbNo],0) <> mrYes) then
              raise EACBrECFSemResposta.create(
                    'Erro ao enviar comandos para a Impressora '+ModeloStr)
           else
              continue ;
        end ;

        { espera ACK chegar na Porta por 1,5 seg }
        try
           try
              ACK := fpDevice.Serial.RecvByte( 3000 ) ;
           except
              raise EACBrECFSemResposta.create(
                    'Impressora '+ModeloStr+' não responde') ;
           end ;

//           if  then
//              raise EACBrECFSemResposta.create(
//                    'Impressora '+ModeloStr+' não reconheceu o Comando')
//           else
           if not ((ACK = Ord(_ACKN)) OR (ACK = Ord(_ACKC)) OR (ACK = Ord(_NAKN))) then
              raise EACBrECFSemResposta.create(
                    'Erro. Resposta da Impressora '+ModeloStr+' inválida') ;
        except
           on E : EACBrECFSemResposta do
           begin
              fpDevice.Serial.Purge ;

              if (not Retentar) or
                 (MessageDlg( E.Message +#10+#10+
                     'Deseja tentar novamente ?'+#10+#10+
                     'Se o problema persistir, verifique os cabos, ou'+#10+
                     'experimente desligar a impressora durante 5 seg,'+#10+
                     'liga-la novamente, e repetir a operação...',
                     mtConfirmation,[mbYes,mbNo],0) <> mrYes) then
                 raise ;
           end ;
           else
              raise ;
        end ;
     end ;

     //SEMPRE DEPOIS DO ACKN, ACKC OU NACK VIRA UM #13 (END)
     fpDevice.Serial.RecvByte( 500 ) ;

     if not fpDevice.Serial.CTS then
        fpDevice.Serial.RTS := false ;

     fpComandoEnviado := cmd ;

     Sleep(20);
     { Chama Rotina da Classe mãe TACBrClass para ler Resposta. Se houver
       falha na leitura LeResposta dispara Exceçao }
     If ACK = Ord(_ACKC) then //tem retorno
     begin

       LeResposta ;

       { Separando o Retorno }
       //	START (1 byte) + BLOCO (1 byte) + COMANDO (1 byte) + TAMANHO (1 byte) + [DADOS] (variavel) +
       //  CHKSUM (1 byte) + EOM (1 byte) + END (1 byte)
       Result := copy(fpRespostaComando, 5, Length(fpRespostaComando)-5-2 ) ;

       if copy(fpRespostaComando,3,1) <> copy(cmd,3,1) then //verifica se e o mesmo comando
          Erro := 'EE';
     end
     Else If ACK = Ord(_NAKN) then //enviar comando para saber o que esta acontecendo
     begin
        strRetorno:=EnviaComando('R');
        charAviso:=strRetorno[1];
        case charAviso of
          'F': ErroMsg := '(AGUARDANDO COND. PAGAMENTO)';
          //'L': ErroMsg := ' LIVRE'
          'O': ErroMsg := 'OBRIGATORIO Z';
          'R': ErroMsg := 'LEITURA X - DURANTE EMISSAO DE RELATORIO';
          'V': ErroMsg := 'ESTA EM ITENS DA VENDA';
          'A': ErroMsg := 'OBRIGA X';
          'X': ErroMsg := 'IMPRESSORA OCUPADA';
        end;

        charAviso:=strRetorno[6];
        case charAviso of
          MEMORIAFISCALTROCADA                  : ErroMsg := 'Memoria Fiscal Trocada';
          SEMNUMEROFABRICACAO                   : ErroMsg := 'Sem Número de Fabricação';
          BUFFERIMPRESSAOCHEIA                  : ErroMsg := 'Buffer de impressão Cheia';
          ITEMCANCELAMENTONAOENCONTRADO         : ErroMsg := 'Item de Cancelamento não encontrado';
          COMANDONAOEXECUTADO                   : ErroMsg := 'Comando Não Executado';
          CANCELAMENTOACIMALIMITE               : ErroMsg := 'Cancelamento Acima do Limite';
          DESCONTOACIMATOTAL                    : ErroMsg := 'Desconto Acima do Permitido';
          DATAINVALIDA                          : ErroMsg := 'Data Inválida';
          EPROMFISCALDESCONECTADA               : ErroMsg := 'EPROM Fiscal Desconectada';
          VERSAOINCORRETA                       : ErroMsg := 'Versão Incorreta do Software Básico';
          ERROFISCAL                            : ErroMsg := 'ERRO FISCAL';
          SEMCLICHE                             : ErroMsg := 'Sem Cliche';
          SEMCNPJIECCM                          : ErroMsg := 'Sem CNPJ;IE/CCM';
          NUMEROCOMPROVANTESINVALIDO            : ErroMsg := 'Quantidade ou Número de Comprovante Inválido';
          NUMERORELATORIOGERENCIALINVALIDO      : ErroMsg := 'Quantidade ou´Número de Relatórios Gerenciais Inválido';
          ESGOTADONUMEROVIASVINCULADO           : ErroMsg := 'Esgotado Número de Vias para o Vinculado';
          COMANDOINVALIDO                       : ErroMsg := 'COMANDO INVÁLIDO';
          DADOSCOMANDOINVALIDO                  : ErroMsg := 'DADOS DO COMANDO INVÁLIDO';
          VENDASUJEITAICMSSEMIE                 : ErroMsg := 'Venda Sujeita ao ICMS sem Inscrição Estadual programada';
          //IMPRESSORAOK                          : ErroMsg := 'IMPRESSORA OK';
          MFSEMLOGOTIPO                         : ErroMsg := 'Memória Fiscal sem Logotipo';
          ESTADOINVALIDO                        : ErroMsg := 'ESTADO INVÁLIDO';
          NUMEROFINALIZADORAINVALIDO            : ErroMsg := 'Número de Finalizadora Inválido';
          FIMPAPEL                              : ErroMsg := 'FIM DE PAPEL';
          FALHAIMPRESSORA                       : ErroMsg := 'Falha na Impressora';
          REDUCAOZOBRIGATORIA                   : ErroMsg := 'Redução Z Obrigatória';
          VENDASUJEITAISSQNSEMIM                : ErroMsg := 'Venda Sujeita ao ISSQN sem Inscrição Municipal Programada';
          DESCONTOSUBTOTALICMSISSQNNAOPERMITIDO : ErroMsg := 'Desconto em Subtotal com Venda Sujeita ao ICMS/ISSQN não Permitido';
          INDICETRIBUTOINVALIDO                 : ErroMsg := 'Indice do Tributo Inválido';
          ENCONTRADOPALAVRATOTAL                : ErroMsg := 'Palavra TOTAL e/ou suas variantes encontrada';
          UNIDADEMEDIDAINVALIDA                 : ErroMsg := 'Unidade de Medida Inválida';
          VALORITEMACIMAPERMITIDO               : ErroMsg := 'Valor Total do Item Acima do Permitido';
          CANCELAMENTOCUPOMTOTALIZADOEMZERO     : ErroMsg := 'Cancelamento do Cupom Totalizado em Zero';
          FALTASENHA                            : ErroMsg := 'Falta Senha para Permitir Gravação da Senha do Primeiro Usuário';
          LEITURAXOBRIGATORIAABERTURACAIXA      : ErroMsg := 'Leitura X Obrigatória para abertura do Caixa';
          DATAREDUCAOZRETROATIVA                : ErroMsg := 'Tentativa de Redução Z com Data/Hora anterior a última redução Gravada';
          AJUSTERETROATIVORELOGIO               : ErroMsg := 'Tentativa de Ajusta Relógio com Data/Hora anterior a última redução Gravada';
          REDUCAOZREALIZADA                     : ErroMsg := 'Redução Z Realizada';
          ESGOTAMENTOMEMORIAFISCAL              : ErroMsg := 'Esgotamento da Capacidade de Gravação de dados na MF';
        end;

     end;

     if Erro = 'EE' then
        ErroMsg := 'Retorno da Impressora inválido.';

     {
     else
        ErroMsg := 'Erro Código ('+Erro+')' ;}



     if ErroMsg <> '' then
     begin
        ErroMsg := 'Erro retornado pela Impressora: '+ModeloStr+#10+#10+
                   ErroMsg ;
        raise EACBrECFSemResposta.create(ErroMsg) ;
     end ;
  finally
     AguardandoResposta := false ;
  end ;

end;

function TACBrECFDataRegis.VerificaFimLeitura : Boolean;
begin
  result := false;
  If length(fpRespostaComando) > 3 then
     //valida os dois ultimos caracteres
     result :=
        (copy( fpRespostaComando, length(fpRespostaComando)-1,2)
        = _EOM+_END);


end;

Function TACBrECFDataRegis.PreparaCmd( cmd : String ) : String ;
Var A, iSoma   : Integer ;
    CKS1       : String ;
begin

  result := '' ;
  if cmd = '' then exit ;

  fsSEQ := fsSEQ + 1 ;
  if fsSEQ > 250 then fsSEQ := 1 ;

  //  START (1 byte)	 +	BLOCO	(1 byte) +	COMANDO  (1 byte) +	TAMANHO (1 byte) + [DADOS] (variavel) + CHKSUM (1 byte)
  cmd   := _START + Chr(fsSEQ)+ Copy(cmd,1,1) + Chr(Length(cmd)-1) + Copy(cmd,2,length(cmd)-1) ;

  { Calculando a Soma dos caracteres ASC }
  iSoma := 0 ;
  For A := 3 to Length(cmd) do
     iSoma := iSoma + ord( cmd[A] ) ;

  CKS1 := chr( iSoma mod 256 ) ;

  result := cmd + CKS1;
end ;


function TACBrECFDataRegis.GetDataHora: TDateTime;
Var RetCmd : String ;
    OldShortDateFormat : String ;
begin
  RetCmd := EnviaComando( 'd' );

  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yy' ;
     result := StrToDate( Copy(RetCmd,1,8) ) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
  result := RecodeHour(  result,StrToIntDef(copy(RetCmd,10,2),0)) ;
  result := RecodeMinute(result,StrToIntDef(copy(RetCmd,13,2),0)) ;
end;

function TACBrECFDataRegis.GetNumCupom: String;
begin
  result := Copy(EnviaComando( 'd' ),16,6) ;
end;

function TACBrECFDataRegis.GetNumECF: String;
begin
  if fsNumECF = '' then
  begin
     fsNumECF := Copy(EnviaComando( 'PS' ),7,3) ;
  end ;

  Result := fsNumECF
end;

function TACBrECFDataRegis.GetNumSerie: String;
begin
  if fsNumSerie = '' then
  begin
     fsNumSerie := copy(EnviaComando( 'PS' ), 14, 6) ;
  end ;

  result := fsNumSerie ;
end;

function TACBrECFDataRegis.GetNumVersao: String ;
begin
  if fsNumVersao = '' then
  begin
     fsNumVersao := copy(EnviaComando( 'PS' ), 1, 5) ;
  end ;

  Result := fsNumVersao ;
end;

function TACBrECFDataRegis.GetNumCRO: String;
begin
   result := copy(EnviaComando( 'IS'+FormatDateTime('ddmmaa',date)+FormatDateTime('ddmmaa',date) ), 49, 4) ;
end;

function TACBrECFDataRegis.GetTotalPago: Double;
var retCmd:string;
begin
   retCmd:=EnviaComando( 'C' );
   result:=0;
   If retCmd[1]='T' then
      result := StrToInt(Copy(retCmd,2,14))/100;

end;

function TACBrECFDataRegis.GetSubTotal: Double;
var retCmd:string;
begin
   retCmd:=EnviaComando( 'C' );
   result:=0;
   If retCmd[1]='S' then
      result := StrToInt(Copy(retCmd,2,14))/100;
end;


function TACBrECFDataRegis.GetEstado: TACBrECFEstado;
var RetCmd:String;
begin
   if (not fpAtivo) then
      fpEstado := estNaoInicializada
   else
   begin
      RetCmd := EnviaComando( 'R' ) ;
      if RetCmd<>'' then
      begin
         {
         -F (AGUARDANDO COND. PAGAMENTO)
         -L LIVRE
         -O OBRIGATORIO Z
         -R LEITURA X - DURANTE EMISSAO DE RELATORIO
         -V ESTA EM ITENS DA VENDA
         -A OBRIGA X
         -X IMPRESSORA OCUPADA}
         if RetCmd[1] = 'X' then
            fpEstado := estBloqueada
         else if RetCmd[1] = 'O' then
            fpEstado := estRequerZ
         else if RetCmd[1] = 'A' then
            fpEstado := estRequerX
         else if RetCmd[1] = 'F' then
            fpEstado := estPagamento
         else if RetCmd[1] = 'V' then
            fpEstado := estVenda
         else if RetCmd[1] = 'R' then
            fpEstado := estRelatorio 
         else if RetCmd[1] = 'L' then
            fpEstado := estLivre
         else
            fpEstado := estDesconhecido ;
      end ;
   end ;
   Result := fpEstado ;
end;

function TACBrECFDataRegis.GetGavetaAberta: Boolean;
begin
  result := false ;   // TODO
end;

function TACBrECFDataRegis.GetPoucoPapel: Boolean;
begin
  result := false ;   // TODO
end;

Procedure TACBrECFDataRegis.LeituraX ;
begin
  EnviaComando( 'GNS') ;  { Espaço em branco = Supervisor C 13 }
end;

Procedure TACBrECFDataRegis.AbreGaveta ;
begin
  EnviaComando('N') ;
end;

Procedure TACBrECFDataRegis.ReducaoZ(DataHora: TDateTime) ;
begin
  EnviaComando('HN') ;  { Espaço em branco}
end;

Procedure TACBrECFDataRegis.MudaHorarioVerao ;
begin
end;

procedure TACBrECFDataRegis.AbreCupom(CPF_CNPJ: String);
begin
 {Nao envia comando porque ao regigistrar item abre cupom}

 {Devido a impressora nao ter comando especifico para sub-totaliza e desconto, sendo enviado com o
  comando que registra a finalizadora, a variavel abaixo controla o valor de desconto ou acrescimo
  conforme funcao subtotaliza e finalizadora. E inicializa neste momento com valor zero.}
 fsDescontoAcrescimo := 0;
end;

procedure TACBrECFDataRegis.CancelaCupom;
begin
   EnviaComando('F');
end;

procedure TACBrECFDataRegis.CancelaItemVendido(NumItem: Integer);
begin
end;

procedure TACBrECFDataRegis.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
var curValorDescAcre:currency;
    strTipo:string;
begin
   inherited EfetuaPagamento(CodFormaPagto, Valor, Observacao, ImprimeVinculado);
   If fsDescontoAcrescimo<>0 then
   begin
      If fsDescontoAcrescimo>0 then
         strTipo:='A'
      Else
         strTipo:='D';

      curValorDescAcre:=ABS(fsDescontoAcrescimo);
      EnviaComando('c'+CodFormaPagto+stringofChar(#32,18)+
                       FormatCurr('00000000000000',Valor*100)+
                       FormatCurr('00000000000000',curValorDescAcre*100)+
                       strTipo);
   end
   Else
   begin
      EnviaComando('D'+CodFormaPagto+stringofChar(#32,18)+
                       FormatCurr('00000000000000',Valor*100));
   end;
   fsDescontoAcrescimo:=0;  {so imprime o desconto ou acrescimo na primeira vez, pois foi armazenado por SubTotaliza}

end;

procedure TACBrECFDataRegis.FechaCupom(Observacao: String);
begin
end;

procedure TACBrECFDataRegis.SubtotalizaCupom(DescontoAcrescimo: Double);
begin
   {nao tem subtotalizador e desconto ou acrescimento tem que jogar na forma de pagamento}
   fsDescontoAcrescimo := DescontoAcrescimo;
end;

function TACBrECFDataRegis.AchaIndiceTipo( chrTipo:char ) : TACBrECFAliquota;
var A : Integer ;
begin
  if not Assigned( fpAliquotas ) then
     CarregaAliquotas ;

  result := nil ;
  with fpAliquotas do
  begin
     For A := 0 to Count -1 do
        if Objects[A].tipo = chrTipo then
         begin
           result := Objects[A] ;
           Break ;
         end ;
  end ;
end;

procedure TACBrECFDataRegis.VendeItem(Codigo, Descricao: String;
  AliquotaICMS : String; Qtd: Double; ValorUnitario: Double;
  DescontoPorc: Double; Unidade: String);
Var AliquotaStr, QtdStr, ValorStr, TotalStr, Descr2 : String ;
    ValAliquota, ValTotal : Double ;
    Aliquota : TACBrECFAliquota ;
begin
  { Obs.: Sweda nao usa parametro Unidade }
  if Qtd > 9999 then
     raise EACBrECFCMDInvalido.Create(
           'Quantidade deve ser inferior a 9999.');

  if Qtd <= 0 then
     raise EACBrECFCMDInvalido.Create(
           'Quantidade deve ser superior a 0.');

  if AliquotaICMS = '' then
     raise EACBrECFCMDInvalido.Create(
           'Aliquota de ICMS não pode ser vazia.');

  case AliquotaICMS[1] of
    'I' : begin
            Aliquota := AchaIndiceTipo('I') ;
            if Aliquota <> nil then
               AliquotaStr := Aliquota.Indice
            else
               raise EACBrECFCMDInvalido.Create('Aliquota nao encontrada: '+AliquotaICMS);
          end;
    'N' : begin
            Aliquota := AchaIndiceTipo('N') ;
            if Aliquota <> nil then
               AliquotaStr := Aliquota.Indice
            else
               raise EACBrECFCMDInvalido.Create('Aliquota nao encontrada: '+AliquotaICMS);
          end;
    'F' : begin
            Aliquota := AchaIndiceTipo('F') ;
            if Aliquota <> nil then
               AliquotaStr := Aliquota.Indice
            else
               raise EACBrECFCMDInvalido.Create('Aliquota nao encontrada: '+AliquotaICMS);
          end;
    'T' : AliquotaStr := padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice}
    'S' : AliquotaStr := padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice}
  else
   begin
     try
        ValAliquota := StrToFloat( AliquotaICMS ) ;
     except
        raise EACBrECFCMDInvalido.Create('Aliquota inválida: '+AliquotaICMS);
     end ;

     Aliquota := AchaICMSAliquota( ValAliquota ) ;
     if Aliquota <> nil then
        AliquotaStr := Aliquota.Indice
     else
        raise EACBrECFCMDInvalido.Create(
              'Aliquota nao encontrada: '+AliquotaICMS);
   end
  end;

  if ArredondaPorQtd and (not Arredonda) then
     ArredondarPorQtd( Qtd, ValorUnitario );

  Codigo      := padL(Codigo,13) ;    { Ajustando Tamanhos }
  Unidade     := padL(Unidade,2) ;

  Descr2      := '' ;                 { Usa descriçao Grande ? }
  if DescricaoGrande Then
     Descr2 := copy(Descricao,24,40) ;
  if Length(Trim(Descr2)) = 0 then
     Descr2 := ''
  else
     Descr2 := padL(Descr2,40) ;

  Descricao   := padL(Descricao,23) ; {23 e nao 24 porque adiciona o campo Sinal}
  QtdStr      := IntToStrZero( Round( Qtd*1000 ) ,6) ;
  ValorStr    := IntToStrZero( Round( ValorUnitario*100 ) ,9) ;

//  if fsModeloSweda >= 'F' then   { serie 9000 somente Trunca o total }
//   begin
//     ValTotal := Trunc( Qtd*ValorUnitario*100 ) / 100 ;
//     TotalStr := IntToStrZero( Trunc( ValTotal*100 ) ,12) ;
//   end
//  else
//   begin
     ValTotal := RoundTo( Qtd*ValorUnitario, -2 ) ;
     TotalStr := IntToStrZero( Round( ValTotal*100 ) ,12) ;
//   end ;

  EnviaComando( 'A' + Codigo + Descricao + Descr2 + AliquotaStr + QtdStr + ValorStr + IntToStrZero( Round( DescontoPorc*100) ,4));

//   fsFechando := false ;

end;

procedure TACBrECFDataRegis.CarregaAliquotas;
var Aliquota : TACBrECFAliquota ;
    retCmd,strAliquota: String;
    intTotal:integer;
    intX:integer;
begin
   inherited CarregaAliquotas ;   { Cria fpAliquotas }

   retCmd := EnviaComando('Q');

   intTotal:=0;
   try
      intTotal:=StrToInt(copy(retCmd,1,2));
   except
   end;

   for intX:=1 to intTotal do
   begin
      strAliquota := copy(retCmd,((intX-1) * 5) + 3,5) ;
      Aliquota := TACBrECFAliquota.create ;

      Aliquota.Indice   := FormatCurr('00',intX);
      Aliquota.Aliquota := StrToInt(copy(strAliquota,2,4))/100 ;
      Aliquota.Tipo     := strAliquota[1];

      fpAliquotas.Add( Aliquota ) ;
   end;
end;

procedure TACBrECFDataRegis.CarregaFormasPagamento;
var FPagto : TACBrECFFormaPagamento ;
    retCmd,strForma: String;
    intX:integer;

begin
   inherited CarregaFormasPagamento ;   { Cria fpFormasPagamentos }

   retCmd := EnviaComando('f');

   intX:=1;
   strForma := copy(retCmd,((intX-1) * 37) + 1,37) ;
   while length(strForma)>5 do
   begin
      FPagto := TACBrECFFormaPagamento.create ;

      FPagto.Indice    := FormatCurr('00',intX-1);
      FPagto.Descricao := Copy(strForma,3,14);
      fpFormasPagamentos.Add( FPagto ) ;

      intX := intX+1;
      strForma := copy(retCmd,((intX-1) * 37) + 1,37) ;
   end;



end;

procedure TACBrECFDataRegis.CancelaImpressaoCheque;
begin
end;

function TACBrECFDataRegis.GetChequePronto: Boolean;
begin
  result := false ;    // TODO
end;

procedure TACBrECFDataRegis.AbreRelatorioGerencial;
begin
   //o comando j, envia linha e abre se necessario
end;

procedure TACBrECFDataRegis.LinhaRelatorioGerencial(Linha: String);
begin
   EnviaComando('j'+padL( Linha,40));
end;

procedure TACBrECFDataRegis.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
Var FPG : TACBrECFFormaPagamento ;
    FPGDesc : String ;
begin
  FPG := AchaFPGIndice( CodFormaPagto ) ;

  if FPG = nil then
     raise Exception.create( 'Forma de Pagamento: '+CodFormaPagto+
                             ' não foi cadastrada.' ) ;

  COO       := Poem_Zeros( trim(COO) ,6) ;
  FPGDesc   := padL( FPG.Descricao, 16 ) ;
  FPGDesc   := UpperCase(copy(FPGDesc,1,1))+LowerCase(copy(FPGDesc,2,16)) ;

//   EnviaComando( #66 + FPGDesc, 5) ;
end;

procedure TACBrECFDataRegis.LinhaCupomVinculado(Linha: String);
begin
end;

procedure TACBrECFDataRegis.FechaRelatorio;
begin
   EnviaComando('K');
end;


procedure TACBrECFDataRegis.ListaRelatorioGerencial(Relatorio: TStrings;
  Vias: Integer);
Var Imp, Linha : Integer ;
    Texto : String ;
begin
  Imp := 0 ;

  while Imp < Vias do
  begin
     try
        Texto := Format(MsgRelatorio,['Relatório Gerêncial',Imp+1 ]) ;
     except
        Texto := MsgRelatorio ;
     end ;

     PintaFormMsg( Texto );

     Linha := 0 ;
     while Linha <= ( Relatorio.Count - 1) do
     begin
        LinhaRelatorioGerencial( Relatorio[ Linha ] ) ;
        {aguardar impressora estar em linha para continuar ou time-out}
        Linha := Linha + 1 ;

       Application.ProcessMessages ;
     end ;

     Imp := Imp + 1 ;

     if Imp < Vias then
     begin
        LinhaRelatorioGerencial( StringofChar(#10, LinhasEntreCupons ) ) ;
        PausarRelatorio( Imp ) ;
     end ;
  end ;

  PintaFormMsg( 'Fechando Relatório Gerencial' );
  FechaRelatorio ;

end;

procedure TACBrECFDataRegis.ListaCupomVinculado(Relatorio: TStrings;
  Vias: Integer);
Var Imp, Linha : Integer ;
    Texto : String ;
begin
  Imp := 0 ;

  while Imp < Vias do
  begin
     try
        Texto := Format(MsgRelatorio,['Cupom Vinculado',Imp+1 ]) ;
     except
        Texto := MsgRelatorio ;
     end ;

     PintaFormMsg( Texto );

     Linha := 0 ;
     while Linha <= ( Relatorio.Count - 1) do
     begin
        LinhaCupomVinculado( Relatorio[ Linha ] ) ;
        Linha := Linha + 1 ;

       Application.ProcessMessages ;
     end ;

     Imp := Imp + 1 ;

     if Imp < Vias then
     begin
        LinhaCupomVinculado( StringofChar(#10, LinhasEntreCupons ) ) ;
        PausarRelatorio( Imp ) ;
     end ;
  end ;

  PintaFormMsg( 'Fechando Cupom Vinculado' );
  FechaRelatorio ;

end;

procedure TACBrECFDataRegis.PreparaTEF;
begin
  FechaRelatorio ;
end;


end.


