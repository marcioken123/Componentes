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
unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CoolCtrls, StdCtrls, CoolTools, Grids, ExtCtrls, Buttons, ComCtrls{$IFDEF VER120}, ImgList{$ENDIF};

type
  TForm3 = class(TForm)
    CoolListBox1: TCoolListBox;
    CoolEdit1: TCoolEdit;
    CoolComboBox1: TCoolComboBox;
    CoolStringGrid1: TCoolStringGrid;
    CoolFormHook1: TCoolFormHook;
    StatusBar1: TStatusBar;
    CoolGroupBox1: TCoolGroupBox;
    CoolCheckRadioBox1: TCoolCheckRadioBox;
    CoolCheckRadioBox2: TCoolCheckRadioBox;
    CoolCheckRadioBox3: TCoolCheckRadioBox;
    CoolPanel1: TCoolButtonPanel;
    CoolSpeedButton1: TCoolSpeedButton;
    CoolSpeedButton2: TCoolSpeedButton;
    CoolSpeedButton3: TCoolSpeedButton;
    CoolLabel1: TCoolLabel;
    CoolLabel2: TCoolLabel;
    CoolLabel3: TCoolLabel;
    CoolLabel4: TCoolLabel;
    ImageList1: TImageList;
    CoolMemo1: TCoolMemo;
    CoolTrackBar1: TCoolTrackBar;
    CoolTrackBar2: TCoolTrackBar;
    CoolTrackBar3: TCoolTrackBar;
    CoolLabel5: TCoolLabel;
    CoolLabel6: TCoolLabel;
    CoolSpeedButton4: TCoolSpeedButton;
    CoolBtn9: TCoolBtn;
    CoolCaptionEffects1: TCoolCaptionEffects;
    procedure FormCreate(Sender: TObject);
    procedure CoolSpeedButton1Click(Sender: TObject);
    procedure CoolSpeedButton2Click(Sender: TObject);
    procedure CoolSpeedButton3Click(Sender: TObject);
    procedure CoolSpeedButton1MouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure CoolSpeedButton2MouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure CoolSpeedButton3MouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CoolSpeedButton4Click(Sender: TObject);
    procedure CoolSpeedButton4MouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

uses
  Unit11;

procedure TForm3.FormCreate(Sender: TObject);
begin
  CoolComboBox1.ItemIndex := 0;
end;

procedure TForm3.CoolSpeedButton1Click(Sender: TObject);
begin
  if ocPaintWallpaper in CoolFormHook1.Options then
    CoolFormHook1.Options := CoolFormHook1.Options - [ocPaintWallpaper] else
      CoolFormHook1.Options := CoolFormHook1.Options + [ocPaintWallpaper]
end;

procedure TForm3.CoolSpeedButton2Click(Sender: TObject);
begin
  CoolStringGrid1.Enabled := not CoolStringGrid1.Enabled;
  CoolListBox1.Enabled := not CoolListBox1.Enabled;
  CoolEdit1.Enabled := not CoolEdit1.Enabled;
  CoolComboBox1.Enabled := not CoolComboBox1.Enabled;
  CoolCheckRadioBox1.Enabled := not CoolCheckRadioBox1.Enabled;
  CoolCheckRadioBox2.Enabled := not CoolCheckRadioBox2.Enabled;
  CoolCheckRadioBox3.Enabled := not CoolCheckRadioBox3.Enabled;
  CoolGroupBox1.Enabled := not CoolGroupBox1.Enabled;
  CoolLabel1.Enabled := not CoolLabel1.Enabled;
  CoolLabel2.Enabled := not CoolLabel2.Enabled;
  CoolLabel3.Enabled := not CoolLabel3.Enabled;
  CoolLabel4.Enabled := not CoolLabel4.Enabled;
  CoolLabel5.Enabled := not CoolLabel5.Enabled;
  CoolLabel6.Enabled := not CoolLabel6.Enabled;
  CoolMemo1.Enabled := not CoolMemo1.Enabled;
  CoolTrackbar1.Enabled := not CoolTrackbar1.Enabled;
  CoolTrackbar2.Enabled := not CoolTrackbar2.Enabled;
  CoolTrackbar3.Enabled := not CoolTrackbar3.Enabled;
end;

procedure TForm3.CoolSpeedButton3Click(Sender: TObject);
begin
  if ocPaintTransparently in CoolStringGrid1.ExOptions then
    CoolStringGrid1.ExOptions := CoolStringGrid1.ExOptions - [ocPaintTransparently] else
      CoolStringGrid1.ExOptions := CoolStringGrid1.ExOptions + [ocPaintTransparently];

  if ocPaintTransparently in CoolListBox1.Options then
    CoolListBox1.Options := CoolListBox1.Options - [ocPaintTransparently] else
      CoolListBox1.Options := CoolListBox1.Options + [ocPaintTransparently];

  if ocPaintTransparently in CoolEdit1.Options then
    CoolEdit1.Options := CoolEdit1.Options - [ocPaintTransparently] else
      CoolEdit1.Options := CoolEdit1.Options + [ocPaintTransparently];

  if ocPaintTransparently in CoolComboBox1.Options then
    CoolComboBox1.Options := CoolComboBox1.Options - [ocPaintTransparently] else
      CoolComboBox1.Options := CoolComboBox1.Options + [ocPaintTransparently];

  CoolPanel1.Transparent := not CoolPanel1.Transparent;
  CoolCheckRadioBox1.Transparent := not CoolCheckRadioBox1.Transparent;
  CoolCheckRadioBox2.Transparent := not CoolCheckRadioBox2.Transparent;
  CoolCheckRadioBox3.Transparent := not CoolCheckRadioBox3.Transparent;
  CoolGroupBox1.Transparent := not CoolGroupBox1.Transparent;
  CoolLabel1.Transparent := not CoolLabel1.Transparent;
  CoolLabel2.Transparent := not CoolLabel2.Transparent;
  CoolLabel3.Transparent := not CoolLabel3.Transparent;
  CoolLabel4.Transparent := not CoolLabel4.Transparent;
  CoolLabel5.Transparent := not CoolLabel5.Transparent;
  CoolLabel6.Transparent := not CoolLabel6.Transparent;
                       
  if ocPaintTransparently in CoolMemo1.Options then
    CoolMemo1.Options := CoolMemo1.Options - [ocPaintTransparently] else
      CoolMemo1.Options := CoolMemo1.Options + [ocPaintTransparently];

  if ocPaintTransparently in CoolTrackbar1.Options then
    CoolTrackbar1.Options := CoolTrackbar1.Options - [ocPaintTransparently] else
      CoolTrackbar1.Options := CoolTrackbar1.Options + [ocPaintTransparently];

  if ocPaintTransparently in CoolTrackbar2.Options then
    CoolTrackbar2.Options := CoolTrackbar2.Options - [ocPaintTransparently] else
      CoolTrackbar2.Options := CoolTrackbar2.Options + [ocPaintTransparently];

  if ocPaintTransparently in CoolTrackbar3.Options then
    CoolTrackbar3.Options := CoolTrackbar3.Options - [ocPaintTransparently] else
      CoolTrackbar3.Options := CoolTrackbar3.Options + [ocPaintTransparently];
end;

procedure TForm3.CoolSpeedButton1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(StatusBar1) then
    StatusBar1.SimpleText := 'Wallpaper on/off'
end;

procedure TForm3.CoolSpeedButton2MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(StatusBar1) then
    StatusBar1.SimpleText := 'Enabled on/off'
end;

procedure TForm3.CoolSpeedButton3MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(StatusBar1) then
    StatusBar1.SimpleText := 'Transparency on/off'
end;

procedure TForm3.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if Assigned(StatusBar1) then
    StatusBar1.SimpleText := ''
end;

procedure TForm3.CoolSpeedButton4Click(Sender: TObject);
begin
  if ocFlatBorder in CoolStringGrid1.ExOptions then
    CoolStringGrid1.ExOptions := CoolStringGrid1.ExOptions - [ocFlatBorder] else
      CoolStringGrid1.ExOptions := CoolStringGrid1.ExOptions + [ocFlatBorder];

  if ocFlatBorder in CoolListBox1.Options then
    CoolListBox1.Options := CoolListBox1.Options - [ocFlatBorder] else
      CoolListBox1.Options := CoolListBox1.Options + [ocFlatBorder];

  if ocFlatBorder in CoolEdit1.Options then
    CoolEdit1.Options := CoolEdit1.Options - [ocFlatBorder] else
      CoolEdit1.Options := CoolEdit1.Options + [ocFlatBorder];

  if ocFlatBorder in CoolComboBox1.Options then
    CoolComboBox1.Options := CoolComboBox1.Options - [ocFlatBorder] else
      CoolComboBox1.Options := CoolComboBox1.Options + [ocFlatBorder];

  if ocFlatBorder in CoolMemo1.Options then
    CoolMemo1.Options := CoolMemo1.Options - [ocFlatBorder] else
      CoolMemo1.Options := CoolMemo1.Options + [ocFlatBorder];
end;

procedure TForm3.CoolSpeedButton4MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if Assigned(StatusBar1) then
    StatusBar1.SimpleText := 'Flat borders on/off'
end;

end.
