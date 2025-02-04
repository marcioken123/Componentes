unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RARegAuto, ComCtrls, RACt, RAEditor, RAHLEditor, Menus;

type
  TMain = class(TForm)
    RegAuto1: TRegAuto;
    RAHLEditor1: TRAHLEditor;
    StatusBar: TRAStatusBar;
    MainMenu1: TMainMenu;
    miFile: TMenuItem;
    miFileOpen: TMenuItem;
    N1: TMenuItem;
    miExit: TMenuItem;
    miFileSave: TMenuItem;
    miFileSaveAs: TMenuItem;
    raCommon: TRegAuto;
    N2: TMenuItem;
    miHelpAbout: TMenuItem;
    procedure RAHLEditor1ChangeStatus(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miFileSaveClick(Sender: TObject);
    procedure miHelpAboutClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure raCommonAfterLoad(Sender: TObject);
  private
    FFileName: TFileName;
    Exts: array[THighlighter] of string;
    procedure OpenFile(const AFileName: TFileName);
    procedure SetHighlighter;
    procedure LoadColors;
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses RAUtils;

{$R *.DFM}

const
  HighLighters: array[THighLighter] of string = (
    'None', 'Pascal', 'CBuilder', 'Sql', 'Python', 'Java', 'VB', 'Html');

procedure TMain.RAHLEditor1ChangeStatus(Sender: TObject);
const
  Modi: array[boolean] of string[10] = ('', 'Modified');
  Modes: array[boolean] of string[10] = ('Overwrite', 'Insert');
begin
  with StatusBar, RAHLEditor1 do
  begin
    Panels[0].Text := IntToStr(CaretY) + ':' + IntToStr(CaretX);
    Panels[1].Text := Modi[Modified];
    if ReadOnly then
      Panels[2].Text := 'ReadOnly'
    else if Recording then
      Panels[2].Text := 'Recording'
    else
      Panels[2].Text := Modes[InsertMode];
    miFileSave.Enabled := Modified;
  end;
end;

procedure TMain.OpenFile(const AFileName: TFileName);
begin
  RAHLEditor1.Lines.LoadFromFile(AFileName);
  RAHLEditor1ChangeStatus(nil);
  FFileName := AFileName;
  SetHighlighter;
end;

procedure TMain.miFileSaveClick(Sender: TObject);
begin
  RAHLEditor1.Lines.SaveToFile(FFileName);
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  raCommon.IniFile := ChangeFileExt(ParamStr(0), '.ini');
  Exts[hlPascal] := '*.pas;*.dpk;*.dpr;*.inc';
  Exts[hlCBuilder] := '*.cpp;*.c;*.hpp;*.h';
  Exts[hlSql] := '*.sql';
  Exts[hlPython] := '*.py';
  Exts[hlJava] := '*.java';
  Exts[hlVB] := '*.bas';
  Exts[hlHtml] := '*.htm;*.html;*.asp';
  raCommon.Load;
  if ParamCount > 0 then
    OpenFile(ParamStr(1));
end;

procedure TMain.SetHighlighter;
var
  Ext: TFileName;
  i, H: THighlighter;
begin
  Ext := ExtractFileExt(FFileName);
  H := hlNone;
  for i := Low(THighlighter) to High(THighlighter) do
    if FileEquMasks(FFileName, Exts[i]) then
    begin
      H := i;
      break;
    end;
  RAHLEditor1.HighLighter := H;
  LoadColors;
end;

procedure TMain.raCommonAfterLoad(Sender: TObject);
var
  i: THighlighter;
begin
  RAHLEditor1.RightMargin := raCommon.ReadInteger('Common', 'RightMargin',
    RAHLEditor1.RightMargin);
  for i := Low(THighlighter) to High(THighlighter) do
    Exts[i] := raCommon.ReadString('Common', HighLighters[i], Exts[i]);
end;

procedure TMain.LoadColors;
var
  Section : string;

  procedure LoadColor(AColor: TSymbolColor; const Prefix: string);
  begin
    AColor.ForeColor := StringToColor(raCommon.ReadString(Section,
      Prefix, ColorToString(AColor.ForeColor)));
    AColor.Style := TFontStyles(byte(raCommon.
      ReadInteger(Section, Prefix + '_Style', byte(AColor.Style))));
    AColor.BackColor := RAHLEditor1.Color;
  end;

begin
  Section := HighLighters[RAHLEditor1.HighLighter];
  RAHLEditor1.Color := StringToColor(raCommon.ReadString(Section, 'BackColor',
    ColorToString(RAHLEditor1.Color)));
  RAHLEditor1.Font.Name := raCommon.ReadString(Section, 'FontName',
    RAHLEditor1.Font.Name);
  RAHLEditor1.Font.Size := raCommon.ReadInteger(Section, 'FontSize',
    RAHLEditor1.Font.Size);
  LoadColor(RAHLEditor1.Colors.Number, 'Number');
  LoadColor(RAHLEditor1.Colors.Strings, 'Strings');
  LoadColor(RAHLEditor1.Colors.Symbol, 'Symbol');
  LoadColor(RAHLEditor1.Colors.Comment, 'Comment');
  LoadColor(RAHLEditor1.Colors.Reserved, 'Reserved');
  LoadColor(RAHLEditor1.Colors.Identifer, 'Identifer');
  LoadColor(RAHLEditor1.Colors.Preproc, 'Preproc');
  LoadColor(RAHLEditor1.Colors.FunctionCall, 'FunctionCall');
  LoadColor(RAHLEditor1.Colors.Declaration, 'Declaration');
  LoadColor(RAHLEditor1.Colors.Statement, 'Statement');
  LoadColor(RAHLEditor1.Colors.PlainText, 'PlainText');
end;

procedure TMain.miHelpAboutClick(Sender: TObject);
begin
  MessageBox('R&A Notepad 1.0'#13'Freeware'#13#13'blacknbs@chat.ru'#13'www.chat.ru/~blacknbs',
    'About', MB_ICONINFORMATION);
end;

procedure TMain.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if RAHLEditor1.Modified then
    case MessageDlg('Save changes ?', mtConfirmation,
       [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        miFileSave.Click;
      mrCancel:
        Abort;
    end;
  CanClose := True;
end;

end.
