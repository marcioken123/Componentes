unit pLMDSysViewDlg;
{$I LMDCmps.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, LMDSysBase, LMDSysNetworkEnumerator, LMDSysTreeView,
  LMDSysNetTreeView, LMDSysInfoListView, ExtCtrls, LMDSysInfoTreeView;

type
  TfrmLMDSysViewDlg = class(TForm)
    lv: TLMDSysInfoListView;
    Panel1: TPanel;
    btnClose: TButton;
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
 end;

implementation

{$R *.DFM}

procedure TfrmLMDSysViewDlg.FormDestroy(Sender: TObject);
begin
  lv.SysInfoControl:=nil;
end;

end.
