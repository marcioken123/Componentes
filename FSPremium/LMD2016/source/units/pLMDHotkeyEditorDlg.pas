unit pLMDHotkeyEditorDlg;
{$I lmdcmps.Inc}
interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ComCtrls;

type
  TLMDfrmHotkeyEditor = class(TForm)
    LMDGroupBox1: TGroupBox;
    LMDSimpleLabel1: TLabel;
    Button1: TButton;
    Button2: TButton;
    edHotkey: THotKey;
  private
  public
  end;

implementation

{$R *.DFM}

end.
 
