// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDClassLib.pas' rev: 31.00 (Windows)

#ifndef LmdclasslibHPP
#define LmdclasslibHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.TypInfo.hpp>
#include <LMDZLib.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdclasslib
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSupportReader;
class DELPHICLASS TLMDSupportWriter;
class DELPHICLASS TLMDSerializable;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDSupportReader : public System::Classes::TReader
{
	typedef System::Classes::TReader inherited;
	
public:
	void __fastcall ReadObject(TLMDSerializable* aObject, bool bBinaryStream = true);
public:
	/* TReader.Destroy */ inline __fastcall virtual ~TLMDSupportReader(void) { }
	
public:
	/* TFiler.Create */ inline __fastcall TLMDSupportReader(System::Classes::TStream* Stream, int BufSize) : System::Classes::TReader(Stream, BufSize) { }
	
};


class PASCALIMPLEMENTATION TLMDSupportWriter : public System::Classes::TWriter
{
	typedef System::Classes::TWriter inherited;
	
protected:
	HIDESBASE void __fastcall WritePrefix(System::Classes::TFilerFlags Flags, int AChildPos);
	
public:
	void __fastcall WriterObject(TLMDSerializable* aObject, bool bBinaryStream = true);
public:
	/* TWriter.Destroy */ inline __fastcall virtual ~TLMDSupportWriter(void) { }
	
public:
	/* TFiler.Create */ inline __fastcall TLMDSupportWriter(System::Classes::TStream* Stream, int BufSize) : System::Classes::TWriter(Stream, BufSize) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSerializable : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	bool FUseZLIB;
	bool FBinaryStream;
	virtual void __fastcall Loading(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall TLMDSerializable(void);
	virtual void __fastcall WriteObject(System::Classes::TStream* Stream);
	virtual void __fastcall ReadObject(System::Classes::TStream* Stream);
	virtual bool __fastcall ReadFromFile(System::UnicodeString szFileName);
	virtual bool __fastcall WriteToFile(System::UnicodeString szFileName);
	__property bool Compressed = {read=FUseZLIB, write=FUseZLIB, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDSerializable(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdclasslib */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCLASSLIB)
using namespace Lmdclasslib;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdclasslibHPP
