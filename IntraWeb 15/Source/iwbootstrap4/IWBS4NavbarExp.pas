unit IWBS4NavbarExp;

// Todo: Add the Hamburger

interface

uses SysUtils, Classes, Controls, StrUtils, IWRenderContext, IWHTMLTag,
  IWBaseHTMLControl, IWControl, IWBS4Common, IWBS4ScriptEvents, IWBS4Color,
  IWBS4BaseContainer, IWBS4CustomEvents, IWBS4Responsive;

type
  TIWBS4NavFixed = (bs4fxNone, bs4fxTop, bs4fxBottom, bs4fxStickyTop);

const
  aIWBS4NavFixed: array[bs4fxNone..bs4fxStickyTop] of string =
    ('', 'fixed-top', 'fixed-bottom', 'sticky-top');

type
  TIWBS4NavbarItemsExp = class;
  TIWBS4NavbarExp = class;

  TIWBS4NavbarItemExp = class(TCollectionItem)
  private
    FText: string;
    FHref: string; // if Href = '' then it is a Navbar text item
    FCss: string;
    FActive: Boolean;
    FDisabled: Boolean;
  //FNavDropdown: TIWBS4NavbarItems;
  //FOnAsyncClick: TIWAsyncEvent; // let's leave this out for now
    procedure SetHref(const Value: string);
    function GetNavbar: TIWBS4NavbarExp;
  //function GetNavDropDown: TIWBS4NavbarItems;
  //procedure SetNavDropdown(const Value: TIWBS4NavbarItems);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Navbar: TIWBS4NavbarExp read GetNavbar;
  published
    property Text: string read FText write FText;
    property Href: string read FHref write SetHref; // stored IsHrefStored;
    property Css: string read FCss write FCss;
    property Active: Boolean read FActive write FActive;
    property Disabled: Boolean read FDisabled write FDisabled;
  //property NavbarItems: TIWBS4NavbarItems read GetNavDropDown write SetNavDropdown;
  //property OnAsyncClick: TIWAsyncEvent read FOnAsyncClick write FOnAsyncClick;
  end;

  TIWBS4NavbarItemsExp = class(TOwnedCollection)
  private
    FOwner: TIWBS4NavbarExp;
  //FCollectionString: string;
    function GetNavbarItem(index: Integer): TIWBS4NavbarItemExp;
    procedure SetNavbarItem(index: Integer; const Value: TIWBS4NavbarItemExp);
  public
    function CreateItemClass: TCollectionItemClass; virtual;
    constructor Create(AOwner: TComponent);

    function GetOwner: TPersistent; override;
    procedure Update(AItem: TCollectionItem); override;
    function Add: TIWBS4NavbarItemExp;
    property NavbarItems[index: Integer]: TIWBS4NavbarItemExp read GetNavbarItem write SetNavbarItem; default;
  end;

  TIWBS4NavbarExp = class(TIWBS4BaseContainer)
  private
    FExpandPoint: TIWBS4Breakpoint;
    FBackgroundContextual: TIWBS4Background;
    FBackgroundOverride: string; // if this is set, the BackgroundContextual will not be used
    FDarkLight: TIWBS4DarkLight;
    FNavItemAlignment: TIWBS4NavItemAlignment;
    FBrand: Boolean;
    FBrandHref: string;
    FBrandText: string;
    FBrandImage: string;
    FBrandAlt: string;
    FBrandWidth: string;
    FHamburger: Boolean;
    FFrenchFries: Boolean;
    FFixedOrSticky: TIWBS4NavFixed;
    FNavbarItems: TIWBS4NavbarItemsExp;
    FNavbarItemsAlwaysHide: Boolean;
    function RenderText: string;
    procedure SetExpandPoint(const Value: TIWBS4Breakpoint);
  //function IsStoredNavbarItems: Boolean;
    procedure SetNavbarItems(const Value: TIWBS4NavbarItemsExp);
    procedure SetFixedOrSticky(const Value: TIWBS4NavFixed);
  protected
    procedure SetBackgroundContextual(const Value: TIWBS4Background);
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property ExpandPoint: TIWBS4Breakpoint read FExpandPoint write SetExpandPoint;
    property BackgroundContextual: TIWBS4Background read FBackgroundContextual write SetBackgroundContextual default bs4bgNone;
    property BackgroundOverride: string read FBackgroundOverride write FBackgroundOverride;
    property DarkLight: TIWBS4DarkLight read FDarkLight write FDarkLight;
    property NavItemAlignment: TIWBS4NavItemAlignment read FNavItemAlignment write FNavItemAlignment default bs4naLeft;
    property Brand: Boolean read FBrand write FBrand;
    property BrandHref: string read FBrandHref write FBrandHref;
    property BrandText: string read FBrandText write FBrandText;
    property BrandImage: string read FBrandImage write FBrandImage;
    property BrandAlt: string read FBrandAlt write FBrandAlt;
    property BrandWidth: string read FBrandWidth write FBrandWidth;
    property Hamburger: Boolean read FHamburger write FHamburger;
    property FrenchFries: Boolean read FFrenchFries write FFrenchFries;
    property FixedOrSticky: TIWBS4NavFixed read FFixedOrSticky write SetFixedOrSticky default bs4fxNone;
    property NavbarItems: TIWBS4NavbarItemsExp read FNavbarItems write SetNavbarItems; // stored IsStoredNavbarItems;
    property NavbarItemsAlwaysHide: Boolean read FNavbarItemsAlwaysHide write FNavbarItemsAlwaysHide;
  end;

implementation

uses IWBS4NavBar, IWBS4Global;

constructor TIWBS4NavbarExp.Create(AOwner: TComponent);
begin
  inherited;

  FTagName := 'nav';

  FExpandPoint := bs4bpMedium;
  FBackgroundContextual := bs4bgNone;
  FDarkLight := bs4dlNone;
  FNavItemAlignment := bs4naLeft;

  // Nav Items
  FNavbarItems := TIWBS4NavbarItemsExp.Create(Self);
end;

destructor TIWBS4NavbarExp.Destroy;
begin
  FNavbarItems.Free;
  inherited;
end;

procedure TIWBS4NavbarExp.InternalRenderCss(var ACss: string);
begin
  // Core class
  TIWBS4Common.AddCssClass(ACss, 'navbar');

  // Expand Point
  if (FExpandPoint <> bs4bpNone) and (FExpandPoint <> bs4bpExtraSmall) and not FNavbarItemsAlwaysHide then
  begin
    TIWBS4Common.AddCssClass(ACss, 'navbar-expand-' + aIWBS4Breakpoint[FExpandPoint]);
  end;

  // Contextual Class / Background (Main) Color: If Override is supplied, ignore Contextual setting
  if FBackgroundOverride <> '' then
  begin
    // have to add to Style: style="background-color: #a4b5c6;" FBackgroundOverride
    TIWBS4Common.AddCssClass(ACss, 'bg-light'); // or bg-dark (basically determines whether font is black or white
  end else
  begin
    // See if the user wants a background based on one of the +-10
    if FBackgroundContextual <> bs4bgNone then
    begin
      TIWBS4Common.AddCssClass(ACss, 'bg-' + aIWBS4Background[FBackgroundContextual]);
    end;

    // See if the user wants a light or dark addon class
    if FDarkLight <> bs4dlNone then
    begin
      TIWBS4Common.AddCssClass(ACss, 'navbar-' + aIWBS4DarkLight[FDarkLight]);
    end;

    // Fixed or Sticky
    if FFixedOrSticky <> bs4fxNone then
    begin
      TIWBS4Common.AddCssClass(ACss, aIWBS4NavFixed[FFixedOrSticky]);
    end;
  end;
end;

procedure TIWBS4NavbarExp.SetBackgroundContextual(const Value: TIWBS4Background);
begin
  FBackgroundContextual := Value;
  Invalidate;
end;

procedure TIWBS4NavbarExp.SetExpandPoint(const Value: TIWBS4Breakpoint);
begin
  FExpandPoint := Value;
end;

procedure TIWBS4NavbarExp.SetFixedOrSticky(const Value: TIWBS4NavFixed);
begin
  FFixedOrSticky := Value;
  Invalidate;
end;

procedure TIWBS4NavbarExp.SetNavbarItems(const Value: TIWBS4NavbarItemsExp);
begin
  if Value = nil
    then FreeAndNil(FNavbarItems)
    else FNavbarItems.Assign(Value);
end;

function TIWBS4NavbarExp.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
var
  ULTag: TIWHTMLTag;
  BrandImageTag: TIWHTMLTag;
  HamburgerTag: TIWHTMLTag;
  CollapsibleDivTag: TIWHTMLTag;
  TogglerSpanTag: TIWHTMLTag;
  AttachPoint: TIWHTMLTag;
  ItemTag: TIWHTMLTag;
  AnchorTag: TIWHTMLTag;
  DivID: string;
  i: Integer;
begin
  OldCss := RenderCSSClass(AContext);
  OldStyle := RenderStyle(AContext);
  OldVisible := Visible;

  FRegionDiv := TIWHTMLTag.CreateTag(FTagName);
  FRegionDiv.AddStringParam('id', HTMLName);
  FRegionDiv.AddClassParam(OldCss);
  FRegionDiv.AddStringParam('role', GetRoleString);
  FRegionDiv.AddStringParam('style', RenderStyle(AContext));

  // Brand
  if FBrand then
  begin
    AnchorTag := FRegionDiv.Contents.AddTag('a');
    AnchorTag.AddClassParam('navbar-brand');
    AnchorTag.AddStringParam('href', FBrandHref);
    if FBrandText <> '' then
    begin
      AnchorTag.Contents.AddText(FBrandText);
    end;
    if FBrandImage <> '' then
    begin
      BrandImageTag := FRegionDiv.Contents.AddTag('img');
      BrandImageTag.AddStringParam('src', FBrandImage);
      BrandImageTag.AddStringParam('alt', FBrandAlt);
      if FBrandWidth <> '' then
      begin
        BrandImageTag.AddStringParam('style', 'width:' + FBrandWidth);
      end;
    end;
  end;

  // Hamburger/Collapsible
  if FHamburger then
  begin
    DivID := 'collapser';

    HamburgerTag := FRegionDiv.Contents.AddTag('button');
    HamburgerTag.AddClassParam('navbar-toggler');
    HamburgerTag.AddStringParam('type', 'button');
    HamburgerTag.AddStringParam('data-toggle', 'collapse');
    HamburgerTag.AddStringParam('data-target', '#' + DivID);
    // Toggler
    TogglerSpanTag := HamburgerTag.Contents.AddTag('span');
    TogglerSpanTag.AddClassParam('navbar-toggler-icon');

    // Create a div to contain the items "ul" only if Hamburger/Collapsible is wanted
    CollapsibleDivTag := FRegionDiv.Contents.AddTag('div');
    CollapsibleDivTag.AddClassParam('collapse navbar-collapse');
    CollapsibleDivTag.AddStringParam('id', DivID);

    AttachPoint := CollapsibleDivTag;
  end else
  begin
    AttachPoint := FRegionDiv;
  end;

  // Render the Items
  ULTag := AttachPoint.Contents.AddTag('ul');
  ULTag.AddClassParam('navbar-nav ml-auto');
  for i := 0 to FNavbarItems.Count - 1 do
  begin
    ItemTag := ULTag.Contents.AddTag('li');
    ItemTag.AddClassParam('nav-item');

    AnchorTag := ItemTag.Contents.AddTag('a');
    AnchorTag.AddClassParam('nav-link');
    if (FNavbarItems.Items[i] as TIWBS4NavbarItemExp).Active then
    begin
      AnchorTag.AddClassParam('active')
    end;
    if (FNavbarItems.Items[i] as TIWBS4NavbarItemExp).Disabled then
    begin
      AnchorTag.AddClassParam('disabled')
    end;
    AnchorTag.AddStringParam('href', (FNavbarItems.Items[i] as TIWBS4NavbarItemExp).Href);
    if (FNavbarItems.Items[i] as TIWBS4NavbarItemExp).Text <>  '' then
    begin
      AnchorTag.Contents.AddText((FNavbarItems.Items[i] as TIWBS4NavbarItemExp).Text);
    end;
  end;

  if Text <> '' then
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

  AsyncRefreshControlYesOrNo := False;
  Rendered := True;
end;

function TIWBS4NavbarExp.RenderText: string;
var
  i: Integer;
  LLines: TStringList;
begin
  if RawText then
  begin
    LLines := TStringList.Create;
    try
      LLines.Text := Text;

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
    Result := TIWBaseHTMLControl.TextToHTML(Text);
  end;
end;

procedure TIWBS4NavbarItemExp.Assign(Source: TPersistent);
begin
  if Source is TIWBS4NavbarItemExp then
  begin
    Text := TIWBS4NavbarItemExp(Source).Text;
    Href := TIWBS4NavbarItemExp(Source).Href;
    Css := TIWBS4NavbarItemExp(Source).Css;
    Disabled := TIWBS4NavbarItemExp(Source).Disabled;
  //OnAsyncClick := TIWBS4NavbarItem(Source).OnAsyncClick;
  end else
  begin
    inherited;
  end;
end;

constructor TIWBS4NavbarItemExp.Create(Collection: TCollection);
begin
  inherited;
  FHref := '#';

//FNavDropdown := TIWBS4NavbarItems.Create(Navbar.Owner);
end;

destructor TIWBS4NavbarItemExp.Destroy;
begin
//FNavDropdown.Free;
  inherited;
end;

function TIWBS4NavbarItemExp.GetDisplayName: string;
begin
  if FText <> ''
    then Result := FText
    else Result := 'TIWBS4NavbarItem' + IntToStr(Index);
end;

function TIWBS4NavbarItemExp.GetNavbar: TIWBS4NavbarExp;
begin
  Result := TIWBS4NavbarItemsExp(Collection).FOwner;
end;

{function TIWBS4NavbarItem.GetNavDropDown: TIWBS4NavbarItems;
begin
  // Lazy create -- there could be lots of items, very few of which have dropdowns
  if not Assigned(FNavDropdown) then
  begin
    FNavDropdown := TIWBS4NavbarItems.Create(Navbar);
  end;

  Result := FNavDropdown;
end;}

{procedure TIWBS4NavbarItem.SetNavDropdown(const Value: TIWBS4NavbarItems);
begin
  FNavDropdown := Value;
end;}

procedure TIWBS4NavbarItemExp.SetHref(const Value: string);
begin
  FHref := Value;
end;

function TIWBS4NavbarItemsExp.Add: TIWBS4NavbarItemExp;
begin
  Result := TIWBS4NavbarItemExp(inherited Add);
end;

constructor TIWBS4NavbarItemsExp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner, TIWBS4NavbarItemExp);
//FOwner := AOwner;
end;

function TIWBS4NavbarItemsExp.CreateItemClass: TCollectionItemClass;
begin
  Result := TIWBS4NavbarItemExp;
end;

function TIWBS4NavbarItemsExp.GetNavbarItem(index: Integer): TIWBS4NavbarItemExp;
begin
  Result := TIWBS4NavbarItemExp(inherited Items[index]);
end;

procedure TIWBS4NavbarItemsExp.SetNavbarItem(index: Integer; const Value: TIWBS4NavbarItemExp);
begin
  Items[index] := Value;
end;

function TIWBS4NavbarItemsExp.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TIWBS4NavbarItemsExp.Update(AItem: TCollectionItem);
{var
  S: string;
  i: Integer;}
begin
  inherited;
 {S := '';
  for i := 0 to Count - 1 do
  begin
    S := (AItem as TIWBS4NavbarItem).Text + ',  ';
  end;
  if System.Length(S) > 1 then
  begin
    System.Delete(S, Length(S) - 1, 2);
  end;
  FCollectionString := S;}
end;

end.
