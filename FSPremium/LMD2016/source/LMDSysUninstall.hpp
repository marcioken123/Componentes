// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysUninstall.pas' rev: 31.00 (Windows)

#ifndef LmdsysuninstallHPP
#define LmdsysuninstallHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysUninstallInfo.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysLog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysuninstall
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysUninstall;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysUninstall : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysuninstallinfo::TLMDUninstallInfo* FUninstall;
	void __fastcall SetUninstall(Lmdsysuninstallinfo::TLMDUninstallInfo* const Value);
	
protected:
	virtual void __fastcall RefreshIt(void);
	
public:
	__fastcall virtual TLMDSysUninstall(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysUninstall(void);
	virtual System::TObject* __fastcall GetElement(int index);
	
__published:
	__property Lmdsysuninstallinfo::TLMDUninstallInfo* Uninstall = {read=FUninstall, write=SetUninstall, stored=false};
	__property SysLog;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysuninstall */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSUNINSTALL)
using namespace Lmdsysuninstall;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysuninstallHPP
