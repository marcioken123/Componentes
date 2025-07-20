// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeCustomLegendTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeecustomlegendtoolHPP
#define Vcltee_TeecustomlegendtoolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Grids.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <System.Types.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeeTools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teecustomlegendtool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomLegendTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomLegendTool : public Vcltee::Teetools::TRectangleTool
{
	typedef Vcltee::Teetools::TRectangleTool inherited;
	
private:
	Vcl::Grids::TStringGrid* FGrid;
	void __fastcall SetGrid(Vcl::Grids::TStringGrid* const Value);
	
protected:
	virtual void __fastcall DoDrawText(Vcltee::Teengine::TCustomAxisPanel* const AParent)/* overload */;
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TCustomLegendTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomLegendTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Vcl::Grids::TStringGrid* Grid = {read=FGrid, write=SetGrid};
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DoDrawText(){ Vcltee::Teetools::TAnnotationTool::DoDrawText(); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teecustomlegendtool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECUSTOMLEGENDTOOL)
using namespace Vcltee::Teecustomlegendtool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeecustomlegendtoolHPP
