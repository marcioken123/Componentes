unit IWBS4Deprecated;

interface

uses
  SysUtils, Classes, Controls, StrUtils, IWBS4Common, IWBS4CustomRegion;

type
  TIWBS4UnorderedList = class(TIWBS4CustomRegion)
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
  end deprecated;

implementation

uses IWBS4NavBar;

{$region 'TIWBS4UnorderedList'}
constructor TIWBS4UnorderedList.Create(AOwner: TComponent);
begin
  inherited;

  FTagName := 'ul';
end;

procedure TIWBS4UnorderedList.InternalRenderCss(var ACss: string);
begin
  if Parent is TIWBS4NavBarBase
    then TIWBS4Common.AddCssClass(ACss, 'nav navbar-nav')
    else TIWBS4Common.AddCssClass(ACss, 'list-group');

  inherited;
end;
{$endregion}

end.
