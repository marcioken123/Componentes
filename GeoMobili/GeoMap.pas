unit GeoMap;

interface

uses
  Forms, Classes, SysUtils, Graphics, StdCtrls, Extctrls, Comctrls,
  Controls, Db, DbTables, DbCtrls, Buttons, OleCtrls, MapObjects2_TLB,
  ComObj, Windows, Messages, Dialogs, ActiveX;

type
  TmoOptions = record
    DirMapa: String;
    FileMapa: String;
    DirGeoRule: String;
    NomeRua: String;
    m_FromLeft: String;
    m_FromRight: String;
    m_ToLeft: String;
    m_ToRight: String;
    m_PreDir: String;
    m_PreType: String;
    m_StreetName: String;
    m_StreetType: String;
    m_SufDir: String;
    m_LeftZone: String;
    m_RightZone: String;
  end;

  TmoAction = (moCustom, moZoomOut, moZoomIn, moMover);

  TGeoMap = class(TMap)
  protected
    { Protected declarations }
    Symbol : IMoSymbol;
    gBoolPan : Boolean;
    AddrChanged : Boolean;
    Standardizer : IMoStandardizer;
    Coder : IMoGeocoder;
    ZipChanged : Boolean;
    Dataset : IMoGeoDataset;
    RmoOptions: TmoOptions;
    RmoAction: TmoAction;
    procedure SetmoAction(Action: TmoAction);
  public
    { Public declarations }
    moOptions: TmoOptions;
    property moAction: TmoAction read RmoAction write SetmoAction;
    constructor Create(Aowner: TComponent); override;
    destructor Destroy; override;
    procedure SetIndexQueries;
    procedure BuildIndex;
    procedure Open;
    procedure MapAfterTrackingLayerDraw(Sender: TObject; hDC: Cardinal);
    procedure MapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    function FindAddress(StreetName, ZipCode: String; CmbCand: TComboBox = nil): Integer;
  private
    { Private declarations }
  published
    { Published declarations }
end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoMap]);
end;

constructor TGeoMap.Create(Aowner: TComponent);
begin
  inherited Create(Aowner);

  Self.OnAfterTrackingLayerDraw := MapAfterTrackingLayerDraw;
  Self.OnMouseDown := MapMouseDown;
end;

destructor TGeoMap.Destroy;
begin
  inherited Destroy;
end;

procedure TGeoMap.SetmoAction(Action: TmoAction);
begin
  RmoAction := Action;

  case RmoAction of
  moCustom: Self.MousePointer := 0; // Default
  moZoomIn: Self.MousePointer := 51; // Zoom In
  moZoomOut: Self.MousePointer := 52; // Zoom Out
  moMover: Self.MousePointer := 53; // Pan
  end;
end;

procedure TGeoMap.SetIndexQueries;
var
  StrQuery : IMoStrings;
begin
  StrQuery := IMoStrings(CreateOleObject('MapObjects2.Strings'));
  StrQuery.Add('SN? & ZN');
  StrQuery.Add('SN?');

  Coder.SearchQueries := StrQuery;

  if not Coder.Valid then
    Application.MessageBox('Geocodificação inválida.', 'Erro', MB_ICONERROR);
end;

procedure TGeoMap.BuildIndex;
begin
  if Coder.IndexStatus <> 3 then

  if not Coder.AddIndex(Self.moOptions.m_StreetName, '', mgIndexTypeSoundex) then
  begin
    ShowMessage('StreetName:  Cannot build Geocoding Index');
    Exit;
  end;

  if not Coder.AddIndex(Self.moOptions.m_LeftZone, Self.moOptions.m_rightZone, mgIndexTypeNormal) then
  begin
    ShowMessage('Zone:  Cannot build Geocoding Index');
    Exit;
  end;

  if not Coder.BuildIndices(True) then
  begin
    ShowMessage('Build:  Cannot build Geocoding Index');
    Exit;
  end
  else
    ShowMessage('Building Geocoding index ...');

  SetIndexQueries;
end;

procedure TGeoMap.Open;
var
  dDataCon : IMoDataConnection;
  layer : IMoMapLayer;
  Sym : IMoSymbol;
  layers : IMoLayers;
  OleFont: Variant;
  Font: TFont;

  procedure MostrarRuas;
  var
    LabelRua: IMoLabelPlacer;
    Layer: IMoMapLayer;
  begin
    Layer := IMoMapLayer(Self.Layers.Item(0));
    Layer := IMoMapLayer(CreateOleObject('MapObjects2.MapLayer'));
    LabelRua := ImoLabelPlacer(CreateOleObject('MapObjects2.LabelPlacer'));

    LabelRua.Field := Self.moOptions.NomeRua;
    LabelRua.PlaceAbove := True;
    LabelRua.DrawBackground := True;
    LabelRua.AllowDuplicates := True;
    LabelRua.MaskLabels := True;
    LabelRua.MaskColor := Self.BackColor;
    Layer.Renderer := LabelRua;
    Self.Layers.Add(Layer);
    IMoMapLayer(Self.Layers.Item(0)).Renderer := LabelRua;
    Self.Refresh;
  end;
begin
  dDataCon := IMoDataConnection(CreateOleObject('MapObjects2.DataConnection'));
  dDataCon.Database := Self.moOptions.DirMapa;

  if (not dDataCon.Connect) then
  begin
    ShowMessage('invalid Data Connection');
    Exit;
  end;

  layer := IMoMapLayer(CreateOleObject('MapObjects2.MapLayer'));
  Dataset := IMoGeoDataset(dDataCon.FindGeoDataset(Self.moOptions.FileMapa));

  layer.GeoDataset := Dataset;
  Sym := layer.Symbol;
  Sym.Color := clBlue;
  layers := Self.Layers;
  layers.Add(layer);

  AddrChanged := False;
  gBoolPan := True;

  Standardizer := IMoStandardizer(CreateOleObject('MapObjects2.Standardizer'));
  Coder := IMoGeocoder(CreateOleObject('MapObjects2.GeoCoder'));

  Standardizer.StandardizingRules := Self.moOptions.DirGeoRule + 'us_addr.stn';
  Standardizer.IntersectionStandardizingRules := Self.moOptions.DirGeoRule + 'us_intsc.stn';

  if (not Standardizer.Valid) then
  begin
    ShowMessage('Standardizer is not valid.-- exiting; Check path to GeoRules');
    Exit;
  end;

  Coder.Standardizer := Standardizer;
  Coder.StreetTable  := Dataset;

  Coder.MatchRules := Self.moOptions.DirGeoRule + 'us_addr1.mat';
  Coder.IntersectionMatchRules := Self.moOptions.DirGeoRule + 'us_intsc1.mat';

  Coder.MatchVariableField['FromLeft'] := Self.moOptions.m_FromLeft;
  Coder.MatchVariableField['FromRight'] := Self.moOptions.m_FromRight;
  Coder.MatchVariableField['ToLeft'] := Self.moOptions.m_ToLeft;
  Coder.MatchVariableField['ToRight'] := Self.moOptions.m_ToRight;
  Coder.MatchVariableField['PreDir'] := Self.moOptions.m_PreDir;
  Coder.MatchVariableField['PreType'] := Self.moOptions.m_PreType;
  Coder.MatchVariableField['StreetName'] := Self.moOptions.m_StreetName;
  Coder.MatchVariableField['StreetType'] := Self.moOptions.m_StreetType;
  Coder.MatchVariableField['SufDir'] := Self.moOptions.m_SufDir;
  Coder.MatchVariableField['LeftZone'] := Self.moOptions.m_LeftZone;
  Coder.MatchVariableField['RightZone'] := Self.moOptions.m_RightZone;

  if Coder.IndexStatus = 3 then
    SetIndexQueries
  else
    BuildIndex;

  Coder.SpellingSensitivity := 60;
  Coder.MinimumMatchScore := 60;

  Font := TFont.Create;
  Font.Name := 'Webdings';
  Font.Size := 20;
  OleFont := FontToOleFont(Font);

  Symbol := IMoSymbol(CreateOleObject('MapObjects2.Symbol'));
  Symbol.SymbolType := 0;
  Symbol.Style := moTrueTypeMarker;
  Symbol.Font := IFontDisp(IDispatch(OleFont));
  Symbol.Color := moRed;
  Symbol.Size := 15;
  Symbol.CharacterIndex := 70;

  //MostrarRuas;
end;

procedure TGeoMap.MapAfterTrackingLayerDraw(Sender: TObject; hDC: Cardinal);
begin
  if Coder.CandidateCount > 0 then
    Self.DrawShape(Coder.LocateCandidate(0).Location, Symbol);
end;

procedure TGeoMap.MapMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Rect: IMoRectangle;
begin
  if (moAction = moZoomIn) then
    Self.Extent := Self.TrackRectangle
  else
  if (moAction = moZoomOut) then
  begin
    Rect := IMoRectangle(CreateOleObject('MapObjects2.Rectangle'));
    Rect := IMoRectangle(IDispatch(Self.Extent));
    Self.Extent := Rect;
    Rect.ScaleRectangle((1.5));
    Self.Extent := Rect;
  end
  else
  if (moAction = moMover) then
  begin
    Self.Pan;
  end;
end;

function TGeoMap.FindAddress(StreetName, ZipCode: String; CmbCand: TComboBox = nil): Integer;
  procedure FillCandList;
  var
    i: Integer;
  begin
    CmbCand.Clear;

    if Coder.CandidateCount <> 0 then
      for i := 0 to Coder.CandidateCount - 1 do
        CmbCand.Items.Add(Coder.Candidate[i]);

    CmbCand.ItemIndex := 0;
  end;
begin
  if Standardizer.StandardizeAddress(StreetName) then
  begin
    Standardizer.FieldValue['ZN'] := ZipCode;
    AddrChanged := False;
    ZipChanged := False;
    FindAddress := Coder.GenerateCandidates;

    { 0 Failed. No matches }
    { 1 Success.  Single best match }
    { 2 Success.Multiple best matches }
    { 3 Partial success. Nothing above minimum score }
  end;

  FillCandList;
  Self.TrackingLayer.Refresh(True, Self.FullExtent);

  if Coder.CandidateCount > 0 then
    Self.CenterAt(Coder.LocateCandidate(CmbCand.ItemIndex).location.x, Coder.LocateCandidate(CmbCand.ItemIndex).Location.y)
  else
    Application.MessageBox('Não foi possível geocodificar o endereço.', 'Erro', MB_ICONERROR);
end;

end.
