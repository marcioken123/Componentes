{---------------------------------------------------}
{ Copyright (c)2000 by Przemyslaw Jankowski         }
{              e-mail: pjank@home.pl                }
{---------------------------------------------------}
{                                                   }
{ >> TRAWPrinter <<  component                      }
{  just put it on your form                         }
{  and you can send RAW data to the printer         }
{  or simply print in text mode (just like in DOS)  }
{                                                   }
{ Here's all you need to know:                      }
{ properties:                                       }
{ - PrinterName                                     }
{   the name of the printer you want to use         }
{   to use the default printer - leave this blank   }
{ - DocumentTitle                                   }
{   the text that is listed in the Print Manager    }
{ methods:                                          }
{ - BeginDoc - this starts a new print job          }
{   if PrinterName was empty, it will contain       }
{   the default printer name                        }
{ - EndDoc - call this when you finish sending data }
{ - Abort - if you want to abort current print-job  }
{   note: it will cancel only this part of the data }
{   that didn't yet go the printer                  }
{ - Write - use this between BeginDoc and EndDoc    }
{   sends <Count> bytes of <Buffer> to the printer  }
{                                                   }
{ To make things easier there're more methods:      }
{ - WriteStr - just pass any string as parameter    }
{ - WriteLn - like the above but adds CRLF (#10#13) }
{ - NextPage - sends FormFeed code (#12)            }
{ - CR - sends only CarrigeReturn (#13)             }
{ - LF - sends only LineFeed (#10)                  }
{                                                   }
{ All methods return:                               }
{ - True - if everything was O.K.                   }
{ - False - if something failed                     }
{                                                   }
{---------------------------------------------------}
unit RAWPrinter;
{$B-}

interface

uses
  Windows, SysUtils, Classes;

type
  TRAWPrinter = class(TComponent)
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
  private
    fDocumentTitle: string;
    fPrinterName: string;
    fPrinterHandle: DWord;
    fLevel: Integer;
      // 0 - printer closed
      // 1 - printer open
      // 2 - job started
      // 3 - page started
  public
    function SetToDefaultPrinter:Boolean;
    function BeginDoc:Boolean;
    function EndDoc:Boolean;
    function Abort:Boolean;
    function Write(const Buffer; Count:Longint):DWord;
    function WriteStr(const text:string):Boolean;
    function WriteLn(const line:string):Boolean;
    function NextPage:Boolean;
    function CR:Boolean;
    function LF:Boolean;
  published
    property PrinterName:string read fPrinterName write fPrinterName;
    property DocumentTitle:string read fDocumentTitle write fDocumentTitle;
  end;

procedure Register;

implementation

uses
  WinSpool;


procedure Register;
begin
  RegisterComponents('Domani', [TRAWPrinter]);
end;


{ TRAWPrinter }
(***********************************************************************************)
constructor TRAWPrinter.Create(AOwner: TComponent);
begin
  inherited;
  fDocumentTitle:= '';
  fPrinterName:= '';
  fLevel:= 0;
end;

destructor TRAWPrinter.Destroy;
begin
  if (fLevel>0) then Abort;
  inherited;
end;

(***********************************************************************************)
function TRAWPrinter.SetToDefaultPrinter:Boolean;
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
  fPrinterName:= FetchStr(str);
  Result:= (fPrinterName<>'');
end;

(***********************************************************************************)
function TRAWPrinter.BeginDoc: Boolean;
var DocInfo: TDocInfo1;
begin
  if (fLevel=0) then begin  // open printer
    if (fPrinterName='') then SetToDefaultPrinter;
    if (fPrinterName<>'') and OpenPrinter(PChar(fPrinterName), fPrinterHandle, nil)
     then fLevel:= 1;
  end;
  if (fLevel=1) then begin  // start new job
    with DocInfo do begin
      pDocName:= PChar(fDocumentTitle);
      pOutputFile:= nil;
      pDatatype:= 'RAW';
    end;
    if (StartDocPrinter(fPrinterHandle, 1, @DocInfo)<>0)
     then fLevel:= 2;
  end;
  if (fLevel=2) then        // start new page
    if StartPagePrinter(fPrinterHandle)
     then fLevel:= 3;
  Result:= (fLevel=3);
end;

function TRAWPrinter.EndDoc: Boolean;
begin
  if (fLevel=3) then
    if EndPagePrinter(fPrinterHandle) then fLevel:= 2;
  if (fLevel=2) then
    if EndDocPrinter(fPrinterHandle) then fLevel:= 1;
  if (fLevel=1) then
    if ClosePrinter(fPrinterHandle) then fLevel:= 0;
  Result:= (fLevel=0);
end;

function TRAWPrinter.Abort: Boolean;
begin
  if (fLevel>1) then
    if AbortPrinter(fPrinterHandle) then fLevel:= 1;
  if (fLevel=1) then
    if ClosePrinter(fPrinterHandle) then fLevel:= 0;
  Result:= (fLevel=0);
end;

(***********************************************************************************)
function TRAWPrinter.Write(const Buffer; Count: Integer): DWord;
begin
  Result:= 0;
  if (fLevel=3) then
    WritePrinter(fPrinterHandle, Pointer(Buffer), Count, Result);
end;

function TRAWPrinter.WriteStr(const text: string): Boolean;
var len: DWord;
begin
  len:= Length(text);
  Result:= (Write(text,len)=len);
end;

function TRAWPrinter.WriteLn(const line: string): Boolean;
begin
  Result:= WriteStr(line+#10#13);
end;

function TRAWPrinter.NextPage: Boolean;
begin
  Result:= WriteStr(#12);
end;

function TRAWPrinter.CR: Boolean;
begin
  Result:= WriteStr(#13);
end;

function TRAWPrinter.LF: Boolean;
begin
  Result:= WriteStr(#10);
end;

(***********************************************************************************)

end.
