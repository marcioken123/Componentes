unit LMDIdeManager;
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

LMDIdeManager unit (YB)
------------------------
TLMDIdeManager unit.

Changes
-------

###############################################################################}

interface     

uses
  Windows, Classes, Controls, SysUtils, Menus, intfLMDBase, LMDTypes,
  LMDSvcPvdr, LMDDsgCst, LMDDsgClass, LMDDsgObjects, LMDDsgModule,
  LMDDsgDesigner, LMDDsgComboBox, LMDDsgPropInsp, LMDIdeCompPltte,
  LMDIdeCompBar, LMDIdeObjEdrMgr, LMDIdeCompTree, LMDIdeAlignPltte,
  LMDIdeActns, LMDInsEditorWnds, LMDInsEditorUtils, LMDSctScripter,
  LMDIdeDebugCtrls;

type
  ELMDIdeManager = class(Exception);

  { ***************************** TLMDIdeManager ***************************** }

  TLMDIdeManagerServiceOptions = set of (imsoAutoConnectObjectComboBox,
                                         imsoAutoConnectPropInsp,
                                         imsoAutoConnectObjectEditorMgr,
                                         imsoAutoConnectCompTree,
                                         imsoAutoConnectAlignPalette,
                                         imsoAutoConnectDebuggerSources,
                                         imsoProvideCompInsertionService,
                                         imsoProvideCompImageService,
                                         imsoProvideObjEditService,
                                         amsoProvideCurDesignerService);

  TLMDIdeManager = class(TComponent, ILMDComponent)
  private
    FAbout:                   TLMDAboutVar;
    FServiceProvider:         TLMDServiceProvider;
    FServiceOptions:          TLMDIdeManagerServiceOptions;
    FCurrentDesigner:         TLMDDesigner;
    FCurrentDebugger:         TLMDScriptDebugger;
    FServicesNotifier:        ILMDServicesNotifier;
    FDesignerNotifier:        ILMDDesignerNotifier;
    FDebuggerNotifier:        ILMDScriptDebuggerNotifier;
    FCompInsService:          ILMDCompInsService;
    FCompImageService:        ILMDCompImageService;
    FObjEditService:          ILMDObjEditService;
    FCurDesignerService:      ILMDCurDesignerService;
    FOnCurrentDesignerChange: TNotifyEvent;
    FOnCurrentDebuggerChange: TNotifyEvent;
    FAutoCurrentDesigner:     Boolean;
    FAutoCurrentDebugger:     Boolean;

    procedure RegisterAll(ASvcPvdr: TLMDServiceProvider);
    procedure UnregisterAll(ASvcPvdr: TLMDServiceProvider);
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
    procedure SetServiceOptions(const Value: TLMDIdeManagerServiceOptions);
    procedure SetCurrentDesigner(const Value: TLMDDesigner);
    procedure SetCurrentDebugger(const Value: TLMDScriptDebugger);
    procedure DesignersChanged;
    procedure DebuggersChanged;

    function  FindComboBox: TLMDObjectComboBox;
    function  FindPropInsp: TLMDPropertyInspector;
    function  FindObjEditorMgr: TLMDObjectEditorManager;
    function  FindCompTree: TLMDComponentTree;
    function  FindCompPalette: TLMDComponentPalette;
    function  FindCompBar: TLMDComponentBar;
    function  FindAlignPalette: TLMDAlignPalette;
    function  GetDebuggerSources: TList;

    procedure ConnectComboBox;
    procedure ConnectPropInsp;
    procedure ConnectCompEditors;
    procedure ConnectCompTree;
    procedure ConnectAlignPalette;
    procedure ConnectDebuggerSources;
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    procedure DoCurrentDesignerChange; virtual;
    procedure DoCurrentDebuggerChange; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property CurrentDesigner: TLMDDesigner read FCurrentDesigner;
    property CurrentDebugger: TLMDScriptDebugger read FCurrentDebugger;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
    property ServiceOptions: TLMDIdeManagerServiceOptions read FServiceOptions write SetServiceOptions
               default [imsoAutoConnectObjectComboBox, imsoAutoConnectPropInsp, imsoAutoConnectObjectEditorMgr,
                        imsoAutoConnectCompTree, imsoAutoConnectAlignPalette, imsoAutoConnectDebuggerSources,
                        imsoProvideCompInsertionService, imsoProvideCompImageService, imsoProvideObjEditService,
                        amsoProvideCurDesignerService];
    property ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property AutoCurrentDesigner: Boolean read FAutoCurrentDesigner write FAutoCurrentDesigner default True;
    property AutoCurrentDebugger: Boolean read FAutoCurrentDebugger write FAutoCurrentDebugger default True;
    property OnCurrentDesignerChange: TNotifyEvent read FOnCurrentDesignerChange write FOnCurrentDesignerChange;
    property OnCurrentDebuggerChange: TNotifyEvent read FOnCurrentDebuggerChange write FOnCurrentDebuggerChange;
  end;

implementation

uses
  Dialogs;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

type
  {**************************** TServicesNotifier *****************************}

  TServicesNotifier = class(ILMDServicesNotifier)
  private
    FMgr: TLMDIdeManager;
  public
    constructor Create(AIdeManager: TLMDIdeManager);

    procedure AfterMemberAddition(AMember: TObject); override;
    procedure BeforeMemberRemoving(AMember: TObject); override;
  end;

  {**************************** TDesignerNotifier *****************************}

  TDesignerNotifier = class(ILMDDesignerNotifier)
  private
    FMgr: TLMDIdeManager;
  public
    constructor Create(AIdeManager: TLMDIdeManager);

    procedure Focus(ASender: TLMDCustomDesigner); override;
    procedure ActiveChanged(ASender: TLMDCustomDesigner); override;
  end;

  TScriptDebuggerNotifier = class(ILMDScriptDebuggerNotifier)
  private
    FMgr: TLMDIdeManager;
  public
    constructor Create(AIdeManager: TLMDIdeManager);

    procedure Breaked(ADebugger: TLMDScriptDebugger); override;
    procedure Resumed(ADebugger: TLMDScriptDebugger); override;
    procedure DebugNameChanged(ADebugger: TLMDScriptDebugger;
                               AScript: TLMDScriptControl); override;
    procedure LogMessage(ADebugger: TLMDScriptDebugger; const AMsg: TLMDString;
                         AKind: TLMDDebugMsgKind); override;
    procedure BreakpointsChanged(ADebugger: TLMDScriptDebugger); override;
  end;

  {***************************** TCompInsService ******************************}

  TCompInsService = class(ILMDCompInsService)
  private
    FMgr: TLMDIdeManager;
  public
    constructor Create(AIdeManager: TLMDIdeManager);

    procedure Inserting(ASender: TObject;
                        var AComponentClass: TComponentClass); override;
    procedure Inserted(ADesigner: TLMDCustomDesigner); override;
  end;

  {**************************** TCompImageService *****************************}

  TCompImageService = class(ILMDCompImageService)
  private
    FMgr: TLMDIdeManager;
  public
    constructor Create(AIdeManager: TLMDIdeManager);

    procedure GetCompImageParams(ASender: TObject;
                                 AComponentClass: TComponentClass;
                                 var AImageList: TImageList;
                                 var AImageIndex: Integer); override;
  end;

  {****************************** TObjEditService *****************************}

  TObjEditService = class(ILMDObjEditService)
  private
    FMgr: TLMDIdeManager;
  public
    constructor Create(AIdeManager: TLMDIdeManager);

    procedure DblClicked(ASender: TObject;
                         AInstance: TPersistent); override;
    procedure AdjustMenu(ASender: TObject;
                         AInstance: TPersistent;
                         AMenu: TPopupMenu); override;
  end;
                  
  {*************************** TCurDesignerService ****************************}

  TCurDesignerService = class(ILMDCurDesignerService)
  private
    FMgr: TLMDIdeManager;
  public
    constructor Create(AIdeManager: TLMDIdeManager);

    function GetCurrentDesigner: TLMDDesigner; override;
  end;

{******************************* TServicesNotifier ****************************}
{------------------------------------------------------------------------------}
procedure TServicesNotifier.AfterMemberAddition(AMember: TObject);
begin
  if AMember is TLMDObjectComboBox then
    FMgr.ConnectComboBox;
  if AMember is TLMDPropertyInspector then
    FMgr.ConnectPropInsp;
  if AMember is TLMDObjectEditorManager then
    FMgr.ConnectCompEditors;
  if AMember is TLMDComponentTree then
    FMgr.ConnectCompTree;
  if AMember is TLMDAlignPalette then
    FMgr.ConnectAlignPalette;
  if AMember is TLMDDebuggerSource then
    FMgr.ConnectDebuggerSources;
    
  if AMember is TLMDDesigner then
    FMgr.DesignersChanged;
  if AMember is TLMDScriptDebugger then
    FMgr.DebuggersChanged;
end;

{------------------------------------------------------------------------------}
procedure TServicesNotifier.BeforeMemberRemoving(AMember: TObject);
begin
  if AMember is TLMDDesigner then
    FMgr.DesignersChanged;
  if AMember is TLMDScriptDebugger then
    FMgr.DebuggersChanged;
end;

{------------------------------------------------------------------------------}
constructor TServicesNotifier.Create(
  AIdeManager: TLMDIdeManager);
begin
  inherited Create;
  FMgr := AIdeManager;
end;

{***************************** TDesignerNotifier ******************************}
{ -------------------------------- public ------------------------------------ }
constructor TDesignerNotifier.Create(
  AIdeManager: TLMDIdeManager);
begin
  inherited Create;
  FMgr := AIdeManager;
end;

{ ---------------------------------------------------------------------------- }
procedure TDesignerNotifier.Focus(ASender: TLMDCustomDesigner);
begin
  if FMgr.FAutoCurrentDesigner then
    FMgr.SetCurrentDesigner(ASender as TLMDDesigner);
end;

{ ---------------------------------------------------------------------------- }
procedure TDesignerNotifier.ActiveChanged(ASender: TLMDCustomDesigner);
begin
  if (FMgr.FCurrentDesigner = ASender) and
     not TLMDDesigner(ASender).Active then
    FMgr.SetCurrentDesigner(nil);
end;

{****************************** TCompInsService *******************************}
{ ---------------------------------------------------------------------------- }
constructor TCompInsService.Create(AIdeManager: TLMDIdeManager);
begin
  inherited Create;
  FMgr := AIdeManager;
end;

{ ---------------------------------------------------------------------------- }
procedure TCompInsService.Inserted(ADesigner: TLMDCustomDesigner);
var
  LPalette:  TLMDComponentPalette;
  LBar:      TLMDComponentBar;
begin
  LPalette := FMgr.FindCompPalette;
  if LPalette <> nil then
    LPalette.SelectedItem := nil;

  LBar := FMgr.FindCompBar;
  if LBar <> nil then
    LBar.SelectedItem := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TCompInsService.Inserting(ASender: TObject;
  var AComponentClass: TComponentClass);
var
  LPalette:  TLMDComponentPalette;
  LBar:      TLMDComponentBar;
begin
  LPalette := FMgr.FindCompPalette;
  if LPalette <> nil then
  begin
    AComponentClass := LPalette.SelectedClass;
    Exit;
  end;

  LBar := FMgr.FindCompBar;
  if LBar <> nil then
    AComponentClass := LBar.SelectedClass;
end;

{**************************** TCompImageService *******************************}
{ ---------------------------------------------------------------------------- }
constructor TCompImageService.Create(AIdeManager: TLMDIdeManager);
begin
  inherited Create;
  FMgr := AIdeManager;
end;

{ ---------------------------------------------------------------------------- }
procedure TCompImageService.GetCompImageParams(
  ASender: TObject; AComponentClass: TComponentClass;
  var AImageList: TImageList; var AImageIndex: Integer);
var
  LPalette:  TLMDComponentPalette;
  LPItem:    TLMDCompPalettePageItem;
  LBar:      TLMDComponentBar;
  LBItem:    TLMDCompBarItem;
begin
  LPalette := FMgr.FindCompPalette;
  if LPalette <> nil then
  begin
    LPItem := LPalette.FindItem(AComponentClass);

    if LPItem <> nil then
    begin
      AImageList  := LPalette.Images;
      AImageIndex := LPItem.ImageIndex;
      Exit;
    end;
  end;

  LBar := FMgr.FindCompBar;
  if LBar <> nil then
  begin
    LBItem := LBar.FindItem(AComponentClass);

    if LBItem <> nil then
    begin
      AImageList  := LBar.Images;
      AImageIndex := LBItem.ImageIndex;
    end;
  end;
end;

{****************************** TObjEditService *******************************}
{ ---------------------------------------------------------------------------- }
constructor TObjEditService.Create(AIdeManager: TLMDIdeManager);
begin
  inherited Create;
  FMgr := AIdeManager;
end;

{ ---------------------------------------------------------------------------- }
procedure TObjEditService.AdjustMenu(ASender: TObject;
  AInstance: TPersistent; AMenu: TPopupMenu);
var
  LObjEditors: TLMDObjectEditorManager;
begin
  LObjEditors := FMgr.FindObjEditorMgr;
  if LObjEditors <> nil then
    LObjEditors.AdjustMenu(AInstance, AMenu);
end;

{ ---------------------------------------------------------------------------- }
procedure TObjEditService.DblClicked(ASender: TObject;
  AInstance: TPersistent);
var
  LObjEditors: TLMDObjectEditorManager;
begin
  LObjEditors := FMgr.FindObjEditorMgr;
  if LObjEditors <> nil then
    LObjEditors.DblClicked(AInstance);
end;

{**************************** TCurDesignerService *****************************}
{ ---------------------------------------------------------------------------- }
constructor TCurDesignerService.Create(AIdeManager: TLMDIdeManager);
begin
  inherited Create;
  FMgr := AIdeManager;
end;

{ ---------------------------------------------------------------------------- }
function TCurDesignerService.GetCurrentDesigner: TLMDDesigner;
begin
  Result := FMgr.FCurrentDesigner;
end;

{ ************************** class TLMDIdeManager **************************** }
{ -------------------------------- private ----------------------------------- }

procedure TLMDIdeManager.RegisterAll(ASvcPvdr: TLMDServiceProvider);
begin
  ASvcPvdr.Notifiers.RegisterNotifier(FServicesNotifier);
  ASvcPvdr.Notifiers.RegisterNotifier(FDesignerNotifier);
  ASvcPvdr.Notifiers.RegisterNotifier(FDebuggerNotifier);

  if imsoProvideCompInsertionService in FServiceOptions then
    ASvcPvdr.Services.RegisterService(FCompInsService);

  if imsoProvideCompImageService in FServiceOptions then
    ASvcPvdr.Services.RegisterService(FCompImageService);

  if imsoProvideObjEditService in FServiceOptions then
    ASvcPvdr.Services.RegisterService(FObjEditService);

  if amsoProvideCurDesignerService in FServiceOptions then
    ASvcPvdr.Services.RegisterService(FCurDesignerService);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdeManager.UnregisterAll(ASvcPvdr: TLMDServiceProvider);
begin
  ASvcPvdr.Notifiers.UnregisterNotifier(FServicesNotifier);
  ASvcPvdr.Notifiers.UnregisterNotifier(FDesignerNotifier);
  ASvcPvdr.Notifiers.UnregisterNotifier(FDebuggerNotifier);
  ASvcPvdr.Services.UnregisterService(FCompInsService);
  ASvcPvdr.Services.UnregisterService(FCompImageService);
  ASvcPvdr.Services.UnregisterService(FObjEditService);
  ASvcPvdr.Services.UnregisterService(FCurDesignerService);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdeManager.SetServiceProvider(
  const Value: TLMDServiceProvider);
begin
  if FServiceProvider <> Value then
  begin
    if FServiceProvider <> nil then
    begin
      FServiceProvider.RemoveFreeNotification(Self);
      UnregisterAll(FServiceProvider);
    end;

    FServiceProvider := Value;

    if FServiceProvider <> nil then
    begin
      FServiceProvider.FreeNotification(Self);
      try
        RegisterAll(FServiceProvider);
      except
        FServiceProvider.RemoveFreeNotification(Self);
        UnregisterAll(FServiceProvider);
        FServiceProvider := nil;
        raise;
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdeManager.SetCurrentDebugger(const Value: TLMDScriptDebugger);
begin
  if FCurrentDebugger <> Value then
  begin
    if (Value <> nil) and (Value.BreakKind = bkNone) then
      raise ELMDIdeManager.Create(SLMDDsgMgrNonBreakedCurDebugger);

    FCurrentDebugger := Value;
    ConnectDebuggerSources;

    DoCurrentDebuggerChange;
  end;
end;

procedure TLMDIdeManager.SetCurrentDesigner(
  const Value: TLMDDesigner);
begin
  if FCurrentDesigner <> Value then
  begin
    if (Value <> nil) and not Value.Active then
      raise ELMDIdeManager.Create(SLMDDsgMgrNonActiveCurDesigner);

    FCurrentDesigner := Value;
    
    ConnectComboBox;
    ConnectPropInsp;
    ConnectCompEditors;
    ConnectCompTree;
    ConnectAlignPalette;

    DoCurrentDesignerChange;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdeManager.DebuggersChanged;
var
  LIsMember: Boolean;
begin
  if FCurrentDesigner <> nil then
  begin
    LIsMember := (FServiceProvider <> nil) and
                 FServiceProvider.Members.IsMember(FCurrentDebugger);

    if not LIsMember then
      SetCurrentDebugger(nil);
  end;
end;

procedure TLMDIdeManager.DesignersChanged;
var
  LIsMember: Boolean;
begin
  if FCurrentDesigner <> nil then
  begin
    LIsMember := (FServiceProvider <> nil) and
                 FServiceProvider.Members.IsMember(FCurrentDesigner);

    if not LIsMember then
      SetCurrentDesigner(nil);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDIdeManager.FindComboBox: TLMDObjectComboBox;
begin
  Result := nil;
  if FServiceProvider <> nil then
    Result := TLMDObjectComboBox(FServiceProvider.Members.
                                 FindFirst(TLMDObjectComboBox));
end;

{ ---------------------------------------------------------------------------- }
function TLMDIdeManager.FindObjEditorMgr: TLMDObjectEditorManager;
begin
  Result := nil;
  if FServiceProvider <> nil then
    Result := TLMDObjectEditorManager(FServiceProvider.Members.
                                      FindFirst(TLMDObjectEditorManager));
end;

{ ---------------------------------------------------------------------------- }
function TLMDIdeManager.FindCompTree: TLMDComponentTree;
begin
  Result := nil;
  if FServiceProvider <> nil then
    Result := TLMDComponentTree(FServiceProvider.Members.
                                FindFirst(TLMDComponentTree));
end;

{ ---------------------------------------------------------------------------- }
function TLMDIdeManager.FindPropInsp: TLMDPropertyInspector;
begin
  Result := nil;
  if FServiceProvider <> nil then
    Result := TLMDPropertyInspector(FServiceProvider.Members.
                                    FindFirst(TLMDPropertyInspector));
end;

function TLMDIdeManager.GetDebuggerSources: TList;
begin
  if FServiceProvider <> nil then
    Result := FServiceProvider.Members.GetList(TLMDDebuggerSource)
  else
    Result := TList.Create; // Return empty list.
end;

{ ---------------------------------------------------------------------------- }
function TLMDIdeManager.FindCompPalette: TLMDComponentPalette;
begin
  Result := nil;
  if FServiceProvider <> nil then
    Result := TLMDComponentPalette(FServiceProvider.Members.
                                   FindFirst(TLMDComponentPalette));
end;

{ ---------------------------------------------------------------------------- }
function TLMDIdeManager.FindCompBar: TLMDComponentBar;
begin
  Result := nil;
  if FServiceProvider <> nil then
    Result := TLMDComponentBar(FServiceProvider.Members.
                               FindFirst(TLMDComponentBar));
end;

{ ---------------------------------------------------------------------------- }
function TLMDIdeManager.FindAlignPalette: TLMDAlignPalette;
begin
  Result := nil;
  if FServiceProvider <> nil then
    Result := TLMDAlignPalette(FServiceProvider.Members.
                               FindFirst(TLMDAlignPalette));
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdeManager.ConnectComboBox;
var
  LSeln,
  LListObjs: TLMDDesignObjects;
  LComboBox: TLMDObjectComboBox;
begin
  if imsoAutoConnectObjectComboBox in FServiceOptions then
  begin
    LSeln     := nil;
    LListObjs := nil;
    if FCurrentDesigner <> nil then
    begin
      LSeln     := FCurrentDesigner.Selection;
      LListObjs := FCurrentDesigner.AllComponents;
    end;

    LComboBox := FindComboBox;

    if LComboBox <> nil then
    begin
      LComboBox.Selection   := LSeln;
      LComboBox.ListObjects := LListObjs;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdeManager.ConnectPropInsp;
var
  LSeln:     TLMDDesignObjects;
  LPropInsp: TLMDPropertyInspector;
begin
  if imsoAutoConnectPropInsp in FServiceOptions then
  begin
    LSeln := nil;
    if FCurrentDesigner <> nil then
      LSeln := FCurrentDesigner.Selection;

    LPropInsp := FindPropInsp;

    if LPropInsp <> nil then
      LPropInsp.Selection := LSeln;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdeManager.ConnectCompEditors;
var
  LSeln:       TLMDDesignObjects;
  LObjEditors: TLMDObjectEditorManager;
begin
  if imsoAutoConnectObjectEditorMgr in FServiceOptions then
  begin
    LSeln := nil;
    if FCurrentDesigner <> nil then
      LSeln := FCurrentDesigner.Selection;

    LObjEditors := FindObjEditorMgr;
    if LObjEditors <> nil then
      LObjEditors.Selection := LSeln;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdeManager.ConnectCompTree;
var
  LSeln:     TLMDDesignObjects;
  LRoot:     TWinControl;
  LCompTree: TLMDComponentTree;
begin
  if imsoAutoConnectCompTree in FServiceOptions then
  begin
    LSeln := nil;
    LRoot := nil;
    if FCurrentDesigner <> nil then
    begin
      LSeln := FCurrentDesigner.Selection;
      if FCurrentDesigner.Module <> nil then
        LRoot := FCurrentDesigner.Module.Root
      else
        LRoot := nil;
    end;

    LCompTree := FindCompTree;
    if LCompTree <> nil then
    begin
      LCompTree.Root      := LRoot;
      LCompTree.Selection := LSeln;
    end;
  end;
end;

procedure TLMDIdeManager.ConnectDebuggerSources;
var
  srcs: TList;
  i: Integer;
begin
  if imsoAutoConnectDebuggerSources in FServiceOptions then
  begin
    srcs := GetDebuggerSources;
    try
      for i := 0 to srcs.Count - 1 do
        TLMDDebuggerSource(srcs[i]).Debugger := FCurrentDebugger;
    finally
      srcs.Free;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdeManager.ConnectAlignPalette;
var
  LPalette: TLMDAlignPalette;
begin
  if imsoAutoConnectAlignPalette in FServiceOptions then
  begin
    LPalette := FindAlignPalette;
    if LPalette <> nil then
      LPalette.Designer := FCurrentDesigner;
  end;
end;

{ ------------------------------- protected ---------------------------------- }
function TLMDIdeManager.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_IDE;
end;

{ ------------------------------- protected ---------------------------------- }
procedure TLMDIdeManager.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  
  if (Operation = opRemove) and (AComponent = FServiceProvider) then
    ServiceProvider := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDIdeManager.DoCurrentDebuggerChange;
begin
  if Assigned(FOnCurrentDebuggerChange) then
    FOnCurrentDebuggerChange(Self);
end;

procedure TLMDIdeManager.DoCurrentDesignerChange;
begin
  if Assigned(FOnCurrentDesignerChange) then
    FOnCurrentDesignerChange(Self);
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDIdeManager.Create(AOwner: TComponent);
begin
  inherited;
  FServiceOptions        := [imsoAutoConnectObjectComboBox,
                             imsoAutoConnectPropInsp,
                             imsoAutoConnectObjectEditorMgr,
                             imsoAutoConnectCompTree,
                             imsoAutoConnectAlignPalette,
                             imsoAutoConnectDebuggerSources,
                             imsoProvideCompInsertionService,
                             imsoProvideCompImageService,
                             imsoProvideObjEditService,
                             amsoProvideCurDesignerService];
  FServicesNotifier      := TServicesNotifier.Create(Self);
  FDesignerNotifier      := TDesignerNotifier.Create(Self);
  FDebuggerNotifier      := TScriptDebuggerNotifier.Create(Self);
  FCompInsService        := TCompInsService.Create(Self);
  FCompImageService      := TCompImageService.Create(Self);
  FObjEditService        := TObjEditService.Create(Self);
  FCurDesignerService    := TCurDesignerService.Create(Self);
  FAutoCurrentDesigner   := True;
  FAutoCurrentDebugger   := True;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDIdeManager.Destroy;
begin
  ServiceProvider := nil;
  SetCurrentDesigner(nil);
  SetCurrentDebugger(nil);
  FServicesNotifier.Free;
  FDesignerNotifier.Free;
  FDebuggerNotifier.Free;
  FCompInsService.Free;
  FCompImageService.Free;
  FObjEditService.Free;
  FCurDesignerService.Free;

  inherited;
end;

procedure TLMDIdeManager.SetServiceOptions(
  const Value: TLMDIdeManagerServiceOptions);
begin
  if FServiceOptions <> Value then
  begin
    if FServiceProvider <> nil then
      UnregisterAll(FServiceProvider);
    FServiceOptions := Value;
    if FServiceProvider <> nil then
      RegisterAll(FServiceProvider);
  end;
end;

{ TScriptDebuggerNotifier }

procedure TScriptDebuggerNotifier.Breaked(ADebugger: TLMDScriptDebugger);
begin
  if FMgr.FAutoCurrentDebugger then
    FMgr.SetCurrentDebugger(ADebugger);
end;

procedure TScriptDebuggerNotifier.BreakpointsChanged(
  ADebugger: TLMDScriptDebugger);
begin
  // Do nothing.
end;

constructor TScriptDebuggerNotifier.Create(AIdeManager: TLMDIdeManager);
begin
  inherited Create;
  FMgr := AIdeManager;
end;

procedure TScriptDebuggerNotifier.DebugNameChanged(
  ADebugger: TLMDScriptDebugger; AScript: TLMDScriptControl);
begin
  // Do nothing.
end;

procedure TScriptDebuggerNotifier.LogMessage(ADebugger: TLMDScriptDebugger;
  const AMsg: TLMDString; AKind: TLMDDebugMsgKind);
begin
  // Do nothing.
end;

procedure TScriptDebuggerNotifier.Resumed(ADebugger: TLMDScriptDebugger);
begin
  if FMgr.FAutoCurrentDebugger and
     (FMgr.FCurrentDebugger = ADebugger) then
    FMgr.SetCurrentDebugger(nil);
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}

end.
