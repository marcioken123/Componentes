unit ECFTeste1;

interface

uses ACBrECF, ACBrBase, ACBrECFClass, ACBrECFBematech, 
  StrUtils, SysUtils, Classes, Types, Graphics,
  Controls, Forms, Dialogs, StdCtrls,  ComCtrls, Buttons, ExtCtrls,
  Menus;

type
  TForm1 = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    StatusBar1: TStatusBar;
    mEnviado: TMemo;
    mResp: TMemo;
    MainMenu1: TMainMenu;
    Principal1: TMenuItem;
    Sair1: TMenuItem;
    Sobre1: TMenuItem;
    N1: TMenuItem;
    Ativcar1: TMenuItem;
    Desativar1: TMenuItem;
    N2: TMenuItem;
    Testar1: TMenuItem;
    cbxModelo: TComboBox;
    Label1: TLabel;
    Label4: TLabel;
    cbxPorta: TComboBox;
    edTimeout: TEdit;
    Label5: TLabel;
    chTentar: TCheckBox;
    chBloqueia: TCheckBox;
    chExibeMsg: TCheckBox;
    mMsg: TMemo;
    Label6: TLabel;
    bAtivar: TButton;
    Variaveis1: TMenuItem;
    DataHora1: TMenuItem;
    NumECF1: TMenuItem;
    NSrie1: TMenuItem;
    NVerso1: TMenuItem;
    N3: TMenuItem;
    PoucoPapel1: TMenuItem;
    Estado1: TMenuItem;
    Relatrios1: TMenuItem;
    LeituraX1: TMenuItem;
    ReduoZ1: TMenuItem;
    N4: TMenuItem;
    AliquotasICMS1: TMenuItem;
    FormasdePagamento1: TMenuItem;
    CopumFiscal1: TMenuItem;
    AbrirCupom1: TMenuItem;
    N5: TMenuItem;
    VenderItem1: TMenuItem;
    CancelarItemVendido1: TMenuItem;
    N6: TMenuItem;
    Sub1: TMenuItem;
    EfetuarPagamento1: TMenuItem;
    FecharCupom1: TMenuItem;
    CancelaCupom1: TMenuItem;
    N8: TMenuItem;
    Variveis1: TMenuItem;
    NUltimoCupom1: TMenuItem;
    SubTotal1: TMenuItem;
    TotalPago1: TMenuItem;
    N9: TMenuItem;
    RelatorioGerencial1: TMenuItem;
    N10: TMenuItem;
    CupomVinculado1: TMenuItem;
    FechaRelatrio1: TMenuItem;
    Dispositivos1: TMenuItem;
    Gaveta1: TMenuItem;
    GavetaAberta1: TMenuItem;
    AbreGaveta1: TMenuItem;
    Cheque1: TMenuItem;
    CancelaImpressoCheque1: TMenuItem;
    ImprimeCheque1: TMenuItem;
    ChequePronto1: TMenuItem;
    Utilitrios1: TMenuItem;
    HorarioVerao1: TMenuItem;
    ImpactoAgulhas1: TMenuItem;
    N7: TMenuItem;
    EnviaComando1: TMenuItem;
    TestaPodeAbrirCupom1: TMenuItem;
    ACBrECF1: TACBrECF;
    CarregaComprovantesNAOFiscais1: TMenuItem;
    HorarioVerao2: TMenuItem;
    Arredonda1: TMenuItem;
    MudaArredondamento1: TMenuItem;
    NumLoja1: TMenuItem;
    NumCRO1: TMenuItem;
    N11: TMenuItem;
    TestedeVelocidade1: TMenuItem;
    chArredondaPorQtd: TCheckBox;
    N12: TMenuItem;
    LeituradeMemoriaFiscal1: TMenuItem;
    CapturaporNReduaoZ1: TMenuItem;
    CapturaporPeriodo1: TMenuItem;
    ImprimeporNReduaoZ1: TMenuItem;
    ImprimeporPeriodo1: TMenuItem;
    ProgramaAliquota1: TMenuItem;
    N13: TMenuItem;
    ProgramaComprovanteNAOFiscal1: TMenuItem;
    ProgramaFormadePagamento1: TMenuItem;
    CorrigeEstadodeErro1: TMenuItem;
    N14: TMenuItem;
    procedure cbxModeloChange(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
    procedure bAtivarClick(Sender: TObject);
    procedure cbxPortaChange(Sender: TObject);
    procedure Ativcar1Click(Sender: TObject);
    procedure Desativar1Click(Sender: TObject);
    procedure chTentarClick(Sender: TObject);
    procedure chBloqueiaClick(Sender: TObject);
    procedure chExibeMsgClick(Sender: TObject);
    procedure edTimeoutChange(Sender: TObject);
    procedure mMsgChange(Sender: TObject);
    procedure Testar1Click(Sender: TObject);
    procedure ACBrECF1MsgAguarde(Mensagem : String);
    procedure DataHora1Click(Sender: TObject);
    procedure NumECF1Click(Sender: TObject);
    procedure NSrie1Click(Sender: TObject);
    procedure NVerso1Click(Sender: TObject);
    procedure NumUltimoCupom1Click(Sender: TObject);
    procedure PoucoPapel1Click(Sender: TObject);
    procedure Estado1Click(Sender: TObject);
    procedure LeituraX1Click(Sender: TObject);
    procedure ReduoZ1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Sobre1Click(Sender: TObject);
    procedure AliquotasICMS1Click(Sender: TObject);
    procedure FormasdePagamento1Click(Sender: TObject);
    procedure AbreGaveta1Click(Sender: TObject);
    procedure GavetaAberta1Click(Sender: TObject);
    procedure ChequePronto1Click(Sender: TObject);
    procedure CancelaImpressoCheque1Click(Sender: TObject);
    procedure HorarioVerao1Click(Sender: TObject);
    procedure ImpactoAgulhas1Click(Sender: TObject);
    procedure TestaPodeAbrirCupom1Click(Sender: TObject);
    procedure NUltimoCupom1Click(Sender: TObject);
    procedure SubTotal1Click(Sender: TObject);
    procedure TotalPago1Click(Sender: TObject);
    procedure AbrirCupom1Click(Sender: TObject);
    procedure CancelaCupom1Click(Sender: TObject);
    procedure VenderItem1Click(Sender: TObject);
    procedure CancelarItemVendido1Click(Sender: TObject);
    procedure Sub1Click(Sender: TObject);
    procedure EfetuarPagamento1Click(Sender: TObject);
    procedure FecharCupom1Click(Sender: TObject);
    procedure EnviaComando1Click(Sender: TObject);
    procedure RelatorioGerencial1Click(Sender: TObject);
    procedure CupomVinculado1Click(Sender: TObject);
    procedure ACBrECF1AguardandoRespostaChange(Sender: TObject);
    procedure CarregaComprovantesNAOFiscais1Click(Sender: TObject);
    procedure FechaRelatrio1Click(Sender: TObject);
    procedure HorarioVerao2Click(Sender: TObject);
    procedure Arredonda1Click(Sender: TObject);
    procedure MudaArredondamento1Click(Sender: TObject);
    procedure NumLoja1Click(Sender: TObject);
    procedure NumCRO1Click(Sender: TObject);
    procedure TestedeVelocidade1Click(Sender: TObject);
    procedure chArredondaPorQtdClick(Sender: TObject);
    procedure CapturaporNReduaoZ1Click(Sender: TObject);
    procedure ImprimeporNReduaoZ1Click(Sender: TObject);
    procedure CapturaporPeriodo1Click(Sender: TObject);
    procedure ImprimeporPeriodo1Click(Sender: TObject);
    procedure ProgramaAliquota1Click(Sender: TObject);
    procedure ProgramaComprovanteNAOFiscal1Click(Sender: TObject);
    procedure ACBrECF1MsgPoucoPapel(Sender: TObject);
    procedure ProgramaFormadePagamento1Click(Sender: TObject);
    procedure CorrigeEstadodeErro1Click(Sender: TObject);
  private
    { Private declarations }
    Function Converte( cmd : String) : String;
  public
    { Public declarations }
    Procedure AtualizaMemos ;
  end;

const Estados : array[TACBrECFEstado] of string =
  ('N�o Inicializada', 'Desconhecido', 'Livre', 'Venda',
   'Pagamento', 'Relat�rio', 'Bloqueada', 'Requer Z', 'Requer X' );

var
  Form1: TForm1;

implementation

uses ACBrUtil, VendeItem, EfetuaPagamento, Relatorio, DateUtils;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  mMsgChange( Sender );
end;

procedure TForm1.AtualizaMemos;
begin
  mEnviado.Text := Converte( ACBrECF1.ComandoEnviado );
  mResp.Lines.Add( Converte( ACBrECF1.RespostaComando) );
  mResp.Lines.Add('- + - + - + - + - + - + - + - + - + - + - + -') ;
  StatusBar1.Panels[0].Text := Estados[ ACBrECF1.Estado ] ;
end;

function TForm1.Converte(cmd: String): String;
var A : Integer ;
begin
  Result := '' ;
  For A := 1 to length( cmd ) do
  begin
     if not (cmd[A] in ['A'..'Z','a'..'z','0'..'9',
                        ' ','.',',','/','?','<','>',';',':',']','[','{','}',
                        '\','|','=','+','-','_',')','(','*','&','^','%','$',
                        '#','@','!','~',']' ]) then
        Result := Result + '#' + IntToStr(ord( cmd[A] ))
     else
        Result := Result + cmd[A] ;
  end ;
end;

procedure TForm1.cbxModeloChange(Sender: TObject);
begin
  try
     ACBrECF1.Modelo := TACBrECFModelo( cbxModelo.ItemIndex ) ;
  except
     cbxModelo.ItemIndex := Integer( ACBrECF1.Modelo ) ;
     raise ;
  end ;
end;

procedure TForm1.Sair1Click(Sender: TObject);
begin
  close ;
end;

procedure TForm1.bAtivarClick(Sender: TObject);
begin
  if bAtivar.Caption = 'Ativar' then
     Ativcar1Click( Sender )
  else
     Desativar1Click( Sender );
end;

procedure TForm1.cbxPortaChange(Sender: TObject);
begin
  try
    ACBrECF1.Porta := cbxPorta.Text ;
  finally
     cbxPorta.Text := ACBrECF1.Porta ;
  end ;
end;

procedure TForm1.Ativcar1Click(Sender: TObject);
begin
  try
     if cbxModelo.ItemIndex = 0 then
        if not ACBrECF1.AcharECF(true,False) then
        begin
           MessageDlg('Nenhum ECF encontrado.',mtInformation,[mbOk],0) ;
           exit ;
        end ;

     ACBrECF1.Ativar ;
     bAtivar.Caption := 'Desativar' ;
     mResp.Lines.Add( 'Ativar' );
     AtualizaMemos ;
  finally
     cbxModelo.ItemIndex := Integer(ACBrECF1.Modelo) ;
     cbxPorta.Text       := ACBrECF1.Porta ;
  end ;
end;

procedure TForm1.Desativar1Click(Sender: TObject);
begin
  ACBrECF1.Desativar ;
  bAtivar.Caption := 'Ativar' ;
  mResp.Lines.Add( 'Desativar' );
  AtualizaMemos ;
end;

procedure TForm1.chTentarClick(Sender: TObject);
begin
  ACBrECF1.ReTentar := chTentar.Checked ;
end;

procedure TForm1.chBloqueiaClick(Sender: TObject);
begin
  ACBrECF1.BloqueiaMouseTeclado := chBloqueia.Checked ;
end;

procedure TForm1.chExibeMsgClick(Sender: TObject);
begin
  ACBrECF1.ExibeMensagem := chExibeMsg.Checked ;
end;

procedure TForm1.chArredondaPorQtdClick(Sender: TObject);
begin
  ACBrECF1.ArredondaPorQtd := chArredondaPorQtd.Checked ;
end;

procedure TForm1.edTimeoutChange(Sender: TObject);
begin
  ACBrECF1.TimeOut := StrToIntDef(edTimeout.Text, ACBrECF1.TimeOut ) ;
end;

procedure TForm1.mMsgChange(Sender: TObject);
Var Msg : String ;
    L : Integer ;
begin
  Msg := '' ;
  For L := 0 to mMsg.Lines.Count - 1 do
  begin
     Msg := Msg + mMsg.Lines[L]+#10
  end ;

  ACBrECF1.MsgAguarde := copy(Msg, 1, Length(Msg)-1 ) ;
end;

procedure TForm1.Testar1Click(Sender: TObject);
begin
  ACBrECF1.TestarDialog ;
  AtualizaMemos ;
end;

procedure TForm1.ACBrECF1MsgAguarde(Mensagem : String);
begin
  StatusBar1.Panels[1].Text := StringReplace(Mensagem,#10,' ',[rfReplaceAll]) ;
end;

procedure TForm1.DataHora1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'Data/Hora: '+ DateTimeToStr( ACBrECF1.DataHora ) ) ;
  AtualizaMemos ;
end;

procedure TForm1.NumECF1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'N.ECF: ('+ ACBrECF1.NumECF+')' );
  AtualizaMemos ;
end;

procedure TForm1.NSrie1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'N.S�rie: ('+ ACBrECF1.NumSerie+')' );
  AtualizaMemos ;
end;

procedure TForm1.NVerso1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'N.Vers�o: '+ ACBrECF1.NumVersao );
  AtualizaMemos ;
end;

procedure TForm1.NumUltimoCupom1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'N.�ltimo Cupom: ('+ ACBrECF1.NumCupom+')' );
  AtualizaMemos ;
end;

procedure TForm1.PoucoPapel1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'Pouco Papel: '+
     StrUtils.IfThen( ACBrECF1.PoucoPapel , 'SIM', 'NAO') );
  AtualizaMemos ;
end;

procedure TForm1.Estado1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'Estado: '+ Estados[ ACBrECF1.Estado ] );
  AtualizaMemos ;
end;

procedure TForm1.LeituraX1Click(Sender: TObject);
begin
  ACBrECF1.LeituraX ;
  mResp.Lines.Add( 'Leitura X');
  AtualizaMemos ;
end;

procedure TForm1.ReduoZ1Click(Sender: TObject);
begin
  if ACBrECF1.Estado <> estRequerZ then
  begin
     if MessageDlg('A Redu��o Z pode Bloquear o seu ECF at� a 12:00'+#10+#10+
                  'Continua assim mesmo ?',mtWarning,mbYesNoCancel,0) <> mrYes then
        exit ;

     if MessageDlg('Voc� tem certeza ?',mtWarning,mbYesNoCancel,0) <> mrYes then
        exit ;
  end ;

  ACBrECF1.ReducaoZ( now ) ;
  mResp.Lines.Add( 'Redu�ao Z');
  AtualizaMemos ;
end;

procedure TForm1.Sobre1Click(Sender: TObject);
begin
  ACBrAboutDialog ;
end;

procedure TForm1.AliquotasICMS1Click(Sender: TObject);
var A : Integer ;
begin
  ACBrECF1.CarregaAliquotas ;

  for A := 0 to ACBrECF1.Aliquotas.Count -1 do
  begin
     mResp.Lines.Add( 'Aliquota: '+ACBrECF1.Aliquotas[A].Indice +' -> '+
                      FloatToStr( ACBrECF1.Aliquotas[A].Aliquota ) + ' Tipo: '+
                      ACBrECF1.Aliquotas[A].Tipo );
  end ;
  mResp.Lines.Add('---------------------------------');
end;

procedure TForm1.FormasdePagamento1Click(Sender: TObject);
var A : Integer ;
begin
  ACBrECF1.CarregaFormasPagamento ;

  for A := 0 to ACBrECF1.FormasPagamento.Count -1 do
  begin
     if ACBrECF1.FormasPagamento[A].Descricao <> '' then
        mResp.Lines.Add( 'Forma Pagto: '+ACBrECF1.FormasPagamento[A].Indice+' -> '+
           ACBrECF1.FormasPagamento[A].Descricao+'  Permite Vinculado: '+
           StrUtils.IfThen( ACBrECF1.FormasPagamento[A].PermiteVinculado,'S','N'));
  end ;
  mResp.Lines.Add('---------------------------------');
end;

procedure TForm1.CarregaComprovantesNAOFiscais1Click(Sender: TObject);
var A : Integer ;
begin
  ACBrECF1.CarregaComprovantesNaoFiscais ;

  for A := 0 to ACBrECF1.ComprovantesNaoFiscais.Count -1 do
  begin
     if ACBrECF1.ComprovantesNaoFiscais[A].Descricao <> '' then
        mResp.Lines.Add( 'CNF: '+ACBrECF1.ComprovantesNaoFiscais[A].Indice+' -> '+
           ACBrECF1.ComprovantesNaoFiscais[A].Descricao+'  Permite Vinculado: '+
           StrUtils.IfThen( ACBrECF1.ComprovantesNaoFiscais[A].PermiteVinculado,
                            'S','N')+
           ' - FPG associada: '+ACBrECF1.ComprovantesNaoFiscais[A].FormaPagamento);
  end ;
  mResp.Lines.Add('---------------------------------');
end;

procedure TForm1.AbreGaveta1Click(Sender: TObject);
begin
  ACBrECF1.AbreGaveta ;
  mResp.Lines.Add( 'AbreGaveta');
  AtualizaMemos ;
end;

procedure TForm1.GavetaAberta1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'Gaveta Aberta: '+
     StrUtils.IfThen( ACBrECF1.GavetaAberta,'SIM','NAO'));
  AtualizaMemos ;
end;

procedure TForm1.ChequePronto1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'Cheque Pronto: '+
     StrUtils.IfThen( ACBrECF1.ChequePronto,'SIM','NAO'));
  AtualizaMemos ;
end;

procedure TForm1.CancelaImpressoCheque1Click(Sender: TObject);
begin
  ACBrECF1.CancelaImpressaoCheque ;
  mResp.Lines.Add( 'CancelaImpressaoCheque');
  AtualizaMemos ;
end;

procedure TForm1.HorarioVerao1Click(Sender: TObject);
begin
  ACBrECF1.MudaHorarioVerao ;
  mResp.Lines.Add( 'MudaHorarioVerao');
  AtualizaMemos ;
end;

procedure TForm1.ImpactoAgulhas1Click(Sender: TObject);
begin
  ACBrECF1.ImpactoAgulhas ;
  mResp.Lines.Add( 'ImpactoAgulhas');
  AtualizaMemos ;
end;

procedure TForm1.TestaPodeAbrirCupom1Click(Sender: TObject);
var Est : String ;
begin

  Est := Estados[ ACBrECF1.Estado ] ;

  try
     ACBrECF1.TestaPodeAbrirCupom ;

     mResp.Lines.Add( 'Pode Abrir Cupom.. OK') ;
  except
     mResp.Lines.Add( 'NAO Pode Abrir Cupom..') ;
     mResp.Lines.Add( 'pois o estado Atual � '+Est) ;
     AtualizaMemos ;

     raise ;
  end ;
  
  AtualizaMemos ;

end;

procedure TForm1.NUltimoCupom1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'Num Ultimo Cupom: '+ ACBrECF1.NumCupom );
  AtualizaMemos ;
end;

procedure TForm1.SubTotal1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'SubTotal: '+  FloatToStr( ACBrECF1.Subtotal ) );
  AtualizaMemos ;
end;

procedure TForm1.TotalPago1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'Total Pago: '+  FloatToStr( ACBrECF1.TotalPago ) );
  AtualizaMemos ;
end;

procedure TForm1.AbrirCupom1Click(Sender: TObject);
Var CPF : String ;
begin
  CPF := ' ' ;
  if InputQuery('Abre Cupom','Se necess�rio, Informe o CPF/CNPJ',CPF) then
  begin
     ACBrECF1.AbreCupom( CPF );
     mResp.Lines.Add( 'AbreCupom' );
     AtualizaMemos ;
  end ;
end;

procedure TForm1.CancelaCupom1Click(Sender: TObject);
begin
  ACBrECF1.CancelaCupom ;
  mResp.Lines.Add( 'CancelaCupom' );
  AtualizaMemos ;
end;

procedure TForm1.VenderItem1Click(Sender: TObject);
begin
  frVendeItem.Show ;
end;

procedure TForm1.CancelarItemVendido1Click(Sender: TObject);
Var Item : String ;
begin
  Item := '1' ;
  if InputQuery('Cancelar Item Vendido',
                'Informe o n�mero da Sequencia de Venda', Item ) then
  begin
     ACBrECF1.CancelaItemVendido( StrToIntDef(Item,0) );
     mResp.Lines.Add( 'Cancela Item Vendido: '+Item );
     AtualizaMemos ;
  end ;
end;

procedure TForm1.Sub1Click(Sender: TObject);
Var Desc : String ;
begin
  Desc := '0' ;
  if InputQuery('Subtotaliza Cupom',
                'Digite Valor negativo para Desconto'+#10+
                'ou Valor Positivo para Acrescimo' , Desc ) then
  begin
     ACBrECF1.SubtotalizaCupom( StrToFloatDef(Desc,0) );
     mResp.Lines.Add( 'Subtotaliza Cupom: '+ Desc );
     AtualizaMemos ;
  end ;
end;


procedure TForm1.EfetuarPagamento1Click(Sender: TObject);
begin
  if ACBrECF1.Estado <> estPagamento then
     MessageDlg('Impressora nao est� em Estado de Pagamento'+#10+
                'Primeiro use SubTotaliza Cupom' ,mtWarning,[mbOk],0) ;

  frPagamento.Show ;
end;

procedure TForm1.FecharCupom1Click(Sender: TObject);
Var Obs : String ;
begin
  Obs := 'Componentes ACBr|http://acbr.sourceforge.net' ;
  if InputQuery('Fechar Cupom',
                'Se Necess�rio digite alguma Observa�ao (at� 8 linhas)'+#10+
                'O sinal | (pipe) ser� convertido para #10 (quebra de linha)' ,
                Obs ) then
  begin
     Obs := StringReplace(Obs,'|',#10,[rfReplaceAll,rfIgnoreCase]) ;
     ACBrECF1.FechaCupom( Obs );
     mResp.Lines.Add( 'Fecha Cupom: '+#10+Obs );
     AtualizaMemos ;
  end ;
end;

procedure TForm1.EnviaComando1Click(Sender: TObject);
Var CMD1,CMD2, C : String ;
    A : Integer ;
    T : String ;
begin
  CMD1 := '' ;
  T    := '0'  ;
  if InputQuery('Enviar Comando',
                'Digite o comando de acordo com a Sintaxe da Impressora'+#10+#10+
                'Para Caracteres ASC use #nnn  Ex: #006 = chr(006)'+#10+#10+
                'Exemplo: #006 ir� imprimir uma Leitura X na Bematech' ,
                CMD1 ) then
    if (not (ACBrECF1.Modelo = ecfBematech)) or
       InputQuery('Enviar Comando BEMATECH',
                  'Digite o tamanho em Bytes do Retorno esperado'+#10+#10+
                  'NAO adcione os 3 bytes de ACK+ST1+ST2',
                  T ) then
     begin
        CMD2   := '' ;
        A      := 1 ;

        if ACBrECF1.ECF is TACBrECFBematech then
           (ACBrECF1.ECF as TACBrECFBematech).BytesResp := StrToIntDef(T,0) ;


        while A <= length( CMD1 ) do
        begin
           C := copy( CMD1, A, 1) ;

           if C = '#' then
            begin
              CMD2 := CMD2 + chr( StrToIntDef(copy(CMD1,A+1,3),0) ) ;
              A := A + 3 ;
            end
           else
              CMD2 := CMD2 + C ;

           A := A + 1 ;
        end ;

        ACBrECF1.EnviaComando( CMD2 );
        mResp.Lines.Add( 'Envia Comando: '+CMD1 );
        AtualizaMemos ;
     end ;
end;

procedure TForm1.RelatorioGerencial1Click(Sender: TObject);
begin
  frRelatorio.TipoRelatorio := 'G' ;
  frRelatorio.ShowModal ;
end;

procedure TForm1.FechaRelatrio1Click(Sender: TObject);
begin
  ACBrECF1.FechaRelatorio ;
end;

procedure TForm1.CupomVinculado1Click(Sender: TObject);
begin
  MessageDlg('Para imprimir um Cupom Vinculado voc� deve ter '+
             'informa�oes dos Pagamentos Efetuados no �ltimo Cupom Fiscal',
             mtInformation,[mbOk],0) ;
  frRelatorio.TipoRelatorio := 'V' ;
  frRelatorio.ShowModal ;
end;

procedure TForm1.ACBrECF1AguardandoRespostaChange(Sender: TObject);
begin
  if ACBrECF1.AguardandoResposta then
     StatusBar1.Panels[0].Text := 'Processando...'
  else
     StatusBar1.Panels[0].Text := '' ;
end;

procedure TForm1.HorarioVerao2Click(Sender: TObject);
begin
  mResp.Lines.Add( 'Hor�rio de Ver�o: '+
     StrUtils.IfThen( ACBrECF1.HorarioVerao , 'SIM', 'NAO') );
  AtualizaMemos ;
end;

procedure TForm1.Arredonda1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'Arredondamento: '+
     StrUtils.IfThen( ACBrECF1.Arredonda , 'SIM', 'NAO') );
  AtualizaMemos ;
end;

procedure TForm1.MudaArredondamento1Click(Sender: TObject);
Var Resp : TModalResult ;
begin
  Resp := MessageDlg('Arredondar ?',mtConfirmation,mbYesNoCancel,0) ;
  if Resp <> mrCancel then
  begin
    ACBrECF1.MudaArredondamento( (Resp = mrYes) ) ;
    mResp.Lines.Add( 'MudaArredondamento');
    AtualizaMemos ;
  end ;
end;

procedure TForm1.NumLoja1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'NUM Loja: ('+ ACBrECF1.NumLoja+')' );
  AtualizaMemos ;
end;

procedure TForm1.NumCRO1Click(Sender: TObject);
begin
  mResp.Lines.Add( 'Num.CRO: ('+ ACBrECF1.NumCRO+')' );
  AtualizaMemos ;
end;

procedure TForm1.TestedeVelocidade1Click(Sender: TObject);
Var cItens : String ;
    nItens, I : Integer ;
    tIni,tFim : TDateTime ;
begin
  ACBrECF1.CarregaFormasPagamento ;
  if ACBrECF1.FormasPagamento.Count < 1 then
     raise Exception.Create('Nenhuma Forma de Pagamento programada no ECF');

  cItens := '10' ;
  if not InputQuery('Teste de Velocidade',
                'Numero de Itens a imprimir:', cItens ) then
     exit ;

  nItens := StrToIntDef(cItens,0) ;
  if nItens < 1 then
     exit ;

  tIni := Now ;
  mResp.Lines.Add('Iniciando Cupom: '+DateTimeToStr(tIni)) ;
  ACBrECF1.AbreCupom();

  For i := 1 to nItens do
     ACBrECF1.VendeItem( IntToStrZero(i,6),
                         'DESCRICAO DO PRODUTO NUMERO: '+IntToStrZero(i,6),
                         'NN',i,i/100,0,'UN') ;

  ACBrECF1.SubtotalizaCupom();
  ACBrECF1.EfetuaPagamento(ACBrECF1.FormasPagamento[0].Indice,  ACBrECF1.Subtotal,
                      'TESTANDO COM 1 PAGAMENTO APENAS' );
  ACBrECF1.FechaCupom('TESTE DE CUPOM');
  tFim := Now ;
  mResp.Lines.Add('Finalizado em: '+DateTimeToStr(tFim)) ;
  mResp.Lines.Add('Diferen�a: '+ FloatToStr(SecondSpan(tIni,tFim))+' segundos' ) ;
  mResp.Lines.Add('---------------------------------');
end;

procedure TForm1.CapturaporNReduaoZ1Click(Sender: TObject);
Var Linhas : TStringList ;
    cRedIni, cRedFim : String ;
    I, nRedIni, nRedFim : Integer ;
begin
  cRedIni := '0' ;
  cRedFim := '0' ;

  if not InputQuery('Captura da Memoria Fiscal',
                'Entre com o a Redu�ao Z Inicial:', cRedIni ) then
     exit ;
  nRedIni := StrToIntDef(cRedIni,-1) ;
  if nRedIni < 0 then exit ;

  if not InputQuery('Captura da Memoria Fiscal',
                'Entre com o a Redu�ao Z Final:', cRedFim ) then
     exit ;
  nRedFim := StrToIntDef(cRedFim,-1) ;
  if nRedFim < 0 then exit ;

  Linhas := TStringList.Create ;
  try
     ACBrECF1.LeituraMemoriaFiscalSerial(nRedIni, nRedFim, Linhas);

     For I := 0 to Linhas.Count - 1 do
        mResp.Lines.Add(Linhas[I]) ;
  finally
     Linhas.Free ;
  end ;
  mResp.Lines.Add('---------------------------------');
end;

procedure TForm1.ImprimeporNReduaoZ1Click(Sender: TObject);
Var cRedIni, cRedFim : String ;
    nRedIni, nRedFim : Integer ;
begin
  cRedIni := '0' ;
  cRedFim := '0' ;

  if not InputQuery('Impress�o da Memoria Fiscal',
                'Entre com o a Redu�ao Z Inicial:', cRedIni ) then
     exit ;
  nRedIni := StrToIntDef(cRedIni,-1) ;
  if nRedIni < 0 then exit ;

  if not InputQuery('Impress�o da Memoria Fiscal',
                'Entre com o a Redu�ao Z Final:', cRedFim ) then
     exit ;
  nRedFim := StrToIntDef(cRedFim,-1) ;
  if nRedFim < 0 then exit ;

  ACBrECF1.LeituraMemoriaFiscal(nRedIni, nRedFim);
  mResp.Lines.Add('Leitura da Memoria Fiscal por Redu�ao');
end;

procedure TForm1.CapturaporPeriodo1Click(Sender: TObject);
Var Linhas : TStringList ;
    cDatIni, cDatFim : String ;
    dDatIni, dDatFim : TDateTime ;
    I : Integer ;
begin
  cDatIni := '01/'+FormatDateTime('mm/yy',now) ;
  cDatFim := FormatDateTime('dd/mm/yy',now) ;

  if not InputQuery('Captura da Memoria Fiscal',
                'Entre com o a Data Inicial (DD/MM/AA):', cDatIni ) then
     exit ;
  try dDatIni := StrToDateTime(cDatIni) except exit end ;

  if not InputQuery('Captura da Memoria Fiscal',
                'Entre com o a Data Final (DD/MM/AA):', cDatFim ) then
     exit ;
  try dDatFim := StrToDateTime(cDatFim) except exit end ;

  Linhas := TStringList.Create ;
  try
     ACBrECF1.LeituraMemoriaFiscalSerial(dDatIni, dDatFim, Linhas);

     For I := 0 to Linhas.Count - 1 do
        mResp.Lines.Add(Linhas[I]) ;
  finally
     Linhas.Free ;
  end ;
  mResp.Lines.Add('---------------------------------');
end;

procedure TForm1.ImprimeporPeriodo1Click(Sender: TObject);
Var cDatIni, cDatFim : String ;
    dDatIni, dDatFim : TDateTime ;
begin
  cDatIni := '01/'+FormatDateTime('mm/yy',now) ;
  cDatFim := FormatDateTime('dd/mm/yy',now) ;

  if not InputQuery('Captura da Memoria Fiscal',
                'Entre com o a Data Inicial (DD/MM/AA):', cDatIni ) then
     exit ;
  try dDatIni := StrToDateTime(cDatIni) except exit end ;

  if not InputQuery('Captura da Memoria Fiscal',
                'Entre com o a Data Final (DD/MM/AA):', cDatFim ) then
     exit ;
  try dDatFim := StrToDateTime(cDatFim) except exit end ;

  ACBrECF1.LeituraMemoriaFiscal(dDatIni, dDatFim );
  mResp.Lines.Add('Leitura da Memoria Fiscal por Datas');
end;

procedure TForm1.ProgramaAliquota1Click(Sender: TObject);
Var cAliq : String ;
    nAliq : Double ;
    Tipo  : Char ;
    Resp  : TModalResult ;
begin
  cAliq := '18,00' ;

  if not InputQuery('Programa�ao de Aliquotas',
                    'Entre com o valor da Aliquota:', cAliq ) then
     exit ;

  cAliq := StringReplace(StringReplace(cAliq,'.',DecimalSeparator,[]),
                                             ',',DecimalSeparator,[]) ;
  nAliq := StrToFloatDef(cAliq,0) ;
//  if nAliq = 0 then
//     exit ;

  Resp := MessageDlg('Aliquota do ICMS ?'+sLineBreak+'SIM = ICMS, NAO = ISS',
                mtConfirmation,mbYesNoCancel,0) ; 
  case Resp of
    mrCancel : exit ;
    mrYes    : Tipo := 'T' ;
  else ;
    Tipo := 'S' ;
  end;

  if MessageDlg('A aliquota: ['+FloatToStr(nAliq)+'] do Tipo: ['+Tipo+
                '] ser� programada.'+sLineBreak+sLineBreak+
                'Cuidado a programa��o de Aliquotas � irreversivel'+sLineBreak+
                'Confirma a opera��o ?',mtConfirmation,mbYesNoCancel,0) <> mrYes then
     exit ;

  ACBrECF1.ProgramaAliquota(nAliq,Tipo);
  AliquotasICMS1Click(Sender);
end;

procedure TForm1.ProgramaFormadePagamento1Click(Sender: TObject);
Var cDescricao : String ;
    Vinculado  : Boolean ;
    Resp       : TModalResult ;
begin
  cDescricao := 'CARTAO' ;
  Vinculado  := true ;

  if not InputQuery('Programa�ao de Formas de Pagamento (FPG)',
                    'Entre com a Descri�ao:', cDescricao ) then
     exit ;

  if not (ACBrECF1.Modelo in [ecfBematech, ecfNaoFiscal, ecfMecaf]) then
  begin
     Resp := MessageDlg('Permite Vinculado nessa Forma de Pagamento ?',
                   mtConfirmation,mbYesNoCancel,0) ;
     if Resp = mrCancel then
        exit
     else
        Vinculado := (Resp = mrYes) ;
  end ;

  if MessageDlg('A Forma de Pagamento: ['+cDescricao+'] '+
                'ser� programada.'+sLineBreak+sLineBreak+
                'Cuidado, a programa��o de Formas de Pagamento � irreversivel'+sLineBreak+
                'Confirma a opera��o ?',mtConfirmation,mbYesNoCancel,0) <> mrYes then
     exit ;

  ACBrECF1.ProgramaFormaPagamento(cDescricao,Vinculado);
  FormasdePagamento1Click(Sender);
end;

procedure TForm1.ProgramaComprovanteNAOFiscal1Click(Sender: TObject);
Var cDescricao, cTipo : String ;
begin
  cDescricao := 'CARTAO' ;
  cTipo      := '' ;

  if not InputQuery('Programa�ao de Comprovantes NAO Fiscais (CNF)',
                    'Entre com a Descri�ao:', cDescricao ) then
     exit ;

  case ACBrECF1.Modelo of
    ecfSchalter :
       if not InputQuery('Comprovantes NAO Fiscal '+ACBrECF1.ModeloStr,
                         'Entre com a String do parametro "Tipo".'+sLineBreak+
                         'D - Permite Desconto e Item '+sLineBreak+
                         'A - Permite Acrescimo no Subtotal'+sLineBreak+
                         'C - Permite Cancelamento de Item'+sLineBreak+
                         'P - Obriga forma de Pagamento'+sLineBreak+sLineBreak+
                         'Vnn - Obriga emissao de vinculado na Forma de '+
                         'Pagamento nn'+sLineBreak+sLineBreak+
                         'Se vazio assume Default = "DAC"'+sLineBreak+
                         'Exemplos:  V04 -> Torna a Emissao do Cupom Fiscal '+
                         'Vinculado obrigat�ria para a Forma de Pagamento 04',
                         cTipo ) then
          exit ;

    ecfDaruma :
       if not InputQuery('Comprovantes NAO Fiscal '+ACBrECF1.ModeloStr,
                         'Entre com a String do parametro "Tipo".'+sLineBreak+
                         'V  Comprovante Vinculado'+sLineBreak+
                         '+  Entrada de Recursos'+sLineBreak+
                         '-  Saida de Recursos'+sLineBreak+sLineBreak+
                         'Se vazio assume Default = "V"'+sLineBreak+
                         'Informe Apenas uma das Op�oes',
                         cTipo ) then
          exit ;
  end;

  if MessageDlg('O Comprovante Nao Fiscal: ['+cDescricao+'] '+
                IfThen(ACBrECF1.Modelo in [ecfDaruma,ecfSchalter],
                       ' do Tipo: ['+cTipo+'] ','') +
                'ser� programado.'+sLineBreak+sLineBreak+
                'Cuidado a programa��o de CNFs � irreversivel'+sLineBreak+
                'Confirma a opera��o ?',mtConfirmation,mbYesNoCancel,0) <> mrYes then
     exit ;

  ACBrECF1.ProgramaComprovanteNaoFiscal(cDescricao,cTipo);
  CarregaComprovantesNAOFiscais1Click(Sender);
end;

procedure TForm1.ACBrECF1MsgPoucoPapel(Sender: TObject);
begin
  mResp.Lines.Add('ATEN��O... POUCO PAPEL') ;
end;

procedure TForm1.CorrigeEstadodeErro1Click(Sender: TObject);
begin
  ACBrECF1.CorrigeEstadoErro ;
end;

end.


