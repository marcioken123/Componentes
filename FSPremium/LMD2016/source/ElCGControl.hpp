// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElCGControl.pas' rev: 31.00 (Windows)

#ifndef ElcgcontrolHPP
#define ElcgcontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Controls.hpp>
#include <LMDTypes.hpp>
#include <intfLMDBase.hpp>
#include <ElVCLUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcgcontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElCustomGraphicControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElCustomGraphicControl : public Vcl::Controls::TGraphicControl
{
	typedef Vcl::Controls::TGraphicControl inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property Color;
public:
	/* TGraphicControl.Create */ inline __fastcall virtual TElCustomGraphicControl(System::Classes::TComponent* AOwner) : Vcl::Controls::TGraphicControl(AOwner) { }
	/* TGraphicControl.Destroy */ inline __fastcall virtual ~TElCustomGraphicControl(void) { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elcgcontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCGCONTROL)
using namespace Elcgcontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcgcontrolHPP
