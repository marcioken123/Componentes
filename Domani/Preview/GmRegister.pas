{******************************************************************************}
{                                                                              }
{                        GmRegister.pas v2.61 Pro                              }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmRegister;

interface

uses Classes,
     GmPreview,
     GmRtfPreview,
     GmGridPrint,
     GmThumbnails,
     GmMultiPageImage,
     GmOrientationImage,
     GmPrinterList;

procedure Register;

implementation



procedure Register;
begin
  RegisterComponents('GmPrintSuite', [TGmPreview]);
  RegisterComponents('GmPrintSuite', [TGmRtfPreview]);
  RegisterComponents('GmPrintSuite', [TGmGridPrint]);
  RegisterComponents('GmPrintSuite', [TGmThumbnails]);
  RegisterComponents('GmPrintSuite', [TGmMultiPageImage]);
  RegisterComponents('GmPrintSuite', [TGmOrientationImage]);
  RegisterComponents('GmPrintSuite', [TGmPrinterList]);
end;

end.
