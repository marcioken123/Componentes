// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartSeriesCollection.pas' rev: 31.00 (Windows)

#ifndef LmdchartseriescollectionHPP
#define LmdchartseriescollectionHPP

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
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <System.Math.hpp>
#include <LMDChartValuesBase.hpp>
#include <LMDChartSeries.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartMarker.hpp>
#include <LMDChartBackground.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartseriescollection
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartSeriesCollectionItem;
class DELPHICLASS TLMDChartSeriesColl;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDChartSeriesCollectionItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdchartbackground::TLMDChartBackground* FFill;
	Lmdchartline::TLMDChartLine* FLine;
	Lmdchartmarker::TLMDChartMarker* FMarker;
	void __fastcall SetFill(Lmdchartbackground::TLMDChartBackground* const Value);
	void __fastcall SetLine(Lmdchartline::TLMDChartLine* const Value);
	void __fastcall SetMarker(Lmdchartmarker::TLMDChartMarker* const Value);
	
protected:
	Lmdchartseries::TLMDCustomChartSeries* FSeries;
	void __fastcall SetSeries(Lmdchartseries::TLMDCustomChartSeries* const Value);
	
public:
	__fastcall virtual TLMDChartSeriesCollectionItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDChartSeriesCollectionItem(void);
	void __fastcall RefreshParentChart(void);
	
__published:
	__property Lmdchartseries::TLMDCustomChartSeries* Series = {read=FSeries, write=SetSeries};
	__property Lmdchartmarker::TLMDChartMarker* Marker = {read=FMarker, write=SetMarker};
	__property Lmdchartline::TLMDChartLine* Line = {read=FLine, write=SetLine};
	__property Lmdchartbackground::TLMDChartBackground* Fill = {read=FFill, write=SetFill};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDChartSeriesColl : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDChartSeriesCollectionItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TLMDChartSeriesCollectionItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDChartSeriesCollectionItem* const Value);
	int __fastcall GetMaxNumberOfValues(void);
	void __fastcall RefreshParentChart(void);
	
protected:
	System::Classes::TComponent* FOwner;
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TLMDChartSeriesColl(System::Classes::TComponent* AComponent);
	HIDESBASE TLMDChartSeriesCollectionItem* __fastcall Add(void);
	HIDESBASE void __fastcall Delete(int Index);
	__property TLMDChartSeriesCollectionItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
	__property int MaxNumberOfValues = {read=GetMaxNumberOfValues, nodefault};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDChartSeriesColl(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartseriescollection */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTSERIESCOLLECTION)
using namespace Lmdchartseriescollection;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartseriescollectionHPP
