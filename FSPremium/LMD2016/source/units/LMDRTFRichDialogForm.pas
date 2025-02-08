unit LMDRTFRichDialogForm;
{$I LMDCmps.inc}

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

LMDRTFRichDialogForm unit (RM)
------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Forms, Messages, Classes, Controls, StdCtrls, Menus, ActnList, ImgList,
  ComCtrls, ToolWin,
  LMDRTFActions, LMDRTFRichEdit;
  type
  TLMDRichDialogForm = class(TForm)
    MainMenu: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    ImageList: TImageList;
    alToolbar: TActionList;
    Toolbar: TToolBar;
    btnNew1: TToolButton;
    actNew: TLMDRichEditNew;
    btnLoad1: TToolButton;
    actLoad: TLMDRichEditLoad;
    btnSave1: TToolButton;
    actSave: TLMDRichEditSave;
    Separator1: TToolButton;
    btnPrint1: TToolButton;
    actPrint: TLMDRichEditPrint;
    btnPreview1: TToolButton;
    actPreview: TLMDRichEditPreview;
    Separator2: TToolButton;
    btnFind1: TToolButton;
    actFind: TLMDRichEditFind;
    Separator3: TToolButton;
    btnCut1: TToolButton;
    actCut: TLMDRichEditCut;
    btnCopy1: TToolButton;
    actCopy: TLMDRichEditCopy;
    btnPaste1: TToolButton;
    actPaste: TLMDRichEditPaste;
    Separator4: TToolButton;
    btnUndo1: TToolButton;
    actUndo: TLMDRichEditUndo;
    btnRedo1: TToolButton;
    actRedo: TLMDRichEditRedo;
    Separator5: TToolButton;
    btnTextAttributes1: TToolButton;
    actTextAttributes: TLMDRichEditTextAttributes;
    Separator6: TToolButton;
    btnTextBold1: TToolButton;
    actTextBold: TLMDRichEditTextBold;
    btnTextItalic1: TToolButton;
    actTextItalic: TLMDRichEditTextItalic;
    btnTextUnderline1: TToolButton;
    actTextUnderline: TLMDRichEditTextUnderline;
    Separator7: TToolButton;
    btnTextSubscript1: TToolButton;
    actTextSubscript: TLMDRichEditTextSubscript;
    btnTextSuperscript1: TToolButton;
    actTextSuperscript: TLMDRichEditTextSuperscript;
    Separator8: TToolButton;
    btnParaAlign1: TToolButton;
    actParaAlign1: TLMDRichEditParaAlign;
    btnParaAlign2: TToolButton;
    actParaAlign2: TLMDRichEditParaAlign;
    btnParaAlign3: TToolButton;
    actParaAlign3: TLMDRichEditParaAlign;
    Separator9: TToolButton;
    btnNumbering1: TToolButton;
    actNumbering1: TLMDRichEditNumbering;
    btnNumbering2: TToolButton;
    actNumbering2: TLMDRichEditNumbering;
    btnIndent1: TToolButton;
    actIndent: TLMDRichEditIndent;
    btnUnindent1: TToolButton;
    actUnindent: TLMDRichEditUnindent;
    Openafile1: TMenuItem;
    Save1: TMenuItem;
    N1: TMenuItem;
    Print1: TMenuItem;
    Preview1: TMenuItem;
    Edit1: TMenuItem;
    Find1: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N2: TMenuItem;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    N3: TMenuItem;
    Format1: TMenuItem;
    Font1: TMenuItem;
    Numbering1: TMenuItem;
    StatusBar: TStatusBar;
    LMDRichEdit: TLMDRichEdit;
    Paragraph1: TMenuItem;
    actParagraph: TLMDRichEditParagraph;
    procedure LMDRichEditSelectionChange(Sender: TObject);
  private
    { Private declarations }
    procedure WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  public
    { Public declarations }
  end;

var
  LMDRichDialogForm: TLMDRichDialogForm;

implementation

uses
  SysUtils;

{$R *.dfm}

{ -------------------------------------------------------------------------- }
procedure TLMDRichDialogForm.WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo);
begin
  inherited;

  with Msg.MinMaxInfo.ptMinTrackSize do
  begin
    x := self.Constraints.MinWidth;
    y := self.Constraints.MinHeight;
  end;
end;

procedure TLMDRichDialogForm.LMDRichEditSelectionChange(Sender: TObject);
begin
   StatusBar.Panels[0].Text:= Format( '%d : %d',
     [ LMDRichEdit.CursorPos.Y,  LMDRichEdit.CursorPos.X])
end;

end.
