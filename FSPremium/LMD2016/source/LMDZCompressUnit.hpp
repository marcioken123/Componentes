// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDZCompressUnit.pas' rev: 34.00 (Windows)

#ifndef LmdzcompressunitHPP
#define LmdzcompressunitHPP

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
#include <LMDZCommonUnit.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdzcompressunit
{
//-- forward type declarations -----------------------------------------------
struct internal_state_s;
struct config_s;
//-- type declarations -------------------------------------------------------
typedef System::Byte *BytePtr;

typedef char * charf;

typedef System::Byte block_state;

typedef internal_state_s *internal_state;

struct DECLSPEC_DRECORD internal_state_s
{
public:
	Lmdzcommonunit::TZStreamRec *strm;
	int status;
	Lmdzcommonunit::Arrayfff *pending_buf;
	Lmdzcommonunit::Arrayfff *pending_out;
	unsigned pending_buf_size;
	int pending;
	int wrap;
	System::Byte data_type;
	System::Byte method;
	int last_flush;
	unsigned w_size;
	unsigned w_bits;
	unsigned w_mask;
	Lmdzcommonunit::Arrayfff *window;
	unsigned window_size;
	Lmdzcommonunit::ArrayWord *prev;
	Lmdzcommonunit::ArrayWord *head;
	unsigned ins_h;
	unsigned hash_size;
	unsigned hash_bits;
	unsigned hash_mask;
	unsigned hash_shift;
	int block_start;
	unsigned match_length;
	unsigned prev_match;
	int match_available;
	unsigned strstart;
	unsigned match_start;
	unsigned lookahead;
	unsigned prev_length;
	unsigned max_chain_length;
	unsigned max_lazy_match;
	int level;
	int strategy;
	unsigned good_match;
	int nice_match;
	System::StaticArray<Lmdzcommonunit::ct_data_s, 574> dyn_ltree;
	System::StaticArray<Lmdzcommonunit::ct_data_s, 62> dyn_dtree;
	System::StaticArray<Lmdzcommonunit::ct_data_s, 40> bl_tree;
	Lmdzcommonunit::tree_desc_s l_desc;
	Lmdzcommonunit::tree_desc_s d_desc;
	Lmdzcommonunit::tree_desc_s bl_desc;
	System::StaticArray<System::Word, 17> bl_count;
	System::StaticArray<int, 574> heap;
	int heap_len;
	int heap_max;
	System::StaticArray<System::Byte, 574> depth;
	Lmdzcommonunit::Arrayfff *l_buf;
	unsigned lit_bufsize;
	unsigned last_lit;
	Lmdzcommonunit::ArrayWord *d_buf;
	unsigned opt_len;
	unsigned static_len;
	unsigned matches;
	int last_eob_len;
	System::Word bi_buf;
	int bi_valid;
};


typedef internal_state *internal_state_p;

typedef internal_state deflate_state;

typedef System::Byte __fastcall (*compress_func)(internal_state_s &s, int &flush);

struct DECLSPEC_DRECORD config_s
{
public:
	System::Word good_length;
	System::Word max_lazy;
	System::Word nice_length;
	System::Word max_chain;
	compress_func func;
};


typedef config_s config;

typedef System::StaticArray<System::AnsiString, 11> Lmdzcompressunit__1;

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 Z_BINARY = System::Int8(0x0);
static const System::Int8 Z_TEXT = System::Int8(0x1);
static const System::Int8 Z_ASCII = System::Int8(0x1);
static const System::Int8 Z_UNKNOWN = System::Int8(0x2);
static const System::Int8 MAX_MEM_LEVEL = System::Int8(0x9);
static const System::Int8 DEF_MEM_LEVEL = System::Int8(0x8);
static const System::Int8 Z_NO_COMPRESSION = System::Int8(0x0);
static const System::Int8 Z_BEST_SPEED = System::Int8(0x1);
static const System::Int8 Z_BEST_COMPRESSION = System::Int8(0x9);
static const System::Int8 Z_DEFAULT_COMPRESSION = System::Int8(-1);
static const System::Int8 Z_FILTERED = System::Int8(0x1);
static const System::Int8 Z_DEFAULT_STRATEGY = System::Int8(0x0);
static const System::Int8 Z_HUFFMAN_ONLY = System::Int8(0x2);
static const System::Int8 need_more = System::Int8(0x0);
static const System::Int8 block_done = System::Int8(0x1);
static const System::Int8 finish_started = System::Int8(0x2);
static const System::Int8 finish_done = System::Int8(0x3);
static const System::Int8 Buf_size = System::Int8(0x10);
static const System::Int8 MIN_MATCH = System::Int8(0x3);
static const System::Word MAX_MATCH = System::Word(0x102);
static const System::Word MIN_LOOKAHEAD = System::Word(0x106);
static const System::Word DIST_CODE_LEN = System::Word(0x200);
static const System::Word END_BLOCK = System::Word(0x100);
static const System::Int8 MAX_BL_BITS = System::Int8(0x7);
static const System::Word TOO_FAR = System::Word(0x1000);
extern DELPHI_PACKAGE System::Word tmpi;
extern DELPHI_PACKAGE Lmdzcompressunit__1 z_errmsg;
extern DELPHI_PACKAGE int FORCE_STORED;
extern DELPHI_PACKAGE int FORCE_STATIC;
extern DELPHI_PACKAGE int FASTEST;
extern DELPHI_PACKAGE int GEN_TREES_H;
extern DELPHI_PACKAGE int STDC;
extern DELPHI_PACKAGE int ASMV;
extern DELPHI_PACKAGE char * __fastcall zlibVersion(void);
extern DELPHI_PACKAGE int __fastcall deflate(Lmdzcommonunit::TZStreamRec &strm, int flush);
extern DELPHI_PACKAGE int __fastcall deflateEnd(Lmdzcommonunit::TZStreamRec &strm);
extern DELPHI_PACKAGE int __fastcall deflateReset(Lmdzcommonunit::TZStreamRec &strm);
extern DELPHI_PACKAGE int __fastcall deflateInit2_(Lmdzcommonunit::TZStreamRec &strm, int level, int method, int windowBits, int memLevel, int strategy, char * version, int recsize);
extern DELPHI_PACKAGE int __fastcall deflateInit_(Lmdzcommonunit::TZStreamRec &strm, int level, char * version, int recsize);
extern DELPHI_PACKAGE void __fastcall CompressBuf(const void * InBuf, int InBytes, /* out */ void * &OutBuf, /* out */ int &OutBytes);
extern DELPHI_PACKAGE int __fastcall deflateSetDictionary(Lmdzcommonunit::TZStreamRec &strm, char * dictionary, unsigned dictLength);
}	/* namespace Lmdzcompressunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDZCOMPRESSUNIT)
using namespace Lmdzcompressunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdzcompressunitHPP
