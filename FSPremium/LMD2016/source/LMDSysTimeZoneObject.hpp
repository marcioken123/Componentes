// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysTimeZoneObject.pas' rev: 31.00 (Windows)

#ifndef LmdsystimezoneobjectHPP
#define LmdsystimezoneobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsystimezoneobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysTimeZoneObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysTimeZoneDisplayInfo : unsigned char { tpidBias, tpidTimezoneID, tpidDayLightName, tpidDayLightBias, tpidDayLightDate, tpidDayLightDateString, tpidStandardName, tpidStandardBias, tpidStandardDate, tpidStandardDateString };

typedef System::Set<TLMDSysTimeZoneDisplayInfo, TLMDSysTimeZoneDisplayInfo::tpidBias, TLMDSysTimeZoneDisplayInfo::tpidStandardDateString> TLMDSysTimeZoneDisplayInfos;

enum DECLSPEC_DENUM TLMDSysTimeZoneID : unsigned char { stzStandard, stzDayLight, stzUnknown };

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 10> Lmdsystimezoneobject__1;

typedef System::StaticArray<System::UnicodeString, 3> Lmdsystimezoneobject__2;

class PASCALIMPLEMENTATION TLMDSysTimeZoneObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	int FStdBias;
	int FDayLightBias;
	int FBias;
	System::UnicodeString FDayLightName;
	System::UnicodeString FStdName;
	System::UnicodeString FDayLightDateString;
	System::UnicodeString FStdDateString;
	System::TDateTime FDayLightDate;
	System::TDateTime FStdDate;
	TLMDSysTimeZoneDisplayInfos FDisplayInfo;
	TLMDSysTimeZoneID FTimeZoneID;
	void __fastcall SetDummyLongInt(int aValue);
	void __fastcall SetDummyDate(System::TDateTime aValue);
	void __fastcall SetDummyString(System::UnicodeString aValue);
	void __fastcall SetDisplayInfo(const TLMDSysTimeZoneDisplayInfos Value);
	System::TDateTime __fastcall GetLocalTimeOffset(void);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysTimeZoneObject(void);
	virtual void __fastcall Apply(void);
	virtual void __fastcall Init(void);
	virtual void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	System::TDateTime __fastcall GetCoordinatedUniversalTime(void);
	int __fastcall GetLocalTimeOffsetMinutes(void);
	__property TLMDSysTimeZoneID TimeZoneID = {read=FTimeZoneID, nodefault};
	__property System::TDateTime LocalTimeOffset = {read=GetLocalTimeOffset};
	
__published:
	__property int Bias = {read=FBias, write=SetDummyLongInt, stored=false, nodefault};
	__property int DayLightBias = {read=FDayLightBias, write=SetDummyLongInt, stored=false, nodefault};
	__property int StandardBias = {read=FStdBias, write=SetDummyLongInt, stored=false, nodefault};
	__property System::UnicodeString DayLightName = {read=FDayLightName, write=SetDummyString, stored=false};
	__property System::UnicodeString StandardName = {read=FStdName, write=SetDummyString, stored=false};
	__property System::UnicodeString DayLightDateExt = {read=FDayLightDateString, write=SetDummyString, stored=false};
	__property System::UnicodeString StandardDateExt = {read=FStdDateString, write=SetDummyString, stored=false};
	__property System::TDateTime DayLightDate = {read=FDayLightDate, write=SetDummyDate, stored=false};
	__property System::TDateTime StandardDate = {read=FStdDate, write=SetDummyDate, stored=false};
	__property TLMDSysTimeZoneDisplayInfos DisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=1023};
public:
	/* TLMDSysObject.Destroy */ inline __fastcall virtual ~TLMDSysTimeZoneObject(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysTimeZoneDisplayInfos (System::Set<TLMDSysTimeZoneDisplayInfo, TLMDSysTimeZoneDisplayInfo::tpidBias, TLMDSysTimeZoneDisplayInfo::tpidStandardDateString>() << TLMDSysTimeZoneDisplayInfo::tpidBias << TLMDSysTimeZoneDisplayInfo::tpidTimezoneID << TLMDSysTimeZoneDisplayInfo::tpidDayLightName << TLMDSysTimeZoneDisplayInfo::tpidDayLightBias << TLMDSysTimeZoneDisplayInfo::tpidDayLightDate << TLMDSysTimeZoneDisplayInfo::tpidDayLightDateString << TLMDSysTimeZoneDisplayInfo::tpidStandardName << TLMDSysTimeZoneDisplayInfo::tpidStandardBias << TLMDSysTimeZoneDisplayInfo::tpidStandardDate << TLMDSysTimeZoneDisplayInfo::tpidStandardDateString )
extern DELPHI_PACKAGE Lmdsystimezoneobject__1 LMDSysTimeZoneProps;
extern DELPHI_PACKAGE Lmdsystimezoneobject__2 sLMDSysTimeZoneID;
extern DELPHI_PACKAGE System::TDateTime __fastcall LMDSysGetDateTimeExt(System::Word NumberDayInMonth, System::Word WeekDay, System::Word Month, System::TDateTime ATime = 0.000000E+00);
}	/* namespace Lmdsystimezoneobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSTIMEZONEOBJECT)
using namespace Lmdsystimezoneobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsystimezoneobjectHPP
