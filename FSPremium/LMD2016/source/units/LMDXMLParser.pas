unit LMDXMLParser;
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

LMDXMLParser unit (VO)
----------------------



ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, LMDText, LMDTable, LMDXMLLex, LMDParser, LMDLex, LMDTree;

type
  { **************************** TLMDXMLParser ******************************* }
  TLMDXMLParser = class(TLMDParser)
  private
    function  ProcessText(aRoot : TLMDParsedTextList; aText : string) : TLMDBaseText;
    procedure ParseBranch(aRoot : TLMDTree; aStream : TStream; aOpenText : string);
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
uses
  SysUtils;

{-----------------------------------------------------------------------------}
function  TLMDXMLParser.ProcessText(aRoot : TLMDParsedTextList; aText : string) : TLMDBaseText;
var
  lWord : string;
  J     : LongInt;
begin
  result := TLMDParagraph.Create(aRoot);
  J := 1;
  while J <= Length(aText) do
    begin
      // ATTENTION: I think this isn't good solution...
//      while (aText[J] = ' ') and (J <= Length(aText)) do
//        begin
//          TLMDParagraph(result).AddSubitem(TLMDText.Create(' ', TLMDParagraph(result)));
//          inc(J);
//        end;
//      lWord := '';
//      while (aText[J] <> ' ') and (J <= Length(aText)) do
//        begin
//          lWord := lWord+ aText[J];
//          inc(J);
//        end;
//      if Length(lWord) > 0 then
//        TLMDParagraph(result).AddSubitem(TLMDText.Create(lWord, TLMDParagraph(result)));

      while (aText[J] = ' ') do
        begin
          TLMDParagraph(result).AddSubitem(TLMDText.Create(' ', TLMDParagraph(result)));
          inc(J);
          if (J > Length(aText)) then
            break;
        end;

      lWord := '';
      if (J <= Length(aText)) then
      begin
        while (aText[J] <> ' ') do
        begin
          lWord := lWord+ aText[J];
          inc(J);
          if (J > Length(aText)) then
            break;
        end;
      end;
      if Length(lWord) > 0 then
        TLMDParagraph(result).AddSubitem(TLMDText.Create(lWord, TLMDParagraph(result)));
    end;
end;

{-----------------------------------------------------------------------------}
procedure TLMDXMLParser.ParseBranch(aRoot : TLMDTree; aStream : TStream; aOpenText : string);
var
  T             : TLMDToken;
  L             : TList;
  I             : LongInt;
  pBranch       : TLMDTree;
  tmpStr        : string;
begin
  L := TList.Create;
  tmpStr := '';

  T := Lex.GetToken(aStream);
  L.Add(T);

  if T.TokenType = ttText then
    begin
      tmpStr := TLMDTextToken(T).TokenText;
      T := Lex.GetToken(aStream);
      L.Add(T);
      if (T.TokenType = ttTag) and (AnsiSameText(TLMDTagToken(T).TokenText,'CLOSE')) then
      begin
          aRoot.AddSubitem(ProcessText(aRoot, '<'+aOpenText+'>' + tmpStr + '<'+TLMDTagToken(T).Attributes.Values['CONTENT']+'>'));
          for I := 0 to L.Count-1 do
          if assigned(L[I]) then TLMDToken(L[I]).Free;
          L.Free;
          exit;
        end
    end;

  aRoot.AddSubitem(ProcessText(aRoot, '<'+aOpenText+'>'));
  pBranch := TLMDTree(aRoot.AddSubitem(TLMDTree.Create(aRoot)));
  if tmpStr <> '' then
    pBranch.AddSubitem(ProcessText(pBranch, tmpStr));
  while T.TokenType <> ttEof do
    begin
      case T.TokenType of
        ttTag  :
          begin
            if AnsiSameText(TLMDTagToken(T).TokenText, 'OPEN') then
            ParseBranch(pBranch, aStream, TLMDTagToken(T).Attributes.values['CONTENT'])
            else if AnsiSameText(TLMDTagToken(T).TokenText, 'EMPTY') then
            pBranch.AddSubitem(ProcessText(pBranch, '<'+TLMDTagToken(T).Attributes.values['CONTENT']+'>'))
            else if AnsiSameText(TLMDTagToken(T).TokenText, 'CLOSE') then
            begin
                aRoot.AddSubitem(ProcessText(aRoot, '<'+TLMDTagToken(T).Attributes.values['CONTENT']+'>'));
                break;
              end
            else;
          end;
        ttText :
          pBranch.AddSubitem(ProcessText(pBranch, TLMDTextToken(T).TokenText));
      end;
      T := Lex.GetToken(aStream);
      L.Add(T);
    end;
  for I := 0 to L.Count-1 do
    if assigned(L[I]) then
      TLMDToken(L[I]).Free;
  L.Free;
end;

{-----------------------------------------------------------------------------}
function TLMDXMLParser.GetLexClass: TLMDLexClass;
begin
 Result:= TLMDXMLLex;
end;

function TLMDXMLParser.Parse(aStream: TStream;
  aGraphicErrorEvent: TLMDGraphicErrorEvent;
  aGetVariable: TLMDGetVariableEvent;
  aEmbdControlCreated : TLMDEmbdControlEvent;
  aRepeatEvent : TLMDRepeatEvent): TLMDParsedTextList;
var
  tmpTree       : TLMDTree;
  T             : TLMDToken;
  L             : TList;
  I             : LongInt;
begin
  Result := TLMDParsedTextList.Create(nil);
  tmpTree := TLMDTree(Result.AddSubitem(TLMDTree.Create(Result, True)));
  L := TList.Create;
  repeat
    T := Lex.GetToken(aStream);
    L.Add(T);
    if (T.TokenType = ttTag) then
      begin
        if AnsiSameText(TLMDTagToken(T).TokenText, 'OPEN') then break;
        tmpTree.AddSubitem(ProcessText(tmpTree, '<'+TLMDTagToken(T).Attributes.values['CONTENT']+'>'));
      end;
  until T.TokenType = ttEOF;

  if AnsiSameText(TLMDTagToken(T).TokenText, 'OPEN') then
  ParseBranch(tmpTree, aStream, TLMDTagToken(T).Attributes.Values['CONTENT']);

  for I := 0 to L.Count-1 do
    if assigned(L[I]) then
      TLMDToken(L[I]).Free;
  L.Free;
  if assigned(result) then Result.ApplyVariables(aGetVariable);
end;

initialization
  RegisterParser(TLMDXMLParser, ['XML'], False);
end.
