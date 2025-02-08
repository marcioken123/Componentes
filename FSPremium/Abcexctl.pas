 unit Abcexctl;

interface

uses
  Classes, ExtCtrls, Graphics;

type
  TabcBackground = class(TImage)
  private
    FActive: Boolean;
    FColorFrom: TColor;
    FColorTo: TColor;
  published
    property Active: Boolean read FActive write FActive;
    property ColorFrom: TColor read FColorFrom write FColorFrom;
    property ColorTo: TColor read FColorTo write FColorTo;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FSPremium', [TabcBackground]);
end;

end.
