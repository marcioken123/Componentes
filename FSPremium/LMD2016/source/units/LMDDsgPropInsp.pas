unit LMDDsgPropInsp;
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

LMDDsgPropInsp unit (YB)
------------------------
TLMDPropertyInspector and Property Editors unit.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, Controls, Grids, Graphics, Windows, Messages, Forms,
  Dialogs, TypInfo, Menus, Masks, RTLConsts, Variants, Types, intfLMDBase, LMDUnicode,
  LMDUnicodeStrings, LMDSvcPvdr, LMDTypes, LMDDsgCst, LMDDsgClass, LMDDsgObjects,
  LMDDsgModule, LMDInsClass, LMDInsEditorWnds, LMDInsEditorUtils, LMDInsPropInsp;

type
  { ************************* TLMDPropertyInspector ************************** }

  TLMDPropertyInspector = class(TLMDCustomPropertyInspector, ILMDComponent)
  private
    FServiceProvider: TLMDServiceProvider;
    FSelection:       TLMDDesignObjects;
    FSelnNotifier:    TObject;

    procedure SetSelection(const Value: TLMDDesignObjects);
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
    procedure SelnNotifierChanged;
    function  GetModuleForEditingInstances(AEditor: TLMDPropEditor): TLMDModule;
    procedure CompsChangeNotification(Sender: TObject; AChangedComps: TList);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    procedure GetObjects(AResult: TList); override;
    procedure SetObjects(AObjects: TList); override;
    function  DetectEditorWindowManager(
                  AEditedObject: TPersistent): TLMDEditorWindowManager; override;
    procedure DoGetCompRef(AEditor: TLMDPropEditor; const ACompName: TLMDString;
                           var AComponent: TComponent); override;
    procedure DoGetCompRefName(AEditor: TLMDPropEditor; AComponent: TComponent;
                               var AName: TLMDString); override;
    procedure DoGetCompRefList(AEditor: TLMDPropEditor; AClass: TComponentClass;
                               AResult: TList); override;
    procedure DoGetEventValue(AEditor: TLMDPropEditor; AInstance: TPersistent;
                              APropInfo: ILMDProperty; var AResult: TLMDString); override;
    procedure DoSetEventValue(AEditor: TLMDPropEditor; AInstance: TPersistent;
                              APropInfo: ILMDProperty; const AValue: TLMDString); override;
    procedure DoGetDefaultEventHandlerName(AEditor: TLMDPropEditor; AInstance: TPersistent;
                                           const AEventName: TLMDString; AEventTypeInfo: TLMDTypeInfo;
                                           var AResult: TLMDString); override;
    procedure DoGetExistingEventHandlers(AEditor: TLMDPropEditor; AEventTypeInfo: TLMDTypeInfo;
                                         AResult: TLMDStrings); override;
    procedure DoEnsureEventHandlerSource(AEditor: TLMDPropEditor; const AName, AOldName: TLMDString;
                                         AEventTypeInfo: TLMDTypeInfo; AShowSource: Boolean); override;
    procedure DoGetUniqueCompName(AComponent: TComponent; var AUniqueName: TLMDString); override;
    procedure DoChange(AEditor: TLMDPropEditor); override;
  protected
    { ILMDComponent }
    function getLMDPackage: TLMDPackageID;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property State;
    property ActiveItem;
    property ActiveCategory;
    property Designer;
    property Items;
    property Categories;
    property ObjectsCategories;
  published
    property Selection: TLMDDesignObjects read FSelection write SetSelection;
    property ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
    property PropKinds;
    property ComponentRefColor;
    property ComponentRefPropColor;
    property ExpandComponentRefs;
    property MenuOptions;
    property ReadOnly;
    property SortType;
    property ArrangeKind;
    property ToolTips;
    property GridColor;
    property GridVisible;
    property GutterVisible;
    property GutterColor;
    property GutterLineColor;
    property CursorVisible;
    property SelectionStyle;
    property FlatSelectionBackgroundColor;
    property FlatSelectionColor;
    property CategoryBackgroundColor;
    property CategoryFont;
    property DefaultPropName;
    property Splitter;
    property ValuesColor;
    property HighlightNonDefaultValues;
    property ExpandedCategories;
    property Align;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property Visible;
    property OnExpanded;
    property OnCollapsed;
    property OnCategoryExpanded;
    property OnCategoryCollapsed;
    property OnFilterProp;
    property OnTranslateProp;
    property OnChange;
    property OnGetCaptionColor;
    property OnGetEditorClass;
    property OnCompare;
    property OnDynPropsDefine;
    property OnDynPropGetValue;
    property OnDynPropSetValue;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  LMDDsgDesigner;

type
  { ****************************** TSelnNotifier ***************************** }

  TSelnNotifier = class(ILMDDsgObjsNotifier)
  private
    FPropInsp: TLMDPropertyInspector;
  public
    constructor Create(APropInsp: TLMDPropertyInspector);
    procedure   Changed(ASender: TLMDDesignObjects); override;
  end;

{ TLMDPropertyInspector }

procedure TLMDPropertyInspector.DoChange(AEditor: TLMDPropEditor);
var
  i:     Integer;
  comps: TList;
begin
  comps := TList.Create;
  try
    while True do
    begin
      if AEditor.ParentObjEditor = nil then
        Break; // while
      AEditor := AEditor.ParentObjEditor;
    end;

    if AEditor <> nil then
    begin
      for i := 0 to AEditor.PropCount - 1 do
        comps.Add(AEditor.GetInstance(i));
    end;

    LMDTransformToCompList(comps);
    LMDComponentsChanged(Self, comps);
  finally
    comps.Free;
  end;

  inherited;
end;

procedure TLMDPropertyInspector.CompsChangeNotification(Sender: TObject;
  AChangedComps: TList);
var
  comps: TList;
begin
  if Sender = Self then
    Exit;

  comps := TList.Create;
  try
    if FSelection <> nil then
      FSelection.GetItems(comps);

    LMDTransformToCompList(comps);
    if LMDHasCommonItems(AChangedComps, comps) then
      UpdateContent;
  finally
    comps.Free;
  end;
end;

constructor TLMDPropertyInspector.Create(AOwner: TComponent);
begin
  inherited;
  FSelnNotifier := TSelnNotifier.Create(Self);
  LMDRegisterComponentChangeNotification(Self, CompsChangeNotification);
end;

destructor TLMDPropertyInspector.Destroy;
begin
  Selection := nil;
  ServiceProvider := nil;

  FSelnNotifier.Free;
  LMDUnregisterComponentChangeNotification(Self);
  inherited;
end;

function TLMDPropertyInspector.DetectEditorWindowManager(
  AEditedObject: TPersistent): TLMDEditorWindowManager;
var
  module: TLMDModule;
begin
  Result := nil;
  module := LMDFindObjectModule(AEditedObject);
  if module <> nil then
    Result := LMDFindDesignerEditorWindows(module.Root);
end;

procedure TLMDPropertyInspector.GetObjects(AResult: TList);
begin
  if FSelection <> nil then
    FSelection.GetItems(AResult);
end;

procedure TLMDPropertyInspector.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FSelection then
      Selection := nil;
    if AComponent = FServiceProvider then
      ServiceProvider := nil;
  end;
end;

procedure TLMDPropertyInspector.SelnNotifierChanged;
begin
  ObjectsChanged;
end;

procedure TLMDPropertyInspector.SetObjects(AObjects: TList);
begin
  if FSelection <> nil then
    FSelection.SetItems(AObjects);
end;

procedure TLMDPropertyInspector.SetSelection(
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

    ObjectsChanged;
  end;
end;

procedure TLMDPropertyInspector.SetServiceProvider(
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

procedure TLMDPropertyInspector.DoEnsureEventHandlerSource(
  AEditor: TLMDPropEditor; const AName, AOldName: TLMDString;
  AEventTypeInfo: TLMDTypeInfo; AShowSource: Boolean);
var
  module: TLMDModule;
  eval:   TLMDEventValue;
begin
  module  := GetModuleForEditingInstances(AEditor);
  if module <> nil then
  begin
    eval.Owner := module.Root;
    eval.Name  := AName;
    module.CheckEventHandler(eval);
    
    module.EnsureEventHandlerSource(AName, AOldName, AEventTypeInfo,
                                    AShowSource);
  end;
end;

procedure TLMDPropertyInspector.DoGetCompRef(AEditor: TLMDPropEditor;
  const ACompName: TLMDString; var AComponent: TComponent);
var
  module: TLMDModule;
begin
  AComponent := nil;
  module     := GetModuleForEditingInstances(AEditor);

  if module <> nil then
    AComponent := module.GetCompRef(ACompName);
end;

procedure TLMDPropertyInspector.DoGetCompRefList(AEditor: TLMDPropEditor;
  AClass: TComponentClass; AResult: TList);
var
  module: TLMDModule;
begin
  module := GetModuleForEditingInstances(AEditor);
  if module <> nil then
    module.GetCompRefList(AClass, AResult);
end;

procedure TLMDPropertyInspector.DoGetCompRefName(AEditor: TLMDPropEditor;
  AComponent: TComponent; var AName: TLMDString);
var
  module: TLMDModule;
begin
  AName   := '';
  module  := GetModuleForEditingInstances(AEditor);

  if module <> nil then
    AName := module.GetCompRefName(AComponent);
end;

procedure TLMDPropertyInspector.DoGetDefaultEventHandlerName(
  AEditor: TLMDPropEditor; AInstance: TPersistent;
  const AEventName: TLMDString; AEventTypeInfo: TLMDTypeInfo;
  var AResult: TLMDString);
var
  module: TLMDModule;
begin
  AResult := '';
  module  := GetModuleForEditingInstances(AEditor);
  
  if module <> nil then
    AResult := module.GetEventHandlerName(AInstance, AEventName, AEventTypeInfo);
end;

procedure TLMDPropertyInspector.DoGetEventValue(AEditor: TLMDPropEditor;
  AInstance: TPersistent; APropInfo: ILMDProperty;
  var AResult: TLMDString);
var
  module: TLMDModule;
  eval:   TLMDEventValue;
begin
  AResult := '';
  module  := GetModuleForEditingInstances(AEditor);

  if module <> nil then
  begin
    eval    := module.GetEventProp(AInstance, APropInfo.RTTIPropInfo);
    AResult := eval.Name;

    if eval.Owner <> module.Root then
      AResult := ''; // Delphi like behavior; Don't show inherited frame
                     // event handlers.
  end;
end;

procedure TLMDPropertyInspector.DoGetExistingEventHandlers(
  AEditor: TLMDPropEditor; AEventTypeInfo: TLMDTypeInfo;
  AResult: TLMDStrings);
var
  module: TLMDModule;
begin
  module  := GetModuleForEditingInstances(AEditor);
  if module <> nil then
    module.GetEventHandlerList(AEventTypeInfo, AResult);
end;

procedure TLMDPropertyInspector.DoGetUniqueCompName(AComponent: TComponent;
  var AUniqueName: TLMDString);
var
  module: TLMDModule;
begin
  AUniqueName := '';
  module      := LMDFindObjectModule(AComponent);
  
  if module <> nil then
    AUniqueName := module.GetUniqueCompName(AComponent.ClassName);
end;

procedure TLMDPropertyInspector.DoSetEventValue(AEditor: TLMDPropEditor;
  AInstance: TPersistent; APropInfo: ILMDProperty;
  const AValue: TLMDString);
var
  module: TLMDModule;
  evval:  TLMDEventValue;
begin
  module  := GetModuleForEditingInstances(AEditor);

  if module <> nil then
  begin
    evval.Owner := module.Root;
    evval.Name  := AValue;
    module.SetEventProp(AInstance, APropInfo.RTTIPropInfo, evval);
  end;
end;

function TLMDPropertyInspector.GetModuleForEditingInstances(
  AEditor: TLMDPropEditor): TLMDModule;
var
  i: Integer;
begin
  Result := LMDFindObjectModule(AEditor.GetInstance(0));
  if Result = nil then
    Exit;

  for i := 1 to AEditor.PropCount - 1 do
    if LMDFindObjectModule(AEditor.GetInstance(i)) <> Result then
    begin
      Result := nil;
      Exit;
    end;
end;

function TLMDPropertyInspector.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_DESIGN;
end;

{ TSelnNotifier }

procedure TSelnNotifier.Changed(ASender: TLMDDesignObjects);
begin
  FPropInsp.SelnNotifierChanged;
end;

constructor TSelnNotifier.Create(APropInsp: TLMDPropertyInspector);
begin
  inherited Create;
  FPropInsp := APropInsp;
end;

end.
