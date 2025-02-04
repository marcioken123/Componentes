program RAdOctober4;

uses
  ShareMem,
  Forms,
  Dialogs,
  Classes,
  SysUtils,
  RAUtils,
  fRAFDAppBuilder,
  fSplash in 'fSplash.pas' {Splash},
  RAFDCompat in 'designer\RAFDCompat.pas';

{$R *.RES}

var
  RAAppBuilder: TRAAppBuilder;
begin
  RAFDDebug := HasSwitch('Debug');
  Application.Initialize;
  RAAppBuilder := TRAAppBuilder.Create(Application);
  RAAppBuilder.CreateAppBuilderWindow;
  Application.Title := 'RAd October 0.2';
  Application.Icon := AppBuilder.Icon;
  ShowSplash;
  RAAppBuilder.IniFile := ChangeFileExt(Application.ExeName, '.ini');
  RAAppBuilder.Execute;
  HideSplash;
  Application.Run;
  RAAppBuilder.Free;
end.
