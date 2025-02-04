unit vgRxDBCt;

interface
uses
  Classes, ExtCtrls, Graphics, Grids, DBGrids;

type
  TvgDBGrid = class(TDBGrid)
  private
  published
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FSPremium', [TvgDBGrid]);
end;

end.
