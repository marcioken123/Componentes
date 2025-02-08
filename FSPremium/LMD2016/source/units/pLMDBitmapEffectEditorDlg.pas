unit pLMDBitmapEffectEditorDlg;
{$I lmdcmps.Inc}

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

pLMDBitmapEffectEditorDlg unit (RM)
-----------------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Windows, Forms,StdCtrls, ImgList, Classes, ExtCtrls, ComCtrls, Controls,
  LMDExtSpinEdit, LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDCustomExtSpinEdit,
  LMDSpinEdit, LMDCustomListBox, LMDCustomImageListBox, LMDCustomCheckListBox,
  LMDCheckListBox, LMDCustomComponent, LMDWndProcComponent, LMDCustomButton,
  LMDButton, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDClass,
  LMDCustomParentPanel, LMDCustomPanelFill, LMDPanelFill, LMDCustomContainer,
  LMDCustomImageList, LMDBitmapList, LMDBaseController, LMDControl, LMDThemes;
  type
  TLMDBitmapEffectEditorDlg = class(TForm)
    test: TLMDPanelFill;
    Bevel1: TBevel;
    nb: TPageControl;
    TabSheet2: TTabSheet;
    ok: TButton;
    Button1: TButton;
    reset: TButton;
    clb: TLMDCheckListBox;
    Label1: TLabel;
    edBright: TLMDSpinEdit;
    TabSheet1: TTabSheet;
    Label10: TLabel;
    btnFillObject: TButton;
    Label2: TLabel;
    edStrength: TLMDExtSpinEdit;
    LMDBitmapList1: TLMDBitmapList;
    lbldesc: TLabel;
    procedure edbiwChange(Sender: TObject);
    procedure resetClick(Sender: TObject);
    procedure btnFillObjectClick(Sender: TObject);
    procedure clbClickCheck(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    Procedure SetLabels;
  end;

implementation

uses
  LMDGraph, LMDUtils, LMDBitmapEffectObject, pLMDCPGetCore;

{$R *.DFM}
{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectEditorDlg.edbiwChange(Sender: TObject);
begin
  if Sender=edStrength then Test.BackFx.AlphaBlend.Strength:=edStrength.AsFloat;
  if Sender=edBright then Test.BackFx.Brightness:=edBright.Value;
  SetLabels;
end;

procedure TLMDBitmapEffectEditorDlg.FormCreate(Sender: TObject);
begin
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{ ---------------------------------------------------------------------------- }
Procedure TLMDBitmapEffectEditorDlg.SetLabels;
begin
  with Test.BackFx do
    begin
      edBright.Value:=Brightness;
      clb.Checked[0]:=Buffered;
      clb.Checked[1]:=FlipHorizontal;
      clb.Checked[2]:=FlipVertical;
      clb.Checked[3]:=GrayScale;
      clb.Checked[4]:=Invert;
      edStrength.Value:=AlphaBlend.Strength;
      lbldesc.Caption:=AlphaBlend.FillObject.GetSetStr;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectEditorDlg.resetClick(Sender: TObject);
var
  b : TLMDBitmapEffectObject;
begin
  b:=TLMDBitmapEffectObject.Create;
  test.BackFx.assign(b);
  b.free;
  SetLabels;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectEditorDlg.btnFillObjectClick(Sender: TObject);
begin
  LMDCPGetFillObject(test.BackFx.AlphaBlend.FillObject);
  SetLabels;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBitmapEffectEditorDlg.clbClickCheck(Sender: TObject);
begin
  with Test.BackFx do
    begin
      Buffered:=clb.Checked[0];
      FlipHorizontal:=clb.Checked[1];
      FlipVertical:=clb.Checked[2];
      GrayScale:=clb.Checked[3];
      Invert:=clb.Checked[4];
    end;
end;

end.
