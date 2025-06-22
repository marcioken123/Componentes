unit IWBS4Region;
(** Notes:
     > Need to handle the <small> tag that can now be embedded in headers
**)

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, Controls, StrUtils, IWBS4Common, IWBS4Color,
  IWBS4CustomRegion;

type
  TIWBS4RegionType = (bs4rtNone, bs4rtContainer, bs4rtContainerFluid, bs4rtRow, bs4rtColumn, bs4rtDropDown, bs4rtDropDownMenu, bs4rtFormGroup, bs4rtJumbotron, bs4rtPageHeader, bs4rtButtonToolbar, bs4rtListGroup, bs4rtModalContent, bs4rtModalHeader, bs4rtModalBody, bs4rtModalFooter, bs4rtCard, bs4rtCardBody, bs4rtCardHeader, bs4rtCardFooter, bs4rtCardColumns, bs4rtCardDeck, bs4rtCardGroup, bs4rtCardImageOverlay, bs4rtNav, bs4rtUnorderedList, bs4rtListItem, bs4rtHeader, bs4rtFooter);

const
  aIWBS4RegionType: array[bs4rtNone..bs4rtFooter] of string = ('', 'container', 'container-fluid', 'row', 'column', 'dropdown', 'dropdown-menu', 'form-group', 'jumbotron', 'page-header', 'btn-toolbar', 'list-group', 'modal-content', 'modal-header', 'modal-body', 'modal-footer', 'card', 'card-body', 'card-header', 'card-footer', 'card-columns', 'card-deck', 'card-group', 'card-img-overlay', 'nav', 'ul', 'li', 'header', 'footer');
// Span has been moved to TIWBS4Inline

type
  TIWBS4RegionTagType = (bs4ttAnchor, bs4ttButton, bs4ttDiv, bs4ttListItem, bs4ttUnorderedList);

const
  aIWBS4RegionTagType: array[bs4ttAnchor..bs4ttUnorderedList] of string = ('a', 'button', 'div', 'li', 'ul');
// The h1..h6, p and pre elements have been moved to TIWBS4BlockText
{type
  TIWBS4HeaderDisplay = (bs4hdNone, bs4hdDisplay1, bs4hdDisplay2, bs4hdDisplay3, bs4hdDisplay4);
const
  aIWBS4HeaderDisplay: array[bs4hdNone..bs4hdDisplay4] of string =
    ('', 'display-1', 'display-2', 'display-3', 'display-4');}

type
  {$include IWPlatformAttrib.inc}
  TIWBS4Region = class(TIWBS4CustomRegion)
  private
    FBackground: TIWBS4Background;
    FRegionType: TIWBS4RegionType;
    FTagType: TIWBS4RegionTagType;
    procedure SetRegionType(AValue: TIWBS4RegionType);
    procedure SetBackground(AValue: TIWBS4Background);
    procedure SetTagType(const Value: TIWBS4RegionTagType);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetRoleString: string; override;
  published
    property BSBackground: TIWBS4Background read FBackground write SetBackground default bs4bgNone;
    property BSRegionType: TIWBS4RegionType read FRegionType write SetRegionType default bs4rtNone;
    property TagType: TIWBS4RegionTagType read FTagType write SetTagType default bs4ttDiv;
  end;

implementation

uses
  IWBS4NavBar;

constructor TIWBS4Region.Create(AOwner: TComponent);
begin
  inherited;

  FTagType := bs4ttDiv;
end;

procedure TIWBS4Region.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, aIWBS4RegionType[FRegionType]);
  // Background theme color
  if FBackground <> bs4bgNone then
  begin
    TIWBS4Common.AddCssClass(ACss, 'bg-' + aIWBS4Background[FBackground])
  end
  else if Parent is TIWBS4NavBar then
  begin
    if TagType = bs4ttDiv then
      TIWBS4Common.AddCssClass(ACss, 'navbar-btn')
    else
      TIWBS4Common.AddCssClass(ACss, 'navbar-text');
  end;
  if BorderClass <> bs4bdNone then
  begin
    TIWBS4Common.AddCssClass(ACss, 'border-' + aIWBS4Border[BorderClass]);
  end;
  inherited;
end;

function TIWBS4Region.GetRoleString: string;
begin
  if FRegionType = bs4rtButtonToolbar then
    Result := 'toolbar'
  else
    Result := '';
end;

procedure TIWBS4Region.SetRegionType(AValue: TIWBS4RegionType);
begin
  FRegionType := AValue;
  Invalidate;
end;

procedure TIWBS4Region.SetTagType(const Value: TIWBS4RegionTagType);
begin
  FTagType := Value;
  FTagName := aIWBS4RegionTagType[Value];
  AsyncRefreshControl;
end;

procedure TIWBS4Region.SetBackground(AValue: TIWBS4Background);
begin
  FBackground := AValue;
  Invalidate;
end;

end.

