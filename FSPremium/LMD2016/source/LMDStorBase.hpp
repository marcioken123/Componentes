// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorBase.pas' rev: 31.00 (Windows)

#ifndef LmdstorbaseHPP
#define LmdstorbaseHPP

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
#include <Vcl.Controls.hpp>
#include <System.Win.Registry.hpp>
#include <Winapi.ShlObj.hpp>
#include <Winapi.ActiveX.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <System.Types.hpp>
#include <Vcl.FileCtrl.hpp>
#include <LMDStorCommon.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstorbase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStorComponent;
class DELPHICLASS TLMDAbstractStorageVault;
class DELPHICLASS TLMDAbstractStorageCryptor;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDStorSectionAddEvent)(System::TObject* Sender, const System::UnicodeString Section);

typedef void __fastcall (__closure *TLMDStorSectionDeleteEvent)(System::TObject* Sender, const System::UnicodeString Section);

typedef void __fastcall (__closure *TLMDStorLoadStreamEvent)(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);

typedef void __fastcall (__closure *TLMDStorSaveStreamEvent)(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);

class PASCALIMPLEMENTATION TLMDStorComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDStorComponent(System::Classes::TComponent* AOwner) : Lmdcustomcomponent::TLMDCustomComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDStorComponent(void) { }
	
};


typedef void __fastcall (__closure *TLMDStorStreamEvent)(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);

typedef void __fastcall (__closure *TLMDStorStringCryptEvent)(System::TObject* Sender, System::UnicodeString &Value);

typedef void __fastcall (__closure *TLMDStorStringCryptProcessEvent)(System::TObject* Sender, System::UnicodeString &Value, bool &CanProcess);

typedef void __fastcall (__closure *TLMDStorIntegerCryptEvent)(System::TObject* Sender, int &Value);

typedef void __fastcall (__closure *TLMDStorIntegerCryptProcessEvent)(System::TObject* Sender, int &Value, bool &CanProcess);

typedef void __fastcall (__closure *TLMDStorCustomRootEvent)(System::TObject* Sender, System::Classes::TComponent* Instance, System::Classes::TComponent* &Root);

typedef void __fastcall (__closure *TLMDStorUpdateBeforeCloseEvent)(System::TObject* Sender, bool &ACanUpdate);

enum DECLSPEC_DENUM TLMDStorPathPrefix : unsigned char { ppDefault, ppSystem, ppProgram, ppWindows, ppCustom };

class PASCALIMPLEMENTATION TLMDAbstractStorageVault : public TLMDStorComponent
{
	typedef TLMDStorComponent inherited;
	
private:
	TLMDStorStreamEvent FOnBeforeEncryption;
	TLMDStorStreamEvent FOnAfterEncryption;
	TLMDStorStreamEvent FOnBeforeDecryption;
	TLMDStorStreamEvent FOnAfterDecryption;
	TLMDStorStringCryptProcessEvent FOnBeforeStringEncryption;
	TLMDStorStringCryptEvent FOnAfterStringEncryption;
	TLMDStorStringCryptProcessEvent FOnBeforeStringDecryption;
	TLMDStorStringCryptEvent FOnAfterStringDecryption;
	TLMDStorIntegerCryptProcessEvent FOnBeforeIntegerEncryption;
	TLMDStorIntegerCryptEvent FOnAfterIntegerEncryption;
	TLMDStorIntegerCryptProcessEvent FOnBeforeIntegerDecryption;
	TLMDStorIntegerCryptEvent FOnAfterIntegerDecryption;
	TLMDStorUpdateBeforeCloseEvent FOnUpdateBeforeClose;
	bool FBinaryStream;
	bool FCompressedStream;
	System::Classes::TStrings* FSections;
	System::UnicodeString FActiveSection;
	int FActiveSectionIndex;
	System::Classes::TNotifyEvent FOnBeforeOpen;
	System::Classes::TNotifyEvent FOnAfterOpen;
	System::Classes::TNotifyEvent FOnBeforeClose;
	System::Classes::TNotifyEvent FOnAfterClose;
	TLMDStorSectionAddEvent FOnSectionAdd;
	TLMDStorSectionDeleteEvent FOnSectionDelete;
	TLMDStorLoadStreamEvent FOnLoadStream;
	TLMDStorSaveStreamEvent FOnSaveStream;
	System::Sysutils::TFileName FFileName;
	TLMDStorPathPrefix FFilePrefix;
	System::UnicodeString FAppDataPath;
	bool FAppDataCommon;
	bool FEncrypted;
	bool FAutoUpdate;
	TLMDStorCustomRootEvent FOnCustomRootRead;
	TLMDStorCustomRootEvent FOnCustomRootWrite;
	void __fastcall SetBinaryStream(const bool Value);
	void __fastcall SetCompressedStream(const bool Value);
	virtual void __fastcall SetSections(System::Classes::TStrings* const Value);
	virtual void __fastcall SetActiveSection(const System::UnicodeString Value);
	virtual void __fastcall SetActiveSectionIndex(const int Value);
	void __fastcall SetStorageCryptor(TLMDAbstractStorageCryptor* const Value);
	void __fastcall SetFileName(const System::Sysutils::TFileName Value);
	void __fastcall SetFilePrefix(const TLMDStorPathPrefix Value);
	void __fastcall SetEncrypted(const bool Value);
	System::UnicodeString __fastcall GetDataFile(void);
	bool __fastcall IsCustomDataPath(void);
	System::UnicodeString __fastcall LMDAppData(void);
	System::UnicodeString __fastcall LMDCreatePathPrefix(TLMDStorPathPrefix aValue, bool Slash);
	
protected:
	bool FIsLoading;
	TLMDAbstractStorageCryptor* FStorageCryptor;
	DYNAMIC System::UnicodeString __fastcall Extension(void) = 0 ;
	__property System::Sysutils::TFileName FileName = {read=FFileName, write=SetFileName};
	__property TLMDStorPathPrefix FilePrefix = {read=FFilePrefix, write=SetFilePrefix, default=2};
	__property bool Encrypted = {read=FEncrypted, write=SetEncrypted, default=0};
	__property System::UnicodeString AppDataPath = {read=FAppDataPath, write=FAppDataPath, stored=IsCustomDataPath};
	__property bool AppDataCommon = {read=FAppDataCommon, write=FAppDataCommon, default=0};
	DYNAMIC void __fastcall DoOnBeforeEncryption(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);
	DYNAMIC void __fastcall DoOnAfterEncryption(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);
	DYNAMIC void __fastcall DoOnBeforeDecryption(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);
	DYNAMIC void __fastcall DoOnAfterDecryption(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);
	DYNAMIC void __fastcall DoOnBeforeStringEncryption(System::TObject* Sender, System::UnicodeString &Value, bool &CanProcess);
	DYNAMIC void __fastcall DoOnAfterStringEncryption(System::TObject* Sender, System::UnicodeString &Value);
	DYNAMIC void __fastcall DoOnBeforeStringDecryption(System::TObject* Sender, System::UnicodeString &Value, bool &CanProcess);
	DYNAMIC void __fastcall DoOnAfterStringDecryption(System::TObject* Sender, System::UnicodeString &Value);
	DYNAMIC void __fastcall DoOnBeforeIntegerEncryption(System::TObject* Sender, int &Value, bool &CanProcess);
	DYNAMIC void __fastcall DoOnAfterIntegerEncryption(System::TObject* Sender, int &Value);
	DYNAMIC void __fastcall DoOnBeforeIntegerDecryption(System::TObject* Sender, int &Value, bool &CanProcess);
	DYNAMIC void __fastcall DoOnAfterIntegerDecryption(System::TObject* Sender, int &Value);
	DYNAMIC void __fastcall DoOnBeforeOpen(System::TObject* Sender);
	DYNAMIC void __fastcall DoOnAfterOpen(System::TObject* Sender);
	DYNAMIC void __fastcall DoOnBeforeClose(System::TObject* Sender);
	DYNAMIC void __fastcall DoOnAfterClose(System::TObject* Sender);
	DYNAMIC void __fastcall DoOnSectionAdd(System::TObject* Sender, const System::UnicodeString Section);
	DYNAMIC void __fastcall DoOnSectionDelete(System::TObject* Sender, const System::UnicodeString Section);
	DYNAMIC void __fastcall DoOnLoadStream(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);
	DYNAMIC void __fastcall DoOnSaveStream(System::TObject* Sender, System::Classes::TMemoryStream* &Stream);
	DYNAMIC void __fastcall DoOnUpdateBeforeCloseEvent(System::TObject* Sender, bool &ACanUpdate);
	virtual void __fastcall DoCustomRootRead(System::Classes::TComponent* Instance, System::Classes::TComponent* &Root);
	virtual void __fastcall DoCustomRootWrite(System::Classes::TComponent* Instance, System::Classes::TComponent* &Root);
	virtual void __fastcall FileChanged(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property System::Classes::TNotifyEvent OnBeforeOpen = {read=FOnBeforeOpen, write=FOnBeforeOpen};
	__property System::Classes::TNotifyEvent OnAfterOpen = {read=FOnAfterOpen, write=FOnAfterOpen};
	__property System::Classes::TNotifyEvent OnBeforeClose = {read=FOnBeforeClose, write=FOnBeforeClose};
	__property System::Classes::TNotifyEvent OnAfterClose = {read=FOnAfterClose, write=FOnAfterClose};
	__property TLMDStorSectionAddEvent OnSectionAdd = {read=FOnSectionAdd, write=FOnSectionAdd};
	__property TLMDStorSectionDeleteEvent OnSectionDelete = {read=FOnSectionDelete, write=FOnSectionDelete};
	__property TLMDStorLoadStreamEvent OnLoadStream = {read=FOnLoadStream, write=FOnLoadStream};
	__property TLMDStorSaveStreamEvent OnSaveStream = {read=FOnSaveStream, write=FOnSaveStream};
	__property TLMDStorStreamEvent OnBeforeEncryption = {read=FOnBeforeEncryption, write=FOnBeforeEncryption};
	__property TLMDStorStreamEvent OnAfterEncryption = {read=FOnAfterEncryption, write=FOnAfterEncryption};
	__property TLMDStorStreamEvent OnBeforeDecryption = {read=FOnBeforeDecryption, write=FOnBeforeDecryption};
	__property TLMDStorStreamEvent OnAfterDecryption = {read=FOnAfterDecryption, write=FOnAfterDecryption};
	__property TLMDStorStringCryptProcessEvent OnBeforeStringEncryption = {read=FOnBeforeStringEncryption, write=FOnBeforeStringEncryption};
	__property TLMDStorStringCryptEvent OnAfterStringEncryption = {read=FOnAfterStringEncryption, write=FOnAfterStringEncryption};
	__property TLMDStorStringCryptProcessEvent OnBeforeStringDecryption = {read=FOnBeforeStringDecryption, write=FOnBeforeStringDecryption};
	__property TLMDStorStringCryptEvent OnAfterStringDecryption = {read=FOnAfterStringDecryption, write=FOnAfterStringDecryption};
	__property TLMDStorIntegerCryptProcessEvent OnBeforeIntegerEncryption = {read=FOnBeforeIntegerEncryption, write=FOnBeforeIntegerEncryption};
	__property TLMDStorIntegerCryptEvent OnAfterIntegerEncryption = {read=FOnAfterIntegerEncryption, write=FOnAfterIntegerEncryption};
	__property TLMDStorIntegerCryptProcessEvent OnBeforeIntegerDecryption = {read=FOnBeforeIntegerDecryption, write=FOnBeforeIntegerDecryption};
	__property TLMDStorIntegerCryptEvent OnAfterIntegerDecryption = {read=FOnAfterIntegerDecryption, write=FOnAfterIntegerDecryption};
	__property TLMDStorCustomRootEvent OnCustomRootRead = {read=FOnCustomRootRead, write=FOnCustomRootRead};
	__property TLMDStorCustomRootEvent OnCustomRootWrite = {read=FOnCustomRootWrite, write=FOnCustomRootWrite};
	__property TLMDStorUpdateBeforeCloseEvent OnUpdateBeforeClose = {read=FOnUpdateBeforeClose, write=FOnUpdateBeforeClose};
	__property bool BinaryStream = {read=FBinaryStream, write=SetBinaryStream, default=0};
	__property System::Classes::TStrings* Sections = {read=FSections, write=SetSections};
	__property int ActiveSectionIndex = {read=FActiveSectionIndex, write=SetActiveSectionIndex, default=-1};
	__property TLMDAbstractStorageCryptor* StorageCryptor = {read=FStorageCryptor, write=SetStorageCryptor};
	
public:
	__fastcall virtual TLMDAbstractStorageVault(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDAbstractStorageVault(void);
	virtual void __fastcall Save(System::Classes::TMemoryStream* Stream);
	virtual void __fastcall Load(System::Classes::TMemoryStream* Stream);
	virtual void __fastcall Open(void) = 0 ;
	virtual void __fastcall Close(void) = 0 ;
	virtual void __fastcall Update(void) = 0 ;
	virtual bool __fastcall KeyExists(const System::UnicodeString Key, System::UnicodeString Section = System::UnicodeString()) = 0 ;
	virtual void __fastcall ReadKeys(System::Classes::TStrings* Strings, System::UnicodeString Section = System::UnicodeString()) = 0 ;
	virtual int __fastcall KeyCount(System::UnicodeString Section = System::UnicodeString()) = 0 ;
	virtual bool __fastcall SectionExists(const System::UnicodeString Section) = 0 ;
	virtual void __fastcall AddSection(const System::UnicodeString Section) = 0 ;
	virtual bool __fastcall RenameSection(const System::UnicodeString OldName, const System::UnicodeString NewName) = 0 ;
	virtual bool __fastcall RemoveSection(const System::UnicodeString Section) = 0 ;
	virtual bool __fastcall DeleteSection(const System::UnicodeString Section) = 0 ;
	virtual bool __fastcall ClearSection(const System::UnicodeString Section) = 0 ;
	virtual void __fastcall DeleteKey(const System::UnicodeString Section, const System::UnicodeString Ident) = 0 ;
	virtual void __fastcall WriteBool(const System::UnicodeString Section, const System::UnicodeString Ident, bool Value) = 0 ;
	virtual bool __fastcall ReadBool(const System::UnicodeString Section, const System::UnicodeString Ident, bool ADefault) = 0 ;
	virtual void __fastcall WriteColor(const System::UnicodeString Section, const System::UnicodeString Ident, System::Uitypes::TColor Value) = 0 ;
	virtual System::Uitypes::TColor __fastcall ReadColor(const System::UnicodeString Section, const System::UnicodeString Ident, System::Uitypes::TColor ADefault) = 0 ;
	virtual void __fastcall WriteComponent(System::Classes::TComponent* const Instance, const System::UnicodeString Section = System::UnicodeString()) = 0 ;
	virtual System::Classes::TComponent* __fastcall ReadComponent(const System::UnicodeString Section, System::Classes::TComponent* Instance) = 0 ;
	virtual void __fastcall WriteDate(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value) = 0 ;
	virtual System::TDateTime __fastcall ReadDate(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime ADefault) = 0 ;
	virtual void __fastcall WriteDateTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value) = 0 ;
	virtual System::TDateTime __fastcall ReadDateTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime ADefault) = 0 ;
	virtual void __fastcall WriteFloat(const System::UnicodeString Section, const System::UnicodeString Ident, double Value) = 0 ;
	virtual double __fastcall ReadFloat(const System::UnicodeString Section, const System::UnicodeString Ident, double ADefault) = 0 ;
	virtual void __fastcall WriteObject(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TPersistent* Instance) = 0 ;
	virtual System::Classes::TPersistent* __fastcall ReadObject(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TPersistent* Instance) = 0 ;
	virtual void __fastcall WriteFont(const System::UnicodeString Section, const System::UnicodeString Ident, Vcl::Graphics::TFont* Instance) = 0 ;
	virtual Vcl::Graphics::TFont* __fastcall ReadFont(const System::UnicodeString Section, const System::UnicodeString Ident, Vcl::Graphics::TFont* Instance) = 0 ;
	virtual void __fastcall WriteInteger(const System::UnicodeString Section, const System::UnicodeString Ident, int Value) = 0 ;
	virtual int __fastcall ReadInteger(const System::UnicodeString Section, const System::UnicodeString Ident, int ADefault) = 0 ;
	virtual void __fastcall WriteInt64(const System::UnicodeString Section, const System::UnicodeString Ident, __int64 Value) = 0 ;
	virtual __int64 __fastcall ReadInt64(const System::UnicodeString Section, const System::UnicodeString Ident, __int64 ADefault) = 0 ;
	virtual void __fastcall WritePoint(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TPoint &Value) = 0 ;
	virtual System::Types::TPoint __fastcall ReadPoint(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TPoint &ADefault) = 0 ;
	virtual void __fastcall WriteRect(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TRect &Value) = 0 ;
	virtual System::Types::TRect __fastcall ReadRect(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TRect &ADefault) = 0 ;
	virtual void __fastcall WriteString(const System::UnicodeString Section, const System::UnicodeString Ident, System::UnicodeString Value) = 0 ;
	virtual System::UnicodeString __fastcall ReadString(const System::UnicodeString Section, const System::UnicodeString Ident, System::UnicodeString ADefault) = 0 ;
	virtual void __fastcall WriteStrings(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TStrings* Value) = 0 ;
	virtual void __fastcall ReadStrings(const System::UnicodeString Section, const System::UnicodeString Ident, System::Classes::TStrings* Value) = 0 ;
	virtual void __fastcall WriteTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value) = 0 ;
	virtual System::TDateTime __fastcall ReadTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime ADefault) = 0 ;
	virtual void __fastcall ReadSection(const System::UnicodeString Section, System::Classes::TStrings* Strings) = 0 ;
	virtual void __fastcall ReadSections(System::Classes::TStrings* Strings) = 0 ;
	System::UnicodeString __fastcall EncryptString(System::UnicodeString Value);
	System::UnicodeString __fastcall DecryptString(System::UnicodeString Value);
	int __fastcall EncryptInteger(int Value);
	int __fastcall DecryptInteger(int Value);
	__property System::UnicodeString DataFile = {read=GetDataFile};
	__property bool AutoUpdate = {read=FAutoUpdate, write=FAutoUpdate, nodefault};
	__property System::UnicodeString ActiveSection = {read=FActiveSection, write=SetActiveSection};
	__property bool IsLoading = {read=FIsLoading, nodefault};
	
__published:
	__property bool CompressedStream = {read=FCompressedStream, write=SetCompressedStream, default=1};
};


enum DECLSPEC_DENUM Lmdstorbase__3 : unsigned char { ctString, ctInteger };

typedef System::Set<Lmdstorbase__3, Lmdstorbase__3::ctString, Lmdstorbase__3::ctInteger> TLMDStorCryptTypes;

class PASCALIMPLEMENTATION TLMDAbstractStorageCryptor : public TLMDStorComponent
{
	typedef TLMDStorComponent inherited;
	
protected:
	TLMDStorCryptTypes FCryptTypes;
	
public:
	virtual void __fastcall Encrypt(System::Classes::TMemoryStream* Stream) = 0 ;
	virtual void __fastcall Decrypt(System::Classes::TMemoryStream* Stream) = 0 ;
	virtual System::UnicodeString __fastcall EncryptString(System::UnicodeString Value) = 0 ;
	virtual System::UnicodeString __fastcall DecryptString(System::UnicodeString Value) = 0 ;
	virtual int __fastcall EncryptInteger(int Value) = 0 ;
	virtual int __fastcall DecryptInteger(int Value) = 0 ;
	__property TLMDStorCryptTypes CryptTypes = {read=FCryptTypes, write=FCryptTypes, default=0};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDAbstractStorageCryptor(System::Classes::TComponent* AOwner) : TLMDStorComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDAbstractStorageCryptor(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstorbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORBASE)
using namespace Lmdstorbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorbaseHPP
