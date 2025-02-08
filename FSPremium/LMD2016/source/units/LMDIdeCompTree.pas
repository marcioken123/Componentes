unit LMDIdeCompTree;
{$I LMDCmps.inc}

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

LMDIdeCompTree unit (YB)
------------------------
TLMDComponentTree unit.

Changes
-------

###############################################################################}

interface

uses
  Classes, Controls, Windows, Messages, SysUtils, Graphics, TypInfo, ComCtrls,
  ImgList, Forms, Menus, intfLMDBase, LMDTypes, LMDSvcPvdr, LMDDsgClass,
  LMDDsgModule, LMDDsgObjects, LMDDsgDesigner, LMDIdeCst, LMDIdeClass;

type
  TLMDComponentTree = class;
  TLMDSprig         = class;
  TLMDSprigClass    = class of TLMDSprig;

  {********************************** TLMDSprig *******************************}

  TLMDSprigImageKind = (sikFake, sikFakeCollection, sikPersistent, sikCollection,
                        sikComponent, sikControl, sikWinControl, sikContainer,
                        sikForm);

  TLMDGetSprigClassProc = procedure(AInstance: TPersistent;
                                    var ASprigClass: TLMDSprigClass) of object;

  TLMDSprig = class
  private
    FTree:     TLMDComponentTree;
    FParent:   TLMDSprig;
    FNode:     TTreeNode;
    FInstance: TPersistent;
    FPropName: TLMDString;
    FItems:    TList;

    procedure SetNode(ANode: TTreeNode);
    procedure InsertItem(AItem: TLMDSprig);
    procedure RemoveItem(AItem: TLMDSprig);
    procedure ClearItems;
    function  GetCount: Integer;
    function  GetItems(AIndex: Integer): TLMDSprig;
  protected
    procedure CreateChildren(AGetEditorClassProc: TLMDGetSprigClassProc); virtual;
    procedure ValidateParent(var AParent: TLMDSprig); virtual;
    function  GetDisplayName: TLMDString; virtual;
    function  GetImageKind: TLMDSprigImageKind; virtual;
  public
    constructor Create(ATree: TLMDComponentTree; AParent: TLMDSprig;
                       AInstance: TPersistent;
                       const APropName: TLMDString = ''); virtual;
    destructor Destroy; override;

    property Tree: TLMDComponentTree read FTree;
    property Node: TTreeNode read FNode;
    property Parent: TLMDSprig read FParent;
    property Instance: TPersistent read FInstance;
    property PropName: TLMDString read FPropName;
    property DisplayName: TLMDString read GetDisplayName;
    property ImageKind: TLMDSprigImageKind read GetImageKind;
    property Count: Integer read GetCount;
    property Items[AIndex: Integer]: TLMDSprig read GetItems; default;
  end;

  {****************************** TLMDComponentTree ***************************}

  TLMDCompTreeMenuOptions    = set of (ctmoAddCompEditorItems);
  TLMDCompTreeServiceOptions = set of (ctsoUseObjEditService);

  TLMDComponentTree = class(TCustomTreeView, ILMDComponent)
  private
    FAbout:             TLMDAboutVar;
    FSprigTypes:        TList;
    FRootSprig:         TLMDSprig;
    FRoot:              TWinControl;
    FAllSprigs:         TList;
    FDblClicking:       Boolean;
    FUpdateCount:       Integer;
    FSelnNotifier:      ILMDDsgObjsNotifier;
    FSelection:         TLMDDesignObjects;
    FUpdatingSeln:      Boolean;
    FServiceProvider:   TLMDServiceProvider;
    FUpdatingTreeNodes: Boolean;
    FTempMenu:          TPopupMenu;
    FMenuOptions:       TLMDCompTreeMenuOptions;
    FServiceOptions:    TLMDCompTreeServiceOptions;

    procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    procedure DummyDrawHandler(Sender: TCustomTreeView; Node: TTreeNode;
                               State: TCustomDrawState; Stage: TCustomDrawStage;
                               var PaintImages, DefaultDraw: Boolean);
    function  FindSprigTypeItem(AObjectClass: TClass): TObject;
    procedure ClearSprigTypes;
    procedure SetRoot(const Value: TWinControl);
    procedure SetSelection(const Value: TLMDDesignObjects);
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
    procedure CompsChangeNotification(Sender: TObject; AChangedComps: TList);
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure CreateHandle; override;
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
    procedure DblClick; override;
    function  CanCollapse(Node: TTreeNode): Boolean; override;
    function  CanExpand(Node: TTreeNode): Boolean; override;
    function  CreateNode: TTreeNode; override;
    procedure Change(Node: TTreeNode); override;
    function  CustomDrawItem(Node: TTreeNode; State: TCustomDrawState;
                             Stage: TCustomDrawStage;
                             var PaintImages: Boolean): Boolean; override;
    procedure GetSprigClass(AInstance: TPersistent;
                            var ASprigClass: TLMDSprigClass); virtual;

    procedure RecreateSprigs;
    procedure UpdateTreeNodes;
    procedure UpdateSelection;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure RegisterSprig(AObjectClass: TClass; ASprigClass: TLMDSprigClass);
    procedure UnregisterSprig(AObjectClass: TClass);

    procedure BeginUpdate;
    procedure EndUpdate;

    procedure UpdateSprigs;
    procedure UpdateContent;
    function  FindSprig(AInstance: TPersistent): TLMDSprig;
    function  ConvertTreeNode(ATreeNode: TTreeNode): TLMDSprig;

    property RootSprig: TLMDSprig read FRootSprig;
    property Root: TWinControl read FRoot write SetRoot;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property ServiceOptions: TLMDCompTreeServiceOptions read FServiceOptions write FServiceOptions
                default [ctsoUseObjEditService];
    property Selection: TLMDDesignObjects read FSelection write SetSelection;
    property MenuOptions: TLMDCompTreeMenuOptions read FMenuOptions write FMenuOptions
                default [ctmoAddCompEditorItems];
    property Align;
    property Anchors;
    property AutoExpand;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property ChangeDelay;
    property Color;
    property Ctl3D;
    property Constraints;
    property DragKind;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property HideSelection default False;
    property HotTrack;
    property Indent;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property RightClickSelect;
    property RowSelect;
    property ShowHint;
    property ShowLines;
    property ShowRoot;
    property TabOrder;
    property TabStop default True;
    property Visible;
    property OnAddition;
    property OnClick;
    property OnCollapsed;
    property OnCollapsing;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnExpanding;
    property OnExpanded;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  LMDIdeSprigs;

{------------------------------------------------------------------------------}

type
  TPersistentAccess = class(TPersistent);

  TSprigTypeItem = class
  public
    ObjectClass: TClass;
    SprigClass:  TLMDSprigClass;
  end;

  TSprigTreeNode = class(TTreeNode)
  private
    FSprig:        TLMDSprig;
    FTempInstance: TPersistent; // Only for recreating sprigs.
  public
    destructor Destroy; override;
  end;

  TSelnNotifier = class(ILMDDsgObjsNotifier)
  private
    FTree: TLMDComponentTree;
  public
    constructor Create(ATree: TLMDComponentTree);
    procedure   Changed(ASender: TLMDDesignObjects); override;
  end;

{------------------------------------------------------------------------------}

var
  CompTreeImages: TImageList;

{------------------------------------------------------------------------------}

procedure InitTreeImages;

  procedure _AddBitmap(const AResName: string);
  var
    bmp:  TBitmap;
    mask: TBitmap;
  begin
    bmp  := TBitmap.Create;
    mask := TBitmap.Create;
    try
      bmp.Transparent := True;
      bmp.LoadFromResourceName(HInstance, AResName);

      mask.Assign(bmp);
      mask.Mask(mask.Canvas.Pixels[0, 0]);

      CompTreeImages.Add(bmp, mask);
    finally
      bmp.Free;
      mask.Free;
    end;
  end;

begin
  CompTreeImages := TImageList.Create(nil);
  try
    _AddBitmap('LMD_SPRIGFAKE');
    _AddBitmap('LMD_SPRIGFAKECOLLECTION');
    _AddBitmap('LMD_SPRIGPERSISTENT');
    _AddBitmap('LMD_SPRIGCOLLECTION');
    _AddBitmap('LMD_SPRIGCOMPONENT');
    _AddBitmap('LMD_SPRIGCONTROL');
    _AddBitmap('LMD_SPRIGWINCONTROL');
    _AddBitmap('LMD_SPRIGCONTAINER');
    _AddBitmap('LMD_SPRIGFORM');
  except
    CompTreeImages.Free;
    CompTreeImages := nil;
    raise;
  end;
end;

{******************************* TSprigTreeNode *******************************}
{------------------------------------------------------------------------------}

destructor TSprigTreeNode.Destroy;
begin
  if FSprig <> nil then
    FSprig.SetNode(nil);
  inherited;
end;

{******************************* TSelnNotifier ********************************}
{------------------------------------------------------------------------------}

constructor TSelnNotifier.Create(ATree: TLMDComponentTree);
begin
  inherited Create;
  FTree := ATree;
end;

{------------------------------------------------------------------------------}

procedure TSelnNotifier.Changed(ASender: TLMDDesignObjects);
begin
  if not FTree.FUpdatingSeln then
    FTree.UpdateSprigs;
end;

{*********************************** TLMDSprig ********************************}
{------------------------------------------------------------------------------}

procedure TLMDSprig.SetNode(ANode: TTreeNode);
begin
  if FNode <> ANode then
  begin
    if FNode <> nil then
      TSprigTreeNode(FNode).FSprig := nil;
    FNode := ANode;
    if FNode <> nil then
      TSprigTreeNode(FNode).FSprig := Self;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDSprig.InsertItem(AItem: TLMDSprig);
begin
  FItems.Add(AItem);
end;

{------------------------------------------------------------------------------}

procedure TLMDSprig.RemoveItem(AItem: TLMDSprig);
begin
  FItems.Remove(AItem);
end;

{------------------------------------------------------------------------------}

procedure TLMDSprig.ClearItems;
begin
  while FItems.Count > 0 do
    TObject(FItems[0]).Free;
end;

{------------------------------------------------------------------------------}

function TLMDSprig.GetCount: Integer;
begin
  Result := FItems.Count;
end;

{------------------------------------------------------------------------------}

function TLMDSprig.GetItems(AIndex: Integer): TLMDSprig;
begin
  Result := TLMDSprig(FItems[AIndex]);
end;

{------------------------------------------------------------------------------}

procedure TLMDSprig.CreateChildren(AGetEditorClassProc: TLMDGetSprigClassProc);
var
  plist: TLMDPropList;
  pcnt:  Integer;
  i:     Integer;
  obj:   TObject;
  scls:  TLMDSprigClass;
begin
  if Instance <> nil then
  begin
    pcnt := GetPropList(Instance.ClassInfo, [tkClass], nil);
    GetMem(plist, pcnt * SizeOf(Pointer));
    GetPropList(Instance.ClassInfo, [tkClass], plist);
    try
      for i := 0 to pcnt - 1 do
      begin
        obj := TObject(GetOrdProp(Instance, plist[i]));

        if (obj is TCollection) and
           (TPersistentAccess(obj).GetOwner <> nil) and
           (Tree.FindSprig(TCollection(obj)) = nil) then
        begin
          AGetEditorClassProc(TCollection(obj), scls);
          scls.Create(Tree, Self, TCollection(obj), {$IFDEF LMDCOMP12}String{$ENDIF}(plist[i].Name));
        end;
      end;
    finally
      FreeMem(plist);
    end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDSprig.ValidateParent(var AParent: TLMDSprig);
var
  pnt: TPersistent;
begin
  pnt := nil;

  if FInstance is TComponent then
    pnt := TComponent(FInstance).GetParentComponent;

  if pnt <> nil then
    AParent := Tree.FindSprig(pnt);
end;

{------------------------------------------------------------------------------}

function TLMDSprig.GetDisplayName: TLMDString;
begin
  Result := Instance.GetNamePath;
end;

{------------------------------------------------------------------------------}

function TLMDSprig.GetImageKind: TLMDSprigImageKind;
begin
  Result := sikPersistent;
end;

{------------------------------------------------------------------------------}

constructor TLMDSprig.Create(ATree: TLMDComponentTree;
  AParent: TLMDSprig; AInstance: TPersistent; const APropName: TLMDString);
begin
  inherited Create;
  FTree     := ATree;
  FParent   := AParent;
  FInstance := AInstance;
  FPropName := APropName;
  FItems    := TList.Create;

  FTree.FAllSprigs.Add(Self);
  if FParent <> nil then
    FParent.InsertItem(Self);
end;

{------------------------------------------------------------------------------}

destructor TLMDSprig.Destroy;
begin
  SetNode(nil);
  ClearItems;

  FTree.FAllSprigs.Remove(Self);
  if FParent <> nil then
    FParent.RemoveItem(Self);

  FItems.Free;
  inherited;
end;

{******************************* TLMDComponentTree ****************************}
{------------------------------------------------------------------------------}

function TLMDComponentTree.FindSprigTypeItem(AObjectClass: TClass): TObject;
var
  i: Integer;
begin
  for i := 0 to FSprigTypes.Count - 1 do
    if TSprigTypeItem(FSprigTypes[i]).ObjectClass = AObjectClass then
    begin
      Result := FSprigTypes[i];
      Exit;
    end;

  Result := nil;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.ClearSprigTypes;
var
  i: Integer;
begin
  for i := 0 to FSprigTypes.Count - 1 do
    TObject(FSprigTypes[i]).Free;
  FSprigTypes.Clear;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.SetRoot(const Value: TWinControl);
begin
  if FRoot <> Value then
  begin
    if FRoot <> nil then
      FRoot.RemoveFreeNotification(Self);
    FRoot := Value;
    if FRoot <> nil then
      FRoot.FreeNotification(Self);

    RecreateSprigs;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.SetSelection(const Value: TLMDDesignObjects);
begin
  if FSelection <> Value then
  begin
    if FSelection <> nil then
      FSelection.RemoveNotifier(FSelnNotifier);
    FSelection := Value;
    if FSelection <> nil then
      FSelection.AddNotifier(FSelnNotifier);

    UpdateTreeNodes;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.SetServiceProvider(
  const Value: TLMDServiceProvider);
begin
  if FServiceProvider <> Value then
  begin
    if FServiceProvider <> nil then
    begin
      FServiceProvider.RemoveFreeNotification(Self);
      FServiceProvider.Members.UnregisterMember(Self);
    end;
    FServiceProvider := Value;
    if FServiceProvider <> nil then
    begin
      FServiceProvider.FreeNotification(Self);
      FServiceProvider.Members.RegisterMember(Self);
    end;
  end;
end;

{------------------------------------------------------------------------------}

function TLMDComponentTree.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.CreateHandle;
begin
  inherited;
  UpdateTreeNodes;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FRoot then
      Root := nil;
    if AComponent = FSelection then
      Selection := nil;
    if AComponent = FServiceProvider then
      ServiceProvider := nil;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.DoContextPopup(MousePos: TPoint;
  var Handled: Boolean);
var
  ppmnu:    TPopupMenu;
  isdefmnu: Boolean;
  svc:      ILMDObjEditService;
begin
  FTempMenu.Free;   // Destroy previous implicit menu.
  FTempMenu := nil; //

  if Assigned(OnContextPopup) then
    OnContextPopup(Self, MousePos, Handled);
  if Handled then
    Exit;

  ppmnu    := GetPopupMenu;
  isdefmnu := (ppmnu = nil);
  if isdefmnu then
  begin
    FTempMenu  := TPopupMenu.Create(nil);
    ppmnu      := FTempMenu;
  end;

  if ppmnu.AutoPopup then
  begin
    { Find component-editors service }

    if (Selection.Count = 1) and
       (ctsoUseObjEditService in FServiceOptions) and
       LMDTryGetService(FServiceProvider, ILMDObjEditService, svc) then
    begin
      svc.AdjustMenu(Self, Selection[0], ppmnu);
    end;

    { Do popup }

    MousePos := ClientToScreen(MousePos);

    ppmnu.PopupComponent := Self;
    ppmnu.Popup(MousePos.X, MousePos.Y);
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.DblClick;
var
  p:    TPoint;
  svc:  ILMDObjEditService;
begin
  { Send command to component-editors service }

  GetCursorPos(p);
  p := ScreenToClient(p);

  if htOnItem in GetHitTestInfoAt(p.X, p.Y) then
  begin
    if (Selection.Count = 1) and (ctsoUseObjEditService in FServiceOptions) and
       LMDTryGetService(FServiceProvider, ILMDObjEditService, svc) then
    begin
      svc.DblClicked(Self, Selection[0]);
    end;
  end;

  { Fire event }

  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDComponentTree.CreateNode: TTreeNode;
begin
  Result := TSprigTreeNode.Create(Items);
  Result.ImageIndex    := -1;
  Result.SelectedIndex := -1;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.Change(Node: TTreeNode);
begin
  inherited;
  if not FUpdatingTreeNodes then
    UpdateSelection;
end;

{------------------------------------------------------------------------------}

function TLMDComponentTree.CustomDrawItem(Node: TTreeNode;
  State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages: Boolean): Boolean;
var
  r:     TRect;
  sprig: TLMDSprig;
begin
  if Stage = cdPostPaint then
  begin
    Result      := False;
    PaintImages := False;

    sprig := TSprigTreeNode(Node).FSprig;
    r     := Node.DisplayRect(True);

    if sprig <> nil then
      Images.Draw(Canvas, r.Left - 16, r.Top,
                  Ord(sprig.ImageKind));
  end
  else
    Result := True;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.GetSprigClass(AInstance: TPersistent;
  var ASprigClass: TLMDSprigClass);
var
  cls:  TClass;
  item: TSprigTypeItem;
begin
  ASprigClass := nil;
  cls         := AInstance.ClassType;

  { Search in registered }

  while cls <> TObject do
  begin
    item := TSprigTypeItem(FindSprigTypeItem(cls));
    if item <> nil then
    begin
      ASprigClass := item.SprigClass;
      Exit;
    end;

    cls := cls.ClassParent;
  end;

  { Assign standard one }

  if AInstance is TCustomForm then
    ASprigClass := TLMDFormSprig
  else if AInstance is TCustomFrame then
    ASprigClass := TLMDFrameSprig
  else if AInstance is TWinControl then
  begin
    if TWinControl(AInstance).Owner = nil then
      ASprigClass := TLMDRootControlSprig // Avoid to write unneeded
                                          // root specific sprigs for
                                          // non-form roots.
    else
      ASprigClass := TLMDWinControlSprig;
  end
  else if AInstance is TControl then
    ASprigClass := TLMDControlSprig
  else if AInstance is TComponent then
    ASprigClass := TLMDComponentSprig
  else if AInstance is TCollection then
    ASprigClass := TLMDCollectionSprig
  else if AInstance is TCollectionItem then
    ASprigClass := TLMDCollectionItemSprig
  else
    ASprigClass := TLMDSprig;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.RecreateSprigs;

  procedure _BeforeRecreation(ASprig: TLMDSprig);
  var
    i: Integer;
  begin
    if ASprig.FNode <> nil then
      TSprigTreeNode(ASprig.FNode).FTempInstance := ASprig.FInstance;

    for i := 0 to ASprig.Count - 1 do
      _BeforeRecreation(ASprig[i]);
  end;

  procedure _CreateChildren(ASprig: TLMDSprig);
  var
    i: Integer;
  begin
    ASprig.CreateChildren(GetSprigClass);

    for i := 0 to ASprig.Count - 1 do
      _CreateChildren(ASprig[i]);
  end;

  procedure _ValidateParents;
  var
    i:          Integer;
    sprig:      TLMDSprig;
    oldpnt,
    newpnt:     TLMDSprig;
    haschanges: Boolean;
  begin
    repeat
      haschanges := False;

      for i := 0 to FAllSprigs.Count - 1 do
      begin
        sprig := TLMDSprig(FAllSprigs[i]);

        if sprig = FRootSprig then
          Continue; // for

        oldpnt := sprig.FParent;
        newpnt := oldpnt;
        sprig.ValidateParent(newpnt);

        if newpnt = nil then
          newpnt := FRootSprig;

        if newpnt <> oldpnt then
        begin
          if oldpnt <> nil then
            oldpnt.RemoveItem(sprig);
          if newpnt <> nil then
            newpnt.InsertItem(sprig);
          sprig.FParent := newpnt;

          haschanges := True;
        end;
      end;
    until not haschanges;
  end;

  procedure _AssociateNode(ASprig: TLMDSprig; ANode: TTreeNode);

    function _FindNode(ASprig: TLMDSprig; AParent: TTreeNode): TTreeNode;
    var
      nd: TTreeNode;
    begin
      if ASprig.FInstance <> nil then
      begin
        nd := AParent.getFirstChild;
        while nd <> nil do
        begin
          if TSprigTreeNode(nd).FTempInstance = ASprig.FInstance then
          begin
            Result := nd;
            Exit;
          end;
          nd := AParent.GetNextChild(nd);
        end;
      end
      else
      begin
        nd := AParent.getFirstChild;
        while nd <> nil do
        begin
          if nd.Text = ASprig.DisplayName then
          begin
            Result := nd;
            Exit;
          end;
          nd := AParent.GetNextChild(nd);
        end;
      end;

      Result := nil;
    end;

  var
    i:  Integer;
    nd: TTreeNode;
  begin
    ASprig.SetNode(ANode);
    ANode.Text := ASprig.GetDisplayName;

    for i := 0 to ASprig.Count - 1 do
    begin
      nd := _FindNode(ASprig[i], ANode);
      if nd <> nil then
        _AssociateNode(ASprig[i], nd);
    end;
  end;

var
  sprgcls: TLMDSprigClass;

begin
  BeginUpdate;
  try
    if FRootSprig <> nil then
    begin
      _BeforeRecreation(FRootSprig);
      FRootSprig.Free;
      FRootSprig := nil;
    end;

    if FRoot <> nil then
    begin
      GetSprigClass(FRoot, sprgcls);
      FRootSprig := sprgcls.Create(Self, nil, FRoot);

      _CreateChildren(FRootSprig);
      _ValidateParents;
    end;

    if (FRootSprig <> nil) and (Items.GetFirstNode <> nil) then
      _AssociateNode(FRootSprig, Items.GetFirstNode);

    UpdateTreeNodes;
  finally
    EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.UpdateTreeNodes;

  function _UpdateOrDelNode(ANode: TTreeNode; ASelection: TList): TTreeNode;
  var
    sprig: TLMDSprig;
  begin
    sprig := TSprigTreeNode(ANode).FSprig;

    if sprig = nil then
    begin
      Result := ANode.GetNextSibling;
      ANode.Free;
    end
    else
    begin
      Result     := ANode.GetNext;
      ANode.Text := sprig.DisplayName;

      if (FSelection <> nil) and (ASelection.IndexOf(ANode) = -1) and
         (FSelection.IndexOf(sprig.FInstance) <> -1) then
        ASelection.Add(ANode);
    end;
  end;

  procedure _AddNewNode(AParent: TTreeNode; ASprig: TLMDSprig);
  var
    i:  Integer;
    nd: TTreeNode;
  begin
    if ASprig.FNode = nil then
    begin
      nd := Items.AddChild(AParent, ASprig.DisplayName);
      ASprig.SetNode(nd);
    end;

    for i := 0 to ASprig.Count - 1 do
      _AddNewNode(ASprig.FNode, ASprig[i]);
  end;

var
  seln: TList;
  nd:   TTreeNode;
begin
  if (FUpdateCount > 0) or not HandleAllocated then
    Exit;

  Items.BeginUpdate;
  seln               := TList.Create;
  FUpdatingTreeNodes := True;
  try
    { Delete old nodes }

    nd := Items.GetFirstNode;
    while nd <> nil do
      nd := _UpdateOrDelNode(nd, seln);

    { Add mising nodes }

    if FRootSprig <> nil then
      _AddNewNode(nil, FRootSprig);

    Select(seln);
  finally
    Items.EndUpdate;
    FUpdatingTreeNodes := False;
    seln.Free;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.UpdateSelection;
var
  i:     Integer;
  sprig: TLMDSprig;
begin
  if FSelection <> nil then
  begin
    FUpdatingSeln := True;
    FSelection.BeginUpdate;
    try
      FSelection.Clear;
      for i := 0 to SelectionCount - 1 do
        begin
          sprig := TSprigTreeNode(Selections[i]).FSprig;
          if (sprig <> nil) and (sprig.FInstance <> nil) then
            FSelection.Add(sprig.FInstance);
        end;
    finally
      FSelection.EndUpdate;
      FUpdatingSeln := False;
    end;
  end;
end;

{------------------------------------------------------------------------------}

constructor TLMDComponentTree.Create(AOwner: TComponent);
begin
  inherited;

  FSprigTypes      := TList.Create;
  FAllSprigs       := TList.Create;
  FSelnNotifier    := TSelnNotifier.Create(Self);
  FMenuOptions     := [ctmoAddCompEditorItems];
  FServiceOptions  := [ctsoUseObjEditService];
  MultiSelect      := True;
  MultiSelectStyle := [msControlSelect, msShiftSelect];
  HideSelection    := False;
  Images           := CompTreeImages;
  ReadOnly         := True;

  OnAdvancedCustomDrawItem := DummyDrawHandler; // The way to tell tree view
                                                // that it is custom-drawn.
                                                // Compatible with Delphi5.

  LMDRegisterComponentChangeNotification(Self, CompsChangeNotification);
end;

{------------------------------------------------------------------------------}

destructor TLMDComponentTree.Destroy;
begin
  ServiceProvider := nil;
  Root            := nil;
  Selection       := nil;
  ClearSprigTypes;
  LMDUnregisterComponentChangeNotification(Self);

  FSprigTypes.Free;
  FAllSprigs.Free;
  FSelnNotifier.Free;
  FTempMenu.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.RegisterSprig(AObjectClass: TClass;
  ASprigClass: TLMDSprigClass);
var
  item: TSprigTypeItem;
begin
  item := TSprigTypeItem(FindSprigTypeItem(AObjectClass));
  if item = nil then
  begin
    item := TSprigTypeItem.Create;
    try
      item.ObjectClass := AObjectClass;
      item.SprigClass  := ASprigClass;
      FSprigTypes.Add(item);
    except
      item.Free;
      raise;
    end;
  end;

  item.SprigClass := ASprigClass;
  RecreateSprigs;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.UnregisterSprig(AObjectClass: TClass);
var
  item: TSprigTypeItem;
begin
  item := TSprigTypeItem(FindSprigTypeItem(AObjectClass));
  if item <> nil then
  begin
    FSprigTypes.Remove(item);
    item.Free;
  end;

  RecreateSprigs;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.EndUpdate;
begin
  Dec(FUpdateCount);
  if FUpdateCount = 0 then
    UpdateTreeNodes;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.UpdateSprigs;
begin
  RecreateSprigs;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.UpdateContent;
begin
  UpdateTreeNodes;
end;

{------------------------------------------------------------------------------}

function TLMDComponentTree.FindSprig(AInstance: TPersistent): TLMDSprig;
var
  i: Integer;
begin
  for i := 0 to FAllSprigs.Count - 1 do
    if TLMDSprig(FAllSprigs[i]).FInstance = AInstance then
    begin
      Result := TLMDSprig(FAllSprigs[i]);
      Exit;
    end;

  Result := nil;
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.DummyDrawHandler(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; Stage: TCustomDrawStage;
  var PaintImages, DefaultDraw: Boolean);
begin
  // Do nothing.
end;
               
{------------------------------------------------------------------------------}

procedure TLMDComponentTree.CompsChangeNotification(Sender: TObject;
  AChangedComps: TList);
var
  i:      Integer;
  update: Boolean;
begin
  if (Sender = Self) or (FRoot = nil) then
    Exit;

  update := False;
  for i := 0 to AChangedComps.Count - 1 do
    if LMDIsObjectOwnedBy(TComponent(AChangedComps[i]), FRoot) then
    begin
      update := True;
      Break; // for
    end;

  if update then
    UpdateSprigs;
end;
            
{------------------------------------------------------------------------------}

function TLMDComponentTree.ConvertTreeNode(
  ATreeNode: TTreeNode): TLMDSprig;
begin
  if ATreeNode is TSprigTreeNode then
    Result := TSprigTreeNode(ATreeNode).FSprig
  else
    Result := nil;
end;

{------------------------------------------------------------------------------}

function TLMDComponentTree.CanCollapse(Node: TTreeNode): Boolean;
begin
  Result := (Node <> Items.GetFirstNode) and not FDblClicking;
  if Result then
    Result := inherited CanCollapse(Node);
end;

{------------------------------------------------------------------------------}

function TLMDComponentTree.CanExpand(Node: TTreeNode): Boolean;
begin
  Result := not FDblClicking;
  if Result then
    Result := inherited CanExpand(Node);
end;

{------------------------------------------------------------------------------}

procedure TLMDComponentTree.WMLButtonDblClk(var Message: TWMLButtonDblClk);
begin
  FDblClicking := (htOnItem in GetHitTestInfoAt(Message.XPos, Message.YPos));
  try
    inherited;
  finally
    FDblClicking := False;
  end;
end;

{------------------------------------------------------------------------------}

initialization
  InitTreeImages;

{------------------------------------------------------------------------------}

finalization
  CompTreeImages.Free;

{------------------------------------------------------------------------------}

end.
