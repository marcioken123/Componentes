// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDateTime.pas' rev: 34.00 (Windows)

#ifndef LmddatetimeHPP
#define LmddatetimeHPP

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

namespace Lmddatetime
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDateTime;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDateTime : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::TDateTime FDateTime;
	void __fastcall SetDay(System::Byte aValue);
	void __fastcall SetMonth(System::Byte aValue);
	void __fastcall SetYear(int aValue);
	void __fastcall SetMinute(System::Byte aValue);
	void __fastcall SetHour(System::Byte aValue);
	void __fastcall SetSecond(System::Byte aValue);
	void __fastcall SetDateTime(System::TDateTime aValue);
	System::Byte __fastcall GetDay();
	System::Byte __fastcall GetMonth();
	int __fastcall GetYear();
	System::Byte __fastcall GetHour();
	System::Byte __fastcall GetMinute();
	System::Byte __fastcall GetSecond();
	System::UnicodeString __fastcall GetISO8601();
	System::UnicodeString __fastcall GetRFC822();
	void __fastcall SetISO8601(const System::UnicodeString Value);
	void __fastcall SetRFC822(const System::UnicodeString Value);
	
public:
	__fastcall virtual TLMDDateTime(System::Classes::TPersistent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property System::TDateTime DateTimeValue = {read=FDateTime, write=SetDateTime};
	__property System::UnicodeString DateISO8601 = {read=GetISO8601, write=SetISO8601};
	__property System::UnicodeString DateRFC822 = {read=GetRFC822, write=SetRFC822};
	
__published:
	__property System::Byte Day = {read=GetDay, write=SetDay, default=1};
	__property System::Byte Month = {read=GetMonth, write=SetMonth, default=1};
	__property int Year = {read=GetYear, write=SetYear, default=1990};
	__property System::Byte Hour = {read=GetHour, write=SetHour, default=0};
	__property System::Byte Minute = {read=GetMinute, write=SetMinute, default=0};
	__property System::Byte Second = {read=GetSecond, write=SetSecond, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDDateTime() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddatetime */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDATETIME)
using namespace Lmddatetime;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddatetimeHPP
