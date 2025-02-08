// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDateFormat.pas' rev: 31.00 (Windows)

#ifndef LmddateformatHPP
#define LmddateformatHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddateformat
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDateFormat;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDateFormats : unsigned char { dfShortSystem, dfLongSystem, dfCustom };

class PASCALIMPLEMENTATION TLMDDateFormat : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::UnicodeString FFormatStr;
	TLMDDateFormats FFormat;
	System::Int8 FYearDelta;
	System::Classes::TNotifyEvent FOnFormatChanged;
	System::Classes::TNotifyEvent FOnFormatChange;
	void __fastcall SetFormatStr(System::UnicodeString aValue);
	void __fastcall SetFormat(TLMDDateFormats aValue);
	
public:
	__fastcall virtual TLMDDateFormat(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Word __fastcall LastMonthDay(System::Word y, System::Word m);
	void __fastcall DoFormatChanged(void);
	void __fastcall DoFormatChange(void);
	System::UnicodeString __fastcall GetFormatStr(void);
	System::UnicodeString __fastcall DateToStr(System::TDateTime date);
	void __fastcall StrToYMD(System::UnicodeString str, System::Word &Y, System::Word &M, System::Word &D);
	System::TDateTime __fastcall StrToDate(System::UnicodeString str);
	System::UnicodeString __fastcall GetEditString(System::Word Y, System::Word M, System::Word D);
	System::UnicodeString __fastcall GetDTEditString(System::TDateTime dt);
	int __fastcall GetLongMonthExtend(void);
	int __fastcall GetShortMonthExtend(void);
	int __fastcall GetLongDayExtend(void);
	int __fastcall GetShortDayExtend(void);
	int __fastcall NextEditPos(int current, System::UnicodeString text);
	int __fastcall PrevEditPos(int current, System::UnicodeString text);
	int __fastcall CurrentLength(int current, System::UnicodeString text);
	int __fastcall CurrentStart(int current, System::UnicodeString text);
	int __fastcall CurrentType(int current, System::UnicodeString text);
	int __fastcall DateLength(System::UnicodeString text);
	int __fastcall GetPattern(int current, System::UnicodeString text);
	void __fastcall GetPatInfo(int pattern, System::UnicodeString text, int &pat_start, int &pat_end, int &pat_type);
	System::Word __fastcall CurrentYear(void);
	System::Word __fastcall GetYearDelta(void);
	__property System::Classes::TNotifyEvent OnFormatChanged = {read=FOnFormatChanged, write=FOnFormatChanged};
	__property System::Classes::TNotifyEvent OnFormatChange = {read=FOnFormatChange, write=FOnFormatChange};
	
__published:
	__property System::UnicodeString FormatStr = {read=FFormatStr, write=SetFormatStr};
	__property TLMDDateFormats Format = {read=FFormat, write=SetFormat, default=0};
	__property System::Int8 YearDelta = {read=FYearDelta, write=FYearDelta, default=-1};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDDateFormat(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddateformat */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDATEFORMAT)
using namespace Lmddateformat;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddateformatHPP
