unit IWBS4Badge;

interface

uses
  SysUtils, Classes, IWBS4Color;

type
  TIWBS4Badge = class(TPersistent)
  private
    FEnabled: Boolean;
    FBadgeOnRight: Boolean;
    FContextualColor: TIWBS4ContextualClass;
    FBadgePill: Boolean;
    FBadgeText: string;
  public
    constructor Create(AOwner: TComponent);
  published
    property Enabled: Boolean read FEnabled write FEnabled default False;
    property BadgeOnRight: Boolean read FBadgeOnRight write FBadgeOnRight default True;
    property ContextualColor: TIWBS4ContextualClass read FContextualColor write FContextualColor default bs4cxLight;
    property BadgePill: Boolean read FBadgePill write FBadgePill default False;
    property BadgeText: string read FBadgeText write FBadgeText;
  end;

implementation

constructor TIWBS4Badge.Create(AOwner: TComponent);
begin
  FContextualColor := bs4cxLight;
  FBadgeOnRight := True;
end;

end.

