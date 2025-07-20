// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSmith.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeesmithHPP
#define Vcltee_TeesmithHPP

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
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.Series.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeePolar.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teesmith
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSmithSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TSmithSeries : public Vcltee::Teepolar::TCustomCircledSeries
{
	typedef Vcltee::Teepolar::TCustomCircledSeries inherited;
	
private:
	System::UnicodeString FImagSymbol;
	bool IFirstNonNull;
	int OldX;
	int OldY;
	Vcltee::Teengine::TChartValueList* __fastcall GetResistanceValues();
	Vcltee::Teengine::TChartValueList* __fastcall GetReactance();
	Vcltee::Tecanvas::TTeePen* __fastcall GetCPen();
	Vcltee::Tecanvas::TTeePen* __fastcall GetRPen();
	bool __fastcall GetCLabels();
	bool __fastcall GetRLabels();
	void __fastcall SetResistanceValues(Vcltee::Teengine::TChartValueList* Value);
	void __fastcall SetReactance(Vcltee::Teengine::TChartValueList* Value);
	void __fastcall SetRPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetCPen(Vcltee::Tecanvas::TTeePen* const Value);
	void __fastcall SetCLabels(const bool Value);
	void __fastcall SetRLabels(const bool Value);
	Vcltee::Tecanvas::TTeeFont* __fastcall GetCLabelsFont();
	Vcltee::Tecanvas::TTeeFont* __fastcall GetRLabelsFont();
	void __fastcall SetCLabelsFont(Vcltee::Tecanvas::TTeeFont* const Value);
	void __fastcall SetRLabelsFont(Vcltee::Tecanvas::TTeeFont* const Value);
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
	int __fastcall AddPoint(const double Resist, const double React, const System::UnicodeString ALabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
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
	__property Vcltee::Tecanvas::TTeePen* CCirclePen = {read=GetCPen, write=SetCPen};
	__property CircleBackColor = {default=536870912};
	__property CircleGradient;
	__property CirclePen;
	__property bool CLabels = {read=GetCLabels, write=SetCLabels, nodefault};
	__property Vcltee::Tecanvas::TTeeFont* CLabelsFont = {read=GetCLabelsFont, write=SetCLabelsFont};
	__property ColorEachLine = {default=1};
	__property ColorEachPoint = {default=0};
	__property DrawStyle = {default=0};
	__property System::UnicodeString ImagSymbol = {read=FImagSymbol, write=SetImagSymbol};
	__property Vcltee::Teengine::TChartValueList* ResistanceValues = {read=GetResistanceValues, write=SetResistanceValues};
	__property Vcltee::Teengine::TChartValueList* ReactanceValues = {read=GetReactance, write=SetReactance};
	__property Pen;
	__property Pointer;
	__property PointerBehind = {default=0};
	__property Vcltee::Tecanvas::TTeePen* RCirclePen = {read=GetRPen, write=SetRPen};
	__property bool RLabels = {read=GetRLabels, write=SetRLabels, nodefault};
	__property Vcltee::Tecanvas::TTeeFont* RLabelsFont = {read=GetRLabelsFont, write=SetRLabelsFont};
	__property TreatNulls = {default=0};
	__property OnGetPointerStyle;
public:
	/* TCustomCircledSeries.Destroy */ inline __fastcall virtual ~TSmithSeries() { }
	
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Clicked(const float X, const float Y){ return Vcltee::Teengine::TChartSeries::Clicked(X, Y); }
	inline int __fastcall  Clicked(const System::Types::TPoint &P){ return Vcltee::Teengine::TChartSeries::Clicked(P); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teesmith */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESMITH)
using namespace Vcltee::Teesmith;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeesmithHPP
