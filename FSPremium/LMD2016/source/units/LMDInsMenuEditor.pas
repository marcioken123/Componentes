unit LMDInsMenuEditor;
{$I LmdCmps.inc}

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

LMDInsMenuEditor unit (RS)
--------------------------
Menu component editor (ported from LMDElPack package).

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, ExtCtrls, ComCtrls, LMDUnicode, LMDTypes, LMDInsPropInsp,
  LMDInsEditorWnds;

type
  TLMDMenuEditorDialog = class(TForm)
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    NewSubItemBtn: TButton;
    NewItemBtn: TButton;
    DeleteItemBtn: TButton;
    OpenMenuDlg: TOpenDialog;
    SaveMenuDlg: TSaveDialog;
    Bevel2: TBevel;
    MoveUp: TButton;
    MoveDown: TButton;
    LevelUp: TButton;
    LevelDown: TButton;
    MenuEdit: TTreeView;
    Timer1: TTimer;
    procedure NewItemBtnClick(Sender: TObject);
    procedure NewSubItemBtnClick(Sender: TObject);
    procedure DeleteItemBtnClick(Sender: TObject);
    procedure MoveUpClick(Sender: TObject);
    procedure MoveDownClick(Sender: TObject);
    procedure LevelUpClick(Sender: TObject);
    procedure LevelDownClick(Sender: TObject);
    procedure MenuEditStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure MenuEditDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure MenuEditDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure MenuEditEdited(Sender: TObject; Node: TTreeNode;
      var S: String);
    procedure MenuEditChange(Sender: TObject; Node: TTreeNode);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    FMenu:         TMenu;
    FRootMenuItem: TMenuItem;
    FDragItem:     TTreeNode;
    FMenuItem:     TMenuItem;
    FCallbacks:    TLMDEditorWindowCallbacks;

    procedure CallbacksCommand(Sender: TObject;
                               ACommand: TLMDEditorWndCommand);

    procedure SetMenu(const Value: TMenu);
    procedure MenuChanged(Sender: TObject; Source: TMenuItem;
                          Rebuild: Boolean);
    procedure UpdateSelection;
    procedure UpdateStayOnTop;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
  public
    property Menu : TMenu read FMenu write SetMenu;

    class procedure OpenEditor(ACallbacks: TLMDEditorWindowCallbacks;
                               AValue: TMenuItem);
  end;

  TLMDDragObject = class (TDragControlObject)
  protected
    function GetDragCursor(Accepted: Boolean;
                           X, Y: Integer): TCursor; override;
  end;

procedure InsertItems(var AMenu: TMenu; MainItem: TMenuItem; Index: Integer;
                      Items: array of TMenuItem);
procedure InsertMenuItems(var AMenu: TMenu; Index: Integer;
                          Items: array of TMenuItem);

function  GetOwnerForm(Component: TComponent): TForm;
function  StripHotKey(const Text: TLMDString): TLMDString;

function  FindTreeNodeByMenuItem(StartNode: TTreeNode;
                                 item: TMenuItem): TTreeNode; overload;
function  FindTreeNodeByMenuItem(TreeView: TTreeView;
                                 item: TMenuItem): TTreeNode; overload;
procedure MoveTreeNodeTo(Node, DestinationNode: TTreeNode; index: integer);
function  TreeNodeIsUnder(UnderNode, AboveNode: TTreeNode): boolean;

procedure UpdateTreeNodesFromMenu(Menu: TMenu; TreeView: TTreeView); overload;
procedure UpdateTreeNodesFromMenu(MenuItem: TMenuItem; TreeView: TTreeView;
                                  ParentNode: TTreeNode); overload;

implementation

{$R *.dfm}

var
  EditorList: TList;

{ Some general utility functions}

function GetOwnerForm(Component: TComponent): TForm;
begin
  result := nil;
  while (not (Component is TForm)) and (Component.Owner <> nil) do
    Component := Component.Owner;
    if Component is TForm then
    Result := (Component as TForm);
end;

function StripHotKey(const Text: TLMDString): TLMDString;
var
  i:   Integer;
  Len: Integer;
begin
  Result := Text;
  Len := Length(Result);
  for i := 1 to Len do
  begin
    {$IFNDEF LMD_UNICODE}
    if not (Result[i] in LeadBytes) then
    {$ENDIF}
    begin
      if Result[i] = cHotKeyPrefix then
        if ((i > 1) and (Len - i >= 2) and (Result[i - 1] = '(') and
          (Result[i + 2] = ')') and Syslocale.FarEast) then
          Delete(Result, i - 1, 4)
        else
          Delete(Result, i, 1);
    end;
  end;
end;

{ Menu building procedures }

procedure InsertItems(var AMenu: TMenu; MainItem: TMenuItem; Index: Integer;
  Items: array of TMenuItem);
var
  I: Integer;

  procedure SetOwner(Item: TMenuItem);
  var
    I: Integer;
  begin
    if Item <> nil then
    begin
      if Item.Owner = nil then
      begin
        if AMenu is TPopupMenu then
          GetOwnerForm(TPopupMenu(AMenu)).InsertComponent(Item)
        else
          GetOwnerForm(TMainMenu(AMenu)).InsertComponent(Item);
      end;
      for I := 0 to Item.Count - 1 do
        SetOwner(Item[I]);
    end;
  end;

begin
  for I := Low(Items) to High(Items) do
  begin
    SetOwner(Items[I]);
    MainItem.Insert(Index, Items[I]);
  end;
end;

procedure InsertMenuItems(var AMenu: TMenu; Index: Integer; Items: array of
  TMenuItem);
var
  I: Integer;

  procedure SetOwner(Item: TMenuItem);
  var
    I: Integer;
  begin
    if Item <> nil then
    begin
      if Item.Owner = nil then
      begin
        if AMenu is TPopupMenu then
          TPopupMenu(AMenu).Owner.InsertComponent(Item)
        else
          TMainMenu(AMenu).Owner.InsertComponent(Item);
      end;
      for I := 0 to Item.Count - 1 do
        SetOwner(Item[I]);
    end;
  end;

begin
  for I := Low(Items) to High(Items) do
  begin
    SetOwner(Items[I]);
    if (Index = -1) then
    begin
      if AMenu is TPopupMenu then
        TPopupMenu(AMenu).Items.Add(Items[I])
      else
        TMainMenu(AMenu).Items.Add(Items[I]);
    end
    else
    begin
      if AMenu is TPopupMenu then
        TPopupMenu(AMenu).Items.Insert(Index, Items[I])
      else
        TMainMenu(AMenu).Items.Insert(Index, Items[I]);
    end;
  end;
end;

function FindTreeNodeByMenuItem(StartNode: TTreeNode; item: TMenuItem): TTreeNode;
var
  i: integer;
begin
  if  (StartNode <> nil) //and (StartNode.Data is TMenuItem)
    and (TMenuItem(StartNode.Data) = item) then
    Result := StartNode
  else
    Result := nil;
  i := 0;
  while (Result = nil) and (i < StartNode.Count) do
  begin
    Result := FindTreeNodeByMenuItem(StartNode.Item[i], item);
    if Result = nil then
      Inc(i);
  end;
end;

function FindTreeNodeByMenuItem(TreeView: TTreeView; item: TMenuItem): TTreeNode;
var
  i: integer;
begin
  Result := nil;
  i := 0;
  while (Result = nil) and (i < TreeView.Items.Count) do
  begin
    Result := FindTreeNodeByMenuItem(TreeView.Items[i], item);
    if Result = nil then
      Inc(i);
  end;
end;

procedure MoveTreeNodeTo(Node, DestinationNode: TTreeNode; index: integer);
var
  pos, curItem: integer;
  posCount: integer;
  found: boolean;
  function GetTopLevelCount(TreeView: TTreeView): integer;
  var
    i: integer;
  begin
    Result := 0;
    for i := 0 to TreeView.Items.Count - 1 do
      if TreeView.Items.Item[i].Level = 0 then
        Inc(Result);
  end;
  function GetTopLevelNode(TreeView: TTreeView; index: integer): TTreeNode;
  var
    i, ind: integer;
  begin
    Result := nil; 
    i := 0; ind := -1;
    while (i < TreeView.Items.Count) and (ind < index) do
    begin
      if TreeView.Items.Item[i].Level = 0 then
        Inc(ind);
      if ind = index then
        Result := TreeView.Items.Item[i];
      Inc(i);  
    end;
  end;
begin

  begin
    if DestinationNode <> nil then
      posCount := DestinationNode.Count
    else
      posCount := GetTopLevelCount(TTreeView(Node.TreeView));
    if Node.Parent <> DestinationNode then
      Inc(posCount);

    pos := 0; 
    while pos < posCount do
    begin
      if pos = index then
      begin
        Node.MoveTo(DestinationNode, naAddChild);
        Inc(pos);
      end
      else
      begin
        curItem := 0; found := false;
        while (not found) and (curItem < posCount - pos) do
        begin
          if DestinationNode <> nil then
            found := DestinationNode.Item[curItem] <> Node
          else
            found := GetTopLevelNode(TTreeView(Node.TreeView), curItem) <> Node;
          if not found then
            Inc(curItem);
        end;
        if found then
        begin
          if DestinationNode <> nil then
            DestinationNode.Item[curItem].MoveTo(DestinationNode, naAddChild)
          else
            GetTopLevelNode(TTreeView(Node.TreeView), curItem)
              .MoveTo(DestinationNode, naAddChild);

          Inc(pos);
        end;
      end;
    end;
  end;
  end;

function TreeNodeIsUnder(UnderNode, AboveNode: TTreeNode): boolean;
begin
  if (UnderNode = nil) or (AboveNode = nil) then
  begin
    result := false;
    exit;
  end;
  if UnderNode = AboveNode then
     result := true
  else
  if UnderNode.Parent <> nil then
     result := TreeNodeIsUnder(UnderNode.Parent, AboveNode)
  else
     result := false;
end;

procedure UpdateTreeNodesFromMenu(Menu: TMenu; TreeView: TTreeView);
var
  i: integer;
begin
  // Adding of new (not present in the tree) menu items and
  // caption-text synchronization.

  for i := 0 to Menu.Items.Count - 1 do
    UpdateTreeNodesFromMenu(Menu.Items[i], TreeView, nil);

  // Removing tree nodes which represent menu items which were removed from menu.
  // The notification procedure is not enough because a menu item can be removed
  // from the menu, but not destroyed.

  i := 0;
  while i < TreeView.Items.Count do
  begin
    if not (((TreeView.Items.Item[i].Level = 0) and
             (TMenuItem(TreeView.Items.Item[i].Data).Parent = Menu.Items)) or
            ((TreeView.Items.Item[i].Level > 0) and
             (TMenuItem(TreeView.Items.Item[i].Data).Parent = TMenuItem(TreeView.Items.Item[i].Parent.Data))))
    then
      TreeView.Items.Item[i].Delete // This item no longer belongs
                                    // to this menu.
    else
      Inc(i);
  end;
end;

procedure UpdateTreeNodesFromMenu(MenuItem: TMenuItem; TreeView: TTreeView;
  ParentNode: TTreeNode);
var
  i: integer;
  found: boolean;
  FoundNode: TTreeNode;
begin
  FoundNode := nil;

  // Adding of new (not present in the tree) menu items and
  // caption-text synchronization.

  i := 0;
  found := false;
  if ParentNode <> nil then
    while (not found) and (i < ParentNode.Count) do
    begin
      found := TMenuItem(ParentNode.Item[i].Data) = MenuItem;
      if found then
        FoundNode := ParentNode.Item[i]
      else
        Inc(i);
    end
  else
    while (not found) and (i < TreeView.Items.Count) do
    begin
      found := TMenuItem(TreeView.Items.Item[i].Data) = MenuItem;
      if found then
        FoundNode := TreeView.Items.Item[i]
      else
        Inc(i);
    end;
  if found then
  begin
    if FoundNode.Text <> MenuItem.Caption then
      FoundNode.Text := MenuItem.Caption;
  end
  else
  begin
    FoundNode := TreeView.Items.AddChildObject(ParentNode,MenuItem.Caption,
                                               MenuItem);
    MoveTreeNodeTo(FoundNode, ParentNode, MenuItem.MenuIndex);
  end;

  for i := 0 to MenuItem.Count - 1 do
    UpdateTreeNodesFromMenu(MenuItem.Items[i], TreeView, FoundNode);
end;

{ TLMDDesignMenu }

function NewItem(Owner: TComponent; const ACaption: TLMDString;
  AShortCut: TShortCut; AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent;
  hCtx: Word; const AName: TLMDString): TMenuItem;
begin
  Result := TMenuItem.Create(Owner);

  with Result do
  begin
    Caption := ACaption;
    ShortCut := AShortCut;
    OnClick := AOnClick;
    HelpContext := hCtx;
    Checked := AChecked;
    Enabled := AEnabled;
    Name := AName;
  end;
end;

function TLMDDragObject.GetDragCursor(Accepted: Boolean; X, Y: Integer): TCursor;
begin
  if Control is TTreeView then
  begin
    if ((Control as TTreeView).GetNodeAt(X, Y) <> nil) or (Accepted) then
       Result := (Control as TTreeView).DragCursor
    else
       Result := crNoDrop;
  end
  else
    Result:=inherited GetDragCursor(Accepted,X,Y);
end;

procedure TLMDMenuEditorDialog.MenuChanged(Sender: TObject; Source: TMenuItem;
  Rebuild: Boolean);
var
  Form: TCustomForm;
  Temp: TMenuItem;
begin
  if csDestroying in ComponentState then exit;
  if MenuEdit <> nil then
  if (MenuEdit.Selected <> nil) and (MenuEdit.Selected.Data <> nil) and
     (TComponent(MenuEdit.Selected.Data) is TMenuItem) then
  begin
    Temp := TMenuItem(MenuEdit.Selected.Data);

    if FMenu is TPopupMenu then
    begin
      if (TPopupMenu(FMenu).Images <> nil) and (MenuEdit.Images = nil) then
        MenuEdit.Images := TImageList(TPopupMenu(FMenu).Images);
    end
    else
    begin
      if (TMainMenu(FMenu).Images <> nil) then
        MenuEdit.Images := TImageList(TMainMenu(FMenu).Images);
    end;

    MenuEdit.Selected.Text := TMenuItem(MenuEdit.Selected.Data).Caption;
    MenuEdit.Selected.ImageIndex := TMenuItem(MenuEdit.Selected.Data).ImageIndex;

    if (Temp.Caption <> '-') or (FMenu is TPopupMenu) then
    begin
      while Temp.Parent <> nil do
        Temp := TMenuItem(Temp.Parent);
    end
    else
    begin
      if (Temp.Parent <> nil) then
      begin
        if (Self.FMenu is TMainMenu) then
          TMainMenu(Self.FMenu).OnChange := nil
        else
          TPopupMenu(Self.FMenu).OnChange := nil;
        TMenuItem(Temp.Parent).Remove(Temp);
        InsertItems(FMenu, TMenuItem(MenuEdit.Selected.Parent.Data),
                    MenuEdit.Selected.Index, Temp);
        if (Self.FMenu is TMainMenu) then
          TMainMenu(Self.FMenu).OnChange := Self.MenuChanged
        else
          TPopupMenu(Self.FMenu).OnChange := Self.MenuChanged;
      end;
    end;

    Form := GetOwnerForm(FMenu);
    if (Form <> nil) and (not (csDestroying in Form.ComponentState)) then
      DrawMenuBar(Form.Handle);
  end;
end;

procedure TLMDMenuEditorDialog.SetMenu(const Value: TMenu);
var
  j:     Integer;
  Count: Integer;

  function AddMenuItem (MenuItem : TMenuItem) : TTreeNode;
  var
    i: integer;
    TreeNode: TTreeNode;
    Node: TTreeNode;
  begin
    MenuItem.FreeNotification(Self);

    TreeNode := MenuEdit.Items.AddChildObject(MenuEdit.Selected,
      MenuItem.Caption, MenuItem);
    TreeNode.ImageIndex := MenuItem.ImageIndex;
    result              := TreeNode;

    for i := 0 to MenuItem.Count - 1 do
    begin
      MenuEdit.Selected := TreeNode;
      MenuEdit.Selected.Expanded := true;

      if TMenuItem(MenuItem[i]).Count > 0 then
        Node := AddMenuItem(TMenuItem(TMenuItem(MenuItem).Items[i]))
      else
      begin
        Node := MenuEdit.Items.AddChildObject(MenuEdit.Selected,
          TMenuItem(MenuItem.Items[i]).Caption, MenuItem.Items[i]);
        MenuItem.Items[i].FreeNotification(Self);
      end;

      Node.ImageIndex := TMenuItem(MenuItem[i]).ImageIndex;
    end;
  end;

begin
  if (Value <> nil) then
  begin
   FMenu := Value;

    if (FMenu <> nil) then
      FMenu.FreeNotification(Self);

    if csDestroying in ComponentState then
      exit;

    MenuEdit.Items.Clear;
    if FMenu is TPopupMenu then
    begin
      if (TPopupMenu(FMenu).Images <> nil) then
        MenuEdit.Images := TImageList(TPopupMenu(FMenu).Images);
    end
    else
    begin
      if (TMainMenu(FMenu).Images <> nil) then
        MenuEdit.Images := TImageList(TMainMenu(FMenu).Images);
    end;

    if FMenu is TPopupMenu then
      Count := TPopupMenu(FMenu).Items.Count
    else
      Count := TMainMenu(FMenu).Items.Count;

    for j := 0 to Count - 1 do
    begin
      MenuEdit.Selected := nil;

      if FMenu is TPopupMenu then
        AddMenuItem(TMenuItem(TPopupMenu(FMenu).Items[j]))
      else
        AddMenuItem(TMenuItem(TMainMenu(FMenu).Items[j]));
    end;
  end;
end;

procedure TLMDMenuEditorDialog.NewItemBtnClick(Sender: TObject);
var
  Index:    Integer;
  TreeNode: TTreeNode;
  Node:     TTreeNode;
  Form:     TCustomForm;
  Temp:     TMenuItem;
begin
  Form      := GetOwnerForm(FMenu);
  FMenuItem := TMenuItem.Create(FMenu.Owner);

  FMenuItem.Name    := FCallbacks.EditorUtils.GetUniqueCompName(FMenuItem);
  FMenuItem.Caption := FMenuItem.Name;
  FMenuItem.FreeNotification(Self);

  Index    := -1;
  TreeNode := nil;

  if (MenuEdit.Selected <> nil) then
  begin
    Index := MenuEdit.Selected.Index;

    if (MenuEdit.Selected.Level <> 0) then
      TreeNode:= MenuEdit.Selected.Parent;

    MenuEdit.Selected.Expand(False);
  end;

  if (TreeNode = nil) then
  begin
    InsertMenuItems(FMenu, Index, FMenuItem);
    Temp := FMenuItem;
  end
  else
  begin
    try
      InsertItems(FMenu, TMenuItem(TreeNode.Data), Index, FMenuItem);
    except
      Index := 0;
    end;
    Temp := TMenuItem(TreeNode.Data);
  end;

  while Temp.Parent <> nil do
    Temp := TMenuItem(Temp.Parent);

  MenuEdit.Items.BeginUpdate;
  try
    if (Index <> -1) then
      Node := MenuEdit.Items.InsertObject(MenuEdit.Selected, FMenuItem.Caption,
                                          FMenuItem)
    else
      Node := MenuEdit.Items.AddChildObject(TreeNode, FMenuItem.Caption,
                                            FMenuItem);

    Node.ImageIndex   := FMenuItem.ImageIndex;
    MenuEdit.Selected := Node;
  finally
    MenuEdit.Items.EndUpdate;
  end;

  if (Form <> nil) and not (csDestroying in Form.ComponentState) then
    DrawMenuBar(Form.Handle);

  FCallbacks.EditorUtils.MarkModified;
end;

procedure TLMDMenuEditorDialog.NewSubItemBtnClick(Sender: TObject);
Var
  TreeNode: TTreeNode;
  Node: TTreeNode;
  Form: TCustomForm;
  Temp: TMenuItem;
begin
  TreeNode := MenuEdit.Selected;

  if (TreeNode <> nil) and (TreeNode.Data <> nil) then
  begin
    FMenuItem := NewItem(FMenu.Owner, '', 0, false, true, nil, 0, '');

    FMenuItem.Name    := FCallbacks.EditorUtils.GetUniqueCompName(FMenuItem);
    FMenuItem.Caption := FMenuItem.Name;
    FMenuItem.FreeNotification(Self);

    Temp := TMenuItem(TreeNode.Data);
    Temp.Add(FMenuItem);

    while Temp.Parent <> nil do
      Temp := TMenuItem(Temp.Parent);

    Node := MenuEdit.Items.AddChildObject(TreeNode, FMenuItem.Caption,
                                          FMenuItem);
    Node.ImageIndex := FMenuItem.ImageIndex;

    if TreeNode <> nil then
      TreeNode.Expanded := true;
    MenuEdit.Selected := Node;
    MenuEdit.Selected := Node;
    Form := GetOwnerForm(FMenu);

    if (Form <> nil) and not (csDestroying in Form.ComponentState) then
      DrawMenuBar(Form.Handle);

    FCallbacks.EditorUtils.MarkModified;
  end;
end;

procedure TLMDMenuEditorDialog.DeleteItemBtnClick(Sender: TObject);
var
  Form:         TCustomForm;
  ItemToDelete: TMenuItem;
begin
  if (MenuEdit.Selected <> nil) and (MenuEdit.Selected.Data <> nil) then
  begin
    ItemToDelete := TMenuItem(MenuEdit.Selected.Data);
    ItemToDelete.Free;
  end;

  Form := GetOwnerForm(FMenu);
  if (Form <> nil) and not (csDestroying in Form.ComponentState) then
    DrawMenuBar(Form.Handle);

  FCallbacks.EditorUtils.MarkModified;
end;

procedure TLMDMenuEditorDialog.Notification(AComponent: TComponent; Operation:
    TOperation);
var
  Temp:  TMenuItem;
  Temp1: TTreeNode;
begin
  inherited;

  if (Operation = opRemove) then
  begin
    if AComponent = FMenu then
      Close
    else if AComponent is TMenuItem then
    begin
      if not (csDestroying in FMenu.ComponentState) and
         not (csDestroying in ComponentState) then
      begin
        Temp := TMenuItem(AComponent);

        if (Temp <> nil) then
        begin
          if MenuEdit.Items.Count > 0 then
            Temp1 := FindTreeNodeByMenuItem(Self.MenuEdit, temp)
          else
            Temp1 := nil;
            if Temp1 <> nil then
            Temp1.Delete;
        end;
      end;
    end;
  end;
end;

procedure TLMDMenuEditorDialog.MoveUpClick(Sender: TObject);
var
  TreeNode: TTreeNode;
  Form:     TCustomForm;
  Item:     TMenuItem;
begin
  TreeNode := MenuEdit.Selected;

  if (TreeNode <> nil) and (TreeNode.Data <> nil) then
  begin
    Item           := TMenuItem(TreeNode.Data);
    Item.MenuIndex := Item.MenuIndex - 1;

    if TreeNode.Index > 0 then
      MoveTreeNodeTo(TreeNode, TreeNode.Parent, TreeNode.Index - 1);

    Form := GetOwnerForm(FMenu);
    if (Form <> nil) and (not (csDestroying in Form.ComponentState)) then
      DrawMenuBar(Form.Handle);

    FCallbacks.EditorUtils.MarkModified;
  end;
end;

procedure TLMDMenuEditorDialog.MoveDownClick(Sender: TObject);
var
  TreeNode: TTreeNode;
  Form:     TCustomForm;
  Item:     TMenuItem;
begin
  TreeNode := MenuEdit.Selected;

  if (TreeNode <> nil) and (TreeNode.Data <> nil) then
  begin
    Item           := TMenuItem(TreeNode.Data);
    Item.MenuIndex := Item.MenuIndex + 1;

    if TreeNode.GetNextSibling <> nil then
      MoveTreeNodeTo(TreeNode, TreeNode.Parent, TreeNode.Index + 1);

    Form := GetOwnerForm(FMenu);
    if (Form <> nil) and (not (csDestroying in Form.ComponentState)) then
      DrawMenuBar(Form.Handle);

    FCallbacks.EditorUtils.MarkModified;
  end;
end;

procedure TLMDMenuEditorDialog.LevelUpClick(Sender: TObject);
var
  TreeNode: TTreeNode;
  PntItem:  TMenuItem;
  Item:     TMenuItem;
  Form:     TCustomForm;
begin
  TreeNode := MenuEdit.Selected;

  if (TreeNode <> nil) and (TreeNode.Data <> nil) and
     (TMenuItem(TreeNode.Data).Parent.Parent <> nil) then
  begin
    Item    := TMenuItem(TreeNode.Data);
    PntItem := TMenuItem(Item.Parent);

    PntItem.Remove(Item);
    PntItem.Parent.Insert(PntItem.MenuIndex + 1, Item);

    MoveTreeNodeTo(TreeNode, TreeNode.Parent.Parent, TreeNode.Parent.Index + 1);

    Form := GetOwnerForm(FMenu);
    if (Form <> nil) and (not (csDestroying in Form.ComponentState)) then
      DrawMenuBar(Form.Handle);

    FCallbacks.EditorUtils.MarkModified;
  end;
end;

procedure TLMDMenuEditorDialog.LevelDownClick(Sender: TObject);
var
  TreeNode: TTreeNode;
  Item:     TMenuItem;
  Temp:     TMenuItem;
  Form:     TCustomForm;
begin
  TreeNode := MenuEdit.Selected;

  if (TreeNode <> nil) and (TreeNode.Data <> nil) and
     (TMenuItem(TreeNode.Data).MenuIndex > 0) then
    begin
      Item := TMenuItem(TreeNode.Data);
      Temp := TMenuItem(TMenuItem(Item.Parent).Items[Item.MenuIndex - 1]);

      Item.Parent.Remove(Item);
      Temp.Insert(0, Item);

      if TreeNode.GetPrevSibling <> nil then
         MoveTreeNodeTo(TreeNode, TreeNode.getPrevSibling, 0);

      Form := GetOwnerForm(FMenu);
      if (Form <> nil) and (not (csDestroying in Form.ComponentState)) then
        DrawMenuBar(Form.Handle);

      FCallbacks.EditorUtils.MarkModified;
    end;
end;

procedure TLMDMenuEditorDialog.MenuEditStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  FDragItem  := MenuEdit.Selected;
  DragObject := TLMDDragObject.Create(MenuEdit);
end;

procedure TLMDMenuEditorDialog.MenuEditDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  Temp: TTreeNode;
begin
  Accept:=false;
  if Source.ClassType <> TLMDDragObject then
    exit;
    Temp := MenuEdit.GetNodeAt(X, Y);
  if Temp = nil then
  begin
    Accept:=true;
    exit;
  end;

  if ((not TreeNodeIsUnder(Temp, FDragItem)) and (Temp.Data <> nil)) then
    Accept:=true;
end;

procedure TLMDMenuEditorDialog.MenuEditDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Temp:     TTreeNode;
  Src, Dst: TMenuItem;
begin
  Temp := MenuEdit.GetNodeAt(X, Y);
  if (Temp <> nil) and not TreeNodeIsUnder(Temp, FDragItem) and
     (Temp.Data <> nil) then
  begin
    Src := TMenuItem(FDragItem.Data);
    Dst := TMenuItem(Temp.Data);

    MoveTreeNodeTo(FDragItem, temp.Parent, Temp.Index + 1);

    Src.Parent.Remove(Src);
    Dst.Parent.Insert(Dst.MenuIndex + 1, Src);

    FCallbacks.EditorUtils.MarkModified;
  end;
  FDragItem := nil;
end;

procedure TLMDMenuEditorDialog.MenuEditEdited(Sender: TObject;
  Node: TTreeNode; var S: string);
var
  Item: TMenuItem;
begin
  if Node.Data <> nil then
  begin
    Item := TMenuItem(Node.Data);
    Item.Caption := S;

    FCallbacks.EditorUtils.MarkModified;
  end;
end;

procedure TLMDMenuEditorDialog.Timer1Timer(Sender: TObject);
begin
  UpdateTreeNodesFromMenu(Self.FMenu, Self.MenuEdit);
end;

class procedure TLMDMenuEditorDialog.OpenEditor(
  ACallbacks: TLMDEditorWindowCallbacks; AValue: TMenuItem);
var
  i:      Integer;
  editor: TLMDMenuEditorDialog;
begin
  for i := 0 to EditorList.Count -1 do
    if TLMDMenuEditorDialog(EditorList[i]).FRootMenuItem = AValue then
    begin
      ACallbacks.Free;

      TLMDMenuEditorDialog(EditorList[i]).Show;
      TLMDMenuEditorDialog(EditorList[i]).BringToFront;
      Exit;
    end;

  editor                   := TLMDMenuEditorDialog.Create(Application);
  editor.FCallbacks        := ACallbacks;
  ACallbacks.OnCommand     := editor.CallbacksCommand;
  editor.FRootMenuItem     := AValue;

  editor.Menu      := AValue.GetParentMenu;
  editor.Caption   := 'Editing ' + AValue.GetNamePath;

  EditorList.Add(editor);
  editor.Show;
  editor.BringToFront;
  editor.UpdateStayOnTop;
end;

procedure TLMDMenuEditorDialog.MenuEditChange(Sender: TObject;
  Node: TTreeNode);
begin
  Self.UpdateSelection;
end;

procedure TLMDMenuEditorDialog.UpdateSelection;
var
  item: TMenuItem;
begin
  if Assigned(Self.MenuEdit.Selected) and
     Assigned(Self.MenuEdit.Selected.Data) then
  begin
    item := TMenuItem(Self.MenuEdit.Selected.Data);
    FCallbacks.EditorUtils.SetObjects([item]);
  end;
end;

procedure TLMDMenuEditorDialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TLMDMenuEditorDialog.FormDestroy(Sender: TObject);
begin
  EditorList.Remove(Self);
  FCallbacks.Free;
end;

procedure TLMDMenuEditorDialog.CallbacksCommand(Sender: TObject;
  ACommand: TLMDEditorWndCommand);
begin
  case ACommand of
    ewcUpdateView:      UpdateTreeNodesFromMenu(Self.FMenu, Self.MenuEdit);
    ewcHideWindow:      Hide;
    ewcShowWindow:      Show;
    ewcDestroyWindow:   Release;
    ewcUpdateStayOnTop: UpdateStayOnTop;
  end;
end;

procedure TLMDMenuEditorDialog.UpdateStayOnTop;
begin
  if FCallbacks.StayOnTop then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
end;

initialization
  EditorList := TList.Create;

finalization
  EditorList.Free;
  end.
