unit pLMDRTFHyperTextEditor;
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

pLMDRTFHyperTextEditor unit (RM)
--------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, Messages, Classes, ActnList, ImgList, Controls, StdCtrls,
  ExtCtrls, ToolWin, ComCtrls,
  LMDRTFActions, LMDRTFHyperText, LMDRTFRichEdit;
  type
  { **************************  TfrmLMDRTFEditor  ************************** }
  TfrmLMDRTFHyperTextEditor = class(TForm)
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
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    actBookMarks: TAction;
    actHyperText: TAction;
    procedure LMDRichEditSelectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actBookMarksExecute(Sender: TObject);
    procedure actHyperTextExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LMDRichEditURLClick(Sender: TObject; const URLText: String;
      Button: TMouseButton);
  private
    FHyperText : TLMDRichHyperText;
    procedure WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
    procedure CheckButtons;
    procedure LinkMouseMove(Sender: TObject; const URLText: string;
                                     IsLink: Boolean);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MarkLinks;
  end;

implementation

uses
  Windows, SysUtils;

{$R *.DFM}

{ **************************  TfrmLMDRTFEditor  ************************** }
{ -------------------------------------------------------------------------- }
constructor TfrmLMDRTFHyperTextEditor.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHyperText := TLMDRichHyperText.Create;
  FHyperText.Editor := LMDRichEdit;
  LMDRichEdit.OnLinkMouseMove := LinkMouseMove;
end;

{ -------------------------------------------------------------------------- }
destructor TfrmLMDRTFHyperTextEditor.Destroy;
begin
  if assigned(FHyperText) then FHyperText.Free;
  inherited Destroy;
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFHyperTextEditor.MarkLinks;
begin
  FHyperText.Editor :=  LMDRichEdit;
  FHyperText.MarkAllLink;
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFHyperTextEditor.FormCreate(Sender: TObject);
begin
  LMDRichEditSelectionChange(Sender);
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFHyperTextEditor.LMDRichEditSelectionChange(Sender: TObject);
begin
  StatusBar1.Panels[0].Text:= Format( '%d : %d',
     [ LMDRichEdit.CursorPos.Y,  LMDRichEdit.CursorPos.X]);
  CheckButtons;
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFHyperTextEditor.CheckButtons;
begin
  actHyperText.Enabled := (LMDRichEdit.SelLength > 0)
    or FHyperText.ValidLinkSelection;
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFHyperTextEditor.actBookMarksExecute(Sender: TObject);
begin
  FHyperText.ShowBookMarksDialog;
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFHyperTextEditor.actHyperTextExecute(Sender: TObject);
begin
  FHyperText.ShowLinkDialog;
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFHyperTextEditor.FormShow(Sender: TObject);
begin
  MarkLinks;
  LMDRichEditSelectionChange(LMDRichEdit);
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFHyperTextEditor.WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo);
begin
  inherited;

  with Msg.MinMaxInfo.ptMinTrackSize do
  begin
    x := self.Constraints.MinWidth;
    y := self.Constraints.MinHeight;
  end;
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFHyperTextEditor.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if  (Shift = []) and (Key = VK_ESCAPE)  then
    Close;
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFHyperTextEditor.LinkMouseMove(Sender: TObject; const URLText: string;
                                     IsLink: Boolean);
begin
  StatusBar1.Panels[1].Text:= URLText;
end;

{ -------------------------------------------------------------------------- }
procedure TfrmLMDRTFHyperTextEditor.LMDRichEditURLClick(Sender: TObject;
  const URLText: String; Button: TMouseButton);
begin
  //  Nothing 
end;

end.

