// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'Wwpict.pas' rev: 6.00

#ifndef WwpictHPP
#define WwpictHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwpict
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TwwPicResult { prComplete, prIncomplete, prEmpty, prError, prSyntax, prAmbiguous, prIncompNoFill };
#pragma option pop

class DELPHICLASS TwwPictureValidator;
class PASCALIMPLEMENTATION TwwPictureValidator : public System::TObject 
{
	typedef System::TObject inherited;
	
public:
	Word Status;
	Word Options;
	AnsiString *Pic;
	__fastcall TwwPictureValidator(const AnsiString APic, bool AutoFill);
	__fastcall virtual ~TwwPictureValidator(void);
	virtual bool __fastcall IsValidInput(AnsiString &S, bool SuppressFill);
	virtual bool __fastcall IsValid(const AnsiString S);
	virtual TwwPicResult __fastcall Picture(AnsiString &Input, bool AutoFill);
	bool __fastcall isSyntaxError(void);
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, Wwpict)

}	/* namespace Wwpict */
using namespace Wwpict;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Wwpict
