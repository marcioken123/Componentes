unit pLMDMMButtonFaceEditorDlg;
{$I lmdcmps.inc}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList,
  LMDGraph, LMDCont, LMDProcs, LMDCustomComponent, LMDWndProcComponent, LMDFormA,
  LMDCustomScrollBox, LMDListBox, LMDCustomButton, LMDButton, LMDThemes, LMDClass,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel, LMDCustomMMButton,
  LMDButtonBase, LMDSimpleLabel, LMDCustomImageList, LMDMMButtonFaceController,
  LMDBaseControl;

type
  TLMDButtonFaceDlg = class(TForm)
    SelectBtn: TLMDButton;
    OKButton: TLMDButton;
    CancelButton: TLMDButton;
    lb: TLMDListBox;
    nopicture: TLMDButton;
    ClearAll: TLMDButton;
    LMDSimpleLabel1: TLMDSimpleLabel;
    sync: TLMDButton;
    synchot: TLMDButton;
    LMDButton1: TLMDButton;
    procedure FormActivate(Sender: TObject);
    procedure lbDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure SelectBtnClick(Sender: TObject);
    procedure nopictureClick(Sender: TObject);
    procedure ClearAllClick(Sender: TObject);
    procedure syncClick(Sender: TObject);
    procedure lbResize(Sender: TObject);
    procedure LMDButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    FTempIndices: TLMDButtonFaceIndices;
    FIndices: TLMDButtonFaceIndices;
    FImageList: TCustomImageList;
    function GetHeighestItem: Word;
    procedure RefreshList;
  end;

implementation
uses
  TypInfo,
  LMDGraphUtils, pLMDCPGetCore, pLMDDsgnCPGetX;

{$R *.DFM}
{------------------------------------------------------------------------------}
procedure TLMDButtonFaceDlg.RefreshList;
var
  i: TLMDButtonState;
begin
  lb.Clear;
  for i:=Low(TLMDButtonState) to High(TLMDButtonState) do lb.Items.Add('');
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonFaceDlg.FormActivate(Sender: TObject);
begin
  RefreshList;
  lb.ItemHeight:=GetHeighestItem;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonFaceDlg.FormCreate(Sender: TObject);
begin
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonFaceDlg.lbDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  tmp:TRect;
  flag:Word;
begin

  if (FImageList=nil) then exit;
  lb.PrepareDrawItem(Rect, State);

  tmp:=Rect;
  flag:=0;
  with lb.Canvas do
    begin
      tmp.Right:=tmp.Left+lb.Header.Sections[0].Width-2;
      // use GetEnumName, RM
      LMDDrawTextExt(lb.Canvas, TypInfo.GetEnumName(TypeInfo(TLMDButtonState), Index), nil,tmp, DT_SINGLELINE);
      // ---------------------
      tmp.Left:=Rect.Left+lb.Header.Sections[0].Width+2;Inc(tmp.Top,2);
      tmp.Top:=tmp.Top-1;
      tmp.Bottom:=tmp.Bottom-1;
      tmp.Right:=Rect.Right-2;
      if LMDIMLIsValidItem(FImageList, FIndices[TLMDButtonState(Index)].ListIndex, FIndices[TLMDButtonState(Index)].ImageIndex) then
        begin
          if LMDIMLItemHeight(FImageList,FIndices[TLMDButtonState(Index)].ListIndex)>lb.ItemHeight then
             flag:=DSF_STRETCHKEEPRATIO;
          LMDIMLDrawExt(lb.Canvas, tmp, flag, FImageList, FIndices[TLMDButtonState(Index)].ListIndex, FIndices[TLMDButtonState(Index)].ImageIndex);
        end
      else
        LMDDrawTextExt(lb.Canvas, 'No or no valid picture assigned for this state', nil, tmp, DT_SINGLELINE);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonFaceDlg.SelectBtnClick(Sender: TObject);
var
  i,j,k : Word;
begin
  //k:=0;
  if lb.ItemIndex=-1 then exit;
  k:=lb.ItemIndex;
  i:=FIndices[TLMDButtonState(k)].ListIndex;
  j:=FIndices[TLMDButtonState(k)].ImageIndex;
  if not LMDCPGetIML(FImageList, i, j) then exit;
  FIndices[TLMDButtonState(k)].ListIndex:=i;
  FIndices[TLMDButtonState(k)].ImageIndex:=j;
  lb.ItemHeight:=GetHeighestItem;
  RefreshList;
  lb.ItemIndex:=k;
end;

{------------------------------------------------------------------------------}
function TLMDButtonFaceDlg.GetHeighestItem: word;
var
  TempH: integer;
  i: TLMDButtonState;
begin
  Result:=0;
  for i:=Low(TLMDButtonState) to High(TLMDButtonState) do
    if LMDIMLIsValidItem(FImageList, FIndices[i].ListIndex, FIndices[i].ImageIndex) then
      begin
        TempH:=LMDIMLItemHeight(FImageList,FIndices[TLMDButtonState(i)].ListIndex);
        if TempH>Result then
          if TempH>40 then
            Result:=40
          else
            Result:=TempH;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonFaceDlg.nopictureClick(Sender: TObject);
var
  k:Integer;
begin
  k:=lb.ItemIndex;
  FIndices[TLMDButtonState(lb.ItemIndex)].ListIndex:=0;
  FIndices[TLMDButtonState(lb.ItemIndex)].ImageIndex:=0;
  lb.ItemHeight:=GetHeighestItem;
  RefreshList;
  lb.ItemIndex:=k;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonFaceDlg.ClearAllClick(Sender: TObject);
var
  k:Integer;
begin
  k:=lb.ItemIndex;
  LMDMMInitFace(FIndices);
  RefreshList;
  lb.ItemIndex:=k;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonFaceDlg.syncClick(Sender: TObject);
var
  k:Integer;
begin
  k:=lb.ItemIndex;
  LMDMMSynchronize(FIndices, Sender=syncHot);
  RefreshList;
  lb.ItemIndex:=k;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonFaceDlg.lbResize(Sender: TObject);
begin
  lb.HeaderSections[1].Width:=lb.Width-112;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonFaceDlg.LMDButton1Click(Sender: TObject);
var
  k:Integer;
begin
  k:=lb.ItemIndex;
  LMDMMCopyFace(FIndices, FTempIndices);
  RefreshList;
  lb.ItemHeight:=GetHeighestItem;
  lb.ItemIndex:=k;
end;

end.
