{***********************************************************
                R&A Library
              R&A Form Designer
       Copyright (C) 1998-99 R&A

       description : R&A implemetation of
                     Delphi design-time packages

       programer   : black
       e-mail      : blacknbs@chat.ru
       www         : www.chat.ru\~blacknbs\ralib
************************************************************}

{$INCLUDE RA.INC}

unit fDBGridColumnsEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, StdCtrls, ExtCtrls, DBGrids,
  DsgnIntf, fCollectionEditor, RARegAuto;

type
  TDBGridColumnsEditor = class(TCollectionEditor)
    AddAllFields: TButton;
    RestoreDefaults: TButton;
  private
  end;

implementation

{$R *.dfm}

              
end.
