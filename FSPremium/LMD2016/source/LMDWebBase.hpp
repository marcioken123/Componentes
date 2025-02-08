// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebBase.pas' rev: 31.00 (Windows)

#ifndef LmdwebbaseHPP
#define LmdwebbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebbase
{
//-- forward type declarations -----------------------------------------------
struct TLMDWebVersionRecord;
class DELPHICLASS TLMDWebComponent;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TLMDWebVersionRecord
{
public:
	System::Word Major;
	System::Word Minor;
	System::Word Release;
	System::Word Build;
};


class PASCALIMPLEMENTATION TLMDWebComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDWebComponent(System::Classes::TComponent* AOwner) : Lmdcustomcomponent::TLMDCustomComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDWebComponent(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define WU_MAIN_DIR L"%MAIN%"
#define WU_SYSTEM_DIR L"%SYSTEM%"
#define WU_WINDOWS_DIR L"%WINDOWS%"
#define WU_COMP_SIGN L"WU COMP"
static const System::Int8 MAX_SERVER_THREADS = System::Int8(0x1e);
static const System::Int8 SE_EXCEPTION = System::Int8(0x1);
#define LNEWS_IMAGES_ROOTKEY L"IMAGES"
#define LNEWS_ROOTKEY L"NEWS"
#define LNEWS_TREE_ROOTKEY L"NEWSTREE"
#define LNEWS_URL L"URL"
#define LNEWS_SEL_IMAGE L"SELECTEDIMAGE"
#define LNEWS_IMAGE L"IMAGE"
#define LNEWS_IMAGES_BASEURL L"BASEURL"
#define LNEWS_IMAGES_INDEX L"INDEX"
#define LNEWS_IMAGES_FILENAME L"FILENAME"
extern DELPHI_PACKAGE void __fastcall LMDWebDeCompress(System::Classes::TStream* InStream, System::Classes::TStream* OutStream);
extern DELPHI_PACKAGE bool __fastcall LMDWebCompressFile(System::UnicodeString szOldFileName, System::UnicodeString szNewFileName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWebGetFullFileName(const System::UnicodeString szFileName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWebVersionToStr(const TLMDWebVersionRecord &Version);
extern DELPHI_PACKAGE bool __fastcall LMDWebGetFileVersionRecord(const System::UnicodeString FileName, TLMDWebVersionRecord &vr);
extern DELPHI_PACKAGE bool __fastcall LMDWebGetFileVersion(const System::UnicodeString FileName, System::UnicodeString &VersionString);
extern DELPHI_PACKAGE int __fastcall LMDWebCompareVersionNumber(const System::UnicodeString szTest, const System::UnicodeString szBase = System::UnicodeString());
extern DELPHI_PACKAGE bool __fastcall LMDWebRenameFileEx(const System::UnicodeString szOldFileName, const System::UnicodeString szNewFileName, bool &NeedReboot);
extern DELPHI_PACKAGE bool __fastcall LMDWebTerminateProcessByName(const System::UnicodeString FileName);
extern DELPHI_PACKAGE void __fastcall LMDWebExecuteFile(const System::UnicodeString FileName, bool Wait);
extern DELPHI_PACKAGE void __fastcall LMDWebClearData(void *D, int Size, System::Byte Ch);
}	/* namespace Lmdwebbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBBASE)
using namespace Lmdwebbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebbaseHPP
