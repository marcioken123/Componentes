unit gridlargeedit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, wwriched, DB, DBTables, Wwtable, Wwdatsrc,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, Mask, wwdbedit;

type
  TLargeGridEditForm = class(TForm)
    wwDBGrid1: TwwDBGrid;
    wwDBGrid1IButton: TwwIButton;
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;
    wwDBRichEdit1: TwwDBRichEdit;
    wwDBEdit1: TwwDBEdit;
    procedure wwDBRichEdit1Enter(Sender: TObject);
    procedure wwDBEdit1Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LargeGridEditForm: TLargeGridEditForm;

implementation

{$R *.dfm}

procedure TLargeGridEditForm.wwDBRichEdit1Enter(Sender: TObject);
begin
  with wwDBGrid1 do begin
     ColumnByName('RINTERESTS').DisableSizing:=True;
     wwDBRichEdit1.Width:= 200;
     wwDBRichEdit1.Height:= 40;
  end;
end;

procedure TLargeGridEditForm.wwDBEdit1Enter(Sender: TObject);
begin
  with wwDBGrid1 do begin
     ColumnByName('ADDRESS_1').DisableSizing:=True;
     wwDBEdit1.Width:= 200;
  end;

end;

end.
