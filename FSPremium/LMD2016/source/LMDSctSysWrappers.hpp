// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctSysWrappers.pas' rev: 31.00 (Windows)

#ifndef LmdsctsyswrappersHPP
#define LmdsctsyswrappersHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.Classes.hpp>
#include <LMDSctClass.hpp>
#include <LMDSctWrappers.hpp>
#include <LMDSctScripter.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctsyswrappers
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS Boolean_sw;
class DELPHICLASS ByteBool_sw;
class DELPHICLASS WordBool_sw;
class DELPHICLASS LongBool_sw;
class DELPHICLASS Integer_sw;
class DELPHICLASS Cardinal_sw;
class DELPHICLASS Int64_sw;
class DELPHICLASS UInt64_sw;
class DELPHICLASS NativeInt_sw;
class DELPHICLASS NativeUInt_sw;
class DELPHICLASS FixedInt_sw;
class DELPHICLASS FixedUInt_sw;
class DELPHICLASS Single_sw;
class DELPHICLASS Double_sw;
class DELPHICLASS Extended_sw;
class DELPHICLASS Currency_sw;
class DELPHICLASS Byte_sw;
class DELPHICLASS Smallint_sw;
class DELPHICLASS Shortint_sw;
class DELPHICLASS Word_sw;
class DELPHICLASS Longword_sw;
class DELPHICLASS Longint_sw;
class DELPHICLASS Char_sw;
class DELPHICLASS AnsiChar_sw;
class DELPHICLASS WideChar_sw;
class DELPHICLASS String_sw;
class DELPHICLASS ShortString_sw;
class DELPHICLASS AnsiString_sw;
class DELPHICLASS WideString_sw;
class DELPHICLASS UnicodeString_sw;
class DELPHICLASS RawByteString_sw;
class DELPHICLASS TDateTime_sw;
class DELPHICLASS Variant_sw;
class DELPHICLASS OleVariant_sw;
class DELPHICLASS TVarRecord_sw;
class DELPHICLASS TVarData_sw;
class DELPHICLASS TGUID_sw;
class DELPHICLASS TMethod_sw;
class DELPHICLASS TTextLineBreakStyle_sw;
class DELPHICLASS TObject_sw;
class DELPHICLASS TClass_sw;
class DELPHICLASS TInterfacedObject_sw;
class DELPHICLASS TInterfacedClass_sw;
class DELPHICLASS TAggregatedObject_sw;
class DELPHICLASS TContainedObject_sw;
class DELPHICLASS TCustomAttribute_sw;
class DELPHICLASS TPtrWrapper_sw;
class DELPHICLASS System_sw;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION Boolean_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(bool AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod bool __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Boolean_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Boolean_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ByteBool_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(bool AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod bool __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual ByteBool_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~ByteBool_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION WordBool_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::WordBool AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::WordBool __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual WordBool_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~WordBool_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION LongBool_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::LongBool AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::LongBool __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual LongBool_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~LongBool_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Integer_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(int AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod int __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Integer_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Integer_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Cardinal_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(unsigned AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod unsigned __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Cardinal_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Cardinal_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Int64_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(__int64 AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod __int64 __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Int64_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Int64_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION UInt64_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(unsigned __int64 AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod unsigned __int64 __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual UInt64_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~UInt64_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION NativeInt_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(NativeInt AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod NativeInt __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual NativeInt_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~NativeInt_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION NativeUInt_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(NativeUInt AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod NativeUInt __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual NativeUInt_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~NativeUInt_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION FixedInt_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(int AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod int __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual FixedInt_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~FixedInt_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION FixedUInt_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(unsigned AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod unsigned __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual FixedUInt_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~FixedUInt_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Single_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(float AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod float __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Single_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Single_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Double_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(double AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod double __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Double_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Double_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Extended_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::Extended AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::Extended __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Extended_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Extended_sw(void) { }
	
};

#pragma pack(pop)

typedef Int64_sw Comp_sw;

#pragma pack(push,4)
class PASCALIMPLEMENTATION Currency_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::Currency AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::Currency __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Currency_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Currency_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Byte_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::Byte AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::Byte __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Byte_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Byte_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Smallint_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(short AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod short __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Smallint_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Smallint_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Shortint_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::Int8 AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::Int8 __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Shortint_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Shortint_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Word_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::Word AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::Word __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Word_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Word_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Longword_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(unsigned AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod unsigned __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Longword_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Longword_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Longint_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(int AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod int __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Longint_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Longint_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Char_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::WideChar AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::WideChar __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Char_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Char_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION AnsiChar_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(char AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod char __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual AnsiChar_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~AnsiChar_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION WideChar_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::WideChar AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::WideChar __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual WideChar_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~WideChar_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION String_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(const System::UnicodeString AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::UnicodeString __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual String_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~String_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ShortString_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::ShortString &AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::ShortString __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual ShortString_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~ShortString_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION AnsiString_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::AnsiString AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::AnsiString __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual AnsiString_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~AnsiString_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION WideString_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::WideString AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::WideString __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual WideString_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~WideString_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION UnicodeString_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::WideString AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::WideString __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual UnicodeString_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~UnicodeString_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION RawByteString_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::RawByteString AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::RawByteString __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual RawByteString_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~RawByteString_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TDateTime_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::TDateTime AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::TDateTime __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual TDateTime_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TDateTime_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION Variant_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(const System::Variant &AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::Variant __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual Variant_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~Variant_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION OleVariant_sw : public Lmdsctwrappers::TLMDPredTypeWrapper
{
	typedef Lmdsctwrappers::TLMDPredTypeWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::Word __fastcall GetVarType();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(const System::OleVariant &AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::OleVariant __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual OleVariant_sw(void) : Lmdsctwrappers::TLMDPredTypeWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~OleVariant_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TVarRecord_sw : public Lmdsctwrappers::TLMDRecordWrapper
{
	typedef Lmdsctwrappers::TLMDRecordWrapper inherited;
	
private:
	System::TVarRecord FValue;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	virtual Lmdsctwrappers::TLMDRecordWrapper* __fastcall CloneVal(void);
	__classmethod virtual void __fastcall DoInit(Lmdsctwrappers::TLMDRecordWrapperData* AData);
	
public:
	__classmethod System::OleVariant __fastcall ToVar(const System::TVarRecord &AValue);
	__classmethod System::TVarRecord __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDRecordWrapper.Create */ inline __fastcall virtual TVarRecord_sw(void) : Lmdsctwrappers::TLMDRecordWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TVarRecord_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TVarData_sw : public Lmdsctwrappers::TLMDRecordWrapper
{
	typedef Lmdsctwrappers::TLMDRecordWrapper inherited;
	
private:
	TVarData FValue;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	virtual Lmdsctwrappers::TLMDRecordWrapper* __fastcall CloneVal(void);
	__classmethod virtual void __fastcall DoInit(Lmdsctwrappers::TLMDRecordWrapperData* AData);
	
public:
	__classmethod System::OleVariant __fastcall ToVar(const TVarData &AValue);
	__classmethod TVarData __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDRecordWrapper.Create */ inline __fastcall virtual TVarData_sw(void) : Lmdsctwrappers::TLMDRecordWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TVarData_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TGUID_sw : public Lmdsctwrappers::TLMDRecordWrapper
{
	typedef Lmdsctwrappers::TLMDRecordWrapper inherited;
	
private:
	GUID FValue;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	virtual Lmdsctwrappers::TLMDRecordWrapper* __fastcall CloneVal(void);
	__classmethod virtual void __fastcall DoInit(Lmdsctwrappers::TLMDRecordWrapperData* AData);
	
public:
	__classmethod System::OleVariant __fastcall ToVar(const GUID &AValue);
	__classmethod GUID __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDRecordWrapper.Create */ inline __fastcall virtual TGUID_sw(void) : Lmdsctwrappers::TLMDRecordWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TGUID_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TMethod_sw : public Lmdsctwrappers::TLMDRecordWrapper
{
	typedef Lmdsctwrappers::TLMDRecordWrapper inherited;
	
private:
	System::TMethod FValue;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	virtual Lmdsctwrappers::TLMDRecordWrapper* __fastcall CloneVal(void);
	__classmethod virtual void __fastcall DoInit(Lmdsctwrappers::TLMDRecordWrapperData* AData);
	
public:
	__classmethod System::OleVariant __fastcall ToVar(const System::TMethod &AValue);
	__classmethod System::TMethod __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDRecordWrapper.Create */ inline __fastcall virtual TMethod_sw(void) : Lmdsctwrappers::TLMDRecordWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TMethod_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTextLineBreakStyle_sw : public Lmdsctwrappers::TLMDEnumWrapper
{
	typedef Lmdsctwrappers::TLMDEnumWrapper inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual void __fastcall GetEnumerators(/* out */ Lmdsctwrappers::PLMDEnumerator &AEnums, /* out */ int &ACount);
	
public:
	__classmethod System::OleVariant __fastcall ToVar(const System::TTextLineBreakStyle AValue);
	__classmethod System::TTextLineBreakStyle __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual TTextLineBreakStyle_sw(void) : Lmdsctwrappers::TLMDEnumWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TTextLineBreakStyle_sw(void) { }
	
};

#pragma pack(pop)

typedef Longint_sw HRESULT_sw;

typedef Longword_sw THandle_sw;

typedef Longword_sw HINST_sw;

typedef Longword_sw HMODULE_sw;

typedef Longword_sw HGLOBAL_sw;

typedef Int64_sw TOACurrency_sw;

typedef Shortint_sw Int8_sw;

typedef Smallint_sw Int16_sw;

typedef Integer_sw Int32_sw;

typedef NativeInt_sw IntPtr_sw;

typedef Byte_sw UInt8_sw;

typedef Word_sw UInt16_sw;

typedef Cardinal_sw UInt32_sw;

typedef NativeUInt_sw UIntPtr_sw;

typedef Word_sw TVarType_sw;

typedef TDateTime_sw TDate_sw;

typedef TDateTime_sw TTime_sw;

typedef Integer_sw TVarOp_sw;

typedef Longword_sw TThreadID_sw;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TObject_sw : public Lmdsctwrappers::TLMDClassWrapper
{
	typedef Lmdsctwrappers::TLMDClassWrapper inherited;
	
protected:
	__classmethod virtual System::TClass __fastcall GetWrappedClass();
	__classmethod virtual void __fastcall DoInit(Lmdsctwrappers::TLMDClassWrapperData* AData);
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::TObject* AObject);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::TObject* __fastcall FromVar(const System::OleVariant &AObject);
	__classmethod System::OleVariant __fastcall ClassToVar(System::TClass AClass);
	__classmethod System::TClass __fastcall ClassFromVar(const System::OleVariant &AClass);
public:
	/* TLMDClassWrapper.Create */ inline __fastcall virtual TObject_sw(System::TObject* AValue) : Lmdsctwrappers::TLMDClassWrapper(AValue) { }
	/* TLMDClassWrapper.Destroy */ inline __fastcall virtual ~TObject_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TClass_sw : public Lmdsctwrappers::TLMDMetaclassWrapper
{
	typedef Lmdsctwrappers::TLMDMetaclassWrapper inherited;
	
protected:
	__classmethod virtual System::TClass __fastcall GetWrappedBaseClass();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::TClass AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::TClass __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual TClass_sw(void) : Lmdsctwrappers::TLMDMetaclassWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TClass_sw(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TInterfacedObject_sc;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TInterfacedObject_sw : public TObject_sw
{
	typedef TObject_sw inherited;
	
protected:
	__classmethod virtual System::TClass __fastcall GetWrappedClass();
	__classmethod virtual void __fastcall DoInit(Lmdsctwrappers::TLMDClassWrapperData* AData);
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::TInterfacedObject* AObject);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::TInterfacedObject* __fastcall FromVar(const System::OleVariant &AObject);
	__classmethod System::OleVariant __fastcall ClassToVar(TInterfacedObject_sc AClass);
	__classmethod TInterfacedObject_sc __fastcall ClassFromVar(const System::OleVariant &AClass);
public:
	/* TLMDClassWrapper.Create */ inline __fastcall virtual TInterfacedObject_sw(System::TObject* AValue) : TObject_sw(AValue) { }
	/* TLMDClassWrapper.Destroy */ inline __fastcall virtual ~TInterfacedObject_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TInterfacedClass_sw : public Lmdsctwrappers::TLMDMetaclassWrapper
{
	typedef Lmdsctwrappers::TLMDMetaclassWrapper inherited;
	
protected:
	__classmethod virtual System::TClass __fastcall GetWrappedBaseClass();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::TInterfacedClass AValue);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::TInterfacedClass __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDTypeWrapper.Create */ inline __fastcall virtual TInterfacedClass_sw(void) : Lmdsctwrappers::TLMDMetaclassWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TInterfacedClass_sw(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TAggregatedObject_sc;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TAggregatedObject_sw : public TObject_sw
{
	typedef TObject_sw inherited;
	
protected:
	__classmethod virtual System::TClass __fastcall GetWrappedClass();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::TAggregatedObject* AObject);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::TAggregatedObject* __fastcall FromVar(const System::OleVariant &AObject);
	__classmethod System::OleVariant __fastcall ClassToVar(TAggregatedObject_sc AClass);
	__classmethod TAggregatedObject_sc __fastcall ClassFromVar(const System::OleVariant &AClass);
public:
	/* TLMDClassWrapper.Create */ inline __fastcall virtual TAggregatedObject_sw(System::TObject* AValue) : TObject_sw(AValue) { }
	/* TLMDClassWrapper.Destroy */ inline __fastcall virtual ~TAggregatedObject_sw(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TContainedObject_sc;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TContainedObject_sw : public TAggregatedObject_sw
{
	typedef TAggregatedObject_sw inherited;
	
protected:
	__classmethod virtual System::TClass __fastcall GetWrappedClass();
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::TContainedObject* AObject);
	__classmethod System::OleVariant __fastcall UntypedToVar(const void *AValue);
	__classmethod System::TContainedObject* __fastcall FromVar(const System::OleVariant &AObject);
	__classmethod System::OleVariant __fastcall ClassToVar(TContainedObject_sc AClass);
	__classmethod TContainedObject_sc __fastcall ClassFromVar(const System::OleVariant &AClass);
public:
	/* TLMDClassWrapper.Create */ inline __fastcall virtual TContainedObject_sw(System::TObject* AValue) : TAggregatedObject_sw(AValue) { }
	/* TLMDClassWrapper.Destroy */ inline __fastcall virtual ~TContainedObject_sw(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TCustomAttribute_sc;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TCustomAttribute_sw : public TObject_sw
{
	typedef TObject_sw inherited;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	__classmethod virtual System::TClass __fastcall GetWrappedClass();
	__classmethod virtual void __fastcall DoInit(Lmdsctwrappers::TLMDClassWrapperData* AData);
	
public:
	__classmethod System::OleVariant __fastcall ToVar(System::TCustomAttribute* const AValue);
	__classmethod System::TCustomAttribute* __fastcall FromVar(const System::OleVariant &AValue);
	__classmethod System::OleVariant __fastcall ClassToVar(TCustomAttribute_sc AClass);
	__classmethod TCustomAttribute_sc __fastcall ClassFromVar(const System::OleVariant &AClass);
public:
	/* TLMDClassWrapper.Create */ inline __fastcall virtual TCustomAttribute_sw(System::TObject* AValue) : TObject_sw(AValue) { }
	/* TLMDClassWrapper.Destroy */ inline __fastcall virtual ~TCustomAttribute_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TPtrWrapper_sw : public Lmdsctwrappers::TLMDRecordWrapper
{
	typedef Lmdsctwrappers::TLMDRecordWrapper inherited;
	
private:
	System::TPtrWrapper FValue;
	
protected:
	__classmethod virtual System::WideString __fastcall GetTypeName();
	virtual Lmdsctwrappers::TLMDRecordWrapper* __fastcall CloneVal(void);
	__classmethod virtual void __fastcall DoInit(Lmdsctwrappers::TLMDRecordWrapperData* AData);
	
public:
	__classmethod System::OleVariant __fastcall ToVar(const System::TPtrWrapper AValue);
	__classmethod System::TPtrWrapper __fastcall FromVar(const System::OleVariant &AValue);
public:
	/* TLMDRecordWrapper.Create */ inline __fastcall virtual TPtrWrapper_sw(void) : Lmdsctwrappers::TLMDRecordWrapper() { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TPtrWrapper_sw(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION System_sw : public Lmdsctwrappers::TLMDUnitWrapper
{
	typedef Lmdsctwrappers::TLMDUnitWrapper inherited;
	
protected:
	__classmethod virtual void __fastcall DoInit(Lmdsctwrappers::TLMDUnitWrapperData* AData);
	
public:
	__classmethod virtual System::WideString __fastcall GetUnitName();
	__classmethod System::OleVariant __fastcall ToVar(Lmdsctscripter::TLMDScriptControl* AScriptControl);
public:
	/* TLMDUnitWrapper.Create */ inline __fastcall virtual System_sw(System::TObject* AScriptControl) : Lmdsctwrappers::TLMDUnitWrapper(AScriptControl) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~System_sw(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall _RegisterSysWrappers(void);
}	/* namespace Lmdsctsyswrappers */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTSYSWRAPPERS)
using namespace Lmdsctsyswrappers;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctsyswrappersHPP
