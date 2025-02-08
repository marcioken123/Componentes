// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStringsPrintTask.pas' rev: 31.00 (Windows)

#ifndef LmdstringsprinttaskHPP
#define LmdstringsprinttaskHPP

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
#include <Vcl.ComCtrls.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Printers.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Dialogs.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDPrinter.hpp>
#include <LMDDocModel.hpp>
#include <LMDPrintablePage.hpp>
#include <LMDCustomPrintTask.hpp>
#include <LMDPageLayout.hpp>
#include <LMDSimpleDocLayout.hpp>
#include <LMDLayoutRenderPrintTask.hpp>
#include <LMDDocElementRenderer.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstringsprinttask
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStringsPrintTask;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStringsPrintTask : public Lmdlayoutrenderprinttask::TLMDLayoutRenderPrintTask
{
	typedef Lmdlayoutrenderprinttask::TLMDLayoutRenderPrintTask inherited;
	
private:
	Lmddocmodel::TLMDTextAreaSettings* FFormatOptions;
	System::Classes::TStrings* FLines;
	void __fastcall SetFormatOptions(Lmddocmodel::TLMDTextAreaSettings* const Value);
	void __fastcall SetLines(System::Classes::TStrings* const Value);
	
protected:
	virtual void __fastcall CreateLayoutManager(void);
	virtual void __fastcall ConstructDocument(void);
	
public:
	__fastcall virtual TLMDStringsPrintTask(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDStringsPrintTask(void);
	void __fastcall LoadFromRtf(Vcl::Comctrls::TRichEdit* AEdit);
	
__published:
	__property About = {default=0};
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines};
	__property Lmddocmodel::TLMDTextAreaSettings* FormatOptions = {read=FFormatOptions, write=SetFormatOptions};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstringsprinttask */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTRINGSPRINTTASK)
using namespace Lmdstringsprinttask;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstringsprinttaskHPP
