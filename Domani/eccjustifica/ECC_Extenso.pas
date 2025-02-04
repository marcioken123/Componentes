unit ECC_Extenso;

{$RESOURCE ECC_Extenso.dcr}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, stdctrls;

type
  Tnumeros = array[1..10] of string[15];

  TQRECC_DataExtenso = class(TQRLabel)
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

  TQRECC_ValorExtenso = class(TQRLabel)
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
  procedure Register;
  function DataExtenso(pCidade:String;Data: TDateTime): string;
  function StrZero(Num : Real; Zeros,Deci : Integer):string;
  function Converte(cNumero: string ; nCasas: byte;cmoeda1,cMoeda2:String):String;
  Function ValorExtenso(nValor:Real;cMoeda1,cMoeda2: String):String;

var
  cValor1,cPosicao1,cPosicao2,cPosicao3,cPosicao4 : string;
  cTipoMoeda: Byte;

implementation

procedure Register;
begin
  RegisterComponents('QReport_ECC', [TQRECC_DataExtenso,TQRECC_ValorExtenso]);
end;

constructor TQRECC_DataExtenso.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FData:=Date;
  FCidade:='CIDADE';
  Caption:=DataExtenso(FCidade,FData);
end;

procedure TQRECC_DataExtenso.Print(OfsX, OfsY : integer);
begin
  Inherited;
end;

procedure TQRECC_DataExtenso.SetCidade(Value: String);
begin
  if Value <> FCidade then
  begin
    FCidade := Value;
    Caption:=DataExtenso(FCidade,FData);
    inValidate;
  end;
end;

procedure TQRECC_DataExtenso.SetData(Value: Tdate);
begin
  if Value <> FData then
  begin
    FData := Value;
    Caption:=DataExtenso(FCidade,FData);
    inValidate;
  end;
end;


procedure TQRECC_DataExtenso.Paint;
begin
  Inherited;
end;


constructor TQRECC_ValorExtenso.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FValor:=0;
  FMoedaSingular:='REAL';
  FMoedaPlural:='REAIS';
  //Caption:=
end;

procedure TQRECC_ValorExtenso.Print(OfsX, OfsY : integer);
begin
  Inherited;
end;

procedure TQRECC_ValorExtenso.SetMoedaSingular(Value: String);
begin
  if Value <> FMoedaSingular then
  begin
    FMoedaSingular := Value;
    Caption:=ValorExtenso(Fvalor,FMoedaSingular,FMoedaPlural);
    inValidate;
  end;
end;

procedure TQRECC_ValorExtenso.SetMoedaPlural(Value: String);
begin
  if Value <> FMoedaPlural then
  begin
    FMoedaPlural := Value;
    Caption:=ValorExtenso(Fvalor,FMoedaSingular,FMoedaPlural);
    inValidate;
  end;
end;



procedure TQRECC_ValorExtenso.SetValor(Value: Currency);
begin
  if Value <> FValor then
  begin
    FValor := Value;
    Caption:=ValorExtenso(Fvalor,MoedaSingular,MoedaPlural);
    inValidate;
  end;
end;


procedure TQRECC_ValorExtenso.Paint;
begin
  Inherited;
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
    Result := IntToStr(Dia)+'º de '+Mes1+' de '+IntToStr(Ano)
  else begin
    Result := IntToStr(Dia)+' de '+Mes1+' de '+IntToStr(Ano);
  end;
  if trim(pCidade)<>'' then begin
    Result:=pCidade+', '+Result;
  end;
end;



Function ValorExtenso(nValor:Real;cMoeda1,cMoeda2: String):String;
var cTexto,cTextoTemp:String;
begin
   cTexto := '';
   cValor1 := StrZero(nValor,13,2);
   cPosicao1 := Copy(cValor1,2,3);
   cPosicao2 := Copy(cValor1,5,3);
   cPosicao3 := Copy(cValor1,8,3);
   cPosicao4 := '0'+Copy(cValor1,(length(cValor1)-1),2);
   cTextoTemp:=Converte(cPosicao1,1,cmoeda1,cMoeda2);
   if (strtoint(cPosicao1)<>0) then
      cTexto:=cTextoTemp;
   cTextoTemp:=Converte(cPosicao2,2,cmoeda1,cMoeda2);
   if (StrToInt(cPosicao2) <> 0) then
      cTexto := cTexto+cTextotemp+' E ';
   cTextoTemp:=Converte(cPosicao3,3,cmoeda1,cMoeda2);
   if (StrToInt(cPosicao3) <> 0) then
      cTexto := cTexto+cTextotemp;
   cTextoTemp:=Converte(cPosicao4,4,cmoeda1,cMoeda2);
   if (StrToInt(cPosicao4) <> 0) then
     cTexto := cTexto+cTextoTemp;
   Result:=cTexto;
end;


function Converte(cNumero: string ; nCasas: byte;cmoeda1,cMoeda2:String):String;
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
         vTexto := vTexto + cMoeda1
      else
         vTexto := vTexto + cMoeda2;
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


end.


