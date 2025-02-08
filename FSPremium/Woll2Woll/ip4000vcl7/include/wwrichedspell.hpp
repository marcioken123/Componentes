// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwrichedspell.pas' rev: 6.00

#ifndef wwrichedspellHPP
#define wwrichedspellHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Controls.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <ComCtrls.hpp>	// Pascal unit
#include <wwriched.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwrichedspell
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwDBRichEditMSWord;
class PASCALIMPLEMENTATION TwwDBRichEditMSWord : public Wwriched::TwwDBRichEdit 
{
	typedef Wwriched::TwwDBRichEdit inherited;
	
public:
	virtual bool __fastcall MSWordSpellChecker(void);
public:
	#pragma option push -w-inl
	/* TwwDBRichEdit.Create */ inline __fastcall virtual TwwDBRichEditMSWord(Classes::TComponent* AOwner) : Wwriched::TwwDBRichEdit(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TwwDBRichEdit.Destroy */ inline __fastcall virtual ~TwwDBRichEditMSWord(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TwwDBRichEditMSWord(HWND ParentWindow) : Wwriched::TwwDBRichEdit(ParentWindow) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwrichedspell)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwrichedspell */
using namespace Wwrichedspell;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwrichedspell
