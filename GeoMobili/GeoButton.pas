unit GeoButton;

interface

uses
  Classes, StdCtrls, ComCtrls, Dialogs, Messages, Controls, ExtCtrls,
  Graphics, Forms, Db, DbTables, Buttons, ActnList;

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
  for i := 0 to GetParentForm(Self).ComponentCount - 1 do

end;

end.