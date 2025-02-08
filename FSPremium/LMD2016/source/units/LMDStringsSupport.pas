unit LMDStringsSupport;
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

LMDStringsSupport unit (DD)
---------------------------
LMD Strings support

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Classes, SysUtils,
  LMDStrings;

type
  TCharSet = TSysCharSet;

function WordCount(const S: string; const WordDelims: TCharSet): Integer;
function ExtractWord(N: Integer; const S: string; const WordDelims: TCharSet):
  string;
function WordPosition(const N: Integer; const S: string;
  const WordDelims: TCharSet): Integer;
function DelSpace1(const S: string): string;

function GetYear: string;
function CheckName(List: TStringList; const szStr: string): string;

function SetHighLight(const Value, szWords, szBegin, szEnd: string): string;
function IsAnyStr(const szStr: string; const Arr: array of string;
          IgnoreCase: Boolean = False): Boolean;

implementation

{=== Local ====================================================================}

function DelSpace1(const S: string): string;
var
  I: Integer;
begin
  Result:= S;
  for I:= length(Result) downto 2 do
    begin
      if (Result[I] = ' ') and (Result[I - 1] = ' ') then
        Delete(Result, I, 1);
    end;
end; {DelSpace1 - local}

//------------------------------------------------------------------------------

function WordPosition(const N: Integer; const S: string; const WordDelims: TCharSet): Integer;
var
  Count, I, L: Integer;
begin
  Count:= 0;
  I:= 1;
  Result:= 0;
  L := Length(S);
  while (I <= L) and (Count <> N) do
    begin
      {skip over delimiters}
      while (I <= L) and (AnsiChar(S[I]) in WordDelims) do
        Inc(I);
      {if we're not beyond end of S, we're at the start of a word}
      if I <= L then
        Inc(Count);
      {if not finished, find the end of the current word}
      if Count <> N then
        while (I <= L) and not (AnsiChar(S[I]) in WordDelims) do
          Inc(I)
      else
        Result:= I;
    end;
end; {WordPosition - local}

//------------------------------------------------------------------------------

function ExtractWord(N: Integer; const S: string; const WordDelims: TCharSet): string;
var
  I: Integer;
  Len, L: Integer;
begin
  Len:= 0;
  L := Length(S);
  I:= WordPosition(N, S, WordDelims);
  if I <> 0 then
    {find the end of the current word}
    while (I <= L) and not (AnsiChar(S[I]) in WordDelims) do
      begin
        {add the I'th character to result}
        Inc(Len);
        SetLength(Result, Len);
        Result[Len]:= S[I];
        Inc(I);
      end;
  SetLength(Result, Len);
end; {ExtractWord - local}

//------------------------------------------------------------------------------

function WordCount(const S: string; const WordDelims: TCharSet): Integer;
var
  SLen, I: Cardinal;
begin
  Result:= 0;
  I:= 1;
  SLen:= length(S);
  while I <= SLen do
    begin
      while (I <= SLen) and (AnsiChar(S[I]) in WordDelims) do
        Inc(I);
      if I <= SLen then
        Inc(Result);
      while (I <= SLen) and not (AnsiChar(S[I]) in WordDelims) do
        Inc(I);
    end;
end; {WordCount - local}

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
function GetYear: string;
var
  Present: TDateTime;
  Year, Month, Day: Word;
begin
  Present:= Now;
  DecodeDate(Present, Year, Month, Day);
  Result:= IntToStr(Year);
end; {GetYear - local}

//------------------------------------------------------------------------------

function CheckName(List: TStringList; const szStr: string): string;
var
  I: Integer;
begin
  Result:= szStr;
  I:= 1;
  while List.IndexOfName(Result) >= 0 do
    begin
      Result:= szStr + IntToStr(I);
      Inc(I);
    end;
end;
//------------------------------------------------------------------------------

function SetHighLightWord(szStr, szWord, szBegin, szEnd: string): string;
var
  I, j: Integer;
  Index: Integer;
  szTmp: string;
begin
  Result:= '';
  szWord:= WideUpperCase(szWord);
  szTmp:= WideUpperCase(szStr);
  Index:= 1;
  I:= LMDAnsiPosEx(szWord, szTmp, 1);
  while I > 0 do
    begin
      Result:= Result + Copy(szStr, Index, I - Index);

      j:= I + length(szWord);
      if j = length(szStr) then
        Inc(j);
      Result:= Result + szBegin + Copy(szStr, I, j - I) + szEnd;
      Index:= j;
      I:= LMDAnsiPosEx(szWord, szTmp, j);
    end;
  Result:= Result + Copy(szStr, Index, length(szStr) - Index + 1);
end;

function SetHighLight(const Value, szWords, szBegin, szEnd: string): string;
var
  I: Integer;
begin
  Result:= '';
  if (length(Value) < 1) then
    exit;
  Result:= Value;
  for I:= 1 to WordCount(szWords, [' ']) do
    Result:= SetHighLightWord(Result, ExtractWord(I, szWords, [' ']), szBegin,
      szEnd);
  Result:= Trim(Result);
end;

function IsAnyStr(const szStr: string; const Arr: array of string;
          IgnoreCase: Boolean = False): Boolean;
var
  i: integer;
begin
  Result := False;

  if  IgnoreCase  then
    begin
      for i := Low(Arr) to High(Arr) do
        if  SameText(szStr, Arr[i]) then
          begin
            Result := True;
            break;
          end;
    end
  else
    for i := Low(Arr) to High(Arr) do
      if  szStr = Arr[i] then
        begin
          Result := True;
          break;
        end;
end;

end.
