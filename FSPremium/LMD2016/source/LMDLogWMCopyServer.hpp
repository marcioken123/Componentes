// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLogWMCopyServer.pas' rev: 31.00 (Windows)

#ifndef LmdlogwmcopyserverHPP
#define LmdlogwmcopyserverHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <LMDLogServer.hpp>
#include <LMDLogMessage.hpp>
#include <LMDUtils.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlogwmcopyserver
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWMCopyDataCollector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDWMCopyDataCollector : public Lmdlogserver::TLMDLogCollector
{
	typedef Lmdlogserver::TLMDLogCollector inherited;
	
private:
	NativeUInt FWindowHandle;
	
protected:
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMCopyData(Winapi::Messages::TWMCopyData &Message);
	
public:
	__fastcall TLMDWMCopyDataCollector(void);
	__fastcall virtual ~TLMDWMCopyDataCollector(void);
	__classmethod virtual System::WideString __fastcall GetName();
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlogwmcopyserver */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLOGWMCOPYSERVER)
using namespace Lmdlogwmcopyserver;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlogwmcopyserverHPP
