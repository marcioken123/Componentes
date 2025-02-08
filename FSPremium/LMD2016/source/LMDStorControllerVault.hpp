// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorControllerVault.pas' rev: 31.00 (Windows)

#ifndef LmdstorcontrollervaultHPP
#define LmdstorcontrollervaultHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <System.TypInfo.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Windows.hpp>
#include <System.Types.hpp>
#include <LMDStorBase.hpp>
#include <LMDStorPropertiesStorage.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstorcontrollervault
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStorCustomControllerVault;
class DELPHICLASS TLMDStorControllerVault;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStorCustomControllerVault : public Lmdstorbase::TLMDAbstractStorageVault
{
	typedef Lmdstorbase::TLMDAbstractStorageVault inherited;
	
private:
	void __fastcall SetStorageVault(Lmdstorbase::TLMDAbstractStorageVault* const Value);
	
protected:
	Lmdstorbase::TLMDAbstractStorageVault* FStorageVault;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property Lmdstorbase::TLMDAbstractStorageVault* StorageVault = {read=FStorageVault, write=SetStorageVault};
	
public:
	__fastcall virtual TLMDStorCustomControllerVault(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDStorCustomControllerVault(void);
	virtual void __fastcall Save(System::Classes::TMemoryStream* Stream);
	virtual void __fastcall Load(System::Classes::TMemoryStream* Stream);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
	virtual void __fastcall Update(void);
	virtual bool __fastcall KeyExists(const System::UnicodeString Key, System::UnicodeString Section = System::UnicodeString());
	virtual void __fastcall ReadKeys(System::Classes::TStrings* Strings, System::UnicodeString Section = System::UnicodeString());
	virtual int __fastcall KeyCount(System::UnicodeString Section = System::UnicodeString());
	virtual bool __fastcall SectionExists(const System::UnicodeString Section);
	virtual void __fastcall AddSection(const System::UnicodeString Section);
	virtual bool __fastcall RenameSection(const System::UnicodeString OldName, const System::UnicodeString NewName);
	virtual bool __fastcall RemoveSection(const System::UnicodeString Section);
	virtual bool __fastcall DeleteSection(const System::UnicodeString Section);
	virtual bool __fastcall ClearSection(const System::UnicodeString Section);
	virtual void __fastcall DeleteKey(const System::UnicodeString Section, const System::UnicodeString Ident);
	virtual void __fastcall WriteBool(const System::UnicodeString Section, const System::UnicodeString Ident, bool Value);
	virtual bool __fastcall ReadBool(const System::UnicodeString Section, const System::UnicodeString Ident, bool Default);
	virtual void __fastcall WriteColor(const System::UnicodeString Section, const System::UnicodeString Ident, System::Uitypes::TColor Value);
	virtual System::Uitypes::TColor __fastcall ReadColor(const System::UnicodeString Section, const System::UnicodeString Ident, System::Uitypes::TColor Default);
	virtual void __fastcall WriteComponent(System::Classes::TComponent* const Instance, const System::UnicodeString Section = System::UnicodeString());
	virtual System::Classes::TComponent* __fastcall ReadComponent(const System::UnicodeString Section, System::Classes::TComponent* Instance);
	virtual void __fastcall WriteDate(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value);
	virtual System::TDateTime __fastcall ReadDate(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Default);
	virtual void __fastcall WriteDateTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value);
	virtual System::TDateTime __fastcall ReadDateTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Default);
	virtual void __fastcall WriteFloat(const System::UnicodeString Section, const System::UnicodeString Ident, double Value);
	virtual double __fastcall ReadFloat(const System::UnicodeString Section, const System::UnicodeString Ident, double Default);
	virtual void __fastcall WriteObject(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TPersistent* Instance);
	virtual System::Classes::TPersistent* __fastcall ReadObject(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TPersistent* Instance);
	virtual void __fastcall WriteFont(const System::UnicodeString Section, const System::UnicodeString Ident, Vcl::Graphics::TFont* Instance);
	virtual Vcl::Graphics::TFont* __fastcall ReadFont(const System::UnicodeString Section, const System::UnicodeString Ident, Vcl::Graphics::TFont* Instance);
	virtual void __fastcall WriteInteger(const System::UnicodeString Section, const System::UnicodeString Ident, int Value);
	virtual int __fastcall ReadInteger(const System::UnicodeString Section, const System::UnicodeString Ident, int Default);
	virtual void __fastcall WriteInt64(const System::UnicodeString Section, const System::UnicodeString Ident, __int64 Value);
	virtual __int64 __fastcall ReadInt64(const System::UnicodeString Section, const System::UnicodeString Ident, __int64 Default);
	virtual void __fastcall WritePoint(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TPoint &Value);
	virtual System::Types::TPoint __fastcall ReadPoint(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TPoint &Default);
	virtual void __fastcall WriteRect(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TRect &Value);
	virtual System::Types::TRect __fastcall ReadRect(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TRect &Default);
	virtual void __fastcall WriteString(const System::UnicodeString Section, const System::UnicodeString Ident, System::UnicodeString Value);
	virtual System::UnicodeString __fastcall ReadString(const System::UnicodeString Section, const System::UnicodeString Ident, System::UnicodeString Default);
	virtual void __fastcall WriteStrings(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TStrings* Value);
	virtual void __fastcall ReadStrings(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TStrings* Value);
	virtual void __fastcall WriteTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value);
	virtual System::TDateTime __fastcall ReadTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Default);
	virtual void __fastcall ReadSection(const System::UnicodeString Section, System::Classes::TStrings* Strings);
	virtual void __fastcall ReadSections(System::Classes::TStrings* Strings);
};


class PASCALIMPLEMENTATION TLMDStorControllerVault : public TLMDStorCustomControllerVault
{
	typedef TLMDStorCustomControllerVault inherited;
	
__published:
	__property StorageVault;
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
public:
	/* TLMDStorCustomControllerVault.Create */ inline __fastcall virtual TLMDStorControllerVault(System::Classes::TComponent* AOwner) : TLMDStorCustomControllerVault(AOwner) { }
	/* TLMDStorCustomControllerVault.Destroy */ inline __fastcall virtual ~TLMDStorControllerVault(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstorcontrollervault */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORCONTROLLERVAULT)
using namespace Lmdstorcontrollervault;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorcontrollervaultHPP
