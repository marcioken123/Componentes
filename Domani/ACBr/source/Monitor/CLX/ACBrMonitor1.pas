{******************************************************************************}
{ Projeto: ACBr Monitor                                                        }
{  Executavel multiplataforma que faz uso do conjunto de componentes ACBr para }
{ criar uma interface de comunica��o com equipamentos de automacao comercial.  }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                  2005 F�bio Rog�rio Ba�a                     }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Este � software livre; voc� pode redistribu�-lo e/ou modific�-lo            }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Este software � distribu�do na expectativa de que seja �til, por�m, SEM     }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{ F�bio Rog�rio Ba�a  -  rogerio@frbaia.com.br  -  www.frbaia.com.br           }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico ACBr Monitor
|*
|* 07/03/2005: Primeiros Esbo�os
|*    Fabio Rogerio Baia
|* 24/03/2005: Migra�ao para CLX
|*    Daniel Simoes de Almeida
******************************************************************************}
{$DEFINE VisualCLX}
{$I ACBr.inc}

unit ACBrMonitor1;
interface

uses
  SysUtils, Classes, QForms,
  ACBrBase, ACBrECF, ACBrECFClass, ACBrDIS, ACBrGAV, ACBrCHQ,  { Unit do ACBr }
  QTrayIcon, IniFiles, QDialogs,
  QMenus, QTypes, QImgList, QExtCtrls, QStdCtrls, QButtons, QControls,
  QComCtrls, IdBaseComponent, IdComponent, IdTCPServer, ACBrLCB  ;

const
   Versao  = '0.02a' ;
   Estados : array[TACBrECFEstado] of string =
      ('N�o Inicializada', 'Desconhecido', 'Livre', 'Venda',
       'Pagamento', 'Relat�rio', 'Bloqueada', 'Requer Z', 'Requer X' );
   Objetos = '"ECF","CHQ","GAV","DIS"' ;  { Objetos suportados nos Comandos }
   BufferResposta = 1000 ;                { Maximo de Linhas no MemoResposta }

type
TACBrCmd = class
  private
    fsParams : TStringList ;
    fsComando: String;
    fsObjeto : String;
    fsMetodo : String;
    fsResposta: String;
    procedure SetComando(const Value: String);

  public
    constructor Create;
    destructor Destroy; override ;

    function Params( Index : Integer) : String ;

    property Comando : String      read fsComando write SetComando ;
    property Objeto  : String      read fsObjeto ;
    property Metodo  : String      read fsMetodo ;
    property Resposta: String      read fsResposta write fsResposta ;
  end;

