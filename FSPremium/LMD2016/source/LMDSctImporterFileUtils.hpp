// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctImporterFileUtils.pas' rev: 31.00 (Windows)

#ifndef LmdsctimporterfileutilsHPP
#define LmdsctimporterfileutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Forms.hpp>
#include <System.Win.Registry.hpp>
#include <Vcl.FileCtrl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctimporterfileutils
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDFileHandler;
class DELPHICLASS TLMDFileHandler;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDFileHandler : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDFileHandler(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDFileHandler(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDFileHandler(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDFileHandler(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDFileHandler(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDFileHandler(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDFileHandler(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDFileHandler(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDFileHandler(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDFileHandler(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDFileHandler(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDFileHandler(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDFileHandler(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFileHandler : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FUnitPath;
	System::Classes::TStrings* FLibPaths;
	System::Classes::TStrings* FNamespacePrefixes;
	System::UnicodeString FVCLImportSubpath;
	__classmethod System::UnicodeString __fastcall GetPathFromRegistry(const System::UnicodeString AKey);
	System::UnicodeString __fastcall GetVCLStubPath(void);
	System::UnicodeString __fastcall GetVCLWrapperPath(void);
	bool __fastcall FindFullPath(const System::UnicodeString AShortFileName, /* out */ System::UnicodeString &APath);
	void __fastcall FindFiles(const System::UnicodeString ADirectory, const System::UnicodeString AMask, bool AWithSubdirs, System::Classes::TStrings* AResFilePaths);
	
public:
	__fastcall TLMDFileHandler(const System::UnicodeString AUnitPath);
	__fastcall virtual ~TLMDFileHandler(void);
	__classmethod System::UnicodeString __fastcall GetVCLHintFileName();
	bool __fastcall FindStub(/* out */ System::UnicodeString &APath);
	bool __fastcall FindINCFile(const System::UnicodeString AIncFileName, /* out */ System::UnicodeString &APath);
	bool __fastcall FindUsedPasFile(const System::UnicodeString AUnitName, /* out */ System::UnicodeString &APath);
	bool __fastcall FindUsedUSUFile(const System::UnicodeString AUnitName, /* out */ System::UnicodeString &APath);
	bool __fastcall FindUIMFile(/* out */ System::UnicodeString &APath);
	System::UnicodeString __fastcall GetUSUSavePath(bool AIsSysLib);
	System::UnicodeString __fastcall GetUIMSavePath(bool AIsSysLib);
	System::UnicodeString __fastcall GetWrapperUnitName(const System::UnicodeString AUnitName);
	System::UnicodeString __fastcall GetWrapperUnitSavePath(bool AIsSysLib);
	__property System::UnicodeString UnitPath = {read=FUnitPath, write=FUnitPath};
	__property System::UnicodeString VCLImportSubpath = {read=FVCLImportSubpath, write=FVCLImportSubpath};
	__property System::Classes::TStrings* LibPaths = {read=FLibPaths};
	__property System::Classes::TStrings* NamespacePrefixes = {read=FNamespacePrefixes};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsctimporterfileutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTIMPORTERFILEUTILS)
using namespace Lmdsctimporterfileutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctimporterfileutilsHPP
