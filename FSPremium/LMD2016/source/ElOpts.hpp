// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElOpts.pas' rev: 31.00 (Windows)

#ifndef EloptsHPP
#define EloptsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Win.Registry.hpp>
#include <System.IniFiles.hpp>
#include <ElIni.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <ElVCLUtils.hpp>
#include <System.Types.hpp>
#include <System.TypInfo.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elopts
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElOptions;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElStorageType : unsigned char { eosRegistry, eosIni, eosElIni };

class PASCALIMPLEMENTATION TElOptions : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
protected:
	bool FAutoSave;
	System::UnicodeString FIniName;
	System::UnicodeString FIniSection;
	bool FLoading;
	Elini::TElIniFile* FStorage;
	TElStorageType FStorageType;
	virtual void __fastcall SetAutoSave(bool Value);
	
public:
	__fastcall virtual TElOptions(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElOptions(void);
	virtual void __fastcall Load(void);
	virtual void __fastcall Save(void);
	__property bool Loading = {read=FLoading, nodefault};
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property bool AutoSave = {read=FAutoSave, write=SetAutoSave, nodefault};
	__property System::UnicodeString IniName = {read=FIniName, write=FIniName};
	__property System::UnicodeString IniSection = {read=FIniSection, write=FIniSection};
	__property Elini::TElIniFile* Storage = {read=FStorage, write=FStorage};
	__property TElStorageType StorageType = {read=FStorageType, write=FStorageType, nodefault};
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elopts */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELOPTS)
using namespace Elopts;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EloptsHPP
