unit GmProgress;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TfrmProgress = class(TForm)
    Panel1: TPanel;
    barProgress: TProgressBar;
    Panel2: TPanel;
    Image3: TImage;
    Bevel1: TBevel;
    lblProgress: TLabel;
    BitBtn1: TBitBtn;
    barTotal: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    FNumPages: integer;
    { Private declarations }
  public
    DoAbort: Boolean;
    procedure Initialize(NumPages: integer; TotalPages: integer);
    procedure Increment;
    { Public declarations }
  end;

var
  frmProgress: TfrmProgress;

implementation

{$R *.DFM}

procedure TfrmProgress.Initialize(NumPages: integer; TotalPages: integer);
begin
  DoAbort := False;
  barProgress.Position := 0;
  barTotal.Position := 0;
  lblProgress.Caption := 'Printing page 0 of '+IntToStr(NumPages);
  barProgress.Max := NumPages;
  barTotal.Max := TotalPages;
  FNumPages := NumPages;
end;

procedure TfrmProgress.Increment;
begin
  barProgress.Position := barProgress.Position + 1;
  barTotal.Position := barTotal.Position + 1;
  lblProgress.Caption := 'Printing page '+IntToStr(barProgress.Position)+' of '+IntToStr(FNumPages);
  Repaint;
end;

procedure TfrmProgress.BitBtn1Click(Sender: TObject);
begin
  DoAbort := True;
  Hide;
end;

end.
