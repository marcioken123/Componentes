// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctClass.pas' rev: 31.00 (Windows)

#ifndef LmdsctclassHPP
#define LmdsctclassHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <System.VarUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctclass
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDIdentifierItem;
class DELPHICLASS TLMDIdentifierHashTable;
class DELPHICLASS TLMDNamedItem;
class DELPHICLASS TLMDNameHashTable;
//-- type declarations -------------------------------------------------------
typedef System::StaticArray<System::OleVariant, 1025> TLMDVarArray;

typedef TLMDVarArray *PLMDVarArray;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIdentifierItem : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	System::WideString Name;
	System::TObject* Data;
public:
	/* TObject.Create */ inline __fastcall TLMDIdentifierItem(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDIdentifierItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIdentifierHashTable : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<System::TObject*> _TLMDIdentifierHashTable__1;
	
	
private:
	bool FOwnItems;
	_TLMDIdentifierHashTable__1 FItems;
	int FIndexMask;
	int FCount;
	void __fastcall Grow(int AOldLength);
	void __fastcall Rehash(int AOldLength);
	void __fastcall InsertItem(System::TObject* AItem);
	System::TObject* __fastcall CreateColl(System::TObject* AItem, System::TObject* ANext);
	bool __fastcall DecodeEntry(System::TObject* ACur, /* out */ System::TObject* &AItem, /* out */ System::TObject* &ANext, /* out */ bool &AIsCol);
	int __fastcall StrHash(const System::WideString AKey);
	
public:
	__fastcall TLMDIdentifierHashTable(bool AOwnItems);
	__fastcall virtual ~TLMDIdentifierHashTable(void);
	void __fastcall Clear(void);
	bool __fastcall Add(TLMDIdentifierItem* AItem);
	bool __fastcall Remove(const System::WideString AKey);
	TLMDIdentifierItem* __fastcall Find(const System::WideString AKey);
	void __fastcall GetAll(System::Classes::TList* AResult);
	__property int Count = {read=FCount, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNamedItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FName;
	TLMDNamedItem* FNext;
	
public:
	__fastcall TLMDNamedItem(const int AName);
	__property int Name = {read=FName, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDNamedItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDNameHashTable : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TLMDNamedItem*> _TLMDNameHashTable__1;
	
	
private:
	bool FOwnItems;
	_TLMDNameHashTable__1 FItems;
	int FIndexMask;
	int FCount;
	void __fastcall Grow(int AOldLength);
	void __fastcall Rehash(int AOldLength);
	void __fastcall InsertItem(TLMDNamedItem* AItem);
	
public:
	__fastcall TLMDNameHashTable(bool AOwnItems);
	__fastcall virtual ~TLMDNameHashTable(void);
	void __fastcall Clear(void);
	bool __fastcall Add(TLMDNamedItem* AItem);
	bool __fastcall Remove(const int AKey);
	TLMDNamedItem* __fastcall Find(const int AKey);
	void __fastcall GetAll(System::Classes::TList* AResult);
	__property int Count = {read=FCount, nodefault};
};

#pragma pack(pop)

;

;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall VarResultCheck(HRESULT AResult);
extern DELPHI_PACKAGE void __fastcall VarCastError(void);
extern DELPHI_PACKAGE void __fastcall VarInvalidOp(void);
extern DELPHI_PACKAGE void __fastcall VarArrayCreateError(void);
extern DELPHI_PACKAGE bool __fastcall TryGetCustomVarTypeName(System::Word AType, /* out */ System::WideString &S);
}	/* namespace Lmdsctclass */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTCLASS)
using namespace Lmdsctclass;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctclassHPP
