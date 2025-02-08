// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwProvider.pas' rev: 6.00

#ifndef wwProviderHPP
#define wwProviderHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <DB.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <Wwcommon.hpp>	// Pascal unit
#include <Variants.hpp>	// Pascal unit
#include <Provider.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwprovider
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwProvider;
class PASCALIMPLEMENTATION TwwProvider : public Provider::TProvider 
{
	typedef Provider::TProvider inherited;
	
public:
	virtual OleVariant __fastcall DataRequest(const OleVariant &Input);
public:
	#pragma option push -w-inl
	/* TDataSetProvider.Create */ inline __fastcall virtual TwwProvider(Classes::TComponent* AOwner) : Provider::TProvider(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TDataSetProvider.Destroy */ inline __fastcall virtual ~TwwProvider(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwProvider)

}	/* namespace Wwprovider */
using namespace Wwprovider;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwProvider
