unit pLMDMaskEditorDlg;
{$I lmdcmps.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  LMDClass, LMDEdit, LMDCustomButton, LMDCustomScrollBox, LMDListBox,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel,
  LMDWndProcComponent, LMDBackPanel, LMDButton, LMDCustomComponent, LMDBaseEdit,
  LMDCustomEdit, LMDCustomControl, LMDThemes, LMDControl;

type
  TLMDfrmMaskEditDlg = class(TForm)
    LMDBackPanel1: TLMDBackPanel;
    MaskListBox: TLMDListBox;
    LMDButton1: TLMDButton;
    LMDButton2: TLMDButton;
    MaskEdit: TLMDEdit;
    procedure MaskListBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

procedure TLMDfrmMaskEditDlg.FormCreate(Sender: TObject);
begin
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

procedure TLMDfrmMaskEditDlg.MaskListBoxClick(Sender: TObject);
begin
  MaskEdit.Text := Copy (MaskListBox.Items[MaskListBox.ItemIndex], 1, Pos ('|', MaskListBox.Items[MaskListBox.ItemIndex])-1);
end;

end.
 
