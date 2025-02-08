// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwfilter.pas' rev: 6.00

#ifndef wwfilterHPP
#define wwfilterHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <BDE.hpp>	// Pascal unit
#include <Wwstr.hpp>	// Pascal unit
#include <wwStacks.hpp>	// Pascal unit
#include <DB.hpp>	// Pascal unit
#include <DBTables.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwfilter
{
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwfilter)
extern PACKAGE bool __fastcall wwSetFilter(AnsiString a_line, Dbtables::TTable* table, Bde::hDBIFilter &fh, bool InOpen);
extern PACKAGE void __fastcall wwRemoveFilter(Dbtables::TDBDataSet* table, Bde::hDBIFilter &fh);
extern PACKAGE bool __fastcall wwAddFilter(AnsiString a_line, Dbtables::TTable* table, Bde::hDBIFilter &fh);
extern PACKAGE bool __fastcall wwSetFilterFunction(void * func, Dbtables::TDBDataSet* table, Bde::hDBIFilter &fh);

}	/* namespace Wwfilter */
using namespace Wwfilter;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwfilter
