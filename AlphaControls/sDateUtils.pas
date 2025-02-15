unit sDateUtils;
{$I sDefs.inc}

interface

uses
  Windows, SysUtils,
  sConst, acntUtils;


{$IFNDEF NOTFORHELP}
const
  NullDate: TDateTime = 0;


var
  NormalYears: boolean;


function GetDateOrder(const DateFormat: string): TDateOrder;
function InternalStrToDate(const DateFormat, S: string; var Date: TDateTime): Boolean;
procedure ExtractMask(const Format, S: AnsiString; Ch: AnsiChar; Cnt: Integer; var I: Integer; Blank, Default: Integer);
function ScanDateStr(const Format, S: string; var D, M, Y: Integer): Boolean;
function ScanDate(const S, DateFormat: string; var Pos: Integer; var Y, M, D: Integer): Boolean;
// from SYSUTILS.PAS
{$ENDIF} // NOTFORHELP

function CurrentYear: Word;
function DaysPerMonth(AYear, AMonth: Integer): Integer;
function DefDateFormat(NormalYears: Boolean): string;
function DefDateMask(BlanksChar: Char; NormalYears: Boolean): string;
function ExpandYear(Year: Integer): Integer;
function ExtractMonth(ADate: TDateTime): Word;
function ExtractYear(ADate: TDateTime): Word;
function FirstDayOfCurrMonth(D: TDateTime): TDateTime;
function ValidDate(ADate: TDateTime): Boolean;
function IsValidDate(Y, M, D: Word): Boolean;
function MonthFromName(const S: string; MaxLen: Byte): Byte;
function DateToLongStr(aDate: TDateTime): acString;


implementation


function FirstDayOfCurrMonth(D: TDateTime): TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(D, Year, Month, Day);
  Day := 1;
  Result := EncodeDate(Year, Month, Day);
end;


function DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then
    Inc(Result); { leap-year Feb is special }
end;


function ExtractMonth(ADate: TDateTime): Word;
var
  D, Y: Word;
begin
  DecodeDate(ADate, Y, Result, D);
end;


function ExtractYear(ADate: TDateTime): Word;
var
  D, M: Word;
begin
  DecodeDate(ADate, Result, M, D);
end;


function DefDateFormat(NormalYears: Boolean): string;
var
  Y: ShortString;
begin
  Y := iff(NormalYears, 'YYYY', 'YY');
  case GetDateOrder({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ShortDateFormat) of
    doMDY: Result := 'MM/DD/' + Y;
    doDMY: Result := 'DD/MM/' + Y;
    doYMD: Result := Y + '/MM/DD';
  end
end;


function GetDateOrder(const DateFormat: string): TDateOrder;
var
  I: Integer;
begin
  Result := doDMY;
  I := 1;
  while I <= Length(DateFormat) do begin
    case Chr(Ord(DateFormat[I]) and $DF) of
      'Y': Result := doYMD;
      'M': Result := doMDY;
      'D': Result := doDMY;
      else
        Inc(I);
        Continue;
    end;
    Break;
  end;
end;


function DefDateMask(BlanksChar: Char; NormalYears: Boolean): string;
begin
  if NormalYears then
    case GetDateOrder({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ShortDateFormat) of
      doMDY, doDMY: Result := '!99/99/9999;1;';
      doYMD:        Result := '!9999/99/99;1;';
    end
  else
    case GetDateOrder({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ShortDateFormat) of
      doMDY, doDMY: Result := '!99/99/99;1;';
      doYMD:        Result := '!99/99/99;1;';
    end;

  if Result <> '' then
    Result := Result + BlanksChar;
end;


function ValidDate(ADate: TDateTime): Boolean;
var
  Year, Month, Day: Word;
begin
  try
    DecodeDate(ADate, Year, Month, Day);
    Result := IsValidDate(Year, Month, Day);
  except
    Result := False;
  end;
end;


function IsValidDate(Y, M, D: Word): Boolean;
begin
  Result := (Y >= 1) and (Y <= 9999) and (M >= 1) and (M <= 12) and (D >= 1) and (D <= DaysPerMonth(Y, M));
end;


function InternalStrToDate(const DateFormat, S: string; var Date: TDateTime): Boolean;
var
  D, M, Y: Integer;
begin
  if S = '' then begin
    Date := NullDate;
    Result := True;
  end
  else begin
    Result := ScanDateStr(DateFormat, S, D, M, Y);
    if Result then
      try
        Date := EncodeDate(Y, M, D);
      except
        Result := False;
      end;
  end;
end;


function ScanDateStr(const Format, S: string; var D, M, Y: Integer): Boolean;
var
  Pos: Integer;
begin
  ExtractMask(Format, S, 'm', 3, M, -1, 0); { short month name? }
  if M = 0 then
    ExtractMask(Format, S, 'm', 1, M, -1, 0);

  ExtractMask(Format, S, 'd', 1, D, -1, 1);
  ExtractMask(Format, S, 'y', 1, Y, -1, CurrentYear);
  Y := ExpandYear(Y);
  Result := (M > 0) and (D > 0) and IsValidDate(Y, M, D);
  if not Result then begin
    Pos := 1;
    Result := ScanDate(S, Format, Pos, Y, M, D);
  end;
end;


procedure ExtractMask(const Format, S: AnsiString; Ch: AnsiChar; Cnt: Integer; var I: Integer; Blank, Default: Integer);
var
  Tmp: string[20];
  J, L, ix: integer;
begin
  I := Default;
  Ch := UpCase(Ch);
  L := Length(Format);
  if Length(S) < L then
    L := Length(S)
  else
    if Length(S) > L then
      Exit;

  J := Pos(MakeStr(Ch, Cnt), AnsiUpperCase(Format));
  if J <= 0 then
    Exit;

  Tmp := '';
  ix := Length(Format);
  if not ((ix < Cnt) or (ix < J)) then
    while ix < 20 do begin
      if (ix < J) then
        break;

      if not ((UpCase(Format[J]) = Ch) and (J <= L)) then
        break;

      if S[J] <> s_Space then
        Tmp := Tmp + S[J];

      Inc(J);
    end;

  if Tmp = '' then
    I := Blank
  else
    if Cnt > 1 then begin
      I := MonthFromName(Tmp, Length(Tmp));
      if I = 0 then
        I := -1;
    end
    else
      I := StrToIntDef(Tmp, -1);
end;


function CurrentYear: Word;
var
  SystemTime: TSystemTime;
begin
  GetLocalTime(SystemTime);
  Result := SystemTime.wYear;
end;


function ExpandYear(Year: Integer): Integer;
var
  N: Longint;
begin
  Result := Year;
  if Result < 100 then begin
    N := CurrentYear - 60;
    Inc(Result, N div 100 * 100);
    if Result < N then
      Inc(Result, 100);
  end;
end;


procedure ScanBlanks(const S: string; var Pos: Integer);
var
  I: Integer;
begin
  I := Pos;
  while (I <= Length(S)) and (S[I] = s_Space) do
    Inc(I);

  Pos := I;
end;


function ScanChar(const S: string; var Pos: Integer; Ch: Char): Boolean;
begin
  Result := False;
  ScanBlanks(S, Pos);
  if (Pos <= Length(S)) and (S[Pos] = Ch) then begin
    Inc(Pos);
    Result := True;
  end;
end;


function ScanNumber(const S: AnsiString; MaxLength: Integer; var Pos: Integer; var Number: Longint): Boolean;
var
  I: Integer;
  N: Word;
begin
  Result := False;
  ScanBlanks(S, Pos);
  I := Pos;
  N := 0;
  while (I <= Length(S)) and (Longint(I - Pos) < MaxLength) and CharInSet(S[I], [ZeroChar..'9']) and (N < 1000) do begin
    N := N * 10 + (Ord(S[I]) - Ord(ZeroChar));
    Inc(I);
  end;
  if I > Pos then begin
    Pos := I;
    Number := N;
    Result := True;
  end;
end;


function ScanDate(const S, DateFormat: string; var Pos: Integer; var Y, M, D: Integer): Boolean;
var
  DateOrder: TDateOrder;
  N1, N2, N3: Longint;
begin
  Result := False;
  Y := 0;
  M := 0;
  D := 0;
  DateOrder := GetDateOrder(DateFormat);
  if not (ScanNumber(S, MaxInt, Pos, N1) and
       ScanChar(S, Pos, {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DateSeparator) and
         ScanNumber(S, MaxInt, Pos, N2)) then
    Exit;

  if ScanChar(S, Pos, {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DateSeparator) then begin
    if not ScanNumber(S, MaxInt, Pos, N3) then
      Exit;
      
    case DateOrder of
      doMDY: begin
        Y := N3;
        M := N1;
        D := N2;
      end;

      doDMY: begin
        Y := N3;
        M := N2;
        D := N1;
      end;

      doYMD: begin
        Y := N1;
        M := N2;
        D := N3;
      end;
    end;
    Y := ExpandYear(Y);
  end
  else begin
    Y := CurrentYear;
    if DateOrder = doDMY then begin
      D := N1;
      M := N2;
    end
    else begin
      M := N1;
      D := N2;
    end;
  end;
  ScanChar(S, Pos, {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}DateSeparator);
  ScanBlanks(S, Pos);
  Result := IsValidDate(Y, M, D) and (Pos > Length(S));
end;


function MonthFromName(const S: string; MaxLen: Byte): Byte;
begin
  if Length(S) > 0 then
    for Result := 1 to 12 do
      if (Length({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}LongMonthNames[Result]) > 0) and
           (AnsiCompareText(Copy(S, 1, MaxLen),
             Copy({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}LongMonthNames[Result], 1, MaxLen)) = 0) then
        Exit;

  Result := 0;
end;


function DropDayName(const fmtDateStr: string): string;
var
  dnPos: Integer;
begin
  Result := fmtDateStr;
  dnPos := Pos('dddd', fmtDateStr);
  if dnPos <> 0 then begin
    if dnPos = 1 then // Format starts with name of day
      Result := Copy(Result, Pos(' ', Result) + 1, 9999)
    else
      if (dnPos + 4) >= Length(Result) then begin // Dayname at the end (Hungarian / Korean / Turkish / Lithuanian / Russian / Tsana / Xhosa / Sami / Kazak / Indian style)
        Result := Copy(Result, 1, dnPos - 2);
        if Result[Length(Result)] = ',' then
          Result := Copy(Result, 1, Length(Result) - 1);
      end
      else
        // For day name in the middle (Mongolian) just use short date format
        Result := {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ShortDateFormat;
  end;
end;


function DateToLongStr(aDate: TDateTime): acString;
const
  Size = 128;
var
  s, sf: string;
  Y, D, M: Word;
  SysTime: TSystemTime;
  LngID: Cardinal;
begin
  DecodeDate(aDate, Y, M, D);
  SysTime.wYear := Y;
  SysTime.wMonth := M;
  SysTime.wDay := D;
  LngID := SysLocale.DefaultLCID; // LANG_ENGLISH or (SUBLANG_ENGLISH_US shl 10);
  SetLength(sf, Size);
  if GetLocaleInfo(LngID, LOCALE_SLONGDATE, PChar(sf), Size) = 0 then
    s := {$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ShortDateFormat
  else
    s := DropDayName(sf);

  GetDateFormat(LngID, 0, @SysTime, PChar(s), PChar(sf), Size);
  Result := sf;
end;


initialization
  NormalYears := Pos('YYYY', AnsiUpperCase({$IFDEF DELPHI_XE}FormatSettings.{$ENDIF}ShortDateFormat)) > 0;

end.

