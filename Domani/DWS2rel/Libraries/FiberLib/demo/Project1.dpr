program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FiberLibrary in '..\FiberLibrary.pas',
  DWSII_FiberLibrary in '..\DWSII_FiberLibrary.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
