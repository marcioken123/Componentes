// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.Bar3D.pas' rev: 34.00 (Windows)

#ifndef Vcltee_Bar3dHPP
#define Vcltee_Bar3dHPP

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
#include <VCLTee.Series.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Bar3d
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TBar3DSeries;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TBar3DSeries : public Vcltee::Series::TBarSeries
{
	typedef Vcltee::Series::TBarSeries inherited;
	
private:
	Vcltee::Teengine::TChartValueList* FOffsetValues;
	
protected:
	DYNAMIC void __fastcall AddSampleValues(int NumValues, bool OnlyMandatory = false);
	void __fastcall SetOffsetValues(Vcltee::Teengine::TChartValueList* Value);
	__classmethod virtual bool __fastcall SubGalleryStack();
	
public:
	__fastcall virtual TBar3DSeries(System::Classes::TComponent* AOwner);
	HIDESBASE int __fastcall AddBar(const double AX, const double AY, const double AOffset, const System::UnicodeString AXLabel = System::UnicodeString(), System::Uitypes::TColor AColor = (System::Uitypes::TColor)(0x20000000));
	virtual double __fastcall GetOriginValue(int ValueIndex);
	virtual double __fastcall MaxYValue();
	virtual double __fastcall MinYValue();
	virtual double __fastcall PointOrigin(int ValueIndex, bool SumAll);
	
__published:
	__property Vcltee::Teengine::TChartValueList* OffsetValues = {read=FOffsetValues, write=SetOffsetValues};
public:
	/* TCustomBarSeries.Destroy */ inline __fastcall virtual ~TBar3DSeries() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Bar3d */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_BAR3D)
using namespace Vcltee::Bar3d;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_Bar3dHPP
