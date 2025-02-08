// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDZUncompressUnit.pas' rev: 34.00 (Windows)

#ifndef LmdzuncompressunitHPP
#define LmdzuncompressunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>
#include <LMDZCommonUnit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdzuncompressunit
{
//-- forward type declarations -----------------------------------------------
struct code;
struct inflate_state_s;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD code
{
public:
	System::Byte op;
	System::Byte bits;
	System::Word val;
};
#pragma pack(pop)


typedef System::StaticArray<short, 321> TArrShr;

typedef TArrShr *PArrShr;

typedef System::StaticArray<short, 289> TArrShr288;

typedef TArrShr *PArrShr288;

typedef code *PCode;

typedef System::StaticArray<code, 2049> TArrCds;

typedef TArrCds *PArrCds;

typedef System::StaticArray<code, 32> TArrCds31;

typedef TArrCds31 *PArrCds31;

typedef System::StaticArray<code, 512> TArrCds511;

typedef TArrCds511 *PArrCds511;

enum DECLSPEC_DENUM inflate_mode : unsigned char { HEAD, DICTID, DICT, TYPEB, TYPEDO, STORED, SCOPY, TABLE, LENLENS, CODELENS, LEN, LENEXT, DIST, DISTEXT, MATCH, LIT, CHECK, DONE, BAD, MEM, SYNC };

typedef inflate_state_s *inflate_state;

struct DECLSPEC_DRECORD inflate_state_s
{
public:
	inflate_mode mode;
	int last;
	int wrap;
	int havedict;
	int flags;
	unsigned dmax;
	unsigned check;
	unsigned total;
	unsigned wbits;
	unsigned wsize;
	unsigned whave;
	unsigned Write;
	unsigned hold;
	unsigned bits;
	unsigned Length;
	unsigned offset;
	unsigned extra;
	char *window;
	TArrCds511 *lencode;
	TArrCds31 *distcode;
	unsigned lenbits;
	unsigned distbits;
	unsigned ncode;
	unsigned nlen;
	unsigned ndist;
	unsigned have;
	code *next;
	TArrShr lens;
	TArrShr288 work;
	TArrCds codes;
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word MANY = System::Word(0x5a0);
static const System::Int8 DEF_WBITS = System::Int8(0xf);
static const System::Int8 BMAX = System::Int8(0xf);
extern DELPHI_PACKAGE int __fastcall inflateEnd(Lmdzcommonunit::TZStreamRec &z);
extern DELPHI_PACKAGE int __fastcall inflateReset(Lmdzcommonunit::TZStreamRec &z);
extern DELPHI_PACKAGE int __fastcall inflateInit2_(Lmdzcommonunit::TZStreamRec &z, int w, const System::AnsiString version, int stream_size);
extern DELPHI_PACKAGE int __fastcall inflateInit_(Lmdzcommonunit::TZStreamRec &z, const System::AnsiString version, int stream_size);
extern DELPHI_PACKAGE int __fastcall uncompress(Lmdzcommonunit::ArrayPtr &dest, unsigned &destLen, Lmdzcommonunit::ArrayPtr source, unsigned sourceLen);
extern DELPHI_PACKAGE int __fastcall inflate(Lmdzcommonunit::TZStreamRec &z, int f);
}	/* namespace Lmdzuncompressunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDZUNCOMPRESSUNIT)
using namespace Lmdzuncompressunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdzuncompressunitHPP
