// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStack.pas' rev: 34.00 (Windows)

#ifndef LmdstackHPP
#define LmdstackHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDDynLIFOBuffer.hpp>
#include <LMDBuffer.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstack
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStack;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStack : public Lmddynlifobuffer::TLMDDynLIFOBuffer
{
	typedef Lmddynlifobuffer::TLMDDynLIFOBuffer inherited;
	
public:
	void __fastcall Push(System::TObject* item)/* overload */;
	void __fastcall Pop();
	System::TObject* __fastcall Top();
	System::TObject* __fastcall ExtractTop();
	void __fastcall Push(void * item)/* overload */;
public:
	/* TLMDDynLIFOBuffer.Create */ inline __fastcall virtual TLMDStack(System::Classes::TPersistent* AOwner) : Lmddynlifobuffer::TLMDDynLIFOBuffer(AOwner) { }
	/* TLMDDynLIFOBuffer.Destroy */ inline __fastcall virtual ~TLMDStack() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstack */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTACK)
using namespace Lmdstack;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstackHPP
