unit LMDPlainTextLex;
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

LMDPlainTextLex unit (VO)
-------------------------

Plain text lexical analyser 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  classes, LMDLex;

type
  TLMDPlainTextLex = class(TLMDLex)
  public
    function GetToken(aStream: TStream): TLMDToken; override;
  end;

implementation

{ TLMDPlainTextLex }

function TLMDPlainTextLex.GetToken(aStream: TStream): TLMDToken;
var
  C: Char;
  S: string;
begin
  if aStream.Position >= aStream.Size then
    begin
      Result:= TLMDEofToken.Create;
      Exit;
    end;
  S:= '';
  C:= #0;
  while (aStream.Position < aStream.Size) and (C <> #13) and (C <> ' ') do
    begin
      C:= GetNextChar(aStream);
      case C of
        #10: ;
        #13:
          if S = '' then
            begin
              Result:= TLMDTagToken.Create('NEWLINE');
              Exit;
            end
          else
            BackChar(aStream);
        #9: S:= S + '        ';
      else
        S:= S + C;
      end;
    end;
  Result:= TLMDTextToken.Create(S);
end;

end.
