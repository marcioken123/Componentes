unit pLMDLEDEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Classes, Graphics, Forms, Controls, Dialogs, buttons, StdCtrls, ExtCtrls,
  LMDClass, LMDLED, LMDGraph,
  LMDCustomColorComboBox, LMDBaseGraphicButton, LMDCustomSpeedButton, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDBaseGraphicControl, LMDGraphicControl,
  LMDSimpleLabel, LMDDockSpeedButton, LMDLEDLabel, LMDColorComboBox, LMDLEDCustomLabel,
  LMDCustomComponent, LMDCustomComboBox, LMDCustomControl,
  LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit,
  LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit, LMDThemes,
  LMDThemedComboBox, LMDControl, LMDBaseControl;

type
  TLMDLEDEditorDlg = class(TForm)
    Bevel1: TBevel;
    test: TLMDLEDLabel;
    Label3: TLabel;
    edhs: TLMDSpinEdit;
    Label1: TLabel;
    edvs: TLMDSpinEdit;
    Label2: TLabel;
    edt: TLMDSpinEdit;
    chk: TCheckBox;
    cmbb: TLMDColorComboBox;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    cmbL: TLMDColorComboBox;
    pred: TComboBox;
    LMDSimpleLabel1: TLMDSimpleLabel;
    ok: TButton;
    Button1: TButton;
    reset: TButton;
    bt1: TLMDDockSpeedButton;
    bt2: TLMDDockSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure edchange(Sender: TObject);
    procedure cmbc(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkClick(Sender: TObject);
    procedure predChange(Sender: TObject);
    procedure btn(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

implementation

uses SysUtils, LMDProcs,  pLMDCommon;

const
   LMDLightColorStr:array[TLMDLightColor] of String = ('lcNone', 'lcBlue', 'lcRed',
                    'lcGreen', 'lcYellow', 'lcMarine', 'lcPurple');

{$R *.DFM}

{********************* Class TLMDLEDEditorDlg *********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDLEDEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDEditorDlg.FormCreate(Sender: TObject);
var
  i:Integer;
begin
  for i:=0 to Ord(High(LMDLightColorStr)) do
    pred.items.add(LMDLightColorStr[TLMDLightColor(i)]);
  LMDComLoadDelphiCustomColor(cmbb.CustomColors);
  FShow:=False;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LMDComSaveDelphiCustomColor(cmbb.CustomColors);
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDEditorDlg.btn(Sender: TObject);
begin
  if sender=bt1 then cmbb.Execute
  else if sender=bt2 then cmbL.ExecuteEnh(cmbb.CustomColors)
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDEditorDlg.chkClick(Sender: TObject);
begin
  test.Led.DisabledDigits:=chk.Checked;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDEditorDlg.cmbc(Sender: TObject);
begin
  with test.LED do
    if sender=cmbb then ActiveColor:=cmbb.SelectedColor
    else if sender=cmbl then InActiveColor:=cmbl.SelectedColor;
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDEditorDlg.predChange(Sender: TObject);
var
  c1, c2:TColor;
begin
  if pred.ItemIndex<>-1 then
    begin
      LMDGetLightColors(TLMDLightColor(pred.ItemIndex), c1, c2);
      test.LED.ActiveColor:=c1;
      test.LED.InActiveColor:=c2;
      if FShow then SetLabels;
      pred.ItemIndex:=-1;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDEditorDlg.edchange(Sender: TObject);
begin
  with test.LED do
    if sender=edhs then HorzSize:=Trunc(edhs.value)
    else if sender=edvs then VertSize:=Trunc(edvs.value)
    else if sender=edt then Thickness:=Trunc(edt.value);
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDEditorDlg.resetClick(Sender: TObject);
var
  b:TLMDLED;
begin
  b:=TLMDLED.Create;
  test.LED.Assign(b);
  b.Free;
  SetLabels;
end;

{------------------------------------------------------------------------------}
Procedure TLMDLEDEditorDlg.SetLabels;
begin
  With Test.LED do
    begin
      {Sizes}
      edhs.Value:=HorzSize;
      edvs.Value:=VertSize;
      edt.Value:=Thickness;
      {Colors}
      cmbb.SelectedColor:=ActiveColor;
      cmbL.SelectedColor:=InActiveColor;
      {PaletteRealize}
      chk.checked:=DisabledDigits;

      {Direction}
      {direct.Itemindex:=Ord(Style);}
    end;

end;

end.

 
