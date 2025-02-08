// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDTD.pas' rev: 31.00 (Windows)

#ifndef LmddtdHPP
#define LmddtdHPP

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
#include <LMDEntryPoint.hpp>
#include <LMDDeductionTree.hpp>
#include <LMDRule.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddtd
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDTD;
class DELPHICLASS TLMDDTDDefinition;
class DELPHICLASS TLMDDataModeBase;
class DELPHICLASS TLMDDataModelEntry;
class DELPHICLASS TLMDDataModelOperation;
class DELPHICLASS TLMDDataModel;
class DELPHICLASS TLMDDTDBaseDefinition;
class DELPHICLASS TLMDDTDTypeDefiniton;
class DELPHICLASS TLMDDTDEntityDefiniton;
class DELPHICLASS TLMDDTDElementDefiniton;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDTD : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdextparser::TLMDExtParser* FParser;
	TLMDDTDDefinition* FDefinition;
	Lmdlistobjects::TLMDListObjects* FEntryTable;
	Lmddeductiontree::TLMDDeductionTree* FDeductionTree;
	Lmdrule::TLMDRule* __fastcall BuildRule(TLMDDataModel* aDataModel);
	System::Classes::TList* __fastcall BuildExclusion(System::Classes::TStringList* aExclusion);
	Lmdentrypoint::TLMDEntryPoint* __fastcall FindEntry(const System::UnicodeString aName);
	void __fastcall ClearEntryTable(void);
	void __fastcall BuildEntryTable(void);
	
public:
	__fastcall TLMDDTD(Lmdextparser::TLMDExtParser* aParser);
	__fastcall virtual ~TLMDDTD(void);
	bool __fastcall Check(const System::UnicodeString aRule, Lmdtext::TLMDParsedTextList* &aParsedText);
	__property TLMDDTDDefinition* Definition = {read=FDefinition};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDTDDefinition : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDDTDBaseDefinition* operator[](int index) { return this->Item[index]; }
	
private:
	System::Classes::TList* FList;
	TLMDDTDBaseDefinition* __fastcall GetItem(int index);
	
public:
	__fastcall TLMDDTDDefinition(void);
	__fastcall virtual ~TLMDDTDDefinition(void);
	void __fastcall Clear(void);
	int __fastcall Count(void);
	void __fastcall DTD_TYPE(const System::UnicodeString aName, Lmdextparser::TLMDParseFunc aTypeFunc, Lmdextparser::TLMDParseAction aAction);
	void __fastcall DTD_ENTITY(const System::UnicodeString aName, TLMDDataModel* aDataModel);
	void __fastcall DTD_ELEMENT(const System::UnicodeString aName, bool aOpenTag, bool aCloseTag, System::Classes::TStringList* aCloseTags, TLMDDataModel* aDataModel, System::Classes::TStringList* aExclusion, Lmdextparser::TLMDParseAction aAction, Lmdextparser::TLMDParseAction aExceptionHandler)/* overload */;
	void __fastcall DTD_ELEMENT(const System::UnicodeString aName, bool aOpenTag, bool aCloseTag, System::Classes::TStringList* aCloseTags, TLMDDataModel* aDataModel, const System::UnicodeString aExclusion, Lmdextparser::TLMDParseAction aAction, Lmdextparser::TLMDParseAction aExceptionHandler)/* overload */;
	__property TLMDDTDBaseDefinition* Item[int index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDDataModelElement : unsigned char { deENTRY, deDataModel, deOperation };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDataModeBase : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDDataModelElement FType;
	Lmdrule::TLMDIteratorType FIterator;
	
public:
	__property TLMDDataModelElement ElementType = {read=FType, nodefault};
	__property Lmdrule::TLMDIteratorType Iterator = {read=FIterator, write=FIterator, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDDataModeBase(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDataModeBase(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDataModelEntry : public TLMDDataModeBase
{
	typedef TLMDDataModeBase inherited;
	
private:
	System::UnicodeString FName;
	
public:
	__fastcall TLMDDataModelEntry(const System::UnicodeString aName, Lmdrule::TLMDIteratorType aIterator);
	__property System::UnicodeString Name = {read=FName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDataModelEntry(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDataModelOperation : public TLMDDataModeBase
{
	typedef TLMDDataModeBase inherited;
	
public:
	__fastcall TLMDDataModelOperation(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDataModelOperation(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDataModel : public TLMDDataModeBase
{
	typedef TLMDDataModeBase inherited;
	
public:
	TLMDDataModeBase* operator[](int index) { return this->Item[index]; }
	
private:
	System::Classes::TList* FList;
	TLMDDataModeBase* __fastcall GetItem(int index);
	void __fastcall Clear(void);
	
public:
	__fastcall TLMDDataModel(void);
	__fastcall virtual ~TLMDDataModel(void);
	int __fastcall Count(void);
	void __fastcall Add(const System::UnicodeString aEntry, Lmdrule::TLMDIteratorType aIterator)/* overload */;
	void __fastcall Add(TLMDDataModel* aEntry)/* overload */;
	void __fastcall Add_OR(void);
	__property TLMDDataModeBase* Item[int index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDDefinitionType : unsigned char { dtTYPE, dtENTITY, dtELEMENT };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDTDBaseDefinition : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDDefinitionType FType;
	System::UnicodeString FName;
	
public:
	__property TLMDDefinitionType DefinitionType = {read=FType, nodefault};
	__property System::UnicodeString Name = {read=FName};
public:
	/* TObject.Create */ inline __fastcall TLMDDTDBaseDefinition(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDTDBaseDefinition(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDDTDTypeDefiniton : public TLMDDTDBaseDefinition
{
	typedef TLMDDTDBaseDefinition inherited;
	
private:
	Lmdextparser::TLMDParseAction FAction;
	Lmdextparser::TLMDParseFunc FTypeFunc;
	
public:
	__fastcall TLMDDTDTypeDefiniton(const System::UnicodeString aName, Lmdextparser::TLMDParseFunc aTypeFunc, Lmdextparser::TLMDParseAction aAction);
	__property Lmdextparser::TLMDParseAction Action = {read=FAction};
	__property Lmdextparser::TLMDParseFunc TypeFunc = {read=FTypeFunc};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDDTDTypeDefiniton(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDTDEntityDefiniton : public TLMDDTDBaseDefinition
{
	typedef TLMDDTDBaseDefinition inherited;
	
private:
	TLMDDataModel* FDataModel;
	
public:
	__fastcall TLMDDTDEntityDefiniton(const System::UnicodeString aName, TLMDDataModel* aDataModel);
	__fastcall virtual ~TLMDDTDEntityDefiniton(void);
	__property TLMDDataModel* DataModel = {read=FDataModel};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDDTDElementDefiniton : public TLMDDTDBaseDefinition
{
	typedef TLMDDTDBaseDefinition inherited;
	
private:
	bool FOpenTag;
	bool FCloseTag;
	TLMDDataModel* FDataModel;
	System::Classes::TStringList* FExclusion;
	Lmdextparser::TLMDParseAction FAction;
	Lmdextparser::TLMDParseAction FExceptionHandler;
	System::Classes::TStringList* FCloseTags;
	
public:
	__fastcall TLMDDTDElementDefiniton(const System::UnicodeString aName, bool aOpenTag, bool aCloseTag, System::Classes::TStringList* aCloseTags, TLMDDataModel* aDataModel, System::Classes::TStringList* aExclusion, Lmdextparser::TLMDParseAction aAction, Lmdextparser::TLMDParseAction aExceptionHandler);
	__fastcall virtual ~TLMDDTDElementDefiniton(void);
	__property bool OpenTag = {read=FOpenTag, nodefault};
	__property bool CloseTag = {read=FCloseTag, nodefault};
	__property TLMDDataModel* DataModel = {read=FDataModel};
	__property System::Classes::TStringList* Exclusion = {read=FExclusion};
	__property Lmdextparser::TLMDParseAction Action = {read=FAction};
	__property Lmdextparser::TLMDParseAction ExceptionHandler = {read=FExceptionHandler};
	__property System::Classes::TStringList* CloseTags = {read=FCloseTags};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddtd */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDTD)
using namespace Lmddtd;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddtdHPP
