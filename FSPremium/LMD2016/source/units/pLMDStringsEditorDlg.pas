unit pLMDStringsEditorDlg;
{$I lmdcmps.Inc}

interface

uses
  RTLConsts, Windows, ComCtrls,  Messages, SysUtils,
  Classes, Graphics, Controls, Forms, Dialogs,StdCtrls, Printers,
  LMDClass, LMDCont, LMDBaseGraphicControl, LMDBaseLabel, LMDCustomGlyphLabel,
  LMDCustomStatusBar, LMDCustomButton, 
  LMDBaseGraphicButton, LMDCustomSpeedButton, LMDCustomPanel,
  LMDCustomBevelPanel, LMDInformationLabel, LMDStatusBar,
  pLMDCPGetCore, LMDWndProcComponent, LMDSimplePanel,
  LMDSpeedButton, LMDGlyphLabel, LMDButton, LMDCustomComponent,
  LMDCustomControl, LMDImagelist, LMDBaseController,
  LMDCustomContainer, LMDCustomImageList, ImgList, LMDBaseControl,
  LMDControl;

type
  TLMDFrmStringEditor = class(TForm)
    StatusBar: TLMDStatusBar;
    PosInfo: TLMDGlyphLabel;
    LMDInformationLabel1: TLMDInformationLabel;
    LMDInformationLabel2: TLMDInformationLabel;
    StrList: TMemo;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    FindDialog: TFindDialog;
    ReplaceDialog: TReplaceDialog;
    PrintDialog: TPrintDialog;
    LMDImageList2: TLMDImageList;
    main: TLMDSimplePanel;
    LMDButton1: TButton;
    btnCancel: TButton;
    LMDButton2: TButton;
    tools: TLMDSimplePanel;
    OpenBtn: TLMDSpeedButton;
    SaveBtn: TLMDSpeedButton;
    CopyBtn: TLMDSpeedButton;
    PasteBtn: TLMDSpeedButton;
    CutBtn: TLMDSpeedButton;
    SelectBtn: TLMDSpeedButton;
    PrintBtn: TLMDSpeedButton;
    SearchBtn: TLMDSpeedButton;
    ReplaceBtn: TLMDSpeedButton;

    procedure SelectBtnClick(Sender: TObject);
    procedure CutBtnClick(Sender: TObject);
    procedure PasteBtnClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure OpenBtnClick(Sender: TObject);
    procedure StrListChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StrListClick(Sender: TObject);
    procedure StrListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StrListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StrListKeyPress(Sender: TObject; var Key: Char);
    procedure SearchBtnClick(Sender: TObject);
    procedure Find(Sender: TObject);
    procedure PrintBtnClick(Sender: TObject);
    procedure ReplaceBtnClick(Sender: TObject);
    procedure ReplaceDialogReplace(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure ReplaceDialogFind(Sender: TObject);
    procedure ReplaceDialogClose(Sender: TObject);
    procedure LMDButton1Click(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    LastPos,
    LastLine : Integer;  
    procedure UpDateCursorPos;
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.DFM}

procedure TLMDFrmStringEditor.SelectBtnClick(Sender: TObject);
begin
  StrList.SelectAll;
end;

procedure TLMDFrmStringEditor.CutBtnClick(Sender: TObject);
begin
  StrList.CutToClipboard;
end;

procedure TLMDFrmStringEditor.PasteBtnClick(Sender: TObject);
begin
  StrList.PasteFromClipboard;
end;

procedure TLMDFrmStringEditor.CopyBtnClick(Sender: TObject);
begin
  StrList.CopyToClipboard;
end;

procedure TLMDFrmStringEditor.SaveBtnClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    if SaveDialog.Filename <> '' then
      begin
        StrList.Lines.SaveToFile (SaveDialog.Filename);
      end;
end;

procedure TLMDFrmStringEditor.OpenBtnClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    if OpenDialog.Filename <> '' then
      begin
        if StrList.Lines.Count <> 0 then
          if MessageDlg ('Current text will be deleted!',mtWarning, [mbOk, mbCancel], 0) = ID_CANCEL then
            exit;
        StrList.Lines.LoadFromFile (OpenDialog.Filename);
      end;
end;

procedure TLMDFrmStringEditor.UpDateCursorPos;
var
  CharPos: TPoint;
begin
  CharPos.Y := SendMessage(StrList.Handle, EM_LINEFROMCHAR, StrList.SelStart,
    0);
  CharPos.X := (StrList.SelStart -
    SendMessage(StrList.Handle, EM_LINEINDEX, CharPos.Y, 0));
  Inc(CharPos.Y);
  Inc(CharPos.X);
  PosInfo.Caption := Format('Line: %3d   Col: %3d', [CharPos.Y, CharPos.X]);
end;

procedure TLMDFrmStringEditor.StrListChange(Sender: TObject);
begin
  UpDateCursorPos;
end;

procedure TLMDFrmStringEditor.FormCreate(Sender: TObject);
begin
  UpDateCursorPos;
end;

procedure TLMDFrmStringEditor.StrListClick(Sender: TObject);
begin
  UpDateCursorPos;
end;

procedure TLMDFrmStringEditor.StrListKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnCancelClick(nil)
  else
    UpDateCursorPos;
end;

procedure TLMDFrmStringEditor.StrListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  UpDateCursorPos;
end;

procedure TLMDFrmStringEditor.StrListKeyPress(Sender: TObject;
  var Key: Char);
begin
  UpDateCursorPos;
end;

procedure TLMDFrmStringEditor.SearchBtnClick(Sender: TObject);
begin
  LastLine := 1;
  LastPos := 1;
  FindDialog.Execute;
end;

procedure TLMDFrmStringEditor.Find(Sender: TObject);
begin
 {  with Sender as TFindDialog do   FindText
    if not SearchMemo(StrList, FindText, Options) then
      ShowMessage('Cannot find "' + FindText + '".');}
end;

procedure TLMDFrmStringEditor.PrintBtnClick(Sender: TObject);
var
  Line, i: Integer;
  PrintText: TextFile;   {Deklaration einer Dateivariablen}

begin
  if PrintDialog.Execute then
    for i := 1 to PrintDialog.Copies do
      begin
        AssignPrn(PrintText);   {Zuweisung von PrintText an den Drucker}
        Rewrite(PrintText);     {Erzeugen und ÷ffnen der Ausgabedatei}
        Printer.Canvas.Font := StrList.Font;{Zuweisung der eingestellten Schriftart an die Leinwand}
        Printer.Title := 'StringList #'+IntToStr(i);
        for Line := 0 to StrList.Lines.Count - 1 do
          Writeln(PrintText, StrList.Lines[Line]);	{Schreiben des Inhalts von Memo1 in das Druckerobjekt}
        CloseFile(PrintText); {Schlieﬂen der Druckervariablen}
      end;
end;

procedure TLMDFrmStringEditor.ReplaceBtnClick(Sender: TObject);
begin
  ReplaceDialog.Execute;
end;

procedure TLMDFrmStringEditor.ReplaceDialogReplace(Sender: TObject);
var
  op,
  I, J, PosReturn, SkipChars: Integer;
  s, s2 : String;
begin
  s := ReplaceDialog.FindText;
  if not (frMatchCase in ReplaceDialog.Options) then
    s := AnsiUpperCase (s);
  if (ReplaceDialog.Options*[frReplaceAll])=[frReplaceAll] then
    For I := 0 to StrList.Lines.Count do
      begin
        op := 1;
        repeat
         if not (frMatchCase in ReplaceDialog.Options) then
           s2 := AnsiUpperCase (StrList.Lines[I])
         else
           s2 := StrList.Lines[I];
         s2 := Copy(s2, op, Length(s2) - op +1);
         PosReturn := Pos(s,s2);

         if PosReturn <> 0 then {found!}
           begin
             inc(PosReturn, op-1);
             Skipchars := 0;
             for J := 0 to I - 1 do
               Skipchars := Skipchars + Length(StrList.Lines[J]);
             SkipChars := SkipChars + (I*2);

             SkipChars := SkipChars + PosReturn - 1;
             StrList.SetFocus;
             StrList.SelStart := SkipChars;
             StrList.SelLength := Length(s);
             StrList.SelText := ReplaceDialog.ReplaceText;
           end;
         op := PosReturn+1;
        until PosReturn = 0;
      end
  else
    begin
      { search for next pattern if no one is selected }
{      FindDialog.FindText := ReplaceDialog.FindText;
      if StrList.SelLength = 0 then
        FindDialogFind (Sender);}
      { if a pattern is selected replace it }  
      if StrList.SelLength <> 0 then
        StrList.SelText := ReplaceDialog.ReplaceText
      else
        ShowMessage ('No text selected!');
    end;
end;

procedure TLMDFrmStringEditor.FindDialogFind(Sender: TObject);
var
  SkipChars,
  PosReturn, I, J : integer;
{  found, i, i2, J : integer;}
  s2,
  s : string;

  function BPos (SubStr, OStr : String) : longint;
  var
    i : longint;
  begin
    result := 0;
    i := Length (OStr) - Length (SubStr);
    while i > 0 do
      begin
        if OStr[i] = SubStr[1] then
          if Pos (SubStr, Copy (OStr, i, Length(OStr) - i)) <> 0 then
            begin
              result := i;
              exit;
            end;
        dec (i);
      end;
  end;

begin
  s := FindDialog.FindText;
  if LastLine > StrList.Lines.Count then
    LastLine := 0;
  if LastLine < 0 then
    LastLine := StrList.Lines.Count;
  if frWholeWord in FindDialog.Options then
    s := s+' ';
  if not (frMatchCase in FindDialog.Options) then
    s := AnsiUpperCase(s);
  if frDown in FindDialog.Options then
    For I := LastLine-1 to StrList.Lines.Count-1 do
      begin
        s2 := Copy (StrList.Lines[I], LastPos, Length (StrList.Lines[I]) - LastPos + 1);
        if not (frMatchCase In FindDialog.Options) then
          PosReturn := Pos(s,AnsiUpperCase(s2))
        else
          PosReturn := Pos(s,s2);
        if PosReturn <> 0 then {found!}
          begin
            Skipchars := 0;
            for J := 0 to I - 1 do
               Skipchars := Skipchars + Length(StrList.Lines[J]);
            SkipChars := SkipChars + (I*2);

            SkipChars := SkipChars + PosReturn - 1 + LastPos - 1;
            StrList.SetFocus;
            StrList.SelStart := SkipChars;
            StrList.SelLength := Length(FindDialog.FindText);
            LastLine := i+1;
            LastPos := PosReturn + LastPos;
            Exit;
          end;
        LastPos := 1;
      end
  else
    For I := LastLine downto 0 do
      begin
        s2 := Copy (StrList.Lines[I], 1, LastPos);
        if not (frMatchCase In FindDialog.Options) then
          PosReturn := BPos(s,AnsiUpperCase(s2))
        else
          PosReturn := BPos(s,s2);
        if PosReturn <> 0 then {found!}
          begin
            Skipchars := 0;
            for J := 0 to I - 1 do
              Skipchars := Skipchars + Length(StrList.Lines[J]);
            SkipChars := SkipChars + (I*2);

            SkipChars := SkipChars + PosReturn - 1;
            StrList.SetFocus;
            StrList.SelStart := SkipChars;
            StrList.SelLength := Length(FindDialog.FindText);
            LastLine := i;
            LastPos := PosReturn - 1;
            Exit;
          end;
        LastPos := Length(StrList.Lines[I-1]);
      end;
end;

procedure TLMDFrmStringEditor.ReplaceDialogFind(Sender: TObject);
begin
  FindDialog.FindText := ReplaceDialog.FindText;
  FindDialogFind (Sender);
end;

procedure TLMDFrmStringEditor.ReplaceDialogClose(Sender: TObject);
begin
  LastLine := 1;
  LastPos := 1;
end;

procedure TLMDFrmStringEditor.LMDButton1Click(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TLMDFrmStringEditor.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
