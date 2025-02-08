// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPrintablePage.pas' rev: 31.00 (Windows)

#ifndef LmdprintablepageHPP
#define LmdprintablepageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <LMDPrinter.hpp>
#include <LMDDocModel.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdprintablepage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDPrintablePage;
class DELPHICLASS TLMDPageArea;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPrintablePage : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Classes::TList* FPageAreas;
	int FPageNumber;
	
public:
	__fastcall TLMDPrintablePage(void);
	__fastcall virtual ~TLMDPrintablePage(void);
	
__published:
	__property System::Classes::TList* PageAreas = {read=FPageAreas};
	__property int PageNumber = {read=FPageNumber, write=FPageNumber, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPageArea : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
	
private:
	typedef System::DynamicArray<Lmddocmodel::TLMDDocElement*> _TLMDPageArea__1;
	
	
private:
	_TLMDPageArea__1 FDocElements;
	System::Types::TRect FArea;
	TLMDPrintablePage* FPage;
	int FHorizPartIndex;
	int FVertPartIndex;
	int __fastcall GetDocElementsCount(void);
	Lmddocmodel::TLMDDocElement* __fastcall GetDocElement(int AIndex);
	
public:
	__fastcall TLMDPageArea(void);
	__fastcall virtual ~TLMDPageArea(void);
	void __fastcall AddDocElement(Lmddocmodel::TLMDDocElement* AElement);
	void __fastcall DetachElements(void);
	__property Lmddocmodel::TLMDDocElement* DocElements[int AIndex] = {read=GetDocElement};
	__property int DocElementsCount = {read=GetDocElementsCount, nodefault};
	__property TLMDPrintablePage* Page = {read=FPage, write=FPage};
	__property System::Types::TRect Area = {read=FArea, write=FArea};
	__property int HorizPartIndex = {read=FHorizPartIndex, write=FHorizPartIndex, nodefault};
	__property int VertPartIndex = {read=FVertPartIndex, write=FVertPartIndex, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdprintablepage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPRINTABLEPAGE)
using namespace Lmdprintablepage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdprintablepageHPP
