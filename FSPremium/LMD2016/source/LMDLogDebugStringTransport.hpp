// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLogDebugStringTransport.pas' rev: 31.00 (Windows)

#ifndef LmdlogdebugstringtransportHPP
#define LmdlogdebugstringtransportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDLogLayoutTransport.hpp>
#include <LMDLogMessage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlogdebugstringtransport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLogDebugStringTransport;
class DELPHICLASS TLMDLogDebugStringSendThread;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogDebugStringTransport : public Lmdloglayouttransport::TLMDLogLayoutTransport
{
	typedef Lmdloglayouttransport::TLMDLogLayoutTransport inherited;
	
protected:
	virtual System::Classes::TThread* __fastcall CreateSendThread(void);
public:
	/* TLMDLogLayoutTransport.Destroy */ inline __fastcall virtual ~TLMDLogDebugStringTransport(void) { }
	
public:
	/* TLMDLogCustomTransport.Create */ inline __fastcall virtual TLMDLogDebugStringTransport(void) : Lmdloglayouttransport::TLMDLogLayoutTransport() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDLogDebugStringSendThread : public Lmdlogmessage::TLMDLogCustomSendThread
{
	typedef Lmdlogmessage::TLMDLogCustomSendThread inherited;
	
protected:
	TLMDLogDebugStringTransport* FOwner;
	virtual bool __fastcall DoMessage(Lmdlogmessage::TLMDLogMessage* AMessage);
	
public:
	__fastcall TLMDLogDebugStringSendThread(bool ACreateSuspended, Lmdlogmessage::TLMDLogCustomTransport* AOwner);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TLMDLogDebugStringSendThread(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlogdebugstringtransport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLOGDEBUGSTRINGTRANSPORT)
using namespace Lmdlogdebugstringtransport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlogdebugstringtransportHPP
