unit pLMDConfigDlg;
{$I LMDCmps.inc}

interface

uses
  Windows, ComCtrls, Classes, Graphics, Forms, Controls, Dialogs, buttons,
  StdCtrls, ExtCtrls, CheckLst, pLMDURLLabel;

type
  TLMDConfigDlg = class(TForm)
    pnlBottom: TPanel;
    ok: TButton;
    Button2: TButton;
    pnlLeft: TPanel;
    tvCategories: TTreeView;
    Panel1: TPanel;
    nb: TNotebook;
    Label4: TLabel;
    Label5: TLabel;
    globalbox: TCheckListBox;
    lblLMDSettings: TLabel;
    LMDBox: TCheckListBox;
    lblquestion: TLabel;
    lblsupport: TLMDURLLabel;
    lblsite: TLabel;
    lmdurl1: TLMDURLLabel;
    lblnews: TLabel;
    lmdurl2: TLMDURLLabel;
    Bevel1: TBevel;
    Panel2: TPanel;
    lblPageTitle: TLabel;
    lblversion: TLabel;
    lblversionExt: TLabel;
    lbldesc: TLabel;
    lblcopyright: TLabel;
    bv: TBevel;
    LMDSysURLLabel1: TLMDURLLabel;
    lblComponent: TLabel;
    btnReg: TButton;
    Label2: TLabel;
    lblvnumber: TLabel;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnRegClick(Sender: TObject);
    procedure nbPageChanged(Sender: TObject);
    procedure tvCategoriesChange(Sender: TObject; Node: TTreeNode);
    procedure okClick(Sender: TObject);
  private
    FApp: String;
  end;

implementation

uses
  SysUtils, Registry, ShellAPI, TypInfo, Clipbrd, intfLMDBase, pLMDCst,
  pLMDCommon, LMDTypes, LMDProcs;

{$R *.DFM}

{------------------------------------------------------------------------------}
procedure TLMDConfigDlg.FormCreate(Sender: TObject);
var
  tmp:  TLMDDsgnGlobalEditorOptions;
  i:    TLMDDsgnGlobalEditorOption;
  tmp1: TLMDToolsEditorOptions;
  j:    TLMDToolsEditorOption;
begin
  Caption := sLMDSharedName + ' Settings';
  lblVersion.Caption := sLMDPackageName;
  bv.Width := lblVersion.Width + 3;
  lblvnumber.Caption := 'Common Runtime Version: '+
                        LMDPackageInfo[pi_LMD_TOOLS].Version+' ('+
                        LMDPackageInfo[pi_LMD_TOOLS].ReleaseDate+')';

  tmp  := LMDGLOBALEDITOROPTIONS;
  tmp1 := LMDTOOLSEDITOROPTIONS;

  for i := Low(TLMDDsgnGlobalEditorOption) to High(TLMDDsgnGlobalEditorOption) do
  begin
    if i in tmp then
      globalbox.Checked[Ord(i)] := True;
  end;

  for j := Low(TLMDToolsEditorOption) to High(TLMDToolsEditorOption) do
  begin
    if j in tmp1 then
      LMDBox.Checked[Ord(j)] := True;
  end;

  // Find and check registration utility
  FApp:=LMDSystemDirectory+'\'+LMDTOOLS_APPNAME+'.exe';

  btnReg.Visible:=FileExists(FApp);
  try    //.net debug purposes only
    lblsupport.Jump:='mailto:mail@lmdsupport.com?subject='+sLMDPackageName+'%20Support';
  except //.net debug purposes only
  end;   //.net debug purposes only

  // Categories
  tvCategories.Items[0].Expanded := True;
  tvCategories.Items[1].Selected := True;

  {$IFDEF LMDCOMP7}
  Panel2.ParentBackground := False;
  {$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDConfigDlg.btnRegClick(Sender: TObject);
begin
  ShellExecute(0, 'open', PChar(FApp), nil, nil, SW_SHOWNORMAL)
end;

{------------------------------------------------------------------------------}
procedure TLMDConfigDlg.nbPageChanged(Sender: TObject);
begin
  lblPageTitle.Caption := nb.ActivePage;
end;

{------------------------------------------------------------------------------}
procedure TLMDConfigDlg.tvCategoriesChange(Sender: TObject; Node: TTreeNode);
begin
 if Assigned(Node) then
   nb.ActivePage := Node.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDConfigDlg.okClick(Sender: TObject);
var
  i, j, tmp, tmp1: Integer;
begin
  tmp  := 0;
  tmp1 := 0;

  for i := 0 to globalbox.Items.count-1 do
    if globalbox.Checked[i] then
      tmp := tmp + (1 shl i);

  for j := 0 to LMDBox.Items.count-1 do
    if LMDBox.Checked[j] then
      tmp1 := tmp1 + (1 shl j);

  with TRegIniFile.Create(LMDTOOLS_REGISTRYPATH) do
  try
    WriteInteger('Shared', 'EditorOptions', tmp);
    WriteInteger('Shared', 'LMDOptions', tmp1);
  finally
    Free;
  end;

  LMDDsgnRefreshOptions;
end;

initialization
  RegisterClass(TLMDUrlLabel);
end.
