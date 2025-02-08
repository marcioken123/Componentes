{$IFDEF VER130}
  {$DEFINE VER120}
{$ENDIF}

unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, CoolCtrls, Grids, ExtCtrls, {$IFDEF ver120} ImgList, {$ENDIF}
  CoolUtils, CoolTools, CoolCtrlsEx;

type
  TForm6 = class(TForm)
    ListBox2: TCoolListBox;
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
    CoolExplorerListView1: TCoolExplorerListView;
    CoolExplorerListView2: TCoolExplorerListView;
    CoolLabel1: TCoolLabel;
    CoolLabel3: TCoolLabel;
    CoolLabel4: TCoolLabel;
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
  CoolExplorerListView2.Directory := Desktop1.WindowsDirectory;

  RadioGroup1.ItemIndex := Integer(Desktop1.GetWallpaperIsTile);

  Items := Desktop1.GetPatterns;
  try
    ListBox2.Items.Assign(Items);
  finally
    Items.Free;
  end;

  ListBox2.ItemIndex := ListBox2.Items.IndexOf(Desktop1.GetPattern);

  {$IFNDEF VER90}
  CoolExplorerListView1.Directory := Desktop1.DesktopDirectory;
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
  if CoolExplorerListView2.Selected <> nil then
    Desktop1.SetWallpaper('C:\Windows\' + CoolExplorerListView2.Selected.Caption, Boolean(RadioGroup1.ItemIndex));

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
    Delay(3000);
    CoolExplorerListView1.Directory := Desktop1.DesktopDirectory;
  end;
  {$ENDIF}
end;

procedure TForm6.CoolBtn3Click(Sender: TObject);
begin
  {$IFNDEF VER90}
  if CoolExplorerListView1.Selected <> nil then
    Desktop1.DeleteDesktopFile(ChangeFileExt(CoolExplorerListView1.Selected.Caption, ''));

  CoolExplorerListView1.Directory := Desktop1.DesktopDirectory;
  {$ENDIF}
end;

end.
