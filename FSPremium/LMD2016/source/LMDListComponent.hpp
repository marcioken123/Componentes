// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDListComponent.pas' rev: 31.00 (Windows)

#ifndef LmdlistcomponentHPP
#define LmdlistcomponentHPP

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

namespace Lmdlistcomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDListComponent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDListComponent : public Lmdbuffercomponent::TLMDBufferComponent
{
	typedef Lmdbuffercomponent::TLMDBufferComponent inherited;
	
public:
	__fastcall virtual TLMDListComponent(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDListComponent(void);
	void * __fastcall Item(void);
	void __fastcall First(void);
	void __fastcall Next(void);
	void __fastcall Last(void);
	void __fastcall Prev(void);
	bool __fastcall isLast(void);
	void __fastcall Seek(int index);
	void __fastcall Delete(void);
	void * __fastcall Extract(void);
	void * __fastcall ExtractByNr(int index);
	void * __fastcall GetItemByNr(int index);
	HIDESBASE void __fastcall Insert(void * item);
	void __fastcall InsertAt(void * item, int index);
	void __fastcall Add(void * item);
	void __fastcall Clear(void);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlistcomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLISTCOMPONENT)
using namespace Lmdlistcomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlistcomponentHPP
