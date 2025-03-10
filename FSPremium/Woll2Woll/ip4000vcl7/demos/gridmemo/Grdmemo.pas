unit Grdmemo;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Grids, DBGrids, DBTables, DB, wwstr, StdCtrls,
  Buttons, Wwkeycb, Wwdbgrid,
  Wwtable, Wwdblook, Wwdbigrd, Wwdatsrc, Wwdbdlg, ExtCtrls,
  TabNotBk, DBCtrls, IniFiles, wwidlg, ComCtrls, wwriched;

type
  TGridMemoApp = class(TForm)
    CustomerTable: TwwTable;
    CustomerSource: TwwDataSource;
    wwDBGrid1: TwwDBGrid;
    CancelBtn: TBitBtn;
    BitBtn2: TBitBtn;
    wwDBRichEdit1: TwwDBRichEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure wwDBGrid1MemoOpen(Grid: TwwDBGrid;
      MemoDialog: TwwMemoDialog);
    procedure wwDBGrid1CreateHintWindow(Sender: TObject;
      HintWindow: TwwGridHintWindow; AField: TField; R: TRect;
      var WordWrap: Boolean; var MaxWidth, MaxHeight: Integer;
      var DoDefault: Boolean);
  private
  public
  end;

var
  GridMemoApp: TGridMemoApp;

implementation

{$R *.DFM}


procedure TGridMemoApp.BitBtn2Click(Sender: TObject);
begin
   Close;
end;

procedure TGridMemoApp.wwDBGrid1MemoOpen(Grid: TwwDBGrid;
  MemoDialog: TwwMemoDialog);
begin
   with MemoDialog do begin
      DlgLeft:= 15;
   end;
end;

procedure TGridMemoApp.wwDBGrid1CreateHintWindow(Sender: TObject;
  HintWindow: TwwGridHintWindow; AField: TField; R: TRect;
  var WordWrap: Boolean; var MaxWidth, MaxHeight: Integer;
  var DoDefault: Boolean);
begin
  WordWrap := True;
  if (AField is TBlobField) then
     MaxWidth := 100;
  MaxHeight := Screen.Height;
end;

end.
