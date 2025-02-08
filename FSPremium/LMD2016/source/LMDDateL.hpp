// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDateL.pas' rev: 31.00 (Windows)

#ifndef LmddatelHPP
#define LmddatelHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddatel
{
//-- forward type declarations -----------------------------------------------
struct TLMDDateListRecord;
class DELPHICLASS TLMDDateList;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TLMDDateListRecord
{
public:
	System::TDateTime Datefg;
	System::TDateTime Date;
	System::SmallString<40> DateString;
	bool Active;
	bool Calculated;
};


typedef TLMDDateListRecord *PLMDDateListRecord;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDateList : public System::Classes::TList
{
	typedef System::Classes::TList inherited;
	
private:
	TLMDDateListRecord __fastcall GetDate(int Index);
	
protected:
	int __fastcall Comp(System::TObject* Item1, System::TObject* Item2);
	
public:
	__fastcall virtual ~TLMDDateList(void);
	void __fastcall DeleteDate(int Index);
	void __fastcall PutDate(int Index, const TLMDDateListRecord &aValue);
	void __fastcall AddDate(const TLMDDateListRecord &aValue);
	void __fastcall EditDate(int Index, const TLMDDateListRecord &aValue);
	void __fastcall SortDates(void);
	void __fastcall SaveToFile(const System::UnicodeString Filename);
	void __fastcall LoadFromFile(const System::UnicodeString Filename);
	void __fastcall SaveToStream(System::Classes::TStream* Stream);
	void __fastcall LoadFromStream(System::Classes::TStream* Stream);
	__property TLMDDateListRecord Dates[int Index] = {read=GetDate, write=PutDate};
public:
	/* TObject.Create */ inline __fastcall TLMDDateList(void) : System::Classes::TList() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddatel */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDATEL)
using namespace Lmddatel;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddatelHPP
