// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'intfLMDBase.pas' rev: 34.00 (Windows)

#ifndef IntflmdbaseHPP
#define IntflmdbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Intflmdbase
{
//-- forward type declarations -----------------------------------------------
__interface DELPHIINTERFACE ILMDComponent;
typedef System::DelphiInterface<ILMDComponent> _di_ILMDComponent;
//-- type declarations -------------------------------------------------------
__interface  INTERFACE_UUID("{42DEE038-9F98-4CA3-9734-F770483E97FF}") ILMDComponent  : public System::IInterface 
{
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage() = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDSupports(System::TObject* const Instance, const GUID &IID, /* out */ void *Intf);
}	/* namespace Intflmdbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_INTFLMDBASE)
using namespace Intflmdbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IntflmdbaseHPP
