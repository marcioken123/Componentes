// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysProcessor.pas' rev: 31.00 (Windows)

#ifndef LmdsysprocessorHPP
#define LmdsysprocessorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysProcessorObject.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysprocessor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysProcessor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysProcessor : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysprocessorobject::TLMDSysProcessorObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsysprocessorobject::TLMDSysProcessorObject* aValue);
	
public:
	__fastcall virtual TLMDSysProcessor(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsysprocessorobject::TLMDSysProcessorObject* Processor = {read=GetObj, write=SetObj};
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysProcessor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysprocessor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSPROCESSOR)
using namespace Lmdsysprocessor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysprocessorHPP
