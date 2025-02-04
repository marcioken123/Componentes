unit uComboEditGrid;

interface

uses
  SysUtils, Forms, Classes, Controls, StdCtrls, Mask, JvExMask, JvToolEdit;

Type
  TComboGridCustom = class(TPersistent)
  private
    FFormGrid: TCustomForm;
    procedure SetFormGrid(const Value: TCustomForm);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property FormGrid: TCustomForm read FFormGrid write SetFormGrid;
  end;

type
  TComboEditGrid = class(TJvComboEdit)
  private
    FComboGrid: TComboGridCustom;
    procedure SetComboGrid(const Value: TComboGridCustom);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    Constructor Create(AWOner: TComponent); override;
    property ComboGrid: TComboGridCustom read FComboGrid write SetComboGrid;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Tropicom', [TComboEditGrid]);
end;

{ TComboEditGrid }

constructor TComboEditGrid.Create(AWOner: TComponent);
begin
  ComboGrid := TComboGridCustom.Create;
  inherited;
end;

procedure TComboEditGrid.SetComboGrid(const Value: TComboGridCustom);
begin
  FComboGrid := Value;
end;

{ TComboGridCustom }

procedure TComboGridCustom.SetFormGrid(const Value: TCustomForm);
begin
  FFormGrid := Value;
end;

end.
