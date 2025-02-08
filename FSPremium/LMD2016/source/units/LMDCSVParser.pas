unit LMDCSVParser;
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

LMDCSVParser unit (VO)
----------------------

CSV Parser

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, LMDText, LMDTable, LMDCSVLex, LMDParser, LMDLex;

type
  { **************************** TLMDCSVParser ******************************* }
  TLMDCSVParser = class(TLMDParser)
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

function TLMDCSVParser.GetLexClass: TLMDLexClass;
begin
 Result:= TLMDCSVLex;
end;

function TLMDCSVParser.Parse(aStream: TStream;
  aGraphicErrorEvent: TLMDGraphicErrorEvent;
  aGetVariable: TLMDGetVariableEvent;
  aEmbdControlCreated : TLMDEmbdControlEvent;
  aRepeatEvent : TLMDRepeatEvent): TLMDParsedTextList;
var
  T             : TLMDToken;
  tmpTable      : TLMDTable;
  tmpTableRow   : TLMDTableRow;
  tmpTableCell  : TLMDCell;
  tmpParagraph  : TLMDParagraph;
  L             : TList;
  J             : LongInt;
  tmpNL         : boolean;

  procedure ProcessTextData(aParagraph : TLMDParagraph; const aText : string);
  var
    lWord : string;
    I     : LongInt;
  begin
    I := 1;
    while I <= Length(aText) do
      begin
        // ATTENTION: I think this isn't good solution...
//        while (aText[I] = ' ') and (I <= Length(aText)) do
//          begin
//          aParagraph.AddSubitem(TLMDText.Create(' ', aParagraph));
//          inc(I);
//          end;
//
//        lWord := '';
//        while (aText[I] <> ' ') and (I <= Length(aText)) do
//          begin
//            lWord := lWord+ aText[I];
//            inc(I);
//          end;
//        if Length(lWord) > 0 then
//          aParagraph.AddSubitem(TLMDText.Create(lWord, aParagraph));
        while (aText[I] = ' ') do
        begin
          aParagraph.AddSubitem(TLMDText.Create(' ', aParagraph));
          inc(I);
          if (I > Length(aText)) then
            break;
        end;

        if (I <= Length(aText)) then
        begin
          lWord := '';
          while (aText[I] <> ' ') do
          begin
            lWord := lWord+ aText[I];
            inc(I);
            if (I > Length(aText)) then
              break;
          end;
        end;
        if Length(lWord) > 0 then
          aParagraph.AddSubitem(TLMDText.Create(lWord, aParagraph));
      end;
  end;

begin
  Result:= TLMDParsedTextList.Create(nil);
  tmpTable := TLMDTable(Result.AddSubItem(TLMDTable.Create(Result)));
  tmpNL := True;
  tmpTableRow := nil;

  L := TList.Create;
  repeat
    T := Lex.GetToken(aStream);
    case T.TokenType of
      ttText :
        begin
          if tmpNL then
            begin
              tmpTableRow := TLMDTableRow(tmpTable.AddSubItem(TLMDTableRow.Create(tmpTable)));
              tmpNL := False;
            end;
          tmpTableCell := TLMDCell(tmpTableRow.AddSubItem(TLMDCell.Create(tmpTableRow)));
          tmpParagraph := TLMDParagraph(tmpTableCell.AddSubItem(TLMDParagraph.Create(tmpTableCell)));
          ProcessTextData(tmpParagraph, TLMDTextToken(T).TokenText);
        end;
      ttTag :
        tmpNL := True;
    end;
    L.Add(T);
  until T.TokenType = ttEOF;

  for J := 0 to L.Count-1 do
    if assigned(L[J]) then
      TLMDToken(L[J]).Free;
  L.Free;
  tmpTable.Prepare;
  if assigned(result) then Result.ApplyVariables(aGetVariable);
end;

initialization
  RegisterParser(TLMDCSVParser, ['CSV'], False);
end.
