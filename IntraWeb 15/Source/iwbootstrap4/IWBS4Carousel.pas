unit IWBS4Carousel;

interface

{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, Controls, Forms, StrUtils, IWApplication, IWHTMLContainer,
  IWBaseRenderContext, IWContainer, IWControl, IWBaseHTMLInterfaces, IWRegion,
  IWBaseHTMLControl, IWHTML40Container, IWHTMLTag, IWBaseInterfaces, IWXMLTag,
  IWFont, IWTypes, IWScriptEvents, IWRenderContext, IWBS4CustomEvents,
  IWBS4CommonInterfaces, IWBS4LayoutMgr, IWBS4Common;

type
  {$include IWPlatformAttrib.inc}
  TIWBS4Carousel = class(TIWCustomRegion, IIWBS4Component, IIWBS4Container)
  private
    FCarouselImages: TStringList;
    FIndicators: Boolean;
    FSlide: Boolean;             // controls whether to add the transition animation
    FFade: Boolean;              // enhances the slide
    FInterval: Integer;          // data-interval="5000" or data-interval="false"
    FKeyboardUseArrows: Boolean; // data-keyboard="true"
    FPauseOnHover: Boolean;      // data-pause="hover"
    FWrap: Boolean;              // data-wrap="false"
    // The BS4 carousel has a design flaw in that it doesn't make any attempt to adapt to its content.
    // To get around this limitation, all images should be the same size. Set the Width of the
    // component to the width of your images, then set UseWidth to True -- and everything will magically work
    FUseWidth: Boolean;
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
    procedure SetCarouselImages(const AValue: TStringList);
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
    class function BuildCarouselImageString(AImage, AAlternate: string; ACaption: string = ''; ASubTitle: string = ''): string;
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
    property CarouselImages: TStringList read FCarouselImages write SetCarouselImages;
    property Indicators: Boolean read FIndicators write FIndicators default True;
    property UseWidth: Boolean read FUseWidth write FUseWidth default False;
    property Slide: Boolean read FSlide write FSlide default True;
    property Fade: Boolean read FFade write FFade default False;
    property Interval: Integer read FInterval write FInterval default 3000;
    property KeyboardUseArrows: Boolean read FKeyboardUseArrows write FKeyboardUseArrows default True;
    property PauseOnHover: Boolean read FPauseOnHover write FPauseOnHover default True;
    property Wrap: Boolean read FWrap write FWrap default True;
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

constructor TIWBS4Carousel.Create(AOwner: TComponent);
begin
  inherited;
  FTagName := 'div';
  FCarouselImages := TStringList.Create;
  FIndicators := True;
  FSlide := True;
  FFade := False;
  FInterval := 3000;
  FKeyboardUseArrows := True;
  FPauseOnHover := True;
  FWrap := True;
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

destructor TIWBS4Carousel.Destroy;
begin
  FreeAndNil(FCarouselImages);
  FreeAndNil(FCustomAsyncEvents);
  FreeAndNil(FCustomRestEvents);
  FreeAndNil(FScript);
  FreeAndNil(FScriptParams);
  FreeAndNil(FStyle);
  inherited;
end;
{$IFNDEF IW_14_1_0_UP}

function TIWBS4Carousel.get_ScriptEvents: TIWScriptEvents;
begin
  Result := inherited get_ScriptEvents;
end;

procedure TIWBS4Carousel.set_ScriptEvents(const Value: TIWScriptEvents);
begin
  inherited set_ScriptEvents(Value);
end;

function TIWBS4Carousel.IsScriptEventsStored: Boolean;
begin
  Result := ScriptEvents.Count > 0;
end;
{$ENDIF}

function TIWBS4Carousel.get_Visible: Boolean;
begin
  if (Parent is TFrame) and (Name = 'IWFrameRegion') then
    Result := Parent.Visible
  else
    Result := inherited;
end;

procedure TIWBS4Carousel.set_Visible(Value: Boolean);
begin
  inherited;
  if (Parent is TFrame) and (Name = 'IWFrameRegion') and (Parent.Visible <> Value) then
  begin
    Parent.Visible := Value;
  end;
end;

procedure TIWBS4Carousel.SetParent(AParent: TWinControl);
begin
  inherited;
  if (Parent is TFrame) and (Name <> 'IWFrameRegion') and (Parent.FindComponent('IWFrameRegion') = nil) then
  begin
    Name := 'IWFrameRegion';
  end;
end;

procedure TIWBS4Carousel.SetRawText(const Value: Boolean);
begin
  FRawText := Value;
  AsyncRefreshControl;
end;

function TIWBS4Carousel.JQSelector: string;
begin
  Result := '$("#' + HTMLName + '")';
end;

procedure TIWBS4Carousel.AsyncRefreshControl;
begin
  FAsyncRefreshControl := True;
  Invalidate;
end;

procedure TIWBS4Carousel.ResetAsyncRefreshControl;
begin
  FAsyncRefreshControl := False;
end;

procedure TIWBS4Carousel.ApplyAsyncChanges;
begin
  if FAsyncRefreshControl or not FRendered then
  begin
    raise Exception.Create('Cannot apply changes now, control should be full refreshed');
  end;
  RenderAsync(nil);
  DoRefreshControl := False;
end;

procedure TIWBS4Carousel.AsyncRemoveControl;
begin
  TIWBS4Common.AsyncRemoveControl(FMainID);
  FAsyncRefreshControl := False;
  FRendered := False;
end;
// Useful for building the CarouselImages in code

class function TIWBS4Carousel.BuildCarouselImageString(AImage, AAlternate: string; ACaption: string = ''; ASubTitle: string = ''): string;
begin
  if (Length(Trim(AImage)) = 0) or (Length(Trim(AAlternate)) = 0) then
  begin
    raise Exception.Create('Both the image and the alternate must be provided');
  end;

  Result := Trim(AImage) + '@' + Trim(AAlternate);

  // If either the caption or subtitle is provided, both must be provided
  if (Length(Trim(ACaption)) > 0) or (Length(Trim(ASubTitle)) > 0) then
  begin
    if (Length(Trim(ACaption)) = 0) or (Length(Trim(ASubTitle)) = 0) then
    begin
      raise Exception.Create('If you want a caption, both the caption and the subtitle must be provided');
    end;

    Result := Result + '@@' + Trim(ACaption) + '@@@' + Trim(ASubTitle);
  end;
end;

procedure TIWBS4Carousel.Release;
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

procedure TIWBS4Carousel.SetFocus;
begin
  IWBS4ExecuteAsyncJScript(JQSelector + '.focus()');
end;

function TIWBS4Carousel.GetRoleString: string;
begin
  Result := '';
end;

procedure TIWBS4Carousel.OnScriptChange(ASender: TObject);
begin
  AsyncRefreshControl;
end;

procedure TIWBS4Carousel.OnStyleChange(ASender: TObject);
begin
  Invalidate;
end;

function TIWBS4Carousel.GetAfterRender: TNotifyEvent;
begin
  Result := FOnAfterRender;
end;

function TIWBS4Carousel.GetCssString: string;
begin
  Result := RenderCSSClass(nil);
end;

function TIWBS4Carousel.GetCustomAsyncEvents: TIWBS4CustomAsyncEvents;
begin
  if FCustomAsyncEvents = nil then
  begin
    FCustomAsyncEvents := TIWBS4CustomAsyncEvents.Create(Self);
  end;
  Result := FCustomAsyncEvents;
end;

function TIWBS4Carousel.GetCustomRestEvents: TIWBS4CustomRestEvents;
begin
  if FCustomRestEvents = nil then
  begin
    FCustomRestEvents := TIWBS4CustomRestEvents.Create(Self);
  end;
  Result := FCustomRestEvents;
end;

procedure TIWBS4Carousel.SetAfterRender(const Value: TNotifyEvent);
begin
  FOnAfterRender := Value;
end;

procedure TIWBS4Carousel.SetCarouselImages(const AValue: TStringList);
begin
  FCarouselImages.Assign(AValue);
end;

procedure TIWBS4Carousel.SetCss(const Value: string);
begin
  FCss := Value;
  Invalidate;
end;

procedure TIWBS4Carousel.SetCustomAsyncEvents(const Value: TIWBS4CustomAsyncEvents);
begin
  FCustomAsyncEvents.Assign(Value);
end;

procedure TIWBS4Carousel.SetCustomRestEvents(const Value: TIWBS4CustomRestEvents);
begin
  FCustomRestEvents.Assign(Value);
end;

function TIWBS4Carousel.IsStoredCustomAsyncEvents: Boolean;
begin
  Result := (FCustomAsyncEvents <> nil) and (FCustomAsyncEvents.Count > 0);
end;

function TIWBS4Carousel.IsStoredCustomRestEvents: Boolean;
begin
  Result := (FCustomRestEvents <> nil) and (FCustomRestEvents.Count > 0);
end;

procedure TIWBS4Carousel.SetScript(const AValue: TStringList);
begin
  FScript.Assign(AValue);
end;

procedure TIWBS4Carousel.SetScriptInsideTag(const Value: Boolean);
begin
  FScriptInsideTag := Value;
end;

procedure TIWBS4Carousel.SetScriptParams(const AValue: TIWBS4ScriptParams);
begin
  FScriptParams.Assign(AValue);
end;

function TIWBS4Carousel.GetScript: TStringList;
begin
  Result := FScript;
end;

function TIWBS4Carousel.GetScriptInsideTag: Boolean;
begin
  Result := FScriptInsideTag;
end;

function TIWBS4Carousel.GetScriptParams: TIWBS4ScriptParams;
begin
  Result := FScriptParams;
end;

function TIWBS4Carousel.GetStyle: TStringList;
begin
  Result := FStyle;
end;

procedure TIWBS4Carousel.SetStyle(const AValue: TStringList);
begin
  FStyle.Assign(AValue);
end;

procedure TIWBS4Carousel.SetText(const Value: string);
begin
  FText := TrimRight(Value);
  AsyncRefreshControl;
end;

function TIWBS4Carousel.ContainerPrefix: string;
begin
  if Owner is TFrame then
    Result := UpperCase(TFrame(Owner).Name)
  else if isBaseContainer(Parent) then
    Result := BaseContainerInterface(Parent).ContainerPrefix
  else
    Result := UpperCase(Name);
end;

function TIWBS4Carousel.HTMLControlImplementation: TIWHTMLControlImplementation;
begin
  Result := ControlImplementation;
end;

function TIWBS4Carousel.RegionDiv: TIWHTMLTag;
begin
  Result := FRegionDiv;
end;

function TIWBS4Carousel.InitContainerContext(AWebApplication: TIWApplication): TIWContainerContext;
begin
  if not (Self.LayoutMgr is TIWBS4LayoutMgr) then
  begin
    Self.LayoutMgr := TIWBS4LayoutMgr.Create(Self);
  end;
  Result := inherited;
end;

function TIWBS4Carousel.SupportsInput: Boolean;
begin
  Result := False;
end;

procedure TIWBS4Carousel.IWComponentsChanged(AComponent: TComponent);

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

procedure TIWBS4Carousel.InternalRenderCss(var ACss: string);
begin
//TIWBS4Common.AddCssClass(ACss, aIWBS4TableElement[FTableElement]);
  TIWBS4Common.AddCssClass(ACss, 'carousel');
  // We override the user if the user sets Slide to False and Fade to True -- Fade requires Slide
  if FSlide or FFade then
  begin
    TIWBS4Common.AddCssClass(ACss, 'slide');
  end;
  if FFade then
  begin
    TIWBS4Common.AddCssClass(ACss, 'carousel-fade');
  end;
end;

procedure TIWBS4Carousel.InternalRenderScript(AContext: TIWCompContext; const AHTMLName: string; AScript: TStringList);
begin
  //
end;

procedure TIWBS4Carousel.InternalRenderStyle(AStyle: TStringList);
begin
  //
end;

function TIWBS4Carousel.RenderAsync(AContext: TIWCompContext): TIWXMLTag;
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

procedure TIWBS4Carousel.RenderComponents(AContainerContext: TIWContainerContext; APageContext: TIWBasePageContext);
begin
  TIWBS4RegionCommon.RenderComponents(Self, AContainerContext, APageContext);
end;

function TIWBS4Carousel.RenderCSSClass(AComponentContext: TIWCompContext): string;
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

function TIWBS4Carousel.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  FOldCss := RenderCSSClass(AContext);
  FOldStyle := RenderStyle(AContext);
  FOldVisible := Visible;
  FRegionDiv := TIWHTMLTag.CreateTag(FTagName);
  FRegionDiv.AddStringParam('id', HTMLName);
  FRegionDiv.AddClassParam(FOldCss);
  FRegionDiv.AddStringParam('role', GetRoleString);
  FRegionDiv.AddStringParam('style', RenderStyle(AContext));
  // To address the design flaw of the BS4 carousel where it make no attempt to adapt itself to its content,
  // we must fix it ourselves. If UseWidth is True, we add a style that makes fixes the problem completely
  if FUseWidth then
  begin
    FRegionDiv.AddStringParam('style', 'width:' + IntToStr(Self.Width) + 'px;');
  end;
  // Core properties
  // Interval
  if FInterval = 0 then
    FRegionDiv.AddStringParam('data-interval', 'false')
  else
    FRegionDiv.AddStringParam('data-interval', IntToStr(FInterval));
  // Keyboard
  if FKeyboardUseArrows then
    FRegionDiv.AddStringParam('data-keyboard', 'true')
  else
    FRegionDiv.AddStringParam('data-keyboard', 'false');
  // Pause
  if FPauseOnHover then
  begin
    FRegionDiv.AddStringParam('data-pause', 'hover');
  end;
  // Wrap
  if FWrap then
    FRegionDiv.AddStringParam('data-wrap', 'true')
  else
    FRegionDiv.AddStringParam('data-wrap', 'false');
//if FText <> '' then
  if FCarouselImages.Count <> 0 then
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

procedure TIWBS4Carousel.RenderScripts(AComponentContext: TIWCompContext);
begin
  //
end;

function TIWBS4Carousel.RenderStyle(AContext: TIWCompContext): string;
begin
  Result := TIWBS4Common.RenderStyle(Self);
end;

function TIWBS4Carousel.RenderText: string;
var
  i: Integer;
  slInner: TStringList;
  ImgCt: Integer;
  S: string;
  Img: string;
  Alt: string;
  ImageCaption: string;
  ImageSubCaption: string;
begin
  // Want to output the entire inner section here, without requiring the user
  // to add divs and list  items and images and indicators, etc.
  slInner := TStringList.Create;
  try
    // First find out how many images are in the Carousel
    CarouselImages.Text := Trim(CarouselImages.Text);
    ImgCt := CarouselImages.Count;

    // Add an Indicator for each
    if FIndicators then
    begin
      slInner.Add(sLineBreak + '  <ul class="carousel-indicators">');
      for i := 0 to ImgCt - 1 do
      begin
        slInner.Add('    <li data-target="#' + HTMLName + '" data-slide-to="' + IntToStr(i) + '"' + IfThen(i = 0, ' class="active"', '') + '></li>');
      end;
      slInner.Add('  </ul>');
    end;

    // Add the carousel images
    slInner.Add('  <div class="carousel-inner">');
    for i := 0 to ImgCt - 1 do
    begin
      slInner.Add('    <div class="carousel-item' + IfThen(i = 0, ' active', '') + '">');
      S := Trim(CarouselImages[i]);
      // Parse the image line (must have @)
      if Pos('@', S) = 0 then
      begin
        raise Exception.Create('Invalid carousel image string: must contain the "@" symbol');
      end;
      // If we find @@@ in the string, it means that the user wants captions
      // and we must ferret out 2 extra data points
      // (later we should convert to a real collection property -- whoever has time may volunteer)
      if Pos('@@@', S) > 0 then
      begin
        ImageSubCaption := Copy(S, Pos('@@@', S) + 3, 999);
        Delete(S, Pos('@@@', S), 999);
        ImageCaption := Copy(S, Pos('@@', S) + 2, 999);
        Delete(S, Pos('@@', S), 999);
      end;
      // Create the markup for the image and alternate
      Img := Trim(Copy(CarouselImages[i], 1, Pos('@', CarouselImages[i]) - 1));
      Alt := Trim(Copy(CarouselImages[i], Pos('@', CarouselImages[i]) + 1, 999));
      slInner.Add('      <img src="' + Img + '" alt="' + Alt + '">');
      // If the Caption is provided, create the markup for it and the SubCaption (currently must have both or none)
      if Length(ImageCaption) > 0 then
      begin
        slInner.Add('      <div class="carousel-caption d-none d-md-block">');
        slInner.Add('        <h5>' + ImageCaption + '</h5>');
        slInner.Add('        <p>' + ImageSubCaption + '</p>');
        slInner.Add('      </div>');
      end;
      slInner.Add('    </div>');
    end;
    slInner.Add('  </div>');

    // Add the left and right icons
    slInner.Add('  <a class="carousel-control-prev" href="#' + HTMLName + '" role="button" data-slide="prev">');
    slInner.Add('    <span class="carousel-control-prev-icon" aria-hidden="true"></span>');
    slInner.Add('    <span class="sr-only">Previous</span>');
    slInner.Add('  </a>');
    slInner.Add('  <a class="carousel-control-next" href="#' + HTMLName + '" role="button" data-slide="next">');
    slInner.Add('    <span class="carousel-control-next-icon" aria-hidden="true"></span>');
    slInner.Add('    <span class="sr-only">Next</span>');
    slInner.Add('  </a>');

    Result := slInner.Text;
  finally
    slInner.Free;
  end;
end;
{$REGION 'IIWBaseHTMLComponent and other interfaces required by old compilers (D2009)'}

function TIWBS4Carousel.get_HTMLName: string;
begin
  Result := ControlImplementation.HTMLName;
end;

function TIWBS4Carousel.get_Clip: Boolean;
begin
  Result := inherited ClipRegion;
end;

procedure TIWBS4Carousel.set_Clip(AValue: Boolean);
begin
  inherited ClipRegion := AValue;
end;

function TIWBS4Carousel.get_HasName: Boolean;
begin
  Result := inherited HasName;
end;

function TIWBS4Carousel.get_UseFrame: Boolean;
begin
  Result := inherited UseFrame;
end;

procedure TIWBS4Carousel.set_UseFrame(AValue: Boolean);
begin
  inherited UseFrame := AValue;
end;

function TIWBS4Carousel.get_HTMLWidth: Integer;
begin
  Result := inherited HTMLWidth;
end;

function TIWBS4Carousel.get_HTMLHeight: Integer;
begin
  Result := inherited HTMLHeight;
end;

function TIWBS4Carousel.get_HTMLLeft: Integer;
begin
  Result := ControlImplementation.GetHTMLLeft;
end;

function TIWBS4Carousel.get_HTMLTop: Integer;
begin
  Result := ControlImplementation.GetHTMLTop;
end;

function TIWBS4Carousel.get_ZIndex: Integer;
begin
  Result := ControlImplementation.GetZIndex;
end;

procedure TIWBS4Carousel.set_ZIndex(AValue: Integer);
begin
  ControlImplementation.SetZIndex(AValue);
end;

function TIWBS4Carousel.get_RenderSize: Boolean;
begin
  Result := ControlImplementation.GetRenderSize;
end;

procedure TIWBS4Carousel.set_RenderSize(AValue: Boolean);
begin
  // Constant
end;

function TIWBS4Carousel.get_StyleRenderOptions: TIWStyleRenderOptions;
begin
  Result := ControlImplementation.GetStyleRenderOptions;
end;

procedure TIWBS4Carousel.set_StyleRenderOptions(AValue: TIWStyleRenderOptions);
begin
  ControlImplementation.SetStyleRenderOptions(AValue);
end;

function TIWBS4Carousel.get_ScriptEvents: TIWScriptEvents;
begin
  Result := ControlImplementation.GetScriptEvents;
end;

procedure TIWBS4Carousel.set_ScriptEvents(AValue: TIWScriptEvents);
begin
  ControlImplementation.SetScriptEvents(AValue);
end;

function TIWBS4Carousel.get_Css: string;
begin
  Result := ControlImplementation.GetCss;
end;

procedure TIWBS4Carousel.set_Css(const AValue: string);
begin
  ControlImplementation.SetCss(AValue);
end;

function TIWBS4Carousel.get_SkinId: string;
begin
  Result := ControlImplementation.getSkinId;
end;

procedure TIWBS4Carousel.set_SkinId(const AValue: string);
begin
  ControlImplementation.setSkinId(AValue);
end;

function TIWBS4Carousel.get_WebCursor: TIWCursor;
begin
  Result := ControlImplementation.GetCursor;
end;

procedure TIWBS4Carousel.set_WebCursor(AValue: TIWCursor);
begin
  ControlImplementation.SetCursor(AValue);
end;

procedure TIWBS4Carousel.set_WebFont(AValue: TIWFont);
begin
  ControlImplementation.Font := AValue;
end;

function TIWBS4Carousel.get_WebFont: TIWFont;
begin
  Result := ControlImplementation.Font;
end;

function TIWBS4Carousel.get_ExtraTagParams: TStringList;
begin
  Result := ControlImplementation.get_ExtraTagParams;
end;

procedure TIWBS4Carousel.set_ExtraTagParams(const Value: TStringList);
begin
  ControlImplementation.set_ExtraTagParams(Value);
end;

function TIWBS4Carousel.get_OnHTMLTag: TIWOnHTMLTag;
begin
  Result := ControlImplementation.OnHTMLTag;
end;

procedure TIWBS4Carousel.set_OnHTMLTag(AValue: TIWOnHTMLTag);
begin
  ControlImplementation.setOnHTMLTag(AValue);
end;
// deprecated

function TIWBS4Carousel.get_SupportsPartial: Boolean;
begin
  Result := False;
end;

procedure TIWBS4Carousel.set_SupportsPartial(AValue: Boolean);
begin
  // deprecated property
end;
{$ENDREGION}

end.

