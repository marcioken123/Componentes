program RANotepad;

uses
  Forms,
  fMain in 'fMain.pas' {Main},
  fParams in 'fParams.pas' {ParamsForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
