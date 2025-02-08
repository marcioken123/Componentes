// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorCustomCryptor.pas' rev: 31.00 (Windows)

#ifndef LmdstorcustomcryptorHPP
#define LmdstorcustomcryptorHPP

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

namespace Lmdstorcustomcryptor
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStorCustomCustomCryptor;
class DELPHICLASS TLMDStorCustomCryptor;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDStorStreamCryptEvent)(System::TObject* Sender, System::Classes::TMemoryStream* Stream);

class PASCALIMPLEMENTATION TLMDStorCustomCustomCryptor : public Lmdstorbase::TLMDAbstractStorageCryptor
{
	typedef Lmdstorbase::TLMDAbstractStorageCryptor inherited;
	
private:
	Lmdstorbase::TLMDStorIntegerCryptEvent FOnIntegerEncryption;
	Lmdstorbase::TLMDStorStringCryptEvent FOnStringEncryption;
	TLMDStorStreamCryptEvent FOnStreamEncryption;
	Lmdstorbase::TLMDStorIntegerCryptEvent FOnIntegerDecryption;
	Lmdstorbase::TLMDStorStringCryptEvent FOnStringDecryption;
	TLMDStorStreamCryptEvent FOnStreamDecryption;
	
protected:
	void __fastcall DoOnIntegerEncryption(System::TObject* Sender, int &Value);
	void __fastcall DoOnStringEncryption(System::TObject* Sender, System::UnicodeString &Value);
	void __fastcall DoOnStreamEncryption(System::TObject* Sender, System::Classes::TMemoryStream* Value);
	void __fastcall DoOnIntegerDecryption(System::TObject* Sender, int &Value);
	void __fastcall DoOnStringDecryption(System::TObject* Sender, System::UnicodeString &Value);
	void __fastcall DoOnStreamDecryption(System::TObject* Sender, System::Classes::TMemoryStream* Value);
	__property Lmdstorbase::TLMDStorIntegerCryptEvent OnIntegerEncryption = {read=FOnIntegerEncryption, write=FOnIntegerEncryption};
	__property Lmdstorbase::TLMDStorStringCryptEvent OnStringEncryption = {read=FOnStringEncryption, write=FOnStringEncryption};
	__property TLMDStorStreamCryptEvent OnStreamEncryption = {read=FOnStreamEncryption, write=FOnStreamEncryption};
	__property Lmdstorbase::TLMDStorIntegerCryptEvent OnIntegerDecryption = {read=FOnIntegerDecryption, write=FOnIntegerDecryption};
	__property Lmdstorbase::TLMDStorStringCryptEvent OnStringDecryption = {read=FOnStringDecryption, write=FOnStringDecryption};
	__property TLMDStorStreamCryptEvent OnStreamDecryption = {read=FOnStreamDecryption, write=FOnStreamDecryption};
	
public:
	virtual void __fastcall Encrypt(System::Classes::TMemoryStream* Stream);
	virtual void __fastcall Decrypt(System::Classes::TMemoryStream* Stream);
	virtual System::UnicodeString __fastcall EncryptString(System::UnicodeString Value);
	virtual System::UnicodeString __fastcall DecryptString(System::UnicodeString Value);
	virtual int __fastcall EncryptInteger(int Value);
	virtual int __fastcall DecryptInteger(int Value);
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDStorCustomCustomCryptor(System::Classes::TComponent* AOwner) : Lmdstorbase::TLMDAbstractStorageCryptor(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDStorCustomCustomCryptor(void) { }
	
};


class PASCALIMPLEMENTATION TLMDStorCustomCryptor : public TLMDStorCustomCustomCryptor
{
	typedef TLMDStorCustomCustomCryptor inherited;
	
__published:
	__property CryptTypes = {default=0};
	__property OnIntegerEncryption;
	__property OnStringEncryption;
	__property OnStreamEncryption;
	__property OnIntegerDecryption;
	__property OnStringDecryption;
	__property OnStreamDecryption;
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDStorCustomCryptor(System::Classes::TComponent* AOwner) : TLMDStorCustomCustomCryptor(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDStorCustomCryptor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstorcustomcryptor */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORCUSTOMCRYPTOR)
using namespace Lmdstorcustomcryptor;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorcustomcryptorHPP
