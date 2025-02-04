{******************************************************************************}
{                                                                              }
{                           GmErrors.pas v2.61 Pro                             }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmErrors;

interface

uses Dialogs, classes;

const
  // GmPreview errors...
  PRO_VERSION_ONLY      = 'This functionallity is only available in '+#13+#13+
                          'GmPrintSuite Professional';                                                            

  PAGE_SIZE_NOT_FOUND   = 'Page size not found.';
  PAGE_OUT_OF_RANGE     = 'Page is out of range.';
  INDEX_OUT_OF_RANGE    = 'Printer index is out of range.';
  NO_PRINTER_SELECTED   = 'No printer selected';
  PRINTING_IN_PROGRESS  = 'Unable to initialise printer... Printing in progress.';
  INVALID_SHADOW_WIDTH  = 'Invalid shadow width...'+#13+#13+'Value must be in range (1-20)';
  // GmThumbnails errors...
  THUMB_SIZE_INVALID    = 'Thumbnail size must be in the range 1-20.';

  ERROR = 'Error...';
  PREVIEW_NOT_ASSIGNED  = 'Preview property not assigned.';
  NO_PREVIEW_ASSIGNED = 'There is no preview assigned to this component';

                        
  FILE_NOT_FOUND        = 'File not found.';
  CANT_READ_VERSION     = 'Unable to read file version.';
  CANT_OPEN_FILE        = 'Unable to open file';
  // General errors...

  // GmRtfErrors...
  NOT_RXRICHEDIT        = 'The paramater passed is not of type TRxRichEdit';
  NOT_RICHEDIT          = 'The paramater passed is not of type TRichEdit or TRichEdit98';
  RXFILE_UNAVAILABLE    = 'This method is only available in the registered version';
  RXSTREAM_UNAVAILABLE  = 'This method is only available in the registered version';
  NEED_RXRICHEDIT       = 'To use this event, you need to use the OnNeedRxRichEdit event to '+#13+
                          'create the TRxRichEdit';
  NOT_TRXRICHEDIT       = 'The object created is not a TRxRichEdit';

  CANNOT_SET_CUSTOM     = 'You cannot set the papersize to "Custom" directly...'+#13+#13+
                          'The papersize is set to "Custom internally when either the PageHeight '+#13+
                          'or PageWidth are changed manually at runtime.';
  PRINT_DRIVER_NEEDED   = 'You need to have a printer driver installed to preview text or rich text';


  procedure ShowGmError(Sender: TComponent; AError: string);
  procedure ShowGmMessage(Sender: TComponent; AMessage: string);


implementation

procedure ShowGmError(Sender: TComponent; AError: string);
begin
  MessageDlg(Sender.ClassName+' Error...' + #13 + #13 + AError, mtInformation, [mbOk], 0);
end;

procedure ShowGmMessage(Sender: TComponent; AMessage: string);
begin
  MessageDlg(AMessage, mtInformation, [mbOk], 0);
end;

end.






