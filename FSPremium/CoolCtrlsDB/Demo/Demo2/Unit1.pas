{$DEFINE DEBUG}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, DBTables, Grids, DBGrids, ComCtrls, CoolComparer,
  Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Table1: TTable;
    PageControl: TPageControl;
    TabSettings: TTabSheet;
    LabelFields: TLabel;
    LabelPriorities: TLabel;
    LabelSearchSettings: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    ListBoxFields: TListBox;
    ComboBoxPriorities: TComboBox;
    ListViewFields: TListView;
    OpenDialog1: TOpenDialog;
    Comparer: TCoolComparer;
    StaticTextMainLabel: TStaticText;
    StaticTextSubLabel: TStaticText;
    StatusBar1: TStatusBar;
    ButtonOpen: TButton;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    ButtonSearch: TButton;
    TabSearch: TTabSheet;
    LabelFieldsValues: TLabel;
    StringGridSearch: TStringGrid;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure ButtonOpenClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure ButtonSearchClick(Sender: TObject);
    procedure ComparerProgress(Sender: TObject; Total, Current: Integer);
    procedure ButtonSearchEnter(Sender: TObject);
  private
    procedure OpenTable(FileName: string);
    procedure DoPageSettings;
    procedure DoPageSearch;
    function GetPriority(FieldName: string): TPriority;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.OpenTable(FileName: string);
var
  I: Integer;
begin
  Table1.Active := False;
  Table1.DatabaseName := ExtractFilePath(FileName);
  Table1.TableName := ExtractFileName(FileName);
  Table1.Active := True;

  ListBoxFields.Items.Clear;
  for I := 0 to Pred(Table1.FieldDefs.Count) do
    ListBoxFields.Items.Add(Table1.FieldDefs[I].Name);

  if ListBoxFields.Items.Count <> 0 then
    ListBoxFields.ItemIndex := 0;

  PageControl.ActivePageIndex := 0;
{$IFDEF VER140}
  ListViewFields.Clear;
{$ELSE}
  ListViewFields.Items.Clear;
{$ENDIF}

  for I := 1 to Pred(StringGridSearch.RowCount) do
  begin
    StringGridSearch.Cells[0, I] := '';
    StringGridSearch.Cells[1, I] := '';
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
resourcestring
  SDataFolderName = 'Data\';
  SDataTableName  = 'employee.DB';
const
  StrPriorities: array[TPriority] of string =
   (
     'HIGHEST',
     'HIGHER',
     'HIGH',
     'LOW',
     'LOWER',
     'LOWEST',
     'NONE'
   );
var
  I: TPriority;
begin
  OpenTable(ExtractFilePath(ParamStr(0)) + SDataFolderName + SDataTableName);

  for I := Low(TPriority) to High(TPriority) do
{$IFDEF VER140}
    ComboBoxPriorities.AddItem(StrPriorities[I], Pointer(I));
{$ELSE}
    ComboBoxPriorities.Items.AddObject(StrPriorities[I], Pointer(I));
{$ENDIF}

  ComboBoxPriorities.ItemIndex := 0;

  PageControl.ActivePageIndex := 0;
  StringGridSearch.Cells[0, 0] := 'Field';
  StringGridSearch.Cells[1, 0] := 'Text';

  DoPageSettings;
end;

procedure TForm1.ButtonOpenClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    OpenTable(OpenDialog1.FileName);
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  I: Integer;
  Item: TListItem;
  Total: Integer;
begin
  Assert(ListBoxFields.ItemIndex <> -1, 'Field should be selected in the listbox');
  Assert(ComboBoxPriorities.ItemIndex <> -1, 'Priority should be selected in the combobox');

  Item := ListViewFields.Items.Add;
  Item.Caption := ListBoxFields.Items[ListBoxFields.ItemIndex];
  Item.SubItems.AddObject(ComboBoxPriorities.Items[ComboBoxPriorities.ItemIndex], ComboBoxPriorities.Items.Objects[ComboBoxPriorities.ItemIndex]);

  Total := 0;
  for I := 0 to Pred(ListViewFields.Items.Count) do
  begin
    Item := ListViewFields.Items[I];
    Total := Total + PriorityToPoints(TPriority(Item.SubItems.Objects[0]));
  end;
  Label6.Caption := IntToStr(Total);
  UpDown1.Position := Total;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if ListViewFields.Selected <> nil then
{$IFDEF VER140}
    ListViewFields.DeleteSelected;
{$ELSE}
    ListViewFields.Items.Delete(ListViewFields.Selected.Index);
{$ENDIF}
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
{$IFDEF VER140}
  ListViewFields.Clear;
{$ELSE}
  ListViewFields.Items.Clear;
{$ENDIF}
end;

procedure TForm1.PageControlChange(Sender: TObject);
begin
  case PageControl.ActivePageIndex of
    0: DoPageSettings;
    1: DoPageSearch;
  end;
end;

procedure TForm1.DoPageSettings;
begin
  StaticTextMainLabel.Caption := 'Settings';
  StaticTextSubLabel.Caption := 'Just one of the possible areas TCoolComparer can be used at - inteligent search. You do not need to browse' + #13 +
                                'for exact words. Search for something that "sounds like". Select field you like to look for then specify what' + #13 +
                                'priority the field has and add it to the "Search settings" list. Repeat the process if needed, the more the better.';
end;

procedure TForm1.DoPageSearch;
var
  I: Integer;
begin
  StaticTextMainLabel.Caption := 'Search';
  StaticTextSubLabel.Caption := 'Now specify what value the field you are looking for must have. No need to specify exactl value' + #13 +
                                'Doug for Douglas and Anie for Ann will work. When ready hit the "Search!" button. Powerful importing' + #13 +
                                'and testing system can be built using the TCoolComparer''s capabilities as well.';

  StringGridSearch.RowCount := ListViewFields.Items.Count + 1;
  for I := 0 to Pred(ListViewFields.Items.Count) do
    StringGridSearch.Cells[0, Succ(I)] := ListViewFields.Items[I].Caption;

  if ListViewFields.Items.Count = 0 then
  begin
    StringGridSearch.RowCount := StringGridSearch.RowCount + 1;
    StringGridSearch.FixedRows := 1;
    StringGridSearch.Enabled := False;
  end else
  begin
    StringGridSearch.FixedRows := 1;
    StringGridSearch.Enabled := True;
  end;
end;

procedure TForm1.ButtonSearchClick(Sender: TObject);
var
  RecPoints, RecIndex, I: Integer;
begin
  Comparer.FieldList.Clear;
  for I := 1 to Pred(StringGridSearch.RowCount) do
  begin
    Comparer.FieldList.Add(StringGridSearch.Cells[0, I]);

    Comparer.FieldValue[StringGridSearch.Cells[0, I]] := StringGridSearch.Cells[1, I];
    Comparer.FieldPriority[StringGridSearch.Cells[0, I]] := GetPriority(StringGridSearch.Cells[0, I]); 
  end;

  Comparer.PointsEnough := UpDown1.Position;

  if Comparer.Compare(Table1, RecPoints, RecIndex) then
  begin
    ProgressBar1.Position := 0;

    if RecIndex <> -1 then
    begin
      Table1.RecNo := RecIndex;
      StatusBar1.SimpleText := 'Record earned: ' + IntToStr(RecPoints) + ' points.';
    end else
    begin
      StatusBar1.SimpleText := 'No matches found.';
    end;
  end;
end;

procedure TForm1.ComparerProgress(Sender: TObject; Total,
  Current: Integer);
begin
  ProgressBar1.Min := 0;
  ProgressBar1.Max := Total;
  ProgressBar1.Position := Current;
end;

function TForm1.GetPriority(FieldName: string): TPriority;
var
  I: Integer;
begin
  Result := ptyNone;
  for I := 0 to Pred(ListViewFields.Items.Count) do
  begin
    if ListViewFields.Items[I].Caption = FieldName then
    begin
      Result := TPriority(ListViewFields.Items[I].SubItems.Objects[0]);
      Break;
    end;
  end;
end;

procedure TForm1.ButtonSearchEnter(Sender: TObject);
begin
  ButtonSearch.Enabled := ListViewFields.Items.Count <> 0;
end;

end.
