// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorXMLVault.pas' rev: 31.00 (Windows)

#ifndef LmdstorxmlvaultHPP
#define LmdstorxmlvaultHPP

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
#include <LMDTypes.hpp>
#include <LMDUnicode.hpp>
#include <LMDStorBase.hpp>
#include <LMDStorCommon.hpp>
#include <LMDStorXMLSupport.hpp>
#include <LMDStorPropertiesStorage.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstorxmlvault
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TXMLCrackWriter;
class DELPHICLASS TLMDStorCustomXMLVault;
class DELPHICLASS TLMDStorXMLVault;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TXMLCrackWriter : public System::Classes::TWriter
{
	typedef System::Classes::TWriter inherited;
	
public:
	/* TWriter.Destroy */ inline __fastcall virtual ~TXMLCrackWriter(void) { }
	
public:
	/* TFiler.Create */ inline __fastcall TXMLCrackWriter(System::Classes::TStream* Stream, int BufSize) : System::Classes::TWriter(Stream, BufSize) { }
	
};


class PASCALIMPLEMENTATION TLMDStorCustomXMLVault : public Lmdstorbase::TLMDAbstractStorageVault
{
	typedef Lmdstorbase::TLMDAbstractStorageVault inherited;
	
private:
	System::UnicodeString FHeader;
	System::UnicodeString FFooter;
	System::UnicodeString FMainTag;
	bool Parsed;
	bool FNormalizeSeparators;
	void __fastcall SetHeader(const System::UnicodeString Value);
	void __fastcall SetFooter(const System::UnicodeString Value);
	void __fastcall SetMainTag(const System::UnicodeString Value);
	System::UnicodeString __fastcall CurrentActiveSection(void);
	Lmdstorxmlsupport::TLMDStorXMLTag* __fastcall GetTag(const System::UnicodeString Section);
	void __fastcall WriteSimpleProperty(const System::UnicodeString Section, const System::UnicodeString Ident, const System::UnicodeString PropType, const System::UnicodeString PropValue);
	void __fastcall ReadSimpleProperty(const System::UnicodeString Section, const System::UnicodeString Ident, System::UnicodeString &PropType, System::UnicodeString &PropValue);
	void __fastcall LoadComponent(Lmdstorxmlsupport::TLMDStorXMLTag* Tag, TXMLCrackWriter* Writer);
	void __fastcall SaveObject(System::Classes::TStream* Stream, System::UnicodeString Section, System::UnicodeString szType);
	void __fastcall WriteEssence(const System::UnicodeString Section, const System::UnicodeString Ident, const System::UnicodeString szType, System::Classes::TPersistent* Instance);
	System::Classes::TPersistent* __fastcall ReadEssence(const System::UnicodeString Section, const System::UnicodeString Ident, const System::UnicodeString szType, System::Classes::TPersistent* Instance);
	bool __fastcall IsCustomFooter(void);
	bool __fastcall IsCustomHeader(void);
	bool __fastcall IsCustomMainTag(void);
	void __fastcall WriteData(Lmdstorxmlsupport::TLMDStorXMLTag* Tag, System::UnicodeString Name, System::UnicodeString szType, const void *Data, int DataSize);
	
protected:
	Lmdstorxmlsupport::TLMDStorXML* XML;
	bool BinaryState;
	DYNAMIC System::UnicodeString __fastcall Extension(void);
	System::UnicodeString __fastcall Normalize(System::UnicodeString v);
	virtual void __fastcall FileChanged(void);
	__property System::UnicodeString Header = {read=FHeader, write=SetHeader, stored=IsCustomHeader};
	__property System::UnicodeString Footer = {read=FFooter, write=SetFooter, stored=IsCustomFooter};
	__property System::UnicodeString MainTag = {read=FMainTag, write=SetMainTag, stored=IsCustomMainTag};
	
public:
	__fastcall virtual TLMDStorCustomXMLVault(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDStorCustomXMLVault(void);
	virtual void __fastcall Save(System::Classes::TMemoryStream* Stream);
	virtual void __fastcall Load(System::Classes::TMemoryStream* Stream);
	virtual void __fastcall Open(void);
	virtual void __fastcall Close(void);
	virtual void __fastcall Update(void);
	void __fastcall Delete(void);
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
	void __fastcall DeleteKeyEx(const System::UnicodeString Section, const System::UnicodeString Ident, const System::UnicodeString Attribute);
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
	__property bool NormalizeSeparators = {read=FNormalizeSeparators, write=FNormalizeSeparators, nodefault};
};


class PASCALIMPLEMENTATION TLMDStorXMLVault : public TLMDStorCustomXMLVault
{
	typedef TLMDStorCustomXMLVault inherited;
	
__published:
	__property BinaryStream = {default=0};
	__property FileName = {default=0};
	__property FilePrefix = {default=2};
	__property AppDataPath = {default=0};
	__property AppDataCommon = {default=0};
	__property Encrypted = {default=0};
	__property Header = {default=0};
	__property Footer = {default=0};
	__property MainTag = {default=0};
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
	__property OnUpdateBeforeClose;
	__property StorageCryptor;
	__property Sections;
	__property ActiveSection = {default=0};
	__property ActiveSectionIndex = {default=-1};
	__property AutoUpdate;
	__property NormalizeSeparators = {default=0};
public:
	/* TLMDStorCustomXMLVault.Create */ inline __fastcall virtual TLMDStorXMLVault(System::Classes::TComponent* AOwner) : TLMDStorCustomXMLVault(AOwner) { }
	/* TLMDStorCustomXMLVault.Destroy */ inline __fastcall virtual ~TLMDStorXMLVault(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word MaxXMLStringLength = System::Word(0x384);
}	/* namespace Lmdstorxmlvault */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORXMLVAULT)
using namespace Lmdstorxmlvault;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorxmlvaultHPP
