// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebInfo.pas' rev: 31.00 (Windows)

#ifndef LmdwebinfoHPP
#define LmdwebinfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDWebBase.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebinfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWebInfo;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDWebInfo : public Lmdwebbase::TLMDWebComponent
{
	typedef Lmdwebbase::TLMDWebComponent inherited;
	
private:
	bool FModem;
	System::UnicodeString __fastcall GetHostIP(void);
	System::UnicodeString __fastcall GetHostName_(void);
	bool __fastcall GetOnline(void);
	void __fastcall SetModem(const bool Value);
	
public:
	__property System::UnicodeString HostIP = {read=GetHostIP};
	__property System::UnicodeString HostName = {read=GetHostName_};
	__property bool Online = {read=GetOnline, nodefault};
	
__published:
	__property bool Modem = {read=FModem, write=SetModem, default=0};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDWebInfo(System::Classes::TComponent* AOwner) : Lmdwebbase::TLMDWebComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDWebInfo(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MAXHOSTNAMELEN = System::Int8(0x3f);
}	/* namespace Lmdwebinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBINFO)
using namespace Lmdwebinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebinfoHPP
