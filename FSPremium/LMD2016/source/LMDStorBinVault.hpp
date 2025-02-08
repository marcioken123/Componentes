// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStorBinVault.pas' rev: 31.00 (Windows)

#ifndef LmdstorbinvaultHPP
#define LmdstorbinvaultHPP

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
#include <Winapi.Windows.hpp>
#include <System.Types.hpp>
#include <LMDStorXMLVault.hpp>
#include <LMDStorBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstorbinvault
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStorCustomBinVault;
class DELPHICLASS TLMDStorBinVault;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStorCustomBinVault : public Lmdstorxmlvault::TLMDStorCustomXMLVault
{
	typedef Lmdstorxmlvault::TLMDStorCustomXMLVault inherited;
	
protected:
	DYNAMIC System::UnicodeString __fastcall Extension(void);
	
public:
	__fastcall virtual TLMDStorCustomBinVault(System::Classes::TComponent* AOwner);
public:
	/* TLMDStorCustomXMLVault.Destroy */ inline __fastcall virtual ~TLMDStorCustomBinVault(void) { }
	
};


class PASCALIMPLEMENTATION TLMDStorBinVault : public TLMDStorCustomBinVault
{
	typedef TLMDStorCustomBinVault inherited;
	
__published:
	__property FileName = {default=0};
	__property FilePrefix = {default=2};
	__property AppDataPath = {default=0};
	__property AppDataCommon = {default=0};
	__property Encrypted = {default=0};
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
	/* TLMDStorCustomBinVault.Create */ inline __fastcall virtual TLMDStorBinVault(System::Classes::TComponent* AOwner) : TLMDStorCustomBinVault(AOwner) { }
	
public:
	/* TLMDStorCustomXMLVault.Destroy */ inline __fastcall virtual ~TLMDStorBinVault(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstorbinvault */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTORBINVAULT)
using namespace Lmdstorbinvault;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstorbinvaultHPP
