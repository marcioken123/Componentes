// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSimpleRectPageLayout.pas' rev: 31.00 (Windows)

#ifndef LmdsimplerectpagelayoutHPP
#define LmdsimplerectpagelayoutHPP

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
#include <LMDPrintConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsimplerectpagelayout
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSimpleRectPageLayout;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSimpleRectPageLayout : public Lmdpagelayout::TLMDCustomPageLayout
{
	typedef Lmdpagelayout::TLMDCustomPageLayout inherited;
	
protected:
	virtual void __fastcall GetElementAreaIndexesByPage(Lmddocelementrenderer::TLMDCustomDocElementRenderer* ARenderer, int APageNum, /* out */ int &AVertIndex, /* out */ int &AHorizIndex);
	
public:
	virtual void __fastcall PreparePages(int APageWidth, int APageHeight, Vcl::Graphics::TCanvas* ACanvas);
public:
	/* TLMDCustomPageLayout.Create */ inline __fastcall TLMDSimpleRectPageLayout(void) : Lmdpagelayout::TLMDCustomPageLayout() { }
	/* TLMDCustomPageLayout.Destroy */ inline __fastcall virtual ~TLMDSimpleRectPageLayout(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsimplerectpagelayout */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSIMPLERECTPAGELAYOUT)
using namespace Lmdsimplerectpagelayout;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsimplerectpagelayoutHPP
