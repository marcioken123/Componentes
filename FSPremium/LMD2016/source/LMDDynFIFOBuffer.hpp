// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDynFIFOBuffer.pas' rev: 34.00 (Windows)

#ifndef LmddynfifobufferHPP
#define LmddynfifobufferHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDBuffer.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddynfifobuffer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDynFIFOBuffer;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDynFIFOBuffer : public Lmdbuffer::TLMDBuffer
{
	typedef Lmdbuffer::TLMDBuffer inherited;
	
private:
	Lmdbuffer::TLMDDynNode *FRoot;
	Lmdbuffer::TLMDDynNode *FTop;
	void __fastcall FreeNode(Lmdbuffer::PLMDDynNode Node);
	Lmdbuffer::PLMDDynNode __fastcall CreateNode();
	
protected:
	virtual void __fastcall FirstNode(void * &node);
	virtual void __fastcall NextNode(void * &node);
	virtual bool __fastcall EOFBuffer(void * node);
	virtual void * __fastcall GetItem(void * node);
	
public:
	virtual bool __fastcall IsEmpty();
	virtual bool __fastcall IsFull();
	virtual void __fastcall Put(void * item);
	virtual void * __fastcall Get();
	void * __fastcall Front();
	virtual void __fastcall Clear();
	__fastcall virtual TLMDDynFIFOBuffer(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TLMDDynFIFOBuffer();
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddynfifobuffer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDYNFIFOBUFFER)
using namespace Lmddynfifobuffer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddynfifobufferHPP
