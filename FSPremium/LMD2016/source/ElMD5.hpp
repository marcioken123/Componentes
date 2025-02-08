// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElMD5.pas' rev: 31.00 (Windows)

#ifndef Elmd5HPP
#define Elmd5HPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <ElVCLUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elmd5
{
//-- forward type declarations -----------------------------------------------
struct ULONG32;
struct hashDigest;
class DELPHICLASS TCrMD5;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TSourceType : unsigned char { SourceFile, SourceByteArray, SourceString, SourceAnsiString, SourceWideString };

struct DECLSPEC_DRECORD ULONG32
{
public:
	System::Word LoWord16;
	System::Word HiWord16;
};


typedef ULONG32 *PULONG32;

typedef int *PLong;

struct DECLSPEC_DRECORD hashDigest
{
public:
	unsigned A;
	unsigned B;
	unsigned C;
	unsigned D;
};


typedef hashDigest *PTR_Hash;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TCrMD5 : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TSourceType FType;
	System::UnicodeString FInputFilePath;
	System::Byte *FInputArray;
	hashDigest *FOutputDigest;
	System::UnicodeString FInputString;
	System::AnsiString FInputAnsiString;
	System::WideString FInputWideString;
	int FSourceLength;
	System::StaticArray<unsigned, 16> FActiveBlock;
	unsigned FAA;
	unsigned FBB;
	unsigned FCC;
	unsigned FDD;
	unsigned FA;
	unsigned FB;
	unsigned FC;
	unsigned FD;
	void __fastcall FF(unsigned &a, unsigned &b, unsigned &c, unsigned &d, unsigned &x, System::Byte s, unsigned ac);
	void __fastcall GG(unsigned &a, unsigned &b, unsigned &c, unsigned &d, unsigned &x, System::Byte s, unsigned ac);
	void __fastcall HH(unsigned &a, unsigned &b, unsigned &c, unsigned &d, unsigned &x, System::Byte s, unsigned ac);
	void __fastcall II(unsigned &a, unsigned &b, unsigned &c, unsigned &d, unsigned &x, System::Byte s, unsigned ac);
	
public:
	void __fastcall MD5_Initialize(void);
	void __fastcall MD5_Transform(void);
	void __fastcall MD5_Finish(void);
	void __fastcall MD5_Hash_Bytes(void);
	void __fastcall MD5_Hash_File(void);
	void __fastcall MD5_Hash(void);
	__property System::PByte pInputArray = {read=FInputArray, write=FInputArray};
	__property PTR_Hash pOutputArray = {read=FOutputDigest, write=FOutputDigest};
	__property TSourceType InputType = {read=FType, write=FType, nodefault};
	__property System::UnicodeString InputFilePath = {read=FInputFilePath, write=FInputFilePath};
	__property System::UnicodeString InputString = {read=FInputString, write=FInputString};
	__property System::AnsiString InputAnsiString = {read=FInputAnsiString, write=FInputAnsiString};
	__property System::WideString InputWideString = {read=FInputWideString, write=FInputWideString};
	__property int InputLength = {read=FSourceLength, write=FSourceLength, nodefault};
public:
	/* TObject.Create */ inline __fastcall TCrMD5(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TCrMD5(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 S11 = System::Int8(0x7);
static const System::Int8 S12 = System::Int8(0xc);
static const System::Int8 S13 = System::Int8(0x11);
static const System::Int8 S14 = System::Int8(0x16);
static const System::Int8 S21 = System::Int8(0x5);
static const System::Int8 S22 = System::Int8(0x9);
static const System::Int8 S23 = System::Int8(0xe);
static const System::Int8 S24 = System::Int8(0x14);
static const System::Int8 S31 = System::Int8(0x4);
static const System::Int8 S32 = System::Int8(0xb);
static const System::Int8 S33 = System::Int8(0x10);
static const System::Int8 S34 = System::Int8(0x17);
static const System::Int8 S41 = System::Int8(0x6);
static const System::Int8 S42 = System::Int8(0xa);
static const System::Int8 S43 = System::Int8(0xf);
static const System::Int8 S44 = System::Int8(0x15);
}	/* namespace Elmd5 */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELMD5)
using namespace Elmd5;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Elmd5HPP
