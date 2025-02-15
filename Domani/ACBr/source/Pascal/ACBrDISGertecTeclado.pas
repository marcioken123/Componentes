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
|* 30/09/2004: Daniel Simoes de Almeida
|*  - Primeira Versao ACBrDISGertecTeclado
|* 05/11/2004: Daniel Simoes de Almeida
|*  - Adcionado suporte a Linux
******************************************************************************}

{$I ACBr.inc}

unit ACBrDISGertecTeclado;

interface
uses ACBrDISClass,
     Classes;

const
   PortAtOut = 96 ;
   PortAtIn  = 100 ;

{ Nota: - A comunica��o com a Porta AT n�o � t�o r�pida quando a Porta Serial,
          por isso, evite o uso excessivo de textos "animados"
        - A fun�ao TxKeyboard() funciona normalmente em Win9x,
        - XP /NT /2000, deve-se usar um device driver que permita acesso direto
          a porta AT (dispon�vel em www.gertec.com.br)
        - Linux: � necess�rio ser ROOT para acessar /dev/port
          (use: su  ou  chmod u+s SeuPrograma ) }
type
TACBrDISGertecTeclado = class( TACBrDISClass )
  private
    fsIntervaloEnvioBytes: Integer; 
    procedure TxKeyboard( B: Byte ) ;

  public
    constructor Create(AOwner: TComponent);

   { Aumente esse intervalo se n�o estiver exibindo corretamente.
     Use valores de 0 a 10. Default = 1 }
    property IntervaloEnvioBytes : Integer read fsIntervaloEnvioBytes
       write fsIntervaloEnvioBytes ;
    procedure Ativar ; override ;
    
    procedure LimparDisplay ; override ;
    procedure PosicionarCursor(Linha, Coluna: Integer ) ; override ;
    procedure Escrever( Texto : String ) ; override ;
end ;

implementation
Uses ACBrDIS, ACBrUtil,
     SysUtils, DateUtils ;

{ TACBrDISGertecTeclado}

constructor TACBrDISGertecTeclado.Create(AOwner: TComponent);
begin
  inherited Create( AOwner );

  fsIntervaloEnvioBytes := 1 ;
  fpModeloStr := 'Gertec Teclado' ;
  LinhasCount := 2 ;
  Colunas     := 40 ;
end;


procedure TACBrDISGertecTeclado.LimparDisplay;
begin
{ TxKeyboard( 231 );  // Liga display
  TxKeyboard( 12 );   // Limpa Display
  TxKeyboard( 232 );  // DesLiga display }

  TxKeyboard( 212 );  // Limpa Display direto 
end;

procedure TACBrDISGertecTeclado.PosicionarCursor(Linha, Coluna: Integer);
Var ColB, LinB : Byte ;
begin
  ColB := ord(chr(Coluna)) ;
  LinB := ord(chr(Linha)) ;

{ TxKeyboard( 231 );  // Liga display
  TxKeyboard( 9 ) ;
  TxKeyboard( ColB );
  TxKeyboard( LinB ) ;
  TxKeyboard( 232 );  // DesLiga display }

  TxKeyboard( 214 ) ;   { posicionamento de cursor direto }
  TxKeyboard( ColB );
  TxKeyboard( LinB ) ;
end;

procedure TACBrDISGertecTeclado.Escrever(Texto: String);
Var A : Integer ;
    TextoComp : String;
begin
  { Verificando se � mais r�pido apagar toda linha. Isso ocorrer� quando "Texto"
    possuir muitos caracteres em branco e for do tamanho de "Colunas" }
  if (Cursor.Y = 1) and (Length( Texto ) = Colunas) then
  begin
     TextoComp := Trim( Texto ) ;
     if Length(TextoComp)  < (Colunas - 4) then
     begin
        if Cursor.X = 1 then
           TxKeyboard( 219 )   // Apaga linha 1
        else
           TxKeyboard( 221 );  // Apaga linha 2

        TextoComp := TrimLeft( Texto ) ;
        PosicionarCursor(Cursor.X, (Colunas - Length(TextoComp) + 1));
        Texto := Trim( Texto ) ;
     end ;
  end ;

  TxKeyboard( 231 );  // Liga display
  For A := 1 to Length( Texto ) do
     TxKeyboard( ord(Texto[A]) ) ;      // Envia um Byte por vez...
  TxKeyboard( 232 );  // DesLiga display
end;

procedure TACBrDISGertecTeclado.TxKeyboard(B: Byte);
begin
  { Aguarda se a porta AT nao est� livre }
  while (InPort( PortAtIn ) and 02) <> 0 do
     sleep(1) ;

  OutPort( PortAtOut, B);
  sleep( fsIntervaloEnvioBytes ) ;
end;

procedure TACBrDISGertecTeclado.Ativar;
begin
  { Nao precisa de inicializa�ao }
  fpAtivo := true ;
end;

end.
