// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDGlyphTextLayout.pas' rev: 31.00 (Windows)

#ifndef LmdglyphtextlayoutHPP
#define LmdglyphtextlayoutHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDGraph.hpp>
#include <LMDObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdglyphtextlayout
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDGlyphTextLayout;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDGlyphTextLayout : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	Lmdgraph::TLMDTextArrange FAlignText2Glyph;
	int FOffsetX;
	int FOffsetY;
	int FSpacing;
	
protected:
	Lmdgraph::TLMDAlignment FAlignment;
	void __fastcall SetAlignment(Lmdgraph::TLMDAlignment aValue);
	void __fastcall SetAlignText2Glyph(Lmdgraph::TLMDTextArrange aValue);
	void __fastcall SetOffset(int index, int aValue);
	void __fastcall SetSpacing(int aValue);
	
public:
	__fastcall virtual TLMDGlyphTextLayout(System::Classes::TPersistent* Owner);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	DYNAMIC System::UnicodeString __fastcall GetSetStr(void);
	
__published:
	__property Lmdgraph::TLMDAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property Lmdgraph::TLMDTextArrange AlignText2Glyph = {read=FAlignText2Glyph, write=SetAlignText2Glyph, default=2};
	__property int OffsetX = {read=FOffsetX, write=SetOffset, index=0, default=0};
	__property int OffsetY = {read=FOffsetY, write=SetOffset, index=1, default=0};
	__property int Spacing = {read=FSpacing, write=SetSpacing, default=2};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDGlyphTextLayout(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdglyphtextlayout */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDGLYPHTEXTLAYOUT)
using namespace Lmdglyphtextlayout;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdglyphtextlayoutHPP
