unit QRDBRichECC;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, stdctrls;

type
  Tnumeros = array[1..10] of string[15];
  Tmoeda   = array[1..3,1..2] of string[10];

  TQRECCDataExtenso = class(TQRLabel)
  private
    { Private declarations }
  private
    FCidade : String;
    FData   : TDate;
    procedure SetCidade(Value : String);
    procedure SetData(Value : TDate);
  public
    constructor Create(AOwner : TComponent); override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
  protected
    property Caption;
  published
    property Cidade : String read FCidade write SetCidade;
    Property Data   : TDate  read FData write SetData;
  end;

  TQRECCValorExtenso = class(TQRLabel)
  private
    { Private declarations }
  private
    FValor : Currency;
    FMoedaSingular : String;
    FMoedaPlural : String;
    procedure SetValor(Value : Currency);
    Procedure SetMoedaSingular(Value : String);
    Procedure SetMoedaPlural(Value : String);
  public
    constructor Create(AOwner : TComponent); override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
  protected
    property Caption;
  published
    property Valor : Currency read FValor write SetValor;
    property MoedaSingular : String read FMoedaSingular Write SetMoedaSingular;
    property MoedaPlural : String read FMoedaPlural Write SetMoedaPlural;
  end;


  TQRCheckECC = class(TQRPrintable)
  private
    { Private declarations }
  private
    FChecked : boolean;
    procedure SetChecked(Value : boolean);
  public
    constructor Create(AOwner : TComponent); override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
  published
    property Checked : boolean read FChecked write SetChecked;
  end;

  TAlin=(taRightJustify,taCenter,taLeftJustify,taAllJustify);

  TQRMemoECC = class(TQRMemo)
  private
    { Private declarations }
  private
    FAlin    : TAlin;
  public
    constructor Create(AOwner : TComponent); override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure SetAlin(Value: TAlin);
  published
    property Alignment : TAlin read FAlin write Setalin;
  end;

  TQRDBRichECC = class(TQRDBRichText)
  private
    { Private declarations }
  private
    FAlin    : TAlin;
  public
    constructor Create(AOwner : TComponent); override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure SetAlin(Value: TAlin);
  published
    property Alignment : TAlin read FAlin write Setalin;
  end;

  procedure Register;
  procedure Justifica_Texto(Sender:TControl;pLista:TStrings;pCanvas:TCanvas;pEsquerda,pCima,pDireita,pBaixo:Integer;AutoStretch:Boolean);
  function DataExtenso(pCidade:String;Data: TDateTime): string;
  function StrZero(Num : Real; Zeros,Deci : Integer):string;
  Function Converte(cNumero: string ; nCasas: byte):String;
  function BuscaTroca(Text,Busca,Troca : string) : string;
  function BuscaDireita(Busca,Text : string) : integer;
  function Repete(Caractere : char; nCaracteres : integer) : string;
  function ValorExtenso(nValor:Real;nMoeda: Integer):String;

var
  cValor1,cPosicao1,cPosicao2,cPosicao3,cPosicao4 : string;
  cTipoMoeda: Byte;

implementation

constructor TQRECCDataExtenso.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FData:=Date;
  FCidade:='CIDADE';
  Caption:=DataExtenso(FCidade,FData);
end;

procedure TQRECCDataExtenso.Print(OfsX, OfsY : integer);
begin
  Inherited;
end;

procedure TQRECCDataExtenso.SetCidade(Value: String);
begin
  if Value <> FCidade then
  begin
    FCidade := Value;
    Caption:=DataExtenso(FCidade,FData);
    inValidate;
  end;
end;

procedure TQRECCDataExtenso.SetData(Value: Tdate);
begin
  if Value <> FData then
  begin
    FData := Value;
    Caption:=DataExtenso(FCidade,FData);
    inValidate;
  end;
end;


procedure TQRECCDataExtenso.Paint;
begin
  Inherited;
end;


constructor TQRECCValorExtenso.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FValor:=0;
  //Caption:=DataExtenso(FCidade,FData);
end;

procedure TQRECCValorExtenso.Print(OfsX, OfsY : integer);
begin
  Inherited;
end;

procedure TQRECCValorExtenso.SetMoedaSingular(Value: String);
begin
  if Value <> FMoedaSingular then
  begin
    FMoedaSingular := Value;
    Caption:=ValorExtenso(Fvalor,1);
    inValidate;
  end;
end;

procedure TQRECCValorExtenso.SetMoedaPlural(Value: String);
begin
  if Value <> FMoedaPlural then
  begin
    FMoedaPlural := Value;
    Caption:=ValorExtenso(Fvalor,1);
    inValidate;
  end;
end;



procedure TQRECCValorExtenso.SetValor(Value: Currency);
begin
  if Value <> FValor then
  begin
    FValor := Value;
    Caption:=ValorExtenso(Fvalor,1);
    inValidate;
  end;
end;


procedure TQRECCValorExtenso.Paint;
begin
  Inherited;
end;






constructor TQRDBRichECC.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

constructor TQRMemoECC.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

procedure TQRDBRichECC.Print(OfsX, OfsY : integer);
var R:TRect;
    CalcLeft  :Integer;
    CalcTop   :Integer;
    CalcRight :Integer;
    CalcBottom:Integer;
begin
  Inherited;
  if (Alignment=taAllJustify) then begin
    with ParentReport.QRPrinter do begin
      try
        CalcLeft := XPos(OfsX + Size.Left);
        CalcTop := YPos(OfsY + Size.Top);
        CalcRight := XPos(OfsX + Size.Left + Size.Width);
        CalcBottom := YPos(OfsY + Size.Top + Size.Height);
        R:=Rect(CalcLeft,CalcTop,CalcRight,CalcBottom);
        Canvas.Brush.Color:=clWhite;
        Canvas.FillRect(R);
        Justifica_Texto(Self,Lines,Canvas,CalcLeft,CalcTop,CalcRight,CalcBottom,AutoStretch);
      except
        ShowMessage('Justificação Não Possivel.');
      end;
    end;
  end;
end;


procedure TQRDBRichECC.Paint;
var R:TRect;
begin
  Inherited;
  if (Alignment=taAllJustify) then begin
    try
      R:=Rect(0,0,Width,Height);
      Canvas.Brush.Color:=clWhite;
      Canvas.FillRect(R);
      Justifica_Texto(Self,Lines,Canvas,0,0,Width,Height,AutoStretch);
    except
      ShowMessage('Justificação Não Possivel.');
    end;
  end;
end;

procedure TQRMemoECC.Print(OfsX, OfsY : integer);
var R:TRect;
    CalcLeft  :Integer;
    CalcTop   :Integer;
    CalcRight :Integer;
    CalcBottom:Integer;
begin
  Inherited;
  if (Alignment=taAllJustify) then begin
    with ParentReport.QRPrinter do begin
      try
        CalcLeft := XPos(OfsX + Size.Left);
        CalcTop := YPos(OfsY + Size.Top);
        CalcRight := XPos(OfsX + Size.Left + Size.Width);
        CalcBottom := YPos(OfsY + Size.Top + Size.Height);
        R:=Rect(CalcLeft,CalcTop,CalcRight,CalcBottom);
        Canvas.Brush.Color:=clWhite;
        Canvas.FillRect(R);
        Justifica_Texto(Self,Lines,Canvas,CalcLeft,CalcTop,CalcRight,CalcBottom,AutoStretch);
      except
        ShowMessage('Justificação Não Possivel.');
      end;
    end;
  end;
end;


procedure TQRMemoECC.Paint;
var R:TRect;
begin
  Inherited;
  if (Alignment=taAllJustify) then begin
    try
      R:=Rect(0,0,Width,Height);
      Canvas.Brush.Color:=clWhite;
      Canvas.FillRect(R);
      Justifica_Texto(Self,Lines,Canvas,0,0,Width,Height,AutoStretch);
    except
      ShowMessage('Justificação Não Possivel.');
    end;
  end;
end;


constructor TQRCheckECC.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FChecked := False;
end;

procedure TQRCheckECC.SetChecked(Value : boolean);
begin
  if Value <> FChecked then
  begin
    FChecked := Value;
    Invalidate;
  end;
end;

procedure TQRCheckECC.Paint;
begin
  with Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Rectangle(0, 0, Width - 1, Height - 1);
    if Checked then
    begin
      MoveTo(0, 0);
      LineTo(Width - 1, Height - 1);
      MoveTo(0, Height - 1);
      LineTo(Width - 1, 0);
    end;
  end;
end;

procedure TQRCheckECC.Print(OfsX, OfsY : integer);
var
  CalcLeft,
  CalcTop,
  CalcRight,
  CalcBottom : Longint;
begin
  with ParentReport.QRPrinter do
  begin
    Canvas.Pen.Color := clBlack;
    Canvas.Pen.Width := 1;
    CalcLeft := XPos(OfsX + Size.Left);
    CalcTop := YPos(OfsY + Size.Top);
    CalcRight := XPos(OfsX + Size.Left + Size.Width);
    CalcBottom := YPos(OfsY + Size.Top + Size.Height);
    Canvas.Rectangle(CalcLeft, CalcTop, CalcRight, CalcBottom);
    if Checked then
    begin
      Canvas.MoveTo(CalcLeft, CalcTop);
      Canvas.LineTo(CalcRight, CalcBottom);
      Canvas.MoveTo(CalcLeft, CalcBottom);
      Canvas.LineTo(CalcRight, CalcTop);
    end;
  end;
end;

procedure Register;
begin
  RegisterComponents('QReport', [TQRCheckECC,TQRMemoECC,TQRDBRichECC,TQRECCDataExtenso,TQRECCValorExtenso]);
end;

procedure Justifica_Texto(Sender:TControl;pLista:TStrings;pCanvas:TCanvas;pEsquerda,pCima,pDireita,pBaixo:Integer;AutoStretch:Boolean);
var
  i: Integer;
  Inipa1:Integer;
  Quebras:Integer;
  TamY,PosY,nClientWidth: Integer;
  Linha: string;
  Palavra: String;
  R:TRect;
begin
  nClientWidth:=pDireita-pEsquerda;
  if Sender.Width<100 then exit;
  R:=Rect(pEsquerda,pCima,pDireita,pBaixo);
  i:= 1;
  PosY :=pCima;
  Tamy:= pCanvas.TextHeight('Wy');
  Linha:='';
  Quebras:=0;
  SetBkMode(pCanvas.Handle,0);
  with pLista do begin
    while i<= Length(Text) do begin
      if PosY>pBaixo then begin
        if not AutoStretch then break;
        Sender.Height:=Sender.Height+TamY;
        Break; {acabou linhas disponiveis para o texto}
      end;
      while Text[i] in [' ',#10,#13] do begin
        Inc(i);
        continue;
      end;
      IniPa1:=i;
      while (i<= Length(text)) and not (Text[i] in [' ',#10,#13]) do Inc(i);
      setTextJustification(pCanvas.Handle,0,0);
      Palavra:=copy(Text,IniPa1,i-IniPa1);
      if pcanvas.TextWidth(Linha)+pcanvas.TextWidth(Palavra) > nClientWidth then begin
        setTextJustification(pCanvas.Handle,nClientWidth - pcanvas.textWidth(Linha),Quebras);
        pcanvas.textout(pEsquerda,PosY,Linha);
        Linha:= Palavra;
        Quebras:=0;
        Inc(PosY,TamY);
        Continue;
      end;
      if Linha<>'' then
        Linha:=Linha+' '+Palavra
      else begin
        Linha:=Palavra;
      end;
      if (i > Length(Text)) or (Text[i] in [#10,#13]) then begin
        pCanvas.textOut(pEsquerda,PosY,Linha);
        inc(PosY,TamY);
        Linha:='';
        Quebras:=0;
        if i > Length(Text) then
          break
        else begin
          continue;
        end;
      end;
      Inc(Quebras);
    end;
  end;
end;

procedure TQRDBRichECC.SetAlin(Value: TAlin);
begin
  if Value <> FAlin then
  begin
    FAlin := Value;
    inValidate;
  end;
end;

procedure TQRMemoECC.SetAlin(Value: TAlin);
begin
  if Value <> FAlin then
  begin
    FAlin := Value;
    inValidate;
  end;
end;

function DataExtenso(pCidade:String;Data: TDateTime): string;
var Ano, Mes, Dia : Word;
    Mes1 : String;
begin
  // Retorna a data por extenso
  DecodeDate(Data, Ano, Mes, Dia);
  Case Mes of
    1  : Mes1 := 'Janeiro';
    2  : Mes1 := 'Fevereiro';
    3  : Mes1 := 'Março';
    4  : Mes1 := 'Abril';
    5  : Mes1 := 'Maio';
    6  : Mes1 := 'Junho';
    7  : Mes1 := 'Julho';
    8  : Mes1 := 'Agosto';
    9  : Mes1 := 'Setembro';
    10 : Mes1 := 'Outubro';
    11 : Mes1 := 'Novembro';
    12 : Mes1 := 'Dezembro';
  end;
  if (Dia = 1) then 
    Result := pCidade+' '+IntToStr(Dia)+'º de '+Mes1+' de '+IntToStr(Ano)
  else begin
    Result := pCidade+' '+IntToStr(Dia)+' de '+Mes1+' de '+IntToStr(Ano);
  end;
end;



Function ValorExtenso(nValor:Real;nMoeda: Integer):String;
var n1,nInicio : integer;
    //cTexto,cTextoTemp,cValor1,cPosicao1,cPosicao2,cPosicao3,cPosicao4 : string;
    //cTipoMoeda: Byte;
    cTexto,cTextoTemp:String;
begin
   cTexto := '';
   if nMoeda = 0 then
      cTipoMoeda := 3
   else
      cTipoMoeda := nMoeda;
   cValor1 := StrZero(nValor,13,2);
   cPosicao1 := Copy(cValor1,2,3);
   cPosicao2 := Copy(cValor1,5,3);
   cPosicao3 := Copy(cValor1,8,3);
   cPosicao4 := '0'+Copy(cValor1,(length(cValor1)-1),2);
   cTextoTemp:=Converte(cPosicao1,1);
   if (strtoint(cPosicao1)<>0) then
      cTexto:=cTexto+cTextoTemp;
   cTextoTemp:=Converte(cPosicao2,2);
   if (StrToInt(cPosicao2) <> 0) and (StrToInt(cPosicao3) <> 0) and (StrToInt(cPosicao4) = 0) then
      cTexto := cTexto + cTextotemp+' E ';
   cTextoTemp:=Converte(cPosicao3,3);
   if (StrToInt(cPosicao3) <> 0) then
      cTexto := cTexto + cTextotemp;
   cTextoTemp:=Converte(cPosicao4,4);
   cTexto := cTexto + cTextoTemp;
   Result:=cTexto;
end;


function Converte(cNumero: string ; nCasas: byte):String;
var cNumero1,cNumero2,cNumero3,cNumero4 : string;
    vTexto:String;
const
  aUnidade : Tnumeros = ('UM ','DOIS ',' TRES ',' QUATRO ',' CINCO ',' SEIS ',' SETE ',' OITO ',' NOVE ','');
  aDezena  : Tnumeros = ('DEZ ','VINTE ','TRINTA ','QUARENTA ','CINQUENTA ','SESSENTA ','SETENTA ','OITENTA ','NOVENTA ','');
  aDezena2 : Tnumeros = ('DEZ ','ONZE ',' DOZE ','TREZE ','QUATORZE ','QUINZE ','DEZESSEIS ',
           'DEZESSETE ','DEZOITO ','DEZENOVE ');
  aCentena : Tnumeros = ('CENTO ','DUZENTOS ','TREZENTOS ','QUATROCENTOS ','QUINHENTOS ','SEISCENTOS ',
           'SETECENTOS ','OITOCENTOS ','NOVECENTOS ','');
  aMilhar  : Tnumeros = ('MIL ','MILHAO ','MILHOES ','','','','','','','');
  aMoeda   : Tmoeda   = (('CRUZEIRO ','CRUZEIROS '),('DOLAR ','DOLARES '),('REAL ','REAIS '));
  aCentavo : Tnumeros = ('CENTAVO','CENTAVOS','','','','','','','','');
begin
   vTexto:='';
   if cNumero = '000' then exit;
   cNumero1 := Copy(cNumero,1,1);
   cNumero2 := Copy(cNumero,2,1);
   cNumero3 := Copy(cNumero,length(cNumero),1);
   cNumero4 := Copy(cNumero,length(cNumero)-1,2);
   if nCasas = 4 then
   begin
      if StrToInt(cPosicao1+cPosicao2+cPosicao3) <> 0 then vTexto := vTexto + ' E ';
   end;
   if cNumero1 <> '0' then
   begin
      if (cNumero4 = '00') and (cNumero1 = '1') then
         vTexto := vTexto + 'CEM '
      else
         vTexto := vTexto + aCentena[StrToInt(cNumero1)];
   end;
   if (cNumero4 >= '10') and (cNumero4 <= '19') then
   begin
      if (cNumero1 <> '0') then
         vTexto := vTexto + 'E '+aDezena2[StrToInt(cNumero4)-9]
      else
         vTexto := vTexto + aDezena2[StrToInt(cNumero4)-9];
   end;
   if cNumero2 >= '2' then
   begin
      if cNumero1 <> '0' then
         vTexto := vTexto + 'E '+aDezena[StrToInt(cNumero2)]
      else
         vTexto := vTexto + aDezena[StrToInt(cNumero2)];
   end;
   if (cNumero3 <> '0') and ((cNumero4 < '10') or (cNumero4 > '19')) then
   begin
      if (cNumero1 <> '0') or (cNumero2 <> '0') then
         vTexto := vTexto + 'E '+aUnidade[StrToInt(cNumero3)]
      else
         vTexto := vTexto + aUnidade[StrToInt(cNumero3)];
   end;
   Case nCasas of
   1: begin
      if StrToInt(cNumero) = 1 then
         vTexto := vTexto + aMilhar[2]
      else
         vTexto := vTexto + aMilhar[3];
      end;
   2: begin
      if StrToInt(cNumero) > 0 then
         vTexto := vTexto + aMilhar[1];
      end;
   3: begin
      if StrToInt(cPosicao1+cPosicao2+cPosicao3) = 1 then
         vTexto := vTexto + aMoeda[cTipoMoeda,1]
      else
         vTexto := vTexto + aMoeda[cTipoMoeda,2];
      end;
   4: begin
      if StrToInt(cNumero) = 1 then
         vTexto := vTexto + aCentavo[1]
      else
         vTexto := vTexto + aCentavo[2];
      end;
   end;
   Result:=vTexto;
end;

function StrZero(Num : Real; Zeros,Deci : Integer):string;
var
   tam, z : integer;
   res,zer: string;
begin
     Str(Num:Zeros:Deci,res);
     res := Trim(res);
     tam := length(res);
     zer := '';
     for z := 1 to (Zeros-tam) do
         zer := zer + '0';
     Result := zer + res;
end;

function BuscaTroca(Text,Busca,Troca : string) : string;
var n : integer;
begin
   for n := 1 to length(Text) do
   begin
      if Copy(Text,n,1) = Busca then
      begin
         Delete(Text,n,1);
         Insert(Troca,Text,n);
      end;
   end;
   Result := Text;
end;

function BuscaDireita(Busca,Text : string) : integer;
var n,retorno : integer;
begin
   retorno := 0;
   for n := length(Text) downto 1 do
   begin
      if Copy(Text,n,1) = Busca then
      begin
         retorno := n;
         break;
      end;
   end;
   Result := retorno;
end;

function Repete(Caractere : char; nCaracteres : integer) : string;
var n : integer; CadeiaCar : string;
begin
   CadeiaCar := '';
   for n := 1 to nCaracteres do CadeiaCar := CadeiaCar + Caractere;
   Result := CadeiaCar;
end;




end.
