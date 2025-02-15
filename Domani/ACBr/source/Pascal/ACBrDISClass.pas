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
|* 28/09/2004: Daniel Simoes de Almeida
|*  - Primeira Versao ACBrDIS
******************************************************************************}

{$I ACBr.inc}

unit ACBrDISClass;

interface
uses ACBrBase,     {Units da ACBr}
     Classes, Types; 

type

{ Classe generica de DISPLAY, nao implementa nenhum modelo especifico, apenas
  declara a Classe. NAO DEVE SER INSTANCIADA. Usada apenas como base para
  as demais Classes de DISPLAY como por exemplo a classe TACBrDISGertecSerial }

TACBrDISClass = class
  private

    fsColunas: Integer;
    fsLinhasCount: Integer;

    procedure SetAtivo(const Value: Boolean);
    procedure SetColunas(const Value: Integer);
  protected
    fpDevice  : TACBrDevice ;

    fpAtivo   : Boolean ;
    fpModeloStr: String;
    fpPassos: Integer;

  public
    Cursor : TPoint ;
    
    constructor Create(AOwner: TComponent);
    Destructor Destroy  ; override ;

    Property Ativo  : Boolean read fpAtivo write SetAtivo ;
    procedure Ativar ; virtual ;
    procedure Desativar ; virtual ;

    Property ModeloStr: String  read fpModeloStr ;

    property LinhasCount : Integer read fsLinhasCount  write fsLinhasCount  ;
    property Colunas : Integer read fsColunas write SetColunas ;

    procedure LimparDisplay ; virtual ;
    procedure PosicionarCursor( Linha, Coluna: Integer ) ; virtual ;
    procedure Escrever( Texto : String ) ; virtual ;
end ;

implementation
Uses ACBrDIS,
     SysUtils ;

{ TACBrDISClass }

constructor TACBrDISClass.Create(AOwner: TComponent);
begin
  if not (AOwner is TACBrDIS) then
     raise Exception.create('Essa Classe deve ser instanciada por TACBrDIS');

  { Criando ponteiro interno para as Propriedade SERIAL de ACBrDIS,
    para permitir as Classes Filhas o acesso a essas propriedades do Componente}

  fsLinhasCount := 2 ;
  fsColunas     := 20 ;
         
  fpDevice    := (AOwner as TACBrDIS).Device ;
  fpDevice.SetDefaultValues ;

  fpAtivo     := false ;
  fpModeloStr := 'N�o Definida' ;
  fpPassos    := 1 ;
end;

destructor TACBrDISClass.Destroy;
begin
  fpDevice := nil ; { Apenas remove referencia (ponteiros internos) }

  inherited Destroy;
end;

procedure TACBrDISClass.SetAtivo(const Value: Boolean);
begin
  if Value then
     Ativar
  else
     Desativar ;
end;

procedure TACBrDISClass.Ativar;
begin
  if fpAtivo then exit ;

  if fpDevice.Porta <> '' then
     fpDevice.Ativar ;
     
  fpAtivo := true ;
end;

procedure TACBrDISClass.Desativar;
begin
  if not fpAtivo then exit ;

  if fpDevice.Porta <> '' then
     fpDevice.Desativar ;
     
  fpAtivo := false ;
end;

procedure TACBrDISClass.SetColunas(const Value: Integer);
begin
  fsColunas := Value;
end;

procedure TACBrDISClass.LimparDisplay;
begin
  { Deve ser implementada na ClassFilha }
end;

procedure TACBrDISClass.PosicionarCursor(Linha, Coluna: Integer);
begin
  { Deve ser implementada na ClassFilha }
end;

procedure TACBrDISClass.Escrever(Texto: String);
begin
  { Deve ser implementada na ClassFilha }
end;

end.
