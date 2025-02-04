{ :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  :: QuickReport 4.0 for Delphi                              ::
  ::                                                         ::
  :: QRBONUS - Bonus classes                                 ::
  ::                                                         ::
  :: Copyright (c) 2007 QBS Software                         ::
  :: All Rights Reserved                                     ::
  ::                                                         ::
  :: web: http://www.quickreport.co.uk                       ::
  ::                                                         ::
  :: 02/04/07 updated for QR4                                ::
  ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: }

unit QRBonus;

interface

uses
  Windows, Forms, QRPrntr, quickrpt;

type
  { TQRPrintJob
    This class works as a wrapper around TQRPrinter, making your life easier
    if you want to use this independently of the rest of QuickReport.
    Override the CreateOutput method to create the actual output and call the
    AQRPrinter.XPos, YPos, XSize and YSize to convert any coordinates from 0.1mm
    to actual device coordinates. 

 //****** Sample code ******
 //  1. Declare your own descendant class
 type
  TPPreview = class(TQRPrintJob)
  protected
    procedure CreateOutput; override;
  end;

 //  2. Create  procedure CreateOutPut -
procedure TPPreview.CreateOutput;
var
  j: Integer;
begin
  LineNum := 0;
  with qrPrn do begin
    BeginDoc;
    NewPage;
    NewLine(2);
    PPrint(100, 'Start', 'L');
    for j := 1 to 20 do begin
      NewLine(2);
      PPrint(400, 'printed at 400', 'C');
      PPrint(1100, 'printed at 1100', 'R');
    end;
    NewPage;
    LineNum := 0;
    NewLine(2);
    PPrint(100, 'Start', 'L');
    for j := 1 to 20 do begin
      NewLine(2);
      PPrint(400, 'printed at 400', 'C');
      PPrint(1100, 'printed at 400', 'R');
    end;
    EndDoc;
  end;
end;

  // 4. To call the print and preview methods -
procedure TForm1.bImpClick(Sender: TObject);
var
  PPreview: TPPreview;
begin
  PPreview := TPPreview.Create;
  try
    PPreview.Preview; // or Print
  finally
    PPreview.Free;
  end;
end;

// ********* End of sample code **************
    }

  TQRPrintJob = class
    qrPrn: TQRPrinter;
    LineNum: Single;
  protected
    procedure CreateOutput; virtual;
  public
    // qr407
    parentReport : TQuickrep;
    constructor Create;
    destructor Destroy; override;
    procedure Print;
    procedure Preview;
    procedure PPrint(iX: Integer; sTxt: string; sPos: Char);
    procedure NewLine(f: Single);
    procedure FormatLine(s: string; iLin1, iLin2: integer;
              var aLin: array of string);
  end;

implementation

//uses sdFunc;

procedure TQRPrintJob.CreateOutput;
begin
end;

constructor TQRPrintJob.Create;
begin
  inherited;
  parentReport := TQuickrep.Create(nil);
  qrPrn := TQRPrinter.Create(parentreport);
end;

destructor TQRPrintJob.Destroy;
begin
  parentReport.Free;
  qrPrn.Free;
  inherited Destroy;
end;

procedure TQRPrintJob.Preview;
begin
  with qrPrn do begin
    CleanUp;
    Destination := qrdMetafile;
//    OnGenerateToPrinter := Self.Print;
    Preview;
    Application.ProcessMessages;
    CreateOutput;
    repeat
      Application.ProcessMessages
    until not qrPrn.ShowingPreview;
  end;
end;

procedure TQRPrintJob.Print;
begin
  with qrPrn do begin
    CleanUp;
    Destination := qrdPrinter;
    CreateOutput;
  end;
end;


procedure TQRPrintJob.PPrint(iX: Integer; sTxt: string; sPos: Char);
begin
  with qrPrn do begin
    case sPos of
      'R', 'r': iX := XPos(iX) - Canvas.TextWidth(sTxt);
      'C', 'c': iX := XPos(iX) - (Canvas.TextWidth(sTxt) div 2);
    else iX := XPos(iX);
    end;
    Canvas.TextOut(iX, Canvas.PenPos.Y, sTxt);
  end;
end;

procedure TQRPrintJob.NewLine(f: Single);
begin
  LineNum := LineNum + f;
  with qrPrn do Canvas.MoveTo(XPos(0), YPos(LineNum * 42));
end;

procedure TQRPrintJob.FormatLine(s: string; iLin1, iLin2: integer;
              var aLin: array of string);
var
  iLin, j, k: integer;
  sPlv: string;
begin
  iLin := qrPrn.XPos(iLin1);
  iLin2 := qrPrn.XPos(iLin2);
  for k := Low(aLin) to High(aLin) do aLin[k] := '';
  k := Low(aLin);

  j := Pos(Chr(vk_Tab), s);
  while j > 0 do begin
    s := Copy(s, 1, j - 1) + StringOfChar(' ', 8) + Copy(s, j + 1,
        Length(s));
    j := Pos(Chr(vk_Tab), s);
  end;

  s := s + Chr(3);
  sPlv := '';
  for j := 1 to Length(s) do begin
    if Ord(s[j]) = 10 then Continue;
    if Ord(s[j]) = 13 then begin
      aLin[k] := aLin[k] + sPlv;
      sPlv := '';
      Inc(k);
      if k = Low(aLin) + 1 then iLin := iLin2;
      Continue;
    end;
    if (s[j] = ' ') or (Ord(s[j]) = 3) then begin
      if s[j] = ' ' then sPlv := sPlv + ' ';
      if qrPrn.Canvas.TextWidth(aLin[k] + sPlv) > iLin then begin
        Delete(aLin[k], Length(aLin[k]), 1);
        Inc(k);
        if k = Low(aLin) + 1 then iLin := iLin2;
        s[j] := ' ';
      end;
      aLin[k] := aLin[k] + sPlv;
      sPlv := '';
    end else sPlv := sPlv + s[j];
  end;
  if aLin[k]<> '' then Inc(k);
  aLin[k] := Chr(3);
end;

end.
