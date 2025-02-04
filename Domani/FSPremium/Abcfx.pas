unit Abcfx;

interface

uses
  Classes, StdCtrls, ExtCtrls;

type
  TabcEffectsImage = class(TImage)
end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FSPremium', [TabcEffectsImage]);
end;

end.
