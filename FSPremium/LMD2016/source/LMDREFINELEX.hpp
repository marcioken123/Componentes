// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDREFINELEX.pas' rev: 31.00 (Windows)

#ifndef LmdrefinelexHPP
#define LmdrefinelexHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDYParser.hpp>
#include <LMDREFINEParser.hpp>
#include <System.SysUtils.hpp>
#include <LMDSearchConsts.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrefinelex
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDREFINELEXLex;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDREFINELEXLex : public Lmdyparser::TYLex
{
	typedef Lmdyparser::TYLex inherited;
	
public:
	YYSType yylval;
	virtual int __fastcall yylex(void);
	virtual System::TObject* __fastcall GetYYlvalPonter(void);
	void __fastcall yyaction(int yyruleno);
public:
	/* TYLex.Create */ inline __fastcall TLMDREFINELEXLex(Lmdyparser::TYStream* aYStream) : Lmdyparser::TYLex(aYStream) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDREFINELEXLex(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrefinelex */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDREFINELEX)
using namespace Lmdrefinelex;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrefinelexHPP
