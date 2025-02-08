unit LMDDsgManager;
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

LMDDsgManager unit (YB)
------------------------
TLMDDesignManager unit

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, SysUtils, intfLMDBase, LMDTypes, LMDSvcPvdr, LMDDsgCst,
  LMDDsgClass, LMDDsgObjects, LMDDsgModule, LMDDsgDesigner, LMDDsgComboBox,
  LMDDsgPropInsp, LMDInsEditorWnds, LMDInsEditorUtils;

type
  ELMDDesignManager = class(Exception);

  { ************************ TLMDCustomDesignManager ************************* }

  TLMDDesignManagerServiceOptions = set of (dmsoAutoConnectObjectComboBox,
                                            dmsoAutoConnectPropInsp);

  TLMDCustomDesignManager = class(TComponent, ILMDComponent)
  private
    FAbout                   : TLMDAboutVar;
    FServiceProvider         : TLMDServiceProvider;
    FCurrentDesigner         : TLMDDesigner;
    FServicesNotifier        : ILMDServicesNotifier;
    FDesignerNotifier        : ILMDDesignerNotifier;
    FOnCurrentDesignerChange : TNotifyEvent;
    FAutoCurrentDesigner     : Boolean;
    FServiceOptions          : TLMDDesignManagerServiceOptions;

    procedure SetServiceProvider(const Value: TLMDServiceProvider);
    procedure SetServiceOptions(const Value: TLMDDesignManagerServiceOptions);
    procedure SetCurrentDesigner(const Value: TLMDDesigner);
    procedure DesignersChanged;
    procedure ConnectComboBox;
    procedure ConnectPropInsp;
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoCurrentDesignerChange; virtual;
    property  ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property  ServiceOptions: TLMDDesignManagerServiceOptions read FServiceOptions write SetServiceOptions
                  default [dmsoAutoConnectObjectComboBox, dmsoAutoConnectPropInsp];
    property  CurrentDesigner: TLMDDesigner read FCurrentDesigner;
    property  AutoCurrentDesigner: Boolean read FAutoCurrentDesigner write FAutoCurrentDesigner default True;
    property  OnCurrentDesignerChange: TNotifyEvent read FOnCurrentDesignerChange write FOnCurrentDesignerChange;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
  end;

  { *************************** TLMDDesignManager **************************** }

  TLMDDesignManager = class(TLMDCustomDesignManager)
  private
    procedure ReadDeprecatedBooleanProp(Reader: Treader);
    procedure ReadDeprecatedEventProp(Reader: Treader);
  protected
    procedure DefineProperties(Filer: TFiler); override;
  public
    property CurrentDesigner;
  published
    property ServiceProvider;
    property ServiceOptions;
    property AutoCurrentDesigner;
    property OnCurrentDesignerChange;
  end;

implementation

type
  {**************************** TServicesNotifier *****************************}

  TServicesNotifier = class(ILMDServicesNotifier)
  private
    FMgr: TLMDCustomDesignManager;
  public
    constructor Create(ADesignManager: TLMDCustomDesignManager);

    procedure AfterMemberAddition(AMember: TObject); override;
    procedure BeforeMemberRemoving(AMember: TObject); override;
  end;

  {**************************** TDesignerNotifier *****************************}

  TDesignerNotifier = class(ILMDDesignerNotifier)
  private
    FMgr: TLMDCustomDesignManager;
  public
    constructor Create(ADesignManager: TLMDCustomDesignManager);

    procedure Focus(ASender: TLMDCustomDesigner); override;
    procedure ActiveChanged(ASender: TLMDCustomDesigner); override;
  end;

{***************************** TServicesNotifier ******************************}
{ ---------------------------------------------------------------------------- }
constructor TServicesNotifier.Create(
  ADesignManager: TLMDCustomDesignManager);
begin
  inherited Create;
  FMgr := ADesignManager;
end;

{ ---------------------------------------------------------------------------- }
procedure TServicesNotifier.AfterMemberAddition(AMember: TObject);
begin
  if AMember is TLMDObjectComboBox then
    FMgr.ConnectComboBox;
  if AMember is TLMDPropertyInspector then
    FMgr.ConnectPropInsp;
  if AMember is TLMDDesigner then
    FMgr.DesignersChanged;
end;

{ ---------------------------------------------------------------------------- }
procedure TServicesNotifier.BeforeMemberRemoving(AMember: TObject);
begin
  if AMember is TLMDDesigner then
    FMgr.DesignersChanged;
end;

{***************************** TDesignerNotifier ******************************}
{ -------------------------------- public ------------------------------------ }
constructor TDesignerNotifier.Create(
  ADesignManager: TLMDCustomDesignManager);
begin
  inherited Create;
  FMgr := ADesignManager;
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

{ *********************** class TLMDCustomDesignManager ********************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDCustomDesignManager.SetCurrentDesigner(
  const Value: TLMDDesigner);
begin
  if FCurrentDesigner <> Value then
  begin
    if (Value <> nil) and not Value.Active then
      raise ELMDDesignManager.Create(SLMDDsgMgrNonActiveCurDesigner);

    FCurrentDesigner := Value;
    ConnectComboBox;
    ConnectPropInsp;

    DoCurrentDesignerChange;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignManager.DesignersChanged;
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
procedure TLMDCustomDesignManager.ConnectComboBox;
var
  LSeln,
  LListObjs: TLMDDesignObjects;
  LI:        Integer;
  LList:     TList;
begin
  if dmsoAutoConnectObjectComboBox in FServiceOptions then
  begin
    LSeln     := nil;
    LListObjs := nil;
    if FCurrentDesigner <> nil then
    begin
      LSeln     := FCurrentDesigner.Selection;
      LListObjs := FCurrentDesigner.AllComponents;
    end;

    if FServiceProvider <> nil then
    begin
      LList := FServiceProvider.Members.GetList(TLMDObjectComboBox);
      try
        for LI := 0 to LList.Count - 1 do
        begin
          TLMDObjectComboBox(LList[LI]).Selection   := LSeln;
          TLMDObjectComboBox(LList[LI]).ListObjects := LListObjs;
        end;
      finally
        LList.Free;
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignManager.ConnectPropInsp;
var
  LSeln: TLMDDesignObjects;
  LI:    Integer;
  LList: TList;
begin
  if dmsoAutoConnectPropInsp in FServiceOptions then
  begin
    LSeln := nil;
    if FCurrentDesigner <> nil then
      LSeln := FCurrentDesigner.Selection;

    if FServiceProvider <> nil then
    begin
      LList := FServiceProvider.Members.GetList(TLMDPropertyInspector);
      try
        for LI := 0 to LList.Count - 1 do
          TLMDPropertyInspector(LList[LI]).Selection := LSeln;
      finally
        LList.Free;
      end;
    end;
  end;
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDCustomDesignManager.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_DESIGN;
end;

{ ------------------------------ protected ----------------------------------- }
procedure TLMDCustomDesignManager.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  
  if (Operation = opRemove) and (AComponent = FServiceProvider) then
    ServiceProvider := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignManager.DoCurrentDesignerChange;
begin
  if Assigned(FOnCurrentDesignerChange) then
    FOnCurrentDesignerChange(Self);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDCustomDesignManager.Create(AOwner: TComponent);
begin
  inherited;

  FServicesNotifier    := TServicesNotifier.Create(Self);
  FDesignerNotifier    := TDesignerNotifier.Create(Self);
  FAutoCurrentDesigner := True;
  FServiceOptions      := [dmsoAutoConnectObjectComboBox, dmsoAutoConnectPropInsp];
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomDesignManager.Destroy;
begin
  ServiceProvider := nil;
  SetCurrentDesigner(nil);
  FServicesNotifier.Free;
  FDesignerNotifier.Free;

  inherited;
end;

{ **************************** TLMDDesignManager ***************************** }
{ ---------------------------------------------------------------------------- }
procedure TLMDDesignManager.ReadDeprecatedBooleanProp(
  Reader: Treader);
begin
  Reader.ReadBoolean;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignManager.ReadDeprecatedEventProp(Reader: Treader);
begin
  if Reader.NextValue = vaNil then
    Reader.ReadValue
  else
    Reader.ReadIdent;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomDesignManager.SetServiceProvider(
  const Value: TLMDServiceProvider);
begin
  if FServiceProvider <> Value then
  begin
    if FServiceProvider <> nil then
    begin
      FServiceProvider.RemoveFreeNotification(Self);
      FServiceProvider.Notifiers.UnregisterNotifier(FServicesNotifier);
      FServiceProvider.Notifiers.UnregisterNotifier(FDesignerNotifier);
    end;
    FServiceProvider := Value;
    if FServiceProvider <> nil then
    begin
      FServiceProvider.FreeNotification(Self);
      FServiceProvider.Notifiers.RegisterNotifier(FServicesNotifier);
      FServiceProvider.Notifiers.RegisterNotifier(FDesignerNotifier);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDesignManager.DefineProperties(Filer: TFiler);
begin
  inherited;

  { Deprecated properties }

  Filer.DefineProperty('ExcludeDesignControl', ReadDeprecatedBooleanProp, nil, False);
  Filer.DefineProperty('AutoCompRefs', ReadDeprecatedBooleanProp, nil, False);
  Filer.DefineProperty('AlwaysShowNonvisualComponents', ReadDeprecatedBooleanProp, nil, False);
  Filer.DefineProperty('OnChangeSelection', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnUpdateComboBoxObjects', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnUpdateComboBoxSelection', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnUpdatePropInspObjects', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnUpdateCurrentDesignerSelection', ReadDeprecatedEventProp, nil, False);
  Filer.DefineProperty('OnChange', ReadDeprecatedEventProp, nil, False);
end;

procedure TLMDCustomDesignManager.SetServiceOptions(
  const Value: TLMDDesignManagerServiceOptions);
begin
  FServiceOptions := Value;
end;

end.
