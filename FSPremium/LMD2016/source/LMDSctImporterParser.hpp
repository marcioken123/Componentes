// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctImporterParser.pas' rev: 31.00 (Windows)

#ifndef LmdsctimporterparserHPP
#define LmdsctimporterparserHPP

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
#include <Vcl.Dialogs.hpp>
#include <LMDSctImporterFileUtils.hpp>
#include <LMDSctImporterTree.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctimporterparser
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDPasParseError;
struct TLMDPasScannerCondState;
class DELPHICLASS TLMDPasScannerCond;
struct TLMDPasScannerFileState;
class DELPHICLASS TLMDPasScannerFile;
class DELPHICLASS TLMDPasScannerDefine;
struct TLMDPasScannerSavepoint;
class DELPHICLASS TLMDPasScanner;
struct TLMDPasParserExprResult;
class DELPHICLASS TLMDPasParser;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPasParseError : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
private:
	int FSourcePos;
	
public:
	__fastcall ELMDPasParseError(const System::UnicodeString Msg, int ASourcePos);
	__fastcall ELMDPasParseError(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int ASourcePos);
	__property int SourcePos = {read=FSourcePos, write=FSourcePos, nodefault};
public:
	/* Exception.CreateRes */ inline __fastcall ELMDPasParseError(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPasParseError(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPasParseError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPasParseError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPasParseError(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPasParseError(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPasParseError(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPasParseError(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPasParseError(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDPasToken : unsigned char { ptIdentifier, ptCString, ptCInteger, ptCFloat, ptArray, ptAsm, ptAutomated, ptBegin, ptCase, ptClass, ptConst, ptConstructor, ptDestructor, ptDispinterface, ptDo, ptDownto, ptElse, ptEnd, ptExcept, ptExports, ptFile, ptFinalization, ptFinally, ptFor, ptFunction, ptGoto, ptIf, ptImplementation, ptInherited, ptInitialization, ptInline, ptInterface, ptLabel, ptLibrary, ptNil, ptObject, ptOf, ptOn, ptOut, ptPacked, ptProcedure, ptProgram, ptProperty, ptRaise, ptRecord, ptRepeat, ptResourcestring, ptSet, ptString, ptThen, ptThreadvar, ptTo, ptTry, ptType, ptUnit, ptUntil, ptUses, ptVar, ptWhile, ptWith, ptAnd, ptAs, ptDereference, ptDiv, ptDivide, ptEqual, ptGreater, ptGreaterEqual, ptIn, ptIs, ptLess, 
	ptLessEqual, ptMinus, ptMod, ptMultiply, ptNot, ptNotEqual, ptOr, ptPlus, ptReference, ptShl, ptShr, ptXor, ptAssignment, ptCloseBlock, ptCloseRound, ptColon, ptComma, ptOpenBlock, ptOpenRound, ptPeriod, ptDoublePeriod, ptSemiColon, ptComment, ptDirective, ptIncludeFile, ptEOf };

typedef System::Set<TLMDPasToken, TLMDPasToken::ptIdentifier, TLMDPasToken::ptEOf> TLMDPasTokens;

enum DECLSPEC_DENUM TLMDPasScannerDirective : unsigned char { pcdInclude, pcdOther };

enum DECLSPEC_DENUM TLMDPasScannerCondKind : unsigned char { ckIFDEF, ckIF };

struct DECLSPEC_DRECORD TLMDPasScannerCondState
{
public:
	bool IsInElse;
	bool Active;
	System::WideChar *C;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasScannerCond : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDPasScannerCond* Parent;
	TLMDPasScannerCondState ParentState;
	TLMDPasScannerCondKind Kind;
	bool IsInElse;
	bool Active;
	System::WideChar *C;
public:
	/* TObject.Create */ inline __fastcall TLMDPasScannerCond(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPasScannerCond(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDPasScannerFileState
{
public:
	System::WideChar *C;
	TLMDPasScannerCond* Top;
	TLMDPasScannerCondState TopState;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasScannerFile : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDPasScannerFile* Parent;
	TLMDPasScannerFileState ParentState;
	TLMDPasScannerCond* Top;
	System::UnicodeString SrcRef;
	System::WideChar *Source;
	System::WideChar *C;
public:
	/* TObject.Create */ inline __fastcall TLMDPasScannerFile(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPasScannerFile(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasScannerDefine : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDPasScannerDefine* Prev;
	System::UnicodeString Name;
	bool IsDefined;
public:
	/* TObject.Create */ inline __fastcall TLMDPasScannerDefine(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPasScannerDefine(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDPasScannerSavepoint
{
public:
	TLMDPasScannerDefine* Defines;
	TLMDPasScannerFile* File_;
	TLMDPasScannerFileState FileState;
};


typedef void __fastcall (__closure *TLMDPasScannerInterpretIf)(System::TObject* Sender, System::WideChar * AExpr, /* out */ bool &AResult);

enum DECLSPEC_DENUM TLMDPasScannerMode : unsigned char { psmNormal, psmInIfDirective };

class PASCALIMPLEMENTATION TLMDPasScanner : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdsctimporterfileutils::TLMDFileHandler* FFileHandler;
	TLMDPasScannerMode FMode;
	System::Classes::TList* FFiles;
	System::Classes::TList* FConditions;
	System::Classes::TList* FDefines;
	TLMDPasScannerDefine* FDefineFirst;
	TLMDPasScanner* FDefinesLookup;
	TLMDPasScannerFile* FFile;
	TLMDPasToken FToken;
	int FTokenPos;
	System::UnicodeString FSData;
	__int64 FIData;
	System::Extended FFData;
	TLMDPasScannerInterpretIf FOnInterpretIf;
	void __fastcall AddFile(const System::UnicodeString ASource);
	void __fastcall SaveFile(TLMDPasScannerFile* AFile, /* out */ TLMDPasScannerFileState &AState);
	void __fastcall RestoreFile(TLMDPasScannerFile* AFile, const TLMDPasScannerFileState &AState);
	void __fastcall AddCondition(TLMDPasScannerCondKind AKind, bool AActive);
	void __fastcall SaveCondition(TLMDPasScannerCond* ACond, /* out */ TLMDPasScannerCondState &AState);
	void __fastcall RestoreCondition(TLMDPasScannerCond* ACond, const TLMDPasScannerCondState &AState);
	TLMDPasScannerDefine* __fastcall FindDefineItem(const System::UnicodeString AName);
	void __fastcall Clear(void);
	System::UnicodeString __fastcall GetIncSource(const System::UnicodeString AFileName);
	bool __fastcall IsActiveContent(void);
	void __fastcall NextChar(void);
	int __fastcall GetCurCharPos(void);
	void __fastcall SkipBlanks(void);
	void __fastcall SkipToNextDirective(void);
	void __fastcall ScanToken(void);
	TLMDPasToken __fastcall ScanDirective(/* out */ System::UnicodeString &AValue);
	TLMDPasToken __fastcall ScanNumber(bool AllowFloat, /* out */ __int64 &IntVal, /* out */ System::Extended &FloatVal);
	System::UnicodeString __fastcall ScanIdentifier(/* out */ bool &CanBeKeyword);
	System::UnicodeString __fastcall ScanString(void);
	System::UnicodeString __fastcall ScanIncludeFileName(void);
	TLMDPasToken __fastcall DetectReservedWord(const System::UnicodeString Token);
	void __fastcall NextToken(void);
	
protected:
	virtual bool __fastcall InterpretIf(System::WideChar * AExpr);
	
public:
	__fastcall TLMDPasScanner(Lmdsctimporterfileutils::TLMDFileHandler* AFileHandler);
	__fastcall virtual ~TLMDPasScanner(void);
	void __fastcall Define(const System::UnicodeString Name);
	void __fastcall Undefine(const System::UnicodeString Name);
	bool __fastcall IsDefined(const System::UnicodeString Name);
	System::UnicodeString __fastcall TokenToStr(TLMDPasToken Token);
	TLMDPasScannerSavepoint __fastcall GetSavepoint(void);
	void __fastcall RollbackToSavepoint(const TLMDPasScannerSavepoint &S);
	void __fastcall Start(TLMDPasScannerMode AMode, const System::UnicodeString Source);
	void __fastcall SkipToken(void);
	__property TLMDPasScannerMode Mode = {read=FMode, nodefault};
	__property TLMDPasToken Token = {read=FToken, nodefault};
	__property int TokenPos = {read=FTokenPos, nodefault};
	__property System::UnicodeString SData = {read=FSData};
	__property __int64 IData = {read=FIData};
	__property System::Extended FData = {read=FFData};
	__property TLMDPasScannerInterpretIf OnInterpretIf = {read=FOnInterpretIf, write=FOnInterpretIf};
};


typedef TLMDPasToken TLMDParserToken;

typedef TLMDPasTokens TLMDParserTokens;

enum DECLSPEC_DENUM TLMDPasParserVisibility : unsigned char { pvPrivate, pvProtected, pvPublic, pvPublished };

enum DECLSPEC_DENUM TLMDParserMemberKind : unsigned char { mkMethod, mkProperty, mkTypeSection, mkConstSection, mkVarSection };

enum DECLSPEC_DENUM TLMDPasParserExprType : unsigned char { etInteger, etFloat, etString, etPointer, etBoolean, etUnknown };

enum DECLSPEC_DENUM TLMDParserRelOp : unsigned char { roGreater, roLess, roLessEqual, roGreaterEqual, roNotEqual, roEqual, roIn, roIs, roAs };

enum DECLSPEC_DENUM TLMDParserMulOp : unsigned char { moMultiply, moDivide, moDiv, moMod, moAnd, moShl, moShr };

enum DECLSPEC_DENUM TLMDParserUnaryOp : unsigned char { uoNot, uoMinus, uoPlus };

enum DECLSPEC_DENUM TLMDParserAddOp : unsigned char { aoPlus, aoMinus, aoOr, aoXor };

struct DECLSPEC_DRECORD TLMDPasParserExprResult
{
public:
	Lmdsctimportertree::TLMDPasConstKind ConstKind;
	System::Variant Val;
};


typedef bool __fastcall (__closure *TLMDPasParserFindDirectiveConst)(const System::UnicodeString AConstName, /* out */ System::Variant &AValue);

class PASCALIMPLEMENTATION TLMDPasParser : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdsctimportertree::TLMDPasUnit* FUnit;
	TLMDPasScanner* FScanner;
	TLMDPasParserFindDirectiveConst FFindConstProc;
	TLMDPasToken __fastcall GetCurToken(void);
	
protected:
	void __fastcall InvalidTokenError(TLMDPasToken AToken);
	void __fastcall StrExpectedError(const System::UnicodeString AStr);
	void __fastcall CheckTokens(const TLMDPasTokens &ATokens);
	void __fastcall CheckAndSkipTokens(const TLMDPasTokens &ATokens);
	void __fastcall SkipToken(void);
	__property TLMDPasToken CurToken = {read=GetCurToken, nodefault};
	void __fastcall ScannerInterpretIf(System::TObject* Sender, System::WideChar * AExpr, /* out */ bool &AResult);
	TLMDPasParserExprResult __fastcall UnknownExprRes(void);
	bool __fastcall IsValKnown(const TLMDPasParserExprResult &R);
	TLMDPasParserExprResult __fastcall AnalyzeRelOp(TLMDParserRelOp AOp, const TLMDPasParserExprResult &L, const TLMDPasParserExprResult &R);
	TLMDPasParserExprResult __fastcall AnalyzeAddOp(TLMDParserAddOp AOp, const TLMDPasParserExprResult &L, const TLMDPasParserExprResult &R);
	TLMDPasParserExprResult __fastcall AnalyzeMulOp(TLMDParserMulOp AOp, const TLMDPasParserExprResult &L, const TLMDPasParserExprResult &R);
	TLMDPasParserExprResult __fastcall AnalyzeUnaryOp(TLMDParserUnaryOp AOp, const TLMDPasParserExprResult &R);
	void __fastcall AddProc(Lmdsctimportertree::TLMDPasProcHeading* AProc, Lmdsctimportertree::TLMDPasNamedNodes* AddTo);
	void __fastcall ParseUnitInterface(void);
	void __fastcall ParseUsesClause(void);
	bool __fastcall IsPortabilityDirective(void);
	bool __fastcall TryParsePortabilityDirective(void);
	void __fastcall ParseInterfaceSection(void);
	void __fastcall ParseInterfaceDecl(void);
	void __fastcall ParseExportedHeading(void);
	void __fastcall ParseConstSection(void);
	Lmdsctimportertree::TLMDPasConstDecl* __fastcall ParseConstantDecl(void);
	void __fastcall ParseTypeSection(void);
	Lmdsctimportertree::TLMDPasTypeDecl* __fastcall ParseTypeDecl(void);
	bool __fastcall IsAnsiStringDecl(void);
	Lmdsctimportertree::TLMDPasTypeId* __fastcall ParseAnsiStringDecl(void);
	void __fastcall ParseTemplateParams(void);
	void __fastcall ParseTemplateParam(void);
	void __fastcall ParseTemplateConstraint(void);
	void __fastcall ParseDotNetAttr(void);
	void __fastcall ParseVarSection(void);
	void __fastcall ParseVarDecl(System::Classes::TList* Result);
	Lmdsctimportertree::TLMDPasType* __fastcall ParseType(void);
	bool __fastcall IsRestrictedType(void);
	Lmdsctimportertree::TLMDPasType* __fastcall ParseRestrictedType(bool isTObject = false);
	Lmdsctimportertree::TLMDPasTypeId* __fastcall ParseTypeId(void);
	void __fastcall ParseTemplateArg(void);
	void __fastcall ParseTemplateArgs(void);
	Lmdsctimportertree::TLMDPasTypeId* __fastcall ParseStringType(void);
	bool __fastcall CanBeSubrangeType(void);
	Lmdsctimportertree::TLMDPasSubrangeType* __fastcall ParseSubrangeType(void);
	Lmdsctimportertree::TLMDPasEnumType* __fastcall ParseEnumeratedType(void);
	System::UnicodeString __fastcall ParseEnumeratedTypeElement(void);
	Lmdsctimportertree::TLMDPasPointerType* __fastcall ParsePointerType(void);
	bool __fastcall IsProcedureType(void);
	Lmdsctimportertree::TLMDPasProcType* __fastcall ParseProcedureType(void);
	void __fastcall ParseFunctionTypeHeading(Lmdsctimportertree::TLMDPasProcType* AType);
	void __fastcall ParseProcedureTypeHeading(Lmdsctimportertree::TLMDPasProcType* AType);
	Lmdsctimportertree::TLMDPasClassRefType* __fastcall ParseClassRefType(void);
	Lmdsctimportertree::TLMDPasType* __fastcall ParseStrucType(void);
	Lmdsctimportertree::TLMDPasArrayTypeBase* __fastcall ParseArrayType(void);
	Lmdsctimportertree::TLMDPasRecordType* __fastcall ParseRecType(void);
	void __fastcall AddSpecialMethods(Lmdsctimportertree::TLMDPasRecordType* AType);
	void __fastcall ParseRecMembersSection(Lmdsctimportertree::TLMDPasRecordType* AType, TLMDPasParserVisibility AVisibility);
	void __fastcall ParseRecVariantSection(Lmdsctimportertree::TLMDPasRecordType* AType);
	void __fastcall ParseRecVariant(Lmdsctimportertree::TLMDPasRecordType* AType);
	Lmdsctimportertree::TLMDPasSetType* __fastcall ParseSetType(void);
	Lmdsctimportertree::TLMDPasFileType* __fastcall ParseFileType(void);
	Lmdsctimportertree::TLMDPasClassType* __fastcall ParseClassType(bool isTObject = false);
	void __fastcall ParseClassHeritage(Lmdsctimportertree::TLMDPasClassType* AType);
	void __fastcall ParseClassMembersSection(Lmdsctimportertree::TLMDPasClassType* AType, TLMDPasParserVisibility AVisibility);
	bool __fastcall IsVisibility(void);
	TLMDPasParserVisibility __fastcall ParseVisibility(void);
	TLMDParserMemberKind __fastcall DetectMemberKind(void);
	void __fastcall ParseFieldDecl(Lmdsctimportertree::TLMDPasNamedNodes* AResult, TLMDPasParserVisibility AVisibility, bool AIsClassField);
	Lmdsctimportertree::TLMDPasPropertyBase* __fastcall ParsePropertyDecl(bool AIsProtected);
	System::UnicodeString __fastcall ParsePropertySpecifier(void);
	Lmdsctimportertree::TLMDPasProcHeading* __fastcall ParseMethodDecl(/* out */ bool &IsOverride);
	Lmdsctimportertree::TLMDPasProcHeading* __fastcall ParseConstructorHeading(void);
	Lmdsctimportertree::TLMDPasProcHeading* __fastcall ParseDestructorHeading(void);
	void __fastcall ParseInnerTypeSection(void);
	void __fastcall ParseInnerConstSection(Lmdsctimportertree::TLMDPasNamedNodes* AResult, TLMDPasParserVisibility AVisibility);
	void __fastcall ParseInnerVarSection(Lmdsctimportertree::TLMDPasNamedNodes* AResult, TLMDPasParserVisibility AVisibility);
	Lmdsctimportertree::TLMDPasInterfaceType* __fastcall ParseInterfaceType(void);
	void __fastcall ParseInterfaceHeritage(Lmdsctimportertree::TLMDPasInterfaceType* AType);
	void __fastcall ParseInterfaceGuid(void);
	Lmdsctimportertree::TLMDPasProcHeading* __fastcall ParseFunctionHeading(bool IsClassFunc, bool IsOperator);
	Lmdsctimportertree::TLMDPasProcHeading* __fastcall ParseProcedureHeading(bool IsClassProc);
	void __fastcall ParseFormalParameters(Lmdsctimportertree::TLMDPasParameters* Result);
	void __fastcall ParseFormalParam(System::Classes::TList* Result);
	void __fastcall ParseTypedConstant(void);
	void __fastcall ParseArrayConstant(void);
	void __fastcall ParseRecordConstant(void);
	System::UnicodeString __fastcall ParseIdentifier(void);
	void __fastcall ParseIdentList(System::Classes::TStrings* Result = (System::Classes::TStrings*)(0x0));
	void __fastcall ParseFormalParamNames(System::Classes::TStrings* Result = (System::Classes::TStrings*)(0x0));
	TLMDPasParserExprResult __fastcall ParseExpression(void);
	TLMDPasParserExprResult __fastcall ParseSimpleExpression(void);
	TLMDPasParserExprResult __fastcall ParseTerm(void);
	TLMDPasParserExprResult __fastcall ParseFactor(void);
	TLMDParserRelOp __fastcall ParseRelOp(void);
	TLMDParserAddOp __fastcall ParseAddOp(void);
	TLMDParserMulOp __fastcall ParseMulOp(void);
	TLMDPasParserExprResult __fastcall ParseDesignator(void);
	void __fastcall ParseSetConstructor(void);
	void __fastcall ParseSetElement(void);
	bool __fastcall IsDirective(void);
	void __fastcall ParseDirective(Lmdsctimportertree::TLMDPasProcHeading* AProc = (Lmdsctimportertree::TLMDPasProcHeading*)(0x0));
	void __fastcall ParseProcDirective(Lmdsctimportertree::TLMDPasProcHeading* AProc = (Lmdsctimportertree::TLMDPasProcHeading*)(0x0));
	bool __fastcall IsProcDirective(void);
	bool __fastcall IsVirtualDirective(void);
	void __fastcall ParseVirtualDirective(void);
	
public:
	__fastcall TLMDPasParser(Lmdsctimporterfileutils::TLMDFileHandler* AFileHandler, TLMDPasParserFindDirectiveConst AFindConstProc);
	__fastcall virtual ~TLMDPasParser(void);
	Lmdsctimportertree::TLMDPasUnit* __fastcall Parse(const System::UnicodeString ASource);
	TLMDPasParserExprResult __fastcall ParseIfDirective(const System::WideChar * AExpr);
	void __fastcall Define(const System::UnicodeString Name);
	void __fastcall Undefine(const System::UnicodeString Name);
	bool __fastcall IsDefined(const System::UnicodeString Name);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsctimporterparser */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTIMPORTERPARSER)
using namespace Lmdsctimporterparser;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctimporterparserHPP
