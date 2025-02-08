unit pLMDSendKeyEditorDlg;
{$I lmdcmps.Inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, LMDCustomComponent, LMDSendKeys, LMDCustomScrollBox,
  LMDListBox, ComCtrls, LMDCustomControl, LMDCustomPanel, LMDClass,
  LMDCustomBevelPanel, LMDBaseEdit, LMDCustomMemo, LMDMemo,
  LMDBaseGraphicControl, LMDBaseLabel, LMDThemes,
  LMDCustomSimpleLabel, LMDCustomDockLabel, LMDDockLabel, LMDIniCtrl,
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, LMDControl, LMDBaseControl;

type
  TLMDSendKeysEditorDlg = class(TForm)
    Button1: TButton;
    Close: TButton;
    window: TPageControl;
    keys: TTabSheet;
    Windows: TTabSheet;
    lb2: TLMDListBox;
    lb: TListBox;
    Update: TButton;
    Macro: TGroupBox;
    m: TLMDMemo;
    wnd: TEdit;
    LMDDockLabel1: TLMDDockLabel;
    LMDDockLabel2: TLMDDockLabel;
    Button3: TButton;
    dlg: TOpenDialog;
    last: TLMDCheckBox;
    ini: TLMDIniCtrl;
    sk: TLMDSendKeys;
    procedure Button1Click(Sender: TObject);
    procedure CloseClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure UpdateClick(Sender: TObject);
    procedure lbDblClick(Sender: TObject);
    procedure lb2DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation
uses
  pLMDPECst, pLMDCst, LMDTypes;

{$R *.DFM}
var
  glb:TListBox;

function EnumerateWindows(hWnd: HWND; lParam: LPARAM): BOOL; stdcall;
var
   tmp:array[0..255] of char;  // this holds the window text
   begin
   if (GetWindowText(hWnd, tmp, 255)<>0) then
     glb.Items.Add(tmp);
   result:=True;
end;

procedure TLMDSendKeysEditorDlg.Button1Click(Sender: TObject);
begin
  dlg.Filename:='*.exe';
  if dlg.execute then
    if sk.shell(dlg.filename) then
      begin
        wnd.Text:=sk.Caption;
        UpdateClick(nil);
      end
    else
      wnd.Text:='';
end;

procedure TLMDSendKeysEditorDlg.CloseClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TLMDSendKeysEditorDlg.Button3Click(Sender: TObject);
begin
  sk.AppActivate(wnd.Text);
  sk.SendKeys(m.Text, false);
end;

procedure TLMDSendKeysEditorDlg.FormCreate(Sender: TObject);
begin
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
  ini.RegPath:=LMDTOOLS_REGISTRYPATH;
  last.Checked:=ini.ReadBool('TLMDSendKey', 'LoadLast', false);
  if last.Checked then
    if sk.shell(ini.ReadString('TLMDSendKey', 'Filename', '')) then wnd.Text:=sk.Caption;
  glb:=lb;
  UpdateClick(nil);
end;

procedure TLMDSendKeysEditorDlg.UpdateClick(Sender: TObject);
begin
  lb.Items.Clear;
  EnumWindows(@EnumerateWindows,0);
end;

procedure TLMDSendKeysEditorDlg.lbDblClick(Sender: TObject);
begin
  if lb.ItemIndex<>-1 then
    begin
      wnd.Text:=lb.Items[lb.ItemIndex];
      m.SetFocus;
    end;
end;

procedure TLMDSendKeysEditorDlg.lb2DblClick(Sender: TObject);
begin
  if lb2.ItemIndex<>-1 then
    begin
      m.Insert(m.SelStart, lb2.ItemPart(lb2.ItemIndex, 0));
      m.SetFocus;
    end;
end;

procedure TLMDSendKeysEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ini.WriteBool('TLMDSendKey', 'LoadLast', Last.Checked);
  if last.Checked then
    ini.WriteString('TLMDSendKey', 'FileName', sk.Filename)
  else
    ini.WriteString('TLMDSendKey', 'FileName', '');
end;

end.
