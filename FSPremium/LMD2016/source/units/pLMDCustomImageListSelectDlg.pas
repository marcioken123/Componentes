unit pLMDCustomImageListSelectDlg;
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

pLMDCustomImageListSelectDlg Unit (RM)
--------------------------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, 
  Windows, Consts, Classes, Graphics, Forms, Controls, Messages, Dialogs, Buttons,
  TypInfo, StdCtrls, ExtCtrls, ComCtrls, ImgList,
  LMDCustomImageList, LMDCont;

type
  TLMDCustImgListSelectDlg = class(TForm)
    LMDSimplePanel2: TPanel;
    Label1: TLabel;
    cmb: TComboBox;
    LMDSimplePanel1: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    Button2: TButton;
    ll: TListView;
    ImageList1: TImageList;
    lv: TListBox;
    Header: THeaderControl;
    procedure lbDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cmbChange(Sender: TObject);
    procedure lbDblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure llClick(Sender: TObject);
    procedure lvCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
  private
    tmp:TBitmap;
    FSelect:Boolean;
    FDesigner: IDesigner;
    procedure SetMultiSelect(aValue:Boolean);
    procedure SetImageList(aValue:TCustomImageList);
    procedure GetLists(const S: string);
    procedure AddItem(const sType:String; sCount:Integer; const sName:String; sData:TObject);
  public
    FImageList: TCustomImageList;
    procedure AddImageLists;
    procedure SetLabels;
    procedure SetListIndex(nr:Integer);
    property Design: IDesigner read FDesigner write FDesigner;
    property ImageList:TCustomImageList read FImageList write SetImageList;
    property MultiSelect:Boolean read FSelect write SetMultiSelect;
  end;

implementation
uses
  SysUtils, LMDUtils, LMDGraphUtils, LMDBitmapList, LMDGraphicList;

{$R *.DFM}

{********************* Class TLMDCustImgListSelectDlg *************************}
{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.SetMultiSelect(aValue:Boolean);
begin
  lv.MultiSelect:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.SetImageList(aValue:TCustomImageList);
begin
  FImageList:=aValue;
  SetLabels;
  if cmb.Items.Count>0 then SetListIndex(0);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.AddItem(const sType:String; sCount:Integer; const sName:String; sData:TObject);
begin
  with ll.Items.Add do
    begin
      Caption:=sType;
      Data:=sData;
      SubItems.Add(Inttostr(sCount));
      SubItems.Add(sName);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.GetLists(const S:String);
var
  tmp:TComponent;
  stype:String;
begin
 tmp:=FDesigner.GetComponent(s);
 if tmp is TLMDCustomImagelist then
   begin
     if LMDIsSingleItemImageList(TLMDCustomImageList(tmp)) then
       stype:='LMD'
     else
       stype:='LMDL';
   end
 else
   stype:='VCL';

 AddItem(stype, LMDIMLCount(TCustomImageList(tmp), 0), S, tmp);
end;

{------------------------------- public ---------------------------------------}
Procedure TLMDCustImgListSelectDlg.SetLabels;
var
  i:Integer;

  procedure AddColumn(const capt:String; w:Integer);
  begin
    with Header.Sections.Add do
      begin
        Text:=capt;
        Width:=w;
      end;
  end;
begin
  lv.Items.Clear;
  header.Sections.Clear;
  cmb.Clear;
  if ImageList=nil then exit;

  cmb.Enabled:=(not LMDIsSingleItemImageList(ImageList)) and (LMDIMLCount(ImageList)>0);
  label1.Enabled:=cmb.Enabled;

  AddColumn('Nr.', 48);
  if not cmb.Enabled then
    begin
      AddColumn('ID', 48);
    AddColumn('Image', 154);
    end
  else
    AddColumn('Image', 202);
  if cmb.Enabled then
    begin
      for i:=0 to Pred(LMDIMLCount(ImageList)) do
        if (ImageList is TLMDCustomImageList) and (TLMDCustomImageList(ImageList).Contents[i].Description<>'') then
          cmb.Items.Add(TLMDCustomImageList(ImageList).Contents[i].Description)
        else
          cmb.Items.Add('NoName '+inttostr(i));
    end
  else
    for i:=0 to Pred(LMDIMLCount(ImageList)) do
      lv.Items.Add(IntToStr(i+1));
end;

{------------------------------------------------------------------------------}
Procedure TLMDCustImgListSelectDlg.SetListIndex(nr:Integer);
var
  i:Integer;
begin
  if (ImageList=nil) then exit;

  if not LMDIsSingleItemImageList(ImageList) then
    begin
      if cmb.Items.Count>0 then
        cmb.ItemIndex:=nr;

      with TLMDCustomImageList(ImageList) do
        begin
          lv.Items.Clear;
          for i:=0 to Pred(ItemCount(nr)) do lv.Items.Add(IntToStr(i+1));
        end;
    end;

  if lv.Items.Count>0 then
    lv.ItemIndex:=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.lbDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  tmp:TRect;
  t, tl:Integer;
  tmpfc:TColor;
begin
  t:=Index;
  tmp:=Rect;

  with lv.Canvas do
    begin
      if odSelected in State then
        begin
          Brush.Color:=clHighlight;
          tmpfc:=clHighlightText;
        end
      else
        begin
          tmpfc:=lv.Font.Color;
          Brush.Color:=lv.Color;
        end;

      Canvas.Font.Color:=tmpfc;
      Brush.Style := bsSolid;
      FillRect(Rect);
      Brush.Style := bsClear;

      {Index-Nr.}
      tmp.Right:=tmp.Left+Header.Sections[0].Width-2;
      LMDDrawTextExt(lv.Canvas, inttostr(t), nil, tmp, DT_CENTER or DT_VCENTER or DT_SINGLELINE);

      {Index-Nr.}
      if LMDIsSingleItemImageList(ImageList)  then
        begin
          tmp.Left:=tmp.Right+2;
          tmp.Right:=tmp.Left+Header.Sections[1].Width-4;
          if ImageList is TLMDBitmapList then
            LMDDrawTextExt(lv.Canvas, inttostr(TLMDBitmapList(ImageList).Items[t].Ident), nil, tmp, DT_CENTER or DT_VCENTER or DT_SINGLELINE)
          else
            if ImageList is TLMDGraphicList then
              LMDDrawTextExt(lv.Canvas, inttostr(TLMDGraphicList(ImageList).Graphics[t].Index), nil, tmp, DT_CENTER or DT_VCENTER or DT_SINGLELINE)
            else
              LMDDrawTextExt(lv.Canvas, inttostr(t), nil, tmp, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
          tl:=t;
        end
      else
        tl:=cmb.ItemIndex;

      {Bitmap}
      tmp.Left:=tmp.Right+4;
      if not LMDIMLIsValidItem(ImageList, tl, t) then
        begin
          tmp.Right:=tmp.Left+Header.Sections[2].Width-4;
          LMDDrawTextExt(lv.Canvas, srNone, nil, tmp, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
        end
      else
        begin
          Inc(tmp.Top,2);
          if LMDIMLItemWidth(ImageList, tl)<Rect.Right-tmp.Left then
            tmp.Right:=tmp.Left+LMDIMLItemWidth(ImageList, tl)
          else
            tmp.Right:=Rect.Right;

          if LMDIMLItemHeight(ImageList, tl)<lv.ItemHeight-4 then
            tmp.Bottom:=tmp.Top+LMDIMLItemHeight(ImageList, tl)
          else
            tmp.Bottom:=Rect.Bottom-2;
          // draw image
          LMDIMLDrawExt(lv.Canvas, tmp, DSF_STRETCHKEEPRATIO, ImageList, tl, t);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.FormCreate(Sender: TObject);
begin
  tmp:=TBitmap.Create;
  FDesigner:=nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.FormDestroy(Sender: TObject);
begin
  tmp.Free;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.cmbChange(Sender: TObject);
begin
  if cmb.ItemIndex<>-1 then SetListIndex(cmb.ItemIndex);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.lbDblClick(Sender: TObject);
begin
  ModalResult:=mrOK;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.AddImageLists;
var
  TD:PTypeData;
begin
  ll.Items.Clear;
  {global Elements}
  AddItem('LMD', LMDContainer.BitmapList.Count, LMD_ICGLOBALBML, LMDContainer.BitmapList);
  AddItem('LMDL', LMDContainer.ImageList.Count, LMD_ICGLOBALIML, LMDContainer.ImageList);

  {current form}
  if FDesigner<>nil then
    begin
      TD := GetTypeData(TCustomImageList.ClassInfo);
      FDesigner.GetComponentNames(TD, GetLists);
    end;
  ll.Selected:=ll.FindData(0, FImageList, true, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.Button2Click(Sender: TObject);
begin
  FImageList:=nil;
  ModalResult:=mrOK;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.FormActivate(Sender: TObject);
begin
  if FDesigner=nil then
    ll.Enabled:=False;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.llClick(Sender: TObject);
begin
  if ll.FindData(0, ImageList, True, false)<>ll.Selected then
    begin
      if ll.Selected<>nil then
        ImageList:=TCustomImageList(ll.Selected.Data);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustImgListSelectDlg.lvCustomDrawItem(
  Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
    DefaultDraw:=True;
end;

end.