type
  TFrmACBrMonitor = class(TForm)
    ACBrECF1: TACBrECF;
    StatusBar1: TStatusBar;
    PageControl1: TPageControl;
    tsMonitor: TTabSheet;
    tsECF: TTabSheet;
    tsCHQ: TTabSheet;
    tsGAV: TTabSheet;
    tsDIS: TTabSheet;
    ImageList1: TImageList;
    cbLog: TCheckBox;
    Label4: TLabel;
    edArqLog: TEdit;
    Label8: TLabel;
    cbECFModelo: TComboBox;
    Label9: TLabel;
    cbECFPorta: TComboBox;
    Label10: TLabel;
    edECFTimeout: TEdit;
    chECFBloqueia: TCheckBox;
    chECFArredondaPorQtd: TCheckBox;
    chECFExibeMsg: TCheckBox;
    chECFTentar: TCheckBox;
    Label11: TLabel;
    mECFMsg: TMemo;
    cbSenha: TCheckBox;
    Label3: TLabel;
    edSenha: TEdit;
    gbTCP: TGroupBox;
    Label5: TLabel;
    edPortaTCP: TEdit;
    gbTXT: TGroupBox;
    Label6: TLabel;
    Label7: TLabel;
    edEntTXT: TEdit;
    edSaiTXT: TEdit;
    Label12: TLabel;
    cbCHQModelo: TComboBox;
    Label13: TLabel;
    cbCHQPorta: TComboBox;
    Label15: TLabel;
    cbGAVModelo: TComboBox;
    Label16: TLabel;
    cbGAVPorta: TComboBox;
    bGAVAbrir: TBitBtn;
    bGAVEstado: TBitBtn;
    Label17: TLabel;
    cbDISPorta: TComboBox;
    Label18: TLabel;
    cbDISModelo: TComboBox;
    Label19: TLabel;
    edDISIntervalo: TEdit;
    Label20: TLabel;
    edDISPassos: TEdit;
    bDISTestar: TBitBtn;
    bECFTestar: TBitBtn;
    bECFLeituraX: TBitBtn;
    bCHQTestar: TBitBtn;
    bDISLimpar: TBitBtn;
    ACBrCHQ1: TACBrCHQ;
    ACBrGAV1: TACBrGAV;
    ACBrDIS1: TACBrDIS;
    chCHQVerForm: TCheckBox;
    Label14: TLabel;
    lGAVEstado: TLabel;
    bECFAtivar: TBitBtn;
    pmTray: TPopupMenu;
    Restaurar1: TMenuItem;
    Encerrar1: TMenuItem;
    Ocultar1: TMenuItem;
    N1: TMenuItem;
    Label21: TLabel;
    edGAVStrAbre: TEdit;
    rbTCP: TRadioButton;
    rbTXT: TRadioButton;
    pBotoes: TPanel;
    btOk: TBitBtn;
    bConfig: TButton;
    pCmd: TPanel;
    mCmd: TMemo;
    pRespostas: TPanel;
    mResp: TMemo;
    pTopRespostas: TPanel;
    pTopCmd: TPanel;
    Splitter1: TSplitter;
    TCPServer: TIdTCPServer;
    tsLCB: TTabSheet;
    cbxLCBPorta: TComboBox;
    edLCBSufLeitura: TEdit;
    edLCBIntervalo: TEdit;
    cbLCBExcluirSufixo: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label22: TLabel;
    ACBrLCB1: TACBrLCB;
    BitBtn1: TBitBtn;
    Label23: TLabel;
    edLCBPreExcluir: TEdit;
    lLCBCodigoLido: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    edLCBSufINC: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure TCPServerExecute(AThread: TIdPeerThread);
    procedure TCPServerConnect(AThread: TIdPeerThread);
    procedure TCPServerDisconnect(AThread: TIdPeerThread);
    procedure ACBrECF1MsgAguarde(Mensagem: String);
    procedure ACBrECF1MsgPoucoPapel(Sender: TObject);
    procedure ACBrECF1AguardandoRespostaChange(Sender: TObject);
    procedure bConfigClick(Sender: TObject);
    procedure cbLogClick(Sender: TObject);
    procedure cbSenhaClick(Sender: TObject);
    procedure edPortaTCPKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure bECFTestarClick(Sender: TObject);
    procedure bECFLeituraXClick(Sender: TObject);
    procedure bECFAtivarClick(Sender: TObject);
    procedure tsECFShow(Sender: TObject);
    procedure Ocultar1Click(Sender: TObject);
    procedure Restaurar1Click(Sender: TObject);
    procedure Encerrar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbGAVModeloChange(Sender: TObject);
    procedure cbGAVPortaChange(Sender: TObject);
    procedure bGAVEstadoClick(Sender: TObject);
    procedure bGAVAbrirClick(Sender: TObject);
    procedure cbDISModeloChange(Sender: TObject);
    procedure cbDISPortaChange(Sender: TObject);
    procedure edDISIntervaloChange(Sender: TObject);
    procedure edDISPassosChange(Sender: TObject);
    procedure bDISLimparClick(Sender: TObject);
    procedure bDISTestarClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure edGAVStrAbreChange(Sender: TObject);
    procedure rbTCPTXTClick(Sender: TObject);
    procedure cbCHQModeloChange(Sender: TObject);
    procedure cbCHQPortaChange(Sender: TObject);
    procedure cbECFModeloChange(Sender: TObject);
    procedure cbECFPortaChange(Sender: TObject);
    procedure chECFArredondaPorQtdClick(Sender: TObject);
    procedure chECFBloqueiaClick(Sender: TObject);
    procedure chECFExibeMsgClick(Sender: TObject);
    procedure chECFTentarClick(Sender: TObject);
    procedure edECFTimeoutChange(Sender: TObject);
    procedure mECFMsgChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Conexao   : TIdPeerThread;
    TrayIcon  : TTrayIcon ;
    ACBrTimer : TACBrThreadTimer ;
    ACBrMonitorINI : string;
    Inicio  : Boolean ;
    Working : Boolean ;
    ArqSaiTXT, ArqEntTXT, ArqLogTXT : String ;
    Cmd : TACBrCmd ;

    procedure Inicializar ;
    procedure EscondeConfig ;
    procedure ExibeConfig ;
    procedure LerIni ;
    procedure SalvarIni ;
    procedure Desativar ;

    procedure DoACBrTimer(Sender: TObject);
    Procedure Processar ;
    Procedure Resposta(Comando, Resposta : string);
    Procedure GravaArqResp(ArqTXT, Retorno : string);

    function AcertaPath( APath : String ) : String ;
  public
  end;

var
  FrmACBrMonitor: TFrmACBrMonitor;

implementation

uses StrUtils, DoECFUnit {$IFDEF MSWINDOWS},sndkey32{$ENDIF} ;
{$R *.xfm}

{----------------------------------- TACBrCmd ---------------------------------}
constructor TACBrCmd.Create;
begin
  fsParams := TStringList.Create ;
end;

destructor TACBrCmd.Destroy;
begin
  fsParams.Free ;
  inherited Destroy ;
end;

function TACBrCmd.Params(Index: Integer): String;
begin
  if Index > fsParams.Count-1 then
     Result := ''
  else
     Result := fsParams[Index] ;
end;

procedure TACBrCmd.SetComando(const Value: String);
Var P,PaI,PaF,Pv : Integer ;
    wComando : string ;
    wParam   : STring ;
begin
  fsMetodo   := '' ;
  fsObjeto   := '' ;
  fsResposta := '' ;
  fsParams.Clear ;

  fsComando := Value ;
  wComando  := Value ;

  { Achando o Objeto }
  P := pos('.',wComando) ;
  if P = 0 then
     raise Exception.Create('Objeto nao definido') ;

  fsObjeto := UpperCase( Trim(copy(fsComando,1,P-1)) ) ;
  if pos('"'+fsObjeto+'"', Objetos) = 0 then
     raise Exception.Create('Objeto inv�lido: '+fsObjeto+sLineBreak+
                            ' Permitidos: '+Objetos ) ;

  { Achando o Metodo }
  wComando := copy(wComando, P+1, Length(wComando) ) ;
  P := pos('(',wComando) ;
  if P = 0 then
  begin
     { Verificando se � uma atribui��o a propriedade Ex: "Ativo := true" }
     P := pos(':=',wComando) ;
     if P > 0 then
      begin
         wComando := 'Set'+Trim(copy(wComando,1,P-1))+'('+
                           Trim(copy(wComando,1,P+2))+')' ;
         P := pos('(',wComando) ;
      end 
     else
        P := Length( wComando ) + 1 ;
  end ;

  fsMetodo := LowerCase( Trim(copy(wComando,1,P-1)) ) ;
  if fsMetodo = '' then
     raise Exception.Create('Metodo n�o definido') ;

  { Tem Parameteros ? }
  wComando := copy(wComando, P+1, Length(wComando) ) ;
  while Length(wComando) > 0 do
  begin
     PaI := pos('"',wComando) ;
     Pv  := pos(',',wComando) ;  { Procurando o Fim do parametro }
     if Pv = 0 then
        Pv := pos(')',wComando) ;
     if Pv = 0 then
        Pv := Length( wComando ) + 1;

     if (PaI <> 0) and (PaI < Pv) then  { Tem aspas no Inicio do Comando }
      begin                             { Entao procure a proxima Aspas }
        PaF := Pos('"',copy(wComando, PaI+1, Length(Wcomando)) ) ;
        if PaF = 0 then
           raise Exception.Create('Parametro Inv�lido. String n�o terminada');

        wParam := copy(wComando, PaI+1 , PaF-1 ) ;
        Pv := PaI + PaF + 1 ;
      end
     else
        wParam := copy(wComando, 1, Pv-1 ) ;

     fsParams.Add(wParam) ;
     wComando := copy(wComando, Pv+1, Length( wComando ) ) ;
  end ;
end;

{-------------------------------- TFrmACBrMonitor -----------------------------}
procedure TFrmACBrMonitor.FormCreate(Sender: TObject);
Var MemStream : TMemoryStream ;
begin
  mResp.Clear ;
  mCmd.Clear ;
  Cmd       := TACBrCmd.Create ;
  Inicio    := true ;
  ArqSaiTXT := '' ;
  ArqEntTXT := '' ;
  ArqLogTXT := '' ;

  { Criando TrayIcon, e copiando Icone do Form }
  MemStream := TMemoryStream.Create;
  try
     Icon.SaveToStream(MemStream);
     TrayIcon := TTrayIcon.Create(self);
     with TrayIcon do
     begin
        Icon.LoadFromStream(MemStream);
        PopupMenu   := pmTray ;
        ToolTip     := 'ACBrMonitor '+ Versao +
                        {$IFDEF LINUX}#10{$ELSE}#13{$ENDIF}+
                       'ACBr: '+ACBR_VERSAO ;
        OnDblClick  := Restaurar1Click ;
        OnClick     := Restaurar1Click ;
        ShowToolTip := true ;
        Masked      := true ;
        AutoShow    := true ;
        Visible     := true ;
     end ;
  finally
     MemStream.Free ;
  end ;

  Caption := 'ACBrMonitor '+ Versao + ' - ACBr: '+ACBR_VERSAO ;
  Application.OnMinimize := Ocultar1Click ;
  Application.OnRestore  := Restaurar1Click ;
  Application.Title      := Caption ;

  EscondeConfig ;
  PageControl1.ActivePageIndex := 0 ;

  { Criando o ACBrTimer (Timer em Thread separada) }
  ACBrTimer := TACBrThreadTimer.Create ;
  ACBrTimer.Interval := 1000 ;
  ACBrTimer.OnTimer  := DoACBrTimer ;
  ACBrTimer.Enabled  := True ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.FormDestroy(Sender: TObject);
begin
  Cmd.Free ;
  ACBrTimer.Enabled := false ;
  ACBrTimer.Free ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.FormShow(Sender: TObject);
begin
  TrayIcon.Show ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Desativar ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.Restaurar1Click(Sender: TObject);
begin
  TrayIcon.Visible := false ;
  Application.ShowMainForm := true ;
  Visible := true ;
  WindowState := wsNormal ;
  Application.Restore ;
  Application.BringToFront ;
  TrayIcon.Visible := true ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.Ocultar1Click(Sender: TObject);
begin
  if WindowState <> wsMinimized then
     WindowState := wsMinimized ;
//  Application.Minimize ;
  Visible := false ;
  Application.ShowMainForm := false ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.Encerrar1Click(Sender: TObject);
begin
  close ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.btOkClick(Sender: TObject);
begin
  Ocultar1Click( Sender );
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bConfigClick(Sender: TObject);
begin
  if PageControl1.Visible then
   begin
     EscondeConfig ;
     SalvarIni ;
     LerIni ; { Para as altera�oes fazerem efeito }
   end
  else
     ExibeConfig ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.rbTCPTXTClick(Sender: TObject);
begin
  gbTCP.Enabled := rbTCP.Checked ;
  gbTXT.Enabled := rbTXT.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbSenhaClick(Sender: TObject);
begin
  edSenha.Enabled := cbSenha.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbLogClick(Sender: TObject);
begin
  edArqLog.Enabled := cbLog.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edPortaTCPKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not ( Key in ['0'..'9',#13,#8] ) then
     Key := #0 ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.ACBrECF1MsgAguarde(Mensagem: String);
begin
  StatusBar1.Panels[2].Text := Mensagem ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.ACBrECF1MsgPoucoPapel(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := 'ATEN�AO. Pouco papel'
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.ACBrECF1AguardandoRespostaChange(Sender: TObject);
begin
  if ACBrECF1.AguardandoResposta then
     StatusBar1.Panels[1].Text := 'Processando...'
  else
     StatusBar1.Panels[1].Text := '' ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.DoACBrTimer(Sender: TObject);
var SL : TStringList ;
begin
  ACBrTimer.Enabled := false;

  if Inicio then
  begin
     Inicializar ;
     exit;
  end ;

  try
     if FileExists( ArqEntTXT ) then  { Existe arquivo para ler ? }
     begin
       { Lendo em StringList tempor�rio para nao apagar comandos nao processados }
       SL := TStringList.Create ;
       try
          try
             SL.LoadFromFile( ArqEntTXT );
             DeleteFile( ArqEntTXT );
          except
             { Ignora Exce�oes na Tentativa de Leitura o Dele�ao }
          end ;
          mCmd.Lines.AddStrings( SL );
       finally
          SL.Free ;
       end ;

       Processar ;
     end;
  finally
     ACBrTimer.Enabled := True;
  end ;
end;

{---------------------------------- ACBrECF -----------------------------------}
{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.tsECFShow(Sender: TObject);
begin
  if ACBrECF1.Ativo then
   begin
     bECFAtivar.Caption := '&Desativar' ;
     ImageList1.GetBitmap(6,bECFAtivar.Glyph);
   end
  else
   begin
     bECFAtivar.Caption := '&Ativar' ;
     ImageList1.GetBitmap(5,bECFAtivar.Glyph);
   end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbECFModeloChange(Sender: TObject);
begin
  try
     ACBrECF1.Modelo := TACBrECFModelo( cbECFModelo.ItemIndex ) ;
  finally
     cbECFModelo.ItemIndex := Integer( ACBrECF1.Modelo ) ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbECFPortaChange(Sender: TObject);
begin
  try
    ACBrECF1.Porta := cbECFPorta.Text ;
  finally
     cbECFPorta.Text := ACBrECF1.Porta ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edECFTimeoutChange(Sender: TObject);
begin
  ACBrECF1.TimeOut := StrToIntDef(edECFTimeout.Text, ACBrECF1.TimeOut ) ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.chECFTentarClick(Sender: TObject);
begin
  ACBrECF1.ReTentar := chECFTentar.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.chECFBloqueiaClick(Sender: TObject);
begin
  ACBrECF1.BloqueiaMouseTeclado := chECFBloqueia.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.chECFExibeMsgClick(Sender: TObject);
begin
  ACBrECF1.ExibeMensagem := chECFExibeMsg.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.chECFArredondaPorQtdClick(Sender: TObject);
begin
  ACBrECF1.ArredondaPorQtd := chECFArredondaPorQtd.Checked ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.mECFMsgChange(Sender: TObject);
Var Msg : String ;
    L : Integer ;
begin
  Msg := '' ;
  For L := 0 to mECFMsg.Lines.Count - 1 do
  begin
     Msg := Msg + mECFMsg.Lines[L]+#10
  end ;

  ACBrECF1.MsgAguarde := copy(Msg, 1, Length(Msg)-1 ) ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bECFAtivarClick(Sender: TObject);
begin
  if bECFAtivar.Caption = '&Ativar' then
   begin
     try
        if cbECFModelo.ItemIndex = 0 then
           if not ACBrECF1.AcharECF(true,False) then
           begin
              MessageDlg('Nenhum ECF encontrado.',mtInformation,[mbOk],0) ;
              exit ;
           end ;

        ACBrECF1.Ativar ;
     finally
        cbECFModelo.ItemIndex := Integer(ACBrECF1.Modelo) ;
        cbECFPorta.Text       := ACBrECF1.Porta ;
     end ;
   end
  else
     ACBrECF1.Desativar ;

  tsECFShow( Sender );
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bECFTestarClick(Sender: TObject);
begin
  ACBrECF1.TestarDialog ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bECFLeituraXClick(Sender: TObject);
var wAtivo : Boolean ;
begin
  wAtivo := ACBrECF1.Ativo ;

  try
     if not ACBrECF1.Ativo then
        ACBrECF1.Ativar ;

     ACBrECF1.LeituraX ;
  finally
     ACBrECF1.Ativo := wAtivo ;
  end ;
end;

{------------------------------------ ACBrCHQ ---------------------------------}
procedure TFrmACBrMonitor.cbCHQModeloChange(Sender: TObject);
begin
  try
     ACBrCHQ1.Modelo := TACBrCHQModelo( cbCHQModelo.ItemIndex ) ;

     if ACBrCHQ1.Modelo = chqImpressoraECF then
        ACBrCHQ1.ECF := ACBrECF1 ;
  finally
     cbCHQModelo.ItemIndex := Integer( ACBrCHQ1.Modelo ) ;
     cbCHQPorta.Text       := ACBrCHQ1.Porta ;
  end ;end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbCHQPortaChange(Sender: TObject);
begin
  if ACBrCHQ1.Modelo <> chqImpressoraECF then
  begin
     Try
        ACBrCHQ1.Porta := cbCHQPorta.Text ;
     finally
        cbCHQPorta.Text := ACBrCHQ1.Porta ;
     end ;
  end ;
end;

{------------------------------------ ACBrGAV ---------------------------------}
procedure TFrmACBrMonitor.cbGAVModeloChange(Sender: TObject);
begin
  try
     ACBrGAV1.Modelo := TACBrGAVModelo( cbGAVModelo.ItemIndex ) ;

     if ACBrGAV1.Modelo = gavImpressoraECF then
        ACBrGAV1.ECF := ACBrECF1 ;
  finally
     cbGAVModelo.ItemIndex := Integer( ACBrGAV1.Modelo ) ;
     cbGAVPorta.Text       := ACBrGAV1.Porta ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbGAVPortaChange(Sender: TObject);
begin
  if ACBrGAV1.Modelo <> gavImpressoraECF then
  begin
     Try
        ACBrGAV1.Porta := cbGAVPorta.Text ;
     finally
        cbGAVPorta.Text := ACBrGAV1.Porta ;
     end ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edGAVStrAbreChange(Sender: TObject);
begin
  ACBrGAV1.StrComando := edGAVStrAbre.Text ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bGAVEstadoClick(Sender: TObject);
begin
  if ACBrGAV1.Ativo then
   begin
     if ACBrGAV1.GavetaAberta then
        lGAVEstado.Caption := 'Aberta'
     else
        lGAVEstado.Caption := 'Fechada' ;
   end
  else
     lGAVEstado.Caption := 'Desconhecido' ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bGAVAbrirClick(Sender: TObject);
begin
  ACBrGAV1.AbreGaveta ;
end;

{------------------------------------ ACBrDIS ---------------------------------}
procedure TFrmACBrMonitor.cbDISModeloChange(Sender: TObject);
begin
  try
     ACBrDIS1.Modelo := TACBrDISModelo( cbDISModelo.ItemIndex ) ;
  finally
     cbDISModelo.ItemIndex := Integer( ACBrDIS1.Modelo ) ;
     cbDISPorta.Text       := ACBrDIS1.Porta ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.cbDISPortaChange(Sender: TObject);
begin
  Try
     ACBrDIS1.Porta := cbDISPorta.Text ;
  finally
     cbDISPorta.Text := ACBrDIS1.Porta ;
  end ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edDISIntervaloChange(Sender: TObject);
begin
  ACBrDIS1.Intervalo := StrToIntDef( edDISIntervalo.Text, 0) ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.edDISPassosChange(Sender: TObject);
begin
  ACBrDIS1.Passos := StrToIntDef( edDISPassos.Text, 0) ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bDISLimparClick(Sender: TObject);
begin
  ACBrDIS1.LimparDisplay ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.bDISTestarClick(Sender: TObject);
begin
  ACBrDIS1.ExibirLinha(1,'Projeto ACBr'        ,efeDireita_Esquerda) ;
  ACBrDIS1.ExibirLinha(2,'acbr.sourceforge.net',efeEsquerda_Direita) ;
end;

{------------------------- Procedures de Uso Interno --------------------------}
procedure TFrmACBrMonitor.Inicializar;
begin
  Inicio          := false ;
  ACBrMonitorINI  := ExtractFilePath(Application.ExeName)+ 'ACBrMonitor.ini';

  if not FileExists( ACBrMonitorINI ) then //verifica se o arq. de config existe
  begin                                    //se nao existir vai para as configs
    ShowMessage('Arquivos de Configura��o n�o encontrado.'+sLineBreak+sLineBreak+
                'Favor configurar o ACBrMonitor e clicar em Salvar.');
    bConfig.Click ;
  end;

  LerIni;

  Ocultar1Click( self );

  bConfig.Enabled    := true ;
  ACBrTimer.Interval := 300 ;
  ACBrTimer.Enabled  := rbTXT.Checked ;
  TCPServer.Active   := rbTCP.Checked;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.Desativar;
begin
//   if Assigned( Conexao ) then
//      conexao.Connection.Disconnect;

  TCPServer.Active  := False ;    { Desliga TCP }
  ACBrTimer.Enabled := False ;    { Desliga TXT }
  ACBrECF1.Desativar ;
  ACBrCHQ1.Desativar ;
  ACBrGAV1.Desativar ;
  ACBrDIS1.Desativar ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.LerIni ;
var Ini : TIniFile;
begin
  Ini := TIniFile.Create( ACBrMonitorINI ) ;

  try
     { Parametros do Monitor }
     rbTCP.Checked   := Ini.ReadBool('ACBrMonitor','Modo_TCP',false);
     rbTXT.Checked   := Ini.ReadBool('ACBrMonitor','Modo_TXT',false);
     edPortaTCP.Text := IntToStr(Ini.ReadInteger('ACBrMonitor','TCP_Porta',3434));
     edEntTXT.Text   := Ini.ReadString('ACBrMonitor','TXT_Entrada','ENT.TXT');
     edSaiTXT.Text   := Ini.ReadString('ACBrMonitor','TXT_Saida','SAI.TXT');
     cbSenha.Checked := Ini.ReadBool('ACBrMonitor','Protegido',false);
     edSenha.Text    := Ini.ReadString('ACBrMonitor','Senha','');
     cbLog.Checked   := Ini.ReadBool('ACBrMonitor','Gravar_Log',false);
     edArqLog.Text   := Ini.ReadString('ACBrMonitor','Arquivo_Log','LOG.TXT');

     ArqEntTXT := AcertaPath( edEntTXT.Text ) ;
     ArqSaiTXT := AcertaPath( edSaiTXT.Text ) ;
     ArqLogTXT := AcertaPath( edArqLog.Text ) ;

     TCPServer.DefaultPort := StrToInt( edPortaTCP.Text ) ;

     { Parametros do ECF }
     cbECFModelo.ItemIndex := Ini.ReadInteger('ECF','Modelo',0);
     cbECFPorta.Text       := Ini.ReadString('ECF','Porta','Procurar');
     edECFTimeout.Text     := IntToStr(Ini.ReadInteger('ECF','Timeout',3));
     chECFTentar.Checked   := Ini.ReadBool('ECF','TentarNovamente',false);
     chECFBloqueia.Checked := Ini.ReadBool('ECF','BloqueiaMouseTeclado',true);
     chECFExibeMsg.Checked := Ini.ReadBool('ECF','ExibirMsgAguarde',true);
     chECFArredondaPorQtd.Checked := Ini.ReadBool('ECF','ArredondamentoPorQtd',false);
     mECFMsg.Text := Ini.ReadString('ECF','Mensagem',
                     'Aguardando o retorno do ECF'+sLineBreak+
                     ' Faltam %d segundos para TimeOut') ;

     { Parametros do CHQ }
     cbCHQModelo.ItemIndex := Ini.ReadInteger('CHQ','Modelo',0);
     cbCHQPorta.Text       := Ini.ReadString('CHQ','Porta','');
     chCHQVerForm.Checked  := Ini.ReadBool('CHQ','VerificaFormulario',false);

     { Parametros do GAV }
     cbGAVModelo.ItemIndex := Ini.ReadInteger('GAV','Modelo',0);
     cbGAVPorta.Text       := Ini.ReadString('GAV','Porta','');
     edGAVStrAbre.Text     := Ini.ReadString('GAV','StringAbertura','');

     { Parametros do DIS }
     cbDISModelo.ItemIndex := Ini.ReadInteger('DIS','Modelo',0);
     cbDISPorta.Text       := Ini.ReadString('DIS','Porta','');
     edDISIntervalo.Text   := IntToStr(Ini.ReadInteger('DIS','Intervalo',300));
     edDISPassos.Text      := IntToStr(Ini.ReadInteger('DIS','Passos',1));
  finally
     Ini.Free ;
  end ;

  with ACBrECF1 do
  begin
     Desativar ;
     Modelo               := TACBrECFModelo( cbECFModelo.ItemIndex ) ;
     Porta                := cbECFPorta.Text ;
     TimeOut              := StrToIntDef(edECFTimeout.Text,3) ;
     MsgAguarde           := mECFMsg.Text ;
     ReTentar             := chECFTentar.Checked ;
     BloqueiaMouseTeclado := chECFBloqueia.Checked ;
     ExibeMensagem        := chECFExibeMsg.Checked ;
     ArredondaPorQtd      := chECFArredondaPorQtd.Checked ;
  end ;

  with ACBrCHQ1 do
  begin
     Desativar ;
     Modelo := TACBrCHQModelo( cbCHQModelo.ItemIndex ) ;
     Porta  := cbCHQPorta.Text ;
  end ;

  with ACBrGAV1 do
  begin
     Desativar ;
     StrComando := edGAVStrAbre.Text ;
     Modelo     := TACBrGAVModelo( cbGAVModelo.ItemIndex ) ;
     Porta      := cbGAVPorta.Text ;
  end ;
     
  with ACBrDIS1 do
  begin
     Desativar ;
     Intervalo := StrToIntDef(edDISIntervalo.Text,0) ;
     Passos    := StrToIntDef(edDISPassos.Text,1) ;
     Modelo    := TACBrDISModelo( cbDISModelo.ItemIndex ) ;
     Porta     := cbDISPorta.Text ;
  end ;
end;

procedure TFrmACBrMonitor.SalvarIni;
var Ini : TIniFile;
begin
  Ini := TIniFile.Create( ACBrMonitorINI ) ;

  try
     // Parametros do Monitor //
     Ini.WriteBool('ACBrMonitor','Modo_TCP',rbTCP.Checked);
     Ini.WriteBool('ACBrMonitor','Modo_TXT',rbTXT.Checked);
     Ini.WriteInteger('ACBrMonitor','TCP_Porta',StrToIntDef(edPortaTCP.Text,3434));
     Ini.WriteString('ACBrMonitor','TXT_Entrada',edEntTXT.Text);
     Ini.WriteString('ACBrMonitor','TXT_Saida',edSaiTXT.Text);
     Ini.WriteBool('ACBrMonitor','Protegido',cbSenha.Checked);
     Ini.WriteString('ACBrMonitor','Senha',edSenha.Text);
     Ini.WriteBool('ACBrMonitor','Gravar_Log',cbLog.Checked);
     Ini.WriteString('ACBrMonitor','Arquivo_Log',edArqLog.Text);

     // Parametros do ECF //
     Ini.WriteInteger('ECF','Modelo',cbECFModelo.ItemIndex);
     Ini.WriteString('ECF','Porta',cbECFPorta.Text);
     Ini.WriteInteger('ECF','Timeout',StrToIntDef(edECFTimeout.Text,3));
     Ini.WriteBool('ECF','TentarNovamente',chECFTentar.Checked);
     Ini.WriteBool('ECF','BloqueiaMouseTeclado',chECFBloqueia.Checked);
     Ini.WriteBool('ECF','ExibirMsgAguarde',chECFExibeMsg.Checked);
     Ini.WriteBool('ECF','ArredondamentoPorQtd',chECFArredondaPorQtd.Checked);
     Ini.WriteString('ECF','Mensagem', mECFMsg.Text ) ;

     { Parametros do CHQ }
     Ini.WriteInteger('CHQ','Modelo',cbCHQModelo.ItemIndex);
     Ini.WriteString('CHQ','Porta',cbCHQPorta.Text);
     Ini.WriteBool('CHQ','VerificaFormulario',chCHQVerForm.Checked);

     { Parametros do GAV }
     Ini.WriteInteger('GAV','Modelo',cbGAVModelo.ItemIndex);
     Ini.WriteString('GAV','Porta',cbGAVPorta.Text);
     Ini.WriteString('GAV','StringAbertura',edGAVStrAbre.Text);

     { Parametros do DIS }
     Ini.WriteInteger('DIS','Modelo',cbDISModelo.ItemIndex);
     Ini.WriteString('DIS','Porta',cbDISPorta.Text);
     Ini.WriteInteger('DIS','Intervalo',StrToIntDef(edDISIntervalo.Text,300));
     Ini.WriteInteger('DIS','Passos',StrToIntDef(edDISPassos.Text,1));
  finally
     Ini.Free ;
  end ;
end;


{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.EscondeConfig;
begin
  Constraints.MinHeight := 0 ;
  PageControl1.Visible := False ;

  bConfig.Caption := 'Configurar >>' ;
  btOk.Enabled := true ;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.ExibeConfig;
Var Senha : String ;
    SenhaOk : Boolean ;
begin
  SenhaOk := false ;
  if cbSenha.Checked then
   begin
     Senha := '' ;
     if InputQuery('Configura��o','Digite a Senha de Configura��o',Senha) then
        SenhaOk := (Senha = edSenha.Text)
   end
  else
     SenhaOk := true ;

  if not SenhaOk then exit ;

  PageControl1.Align   := alNone ;
  PageControl1.Visible := true ;
  PageControl1.Align   := alBottom ;

  bConfig.Caption := '<<  Salvar' ;
  btOk.Enabled := false ;
end;

procedure TFrmACBrMonitor.TCPServerExecute(AThread: TIdPeerThread);
begin
  { Le o que foi enviado atravez da conexao TCP }
  mCmd.Lines.Add(trim(Athread.Connection.ReadLn()));
  Processar ;
end;

procedure TFrmACBrMonitor.TCPServerConnect(AThread: TIdPeerThread);
begin
  conexao := AThread;
{  Athread.Connection.WriteLn('ACBr Monitor Ver.'+Versao);
  Athread.Connection.WriteLn('Conectado com sucesso !');
  Athread.Connection.WriteLn('Esperando por comandos.');}
  Resposta('','ACBr Monitor Ver.'+Versao);
  Resposta('','Conectado com sucesso - '+Conexao.Connection.Socket.LocalName);
  Resposta('','Esperando por comandos.');
end;

procedure TFrmACBrMonitor.TCPServerDisconnect(AThread: TIdPeerThread);
begin
  if Assigned( Conexao ) then
     Conexao.Connection.Disconnect;
  mCmd.Lines.Clear;
end;

{------------------------------------------------------------------------------}
procedure TFrmACBrMonitor.Processar;
var
  Linha : string;
begin
  if Working then exit ;{ Evita chamadas recursivas disparadas a cada OnChange }

  Working := true ;
  try
     while mCmd.Lines.Count > 0 do
     begin
        Application.ProcessMessages ;

        Linha := Trim( mCmd.Lines[0] );
        mCmd.Lines.Delete(0);

        try
           if pos('.',Linha) = 0 then              { Comandos do ACBrMonitor }
           begin
              Linha := LowerCase( Linha ) ;
              if (Linha = 'exit') or (Linha = 'bye') or (Linha = 'fim') or
                 (Linha = 'sair') then {fecha conexao}
               begin
                 Resposta(Linha, 'Obrigado por usar o ACBrMonitor');
                 Desativar ;
               end
              else
                 raise Exception.Create('Comando inv�lido: '+Linha) ;

              exit ;
           end ;

           Cmd.Comando := Linha ;

           if Cmd.Objeto = 'ECF' then
              DoECF( Cmd ) ;{
           else if Cmd.Objeto = 'CHQ' then
              DoCHQ( Cmd )
           else if Cmd.Objeto = 'GAV' then
              DoGAV( Cmd )
           else if Cmd.Objeto = 'DIS' then
              DoDIS( Cmd );  }

           Resposta(Linha, 'OK: '+Cmd.Resposta );
        except
           on E : Exception do
              Resposta(Linha, 'ERRO: '+E.Message );
        end ;
     end ;
  finally
     Working := false ;
  end ;
end;

{------------------------------------------------------------------------------}
Procedure TFrmACBrMonitor.Resposta(Comando, Resposta : string );
begin
  if rbTCP.Checked then
  begin
     if Assigned( conexao ) then
        conexao.Connection.WriteLn(Resposta) ;
  end ;

  if rbTXT.Checked then
     GravaArqResp(ArqSaiTXT, Resposta);

  mResp.Lines.BeginUpdate ;
  mResp.Lines.Add( Comando + sLineBreak + Resposta ) ;
  while mResp.Lines.Count > BufferResposta do
     mResp.Lines.Delete(0) ;
  mResp.Lines.EndUpdate ;

  if cbLog.Checked then
     GravaArqResp(ArqLogTXT, Comando + sLineBreak + Resposta);
end;

{------------------------------------------------------------------------------}
Procedure TFrmACBrMonitor.GravaArqResp(ArqTXT, Retorno : string);
var
  Arq : textfile;
begin
  AssignFile( Arq, ArqTXT) ;
  if not FileExists(ArqTXT) then
     Rewrite( Arq )
  else
     Append( Arq ) ;

  Writeln( Arq, Retorno ) ;

  Flush( Arq ) ;
  CloseFile( Arq ) ;
end;

{------------------------------------------------------------------------------}
function TFrmACBrMonitor.AcertaPath(APath : String): String;
begin
  Result := trim(APath) ;
  if pos(PathDelim, APath) = 0 then
     Result := ExtractFilePath( Application.ExeName ) + APath ;
end;

end.

