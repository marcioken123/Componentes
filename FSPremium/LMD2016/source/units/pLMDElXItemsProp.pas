unit pLMDElXItemsProp;
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

pLMDElXItemsProp unit
---------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  Buttons, ExtCtrls, pLMDElXItemCol, Dialogs,
  LMDUtils, ElXPThemedControl, ElTreeInplaceEditors, ElXTree, ElBtnCtl,
  ElPopBtn;

type
  TXItemsPropDlg = class(TForm)
    ItemsGB : TGroupBox;
    OpenDlg : TOpenDialog;
    SaveDlg : TSaveDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    XTree: TElXTree;
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
    procedure XTreeItemFocused(Sender : TObject);
    procedure NewItemBtnClick(Sender : TObject);
    procedure EditBtnClick(Sender : TObject);
    procedure OKBtnClick(Sender : TObject);
    procedure SaveBtnClick(Sender : TObject);
    procedure LoadBtnClick(Sender : TObject);
    procedure XTreeStartDrag(Sender : TObject; var DragObject : TDragObject);
    procedure XTreeDragOver(Sender, Source : TObject; X, Y : Integer;
      State : TDragState; var Accept : Boolean);
    procedure XTreeDragDrop(Sender, Source : TObject; X, Y : Integer);
    procedure FormCreate(Sender : TObject);
    procedure XTreeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MoveRightBtnClick(Sender: TObject);
    procedure MoveLeftBtnClick(Sender: TObject);
    procedure MoveUpBtnClick(Sender: TObject);
    procedure MoveDownBtnClick(Sender: TObject);
    procedure XTreeDblClick(Sender: TObject);
    procedure DuplicateBtnClick(Sender: TObject);
  private
    { Private declarations }
    FDragXItem : TElXTreeItem;
//    procedure SetItems(value : TElTreeItems);
//    function  GetItems:TElTreeItems;
  public
    { Public declarations }
    AComp : TComponent;
    DXTreeItems : TElXTreeItems;
  end;

  TElXTreeItemsProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes : TPropertyAttributes; override;
    function GetValue : string; override;
  end;

var
  XItemsPropDlg : TXItemsPropDlg;

implementation

{$R *.DFM}

type
  TElDragObject = class(TDragControlObject)
    function GetDragCursor(Accepted : Boolean; X, Y : Integer) : TCursor; override;
  end;

function TElDragObject.GetDragCursor(Accepted : Boolean; X, Y : Integer) : TCursor;
begin
  if Control is TElXTree then
  begin
    if ((Control as TElXTree).GetItemAtY(Y) <> nil) or (Accepted) then
      Result := (Control as TElXTree).DragCursor
    else
      Result := crNoDrop;
  end
  else
    result := inherited GetDragCursor(Accepted, X, Y);
end;

procedure TElXTreeItemsProperty.Edit;
var
  Editor : TXItemsPropDlg;
begin
  Editor := TXItemsPropDlg.Create(Application);
  try
    Editor.AComp := TComponent(GetComponent(0));

{ // commented until new TElXTreeCombo and TElXTreeInplaceTreeComboEdit exists
    if Editor.AComp is TElTreeCombo then
    begin
      Editor.DXTreeItems := TElTreeCombo(Editor.AComp).Items;
    end
    else
      if Editor.AComp is TElTreeInplaceTreeComboEdit then
      begin
        Editor.DXTreeItems := TElTreeInplaceTreeComboEdit(Editor.AComp).Editor.Items;
      end
      else
}
    Editor.DXTreeItems := TCustomElXTree(Editor.AComp).Items;
    Editor.XTree.Items := Editor.DXTreeItems;
    Editor.XTree.Font.Assign(TElXTree(Editor.AComp).Font);
    Editor.ShowModal;
  finally
    Editor.Free;
  end;
end;

function TElXTreeItemsProperty.GetAttributes;
begin
  Result := [paDialog, paReadOnly];
end;

function TElXTreeItemsProperty.GetValue;
begin
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
end;

// ===========================================================================

procedure TXItemsPropDlg.DeleteBtnClick(Sender : TObject);
var
  Form : TCustomForm;
begin
  if XTree.ItemFocused <> nil then XTree.Items.DeleteItem(XTree.ItemFocused);
  Form := LMDGetOwnerForm(AComp);
  if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
end;

procedure TXItemsPropDlg.SubitemBtnClick(Sender : TObject);
var
  TSI : TElXTreeItem;
var
  Form : TCustomForm;
begin
  if XTree.ItemFocused <> nil then
  begin
    XTree.ItemFocused.Expanded := true;
    TSI := XTree.Items.AddItem(XTree.ItemFocused);
    TSI.Text := 'Item ' +IntToStr(TSI.AbsoluteIndex);
    XTree.ItemFocused := TSI;
    XTree.EnsureVisible(TSI);
    Form := LMDGetOwnerForm(AComp);
    if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
  end;
end;

procedure TXItemsPropDlg.XTreeItemFocused(Sender : TObject);
var b : boolean;
begin
  b := XTree.ItemFocused <> nil;
  SubItemBtn.Enabled := b;
  EditBtn.Enabled := b;
  DeleteBtn.Enabled := b;
  MoveUpBtn.Enabled := b;
  MoveDownBtn.Enabled := b;
  MoveLeftBtn.Enabled := b;
  MoveRightBtn.Enabled := b;
  DuplicateBtn.Enabled := b;
end;

procedure TXItemsPropDlg.NewItemBtnClick(Sender : TObject);
var
  TSI : TElXTreeItem;
var
  Form : TCustomForm;
begin
  TSI := XTree.Items.AddItem(nil);
  TSI.Text := 'Item ' +IntToStr(TSI.AbsoluteIndex);
  XTree.ItemFocused := TSI;
  XTree.EnsureVisible(TSI);
  Form := LMDGetOwnerForm(AComp);
  if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
end;

procedure TXItemsPropDlg.EditBtnClick(Sender : TObject);
var
  T : TXItemColDlg;
var
  Form : TCustomForm;
begin
  if XTree.ItemFocused = nil then exit;
  T := nil;
  try
    T := TXItemColDlg.Create(self);
    T.Item := XTree.ItemFocused;
    T.MainTreeColumn := XTree.MainTreeColumn;
    T.SetData;
    if T.ShowModal = mrOk then
    begin
      T.GetData;
      Form := LMDGetOwnerForm(AComp);
      if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
    end;
    XTree.SetFocus;
  finally
    T.Free;
  end;
end;

procedure TXItemsPropDlg.OKBtnClick(Sender : TObject);
begin
  if XTree.Items = nil then
    MessageBox(0, 'Serious error in ElXTreeItems editor. Please report to EldoS', nil, 0)
  else
    DXTreeItems.Assign(XTree.Items);
end;

procedure TXItemsPropDlg.SaveBtnClick(Sender : TObject);
var
  T : TFileStream;
begin
  if not SaveDlg.Execute then exit;
  T := nil;
  try
    T := TFileStream.Create(SaveDlg.FileName, fmCreate or fmShareDenyWrite);
    XTree.Items.SaveToStream(T);
  finally
    T.Free;
  end;
end;

procedure TXItemsPropDlg.LoadBtnClick(Sender : TObject);
var
  T : TFileStream;
var
  Form : TCustomForm;
begin
  if not OpenDlg.Execute then exit;
  T := nil;
  try
    T := TFileStream.Create(OpenDlg.FileName, fmOpenRead or fmShareDenyWrite);
    XTree.Items.LoadFromStream(T);
    Form := LMDGetOwnerForm(AComp);
    if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
  finally
    T.Free;
  end;
end;

procedure TXItemsPropDlg.XTreeStartDrag(Sender : TObject;
  var DragObject : TDragObject);
begin
  FDragXItem := XTree.ItemFocused;
  DragObject := TElDragObject.Create(XTree);
end;

procedure TXItemsPropDlg.XTreeDragOver(Sender, Source : TObject; X,
  Y : Integer; State : TDragState; var Accept : Boolean);
var
  TSI : TElXTreeItem;
begin
  Accept := false;
  if (Source <> XTree) and ((not (Source is TDragControlObject)) or (TDragControlObject(Source).Control <> XTree)) then exit;
  TSI := XTree.GetItemAtY(Y);
  if (TSI <> nil) and (not TSI.IsUnder(FDragXItem)) then Accept := true;
end;

procedure TXItemsPropDlg.XTreeDragDrop(Sender, Source : TObject; X,
  Y : Integer);
var
  TSI : TElXTreeItem;
var
  Form : TCustomForm;
begin
  TSI := XTree.GetItemAtY(Y);
  if (TSI <> nil) and (not TSI.IsUnder(FDragXItem)) then FDragXItem.MoveToIns(TSI.Parent, TSI.Index);
  Form := LMDGetOwnerForm(AComp);
  if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
end;

procedure TXItemsPropDlg.FormCreate(Sender : TObject);
begin
  XTreeItemFocused(self);
end;

procedure TXItemsPropDlg.XTreeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_LEFT) and (Shift = [ssCtrl]) then MoveLeftBtnClick(Self) else
  if (Key = VK_RIGHT) and (Shift = [ssCtrl]) then MoveRightBtnClick(Self) else
  if (Key = VK_UP) and (Shift = [ssCtrl]) then MoveUpBtnClick(Self) else
  if (Key = VK_DOWN) and (Shift = [ssCtrl]) then MoveDownBtnClick(Self);
end;

procedure TXItemsPropDlg.MoveRightBtnClick(Sender: TObject);
var Item : TElXTreeItem;
begin
  if (XTree.ItemFocused <> nil) then
  begin
    Item := XTree.ItemFocused;
    if Item.GetPrevSibling <> nil then
       Item.MoveToIns(Item.GetPrevSibling, 0);
  end;
end;

procedure TXItemsPropDlg.MoveLeftBtnClick(Sender: TObject);
var Item : TElXTreeItem;
begin
  if (XTree.ItemFocused <> nil) then
  begin
    Item := XTree.ItemFocused;
    if Item.Parent <> nil then
    begin
      Item.MoveToIns(Item.Parent.Parent, Item.Parent.Index + 1);
    end;
  end;
end;

procedure TXItemsPropDlg.MoveUpBtnClick(Sender: TObject);
var Item : TElXTreeItem;
begin
  if (XTree.ItemFocused <> nil) then
  begin
    Item := XTree.ItemFocused;
    if Item.Index > 0 then
      Item.MoveToIns(Item.Parent, Item.Index - 1);
  end;
end;

procedure TXItemsPropDlg.MoveDownBtnClick(Sender: TObject);
var Item : TElXTreeItem;
begin
  if (XTree.ItemFocused <> nil) then
  begin
    Item := XTree.ItemFocused;
    if Item.GetNextSibling <> nil then
      Item.MoveToIns(Item.Parent, Item.GetNextSibling.Index);
  end;
end;

procedure TXItemsPropDlg.XTreeDblClick(Sender: TObject);
var HS : integer;
    Item : TElXTreeItem;
    ItemPart: TSTXItemPart;
    P       : TPoint;
begin
  GetCursorPos(P);
  P := XTree.ScreenToClient(P);
  Item := XTree.GetItemAt(P.x, P.Y, ItemPart, HS);
  if Item <> nil then
  begin
    XTree.ItemFocused := Item;
    EditBtnClick(Self);
  end;
end;

procedure TXItemsPropDlg.DuplicateBtnClick(Sender: TObject);
var Item,
    Item1 : TElXTreeItem;

begin
  if (XTree.ItemFocused <> nil) then
  begin
    Item := XTree.ItemFocused;
    Item1 := XTree.Items.InsertItem(Item.Index + 1, Item.Parent);
    Item1.Assign(Item);
    Item1.Text := 'Item ' +IntToStr(Item1.AbsoluteIndex);
    XTree.ItemFocused := Item1;
    XTree.EnsureVisible(Item1);
  end;
end;

end.
