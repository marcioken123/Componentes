unit pLMDElItemsProp;
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

pLMDElItemsProp unit
--------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  Buttons, ExtCtrls, ElTree, pLMDElItemCol, Dialogs,

  ElTreeCombo,
  ElTreeTreeComboEdit,

  LMDUtils, ElXPThemedControl, ElTreeInplaceEditors, ElBtnCtl, ElPopBtn;

type
  TItemsPropDlg = class(TForm)
    ItemsGB : TGroupBox;
    OpenDlg : TOpenDialog;
    SaveDlg : TSaveDialog;
    Tree : TElTree;
    Panel1: TPanel;
    Panel2: TPanel;
    NewItemBtn: TElPopupButton;
    SubitemBtn: TElPopupButton;
    DeleteBtn: TElPopupButton;
    SaveBtn: TElPopupButton;
    LoadBtn: TElPopupButton;
    EditBtn: TElPopupButton;
    MoveRightBtn: TElPopupButton;
    MoveLeftBtn: TElPopupButton;
    MoveDownBtn: TElPopupButton;
    MoveUpBtn: TElPopupButton;
    DuplicateBtn: TElPopupButton;
    OKBtn: TElPopupButton;
    CancelBtn: TElPopupButton;
    ApplyBtn: TElPopupButton;
    procedure DeleteBtnClick(Sender : TObject);
    procedure SubitemBtnClick(Sender : TObject);
    procedure TreeItemFocused(Sender : TObject);
    procedure NewItemBtnClick(Sender : TObject);
    procedure EditBtnClick(Sender : TObject);
    procedure OKBtnClick(Sender : TObject);
    procedure SaveBtnClick(Sender : TObject);
    procedure LoadBtnClick(Sender : TObject);
    procedure TreeStartDrag(Sender : TObject; var DragObject : TDragObject);
    procedure TreeDragOver(Sender, Source : TObject; X, Y : Integer;
      State : TDragState; var Accept : Boolean);
    procedure TreeDragDrop(Sender, Source : TObject; X, Y : Integer);
    procedure FormCreate(Sender : TObject);
    procedure TreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MoveRightBtnClick(Sender: TObject);
    procedure MoveLeftBtnClick(Sender: TObject);
    procedure MoveUpBtnClick(Sender: TObject);
    procedure MoveDownBtnClick(Sender: TObject);
    procedure TreeDblClick(Sender: TObject);
    procedure DuplicateBtnClick(Sender: TObject);
  private
    { Private declarations }
    FDragItem : TElTreeItem;
//    procedure SetItems(value : TElTreeItems);
//    function  GetItems:TElTreeItems;
  public
    { Public declarations }
    AComp : TComponent;
    DTreeItems : TElTreeItems;
  end;

  TElTreeItemsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
    function GetValue : string; override;
  end;

var
  ItemsPropDlg : TItemsPropDlg;

implementation

{$R *.DFM}

type
  TElDragObject = class(TDragControlObject)
    function GetDragCursor(Accepted : Boolean; X, Y : Integer) : TCursor; override;
  end;

function TElDragObject.GetDragCursor(Accepted : Boolean; X, Y : Integer) : TCursor;
begin
  if Control is TElTree then
  begin
    if ((Control as TElTree).GetItemAtY(Y) <> nil) or (Accepted) then
      Result := (Control as TElTree).DragCursor
    else
      Result := crNoDrop;
  end
  else
    result := inherited GetDragCursor(Accepted, X, Y);
end;

procedure TElTreeItemsProperty.Edit;
var
  Editor : TItemsPropDlg;
begin
  Editor := TItemsPropDlg.Create(Application);
  try
    Editor.AComp := TComponent(GetComponent(0));

    if Editor.AComp is TElTreeCombo then
    begin
      Editor.DTreeItems := TElTreeCombo(Editor.AComp).Items;
      Editor.Tree.Font.Assign(TElTreeCombo(Editor.AComp).Font);
    end
    else
      if Editor.AComp is TElTreeInplaceTreeComboEdit then
      begin
        Editor.DTreeItems := TElTreeInplaceTreeComboEdit(Editor.AComp).Editor.Items;
        Editor.Tree.Font.Assign(TElTreeInplaceTreeComboEdit(Editor.AComp).Font);
      end
      else
      begin
        Editor.DTreeItems := TCustomElTree(Editor.AComp).Items;
        Editor.Tree.Font.Assign(TElTree(Editor.AComp).Font);
      end;
    Editor.Tree.Items := Editor.DTreeItems;
    Editor.ShowModal;
  finally
    Editor.Free;
  end;
end;

function TElTreeItemsProperty.GetAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TElTreeItemsProperty.GetValue;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

// ===========================================================================

procedure TItemsPropDlg.DeleteBtnClick(Sender : TObject);
var
  Form : TCustomForm;
begin
  if Tree.ItemFocused <> nil then Tree.Items.DeleteItem(Tree.ItemFocused);
  Form := LMDGetOwnerForm(AComp);
  if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
end;

procedure TItemsPropDlg.SubitemBtnClick(Sender : TObject);
var
  TSI : TElTreeItem;
var
  Form : TCustomForm;
begin
  if Tree.ItemFocused <> nil then
  begin
    Tree.ItemFocused.Expanded := true;
    TSI := Tree.Items.AddItem(Tree.ItemFocused);
    TSI.Text := 'Item ' +IntToStr(TSI.AbsoluteIndex);
    Tree.ItemFocused := TSI;
    Tree.EnsureVisible(TSI);
    Form := LMDGetOwnerForm(AComp);
    if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
  end;
end;

procedure TItemsPropDlg.TreeItemFocused(Sender : TObject);
var b : boolean;
begin
  b := Tree.ItemFocused <> nil;
  SubItemBtn.Enabled := b;
  EditBtn.Enabled := b;
  DeleteBtn.Enabled := b;
  MoveUpBtn.Enabled := b;
  MoveDownBtn.Enabled := b;
  MoveLeftBtn.Enabled := b;
  MoveRightBtn.Enabled := b;
  DuplicateBtn.Enabled := b;
end;

procedure TItemsPropDlg.NewItemBtnClick(Sender : TObject);
var
  TSI : TElTreeItem;
var
  Form : TCustomForm;
begin
  TSI := Tree.Items.AddItem(nil);
  TSI.Text := 'Item ' +IntToStr(TSI.AbsoluteIndex);
  Tree.ItemFocused := TSI;
  Tree.EnsureVisible(TSI);
  Form := LMDGetOwnerForm(AComp);
  if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
end;

procedure TItemsPropDlg.EditBtnClick(Sender : TObject);
var
  T : TItemColDlg;
var
  Form : TCustomForm;
begin
  if Tree.ItemFocused = nil then exit;
  T := nil;
  try
    T := TItemColDlg.Create(self);
    T.Item := Tree.ItemFocused;
    T.SetData;
    if T.ShowModal = mrOk then
    begin
      T.GetData;
      Form := LMDGetOwnerForm(AComp);
      if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
    end;
    Tree.SetFocus;
  finally
    T.Free;
  end;
end;

procedure TItemsPropDlg.OKBtnClick(Sender : TObject);
begin
  if Tree.Items = nil then
    MessageBox(0, 'Serious error in ElTreeItems editor. Please report to EldoS', nil, 0)
  else
    DTreeItems.Assign(Tree.Items);
end;

procedure TItemsPropDlg.SaveBtnClick(Sender : TObject);
var
  T : TFileStream;
begin
  if not SaveDlg.Execute then exit;
  T := nil;
  try
    T := TFileStream.Create(SaveDlg.FileName, fmCreate or fmShareDenyWrite);
    Tree.Items.SaveToStream(T);
  finally
    T.Free;
  end;
end;

procedure TItemsPropDlg.LoadBtnClick(Sender : TObject);
var
  T : TFileStream;
var
  Form : TCustomForm;
begin
  if not OpenDlg.Execute then exit;
  T := nil;
  try
    T := TFileStream.Create(OpenDlg.FileName, fmOpenRead or fmShareDenyWrite);
    Tree.Items.LoadFromStream(T);
    Form := LMDGetOwnerForm(AComp);
    if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
  finally
    T.Free;
  end;
end;

procedure TItemsPropDlg.TreeStartDrag(Sender : TObject;
  var DragObject : TDragObject);
begin
  FDragItem := Tree.ItemFocused;
  DragObject := TElDragObject.Create(Tree);
end;

procedure TItemsPropDlg.TreeDragOver(Sender, Source : TObject; X,
  Y : Integer; State : TDragState; var Accept : Boolean);
var
  TSI : TElTreeItem;
begin
  Accept := false;
  if (Source <> Tree) and ((not (Source is TDragControlObject)) or (TDragControlObject(Source).Control <> Tree)) then exit;
  TSI := Tree.GetItemAtY(Y);
  if (TSI <> nil) and (not TSI.IsUnder(FDragItem)) then Accept := true;
end;

procedure TItemsPropDlg.TreeDragDrop(Sender, Source : TObject; X,
  Y : Integer);
var
  TSI : TElTreeItem;
var
  Form : TCustomForm;
begin
  TSI := Tree.GetItemAtY(Y);
  if (TSI <> nil) and (not TSI.IsUnder(FDragItem)) then FDragItem.MoveToIns(TSI.Parent, TSI.Index);
  Form := LMDGetOwnerForm(AComp);
  if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
end;

procedure TItemsPropDlg.FormCreate(Sender : TObject);
begin
  TreeItemFocused(self);
end;

procedure TItemsPropDlg.TreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_LEFT) and (Shift = [ssCtrl]) then MoveLeftBtnClick(Self) else
  if (Key = VK_RIGHT) and (Shift = [ssCtrl]) then MoveRightBtnClick(Self) else
  if (Key = VK_UP) and (Shift = [ssCtrl]) then MoveUpBtnClick(Self) else
  if (Key = VK_DOWN) and (Shift = [ssCtrl]) then MoveDownBtnClick(Self);
end;

procedure TItemsPropDlg.MoveRightBtnClick(Sender: TObject);
var Item : TElTreeItem;
begin
  if (Tree.ItemFocused <> nil) then
  begin
    Item := Tree.ItemFocused;
    if Item.GetPrevSibling <> nil then
       Item.MoveToIns(Item.GetPrevSibling, 0);
  end;
end;

procedure TItemsPropDlg.MoveLeftBtnClick(Sender: TObject);
var Item : TElTreeItem;
begin
  if (Tree.ItemFocused <> nil) then
  begin
    Item := Tree.ItemFocused;
    if Item.Parent <> nil then
    begin
      Item.MoveToIns(Item.Parent.Parent, Item.Parent.Index + 1);
    end;
  end;
end;

procedure TItemsPropDlg.MoveUpBtnClick(Sender: TObject);
var Item : TElTreeItem;
begin
  if (Tree.ItemFocused <> nil) then
  begin
    Item := Tree.ItemFocused;
    if Item.Index > 0 then
      Item.MoveToIns(Item.Parent, Item.Index - 1);
  end;
end;

procedure TItemsPropDlg.MoveDownBtnClick(Sender: TObject);
var Item : TElTreeItem;
begin
  if (Tree.ItemFocused <> nil) then
  begin
    Item := Tree.ItemFocused;
    if Item.GetNextSibling <> nil then
      Item.MoveToIns(Item.Parent, Item.GetNextSibling.Index);
  end;
end;

procedure TItemsPropDlg.TreeDblClick(Sender: TObject);
var HS : integer;
    Item : TElTreeItem;
    ItemPart: TSTItemPart;
    P       : TPoint;
begin
  GetCursorPos(P);
  P := Tree.ScreenToClient(P);
  Item := Tree.GetItemAt(P.x, P.Y, ItemPart, HS);
  if Item <> nil then
  begin
    Tree.ItemFocused := Item;
    EditBtnClick(Self);
  end;
end;

procedure TItemsPropDlg.DuplicateBtnClick(Sender: TObject);
var Item,
    Item1 : TElTreeItem;

begin
  if (Tree.ItemFocused <> nil) then
  begin
    Item := Tree.ItemFocused;
    Item1 := Tree.Items.InsertItem(Item.Index + 1, Item.Parent);
    Item1.Assign(Item);
    Item1.Text := 'Item ' +IntToStr(Item1.AbsoluteIndex);
    Tree.ItemFocused := Item1;
    Tree.EnsureVisible(Item1);
  end;
end;

end.
