unit LMDTextEditor;
{$I lmdcmps.INC}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDTextEditor unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ImgList, Menus,
  LMDClass, LMDBaseGraphicButton, LMDCustomSpeedButton, LMDTxtPrinter,
  LMDCustomComponent, LMDWndProcComponent, LMDFormStyler,
  LMDCustomImageList, LMDImageList, StdCtrls, LMDCustomButton, LMDButton,
  LMDSimplePanel, LMDSpeedButton, LMDBaseControl, LMDBaseGraphicControl,
  LMDBaseLabel, LMDInformationLabel, LMDCustomStatusBar, LMDStatusBar,
  LMDBaseEdit, LMDCustomMemo, LMDMemo, LMDControl, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel,
  LMDCustomPanelFill, LMDPanelFill;

type
  TLMDFrmTextEditor = class(TForm)
    b: TLMDPanelFill;
    Memo: TLMDMemo;
    StatusBar: TLMDStatusBar;
    LMDImageList1: TLMDImageList;
    FontDialog: TFontDialog;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    fs: TLMDFormStyler;
    FindDialog: TFindDialog;
    ReplaceDialog: TReplaceDialog;
    LMDInformationLabel1: TLMDInformationLabel;
    LMDInformationLabel2: TLMDInformationLabel;
    PrintDialog: TPrintDialog;
    mainmenu: TMainMenu;
    LMDTxtPrinter: TLMDTxtPrinter;
    File1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Clear1: TMenuItem;
    Print1: TMenuItem;
    N1: TMenuItem;
    Close1: TMenuItem;
    Edit1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Cut1: TMenuItem;
    Selectall1: TMenuItem;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    Search2: TMenuItem;
    Replace1: TMenuItem;
    Options1: TMenuItem;
    Font1: TMenuItem;
    Lined1: TMenuItem;
    Wordwrap1: TMenuItem;
    Statistics1: TMenuItem;
    toolBar: TLMDPanelFill;
    open: TLMDSpeedButton;
    save: TLMDSpeedButton;
    clear: TLMDSpeedButton;
    print: TLMDSpeedButton;
    fontbtn: TLMDSpeedButton;
    lines: TLMDSpeedButton;
    WordWrap: TLMDSpeedButton;
    alignLeft: TLMDSpeedButton;
    alignCenter: TLMDSpeedButton;
    alignRight: TLMDSpeedButton;
    statistics: TLMDSpeedButton;
    cut: TLMDSpeedButton;
    paste: TLMDSpeedButton;
    copy: TLMDSpeedButton;
    selectall: TLMDSpeedButton;
    redo: TLMDSpeedButton;
    undo: TLMDSpeedButton;
    search: TLMDSpeedButton;
    replace: TLMDSpeedButton;
    N3: TMenuItem;
    N4: TMenuItem;
    pnlBottom: TLMDSimplePanel;
    btnOk: TLMDButton;
    btnCancel: TLMDButton;
    btnCustom: TLMDButton;
    N5: TMenuItem;
    N6: TMenuItem;
    procedure linesClick(Sender: TObject);
    procedure redoClick(Sender: TObject);
    procedure undoClick(Sender: TObject);
    procedure copyClick(Sender: TObject);
    procedure pasteClick(Sender: TObject);
    procedure cutClick(Sender: TObject);
    procedure alignLeftClick(Sender: TObject);
    procedure WordWrapClick(Sender: TObject);
    procedure selectallClick(Sender: TObject);
    procedure fontbtnClick(Sender: TObject);
    procedure clearClick(Sender: TObject);
    procedure openClick(Sender: TObject);
    procedure saveClick(Sender: TObject);
    procedure MemoCursorPosChanged(Sender: TObject);
    procedure MemoCurrentRowChanged(Sender: TObject);
    procedure searchClick(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure statisticsClick(Sender: TObject);
    procedure replaceClick(Sender: TObject);
    procedure ReplaceDialogFind(Sender: TObject);
    procedure MemoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure printClick(Sender: TObject);
    procedure Close1Click(Sender: TObject);
  private
    { Private declarations }
  public
    Filename : String;
  end;

implementation

{$R *.DFM}

uses
  Printers, Consts,
  LMDConst, LMDRTLConst, LMDProcs, LMDStrings;

procedure TLMDFrmTextEditor.linesClick(Sender: TObject);
begin
  lined1.Checked := not lined1.Checked;
  Lines.Pressed := lined1.Checked;
  Memo.Lined := Lines.Pressed;
end;

procedure TLMDFrmTextEditor.redoClick(Sender: TObject);
begin
  Memo.Redo;
end;

procedure TLMDFrmTextEditor.undoClick(Sender: TObject);
begin
  Memo.Undo;
end;

procedure TLMDFrmTextEditor.copyClick(Sender: TObject);
begin
  Memo.CopyToClipBoard;
end;

procedure TLMDFrmTextEditor.pasteClick(Sender: TObject);
begin
  Memo.PasteFromClipBoard;
end;

procedure TLMDFrmTextEditor.cutClick(Sender: TObject);
begin
  Memo.CutToClipBoard;
end;

procedure TLMDFrmTextEditor.alignLeftClick(Sender: TObject);
begin
  if sender is TLMDSpeedButton then
    Memo.Alignment := TAlignment((Sender as TLMDSpeedButton).Tag)
  else
    Memo.Alignment := TAlignment((Sender as TMenuItem).Tag)
end;

procedure TLMDFrmTextEditor.WordWrapClick(Sender: TObject);
begin
  wordwrap1.Checked := not wordwrap1.Checked;
  wordwrap.Pressed := wordwrap1.Checked;
  Memo.WordWrap := WordWrap.Pressed;
end;

procedure TLMDFrmTextEditor.selectallClick(Sender: TObject);
begin
  Memo.SelectAll;
end;

procedure TLMDFrmTextEditor.fontbtnClick(Sender: TObject);
begin
  FontDialog.Font.Assign (Memo.Font);
  if FontDialog.Execute then
    Memo.Font.Assign (FontDialog.Font);
end;

procedure TLMDFrmTextEditor.clearClick(Sender: TObject);
begin
  Memo.Clear;
end;

procedure TLMDFrmTextEditor.openClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    begin
      Filename := OpenDialog.Filename;
      Memo.LoadFromFile (OpenDialog.Filename);
    end;
end;

procedure TLMDFrmTextEditor.saveClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    Memo.SaveToFile (SaveDialog.Filename);
end;

procedure TLMDFrmTextEditor.MemoCursorPosChanged(Sender: TObject);
begin
  StatusBar.Panels[0].Text := IntToStr(Memo.CurrentChar) + ' : '+IntToStr(Length(Memo.Text));
  StatusBar.Panels[1].Text := IntToStr(Memo.Column) + ' : '+IntToStr(Memo.Columns);
end;

procedure TLMDFrmTextEditor.MemoCurrentRowChanged(Sender: TObject);
begin
  StatusBar.Panels[2].Text := IntToStr(Memo.Row) + ' : '+IntToStr(Memo.Rows);
end;

procedure TLMDFrmTextEditor.searchClick(Sender: TObject);
begin
  FindDialog.Execute;
end;

procedure TLMDFrmTextEditor.FindDialogFind(Sender: TObject);
var
  sd : TLMDSearchDirection;
begin
  if frDown in FindDialog.Options then
    sd := sdDown
  else
    sd := sdUp;
  Memo.Search (FindDialog.FindText, stCursor, frMatchCase in FindDialog.Options,
               frWholeWord in FindDialog.Options, sd);
  Memo.SetFocus;
end;

procedure TLMDFrmTextEditor.statisticsClick(Sender: TObject);
begin
  ShowMessage ('Words : '+IntToStr(Memo.CountWords)+#10#13+
               'Lines : '+IntToStr(Memo.Rows)+#10#13+
               'Characters : '+IntToStr(Memo.GetLength));
end;

procedure TLMDFrmTextEditor.replaceClick(Sender: TObject);
begin
  ReplaceDialog.Execute;
end;

procedure TLMDFrmTextEditor.ReplaceDialogFind(Sender: TObject);
var
  sd : TLMDSearchDirection;
begin
  if frDown in ReplaceDialog.Options then
    sd := sdDown
  else
    sd := sdUp;
  Memo.SearchAndReplace (ReplaceDialog.FindText, ReplaceDialog.ReplaceText, stCursor,
                         frMatchCase in ReplaceDialog.Options,
                         frWholeWord in ReplaceDialog.Options, sd, true,
                         frReplaceAll in ReplaceDialog.Options);
end;

procedure TLMDFrmTextEditor.MemoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_Insert then
    if emInsert in LMDApplication.EditMode then
      StatusBar.Panels[5].Text := 'Ins'
    else
      StatusBar.Panels[5].Text := 'Ovr';
end;

procedure TLMDFrmTextEditor.FormCreate(Sender: TObject);

  function clearAccel (s : String) : String;
  begin
    result := '';
    while Pos ('&', s) <> 0 do
      begin
        result := result + System.Copy (s, 1, Pos ('&', s) - 1);
        Delete (s, 1, Pos ('&', s));
        if s[1] = '&' then
          begin
            result := result + '&';
            Delete (s, 1, 1);
          end;
      end;
    result := result + s;
  end;

begin
  btnOk.Caption:=SOKButton;
  btnCancel.Caption:=IDS_CANCEl;
  copy.Hint := clearAccel(IDS_COPY);
  paste.Hint := clearAccel(IDS_INSERT);
  cut.Hint := clearAccel(IDS_CUT);
  undo.Hint := clearAccel(IDS_UNDO);
  redo.Hint := clearAccel(IDS_REDO);
  selectall.Hint := clearAccel(IDS_SELECTALL);
  search.Hint := clearAccel(IDS_SEARCH);
  replace.Hint := clearAccel(IDS_REPLACE);
  wordwrap.Hint := clearAccel(IDS_WORDWRAP);

  save.Hint := clearAccel(IDS_SAVE);
  open.Hint := clearAccel(IDS_OPEN);
  clear.Hint := clearAccel(IDS_CLEAR);
  print.Hint := clearAccel(IDS_PRINT);
  lines.Hint := clearAccel(IDS_LINED);
  alignLeft.Hint := clearAccel(IDS_ALIGNLEFT);
  alignRight.Hint := clearAccel(IDS_ALIGNRIGHT);
  alignCenter.Hint := clearAccel(IDS_ALIGNCENTER);
  statistics.Hint := clearAccel(IDS_STATISTICS);
  fontbtn.Hint := clearAccel(IDS_FONT);

  open1.Caption := IDS_OPEN;
  save1.Caption := IDS_SAVE;
  print1.Caption := IDS_PRINT;
  redo1.Caption := IDS_REDO;
  undo1.Caption := IDS_UNDO;
  clear1.Caption := IDS_CLEAR;
  font1.Caption := IDS_FONT;
  statistics1.Caption := IDS_STATISTICS;
  wordwrap1.Caption := IDS_WORDWRAP;
  copy1.Caption := IDS_COPY;
  cut1.Caption := IDS_CUT;
  paste1.Caption := IDS_INSERT;
  search2.Caption := IDS_SEARCH;
  replace1.Caption := IDS_REPLACE;
  close1.Caption := IDS_CLOSE;
  file1.Caption := IDS_FILE;
  edit1.Caption := IDS_EDIT;
  selectall1.Caption := IDS_SELECTALL;
end;

procedure TLMDFrmTextEditor.printClick(Sender: TObject);
begin
  if PrintDialog.Execute then
    begin
      LMDTxtPrinter.Title := Application.Title + '-' + Filename;
      LMDTxtPrinter.Copies := PrintDialog.Copies;
      LMDTxtPrinter.PrintText (Memo.Text);
    end;
end;

procedure TLMDFrmTextEditor.Close1Click(Sender: TObject);
begin
  Close;
end;

end.
