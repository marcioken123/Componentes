unit GeoDBComboBox;

interface

uses
  Forms, Classes, SysUtils, Graphics, Stdctrls, Windows, Dialogs,
  ExtCtrls, Comctrls, Controls, Db, DbTables, DBCtrls, Buttons,
  Messages, GeoStringList;

type
  TGeoDBComboBox = class(TDBCombobox)
    LblDisplay: TDBText;
  protected
    { Protected declarations }
    RGeoStringList: TGeoStringList;
    procedure SetGeoStringList(StringList: TGeoStringList);
  public
    { Public declarations }
    procedure SetReadOnly(Flag: Boolean = True);
  private
    { Private declarations }
  published
    { Published declarations }
    property GeoStringList: TGeoStringList read RGeoStringList write SetGeoStringList;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoDBComboBox]);
end;

procedure TGeoDBComboBox.SetReadOnly(Flag: Boolean = True);
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

procedure TGeoDBComboBox.SetGeoStringList(StringList: TGeoStringList);
begin
  RGeoStringList := StringList;
  Self.Items := RGeoStringList.Strings;
end;

end.
