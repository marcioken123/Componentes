unit richlabelu;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, wwriched;

type
  TRichLabelDemo = class(TForm)
    RichLabelDemo: TwwDBRichEdit;
    wwDBRichEdit2: TwwDBRichEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RichLabelDemo: TRichLabelDemo;

implementation

{$R *.DFM}

end.
