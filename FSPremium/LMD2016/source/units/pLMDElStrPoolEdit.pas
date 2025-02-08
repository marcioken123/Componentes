unit pLMDElStrPoolEdit;
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

pLMDElStrPoolEdit unit
----------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDTypes,
  pLMDCst, ElTree, StdCtrls, ElACtrls, ElSplit, ExtCtrls, ElPanel, ElBtnCtl,
  ElPopBtn, Menus, ElStrArray,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  ElStrPool, ElVCLUtils, TypInfo, ElFrmPers, ElIni,
  ElXPThemedControl, ElEdits, ElComponent, ElTreeInplaceEditors;

type
  TStrPoolEditForm = class(TForm)
    ElPanel1: TElPanel;
    ElPanel2: TElPanel;
    ElPanel3: TElPanel;
    ElSplitter1: TElSplitter;
    ElPanel4: TElPanel;
    List: TElTree;
    OkBtn: TElPopupButton;
    CancelBtn: TElPopupButton;
    AddBtn: TElPopupButton;
    InsertBtn: TElPopupButton;
    DeleteBtn: TElPopupButton;
    PopupMenu: TPopupMenu;
    AddItem: TMenuItem;
    InsertItem: TMenuItem;
    DeleteItem: TMenuItem;
    MainMenu: TMainMenu;
    Pool1: TMenuItem;
    Clear1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Text1: TMenuItem;
    Open2: TMenuItem;
    Save2: TMenuItem;
    ElFormPersist1: TElFormPersist;
    ElIniFile1: TElIniFile;
    UpBtn: TElPopupButton;
    DownBtn: TElPopupButton;
    CopyBtn: TElPopupButton;
    Memo: TElEdit;
    procedure ListItemFocused(Sender: TObject);
    procedure AddBtnClick(Sender: TObject);
    procedure InsertBtnClick(Sender: TObject);
    procedure DeleteBtnClick(Sender: TObject);
    procedure ListItemDeletion(Sender: TObject; Item: TElTreeItem);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListVirtualTextNeeded(Sender: TObject; Item: TElTreeItem;
      SectionIndex: Integer; var Text: TLMDString);
    procedure ListVirtualHintNeeded(Sender: TObject; Item: TElTreeItem;
      var Hint: TLMDString);
    procedure UpBtnClick(Sender: TObject);
    procedure DownBtnClick(Sender: TObject);
    procedure CopyBtnClick(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
  private
    CurIndex : integer;
    StrArray : TLMDStringArray;
  public
    procedure GetData(anArray : TLMDStringArray);
    procedure SetData(anArray : TLMDStringArray);
  end;

implementation

{$R *.DFM}

procedure TStrPoolEditForm.ListItemFocused(Sender: TObject);
var b : boolean;
begin
  if csDestroying in ComponentState then exit;
  b := List.ItemFocused <> nil;
  InsertBtn.Enabled := b;
  DeleteBtn.Enabled := b;
  InsertItem.Enabled := b;
  DeleteItem.Enabled := b;
  Memo.Enabled := b;
  CopyBtn.Enabled := b;

  if CurIndex <> -1 then
  begin
    StrArray[CurIndex] := Memo.Text;
    List.Items[CurIndex].RedrawItem(true);
    // List.Items[CurIndex].Text := StrArray[CurIndex];
  end;
  if b then
     CurIndex := List.ItemFocused.Index
  else
     CurIndex := -1;
  if CurIndex <> -1 then
    Memo.Text := StrArray[CurIndex];
  UpBtn.Enabled := CurIndex > 0;
  DownBtn.Enabled := (CurIndex >= 0) and (CurIndex < List.Items.Count - 1);
end;

procedure TStrPoolEditForm.AddBtnClick(Sender: TObject);
begin
  List.ItemFocused := List.Items.AddItem(nil);
  // List.ItemFocused.ColumnText.Add(IntToStr(List.ItemFocused.Index));
  StrArray.Add('');
  Memo.SetFocus;
end;

procedure TStrPoolEditForm.InsertBtnClick(Sender: TObject);
//var oi : TElTreeItem;
//    i : integer;
begin
  List.Items.BeginUpdate;
  // oi := List.ItemFocused;
  List.ItemFocused := List.Items.InsertItem(List.ItemFocused.Index, nil);
  StrArray.Insert(CurIndex, '');
  // oi.Text := List.ItemFocused.Text;
  // List.ItemFocused.Text := '';
  Memo.Text := '';
  List.Items.EndUpdate;
  Memo.SetFocus;
  (*
  List.Items.BeginUpdate;
  for i := 0 to List.Items.Count - 1 do
  begin
    if List.Items[i].ColumnText.Count > 0 then
       List.Items[i].ColumnText[0] := IntToStr(i)
    else
       List.Items[i].ColumnText.Add(IntToStr(i));
  end;
  List.Items.EndUpdate;
  *)
end;

procedure TStrPoolEditForm.DeleteBtnClick(Sender: TObject);
// var AnItem : TElTreeItem;
begin
  Memo.Lines.Clear;
  CurIndex := -1;
  List.Items.BeginUpdate;
  if List.ItemFocused <> nil then
    List.Items.DeleteItem(List.ItemFocused);
  if List.ItemFocused <> nil then
    CurIndex := List.ItemFocused.Index;
  // for i := 0 to List.Items.Count - 1 do List.Items[i].ColumnText[0] := IntToStr(i);
  List.Items.EndUpdate;
  UpBtn.Enabled := CurIndex > 0;
  DownBtn.Enabled := (CurIndex >= 0) and (CurIndex < List.Items.Count - 1);
end;

procedure TStrPoolEditForm.ListItemDeletion(Sender: TObject;
  Item: TElTreeItem);
begin
  if StrArray <> nil then
     StrArray.Delete(Item.Index);
end;

procedure TStrPoolEditForm.GetData(anArray : TLMDStringArray);
begin
  if CurIndex <> -1 then
    StrArray[CurIndex] := Memo.Text;
  anArray.Assign(StrArray);
end;

procedure TStrPoolEditForm.SetData(anArray : TLMDStringArray);
var i : integer;
    //ti: TElTreeItem;
begin
  StrArray.Assign(anArray);
  CurIndex := -1;

  for i := 0 to StrArray.Count - 1 do    { Iterate }
  begin
    List.Items.AddItem(nil);
    //ti.Text := StrArray[i];
    //ti.ColumnText.Add(IntToStr(i));
  end;    { for }
end;

procedure TStrPoolEditForm.FormCreate(Sender: TObject);
begin
  StrArray := TLMDStringArray.Create;
  ElIniFile1.Path := LMDELPACK_REGISTRYPATH;
end;

procedure TStrPoolEditForm.FormDestroy(Sender: TObject);
var
  p: TObject;
begin
  p := StrArray;
  StrArray := nil;
  p.Free;
end;

procedure TStrPoolEditForm.ListVirtualTextNeeded(Sender: TObject;
  Item: TElTreeItem; SectionIndex: Integer; var Text: TLMDString);
begin
  if SectionIndex = 0 then
    Text := IntToStr(Item.AbsoluteIndex)
  else
    Text := Copy(StrArray[Item.AbsoluteIndex], 1, 128);
end;

procedure TStrPoolEditForm.ListVirtualHintNeeded(Sender: TObject;
  Item: TElTreeItem; var Hint: TLMDString);
begin
  Hint := StrArray[Item.AbsoluteIndex];
end;

procedure TStrPoolEditForm.UpBtnClick(Sender: TObject);
var i : integer;
begin
  Memo.Lines.Clear;
  CurIndex := -1;

  if List.ItemFocused <> nil then
    begin
      i := List.ItemFocused.Index;
      StrArray.Move(i, i - 1);
      List.ItemFocused.MoveToIns(nil, i - 1);
    end;
  ListItemFocused(Self);
  if List.ItemFocused <> nil then
    List.EnsureVisible(List.ItemFocused);
end;

procedure TStrPoolEditForm.DownBtnClick(Sender: TObject);
var i : integer;
begin
  Memo.Lines.Clear;
  CurIndex := -1;

  if List.ItemFocused <> nil then
  begin
    i := List.ItemFocused.Index;
    StrArray.Move(i, i + 1);
    List.ItemFocused.MoveToIns(nil, i + 1);
  end;
  ListItemFocused(Self);
  if List.ItemFocused <> nil then
    List.EnsureVisibleBottom(List.ItemFocused);
end;

procedure TStrPoolEditForm.CopyBtnClick(Sender: TObject);
var s : String;
begin
  if CurIndex <> -1 then
    S := Memo.Text// StrArray[CurIndex]
  else
    S := '';

  List.ItemFocused := List.Items.AddItem(nil);
  // List.ItemFocused.ColumnText.Add(IntToStr(List.ItemFocused.Index));
  List.ItemFocused.RedrawItem(true);
  StrArray.Add(S);
  Memo.Text := S;
  Memo.SetFocus;
end;

procedure TStrPoolEditForm.OkBtnClick(Sender: TObject);
begin
  List.ItemFocused := nil;
end;

end.
