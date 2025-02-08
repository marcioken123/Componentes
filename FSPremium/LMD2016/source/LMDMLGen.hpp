// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMlGen.pas' rev: 31.00 (Windows)

#ifndef LmdmlgenHPP
#define LmdmlgenHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmlgen
{
//-- forward type declarations -----------------------------------------------
struct TLMDMlStringsRec;
class DELPHICLASS TLMDMLGenSession;
class DELPHICLASS TLMDStringParameters;
class DELPHICLASS TLMDTranslationTables;
class DELPHICLASS TLMDTranslationTable;
class DELPHICLASS TLMDBaseMLGen;
class DELPHICLASS TLMDCustomMLGen;
class DELPHICLASS TLMDMLGen;
class DELPHICLASS ELMDMlGenException;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TLMDMlStringsRec
{
public:
	System::UnicodeString ValueName;
	System::UnicodeString Value;
	System::TObject* UserObject;
};


typedef System::DynamicArray<TLMDMlStringsRec> TLMDMlArrayOfStringsRec;

typedef void __fastcall (__closure *TLMDMlPageEvent)(System::TObject* Sender, int PageNumb);

typedef void __fastcall (__closure *TLMDMlIfFoundEvent)(System::TObject* Sender, System::UnicodeString IfName, TLMDStringParameters* TagParameters, bool &ResultValue);

typedef void __fastcall (__closure *TLMDMlLoopIterateEvent)(System::TObject* Sender, int LoopNumb, System::UnicodeString LoopName, TLMDStringParameters* TagParameters, bool &LoopDone);

typedef void __fastcall (__closure *TLMDMlMacroFoundEvent)(System::TObject* Sender, System::UnicodeString MacroName, TLMDStringParameters* TagParameters, System::UnicodeString &MacroResult, bool &UseTranslationTable);

typedef void __fastcall (__closure *TLMDMlCodeFoundEvent)(System::TObject* Sender, System::UnicodeString CodeName, TLMDStringParameters* TagParameters, bool ClosedTag, System::Classes::TStringList* Code, System::UnicodeString &CodeResult, bool &UseTranslationTable);

typedef void __fastcall (__closure *TLMDMlWriteStringEvent)(System::TObject* Sender, System::UnicodeString Value);

typedef void __fastcall (__closure *TLMDMlTagFoundEvent)(System::TObject* Sender, System::UnicodeString Tag, const bool TagClosed, TLMDStringParameters* TagParameters);

typedef void __fastcall (__closure *TLMDMlIsTagEvent)(System::TObject* Sender, System::UnicodeString TagName, bool &IsTag);

typedef void __fastcall (__closure *TLMDMlIsTagValidEvent)(System::TObject* Sender, System::UnicodeString aName, TLMDStringParameters* TagParameters, bool &Result);

typedef void __fastcall (__closure *TLMDMLTemplateNeededEvent)(System::TObject* Sender, System::UnicodeString TemplateName, TLMDStringParameters* TagParameters, System::UnicodeString &Result);

typedef void __fastcall (__closure *TLMDMlObjectNotifyEvent)(System::TObject* Sender, System::TObject* Value);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMLGenSession : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
	
private:
	typedef System::DynamicArray<System::UnicodeString> _TLMDMLGenSession__1;
	
	typedef System::DynamicArray<int> _TLMDMLGenSession__2;
	
	typedef System::DynamicArray<int> _TLMDMLGenSession__3;
	
	typedef System::DynamicArray<int> _TLMDMLGenSession__4;
	
	typedef System::DynamicArray<int> _TLMDMLGenSession__5;
	
	typedef System::DynamicArray<int> _TLMDMLGenSession__6;
	
	typedef System::DynamicArray<System::UnicodeString> _TLMDMLGenSession__7;
	
	typedef System::DynamicArray<System::UnicodeString> _TLMDMLGenSession__8;
	
	typedef System::DynamicArray<int> _TLMDMLGenSession__9;
	
	
private:
	System::UnicodeString FBlockName;
	TLMDStringParameters* FBlocks;
	TLMDMLGenSession* FChildSession;
	System::UnicodeString FCommentName;
	System::UnicodeString FCodeName;
	int FCodeBegin;
	TLMDStringParameters* FCodeParams;
	_TLMDMLGenSession__1 FIfNames;
	_TLMDMLGenSession__2 FLoopBeginPos;
	_TLMDMLGenSession__3 FLoopBeginPosRzrv;
	System::UnicodeString FLoopBreak;
	_TLMDMLGenSession__4 FLoopCounters;
	_TLMDMLGenSession__5 FLoopCountersCurrentPage;
	_TLMDMLGenSession__6 FLoopCountersRzrv;
	_TLMDMLGenSession__7 FLoopNames;
	_TLMDMLGenSession__8 FLoopNamesRzrv;
	_TLMDMLGenSession__9 FLoopParamsBeginPos;
	System::UnicodeString FName;
	TLMDBaseMLGen* FOwner;
	TLMDMLGenSession* FParentSession;
	bool FSessionExecuting;
	int FSkipIfsDownToIndex;
	System::UnicodeString FSource;
	int FSrcPos;
	TLMDStringParameters* FTagParameters;
	System::Classes::TStrings* FTemplate;
	void __fastcall CheckEndPos(void);
	bool __fastcall DoBlockBegin(void);
	bool __fastcall DoBlockEnd(void);
	bool __fastcall DoCodeBegin(bool APreparePass = false);
	void __fastcall DoCodeEnd(bool APreparePass = false);
	bool __fastcall DoCommentBegin(void);
	bool __fastcall DoCommentEnd(void);
	bool __fastcall DoIfDone(void);
	bool __fastcall DoIfElse(const bool LastResult);
	bool __fastcall DoIfFound(bool CallUserEvent);
	bool __fastcall DoIsTag(const System::UnicodeString TagName);
	System::UnicodeString __fastcall DoMacroFound(void);
	bool __fastcall DoParamBegin(System::UnicodeString &ParamName, int &ParamNumb);
	void __fastcall DoParamEnd(void);
	bool __fastcall DoParamsBegin(void);
	void __fastcall DoParamsEnd(void);
	void __fastcall DoProcess(void);
	void __fastcall DoRepeatBegin(void);
	void __fastcall DoRepeatDone(void);
	bool __fastcall DoRepeatSkipDone(void);
	bool __fastcall DoReplaceBegin(System::UnicodeString &ParamName, int &ParamNumb);
	void __fastcall DoReplaceEnd(void);
	void __fastcall DoTagFound(System::UnicodeString TagName);
	void __fastcall DoTranslationBegin(System::UnicodeString &TableName);
	void __fastcall DoTranslationEnd(System::UnicodeString &TableName);
	void __fastcall DoWriteInterval(const System::UnicodeString AInterval);
	void __fastcall FreeArrays(void);
	void __fastcall FreeRzrvArrays(void);
	void __fastcall GetTagProp(bool &ClosedTag, TLMDStringParameters* TagOptions);
	void __fastcall PrepareTemplate(void);
	void __fastcall SetTemplate(System::Classes::TStrings* Value);
	void __fastcall StartSession(const System::UnicodeString TemplateName, const System::UnicodeString BlockName, const System::UnicodeString TemplateText);
	void __fastcall TemplateChanged(System::TObject* Sender);
	
protected:
	int __fastcall GetLoopIndex(const System::UnicodeString LoopName);
	
public:
	__fastcall TLMDMLGenSession(TLMDBaseMLGen* aOwner, TLMDMLGenSession* aParentSession, const System::UnicodeString aName);
	__fastcall virtual ~TLMDMLGenSession(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Execute(void);
	virtual void __fastcall ExecuteEx(System::UnicodeString BlockName);
	__property TLMDMLGenSession* ChildSession = {read=FChildSession};
	__property System::UnicodeString Name = {read=FName};
	__property TLMDBaseMLGen* Owner = {read=FOwner};
	__property TLMDMLGenSession* ParentSession = {read=FParentSession};
	__property System::Classes::TStrings* Template = {read=FTemplate, write=SetTemplate};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDStringParameters : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TLMDMlArrayOfStringsRec FData;
	TLMDMlObjectNotifyEvent FOnObjectRemove;
	void __fastcall BeforeDataClear(void);
	System::TObject* __fastcall GetanObject(int Index);
	System::TObject* __fastcall GetanObjectByName(System::UnicodeString ValueName);
	int __fastcall GetCount(void);
	System::UnicodeString __fastcall GetValue(int Index);
	System::UnicodeString __fastcall GetValueByName(System::UnicodeString ValueName);
	System::UnicodeString __fastcall GetValueName(int Index);
	void __fastcall SetanObject(int Index, System::TObject* const Value);
	void __fastcall SetanObjectByName(System::UnicodeString ValueName, System::TObject* const Value);
	void __fastcall SetValue(int Index, const System::UnicodeString Value);
	void __fastcall SetValueByName(System::UnicodeString ValueName, const System::UnicodeString Value);
	void __fastcall SetValueName(int Index, const System::UnicodeString Value);
	
public:
	__fastcall TLMDStringParameters(void);
	__fastcall virtual ~TLMDStringParameters(void);
	int __fastcall AddValue(const System::UnicodeString aValueName, const System::UnicodeString aValue, System::TObject* anObject1);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	void __fastcall Clear(void);
	int __fastcall FindItemByName(System::UnicodeString ValueName);
	void __fastcall GetNames(System::Classes::TStrings* Strings);
	System::UnicodeString __fastcall GetValueByNameEx(System::UnicodeString ValueName, System::UnicodeString DefaultValue);
	void __fastcall RemoveValue(const int Index);
	void __fastcall RemoveValueByName(const System::UnicodeString aValueName);
	void __fastcall ReplaceValue(int Index, const System::UnicodeString aValue);
	int __fastcall ReplaceValueByName(const System::UnicodeString aValueName, const System::UnicodeString aValue);
	__property System::TObject* UserObject[int Index] = {read=GetanObject, write=SetanObject};
	__property System::TObject* anObjectByName[System::UnicodeString ValueName] = {read=GetanObjectByName, write=SetanObjectByName};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDMlArrayOfStringsRec Data = {read=FData};
	__property TLMDMlObjectNotifyEvent OnObjectRemove = {read=FOnObjectRemove, write=FOnObjectRemove};
	__property System::UnicodeString Value[int Index] = {read=GetValue, write=SetValue};
	__property System::UnicodeString ValueByName[System::UnicodeString ValueName] = {read=GetValueByName, write=SetValueByName};
	__property System::UnicodeString ValueName[int Index] = {read=GetValueName, write=SetValueName};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTranslationTables : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDTranslationTable* operator[](int Index) { return this->Items[Index]; }
	
private:
	int FDefaultForMacro;
	int FDefaultForTemplate;
	int FDefaultForCode;
	TLMDTranslationTable* __fastcall GetItems(int Index);
	void __fastcall SetDefaultForMacro(int Value);
	void __fastcall SetDefaultForTemplate(int Value);
	void __fastcall SetItems(int Index, TLMDTranslationTable* Value);
	void __fastcall SetDefaultForCode(const int Value);
	
public:
	__fastcall TLMDTranslationTables(void);
	HIDESBASE TLMDTranslationTable* __fastcall Add(const System::UnicodeString TableName);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	HIDESBASE void __fastcall Clear(void);
	int __fastcall FindTableByName(const System::UnicodeString TableName);
	void __fastcall GetTableNames(System::Classes::TStrings* Strings);
	__property int DefaultForCode = {read=FDefaultForCode, write=SetDefaultForCode, nodefault};
	__property int DefaultForMacro = {read=FDefaultForMacro, write=SetDefaultForMacro, nodefault};
	__property int DefaultForTemplate = {read=FDefaultForTemplate, write=SetDefaultForTemplate, nodefault};
	__property TLMDTranslationTable* Items[int Index] = {read=GetItems, write=SetItems/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDTranslationTables(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTranslationTable : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FName;
	TLMDStringParameters* FTable;
	
public:
	__fastcall virtual TLMDTranslationTable(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDTranslationTable(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::UnicodeString __fastcall Translate(System::UnicodeString Source);
	__property System::UnicodeString Name = {read=FName, write=FName};
	__property TLMDStringParameters* Table = {read=FTable};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDBaseMLGen : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FCancelJob;
	System::Classes::TStrings* FCode;
	TLMDMLGenSession* FCurrentSession;
	System::Classes::TStrings* FCustomTagNames;
	bool FEnteringInNextPage;
	bool FExecuting;
	bool FNewPageProcessing;
	int FPageCount;
	TLMDStringParameters* FParameters;
	TLMDMLGenSession* FRootSession;
	bool FSyntaxCheck;
	System::UnicodeString FTagPrefix;
	TLMDTranslationTable* FTranslationTable;
	TLMDTranslationTables* FTranslationTables;
	void __fastcall DoNextPage(void);
	TLMDStringParameters* __fastcall GetBlocks(void);
	int __fastcall GetLoopCount(void);
	int __fastcall GetLoopCounter(int Index);
	int __fastcall GetLoopCountersCurrentPage(int Index);
	int __fastcall GetLoopCountersCurrentPageStr(System::UnicodeString LoopName);
	int __fastcall GetLoopCounterStr(System::UnicodeString LoopName);
	System::UnicodeString __fastcall GetLoopName(int Index);
	System::Classes::TStrings* __fastcall GetTemplate(void);
	void __fastcall SetCustomTagNames(System::Classes::TStrings* Value);
	void __fastcall SetTagPrefix(const System::UnicodeString Value);
	void __fastcall SetTemplate(System::Classes::TStrings* Value);
	
protected:
	virtual void __fastcall AfterExecute(void) = 0 ;
	virtual void __fastcall BeforeExecute(void) = 0 ;
	virtual void __fastcall IfFound(System::UnicodeString IfName, TLMDStringParameters* TagParameters, bool &ResultValue) = 0 ;
	virtual void __fastcall IsIfValid(System::UnicodeString aName, TLMDStringParameters* TagParameters, bool &Result);
	virtual void __fastcall IsLoopValid(System::UnicodeString aName, TLMDStringParameters* TagParameters, bool &Result);
	virtual void __fastcall IsMacroValid(System::UnicodeString aName, TLMDStringParameters* TagParameters, bool &Result);
	virtual void __fastcall IsTag(System::UnicodeString TagName, bool &IsTag);
	virtual void __fastcall LoopIteration(int LoopNumb, System::UnicodeString LoopName, TLMDStringParameters* TagParameters, bool &LoopDone) = 0 ;
	virtual void __fastcall CodeFound(System::UnicodeString CodeName, TLMDStringParameters* TagParameters, bool ClosedTag, System::Classes::TStringList* Code, System::UnicodeString &CodeResult, bool &UseTranslationTable) = 0 ;
	virtual void __fastcall MacroFound(System::UnicodeString MacroName, TLMDStringParameters* TagParameters, System::UnicodeString &MacroResult, bool &UseTranslationTable) = 0 ;
	virtual void __fastcall PageBegin(int PageNumb) = 0 ;
	virtual void __fastcall PageEnd(int PageNumb) = 0 ;
	virtual void __fastcall ProcessMessages(void);
	virtual void __fastcall TagFound(System::UnicodeString Tag, const bool TagClosed, TLMDStringParameters* TagParameters);
	virtual void __fastcall TemplateNeeded(System::UnicodeString TemplateName, TLMDStringParameters* TagParameters, System::UnicodeString &Result);
	virtual void __fastcall WriteString(System::UnicodeString Value) = 0 ;
	__property TLMDMLGenSession* CurrentSession = {read=FCurrentSession};
	__property TLMDMLGenSession* RootSession = {read=FRootSession};
	
public:
	__fastcall virtual TLMDBaseMLGen(System::Classes::TComponent* AOwner);
	__fastcall TLMDBaseMLGen(TLMDBaseMLGen* AOwner);
	__fastcall virtual ~TLMDBaseMLGen(void);
	virtual void __fastcall Init(void);
	virtual void __fastcall Abort(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	virtual void __fastcall Execute(void);
	virtual void __fastcall ExecuteEx(System::UnicodeString BlockName);
	int __fastcall GetLoopIndex(const System::UnicodeString LoopName);
	void __fastcall LoopBreak(System::UnicodeString LoopName);
	void __fastcall LoopContinue(System::UnicodeString LoopName);
	void __fastcall NextPage(void);
	virtual void __fastcall SyntaxCheck(void);
	__property TLMDStringParameters* Blocks = {read=GetBlocks};
	__property System::Classes::TStrings* Code = {read=FCode};
	__property System::Classes::TStrings* CustomTagNames = {read=FCustomTagNames, write=SetCustomTagNames};
	__property bool Executing = {read=FExecuting, nodefault};
	__property int LoopCount = {read=GetLoopCount, nodefault};
	__property int LoopCounter[int Index] = {read=GetLoopCounter};
	__property int LoopCountersCurrentPage[int Index] = {read=GetLoopCountersCurrentPage};
	__property int LoopCountersCurrentPageStr[System::UnicodeString LoopName] = {read=GetLoopCountersCurrentPageStr};
	__property int LoopCounterStr[System::UnicodeString LoopName] = {read=GetLoopCounterStr};
	__property System::UnicodeString LoopName[int Index] = {read=GetLoopName};
	__property int PageCount = {read=FPageCount, nodefault};
	__property TLMDStringParameters* Parameters = {read=FParameters};
	__property System::UnicodeString TagPrefix = {read=FTagPrefix, write=SetTagPrefix};
	__property System::Classes::TStrings* Template = {read=GetTemplate, write=SetTemplate};
	__property TLMDTranslationTables* TranslationTables = {read=FTranslationTables};
};


class PASCALIMPLEMENTATION TLMDCustomMLGen : public TLMDBaseMLGen
{
	typedef TLMDBaseMLGen inherited;
	
private:
	System::Classes::TNotifyEvent FOnAfterExecute;
	System::Classes::TNotifyEvent FOnBeforeExecute;
	TLMDMlIfFoundEvent FOnIfFound;
	TLMDMlIsTagValidEvent FOnIsIfValid;
	TLMDMlIsTagValidEvent FOnIsLoopValid;
	TLMDMlIsTagValidEvent FOnIsMacroValid;
	TLMDMlIsTagEvent FOnIsTag;
	TLMDMlLoopIterateEvent FOnLoopIteration;
	TLMDMlCodeFoundEvent FOnCodeFound;
	TLMDMlMacroFoundEvent FOnMacroFound;
	TLMDMlPageEvent FOnPageBegin;
	TLMDMlPageEvent FOnPageEnd;
	System::Classes::TNotifyEvent FOnProcessMessages;
	TLMDMlTagFoundEvent FOnTagFound;
	TLMDMLTemplateNeededEvent FOnTemplateNeeded;
	TLMDMlWriteStringEvent FOnWriteString;
	
protected:
	virtual void __fastcall AfterExecute(void);
	virtual void __fastcall BeforeExecute(void);
	virtual void __fastcall IfFound(System::UnicodeString IfName, TLMDStringParameters* TagParameters, bool &ResultValue);
	virtual void __fastcall IsIfValid(System::UnicodeString aName, TLMDStringParameters* TagParameters, bool &Result);
	virtual void __fastcall IsLoopValid(System::UnicodeString aName, TLMDStringParameters* TagParameters, bool &Result);
	virtual void __fastcall IsMacroValid(System::UnicodeString aName, TLMDStringParameters* TagParameters, bool &Result);
	virtual void __fastcall IsTag(System::UnicodeString TagName, bool &IsTag);
	virtual void __fastcall LoopIteration(int LoopNumb, System::UnicodeString LoopName, TLMDStringParameters* TagParameters, bool &LoopDone);
	virtual void __fastcall CodeFound(System::UnicodeString CodeName, TLMDStringParameters* TagParameters, bool ClosedTag, System::Classes::TStringList* Code, System::UnicodeString &CodeResult, bool &UseTranslationTable);
	virtual void __fastcall MacroFound(System::UnicodeString MacroName, TLMDStringParameters* TagParameters, System::UnicodeString &MacroResult, bool &UseTranslationTable);
	virtual void __fastcall PageBegin(int PageNumb);
	virtual void __fastcall PageEnd(int PageNumb);
	virtual void __fastcall ProcessMessages(void);
	virtual void __fastcall TagFound(System::UnicodeString Tag, const bool TagClosed, TLMDStringParameters* TagParameters);
	virtual void __fastcall TemplateNeeded(System::UnicodeString TemplateName, TLMDStringParameters* TagParameters, System::UnicodeString &Result);
	virtual void __fastcall WriteString(System::UnicodeString Value);
	__property System::Classes::TNotifyEvent OnAfterExecute = {read=FOnAfterExecute, write=FOnAfterExecute};
	__property System::Classes::TNotifyEvent OnBeforeExecute = {read=FOnBeforeExecute, write=FOnBeforeExecute};
	__property TLMDMlIfFoundEvent OnIfFound = {read=FOnIfFound, write=FOnIfFound};
	__property TLMDMlIsTagValidEvent OnIsIfValid = {read=FOnIsIfValid, write=FOnIsIfValid};
	__property TLMDMlIsTagValidEvent OnIsLoopValid = {read=FOnIsLoopValid, write=FOnIsLoopValid};
	__property TLMDMlIsTagValidEvent OnIsMacroValid = {read=FOnIsMacroValid, write=FOnIsMacroValid};
	__property TLMDMlIsTagEvent OnIsTag = {read=FOnIsTag, write=FOnIsTag};
	__property TLMDMlLoopIterateEvent OnLoopIteration = {read=FOnLoopIteration, write=FOnLoopIteration};
	__property TLMDMlCodeFoundEvent OnCodeFound = {read=FOnCodeFound, write=FOnCodeFound};
	__property TLMDMlMacroFoundEvent OnMacroFound = {read=FOnMacroFound, write=FOnMacroFound};
	__property TLMDMlPageEvent OnPageBegin = {read=FOnPageBegin, write=FOnPageBegin};
	__property TLMDMlPageEvent OnPageEnd = {read=FOnPageEnd, write=FOnPageEnd};
	__property System::Classes::TNotifyEvent OnProcessMessages = {read=FOnProcessMessages, write=FOnProcessMessages};
	__property TLMDMlTagFoundEvent OnTagFound = {read=FOnTagFound, write=FOnTagFound};
	__property TLMDMLTemplateNeededEvent OnTemplateNeeded = {read=FOnTemplateNeeded, write=FOnTemplateNeeded};
	__property TLMDMlWriteStringEvent OnWriteString = {read=FOnWriteString, write=FOnWriteString};
public:
	/* TLMDBaseMLGen.Create */ inline __fastcall virtual TLMDCustomMLGen(System::Classes::TComponent* AOwner) : TLMDBaseMLGen(AOwner) { }
	/* TLMDBaseMLGen.CreateFrom */ inline __fastcall TLMDCustomMLGen(TLMDBaseMLGen* AOwner) : TLMDBaseMLGen(AOwner) { }
	/* TLMDBaseMLGen.Destroy */ inline __fastcall virtual ~TLMDCustomMLGen(void) { }
	
};


class PASCALIMPLEMENTATION TLMDMLGen : public TLMDCustomMLGen
{
	typedef TLMDCustomMLGen inherited;
	
__published:
	__property About = {default=0};
	__property CustomTagNames;
	__property OnAfterExecute;
	__property OnBeforeExecute;
	__property OnIfFound;
	__property OnIsIfValid;
	__property OnIsLoopValid;
	__property OnIsMacroValid;
	__property OnIsTag;
	__property OnLoopIteration;
	__property OnCodeFound;
	__property OnMacroFound;
	__property OnPageBegin;
	__property OnPageEnd;
	__property OnProcessMessages;
	__property OnTagFound;
	__property OnTemplateNeeded;
	__property OnWriteString;
	__property TagPrefix = {default=0};
	__property Template;
public:
	/* TLMDBaseMLGen.Create */ inline __fastcall virtual TLMDMLGen(System::Classes::TComponent* AOwner) : TLMDCustomMLGen(AOwner) { }
	/* TLMDBaseMLGen.CreateFrom */ inline __fastcall TLMDMLGen(TLMDBaseMLGen* AOwner) : TLMDCustomMLGen(AOwner) { }
	/* TLMDBaseMLGen.Destroy */ inline __fastcall virtual ~TLMDMLGen(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDMlGenException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
private:
	TLMDBaseMLGen* FMlGen;
	
public:
	__fastcall ELMDMlGenException(TLMDBaseMLGen* MlGen, System::UnicodeString Msg);
	__property TLMDBaseMLGen* MlGen = {read=FMlGen};
public:
	/* Exception.CreateFmt */ inline __fastcall ELMDMlGenException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDMlGenException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDMlGenException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDMlGenException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDMlGenException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDMlGenException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDMlGenException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDMlGenException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDMlGenException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDMlGenException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDMlGenException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDMlGenException(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall CheckPath(System::UnicodeString InpPath, bool IsPath);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetWordEx(System::UnicodeString S, int &CharNumb, const System::Sysutils::TSysCharSet &Breaks);
extern DELPHI_PACKAGE int __fastcall GetPosOfNewString(const System::UnicodeString Value, int CurPos);
extern DELPHI_PACKAGE System::UnicodeString __fastcall SetStrWidth(System::UnicodeString Value, int Width);
extern DELPHI_PACKAGE void __fastcall GetTextLineByStringPos(const System::UnicodeString Value, int ValuePos, int &Line, int &CharPos);
extern DELPHI_PACKAGE int __fastcall PosEx(const System::UnicodeString substr, const System::UnicodeString s, int EndPos, int BegPos);
}	/* namespace Lmdmlgen */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMLGEN)
using namespace Lmdmlgen;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmlgenHPP
