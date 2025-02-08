unit pLMDFillObjectEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Classes, Graphics, Forms, Controls, Dialogs, Buttons, StdCtrls,
  ExtCtrls,  Tabs, ComCtrls, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDBaseImage, LMDBaseGraphicControl,
  LMDGraphicControl, LMDFill, LMDClass,
  LMDWndProcComponent, LMDCustomNImage, LMDSimpleLabel, LMDNImage,
  LMDCustomComponent, LMDCustomControl, LMDCustomPanel,
  LMDButtonControl, LMDCustomCheckBox, LMDCheckBox, LMDCustomButton,
  LMDButton, LMDControl, LMDBaseControl, LMDThemes;

type
  TLMDFillEditorDlg = class(TForm)
    Bevel1: TBevel;
    test: TLMDFill;
    nb: TPageControl;
    Label2: TLabel;
    cmbStyle: TComboBox;
    Label4: TLabel;
    iTest: TLMDNImage;
    cmbTile: TComboBox;
    btest: TLMDFill;
    info: TLMDSimpleLabel;
    gTest: TLMDFill;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    ok: TButton;
    Button1: TButton;
    reset: TButton;
    ck1: TCheckBox;
    ck2: TCheckBox;
    ck3: TCheckBox;
    btnBitmap: TButton;
    btnbrush: TButton;
    btnGradient: TButton;
    procedure resetClick(Sender: TObject);
    procedure tabChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ck1Click(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

implementation
uses
  TypInfo, SysUtils, 
  LMDGraph, LMDUtils, LMDFillObject,
  pLMDCPGetCore, pLMDCPGetBase;

{$R *.DFM}
{********************* Class TLMDFillObjectEditorDlg **************************}
{------------------------- Private---------------------------------------------}
procedure TLMDFillEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDFillEditorDlg.FormCreate(Sender: TObject);
{var i:integer;}
begin
  {for i:=0 to Ord(High(styleNames)) do
    cmbstyle.items.add(styleNames[TLMDFillStyle(i)]);}
  FShow:=False;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDFillEditorDlg.cmbChange(Sender: TObject);
begin
  with test.FillObject do
    if Sender=cmbstyle then
      begin
        Style:=TLMDFillStyle(cmbstyle.Itemindex);
        Invalidate;
      end
    else if Sender=cmbtile then
      TileMode:=TLMDTileMode(cmbtile.Itemindex);
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDFillEditorDlg.resetClick(Sender: TObject);
var
  b:TLMDFillObject;
begin
  b:=TLMDFillObject.Create;
  test.FillObject.Assign(b);
  b.Destroy;
  SetLabels;
end;

{------------------------------------------------------------------------------}
Procedure TLMDFillEditorDlg.SetLabels;
begin
  With Test.FillObject do
    begin
      {Styles}
      cmbstyle.ItemIndex:=Ord(Style);
      cmbtile.ItemIndex:=Ord(TileMode);
      {Bitmap}
      iTest.Bitmap:=Bitmap;
      bTest.FillObject.Brush:=Brush;
      gTest.FillObject.Gradient:=Gradient;
      {Options}
      ck1.Checked:=foFillInner in Options;
      ck2.Checked:=foQuickDraw in Options;
      ck3.Checked:=foGrUseBitmap in Options;
    end;

end;

procedure TLMDFillEditorDlg.tabChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDFillEditorDlg.Button1Click(Sender: TObject);
begin
  if sender=btnBrush then
    LMDCPGetBrush(test.FillObject.Brush)
  else if Sender=btnBitmap then
    LMDCPGetBitmap(test.FillObject.Bitmap)
  else if Sender=btnGradient then
    LMDCPGetGradient(test.FillObject.Gradient);
  SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDFillEditorDlg.ck1Click(Sender: TObject);
begin
  with test.FillObject do
    if sender=ck1 then
      begin
        if ck1.Checked then Options:=Options+[foFillInner] else Options:=Options-[foFillInner]
      end
    else if sender=ck2 then
      begin
        if ck2.Checked then Options:=Options+[foQuickDraw] else Options:=Options-[foQuickDraw]
      end
    else if sender=ck3 then
       if ck3.Checked then Options:=Options+[foGrUseBitmap] else Options:=Options-[foGrUseBitmap];
end;

end.

 
