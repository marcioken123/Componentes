program EditorsStylesDemo;

uses
  Forms,
  EditorsStylesDemoMain in 'EditorsStylesDemoMain.pas' {EditorsStylesDemoDemoMainForm},
  EditorsStylesDemoBase in 'EditorsStylesDemoBase.pas' {EditorsStylesDemoBaseFrame: TFrame},
  EditorsStylesDemoUtils in 'EditorsStylesDemoUtils.pas',
  EditorsStylesDemoRichEdit in 'EditorsStylesDemoRichEdit.pas' {EditorsStylesDemoRichEditFrame: TFrame},
  EditorsStylesDemoConvert in 'EditorsStylesDemoConvert.pas' {EditorsStylesDemoConvertFrame: TFrame},
  EditorsStylesDemoPlanets in 'EditorsStylesDemoPlanets.pas' {EditorsStylesDemoPlanetsFrame: TFrame},
  EditorsStylesDemoNoteBook in 'EditorsStylesDemoNoteBook.pas' {EditorsStylesDemoNoteBookFrame: TFrame},
  EditorsStylesDemoIssues in 'EditorsStylesDemoIssues.pas' {EditorsStylesDemoIssuesFrame: TFrame},
  EditorsStylesDemoStylesPalette in 'EditorsStylesDemoStylesPalette.pas' {EditorsStylesDemoStylesPaletteFrame: TFrame},
  EditorsStylesDemoFrameControl in 'EditorsStylesDemoFrameControl.pas',
  EditorsStylesDemoData in 'EditorsStylesDemoData.pas' {EditorsStylesDemoDataDM: TDataModule},
  AboutDemoForm in '..\AboutDemoForm.pas' {formAboutDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ExpressEditors Library (Extended Component Features)';
  Application.CreateForm(TEditorsStylesDemoDataDM, EditorsStylesDemoDataDM);
  Application.CreateForm(TEditorsStylesDemoDemoMainForm, EditorsStylesDemoDemoMainForm);
  Application.Run;
end.
