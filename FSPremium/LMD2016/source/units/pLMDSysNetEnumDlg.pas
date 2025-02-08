unit pLMDSysNetEnumDlg;
{$I LMDCmps.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, LMDSysBase, LMDSysNetworkEnumerator, LMDSysTreeView,
  LMDSysNetTreeView, LMDControl, LMDCustomComponent;

type
  TfrmLMDSysEnumDlg = class(TForm)
    btnUpdate: TButton;
    btnClose: TButton;
    nettv: TLMDSysNetTreeView;
    nenum: TLMDSysNetworkEnumerator;
    procedure btnUpdateClick(Sender: TObject);
  private
    { Private declarations }
  public
 end;

implementation

{$R *.DFM}

procedure TfrmLMDSysEnumDlg.btnUpdateClick(Sender: TObject);
begin
  nEnum.Refresh;
end;

end.
