// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorCommon.pas' rev: 31.00 (Windows)

#ifndef LmdstorcommonHPP
#define LmdstorcommonHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.TypInfo.hpp>
#include <Winapi.Windows.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstorcommon
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDOSWriter;
class DELPHICLASS TLMDOSReader;
class DELPHICLASS TSafeWord;
//-- type declarations -------------------------------------------------------
typedef System::Sysutils::TSysCharSet TCharSet;

typedef System::UnicodeString UTF8String;

typedef UTF8String *PUTF8String;

class PASCALIMPLEMENTATION TLMDOSWriter : public System::Classes::TWriter
{
	typedef System::Classes::TWriter inherited;
	
public:
	void __fastcall LMDWriteComponent(System::Classes::TComponent* Component);
	void __fastcall LMDWriteObject(System::Classes::TPersistent* Value, System::UnicodeString Ident);
public:
	/* TWriter.Destroy */ inline __fastcall virtual ~TLMDOSWriter(void) { }
	
public:
	/* TFiler.Create */ inline __fastcall TLMDOSWriter(System::Classes::TStream* Stream, int BufSize) : System::Classes::TWriter(Stream, BufSize) { }
	
};


class PASCALIMPLEMENTATION TLMDOSReader : public System::Classes::TReader
{
	typedef System::Classes::TReader inherited;
	
public:
	void __fastcall LMDReadProperty(void);
	void __fastcall LMDReadObject(System::Classes::TPersistent* Instance);
public:
	/* TReader.Destroy */ inline __fastcall virtual ~TLMDOSReader(void) { }
	
public:
	/* TFiler.Create */ inline __fastcall TLMDOSReader(System::Classes::TStream* Stream, int BufSize) : System::Classes::TReader(Stream, BufSize) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TSafeWord : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Byte __fastcall GetLo(void);
	System::Byte __fastcall GetHi(void);
	
public:
	System::Word Value;
	__property System::Byte Lo = {read=GetLo, nodefault};
	__property System::Byte Hi = {read=GetHi, nodefault};
public:
	/* TObject.Create */ inline __fastcall TSafeWord(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TSafeWord(void) { }
	
};

#pragma pack(pop)

typedef System::Word TBufferSize;

typedef System::Word TBufferIndex;

typedef System::StaticArray<System::Byte, 32782> TABuffer;

typedef System::StaticArray<System::Word, 4096> LZTable;

typedef TABuffer *PBuffer;

typedef LZTable *PLZTable;

//-- var, const, procedure ---------------------------------------------------
static const System::Byte FLAG_Copied = System::Byte(0x80);
static const System::Word MaxBufferSize = System::Word(0x7fff);
static const System::Word MaxBufferIndex = System::Word(0x800d);
static const System::Int8 FLAG_Compress = System::Int8(0x40);
extern DELPHI_PACKAGE int __fastcall ReplaceChar(System::UnicodeString &S, System::WideChar ChOld, System::WideChar ChNew);
extern DELPHI_PACKAGE System::UnicodeString __fastcall DelChar(const System::UnicodeString S, System::WideChar Ch = (System::WideChar)(0x20));
extern DELPHI_PACKAGE int __fastcall WordPosition(const int N, const System::UnicodeString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ExtractWord(int N, const System::UnicodeString S, const System::Sysutils::TSysCharSet &WordDelims);
extern DELPHI_PACKAGE System::AnsiString __fastcall Base64Encode(System::AnsiString Buf);
extern DELPHI_PACKAGE System::UnicodeString __fastcall Base64Decode(System::AnsiString B64);
extern DELPHI_PACKAGE void __fastcall CreateDirs(System::UnicodeString szDir);
extern DELPHI_PACKAGE void __fastcall LMDStorLoadCompressedStream(System::Classes::TStream* src, System::Classes::TStream* target);
extern DELPHI_PACKAGE void __fastcall LMDStorSaveCompressedStream(System::Classes::TStream* src, System::Classes::TStream* target, int size);
extern DELPHI_PACKAGE TBufferSize __fastcall LMDLZRWCompress(TABuffer &Source, TABuffer &Dest, TBufferSize SourceSize);
extern DELPHI_PACKAGE TBufferSize __fastcall LMDLZRWDecompress(TABuffer &Source, TABuffer &Dest, TBufferSize Size);
}	/* namespace Lmdstorcommon */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORCOMMON)
using namespace Lmdstorcommon;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorcommonHPP
