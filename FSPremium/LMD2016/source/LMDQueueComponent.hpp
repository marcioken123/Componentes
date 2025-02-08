// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDQueueComponent.pas' rev: 31.00 (Windows)

#ifndef LmdqueuecomponentHPP
#define LmdqueuecomponentHPP

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

namespace Lmdqueuecomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDQueueComponent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDQueueComponent : public Lmdbuffercomponent::TLMDBufferComponent
{
	typedef Lmdbuffercomponent::TLMDBufferComponent inherited;
	
public:
	__fastcall virtual TLMDQueueComponent(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDQueueComponent(void);
	void __fastcall EnQueue(void * item);
	void __fastcall DeQueue(void);
	void * __fastcall Front(void);
	void * __fastcall ExtractFront(void);
	void __fastcall Clear(void);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdqueuecomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDQUEUECOMPONENT)
using namespace Lmdqueuecomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdqueuecomponentHPP
