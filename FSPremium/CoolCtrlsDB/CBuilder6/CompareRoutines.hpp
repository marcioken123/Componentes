// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CompareRoutines.pas' rev: 6.00

#ifndef CompareRoutinesHPP
#define CompareRoutinesHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Math.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Compareroutines
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TStrComparer;
class PASCALIMPLEMENTATION TStrComparer : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	AnsiString ConsonantedS1;
	AnsiString ConsonantedS2;
	AnsiString VoweledS1;
	AnsiString VoweledS2;
	AnsiString DigitedS1;
	AnsiString DigitedS2;
	bool EmptyConsonants;
	bool EmptyVowels;
	bool EmptyDigits;
	bool __fastcall IsConsonant(char Ch);
	bool __fastcall IsVowel(char Ch);
	bool __fastcall IsDigit(char Ch);
	void __fastcall Parse(AnsiString S1, AnsiString S2);
	bool __fastcall CompareByPart(AnsiString S1, AnsiString S2);
	bool __fastcall CompareByConsonants(void);
	bool __fastcall CompareByVowels(void);
	bool __fastcall CompareByDigits(void);
	bool __fastcall CompareByConsonantsByPart(void);
	bool __fastcall CompareByVowelsByPart(void);
	bool __fastcall CompareByDigitsByPart(void);
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TStrComparer(void) : System::TObject() { }
	#pragma option pop
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~TStrComparer(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Compareroutines */
using namespace Compareroutines;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CompareRoutines
