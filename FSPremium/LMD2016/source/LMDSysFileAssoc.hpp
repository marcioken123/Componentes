// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysFileAssoc.pas' rev: 31.00 (Windows)

#ifndef LmdsysfileassocHPP
#define LmdsysfileassocHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDSysBaseComponent.hpp>
#include <LMDSysFileAssocInfo.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysLog.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysfileassoc
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysFileAssoc;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSysFileAssoc : public Lmdsysbasecomponent::TLMDSysBaseComponent
{
	typedef Lmdsysbasecomponent::TLMDSysBaseComponent inherited;
	
private:
	Lmdsysfileassocinfo::TLMDFileAssocsInfo* FFileAssoc;
	void __fastcall SetFileAssoc(Lmdsysfileassocinfo::TLMDFileAssocsInfo* const Value);
	
protected:
	virtual void __fastcall RefreshIt(void);
	
public:
	__fastcall virtual TLMDSysFileAssoc(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysFileAssoc(void);
	virtual System::TObject* __fastcall GetElement(int index);
	
__published:
	__property Lmdsysfileassocinfo::TLMDFileAssocsInfo* FileAssoc = {read=FFileAssoc, write=SetFileAssoc, stored=false};
	__property SysLog;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysfileassoc */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSFILEASSOC)
using namespace Lmdsysfileassoc;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysfileassocHPP
