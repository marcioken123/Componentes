// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDToolBar.pas' rev: 31.00 (Windows)

#ifndef LmdtoolbarHPP
#define LmdtoolbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomToolBar.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDButtonPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtoolbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDToolBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDToolBar : public Lmdcustomtoolbar::TLMDCustomToolBar
{
	typedef Lmdcustomtoolbar::TLMDCustomToolBar inherited;
	
__published:
	__property TransparentBorder = {default=0};
public:
	/* TLMDCustomToolBar.Create */ inline __fastcall virtual TLMDToolBar(System::Classes::TComponent* aOwner) : Lmdcustomtoolbar::TLMDCustomToolBar(aOwner) { }
	/* TLMDCustomToolBar.Destroy */ inline __fastcall virtual ~TLMDToolBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDToolBar(HWND ParentWindow) : Lmdcustomtoolbar::TLMDCustomToolBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtoolbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTOOLBAR)
using namespace Lmdtoolbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtoolbarHPP
