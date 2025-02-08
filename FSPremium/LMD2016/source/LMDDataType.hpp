// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDataType.pas' rev: 31.00 (Windows)

#ifndef LmddatatypeHPP
#define LmddatatypeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddatatype
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAssociation;
class DELPHICLASS TLMDMap;
class DELPHICLASS TLMDHashTable;
class DELPHICLASS TLMDCustomStack;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDAssociation : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FKey;
	
public:
	__fastcall virtual TLMDAssociation(System::Classes::TCollection* aCollection);
	__property System::UnicodeString Key = {read=FKey, write=FKey};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDAssociation(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDAssociationClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMap : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDAssociation* operator[](const System::UnicodeString index) { return this->Items[index]; }
	
private:
	HIDESBASE TLMDAssociation* __fastcall GetItem(const System::UnicodeString index);
	bool __fastcall Find(const System::UnicodeString aKey, int &Index);
	
public:
	__fastcall TLMDMap(TLMDAssociationClass aItemClass);
	__fastcall virtual ~TLMDMap(void);
	HIDESBASE TLMDAssociation* __fastcall Add(const System::UnicodeString aKey);
	__property TLMDAssociation* Items[const System::UnicodeString index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDHashTable : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDAssociation* operator[](const System::UnicodeString index) { return this->Items[index]; }
	
private:
	System::Classes::TList* FList;
	int FMaxSize;
	TLMDAssociationClass FItemClass;
	System::StaticArray<System::Byte, 256> FRand;
	void __fastcall FillRand(void);
	
protected:
	TLMDAssociation* __fastcall GetItem(const System::UnicodeString index);
	
public:
	__fastcall TLMDHashTable(int aMaxSize, TLMDAssociationClass aItemClass);
	__fastcall virtual ~TLMDHashTable(void);
	virtual int __fastcall Hash(const System::UnicodeString aKey);
	TLMDAssociation* __fastcall Add(const System::UnicodeString aKey);
	int __fastcall count(void);
	void __fastcall Clear(void);
	__property TLMDAssociation* Items[const System::UnicodeString index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCustomStack : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::Classes::TList* FList;
	
protected:
	void * __fastcall GetTop(void);
	void __fastcall SetTop(void * aValue);
	
public:
	__fastcall TLMDCustomStack(void);
	__fastcall virtual ~TLMDCustomStack(void);
	void __fastcall Clear(void);
	void __fastcall Push(void * aItem);
	void * __fastcall Pop(void);
	__property void * Top = {read=GetTop, write=SetTop};
	bool __fastcall IsEmpty(void);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddatatype */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDATATYPE)
using namespace Lmddatatype;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddatatypeHPP
