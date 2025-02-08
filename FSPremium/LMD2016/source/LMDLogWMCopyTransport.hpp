// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLogWMCopyTransport.pas' rev: 31.00 (Windows)

#ifndef LmdlogwmcopytransportHPP
#define LmdlogwmcopytransportHPP

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
#include <LMDProcs.hpp>
#include <LMDShUtils.hpp>
#include <LMDThreads.hpp>
#include <LMDTypes.hpp>
#include <LMDLogMessage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlogwmcopytransport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWMCopyDataTransport;
class DELPHICLASS TLMDWMSendThread;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWMCopyDataTransport : public Lmdlogmessage::TLMDLogCustomTransport
{
	typedef Lmdlogmessage::TLMDLogCustomTransport inherited;
	
private:
	Lmdtypes::TLMDString FWindowClass;
	Lmdtypes::TLMDString FWindowName;
	
protected:
	virtual System::WideString __fastcall GetParameters(void);
	virtual void __fastcall SetParameters(const System::WideString Value);
	virtual System::Classes::TThread* __fastcall CreateSendThread(void);
	
public:
	__classmethod virtual System::WideString __fastcall GetName();
	__fastcall virtual TLMDWMCopyDataTransport(void)/* overload */;
	__fastcall TLMDWMCopyDataTransport(const Lmdtypes::TLMDString AWindowClass, const Lmdtypes::TLMDString AWindowName)/* overload */;
	__fastcall virtual ~TLMDWMCopyDataTransport(void);
	__property Lmdtypes::TLMDString WindowClass = {read=FWindowClass, write=FWindowClass};
	__property Lmdtypes::TLMDString WindowName = {read=FWindowName, write=FWindowName};
	__property System::WideString Parameters = {read=GetParameters, write=SetParameters};
private:
	void *__ILMDLogTransport;	// Lmdlogmessage::ILMDLogTransport 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D974AF86-C7E2-49B5-B88F-1D0253320DB3}
	operator Lmdlogmessage::_di_ILMDLogTransport()
	{
		Lmdlogmessage::_di_ILMDLogTransport intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdlogmessage::ILMDLogTransport*(void) { return (Lmdlogmessage::ILMDLogTransport*)&__ILMDLogTransport; }
	#endif
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDWMSendThread : public Lmdlogmessage::TLMDLogCustomSendThread
{
	typedef Lmdlogmessage::TLMDLogCustomSendThread inherited;
	
protected:
	Lmdtypes::TLMDString FWindowClass;
	Lmdtypes::TLMDString FWindowName;
	virtual bool __fastcall DoMessage(Lmdlogmessage::TLMDLogMessage* AMessage);
	
public:
	__fastcall TLMDWMSendThread(bool ACreateSuspended, Lmdlogmessage::TLMDLogCustomTransport* AOwner);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TLMDWMSendThread(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlogwmcopytransport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLOGWMCOPYTRANSPORT)
using namespace Lmdlogwmcopytransport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlogwmcopytransportHPP
