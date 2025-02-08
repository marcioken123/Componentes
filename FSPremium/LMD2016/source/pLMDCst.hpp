// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDCst.pas' rev: 31.00 (Windows)

#ifndef PlmdcstHPP
#define PlmdcstHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDStrings.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdcst
{
//-- forward type declarations -----------------------------------------------
struct TLMDHelpFileEntry;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDHelpfile : unsigned char { lhfTools, lhfElPack, lhfShared, lhfGrid, lhfPacks, lhfIDETools };

struct DECLSPEC_DRECORD TLMDHelpFileEntry
{
public:
	System::UnicodeString FileName;
	System::UnicodeString Caption;
};


typedef System::StaticArray<TLMDHelpFileEntry, 6> Plmdcst__1;

//-- var, const, procedure ---------------------------------------------------
#define sLMDDesignRtlResourceName L"pLMDEditors"
#define sLMDDesignSplashResourceName L"LMDSplash"
#define sLMDSharedName L"LMD VCL 2016"
#define sLMDSplashIconResource L"LMDICON"
#define sLMDTargetName L""
#define sLMDPackageName L"LMD VCL 2016 - Common Designtime Support"
#define sLMDAboutDescription L"LMD VCL 2016 - Common Designtime Support\r\nProvides commo"\
	L"n editors and designtime support for all LMD VCL 2016 pack"\
	L"ages\r\n\r\n(c) by LMD Innovative, Germany"
static const System::Int8 LMDPE_DEFVISUALWIDTH = System::Int8(0x18);
static const System::Int8 LMDPE_DEFSHAREDOPTIONS = System::Int8(0x1f);
static const System::Int8 LMDPE_DEFLMDTOOLSOPTIONS = System::Int8(0x1);
#define LMDTOOLS_APPNAME L"lmdutil"
#define LMDELPACK_REGISTRYPATH L"SOFTWARE\\LMD Innovative\\LMD-Tools 2016\\LMD ElPack"
extern DELPHI_PACKAGE Plmdcst__1 LMDHelpFiles;
#define LMDREGROOTDIR L"Software\\Embarcadero\\BDS\\18.0"
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDTOOLS_COMPILERNAME(void);
}	/* namespace Plmdcst */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCST)
using namespace Plmdcst;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdcstHPP
