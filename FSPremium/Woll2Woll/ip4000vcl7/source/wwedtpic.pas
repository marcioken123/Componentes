unit wwedtpic;
{
//
// Property Dialog : Select Picture Mask Design Time Dialog
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, Buttons, wwpicdb;

type
  TwwPictureDialog = class(TForm)
    StringGrid1: TStringGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1DblClick(Sender: TObject);
  private
    procedure DeleteCurrentRow;
    { Private declarations }
  public
     MaskChanged: boolean;
    { Public declarations }
  end;

var
  wwPictureDialog: TwwPictureDialog;

implementation

{$R *.DFM}

procedure TwwPictureDialog.FormShow(Sender: TObject);
begin
  stringgrid1.cells[0,0]:= 'Description';
  stringgrid1.cells[1,0]:= 'Mask';
  stringgrid1.fixedrows:= 1;
  with stringgrid1 do
     if toprow + visiblerowcount <= row then
        toprow:= row - visiblerowcount+1;
end;

function max(x,y: integer): integer;
begin
   if x>y then result:= x else result:= y;
end;

procedure TwwPictureDialog.DeleteCurrentRow;
var i, tempRowCount: integer;
begin
   with StringGrid1 do begin
      for i:= row to rowCount-1 do begin
         cells[1, i]:= cells[1,i+1];
         cells[0, i]:= cells[0,i+1];
      end;
      tempRowCount:= max(rowCount - 1, 2);
      if row>=tempRowCount then row:= tempRowCount-1;
      RowCount:= tempRowCount;
   end
end;

procedure TwwPictureDialog.BitBtn1Click(Sender: TObject);
begin
   Screen.cursor:= crHourGlass;
   with TwwEditMaskForm.create(Application) do begin
      Description.Text:= stringgrid1.cells[0, stringgrid1.row];
      MaskEdit.Text:= stringgrid1.cells[1, stringgrid1.row];

      Screen.cursor:= crDefault;
      if ShowModal = mrOK then
      begin
        MaskChanged:= True;
        stringgrid1.cells[0, stringgrid1.row]:= Description.text;
        stringgrid1.cells[1, stringgrid1.row]:= MaskEdit.Text;
      end;
//      wwDataSource1.dataset:= Nil;
      Free;
   end
end;

procedure TwwPictureDialog.BitBtn2Click(Sender: TObject);
begin
   if MessageDlg('Are you sure you wish to delete this picture mask?',
            mtInformation, [mbYes, mbNo], 0) = mrYes then
   begin
      DeleteCurrentRow;
      MaskChanged:= True;
     end

end;

procedure TwwPictureDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key=VK_RETURN then begin
      OkBtn.setFocus;
      ModalResult:= mrOK;
   end
end;

procedure TwwPictureDialog.StringGrid1DblClick(Sender: TObject);
begin
    ModalResult := mrOK;
end;

end.
