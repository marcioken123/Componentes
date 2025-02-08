unit LMDHTTPSupp;
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

LMDHTTPSupp unit (DD)
--------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, SysUtils;
{
procedure ExtractHTTPFields(Separators, WhiteSpace: TSysCharSet; Content: PChar;
  Strings: TStrings; StripQuotes: boolean = False);
procedure ExtractHeaderFields(Separators, WhiteSpace: TSysCharSet;
  Content: PChar; Strings: TStrings; Decode: boolean; StripQuotes: boolean = False);
}
procedure ExtractHTTPFields(Separators, WhiteSpace: TSysCharSet; const Content: string;
  Strings: TStrings; StripQuotes: boolean = False);
procedure ExtractHeaderFields(Separators, WhiteSpace: TSysCharSet;
  const Content: string; Strings: TStrings; Decode: boolean; StripQuotes: boolean = False);
function HTTPDecode(const AStr: string): string;
function HTTPEncode(const szStr: string; const szSpace: string = '+'): string;

function HTTPGetHeader(szHeader: PChar; const szHeaderName: string): string; overload;

function HTTPGetHeader(const szHeader: string; const szHeaderName: string): string; overload;
function ParseDate(const DateStr: string): TDateTime;
function ParseDateEx(const DateStr: string; DateFormat: string): TDateTime;
function ExtractSetCookies(const szHeader: string; DeleteExCookies: boolean = True): string; overload;
procedure ExtractSetCookies(const szHeader: string; FGetCookies: TStrings;
  DeleteExCookies: boolean); overload;
function BuildCookies(Cookies: TStrings): string; overload;
function BuildCookies(const szCookies: string): string; overload;

implementation

uses
  LMDStringsSupport, LMDFSSupport;

function BuildCookies(Cookies: TStrings): string;
var
  i: integer;
  S: string;
begin
  Result := '';

  if  Assigned(Cookies) then
    for i := 0 to Cookies.Count - 1 do
      begin
        S := Cookies.Names[i];
        if  not IsAnyStr(S, ['expires', 'path'], True)  then
          if  Result = '' then
            Result := S
          else
            Result := Result + '; ' + S;
      end;
end;

{-----------------------------------------------------------------------------}

function BuildCookies(const szCookies: string): string;
var
  Cookies: TStringList;
begin
  Cookies := TStringList.Create;
  try
    Cookies.Text := szCookies;
    Result := BuildCookies(Cookies);
  finally
    Cookies.Free;
  end;
end;

{-----------------------------------------------------------------------------}

function ExtractSetCookies(const szHeader: string; DeleteExCookies: boolean): string;
var
  FGetCookies: TStringList;
begin
  Result:= '';
  FGetCookies:= TStringList.Create;
  try
    ExtractSetCookies(szHeader, FGetCookies, DeleteExCookies);

    if FGetCookies.Count > 0 then
      Result:= FGetCookies.Text;
  finally
    FGetCookies.Free;
  end;
end;

{-----------------------------------------------------------------------------}

procedure ExtractSetCookies(const szHeader: string; FGetCookies: TStrings;
  DeleteExCookies: boolean);
var
  szBuf: string;
  i: integer;
begin
  FGetCookies.BeginUpdate;
  try
    szBuf:= HTTPGetHeader(szHeader, 'Set-Cookie: ');
    ExtractHeaderFields([';'], [' '], szBuf, FGetCookies, False);

    if  DeleteExCookies then
      for i := FGetCookies.Count - 1 downto 0 do
        if  IsAnyStr(FGetCookies.Names[i], ['EXPIRES', 'DOMAIN', 'PATH'], True) then
          FGetCookies.Delete(i);
  finally
    FGetCookies.EndUpdate;
  end;
end;

{-----------------------------------------------------------------------------}
function HTTPDecode(const AStr: string): string;
var
  iCharCode, iRes, iStr, LenStr: integer;
  C: AnsiChar;
begin
  LenStr := Length(AStr);
  SetLength(Result, LenStr);
  iRes := 1;
  iStr := 1;

  while (iStr <= LenStr) and (AStr[iStr] <> #0) do
    begin
      C := AnsiChar(AStr[iStr]);
      if not (C in ['+', '%']) then
        Result[iRes] := Char(C)
      else
      if C = '+' then
        Result[iRes] := ' '
      else
      if  iStr = LenStr then
        Result[iRes] := ' '   //    ????
      else
        begin
          Inc(iStr);

          if AnsiChar(AStr[iStr]) = '%' then
            Result[iRes] := '%'
          else
            begin
              if (TryStrToInt('$' + Copy(AStr, iStr, 2), iCharCode)) then
              begin
                Result[iRes] := Chr(iCharCode);
                Inc(iStr);
              end
              else
              begin
                Result[iRes] := AStr[iStr - 1];
                inc(iRes);
                Result[iRes] := AStr[iStr];
              end;
            end;
        end;

      Inc(iRes);
      Inc(iStr);
    end;

  SetLength(Result, iRes - 1);
end;

{-----------------------------------------------------------------------------}

function HTTPEncode(const szStr: string; const szSpace: string = '+'): string;
const
  NoConversion = ['A'..'Z', 'a'..'z', '*', '@', '.', '_', '-', '0'..'9', '$',
    '!', '''', '(', ')'];
var
  i: integer;
  iCount: integer;
begin
  Result:= '';
  iCount:= Length(szStr);
  for i:= 1 to iCount do
    begin
      if AnsiChar(szStr[i]) in NoConversion then
        Result:= Result + szStr[i]
      else
        if szStr[i] = ' ' then
          Result:= Result + szSpace
        else
          Result:= Result + Format('%%%.2x', [Ord(szStr[i])]);
    end;
end;

{-----------------------------------------------------------------------------}

procedure ExtractHeaderFields(Separators, WhiteSpace: TSysCharSet;
      const Content: string; Strings: TStrings; Decode: boolean;
      StripQuotes: boolean = False);

  function DoStripQuotes(const S: string): string;
  var
    i: integer;
  begin
    Result:= S;
    if StripQuotes then
      for i:= Length(Result) downto 1 do
//        if Result[i] = QuoteChar  then
        if AnsiChar(Result[i]) in ['''', '"'] then    //    ???
          Delete(Result, i, 1);
  end;
  var
  i, i0: integer;
  S: string;
begin
  Strings.BeginUpdate;

  try
    i0 := Strings.Count;

    ExtractStrings(Separators, WhiteSpace, PChar(Content), Strings);

    if  Decode or StripQuotes then
      for i := i0 to Strings.Count - 1 do
        begin
          S := Strings[i];

          if  Decode  then  S := HTTPDecode(S);

          Strings[i] := DoStripQuotes(S);
        end;
  finally
    Strings.EndUpdate;
  end;
end;

{-----------------------------------------------------------------------------}

procedure ExtractHTTPFields(Separators, WhiteSpace: TSysCharSet; const Content: string;
  Strings: TStrings; StripQuotes: boolean = False);
begin
  ExtractHeaderFields(Separators, WhiteSpace, Content, Strings, True,
    StripQuotes);
end;

{-----------------------------------------------------------------------------}

function HTTPGetHeader(const szHeader: string; const szHeaderName: string): string;
var
  LenHeaderName: integer;
  sResult: string;

  procedure ProcessPart(iB, iE: integer);
  var
    S: string;
  begin
    //  Skip blanks
    while (iB < iE) and (szHeader[iB] <= ' ') do inc(iB);

    if  ((iE - iB) > LenHeaderName)
        and SameText(Copy(szHeader, iB, LenHeaderName), szHeaderName)  then
      begin
        S := Copy(szHeader, iB + LenHeaderName, iE - iB - LenHeaderName);

        if sResult = '' then
          sResult := S
        else
          sResult := sResult + '; ' + S;
      end;
  end;

var
  i, iH, LenHeader: integer;
begin
  sResult := '';
  LenHeader := Length(szHeader);
  LenHeaderName := Length(szHeaderName);
  iH := 1;

  for i := 1 to LenHeader - 1 do
    if (szHeader[i] = #0) or ((szHeader[i] = #13)
        and (szHeader[i + 1] = #10)) then
      begin
        ProcessPart(iH, i);
        iH := i + 1;
      end;

  ProcessPart(iH, LenHeader);
  Result := sResult;
end;

{-----------------------------------------------------------------------------}

function HTTPGetHeader(szHeader: PChar; const szHeaderName: string): string;
var
  szTmp: string;
  i: integer;
begin
  i:= 0;
  Result:= '';
  szTmp:= '';
  while not ((szHeader[i] = #0) and (szTmp = '')) do
    begin
      if (szHeader[i] <> #0) and ((szHeader[i] <> #13) and (szHeader[i + 1] <>
        #10)) then
        szTmp:= szTmp + szHeader[i]
      else
        begin
          if pos(szHeaderName, szTmp) <> 0 then
            begin
              if Result <> '' then
                Result:= Result + '; ';
              Result:= Result + Copy(szTmp, Length(szHeaderName) +
                pos(szHeaderName, szTmp), Length(szTmp));
            end;
          //      if szHeader[i]<>#13 then
          //        Inc(i);
          szTmp:= '';
        end;
      Inc(i);
    end;
end;

const
  // These strings are NOT to be resourced
  Months: array[1..12] of string = ('Jan', 'Feb', 'Mar', 'Apr',
    'May', 'Jun', 'Jul', 'Aug',
    'Sep', 'Oct', 'Nov', 'Dec');
  DaysOfWeek: array[1..7] of string = ('Sun', 'Mon', 'Tue', 'Wed',
    'Thu', 'Fri', 'Sat');

  {-----------------------------------------------------------------------------}

function ParseDate(const DateStr: string): TDateTime;
var
  Month, Day, Year, Hour, Minute, Sec: integer;
  Parser: TParser;
  StringStream: TStream;

  function GetMonth: boolean;
  begin
    Month:= 1;
    while (Month < 13) and not Parser.TokenSymbolIs(Months[Month]) do
      Inc(Month);
    Result:= Month < 13;
  end;

  procedure GetTime;
  begin
    with Parser do
      begin
        Hour:= TokenInt;
        NextToken;
        if Token = ':' then
          NextToken;
        Minute:= TokenInt;
        NextToken;
        if Token = ':' then
          NextToken;
        Sec:= TokenInt;
        NextToken;
      end;
  end;
begin
  Result := 0;
  Parser:= nil;
//  StringStream:= TStringStream.Create(DateStr);   -- D8 bug!
  StringStream:= TMemoryStream.Create;
  try
    LMDWebStringToStream(StringStream, DateStr);
    StringStream.Position := 0; 
    Year := 0;
    Month := 0;
    Day := 0;
    Hour := 0;
    Minute := 0;
    Sec := 0;
    Parser:= TParser.Create(StringStream);
    Parser.NextToken;

    if Parser.Token = ':' then
      Parser.NextToken;
    Parser.NextToken;
    if Parser.Token = ',' then
      Parser.NextToken;
    if (Parser.Token = toString) and GetMonth then
      begin
        Parser.NextToken;
        Day:= Parser.TokenInt;
        Parser.NextToken;
        GetTime;
        Year:= Parser.TokenInt;
      end
    else
    if (Parser.Token = toInteger)  then
      begin
        Day:= Parser.TokenInt;
        Parser.NextToken;
        if Parser.Token = '-' then
          Parser.NextToken;
        GetMonth;
        Parser.NextToken;
        if Parser.Token = '-' then
          Parser.NextToken;
        Year:= Parser.TokenInt;
        if Year < 100 then
          Inc(Year, 1900);
        Parser.NextToken;
        GetTime;
      end;
    if  (Month >= 1) and (Month <= 12) and (Day >= 1) and (Day <= 31) then
      Result:= EncodeDate(Year, Month, Day) +
               EncodeTime(Hour, Minute, Sec, 0);
  finally
    Parser.Free;
    StringStream.Free;
  end;
end;
// Y - YEAR
// D - DAY
// M - MONTH
// J - String MONTH
// H - HOUR
// N - MINUTES
// S - SECUNDES
// L - AM/PM
// - - SKIP

{-----------------------------------------------------------------------------}

function ParseDateEx(const DateStr: string; DateFormat: string): TDateTime;
var
  Month, Day, Year, Hour, Minute, Sec: integer;
  iPos : Integer;
  szTokenString:String;
  i: integer;
  bAbort: boolean;
  szTmp: string;
  bToken : Boolean;

  function GetNextToken(const Str: String; var iPos:Integer;var Token:String):Boolean;
  var
    bInt,bComp : Boolean;
    L: integer;
  begin
//    Result := iPos<=Length(Str);
    Token  := '';
    L := Length(Str);

    while (iPos <= L) and (Str[iPos] <> ' ') do
      Inc(iPos);

    Result := (iPos <= L);

    if not Result then
    begin
      exit;
    end;

    Token := Str[iPos];
    bInt := AnsiChar(Str[iPos]) in ['0'..'9'];
    Inc(iPos);
    if not (AnsiChar(Token[1]) in [' ','!'..'/',':'..'@','['..'`']) then
    while iPos <= L do
    begin
      if bInt then
        bComp := not (AnsiChar(Str[iPos]) in ['0'..'9'])
      else
        bComp := (AnsiChar(Str[iPos]) in [' ','!'..'/',':'..'@','['..'`']);
      if bComp then
        break;
      Token := Token+Str[iPos];
      Inc(iPos);
    end;
  end;

  function GetMonth: boolean;
  begin
    Month:= 1;

    while (Month < 13) and not SameText(szTokenString, Months[Month]) do
      Inc(Month);
    Result:= Month < 13;
  end;
begin
  Result:= 0;
  Hour:= 0;
  Year:= -1;
  Day:= 0;
  Month:= 0;
  Minute:= 0;
  Sec:= 0;
  iPos := 1;
  bAbort:= False;
  szTmp:= '';
  szTokenString := '';
  for i:= 1 to Length(DateFormat) do
    case DateFormat[i] of
       #13,#10:;
       ',','.': szTmp:= szTmp + '/';
     else
       szTmp:= szTmp + DateFormat[i];
    end;
  DateFormat := szTmp;

  szTmp:= '';
  for i:= 1 to Length(DateStr) do
    case DateStr[i] of
       #13,#10:;
       ',','.': szTmp:= szTmp + '/';
     else
       szTmp:= szTmp + DateStr[i];
    end;
  bToken := GetNextToken(szTmp,iPos,szTokenString);
  try
    for i:= 1 to Length(DateFormat) do
      begin
        if not bToken then
          begin
            bAbort:= True;
            Break;
          end;
        case DateFormat[i] of
          'y','Y':
            begin
              Year:= StrToInt64(szTokenString);
            end;
          'd','D':
            begin
              Day:= StrToInt64(szTokenString);
            end;
          'm','M':
            begin
              Month:= StrToInt64(szTokenString);
            end;
          'j','J':
            begin
              GetMonth;
            end;
          'h','H':
            begin
              Hour:= StrToInt64(szTokenString);
            end;
          'n','N':
            begin
              Minute:= StrToInt64(szTokenString);
            end;
          's','S':
            begin
              Sec:= StrToInt64(szTokenString);
            end;
          'l','L':
            begin
              if UpperCase(szTokenString) = 'PM' then
                Inc(Hour, 12);
              if Hour >= 24 then
                Hour:= Hour - 24;
            end;
          '-':
            begin
            end;
        else
          if szTokenString<>DateFormat[i] then
            begin
              bAbort:= True;
              Break;
            end;
        end;
        bToken := GetNextToken(szTmp,iPos,szTokenString);
      end;
    if not bAbort then
      begin
        if (Year < 100) and (Year >= 0) then
          begin
            if Year < 80 then
              Inc(Year, 2000)
            else
              Inc(Year, 1900);
          end;
        try
          if Year = -1 then
            Result:= Trunc(Now) + EncodeTime(Hour, Minute, Sec, 0)
            else
            Result:= EncodeDate(Year, Month, Day) + EncodeTime(Hour, Minute, Sec, 0);
        except
          Result:= 0;
        end;
      end;
  except
    Result := 0;
  end;
end;

end.
