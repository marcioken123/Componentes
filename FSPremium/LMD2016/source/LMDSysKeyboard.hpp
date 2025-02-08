// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysKeyboard.pas' rev: 31.00 (Windows)

#ifndef LmdsyskeyboardHPP
#define LmdsyskeyboardHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysKeyboardObject.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysLog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyskeyboard
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysKeyboard;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysKeyboard : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsyskeyboardobject::TLMDSysKeyboardObject* __fastcall GetObj(void);
	void __fastcall SetObj(Lmdsyskeyboardobject::TLMDSysKeyboardObject* aValue);
	
public:
	__fastcall virtual TLMDSysKeyboard(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdsyskeyboardobject::TLMDSysKeyboardObject* Keyboard = {read=GetObj, write=SetObj};
	__property SysLog;
public:
	/* TLMDSysBaseComponent.Destroy */ inline __fastcall virtual ~TLMDSysKeyboard(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsyskeyboard */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSKEYBOARD)
using namespace Lmdsyskeyboard;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyskeyboardHPP
