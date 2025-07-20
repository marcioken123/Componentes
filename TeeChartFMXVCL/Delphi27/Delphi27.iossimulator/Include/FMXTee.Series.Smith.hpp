// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Series.Smith.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Series_SmithHPP
#define Fmxtee_Series_SmithHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <FMX.Types.hpp>
#include <System.Types.hpp>
#include <FMX.Graphics.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Series.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Series.Polar.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Series
{
namespace Smith
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSmithSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSmithSeries : public Fmxtee::Series::Polar::TCustomCircledSeries
{
	typedef Fmxtee::Series::Polar::TCustomCircledSeries inherited;
	
private:
	System::UnicodeString FImagSymbol;
	bool IFirstNonNull;
	int OldX;
	int OldY;
	Fmxtee::Engine::TChartValueList* __fastcall GetResistanceValues();
	Fmxtee::Engine::TChartValueList* __fastcall GetReactance();
	Fmxtee::Canvas::TTeePen* __fastcall GetCPen();
	Fmxtee::Canvas::TTeePen* __fastcall GetRPen();
	bool __fastcall GetCLabels();
	bool __fastcall GetRLabels();
	void __fastcall SetResistanceValues(Fmxtee::Engine::TChartValueList* Value);
	void __fastcall SetReactance(Fmxtee::Engine::TChartValueList* Value);
	void __fastcall SetRPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetCPen(Fmxtee::Canvas::TTeePen* const Value);
	void __fastcall SetCLabels(const bool Value);
	void __fastcall SetRLabels(const bool Value);
	Fmxtee::Canvas::TTeeFont* __fastcall GetCLabelsFont();
	Fmxtee::Canvas::TTeeFont* __fastcall GetRLabelsFont();
	void __fastcall SetCLabelsFont(Fmxtee::Canvas::TTeeFont* const Value);
	void __fastcall SetRLabelsFont(Fmxtee::Canvas::TTeeFont* const Value);
	void __fastcall SetImagSymbol(const System::UnicodeString Value);
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	virtual void __fastcall DoBeforeDrawValues();
	virtual void __fastcall DrawValue(int ValueIndex);
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	System::UnicodeString __fastcall GetXCircleLabel(const double Reactance);
	void __fastcall LinePrepareCanvas(int ValueIndex);
	DYNAMIC void __fastcall PrepareForGallery();
	
public:
	__fastcall virtual TSmithSeries(System::Classes::TComponent* AOwner);
	int __fastcall AddPoint(const double Resist, const double React, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TAlphaColor AColor = (System::Uitypes::TAlphaColor)(0xffffff));
	virtual int __fastcall CalcXPos(int ValueIndex);
	virtual int __fastcall CalcYPos(int ValueIndex);
	virtual int __fastcall Clicked(int X, int Y)/* overload */;
	void __fastcall DrawRCircle(const double Value, int Z, bool ShowLabel = true);
	void __fastcall DrawXCircle(const double Value, int Z, bool ShowLabel = true);
	void __fastcall PosToZ(int X, int Y, /* out */ double &Resist, /* out */ double &React);
	void __fastcall ZToPos(const int ValueIndex, /* out */ int &X, /* out */ int &Y)/* overload */;
	void __fastcall ZToPos(const double Resist, const double React, /* out */ int &X, /* out */ int &Y)/* overload */;
	void __fastcall ZToPos(const double Resist, const double React, int AXRadius, int AYRadius, /* out */ int &X, /* out */ int &Y)/* overload */;
	
__published:
	__property Active = {default=1};
	__property Fmxtee::Canvas::TTeePen* CCirclePen = {read=GetCPen, write=SetCPen};
	__property CircleBackColor = {default=16777215};
	__property CircleGradient;
	__property CirclePen;
	__property bool CLabels = {read=GetCLabels, write=SetCLabels, nodefault};
	__property Fmxtee::Canvas::TTeeFont* CLabelsFont = {read=GetCLabelsFont, write=SetCLabelsFont};
	__property ColorEachLine = {default=1};
	__property ColorEachPoint = {default=0};
	__property DrawStyle = {default=0};
	__property System::UnicodeString ImagSymbol = {read=FImagSymbol, write=SetImagSymbol};
	__property Fmxtee::Engine::TChartValueList* ResistanceValues = {read=GetResistanceValues, write=SetResistanceValues};
	__property Fmxtee::Engine::TChartValueList* ReactanceValues = {read=GetReactance, write=SetReactance};
	__property Pen;
	__property Pointer;
	__property PointerBehind = {default=0};
	__property Fmxtee::Canvas::TTeePen* RCirclePen = {read=GetRPen, write=SetRPen};
	__property bool RLabels = {read=GetRLabels, write=SetRLabels, nodefault};
	__property Fmxtee::Canvas::TTeeFont* RLabelsFont = {read=GetRLabelsFont, write=SetRLabelsFont};
	__property TreatNulls = {default=0};
	__property OnGetPointerStyle;
public:
	/* TCustomCircledSeries.Destroy */ inline __fastcall virtual ~TSmithSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Fmxtee::Engine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPointF &P){ return Fmxtee::Engine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Smith */
}	/* namespace Series */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_SERIES_SMITH)
using namespace Fmxtee::Series::Smith;
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
#endif	// Fmxtee_Series_SmithHPP
