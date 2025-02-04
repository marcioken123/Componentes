unit JvDateEditTropicom;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask, JvToolEdit, Graphics;

type
  TJvDateEditTropicom = class(TJvDateEdit)
  private
    FColorEnter: TColor;
    FColorExit: TColor;
    FColorActive: Boolean;
    FEnterToTab: Boolean;
    FColorDefault: TColor;
    FColorLabel: TColor;
    FSetLabel: TLabel;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure SetColorEnter(const Value: TColor);
    procedure SetColorExit(const Value: TColor);
    procedure SetColorActive(const Value: Boolean);
    procedure SetEnterToTab(const Value: Boolean);
    procedure SetColorLabel(const Value: TColor);
    procedure SetSetLabel(const Value: TLabel);
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
  RegisterComponents('Protheus', [TJvDateEditTropicom]);
end;

{ TJvDateEditTropicom }

procedure TJvDateEditTropicom.CMEnter(var Message: TCMEnter);
begin
  if Self.SetLabel <> Nil then
     begin
        FColorDefault := Self.SetLabel.Font.Color;
        Self.SetLabel.Font.Color := FColorLabel;
     end;
  if ColorActive then
     Self.Color := ColorEnter;
end;

procedure TJvDateEditTropicom.CMExit(var Message: TCMExit);
begin
  if Self.SetLabel <> Nil then
     Self.SetLabel.Font.Color := FColorDefault;
  if ColorActive then
     Self.Color := ColorExit;
end;

constructor TJvDateEditTropicom.Create(AOwner: TComponent);
begin
  inherited;
  FColorEnter := clYellow;
  FColorExit  := clWhite;
  FEnterToTab := False;
  FColorLabel := clBlue;
end;

procedure TJvDateEditTropicom.SetColorActive(const Value: Boolean);
begin
  FColorActive := Value;
end;

procedure TJvDateEditTropicom.SetColorEnter(const Value: TColor);
begin
  FColorEnter := Value;
end;

procedure TJvDateEditTropicom.SetColorExit(const Value: TColor);
begin
  FColorExit := Value;
end;

procedure TJvDateEditTropicom.SetColorLabel(const Value: TColor);
begin
  FColorLabel := Value;
end;

procedure TJvDateEditTropicom.SetEnterToTab(const Value: Boolean);
begin
  FEnterToTab := Value;
end;

procedure TJvDateEditTropicom.SetSetLabel(const Value: TLabel);
begin
  FSetLabel := Value;
end;

end.
