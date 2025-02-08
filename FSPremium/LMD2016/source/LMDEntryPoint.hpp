// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDEntryPoint.pas' rev: 31.00 (Windows)

#ifndef LmdentrypointHPP
#define LmdentrypointHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDListObjects.hpp>
#include <LMDExtParser.hpp>
#include <LMDText.hpp>
#include <LMDRule.hpp>
#include <LMDDeductionTree.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdentrypoint
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDEntryPoint;
class DELPHICLASS TLMDTypeEntry;
class DELPHICLASS TLMDEntityEntry;
class DELPHICLASS TLMDElementEntry;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDEntryPoint : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::UnicodeString FName;
	Lmdextparser::TLMDExtParser* FParser;
	int FLockRef;
	Lmdlistobjects::TLMDListObjects* FTable;
	Lmdextparser::TLMDParseAction FAction;
	Lmdextparser::TLMDParseAction FExceptionHandler;
	bool __fastcall GetLocked(void);
	bool __fastcall ValidTag(void);
	
protected:
	void __fastcall Lock(void);
	void __fastcall UnLock(void);
	void __fastcall DoAction(Lmddeductiontree::TLMDDeductionTree* aTree, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall Exception(Lmddeductiontree::TLMDDeductionTree* aTree, Lmdextparser::TLMDEntryStage aStage);
	void __fastcall PrevToken(Lmddeductiontree::TLMDDeductionTree* aNode);
	void __fastcall NextToken(Lmddeductiontree::TLMDDeductionTree* aNode);
	__property bool Locked = {read=GetLocked, nodefault};
	
public:
	__fastcall TLMDEntryPoint(const System::UnicodeString aName, Lmdextparser::TLMDExtParser* aParser, Lmdlistobjects::TLMDListObjects* aTable, Lmdextparser::TLMDParseAction aAction, Lmdextparser::TLMDParseAction aExceptionHandler);
	virtual bool __fastcall IsTrue(Lmddeductiontree::TLMDDeductionTree* aTree) = 0 ;
	virtual void __fastcall RollBack(Lmddeductiontree::TLMDDeductionTree* aTree) = 0 ;
	void __fastcall GetFirstToken(Lmddeductiontree::TLMDDeductionTree* aNode);
	__property System::UnicodeString Name = {read=FName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDEntryPoint(void) { }
	
};


class PASCALIMPLEMENTATION TLMDTypeEntry : public TLMDEntryPoint
{
	typedef TLMDEntryPoint inherited;
	
private:
	Lmdextparser::TLMDParseFunc FTypeFunc;
	
public:
	__fastcall TLMDTypeEntry(const System::UnicodeString aName, Lmdextparser::TLMDParseFunc aTypeFunc, Lmdextparser::TLMDParseAction aAction, Lmdextparser::TLMDExtParser* aParser, Lmdlistobjects::TLMDListObjects* aTable);
	virtual bool __fastcall IsTrue(Lmddeductiontree::TLMDDeductionTree* aTree);
	virtual void __fastcall RollBack(Lmddeductiontree::TLMDDeductionTree* aTree);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDTypeEntry(void) { }
	
};


class PASCALIMPLEMENTATION TLMDEntityEntry : public TLMDEntryPoint
{
	typedef TLMDEntryPoint inherited;
	
private:
	Lmdrule::TLMDRule* FRule;
	bool FOwnedRule;
	
public:
	__fastcall TLMDEntityEntry(const System::UnicodeString aName, Lmdextparser::TLMDExtParser* aParser, Lmdlistobjects::TLMDListObjects* aTable);
	__fastcall virtual ~TLMDEntityEntry(void);
	virtual bool __fastcall IsTrue(Lmddeductiontree::TLMDDeductionTree* aTree);
	virtual void __fastcall RollBack(Lmddeductiontree::TLMDDeductionTree* aTree);
	void __fastcall SetRule(Lmdrule::TLMDRule* Rule, bool Owned);
	__property Lmdrule::TLMDRule* Rule = {read=FRule};
};


class PASCALIMPLEMENTATION TLMDElementEntry : public TLMDEntryPoint
{
	typedef TLMDEntryPoint inherited;
	
private:
	Lmdrule::TLMDRule* FRule;
	bool FOwnedRule;
	bool FTagOpen;
	bool FTagClose;
	System::Classes::TStringList* FCloseTags;
	System::Classes::TList* FExclusion;
	bool __fastcall IsCloseTag(void);
	bool __fastcall CheckDataModel(Lmddeductiontree::TLMDDeductionTree* aTree);
	void __fastcall LockExclusion(void);
	void __fastcall UnLockExclusion(void);
	
public:
	__fastcall TLMDElementEntry(const System::UnicodeString aName, bool aTagOpen, bool aTagClose, System::Classes::TStringList* aCloseTags, Lmdextparser::TLMDParseAction aAction, Lmdextparser::TLMDExtParser* aParser, Lmdextparser::TLMDParseAction aExceptionHandler, Lmdlistobjects::TLMDListObjects* aTable);
	__fastcall virtual ~TLMDElementEntry(void);
	virtual bool __fastcall IsTrue(Lmddeductiontree::TLMDDeductionTree* aTree);
	virtual void __fastcall RollBack(Lmddeductiontree::TLMDDeductionTree* aTree);
	void __fastcall SetRule(Lmdrule::TLMDRule* Rule, bool Owned);
	__property System::Classes::TList* Exclusion = {read=FExclusion, write=FExclusion};
	__property Lmdrule::TLMDRule* Rule = {read=FRule};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdentrypoint */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDENTRYPOINT)
using namespace Lmdentrypoint;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdentrypointHPP
