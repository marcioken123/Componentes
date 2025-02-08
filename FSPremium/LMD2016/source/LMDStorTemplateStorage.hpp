// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorTemplateStorage.pas' rev: 31.00 (Windows)

#ifndef LmdstortemplatestorageHPP
#define LmdstortemplatestorageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDStorBase.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstortemplatestorage
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStorTemplateStorage;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStorTemplateStorage : public Lmdstorbase::TLMDStorComponent
{
	typedef Lmdstorbase::TLMDStorComponent inherited;
	
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDStorTemplateStorage(System::Classes::TComponent* AOwner) : Lmdstorbase::TLMDStorComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDStorTemplateStorage(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstortemplatestorage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORTEMPLATESTORAGE)
using namespace Lmdstortemplatestorage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstortemplatestorageHPP
