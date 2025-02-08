// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFxBase.pas' rev: 31.00 (Windows)

#ifndef LmdfxbaseHPP
#define LmdfxbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDBaseControl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfxbase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFxComponent;
class DELPHICLASS TLMDFxGraphicControl;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDFxComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDFxComponent(System::Classes::TComponent* AOwner) : Lmdcustomcomponent::TLMDCustomComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDFxComponent(void) { }
	
};


class PASCALIMPLEMENTATION TLMDFxGraphicControl : public Lmdbasecontrol::TLMDBaseControl
{
	typedef Lmdbasecontrol::TLMDBaseControl inherited;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
public:
	/* TLMDBaseControl.Create */ inline __fastcall virtual TLMDFxGraphicControl(System::Classes::TComponent* aOwner) : Lmdbasecontrol::TLMDBaseControl(aOwner) { }
	/* TLMDBaseControl.Destroy */ inline __fastcall virtual ~TLMDFxGraphicControl(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word CM_PAINTTOBITMAP = System::Word(0xb1c8);
}	/* namespace Lmdfxbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFXBASE)
using namespace Lmdfxbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfxbaseHPP
