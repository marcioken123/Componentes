unit pLMDSysCheckListDlg;
{$I LMDCmps.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CheckLst;

type
  TfrmLMDSysOptionsEditor = class(TForm)
    lb: TCheckListBox;
    btnOK: TButton;
    btnCancel: TButton;
    btnSelectAll: TButton;
    btnSelectNone: TButton;
    procedure btnSelectAllClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure SetValues(aValue: TCollection);
  end;

implementation

{$R *.DFM}

procedure TfrmLMDSysOptionsEditor.SetValues(aValue: TCollection);
begin
end;

procedure TfrmLMDSysOptionsEditor.btnSelectAllClick(Sender: TObject);
var
  i:Integer;
  tmp:Boolean;
begin
  tmp:=sender=btnSelectAll;
  for i:=0 to lb.Items.Count-1 do
    lb.Checked[i]:=tmp;
end;

end.
