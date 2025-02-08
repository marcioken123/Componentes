unit pLMDElHTMLEditorDlg;
{$I LMDCmps.INC}

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

pLMDElHTMLEditorDlg unit
------------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release


###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ExtCtrls, 
  ElListBox, HTMLLbx, ElXPThemedControl, ElBtnCtl, ElPopBtn, ImgList,
  ElEdits, ElIni, ElHTMLView, ComCtrls, ElBtnEdit, ElNameEdits, ElShellUtils, ElComponent;

type
  TfrmLMDElHTMLEditor = class(TForm)
    Panel1: TPanel;
    openDialog: TOpenDialog;
    tabs: TPageControl;
    editor: TTabSheet;
    TabSheet2: TTabSheet;
    options: TTabSheet;
    SaveDialog: TSaveDialog;
    colordlg: TColorDialog;
    ImageList1: TImageList;
    btnOk: TElPopupButton;
    ElPopupButton1: TElPopupButton;
    btnOpen: TElPopupButton;
    btnSave: TElPopupButton;
    btnCut: TElPopupButton;
    btnCopy: TElPopupButton;
    btnPaste: TElPopupButton;
    btnFontColor: TElPopupButton;
    btnEditor: TElPopupButton;
    taglb: TElHTMLListBox;
    HTMLEdit: TElMemo;
    ini: TElIniFile;
    preview: TElHTMLView;
    fedit: TElFileNameEdit;
    Label1: TLabel;
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
    procedure btnFontColorClick(Sender: TObject);
  private
  public

  end;

var
  frmTLMDElHTMLEditor: TfrmLMDElHTMLEditor;

const
  IDS_ROOT:String='Options';

implementation

uses
  pLMDCst, LMDProcs ;

{$R *.DFM}
procedure TfrmLMDElHTMLEditor.TabSheet2Show(Sender: TObject);
begin
  preview.caption := HTMLEdit.text;
end;

procedure TfrmLMDElHTMLEditor.taglbDblClick(Sender: TObject);
var
  tmp,s:String;

  procedure PerformAction(const aValue:String; goback:Integer=0);
  begin
    HTMLEdit.SelText := aValue;
    HTMLEdit.SelStart := HTMLEdit.SelStart - goback;
    HTMLEdit.SetFocus;
  end;

begin
  if taglb.ItemIndex=-1 then
    exit
  else
    tmp:=Trim(taglb.Items[taglb.ItemIndex]);
    s := HTMLEdit.SelText;
  // Font Tags
  if tmp='Font' then PerformAction('<FONT FACE="" SIZE="">'+s+'</FONT>', 17);
  if tmp='Image' then PerformAction('<img src="">', 2);
//  if tmp='Table' then PerformAction('<table></table>',8);
  if tmp='Paragraph' then PerformAction('<p>'+s+'</p>',4);
  if tmp='LineBreak' then PerformAction('<BR>'+s);
  if tmp='Center' then PerformAction('<CENTER>'+s+'</CENTER>',9);
//  if tmp='BlockQuote' then PerformAction('<BLOCKQUOTE>'+s+'</BLOCKQUOTE>',13);

  // Format Tags
  if tmp='Bold' then PerformAction('<B>'+s+'</B>',4);
  if tmp='Italic' then PerformAction('<I>'+s+'</I>',4);
  if tmp='Strike' then PerformAction('<STRIKE>'+s+'</STRIKE>',9);
  if tmp='Underline' then PerformAction('<U>'+s+'</U>',4);
  if tmp='Subscript' then PerformAction('<SUB>'+s+'</SUB>',6);
  if tmp='Superscript' then PerformAction('<SUP>'+s+'</SUP>',6);

  // List Tags
  if tmp='Ordered' then PerformAction('<OL><LI>'+s+'</LI></OL>',9);
  if tmp='UnOrdered' then PerformAction('<UL><LI>'+s+'</LI></UL>',9);

  // Link Tags
  if tmp='Link' then PerformAction('<a href="'+s+'">'+s+'</a>',6);
  if tmp='Mail' then PerformAction('<a href="mailto:'+s+'">'+s+'</a>',6);

  // LMD Tags
  //if tmp='Repeat' then PerformAction('<repeat count=></repeat>');
  //if tmp='Variable' then PerformAction('<~~>');
  //if tmp='Control' then PerformAction('<control vclclass=TLMDEdit name= width= height=>');

end;

procedure TfrmLMDElHTMLEditor.btnOpenClick(Sender: TObject);
begin
  if openDialog.execute then
    HTMLEdit.Lines.LoadFromFile (openDialog.Filename);
end;

procedure TfrmLMDElHTMLEditor.btnSaveClick(Sender: TObject);
begin
  if saveDialog.execute then
    HTMLEdit.Lines.SaveToFile (saveDialog.Filename);
end;

procedure TfrmLMDElHTMLEditor.btnCutClick(Sender: TObject);
begin
  HTMLEdit.CutToClipboard;
end;

procedure TfrmLMDElHTMLEditor.btnCopyClick(Sender: TObject);
begin
  HTMLEdit.CopyToClipboard;
end;

procedure TfrmLMDElHTMLEditor.btnPasteClick(Sender: TObject);
begin
  HTMLEdit.PasteFromClipboard;
end;

procedure TfrmLMDElHTMLEditor.FormCreate(Sender: TObject);
var s:string;
begin
  ini.Path:=LMDELPACK_REGISTRYPATH+'\HTMLEditor';
  ini.ReadString(IDS_ROOT, 'EditorPath','',s);
  fedit.Text := s;
end;

procedure TfrmLMDElHTMLEditor.FormDestroy(Sender: TObject);
begin
  ini.Writestring(IDS_ROOT, 'EditorPath',fedit.Text)
end;

procedure TfrmLMDElHTMLEditor.btnEditorClick(Sender: TObject);
begin
  LMDFireUrl(FEdit.Text);
end;

procedure TfrmLMDElHTMLEditor.btnFontColorClick(Sender: TObject);
var
  tmp:String;
  ac:LongInt;
begin
  if colordlg.Execute then
    begin
      ac:=ColorToRGB(colorDlg.Color);
      tmp:=InttoHex(GetRValue(ac), 2)+InttoHex(GetGValue(ac), 2)+InttoHex(GetBValue(ac), 2);
      tmp:='<FONT COLOR="#'+tmp+'">';
      //HTMLEDit.Insert(HTMLEdit.CurrentChar, tmp);
      HTMLEDit.SelText := tmp;
      HTMLEdit.SetFocus;
    end;
end;

end.
