unit LMDSimpleRTFParser;
{$I LMDCmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDSimpleRTFParser unit (VO)
----------------------------

RTF parser 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDParser, LMDRTFTape, LMDLex, LMDRTFScanner, LMDRTFDocument, LMDText;

type
  { ************************************************************************** }
  TLMDSimpleRTFParser = class (TLMDParser)
  private
    FStream     : TStream;
    FTape       : TLMDRTFTape;
    FScanner    : TLMDRTFScanner;
    FDocument   : TLMDRTFDocument;
  protected
    function GetLexClass: TLMDLexClass; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function Parse(aStream: TStream;
      aGraphicErrorEvent: TLMDGraphicErrorEvent;
      aGetVariable: TLMDGetVariableEvent;
      aEmbdControlCreated : TLMDEmbdControlEvent;
      aRepeatEvent : TLMDRepeatEvent): TLMDParsedTextList; override;
  end;

implementation

uses
  LMDRTFAnalyser, LMDRTFLookupTable;

type
  TLMDRTFLex = class (TLMDLex)
  public
    function GetToken(aStream: TStream): TLMDToken; override;
  end;

function TLMDRTFLex.GetToken(aStream: TStream): TLMDToken;
begin
  result := TLMDEOFToken.Create;
end;

function TLMDSimpleRTFParser.GetLexClass: TLMDLexClass;
begin result := TLMDRTFLex; end;

constructor TLMDSimpleRTFParser.Create;
begin
  inherited;
  FTape := TLMDRTFTape.Create;
  FDocument := TLMDRTFDocument.Create;
end;

destructor TLMDSimpleRTFParser.Destroy;
begin
  {if assigned (FScanner) then }
  FScanner.Free;
  FTape.Free;
  FDocument.Free;
  inherited;
end;

function TLMDSimpleRTFParser.Parse(aStream: TStream;
      aGraphicErrorEvent: TLMDGraphicErrorEvent;
      aGetVariable: TLMDGetVariableEvent;
      aEmbdControlCreated : TLMDEmbdControlEvent;
      aRepeatEvent : TLMDRepeatEvent): TLMDParsedTextList;
var

  GDSFinished : boolean;
  FontTblFinished : boolean;
  FileTblFinished : boolean;
  ColorTblFinished : boolean;
  StyleTblFinished : boolean;

begin
  result := nil;
  if not assigned(aStream) then Exit;
  FStream := aStream;
  FTape.Clear; FTape.AddCell(tocWAIT);
  FDocument.Clear;

  TLMDRTFGDSAnalyser.Create(FTape, FDocument, @GDSFinished);
  TLMDRTFFontTblAnalyser.Create(FTape, FDocument, @FontTblFinished);
  TLMDRTFFileTblAnalyser.Create(FTape, FDocument, @FileTblFinished);
  TLMDRTFColorTblAnalyser.Create(FTape, FDocument, @ColorTblFinished);
  TLMDRTFStyleTblAnalyser.Create(FTape, FDocument, @StyleTblFinished);
  FScanner := TLMDRTFScanner.Create(FStream, FTape);
  FScanner.Execute;

  while not (GDSFinished and FontTblFinished and FileTblFinished
      and ColorTblFinished and StyleTblFinished) do ;
  result := nil;
end;

end.
