{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para interação com equipa- }
{ mentos de Automação Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
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
|* 21/02/2005:  Daniel Simoes de Almeida
|*   Primeira Versao: Criaçao e Distribuiçao da Primeira Versao
|* 22/06/2005:  Daniel Simoes de Almeida e Licerio Jose Rodrigues Neto
|*   - Corrigido diversos Bugs nos ECFs versao 0.3, em VendeItem,
|*     EfetuaPagamento
******************************************************************************}
{$I ACBr.inc}

unit ACBrECFSweda ;

interface
uses ACBrECFClass, ACBrUtil, 
     Classes,
     {$IFDEF VCL} Dialogs , Controls , Forms {$ENDIF}
     {$IFDEF VisualCLX} QDialogs, QControls, QForms {$ENDIF};

type
{ Classe filha de TACBrECFClass com implementaçao para Sweda }
TACBrECFSweda = class( TACBrECFClass )
 private
    fsNumVersao : String ;
    fsNumSerie  : String ;
    fsNumCRO    : String ;
    fsNumECF    : String ;
    fsModeloSweda : Char ; { A - IF-7000III, B - IF-7000I,   C - IF-7000II,
                             D - IF-7000IE,  E - IF-7000IIE, F - IFS-9000,
                             G - IFS9000IIIE }
    fsVinculado  : Integer ;  { 0 = Nenhum, ou numero de Vinculados pendentes }
    fsFechando   : Boolean ;
    fsTimeOutStat: TDateTime ;
    fsCMDVinculado : String ;

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

    Procedure ImprimeCheque(Banco : String; Valor : Double ; Favorecido,
       Cidade : String; Data : TDateTime ;Observacao : String = '') ; override ;
    Procedure CancelaImpressaoCheque ; override ;
    
    Procedure MudaHorarioVerao  ; override ;
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
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;
 end ;

implementation
Uses ACBrBase,
     SysUtils, DateUtils, StrUtils  , Math ;

{ ----------------------------- TACBrECFSweda ------------------------------ }

constructor TACBrECFSweda.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.HandShake := hsDTR_DSR ;
  { Variaveis internas dessa classe }
  fsVinculado   := 0 ;
  fsFechando    := false ;
  fsNumVersao   := '0' ;
  fsNumSerie    := '' ;
  fsNumECF      := '' ;
  fsNumCRO      := '' ;
  fsModeloSweda := ' ' ;
  fsTimeOutStat := 0 ;
  fsCMDVinculado:= '' ;

  fpColunas     := 40 ;
  fpModeloStr   := 'Sweda' ;
end;

destructor TACBrECFSweda.Destroy;
begin

  inherited Destroy ;
end;

procedure TACBrECFSweda.Ativar;
begin
  if not fpDevice.IsSerialPort  then
     raise Exception.Create('A impressora: '+ModeloStr+' requer'+#10+
                            'Porta Serial:  (COM1, COM2, COM3, ...)');

  fpDevice.HandShake := hsDTR_DSR ;
  inherited Ativar ; { Abre porta serial }

  fsNumVersao   := '0' ;
  fsNumSerie    := '' ;
  fsNumECF      := '' ;
  fsNumCRO      := '' ;
  fsModeloSweda := ' ' ;

  try
     { Testando a comunicaçao com a porta }
     if NumVersao = '0' then
        raise EACBrECFNaoInicializado.Create(
                 'Erro inicializando a impressora '+ModeloStr );
  except
     Desativar ;
     raise ;
  end ;
end;


Function TACBrECFSweda.EnviaComando( cmd : String ) : String ;
Var ErroMsg : String ;
    AUT, SLIP, STATUS : Char ;
    Verificar : Boolean ;
begin

  result    := '' ;
  ErroMsg   := '' ;
  Verificar := false ;
  fpComandoEnviado   := '' ;
  fpRespostaComando  := '' ;
  AguardandoResposta := true ;

  try
     if (not fpDevice.Ativo) then
        raise EACBrECFNaoInicializado.create(
                 'Componente ACBrECF não está Ativo');

     { Codificando CMD de acordo com o protocolo da Sweda }
     cmd := #27 + '.' + cmd + '}' ;
     
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

     while fpComandoEnviado = '' do
     begin
        fpDevice.Serial.Purge ;                   { Limpa a Porta }

        try
           fpDevice.Serial.SendString( cmd );   { Eviando o comando }
           fpComandoEnviado := cmd ;
        except
           if (not Retentar) or (MessageDlg(
              'Camandos não estão sendo enviados para Impressora '+ModeloStr+
              sLineBreak+'Deseja tentar novamente ?',
              mtConfirmation,[mbYes,mbNo],0) <> mrYes) then
              raise EACBrECFSemResposta.create(
                    'Erro ao enviar comandos para a Impressora '+ModeloStr)
           else
              continue ;
        end ;
     end ;

     while true do
     begin
        try
           fpDevice.Serial.DTR := true ;
           break ;
        except
           Sleep(100);
        end ;
     end ;

     { Chama Rotina da Classe mãe TACBrClass para ler Resposta. Se houver
       falha na leitura LeResposta dispara Exceçao }
     LeResposta ;
     Result := fpRespostaComando ;

     if Result = '' then
        Result := '.-0001^TIMEOUT' ;

     { Verificando por erros }
     ErroMsg := '' ;
     if (copy(Result, 1, 5) = '.-P00') and (Length(Result) = 7) then
      begin
        case Result[6] of
          '2' : ErroMsg := 'Comando não foi enviado a Impressora.' ;
          '6' : ErroMsg := 'Não foi recebida a resposta da Impressora.' ;
        end;
        Verificar := true ;
      end

     else if copy(Result, 1, 3) = '.-P' then
      begin
        try AUT    := Result[4] except AUT    := ' ' end ;
        try SLIP   := Result[5] except SLIP   := ' ' end ;
        try STATUS := Result[6] except STATUS := ' ' end ;

        if (AUT = '1') or (SLIP = '1') or (STATUS = '1') then
         begin
           ErroMsg   := 'Impressora fora de linha'+sLineBreak ;
           Verificar := true ;
         end
        else if (AUT = '2') or (SLIP = '2') or (STATUS = '2') then
         begin
           ErroMsg   := 'Time-out de Transmissao'+sLineBreak ;
           Verificar := true ;
         end
        else if (AUT = '6') or (SLIP = '6') or (STATUS = '6') then
         begin
           ErroMsg   := 'Impressora não está pronta para aceitar novo comando'+
                        sLineBreak ;
           Verificar := true ;
         end ;

        if AUT = '5' then
           ErroMsg := ErroMsg + 'SEM documento para AUTENTICAR'+sLineBreak ;

        if SLIP = '5' then
           ErroMsg := ErroMsg + 'SEM FOLHA solta presente'+sLineBreak ;

        if STATUS = '5' then
           DoOnMsgPoucoPapel( 'Sem papel ou papel acabando' ) ;

      end
     else if copy(Result, 1, 2) = '.-' then
      begin
        ErroMsg := copy(Result,7,Length(Result)-7) ;
      end ;

     if Verificar then
     begin
        ErroMsg := ErroMsg + sLineBreak + sLineBreak +
                   'Verifique se a impressora está ligada, '+sLineBreak+
                   'se os cabos estão conectados ou '+sLineBreak+
                   'se o programa está configurado corretamente.' ;
     end ;

     if ErroMsg <> '' then
     begin
        ErroMsg := 'Erro retornado pela Impressora: '+ModeloStr+
                   sLineBreak + sLineBreak+
                   ErroMsg ;
        raise EACBrECFSemResposta.create( ErroMsg ) ;
     end ;

  finally
     AguardandoResposta := false ;
     fsTimeOutStat      := 0 ;
  end ;
end;

function TACBrECFSweda.EnviaComandoEspera(cmd: String;
   lTimeout: Integer): String;
Var SecRestante     : Integer ;
    TempoInicio     : TDateTime ;
    wTempoInicioMsg : Integer ;
    wRetentar       : Boolean ;
    wRespostaComando: String ;
    RetCmd          : String ;
begin
  TempoInicio := now  ;

  Result := EnviaComando( cmd , lTimeout) ;
  RetCmd := '' ;

  SecRestante := lTimeout - SecondsBetween(now, TempoInicio) ;

  { Tenta ler o Status (.23), pois a Sweda nao conseguirá responder enquanto
   estiver imprimindo. Isso irá "prender" a Rotina em EnviaComando, corretamente}
  wTempoInicioMsg := TempoInicioMsg ;
  wRetentar       := Retentar ;
  wRespostaComando:= fpRespostaComando ;
  try
     try
        TempoInicioMsg := 0 ;          { Para nao parar de exibir a msg }
        Retentar       := false ;

        while (SecRestante > 0) and (RetCmd = '') do
        begin
          { Espera metade do tempo sem Testar Status da Impressora }
           fsTimeOutStat := IncSecond( now, max(Round(SecRestante / 2),2) ) ;
           try
              RetCmd := EnviaComando( '23', SecRestante) ;

              if SecondsBetween(TempoInicio, now) < Round(SecRestante/4) then
                 raise Exception.create('Resposta inválida (muito antes !!!)');
           except
              RetCmd := '' ;
              Sleep( 500 ) ;
           end ;
           SecRestante := lTimeout - SecondsBetween(now, TempoInicio) ;
        end ;

     finally
        fsTimeOutStat     := 0 ;
        Retentar          := wRetentar ;
        TempoInicioMsg    := wTempoInicioMsg ;
        fpRespostaComando := wRespostaComando ;
     end ;
  except
     on E : EACBrECFSemResposta do
     else
        raise ;
  end ;
end;

function TACBrECFSweda.VerificaFimLeitura : Boolean;
begin
  { Nota sobre o VerificaFimLeitura: A SWEDA responde muito antes da
    Impressao terminar, o que pode causar problemas com comandos enviados logo
    após impressoes demoradas como a LituraX por exemplo. Por isso usei .23
    nesses casos após a Impressao demorada, para prender a Impressora até o Fim
    da Impressao (Veja Procedure EnviaComandoEspera) }

   Result := (RightStr(fpRespostaComando,1) = '}') and
             (Length(fpRespostaComando) > 6) ;

  { comando .23,.28 nao podem demora mais do que 1 segundo, se nao respondeu
    nesse tempo, a impressora nao irá responder nunca... Provavelmente o comando
    nao foi registrado, porém a Sweda nao possui retorno de ACK }
   if (not Result) and (fsTimeOutStat <> 0) and (now > fsTimeOutStat) then
      Result := true ;
end;

function TACBrECFSweda.GetDataHora: TDateTime;
Var RetCmd : String ;
    OldShortDateFormat : String ;
    P : Integer ;
begin
  RetCmd := EnviaComando( '28' ) ;
  P      := pos('!',RetCmd) ;
  Result := 0 ;
  if P > 0 then
  begin
     OldShortDateFormat := ShortDateFormat ;
     try
        ShortDateFormat := 'dd/mm/yy' ;
        result := StrToDate(copy(RetCmd,P+1,2)+'/'+copy(RetCmd,P+3,2)+'/'+
                            copy(RetCmd,P+5,2)) ;
        result := RecodeHour(  result,StrToIntDef(copy(RetCmd,P+7,2),0)) ;
        result := RecodeMinute(result,StrToIntDef(copy(RetCmd,P+9,2),0)) ;
        { Obs.: Sweda nao retorna os Segundos }
     finally
        ShortDateFormat := OldShortDateFormat ;
     end ;
  end ;
end;

function TACBrECFSweda.GetNumCupom: String;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( '27'+'1' ) ;
  Result := '      ' ;

  if LeftStr(RetCmd, 3) = '.+C' then
     Result := IntToStrZero( StrToIntDef( copy(RetCmd,14,4), 0), 6) ;
end;

function TACBrECFSweda.GetNumCRO: String;
Var RetCmd : String ;
begin
  if Trim(fsNumCRO) = '' then
  begin
     RetCmd := EnviaComando( '27'+'G' ) ;

     if LeftStr(RetCmd, 3) = '.+C' then
        fsNumCRO := IntToStrZero( StrToIntDef(copy(RetCmd,16,4),0),4) ;
  end ;

  Result := fsNumCRO ;
end;

function TACBrECFSweda.GetNumECF: String;
Var RetCmd : String ;
begin
  if Trim(fsNumECF) = '' then
  begin
     RetCmd := EnviaComando( '27'+'F' ) ;  { F ‚ o menor, mais rapido de ler }
     if LeftStr(RetCmd, 3) = '.+C' then
        fsNumECF := IntToStrZero( StrToIntDef(copy(RetCmd,4,3),0),4) ;
  end ;

  Result := fsNumECF ;
end;

function TACBrECFSweda.GetNumSerie: String;
Var RetCmd : String ;
begin
  if Trim(fsNumSerie) = '' then
  begin
     RetCmd := EnviaComando( '27'+'3' ) ;
     if LeftStr(RetCmd, 3) = '.+C' then
        fsNumSerie := Copy(RetCmd,13,9) ;
  end ;

  Result := fsNumSerie ;
end;

function TACBrECFSweda.GetNumVersao: String ;
Var RetCmd : String ;
begin
  if fsModeloSweda = ' ' then
  begin
     RetCmd := EnviaComando( '27'+'1' ) ;
     if (LeftStr(RetCmd, 3) = '.+C') and (copy(RetCmd, 7, 1) = '1') then
        try
           fsModeloSweda := RetCmd[125] ;
        except
           fsModeloSweda := ' ' ;
        end ;
  end ;

  if fsNumVersao = '0' then
  begin
     RetCmd := EnviaComando( '27'+'G' ) ;
     if (LeftStr(RetCmd, 3) = '.+C') and (copy(RetCmd, 7, 1) = 'G') then
        fsNumVersao := copy(RetCmd,28,3)
     else
        fsNumVersao := '0.3' ;
        
     fsNumVersao := StringReplace(fsNumVersao,',',DecimalSeparator,[]) ;
     fsNumVersao := StringReplace(fsNumVersao,'.',DecimalSeparator,[]) ;

     try
        StrToFloat(fsNumVersao) ;
     except
        fsNumVersao := '0' ;
     end ;
  end ;

  Result := fsNumVersao ;
end;

function TACBrECFSweda.GetTotalPago: Double;
Var RetCmd : String ;
    SubTot, Falta : Double ;
    P : Integer ;
begin
  RetCmd := EnviaComando('28') ;
  P      := pos('!',RetCmd) ;
  Result := 0 ;
  if P > 0 then
  begin
     SubTot := RoundTo(StrToIntDef(copy(RetCmd,P-24,12),0) / 100, -2) ;
     Falta  := RoundTo(StrToIntDef(copy(RetCmd,P+52,12),0) / 100, -2) ;
     Result := max( RoundTo(SubTot - Falta,-2) ,0) ; { evitar negativo }
  end ;
end;

function TACBrECFSweda.GetSubTotal: Double;
Var RetCmd : String ;
    P : Integer ;
begin
  RetCmd := EnviaComando('28') ;
  P      := pos('!',RetCmd) ;
  Result := 0 ;
  if P > 0 then
     Result := RoundTo(StrToIntDef(copy(RetCmd,P-24,12),0) / 100, -2) ;
end;

function TACBrECFSweda.GetEstado: TACBrECFEstado;
Var RetCmd, Status, Transacao : String ;
    P, I : Integer ;
    FlagZ, FlagX : Char ;
    SubTot, Falta : Double ;
begin
  if (not fpAtivo) then
     fpEstado := estNaoInicializada
  else
   begin
     RetCmd := EnviaComando( '28' ) ;
     P      := pos('!',RetCmd) ;
     if P > 0 then
     begin
        try
           FlagX := RetCmd[P+76]
        except
           FlagX := ' '
        end ;
        try
           FlagZ := RetCmd[P+77]
        except
           FlagZ := ' '
        end ;
        SubTot := RoundTo(StrToIntDef(copy(RetCmd,P-24,12),0) / 100, -2) ;
        Falta  := RoundTo(StrToIntDef(copy(RetCmd,P+52,12),0) / 100, -2) ;

        I := IfThen(StrToFloat(NumVersao) >= 1,10,07) ;
        { Status pode ser: C - concluida, P - Pendente, E - Erro no Comando }
        Status    := UpperCase(copy(RetCmd,I,1)) ;
        Transacao := UpperCase(Trim(copy(RetCmd,I+1,8))) ;

        if FlagZ = 'S' then
           fpEstado := estBloqueada
        else if FlagZ = 'F' then
           fpEstado := estRequerZ
        else if FlagX = 'F' then
           fpEstado := estRequerX
        else if (Status <> 'C') then
         begin
           if fsFechando or ((SubTot <> 0) and (SubTot <> Falta)) then
              fpEstado := estPagamento
           else if (Transacao = 'VENDAS')  then
              fpEstado := estVenda
           else if ((Transacao = 'N.FISCAL') or (Transacao = 'LEIT. X') ) then
              fpEstado := estRelatorio ;
         end
        else if (Status = 'C') and (FlagZ = 'N') then
           fpEstado := estLivre
        else
           fpEstado := estDesconhecido ;
     end ;
   end ;

  Result := fpEstado ;
end;

function TACBrECFSweda.GetGavetaAberta: Boolean;
Var RetCmd : String ;
begin
  if fsModeloSweda = 'B' then
     RetCmd := EnviaComando('22')
  else
     RetCmd := EnviaComando('43') ;

  Result := (copy(RetCmd,1,6) = '.+G000')
end;

function TACBrECFSweda.GetPoucoPapel: Boolean;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando( '23' ) ;
  Result := (copy( RetCmd, 6,1) = '5') ;
end;

function TACBrECFSweda.GetHorarioVerao: Boolean;
Var RetCmd : String ;
    P : Integer ;
begin
  RetCmd := EnviaComando( '28' ) ;
  P      := pos('!',RetCmd) ;
  Result := False ;
  if P > 0 then
     Result := (copy(RetCmd,P+11,1) = 'S') ;
end;

function TACBrECFSweda.GetArredonda: Boolean;
begin
  Result := (fsModeloSweda < 'F') ;
end;

Procedure TACBrECFSweda.LeituraX ;
begin
  EnviaComandoEspera('13N' , 45 ) ;
end;

Procedure TACBrECFSweda.ReducaoZ(DataHora: TDateTime) ;
begin
  EnviaComandoEspera( '14N'+FormatDateTime('ddmmyy',now), 50 ) ;
end;

Procedure TACBrECFSweda.AbreGaveta ;
begin
  if fsModeloSweda = 'B' then
     EnviaComando('21')
  else
     EnviaComando('42') ;
     
  sleep(100) ;
end;

Procedure TACBrECFSweda.MudaHorarioVerao ;
Var Resp : TModalResult ;
begin
  Resp := MessageDlg('Horário de Verão ?',mtConfirmation,mbYesNoCancel,0) ;
  if Resp = mrCancel then exit ;

  EnviaComando( '36' + IfThen(Resp = mrYes,'S','N'), 3 ) ;
end;

procedure TACBrECFSweda.AbreCupom(CPF_CNPJ: String);
begin
  fpUltimaMsgPoucoPapel := 0 ;  { Zera tempo pra msg de pouco papel }

  CPF_CNPJ := padL(CPF_CNPJ,20) ;
  EnviaComandoEspera('17'+CPF_CNPJ, 15) ;
  fsFechando := false ;
end;

procedure TACBrECFSweda.CancelaCupom;
Var RetCmd   : String ;
    Cancelou : Boolean ;
    SubTot   : Double ;
begin
{ TODO : Modelos F e superiores permitem cancelar o Cupom Nao Fiscal Vinculado
         usando: .088 }
  RetCmd   := EnviaComandoEspera( '05' ,20) ;
  Cancelou := (copy(RetCmd,1,2) = '.+') ;

  if not Cancelou then
  begin
     SubTot := Subtotal ;
     EnviaComando('10'+'01'+IntToStrZero( Round(SubTot*100) ,12) ) ;
     EnviaComando('12' + IfThen(StrToFloat(NumVersao) >= 1,
                                'N'+IfThen(fsModeloSweda < 'F','N',''),
                                ''), 10 ) ;
     EnviaComando('05' ,15) ;
  end ;

  FechaRelatorio ;   { Fecha relatorio se ficou algum aberto (só por garantia)}
end;

procedure TACBrECFSweda.CancelaItemVendido(NumItem: Integer);
begin
  EnviaComando( '04' + IntToStrZero(NumItem,3) ,1) ;
end;

procedure TACBrECFSweda.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
begin
  inherited EfetuaPagamento(CodFormaPagto, Valor, Observacao, ImprimeVinculado);

  if ImprimeVinculado then
     if (fsModeloSweda < 'F') and (fsVinculado > 0) then
        raise Exception.Create('Já existe Forma de Pagamento com '+sLineBreak+
                       'comprovante NAO fiscal vinculado pendente. '+sLineBreak+
                       'Impressora: '+ModeloStr+' Modelo: '+fsModeloSweda+sLineBreak+
                       ' aceita apenas 1 Compr.NAO Fiscal Viculado por Cupom.')
     else
        fsVinculado := fsVinculado + 1 ;

  If StrToFloat(NumVersao) < 1 then
   begin
     Sleep(100) ;
     Observacao := '' ;
   end
  else
     Observacao := '{' + copy(Observacao,1,80) ;

  EnviaComandoEspera('10' + CodFormaPagto + IntToStrZero( Round(Valor*100) ,12) +
                     Observacao ,5) ;

  fsFechando := true ;
end;

procedure TACBrECFSweda.FechaCupom(Observacao: String);
Var A,P,N : Integer ;
    Obs, Cmd : String ;
begin
  { Ajustando a Observaçao em N Linhas do mesmo tamanho de COLUNAS}
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

     Obs := Obs + '0' + padL( copy(Observacao,1,P-N) , Colunas) ;

     A := A + 1 ;
     Observacao := copy(Observacao, P+1, Length(Observacao) ) ;
  end ;

  { Fecha cupom }
  Cmd := '' ;
  if StrToFloat(NumVersao) >= 1 then {V0.3 nao tem parametros adcionais }
   begin
     if fsModeloSweda < 'F' then     { Serie 9000 nao possui param VINC }
        Cmd := Cmd + IfThen(fsVinculado > 0, 'S','N') ;
     Cmd := Cmd + 'N' ;              { Sem cupom Adcional }
   end
  else
     Sleep(100) ;

  EnviaComandoEspera( '12' + Cmd + Obs, 15 ) ;

  fsVinculado := 0 ;
  fsFechando  := false ;
end;

procedure TACBrECFSweda.SubtotalizaCupom(DescontoAcrescimo: Double);
Var SubTot, Porc : Double ;
begin
  if DescontoAcrescimo < 0 then
   begin
     DescontoAcrescimo := abs(DescontoAcrescimo) ;
     if fsModeloSweda >= 'F' then
        EnviaComando('03'+'0000'+IntToStrZero(Round(DescontoAcrescimo*100),12) ,2)
     else
      begin
        SubTot := Subtotal ;
        Porc   := RoundTo( DescontoAcrescimo / SubTot * 100, -2) ;
        EnviaComando('03'+padL(FormatFloat('00.00',Porc),10)+
                     IntToStrZero(Round(DescontoAcrescimo*100),12)+
                     IfThen( StrToFloat(NumVersao) >= 1,'N','') ,2) ;
      end
   end
  else if DescontoAcrescimo > 0 then
   begin
     If StrToFloat(NumVersao) < 1 then
        EnviaComando('11' + '53' + '0000' +
                  IntToStrZero(Round(DescontoAcrescimo*100),11) + '   ' + 'N', 2)
     else
        EnviaComando('11' + '51' + '0000' +
                  IntToStrZero(Round(DescontoAcrescimo*100),11) +
                  IfThen(fsModeloSweda >= 'F','','N'), 2) ;
   end ;

  { Inicia fechamento com formas de Pagamento }
  If StrToFloat(NumVersao) >= 1 then
     EnviaComando('10') ;

  fsVinculado := 0 ;
  fsFechando  := true ;
end;

procedure TACBrECFSweda.VendeItem(Codigo, Descricao: String;
  AliquotaICMS : String; Qtd: Double; ValorUnitario: Double;
  DescontoPorc: Double; Unidade: String);
Var AliquotaStr, QtdStr, ValorStr, TotalStr, Descr2 : String ;
    ValAliquota, ValTotal, ValDesc : Double ;
    Aliquota : TACBrECFAliquota ;
begin
  { Obs.: Sweda nao usa parametro Unidade }
  if Qtd > 9999 then
     raise EACBrECFCMDInvalido.Create(
           'Quantidade deve ser inferior a 9999.');

  if AliquotaICMS = '' then
     raise EACBrECFCMDInvalido.Create(
           'Aliquota de ICMS não pode ser vazia.');

  case AliquotaICMS[1] of
    'I' : AliquotaStr := 'I  ' ;
    'N' : AliquotaStr := 'N  ' ;
    'F' : AliquotaStr := 'F  ' ;
    'T' : AliquotaStr := 'T'+padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice}
    'S' : AliquotaStr := 'S'+padR(copy(AliquotaICMS,2,2),2,'0') ; {Indice}
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
  QtdStr      := IntToStrZero( Round( Qtd*1000 ) ,7) ;
  ValorStr    := IntToStrZero( Round( ValorUnitario*1000 ) ,9) ;

  if fsModeloSweda >= 'F' then   { serie 9000 somente Trunca o total }
   begin
     ValTotal := Trunc( Qtd*ValorUnitario*100 ) / 100 ;
     TotalStr := IntToStrZero( Trunc( ValTotal*100 ) ,12) ;
   end
  else
   begin
     ValTotal := RoundTo( Qtd*ValorUnitario, -2 ) ;
     TotalStr := IntToStrZero( Round( ValTotal*100 ) ,12) ;
   end ;

  If StrToFloat(NumVersao) < 1 then
     Sleep(100) ;

  EnviaComando( '01' + Codigo + QtdStr + ValorStr + TotalStr + '~' +
                Descricao + AliquotaStr + Descr2, 8) ;
  fsFechando := false ;

  if DescontoPorc > 0 then
  begin
     ValDesc := RoundTo( ValTotal * (DescontoPorc / 100), -2) ;
     if fsModeloSweda >= 'F' then
        EnviaComando('02' + '0000' + IntToStrZero( Round(ValDesc*100) ,12) )
     else
        EnviaComando('02' + padL(FormatFloat('00.00',DescontoPorc),10) +
                            IntToStrZero( Round(ValDesc*100) ,12) ) ;
  end ;
end;

procedure TACBrECFSweda.CarregaAliquotas;
Var RetCmd, AliquotasStr, AliqStr : String ;
    Aliquota : TACBrECFAliquota ;
    ValAliq : Double ;
    A : Integer ;
begin
  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  AliquotasStr := '' ;
  AliqStr      := '' ;

  if StrToFloat(NumVersao) < 1 then   { Retorno da 0.3 é muito diferente }
   begin
     RetCmd := EnviaComando('29'+'3') ;
     if copy(RetCmd,1,3) = '.+T' then
     begin
        AliquotasStr := AliquotasStr + copy(RetCmd,49,64) ;

        RetCmd := EnviaComando('29'+'4') ;
        if copy(RetCmd,1,3) = '.+T' then
        begin
           AliquotasStr := AliquotasStr + copy(RetCmd,8,112) ;

           RetCmd := EnviaComando('29'+'5') ;
           if copy(RetCmd,1,3) = '.+T' then
              AliquotasStr := AliquotasStr + copy(RetCmd,8,64) ;
        end ;
     end ;

     for A := 1 to 15 do
     begin
        AliqStr := copy(AliquotasStr,((A-1) * 16) + 1,16) ;
        ValAliq := StrToIntDef(copy(AliqStr,9,4),0) / 100 ;
        if (StrToIntDef( copy(AliqStr,2,2) ,0) > 0) and
           (pos(copy(AliqStr,1,1),'TS') > 0)        then
        begin
           Aliquota := TACBrECFAliquota.create ;

           Aliquota.Indice   := copy(AliqStr,1,3) ;
           Aliquota.Aliquota := ValAliq ;
           if copy(AliqStr,1,1) = 'S' then
              Aliquota.Tipo := 'S' ;

           fpAliquotas.Add( Aliquota ) ;
        end ;
     end ;
   end
  else
   begin
     RetCmd := EnviaComando('29'+'3') ;
     if copy(RetCmd,1,3) = '.+T' then
     begin
        AliquotasStr := AliquotasStr + copy(RetCmd,49,28) ;

        RetCmd := EnviaComando('29'+'4') ;
        if copy(RetCmd,1,3) = '.+T' then
        begin
           AliquotasStr := AliquotasStr + copy(RetCmd,8,49) ;

           RetCmd := EnviaComando('29'+'5') ;
           if copy(RetCmd,1,3) = '.+T' then
               AliquotasStr :=  AliquotasStr + copy(RetCmd,8,28) ;
        end ;
     end ;

     for A := 1 to 15 do
     begin
        AliqStr := copy(AliquotasStr,((A-1) * 7) + 1,7) ;
        ValAliq := StrToIntDef(copy(AliqStr,4,4),0) / 100 ;
        if (StrToIntDef( copy(AliqStr,2,2) ,0) > 0) and
           (pos(copy(AliqStr,1,1),'TS') > 0)        then
        begin
           Aliquota := TACBrECFAliquota.create ;

           Aliquota.Indice   := copy(AliqStr,1,3) ;
           Aliquota.Aliquota := ValAliq ;
           if copy(AliqStr,1,1) = 'S' then
              Aliquota.Tipo := 'S' ;

           fpAliquotas.Add( Aliquota ) ;
        end ;
     end ;
   end ;
end;

procedure TACBrECFSweda.ProgramaAliquota(Aliquota: Double; Tipo: Char;
   Posicao : String);
Var ProxIndice : Integer ;
    ValStr : String ;
    Aliq : TACBrECFAliquota ;    
begin
  ValStr := IntToStrZero( Round(Aliquota * 100) ,4) ;
  Tipo := UpCase(Tipo) ;
  if Tipo <> 'S' then
     Tipo := 'T' ;

  CarregaAliquotas ;

  ProxIndice := StrToIntDef(Posicao,0) ;
  if (ProxIndice < 1) or (ProxIndice > 15) then { Indice passado é válido ? }
  begin
     For ProxIndice := 1 to 16 do  { Procurando Lacuna }
     begin
        if (AchaICMSIndice('T'+IntToStrZero(ProxIndice,2)) = nil) and
           (AchaICMSIndice('S'+IntToStrZero(ProxIndice,2)) = nil) then
           break ;
     end ;
  end ;

  if ProxIndice > 15 then
     raise Exception.create('Não há espaço para programar novas Aliquotas');

  EnviaComando( '33' + Tipo + IntToStrZero(ProxIndice,2) + ValStr ) ;

  { Adcionanodo nova Aliquota no ObjectList }
  Aliq := TACBrECFAliquota.create ;
  Aliq.Indice   := Tipo + IntToStrZero(ProxIndice,2) ;
  Aliq.Aliquota := Aliquota ;
  Aliq.Tipo     := Tipo ;
  fpAliquotas.Add( Aliq ) ;
end;


procedure TACBrECFSweda.CarregaFormasPagamento;  
Var RetCmd, Str, Descricao : String ;
    Cont, Inicio : Integer ;
    FPagto : TACBrECFFormaPagamento ;
    PermiteVinc : Boolean ;
    Ver : Double ; 
begin
  inherited CarregaFormasPagamento ;       {Inicializa fpFormasPagamentos}

  Str := '' ;
  Ver := StrToFloat(NumVersao) ;
  if fsModeloSweda < 'F' then
   begin
     Inicio := IfThen(Ver >= 1 ,36 ,72) ;     { Retorno da 0.3 é diferente }
     RetCmd := EnviaComando('29' + '5') ;
     if copy(RetCmd,1,3) = '.+T' then
     begin
        Str := Str + PadL(copy(RetCmd,81,1),1,'S') +
                     copy(RetCmd, Inicio   , 15) ;
        Str := Str + PadL(copy(RetCmd,82,1),1,'S') +
                     copy(RetCmd, Inicio+15, 15) ;
        Str := Str + PadL(copy(RetCmd,83,1),1,'S') +
                     copy(RetCmd, Inicio+30, 15) ;

        RetCmd := EnviaComando('29' + '6') ;
        if copy(RetCmd,1,3) = '.+T' then
        begin
           Str := Str + PadL(copy(RetCmd,113,1),1,'S') +
                        copy(RetCmd, 8 , 15) ;
           Str := Str + PadL(copy(RetCmd,114,1),1,'S') +
                        copy(RetCmd, 23, 15) ;
           Str := Str + PadL(copy(RetCmd,115,1),1,'S') +
                        copy(RetCmd, 38, 15) ;
           Str := Str + PadL(copy(RetCmd,116,1),1,'S') +
                        copy(RetCmd, 53, 15) ;
           Str := Str + PadL(copy(RetCmd,117,1),1,'S') +
                        copy(RetCmd, 68, 15) ;
           Str := Str + PadL(copy(RetCmd,118,1),1,'S') +
                        copy(RetCmd, 83, 15) ;
           Str := Str + PadL(copy(RetCmd,119,1),1,'S') +
                        copy(RetCmd, 98, 15) ;
        end ;
     end ;
   end
  else
   begin
     RetCmd := EnviaComando('29' + '5') ;
     if copy(RetCmd,1,3) = '.+T' then
     begin
        Str := Str + copy(RetCmd, 36, 48) ;

        RetCmd := EnviaComando('29' + '6') ;
        if copy(RetCmd,1,3) = '.+T' then
           Str := Str + copy(RetCmd, 8, 112) ;
     end ;
   end ;

  for Cont := 1 to 10 do
  begin
    Descricao   := UpperCase(TrimRight( copy(Str, (Cont * 16) - 15, 16) )) ;
    PermiteVinc := (copy(Descricao,1,1) = 'S') ;
    Descricao   := copy(Descricao,2,15) ;

    if Descricao <> '' then
    begin
       FPagto := TACBrECFFormaPagamento.create ;

       FPagto.Indice    := IntToStrZero(Cont,2) ;
       FPagto.Descricao := Descricao ;
       FPagto.PermiteVinculado := PermiteVinc ;

       fpFormasPagamentos.Add( FPagto ) ;
    end ;
  end
end;

procedure TACBrECFSweda.ProgramaFormaPagamento(var Descricao: String;
  PermiteVinculado: Boolean; Posicao : String);
Var ProxIndice, I : Integer ;
    FPagto : TACBrECFFormaPagamento ;
    Cmd, CmdIns : String ;
    TemVinculado : Boolean ;
begin
  if fsModeloSweda < 'F' then
     PermiteVinculado := true ;
     
  TemVinculado := (fsModeloSweda >= 'F') or (StrToFloat(NumVersao) > 1) ;

  CarregaFormasPagamento ;
  Cmd := '' ;
  { Sweda permite reprogramar Todas as FPG, por isso é preciso enviar uma String
    com as FPG já existentes... Criando String com as existentes}
  For I := 0 to FormasPagamento.Count - 1  do
  begin
     if TemVinculado then    { Modelos novos tem Flag de Vinculado }
        Cmd := Cmd + IfThen(FormasPagamento[I].PermiteVinculado,'S','N') ;
     Cmd := Cmd + padL(FormasPagamento[I].Descricao,15) ;
  end ;

  CmdIns := IfThen(TemVinculado, IfThen(PermiteVinculado,'S','N'),'') +
            padL(Descricao,15) ;

  ProxIndice := StrToIntDef(Posicao,0) ;
  if (ProxIndice < 1) or (ProxIndice > 10) then { Indice passado é válido ? }
     ProxIndice := 0 ;

  if ProxIndice = 0 then
     Cmd := Cmd + CmdIns
  else
     If TemVinculado then
        Cmd := StuffString(Cmd, (ProxIndice*16)-15,0, CmdIns )
     else
        Cmd := StuffString(Cmd, (ProxIndice*15)-14,0, CmdIns ) ;

  if Length(Cmd) > IfThen(TemVinculado,160,150) then
     raise Exception.create('Não há espaço para programar novas Formas de '+
                            'Pagamento');

  EnviaComando( '39' + Cmd ) ;

  { Adcionanodo nova FPG no ObjectList }
  FPagto := TACBrECFFormaPagamento.create ;
  FPagto.Indice    := IntToStrZero(FormasPagamento.Count,2) ;
  FPagto.Descricao := Descricao ;
  FPagto.PermiteVinculado := PermiteVinculado ;
  fpFormasPagamentos.Add( FPagto ) ;
end;

procedure TACBrECFSweda.CarregaComprovantesNaoFiscais;
Var RetCmd, Str, Descricao : String ;
    Cont : Integer ;
    CNF : TACBrECFComprovanteNaoFiscal ;
begin
  inherited CarregaComprovantesNaoFiscais ;{Inicializa fpComprovantesNaoFiscais}

  RetCmd := EnviaComando('29' + '7') ;
  if copy(RetCmd,1,3) <> '.+T' then exit ;
  Str := Str + copy(RetCmd, 8, 120) ;

  RetCmd := EnviaComando('29' + '8') ;
  if copy(RetCmd,1,3) <> '.+T' then exit ;
  Str := Str + copy(RetCmd, 8, 120) ;

  RetCmd := EnviaComando('29' + '9') ;
  if copy(RetCmd,1,3) <> '.+T' then exit ;
  Str := Str + copy(RetCmd, 8, 120) ;

  RetCmd := EnviaComando('29' + 'A') ;
  if copy(RetCmd,1,3) <> '.+T' then exit ;
  Str := Str + copy(RetCmd, 8, 120) ;

  RetCmd := EnviaComando('29' + 'B') ;
  if copy(RetCmd,1,3) <> '.+T' then exit ;
  Str := Str + copy(RetCmd, 8, 120) ;

  RetCmd := EnviaComando('29' + 'C') ;
  if copy(RetCmd,1,3) <> '.+T' then exit ;
  Str := Str + copy(RetCmd, 8, 120) ;

  RetCmd := EnviaComando('29' + 'D') ;
  if copy(RetCmd,1,3) <> '.+T' then exit ;
  Str := Str + copy(RetCmd, 8, 60) ;

  for Cont := 1 to 50 do
  begin
    Descricao := UpperCase(Trim( copy(Str, (Cont * 15) - 14, 15) )) ;

    if Descricao <> '' then
    begin
       CNF := TACBrECFComprovanteNaoFiscal.create ;

       if Cont = 1 then
          CNF.Indice := 'A '
       else if Cont = 2 then
          CNF.Indice := 'B '
       else
          CNF.Indice := IntToStrZero(Cont-2,2) ;
       CNF.Descricao := Descricao ;

       fpComprovantesNaoFiscais.Add( CNF ) ;
    end
  end ;
end;

procedure TACBrECFSweda.ProgramaComprovanteNaoFiscal(var Descricao: String;
  Tipo: String; Posicao : String);
Var ProxIndice, I : Integer ;
    CNF : TACBrECFComprovanteNaoFiscal ;
    Cmd : String ;
begin
  if Trim(Tipo) = '' then
     Tipo := '+' ;

  if (pos(Tipo,'&+-') = 0) or (Length(Tipo) > 1) then
     raise Exception.Create('Os Tipos válidos para Sweda são:'+sLineBreak+
                            '&  Criaçao de um novo Grupo (Titulo)'+sLineBreak+
                            '+  Entrada de Recursos'+sLineBreak+
                            '-  Saida de Recursos'+sLineBreak+sLineBreak+
                            'Dentro de um Grupo (titulo) deve ter'+sLineBreak+
                            'apenas legendas de mesmo sinal') ;

  CarregaComprovantesNaoFiscais ;
  Cmd := '' ;
  { Sweda permite reprogramar Todas as CNF, por isso é preciso enviar uma String
    com as CNF já existentes... Criando String com as existentes}
  For I := 2 to ComprovantesNaoFiscais.Count - 1  do
     Cmd := Cmd + padL(ComprovantesNaoFiscais[I].Descricao,15) ;

  ProxIndice := StrToIntDef(Posicao,0) ;
  if (ProxIndice < 1) or (ProxIndice > 50) then { Indice passado é válido ? }
     ProxIndice := 0 ;

  if ProxIndice = 0 then
     Cmd := Cmd + padL(Tipo + Descricao,15)
  else
     Cmd := StuffString(Cmd, (ProxIndice*15)-14,0, padL(Tipo + Descricao,15) ) ;

  if Length(Cmd) > 750 then
     raise Exception.create('Não há espaço para programar novos Comprovantes'+
                            ' não Fiscais');

  EnviaComando( '38' + 'N' + Cmd ) ;

  { Adcionanodo novo CNF no ObjectList }
  CNF := TACBrECFComprovanteNaoFiscal.create ;
  CNF.Indice    := IntToStrZero(ProxIndice,2) ;
  CNF.Descricao := Descricao ;
  fpComprovantesNaoFiscais.Add( CNF ) ;
end;


procedure TACBrECFSweda.AbreRelatorioGerencial;
begin
  EnviaComandoEspera( '13S' ,45 ) ;
end;

procedure TACBrECFSweda.LinhaRelatorioGerencial(Linha: String);
begin
  EnviaComando( '080' + padL(Linha,Colunas)) ;
end;

procedure TACBrECFSweda.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
Var Parcelas : String ;
begin
  Try
     COO := IntToStrZero(StrToInt(COO),4) ;
  except
     COO := '    ' ;
  end ;

  fsCMDVinculado := COO + CodFormaPagto ;
  Parcelas       := '' ;
  if fsModeloSweda >= 'F' then
     Parcelas := StringOfChar(' ',20) + '01' ;
//   Parcelas := StringOfChar(' ',20) + IntToStrZero(max(fsVinculado,1),2) ;

  EnviaComandoEspera( '1900' + fsCMDVinculado + Parcelas ,15 ) ;
end;

procedure TACBrECFSweda.LinhaCupomVinculado(Linha: String);
begin
  LinhaRelatorioGerencial( Linha ) ;
end;

procedure TACBrECFSweda.FechaRelatorio;
Var RetCmd,Status,Transacao,Cmd,Param : String ;
    P,I : Integer ;
begin

  RetCmd := EnviaComando( '28' ) ;
  P      := pos('!',RetCmd) ;
  if P > 0 then
  begin
     Param := '' ;
     I     := 07 ;
     if StrToFloat(NumVersao) >= 1 then
     begin
        I := 10 ;
        if fsModeloSweda <= 'F' then
           Param := 'NN'
        else
           Param := 'N' ;
     end ;

     { Status pode ser: C - concluida, P - Pendente, E - Erro no Comando }
     Status    := UpperCase(copy(RetCmd,I,1)) ;
     Transacao := UpperCase(Trim(copy(RetCmd,I+1,8))) ;
     Cmd       := Trim(copy(RetCmd,I+9,2)) ;

     if ((Status <> 'C') and (Transacao = 'N.FISCAL')) or
        ((Cmd = '08')    and (Transacao = 'VENDAS'))   then
        EnviaComandoEspera( '12' + Param, 9 )

     else if (Status <> 'C') and (Transacao = 'LEIT. X') then
        EnviaComandoEspera('08',9) ;
  end ;
end;

procedure TACBrECFSweda.ListaRelatorioGerencial(Relatorio: TStrings;
  Vias: Integer);
Var Imp, Linha : Integer ;
    Texto : String ;
    Bufferiza : Boolean ;
begin
// OBS: A SWEDA 1.0 e modelo < F, apenas inicia a impressão das Linhas do
// Relatório apos o envio do comando de Fechamento .08} por isso não há como
// fazer Pausa entre as vias a Mensagem enviada ao usuário também foi modificada
  Imp := 0 ;
  Bufferiza := (fsModeloSweda < 'F') and (StrToFloat(NumVersao) <= 1) ;

  while Imp < Vias do
  begin
    if Bufferiza then
       Texto :=  Format('Enviando %s  %dª Via ',['Relatório Gerêncial',Imp+1 ])
    else
       try
          Texto := Format(MsgRelatorio,['Relatório Gerêncial',Imp+1 ]) ;
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
        EnviaComando('089'+IntToStrZero(LinhasEntreCupons,1)) ;
        if not Bufferiza then
           PausarRelatorio( Imp ) ;
     end ;
  end ;

  if Bufferiza then
     PintaFormMsg( 'Imprimindo Relatório Gerencial' )
  else
     PintaFormMsg( 'Fechando Relatório Gerencial' );
     
   FechaRelatorio ;
end;

procedure TACBrECFSweda.ListaCupomVinculado(Relatorio: TStrings;
  Vias: Integer);
Var Imp, Linha : Integer ;
    Texto : String ;
    Bufferiza : Boolean ;
begin
// OBS: A SWEDA 1.0 e modelo < F, apenas inicia a impressão das Linhas do
// Relatório apos o envio do comando de Fechamento .08} por isso não há como
// fazer Pausa entre as vias a Mensagem enviada ao usuário também foi modificada
  Imp := 0 ;
  Bufferiza := (fsModeloSweda < 'F') and (StrToFloat(NumVersao) <= 1) ;

  if Bufferiza then
   begin
     while Imp < Vias do
     begin
        Texto :=  Format('Enviando %s  %dª Via ',['Cupom Vinculado',Imp+1 ]) ;
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
           EnviaComando('089'+IntToStrZero(LinhasEntreCupons,1)) ;
           EnviaComando('1900'+fsCMDVinculado) ;
        end ;
     end ;

     { Buffer já está cheio, imprimindo todas as vias}
     while Imp > 0 do
     begin
        FechaRelatorio ;

        if Imp > 1 then
           PausarRelatorio( Imp ) ;

        Imp := Imp - 1 ;
     end ;
   end
  else
   begin
     while Imp < Vias do
     begin
        try
           Texto := Format(MsgRelatorio,['Cupom Vinculado',Imp+1 ]) ;
        except
           Texto := MsgRelatorio ;
        end ;

        PintaFormMsg( Texto );
        Application.ProcessMessages ;

        if Imp = 0 then
         begin
           Linha := 0 ;
           while Linha <= ( Relatorio.Count - 1) do
           begin
              LinhaCupomVinculado( LeftStr( Relatorio[ Linha ], fpColunas) ) ;
              Linha := Linha + 1 ;

              if not BloqueiaMouseTeclado then
                 Application.ProcessMessages ;
           end ;
         end
        else
           EnviaComandoEspera('1900',10 + Round(Relatorio.Count * 1.5)) ;

        Imp := Imp + 1 ;
{       if Imp < Vias then
        begin
           EnviaComando('089'+IntToStrZero(LinhasEntreCupons,1)) ;
           PausarRelatorio( Imp ) ;
        end ;  }
     end ;

     PintaFormMsg( 'Fechando Cupom Vinculado' );
     FechaRelatorio ;
   end ;
end;

procedure TACBrECFSweda.PreparaTEF;
begin
  inherited PreparaTEF ;

  CarregaFormasPagamento ;
  CarregaComprovantesNaoFiscais ;
end;

procedure TACBrECFSweda.LeituraMemoriaFiscal(ReducaoInicial,
   ReducaoFinal: Integer);
Var Espera : Integer ;
begin
  Espera := 20 + (ReducaoFinal - ReducaoInicial) ;
  EnviaComandoEspera( '15'+IntToStrZero(ReducaoInicial,4)+
                     IntToStrZero(ReducaoFinal  ,4), Espera ) ;
end;

procedure TACBrECFSweda.LeituraMemoriaFiscal(DataInicial, DataFinal: TDateTime);
Var Espera : Integer ;
begin
  Espera := 20 + DaysBetween(DataInicial,DataFinal) ;
  EnviaComandoEspera( '16'+FormatDateTime('ddmmyy',DataInicial)+
                     FormatDateTime('ddmmyy',DataFinal),   Espera ) ;
end;

procedure TACBrECFSweda.LeituraMemoriaFiscalSerial(ReducaoInicial,
   ReducaoFinal: Integer; var Linhas : TStringList);
Var Ret : String ;
    wRetentar : Boolean ;
begin
  Linhas.Clear ;
  wRetentar := Retentar ;
  try
     Retentar := false ;
     Ret := EnviaComando( '15'+IntToStrZero(ReducaoInicial,4)+
                           IntToStrZero(ReducaoFinal  ,4) + '|', 15) ;

     while copy(Ret,1,5) = '.'+#10+#13+'.+' do
     begin
        Linhas.Add( Copy(Ret,10, Length(Ret)-10) ) ;
        try
           Ret := EnviaComando('++',10) ;
        except
           break ;
        end ;
     end ;
  finally
     Retentar := wRetentar ;
  end ;
end;

procedure TACBrECFSweda.LeituraMemoriaFiscalSerial(DataInicial,
  DataFinal: TDateTime; var Linhas : TStringList);
Var Ret : String ;
    wRetentar : Boolean ;
begin
  Linhas.Clear ;
  wRetentar := Retentar ;
  try
     Retentar := false ;
     Ret := EnviaComando( '16'+FormatDateTime('ddmmyy',DataInicial)+
                        FormatDateTime('ddmmyy',DataFinal) + '|' ,15 ) ;

     while copy(Ret,1,5) = '.'+#10+#13+'.+' do
     begin
        Linhas.Add( Copy(Ret,10, Length(Ret)-10) ) ;
        try
           Ret := EnviaComando('++',10) ;
        except
           break ;
        end ;
     end ;
  finally
     Retentar := wRetentar ;
  end ;
end;

function TACBrECFSweda.GetChequePronto: Boolean;
Var RetCmd : String ;
begin
  RetCmd := EnviaComando('23') ;
  Result := (copy( RetCmd, 5,1) = '0') ;
end;

procedure TACBrECFSweda.CancelaImpressaoCheque;
begin
  EnviaComando( '25' ) ;
end;

procedure TACBrECFSweda.ImprimeCheque(Banco: String; Valor: Double;
  Favorecido, Cidade: String; Data: TDateTime; Observacao: String);
Var Dia,Mes,Ano   : String ;
    Moeda, Moedas : String ;
begin
  Banco      := IntToStrZero(StrToIntDef(Banco,1),3) ;
  Favorecido := padL(Favorecido,80) ;
  Cidade     := padL(Cidade,30) ;
  Moeda      := padL('Real',20) ;
  Moedas     := padL('Reais',20) ;

  EnviaComando('44' + Favorecido + Cidade + Moeda + Moeda) ;

  Observacao := padL(Observacao,120) ;
  Dia        := IntToStrZero(  DayOf(Data),2) ;
  Mes        := IntToStrZero(MonthOf(Data),2) ;
  Ano        := RightStr(IntToStrZero( YearOf(Data),4),2) ;

  EnviaComando('24' + Banco + IntToStrZero(Round(Valor * 100),12) + ' ' +
               Observacao + '4' + Dia + Mes + Ano ) ;
end;

end.


