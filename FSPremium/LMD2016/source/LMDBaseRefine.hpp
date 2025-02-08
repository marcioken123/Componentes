// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBaseRefine.pas' rev: 31.00 (Windows)

#ifndef LmdbaserefineHPP
#define LmdbaserefineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Variants.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDYParser.hpp>
#include <System.SysUtils.hpp>
#include <LMDStrSupp.hpp>
#include <LMDStrings.hpp>
#include <LMDWildcardUnit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbaserefine
{
//-- forward type declarations -----------------------------------------------
struct TLMDRefineDetailPositionItem;
struct TLMDRefineDetailItem;
class DELPHICLASS TLMDRefineExecuter;
class DELPHICLASS TYLMDRefineBaseParser;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TLMDRefineDetailPositionItem
{
public:
	System::UnicodeString ActualWord;
	int Position;
};


struct DECLSPEC_DRECORD TLMDRefineDetailItem
{
	
private:
	typedef System::DynamicArray<TLMDRefineDetailPositionItem> _TLMDRefineDetailItem__1;
	
	
public:
	System::UnicodeString SearchWord;
	_TLMDRefineDetailItem__1 Positions;
};


typedef System::DynamicArray<TLMDRefineDetailItem> TLMDRefineDetail;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRefineExecuter : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDRefineDetail FDetail;
	Lmdyparser::TSegment* FStack;
	Lmdyparser::TSegment* FCode;
	System::Classes::TStream* FStream;
	int iPos;
	int FNearLength;
	bool FWholeWordsOnly;
	bool FMatchCase;
	bool __fastcall ExecuteCommand(void);
	
public:
	System::WideChar AnySingleCharacter;
	System::WideChar AnySequenceCharacter;
	__fastcall TLMDRefineExecuter(void);
	__fastcall virtual ~TLMDRefineExecuter(void);
	bool __fastcall ExecuteCode(Lmdyparser::TSegment* Code, System::UnicodeString szText);
	bool __fastcall ExecuteCodeByStream(Lmdyparser::TSegment* Code, System::Classes::TStream* Stream);
	__property TLMDRefineDetail Detail = {read=FDetail};
	__property int NearLength = {read=FNearLength, write=FNearLength, nodefault};
	__property bool WholeWordsOnly = {read=FWholeWordsOnly, write=FWholeWordsOnly, nodefault};
	__property bool MatchCase = {read=FMatchCase, write=FMatchCase, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TYLMDRefineBaseParser : public Lmdyparser::TYParser
{
	typedef Lmdyparser::TYParser inherited;
	
protected:
	Lmdyparser::TSegment* FCode;
	
public:
	__fastcall TYLMDRefineBaseParser(Lmdyparser::TYLex* Lex);
	__fastcall virtual ~TYLMDRefineBaseParser(void);
	__property Lmdyparser::TSegment* Code = {read=FCode};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 C_CONST = System::Int8(0x0);
static const System::Int8 C_AND = System::Int8(0x1);
static const System::Int8 C_OR = System::Int8(0x2);
static const System::Int8 C_NEAR = System::Int8(0x3);
static const System::Int8 C_NOT = System::Int8(0x4);
}	/* namespace Lmdbaserefine */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASEREFINE)
using namespace Lmdbaserefine;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbaserefineHPP
