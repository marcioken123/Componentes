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
{ Esse arquivo usa a classe  SynaSer   Copyright (c)2001-2003, Lukas Gebauer   }
{  Project : Ararat Synapse     (Found at URL: http://www.ararat.cz/synapse/)  }
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
|* 28/09/2004: Daniel Simoes de Almeida
|*  - Primeira Versao ACBrDIS
******************************************************************************}

{$I ACBr.inc}

unit ACBrDIS;

interface
uses ACBrBase, ACBrDISClass,  {Units da ACBr}
     SysUtils, Types ,Contnrs, Classes;

type

TACBrDISModelo = (disNenhum, disGertecSerial, disGertecTeclado ) ;
TACBrDISAlinhamento = (alEsquerda, alDireita, alCentro, alJustificado) ;

TACBrDISEfeitoExibir = (efeEsquerda_Direita, efeDireita_Esquerda) ;
TACBrDISEfeitoRolar = (rolParaEsquerda_Inicio, rolParaEsquerda_Sempre,
                       rolParaDireita_Inicio,  rolParaDireita_Sempre,
                       rolVai_e_Volta ) ;

TACBrDISAtualiza = procedure(Linha : Integer; TextoVisivel: String) of object ;

{ Classe Linha }
TACBrDISLinha = class
  private
    fsTexto: String;
    fsTextoVisivel: String;
    fsEfeitoExibir: TACBrDISEfeitoExibir ;
    fsExibindo: Boolean;
    fsRolando: Boolean;
    fsEfeitoRolar: TACBrDISEfeitoRolar;
    fsPosicao: Integer;
    fsColunas: Integer;
    fsEnabled: Boolean;
    fsParaEsquerda: Boolean;
    procedure SetPosicao(const Value: Integer);
    procedure SetTexto(const Value: String);
    procedure SetColunas(const Value: Integer);
  public
     constructor Create ;

     Property Posicao      : Integer read fsPosicao write SetPosicao ;
     property Texto        : String read fsTexto write SetTexto ;
     property TextoVisivel : String read fsTextoVisivel ;
     property Colunas      : Integer read fsColunas write SetColunas ;
     property EfeitoExibir : TACBrDISEfeitoExibir read fsEfeitoExibir
        write fsEfeitoExibir ;
     property EfeitoRolar : TACBrDISEfeitoRolar   read fsEfeitoRolar
        write fsEfeitoRolar ;

     property Exibindo : Boolean read fsExibindo write fsExibindo ;
     property Rolando  : Boolean read fsRolando  write fsRolando  ;
     property Enabled  : Boolean read fsEnabled  write fsEnabled  ;

     property ParaEsquerda : Boolean read fsParaEsquerda write fsParaEsquerda ; 
end ;

{ Lista de Objetos do tipo TACBrDISLinha }
TACBrDISLinhas = class(TObjectList)
  protected
    procedure SetObject (Index: Integer; Item: TACBrDISLinha);
    function GetObject (Index: Integer): TACBrDISLinha;
  public
    function Add (Obj: TACBrDISLinha): Integer;
    procedure Insert (Index: Integer; Obj: TACBrDISLinha);
    property Objects [Index: Integer]: TACBrDISLinha
      read GetObject write SetObject; default;
  end;


{ Componente ACBrDIS }
TACBrDIS = class( TACBrComponent )
  private
    fsDevice  : TACBrDevice ;   { SubComponente ACBrDevice }

    fsLinhas : TACBrDISLinhas ;  { Conjunto de Objetos TACBrDISLinha }

    { Propriedades do Componente ACBrDIS }
    fsAtivo  : Boolean;
    fsModelo : TACBrDISModelo;
    fsDIS    : TACBrDISClass ;

    fsAlinhamento: TACBrDISAlinhamento;
    fsTimer: TACBrThreadTimer;
    fsPassos: Integer;
    fsLinhasCount : Integer;
    fsOnAtualiza: TACBrDISAtualiza ;

    procedure AtualizaLinhas(Sender: TObject);
    procedure DoOnAtualizar(Linha : Integer );
    Function AjustaTexto( Texto : String; Alin : TACBrDISAlinhamento ) : String ;

    procedure SetModelo(const Value: TACBrDISModelo);
    procedure SetPorta(const Value: String);
    procedure SetAtivo(const Value: Boolean);

    function GetPorta: String;
    function GetModeloStrClass: String;
    function GetColunasClass: Integer;
    procedure SetColunasClass(const Value: Integer);
    procedure SetLinhasCount(const Value: Integer);
    procedure SetPassos(const Value: Integer);
    procedure SetIntervalo(const Value: Integer);
    function GetIntervalo: Integer;
    procedure VerificaLinhaExiste( Linha : Integer ) ;
    function GetTimerEnable: Boolean;
    function GetCursorClass: TPoint;
  protected

  public
    constructor Create(AOwner: TComponent); override;
    Destructor Destroy  ; override ;

    procedure Ativar ;
    procedure Desativar ;
    property Ativo : Boolean read fsAtivo write SetAtivo ;

    property Trabalhando : Boolean read GetTimerEnable ;
    property DIS : TACBrDISClass read fsDIS ;
    property Linhas : TACBrDISLinhas read fsLinhas ;
    property Cursor : TPoint read GetCursorClass ;

    Property ModeloStr : String read GetModeloStrClass;

    procedure LimparDisplay ;
    procedure PosicionarCursor( Linha, Coluna: Integer ) ;
    procedure Escrever( AText : String ) ;
    procedure ExibirLinha( Linha : Integer ; AText : String ) ; overload ;
    procedure ExibirLinha( Linha : Integer ; AText : String;
       Alinhamento : TACBrDISAlinhamento ) ; overload ;
    procedure ExibirLinha( Linha : Integer ; AText : String;
       Efeito : TACBrDISEfeitoExibir ) ; overload ;
    procedure RolarLinha( Linha : Integer ;
       Efeito : TACBrDISEfeitoRolar ) ; overload ;
    procedure Parar ;
    procedure Continuar ;
    procedure PararLinha( Linha : Integer )  ;
    procedure ContinuarLinha( Linha : Integer ) ;

  published
     property Modelo : TACBrDISModelo read fsModelo write SetModelo
                 default disNenhum ;
     property Porta : String read GetPorta write SetPorta ;

     { Instancia do Componente ACBrDevice, ser� passada para fsDIS.create }
     property Device : TACBrDevice read fsDevice ;

     property LinhasCount : Integer read fsLinhasCount   write SetLinhasCount
        default 2 ;
     property Colunas     : Integer read GetColunasClass write SetColunasClass
        default 20 ;
     property Alinhamento : TACBrDISAlinhamento read fsAlinhamento
        write fsAlinhamento default alEsquerda ;
     property Intervalo : Integer read GetIntervalo write SetIntervalo
        default 300;
     property Passos    : Integer read fsPassos    write SetPassos    default 1 ;

     property OnAtualiza : TACBrDISAtualiza read fsOnAtualiza write fsOnAtualiza ;
end ;

implementation
Uses ACBrUtil, ACBrDISGertecSerial, ACBrDISGertecTeclado , StrUtils, Math;

{ TACBrDISLinha }

constructor TACBrDISLinha.Create;
begin
  fsColunas      := 20 ;
  fsTexto        := '' ;
  fsTextoVisivel := '' ;
  fsEfeitoExibir := efeEsquerda_Direita ;
  fsEfeitoRolar  := rolParaEsquerda_Inicio ;
  fsRolando      := false ;
  fsExibindo     := false ;
  fsEnabled      := true ;
  fsParaEsquerda := true ;
end;

procedure TACBrDISLinha.SetColunas(const Value: Integer);
begin
  fsColunas := Value;
  SetTexto( Texto );  { reajusta TextoVisivel }
end;

procedure TACBrDISLinha.SetPosicao(const Value: Integer);
begin
  fsPosicao := Value;
  SetTexto( Texto );  { reajusta TextoVisivel }
end;

procedure TACBrDISLinha.SetTexto(const Value: String);
begin
  fsTexto := Value;
  if Posicao <= 0 then
   begin
     fsTextoVisivel := copy( fsTexto,1,Colunas + (Posicao-1)) ;

     if Rolando and (EfeitoRolar = rolParaDireita_Sempre) and
        (Length( fsTextoVisivel ) < Colunas) then
        fsTextoVisivel := RightStr( fsTexto+'  ',-(Posicao-1) ) + fsTextoVisivel
     else
        fsTextoVisivel := StringOfChar(' ',-(Posicao-1)) + fsTextoVisivel ;
   end
  else
   begin
     fsTextoVisivel := copy( fsTexto, Posicao, Colunas);

     if Rolando and (EfeitoRolar = rolParaEsquerda_Sempre) and
        (Length( fsTextoVisivel ) < Colunas) then
        fsTextoVisivel := copy( fsTexto + '  ' +fsTexto, Posicao, Colunas) ;
   end ;

   fsTextoVisivel := PadL( fsTextoVisivel, Colunas) ;

end;

{ TACBrDISLinhas }

function TACBrDISLinhas.Add(Obj: TACBrDISLinha): Integer;
begin
  Result := inherited Add(Obj) ;
end;

function TACBrDISLinhas.GetObject(Index: Integer): TACBrDISLinha;
begin
  Result := inherited GetItem(Index) as TACBrDISLinha ;
end;

procedure TACBrDISLinhas.Insert(Index: Integer; Obj: TACBrDISLinha);
begin
  inherited Insert(Index, Obj);
end;

procedure TACBrDISLinhas.SetObject(Index: Integer; Item: TACBrDISLinha);
begin
  inherited SetItem (Index, Item) ;
end;


{ TACBrDIS }
constructor TACBrDIS.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  fsAtivo       := false ;
  fsModelo      := disNenhum ;
  fsAlinhamento := alEsquerda ;
  fsPassos      := 1 ;
  fsOnAtualiza  := nil ;

  { Instanciando SubComponente TACBrDevice }
  fsDevice := TACBrDevice.Create( self ) ;  { O dono � o proprio componente }
  fsDevice.Name := 'ACBrDevice' ;      { Apenas para aparecer no Object Inspector}
  fsDevice.SetSubComponent( true );{ para gravar no DFM/XFM }
  fsDevice.Porta := 'COM1';
  fsDevice.Serial.DeadlockTimeout := 1000 ;

  { Thread para simular um Timer }
  fsTimer := TACBrThreadTimer.Create ;
  fsTimer.Interval := 300 ;
  fsTimer.OnTimer  := AtualizaLinhas ;
  fsTimer.Enabled  := false ;

  fsLinhas := TACBrDISLinhas.Create( true );
  
  { Instanciando fsDIS com modelo Generico (DISClass) }
  fsDIS := TACBrDISClass.create( self ) ;
  LinhasCount := fsDIS.LinhasCount ;
  Colunas     := fsDIS.Colunas ;
  fsDIS.Cursor.X := 1 ;
  fsDIS.Cursor.Y := 1 ;
end;

destructor TACBrDIS.Destroy;
begin
  Ativo := false ;

  fsTimer.Interval := 0 ;
  fsTimer.Terminate ;
  fsTimer.Free ;

  if Assigned( fsDIS ) then
     FreeAndNil( fsDIS ) ;

  fsLinhas.Free ;
  FreeAndNil( fsDevice ) ;

  inherited Destroy;
end;

procedure TACBrDIS.SetModelo(const Value: TACBrDISModelo);
begin
  if fsModelo = Value then exit ;

  if fsAtivo then
     raise Exception.Create('N�o � poss�vel mudar o Modelo com ACBrDIS Ativo');

  FreeAndNil( fsDIS ) ;

  { Instanciando uma nova classe de acordo com fsModelo }
  case Value of
     disGertecSerial    : fsDIS := TACBrDISGertecSerial.create( Self ) ;
     disGertecTeclado   : fsDIS := TACBrDISGertecTeclado.create( Self ) ;
  else
     fsDIS := TACBrDISClass.create( Self ) ;
  end;

  LinhasCount := fsDIS.LinhasCount ;
  Colunas     := fsDIS.Colunas ;
  fsModelo := Value;
end;

procedure TACBrDIS.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

procedure TACBrDIS.Ativar;
begin
  if fsAtivo then exit ;

  fsDIS.Ativar ;
  fsAtivo := true ;
end;

procedure TACBrDIS.Desativar;
begin
  if not fsAtivo then exit ;

  Parar ;
  
  fsDIS.Desativar ;
  fsAtivo := false;
end;


function TACBrDIS.GetModeloStrClass: String;
begin
  Result := fsDIS.ModeloStr ;
end;

function TACBrDIS.GetPorta: String;
begin
  result := fsDevice.Porta ;
end;

procedure TACBrDIS.SetPorta(const Value: String);
begin
  fsDevice.Porta := Value ;
end;

procedure TACBrDIS.SetIntervalo(const Value: Integer);
begin
  fsTimer.Interval := Value;
end;

function TACBrDIS.GetIntervalo: Integer;
begin
  Result := fsTimer.Interval ;
end;

procedure TACBrDIS.SetPassos(const Value: Integer);
begin
  if Value < 1 then
     fsPassos := 1
  else
     fsPassos := Value;
end;

function TACBrDIS.GetColunasClass: Integer;
begin
  Result := fsDIS.Colunas ;
end;

procedure TACBrDIS.SetColunasClass(const Value: Integer);
Var A : Integer ;
begin
  fsDIS.Colunas := Value ;
  For A := 0 to Linhas.Count-1 do
     Linhas[A].Colunas := Value ;
end;

procedure TACBrDIS.SetLinhasCount(const Value: Integer);
Var Lin : TACBrDISLinha ;
begin
  if Linhas.Count < Value then
     while Linhas.Count < Value do
     begin
        Lin := TACBrDISLinha.Create ;
        Lin.Colunas := Colunas ;
        Linhas.Add( Lin ) ;
     end
  else
     while Linhas.Count > Value do
        Linhas.Delete( Linhas.Count - 1 ) ;

  fsLinhasCount     := Value ;
  fsDIS.LinhasCount := Value ;
end;

Function TACBrDIS.AjustaTexto(Texto: String;
  Alin: TACBrDISAlinhamento) : String ;
begin
  Result := Texto ;
  if Length( Texto ) > Colunas then exit ;
  
  case Alin of
     alJustificado : Result := padS(Texto, Colunas,' ') ;
     alDireita     : Result := padR(Texto, Colunas)     ;
     alCentro      : Result := padC(Texto, Colunas)     ;
  else ;
     Result := padL(Texto, Colunas) ;
  end;
end;

procedure TACBrDIS.ExibirLinha(Linha: Integer; AText: String);
begin
  AText := AjustaTexto( AText, Alinhamento ) ;

  with Linhas[ Linha - 1] do
  begin
     Posicao  := 1 ;
     Texto    := AText ;
     Rolando  := false ;
     Exibindo := false ;
  end ;

  DoOnAtualizar( Linha );
end;

procedure TACBrDIS.ExibirLinha(Linha: Integer; AText: String;
  Alinhamento: TACBrDISAlinhamento);
Var wAlinhamento : TACBrDISAlinhamento ;
begin
  wAlinhamento := fsAlinhamento ;
  fsAlinhamento:= Alinhamento ;
  try
     ExibirLinha( Linha, AText );
  finally
     fsAlinhamento := wAlinhamento ;
  end ;
end;

procedure TACBrDIS.ExibirLinha(Linha: Integer; AText: String;
  Efeito: TACBrDISEfeitoExibir);
Var Lin : TACBrDISLinha ;
    Ini : Integer ;
begin
  VerificaLinhaExiste( Linha ) ;
  Ativo := true ;

  AText := AjustaTexto(AText,fsAlinhamento) ;
  Lin   := Linhas[ Linha - 1] ;
  Ini   := Length( AText ) ;
  
  case Efeito of
     efeEsquerda_Direita : Lin.Posicao :=  Ini ;
     efeDireita_Esquerda : Lin.Posicao := -Ini ;
  end;

  Lin.Texto        := AText ;
  Lin.Exibindo     := true ;
  Lin.Rolando      := false ;
  Lin.EfeitoExibir := Efeito ;

  fsTimer.Enabled := true ;
end;

procedure TACBrDIS.RolarLinha(Linha: Integer; Efeito: TACBrDISEfeitoRolar);
Var Lin : TACBrDISLinha ;
begin
  VerificaLinhaExiste( Linha ) ;
  Ativo := true ;

  Lin := Linhas[ Linha - 1] ;
  Lin.Rolando     := true ;
  Lin.EfeitoRolar := Efeito ;
  fsTimer.Enabled := true ;

  if Efeito = rolVai_e_Volta then
  begin
     Lin.ParaEsquerda := false ;
     Lin.Texto := TrimLeft( Lin.Texto ) ;
     if Length( Lin.Texto ) < Colunas then
        Lin.Posicao := Length( Lin.Texto ) - Colunas ;
  end ;
end;

procedure TACBrDIS.Parar;
begin
  fsTimer.Enabled := false ;
end;

procedure TACBrDIS.Continuar;
begin
  fsTimer.Enabled := True ;
end;

procedure TACBrDIS.ContinuarLinha(Linha: Integer);
begin
  VerificaLinhaExiste( Linha );
  Linhas[Linha-1].Enabled := true ;
end;

procedure TACBrDIS.PararLinha(Linha: Integer);
begin
  VerificaLinhaExiste( Linha );
  Linhas[Linha-1].Enabled := false ;
end;


procedure TACBrDIS.LimparDisplay;
Var wAtivo : Boolean ;
    A : Integer ;
begin
  wAtivo := Ativo ;
  try
     Ativo := true ;
     fsDIS.LimparDisplay ;
     fsDIS.Cursor.X := 1 ;
     fsDIS.Cursor.Y := 1 ;

     For A := 0 to Linhas.Count-1 do
        with Linhas[A] do
        begin
           Posicao  := 1  ;
           Texto    := '' ;
           Rolando  := false ;
           Exibindo := false ;

           if Assigned( fsOnAtualiza ) then
              fsOnAtualiza( A+1, TextoVisivel ) ;
        end ;
        
  finally
     Ativo := wAtivo ;
  end ;
end;

procedure TACBrDIS.PosicionarCursor(Linha, Coluna: Integer);
begin
  VerificaLinhaExiste( Linha ) ;
  
  Ativo := true ;
  fsDIS.PosicionarCursor( Linha, Coluna );
  fsDIS.Cursor.X := Linha  ;
  fsDIS.Cursor.Y := Coluna ;
end;

procedure TACBrDIS.Escrever(AText: String);
begin
  Ativo := true ;
  fsDIS.Escrever( AText );

  with Linhas[Cursor.X-1] do
  begin
     Texto := StuffString( Texto, Cursor.Y + Posicao - 1, Length(AText), AText)
  end ;
  fsDIS.Cursor.Y := Cursor.Y + Length( AText ) ;

  if Assigned( fsOnAtualiza ) then
     fsOnAtualiza( Cursor.X, Linhas[Cursor.X-1].TextoVisivel ) ;
end;

procedure TACBrDIS.VerificaLinhaExiste( Linha : Integer ) ;
begin
  if (Linha < 1) or (Linha > Linhas.Count) then
     raise Exception.Create('Linha '+IntToStr(Linha)+' fora da Faixa, 1 - '+
                            IntToStr(Linhas.Count)) ;
end;

procedure TACBrDIS.AtualizaLinhas(Sender: TObject);
Var A : Integer ;
    Desliga : Boolean ;
    PosFim : Integer ;
begin
  Desliga := true ;

  For A := 0 to Linhas.Count-1 do
  begin
     with Linhas[A] do
     begin
        if Enabled then
        begin
           if Exibindo then
            begin
              if EfeitoExibir = efeEsquerda_Direita then
               begin
                 Posicao := Posicao - Passos ;
                 if Posicao <= 1 then
                    Posicao := 1 ;
               end
              else
               begin
                 Posicao := Posicao + Passos ;
                 if Posicao >= 1 then
                    Posicao := 1 ;
               end ;

              Exibindo := (Posicao <> 1) ;
              Desliga  := Desliga and (not Exibindo) and (not Rolando) ;

              DoOnAtualizar( A + 1 );
            end
           else
              if Rolando then
              begin
                 case EfeitoRolar of
                    rolParaEsquerda_Inicio, rolParaEsquerda_Sempre :
                    begin
                       Posicao := Posicao + Passos ;
                       if Posicao >= Length( Texto )+3  then
                          Posicao := 1 ;
                    end ;

                    rolParaDireita_Inicio :
                    begin
                       Posicao := Posicao - Passos ;
                       if Posicao <= -Colunas  then
                          Posicao := Length( Texto ) - Colunas + 1;
                    end ;

                    rolParaDireita_Sempre :
                    begin
                       Posicao := Posicao - Passos ;
                       if Posicao <= -Colunas-2  then
                          Posicao := Length( Texto ) - Colunas ;
                    end ;

                    rolVai_e_Volta :
                    begin
                       if ParaEsquerda then
                        begin
                          Posicao := Posicao + Passos ;
                          PosFim  := Max(Length( Trim(Texto) )-Colunas+1,1) ;
                          if Posicao > PosFim then
                          begin
                             Posicao := PosFim ;
                             ParaEsquerda := false ;
                          end ;
                        end
                       else
                        begin
                          Posicao := Posicao - Passos ;
                          PosFim  := Min(Length( Trim(Texto) )-Colunas+1,1) ;
                          if Posicao < PosFim  then
                          begin
                             Posicao := PosFim ;
                             ParaEsquerda := true ;
                          end ;
                        end ;
                    end ;
                 end;

                 DoOnAtualizar( A + 1 );
                 Desliga := False ;
              end ;
        end ;
     end ;
  end ;

  fsTimer.Enabled := not Desliga
end;

procedure TACBrDIS.DoOnAtualizar(Linha : Integer ) ;
Var Texto : String ;
begin
  Texto := Linhas[Linha-1].TextoVisivel ;
  PosicionarCursor(Linha, 1);
  fsDIS.Escrever( Texto );

  if Assigned( fsOnAtualiza ) then
     fsOnAtualiza( Linha, Texto ) ;
end;

function TACBrDIS.GetTimerEnable: Boolean;
begin
  Result := fsTimer.Enabled ;
end;

function TACBrDIS.GetCursorClass: TPoint;
begin
  result := fsDIS.Cursor ; 
end;

end.


