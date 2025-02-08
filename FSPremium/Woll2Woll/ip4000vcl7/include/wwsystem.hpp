// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwSystem.pas' rev: 6.00

#ifndef wwSystemHPP
#define wwSystemHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <StdCtrls.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwsystem
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TwwDateOrder { doMDY, doDMY, doYMD };
#pragma option pop

#pragma option push -b-
enum TwwDateTimeSelection { wwdsDay, wwdsMonth, wwdsYear, wwdsHour, wwdsMinute, wwdsSecond, wwdsAMPM };
#pragma option pop

//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwSystem)
extern PACKAGE TwwDateOrder __fastcall wwGetDateOrder(const AnsiString DateFormat);
extern PACKAGE int __fastcall wwNextDay(Word Year, Word Month, Word Day);
extern PACKAGE int __fastcall wwPriorDay(Word Year, Word Month, Word Day);
extern PACKAGE bool __fastcall wwDoEncodeDate(Word Year, Word Month, Word Day, System::TDateTime &Date);
extern PACKAGE bool __fastcall wwScanDate(const AnsiString S, System::TDateTime &Date);
extern PACKAGE bool __fastcall wwScanDateEpoch(const AnsiString S, System::TDateTime &Date, int Epoch);
extern PACKAGE bool __fastcall wwDoEncodeTime(Word Hour, Word Min, Word Sec, Word MSec, System::TDateTime &Time);
extern PACKAGE bool __fastcall wwStrToDate(const AnsiString S);
extern PACKAGE bool __fastcall wwStrToTime(const AnsiString S);
extern PACKAGE bool __fastcall wwStrToDateTime(const AnsiString S);
extern PACKAGE System::TDateTime __fastcall wwStrToDateTimeVal(const AnsiString S);
extern PACKAGE System::TDateTime __fastcall wwStrToDateVal(const AnsiString S);
extern PACKAGE System::TDateTime __fastcall wwStrToTimeVal(const AnsiString S);
extern PACKAGE bool __fastcall wwStrToInt(const AnsiString S);
extern PACKAGE bool __fastcall wwStrToFloat(const AnsiString S);
extern PACKAGE TwwDateTimeSelection __fastcall wwGetDateTimeCursorPosition(int SelStart, AnsiString Text, bool TimeOnly);
extern PACKAGE TwwDateTimeSelection __fastcall wwGetTimeCursorPosition(int SelStart, AnsiString Text);
extern PACKAGE void __fastcall wwSetDateTimeCursorSelection(TwwDateTimeSelection dateCursor, Stdctrls::TCustomEdit* edit, bool TimeOnly);
extern PACKAGE bool __fastcall wwStrToFloat2(const AnsiString S, Extended &FloatValue, AnsiString DisplayFormat);

}	/* namespace Wwsystem */
using namespace Wwsystem;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwSystem
