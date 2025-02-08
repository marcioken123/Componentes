// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDYParser.pas' rev: 31.00 (Windows)

#ifndef LmdyparserHPP
#define LmdyparserHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <LMDSearchConsts.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdyparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSegment;
class DELPHICLASS TYStream;
class DELPHICLASS TYConStream;
class DELPHICLASS TYVCLStream;
class DELPHICLASS TYLex;
class DELPHICLASS TYParser;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM YYSFlag : unsigned char { yyfnone, yyfaccept, yyfabort, yyferror };

typedef System::StaticArray<System::Variant, 134217727> TVariantArray;

typedef TVariantArray *PVariantArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSegment : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TVariantArray *FList;
	int FCount;
	int FCapacity;
	void __fastcall SetCode(int Index, const System::Variant &Value);
	System::Variant __fastcall GetCode(int Index);
	void __fastcall SetLastCode(const System::Variant &Value);
	System::Variant __fastcall GetLastCode(void);
	void __fastcall SetCount(const int Value);
	void __fastcall SetCapacity(const int Value);
	virtual void __fastcall Grow(void);
	
public:
	System::TObject* Data;
	int lRes;
	__property System::Variant Codes[int Index] = {read=GetCode, write=SetCode};
	__property System::Variant Code = {read=GetLastCode, write=SetLastCode};
	__property int Count = {read=FCount, write=SetCount, nodefault};
	__property int Capacity = {read=FCapacity, write=SetCapacity, nodefault};
	__fastcall TSegment(void);
	__fastcall virtual ~TSegment(void);
	void __fastcall Clear(void);
	void __fastcall AddCodes(const System::Variant *Values, const int Values_High);
	virtual void __fastcall AddSegment(TSegment* Seg);
	void __fastcall AddCode(const System::Variant &Value);
	void __fastcall Delete(int Index);
	System::Variant __fastcall Pop(void);
	bool __fastcall Load(System::Classes::TReader* Reader);
	bool __fastcall Save(System::Classes::TWriter* Writer);
	int __fastcall ParamsCount(void);
	System::Variant __fastcall GetParam(int Index, const System::Variant &Def);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TYStream : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int yylineno;
	int yycolno;
	virtual void __fastcall fatal(System::UnicodeString msg) = 0 ;
	virtual System::WideChar __fastcall get_char(void) = 0 ;
	virtual void __fastcall unget_char(System::WideChar c) = 0 ;
	virtual void __fastcall put_char(System::WideChar c) = 0 ;
	virtual void __fastcall yyclear(void) = 0 ;
	virtual bool __fastcall yywrap(void);
	virtual void __fastcall message(System::UnicodeString msg) = 0 ;
public:
	/* TObject.Create */ inline __fastcall TYStream(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TYStream(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TYConStream : public TYStream
{
	typedef TYStream inherited;
	
protected:
	int bufptr;
	System::StaticArray<System::WideChar, 2048> buf;
	System::TextFile yyinput;
	System::TextFile yyoutput;
	System::UnicodeString yyline;
	
public:
	__fastcall TYConStream(void);
	__fastcall virtual ~TYConStream(void);
	virtual void __fastcall fatal(System::UnicodeString msg);
	virtual System::WideChar __fastcall get_char(void);
	virtual void __fastcall unget_char(System::WideChar c);
	virtual void __fastcall put_char(System::WideChar c);
	virtual void __fastcall yyclear(void);
	virtual void __fastcall message(System::UnicodeString msg);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TYVCLStream : public TYStream
{
	typedef TYStream inherited;
	
public:
	System::Classes::TMemoryStream* aInStream;
	System::Classes::TMemoryStream* aOutStream;
	__fastcall TYVCLStream(void);
	__fastcall virtual ~TYVCLStream(void);
	void __fastcall LoadFromStrings(System::Classes::TStrings* aStrings);
	void __fastcall SaveToStrings(System::Classes::TStrings* aStrings);
	virtual void __fastcall fatal(System::UnicodeString msg);
	virtual System::WideChar __fastcall get_char(void);
	virtual void __fastcall unget_char(System::WideChar c);
	virtual void __fastcall put_char(System::WideChar c);
	virtual void __fastcall yyclear(void);
	virtual bool __fastcall yywrap(void);
	virtual void __fastcall message(System::UnicodeString msg);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TYLex : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	TYStream* FYStream;
	System::UnicodeString yystext;
	int yysstate;
	int yylstate;
	int yymatches;
	System::StaticArray<int, 1024> yystack;
	System::StaticArray<int, 256> yypos;
	int yysleng;
	
public:
	System::UnicodeString yytext;
	int yystate;
	System::WideChar yyactchar;
	System::WideChar yylastchar;
	int yyrule;
	bool yyreject;
	bool yydone;
	int yyretval;
	__fastcall TYLex(TYStream* aYStream);
	virtual int __fastcall yylex(void) = 0 ;
	System::Byte __fastcall GetTextLen(void);
	virtual void __fastcall echo(void);
	virtual void __fastcall yymore(void);
	virtual void __fastcall yyless(int n);
	virtual void __fastcall reject(void);
	virtual void __fastcall returnn(int n);
	virtual void __fastcall returnc(System::WideChar c);
	virtual void __fastcall start(int state);
	virtual bool __fastcall yywrap(void);
	void __fastcall yynew(void);
	void __fastcall yyscan(void);
	void __fastcall yymark(int n);
	void __fastcall yymatch(int n);
	bool __fastcall yyfind(int &n);
	bool __fastcall yydefault(void);
	void __fastcall yyclear(void);
	void __fastcall fatal(System::UnicodeString msg);
	System::WideChar __fastcall get_char(void);
	void __fastcall unget_char(System::WideChar c);
	void __fastcall put_char(System::WideChar c);
	void __fastcall message(System::UnicodeString msg);
	virtual System::TObject* __fastcall GetYYlvalPonter(void) = 0 ;
	__property System::Byte yyleng = {read=GetTextLen, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TYLex(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TYParser : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	TYLex* FYLex;
	virtual int __fastcall yylex(void);
	virtual int __fastcall yyparse(void) = 0 ;
	
public:
	TSegment* CodeSeg;
	TSegment* DataSeg;
	TSegment* Stack;
	System::Classes::TNotifyEvent FErrorProc;
	int yychar;
	int yynerrs;
	bool yydebug;
	YYSFlag yyflag;
	int yyerrflag;
	virtual void __fastcall yyerror(System::UnicodeString msg);
	virtual void __fastcall yyclearin(void);
	virtual void __fastcall yyaccept(void);
	virtual void __fastcall yyabort(void);
	virtual void __fastcall yyerrlab(void);
	virtual void __fastcall yyerrok(void);
	__fastcall TYParser(TYLex* aYLex);
	__fastcall virtual ~TYParser(void);
	int __fastcall Getyylineno(void);
	int __fastcall Getyycolno(void);
	__property int yylineno = {read=Getyylineno, nodefault};
	__property int yycolno = {read=Getyycolno, nodefault};
	
__published:
	__property TYLex* YLex = {read=FYLex, write=FYLex, default=0};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word yymaxdepth = System::Word(0x400);
static const System::WideChar nl = (System::WideChar)(0xa);
static const System::Word max_chars = System::Word(0x800);
static const System::Word max_matches = System::Word(0x400);
static const System::Word max_rules = System::Word(0x100);
static const unsigned NULL_VAR = unsigned(0x80000000);
static const System::Int8 MAX_PARAMS = System::Int8(0xf);
#define TooManyRules L"too many rules"
#define MatchStackOverflow L"match stack overflow"
#define AtLine L"at line"
#define InputBufferOverflow L"input buffer overflow"
#define FatalError L"Fatal error"
#define UnexpectedEOFInsideComment L"Unexpected EOF inside comment"
#define YyparseStackOverflow L"yyparse stack overflow"
#define StateMsg L"state"
#define CharMsg L"char"
#define SyntaxError L"syntax error"
#define ErrorRecoveryPopsState L"error recovery pops state"
#define Uncovers L"uncovers"
#define ErrorRecoveryFailsAbort L"error recovery fails ... abort"
#define ErrorRecoveryDiscardsChar L"error recovery discards char"
#define ReduceMsg L"reduce"
}	/* namespace Lmdyparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDYPARSER)
using namespace Lmdyparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdyparserHPP
