unit pLMDStatusBarEditorDlg;
{$I lmdcmps.Inc}
interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, lmdclass, 
  LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDWndProcComponent, LMDSimpleLabel,
  LMDCustomComponent, LMDBaseControl;

{ DBState, Caps, Num, Scroll, DateTime
Text (hint), DBState, Caps, Num, Scroll, DateTime
DBState, DateTime
}

type
  TLMDStatusBarEditorDlg = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ListBox: TListBox;
    LMDSimpleLabel1: TLMDSimpleLabel;
    procedure ListBoxDblClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

{$R *.DFM}

procedure TLMDStatusBarEditorDlg.ListBoxDblClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

end.
 
