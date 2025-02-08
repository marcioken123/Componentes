// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStackComponent.pas' rev: 31.00 (Windows)

#ifndef LmdstackcomponentHPP
#define LmdstackcomponentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDBufferComponent.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstackcomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStackComponent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStackComponent : public Lmdbuffercomponent::TLMDBufferComponent
{
	typedef Lmdbuffercomponent::TLMDBufferComponent inherited;
	
public:
	__fastcall virtual TLMDStackComponent(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDStackComponent(void);
	void __fastcall Pop(void);
	void __fastcall Push(void * item);
	void * __fastcall Top(void);
	void * __fastcall ExtractTop(void);
	void __fastcall Clear(void);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstackcomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTACKCOMPONENT)
using namespace Lmdstackcomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstackcomponentHPP
