unit pLMDGlyphTextLayoutEditorDlg;
{$I lmdcmps.inc}

interface

uses
  ComCtrls, Classes, Graphics, Forms, Controls, Dialogs, buttons, StdCtrls, ExtCtrls,
  Tabs, TabNotBk, LMDBaseGraphicControl,
  LMDBaseLabel, LMDCustomSimpleLabel, LMDBaseGraphicButton, LMDClass, LMDGraph,
  LMDCustomSpeedButton, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
  LMDCustomExtSpinEdit, LMDSpinEdit, LMDSimpleLabel, LMDSpeedButton,
  LMDControl, LMDBaseControl, LMDThemes, LMDShSpinEdit;

type
  TLMDGlyphTextLayoutEditorDlg = class(TForm)
    Bevel1: TBevel;
    ok: TButton;
    cancel: TButton;
    reset: TButton;
    test: TLMDSpeedButton;
    nb: TPageControl;
    Label7: TLabel;
    Label8: TLabel;
    Label3: TLabel;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    spc: TLMDShSpinEdit;
    cmb2: TComboBox;
    cmb: TComboBox;
    LMDSimpleLabel4: TLMDSimpleLabel;
    capX: TLMDShSpinEdit;
    Label5: TLabel;
    capY: TLMDShSpinEdit;
    Label6: TLabel;
    LMDSimpleLabel5: TLMDSimpleLabel;
    LMDSimpleLabel6: TLMDSimpleLabel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure edchange(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbChange(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

implementation

uses SysUtils, lmdutils, LMDButtonLayout;

{$R *.DFM}

{********************* Class TLMDButtonLayoutEditorDlg ************************}
{------------------------- Private---------------------------------------------}
procedure TLMDGlyphTextLayoutEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyphTextLayoutEditorDlg.FormCreate(Sender: TObject);
begin
  FShow:=False;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyphTextLayoutEditorDlg.edchange(Sender: TObject);
begin
  with test.ButtonLayout do
    if sender=spc then Spacing:=Trunc(spc.value)
    else if sender=capX then OffsetX:=Trunc(capX.value)
    else if sender=capY then OffsetY:=Trunc(capY.value);
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDGlyphTextLayoutEditorDlg.resetClick(Sender: TObject);
var
  b:TLMDButtonLayout;
begin
  b:=TLMDButtonLayout.Create;
  try
    test.ButtonLayout.Assign(b);
    SetLabels;
  finally
    b.Free;
  end;
end;

{------------------------------------------------------------------------------}
Procedure TLMDGlyphTextLayoutEditorDlg.SetLabels;
begin
  With Test.ButtonLayout do
    begin
      {Sizes}
      spc.Value:=Spacing;
      capX.Value:=OffsetX;
      capY.Value:=OffsetY;

      {Alignment}
      cmb.ItemIndex:=Ord(Alignment);
      cmb2.ItemIndex:=Ord(AlignText2Glyph);
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDGlyphTextLayoutEditorDlg.cmbChange(Sender: TObject);
begin
  with test.ButtonLayout do
    if sender=cmb then Alignment:=TLMDAlignment(Ord(cmb.ItemIndex))
    else if sender=cmb2 then AlignText2Glyph:=TLMDTextArrange(ord(cmb2.ItemIndex));
end;

end.

 
