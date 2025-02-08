// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPageLayout.pas' rev: 31.00 (Windows)

#ifndef LmdpagelayoutHPP
#define LmdpagelayoutHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDPrinter.hpp>
#include <LMDDocModel.hpp>
#include <LMDPrintablePage.hpp>
#include <LMDDocElementRenderer.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpagelayout
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomPageLayout;
class DELPHICLASS TLMDDocElementRendererMapping;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCustomPageLayout : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
	
private:
	typedef System::DynamicArray<Lmdprintablepage::TLMDPrintablePage*> _TLMDCustomPageLayout__1;
	
	
private:
	Lmddocmodel::TLMDDocument* FDocument;
	Lmdprintablepage::TLMDPrintablePage* __fastcall GetPage(int Index);
	
protected:
	bool FPagesPrepared;
	_TLMDCustomPageLayout__1 FPages;
	System::Classes::TList* FRendererMappings;
	int FCurY;
	int FPageWidth;
	int FPageHeight;
	Vcl::Graphics::TCanvas* FCanvas;
	Lmdprintablepage::TLMDPrintablePage* __fastcall AddPage(void);
	void __fastcall AddRendererMapping(Lmddocelementrenderer::TLMDCustomDocElementRenderer* ARenderer, Lmddocmodel::TLMDDocElement* ADocElement);
	virtual Lmddocelementrenderer::TLMDCustomDocElementRenderer* __fastcall SelectRendererForDocElement(Lmddocmodel::TLMDDocElement* ADocElement);
	virtual Lmddocelementrenderer::TLMDCustomDocElementRenderer* __fastcall GetRendererForDocElement(Lmddocmodel::TLMDDocElement* ADocElement);
	virtual void __fastcall GetElementAreaIndexesByPage(Lmddocelementrenderer::TLMDCustomDocElementRenderer* ARenderer, int APageNum, /* out */ int &AVertIndex, /* out */ int &AHorizIndex) = 0 ;
	void __fastcall ReleasePages(void);
	void __fastcall ReleaseRenderers(void);
	void __fastcall CheckPagesPrepared(void);
	void __fastcall CheckPagesNotPrepared(void);
	
public:
	__fastcall TLMDCustomPageLayout(void);
	__fastcall virtual ~TLMDCustomPageLayout(void);
	virtual void __fastcall PreparePages(int APageWidth, int APageHeight, Vcl::Graphics::TCanvas* ACanvas);
	int __fastcall GetPagesCount(void);
	virtual void __fastcall DrawPage(int ANum, const System::Types::TPoint &APoint, Vcl::Graphics::TCanvas* ACanvas);
	virtual void __fastcall FinalizePages(void);
	__property Lmdprintablepage::TLMDPrintablePage* Page[int Index] = {read=GetPage};
	
__published:
	__property int PagesCount = {read=GetPagesCount, nodefault};
	__property Lmddocmodel::TLMDDocument* Document = {read=FDocument, write=FDocument};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDocElementRendererMapping : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmddocelementrenderer::TLMDCustomDocElementRenderer* FRenderer;
	Lmddocmodel::TLMDDocElement* FDocElement;
	
public:
	__property Lmddocmodel::TLMDDocElement* DocElement = {read=FDocElement, write=FDocElement};
	__property Lmddocelementrenderer::TLMDCustomDocElementRenderer* Renderer = {read=FRenderer, write=FRenderer};
public:
	/* TObject.Create */ inline __fastcall TLMDDocElementRendererMapping(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDocElementRendererMapping(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdpagelayout */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPAGELAYOUT)
using namespace Lmdpagelayout;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpagelayoutHPP
