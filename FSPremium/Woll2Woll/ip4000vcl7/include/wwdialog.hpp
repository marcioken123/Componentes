// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwDialog.pas' rev: 6.00

#ifndef wwDialogHPP
#define wwDialogHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <DB.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwdialog
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwCustomDialog;
class PASCALIMPLEMENTATION TwwCustomDialog : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
public:
	virtual bool __fastcall Execute(void) = 0 ;
	virtual Db::TDataSet* __fastcall GetPrimaryDataSet(void) = 0 ;
public:
	#pragma option push -w-inl
	/* TComponent.Create */ inline __fastcall virtual TwwCustomDialog(Classes::TComponent* AOwner) : Classes::TComponent(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TComponent.Destroy */ inline __fastcall virtual ~TwwCustomDialog(void) { }
	#pragma option pop
	
};


typedef TMetaClass* TwwCustomDialogClass;

//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwDialog)

}	/* namespace Wwdialog */
using namespace Wwdialog;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwDialog
