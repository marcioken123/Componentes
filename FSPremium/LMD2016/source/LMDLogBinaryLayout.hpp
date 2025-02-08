// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLogBinaryLayout.pas' rev: 31.00 (Windows)

#ifndef LmdlogbinarylayoutHPP
#define LmdlogbinarylayoutHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDLogLayoutTransport.hpp>
#include <System.Classes.hpp>
#include <LMDLogMessage.hpp>
#include <LMDTypes.hpp>
#include <LMDLogFileTransport.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlogbinarylayout
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLogBinaryLayout;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogBinaryLayout : public Lmdloglayouttransport::TLMDLogCustomBinaryLayout
{
	typedef Lmdloglayouttransport::TLMDLogCustomBinaryLayout inherited;
	
protected:
	virtual void __fastcall SetParameters(System::Classes::TStringList* const AStr);
	virtual System::WideString __fastcall GetParameters(void);
	
public:
	__classmethod virtual System::WideString __fastcall GetName();
	virtual Lmdtypes::TLMDByteArray __fastcall GetMessageAsBinary(Lmdlogmessage::TLMDLogMessage* const AMessage);
	virtual Lmdtypes::TLMDByteArray __fastcall GetHeaderAsBinary(void);
	virtual Lmdtypes::TLMDByteArray __fastcall GetFooterAsBinary(void);
public:
	/* TLMDLogCustomLayout.Create */ inline __fastcall virtual TLMDLogBinaryLayout(void) : Lmdloglayouttransport::TLMDLogCustomBinaryLayout() { }
	
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDLogBinaryLayout(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlogbinarylayout */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLOGBINARYLAYOUT)
using namespace Lmdlogbinarylayout;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlogbinarylayoutHPP
