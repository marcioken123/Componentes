unit LMDSimpleXMLLex;
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

LMDSimpleXMLLex unit (VO)
-------------------------



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
  { ******************************* TLMDSimpleXMLLex ******************************* }
  TLMDSimpleXMLLex = class(TLMDLex)
  protected
    function GetDelimChars: TCharSet; override;
  public
    function GetToken(aStream: TStream): TLMDToken; override;
  end;

implementation

uses
  SysUtils;

{-----------------------------------------------------------------------------}

function TLMDSimpleXMLLex.GetToken(aStream: TStream): TLMDToken;
var
  C: Char;
  S: string;
//  avPos: LongInt;
begin
  C:= GetNextChar(aStream);
  while (aStream.Position < aStream.Size) and (AnsiChar(C) in [#10, #13, ' ']) do
    C:= GetNextChar(aStream);

  if aStream.Position >= aStream.Size then
    begin
      Result:= TLMDEofToken.Create;
      exit;
    end;

  if C = '<' then
    begin
      C:= GetNextChar(aStream);
      if aStream.Position >= aStream.Size then
        begin
          Result:= TLMDEofToken.Create;
          exit;
        end;
      S := C;
      C:= GetNextChar(aStream);
      while (C <> '>') and (aStream.Position < aStream.Size) do
      begin
        S := S + C;
        C:= GetNextChar(aStream);
      end;
      case S[1] of
        '?' :
          begin
            Result := TLMDTagToken.Create('TYPE');
            TLMDTagToken(Result).Attributes.Add('CONTENT='+S);
            exit;
          end;
        '/' :
          begin
            Result := TLMDTagToken.Create('CLOSE');
            TLMDTagToken(Result).Attributes.Add('CONTENT='+S);
            exit;
          end;
        '!' :
          begin
            Result := TLMDTagToken.Create('COMMENT');
            TLMDTagToken(Result).Attributes.Add('CONTENT='+S);
            exit;
          end;
        else
          begin
            if S[Length(S)] = '/' then
              begin
                Result := TLMDTagToken.Create('EMPTY');
                TLMDTagToken(Result).Attributes.Add('CONTENT='+S);
                exit;
              end
            else
              begin
                Result := TLMDTagToken.Create('OPEN');
                TLMDTagToken(Result).Attributes.Add('CONTENT='+S);
                exit;
              end;
          end;
      end;
    end;

  S := '';
  while (C <> '<') and (aStream.Position < aStream.Size) do
    begin
      if not (AnsiChar(C) in [#10,#13]) then
        S := S + C;
      C:= GetNextChar(aStream);
    end;
  S := TrimRight(TrimLeft(S));
  if S <> '' then
    Result := TLMDTextToken.Create(S)
  else
    Result := TLMDEofToken.Create;
  if C = '<' then
    BackChar(aStream);
end;

{-----------------------------------------------------------------------------}

function TLMDSimpleXMLLex.GetDelimChars: TCharSet;
begin
  Result:= ['<', '>'] + GetSpaceChars
end;

end.
