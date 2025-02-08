// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'intfLMDFaceControllerPressable.pas' rev: 31.00 (Windows)

#ifndef IntflmdfacecontrollerpressableHPP
#define IntflmdfacecontrollerpressableHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <intfLMDBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Intflmdfacecontrollerpressable
{
//-- forward type declarations -----------------------------------------------
__interface ILMDFaceControllerPressable;
typedef System::DelphiInterface<ILMDFaceControllerPressable> _di_ILMDFaceControllerPressable;
//-- type declarations -------------------------------------------------------
__interface  INTERFACE_UUID("{DAF1F323-1814-4CF5-97C9-5B82B945D7E6}") ILMDFaceControllerPressable  : public System::IInterface 
{
	virtual bool __fastcall fcGetPressed(void) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Intflmdfacecontrollerpressable */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_INTFLMDFACECONTROLLERPRESSABLE)
using namespace Intflmdfacecontrollerpressable;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IntflmdfacecontrollerpressableHPP
