// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysLocaleObject.pas' rev: 31.00 (Windows)

#ifndef LmdsyslocaleobjectHPP
#define LmdsyslocaleobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysConst.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyslocaleobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysLocaleObject;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::UnicodeString, 7> Lmdsyslocaleobject__1;

enum DECLSPEC_DENUM TLMDSysLocaleNumberInfo : unsigned char { lpidLanguage, lpidLanguageEnglish, lpidLanguageSymbol, lpidCountryCode, lpidCountry, lpidCountrySymbol, lpidDecimalSeparator, lpidDigits, lpidThousandSeparator, lpidGrouping, lpidNegativeSign, lpidNegativeFormat, lpidPositiveSign, lpidShowLeadingZero, lpidListSeparator, lpidMeasurement };

typedef System::Set<TLMDSysLocaleNumberInfo, TLMDSysLocaleNumberInfo::lpidLanguage, TLMDSysLocaleNumberInfo::lpidMeasurement> TLMDSysLocaleNumberInfos;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 16> Lmdsyslocaleobject__2;

enum DECLSPEC_DENUM TLMDSysLocaleDateTimeInfo : unsigned char { lpidCalendarType, lpidYearDigits, lpidFirstDayOfWeek, lpidFirstWeekOfYear, lpidDateSeparator, lpidLongDateFormat, lpidLongDateOrder, lpidShortDateFormat, lpidShortDateOrder, lpidClockMode, lpidTimeSeparator, lpidTimeFormat, lpidMorningSymbol, lpidAfternoonSymbol };

typedef System::Set<TLMDSysLocaleDateTimeInfo, TLMDSysLocaleDateTimeInfo::lpidCalendarType, TLMDSysLocaleDateTimeInfo::lpidAfternoonSymbol> TLMDSysLocaleDateTimeInfos;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 14> Lmdsyslocaleobject__3;

enum DECLSPEC_DENUM TLMDSysLocaleCurrencyInfo : unsigned char { lpidCurrencySymbol, lpidInternationalCurrencySymbol, lpidPositiveCurrencyFormat, lpidNegativeCurrencyFormat, lpidCurrencyDecimalSeparator, lpidCurrencyDigits, lpidCurrencyGroupingSign, lpidCurrencyGrouping };

typedef System::Set<TLMDSysLocaleCurrencyInfo, TLMDSysLocaleCurrencyInfo::lpidCurrencySymbol, TLMDSysLocaleCurrencyInfo::lpidCurrencyGrouping> TLMDSysLocaleCurrencyInfos;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 8> Lmdsyslocaleobject__4;

class PASCALIMPLEMENTATION TLMDSysLocaleObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	System::UnicodeString FCalendarType;
	System::UnicodeString FCurrencyDigits;
	System::UnicodeString FPositiveCurrencyFormat;
	System::UnicodeString FDigits;
	System::UnicodeString FFirstDayOfWeek;
	System::UnicodeString FFirstWeekOfYear;
	System::UnicodeString FMeasurement;
	System::UnicodeString FNegativeCurrFormat;
	System::UnicodeString FShowLeadingZero;
	System::UnicodeString FNegativeFormat;
	System::UnicodeString FClockMode;
	System::UnicodeString FMorningSymbol;
	System::UnicodeString FAfternoonSymbol;
	System::UnicodeString FCurrencySymbol;
	System::UnicodeString FDateSeparator;
	System::UnicodeString FDecimalSeparator;
	System::UnicodeString FGrouping;
	System::UnicodeString FListSeparator;
	System::UnicodeString FLongDateFormat;
	System::UnicodeString FCurrencyDecimalSeparator;
	System::UnicodeString FCurrencyGrouping;
	System::UnicodeString FCurrencyGroupingSign;
	System::UnicodeString FNegativeSign;
	System::UnicodeString FPositiveSign;
	System::UnicodeString FTimeFormat;
	System::UnicodeString FThousandSeparator;
	System::UnicodeString FTimeSeparator;
	System::UnicodeString FShortDateOrder;
	System::UnicodeString FLongDateOrder;
	System::UnicodeString FYearDigits;
	System::UnicodeString FIntCurSymbol;
	System::UnicodeString FLanguage;
	System::UnicodeString FLanguageEnglish;
	System::UnicodeString FLanguageSymbol;
	System::UnicodeString FCountryCode;
	System::UnicodeString FCountry;
	System::UnicodeString FCountrySymbol;
	System::UnicodeString FShortDateFormat;
	TLMDSysLocaleCurrencyInfos FCurrencyInfo;
	TLMDSysLocaleDateTimeInfos FDateTimeInfo;
	TLMDSysLocaleNumberInfos FNumberInfo;
	void __fastcall SetString(int aIndex, System::UnicodeString aValue);
	void __fastcall repIt(System::UnicodeString rep, System::UnicodeString w, System::UnicodeString &s);
	void __fastcall InitArrays(System::UnicodeString *pos_cur, const int pos_cur_High, System::UnicodeString *neg_cur, const int neg_cur_High, System::UnicodeString *neg_num, const int neg_num_High, System::UnicodeString *lz, const int lz_High, System::UnicodeString *cm, const int cm_High);
	void __fastcall SetDisplayInfoC(const TLMDSysLocaleCurrencyInfos Value);
	void __fastcall SetDisplayInfoD(const TLMDSysLocaleDateTimeInfos Value);
	void __fastcall SetDisplayInfoN(const TLMDSysLocaleNumberInfos Value);
	
protected:
	virtual void __fastcall DoFilterProperty(const System::UnicodeString Name, bool &Cancel);
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysLocaleObject(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property System::UnicodeString CalendarType = {read=FCalendarType, write=SetString, stored=false, index=0};
	__property System::UnicodeString CurrencyDigits = {read=FCurrencyDigits, write=SetString, stored=false, index=1};
	__property System::UnicodeString PositiveCurrencyFormat = {read=FPositiveCurrencyFormat, write=SetString, stored=false, index=2};
	__property System::UnicodeString Digits = {read=FDigits, write=SetString, stored=false, index=3};
	__property System::UnicodeString FirstDayOfWeek = {read=FFirstDayOfWeek, write=SetString, stored=false, index=4};
	__property System::UnicodeString FirstWeekOfYear = {read=FFirstWeekOfYear, write=SetString, stored=false, index=5};
	__property System::UnicodeString ShowLeadingZero = {read=FShowLeadingZero, write=SetString, stored=false, index=6};
	__property System::UnicodeString Measurement = {read=FMeasurement, write=SetString, stored=false, index=7};
	__property System::UnicodeString NegativeCurrencyFormat = {read=FNegativeCurrFormat, write=SetString, stored=false, index=8};
	__property System::UnicodeString NegativeFormat = {read=FNegativeFormat, write=SetString, stored=false, index=9};
	__property System::UnicodeString ClockMode = {read=FClockMode, write=SetString, stored=false, index=10};
	__property System::UnicodeString MorningSymbol = {read=FMorningSymbol, write=SetString, stored=false, index=11};
	__property System::UnicodeString AfternoonSymbol = {read=FAfternoonSymbol, write=SetString, stored=false, index=12};
	__property System::UnicodeString CurrencySymbol = {read=FCurrencySymbol, write=SetString, stored=false, index=13};
	__property System::UnicodeString DateSeparator = {read=FDateSeparator, write=SetString, stored=false, index=14};
	__property System::UnicodeString DecimalSeparator = {read=FDecimalSeparator, write=SetString, stored=false, index=15};
	__property System::UnicodeString Grouping = {read=FGrouping, write=SetString, stored=false, index=16};
	__property System::UnicodeString ListSeparator = {read=FListSeparator, write=SetString, stored=false, index=17};
	__property System::UnicodeString LongDateFormat = {read=FLongDateFormat, write=SetString, stored=false, index=18};
	__property System::UnicodeString CurrencyDecimalSeparator = {read=FCurrencyDecimalSeparator, write=SetString, stored=false, index=19};
	__property System::UnicodeString CurrencyGrouping = {read=FCurrencyGrouping, write=SetString, stored=false, index=20};
	__property System::UnicodeString CurrencyGroupingSign = {read=FCurrencyGroupingSign, write=SetString, stored=false, index=21};
	__property System::UnicodeString NegativeSign = {read=FNegativeSign, write=SetString, stored=false, index=22};
	__property System::UnicodeString PositiveSign = {read=FPositiveSign, write=SetString, stored=false, index=23};
	__property System::UnicodeString ShortDateFormat = {read=FShortDateFormat, write=SetString, stored=false, index=24};
	__property System::UnicodeString ThousandSeparator = {read=FThousandSeparator, write=SetString, stored=false, index=25};
	__property System::UnicodeString TimeSeparator = {read=FTimeSeparator, write=SetString, stored=false, index=26};
	__property System::UnicodeString TimeFormat = {read=FTimeFormat, write=SetString, stored=false, index=27};
	__property System::UnicodeString ShortDateOrder = {read=FShortDateOrder, write=SetString, stored=false, index=28};
	__property System::UnicodeString LongDateOrder = {read=FLongDateOrder, write=SetString, stored=false, index=29};
	__property System::UnicodeString YearDigits = {read=FYearDigits, write=SetString, stored=false, index=30};
	__property System::UnicodeString InternationalCurrencySymbol = {read=FIntCurSymbol, write=SetString, stored=false, index=31};
	__property System::UnicodeString Language = {read=FLanguage, write=SetString, stored=false, index=32};
	__property System::UnicodeString LanguageEnglish = {read=FLanguageEnglish, write=SetString, stored=false, index=33};
	__property System::UnicodeString LanguageSymbol = {read=FLanguageSymbol, write=SetString, stored=false, index=34};
	__property System::UnicodeString CountryCode = {read=FCountryCode, write=SetString, stored=false, index=35};
	__property System::UnicodeString Country = {read=FCountry, write=SetString, stored=false, index=36};
	__property System::UnicodeString CountrySymbol = {read=FCountrySymbol, write=SetString, stored=false, index=37};
	__property TLMDSysLocaleCurrencyInfos DisplayCurrencyInfo = {read=FCurrencyInfo, write=SetDisplayInfoC, default=255};
	__property TLMDSysLocaleNumberInfos DisplayNumberInfo = {read=FNumberInfo, write=SetDisplayInfoN, default=65535};
	__property TLMDSysLocaleDateTimeInfos DisplayDateTimeInfo = {read=FDateTimeInfo, write=SetDisplayInfoD, default=16383};
public:
	/* TLMDSysObject.Destroy */ inline __fastcall virtual ~TLMDSysLocaleObject(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Lmdsyslocaleobject__1 LMDSysLocaleDayNames;
extern DELPHI_PACKAGE Lmdsyslocaleobject__2 LMDSysLocaleNumberProps;
#define def_TLMDSysLocaleNumberInfos (System::Set<TLMDSysLocaleNumberInfo, TLMDSysLocaleNumberInfo::lpidLanguage, TLMDSysLocaleNumberInfo::lpidMeasurement>() << TLMDSysLocaleNumberInfo::lpidLanguage << TLMDSysLocaleNumberInfo::lpidLanguageEnglish << TLMDSysLocaleNumberInfo::lpidLanguageSymbol << TLMDSysLocaleNumberInfo::lpidCountryCode << TLMDSysLocaleNumberInfo::lpidCountry << TLMDSysLocaleNumberInfo::lpidCountrySymbol << TLMDSysLocaleNumberInfo::lpidDecimalSeparator << TLMDSysLocaleNumberInfo::lpidDigits << TLMDSysLocaleNumberInfo::lpidThousandSeparator << TLMDSysLocaleNumberInfo::lpidGrouping << TLMDSysLocaleNumberInfo::lpidNegativeSign << TLMDSysLocaleNumberInfo::lpidNegativeFormat << TLMDSysLocaleNumberInfo::lpidPositiveSign << TLMDSysLocaleNumberInfo::lpidShowLeadingZero \
	<< TLMDSysLocaleNumberInfo::lpidListSeparator << TLMDSysLocaleNumberInfo::lpidMeasurement )
extern DELPHI_PACKAGE Lmdsyslocaleobject__3 LMDSysLocaleDateTimeProps;
#define def_TLMDSysLocaleDateTimeInfos (System::Set<TLMDSysLocaleDateTimeInfo, TLMDSysLocaleDateTimeInfo::lpidCalendarType, TLMDSysLocaleDateTimeInfo::lpidAfternoonSymbol>() << TLMDSysLocaleDateTimeInfo::lpidCalendarType << TLMDSysLocaleDateTimeInfo::lpidYearDigits << TLMDSysLocaleDateTimeInfo::lpidFirstDayOfWeek << TLMDSysLocaleDateTimeInfo::lpidFirstWeekOfYear << TLMDSysLocaleDateTimeInfo::lpidDateSeparator << TLMDSysLocaleDateTimeInfo::lpidLongDateFormat << TLMDSysLocaleDateTimeInfo::lpidLongDateOrder << TLMDSysLocaleDateTimeInfo::lpidShortDateFormat << TLMDSysLocaleDateTimeInfo::lpidShortDateOrder << TLMDSysLocaleDateTimeInfo::lpidClockMode << TLMDSysLocaleDateTimeInfo::lpidTimeSeparator << TLMDSysLocaleDateTimeInfo::lpidTimeFormat << TLMDSysLocaleDateTimeInfo::lpidMorningSymbol \
	<< TLMDSysLocaleDateTimeInfo::lpidAfternoonSymbol )
extern DELPHI_PACKAGE Lmdsyslocaleobject__4 LMDSysLocaleCurrencyProps;
#define def_TLMDSysLocaleCurrencyInfos (System::Set<TLMDSysLocaleCurrencyInfo, TLMDSysLocaleCurrencyInfo::lpidCurrencySymbol, TLMDSysLocaleCurrencyInfo::lpidCurrencyGrouping>() << TLMDSysLocaleCurrencyInfo::lpidCurrencySymbol << TLMDSysLocaleCurrencyInfo::lpidInternationalCurrencySymbol << TLMDSysLocaleCurrencyInfo::lpidPositiveCurrencyFormat << TLMDSysLocaleCurrencyInfo::lpidNegativeCurrencyFormat << TLMDSysLocaleCurrencyInfo::lpidCurrencyDecimalSeparator << TLMDSysLocaleCurrencyInfo::lpidCurrencyDigits << TLMDSysLocaleCurrencyInfo::lpidCurrencyGroupingSign << TLMDSysLocaleCurrencyInfo::lpidCurrencyGrouping )
}	/* namespace Lmdsyslocaleobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSLOCALEOBJECT)
using namespace Lmdsyslocaleobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyslocaleobjectHPP
