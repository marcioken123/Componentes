// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.BigCandl.pas' rev: 34.00 (Windows)

#ifndef Vcltee_BigcandlHPP
#define Vcltee_BigcandlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.CandleCh.hpp>
#include <VCLTee.OHLChart.hpp>
#include <VCLTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Bigcandl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBigCandleSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBigCandleSeries : public Vcltee::Candlech::TCandleSeries
{
	typedef Vcltee::Candlech::TCandleSeries inherited;
	
private:
	int FHorizGap;
	int FVertGap;
	
protected:
	virtual void __fastcall DrawMark(int ValueIndex, const System::UnicodeString St, Vcltee::Teengine::TSeriesMarkPosition* APosition);
	void __fastcall SetHorizGap(int Value);
	void __fastcall SetVertGap(int Value);
	
public:
	__fastcall virtual TBigCandleSeries(System::Classes::TComponent* AOwner);
	
__published:
	__property int HorizGap = {read=FHorizGap, write=SetHorizGap, nodefault};
	__property int VertGap = {read=FVertGap, write=SetVertGap, nodefault};
public:
	/* TCandleSeries.Destroy */ inline __fastcall virtual ~TBigCandleSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Bigcandl */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_BIGCANDL)
using namespace Vcltee::Bigcandl;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_BigcandlHPP
