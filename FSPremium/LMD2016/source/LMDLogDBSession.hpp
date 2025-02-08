// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLogDBSession.pas' rev: 31.00 (Windows)

#ifndef LmdlogdbsessionHPP
#define LmdlogdbsessionHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.TypInfo.hpp>
#include <Data.DB.hpp>
#include <LMDUnicode.hpp>
#include <LMDLogMessage.hpp>
#include <LMDStrings.hpp>
#include <LMDIniCtrl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlogdbsession
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLogDBSession;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDLogDBSession : public Lmdlogmessage::TLMDLogCustomSession
{
	typedef Lmdlogmessage::TLMDLogCustomSession inherited;
	
public:
	__classmethod virtual System::WideString __fastcall GetName();
	void __fastcall SendDataSet(Lmdlogmessage::TLMDLogLevel* ALogLevel, System::UnicodeString AName, Data::Db::TDataSet* ADataSet)/* overload */;
	void __fastcall SendDataSet(System::UnicodeString AName, Data::Db::TDataSet* ADataSet)/* overload */;
	void __fastcall SendDataSetStructure(Lmdlogmessage::TLMDLogLevel* ALogLevel, System::UnicodeString AName, Data::Db::TDataSet* ADataSet)/* overload */;
	void __fastcall SendDataSetStructure(System::UnicodeString AName, Data::Db::TDataSet* ADataSet)/* overload */;
public:
	/* TLMDLogCustomSession.Create */ inline __fastcall virtual TLMDLogDBSession(Lmdlogmessage::TLMDLogManager* AOwner, const Lmdtypes::TLMDString AName, Lmdlogmessage::_di_ILMDLogTransport ATransport) : Lmdlogmessage::TLMDLogCustomSession(AOwner, AName, ATransport) { }
	/* TLMDLogCustomSession.Destroy */ inline __fastcall virtual ~TLMDLogDBSession(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdlogdbsession */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLOGDBSESSION)
using namespace Lmdlogdbsession;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlogdbsessionHPP
