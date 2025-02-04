unit GeoStringList;

interface

uses
  Classes, Forms, Controls, SysUtils, StdCtrls, ExtCtrls, ComCtrls,
  Db, DbTables, ADODB, DBCtrls;

type

  TGeoStringList = class(TComponent)
  private
    FStrings: TStrings;
    procedure SetStrings(Value: TStrings);
  protected
  public
    constructor Create(Owner: TComponent); override;
    destructor  Destroy; override;
  published
    property Strings: TStrings read FStrings write SetStrings;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoStringList]);
end;

constructor TGeoStringList.Create(Owner: TComponent);
begin
  inherited;

  FStrings := TStringList.Create;
end;

destructor TGeoStringList.Destroy;
begin
  FStrings.Free;

  inherited;
end;

procedure TGeoStringList.SetStrings(Value: TStrings);
begin
  FStrings.Assign(Value);
end;

end.
