// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBiTrackBar.pas' rev: 31.00 (Windows)

#ifndef LmdbitrackbarHPP
#define LmdbitrackbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomBiTrackBar.hpp>
#include <LMDCustomTrackBar.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDFillObject.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbitrackbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBiTrackBar;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDBiTrackBar : public Lmdcustombitrackbar::TLMDCustomBiTrackBar
{
	typedef Lmdcustombitrackbar::TLMDCustomBiTrackBar inherited;
	
__published:
	__property DiapasonFillObject;
	__property RightPosition;
	__property LeftPosition;
public:
	/* TLMDCustomBiTrackBar.Create */ inline __fastcall virtual TLMDBiTrackBar(System::Classes::TComponent* AOwner) : Lmdcustombitrackbar::TLMDCustomBiTrackBar(AOwner) { }
	/* TLMDCustomBiTrackBar.Destroy */ inline __fastcall virtual ~TLMDBiTrackBar(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDBiTrackBar(HWND ParentWindow) : Lmdcustombitrackbar::TLMDCustomBiTrackBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbitrackbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBITRACKBAR)
using namespace Lmdbitrackbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbitrackbarHPP
