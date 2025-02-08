// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorXORCryptor.pas' rev: 31.00 (Windows)

#ifndef LmdstorxorcryptorHPP
#define LmdstorxorcryptorHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDStorBase.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstorxorcryptor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStorCustomXORCryptor;
class DELPHICLASS TLMDStorXORCryptor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStorCustomXORCryptor : public Lmdstorbase::TLMDAbstractStorageCryptor
{
	typedef Lmdstorbase::TLMDAbstractStorageCryptor inherited;
	
private:
	System::Byte FMask;
	void __fastcall SetMask(const System::Byte Value);
	
protected:
	__property System::Byte Mask = {read=FMask, write=SetMask, default=0};
	
public:
	virtual void __fastcall Encrypt(System::Classes::TMemoryStream* Stream);
	virtual void __fastcall Decrypt(System::Classes::TMemoryStream* Stream);
	virtual System::UnicodeString __fastcall EncryptString(System::UnicodeString Value);
	virtual System::UnicodeString __fastcall DecryptString(System::UnicodeString Value);
	virtual int __fastcall EncryptInteger(int Value);
	virtual int __fastcall DecryptInteger(int Value);
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDStorCustomXORCryptor(System::Classes::TComponent* AOwner) : Lmdstorbase::TLMDAbstractStorageCryptor(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDStorCustomXORCryptor(void) { }
	
};


class PASCALIMPLEMENTATION TLMDStorXORCryptor : public TLMDStorCustomXORCryptor
{
	typedef TLMDStorCustomXORCryptor inherited;
	
__published:
	__property Mask = {default=0};
	__property CryptTypes = {default=0};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDStorXORCryptor(System::Classes::TComponent* AOwner) : TLMDStorCustomXORCryptor(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDStorXORCryptor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstorxorcryptor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORXORCRYPTOR)
using namespace Lmdstorxorcryptor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorxorcryptorHPP
