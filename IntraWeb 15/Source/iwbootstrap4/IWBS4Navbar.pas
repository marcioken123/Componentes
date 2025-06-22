unit IWBS4NavBar;

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, StrUtils, IWRenderContext, IWHTMLTag, IWBS4CustomRegion,
  IWBS4Common;

type
  TIWBS4NavBarFixed = (bs4nvfxNone, bs4nvfxTop, bs4nvfxBottom);

  TIWBS4NavBarBase = class(TIWBS4CustomRegion);

  {$include IWPlatformAttrib.inc}
  TIWBS4NavBar = class(TIWBS4NavBarBase)
  private
    FFluid: Boolean;
    FFixed: TIWBS4NavBarFixed;
    FInverse: Boolean;
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function RenderHTML(AContext: TIWCompContext): TIWHTMLTag; override;
  published
    property BSFluid: Boolean read FFluid write FFluid default False;
    property BSInverse: Boolean read FInverse write FInverse default False;
    property BSFixed: TIWBS4NavBarFixed read FFixed write FFixed default bs4nvfxNone;
  end;

  {$include IWPlatformAttrib.inc}
  TIWBS4NavBarHeader = class(TIWBS4NavBarBase)
  protected
    procedure InternalRenderCss(var ACss: string); override;
  end;

  {$include IWPlatformAttrib.inc}
  TIWBS4NavBarCollapse = class(TIWBS4NavBarBase)
  protected
    procedure InternalRenderCss(var ACss: string); override;
  end;

implementation

uses
  IW.Common.SysTools;

constructor TIWBS4NavBar.Create(AOwner: TComponent);
begin
  inherited;
  FFluid := False;
  FFixed := bs4nvfxNone;
  FInverse := False;
  FTagName := 'nav';
end;

procedure TIWBS4NavBar.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, 'navbar navbar-' + iif(FInverse, 'inverse', 'default'));
  if FFixed = bs4nvfxTop then
  begin
    TIWBS4Common.AddCssClass(ACss, 'navbar-fixed-top')
  end
  else if FFixed = bs4nvfxBottom then
  begin
    TIWBS4Common.AddCssClass(ACss, ' navbar-fixed-bottom');
  end;

  inherited;
end;

function TIWBS4NavBar.RenderHTML(AContext: TIWCompContext): TIWHTMLTag;
begin
  Result := inherited;

  FRegionDiv := Result.Contents.AddTag('div');
  FRegionDiv.AddClassParam('container' + iif(FFluid, '-fluid'));
end;

procedure TIWBS4NavBarHeader.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, 'navbar-header');

  inherited;
end;

procedure TIWBS4NavBarCollapse.InternalRenderCss(var ACss: string);
begin
  TIWBS4Common.AddCssClass(ACss, 'navbar-collapse');
  TIWBS4Common.AddCssClass(ACss, 'collapse');

  inherited;
end;

end.

