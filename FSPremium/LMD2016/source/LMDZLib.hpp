// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDZLib.pas' rev: 34.00 (Windows)

#ifndef LmdzlibHPP
#define LmdzlibHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDRTLConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdzlib
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomZlibStream;
class DELPHICLASS TLMDCompressionStream;
class DELPHICLASS TLMDDecompressionStream;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomZlibStream : public System::Classes::TStream
{
	typedef System::Classes::TStream inherited;
	
private:
	System::Classes::TStream* FStrm;
	int FStrmPos;
	System::Classes::TNotifyEvent FOnProgress;
	void *FZRec;
	System::StaticArray<char, 65536> FBuffer;
	
protected:
	DYNAMIC void __fastcall Progress(System::TObject* Sender);
	__property System::Classes::TNotifyEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	
public:
	__fastcall TLMDCustomZlibStream(System::Classes::TStream* Strm);
	__fastcall virtual ~TLMDCustomZlibStream();
};


enum DECLSPEC_DENUM TLMDCompressionLevel : unsigned char { clNone, clFastest, clDefault, clMax };

class PASCALIMPLEMENTATION TLMDCompressionStream : public TLMDCustomZlibStream
{
	typedef TLMDCustomZlibStream inherited;
	
private:
	float __fastcall GetCompressionRate();
	
public:
	__fastcall TLMDCompressionStream(TLMDCompressionLevel CompressionLevel, System::Classes::TStream* Dest);
	__fastcall virtual ~TLMDCompressionStream();
	virtual int __fastcall Read(void *Buffer, int Count)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count)/* overload */;
	virtual int __fastcall Seek(int Offset, System::Word Origin)/* overload */;
	__property float CompressionRate = {read=GetCompressionRate};
	__property OnProgress;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Read(System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	inline __int64 __fastcall  Seek(const __int64 Offset, System::Classes::TSeekOrigin Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	
};


class PASCALIMPLEMENTATION TLMDDecompressionStream : public TLMDCustomZlibStream
{
	typedef TLMDCustomZlibStream inherited;
	
public:
	__fastcall TLMDDecompressionStream(System::Classes::TStream* Source);
	__fastcall virtual ~TLMDDecompressionStream();
	virtual int __fastcall Read(void *Buffer, int Count)/* overload */;
	virtual int __fastcall Write(const void *Buffer, int Count)/* overload */;
	virtual int __fastcall Seek(int Offset, System::Word Origin)/* overload */;
	__property OnProgress;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Read(System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	inline __int64 __fastcall  Seek(const __int64 Offset, System::Classes::TSeekOrigin Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdzlib */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDZLIB)
using namespace Lmdzlib;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdzlibHPP
