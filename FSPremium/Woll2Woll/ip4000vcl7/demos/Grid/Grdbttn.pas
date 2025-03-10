unit Grdbttn;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Grids, Wwdbigrd, Wwdbgrid, DB, DBTables, Wwtable,
  Wwdatsrc, StdCtrls, Wwkeycb, Buttons, wwrcdvw,
  ComCtrls, wwriched, wwDialog, ImgList;

type
  TBtnGridForm = class(TForm)
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;
    wwDBGrid1: TwwDBGrid;
    wwDBGrid1IButton: TwwIButton;
    wwRecordViewDialog1: TwwRecordViewDialog;
    wwDBRichEdit1: TwwDBRichEdit;
    ImageList1: TImageList;
    procedure wwDBGrid1TitleButtonClick(Sender: TObject;
      AFieldName: string);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure wwDBGrid1CalcTitleImage(Sender: TObject; Field: TField;
      var TitleImageAttributes: TwwTitleImageAttributes);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BtnGridForm: TBtnGridForm;

implementation

{$R *.DFM}

uses wwstr;

procedure TBtnGridForm.wwDBGrid1TitleButtonClick(Sender: TObject;
  AFieldName: string);
begin
   wwtable1.IndexFieldName:= AFieldName;
end;

procedure TBtnGridForm.wwDBGrid1IButtonClick(Sender: TObject);
begin
  wwRecordViewDialog1.execute;
end;

procedure TBtnGridForm.wwDBGrid1CalcTitleImage(Sender: TObject;
  Field: TField; var TitleImageAttributes: TwwTitleImageAttributes);
begin
    if Field=(Field.Dataset as TTable).indexFields[0] then
      TitleImageAttributes.imageIndex:= 4
    else
      TitleImageAttributes.imageIndex:= -1
end;

end.
