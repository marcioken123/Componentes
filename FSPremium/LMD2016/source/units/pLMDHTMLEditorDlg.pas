unit pLMDHTMLEditorDlg;
{$I lmdcmps.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, LMDPopupMenu, LMDDrawEdge, StdCtrls, LMDIniCtrl,
  LMDCustomComponent, LMDCont, LMDCustomEdit, LMDCustomBrowseEdit,
  LMDFileOpenEdit, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDCustomDockLabel, LMDDockLabel,
  LMDCustomParentPanel, LMDCustomPanelFill, LMDTextCustomPanel,
  LMDTextScrollPanel, LMDCustomImageListBox, LMDTextListBox,
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit,
  LMDCustomMemo, LMDMemo, ComCtrls, LMDCustomButton, LMDButton, 
  LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDSpeedButton, ExtCtrls, LMDCustomFileEdit, LMDCustomListBox,
  LMDBaseController, LMDCustomContainer, LMDCustomImageList, LMDImageList,
  ImgList, LMDControl, LMDBaseControl;

type
  TfrmTLMDHTMLEditor = class(TForm)
    Panel1: TPanel;
    LMDButton1: TLMDButton;
    LMDButton2: TLMDButton;
    openDialog: TOpenDialog;
    tabs: TPageControl;
    editor: TTabSheet;
    TabSheet2: TTabSheet;
    preview: TLMDTextScrollPanel;
    options: TTabSheet;
    fedit: TLMDFileOpenEdit;
    LMDDockLabel1: TLMDDockLabel;
    HTMLEDIT: TLMDMemo;
    taglb: TLMDTextListBox;
    LMDImageList1: TLMDImageList;
    btnOpen: TLMDSpeedButton;
    btnSave: TLMDSpeedButton;
    btnCut: TLMDSpeedButton;
    btnCopy: TLMDSpeedButton;
    btnPaste: TLMDSpeedButton;
    btnEditor: TLMDSpeedButton;
    SaveDialog: TSaveDialog;
    ini: TLMDIniCtrl;
    LMDSpeedButton1: TLMDSpeedButton;
    colordlg: TColorDialog;
    procedure TabSheet2Show(Sender: TObject);
    procedure taglbDblClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCutClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEditorClick(Sender: TObject);
    procedure LMDSpeedButton1Click(Sender: TObject);
  private
  public

  end;

var
  frmTLMDHTMLEditor: TfrmTLMDHTMLEditor;

implementation
uses
  shellapi,
  LMDTypes, pLMDCst ;

{$R *.DFM}
procedure TfrmTLMDHTMLEditor.TabSheet2Show(Sender: TObject);
begin
  HTMLEdit.Lines.GetAsStrings(preview.Lines);
end;

procedure TfrmTLMDHTMLEditor.taglbDblClick(Sender: TObject);
var
  tmp:String;

  procedure PerformAction(const aValue:String; goback:Integer=0);
  begin
    HTMLEDit.Insert(HTMLEdit.CurrentChar, aValue);
    //HTMLEdit.SelText:=aValue;
    HTMLEdit.CurrentChar:=HTMLEdit.CurrentChar-goback;
    HTMLEdit.SetFocus;
  end;

begin
  if taglb.ItemIndex=-1 then
    exit
  else
    tmp:=Trim(taglb.Items[taglb.ItemIndex]);

  // Font Tags
  if tmp='Font' then PerformAction('<FONT FACE="" SIZE=""></FONT>', 17);
  if tmp='Image' then PerformAction('<img src="">', 2);
  if tmp='Table' then PerformAction('<table></table>',8);
  if tmp='Paragraph' then PerformAction('<p></p>',4);
  if tmp='LineBreak' then PerformAction('<BR>');
  if tmp='Center' then PerformAction('<CENTER></CENTER>',9);
  if tmp='BlockQuote' then PerformAction('<BLOCKQUOTE></BLOCKQUOTE>',13);

  // Format Tags
  if tmp='Bold' then PerformAction('<B></B>',4);
  if tmp='Italic' then PerformAction('<I></I>',4);
  if tmp='Strike' then PerformAction('<STRIKE></STRIKE>',9);
  if tmp='Underline' then PerformAction('<U></U>',4);
  if tmp='Subscript' then PerformAction('<SUB></SUB>',6);
  if tmp='Superscript' then PerformAction('<SUP></SUP>',6);

  // List Tags
  if tmp='Ordered' then PerformAction('<OL><LI></LI><OL>',9);
  if tmp='UnOrdered' then PerformAction('<UL><LI></LI></UL>',9);

  // Link Tags
  if tmp='Link' then PerformAction('<a href=""></a>',6);
  if tmp='Mail' then PerformAction('<a href="mailto:"></a>',6);

  // LMD Tags
  if tmp='Repeat' then PerformAction('<repeat count=></repeat>');
  if tmp='Variable' then PerformAction('<~~>');
  if tmp='Control' then PerformAction('<control vclclass=TLMDEdit name= width= height=>');

end;

procedure TfrmTLMDHTMLEditor.btnOpenClick(Sender: TObject);
begin
  if openDialog.execute then
    HTMLEdit.Lines.LoadFromFile (openDialog.Filename);
end;

procedure TfrmTLMDHTMLEditor.btnSaveClick(Sender: TObject);
begin
  if saveDialog.execute then
    HTMLEdit.Lines.SaveToFile (saveDialog.Filename);
end;

procedure TfrmTLMDHTMLEditor.btnCutClick(Sender: TObject);
begin
  HTMLEdit.CutToClipboard;
end;

procedure TfrmTLMDHTMLEditor.btnCopyClick(Sender: TObject);
begin
  HTMLEdit.CopyToClipboard;
end;

procedure TfrmTLMDHTMLEditor.btnPasteClick(Sender: TObject);
begin
  HTMLEdit.PasteFromClipboard;
end;

procedure TfrmTLMDHTMLEditor.FormCreate(Sender: TObject);
begin
  ini.RegPath:=LMDTOOLS_REGISTRYPATH+'\HTMLEditor';
  fedit.Text:=ini.ReadString(IDS_ROOT, 'EditorPath','')
end;

procedure TfrmTLMDHTMLEditor.FormDestroy(Sender: TObject);
begin
  ini.Writestring(IDS_ROOT, 'EditorPath',fedit.Text)
end;

procedure TfrmTLMDHTMLEditor.btnEditorClick(Sender: TObject);
begin
  {$IFDEF LMD_UNICODE}
  ShellExecuteW(Application.Handle,'', PWideChar(FEdit.Text),'','', SW_SHOWNORMAL);
  {$ELSE}
  ShellExecuteA(Application.Handle,'', PAnsiChar(FEdit.Text),'','', SW_SHOWNORMAL);
  {$ENDIF}
end;

procedure TfrmTLMDHTMLEditor.LMDSpeedButton1Click(Sender: TObject);
var
  tmp:String;
  ac:LongInt;
begin
  if colordlg.Execute then
    begin
      ac:=ColorToRGB(colorDlg.Color);
      tmp:=InttoHex(GetRValue(ac), 2)+InttoHex(GetGValue(ac), 2)+InttoHex(GetBValue(ac), 2);
      tmp:='<FONT COLOR="#'+tmp+'">';
      HTMLEDit.Insert(HTMLEdit.CurrentChar, tmp);
      HTMLEdit.SetFocus;
    end;
end;

end.
