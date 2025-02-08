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
unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CoolCtrls, StdCtrls, {$IFDEF VER120} ImgList, {$ENDIF} ComCtrls,
  CoolTools, CoolCtrlsEx;

type
  TForm2 = class(TForm)
    ImageList1: TImageList;
    CoolFormHook1: TCoolFormHook;
    CoolBtn9: TCoolBtn;
    CoolPageControl1: TCoolPageControl;
    CoolTabSheet1: TCoolTabSheet;
    CoolTabSheet2: TCoolTabSheet;
    CoolListBox1: TCoolListBox;
    CoolListBox2: TCoolListBox;
    CoolListBox4: TCoolListBox;
    CoolListBox5: TCoolListBox;
    CoolListBox3: TCoolListBox;
    CoolListBox6: TCoolListBox;
    CoolComboBox3: TCoolComboBox;
    CoolComboBox4: TCoolComboBox;
    CoolEditBtn1: TCoolEditBtn;
    CoolEdit1: TCoolEdit;
    CoolComboBox1: TCoolComboBox;
    CoolComboBox2: TCoolComboBox;
    CoolCaptionEffects1: TCoolCaptionEffects;
    procedure FormCreate(Sender: TObject);
  private
    {$IFDEF VER130}
    procedure CoolPageControl1DrawTab(Control: TCustomTabControl;
      TabIndex: Integer; const Rect: TRect; Active: Boolean);
    {$ENDIF}
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

uses
  Unit11;
  
procedure TForm2.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Pred(CoolTabSheet2.ControlCount) do
    if CoolTabSheet2.Controls[I] is TCoolComboBox then
      TCoolComboBox(CoolTabSheet2.Controls[I]).ItemIndex := 0;

  {$IFDEF VER130}
  CoolPageControl1.OwnerDraw := True;
  CoolPageControl1.OnDrawTab := CoolPageControl1DrawTab;
  {$ENDIF}
end;

{$IFDEF VER130}
procedure TForm2.CoolPageControl1DrawTab(Control: TCustomTabControl;
  TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  S: string;
  R: TRect;
begin
  R := Rect;
  S := 'Page #' + IntToStr(TabIndex);
  SetBkMode(CoolPageControl1.Canvas.Handle, Transparent);
  CoolPageControl1.Canvas.Font.Color := clWhite;
  CoolPageControl1.Canvas.Font.Style := [fsItalic];
  DrawText(CoolPageControl1.Canvas.Handle, PChar(S), Length(S), R, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
end;
{$ENDIF}

end.
