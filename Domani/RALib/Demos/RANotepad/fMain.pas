unit fMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  RARegAuto, ComCtrls, RAEditor, RAHLEditor, Menus,
  ShellApi, RAI2, RACt;

const
  WM_CHECKFILEMODIFIED = WM_USER + $101;

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
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    FindDialog1: TFindDialog;
    ReplaceDialog1: TReplaceDialog;
    miSearch: TMenuItem;
    Search1: TMenuItem;
    miSearchAgain: TMenuItem;
    miSearchReplace: TMenuItem;
    N3: TMenuItem;
    miOptions: TMenuItem;
    PopupMenu1: TPopupMenu;
    miEditorProperties: TMenuItem;
    RAI2Program1: TRAI2Program;
    procedure RAHLEditor1ChangeStatus(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure miFileSaveClick(Sender: TObject);
    procedure miHelpAboutClick(Sender: TObject);
    procedure miExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure raCommonAfterLoad(Sender: TObject);
    procedure miFileOpenClick(Sender: TObject);
    procedure miFileSaveAsClick(Sender: TObject);
    procedure Search1Click(Sender: TObject);
    procedure miSearchAgainClick(Sender: TObject);
    procedure miSearchReplaceClick(Sender: TObject);
    procedure miOptionsClick(Sender: TObject);
    procedure miEditorPropertiesClick(Sender: TObject);
    procedure raCommonAfterSave(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RAI2Program1GetValue(Sender: TObject; Identifer: String;
      var Value: Variant; Args: TArgs; var Done: Boolean);
    procedure RAHLEditor1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RAHLEditor1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RAHLEditor1KeyPress(Sender: TObject; var Key: Char);
    procedure RAI2Program1GetUnitSource(UnitName: String;
      var Source: String; var Done: Boolean);
    procedure FindDialog1Find(Sender: TObject);
  private
    FFileName: TFileName;
    FileTime: Integer;
    Exts: array[THighlighter] of string;
    Capt: string;
    BaseLine: Integer;
    procedure OpenFile(AFileName: TFileName);
    procedure SetHighlighter;
    procedure LoadColors;
    procedure UpdateCaption;
    procedure CheckSave;
    procedure UpdateEditorSettings;
    procedure WMDropFiles(var Message: TMessage); message WM_DROPFILES;
    procedure FindNext;
    procedure CheckFileModified;
    procedure ApplicationActivate(Sender: TObject);
    procedure WMCheckFileModified(var Message: TMessage); message WM_CHECKFILEMODIFIED;
  private { RAI2 support }
    RAI2FileName: TFileName;
    Args: TArgs;
    procedure ErrorLogFmt(const Message: string; const Args: array of const);
    function RAI2Script: boolean;
    procedure RAI2Initialize;
    procedure RAI2UnInitialize;
    function RAI2SafeCall(const FunName: string; Args: TArgs;
      Params: array of Variant): Variant;
    procedure RAI2FileOpened;
    procedure RAI2FileClosed;
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses RAUtils, iMTracer, fParams,
  RAI2_System, RAI2_Windows, RAI2_SysUtils,
  RAI2_Graphics, RAI2_Classes, RAI2_Controls,
  RAI2_StdCtrls, RAI2_ComCtrls, RAI2_ExtCtrls, RAI2_Forms,
  RAI2_Menus, RAI2_Dialogs,
  RAI2Fm,
  RAI2_RAEditor, RAI2_RARegAuto
  ;

{$R *.DFM}

const
  PadExt = '.pad'; { extension for macro-files }

{
procedure FailProc;
var
  Func: procedure; far;
begin
end;
}

procedure TMain.RAHLEditor1ChangeStatus(Sender: TObject);
const
  Modi: array[boolean] of string[10] = ('', 'Modified');
  Modes: array[boolean] of string[10] = ('Overwrite', 'Insert');
begin
  with StatusBar, RAHLEditor1 do
  begin
    Panels[0].Text := IntToStr(CaretY + 1 - BaseLine) + ':' + IntToStr(CaretX + 1);
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

procedure TMain.OpenFile(AFileName: TFileName);
begin
 {$IFDEF RA_D3H}
  AFileName := TargetFileName(AFileName);
 {$ENDIF RA_D3H}
  RAHLEditor1.BeginUpdate;
  try
    RAHLEditor1.Lines.LoadFromFile(AFileName);
    FileTime := FileAge(AFileName);
    RAHLEditor1.SetLeftTop(0, 0);
    RAHLEditor1.Modified := False;
    RAHLEditor1ChangeStatus(nil);
    FFileName := AFileName;
    SetHighlighter;
    UpdateCaption;
    Application.BringToFront;
    RAI2FileOpened;
  finally
    RAHLEditor1.EndUpdate;
  end;
end;

procedure TMain.CheckFileModified;
begin
  if FFileName = '' then Exit;
  if FileExists(FFileName) then
  begin
    if FileTime <> FileAge(FFileName) then
    begin
      if RAHLEditor1.Modified then
        if MessageDlg('File time/date changed.'#13 +
           'Reload ?'#13#13 +
           'WARNING: Document has been modified.',
           mtWarning, [mbYes, mbNo], 0) = idYes then
          OpenFile(FFileName) else
      else
        if MessageDlg('File time/date changed.'#13 +
           'Reload ?', mtInformation, [mbYes, mbNo], 0) = idYes then
          OpenFile(FFileName);
    end;
  end
  else
    { ��������, ��� ��� ���� ���� �� ����-������ ��������� }
    MessageDlg('File removed from disk.'#13 +
      'Choose File|SaveAs menu item to save file.',
       mtWarning, [mbOK], 0);
end;

procedure TMain.ApplicationActivate(Sender: TObject);
begin
  PostMessage(Handle, WM_CHECKFILEMODIFIED, 0, 0);
end;

procedure TMain.WMCheckFileModified(var Message: TMessage);
begin
  CheckFileModified;
end;

procedure TMain.miFileSaveClick(Sender: TObject);
begin
  RAHLEditor1.Lines.SaveToFile(FFileName);
  FileTime := FileAge(FFileName);
  RAHLEditor1.Modified := False;
  RAHLEditor1ChangeStatus(nil);
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  Application.OnActivate := ApplicationActivate;
  Capt := Caption;
  raCommon.IniFile := ExePath + 'ranotepad.ini';
  Exts[hlPascal] := '*.pas;*.dpk;*.dpr;*.inc;*.pad';
  Exts[hlCBuilder] := '*.cpp;*.c;*.hpp;*.h';
  Exts[hlSql] := '*.sql';
  Exts[hlPython] := '*.py';
  Exts[hlJava] := '*.java';
  Exts[hlVB] := '*.bas';
  Exts[hlHtml] := '*.htm;*.html;*.asp';
  DragAcceptFiles(Handle, True);
  raCommon.Load;
  RAI2Initialize;

  if ParamCount > 0 then
    OpenFile(GetParameter);
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  RAI2UnInitialize;
  raCommon.Save;
end;

procedure TMain.UpdateEditorSettings;
begin
  RAHLEditor1.DoubleClickLine := Params.DoubleClickLine;
  RAHLEditor1.KeepTrailingBlanks := Params.KeepTrailingBlanks;
  RAHLEditor1.AutoIndent := Params.AutoIndent;
  RAHLEditor1.SmartTab := Params.SmartTab;
  RAHLEditor1.BackspaceUnindents := Params.BackspaceUnindents;
  RAHLEditor1.CursorBeyondEOF := Params.CursorBeyondEOF;
  RAHLEditor1.TabStops := Params.TabStops;
  SetHighlighter;
end;    { UpdateEditorSettings }

procedure TMain.SetHighlighter;
var
  Ext: TFileName;
  i, H: THighlighter;
begin
  Ext := ExtractFileExt(FFileName);
  H := hlNone;
  if Params.SytaxHighlighting then
    for i := Low(THighlighter) to High(THighlighter) do
      if FileEquMasks(FFileName, Exts[i]) then
      begin
        H := i;
        break;
      end;
  RAHLEditor1.HighLighter := H;
  LoadColors;
end;

procedure TMain.raCommonAfterSave(Sender: TObject);
begin
  Params.Save(raCommon);
end;

procedure TMain.raCommonAfterLoad(Sender: TObject);
var
  i: THighlighter;
begin
  for i := Low(THighlighter) to High(THighlighter) do
    Exts[i] := Trim(raCommon.ReadString('Highlighters', HighLighters[i], Exts[i]));
  Params.Restore(raCommon);
  UpdateEditorSettings;
end;

procedure TMain.LoadColors;
begin
  Params.LoadColors(raCommon, HighLighters[RAHLEditor1.HighLighter], RAHLEditor1);
end;

procedure TMain.miHelpAboutClick(Sender: TObject);
begin
  MessageBox('R&A Notepad 1.1 Freeware'#13#13 +
    'Based on Delphi component TRAHLEditor.'#13 +
    'Available (free) at R&A Library home page:'#13 +
    '   www.chat.ru/~blacknbs'#13#13 +
    'programing - black(nbs):'#13 +
    '   blacknbs@chat.ru'#13 +
    '   www.chat.ru/~blacknbs'#13#13,
    'About', MB_ICONINFORMATION);
end;

procedure TMain.miExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CheckSave;
  CanClose := True;
end;

procedure TMain.CheckSave;
begin
  if RAHLEditor1.Modified then
    case MessageDlg('Save changes ?', mtConfirmation,
       [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        miFileSave.Click;
      mrCancel:
        Abort;
    end;
  RAI2FileClosed;
end;

procedure TMain.miFileOpenClick(Sender: TObject);
begin
  CheckSave;
  if OpenDialog1.Execute then
  begin
    OpenFile(OpenDialog1.FileName);
  end;
end;

procedure TMain.miFileSaveAsClick(Sender: TObject);
begin
  if FFileName <> '' then
    SaveDialog1.FileName := FFileName
  else
    SaveDialog1.FileName := ExtractFilePath(OpenDialog1.FileName) + 'NONAME.TXT';
  if SaveDialog1.Execute then
  begin
    RAHLEditor1.Lines.SaveToFile(SaveDialog1.FileName);
    FFileName := SaveDialog1.FileName;
    FileTime := FileAge(FFileName);
  end
  else
    Abort;
  OpenDialog1.FileName := SaveDialog1.FileName;
  UpdateCaption;
end;

procedure TMain.UpdateCaption;
begin
  if FFileName <> '' then
  begin
    Caption := Capt + ' - ' + FFileName;
    Application.Title := FFileName + ' - ' + Capt;
  end
  else
  begin
    Caption := Capt + ' - new file' ;
    Application.Title := 'new file - ' + Capt;
  end;
end;

procedure TMain.WMDropFiles(var Message: TMessage);
var
  FN: string;
begin
  SetLength(FN, 260);
  SetLength(FN, DragQueryFile(Message.WParam, 0, PChar(FN), 260));
  CheckSave;
  OpenFile(FN);
end;

procedure TMain.Search1Click(Sender: TObject);
begin
  FindDialog1.Execute;
end;

procedure TMain.miSearchAgainClick(Sender: TObject);
begin
  FindNext;
end;

procedure TMain.FindDialog1Find(Sender: TObject);
begin
  FindNext;
end;

procedure TMain.FindNext;
var
  S, S1: string;
  F: PChar;
begin
  S := RAHLEditor1.Lines.Text;
  S1 := FindDialog1.FindText;
  if not (frMatchCase in FindDialog1.Options) then
  begin
    S := ANSIUpperCase(S);
    S1 := ANSIUpperCase(S1);
  end;
  F := StrPos(PChar(S) + RAHLEditor1.SelStart, PChar(S1));
  if F <> nil then
  begin
    RAHLEditor1.SelStart := F - PChar(S);
    RAHLEditor1.SelLength := Length(S1);
  end;
end;

procedure TMain.miSearchReplaceClick(Sender: TObject);
begin
//  SAR1.ReplaceDialog;
end;

procedure TMain.miOptionsClick(Sender: TObject);
begin
  if fParams.Show(raCommon, RAHLEditor1.HighLighter, False) then
  begin
    UpdateEditorSettings;
    RAHLEditor1.Invalidate;
  end;
end;

procedure TMain.miEditorPropertiesClick(Sender: TObject);
begin
  if fParams.Show(raCommon, RAHLEditor1.HighLighter, True) then
  begin
    UpdateEditorSettings;
    RAHLEditor1.Invalidate;
  end;
end;



{*********************** RAI2 support ***********************}
type
  { small hack }
  TMyProgram = class(TRAI2Program);

procedure TMain.ErrorLogFmt(const Message: string; const Args: array of const);
var
  S: string;
begin
  S := Format(Message, Args);
  { save S to log file }
  //.. not implemented
  ShowMessage(S);
end;    { ErrorLogFmt }

procedure TMain.RAI2Initialize;
begin
  Args := TArgs.Create;
 { from RAI2_all.pas }
  RAI2_System.RegisterRAI2Adapter(GlobalRAI2Adapter);
  RAI2_Windows.RegisterRAI2Adapter(GlobalRAI2Adapter);
  RAI2_SysUtils.RegisterRAI2Adapter(GlobalRAI2Adapter);
  RAI2_Classes.RegisterRAI2Adapter(GlobalRAI2Adapter);
  RAI2_Graphics.RegisterRAI2Adapter(GlobalRAI2Adapter);
  RAI2_Controls.RegisterRAI2Adapter(GlobalRAI2Adapter);

  RAI2_StdCtrls.RegisterRAI2Adapter(GlobalRAI2Adapter);
  RAI2_ComCtrls.RegisterRAI2Adapter(GlobalRAI2Adapter);
  RAI2_Extctrls.RegisterRAI2Adapter(GlobalRAI2Adapter);
  RAI2_Forms.RegisterRAI2Adapter(GlobalRAI2Adapter);
  RAI2_Dialogs.RegisterRAI2Adapter(GlobalRAI2Adapter);
  RAI2_Menus .RegisterRAI2Adapter(GlobalRAI2Adapter);

  RAI2Fm.RegisterRAI2Adapter(GlobalRAI2Adapter);

  RAI2_RAEditor.RegisterRAI2Adapter(GlobalRAI2Adapter);
  RAI2_RARegAuto.RegisterRAI2Adapter(GlobalRAI2Adapter);

  RAI2FileName := raCommon.ReadString('Params', 'RAI2File', '');
  if RAI2FileName = '' then Exit;
  RAI2FileName := AddPath(RAI2FileName, ExePath);
  if not FileExists(RAI2FileName) then
  begin
    ErrorLogFmt('File %s not found', [RAI2FileName]);
    Exit;
  end;
  try
    RAI2Program1.Pas.LoadFromFile(RAI2FileName);
  except
    ErrorLogFmt('Failed to load file %s', [RAI2FileName]);
    Exit;
  end;
  RAI2Program1.Compile;
  RAI2SafeCall('main', nil, [Null]);
end;    { RegisterRAI2Adapters }

procedure TMain.RAI2UnInitialize;
begin
  RAI2SafeCall('done', nil, [Null]);
  Args.Free;
end;

function TMain.RAI2Script: boolean;
begin
  Result := RAI2Program1.Source <> '';
end;    {  }

function TMain.RAI2SafeCall(const FunName: string; Args: TArgs;
  Params: array of Variant): Variant;
begin
  Result := Null;
  if RAI2Script and RAI2Program1.FunctionExist(FunName) then
    try
      Result := RAI2Program1.CallFunction(FunName, Args, Params);
    except
      on E: ERAI2Error do
        ErrorLogFmt('Call to function %s failed: %s', [FunName, E.Message]);
    end
end;    { RAI2SafeCall }

procedure TMain.RAI2FileOpened;
begin
  RAI2SafeCall('FileOpened', nil, [FFileName]);
end;    { RAI2Open }

procedure TMain.RAI2FileClosed;
begin
  RAI2SafeCall('FileClosed', nil, [FFileName]);
end;    { RAI2FileClosed }

procedure TMain.RAI2Program1GetValue(Sender: TObject; Identifer: String;
  var Value: Variant; Args: TArgs; var Done: Boolean);
var
  S: string;
begin
  if Cmp(Identifer, 'MainWindow') then
  begin
    Value := O2V(Self);
    Done := True;
  end
  else if Cmp(Identifer, 'Editor') then
  begin
    Value := O2V(RAHLEditor1);
    Done := True;
  end
  else if Cmp(Identifer, 'ODS') then
  begin
    ODS(Args.Values[0]);
    Value := Null;
    Done := True;
  end
  else if Cmp(Identifer, 'Call') then
  begin
    S := Args.Values[0];
    Args.Delete(0);
    Value := RAI2Program1.CallFunction(S, Args, [Null]);
    Done := True;
  end
  else if Cmp(Identifer, 'UseUnit') then
  begin
    TMyProgram(RAI2Program1).ReadUnit(Args.Values[0]);
    Value := Null;
    Done := True;
  end
  else if Args.Obj = RAHLEditor1 then
  begin
    if Cmp(Identifer, 'FileName') then
    begin
      Value := FFileName;
      Done := True;
    end
    else if Cmp(Identifer, 'FileOpen') then
    begin
      OpenFile(Args.Values[0]);
      Value := Null;
      Done := True;
    end
    else if Cmp(Identifer, 'FileSave') then
    begin
      miFileSave.Click;
      Value := Null;
      Done := True;
    end
    else if Cmp(Identifer, 'CheckSave') then
    begin
      CheckSave;
      Value := Null;
      Done := True;
    end
    else if Cmp(Identifer, 'HighlighterName') then
    begin
      Value := Highlighters[RAHLEditor1.Highlighter];
      Done := True;
    end
    else if Cmp(Identifer, 'LoadColors') then
    begin
      LoadColors;
      Done := True;
    end
  end;
end;

procedure TMain.RAI2Program1GetUnitSource(UnitName: String;
  var Source: String; var Done: Boolean);
begin
  try
    Source := LoadTextFile(AddPath(UnitName + PadExt, ExtractFilePath(RAI2FileName)));
    Done := True;
  except
  end;
end;

procedure TMain.RAHLEditor1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Args.Clear;
  Args.Values[0] := Key;
  Args.Values[1] := S2V(Byte(Shift));
  Args.Types[0] := varInteger or varByRef;
  Args.Count := 2;
  RAI2SafeCall('KeyDown', Args, [Null]);
  Key := Args.Values[0];
  if Key = VK_F4 then
  begin
    BaseLine := RAHLEditor1.CaretY;
    RAHLEditor1ChangeStatus(nil);
  end;
end;

procedure TMain.RAHLEditor1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Args.Clear;
  Args.Values[0] := Key;
  Args.Values[1] := S2V(Byte(Shift));
  Args.Types[0] := varInteger or varByRef;
  Args.Count := 2;
  RAI2SafeCall('KeyUp', Args, [Null]);
  Key := Args.Values[0];
end;

procedure TMain.RAHLEditor1KeyPress(Sender: TObject; var Key: Char);
begin
  Args.Clear;
  Args.Values[0] := Key;
  Args.Types[0] := varInteger or varByRef;
  Args.Count := 1;
  RAI2SafeCall('KeyPress', Args, [Null]);
  if string(Args.Values[0]) <> '' then
    Key := string(Args.Values[0])[1] else
    Key := #0;
end;


end.
