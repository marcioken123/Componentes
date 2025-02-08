unit LMDPrintTemplateEditDlg;
{$I lmdcmps.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdActns, ImgList, ComCtrls, StdCtrls, ActnList,
  ToolWin, LMDPrinter, LMDTypes, Menus, ExtCtrls
  ;

type
  TLMDTemplateEditDialog = class(TForm)
    RichEdit: TRichEdit;
    ToolBar1: TToolBar;
    ActionList1: TActionList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ImageList1: TImageList;
    ToolButton4: TToolButton;
    btnBold: TToolButton;
    actUndo: TAction;
    btnItalic: TToolButton;
    ToolButton7: TToolButton;
    actFileOpen: TAction;
    actFileSaveAs: TAction;
    actBold: TAction;
    actItalic: TAction;
    actUnderline: TAction;
    btnUndeline: TToolButton;
    ToolButton9: TToolButton;
    actAlignLeft: TAction;
    actAlignCenter: TAction;
    actAlignRight: TAction;
    btnLeft: TToolButton;
    btnCenter: TToolButton;
    btnRight: TToolButton;
    ToolButton13: TToolButton;
    btnFont: TToolButton;
    actFontEdit: TAction;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    FontDialog: TFontDialog;
    ToolButton15: TToolButton;
    TemplatesPopup: TPopupMenu;
    Panel1: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    procedure FormCreate(Sender: TObject);
    procedure actRichUpdate(Sender: TObject);
    procedure actUndoExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure actFileSaveAsExecute(Sender: TObject);
    procedure actBoldExecute(Sender: TObject);
    procedure actItalicExecute(Sender: TObject);
    procedure actUnderlineExecute(Sender: TObject);
    procedure actAlignLeftExecute(Sender: TObject);
    procedure actAlignCenterExecute(Sender: TObject);
    procedure actAlignRightExecute(Sender: TObject);
    procedure actFontEditExecute(Sender: TObject);
    procedure RichEditSelectionChange(Sender: TObject);
    procedure RichEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure TemplOnClick(Sender: TObject);
    procedure UpdateStatus;
  public
    { Public declarations }
  end;

var
  LMDTemplateEditDialog: TLMDTemplateEditDialog;

  function LMDPrintExecTemplateDlg(ACaption:  TLMDString;
                                   ATemplateLines: TStrings): Boolean;

implementation
uses
  Math, Types, Variants,
  LMDPrintConst;

var TemplateDescrs: array[0..2] of TLMDString;

const TemplateTempls: array[0..2] of TLMDString = (
      '[Page]',
      '[PagesCount]',
      '[Title]');

{$R *.dfm}

procedure AssignRich(Rich1, Rich2: TStrings);
var
  st: TMemoryStream;
begin
  st := TMemoryStream.Create;
  try
    Rich2.SaveToStream(st);

    st.Position := 0;
    Rich1.LoadFromStream(st);
  finally
    st.Free;
  end;
end;

function LMDPrintExecTemplateDlg(ACaption:  TLMDString;
                                 ATemplateLines: TStrings): Boolean;
var
    Dlg: TLMDTemplateEditDialog;
begin
  Dlg := TLMDTemplateEditDialog.Create(nil);
  try
    Dlg.Caption := ACaption;

    AssignRich(Dlg.RichEdit.Lines, ATemplateLines);

    Result := Dlg.ShowModal=mrOk;
    if Result then
      AssignRich(ATemplateLines, Dlg.RichEdit.Lines);
  finally
    Dlg.Free;
  end;
end;

procedure TLMDTemplateEditDialog.FormCreate(Sender: TObject);
var
    itm: TMenuItem;
    i: Integer;
begin
  btnOk.Caption := SLMDPrintTemplateEditOk;
  btnCancel.Caption := SLMDPrintTemplateEditCancel;
  actUndo.Caption := SLMDPrintTemplateEditUndo;
  actFileOpen.Caption := SLMDPrintTemplateEditFileOpen;
  actFileSaveAs.Caption := SLMDPrintTemplateEditFileSaveAs;
  actBold.Caption := SLMDPrintTemplateEditBold;
  actItalic.Caption := SLMDPrintTemplateEditItalic;
  actUnderline.Caption := SLMDPrintTemplateEditUndeline;
  actAlignLeft.Caption := SLMDPrintTemplateEditAlignLeft;
  actAlignCenter.Caption := SLMDPrintTemplateEditAlignCenter;
  actAlignRight.Caption := SLMDPrintTemplateEditAlignRight;
  actFontEdit.Caption := SLMDPrintTemplateEditFont;

  for i := Low(TemplateDescrs) to High(TemplateDescrs) do
  begin
    itm := TMenuItem.Create(self);
    itm.Tag := Variant(Ord(i));
    itm.Caption := TemplateDescrs[Integer(itm.Tag)];
    itm.OnClick := TemplOnClick;
    TemplatesPopup.Items.Add(itm);
  end;

  RichEdit.SelAttributes.Assign(RichEdit.Font);
end;

procedure TLMDTemplateEditDialog.TemplOnClick(Sender: TObject);
var
    itm: TMenuItem;
begin
  itm := Sender as TMenuItem;
  Assert(Integer(itm.Tag) <= High(TemplateTempls));

  RichEdit.SelText := TemplateTempls[Integer(itm.Tag)];
  MouseCapture := true;
  MouseCapture := false;  
end;

procedure TLMDTemplateEditDialog.actRichUpdate(Sender: TObject);
begin
  UpdateStatus;
end;

procedure TLMDTemplateEditDialog.actUndoExecute(Sender: TObject);
begin
  RichEdit.Undo;
  UpdateStatus;  
end;

procedure TLMDTemplateEditDialog.actFileOpenExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
    RichEdit.Lines.LoadFromFile(OpenDialog.FileName);

  UpdateStatus;
end;

procedure TLMDTemplateEditDialog.actFileSaveAsExecute(Sender: TObject);
begin
  if SaveDialog.Execute then
    RichEdit.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TLMDTemplateEditDialog.actBoldExecute(Sender: TObject);
begin
  if fsBold in RichEdit.SelAttributes.Style then
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style - [fsBold]
  else
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style + [fsBold];

  UpdateStatus;
end;

procedure TLMDTemplateEditDialog.actItalicExecute(Sender: TObject);
begin
  if fsItalic in RichEdit.SelAttributes.Style then
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style - [fsItalic]
  else
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style + [fsItalic];

  UpdateStatus;
end;

procedure TLMDTemplateEditDialog.actUnderlineExecute(Sender: TObject);
begin
  if fsUnderline in RichEdit.SelAttributes.Style then
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style - [fsUnderline]
  else
    RichEdit.SelAttributes.Style := RichEdit.SelAttributes.Style + [fsUnderline];

  UpdateStatus;
end;

procedure TLMDTemplateEditDialog.actAlignLeftExecute(Sender: TObject);
begin
  RichEdit.Paragraph.Alignment := taLeftJustify;
  UpdateStatus;  
end;

procedure TLMDTemplateEditDialog.actAlignCenterExecute(Sender: TObject);
begin
  RichEdit.Paragraph.Alignment := taCenter;
  UpdateStatus;
end;

procedure TLMDTemplateEditDialog.actAlignRightExecute(Sender: TObject);
begin
  RichEdit.Paragraph.Alignment := taRightJustify;
  UpdateStatus;
end;

procedure TLMDTemplateEditDialog.actFontEditExecute(Sender: TObject);
var
    Fnt: TFont;
begin
  FontDialog.Font.Assign(RichEdit.SelAttributes);
  if FontDialog.Execute then
  begin
    Fnt := FontDialog.Font;

    RichEdit.SelAttributes.Charset := Fnt.Charset;
    RichEdit.SelAttributes.Color := Fnt.Color;
    RichEdit.SelAttributes.Name := Fnt.Name;
    RichEdit.SelAttributes.Pitch := Fnt.Pitch;

    RichEdit.SelAttributes.Size := Fnt.Size;
    RichEdit.SelAttributes.Style := Fnt.Style;

    UpdateStatus;
  end;
end;

procedure TLMDTemplateEditDialog.RichEditSelectionChange(Sender: TObject);
begin
  UpdateStatus;
end;

procedure TLMDTemplateEditDialog.RichEditKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Close;
  end;
end;

procedure TLMDTemplateEditDialog.UpdateStatus;
var
    St: TFontStyles;
    Al: TAlignment;
    En: Boolean;
begin
  St := RichEdit.SelAttributes.Style;

  actBold.Checked := fsBold in St;
  actItalic.Checked := fsItalic in St;
  actUnderline.Checked := fsUnderline in St;

  Al := RichEdit.Paragraph.Alignment;

  actAlignLeft.Checked   := Al=taLeftJustify;
  actAlignCenter.Checked := Al=taCenter;
  actAlignRight.Checked  := Al=taRightJustify;

  En := (ActiveControl=RichEdit) and RichEdit.CanUndo;
  if (En<>actUndo.Enabled) then
    actUndo.Enabled := En;
end;

initialization

  TemplateDescrs[0] := SLMDPrintTemplateEditTemplPage;
  TemplateDescrs[1] := SLMDPrintTemplateEditTemplPagesCount;
  TemplateDescrs[2] := SLMDPrintTemplateEditTemplDocName;

end.
