// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartScaleBreak.pas' rev: 31.00 (Windows)

#ifndef LmdchartscalebreakHPP
#define LmdchartscalebreakHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <System.Math.hpp>
#include <System.Types.hpp>
#include <System.Variants.hpp>
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartData.hpp>
#include <LMDChartUtils.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartscalebreak
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartScaleBreak;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDScaleBreakStyle2D : unsigned char { sbt2DNone, sbt2DStraight, sbt2DWave, sbt2DRagged };

enum DECLSPEC_DENUM TLMDScaleBreakStyle3D : unsigned char { sbt3DNone, sbt3DEmpty, sbt3DFill };

enum DECLSPEC_DENUM TLMDScaleBreakAppearance : unsigned char { sbaNone, sbaPositive, sbaNegative, sbaBoth };

class PASCALIMPLEMENTATION TLMDChartScaleBreak : public Lmdchartpersistent::TLMDChartPersistent
{
	typedef Lmdchartpersistent::TLMDChartPersistent inherited;
	
private:
	bool FEnabled;
	bool FAutoAppearance;
	TLMDScaleBreakAppearance FAppearance;
	bool FAutoLimits;
	System::Variant FPositiveLowLimit;
	System::Variant FPositiveHighLimit;
	System::Variant FNegativeLowLimit;
	System::Variant FNegativeHighLimit;
	TLMDScaleBreakStyle2D FStyle2D;
	TLMDScaleBreakStyle3D FStyle3D;
	System::Uitypes::TColor FColor;
	int FSpacing;
	Lmdchartdata::TLMDChartData* FData;
	void __fastcall SetEnabled(bool Value);
	void __fastcall SetColor(System::Uitypes::TColor Value);
	void __fastcall SetSpacing(int Value);
	void __fastcall SetStyle2D(TLMDScaleBreakStyle2D Value);
	void __fastcall SetStyle3D(TLMDScaleBreakStyle3D Value);
	void __fastcall SetAutoAppearance(bool Value);
	void __fastcall SetAppearance(TLMDScaleBreakAppearance Value);
	void __fastcall SetAutoLimits(bool Value);
	void __fastcall SetPositiveLowLimit(const System::Variant &Value);
	void __fastcall SetPositiveHighLimit(const System::Variant &Value);
	void __fastcall SetNegativeLowLimit(const System::Variant &Value);
	void __fastcall SetNegativeHighLimit(const System::Variant &Value);
	
public:
	bool __fastcall ProcessAutoAppearance(Lmdchartdata::TLMDChartData* FData);
	void __fastcall ProcessAutoLimits(Lmdchartdata::TLMDChartData* FData);
	__fastcall virtual TLMDChartScaleBreak(System::Classes::TPersistent* AMainOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* ASource);
	void __fastcall SetData(Lmdchartdata::TLMDChartData* AData);
	void __fastcall RenderBreak(Vcl::Graphics::TCanvas* ATarget, const System::Types::TPoint &AStart, const System::Types::TPoint &AEnd, bool IsVertical, bool IsPositive);
	
__published:
	__property bool Enabled = {read=FEnabled, write=SetEnabled, default=0};
	__property System::Uitypes::TColor Color = {read=FColor, write=SetColor, default=65535};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=3};
	__property TLMDScaleBreakStyle2D Style2D = {read=FStyle2D, write=SetStyle2D, default=2};
	__property TLMDScaleBreakStyle3D Style3D = {read=FStyle3D, write=SetStyle3D, default=1};
	__property bool AutoAppearance = {read=FAutoAppearance, write=SetAutoAppearance, default=1};
	__property TLMDScaleBreakAppearance Appearance = {read=FAppearance, write=SetAppearance, default=0};
	__property bool AutoLimits = {read=FAutoLimits, write=SetAutoLimits, default=1};
	__property System::Variant PositiveLowLimit = {read=FPositiveLowLimit, write=SetPositiveLowLimit};
	__property System::Variant PositiveHighLimit = {read=FPositiveHighLimit, write=SetPositiveHighLimit};
	__property System::Variant NegativeLowLimit = {read=FNegativeLowLimit, write=SetNegativeLowLimit};
	__property System::Variant NegativeHighLimit = {read=FNegativeHighLimit, write=SetNegativeHighLimit};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDChartScaleBreak(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartscalebreak */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTSCALEBREAK)
using namespace Lmdchartscalebreak;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartscalebreakHPP
