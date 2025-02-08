unit LMDPlainTextParser;
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

LMDPlainTextParser unit (VO)
----------------------------

Plain text parser 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Graphics, Controls,
  LMDParser, LMDPlainTextLex, LMDLex, LMDText;

type
  { **************************** TLMDPlainTextParser ************************** }
  TLMDPlainTextParser = class(TLMDParser)
  protected
    function GetLexClass: TLMDLexClass; override;
  public
    function Parse(aStream: TStream;
      aGraphicErrorEvent: TLMDGraphicErrorEvent;
      aGetVariable: TLMDGetVariableEvent;
      aEmbdControlCreated : TLMDEmbdControlEvent;
      aRepeatEvent : TLMDRepeatEvent): TLMDParsedTextList; override;
  end;

implementation

{-----------------------------------------------------------------------------}

function TLMDPlainTextParser.GetLexClass: TLMDLexClass;
begin
 Result:= TLMDPlainTextLex;
end;

function TLMDPlainTextParser.Parse(aStream: TStream;
  aGraphicErrorEvent: TLMDGraphicErrorEvent;
  aGetVariable: TLMDGetVariableEvent;
  aEmbdControlCreated : TLMDEmbdControlEvent;
  aRepeatEvent : TLMDRepeatEvent): TLMDParsedTextList;
var
  T: TLMDToken;
  TT: TLMDTokenType;
begin
  Result:= TLMDParsedTextList.Create(nil);
  Result.AddSubitem(TLMDParagraph.Create(Result, ''));
  repeat
    T:= Lex.GetToken(aStream);
    try
      TT := T.TokenType;

      case  TT of
        ttText:
          TLMDParagraph(Result[Result.Count - 1]).AddSubitem(
            TLMDText.Create((T as TLMDTextToken).TokenText,
            TLMDParagraph(Result[Result.Count - 1])));
        ttTag: // NewLine ;)
          Result.AddSubitem(TLMDParagraph.Create(Result, ''));
      end;
    finally
      T.Free;
    end;
  until TT = ttEOF;
end;

initialization
  RegisterParser(TLMDPlainTextParser, ['TXT'], true);

end.
