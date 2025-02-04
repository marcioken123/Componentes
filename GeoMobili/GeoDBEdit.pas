unit GeoDBEdit;

interface

uses
  Forms, Classes, SysUtils, Graphics, StdCtrls, Extctrls, Comctrls,
  Controls, Db, DbTables, DbCtrls, Buttons, Messages, Dialogs;

type
  TGeoDBEdit = class(TDBEdit)
    LblDisplay: TDBText;
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetReadOnly(Flag: Boolean = True);
  private
    { Private declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoDBEdit]);
end;

constructor TGeoDBEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TGeoDBEdit.Destroy;
begin
  inherited Destroy;
end;

procedure TGeoDBEdit.SetReadOnly(Flag: Boolean = True);
begin
  if Flag then
  begin
    LblDisplay := TDBText.Create(Self);
    LblDisplay.Parent := Self.Parent;
    LblDisplay.Left := Left;
    LblDisplay.DataSource := Self.DataSource;
    LblDisplay.DataField := Self.DataField;
    LblDisplay.Width := Self.Width;
    LblDisplay.Top := (Top + (Height div 2)) - (LblDisplay.Height div 2);
  end
  else
    LblDisplay.Free;

  Self.Visible := not Flag;
end;

end.
