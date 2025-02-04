unit FSRegistroXY;

interface

uses
  Classes, ExtCtrls, Graphics, Controls, SysUtils, Messages, Db;

type
  TFSRegistroXY = class(TGraphicControl)
  private
    FResource: PResource;  
    FWidth: Integer;
    FHeight: Integer;
    FAlignment: TAlignment;
    FCaption: TCaption;
    FFont: TFont;
    FParentFont: Boolean;
    FRotulo1: string;
    FRotulo2: string;
    FDataSet: TDataSet;
  public
    procedure Atualizar;
  published
    property Width: Integer read FWidth write FWidth;
    property Height: Integer read FHeight write FHeight;
    property Alignment: TAlignment read FAlignment write FAlignment;
    property Anchors;
    property DataSet: TDataSet read FDataSet write FDataSet;
    property Rotulo1: string read FRotulo1 write FRotulo1;     
    property Rotulo2: string read FRotulo2 write FRotulo2;
    property Caption;
    property Font;
    property ParentFont: Boolean read FParentFont write FParentFont;
      //Alignment = taRightJustify
      //Anchors = [akTop, akRight]
      //Caption = 'FSRegistroXY1'
      //Font.Charset = DEFAULT_CHARSET
      //Font.Color = clOlive
      //Font.Height = -11
      //Font.Name = 'MS Sans Serif'
      //Font.Style = [fsBold]
      //ParentFont = False
      //Rotulo1 = 'Registro '
      //Rotulo2 = ' de '
      //DataSet = fDMMovEst.wwtMovEstPai
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FSPremium', [TFSRegistroXY]);
end;
{ TFSRegistroXY }

procedure TFSRegistroXY.Atualizar;
begin

end;

end.
