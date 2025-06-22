unit IWBS4List;

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, Controls, StrUtils, IWHTMLTag, IWBS4Common,
  IWBS4CustomRegion, IWBS4CustomControl;

type
  TIWBS4ListType = (bs4ltNone, bs4ltDropDownMenu, bs4ltGroup, bs4ltInline, bs4ltNav, bs4ltPager, bs4ltPagination, bs4ltPaginationLg, bs4ltPaginationSm, bs4ltBreadcrumb);

const
  aIWBS4ListType: array[bs4ltNone..bs4ltBreadcrumb] of string = ('', 'dropdown-menu', 'list-group', 'list-inline', 'nav navbar-nav', 'pager', 'pagination', 'pagination pagination-lg', 'pagination pagination-sm', 'breadcrumb');

type
  {$include IWPlatformAttrib.inc}
  TIWBS4List = class(TIWBS4CustomRegion)
  private
    FListType: TIWBS4ListType;
    procedure SetListType(const Value: TIWBS4ListType);
  protected
    procedure InternalRenderCss(var ACss: string); override;
    procedure SetParent(AParent: TWinControl); override;
  public
    constructor Create(AOwner: TComponent); override;

    class procedure WrapItem(AControl: TIWBS4CustomControl; var AHTMLTag: TIWHTMLTag);
  published
    property BSListType: TIWBS4ListType read FListType write SetListType default bs4ltNone;
  end;

implementation

uses
  IWBS4NavBar, IWBS4Region;

constructor TIWBS4List.Create(AOwner: TComponent);
begin
  inherited;
  FTagName := 'ul';
end;

procedure TIWBS4List.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, aIWBS4ListType[FListType]);
  inherited;
end;

procedure TIWBS4List.SetListType(const Value: TIWBS4ListType);
begin
  if Parent is TIWBS4NavBarBase then
    FListType := bs4ltNav
  else
    FListType := Value;
  Invalidate;
end;

procedure TIWBS4List.SetParent(AParent: TWinControl);
begin
  inherited;

  if AParent is TIWBS4NavBarBase then
  begin
    FListType := bs4ltNav
  end
  else if (AParent is TIWBS4Region) and (TIWBS4Region(Parent).BSRegionType = bs4rtDropDown) then
  begin
    FListType := bs4ltDropDownMenu;
  end;
end;

class procedure TIWBS4List.WrapItem(AControl: TIWBS4CustomControl; var AHTMLTag: TIWHTMLTag);
var
  xHTMLTag: TIWHTMLTag;
begin
  if AControl.Parent is TIWBS4List then
  begin
    xHTMLTag := TIWHTMLTag.CreateTag('li');

    case TIWBS4List(AControl.Parent).BSListType of
      bs4ltGroup:
        xHTMLTag.AddClassParam('list-group-item');
    end;

    xHTMLTag.Contents.AddTagAsObject(AHTMLTag);
    AHTMLTag := xHTMLTag;
  end;
end;

end.

