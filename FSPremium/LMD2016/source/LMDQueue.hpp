// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDQueue.pas' rev: 34.00 (Windows)

#ifndef LmdqueueHPP
#define LmdqueueHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDDynFIFOBuffer.hpp>
#include <LMDBuffer.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdqueue
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDQueue;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDQueue : public Lmddynfifobuffer::TLMDDynFIFOBuffer
{
	typedef Lmddynfifobuffer::TLMDDynFIFOBuffer inherited;
	
public:
	virtual void __fastcall enQueue(System::TObject* item);
	void __fastcall deQueue();
	System::TObject* __fastcall extractFront();
public:
	/* TLMDDynFIFOBuffer.Create */ inline __fastcall virtual TLMDQueue(System::Classes::TPersistent* AOwner) : Lmddynfifobuffer::TLMDDynFIFOBuffer(AOwner) { }
	/* TLMDDynFIFOBuffer.Destroy */ inline __fastcall virtual ~TLMDQueue() { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdqueue */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDQUEUE)
using namespace Lmdqueue;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdqueueHPP
