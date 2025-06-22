unit IWBS4ButtonGroup;

interface
{$Include IWBootstrap4.inc}

uses
  SysUtils, Classes, Controls, StrUtils, IWBS4Common, IWBS4Customregion;

type
  {$include IWPlatformAttrib.inc}
  TIWBS4ButtonGroup = class(TIWBS4CustomRegion)
  private
    FVertical: Boolean;
    FJustified: Boolean;
    FSize: TIWBS4Size;
    procedure SetJustified(const Value: Boolean);
    procedure SetSize(const Value: TIWBS4Size);
    procedure SetVertical(const Value: Boolean);
  protected
    procedure InternalRenderCss(var ACss: string); override;
  public
    constructor Create(AOwner: TComponent); override;
    function GetRoleString: string; override;
  published
    property BSVertical: Boolean read FVertical write SetVertical default False;
    property BSJustified: Boolean read FJustified write SetJustified default False;
    property BSButtonSize: TIWBS4Size read FSize write SetSize default bs4szDefault;
  end;

implementation

uses
  IWBS4NavBar;

constructor TIWBS4ButtonGroup.Create(AOwner: TComponent);
begin
  inherited;

  FVertical := False;
  FJustified := False;
  FSize := bs4szDefault;
end;

function TIWBS4ButtonGroup.GetRoleString: string;
begin
  Result := 'group';
end;

procedure TIWBS4ButtonGroup.InternalRenderCss(var ACss: string);
begin
  if FVertical then
    TIWBS4Common.AddCssClass(ACss, 'btn-group-vertical')
  else
    TIWBS4Common.AddCssClass(ACss, 'btn-group');
  if FSize <> bs4szDefault then
  begin
    TIWBS4Common.AddCssClass(ACss, 'btn-group-' + aIWBS4Size[FSize]);
  end;
  if FJustified then
  begin
    TIWBS4Common.AddCssClass(ACss, 'btn-group-justified');
  end;
  if Parent is TIWBS4NavBarBase then
  begin
    TIWBS4Common.AddCssClass(ACss, 'navbar-btn');
  end;

  inherited;
end;

procedure TIWBS4ButtonGroup.SetJustified(const Value: Boolean);
begin
  FJustified := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4ButtonGroup.SetSize(const Value: TIWBS4Size);
begin
  FSize := Value;
  AsyncRefreshControl;
end;

procedure TIWBS4ButtonGroup.SetVertical(const Value: Boolean);
begin
  FVertical := Value;
  AsyncRefreshControl;
end;

end.

