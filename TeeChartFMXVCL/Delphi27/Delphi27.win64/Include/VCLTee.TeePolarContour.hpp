// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeePolarContour.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeepolarcontourHPP
#define Vcltee_TeepolarcontourHPP

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
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeePolar.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.Series.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teepolarcontour
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TPolarContourSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TPolarContourSeries : public Vcltee::Teepolar::TPolarSeries
{
	typedef Vcltee::Teepolar::TPolarSeries inherited;
	
private:
	Vcltee::Teesurfa::TContourSeries* FContour;
	bool __fastcall IsLevelsStored();
	void __fastcall SetLevels(Vcltee::Teesurfa::TContourLevels* const Value);
	Vcltee::Teesurfa::TContourLevels* __fastcall GetLevels();
	bool __fastcall GetAutomaticLevels();
	void __fastcall SetAutomaticLevels(const bool Value);
	int __fastcall GetNumLevels();
	void __fastcall SetNumLevels(const int Value);
	
protected:
	virtual void __fastcall AddValues(Vcltee::Teengine::TChartSeries* Source);
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall DrawAllValues();
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall SetParentChart(Vcltee::Teengine::TCustomAxisPanel* const Value);
	
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
	__property Vcltee::Teesurfa::TContourSeries* Contour = {read=FContour};
	
__published:
	__property bool AutomaticLevels = {read=GetAutomaticLevels, write=SetAutomaticLevels, default=1};
	__property Vcltee::Teesurfa::TContourLevels* Levels = {read=GetLevels, write=SetLevels, stored=IsLevelsStored};
	__property int NumLevels = {read=GetNumLevels, write=SetNumLevels, default=10};
	__property PointerBehind = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teepolarcontour */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEPOLARCONTOUR)
using namespace Vcltee::Teepolarcontour;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeepolarcontourHPP
