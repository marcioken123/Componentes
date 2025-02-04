unit GeoADOQuery;

interface

uses
  Forms, Classes, SysUtils, Graphics, StdCtrls, Messages,
  ExtCtrls, ComCtrls, Controls, Db, DBTables, DBCtrls, Dialogs,
  Buttons, ADODB, Windows;

type
  TGeoADOQuery = class(TADOQuery)
  protected
    { Protected declarations }
    RConfirmDelete: Boolean;
    procedure SetConfirmDelete(Confirm: Boolean);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ClassBeforeDelete(Dataset: TDataset);
  private
    { Private declarations }
  published
    { Published declarations }
    property ConfirmDelete: Boolean read RConfirmDelete write SetConfirmDelete default True;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoADOQuery]);
end;

constructor TGeoADOQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Self.BeforeDelete := ClassBeforeDelete;
end;

destructor TGeoADOQuery.Destroy;
begin
  inherited Destroy;
end;

procedure TGeoADOQuery.SetConfirmDelete(Confirm: Boolean);
begin
  RConfirmDelete := Confirm;
end;

procedure TGeoADOQuery.ClassBeforeDelete(Dataset: TDataset);
begin
  if RConfirmDelete then
    if Application.MessageBox(PChar('Deseja realmente excluir o registro?'), PChar('Confirmação'), MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = mrNo then
      Abort;
end;

end.
