{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:    Marcelo Welter - www.welter.pro.br/sultan    }
{                                 Alexandre Rocha Lima e Marcondes             }
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
|* 21/09/2004: Daniel Simoes de Almeida
|*  - Primeira Versao ACBrLCB
******************************************************************************}

{$I ACBr.inc}

unit ACBrLCB;

interface
uses ACBrBase,  {Units da ACBr}
     SysUtils, DateUtils , Classes ;


type

{ Componente ACBrLCB - Leitor de C�digo de Barras }
TACBrLCB = class( TACBrComponent )
  private
    fsDevice  : TACBrDevice ;   { SubComponente ACBrDevice }
    fsTimer   : TACBrThreadTimer ;
    
    { Propriedades do Componente ACBrLCB }
    fsAtivo  : Boolean;
    fsOnLeCodigo: TNotifyEvent;
    fsOnLeFila : TNotifyEvent;
    fsUsarFila: Boolean;
    fsFilaMaxItens: Integer;
    fsExcluirSufixo: Boolean;
    fsSufixo: String;
    fs_Sufixo: String;
    fsPrefixoAExcluir: String;
    fs_PrefixoAExcluir: String;
    fsUltimaLeitura: String;
    fsUltimoCodigo: String;
    fsIntervalo: Integer;

    procedure SetPorta(const Value: String);
    procedure SetAtivo(const Value: Boolean);

    function GetPorta: String;
    function GetFilaCount: Integer;

    procedure LeSerial(Sender: TObject);
    procedure SetUltimoCodigo(const Value: String);
    procedure SetPrefixoAExcluir(const Value: String);
    procedure SetSufixo(const Value: String);
    procedure AddFila( AString : String ) ;
    procedure SetUsarFila(const Value: Boolean);
    procedure SetIntervalo(const Value: Integer);
  protected

  public
    Fila : TStringList ;

    constructor Create(AOwner: TComponent); override;
    Destructor Destroy  ; override ;

    procedure Ativar ;
    procedure Desativar ;
    property Ativo : Boolean read fsAtivo write SetAtivo ;

    function LerFila : String ;
    procedure ApagarFila ;
    property FilaCount : Integer read GetFilaCount ;

    property UltimaLeitura : String read fsUltimaLeitura ;
    property UltimoCodigo  : String read fsUltimoCodigo ;
  published
     { Instancia do Componente ACBrDevice }
     property Device : TACBrDevice read fsDevice ;
     property Porta : String read GetPorta write SetPorta ;

     property PrefixoAExcluir : String  read fsPrefixoAExcluir
        write SetPrefixoAExcluir;
     property Sufixo : String  read fsSufixo write SetSufixo ;
     property ExcluirSufixo : Boolean read fsExcluirSufixo
        write fsExcluirSufixo default true ;

     property UsarFila : Boolean read fsUsarFila write SetUsarFila
        default false ;
     property FilaMaxItens : Integer read fsFilaMaxItens write fsFilaMaxItens
        default 0 ;

     property Intervalo  : Integer      read fsIntervalo
        write SetIntervalo default 200 ;
     property OnLeCodigo : TNotifyEvent read fsOnLeCodigo write fsOnLeCodigo ;
     property OnLeFila   : TNotifyEvent read fsOnLeFila   write fsOnLeFila   ;
end ;

Function EAN13Valido( CodEAN13 : String ) : Boolean ;
Function EAN13_DV( CodEAN13 : String ) : String ;

implementation

uses ACBrUtil,
     StrUtils, Math, synaser;

{------------------------------------------------------------------------------
 Calcula e Retorna o Digito verificador do EAN-13 de acordo com 12 primeiros
  caracteres de <CodEAN13>
 ------------------------------------------------------------------------------}
function EAN13_DV(CodEAN13: String): String;
Var A,DV : Integer ;
begin
   Result   := '' ;
   CodEAN13 := PadR(Trim(CodEAN13),12,'0') ;
   if not StrIsNumber( CodEAN13 ) then
      exit ;

   DV := 0;
   For A := 12 downto 1 do
      DV := DV + (StrToInt( CodEAN13[A] ) * IfThen(odd(A),1,3));

   DV := (Ceil( DV / 10 ) * 10) - DV ;

   Result := IntToStr( DV );
end;

{------------------------------------------------------------------------------
 Retorna True se o <CodEAN13> informado for v�lido 
 ------------------------------------------------------------------------------}
function EAN13Valido(CodEAN13: String): Boolean;
begin
  Result := false ;
  if Length(CodEAN13) = 13 then
     Result := ( CodEAN13[13] =  EAN13_DV(CodEAN13) ) ;
end;


{ TACBrLCB }

constructor TACBrLCB.Create(AOwner: TComponent);
begin
  inherited create( AOwner );

  fsAtivo           := false ;
  fsPrefixoAExcluir := '' ;
  fs_PrefixoAExcluir:= '' ;
  fsSufixo          := '#13' ;
  fs_Sufixo         := #13 ;
  fsExcluirSufixo   := true ;
  fsUsarFila        := false ;
  fsFilaMaxItens    := 0 ;
  fsUltimaLeitura   := '' ;
  fsOnLeCodigo      := nil ;
  fsOnLeFila        := nil ;
  fsIntervalo       := 200 ;

  Fila := TStringList.Create ;

  { Instanciando SubComponente TACBrDevice }
  fsDevice := TACBrDevice.Create( self ) ;  { O dono � o proprio componente }
  fsDevice.Name := 'ACBrDevice' ;      { Apenas para aparecer no Object Inspector}
  fsDevice.SetSubComponent( true );{ para gravar no DFM/XFM }
  fsDevice.Porta := 'COM1';
  fsDevice.Serial.DeadlockTimeout := 1000 ;

  { Thread para simular um Timer }
  fsTimer := TACBrThreadTimer.Create ;
  fsTimer.OnTimer := LeSerial ;
end;

destructor TACBrLCB.Destroy;
begin
  Desativar ;

  fsTimer.Interval := 0 ;
  fsTimer.Terminate ;
  fsTimer.Free ;

  FreeAndNil( fsDevice ) ;
  FreeAndNil( Fila );

  inherited Destroy;
end;

procedure TACBrLCB.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

procedure TACBrLCB.Ativar;
begin
  if fsAtivo then exit ;

  if not fsDevice.IsSerialPort  then
     raise Exception.Create('O ACBrLCB foi projetado para Leitores de'+#10+
                            ' C�digo de Barras ligados a Portas Seriais.');

  try
     fsDevice.Ativar ;

     if fsIntervalo = 0 then
        fsIntervalo := 200 ;
        
     fsTimer.Interval := fsIntervalo ;
     fsTimer.Enabled  := true ;   { Ativa a ThreadTimer }

     fsAtivo := true ;
  except
     Desativar ;
     raise ;
  end ;
end;

procedure TACBrLCB.Desativar;
begin
  if not fsAtivo then exit ;

  fsDevice.Desativar ;
  fsTimer.Enabled := false ; { Suspende a ThreadTimer }

  fsAtivo := false;
end;

function TACBrLCB.GetPorta: String;
begin
  result := fsDevice.Porta ;
end;

procedure TACBrLCB.SetPorta(const Value: String);
begin
  fsDevice.Porta := Value ;
end;

function TACBrLCB.GetFilaCount: Integer;
begin
  Result := Fila.Count ;
end;

procedure TACBrLCB.ApagarFila;
begin
  Fila.Clear ;
end;

function TACBrLCB.LerFila: String;
begin
  Result := '' ;
  if Fila.Count > 0 then
  begin
     Result := Fila[0] ;
     Fila.Delete( 0 ) ;

     SetUltimoCodigo( Result );
     if Assigned( fsOnLeFila ) then
        fsOnLeFila( self ) ;
  end
end;

procedure TACBrLCB.SetUltimoCodigo(const Value: String);
begin
  { acertando codigo, removendo prefixo, sufixo } 
  fsUltimoCodigo := Value;
  if fs_PrefixoAExcluir <> '' then
     if LeftStr(fsUltimoCodigo,Length(fs_PrefixoAExcluir)) =
        fs_PrefixoAExcluir then
        fsUltimoCodigo := copy(fsUltimoCodigo, Length(fs_PrefixoAExcluir)+1,
                                               Length(fsUltimoCodigo) ) ;

  if fsExcluirSufixo then
     if RightStr(fsUltimoCodigo,Length(fs_Sufixo)) = fs_Sufixo then
        fsUltimoCodigo := copy(fsUltimoCodigo, 1,
                          Length(fsUltimoCodigo)-Length(fs_Sufixo) ) ;
end;

procedure TACBrLCB.SetPrefixoAExcluir(const Value: String);
begin
  fsPrefixoAExcluir  := Value;
  fs_PrefixoAExcluir := TraduzComando( Value ) ;
end;

procedure TACBrLCB.SetSufixo(const Value: String);
begin
  if Value = '' then  {Isso ir� for�ar o Sufixo ser gravado no DFM/XFM mesmo que}
     fsSufixo := ' '  {ele seja vazio. Necess�rio, pois ele � criado com #13 }
  else
     fsSufixo  := Value;
  fs_Sufixo := TraduzComando( Value ) ;
end;

procedure TACBrLCB.AddFila(AString: String);
begin
  if Fila.Count = FilaMaxItens then
     Fila.Delete( 0 ) ;

  Fila.Add( AString ) ;
end;

procedure TACBrLCB.SetUsarFila(const Value: Boolean);
begin
  fsUsarFila := Value;

  if Value then
   begin
     if Sufixo = '' then  { precisa de um Sufixo para manipular Filas }
        Sufixo := '#13' ;

     if FilaMaxItens = 0 then
        FilaMaxItens := 100 ;
   end
  else
     Fila.Clear ;
end;

procedure TACBrLCB.LeSerial(Sender: TObject);
var leitura : String ;
    OldRaiseExcept : Boolean ;
begin
  with fsDevice.Serial do
  begin
     if InstanceActive then
     begin
        if WaitingDataEx > 0 then
        begin
           leitura := '' ;
           if fs_Sufixo <> '' then
              OldRaiseExcept := RaiseExcept ;
              try
                 { Desliga a RaiseExcept para nao perder o Buffer da serial, se
                   RecvTerminated falhar (bug da Synaser) }
                 RaiseExcept    := false ;
                 leitura := RecvTerminated(200,fs_Sufixo) ;
                 if leitura <> '' then
                    leitura := leitura + fs_Sufixo ;
              finally
                 RaiseExcept := OldRaiseExcept ;
              end ;

           if leitura = '' then
              leitura := RecvPacket(200) ;

           fsUltimaLeitura := leitura ; {Leitura exatamente como veio do Leitor}
           
           if UsarFila then
              AddFila( leitura ) ;

           SetUltimoCodigo( leitura );
           if Assigned( fsOnLeCodigo ) then
              fsOnLeCodigo( self ) ;
        end;
     end ;
  end ;
end;

procedure TACBrLCB.SetIntervalo(const Value: Integer);
begin
  fsIntervalo := Value;
  fsTimer.Interval := Value ;

  if Value = 0 then
     Desativar ;
end;

end.
