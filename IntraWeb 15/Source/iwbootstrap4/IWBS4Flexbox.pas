unit IWBS4Flexbox;
// Todo: add the repsonsive options

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, Controls, Forms, StrUtils, IWApplication, IWHTMLContainer,
  IWBaseRenderContext, IWContainer, IWControl, IWBaseHTMLInterfaces, IWRegion,
  IWBaseHTMLControl, IWHTML40Container, IWHTMLTag, IWBaseInterfaces, IWXMLTag,
  IWScriptEvents, IWFont, IWTypes, IWRenderContext, IWBS4Typography,
  IWBS4CustomEvents, IWBS4CommonInterfaces, IWBS4LayoutMgr, IWBS4Common,
  IWBS4Color;
// Direction (default and row are the same thing, but row can be specified by specifying nothing)

type
  TIWBS4FlexDirection = (bs4fdDefault, bs4fdRow, bs4fdRowReverse, bs4fdColumn, bs4fdColumnReverse);

const
  aIWBS4FlexDirection: array[bs4fdDefault..bs4fdColumnReverse] of string = ('', 'flex-row', 'flex-row-reverse', 'flex-column', 'flex-column-reverse');
// Justify Content (default = start)

type
  TIWBS4JustifyContent = (bs4jcDefault, bs4jcStart, bs4jcEnd, bs4jcCenter, bs4jcBetween, bs4jcAround);

const
  aIWBS4JustifyContent: array[bs4jcDefault..bs4jcAround] of string = ('', 'justify-content-start', 'justify-content-end', 'justify-content-center', 'justify-content-between', 'justify-content-around');
// Align Items

type
  TIWBS4AlignItems = (bs4aiNone, bs4aiStart, bs4aiEnd, bs4aiCenter, bs4aiBaseline, bs4aiStretch);

const
  aIWBS4AlignItems: array[bs4aiNone..bs4aiStretch] of string = ('', 'align-items-start', 'align-items-end', 'align-items-center', 'align-items-baseline', 'align-items-stretch');
// Wrap (nowrap is the default, which can be explicit or implicit)

type
  TIWBS4FlexboxWrap = (bs4wrDefault, bs4wrNoWrap, bs4wrWrap, bs4wrWrapReverse);

const
  aIWBS4FlexboxWrap: array[bs4wrDefault..bs4wrWrapReverse] of string = ('', 'flex-nowrap', 'flex-wrap', 'flex-wrap-reverse');
// Align Content

type
  TIWBS4AlignContent = (bs4acNone, bs4acStart, bs4acEnd, bs4acCenter, bs4acBetween, bs4acAround, bs4acStretch);

const
  aIWBS4AlignContent: array[bs4acNone..bs4acStretch] of string = ('', 'align-content-start', 'align-content-end', 'align-content-center', 'align-content-between', 'align-content-around', 'align-content-stretch');

type
  {$include IWPlatformAttrib.inc}
  TIWBS4Flexbox = class(TIWCustomRegion, IIWBS4Component, IIWBS4Container)
  private
    FIsInline: Boolean;
    FDirection: TIWBS4FlexDirection;
    FJustifyContent: TIWBS4JustifyContent;
    FAlignItems: TIWBS4AlignItems;
    FWrap: TIWBS4FlexboxWrap;
    FAlignContent: TIWBS4AlignContent;
    FPerfectCenter: Boolean;
    FHeightRender: Boolean;
    FBSBackground: TIWBS4Background;
    FOldCss: string;
    FOldStyle: string;
    FOldVisible: Boolean;
    FAsyncRefreshControl: Boolean;
    FRendered: Boolean;
    FCustomAsyncEvents: TIWBS4CustomAsyncEvents;
    FCustomRestEvents: TIWBS4CustomRestEvents;
    FCss: string;
    FScript: TStringList;
    FScriptInsideTag: Boolean;
    FScriptParams: TIWBS4ScriptParams;
    FStyle: TStringList;
    FReleased: Boolean;
    FText: string;
    FRawText: Boolean;
    FOnAfterRender: TNotifyEvent;
    FOnAfterAsyncChange: TNotifyEvent;
    function HTMLControlImplementation: TIWHTMLControlImplementation;
    function RegionDiv: TIWHTMLTag;
    function RenderText: string;
    procedure OnScriptChange(ASender: TObject);
    procedure OnStyleChange(ASender: TObject);
    function GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
    procedure SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
    function GetCustomRestEvents: TIWBS4CustomRestEvents;
    procedure SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
    function GetScript: TStringList;
    procedure SetScript(const AValue: TStringList);
    function GetScriptParams: TIWBS4ScriptParams;
    procedure SetScriptParams(const AValue: TIWBS4ScriptParams);
    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    function GetScriptInsideTag: Boolean;
    procedure SetScriptInsideTag(const Value: Boolean);
    function GetAfterRender: TNotifyEvent;
    procedure SetAfterRender(const Value: TNotifyEvent);
    procedure SetRawText(const Value: Boolean);
    procedure SetText(const Value: string);
    procedure SetCss(const Value: string);
    {$IFNDEF IW_14_1_0_UP}
    function IsScriptEventsStored: Boolean; virtual;
    function get_ScriptEvents: TIWScriptEvents;
    procedure set_ScriptEvents(const Value: TIWScriptEvents);
    {$ENDIF}
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
    procedure SetPerfectCenter(const Value: Boolean);
  protected
    FMainID: string;
    FRegionDiv: TIWHTMLTag;
    FTagName: string;
    {$hints off}
    function get_Visible: Boolean; override;
    procedure set_Visible(Value: Boolean); override;
    procedure SetParent(AParent: TWinControl); override;
    {$hints on}
    function get_HTMLName: string; override;
    function ContainerPrefix: string; override;
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
     // <css> \\
    procedure InternalRenderCss(var ACss: string); virtual;
    //  </css> \\
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); virtual;
    procedure InternalRenderStyle(AStyle: TStringList); virtual;
    property Released: Boolean read FReleased;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    procedure RenderScripts(AComponentContext: TIWCompContext); override;
    function RenderStyle(AContext: TIWCompContext): string; override;
    function SupportsInput: Boolean;
    procedure IWComponentsChanged(AComponent: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // Lets you destroy the region inside a self event handler
    procedure Release;
    procedure AsyncRefreshControl;
    procedure ResetAsyncRefreshControl;
    procedure AsyncRemoveControl;
    procedure ApplyAsyncChanges;
    function GetCssString: string;
    function GetRoleString: string; virtual;
    function IsStoredCustomAsyncEvents: Boolean;
    function IsStoredCustomRestEvents: Boolean;
    function JQSelector: string;
    procedure SetFocus; override;
    property TagType: string read FTagName;
  published
    property IsInline: Boolean read FIsInline write FIsInline default False;
    property Direction: TIWBS4FlexDirection read FDirection write FDirection default bs4fdDefault;
    property JustifyContent: TIWBS4JustifyContent read FJustifyContent write FJustifyContent default bs4jcDefault;
    property AlignItems: TIWBS4AlignItems read FAlignItems write FAlignItems default bs4aiNone;
    property Wrap: TIWBS4FlexboxWrap read FWrap write FWrap default bs4wrDefault;
    property AlignContent: TIWBS4AlignContent read FAlignContent write FAlignContent default bs4acNone;
    property PerfectCenter: Boolean read FPerfectCenter write SetPerfectCenter default False;
    property HeightRender: Boolean read FHeightRender write FHeightRender default False;
    property BSBackground: TIWBS4Background read FBSBackground write FBSBackground default bs4bgNone;
    property Align;
    property ClipRegion default False;
    property CustomAsyncEvents: TIWBS4CustomAsyncEvents read GetCustomAsyncEvents write SetCustomAsyncEvents stored IsStoredCustomAsyncEvents;
    property CustomRestEvents: TIWBS4CustomRestEvents read GetCustomRestEvents write SetCustomRestEvents stored IsStoredCustomRestEvents;
    property Css: string read FCss write SetCss;
    property ExtraTagParams;
    property LayoutMgr;
    property RawText: Boolean read FRawText write SetRawText default False;
    property RenderInvisibleControls default True;
    property ScriptEvents {$IFNDEF IW_14_1_0_UP}: TIWScriptEvents read get_ScriptEvents write set_ScriptEvents stored IsScriptEventsStored {$ENDIF};
    property Script: TStringList read GetScript write SetScript;
    property ScriptInsideTag: Boolean read GetScriptInsideTag write SetScriptInsideTag default True;
    property ScriptParams: TIWBS4ScriptParams read GetScriptParams write SetScriptParams;
    property Style: TStringList read GetStyle write SetStyle;
    property Text: string read FText write SetText;
    property ZIndex default 0;
    // Occurs after component is rendered.
    property OnAfterRender: TNotifyEvent read GetAfterRender write SetAfterRender;
    // Occurs after component is changed on an Asyn call, it doesn't occurs if the control is fully rendered
    property OnAfterAsyncChange: TNotifyEvent read FOnAfterAsyncChange write FOnAfterAsyncChange;
    property OnHTMLTag;
  end;

implementation

uses
  IWBS4Utils, IWBS4ScriptEvents, IWBS4Global;

type
  TIWContainerHack = class(TIWContainer);

constructor TIWBS4Flexbox.Create(AOwner: TComponent);
begin
  inherited;
  FTagName := 'div';
  FIsInline := False;
  FDirection := bs4fdDefault;
  FJustifyContent := bs4jcDefault;
  FAlignItems := bs4aiNone;
  FWrap := bs4wrDefault;
  FAlignContent := bs4acNone;
  FPerfectCenter := False;
  FHeightRender := False;
  FAsyncRefreshControl := False;
  FRendered := False;
  FReleased := False;
  FCustomAsyncEvents := nil;
  FCustomRestEvents := nil;
  FCss := '';
  FMainID := '';
  FScript := TStringList.Create;
  FScript.OnChange := OnScriptChange;
  FScriptInsideTag := True;
  FScriptParams := TIWBS4ScriptParams.Create;
  FScriptParams.OnChange := OnScriptChange;
  FStyle := TStringList.Create;
  FStyle.OnChange := OnStyleChange;
  FStyle.NameValueSeparator := ':';
  ClipRegion := False;
  RenderInvisibleControls := True;
  ZIndex := 0;
  if name = '' then
  begin
    name := IWBS4GetUniqueComponentName(Owner, Copy(ClassName, 2, MaxInt));
  end;
end;

destructor TIWBS4Flexbox.Destroy;
begin
  FreeAndNil(FCustomAsyncEvents);
  FreeAndNil(FCustomRestEvents);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);
  inherited;
end;
{$IFNDEF IW_14_1_0_UP}

function TIWBS4Flexbox.get_ScriptEvents: TIWScriptEvents;
begin
  Result := inherited get_ScriptEvents;
end;

procedure TIWBS4Flexbox.set_ScriptEvents(const Value: TIWScriptEvents);
begin
  inherited set_ScriptEvents(Value);
end;

function TIWBS4Flexbox.IsScriptEventsStored: Boolean;
begin
  Result := ScriptEvents.Count > 0;
end;
{$ENDIF}

function TIWBS4Flexbox.get_Visible: Boolean;
begin
  if (Parent is TFrame) and (Name = 'IWFrameRegion') then
    Result := Parent.Visible
  else
    Result := inherited;
end;

procedure TIWBS4Flexbox.set_Visible(Value: Boolean);
begin
  inherited;
  if (Parent is TFrame) and (Name = 'IWFrameRegion') and (Parent.Visible <> Value) then
  begin
    Parent.Visible := Value;
  end;
end;

procedure TIWBS4Flexbox.SetParent(AParent: TWinControl);
begin
  inherited;
  if (Parent is TFrame) and (Name <> 'IWFrameRegion') and (Parent.FindComponent('IWFrameRegion') = nil) then
  begin
    Name := 'IWFrameRegion';
  end;
end;

procedure TIWBS4Flexbox.SetPerfectCenter(const Value: Boolean);
begin
  FPerfectCenter := Value;
  FJustifyContent := bs4jcCenter;
  FAlignItems := bs4aiCenter;
end;

procedure TIWBS4Flexbox.SetRawText(const Value: Boolean);
begin
  FRawText := Value;
  AsyncRefreshControl;
end;

function TIWBS4Flexbox.JQSelector: string;
begin
  Result := '$("#' + HTMLName + '")';
end;

procedure TIWBS4Flexbox.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBS4Flexbox.ResetAsyncRefreshControl;
begin
  FAsyncRefreshControl := False;
end;

procedure TIWBS4Flexbox.ApplyAsyncChanges;
begin
  if FAsyncRefreshControl or not FRendered then
  begin
    raise Exception.Create('Cannot apply changes now, control should be full refreshed');
  end;
  RenderAsync(nil);
  DoRefreshControl := False;
end;

procedure TIWBS4Flexbox.AsyncRemoveControl;
begin
  TIWBS4Common.AsyncRemoveControl(FMainID);
  FAsyncRefreshControl := False;
  FRendered := False;
end;

procedure TIWBS4Flexbox.Release;
var
  LWebApplication: TIWApplication;
begin
  if Released then
    Exit;
  FReleased := True;
  Hide;
  LWebApplication := GGetWebApplicationThreadVar;
  if LWebApplication <> nil then
  begin
    if Parent is TFrame then
      LWebApplication.ReleaseForm(Parent)
    else
      LWebApplication.ReleaseForm(Self);
  end;
end;

procedure TIWBS4Flexbox.SetFocus;
begin
  IWBS4ExecuteAsyncJScript(JQSelector + '.focus()');
end;

function TIWBS4Flexbox.GetRoleString: string;
begin
  Result := '';
end;

procedure TIWBS4Flexbox.OnScriptChange(ASender: TObject);
begin
  AsyncRefreshControl;
end;

procedure TIWBS4Flexbox.OnStyleChange(ASender: TObject);
begin
  Invalidate;
end;

function TIWBS4Flexbox.GetAfterRender: TNotifyEvent;
begin
  Result := FOnAfterRender;
end;

function TIWBS4Flexbox.GetCssString: string;
begin
  Result := RenderCSSClass(nil);
end;

function TIWBS4Flexbox.GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
begin
  if FCustomAsyncEvents = nil then
  begin
    FCustomAsyncEvents := TIWBS4CustomAsyncEvents.Create(Self);
  end;
  Result := FCustomAsyncEvents;
end;

function TIWBS4Flexbox.GetCustomRestEvents: TIWBS4CustomRestEvents;
begin
  if FCustomRestEvents = nil then
  begin
    FCustomRestEvents := TIWBS4CustomRestEvents.Create(Self);
  end;
  Result := FCustomRestEvents;
end;

procedure TIWBS4Flexbox.SetAfterRender(const Value: TNotifyEvent);
begin
  FOnAfterRender := Value;
end;

procedure TIWBS4Flexbox.SetCss(const Value: string);
begin
  FCss := Value;
  Invalidate;
end;

procedure TIWBS4Flexbox.SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
begin
  FCustomAsyncEvents.Assign(Value);
end;

procedure TIWBS4Flexbox.SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
begin
  FCustomRestEvents.Assign(Value);
end;

function TIWBS4Flexbox.IsStoredCustomAsyncEvents: Boolean;
begin
  Result := (FCustomAsyncEvents <> nil) and (FCustomAsyncEvents.Count > 0);
end;

function TIWBS4Flexbox.IsStoredCustomRestEvents: Boolean;
begin
  Result := (FCustomRestEvents <> nil) and (FCustomRestEvents.Count > 0);
end;

procedure TIWBS4Flexbox.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;

procedure TIWBS4Flexbox.SetScriptInsideTag(const Value: Boolean);
begin
  FScriptInsideTag := Value;
end;

procedure TIWBS4Flexbox.SetScriptParams(const AValue: TIWBS4ScriptParams);
begin
  FScriptParams.Assign(AValue);
end;

function TIWBS4Flexbox.GetScript: TStringList;
begin
  Result := FScript;
end;

function TIWBS4Flexbox.GetScriptInsideTag: Boolean;
begin
  Result := FScriptInsideTag;
end;

function TIWBS4Flexbox.GetScriptParams: TIWBS4ScriptParams;
begin
  Result := FScriptParams;
end;

function TIWBS4Flexbox.GetStyle: TStringList;
begin
  Result := FStyle;
end;

procedure TIWBS4Flexbox.SetStyle(const AValue: TStringList);
begin
  FStyle.Assign(AValue);
end;

procedure TIWBS4Flexbox.SetText(const Value: string);
begin
  FText := TrimRight(Value);
  AsyncRefreshControl;
end;

function TIWBS4Flexbox.ContainerPrefix: string;
begin
  if Owner is TFrame then
    Result := UpperCase(TFrame(Owner).Name)
  else if isBaseContainer(Parent) then
    Result := BaseContainerInterface(Parent).ContainerPrefix
  else
    Result := UpperCase(Name);
end;

function TIWBS4Flexbox.HTMLControlImplementation: TIWHTMLControlImplementation;
begin
  Result := ControlImplementation;
end;

function TIWBS4Flexbox.RegionDiv: TIWHTMLTag;
begin
  Result := FRegionDiv;
end;

function TIWBS4Flexbox.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  if not (Self.LayoutMgr is TIWBS4LayoutMgr) then
  begin
    Self.LayoutMgr := TIWBS4LayoutMgr.Create(Self);
  end;
  Result := inherited;
end;

function TIWBS4Flexbox.SupportsInput: Boolean;
begin
  Result := False;
end;

procedure TIWBS4Flexbox.IWComponentsChanged(AComponent: TComponent);

  procedure NotifyParentContainer(AParent: TWinControl);
  begin
    if AParent is TIWContainer then
      TIWContainerHack(AParent).IWComponentsChanged(AComponent)
    else if AParent.Parent <> nil then
      NotifyParentContainer(AParent.Parent);
  end;

begin
  if not (csDestroying in ComponentState) and Assigned(Parent) then
  begin
    NotifyParentContainer(Parent);
  end;
end;

procedure TIWBS4Flexbox.InternalRenderCss(var ACss: string);
begin
  // Core Flex Class
  if FIsInline then
    TIWBS4Common.AddCssClass(ACss, 'd-inline-flex')
  else
    TIWBS4Common.AddCssClass(ACss, 'd-flex');
  // Flex Direction
  if FDirection <> bs4fdDefault then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4FlexDirection[FDirection]);
  end;
  // Justify Content
  if FJustifyContent <> bs4jcDefault then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4JustifyContent[FJustifyContent]);
  end;
  // Align Items
  if FAlignItems <> bs4aiNone then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4AlignItems[FAlignItems]);
  end;
  // Background
  if FBSBackground <> bs4bgNone then
  begin
    TIWBS4Common.AddCssClass(ACss, 'bg-' + aIWBS4Background[FBSBackground]);
  end;
  // Wrap
  if FWrap <> bs4wrDefault then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4FlexboxWrap[FWrap]);
  end;
  // Align Items
  if FAlignContent <> bs4acNone then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4AlignContent[FAlignContent]);
  end;
end;

procedure TIWBS4Flexbox.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  //
end;

procedure TIWBS4Flexbox.InternalRenderStyle(AStyle: TStringList);
begin
  //
end;

function TIWBS4Flexbox.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
var
  xHTMLName: string;
  xApplication: TIWApplication;
begin
  Result := nil;
  xHTMLName := HTMLName;
  if FAsyncRefreshControl or not FRendered then
  begin
    TIWBS4RegionCommon.CancelChildAsyncRender(Self);
    TIWBS4Common.RenderAsync(xHTMLName, Self, AContext);
  end
  else
  begin
    if AContext = nil then
      xApplication := GGetWebApplicationThreadVar
    else
      xApplication := AContext.WebApplication;
    TIWBS4Common.SetAsyncClass(xApplication, xHTMLName, RenderCSSClass(nil), FOldCss);
    TIWBS4Common.SetAsyncStyle(xApplication, xHTMLName, RenderStyle(nil), FOldStyle);
    TIWBS4Common.SetAsyncVisible(xApplication, FMainID, Visible, FOldVisible);
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

procedure TIWBS4Flexbox.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  TIWBS4RegionCommon.RenderComponents(Self, AContainerContext, APageContext);
end;

function TIWBS4Flexbox.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  // Achtung -- figure out what this should be in the context of a table
  Result := ''; //FGridOptions.GetClassString;
  if FCss <> '' then
  begin
    if Result <> '' then
    begin
      Result := Result + ' ';
    end;
    Result := Result + FCss;
  end;
  InternalRenderCss(Result);
end;

function TIWBS4Flexbox.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;
 {if FHeightRender then
  begin
    AContext.AddStyle('height:' + IntToStr(Height) + 'px;');
  end;}
  FRegionDiv := TIWHTMLTag.CreateTag(FTagName);
  FRegionDiv.AddStringParam('id', HTMLName);
  FRegionDiv.AddClassParam(FOldCss);
  FRegionDiv.AddStringParam('role', GetRoleString);
  FRegionDiv.AddStringParam('style', RenderStyle(AContext));
  if FHeightRender then
  begin
    FRegionDiv.AddStringParam('style', 'height:' + IntToStr(Height) + 'px;' + RenderStyle(AContext));
  end;
  if FText <> '' then
  begin
    FRegionDiv.Contents.AddText(RenderText);
  end;
  IWBS4RenderScript(Self, AContext, FRegionDiv);
  FMainID := FRegionDiv.Params.Values['id'];
  if gIWBS4AttributeCmpName <> '' then
  begin
    FRegionDiv.Params.Values[gIWBS4AttributeCmpName] := name;
  end;
  Result := FRegionDiv;
  FAsyncRefreshControl := False;
  FRendered := True;
end;

procedure TIWBS4Flexbox.RenderScripts(AComponentContext: TIWCompContext);
begin
  //
end;

function TIWBS4Flexbox.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := TIWBS4Common.RenderStyle(Self);
end;

function TIWBS4Flexbox.RenderText: string;
var
  i: Integer;
  LLines: TStringList;
begin
  if RawText then
  begin
    LLines := TStringList.Create;
    try
      LLines.Text := FText;
      // replace params before custom events
      LLines.Text := TIWBS4Common.ReplaceParams(Self, LLines.Text);
      // replace inner events calls
      if IsStoredCustomAsyncEvents then
      begin
        for i := 0 to CustomAsyncEvents.Count - 1 do
        begin
          TIWBS4CustomAsyncEvent(CustomAsyncEvents.Items[i]).ParseParam(LLines);
        end;
      end;
      // replace inner events calls
      if IsStoredCustomRestEvents then
      begin
        for i := 0 to CustomRestEvents.Count - 1 do
        begin
          TIWBS4CustomRestEvent(CustomRestEvents.Items[i]).ParseParam(LLines);
        end;
      end;
      Result := LLines.Text;
    finally
      LLines.Free;
    end;
  end
  else
  begin
    Result := TIWBaseHTMLControl.TextToHTML(FText);
  end;
end;
{$REGION 'IIWBaseHTMLComponent and other interfaces required by old compilers (D2009)'}

function TIWBS4Flexbox.get_HTMLName: string;
begin
  Result := ControlImplementation.HTMLName;
end;

function TIWBS4Flexbox.get_Clip: Boolean;
begin
  Result := inherited ClipRegion;
end;

procedure TIWBS4Flexbox.set_Clip(AValue: Boolean);
begin
  inherited ClipRegion := AValue;
end;

function TIWBS4Flexbox.get_HasName: Boolean;
begin
  Result := inherited HasName;
end;

function TIWBS4Flexbox.get_UseFrame: Boolean;
begin
  Result := inherited UseFrame;
end;

procedure TIWBS4Flexbox.set_UseFrame(AValue: Boolean);
begin
  inherited UseFrame := AValue;
end;

function TIWBS4Flexbox.get_HTMLWidth: Integer;
begin
  Result := inherited HTMLWidth;
end;

function TIWBS4Flexbox.get_HTMLHeight: Integer;
begin
  Result := inherited HTMLHeight;
end;

function TIWBS4Flexbox.get_HTMLLeft: Integer;
begin
  Result := ControlImplementation.GetHTMLLeft;
end;

function TIWBS4Flexbox.get_HTMLTop: Integer;
begin
  Result := ControlImplementation.GetHTMLTop;
end;

function TIWBS4Flexbox.get_ZIndex: Integer;
begin
  Result := ControlImplementation.GetZIndex;
end;

procedure TIWBS4Flexbox.set_ZIndex(AValue: Integer);
begin
  ControlImplementation.SetZIndex(AValue);
end;

function TIWBS4Flexbox.get_RenderSize: Boolean;
begin
  Result := ControlImplementation.GetRenderSize;
end;

procedure TIWBS4Flexbox.set_RenderSize(AValue: Boolean);
begin
  // Constant
end;

function TIWBS4Flexbox.get_StyleRenderOptions: TIWStyleRenderOptions;
begin
  Result := ControlImplementation.GetStyleRenderOptions;
end;

procedure TIWBS4Flexbox.set_StyleRenderOptions(AValue: TIWStyleRenderOptions);
begin
  ControlImplementation.SetStyleRenderOptions(AValue);
end;

function TIWBS4Flexbox.get_ScriptEvents: TIWScriptEvents;
begin
  Result := ControlImplementation.GetScriptEvents;
end;

procedure TIWBS4Flexbox.set_ScriptEvents(AValue: TIWScriptEvents);
begin
  ControlImplementation.SetScriptEvents(AValue);
end;

function TIWBS4Flexbox.get_Css: string;
begin
  Result := ControlImplementation.GetCss;
end;

procedure TIWBS4Flexbox.set_Css(const AValue: string);
begin
  ControlImplementation.SetCss(AValue);
end;

function TIWBS4Flexbox.get_SkinId: string;
begin
  Result := ControlImplementation.getSkinId;
end;

procedure TIWBS4Flexbox.set_SkinId(const AValue: string);
begin
  ControlImplementation.setSkinId(AValue);
end;

function TIWBS4Flexbox.get_WebCursor: TIWCursor;
begin
  Result := ControlImplementation.GetCursor;
end;

procedure TIWBS4Flexbox.set_WebCursor(AValue: TIWCursor);
begin
  ControlImplementation.SetCursor(AValue);
end;

procedure TIWBS4Flexbox.set_WebFont(AValue: TIWFont);
begin
  ControlImplementation.Font := AValue;
end;

function TIWBS4Flexbox.get_WebFont: TIWFont;
begin
  Result := ControlImplementation.Font;
end;

function TIWBS4Flexbox.get_ExtraTagParams: TStringList;
begin
  Result := ControlImplementation.get_ExtraTagParams;
end;

procedure TIWBS4Flexbox.set_ExtraTagParams(const Value: TStringList);
begin
  ControlImplementation.set_ExtraTagParams(Value);
end;

function TIWBS4Flexbox.get_OnHTMLTag: TIWOnHTMLTag;
begin
  Result := ControlImplementation.OnHTMLTag;
end;

procedure TIWBS4Flexbox.set_OnHTMLTag(AValue: TIWOnHTMLTag);
begin
  ControlImplementation.setOnHTMLTag(AValue);
end;
// deprecated

function TIWBS4Flexbox.get_SupportsPartial: Boolean;
begin
  Result := False;
end;

procedure TIWBS4Flexbox.set_SupportsPartial(AValue: Boolean);
begin
  // deprecated property
end;
{$ENDREGION}

end.

