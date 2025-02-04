program Project5;
uses
  Forms,
  Unit5 in 'Unit5.pas' {Form1},
  Unit6a in 'Unit6a.pas' {Form2};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
  Application.CreateForm(TForm1, Form1);
end.


