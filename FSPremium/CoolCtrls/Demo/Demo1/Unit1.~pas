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

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, CoolCtrlsDB,
  CoolPolygons, StdCtrls, CoolCtrls, {$IFDEF VER120} ImgList, {$ENDIF} CoolTools,
  ExtCtrls;

type
  TForm1 = class(TForm)
    CoolBtn1: TCoolBtn;
    CoolBtn2: TCoolBtn;
    CoolBtn3: TCoolBtn;
    CoolBtn4: TCoolBtn;
    CoolBtn5: TCoolBtn;
    CoolFormHook1: TCoolFormHook;
    CoolBtn9: TCoolBtn;
    ImageList1: TImageList;
    CoolTrayIcon1: TCoolTrayIcon;
    CoolInstancesChecker1: TCoolInstancesChecker;
    CoolBtn6: TCoolBtn;
    CoolPolygones1: TCoolPolygones;
    CoolBtn7: TCoolBtn;
    CoolBtn8: TCoolBtn;
    Image1: TImage;
    CoolLabel1: TCoolLabel;
    CoolCheckRadioBox1: TCoolCheckRadioBox;
    CoolCheckRadioBox2: TCoolCheckRadioBox;
    CoolCaptionEffects1: TCoolCaptionEffects;
    CoolPolygones2: TCoolPolygones;
    procedure CoolBtn1Click(Sender: TObject);
    procedure CoolBtn2Click(Sender: TObject);
    procedure CoolBtn3Click(Sender: TObject);
    procedure CoolBtn9Click(Sender: TObject);
    procedure CoolBtn4Click(Sender: TObject);
    procedure CoolBtn5Click(Sender: TObject);
    procedure CoolBtn6Click(Sender: TObject);
    procedure CoolBtn7Click(Sender: TObject);
    procedure CoolBtn8Click(Sender: TObject);
    procedure CoolCheckRadioBox1Click(Sender: TObject);
    procedure CoolCheckRadioBox2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Scheme: Integer;
    procedure ShowModalEx(FormClass: TFormClass);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3, Unit4, Unit7, Unit5, Unit6, Unit8, Unit9, Unit11;

{$R *.DFM}

procedure TForm1.ShowModalEx(FormClass: TFormClass);
begin
  Hide;
  with FormClass.Create(nil) do
  try
    ShowModal;
  finally
    Release;
  end;
  Show;
end;

procedure TForm1.CoolBtn1Click(Sender: TObject);
begin
  ShowModalEx(TForm2);
end;

procedure TForm1.CoolBtn2Click(Sender: TObject);
begin
  ShowModalEx(TForm3);
end;

procedure TForm1.CoolBtn3Click(Sender: TObject);
begin
  ShowModalEx(TForm4);
end;

procedure TForm1.CoolBtn9Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.CoolBtn4Click(Sender: TObject);
begin
  ShowModalEx(TForm7);
end;

procedure TForm1.CoolBtn5Click(Sender: TObject);
begin
  ShowModalEx(TForm5);
end;

procedure TForm1.CoolBtn6Click(Sender: TObject);
begin
  ShowModalEx(TForm6);
end;

procedure TForm1.CoolBtn7Click(Sender: TObject);
begin
  ShowModalEx(TForm8);
end;

procedure TForm1.CoolBtn8Click(Sender: TObject);
begin
  ShowModalEx(TForm9);
end;

procedure TForm1.CoolCheckRadioBox1Click(Sender: TObject);
var
  Pic: TPicture;
begin
  if CoolCheckRadioBox1.Checked and (Scheme <> 1) then
  begin
    Pic := TPicture.Create;
    try
      Pic.Assign(ImagesModule.CoolImages1.Images[1].Picture);
      ImagesModule.CoolImages1.Images[1].Picture.Assign(ImagesModule.CoolImages1.Images[12].Picture);
      ImagesModule.CoolImages1.Images[12].Picture.Assign(Pic);
    finally
      Pic.Free;
    end;
    Scheme := 1;
  end;
end;

procedure TForm1.CoolCheckRadioBox2Click(Sender: TObject);
var
  Pic: TPicture;
begin
  if CoolCheckRadioBox2.Checked and (Scheme <> 2) then
  begin
    Pic := TPicture.Create;
    try
      Pic.Assign(ImagesModule.CoolImages1.Images[1].Picture);
      ImagesModule.CoolImages1.Images[1].Picture.Assign(ImagesModule.CoolImages1.Images[12].Picture);
      ImagesModule.CoolImages1.Images[12].Picture.Assign(Pic);
    finally
      Pic.Free;
    end;
    Scheme := 2;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Scheme := 1;
end;

end.
