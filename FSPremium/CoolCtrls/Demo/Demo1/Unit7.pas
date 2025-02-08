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
unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CoolUtils, CoolCtrls, StdCtrls, ExtCtrls, Menus, {$IFDEF VER120} ImgList,{$ENDIF}
  CoolTools, CoolCtrlsEx;

type
  TForm7 = class(TForm)
    CoolBtn1: TCoolBtn;
    CoolBtn2: TCoolBtn;
    CoolBtn7: TCoolBtn;
    CoolBtn3: TCoolBtn;
    CoolBtn5: TCoolBtn;
    CoolBtn6: TCoolBtn;
    CoolBtn4: TCoolBtn;
    CoolBtn8: TCoolBtn;
    ImageList1: TImageList;
    ImageList2: TImageList;
    CoolTrackBar1: TCoolTrackBar;
    CoolTrackBar2: TCoolTrackBar;
    CoolTrackBar3: TCoolTrackBar;
    CoolTrackBar4: TCoolTrackBar;
    CoolTrackBar5: TCoolTrackBar;
    CoolTrackBar6: TCoolTrackBar;
    CoolThumbTab1: TCoolThumbTab;
    CoolThumbTab2: TCoolThumbTab;
    CoolPopupButton1: TCoolPopupButton;
    CoolPopupBox1: TCoolPopupBox;
    CoolPopupBox2: TCoolPopupBox;
    CoolPopupButton2: TCoolPopupButton;
    PopupMenu1: TPopupMenu;
    ItemOne1: TMenuItem;
    ItemTwo1: TMenuItem;
    N1: TMenuItem;
    ItemThree1: TMenuItem;
    CoolBtn9: TCoolBtn;
    CoolBtn10: TCoolBtn;
    CoolPopupButton3: TCoolPopupButton;
    CoolPopupButton21: TCoolPopupButton2;
    CoolBevel1: TCoolBevel;
    CoolFormHook1: TCoolFormHook;
    CoolBtn11: TCoolBtn;
    CoolBitmapButton3: TCoolBitmapButton;
    CoolBitmapButton4: TCoolBitmapButton;
    CoolBitmapButton5: TCoolBitmapButton;
    CoolBitmapButton6: TCoolBitmapButton;
    CoolBitmapButton7: TCoolBitmapButton;
    CoolBitmapButton9: TCoolBitmapButton;
    CoolBitmapButton8: TCoolBitmapButton;
    CoolCaptionEffects1: TCoolCaptionEffects;
    procedure CoolBtn7Click(Sender: TObject);
    procedure CoolBtn1Click(Sender: TObject);
    procedure CoolBtn2Click(Sender: TObject);
    procedure CoolBtn3Click(Sender: TObject);
    procedure CoolBtn5Click(Sender: TObject);
    procedure CoolBtn6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CoolBtn4Click(Sender: TObject);
    procedure CoolBtn8Click(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.DFM}

uses
  Unit11;

procedure TForm7.CoolBtn7Click(Sender: TObject);
begin
  ShowMessage(TCoolBtn(Sender).Name);
end;

procedure TForm7.CoolBtn1Click(Sender: TObject);
begin
  ShowMessage(TCoolBtn(Sender).Name);
end;

procedure TForm7.CoolBtn2Click(Sender: TObject);
begin
  ShowMessage(TCoolBtn(Sender).Name);
end;

procedure TForm7.CoolBtn3Click(Sender: TObject);
begin
  ShowMessage(TCoolBtn(Sender).Name);
end;

procedure TForm7.CoolBtn5Click(Sender: TObject);
begin
  ShowMessage(TCoolBtn(Sender).Name);
end;

procedure TForm7.CoolBtn6Click(Sender: TObject);
begin
  ShowMessage(TCoolBtn(Sender).Name);
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  {$IFDEF VER120}
  CoolThumbTab1.Anchors := [akRight, akBottom];
  CoolThumbTab2.Anchors := [akLeft, akBottom];
  {$ENDIF}
end;

procedure TForm7.CoolBtn4Click(Sender: TObject);
begin
  ShowMessage(TCoolBtn(Sender).Name);
end;

procedure TForm7.CoolBtn8Click(Sender: TObject);
begin
  ShowMessage(TCoolBtn(Sender).Name);
end;

end.
