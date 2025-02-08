unit pLMDButtonBarEditorDlg;
{$I lmdcmps.inc}
interface

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

pLMDButtonBarEditorDlg unit (RM)
--------------------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}
uses
  DesignIntf, DesignEditors, VCLEditors,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus,
  LMDButtonBar, LMDCustomControl, LMDCustomComponent, LMDClass, LMDButtonControl,
  LMDCustomCheckBox, LMDCheckBox, LMDComboBox, LMDCustomImageListBox,
  LMDImageListBox, LMDCustomButton, LMDButton, LMDGraphicControl,
  LMDTechnicalLine, LMDBaseGraphicControl, LMDBaseLabel,
  LMDCustomSimpleLabel, LMDSimpleLabel, LMDCustomGroupBox, LMDGroupBox,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel,
  LMDCustomPanelFill, LMDCustomComboBox,
  LMDSimplePanel, LMDDlgButtonPanel, LMDBaseGraphicButton,
  LMDCustomSpeedButton, LMDSpeedButton, LMDNoteBook, LMDBaseEdit,
  LMDCustomEdit, LMDEdit, LMDCont, ExtDlgs, LMDButtonBarPopupMenu,
  LMDCustomListBox, LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit,
  LMDControl, LMDBaseControl, LMDThemes, LMDCustomSheetControl;

const
  sedigbCaption = 'Image settings for item ';

type
  TfrmLMDButtonBarEditorDlg = class(TForm)
    bbar: TLMDButtonBar;
    LMDButtonBarPopupMenu1: TLMDButtonBarPopupMenu;
    pages: TLMDNoteBook;
    Section: TLMDNoteBookPage;
    General: TLMDNoteBookPage;
    s1: TLMDSpeedButton;
    s2: TLMDSpeedButton;
    LMDGroupBox1: TLMDGroupBox;
    LMDSimpleLabel3: TLMDSimpleLabel;
    btnSectionAdd: TLMDButton;
    btnSectionRename: TLMDButton;
    btnSectionDelete: TLMDButton;
    btnSectionFont: TLMDButton;
    btnSectionFont3D: TLMDButton;
    LMDGroupBox3: TLMDGroupBox;
    btnFillObject: TLMDButton;
    btnFont: TLMDButton;
    btnBevel: TLMDButton;
    btnFont3D: TLMDButton;
    LMDCheckBox1: TLMDCheckBox;
    LMDDlgButtonPanel1: TLMDDlgButtonPanel;
    btnOK1: TLMDButton;
    btnCancel1: TLMDButton;
    LMDGroupBox4: TLMDGroupBox;
    largelbx: TLMDImageListBox;
    large: TLMDEdit;
    LMDSimpleLabel2: TLMDSimpleLabel;
    LMDSimpleLabel1: TLMDSimpleLabel;
    small: TLMDEdit;
    smalllbx: TLMDImageListBox;
    LMDSimpleLabel7: TLMDSimpleLabel;
    opd: TOpenPictureDialog;
    edImg: TLMDSpinEdit;
    LMDSimpleLabel4: TLMDSimpleLabel;
    lih: TLMDSpinEdit;
    LMDSimpleLabel5: TLMDSimpleLabel;
    sih: TLMDSpinEdit;
    LMDGroupBox2: TLMDGroupBox;
    LMDSimpleLabel6: TLMDSimpleLabel;
    btnAddItem: TLMDButton;
    eigb: TLMDGroupBox;
    LMDSimpleLabel8: TLMDSimpleLabel;
    lgbtn: TLMDButton;
    sgbtn: TLMDButton;
    chkParentFont: TLMDCheckBox;
    procedure s1Click(Sender: TObject);
    procedure smallBtnClick(Sender, Btn: TObject; index: Integer);
    procedure lgbtnClick(Sender: TObject);
    procedure bbarItemClick(Sender: TObject; Section, Item: Integer);
    procedure largelbxDblClick(Sender: TObject);
    procedure edImgChange(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure ihChange(Sender: TObject);
    procedure bbarSectionChanged(Sender: TObject; CurrentSection,
      OldSection: Integer);
    procedure FormCreate(Sender: TObject);
  private
  public
     FEditItem: Integer;
     FDesigner: IDesigner;
     procedure InitBoxes;
     procedure UpdateItem;
  end;

implementation

{$R *.DFM}

uses
  ImgList, 
  pLMDDsgnCPGetX, LMDCustomImageList, LMDImageList, LMDBitmapList, pLMDCPGetCore;

procedure TfrmLMDButtonBarEditorDlg.InitBoxes;

  function ReturnName(const aValue:TCustomImageList):String;
  begin
    result:='';
    if LMDIsGlobalIdent(aValue) then
      begin
        if aValue is TLMDBitmapList then
          result:='Global BitmapList'
        else
          result:='Global ImageList';
      end
    else
      result:=aValue.Name;
  end;

begin
  if bbar.SmallImageList<>nil then
    begin
      smalllbx.ImageList:=bbar.SmallImageList;
      small.Text:=ReturnName(bbar.SmallImageList);
    end;
  if bbar.LargeImageList<>nil then
    begin
      largelbx.ImageList:=bbar.LargeImageList;
      large.text:=ReturnName(bbar.LargeImageList);
    end;
  sih.Value:=bbar.SmallItemHeight;
  lih.Value:=bbar.LargeItemHeight;
  if bbar.Sections.Count>0 then
    edImg.Value:=bbar.Sections[bbar.Open].ListIndex;
  s1Click(s1);
end;

procedure TfrmLMDButtonBarEditorDlg.btnClick(Sender: TObject);
begin
  if Sender=btnSectionAdd then
    bbar.AddSection;
  if Sender=btnSectionRename then
    bbar.RenSection;
  if Sender=btnSectionDelete then
    bbar.DelSection;
  if Sender=btnSectionFont then
    if bbar.Sections.Count > 0 then
      LMDCPGetFont (bbar.Sections[bbar.Open].Font);
  if Sender=btnSectionFont3D then
    if bbar.Sections.Count > 0 then
      LMDCPGetFont3D (bbar.Sections[bbar.Open].Font3D);
  if Sender=chkParentFont then
    if bbar.Sections.Count > 0 then
      bbar.Sections[bbar.Open].ParentFont:=chkParentFont.Checked;
  if Sender=btnAddItem then
    bbar.AddItem;
  if Sender=btnFillObject then
    LMDCPGetFillObject (bbar.FillObject);
  if SendeR=btnBevel then
    LMDCPGetBevel (bbar.Bevel);
  if Sender=btnFont3D then
    LMDCPGetFont3D (bbar.Font3D);
  if Sender=btnFont then
    LMDCPGetFont(bbar.Font);
  if Sender=LMDCheckBox1 then
    bbar.Transparent := LMDCheckBox1.Checked;
end;

procedure TfrmLMDButtonBarEditorDlg.s1Click(Sender: TObject);
begin
  FEditItem := 0;
  UpdateItem;
  pages.PageIndex:=Integer(TComponent(Sender).Tag)-1;
end;

procedure TfrmLMDButtonBarEditorDlg.smallBtnClick(Sender, Btn: TObject;
  index: Integer);
var
  t1, t2:Word;
  t3:TCustomImageList;
begin
   t1:=0;
   t2:=0;
   if sender=small then
     t3:=bbar.SmallImageList
   else
     t3:=bbar.LargeImageList;
   if bbar.Sections.Count > 0 then
     t1:=bbar.Sections[bbar.Open].ListIndex;

   if not LMDCPGetIMLExt(FDesigner, t3, t1, t2) then exit;
   if sender=small then
     begin
       small.text:='(none)';
       bbar.SmallImageList:=t3;
       smalllbx.ImageList:=t3;
       smalllbx.ListIndex:=t1;
       if bbar.SmallImageList<>nil then
         small.text:=bbar.SmallImageList.Name;
     end
   else
     begin
       large.text:='(none)';
       bbar.LargeImageList:=t3;
       largelbx.ImageList:=t3;
       largelbx.ListIndex:=t1;
       if bbar.LargeImageList<>nil then
         large.text:=bbar.LargeImageList.Name;
     end;
   if bbar.Sections.Count > 0 then
     bbar.Sections[bbar.Open].ListIndex:=t1;
end;

procedure TfrmLMDButtonBarEditorDlg.lgbtnClick(Sender: TObject);
begin
  if (bbar.Sections.Count=0) or (bbar.Sections[bbar.Open].Items.Count <= FEditItem) then exit;
  if opd.Execute then
    with bbar.Sections[bbar.Open].Items[FEditItem] do
      if Sender = lgbtn then
        LargeGlyph.LoadFromFile (opd.Filename)
      else
        SmallGlyph.LoadFromFile (opd.Filename);
end;

procedure TfrmLMDButtonBarEditorDlg.bbarItemClick(Sender: TObject; Section,
  Item: Integer);
begin
  FEditItem:= Item;
  UpdateItem;
end;

procedure TfrmLMDButtonBarEditorDlg.UpdateItem;
begin
  eigb.Caption := sedigbCaption+ '('+IntToStr (FEditItem)+')';
  chkParentFont.Enabled:=false;
  chkParentFont.Checked:=false;

  if (bbar.Sections.Count>0) and (bbar.Sections[bbar.Open].Items.Count>FEditItem) then
    // Select Image in ImageLists
    with bbar.Sections[bbar.Open].Items[FEditItem] do
      begin

        edImg.Value:=bbar.Sections[bbar.Open].ListIndex;
        largelbx.ListIndex:=bbar.Sections[bbar.Open].ListIndex;
        smalllbx.ListIndex:=bbar.Sections[bbar.Open].ListIndex;;
        chkParentFont.Enabled:=True;
        chkParentFont.Checked:=bbar.Sections[bbar.Open].ParentFont;

        // code for small imagelists
        if SmallGlyph.Empty and Assigned(bbar.SmallImageList) then
          smalllbx.ItemIndex:=ImageIndex
        else
          smalllbx.ItemIndex:=-1;

        // code for large imagelists
        if LargeGlyph.Empty and Assigned(bbar.LargeImageList) then
          largelbx.ItemIndex:=ImageIndex
        else
          largelbx.ItemIndex:=-1;
      end;
end;

procedure TfrmLMDButtonBarEditorDlg.largelbxDblClick(Sender: TObject);
begin
  if (bbar.Sections.Count=0) or (bbar.Sections[bbar.Open].Items.Count <= FEditItem) then exit;

  if sender=smalllbx then
    begin
      if smalllbx.ItemIndex=-1 then exit;
      bbar.Sections[bbar.Open].Items[FEditItem].ImageIndex:=smalllbx.ItemIndex;
      largelbx.ItemIndex:=smalllbx.ItemIndex;
      largelbx.TopIndex:=smalllbx.TopIndex;
    end
  else
    begin
      if largelbx.ItemIndex=-1 then exit;
      bbar.Sections[bbar.Open].Items[FEditItem].ImageIndex:=largelbx.ItemIndex;
      largelbx.ItemIndex:=largelbx.ItemIndex;
      smalllbx.TopIndex:=largelbx.TopIndex;
    end;
end;

procedure TfrmLMDButtonBarEditorDlg.edImgChange(Sender: TObject);
begin
  if bbar.Sections.Count=0 then exit;
  bbar.Sections[bbar.Open].ListIndex := edImg.AsInteger;
  if Assigned(smallLbx) then
    smallLbx.ListIndex:=edImg.AsInteger;
  if Assigned(largeLbx) then
    largeLbx.ListIndex:=edImg.AsInteger;
end;

procedure TfrmLMDButtonBarEditorDlg.FormCreate(Sender: TObject);
begin
 {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

procedure TfrmLMDButtonBarEditorDlg.ihChange(Sender: TObject);
begin
  if sender=sih then
    bbar.SmallItemHeight:=sih.AsInteger
  else
    bbar.LargeItemHeight:=lih.AsInteger
end;

procedure TfrmLMDButtonBarEditorDlg.bbarSectionChanged(Sender: TObject;
  CurrentSection, OldSection: Integer);
begin
  FEditItem := 0;
  UpdateItem;
end;

end.
