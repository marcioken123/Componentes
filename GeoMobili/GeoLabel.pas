unit GeoLabel;

interface

uses
  Forms, Classes, SysUtils, Graphics, StdCtrls, Dialogs, DBCtrls,
  ExtCtrls, ComCtrls, Controls, Db, DBTables, Messages,
  Buttons, Windows;

type
  TLabelType = (ltCustom, ltLink, ltDateTime);

  TLinkedControl = record
    DataSource: TDataSource;
    Component: TComponent; 
  end;

  TGeoLabel = class(TLabel)
  protected
    { Protected declarations }
    RLabelType: TLabelType;
    TmpLabel: TTimer;
    MaskDateTime: String;
    RLinkedControl: TLinkedControl;
  public
    { Public declarations }
    procedure SetLabelType(LabelType: TLabelType);
    procedure SetMaskDateTime(Mask: String);
    procedure MouseEnter(Sender: TObject);
    procedure MouseLeave(Sender: TObject);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure TmpLabelOnTimer(Sender: TObject);
    procedure SetLinkedControl(Control: TLinkedControl);
  private
    { Private declarations }
  published
    { Published declarations }
    property DateTimeFormat: String read MaskDateTime write SetMaskDateTime;
    property LabelType: TLabelType read RLabelType write SetLabelType default ltCustom;
    property LinkedControl: TLinkedControl read RLinkedControl write SetLinkedControl;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoLabel]);
end;

procedure TGeoLabel.TmpLabelOnTimer(Sender: TObject);
begin
  if Self.LabelType = ltDateTime then
    Self.Caption := FormatDateTime(MaskDateTime, Now);
end;

constructor TGeoLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  TmpLabel := TTimer.Create(Self);
  TmpLabel.Interval := 0;
  Self.OnMouseEnter := MouseEnter;
  Self.OnMouseLeave := MouseLeave;
end;

destructor TGeoLabel.Destroy;
begin
  TmpLabel.Free;
  inherited Destroy;
end;

procedure TGeoLabel.MouseEnter(Sender: TObject);
begin
  if RLabelType = ltLink then
    Self.Font.Style := Self.Font.Style + [fsBold];
end;

procedure TGeoLabel.MouseLeave(Sender: TObject);
begin
  if RLabelType = ltLink then
    Self.Font.Style := Self.Font.Style - [fsBold];
end;

procedure TGeoLabel.SetMaskDateTime(Mask: String);
begin
  MaskDateTime := Mask; 
end;

procedure TGeoLabel.SetLabelType(LabelType: TLabelType);
begin
  RLabelType := LabelType;
  Self.Cursor := crDefault;

  if RLabelType = ltDateTime then
  begin
    TmpLabel.Interval := 1000;
    TmpLabel.OnTimer := TmpLabelOnTimer;
  end;

  if RLabelType = ltLink then
  begin
    Self.Cursor := crHandPoint;
    Self.Font.Style := [fsUnderline];    
  end;
end;

procedure TGeoLabel.SetLinkedControl(Control: TLinkedControl);
begin
  RLinkedControl := Control;
end;

end.
