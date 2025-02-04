{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       class       : TRAAlignPalette
       description : Align Palette

       programer   : black
       e-mail      : black@infa.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit fRAFDAlignPalette;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Buttons, ExtCtrls, RARegAuto;

type
  TRAAlignPalette = class(TForm)
    Panel1: TPanel;
    bnLeft: TSpeedButton;
    AlignPalPopup: TPopupMenu;
    Stayontop: TMenuItem;
    RegAuto1: TRegAuto;
    procedure ButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  end;

  procedure Show;

implementation

uses RAUtils, RAFDDesigner, RAFD;


{$R *.dfm}

procedure Show;
var
  Form: TForm;
begin
  Form := FindFormByClass(TRAAlignPalette);
  if Form = nil then
    Form := TRAAlignPalette.Create(Application);
  Form.Show;
end;

procedure TRAAlignPalette.ButtonClick(Sender: TObject);
begin
  if ActiveDesigner <> nil then
    ActiveDesigner.AlignSelection(TAlignSelection((Sender as TComponent).Tag));
end;

procedure TRAAlignPalette.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TRAAlignPalette.FormCreate(Sender: TObject);
var
  i: integer;
begin
  Name := 'AlignPalette';
  RegAuto1.RegPath := BaseRegKey;
  ClientWidth := Panel1.Width;
  ClientHeight := Panel1.Height;
  Caption := ResStr(deAlign, Caption);
  for i := 0 to Panel1.ControlCount - 1 do    { Iterate }
    Panel1.Controls[i].Hint := ResStr(deAlign + 1 + Panel1.Controls[i].Tag,
      TSpeedButton(Panel1.Controls[i]).Caption)
end;

end.
