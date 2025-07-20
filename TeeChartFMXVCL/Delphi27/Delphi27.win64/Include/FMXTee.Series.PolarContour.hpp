// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.PolarContour.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Series_PolarcontourHPP
#define Fmxtee_Series_PolarcontourHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.Polar.hpp>
#include <FMXTee.Series.Surface.hpp>
#include <FMXTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Polarcontour
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPolarContourSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPolarContourSeries : public Fmxtee::Series::Polar::TPolarSeries
{
	typedef Fmxtee::Series::Polar::TPolarSeries inherited;
	
private:
	Fmxtee::Series::Surface::TContourSeries* FContour;
	bool __fastcall IsLevelsStored();
	void __fastcall SetLevels(Fmxtee::Series::Surface::TContourLevels* const Value);
	Fmxtee::Series::Surface::TContourLevels* __fastcall GetLevels();
	bool __fastcall GetAutomaticLevels();
	void __fastcall SetAutomaticLevels(const bool Value);
	int __fastcall GetNumLevels();
	void __fastcall SetNumLevels(const int Value);
	
protected:
	virtual void __fastcall AddValues(Fmxtee::Engine::TChartSeries* Source);
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Fmxtee::Engine::TCustomAxisPanel* const Value);
	
public:
	__fastcall virtual TPolarContourSeries(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TPolarContourSeries();
	virtual void __fastcall Clear();
	int __fastcall AddXYZ(int X, const double Y, int Z);
	int __fastcall AddNullXZ(int X, int Z);
	virtual double __fastcall MaxXValue();
	virtual double __fastcall MinXValue();
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	__property Fmxtee::Series::Surface::TContourSeries* Contour = {read=FContour};
	
__published:
	__property bool AutomaticLevels = {read=GetAutomaticLevels, write=SetAutomaticLevels, default=1};
	__property Fmxtee::Series::Surface::TContourLevels* Levels = {read=GetLevels, write=SetLevels, stored=IsLevelsStored};
	__property int NumLevels = {read=GetNumLevels, write=SetNumLevels, default=10};
	__property PointerBehind = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Polarcontour */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_POLARCONTOUR)
using namespace Fmxtee::Series::Polarcontour;
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
#endif	// Fmxtee_Series_PolarcontourHPP
