// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.TransposeSeries.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_Tools_TransposeseriesHPP
#define Fmxtee_Tools_TransposeseriesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Math.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Transposeseries
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTransposeSeriesTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTransposeSeriesTool : public Fmxtee::Engine::TTeeCustomTool
{
	typedef Fmxtee::Engine::TTeeCustomTool inherited;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	void __fastcall Transpose();
public:
	/* TCustomChartElement.Create */ inline __fastcall virtual TTransposeSeriesTool(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeCustomTool(AOwner) { }
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TTransposeSeriesTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Transposeseries */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_TRANSPOSESERIES)
using namespace Fmxtee::Tools::Transposeseries;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS)
using namespace Fmxtee::Tools;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_Tools_TransposeseriesHPP
