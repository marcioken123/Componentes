// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysModem.pas' rev: 31.00 (Windows)

#ifndef LmdsysmodemHPP
#define LmdsysmodemHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysModemInfo.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysLog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysmodem
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysModem;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysModem : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysmodeminfo::TLMDSysModemDisplayInfos FDisplayInfo;
	Lmdsysmodeminfo::TLMDModemInfo* FModems;
	void __fastcall SetModem(Lmdsysmodeminfo::TLMDModemInfo* const Value);
	void __fastcall SetDisplayInfo(const Lmdsysmodeminfo::TLMDSysModemDisplayInfos Value);
	
protected:
	virtual void __fastcall RefreshIt(void);
	
public:
	__fastcall virtual TLMDSysModem(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysModem(void);
	virtual System::TObject* __fastcall GetElement(int index);
	
__published:
	__property Lmdsysmodeminfo::TLMDModemInfo* Modems = {read=FModems, write=SetModem, stored=false};
	__property Lmdsysmodeminfo::TLMDSysModemDisplayInfos DisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=15};
	__property SysLog;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysmodem */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSMODEM)
using namespace Lmdsysmodem;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysmodemHPP
