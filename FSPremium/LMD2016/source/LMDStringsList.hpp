// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStringsList.pas' rev: 31.00 (Windows)

#ifndef LmdstringslistHPP
#define LmdstringslistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstringslist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStringsItem;
class DELPHICLASS TLMDStringsList;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStringsItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::Classes::TStringList* FStringList;
	
public:
	__fastcall virtual TLMDStringsItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDStringsItem(void);
	void __fastcall Replace(const System::UnicodeString aSrc, const System::UnicodeString aDect);
	__property System::Classes::TStringList* Strings = {read=FStringList};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStringsList : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDStringsItem* operator[](int index) { return this->Item[index]; }
	
private:
	HIDESBASE TLMDStringsItem* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDStringsList(void);
	HIDESBASE TLMDStringsItem* __fastcall Add(void);
	int __fastcall GetMaxSubItemsCount(void);
	int __fastcall GetMaxSubItemLength(int aCol);
	void __fastcall Replace(const System::UnicodeString aSrc, const System::UnicodeString aDect);
	__property TLMDStringsItem* Item[int index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDStringsList(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstringslist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTRINGSLIST)
using namespace Lmdstringslist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstringslistHPP
