unit pLMDFilterPropertyEditorDlg;
{$I lmdcmps.inc}
interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
     Buttons, ExtCtrls, Dialogs, Grids;

type
  TLMDFilterPropsDlg = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    FilterGrid: TStringGrid;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
    FFilter:string;
  public
    { Public declarations }
    property Filter:string read FFilter write FFilter;
  end;

implementation

{$R *.DFM}
procedure TLMDFilterPropsDlg.FormCreate(Sender: TObject);
begin
 FilterGrid.Cells[0,0]:='Filter Name';
 FilterGrid.Cells[1,0]:='Filter';
end;

procedure TLMDFilterPropsDlg.FormShow(Sender: TObject);
var st:string;
    p,row:integer;
begin
 st:=Filter+'|';
 p:=Pos('|',st);
 row:=1;
 while p <> 0 do begin
  FilterGrid.Cells[0,row]:=copy(st,1,p-1);
  delete(st,1,p);
  p:=Pos('|',st);
  FilterGrid.Cells[1,row]:=copy(st,1,p-1);
  delete(st,1,p);
  inc(row);
  p:=Pos('|',st);
  if FilterGrid.RowCount >= row then FilterGrid.RowCount:=FilterGrid.RowCount+10;
 end;
end;

procedure TLMDFilterPropsDlg.OKBtnClick(Sender: TObject);
var row:integer;
    col1,col2,st:string;
begin
 st:='';
 for row:=1 to FilterGrid.RowCount-1 do begin
  col1:=FilterGrid.Cells[0,row];
  col2:=FilterGrid.Cells[1,row];
  if (col1 <> '') and (col2 <> '') then begin
   while (col1[1] = ' ') and (length(col1) > 0) do delete(col1,1,1);
   while (col2[1] = ' ') and (length(col2) > 0)do delete(col2,1,1);
   while col1[length(col1)] = ' ' do delete(col1,length(col1),1);
   while col2[length(col2)] = ' ' do delete(col2,length(col2),1);
   st:=st+col1+'|'+col2+'|';
  end;
 end;
 delete(st,length(st),1);
 Filter:=st;
end;

end.
 
