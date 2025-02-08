unit pLMDTeethEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Classes, Graphics, Forms, Controls, Dialogs, Buttons, StdCtrls, ExtCtrls, Tabs,
  LMDClass, LMDBaseGraphicControl, LMDBaseShape, LMDWndProcComponent,
  LMDShapeControl, LMDCustomComponent, LMDCustomControl, LMDCustomPanel,
  LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit,
  LMDCustomExtSpinEdit, LMDSpinEdit, LMDThemes, LMDControl, LMDBaseControl;

type

  TLMDTeethEditorDlg = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    test: TLMDShapeControl;
    Label1: TLabel;
    cmb: TComboBox;
    Label4: TLabel;
    spinc: TLMDSpinEdit;
    Label2: TLabel;
    spinW: TLMDSpinEdit;
    Label3: TLabel;
    spinh: TLMDSpinEdit;
    chkc: TCheckBox;
    Label5: TLabel;
    chko: TCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    ok: TButton;
    Button1: TButton;
    reset: TButton;
    procedure FormCreate(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure spincChange(Sender: TObject);
    procedure chkcClick(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

 implementation
uses
  TypInfo, SysUtils, LMDGraph, LMDProcs, LMDTeeth;

{$R *.DFM}
{const
   DirectionNames:array[TLMDDirection] of string=
                       ('tdRight', 'tdDown', 'tdLeft', 'tdUp');}

{********************* Class TFxEditorDlg *************************************}
{------------------------- Private---------------------------------------------}
procedure TLMDTeethEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDTeethEditorDlg.FormCreate(Sender: TObject);
{var
  i:integer;}
begin
  {for i:=0 to Ord(High(DirectionNames)) do
    cmb.items.add(DirectionNames[TLMDDirection(i)]);}
  FShow:=False;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDTeethEditorDlg.cmbChange(Sender: TObject);
begin
  test.teeth.Direction:=TLMDDirection(cmb.Itemindex);
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDTeethEditorDlg.resetClick(Sender: TObject);
var
  b:TLMDTeeth;
begin
  b:=TLMDTeeth.Create;
  test.teeth.assign(b);
  b.free;
  SetLabels;
end;

{------------------------------------------------------------------------------}
Procedure TLMDTeethEditorDlg.SetLabels;
begin
  With Test.Teeth do
    begin
      {Int}
      spinc.Value:=Count;
      spinh.Value:=Height;
      spinw.Value:=Width;
      {Bool}
      chkc.Checked:=SetPerCount;
      chko.Checked:=Offset;
      {Styles}
      cmb.ItemIndex:=Ord(Direction);
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDTeethEditorDlg.spincChange(Sender: TObject);
begin
  if sender=spinc then
    test.teeth.count:=spinc.AsInteger
  else if sender=spinw then
    test.teeth.width:=spinw.AsInteger
  else if sender=spinh then
    test.teeth.height:=spinh.AsInteger;
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDTeethEditorDlg.chkcClick(Sender: TObject);
begin
  if sender=chkc then
    test.teeth.setpercount:=chkc.Checked
  else if sender=chko then
    test.teeth.offset:=chko.Checked;
  if FShow then SetLabels;
end;

end.

