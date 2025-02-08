// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysModemInfo.pas' rev: 31.00 (Windows)

#ifndef LmdsysmodeminfoHPP
#define LmdsysmodeminfoHPP

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
#include <LMDSysBase.hpp>
#include <LMDSysConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysmodeminfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDModemItem;
class DELPHICLASS TLMDModemInfo;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysModemDisplayInfo : unsigned char { mopidName, mopidAttachedTo, mopidUserInit, mopidPortSpeed };

typedef System::Set<TLMDSysModemDisplayInfo, TLMDSysModemDisplayInfo::mopidName, TLMDSysModemDisplayInfo::mopidPortSpeed> TLMDSysModemDisplayInfos;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 4> Lmdsysmodeminfo__1;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDModemItem : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	System::UnicodeString FSubKeyName;
	int FPortSpeed;
	System::UnicodeString FAttachedTo;
	System::UnicodeString FName;
	System::UnicodeString FUserInit;
	void __fastcall SetDummyLong(const int Value);
	void __fastcall SetDummyString(const System::UnicodeString Value);
	void __fastcall SetString(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	TLMDSysModemDisplayInfos __fastcall GetDisplayInfo(void);
	
public:
	virtual void __fastcall Apply(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property System::UnicodeString Name = {read=FName, write=SetDummyString, stored=false};
	__property System::UnicodeString AttachedTo = {read=FAttachedTo, write=SetDummyString, stored=false};
	__property System::UnicodeString UserInit = {read=FUserInit, write=SetString, stored=false};
	__property int PortSpeed = {read=FPortSpeed, write=SetDummyLong, stored=false, nodefault};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDModemItem(System::Classes::TCollection* Collection) : Lmdsysobject::TLMDSysCollectionItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDModemItem(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDModemInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDModemItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TComponent* FOwner;
	HIDESBASE TLMDModemItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDModemItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDModemItem* __fastcall Add(void);
	__fastcall TLMDModemInfo(System::Classes::TComponent* aOwner);
	void __fastcall Refresh(void);
	void __fastcall UpdateProperties(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDModemItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TLMDSysCollection.Destroy */ inline __fastcall virtual ~TLMDModemInfo(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysModemDisplayInfos (System::Set<TLMDSysModemDisplayInfo, TLMDSysModemDisplayInfo::mopidName, TLMDSysModemDisplayInfo::mopidPortSpeed>() << TLMDSysModemDisplayInfo::mopidName << TLMDSysModemDisplayInfo::mopidAttachedTo << TLMDSysModemDisplayInfo::mopidUserInit << TLMDSysModemDisplayInfo::mopidPortSpeed )
extern DELPHI_PACKAGE Lmdsysmodeminfo__1 LMDSysModemProps;
}	/* namespace Lmdsysmodeminfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSMODEMINFO)
using namespace Lmdsysmodeminfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysmodeminfoHPP
