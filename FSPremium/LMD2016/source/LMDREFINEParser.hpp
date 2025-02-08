// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDREFINEParser.pas' rev: 31.00 (Windows)

#ifndef LmdrefineparserHPP
#define LmdrefineparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDYParser.hpp>
#include <System.SysUtils.hpp>
#include <LMDBaseRefine.hpp>
#include <LMDSearchConsts.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------
#pragma pack(push,4)
struct YYSType{
#pragma pack(push,1)
union{
struct{ Lmdyparser::TSegment* yyTSegment; };
struct { char yyShortString[255]; };
};
#pragma pack(pop)
};
#pragma pack(pop)

namespace Lmdrefineparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDREFINEParser;
//-- type declarations -------------------------------------------------------
typedef YYSType *PYYSType;

class PASCALIMPLEMENTATION TLMDREFINEParser : public Lmdbaserefine::TYLMDRefineBaseParser
{
	typedef Lmdbaserefine::TYLMDRefineBaseParser inherited;
	
public:
	int yystate;
	int yysp;
	int yyn;
	System::StaticArray<int, 1024> yys;
	System::StaticArray<YYSType, 1024> yyv;
	YYSType yyval;
	virtual int __fastcall yyparse(void);
	void __fastcall yyaction(int yyruleno);
	bool __fastcall yyact(int state, int sym, int &act);
	bool __fastcall yygoto(int state, int sym, int &nstate);
	YYSType __fastcall Getyylval(void);
	__property YYSType yylval = {read=Getyylval};
public:
	/* TYLMDRefineBaseParser.Create */ inline __fastcall TLMDREFINEParser(Lmdyparser::TYLex* Lex) : Lmdbaserefine::TYLMDRefineBaseParser(Lex) { }
	/* TYLMDRefineBaseParser.Destroy */ inline __fastcall virtual ~TLMDREFINEParser(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word _AND = System::Word(0x101);
static const System::Word _OR = System::Word(0x102);
static const System::Word _NOT = System::Word(0x103);
static const System::Word _NEAR = System::Word(0x104);
static const System::Word IDENTIFIER = System::Word(0x105);
static const System::Word CHARACTER_STRING = System::Word(0x106);
static const System::Word ILLEGAL = System::Word(0x107);
}	/* namespace Lmdrefineparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDREFINEPARSER)
using namespace Lmdrefineparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrefineparserHPP
