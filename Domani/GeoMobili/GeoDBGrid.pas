unit GeoDBGrid;

interface

uses
  Forms, Classes, SysUtils, Graphics, StdCtrls, Messages,
  Extctrls, Comctrls, Controls, Db, DBTables, DBCtrls,
  Buttons, Dialogs, Windows, DBGrids;

type
  TGeoDBGrid = class(TDBGrid)
  protected
  public
  private
  published
  end;

procedure Register;

implementation

procedure Register;
begin
   RegisterComponents('GeoMobilli', [TGeoDBgrid]);
end;

end.
