unit wwInspectorProp;
{
//
// Components : Design-time property editors for inspector
//
// Copyright (c) 1999-2001 by Woll2Woll Software
//
// 2/8/2000 - Repaint inspector after move
}
{$i wwIfDef.pas}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls,
       {$ifdef wwdelphi6up}
       designintf, designeditors,
       {$else}
       dsgnintf,
       {$endif}
  checklst,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb, wwdatainspector;

type
  TInspectorPropEdit = class(TForm)
    Panel2: TPanel;
    NewItemButton: TSpeedButton;
    NewSubItemButton: TSpeedButton;
    DeleteButton: TSpeedButton;
    MoveUpButton: TSpeedButton;
    MoveDownButton: TSpeedButton;
    Button5: TButton;
    procedure NewItemButtonClick(Sender: TObject);
    procedure NewSubitemButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MoveButtonClick(Sender: TObject);
    procedure TreeViewDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeViewDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
   procedure TreeViewMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DeleteButtonClick(Sender: TObject);
    procedure TreeViewChange(Sender: TObject; Node: TTreeNode);
    procedure TreeViewExpanded(Sender: TObject; Node: TTreeNode);
    procedure TreeViewCollapsed(Sender: TObject; Node: TTreeNode);
    procedure TreeViewCustomDrawItem(Sender: TCustomTreeView;
       Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure Button5Click(Sender: TObject);
  private
     TreeView: TTreeView;
//     DesignerForm: TCustomForm;
     Designer:
        {$ifdef wwDelphi6Up} IDesigner;
        {$else} {$ifdef wwDelphi4Up} IFormDesigner; {$else} TFormDesigner; {$endif}
        {$endif}
//     {$ifdef wwDelphi4Up}IFormDesigner{$else}TFormDesigner{$endif};
     Inspector: TwwDataInspector;
     SkipUpdate: boolean;
     SkipChange: boolean;
     procedure AddChildrenToTree(ParentNode: TTreeNode; Items: TwwInspectorCollection);
     procedure AddChildrenToInspector(ParentNode: TTreeNode; ParentItem: TwwInspectorItem);
//     procedure UpdateComponent;
     procedure RefreshNodeText(ParentNode: TTreeNode);
  public
    destructor Destroy; override;
    procedure Update; override;
    { Public declarations }
  end;

Function ExecuteInspectorEditor(
   ADesigner:
//     {$ifdef wwDelphi4Up}IFormDesigner{$else}TFormDesigner{$endif};
        {$ifdef wwDelphi6Up} IDesigner;
        {$else} {$ifdef wwDelphi4Up} IFormDesigner; {$else} TFormDesigner; {$endif}
        {$endif}
//   ADesignerForm: TCustomForm;
   AEdit: TwwDataInspector): boolean;

var
  InspectorPropEdit: TInspectorPropEdit=nil;

implementation

{$R *.DFM}

uses typinfo, wwcommon, wwprpfld, db;

type

 TObjTreeView=class(TTreeView)
  private
    LastSelectedNode: TTreeNode;
    MultiSelectActive: boolean;
  protected
    procedure UnselectAllNodes(IgnoreNode: TTreeNode);
    function CreateNode: TTreeNode; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                X, Y: Integer); override;
    Function MultiSelectCount: integer;
    function NumChildren: integer;

 end;

 TObjTreeNode=class(TTreeNode)
 public
   Caption: string;
   ObjItem: TwwInspectorItem;
   MultiSelected: boolean;

   constructor Create(AOwner: TTreeNodes); virtual;
   destructor Destroy; override;
   procedure InvalidateNode;
 end;

 constructor TObjTreeNode.Create(AOwner: TTreeNodes);
 begin
    inherited Create(AOwner);
 end;

 destructor TObjTreeNode.Destroy;
 begin
    if TObjTreeView(TreeView).LastSelectedNode= self then
       TObjTreeView(TreeView).LastSelectedNode:= nil;

    inherited Destroy;
 end;

 procedure TObjTreeNode.InvalidateNode;
 var r: TRect;
 begin
     R := DisplayRect(False);
     InvalidateRect(TreeView.handle, @R, True);
 end;

