// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartValuesCollection.pas' rev: 31.00 (Windows)

#ifndef LmdchartvaluescollectionHPP
#define LmdchartvaluescollectionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <LMDChartValuesBase.hpp>
#include <LMDChartValues.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartvaluescollection
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartValuesCollectionItem;
class DELPHICLASS TLMDChartValuesColl;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDChartValuesType : unsigned char { cvtMemory, cvtDB, cvtXML };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDChartValuesCollectionItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
protected:
	Lmdchartvaluesbase::TLMDChartValuesBase* FChartValues;
	void __fastcall SetChartValues(Lmdchartvaluesbase::TLMDChartValuesBase* const Value);
	
public:
	__fastcall virtual TLMDChartValuesCollectionItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDChartValuesCollectionItem(void);
	
__published:
	__property Lmdchartvaluesbase::TLMDChartValuesBase* ChartValues = {read=FChartValues, write=SetChartValues};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDChartValuesColl : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDChartValuesCollectionItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	TLMDChartValuesType FChartValuesType;
	Lmdchartvaluesbase::TLMDChartValuesClass FChartValuesClass;
	void __fastcall SetChartValuesType(const TLMDChartValuesType Value);
	HIDESBASE TLMDChartValuesCollectionItem* __fastcall GetItem(int Index)/* overload */;
	HIDESBASE void __fastcall SetItem(int Index, TLMDChartValuesCollectionItem* const Value)/* overload */;
	TLMDChartValuesCollectionItem* __fastcall GetItemByName(System::UnicodeString Name)/* overload */;
	void __fastcall SetItemByName(System::UnicodeString Name, TLMDChartValuesCollectionItem* const Value)/* overload */;
	int __fastcall ItemIndexByName(System::UnicodeString Name);
	int __fastcall GetNumberOfValues(void);
	void __fastcall SetNumberOfValues(const int Value);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDChartValuesColl(System::Classes::TComponent* AComponent, Lmdchartvaluesbase::TLMDChartValuesClass AChartValuesClass);
	HIDESBASE TLMDChartValuesCollectionItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	bool __fastcall Contains(System::UnicodeString Name);
	void __fastcall RefreshParentChart(void);
	__property TLMDChartValuesCollectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property TLMDChartValuesCollectionItem* ItemsByName[System::UnicodeString Name] = {read=GetItemByName, write=SetItemByName};
	__property TLMDChartValuesType ChartValuesType = {read=FChartValuesType, write=SetChartValuesType, nodefault};
	__property int NumberOfValues = {read=GetNumberOfValues, write=SetNumberOfValues, nodefault};
	__property Lmdchartvaluesbase::TLMDChartValuesClass ChartValuesClass = {read=FChartValuesClass};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDChartValuesColl(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartvaluescollection */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTVALUESCOLLECTION)
using namespace Lmdchartvaluescollection;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartvaluescollectionHPP
