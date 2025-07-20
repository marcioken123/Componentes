// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.HighLowLine.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Series_HighlowlineHPP
#define Fmxtee_Series_HighlowlineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <System.Types.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Series.Error.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Highlowline
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS THighLowLineSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION THighLowLineSeries : public Fmxtee::Series::Error::TBaseHighLowSeries
{
	typedef Fmxtee::Series::Error::TBaseHighLowSeries inherited;
	
private:
	Fmxtee::Engine::TSeriesPointer* FHighPointer;
	Fmxtee::Engine::TSeriesPointer* FLowPointer;
	void __fastcall SetHighPointer(Fmxtee::Engine::TSeriesPointer* const Value);
	void __fastcall SetLowPointer(Fmxtee::Engine::TSeriesPointer* const Value);
	void __fastcall ChangePen(System::TObject* Sender);
	
protected:
	virtual void __fastcall AssignFormatting(Fmxtee::Engine::TChartSeries* Source);
	virtual void __fastcall CalcHorizMargins(int &LeftMargin, int &RightMargin);
	virtual void __fastcall CalcVerticalMargins(int &TopMargin, int &BottomMargin);
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	DYNAMIC void __fastcall PrepareForGallery();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	virtual void __fastcall SetSeriesColor(System::Uitypes::TAlphaColor AColor);
	
public:
	__fastcall virtual THighLowLineSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~THighLowLineSeries();
	virtual int __fastcall Clicked(int x, int y)/* overload */;
	
__published:
	__property Fmxtee::Engine::TSeriesPointer* HighPointer = {read=FHighPointer, write=SetHighPointer};
	__property Fmxtee::Engine::TSeriesPointer* LowPointer = {read=FLowPointer, write=SetLowPointer};
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Highlowline */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_HIGHLOWLINE)
using namespace Fmxtee::Series::Highlowline;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES)
using namespace Fmxtee::Series;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Series_HighlowlineHPP
