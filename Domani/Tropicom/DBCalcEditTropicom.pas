unit DBCalcEditTropicom;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask, JvToolEdit, JVDBControls,
  Graphics, Messages;

type
  TDBCalcEditTropicom = class(TJvDBCalcEdit)
  private
    FColorEnter: TColor;
    FColorExit: TColor;
    FColorActive: Boolean;
    FEnterToTab: Boolean;
    FSetLabel: TLabel;
    FColorLabel: TColor;
    FColorDefault: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure SetColorEnter(const Value: TColor);
    procedure SetColorExit(const Value: TColor);
    procedure SetColorActive(const Value: Boolean);
    procedure SetEnterToTab(const Value: Boolean);
    procedure SetSetLabel(const Value: TLabel);
    procedure SetColorLabel(const Value: TColor);
    { Private declarations }
  protected
    { Protected declarations }
  public
    Constructor Create(AOwner: TComponent); override;
    { Public declarations }
  published
     property EnterToTab: Boolean read FEnterToTab write SetEnterToTab;
     property ColorEnter: TColor read FColorEnter write SetColorEnter;
     property ColorExit: TColor read FColorExit write SetColorExit;
     property ColorActive: Boolean read FColorActive write SetColorActive;
     property SetLabel: TLabel read FSetLabel write SetSetLabel;
     property ColorLabel: TColor read FColorLabel write SetColorLabel;
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Protheus', [TDBCalcEditTropicom]);
end;

{ TDBCalcEditTropicom }

procedure TDBCalcEditTropicom.CMEnter(var Message: TCMEnter);
begin
  if Self.SetLabel <> Nil then
     begin
        FColorDefault := Self.SetLabel.Font.Color;
        Self.SetLabel.Font.Color := FColorLabel;
     end;
     
  if ColorActive then
     Self.Color := ColorEnter;
  Inherited;
end;

procedure TDBCalcEditTropicom.CMExit(var Message: TCMExit);
begin
  if Self.SetLabel <> Nil then
     Self.SetLabel.Font.Color := FColorDefault;
     
  if ColorActive then
     Self.Color := ColorExit;
  Inherited;
end;

constructor TDBCalcEditTropicom.Create(AOwner: TComponent);
begin
  inherited;
  FColorEnter := clYellow;
  FColorExit  := clWhite;
  FEnterToTab := False;
  FColorLabel := clBlue;
end;

procedure TDBCalcEditTropicom.SetColorActive(const Value: Boolean);
begin
  FColorActive := Value;
end;

procedure TDBCalcEditTropicom.SetColorEnter(const Value: TColor);
begin
  FColorEnter := Value;
end;

procedure TDBCalcEditTropicom.SetColorExit(const Value: TColor);
begin
  FColorExit := Value;
end;

procedure TDBCalcEditTropicom.SetColorLabel(const Value: TColor);
begin
  FColorLabel := Value;
end;

procedure TDBCalcEditTropicom.SetEnterToTab(const Value: Boolean);
begin
  FEnterToTab := Value;
end;

procedure TDBCalcEditTropicom.SetSetLabel(const Value: TLabel);
begin
  FSetLabel := Value;
end;

end.
