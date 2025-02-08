// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextScroll.pas' rev: 31.00 (Windows)

#ifndef LmdtextscrollHPP
#define LmdtextscrollHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDTextCustomScroll.hpp>
#include <LMDTextPanel.hpp>
#include <LMDTextCustomPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDTextObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextscroll
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextScroll;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTextScroll : public Lmdtextcustomscroll::TLMDTextCustomScroll
{
	typedef Lmdtextcustomscroll::TLMDTextCustomScroll inherited;
	
__published:
	__property Lines;
public:
	/* TLMDTextCustomScroll.Create */ inline __fastcall virtual TLMDTextScroll(System::Classes::TComponent* aOwner) : Lmdtextcustomscroll::TLMDTextCustomScroll(aOwner) { }
	/* TLMDTextCustomScroll.Destroy */ inline __fastcall virtual ~TLMDTextScroll(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextScroll(HWND ParentWindow) : Lmdtextcustomscroll::TLMDTextCustomScroll(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextscroll */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTSCROLL)
using namespace Lmdtextscroll;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextscrollHPP
