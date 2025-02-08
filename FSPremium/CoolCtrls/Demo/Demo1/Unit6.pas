{$IFDEF VER130}
  {$DEFINE VER120}
{$ENDIF}

unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, CoolCtrls, Grids, ExtCtrls, {$IFDEF ver120} ImgList, {$ENDIF}
  CoolUtils, CoolTools;

type
  TForm6 = class(TForm)
    ListBox1: TCoolListBox;
    ListBox2: TCoolListBox;
    ListBox3: TCoolListBox;
    RadioGroup1: TCoolCheckRadioGroup;
    Label4: TCoolLabel;
    CoolEditBtn2: TCoolEditBtn;
    OpenDialog1: TOpenDialog;
    Desktop1: TCoolDesktop;
    CoolBtn1: TCoolBtn;
    CoolBtn2: TCoolBtn;
    CoolBtn3: TCoolBtn;
    CoolLabel2: TCoolLabel;
    CoolFormHook1: TCoolFormHook;
    CoolBtn9: TCoolBtn;
    CoolCaptionEffects1: TCoolCaptionEffects;
    procedure FormCreate(Sender: TObject);
    procedure CoolEditBtn2BtnClick(Sender: TObject);
    procedure CoolBtn1Click(Sender: TObject);
    procedure CoolBtn2Click(Sender: TObject);
    procedure CoolBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.DFM}

uses
  Unit11;

procedure TForm6.FormCreate(Sender: TObject);
var
  Items: TStringList;
begin
  Items := Desktop1.GetWindowsBitmaps(True);
  try
    ListBox1.Items.Assign(Items);
  finally
    Items.Free;
  end;

  ListBox1.Items.Insert(0, '(None)');
  ListBox1.ItemIndex := ListBox1.Items.IndexOf(ExtractFileName(Desktop1.GetWallpaper));
  RadioGroup1.ItemIndex := Integer(Desktop1.GetWallpaperIsTile);

  Items := Desktop1.GetPatterns;
  try
    ListBox2.Items.Assign(Items);
  finally
    Items.Free;
  end;

  ListBox2.ItemIndex := ListBox2.Items.IndexOf(Desktop1.GetPattern);

  {$IFNDEF VER90}
  Items := Desktop1.GetDesktopFiles;
  try
    ListBox3.Items.Assign(Items);
  finally
    Items.Free;
  end;
  {$ENDIF}
end;

procedure TForm6.CoolEditBtn2BtnClick(Sender: TObject);
begin
  {$IFNDEF VER90}
  if OpenDialog1.Execute then
    CoolEditBtn2.Text := OpenDialog1.FileName;
  {$ENDIF}
end;

procedure TForm6.CoolBtn1Click(Sender: TObject);
begin
  {$IFNDEF VER90}
  if ListBox1.ItemIndex <> -1 then
    Desktop1.SetWallpaper('C:\Windows\' + ListBox1.Items.Strings[ListBox1.ItemIndex], Boolean(RadioGroup1.ItemIndex));

  if ListBox2.ItemIndex <> -1 then
    Desktop1.SetPattern(ListBox2.Items.strings[ListBox2.ItemIndex]);
  {$ENDIF}
end;

procedure TForm6.CoolBtn2Click(Sender: TObject);
begin
  {$IFNDEF VER90}
  if CoolEditBtn2.Text <> '' then
  begin
    Desktop1.SetDesktopFile(CoolEditBtn2.Text, '', ChangeFileExt(ExtractFileName(OpenDialog1.FileName), '.lnk'));
    ListBox3.Items := Desktop1.GetDesktopFiles;
  end;
  {$ENDIF}
end;

procedure TForm6.CoolBtn3Click(Sender: TObject);
{$IFNDEF VER90}
var
  I: Integer;
{$ENDIF}
begin
  {$IFNDEF VER90}
  if ListBox3.ItemIndex <> -1 then
  begin
    for I := 0 to ListBox3.Items.Count-1 do
      if ListBox3.Checked[I] then
        Desktop1.DeleteDesktopFile(ListBox3.Items.Strings[I]);

    Delay(3000);
    ListBox3.Items := Desktop1.GetDesktopFiles;
  end;
  {$ENDIF}
end;

end.
