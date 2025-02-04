unit DBDateEditTropicom;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask, JvToolEdit, Graphics, Messages, JVDBControls;

type
  TDBDateEditTropicom = class(TJvDBDateEdit)
  private
    FColorLabel: TColor;
    FSetLabel: TLabel;
    procedure SetColorLabel(const Value: TColor);
    procedure SetSetLabel(const Value: TLabel);
  private
    FColorEnter: TColor;
    FColorExit: TColor;
    FColorActive: Boolean;
    FEnterToTab: Boolean;
    FColorDefault: TColor;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure SetColorEnter(const Value: TColor);
    procedure SetColorExit(const Value: TColor);
    procedure SetColorActive(const Value: Boolean);
    procedure SetEnterToTab(const Value: Boolean);
    property SetLabel: TLabel read FSetLabel write SetSetLabel;
    property ColorLabel: TColor read FColorLabel write SetColorLabel;
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
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Protheus', [TDBDateEditTropicom]);
end;

{ TDBDateEditTropicom }

procedure TDBDateEditTropicom.CMEnter(var Message: TCMEnter);
begin
  if Self.SetLabel <> Nil then
     begin
        FColorDefault := Self.SetLabel.Font.Color;
        Self.SetLabel.Font.Color := FColorLabel;
     end;
     
  if ColorActive then
     Self.Color := ColorEnter;
end;

procedure TDBDateEditTropicom.CMExit(var Message: TCMExit);
begin
  if Self.SetLabel <> Nil then
     Self.SetLabel.Font.Color := FColorDefault;
     
  if ColorActive then
     Self.Color := ColorExit;
end;

constructor TDBDateEditTropicom.Create(AOwner: TComponent);
begin
  inherited;
  FColorEnter := clYellow;
  FColorExit  := clWhite;
  FEnterToTab := False;
  FColorLabel := clBlue;
end;

procedure TDBDateEditTropicom.SetColorActive(const Value: Boolean);
begin
  FColorActive := Value;
end;

procedure TDBDateEditTropicom.SetColorEnter(const Value: TColor);
begin
  FColorEnter := Value;
end;

procedure TDBDateEditTropicom.SetColorExit(const Value: TColor);
begin
  FColorExit := Value;
end;

procedure TDBDateEditTropicom.SetColorLabel(const Value: TColor);
begin
  FColorLabel := Value;
end;

procedure TDBDateEditTropicom.SetEnterToTab(const Value: Boolean);
begin
  FEnterToTab := Value;
end;

procedure TDBDateEditTropicom.SetSetLabel(const Value: TLabel);
begin
  FSetLabel := Value;
end;

end.
