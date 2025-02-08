// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElStrPool.pas' rev: 31.00 (Windows)

#ifndef ElstrpoolHPP
#define ElstrpoolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <ElComponent.hpp>
#include <LMDUnicodeStrings.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elstrpool
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElStringPool;
//-- type declarations -------------------------------------------------------
typedef Lmdunicodestrings::TLMDWideStringArray TLMDStringArray;

class PASCALIMPLEMENTATION TElStringPool : public Elcomponent::TElComponent
{
	typedef Elcomponent::TElComponent inherited;
	
private:
	Lmdunicodestrings::TLMDWideStringArray* FItems;
	void __fastcall SetItems(Lmdunicodestrings::TLMDWideStringArray* newValue);
	
public:
	__fastcall virtual TElStringPool(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElStringPool(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property Lmdunicodestrings::TLMDWideStringArray* Items = {read=FItems, write=SetItems};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elstrpool */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSTRPOOL)
using namespace Elstrpool;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElstrpoolHPP
