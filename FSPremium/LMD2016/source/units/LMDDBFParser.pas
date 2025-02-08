unit LMDDBFParser;
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

LMDDBFParser unit (VO)
----------------------

Read DBF

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes, LMDText, LMDTable, LMDParser, LMDLex;

type
  { **************************** TLMDCSVParser ******************************* }
  TLMDDBFParser = class(TLMDParser)
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
  SysUtils, LMDDBFReader;

{-----------------------------------------------------------------------------}

function TLMDDBFParser.GetLexClass: TLMDLexClass;
begin
  Result := TLMDLex;
  end;

{-----------------------------------------------------------------------------}

function TLMDDBFParser.Parse(aStream: TStream;
  aGraphicErrorEvent: TLMDGraphicErrorEvent;
  aGetVariable: TLMDGetVariableEvent;
  aEmbdControlCreated : TLMDEmbdControlEvent;
  aRepeatEvent : TLMDRepeatEvent): TLMDParsedTextList;
var
//  T             : TLMDToken;
  tmpTable      : TLMDTable;
  tmpTableRow   : TLMDTableRow;
  tmpTableCell  : TLMDCell;
  tmpParagraph  : TLMDParagraph;
//  L             : TList;
  J             : LongInt;
  DBF           : TLMDDBF;

  procedure ProcessTextData(aParagraph : TLMDParagraph; const aText : string);
  var
    lWord : string;
    I     : LongInt;
  begin
    I := 1;
    while I <= Length(aText) do
      begin
        while (aText[I] = ' ') do
        begin
          aParagraph.AddSubitem(TLMDText.Create(' ', aParagraph));
          inc(I);
          if (I > Length(aText)) then
            break;
        end;

        lWord := '';
        if (I <= Length(aText)) then
        begin
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
  DBF := TLMDDBF.Create(aStream);
  Result:= TLMDParsedTextList.Create(nil);
  tmpTable := TLMDTable(Result.AddSubItem(TLMDTable.Create(Result)));

  while not DBF.Eof do
    begin
      tmpTableRow := TLMDTableRow(tmpTable.AddSubItem(TLMDTableRow.Create(tmpTable)));
      for J := 0 to DBF.Header.FieldDefs.Count-1 do
        begin
          tmpTableCell := TLMDCell(tmpTableRow.AddSubItem(TLMDCell.Create(tmpTableRow)));
          tmpParagraph := TLMDParagraph(tmpTableCell.AddSubItem(TLMDParagraph.Create(tmpTableCell)));
          ProcessTextData(tmpParagraph, DBF.ReadFieldAsString(J));
        end;
      DBF.MoveNext;
    end;

  tmpTable.Prepare;
  if assigned(result) then Result.ApplyVariables(aGetVariable);
  DBF.Free;
end;

initialization
  RegisterParser(TLMDDBFParser, ['DBF'], False);
end.
