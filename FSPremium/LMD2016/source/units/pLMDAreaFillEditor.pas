unit pLMDAreaFillEditor;
{$I lmdcmps.inc}
{
###############################################################################
pLMDAreaFillEditor unit - Editor for backgrounds of several Chart elements
-----------------------------------
Description

ToDo
----
*

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Types, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, ExtDlgs,
  LMDChartBackground;

type
  TLMDAreaFillEditor = class(TForm)
    RadioGroup1: TRadioGroup;
    PageControl1: TPageControl;
    tpSolid: TTabSheet;
    tpGradient: TTabSheet;
    tpImage: TTabSheet;
    btCancel: TButton;
    btOK: TButton;
    pbSolidColor: TPaintBox;
    btSolidColor: TButton;
    btGradientColor1: TButton;
    pbGradientColor1: TPaintBox;
    pbGradientColor2: TPaintBox;
    btGradientColor2: TButton;
    Label1: TLabel;
    tbGradientAngle: TTrackBar;
    Label2: TLabel;
    edMaxLOD: TEdit;
    btImage: TButton;
    rgImageMode: TRadioGroup;
    Image1: TImage;
    ColorDialog1: TColorDialog;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure pbSolidColorPaint(Sender: TObject);
    procedure pbGradientColor1Paint(Sender: TObject);
    procedure pbGradientColor2Paint(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure rgImageModeClick(Sender: TObject);
    procedure btSolidColorClick(Sender: TObject);
    procedure btGradientColor1Click(Sender: TObject);
    procedure btGradientColor2Click(Sender: TObject);
    procedure tbGradientAngleChange(Sender: TObject);
    procedure btImageClick(Sender: TObject);
  private
    { Private declarations }
    FSolidColor, FColor1, FColor2: TColor;
    FStyle: TLMDChartBackgroundStyle;
    FAngle: integer;
    FMaxLOD: integer;
    FArea: TLMDChartBackground;
  public
    { Public declarations }
    function Edit(AArea: TLMDChartBackground): boolean;
  end;

var
  LMDAreaFillEditor: TLMDAreaFillEditor;

implementation

{$R *.dfm}

{ TLMDAreaFillEditor }

function TLMDAreaFillEditor.Edit(AArea: TLMDChartBackground): boolean;
begin
  Self.FArea := AArea;
  //Self.FArea.Assign(AArea);
  Self.FStyle := Self.FArea.Style;
  Self.FColor1 := Self.FArea.GradientColorBegin;
  Self.FColor2 := Self.FArea.GradientColorEnd;
  Self.FAngle := Self.FArea.GradientAngle;
  Self.FMaxLOD := Self.FArea.GradientMaxLOD;
  Self.FSolidColor := Self.FArea.SolidColor;
  Self.Image1.Picture := Self.FArea.Image;

  Self.PageControl1.Visible := Self.FStyle <> cbsNone;
  if Self.FStyle = cbsSolid then
    Self.PageControl1.ActivePage := tpSolid
  else if Self.FStyle = cbsGradient then
    Self.PageControl1.ActivePage := tpGradient
  else
    Self.PageControl1.ActivePage := tpImage;  

  if Self.ShowModal = mrOK then
  begin
    Self.FArea.Style := Self.FStyle;
    Self.FArea.GradientColorBegin := Self.FColor1;
    Self.FArea.GradientColorEnd := Self.FColor2;
    Self.FArea.GradientAngle := Self.FAngle;

    if Self.edMaxLOD.Text <> '' then
      Self.FMaxLOD := StrToInt(Self.edMaxLOD.Text);
    Self.FArea.GradientMaxLOD := Self.FMaxLOD;
    Self.FArea.SolidColor := Self.FSolidColor;
    Self.FArea.Image := Self.Image1.Picture;

    Result := true;
  end
  else
    Result := false;
end;

procedure TLMDAreaFillEditor.pbSolidColorPaint(Sender: TObject);
var
  pb: TPaintBox;
begin
  pb := Sender as TPaintBox;
  pb.Canvas.Brush.Color := Self.FSolidColor;
  pb.Canvas.FillRect(Rect(0, 0, pb.Width, pb.Height));
end;

procedure TLMDAreaFillEditor.pbGradientColor1Paint(Sender: TObject);
var
  pb: TPaintBox;
begin
  pb := Sender as TPaintBox;
  pb.Canvas.Brush.Color := Self.FColor1;
  pb.Canvas.FillRect(Rect(0, 0, pb.Width, pb.Height));
end;

procedure TLMDAreaFillEditor.pbGradientColor2Paint(Sender: TObject);
var
  pb: TPaintBox;
begin
  pb := Sender as TPaintBox;
  pb.Canvas.Brush.Color := Self.FColor2;
  pb.Canvas.FillRect(Rect(0, 0, pb.Width, pb.Height));
end;

procedure TLMDAreaFillEditor.RadioGroup1Click(Sender: TObject);
begin
  Self.PageControl1.Visible := Self.RadioGroup1.ItemIndex <> 0;
  if Self.RadioGroup1.ItemIndex = 0 then
    Self.FStyle := cbsNone
  else if Self.RadioGroup1.ItemIndex = 1 then
  begin
    Self.FStyle := cbsSolid;
    Self.PageControl1.ActivePage := Self.tpSolid;
  end
  else if Self.RadioGroup1.ItemIndex = 2 then
  begin
    Self.FStyle := cbsGradient;
    Self.PageControl1.ActivePage := Self.tpGradient;
  end
  else if Self.RadioGroup1.ItemIndex = 3 then
  begin
    if Self.rgImageMode.ItemIndex = 0 then
      Self.FStyle := cbsImageStretched
    else
      Self.FStyle := cbsImageTiled;
    Self.PageControl1.ActivePage := Self.tpImage;
  end;
end;

procedure TLMDAreaFillEditor.rgImageModeClick(Sender: TObject);
begin
  Self.RadioGroup1.ItemIndex := 3;
  if Self.rgImageMode.ItemIndex = 0 then
      Self.FStyle := cbsImageStretched
  else
      Self.FStyle := cbsImageTiled;
end;

procedure TLMDAreaFillEditor.btSolidColorClick(Sender: TObject);
begin
  Self.ColorDialog1.Color := Self.FSolidColor;
  if Self.ColorDialog1.Execute then
  begin
    Self.FSolidColor := Self.ColorDialog1.Color;
    Self.pbSolidColor.Refresh;
  end;
end;

procedure TLMDAreaFillEditor.btGradientColor1Click(Sender: TObject);
begin
  Self.ColorDialog1.Color := Self.FColor1;
  if Self.ColorDialog1.Execute then
  begin
    Self.FColor1 := Self.ColorDialog1.Color;
    Self.pbGradientColor1.Refresh;
  end; 
end;

procedure TLMDAreaFillEditor.btGradientColor2Click(Sender: TObject);
begin
  Self.ColorDialog1.Color := Self.FColor2;
  if Self.ColorDialog1.Execute then
  begin
    Self.FColor2 := Self.ColorDialog1.Color;
    Self.pbGradientColor2.Refresh;
  end;
end;

procedure TLMDAreaFillEditor.tbGradientAngleChange(Sender: TObject);
begin
  Self.FAngle := Self.tbGradientAngle.Position;
end;

procedure TLMDAreaFillEditor.btImageClick(Sender: TObject);
begin
  if Self.OpenPictureDialog1.Execute then
    Self.Image1.Picture.LoadFromFile(Self.OpenPictureDialog1.FileName);
end;

end.
