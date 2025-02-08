// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDZCommonUnit.pas' rev: 34.00 (Windows)

#ifndef LmdzcommonunitHPP
#define LmdzcommonunitHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdzcommonunit
{
//-- forward type declarations -----------------------------------------------
struct ct_data_s;
struct TZStreamRec;
struct static_tree_desc_s;
struct tree_desc_s;
struct ptr_table_s;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD ct_data_s
{
	
public:
	union
	{
		struct 
		{
			int Code;
			int Len;
		};
		struct 
		{
			int Freq;
			int Dad;
		};
		
	};
};
#pragma pack(pop)


typedef ct_data_s ct_data;

typedef int PtrInt;

typedef unsigned PtrUInt;

typedef System::StaticArray<System::Byte, 4096> Arrayfff;

typedef Arrayfff *ArrayPtr;

typedef System::StaticArray<System::Word, 65536> ArrayWord;

typedef ArrayWord *ArrayWordPtr;

typedef System::StaticArray<int, 65536> ArrayInt;

typedef ArrayInt *ArrayIntPtr;

typedef System::StaticArray<unsigned, 65536> ArrayuInt;

typedef ArrayuInt *ArrayuIntPtr;

typedef System::StaticArray<ct_data_s, 65536> ArrayCt;

typedef ArrayCt *ArrayCtPtr;

typedef ArrayPtr Bytef;

typedef ArrayPtr *PBytef;

typedef unsigned ulg;

typedef System::Word ush;

typedef System::Word PosSh;

typedef ArrayWordPtr Posf;

typedef unsigned IPos;

typedef ArrayIntPtr Intf;

typedef System::Byte uch;

typedef ArrayPtr uchf;

typedef ArrayWordPtr ushf;

typedef ArrayuIntPtr uIntf;

typedef ArrayPtr *Bytefp;

typedef ArrayuIntPtr uLongf;

typedef void __fastcall (*voidpf)(void);

typedef void * __fastcall (*TAlloc)(void * AppData, int Items, int Size);

typedef void __fastcall (*TFree)(void * AppData, void * Block);

typedef TZStreamRec *PZStreamRec;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TZStreamRec
{
public:
	char *next_in;
	int avail_in;
	int total_in;
	char *next_out;
	int avail_out;
	int total_out;
	char *msg;
	void *internal;
	TAlloc zalloc;
	TFree zfree;
	void *AppData;
	int data_type;
	unsigned adler;
	int reserved;
};
#pragma pack(pop)


struct DECLSPEC_DRECORD static_tree_desc_s
{
public:
	ArrayCt *static_tree;
	ArrayInt *extra_bits;
	int extra_base;
	int elems;
	int max_length;
};


typedef static_tree_desc_s static_tree_desc;

struct DECLSPEC_DRECORD tree_desc_s
{
public:
	ArrayCt *dyn_tree;
	int max_code;
	static_tree_desc_s stat_desc;
};


typedef tree_desc_s tree_desc;

struct DECLSPEC_DRECORD ptr_table_s
{
public:
	void *org_ptr;
	void *new_ptr;
};


typedef ptr_table_s ptr_table;

//-- var, const, procedure ---------------------------------------------------
static const System::Word ENOUGH = System::Word(0x800);
static const System::Word MAXD = System::Word(0x250);
static const System::Int8 LENGTH_CODES = System::Int8(0x1d);
static const System::Word LITERALS = System::Word(0x100);
static const System::Word L_CODES = System::Word(0x11e);
static const System::Word HEAP_SIZE = System::Word(0x23d);
static const System::Int8 D_CODES = System::Int8(0x1e);
static const System::Int8 BL_CODES = System::Int8(0x13);
static const System::Int8 MAX_BITS = System::Int8(0xf);
#define ZLIB_VERSION L"1.2.3"
static const System::Word ZLIB_VERNUM = System::Word(0x1220);
static const System::Int8 Z_NO_FLUSH = System::Int8(0x0);
static const System::Int8 Z_PARTIAL_FLUSH = System::Int8(0x1);
static const System::Int8 Z_SYNC_FLUSH = System::Int8(0x2);
static const System::Int8 Z_FULL_FLUSH = System::Int8(0x3);
static const System::Int8 Z_FINISH = System::Int8(0x4);
static const System::Int8 Z_BLOCK = System::Int8(0x5);
static const System::Int8 Z_OK = System::Int8(0x0);
static const System::Int8 Z_STREAM_END = System::Int8(0x1);
static const System::Int8 Z_NEED_DICT = System::Int8(0x2);
static const System::Int8 Z_STREAM_ERROR = System::Int8(-2);
static const System::Int8 Z_DATA_ERROR = System::Int8(-3);
static const System::Int8 Z_MEM_ERROR = System::Int8(-4);
static const System::Int8 Z_BUF_ERROR = System::Int8(-5);
static const System::Int8 Z_VERSION_ERROR = System::Int8(-6);
#define Z_NULL (void*)(0)
static const System::Int8 MAX_PTR = System::Int8(0xa);
static const System::Int8 MAX_WBITS = System::Int8(0xf);
static const System::Int8 Z_RLE = System::Int8(0x3);
static const System::Int8 Z_FIXED = System::Int8(0x4);
static const System::Int8 Z_DEFLATED = System::Int8(0x8);
static const System::Int8 PRESET_DICT = System::Int8(0x20);
extern DELPHI_PACKAGE System::StaticArray<ptr_table_s, 11> table;
extern DELPHI_PACKAGE void __cdecl LMDMemCpy(void * dest, void * source, int count);
extern DELPHI_PACKAGE unsigned __fastcall adler32(unsigned adler, void * buf, unsigned len);
extern DELPHI_PACKAGE void * __fastcall zlibAllocMem(void * AppData, int Items, int Size);
extern DELPHI_PACKAGE void __fastcall zlibFreeMem(void * AppData, void * Block);
extern DELPHI_PACKAGE int __fastcall CCheck(int code);
}	/* namespace Lmdzcommonunit */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDZCOMMONUNIT)
using namespace Lmdzcommonunit;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdzcommonunitHPP
