// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSimpleDocLayout.pas' rev: 31.00 (Windows)

#ifndef LmdsimpledoclayoutHPP
#define LmdsimpledoclayoutHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDPrinter.hpp>
#include <LMDDocModel.hpp>
#include <LMDPrintablePage.hpp>
#include <LMDPageLayout.hpp>
#include <LMDDocElementRenderer.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsimpledoclayout
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSimpleDocLayout;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSimpleDocLayout : public Lmdpagelayout::TLMDCustomPageLayout
{
	typedef Lmdpagelayout::TLMDCustomPageLayout inherited;
	
protected:
	virtual void __fastcall GetElementAreaIndexesByPage(Lmddocelementrenderer::TLMDCustomDocElementRenderer* ARenderer, int APageNum, /* out */ int &AVertIndex, /* out */ int &AHorizIndex);
	
public:
	virtual void __fastcall PreparePages(int APageWidth, int APageHeight, Vcl::Graphics::TCanvas* ACanvas);
public:
	/* TLMDCustomPageLayout.Create */ inline __fastcall TLMDSimpleDocLayout(void) : Lmdpagelayout::TLMDCustomPageLayout() { }
	/* TLMDCustomPageLayout.Destroy */ inline __fastcall virtual ~TLMDSimpleDocLayout(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsimpledoclayout */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSIMPLEDOCLAYOUT)
using namespace Lmdsimpledoclayout;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsimpledoclayoutHPP
