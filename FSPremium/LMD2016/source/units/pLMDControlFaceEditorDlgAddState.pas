unit pLMDControlFaceEditorDlgAddState;
{$I lmdcmps.Inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LMDCustomButton, LMDButton, ComCtrls,
  LMDCustomScrollBox, LMDScrollBox, lmdsplt, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomListBox,
  LMDCustomImageListBox, LMDCustomCheckListBox, LMDCheckListBox, LMDControl;

type
  TfrmStateAddingDlg = class(TForm)
    LMDSplitterPanel1: TLMDSplitterPanel;
    LMDSplitterPane1: TLMDSplitterPane;
    LMDSplitterPane2: TLMDSplitterPane;
    LMDButton1: TButton;
    LMDButton2: TButton;
    LMDButton3: TButton;
    LMDButton4: TButton;
    notUsedStates: TLMDCheckListBox;
    procedure LMDButton1Click(Sender: TObject);
    procedure LMDButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure init (alreadyUsedStates: TStringList);
  end;

var
  frmStateAddingDlg: TfrmStateAddingDlg;

implementation

{$R *.dfm}

uses
  LMDCFCStateObject;

procedure TfrmStateAddingDlg.FormCreate(Sender: TObject);
begin
 {$IFDEF LMDCOMP11}notUsedStates.CtlXP:=true;{$ENDIF}
end;

procedure TfrmStateAddingDlg.init (alreadyUsedStates: TStringList);
var
  i: Integer;
  s: String;
begin
  for i := 0 to LMDCFCgetAvailableStatesCount - 1 do
    begin
      s := LMDCFCgetStateDescription(i);
      if alreadyUsedStates.IndexOf(s) = -1 then
        notUsedStates.Items.Add (s);
    end;
end;

procedure TfrmStateAddingDlg.LMDButton1Click(Sender: TObject);
begin
//   TreeView1.Select(nil);
  notUsedStates.CheckAll;
end;

procedure TfrmStateAddingDlg.LMDButton2Click(Sender: TObject);
begin
  notUsedStates.CheckAll(true);
end;

end.
