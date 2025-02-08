unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, CoolCtrls, CoolTools, CoolPolygons;

type
  TForm1 = class(TForm)
    CoolImages1: TCoolImages;
    CoolAnimateEffects1: TCoolAnimateEffects;
    CoolImageShape1: TCoolImageShape;
    CoolBtn9: TCoolBtn;
    CoolClipboardViewer1: TCoolClipboardViewer;
    CoolLabel2: TCoolLabel;
    CoolShadow1: TCoolShadow;
    CoolShadow2: TCoolShadow;
    CoolShadow3: TCoolShadow;
    CoolAnimate1: TCoolAnimate;
    CoolShadow4: TCoolShadow;
    procedure CoolAnimateEffects1AnimationEnd(Sender: TObject;
      Index: Integer; var DoContinue: Boolean);
    procedure CoolBtn9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.CoolAnimateEffects1AnimationEnd(Sender: TObject;
  Index: Integer; var DoContinue: Boolean);
begin
  if Assigned(CoolAnimateEffects1) then
    with CoolAnimateEffects1 do
      case AnimateEffect of
        aeStripesDown: AnimateEffect := aeStripesUp;
        aeStripesUp: AnimateEffect := aeStripesRight;
        aeStripesRight: AnimateEffect := aeStripesLeft;
        aeStripesLeft: AnimateEffect := aeStripesTBCenter;
        aeStripesTBCenter: AnimateEffect := aeStripesLRCenter;
        aeStripesLRCenter: AnimateEffect := aeStripesCenterTB;
        aeStripesCenterTB: AnimateEffect := aeStripesCenterLR;
        aeStripesCenterLR: AnimateEffect := aeStripesPartsHz;
        aeStripesPartsHz: AnimateEffect := aeStripesPartsVt;
        aeStripesPartsVt: AnimateEffect := aeStripesDown;
      end;
end;

procedure TForm1.CoolBtn9Click(Sender: TObject);
begin
  CoolImageShape1.Active := not CoolImageShape1.Active;
  CoolImageShape1.MoveParent := CoolImageShape1.Active;
   
  if CoolImageShape1.Active then
    CoolBtn9.Caption := '&Active (+)' else
    CoolBtn9.Caption := '&Active (-)';
end;

end.
