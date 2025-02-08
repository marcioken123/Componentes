// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDChartCTLine.pas' rev: 31.00 (Windows)

#ifndef LmdchartctlineHPP
#define LmdchartctlineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Variants.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <System.Math.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDXML.hpp>
#include <LMDXMLNodeNames.hpp>
#include <LMDChartData.hpp>
#include <LMDChartTypes.hpp>
#include <LMDChartPersistent.hpp>
#include <LMDChartUtils.hpp>
#include <LMDChartAxis.hpp>
#include <LMDChartMarker.hpp>
#include <LMDChartLine.hpp>
#include <LMDChartLabel.hpp>
#include <LMDChartRectangular2DCT.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdchartctline
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChartCTLine;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChartCTLine : public Lmdchartrectangular2dct::TLMDChartRectangular2DCT
{
	typedef Lmdchartrectangular2dct::TLMDChartRectangular2DCT inherited;
	
protected:
	virtual void __fastcall DrawChartElements(Vcl::Graphics::TCanvas* ATarget, Lmdchartdata::TLMDChartData* AValues, int ASeriesIndex, Lmdchartrectangular2dct::TLMDChartPoints AElementsPoints, int AStartX, int AEndX, int AStartY, int AEndY);
public:
	/* TLMDChartRectangular2DCT.Destroy */ inline __fastcall virtual ~TLMDChartCTLine(void) { }
	/* TLMDChartRectangular2DCT.Create */ inline __fastcall virtual TLMDChartCTLine(System::Classes::TComponent* AMainOwner) : Lmdchartrectangular2dct::TLMDChartRectangular2DCT(AMainOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdchartctline */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCHARTCTLINE)
using namespace Lmdchartctline;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdchartctlineHPP
