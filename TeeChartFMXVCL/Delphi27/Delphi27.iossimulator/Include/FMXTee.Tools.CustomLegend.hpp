// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.CustomLegend.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Tools_CustomlegendHPP
#define Fmxtee_Tools_CustomlegendHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <FMX.Types.hpp>
#include <FMX.Grid.hpp>
#include <System.Types.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Tools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Customlegend
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomLegendTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TCustomLegendTool : public Fmxtee::Tools::TRectangleTool
{
	typedef Fmxtee::Tools::TRectangleTool inherited;
	
private:
	Fmx::Grid::TStringGrid* FGrid;
	void __fastcall SetGrid(Fmx::Grid::TStringGrid* const Value);
	
protected:
	virtual void __fastcall DoDrawText(Fmxtee::Engine::TCustomAxisPanel* const AParent)/* overload */;
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TCustomLegendTool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCustomLegendTool();
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	__property Fmx::Grid::TStringGrid* Grid = {read=FGrid, write=SetGrid};
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DoDrawText(){ Fmxtee::Tools::TAnnotationTool::DoDrawText(); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Customlegend */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_CUSTOMLEGEND)
using namespace Fmxtee::Tools::Customlegend;
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
#endif	// Fmxtee_Tools_CustomlegendHPP
