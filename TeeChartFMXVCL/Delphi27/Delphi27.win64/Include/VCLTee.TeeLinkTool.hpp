// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeLinkTool.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeelinktoolHPP
#define Vcltee_TeelinktoolHPP

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
#include <System.UIConsts.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <VCLTee.TeeTools.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.Chart.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teelinktool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLinkTool;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLinkTool : public Vcltee::Teetools::TAnnotationTool
{
	typedef Vcltee::Teetools::TAnnotationTool inherited;
	
private:
	System::UnicodeString FHint;
	System::UnicodeString FURL;
	System::UnicodeString IOldHint;
	void __fastcall SetHint(const System::UnicodeString Value);
	void __fastcall SetURL(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall ChartMouseEvent(Vcltee::Teengine::TChartMouseEvent AEvent, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall DoDrawText(Vcltee::Teengine::TCustomAxisPanel* const AParent)/* overload */;
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
	inline void __fastcall  DoDrawText(){ Vcltee::Teetools::TAnnotationTool::DoDrawText(); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Teelinktool */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEELINKTOOL)
using namespace Vcltee::Teelinktool;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeelinktoolHPP
