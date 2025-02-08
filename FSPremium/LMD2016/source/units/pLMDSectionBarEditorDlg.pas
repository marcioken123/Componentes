unit pLMDSectionBarEditorDlg;
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

pLMDSectionBarEditorDlg unit (DD, RM, AH)
-----------------------------------------
Implements SectionBar --> Sections dialog.

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  DesignIntf, DesignEditors, VCLEditors,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtDlgs, pLMDImageBox, Menus, LMDSectionBarPopupMenu,
  LMDShSpinEdit, LMDBarBase, LMDSectionBar, ImgList, CheckLst,
  Buttons, LMDControl;

type
  TLMDfrmSectionBarEditorDlg = class(TForm)
    grpSection: TGroupBox;
    btnSectionAdd: TButton;
    btnSectionRename: TButton;
    btnSectionDelete: TButton;
    btnSectionMoveUp: TButton;
    btnSectionCopyImages: TButton;
    grpItems: TGroupBox;
    LMDSimpleLabel6: TLabel;
    btnItemAdd: TButton;
    btnSectionMoveDown: TButton;
    btnOK: TButton;
    Button1: TButton;
    btnSectionClear: TButton;
    btnItemInsert: TButton;
    btnItemDelete: TButton;
    btnItemMoveUp: TButton;
    btnItemMoveDown: TButton;
    btnItemClear: TButton;
    btnItemRename: TButton;
    btnSectionInsert: TButton;
    lbd: TLabel;
    acSmallImages: TLabel;
    edCaption: TEdit;
    edHint: TEdit;
    lblCaption: TLabel;
    lblHint: TLabel;
    lblTag: TLabel;
    lblCustomData: TLabel;
    edCustomData: TEdit;
    Label1: TLabel;
    edSectionCaption: TEdit;
    Label2: TLabel;
    edSectionHint: TEdit;
    Label3: TLabel;
    edSmall: TEdit;
    edLarge: TEdit;
    lbOptions: TCheckListBox;
    btnSmall: TSpeedButton;
    btnLarge: TSpeedButton;
    btnCopyReadOnly: TButton;
    btnCopyAllowDown: TButton;
    Label4: TLabel;
    Label5: TLabel;
    btnCopyLargeImages: TButton;
    btnFont: TButton;
    btnCopyFont: TButton;
    bbarMenu: TLMDSectionBarPopupMenu;
    bbar: TLMDSectionBar;
    edSectionTag: TLMDShSpinEdit;
    edTag: TLMDShSpinEdit;
    cbSmall: TLMDImageCBox;
    cbLarge: TLMDImageCBox;
    procedure btnClick(Sender: TObject);
    procedure bbarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbOptionsClickCheck(Sender: TObject);
    procedure btnimlClick(Sender: TObject);
    procedure edKeyPress(Sender: TObject; var Key: Char);
    procedure edExit(Sender: TObject);
    procedure bbarItemClick(Sender: TObject;
      Section: TLMDSectionBarSection; Item: TLMDSectionBarItem);
  private
  public
     FEditItem: Integer;
     FDesigner: IDesigner;
     procedure UpdateData;
  end;

implementation
uses
  pLMDBarSelectIMLDlg;

{$R *.DFM}

{------------------------------------------------------------------------------}
procedure TLMDfrmSectionBarEditorDlg.btnClick(Sender: TObject);
begin
  // Sections
  if Sender=btnSectionAdd then
    begin
      bbar.SectionAdd(true, false);
    end;
  if Sender=btnSectionInsert then
    bbar.SectionInsert(bbar.ActiveSectionIndex, true, false);
  if Sender=btnSectionRename then
    bbar.SectionEdit;
  if Sender=btnSectionDelete then
    bbar.SectionDelete;
  if Sender=btnFont then
    with TFontDialog.Create(self) do
      try
        Font.Assign(bbar.ActiveSection.Font);
        Font.Color:=clBlack;
        if Execute then
          bbar.ActiveSection.Font:=Font;
      finally
        free;
      end;

  if Sender=btnSectionMoveUp then
    bbar.SectionMove(bbar.ActiveSectionIndex-1);
  if Sender=btnSectionMoveDown then
    bbar.SectionMove(bbar.ActiveSectionIndex+1);
  if Sender=btnSectionClear then
    if MessageDlg('Do you really want to clear all sections?', mtConfirmation, [mbYes,mbNo], 0)=mrYes then
      bbar.ActiveSections.Clear;
  if Sender=btnSectionCopyImages then
    bbar.SectionsCopyImageSettings;
  if Sender=btnCopyReadOnly then
    bbar.SetReadOnly(bbar.ActiveSection.ReadOnly);
  if Sender=btnCopyLargeImages then
    if bbar.ActiveSection.ViewStyle=lvsLargeImages then
      bbar.SetViewStyle(lvsLargeImages)
    else
      bbar.SetViewStyle(lvsSmallImages);
  if Sender=btnCopyAllowDown then
    bbar.SetAllowDownState(bbar.ActiveSection.AllowDown);
  if sender=btnCopyFont then
    bbar.SetFont(bbar.ActiveSection.Font);

  // Items
  if Sender=btnItemAdd then
    bbar.ItemAdd;
  if sender=btnItemInsert then
    bbar.ItemInsert(bbar.ActiveSection.DownItemIndex);
  if sender=btnItemDelete then
    bbar.ItemDelete;
  if Sender=btnItemClear then
    if MessageDlg('Do you really want to clear all items?', mtConfirmation, [mbYes,mbNo], 0)=mrYes then
      bbar.ActiveSection.Items.Clear;
  if Sender=btnItemRename then
    bbar.ItemEdit;

  if sender=btnItemMoveUp then
    bbar.ItemMove(bbar.ActiveSection.DownItemIndex-1);
  if sender=btnItemMoveDown then
    bbar.ItemMove(bbar.ActiveSection.DownItemIndex+1);

  UpdateData;
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmSectionBarEditorDlg.UpdateData;
var
  tmp:Boolean;

  procedure SetIMLData(iml:TCustomImageList; aCombo:TLMDImageCBox; lbl:TEdit);
  begin
    aCombo.Enabled:=Assigned(iml) and (bbar.ActiveSectionIndex<>-1) and (bbar.ActiveSection.AllowDown=True) and (bbar.ActiveSection.DownItemIndex<>-1);
    if Assigned(IML) then
      begin
        lbl.Text:=IML.Name+' ('+inttostr(IML.Count)+' items)';
        if aCombo.Enabled then aCombo.ImageList:=IML else aCombo.ImageList:=nil;
      end
    else
      begin
        lbl.Text:='(none)';
        aCombo.ImageList:=nil;
      end;
    lbl.Enabled:=bbar.ActiveSectionIndex<>-1;
  end;

  procedure DisableControl(aControl:TCustomEdit);
  begin
    aControl.Text:='';
    aControl.Enabled:=false;
  end;

  procedure EnableControl(aControl:TCustomEdit; const aValue:String);
  begin
    aControl.Enabled:=true;
    aControl.Text:=AValue;
  end;

  procedure FillBox;
  var
    i:Integer;
  begin
    if bbar.ActiveSectionIndex<>-1 then
      with bbar.ActiveSection do
        begin
          lbOptions.Checked[0]:=ViewStyle=lvsLargeImages;
          lbOptions.Checked[1]:=ReadOnly;
          lbOptions.Checked[2]:=AllowDown;
        end
    else
      for i:=0 to lbOptions.Items.Count-1 do lbOptions.Checked[i]:=false;
    lbOptions.Enabled:=bbar.ActiveSectionIndex<>-1;
  end;

begin
  tmp:=(bbar.ActiveSectionIndex<>-1);
  btnSectionMoveUp.Enabled:=bbar.ActiveSectionIndex>0;
  btnSectionMoveDown.Enabled:= tmp and (bbar.ActiveSectionIndex<bbar.ActiveSections.Count-1);
  btnSectionDelete.Enabled:=bbar.ActiveSectionIndex<>-1;
  btnSectionCopyImages.Enabled:=tmp and (bbar.ActiveSections.Count>1);

  btnSectionRename.Enabled:=btnSectionDelete.Enabled;
  btnSectionInsert.Enabled:=btnSectionDelete.Enabled;
  btnSectionClear.Enabled:=bbar.ActiveSections.Count>0;
  btnFont.Enabled:=tmp;
  btnCopyFont.Enabled:=btnSectionCopyImages.Enabled;
  btnCopyReadOnly.Enabled:=btnSectionCopyImages.Enabled;
  btnCopyAllowDown.Enabled:=btnSectionCopyImages.Enabled;
  btnCopyLargeImages.Enabled:=btnSectionCopyImages.Enabled;
  // Settings for curren section
  if bbar.ActiveSectionIndex<>-1 then
    begin
      SetIMLData(bbar.ActiveSection.SmallImages, cbSmall, edSmall);
      SetIMLData(bbar.ActiveSection.LargeImages, cbLarge, edLarge);
      EnableControl(edSectionCaption ,bbar.ActiveSection.Caption);
      EnableControl(edSectionHint, bbar.ActiveSection.Hint);
      EnableControl(edSectionTag, Inttostr(bbar.ActiveSection.Tag));
    end
  else
    begin
      SetIMLData(nil, cbSmall, edSmall);
      SetIMLData(nil, cbLarge, edLarge);
      DisableControl(edSectionCaption);
      DisableControl(edSectionHint);
      DisableControl(edSectionTag);
    end;
  btnLarge.Enabled:=edLarge.Enabled;
  btnSmall.Enabled:=edSmall.Enabled;
  FillBox;

  // Settings for current item
  btnItemAdd.Enabled:=btnSectionDelete.Enabled;
  btnItemInsert.Enabled:=btnItemAdd.Enabled;
  btnItemClear.Enabled:=btnItemAdd.Enabled and (bbar.ActiveSection.Items.Count>0);

  tmp:=tmp and (bbar.ActiveSection.AllowDown=True) and (bbar.ActiveSection.DownItemIndex<>-1);

  btnItemRename.Enabled:=tmp;
  btnItemDelete.Enabled:=btnItemRename.Enabled;
  btnItemMoveUp.Enabled:=tmp and (bbar.ActiveSection.DownItemIndex>0);
  btnItemMoveDown.Enabled:=tmp and (bbar.ActiveSection.DownItemIndex<bbar.ActiveSection.Items.Count-1);

  if tmp then
    with bbar.ActiveSection.DownItem do
      begin
        if cbSmall.Enabled then cbSmall.ItemIndex:=ImageIndex;
        if cbLarge.Enabled then cbLarge.ItemIndex:=ImageIndex;
        EnableControl(edCaption, Caption);
        EnableControl(edHint, Hint);
        edTag.Value:=Tag;
        EnableControl(edCustomData, CustomData);
      end
  else
    begin
      DisableControl(edCaption);
      DisableControl(edHint);
      DisableControl(edTag);
      DisableControl(edCustomData);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmSectionBarEditorDlg.bbarChange(Sender: TObject);
begin
  UpdateData;
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmSectionBarEditorDlg.FormCreate(Sender: TObject);
begin
  UpdateData;
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmSectionBarEditorDlg.lbOptionsClickCheck(Sender: TObject);
begin
  with bbar.ActiveSection do
    begin
      If lbOptions.Checked[0] then ViewStyle:=lvsLargeImages else ViewStyle:=lvsSmallImages;
      ReadOnly:=lbOptions.Checked[1];
      AllowDown:=lbOptions.Checked[2];
    end;
  UpdateData;
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmSectionBarEditorDlg.btnimlClick(Sender: TObject);
var
  tmp:TLMDfrmBarSelectIMLDlg;
begin
  tmp:=TLMDfrmBarSelectIMLDlg.Create(nil);
  with tmp do
    try
       Design:=self.FDesigner;
       AddImageLists;
       if (sender=btnSmall) or (sender=edSmall) then
          ImageList:=bbar.ActiveSection.SmallImages;
       if (sender=btnLarge) or (sender=edLarge) then
          ImageList:=bbar.ActiveSection.LargeImages;
       ln.ItemIndex:=ln.Items.IndexofObject(ImageList);
       if ShowModal=mrOK then
         begin
           if (sender=btnSmall) or (sender=edSmall) then
             bbar.ActiveSection.SmallImages:=ImageList;
           if (sender=btnLarge) or (sender=edLarge) then
             bbar.ActiveSection.LargeImages:=ImageList;
           UpdateData;
         end;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmSectionBarEditorDlg.edKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (key=#32) or (key=#13) then
    btnIMLClick(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmSectionBarEditorDlg.edExit(Sender: TObject);
begin
  if sender=edSectionCaption then
    bbar.ActiveSection.Caption:=edSectionCaption.Text;
  if sender=edSectionHint then
    bbar.ActiveSection.Hint:=edSectionHint.Text;
  if sender=edSectionTag then
    bbar.ActiveSection.Tag:=edSectionTag.Value;

  if Sender=edCaption then
    bbar.ActiveSection.DownItem.Caption:=edCaption.Text;
  if Sender=edHint then
    bbar.ActiveSection.DownItem.Hint:=edHint.Text;
  if Sender=edTag then
    bbar.ActiveSection.DownItem.Tag:=edTag.Value;
  if Sender=edCustomData then
    bbar.ActiveSection.DownItem.CustomData:=edCustomData.Text;

  if Sender=cbLarge then
    begin
      bbar.ActiveSection.DownItem.ImageIndex:=cbLarge.ItemIndex;
      if cbSmall.Enabled then cbSmall.ItemIndex:=cbLarge.ItemIndex;
    end;
  if Sender=cbSmall then
    begin
      bbar.ActiveSection.DownItem.ImageIndex:=cbSmall.ItemIndex;
      if cbLarge.Enabled then cbLarge.ItemIndex:=cbSmall.ItemIndex;
    end;

  if Sender=edCaption then
    bbar.ActiveSection.DownItem.Caption:=edCaption.Text;
  if Sender=edHint then
    bbar.ActiveSection.DownItem.Hint:=edHint.Text;
  if Sender=edTag then
     bbar.ActiveSection.DownItem.Tag:=edTag.Value;
  if Sender=edCustomData then
     bbar.ActiveSection.DownItem.CustomData:=edCustomData.Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmSectionBarEditorDlg.bbarItemClick(Sender: TObject;
  Section: TLMDSectionBarSection; Item: TLMDSectionBarItem);
begin
   UpdateData;
end;

end.
