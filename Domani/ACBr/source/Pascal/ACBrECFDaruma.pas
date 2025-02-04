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
|* Historico
|*
|* 06/09/2004:  Daniel Simoes de Almeida
|*   Primeira Versao: Cria�ao e Distribui�ao da Primeira Versao
|* 19/03/2004:  Daniel Simoes de Almeida
|*   Corrigido BUG em FechaRelatorio quando um CV estava aberto.
|*   -  Bug reportado por Aurimenes Apolonio Silva
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFDaruma ;

interface
uses ACBrECFClass, ACBrUtil, 
     Classes,
     {$IFDEF VisualCLX} QDialogs, QControls, QForms {$ENDIF}
     {$IFDEF VCL} Dialogs, Controls, Forms {$ENDIF} ;

const  ESC = #27  ;
       FS  = #28  ;
       GS  = #29  ;
       CR  = #13  ;
       LF  = #10  ;
       FF  = #255 ;

type
{ Classe filha de TACBrECFClass com implementa�ao para Daruma }
TACBrECFDaruma = class( TACBrECFClass )
 private
    fsNumVersao   : String ;
    fsNumSerie    : String ;
    fsNumECF      : String ;
    fsArredonda   : Char ;
    fsNumCRO      : String ;
    fsTotalAPagar : Double ;
    fsEmPagamento : Boolean ;
    fsMFD         : Boolean ;

    Function PreparaCmd( cmd : String ) : String ;
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
    function GetArredonda : Boolean; override ;

    Function VerificaFimLeitura : Boolean ; override ;

    procedure ListaRelatorioGerencial(Relatorio : TStrings; Vias : Integer = 1);
       override ;
    Procedure ListaCupomVinculado( Relatorio : TStrings; Vias : Integer = 1) ;
      override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    procedure Ativar ; override ;

    Property IsMFD : Boolean read fsMFD ;
    
    Function EnviaComando( cmd : String ) : String ; override ;
    Function EnviaComandoEspera( cmd : String; lTimeout : Integer ) : String ;

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

    Procedure MudaHorarioVerao  ; override ;
    Procedure MudaArredondamento( Arredondar : Boolean ) ; override ;
    Procedure PreparaTEF ; override ; { Carrega as Formas, de Pagamento e CNF}
    Procedure ImpactoAgulhas ; override ;
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
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;
 end ;

implementation
Uses ACBrBase,
     SysUtils, DateUtils, StrUtils  , Math;

{ ----------------------------- TACBrECFDaruma ------------------------------ }

constructor TACBrECFDaruma.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.HandShake := hsRTS_CTS ;
  { Variaveis internas dessa classe }
  fsTotalAPagar := 0 ;
  fsEmPagamento := false ;
  fsNumVersao   := '' ;
  fsNumSerie    := '' ;
  fsNumECF      := '' ;
  fsNumCRO      := '' ;
  fsArredonda   := ' ';
  fsMFD         := false ;

  fpModeloStr := 'Daruma' ;
end;

destructor TACBrECFDaruma.Destroy;
begin

  inherited Destroy ;
end;

procedure TACBrECFDaruma.Ativar;
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
  fsMFD       := false ;

  try
     { Testando a comunica�ao com a porta e se � MFD }
     if NumVersao = '' then
        raise EACBrECFNaoInicializado.Create(
                 'Erro inicializando a impressora '+ModeloStr );
  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFDaruma.EnviaComando( cmd : String ) : String ;
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

     { Codificando CMD de acordo com o protocolo da Daruma }
     cmd := PreparaCmd( cmd ) ;

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
     Result := fpRespostaComando ;

     { Verificando por erros }
     ErroMsg := '' ;
     if copy(Result,1,2) = ':E' then
     begin
        Erro := StrToIntDef(copy(Result,3,2),0) ;

        case Erro of
           0 : ErroMsg := 'ECF em modo de Interven��o T�cnica' ;
           1 : ErroMsg := 'Comando dispon�vel somente em modo de Interven��o T�cnica' ;
           2 : ErroMsg := 'Erro gravando mem�ria fiscal' ;
           3 : ErroMsg := 'Mem�ria fiscal esgotada' ;
           4 : ErroMsg := 'Erro no rel�gio interno' ;
           5 : ErroMsg := 'Falha mec�nica' ;
           6 : ErroMsg := 'Erro lendo mem�ria fiscal' ;
          10 : ErroMsg := 'Documento sendo emitido' ;
          11 : ErroMsg := 'Documento n�o foi aberto' ;
          12 : ErroMsg := 'N�o existe documento a cancelar' ;
          13 : ErroMsg := 'Erro nos par�metros: N�o num�rico' ;
          14 : ErroMsg := 'N�o h� mem�ria dispon�vel para esta opera��o' ;
          15 : ErroMsg := 'Item a cancelar n�o encontrado' ;
          16 : ErroMsg := 'Erro de sintaxe no comando' ;
          17 : ErroMsg := 'Numeric overflow' ;
          18 : ErroMsg := 'Totalizador Tribut�rio selecionado n�o possui '+
                          'aliquota definida' ;
          19 : ErroMsg := 'Mem�ria fiscal vazia' ;
          21 : ErroMsg := 'Detectado proximidade do final da bobina de papel' ;
          22 : ErroMsg := 'Redu��o Z j� foi emitida. ECF Bloqueado ate 00:00' ;
          23 : ErroMsg := 'Redu��o Z do dia anterior ainda pendente '+
                          'Efetue uma Redu��o Z.' ;
          24 : ErroMsg := 'Valor de desconto ou acrescimo inv�lido' ;
          25 : ErroMsg := 'Caracter inv�lido nos Par�metros' ;
          30 : ErroMsg := 'Comprovante N�O Fiscal inv�lido ou n�o programado' ;
          38 : ErroMsg := 'Forma de pagamento selecionada n�o � v�lida' ;
          39 : ErroMsg := 'Erro na sequ�ncia de fechamento do cupom fiscal' ;
          42 : ErroMsg := 'Leitura X inicial ainda n�o foi emitida' ;
          50 : ErroMsg := 'Sem Papel' ;
          61 : ErroMsg := 'Queda de energia durante a emiss�o do Cupom Fiscal' ;
          84 : ErroMsg := 'Impressora n�o est� respondendo' ;
        else
           ErroMsg := 'Erro retornado pelo ECF: '+IntToStrZero(Erro,2) ;
        end ;

        if Erro = 21 then       { Verifica se possui erro "Pouco Papel" }
        begin
           DoOnMsgPoucoPapel ;
           ErroMsg := '' ;   { Apaga Msg de Erro para nao gerar Exce��o }
        end ;

        if ErroMsg <> '' then
        begin
           ErroMsg := 'Erro retornado pela Impressora: '+ModeloStr+#10+#10+
                      ErroMsg ;
           raise EACBrECFSemResposta.create(ErroMsg) ;
        end ;
     end ;

  finally
     AguardandoResposta := false ;
  end ;

end;

Function TACBrECFDaruma.PreparaCmd( cmd : String ) : String ;
Var I, chksum, LenCmd : Integer ;
begin
  result := '' ;
  if cmd = '' then exit ;

  if IsMFD or (cmd[1] = FS) then
   begin
     if cmd[1] = ESC then  { Traduzindo comando enviado no protocolo antigo }
        cmd := FS + 'F' + copy(cmd,2,Length( cmd ) ) ;

     chksum := 0 ;
     LenCmd := Length( cmd ) ;

     For I := 1 to LenCmd do   { Aplicando XOR nos Bytes do comando }
        chksum := chksum xor ord( cmd[ I ] ) ;

     Result := cmd + chr( chksum ) ;
   end
  else
     Result := cmd + #13 ; { Adcionando Sufixo padrao }
end ;


function TACBrECFDaruma.EnviaComandoEspera(cmd: String;
  lTimeout: Integer): String;
Var SecRestante     : Integer ;
    TempoInicio     : TDateTime ;
    wTempoInicioMsg : Integer ;
    wRetentar       : Boolean ;
    wRespostaComando: String ;
begin
  TempoInicio := now  ;

  Result := EnviaComando( cmd , lTimeout) ;

  SecRestante := lTimeout - SecondsBetween(now, TempoInicio) ;
  if SecRestante < Timeout then
     SecRestante := TimeOut ;

  { Tenta ler a DATA, pois a DARUMA nao conseguir� responder enquanto estiver
    imprimindo. Isso ir� "prender" a Rotina em EnviaComando, corretamente }
  wTempoInicioMsg := TempoInicioMsg ;
  wRetentar       := Retentar ;
  wRespostaComando:= fpRespostaComando ;
  try
     try
        TempoInicioMsg := 0 ;          { Para nao parar de exibir a msg }
        Retentar       := false ;
        
        EnviaComando( ESC + #230, SecRestante) ;  {Data}
     finally
        Retentar         := wRetentar ;
        TempoInicioMsg   := wTempoInicioMsg ;
        fpRespostaComando:= wRespostaComando ;
     end ;
  except
     on E : EACBrECFSemResposta do
     else
        raise ;
  end ;
end;


function TACBrECFDaruma.VerificaFimLeitura : Boolean;
begin
  result := (LeftStr( fpRespostaComando ,1 ) = ':') and
            (RightStr( fpRespostaComando,1 ) = #13)      ;

  { Nota sobre o VerificaFimLeitura: A DARUMA responde muito antes da
    Impressao terminar, o que pode causar problemas com comandos enviados logo
    ap�s impressoes demoradas como a LituraX por exemplo. Por isso usei ESC+#230
    nesses casos ap�s a Impressao demorada, para prender a Impressora at� o Fim
    da Impressao (Veja Procedure EnviaComandoEspera) }
end;

function TACBrECFDaruma.GetDataHora: TDateTime;
Var RetCmd : String ;
    OldShortDateFormat : String ;
begin
  RetCmd := EnviaComando( ESC + #230 ) ;
  OldShortDateFormat := ShortDateFormat ;
  try
     ShortDateFormat := 'dd/mm/yy' ;
     result := StrToDate(copy(RetCmd,3,2)+'/'+copy(RetCmd,5,2)+'/'+copy(RetCmd,7,2)) ;
  finally
     ShortDateFormat := OldShortDateFormat ;
  end ;
  result := RecodeHour(  result,StrToInt(copy(RetCmd, 9,2))) ;
  result := RecodeMinute(result,StrToInt(copy(RetCmd,11,2))) ;
  result := RecodeSecond(result,StrToInt(copy(RetCmd,13,2))) ;
end;

function TACBrECFDaruma.GetNumCupom: String;
Var RetCmd : String ;
    Num : Integer ;
begin

  RetCmd := EnviaComando( ESC + #239 ) ;

  if LeftStr(RetCmd, 3) <> ':' + ESC + #239 then
     Result := '      '
  else
   begin
     Num := StrToIntDef(copy(RetCmd,9,6),0) ;

     if copy(RetCmd,8,1) = '2' then  { Nao ha cupom aberto, retorna o proximo }
        Num := Num - 1 ;

     Result := IntToStrZero(Num,6) ;
   end ;
end;

function TACBrECFDaruma.GetNumECF: String;
Var RetCmd : String ;
begin
  if Trim(fsNumECF) = '' then
  begin
     RetCmd := EnviaComando( ESC + #239 ) ;

     if LeftStr(RetCmd, 3) <> ':' + ESC + #239 then
        fsNumECF := '    '
     else
        fsNumECF := copy(RetCmd,4,4) ;
  end ;

  Result := fsNumECF ;
end;

function TACBrECFDaruma.GetNumCRO: String;
Var RetCmd : String ;
begin
  if Trim(fsNumCRO) = '' then
  begin
     RetCmd := EnviaComando( ESC + #244 ) ;

     if LeftStr(RetCmd, 3) <> ':' + ESC + #244 then
        fsNumCRO := '    '
     else
        fsNumCRO := copy(RetCmd,38,4) ;
  end ;

  Result := fsNumCRO ;
end;

function TACBrECFDaruma.GetNumSerie: String;
Var RetCmd : String ;
    Tam : Integer ;
begin
  if Trim(fsNumSerie) = '' then
  begin
     RetCmd := EnviaComando(ESC + #236) ;
     Tam := IfThen(StrToIntDef(NumVersao,0) < 345, 6, 8) ;

     if LeftStr(RetCmd, 2) <> ':V' then
        fsNumSerie := StringOfChar(' ',Tam)
     else
        fsNumSerie := copy(RetCmd,3,Tam) ;
  end ;

  Result := fsNumSerie ;
end;

function TACBrECFDaruma.GetNumVersao: String ;
Var RetCmd    : String ;
    wRetentar : Boolean ;
begin
  if fsNumVersao = '' then
  begin
     try
        wRetentar := Retentar ;
        try
           Retentar := false ;
           RetCmd   := copy(EnviaComando(FS + 'F' + #195, 1), 1, 6) ;
           fsMFD    := true ;
        finally
           Retentar := wRetentar ;
        end ;
     except
        fsMFD  := false ;
        RetCmd := copy(EnviaComando(ESC + #195), 1, 6) ;
     end ;

     if RetCmd = ':10043' then
        fsNumVersao := '345'
     else if RetCmd = ':10033' then
        fsNumVersao := '315'
     else
        fsNumVersao := copy(RetCmd,2,length(RetCmd)-2) ;
  end ;

  Result := fsNumVersao ;
end;

function TACBrECFDaruma.GetTotalPago: Double;
begin
  Result := Subtotal - fsTotalAPagar ;
end;

function TACBrECFDaruma.GetSubTotal: Double;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando(ESC + #239) ;

  if LeftStr(RetCmd, 3) <> ':' + ESC + #239 then
     RetCmd := '0'
  else
     if StrToIntDef(NumVersao,0) >= 345 then
        RetCmd := copy(RetCmd,29,14)
     else
        RetCmd := copy(RetCmd,31,21) ;

  Result := RoundTo( StrToIntDef(RetCmd,0) / 100,-2) ;
end;


function TACBrECFDaruma.GetEstado: TACBrECFEstado;
Var RetCmd1,RetCmd2 : String ;
begin
  if (not fpAtivo) then
     fpEstado := estNaoInicializada
  else
   begin

     RetCmd1 := EnviaComando( GS + FF ) ;

     if TestBit(StrToInt('$'+RetCmd1[7]),1) then
        fpEstado := estBloqueada
     else if TestBit(StrToInt('$'+RetCmd1[3]),1) then
        fpEstado := estRequerZ
     else if not TestBit(StrToInt('$'+RetCmd1[7]),2) then
        fpEstado := estRequerX
     else if fsEmPagamento then
        fpEstado := estPagamento
     else
      begin
        RetCmd2 := EnviaComando( ESC + #239 ) ;

        if pos(copy(RetCmd2,8,1),'03') > 0 then
           fpEstado := estRelatorio

        else if TestBit(StrToInt('$'+RetCmd1[5]),2) or
                (copy(RetCmd2,8,1) = '1') then
           fpEstado := estVenda
        else
           fpEstado := estLivre ;
      end;
   end ;

  Result := fpEstado ;
end;

function TACBrECFDaruma.GetGavetaAberta: Boolean;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( GS + FF ) ;
  Result := TestBit(StrToInt('$'+RetCmd[2]),3) ;
end;

function TACBrECFDaruma.GetPoucoPapel: Boolean;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( GS + FF ) ;
  Result := TestBit(StrToInt('$'+RetCmd[3]),0) or
            TestBit(StrToInt('$'+RetCmd[2]),0)  ;
end;

function TACBrECFDaruma.GetHorarioVerao: Boolean;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( ESC + #229 ) ;
  Result := (copy(RetCmd,6,1) = '1') ;
end;

function TACBrECFDaruma.GetArredonda: Boolean;
Var RetCmd : String ;
begin
  if fsArredonda = ' ' then
  begin
     RetCmd := EnviaComando( ESC + #229 ) ;
     if (copy(RetCmd,5,1) = '1') then
        fsArredonda := 'S'
     else
        fsArredonda := 'N' ;
  end ;

  Result := (fsArredonda = 'S') ;
end;

Procedure TACBrECFDaruma.LeituraX ;
begin
  EnviaComandoEspera(ESC + #207, 30 ) ;
end;

Procedure TACBrECFDaruma.AbreGaveta ;
Var wRetentar : Boolean ;
begin
  wRetentar := Retentar ;
  Retentar  := false ;
  try
     try
        EnviaComando( ESC + 'p000') ;
     except
     { exce�ao silenciosa pois AbreGaveta nao tem resposta, Sempre gera erro }
     end ;
  finally
     Retentar := wRetentar ;
  end ;
  
  try
  { pede a Data somente para esperar a impressora entrar em linha. A DARUMA
   imprime uma linha na bobina (demora + ou - 4 seg), ap�s a abertura da gaveta}
     EnviaComando( ESC + #230, 5) ;
  except
  end ;
end;

Procedure TACBrECFDaruma.ReducaoZ(DataHora: TDateTime) ;
begin
  EnviaComandoEspera( ESC + #208 + FormatDateTime('ddmmyyhhnnss',now), 30 )
end;

Procedure TACBrECFDaruma.MudaHorarioVerao ;
Var FlagVerao : String ;
    Resp : TModalResult ;
begin

  Resp := MessageDlg('Hor�rio de Ver�o ?',mtConfirmation,mbYesNoCancel,0) ;
  if Resp = mrCancel then exit ;

  FlagVerao := IfThen( Resp = mrYes, '1','0' );
  EnviaComando(ESC + #228 + 'XXXXX' + FlagVerao + StringOfChar('X',34) ) ;
end;

procedure TACBrECFDaruma.MudaArredondamento(Arredondar: Boolean);
begin
  EnviaComando( ESC + #228 + 'XXXX' + IfThen( Arredondar, '1','0' ) +
                StringOfChar('X',35) ) ;
end;

procedure TACBrECFDaruma.AbreCupom(CPF_CNPJ: String);
begin
  { Daruma n�o permite informar o CPF/CNPJ na Abertura do Cupom } 
  fpUltimaMsgPoucoPapel := 0 ;  { Zera tempo pra msg de pouco papel }

  EnviaComandoEspera(ESC + #200, 5) ;
  fsEmPagamento := false ;
  fsTotalAPagar := 0 ;
end;

procedure TACBrECFDaruma.CancelaCupom;
begin
  EnviaComandoEspera(ESC + #206, 15) ;
  fsEmPagamento := false ;
  fsTotalAPagar := 0 ;

  FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (s� por garantia)}
end;

procedure TACBrECFDaruma.CancelaItemVendido(NumItem: Integer);
begin
  EnviaComando(ESC + #205 + IntToStrZero( NumItem ,3), 1) ;
end;

procedure TACBrECFDaruma.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
Var RetCmd : String ;
begin
  inherited EfetuaPagamento(CodFormaPagto, Valor, Observacao, ImprimeVinculado);

  Observacao := LeftStr(Observacao,48) + FF ;
  RetCmd     := EnviaComando( ESC + #242 + CodFormaPagto +
                  IntToStrZero( Round( Valor * 100),12) + Observacao, 2) ;

  fsEmPagamento := true ;
  fsTotalAPagar := RoundTo( StrToIntDef( copy(RetCmd,2,12),0 ) / 100, -2) ;
end;

procedure TACBrECFDaruma.FechaCupom(Observacao: String);
begin
  Observacao := StringReplace(Observacao,#10,CR+LF,[rfReplaceAll]) + FF ;

  EnviaComandoEspera( ESC + #243 + Observacao, 10) ;

  fsEmPagamento := false ;
  fsTotalAPagar := 0 ;
end;

procedure TACBrECFDaruma.SubtotalizaCupom(DescontoAcrescimo: Double);
Var A_D : Char ;
    RetCmd : String ;
begin
  if DescontoAcrescimo < 0 then
     A_D := '1'
  else if DescontoAcrescimo > 0 then
     A_D := '3'
  else
     A_D := '0' ;

  DescontoAcrescimo := abs(DescontoAcrescimo) ;

  { Inicia fechamento com formas de Pagamento }
  RetCmd := EnviaComando(ESC + #241 + A_D + IntToStrZero(
                         Round( DescontoAcrescimo * 100 ), 12), 5) ;
  fsEmPagamento := true ;
  fsTotalAPagar := RoundTo( StrToIntDef( copy(RetCmd,2,12),0 ) / 100, -2) ;
end;

procedure TACBrECFDaruma.VendeItem(Codigo, Descricao: String;
  AliquotaICMS : String; Qtd: Double; ValorUnitario: Double;
  DescontoPorc: Double; Unidade: String);
Var AliquotaStr, QtdStr, ValorStr, DescontoStr : String ;
    ValAliquota : Double ;
    Aliquota : TACBrECFAliquota ;
    LenQtd : Integer ;
begin
  if Qtd > 99999 then
     raise EACBrECFCMDInvalido.Create(
           'Quantidade deve ser inferior a 99999.');

  if AliquotaICMS = '' then
     raise EACBrECFCMDInvalido.Create(
           'Aliquota de ICMS n�o pode ser vazia.');
           
  case AliquotaICMS[1] of
    'I' : AliquotaStr := 'I ' ;
    'N' : AliquotaStr := 'N ' ;
    'F' : AliquotaStr := 'F ' ;
    'T' : AliquotaStr := padL(copy(AliquotaICMS,1,2),2) ; {Indice}
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
  DescontoStr := IntToStrZero( Round(DescontoPorc * 100), 4) ;
  LenQtd      := 5 ;
  if StrToInt(NumVersao) >= 345 then
     LenQtd := 6 ;
  QtdStr := FloatToStr(Qtd) ;
  if Length(QtdStr) > LenQtd then
     QtdStr := FloatToStr(RoundTo(Qtd,-(LenQtd-pos(DecimalSeparator,QtdStr)))) ;
  QtdStr := PadR(StringReplace(QtdStr,DecimalSeparator,',',[rfReplaceAll])
                    ,LenQtd,'0') ;

  if StrToInt(NumVersao) >= 345 then
   begin
     Descricao := Trim(Descricao) + FF ;
     ValorStr  := IntToStrZero( Round(ValorUnitario * 1000), 9) ;

     EnviaComando(ESC + #225 + AliquotaStr + Codigo + '0000' + DescontoStr +
                  ValorStr + QtdStr + Unidade + Descricao, 1) ;
   end
  else
   begin
     Descricao := PadL(Descricao,30) ;
     ValorStr  := IntToStrZero( Round(ValorUnitario * 100), 9) ;

     EnviaComando(ESC + #215 + AliquotaStr + Codigo + '0000' + DescontoStr +
                  ValorStr + QtdStr + Unidade + Descricao, 1) ;
   end ;

  fsTotalAPagar := 0 ;
  fsEmPagamento := false ;
end;

procedure TACBrECFDaruma.CarregaAliquotas;
Var RetCmd : String ;
    Aliquota : TACBrECFAliquota ;
    ValAliq : Double ;
begin
  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  RetCmd := EnviaComando( ESC + #231 ) ;
  RetCmd := copy(RetCmd,3,Length(RetCmd)-3) ;  {Retira :% e CR }

  while Length(RetCmd) > 0 do
  begin
    ValAliq := RoundTo( StrToIntDef( copy(RetCmd,2,4) ,0) / 100, -2) ;

    if ValAliq > 0 then
    begin
       Aliquota := TACBrECFAliquota.create ;

       Aliquota.Indice   := 'T'+UpCase(RetCmd[1]) ;
       Aliquota.Aliquota := ValAliq ;
       if UpCase(RetCmd[1]) <> RetCmd[1] then { � minuscula ? }
          Aliquota.Tipo := 'S' ;

       fpAliquotas.Add( Aliquota ) ;
    end ;

    RetCmd := copy(RetCmd,6,Length(RetCmd) ) ;
  end ;
end;

procedure TACBrECFDaruma.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String );
Var ValStr, TipoStr : String ;
begin
  { Esse comando na Daruma nao usa o parametro Posicao }
  ValStr  := IntToStrZero( Round(Aliquota * 100) ,4) ;
  TipoStr := UpperCase(Tipo) ;
  if TipoStr <> 'S' then
     TipoStr := '' ;

  EnviaComando( ESC + #220 + TipoStr + ValStr ) ;
  
  CarregaAliquotas ;  { Re-avalia as aliquotas } 
end;

procedure TACBrECFDaruma.CarregaFormasPagamento;  { fun�ao Lenta +- 3 sec. }
Var RetCmd, StrFPG, StrCNF, Token, Descricao : String ;
    Cont : Integer ;
    FPagto : TACBrECFFormaPagamento ;
    CNF : TACBrECFComprovanteNaoFiscal ;
begin
  inherited CarregaFormasPagamento ;       {Inicializa fpFormasPagamentos}
  inherited CarregaComprovantesNaoFiscais ;{Inicializa fpComprovantesNaoFiscais}

  RetCmd := EnviaComando( ESC + #238 ) ;

  StrFPG := UpperCase(copy(RetCmd, 710, 288)) ;
  StrCNF := UpperCase(copy(RetCmd, 374, 336)) ;

  for Cont := 1 to 16 do
  begin
     Token     := copy(StrFPG, ((Cont-1) * 18) + 1, 17) ;
     Descricao := Trim(copy(Token,2,17)) ;
     if Descricao <> '' then
     begin
        FPagto := TACBrECFFormaPagamento.create ;

        FPagto.Indice    := chr(64+Cont) ;
        FPagto.Descricao := Descricao ;
        FPagto.PermiteVinculado := (Token[1] = 'V');

        fpFormasPagamentos.Add( FPagto ) ;
     end ;

     Token := copy(StrCNF, ((Cont-1) * 21) + 1, 21) ;
     if Token <> '' then
     begin
        CNF := TACBrECFComprovanteNaoFiscal.create ;

        CNF.Indice := chr(64+Cont) ;
        CNF.Descricao := Trim(Token) ;

        fpComprovantesNaoFiscais.Add( CNF ) ;
     end ;
  end ;
end;

procedure TACBrECFDaruma.ProgramaFormaPagamento(var Descricao: String;
  PermiteVinculado: Boolean; Posicao : String);
Var ProxIndice : Integer ;
    FPagto : TACBrECFFormaPagamento ;
begin
  Descricao := padL(Descricao,17) ;

  CarregaFormasPagamento ;

  ProxIndice := StrToIntDef(Posicao,-1) ;
  if (ProxIndice < 0) or (ProxIndice > 15) then { Indice passado � v�lido ? }
  begin
     For ProxIndice := 0 to 16 do  { Procurando Lacuna }
     begin
        if AchaCNFIndice(chr(65+ProxIndice)) = nil then
           break ;
     end ;
  end ;

  if ProxIndice > 15 then
     raise Exception.create('N�o h� espa�o para programar novas Formas de '+
                            'Pagamento');

  EnviaComando( ESC + #218 + 'PG' + IfThen(PermiteVinculado,'V','X') +
                chr(65+ProxIndice) + Descricao ) ;

  { Adcionanodo nova FPG no ObjectList }
  FPagto := TACBrECFFormaPagamento.create ;
  FPagto.Indice    := chr(65+ProxIndice) ;
  FPagto.Descricao := Descricao ;
  FPagto.PermiteVinculado := PermiteVinculado ;
  fpFormasPagamentos.Add( FPagto ) ;

  if PermiteVinculado then  { Equalizando Formas de Pagamento com CNFs }
     ProgramaComprovanteNaoFiscal(Descricao,'V');
end;

procedure TACBrECFDaruma.CarregaComprovantesNaoFiscais;
begin
  CarregaFormasPagamento ;
end;

procedure TACBrECFDaruma.ProgramaComprovanteNaoFiscal(var Descricao: String;
  Tipo: String; Posicao : String );
begin
  { Esse comando na Daruma nao usa o parametro Posicao }
  Descricao := padL(Descricao,21) ;
  if Tipo = '' then
     Tipo := 'V'
  else
     Tipo := UpperCase(Tipo) ;

  if pos(Tipo,'V+-') = 0 then
     raise Exception.Create('Os Tipos v�lidos para Daruma s�o:'+sLineBreak+
                            'V  Comprovante Vinculado'+sLineBreak+
                            '+  Entrada de Recursos'+sLineBreak+
                            '-  Saida de Recursos') ;

  EnviaComando( ESC + #226 + Tipo + Descricao ) ;
  CarregaComprovantesNaoFiscais ;
end;


procedure TACBrECFDaruma.AbreRelatorioGerencial;
begin
  EnviaComandoEspera(ESC + #211, 30) ;
end;

procedure TACBrECFDaruma.LinhaRelatorioGerencial(Linha: String);
begin
  EnviaComando( ESC + #213 + Linha + LF ) ;
end;

procedure TACBrECFDaruma.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
Var FPG : TACBrECFFormaPagamento ;
    CNF : TACBrECFComprovanteNaoFiscal ;
    StrValor : String ;
begin
  FPG := AchaFPGIndice( CodFormaPagto ) ;
  if FPG = nil then
     raise Exception.create( 'Forma de Pagamento: '+CodFormaPagto+
                             ' n�o foi cadastrada.' ) ;

  if CodComprovanteNaoFiscal <> '' then
   begin
     CNF := AchaCNFIndice( CodComprovanteNaoFiscal ) ;
     if CNF = nil then
        raise Exception.create( 'Comprovante N�O Fiscal: '+
                         CodComprovanteNaoFiscal+' n�o cadastrado.' ) ;
   end
  else
   begin
     CNF := AchaCNFDescricao( FPG.Descricao ) ;
     if CNF = nil then
        raise Exception.create( 'N�o existe nenhum Comprovante N�O Fiscal '+
                         ' com a Descri��o: '+FPG.Descricao) ;
   end ;

  COO      := Poem_Zeros( trim(COO) ,6) ;
  StrValor := IntToStrZero( Round(Valor * 100) ,12) ;
  
  EnviaComandoEspera(ESC + #219 + CNF.Indice + FPG.Indice + COO + StrValor, 8)
end;

procedure TACBrECFDaruma.LinhaCupomVinculado(Linha: String);
begin
  LinhaRelatorioGerencial( Linha ) ; 
end;

procedure TACBrECFDaruma.FechaRelatorio;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( ESC + #239 ) ;

  if pos(copy(RetCmd,8,1),'03') > 0 then
     EnviaComandoEspera(ESC + #212, 8 ) ;
end;


procedure TACBrECFDaruma.ListaRelatorioGerencial(Relatorio: TStrings;
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

procedure TACBrECFDaruma.ListaCupomVinculado(Relatorio: TStrings;
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

procedure TACBrECFDaruma.PreparaTEF;
begin
  inherited PreparaTEF ;

  CarregaFormasPagamento ;
end;

procedure TACBrECFDaruma.ImpactoAgulhas;
Var
  {$IFDEF VisualCLX}
  Value : Integer
  {$ELSE}
  Resp  : String
  {$ENDIF} ;
  Cmd : String ;
begin
  if MessageDlg('Usar uma for�a de impacto maior'+sLineBreak+
                'que a Padr�o da Impressora (Normal)'+sLineBreak+
                'implica na diminui��o da vida �til'+sLineBreak+
                'do cabe�ote impressor.'+sLineBreak+sLineBreak+
                'Deseja continuar ?',mtWarning,mbYesNoCancel,0) <> mrYes then
     exit ;

  {$IFDEF VisualCLX}
    Value := 1 ;
    if not InputQuery('For�a de Impacto',
                  'Entre com a For�a de Impacto'+sLineBreak+sLineBreak+
                  '1 - Normal (padr�o)'+sLineBreak+
                  '2 - Extra',
                   Value, 1, 2 ) then
       exit ;

       if Value = 2 then
          Cmd := '2'
       else
          Cmd := '0' ;
  {$ELSE}
    Resp := '1' ;
    if not InputQuery('For�a de Impacto',
                  'Entre com a For�a de Impacto'+sLineBreak+sLineBreak+
                  '1 - Normal (padr�o)'+sLineBreak+
                  '2 - Extra', Resp ) then
       exit ;

       if Resp = '2' then
          Cmd := '2'
       else
          Cmd := '0' ;
  {$ENDIF} ;

  EnviaComando(ESC + #228 + StringOfChar('X',13) + Cmd + StringOfChar('X',26) ) ;
end;

procedure TACBrECFDaruma.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal: Integer);
Var Espera : Integer ;
begin
  Espera := 10 + (ReducaoFinal - ReducaoInicial) ;
  EnviaComandoEspera( ESC + #209 + 'x' + IntToStrZero(ReducaoInicial,6)+
                      IntToStrZero(ReducaoFinal  ,6), Espera ) ;
end;

procedure TACBrECFDaruma.LeituraMemoriaFiscal(DataInicial,
   DataFinal: TDateTime);
Var Espera : Integer ;
begin
  Espera := 10 + DaysBetween(DataInicial,DataFinal) ;
  EnviaComandoEspera( ESC + #209 + 'x' + FormatDateTime('ddmmyy',DataInicial)+
                      FormatDateTime('ddmmyy',DataFinal), Espera ) ;
end;

procedure TACBrECFDaruma.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas: TStringList);
Var Espera : Integer ;
begin
  Espera := Trunc(TimeOut + ((ReducaoFinal - ReducaoInicial)/5) ) ;
  Linhas.Clear ;
  Linhas.Text := EnviaComando(ESC + #209 + 's' +
                                  IntToStrZero(ReducaoInicial,6)+
                                  IntToStrZero(ReducaoFinal  ,6), Espera ) ;
end;

procedure TACBrECFDaruma.LeituraMemoriaFiscalSerial(DataInicial,
   DataFinal: TDateTime; var Linhas: TStringList);
Var Espera : Integer ;
begin
  Espera := Trunc(TimeOut + (DaysBetween(DataInicial,DataFinal)/5) ) ;
  Linhas.Clear ;
  Linhas.Text := EnviaComando(ESC + #209 + 's' +
                                  FormatDateTime('ddmmyy',DataInicial)+
                                  FormatDateTime('ddmmyy',DataFinal), Espera ) ;
end;

end.


