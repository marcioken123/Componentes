unit JvCalcEditTropicom;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask, JvToolEdit, Graphics, JvBaseEdits;

type
  TJvCalcEditTropicom = class(TJvCalcEdit)
  private
    FFocused: Boolean;
    FFormatting: Boolean;
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
    procedure SetFocused(Value: Boolean);
    { Protected declarations }
  public
    Constructor Create(AOwner: TComponent); override;
    { Public declarations }
  published
    { Published declarations }
    property ColorActive: Boolean read FColorActive write SetColorActive;
    property ColorEnter: TColor read FColorEnter write SetColorEnter;
    property ColorExit: TColor read FColorExit write SetColorExit;
    property EnterToTab: Boolean read FEnterToTab write SetEnterToTab;
    property SetLabel: TLabel read FSetLabel write SetSetLabel;
    property ColorLabel: TColor read FColorLabel write SetColorLabel;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Protheus', [TJvCalcEditTropicom]);
end;

{ TJvCalcEditTropicom }

procedure TJvCalcEditTropicom.SetFocused(Value: Boolean);
begin
  if FFocused  <> Value then
  begin
     FFocused  := Value;
    Invalidate;
    FFormatting := True;
    try
      DataChanged;
    finally
      FFormatting := False;
    end;
  end;
end;

procedure TJvCalcEditTropicom.CMEnter(var Message: TCMEnter);
begin
  Inherited;
  if Self.SetLabel <> Nil then
     begin
        FColorDefault := Self.SetLabel.Font.Color;
        Self.SetLabel.Font.Color := FColorLabel;
     end;
     
  SetFocused(True);
  if FormatOnEditing then ReformatEditText;

  if ColorActive then
     Self.Color := ColorEnter;
end;

procedure TJvCalcEditTropicom.CMExit(var Message: TCMExit);
begin
  Inherited;
  if Self.SetLabel <> Nil then
     Self.SetLabel.Font.Color := FColorDefault;

  if ColorActive then
     Self.Color := ColorExit;

  try
    CheckRange;
    UpdateData;
  except
    SelectAll;
    if CanFocus then SetFocus;
    raise;
  end;
  SetFocused(False);
  SetCursor(0);
  DoExit;  
end;

constructor TJvCalcEditTropicom.Create(AOwner: TComponent);
begin
  inherited;
  FColorEnter := clYellow;
  FColorExit  := clWhite;
  FEnterToTab := False;
  FColorLabel := clBlue;
end;

procedure TJvCalcEditTropicom.SetColorActive(const Value: Boolean);
begin
  FColorActive := Value;
end;

procedure TJvCalcEditTropicom.SetColorEnter(const Value: TColor);
begin
  FColorEnter := Value;
end;

procedure TJvCalcEditTropicom.SetColorExit(const Value: TColor);
begin
  FColorExit := Value;
end;

procedure TJvCalcEditTropicom.SetEnterToTab(const Value: Boolean);
begin
  FEnterToTab := Value;
end;

procedure TJvCalcEditTropicom.SetColorLabel(const Value: TColor);
begin
  FColorLabel := Value;
end;

procedure TJvCalcEditTropicom.SetSetLabel(const Value: TLabel);
begin
  FSetLabel := Value;
end;

end.
