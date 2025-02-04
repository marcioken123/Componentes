{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressEditors                                               }
{                                                                    }
{       Copyright (c) 1998-2007 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxDateUtils;

{$I cxVer.inc}

interface

uses
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  Windows;

type
  TDay = (dSunday, dMonday, dTuesday, dWednesday, dThursday, dFriday, dSaturday);
  TDays = set of TDay;
  TDayOfWeek = 0..6;
  TcxDateElement = (deYear, deMonth, deDay);
  TcxFirstWeekOfYear = (fwySystem, fwyJan1, fwyFirstFullWeek, fwyFirstFourDays);

const
  DATE_YEARMONTH  = $00000008;  // use year month picture
  {$EXTERNALSYM DATE_YEARMONTH}
  DATE_LTRREADING = $00000010;  // add marks for left to right reading order layout
  {$EXTERNALSYM DATE_LTRREADING}
  DATE_RTLREADING = $00000020;  // add marks for right to left reading order layout
  {$EXTERNALSYM DATE_RTLREADING}

  NullDate = -700000;
  InvalidDate = NullDate + 1;
  SmartTextToDateFunc: function(const AText: string; var ADate: TDateTime): Boolean = nil;

{$IFNDEF DELPHI7}
  ApproxDaysPerMonth: Double = 30.4375;
  ApproxDaysPerYear: Double  = 365.25;
  DaysPerWeek = 7;
  WeeksPerFortnight = 2;
  MonthsPerYear = 12;
  YearsPerDecade = 10;
  YearsPerCentury = 100;
  YearsPerMillennium = 1000;
  HoursPerDay   = 24;
  MinsPerHour   = 60;
  SecsPerMin    = 60;
  MSecsPerSec   = 1000;
  MinsPerDay    = HoursPerDay * MinsPerHour;
  SecsPerDay    = MinsPerDay * SecsPerMin;
  MSecsPerDay   = SecsPerDay * MSecsPerSec;
  DayMonday = 1;
  DayTuesday = 2;
  DayWednesday = 3;
  DayThursday = 4;
  DayFriday = 5;
  DaySaturday = 6;
  DaySunday = 7;
{$ENDIF}

var
  MinYear: Integer = 100;
  MaxYear: Integer = 9999;
  cxMaxDateTime: Double = 2958465.99999; // 12/31/9999 11:59:59.999 PM

procedure AddDateRegExprMaskSmartInput(var AMask: string; ACanEnterTime: Boolean);
procedure DecMonth(var AYear, AMonth: Word);
procedure IncMonth(var AYear, AMonth: Word); overload;
procedure ChangeMonth(var AYear, AMonth: Word; Delta: Integer);
function GetMonthNumber(const ADate: TDateTime): Integer;
function GetDateElement(ADate: TDateTime; AElement: TcxDateElement): Integer;
function IsLeapYear(AYear: Integer): Boolean;
function DaysPerMonth(AYear, AMonth: Integer): Integer;
function CheckDay(AYear, AMonth, ADay: Integer): Integer;
function TimeOf(const AValue: TDateTime): TDateTime;
function DateOf(const AValue: TDateTime): TDateTime;
function DayOfWeekOffset(const AValue: TDateTime): TDayOfWeek;

function GetStartDateOfMonth(const ADate: TDateTime): TDateTime;
function GetEndDateOfMonth(const ADate: TDateTime; AIgnoreTime: Boolean): TDateTime;
function GetStartDateOfYear(const ADate: TDateTime): TDateTime;
function GetEndDateOfYear(const ADate: TDateTime; AIgnoreTime: Boolean): TDateTime;

{!!! TODO: adapt to .net}
function cxGetDateFormat(ADate: TDateTime; out AFormatDate: string; AFlags: Integer; AFormat: string = ''): Boolean;
function DateToLongDateStr(ADate: TDateTime): string;
function GetWeekNumber(ADate: TDateTime; AStartOfWeek: TDay;
  AFirstWeekOfYear: TcxFirstWeekOfYear): Integer;

{$IFNDEF DELPHI6}
function HourOf(ADateTime: TDateTime): Word;
function IsPM(const AValue: TDateTime): Boolean;
function EncodeDateWeek(const AYear, AWeekOfYear: Word;
  const ADayOfWeek: Word): TDateTime;
procedure DecodeDateWeek(const AValue: TDateTime; out AYear, AWeekOfYear,
  ADayOfWeek: Word);
function DaysInAMonth(const AYear, AMonth: Word): Word;
function DaysInMonth(const AValue: TDateTime): Word;
function DayOf(const AValue: TDateTime): Word;
function DayOfTheMonth(const AValue: TDateTime): Word;
function DayOfTheWeek(const AValue: TDateTime): Word;
procedure DecodeDateTime(const AValue: TDateTime; out AYear, AMonth, ADay,
  AHour, AMinute, ASecond, AMilliSecond: Word);
function EncodeDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
  AMilliSecond: Word): TDateTime;
procedure IncAMonth(var Year, Month, Day: Word; NumberOfMonths: Integer = 1);
function MinuteOf(const AValue: TDateTime): Word;
function MonthOf(const AValue: TDateTime): Word;
function StartOfTheYear(const AValue: TDateTime): TDateTime;
function StartOfTheMonth(const AValue: TDateTime): TDateTime;
function YearOf(const AValue: TDateTime): Word;
function YearsBetween(const ANow, AThen: TDateTime): Integer;
function MonthsBetween(const ANow, AThen: TDateTime): Integer;
function WeeksBetween(const ANow, AThen: TDateTime): Integer;
function DaysBetween(const ANow, AThen: TDateTime): Integer;
function IncYear(const AValue: TDateTime;
  const ANumberOfYears: Integer = 1): TDateTime;
function IncMonth(const DateTime: TDateTime; NumberOfMonths: Integer): TDateTime; overload;
function IncWeek(const AValue: TDateTime;
  const ANumberOfWeeks: Integer = 1): TDateTime;
function IncDay(const AValue: TDateTime;
  const ANumberOfDays: Integer = 1): TDateTime;
function IncHour(const AValue: TDateTime; const ANumberOfHours: Int64 = 1): TDateTime;
function IncMinute(const AValue: TDateTime; const ANumberOfMinutes: Int64 = 1): TDateTime;
function WeekOfTheMonth(const AValue: TDateTime): Word;
function WeekOf(AValue: TDateTime): Word;
function WeekOfTheYear(const AValue: TDateTime): Word;
function DayOfTheYear(AValue: TDateTime): Word;
function EndOfTheYear(AValue: TDateTime): TDateTime;
{$ENDIF}

function StrToDateDef(const ADateStr: string; ADefDate: TDateTime): TDateTime;
function SmartTextToDate(const AText: string; var ADate: TDateTime): Boolean;
function TextToDateEx(AText: string; var ADate: TDateTime): Boolean;
function DateTimeToText(ADate: TDateTime; AFourDigitYearNeeded: Boolean = False): string;
function DateTimeToTextEx(const ADate: TDateTime; AIsMasked: Boolean;
  AIsDateTimeEdit: Boolean = False; AFourDigitYearNeeded: Boolean = False): string;
function cxMinDateTime: Double;
function cxStrToDateTime(S: string; AUseOleDateFormat: Boolean;
  out ADate: TDateTime): Boolean;
function VarIsNullDate(const AValue: Variant): Boolean;

implementation

uses
{$IFDEF DELPHI6}
  DateUtils,
{$ENDIF}
  SysUtils, Classes, cxClasses, cxEditConsts, cxFormats, cxVariants;

type
  TcxDateEditSmartInput = (deiToday, deiYesterday, deiTomorrow,
    deiSunday, deiMonday, deiTuesday, deiWednesday, deiThursday, deiFriday, deiSaturday,
    deiFirst, deiSecond, deiThird, deiFourth, deiFifth, deiSixth, deiSeventh,
    deiBOM, deiEOM, deiNow);

var
  scxDateEditSmartInput: array [TcxDateEditSmartInput] of string;

function cxGetLocaleChar(ALocaleType: Integer; const ADefaultValue: Char): string;
begin
  Result := GetLocaleChar(GetThreadLocale, ALocaleType, ADefaultValue);
end;

function cxGetLocaleStr(ALocaleType: Integer; const ADefaultValue: string = ''): string;
begin
  Result := GetLocaleStr(GetThreadLocale, ALocaleType, ADefaultValue);
end;

procedure CorrectTextForDateTimeConversion(var AText: string;
  AOleConversion: Boolean);

  procedure InternalStringReplace(var S: WideString; ASubStr: WideString);
  begin
    S := StringReplace(S, ASubStr, GetCharString(' ', Length(ASubStr)),
      [rfIgnoreCase, rfReplaceAll]);
  end;

  procedure GetSpecialStrings(AList: TStringList);
  var
    I: Integer;
  begin
    if AOleConversion then
    begin
      AList.Add(cxGetLocaleStr(LOCALE_SDATE)[1]);
      AList.Add(cxGetLocaleStr(LOCALE_STIME)[1]);
      AList.Add(cxGetLocaleStr(LOCALE_S1159, 'am'));
      AList.Add(cxGetLocaleStr(LOCALE_S2359, 'pm'));
    end
    else
    begin
      AList.Add(DateSeparator);
      AList.Add(TimeSeparator);
      AList.Add(TimeAMString);
      AList.Add(TimePMString);
    end;
    for I := 0 to AList.Count - 1 do
      AList[I] := AnsiUpperCase(Trim(AList[I]));
  end;

  procedure RemoveStringsThatInFormatInfo(var S: WideString;
    const ADateTimeFormatInfo: TcxDateTimeFormatInfo);
  var
    ASpecialStrings: TStringList;
    ASubStr: string;
    I: Integer;
  begin
    ASpecialStrings := TStringList.Create;
    try
      GetSpecialStrings(ASpecialStrings);
      for I := 0 to High(ADateTimeFormatInfo.Items) do
        if ADateTimeFormatInfo.Items[I].Kind = dtikString then
        begin
          ASubStr := AnsiUpperCase(Trim(ADateTimeFormatInfo.Items[I].Data));
          if (ASubStr <> '') and (ASpecialStrings.IndexOf(ASubStr) = -1) then
            InternalStringReplace(S, ASubStr);
        end;
    finally
      ASpecialStrings.Free;
    end;
  end;

  procedure RemoveUnnecessarySpaces(var S: WideString);
  var
    I: Integer;
  begin
    S := Trim(S);
    I := 2;
    while I < Length(S) - 1 do
      if (S[I] <= ' ') and (S[I + 1] <= ' ') then
        Delete(S, I, 1)
      else
        Inc(I);
  end;

var
  S: WideString;
begin
  S := AText;
  RemoveStringsThatInFormatInfo(S, cxFormatController.DateFormatInfo);
  RemoveStringsThatInFormatInfo(S, cxFormatController.TimeFormatInfo);
  RemoveUnnecessarySpaces(S);
  if AOleConversion then
    InternalStringReplace(S, cxGetLocaleStr(LOCALE_SDATE)[1]);
  AText := S;
end;

procedure InitSmartInputConsts;
begin
  scxDateEditSmartInput[deiToday] := cxGetResourceString(@cxSDateToday);
  scxDateEditSmartInput[deiYesterday] := cxGetResourceString(@cxSDateYesterday);
  scxDateEditSmartInput[deiTomorrow] := cxGetResourceString(@cxSDateTomorrow);
  scxDateEditSmartInput[deiSunday] := cxGetResourceString(@cxSDateSunday);
  scxDateEditSmartInput[deiMonday] := cxGetResourceString(@cxSDateMonday);
  scxDateEditSmartInput[deiTuesday] := cxGetResourceString(@cxSDateTuesday);
  scxDateEditSmartInput[deiWednesday] := cxGetResourceString(@cxSDateWednesday);
  scxDateEditSmartInput[deiThursday] := cxGetResourceString(@cxSDateThursday);
  scxDateEditSmartInput[deiFriday] := cxGetResourceString(@cxSDateFriday);
  scxDateEditSmartInput[deiSaturday] := cxGetResourceString(@cxSDateSaturday);
  scxDateEditSmartInput[deiFirst] := cxGetResourceString(@cxSDateFirst);
  scxDateEditSmartInput[deiSecond] := cxGetResourceString(@cxSDateSecond);
  scxDateEditSmartInput[deiThird] := cxGetResourceString(@cxSDateThird);
  scxDateEditSmartInput[deiFourth] := cxGetResourceString(@cxSDateFourth);
  scxDateEditSmartInput[deiFifth] := cxGetResourceString(@cxSDateFifth);
  scxDateEditSmartInput[deiSixth] := cxGetResourceString(@cxSDateSixth);
  scxDateEditSmartInput[deiSeventh] := cxGetResourceString(@cxSDateSeventh);
  scxDateEditSmartInput[deiBOM] := cxGetResourceString(@cxSDateBOM);
  scxDateEditSmartInput[deiEOM] := cxGetResourceString(@cxSDateEOM);
  scxDateEditSmartInput[deiNow] := cxGetResourceString(@cxSDateNow);
end;

procedure AddDateRegExprMaskSmartInput(var AMask: string; ACanEnterTime: Boolean);

  procedure AddString(var AMask: string; const S: string);
  var
    I: Integer;
  begin
    I := 1;
    while I <= Length(S) do
      if S[I] = '''' then
      begin
        AMask := AMask + '\''';
        Inc(I);
      end
      else
      begin
        AMask := AMask + '''';
        repeat
          AMask := AMask + S[I];
          Inc(I);
        until (I > Length(S)) or (S[I] = '''');
        AMask := AMask + '''';
      end;
  end;

var
  I: TcxDateEditSmartInput;
begin
  InitSmartInputConsts;
  AMask := '(' + AMask + ')|(';
  I := Low(TcxDateEditSmartInput);
  if not ACanEnterTime and (I = deiNow) then
    Inc(I);
  AddString(AMask, scxDateEditSmartInput[I]);
  while I < High(TcxDateEditSmartInput) do
  begin
    Inc(I);
    if not(not ACanEnterTime and (I = deiNow)) then
    begin
      AMask := AMask + '|';
      AddString(AMask, scxDateEditSmartInput[I]);
    end;
  end;
  AMask := AMask + ')((\+|-)\d(\d(\d\d?)?)?)?';
end;

procedure DecMonth(var AYear, AMonth: Word);
begin
  if AMonth = 1 then
  begin
    Dec(AYear);
    AMonth := 12;
  end
  else Dec(AMonth);
end;

procedure IncMonth(var AYear, AMonth: Word);
begin
  if AMonth = 12 then
  begin
    Inc(AYear);
    AMonth := 1;
  end
  else Inc(AMonth);
end;

procedure ChangeMonth(var AYear, AMonth: Word; Delta: Integer);
var
  Month: Integer;
begin
  Inc(AYear, Delta div 12);
  Month := AMonth;
  Inc(Month, Delta mod 12);
  if Month < 1 then
  begin
    Dec(AYear);
    Month := 12 + Month;
  end;
  if Month > 12 then
  begin
    Inc(AYear);
    Month := Month - 12;
  end;
  AMonth := Month;
end;

function GetMonthNumber(const ADate: TDateTime): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(ADate, AYear, AMonth, ADay);
  Result := (AYear - 1) * 12 + AMonth;
end;

function GetDateElement(ADate: TDateTime; AElement: TcxDateElement): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(ADate, AYear, AMonth, ADay);
  case AElement of
    deYear: Result := AYear;
    deMonth: Result := AMonth;
  else
    {deDay:} Result := ADay; // make compiler happy
  end;
end;

function IsLeapYear(AYear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

function DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  ADaysInMonth: array[1..12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := ADaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then Inc(Result);
end;

function CheckDay(AYear, AMonth, ADay: Integer): Integer;
begin
  if ADay < 1 then
    Result := 1
  else
    if ADay > DaysPerMonth(AYear, AMonth) then
      Result := DaysPerMonth(AYear, AMonth)
    else
      Result := ADay;
end;

function TimeOf(const AValue: TDateTime): TDateTime;
//to avoid problem
//var
//  Hour, Min, Sec, MSec: Word;
begin
//  DecodeTime(ADateTime, Hour, Min, Sec, MSec);
//  Result := EncodeTime(Hour, Min, Sec, MSec);
  Result := Frac(AValue);
end;

function DateOf(const AValue: TDateTime): TDateTime;
begin
//to avoid problem
//  Result := Trunc(ADateTime + (2 * Byte(ADateTime >= 0) - 1) * 1E-11);
  Result := Trunc(AValue);
end;

function DayOfWeekOffset(const AValue: TDateTime): TDayOfWeek;
var
  AOffset: Integer;
begin
  AOffset := DayOfWeek(AValue) - 1 - cxFormatController.StartOfWeek;
  if AOffset < 0 then
    Inc(AOffset, 7);
  Result := AOffset;
end;

function GetStartDateOfMonth(const ADate: TDateTime): TDateTime;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(ADate, AYear, AMonth, ADay);
  Result := EncodeDate(AYear, AMonth, 1);
end;

function GetEndDateOfMonth(const ADate: TDateTime; AIgnoreTime: Boolean): TDateTime;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(ADate, AYear, AMonth, ADay);
  Result := EncodeDate(AYear, AMonth, MonthDays[IsLeapYear(AYear), AMonth]);
  if not AIgnoreTime then
    Result := Result + EncodeTime(23, 59, 59, 999);
end;

function GetStartDateOfYear(const ADate: TDateTime): TDateTime;
begin
  Result := EncodeDate(GetDateElement(ADate, deYear), 1, 1);
end;

function GetEndDateOfYear(const ADate: TDateTime; AIgnoreTime: Boolean): TDateTime;
begin
  Result := EncodeDate(GetDateElement(ADate, deYear), 12, 31);
  if not AIgnoreTime then
    Result := Result + EncodeTime(23, 59, 59, 999);
end;

{!!! TODO: adapt to .net}
function cxGetDateFormat(ADate: TDateTime; out AFormatDate: string; AFlags: Integer; AFormat: string = ''): Boolean;
var
  L: Integer;
  P: PChar;
  ASystemDate: TSystemTime;
  Buffer: array[0..255] of Char;
begin
  DateTimeToSystemTime(ADate, ASystemDate);
  if Length(AFormat) = 0 then P := nil else P := PChar(AFormat);
  L := GetDateFormat(GetThreadLocale, AFlags, @ASystemDate, P, Buffer, SizeOf(Buffer));
  Result := L > 0;
  if Result then SetString(AFormatDate, Buffer, L - 1) else AFormatDate := '';
end;

function DateToLongDateStr(ADate: TDateTime): string;
begin
  if not cxGetDateFormat(ADate, Result, DATE_LONGDATE) then
    Result := FormatDateTime('dddddd', Date);
end;

function GetWeekNumber(ADate: TDateTime; AStartOfWeek: TDay;
  AFirstWeekOfYear: TcxFirstWeekOfYear): Integer;

  function FindFirstDayOfWeekDate(ADate: TDateTime): TDateTime;
  var
    ADayOfWeek: TDay;
    ADelta: Integer;
  begin
    ADayOfWeek := TDay(DayOfWeek(ADate) - 1);
    ADelta := Ord(ADayOfWeek) - Ord(AStartOfWeek);
    if ADelta < 0 then Inc(ADelta, 7);
    Result := Trunc(ADate) - ADelta;
  end;

var
  AYear, AMonth, ADay: Word;
  AStartWeekDate: TDateTime;
  AStart: TDateTime;
begin
  if AFirstWeekOfYear = fwySystem then
    AFirstWeekOfYear := TcxFirstWeekOfYear(
      StrToInt(cxGetLocaleChar(LOCALE_IFIRSTWEEKOFYEAR, '0')) + 1);
  AStart := FindFirstDayOfWeekDate(StartOfTheYear(ADate));
  DecodeDate(ADate, AYear, AMonth, ADay);
  case AFirstWeekOfYear of
    fwyFirstFourDays:
      if YearOf(AStart + 3) < AYear then AStart := AStart + 7;
    fwyFirstFullWeek:
      if YearOf(AStart) < AYear then AStart := AStart + 7;
  end;
  //DELPHI8! check Trunc()
  Result := Trunc(Trunc(ADate) - AStart) div 7 + 1;
  if AMonth = 12 then
  begin
    AStartWeekDate := FindFirstDayOfWeekDate(ADate);
    case AFirstWeekOfYear of
      fwyJan1:
        if MonthOf(AStartWeekDate + 6) = 1 then
          Result := 1;
      fwyFirstFourDays:
        if MonthOf(AStartWeekDate + 3) = 1 then
          Result := 1;
    end;
  end;
end;

{$IFNDEF DELPHI6}
function HourOf(ADateTime: TDateTime): Word;
var
  AMin, ASec, AMilliSec: Word;
begin
  DecodeTime(ADateTime, Result, AMin, ASec, AMilliSec);
end;

function IsPM(const AValue: TDateTime): Boolean;
begin
  Result := HourOf(AValue) >= 12;
end;

function DaysInAMonth(const AYear, AMonth: Word): Word;
begin
  Result := MonthDays[(AMonth = 2) and IsLeapYear(AYear), AMonth];
end;

function DaysInMonth(const AValue: TDateTime): Word;
begin
  Result := DaysInAMonth(YearOf(AValue), MonthOf(AValue));
end;

function DayOf(const AValue: TDateTime): Word;
var
  AYear, AMonth: Word;
begin
  DecodeDate(AValue, AYear, AMonth, Result);
end;

function DayOfTheMonth(const AValue: TDateTime): Word;
begin
  Result := DayOf(AValue);
end;

function DayOfTheWeek(const AValue: TDateTime): Word;
begin
  Result := (DateTimeToTimeStamp(AValue).Date - 1) mod 7 + 1;
end;

procedure DecodeDateTime(const AValue: TDateTime; out AYear, AMonth, ADay,
  AHour, AMinute, ASecond, AMilliSecond: Word);
begin
  DecodeDate(AValue, AYear, AMonth, ADay);
  DecodeTime(AValue, AHour, AMinute, ASecond, AMilliSecond);
end;

function EncodeDateTime(const AYear, AMonth, ADay, AHour, AMinute, ASecond,
  AMilliSecond: Word): TDateTime;
begin
  Result := EncodeDate(AYear, AMonth, ADay) +
    EncodeTime(AHour, AMinute, ASecond, AMilliSecond);
end;

procedure IncAMonth(var Year, Month, Day: Word; NumberOfMonths: Integer = 1);
var
  DayTable: PDayTable;
  Sign: Integer;
begin
  if NumberOfMonths >= 0 then Sign := 1 else Sign := -1;
  Year := Year + (NumberOfMonths div 12);
  NumberOfMonths := NumberOfMonths mod 12;
  Inc(Month, NumberOfMonths);
  if Word(Month-1) > 11 then    // if Month <= 0, word(Month-1) > 11)
  begin
    Inc(Year, Sign);
    Inc(Month, -12 * Sign);
  end;
  DayTable := @MonthDays[IsLeapYear(Year)];
  if Day > DayTable^[Month] then Day := DayTable^[Month];
end;

function MinuteOf(const AValue: TDateTime): Word;
var
  AHour, ASecond, AMilliSecond: Word;
begin
  DecodeTime(AValue, AHour, Result, ASecond, AMilliSecond);
end;

function MonthOf(const AValue: TDateTime): Word;
var
  AYear, ADay: Word;
begin
  DecodeDate(AValue, AYear, Result, ADay);
end;

function StartOfTheYear(const AValue: TDateTime): TDateTime;
begin
  Result := EncodeDate(YearOf(AValue), 1, 1);
end;

function StartOfTheMonth(const AValue: TDateTime): TDateTime;
begin
  Result := EncodeDate(YearOf(AValue), MonthOf(AValue), 1);
end;

function YearOf(const AValue: TDateTime): Word;
var
  AMonth, ADay: Word;
begin
  DecodeDate(AValue, Result, AMonth, ADay);
end;

const
  DayMap: array [1..7] of Word = (7, 1, 2, 3, 4, 5, 6);

procedure DivMod(Dividend: Integer; Divisor: Word;
  var Result, Remainder: Word);
asm
        PUSH    EBX
        MOV     EBX,EDX
        MOV     EDX,EAX
        SHR     EDX,16
        DIV     BX
        MOV     EBX,Remainder
        MOV     [ECX],AX
        MOV     [EBX],DX
        POP     EBX
end;

function DecodeDateFully(const DateTime: TDateTime; var Year, Month, Day, DOW: Word): Boolean;
const
  D1 = 365;
  D4 = D1 * 4 + 1;
  D100 = D4 * 25 - 1;
  D400 = D100 * 4 + 1;
var
  Y, M, D, I: Word;
  T: Integer;
  DayTable: PDayTable;
begin
  T := DateTimeToTimeStamp(DateTime).Date;
  if T <= 0 then
  begin
    Year := 0;
    Month := 0;
    Day := 0;
    DOW := 0;
    Result := False;
  end else
  begin
    DOW := T mod 7 + 1;
    Dec(T);
    Y := 1;
    while T >= D400 do
    begin
      Dec(T, D400);
      Inc(Y, 400);
    end;
    DivMod(T, D100, I, D);
    if I = 4 then
    begin
      Dec(I);
      Inc(D, D100);
    end;
    Inc(Y, I * 100);
    DivMod(D, D4, I, D);
    Inc(Y, I * 4);
    DivMod(D, D1, I, D);
    if I = 4 then
    begin
      Dec(I);
      Inc(D, D1);
    end;
    Inc(Y, I);
    Result := IsLeapYear(Y);
    DayTable := @MonthDays[Result];
    M := 1;
    while True do
    begin
      I := DayTable^[M];
      if D < I then Break;
      Dec(D, I);
      Inc(M);
    end;
    Year := Y;
    Month := M;
    Day := D + 1;
  end;
end;

procedure DecodeDateWeek(const AValue: TDateTime; out AYear, AWeekOfYear,
  ADayOfWeek: Word);
var
  ADayOfYear: Integer;
  AMonth, ADay: Word;
  AStart: TDateTime;
  AStartDayOfWeek, AEndDayOfWeek: Word;
  ALeap: Boolean;
begin
  ALeap := DecodeDateFully(AValue, AYear, AMonth, ADay, ADayOfWeek);
  ADayOfWeek := DayMap[ADayOfWeek];
  AStart := EncodeDate(AYear, 1, 1);
  ADayOfYear := Trunc(AValue - AStart + 1);
  AStartDayOfWeek := DayOfTheWeek(AStart);
  if AStartDayOfWeek in [DayFriday, DaySaturday, DaySunday] then
    Dec(ADayOfYear, 8 - AStartDayOfWeek)
  else
    Inc(ADayOfYear, AStartDayOfWeek - 1);
  if ADayOfYear <= 0 then
    DecodeDateWeek(AStart - 1, AYear, AWeekOfYear, ADay)
  else
  begin
    AWeekOfYear := ADayOfYear div 7;
    if ADayOfYear mod 7 <> 0 then
      Inc(AWeekOfYear);
    if AWeekOfYear > 52 then
    begin
      AEndDayOfWeek := AStartDayOfWeek;
      if ALeap then
      begin
        if AEndDayOfWeek = DaySunday then
          AEndDayOfWeek := DayMonday
        else
          Inc(AEndDayOfWeek);
      end;
      if AEndDayOfWeek in [DayMonday, DayTuesday, DayWednesday] then
      begin
        Inc(AYear);
        AWeekOfYear := 1;
      end;
    end;
  end;
end;

function EncodeDateWeek(const AYear, AWeekOfYear: Word;
  const ADayOfWeek: Word): TDateTime; 
var
  ADayOfYear: Integer;
  AStartDayOfWeek: Word;
begin
  Result := EncodeDate(AYear, 1, 1);
  AStartDayOfWeek := DayOfTheWeek(Result);
  ADayOfYear := (AWeekOfYear - 1) * 7 + ADayOfWeek - 1;
  if AStartDayOfWeek in [DayFriday, DaySaturday, DaySunday] then
    Inc(ADayOfYear, 8 - AStartDayOfWeek)
  else
    Dec(ADayOfYear, AStartDayOfWeek - 1);
  Result := Result + ADayOfYear;
end;

function SpanOfNowAndThen(const ANow, AThen: TDateTime): TDateTime;
begin
  if ANow < AThen then
    Result := AThen - ANow
  else
    Result := ANow - AThen;
end;

function DaySpan(const ANow, AThen: TDateTime): Double;
begin
  Result := SpanOfNowAndThen(ANow, AThen);
end;

function YearSpan(const ANow, AThen: TDateTime): Double;
begin
  Result := DaySpan(ANow, AThen) / ApproxDaysPerYear;
end;

function MonthSpan(const ANow, AThen: TDateTime): Double;
begin
  Result := DaySpan(ANow, AThen) / ApproxDaysPerMonth;
end;

function WeekSpan(const ANow, AThen: TDateTime): Double;
begin
  Result := DaySpan(ANow, AThen) / DaysPerWeek;
end;

function YearsBetween(const ANow, AThen: TDateTime): Integer;
begin
  Result := Trunc(YearSpan(ANow, AThen));
end;

function MonthsBetween(const ANow, AThen: TDateTime): Integer;
begin
  Result := Trunc(MonthSpan(ANow, AThen));
end;

function WeeksBetween(const ANow, AThen: TDateTime): Integer;
begin
  Result := Trunc(WeekSpan(ANow, AThen));
end;

function DaysBetween(const ANow, AThen: TDateTime): Integer;
begin
  Result := Trunc(DaySpan(ANow, AThen));
end;

function IncMonth(const DateTime: TDateTime; NumberOfMonths: Integer): TDateTime;
var
  Year, Month, Day: Word;
begin
  DecodeDate(DateTime, Year, Month, Day);
  IncAMonth(Year, Month, Day, NumberOfMonths);
  Result := EncodeDate(Year, Month, Day);
  ReplaceTime(Result, DateTime);
end;

function IncYear(const AValue: TDateTime;
  const ANumberOfYears: Integer): TDateTime;
begin
  Result := IncMonth(AValue, ANumberOfYears * MonthsPerYear);
end;

function IncWeek(const AValue: TDateTime;
  const ANumberOfWeeks: Integer): TDateTime;
begin
  Result := AValue + ANumberOfWeeks * DaysPerWeek;
end;

function IncDay(const AValue: TDateTime;
  const ANumberOfDays: Integer): TDateTime;
begin
  Result := AValue + ANumberOfDays;
end;

function IncHour(const AValue: TDateTime; const ANumberOfHours: Int64): TDateTime;
begin
  Result := ((AValue * HoursPerDay) + ANumberOfHours) / HoursPerDay;
end;

function IncMinute(const AValue: TDateTime; const ANumberOfMinutes: Int64): TDateTime;
begin
  Result := ((AValue * MinsPerDay) + ANumberOfMinutes) / MinsPerDay;
end;

procedure DecodeDateMonthWeek(const AValue: TDateTime;
  out AYear, AMonth, AWeekOfMonth, ADayOfWeek: Word);
var
  LDay, LDaysInMonth: Word;
  LDayOfMonth: Integer;
  LStart: TDateTime;
  LStartDayOfWeek, LEndOfMonthDayOfWeek: Word;
begin
  DecodeDateFully(AValue, AYear, AMonth, LDay, ADayOfWeek);
  ADayOfWeek := DayMap[ADayOfWeek]; 
  LStart := EncodeDate(AYear, AMonth, 1);
  LStartDayOfWeek := DayOfTheWeek(LStart);
  LDayOfMonth := LDay;
  if LStartDayOfWeek in [DayFriday, DaySaturday, DaySunday] then
    Dec(LDayOfMonth, 8 - LStartDayOfWeek)
  else
    Inc(LDayOfMonth, LStartDayOfWeek - 1);
  if LDayOfMonth <= 0 then
    DecodeDateMonthWeek(LStart - 1, AYear, AMonth, AWeekOfMonth, LDay)
  else
  begin
    AWeekOfMonth := LDayOfMonth div 7;
    if LDayOfMonth mod 7 <> 0 then
      Inc(AWeekOfMonth);
    LDaysInMonth := DaysInAMonth(AYear, AMonth);
    LEndOfMonthDayOfWeek := DayOfTheWeek(EncodeDate(AYear, AMonth, LDaysInMonth));
    if (LEndOfMonthDayOfWeek in [DayMonday, DayTuesday, DayWednesday]) and
       (LDaysInMonth - LDay < LEndOfMonthDayOfWeek) then
    begin
      Inc(AMonth);
      if AMonth = 13 then
      begin
        AMonth := 1;
        Inc(AYear);
      end;
      AWeekOfMonth := 1;
    end;
  end;
end;

function WeekOfTheMonth(const AValue: TDateTime): Word;
var
  LYear, LMonth, LDayOfWeek: Word;
begin
  DecodeDateMonthWeek(AValue, LYear, LMonth, Result, LDayOfWeek);
end;

function WeekOf(AValue: TDateTime): Word;
var
  AYear, ADay: Word;
begin
  DecodeDateWeek(AValue, AYear, Result, ADay);
end;

function WeekOfTheYear(const AValue: TDateTime): Word;
var
  AYear, ADayOfWeek: Word;
begin
  DecodeDateWeek(AValue, AYear, Result, ADayOfWeek);
end;

function DayOfTheYear(AValue: TDateTime): Word;
begin
  Result := Trunc(AValue - StartOfTheYear(AValue)) + 1;
end;

function EndOfTheYear(AValue: TDateTime): TDateTime;
begin
  Result := EncodeDateTime(YearOf(AValue), 12, 31, 23, 59, 59, 999)
end;

{$ENDIF}


function StrToDateDef(const ADateStr: string; ADefDate: TDateTime): TDateTime;
begin
  try
    Result := StrToDate(ADateStr)
  except
    Result := ADefDate
  end;
end;

function SICompare(List: TStringList; Index1, Index2: Integer): Integer;
var
  S1, S2: string;
begin
  S1 := List[Index1];
  S2 := List[Index2];
  if Length(S1) > Length(S2) then
    Result := -1
  else
    if Length(S1) < Length(S2) then
      Result := 1
    else
      Result := -AnsiCompareText(S1, S2);
end;

{$IFNDEF DELPHI5}
type
  TStringListSortCompare = function(List: TStringList; Index1, Index2: Integer): Integer;

  TSIStringList = class(TStringList)
  protected
    procedure QuickSortEx(L, R: Integer; SCompare: TStringListSortCompare);
  public
    procedure CustomSort(Compare: TStringListSortCompare);
  end;

procedure TSIStringList.QuickSortEx(L, R: Integer; SCompare: TStringListSortCompare);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while SCompare(Self, I, P) < 0 do Inc(I);
      while SCompare(Self, J, P) > 0 do Dec(J);
      if I <= J then
      begin
        Exchange(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSortEx(L, J, SCompare);
    L := I;
  until I >= R;
end;

procedure TSIStringList.CustomSort(Compare: TStringListSortCompare);
begin
  if not Sorted and (Count > 1) then
  begin
    Changing;
    QuickSortEx(0, Count - 1, Compare);
    Changed;
  end;
end;
{$ENDIF}

function SmartTextToDate(const AText: string; var ADate: TDateTime): Boolean;

  function GetSmartInputKind(const AText: string;
    var Kind: TcxDateEditSmartInput): Boolean;
  var
    I: TcxDateEditSmartInput;
    J: Integer;
    S: string;
  begin
    Result := False;
  {$IFNDEF DELPHI5}
    with TSIStringList.Create do
  {$ELSE}
    with TStringList.Create do
  {$ENDIF}
    try
      for I := Low(TcxDateEditSmartInput) to High(TcxDateEditSmartInput) do
        AddObject(scxDateEditSmartInput[I], TObject(I));
      CustomSort(SICompare);
      for J := 0 to Count - 1 do
      begin
        S := Strings[J];
        if AnsiCompareText(S, Copy(AText, 1, Length(S))) = 0 then
        begin
          Kind := TcxDateEditSmartInput(Objects[J]);
          Result := True;
          Break;
        end;
      end;
    finally
      Free;
    end;
  end;

var
  I: TcxDateEditSmartInput;
  L, Delta: Integer;
  S: string;
  Y, M, D: Word;
  
begin
  InitSmartInputConsts;
  Result := False;
  S := Trim(AText);
  if GetSmartInputKind(S, I) then
  begin
    case I of
      deiToday:
        ADate := Date;
      deiYesterday:
        ADate := Date - 1;
      deiTomorrow:
        ADate := Date + 1;
      deiSunday, deiMonday, deiTuesday, deiWednesday, deiThursday, deiFriday, deiSaturday:
        begin
          ADate := Date;
          Delta := Integer(I) - Integer(deiSunday) + 1 - DayOfWeek(ADate);
          if Delta >= 0 then
            ADate := ADate + Delta
          else
            ADate := ADate + 7 + Delta;
        end;
      deiFirst..deiSeventh:
        begin
          ADate := Date;
          Delta := DayOfWeekOffset(ADate) - (Integer(I) - Integer(deiFirst));
          ADate := ADate - Delta;
        end;
      deiBOM:
        begin
          DecodeDate(Date, Y, M, D);
          ADate := EncodeDate(Y, M, 1);
        end;
      deiEOM:
        begin
          DecodeDate(Date, Y, M, D);
          ADate := EncodeDate(Y, M, MonthDays[IsLeapYear(Y), M]);
        end;
      deiNow:
        ADate := Now;
    end;
    L := Length(scxDateEditSmartInput[I]);
    S := Trim(Copy(AText, L + 1, Length(AText)));
    if (Length(S) >= 2) and ((S[1] = '+') or (S[1] = '-')) then
    begin
      if S[1] = '+' then L := 1
      else L := -1;
      S := Trim(Copy(S, 2, Length(S)));
      try
        ADate := ADate + L * StrToInt(S);
      except
        on EConvertError do;
      end;
    end;
    Result := True;
  end;
  if not Result and Assigned(SmartTextToDateFunc) then
    Result := SmartTextToDateFunc(AText, ADate);
end;

function TextToDateEx(AText: string; var ADate: TDateTime): Boolean;
var
  ADay, AMonth, AYear: Word;
begin
  try
    AText := Trim(AText);
    if AText = '' then
      Result := False
    else
    begin
      // Smart Date
      if not SmartTextToDate(AText, ADate) then
      begin
        CorrectTextForDateTimeConversion(AText,
          not cxFormatController.UseDelphiDateTimeFormats);
        if cxFormatController.UseDelphiDateTimeFormats then
          ADate := StrToDateTime(AText)
        else
          ADate := VarToDateTime(AText);
      end;
      Result := (ADate < MaxInt) and (ADate > -MaxInt - 1);
      if Result then
      begin
        DecodeDate(ADate, AYear, AMonth, ADay);
        Result := (ADay > 0) and (AYear <= MaxYear);
      end;
    end;
  except
    Result := False;
    ADate := NullDate;
  end;
end;

function DateTimeToText(ADate: TDateTime; AFourDigitYearNeeded: Boolean = False): string;

  function GetDateTimeFormat: string;
  var
    I: Integer;
    S: string;
  begin
    if cxFormatController.UseDelphiDateTimeFormats then
    begin
      Result := ShortDateFormat;
      if TimeOf(ADate) <> 0 then
        Result := Result + ' ' + LongTimeFormat;
    end
    else
      Result := cxGetLocaleStr(LOCALE_SSHORTDATE);
    if AFourDigitYearNeeded then
    begin
      S := LowerCase(Result);
      if (Pos('yyy', S) = 0) and (Pos('yy', S) > 0) then
      begin
        I := Pos('yy', S);
        Insert(Result[I], Result, I + 2);
        Insert(Result[I], Result, I + 3);
      end;
    end;
  end;

var
  SystemTime: TSystemTime;
  PS: PChar;
begin
  if ADate = NullDate then
    Result := ''
  else
    if cxFormatController.UseDelphiDateTimeFormats then
//      Result := DateTimeToStr(ADate)
      DateTimeToString(Result, GetDateTimeFormat, ADate)
    else
    begin
      DateTimeToSystemTime(ADate, SystemTime);
//      if Pos('yyyy', LowerCase(cxFormatController.DateEditFormat)) = 0 then
//        SystemTime.wYear := SystemTime.wYear mod 100;
      GetMem(PS, 100);
      try
        if GetDateFormat(GetThreadLocale, 0, @SystemTime,
          PAnsiChar(GetDateTimeFormat), PS, 100) <> 0 then
        begin
          Result := PS;
          if TimeOf(ADate) <> 0 then
          begin
            GetTimeFormat(GetThreadLocale, 0, @SystemTime, nil, PS, 100);
            Result := Result + ' ' + PS;
          end;
        end
        else
          try
            Result := VarFromDateTime(ADate);
          except
            on EVariantError do
              Result := '';
          end;
      finally
        FreeMem(PS, 100);
      end;
    end;
end;

function DateTimeToTextEx(const ADate: TDateTime; AIsMasked: Boolean;
  AIsDateTimeEdit: Boolean = False; AFourDigitYearNeeded: Boolean = False): string;
begin
  if ADate = NullDate then
    Result := ''
  else
  begin
    if AIsMasked then
    begin
      if AIsDateTimeEdit then
        Result := FormatDateTime(cxFormatController.MaskedDateTimeEditFormat, ADate)
      else
        Result := FormatDateTime(cxFormatController.MaskedDateEditFormat, DateOf(ADate));
    end
    else
      Result := DateTimeToText(ADate, AFourDigitYearNeeded);
  end;
end;

function cxMinDateTime: Double;
begin
  Result := EncodeDate(MinYear, 1, 1);
end;

function cxStrToDateTime(S: string; AUseOleDateFormat: Boolean;
  out ADate: TDateTime): Boolean;
begin
  Result := False;
  ADate := NullDate;
  try
    CorrectTextForDateTimeConversion(S, AUseOleDateFormat);
    if AUseOleDateFormat then
      ADate := VarToDateTime(S)
    else
      ADate := StrToDateTime(S);
    Result := True;
  except
    on Exception(*EConvertError*) do
      ADate := NullDate;
  end;
end;

function VarIsNullDate(const AValue: Variant): Boolean;
begin
  Result := (VarIsDate(AValue) or VarIsNumericEx(AValue)) and (AValue = NullDate);
end;

end.

