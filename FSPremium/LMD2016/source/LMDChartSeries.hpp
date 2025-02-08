// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartSeries.pas' rev: 31.00 (Windows)

#ifndef LmdchartseriesHPP
#define LmdchartseriesHPP

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
#include <Winapi.Windows.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartValuesBase.hpp>
#include <LMDChartValues.hpp>
#include <LMDChartValuesCollection.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartseries
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomChartSeries;
class DELPHICLASS TLMDChartSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomChartSeries : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Lmdchartvaluescollection::TLMDChartValuesColl* FChartValuesColl;
	System::UnicodeString FSeriesName;
	System::Classes::TList* FParentCharts;
	int __fastcall GetCount(void);
	void __fastcall SetCount(const int Value);
	void __fastcall SetChartValues(Lmdchartvaluescollection::TLMDChartValuesColl* const Value);
	
protected:
	virtual Lmdchartvaluescollection::TLMDChartValuesType __fastcall GetChartValuesType(void) = 0 ;
	virtual Lmdchartvaluesbase::TLMDChartValuesClass __fastcall GetChartValuesClass(void) = 0 ;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDCustomChartSeries(System::Classes::TComponent* AMainOwner);
	__fastcall virtual ~TLMDCustomChartSeries(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall RefreshChartValuesSettings(Lmdchartvaluesbase::TLMDChartValuesBase* AValues);
	void __fastcall AddParentChart(Vcl::Controls::TControl* AChart);
	void __fastcall RemoveParentChart(Vcl::Controls::TControl* AChart);
	void __fastcall RefreshParentCharts(void);
	__property System::Classes::TList* ParentCharts = {read=FParentCharts};
	
__published:
	__property About = {default=0};
	__property Lmdchartvaluescollection::TLMDChartValuesColl* ChartValuesCollection = {read=FChartValuesColl, write=SetChartValues};
	__property System::UnicodeString SeriesName = {read=FSeriesName, write=FSeriesName};
	__property int Count = {read=GetCount, write=SetCount, nodefault};
};


class PASCALIMPLEMENTATION TLMDChartSeries : public TLMDCustomChartSeries
{
	typedef TLMDCustomChartSeries inherited;
	
protected:
	virtual Lmdchartvaluescollection::TLMDChartValuesType __fastcall GetChartValuesType(void);
	virtual Lmdchartvaluesbase::TLMDChartValuesClass __fastcall GetChartValuesClass(void);
	
public:
	__fastcall virtual TLMDChartSeries(System::Classes::TComponent* AMainOwner);
public:
	/* TLMDCustomChartSeries.Destroy */ inline __fastcall virtual ~TLMDChartSeries(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartseries */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTSERIES)
using namespace Lmdchartseries;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartseriesHPP
