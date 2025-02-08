// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDListBoxExt.pas' rev: 31.00 (Windows)

#ifndef LmdlistboxextHPP
#define LmdlistboxextHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomListBoxExt.hpp>
#include <LMDCustomScrollBoxExt.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDSBar.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlistboxext
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDListBoxExt;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDListBoxExt : public Lmdcustomlistboxext::TLMDCustomListBoxExt
{
	typedef Lmdcustomlistboxext::TLMDCustomListBoxExt inherited;
	
__published:
	__property HorzScrollBar;
	__property VertScrollBar;
	__property VirtualAutoWidth = {index=16, default=0};
public:
	/* TLMDCustomListBoxExt.Create */ inline __fastcall virtual TLMDListBoxExt(System::Classes::TComponent* AOwner) : Lmdcustomlistboxext::TLMDCustomListBoxExt(AOwner) { }
	/* TLMDCustomListBoxExt.Destroy */ inline __fastcall virtual ~TLMDListBoxExt(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDListBoxExt(HWND ParentWindow) : Lmdcustomlistboxext::TLMDCustomListBoxExt(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlistboxext */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLISTBOXEXT)
using namespace Lmdlistboxext;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlistboxextHPP
