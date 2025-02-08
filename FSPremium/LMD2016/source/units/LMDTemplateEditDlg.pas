unit LMDTemplateEditDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdActns, ImgList, ComCtrls, StdCtrls, ExtActns, ActnList,
  ToolWin, LMDPrinter;

type
  TLMDTemplateEditDialog = class(TForm)
    RichEdit: TRichEdit;
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    btnOk: TButton;
    btnCancel: TButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ImageList1: TImageList;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    actUndo: TEditUndo;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    actFileOpen: TFileOpen;
    actFileSaveAs: TFileSaveAs;
    actBold: TRichEditBold;
    actItalic: TRichEditItalic;
    actUnderline: TRichEditUnderline;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    actAlignLeft: TRichEditAlignLeft;
    actAlignCenter: TRichEditAlignCenter;
    actAlignRight: TRichEditAlignRight;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    actFontEdit: TFontEdit;
    procedure actFontSelectExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LMDTemplateEditDialog: TLMDTemplateEditDialog;

  procedure LMDPrintExecTemplateDlg(ATemplate: TLMDPageTemplateBlock);
implementation

uses Math;

{$R *.dfm}

procedure LMDPrintExecTemplateDlg(ATemplate: TLMDPageTemplateBlock);
var
    Dlg: TLMDTemplateEditDialog;
begin
  Dlg := TLMDTemplateEditDialog.Create(nil);
  try
    ATemplate.AssignLinesTo(Dlg.RichEdit.Lines);

    if Dlg.ShowModal=mrOk then
      ATemplate.AssignLines(Dlg.RichEdit.Lines);
  finally
    Dlg.Free;
  end;
end;

procedure TLMDTemplateEditDialog.actFontSelectExecute(Sender: TObject);
var
    Fnt: TFont;
begin
  if RichEdit.SelLength>0 then
  begin
    Fnt := (Sender as TFontEdit).Dialog.Font;

    RichEdit.SelAttributes.Charset := Fnt.Charset;
    RichEdit.SelAttributes.Color := Fnt.Color;
    RichEdit.SelAttributes.Name := Fnt.Name;
    RichEdit.SelAttributes.Pitch := Fnt.Pitch;
//caBold, caColor, caFace, caItalic,
//    caSize, caStrikeOut, caUnderline, caProtected

    RichEdit.SelAttributes.Size := Fnt.Size;
    RichEdit.SelAttributes.Style := Fnt.Style;
  end;
end;

end.
