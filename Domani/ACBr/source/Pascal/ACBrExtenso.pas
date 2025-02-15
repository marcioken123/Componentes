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
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 16/08/2004: Daniel Simoes de Almeida
|*  - Primeira Versao ACBrExtenso
******************************************************************************}

{$I ACBr.inc}

unit ACBrExtenso;

interface
uses ACBrBase, ACBrUtil, {Units da ACBr}
     SysUtils , Classes;

const
   cMilharSin  : array[0..2] of string = ('Bilh�o','Milh�o','Mil') ;
   cMilharPlu  : array[0..2] of string = ('Bilh�es','Milh�es','Mil') ;
   cUnidade    : array[0..8] of string =
      ('Um','Dois','Tres','Quatro','Cinco','Seis','Sete','Oito','Nove') ;
   cDez        : array[0..9] of string =
      ('Dez','Onze','Doze','Treze','Quatorze','Quinze','Dezesseis','Dezessete',
       'Dezoito','Dezenove') ;
   cDezenas    : array[0..7] of string =
      ('Vinte','Trinta','Quarenta','Cinquenta','Sessenta','Setenta','Oitenta',
       'Noventa') ;
   cCentenas   : array[0..9] of string =
      ('Cem','Cento','Duzentos','Trezentos','Quatrocentos','Quinhentos','Seiscentos',
       'Setecentos','Oitocentos','Novecentos') ;

type

{ Componente ACBrExtenso }
TACBrExtenso = class( TACBrComponent )
  private
    { Propriedades do Componente ACBrExtenso }
    fsMoeda: String;
    fsMoedas: String;
    fsCentavos: String;
    fsCentavo: String;
    fsValor: Double;
    fsTexto: String;

    Function ExtensoAux(Str3 : String) : String ;
    procedure TraduzValor(const Value: Double);
    procedure SetfsTexto(const Value: String);
  public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy  ; override ;

  published
    property StrMoeda    : String read fsMoeda    write fsMoeda   ;
    property StrMoedas   : String read fsMoedas   write fsMoedas  ;
    property StrCentavo  : String read fsCentavo  write fsCentavo ;
    property StrCentavos : String read fsCentavos write fsCentavos;
    property Valor       : Double read fsValor    write TraduzValor stored false;
    property Texto       : String read fsTexto    write SetfsTexto  stored false;
end ;

implementation

uses StrUtils;

{ TACBrExtenso }

constructor TACBrExtenso.Create(AOwner: TComponent);
begin
  inherited Create( AOwner ) ;

  fsMoeda   := 'Real' ;
  fsMoedas  := 'Reais' ;
  fsCentavo := 'Centavo' ;
  fsCentavos:= 'Centavos' ;
  fsValor   := 0 ;
  fsTexto   := '' ;

end;

destructor TACBrExtenso.Destroy;
begin

  inherited Destroy ;
end;

procedure TACBrExtenso.TraduzValor(const Value: Double);
Var Casa, Inteiros, Decimais : Integer ;
    StrInteiros : String ;
    aStrCasas : array[0..3] of string ;
begin
  if Value = fsValor then exit ;
  
  if Value > 999999999999.99 then
     raise Exception.Create('Valor acima do permitido');

  fsValor := Value ;
  fsTexto      := '' ;
  Inteiros    := Trunc( fsValor ) ;
  Decimais    := Round( Frac(fsValor) * 100 ) ;
  StrInteiros := IntToStrZero( Inteiros, 12 ) ;

  if Inteiros > 0 then   { Se tiver inteiros processe }
   begin
     { Achando a CASAS dos Bilhoes, Milhoes, Mil, e Cem }
     for Casa := 0 to 3 do
        aStrCasas[ Casa ] := copy( StrInteiros, (Casa * 3)+1, 3);

     for Casa := 0 to 3 do
     begin
        if StrToIntDef(aStrCasas[Casa],0) = 0  then { Casa vazia ? }
           continue ;

        if fsTexto <> '' then { Se ja existe texto, concatena com "," ou "e"}
           fsTexto := fsTexto + IfThen(Casa = 3,' e ',', ') ;

        fsTexto := fsTexto + ExtensoAux( aStrCasas[ Casa ] ) ;

        if Casa < 3 then { Se for acima da casa dos Cem pegue um titulo }
           { Se a CASA tiver valor de UM usa singular, senao usa o plural }
           fsTexto := fsTexto + ' ' +
                    IfThen( StrToIntDef(aStrCasas[Casa],0) = 1,
                            cMilharSin[Casa], cMilharPlu[Casa] ) ;
     end ;

     { Se nao possui valores na casa dos MIL ou dos CEM, concatena ' de' }
     if StrToIntDef(aStrCasas[2] + aStrCasas[3],0) = 0 then
        fsTexto := fsTexto + ' de' ;
   end
  else
     fsTexto := 'Zero' ;

  { Se o valor total for UM usa moeda singular, senao no Plurar }
  fsTexto := fsTexto + ' ' + IfThen( Inteiros = 1, fsMoeda, fsMoedas ) ;

  { PROCESSANDO OS DECIMAIS }
  if Decimais > 0 then
  begin
     if fsTexto <> '' then  { Se ja possui algum Texto adiciona o ' e ' }
        fsTexto := fsTexto + ' e ' ;

     fsTexto := fsTexto + ExtensoAux( IntToStrZero(Decimais,3) ) ;

     { Se o valor total dos decimais for UM usa singular, senao no Plurar }
     fsTexto := fsTexto + ' ' + IfThen(Decimais = 1, fsCentavo, fsCentavos ) ;
  end
end;

function TACBrExtenso.ExtensoAux(Str3 : String) : String;
{ Funcao de auxilio a Extenso. Retorna uma string contendo o extenso
  de Str3. Esta funcao e apenas monta o extenso de uma string de 3
  digitos, (nao acressenta a moeda ou Titulo (Mil, Milhao, etc..))
  Str3 -> String com 3 casas com Valor a transformar em extenso }
Var POS1, POS2, POS3 : Integer ;
begin

  Result := '' ;

  POS1 := StrToIntDef(copy(Str3,1,1),0) ;
  POS2 := StrToIntDef(copy(Str3,2,1),0) ;
  POS3 := StrToIntDef(copy(Str3,3,1),0) ;

  if POS1 > 0 then    { Se possuir numero na casa da centena processe }
  begin
    { Se nao possuir numeros a seguir e POS1 for o numero UM entao = "Cem" }
     if (POS1 = 1) and ((POS2 + POS3) = 0) then
        POS1 := 0 ;

     Result := cCentenas[ POS1 ] ;
  end ;
  
  if POS2 > 0 then    { Se possuir numero na casa da dezena processe }
  begin
     if Result <> '' then  { Se ja possui algum Texto adiciona o ' e ' }
        Result := Result + ' e ' ;

     if POS2 = 1 then {  Se for na casa dos dez usa vetor de Dezenas }
      begin
        Result := Result + cDez[ POS3 ] ;   { Dez, Onze, Doze... }
        POS3 := 0 ;
      end
     else
        Result := Result + cDezenas[ POS2 - 2 ] ; {Vinte, Trinta...}
  end ;

  if POS3 > 0 then    {  Se possuir numero na casa da unidade processe }
  begin
     if Result <> '' then  { Se ja possui algum Texto adiciona o ' e ' }
        Result := Result + ' e ' ;

     Result := Result + cUnidade[ POS3 - 1 ] ;
  end ;
  
end;

procedure TACBrExtenso.SetfsTexto(const Value: String);
begin
  { fun�ao existente apenas para permitir a Propriedade Texto ser visivel no
    Object Inspector...  }
end;

end.
