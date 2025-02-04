unit GeoCalendar;

interface

uses
  Forms, Classes, SysUtils, Graphics, StdCtrls, Messages, Buttons,
  Extctrls, Comctrls, Controls, Db, DBTables, DBCtrls, Dialogs,
  Windows, DBGrids;

type
  TGeoCalendar = class(TPanel)
  protected
    { Protected declarations }
    VetorMes: array[0..11] of TMonthCalendar;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  private
    { Private declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoCalendar]);
end;

constructor TGeoCalendar.Create(AOwner: TComponent);
var
  i, fTop, fLeft: Integer;
begin
  inherited Create(AOwner);
  fTop := 0;
  fLeft := 0;

  for i := 0 to 11 do
  begin
    VetorMes[i] := TMonthCalendar.Create(Self);
    VetorMes[i].Parent := Self;
    VetorMes[i].Height := Self.Height div 11;
    VetorMes[i].Width := Self.Width div 3;
    VetorMes[i].Top := fTop;
    VetorMes[i].Left := fLeft;

    fLeft := fLeft + Self.Width;

    if i in [3, 6, 9] then
    begin
      fTop := fTop + (Self.Height div 11);
      fLeft := 0;
    end;
  end;
end;

destructor TGeoCalendar.Destroy;
var
  i: Integer;
begin
  for i := 0 to 11 do
    VetorMes[i].Free;

  inherited Destroy;
end;

end.
