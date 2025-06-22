unit IWBS4Header;

interface

uses
  SysUtils, Classes, IWContainer, IWScriptEvents, IWTypes, IWFont,
  IWBaseHTMLInterfaces, IWControl, IWRegion, IWHTMLTag, IWRenderContext,
  IWBaseHTMLControl, IWBS4Common, IWBS4CommonInterfaces, IWBS4CustomRegion,
  IWBS4CustomEvents, IWBS4ScriptEvents, IWBS4Global, IWBS4Typography, IWBS4Color;

type
  TIWBS4HeaderTagType = (bs4httH1, bs4httH2, bs4httH3, bs4httH4, bs4httH5, bs4httH6);

const
  aIWBS4HeaderTagType: array[bs4httH1..bs4httH6] of string = ('h1', 'h2', 'h3', 'h4', 'h5', 'h6');

type
  TIWBS4HeaderDisplay = (bs4hdNone, bs4hdDisplay1, bs4hdDisplay2, bs4hdDisplay3, bs4hdDisplay4);

const
  aIWBS4HeaderDisplay: array[bs4hdNone..bs4hdDisplay4] of string = ('', 'display-1', 'display-2', 'display-3', 'display-4');

type
  {$include IWPlatformAttrib.inc}
  TIWBS4Header = class(TIWCustomRegion, IIWBS4Component, IIWBS4Container)
  private
    FTagType: TIWBS4HeaderTagType;       // h1, h2, etc
    FHeaderDisplay: TIWBS4HeaderDisplay; // display-1, display-2, etc
    FTextAlignment: TIWBS4TextAlignment; // text-center, text-right, etc
    FTextColor: TIWBS4TextColor;         // text-primary, text-warning, etc
    FOldCss: string;
    FOldStyle: string;
    FOldVisible: Boolean;
    FCss: string;
    FAsyncRefreshControl: Boolean;
    FRendered: Boolean;
    FOnAfterRender: TNotifyEvent;
    FCustomAsyncEvents: TIWBS4CustomAsyncEvents;
    FCustomRestEvents: TIWBS4CustomRestEvents;
    FScript: TStringList;
    FScriptInsideTag: Boolean;
    FScriptParams: TIWBS4ScriptParams;
    FStyle: TStringList;
    FText: string;
    FRawText: Boolean;
    FOnAfterAsyncChange: TNotifyEvent;
    function RegionDiv: TIWHTMLTag;
    function HTMLControlImplementation: TIWHTMLControlImplementation;
    function GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
    procedure SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
    function GetCustomRestEvents: TIWBS4CustomRestEvents;
    procedure SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
    function GetAfterRender: TNotifyEvent;
    procedure SetAfterRender(const Value: TNotifyEvent);
    function GetScript: TStringList;
    procedure SetScript(const AValue: TStringList);
    function GetScriptInsideTag: Boolean;
    procedure SetScriptInsideTag(const Value: Boolean);
    function GetScriptParams: TIWBS4ScriptParams;
    procedure SetScriptParams(const AValue: TIWBS4ScriptParams);
    function GetStyle: TStringList;
    procedure SetStyle(const AValue: TStringList);
    function RenderText: string;
    procedure SetRawText(const Value: Boolean);
    procedure SetText(const Value: string);
    procedure OnScriptChange(ASender: TObject);
    procedure OnStyleChange(ASender: TObject);
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
    FMainID: string;
    FRegionDiv: TIWHTMLTag;
    FTagName: string;
    function get_HTMLName: string; override;
    procedure InternalRenderCss(var ACss: string); virtual;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
    function RenderCSSClass(AComponentContext: TIWCompContext): string; override;
    procedure InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList); virtual;
    procedure InternalRenderStyle(AStyle: TStringList); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ResetAsyncRefreshControl;
    procedure AsyncRefreshControl;
    procedure AsyncRemoveControl;
    function JQSelector: string;
    function GetCssString: string;
    function IsStoredCustomAsyncEvents: Boolean;
    function IsStoredCustomRestEvents: Boolean;
    property TagName: string read FTagName;
  published
    property Align;
    property ExtraTagParams;
    property LayoutMgr;
    property RenderInvisibleControls default True;
    property ScriptEvents; //: TIWScriptEvents read get_ScriptEvents write set_ScriptEvents stored IsScriptEventsStored;
    property TagType: TIWBS4HeaderTagType read FTagType write FTagType default bs4httH1;
    property HeaderDisplay: TIWBS4HeaderDisplay read FHeaderDisplay write FHeaderDisplay default bs4hdNone;
    property TextAlignment: TIWBS4TextAlignment read FTextAlignment write FTextAlignment default bs4taNone;
    property TextColor: TIWBS4TextColor read FTextColor write FTextColor default bs4tcNone;
    property RawText: Boolean read FRawText write SetRawText default False;
    property Text: string read FText write SetText;
    property Script: TStringList read GetScript write SetScript;
    property ScriptInsideTag: Boolean read GetScriptInsideTag write SetScriptInsideTag default True;
    property ScriptParams: TIWBS4ScriptParams read GetScriptParams write SetScriptParams;
    property Style: TStringList read GetStyle write SetStyle;
    property ZIndex default 0;
    property CustomAsyncEvents: TIWBS4CustomAsyncEvents read GetCustomAsyncEvents write SetCustomAsyncEvents stored IsStoredCustomAsyncEvents;
    property CustomRestEvents: TIWBS4CustomRestEvents read GetCustomRestEvents write SetCustomRestEvents stored IsStoredCustomRestEvents;
    property ClipRegion default False;
    // Occurs after component is rendered.
    property OnAfterRender: TNotifyEvent read GetAfterRender write SetAfterRender;
    // Occurs after component is changed on an Asyn call, it doesn't occurs if the control is fully rendered
    property OnAfterAsyncChange: TNotifyEvent read FOnAfterAsyncChange write FOnAfterAsyncChange;
    property OnHTMLTag;
  end;

implementation

uses
  IWBS4Utils;

type
  TIWContainerHack = class(TIWContainer);

constructor TIWBS4Header.Create(AOwner: TComponent);
begin
  inherited;

  FAsyncRefreshControl := False;
  FRendered := False;
//FReleased := False;
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
  FTagName := 'h1';
  FTagType := bs4httH1;

  ClipRegion := False;
  RenderInvisibleControls := True;
  ZIndex := 0;
  if name = '' then
  begin
    name := IWBS4GetUniqueComponentName(Owner, Copy(ClassName, 2, MaxInt));
  end;
end;

destructor TIWBS4Header.Destroy;
begin
  FreeAndNil(FCustomAsyncEvents);
  FreeAndNil(FCustomRestEvents);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);

  inherited;
end;

procedure TIWBS4Header.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBS4Header.AsyncRemoveControl;
begin
  TIWBS4Common.AsyncRemoveControl(FMainID);
  FAsyncRefreshControl := False;
  FRendered := False;
end;

function TIWBS4Header.GetAfterRender: TNotifyEvent;
begin
  Result := FOnAfterRender;
end;

function TIWBS4Header.GetCssString: string;
begin
  Result := RenderCSSClass(nil);
end;

function TIWBS4Header.GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
begin
  if FCustomAsyncEvents = nil then
  begin
    FCustomAsyncEvents := TIWBS4CustomAsyncEvents.Create(Self);
  end;
  Result := FCustomAsyncEvents;
end;

function TIWBS4Header.GetCustomRestEvents: TIWBS4CustomRestEvents;
begin
  if FCustomRestEvents = nil then
  begin
    FCustomRestEvents := TIWBS4CustomRestEvents.Create(Self);
  end;
  Result := FCustomRestEvents;
end;

function TIWBS4Header.GetScript: TStringList;
begin
  Result := FScript;
end;

function TIWBS4Header.GetScriptInsideTag: Boolean;
begin
  Result := FScriptInsideTag;
end;

function TIWBS4Header.GetScriptParams: TIWBS4ScriptParams;
begin
  Result := FScriptParams;
end;

function TIWBS4Header.GetStyle: TStringList;
begin
  Result := FStyle;
end;

function TIWBS4Header.HTMLControlImplementation: TIWHTMLControlImplementation;
begin
  Result := ControlImplementation;
end;

procedure TIWBS4Header.InternalRenderCss(var ACss: string);
begin
  inherited;

  TIWBS4Common.AddCssClass(ACss, aIWBS4HeaderTagType[FTagType]);

  // Handle the new "display" classes
  if FHeaderDisplay <> bs4hdNone then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4HeaderDisplay[FHeaderDisplay]);
  end;

  // Text Direction
  if FTextAlignment <> bs4taNone then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4TextAlignment[FTextAlignment]);
  end;

  // Text Color
  if FTextColor <> bs4tcNone then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4TextColor[FTextColor]);
  end;
end;

procedure TIWBS4Header.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  //
end;

procedure TIWBS4Header.InternalRenderStyle(AStyle: TStringList);
begin
  //
end;

function TIWBS4Header.IsStoredCustomAsyncEvents: Boolean;
begin
  Result := (FCustomAsyncEvents <> nil) and (FCustomAsyncEvents.Count > 0);
end;

function TIWBS4Header.IsStoredCustomRestEvents: Boolean;
begin
  Result := (FCustomRestEvents <> nil) and (FCustomRestEvents.Count > 0);
end;

function TIWBS4Header.JQSelector: string;
begin
  Result := '$("#' + HTMLName + '")';
end;

procedure TIWBS4Header.OnScriptChange(ASender: TObject);
begin
  AsyncRefreshControl;
end;

procedure TIWBS4Header.OnStyleChange(ASender: TObject);
begin
  Invalidate;
end;

function TIWBS4Header.RegionDiv: TIWHTMLTag;
begin
  Result := FRegionDiv;
end;

function TIWBS4Header.RenderCSSClass(AComponentContext: TIWCompContext): string;
begin
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

function TIWBS4Header.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;
  FRegionDiv := TIWHTMLTag.CreateTag(FTagName);
  FRegionDiv.AddStringParam('id', HTMLName);
  FRegionDiv.AddClassParam(FOldCss);
//FRegionDiv.AddStringParam('role', GetRoleString);
  FRegionDiv.AddStringParam('style', RenderStyle(AContext));
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

function TIWBS4Header.RenderText: string;
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

procedure TIWBS4Header.ResetAsyncRefreshControl;
begin
  FAsyncRefreshControl := False;
end;

procedure TIWBS4Header.SetAfterRender(const Value: TNotifyEvent);
begin
  FOnAfterRender := Value;
end;

procedure TIWBS4Header.SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
begin
  FCustomAsyncEvents.Assign(Value);
end;

procedure TIWBS4Header.SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
begin
  FCustomRestEvents.Assign(Value);
end;

procedure TIWBS4Header.SetRawText(const Value: Boolean);
begin
  FRawText := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4Header.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;

procedure TIWBS4Header.SetScriptInsideTag(const Value: Boolean);
begin
  FScriptInsideTag := Value;
end;

procedure TIWBS4Header.SetScriptParams(const AValue: TIWBS4ScriptParams);
begin
  FScriptParams.Assign(AValue);
end;

procedure TIWBS4Header.SetStyle(const AValue: TStringList);
begin
  FStyle.Assign(AValue);
end;

procedure TIWBS4Header.SetText(const Value: string);
begin
  FText := TrimRight(Value);
  AsyncRefreshControl;
end;

{$REGION 'IIWBaseHTMLComponent and other interfaces required by old compilers (D2009)'}
function TIWBS4Header.get_HTMLName: string;
begin
  Result := ControlImplementation.HTMLName;
end;

function TIWBS4Header.get_Clip: Boolean;
begin
  Result := inherited ClipRegion;
end;

procedure TIWBS4Header.set_Clip(AValue: Boolean);
begin
  inherited ClipRegion := AValue;
end;

function TIWBS4Header.get_HasName: Boolean;
begin
  Result := inherited HasName;
end;

function TIWBS4Header.get_UseFrame: Boolean;
begin
  Result := inherited UseFrame;
end;

procedure TIWBS4Header.set_UseFrame(AValue: Boolean);
begin
  inherited UseFrame := AValue;
end;

function TIWBS4Header.get_HTMLWidth: Integer;
begin
  Result := inherited HTMLWidth;
end;

function TIWBS4Header.get_HTMLHeight: Integer;
begin
  Result := inherited HTMLHeight;
end;

function TIWBS4Header.get_HTMLLeft: Integer;
begin
  Result := ControlImplementation.GetHTMLLeft;
end;

function TIWBS4Header.get_HTMLTop: Integer;
begin
  Result := ControlImplementation.GetHTMLTop;
end;

function TIWBS4Header.get_ZIndex: Integer;
begin
  Result := ControlImplementation.GetZIndex;
end;

procedure TIWBS4Header.set_ZIndex(AValue: Integer);
begin
  ControlImplementation.SetZIndex(AValue);
end;

function TIWBS4Header.get_RenderSize: Boolean;
begin
  Result := ControlImplementation.GetRenderSize;
end;

procedure TIWBS4Header.set_RenderSize(AValue: Boolean);
begin
  // Constant
end;

function TIWBS4Header.get_StyleRenderOptions: TIWStyleRenderOptions;
begin
  Result := ControlImplementation.GetStyleRenderOptions;
end;

procedure TIWBS4Header.set_StyleRenderOptions(AValue: TIWStyleRenderOptions);
begin
  ControlImplementation.SetStyleRenderOptions(AValue);
end;

function TIWBS4Header.get_ScriptEvents: TIWScriptEvents;
begin
  Result := ControlImplementation.GetScriptEvents;
end;

procedure TIWBS4Header.set_ScriptEvents(AValue: TIWScriptEvents);
begin
  ControlImplementation.SetScriptEvents(AValue);
end;

function TIWBS4Header.get_Css: string;
begin
  Result := ControlImplementation.GetCss;
end;

procedure TIWBS4Header.set_Css(const AValue: string);
begin
  ControlImplementation.SetCss(AValue);
end;

function TIWBS4Header.get_SkinId: string;
begin
  Result := ControlImplementation.getSkinId;
end;

procedure TIWBS4Header.set_SkinId(const AValue: string);
begin
  ControlImplementation.setSkinId(AValue);
end;

function TIWBS4Header.get_WebCursor: TIWCursor;
begin
  Result := ControlImplementation.GetCursor;
end;

procedure TIWBS4Header.set_WebCursor(AValue: TIWCursor);
begin
  ControlImplementation.SetCursor(AValue);
end;

procedure TIWBS4Header.set_WebFont(AValue: TIWFont);
begin
  ControlImplementation.Font := AValue;
end;

function TIWBS4Header.get_WebFont: TIWFont;
begin
  Result := ControlImplementation.Font;
end;

function TIWBS4Header.get_ExtraTagParams: TStringList;
begin
  Result := ControlImplementation.get_ExtraTagParams;
end;

procedure TIWBS4Header.set_ExtraTagParams(const Value: TStringList);
begin
  ControlImplementation.set_ExtraTagParams(Value);
end;

function TIWBS4Header.get_OnHTMLTag: TIWOnHTMLTag;
begin
  Result := ControlImplementation.OnHTMLTag;
end;

procedure TIWBS4Header.set_OnHTMLTag(AValue: TIWOnHTMLTag);
begin
  ControlImplementation.setOnHTMLTag(AValue);
end;
// deprecated

function TIWBS4Header.get_SupportsPartial: Boolean;
begin
  Result := False;
end;

procedure TIWBS4Header.set_SupportsPartial(AValue: Boolean);
begin
  // deprecated property
end;
{$ENDREGION}

end.

