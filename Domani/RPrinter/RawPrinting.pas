{---------------------------------------------------}
{ Copyright (c)2000 by Przemyslaw Jankowski         }
{              e-mail: pjank@pjank.pl               }
{---------------------------------------------------}
{                                                   }
{ Thanks to:                                        }
{  - Harald Bender <bender@nt-newton.fho-emden.de>  }
{    for helping me with WinNT support              }
{    and German error messages                      }
{                                                   }
{---------------------------------------------------}
unit RAWPrinting;
{$B-,H+,X+}

interface

uses SysUtils;


type
  ERAWPrintError = class(Exception);
  ERAWPrintErrorPrinterName = class(ERAWPrintError);


procedure RAWPrint(PrinterName, DocumentTitle, DocumentData: string);
// PrinterName - the name of the printer you want to use
//               to use the default printer - leave this blank
// DocumentTitle - the text that is listed in the Print Manager
// DocumentData - the text you want to send to the printer

implementation

uses WinSpool, Windows;

const
  // English //
  errNoDefaultPrinter = 'No default printer found.';
  errOpenPrinter = 'The printer "%s" is not available.';
  errPrintError  = 'Error printing the document "%s".';
  // German //
  //errNoDefaultPrinter = 'Keinen Standarddrucker gefunden.';
  //errOpenPrinter = 'Der Drucker "%s" ist nicht verfügbar.';
  //errPrintError  = 'Fehler beim Drucken von Dokument "%s".';
  // Polish  //
  //errNoDefaultPrinter = 'Brak domyœlnej drukarki.';
  //errOpenPrinter = 'Drukarka "%s" jest niedostêpna.';
  //errPrintError  = 'B³¹d przy drukowaniu "%s".';


function DefaultPrinter:string;
var str: array[0..79]of Char;
  function FetchStr(s:string):string;
  var i: Integer;
  begin
    s:= TrimLeft(s);
    i:= Pos(',',s);
    if i=0
     then Result:= s
     else Result:= Copy(s, 1, i-1);
  end;
begin
  GetProfileString('windows', 'device', '', str, SizeOf(str)-1);
  Result:= FetchStr(str);
  if Result='' then raise ERAWPrintErrorPrinterName.Create(errNoDefaultPrinter);
end;

procedure RAWPrint(PrinterName, DocumentTitle, DocumentData: string);
var hPrinter: DWord;
    DocInfo: TDocInfo1;
    dwJob: Integer;
    dwBytesWritten: DWord;
  procedure PrintError;
  begin
    raise ERAWPrintError.Create(Format(errPrintError, [DocumentTitle]));
  end;
begin
  if PrinterName='' then PrinterName:= DefaultPrinter;
  if not OpenPrinter(PChar(PrinterName), hPrinter, nil) then
    raise ERAWPrintErrorPrinterName.Create(Format(errOpenPrinter, [PrinterName]));
  try
    DocInfo.pOutputFile:= nil;
    DocInfo.pDatatype:= 'RAW';
    DocInfo.pDocName:= PChar(DocumentTitle);
    dwJob:= StartDocPrinter(hPrinter, 1, @DocInfo);
    if (dwJob=0) then PrintError;
    try
      if not StartPagePrinter(hPrinter) then PrintError;
      try
        if not WritePrinter(hPrinter, Pointer(DocumentData), Length(DocumentData), dwBytesWritten)
          then PrintError;
        if (LongInt(dwBytesWritten)<Length(DocumentData))
          then PrintError;
      finally
        if not EndPagePrinter(hPrinter) then PrintError;
      end;
    finally
      if not EndDocPrinter(hPrinter) then PrintError;
    end;
  finally
    ClosePrinter(hPrinter);
  end;
end;


end.

