// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDResWinControl.pas' rev: 31.00 (Windows)

#ifndef LmdreswincontrolHPP
#define LmdreswincontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdreswincontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDResWinControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDResWinControl : public Vcl::Controls::TWinControl
{
	typedef Vcl::Controls::TWinControl inherited;
	
protected:
	virtual void __fastcall CreateHandle(void);
	
public:
	void __fastcall FreeResources(void);
public:
	/* TWinControl.Create */ inline __fastcall virtual TLMDResWinControl(System::Classes::TComponent* AOwner) : Vcl::Controls::TWinControl(AOwner) { }
	/* TWinControl.CreateParented */ inline __fastcall TLMDResWinControl(HWND ParentWindow) : Vcl::Controls::TWinControl(ParentWindow) { }
	/* TWinControl.Destroy */ inline __fastcall virtual ~TLMDResWinControl(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall LMDFreeResources(Vcl::Controls::TWinControl* aControl);
}	/* namespace Lmdreswincontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRESWINCONTROL)
using namespace Lmdreswincontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdreswincontrolHPP
