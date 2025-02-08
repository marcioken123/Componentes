// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLayoutRenderPrintTask.pas' rev: 31.00 (Windows)

#ifndef LmdlayoutrenderprinttaskHPP
#define LmdlayoutrenderprinttaskHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Math.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDPrinter.hpp>
#include <LMDDocModel.hpp>
#include <LMDPrintablePage.hpp>
#include <LMDCustomPrintTask.hpp>
#include <LMDPageLayout.hpp>
#include <LMDDocElementRenderer.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlayoutrenderprinttask
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLayoutRenderPrintTask;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDLayoutRenderPrintTask : public Lmdcustomprinttask::TLMDCustomPrintTask
{
	typedef Lmdcustomprinttask::TLMDCustomPrintTask inherited;
	
protected:
	Lmddocmodel::TLMDDocument* FDocument;
	Lmdpagelayout::TLMDCustomPageLayout* FLayout;
	int FPageWidth;
	int FPageHeight;
	Vcl::Graphics::TCanvas* FCanvas;
	virtual void __fastcall CreateLayoutManager(void) = 0 ;
	virtual void __fastcall ConstructDocument(void) = 0 ;
	virtual void __fastcall PreparePagesInternal(int APageWidth, int APageHeight, Vcl::Graphics::TCanvas* ACanvas);
	virtual int __fastcall GetPagesCountInternal(Lmdprinter::TLMDPrintOperationRange ARange);
	virtual void __fastcall DrawPageInternal(Lmdprinter::TLMDPrintOperationRange ARange, int ANum, const System::Types::TPoint &APoint, Vcl::Graphics::TCanvas* ACanvas);
	virtual void __fastcall FinalizePagesInternal(void);
public:
	/* TLMDCustomPrintTask.Create */ inline __fastcall virtual TLMDLayoutRenderPrintTask(System::Classes::TComponent* AOwner) : Lmdcustomprinttask::TLMDCustomPrintTask(AOwner) { }
	/* TLMDCustomPrintTask.Destroy */ inline __fastcall virtual ~TLMDLayoutRenderPrintTask(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlayoutrenderprinttask */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLAYOUTRENDERPRINTTASK)
using namespace Lmdlayoutrenderprinttask;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlayoutrenderprinttaskHPP
