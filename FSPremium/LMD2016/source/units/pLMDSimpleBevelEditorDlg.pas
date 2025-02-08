unit pLMDSimpleBevelEditorDlg;
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

pLMDBevelEditorDlg unit ()
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Classes, Graphics, Forms, Controls, Dialogs, ExtCtrls, Tabs, Buttons, StdCtrls, 
  LMDCustomComponent, LMDWndProcComponent, LMDFormStyler, LMDCustomComboBox, 
  LMDCustomColorComboBox, LMDColorComboBox, LMDBaseControl, LMDBaseGraphicControl, 
  LMDBaseShape, LMDShapeControl, LMDThemes, LMDClass, LMDFormA, LMDControl, 
  LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDBaseEdit, LMDCustomEdit,
  LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit, LMDThemedComboBox;

type

  TLMDSimpleBevelEditorDlg = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    cmbstyle: TComboBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    spind: TLMDSpinEdit;
    test: TLMDShapeControl;
    cmbL: TLMDColorComboBox;
    dlgl: TButton;
    Label2: TLabel;
    cmbs: TLMDColorComboBox;
    dlgs: TButton;
    Label5: TLabel;
    cmbn: TLMDColorComboBox;
    dlgn: TButton;
    ok: TButton;
    Button1: TButton;
    reset: TButton;
    procedure resetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure cmbSChange(Sender: TObject);
    procedure spindChange(Sender: TObject);
    procedure dlglClick(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

implementation
uses
  TypInfo, SysUtils, LMDGraph, LMDProcs, LMDSimpleBevel, pLMDCommon;

{$R *.DFM}
{********************* Class TLMDShadowEditorDlg ***************************}
{------------------------- Private---------------------------------------------}
procedure TLMDSimpleBevelEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleBevelEditorDlg.FormCreate(Sender: TObject);
begin
  LMDComLoadDelphiCustomColor(cmbL.CustomColors);
  FShow:=False;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleBevelEditorDlg.cmbChange(Sender: TObject);
begin
  with test.Bevel do
    if Sender=cmbstyle then
      Style:=TLMDSimpleBevelStyle(cmbstyle.Itemindex);

  if FShow and self.Visible then
    SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleBevelEditorDlg.resetClick(Sender: TObject);
var
  b:TLMDSimpleBevel;
begin
  b:=TLMDSimpleBevel.Create;
  test.Bevel.Assign(b);
  b.Free;
  SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleBevelEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LMDComSaveDelphiCustomColor(cmbL.CustomColors);
end;

{------------------------------------------------------------------------------}
Procedure TLMDSimpleBevelEditorDlg.SetLabels;
begin
  With Test.Bevel do
    begin
      {Style}
      cmbstyle.ItemIndex:=Ord(Style);
      {Color}
      cmbL.SelectedColor:=LightColor;
      cmbS.SelectedColor:=ShadowColor;
      cmbN.SelectedColor:=Color;
      {Depth}
      spind.Value:=Width;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleBevelEditorDlg.cmbSChange(Sender: TObject);
begin
  with test.Bevel do
    if sender=cmbL then
      LightColor:=cmbL.SelectedColor
    else if sender=cmbS then
      ShadowColor:=cmbS.SelectedColor
    else if sender=cmbN then
      Color:=cmbN.SelectedColor;
  if self.Visible then
    SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleBevelEditorDlg.spindChange(Sender: TObject);
begin
  test.Bevel.Width:=spind.AsInteger;
  if self.Visible then
    SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleBevelEditorDlg.dlglClick(Sender: TObject);
begin
  if sender=dlgl then
    cmbl.execute
  else if sender=dlgs then
    cmbs.ExecuteEnh(cmbL.CustomColors)
  else if sender=dlgN then
    cmbN.ExecuteEnh(cmbL.CustomColors)
end;

end.

