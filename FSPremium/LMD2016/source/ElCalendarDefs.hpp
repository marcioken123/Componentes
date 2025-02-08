// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCalendarDefs.pas' rev: 31.00 (Windows)

#ifndef ElcalendardefsHPP
#define ElcalendardefsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Windows.hpp>
#include <LMDUnicode.hpp>
#include <LMDStrings.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcalendardefs
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElCustomCalendarNames;
class DELPHICLASS TElHoliday;
class DELPHICLASS TElHolidays;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElCalendarCellType : unsigned char { cctDayName, cctWeekNum, cctToday, cctOtherMonth, cctWeekEnd, cctInPeriod, cctHoliday, cctEmpty, cctSelected };

typedef System::Set<TElCalendarCellType, TElCalendarCellType::cctDayName, TElCalendarCellType::cctSelected> TElCalendarCellTypes;

typedef void __fastcall (__closure *TBeforeCellDrawEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, int RowNum, int ColNum, System::TDateTime Date, TElCalendarCellTypes CellType);

typedef System::Int8 TDayOfWeek;

enum DECLSPEC_DENUM TElWeekEndDay : unsigned char { Sun, Mon, Tue, Wed, Thu, Fri, Sat };

typedef System::Set<TElWeekEndDay, TElWeekEndDay::Sun, TElWeekEndDay::Sat> TElWeekEndDays;

typedef void __fastcall (__closure *TElHolidayEvent)(System::TObject* Sender, System::Word ADay, System::Word AMonth, System::Word AYear, bool &IsHoliday);

class PASCALIMPLEMENTATION TElCustomCalendarNames : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	System::Classes::TStrings* FLongMonthNames;
	System::Classes::TStrings* FShortMonthNames;
	System::Classes::TStrings* FLongDayNames;
	System::Classes::TStrings* FShortDayNames;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall SetLongMonthNames(System::Classes::TStrings* const Value);
	void __fastcall SetLongDayNames(System::Classes::TStrings* const Value);
	void __fastcall SetShortDayNames(System::Classes::TStrings* const Value);
	void __fastcall SetShortMonthNames(System::Classes::TStrings* const Value);
	void __fastcall DoChange(System::TObject* Sender);
	
public:
	__fastcall virtual TElCustomCalendarNames(void);
	__fastcall virtual ~TElCustomCalendarNames(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	Lmdtypes::TLMDString __fastcall GetShortDayNames(int Index);
	Lmdtypes::TLMDString __fastcall GetShortMonthNames(int Index);
	Lmdtypes::TLMDString __fastcall GetLongDayNames(int Index);
	Lmdtypes::TLMDString __fastcall GetLongMonthNames(int Index);
	
__published:
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property System::Classes::TStrings* LongMonthNames = {read=FLongMonthNames, write=SetLongMonthNames};
	__property System::Classes::TStrings* ShortMonthNames = {read=FShortMonthNames, write=SetShortMonthNames};
	__property System::Classes::TStrings* LongDayNames = {read=FLongDayNames, write=SetLongDayNames};
	__property System::Classes::TStrings* ShortDayNames = {read=FShortDayNames, write=SetShortDayNames};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElHoliday : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::AnsiString FDescription;
	bool FFixedDate;
	System::Word FDay;
	System::Word FDayOfWeek;
	System::Word FMonth;
	bool FIsRest;
	void __fastcall SetFixedDate(bool newValue);
	void __fastcall SetDay(System::Word newValue);
	void __fastcall SetDayOfWeek(System::Word newValue);
	void __fastcall SetMonth(System::Word newValue);
	void __fastcall SetIsRest(bool newValue);
	
public:
	__fastcall virtual TElHoliday(System::Classes::TCollection* Collection);
	__fastcall virtual ~TElHoliday(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	
__published:
	__property bool FixedDate = {read=FFixedDate, write=SetFixedDate, default=1};
	__property System::Word Day = {read=FDay, write=SetDay, nodefault};
	__property System::Word DayOfWeek = {read=FDayOfWeek, write=SetDayOfWeek, nodefault};
	__property System::Word Month = {read=FMonth, write=SetMonth, nodefault};
	__property bool IsRest = {read=FIsRest, write=SetIsRest, nodefault};
	__property System::AnsiString Description = {read=FDescription, write=FDescription};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElHolidays : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TElHoliday* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TPersistent* FOwner;
	TElHoliday* __fastcall GetItems(int Index);
	void __fastcall SetItems(int Index, TElHoliday* newValue);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TElHolidays(System::Classes::TComponent* AOwner);
	HIDESBASE TElHoliday* __fastcall Add(void);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	__property TElHoliday* Items[int Index] = {read=GetItems, write=SetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TElHolidays(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elcalendardefs */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCALENDARDEFS)
using namespace Elcalendardefs;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcalendardefsHPP
