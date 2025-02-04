unit GeoToolBar;

interface

uses
  Forms, Classes, SysUtils, Graphics, StdCtrls, ExtCtrls, ComCtrls,
  Controls, Db, DbTables, DbCtrls, Buttons, ToolWin, Windows, GeoMap,
  GeoCtrls, StrUtils;

type
  TBtnType = (btZoomIn, btZoomOut, btMover, btMapInfo, btFullExtend, btFullScreen);
  TButtonSet = set of TBtnType;

  TGeoToolBar = class(TPanel)
  protected
    { Protected declarations }
    BtnZoomIn: TGeoButton;
    BtnZoomOut: TGeoButton;
    BtnMover: TGeoButton;
    BtnMapInfo: TGeoButton;
    BtnFullExtend: TGeoButton;
    RGeoMap: TGeoMap;
    ImgList: TImageList;
    FVisibleButtons: TButtonSet;
    Buttons: array[0..5] of TGeoButton;
    procedure SetVisible(ButtonSet: TButtonSet);
    procedure SetMapObjects(GeoMap: TGeoMap);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Resize; override;
  private
    { Private declarations }
    procedure BtnZoomInClick(Sender: TObject);
    procedure BtnZoomOutClick(Sender: TObject);
    procedure BtnMoverClick(Sender: TObject);
    procedure BtnMapInfoClick(Sender: TObject);
    procedure BtnFullExtendClick(Sender: TObject);
    procedure BtnFullScreenClick(Sender: TObject);
  published
    { Published declarations }
    property MapObjects: TGeoMap read RGeoMap write SetMapObjects;
    property VisibleButtons: TButtonSet read FVisibleButtons write SetVisible default [btZoomIn, btZoomOut, btMover, btMapInfo, btFullExtend];
  end;

const
  ButtonCount = 5;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoToolBar]);
end;

constructor TGeoToolBar.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited Create(AOwner);
  Self.Caption := '';
  Self.BevelInner := bvNone;
  Self.BevelOuter := bvNone;

  Buttons[0] := BtnZoomIn;
  Buttons[1] := BtnZoomOut;
  Buttons[2] := BtnMover;
  Buttons[3] := BtnMapInfo;
  Buttons[4] := BtnFullExtend;

  for i := 0 to ButtonCount do
  begin
    Buttons[i] := TGeoButton.Create(Self);
    Buttons[i].Parent := Self;
    Buttons[i].Transparent := True;
    Buttons[i].Top := 0;
    Buttons[i].Width := Self.Width div (ButtonCount + 1);
    Buttons[i].Left := (Buttons[i].Width * i);
    Buttons[i].Height := Self.Height;

    case i of
    0:
    begin
      Buttons[i].Glyph.Handle := LoadBitmap(HInstance, 'BmpZoomIn');
      Buttons[i].OnClick := BtnZoomInClick;
    end;
    1:
    begin
      Buttons[i].Glyph.Handle := LoadBitmap(HInstance, 'BmpZoomOut');
      Buttons[i].OnClick := BtnZoomOutClick;
    end;
    2:
    begin
      Buttons[i].Glyph.Handle := LoadBitmap(HInstance, 'BmpMover');
      Buttons[i].OnClick := BtnMoverClick;
    end;
    3:
    begin
      Buttons[i].Glyph.Handle := LoadBitmap(HInstance, 'BmpMapInfo');
      Buttons[i].OnClick := BtnMapInfoClick;
    end;
    4:
    begin
      Buttons[i].Glyph.Handle := LoadBitmap(HInstance, 'BmpFullExtend');
      Buttons[i].OnClick := BtnFullExtendClick;
    end;
    5:
    begin
      Buttons[i].Glyph.Handle := LoadBitmap(HInstance, 'BmpFullScreen');
      Buttons[i].OnClick := BtnFullScreenClick;
    end;
    end;
  end;
end;

procedure TGeoToolBar.Resize;
var
  i: Integer;
begin
  for i := 0 to ButtonCount do
  begin
    if Buttons[i].Visible then
    begin
      Buttons[i].Width := Self.Width div (ButtonCount + 1);
      Buttons[i].Height := Self.Height;
      Buttons[i].Left := (Buttons[i].Width * i);
    end;
  end;
end;

destructor TGeoToolBar.Destroy;
begin
  inherited Destroy;
end;

procedure TGeoToolBar.SetVisible(ButtonSet: TButtonSet);
var
  i: Integer;
begin
  FVisibleButtons := ButtonSet;

  //ButtonSet[0];

  for i := 0 to ButtonCount do
    //Buttons[i].Visible := Buttons[i] in ButtonSet;
end;

procedure TGeoToolBar.SetMapObjects(GeoMap: TGeoMap);
begin
  RGeoMap := GeoMap;
end;

procedure TGeoToolBar.BtnZoomInClick(Sender: TObject);
begin
  Self.MapObjects.MousePointer := 51;
  Self.MapObjects.moAction := moZoomIn;
end;

procedure TGeoToolBar.BtnZoomOutClick(Sender: TObject);
begin
  Self.MapObjects.MousePointer := 51;
  Self.MapObjects.moAction := moZoomIn;
end;

procedure TGeoToolBar.BtnMoverClick(Sender: TObject);
begin
  Self.MapObjects.MousePointer := 40;
  Self.MapObjects.moAction := moMover;
  Self.MapObjects.Pan;  
end;

procedure TGeoToolBar.BtnMapInfoClick(Sender: TObject);
begin
  Self.MapObjects.MousePointer := 0;
  Self.MapObjects.moAction := moCustom;
  Self.MapObjects.Pan;  
end;

procedure TGeoToolBar.BtnFullExtendClick(Sender: TObject);
begin
  Self.MapObjects.Extent := Self.MapObjects.FullExtent;
end;

procedure TGeoToolBar.BtnFullScreenClick(Sender: TObject);
var
  FrmTela: TForm;
begin
  FrmTela := TForm.Create(GetParentForm(Self));
  FrmTela.WindowState := wsMaximized;
  FrmTela.Color := clBlack;
  FrmTela.ShowModal;
  FrmTela.Free;
end;

end.
