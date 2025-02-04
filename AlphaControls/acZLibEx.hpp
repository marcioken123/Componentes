// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acZLibEx.pas' rev: 27.00 (Windows)

#ifndef AczlibexHPP
#define AczlibexHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Aczlibex
{
//-- type declarations -------------------------------------------------------
typedef void * __fastcall (*TZAlloc)(void * opaque, int items, int size);

typedef void __fastcall (*TZFree)(void * opaque, void * block);

enum DECLSPEC_DENUM TZCompressionLevel : unsigned char { zcNone, zcFastest, zcDefault, zcMax, zcLevel1, zcLevel2, zcLevel3, zcLevel4, zcLevel5, zcLevel6, zcLevel7, zcLevel8, zcLevel9 };

enum DECLSPEC_DENUM TZStrategy : unsigned char { zsDefault, zsFiltered, zsHuffman, zsRLE, zsFixed };

enum DECLSPEC_DENUM TZError : unsigned char { zeError, zeStreamError, zeDataError, zeMemoryError, zeBufferError, zeVersionError };

#pragma pack(push,1)
struct DECLSPEC_DRECORD TZStreamRec
{
public:
	System::WideChar *next_in;
	int avail_in;
	int total_in;
	System::WideChar *next_out;
	int avail_out;
	int total_out;
	System::WideChar *msg;
	void *state;
	TZAlloc zalloc;
	TZFree zfree;
	void *opaque;
	int data_type;
	int adler;
	int reserved;
};
#pragma pack(pop)


class DELPHICLASS TCustomZStream;
class PASCALIMPLEMENTATION TCustomZStream : public System::Classes::TStream
{
	typedef System::Classes::TStream inherited;
	
private:
	System::Classes::TStream* FStream;
	__int64 FStreamPos;
	System::Classes::TNotifyEvent FOnProgress;
	TZStreamRec FZStream;
	System::StaticArray<System::WideChar, 65536> FBuffer;
	
protected:
	void __fastcall DoProgress(void);
	__property System::Classes::TNotifyEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	
public:
	__fastcall TCustomZStream(System::Classes::TStream* stream);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TCustomZStream(void) { }
	
};


class DELPHICLASS TZCompressionStream;
class PASCALIMPLEMENTATION TZCompressionStream : public TCustomZStream
{
	typedef TCustomZStream inherited;
	
private:
	float __fastcall GetCompressionRate(void);
	
public:
	__fastcall TZCompressionStream(System::Classes::TStream* dest, TZCompressionLevel compressionLevel)/* overload */;
	__fastcall TZCompressionStream(System::Classes::TStream* dest, TZCompressionLevel compressionLevel, int windowBits, int memLevel, TZStrategy strategy)/* overload */;
	__fastcall virtual ~TZCompressionStream(void);
	virtual int __fastcall Read(void *buffer, int count)/* overload */;
	virtual int __fastcall Write(const void *buffer, int count)/* overload */;
	virtual int __fastcall Seek(int offset, System::Word origin)/* overload */;
	__property float CompressionRate = {read=GetCompressionRate};
	__property OnProgress;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Read(System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	inline __int64 __fastcall  Seek(const __int64 Offset, System::Classes::TSeekOrigin Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	inline __int64 __fastcall  Seek _DEPRECATED_ATTRIBUTE0 (const __int64 Offset, System::Word Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	
};


class DELPHICLASS TZDecompressionStream;
class PASCALIMPLEMENTATION TZDecompressionStream : public TCustomZStream
{
	typedef TCustomZStream inherited;
	
public:
	__fastcall TZDecompressionStream(System::Classes::TStream* source)/* overload */;
	__fastcall TZDecompressionStream(System::Classes::TStream* source, int windowBits)/* overload */;
	__fastcall virtual ~TZDecompressionStream(void);
	virtual int __fastcall Read(void *buffer, int count)/* overload */;
	virtual int __fastcall Write(const void *buffer, int count)/* overload */;
	virtual int __fastcall Seek(int offset, System::Word origin)/* overload */;
	__property OnProgress;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Read(System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	inline __int64 __fastcall  Seek(const __int64 Offset, System::Classes::TSeekOrigin Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	inline __int64 __fastcall  Seek _DEPRECATED_ATTRIBUTE0 (const __int64 Offset, System::Word Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	
};


typedef System::TMetaClass* EZLibErrorClass;

class DELPHICLASS EZLibError;
#pragma pack(push,4)
class PASCALIMPLEMENTATION EZLibError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
private:
	int FErrorCode;
	
public:
	__fastcall EZLibError(int code, const System::UnicodeString dummy)/* overload */;
	__fastcall EZLibError(TZError error, const System::UnicodeString dummy)/* overload */;
	__property int ErrorCode = {read=FErrorCode, write=FErrorCode, nodefault};
public:
	/* Exception.CreateFmt */ inline __fastcall EZLibError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EZLibError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EZLibError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EZLibError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EZLibError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EZLibError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EZLibError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EZLibError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EZLibError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EZLibError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EZLibError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EZLibError(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS EZCompressionError;
#pragma pack(push,4)
class PASCALIMPLEMENTATION EZCompressionError : public EZLibError
{
	typedef EZLibError inherited;
	
public:
	/* EZLibError.Create */ inline __fastcall EZCompressionError(int code, const System::UnicodeString dummy)/* overload */ : EZLibError(code, dummy) { }
	/* EZLibError.Create */ inline __fastcall EZCompressionError(TZError error, const System::UnicodeString dummy)/* overload */ : EZLibError(error, dummy) { }
	
public:
	/* Exception.CreateFmt */ inline __fastcall EZCompressionError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High) : EZLibError(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EZCompressionError(NativeUInt Ident)/* overload */ : EZLibError(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EZCompressionError(System::PResStringRec ResStringRec)/* overload */ : EZLibError(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EZCompressionError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High)/* overload */ : EZLibError(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EZCompressionError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High)/* overload */ : EZLibError(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EZCompressionError(const System::UnicodeString Msg, int AHelpContext) : EZLibError(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EZCompressionError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High, int AHelpContext) : EZLibError(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EZCompressionError(NativeUInt Ident, int AHelpContext)/* overload */ : EZLibError(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EZCompressionError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : EZLibError(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EZCompressionError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : EZLibError(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EZCompressionError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : EZLibError(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EZCompressionError(void) { }
	
};

#pragma pack(pop)

class DELPHICLASS EZDecompressionError;
#pragma pack(push,4)
class PASCALIMPLEMENTATION EZDecompressionError : public EZLibError
{
	typedef EZLibError inherited;
	
public:
	/* EZLibError.Create */ inline __fastcall EZDecompressionError(int code, const System::UnicodeString dummy)/* overload */ : EZLibError(code, dummy) { }
	/* EZLibError.Create */ inline __fastcall EZDecompressionError(TZError error, const System::UnicodeString dummy)/* overload */ : EZLibError(error, dummy) { }
	
public:
	/* Exception.CreateFmt */ inline __fastcall EZDecompressionError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High) : EZLibError(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EZDecompressionError(NativeUInt Ident)/* overload */ : EZLibError(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EZDecompressionError(System::PResStringRec ResStringRec)/* overload */ : EZLibError(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EZDecompressionError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High)/* overload */ : EZLibError(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EZDecompressionError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High)/* overload */ : EZLibError(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EZDecompressionError(const System::UnicodeString Msg, int AHelpContext) : EZLibError(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EZDecompressionError(const System::UnicodeString Msg, System::TVarRec const *Args, const int Args_High, int AHelpContext) : EZLibError(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EZDecompressionError(NativeUInt Ident, int AHelpContext)/* overload */ : EZLibError(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EZDecompressionError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : EZLibError(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EZDecompressionError(System::PResStringRec ResStringRec, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : EZLibError(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EZDecompressionError(NativeUInt Ident, System::TVarRec const *Args, const int Args_High, int AHelpContext)/* overload */ : EZLibError(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EZDecompressionError(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
#define acZLIB_VERSION L"1.2.3"
static const System::Word acZLIB_VERNUM = System::Word(0x1230);
static const System::Int8 Z_DEFLATED = System::Int8(0x8);
static const System::Int8 Z_NO_FLUSH = System::Int8(0x0);
static const System::Int8 Z_PARTIAL_FLUSH = System::Int8(0x1);
static const System::Int8 Z_SYNC_FLUSH = System::Int8(0x2);
static const System::Int8 Z_FULL_FLUSH = System::Int8(0x3);
static const System::Int8 Z_FINISH = System::Int8(0x4);
static const System::Int8 Z_BLOCK = System::Int8(0x5);
static const System::Int8 Z_OK = System::Int8(0x0);
static const System::Int8 Z_STREAM_END = System::Int8(0x1);
static const System::Int8 Z_NEED_DICT = System::Int8(0x2);
static const System::Int8 Z_ERRNO = System::Int8(-1);
static const System::Int8 Z_STREAM_ERROR = System::Int8(-2);
static const System::Int8 Z_DATA_ERROR = System::Int8(-3);
static const System::Int8 Z_MEM_ERROR = System::Int8(-4);
static const System::Int8 Z_BUF_ERROR = System::Int8(-5);
static const System::Int8 Z_VERSION_ERROR = System::Int8(-6);
extern DELPHI_PACKAGE int __fastcall InflateInit(TZStreamRec &stream);
extern DELPHI_PACKAGE void __fastcall ZCompress(const void * inBuffer, int inSize, /* out */ void * &outBuffer, /* out */ int &outSize, TZCompressionLevel level = (TZCompressionLevel)(0x2));
extern DELPHI_PACKAGE void __fastcall ZCompress2(const void * inBuffer, int inSize, /* out */ void * &outBuffer, /* out */ int &outSize, TZCompressionLevel level, int windowBits, int memLevel, TZStrategy strategy);
extern DELPHI_PACKAGE void __fastcall ZDecompress(const void * inBuffer, int inSize, /* out */ void * &outBuffer, /* out */ int &outSize, int outEstimate = 0x0);
extern DELPHI_PACKAGE void __fastcall ZDecompress2(const void * inBuffer, int inSize, /* out */ void * &outBuffer, /* out */ int &outSize, int windowBits, int outEstimate = 0x0);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ZCompressStr(const System::UnicodeString s, TZCompressionLevel level = (TZCompressionLevel)(0x2));
extern DELPHI_PACKAGE System::UnicodeString __fastcall ZCompressStrEx(const System::UnicodeString s, TZCompressionLevel level = (TZCompressionLevel)(0x2));
extern DELPHI_PACKAGE System::UnicodeString __fastcall ZCompressStr2(const System::UnicodeString s, TZCompressionLevel level, int windowBits, int memLevel, TZStrategy strategy);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ZCompressStrWeb(const System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ZDecompressStr(const System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ZDecompressStrEx(const System::UnicodeString s);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ZDecompressStr2(const System::UnicodeString s, int windowBits);
extern DELPHI_PACKAGE void __fastcall ZCompressStream(System::Classes::TStream* inStream, System::Classes::TStream* outStream, TZCompressionLevel level = (TZCompressionLevel)(0x2));
extern DELPHI_PACKAGE void __fastcall ZCompressStream2(System::Classes::TStream* inStream, System::Classes::TStream* outStream, TZCompressionLevel level, int windowBits, int memLevel, TZStrategy strategy);
extern DELPHI_PACKAGE void __fastcall ZCompressStreamWeb(System::Classes::TStream* inStream, System::Classes::TStream* outStream);
extern DELPHI_PACKAGE void __fastcall ZDecompressStream(System::Classes::TStream* inStream, System::Classes::TStream* outStream);
extern DELPHI_PACKAGE void __fastcall ZDecompressStream2(System::Classes::TStream* inStream, System::Classes::TStream* outStream, int windowBits);
extern DELPHI_PACKAGE int __fastcall ZAdler32(int adler, const void *buffer, int size);
extern DELPHI_PACKAGE int __fastcall ZCrc32(int crc, const void *buffer, int size);
extern DELPHI_PACKAGE int __fastcall inflateReset(TZStreamRec &strm);
extern DELPHI_PACKAGE int __fastcall inflate(TZStreamRec &strm, int flush);
extern DELPHI_PACKAGE int __fastcall inflateEnd(TZStreamRec &strm);
}	/* namespace Aczlibex */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACZLIBEX)
using namespace Aczlibex;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AczlibexHPP
