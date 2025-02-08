// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDButtonLayout.pas' rev: 31.00 (Windows)

#ifndef LmdbuttonlayoutHPP
#define LmdbuttonlayoutHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDButtonBase.hpp>
#include <LMDGraph.hpp>
#include <LMDGlyphTextLayout.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbuttonlayout
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDButtonLayout;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDButtonLayout : public Lmdglyphtextlayout::TLMDGlyphTextLayout
{
	typedef Lmdglyphtextlayout::TLMDGlyphTextLayout inherited;
	
private:
	bool FArrow;
	System::Uitypes::TColor FArrowColor;
	int FArrowIndent;
	Lmdbuttonbase::TLMDArrowPosition FArrowPosition;
	Lmdgraph::TLMDDDArrowSize FArrowSize;
	
protected:
	void __fastcall SetArrow(bool aValue);
	void __fastcall SetArrowColor(System::Uitypes::TColor aValue);
	void __fastcall SetArrowPosition(Lmdbuttonbase::TLMDArrowPosition aValue);
	void __fastcall SetArrowSize(Lmdgraph::TLMDDDArrowSize aValue);
	void __fastcall SetInteger(int Index, int aValue);
	
public:
	__fastcall virtual TLMDButtonLayout(System::Classes::TPersistent* AOwner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Alignment = {default=4};
	__property bool Arrow = {read=FArrow, write=SetArrow, default=0};
	__property System::Uitypes::TColor ArrowColor = {read=FArrowColor, write=SetArrowColor, default=0};
	__property int ArrowIndent = {read=FArrowIndent, write=SetInteger, index=0, default=3};
	__property Lmdbuttonbase::TLMDArrowPosition ArrowPosition = {read=FArrowPosition, write=SetArrowPosition, default=0};
	__property Lmdgraph::TLMDDDArrowSize ArrowSize = {read=FArrowSize, write=SetArrowSize, default=3};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDButtonLayout(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbuttonlayout */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBUTTONLAYOUT)
using namespace Lmdbuttonlayout;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbuttonlayoutHPP
