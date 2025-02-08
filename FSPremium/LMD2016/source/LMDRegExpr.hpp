// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRegExpr.pas' rev: 34.00 (Windows)

#ifndef LmdregexprHPP
#define LmdregexprHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDFiles.hpp>
#include <LMDStrings.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicode.hpp>
#include <LMDArrayUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdregexpr
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRegexSource;
class DELPHICLASS TLMDRegexStringSource;
struct TLMDCharRange;
class DELPHICLASS TLMDCharSet;
class DELPHICLASS TLMDBoyerMooreSearch;
class DELPHICLASS TLMDRegexNode;
class DELPHICLASS TLMDRegExp;
class DELPHICLASS TLMDRegOptions;
struct TLMDRegExpHeader;
class DELPHICLASS TLMDRegExpr;
class DELPHICLASS ELMDRegExprError;
class DELPHICLASS ELMDCharSetError;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRegexSource : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	int operator[](int AIdx) { return this->Codes[AIdx]; }
	
protected:
	Lmdtypes::TLMDIntArray FBuffer;
	int FBufferSize;
	int FBoundGap;
	int FBufferStart;
	int FBufferEnd;
	int FIdxStart;
	int FIdxEnd;
	virtual void __fastcall FillBuffer() = 0 ;
	__fastcall TLMDRegexSource(int ABufSize, int AInitCount);
	
public:
	int Count;
	int BaseIndex;
	void __fastcall SetBuffer(Lmdtypes::TLMDIntArray ABuffer);
	virtual void __fastcall ResetBuffer();
	int __fastcall GetCode(int AIdx);
	__property int Codes[int AIdx] = {read=GetCode/*, default*/};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRegexSource() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRegexStringSource : public TLMDRegexSource
{
	typedef TLMDRegexSource inherited;
	
protected:
	Lmdtypes::TLMDString FStr;
	virtual void __fastcall FillBuffer();
	
public:
	__fastcall TLMDRegexStringSource(const Lmdtypes::TLMDString AStr);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRegexStringSource() { }
	
};

#pragma pack(pop)

typedef System::Set<System::Byte, 0, 255> TLMDSetOfByte;

struct DECLSPEC_DRECORD TLMDCharRange
{
public:
	int Min;
	int Max;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCharSet : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TLMDCharRange> _TLMDCharSet__1;
	
	
private:
	int FRangesCount;
	_TLMDCharSet__1 FRanges;
	bool FHaveRanges;
	bool FInverted;
	Lmdunicode::TLMDUnicodeCategories FCategories;
	bool FHaveCategories;
	void __fastcall CheckNotInverted();
	
public:
	TLMDSetOfByte AnsiSet;
	bool IsAnsiSet;
	__fastcall TLMDCharSet()/* overload */;
	__fastcall TLMDCharSet(int ACh)/* overload */;
	__fastcall TLMDCharSet(const Lmdtypes::TLMDString AStr)/* overload */;
	__fastcall TLMDCharSet(Lmdunicode::TLMDUnicodeCategory ACat)/* overload */;
	__fastcall TLMDCharSet(Lmdunicode::TLMDUnicodeCategories ACats)/* overload */;
	__fastcall TLMDCharSet(int AMin, int AMax)/* overload */;
	bool __fastcall Contains(int ACh)/* overload */;
	bool __fastcall Contains(System::WideChar ACh)/* overload */;
	bool __fastcall ContainsAll(const Lmdtypes::TLMDString AStr);
	void __fastcall IncludeChar(int ACh);
	void __fastcall IncludeChars(const Lmdtypes::TLMDString AStr);
	void __fastcall IncludeCat(Lmdunicode::TLMDUnicodeCategory ACat);
	void __fastcall IncludeCats(Lmdunicode::TLMDUnicodeCategories ACats);
	void __fastcall IncludeRange(int AMin, int AMax);
	void __fastcall Clear();
	void __fastcall Invert();
	void __fastcall Assign(TLMDCharSet* AOther);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCharSet() { }
	
};

#pragma pack(pop)

typedef int __fastcall (__closure *TLMDInvertCaseFunction)(const int ACh);

class PASCALIMPLEMENTATION TLMDBoyerMooreSearch : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdtypes::TLMDIntArray FPattern;
	Lmdtypes::TLMDIntArray FPatternInv;
	Lmdtypes::TLMDIntArray FSkip;
	Lmdtypes::TLMDIntArray FSuffix;
	bool FIgnoreCase;
	int FSkipTableSize;
	int FSkipHashMask;
	int FPatEnd;
	TLMDInvertCaseFunction FInvertCase;
	int __fastcall InvertCase(int ACh);
	int __fastcall GetSkipIndex(int ACh);
	
public:
	__fastcall TLMDBoyerMooreSearch(int ASkipTableSize, int ASkipHashMask, TLMDInvertCaseFunction AInvertCase);
	void __fastcall Prepare(const Lmdtypes::TLMDIntArray APattern, bool AIgnoreCase);
	int __fastcall Search(TLMDRegexSource* const AInput, int AOffset, int ACount = 0xffffffff);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBoyerMooreSearch() { }
	
};


typedef int __fastcall (__closure *TLMDIntCodeResolveFunction)(const Lmdtypes::TLMDString ACodeName);

typedef int TLMDREOp;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRegexNode : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDREOp Op;
	Lmdtypes::TLMDIntArray TinySet;
	Lmdtypes::TLMDIntArray ExactStr;
	Lmdtypes::TLMDIntArray ExactStrInvC;
	int ExactChar;
	int ExactCharInvC;
	int ExactVarId;
	TLMDCharSet* SetHash;
	int BackRef;
	int MinBrace;
	int MaxBrace;
	TLMDRegexNode* LoopTo;
	TLMDRegexNode* NextOp;
	TLMDRegexNode* PrevNode;
	TLMDRegexNode* NextNode;
	__fastcall TLMDRegexNode(TLMDREOp AOp);
	__fastcall virtual ~TLMDRegexNode();
};

#pragma pack(pop)

typedef Lmdtypes::TLMDString __fastcall (__closure *TLMDRegExprReplaceFunction)(TLMDRegExp* ARegExpr);

typedef void __fastcall (__closure *TLMDRegExprVariableGetter)(int AId, Lmdtypes::TLMDIntArray &ARes);

class PASCALIMPLEMENTATION TLMDRegExp : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	TLMDRegexSource* FInput;
	bool FOwnsInput;
	TLMDIntCodeResolveFunction FCodesResolver;
	TLMDRegExprVariableGetter FVarGetter;
	System::Classes::TList* FVariablesList;
	bool FVarsOptsOk;
	Lmdtypes::TLMDIntArray FStartp;
	Lmdtypes::TLMDIntArray FEndp;
	Lmdtypes::TLMDIntArray FLoopStack;
	int FLoopStackIdx;
	TLMDBoyerMooreSearch* FBMSearch;
	TLMDRegexNode* FRegStart;
	bool FRegAnch;
	TLMDRegexNode* FRegmustExact;
	TLMDSetOfByte FFirstCharSet;
	bool FFirstCharSetHasUnicode;
	int FReginput;
	int FSavedReginput;
	int FInputStart;
	int FInputEnd;
	bool FNeedMore;
	Lmdtypes::TLMDString FExpr;
	int FParse;
	int FParseEnd;
	int FSubexpCount;
	TLMDCharSet* FIgnoredChars;
	TLMDCharSet* FRangeSet;
	int FLastError;
	bool FExprIsCompiled;
	int FModifiers;
	int FCompModifiers;
	int FProgModifiers;
	int FCompiledFlags;
	Lmdtypes::TLMDString FSpaceChars;
	Lmdtypes::TLMDString FWordChars;
	Lmdtypes::TLMDString FWordSeparators;
	Lmdtypes::TLMDString FLineSeparators;
	TLMDCharSet* FWordCharsSet;
	TLMDCharSet* FWordSepsSet;
	TLMDCharSet* FLineSeparatorsSet;
	TLMDCharSet* FDigitsSet;
	TLMDCharSet* FHexDigCharSet;
	bool FLinePairedSeparatorAssigned;
	System::WideChar FLinePairedSeparatorHead;
	System::WideChar FLinePairedSeparatorTail;
	TLMDInvertCaseFunction FInvertCase;
	TLMDRegexNode* FProgrammFirst;
	TLMDRegexNode* FProgrammLast;
	void __fastcall SetSubExpCountLow(int ACount);
	void __fastcall SetInput(TLMDRegexSource* const AInput, bool AOwnIt);
	bool __fastcall CompModifier(int AMod);
	int __fastcall HexDig(System::WideChar ch);
	System::WideChar __fastcall UnQuoteChar(int &AIdx, const Lmdtypes::TLMDString AStr, int AStrEnd);
	bool __fastcall TryParseUnicodeCat(int &AIdx, Lmdunicode::TLMDUnicodeCategories &ACats, const Lmdtypes::TLMDString AStr);
	int __fastcall ParseIntCode(int &AIdx, const Lmdtypes::TLMDString AStr);
	int __fastcall InvertCase(int ACh);
	void __fastcall SetInvertCaseFn(TLMDInvertCaseFunction AInvertCase);
	void __fastcall InvalidateProgramm();
	bool __fastcall IsProgrammOk();
	Lmdtypes::TLMDString __fastcall GetExpression();
	void __fastcall SetExpression(const Lmdtypes::TLMDString s);
	Lmdtypes::TLMDString __fastcall GetModifierStr();
	bool __fastcall ParseModifiersStr(const Lmdtypes::TLMDString AStr, int AStart, int AEnd, int &AModifiersInt);
	void __fastcall SetModifierStr(const Lmdtypes::TLMDString AModifiers);
	bool __fastcall GetModifier(int AIndex);
	void __fastcall SetModifier(int AIndex, bool ASet);
	void __fastcall CheckInCodesMode(const Lmdtypes::TLMDString AConstruct);
	void __fastcall CheckNotInCodesMode(const Lmdtypes::TLMDString AConstruct);
	virtual void __fastcall Error(int AErrorID, int AErrPos = 0xffffffff);
	bool __fastcall CompileRegExpr();
	void __fastcall PrepareVarsOpts();
	void __fastcall Tail(TLMDRegexNode* ALinkTo, TLMDRegexNode* ANode);
	void __fastcall OpTail(TLMDRegexNode* ALinkTo, TLMDRegexNode* ANode);
	TLMDRegexNode* __fastcall EmitNode(TLMDREOp AOp);
	void __fastcall InsertOperator(TLMDREOp AOp, TLMDRegexNode* &AOpnd);
	int __fastcall ParseNumExpr(int AStart, int AEnd);
	TLMDRegexNode* __fastcall ParseReg(int AParenNo, int &AFlagp);
	TLMDRegexNode* __fastcall ParseBranch(int &AFlagp);
	TLMDRegexNode* __fastcall ParsePiece(int &AFlagp);
	TLMDRegexNode* __fastcall ParseAtom(int &AFlagp);
	void __fastcall AdvanceParse();
	int __fastcall NextParse();
	void __fastcall AdvanceParseEx(int &ParseIdx);
	int __fastcall NextParseEx(int ParseIdx);
	int __fastcall GetCompilerErrorPos();
	int __fastcall RegRepeat(TLMDRegexNode* ANode, int AMax);
	bool __fastcall MatchPrim(TLMDRegexNode* ANode);
	void __fastcall ClearMatches();
	bool __fastcall ExecPrim(int AOffset, int ACount);
	int __fastcall GetSubExprMatchCount();
	int __fastcall GetMatchPos(int Idx);
	int __fastcall GetMatchLen(int Idx);
	Lmdtypes::TLMDString __fastcall GetMatch(int Idx);
	void __fastcall SetWordChars(const Lmdtypes::TLMDString AStr);
	void __fastcall SetWordSeparators(const Lmdtypes::TLMDString AStr);
	void __fastcall SetSpaceChars(const Lmdtypes::TLMDString AStr);
	void __fastcall SetLineSeparators(const Lmdtypes::TLMDString AStr);
	void __fastcall SetLinePairedSeparator(const Lmdtypes::TLMDString AStr);
	Lmdtypes::TLMDString __fastcall GetLinePairedSeparator();
	void __fastcall AddWordSet(TLMDCharSet* ASet);
	void __fastcall AddWordSepsSet(TLMDCharSet* ASet);
	void __fastcall AddSpaceSet(TLMDCharSet* ASet);
	void __fastcall AddLineSepSet(TLMDCharSet* ASet);
	void __fastcall AddDigitsSet(TLMDCharSet* ASet);
	void __fastcall AddHexDigitsSet(TLMDCharSet* ASet);
	void __fastcall AddIgnoredCharSet(TLMDCharSet* ASet);
	void __fastcall CheckInputSourceIsString();
	Lmdtypes::TLMDString __fastcall GetInputText();
	void __fastcall SetInputText(const Lmdtypes::TLMDString AStr);
	TLMDRegexSource* __fastcall GetInputSource();
	void __fastcall SetInputSource(TLMDRegexSource* ASrc);
	
public:
	__fastcall TLMDRegExp();
	__fastcall virtual ~TLMDRegExp();
	int __fastcall CompiledSubExpCount();
	__classmethod int __fastcall SubExpMaxCount();
	__property Lmdtypes::TLMDString Expression = {read=GetExpression, write=SetExpression};
	__property Lmdtypes::TLMDString ModifierStr = {read=GetModifierStr, write=SetModifierStr};
	__property bool ModifierI = {read=GetModifier, write=SetModifier, index=1, nodefault};
	__property bool ModifierS = {read=GetModifier, write=SetModifier, index=3, nodefault};
	__property bool ModifierG = {read=GetModifier, write=SetModifier, index=4, nodefault};
	__property bool ModifierM = {read=GetModifier, write=SetModifier, index=5, nodefault};
	__property bool ModifierX = {read=GetModifier, write=SetModifier, index=6, nodefault};
	__property bool ModifierA = {read=GetModifier, write=SetModifier, index=7, nodefault};
	__property bool ModifierC = {read=GetModifier, write=SetModifier, index=8, nodefault};
	__property TLMDIntCodeResolveFunction CodesResolver = {read=FCodesResolver, write=FCodesResolver};
	__property TLMDRegExprVariableGetter VariablesGetter = {read=FVarGetter, write=FVarGetter};
	__property Lmdtypes::TLMDString InputText = {read=GetInputText, write=SetInputText};
	__property TLMDRegexSource* InputSource = {read=GetInputSource, write=SetInputSource};
	bool __fastcall Exec()/* overload */;
	bool __fastcall Exec(int AOffset)/* overload */;
	bool __fastcall Exec(int AOffset, int ACount)/* overload */;
	bool __fastcall Exec(int AOffset, int ACount, bool &ANeedMoreSource)/* overload */;
	bool __fastcall ExecNext()/* overload */;
	Lmdtypes::TLMDString __fastcall Substitute(const Lmdtypes::TLMDString ATemplate);
	void __fastcall Split(System::Classes::TStrings* APieces);
	Lmdtypes::TLMDString __fastcall Replace(const Lmdtypes::TLMDString AReplaceStr, bool AUseSubstitution = false);
	Lmdtypes::TLMDString __fastcall ReplaceEx(TLMDRegExprReplaceFunction AReplaceFunc);
	__property int MatchCount = {read=GetSubExprMatchCount, nodefault};
	__property int MatchPos[int Idx] = {read=GetMatchPos};
	__property int MatchLen[int Idx] = {read=GetMatchLen};
	__property Lmdtypes::TLMDString Match[int Idx] = {read=GetMatch};
	int __fastcall LastError();
	virtual Lmdtypes::TLMDString __fastcall ErrorMsg(int AErrorID);
	__property int CompilerErrorPos = {read=GetCompilerErrorPos, nodefault};
	__property Lmdtypes::TLMDString SpaceChars = {read=FSpaceChars, write=SetSpaceChars};
	__property Lmdtypes::TLMDString WordChars = {read=FWordChars, write=SetWordChars};
	__property Lmdtypes::TLMDString WordSeparators = {read=FWordSeparators, write=SetWordSeparators};
	__property Lmdtypes::TLMDString LineSeparators = {read=FLineSeparators, write=SetLineSeparators};
	__property Lmdtypes::TLMDString LinePairedSeparator = {read=GetLinePairedSeparator, write=SetLinePairedSeparator};
	__classmethod int __fastcall InvertCaseFunction(const int Ch);
	__property TLMDInvertCaseFunction InvertCaseFn = {read=FInvertCase, write=SetInvertCaseFn};
	void __fastcall Compile();
	Lmdtypes::TLMDString __fastcall Dump();
	TLMDSetOfByte __fastcall GetFirstCharSetAnsi(bool &HasUnicode);
	void __fastcall InvalidateVariables();
	bool __fastcall HasVariables();
	int __fastcall MaxVariableId();
	bool __fastcall GetVarByID(int AId, int &AStart, int &ACount);
};


typedef void * PPCRECalloutBlock;

typedef void __fastcall (__closure *TLMDCalloutEvent)(System::TObject* Sender, const void * Data);

class PASCALIMPLEMENTATION TLMDRegOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	int FFlags;
	System::Classes::TNotifyEvent FOnChange;
	bool __fastcall GetCaseLess();
	bool __fastcall GetExtended();
	bool __fastcall GetMultiLine();
	bool __fastcall GetSingleLine();
	bool __fastcall GetUngreedy();
	bool __fastcall GetUTF8();
	void __fastcall SetCaseLess(const bool Value);
	void __fastcall SetExtended(const bool Value);
	void __fastcall SetMultiLine(const bool Value);
	void __fastcall SetSingleLine(const bool Value);
	void __fastcall SetUngreedy(const bool Value);
	void __fastcall SetUTF8(const bool Value);
	void __fastcall TriggerChange();
	
protected:
	__property int Flags = {read=FFlags, nodefault};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall TLMDRegOptions();
	
__published:
	__property bool eroCaseLess = {read=GetCaseLess, write=SetCaseLess, default=1};
	__property bool eroSingleLine = {read=GetSingleLine, write=SetSingleLine, default=1};
	__property bool eroMultiLine = {read=GetMultiLine, write=SetMultiLine, default=0};
	__property bool eroExtendedMode = {read=GetExtended, write=SetExtended, default=1};
	__property bool eroUngreedyMode = {read=GetUngreedy, write=SetUngreedy, default=0};
	__property bool eroUTF8 = {read=GetUTF8, write=SetUTF8, default=0};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDRegOptions() { }
	
};


struct DECLSPEC_DRECORD TLMDRegExpHeader
{
public:
	int Id;
	int Flags;
};


class PASCALIMPLEMENTATION TLMDRegExpr : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
protected:
	TLMDRegExp* FRegExprEngine;
	TLMDRegOptions* FOptions;
	TLMDCalloutEvent FOnCalloutEvent;
	void __fastcall Compile();
	Lmdtypes::TLMDString __fastcall GetMatch(int i);
	int __fastcall GetMatchLen(int i);
	int __fastcall GetMatchPos(int i);
	int __fastcall GetNumMatches();
	Lmdtypes::TLMDRegExString __fastcall GetExpr();
	void __fastcall SetExpr(const Lmdtypes::TLMDRegExString Value);
	Lmdtypes::TLMDString __fastcall GetInputText();
	void __fastcall SetInputText(const Lmdtypes::TLMDString Value);
	void __fastcall DoChange(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDRegExpr(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDRegExpr();
	void __fastcall Study();
	void __fastcall SaveToStream(System::Classes::TStream* AStream);
	void __fastcall LoadFromStream(System::Classes::TStream* AStream);
	void __fastcall SaveToFile(Lmdtypes::TLMDString AFileName);
	void __fastcall LoadFromFile(Lmdtypes::TLMDString AFileName);
	bool __fastcall Exec()/* overload */;
	bool __fastcall Exec(const Lmdtypes::TLMDString AInputText)/* overload */;
	bool __fastcall ExecNext();
	bool __fastcall ExecPos(int AStartOffs);
	void __fastcall Split(Lmdtypes::TLMDString AInputText, System::Classes::TStrings* AResult)/* overload */;
	void __fastcall Split(System::Classes::TStrings* AResult)/* overload */;
	Lmdtypes::TLMDString __fastcall Substitute(const Lmdtypes::TLMDString ATemplate);
	Lmdtypes::TLMDString __fastcall Replace(const Lmdtypes::TLMDString AReplace, bool AUseTemplates)/* overload */;
	Lmdtypes::TLMDString __fastcall Replace(const Lmdtypes::TLMDString AInputText, const Lmdtypes::TLMDString AReplace, bool AUseTemplates)/* overload */;
	__property Lmdtypes::TLMDString Match[int i] = {read=GetMatch};
	__property int MatchPos[int i] = {read=GetMatchPos};
	__property int MatchLen[int i] = {read=GetMatchLen};
	__property int MatchCount = {read=GetNumMatches, nodefault};
	
__published:
	__property About = {default=0};
	__property TLMDRegOptions* Options = {read=FOptions};
	__property Lmdtypes::TLMDRegExString Expression = {read=GetExpr, write=SetExpr};
	__property Lmdtypes::TLMDString InputText = {read=GetInputText, write=SetInputText};
	__property TLMDCalloutEvent OnCallout = {read=FOnCalloutEvent, write=FOnCalloutEvent};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDRegExprError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	int ErrorCode;
	int CompilerErrorPos;
public:
	/* Exception.Create */ inline __fastcall ELMDRegExprError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDRegExprError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDRegExprError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDRegExprError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDRegExprError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDRegExprError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDRegExprError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDRegExprError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDRegExprError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDRegExprError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDRegExprError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDRegExprError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDRegExprError() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDCharSetError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDCharSetError(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDCharSetError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDCharSetError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDCharSetError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDCharSetError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDCharSetError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDCharSetError(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDCharSetError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDCharSetError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDCharSetError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDCharSetError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDCharSetError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDCharSetError() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDExecRegExpr(const Lmdtypes::TLMDString ARegExpr, const Lmdtypes::TLMDString AInputStr);
extern DELPHI_PACKAGE bool __fastcall LMDExecMatchesRegExpr(const Lmdtypes::TLMDString ARegExpr, const Lmdtypes::TLMDString AInputStr, System::Classes::TStrings* AMatches);
extern DELPHI_PACKAGE void __fastcall LMDSplitRegExpr(const Lmdtypes::TLMDString ARegExpr, const Lmdtypes::TLMDString AInputStr, System::Classes::TStrings* APieces);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDReplaceRegExpr(const Lmdtypes::TLMDString ARegExpr, const Lmdtypes::TLMDString AInputStr, const Lmdtypes::TLMDString AReplaceStr, bool AUseSubstitution = false);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDQuoteRegExprMetaChars(const Lmdtypes::TLMDString AStr);
}	/* namespace Lmdregexpr */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDREGEXPR)
using namespace Lmdregexpr;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdregexprHPP
