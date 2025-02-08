// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'intfLMDFaceControllerEditable.pas' rev: 31.00 (Windows)

#ifndef IntflmdfacecontrollereditableHPP
#define IntflmdfacecontrollereditableHPP

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

namespace Intflmdfacecontrollereditable
{
//-- forward type declarations -----------------------------------------------
__interface ILMDFaceControllerEditable;
typedef System::DelphiInterface<ILMDFaceControllerEditable> _di_ILMDFaceControllerEditable;
//-- type declarations -------------------------------------------------------
__interface  INTERFACE_UUID("{4CF92C4B-8694-477D-8E1E-2F6A2EAAE960}") ILMDFaceControllerEditable  : public System::IInterface 
{
	virtual bool __fastcall fcGetModified(void) = 0 ;
	virtual bool __fastcall fcGetReadOnly(void) = 0 ;
	virtual bool __fastcall fcGetInvalidData(void) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Intflmdfacecontrollereditable */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_INTFLMDFACECONTROLLEREDITABLE)
using namespace Intflmdfacecontrollereditable;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IntflmdfacecontrollereditableHPP
