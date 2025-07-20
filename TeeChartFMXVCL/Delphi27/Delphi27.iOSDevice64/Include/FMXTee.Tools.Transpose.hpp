// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.Transpose.pas' rev: 34.00 (iOS)

#ifndef Fmxtee_Tools_TransposeHPP
#define Fmxtee_Tools_TransposeHPP

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
#include <System.UITypes.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Series.Surface.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Transpose
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGridTransposeTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGridTransposeTool : public Fmxtee::Engine::TTeeCustomTool
{
	typedef Fmxtee::Engine::TTeeCustomTool inherited;
	
private:
	Fmxtee::Series::Surface::TCustom3DGridSeries* FSeries;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	void __fastcall Transpose();
	
__published:
	__property Active = {default=1};
	__property Fmxtee::Series::Surface::TCustom3DGridSeries* Series = {read=FSeries, write=FSeries};
public:
	/* TCustomChartElement.Create */ inline __fastcall virtual TGridTransposeTool(System::Classes::TComponent* AOwner) : Fmxtee::Engine::TTeeCustomTool(AOwner) { }
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TGridTransposeTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Transpose */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_TRANSPOSE)
using namespace Fmxtee::Tools::Transpose;
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
#endif	// Fmxtee_Tools_TransposeHPP
