// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysFonts.pas' rev: 31.00 (Windows)

#ifndef LmdsysfontsHPP
#define LmdsysfontsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysFontInfo.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysfonts
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysFonts;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysFonts : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysfontinfo::TLMDFontsInfo* FFonts;
	void __fastcall SetFonts(Lmdsysfontinfo::TLMDFontsInfo* const Value);
	
protected:
	virtual void __fastcall RefreshIt(void);
	
public:
	__fastcall virtual TLMDSysFonts(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysFonts(void);
	virtual System::TObject* __fastcall GetElement(int index);
	
__published:
	__property Lmdsysfontinfo::TLMDFontsInfo* Fonts = {read=FFonts, write=SetFonts, stored=false};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysfonts */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSFONTS)
using namespace Lmdsysfonts;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysfontsHPP
