unit GeoDBLookupComboBox;

interface

uses
  Forms, Classes, SysUtils, Graphics, StdCtrls, ExtCtrls,
  ComCtrls, Controls, Db, DBTables, DBCtrls, Buttons, Messages,
  Dialogs, Windows;

type
  TGeoDBlookupComboBox = class(TDBLookupComboBox)
    LblDisplay: TDBText;
  protected
    { Protected declarations }
  public
    { Public declarations }
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
  RegisterComponents('GeoMobilli', [TGeoDBlookupComboBox]);
end;

procedure TGeoDBlookupComboBox.SetReadOnly(Flag: Boolean = True);
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
