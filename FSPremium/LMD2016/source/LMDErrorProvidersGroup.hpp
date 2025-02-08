// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDErrorProvidersGroup.pas' rev: 31.00 (Windows)

#ifndef LmderrorprovidersgroupHPP
#define LmderrorprovidersgroupHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDVldBase.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmderrorprovidersgroup
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDErrorProvidersGroup;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDErrorProvidersGroup : public Lmdvldbase::TLMDCustomErrorProvider
{
	typedef Lmdvldbase::TLMDCustomErrorProvider inherited;
	
protected:
	Lmdvldbase::TLMDErrorProviders* FErrorProviders;
	void __fastcall SetErrorProviders(Lmdvldbase::TLMDErrorProviders* const Value);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DoDisplayError(Lmdvldbase::_di_ILMDValidatedControl control, System::UnicodeString ErrorMsg, int ErrorLevel);
	
public:
	__fastcall virtual TLMDErrorProvidersGroup(System::Classes::TComponent* AComponent);
	__fastcall virtual ~TLMDErrorProvidersGroup(void);
	
__published:
	__property Lmdvldbase::TLMDErrorProviders* ErrorProviders = {read=FErrorProviders, write=SetErrorProviders};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmderrorprovidersgroup */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDERRORPROVIDERSGROUP)
using namespace Lmderrorprovidersgroup;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmderrorprovidersgroupHPP
