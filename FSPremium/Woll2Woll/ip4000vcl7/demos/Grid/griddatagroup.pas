unit griddatagroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBTables, DB, Grids, Wwdbigrd, Wwdbgrid;

type
  TDataGroupForm = class(TForm)
    wwDBGrid1: TwwDBGrid;
    DataSource1: TDataSource;
    Query1: TQuery;
    Table1: TTable;
    procedure wwDBGrid1BeforeDrawCell(Sender: TwwCustomDBGrid;
      DrawCellInfo: TwwCustomDrawGridCellInfo);
    procedure wwDBGrid1TopRowChanged(Sender: TObject);
    procedure wwDBGrid1AfterDrawCell(Sender: TwwCustomDBGrid;
      DrawCellInfo: TwwCustomDrawGridCellInfo);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataGroupForm: TDataGroupForm;

implementation

{$R *.dfm}

procedure TDataGroupForm.wwDBGrid1BeforeDrawCell(Sender: TwwCustomDBGrid;
  DrawCellInfo: TwwCustomDrawGridCellInfo);
var AText: string;
begin
  with DrawCellInfo do begin
     if (Field<>nil) and (Field.FieldName = 'Company') and
        (DrawCellInfo.dataRow>=0) then
     begin
        if Sender.GetNextRecordText(Field.FieldName, AText) and
           (AText = Field.asstring) then
              DrawCellInfo.DefaultDrawHorzBottomLine:=False;

        if Sender.GetPriorRecordText(Field.FieldName, AText) and
           (AText = Field.asstring) then
        begin
           DrawCellInfo.DefaultDrawContents:=False;
           DrawCellInfo.DefaultDrawHorzTopLine:=False;
        end
     end
  end;

end;

procedure TDataGroupForm.wwDBGrid1TopRowChanged(Sender: TObject);
begin
  (sender as TwwDBGrid).invalidate;
end;

// Draw line separators to group records with the same company together
procedure TDataGroupForm.wwDBGrid1AfterDrawCell(Sender: TwwCustomDBGrid;
  DrawCellInfo: TwwCustomDrawGridCellInfo);
var AText: string;
    curField: TField;
begin
  with DrawCellInfo do begin
     curField:= (Sender as TwwDBGrid).DataSource.DataSet.FindField('Company');
     if (Field<>nil) and
        (DrawCellInfo.dataRow>=0) then
     begin
        if Sender.GetNextRecordText(curField.FieldName, AText) and
           (AText <> curField.asstring) then
        begin
           Sender.Canvas.Pen.Color:=clBlack;
           Sender.Canvas.PolyLine([
              Point(DrawCellInfo.Rect.Left, DrawCellInfo.Rect.Bottom),
              Point(DrawCellInfo.Rect.Right, DrawCellInfo.Rect.Bottom)]);
        end
     end
  end
end;

end.