function ExecuteInspectorEditor(
   ADesigner: //{$ifdef wwDelphi4Up}IFormDesigner{$else}TFormDesigner{$endif};
        {$ifdef wwDelphi6Up} IDesigner;
        {$else} {$ifdef wwDelphi4Up} IFormDesigner; {$else} TFormDesigner; {$endif}
        {$endif}
//   ADesignerForm: TCustomForm;
   AEdit: TwwDataInspector): boolean;
begin
  if InspectorPropEdit <> nil then InspectorPropEdit.Free;
  InspectorPropEdit := TInspectorPropEdit.Create(Application);

  with InspectorPropEdit do
  begin
//     DesignerForm:= ADesignerForm;
     Designer:= ADesigner;
     Inspector:= AEdit;
     Inspector.Designer := InspectorPropEdit;
     AddChildrenToTree(nil, Inspector.Items);
     Show;
  end;
  result:= true;
end;


Function TObjTreeView.MultiSelectCount: integer;
var count: Integer;
    Node: TObjTreeNode;
begin
   count:= 0;
   Node:= Items.GetFirstNode as TObjTreeNode;
   while Node<>nil do begin
      if Node.MultiSelected then inc(count);
      Node:= Node.GetNext as TObjTreeNode;
   end;
   result:= count;
end;

procedure TObjTreeView.UnselectAllNodes(IgnoreNode: TTreeNode);
var Node: TObjTreeNode;
begin
   Node:= Items.GetFirstNode as TObjTreeNode;
   while Node<>nil do begin
      if Node<>IgnoreNode then
      begin
         if Node.MultiSelected then begin
            Node.MultiSelected:= false;
            Node.InvalidateNode;
         end
      end;
      Node:= Node.GetNext as TObjTreeNode;
   end;
end;

procedure TInspectorPropEdit.TreeViewCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
   if (Node as TObjTreeNode).multiselected then
   begin
      Sender.Canvas.Brush.Color:= clHighlight;
      Sender.Canvas.Font.Color:= clHighlightText;
   end
   else if Node.Selected and (TreeView as TObjTreeView).MultiSelectActive then
   begin
      Sender.Canvas.Brush.Color:= clWindow;
      Sender.Canvas.Font.Color:= clWindowText;
   end;
//   Sender.Canvas.Font.assign(TObjTreeView(sender).Font);
end;

procedure TObjTreeView.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var Node, CurNode, LastNode: TObjTreeNode;
    hitTest: THitTests;
    {$ifdef wwDelphi5Up}
    Selections: IDesignerSelections;
    {$else}
    Selections: TComponentList;
    {$endif}

   Function SameLevelShiftSelect: boolean;
   begin
       result:=
         (ssShift in Shift) and
         ((LastSelectedNode<>Nil) and (LastSelectedNode.parent=Node.parent) or
          (LastSelectedNode=Nil))
   end;

  procedure AddSelections;
  var Node: TObjTreeNode;
  begin
     Node:= Items.GetFirstNode as TObjTreeNode;
     while Node<>nil do begin
        if Node.MultiSelected then begin
           {$ifdef wwDelphi6Up}
           Selections.Add(Node.ObjItem);
           {$else}
             {$ifdef wwDelphi5Up}
             Selections.Add(MakeIPersistent(Node.ObjItem));
             {$else}
             Selections.Add(Node.ObjItem);
             {$endif}
           {$endif}
        end;
        Node:= Node.GetNext as TObjTreeNode;
     end;
  end;


begin

   inherited MouseDown(Button, Shift, X, Y);

   Node:= GetNodeAt(X, Y) as TObjTreeNode;
   if Node=Nil then exit;

   hitTest:= GetHitTestInfoAt(X, Y);

   if (ssDouble in Shift) and (Button = mbLeft) then Exit;

   If (hitTest * [htOnItem, htOnLabel, htOnRight] <> []) then
   begin
      if (not (ssCtrl in Shift)) then
      begin
         if SameLevelShiftSelect then begin
            UnselectAllNodes(LastSelectedNode)
         end
         else
            UnselectAllNodes(nil);
      end;

      if (ssShift in Shift) then begin
         if SamelevelShiftSelect and (LastSelectedNode<>nil) then begin
            if Node.index>LastSelectedNode.index then begin
               curNode:= LastSelectedNode as TObjTreeNode;
               curNode.multiselected:= true;
               LastNode:= Node;

               while curNode<>LastNode do begin
                  curNode:= curNode.GetNextSibling as TObjTreeNode;
                  if curNode=Nil then break;
                  curNode.multiselected:= true;
                  MultiSelectActive:= True;
                  invalidate;
               end;
            end
            else begin
               curNode:= Node;
               LastNode:= LastSelectedNode as TObjTreeNode;
               while curNode<>LastNode do begin
                  curNode.multiselected:= true;
                  MultiSelectActive:= True;
                  invalidate;
                  curNode:= curNode.GetNextSibling as TObjTreeNode;
                  if curNode=Nil then break;
               end;
               if curNode=LastNode then curNode.multiselected:= true;
            end;
            if not node.selected then node.selected:= True;
         end
      end
      else begin
          if Node<>nil then
             with Node as TObjTreeNode do begin
                if ssCtrl in Shift then
                begin
                  MultiSelectActive:= True;
                  { Select previous node if no previous selections }
                  if (LastSelectedNode<>nil) and
                     not (LastSelectedNode as TObjTreeNode).MultiSelected and
                     (MultiSelectCount=0) then
                     (LastSelectedNode as TObjTreeNode).multiSelected:= True;
                  Node.MultiSelected:= not Node.MultiSelected;
                  invalidate;
                end;
                if not node.selected then node.selected:= True;
             end;
      end;

   end;

   if not (ssShift in Shift) then
      LastSelectedNode:= Node;

   if MultiSelectActive then
   begin
       if (Owner as TInspectorPropEdit).Designer<>nil then begin
          {$ifndef wwDelphi5Up}
          Selections := TComponentList.Create;
          {$else}
          Selections := CreateSelectionList;
          {$endif}

          AddSelections;
          if Selections.Count > 0 then
             (Owner as TInspectorPropEdit).Designer.SetSelections(Selections);
          {$ifndef wwDelphi5Up}
          Selections.Free;
          {$endif}
       end;
   end
end;



destructor TInspectorPropEdit.Destroy;
begin
  Inspector.Designer := nil;
  InspectorPropEdit:= nil;
  inherited Destroy;
end;

(*procedure TInspectorPropEdit.UpdateComponent;
var i: integer;
    Node: TObjTreeNode;
    Item: TwwInspectorItem;
begin
   SkipUpdate:= True;
   Inspector.BeginUpdate;
   for i:= Inspector.Items.Count-1 downto 0 do
      Inspector.Items[i].Free;

   Node := TObjTreeNode(TreeView.Items.GetFirstNode);
   while Node <> nil do
   begin
      Item:= TwwInspectorItem.create(Inspector.Items);
      AddChildrenToInspector(Node, Item);
      Node := TObjTreeNode(Node.GetNextSibling);
   end;
   SkipUpdate:= False;
   Inspector.EndUpdate;
end;
*)
function TObjTreeView.CreateNode: TTreeNode;
begin
  Result := TObjTreeNode.Create(Items);
end;

function TObjTreeView.NumChildren: integer;
var Node: TTreeNode;
    count: Integer;
begin
     Node := Items.GetFirstNode;
     count:= 0;
     while Node <> nil do
     begin
        inc(count);
        Node := Node.GetNextSibling;
     end;
     result:= count;
end;

{ Update displaynames for each node in tree }
procedure TInspectorPropEdit.RefreshNodeText(ParentNode: TTreeNode);
var Node: TTreeNode;
begin
  if ParentNode=nil then Node := TreeView.Items.GetFirstNode
  else Node := ParentNode.GetFirstChild;

  while Node <> nil do
  begin
      Node.Text:= TObjTreeNode(Node).objItem.GetDisplayName;
      Node := Node.GetNextSibling;
  end;
end;

procedure TInspectorPropEdit.AddChildrenToTree(ParentNode: TTreeNode;
    Items: TwwInspectorCollection);
var i: integer;
    Node: TObjTreeNode;
    tempNode: TTreeNode;
begin
  with Items do begin
     for i:= 0 to Count-1 do begin
//        ShowMessage('i:' + inttostr(i));
        Node:= TObjTreeNode(TreeView.Items.AddChild(ParentNode, Items[i].Caption));
        Node.Text:= Items[i].GetDisplayName;
        Node.Caption:= Items[i].Caption;
        Node.ObjItem:= Items[i];
        AddChildrenToTree(Node, Items[i].Items);
     end
  end;
//  ShowMessage('i:' + 'done');
  if ParentNode=nil then
  begin
     tempNode:= TreeView.Items.GetFirstNode;
     while tempNode<>nil do begin
//       ShowMessage('tempnode:' + tempnode.text);
       if TObjTreeNode(tempNode).objItem.expanded then
         tempNode.expanded:= True;
       tempNode:= tempNode.GetNext;
     end;
  end;
end;

procedure TInspectorPropEdit.AddChildrenToInspector(ParentNode: TTreeNode; ParentItem: TwwInspectorItem);
var Node: TObjTreeNode;
    Item: TwwInspectorItem;
begin
   Node:= TObjTreeNode(ParentNode);
   ParentItem.Caption:= Node.Caption;

   Node := TObjTreeNode(ParentNode.GetFirstChild);
   while Node <> nil do
   begin
      Item:= TwwInspectorItem.create(ParentItem.Items);
      AddChildrenToInspector(Node, Item);
      Node := TObjTreeNode(Node.GetNextSibling);
   end;
end;

{Function wwGetOwnerForm(component: TComponent):TCustomForm;
var temp: TComponent;
begin
   temp:= component;
   while (temp<>Nil) and (temp.Owner<>Nil) and not (temp is TCustomForm) do temp:= temp.Owner;
   result:= TCustomForm(temp);
end;
}
procedure TInspectorPropEdit.NewItemButtonClick(Sender: TObject);
var ParentOfSelected: TObjTreeNode;
    Node: TObjTreeNode;
begin
   if TreeView.Selected=Nil then ParentOfSelected:= Nil
   else ParentOfSelected:= TObjTreeNode(TreeView.Selected.parent);

   Node := TObjTreeNode(TreeView.Items.AddChild(ParentOfSelected, ''));

   if ParentOfSelected=nil then
      Node.ObjItem:= TwwInspectorItem.create(Inspector.Items)
   else
      Node.ObjItem:= TwwInspectorItem.create(ParentOfSelected.ObjItem.Items);
   TreeView.Selected:= Node;

   RefreshNodeText(TreeView.Selected.parent);
   Inspector.invalidate;

end;

procedure TInspectorPropEdit.NewSubitemButtonClick(Sender: TObject);
var Node: TObjTreeNode;
begin
   if TreeView.selected<>Nil then
   begin
      Node:= TObjTreeNode(TreeView.Items.AddChild(TreeView.Selected, ''));
      Node.ObjItem:= TwwInspectorItem.create(
                       TObjTreeNode(TreeView.Selected).ObjItem.Items);
      TreeView.selected:= Node;
      RefreshNodeText(TreeView.Selected.parent);
      Inspector.invalidate;
   end;
end;

procedure TInspectorPropEdit.TreeViewDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var HitTest : THitTests;
    KeyState: TKeyboardState;
    TempNode, XYNode: TTreeNode;
begin
  with (Sender as TTreeView) do begin
    HitTest := GetHitTestInfoAt(X,Y);
    if (Selected <> nil) and
       ([htOnItem, htOnButton, htOnIndent, htOnLabel, htOnRight] * HitTest <> []) then
    begin
       if ([htOnItem, htOnButton, htOnIndent, htOnLabel, htOnRight] * HitTest <> []) then
       begin
          GetKeyboardState(KeyState);
          XYNode:= GetNodeAt(X,Y);
          Items.BeginUpdate;

          if KeyState[vk_Shift]>=128 then begin
             TempNode:= XYNode.Owner.AddChild(XYNode, '');
             Selected.MoveTo(TempNode, naInsert);
             TempNode.Free;
             TObjTreeNode(Selected).objitem.collection:= TObjTreeNode(XYNode).Objitem.Items;
             TObjTreeNode(Selected).objitem.index:= Selected.index; //XYNode.count-1;
             TObjTreeNode(Selected).objitem.parentItem:= TObjTreeNode(XYNode).Objitem;

             RefreshNodeText(selected.parent);
             Inspector.ApplySettings;
          end
          else begin
             if (XYNode<>Nil) and (Selected<>XYNode.GetPrevSibling) then
             begin
               Selected.MoveTo(XYNode, naInsert);

               TObjTreeNode(Selected).objitem.collection:= TObjTreeNode(XYNode).Objitem.collection;
               TObjTreeNode(Selected).objitem.index:= Selected.index;
               TObjTreeNode(Selected).objitem.parentItem:= TObjTreeNode(XYNode).Objitem.parentItem;

               RefreshNodeText(selected.parent);
               Inspector.ApplySettings;
             end;
          end;
          Items.EndUpdate;
       end
    end
    else if htNowhere in HitTest then
    begin
       Items.BeginUpdate;
       Selected.MoveTo(DropTarget, naAdd);

       TObjTreeNode(Selected).objitem.collection:= Inspector.Items;
       TObjTreeNode(Selected).objitem.index:= Selected.index; //TObjTreeView(TreeView).NumChildren-1;
       TObjTreeNode(Selected).objitem.parentItem:= nil;

       RefreshNodeText(selected.parent);
       Inspector.ApplySettings;
       Items.EndUpdate;
    end;

    DropTarget := nil;
    Screen.Cursor := crDefault;
  end
end;

procedure TInspectorPropEdit.TreeViewDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:= True;
end;

procedure TInspectorPropEdit.TreeViewMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var obj: TwwInspectorItem;
    NewRow: integer;
begin
  if (ssAlt in Shift) and (Designer<>nil) and (TreeView.selected<>nil) then
  begin
      obj:= TObjTreeNode(TreeView.Selected).ObjItem;
      if (obj.CustomControl<>nil) then
      begin
         NewRow:= Inspector.GetRowByItem(obj);
         if NewRow>=0 then
         begin
            if NewRow>0 then
               Inspector.row:= NewRow-1
            else if Inspector.RowCount>1 then
               Inspector.row:= NewRow+1;
           (Inspector as TwwDataInspector).row:= NewRow;
         end;
         Designer.SelectComponent(obj.CustomControl);
      end
  end
  else if htOnLabel in TreeView.GetHitTestInfoAt(X,Y) then
     TreeView.BeginDrag(False);
end;

procedure TInspectorPropEdit.MoveButtonClick(Sender: TObject);
var NextSibling: TTreeNode;
    Mode: TNodeAttachMode;
begin
  Mode := naInsert;
  if (TreeView.Selected = nil) then Exit;
  if (Sender as TSpeedButton).Tag < 0 then
  begin
    NextSibling := TreeView.Selected.GetNextSibling;
    if NextSibling = nil then Exit;
    NextSibling := NextSibling.GetNextSibling;
    if NextSibling = nil then
    begin
      NextSibling := TreeView.Selected.GetNextSibling;
      Mode := naAdd;
    end;
  end else NextSibling := TreeView.Selected.GetPrevSibling;
  if NextSibling = nil then Exit;
  TreeView.Items.BeginUpdate;
  TreeView.Selected.MoveTo(NextSibling, Mode);
  TreeView.Items.EndUpdate;


  if Designer<>nil then Designer.SelectComponent(Inspector);
  TObjTreeNode(TreeView.Selected).ObjItem.Index:=
     TObjTreeNode(TreeView.Selected).ObjItem.Index - (Sender as TSpeedButton).Tag;
  if Designer<>nil then Designer.SelectComponent(TObjTreeNode(TreeView.Selected).ObjItem);

  RefreshNodeText(TreeView.Selected.Parent);
  Inspector.ApplySettings; { 2/8/2000 - Repaint }

end;

procedure TInspectorPropEdit.FormCreate(Sender: TObject);
begin
  TreeView:= TObjTreeView.create(self);
  with TreeView do begin
    Left := 2;
    Top := 15;
    Width := 161;
    Height := 269;
    parent:= self; //FieldListGroupBox;
    HideSelection:= False;
    Indent := 19;
    Align := alClient;
    TabOrder := 1;
    OnDragDrop := TreeViewDragDrop;
    OnDragOver := TreeViewDragOver;
    OnMouseDown := TreeViewMouseDown;
    OnChange:= TreeViewChange;
    OnCollapsed:= TreeViewCollapsed;
    OnExpanded:= TreeViewExpanded;
    OnCustomDrawItem:= TreeViewCustomDrawItem;
    ShowLines:= False;
//    RowSelect:= True;
    visible:= true;
    ReadOnly:= True;
  end
end;

procedure TInspectorPropEdit.DeleteButtonClick(Sender: TObject);
var SelectedNode, OldNode, Node: TTreeNode;
    obj: TwwInspectorItem;
begin
   Node:= TreeView.Items.GetFirstNode;
   SelectedNode:= TreeView.Selected;
   OldNode:= nil;
   while True do begin
      if (Node<>nil) and
         ((Node as TObjTreeNode).MultiSelected or (SelectedNode=Node)) then
      begin
        obj:= TObjTreeNode(Node).ObjItem;
//        TObjTreeNode(Node).ObjItem.Free;
        TreeView.Items.Delete(Node);
        obj.Free; // 5/5/01 - Free after treeview node deleted 
        Node:= OldNode;
      end
      else begin
         OldNode:= Node;
         if Node=nil then
           Node:= TreeView.Items.GetFirstNode
         else
           Node:= Node.GetNext;
         if Node=nil then break;
      end
   end;
   RefreshNodeText(nil);
   inspector.ApplySettings;

end;

procedure TInspectorPropEdit.TreeViewChange(Sender: TObject;
  Node: TTreeNode);

  function wwGetShiftState: TShiftState;
  begin
    Result := [];
    if GetKeyState(VK_SHIFT) < 0 then Include(Result, ssShift);
    if GetKeyState(VK_CONTROL) < 0 then Include(Result, ssCtrl);
    if GetKeyState(VK_MENU) < 0 then Include(Result, ssAlt);
  end;

begin
   if SkipChange then exit;
   if [ssShift, ssCtrl] * wwGetShiftState = [] then
   begin
      (TreeView as TObjTreeView).UnselectAllNodes(nil);
      (TreeView as TObjTreeView).MultiSelectActive:= False;
      if Designer<>nil then
         Designer.SelectComponent(TObjTreeNode(TreeView.Selected).ObjItem);
   end
end;

procedure TInspectorPropEdit.Update;
begin
  if SkipUpdate then exit;

  inherited Update;
  if TreeView.Selected<>nil then begin
    TreeView.Selected.Text:= TObjTreeNode(TreeView.Selected).ObjItem.GetDisplayName;
    TObjTreeNode(TreeView.Selected).Caption:=
       TObjTreeNode(TreeView.Selected).ObjItem.Caption;
  end
end;

procedure TInspectorPropEdit.TreeViewExpanded(Sender: TObject;
  Node: TTreeNode);
begin
  TObjTreeNode(Node).ObjItem.Expanded:= True;
  if Designer<>nil then Designer.modified;
  Inspector.ApplySettings;
end;

procedure TInspectorPropEdit.TreeViewCollapsed(Sender: TObject;
  Node: TTreeNode);
begin
  TObjTreeNode(Node).ObjItem.Expanded:= False;
  if Designer<>nil then Designer.modified;
  Inspector.ApplySettings;
end;

procedure TInspectorPropEdit.Button5Click(Sender: TObject);
var currentList,selectedList: TStrings;
    i: integer;
    Node: TObjTreeNode;
    curField: TField;
begin
   if (Inspector.Datasource=nil) or
      (Inspector.Datasource=nil) then
   begin
      MessageDlg('DataInspector does not reference a dataset.', mtError, [mbok], 0);
      exit;
   end;

   selectedList:= TStringList.create;
   currentList:= TStringList.create;
   with TreeView do begin
      Node:= Items.GetFirstNode as TObjTreeNode;
      while Node<>nil do begin
         if Node.ObjItem.DataSource=Inspector.DataSource then
            currentList.Add(Node.ObjItem.DataField);
         Node:= Node.GetNext as TObjTreeNode;
      end;
   end;

   try
      if wwDlgSelectFields(Inspector.Datasource.DataSet,
                 currentList, selectedList) then
      begin
         for i:= 0 to selectedList.count-1 do begin
            Node := TObjTreeNode(TreeView.Items.AddChild(nil, SelectedList[i]));
            Node.ObjItem:= TwwInspectorItem.create(Inspector.Items);
            curField:= Inspector.DataSource.DataSet.FindField(SelectedList[i]);
            with Node.ObjItem do begin
               if curfield=nil then
                 Caption:= SelectedList[i]
               else
                 Caption:= curField.DisplayLabel;
               DataField:= SelectedList[i];
            end
         end;
         RefreshNodeText(nil);
      end
   finally
      selectedList.free;
      currentList.Free;
   end

end;

initialization
finalization
  InspectorPropEdit.Free;
  InspectorPropEdit:= nil;
end.

