// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'intfLMDFaceController.pas' rev: 31.00 (Windows)

#ifndef IntflmdfacecontrollerHPP
#define IntflmdfacecontrollerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <LMDFillObject.hpp>
#include <LMDBevel.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMD3DCaption.hpp>
#include <intfLMDBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Intflmdfacecontroller
{
//-- forward type declarations -----------------------------------------------
__interface ILMDFaceController;
typedef System::DelphiInterface<ILMDFaceController> _di_ILMDFaceController;
//-- type declarations -------------------------------------------------------
__interface  INTERFACE_UUID("{32BE634B-1A6E-4975-9975-241836293C61}") ILMDFaceController  : public System::IInterface 
{
	virtual bool __fastcall fcGetFocused(void) = 0 ;
	virtual bool __fastcall fcGetMouseAbove(void) = 0 ;
	virtual bool __fastcall fcGetTransparent(void) = 0 ;
	virtual bool __fastcall fcGetCtlXP(void) = 0 ;
	virtual bool __fastcall fcGetBorderCtl3D(void) = 0 ;
	virtual bool __fastcall fcGetEnabled(void) = 0 ;
	virtual System::Uitypes::TColor __fastcall fcGetBackColor(void) = 0 ;
	virtual void __fastcall fcSetFaceController(System::Classes::TComponent* aComponent) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Intflmdfacecontroller */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_INTFLMDFACECONTROLLER)
using namespace Intflmdfacecontroller;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IntflmdfacecontrollerHPP
