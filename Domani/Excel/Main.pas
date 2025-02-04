unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Spin, StdCtrls, ExtCtrls, XLSWrite, XLSRead, ComCtrls, BIFFRecs;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    edRead: TEdit;
    edWrite: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    lblVersion: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbVersion: TComboBox;
    seSheet: TSpinEdit;
    Grid: TStringGrid;
    XLSRead: TXLSRead;
    XLSWrite: TXLSWrite;
    dlgOpen: TOpenDialog;
    dlgSave: TSaveDialog;
    Progress: TProgressBar;
    edCellValue: TEdit;
    Label1: TLabel;
    Button6: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure XLSReadSheet(Sender: TObject; Name: String; Index: Integer;
      var ReadIt: Boolean);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure XLSReadFormulaCell(Sender: TObject; Col, Row: Integer;
      Formula: String);
    procedure XLSReadNumberCell(Sender: TObject; Col, Row,
      FormatIndex: Integer; Value: Double; IsFormulaValue: Boolean);
    procedure XLSReadStringCell(Sender: TObject; Col, Row,
      FormatIndex: Integer; Value: String; IsFormulaValue: Boolean);
    procedure XLSReadBoolCell(Sender: TObject; Col, Row,
      FormatIndex: Integer; Value, IsFormulaValue: Boolean);
    procedure XLSReadBlankCell(Sender: TObject; Col, Row,
      FormatIndex: Integer);
    procedure XLSReadProgress(Sender: TObject; Value: Integer);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure GridDrawCell(Sender: TObject; Col, Row: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure cbVersionChange(Sender: TObject);
    procedure GridGetEditText(Sender: TObject; ACol, ARow: Integer;
      var Value: String);
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure Button6Click(Sender: TObject);
    procedure XLSReadRow(Sender: TObject; Row, Col1, Col2, FormatIndex,
      Height: Integer);
    procedure XLSReadDateTimeCell(Sender: TObject; Col, Row,
      FormatIndex: Integer; Value: TDateTime; IsFormulaValue: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
  C: string;
begin
  cbVersion.ItemIndex := 1;
  Grid.ColWidths[0] := 24;
  for i := 0 to Grid.ColCount - 2 do begin
    if (i div 26) > 0 then
      C := Char(Ord('A') + (i div 26) - 1)
    else
      C := '';
    Grid.Cells[i + 1,0] := C + Char(Ord('A') + (i mod 26));
  end;
  for i := 1 to Grid.RowCount - 1 do
    Grid.Cells[0,i] := IntToStr(i);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.XLSReadSheet(Sender: TObject; Name: String;
  Index: Integer; var ReadIt: Boolean);
begin
  ReadIt := Index = seSheet.Value - 1;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  dlgOpen.FileName := edRead.Text;
  if dlgOpen.Execute then
    edRead.Text := dlgOpen.FileName;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  dlgSave.FileName := edWrite.Text;
  if dlgSave.Execute then
    edWrite.Text := dlgSave.FileName;
end;

procedure TForm1.XLSReadFormulaCell(Sender: TObject; Col, Row: Integer;
  Formula: String);
begin
  if (Col < (Grid.ColCount - 1)) and (Row < (Grid.RowCount - 1)) then
    Grid.Cells[Col + 1,Row + 1] := '=' + Formula;
end;

procedure TForm1.XLSReadNumberCell(Sender: TObject; Col, Row,
  FormatIndex: Integer; Value: Double; IsFormulaValue: Boolean);
begin
  Grid.Objects[Col + 1,Row + 1] := TObject(FormatIndex);
  if (Col < (Grid.ColCount - 1)) and (Row < (Grid.RowCount - 1)) and not IsFormulaValue  then begin
    if FormatIndex >= 0 then
      Grid.Cells[Col + 1,Row + 1] := XLSRead.FormatNumber(FormatIndex,Value)
    else
      Grid.Cells[Col + 1,Row + 1] := FloatToStr(Value);
  end;
end;

procedure TForm1.XLSReadStringCell(Sender: TObject; Col, Row,
  FormatIndex: Integer; Value: String; IsFormulaValue: Boolean);
begin
  Grid.Objects[Col + 1,Row + 1] := TObject(FormatIndex);
  if (Col < (Grid.ColCount - 1)) and (Row < (Grid.RowCount - 1)) and not IsFormulaValue then
    Grid.Cells[Col + 1,Row + 1] := Value;
end;

procedure TForm1.XLSReadBoolCell(Sender: TObject; Col, Row,
  FormatIndex: Integer; Value, IsFormulaValue: Boolean);
begin
  Grid.Objects[Col + 1,Row + 1] := TObject(FormatIndex);
  if (Col < (Grid.ColCount - 1)) and (Row < (Grid.RowCount - 1)) and not IsFormulaValue then begin
    if Value then
      Grid.Cells[Col + 1,Row + 1] := XLSRead.StrTRUE
    else
      Grid.Cells[Col + 1,Row + 1] := XLSRead.StrFALSE;
  end;
end;

procedure TForm1.XLSReadBlankCell(Sender: TObject; Col, Row,
  FormatIndex: Integer);
begin
  Grid.Objects[Col + 1,Row + 1] := TObject(FormatIndex);
end;

procedure TForm1.XLSReadProgress(Sender: TObject; Value: Integer);
begin
  Progress.Position := Value;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Row,Col: integer;
  V: double;
begin
  XLSWrite.Filename := edWrite.Text;
  XLSWrite.OpenFile;
  for Row := 1 to Grid.RowCount - 1 do begin
    for Col := 1 to Grid.ColCount - 1 do begin
      if Grid.Cells[Col,Row] <> '' then begin
        if Grid.Cells[Col,Row][1] = '=' then
          XLSWrite.WriteFormula(Col - 1,Row - 1,0,0,Copy(Grid.Cells[Col,Row],2,1024))
        else begin
          try
            if Grid.Cells[Col,Row][1] in ['-','0'..'9'] then begin
              V := StrToFloat(Grid.Cells[Col,Row]);
              XLSWrite.WriteNumber(Col - 1,Row - 1,1,V);
              Continue;
            end;
          except
          end;
          if Uppercase(Grid.Cells[Col,Row]) = 'TRUE' then
            XLSWrite.WriteBool(Col - 1,Row - 1,3,True)
          else if Uppercase(Grid.Cells[Col,Row]) = 'FALSE' then
            XLSWrite.WriteBool(Col - 1,Row - 1,3,False)
          else
            XLSWrite.WriteWideString(Col - 1,Row - 1,2,Grid.Cells[Col,Row]);
        end;
      end;
    end;
  end;
  XLSWrite.CloseFile;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i,j: integer;
begin
  Progress.Position := 0;
  Progress.Visible := True;
  Screen.Cursor := crHourGlass;
  try
    for i := 1 to Grid.ColCount - 1 do begin
     Grid.ColWidths[i] := Grid.DefaultColWidth;
     for j := 1 to Grid.RowCount - 1 do begin
       Grid.Cells[i,j] := '';
       Grid.Objects[i,j] := TObject(0);
     end;
    end;
    XLSRead.FileName := edRead.Text;
    XLSRead.Read;
  finally
    Screen.Cursor := crDefault;
    Progress.Visible := False;
  end;
  case XLSRead.Version of
    ExcelUnknown: lblVersion.Caption := 'Version: ???';
    Excel21: lblVersion.Caption := 'Version: Excel 2.1';
    Excel30: lblVersion.Caption := 'Version: Excel 3.0';
    Excel40: lblVersion.Caption := 'Version: Excel 4.0';
    Excel50: lblVersion.Caption := 'Version: Excel 5.0';
    Excel95: lblVersion.Caption := 'Version: Excel 95';
    Excel97: lblVersion.Caption := 'Version: Excel 97';
  end;
end;

procedure TForm1.GridDrawCell(Sender: TObject; Col, Row: Integer; Rect: TRect; State: TGridDrawState);
var
  H,W: integer;
  i: integer;
begin
  if (Col > 0) and (Row > 0) {and not ((Col = 1) and (Row = 1))} then begin
    Dec(Rect.Left);
    Dec(Rect.Top);
    Inc(Rect.Right);
    Inc(Rect.Bottom);
    i := Integer(Grid.Objects[Col,Row]);
    if i >= 0 then begin
      Grid.Canvas.Brush.Color := XLSRead.FmtCellColor[i];
      if Grid.Canvas.Brush.Color = clBlack then
        Grid.Canvas.Brush.Color := clWhite;
      Grid.Canvas.Font.Assign(XLSRead.FmtFont[i]);
      H := Grid.Canvas.TextHeight('Åj') + 2;
      if H > Grid.RowHeights[Row] then
        Grid.RowHeights[Row] := H;
      W := Grid.Canvas.TextWidth(Grid.Cells[Col,Row]) + 4;
      if W > Grid.ColWidths[Col] then
        Grid.ColWidths[Col] := W;
    end
    else begin
      Grid.Canvas.Brush.Color := clWhite;
      Grid.Canvas.Font.Color := clBlack;
      Grid.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top + 2,Grid.Cells[Col,Row]);
      Exit;
    end;
    if XLSRead.FmtHorizAlignment[i] = chaRight then begin
      W := Grid.Canvas.TextWidth(Grid.Cells[Col,Row]);
      Grid.Canvas.TextRect(Rect,Rect.Right - W - 2,Rect.Top + 2,Grid.Cells[Col,Row]);
    end
    else if XLSRead.FmtHorizAlignment[i] = chaCenter then begin
      W := Grid.Canvas.TextWidth(Grid.Cells[Col,Row]);
      Grid.Canvas.TextRect(Rect,Rect.Left + ((Rect.Right - Rect.Left) div 2) - (W div 2),Rect.Top + 2,Grid.Cells[Col,Row]);
    end
    else
      Grid.Canvas.TextRect(Rect,Rect.Left + 2,Rect.Top + 2,Grid.Cells[Col,Row]);
    Grid.Canvas.Brush.Color := clWhite;
    Grid.Canvas.Pen.Color := clBlack;
    if XLSRead.FmtBorderStyle[i,cbLeft] <> cbsNone then begin
      Grid.Canvas.MoveTo(Rect.Left,Rect.Top);
      Grid.Canvas.LineTo(Rect.Left,Rect.Bottom - 1);
    end;
    if XLSRead.FmtBorderStyle[i,cbTop] <> cbsNone then begin
      Grid.Canvas.MoveTo(Rect.Left,Rect.Top);
      Grid.Canvas.LineTo(Rect.Right - 2,Rect.Top);
    end;
    if XLSRead.FmtBorderStyle[i,cbRight] <> cbsNone then begin
      Grid.Canvas.MoveTo(Rect.Right - 2,Rect.Top);
      Grid.Canvas.LineTo(Rect.Right - 2,Rect.Bottom - 1);
    end;
    if XLSRead.FmtBorderStyle[i,cbBottom] <> cbsNone then begin
      Grid.Canvas.MoveTo(Rect.Right - 2,Rect.Bottom - 2);
      Grid.Canvas.LineTo(Rect.Left,Rect.Bottom - 2);
    end;
  end;
end;

procedure TForm1.cbVersionChange(Sender: TObject);
begin
  case cbVersion.ItemIndex of
    0: XLSWrite.XLSVersion := xls40;
    1: XLSWrite.XLSVersion := xls50;
    2: XLSWrite.XLSVersion := xls97;
  end;
end;

procedure TForm1.GridGetEditText(Sender: TObject; ACol, ARow: Integer; var Value: String);
begin
  if Integer(Grid.Objects[ACol,ARow]) <> 0 then begin
    Grid.Canvas.Brush.Color := XLSRead.FmtCellColor[Integer(Grid.Objects[ACol,ARow])];
    Grid.Canvas.Font.Assign(XLSRead.FmtFont[Integer(Grid.Objects[ACol,ARow])]);
  end;
end;

procedure TForm1.GridSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
var
  R: TRect;
begin
  edCellValue.Text := Grid.Cells[ACol,ARow];
  Exit;
  R := Grid.CellRect(ACol,ARow);
  Dec(R.Left);
  Dec(R.Top);
  Inc(R.Right);
  Inc(R.Bottom);
  InvalidateRect(Grid.Canvas.Handle,@R,False);
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Grid.Cells[Grid.Col,Grid.Row] := edCellValue.Text;
  Grid.Repaint;
  Grid.Canvas.DrawFocusRect(Grid.CellRect(Grid.Col,Grid.Row));
end;

procedure TForm1.XLSReadRow(Sender: TObject; Row, Col1, Col2, FormatIndex, Height: Integer);
var
  i: integer;
begin
  for i := Col1 to Col2 do
    Grid.Objects[i + 1,Row + 1] := TObject(FormatIndex);
end;

procedure TForm1.XLSReadDateTimeCell(Sender: TObject; Col, Row,
  FormatIndex: Integer; Value: TDateTime; IsFormulaValue: Boolean);
begin
  Grid.Objects[Col + 1,Row + 1] := TObject(FormatIndex);
  if (Col < (Grid.ColCount - 1)) and (Row < (Grid.RowCount - 1)) and not IsFormulaValue  then begin
    if FormatIndex >= 0 then
      Grid.Cells[Col + 1,Row + 1] := XLSRead.FormatNumber(FormatIndex,Value)
    else
      Grid.Cells[Col + 1,Row + 1] := DateToStr(Value);
  end;
end;

end.
