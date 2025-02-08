// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDScrollBox.pas' rev: 31.00 (Windows)

#ifndef LmdscrollboxHPP
#define LmdscrollboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDCustomScrollBox.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <LMDClass.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdscrollbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDScrollBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDScrollBox : public Lmdcustomscrollbox::TLMDCustomScrollBox
{
	typedef Lmdcustomscrollbox::TLMDCustomScrollBox inherited;
	
public:
	__property CtlXP = {default=1};
	
__published:
	__property Bevel;
	__property InstantUpdate = {default=1};
	__property Transparent = {default=0};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnPaint;
public:
	/* TLMDCustomScrollBox.Create */ inline __fastcall virtual TLMDScrollBox(System::Classes::TComponent* AOwner) : Lmdcustomscrollbox::TLMDCustomScrollBox(AOwner) { }
	/* TLMDCustomScrollBox.Destroy */ inline __fastcall virtual ~TLMDScrollBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDScrollBox(HWND ParentWindow) : Lmdcustomscrollbox::TLMDCustomScrollBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdscrollbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCROLLBOX)
using namespace Lmdscrollbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdscrollboxHPP
