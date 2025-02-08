unit LMDCSVLex;
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

LMDCSVLex unit (VO)
-------------------

CSV lexical analyzer

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, LMDLex;

type

  { ******************************* TLMDHTMLParser **************************** }
  TLMDCSVLex = class(TLMDLex)
  public
    function GetToken(aStream: TStream): TLMDToken; override;
  end;

implementation
uses
  SysUtils, LMDStrings;

{-----------------------------------------------------------------------------}

function TLMDCSVLex.GetToken(aStream: TStream): TLMDToken;
var
  C: Char;
  S: string;
begin
  if aStream.Position >= aStream.Size then
    begin
      Result:= TLMDEofToken.Create;
      exit;
    end;

  C:= GetNextChar(aStream);
  if LMDAnsiCharInSet(C, [#10, #13]) then
    begin
      while (aStream.Position < aStream.Size) and LMDAnsiCharInSet(C, [#10, #13]) do
      C:= GetNextChar(aStream);
      if (aStream.Position < aStream.Size) then
        BackChar(aStream);
      Result := TLMDTagToken.Create('NEWLINE');
      exit;
    end;

  if C = ';' then
    C := GetNextChar(aStream);

  S := '';
  while (aStream.Position < aStream.Size) and (not LMDAnsiCharInSet(C, [#10, #13])) and (C <> ';') do
    begin
      S := S + C;
      C:= GetNextChar(aStream);
    end;
  Result := TLMDTextToken.Create(S);
  if (aStream.Position < aStream.Size) then
    BackChar(aStream);
end;

end.
