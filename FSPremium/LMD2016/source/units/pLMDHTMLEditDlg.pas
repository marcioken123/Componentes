unit pLMDHTMLEditDlg;
{$I LMDCmps.INC}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ImgList, StdActns, ActnList, ComCtrls, Buttons,
  StdCtrls, ExtCtrls, Typinfo;

type
  TLMDGraphicControlClass = class of TGraphicControl;

  TfrmLMDMiniHTMLEditor = class(TForm)
    Panel1: TPanel;
    colordlg: TColorDialog;
    MainAct: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditDelete1: TEditDelete;
    EditUndo1: TEditUndo;
    BoldTag: TAction;
    ItalicTag: TAction;
    UnderlineTag: TAction;
    ParaTag: TAction;
    BRTag: TAction;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileExitItem: TMenuItem;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    N3: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    Delete1: TMenuItem;
    N2: TMenuItem;
    SelectAll1: TMenuItem;
    Insert1: TMenuItem;
    BoldTag1: TMenuItem;
    ItalicTag1: TMenuItem;
    UnderlineTag1: TMenuItem;
    ParaTag1: TMenuItem;
    LineBreak1: TMenuItem;
    LMDSimplePanel1: TPanel;
    LMDButton1: TButton;
    btnCancel: TButton;
    LMDSimplePanel2: TPanel;
    btnCut: TSpeedButton;
    btnCopy: TSpeedButton;
    btnPaste: TSpeedButton;
    LMDSpeedButton1: TSpeedButton;
    Strikr1: TMenuItem;
    Font1: TMenuItem;
    N4: TMenuItem;
    FontColor1: TMenuItem;
    htmledit: TMemo;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter1: TSplitter;
    SpeedButton1: TSpeedButton;
    procedure MainAction(Sender: TObject);
    procedure HTMLEditChange(Sender: TObject);
    procedure SetPreviewText;
    procedure FormShow(Sender: TObject);
  private
    FView:TGraphicControl;
    FCaptionPropInfo: PPropInfo;
  public
    procedure SetViewControlClass(aControlClass:TLMDGraphicControlClass);
  end;

var
  frmLMDMiniHTMLEditor: TfrmLMDMiniHTMLEditor;

implementation
{$R *.DFM}
uses
  Variants, Consts, ClipBrd, 
  LMDUtils, LMDProcs, LMDTypes;

{ ---------------------------------------------------------------------------- }
function LMDColorToRGB(aValue:TColor):String;
var
  ac:LongInt;
begin
  ac:=ColorToRGB(aValue);
  result:=InttoHex(GetRValue(ac), 2)+InttoHex(GetGValue(ac), 2)+InttoHex(GetBValue(ac), 2);
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDMiniHTMLEditor.FormShow(Sender: TObject);
begin
  SetPreviewText;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDMiniHTMLEditor.MainAction(Sender: TObject);
var
  s: string;

  procedure PerformAction(const aValue:String; goback:Integer=0);
  begin
    ClipBoard.AsText:=aValue;
    HTMLEdit.PasteFromClipBoard;
    HTMLEdit.SelStart := HtmlEdit.SelStart - goback;
    HTMLEdit.SetFocus;
  end;

begin
  s := HTMLEdit.SelText;

  Case integer(TComponent(Sender).Tag) of
   20: ModalResult:=mrCancel;
  105: HTMLEdit.Undo;
  110: HTMLEdit.CutToClipboard;
  115: HTMLEdit.CopyToClipboard;
  120: HTMLEdit.PasteFromClipBoard;
  125: HTMLEdit.ClearSelection;
  130: HTMLEdit.SelectAll;
  200: PerformAction('<FONT FACE="" SIZE="">' + s + '</FONT>', 7);
  210: PerformAction('<BR>');
  215: PerformAction('<p>' + s + '</p>');

  // Format
  280: PerformAction('<B>' + s + '</B>',4);
  285: PerformAction('<I>' + s + '</I>',4);
  290: PerformAction('<U>' + s + '</U>',4);
  295: PerformAction('<S>' + s + '</S>',4);

  505: begin
          if colordlg.Execute then
            begin
              ClipBoard.AsText:='<FONT COLOR="#'+LMDColorToRGB(colorDlg.Color)+'">';
              HTMLEdit.PasteFromClipBoard;
              HTMLEdit.SetFocus;
            end;
       end;
 end;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDMiniHTMLEditor.HTMLEditChange(Sender: TObject);
begin
  if FView = nil then exit;
  SetPreviewText;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDMiniHTMLEditor.SetPreviewText;
begin
  if (FView <> nil) and (FCaptionPropInfo <> nil) then
    SetStrProp(FView, FCaptionPropInfo, HTMLEdit.Text);
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDMiniHTMLEditor.SetViewControlClass(aControlClass: TLMDGraphicControlClass);
begin
   FView:=aControlClass.Create(self);
   FView.Parent:=Panel2;
   TLabel(FView).Align:=alClient;
   FCaptionPropInfo := GetPropInfo(FView.ClassInfo, 'Caption');
end;

end.
