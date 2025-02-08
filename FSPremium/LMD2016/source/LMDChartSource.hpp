// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartSource.pas' rev: 31.00 (Windows)

#ifndef LmdchartsourceHPP
#define LmdchartsourceHPP

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
#include <LMDChartValuesCollection.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartsource
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomChartSource;
class DELPHICLASS TLMDXChartSource;
class DELPHICLASS TLMDXYChartSource;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDChartSourceType : unsigned char { cstXSource, cstXYSource, cstXYZSource, cstOHLCSource };

class PASCALIMPLEMENTATION TLMDCustomChartSource : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdchartseries::TLMDCustomChartSeries* FSeries;
	void __fastcall SetSeries(Lmdchartseries::TLMDCustomChartSeries* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall EnsureChartValuesExist(Lmdchartseries::TLMDCustomChartSeries* ASeries, System::UnicodeString AName, Lmdchartvaluesbase::TLMDChartValueType AValType);
	
public:
	virtual bool __fastcall IsCompatibleWithSeries(Lmdchartseries::TLMDCustomChartSeries* ASeries) = 0 ;
	virtual void __fastcall MakeSeriesCompatible(Lmdchartseries::TLMDCustomChartSeries* ASeries) = 0 ;
	
__published:
	__property Lmdchartseries::TLMDCustomChartSeries* Series = {read=FSeries, write=SetSeries};
public:
	/* TComponent.Create */ inline __fastcall virtual TLMDCustomChartSource(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDCustomChartSource(void) { }
	
};


class PASCALIMPLEMENTATION TLMDXChartSource : public TLMDCustomChartSource
{
	typedef TLMDCustomChartSource inherited;
	
private:
	Lmdchartvaluesbase::TLMDChartValuesBase* __fastcall GetXLabels(void);
	Lmdchartvaluesbase::TLMDChartValuesBase* __fastcall GetXValues(void);
	
public:
	virtual bool __fastcall IsCompatibleWithSeries(Lmdchartseries::TLMDCustomChartSeries* ASeries);
	virtual void __fastcall MakeSeriesCompatible(Lmdchartseries::TLMDCustomChartSeries* ASeries);
	
__published:
	__property Lmdchartvaluesbase::TLMDChartValuesBase* XLabels = {read=GetXLabels};
	__property Lmdchartvaluesbase::TLMDChartValuesBase* XValues = {read=GetXValues};
public:
	/* TComponent.Create */ inline __fastcall virtual TLMDXChartSource(System::Classes::TComponent* AOwner) : TLMDCustomChartSource(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDXChartSource(void) { }
	
};


class PASCALIMPLEMENTATION TLMDXYChartSource : public TLMDXChartSource
{
	typedef TLMDXChartSource inherited;
	
private:
	Lmdchartvaluesbase::TLMDChartValuesBase* __fastcall GetYLabels(void);
	Lmdchartvaluesbase::TLMDChartValuesBase* __fastcall GetYValues(void);
	
public:
	virtual bool __fastcall IsCompatibleWithSeries(Lmdchartseries::TLMDCustomChartSeries* ASeries);
	virtual void __fastcall MakeSeriesCompatible(Lmdchartseries::TLMDCustomChartSeries* ASeries);
	
__published:
	__property Lmdchartvaluesbase::TLMDChartValuesBase* YValues = {read=GetYValues};
	__property Lmdchartvaluesbase::TLMDChartValuesBase* YLabels = {read=GetYLabels};
public:
	/* TComponent.Create */ inline __fastcall virtual TLMDXYChartSource(System::Classes::TComponent* AOwner) : TLMDXChartSource(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDXYChartSource(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define CVN_XVALUES L"X Values"
#define CVN_YVALUES L"Y Values"
#define CVN_ZVALUES L"Z Values"
#define CVN_XLABELS L"X Labels"
#define CVN_YLABELS L"Y Labels"
#define CVN_ZLABELS L"Z Labels"
}	/* namespace Lmdchartsource */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTSOURCE)
using namespace Lmdchartsource;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartsourceHPP
