// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTrackBar.pas' rev: 31.00 (Windows)

#ifndef LmdtrackbarHPP
#define LmdtrackbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomTrackBar.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtrackbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTrackBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDTrackBar : public Lmdcustomtrackbar::TLMDCustomTrackBar
{
	typedef Lmdcustomtrackbar::TLMDCustomTrackBar inherited;
	
__published:
	__property Position;
public:
	/* TLMDCustomTrackBar.Create */ inline __fastcall virtual TLMDTrackBar(System::Classes::TComponent* AOwner) : Lmdcustomtrackbar::TLMDCustomTrackBar(AOwner) { }
	/* TLMDCustomTrackBar.Destroy */ inline __fastcall virtual ~TLMDTrackBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTrackBar(HWND ParentWindow) : Lmdcustomtrackbar::TLMDCustomTrackBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtrackbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTRACKBAR)
using namespace Lmdtrackbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtrackbarHPP
