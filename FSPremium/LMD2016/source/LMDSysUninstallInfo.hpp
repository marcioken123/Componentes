// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysUninstallInfo.pas' rev: 31.00 (Windows)

#ifndef LmdsysuninstallinfoHPP
#define LmdsysuninstallinfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysLogStrings.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysuninstallinfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDUninstallItem;
class DELPHICLASS TLMDUninstallInfo;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUninstallItem : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	System::UnicodeString FregProgramName;
	System::UnicodeString FProgramName;
	System::UnicodeString FRegOwner;
	System::UnicodeString FHelpLink;
	System::UnicodeString FPublisherURL;
	System::UnicodeString FRegCompany;
	System::UnicodeString FPublisher;
	System::UnicodeString FVersion;
	System::UnicodeString FUninstallPath;
	System::UnicodeString FUpdateInfoURL;
	void __fastcall SetString(int aIndex, const System::UnicodeString aValue);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property System::UnicodeString ProgramName = {read=FProgramName, write=SetString, stored=false, index=0};
	__property System::UnicodeString UninstallPath = {read=FUninstallPath, write=SetString, stored=false, index=1};
	__property System::UnicodeString Publisher = {read=FPublisher, write=SetString, stored=false, index=2};
	__property System::UnicodeString PublisherURL = {read=FPublisherURL, write=SetString, stored=false, index=3};
	__property System::UnicodeString Version = {read=FVersion, write=SetString, stored=false, index=4};
	__property System::UnicodeString HelpLink = {read=FHelpLink, write=SetString, stored=false, index=5};
	__property System::UnicodeString UpdateInfoURL = {read=FUpdateInfoURL, write=SetString, stored=false, index=6};
	__property System::UnicodeString RegCompany = {read=FRegCompany, write=SetString, stored=false, index=7};
	__property System::UnicodeString RegOwner = {read=FRegOwner, write=SetString, stored=false, index=8};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDUninstallItem(System::Classes::TCollection* Collection) : Lmdsysobject::TLMDSysCollectionItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDUninstallItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDUninstallInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDUninstallItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TComponent* FOwner;
	HIDESBASE TLMDUninstallItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDUninstallItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDUninstallItem* __fastcall Add(void);
	__fastcall TLMDUninstallInfo(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDUninstallInfo(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDUninstallItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysuninstallinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSUNINSTALLINFO)
using namespace Lmdsysuninstallinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysuninstallinfoHPP
