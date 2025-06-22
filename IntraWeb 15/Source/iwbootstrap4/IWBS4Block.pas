unit IWBS4Block;

interface

{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, Controls, Forms, StrUtils, IWApplication, IWHTMLContainer,
  IWBaseRenderContext, IWContainer, IWControl, IWBaseHTMLInterfaces, IWRegion,
  IWBaseHTMLControl, IWHTML40Container, IWHTMLTag, IWBaseInterfaces, IWXMLTag,
  IWScriptEvents, IWFont, IWTypes, IWRenderContext, IWBS4Typography,
  IWBS4CustomEvents, IWBS4CommonInterfaces, IWBS4LayoutMgr, IWBS4Common;

// Table Element
type
  TIWBS4BlockElement = (bs4beAddress, bs4beArticle, bs4beAside, bs4beBlockquote, bs4beCanvas, bs4beDd, bs4beDiv, bs4beDl, bs4beDt, bs4beFieldset, bs4beFigCaption, bs4beFigure, bs4beFooter, bs4beFooterBlockquote, bs4beHeader, bs4beHr, bs4beMain, bs4beNav, bs4beNoScript, bs4beOl, bs4beOutput, bs4beSection, bs4beTfoot, bs4beVideo);

const
  aIWBS4BlockElement: array[bs4beAddress..bs4beVideo] of string = ('address', 'article', 'aside', 'blockquote', 'canvas', 'dd', 'div', 'dl', 'dt', 'fieldset', 'caption', 'figure', 'footer', 'blockquote-footer', 'header', 'hr', 'main', 'nav', 'noscript', 'ol', 'output', 'section', 'tfoot', 'video');

type
  {$include IWPlatformAttrib.inc}
  TIWBS4Block = class(TIWCustomRegion, IIWBS4Component, IIWBS4Container)
  private
    FBlockElement: TIWBS4BlockElement;

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
    procedure SetBlockElement(const Value: TIWBS4BlockElement);
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
    property BlockElement: TIWBS4BlockElement read FBlockElement write SetBlockElement default bs4beDiv;

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

constructor TIWBS4Block.Create(AOwner: TComponent);
begin
  inherited;

  FBlockElement := bs4beDiv;
  FTagName := 'div';

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

destructor TIWBS4Block.Destroy;
begin
  FreeAndNil(FCustomAsyncEvents);
  FreeAndNil(FCustomRestEvents);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);

  inherited;
end;

{$IFNDEF IW_14_1_0_UP}
function TIWBS4Block.get_ScriptEvents: TIWScriptEvents;
begin
  Result := inherited get_ScriptEvents;
end;

procedure TIWBS4Block.set_ScriptEvents(const Value: TIWScriptEvents);
begin
  inherited set_ScriptEvents(Value);
end;

function TIWBS4Block.IsScriptEventsStored: Boolean;
begin
  Result := ScriptEvents.Count > 0;
end;
{$ENDIF}

function TIWBS4Block.get_Visible: Boolean;
begin
  if (Parent is TFrame) and (Name = 'IWFrameRegion') then
    Result := Parent.Visible
  else
    Result := inherited;
end;

procedure TIWBS4Block.set_Visible(Value: Boolean);
begin
  inherited;

  if (Parent is TFrame) and (Name = 'IWFrameRegion') and (Parent.Visible <> Value) then
  begin
    Parent.Visible := Value;
  end;
end;

procedure TIWBS4Block.SetParent(AParent: TWinControl);
begin
  inherited;

  if (Parent is TFrame) and (Name <> 'IWFrameRegion') and (Parent.FindComponent('IWFrameRegion') = nil) then
  begin
    Name := 'IWFrameRegion';
  end;
end;

procedure TIWBS4Block.SetRawText(const Value: Boolean);
begin
  FRawText := Value;
  AsyncRefreshControl;
end;

function TIWBS4Block.JQSelector: string;
begin
  Result := '$("#' + HTMLName + '")';
end;

procedure TIWBS4Block.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBS4Block.ResetAsyncRefreshControl;
begin
  FAsyncRefreshControl := False;
end;

procedure TIWBS4Block.ApplyAsyncChanges;
begin
  if FAsyncRefreshControl or not FRendered then
  begin
    raise Exception.Create('Cannot apply changes now, control should be full refreshed');
  end;
  RenderAsync(nil);
  DoRefreshControl := False;
end;

procedure TIWBS4Block.AsyncRemoveControl;
begin
  TIWBS4Common.AsyncRemoveControl(FMainID);
  FAsyncRefreshControl := False;
  FRendered := False;
end;

procedure TIWBS4Block.Release;
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

procedure TIWBS4Block.SetFocus;
begin
  IWBS4ExecuteAsyncJScript(JQSelector + '.focus()');
end;

function TIWBS4Block.GetRoleString: string;
begin
  Result := '';
end;

procedure TIWBS4Block.OnScriptChange(ASender: TObject);
begin
  AsyncRefreshControl;
end;

procedure TIWBS4Block.OnStyleChange(ASender: TObject);
begin
  Invalidate;
end;

function TIWBS4Block.GetAfterRender: TNotifyEvent;
begin
  Result := FOnAfterRender;
end;

function TIWBS4Block.GetCssString: string;
begin
  Result := RenderCSSClass(nil);
end;

function TIWBS4Block.GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
begin
  if FCustomAsyncEvents = nil then
  begin
    FCustomAsyncEvents := TIWBS4CustomAsyncEvents.Create(Self);
  end;
  Result := FCustomAsyncEvents;
end;

function TIWBS4Block.GetCustomRestEvents: TIWBS4CustomRestEvents;
begin
  if FCustomRestEvents = nil then
  begin
    FCustomRestEvents := TIWBS4CustomRestEvents.Create(Self);
  end;
  Result := FCustomRestEvents;
end;

procedure TIWBS4Block.SetAfterRender(const Value: TNotifyEvent);
begin
  FOnAfterRender := Value;
end;

procedure TIWBS4Block.SetCss(const Value: string);
begin
  FCss := Value;
  Invalidate;
end;

procedure TIWBS4Block.SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
begin
  FCustomAsyncEvents.Assign(Value);
end;

procedure TIWBS4Block.SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
begin
  FCustomRestEvents.Assign(Value);
end;

function TIWBS4Block.IsStoredCustomAsyncEvents: Boolean;
begin
  Result := (FCustomAsyncEvents <> nil) and (FCustomAsyncEvents.Count > 0);
end;

function TIWBS4Block.IsStoredCustomRestEvents: Boolean;
begin
  Result := (FCustomRestEvents <> nil) and (FCustomRestEvents.Count > 0);
end;

procedure TIWBS4Block.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;

procedure TIWBS4Block.SetScriptInsideTag(const Value: Boolean);
begin
  FScriptInsideTag := Value;
end;

procedure TIWBS4Block.SetScriptParams(const AValue: TIWBS4ScriptParams);
begin
  FScriptParams.Assign(AValue);
end;

function TIWBS4Block.GetScript: TStringList;
begin
  Result := FScript;
end;

function TIWBS4Block.GetScriptInsideTag: Boolean;
begin
  Result := FScriptInsideTag;
end;

function TIWBS4Block.GetScriptParams: TIWBS4ScriptParams;
begin
  Result := FScriptParams;
end;

function TIWBS4Block.GetStyle: TStringList;
begin
  Result := FStyle;
end;

procedure TIWBS4Block.SetStyle(const AValue: TStringList);
begin
  FStyle.Assign(AValue);
end;

procedure TIWBS4Block.SetBlockElement(const Value: TIWBS4BlockElement);
begin
  FBlockElement := Value;
  FTagName := aIWBS4BlockElement[FBlockElement];

  // For horizontal rules, set the height to the perfect visual height in the designer
  if FBlockElement = bs4beHR then
  begin
    if Self.Height = 60 then
    begin
      Self.Height := 21;
    end;
    if Self.Width = 60 then
    begin
      Self.Width := 300;
    end;
  end;

  Invalidate;
end;

procedure TIWBS4Block.SetText(const Value: string);
begin
  FText := TrimRight(Value);
  AsyncRefreshControl;
end;

function TIWBS4Block.ContainerPrefix: string;
begin
  if Owner is TFrame then
  begin
    Result := UpperCase(TFrame(Owner).Name)
  end
  else if isBaseContainer(Parent) then
    Result := BaseContainerInterface(Parent).ContainerPrefix
  else
    Result := UpperCase(Name);
end;

function TIWBS4Block.HTMLControlImplementation: TIWHTMLControlImplementation;
begin
  Result := ControlImplementation;
end;

function TIWBS4Block.RegionDiv: TIWHTMLTag;
begin
  Result := FRegionDiv;
end;

function TIWBS4Block.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  if not (Self.LayoutMgr is TIWBS4LayoutMgr) then
  begin
    Self.LayoutMgr := TIWBS4LayoutMgr.Create(Self);
  end;
  Result := inherited;
end;

function TIWBS4Block.SupportsInput: Boolean;
begin
  Result := False;
end;

procedure TIWBS4Block.IWComponentsChanged(AComponent: TComponent);

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

procedure TIWBS4Block.InternalRenderCss(var ACss: string);
begin
//TIWBS4Common.AddCssClass(ACss, aIWBS4TableElement[FTableElement]);

  // The top-level table element must have a class of .table
 {if FBlockElement = bs4teTable then
  begin
    TIWBS4Common.AddCssClass(ACss, aIWBS4TableElement[bs4teTable]);
  end;}
end;

procedure TIWBS4Block.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  //
end;

procedure TIWBS4Block.InternalRenderStyle(AStyle: TStringList);
begin
  //
end;

function TIWBS4Block.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
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

procedure TIWBS4Block.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  TIWBS4RegionCommon.RenderComponents(Self, AContainerContext, APageContext);
end;

function TIWBS4Block.RenderCSSClass(AComponentContext: TIWCompContext): string;
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

function TIWBS4Block.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;

  FRegionDiv := TIWHTMLTag.CreateTag(FTagName);
  FRegionDiv.AddStringParam('id', HTMLName);
  FRegionDiv.AddClassParam(FOldCss);
  FRegionDiv.AddStringParam('role', GetRoleString);
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

procedure TIWBS4Block.RenderScripts(AComponentContext: TIWCompContext);
begin
  //
end;

function TIWBS4Block.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := TIWBS4Common.RenderStyle(Self);
end;

function TIWBS4Block.RenderText: string;
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
function TIWBS4Block.get_HTMLName: string;
begin
  Result := ControlImplementation.HTMLName;
end;

function TIWBS4Block.get_Clip: Boolean;
begin
  Result := inherited ClipRegion;
end;

procedure TIWBS4Block.set_Clip(AValue: Boolean);
begin
  inherited ClipRegion := AValue;
end;

function TIWBS4Block.get_HasName: Boolean;
begin
  Result := inherited HasName;
end;

function TIWBS4Block.get_UseFrame: Boolean;
begin
  Result := inherited UseFrame;
end;

procedure TIWBS4Block.set_UseFrame(AValue: Boolean);
begin
  inherited UseFrame := AValue;
end;

function TIWBS4Block.get_HTMLWidth: Integer;
begin
  Result := inherited HTMLWidth;
end;

function TIWBS4Block.get_HTMLHeight: Integer;
begin
  Result := inherited HTMLHeight;
end;

function TIWBS4Block.get_HTMLLeft: Integer;
begin
  Result := ControlImplementation.GetHTMLLeft;
end;

function TIWBS4Block.get_HTMLTop: Integer;
begin
  Result := ControlImplementation.GetHTMLTop;
end;

function TIWBS4Block.get_ZIndex: Integer;
begin
  Result := ControlImplementation.GetZIndex;
end;

procedure TIWBS4Block.set_ZIndex(AValue: Integer);
begin
  ControlImplementation.SetZIndex(AValue);
end;

function TIWBS4Block.get_RenderSize: Boolean;
begin
  Result := ControlImplementation.GetRenderSize;
end;

procedure TIWBS4Block.set_RenderSize(AValue: Boolean);
begin
  // Constant
end;

function TIWBS4Block.get_StyleRenderOptions: TIWStyleRenderOptions;
begin
  Result := ControlImplementation.GetStyleRenderOptions;
end;

procedure TIWBS4Block.set_StyleRenderOptions(AValue: TIWStyleRenderOptions);
begin
  ControlImplementation.SetStyleRenderOptions(AValue);
end;

function TIWBS4Block.get_ScriptEvents: TIWScriptEvents;
begin
  Result := ControlImplementation.GetScriptEvents;
end;

procedure TIWBS4Block.set_ScriptEvents(AValue: TIWScriptEvents);
begin
  ControlImplementation.SetScriptEvents(AValue);
end;

function TIWBS4Block.get_Css: string;
begin
  Result := ControlImplementation.GetCss;
end;

procedure TIWBS4Block.set_Css(const AValue: string);
begin
  ControlImplementation.SetCss(AValue);
end;

function TIWBS4Block.get_SkinId: string;
begin
  Result := ControlImplementation.getSkinId;
end;

procedure TIWBS4Block.set_SkinId(const AValue: string);
begin
  ControlImplementation.setSkinId(AValue);
end;

function TIWBS4Block.get_WebCursor: TIWCursor;
begin
  Result := ControlImplementation.GetCursor;
end;

procedure TIWBS4Block.set_WebCursor(AValue: TIWCursor);
begin
  ControlImplementation.SetCursor(AValue);
end;

procedure TIWBS4Block.set_WebFont(AValue: TIWFont);
begin
  ControlImplementation.Font := AValue;
end;

function TIWBS4Block.get_WebFont: TIWFont;
begin
  Result := ControlImplementation.Font;
end;

function TIWBS4Block.get_ExtraTagParams: TStringList;
begin
  Result := ControlImplementation.get_ExtraTagParams;
end;

procedure TIWBS4Block.set_ExtraTagParams(const Value: TStringList);
begin
  ControlImplementation.set_ExtraTagParams(Value);
end;

function TIWBS4Block.get_OnHTMLTag: TIWOnHTMLTag;
begin
  Result := ControlImplementation.OnHTMLTag;
end;

procedure TIWBS4Block.set_OnHTMLTag(AValue: TIWOnHTMLTag);
begin
  ControlImplementation.setOnHTMLTag(AValue);
end;

// deprecated
function TIWBS4Block.get_SupportsPartial: Boolean;
begin
  Result := False;
end;

procedure TIWBS4Block.set_SupportsPartial(AValue: Boolean);
begin
  // deprecated property
end;
{$ENDREGION}

end.

