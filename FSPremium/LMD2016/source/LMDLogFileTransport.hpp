// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLogFileTransport.pas' rev: 31.00 (Windows)

#ifndef LmdlogfiletransportHPP
#define LmdlogfiletransportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDLogLayoutTransport.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <LMDThreads.hpp>
#include <LMDFiles.hpp>
#include <LMDTypes.hpp>
#include <LMDLogMessage.hpp>
#include <LMDZLib.hpp>
#include <LMDStrings.hpp>
#include <LMDProcs.hpp>
#include <LMDObjectList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlogfiletransport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLogFileTransport;
class DELPHICLASS TLMDLogFileSendThread;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogFileTransport : public Lmdloglayouttransport::TLMDLogLayoutTransport
{
	typedef Lmdloglayouttransport::TLMDLogLayoutTransport inherited;
	
private:
	Lmdtypes::TLMDString FFileName;
	bool FKeepOpen;
	bool FAppended;
	bool FBackup;
	void __fastcall SetFileName(const Lmdtypes::TLMDString Value);
	
protected:
	virtual System::Classes::TThread* __fastcall CreateSendThread(void);
	virtual System::WideString __fastcall GetParameters(void);
	virtual void __fastcall SetParameters(const System::WideString AValue);
	
public:
	__fastcall virtual TLMDLogFileTransport(void);
	__fastcall virtual ~TLMDLogFileTransport(void);
	__classmethod virtual System::WideString __fastcall GetName();
	__property Lmdtypes::TLMDString FileName = {read=FFileName, write=SetFileName};
	__property bool KeepOpen = {read=FKeepOpen, write=FKeepOpen, nodefault};
	__property bool Appended = {read=FAppended, write=FAppended, nodefault};
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

class PASCALIMPLEMENTATION TLMDLogFileSendThread : public Lmdlogmessage::TLMDLogCustomSendThread
{
	typedef Lmdlogmessage::TLMDLogCustomSendThread inherited;
	
protected:
	TLMDLogFileTransport* FOwner;
	int FHeaderSize;
	Lmdfiles::TLMDFileStream* FFileStream;
	virtual bool __fastcall DoMessage(Lmdlogmessage::TLMDLogMessage* AMessage);
	
public:
	__fastcall TLMDLogFileSendThread(bool ACreateSuspended, Lmdlogmessage::TLMDLogCustomTransport* AOwner);
	__fastcall virtual ~TLMDLogFileSendThread(void);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlogfiletransport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLOGFILETRANSPORT)
using namespace Lmdlogfiletransport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlogfiletransportHPP
