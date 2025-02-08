unit pLMDRTFEditor;
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

pLMDRTFEditor unit (RM)
-----------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, Messages, Classes, Controls, StdCtrls, ExtCtrls, ActnList,
  ImgList, ToolWin, ComCtrls, LMDRTFActions, LMDRTFRichEdit;
  type
{ **************************  TfrmLMDRTFEditor  ************************** }
  TfrmLMDRTFEditor = class(TForm)
    LMDRichEdit: TLMDRichEdit;
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    alToolbar1: TActionList;
    Toolbar1: TToolBar;
    btnNew1: TToolButton;
    actNew1: TLMDRichEditNew;
    btnLoad1: TToolButton;
    actLoad1: TLMDRichEditLoad;
    btnSave1: TToolButton;
    actSave1: TLMDRichEditSave;
    Separator1: TToolButton;
    btnPrint1: TToolButton;
    actPrint1: TLMDRichEditPrint;
    btnPreview1: TToolButton;
    actPreview1: TLMDRichEditPreview;
    Separator2: TToolButton;
    btnFind1: TToolButton;
    actFind1: TLMDRichEditFind;
    Separator3: TToolButton;
    btnCut1: TToolButton;
    actCut1: TLMDRichEditCut;
    btnCopy1: TToolButton;
    actCopy1: TLMDRichEditCopy;
    btnPaste1: TToolButton;
    actPaste1: TLMDRichEditPaste;
    Separator4: TToolButton;
    btnUndo1: TToolButton;
    actUndo1: TLMDRichEditUndo;
    btnRedo1: TToolButton;
    actRedo1: TLMDRichEditRedo;
    Separator5: TToolButton;
    btnTextAttributes1: TToolButton;
    actTextAttributes1: TLMDRichEditTextAttributes;
    Separator6: TToolButton;
    btnTextBold1: TToolButton;
    actTextBold1: TLMDRichEditTextBold;
    btnTextItalic1: TToolButton;
    actTextItalic1: TLMDRichEditTextItalic;
    btnTextUnderline1: TToolButton;
    actTextUnderline1: TLMDRichEditTextUnderline;
    Separator7: TToolButton;
    btnTextSubscript1: TToolButton;
    actTextSubscript1: TLMDRichEditTextSubscript;
    btnTextSuperscript1: TToolButton;
    actTextSuperscript1: TLMDRichEditTextSuperscript;
    Separator8: TToolButton;
    btnParaAlign1: TToolButton;
    actParaAlign1: TLMDRichEditParaAlign;
    btnParaAlign2: TToolButton;
    actParaAlign2: TLMDRichEditParaAlign;
    btnParaAlign3: TToolButton;
    actParaAlign3: TLMDRichEditParaAlign;
    actParaAlign4: TLMDRichEditParaAlign;
    Separator9: TToolButton;
    btnNumbering1: TToolButton;
    actNumbering1: TLMDRichEditNumbering;
    btnNumbering2: TToolButton;
    actNumbering2: TLMDRichEditNumbering;
    btnIndent1: TToolButton;
    actIndent1: TLMDRichEditIndent;
    btnUnindent1: TToolButton;
    actUnindent1: TLMDRichEditUnindent;
    Panel1: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
    btnCodeEditor: TButton;
    procedure LMDRichEditSelectionChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  public
    { Public declarations }
  end;

implementation

uses
  Windows, SysUtils;

{$R *.DFM}

{ **************************  TfrmLMDRTFEditor  ************************** }

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFEditor.LMDRichEditSelectionChange(Sender: TObject);
begin
   StatusBar1.Panels[0].Text:= Format( '%d : %d',
     [ LMDRichEdit.CursorPos.Y,  LMDRichEdit.CursorPos.X])
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFEditor.WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo);
begin
  inherited;

  with Msg.MinMaxInfo.ptMinTrackSize do
  begin
    x := self.Constraints.MinWidth;
    y := self.Constraints.MinHeight;
  end;
end;

procedure TfrmLMDRTFEditor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if  (Shift = []) and (Key = VK_ESCAPE)  then
    Close;
end;

procedure TfrmLMDRTFEditor.FormShow(Sender: TObject);
begin
  LMDRichEditSelectionChange(LMDRichEdit);
end;

end.

