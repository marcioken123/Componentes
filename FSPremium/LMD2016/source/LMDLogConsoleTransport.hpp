// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLogConsoleTransport.pas' rev: 31.00 (Windows)

#ifndef LmdlogconsoletransportHPP
#define LmdlogconsoletransportHPP

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

namespace Lmdlogconsoletransport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLogConsoleTransport;
class DELPHICLASS TLMDLogConsoleSendThread;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogConsoleTransport : public Lmdloglayouttransport::TLMDLogLayoutTransport
{
	typedef Lmdloglayouttransport::TLMDLogLayoutTransport inherited;
	
protected:
	virtual System::Classes::TThread* __fastcall CreateSendThread(void);
public:
	/* TLMDLogLayoutTransport.Destroy */ inline __fastcall virtual ~TLMDLogConsoleTransport(void) { }
	
public:
	/* TLMDLogCustomTransport.Create */ inline __fastcall virtual TLMDLogConsoleTransport(void) : Lmdloglayouttransport::TLMDLogLayoutTransport() { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDLogConsoleSendThread : public Lmdlogmessage::TLMDLogCustomSendThread
{
	typedef Lmdlogmessage::TLMDLogCustomSendThread inherited;
	
protected:
	TLMDLogConsoleTransport* FOwner;
	virtual bool __fastcall DoMessage(Lmdlogmessage::TLMDLogMessage* AMessage);
	
public:
	__fastcall TLMDLogConsoleSendThread(bool ACreateSuspended, Lmdlogmessage::TLMDLogCustomTransport* AOwner);
	__fastcall virtual ~TLMDLogConsoleSendThread(void);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlogconsoletransport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLOGCONSOLETRANSPORT)
using namespace Lmdlogconsoletransport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlogconsoletransportHPP
