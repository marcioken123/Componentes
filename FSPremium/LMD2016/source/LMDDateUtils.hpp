// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDateUtils.pas' rev: 34.00 (Windows)

#ifndef LmddateutilsHPP
#define LmddateutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddateutils
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
typedef double TLMDJulianDate;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDGetTime(System::TDateTime DateTime);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDIncDate(System::TDateTime ADate, int Days, int Months, int Years);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDNowToUTC(void);
extern DELPHI_PACKAGE void __fastcall LMDUTCToZoneLocal(Winapi::Windows::PTimeZoneInformation lpTimeZoneInformation, const _SYSTEMTIME &lpUniversalTime, _SYSTEMTIME &lpLocalTime);
extern DELPHI_PACKAGE void __fastcall LMDZoneLocalToUTC(Winapi::Windows::PTimeZoneInformation lpTimeZoneInformation, _SYSTEMTIME &lpUniversalTime, const _SYSTEMTIME &lpLocalTime);
extern DELPHI_PACKAGE void __fastcall LMDSystemTimeToTzSpecificLocalTime(Winapi::Windows::PTimeZoneInformation lpTimeZoneInformation, _SYSTEMTIME &lpUniversalTime, _SYSTEMTIME &lpLocalTime);
extern DELPHI_PACKAGE int __fastcall LMDZoneIDtoBias(System::UnicodeString ZoneID);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDExtractTime(System::TDateTime ATime);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDExtractDate(System::TDateTime ATime);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDIncTime(System::TDateTime ATime, int Hours, int Minutes, int Seconds, int MSecs);
extern DELPHI_PACKAGE unsigned __fastcall LMDDateTimeToSeconds(int ADay, int AMonth, int AYear, int AHours, int AMinute, int ASecond);
extern DELPHI_PACKAGE void __fastcall LMDSecondsToDateTime(unsigned Seconds, int &ADay, int &AMonth, int &AYear, int &AHours, int &AMinute, int &ASecond);
extern DELPHI_PACKAGE int __fastcall LMDDateToJulianDays(int ADay, int AMonth, int AYear);
extern DELPHI_PACKAGE void __fastcall LMDJulianDaysToDate(int &ADay, int &AMonth, int &AYear, int JulianDate);
extern DELPHI_PACKAGE int __fastcall LMDDayOfWeek(int ADay, int AMonth, int AYear);
extern DELPHI_PACKAGE int __fastcall LMDDaysPerMonth(int AYear, int AMonth);
extern DELPHI_PACKAGE int __fastcall LMDDayNumber(int AYear, int AMonth, int ADay);
extern DELPHI_PACKAGE int __fastcall LMDWeekNumber(int AYear, int AMonth, int ADay);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDGetFormattedTimeString(System::TDateTime ADate, const System::UnicodeString Format);
extern DELPHI_PACKAGE int __fastcall LMDGetSysStartDayOfWeek(void);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDOffsetDateTime(System::TDateTime DT, int byYears, int byMonths, int byDays, int byHours, int byMinutes, int bySeconds, int byMSeconds);
extern DELPHI_PACKAGE double __fastcall LMDYMDToJulian(int y, int m, int d);
extern DELPHI_PACKAGE double __fastcall LMDDateToJulian(System::TDateTime ADate);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDJulianToDate(double jul);
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDSubtractTimes(System::TDateTime Time1, System::TDateTime Time2);
}	/* namespace Lmddateutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDATEUTILS)
using namespace Lmddateutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddateutilsHPP
