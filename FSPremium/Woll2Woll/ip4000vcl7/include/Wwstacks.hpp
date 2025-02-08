// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwStacks.pas' rev: 6.00

#ifndef wwStacksHPP
#define wwStacksHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwstacks
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TStackStr;
class PASCALIMPLEMENTATION TStackStr : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TStringList* list;
	
public:
	void __fastcall push(AnsiString s);
	AnsiString __fastcall pop();
	__fastcall TStackStr(void);
	__fastcall virtual ~TStackStr(void);
	int __fastcall count(void);
};


class DELPHICLASS TStackPtr;
class PASCALIMPLEMENTATION TStackPtr : public System::TObject 
{
	typedef System::TObject inherited;
	
private:
	Classes::TList* list;
	
public:
	void __fastcall push(void * s);
	void * __fastcall pop(void);
	__fastcall TStackPtr(void);
	__fastcall virtual ~TStackPtr(void);
	int __fastcall count(void);
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwStacks)

}	/* namespace Wwstacks */
using namespace Wwstacks;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwStacks
