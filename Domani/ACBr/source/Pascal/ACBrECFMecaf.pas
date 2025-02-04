{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}
{******************************************************************************
|*             O B S E R V A C O E S   S O B R E   A   M E C A F
|* - A Mecaf produz ECF's OEM para varios outros fabricantes, como por exemplo:
|*   Elgin, Digiarte, Zanthus, Acr, Aoki, Chronos, Promcomp, TrendsSTS, Unigraph.
|*   ( Geralmente existe o Logotipo da MECAF no corpo do equipamento )
|*   Entretanto n�o h� garantia de plena compatibilidade entre os diferentes
|*   equipamentos, se eles usarem protocolos diferentes. (Favor reportar BUGS)
|* - O Procotolo utilizado para esse Modulo � o padr�o de f�brica da MECAF
|*   STX/ETX. Se o protocolo estiver diferente n�o funcionar�, � possivel mudar
|*   o protocolo usando o "MODO MENU" da impressora.
******************************************************************************}
{******************************************************************************
|* Historico
|*
|* 13/09/2004:  Daniel Simoes de Almeida
|*   Primeira Versao: Cria�ao e Distribui�ao da Primeira Versao
|* 23/05/2005:  Daniel Simoes de Almeida
|*   Corrigido BUG em FechaCupom. Linhas de Observa��o eram impressas com
|*   alinhamento errado.
|*   Corrigido BUG em Estado. No incio do dia Estado sempre constava como
|*   estBloqueda
|*   -  Bugs reportados por Licerio Jose Rodrigues Neto
|* 16/06/2005:  Daniel Simoes de Almeida e Licerio Jose Rodrigues Neto
|*   - Adaptado para suporte da Versao FCP201 da MECAF (antiga)
******************************************************************************}
{$I ACBr.inc}

unit ACBrECFMecaf ;

interface
uses ACBrECFClass, ACBrUtil, 
     Classes,
     {$IFDEF VisualCLX} QDialogs, QControls, QForms {$ENDIF}
     {$IFDEF VCL} Dialogs, Controls, Forms {$ENDIF} ;

const  STX = #02  ;
       ETX = #03  ;
       ESC = #27  ;
       CR  = #13  ;
       LF  = #10  ;

type
{ Classe filha de TACBrECFClass com implementa�ao para Mecaf }
TACBrECFMecaf = class( TACBrECFClass )
 private
    fsNumVersao : String ;
    fsNumSerie  : String ;
    fsNumCRO    : String ;
    fsNumECF    : String ;
    fsArredonda : Char ;
    fsVinculado : Boolean ;

    function AjustaStr( AString : String ) : String ; 

 protected
    function GetDataHora: TDateTime; override ;
    function GetNumCupom: String; override ;
    function GetNumECF: String; override ;
    function GetNumCRO: String; override ;
    function GetNumSerie: String; override ;
    function GetNumVersao: String; override ;
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetGavetaAberta: Boolean; override ;
    function GetPoucoPapel : Boolean; override ;
    function GetHorarioVerao: Boolean; override ;
    function GetArredonda: Boolean; override ;
    function GetChequePronto: Boolean; override ;

    Function VerificaFimLeitura : Boolean ; override ;

    procedure ListaRelatorioGerencial(Relatorio : TStrings; Vias : Integer = 1);
       override ;
    Procedure ListaCupomVinculado( Relatorio : TStrings; Vias : Integer = 1) ;
      override ;

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

    Procedure LeituraX ; override ;
    Procedure ReducaoZ(DataHora : TDateTime) ; override ;
    Procedure AbreRelatorioGerencial ; override ;
    Procedure LinhaRelatorioGerencial( Linha : String ) ; override ;
    Procedure AbreCupomVinculado(COO, CodFormaPagto, CodComprovanteNaoFiscal :
       String; Valor : Double) ; override ;
    Procedure LinhaCupomVinculado( Linha : String ) ; override ;
    Procedure FechaRelatorio ; override ;

    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    Procedure CancelaImpressaoCheque ; override ;
    
    Procedure MudaHorarioVerao  ; override ;
    Procedure MudaArredondamento( Arredondar : Boolean ) ; override ;
    Procedure PreparaTEF ; override ; { Carrega as Formas, de Pagamento e CNF}
    Procedure LeituraMemoriaFiscal( DataInicial, DataFinal : TDateTime ) ;
       override ;
    Procedure LeituraMemoriaFiscal( ReducaoInicial, ReducaoFinal : Integer);
       override ;
    Procedure LeituraMemoriaFiscalSerial( DataInicial, DataFinal : TDateTime;
       var Linhas : TStringList ) ; override ; 
    Procedure LeituraMemoriaFiscalSerial( ReducaoInicial, ReducaoFinal : Integer;
       var Linhas : TStringList ) ; override ;

    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;
    
    procedure CarregaFormasPagamento ; override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '') ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;
 end ;

implementation
Uses ACBrBase,
     SysUtils, DateUtils, StrUtils  , Math;

{ ----------------------------- TACBrECFMecaf ------------------------------ }

constructor TACBrECFMecaf.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.HandShake := hsRTS_CTS ;
  { Variaveis internas dessa classe }
  fsVinculado := false ;
  fsNumVersao := '' ;
  fsNumSerie  := '' ;
  fsNumECF    := '' ;
  fsNumCRO    := '' ;
  fsArredonda := ' ';

  fpModeloStr := 'Mecaf' ;
end;

destructor TACBrECFMecaf.Destroy;
begin

  inherited Destroy ;
end;

procedure TACBrECFMecaf.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create('A impressora: '+ModeloStr+' requer'+#10+
                            'Porta Serial:  (COM1, COM2, COM3, ...)');

  fpDevice.HandShake := hsRTS_CTS ;
  inherited Ativar ; { Abre porta serial }

  fsNumVersao := '' ;
  fsNumSerie  := '' ;
  fsNumECF    := '' ;
  fsNumCRO    := '' ;
  fsArredonda := ' ';

  try
     { Testando a comunica�ao com a porta }
     if NumVersao = '' then
        raise EACBrECFNaoInicializado.Create(
                 'Erro inicializando a impressora '+ModeloStr );
  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFMecaf.EnviaComando( cmd : String ) : String ;
Var ErroMsg : String ;
    Erro : Integer ;
begin

  result  := '' ;
  ErroMsg := '' ;
  fpComandoEnviado   := '' ;
  fpRespostaComando  := '' ;
  AguardandoResposta := true ;

  try
     if (not fpDevice.Ativo) then
        raise EACBrECFNaoInicializado.create(
                 'Componente ACBrECF n�o est� Ativo');

     { Codificando CMD de acordo com o protocolo da Mecaf }
     cmd := STX + ESC + '$' + cmd + ETX ;

     while  not EmLinha( 1 ) do  { Impressora est� em-linha ? }
     begin
        if Retentar and
           (MessageDlg('A impressora '+ModeloStr+' n�o est� pronta.'+#10+#10+
                       'Deseja tentar novamente ?',mtConfirmation,
                       [mbYes,mbNo],0) = mrYes) then
           Continue ;

        raise EACBrECFSemResposta.create(
                 'Impressora '+ModeloStr+' n�o est� em linha') ;
     end ;

     fpDevice.Serial.DeadlockTimeout := 2000 ; { Timeout p/ Envio }

     while fpComandoEnviado = '' do
     begin
        fpDevice.Serial.Purge ;                   { Limpa a Porta }

        try
           fpDevice.Serial.SendString( cmd );   { Eviando o comando }
           fpComandoEnviado := cmd ;
        except
           if (not Retentar) or (MessageDlg(
              'Camandos n�o est�o sendo enviados para Impressora '+ModeloStr+
              #10+'Deseja tentar novamente ?',
              mtConfirmation,[mbYes,mbNo],0) <> mrYes) then
              raise EACBrECFSemResposta.create(
                    'Erro ao enviar comandos para a Impressora '+ModeloStr)
           else
              continue ;
        end ;
     end ;

     sleep(20) ;

     { Chama Rotina da Classe m�e TACBrClass para ler Resposta. Se houver
       falha na leitura LeResposta dispara Exce�ao }
     LeResposta ;
     { Retirando STX e ETX }
     Result := copy(fpRespostaComando, 2, Length(fpRespostaComando)-2 ) ;

     { Verificando por erros }
     ErroMsg := '' ;
     Erro    := StrToIntDef( copy(Result,6,2), 0 ) ;
     if LeftStr(Result,1) = '-' then
        case Erro of
           1 : ErroMsg := 'Cabe�alho cont�m caracteres inv�lidos' ;
           4 : ErroMsg := 'Caracteres inv�lidos no Comando' ;
           9 : ErroMsg := 'A palavra TOTAL n�o � aceita' ;
          16 : ErroMsg := 'Data Inv�lida' ;
          17 : ErroMsg := 'Hora Inv�lida' ;
          18 : ErroMsg := 'Aliquota n�o programada ou fora do Intervalo' ;
          20 : ErroMsg := 'Comando s� aceito em Interven��o Fiscal' ;
          21 : ErroMsg := 'Comando s� aceito em Modo Normal' ;
          22 : ErroMsg := 'Necess�rio abrir cupom' ;
          23 : ErroMsg := 'Comando n�o aceito durante Cupom Fiscal' ;
          26 : ErroMsg := 'O rel�gio j� est� em hor�rio de ver�o' ;
          27 : ErroMsg := 'O rel�gio n�o est� em hor�rio de ver�o' ;
          28 : ErroMsg := 'Necess�rio realizar Redu��o Z' ;
          29 : ErroMsg := 'Fechamento di�rio (Redu��o Z) j� realizada' ;
          31 : ErroMsg := 'Item inexistente ou j� cancelado' ;
          32 : ErroMsg := 'Cupom anterior n�o pode ser cancelado' ;
          33 : ErroMsg := 'Detectado falta de papel' ;
          37 : ErroMsg := 'Necess�rio realizar interven��o fiscal' ;
          38 : ErroMsg := 'Mem�ria fiscal n�o permite mais realizar vendas. '+
                          'S� � poss�vel efetuar Leitura X ou da Mem.Fiscal.' ;
          39 : ErroMsg := 'OCORREU ALGUM PROBLEMA NA MEMORIA FISCAL. '+
                          'Ser� necess�rio realizar uma Interven��o T�cnica '+
                          'S� � poss�vel efetuar Leitura X ou da Mem.Fiscal.' ;
          40 : ErroMsg := 'Necess�rio programar a Data do Rel�gio' ;
          41 : ErroMsg := 'N�mero m�ximo de itens por cupom ultrapassado' ;
          44 : ErroMsg := 'Impressora em Estado de impress�o de cheque' ;
          46 : ErroMsg := 'Necess�rio inserir o cheque' ;
          47 : ErroMsg := 'Necess�rio inserir nova bobina' ;
          48 : ErroMsg := 'Necess�rio executar uma Leitura X' ;
          49 : ErroMsg := 'Detectado algum problema na Impressora. '+
                          'Papel encravado, sobretens�o, etc...' ;
          50 : ErroMsg := 'Cupom j� foi totalizado' ;
          53 : ErroMsg := 'Ocorreu erro de grava��o na mem�ria fiscal' ;
          58 : ErroMsg := 'Falta completar valor do pagamento' ;
          61 : ErroMsg := 'Troco n�o realizado' ;
          63 : ErroMsg := 'Impressora n�o est� respondendo' ;
        else
           ErroMsg := 'Erro retornado pelo ECF: '+IntToStr(Erro) ;
        end
     else
        { Verifica se possui erro "Pouco Papel" }
        if (LeftStr(Result,1) = '+') and (Erro = 1) then
           DoOnMsgPoucoPapel ;

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

function TACBrECFMecaf.VerificaFimLeitura : Boolean;
begin
//  result := (LeftStr( fpRespostaComando ,1 ) = STX) and
//            (RightStr( fpRespostaComando,1 ) = ETX) ;
  { Modificado pois leitura da Memoria Fiscal pela serial na inicia com STX }
  result := (RightStr( fpRespostaComando,1 ) = ETX) ;
end;

function TACBrECFMecaf.GetDataHora: TDateTime;
Var RetCmd : String ;
    OldShortDateFormat : String ;
begin
  RetCmd := EnviaComando( '33' ) ;
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yy' ;
     result := StrToDate( copy(RetCmd,6,8) ) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
  result := RecodeHour(  result,StrToInt(copy(RetCmd,15,2))) ;
  result := RecodeMinute(result,StrToInt(copy(RetCmd,18,2))) ;
  result := RecodeSecond(result,StrToInt(copy(RetCmd,21,2))) ;
end;

function TACBrECFMecaf.GetNumCupom: String;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( '34M41' ) ;

  if LeftStr(RetCmd, 1) <> '+' then
     Result := '      '
  else
     Result := IntToStrZero( StrToIntDef( copy(RetCmd,6,6), 0), 6) ;
end;

function TACBrECFMecaf.GetNumCRO: String;
Var RetCmd : String ;
begin
  if Trim(fsNumCRO) = '' then
  begin
     RetCmd := EnviaComando( '34M43' ) ;
     if LeftStr(RetCmd,1) = '+' then
        fsNumCRO := IntToStrZero( StrToIntDef(copy(RetCmd,6,4),0),4) ;
  end ;

  Result := fsNumCRO ;
end;

function TACBrECFMecaf.GetNumECF: String;
Var RetCmd : String ;
begin
  if Trim(fsNumECF) = '' then
  begin
     RetCmd := EnviaComando( '34M48' ) ;
     if LeftStr(RetCmd,1) = '+' then
        fsNumECF := IntToStrZero( StrToIntDef(copy(RetCmd,6,6),0),4) ;
  end ;

  Result := fsNumECF ;
end;

function TACBrECFMecaf.GetNumSerie: String;
Var RetCmd : String ;
begin
  if Trim(fsNumSerie) = '' then
  begin
     RetCmd := EnviaComando( '34M49' ) ;
     if LeftStr(RetCmd,1) = '+' then
        fsNumSerie := Copy(RetCmd,6,10) ;
  end ;

  Result := fsNumSerie ;
end;

function TACBrECFMecaf.GetNumVersao: String ;
Var RetCmd : String ;
begin
  if fsNumVersao = '' then
  begin
     RetCmd := EnviaComando( '34M47' ) ;
     if LeftStr(RetCmd,1) = '+' then
        fsNumVersao := Copy(RetCmd,6,7) ;
  end ;

  Result := fsNumVersao ;
end;

function TACBrECFMecaf.GetTotalPago: Double;
Var RetCmd : String ;
    Valor : Double ;
begin

  RetCmd := EnviaComando( '34M97' ) ;
  Result := 0 ;

  if LeftStr(RetCmd,1) = '+' then
  begin
     Valor := RoundTo( StrToIntDef(copy(RetCmd,6,15),0) / 100, -2 ) ;

     if RightStr(RetCmd,1) = '-' then
        Result := Subtotal - Valor 
     else
        Result := Subtotal + Valor ;

     Result := RoundTo(Result,-2) ;
  end ;
end;

function TACBrECFMecaf.GetSubTotal: Double;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( '34M96' ) ;
  Result :=  0 ;
  if LeftStr(RetCmd, 1) = '+' then
     Result := RoundTo( StrToInt( copy(RetCmd,6,15) ) / 100, -2) ;
end;


function TACBrECFMecaf.GetEstado: TACBrECFEstado;
Var RetCmd : String ;
    Stat1,Stat4,Stat5 : Byte ;
    DataRedZ : String ;
begin
  if (not fpAtivo) then
     fpEstado := estNaoInicializada
  else
   begin
     RetCmd := EnviaComando( '32' ) ;

     Stat1  := StrToInt( '$'+copy(RetCmd, 6,2) ) ;
     Stat4  := StrToInt( '$'+copy(RetCmd,12,2) ) ;
     Stat5  := StrToInt( '$'+copy(RetCmd,14,2) ) ;
     DataRedZ := '' ;

     if TestBit( Stat1 ,2) then
      begin
        RetCmd := EnviaComando( '34M83' ) ;
        { Usei o StringReplace pois n�o tenho certeza se a resposta vem com ou
          sem as / (estou sem o ECF para testes). Segundo o manual n�o deveriam
          vir as /  }
        DataRedZ := StringReplace(copy(RetCmd,6,8),'/','',[rfReplaceAll]) ;
      end
     else

     if TestBit( Stat1 ,5) then
        fpEstado := estRequerZ
     else if TestBit( Stat4 ,7) then
        fpEstado := estRequerX
     else if  TestBit( Stat1 ,2) and
             (DataRedZ = FormatDateTime('ddmmyy',now)) then
        fpEstado := estBloqueada 
     else if TestBit( Stat1,0) and
            (TestBit( Stat5,1) or TestBit( Stat5,4) or TestBit( Stat5,5)) then
        fpEstado := estPagamento
     else if TestBit( Stat1, 0) then
        fpEstado := estVenda
     else
      begin
        RetCmd := EnviaComando( '34M84' ) ;
        Stat1  := StrToIntDef( '$'+copy(RetCmd, 6,2) ,0 ) ;

        if TestBit( Stat1, 0) or TestBit( Stat1, 1) or TestBit( Stat1, 2) then
           fpEstado := estRelatorio
        else
           fpEstado := estLivre ;
      end ;
   end ;

  Result := fpEstado ;
end;

function TACBrECFMecaf.GetGavetaAberta: Boolean;
Var RetCmd : String ;
    Stat3 : Byte ;
begin
  RetCmd := EnviaComando( '32' ) ;
  Stat3  := StrToInt( '$'+copy(RetCmd,10,2) ) ;
  Result := TestBit( Stat3, 1) ;
end;

function TACBrECFMecaf.GetPoucoPapel: Boolean;
Var RetCmd : String ;
    Stat3  : Byte ;
begin
  RetCmd := EnviaComando( '32' ) ;
  Stat3  := StrToInt( '$'+copy(RetCmd,10,2) ) ;
  Result := TestBit( Stat3, 6) ;
end;

function TACBrECFMecaf.GetHorarioVerao: Boolean;
Var RetCmd : String ;
    Stat1  : Byte ;
begin
  RetCmd := EnviaComando( '32' ) ;
  Stat1  := StrToInt( '$'+copy(RetCmd,6,2) ) ;
  Result := TestBit( Stat1, 6) ;
end;

function TACBrECFMecaf.GetArredonda: Boolean;
Var RetCmd : String ;
    Stat1  : Byte ;
begin
  if fsArredonda = ' ' then
  begin
     RetCmd := EnviaComando( '34M84' ) ;
     Stat1  := StrToIntDef( '$'+copy(RetCmd, 6,2) ,0 ) ;

     if TestBit( Stat1, 6) then
        fsArredonda := 'S'
     else
        fsArredonda := 'N' ;
  end ;

  Result := (fsArredonda = 'S') ;
end;

Procedure TACBrECFMecaf.LeituraX ;
begin
  EnviaComando('150' , 40 ) ;
end;

Procedure TACBrECFMecaf.ReducaoZ(DataHora: TDateTime) ;
begin
  EnviaComando( '160', 40 )
end;

Procedure TACBrECFMecaf.AbreGaveta ;
begin
  EnviaComando( '240' + #20 + #80 ) ;
  sleep(100) ;
end;

Procedure TACBrECFMecaf.MudaHorarioVerao ;
Var Resp : TModalResult ;
begin

  Resp := MessageDlg('Hor�rio de Ver�o ?',mtConfirmation,mbYesNoCancel,0) ;
  if Resp = mrCancel then exit ;

  EnviaComando( '27' + IfThen(Resp = mrYes,'+','-'), 3 ) ;
end;

procedure TACBrECFMecaf.MudaArredondamento(Arredondar: Boolean);
begin
  EnviaComando( '50' + IfThen(Arredondar,'1','0') ) ;
end;

procedure TACBrECFMecaf.AbreCupom(CPF_CNPJ: String);
begin
  fpUltimaMsgPoucoPapel := 0 ;  { Zera tempo pra msg de pouco papel }

  if pos('201', fsNumVersao) > 0 then
     CPF_CNPJ := '' ;

  CPF_CNPJ := trim(CPF_CNPJ) ;
  if CPF_CNPJ <> '' then
     CPF_CNPJ := padL(CPF_CNPJ,28) ;
  EnviaComando('10'+CPF_CNPJ, 8) ;
end;

procedure TACBrECFMecaf.CancelaCupom;
begin
  EnviaComando( '14' ,18) ;
  FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (s� por garantia)}
end;

procedure TACBrECFMecaf.CancelaItemVendido(NumItem: Integer);
begin
  EnviaComando( '12' + IntToStrZero(NumItem,3) ,1) ;
end;

procedure TACBrECFMecaf.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
Var Linhas, CodTroco : String ;
    FPG : TACBrECFFormaPagamento ;
begin
  inherited EfetuaPagamento(CodFormaPagto, Valor, Observacao, ImprimeVinculado);

  if ImprimeVinculado then
     if fsVinculado then
        raise Exception.Create('J� existe Forma de Pagamento com '+#10+
                               'comprovante NAO fiscal vinculado pendente. '+#10+
                               'Impressora: '+ModeloStr+' aceita apenas um '+#10+
                               'Comprovante n�o Fiscal Viculado por Cupom.') 
     else
        fsVinculado := true ;
        
  Linhas := '' ;

  if Length(Observacao) > 41 then
   begin
     Linhas     := '4' ;
     Observacao := padL(Observacao,80) ;
   end
  else if Length(Observacao) > 1 then
   begin
     Linhas     := '2' ;
     Observacao := padL(Observacao,40) ;
   end ;

  EnviaComando( '07' + CodFormaPagto + IntToStrZero( Round(Valor*100) ,15) +
                Linhas + Observacao ,2) ;

  { Mecaf nao lan�a troco sozinha. Verificando se precisa lan�ar Troco }
  if TotalPago > SubTotal then
  begin
     CodTroco := '00' ;
     FPG      := AchaFPGDescricao('Dinheiro') ;

     if FPG = nil then
        MessageDlg('Forma de pagamento DINHEIRO n�o encontrada. '+#10+
                   'Usando Forma de Pagamento "00" para lan�ar o Troco.',
                   mtWarning,[mbOk],0)
     else
        CodTroco := FPG.Indice ;

     EnviaComando( '07' + CodTroco + StringOfChar('0' ,15) ,2) ;
  end ;
end;

procedure TACBrECFMecaf.FechaCupom(Observacao: String);
Var A,P,N : Integer ;
    Obs : String ;
begin
  { Ajustando a Observa�ao em N Linhas do mesmo tamanho de COLUNAS}
  A   := 1  ;
  Obs := '' ;
  
  while (A <= 8) and (Length(Observacao) > 0) do
  begin
     P := pos(#10,Observacao) ;
     N := 1 ;
     if P = 0 then
     begin
        P := min(Length( Observacao ), Colunas) ;
        N := 0 ;
     end ;

     Obs := Obs + padL( copy(Observacao,1,P-N) , Colunas) + #10 ;

     A := A + 1 ;
     Observacao := copy(Observacao, P+1, Length(Observacao) ) ;
  end ;

  { Fecha cupom }
  EnviaComando( '08S' + IntToStrZero(Length(Obs),3) + Obs, 7 + A) ;

  fsVinculado := false
end;

procedure TACBrECFMecaf.SubtotalizaCupom(DescontoAcrescimo: Double);
Var A_D : String ;
begin
  if DescontoAcrescimo > 0 then
     A_D := '@'
  else
     A_D := '' ;

  DescontoAcrescimo := abs(DescontoAcrescimo) ;

  { Inicia fechamento com formas de Pagamento }
  EnviaComando( '06' + A_D + '&' +
                IntToStrZero( Round(DescontoAcrescimo*100), 15) ,2) ;
  fsVinculado := false ;
end;

procedure TACBrECFMecaf.VendeItem(Codigo, Descricao: String;
  AliquotaICMS : String; Qtd: Double; ValorUnitario: Double;
  DescontoPorc: Double; Unidade: String);
Var AliquotaStr, QtdStr, ValorStr, DescontoStr, Fmt: String ;
    ValAliquota : Double ;
    Aliquota : TACBrECFAliquota ;
    FlagDesc : Integer ; 
begin
  if Qtd > 9999 then
     raise EACBrECFCMDInvalido.Create(
           'Quantidade deve ser inferior a 9999.');

  if AliquotaICMS = '' then
     raise EACBrECFCMDInvalido.Create(
           'Aliquota de ICMS n�o pode ser vazia.');

  case AliquotaICMS[1] of
    'I' : AliquotaStr := 'I00' ;
    'N' : AliquotaStr := 'N00' ;
    'F' : AliquotaStr := 'F00' ;
    'T' : AliquotaStr := 'T'+padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice}
  else
   begin
     try
        ValAliquota := StrToFloat( AliquotaICMS ) ;
     except
        raise EACBrECFCMDInvalido.Create('Aliquota inv�lida: '+AliquotaICMS);
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

  if pos('201', fsNumVersao) > 0 then
   begin
     QtdStr   := IntToStrZero( Round( Qtd*1000 ) ,6) ;
     Fmt      := '-' ;
     ValorStr := IntToStrZero( Round( ValorUnitario*100 ) ,11) ;
   end
  else
   begin
     QtdStr := IntToStrZero( Round( Qtd*1000 ) ,7) ;

     if RoundTo(ValorUnitario,-2) <> ValorUnitario then {Tem mais de 2 casas dec ?}
      begin
        Fmt := 'H' ;
        ValorStr := IntToStrZero( Round( ValorUnitario*1000 ) ,11) ;
      end
     else
      begin
        Fmt   := 'G' ;
        ValorStr := IntToStrZero( Round( ValorUnitario*100 ) ,11) ;
      end;
   end ;

  DescontoStr := '%' + IntToStrZero( Round(DescontoPorc * 100), 4) ;
  Descricao := LeftStr( Trim(Descricao), 190) { maximo 5 linhas de 38 } ;
  if (Length(Descricao) <= 38) or (not DescricaoGrande) then
   begin
     FlagDesc  := 1 ;
     Descricao := padL(Descricao,38) ;
   end
  else
   begin
     FlagDesc  := Trunc( Length(Descricao) / 38 ) +
                  ifThen( Length(Descricao) mod 38 > 0,1,0) ;
     Descricao := PadL(Descricao, (38 * FlagDesc) ) ;
   end ;

  EnviaComando( '11' + Fmt + QtdStr + ValorStr + AliquotaStr +
                DescontoStr + Unidade + Codigo + IntToStr( FlagDesc ) +
                Descricao ,2) ;
end;

procedure TACBrECFMecaf.CarregaAliquotas;
Var RetCmd : String ;
    Aliquota : TACBrECFAliquota ;
    ValAliq : Double ;
    A : Integer ;
    ByteISS1,ByteISS2 : Byte ;
begin
  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  RetCmd   := EnviaComando( '34M86' ) ;
  ByteISS2 := StrToIntDef( '$'+copy(RetCmd, 8,2) ,0 ) ;
  ByteISS1 := StrToIntDef( '$'+copy(RetCmd,10,2) ,0 ) ;

  RetCmd := EnviaComando( '30' ) ;

  For A := 0 to 15 do
  begin
     ValAliq := RoundTo( StrToIntDef( copy(RetCmd, 6+(A*4), 4),0 ) / 100, -2) ;

     if ValAliq > 0 then
     begin
        Aliquota := TACBrECFAliquota.create ;

        Aliquota.Indice   := 'T'+IntToStrZero(A,2) ;
        Aliquota.Aliquota := ValAliq ;

        if A < 8 then
         begin
           if TestBit( ByteISS1, A ) then
              Aliquota.Tipo := 'S' ;
         end
        else
           if TestBit( ByteISS2, A-8) then
              Aliquota.Tipo := 'S' ;

        fpAliquotas.Add( Aliquota ) ;
     end ;
  end ;
end;

procedure TACBrECFMecaf.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
Var ProxIndice : Integer ;
    sTipo, ValStr : String ;
    Aliq : TACBrECFAliquota ;
begin
  ValStr := IntToStrZero( Round(Aliquota * 100) ,4) ;
  Tipo := UpCase(Tipo) ;
  if Tipo = 'S' then
     sTipo := '001'
  else
     sTipo := '000' ;

  CarregaAliquotas ;
  
  ProxIndice := StrToIntDef(Posicao,0) ;
  if (ProxIndice < 1) or (ProxIndice > 15) then { Indice passado � v�lido ? }
  begin
     For ProxIndice := 1 to 16 do  { Procurando Lacuna }
     begin
        if AchaICMSIndice('T'+IntToStrZero(ProxIndice,2)) = nil then
           break ;
     end ;
  end ;

  if ProxIndice > 15 then
     raise Exception.create('N�o h� espa�o para programar novas Aliquotas');

  EnviaComando( '46' + IntToStrZero(ProxIndice,2) + ValStr + sTipo ) ;

  { Adcionanodo nova Aliquota no ObjectList }
  Aliq := TACBrECFAliquota.create ;
  Aliq.Indice   := 'T'+IntToStrZero(ProxIndice,2) ;
  Aliq.Aliquota := Aliquota ;
  if Tipo = '1' then
     Aliq.Tipo := 'S' ;
  fpAliquotas.Add( Aliq ) ;
end;


procedure TACBrECFMecaf.CarregaFormasPagamento;  { fun�ao Lenta +- 3 sec. }
Var RetCmd, Descricao : String ;
    Cont : Integer ;
    FPagto : TACBrECFFormaPagamento ;
begin
  inherited CarregaFormasPagamento ;       {Inicializa fpFormasPagamentos}

  for Cont := 0 to 15 do
  begin
     RetCmd    := EnviaComando( '34M' + IntToStrZero(50 + Cont,2) ) ;

     Descricao := UpperCase(Trim(copy(RetCmd,6,16))) ;
     if Descricao <> '' then
     begin
        FPagto := TACBrECFFormaPagamento.create ;

        FPagto.Indice    := IntToStrZero(Cont,2) ;
        FPagto.Descricao := Descricao ;

        fpFormasPagamentos.Add( FPagto ) ;
     end ;
   end ;
end;

procedure TACBrECFMecaf.ProgramaFormaPagamento(var Descricao: String;
  PermiteVinculado: Boolean; Posicao : String );
Var ProxIndice : Integer ;
    FPagto : TACBrECFFormaPagamento ;
begin
  { Obs: Mecaf nao usa PermiteVinculado }
  Descricao := padL(Descricao,16) ;

  CarregaFormasPagamento ;
  
  ProxIndice := StrToIntDef(Posicao,0) ;
  if (ProxIndice < 1) or (ProxIndice > 15) then { Indice passado � v�lido ? }
  begin
     For ProxIndice := 0 to 16 do  { Procurando Lacuna }
     begin
        if AchaFPGIndice(IntToStrZero(ProxIndice,2)) = nil then
           break ;
     end ;
  end ;

  if ProxIndice > 15 then
     raise Exception.create('N�o h� espa�o para programar novas Formas de '+
                            'Pagamento');

  EnviaComando( '29' + IntToStrZero(ProxIndice,2) + Descricao ) ;

  { Adcionanodo nova FPG no ObjectList }
  FPagto := TACBrECFFormaPagamento.create ;
  FPagto.Indice    := IntToStrZero(ProxIndice,2) ;
  FPagto.Descricao := Descricao ;
  fpFormasPagamentos.Add( FPagto ) ;
end;

procedure TACBrECFMecaf.CarregaComprovantesNaoFiscais;
Var RetCmd, Descricao : String ;
    Cont : Integer ;
    CNF : TACBrECFComprovanteNaoFiscal ;
begin
  inherited CarregaComprovantesNaoFiscais ;{Inicializa fpComprovantesNaoFiscais}

  for Cont := 16 to 31 do
  begin
     RetCmd    := EnviaComando( '34M' + IntToStrZero(50 + Cont,2) ) ;

     Descricao := UpperCase(Trim(copy(RetCmd,6,16))) ;
     if Descricao <> '' then
     begin
        CNF := TACBrECFComprovanteNaoFiscal.create ;

        CNF.Indice    := IntToStrZero(Cont,2) ;
        CNF.Descricao := Descricao ;

        fpComprovantesNaoFiscais.Add( CNF ) ;
     end ;
   end ;
end;

procedure TACBrECFMecaf.ProgramaComprovanteNaoFiscal(var Descricao: String;
  Tipo: String; Posicao : String );
Var ProxIndice : Integer ;
    CNF : TACBrECFComprovanteNaoFiscal ;
begin
  { Obs: Mecaf nao usa Tipo }
  Descricao := padL(Descricao,16) ;

  CarregaComprovantesNaoFiscais ;

  ProxIndice := StrToIntDef(Posicao,0) ;
  if (ProxIndice < 16) or (ProxIndice > 31) then { Indice passado � v�lido ? }
  begin
     For ProxIndice := 16 to 32 do  { Procurando Lacuna }
     begin
        if AchaCNFIndice(IntToStrZero(ProxIndice,2)) = nil then
           break ;
     end ;
  end ;

  if ProxIndice > 31 then
     raise Exception.create('N�o h� espa�o para programar novos Comprovantes'+
                            ' n�o Fiscais');

  EnviaComando( '29' + IntToStrZero(ProxIndice,2) + Descricao ) ;

  { Adcionanodo novo CNF no ObjectList }
  CNF := TACBrECFComprovanteNaoFiscal.create ;
  CNF.Indice    := IntToStrZero(ProxIndice,2) ;
  CNF.Descricao := Descricao ;
  fpComprovantesNaoFiscais.Add( CNF ) ;
end;


procedure TACBrECFMecaf.AbreRelatorioGerencial;
begin
  EnviaComando( '151' ,40 ) ;
end;

procedure TACBrECFMecaf.LinhaRelatorioGerencial(Linha: String);
begin
  EnviaComando( '260' + padL(Linha,Colunas) ) ;
end;

procedure TACBrECFMecaf.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
begin
  { Mecaf nao faz Vinculo a uma Forma de Pagamento espec�fica do Cupom Anterior
    tamb�m n�o � necess�rio informar nenhum CNF, ou Valor do Cupom Anterior.
    A unica exigencia que a impressora faz � que o Documento Anterior seja
    Cupom Fiscal ou Comprovante nao vinculado
    Fica f�cil criar o Vinculado, mas n�o h� a possibilidade de criar Varios
    Cupons Vinculados a mais de uma forma de pagamento do Cupom Anterior. Ou
    Seja o vinculo � feito ao CUPOM Anterior e n�o a alguma das Formas de
    Pagamento. }

  EnviaComando( '20' ,8 ) ;
end;

procedure TACBrECFMecaf.LinhaCupomVinculado(Linha: String);
begin
  LinhaRelatorioGerencial( Linha ) ; 
end;

procedure TACBrECFMecaf.FechaRelatorio;
Var RetCmd : String ;
    Stat   : Byte ;
begin
  RetCmd := EnviaComando( '34M84' ) ;
  Stat   := StrToInt( '$'+copy(RetCmd, 6,2) ) ;

  if TestBit( Stat, 0) or TestBit( Stat, 1) or TestBit( Stat, 2) then
     EnviaComando( '21' ,12 ) ;
end;

procedure TACBrECFMecaf.ListaRelatorioGerencial(Relatorio: TStrings;
  Vias: Integer);
Var Imp, Linha : Integer ;
    Texto : String ;
begin
  Imp := 0 ;

  while Imp < Vias do
  begin
     try
        Texto := Format(MsgRelatorio,['Relat�rio Ger�ncial',Imp+1 ]) ;
     except
        Texto := MsgRelatorio ;
     end ;

     PintaFormMsg( Texto );

     Linha := 0 ;
     while Linha <= ( Relatorio.Count - 1) do
     begin
        LinhaRelatorioGerencial( LeftStr( Relatorio[ Linha ], fpColunas) ) ;
        Linha := Linha + 1 ;

        if not BloqueiaMouseTeclado then
           Application.ProcessMessages ;
     end ;

     Imp := Imp + 1 ;

     if Imp < Vias then
     begin
        For Linha := 1 to LinhasEntreCupons do
           LinhaRelatorioGerencial( ' ' ) ;
           
        PausarRelatorio( Imp ) ;
     end ;
  end ;

  PintaFormMsg( 'Fechando Relat�rio Gerencial' );
  FechaRelatorio ;

end;

procedure TACBrECFMecaf.ListaCupomVinculado(Relatorio: TStrings;
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
        LinhaCupomVinculado( LeftStr( Relatorio[ Linha ], fpColunas) ) ;
        Linha := Linha + 1 ;

        if not BloqueiaMouseTeclado then
           Application.ProcessMessages ;
     end ;

     Imp := Imp + 1 ;

     if Imp < Vias then
     begin
        For Linha := 1 to LinhasEntreCupons do
           LinhaRelatorioGerencial( ' ' ) ;
           
        PausarRelatorio( Imp ) ;
     end ;
  end ;

  PintaFormMsg( 'Fechando Cupom Vinculado' );
  FechaRelatorio ;

end;

procedure TACBrECFMecaf.PreparaTEF;
begin
  inherited PreparaTEF ;

  CarregaFormasPagamento ;
end;

procedure TACBrECFMecaf.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal: Integer);
Var Espera : Integer ;
begin
  Espera := 60 + (ReducaoFinal - ReducaoInicial) ;
  EnviaComando( '18'+IntToStrZero(ReducaoInicial,4)+
                     IntToStrZero(ReducaoFinal  ,4), Espera ) ;
end;

procedure TACBrECFMecaf.LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime);
Var Espera : Integer ;
begin
  Espera := 60 + DaysBetween(DataInicial,DataFinal) ;
  EnviaComando( '17'+FormatDateTime('ddmmyy',DataInicial)+
                     FormatDateTime('ddmmyy',DataFinal),   Espera ) ;
end;

procedure TACBrECFMecaf.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas : TStringList);
Var Espera : Integer ;
    RetCmd : String ;
begin
  Espera := Trunc(60 + (ReducaoFinal - ReducaoInicial) ) ;
  Linhas.Clear ;
  RetCmd := EnviaComando( '37'+IntToStrZero(ReducaoInicial,4)+
                              IntToStrZero(ReducaoFinal  ,4), Espera ) ;
  RetCmd := AjustaStr( RetCmd ) ;  { Troca #0 dentro da String por espa�os }
  Linhas.Clear ;
  Linhas.Text := RetCmd ;
end;

procedure TACBrECFMecaf.LeituraMemoriaFiscalSerial(DataInicial,
  DataFinal: TDateTime; var Linhas : TStringList);
Var Espera : Integer ;
    RetCmd : String ;
begin
  Espera := Trunc(60 + DaysBetween(DataInicial,DataFinal) ) ;
  RetCmd := EnviaComando( '36'+FormatDateTime('ddmmyy',DataInicial)+
                               FormatDateTime('ddmmyy',DataFinal), Espera );
  RetCmd := AjustaStr( RetCmd ) ;  { Troca #0 dentro da String por espa�os }
  Linhas.Clear ;
  Linhas.Text := RetCmd ;
end;

function TACBrECFMecaf.GetChequePronto: Boolean;
Var RetCmd : String ;
    Stat4 : Byte ;
begin
  RetCmd := EnviaComando( '32' ) ;
  Stat4  := StrToInt( '$'+copy(RetCmd,12,2) ) ;
  Result := TestBit( Stat4, 2) ;
end;

procedure TACBrECFMecaf.CancelaImpressaoCheque;
begin
  EnviaComando( '04' ) ;
end;

procedure TACBrECFMecaf.ImprimeCheque(Banco: String; Valor: Double;
  Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
Var Dia,Mes,Ano, Lin : String ;
begin
  Favorecido := padL(Favorecido,80) ;
  Cidade     := padL(Cidade,20) ;
  Observacao := LeftStr(Observacao,160) ;
  Dia        := IntToStrZero(  DayOf(Data),2) ;
  Mes        := IntToStrZero(MonthOf(Data),2) ;
  Ano        := RightStr(IntToStrZero( YearOf(Data),4),2) ;

  Lin := #36 + #75 + #72 + #10 + #36 + #10 + #36 + #36 + #40 + #36 + #36 + #75 ;

  EnviaComando( '011' ) ;
  EnviaComando( '02' + Lin + IntToStrZero(Round(Valor*100),15) +
                Favorecido + Cidade + '1' + Dia + Mes + Ano + Observacao ,10) ;
end;

function TACBrECFMecaf.AjustaStr(AString: String): String;
Var A,Len : Integer ;
begin
  Result := '' ;
  Len    := Length( AString ) ;

  For A := 1 to Len do
  begin
     if AString[A] = #0 then
        Result := Result + ' '
     else
        Result := Result + AString[A] ;
  end ;
end;

end.


