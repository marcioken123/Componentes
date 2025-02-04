unit GeoTreeView;

interface

uses
  Forms, Classes, SysUtils, Graphics, StdCtrls, Extctrls, Comctrls,
  Controls, Db, DbTables, DbCtrls, Buttons, Types, Windows, Messages,
  Dialogs;

type
  TGeoTreeView = class(TTreeView)
      ImgCheck: TImageList;
    protected
      { Protected declarations }
    public
      { Public declarations }
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Click; override;
    private
      { Private declarations }
    published
      { Published declarations }
  end;

const
  cUnChecked = 1;
  cChecked = 2;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoTreeView]);
end;

constructor TGeoTreeView.Create(AOwner: TComponent);
var
  Bmp: Graphics.TBitmap;
begin
  inherited Create(AOwner);

  Bmp := Graphics.TBitmap.Create;
  Bmp.Handle := LoadBitmap(HInstance, 'BmpChecked');

  ImgCheck := TImageList.Create(Self);
  ImgCheck.Add(Bmp, nil);
  ImgCheck.Add(Bmp, nil);

  Bmp.Handle := LoadBitmap(HInstance, 'BmpUnchecked');
  ImgCheck.Add(Bmp, nil);
  Bmp.Free;

  StateImages := ImgCheck;
end;

destructor TGeoTreeView.Destroy;
begin
  ImgCheck.Free;

  inherited Destroy;
end;

procedure TGeoTreeView.Click;
var
  P:TPoint;
begin
  GetCursorPos(P);
  P := ScreenToClient(P);
  if (htOnStateIcon in GetHitTestInfoAt(P.X,P.Y)) then
  begin
    if Selected.StateIndex = cUnChecked then
      Selected.StateIndex := cChecked
    else if Selected.StateIndex = cChecked then
      Selected.StateIndex := cUnChecked;
  end;

  inherited Click;
end;

end.
