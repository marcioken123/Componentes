unit LMDWebHTMLLex;
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

LMDWebHTMLLex unit (DD)
-----------------------
HTML lexical analyser

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  classes, LMDWebLex, LMDStrings, LMDTypes;

type
  { ******************************* TLMDHTMLParser **************************** }
  TLMDWebHTMLLex = class(TLMDWebLex)
  protected
    FTagsStack: TLMDMemoryStrings;
    function GetDelimChars: TCharSet; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    function GetToken(aStream: TStream): TLMDWebToken; override;
  end;

implementation

uses
  SysUtils;

{-----------------------------------------------------------------------------}

function TLMDWebHTMLLex.GetToken(aStream: TStream): TLMDWebToken;
var
  C: Char;
  S: string;
  avPos: LongInt;
begin
  if aStream.Position >= aStream.Size then
    begin
      Result:= TLMDWebEofToken.Create;
      exit;
    end;
  C:= GetNextChar(aStream);
  {$IFNDEF LMDCOMP12}
  if LMDAnsiCharInSet(C, GetSpaceChars) then
  {$ELSE}
  if CharInSet(C, GetSpaceChars) then
  {$ENDIF}
    begin
      BackChar(aStream);
      SkipSpaces(aStream);
      Result:= TLMDWebTextToken.Create(' ');
      exit;
    end;

  // Check selfclosed tag
  if C = '/' then
  begin
//    BackChar(aStream);
    C := GetNextChar(aStream);
    if C = '>' then
    begin
      Result := TLMDWebTagToken.Create('/' + FTagsStack.Strings[FTagsStack.Count - 1]);
      FTagsStack.Delete(FTagsStack.Count - 1);
      exit;
    end
    else
      BackChar(aStream);
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
          Result:= TLMDWebEofToken.Create;
          exit;
        end;

      if Copy(S, 1, 3) = '!--' then // comments
        begin
          S:= Copy(S, 4, length(S));
          Result := TLMDWebTagToken.Create('!--');
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
          TLMDWebTagToken(Result).Attributes.Add(Copy(S,1,Length(S)-1));
//          Result:= GetToken(aStream);
          exit;
        end;

      //<-- this is to avoid incorrect parsing within tag, e.g. '<=' within
      //the body of <script> tag //VB
      if Length(s) > 0 then
        if (s[1] <> '/') and (s[1] <> '?') and not LMDAnsiIsAlphaNumeric(s[1]) then
          begin
            Result:= GetToken(aStream);
            exit;
          end;
      //-->

      Result:= TLMDWebTagToken.Create(S);
      repeat
        //Parse TAG Attributes
        SkipSpaces(aStream);
        if aStream.Position >= aStream.Size then
          exit;
        C:= GetNextChar(aStream);
        if C = '>' then
          exit;
        if C = '/' then // case when tag selfclosed
        begin
          if aStream.Position >= aStream.Size then
            exit;
          C:= GetNextChar(aStream);
          if C = '>' then
          begin
            FTagsStack.Add(TLMDWebTagToken(Result).TokenText);
            BackChar(aStream);
            BackChar(aStream);
            exit;
          end;
        end;
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
        {$IFNDEF LMDCOMP12}
        if LMDAnsiCharInSet(C, [ '''', '"']) then
        {$ELSE}
        if CharInSet(C, [ '''', '"']) then
        {$ENDIF}
          avPos:= aStream.Position div SizeOf(Char)
        else
          avPos:= (aStream.Position div SizeOf(Char)) + SizeOf(Char);
        BackChar(aStream);
        (Result as TLMDWebTagToken).Attributes.Values[S]:=
(*          AnsiUpperCase(GetString(aStream, ['>'])); // Get ATTR value*)
          GetString(aStream, ['>']); // Get ATTR value
        TLMDWebTagToken(Result).Position[S]:= avPos;
      until false;
    end
  else
    begin
      BackChar(aStream);
      S:= GetWord(aStream, ['<' {, '>'}] { + GetQuoteChars});
      if S <> '' then
        Result:= TLMDWebTextToken.Create(S)
      else
        Result:= GetToken(aStream);
    end;
end;

{-----------------------------------------------------------------------------}
constructor TLMDWebHTMLLex.Create;
begin
  inherited;
  FTagsStack := TLMDMemoryStrings.Create;
end;

{-----------------------------------------------------------------------------}
destructor TLMDWebHTMLLex.Destroy;
begin
  FreeAndNil(FTagsStack);
  inherited;
end;

function TLMDWebHTMLLex.GetDelimChars: TCharSet;
begin
  Result:= ['<', '=', '>'] + GetSpaceChars
end;

end.
