// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDVersionInfo.pas' rev: 31.00 (Windows)

#ifndef LmdversioninfoHPP
#define LmdversioninfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDShBase.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdversioninfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDVersionInfo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDFileOs : unsigned char { foUNKNOWN, foDOS, foOS216, foOS232, foNT };

enum DECLSPEC_DENUM TLMDFileTyp : unsigned char { ftUNKNOWN, ftAPP, ftDLL, ftDRV, ftFONT, ftVXD, ftSTATIC_LIB };

class PASCALIMPLEMENTATION TLMDVersionInfo : public Lmdshbase::TLMDShellComponent
{
	typedef Lmdshbase::TLMDShellComponent inherited;
	
private:
	TLMDFileTyp FFileTyp;
	TLMDFileOs FFileOs;
	System::UnicodeString FRetrieveFilename;
	System::UnicodeString FFileSubTyp;
	System::UnicodeString FCreated;
	System::UnicodeString FLastModified;
	System::UnicodeString FLanguage;
	System::UnicodeString FLastAccess;
	System::UnicodeString FCompanyName;
	System::UnicodeString FProductVersion;
	System::UnicodeString FFileDes;
	System::UnicodeString FFileVersion;
	System::UnicodeString FInternalFileName;
	System::UnicodeString FOriginalFilename;
	System::UnicodeString FLegalCopyright;
	System::UnicodeString FLegalTrademarks;
	System::UnicodeString FProductName;
	System::UnicodeString FComments;
	bool FCompressed;
	bool FArchive;
	bool FReadOnly;
	bool FSystem;
	bool FHidden;
	bool FVolumeId;
	bool FAnyFile;
	bool FDirectory;
	bool FDebug;
	bool FPreRelease;
	bool FPatched;
	bool FPrivateBuild;
	bool FInfoInferred;
	bool FSpecialBuild;
	Vcl::Controls::TImageList* FSmallIconList;
	Vcl::Controls::TImageList* FLargeIconList;
	void __fastcall SetRetrieveFile(System::UnicodeString aValue);
	void __fastcall SetDummyString(System::UnicodeString aValue);
	void __fastcall SetDummyBool(bool aValue);
	void __fastcall SetDummyFileOs(TLMDFileOs aValue);
	void __fastcall SetDummyFileTyp(TLMDFileTyp aValue);
	
protected:
	void __fastcall GetInfos(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDVersionInfo(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDVersionInfo(void);
	__property Vcl::Controls::TImageList* LargeIcons = {read=FLargeIconList};
	__property Vcl::Controls::TImageList* SmallIcons = {read=FSmallIconList};
	
__published:
	__property About = {default=0};
	__property System::UnicodeString RetrieveFilename = {read=FRetrieveFilename, write=SetRetrieveFile};
	__property System::UnicodeString FileSubTyp = {read=FFileSubTyp, write=SetDummyString, stored=false};
	__property System::UnicodeString CompanyName = {read=FCompanyName, write=SetDummyString, stored=false};
	__property System::UnicodeString ProductVersion = {read=FProductVersion, write=SetDummyString, stored=false};
	__property System::UnicodeString FileVersion = {read=FFileVersion, write=SetDummyString, stored=false};
	__property System::UnicodeString InternalFilename = {read=FInternalFileName, write=SetDummyString, stored=false};
	__property System::UnicodeString OriginalFilename = {read=FOriginalFilename, write=SetDummyString, stored=false};
	__property System::UnicodeString ProductName = {read=FProductName, write=SetDummyString, stored=false};
	__property System::UnicodeString Comments = {read=FComments, write=SetDummyString, stored=false};
	__property System::UnicodeString Language = {read=FLanguage, write=SetDummyString, stored=false};
	__property System::UnicodeString LegalCopyright = {read=FLegalCopyright, write=SetDummyString, stored=false};
	__property System::UnicodeString LegalTrademarks = {read=FLegalTrademarks, write=SetDummyString, stored=false};
	__property System::UnicodeString FileDescription = {read=FFileDes, write=SetDummyString, stored=false};
	__property bool Debug = {read=FDebug, write=SetDummyBool, stored=false, nodefault};
	__property bool PreRelease = {read=FPreRelease, write=SetDummyBool, stored=false, nodefault};
	__property bool Patched = {read=FPatched, write=SetDummyBool, stored=false, nodefault};
	__property bool PrivateBuild = {read=FPrivateBuild, write=SetDummyBool, stored=false, nodefault};
	__property bool InfoInferred = {read=FInfoInferred, write=SetDummyBool, stored=false, nodefault};
	__property bool SpecialBuild = {read=FSpecialBuild, write=SetDummyBool, stored=false, nodefault};
	__property System::UnicodeString LastModified = {read=FLastModified, write=SetDummyString, stored=false};
	__property System::UnicodeString LastAccess = {read=FLastAccess, write=SetDummyString, stored=false};
	__property System::UnicodeString Created = {read=FCreated, write=SetDummyString, stored=false};
	__property bool Archive = {read=FArchive, write=SetDummyBool, stored=false, nodefault};
	__property bool ReadOnly = {read=FReadOnly, write=SetDummyBool, stored=false, nodefault};
	__property bool System = {read=FSystem, write=SetDummyBool, stored=false, nodefault};
	__property bool Hidden = {read=FHidden, write=SetDummyBool, stored=false, nodefault};
	__property bool VolumeId = {read=FVolumeId, write=SetDummyBool, stored=false, nodefault};
	__property bool AnyFile = {read=FAnyFile, write=SetDummyBool, stored=false, nodefault};
	__property bool Directory = {read=FDirectory, write=SetDummyBool, stored=false, nodefault};
	__property bool Compressed = {read=FCompressed, write=SetDummyBool, stored=false, nodefault};
	__property TLMDFileOs FileOs = {read=FFileOs, write=SetDummyFileOs, stored=false, nodefault};
	__property TLMDFileTyp FileTyp = {read=FFileTyp, write=SetDummyFileTyp, stored=false, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdversioninfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDVERSIONINFO)
using namespace Lmdversioninfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdversioninfoHPP
