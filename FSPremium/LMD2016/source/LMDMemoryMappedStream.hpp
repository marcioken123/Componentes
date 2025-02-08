// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMemoryMappedStream.pas' rev: 34.00 (Windows)

#ifndef LmdmemorymappedstreamHPP
#define LmdmemorymappedstreamHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <Winapi.Windows.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmemorymappedstream
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMemoryMappedStream;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMemoryMappedStream : public System::Classes::TMemoryStream
{
	typedef System::Classes::TMemoryStream inherited;
	
private:
	void *FMemory;
	int FPosition;
	int FSize;
	NativeUInt FHandle;
	
public:
	__fastcall TLMDMemoryMappedStream(Lmdtypes::TLMDString AName, int ASize);
	__fastcall virtual ~TLMDMemoryMappedStream();
	virtual int __fastcall Write(const void *ABuffer, int ACount)/* overload */;
	virtual int __fastcall Read(void *ABuffer, int ACount)/* overload */;
	virtual __int64 __fastcall Seek(const __int64 AOffset, System::Classes::TSeekOrigin AOrigin)/* overload */;
	__property void * Memory = {read=FMemory, write=FMemory};
	__property int Position = {read=FPosition, write=FPosition, nodefault};
	virtual void __fastcall SetSize(int NewSize)/* overload */;
	/* Hoisted overloads: */
	
public:
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TMemoryStream::Write(Buffer, Offset, Count); }
	inline int __fastcall  Write(const System::DynamicArray<System::Byte> Buffer, int Count){ return System::Classes::TStream::Write(Buffer, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> Buffer, int Offset, int Count){ return System::Classes::TCustomMemoryStream::Read(Buffer, Offset, Count); }
	inline int __fastcall  Read(System::DynamicArray<System::Byte> &Buffer, int Count){ return System::Classes::TStream::Read(Buffer, Count); }
	inline int __fastcall  Seek(int Offset, System::Word Origin){ return System::Classes::TStream::Seek(Offset, Origin); }
	inline void __fastcall  SetSize(const __int64 NewSize){ System::Classes::TMemoryStream::SetSize(NewSize); }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmemorymappedstream */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMEMORYMAPPEDSTREAM)
using namespace Lmdmemorymappedstream;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmemorymappedstreamHPP
