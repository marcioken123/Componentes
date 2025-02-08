// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBChartSeries.pas' rev: 31.00 (Windows)

#ifndef LmddbchartseriesHPP
#define LmddbchartseriesHPP

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
#include <Data.DB.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <LMDChartSeries.hpp>
#include <LMDDBChartValues.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartValuesBase.hpp>
#include <LMDChartValuesCollection.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbchartseries
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBChartSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDBChartSeries : public Lmdchartseries::TLMDCustomChartSeries
{
	typedef Lmdchartseries::TLMDCustomChartSeries inherited;
	
private:
	Data::Db::TDataSet* FDataSet;
	void __fastcall SetDataSet(Data::Db::TDataSet* const Value);
	
protected:
	virtual Lmdchartvaluescollection::TLMDChartValuesType __fastcall GetChartValuesType(void);
	virtual Lmdchartvaluesbase::TLMDChartValuesClass __fastcall GetChartValuesClass(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDDBChartSeries(System::Classes::TComponent* AMainOwner);
	virtual void __fastcall RefreshChartValuesSettings(Lmdchartvaluesbase::TLMDChartValuesBase* AValues);
	void __fastcall RefreshAllChartValuesSettings(void);
	
__published:
	__property Data::Db::TDataSet* DataSet = {read=FDataSet, write=SetDataSet};
public:
	/* TLMDCustomChartSeries.Destroy */ inline __fastcall virtual ~TLMDDBChartSeries(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbchartseries */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBCHARTSERIES)
using namespace Lmddbchartseries;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbchartseriesHPP
