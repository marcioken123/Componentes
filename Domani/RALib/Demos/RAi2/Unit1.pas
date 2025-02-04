unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, RARegAuto, Grids, DBGrids, Db, DBTables;

type
  TMyForm = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    ComboBox1: TComboBox;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    RegAuto1: TRegAuto;
    Label2: TLabel;
    Table1: TTable;
    DataSource1: TDataSource;
    pnlStatus: TPanel;
    CheckBox2: TCheckBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure GroupBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GroupBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure GroupBox1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ComboBox1DropDown(Sender: TObject);
    procedure Table1ActiveChanged(DataSet: TDataSet);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure MyClick(Sender: TObject);
  end;

var
  MyForm: TMyForm;

implementation

//uses fRAI2Test;

{$R *.DFM}

function MessageBox(hWnd: integer; lpText, lpCaption: PChar; uType: integer): Integer;
  external 'user32.dll' name 'MessageBoxA';

procedure TMyForm.Button1Click(Sender: TObject);
begin
  MessageBox(0, 'Hello World !', 'Information', 0);
end;

procedure TMyForm.Memo1Change(Sender: TObject);
begin
//  Label1.Caption := 'Memo changed';
  Label1.Caption := 'Line Count: ' + IntToStr(Memo1.Lines.Count);
end;

procedure TMyForm.Edit1Change(Sender: TObject);
begin
  Label1.Caption := TEdit(Sender).Text;
end;

procedure TMyForm.FormCreate(Sender: TObject);
begin
//  DBGrid1.DataSource.DataSet.Active := True;
//  Application.FindComponent('Test').FindComponent('Table1').Active := True;
end;

procedure TMyForm.GroupBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Label2.Caption := 'X = ' + IntToStr(X) + ', Y = ' + IntToStr(Y);
end;

procedure TMyForm.GroupBox1DragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Source = Label2;
end;

procedure TMyForm.GroupBox1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  Label2.Left := X;
  Label2.Top := Y;
end;

procedure TMyForm.ComboBox1DropDown(Sender: TObject);
begin
  ComboBox1.Items.Add('1');
  ComboBox1.Items.Add('2');
  ComboBox1.Items.Add('3');
  ComboBox1.Items.Add('4');
end;

procedure TMyForm.Table1ActiveChanged(DataSet: TDataSet);
begin
  if Table1.Active then
    pnlStatus.Caption := 'Open'
  else
    pnlStatus.Caption := 'Close'
end;

procedure TMyForm.CheckBox2Click(Sender: TObject);
begin
 // if TCheckBox(Sender).Checked then
  if Sender.Checked then
    Table1.Open
  else
    Table1.Close
end;

procedure TMyForm.Button2Click(Sender: TObject);
begin
  Table1.AppendRecord([1000, 'Hello']);
end;

procedure TMyForm.Button3Click(Sender: TObject);
begin
  RAI2RunFormModal(ExtractFilePath(Application.ExeName) + 'ext2');
end;

procedure TMyForm.Button4Click(Sender: TObject);
var
  B1: TButton;
begin                            
  B1 := TButton.Create(Self);
  B1.Parent := Self;
  B1.Left := 200;
  B1.Top := 120;
  B1.Caption := 'MyButton';
  B1.OnClick := MyClick;
end;

procedure TMyForm.MyClick(Sender: TObject);
begin
  MessageBox(0, 'MyButton Clicked', 'Information', 0);
end;

end.
