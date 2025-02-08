unit pLMDLineEditorDlg;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################
pLMDLineEditorDlg unit - visual editor of line attributes
-----------------------------------
Description

Editor which allows to visually edit line attributes (style, width, color)

-----------------------------------

ToDo
----
*

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Types, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, ImgList,
  LMDChartLine;

type
  TLMDLineEditor = class(TForm)
    btCancel: TButton;
    btOK: TButton;
    gbLineSample: TGroupBox;
    pbLineSample: TPaintBox;
    ListView1: TListView;
    Label1: TLabel;
    ImageList1: TImageList;
    TrackBar1: TTrackBar;
    Label2: TLabel;
    btColor: TButton;
    ColorDialog1: TColorDialog;
    procedure ListView1Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure btColorClick(Sender: TObject);
    procedure pbLineSamplePaint(Sender: TObject);
  private
    { Private declarations }
    FLine: TLMDChartLine;
    FLineColor: TColor;
    FLineStyle: TPenStyle;
    FLineWidth: integer;

    procedure DrawSampleLine;
  public
    { Public declarations }

    function Edit(ALine: TLMDChartLine): boolean;
  end;

var
  LMDLineEditor: TLMDLineEditor;

implementation

{$R *.dfm}

{ TLMDLineEditor }

procedure TLMDLineEditor.DrawSampleLine;
begin
  with Self.pbLineSample.Canvas do
  begin
    Pen.Style := Self.FLineStyle;
    Pen.Color := Self.FLineColor;
    Pen.Width := Self.FLineWidth;

    Brush.Color := Self.gbLineSample.Color;
    FillRect(Rect(0, 0, Self.pbLineSample.Width, Self.pbLineSample.Height));
    MoveTo(20, Self.pbLineSample.Height div 2);
    LineTo(Self.pbLineSample.Width - 20, Self.pbLineSample.Height div 2);
  end;
end;

function TLMDLineEditor.Edit(ALine: TLMDChartLine): boolean;
begin
  Self.FLine := ALine;
  Self.FLineColor := Self.FLine.Color;
  Self.FLineStyle := Self.FLine.Style;
  Self.FLineWidth := Self.FLine.Width;

  Self.TrackBar1.Position := Self.FLineWidth;
  Self.ListView1.ItemIndex := Integer(Self.FLineStyle);

  Self.DrawSampleLine;
  Result := Self.ShowModal = mrOK;
  if Result then
  begin
    Self.FLine.Color := Self.FLineColor;
    Self.FLine.Style := Self.FLineStyle;
    Self.FLine.Width := Self.FLineWidth;
  end;
end;

procedure TLMDLineEditor.ListView1Click(Sender: TObject);
begin
  Self.FLineStyle := TPenStyle(Self.ListView1.ItemIndex);
  Self.DrawSampleLine;
end;

procedure TLMDLineEditor.TrackBar1Change(Sender: TObject);
begin
  Self.FLineWidth := Self.TrackBar1.Position;
  Self.DrawSampleLine;
end;

procedure TLMDLineEditor.btColorClick(Sender: TObject);
begin
  if Self.ColorDialog1.Execute then
  begin
    Self.FLineColor := Self.ColorDialog1.Color;
    Self.DrawSampleLine;
  end;
end;

procedure TLMDLineEditor.pbLineSamplePaint(Sender: TObject);
begin
  Self.DrawSampleLine;
end;

end.
