unit IWBS4Cal;
interface
{$Include IWBootstrap4.inc}
uses
  SysUtils, Classes, Controls, Forms, StrUtils, IWApplication, IWHTMLContainer,
  IWBaseRenderContext, IWContainer, IWControl, IWBaseHTMLInterfaces, IWRegion,
  IWBaseHTMLControl, IWHTML40Container, IWHTMLTag, IWBaseInterfaces, IWXMLTag,
  IWScriptEvents, IWFont, IWTypes, IWRenderContext, IWBS4Color, IWBS4LayoutMgr,
  IWBS4CustomEvents, IWBS4CommonInterfaces, IWBS4Common;
type
  TIWBS4CalItems = class;
  TIWBS4Cal = class;

  TIWBS4CalItem = class(TCollectionItem)
  private
    FCal: TIWBS4Cal;
    FEventID: string;
    FEventTitle: string;
    FEventShort: string;
    FEventContextColor: TIWBS4Background;
    FEventOverrideColor: string;
    FEventStartDateTime: TDateTime;
    FEventDuration: Integer;
    FText: string;
    FCss: string;
    FActive: Boolean;
    FDisabled: Boolean;
    FOnAsyncClick: TIWAsyncEvent;
    function GetEventShort: string;
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    function Cal: TIWBS4Cal; virtual;
  //property Cal: TIWBS4Cal read GetCal;
  published
    property EventID: string read FEventID write FEventID;
    property EventTitle: string read FEventTitle write FEventTitle;
    property EventShort: string read GetEventShort write FEventShort;
    property EventContextColor: TIWBS4Background read FEventContextColor write FEventContextColor;
    property EventOverrideColor: string read FEventOverrideColor write FEventOverrideColor;
    property EventStartDateTime: TDateTime read FEventStartDateTime write FEventStartDateTime;
    property EventDuration: Integer read FEventDuration write FEventDuration;
    property Text: string read FText write FText;
    property Css: string read FCss write FCss;
    property Active: Boolean read FActive write FActive;
    property Disabled: Boolean read FDisabled write FDisabled;
    property OnAsyncClick: TIWAsyncEvent read FOnAsyncClick write FOnAsyncClick;
  end;


  TIWBS4CalItems = class(TOwnedCollection)

  private
    FOwner: TIWBS4Cal;
  //FCollectionString: string;
    function GetCalItem(Index: Integer): TIWBS4CalItem;
    procedure SetCalItem(Index: Integer; const Value: TIWBS4CalItem);
  public
    function CreateItemClass: TCollectionItemClass; virtual;
    constructor Create(AOwner: TComponent);
    function GetOwner: TPersistent; override;
    procedure Update(AItem: TCollectionItem); override;
    function Add: TIWBS4CalItem;
    property CalItems[Index: Integer]: TIWBS4CalItem read GetCalItem write SetCalItem; default;
  end;

  {$include IWPlatformAttrib.inc}
  TIWBS4Cal = class(TIWCustomRegion, IIWBS4Component, IIWBS4Container)
  private
    FOldCss: string;
    FOldStyle: string;
    FOldVisible: Boolean;
    FRendered: Boolean;
    FActiveMonth: Integer;
    FActiveYear: Integer;
    FBackgroundColors: TStringList;
    FCustomAsyncEvents: TIWBS4CustomAsyncEvents;
    FCustomRestEvents: TIWBS4CustomRestEvents;
    FCss: string;
    FScript: TStringList;
    FScriptInsideTag: Boolean;
    FScriptParams: TIWBS4ScriptParams;
    FStyle: TStringList;
    FReleased: Boolean;
    FText: string;
    FCollapseVisible: Boolean;
    FCollapse: Boolean;
    FRawText: Boolean;
    FBorderClass: TIWBS4Border;
    FBorderRounded: Boolean;
    FAnchorDate: TDateTime;
    FCalItems: TIWBS4CalItems;
    FHeightRender: Boolean;
    FWidthRender: Boolean;
    FSmall: Boolean;
    FOnAfterRender: TNotifyEvent;
    FOnAfterAsyncChange: TNotifyEvent;
    function HTMLControlImplementation: TIWHTMLControlImplementation;
    function RegionDiv: TIWHTMLTag;
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
    procedure SetCollapse(const Value: Boolean);
    procedure SetCollapseVisible(const Value: Boolean);
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
    procedure SetActiveMonth(const Value: Integer);
    procedure SetActiveYear(const Value: Integer);
    procedure SetCalItems(const Value: TIWBS4CalItems);
    function GetBackgroundColors: TStringList;
    procedure SetBackgroundColors(const Value: TStringList);
    function TranslateRowColumnToDateTime(ARowColumn: string): TDateTime;
    // deprecated
    function get_SupportsPartial: Boolean;
    procedure set_SupportsPartial(AValue: Boolean);
  protected
    FMainID: string;
    FRegionDiv: TIWHTMLTag;
    FTagName: string;
    FAsyncRefreshControl: Boolean;
    {$hints off}
    function get_Visible: Boolean; override;
    procedure set_Visible(Value: Boolean); override;
    procedure SetParent(AParent: TWinControl); override;
    {$hints on}
    function get_HTMLName: string; override;
    function ContainerPrefix: string; override;
    function InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext; override;
    // css \\
    procedure InternalRenderCss(var ACss: string); virtual;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); virtual;
    procedure InternalRenderStyle(AStyle: TStringList); virtual;
    property Released: Boolean read FReleased;
    function RenderAsync(AContext: TIWCompContext): TIWXMLTag; override;
    procedure RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext); override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    // html \\
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
    function RenderText: string;
    property TagType: string read FTagName;
    property OldCss: string read FOldCss write FOldCss;
    property OldStyle: string read FOldStyle write FOldStyle;
    property OldVisible: Boolean read FOldVisible write FOldVisible;
    property Rendered: Boolean read FRendered write FRendered;
  published
    property ActiveMonth: Integer read FActiveMonth write SetActiveMonth default 1;
    property ActiveYear: Integer read FActiveYear write SetActiveYear default 2019;
    property Align;
    property BackgroundColors: TStringList read GetBackgroundColors write SetBackgroundColors;
    property BorderClass: TIWBS4Border read FBorderClass write FBorderClass default bs4bdNone;
    property BorderRounded: Boolean read FBorderRounded write FBorderRounded default False;
    property CalItems: TIWBS4CalItems read FCalItems write SetCalItems;
    property ClipRegion default False;
    property CustomAsyncEvents: TIWBS4CustomAsyncEvents read GetCustomAsyncEvents write SetCustomAsyncEvents stored IsStoredCustomAsyncEvents;
    property CustomRestEvents: TIWBS4CustomRestEvents read GetCustomRestEvents write SetCustomRestEvents stored IsStoredCustomRestEvents;
    property Css: string read FCss write SetCss;
    property Collapse: Boolean read FCollapse write SetCollapse default False;
    property CollapseVisible: Boolean read FCollapseVisible write SetCollapseVisible default False;
    property ExtraTagParams;
    property HeightRender: Boolean read FHeightRender write FHeightRender;
    property LayoutMgr;
    property RawText: Boolean read FRawText write SetRawText default False;
    property RenderInvisibleControls default True;
    property ScriptEvents {$IFNDEF IW_14_1_0_UP}: TIWScriptEvents read get_ScriptEvents write set_ScriptEvents stored IsScriptEventsStored {$ENDIF};
    property Script: TStringList read GetScript write SetScript;
    property ScriptInsideTag: Boolean read GetScriptInsideTag write SetScriptInsideTag default True;
    property ScriptParams: TIWBS4ScriptParams read GetScriptParams write SetScriptParams;
    property Style: TStringList read GetStyle write SetStyle;
    property Text: string read FText write SetText;
    property WidthRender: Boolean read FWidthRender write FWidthRender;
    property Small: Boolean read FSmall write FSmall default False;
    property ZIndex default 0;
    // Occurs after component is rendered.
    property OnAfterRender: TNotifyEvent read GetAfterRender write SetAfterRender;
    // Occurs after component is changed on an Async call, it doesn't occurs if the control is fully rendered
    property OnAfterAsyncChange: TNotifyEvent read FOnAfterAsyncChange write FOnAfterAsyncChange;
    property OnHTMLTag;
  end;

implementation

uses DateUtils, IWBS4Utils, IWBS4ScriptEvents, IWBS4Global;

type
  TIWContainerHack = class(TIWContainer);

{ TIWBS4Cal }

constructor TIWBS4Cal.Create(AOwner: TComponent);
begin
  inherited;
  FActiveMonth := 1;
  FActiveYear := 2019;
  FBackgroundColors := TStringList.Create;
  FBackgroundColors.NameValueSeparator := '=';
  FAsyncRefreshControl := False;
  FRendered := False;
  FReleased := False;
  FBorderClass := bs4bdNone;
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
  FTagName := 'div';
  ClipRegion := False;
  RenderInvisibleControls := True;
  ZIndex := 0;
  if name = '' then
  begin
    name := IWBS4GetUniqueComponentName(Owner, Copy(ClassName, 2, MaxInt));
  end;
  // Cal Items
  FCalItems := TIWBS4CalItems.Create(Self);
end;
destructor TIWBS4Cal.Destroy;
begin
  FreeAndNil(FCustomAsyncEvents);
  FreeAndNil(FCustomRestEvents);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);
  FreeAndNil(FCalItems);
  FreeAndNil(FBackgroundColors);
  inherited;
end;
{$IFNDEF IW_14_1_0_UP}
function TIWBS4Cal.get_ScriptEvents: TIWScriptEvents;
begin
  Result := inherited get_ScriptEvents;
end;
procedure TIWBS4Cal.set_ScriptEvents(const Value: TIWScriptEvents);
begin
  inherited set_ScriptEvents(Value);
end;
function TIWBS4Cal.IsScriptEventsStored: Boolean;
begin
  Result := ScriptEvents.Count > 0;
end;
{$ENDIF}
function TIWBS4Cal.get_Visible: Boolean;
begin
  if (Parent is TFrame) and (Name = 'IWFrameRegion')
    then Result := Parent.Visible
    else Result := inherited;
end;
procedure TIWBS4Cal.set_Visible(Value: Boolean);
begin
  inherited;
  if (Parent is TFrame) and (Name = 'IWFrameRegion') and (Parent.Visible <> Value) then
  begin
    Parent.Visible := Value;
  end;
end;
procedure TIWBS4Cal.SetParent(AParent: TWinControl);
begin
  inherited;
  if (Parent is TFrame) and (Name <> 'IWFrameRegion') and (Parent.FindComponent('IWFrameRegion') = nil) then
  begin
    Name := 'IWFrameRegion';
  end;
end;
procedure TIWBS4Cal.SetRawText(const Value: Boolean);
begin
  FRawText := Value;
  AsyncRefreshControl;
end;
function TIWBS4Cal.JQSelector: string;
begin
  Result := '$("#' + HTMLName + '")';
end;
procedure TIWBS4Cal.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;
procedure TIWBS4Cal.ResetAsyncRefreshControl;
begin
  FAsyncRefreshControl := False;
end;
procedure TIWBS4Cal.ApplyAsyncChanges;
begin
  if FAsyncRefreshControl or not FRendered then
  begin
    raise Exception.Create('Cannot apply changes now, control should be full refreshed');
  end;
  RenderAsync(nil);
  DoRefreshControl := False;
end;
procedure TIWBS4Cal.AsyncRemoveControl;
begin
  TIWBS4Common.AsyncRemoveControl(FMainID);
  FAsyncRefreshControl := False;
  FRendered := False;
end;
procedure TIWBS4Cal.Release;
var
  LWebApplication: TIWApplication;
begin
  if Released then Exit;
  FReleased := True;
  Hide;
  LWebApplication := GGetWebApplicationThreadVar;
  if LWebApplication <> nil then
  begin
    if Parent is TFrame
      then LWebApplication.ReleaseForm(Parent)
      else LWebApplication.ReleaseForm(Self);
  end;
end;
procedure TIWBS4Cal.SetFocus;
begin
  IWBS4ExecuteAsyncJScript(JQSelector + '.focus()');
end;
function TIWBS4Cal.GetRoleString: string;
begin
  Result := '';
end;
procedure TIWBS4Cal.OnScriptChange(ASender: TObject);
begin
  AsyncRefreshControl;
end;
procedure TIWBS4Cal.OnStyleChange(ASender: TObject);
begin
  Invalidate;
end;
function TIWBS4Cal.GetAfterRender: TNotifyEvent;
begin
  Result := FOnAfterRender;
end;
function TIWBS4Cal.GetBackgroundColors: TStringList;
begin
  Result := FBackgroundColors;
end;

function TIWBS4Cal.GetCssString: string;
begin
  Result := RenderCSSClass(nil);
end;
function TIWBS4Cal.GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
begin
  if FCustomAsyncEvents = nil then
  begin
    FCustomAsyncEvents := TIWBS4CustomAsyncEvents.Create(Self);
  end;
  Result := FCustomAsyncEvents;
end;
function TIWBS4Cal.GetCustomRestEvents: TIWBS4CustomRestEvents;
begin
  if FCustomRestEvents = nil then
  begin
    FCustomRestEvents := TIWBS4CustomRestEvents.Create(Self);
  end;
  Result := FCustomRestEvents;
end;
procedure TIWBS4Cal.SetActiveMonth(const Value: Integer);
begin
  if (Value < 1) or (Value > 12) then
  begin
    raise Exception.Create('Invalid value for month');
  end;
  FActiveMonth := Value;
end;

procedure TIWBS4Cal.SetActiveYear(const Value: Integer);
begin
  if (Value < 1900) or (Value > 3000) then
  begin
    raise Exception.Create('Invalid value for year');
  end;
  FActiveYear := Value;
end;

procedure TIWBS4Cal.SetAfterRender(const Value: TNotifyEvent);
begin
  FOnAfterRender := Value;
end;
procedure TIWBS4Cal.SetBackgroundColors(const Value: TStringList);
begin
  FBackgroundColors.Assign(Value);
end;

procedure TIWBS4Cal.SetCalItems(const Value: TIWBS4CalItems);
begin
  if Value = nil
    then FreeAndNil(FCalItems)
    else FCalItems.Assign(Value);
end;

procedure TIWBS4Cal.SetCollapse(const Value: Boolean);
begin
  FCollapse := Value;
  Invalidate;
end;
procedure TIWBS4Cal.SetCollapseVisible(const Value: Boolean);
begin
  FCollapseVisible := Value;
  Invalidate;
end;
procedure TIWBS4Cal.SetCss(const Value: string);
begin
  FCss := Value;
  Invalidate;
end;
procedure TIWBS4Cal.SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
begin
  FCustomAsyncEvents.Assign(Value);
end;
procedure TIWBS4Cal.SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
begin
  FCustomRestEvents.Assign(Value);
end;
function TIWBS4Cal.IsStoredCustomAsyncEvents: Boolean;
begin
  Result := (FCustomAsyncEvents <> nil) and (FCustomAsyncEvents.Count > 0);
end;
function TIWBS4Cal.IsStoredCustomRestEvents: Boolean;
begin
  Result := (FCustomRestEvents <> nil) and (FCustomRestEvents.Count > 0);
end;
procedure TIWBS4Cal.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;
procedure TIWBS4Cal.SetScriptInsideTag(const Value: Boolean);
begin
  FScriptInsideTag := Value;
end;
procedure TIWBS4Cal.SetScriptParams(const AValue: TIWBS4ScriptParams);
begin
  FScriptParams.Assign(AValue);
end;
function TIWBS4Cal.GetScript: TStringList;
begin
  Result := FScript;
end;
function TIWBS4Cal.GetScriptInsideTag: Boolean;
begin
  Result := FScriptInsideTag;
end;
function TIWBS4Cal.GetScriptParams: TIWBS4ScriptParams;
begin
  Result := FScriptParams;
end;
function TIWBS4Cal.GetStyle: TStringList;
begin
  Result := FStyle;
end;
procedure TIWBS4Cal.SetStyle(const AValue: TStringList);
begin
  FStyle.Assign(AValue);
end;
procedure TIWBS4Cal.SetText(const Value: string);
begin
  FText := TrimRight(Value);
  AsyncRefreshControl;
end;
function TIWBS4Cal.ContainerPrefix: string;
begin
  if Owner is TFrame then
    Result := UpperCase(TFrame(Owner).Name)
  else
  if isBaseContainer(Parent) then
    Result := BaseContainerInterface(Parent).ContainerPrefix
  else
    Result := UpperCase(Name);
end;
function TIWBS4Cal.HTMLControlImplementation: TIWHTMLControlImplementation;
begin
  Result := ControlImplementation;
end;
function TIWBS4Cal.RegionDiv: TIWHTMLTag;
begin
  Result := FRegionDiv;
end;
function TIWBS4Cal.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  if not (Self.LayoutMgr is TIWBS4LayoutMgr) then
  begin
    Self.LayoutMgr := TIWBS4LayoutMgr.Create(Self);
  end;
  Result := inherited;
end;
function TIWBS4Cal.SupportsInput: Boolean;
begin
  Result := False;
end;
function TIWBS4Cal.TranslateRowColumnToDateTime(ARowColumn: string): TDateTime;
var
  Roe: Integer;
  Col: Integer;
begin
  Roe := StrToInt(ARowColumn[1]);
  Col := StrToInt(ARowColumn[2]);

  Result := FAnchorDate + ((Roe - 1) * 7) + (Col - 1);
end;

procedure TIWBS4Cal.IWComponentsChanged(AComponent: TComponent);
 procedure NotifyParentContainer(AParent: TWinControl);
 begin
   if AParent is TIWContainer then
     TIWContainerHack(AParent).IWComponentsChanged(AComponent)
   else
   if AParent.Parent <> nil then
   begin
     NotifyParentContainer(AParent.Parent);
   end;
 end;
begin
  if not (csDestroying in ComponentState) and Assigned(Parent) then
  begin
    NotifyParentContainer(Parent);
  end;
end;
procedure TIWBS4Cal.InternalRenderCss(var ACss: string);
begin
  if FCollapse then
  begin
    TIWBS4Common.AddCssClass(ACss, 'collapse');
    if FCollapseVisible then
    begin
      TIWBS4Common.AddCssClass(ACss, 'in');
    end;
  end;
  // Border
  if FBorderClass <> bs4bdNone then
  begin
    TIWBS4Common.AddCssClass(ACss, 'border border-' + aIWBS4Border[FBorderClass]);
  end;
  if FBorderRounded then
  begin
    TIWBS4Common.AddCssClass(ACss, 'rounded');
  end;
end;

procedure TIWBS4Cal.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  //
end;
procedure TIWBS4Cal.InternalRenderStyle(AStyle: TStringList);
begin
  //
end;
function TIWBS4Cal.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
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
  end else
  begin
    if AContext = nil
      then xApplication := GGetWebApplicationThreadVar
      else xApplication := AContext.WebApplication;
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
procedure TIWBS4Cal.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  TIWBS4RegionCommon.RenderComponents(Self, AContainerContext, APageContext);
end;
function TIWBS4Cal.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
  Result := '';
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
function TIWBS4Cal.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  HeaderSectionTag: TIWHTMLTag;
  HeaderHdrTag: TIWHTMLTag;
  RowTag: TIWHTMLTag;
  Col1Tag: TIWHTMLTag;
  Col2Tag: TIWHTMLTag;
  Col3Tag: TIWHTMLTag;
  BtnLeft: TIWHTMLTag;
  BtnRight: TIWHTMLTag;
  IconLeft: TIWHTMLTag;
  IconRight: TIWHTMLTag;
  Div1: TIWHTMLTag;
  H5: TIWHTMLTag;
  MonthDiv: TIWHTMLTag;
  AnchorClickTag: TIWHTMLTag;
  ClickDiv: TIWHTMLTag;
  WeekDiv: TIWHTMLTag;
  Span1Tag: TIWHTMLTag;
  SmallTag: TIWHTMLTag;
  Span2Tag: TIWHTMLTag;
  PeeTag: TIWHTMLTag;
  EventTag: TIWHTMLTag;
  AttachPoint: TIWHTMLTag;
  i: Integer;
  j: Integer;
  EventCtThisDay: Integer;
  RowNo: Integer;
  ColNo: Integer;
  ADate: TDateTime;
  BGColor: string;
  EventColor: string;
begin
  if FHeightRender then
  begin
    FStyle.Add('height:' + IntToStr(Height) + 'px');
  end;
  if FWidthRender then
  begin
    FStyle.Add('width:' + IntToStr(Width) + 'px');
  end;
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;
  // Create the Calendar inside this div
  FRegionDiv := TIWHTMLTag.CreateTag(FTagName);
  FRegionDiv.AddStringParam('id', HTMLName);
  FRegionDiv.AddClassParam(FOldCss);
  FRegionDiv.AddStringParam('role', GetRoleString);
  FRegionDiv.AddStringParam('style', RenderStyle(AContext));
  // The first visible date in the calendar is the Monday of the week containing the first day of the active month
  ADate := EncodeDate(FActiveYear, FActiveMonth, 1);
  if DayOfTheWeek(ADate) <> 1 then
  begin
    ADate := ADate - (DayOfTheWeek(ADate) - 1);
  end;
  FAnchorDate := ADate;
  // Header for the days of the week
  HeaderSectionTag := FRegionDiv.Contents.AddTag('header');
  // Put the title in a row so we have room for nav buttons
  RowTag := HeaderSectionTag.Contents.AddTag('div');
  RowTag.AddClassParam('row mb-1');
  Col1Tag := RowTag.Contents.AddTag('div');
  Col1Tag.AddClassParam('col-1');
  Col2Tag := RowTag.Contents.AddTag('div');
  Col2Tag.AddClassParam('col-10');
  if FSmall then
  begin
    HeaderHdrTag := Col2Tag.Contents.AddTag('h5');
    HeaderHdrTag.AddClassParam('mb-1 text-center');
  end else
  begin
    HeaderHdrTag := Col2Tag.Contents.AddTag('h4');
    HeaderHdrTag.AddClassParam('display-4 mb-4 text-center');
  end;
  HeaderHdrTag.Contents.AddText(FormatDateTime('mmmm yyyy', EncodeDate(FActiveYear, FActiveMonth, 1)));
  Col3Tag := RowTag.Contents.AddTag('div');
  Col3Tag.AddClassParam('col-1');
  // Columns 1 & 3 need buttons
  BtnLeft := Col1Tag.Contents.AddTag('button');
  BtnLeft.AddClassParam('btn btn-primary btn-sm');
  IconLeft := BtnLeft.Contents.AddTag('i');
  IconLeft.AddClassParam('fa fa-arrow-left');
  BtnRight := Col3Tag.Contents.AddTag('button');
  BtnRight.AddClassParam('btn btn-primary btn-sm');
  IconRight := BtnRight.Contents.AddTag('i');
  IconRight.AddClassParam('fa fa-arrow-right');

  Div1 := HeaderSectionTag.Contents.AddTag('div');
//Div1.AddClassParam('row d-none d-sm-flex p-1 bg-dark text-white');
  Div1.AddClassParam('row d-sm-flex p-1 bg-dark text-white');
  Div1.Contents.AddText(sLineBreak); // formatting
  for i := 1 to 7 do
  begin
    if FSmall
      then H5 := Div1.Contents.AddTag('h6')
      else H5 := Div1.Contents.AddTag('h5');
    H5.AddClassParam('col-sm p-1 text-center');
    if FSmall
      then H5.Contents.AddText(FormatDateTime('ddd', ADate + (i - 1)))
      else H5.Contents.AddText(FormatDateTime('dddd', ADate + (i - 1)));
  end;
  // Start with the day cells
  MonthDiv := FRegionDiv.Contents.AddTag('div');
  MonthDiv.AddClassParam('row border border-right-0 border-bottom-0');
  MonthDiv.Contents.AddText(sLineBreak);
  // Individual Day Blocks
  for i := 1 to 42 do
  begin
    // Critial for drag and drop: id
    RowNo := ((i - 1) div 7) + 1;
    ColNo := i mod 7;
    if ColNo = 0 then
    begin
      ColNo := 7;
    end;

    // The background will be bg-light unless override provided
    BGColor := 'bg-light';
    if FBackgroundColors.IndexOfName(IntToStr(RowNo) + IntToStr(ColNo)) <> -1 then
    begin
      BGColor := FBackgroundColors.ValueFromIndex[FBackgroundColors.IndexOfName(IntToStr(RowNo) + IntToStr(ColNo))];
    end;

    Div1 := MonthDiv.Contents.AddTag('div');
  //Div1.AddClassParam('day col-sm p-2 border border-left-0 border-top-0 text-truncate d-none d-sm-inline-block ' + BGColor + ' text-muted');
    Div1.AddClassParam('day col-sm p-2 border border-left-0 border-top-0 text-truncate d-sm-inline-block ' + BGColor + ' text-muted');
    Div1.AddStringParam('id', IntToStr(RowNo) + IntToStr(ColNo));
    // Drag and drop
    Div1.AddStringParam('ondrop', 'drop(event)');
    Div1.AddStringParam('ondragover', 'allowDrop(event)');
    // Small
    if FSmall then
    begin
      Div1.AddStringParam('style', 'height:55px');
    end;

    // Surround the div by an empty anchor to provide clickability
    if FSmall then
    begin
      AnchorClickTag := Div1.Contents.AddTag('a');
      AnchorClickTag.AddStringParam('href', '#');
      // Small
      if FSmall then
      begin
        AnchorClickTag.AddStringParam('style', 'height:55px');
      end;

      ClickDiv := AnchorClickTag.Contents.AddTag('div');
      ClickDiv.AddClassParam('w-100 h-100');

      AttachPoint := ClickDiv
    end else
    begin
      AttachPoint := Div1;
    end;

    if FSmall
      then H5 := AttachPoint.Contents.AddTag('h6')
      else H5 := AttachPoint.Contents.AddTag('h5');
    H5.AddClassParam('row align-items-center ' + BGColor); //bg-light');

    Span1Tag := H5.Contents.AddTag('span');
    if BGColor = 'bg-warning' then
    begin
      Span1Tag.AddClassParam('date col-1 text-dark');
    end else
    if (BGColor = 'bg-secondary') or (BGColor = 'bg-danger')
      then Span1Tag.AddClassParam('date col-1 text-white')
      else Span1Tag.AddClassParam('date col-1');
    Span1Tag.Contents.AddText(FormatDateTime('d', ADate));

    SmallTag := H5.Contents.AddTag('small');
    SmallTag.AddClassParam('col d-sm-none text-center text-muted');
    SmallTag.Contents.AddText(FormatDateTime('dddd', ADate));

    Span2Tag := H5.Contents.AddTag('span');
    Span2Tag.AddClassParam('col-1');

    // Loop thru all of the CalItems and see which belong here
    EventCtThisDay := 0;
    if not FSmall then
    begin
      for j := 0 to FCalItems.Count - 1 do
      begin
        if DateOf((FCalItems[j] as TIWBS4CalItem).FEventStartDateTime) =
           TranslateRowColumnToDateTime(IntToStr(RowNo) +  IntToStr(ColNo)) then
        begin
          if (FCalItems[j] as TIWBS4CalItem).FEventContextColor <> bs4bgNone
            then EventColor := aIWBS4Background[(FCalItems[j] as TIWBS4CalItem).FEventContextColor]
            else EventColor := 'primary';

          EventTag := Div1.Contents.AddTag('a');
          EventTag.AddClassParam('event d-block p-1 pl-2 pr-2 mb-1 rounded text-truncate small bg-' + EventColor + ' text-white');
          // Drag necessities
          EventTag.AddStringParam('draggable', 'true');
          EventTag.AddStringParam('ondragstart', 'drag(event)');
          // Event details
          EventTag.AddStringParam('id', 'ev_' + (FCalItems[j] as TIWBS4CalItem).FEventID);
          EventTag.AddStringParam('title', (FCalItems[j] as TIWBS4CalItem).EventShort);
          EventTag.Contents.AddText((FCalItems[j] as TIWBS4CalItem).EventShort);

          Inc(EventCtThisDay);
        end;
      end;
    end;


    // Temp add a sample event
   {if i = 3 then
    begin
      EventTag := Div1.Contents.AddTag('a');
      EventTag.AddClassParam('event d-block p-1 pl-2 pr-2 mb-1 rounded text-truncate small bg-info text-white');
      // Drag necessities
      EventTag.AddStringParam('draggable', 'true');
      EventTag.AddStringParam('ondragstart', 'drag(event)');
      // Event details
      EventTag.AddStringParam('id', 'ev1');
      EventTag.AddStringParam('title', 'Meet with Nancy');
      EventTag.Contents.AddText('Meet With Nancy');
    end else}
    if EventCtThisDay = 0 then
    begin
      PeeTag := Div1.Contents.AddTag('p');
      PeeTag.AddClassParam('d-sm-none');
      PeeTag.Contents.AddText('No events');
    end;

    // Every 7 days need to force new row
    if (i mod 7) = 0 then
    begin
      WeekDiv := MonthDiv.Contents.AddTag('div');
      WeekDiv.AddClassParam('w-100');
      WeekDiv.Contents.AddText(sLineBreak);
    end;

    ADate := ADate + 1;
  end;
 {if FText <> '' then
  begin
    FRegionDiv.Contents.AddText(RenderText);
  end;}
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
procedure TIWBS4Cal.RenderScripts(AComponentContext: TIWCompContext);
begin
  //
end;
function TIWBS4Cal.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := TIWBS4Common.RenderStyle(Self);
end;
function TIWBS4Cal.RenderText: string;
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
  end else
  begin
    Result := TIWBaseHTMLControl.TextToHTML(FText);
  end;
end;
// deprecated
function TIWBS4Cal.get_SupportsPartial: Boolean;
begin
  Result := False;
end;
procedure TIWBS4Cal.set_SupportsPartial(AValue: Boolean);
begin
  // deprecated property
end;
{$REGION 'IIWBaseHTMLComponent and other interfaces required by old compilers (D2009)'}
function TIWBS4Cal.get_HTMLName: string;
begin
  Result := ControlImplementation.HTMLName;
end;
function TIWBS4Cal.get_Clip: Boolean;
begin
  Result := inherited ClipRegion;
end;
procedure TIWBS4Cal.set_Clip(AValue: Boolean);
begin
  inherited ClipRegion := AValue;
end;
function TIWBS4Cal.get_HasName: Boolean;
begin
  Result := inherited HasName;
end;
function TIWBS4Cal.get_UseFrame: Boolean;
begin
  Result := inherited UseFrame;
end;
procedure TIWBS4Cal.set_UseFrame(AValue: Boolean);
begin
  inherited UseFrame := AValue;
end;
function TIWBS4Cal.get_HTMLWidth: Integer;
begin
  Result := inherited HTMLWidth;
end;
function TIWBS4Cal.get_HTMLHeight: Integer;
begin
  Result := inherited HTMLHeight;
end;
function TIWBS4Cal.get_HTMLLeft: Integer;
begin
  Result := ControlImplementation.GetHTMLLeft;
end;
function TIWBS4Cal.get_HTMLTop: Integer;
begin
  Result := ControlImplementation.GetHTMLTop;
end;
function TIWBS4Cal.get_ZIndex: Integer;
begin
  Result := ControlImplementation.GetZIndex;
end;
procedure TIWBS4Cal.set_ZIndex(AValue: Integer);
begin
  ControlImplementation.SetZIndex(AValue);
end;
function TIWBS4Cal.get_RenderSize: Boolean;
begin
  Result := ControlImplementation.GetRenderSize;
end;
procedure TIWBS4Cal.set_RenderSize(AValue: Boolean);
begin
  // Constant
end;
function TIWBS4Cal.get_StyleRenderOptions: TIWStyleRenderOptions;
begin
  Result := ControlImplementation.GetStyleRenderOptions;
end;
procedure TIWBS4Cal.set_StyleRenderOptions(AValue: TIWStyleRenderOptions);
begin
  ControlImplementation.SetStyleRenderOptions(AValue);
end;
function TIWBS4Cal.get_ScriptEvents: TIWScriptEvents;
begin
  Result := ControlImplementation.GetScriptEvents;
end;
procedure TIWBS4Cal.set_ScriptEvents(AValue: TIWScriptEvents);
begin
  ControlImplementation.SetScriptEvents(AValue);
end;
function TIWBS4Cal.get_Css: string;
begin
  Result := ControlImplementation.GetCss;
end;
procedure TIWBS4Cal.set_Css(const AValue: string);
begin
  ControlImplementation.SetCss(AValue);
end;
function TIWBS4Cal.get_SkinId: string;
begin
  Result := ControlImplementation.getSkinId;
end;
procedure TIWBS4Cal.set_SkinId(const AValue: string);
begin
  ControlImplementation.setSkinId(AValue);
end;
function TIWBS4Cal.get_WebCursor: TIWCursor;
begin
  Result := ControlImplementation.GetCursor;
end;
procedure TIWBS4Cal.set_WebCursor(AValue: TIWCursor);
begin
  ControlImplementation.SetCursor(AValue);
end;
procedure TIWBS4Cal.set_WebFont(AValue: TIWFont);
begin
  ControlImplementation.Font := AValue;
end;
function TIWBS4Cal.get_WebFont: TIWFont;
begin
  Result := ControlImplementation.Font;
end;
function TIWBS4Cal.get_ExtraTagParams: TStringList;
begin
  Result := ControlImplementation.get_ExtraTagParams;
end;
procedure TIWBS4Cal.set_ExtraTagParams(const Value: TStringList);
begin
  ControlImplementation.set_ExtraTagParams(Value);
end;
function TIWBS4Cal.get_OnHTMLTag: TIWOnHTMLTag;
begin
  Result := ControlImplementation.OnHTMLTag;
end;
procedure TIWBS4Cal.set_OnHTMLTag(AValue: TIWOnHTMLTag);
begin
  ControlImplementation.setOnHTMLTag(AValue);
end;
{$ENDREGION}
function TIWBS4CalItem.Cal: TIWBS4Cal;
begin
  Result := (Collection as TIWBS4CalItems).FOwner;
end;

constructor TIWBS4CalItem.Create(Collection: TCollection);
begin
  inherited;

  FCal := (Collection as TIWBS4CalItems).FOwner;

//FCalItems := TIWBS4CalItems.Create(Cal.Owner);
end;

procedure TIWBS4CalItem.Assign(Source: TPersistent);
begin
  if Source is TIWBS4CalItem then
  begin
    FEventID := TIWBS4CalItem(Source).EventID;
    FEventTitle := TIWBS4CalItem(Source).EventTitle;
    FEventShort := TIWBS4CalItem(Source).EventShort;
    FEventContextColor := TIWBS4CalItem(Source).EventContextColor;
    FEventOverrideColor := TIWBS4CalItem(Source).EventOverrideColor;
    FEventStartDateTime := TIWBS4CalItem(Source).EventStartDateTime;
    EventDuration := TIWBS4CalItem(Source).EventDuration;
    Text := TIWBS4CalItem(Source).Text;
    Css := TIWBS4CalItem(Source).Css;
    Disabled := TIWBS4CalItem(Source).Disabled;
    OnAsyncClick := TIWBS4CalItem(Source).OnAsyncClick;
  end else
  begin
    inherited;
  end;
end;

constructor TIWBS4CalItems.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TIWBS4CalItem);
//FOwner := AOwner;
end;

function TIWBS4CalItems.CreateItemClass: TCollectionItemClass;
begin
  Result := TIWBS4CalItem;
end;

function TIWBS4CalItems.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TIWBS4CalItems.Update(AItem: TCollectionItem);
begin
  inherited;
end;

function TIWBS4CalItem.GetDisplayName: string;
begin
  if FText <> ''
    then Result := FText
    else Result := 'TIWBS4CalItem' + IntToStr(Index);
end;

function TIWBS4CalItem.GetEventShort: string;
begin
  if FEventShort = ''
    then Result := FEventTitle
    else Result := FEventShort;
end;

function TIWBS4CalItems.GetCalItem(Index: Integer): TIWBS4CalItem;
begin
  Result := TIWBS4CalItem(inherited Items[Index]);
end;

procedure TIWBS4CalItems.SetCalItem(Index: Integer; const Value: TIWBS4CalItem);
begin
  Items[Index] := Value;
end;

function TIWBS4CalItems.Add: TIWBS4CalItem;
begin
  Result := TIWBS4CalItem(inherited Add);
end;

end.
