unit Abcpanel;

interface
uses
  Classes, ExtCtrls, Graphics;

type
  TabcEdgePanel = class(Tpanel)
  private
  published
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FSPremium', [TabcEdgePanel]);
end;
end.
