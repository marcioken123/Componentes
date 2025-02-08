// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDynLIFOBuffer.pas' rev: 34.00 (Windows)

#ifndef LmddynlifobufferHPP
#define LmddynlifobufferHPP

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

namespace Lmddynlifobuffer
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDynLIFOBuffer;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDynLIFOBuffer : public Lmdbuffer::TLMDBuffer
{
	typedef Lmdbuffer::TLMDBuffer inherited;
	
private:
	bool FCircleMode;
	Lmdbuffer::TLMDDynNode *FCurrent;
	Lmdbuffer::TLMDDynNode *FTop;
	
protected:
	virtual void __fastcall FirstNode(void * &node);
	virtual void __fastcall NextNode(void * &node);
	virtual void * __fastcall GetItem(void * node);
	virtual bool __fastcall EOFBuffer(void * node);
	void __fastcall clearItem(void * item);
	
public:
	virtual bool __fastcall IsEmpty();
	virtual bool __fastcall IsFull();
	virtual void __fastcall Put(void * item);
	virtual void * __fastcall Get();
	virtual void __fastcall Clear();
	__fastcall virtual TLMDDynLIFOBuffer(System::Classes::TPersistent* AOwner);
	__fastcall virtual ~TLMDDynLIFOBuffer();
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddynlifobuffer */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDYNLIFOBUFFER)
using namespace Lmddynlifobuffer;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddynlifobufferHPP
