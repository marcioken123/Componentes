// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRequiredFieldValidator.pas' rev: 31.00 (Windows)

#ifndef LmdrequiredfieldvalidatorHPP
#define LmdrequiredfieldvalidatorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <LMDVldBase.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrequiredfieldvalidator
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRequiredFieldValidator;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDRequiredFieldValidator : public Lmdvldbase::TLMDCustomValidator
{
	typedef Lmdvldbase::TLMDCustomValidator inherited;
	
protected:
	virtual int __fastcall PerformValidation(System::UnicodeString value);
public:
	/* TLMDCustomValidator.Create */ inline __fastcall virtual TLMDRequiredFieldValidator(System::Classes::TComponent* AOwner) : Lmdvldbase::TLMDCustomValidator(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDRequiredFieldValidator(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrequiredfieldvalidator */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDREQUIREDFIELDVALIDATOR)
using namespace Lmdrequiredfieldvalidator;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrequiredfieldvalidatorHPP
