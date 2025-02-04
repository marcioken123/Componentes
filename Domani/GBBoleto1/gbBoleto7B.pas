unit gbBoleto7B;

interface

uses Classes, Controls, ExtCtrls, QuickRpt, Qrctrls, Graphics, JvGIF, DB,
  DBClient, gbCobranca, StrUtils, SysUtils;

type
  TBoletoB = class(TQuickRep)
    bandDetalhe: TQRBand;
    QRShape2: TQRShape;
    QRImage35: TQRImage;
    txtNomeBanco3: TQRLabel;
    txtLinhaDigitavel3: TQRLabel;
    txtNomeCedente3: TQRLabel;
    txtDataDocumento3: TQRLabel;
    txtNumeroDocumento3: TQRLabel;
    txtEspecieDocumento3: TQRLabel;
    txtAceite3: TQRLabel;
    txtUsoBanco3: TQRLabel;
    txtCarteira3: TQRLabel;
    txtQuantidadeMoeda3: TQRLabel;
    txtEspecieMoeda3: TQRLabel;
    txtSacadoNome3: TQRLabel;
    txtSacadoRuaNumeroComplemento3: TQRLabel;
    txtSacadoCEPBairroCidadeEstado3: TQRLabel;
    txtSacadoCPFCGC3: TQRLabel;
    txtCodigoBaixa3: TQRLabel;
    txtLocalPagamento3: TQRLabel;
    txtValorCobrado3: TQRLabel;
    txtValorMoraMultaB3: TQRLabel;
    txtValorMoraMulta3: TQRLabel;
    txtValorDescontoAbatimentoB3: TQRLabel;
    txtValorDescontoAbatimento3: TQRLabel;
    txtValorDocumento3: TQRLabel;
    txtNossoNumero3: TQRLabel;
    txtAgenciaCodigoCedente3: TQRLabel;
    txtDataVencimento3: TQRLabel;
    txtDataProcessamento3: TQRLabel;
    txtValorMoeda3: TQRLabel;
    lblLocalPagamento3: TQRLabel;
    lblDataDocumento3: TQRLabel;
    lblNumeroDocumento3: TQRLabel;
    lblDataVencimento3: TQRLabel;
    lblAgenciaCodigoCedente3: TQRLabel;
    lblNossoNumero3: TQRLabel;
    lblEspecieDocumento3: TQRLabel;
    lblAceite3: TQRLabel;
    lblDataProcessamento3: TQRLabel;
    lblUsoBanco3: TQRLabel;
    lblCarteira3: TQRLabel;
    lblEspecieMoeda3: TQRLabel;
    lblQuantidadeMoeda3: TQRLabel;
    lblValorMoeda3: TQRLabel;
    lblValorDocumento3: TQRLabel;
    lblInstrucoes3: TQRLabel;
    lblValorDescontoAbatimento3: TQRLabel;
    lblMoraMulta3: TQRLabel;
    lblValorCobrado3: TQRLabel;
    lblSacado3: TQRLabel;
    lblCodigoBaixa3: TQRLabel;
    lblSacadoCPFCGC3: TQRLabel;
    lblNomeCedente3: TQRLabel;
    QRImage36: TQRImage;
    QRImage37: TQRImage;
    QRImage38: TQRImage;
    QRImage39: TQRImage;
    QRImage40: TQRImage;
    QRImage41: TQRImage;
    QRImage42: TQRImage;
    QRImage43: TQRImage;
    QRImage44: TQRImage;
    QRImage45: TQRImage;
    QRImage46: TQRImage;
    QRImage47: TQRImage;
    QRImage48: TQRImage;
    QRImage49: TQRImage;
    QRImage50: TQRImage;
    QRImage51: TQRImage;
    txtCodigoBanco3: TQRLabel;
    lblAutenticacaoMecanica3: TQRLabel;
    imgCodigoBarras3: TQRImage;
    txtInstrucoes3: TQRMemo;
    QRShape4: TQRShape;
    txtEmpresa: TQRLabel;
    txtValorCobrado: TQRLabel;
    txtValorMoraMultaB: TQRLabel;
    txtValorMoraMulta: TQRLabel;
    txtValorDescontoAbatimentoB: TQRLabel;
    txtValorDescontoAbatimento: TQRLabel;
    txtValorDocumento: TQRLabel;
    txtNossoNumero: TQRLabel;
    txtAgenciaCodigoCedente: TQRLabel;
    txtDataVencimento: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRImage1: TQRImage;
    QRImage2: TQRImage;
    QRImage3: TQRImage;
    QRImage4: TQRImage;
    QRImage5: TQRImage;
    QRImage6: TQRImage;
    QRImage7: TQRImage;
    QRImage8: TQRImage;
    QRImage9: TQRImage;
    tmBoleto: TClientDataSet;
    tmBoletoIdTitulo: TIntegerField;
    QRDBText1: TQRDBText;
    procedure bandDetalheBeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private
    xTitulosList: TgbTituloList;
  public

  end;

var
  BoletoB: TBoletoB;

procedure ImprimeBoletosB(xCobranca: TgbCobranca);

implementation

{$R *.DFM}

procedure ImprimeBoletosB(xCobranca: TgbCobranca);
var
  xCont: Integer;
begin
  BoletoB := TBoletoB.Create(nil);

  with BoletoB do
    begin
      tmBoleto.CreateDataSet;
      tmBoleto.Open;

      for xCont := 1 to xCobranca.Titulos.Count do
        begin
          tmBoleto.Append;
          tmBoletoIdTitulo.AsInteger := xCont;
          tmBoleto.Post;
        end;

      xTitulosList := xCobranca.Titulos;
    end;

  BoletoB.Preview;
  BoletoB.Free;
end;

procedure TBoletoB.bandDetalheBeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
  with xTitulosList[tmBoletoIdTitulo.AsInteger - 1] do
    begin
      ReportTitle := 'Cobrança - ' + Cedente.ContaBancaria.Banco.Nome;

      //Terceira via do boleto
      txtEmpresa.Caption := Cedente.Nome;
      txtNomeBanco3.Caption := Cedente.ContaBancaria.Banco.Nome;
      txtCodigoBanco3.Caption := Cedente.ContaBancaria.Banco.Codigo + '-' + Cedente.ContaBancaria.Banco.Digito;
      txtLocalPagamento3.Caption := UpperCase(LocalPagamento);
      txtDataVencimento3.Caption := FormatDateTime('dd/mm/yyyy',DataVencimento);
      txtNomeCedente3.Caption := AnsiUpperCase(Cedente.Nome);
      txtAgenciaCodigoCedente3.Caption := Cedente.CodigoCedente; //AAgenciaCodigoCedente;
      txtDataDocumento3.Caption := FormatDateTime('dd/mm/yyyy',DataDocumento);
      txtNumeroDocumento3.Caption := NumeroDocumento;

      if EspecieDocumento = edDuplicataMercantil then
         txtEspecieDocumento3.Caption := 'DM'
      else if EspecieDocumento = edDuplicataServico then
         txtEspecieDocumento3.Caption := 'DS'
      else
         txtEspecieDocumento3.Caption := ''; //AEspecieDocumento;

      if AceiteDocumento = adSim then
         txtAceite3.Caption := 'S'
      else
         txtAceite3.Caption := 'N';

      txtDataProcessamento3.Caption := FormatDateTime('dd/mm/yyyy',Now);
      txtNossoNumero3.Caption := NossoNumero;
      txtUsoBanco3.Caption := ''; //UsoBanco;
      txtCarteira3.Caption := Carteira;
      txtEspecieMoeda3.Caption := 'R$';
      txtQuantidadeMoeda3.Caption := '';
      txtValorMoeda3.Caption := '';
      txtValorDocumento3.Caption := FormatCurr('#,##0.00',ValorDocumento);
      txtInstrucoes3.Lines.Clear;
      txtInstrucoes3.Lines.AddStrings(Instrucoes);
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
      txtCodigoBaixa3.Caption := NossoNumero;
      txtLinhaDigitavel3.Caption := CodigoBarra.LinhaDigitavel;
      imgCodigoBarras3.Picture.Assign(CodigoBarra.Imagem.Picture);
    end;

  txtDataVencimento.Caption           := txtDataVencimento3.Caption;
  txtAgenciaCodigoCedente.Caption     := txtAgenciaCodigoCedente3.Caption;
  txtNossoNumero.Caption              := txtNossoNumero3.Caption;
  txtValorDocumento.Caption           := txtValorDocumento3.Caption;
  txtValorDescontoAbatimento.Caption  := txtValorDescontoAbatimento3.Caption;
  txtValorDescontoAbatimentoB.Caption := txtValorDescontoAbatimentoB3.Caption;
  txtValorMoraMulta.Caption           := txtValorMoraMulta3.Caption;
  txtValorMoraMultaB.Caption          := txtValorMoraMultaB3.Caption;
  txtValorCobrado.Caption             := txtValorCobrado3.Caption;
end;

end.

