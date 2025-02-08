// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorRegistryVault.pas' rev: 31.00 (Windows)

#ifndef LmdstorregistryvaultHPP
#define LmdstorregistryvaultHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Win.Registry.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.TypInfo.hpp>
#include <LMDUnicode.hpp>
#include <LMDStorBase.hpp>
#include <LMDStorCommon.hpp>
#include <LMDStorPropertiesStorage.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstorregistryvault
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCrackWriter;
class DELPHICLASS TLMDStorCustomRegistryVault;
class DELPHICLASS TLMDStorRegistryVault;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDStorRegRoot : unsigned char { rrCurrentUser, rrLocalMachine };

class PASCALIMPLEMENTATION TCrackWriter : public System::Classes::TWriter
{
	typedef System::Classes::TWriter inherited;
	
public:
	/* TWriter.Destroy */ inline __fastcall virtual ~TCrackWriter(void) { }
	
public:
	/* TFiler.Create */ inline __fastcall TCrackWriter(System::Classes::TStream* Stream, int BufSize) : System::Classes::TWriter(Stream, BufSize) { }
	
};


class PASCALIMPLEMENTATION TLMDStorCustomRegistryVault : public Lmdstorbase::TLMDAbstractStorageVault
{
	typedef Lmdstorbase::TLMDAbstractStorageVault inherited;
	
private:
	TLMDStorRegRoot FRegistryRoot;
	System::UnicodeString FRegistryKey;
	System::Win::Registry::TRegistry* Reg;
	void __fastcall SetRegistryRoot(const TLMDStorRegRoot Value);
	void __fastcall SetRegistryKey(const System::UnicodeString Value);
	System::UnicodeString __fastcall CurrentActiveSection(void);
	System::UnicodeString __fastcall GetType(System::UnicodeString Value);
	void __fastcall WriteSimpleProperty(const System::UnicodeString Section, const System::UnicodeString Ident, const System::UnicodeString PropType, const System::UnicodeString PropValue);
	void __fastcall ReadSimpleProperty(const System::UnicodeString Section, const System::UnicodeString Ident, System::UnicodeString &PropType, System::UnicodeString &PropValue);
	void __fastcall LoadComponent(System::UnicodeString CompName, TCrackWriter* Writer);
	void __fastcall SaveObject(System::Classes::TStream* Stream, System::UnicodeString szType);
	void __fastcall WriteEssence(const System::UnicodeString Section, const System::UnicodeString Ident, const System::UnicodeString szType, System::Classes::TPersistent* Instance);
	System::Classes::TPersistent* __fastcall ReadEssence(const System::UnicodeString Section, const System::UnicodeString Ident, const System::UnicodeString szType, System::Classes::TPersistent* Instance);
	
protected:
	DYNAMIC System::UnicodeString __fastcall Extension(void);
	__property TLMDStorRegRoot RegistryRoot = {read=FRegistryRoot, write=SetRegistryRoot, default=0};
	__property System::UnicodeString RegistryKey = {read=FRegistryKey, write=SetRegistryKey};
	
public:
	__fastcall virtual TLMDStorCustomRegistryVault(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDStorCustomRegistryVault(void);
	virtual void __fastcall Save(System::Classes::TMemoryStream* Stream);
	virtual void __fastcall Load(System::Classes::TMemoryStream* Stream);
	virtual void __fastcall Open(void);
	void __fastcall Delete(void);
	virtual void __fastcall DeleteKey(const System::UnicodeString Section, const System::UnicodeString Ident);
	void __fastcall DeleteKeyEx(const System::UnicodeString Section, const System::UnicodeString Ident, const System::UnicodeString szType);
	virtual bool __fastcall KeyExists(const System::UnicodeString Key, System::UnicodeString Section = System::UnicodeString());
	virtual bool __fastcall SectionExists(const System::UnicodeString Section);
	virtual void __fastcall Close(void);
	virtual void __fastcall Update(void);
	virtual void __fastcall AddSection(const System::UnicodeString Section);
	virtual bool __fastcall RenameSection(const System::UnicodeString OldName, const System::UnicodeString NewName);
	virtual bool __fastcall RemoveSection(const System::UnicodeString Section);
	virtual bool __fastcall DeleteSection(const System::UnicodeString Section);
	virtual bool __fastcall ClearSection(const System::UnicodeString Section);
	virtual void __fastcall ReadKeys(System::Classes::TStrings* Strings, System::UnicodeString Section = System::UnicodeString());
	virtual int __fastcall KeyCount(System::UnicodeString Section = System::UnicodeString());
	virtual void __fastcall WriteBool(const System::UnicodeString Section, const System::UnicodeString Ident, bool Value);
	virtual bool __fastcall ReadBool(const System::UnicodeString Section, const System::UnicodeString Ident, bool Default);
	virtual void __fastcall WriteColor(const System::UnicodeString Section, const System::UnicodeString Ident, System::Uitypes::TColor Value);
	virtual System::Uitypes::TColor __fastcall ReadColor(const System::UnicodeString Section, const System::UnicodeString Ident, System::Uitypes::TColor Default);
	virtual void __fastcall WriteObject(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TPersistent* Instance);
	virtual System::Classes::TPersistent* __fastcall ReadObject(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TPersistent* Instance);
	virtual void __fastcall WriteComponent(System::Classes::TComponent* const Instance, const System::UnicodeString Section = System::UnicodeString());
	virtual System::Classes::TComponent* __fastcall ReadComponent(const System::UnicodeString Section, System::Classes::TComponent* Instance);
	virtual void __fastcall WriteDate(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value);
	virtual System::TDateTime __fastcall ReadDate(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Default);
	virtual void __fastcall WriteDateTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value);
	virtual System::TDateTime __fastcall ReadDateTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Default);
	virtual void __fastcall WriteFloat(const System::UnicodeString Section, const System::UnicodeString Ident, double Value);
	virtual double __fastcall ReadFloat(const System::UnicodeString Section, const System::UnicodeString Ident, double Default);
	virtual void __fastcall WriteFont(const System::UnicodeString Section, const System::UnicodeString Ident, Vcl::Graphics::TFont* Instance);
	virtual Vcl::Graphics::TFont* __fastcall ReadFont(const System::UnicodeString Section, const System::UnicodeString Ident, Vcl::Graphics::TFont* Instance);
	virtual void __fastcall WriteInteger(const System::UnicodeString Section, const System::UnicodeString Ident, int Value);
	virtual int __fastcall ReadInteger(const System::UnicodeString Section, const System::UnicodeString Ident, int Default);
	virtual void __fastcall WriteInt64(const System::UnicodeString Section, const System::UnicodeString Ident, __int64 Value);
	virtual __int64 __fastcall ReadInt64(const System::UnicodeString Section, const System::UnicodeString Ident, __int64 Default);
	virtual void __fastcall WriteStrings(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TStrings* Value);
	virtual void __fastcall ReadStrings(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TStrings* Value);
	virtual void __fastcall WritePoint(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TPoint &Value);
	virtual System::Types::TPoint __fastcall ReadPoint(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TPoint &Default);
	virtual void __fastcall WriteRect(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TRect &Value);
	virtual System::Types::TRect __fastcall ReadRect(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TRect &Default);
	virtual void __fastcall WriteString(const System::UnicodeString Section, const System::UnicodeString Ident, System::UnicodeString Value);
	virtual System::UnicodeString __fastcall ReadString(const System::UnicodeString Section, const System::UnicodeString Ident, System::UnicodeString Default);
	virtual void __fastcall WriteTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value);
	virtual System::TDateTime __fastcall ReadTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Default);
	virtual void __fastcall ReadSection(const System::UnicodeString Section, System::Classes::TStrings* Strings);
	virtual void __fastcall ReadSections(System::Classes::TStrings* Strings);
};


class PASCALIMPLEMENTATION TLMDStorRegistryVault : public TLMDStorCustomRegistryVault
{
	typedef TLMDStorCustomRegistryVault inherited;
	
__published:
	__property Encrypted = {default=0};
	__property BinaryStream = {default=0};
	__property RegistryRoot = {default=0};
	__property RegistryKey = {default=0};
	__property OnBeforeOpen;
	__property OnAfterOpen;
	__property OnBeforeClose;
	__property OnAfterClose;
	__property OnSectionAdd;
	__property OnSectionDelete;
	__property OnLoadStream;
	__property OnSaveStream;
	__property OnBeforeEncryption;
	__property OnAfterEncryption;
	__property OnBeforeDecryption;
	__property OnAfterDecryption;
	__property OnBeforeStringEncryption;
	__property OnAfterStringEncryption;
	__property OnBeforeStringDecryption;
	__property OnAfterStringDecryption;
	__property OnBeforeIntegerEncryption;
	__property OnAfterIntegerEncryption;
	__property OnBeforeIntegerDecryption;
	__property OnAfterIntegerDecryption;
	__property OnCustomRootRead;
	__property OnCustomRootWrite;
	__property StorageCryptor;
	__property Sections;
	__property ActiveSection = {default=0};
	__property ActiveSectionIndex = {default=-1};
public:
	/* TLMDStorCustomRegistryVault.Create */ inline __fastcall virtual TLMDStorRegistryVault(System::Classes::TComponent* AOwner) : TLMDStorCustomRegistryVault(AOwner) { }
	/* TLMDStorCustomRegistryVault.Destroy */ inline __fastcall virtual ~TLMDStorRegistryVault(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstorregistryvault */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORREGISTRYVAULT)
using namespace Lmdstorregistryvault;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorregistryvaultHPP
