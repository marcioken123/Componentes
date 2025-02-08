// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDColorBox.pas' rev: 31.00 (Windows)

#ifndef PlmdcolorboxHPP
#define PlmdcolorboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcolorbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDColorBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDColorBox : public Vcl::Extctrls::TColorBox
{
	typedef Vcl::Extctrls::TColorBox inherited;
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDColorBox(System::Classes::TComponent* AOwner);
public:
	/* TCustomComboBox.Destroy */ inline __fastcall virtual ~TLMDColorBox(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDColorBox(HWND ParentWindow) : Vcl::Extctrls::TColorBox(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdcolorbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCOLORBOX)
using namespace Plmdcolorbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcolorboxHPP
