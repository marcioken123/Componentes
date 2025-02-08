unit pLMDComBrushDlg;
{$I lmdcmps.inc}

interface

uses
  Classes, Graphics, Forms, Controls, Dialogs,
  Buttons, StdCtrls, ExtCtrls, pLMDColorBox;

type
  TLMDComBrushEditorDlg = class(TForm)
    Bevel1: TBevel;
    Label5: TLabel;
    Label1: TLabel;
    cmb: TComboBox;
    LMDDrawEdge1: TBevel;
    test: TShape;
    btnOK: TButton;
    btnCancel: TButton;
    cmbc: TLMDColorBox;
    btnColor: TSpeedButton;
    dlgColor: TColorDialog;
    procedure FormCreate(Sender: TObject);
    procedure cmbcChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure btnColorClick(Sender: TObject);
  private
    FShow:Boolean;
  public
    Procedure SetLabels;
  end;

implementation

uses Consts, TypInfo, SysUtils, pLMDCommon, pLMDCst;

{$R *.DFM}

{********************* Class LMDBrushEditorDlg ********************************}
{------------------------- Private---------------------------------------------}
procedure TLMDComBrushEditorDlg.FormCreate(Sender: TObject);
var
  i:TBrushStyle;
begin
  FShow:=False;
  LMDComLoadDelphiCustomColor(dlgColor.CustomColors);
  for i:=Low(TBrushStyle) to High(TBrushStyle) do
    cmb.Items.Add(GetEnumName(TypeInfo(TBrushStyle), Ord(i)));
end;

{------------------------------------------------------------------------------}
procedure TLMDComBrushEditorDlg.cmbcChange(Sender: TObject);
begin
  test.Brush.Color:=cmbc.Selected;
  if FShow then SetLabels;
end;

{------------------------------------------------------------------------------}
procedure TLMDComBrushEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LMDComSaveDelphiCustomColor(dlgColor.CustomColors);
end;

{------------------------------------------------------------------------------}
procedure TLMDComBrushEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
end;

{------------------------------------------------------------------------------}
procedure TLMDComBrushEditorDlg.cmbChange(Sender: TObject);
begin
  test.Brush.Style:=TBrushStyle(cmb.Itemindex);
  if FShow then SetLabels;
 end;

{------------------------------------------------------------------------------}
Procedure TLMDComBrushEditorDlg.SetLabels;
begin
  With test.Brush do
    begin
      cmbc.Selected:=Color;
      cmb.ItemIndex:=Ord(Style);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDComBrushEditorDlg.btnColorClick(Sender: TObject);
begin
   dlgColor.Color:=cmbc.Selected;
   if dlgColor.Execute then
     begin
       test.Brush.Color:=dlgColor.Color;
       SetLabels;
     end;
end;

end.
