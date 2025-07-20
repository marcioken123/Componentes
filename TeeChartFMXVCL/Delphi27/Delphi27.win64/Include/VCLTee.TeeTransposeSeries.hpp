// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTransposeSeries.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetransposeseriesHPP
#define Vcltee_TeetransposeseriesHPP

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
#include <System.Math.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetransposeseries
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTransposeSeriesTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TTransposeSeriesTool : public Vcltee::Teengine::TTeeCustomTool
{
	typedef Vcltee::Teengine::TTeeCustomTool inherited;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	void __fastcall Transpose();
public:
	/* TCustomChartElement.Create */ inline __fastcall virtual TTransposeSeriesTool(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeCustomTool(AOwner) { }
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TTransposeSeriesTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teetransposeseries */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETRANSPOSESERIES)
using namespace Vcltee::Teetransposeseries;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetransposeseriesHPP
