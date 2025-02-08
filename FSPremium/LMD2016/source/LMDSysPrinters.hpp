// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysPrinters.pas' rev: 31.00 (Windows)

#ifndef LmdsysprintersHPP
#define LmdsysprintersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysPrinterInfo.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysprinters
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysPrinters;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysPrinters : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysprinterinfo::TLMDPrintersInfo* FPrinters;
	Lmdsysprinterinfo::TLMDSysPrinterDisplayInfos FDisplayInfo;
	void __fastcall SetPrinters(Lmdsysprinterinfo::TLMDPrintersInfo* const Value);
	void __fastcall SetDisplayInfo(const Lmdsysprinterinfo::TLMDSysPrinterDisplayInfos Value);
	
protected:
	virtual void __fastcall RefreshIt(void);
	
public:
	__fastcall virtual TLMDSysPrinters(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysPrinters(void);
	virtual System::TObject* __fastcall GetElement(int index);
	
__published:
	__property Lmdsysprinterinfo::TLMDPrintersInfo* Printers = {read=FPrinters, write=SetPrinters, stored=false};
	__property Lmdsysprinterinfo::TLMDSysPrinterDisplayInfos DisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=536870911};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysprinters */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSPRINTERS)
using namespace Lmdsysprinters;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysprintersHPP
