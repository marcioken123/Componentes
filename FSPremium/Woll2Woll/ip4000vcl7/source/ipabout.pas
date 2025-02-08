unit ipabout;
{
//
// Components : InfoPower About Dialog
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TIPAboutForm = class(TForm)
    Bevel1: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Registration: TLabel;
    Version: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    ARegistration, AVersion: string;
    { Public declarations }
  end;

var
  IPAboutForm: TIPAboutForm;

implementation

{$R *.DFM}

procedure TIPAboutForm.FormShow(Sender: TObject);
begin
   Version.Caption:= AVersion;
   Registration.Caption:= ARegistration;
end;

end.
