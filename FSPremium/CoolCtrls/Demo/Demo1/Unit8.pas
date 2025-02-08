{$IFNDEF VER90}
  {$IFNDEF VER100}
    {$IFNDEF VER120}
      {$IFNDEF VER130}
        {$IFNDEF VER140}
          {$IFDEF VER110}
            {$ObjExportAll On}
            {$Define ver100}
          {$ELSE}
            {$IFDEF VER125}
              {$Define ver120}
            {$ELSE}
              {$Define ver90}
            {$ENDIF}
          {$ENDIF}
        {$ELSE}
          {$IFNDEF BCB}
            {$Define Delphi}
          {$ENDIF}
          {$Define ver120}
          {$Define ver130}
        {$ENDIF}
      {$ELSE}
        {$IFNDEF BCB}
          {$Define Delphi}
        {$ENDIF}
        {$Define ver120}
      {$ENDIF}
    {$ELSE}
      {$Define Delphi}
    {$ENDIF}
  {$ELSE}
    {$Define Delphi}
  {$ENDIF}
{$ELSE}
  {$Define Delphi}
{$ENDIF}
unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, CoolCtrls, Grids, ExtCtrls, {$IFDEF ver120} ImgList, {$ENDIF}
  CoolUtils, CoolTools, FileCtrl;

type
  TForm8 = class(TForm)
    RadioGroup2: TCoolCheckRadioGroup;
    RadioGroup3: TCoolCheckRadioGroup;
    CoolLabel1: TCoolLabel;
    CheckBox1: TCoolCheckRadioBox;
    CheckBox2: TCoolCheckRadioBox;
    CheckBox4: TCoolCheckRadioBox;
    CheckBox3: TCoolCheckRadioBox;
    CheckBox5: TCoolCheckRadioBox;
    CoolBtn4: TCoolBtn;
    CoolGroupBox1: TCoolGroupBox;
    CoolCheckRadioBox3: TCoolCheckRadioBox;
    CoolCheckRadioBox4: TCoolCheckRadioBox;
    CoolCheckRadioBox5: TCoolCheckRadioBox;
    CoolCheckRadioBox6: TCoolCheckRadioBox;
    CoolCheckRadioBox7: TCoolCheckRadioBox;
    CoolCheckRadioBox8: TCoolCheckRadioBox;
    CoolCheckRadioBox9: TCoolCheckRadioBox;
    CoolCheckRadioBox10: TCoolCheckRadioBox;
    CoolCheckRadioBox1: TCoolCheckRadioBox;
    CoolCheckRadioBox2: TCoolCheckRadioBox;
    CoolLocker1: TCoolLocker;
    CoolDesktop1: TCoolDesktop;
    CoolFormHook1: TCoolFormHook;
    Label1: TCoolLabel;
    Label2: TCoolLabel;
    Label3: TCoolLabel;
    Label4: TCoolLabel;
    Label5: TCoolLabel;
    Label6: TCoolLabel;
    Label7: TCoolLabel;
    Label8: TCoolLabel;
    Label9: TCoolLabel;
    Label10: TCoolLabel;
    Label11: TCoolLabel;
    Label12: TCoolLabel;
    DriveComboBox1: TDriveComboBox;
    CoolDisksInformant1: TCoolDisksInformant;
    CoolBtn9: TCoolBtn;
    CoolCheckRadioBox11: TCoolCheckRadioBox;
    CoolCaptionEffects1: TCoolCaptionEffects;
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
    procedure CoolBtn4Click(Sender: TObject);
    procedure CoolCheckRadioBox1Click(Sender: TObject);
    procedure CoolCheckRadioBox2Click(Sender: TObject);
    procedure CoolCheckRadioBox4Click(Sender: TObject);
    procedure CoolCheckRadioBox5Click(Sender: TObject);
    procedure CoolCheckRadioBox6Click(Sender: TObject);
    procedure CoolCheckRadioBox7Click(Sender: TObject);
    procedure CoolCheckRadioBox8Click(Sender: TObject);
    procedure CoolCheckRadioBox9Click(Sender: TObject);
    procedure CoolCheckRadioBox3Click(Sender: TObject);
    procedure CoolCheckRadioBox10Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure CoolCheckRadioBox11Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.DFM}

uses
  Unit11;

procedure TForm8.CheckBox1Click(Sender: TObject);
begin
  with CoolFormHook1 do
    if CheckBox1.Checked then
      Options := Options + [ocNoCaption] else
        Options := Options - [ocNoCaption];
end;

procedure TForm8.CheckBox2Click(Sender: TObject);
begin
  with CoolFormHook1 do
    if CheckBox2.Checked then
      Options := Options + [ocDragUsingClientArea] else
        Options := Options - [ocDragUsingClientArea];
end;

procedure TForm8.CheckBox4Click(Sender: TObject);
begin
  with CoolFormHook1 do
    if CheckBox4.Checked then
      Options := Options + [ocRoundedForm] else
        Options := Options - [ocRoundedForm];
end;

procedure TForm8.CheckBox3Click(Sender: TObject);
begin
  with CoolFormHook1 do
    if CheckBox3.Checked then
      Options := Options + [ocNoDragUsingCaption] else
        Options := Options - [ocNoDragUsingCaption];
end;

procedure TForm8.CheckBox5Click(Sender: TObject);
begin
  with CoolFormHook1 do
    if CheckBox5.Checked then
      Options := Options + [ocPaintTransparently] else
      Options := Options - [ocPaintTransparently];
end;

procedure TForm8.RadioGroup2Click(Sender: TObject);
begin
  case RadioGroup2.ItemIndex of
    0: CoolDesktop1.DisplayResolution := dr640x480;
    1: CoolDesktop1.DisplayResolution := dr800x600;
    2: CoolDesktop1.DisplayResolution := dr1024x768;
    3: CoolDesktop1.DisplayResolution := dr1152x864;
    4: CoolDesktop1.DisplayResolution := dr1280x960;
    5: CoolDesktop1.DisplayResolution := dr1280x1024;
  end;
  FormActivate(Self);
end;

procedure TForm8.RadioGroup3Click(Sender: TObject);
begin
  case RadioGroup3.ItemIndex of
    0: CoolDesktop1.ColorMode := cm4bit;
    1: CoolDesktop1.ColorMode := cm8bit;
    2: CoolDesktop1.ColorMode := cm16bit;
    3: CoolDesktop1.ColorMode := cm24bit;
    4: CoolDesktop1.ColorMode := cm32bit;
  end;
  FormActivate(Self);
end;

procedure TForm8.CoolBtn4Click(Sender: TObject);
begin
  if CoolBtn4.Caption = '&Disable TLocker!' then
  begin
    CoolLocker1.Enabled := False;
    CoolBtn4.Caption := '&Enable TLocker!';
  end else
  begin
    CoolLocker1.Enabled := True;
    CoolBtn4.Caption := '&Disable TLocker!';
  end;
end;

procedure TForm8.CoolCheckRadioBox1Click(Sender: TObject);
begin
  if CoolCheckRadioBox1.Checked then
    CoolLocker1.Options := CoolLocker1.Options + [loHideTaskBar] else
    CoolLocker1.Options := CoolLocker1.Options - [loHideTaskBar];
end;

procedure TForm8.CoolCheckRadioBox2Click(Sender: TObject);
begin
  if CoolCheckRadioBox2.Checked then
    CoolLocker1.Options := CoolLocker1.Options + [loHideStartBtn] else
    CoolLocker1.Options := CoolLocker1.Options - [loHideStartBtn];
end;

procedure TForm8.CoolCheckRadioBox3Click(Sender: TObject);
begin
  if CoolCheckRadioBox3.Checked then
    if MessageDlg('If you choose this option the only way to get back' + #13 +
                  'the "Start" button will be rebooting of your PC...' + #13 +
                  'Sure want this option?', mtConfirmation, mbOkCancel, 0) = mrOk then
                  CoolLocker1.Options := CoolLocker1.Options + [loPreventStartBtnExisting] else
                  CoolCheckRadioBox3.Checked := False;
end;

procedure TForm8.CoolCheckRadioBox4Click(Sender: TObject);
begin
  if CoolCheckRadioBox4.Checked then
    CoolLocker1.Options := CoolLocker1.Options + [loPreventAppClosing] else
    CoolLocker1.Options := CoolLocker1.Options - [loPreventAppClosing];
end;

procedure TForm8.CoolCheckRadioBox5Click(Sender: TObject);
begin
  if CoolCheckRadioBox5.Checked then
    CoolLocker1.Options := CoolLocker1.Options + [loPreventAppMinimizing] else
    CoolLocker1.Options := CoolLocker1.Options - [loPreventAppMinimizing];
end;

procedure TForm8.CoolCheckRadioBox6Click(Sender: TObject);
begin
  if CoolCheckRadioBox6.Checked then
    CoolLocker1.Options := CoolLocker1.Options + [loPreventCursorLoosing] else
    CoolLocker1.Options := CoolLocker1.Options - [loPreventCursorLoosing];
end;

procedure TForm8.CoolCheckRadioBox7Click(Sender: TObject);
begin
  if CoolCheckRadioBox7.Checked then
    CoolLocker1.Options := CoolLocker1.Options + [loPreventSystemKeysWork] else
    CoolLocker1.Options := CoolLocker1.Options - [loPreventSystemKeysWork];
end;

procedure TForm8.CoolCheckRadioBox8Click(Sender: TObject);
begin
  if CoolCheckRadioBox8.Checked then
    CoolLocker1.Options := CoolLocker1.Options + [loAlwaysOnTopPosition] else
    CoolLocker1.Options := CoolLocker1.Options - [loAlwaysOnTopPosition];
end;

procedure TForm8.CoolCheckRadioBox9Click(Sender: TObject);
begin
  if CoolCheckRadioBox9.Checked then
    CoolLocker1.Options := CoolLocker1.Options + [lotaskbarautohide] else
    CoolLocker1.Options := CoolLocker1.Options - [lotaskbarautohide];
end;

procedure TForm8.CoolCheckRadioBox10Click(Sender: TObject);
begin
  if CoolCheckRadioBox10.Checked then
    CoolLocker1.Options := CoolLocker1.Options + [loHideProgman] else
    CoolLocker1.Options := CoolLocker1.Options - [loHideProgman];
end;

procedure TForm8.FormActivate(Sender: TObject);
begin
  case CoolDesktop1.DisplayResolution of
    dr640x480:  RadioGroup2.ItemIndex := 0;
    dr800x600:  RadioGroup2.ItemIndex := 1;
    dr1024x768:  RadioGroup2.ItemIndex := 2;
    dr1152x864:  RadioGroup2.ItemIndex := 3;
    dr1280x960:  RadioGroup2.ItemIndex := 4;
    dr1280x1024:  RadioGroup2.ItemIndex := 5;
  end;
  case CoolDesktop1.ColorMode of
    cm4bit:  RadioGroup3.ItemIndex := 0;
    cm8bit:  RadioGroup3.ItemIndex := 1;
    cm16bit:  RadioGroup3.ItemIndex := 2;
    cm24bit:  RadioGroup3.ItemIndex := 3;
    cm32bit:  RadioGroup3.ItemIndex := 4;
  end;
end;

procedure TForm8.DriveComboBox1Change(Sender: TObject);
begin
  CoolDisksInformant1.Drive := DriveComboBox1.Drive + ':\';
  Label2.Caption := CoolDisksInformant1.Drive;
  Label4.Caption := CoolDisksInformant1.DriveTypeStr;
  Label6.Caption := Inttostr(CoolDisksInformant1.TotalBytes);
  Label8.Caption := Inttostr(CoolDisksInformant1.FreeBytes);
  Label10.Caption := CoolDisksInformant1.FileSystemName;
  Label12.Caption := CoolDisksInformant1.VolumeName;
end;

procedure TForm8.CoolCheckRadioBox11Click(Sender: TObject);
begin
  with CoolFormHook1 do
    if CoolCheckRadioBox11.Checked then
      Options := Options + [ocPaintFormSemiTransparently] else
      Options := Options - [ocPaintFormSemiTransparently];
end;

end.
