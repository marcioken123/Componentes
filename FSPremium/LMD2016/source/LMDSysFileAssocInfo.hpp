// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysFileAssocInfo.pas' rev: 31.00 (Windows)

#ifndef LmdsysfileassocinfoHPP
#define LmdsysfileassocinfoHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysfileassocinfo
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFileAction;
class DELPHICLASS TLMDFileActions;
class DELPHICLASS TLMDFileAssocItem;
class DELPHICLASS TLMDFileAssocsInfo;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFileAction : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	System::UnicodeString FActionName;
	System::UnicodeString FActionFile;
	void __fastcall SetDummyString(const System::UnicodeString Value);
	void __fastcall SetString(const System::UnicodeString Value);
	
protected:
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	virtual void __fastcall RegisterProperties(void);
	
public:
	virtual void __fastcall Apply(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property System::UnicodeString ActionName = {read=FActionName, write=SetDummyString};
	__property System::UnicodeString ActionFile = {read=FActionFile, write=SetString};
public:
	/* TLMDSysBaseCollectionItem.Create */ inline __fastcall virtual TLMDFileAction(System::Classes::TCollection* Collection) : Lmdsysobject::TLMDSysCollectionItem(Collection) { }
	/* TLMDSysBaseCollectionItem.Destroy */ inline __fastcall virtual ~TLMDFileAction(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDFileActions : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDFileAction* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TPersistent* FOwner;
	HIDESBASE TLMDFileAction* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDFileAction* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDFileAction* __fastcall Add(void);
	__fastcall TLMDFileActions(System::Classes::TPersistent* aOwner);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDFileAction* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TLMDSysCollection.Destroy */ inline __fastcall virtual ~TLMDFileActions(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFileAssocItem : public Lmdsysobject::TLMDSysCollectionItem
{
	typedef Lmdsysobject::TLMDSysCollectionItem inherited;
	
private:
	System::UnicodeString FSubClass;
	System::UnicodeString FDescription;
	System::UnicodeString FExt;
	TLMDFileActions* FActions;
	System::UnicodeString FDefaultIconStr;
	void __fastcall SetDummyActions(TLMDFileActions* const Value);
	void __fastcall SetDummyString(const System::UnicodeString Value);
	void __fastcall SetString(int Index, const System::UnicodeString Value);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
public:
	__fastcall virtual TLMDFileAssocItem(System::Classes::TCollection* ACollection);
	__fastcall virtual ~TLMDFileAssocItem(void);
	virtual void __fastcall Apply(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	int __fastcall GetElementCount(void);
	System::TObject* __fastcall GetElement(int index);
	
__published:
	__property System::UnicodeString Ext = {read=FExt, write=SetDummyString};
	__property System::UnicodeString Description = {read=FDescription, write=SetString, index=0};
	__property System::UnicodeString DefaultIconStr = {read=FDefaultIconStr, write=SetString, index=1};
	__property TLMDFileActions* Actions = {read=FActions, write=SetDummyActions};
private:
	void *__ILMDSysContainer;	// Lmdsysbase::ILMDSysContainer 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D8DECF0C-3DE0-4E44-AD38-F022380E2970}
	operator Lmdsysbase::_di_ILMDSysContainer()
	{
		Lmdsysbase::_di_ILMDSysContainer intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Lmdsysbase::ILMDSysContainer*(void) { return (Lmdsysbase::ILMDSysContainer*)&__ILMDSysContainer; }
	#endif
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDFileAssocsInfo : public Lmdsysobject::TLMDSysCollection
{
	typedef Lmdsysobject::TLMDSysCollection inherited;
	
public:
	TLMDFileAssocItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	System::Classes::TComponent* FOwner;
	HIDESBASE TLMDFileAssocItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDFileAssocItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDFileAssocItem* __fastcall Add(void);
	__fastcall TLMDFileAssocsInfo(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDFileAssocsInfo(void);
	void __fastcall Refresh(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property TLMDFileAssocItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsysfileassocinfo */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSFILEASSOCINFO)
using namespace Lmdsysfileassocinfo;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysfileassocinfoHPP
