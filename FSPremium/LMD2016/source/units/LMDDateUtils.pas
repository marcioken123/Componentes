unit LMDDateUtils;
{$I lmdcmps.inc}

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

LMDDateUtils unit (EK)
------------------
Helpers unit for DateTime-Utils

ToDo
----

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, SysUtils;

type
  TLMDJulianDate = Double;

function LMDGetTime(DateTime: TDateTime): TDateTime;
function LMDIncDate(ADate: TDateTime; Days, Months, Years: Integer): TDateTime;
function LMDIncTime(ATime: TDateTime; Hours, Minutes, Seconds, MSecs: Integer):
  TDateTime;
function LMDExtractTime(ATime: TDateTime): TDateTime;
function LMDExtractDate(ATime: TDateTime): TDateTime;

function LMDDaysPerMonth(AYear, AMonth: Integer): Integer;
function LMDDayOfWeek(ADay, AMonth, AYear: Integer): Integer;
function LMDDateToJulianDays(ADay, AMonth, AYear: Integer): integer;
procedure LMDJulianDaysToDate(var ADay, AMonth, AYear: Integer; JulianDate:
  integer);
function LMDDateTimeToSeconds(ADay, AMonth, AYear, AHours, AMinute, ASecond:
  integer): Cardinal;
procedure LMDSecondsToDateTime(Seconds: Cardinal; var ADay, AMonth, AYear,
  AHours, AMinute, ASecond: integer);

function LMDGetSysStartDayOfWeek: integer;

procedure LMDSystemTimeToTzSpecificLocalTime(
          lpTimeZoneInformation: PTimeZoneInformation;
          var lpUniversalTime: TSystemTime; var lpLocalTime: TSystemTime);
procedure LMDUTCToZoneLocal(
          lpTimeZoneInformation: PTimeZoneInformation;
          lpUniversalTime: TSystemTime; var lpLocalTime: TSystemTime);
procedure LMDZoneLocalToUTC(
          lpTimeZoneInformation: PTimeZoneInformation;
          var lpUniversalTime: TSystemTime; lpLocalTime: TSystemTime);

function LMDNowToUTC: TDateTime;
function LMDZoneIDtoBias(ZoneID: string): integer;

function LMDGetFormattedTimeString(ADate: TDateTime; const Format: string): string;

function LMDDayNumber(AYear, AMonth, ADay: integer): integer;
function LMDWeekNumber(AYear, AMonth, ADay: integer): integer;
{ --------------------------------------Date functions ----------------------}
//procedure CalcCelebrationDays(var table : TLMDDateList;Year : Word);

function LMDJulianToDate (jul : TLMDJulianDate) : TDateTime;
function LMDDateToJulian (ADate : TDateTime) : TLMDJulianDate;
function LMDYMDToJulian (y, m, d : Integer) : TLMDJulianDate;

function LMDSubtractTimes(Time1, Time2: TDateTime): TDateTime;
function LMDOffsetDateTime (DT : TDateTime;
                           byYears,
                           byMonths,
                           byDays,
                           byHours,
                           byMinutes,
                           bySeconds,
                           byMSeconds : Integer) : TDateTime;

implementation

function LMDGetTime(DateTime: TDateTime): TDateTime;
begin
  Result := DateTime - Trunc(DateTime);
  end;

function LMDIncDate(ADate: TDateTime; Days, Months, Years: Integer): TDateTime;
var
  D, M, Y: Word;
  Day, Month, Year: Longint;
begin
  DecodeDate(ADate, Y, M, D);
  Year := Y;
  Month := M;
  Day := D;
  Inc(Year, Years);
  Inc(Year, Months div 12);
  Inc(Month, Months mod 12);
  if Month < 1 then
  begin
    Inc(Month, 12);
    Dec(Year);
  end
  else
    if Month > 12 then
  begin
    Dec(Month, 12);
    Inc(Year);
  end;
  if Day > LMDDaysPerMonth(Year, Month) then Day := LMDDaysPerMonth(Year, Month);
  Result := EncodeDate(Year, Month, Day) + Days + Frac(ADate);
end;

function LMDNowToUTC: TDateTime;
var
  ST: TSystemTime;
begin
  GetSystemTime(ST);
  Result := SystemTimeToDateTime(ST);
end;

procedure LMDToAbsoluteDate(aYear: integer; var ATime: TSystemTime);
var
  DayNum: integer;
  DIM: Integer;
begin
  ATime.wYear := aYear;
  if (ATime.wDay >= 1) and (ATime.wDay <= 4) then
  begin
    // get first day in month
    DayNum := DayOfWeek(EncodeDate(aTime.wYear, aTime.wMonth, 1));
    DayNum := aTime.wDayOfWeek - DayNum + 1; // get first dayInWeek in month
    if DayNum <= 0 then
      Inc(DayNum, 7);
    DayNum := DayNum + (ATime.wDay - 1) * 7;
      // get weekInMonth-th dayInWeek in month
    ATime.wDay := DayNum;
  end
  else
    if ATime.wDay = 5 then
  begin // last week, calculate from end of month
    DIM := LMDDaysPerMonth(aTime.wYear, aTime.wMonth);
    // get last day in month
    dayNum := DayOfWeek(EncodeDate(aTime.wYear, aTime.wMonth, DIM));
    dayNum := DIM + (aTime.wDayOfWeek - dayNum);
    if dayNum > DIM then Dec(dayNum, 7); // get last dayInWeek in month
    ATime.wDay := DayNum;
  end;
end;

function LMDIsInDaylightTime(lpTimeZoneInformation: TTimeZoneInformation;
  lpLocalTime: TSystemTime): boolean;
var
  TempTime1, TempTime2, TempTime3: TDateTime;
begin
  Result := false;
  if lpTimeZoneInformation.StandardDate.wMonth <> 0 then
  begin
    if lpTimeZoneInformation.StandardDate.wYear = 0 then
      LMDToAbsoluteDate(lpLocalTime.wYear, lpTimeZoneInformation.StandardDate);
    TempTime1 := SystemTimeToDateTime(lpTimeZoneInformation.StandardDate);

    if lpTimeZoneInformation.DaylightDate.wYear = 0 then
      LMDToAbsoluteDate(lpLocalTime.wYear, lpTimeZoneInformation.DaylightDate);
    TempTime2 := SystemTimeToDateTime(lpTimeZoneInformation.DaylightDate);

    TempTime3 := SystemTimeToDateTime(lpLocalTime);

    if TempTime2 < TempTime1 {Northern semisphere} then
      Result := (TempTime3 >= TempTime2) and (TempTime3 < TempTime1)
    else
      Result := not ((TempTime3 >= TempTime1) and (TempTime3 < TempTime2));
  end;
end;

procedure LMDUTCToZoneLocal(lpTimeZoneInformation:PTimeZoneInformation;
  lpUniversalTime: TSystemTime; var lpLocalTime: TSystemTime);
var
  DTF: TDateTime;
begin

  MoveMemory(@lpLocalTime, @lpUniversalTime, sizeof(TSystemTime));

  DTF := LMDIncTime(SystemTimeToDateTime(lpLocalTime), 0,
    -lpTimeZoneInformation.Bias, 0, 0);
  DateTimeToSystemTime(DTF, lpLocalTime);

  if not LMDIsInDaylightTime(lpTimeZoneInformation^, lpLocalTime) then
    DTF := LMDIncTime(DTF, 0, -lpTimeZoneInformation.StandardBias, 0, 0)
  else
    DTF := LMDIncTime(DTF, 0, -lpTimeZoneInformation.DaylightBias, 0, 0);

  DateTimeToSystemTime(DTF, lpLocalTime);
end;

procedure LMDZoneLocalToUTC(lpTimeZoneInformation:PTimeZoneInformation;
  var lpUniversalTime: TSystemTime; lpLocalTime: TSystemTime);
var
  DTF: TDateTime;
begin

  MoveMemory(@lpUniversalTime, @lpLocalTime, sizeof(TSystemTime));

  DTF := LMDIncTime(SystemTimeToDateTime(lpUniversalTime), 0,
    lpTimeZoneInformation.Bias, 0, 0);
  if not LMDIsInDaylightTime(lpTimeZoneInformation^, lpLocalTime) then
    DTF := LMDIncTime(DTF, 0, lpTimeZoneInformation.StandardBias, 0, 0)
  else
    DTF := LMDIncTime(DTF, 0, lpTimeZoneInformation.DaylightBias, 0, 0);

  DateTimeToSystemTime(DTF, lpUniversalTime);
end;

procedure LMDSystemTimeToTzSpecificLocalTime(lpTimeZoneInformation:PTimeZoneInformation;
                                            var lpUniversalTime: TSystemTime;
                                            var lpLocalTime: TSystemTime);
begin
  LMDUTCToZoneLocal(lpTimeZoneInformation, lpUniversalTime, lpLocalTime);
end;

function LMDZoneIDtoBias(ZoneID: string): integer;
const
  IDs: array[0..17] of string = ('NST', 'AST', 'ADT', 'EST', 'EDT',
    'CST', 'CDT', 'MST', 'MDT', 'PST',
    'PDT', 'YST', 'YDT', 'HST', 'HDT',
    'BST', 'BDT', 'GMT');

  biases: array[0..17] of integer = (210, 240, 180, 300, 240, 360, 300, 420,
    360,
    480, 420, 540, 480, 600, 540, 660, 600, 0);
var
  i: integer;
  aID: char;
begin
  ZoneID := Uppercase(ZoneID);
  Result := 0;
  if Length(ZoneID) = 0 then
  begin
    Result := 0;
    exit;
  end;
  if Length(ZoneID) = 1 then
  begin
    aID := ZoneID[1];
    case aID of
      'J', 'Z': Result := 0;
      'A'..'I',
        'K'..'M': Result := -(Ord(aID) - 64);
      'N'..'Y': Result := Ord(aID) - Ord('M');
    end;
  end
  else
    if AnsiChar(ZoneID[1]) in ['0'..'9'] then
  begin
    Result := StrToIntDef(Copy(ZoneID, 1, 2), 0) + StrToIntDef(Copy(ZoneID, 3,
      2), 0);
  end
  else
    if AnsiChar(ZoneID[1]) in ['+', '-'] then
  begin
    Result := StrToIntDef(Copy(ZoneID, 2, 2), 0) + StrToIntDef(Copy(ZoneID, 4,
      2), 0);
    if ZoneID[1] = '-' then Result := -Result;
  end
  else
  begin
    Result := 0;
    for i := 0 to 17 do
      if ZoneID = IDs[i] then
      begin
        Result := Biases[i];
        exit;
      end;
  end;
end;

function LMDExtractTime(ATime: TDateTime): TDateTime;
begin
  Result := Frac(ATime);
end;

function LMDExtractDate(ATime: TDateTime): TDateTime;
begin
  Result := Trunc(ATime);
end;

function LMDIncTime(ATime: TDateTime; Hours, Minutes, Seconds, MSecs: Integer):
  TDateTime;
begin
  Result := ATime + (Hours div 24) + (((Hours mod 24) * 3600000 +
    Minutes * 60000 + Seconds * 1000 + MSecs) / MSecsPerDay);
end;

const
  aDaysCentury = 15020;

function LMDDateTimeToSeconds(ADay, AMonth, AYear, AHours, AMinute, ASecond:
  integer): Cardinal;
begin
  Result := (LMDDateToJulianDays(ADay, AMonth, AYear) - aDaysCentury) * 86400;
  inc(Result, aHours * 3600 + AMinute * 60 + aSecond);
end;

procedure LMDSecondsToDateTime(Seconds: Cardinal; var ADay, AMonth, AYear,
  AHours, AMinute, ASecond: integer);
var
  aDays: integer;
  aSecs: integer;
begin
  aDays := Seconds div 86400 + aDaysCentury;
  aSecs := Seconds mod 86400;
  LMDJulianDaysToDate(ADay, AMonth, AYear, aDays);
  AHours := aSecs div 3600;
  AMinute := (aSecs - (AHours * 3600)) div 60;
  ASecond := aSecs mod 60;
end;

function LMDDateToJulianDays(ADay, AMonth, AYear: Integer): integer;
{var
  A, B: integer;}
var
  i: double;
begin
  i := LMDYMDToJulian(AYear, AMonth, ADay);
  Result := Round(i);
{  a := 10000 * Ayear + 100 * AMonth + ADay;
  if AMonth <= 2 then
  begin
    AMonth := AMonth + 12;
    AYear := AYear - 1;
  end;
  if a <= 15821004 then
    b := -2 + trunc((AYear + 4716) / 4) - 1179
  else
    b := trunc(AYear / 400) - trunc(AYear / 100) + trunc(AYear / 4);
  a := 365 * AYear - 679004;
  Result := a + b + trunc(30.6001 * (AMonth + 1)) + ADay;}
end;

procedure LMDJulianDaysToDate(var ADay, AMonth, AYear: Integer; JulianDate:
  integer);
var
  LDateTime: TDateTime;
  LYear, LMonth, LDay: Word;
begin
  LDateTime := LMDJulianToDate(JulianDate);
  DecodeDate(LDateTime, LYear, LMonth, LDay);
  ADay := LDay;
  AMonth := LMonth;
  AYear := LYear;
{  JD := JulianDate + 2400001;
  if JD < 2299161 then
  begin
    c := JD + 1524;
  end
  else
  begin
    b := trunc((JD - 1867216.25) / 36524.25);
    c := JD + (b - trunc(b / 4)) + 1525;
  end;
  d := trunc((c - 122.1) / 365.25);
  e := 365 * d + trunc(d / 4);
  f := trunc((c - e) / 30.6001);
  ADay := trunc(c - e + 0.5) - trunc(f * 30.6001);
  AMonth := f - 1 - 12 * trunc(f / 14);
  AYear := D - 4715 - trunc((7 + AMonth) / 10);}
end;

function LMDDayOfWeek(ADay, AMonth, AYear: Integer): Integer;
begin
  if AMonth > 2 then
    inc(AMonth)
  else
  begin
    Inc(AMonth, 13);
    Dec(AYear);
  end;
  Result := trunc(365.25 * AYear) + trunc(30.6 * AMonth) + ADay - 621050;
  Result := Result - trunc(Result / 7) * 7 + 1;
  if Result = 7 then Result := 0;
  inc(Result);
end;

function LMDDaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30,
    31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then
    Inc(Result); { leap-year Feb is special }
end;

function LMDDayNumber(AYear, AMonth, ADay: integer): integer;
var
  i: integer;
begin
  Result := 0;
  for i := 1 to AMonth - 1 do
    Inc(Result, LMDDaysPerMonth(AYear, i));
  Inc(Result, ADay);
end;

function LMDWeekNumber(AYear, AMonth, ADay: integer): integer;
var
  FirstDay, FirstMonday, YearOffset: integer;
  NextFirstDay: Integer;
begin
  YearOffset := LMDDayNumber(AYear, AMonth, ADay);
  FirstDay := LMDDayOfWeek(1, 1, AYear);
  NextFirstDay := LMDDayOfWeek(1, 1, AYear + 1) - 1;
  Dec(FirstDay);
  if FirstDay = 0 then
    FirstDay := 7;
  if FirstDay = 1 then
    FirstMonday := 1
  else
    FirstMonday := 9 - FirstDay;
  if (AMonth = 1) and (ADay < FirstMonday) then
    if FirstDay <= 4 then
      Result := 1
    else
      Result := LMDWeekNumber(AYear - 1, 12, 31)
  else
    if (AMonth = 12) and (30 - (ADay - 1) < NextFirstDay) and (NextFirstDay <= 4) then
      Result := 1
    else
    begin
      Result := ((YearOffset - FirstMonday) div 7) + 1;
      if (FirstDay <= 4) and (FirstDay > 1) then Inc(Result);
    end;
end;

function LMDGetFormattedTimeString(ADate: TDateTime; const Format: string): string;

  function DefDateSeparator: string;
  var
  S: string;
  begin

    SetLength(S, 255);
    GetLocaleInfo(GetThreadLocale, LOCALE_SDATE, PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    Result := S;

  end;

  function DefTimeSeparator: string;
  var
  S: string;
  begin

    SetLength(S, 255);
    GetLocaleInfo(GetThreadLocale, LOCALE_STIME, PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    Result := S;

  end;

  function LongDateToStr(var ST: TSystemTime): string;

  var
  S: string;
  begin

    SetLength(S, 255);
    GetDateFormat(GetThreadLocale, LOCALE_NOUSEROVERRIDE or DATE_LONGDATE, @ST,
      nil, PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    Result := S;

  end;

  function LongTimeToStr(var ST: TSystemTime): string;
  var
  S: string;
    F: string;
    s1: string;
    ff: integer;

  begin

    SetLength(S, 255);
    GetLocaleInfo(GetThreadLocale, LOCALE_ITIME, PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    s1 := DefTimeSeparator;
    ff := 0;
    if StrToIntDef(S, 0) = 0 then
      F := 'hh' + s1 + 'mm' + s1 + 'ss tt'
    else
    begin
      F := 'HH' + s1 + 'mm' + s1 + 'ss';
      ff := TIME_FORCE24HOURFORMAT;
    end;
    SetLength(S, 255);
    GetTimeFormat(GetThreadLocale, ff, @ST, PChar(F), PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    Result := S;

  end;

  function GetAMPMSign(Period: integer): string;
  var
  S: string;
  begin

    SetLength(S, 255);
    if Period = 0 then
      GetLocaleInfo(GetThreadLocale, LOCALE_S1159, PChar(S), 254)
    else
      GetLocaleInfo(GetThreadLocale, LOCALE_S2359, PChar(S), 254);
    SetLength(S, StrLen(PChar(S)));
    Result := S;

  end;

var
  S1, S2, S3, S4: string;
  i: integer;
  Dt: TDateTime;
  ST: TSystemTime;
begin
  S1 := Format;
  S2 := '';
  i := 1;
  S4 := S1;
  DT := ADate;
  DateTimeToSystemTime(DT, ST);
  ST.wDayOfWeek := DayOfWeek(DT) - 1;
  while i <= Length(S1) do
  begin
    if S1[i] = '''' then
    begin
      if (i < Length(S1)) and (S1[i + 1] = '''') then
      begin
        S2 := S2 + '''';
        inc(i);
      end
      else
      begin
        inc(i);
        while (i <= Length(S1)) do
        begin
          if S1[i] = '''' then break;
          S2 := S2 + S1[i];
          inc(i);
        end;
      end;
    end
    else
      if S1[i] = '~' then
      S2 := S2 + #9
    else
      if S1[i] = ':' then
      S2 := S2 + DefTimeSeparator
    else
      if S1[i] = '.' then
      S2 := S2 + DefDateSeparator
    else
      if S1[i] = '|' then
      S2 := S2 + #13#10
    else
      if Pos('nn', S4) = 1 then
    begin
      S3 := IntToStr(LMDDayNumber(ST.wYear, ST.wMonth, ST.wDay));
      while Length(S3) < 3 do
        S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'n' then
      S2 := S2 + IntToStr(LMDDayNumber(ST.wYear, ST.wMonth, ST.wDay))
    else
      if Pos('YY', S4) = 1 then
    begin
      S3 := IntToStr(LMDWeekNumber(ST.wYear, ST.wMonth, ST.wDay));
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'Y' then
      S2 := S2 + IntToStr(LMDWeekNumber(ST.wYear, ST.wMonth, ST.wDay))
    else
      if Pos('yy', S4) = 1 then
    begin
      S2 := S2 + IntToStr(ST.wYear);
      inc(i);
    end
    else
      if S1[i] = 'y' then
      S2 := S2 + IntToStr(ST.wYear mod 100)
    else
      if Pos('mmmm', S4) = 1 then
    begin
      S2 := S2 + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongMonthNames[ST.wMonth];
      inc(i, 3);
    end
    else
      if Pos('mmm', S4) = 1 then
    begin
      S2 := S2 + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortMonthNames[ST.wMonth];
      inc(i, 2);
    end
    else
      if Pos('mm', S4) = 1 then
    begin
      S3 := IntToStr(ST.wMonth);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'm' then
      S2 := S2 + IntToStr(ST.wMonth)
    else
      if Pos('TT', S4) = 1 then
    begin
      S2 := S2 + Uppercase(GetAMPMSign(ST.wHour div 12));
      inc(i);
    end
    else
      if Pos('tt', S4) = 1 then
    begin
      S2 := S2 + Lowercase(GetAMPMSign(ST.wHour div 12));
      inc(i);
    end
    else
      if Pos('ww', S4) = 1 then
    begin
      S2 := S2 + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}LongDayNames[ST.wDayOfWeek + 1];
      inc(i);
    end
    else
      if S1[i] = 'w' then
      S2 := S2 + {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortDayNames[ST.wDayOfWeek + 1]
    else
      if S1[i] = 'W' then
      S2 := S2 + IntToStr(ST.wDayOfWeek)
    else
      if Pos('hh', S4) = 1 then
    begin
      if (ST.wHour = 0) or (ST.wHour = 12) then
        S3 := '12'
      else
        S3 := IntToStr(ST.wHour mod 12);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'h' then
    begin
      if (ST.wHour = 0) or (ST.wHour = 12) then
        S2 := S2 + '12'
      else
        S2 := S2 + IntToStr(ST.wHour mod 12);
    end
    else
      if Pos('HH', S4) = 1 then
    begin
      S3 := IntToStr(ST.wHour);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'H' then
      S2 := S2 + IntToStr(ST.wHour)
    else
      if Pos('MM', S4) = 1 then
    begin
      S3 := IntToStr(ST.wMinute);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'M' then
      S2 := S2 + IntToStr(ST.wMinute)
    else
      if Pos('SS', S4) = 1 then
    begin
      S3 := IntToStr(ST.wSecond);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'S' then
      S2 := S2 + IntToStr(ST.wSecond)
    else
      if Pos('dd', S4) = 1 then
    begin
      S3 := IntToStr(ST.wDay);
      if Length(S3) = 1 then S3 := '0' + S3;
      S2 := S2 + S3;
      inc(i);
    end
    else
      if S1[i] = 'd' then
      S2 := S2 + IntToStr(ST.wDay)
    else
      if Pos('xx', S4) = 1 then
    begin
      S2 := S2 + LongTimeToStr(ST);
      inc(i);
    end
    else
      if S1[i] = 'x' then
        S2 := S2 + FormatDateTime({$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}ShortTimeFormat, DT)
    else
      if Pos('DD', S4) = 1 then
    begin
      S2 := S2 + LongDateToStr(ST);
      inc(i);
    end
    else
      if S1[i] = 'D' then
      S2 := S2 + DateToStr(DT)
    else
    begin
      S2 := S2 + S1[i];
    end;
    inc(i);
    S4 := Copy(S1, i, Length(S1));
  end;
  Result := S2;
end;

{$WARNINGS off}

function LMDGetSysStartDayOfWeek: integer;
var
  LS: string;
begin
  LS := GetLocaleStr(LOCALE_USER_DEFAULT, LOCALE_IFIRSTDAYOFWEEK, '0');
  Result := StrToIntDef(LS, 0) + 1;
  if Result = 7 then
    Result := 0;
end;
{$WARNINGS on}
function LMDOffsetDateTime (DT : TDateTime;
                             byYears,
                             byMonths,
                             byDays,
                             byHours,
                             byMinutes,
                             bySeconds,
                             byMSeconds : Integer) : TDateTime;
var
  dateval, timeval : TDateTime;

  procedure LMDOffsetMonth;
  var
    y, m, d : Word;
  begin
    DecodeDate (dateval, y, m ,d);
    y := y + byMonths div 12;
    m := m + byMonths mod 12;
    dateval := EncodeDate (y, m, d);
  end;

  procedure LMDOffsetYear;
  var
    y, m, d : Word;
  begin
    DecodeDate (dateval, y, m, d);
    y := y + byYears;
    dateval := EncodeDate (y, m, d);
  end;

  procedure LMDOffsetDay;
  begin
    Dateval := Dateval + byDays;
  end;

  procedure LMDOffsetHour;
  var
    h, m, s, ms : Word;
  begin
    DecodeTime (dateval, h, m, s, ms);
    byDays := byDays + byHours div 24;
    h := h + byHours mod 24;
    dateval := EncodeTime (h, m, s, ms);
  end;

  procedure LMDOffsetMinute;
  var
    h, m, s, ms : Word;
  begin
    DecodeTime (timeval, h, m, s, ms);
    byHours := byHours + byMinutes div 60;
    m := m + byMinutes mod 60;
    timeval := EncodeTime (h, m, s, ms);
  end;

  procedure LMDOffsetSecond;
  var
    h, m, s, ms : Word;
  begin
    DecodeTime (timeval, h, m, s, ms);
    byMinutes := byMinutes + bySeconds div 60;
    s := s + bySeconds mod 60;
    timeval := EncodeTime (h, m, s, ms);
  end;

  procedure LMDOffsetMSecond;
  var
    h, m, s, ms : Word;
  begin
    DecodeTime (timeval, h, m, s, ms);
    bySeconds := bySeconds + byMSeconds div 100;
    ms := ms + byMSeconds mod 100;
    timeval := EncodeTime (h, m, s, ms);
  end;

begin
  dateval := Int (dt);
  timeval := Frac (dt);
  LMDOffsetMSecond;
  LMDOffsetSecond;
  LMDOffsetMinute;
  LMDOffsetHour;
  LMDOffsetDay;
  LMDOffsetMonth;
  LMDOffsetYear;
  result := dateval + timeval;
end;

function LMDYMDToJulian (y, m, d : Integer) : TLMDJulianDate;
var
  greg, A, T : Double;
  //k, l : Double;
begin
{  K := Int((M-14)/12);
  L := Y + K + 4800;
  result := D - 32075 + 1461 * Int( L / 4 ) + 367 * Int((M -2-12*K)/12)-3*Int((L+100)/400);}
  greg := 588829;
  if Y < 0 then Y := Y + 1;
  if m > 2 then M := m+1 else
  begin
    Y := Y -1;
    m := m +13;
  end;
  result := Int(1461*Y/4)+Int(153*M/5)+D+1720995;
  T := D + 31 * (M+12*Y);
  if T > greg then
  begin
    A := Int (Y/100);
    result := result + 2 - A + Int(A / 4);
  end;
end;

function LMDDateToJulian (ADate : TDateTime): TLMDJulianDate;
var
  y, m, d : Word;
begin
  DecodeDate (ADate, y, m, d);
  result := LMDYMDToJulian (y, m, d);
end;

{function LMDDateStrToJulian (date : String) : TLMDJulianDate;
begin
  result := 0;
end;}

function LMDJulianToDate(jul : TLMDJulianDate) : TDateTime;
var
  A, B, C,
  N, L, Y, M, D : Double;
begin
{  L := jul + 68569;
  N := Int((4*L) / 146097);
  L := L - Int((146097*N+3)/4);
  Y := Int(4000*(L+1)/1461001);
  L := L-1461*Int(Y/4)+31;
  M := Int(80*L / 2447);
  D := L - Int(2447*M/80);
  L := Int(M/11);
  M := M + 2 -12*L;
  Y := 100* (N- 49) + L + Y;}
  L := 2299161;
  jul := jul + 1;
  if jul < L then
    A := jul
  else
  begin
    Y := Int((jul-1867216.25)/36524.25);
    A := jul + 1 + Y - Int (Y/4);
  end;
  B := A + 1524;
  C := Int ((B-122.1)/365.25);
  N := Int(1461*C/4);
  L := Int((B-N)/30.6001);
  D := (B-N)-Int(30.6001*L)-1;
  if L < 13.5 then
    M := L-1
  else
    M := L-13;
  if M > 2.5 then
    Y := C - 4716
  else
    Y := C - 4715;
  result := EncodeDate(Trunc (Y), Trunc (M), Trunc(D));
end;

function LMDSubtractTimes(Time1, Time2: TDateTime): TDateTime;
var
  TT: TSystemTime;
  TFT1, TFT2, TFT3: TFileTime;
  h1, h2, l1, l2: DWord;
begin
  DateTimeToSystemTime(Time1, TT);
  SystemTimeToFileTime(TT, TFT1);
  DateTimeToSystemTime(Time2, TT);
  SystemTimeToFileTime(TT, TFT2);
  h1 := TFT1.dwHighDateTime;
  h2 := TFT2.dwHighDateTime;
  l1 := TFT1.dwLowDateTime;
  l2 := TFT2.dwLowDateTime;
  if (h1 < h2) or
    ((h1 = h2) and (l1 < l2)) then
    Result := 0
  else
  begin
    if l1<l2 then
      TFT3.dwLowDateTime := l1 - l2 - $FFFFFFFF
    else
      TFT3.dwHighDateTime := h1 - h2;
    FileTimeToSystemTime(TFT3, TT);
    TT.wYear := 299 + TT.wYear;
    Result := SystemTimeToDateTime(TT);
  end;
end;

end.
