{: GLSceneEdit<p>

   Handles all the color and texture stuff.<p>

	<b>History : </b><font size=-1><ul>
      <li>03/07/04 - LR - Make change for Linux
      <li>14/12/03 - EG - Paste fix (Mrqzzz)
      <li>31/06/03 - EG - Cosmetic changes, form position/state now saved to the
                          registry 
      <li>21/06/03 - DanB - Added behaviours/effects listviews
      <li>22/01/02 - EG - Fixed controls state after drag/drop (Anton Zhuchkov)
      <li>06/08/00 - EG - Added basic Clipboard support
      <li>14/05/00 - EG - Added workaround for VCL DesignInfo bug (thx Nelson Chu)
      <li>28/04/00 - EG - Fixed new objects not being immediately reco by IDE
      <li>26/04/00 - EG - Added support for objects categories
		<li>17/04/00 - EG - Added access to TInfoForm
		<li>16/04/00 - EG - Fixed occasionnal crash when rebuilding GLScene dpk
									while GLSceneEdit is visible
      <li>10/04/00 - EG - Minor Create/Release change
      <li>24/03/00 - EG - Fixed SetScene not updating enablings
		<li>13/03/00 - EG - Object names (ie. node text) is now properly adjusted
									when a GLScene object is renamed,
									Added Load/Save whole scene
      <li>07/02/00 - EG - Fixed notification logic
      <li>06/02/00 - EG - DragDrop now starts after moving the mouse a little,
                           Form is now auto-creating, fixed Notification,
                           Added actionlist and moveUp/moveDown
      <li>05/02/00 - EG - Fixed DragDrop, added root nodes auto-expansion
   </ul></font>
}
unit GLSceneEdit;

interface

{$i GLScene.inc}

{$IFDEF MSWINDOWS}
uses
   XCollection, Registry,
  Controls, Windows, Forms, ComCtrls, ImgList, 
  Dialogs, Menus, ActnList, ToolWin,
  GLScene, Classes, SysUtils, ExtCtrls,
  StdCtrls, {$ifdef GLS_DELPHI_6_UP} DesignIntf, VCLEditors {$else} DsgnIntf {$endif};
{$ENDIF}
{$IFDEF LINUX}
uses
  XCollection,
  QDialogs, QImgList, QActnList, QForms, QMenus, QTypes, 
  QComCtrls, QControls, Types,
  GLScene, Classes, SysUtils, QExtCtrls,
  QStdCtrls, DesignIntf, VCLEditors; 
   {$ENDIF}


const
  SCENE_SELECTED=0;
  BEHAVIOURS_SELECTED=1;
  EFFECTS_SELECTED=2;
type
  TSetSubItemsEvent = procedure(Sender:TObject) of object;

  TGLSceneEditorForm = class(TForm)
    Tree: TTreeView;
    PopupMenu: TPopupMenu;
    MIAddCamera: TMenuItem;
    MIAddObject: TMenuItem;
    N1: TMenuItem;
    MIDelObject: TMenuItem;
    ToolBar: TToolBar;
    ActionList: TActionList;
    ToolButton1: TToolButton;
    TBAddObjects: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    PMToolBar: TPopupMenu;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ACAddCamera: TAction;
    ACAddObject: TAction;
    ImageList: TImageList;
    ACDeleteObject: TAction;
    ACMoveUp: TAction;
    ACMoveDown: TAction;
    N2: TMenuItem;
    Moveobjectup1: TMenuItem;
    Moveobjectdown1: TMenuItem;
    ACSaveScene: TAction;
    ACLoadScene: TAction;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ToolButton2: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton11: TToolButton;
    ACInfo: TAction;
    ACCopy: TAction;
    ACCut: TAction;
    ACPaste: TAction;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    Cut1: TMenuItem;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    PABehaviours: TPanel;
    BehavioursListView: TListView;
    Splitter3: TSplitter;
    EffectsListView: TListView;
    Splitter: TSplitter;
    PMBehavioursToolbar: TPopupMenu;
    ACAddBehaviour: TAction;
    MIAddBehaviour: TMenuItem;
    MIAddEffect: TMenuItem;
    MIBehaviourSeparator: TMenuItem;
    ACDeleteBehaviour: TAction;
    BehavioursPopupMenu: TPopupMenu;
    Delete1: TMenuItem;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    N4: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    PMEffectsToolbar: TPopupMenu;
    ACAddEffect: TAction;
    ToolBar1: TToolBar;
    TBAddBehaviours: TToolButton;
    TBAddEffects: TToolButton;
    TBEffectsPanel: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure TreeEditing(Sender: TObject; Node: TTreeNode; var AllowEdit: Boolean);
    procedure TreeDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure TreeDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure TreeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TreeEnter(Sender: TObject);
    procedure TreeMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ACAddCameraExecute(Sender: TObject);
    procedure ACDeleteObjectExecute(Sender: TObject);
    procedure ACMoveUpExecute(Sender: TObject);
    procedure ACMoveDownExecute(Sender: TObject);
    procedure ACAddObjectExecute(Sender: TObject);
    procedure ACSaveSceneExecute(Sender: TObject);
    procedure ACLoadSceneExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ACInfoExecute(Sender: TObject);
    procedure ACCopyExecute(Sender: TObject);
    procedure ACCutExecute(Sender: TObject);
    procedure ACPasteExecute(Sender: TObject);
    procedure BehavioursListViewEnter(Sender: TObject);
    procedure EffectsListViewEnter(Sender: TObject);

    procedure ACAddBehaviourExecute(Sender: TObject);
    procedure DeleteBaseBehaviour(ListView:TListView);
    procedure PMBehavioursToolbarPopup(Sender: TObject);
    procedure PMEffectsToolbarPopup(Sender: TObject);
    procedure BehavioursListViewSelectItem(Sender: TObject;
      Item: TListItem; Selected: Boolean);
    procedure ACAddEffectExecute(Sender: TObject);
    procedure PopupMenuPopup(Sender: TObject);
    procedure TBEffectsPanelClick(Sender: TObject);

  private
    FSelectedItems:Integer; //

    FScene: TGLScene;
    FObjectNode, FCameraNode: TTreeNode;
    FCurrentDesigner: {$ifdef GLS_DELPHI_6_UP} IDesigner {$else} IFormDesigner {$endif};
    FLastMouseDownPos : TPoint;

{$ifdef GLS_DELPHI_6_UP}
    FPasteOwner : TComponent;
    FPasteSelection : IDesignerSelections;
{$endif}

    procedure ReadScene;
    procedure ResetTree;
    function AddNodes(ANode: TTreeNode; AObject: TGLBaseSceneObject): TTreeNode;
    procedure AddObjectClick(Sender: TObject);
    procedure AddBehaviourClick(Sender: TObject);
    procedure AddEffectClick(Sender: TObject);
    procedure SetObjectsSubItems(parent : TMenuItem);
    procedure SetXCollectionSubItems(parent : TMenuItem ; XCollection: TXCollection; Event:TSetSubItemsEvent);    
    procedure SetBehavioursSubItems(parent : TMenuItem; XCollection: TXCollection);
    procedure SetEffectsSubItems(parent : TMenuItem; XCollection: TXCollection);
    procedure OnBaseSceneObjectNameChanged(Sender : TObject);
    function IsValidClipBoardNode : Boolean;
    function IsPastePossible : Boolean;
    procedure ShowBehaviours(BaseSceneObject:TGLBaseSceneObject);
    procedure ShowEffects(BaseSceneObject:TGLBaseSceneObject);
    procedure ShowBehavioursAndEffects(BaseSceneObject:TGLBaseSceneObject);
    procedure EnableAndDisableActions();

{$ifdef GLS_DELPHI_6_UP}
    function CanPaste(obj, destination : TGLBaseSceneObject) : Boolean;
    procedure CopyComponents(Root: TComponent; const Components: IDesignerSelections);
   procedure MethodError(Reader: TReader; const MethodName: String; var Address: Pointer; var Error: Boolean);
    procedure PasteComponents(AOwner, AParent: TComponent;const Components: IDesignerSelections);
    procedure ReaderSetName(Reader: TReader; Component: TComponent; var Name: string);
    procedure ComponentRead(Component: TComponent);
    function UniqueName(Component: TComponent): string;
{$endif}

    // We can not use the IDE to define this event because the
    // prototype is not the same between Delphi and Kylix !!
    {$IFDEF MSWINDOWS}
    procedure TreeEdited(Sender: TObject; Node: TTreeNode; var S: String);
    {$ENDIF}
    {$IFDEF LINUX}
    procedure TreeEdited(Sender: TObject; Node: TTreeNode; var S: WideString);
    {$ENDIF}

  protected
	 procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    procedure SetScene(Scene: TGLScene; Designer: {$ifdef GLS_DELPHI_6_UP} IDesigner {$else} IFormDesigner {$endif});

  end;

function GLSceneEditorForm : TGLSceneEditorForm;
procedure ReleaseGLSceneEditorForm;

// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------
implementation
// ------------------------------------------------------------------
// ------------------------------------------------------------------
// ------------------------------------------------------------------

{$IFDEF MSWINDOWS}
{$R *.dfm}
{$ENDIF}
{$IFDEF LINUX}
{$R *.xfm}
{$ENDIF}


uses
{$IFDEF MSWINDOWS}
  GLSceneRegister, GLStrings, Info, OpenGL1x, ClipBrd, GLWin32Viewer; 
{$ENDIF}
{$IFDEF LINUX}
  GLSceneRegister, GLStrings, Info, OpenGL1x, QClipbrd, GLLinuxViewer; 
{$ENDIF}


resourcestring
   cGLSceneEditor = 'GLScene Editor';

const
   cRegistryKey = 'Software\GLScene.org\GLSceneEdit';

var
	vGLSceneEditorForm : TGLSceneEditorForm;

function GLSceneEditorForm : TGLSceneEditorForm;
begin
	if not Assigned(vGLSceneEditorForm) then
		vGLSceneEditorForm:=TGLSceneEditorForm.Create(nil);
	Result:=vGLSceneEditorForm;
end;

procedure ReleaseGLSceneEditorForm;
begin
	if Assigned(vGLSceneEditorForm) then begin
		vGLSceneEditorForm.Free;
      vGLSceneEditorForm:=nil;
   end;
end;

{$IFDEF MSWINDOWS}
function ReadRegistryInteger(reg : TRegistry; const name : String;
                             defaultValue : Integer) : Integer;
begin
   if reg.ValueExists(name) then
      Result:=reg.ReadInteger(name)
   else Result:=defaultValue;
end;
{$ENDIF}

// FindNodeByData
//
function FindNodeByData(treeNodes : TTreeNodes; data : Pointer;
								baseNode : TTreeNode = nil) : TTreeNode;
var
	n : TTreeNode;
begin
	Result:=nil;
	if Assigned(baseNode) then begin
		n:=baseNode.getFirstChild;
		while Assigned(n) do begin
			if n.Data=data then begin
				Result:=n; Break;
			end else	if n.HasChildren then begin
				Result:=FindNodeByData(treeNodes, data, n);
				if Assigned(Result) then Break;
			end;
			n:=baseNode.GetNextChild(n);
		end;
	end else begin
		n:=treeNodes.GetFirstNode;
		while Assigned(n) do begin
			if n.Data=data then begin
				Result:=n; Break;
			end else	if n.HasChildren then begin
				Result:=FindNodeByData(treeNodes, data, n);
				if Assigned(Result) then Break;
			end;
			n:=n.getNextSibling;
		end;
	end;
end;

//----------------- TGLSceneEditorForm ---------------------------------------------------------------------------------

// SetScene
//
procedure TGLSceneEditorForm.SetScene(Scene: TGLScene;
   Designer: {$ifdef GLS_DELPHI_6_UP} IDesigner {$else} IFormDesigner {$endif});
begin
   if Assigned(FScene) then
{$ifdef GLS_DELPHI_5_UP}
		FScene.RemoveFreeNotification(Self);
{$else}
		FScene.Notification(Self, opRemove);
{$endif}
	FScene:=Scene;
   FCurrentDesigner:=Designer;
   ResetTree;
   BehavioursListView.Items.Clear;
   EffectsListView.Items.Clear;

   if Assigned(FScene) then begin
      FScene.FreeNotification(Self);
      ReadScene;
      Caption:=cGLSceneEditor+' : '+FScene.Name;
   end else Caption:=cGLSceneEditor;
   TreeChange(Self, nil);
   if Assigned(FScene) then begin
      Tree.Enabled:=true;
      BehavioursListView.Enabled:=true;
      EffectsListView.Enabled:=true;
      ACLoadScene.Enabled:=True;
      ACSaveScene.Enabled:=True;
      FSelectedItems:=SCENE_SELECTED;
      EnableAndDisableActions;
   end else begin
      Tree.Enabled:=False;
      BehavioursListView.Enabled:=False;
      EffectsListView.Enabled:=False;
      ACLoadScene.Enabled:=False;
      ACSaveScene.Enabled:=False;
      ACAddCamera.Enabled:=False;
      ACAddObject.Enabled:=False;
      ACAddBehaviour.Enabled:=False;
      ACAddEffect.Enabled:=False;
      ACDeleteObject.Enabled:=False;
      ACMoveUp.Enabled:=False;
      ACMoveDown.Enabled:=False;
      ACCut.Enabled:=False;
      ACCopy.Enabled:=False;
      ACPaste.Enabled:=False;
   end;
   ShowBehavioursAndEffects(nil);
end;

// FormCreate
//
procedure TGLSceneEditorForm.FormCreate(Sender: TObject);
var
   CurrentNode: TTreeNode;
   {$IFDEF MSWINDOWS}
   reg : TRegistry;
   {$ENDIF}
begin
	RegisterGLBaseSceneObjectNameChangeEvent(OnBaseSceneObjectNameChanged);
   Tree.Images:=ObjectManager.ObjectIcons;
   Tree.Indent:=ObjectManager.ObjectIcons.Width;
   with Tree.Items do begin
      // first add the scene root
      CurrentNode:=Add(nil, glsSceneRoot);
      with CurrentNode do begin
         ImageIndex:=ObjectManager.SceneRootIndex;
         SelectedIndex:=ImageIndex;
      end;
      // next the root for all cameras
      FCameraNode:=AddChild(CurrentNode, glsCameraRoot);
      with FCameraNode do begin
         ImageIndex:=ObjectManager.CameraRootIndex;
         SelectedIndex:=ObjectManager.CameraRootIndex;
      end;
      // and the root for all objects
      FObjectNode:=AddChild(CurrentNode, glsObjectRoot);
      with FObjectNode do begin
         ImageIndex:=ObjectManager.ObjectRootIndex;
         SelectedIndex:=ObjectManager.ObjectRootIndex;
      end;
   end;
   // Build SubMenus
   SetObjectsSubItems(MIAddObject);
{$ifdef GLS_DELPHI_5_UP}
{$IFDEF MSWINDOWS}
	MIAddObject.SubMenuImages:=ObjectManager.ObjectIcons;
{$ENDIF}
{$endif}
{$ifndef GLS_DELPHI_6_UP}
   ACCut.Visible:=False;
   ACCopy.Visible:=False;
   ACPaste.Visible:=False;
{$endif}
   SetObjectsSubItems(PMToolBar.Items);
   PMToolBar.Images:=ObjectManager.ObjectIcons;

   SetBehavioursSubItems(MIAddBehaviour, nil);
   SetBehavioursSubItems(PMBehavioursToolBar.Items, nil);
   SetEffectsSubItems(MIAddEffect, nil);
   SetEffectsSubItems(PMEffectsToolBar.Items, nil);

   {$IFDEF MSWINDOWS}
   reg:=TRegistry.Create;
   try
      if reg.OpenKey(cRegistryKey, True) then begin
         if reg.ValueExists('EffectsPanel') then
            TBEffectsPanel.Down:=reg.ReadBool('EffectsPanel');
         TBEffectsPanelClick(Self);
         Left:=ReadRegistryInteger(reg, 'Left', Left);
         Top:=ReadRegistryInteger(reg, 'Top', Top);
         Width:=ReadRegistryInteger(reg, 'Width', 250);
         Height:=ReadRegistryInteger(reg, 'Height', Height);
      end;
   finally
      reg.Free;
   end;
   {$ENDIF}

   // Trigger the event OnEdited manualy
   Tree.OnEdited := TreeEdited;
end;

// FormDestroy
//
procedure TGLSceneEditorForm.FormDestroy(Sender: TObject);
{$IFDEF MSWINDOWS}
var
   reg : TRegistry;
{$ENDIF}
begin
	DeRegisterGLBaseSceneObjectNameChangeEvent(OnBaseSceneObjectNameChanged);

   {$IFDEF MSWINDOWS}
   reg:=TRegistry.Create;
   try
      if reg.OpenKey(cRegistryKey, True) then begin
         reg.WriteBool('EffectsPanel', TBEffectsPanel.Down);
         reg.WriteInteger('Left', Left);
         reg.WriteInteger('Top', Top);
         reg.WriteInteger('Width', Width);
         reg.WriteInteger('Height', Height);
      end;
   finally
      reg.Free;
   end;
   {$ENDIF}
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TGLSceneEditorForm.ReadScene;

var
  I: Integer;

begin
  Tree.Items.BeginUpdate;
  with FScene do
  begin
    if Assigned(Cameras) then
    begin
      FCameraNode.Data:=Cameras;
      for I:=0 to Cameras.Count - 1 do AddNodes(FCameraNode, Cameras[I]);
      FCameraNode.Expand(False);
    end;

    if Assigned(Objects) then
	 begin
      FObjectNode.Data:=Objects;
      with Objects do
        for I:=0 to Count - 1 do AddNodes(FObjectNode, Children[I]);
      FObjectNode.Expand(False);
    end;
  end;
  Tree.Items.EndUpdate;
end;

//----------------------------------------------------------------------------------------------------------------------

procedure TGLSceneEditorForm.ResetTree;
begin
   // delete all subtrees (empty tree)
   Tree.Items.BeginUpdate;
   try
      FCameraNode.DeleteChildren;
      FCameraNode.Data:=nil;
      with FObjectNode do begin
         DeleteChildren;
			Data:=nil;
         Parent.Expand(True);
      end;
   finally
      Tree.Items.EndUpdate;
   end;
end;

//----------------------------------------------------------------------------------------------------------------------

function TGLSceneEditorForm.AddNodes(ANode: TTreeNode; AObject: TGLBaseSceneObject): TTreeNode;

// adds the given scene object as well as its children to the tree structure and returns
// the last add node (e.g. for selection)

var
  I: Integer;
  CurrentNode: TTreeNode;

begin
  Result:=Tree.Items.AddChildObject(ANode, AObject.Name, AObject);
  Result.ImageIndex:=ObjectManager.GetImageIndex(TGLSceneObjectClass(AObject.ClassType));
  Result.SelectedIndex:=Result.ImageIndex;
  CurrentNode:=Result;
  for I:=0 to AObject.Count - 1 do Result:=AddNodes(CurrentNode, AObject[I]);
end;

procedure TGLSceneEditorForm.SetObjectsSubItems(parent : TMenuItem);
var
   objectList : TStringList;
   i, j : Integer;
   item, currentParent : TMenuItem;
   currentCategory : String;
   soc : TGLSceneObjectClass;
begin
   objectList:=TStringList.Create;
   try
      ObjectManager.GetRegisteredSceneObjects(objectList);
      for i:=0 to objectList.Count-1 do if objectList[i]<>'' then begin
         with ObjectManager do
            currentCategory:=GetCategory(TGLSceneObjectClass(objectList.Objects[i]));
         if currentCategory='' then
            currentParent:=parent
         else begin
            currentParent:=NewItem(currentCategory, 0, False, True, nil, 0, '');
            parent.Add(currentParent);
         end;
         for j:=i to objectList.Count-1 do if objectList[j]<>'' then with ObjectManager do begin
            soc:=TGLSceneObjectClass(objectList.Objects[j]);
            if currentCategory=GetCategory(soc) then begin
               item:=NewItem(objectList[j], 0, False, True, AddObjectClick, 0, '');
               item.ImageIndex:=GetImageIndex(soc);
               item.Tag:=Integer(soc);
               currentParent.Add(item);
               objectList[j]:='';
               if currentCategory='' then Break; 
            end;
         end;
      end;
	finally
      objectList.Free;
   end;
end;

procedure TGLSceneEditorForm.SetXCollectionSubItems(parent : TMenuItem ; XCollection: TXCollection; Event:TSetSubItemsEvent);
var
	i : Integer;
	list : TList;
	XCollectionItemClass : TXCollectionItemClass;
	mi : TMenuItem;
begin
{$ifdef GLS_DELPHI_5_UP}
   parent.Clear;
{$else}
   for i:=parent.Count-1 downto 0 do
      parent.Delete(i);
{$endif}
   if Assigned(XCollection) then begin
      list:=GetXCollectionItemClassesList(XCollection.ItemsClass);
      try
         for i:=0 to list.Count-1 do begin
            XCollectionItemClass:=TXCollectionItemClass(list[i]);
            mi:=TMenuItem.Create(owner);
            mi.Caption:=XCollectionItemClass.FriendlyName;
            mi.OnClick:=Event;//AddBehaviourClick;
            mi.Tag:=Integer(XCollectionItemClass);
            if Assigned(XCollection) then
               mi.Enabled:=XCollection.CanAdd(XCollectionItemClass)
            else mi.Enabled:=TBAddBehaviours.Enabled;
            parent.Add(mi);
         end;
      finally
         list.Free;
      end;
   end;
end;


// SetBehavioursSubItems
//
procedure TGLSceneEditorForm.SetBehavioursSubItems(parent : TMenuItem ; XCollection: TXCollection);
begin
  SetXCollectionSubItems(parent, XCollection, AddBehaviourClick);
end;

// SetEffectsSubItems
//
procedure TGLSceneEditorForm.SetEffectsSubItems(parent : TMenuItem ; XCollection: TXCollection);
begin
  SetXCollectionSubItems(parent, XCollection, AddEffectClick);
end;


procedure TGLSceneEditorForm.AddObjectClick(Sender: TObject);
var
   AParent, AObject: TGLBaseSceneObject;
   Node: TTreeNode;
begin
   if Assigned(FCurrentDesigner) then with Tree do
      if Assigned(Selected) and (Selected.Level > 0) then begin
         AParent:=TGLBaseSceneObject(Selected.Data);
       //  FCurrentDesigner.cr
         AObject:=TGLBaseSceneObject(FCurrentDesigner.CreateComponent(TGLSceneObjectClass(TMenuItem(Sender).Tag), AParent, 0, 0, 0, 0));
         TComponent(AObject).DesignInfo:=0;
         AParent.AddChild(AObject);
         Node:=AddNodes(Selected, AObject);
         Node.Selected:=True;
         FCurrentDesigner.Modified;
      end;
end;

procedure TGLSceneEditorForm.AddBehaviourClick(Sender: TObject);
var
	XCollectionItemClass : TXCollectionItemClass;
   AParent: TGLBaseSceneObject;
begin
        if Assigned(Tree.Selected) then
        begin
        AParent:=TGLBaseSceneObject(Tree.Selected.Data);
	XCollectionItemClass:=TXCollectionItemClass((Sender as TMenuItem).Tag);
	XCollectionItemClass.Create(AParent.Behaviours);
       	//PrepareListView;
        ShowBehaviours(AParent);
	//ListView.Selected:=ListView.FindData(0, XCollectionItem, True, False);
   FCurrentDesigner.Modified;
   end;
end;


procedure TGLSceneEditorForm.AddEffectClick(Sender: TObject);
var
	XCollectionItemClass : TXCollectionItemClass;
        AParent: TGLBaseSceneObject;
begin
        if Assigned(Tree.Selected) then
        begin

        AParent:=TGLBaseSceneObject(Tree.Selected.Data);
	XCollectionItemClass:=TXCollectionItemClass((Sender as TMenuItem).Tag);
	XCollectionItemClass.Create(AParent.Effects);
       	//PrepareListView;
        ShowEffects(AParent);
	//ListView.Selected:=ListView.FindData(0, XCollectionItem, True, False);
   FCurrentDesigner.Modified;
   end;
end;

procedure TGLSceneEditorForm.TreeDragOver(Sender, Source: TObject; X, Y: Integer;
                                          State: TDragState; var Accept: Boolean);
var
   Target : TTreeNode;
begin
   Accept:=False;
   if Source=Tree then with Tree do begin
      Target:=DropTarget;
      Accept:=Assigned(Target) and (Selected <> Target)
                and Assigned(Target.Data) and (not Target.HasAsParent(Selected));
   end;
end;

procedure TGLSceneEditorForm.TreeDragDrop(Sender, Source: TObject; X, Y: Integer);
var
   SourceNode, DestinationNode: TTreeNode;
   SourceObject, DestinationObject: TGLBaseSceneObject;
begin
   if Assigned(FCurrentDesigner) then begin
      DestinationNode:=Tree.DropTarget;
      if Assigned(DestinationNode) and (Source = Tree) then begin
			SourceNode:=TTreeView(Source).Selected;
         SourceObject:=SourceNode.Data;
         DestinationObject:=DestinationNode.Data;
         DestinationObject.Insert(0, SourceObject);
         SourceNode.MoveTo(DestinationNode, naAddChildFirst);
         TreeChange(Self, nil);
         FCurrentDesigner.Modified;
      end;
   end;
end;

// Notification
//
procedure TGLSceneEditorForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
   if (FScene=AComponent) and (Operation=opRemove) then begin
      FScene:=nil;
      SetScene(nil, nil);
	end;
	inherited;
end;

// OnBaseSceneObjectNameChanged
//
procedure TGLSceneEditorForm.OnBaseSceneObjectNameChanged(Sender : TObject);
var
	n : TTreeNode;
begin
	n:=FindNodeByData(Tree.Items, Sender);
	if Assigned(n) then
		n.Text:=(Sender as TGLBaseSceneObject).Name;
end;

// TreeChange
//
procedure TGLSceneEditorForm.TreeChange(Sender: TObject; Node: TTreeNode);
var
//   selNode : TTreeNode;
   BaseSceneObject1:TGLBaseSceneObject;
begin
   if Assigned(FCurrentDesigner) then begin

   if Node<>nil then
   begin
      BaseSceneObject1:=TGLBaseSceneObject(Node.Data);
      if BaseSceneObject1<>nil then
      begin
        ShowBehavioursAndEffects(BaseSceneObject1);
      end;
   end;

   EnableAndDisableActions();
   end;
end;

// TreeEditing
//
procedure TGLSceneEditorForm.TreeEditing(Sender: TObject; Node: TTreeNode;
                                         var AllowEdit: Boolean);
begin
   AllowEdit:=(Node.Level>1);
end;

procedure TGLSceneEditorForm.ShowBehaviours(BaseSceneObject:TGLBaseSceneObject);
var
  i:integer;
begin
      BehavioursListView.Items.Clear;
      BehavioursListView.Items.BeginUpdate;
      if Assigned(BaseSceneObject) then
      begin
      for i:=0 to BaseSceneObject.Behaviours.Count-1 do
      begin
        with BehavioursListView.Items.Add do
        begin
          Caption:=IntToStr(i)+' - '+BaseSceneObject.Behaviours[i].Name;
          Data:=BaseSceneObject.Behaviours[i];
        end;
      end;
      end;
      BehavioursListView.Items.EndUpdate;
end;

procedure TGLSceneEditorForm.ShowEffects(BaseSceneObject:TGLBaseSceneObject);
var
  i:integer;
begin
      EffectsListView.Items.Clear;
      EffectsListView.Items.BeginUpdate;
      if Assigned(BaseSceneObject) then
      begin
      for i:=0 to BaseSceneObject.Effects.Count-1 do
      begin
        with EffectsListView.Items.Add do
        begin
          caption:=IntToStr(i)+' - '+BaseSceneObject.Effects[i].Name;
          Data:=BaseSceneObject.Effects[i];
        end;
      end;
      end;
      EffectsListView.Items.EndUpdate;
end;


procedure TGLSceneEditorForm.ShowBehavioursAndEffects(BaseSceneObject:TGLBaseSceneObject);
begin
  ShowBehaviours(BaseSceneObject);
  ShowEffects(BaseSceneObject);
end;

// TreeEdited
//
{$IFDEF MSWINDOWS}
procedure TGLSceneEditorForm.TreeEdited(Sender: TObject; Node: TTreeNode; var S: String);
{$ENDIF}
{$IFDEF LINUX}
procedure TGLSceneEditorForm.TreeEdited(Sender: TObject; Node: TTreeNode; var S: WideString);
{$ENDIF}
var
  BaseSceneObject1:TGLBaseSceneObject;
begin
   if Assigned(FCurrentDesigner) then begin
      // renaming a node means renaming a scene object
      BaseSceneObject1:=TGLBaseSceneObject(Node.Data);
      if FScene.FindSceneObject(S)=nil then
        BaseSceneObject1.Name:=S
      else
      begin
        Messagedlg('A component named '+S+' already exists',mtWarning,[mbok],0);
        S:=BaseSceneObject1.Name;
      end;
      ShowBehavioursAndEffects(BaseSceneObject1);

      FCurrentDesigner.Modified;
   end;
end;

// TreeMouseDown
//
procedure TGLSceneEditorForm.TreeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   FLastMouseDownPos:=Point(X, Y);
end;

// TreeMouseMove
//
procedure TGLSceneEditorForm.TreeMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
   node: TTreeNode;
begin
   if Shift=[ssLeft] then begin
      node:=Tree.Selected;
      if Assigned(node) and (node.Level>1) then
         if (Abs(FLastMouseDownPos.x-x)>4) or (Abs(FLastMouseDownPos.y-y)>4) then
            Tree.BeginDrag(False);
   end;
end;

// TreeEnter
//
procedure TGLSceneEditorForm.TreeEnter(Sender: TObject);
begin
   if Assigned(FCurrentDesigner) and Assigned(Tree.Selected) then
      FCurrentDesigner.SelectComponent(Tree.Selected.Data);
   FSelectedItems:=SCENE_SELECTED;
   EnableAndDisableActions();
end;

// ACAddCameraExecute
//
procedure TGLSceneEditorForm.ACAddCameraExecute(Sender: TObject);
var
   AObject: TGLBaseSceneObject;
   Node: TTreeNode;
begin
   if Assigned(FCurrentDesigner) then begin
      AObject:=TGLBaseSceneObject(FCurrentDesigner.CreateComponent(TGLCamera, FScene.Cameras, 0, 0, 0, 0));
      FScene.Cameras.AddChild(AObject);
      Node:=AddNodes(FCameraNode, AObject);
      Node.Selected:=True;
      FCurrentDesigner.Modified;
   end;
end;

// ACDeleteObjectExecute
//
procedure TGLSceneEditorForm.ACDeleteObjectExecute(Sender: TObject);
var
	anObject : TGLBaseSceneObject;
   allowed, keepChildren : Boolean;
   confirmMsg : String;
   buttons : TMsgDlgButtons;
begin
  if FSelectedItems=BEHAVIOURS_SELECTED then
  begin
    DeleteBaseBehaviour(BehavioursListView);
    FCurrentDesigner.SelectComponent(Tree.Selected.data);
    ShowBehaviours(TGLBaseSceneObject(Tree.Selected.data));
  end
  else if FSelectedItems=EFFECTS_SELECTED then
  begin
    DeleteBaseBehaviour(EffectsListView);
    FCurrentDesigner.SelectComponent(Tree.Selected.data);
    ShowEffects(TGLBaseSceneObject(Tree.Selected.data));
  end
  else if FSelectedItems=SCENE_SELECTED then
  begin
	if Assigned(Tree.Selected) and (Tree.Selected.Level > 1) then begin
      anObject:=TGLBaseSceneObject(Tree.Selected.Data);
      // ask for confirmation
      if anObject.Name<>'' then
         ConfirmMsg:='Delete '+anObject.Name
      else ConfirmMsg:='Delete the marked object';
      buttons:=[mbOK, mbCancel];
      // are there children to care for?
      // mbAll exist only on Windows ...
      {$IFDEF MSWINDOWS}
      if anObject.Count>0 then begin
         confirmMsg:=ConfirmMsg+' only or with ALL its children?';
         buttons:=[mbAll]+Buttons;
      end else confirmMsg:=confirmMsg+'?';
      {$ENDIF}
      {$IFDEF LINUX}
      confirmMsg:=confirmMsg+'?';
      {$ENDIF}
      case MessageDlg(confirmMsg, mtConfirmation, buttons, 0) of
        {$IFDEF MSWINDOWS}
         mrAll : begin
            keepChildren:=False;
            allowed:=True;
			end;
         {$ENDIF}
         mrOK : begin
            keepChildren:=True;
            allowed:=True;
         end;
         mrCancel : begin
            allowed:=False;
            keepChildren:=True;
         end;
      else
         allowed:=False;
         keepChildren:=True;
      end;
      // deletion allowed?
      if allowed then begin
         if keepChildren=true then
           while Tree.Selected.Count>0 do
             Tree.Selected.Item[0].MoveTo(Tree.Selected,naAdd);
         //previous line should be "naInsert" if children are to remain in position of parent
         // (would require changes to TGLBaseSceneObject.Remove)
         Tree.Selected.free;
         FCurrentDesigner.SelectComponent(nil);
         anObject.Parent.Remove(anObject, keepChildren);
         anObject.Free;
      end
   end;
   end;
end;

// ACMoveUpExecute
//
procedure TGLSceneEditorForm.ACMoveUpExecute(Sender: TObject);
var
   node : TTreeNode;
   prevData:Pointer;
begin
  if FSelectedItems=BEHAVIOURS_SELECTED then
  begin
        PrevData:=BehavioursListView.Selected.Data;
        TGLBaseBehaviour(PrevData).MoveUp;
        ShowBehaviours(TGLBaseSceneObject(Tree.Selected.Data));
        BehavioursListView.Selected:=BehavioursListView.FindData(0,PrevData,True,False);
        FCurrentDesigner.Modified;
  end
  else if FSelectedItems=EFFECTS_SELECTED then
  begin
        PrevData:=EffectsListView.Selected.Data;
        TGLBaseBehaviour(PrevData).MoveUp;
        ShowEffects(TGLBaseSceneObject(Tree.Selected.Data));
        EffectsListView.Selected:=EffectsListView.FindData(0,PrevData,True,False);
        FCurrentDesigner.Modified;
  end
  else if FSelectedItems=SCENE_SELECTED then
  begin
   if ACMoveUp.Enabled then begin
      node:=Tree.Selected;
      if Assigned(node) then begin
         node.MoveTo(node.GetPrevSibling, naInsert);
         with TGLBaseSceneObject(node.Data) do begin
            MoveUp;
            Update;
         end;
         TreeChange(Self, node);
         FCurrentDesigner.Modified;
      end;
   end;
  end; 
end;

// ACMoveDownExecute
//
procedure TGLSceneEditorForm.ACMoveDownExecute(Sender: TObject);
var
   node : TTreeNode;
   prevData:Pointer;
begin
  if FSelectedItems=BEHAVIOURS_SELECTED then
  begin
        PrevData:=BehavioursListView.Selected.Data;
        TGLBaseBehaviour(PrevData).MoveDown;
        ShowBehaviours(TGLBaseSceneObject(Tree.Selected.Data));
        BehavioursListView.Selected:=BehavioursListView.FindData(0,PrevData,True,False);
        FCurrentDesigner.Modified;
  end
  else if FSelectedItems=EFFECTS_SELECTED then
  begin
        PrevData:=EffectsListView.Selected.Data;
        TGLBaseBehaviour(PrevData).MoveDown;
        ShowEffects(TGLBaseSceneObject(Tree.Selected.Data));
        EffectsListView.Selected:=EffectsListView.FindData(0,PrevData,True,False);
        FCurrentDesigner.Modified;
  end
  else if FSelectedItems=SCENE_SELECTED then
  begin
   if ACMoveDown.Enabled then begin
      node:=Tree.Selected;
      if Assigned(node) then begin
         node.GetNextSibling.MoveTo(node, naInsert);
         with TGLBaseSceneObject(node.Data) do begin
				MoveDown;
            Update;
         end;
			TreeChange(Self, node);
         FCurrentDesigner.Modified;
		end;
	end;
      end;
end;

// ACAddObjectExecute
//
procedure TGLSceneEditorForm.ACAddObjectExecute(Sender: TObject);
begin
	TBAddObjects.CheckMenuDropdown;
end;

// ACSaveSceneExecute
//
procedure TGLSceneEditorForm.ACSaveSceneExecute(Sender: TObject);
begin
	if SaveDialog.Execute then
		FScene.SaveToFile(SaveDialog.FileName);
end;

// ACLoadSceneExecute
//
procedure TGLSceneEditorForm.ACLoadSceneExecute(Sender: TObject);
begin
	if OpenDialog.Execute then begin
		FScene.LoadFromFile(OpenDialog.FileName);
		ResetTree;
		ReadScene;
                ShowBehavioursAndEffects(nil);
	end;
end;

// ACInfoExecute
//
procedure TGLSceneEditorForm.ACInfoExecute(Sender: TObject);
var
	AScene: TGLSceneViewer;
begin
	AScene:=TGLSceneViewer.Create(Self);
	AScene.Name:='GLSceneEditor';
	AScene.Width:=0;
	AScene.Height:=0;
	AScene.Parent:=Self;
	try
		AScene.Buffer.ShowInfo;
	finally
		AScene.Free;
	end;
end;

// IsValidClipBoardNode
//
function TGLSceneEditorForm.IsValidClipBoardNode : Boolean;
var
   selNode : TTreeNode;
begin
   selNode:=Tree.Selected;
   Result:=((selNode<>nil) and (selNode.Parent<>nil)
            and (selNode.Parent.Parent<>nil));
end;

// IsPastePossible
//
function TGLSceneEditorForm.IsPastePossible : Boolean;
{$ifdef GLS_DELPHI_6_UP}

   function PossibleStream(const S: string): Boolean;
   var
     I: Integer;
   begin
     Result := True;
     for I := 1 to Length(S) - 6 do begin
       if (S[I] in ['O','o']) and (CompareText(Copy(S, I, 6), 'OBJECT') = 0) then Exit;
       if not (S[I] in [' ',#9, #13, #10]) then Break;
     end;
     Result := False;
   end;

var
   selNode : TTreeNode;
	anObject, destination : TGLBaseSceneObject;
   ComponentList: IDesignerSelections;
   TmpContainer : TComponent;
begin
   selNode:=Tree.Selected;

   if (selNode<>nil) and (selNode.Parent<>nil)
      {$IFDEF MSWINDOWS}
      and (ClipBoard.HasFormat(CF_COMPONENT) or (Clipboard.HasFormat(CF_TEXT) and
      PossibleStream(Clipboard.AsText))) {$ENDIF} then begin
      TmpContainer := TComponent.Create(self);
      try
         ComponentList := TDesignerSelections.Create;
         PasteComponents(TmpContainer, TmpContainer, ComponentList);
         if (ComponentList.Count>0) and (ComponentList[0] is TGLBaseSceneObject) then begin
            anObject:=TGLBaseSceneObject(ComponentList[0]);
            destination:=TGLBaseSceneObject(selNode.Data);
            Result:=CanPaste(anObject, destination);
         end else Result:=False;
      finally
         TmpContainer.Free;
      end;
   end else Result:=False;
{$else}
begin
   Result:=False;
{$endif}
end;

// CanPaste
//
{$ifdef GLS_DELPHI_6_UP}
function TGLSceneEditorForm.CanPaste(obj, destination : TGLBaseSceneObject) : Boolean;
begin
   Result:=((obj is TGLCamera) or (destination<>FScene.Cameras))
           and (obj is TGLBaseSceneObject);
end;
{$endif}

// ACCopyExecute
//
procedure TGLSceneEditorForm.ACCopyExecute(Sender: TObject);
{$ifdef GLS_DELPHI_6_UP}
var
   ComponentList: IDesignerSelections;
begin
   ComponentList := TDesignerSelections.Create;
   ComponentList.Add(TGLBaseSceneObject(Tree.Selected.Data));
   CopyComponents(FScene.Owner, ComponentList);
   ACPaste.Enabled:=IsPastePossible;
{$else}
begin
{$endif}
end;

// ACCutExecute
//
procedure TGLSceneEditorForm.ACCutExecute(Sender: TObject);
var
	AObject : TGLBaseSceneObject;
   selNode : TTreeNode;
begin
   selNode:=Tree.Selected;
   if IsValidClipBoardNode then begin
      AObject:=TGLBaseSceneObject(selNode.Data);
      ClipBoard.SetComponent(AObject);
      AObject.Parent.Remove(AObject, False);
      AObject.Free;
      Tree.Selected.Free;
   end;
end;




// ACPasteExecute
//
procedure TGLSceneEditorForm.ACPasteExecute(Sender: TObject);
{$ifdef GLS_DELPHI_6_UP}
var
   selNode : TTreeNode;
	destination : TGLBaseSceneObject;
   ComponentList: IDesignerSelections;
   t: integer;
begin
   selNode:=Tree.Selected;
   if (selNode<>nil) and (selNode.Parent<>nil) then begin
      destination:=TGLBaseSceneObject(selNode.Data);
      ComponentList := TDesignerSelections.Create;
      PasteComponents(FScene.Owner, destination, ComponentList);
      if (ComponentList.count>0) and (CanPaste(TGLBaseSCeneObject(ComponentList[0]), destination)) then begin
         for t :=0 to ComponentList.Count-1 do
            AddNodes(selNode, TGLBaseSCeneObject(ComponentList[t]) );
         selNode.Expand(False);
      end;
      FCurrentDesigner.Modified;
   end;
{$else}
begin
{$endif}
end;

{$ifdef GLS_DELPHI_6_UP}
// CopyComponents
//
procedure TGLSceneEditorForm.CopyComponents(Root: TComponent; const Components: IDesignerSelections);
var
  S: TMemoryStream;
  W: TWriter;
  I: Integer;
begin
  S := TMemoryStream.Create;
  try
    W := TWriter.Create(S, 1024);
    try
      W.Root := Root;
      for I := 0 to Components.Count - 1 do
      begin
        W.WriteSignature;
        W.WriteComponent(TComponent(Components[I]));
      end;
      W.WriteListEnd;
    finally
      W.Free;
    end;
    CopyStreamToClipboard(S);
  finally
    S.Free;
  end;
end;

procedure TGLSceneEditorForm.MethodError(Reader: TReader;
      const MethodName: String; var Address: Pointer; var Error: Boolean);
begin
   // error is true because Address is nil in csDesigning
   Error:=false;
end;

procedure TGLSceneEditorForm.PasteComponents(AOwner, AParent: TComponent;const Components: IDesignerSelections);
var
  S: TStream;
  R: TReader;
begin
  S := GetClipboardStream;
  try
    R := TReader.Create(S, 1024);
    try
      R.OnSetName := ReaderSetName;
      R.OnFindMethod := MethodError;
      FPasteOwner := AOwner;
      FPasteSelection := Components;
      R.ReadComponents(AOwner, AParent, ComponentRead);
    finally
      R.Free;
    end;
  finally
    S.Free;
  end;
end;

procedure TGLSceneEditorForm.ReaderSetName(Reader: TReader; Component: TComponent; var Name: string);
begin
  if (Reader.Root = FPasteOwner) and (FPasteOwner.FindComponent(Name) <> nil) then
    Name := UniqueName(Component);
end;

function TGLSceneEditorForm.UniqueName(Component: TComponent): string;
begin
  Result := FCurrentDesigner.UniqueName(Component.ClassName);
end;

procedure TGLSceneEditorForm.ComponentRead(Component: TComponent);
begin
   FPasteSelection.Add(Component);
end;
{$endif}

procedure TGLSceneEditorForm.BehavioursListViewEnter(Sender: TObject);
begin
   if Assigned(FCurrentDesigner) and Assigned(BehavioursListView.Selected) then
      FCurrentDesigner.SelectComponent(BehavioursListView.Selected.Data);
   FSelectedItems:=BEHAVIOURS_SELECTED;
   EnableAndDisableActions();
end;

procedure TGLSceneEditorForm.EffectsListViewEnter(Sender: TObject);
begin
   if Assigned(FCurrentDesigner) and Assigned(EffectsListView.Selected) then
      FCurrentDesigner.SelectComponent(EffectsListView.Selected.Data);
   FSelectedItems:=EFFECTS_SELECTED;
   EnableAndDisableActions();   
end;

procedure TGLSceneEditorForm.ACAddBehaviourExecute(Sender: TObject);
begin
  TBAddBehaviours.CheckMenuDropdown
end;

procedure TGLSceneEditorForm.DeleteBaseBehaviour(ListView:TListView);
begin
  if ListView.Selected<>nil then
  begin

      FCurrentDesigner.Modified;
{$ifndef GLS_DELPHI_4}
      FCurrentDesigner.NoSelection;
{$else}
      FCurrentDesigner.SelectComponent(nil);
{$endif}
      TXCollectionItem(ListView.Selected.Data).Free;
      ListView.Selected.Free;
     // ListViewChange(Self, nil, ctState);
      ShowBehavioursAndEffects(TGLBaseSceneObject(Tree.Selected.Data));
  end;
end;

procedure TGLSceneEditorForm.PMBehavioursToolbarPopup(Sender: TObject);
var
  object1:TGLBaseSceneObject;
begin
   if (Tree.Selected)<>nil then
   begin
     object1:=TGLBaseSceneObject(Tree.Selected.Data);
     SetBehavioursSubItems(PMBehavioursToolbar.Items, object1.Behaviours);
   end;
end;

procedure TGLSceneEditorForm.PMEffectsToolbarPopup(Sender: TObject);
var
  object1:TGLBaseSceneObject;
begin
   if (Tree.Selected)<>nil then
   begin
     object1:=TGLBaseSceneObject(Tree.Selected.Data);
     SetEffectsSubItems(PMEffectsToolbar.Items, object1.Effects);
   end;
end;


procedure TGLSceneEditorForm.BehavioursListViewSelectItem(Sender: TObject;
  Item: TListItem; Selected: Boolean);
begin
  EnableAndDisableActions();
end;

procedure TGLSceneEditorForm.ACAddEffectExecute(Sender: TObject);
begin
   TBAddEffects.CheckMenuDropdown;
end;

procedure TGLSceneEditorForm.EnableAndDisableActions();
var
  SelNode:TTreeNode;
begin
  if FSelectedItems=SCENE_SELECTED then
  begin
      selNode:=Tree.Selected;
      // select in Delphi IDE
      if Assigned(selNode) then
      begin
         if Assigned(selNode.Data) then
            FCurrentDesigner.SelectComponent(selNode.Data)
         else FCurrentDesigner.SelectComponent(FScene);
         // enablings
         ACAddCamera.Enabled:=(selNode=FCameraNode);
         ACAddObject.Enabled:=((selNode=FObjectNode) or selNode.HasAsParent(FObjectNode));
         ACAddBehaviour.Enabled:=(selNode.HasAsParent(FObjectNode));
         ACAddEffect.Enabled:=(selNode.HasAsParent(FObjectNode));
         ACDeleteObject.Enabled:=(selNode.Level>1);
         ACMoveUp.Enabled:=((selNode.Index>0)and(selNode.Level>1));
         ACMoveDown.Enabled:=((selNode.GetNextSibling<>nil)and(selNode.Level>1));
         ACCut.Enabled:=IsValidClipBoardNode;
         ACPaste.Enabled:=IsPastePossible;

      end
      else
      begin
         ACAddCamera.Enabled:=False;
         ACAddObject.Enabled:=False;
         ACAddBehaviour.Enabled:=False;
         ACAddEffect.Enabled:=False;
         ACDeleteObject.Enabled:=False;
         ACMoveUp.Enabled:=False;
         ACMoveDown.Enabled:=False;
         ACCut.Enabled:=False;
         ACPaste.Enabled:=False;
      end;
//   end;
   ACCopy.Enabled:=ACCut.Enabled;

  end
  else if FSelectedItems=BEHAVIOURS_SELECTED then
  begin
    if (BehavioursListView.Selected<>nil) then
    begin
         FCurrentDesigner.SelectComponent(BehavioursListView.Selected.Data);
         ACDeleteObject.Enabled:=True;
         ACMoveUp.Enabled:=(BehavioursListView.Selected.Index>0);
         ACMoveDown.Enabled:=(BehavioursListView.Selected.Index<BehavioursListView.Selected.Owner.Count-1);
         ACCut.Enabled:=False;
         ACCopy.Enabled:=false;
         ACPaste.Enabled:=False;
    end
      else
      begin
         ACDeleteObject.Enabled:=false;
         ACMoveUp.Enabled:=false;
         ACMoveDown.Enabled:=false;
         ACCut.Enabled:=false;
         ACCopy.Enabled:=false;
         ACPaste.Enabled:=false;
      end;
  end
  else if FSelectedItems=EFFECTS_SELECTED then
  begin
    if (EffectsListView.Selected<>nil)then
    begin
         FCurrentDesigner.SelectComponent(EffectsListView.Selected.Data);
         ACDeleteObject.Enabled:=True;
         ACMoveUp.Enabled:=(EffectsListView.Selected.Index>0);
         ACMoveDown.Enabled:=(EffectsListView.Selected.Index<EffectsListView.Selected.Owner.Count-1);
         ACCut.Enabled:=False;
         ACCopy.Enabled:=false;
         ACPaste.Enabled:=False;
    end
      else
      begin
         ACDeleteObject.Enabled:=false;
         ACMoveUp.Enabled:=false;
         ACMoveDown.Enabled:=false;
         ACCut.Enabled:=false;
         ACCopy.Enabled:=false;
         ACPaste.Enabled:=false;
      end;
  end;

end;

procedure TGLSceneEditorForm.PopupMenuPopup(Sender: TObject);
var
   obj : TObject;
   sceneObj : TGLBaseSceneObject;
begin
   if (Tree.Selected)<>nil then begin
      obj:=TObject(Tree.Selected.Data);
      if Assigned(obj) and (obj is TGLBaseSceneObject) then begin
         sceneObj:=TGLBaseSceneObject(obj);
         SetBehavioursSubItems(MIAddBehaviour, sceneObj.Behaviours);
         SetEffectsSubItems(MIAddEffect, sceneObj.Effects);
      end else begin
         SetBehavioursSubItems(MIAddBehaviour, nil);
         SetEffectsSubItems(MIAddEffect, nil);
      end;
   end;
end;

procedure TGLSceneEditorForm.TBEffectsPanelClick(Sender: TObject);
begin
   PABehaviours.Visible:=TBEffectsPanel.Down;
   Splitter.Visible:=TBEffectsPanel.Down;
   if PABehaviours.Visible then
      Width:=Width+PABehaviours.Width
   else Width:=Width-PABehaviours.Width;
end;

initialization

finalization

   ReleaseGLSceneEditorForm;

end.

