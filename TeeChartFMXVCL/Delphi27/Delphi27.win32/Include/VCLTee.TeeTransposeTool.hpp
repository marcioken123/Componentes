// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeTransposeTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeetransposetoolHPP
#define Vcltee_TeetransposetoolHPP

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
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeSurfa.hpp>
#include <VCLTee.TeCanvas.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teetransposetool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TGridTransposeTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TGridTransposeTool : public Vcltee::Teengine::TTeeCustomTool
{
	typedef Vcltee::Teengine::TTeeCustomTool inherited;
	
private:
	Vcltee::Teesurfa::TCustom3DGridSeries* FSeries;
	
protected:
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	void __fastcall Transpose();
	
__published:
	__property Active = {default=1};
	__property Vcltee::Teesurfa::TCustom3DGridSeries* Series = {read=FSeries, write=FSeries};
public:
	/* TCustomChartElement.Create */ inline __fastcall virtual TGridTransposeTool(System::Classes::TComponent* AOwner) : Vcltee::Teengine::TTeeCustomTool(AOwner) { }
	/* TCustomChartElement.Destroy */ inline __fastcall virtual ~TGridTransposeTool() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teetransposetool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEETRANSPOSETOOL)
using namespace Vcltee::Teetransposetool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeetransposetoolHPP
