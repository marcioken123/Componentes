program Project1;

uses
  Forms,
  CoolUtils,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  Unit7 in 'Unit7.pas' {Form7},
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {Form6},
  Unit8 in 'Unit8.pas' {Form8},
  Unit9 in 'Unit9.pas' {Form9},
  Unit10 in 'Unit10.pas' {Form10},
  Unit11 in 'Unit11.pas' {ImagesModule: TDataModule};

{$R *.RES}

begin
  Application.Title := 'CoolControls Demonstration';

  with TForm10.Create(Application) do
  try
    Show;
    Delay(3000);
  finally
    Release;
  end;

  Application.ProcessMessages;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TImagesModule, ImagesModule);
  Application.Run;
end.
