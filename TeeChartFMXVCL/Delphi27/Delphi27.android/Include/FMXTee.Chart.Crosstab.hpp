// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Chart.Crosstab.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Chart_CrosstabHPP
#define Fmxtee_Chart_CrosstabHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Data.DB.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.DBChart.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Canvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Chart
{
namespace Crosstab
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCrossTabSource;
class DELPHICLASS TDBCrossTabSource;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TGroupFormula : unsigned char { gfCount, gfSum, gfMin, gfMax };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TCrossTabSource : public Fmxtee::Dbchart::TTeeSeriesDBSource
{
	typedef Fmxtee::Dbchart::TTeeSeriesDBSource inherited;
	
private:
	bool FCase;
	TGroupFormula FFormula;
	System::UnicodeString FGroup;
	bool FHideSeries;
	System::UnicodeString FLabel;
	System::UnicodeString FValue;
	Fmxtee::Engine::TCustomAxisPanel* IParentChart;
	Fmxtee::Engine::TCustomSeriesList* __fastcall DetailList();
	void __fastcall RemoveSeries();
	void __fastcall SetCase(const bool Value);
	void __fastcall SetFormula(const TGroupFormula Value);
	void __fastcall SetGroup(const System::UnicodeString Value);
	void __fastcall SetIParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	void __fastcall SetLabel(const System::UnicodeString Value);
	void __fastcall SetValue(const System::UnicodeString Value);
	
protected:
	Fmxtee::Engine::TChartSeries* __fastcall FindGroup(const System::UnicodeString AGroup);
	void __fastcall InitLoop();
	Fmxtee::Engine::TChartSeries* __fastcall LocateSeries(const System::UnicodeString ATitle);
	void __fastcall NewPoint(Fmxtee::Engine::TChartSeries* const ASeries, int AIndex, const double AValue, const System::UnicodeString ALabel);
	Fmxtee::Engine::TChartSeries* __fastcall NewSeries();
	virtual void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* const Value);
	void __fastcall TeeEvent(Fmxtee::Procs::TTeeEvent* Event);
	
public:
	bool UseDetail;
	__fastcall virtual TCrossTabSource(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCrossTabSource();
	
__published:
	__property Active = {default=0};
	__property bool CaseSensitive = {read=FCase, write=SetCase, default=1};
	__property TGroupFormula Formula = {read=FFormula, write=SetFormula, default=1};
	__property System::UnicodeString GroupField = {read=FGroup, write=SetGroup};
	__property bool HideSeries = {read=FHideSeries, write=FHideSeries, default=1};
	__property System::UnicodeString LabelField = {read=FLabel, write=SetLabel};
	__property Series;
	__property System::UnicodeString ValueField = {read=FValue, write=SetValue};
private:
	void *__ITeeEventListener;	// Fmxtee::Procs::ITeeEventListener 
	
public:
	operator Fmxtee::Procs::ITeeEventListener*(void) { return (Fmxtee::Procs::ITeeEventListener*)&__ITeeEventListener; }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDBCrossTabSource : public TCrossTabSource
{
	typedef TCrossTabSource inherited;
	
private:
	Data::Db::TDataSet* FDataSet;
	bool LoadingDS;
	Fmxtee::Dbchart::TDBChartDataSource* ISource;
	void __fastcall DataSourceCheckDataSet(Data::Db::TDataSet* const ADataSet);
	void __fastcall DataSourceCloseDataSet(Data::Db::TDataSet* const ADataSet);
	void __fastcall LoadDataSet();
	void __fastcall SetDataSet(Data::Db::TDataSet* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetActive(const bool Value);
	
public:
	__fastcall virtual ~TDBCrossTabSource();
	__classmethod virtual bool __fastcall Available(Fmxtee::Engine::TCustomAxisPanel* AChart);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::Classes::TComponentClass __fastcall Editor();
	__classmethod virtual bool __fastcall HasSeries(Fmxtee::Engine::TChartSeries* ASeries);
	virtual void __fastcall Load();
	
__published:
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
public:
	/* TCrossTabSource.Create */ inline __fastcall virtual TDBCrossTabSource(System::Classes::TComponent* AOwner) : TCrossTabSource(AOwner) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall FillDataSet(Data::Db::TDataSet* const ADataSet, Fmxtee::Engine::TChartSeries* const ASeries, const System::UnicodeString AGroupField, const System::UnicodeString ALabelField, const System::UnicodeString AValueField, const TGroupFormula GroupFormula);
}	/* namespace Crosstab */
}	/* namespace Chart */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_CHART_CROSSTAB)
using namespace Fmxtee::Chart::Crosstab;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_CHART)
using namespace Fmxtee::Chart;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Chart_CrosstabHPP
