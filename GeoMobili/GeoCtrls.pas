unit GeoCtrls;

interface

uses
  Classes, StdCtrls, ComCtrls, Dialogs, Messages, Controls, ExtCtrls,
  Graphics, Forms, Db, DbTables, Buttons, ActnList, GeoDBEdit;

type
  TShape = (bsCustom, bsOval);

  TBasicAction = (baCustom, baEditFields, baClose);

  TGeoButton = class(TSpeedButton)
  protected
    { Protected declarations }
    RDataSource: TDataSource;
    RShape: TShape;
    RModalResult: TModalResult;
    BtnFunc: TActionList;
    RBasicAction: TBasicAction;
    FReadOnly: Boolean;
    procedure GetDataSource(DataSource: TDataSource);
    procedure SetShape(Shape: TShape);
    procedure SetModalResult(ModalResult: TModalResult);
    procedure SetBasicAction(Action: TBasicAction);
  private
    { Private declarations }
  published
    { Published declarations }
    property DataSource: TDataSource read RDataSource write GetDataSource;
    property Shape: TShape read RShape write SetShape default bsCustom;
    property ModalResult: TModalResult read RModalResult write SetModalResult default mrNone;
    property BasicAction: TBasicAction read RBasicAction write SetBasicAction default baCustom;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    procedure BtnEditFieldsClick(Sender: TObject);    
  end;

procedure Register;

implementation

uses StrUtils;

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoButton]);
end;

procedure TGeoButton.GetDataSource(DataSource: TDataSource);
begin
  RDataSource := DataSource;
end;

procedure TGeoButton.SetShape(Shape: TShape);
begin
  RShape := Shape;
end;

procedure TGeoButton.SetModalResult(ModalResult: TModalResult);
begin
  RModalResult := ModalResult
end;

procedure TGeoButton.SetBasicAction(Action: TBasicAction);
begin
  RBasicAction := Action;
end;

constructor TGeoButton.Create(AOwner: TComponent);
var
  BtnEditFields: TAction;
begin
  inherited Create(AOwner);

  Cursor := crHandPoint;
  Self.OnClick := BtnEditFieldsClick;
  BtnFunc := TActionList.Create(Self);

  BtnEditFields := TAction.Create(AOwner);
  BtnEditFields.ActionList := BtnFunc;
  BtnEditFields.OnExecute := BtnEditFieldsClick;
end;

destructor TGeoButton.Destroy;
begin
  BtnFunc.Free;

  inherited Destroy;
end;

procedure TGeoButton.Click;
begin
  if Self.GroupIndex > 0 then
    Self.Down := True;

  GetParentForm(Self).ModalResult := RModalResult;

  inherited Click;
end;

procedure TGeoButton.BtnEditFieldsClick(Sender: TObject);
var
  i: Integer;
begin
  if BasicAction = baEditFields then
  begin
    FReadOnly := not FReadOnly;

    for i := 0 to GetParentForm(Self).ComponentCount - 1 do
      if GetParentForm(Self).Components[i] is TGeoDBEdit then
        TGeoDBEdit(GetParentForm(Self).Components[i]).SetReadOnly(FReadOnly);
  end;
end;

{ --------------------------// GeoControl //---------------------------- }

{
  object PnlControl: TPanel
    Left = 0
    Top = 153
    Width = 177
    Height = 453
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 1
    object PnlA: TPanel
      Left = 1
      Top = 1
      Width = 175
      Height = 319
      Align = alClient
      Color = clBtnShadow
      TabOrder = 0
      DesignSize = (
        175
        319)
      object BtnA: TSpeedButton
        Left = 0
        Top = 0
        Width = 175
        Height = 33
        Caption = 'Layers'
        Transparent = False
        OnClick = BtnAClick
      end
    end
    object PnlB: TPanel
      Tag = 1
      Left = 1
      Top = 320
      Width = 175
      Height = 33
      Align = alBottom
      Color = clBtnShadow
      TabOrder = 1
      object BtnB: TSpeedButton
        Tag = 1
        Left = -2
        Top = 0
        Width = 177
        Height = 33
        Caption = 'Calendario'
        Transparent = False
        OnClick = BtnAClick
      end
    end
    object PnlC: TPanel
      Tag = 2
      Left = 1
      Top = 353
      Width = 175
      Height = 33
      Align = alBottom
      Color = clBtnShadow
      TabOrder = 2
      object BtnC: TSpeedButton
        Tag = 2
        Left = -2
        Top = 0
        Width = 177
        Height = 33
        Caption = 'Contatos'
        Transparent = False
        OnClick = BtnAClick
      end
    end
    object PnlD: TPanel
      Tag = 3
      Left = 1
      Top = 386
      Width = 175
      Height = 33
      Align = alBottom
      Color = clBtnShadow
      TabOrder = 3
      object BtnD: TSpeedButton
        Tag = 3
        Left = -2
        Top = 0
        Width = 177
        Height = 33
        Caption = 'Tarefas'
        Transparent = False
        OnClick = BtnAClick
      end
    end
    object PnlE: TPanel
      Tag = 4
      Left = 1
      Top = 419
      Width = 175
      Height = 33
      Align = alBottom
      Color = clBtnShadow
      TabOrder = 4
      object BtnE: TSpeedButton
        Tag = 4
        Left = -2
        Top = 0
        Width = 177
        Height = 33
        Caption = 'Observações'
        Transparent = False
        OnClick = BtnAClick
      end
    end
  end

{ --------------------------// GeoControl //---------------------------- }

end.
