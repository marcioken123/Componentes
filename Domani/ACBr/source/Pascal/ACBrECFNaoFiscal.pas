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
|* 28/06/2004:  Daniel Simoes de Almeida
|*   Inicio do desenvolvimento
|* 31/05/2005:  Daniel Simoes de Almeida
|*   Variaveis Subtotal ou TotalPago poderiam, conter valores com mais de 2
|*   decimais, o que poderia causar problemas nas compara��es dos valores.
|*   -  Bug reportado por Licerio Jose Rodrigues Neto
******************************************************************************}

{$I ACBr.inc}

unit ACBrECFNaoFiscal ;

interface
uses ACBrECFClass, ACBrUtil, 
     Classes, Contnrs, Math, SysUtils, DateUtils, IniFiles,  
     {$IFDEF VisualCLX} QControls, QForms, QDialogs {$ENDIF}
     {$IFDEF VCL} Controls, Forms, Dialogs {$ENDIF} ;

const CRLF = #13+#10 ;
      cCmdImpCondensado = #15 ;
      cCmdImpExpandidoUmaLinha = #14 ;
      cCmdImpZera = #27+'@' ;

type

TACBrECFNaoFiscalAliquota = class
 private
    fsAliquota: Double ;
    fsISS: Boolean;
    fsTotalDia: Double;
    fsDescricao: String;
 public
    property Aliquota  : Double  read fsAliquota write fsAliquota ;
    property Descricao : String  read fsDescricao write fsDescricao ;
    property Iss       : Boolean read fsISS      write fsISS ;
    property TotalDia  : Double  read fsTotalDia write fsTotalDia ;
end;

TACBrECFNaoFiscalFormaPagamento = class
 private
    fsDescricao: String;
    fsTotalDia: Double;
    fsIndice: String;
 public
    property Indice    : String read fsIndice    write fsIndice ;
    property Descricao : String read fsDescricao write fsDescricao ;
    property TotalDia  : Double  read fsTotalDia write fsTotalDia ;
end;

TACBrECFNaoFiscalComprovanteNaoFiscal = class
 private
    fsDescricao: String;
    fsTotalDia: Double;
    fsIndice: String;
 public
    property Indice    : String read fsIndice    write fsIndice ;
    property Descricao : String read fsDescricao write fsDescricao ;
    property TotalDia  : Double  read fsTotalDia write fsTotalDia ;
end;

TACBrECFNaoFiscalItemCupom = class
 private
    fsDescricao: String;
    fsValorUnit: Double;
    fsQtd: Double;
    fsPosAliq: Integer;
    fsCodigo: String;
    fsBaseICMS: Double;
 public
    property Codigo    : String  read fsCodigo    write fsCodigo    ;
    property Descricao : String  read fsDescricao write fsDescricao ;
    property Qtd       : Double  read fsQtd       write fsQtd       ;
      { Se Qtd = 0 Item foi cancelado }
    property ValorUnit : Double  read fsValorUnit write fsValorUnit ;
    property PosAliq   : Integer read fsPosAliq   write fsPosAliq   ;
    property BaseICMS  : Double  read fsBaseICMS  write fsBaseICMS  ;
end;

TACBrECFNaoFiscalPagamentoCupom = class
 private
    fsValorPago: Double;
    fsPosFPG: Integer;
 public
    property PosFPG    : Integer read fsPosFPG    write fsPosFPG   ;
    property ValorPago : Double  read fsValorPago write fsValorPago;
end;

{ Classe filha de TACBrECFClass com implementa�ao para NaoFiscal }
TACBrECFNaoFiscal = class( TACBrECFClass )
 private
    fsNomeArqINI: String;
    fsArqBuf    : TextFile;
    fsBuffer    : TStringList ;
    fsArqINI    : String ;
    fsNumSerie  : String ;
    fsNumECF    : String ;
    fsCRO       : Integer ;
    fsCabecalho : TStringList ;
    fsCabecalhoItem : TStringList ;
    fsMascaraItem : String ;
    fsGavetaCmd : String ;
    fsVERAO     : Boolean ;
    fsDia       : TDateTime ;
    fsReducoesZ : Integer ;
    fsLeiturasX : Integer ;
    fsCuponsCancelados : Integer ;
    fsCOOInicial : Integer ;
    fsCOOFinal   : Integer ;
    fsNumCupom   : Integer ;
    fsSubTotal   : Double ;
    fsTotalPago  : Double ;

    fsAliquotas              : TObjectList ;
    fsFormasPagamento        : TObjectList ;
    fsComprovantesNaoFiscais : TObjectList ;
    fsItensCupom             : TObjectList ;
    fsPagamentosCupom        : TObjectList ;

    fswVERAO     : Boolean ;
    fswDia       : TDateTime ;
    fswESTADO    : TACBrECFEstado ;
    fswReducoesZ : Integer ;
    fswLeiturasX : Integer ;
    fswCuponsCancelados : Integer ;
    fswCOOInicial : Integer ;
    fswCOOFinal   : Integer ;
    fswNumCupom   : Integer ;
    fswSubTotal   : Double ;
    fswTotalPago  : Double ;

    fswAliquotas              : TObjectList ;
    fswFormasPagamento        : TObjectList ;
    fswComprovantesNaoFiscais : TObjectList ;
    fswItensCupom             : TObjectList ;
    fswPagamentosCupom        : TObjectList ;

    fsCmdImpCondensado: String;
    fsCmdImpExpandidoUmaLinha: String;
    fsCmdImpZera: String;

    Procedure CopyAliquotas( FromObjectList, ToObjectList : TObjectList ) ;
    Procedure CopyFormasPagamento( FromObjectList, ToObjectList : TObjectList );
    Procedure CopyComprovantesNaoFiscais( FromObjectList, ToObjectList :
       TObjectList );
    Procedure CopyItensCupom( FromObjectList, ToObjectList : TObjectList );
    Procedure CopyPagamentosCupom( FromObjectList, ToObjectList : TObjectList );

    Function StringToAsc( AString : String ) : String ;
    Function AscToString( AString : String ) : String ;
    Function StuffMascaraItem( Linha : String; Letra : Char;
       TextoInserir : String) : String ;
    Procedure SalvaEstadoAtual ;
    Procedure RestauraEstadoAnterior ;
    Procedure AvisoLegal ;
    procedure LeArqINI ;
    procedure GravaArqINI ;
    procedure SetNomeArqINI(const Value: String);
    procedure AbreBuffer ;
    procedure GravaBuffer ;
    procedure ZeraBuffer ;
    procedure ImprimeBuffer ;
    procedure ImprimePorta( AString : String ) ; overload ;
    procedure ImprimePorta( AStringList : TStringList ) ; overload ;
    Procedure AddBufferRelatorio ;
    Procedure AddBufferRodape ;
    Procedure InsertCabecalho( AStringList : TStringList ) ;
    Procedure AddBufferCabecalho_Item ;
    Procedure ListaLeituraX( Est : TACBrECFEstado );
    Procedure AbreDocumento(AbreDia : Boolean = false) ;

    function AchaFPGIndiceNaoFiscal( Indice: String) : Integer ;
    function AchaICMSAliquotaNaoFiscal(Aliquota: Double): Integer ;

 protected
    function GetNumCupom: String; override ;
    function GetNumECF: String; override ;
    function GetNumCRO: String; override ;
    function GetNumSerie: String; override ;
    function GetNumVersao: String; override ;
    function GetSubTotal: Double; override ;
    function GetTotalPago: Double; override ;

    function GetEstado: TACBrECFEstado; override ;
    function GetHorarioVerao: Boolean; override ;
    function GetArredonda : Boolean; override ;

    procedure ListaRelatorioGerencial(Relatorio : TStrings; Vias : Integer = 1);
       override ;
    Procedure ListaCupomVinculado( Relatorio : TStrings; Vias : Integer = 1) ;
      override ;

 public
    Constructor create( AOwner : TComponent  )  ;
    Destructor Destroy  ; override ;

    { Propriedades Publicas de ACBrECFNaoFiscal }
    property CmdImpCondensado : String read fsCmdImpCondensado
       write fsCmdImpCondensado ;
    property CmdImpExpandidoUmaLinha : String read fsCmdImpExpandidoUmaLinha
       write fsCmdImpExpandidoUmaLinha ;
    property CmdImpZera : String read fsCmdImpZera write fsCmdImpZera ;
    property GavetaCmd  : String read fsGavetaCmd write fsGavetaCmd ;
    property NomeArqINI : String read fsNomeArqINI write SetNomeArqINI ;

    procedure Ativar ; override ;
    procedure Desativar ; override ;
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

    Procedure MudaHorarioVerao  ; override ;

    Procedure AbreGaveta ; override ;

    procedure CarregaAliquotas ; override ;
    Procedure ProgramaAliquota( Aliquota : Double; Tipo : Char = 'T';
       Posicao : String = '') ; override ;
    function AchaICMSAliquota( Aliquota : Double ) : TACBrECFAliquota ; override;

    procedure CarregaFormasPagamento ; override ;
    function AchaFPGDescricao( Descricao : String ) : TACBrECFFormaPagamento ;
       override ;
    Procedure ProgramaFormaPagamento( var Descricao: String;
       PermiteVinculado : Boolean = true; Posicao : String = '' ) ; override ;

    procedure CarregaComprovantesNaoFiscais ; override ;
    function AchaCNFDescricao( Descricao : String ) :
       TACBrECFComprovanteNaoFiscal ; override ;
    Procedure ProgramaComprovanteNaoFiscal( var Descricao: String;
       Tipo : String = ''; Posicao : String = '') ; override ;
 end ;

implementation
Uses ACBrBase ;

{ ----------------------------- TDJECFNaoFiscal ------------------------------ }

constructor TACBrECFNaoFiscal.create( AOwner : TComponent ) ;
begin
  inherited create( AOwner ) ;

  fpDevice.HandShake := hsRTS_CTS ;
  
  { Variaveis internas dessa classe }
  fsArqINI    := '' ;
  fsNumSerie  := '' ;
  fsNumECF    := '' ;
  fsCRO       := 1 ;
  fpModeloStr := 'NaoFiscal' ;
  fsBuffer    := TStringList.create ;

  fsCabecalho := TStringList.create ;
  fsCabecalho.add('Nome da Empresa') ;
  fsCabecalho.add('Nome da Rua , 1234  -  Bairro') ;
  fsCabecalho.add('Cidade  -  UF  -  99999-999') ;
  fsCabecalho.add('CNPJ: 01.234.567/0001-22    IE: 012.345.678.90') ;

  fsCabecalhoItem := TStringList.create ;
  fsCabecalhoItem.Add('ITEM   CODIGO             DESCRICAO') ;
  fsCabecalhoItem.Add('.             QTDxUNITARIO   Aliq    VALOR (R$)') ;
  fsCabecalhoItem.Add( StringOfChar('-',Colunas) ) ;
  
  fsMascaraItem := 'III CCCCCCCCCCCCC DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD '+
                   'QQQQQQQQ UUxVVVVVVVVV AAAAAAA TTTTTTTTTTT' ;
  fsGavetaCmd := '' ;
  fsVERAO     := false ;
  fsDia       := now ;
  fsReducoesZ := 0 ;
  fsLeiturasX := 0;
  fsCOOInicial:= 0 ;
  fsCOOFinal  := 0 ;
  fsNumCupom  := 0 ;
  fsSubTotal  := 0 ;
  fsTotalPago := 0 ;
  fsCuponsCancelados := 0 ;

  fsCmdImpCondensado        := cCmdImpCondensado ;
  fsCmdImpExpandidoUmaLinha := cCmdImpExpandidoUmaLinha ;
  fsCmdImpZera              := cCmdImpZera ;

  fsAliquotas               := TObjectList.Create( true );
  fsFormasPagamento         := TObjectList.Create( true );
  fsComprovantesNaoFiscais  := TObjectList.Create( true );
  fsItensCupom              := TObjectList.Create( true );
  fsPagamentosCupom         := TObjectList.Create( true );

  fswAliquotas              := TObjectList.Create( true );
  fswFormasPagamento        := TObjectList.Create( true );
  fswComprovantesNaoFiscais := TObjectList.Create( true );
  fswItensCupom             := TObjectList.Create( true );
  fswPagamentosCupom        := TObjectList.Create( true );

  SalvaEstadoAtual ;
end;

destructor TACBrECFNaoFiscal.Destroy;
begin
  fsCabecalho.Free ;
  fsCabecalhoItem.Free ;

  fsAliquotas.Free ;
  fsFormasPagamento.Free ;
  fsComprovantesNaoFiscais.Free ;
  fsItensCupom.Free ;
  fsPagamentosCupom.Free ;

  fswAliquotas.Free ;
  fswFormasPagamento.Free ;
  fswComprovantesNaoFiscais.Free ;
  fswItensCupom.Free ;
  fswPagamentosCupom.Free ;

  fsBuffer.Free ;
  Desativar ;

  inherited Destroy ;
end;

procedure TACBrECFNaoFiscal.Ativar;
Var NumECF : Integer ;
begin
  inherited Ativar ; { Abre porta serial / paralela ou arquivo }

  fsNumSerie := '' ;
  fsNumECF   := '' ;
  fsCRO      := 1 ;

  try
     if NomeArqINI <> '' then
        fsArqINI := NomeArqINI
    else
       begin
        NumECF   := Max(fpDevice.Tag, 1) ;
        fsNumECF := IntToStrZero( NumECF, 3 ) ;
        fsArqINI := ExtractFilePath(Application.ExeName)+'ACBrECF'+fsNumECF+'.INI';
      end ;

     LeArqINI ;

     if fpDevice.IsSerialPort then
        fpDevice.Serial.Purge ;

     if not EmLinha() then
        raise Exception.Create('Impressora: '+ModeloStr+' n�o est� pronta.') ;

     AbreBuffer ;

     ImprimePorta( CmdImpZera + CmdImpCondensado );

     if fsBuffer.Count > 0 then
        ImprimeBuffer ;
  except
     Desativar ;
     raise ;
  end ;
end;

procedure TACBrECFNaoFiscal.Desativar;
begin
  try
     CloseFile( fsArqBuf ) ;
  except
  end ;

  inherited Desativar ;
end;

Function TACBrECFNaoFiscal.EnviaComando( cmd : String ) : String ;
begin
  ImprimePorta( cmd );
  result := '' ;
end;

function TACBrECFNaoFiscal.GetNumCupom: String;
begin
  Result := IntToStrZero( fsNumCupom, 6 ) ;
end;

function TACBrECFNaoFiscal.GetNumECF: String;
begin
  Result := fsNumECF ;
end;

function TACBrECFNaoFiscal.GetNumSerie: String;
begin
  Result := fsNumSerie ;
end;

function TACBrECFNaoFiscal.GetNumCRO: String;
begin
  Result := IntToStrZero(fsCRO,3) ;
end;

function TACBrECFNaoFiscal.GetNumVersao: String ;
begin
  Result := ACBR_VERSAO ;
end;

function TACBrECFNaoFiscal.GetTotalPago: Double;
begin
  Result := RoundTo( fsTotalPago,-2) ;
end;

function TACBrECFNaoFiscal.GetSubTotal: Double;
begin
  Result := RoundTo( fsSubTotal,-2) ;
end;

procedure TACBrECFNaoFiscal.ListaLeituraX( Est : TACBrECFEstado );
Var A : Integer ;
begin
  if Estado <> estRequerX then
     TestaPodeAbrirCupom ;

  ZeraBuffer ;
  fsBuffer.Add( fsCmdImpExpandidoUmaLinha +
                padC('LEITURA X',IfThen(fsCmdImpExpandidoUmaLinha='',Colunas,
                Round(Colunas/2))) ) ;
  AddBufferRelatorio ;

  if Est = estRelatorio then
     For A := 1 to LinhasEntreCupons do
        fsBuffer.Delete(fsBuffer.Count-1) ;
        
  SalvaEstadoAtual ;
  
  fsItensCupom.Clear ;
  fsPagamentosCupom.Clear ;
  fsLeiturasX := fsLeiturasX + 1 ;
  fsTotalPago := 0 ;
  fsSubTotal  := 0 ;
  fpESTADO    := Est ;

  try
     AbreDocumento ;
  except
     RestauraEstadoAnterior ;
     raise ;
  end ;
end;

Procedure TACBrECFNaoFiscal.LeituraX ;
begin
  ListaLeituraX( estLivre );
end;

Procedure TACBrECFNaoFiscal.AbreGaveta ;
begin
  ImprimePorta( fsGavetaCmd );
end;

Procedure TACBrECFNaoFiscal.ReducaoZ(DataHora: TDateTime) ;
var A : Integer ;
begin
  if Estado = estBloqueada then
     raise Exception.Create('Dia j� foi fechado. Redu��o Z j� emitida') ;

  if not (Estado in [estLivre,estRequerZ]) then
     raise Exception.create('O Estado da Impressora n�o � "LIVRE" Cancele o '+
                            '�ltimo Documento') ;

  ZeraBuffer ;
  fsBuffer.Add( fsCmdImpExpandidoUmaLinha +
                padC('REDUCAO Z',IfThen(fsCmdImpExpandidoUmaLinha='',Colunas,
                Round(Colunas/2))) ) ;
  AddBufferRelatorio ;

  SalvaEstadoAtual ;

  fsItensCupom.Clear ;
  fsPagamentosCupom.Clear ;
  fsReducoesZ := fsReducoesZ + 1 ;
  if fpEstado = estRequerZ then
   begin
     fpEstado := estLivre ;
     fsDia    := now ;
   end 
  else
     fpEstado := estBloqueada ;

  fsTotalPago := 0 ;
  fsSubTotal  := 0 ;
  fsCuponsCancelados := 0 ;

  For A := 0 to fsAliquotas.Count - 1 do
     TACBrECFNaoFiscalAliquota( fsAliquotas[A]).TotalDia := 0 ;

  For A := 0 to fsFormasPagamento.Count - 1 do
     TACBrECFNaoFiscalFormaPagamento( fsFormasPagamento[A]).TotalDia := 0 ;

  For A := 0 to fsComprovantesNaoFiscais.Count - 1 do
     TACBrECFNaoFiscalComprovanteNaoFiscal( fsComprovantesNaoFiscais[A]).
        TotalDia := 0 ;

  try
     AbreDocumento( true ) ;
  except
     RestauraEstadoAnterior ;
     raise ;
  end ;

end;

Procedure TACBrECFNaoFiscal.MudaHorarioVerao ;
begin
  fsVERAO := not fsVERAO ;

  try
     GravaArqINI ;
  except
     fsVERAO := not fsVERAO ;
     raise ;
  end ;
end;

procedure TACBrECFNaoFiscal.AbreCupom(CPF_CNPJ: String);
begin
  TestaPodeAbrirCupom ;

  ZeraBuffer ;
  CPF_CNPJ := trim(CPF_CNPJ) ;
  if CPF_CNPJ <> '' then
  begin
     fsBuffer.Add( StringofChar('-',Colunas) ) ;
     fsBuffer.Add(padL('CPF/CNPJ Consumidor: '+CPF_CNPJ,Colunas)) ;
     fsBuffer.Add( StringofChar('-',Colunas) ) ;
  end ;
  AddBufferCabecalho_Item ;

  SalvaEstadoAtual ;

  fsItensCupom.Clear ;
  fsPagamentosCupom.Clear ;
  fsTotalPago := 0 ;
  fsSubTotal  := 0 ;
  fpESTADO    := estVenda ;

  try
     AbreDocumento ;
  except
     RestauraEstadoAnterior ;
     raise ;
  end ;
end;

procedure TACBrECFNaoFiscal.CancelaCupom;
Var A : Integer ;
begin

  if (fsItensCupom.Count = 0) and (Estado <> estVenda) then
     raise Exception.Create('�ltimo Documento n�o � Cupom') ;

  ZeraBuffer ;
  
  fsBuffer.Add( fsCmdImpExpandidoUmaLinha +
                padC('*** CUPOM CANCELADO ***',
                     IfThen(fsCmdImpExpandidoUmaLinha='',Colunas,
                            Round(Colunas/2))) ) ;
  SalvaEstadoAtual ;

  case Estado of
    estVenda : 
       begin
          fsBuffer.Insert(0, fsCmdImpExpandidoUmaLinha +
                padS('TOTAL  R$|'+FormatFloat('#,###,##0.00',Subtotal),
                     IfThen(fsCmdImpExpandidoUmaLinha='',Colunas,
                            Round(Colunas/2)) ,'|') ) ;
          AddBufferRodape ;
       end ;

    estPagamento :
       AddBufferRodape ;

  else
   begin
     fsNumCupom := fsNumCupom + 1 ;

     InsertCabecalho( fsBuffer );

     fsBuffer.Add( padS('COO do Cupom Cancelado:|'+IntToStrZero(fsNumCupom-1,6),
                        Colunas,'|') ) ;
     fsBuffer.Add( padS('Valor da Operacao  R$:|'+
                         FormatFloat('#,###,##0.00',Subtotal),Colunas,'|') );
     fsBuffer.Add( '' ) ;
     fsBuffer.Add( 'Nome do Consumidor:' ) ;
     fsBuffer.Add( '' ) ;
     fsBuffer.Add( 'Telefone do Cosumidor:' ) ;
     fsBuffer.Add( '' ) ;

     AddBufferRodape ;
   end ;
  end;

  fsCuponsCancelados := fsCuponsCancelados + 1 ;
  { Removendo do TotalDiario por Aliquotas }
  For A := 0 to fsItensCupom.Count - 1 do
     with TACBrECFNaoFiscalItemCupom( fsItensCupom[A] ) do
        with TACBrECFNaoFiscalAliquota( fsAliquotas[ PosAliq ] ) do
           TotalDia := max( RoundTo(TotalDia - BaseICMS,-2),0) ;

  { Removendo do TotalDiario por Pagamento }
  For A := 0 to fsPagamentosCupom.Count - 1 do
     with TACBrECFNaoFiscalPagamentoCupom( fsPagamentosCupom[A] ) do
        with TACBrECFNaoFiscalFormaPagamento( fsFormasPagamento[ PosFPG ] ) do
           TotalDia := max( RoundTo(TotalDia - ValorPago,-2),0) ;

  fsItensCupom.Clear ;
  fsPagamentosCupom.Clear ;
  fpEstado   := estLivre ;
  fsSubTotal := 0 ;

  try
     GravaBuffer ;
     try
        GravaArqINI ;
        ImprimeBuffer
     finally
        ZeraBuffer ;
     end ;
  except
     RestauraEstadoAnterior ;
     raise ;
  end ;

end;

procedure TACBrECFNaoFiscal.CancelaItemVendido(NumItem: Integer);
begin
  if Estado <> estVenda then
     raise Exception.create('O Estado da Impressora nao � "VENDA"') ;

  if fsItensCupom.Count = 0 then
     raise Exception.create('Nenhum Item foi vendido ainda') ;

  if (NumItem < 1) or (NumItem > fsItensCupom.Count) then
     raise Exception.create('Item ('+IntToStrZero(NumItem,3)+') fora da Faixa.') ;

  if TACBrECFNaoFiscalItemCupom( fsItensCupom[NumItem-1] ).Qtd = 0 then
     raise Exception.create('Item ('+IntToStrZero(NumItem,3)+
                            ') j� foi cancelado.') ;

  ZeraBuffer ;
  fsBuffer.Add( 'CANECELADO ITEM: '+IntToStrZero( NumItem,3) ) ;

  ImprimeBuffer ;
  SalvaEstadoAtual ;

  try
     with TACBrECFNaoFiscalItemCupom( fsItensCupom[NumItem-1] ) do
     begin
        fsSubTotal := RoundTo(Subtotal - (Qtd * ValorUnit ),-2) ;
        Qtd := 0 ;

        with TACBrECFNaoFiscalAliquota( fsAliquotas[PosAliq] ) do
           TotalDia := max( RoundTo(TotalDia - BaseICMS,-2),0) ;
     end ;

     GravaArqINI ;
  except
     RestauraEstadoAnterior ;
  end ;

end;

procedure TACBrECFNaoFiscal.EfetuaPagamento(CodFormaPagto: String;
  Valor: Double; Observacao: String; ImprimeVinculado: Boolean);
Var FPG    : TACBrECFNaoFiscalFormaPagamento ;
    PosFPG : Integer ;
    Troco  : Double ;
    UltLin : String ;
    Pagto  : TACBrECFNaoFiscalPagamentoCupom ;
begin
  inherited EfetuaPagamento(CodFormaPagto, Valor, Observacao, ImprimeVinculado);

  if Estado <> estPagamento then
     raise Exception.create('O Estado da Impressora nao � "PAGAMENTO"') ;

  if TotalPago >= SubTotal then
     raise Exception.create('Total pago j� foi atingido Cupom deve ser '+
                            'encerrado') ;

  PosFPG := AchaFPGIndiceNaoFiscal( CodFormaPagto ) ;
  try
     if PosFPG < 0 then
        raise Exception.create('')  ;

     FPG := TACBrECFNaoFiscalFormaPagamento( fsFormasPagamento[ PosFPG ] ) ;
  except
     raise Exception.create('Forma de Pagamento '+CodFormaPagto+' Inv�lida') ;
  end ;

  ZeraBuffer ;
  fsBuffer.Add( padS(FPG.Descricao+'|'+
                FormatFloat('#,###,##0.00',Valor),Colunas,'|') ) ;

  while Observacao <> '' do
  begin
     fsBuffer.Add( copy(Observacao,1,Colunas) ) ;
     Observacao := copy(Observacao,Colunas + 1,length(Observacao) ) ;
  end ;

  if RoundTo(TotalPago + Valor,-2) >= SubTotal then   { Ultrapassou o Valor do Cupom }
  begin
     UltLin := padS('VALOR RECEBIDO  R$|'+FormatFloat('#,###,##0.00',
                    RoundTo(TotalPago + Valor,-2)),Colunas,'|') ;

     if RoundTo(TotalPago + Valor,-2) > SubTotal then  { Tem TROCO ? }
     begin
        fsBuffer.Add( UltLin ) ;
        Troco  := RoundTo((TotalPago + Valor) - SubTotal,-2) ;
        UltLin :=  fsCmdImpExpandidoUmaLinha +
                   padS('TROCO  R$|'+FormatFloat('#,###,##0.00',Troco),
                     IfThen(fsCmdImpExpandidoUmaLinha='',Colunas,
                            Round(Colunas/2)) ,'|') ;
     end ;
     
     UltLin := StringReplace( UltLin,' ','_',[rfReplaceAll]) ;
     fsBuffer.Add( UltLin ) ;
  end ;

  ImprimeBuffer ;
  SalvaEstadoAtual ;

  try
     fsTotalPago  := RoundTo(TotalPago  + Valor,-2) ;
     FPG.TotalDia := RoundTo(FPG.TotalDia + Valor,-2) ;

     Pagto := TACBrECFNaoFiscalPagamentoCupom.Create ;
     Pagto.PosFPG    := PosFPG ;
     Pagto.ValorPago := Valor ;
     fsPagamentosCupom.Add( Pagto ) ;

     GravaArqINI ;
  except
     RestauraEstadoAnterior ;
  end ;
end;

procedure TACBrECFNaoFiscal.FechaCupom(Observacao: String);
var wEstado : TACBrECFEstado ;
begin
  if Estado <> estPagamento then
     raise Exception.create('O Estado da Impressora nao � "PAGAMENTO"'+
                            'N�o houve SubTotal') ;

  if TotalPago < SubTotal then
     raise Exception.create('Total Pago � inferior ao Total do Cupom') ;

  Observacao := StringReplace(Observacao,#10,CRLF,[rfReplaceAll]) ;

  ZeraBuffer ;
  fsBuffer.Add( Observacao ) ;
  AddBufferRodape ;

  ImprimeBuffer ;
  wEstado := Estado ;

  try
     fpEstado := estLivre ;

     GravaArqINI ;
  except
     fpEstado := wEstado ;
  end ;
end;

procedure TACBrECFNaoFiscal.SubtotalizaCupom(DescontoAcrescimo: Double);
Var Taxa, ValTaxa : Double ;
    S    : String ;
    A    : Integer ;
begin
  if Estado <> estVenda then
     raise Exception.create('O Estado da Impressora nao � "VENDA"'+
                            ' Cupom n�o Aberto') ;
  if SubTotal <= 0 then
     raise Exception.create('Nenhum Item foi vendido ainda') ;

  ZeraBuffer ;

  Taxa := 0 ;
  if DescontoAcrescimo <> 0 then
  begin
     Taxa := abs(DescontoAcrescimo) / SubTotal ;
     if DescontoAcrescimo < 0 then
        S := 'Desconto '
     else
        S := 'Acrescimo' ;
        
     fsBuffer.Add( padS('SUBTOTAL   R$|'+
                   FormatFloat('#,###,##0.00',SubTotal), Colunas,'|') ) ;
     fsBuffer.Add( padS(S+'  R$|'+FormatFloat('#,###,##0.00',DescontoAcrescimo),
                        Colunas,'|') ) ;
  end ;

  fsBuffer.Add(  fsCmdImpExpandidoUmaLinha +
                   padS('TOTAL  R$|'+FormatFloat('#,###,##0.00',
                        SubTotal+DescontoAcrescimo),
                        IfThen(fsCmdImpExpandidoUmaLinha='',Colunas,
                            Round(Colunas/2)) ,'|') ) ;
  ImprimeBuffer ;
  SalvaEstadoAtual ;

  try
     if Taxa <> 0 then  { Aplicando DESCONTO/ACRECIMO em ALIQUOTAS por % }
     begin
        For A := 0 to fsItensCupom.Count - 1 do
        begin
           with TACBrECFNaoFiscalItemCupom( fsItensCupom[A] ) do
           begin
              ValTaxa := Qtd * ValorUnit * Taxa *
                         IfThen(DescontoAcrescimo < 0,-1,1) ;
              BaseICMS := RoundTo(BaseICMS + ValTaxa,-2) ;
              with TACBrECFNaoFiscalAliquota( fsAliquotas[ PosAliq ] ) do
              begin
                 TotalDia := RoundTo(TotalDia + ValTaxa,-2) ;
              end ;
           end ;
        end ;
     end ;

     fsSubTotal  := RoundTo( SubTotal + DescontoAcrescimo,-2) ;
     fpEstado    := estPagamento ;
     fsTotalPago := 0 ;

     GravaArqINI ;
  except
     RestauraEstadoAnterior ;
  end ;

end;

procedure TACBrECFNaoFiscal.VendeItem(Codigo, Descricao: String;
  AliquotaICMS : String; Qtd: Double; ValorUnitario: Double;
  DescontoPorc: Double; Unidade: String);
Var PosAliq : Integer ;
    Aliq : TACBrECFNaoFiscalAliquota ;
    ItemCupom : TACBrECFNaoFiscalItemCupom ;
    StrQtd,StrPreco,Linha : String ;
    ValAliq, ValDesc, Total : Double ;
begin

  if Estado <> estVenda then
     raise Exception.create('O Estado da Impressora nao � "VENDA"'+
                            ' Cupom n�o Aberto') ;

  if (Qtd <= 0) or (ValorUnitario <= 0) or (Descricao = '') or (Codigo = '') then
     raise Exception.create('Erro. Par�metros inv�lidos') ;

  AliquotaICMS := UpperCase( Trim( AliquotaICMS ) ) ;
  case AliquotaICMS[1] of
     'F' : PosAliq := 0 ;
     'I' : PosAliq := 1 ;
     'N' : PosAliq := 2 ;
     'T' : PosAliq := StrToIntDef(copy(AliquotaICMS,2,2),0) ; {Indice}
  else
   begin
     ValAliq := StrToIntDef( AliquotaICMS, 0 ) ;
     PosAliq := AchaICMSAliquotaNaoFiscal( ValAliq ) ;
     if (PosAliq < 0) and (ValAliq > 0) then
     begin
        AchaICMSAliquota( ValAliq ) ;
        PosAliq := AchaICMSAliquotaNaoFiscal( ValAliq ) ;
     end ;
   end ;
  end;

  try
     if PosAliq < 0 then
        raise Exception.create('')  ;

     Aliq := TACBrECFNaoFiscalAliquota( fsAliquotas[ PosAliq ] ) ;
  except
     raise Exception.create('Aliquota '+AliquotaICMS+' Inv�lida') ;
  end ;

  AliquotaICMS := padC(AliquotaICMS,7) ;

  if Qtd = Round( Qtd ) then
     StrQtd := FormatFloat('#######0',Qtd ) 
  else
     StrQtd := FormatFloat('###0.000',Qtd ) ;

  if RoundTo( ValorUnitario, -2 ) = ValorUnitario then
     StrPreco := FormatFloat('#####0.00',ValorUnitario )
  else
     StrPreco := FormatFloat('####0.000',ValorUnitario ) ;

  Total := RoundTo( Qtd * ValorUnitario, -2) ;

  { Inserindo na String da fsMascaraItem }
  Linha := fsMascaraItem ;
  Linha := StuffMascaraItem( Linha, 'I', IntToStrZero(fsItensCupom.Count+1,3)) ;
  Linha := StuffMascaraItem( Linha, 'C', Codigo ) ;
  Linha := StuffMascaraItem( Linha, 'D', Descricao ) ;
  Linha := StuffMascaraItem( Linha, 'Q', StrQtd ) ;
  Linha := StuffMascaraItem( Linha, 'U', Unidade ) ;
  Linha := StuffMascaraItem( Linha, 'V', StrPreco ) ;
  Linha := StuffMascaraItem( Linha, 'A', AliquotaICMS ) ;
  Linha := StuffMascaraItem( Linha, 'T', FormatFloat('###,##0.00', Total ) ) ;

  { Quebrando a linha pela COLUNA }
  Linha := Trim( Linha ) ;
  while Linha <> '' do
  begin
     fsBuffer.Add( copy(Linha,1,Colunas) ) ;
     Linha := copy(Linha,Colunas + 1,length(Linha) ) ;
  end ;

  if DescontoPorc > 0 then
  begin
     ValDesc := RoundTo(Total * (DescontoPorc / 100), -3) ;
     Total   := RoundTo(Total - ValDesc, -2) ;

     fsBuffer.Add( padS('|DESCONTO|'+FormatFloat('#0.00', DescontoPorc)+'%|R$ '+
                       FormatFloat('##,##0.00',-ValDesc)+'|'+
                       FormatFloat('###,##0.00',Total),Colunas,'|') ) ;
  end ;

  ImprimeBuffer ;
  SalvaEstadoAtual ;

  try
     ItemCupom := TACBrECFNaoFiscalItemCupom.Create ;

     ItemCupom.Codigo    := Codigo ;
     ItemCupom.Descricao := Descricao ;
     ItemCupom.Qtd       := Qtd ;
     ItemCupom.ValorUnit := ValorUnitario ;
     ItemCupom.PosAliq   := PosAliq ;
     ItemCupom.BaseICMS  := Total ;

     fsItensCupom.Add( ItemCupom ) ;

     Aliq.TotalDia := RoundTo( Aliq.TotalDia + Total,-2) ;
     fsSubTotal    := RoundTo( SubTotal + Total,-2) ; 

     GravaArqINI ;
  except
     RestauraEstadoAnterior ;
  end ;

end ;

Function TACBrECFNaoFiscal.StuffMascaraItem( Linha : String; Letra : Char;
   TextoInserir : String) : String ;
Var A,B : Integer ;
    L : Char ;
begin
  B := 1 ;
  Result := '' ; 
  For A := 1 to length(fsMascaraItem) do
  begin
     L := fsMascaraItem[A] ;
     
     if L = Letra then
        if B > Length( TextoInserir ) then
           L := ' '
        else
         begin
           L := TextoInserir[B] ;
           B := B + 1 ;
         end
     else
        if A > Length( Linha ) then
           L := ' ' 
        else
           L := Linha[A] ;

     Result := Result + L ;
  end
end;

procedure TACBrECFNaoFiscal.AbreRelatorioGerencial;
begin
  ListaLeituraX( estRelatorio );
end;

procedure TACBrECFNaoFiscal.LinhaRelatorioGerencial(Linha: String);
begin
  ImprimePorta( Linha + CRLF );
end;

procedure TACBrECFNaoFiscal.AbreCupomVinculado(COO, CodFormaPagto,
  CodComprovanteNaoFiscal: String; Valor: Double);
Var FPG : TACBrECFNaoFiscalFormaPagamento ;
    A, PosFPG : Integer ;
    UsouPagamento : Boolean ;
begin

  if COO = '' then
     raise Exception.create('COO inv�lido');

  if Estado <> estLivre  then
     raise Exception.Create('O Estado da Impressora n�o � "LIVRE"') ;

  if fsPagamentosCupom.Count < 1 then
     raise Exception.Create('Ultimo Documento n�o � Cupom') ;

  COO := Poem_Zeros(COO,6) ;

  PosFPG := AchaFPGIndiceNaoFiscal( CodFormaPagto ) ;
  if PosFPG < 0 then
     raise Exception.Create('Posi��o de Pagamento: '+CodFormaPagto+' inv�lida');

  FPG := TACBrECFNaoFiscalFormaPagamento( fsFormasPagamento[PosFPG] ) ;

  UsouPagamento := false ;
  A := 0 ;
  while (not UsouPagamento) and (A <= fsPagamentosCupom.Count - 1) do
     UsouPagamento := (TACBrECFNaoFiscalPagamentoCupom(
                       fsPagamentosCupom[A]).PosFPG = PosFPG ) ;

  if not UsouPagamento then
     raise Exception.create('Forma de Pagamento: '+FPG.Descricao+
                            ' n�o foi utilizada no Cupom anterior') ;

  ZeraBuffer ;
  fsBuffer.Add( padC('COMPROVANTE NAO FISCAL VINCULADO',Colunas) ) ;
  fsBuffer.Add( '' ) ;
  fsBuffer.Add( 'COO do documento de compra: '+COO ) ;
  fsBuffer.Add( padS('VALOR TOTAL DA COMPRA  R$:|'+
                FormatFloat('##,###,##0.00',SubTotal),Colunas,'|') ) ;
  fsBuffer.Add( padS(padL(FPG.Descricao,22)+' R$:|'+
                FormatFloat('##,###,##0.00',Valor),Colunas,'|') ) ;
  fsBuffer.Add( '' ) ;

  SalvaEstadoAtual ;

  fsItensCupom.Clear ;
  fsPagamentosCupom.Clear ;
  fsTotalPago := 0 ;
  fsSubTotal  := 0 ;
  fpEstado    := estRelatorio ;

  try
     AbreDocumento ;
  except
     RestauraEstadoAnterior ;
     raise ;
  end ;
end;

procedure TACBrECFNaoFiscal.LinhaCupomVinculado(Linha: String);
begin
  ImprimePorta( Linha + CRLF );
end;

procedure TACBrECFNaoFiscal.FechaRelatorio;
var wEstado : TACBrECFEstado ;
begin
  if Estado <> estRelatorio then exit ;

  ZeraBuffer ;
  AddBufferRodape ;

  ImprimeBuffer ;
  wEstado := Estado ;

  try
     fpEstado := estLivre ;

     GravaArqINI ;
  except
     fpEstado := wEstado ;
  end ;
end;

procedure TACBrECFNaoFiscal.ListaRelatorioGerencial(Relatorio: TStrings;
  Vias: Integer);
Var Imp, Linha, A : Integer ;
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

     Linha := 1 ;
     while Linha <= ( Relatorio.Count - 1) do
     begin
        LinhaRelatorioGerencial( Relatorio[ Linha ] ) ;
        Linha := Linha + 1 ;

       Application.ProcessMessages ;
     end ;

     Imp := Imp + 1 ;

     if Imp < Vias then
     begin
        For A := 1 to LinhasEntreCupons do
           LinhaRelatorioGerencial( '' ) ;
        PausarRelatorio( Imp ) ;
     end ;
  end ;

  PintaFormMsg( 'Fechando Relat�rio Gerencial' );
  FechaRelatorio ;
end;

procedure TACBrECFNaoFiscal.ListaCupomVinculado(Relatorio: TStrings;
  Vias: Integer);
Var Imp, Linha, A : Integer ;
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

     Linha := 1 ;
     while Linha <= ( Relatorio.Count - 1) do
     begin
        LinhaCupomVinculado( Relatorio[ Linha ] ) ;
        Linha := Linha + 1 ;

       Application.ProcessMessages ;
     end ;

     Imp := Imp + 1 ;

     if Imp < Vias then
     begin
        For A := 1 to LinhasEntreCupons do
           LinhaRelatorioGerencial( '' ) ;
        PausarRelatorio( Imp ) ;
     end ;
  end ;

  PintaFormMsg( 'Fechando Cupom Vinculado' );
  FechaRelatorio ;
end;

procedure TACBrECFNaoFiscal.GravaArqINI;
Var Ini : TIniFile ;
    A   : Integer ;
    S   : String ;
    Aviso : String ;
    PrimeiraVez : Boolean ;
begin

  PrimeiraVez := not FileExists(fsArqINI)  ;
  Ini := TIniFile.Create( fsArqINI ) ;

  try
     Aviso := Ini.ReadString('Variaveis','Aviso_Legal','SIM') ;

     Ini.WriteInteger('Variaveis','Estado',Integer( fpEstado) ) ;
     Ini.WriteString('Variaveis','Aviso_Legal',Aviso) ;
     Ini.WriteString('Variaveis','NumECF',fsNumECF) ;
     Ini.WriteString('Variaveis','NumSerie',fsNumSerie) ;
     Ini.WriteInteger('Variaveis','CRO',fsCRO) ;
     Ini.WriteInteger('Variaveis','NumCupom',fsNumCupom) ;
     Ini.WriteDate('Variaveis','DiaMovimento',fsDia) ;
     Ini.WriteBool('Variaveis','HorarioVerao',fsVERAO) ;
     Ini.WriteInteger('Variaveis','ReducoesZ',fsReducoesZ) ;
     Ini.WriteInteger('Variaveis','LeiturasX',fsLeiturasX) ;
     Ini.WriteInteger('Variaveis','COOInicial',fsCOOInicial) ;
     Ini.WriteInteger('Variaveis','COOFinal',fsCOOFinal) ;
     Ini.WriteFloat('Variaveis','SubTotal',SubTotal) ;
     Ini.WriteFloat('Variaveis','TotalPago',TotalPago) ;
     Ini.WriteInteger('Variaveis','CuponsCancelados',fsCuponsCancelados) ;

     if PrimeiraVez then
     begin
        Ini.EraseSection('Cabecalho') ;
        For A := 0 to fsCabecalho.Count - 1 do
           Ini.WriteString('Cabecalho','LIN'+IntToStrZero(A,3),fsCabecalho[A] );

        Ini.EraseSection('Cabecalho_Item') ;
        For A := 0 to fsCabecalhoItem.Count - 1 do
           Ini.WriteString('Cabecalho_Item','LIN'+IntToStrZero(A,3),
              fsCabecalhoItem[A] );
        Ini.WriteString('Cabecalho_Item','MascaraItem',fsMascaraItem) ;

        Ini.WriteInteger('Impressora','Colunas', fpColunas) ;
        Ini.WriteString('Impressora','Comando_Abrir_Gaveta',
           StringToAsc(fsGavetaCmd) ) ;
        Ini.WriteString('Impressora','Comando_Incializacao',
           StringToAsc(fsCmdImpZera) ) ;
        Ini.WriteString('Impressora','Comando_Ativar_Condensado',
           StringToAsc(fsCmdImpCondensado) );
        Ini.WriteString('Impressora','Comando_Expandido_uma_Linha',
           StringToAsc(fsCmdImpExpandidoUmaLinha) ) ;
     end ;

     A := 0 ;
     while true do
     begin
        S := 'Item_Cupom'+IntToStrZero( A, 3) ;

        if A <= fsItensCupom.Count - 1 then
           with fsItensCupom[A] as TACBrECFNaoFiscalItemCupom do
           begin
              Ini.WriteString( S ,'Descricao', Descricao );
              Ini.WriteString( S ,'Codigo', Codigo ) ;
              Ini.WriteFloat( S ,'Qtd', Qtd ) ;
              Ini.WriteFloat( S ,'ValorUnit', ValorUnit ) ;
              Ini.WriteInteger( S ,'PosAliq', PosAliq) ;
              Ini.WriteFloat( S ,'BaseICMS', BaseICMS) ;
           end
        else
           if Ini.SectionExists( S ) then
              Ini.EraseSection( S )
           else
              break ;

        A := A + 1 ;
     end ;

     A := 0 ;
     while true do
     begin
        S := 'Pagamento_Cupom'+IntToStrZero( A, 2) ;

        if A <= fsPagamentosCupom.Count - 1 then
           with fsPagamentosCupom[A] as TACBrECFNaoFiscalPagamentoCupom do
           begin
              Ini.WriteInteger( S ,'PosFPG', PosFPG ) ;
              Ini.WriteFloat( S ,'ValorPago', ValorPago ) ;
           end
        else
           if Ini.SectionExists( S ) then
              Ini.EraseSection( S )
           else
              break ;

        A := A + 1 ;
     end ;

     A := 0 ;
     while true do
     begin
        S := 'Aliquota'+IntToStrZero( A, 2) ;

        if A <= fsAliquotas.Count - 1 then
           with fsAliquotas[A] as TACBrECFNaoFiscalAliquota do
           begin
              Ini.WriteString( S ,'Descricao', Descricao ) ;
              Ini.WriteFloat( S ,'Aliquota', Aliquota ) ;
              Ini.WriteBool( S ,'ISS', Iss ) ;
              Ini.WriteFloat( S ,'TotalDia', TotalDia ) ;
           end
        else
           if Ini.SectionExists( S ) then
              Ini.EraseSection( S )
           else
              break ;

        A := A + 1 ;
     end ;

     A := 0 ;
     while true do
     begin
        S := 'Forma_Pagamento'+IntToStrZero( A, 2) ;

        if A <= fsFormasPagamento.Count - 1 then
           with fsFormasPagamento[A] as TACBrECFNaoFiscalFormaPagamento do
           begin
              Ini.WriteString( S ,'Indice', Indice ) ;
              Ini.WriteString( S ,'Descricao', Descricao ) ;
              Ini.WriteFloat( S ,'TotalDia', TotalDia ) ;
           end
        else
           if Ini.SectionExists( S ) then
              Ini.EraseSection( S )
           else
              break ;

        A := A + 1 ;
     end ;

     A := 0 ;
     while true do
     begin
        S := 'Comprovante_nao_Fiscal'+IntToStrZero( A, 2) ;

        if A <= fsComprovantesNaoFiscais.Count - 1 then
           with fsComprovantesNaoFiscais[A] as TACBrECFNaoFiscalComprovanteNaoFiscal do
           begin
              Ini.WriteString( S ,'Indice', Indice ) ;
              Ini.WriteString( S ,'Descricao', Descricao ) ;
              Ini.WriteFloat( S ,'TotalDia', TotalDia ) ;
           end
        else
           if Ini.SectionExists( S ) then
              Ini.EraseSection( S )
           else
              break ;

        A := A + 1 ;
     end ;

  finally
     Ini.Free ;
  end ;

end;

procedure TACBrECFNaoFiscal.LeArqINI;
Var Ini : TIniFile ;
    A,B : Integer ;
    S,T : String ;
    NumSerie : String ;
    ItemCupom            : TACBrECFNaoFiscalItemCupom ;
    PagamentoCupom       : TACBrECFNaoFiscalPagamentoCupom ;
    AliqICMS             : TACBrECFNaoFiscalAliquota ;
    FormaPagamento       : TACBrECFNaoFiscalFormaPagamento ;
    ComprovanteNaoFiscal : TACBrECFNaoFiscalComprovanteNaoFiscal ;
begin

  if not FileExists( fsArqINI ) then
  begin
     AvisoLegal ;

     try
        DateTimeToString(NumSerie, 'ddmmyyhhnnss', now ) ;
        fsNumSerie := NumSerie ;
     except
     end ;

     AliqICMS := TACBrECFNaoFiscalAliquota.create ;
     AliqICMS.Aliquota := 0 ;
     AliqICMS.Descricao:= 'FF' ;
     AliqICMS.Iss      := false ;
     AliqICMS.TotalDia := 0 ;
     fsAliquotas.Add( AliqICMS ) ;

     AliqICMS := TACBrECFNaoFiscalAliquota.create ;
     AliqICMS.Aliquota := 0 ;
     AliqICMS.Descricao:= 'NN' ;
     AliqICMS.Iss      := false ;
     AliqICMS.TotalDia := 0 ;
     fsAliquotas.Add( AliqICMS ) ;

     AliqICMS := TACBrECFNaoFiscalAliquota.create ;
     AliqICMS.Aliquota := 0 ;
     AliqICMS.Descricao:= 'II' ;
     AliqICMS.Iss      := false ;
     AliqICMS.TotalDia := 0 ;
     fsAliquotas.Add( AliqICMS ) ;
     FreeAndNil( fpAliquotas ) ; 

     FormaPagamento := TACBrECFNaoFiscalFormaPagamento.create ;
     FormaPagamento.Indice    := '01' ;
     FormaPagamento.Descricao := 'DINHEIRO' ;
     FormaPagamento.TotalDia  := 0 ;
     fsFormasPagamento.Add( FormaPagamento ) ;
     FreeAndNil( fpFormasPagamentos ) ;

     GravaArqINI ;

     exit ;
  end ;

  Ini := TIniFile.Create( fsArqINI ) ;
  try
     if Ini.ReadString('Variaveis','Aviso_Legal','SIM') = 'SIM' then
        AvisoLegal ;

     if fsNumECF = '' then
        fsNumECF := Ini.ReadString('Variaveis','NumECF',fsNumECF) ;

     fpEstado    := TACBrECFEstado( Ini.ReadInteger('Variaveis','Estado',
                       Integer( fpEstado) ) ) ;
     fsNumSerie  := Ini.ReadString('Variaveis','NumSerie',fsNumSerie) ;
     fsCRO       := Ini.ReadInteger('Variaveis','CRO',fsCRO) ;
     fsNumCupom  := Ini.ReadInteger('Variaveis','NumCupom',fsNumCupom) ;
     fsDia       := Ini.ReadDate('Variaveis','DiaMovimento',fsDia) ;
     fsVERAO     := Ini.ReadBool('Variaveis','HorarioVerao',fsVERAO) ;
     fsReducoesZ := Ini.ReadInteger('Variaveis','ReducoesZ',fsReducoesZ) ;
     fsLeiturasX := Ini.ReadInteger('Variaveis','LeiturasX',fsLeiturasX) ;
     fsCOOInicial:= Ini.ReadInteger('Variaveis','COOInicial',fsCOOInicial) ;
     fsCOOFinal  := Ini.ReadInteger('Variaveis','COOFinal',fsCOOFinal) ;
     fsSubTotal  := Ini.ReadFloat('Variaveis','SubTotal',fsSubTotal) ;
     fsTotalPago := Ini.ReadFloat('Variaveis','TotalPago',fsTotalPago) ;
     fsCuponsCancelados := Ini.ReadInteger('Variaveis','CuponsCancelados',
        fsCuponsCancelados) ;

     fsCabecalho.Clear ;
     A := 0 ;
     while true do
     begin
        S := 'LIN'+IntToStrZero( A, 3) ;
        T := Ini.ReadString('Cabecalho', S, '*FIM*') ;

        if T = '*FIM*' then break ;

        fsCabecalho.Add( T ) ;
        A := A + 1 ;
     end ;

     fsCabecalhoItem.Clear ;
     A := 0 ;
     while true do
     begin
        S := 'LIN'+IntToStrZero( A, 3) ;
        T := Ini.ReadString('Cabecalho_Item', S, '*FIM*') ;

        if T = '*FIM*' then break ;

        fsCabecalhoItem.Add( T ) ;
        A := A + 1 ;
     end ;

     fsMascaraItem := Ini.ReadString('Cabecalho_Item','MascaraItem',
        fsMascaraItem) ;

     fpColunas   := Ini.ReadInteger('Impressora','Colunas', fpColunas) ;
     if fsGavetaCmd = '' then
        fsGavetaCmd := Ini.ReadString('Impressora',
           'Comando_Abrir_Gaveta', #027+'v'+#100) ;
     fsCmdImpZera := AscToString( Ini.ReadString('Impressora',
        'Comando_Incializacao', fsCmdImpZera) ) ;
     fsCmdImpCondensado := AscToString( Ini.ReadString('Impressora',
        'Comando_Ativar_Condensado', fsCmdImpCondensado) ) ;
     fsCmdImpExpandidoUmaLinha := AscToString( Ini.ReadString('Impressora',
        'Comando_Expandido_uma_Linha', fsCmdImpExpandidoUmaLinha) );

     fsItensCupom.Clear ;
     A := 0 ;
     while true do
     begin
        S := 'Item_Cupom'+IntToStrZero( A, 3) ;
        T := Ini.ReadString( S ,'Descricao','*FIM*') ;

        if T = '*FIM*' then break ;

        ItemCupom := TACBrECFNaoFiscalItemCupom.Create ;
        ItemCupom.Descricao := T ;
        ItemCupom.Codigo    := Ini.ReadString( S ,'Codigo','') ;
        ItemCupom.Qtd       := Ini.ReadFloat( S ,'Qtd',0) ;
        ItemCupom.ValorUnit := Ini.ReadFloat( S ,'ValorUnit',0) ;
        ItemCupom.PosAliq   := Ini.ReadInteger( S ,'PosAliq',0) ;
        ItemCupom.BaseICMS  := Ini.ReadFloat( S ,'BaseICMS',0) ;

        fsItensCupom.Add( ItemCupom ) ;
        A := A + 1 ;
     end ;

     fsPagamentosCupom.Clear ;
     A := 0 ;
     while true do 
     begin
        S := 'Pagamento_Cupom'+IntToStrZero( A, 2) ;
        B := Ini.ReadInteger( S ,'PosFPG',-1) ;

        if B = -1 then break ;

        PagamentoCupom := TACBrECFNaoFiscalPagamentoCupom.Create ;
        PagamentoCupom.PosFPG    := B ;
        PagamentoCupom.ValorPago := Ini.ReadFloat( S ,'ValorPago',0) ;

        fsPagamentosCupom.Add( PagamentoCupom ) ;
        A := A + 1 ;
     end ;

     fsAliquotas.Clear ;
     A := 0 ;
     while true do
     begin
        S := 'Aliquota'+IntToStrZero( A, 2) ;
        T := Ini.ReadString( S ,'Descricao','*FIM*') ;

        if T = '*FIM*' then break ;

        AliqICMS := TACBrECFNaoFiscalAliquota.Create ;
        AliqICMS.Descricao := T ;
        AliqICMS.Aliquota  := Ini.ReadFloat( S ,'Aliquota',0) ;
        AliqICMS.Iss       := Ini.ReadBool( S ,'ISS',false) ;
        AliqICMS.TotalDia  := Ini.ReadFloat( S ,'TotalDia',0) ;

        fsAliquotas.Add( AliqICMS ) ;
        A := A + 1 ;
     end ;

     fsFormasPagamento.Clear ;
     A := 0 ;
     while true do
     begin
        S := 'Forma_Pagamento'+IntToStrZero( A, 2) ;
        T := Ini.ReadString( S ,'Descricao','*FIM*') ;

        if T = '*FIM*' then break ;

        FormaPagamento := TACBrECFNaoFiscalFormaPagamento.Create ;
        FormaPagamento.Descricao := T ;
        FormaPagamento.Indice    := Ini.ReadString( S ,'Indice', '') ;
        FormaPagamento.TotalDia  := Ini.ReadFloat( S ,'TotalDia',0) ;

        fsFormasPagamento.Add( FormaPagamento ) ;
        A := A + 1 ;
     end ;

     fsComprovantesNaoFiscais.Clear ;
     A := 0 ;
     while true do
     begin
        S := 'Comprovante_nao_Fiscal'+IntToStrZero( A, 2) ;
        T := Ini.ReadString( S ,'Descricao','*FIM*') ;

        if T = '*FIM*' then break ;

        ComprovanteNaoFiscal := TACBrECFNaoFiscalComprovanteNaoFiscal.Create ;
        ComprovanteNaoFiscal.Descricao := T ;
        ComprovanteNaoFiscal.Indice    := Ini.ReadString( S ,'Indice', '') ;
        ComprovanteNaoFiscal.TotalDia  := Ini.ReadFloat( S ,'TotalDia',0) ;

        fsComprovantesNaoFiscais.Add( ComprovanteNaoFiscal ) ;
        A := A + 1 ;
     end ;

  finally
     Ini.Free ;
  end ;

end;

procedure TACBrECFNaoFiscal.SetNomeArqINI(const Value: String);
begin
  fsNomeArqINI := Value;
  fsGavetaCmd  := '' ;
  fsNumSerie   := '' ;
  fsNumECF     := '' ;
end;

Procedure TACBrECFNaoFiscal.AvisoLegal ;
begin
  if MessageDlg('Este Emulador destina-se EXCLUSIVAMENTE para auxiliar no '+
                'desenvolvimento de aplicativos para as impressoras fiscais. '+
                sLineBreak+sLineBreak+
                'Usar o emulador para fins comerciais sem a devida impress�o '+
                'do Cupom Fiscal ou Nota Fiscal pode caracterizar crime de '+
                'Sonega��o Fiscal.'+
                sLineBreak+sLineBreak+
                'Continua com o uso do Emulador ?'
                ,mtWarning,mbYesNoCancel,0) <> mrYes then
     raise Exception.Create( 'Uso indevido do emulador');           
end;

procedure TACBrECFNaoFiscal.AbreBuffer;
Var NomeArqBuffer : String ;
begin
  NomeArqBuffer := ChangeFileExt( fsArqINI, '.BUF') ;

  AssignFile( fsArqBuf, NomeArqBuffer );
  FileMode := fmOpenReadWrite	+ fmShareExclusive ;

  try
     if FileExists( NomeArqBuffer ) then
      begin
        fsBuffer.LoadFromFile( NomeArqBuffer );
        Reset( fsArqBuf );
        if not SeekEof( fsArqBuf ) then
           raise Exception.Create('Erro ao posicionar em EOF no arquivo: '+
                                  NomeArqBuffer) ;
      end
     else
        ReWrite( fsArqBuf );
  except
     CloseFile( fsArqBuf );
     raise ;
  end ;

end;

procedure TACBrECFNaoFiscal.GravaBuffer ;
var A : Integer ;
begin
  For A := 0 to fsBuffer.Count - 1 do
  begin
     Writeln( fsArqBuf, fsBuffer[A] ) ;
  end ;
end;

procedure TACBrECFNaoFiscal.ImprimeBuffer;
Var A : Integer ;
    Buf : String ;
begin
  Buf := '' ;
  For A := 0 to fsBuffer.Count - 1 do
  begin
     Buf := Buf + fsBuffer[A] + CRLF ;
  end ;

  ImprimePorta( Buf );

  ZeraBuffer ;
end;

procedure TACBrECFNaoFiscal.ZeraBuffer;
begin
  Rewrite( fsArqBuf ) ;
  fsBuffer.Clear ;
end;

procedure TACBrECFNaoFiscal.ImprimePorta( AString : String ) ;
begin
  fpDevice.EnviaString( AString );
end;

procedure TACBrECFNaoFiscal.ImprimePorta(AStringList: TStringList);
Var Str : String ;
    A : Integer ;
begin
  Str := '' ;
  For A := 0 to AStringList.Count - 1 do
     Str := Str + AStringList[A] + CRLF ;

  ImprimePorta( Str );
end;

procedure TACBrECFNaoFiscal.AddBufferRelatorio;
Var Total : Double ;
    A : Integer ;
    T : String ;
begin
  Total := 0 ;
  For A := 0 to 2 do
     with TACBrECFNaoFiscalAliquota( fsAliquotas[A] ) do
        Total := RoundTo(Total + TotalDia,-2) ;
        
  with fsBuffer do
  begin
     Add( StringOfChar('-',Colunas) ) ;
     Add( padS('Reducoes Z:|'+IntToStrZero(fsReducoesZ,4),Colunas,'|') ) ;
     Add( padS('Leitura  X:|'+IntToStrZero(fsLeiturasX,6),Colunas,'|') ) ;
     Add( padS('Cancelamentos de Cupom:|'+IntToStrZero(fsCuponsCancelados,4),
        Colunas,'|') ) ;
     Add( padS('COO do Primeiro Cupom:|'+IntToStrZero(fsCOOInicial,4),
        Colunas,'|') ) ;
     Add( padS('COO do Ultimo Cupom:|'+IntToStrZero(fsCOOFinal,4),Colunas,'|'));
     Add( padC('Total Vendido por Aliquota',Colunas,'-') ) ;
     Add( padS('Substituicao Tributaria (FF)|'+FormatFloat('###,###,##0.00',
        TACBrECFNaoFiscalAliquota(fsAliquotas[0]).TotalDia ),Colunas,'|') ) ;
     Add( padS('Isencao (II)|'+FormatFloat('###,###,##0.00',
        TACBrECFNaoFiscalAliquota(fsAliquotas[1]).TotalDia ),Colunas,'|') ) ;
     Add( padS('Nao Incidencia (NN)|'+FormatFloat('###,###,##0.00',
        TACBrECFNaoFiscalAliquota(fsAliquotas[2]).TotalDia ),Colunas,'|') ) ;

     For A := 3 to fsAliquotas.Count - 1 do
     with TACBrECFNaoFiscalAliquota(fsAliquotas[A]) do
     begin
        if Iss then
           T := 'S'
        else
           T := 'T' ;

        Add( padS(IntToStrZero(A,2)+'|'+ T + FormatFloat('#0.00',Aliquota)+'%|'+
                  FormatFloat('###,###,##0.00',TotalDia),Colunas,'|') ) ;
        Total := RoundTo(Total + TotalDia,-2) ;
     end ;

     Add( padS('T O T A L   R$|'+FormatFloat('###,###,##0.00',Total),
        Colunas,'|') ) ;

     Add( padC('Formas de Pagamento',Colunas,'-') ) ;
     For A := 0 to fsFormasPagamento.Count - 1 do
     with TACBrECFNaoFiscalFormaPagamento(fsFormasPagamento[A]) do
     begin
        Add( padS(Indice+'  '+padL(Descricao,20)+'|'+
                   FormatFloat('###,###,##0.00',TotalDia),Colunas,'|') ) ;
     end ;

     Add( padC('Comprovantes nao Fiscal',Colunas,'-') ) ;
     For A := 0 to fsComprovantesNaoFiscais.Count - 1 do
     with TACBrECFNaoFiscalComprovanteNaoFiscal(fsComprovantesNaoFiscais[A]) do
     begin
        Add( padS(Indice+'  '+padL(Descricao,20)+'|'+
                   FormatFloat('###,###,##0.00',TotalDia),Colunas,'|') ) ;
     end ;
  end ;

  AddBufferRodape ;
end;

procedure TACBrECFNaoFiscal.InsertCabecalho( AStringList : TStringList );
Var A : Integer ;
    V,Linha : String ;
begin
  if fsVERAO then
     V := 'V'
  else
     V := ' ' ;

  For A := 0 to fsCabecalho.Count - 1 do
  begin
     Linha := padC(fsCabecalho[A], Colunas) ;
     if A = 0 then
        Linha := fsCmdImpCondensado + Linha ;
     AStringList.Insert( A, Linha ) ;
  end ;

  AStringList.Insert( fsCabecalho.Count,
                      padS( DateToStr(now)+' '+TimeToStr(now)+V+'|COO:'+
                      IntToStrZero(fsNumCupom,6), Colunas, '|' ) ) ;
end;

procedure TACBrECFNaoFiscal.AddBufferCabecalho_Item;
Var A : Integer ;
begin
  fsBuffer.Add( padC('COMPROVANTE  * NAO FISCAL *',Colunas) ) ;
 
  For A := 0 to fsCabecalhoItem.Count - 1 do
     fsBuffer.Add( fsCabecalhoItem[A] ) ;
end;

procedure TACBrECFNaoFiscal.AddBufferRodape;
Var V : String ;
    A : Integer ;
begin
  if fsVERAO then
     V := 'V'
  else
     V := ' ' ;

  with fsBuffer do
  begin
     Add( StringOfChar('-',Colunas) ) ;
     Add( padS('Serie '+padL(fsNumSerie,15)+' Maq '+padL(fsNumECF,3)+'|'+
               DateToStr(now)+' '+TimeToStr(now)+V,Colunas,'|') );
     Add( padC('** N A O   E   C U P O M   F I S C A L **',Colunas) );
     Add( StringOfChar('=',Colunas) ) ;
     For A := 1 to LinhasEntreCupons do
        Add( '' ) ;
  end ;
end;

procedure TACBrECFNaoFiscal.RestauraEstadoAnterior;
begin
  fsVERAO      := fswVERAO ;
  fsDia        := fswDia   ;
  fpEstado     := fswEstado  ;
  fsReducoesZ  := fswReducoesZ ;
  fsLeiturasX  := fswLeiturasX ;
  fsCuponsCancelados := fswCuponsCancelados ;
  fsCOOInicial := fswCOOInicial ;
  fsCOOFinal   := fswCOOFinal ;
  fsNumCupom   := fswNumCupom ;
  fsSubTotal   := fswSubTotal ;
  fsTotalPago  := fswTotalPago;

  CopyAliquotas( fswAliquotas, fsAliquotas ) ;
  CopyFormasPagamento( fswFormasPagamento, fsFormasPagamento ) ;
  CopyComprovantesNaoFiscais(fswComprovantesNaoFiscais, fsComprovantesNaoFiscais );
  CopyItensCupom( fswItensCupom, fsItensCupom ) ;
  CopyPagamentosCupom( fswPagamentosCupom, fsPagamentosCupom ) ;
end;

procedure TACBrECFNaoFiscal.SalvaEstadoAtual;
begin
  fswVERAO      := fsVERAO ;
  fswDia        := fsDia   ;
  fswESTADO     := fpEstado  ;
  fswReducoesZ  := fsReducoesZ ;
  fswLeiturasX  := fsLeiturasX ;
  fswCuponsCancelados := fsCuponsCancelados ;
  fswCOOInicial := fsCOOInicial ;
  fswCOOFinal   := fsCOOFinal ;
  fswNumCupom   := fsNumCupom ;
  fswSubTotal   := fsSubTotal ;
  fswTotalPago  := fsTotalPago;

  CopyAliquotas( fsAliquotas, fswAliquotas ) ;
  CopyFormasPagamento( fsFormasPagamento, fswFormasPagamento ) ;
  CopyComprovantesNaoFiscais(fsComprovantesNaoFiscais, fswComprovantesNaoFiscais );
  CopyItensCupom( fsItensCupom, fswItensCupom ) ;
  CopyPagamentosCupom( fsPagamentosCupom, fswPagamentosCupom ) ;
end;

procedure TACBrECFNaoFiscal.AbreDocumento(AbreDia : Boolean) ;
var Cab : TStringList ;
begin

  if fsDia > now then
     raise Exception.create('Erro ! A Data da Impressora: '+DateToStr(fsDia)+
            '� maior do que a Data atual: '+DateToStr(now)) ;

  if not EmLinha() then
     raise Exception.Create('Impressora: '+ModeloStr+' n�o est� pronta.') ;
     
  fsNumCupom := fsNumCupom + 1 ;
  fsCOOFinal := fsNumCupom ;

  if AbreDia or (CompareDate(fsDIA, now) > 0) then
  begin
     fsDIA        := now ;
     fsCOOInicial := fsNumCupom ;
  end ;

  Cab := TStringList.create ;
  try
     InsertCabecalho( Cab );

     ImprimePorta( Cab );
     GravaBuffer ;
     try
        GravaArqINI ;
        ImprimeBuffer
     finally
        ZeraBuffer ;
     end ;
  finally
     Cab.Free ;
  end ;
end;

function TACBrECFNaoFiscal.GetEstado: TACBrECFEstado;
Var estAnterior : TACBrECFEstado ;
begin
  estAnterior := fpEstado ;
  if not (fpEstado in [estNaoInicializada,estDesconhecido]) then
  begin
     if (CompareDate( now, fsDia) > 0) and
        ( not (fpEstado in [estBloqueada,estRequerX])) then
        fpEstado := estRequerZ ;

     if (fpEstado = estBloqueada) and (CompareDate( now, fsDia) > 0) then
        fpEstado := estRequerX ;
  end ;

  if fpEstado = estDesconhecido then
     fpEstado := estLivre ;

  if fpEstado <> estAnterior then
     GravaArqINI ;

  result := fpEstado ;
end ;

function TACBrECFNaoFiscal.GetArredonda: Boolean;
begin
  Result := true  ;  { NaoFiscal sempre arredonda }
end;

function TACBrECFNaoFiscal.GetHorarioVerao: Boolean;
begin
  Result := fsVERAO ;
end;

procedure TACBrECFNaoFiscal.CarregaFormasPagamento;
Var A : Integer ;
    FormaPagamento : TACBrECFFormaPagamento ;
begin
  inherited CarregaFormasPagamento ;   { Cria fpFormasPagamentos }

  for A := 0 to fsFormasPagamento.Count - 1 do
  begin
     FormaPagamento := TACBrECFFormaPagamento.create ;

     with TACBrECFNaoFiscalFormaPagamento( fsFormasPagamento[A] ) do
     begin
        FormaPagamento.Indice    := Indice ;
        FormaPagamento.Descricao := Descricao ;
        FormaPagamento.PermiteVinculado := true ; 
     end ;

     fpFormasPagamentos.Add( FormaPagamento ) ;
  end ;
end;

function TACBrECFNaoFiscal.AchaFPGDescricao(Descricao: String) :
   TACBrECFFormaPagamento;
begin
  result := inherited AchaFPGDescricao(Descricao) ;

  { Na impressora Nao Fiscal podemos programas as Formas de Pagamento
    dinamicamente. }
  if (Result = nil) then
  begin
     ProgramaFormaPagamento( Descricao ) ;
     result := inherited AchaFPGDescricao(Descricao) ;
  end ;
end;

procedure TACBrECFNaoFiscal.ProgramaFormaPagamento( var Descricao: String;
   PermiteVinculado : Boolean; Posicao : String ) ;
Var FPagto : TACBrECFFormaPagamento ;
    FPagtoNaoFiscal : TACBrECFNaoFiscalFormaPagamento ;
    A : Integer ;
begin
  { Verificando se a Descri�ao j� foi programada antes (ja existe ?) }
  For A := 0 to fsFormasPagamento.Count -1 do
     if trim(UpperCase(
          TACBrECFNaoFiscalFormaPagamento(fsFormasPagamento[A]).Descricao)) =
        trim(UpperCase(Descricao)) then
        exit ;

  Descricao := UpperCase( Descricao ) ;
  Descricao := padL(Descricao,20) ;         { Ajustando tamanho final }

  SalvaEstadoAtual ;

  FPagtoNaoFiscal := TACBrECFNaoFiscalFormaPagamento.create ;
  FPagtoNaoFiscal.Indice    := IntToStrZero( fsFormasPagamento.Count+1,2) ;
  FPagtoNaoFiscal.Descricao := Descricao ;
  FPagtoNaoFiscal.TotalDia  := 0 ;
  fsFormasPagamento.Add( FPagtoNaoFiscal ) ;

  try
     GravaArqINI ;

     if Assigned(fpFormasPagamentos) then
     begin
        FPagto := TACBrECFFormaPagamento.create ;
        FPagto.Indice           := FPagtoNaoFiscal.Indice ;
        FPagto.Descricao        := Descricao ;
        FPagto.PermiteVinculado := PermiteVinculado ;
        fpFormasPagamentos.Add( FPagto ) ;
     end ;
  except
     RestauraEstadoAnterior ;
  end ;
end;


procedure TACBrECFNaoFiscal.CarregaAliquotas;
Var A : Integer ;
    Aliquota : TACBrECFAliquota ;
begin
  inherited CarregaAliquotas ;   { Cria fpAliquotas }

  for A := 0 to fsAliquotas.Count - 1 do
  begin
     Aliquota := TACBrECFAliquota.create ;

     Aliquota.Indice   := IntToStrZero(A+1,2) ;
     Aliquota.Aliquota := TACBrECFNaoFiscalAliquota( fsAliquotas[A] ).Aliquota ;
     if TACBrECFNaoFiscalAliquota( fsAliquotas[A] ).Iss then
        Aliquota.Tipo := 'S' ;
        
     fpAliquotas.Add( Aliquota ) ;
  end ;
end;

function TACBrECFNaoFiscal.AchaICMSAliquota( Aliquota: Double):
   TACBrECFAliquota;
begin
  result := inherited AchaICMSAliquota( Aliquota ) ;

  { Na impressora Nao Fiscal podemos programas as Aliquotas dinamicamente. }
  if (Result = nil) then
  begin
     ProgramaAliquota( Aliquota ) ;
     result := inherited AchaICMSAliquota( Aliquota ) ;
  end ;
end;

procedure TACBrECFNaoFiscal.ProgramaAliquota( Aliquota : Double; Tipo : Char;
   Posicao : String) ;
Var Aliq : TACBrECFAliquota ;
    AliqNaoFiscal : TACBrECFNaoFiscalAliquota ;
    A : Integer ;
begin
  { Verificando se a Aliquota j� foi programada antes (ja existe ?) }
  For A := 0 to fsAliquotas.Count -1 do
     if (TACBrECFNaoFiscalAliquota(fsAliquotas[A]).Aliquota = Aliquota) and
        (TACBrECFNaoFiscalAliquota(fsAliquotas[A]).Iss      = (Tipo = 'S')) then
        exit ;

  Tipo := UpCase(Tipo) ;

  SalvaEstadoAtual ;

  AliqNaoFiscal := TACBrECFNaoFiscalAliquota.create ;
  AliqNaoFiscal.Aliquota  := Aliquota ;
  AliqNaoFiscal.Descricao := FloatToStr(Aliquota) ;
  AliqNaoFiscal.Iss       := (Tipo = 'S') ;
  fsAliquotas.Add( AliqNaoFiscal ) ;

  try
     GravaArqINI ;

     if Assigned( fpAliquotas ) then
     begin
        Aliq := TACBrECFAliquota.create ;
        Aliq.Indice   := IntToStrZero( fpAliquotas.Count+1,2) ;
        Aliq.Aliquota := Aliquota ;
        if Tipo = 'S' then
           Aliq.Tipo := Tipo ;
        fpAliquotas.Add( Aliq ) ;
     end ;
  except
     RestauraEstadoAnterior ;
  end ;
end;

procedure TACBrECFNaoFiscal.CarregaComprovantesNaoFiscais;
Var A : Integer ;
    CNF : TACBrECFComprovanteNaoFiscal ;
begin
  inherited CarregaComprovantesNaoFiscais ;   { Cria fpComprovantesNaoFiscais }

  for A := 0 to fsComprovantesNaoFiscais.Count - 1 do
  begin
     CNF := TACBrECFComprovanteNaoFiscal.create ;

     with TACBrECFNaoFiscalComprovanteNaoFiscal( fsComprovantesNaoFiscais[A] ) do
     begin
        CNF.Indice    := Indice ;
        CNF.Descricao := Descricao ;
        CNF.PermiteVinculado := true ;
     end ;

     fpComprovantesNaoFiscais.Add( CNF ) ;
  end ;
end;

function TACBrECFNaoFiscal.AchaCNFDescricao(Descricao: String):
   TACBrECFComprovanteNaoFiscal;
begin
  result := inherited AchaCNFDescricao( Descricao ) ;

  { Na impressora Nao Fiscal podemos programas os CNFs dinamicamente. }
  if (Result = nil) then
  begin
     ProgramaComprovanteNaoFiscal( Descricao, 'V' ) ;
     result := inherited AchaCNFDescricao( Descricao ) ;
  end ;
end;

procedure TACBrECFNaoFiscal.ProgramaComprovanteNaoFiscal(var Descricao: String;
   Tipo: String; Posicao : String);
Var CNF : TACBrECFComprovanteNaoFiscal ;
    CNFNaoFiscal : TACBrECFNaoFiscalComprovanteNaoFiscal ;
    A : Integer ;
begin
  { Verificando se a Descri�ao j� foi programada antes (ja existe ?) }
  For A := 0 to fsComprovantesNaoFiscais.Count -1 do
     if trim(UpperCase(TACBrECFNaoFiscalComprovanteNaoFiscal(
               fsComprovantesNaoFiscais[A]).Descricao)) =
        trim(UpperCase(Descricao)) then
        exit ;

  Descricao := UpperCase( Descricao ) ;
  Descricao := padL(Descricao,20) ;         { Ajustando tamanho final }
  Tipo      := UpperCase( Tipo ) ;
  if Tipo = '' then
     Tipo := 'V' ;

  SalvaEstadoAtual ;

  CNFNaoFiscal := TACBrECFNaoFiscalComprovanteNaoFiscal.create ;
  CNFNaoFiscal.Indice    := IntToStrZero( fsComprovantesNaoFiscais.Count+1,2) ;
  CNFNaoFiscal.Descricao := Descricao ;
  CNFNaoFiscal.TotalDia  := 0 ;
  fsComprovantesNaoFiscais.Add( CNFNaoFiscal ) ;

  try
     GravaArqINI ;

     if Assigned( fpComprovantesNaoFiscais ) then
     begin
        CNF := TACBrECFComprovanteNaoFiscal.create ;
        CNF.Indice    := CNFNaoFiscal.Indice ;
        CNF.Descricao := Descricao ;
        CNF.PermiteVinculado := (Tipo =  'V') ;
        fpComprovantesNaoFiscais.Add( CNF ) ;
     end ;
  except
     RestauraEstadoAnterior ;
  end ;
end;

function TACBrECFNaoFiscal.AchaFPGIndiceNaoFiscal( Indice: String) : Integer ;
var A : Integer ;
begin
  result := -1 ;
  with fsFormasPagamento do
  begin
     For A := 0 to Count -1 do
        if TACBrECFNaoFiscalFormaPagamento(Items[A]).Indice = Indice then
        begin
           result := A ;
           Break ;
        end ;
  end ;
end;

function TACBrECFNaoFiscal.AchaICMSAliquotaNaoFiscal( Aliquota: Double ) :
   Integer ;
var A : Integer ;
begin
  result := -1 ;
  with fsAliquotas do
  begin
     For A := 0 to Count -1 do
        if TACBrECFNaoFiscalAliquota(Items[A]).Aliquota = Aliquota then
         begin
           result := A ;
           Break ;
         end ;
  end ;
end;

function TACBrECFNaoFiscal.StringToAsc(AString: String): String;
Var A : Integer ;
begin
  Result := '' ;
  For A := 1 to Length( AString ) do
     Result := Result + '#'+IntToStr( Ord( AString[A] ) )+',' ;

  Result := copy(Result,1, Length( Result )-1 ) ;  
end;

function TACBrECFNaoFiscal.AscToString(AString: String): String;
Var A : Integer ;
    Token : String ;
    C : Char ;
begin
  A      := 1  ;
  Token  := '' ;
  Result := '' ;
  while A <= length( AString ) + 1 do
  begin
     if A > length( AString ) then
        C := ','
     else
        C := AString[A] ;

     if (C = ',') and (Length( Token ) > 1) then
      begin
        if Token[1] = '#' then
        try
           Token := chr( StrToInt( copy(Token,2,length(Token)) ) ) ;
        except
        end ;

        Result := Result + Token ;
        Token := '' ;
      end
     else
        Token := Token + C ;

     A := A + 1 ;
  end ;
end;

procedure TACBrECFNaoFiscal.CopyAliquotas(FromObjectList,
   ToObjectList: TObjectList);
Var A : Integer ;
    ItemF,ItemT : TACBrECFNaoFiscalAliquota ;
begin
  ToObjectList.Clear ;

  For A := 0 to FromObjectList.Count - 1 do
  begin
     ItemF := TACBrECFNaoFiscalAliquota( FromObjectList[A] ) ; 
     ItemT := TACBrECFNaoFiscalAliquota.Create ;

     ItemT.Aliquota  := ItemF.Aliquota ;
     ItemT.Descricao := ItemF.Descricao ;
     ItemT.Iss       := ItemF.Iss ;
     ItemT.TotalDia  := ItemF.TotalDia ;

     ToObjectList.Add( ItemT ) ;
  end ;
end;

procedure TACBrECFNaoFiscal.CopyFormasPagamento(FromObjectList,
  ToObjectList: TObjectList);
Var A : Integer ;
    ItemF,ItemT : TACBrECFNaoFiscalFormaPagamento ;
begin
  ToObjectList.Clear ;

  For A := 0 to FromObjectList.Count - 1 do
  begin
     ItemF := TACBrECFNaoFiscalFormaPagamento( FromObjectList[A] ) ;
     ItemT := TACBrECFNaoFiscalFormaPagamento.Create ;

     ItemT.Indice    := ItemF.Indice ;
     ItemT.Descricao := ItemF.Descricao ;
     ItemT.TotalDia  := ItemF.TotalDia ;

     ToObjectList.Add( ItemT ) ;
  end ;
end;

procedure TACBrECFNaoFiscal.CopyComprovantesNaoFiscais(FromObjectList,
  ToObjectList: TObjectList);
Var A : Integer ;
    ItemF,ItemT : TACBrECFNaoFiscalComprovanteNaoFiscal ;
begin
  ToObjectList.Clear ;

  For A := 0 to FromObjectList.Count - 1 do
  begin
     ItemF := TACBrECFNaoFiscalComprovanteNaoFiscal( FromObjectList[A] ) ;
     ItemT := TACBrECFNaoFiscalComprovanteNaoFiscal.Create ;

     ItemT.Indice    := ItemF.Indice ;
     ItemT.Descricao := ItemF.Descricao ;
     ItemT.TotalDia  := ItemF.TotalDia ;

     ToObjectList.Add( ItemT ) ;
  end ;
end;

procedure TACBrECFNaoFiscal.CopyItensCupom(FromObjectList,
  ToObjectList: TObjectList);
Var A : Integer ;
    ItemF,ItemT : TACBrECFNaoFiscalItemCupom ;
begin
  ToObjectList.Clear ;

  For A := 0 to FromObjectList.Count - 1 do
  begin
     ItemF := TACBrECFNaoFiscalItemCupom( FromObjectList[A] ) ;
     ItemT := TACBrECFNaoFiscalItemCupom.Create ;

     ItemT.Codigo    := ItemF.Codigo ;
     ItemT.Descricao := ItemF.Descricao ;
     ItemT.Qtd       := ItemF.Qtd ;
     ItemT.ValorUnit := ItemF.ValorUnit ;
     ItemT.PosAliq   := ItemF.PosAliq ;
     ItemT.BaseICMS  := ItemF.BaseICMS ;

     ToObjectList.Add( ItemT ) ;
  end ;
end;

procedure TACBrECFNaoFiscal.CopyPagamentosCupom(FromObjectList,
  ToObjectList: TObjectList);
Var A : Integer ;
    ItemF,ItemT : TACBrECFNaoFiscalPagamentoCupom ;
begin
  ToObjectList.Clear ;

  For A := 0 to FromObjectList.Count - 1 do
  begin
     ItemF := TACBrECFNaoFiscalPagamentoCupom( FromObjectList[A] ) ;
     ItemT := TACBrECFNaoFiscalPagamentoCupom.Create ;

     ItemT.PosFPG    := ItemF.PosFPG ;
     ItemT.ValorPago := ItemF.ValorPago ;

     ToObjectList.Add( ItemT ) ;
  end ;
end;

end.

