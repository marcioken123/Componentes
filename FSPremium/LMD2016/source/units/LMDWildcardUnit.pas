unit LMDWildcardUnit;
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

LMDWildcardUnit unit (DD)
------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils, LMDStrSupp;

resourcestring
  MSG_MAX_PROCESS_CONST = 'Dead lock';
const
  MAX_PROCESS_CONST = 10000;

type
  TLMDWCTokenType = (ttConst, ttAnySymbols, ttAnySymbol);

  PLMDWCTemplateToken = ^TLMDWCTemplateToken;
  TLMDWCTemplateToken = record
    szToken: string;
    TokenType: TLMDWCTokenType;
  end;
  TLMDWCTemplateTokens = array of TLMDWCTemplateToken;

  TLMDWildcardProcessor = class
  private
    FMatchCase: Boolean;
    function InternalFindWildcard(Stream:TStream;aTemplate: TLMDWCTemplateTokens;
                                  iTokenIndex: Integer; var EndPos: Integer;
                                  bSearch: Boolean; bAllowSpace: Boolean = True): Integer;
    procedure SetMatchCase(const Value: Boolean);
  public
    // TODO:-> Check StringBuilder Class
    function FindWildcard(szTemplate: string; Stream: TStream;
                          var Founded: String;
                          WholeWordsOnly: Boolean;
                          AnySingleCharacter: Char = '?';
                          AnySequenceCharacter: Char = '*'): Integer;
    property MatchCase:Boolean read FMatchCase write SetMatchCase;
  end;

implementation
uses
  LMDStrings;
{ TLMDWildcardProcessor }

function TLMDWildcardProcessor.FindWildcard(szTemplate: string;
  Stream: TStream; var Founded: String; WholeWordsOnly: Boolean;
  AnySingleCharacter: Char = '?'; AnySequenceCharacter: Char = '*'): Integer;

var
  i: Integer;
  TT: TLMDWCTemplateTokens;
  szToken: string;
  iTokens: Integer;
  function AddToken(szT: string; aTokenType: TLMDWCTokenType): PLMDWCTemplateToken;
  begin
    SetLength(TT, iTokens + 1);
    with TT[iTokens] do
      begin
        szToken:= szT;
        TokenType:= aTokenType;
      end;
    Result:= @TT[iTokens];
    Inc(iTokens);
  end;

  procedure AddConstToken;
  begin
    if szToken <> '' then
      begin
        AddToken(szToken, ttConst);
        szToken:= '';
      end;
  end;

begin
    Founded := '';
    Result:= 0;
    {chekit}
    if szTemplate = '' then
      exit;
    {prepair}
    szToken:= '';
    iTokens:= 0;
    i:= 1;
    AddToken(#1, ttConst);
    while i <= Length(szTemplate) do
    begin
      if szTemplate[i] = AnySequenceCharacter then
          begin
            AddConstToken;
            AddToken('*', ttAnySymbols);
          end else
      if szTemplate[i] = AnySingleCharacter then
          begin
            AddConstToken;
            AddToken('$', ttAnySymbol);
          end
        else
        begin
          szToken:= szToken + szTemplate[i];
        end;
      inc(i);
    end;
    AddConstToken;
    if WholeWordsOnly then
      AddToken(#1, ttConst);
    Result := InternalFindWildcard(Stream,TT,0,i,True);
    if (Result>=0) then
      Inc(Result);
    if WholeWordsOnly then
      Dec(i);
    if (Result>=0) and (Result<i) then
    begin
      Stream.Seek(Result, soFromBeginning);
      if i>=Stream.Size then
        i := Stream.Size-1;
      SetLength(Founded,i-Result);
      Stream.Read(Founded[1],i-Result);
      end;
    SetLength(TT, 0);
end;

function TLMDWildcardProcessor.InternalFindWildcard(Stream:TStream;aTemplate: TLMDWCTemplateTokens; iTokenIndex:
          Integer;var EndPos : Integer;bSearch: Boolean;bAllowSpace:Boolean=True): Integer;
var
  i, j: Integer;
  Token: TLMDWCTemplateToken;
  iTmp: Integer;
  iTmpEnd: Integer;
  iPos: Integer;
  bFlag: Boolean;
  iMax : Integer;
  C, C1: Char;
  begin
  iTmpEnd := 0;
  Result:= -1;
  EndPos:=Stream.Position;
  if iTokenIndex >= Length(aTemplate) then
  begin
    Result := EndPos;
    exit;
  end;
  iMax := Stream.Size;
  Token:= aTemplate[iTokenIndex];
  case Token.TokenType of
    ttConst:
      begin
        if bSearch then
        begin

            iPos := LMDSPFindInStream(Stream,Token.szToken,FMatchCase, bAllowSpace);
            while iPos>=0 do
            begin
              j := Stream.Position;
              Stream.Seek(Length(Token.szToken),soFromCurrent);
              iTmp := InternalFindWildcard(Stream,aTemplate, iTokenIndex + 1,iTmpEnd, False);
              if iTmp>=0 then
                begin
                  Result:= j;
                  EndPos := iTmpEnd;
                  break;
                end
              else
                Inc(j);
              Stream.Seek(j,soFromBeginning);
              iPos := LMDSPFindInStream(Stream,Token.szToken,FMatchCase,bAllowSpace);
            end;
        end
        else
        begin
          j := Stream.Position;
          bFlag := True;
          for i:=1 to Length(Token.szToken) do
          begin
            if Stream.Position=iMax then
            begin
              bFlag := False;
              break;
            end;
            C1 := Token.szToken[i];
            Stream.Read(C,sizeof(C));
            if (Length(Token.szToken)=1) and (Token.szToken[1]=#1) then
            begin
              if LMDAnsiIsSpace(C) then
                C := #1;
            end
            else
            begin
              if not FMatchCase then
                C := LMDAnsiUpperChar(C);
              if not FMatchCase then
                C1 := LMDAnsiUpperChar(C1);
              end;
            if C1<>C then
            begin
              bFlag := False;
              break;
            end;
          end;
          EndPos := Stream.Position;
          if bFlag then
          begin
            iTmp := InternalFindWildcard(Stream,aTemplate, iTokenIndex + 1,iTmpEnd, False);
            if iTmp>=0 then
            begin
              Result:= j;
              EndPos := iTmpEnd;
            end
          end
          else
          begin
            Result := -1;
            Stream.Seek(j,soFromBeginning);
            end;
        end;
      end;

    ttAnySymbols:
      begin
        Result := Stream.Position;
        iTmp := InternalFindWildcard(Stream,aTemplate, iTokenIndex + 1,iTmpEnd, True, False);
        if iTmp>=0 then
          EndPos := iTmpEnd
        else
          Result:= -1;
      end;

    ttAnySymbol:
      begin
        if Stream.Position=iMax then
          Result:= -1
        else
          begin
            Result := Stream.Position;
            Stream.Seek(1, soFromCurrent);
            iTmp := InternalFindWildcard(Stream,aTemplate, iTokenIndex + 1,iTmpEnd,False);
            if iTmp>=0 then
              EndPos := iTmpEnd
            else
              Result:= -1;
          end;
      end;
  end;
end;

procedure TLMDWildcardProcessor.SetMatchCase(const Value: Boolean);
begin
  FMatchCase := Value;
end;

end.
