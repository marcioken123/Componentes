// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRule.pas' rev: 31.00 (Windows)

#ifndef LmdruleHPP
#define LmdruleHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDDeductionTree.hpp>
#include <LMDExtParser.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrule
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseRule;
class DELPHICLASS TLMDAtomRule;
class DELPHICLASS TLMDRule;
class DELPHICLASS TLMDRuleList;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDIteratorType : unsigned char { iONCE, iONE, iZero_or_One, iZero_or_More, iOne_or_More };

enum DECLSPEC_DENUM TLMDRuleType : unsigned char { rtATOM, rtRULE };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBaseRule : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FName;
	TLMDRuleType FType;
	TLMDIteratorType FIterator;
	bool __fastcall Iterator_ONCE(Lmddeductiontree::TLMDDeductionTree* aNode);
	bool __fastcall Iterator_ONE(Lmddeductiontree::TLMDDeductionTree* aNode);
	bool __fastcall Iterator_ZERO_OR_ONE(Lmddeductiontree::TLMDDeductionTree* aNode);
	bool __fastcall Iterator_ZERO_OR_MORE(Lmddeductiontree::TLMDDeductionTree* aNode);
	bool __fastcall Iterator_ONE_OR_MORE(Lmddeductiontree::TLMDDeductionTree* aNode);
	
protected:
	virtual bool __fastcall CheckOnce(Lmddeductiontree::TLMDDeductionTree* aNode) = 0 ;
	
public:
	bool __fastcall Check(Lmddeductiontree::TLMDDeductionTree* aNode);
	__property TLMDRuleType RuleType = {read=FType, nodefault};
	__property TLMDIteratorType Iterator = {read=FIterator, write=FIterator, nodefault};
	__property System::UnicodeString Name = {read=FName, write=FName};
public:
	/* TObject.Create */ inline __fastcall TLMDBaseRule(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBaseRule(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDAtomRule : public TLMDBaseRule
{
	typedef TLMDBaseRule inherited;
	
private:
	void *FEntry;
	
protected:
	virtual bool __fastcall CheckOnce(Lmddeductiontree::TLMDDeductionTree* aNode);
	
public:
	__fastcall TLMDAtomRule(void * aEntry, TLMDIteratorType aIterator);
	__property void * EntryPoint = {read=FEntry};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDAtomRule(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRule : public TLMDBaseRule
{
	typedef TLMDBaseRule inherited;
	
public:
	TLMDRuleList* operator[](int index) { return this->Item[index]; }
	
private:
	System::Classes::TList* FList;
	void __fastcall Clear(void);
	TLMDRuleList* __fastcall GetItem(int index);
	bool __fastcall CheckCNF(int Index, Lmddeductiontree::TLMDDeductionTree* aNode);
	
protected:
	virtual bool __fastcall CheckOnce(Lmddeductiontree::TLMDDeductionTree* aNode);
	
public:
	__fastcall TLMDRule(void);
	__fastcall virtual ~TLMDRule(void);
	int __fastcall Count(void);
	void __fastcall Add(System::TObject* aEntry, TLMDIteratorType aIterator)/* overload */;
	void __fastcall Add(TLMDRule* aRule)/* overload */;
	void __fastcall Add_OR(void);
	__property TLMDRuleList* Item[int index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRuleList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDBaseRule* operator[](int index) { return this->Item[index]; }
	
private:
	System::Classes::TList* FList;
	TLMDBaseRule* __fastcall GetItem(int index);
	void __fastcall Clear(void);
	
public:
	__fastcall TLMDRuleList(void);
	__fastcall virtual ~TLMDRuleList(void);
	int __fastcall Count(void);
	void __fastcall Add(TLMDBaseRule* aItem);
	__property TLMDBaseRule* Item[int index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrule */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRULE)
using namespace Lmdrule;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdruleHPP
