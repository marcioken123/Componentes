// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Tools.Link.pas' rev: 34.00 (Android)

#ifndef Fmxtee_Tools_LinkHPP
#define Fmxtee_Tools_LinkHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UIConsts.hpp>
#include <FMX.Types.hpp>
#include <System.UITypes.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Tools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Tools
{
namespace Link
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLinkTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLinkTool : public Fmxtee::Tools::TAnnotationTool
{
	typedef Fmxtee::Tools::TAnnotationTool inherited;
	
private:
	System::UnicodeString FHint;
	System::UnicodeString FURL;
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetURL(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall ChartMouseEvent(Fmxtee::Engine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoDrawText(Fmxtee::Engine::TCustomAxisPanel* const AParent)/* overload */;
	__classmethod virtual System::UnicodeString __fastcall GetEditorClass();
	
public:
	__fastcall virtual TLinkTool(System::Classes::TComponent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__classmethod virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall LongDescription();
	
__published:
	__property Cursor = {default=-21};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property System::UnicodeString URL = {read=FURL, write=SetURL};
public:
	/* TAnnotationTool.Destroy */ inline __fastcall virtual ~TLinkTool() { }
	
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  DoDrawText(){ Fmxtee::Tools::TAnnotationTool::DoDrawText(); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Link */
}	/* namespace Tools */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_TOOLS_LINK)
using namespace Fmxtee::Tools::Link;
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
#endif	// Fmxtee_Tools_LinkHPP
