unit GeoDBImage;

interface

uses
  Forms, Classes, SysUtils, Graphics, StdCtrls, DBCtrls, Dialogs,
  Extctrls, ComCtrls, Controls, Db, DBTables, Buttons, Messages;

type
  TGeoDBImage = class(TImage)
  protected
    { Protected declarations }
  public
    { Public declarations }
  private
    { Private declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoDBImage]);
end;

end.
 