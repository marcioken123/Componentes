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
|* 27/05/2004: Primeira Versao
|*    Daniel Simoes de Almeida
|*    Cria�ao de um arquivo unico para registro dos Componentes
******************************************************************************}

{$I ACBr.inc}
unit ACBrReg;

interface
Uses Classes ,
    {$IFDEF VisualCLX}
       QDialogs,
       DesignIntf,
       DesignEditors
    {$ELSE}
       Dialogs ,
       {$IFNDEF Delphi6_UP}
         DsgnIntf,
       {$ELSE}
         DesignIntf,
         DesignEditors
       {$ENDIF}
    {$ENDIF} ;

type
  { Editor de Proriedades de Componente para mostrar o AboutACBr }
  TACBrAboutDialogProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
  end;

  { Editor de Proriedades de Componente de ACBrGAV -> StrComando }
  TACBrGAVStrComandoProperty = class( TStringProperty )
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues( Proc : TGetStrProc) ; override;
  end;

  { Editor de Proriedades de Componente para chamar OpenDialog }
  TACBrFileNameProperty = class( TStringProperty )
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  { Editor de Componente para mostrar a Calculadora}
  TACBrCalculadoraEditor = class( TComponentEditor )
  public
    procedure Edit; override;
  end;

  { Editor de Componente do ECF para Mostrar TestarDialog }
  TACBrECFEditor = class( TComponentEditor )
  public
    procedure Edit; override;
  end;

procedure Register;

implementation
Uses {$IFDEF VisualCLX}ACBrEnterTabCLX, {$ENDIF}
     ACBrECF, ACBrCalculadora, ACBrGAV, ACBrExtenso, ACBrValidador, ACBrCHQ,
     ACBrLCB, ACBrDIS, ACBrBase, SysUtils;

{$R ACBr.dcr}

procedure Register;
begin
  RegisterComponents('ACBr', [TACBrECF, TACBrCalculadora, TACBrGAV, TACBrCHQ,
     TACBrLCB, TACBrDIS, TACBrExtenso, TACBrValidador
     {$IFDEF VisualCLX}, TACBrEnterTab{$ENDIF} ]);

  { Registrando os Editores de Propriedade }
  RegisterPropertyEditor(TypeInfo(TACBrAboutInfo), nil, 'AboutACBr',
     TACBrAboutDialogProperty);
  RegisterPropertyEditor(TypeInfo(String), TACBrGAV, 'StrComando',
     TACBrGAVStrComandoProperty);
  RegisterPropertyEditor(TypeInfo(String), TACBrCHQ, 'ArquivoBancosINI',
     TACBrFileNameProperty);

  { Registrando os Editores de Componente }
  RegisterComponentEditor(TACBrCalculadora, TACBrCalculadoraEditor);
  RegisterComponentEditor(TACBrECF, TACBrECFEditor);
end;


{ TACBrAboutDialogProperty }
procedure TACBrAboutDialogProperty.Edit;
begin
  ACBrAboutDialog ;
end;

function TACBrAboutDialogProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TACBrAboutDialogProperty.GetValue: string;
begin
  Result := 'Vers�o: ' + ACBR_VERSAO ;
end;

{ TACBrCalculadoraEditor }

procedure TACBrCalculadoraEditor.Edit;
begin
  with Component as TACBrCalculadora do
     Execute ;
end;

{ TACBrECFEditor }

procedure TACBrECFEditor.Edit;
begin
  with Component as TACBrECF do
     TestarDialog ;
end;

{ TACBrGAVStrComandoProperty }

procedure TACBrGAVStrComandoProperty.Edit;
begin
  inherited;

end;

function TACBrGAVStrComandoProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList];
end;

procedure TACBrGAVStrComandoProperty.GetValues(Proc: TGetStrProc);
begin
  Proc('#027,v,#140 | Bematech') ;
  Proc('#254 | Daruma') ;
  Proc('#027,p,0,#050,#200 | Mecaf') ;
  Proc('#027,p,#000,#050,#200 | Schalter') ;
end;

{ TACBrFileNameProperty }

procedure TACBrFileNameProperty.Edit;
var Dlg : TOpenDialog ;
begin
  Dlg := TOpenDialog.Create( nil );
  try
     Dlg.FileName   := GetValue ;
     Dlg.InitialDir := ExtractFilePath( GetValue ) ;
     Dlg.Filter     := 'Arquivos INI|*.ini' ; 
     
     if Dlg.Execute then
        SetValue( Dlg.FileName );
  finally
     Dlg.Free ;
  end ;
end;

function TACBrFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

end.
