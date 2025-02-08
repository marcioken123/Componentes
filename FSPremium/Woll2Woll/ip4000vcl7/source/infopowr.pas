unit Infopowr;
{
//
// Components : Registration for InfoPower
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
//
// 10/12/98 - Register property editor's for ControlType in record view
// 2/24/98 - Register Selected property instead of just TStringList so that
//           all inherited controls won't use the InfoPower select fields dialog.
}
{$i wwIfDef.pas}
interface
   uses windows, Classes,
       {$ifdef wwdelphi6up}
       designintf,
       {$else}
       dsgnintf,
       {$endif}
        wwDBGrid, wwTable, wwmemo, wwdblook, wwidlg, wwdbdlg, wwprpedt, wwquery,
        wwkeycb, dbtables, wwdotdot, wwdatsrc, db, wwqbe, wwlocate, wwdbcomb,
        wwdbspin, wwdbedit, wwfltdlg, wwintl, wwstorep, wwprpds, wwdbigrd,
        {$ifdef wwDelphi6Up}
//        ToolIntf, ExptIntf,
        {$else}
        ToolIntf, ExptIntf,
        {$endif}
        ipAbout, forms, wwdatainspector, wwInspectorPrpEdt, controls,
        comctrls, wwriched, wwDBNavigator, wwDBNavEdt,
        wwmonthcalendar, wwdbdatetimepicker,
//        {$ifdef wwDelphi5Up}
//        wwrichedspell,
//        {$endif}
        wwrcdvw, wwrcdpnl, buttons, dialogs, Registry,
        wwcheckbox, wwradiobutton, wwradiogroup;
procedure Register;

implementation
{$ifdef win32}
{$R INFO32.RES}
{$else}
{$R INFO16.RES}
{$endif}

uses wwcommon;

procedure Register;
begin
  RegisterComponents('IP Access', [TwwDataSource]);
  RegisterComponents('IP Access', [TwwTable]);
  RegisterComponents('IP Access', [TwwQuery]);
  RegisterComponents('IP Access', [TwwStoredProc]);
  RegisterComponents('IP Access', [TwwQBE]);
  RegisterComponents('IP Controls', [TwwDBGrid]);
  RegisterComponents('IP Controls', [TwwDBNavigator]);
  RegisterComponents('IP Controls', [TwwDBEdit]);
  RegisterComponents('IP Controls', [TwwDBComboBox]);
  RegisterComponents('IP Controls', [TwwDBSpinEdit]);
  RegisterComponents('IP Controls', [TwwDBComboDlg]);
  RegisterComponents('IP Controls', [TwwDBLookupCombo]);
  RegisterComponents('IP Controls', [TwwDBLookupComboDlg]);
  RegisterComponents('IP Controls', [TwwKeyCombo]);
  RegisterComponents('IP Controls', [TwwIncrementalSearch]);
  RegisterComponents('IP Controls', [TwwDBRichEdit]);
  RegisterComponents('IP Controls', [TwwDBMonthCalendar]);
  RegisterComponents('IP Controls', [TwwDBDateTimePicker]);
  RegisterComponents('IP Controls', [TwwCheckBox]);
  RegisterComponents('IP Controls', [TwwExpandButton]);
//  RegisterComponents('IP Controls', [TwwRadioButton]);
//  RegisterComponents('IP Controls', [TwRadioGroup]);
  RegisterComponents('IP Controls', [TwwRadioGroup]);

  RegisterComponents('IP Dialogs', [TwwMemoDialog]);
  RegisterComponents('IP Dialogs', [TwwSearchDialog]);
  RegisterComponents('IP Dialogs', [TwwLocateDialog]);
  RegisterComponents('IP Dialogs', [TwwLookupDialog]);
  RegisterComponents('IP Dialogs', [TwwFilterDialog]);
  RegisterComponents('IP Dialogs', [TwwRecordViewDialog]);
  RegisterComponents('IP Dialogs', [TwwIntl]);
  RegisterComponents('IP Controls', [TwwRecordViewPanel]);
  RegisterComponents('IP Controls', [TwwDataInspector]);

  RegisterComponentEditor(TwwDBGrid, TwwDBGridComponentEditor);

  RegisterComponentEditor(TwwDBNavigator, TwwDBNavigatorEditor);
  {$ifdef wwDelphi6Up}
  RegisterComponentEditor(TwwNavButton, TwwNavButtonEditor);
  {$endif}

  RegisterPropertyEditor(TypeInfo(TwwNavButtons), TwwDBNavigator, '', TwwDBNavigatorButtonsEditor);

  { 9/2/98 - Only register for specific properties (ControlType and Selected) }
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwDBGrid, 'ControlType', TSelectedFieldsProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwDBGrid, 'PictureMasks', TSelectedFieldsProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwDBGrid, 'Selected', TSelectedFieldsProperty);

  RegisterPropertyEditor(TypeInfo(TwwDBPicture),
                         TwwCustomMaskEdit, '', TwwPictureProperty);
  RegisterPropertyEditor(TypeInfo(TwwDBPicture),
                         TwwInspectorItem, 'Picture', TwwObjPictureProperty);
  RegisterPropertyEditor(TypeInfo(String),
                         TwwIncrementalSearch, 'PictureMask', TwwPicturePropertyGen);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwDBCustomLookupCombo, 'Selected', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwRecordViewDialog, 'Selected', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwDataInspector, 'Selected', TwwDBLookupDisplayProperty);
//  RegisterPropertyEditor(TypeInfo(TStrings),
//                         TwwDataInspector, 'ControlType', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwRecordViewDialog, 'ControlType', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwRecordViewDialog, 'PictureMasks', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwRecordViewPanel, 'Selected', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwRecordViewPanel, 'ControlType', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwRecordViewPanel, 'PictureMasks', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwCustomLookupDialog, 'Selected', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwCustomLookupDialog, 'ControlType', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwCustomLookupDialog, 'PictureMasks', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TwwTableDisplayType),
                         TDataSet, 'PictureMasks', TwwTableDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TwwTableDisplayType),
                         TDataSet, 'ControlType', TwwTableDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TwwTableDisplayType),
                         TwwTable, 'LookupFields', TwwTableDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TwwTableDisplayType),
                         TwwTable, 'LookupLinks', TwwTableDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TwwTableDisplayType),
                         TwwQuery, 'LookupFields', TwwTableDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TwwTableDisplayType),
                         TwwQuery, 'LookupLinks', TwwTableDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TwwTableDisplayType),
                         TwwQBE, 'LookupFields', TwwTableDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TwwTableDisplayType),
                         TwwQBE, 'LookupLinks', TwwTableDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TwwTableDisplayType),
                         TwwStoredProc, 'LookupFields', TwwTableDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TwwTableDisplayType),
                         TwwStoredProc, 'LookupLinks', TwwTableDisplayProperty);

  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwDBComboBox, 'Items', TwwComboItemsProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwInspectorPickList, 'Items', TwwComboItemsProperty);
  RegisterPropertyEditor(TypeInfo(TwwDBPicture),
                         TwwDBEdit, 'Picture', TwwPictureProperty);

  RegisterPropertyEditor(TypeInfo(String),
                         TwwDBLookupCombo, 'LookupField', TwwIndexFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),
                         TwwDBLookupComboDlg, 'LookupField', TwwIndexFieldProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwDBLookupComboDlg, 'ControlType', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwDBLookupComboDlg, 'PictureMasks', TwwDBLookupDisplayProperty);
  RegisterPropertyEditor(TypeInfo(String),
                         TwwLocateDialog, 'SearchField', TwwSearchFieldProperty);
  RegisterPropertyEditor(TypeInfo(String),
                         TwwFilterDialog, 'DefaultField', TwwSearchFieldProperty);
  RegisterPropertyEditor(TypeInfo(TDataSet),
                         TwwdBCustomLookupCombo, 'LookupTable', TwwDataSetProperty);
  RegisterPropertyEditor(TypeInfo(TwwTable),
                         TwwCustomLookupDialog, '', TwwTableProperty);

  RegisterPropertyEditor(TypeInfo(String), TwwInspectorItem, 'Caption',
                         TwwMultiLineStringProperty);

  RegisterPropertyEditor(TypeInfo(TDataSet),
                         TwwDataSource, 'DataSet', TwwDataSetProperty);
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwFilterDialog, 'SelectedFields', TwwFilterFieldsProperty);
  {$ifdef win32}
  RegisterPropertyEditor(TypeInfo(TStrings),
                         TwwCustomRichEdit, 'Lines', TwwRichEditItemsProperty);
  {$endif}
  RegisterPropertyEditor(TypeInfo(TSpeedButton),
                         TwwDBGrid, 'IndicatorButton', TwwGridIndicatorProperty);

  RegisterComponentEditor(TwwDBLookupCombo, TwwDBLookupDisplayComponentEditor);
  RegisterComponentEditor(TwwDBLookupComboDlg, TwwDBLookupDisplayComponentEditor);
  RegisterComponentEditor(TwwLookupDialog, TwwDBLookupDisplayComponentEditor);
  RegisterComponentEditor(TwwSearchDialog, TwwDBLookupDisplayComponentEditor);
  {$ifdef win32}
  RegisterComponentEditor(TwwCustomRichEdit, TwwRichEditComponentEditor);
  {$endif}
  RegisterComponentEditor(TwwDataInspector, TwwObjectViewComponentEditor);
  RegisterPropertyEditor(TypeInfo(TWinControl), TwwInspectorItem,
          'CustomControl', TwwCustomEditPropertyEditor);
  RegisterPropertyEditor(TypeInfo(String), TwwInspectorItem,
          'DataField', TwwDataFieldEditor);
  RegisterComponentEditor(TwwRecordViewPanel, TwwRecordViewPanelComponentEditor);
  RegisterComponentEditor(TwwRecordViewDialog, TwwRecordViewComponentEditor);
  RegisterClass(TwwIButton);

  {$ifdef ver100} { Delphi 3 only }
  {$ifndef ver110}
  RegisterPropertyEditor(TypeInfo(TIndexDefs), TDataset,
                         'IndexDefs', TwwIndexDefsProperty);
  {$endif}
  {$endif}
  RegisterPropertyEditor(TypeInfo(TwwInspectorCollection), TwwInspectorItem,
                         'Items', TwwInspectorItemsProperty);
  RegisterPropertyEditor(TypeInfo(TwwInspectorCollection), TwwDataInspector,
                         'Items', TwwInspectorCollectionEditor);

  RegisterComponentEditor(TwwCheckbox, TwwComponentEditor);
  RegisterComponentEditor(TwwRadiogroup, TwwComponentEditor);
  RegisterComponentEditor(TwwDBEdit, TwwComponentEditor);
  RegisterComponentEditor(TwwDBComboDlg, TwwComponentEditor);
  RegisterComponentEditor(TwwDBSpinEdit, TwwComponentEditor);
  RegisterComponentEditor(TwwDBDateTimePicker, TwwComponentEditor);
  RegisterComponentEditor(TwwKeyCombo, TwwComponentEditor);
  RegisterComponentEditor(TwwIncrementalSearch, TwwComponentEditor);
  RegisterComponentEditor(TwwMonthCalendar, TwwComponentEditor);
  RegisterComponentEditor(TwwIntl, TwwComponentEditor);
  RegisterComponentEditor(TwwFilterDialog, TwwComponentEditor);
  RegisterComponentEditor(TwwLocateDialog, TwwComponentEditor);
  RegisterComponentEditor(TwwMemoDialog, TwwComponentEditor);

end;

(*
type
  TMenuClickClass = class
    class procedure AboutInfoPowerClick(Sender: TIMenuItemIntf);
    class procedure ContentsInfoPowerClick(Sender: TIMenuItemIntf);
    class procedure TopicsInfoPowerClick(Sender: TIMenuItemIntf);
  end;

class procedure TMenuClickClass.AboutInfoPowerClick(Sender: TIMenuItemIntf);
var ipReg: TRegIniFile;
    ARegNumber: string;
begin
  ipreg := TRegIniFile.create('');
  ARegNumber := ipreg.ReadString('\Software\Woll2Woll\InfoPower', 'Reg. No.', '');
  ipreg.Free;
  with TIPAboutForm.create(nil) do begin
    AVersion:= 'Version: ' + wwInternational.VersionInfoPower;
    ARegistration:= 'Reg. No.: ' + ARegNumber;
    ShowModal;
    Free;
  end;
end;

class procedure TMenuClickClass.ContentsInfoPowerClick(Sender: TIMenuItemIntf);
begin
   wwHelp(Application.Handle, 'InfoPower Contents');
end;

class procedure TMenuClickClass.TopicsInfoPowerClick(Sender: TIMenuItemIntf);
begin
   {$ifdef ver120}
   WinHelp(Application.Handle, 'IP50D4.HLP', HELP_FINDER, 0);
   {$endif}
   {$ifdef ver125}
   WinHelp(Application.Handle, 'IP50C4.HLP', HELP_FINDER, 0);
   {$endif}
   {$ifdef ver130}
   WinHelp(Application.Handle, 'IP50D5.HLP', HELP_FINDER, 0);
   {$endif}
end;


procedure AddMenuItem;
var Menu: TIMainMenuIntf;
    MenuItem: TIMenuItemIntf;
    InfoPowerMenu : TIMenuItemIntf;
    i, HelpMenuIndex: Integer;
    ipReg: TRegIniFile;
    ADisableIPMenu: string;
begin
  ipreg := TRegIniFile.create('');
  ADisableIPMenu := ipreg.ReadString('\Software\Woll2Woll\InfoPower', 'DisableMenu', 'False');
  ipreg.Free;
  if ADisableIPMenu = 'True' then exit;

  Menu := ToolServices.GetMainMenu;
  MenuItem := Menu.GetMenuItems;

  HelpMenuIndex:= -1;
  for i := 0 to MenuItem.GetItemCount - 1 do
    if MenuItem.GetItem(i).GetName = 'HelpMenu' then
      HelpMenuIndex := i;

  if HelpMenuIndex=-1 then exit;

  InfoPowerMenu := MenuItem.InsertItem(HelpMenuIndex, 'InfoPower', 'InfoPowerMenu', 'InfoPower', 0, 0, 0, [mfEnabled, mfVisible], nil);
  InfoPowerMenu.InsertItem(-1, '&Contents', 'IPHelpContentsItem', 'InfoPower Contents', 0, 0, 0, [mfEnabled, mfVisible], TMenuClickClass.ContentsInfoPowerClick);
  InfoPowerMenu.InsertItem(-1, '&Help Topics', 'IPHelpTopicsItem', 'InfoPower Help Topics', 0, 0, 0, [mfEnabled, mfVisible], TMenuClickClass.TopicsInfoPowerClick);
  InfoPowerMenu.InsertItem(-1, '-', 'IPSep1', '', 0, 0, 0, [mfEnabled, mfVisible], nil);
  InfoPowerMenu.InsertItem(-1, '&About', 'IPAboutItem', 'About InfoPower', 0, 0, 0 , [mfEnabled, mfVisible], TMenuClickClass.AboutInfoPowerClick);
end;

procedure DestroyMenuItem;
var i: Integer;
    MenuItem: TIMenuItemIntf;
    InfoPowerMenu: TIMenuItemIntf;
begin
  MenuItem := ToolServices.GetMainMenu.GetMenuItems;
  for i := 0 to MenuItem.GetItemCount - 1 do
    if MenuItem.GetItem(i).GetName = 'InfoPowerMenu' then
    begin
       InfoPowerMenu := MenuItem.GetItem(i);
       InfoPowerMenu.DestroyMenuItem;
       break;
    end
end;
*)

initialization
//  AddMenuItem;
finalization
//  DestroyMenuItem;
end.
