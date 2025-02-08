// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wwdatsrc.pas' rev: 6.00

#ifndef WwdatsrcHPP
#define WwdatsrcHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <DB.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwdatsrc
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwDataSource;
class PASCALIMPLEMENTATION TwwDataSource : public Db::TDataSource 
{
	typedef Db::TDataSource inherited;
	
public:
	#pragma option push -w-inl
	/* TDataSource.Create */ inline __fastcall virtual TwwDataSource(Classes::TComponent* AOwner) : Db::TDataSource(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TDataSource.Destroy */ inline __fastcall virtual ~TwwDataSource(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, Wwdatsrc)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwdatsrc */
using namespace Wwdatsrc;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Wwdatsrc
