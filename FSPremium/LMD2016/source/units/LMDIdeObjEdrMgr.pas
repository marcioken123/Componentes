unit LMDIdeObjEdrMgr;
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

LMDIdeObjEdrMgr unit (YB)
-------------------------
TLMDObjectEditorManager unit. The manager for so called Component Editors.

Changes
-------

###############################################################################}

interface

uses
  Classes, Controls, Windows, Messages, SysUtils, Menus, ActnList, TypInfo,
  ComCtrls, intfLMDBase, LMDTypes, LMDStrings, LMDSvcPvdr, LMDInsClass,
  LMDDsgObjects, LMDDsgModule, LMDIdeCst, LMDIdeClass, LMDInsEditorWnds,
  LMDInsEditorUtils;

type
  TLMDObjectEditorManager = class;

  {**************************** TLMDObjectEditor ******************************}

  TLMDObjectEditorClass = class of TLMDObjectEditor;
  TLMDObjectEditor      = class
  private
    FOwner:     TLMDObjectEditorManager;
    FInstance:  TPersistent;

    function GetServiceProvider: TLMDServiceProvider;
  public
    constructor Create(AOwner: TLMDObjectEditorManager;
                       AInstance: TPersistent); virtual;
    destructor Destroy; override;

    function  CreateEditorWndCbs(AEditingObject: TPersistent;
                out AResult: TLMDEditorWindowCallbacks): Boolean;
    procedure Changed;
    procedure GetObjects(AResult: TList);
    procedure SetObjects(AObjects: TList); overload;
    procedure SetObjects(AObjects: array of TPersistent); overload;

    procedure Edit; virtual;
    function  GetVerbCount: Integer; virtual;
    function  GetVerb(AIndex: Integer): TLMDString; virtual;
    procedure ExecuteVerb(AIndex: Integer); virtual;

    property Owner: TLMDObjectEditorManager read FOwner;
    property Instance: TPersistent read FInstance;
    property ServiceProvider: TLMDServiceProvider read GetServiceProvider;
  end;

  {************************ TLMDObjectEditorManager ***************************}

  TLMDComponentEdrMgrOnGetEditorClass = procedure(Sender: TObject;
    AInstance: TPersistent; var AEditorClass: TLMDObjectEditorClass) of object;

  TLMDComponentEdrMgrOnAdjustMenu = procedure(Sender: TObject;
    AEditor: TLMDObjectEditor; AMenu: TPopupMenu; var AHandled: Boolean) of object;

  TLMDComponentEdrMgrOnDefaultAction = procedure(Sender: TObject;
    AInstance: TPersistent; var AHandled: Boolean) of object;

  TLMDObjectEditorManager = class(TComponent, ILMDComponent)
  private
    FAbout:                       TLMDAboutVar;
    FItems:                       TList;
    FEditors:                     TList;
    FRecreateDefferCount:         Integer;
    FNeedRecreate:                Boolean;
    FServiceProvider:             TLMDServiceProvider;
    FSelection:                   TLMDDesignObjects;
    FSelnNotifier:                TObject;
    FOnGetEditorClass:            TLMDComponentEdrMgrOnGetEditorClass;
    FOnAdjustMenu:                TLMDComponentEdrMgrOnAdjustMenu;
    FOnDefaultAction:             TLMDComponentEdrMgrOnDefaultAction;
    FOnChange:                    TNotifyEvent;
    FEventHandlerAsDefaultAction: Boolean;

    procedure ClearItems;
    function  FindItem(AClass: TPersistentClass): TObject;
    procedure InsertEditor(AEditor: TLMDObjectEditor);
    procedure RemoveEditor(AEditor: TLMDObjectEditor);
    procedure ClearEditors;
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
    procedure SetSelection(const Value: TLMDDesignObjects);
    procedure RegisterStandardEditors;
  protected
    { ILMDComponent }
    
    function getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    function  DetectEditorWindowManager(AEditingObject: TPersistent):
                                        TLMDEditorWindowManager; virtual;
    procedure DoDefaultAction(AInstance: TPersistent;
                              var AHandled: Boolean); virtual;
    procedure DoChange(AInstance: TPersistent); virtual;

    procedure RecreateEditors;
    procedure BeginRecreateDeffer;
    procedure EndRecreateDeffer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure RegisterEditor(AClass: TPersistentClass;
                             AEditorClass: TLMDObjectEditorClass);
    procedure UnregisterEditor(AClass: TPersistentClass);
    function  FindEditorClass(AInstance: TPersistent): TLMDObjectEditorClass;

    procedure UpdateEditors;
    function  FindEditor(AInstance: TPersistent): TLMDObjectEditor;

    procedure DblClicked(AInstance: TPersistent);
    procedure AdjustMenu(AInstance: TPersistent; AMenu: TPopupMenu);
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property Selection: TLMDDesignObjects read FSelection write SetSelection;
    property EventHandlerAsDefaultAction: Boolean read FEventHandlerAsDefaultAction write FEventHandlerAsDefaultAction default False;
    property OnGetEditorClass: TLMDComponentEdrMgrOnGetEditorClass read FOnGetEditorClass write FOnGetEditorClass;
    property OnAdjustMenu: TLMDComponentEdrMgrOnAdjustMenu read FOnAdjustMenu write FOnAdjustMenu;
    property OnDefaultAction: TLMDComponentEdrMgrOnDefaultAction read FOnDefaultAction write FOnDefaultAction;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

procedure LMDRemoveEditorMenuItems(AMenu: TPopupMenu);
function  LMDCreateVerbMenuItem(AOwner: TComponent; AEditor: TLMDObjectEditor;
                                AVerbIndex: Integer): TMenuItem;
function  LMDCreateSimpleMenuItem(AOwner: TComponent;
                                  const ACaption: TLMDString): TMenuItem;

implementation

uses
  LMDDsgDesigner, LMDIdeObjEditors;

{------------------------------------------------------------------------------}

type
  TPersistentAccess = class(TPersistent);

  TEditorItem = class
  public
    Class_:      TPersistentClass;
    EditorClass: TLMDObjectEditorClass;
  end;

  TSelnNotifier = class(ILMDDsgObjsNotifier)
  private
    FOwner: TLMDObjectEditorManager;
  public
    constructor Create(AOwner: TLMDObjectEditorManager);
    procedure   Changed(ASender: TLMDDesignObjects); override;
  end;

  TEditorMenuItem = class(TMenuItem)
  public
    Editor:    TLMDObjectEditor;
    VerbIndex: Integer;

    procedure Click; override;
  end;

{------------------------------------------------------------------------------}

procedure LMDRemoveEditorMenuItems(AMenu: TPopupMenu);

  procedure _Iterate(AParent: TMenuItem);
  var
    i:    Integer;
    item: TMenuItem;
  begin
    for i := AParent.Count - 1 downto 0 do
    begin
      item := AParent[i];
      
      if item is TEditorMenuItem then
        item.Free
      else
        _Iterate(item);
    end;
  end;

begin
  _Iterate(AMenu.Items);
end;
      
{------------------------------------------------------------------------------}

function LMDCreateVerbMenuItem(AOwner: TComponent;
  AEditor: TLMDObjectEditor; AVerbIndex: Integer): TMenuItem;
var
  item: TEditorMenuItem;
begin
  item := TEditorMenuItem.Create(AOwner);
  try
    item.Caption   := AEditor.GetVerb(AVerbIndex);
    item.Editor    := AEditor;
    item.VerbIndex := AVerbIndex;
  except
    item.Free;
    raise;
  end;

  Result := item;
end;
               
{------------------------------------------------------------------------------}

function LMDCreateSimpleMenuItem(AOwner: TComponent;
  const ACaption: TLMDString): TMenuItem;
var
  item: TEditorMenuItem;
begin
  item := TEditorMenuItem.Create(AOwner);
  try
    item.Caption   := ACaption;
    item.Editor    := nil;
  except
    item.Free;
    raise;
  end;

  Result := item;
end;
               
{******************************* TSelnNotifier ********************************}
{------------------------------------------------------------------------------}

procedure TSelnNotifier.Changed(ASender: TLMDDesignObjects);
begin
  FOwner.RecreateEditors;
end;
                           
{------------------------------------------------------------------------------}

constructor TSelnNotifier.Create(AOwner: TLMDObjectEditorManager);
begin
  inherited Create;
  FOwner := AOwner;
end;

{****************************** TEditorMenuItem *******************************}
{------------------------------------------------------------------------------}

procedure TEditorMenuItem.Click;
begin
  if (Editor <> nil) and Enabled then
  begin
    Editor.FOwner.BeginRecreateDeffer;
    try
      Editor.ExecuteVerb(VerbIndex);
    finally
      Editor.FOwner.EndRecreateDeffer;
    end;
  end;
end;

{****************************** TLMDObjectEditor ******************************}
{------------------------------------------------------------------------------}

function TLMDObjectEditor.GetServiceProvider: TLMDServiceProvider;
begin
  Result := FOwner.FServiceProvider;
end;
                    
{------------------------------------------------------------------------------}

constructor TLMDObjectEditor.Create(AOwner: TLMDObjectEditorManager;
  AInstance: TPersistent);
begin
  inherited Create;

  FOwner    := AOwner;
  FInstance := AInstance;
  FOwner.InsertEditor(Self);
end;
                    
{------------------------------------------------------------------------------}

destructor TLMDObjectEditor.Destroy;
begin
  FOwner.RemoveEditor(Self);
  inherited;
end;
                    
{------------------------------------------------------------------------------}

procedure TLMDObjectEditor.Edit;
begin
  if GetVerbCount > 0 then
    ExecuteVerb(0);
end;
                   
{------------------------------------------------------------------------------}

function TLMDObjectEditor.GetVerbCount: Integer;
begin
  Result := 0;
end;
                   
{------------------------------------------------------------------------------}

function TLMDObjectEditor.GetVerb(AIndex: Integer): TLMDString;
begin
  // Do nothing.
end;
                  
{------------------------------------------------------------------------------}

procedure TLMDObjectEditor.ExecuteVerb(AIndex: Integer);
begin
  // Do nothing.
end;

{************************** TLMDObjectEditorManager ***************************}
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.ClearItems;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
    TEditorItem(FItems[i]).Free;
  FItems.Clear;
end;
                       
{------------------------------------------------------------------------------}

function TLMDObjectEditorManager.FindItem(
  AClass: TPersistentClass): TObject;
var
  i: Integer;
begin
  for i := 0 to FItems.Count - 1 do
  begin
    Result := FItems[i];
    if TEditorItem(Result).Class_ = AClass then
      Exit;
  end;

  Result := nil;
end;
                    
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.InsertEditor(AEditor: TLMDObjectEditor);
begin
  FEditors.Add(AEditor);
end;
                 
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.RemoveEditor(AEditor: TLMDObjectEditor);
begin
  FEditors.Remove(AEditor);
end;
                
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.ClearEditors;
begin
  while FEditors.Count > 0 do
    TLMDObjectEditor(FEditors[0]).Free;
end;
                 
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.SetServiceProvider(
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

procedure TLMDObjectEditorManager.SetSelection(
  const Value: TLMDDesignObjects);
begin
  if FSelection <> Value then
  begin
    if FSelection <> nil then
    begin
      FSelection.RemoveFreeNotification(Self);
      FSelection.RemoveNotifier(TSelnNotifier(FSelnNotifier));
    end;
    FSelection := Value;
    if FSelection <> nil then
    begin
      FSelection.FreeNotification(Self);
      FSelection.AddNotifier(TSelnNotifier(FSelnNotifier));
    end;

    RecreateEditors;
  end;
end;
                  
{------------------------------------------------------------------------------}

function TLMDObjectEditorManager.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;
                 
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FServiceProvider then
      ServiceProvider := nil;
    if AComponent = FSelection then
      Selection := nil;
  end;
end;
                  
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.DoDefaultAction(
  AInstance: TPersistent; var AHandled: Boolean);
begin
  if Assigned(FOnDefaultAction) then
    FOnDefaultAction(Self, AInstance, AHandled);
end;
                 
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.RecreateEditors;
var
  i:     Integer;
  inst:  TPersistent;
  edcls: TLMDObjectEditorClass;
begin
  if FRecreateDefferCount > 0 then
  begin
    FNeedRecreate := True;
    Exit;
  end;

  ClearEditors;
  if FSelection = nil then
    Exit;

  for i := 0 to FSelection.Count - 1 do
  begin
    inst  := FSelection[i];
    edcls := FindEditorClass(inst);

    if edcls <> nil then
      edcls.Create(Self, inst);
  end;
end;
                     
{------------------------------------------------------------------------------}

constructor TLMDObjectEditorManager.Create(AOwner: TComponent);
begin
  inherited;
  FItems         := TList.Create;
  FEditors       := TList.Create;
  FSelnNotifier  := TSelnNotifier.Create(Self);

  RegisterStandardEditors;
end;

{------------------------------------------------------------------------------}

destructor TLMDObjectEditorManager.Destroy;
begin
  ServiceProvider := nil;
  Selection       := nil;

  ClearItems;
  ClearEditors;
  FItems.Free;
  FEditors.Free;
  FSelnNotifier.Free;
  inherited;
end;
                 
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.RegisterEditor(AClass: TPersistentClass;
  AEditorClass: TLMDObjectEditorClass);
var
  item: TEditorItem;
begin
  item := TEditorItem(FindItem(AClass));
  if item = nil then
  begin
    item := TEditorItem.Create;
    try
      item.Class_      := AClass;
      item.EditorClass := AEditorClass;
      FItems.Add(item);
    except
      item.Free;
      raise;
    end;
  end;

  item.EditorClass := AEditorClass;
end;
                    
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.UnregisterEditor(
  AClass: TPersistentClass);
var
  item: TEditorItem;
begin
  item := TEditorItem(FindItem(AClass));
  if item <> nil then
  begin
    FItems.Remove(item);
    item.Free;
  end;
end;
                 
{------------------------------------------------------------------------------}

function TLMDObjectEditorManager.FindEditorClass(
  AInstance: TPersistent): TLMDObjectEditorClass;
var
  i:         Integer;
  cur, best: TEditorItem;
begin
  Result := nil;
  best   := nil;

  if Assigned(FOnGetEditorClass) then
  begin
    FOnGetEditorClass(Self, AInstance, Result);
    if Result <> nil then
      Exit;
  end;

  for i := 0 to FItems.Count - 1 do
  begin
    cur := TEditorItem(FItems[i]);

    if cur.Class_ = AInstance.ClassType then
    begin
      best := cur;
      Break; // No better editor possible.
    end;

    if AInstance.InheritsFrom(cur.Class_) then
    begin
      if best <> nil then
      begin
        if cur.Class_.InheritsFrom(best.Class_) then
          best := cur;
      end
      else
        best := cur;
    end;
  end;

  if best <> nil then
    Result := best.EditorClass
  else
    Result := nil;
end;
                  
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.UpdateEditors;
begin
  RecreateEditors;
end;
                 
{------------------------------------------------------------------------------}

function TLMDObjectEditorManager.FindEditor(
  AInstance: TPersistent): TLMDObjectEditor;
var
  i: Integer;
begin
  for i := 0 to FEditors.Count - 1 do
  begin
    Result := TLMDObjectEditor(FEditors[i]);
    if Result.Instance = AInstance then
      Exit;
  end;

  Result := nil;
end;
                      
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.DblClicked(AInstance: TPersistent);
var
  edtr:    TLMDObjectEditor;
  handled: Boolean;
begin
  BeginRecreateDeffer;
  try
    edtr := FindEditor(AInstance);
    if edtr <> nil then
      edtr.Edit
    else
    begin
      handled := False;
      DoDefaultAction(AInstance, handled);

      if not handled and FEventHandlerAsDefaultAction then
      begin
        LMDShowDefaultEventHandler(AInstance, False);
        DoChange(AInstance);
      end;
    end;
  finally
    EndRecreateDeffer;
  end;
end;
                  
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.AdjustMenu(AInstance: TPersistent;
  AMenu: TPopupMenu);
var
  i:       Integer;
  cnt:     Integer;
  handled: Boolean;
  needsep: Boolean;
  edtr:    TLMDObjectEditor;
begin
  LMDRemoveEditorMenuItems(AMenu);

  edtr := FindEditor(AInstance);
  if edtr <> nil then
  begin
    handled := False;
    if Assigned(FOnAdjustMenu) then
      FOnAdjustMenu(Self, edtr, AMenu, handled);

    if not handled then
    begin
      cnt     := edtr.GetVerbCount;
      needsep := (AMenu.Items.Count > 0);

      for i := 0 to cnt - 1 do
        AMenu.Items.Insert(i, LMDCreateVerbMenuItem(AMenu, edtr, i));

      if needsep then
        AMenu.Items.Insert(cnt, LMDCreateSimpleMenuItem(AMenu, '-'));
    end;
  end;
end;
                 
{------------------------------------------------------------------------------}

procedure TLMDObjectEditorManager.DoChange(AInstance: TPersistent);
begin
  if AInstance <> nil then
    LMDComponentChanged(Self, LMDGetPersistentComponent(AInstance));

  if Assigned(OnChange) then
    OnChange(Self);
end;

function TLMDObjectEditor.CreateEditorWndCbs(
  AEditingObject: TPersistent;
  out AResult: TLMDEditorWindowCallbacks): Boolean;
var
  wndmgr: TLMDEditorWindowManager;
begin
  wndmgr := FOwner.DetectEditorWindowManager(AEditingObject);

  if wndmgr <> nil then
  begin
    AResult := wndmgr.CreateCallbacks;
    Result := True;
  end
  else
  begin
    AResult := nil;
    Result := False;
  end;
end;

function TLMDObjectEditorManager.DetectEditorWindowManager(
  AEditingObject: TPersistent): TLMDEditorWindowManager;
var
  module: TLMDModule;
begin
  Result := nil;
  module := LMDFindObjectModule(AEditingObject);
  if module <> nil then
    Result := LMDFindDesignerEditorWindows(module.Root);
end;

procedure TLMDObjectEditor.Changed;
begin
  FOwner.DoChange(FInstance);
end;

procedure TLMDObjectEditor.GetObjects(AResult: TList);
begin
  if FOwner.FSelection <> nil then
    FOwner.FSelection.GetItems(AResult);
end;

procedure TLMDObjectEditor.SetObjects(AObjects: TList);
begin
  if FOwner.FSelection <> nil then
    FOwner.FSelection.SetItems(AObjects);
end;

procedure TLMDObjectEditor.SetObjects(AObjects: array of TPersistent);
var
  i:   Integer;
  list: TList;
begin
  list := TList.Create;
  try
    for i := 0 to High(AObjects) do
      list.Add(AObjects[i]);
    SetObjects(list);
  finally
    list.Free;
  end;
end;

procedure TLMDObjectEditorManager.RegisterStandardEditors;
begin
  RegisterEditor(TCollection, TLMDCollectionObjEditor);
  RegisterEditor(TMenu, TLMDMenuObjEditor);
  RegisterEditor(TActionList, TLMDActionListObjEditor);
  RegisterEditor(TPageControl, TLMDPageControlObjEditor);
  RegisterEditor(TTabSheet, TLMDPageControlObjEditor);
end;

procedure TLMDObjectEditorManager.BeginRecreateDeffer;
begin
  Inc(FRecreateDefferCount);
end;

procedure TLMDObjectEditorManager.EndRecreateDeffer;
begin
  Dec(FRecreateDefferCount);
  if (FRecreateDefferCount = 0) and FNeedRecreate then
    RecreateEditors;
end;

end.
