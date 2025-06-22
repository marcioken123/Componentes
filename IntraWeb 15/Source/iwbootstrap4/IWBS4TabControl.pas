unit IWBS4TabControl;

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, StrUtils, IWApplication, IWBaseRenderContext, IWControl,
  IWBaseInterfaces, IWCompTabControl, IWTypes, IWScriptEvents, IWFont, IWXMLTag,
  IWBaseHTMLInterfaces, IWBS4CustomEvents, IWBS4Common, IWBS4CommonInterfaces,
  IWHTMLTag, IWRenderContext;

type
  TIWBS4TabOptions = class(TPersistent)
  private
    FFade: Boolean;
    FPills: Boolean;
    FJustified: Boolean;
    FStacked: Boolean;
  public
    constructor Create(AOwner: TComponent);
    procedure Assign(Source: TPersistent); override;
  published
    property Fade: Boolean read FFade write FFade default False;
    property Pills: Boolean read FPills write FPills default False;
    property Justified: Boolean read FJustified write FJustified default False;
    property Stacked: Boolean read FStacked write FStacked default False;
  end;

  {$include IWPlatformAttrib.inc}
  TIWBS4TabControl = class(TIWTabControl, IIWInputControl, IIWBS4Component, IIWBS4Container)
  private
    FMainID: string;
    FOldCss: string;
    FOldStyle: string;
    FOldVisible: Boolean;
    FOldActivePage: Integer;
    FActivePage: Integer;
    FAsyncRefreshControl: Boolean;
    FRendered: Boolean;
    FCustomAsyncEvents: TIWBS4CustomAsyncEvents;
    FCustomRestEvents: TIWBS4CustomRestEvents;
    FGridOptions: TIWBS4GridOptions;
    FRegionDiv: TIWHTMLTag;
    FScript: TStringList;
    FScriptInsideTag: Boolean;
    FScriptParams: TIWBS4ScriptParams;
    FStyle: TStringList;
    FTabOptions: TIWBS4TabOptions;
    FOnAfterRender: TNotifyEvent;
    FOnAfterAsyncChange: TNotifyEvent;
    function TabOrderToTabIndex(ATabOrder: Integer): Integer;
    procedure CheckActiveVisible;
    function HTMLControlImplementation: TIWHTMLControlImplementation;
    function RegionDiv: TIWHTMLTag;
    procedure SetGridOptions(const Value: TIWBS4GridOptions);
    procedure SetTabOptions(const Value: TIWBS4TabOptions);
    procedure SetScript(const AValue: TStringList);
    procedure SetScriptParams(const AValue: TIWBS4ScriptParams);
    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    procedure OnScriptChange(ASender: TObject);
    procedure OnStyleChange(ASender: TObject);
    function GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
    function GetCustomRestEvents: TIWBS4CustomRestEvents;
    procedure SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
    procedure SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
    function GetScript: TStringList;
    function GetScriptParams: TIWBS4ScriptParams;
    function GetScriptInsideTag: Boolean;
    procedure SetActivePage(const Value: Integer);
    procedure SetScriptInsideTag(const Value: Boolean);
    function GetAfterRender: TNotifyEvent;
    procedure SetAfterRender(const Value: TNotifyEvent);
  private
    function get_Clip: Boolean;
    procedure set_Clip(AValue: Boolean);
    function get_HasName: Boolean;
    function get_UseFrame: Boolean;
    procedure set_UseFrame(AValue: Boolean);
    function get_HTMLWidth: Integer;
    function get_HTMLHeight: Integer;
    function get_HTMLLeft: Integer;
    function get_HTMLTop: Integer;
    function get_ZIndex: Integer;
    procedure set_ZIndex(AValue: Integer);
    function get_RenderSize: Boolean;
    procedure set_RenderSize(AValue: Boolean);
    function get_StyleRenderOptions: TIWStyleRenderOptions;
    procedure set_StyleRenderOptions(AValue: TIWStyleRenderOptions);
    function get_ScriptEvents: TIWScriptEvents;
    procedure set_ScriptEvents(AValue: TIWScriptEvents);
    function get_Css: string;
    procedure set_Css(const AValue: string);
    function get_SkinId: string;
    procedure set_SkinId(const AValue: string);
    function get_WebCursor: TIWCursor;
    procedure set_WebCursor(AValue: TIWCursor);
    procedure set_WebFont(AValue: TIWFont);
    function get_WebFont: TIWFont;
    function get_ExtraTagParams: TStringList;
    procedure set_ExtraTagParams(const Value: TStringList);
    function get_OnHTMLTag: TIWOnHTMLTag;
    procedure set_OnHTMLTag(AValue: TIWOnHTMLTag);
    // deprecated
    function get_SupportsPartial: Boolean;
    procedure set_SupportsPartial(AValue: Boolean);
  protected
    function get_HTMLName: string; override;
    procedure SetValue(const AValue: string);
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); virtual;
    procedure InternalRenderStyle(AStyle: TStringList); virtual;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure RenderScripts(AComponentContext: TIWCompContext); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AsyncRefreshControl;
    procedure ResetAsyncRefreshControl;
    procedure AsyncRemoveControl;
    function GetTabPageCSSClass(ATabPage: TComponent): string;
    function IsStoredCustomAsyncEvents: Boolean;
    function IsStoredCustomRestEvents: Boolean;
    function JQSelector: string;
    procedure SetFocus; override;
    procedure SetTabPageVisibility(ATabIndex: Integer; Visible: Boolean); overload;
    procedure SetTabPageVisibility(ATabPage: TIWTabPage; Visible: Boolean); overload;
    function RenderStyle(AContext: TIWCompContext): string; override;
  published
    property ActivePage: Integer read FActivePage write SetActivePage;
    property Align;
    property BSGridOptions: TIWBS4GridOptions read FGridOptions write SetGridOptions;
    property BSTabOptions: TIWBS4TabOptions read FTabOptions write SetTabOptions;
    property ClipRegion default False;
    property CustomAsyncEvents: TIWBS4CustomAsyncEvents read GetCustomAsyncEvents write SetCustomAsyncEvents stored IsStoredCustomAsyncEvents;
    property CustomRestEvents: TIWBS4CustomRestEvents read GetCustomRestEvents write SetCustomRestEvents stored IsStoredCustomRestEvents;
    property ExtraTagParams;
    property LayoutMgr;
    property RenderInvisibleControls default False;
    property Script: TStringList read GetScript write SetScript;
    property ScriptInsideTag: Boolean read GetScriptInsideTag write SetScriptInsideTag default True;
    property ScriptParams: TIWBS4ScriptParams read GetScriptParams write SetScriptParams;
    property Style: TStringList read GetStyle write SetStyle;
    property ZIndex default 0;

    // Occurs after component is rendered.
    property OnAfterRender: TNotifyEvent read GetAfterRender write SetAfterRender;

    // Occurs after component is changed on an Asyn call, it doesn't occurs if the control is fully rendered
    property OnAfterAsyncChange: TNotifyEvent read FOnAfterAsyncChange write FOnAfterAsyncChange;

    property OnHTMLTag;
  end;

implementation

uses
  {$IFDEF  IW_14_3_0_UP}
  IW.Common.SysTools, {$ELSE} IW.Common.System, {$ENDIF}
  {$IFNDEF IW_14_1_0_UP} IWLists, {$ELSE} IW.Common.Lists, {$ENDIF}
  IWBS4Utils, IWBS4LayoutMgr, IWBS4ScriptEvents, IWBS4Global;
{$region 'TIWBS4TabOptions'}
constructor TIWBS4TabOptions.Create(AOwner: TComponent);
begin
  FFade := False;
  FPills := False;
  FJustified := False;
  FStacked := False;
end;

procedure TIWBS4TabOptions.Assign(Source: TPersistent);
begin
  if Source is TIWBS4TabOptions then
  begin
    Fade := TIWBS4TabOptions(Source).Fade;
    Pills := TIWBS4TabOptions(Source).Pills;
    Justified := TIWBS4TabOptions(Source).Justified;
    Stacked := TIWBS4TabOptions(Source).Stacked;
  end
  else
  begin
    inherited;
  end;
end;
{$endregion}

{$region 'TIWBS4TabControl'}

constructor TIWBS4TabControl.Create(AOwner: TComponent);
begin
  inherited;
  FGridOptions := TIWBS4GridOptions.Create(Self);
  FAsyncRefreshControl := True;
  FRendered := False;
  FMainID := '';
  FScript := TStringList.Create;
  FScript.OnChange := OnScriptChange;
  FScriptInsideTag := True;
  FScriptParams := TIWBS4ScriptParams.Create;
  FScriptParams.OnChange := OnScriptChange;
  FStyle := TStringList.Create;
  FStyle.OnChange := OnStyleChange;
  FStyle.NameValueSeparator := ':';
  FTabOptions := TIWBS4TabOptions.Create(Self);
  Height := 112;
  Width := 112;
end;

destructor TIWBS4TabControl.Destroy;
begin
  FreeAndNil(FGridOptions);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);
  FreeAndNil(FTabOptions);
  inherited;
end;

function TIWBS4TabControl.JQSelector: string;
begin
  Result := '$("#' + HTMLName + '")';
end;

procedure TIWBS4TabControl.SetFocus;
begin
  IWBS4ExecuteAsyncJScript(JQSelector + '.focus()');
end;

procedure TIWBS4TabControl.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBS4TabControl.ResetAsyncRefreshControl;
begin
  FAsyncRefreshControl := False;
end;

procedure TIWBS4TabControl.AsyncRemoveControl;
begin
  TIWBS4Common.AsyncRemoveControl(HTMLName);
  FRendered := False;
end;

procedure TIWBS4TabControl.SetGridOptions(const Value: TIWBS4GridOptions);
begin
  FGridOptions.Assign(Value);
  invalidate;
end;

procedure TIWBS4TabControl.SetValue(const AValue: string);
var
  LIndex: Integer;
begin
  if RequiresUpdateNotification(Parent) then
  begin
    UpdateNotifiedInterface(Parent).NotifyUpdate(Self, AValue);
  end;
  LIndex := StrToIntDef(AValue, 0);
  if (LIndex < 0) or (LIndex >= Pages.Count) then
  begin
    FActivePage := 0;
    FOldActivePage := -1;
  end
  else
  begin
    FActivePage := TIWTabPage(Pages[LIndex]).TabOrder;
    FOldActivePage := FActivePage;
  end;
end;

procedure TIWBS4TabControl.SetTabOptions(const Value: TIWBS4TabOptions);
begin
  FTabOptions.Assign(Value);
  invalidate;
end;

procedure TIWBS4TabControl.OnScriptChange(ASender: TObject);
begin
  AsyncRefreshControl;
end;

procedure TIWBS4TabControl.OnStyleChange(ASender: TObject);
begin
  Invalidate;
end;

function TIWBS4TabControl.GetAfterRender: TNotifyEvent;
begin
  Result := FOnAfterRender;
end;

function TIWBS4TabControl.GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
begin
  if FCustomAsyncEvents = nil then
  begin
    FCustomAsyncEvents := TIWBS4CustomAsyncEvents.Create(Self);
  end;
  Result := FCustomAsyncEvents;
end;

function TIWBS4TabControl.GetCustomRestEvents: TIWBS4CustomRestEvents;
begin
  if FCustomRestEvents = nil then
  begin
    FCustomRestEvents := TIWBS4CustomRestEvents.Create(Self);
  end;
  Result := FCustomRestEvents;
end;

procedure TIWBS4TabControl.SetActivePage(const Value: Integer);
begin
  FActivePage := Value;
  Invalidate;
end;

procedure TIWBS4TabControl.SetAfterRender(const Value: TNotifyEvent);
begin
  FOnAfterRender := Value;
end;

procedure TIWBS4TabControl.SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
begin
  FCustomAsyncEvents.Assign(Value);
end;

procedure TIWBS4TabControl.SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
begin
  FCustomRestEvents.Assign(Value);
end;

function TIWBS4TabControl.IsStoredCustomAsyncEvents: Boolean;
begin
  Result := (FCustomAsyncEvents <> nil) and (FCustomAsyncEvents.Count > 0);
end;

function TIWBS4TabControl.IsStoredCustomRestEvents: Boolean;
begin
  Result := (FCustomRestEvents <> nil) and (FCustomRestEvents.Count > 0);
end;

procedure TIWBS4TabControl.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;

procedure TIWBS4TabControl.SetScriptInsideTag(const Value: Boolean);
begin
  FScriptInsideTag := Value;
end;

procedure TIWBS4TabControl.SetScriptParams(const AValue: TIWBS4ScriptParams);
begin
  FScriptParams.Assign(AValue);
end;

function TIWBS4TabControl.GetScript: TStringList;
begin
  Result := FScript;
end;

function TIWBS4TabControl.GetScriptInsideTag: Boolean;
begin
  Result := FScriptInsideTag;
end;

function TIWBS4TabControl.GetScriptParams: TIWBS4ScriptParams;
begin
  Result := FScriptParams;
end;

function TIWBS4TabControl.GetStyle: TStringList;
begin
  Result := FStyle;
end;

procedure TIWBS4TabControl.SetStyle(const AValue: TStringList);
begin
  FStyle.Assign(AValue);
end;

function TIWBS4TabControl.HTMLControlImplementation: TIWHTMLControlImplementation;
begin
  Result := ControlImplementation;
end;

function TIWBS4TabControl.RegionDiv: TIWHTMLTag;
begin
  Result := FRegionDiv;
end;

function TIWBS4TabControl.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  if not (Self.LayoutMgr is TIWBS4LayoutMgr) then
  begin
    Self.LayoutMgr := TIWBS4LayoutMgr.Create(Self);
  end;
  Result := inherited;
end;

procedure TIWBS4TabControl.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  if not FTabOptions.Justified and not FTabOptions.Stacked and gIWBS4LibDynamicTabs then
    AScript.Add('$("#' + AHTMLName + '_tabs' + '").bootstrapDynamicTabs();');

  // save seleted tab on change, manually trigger change event because val don't do it
  AScript.Add('$("#' + AHTMLName + '_tabs").off("show.bs.tab").on("show.bs.tab", function(e){ $("#' + AHTMLName + '_input").val($(e.target).attr("tabindex")).change(); });');

  // event async change
  if Assigned(OnAsyncChange) then
  begin
    AScript.Add('$("#' + AHTMLName + '_tabs").off("shown.bs.tab").on("shown.bs.tab", function(e){ executeAjaxEvent("&page="+$(e.target).attr("tabindex"), null, "' + AHTMLName + '.DoOnAsyncChange", true, null, true); });');
    AContext.WebApplication.RegisterCallBack(AHTMLName + '.DoOnAsyncChange', DoOnAsyncChange);
  end;
end;

procedure TIWBS4TabControl.InternalRenderStyle(AStyle: TStringList);
begin
  //
end;

function TIWBS4TabControl.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
  xApplication: TIWApplication;
begin
  Result := nil;
  xHTMLName := HTMLName;

  if FAsyncRefreshControl or not FRendered then
  begin
    TIWBS4RegionCommon.CancelChildAsyncRender(Self);
    DoRender;
    TIWBS4Common.RenderAsync(xHTMLName, Self, AContext);
  end
  else
  begin
    if AContext = nil then
      xApplication := GGetWebApplicationThreadVar
    else
      xApplication := AContext.WebApplication;
    TIWBS4Common.SetAsyncClass(xApplication, xHTMLName, RenderCSSClass(AContext), FOldCss);
    TIWBS4Common.SetAsyncStyle(xApplication, xHTMLName, RenderStyle(AContext), FOldStyle);
    TIWBS4Common.SetAsyncVisible(xApplication, FMainID, Visible, FOldVisible);
    if FOldActivePage <> FActivePage then
    begin
      IWBS4ExecuteAsyncJScript(xApplication, '$("#' + HTMLName + '_tabs a[tabindex=' + IntToStr(TabOrderToTabIndex(FActivePage)) + ']").tab("show");', False, True);
      FOldActivePage := FActivePage;
    end;

    if Assigned(FOnAfterAsyncChange) then
    begin
      FOnAfterAsyncChange(Self);
    end;

    if Assigned(gIWBS4OnAfterAsyncChange) then
    begin
      gIWBS4OnAfterAsyncChange(Self, xHTMLName);
    end;
  end;
end;

procedure TIWBS4TabControl.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  TIWBS4RegionCommon.RenderComponents(Self, AContainerContext, APageContext);
end;

function TIWBS4TabControl.TabOrderToTabIndex(ATabOrder: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Pages.Count - 1 do
    if TIWTabPage(Pages[i]).TabOrder = ATabOrder then
    begin
      Result := i;
      Break;
    end;
end;

procedure TIWBS4TabControl.CheckActiveVisible;
var
  i, LIndex: Integer;
begin
  LIndex := TabOrderToTabIndex(FActivePage);
  if (LIndex = -1) or not TIWTabPage(FPages.Items[LIndex]).Visible then
  begin
    for i := 0 to Pages.Count - 1 do
      if TIWTabPage(FPages[i]).Visible then
      begin
        FActivePage := TIWTabPage(FPages[i]).TabOrder;
        Break;
      end;
  end;
end;

function TIWBS4TabControl.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := 'iwbs-tabs ' + FGridOptions.GetClassString;
end;

function TIWBS4TabControl.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  xHTMLName: string;
  xHTMLInput: string;
  i, tabIndex: Integer;
  tagTabs, tag: TIWHTMLTag;
  TabPage: TIWTabPage;
  LInitProcCode: string;
begin
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;
  FOldActivePage := FActivePage;

  MergeSortList(Pages, TabOrderCompare);
  CheckActiveVisible;

  // read only one time
  xHTMLName := HTMLName;
  xHTMLInput := xHTMLName + '_input';

  // main div
  FRegionDiv := TIWHTMLTag.CreateTag('div');
  FRegionDiv.AddStringParam('id', xHTMLName);
  FRegionDiv.AddClassParam(FOldCss);
  FRegionDiv.AddStringParam('style', RenderStyle(AContext));
  Result := FRegionDiv;

  // tabs region
  tagTabs := result.Contents.AddTag('ul');
  tagTabs.AddStringParam('id', xHTMLName + '_tabs');
  tagTabs.AddClassParam('nav');
  if FTabOptions.Pills then
    tagTabs.AddClassParam('nav-pills')
  else
    tagTabs.AddClassParam('nav-tabs');

  if FTabOptions.Justified then
  begin
    tagTabs.AddClassParam('nav-justified');
  end;
  if FTabOptions.Stacked then
  begin
    tagTabs.AddClassParam('nav-stacked');
  end;

  tagTabs.AddStringParam('role', 'tablist');

  // build the tabs
  tabIndex := -1;
  for i := 0 to Pages.Count - 1 do
  begin
    TabPage := TIWTabPage(FPages.Items[i]);
    TabPage.TabOrder := i;
    if not TabPage.Visible and not RenderInvisibleControls then
    begin
      Continue;
    end;
    tag := tagTabs.Contents.AddTag('li');
    if (tabIndex = -1) and (FActivePage = TabPage.TabOrder) and TabPage.Visible then
    begin
      tag.AddClassParam('active');
      tabIndex := i;
    end;
    tag := tag.Contents.AddTag('a');
    tag.AddStringParam('data-toggle', IfThen(FTabOptions.Pills, 'pill', 'tab'));
    tag.AddStringParam('href', '#' + TabPage.HTMLName);
    tag.AddIntegerParam('tabindex', i);
    if not TabPage.Visible then
    begin
      tag.AddStringParam('style', 'display: none');
    end;
    tag.Contents.AddText(TabPage.Title);
  end;

  // this hidden input is for input seleted tab page
  Result.Contents.AddHiddenField(xHTMLInput, xHTMLInput, IntToStr(tabIndex));

  // render scripts
  IWBS4RenderScript(Self, AContext, Result);
  FMainID := Result.Params.Values['id'];

  // initialize hidden input (after render scripts)
  {$IFNDEF IW_15}  // Anything prior to IW 15
  LInitProcCode := '  IW.initIWCL(' + HTMLControlImplementation.IWCLName + ',"' + xHTMLName + '_input",true);';
  TIWPageContext40(AContext.PageContext).AddToIWCLInitProc(LInitProcCode);
  {$ELSE}          // IW 15 or newer use a minified func name
  LInitProcCode := '  f(' + HTMLControlImplementation.IWCLName + ',"' + xHTMLName + '_input",true);';
  TIWPageContext40(AContext.PageContext).AppendIWCLInitProc(#13#10 + LInitProcCode);
  {$ENDIF}

  FAsyncRefreshControl := False;
  FRendered := True;
end;

procedure TIWBS4TabControl.RenderScripts(AComponentContext: TIWCompContext);
begin
  //
end;

function TIWBS4TabControl.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := TIWBS4Common.RenderStyle(Self);
end;

function TIWBS4TabControl.GetTabPageCSSClass(ATabPage: TComponent): string;
begin
  Result := 'tab-pane';
  if BSTabOptions.Fade then
  begin
    Result := Result + ' fade';
  end;
  if TIWTabPage(ATabPage).TabOrder = FActivePage then
  begin
    Result := Result + ' active in';
  end;
end;

procedure TIWBS4TabControl.SetTabPageVisibility(ATabIndex: Integer; Visible: Boolean);
var
  LIndex: Integer;
begin
  LIndex := TabOrderToTabIndex(ATabIndex);
  if LIndex >= 0 then
  begin
    TIWTabPage(FPages.Items[LIndex]).Visible := Visible;
    CheckActiveVisible;
    IWBS4ExecuteAsyncJScript('$("#' + HTMLName + '_tabs a[tabindex=' + IntToStr(LIndex) + ']").css("display", "' + iif(Visible, '', 'none') + '");');
  end;
end;

procedure TIWBS4TabControl.SetTabPageVisibility(ATabPage: TIWTabPage; Visible: Boolean);
begin
  SetTabPageVisibility(Pages.IndexOf(ATabPage), Visible);
end;
{$endregion}

{$REGION 'IIWBaseHTMLComponent and other interfaces required by old compilers (D2009)'}

function TIWBS4TabControl.get_HTMLName: string;
begin
  Result := ControlImplementation.HTMLName;
end;

function TIWBS4TabControl.get_Clip: Boolean;
begin
  Result := inherited ClipRegion;
end;

procedure TIWBS4TabControl.set_Clip(AValue: Boolean);
begin
  inherited ClipRegion := AValue;
end;

function TIWBS4TabControl.get_HasName: Boolean;
begin
  Result := inherited HasName;
end;

function TIWBS4TabControl.get_UseFrame: Boolean;
begin
  Result := inherited UseFrame;
end;

procedure TIWBS4TabControl.set_UseFrame(AValue: Boolean);
begin
  inherited UseFrame := AValue;
end;

function TIWBS4TabControl.get_HTMLWidth: Integer;
begin
  Result := inherited HTMLWidth;
end;

function TIWBS4TabControl.get_HTMLHeight: Integer;
begin
  Result := inherited HTMLHeight;
end;

function TIWBS4TabControl.get_HTMLLeft: Integer;
begin
  Result := ControlImplementation.GetHTMLLeft;
end;

function TIWBS4TabControl.get_HTMLTop: Integer;
begin
  Result := ControlImplementation.GetHTMLTop;
end;

function TIWBS4TabControl.get_ZIndex: Integer;
begin
  Result := ControlImplementation.GetZIndex;
end;

procedure TIWBS4TabControl.set_ZIndex(AValue: Integer);
begin
  ControlImplementation.SetZIndex(AValue);
end;

function TIWBS4TabControl.get_RenderSize: Boolean;
begin
  Result := ControlImplementation.GetRenderSize;
end;

procedure TIWBS4TabControl.set_RenderSize(AValue: Boolean);
begin
  // Constant
end;

function TIWBS4TabControl.get_StyleRenderOptions: TIWStyleRenderOptions;
begin
  Result := ControlImplementation.GetStyleRenderOptions;
end;

procedure TIWBS4TabControl.set_StyleRenderOptions(AValue: TIWStyleRenderOptions);
begin
  ControlImplementation.SetStyleRenderOptions(AValue);
end;

function TIWBS4TabControl.get_ScriptEvents: TIWScriptEvents;
begin
  Result := ControlImplementation.GetScriptEvents;
end;

procedure TIWBS4TabControl.set_ScriptEvents(AValue: TIWScriptEvents);
begin
  ControlImplementation.SetScriptEvents(AValue);
end;

function TIWBS4TabControl.get_Css: string;
begin
  Result := ControlImplementation.GetCss;
end;

procedure TIWBS4TabControl.set_Css(const AValue: string);
begin
  ControlImplementation.SetCss(AValue);
end;

function TIWBS4TabControl.get_SkinId: string;
begin
  Result := ControlImplementation.getSkinId;
end;

procedure TIWBS4TabControl.set_SkinId(const AValue: string);
begin
  ControlImplementation.setSkinId(AValue);
end;

function TIWBS4TabControl.get_WebCursor: TIWCursor;
begin
  Result := ControlImplementation.GetCursor;
end;

procedure TIWBS4TabControl.set_WebCursor(AValue: TIWCursor);
begin
  ControlImplementation.SetCursor(AValue);
end;

procedure TIWBS4TabControl.set_WebFont(AValue: TIWFont);
begin
  ControlImplementation.Font := AValue;
end;

function TIWBS4TabControl.get_WebFont: TIWFont;
begin
  Result := ControlImplementation.Font;
end;

function TIWBS4TabControl.get_ExtraTagParams: TStringList;
begin
  Result := ControlImplementation.get_ExtraTagParams;
end;

procedure TIWBS4TabControl.set_ExtraTagParams(const Value: TStringList);
begin
  ControlImplementation.set_ExtraTagParams(Value);
end;

function TIWBS4TabControl.get_OnHTMLTag: TIWOnHTMLTag;
begin
  Result := ControlImplementation.OnHTMLTag;
end;

procedure TIWBS4TabControl.set_OnHTMLTag(AValue: TIWOnHTMLTag);
begin
  ControlImplementation.setOnHTMLTag(AValue);
end;
// deprecated
function TIWBS4TabControl.get_SupportsPartial: Boolean;
begin
  Result := False;
end;

procedure TIWBS4TabControl.set_SupportsPartial(AValue: Boolean);
begin
  // deprecated property
end;
{$ENDREGION}

initialization
  gIWBS4LibDynamicTabs := True;

end.

