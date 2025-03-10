program Prjdemo;



uses
  Forms,
  Combos in '..\combos\COMBOS.PAS' {LookupForm},
  Demoloc in '..\locate\DEMOLOC.PAS' {Locate},
  Grdmemo in '..\gridmemo\GRDMEMO.PAS' {GridMemoApp},
  Isearch in '..\isrchdlg\ISEARCH.PAS' {SearchForm},
  Packdlgs in '..\tblpack\PACKDLGS.PAS' {GetTablesForm},
  Packtest in '..\tblpack\PACKTEST.PAS' {PackMain},
  Search in '..\search\SEARCH.PAS' {IncrSearch},
  Qbe in '..\qbe\QBE.PAS' {QBEForm},
  Fltevent in '..\filters\FLTEVENT.PAS' {FilterEventForm},
  GrdLook in '..\grid\GRDLOOK.PAS' {GridDemo},
  Grdbitmp in '..\GRID\GRDBITMP.PAS' {BitmapForm},
  Pictures in '..\PICMASK\PICTURES.PAS',
  Multi in '..\multidel\multi.PAS',
  FiltDlg in '..\fltdlg\filtdlg.PAS',
  Lkquery in '..\combos\lkquery.pas',
  LkDtl in '..\combos\lkdtl.pas',
  grdbttn in '..\grid\grdbttn.pas',
  rcdvw in '..\rcdvw\rcdvw.pas' {RecordViewDemoForm},
  savefilt in '..\savefilt\savefilt.pas' {SaveFilterDemo},
  selfilt in '..\savefilt\selfilt.pas' {SelectSaveFilter},
  wwsavflt in '..\savefilt\wwsavflt.pas',
  rcdpnldemo in '..\rcdpanel\rcdpnldemo.pas' {RecordPanelDemo},
  Demo in 'demo.pas' {MainDemo},
  monthcalu in '..\DtPicker\monthcalu.pas' {MonthCalendarForm},
  mnthyear in '..\DtPicker\mnthyear.pas' {YearCalendar},
  NavMany in '..\Navigator\NavMany.pas' {NavigatorForm1},
  NavigatorComb in '..\Navigator\NavigatorComb.pas' {CombinedForm},
  dtpick in '..\DtPicker\dtpick.pas' {DateTimePickerForm},
  rcdpnldemo2 in '..\rcdpanel\rcdpnldemo2.pas' {RecordViewPanelForm2},
  dbchecku in '..\framing\dbchecku.pas' {CustomFramingForm},
  DataInspectorU in '..\Inspector\DataInspectorU.pas' {DataInspectorDemo},
  GrdIniHint in '..\GRID\GrdIniHint.pas' {GridHintIniDemo},
  gridmasterdetailpanel in '..\gridmast\gridmasterdetailpanel.pas' {MasterDetailPanelForm},
  gridcontrols in '..\Grid\gridcontrols.pas' {GridControlsForm},
  inspectormulti in '..\inspector\inspectormulti.pas' {MultiInspectorForm},
  exportdemou in '..\export\exportdemou.pas' {ExportForm},
  rcdvw2 in '..\rcdvw\rcdvw2.pas' {RecordViewCustomForm},
  checkboxu in '..\checkbox\checkboxu.pas' {CheckBoxDemo},
  combodemou in '..\Combos\combodemou.pas' {ComboDemoForm},
  radiou in '..\radio\radiou.pas' {RadioDemoForm},
  formatu in '..\numerics\formatu.pas' {FormatForm},
  richlabelu in '..\richedit\richlabelu.pas' {RichLabelDemo},
  gridexpand in '..\Grid\gridexpand.pas' {GridExpandForm},
  lkcustom in '..\Combos\lkcustom.pas' {CustomComboForm},
  gridexpandpanel in '..\Grid\gridexpandpanel.pas' {FormExpandPanel},
  gridlargeedit in '..\Grid\gridlargeedit.pas' {LargeGridEditForm},
  gridmasterdetail in '..\gridmast\gridmasterdetail.pas' {MasterDetailGridForm},
  griddatagroup in '..\Grid\griddatagroup.pas' {DataGroupForm},
  converter in '..\richedit\converter.pas' {RTFImportExportForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainDemo, MainDemo);
  Application.Run;
end.
