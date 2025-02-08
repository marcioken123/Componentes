unit pLMDVldRegExpEditor;
{$I LMDCmps.inc}

interface

uses
  Windows, Messages, SysUtils, Variants,
  Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, Grids
  ;

type
  TLMDRegExprForm = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    edRegExpr: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    sgExpressions: TStringGrid;
    btAddExpr: TButton;
    btRemove: TButton;
    btLoadFile: TButton;
    btSaveFile: TButton;
    btOK: TButton;
    btCancel: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label2: TLabel;
    edExprName: TEdit;
    btUpdateExpr: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btAddExprClick(Sender: TObject);
    procedure btRemoveClick(Sender: TObject);
    procedure sgExpressionsClick(Sender: TObject);
    procedure btLoadFileClick(Sender: TObject);
    procedure btSaveFileClick(Sender: TObject);
    procedure sgExpressionsDblClick(Sender: TObject);
    procedure sgExpressionsSetEditText(Sender: TObject; ACol,
      ARow: Integer; const Value: String);
    procedure btUpdateExprClick(Sender: TObject);
  private
    { Private declarations }
  protected
    FSelectedExpr: string;

    procedure LoadRegExprFile(FileName: string);
    procedure SaveRegExprFile(FileName: string);
  public
    { Public declarations }
    function EditExpression(CurExpr: string): string;
  end;

var
  LMDRegExprForm: TLMDRegExprForm;

implementation
uses
  Registry,
  LMDTypes, pLMDCst;
{$R *.dfm}

{********************* Class TLMDRegExprForm **********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDRegExprForm.FormCreate(Sender: TObject);
begin
  Self.sgExpressions.Cells[0, 0] := 'Name';
  Self.sgExpressions.Cells[1, 0] := 'Expression';
end;

{------------------------------------------------------------------------------}
procedure TLMDRegExprForm.btAddExprClick(Sender: TObject);
var
  LLastRow: integer;
begin
  Self.sgExpressions.RowCount := Self.sgExpressions.RowCount + 1;
  LLastRow := Self.sgExpressions.RowCount - 1;
  Self.sgExpressions.Cells[1, LLastRow] := Self.edRegExpr.Text;
  Self.sgExpressions.Cells[0, LLastRow] := Self.edExprName.Text;
  Self.sgExpressions.Row := LLastRow;
end;

{------------------------------------------------------------------------------}
procedure TLMDRegExprForm.btRemoveClick(Sender: TObject);
var
  i: integer;
begin
  if Self.sgExpressions.RowCount > Self.sgExpressions.FixedRows then
  begin
    for i := Self.sgExpressions.Row to Self.sgExpressions.RowCount - 2 do
    begin
      Self.sgExpressions.Cells[1, i] := Self.sgExpressions.Cells[1, i + 1];
      Self.sgExpressions.Cells[0, i] := Self.sgExpressions.Cells[0, i + 1];
    end;
    Self.sgExpressions.RowCount := Self.sgExpressions.RowCount - 1;
  end;  
end;

{------------------------------------------------------------------------------}
procedure TLMDRegExprForm.sgExpressionsClick(Sender: TObject);
begin
  if Self.sgExpressions.RowCount > Self.sgExpressions.FixedRows then
  begin
    Self.edRegExpr.Text := Self.sgExpressions.Cells[1, Self.sgExpressions.Row];
    Self.edExprName.Text := Self.sgExpressions.Cells[0, Self.sgExpressions.Row];
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRegExprForm.btLoadFileClick(Sender: TObject);
begin
  if Self.OpenDialog1.Execute then
    Self.LoadRegExprFile(Self.OpenDialog1.FileName);
end;

{------------------------------------------------------------------------------}
procedure TLMDRegExprForm.btSaveFileClick(Sender: TObject);
begin
  if Self.SaveDialog1.Execute then
    Self.SaveRegExprFile(Self.SaveDialog1.FileName);
end;

{------------------------- Protected-------------------------------------------}
procedure TLMDRegExprForm.LoadRegExprFile(FileName: string);
var
  sl: TStringList;
  i: integer;
begin
  if (FileName = '') or (not FileExists(FileName)) then
    Exit;
  sl := TStringList.Create;
  try
    begin
      sl.LoadFromFile(FileName);
      Self.sgExpressions.RowCount := sl.Count + 1;
      for i := 0 to sl.Count - 1 do
      begin
        Self.sgExpressions.Cells[0, i + 1] := sl.Names[i];
        Self.sgExpressions.Cells[1, i + 1] := sl.Values[sl.Names[i]];
          // sl.ValueFromIndex[i];
      end;
    end
  finally
    sl.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRegExprForm.SaveRegExprFile(FileName: string);
var
  sl: TStringList;
  i: integer;
begin
  if (FileName = '') then
    Exit;
  sl := TStringList.Create;
  try
    begin
      for i := 1 to Self.sgExpressions.RowCount - 1 do
      begin
        sl.Add(Self.sgExpressions.Cells[0, i]
          + '=' {sl.NameValueSeparator} + Self.sgExpressions.Cells[1, i]);
      end;
      sl.SaveToFile(FileName);
    end
  finally
    sl.Free;
  end;
end;

{------------------------- Public---------------------------------------------}

function TLMDRegExprForm.EditExpression(CurExpr: string): string;
var
  i: integer;
  found: boolean;
  ini: TRegIniFile;
  tmpfile: string;
begin
  Self.edRegExpr.Text := CurExpr;

  Ini := TRegIniFile.Create(LMDTOOLS_REGISTRYPATH);
  try
    tmpfile := ini.ReadString('Validators', 'RegExFile', '');
  finally
    ini.Free;
  end;

  if tmpfile <> '' then
    Self.LoadRegExprFile(tmpfile);

  i := 1;
  found := false;
  while (not found) and (i < Self.sgExpressions.RowCount) do
    begin
      found := Self.sgExpressions.Cells[1, i] = CurExpr;
      if not found then
        Inc(i);
    end;
  if found then
    Self.sgExpressions.Row := i;

  if Self.ShowModal = mrOK then
    begin
      Result := Self.edRegExpr.Text;
      Self.SaveRegExprFile(tmpfile);
    end
  else
    Result := CurExpr;
end;

procedure TLMDRegExprForm.sgExpressionsDblClick(Sender: TObject);
begin
  Self.edRegExpr.Text := Self.sgExpressions.Cells[1, Self.sgExpressions.Row];
  Self.ModalResult := mrOK;
end;

procedure TLMDRegExprForm.sgExpressionsSetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: String);
begin
  Self.edRegExpr.Text := Self.sgExpressions.Cells[1, Self.sgExpressions.Row];
end;

procedure TLMDRegExprForm.btUpdateExprClick(Sender: TObject);
begin
  Self.sgExpressions.Cells[1, Self.sgExpressions.Row] := Self.edRegExpr.Text;
  Self.sgExpressions.Cells[0, Self.sgExpressions.Row] := Self.edExprName.Text;
end;

end.

