unit LMDHTMLLex;
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

LMDHTMLLex unit (VO)
--------------------

HTML lexical analyser

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
  { ******************************* TLMDHTMLParser **************************** }
  TLMDHTMLLex = class(TLMDLex)
  protected
    function GetDelimChars: TCharSet; override;
  public
    function GetToken(aStream: TStream): TLMDToken; override;
  end;

implementation

uses
  SysUtils;

{-----------------------------------------------------------------------------}

function TLMDHTMLLex.GetToken(aStream: TStream): TLMDToken;
var
  C: Char;
  S: string;
  avPos: LongInt;
begin
  if aStream.Position >= aStream.Size then
    begin
      Result:= TLMDEofToken.Create;
      exit;
    end;
  C:= GetNextChar(aStream);
  if AnsiChar(C) in GetSpaceChars then
    begin
//      BackChar(aStream);
      SkipSpaces(aStream);
      Result:= TLMDTextToken.Create(' ');
      exit;
    end;

  // Check TAG
  if C = '<' then // Tag started
    begin
      S:= GetWord(aStream, [{'<',}'>'] + GetQuoteChars);
      if S = '' then // check close tag
        begin
          C:= GetNextChar(aStream);
          if C = '/' then
            S:= '/' + GetWord(aStream, [{'<',}'>'] + GetQuoteChars);
        end;
      // Check EOF
      if aStream.Position >= aStream.Size then
        begin
          Result:= TLMDEofToken.Create;
          exit;
        end;

      if Copy(S, 1, 3) = '!--' then // comments
        begin
          S:= Copy(S, 4, length(S));
          Result := TLMDTagToken.Create('!--');
          if Pos('--', S) <> 0 then
            begin
              if GetNextChar(aStream) = '>' then
                begin
//                  Result:= GetToken(aStream);
                  exit;
                end
              else
                BackChar(aStream);
            end;
          S:= '   ';
          repeat
            S:= S + GetNextChar(aStream);
//            S:= Copy(S, 2, 3);
          until (Pos('-->',S) <> 0) or (aStream.Position >= aStream.Size);
          TLMDTagToken(Result).Attributes.Add(Copy(S,1,Length(S)-1));
//          Result:= GetToken(aStream);
          exit;
        end;

      Result:= TLMDTagToken.Create(S);
      repeat
        //Parse TAG Attributes
        SkipSpaces(aStream);
        if aStream.Position >= aStream.Size then
          exit;
        C:= GetNextChar(aStream);
        if C = '>' then
          exit;
        BackChar(aStream);
(*        S:= AnsiUpperCase(GetString(aStream, ['=', '>'])); // Get ATTR name *)
        S:= GetString(aStream, ['=', '>']); // Get ATTR name
        SkipSpaces(aStream);
        if aStream.Position >= aStream.Size then
          exit;
        C:= GetNextChar(aStream);
        if C = '>' then
          exit;
        if C <> '=' then
          begin
            //        ShowMessage( 'ATTR WITHOUT VALUE: ' + S);
            BackChar(aStream);
            continue; // BAD
          end;
        SkipSpaces(aStream);
        if aStream.Position >= aStream.Size then
          exit;
        C:= GetNextChar(aStream);
        if (AnsiChar(C)  in [ '''', '"']) then
          avPos:= aStream.Position
        else
          avPos:= aStream.Position + SizeOf(Char);
        BackChar(aStream);
        (Result as TLMDTagToken).Attributes.Values[S]:=
(*          AnsiUpperCase(GetString(aStream, ['>'])); // Get ATTR value*)
          GetString(aStream, ['>']); // Get ATTR value
        TLMDTagToken(Result).Position[S]:= avPos;
      until false;
    end
  else
    begin
      BackChar(aStream);
      S:= GetWord(aStream, ['<' {, '>'}] { + GetQuoteChars});
      if S <> '' then
        Result:= TLMDTextToken.Create(S)
      else
        Result:= GetToken(aStream);
    end;
end;

{-----------------------------------------------------------------------------}

function TLMDHTMLLex.GetDelimChars: TCharSet;
begin
  Result:= ['<', '=', '>'] + GetSpaceChars
end;

end.
