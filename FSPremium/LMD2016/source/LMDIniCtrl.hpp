// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDIniCtrl.pas' rev: 34.00 (Windows)

#ifndef LmdinictrlHPP
#define LmdinictrlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.IniFiles.hpp>
#include <LMDProcs.hpp>
#include <LMDCustomComponent.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinictrl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMemIniFile;
class DELPHICLASS TLMDIniCtrl;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMemIniFile : public System::Inifiles::TMemIniFile
{
	typedef System::Inifiles::TMemIniFile inherited;
	
public:
	__fastcall virtual ~TLMDMemIniFile();
	void __fastcall RenameSection(const System::UnicodeString AOldName, const System::UnicodeString ANewName);
	void __fastcall LoadFromStream(System::Classes::TStream* AValue);
	void __fastcall Normalize(System::UnicodeString ARemToken = System::UnicodeString(), bool TrimValue = true);
public:
	/* TMemIniFile.Create */ inline __fastcall TLMDMemIniFile(const System::UnicodeString FileName)/* overload */ : System::Inifiles::TMemIniFile(FileName) { }
	/* TMemIniFile.Create */ inline __fastcall TLMDMemIniFile(const System::UnicodeString FileName, System::Sysutils::TEncoding* const Encoding)/* overload */ : System::Inifiles::TMemIniFile(FileName, Encoding) { }
	/* TMemIniFile.Create */ inline __fastcall TLMDMemIniFile(const System::UnicodeString FileName, System::Sysutils::TEncoding* const Encoding, bool CaseSensitive)/* overload */ : System::Inifiles::TMemIniFile(FileName, Encoding, CaseSensitive) { }
	/* TMemIniFile.Create */ inline __fastcall virtual TLMDMemIniFile(const System::UnicodeString FileName, System::Sysutils::TEncoding* const Encoding, bool CaseSensitive, bool UseLocale)/* overload */ : System::Inifiles::TMemIniFile(FileName, Encoding, CaseSensitive, UseLocale) { }
	/* TMemIniFile.Create */ inline __fastcall virtual TLMDMemIniFile(System::Classes::TStream* Stream, System::Sysutils::TEncoding* const Encoding, bool CaseSensitive, bool UseLocale)/* overload */ : System::Inifiles::TMemIniFile(Stream, Encoding, CaseSensitive, UseLocale) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDIniCryptMode : unsigned char { icmKey, icmTextKey, icmCustom };

typedef void __fastcall (__closure *TLMDIniCryptEvent)(System::TObject* Sender, System::UnicodeString &data);

typedef void __fastcall (__closure *TLMDIniCtrlEvent)(System::TObject* Sender, TLMDIniCtrl* aIniCtrl, System::UnicodeString Section);

enum DECLSPEC_DENUM TLMDIniUse : unsigned char { ioUseLink, ioUseGlobal, ioNone };

enum DECLSPEC_DENUM TLMDIniTarget : unsigned char { itIniFile, itRegistry, itAuto, itMemIniFile };

enum DECLSPEC_DENUM TLMDRegRootKey : unsigned char { rpClassesRoot, rpCurrentUser, rpLocalMachine, rpUsers, rpCurrentConfig, rpDynData };

class PASCALIMPLEMENTATION TLMDIniCtrl : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FCommon;
	bool FNetUser;
	System::UnicodeString FIniFile;
	System::UnicodeString FLastSection;
	System::UnicodeString FUser;
	Lmdprocs::TLMDPathPrefix FIniPrefix;
	TLMDMemIniFile* FMemIniFile;
	TLMDRegRootKey FRootKey;
	System::UnicodeString FRemoteComputer;
	System::UnicodeString FRegPath;
	bool FAlphaCounter;
	System::Byte FMaxEntries;
	TLMDIniTarget FTarget;
	TLMDIniTarget FHTarget;
	System::Word FKey;
	bool FCoded;
	TLMDIniCryptMode FCryptMode;
	TLMDIniCryptEvent FOnEncodeString;
	TLMDIniCryptEvent FOnDecodeString;
	bool FMemIniUtf8;
	void __fastcall SetIniFile(const System::UnicodeString aValue);
	void __fastcall SetNetUser(bool aValue);
	void __fastcall SetAlphaCounter(bool aValue);
	void __fastcall SetMaxEntries(System::Byte aValue);
	System::UnicodeString __fastcall GetCounterIdent(System::Byte aValue);
	void __fastcall SetSection(const System::UnicodeString aValue);
	void __fastcall SetTarget(TLMDIniTarget aValue);
	void __fastcall SetMemIniUtf8(const bool Value);
	void __fastcall RecreateMemIni();
	
protected:
	virtual System::UnicodeString __fastcall GetNetUserName();
	virtual System::UnicodeString __fastcall DoEncode(const System::UnicodeString Value);
	virtual System::UnicodeString __fastcall DoDecode(const System::UnicodeString Value);
	
public:
	__fastcall virtual TLMDIniCtrl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDIniCtrl();
	void __fastcall Clear();
	void __fastcall Load();
	void __fastcall Save();
	bool __fastcall SectionExists(const System::UnicodeString Section);
	bool __fastcall ValueExists(const System::UnicodeString Section, const System::UnicodeString Ident);
	System::UnicodeString __fastcall GetIniName();
	System::UnicodeString __fastcall GetRegPath();
	System::UnicodeString __fastcall GetSectionName(const System::UnicodeString aValue);
	void __fastcall ReadSection(const System::UnicodeString Section, System::Classes::TStrings* Strings);
	void __fastcall ReadSections(System::Classes::TStrings* Strings);
	void __fastcall ReadSectionValues(const System::UnicodeString Section, System::Classes::TStrings* Strings);
	void __fastcall DeleteKey(const System::UnicodeString Section, const System::UnicodeString Ident);
	void __fastcall EraseSection(const System::UnicodeString Section);
	bool __fastcall ReadBool(const System::UnicodeString Section, const System::UnicodeString Ident, bool ADefault);
	void __fastcall ReadColorList(const System::UnicodeString Section, System::Classes::TStrings* Strings);
	System::TDateTime __fastcall ReadDate(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime ADefault);
	System::TDateTime __fastcall ReadDateTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime ADefault);
	System::Extended __fastcall ReadFloat(const System::UnicodeString Section, const System::UnicodeString Ident, System::Extended ADefault);
	int __fastcall ReadInteger(const System::UnicodeString Section, const System::UnicodeString Ident, int ADefault);
	System::UnicodeString __fastcall ReadString(const System::UnicodeString Section, const System::UnicodeString Ident, const System::UnicodeString ADefault);
	void __fastcall ReadStrings(const System::UnicodeString Section, const System::UnicodeString IdentPrefix, System::Classes::TStrings* Strings);
	void __fastcall ReadStringsExt(const System::UnicodeString Section, const System::UnicodeString IdentPrefix, System::Classes::TStrings* Strings, System::Byte Entries);
	System::TDateTime __fastcall ReadTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime ADefault);
	System::Uitypes::TColor __fastcall ReadColor(const System::UnicodeString Section, const System::UnicodeString Ident, System::Uitypes::TColor ADefault);
	bool __fastcall ReadFont(const System::UnicodeString Section, const System::UnicodeString Ident, Vcl::Graphics::TFont* aValue);
	System::Types::TPoint __fastcall ReadPoint(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TPoint &ADefault);
	System::Types::TRect __fastcall ReadRect(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TRect &ADefault);
	void __fastcall ReadObject(const System::UnicodeString Section, System::TObject* aValue);
	void __fastcall WriteColor(const System::UnicodeString Section, const System::UnicodeString Ident, System::Uitypes::TColor aValue);
	void __fastcall WriteColorList(const System::UnicodeString Section, System::Classes::TStrings* Strings);
	void __fastcall WriteFont(const System::UnicodeString Section, const System::UnicodeString Ident, Vcl::Graphics::TFont* aValue);
	void __fastcall WriteRect(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TRect &aValue);
	void __fastcall WritePoint(const System::UnicodeString Section, const System::UnicodeString Ident, const System::Types::TPoint &aValue);
	void __fastcall WriteBool(const System::UnicodeString Section, const System::UnicodeString Ident, bool Value);
	void __fastcall WriteDate(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value);
	void __fastcall WriteDateTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value);
	void __fastcall WriteInteger(const System::UnicodeString Section, const System::UnicodeString Ident, int Value);
	void __fastcall WriteFloat(const System::UnicodeString Section, const System::UnicodeString Ident, System::Extended Value);
	void __fastcall WriteString(const System::UnicodeString Section, const System::UnicodeString Ident, const System::UnicodeString Value);
	void __fastcall WriteStrings(const System::UnicodeString Section, const System::UnicodeString IdentPrefix, System::Classes::TStrings* Strings);
	void __fastcall WriteStringsExt(const System::UnicodeString Section, const System::UnicodeString IdentPrefix, System::Classes::TStrings* Strings, System::Byte Entries);
	void __fastcall WriteTime(const System::UnicodeString Section, const System::UnicodeString Ident, System::TDateTime Value);
	void __fastcall WriteObject(const System::UnicodeString Section, System::TObject* aValue);
	__property TLMDMemIniFile* MemIniFile = {read=FMemIniFile};
	__property System::UnicodeString Section = {read=FLastSection, write=SetSection};
	
__published:
	__property About = {default=0};
	__property bool AlphaCounter = {read=FAlphaCounter, write=SetAlphaCounter, default=0};
	__property bool Common = {read=FCommon, write=FCommon, default=1};
	__property System::UnicodeString IniFile = {read=FIniFile, write=SetIniFile};
	__property bool MemIniUtf8 = {read=FMemIniUtf8, write=SetMemIniUtf8, default=0};
	__property Lmdprocs::TLMDPathPrefix IniPrefix = {read=FIniPrefix, write=FIniPrefix, default=0};
	__property System::Byte MaxEntries = {read=FMaxEntries, write=SetMaxEntries, default=16};
	__property bool NetUser = {read=FNetUser, write=SetNetUser, default=0};
	__property System::UnicodeString User = {read=FUser, write=FUser};
	__property System::UnicodeString RegPath = {read=FRegPath, write=FRegPath};
	__property TLMDRegRootKey RegRoot = {read=FRootKey, write=FRootKey, default=1};
	__property TLMDIniTarget Target = {read=FHTarget, write=SetTarget, default=2};
	__property System::Word EncKey = {read=FKey, write=FKey, default=12345};
	__property bool Encoded = {read=FCoded, write=FCoded, default=0};
	__property TLMDIniCryptMode CryptMode = {read=FCryptMode, write=FCryptMode, default=0};
	__property TLMDIniCryptEvent OnEncodeString = {read=FOnEncodeString, write=FOnEncodeString};
	__property TLMDIniCryptEvent OnDecodeString = {read=FOnDecodeString, write=FOnDecodeString};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString IDS_ROOT;
extern DELPHI_PACKAGE System::UnicodeString IDS_COMMON;
extern DELPHI_PACKAGE HKEY __fastcall LMDGetRootKey(TLMDRegRootKey aValue);
extern DELPHI_PACKAGE void __fastcall LMDSaveObjectProperties(System::Inifiles::TCustomIniFile* IniFile, System::UnicodeString szSection, System::TObject* AInstance);
extern DELPHI_PACKAGE void __fastcall LMDLoadObjectProperties(System::Inifiles::TCustomIniFile* IniFile, System::UnicodeString szSection, System::TObject* AInstance);
}	/* namespace Lmdinictrl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINICTRL)
using namespace Lmdinictrl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinictrlHPP
