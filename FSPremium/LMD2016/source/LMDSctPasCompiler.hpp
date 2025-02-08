// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctPasCompiler.pas' rev: 31.00 (Windows)

#ifndef LmdsctpascompilerHPP
#define LmdsctpascompilerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.Variants.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.Win.ComObj.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDSctCst.hpp>
#include <LMDSctClass.hpp>
#include <LMDSctVMCompBase.hpp>
#include <LMDSctVMByteCode.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctpascompiler
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDPasCompiler;
struct TLMDEBC;
struct TLMDContext;
class DELPHICLASS TLMDExpression;
class DELPHICLASS TLMDStatement;
class DELPHICLASS TLMDStmtList;
class DELPHICLASS TLMDUsedUnit;
class DELPHICLASS TLMDGlobalVarIniter;
class DELPHICLASS TLMDGlobalConstIniter;
class DELPHICLASS TLMDProcLocalNamespace;
class DELPHICLASS TLMDProcLocal;
class DELPHICLASS TLMDLocalVarDecl;
class DELPHICLASS TLMDLocalConstDecl;
class DELPHICLASS TLMDLocalResultDecl;
class DELPHICLASS TLMDParamDecl;
class DELPHICLASS TLMDProcedureDecl;
class DELPHICLASS TLMDCompound;
class DELPHICLASS TLMDIfStmt;
class DELPHICLASS TLMDCaseLabel;
class DELPHICLASS TLMDCaseSelector;
class DELPHICLASS TLMDCaseStmt;
class DELPHICLASS TLMDRepeatStmt;
class DELPHICLASS TLMDWhileStmt;
class DELPHICLASS TLMDForStmt;
class DELPHICLASS TLMDRaiseStmt;
class DELPHICLASS TLMDExcSubBlockNamespace;
class DELPHICLASS TLMDExceptionSubBlock;
class DELPHICLASS TLMDExceptionBlock;
class DELPHICLASS TLMDTryStmt;
class DELPHICLASS TLMDBinaryExpr;
class DELPHICLASS TLMDDesignatorItem;
class DELPHICLASS TLMDDesignatorExpr;
class DELPHICLASS TLMDExpressionStmt;
class DELPHICLASS TLMDAssignmentStmt;
class DELPHICLASS TLMDPasEmptyStmt;
class DELPHICLASS TLMDLiteral;
class DELPHICLASS TLMDUnaryExpr;
class DELPHICLASS TLMDSetElement;
class DELPHICLASS TLMDPasSetExpr;
class DELPHICLASS TLMDArrayDim;
class DELPHICLASS TLMDArrayExpr;
class DELPHICLASS TLMDEventMakeExpr;
struct TLMDPasTokenDescription;
class DELPHICLASS TLMDPasScanner;
struct TLMDPasParserSavepoint;
class DELPHICLASS TLMDPasParser;
class DELPHICLASS TLMDPasLanguage;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDPasCompiler : public Lmdsctvmcompbase::ELMDCompileBase
{
	typedef Lmdsctvmcompbase::ELMDCompileBase inherited;
	
public:
	/* ELMDCompileBase.Create */ inline __fastcall ELMDPasCompiler(const System::WideString Msg, int ASourcePos) : Lmdsctvmcompbase::ELMDCompileBase(Msg, ASourcePos) { }
	/* ELMDCompileBase.CreateFmt */ inline __fastcall ELMDPasCompiler(const System::WideString Msg, const System::TVarRec *Args, const int Args_High, int ASourcePos) : Lmdsctvmcompbase::ELMDCompileBase(Msg, Args, Args_High, ASourcePos) { }
	
public:
	/* Exception.CreateRes */ inline __fastcall ELMDPasCompiler(NativeUInt Ident)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDPasCompiler(System::PResStringRec ResStringRec)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPasCompiler(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDPasCompiler(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDPasCompiler(const System::UnicodeString Msg, int AHelpContext) : Lmdsctvmcompbase::ELMDCompileBase(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDPasCompiler(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : Lmdsctvmcompbase::ELMDCompileBase(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPasCompiler(NativeUInt Ident, int AHelpContext)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDPasCompiler(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPasCompiler(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDPasCompiler(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDPasCompiler(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDEBC
{
public:
	Lmdsctvmbytecode::TLMDLabel* ExitL;
	Lmdsctvmbytecode::TLMDLabel* BreakL;
	Lmdsctvmbytecode::TLMDLabel* ContinueL;
};


struct DECLSPEC_DRECORD TLMDContext
{
public:
	Lmdsctvmbytecode::TLMDByteCode* Code;
	Lmdsctvmbytecode::TLMDTry* CurReraise;
	Lmdsctvmbytecode::TLMDAbstractNamespace* CurNamespace;
	TLMDEBC CurEBC;
};


enum DECLSPEC_DENUM TLMDExprEmitRes : unsigned char { erNoRes, erStack, erPopJmpIfTrue, erPopJmpIfFalse };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExpression : public Lmdsctvmcompbase::ILMDEmitable
{
	typedef Lmdsctvmcompbase::ILMDEmitable inherited;
	
private:
	int FSourcePos;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack) = 0 ;
	virtual void __fastcall DoEmitRefByteCode(TLMDContext &C);
	
public:
	virtual void __fastcall Emit(Lmdsctvmbytecode::TLMDAbstractNamespace* ANamespace, Lmdsctvmbytecode::TLMDByteCode* AByteCode);
	void __fastcall EmitByteCode(TLMDContext &C)/* overload */;
	void __fastcall EmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel = (Lmdsctvmbytecode::TLMDLabel*)(0x0))/* overload */;
	void __fastcall EmitRefByteCode(TLMDContext &C);
	__property int SourcePos = {read=FSourcePos, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDExpression(void) : Lmdsctvmcompbase::ILMDEmitable() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDExpression(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStatement : public Lmdsctvmcompbase::ILMDEmitable
{
	typedef Lmdsctvmcompbase::ILMDEmitable inherited;
	
private:
	int FSourcePos;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C) = 0 ;
	
public:
	virtual void __fastcall Emit(Lmdsctvmbytecode::TLMDAbstractNamespace* ANamespace, Lmdsctvmbytecode::TLMDByteCode* AByteCode);
	void __fastcall EmitByteCode(TLMDContext &C);
	__property int SourcePos = {read=FSourcePos, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDStatement(void) : Lmdsctvmcompbase::ILMDEmitable() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStatement(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStmtList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDStatement* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	System::Classes::TList* FItems;
	bool FOwnItems;
	TLMDStatement* __fastcall GetItems(int AIndex);
	int __fastcall GetCount(void);
	
public:
	__fastcall TLMDStmtList(void)/* overload */;
	__fastcall TLMDStmtList(bool AOwnItems)/* overload */;
	__fastcall virtual ~TLMDStmtList(void);
	void __fastcall Add(TLMDStatement* AItem);
	void __fastcall EmitByteCode(TLMDContext &C);
	__property TLMDStatement* Items[int AIndex] = {read=GetItems/*, default*/};
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUsedUnit : public Lmdsctclass::TLMDNamedItem
{
	typedef Lmdsctclass::TLMDNamedItem inherited;
	
public:
	__fastcall TLMDUsedUnit(int AName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDUsedUnit(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGlobalVarIniter : public Lmdsctvmcompbase::ILMDEmitable
{
	typedef Lmdsctvmcompbase::ILMDEmitable inherited;
	
private:
	Lmdsctvmcompbase::TLMDVarObject* FVar;
	TLMDExpression* FIniter;
	
public:
	__fastcall TLMDGlobalVarIniter(Lmdsctvmcompbase::TLMDVarObject* AVar, TLMDExpression* AIniter);
	__fastcall virtual ~TLMDGlobalVarIniter(void);
	virtual void __fastcall Emit(Lmdsctvmbytecode::TLMDAbstractNamespace* ANamespace, Lmdsctvmbytecode::TLMDByteCode* AByteCode);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDGlobalConstIniter : public Lmdsctvmcompbase::ILMDEmitable
{
	typedef Lmdsctvmcompbase::ILMDEmitable inherited;
	
private:
	Lmdsctvmcompbase::TLMDConstObject* FConst;
	TLMDExpression* FIniter;
	
public:
	__fastcall TLMDGlobalConstIniter(Lmdsctvmcompbase::TLMDConstObject* AConst, TLMDExpression* AIniter);
	virtual void __fastcall Emit(Lmdsctvmbytecode::TLMDAbstractNamespace* ANamespace, Lmdsctvmbytecode::TLMDByteCode* AByteCode);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDGlobalConstIniter(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDProcLocalNamespace : public Lmdsctvmbytecode::TLMDAbstractNamespace
{
	typedef Lmdsctvmbytecode::TLMDAbstractNamespace inherited;
	
private:
	TLMDProcedureDecl* FProcedure;
	
public:
	__fastcall TLMDProcLocalNamespace(TLMDProcedureDecl* AProcedure, Lmdsctvmbytecode::TLMDAbstractNamespace* AParent);
	virtual Lmdsctvmbytecode::TLMDNameSearchRes __fastcall Find(void * AThread, int AName, System::PWideString AStrName);
	virtual void __fastcall EnumDebugVars(bool ALocalsOnly, Lmdsctvmbytecode::TLMDNamespaceEnumVarsProc AProc);
	virtual Lmdsctvmbytecode::TLMDNameSearchRes __fastcall CompileTimeFind(int AName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDProcLocalNamespace(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDProcLocalType : unsigned char { ltVar, ltConst, ltResult, ltParam };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDProcLocal : public Lmdsctclass::TLMDNamedItem
{
	typedef Lmdsctclass::TLMDNamedItem inherited;
	
private:
	System::WideString FStrName;
	TLMDProcLocalType FLocalType;
	
public:
	__fastcall TLMDProcLocal(TLMDProcLocalType ALocalType, int AName, const System::WideString AStrName);
	__property TLMDProcLocalType LocalType = {read=FLocalType, nodefault};
	__property System::WideString StrName = {read=FStrName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDProcLocal(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLocalVarDecl : public TLMDProcLocal
{
	typedef TLMDProcLocal inherited;
	
private:
	TLMDExpression* FExpr;
	int FIndex;
	
public:
	__fastcall TLMDLocalVarDecl(int AName, const System::WideString AStrName)/* overload */;
	__fastcall virtual ~TLMDLocalVarDecl(void);
	__property TLMDExpression* Expr = {read=FExpr};
	__property int Index = {read=FIndex, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDLocalConstDecl : public TLMDProcLocal
{
	typedef TLMDProcLocal inherited;
	
private:
	TLMDExpression* FExpr;
	System::OleVariant FValue;
	
public:
	__fastcall TLMDLocalConstDecl(int AName, const System::WideString AStrName);
	__fastcall virtual ~TLMDLocalConstDecl(void);
	__property TLMDExpression* Expr = {read=FExpr, write=FExpr};
	__property System::OleVariant Value = {read=FValue, write=FValue};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLocalResultDecl : public TLMDProcLocal
{
	typedef TLMDProcLocal inherited;
	
public:
	__fastcall TLMDLocalResultDecl(int AName, const System::WideString AStrName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDLocalResultDecl(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDParamDecl : public TLMDProcLocal
{
	typedef TLMDProcLocal inherited;
	
private:
	Lmdsctvmbytecode::TLMDParamInfo FParamInfo;
	
public:
	__fastcall TLMDParamDecl(int AName, const System::WideString AStrName, Lmdsctvmbytecode::TLMDParamKind AParamKind)/* overload */;
	__property Lmdsctvmbytecode::TLMDParamInfo ParamInfo = {read=FParamInfo};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDParamDecl(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDProcKind : unsigned char { pkFunction, pkProcedure };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDProcedureDecl : public Lmdsctvmcompbase::TLMDProcObject
{
	typedef Lmdsctvmcompbase::TLMDProcObject inherited;
	
private:
	TLMDProcKind FProcKind;
	TLMDProcLocalNamespace* FLocalNamespace;
	Lmdsctclass::TLMDNameHashTable* FLocalMap;
	System::Classes::TList* FParams;
	System::Classes::TList* FLocalVars;
	System::Classes::TList* FLocalConsts;
	TLMDLocalResultDecl* FLocalResult;
	TLMDStmtList* FStmtList;
	int FSourcePos;
	int FEndSourcePos;
	TLMDParamDecl* __fastcall GetParams(int AIndex);
	int __fastcall GetLocalConstCount(void);
	TLMDLocalConstDecl* __fastcall GetLocalConsts(int AIndex);
	TLMDLocalVarDecl* __fastcall GetLocalVars(int AIndex);
	int __fastcall GetLocalVarCount(void);
	bool __fastcall AddLocalItem(TLMDProcLocal* AItem);
	TLMDProcLocalNamespace* __fastcall CreateLocalNS(Lmdsctvmbytecode::TLMDAbstractNamespace* AParent);
	
public:
	__fastcall TLMDProcedureDecl(int AName, const System::WideString AStrName, TLMDProcKind AProcKind);
	__fastcall virtual ~TLMDProcedureDecl(void);
	virtual Lmdsctvmcompbase::TLMDGlobalObjType __fastcall GetGlobalObjType(void);
	virtual void __fastcall EmitByteCode(Lmdsctvmbytecode::TLMDAbstractNamespace* AGlobalNamespace);
	__property int SourcePos = {read=FSourcePos, nodefault};
	__property int EndSourcePos = {read=FEndSourcePos, nodefault};
	__property TLMDProcKind ProcKind = {read=FProcKind, nodefault};
	__property TLMDStmtList* StmtList = {read=FStmtList};
	__property TLMDParamDecl* Params[int AIndex] = {read=GetParams};
	__property ParamCount;
	__property TLMDLocalVarDecl* LocalVars[int AIndex] = {read=GetLocalVars};
	__property int LocalVarCount = {read=GetLocalVarCount, nodefault};
	__property TLMDLocalConstDecl* LocalConsts[int AIndex] = {read=GetLocalConsts};
	__property int LocalConstCount = {read=GetLocalConstCount, nodefault};
	__property TLMDLocalResultDecl* LocalResult = {read=FLocalResult};
	__property TLMDProcLocalNamespace* LocalNamespace = {read=FLocalNamespace};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCompound : public TLMDStatement
{
	typedef TLMDStatement inherited;
	
private:
	TLMDStmtList* FStmtList;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDCompound(void);
	__fastcall virtual ~TLMDCompound(void);
	__property TLMDStmtList* StmtList = {read=FStmtList};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDIfStmt : public TLMDStatement
{
	typedef TLMDStatement inherited;
	
private:
	TLMDExpression* FIfExpr;
	TLMDStatement* FThenStmt;
	TLMDStatement* FElseStmt;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDIfStmt(void);
	__fastcall virtual ~TLMDIfStmt(void);
	__property TLMDExpression* IfExpr = {read=FIfExpr};
	__property TLMDStatement* ThenStmt = {read=FThenStmt};
	__property TLMDStatement* ElseStmt = {read=FElseStmt};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCaseLabel : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDExpression* FFirstExpr;
	TLMDExpression* FSecondExpr;
	int FSourcePos;
	
public:
	__fastcall TLMDCaseLabel(void);
	__fastcall virtual ~TLMDCaseLabel(void);
	void __fastcall EmitExpressions(TLMDContext &C, /* out */ Lmdsctvmbytecode::TLMDInstrCode &ATestInstr);
	__property TLMDExpression* FirstExpr = {read=FFirstExpr};
	__property TLMDExpression* SecondExpr = {read=FSecondExpr};
	__property int SourcePos = {read=FSourcePos, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCaseSelector : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FLabels;
	TLMDStatement* FStmt;
	int __fastcall GetLabelCount(void);
	TLMDCaseLabel* __fastcall GetLabels(int AIndex);
	void __fastcall AddLabel(TLMDCaseLabel* ALabel);
	
public:
	__fastcall TLMDCaseSelector(void);
	__fastcall virtual ~TLMDCaseSelector(void);
	__property TLMDCaseLabel* Labels[int AIndex] = {read=GetLabels};
	__property int LabelCount = {read=GetLabelCount, nodefault};
	__property TLMDStatement* Stmt = {read=FStmt};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCaseStmt : public TLMDStatement
{
	typedef TLMDStatement inherited;
	
private:
	TLMDExpression* FCaseExpr;
	System::Classes::TList* FSelectors;
	TLMDStmtList* FElseStmts;
	int __fastcall GetSelectorCount(void);
	TLMDCaseSelector* __fastcall GetSelectors(int AIndex);
	void __fastcall AddSelector(TLMDCaseSelector* ASelector);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDCaseStmt(void);
	__fastcall virtual ~TLMDCaseStmt(void);
	__property TLMDExpression* CaseExpr = {read=FCaseExpr};
	__property TLMDStmtList* ElseStmtList = {read=FElseStmts};
	__property int CaseSelectorCount = {read=GetSelectorCount, nodefault};
	__property TLMDCaseSelector* CaseSelectors[int AIndex] = {read=GetSelectors};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRepeatStmt : public TLMDStatement
{
	typedef TLMDStatement inherited;
	
private:
	TLMDStmtList* FStmtList;
	TLMDExpression* FRepeatExpr;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDRepeatStmt(void);
	__fastcall virtual ~TLMDRepeatStmt(void);
	__property TLMDStmtList* StmtList = {read=FStmtList};
	__property TLMDExpression* RepeatExpr = {read=FRepeatExpr};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWhileStmt : public TLMDStatement
{
	typedef TLMDStatement inherited;
	
private:
	TLMDStatement* FStmt;
	TLMDExpression* FWhileExpr;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDWhileStmt(void);
	__fastcall virtual ~TLMDWhileStmt(void);
	__property TLMDStatement* Stmt = {read=FStmt};
	__property TLMDExpression* WhileExpr = {read=FWhileExpr};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDForCounterKind : unsigned char { ckTo, ckDownto };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDForStmt : public TLMDStatement
{
	typedef TLMDStatement inherited;
	
private:
	TLMDDesignatorExpr* FVarExpr;
	TLMDForCounterKind FCounterKind;
	TLMDExpression* FFromExpr;
	TLMDExpression* FToExpr;
	TLMDStatement* FStmt;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall virtual ~TLMDForStmt(void);
	__property TLMDDesignatorExpr* VarExpr = {read=FVarExpr};
	__property TLMDForCounterKind CounterKind = {read=FCounterKind, nodefault};
	__property TLMDExpression* FromExpr = {read=FFromExpr};
	__property TLMDExpression* ToExpr = {read=FToExpr};
	__property TLMDStatement* Stmt = {read=FStmt};
public:
	/* TObject.Create */ inline __fastcall TLMDForStmt(void) : TLMDStatement() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRaiseStmt : public TLMDStatement
{
	typedef TLMDStatement inherited;
	
private:
	TLMDExpression* FExpr;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDRaiseStmt(void);
	__fastcall virtual ~TLMDRaiseStmt(void);
	__property TLMDExpression* Expr = {read=FExpr};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExcSubBlockNamespace : public Lmdsctvmbytecode::TLMDAbstractNamespace
{
	typedef Lmdsctvmbytecode::TLMDAbstractNamespace inherited;
	
private:
	int FVarName;
	System::WideString FVarSName;
	int FVarIndex;
	
public:
	__fastcall TLMDExcSubBlockNamespace(Lmdsctvmbytecode::TLMDAbstractNamespace* AParent, int AVarName, const System::WideString AVarSName, int AVarIndex);
	virtual Lmdsctvmbytecode::TLMDNameSearchRes __fastcall Find(void * AThread, int AName, System::PWideString AStrName);
	virtual void __fastcall EnumDebugVars(bool ALocalsOnly, Lmdsctvmbytecode::TLMDNamespaceEnumVarsProc AProc);
	virtual Lmdsctvmbytecode::TLMDNameSearchRes __fastcall CompileTimeFind(int AName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDExcSubBlockNamespace(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExceptionSubBlock : public Lmdsctclass::TLMDNamedItem
{
	typedef Lmdsctclass::TLMDNamedItem inherited;
	
private:
	TLMDExpression* FExpr;
	TLMDStatement* FStmt;
	int FSourcePos;
	System::WideString FStrName;
	TLMDExcSubBlockNamespace* FNamespace;
	Lmdsctvmbytecode::TLMDAbstractNamespace* __fastcall CreateNS(Lmdsctvmbytecode::TLMDAbstractNamespace* AParent, int AVarIndex);
	
public:
	__fastcall TLMDExceptionSubBlock(int AName, const System::WideString AStrName);
	__fastcall virtual ~TLMDExceptionSubBlock(void);
	__property TLMDExcSubBlockNamespace* Namespace = {read=FNamespace};
	__property System::WideString StrName = {read=FStrName};
	__property TLMDExpression* Expr = {read=FExpr};
	__property TLMDStatement* Stmt = {read=FStmt};
	__property int SourcePos = {read=FSourcePos, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExceptionBlock : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDStmtList* FElseStmtList;
	System::Classes::TList* FBlocks;
	bool FHasElse;
	int FElseSourcePos;
	int __fastcall GetBlockCount(void);
	TLMDExceptionSubBlock* __fastcall GetBlocks(int AIndex);
	void __fastcall AddBlock(TLMDExceptionSubBlock* ABlock);
	
public:
	__fastcall TLMDExceptionBlock(void);
	__fastcall virtual ~TLMDExceptionBlock(void);
	__property TLMDStmtList* ElseStmtList = {read=FElseStmtList};
	__property TLMDExceptionSubBlock* Blocks[int AIndex] = {read=GetBlocks};
	__property int BlockCount = {read=GetBlockCount, nodefault};
	__property bool HasElse = {read=FHasElse, nodefault};
	__property int ElseSourcePos = {read=FElseSourcePos, nodefault};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDTryStmtType : unsigned char { ttFinally, ttExcept };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTryStmt : public TLMDStatement
{
	typedef TLMDStatement inherited;
	
private:
	TLMDStmtList* FTryStmtList;
	TLMDStmtList* FExceptStmtList;
	TLMDExceptionBlock* FExceptionBlock;
	TLMDStmtList* FFinallyStmtList;
	TLMDTryStmtType FTryStmtType;
	void __fastcall EmitTryFinally(TLMDContext &C);
	void __fastcall EmitTryExcept(TLMDContext &C);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDTryStmt(void);
	__fastcall virtual ~TLMDTryStmt(void);
	__property TLMDTryStmtType TryStmtType = {read=FTryStmtType, nodefault};
	__property TLMDStmtList* TryStmtList = {read=FTryStmtList};
	__property TLMDStmtList* ExceptStmtList = {read=FExceptStmtList};
	__property TLMDExceptionBlock* ExceptionBlock = {read=FExceptionBlock};
	__property TLMDStmtList* FinallyStmtList = {read=FFinallyStmtList};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDBinaryOp : unsigned char { bopGreater, bopGreaterEqual, bopEqual, bopLess, bopLessEqual, bopNotEqual, bopIn, bopIs, bopPlus, bopMinus, bopOr, bopXor, bopMultiply, bopDivide, bopDiv, bopMod, bopAnd, bopShl, bopShr };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBinaryExpr : public TLMDExpression
{
	typedef TLMDExpression inherited;
	
private:
	TLMDExpression* FLeftExpr;
	TLMDExpression* FRightExpr;
	TLMDBinaryOp FOperator;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	
public:
	__fastcall TLMDBinaryExpr(TLMDBinaryOp AOperator);
	__fastcall virtual ~TLMDBinaryExpr(void);
	__property TLMDBinaryOp Oper = {read=FOperator, nodefault};
	__property TLMDExpression* LeftExpr = {read=FLeftExpr};
	__property TLMDExpression* RightExpr = {read=FRightExpr};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDesignatorItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FName;
	System::WideString FStrName;
	System::Classes::TList* FArgs;
	Lmdsctvmbytecode::TLMDBracketType FBracketType;
	int FSourcePos;
	bool FIsResultUsed;
	TLMDExpression* __fastcall GetArgs(int AIndex);
	int __fastcall GetArgCount(void);
	void __fastcall AddArg(TLMDExpression* AArgs);
	void __fastcall EmitArgs(TLMDContext &C);
	bool __fastcall GetIsNamed(void);
	
public:
	__fastcall TLMDDesignatorItem(void)/* overload */;
	__fastcall TLMDDesignatorItem(int AName, const System::WideString AStrName)/* overload */;
	__fastcall virtual ~TLMDDesignatorItem(void);
	__property int Name = {read=FName, nodefault};
	__property System::WideString StrName = {read=FStrName};
	__property bool IsNamed = {read=GetIsNamed, nodefault};
	__property int SourcePos = {read=FSourcePos, nodefault};
	__property TLMDExpression* Args[int AIndex] = {read=GetArgs};
	__property int ArgCount = {read=GetArgCount, nodefault};
	__property Lmdsctvmbytecode::TLMDBracketType BracketType = {read=FBracketType, nodefault};
	__property bool IsResultUsed = {read=FIsResultUsed, nodefault};
};

#pragma pack(pop)

typedef bool __fastcall (__closure *TLMDPasGetCallInstr)(TLMDContext &C, TLMDDesignatorItem* AItem, /* out */ Lmdsctvmbytecode::TLMDInstr &AInstr, /* out */ bool &ANeedSlot);

typedef void __fastcall (__closure *TLMDPasEmitValue)(TLMDContext &C, TLMDDesignatorItem* AItem);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDesignatorExpr : public TLMDExpression
{
	typedef TLMDExpression inherited;
	
public:
	TLMDDesignatorItem* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	System::Classes::TList* FItems;
	int __fastcall GetItemCount(void);
	TLMDDesignatorItem* __fastcall GetItems(int AIndex);
	TLMDDesignatorItem* __fastcall GetLastItem(void);
	void __fastcall AddItem(TLMDDesignatorItem* AItem);
	Lmdsctvmbytecode::TLMDInstr __fastcall OptimizeCallInstr(TLMDContext &C, TLMDDesignatorItem* AItem, Lmdsctvmbytecode::TLMDInstrCode ACallInstr, bool AHasObject, bool AHasValue, /* out */ bool &ANeedSlot);
	void __fastcall InternalEmit(TLMDContext &C, bool ANeedRef, TLMDPasGetCallInstr AGetInstrProc = 0x0, TLMDPasEmitValue AEmitValueProc = 0x0);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	virtual void __fastcall DoEmitRefByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDDesignatorExpr(void);
	__fastcall TLMDDesignatorExpr(int AName, const System::WideString AStrName, int ASourcePos);
	__fastcall virtual ~TLMDDesignatorExpr(void);
	__property TLMDDesignatorItem* Items[int AIndex] = {read=GetItems/*, default*/};
	__property int ItemCount = {read=GetItemCount, nodefault};
	__property TLMDDesignatorItem* LastItem = {read=GetLastItem};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExpressionStmt : public TLMDStatement
{
	typedef TLMDStatement inherited;
	
private:
	TLMDExpression* FExpr;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDExpressionStmt(void);
	__fastcall virtual ~TLMDExpressionStmt(void);
	__property TLMDExpression* Expr = {read=FExpr};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDAssignmentStmt : public TLMDStatement
{
	typedef TLMDStatement inherited;
	
private:
	TLMDDesignatorExpr* FLeftExpr;
	TLMDExpression* FRightExpr;
	bool __fastcall AsgnCallInstrProc(TLMDContext &C, TLMDDesignatorItem* AItem, /* out */ Lmdsctvmbytecode::TLMDInstr &AInstr, /* out */ bool &ANeedSlot);
	void __fastcall EmitValueProc(TLMDContext &C, TLMDDesignatorItem* AItem);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDAssignmentStmt(void);
	__fastcall virtual ~TLMDAssignmentStmt(void);
	__property TLMDDesignatorExpr* LeftExpr = {read=FLeftExpr};
	__property TLMDExpression* RightExpr = {read=FRightExpr};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasEmptyStmt : public TLMDStatement
{
	typedef TLMDStatement inherited;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
public:
	/* TObject.Create */ inline __fastcall TLMDPasEmptyStmt(void) : TLMDStatement() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPasEmptyStmt(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDLiteral : public TLMDExpression
{
	typedef TLMDExpression inherited;
	
private:
	System::OleVariant FValue;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	
public:
	__fastcall TLMDLiteral(const System::OleVariant &AValue)/* overload */;
	__property System::OleVariant Value = {read=FValue};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDLiteral(void) { }
	
};


enum DECLSPEC_DENUM TLMDUnaryOp : unsigned char { uopPlus, uopMinus, uopNot };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDUnaryExpr : public TLMDExpression
{
	typedef TLMDExpression inherited;
	
private:
	TLMDUnaryOp FOperator;
	TLMDExpression* FExpr;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	
public:
	__fastcall TLMDUnaryExpr(TLMDUnaryOp AOperator);
	__fastcall virtual ~TLMDUnaryExpr(void);
	__property TLMDUnaryOp Oper = {read=FOperator, nodefault};
	__property TLMDExpression* Expr = {read=FExpr};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDSetElement : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDExpression* FLeftExpr;
	TLMDExpression* FRightExpr;
	int FSourcePos;
	
public:
	__fastcall TLMDSetElement(void);
	__fastcall virtual ~TLMDSetElement(void);
	void __fastcall EmitByteCode(TLMDContext &C);
	__property TLMDExpression* LeftExpr = {read=FLeftExpr};
	__property TLMDExpression* RightExpr = {read=FRightExpr};
	__property int SourcePos = {read=FSourcePos, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasSetExpr : public TLMDExpression
{
	typedef TLMDExpression inherited;
	
private:
	System::Classes::TList* FSetElements;
	int __fastcall GetSetElementCount(void);
	TLMDSetElement* __fastcall GetSetElements(int AIndex);
	void __fastcall AddSetElement(TLMDSetElement* AElem);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	
public:
	__fastcall TLMDPasSetExpr(void);
	__fastcall virtual ~TLMDPasSetExpr(void);
	__property TLMDSetElement* SetElements[int AIndex] = {read=GetSetElements};
	__property int SetElementCount = {read=GetSetElementCount, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDArrayDim : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDExpression* FLeftExpr;
	TLMDExpression* FRightExpr;
	int FSourcePos;
	
public:
	__fastcall virtual ~TLMDArrayDim(void);
	void __fastcall EmitByteCode(TLMDContext &C);
	__property TLMDExpression* LeftExpr = {read=FLeftExpr};
	__property TLMDExpression* RightExpr = {read=FRightExpr};
	__property int SourcePos = {read=FSourcePos, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDArrayDim(void) : System::TObject() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDArrayExpr : public TLMDExpression
{
	typedef TLMDExpression inherited;
	
private:
	System::Classes::TList* FArrayDims;
	System::Word FElemVarType;
	int __fastcall GetArrayDimCount(void);
	TLMDArrayDim* __fastcall GetArrayDims(int AIndex);
	void __fastcall AddArrayDim(TLMDArrayDim* AElem);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	
public:
	__fastcall TLMDArrayExpr(void);
	__fastcall virtual ~TLMDArrayExpr(void);
	__property TLMDArrayDim* ArrayDims[int AIndex] = {read=GetArrayDims};
	__property int ArrayDimCount = {read=GetArrayDimCount, nodefault};
	__property System::Word ElemVarType = {read=FElemVarType, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDEventMakeExpr : public TLMDExpression
{
	typedef TLMDExpression inherited;
	
private:
	int FProcName;
	System::WideString FStrProcName;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	
public:
	__fastcall TLMDEventMakeExpr(int AProcName);
	__property int ProcName = {read=FProcName, nodefault};
	__property System::WideString StrProcName = {read=FStrProcName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDEventMakeExpr(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDPasToken : unsigned char { ptIdentifier, ptCString, ptCInteger, ptCFloat, ptArray, ptBegin, ptCase, ptConst, ptDo, ptDownto, ptElse, ptEnd, ptExcept, ptFinally, ptFor, ptFunction, ptIf, ptNil, ptOf, ptOn, ptOut, ptProcedure, ptRaise, ptRepeat, ptThen, ptTo, ptTry, ptUntil, ptUses, ptVar, ptWhile, ptAnd, ptDiv, ptDivide, ptEqual, ptGreater, ptGreaterEqual, ptIn, ptIs, ptLess, ptLessEqual, ptMinus, ptMod, ptMultiply, ptNot, ptNotEqual, ptOr, ptPlus, ptShl, ptShr, ptXor, ptAssignment, ptCloseBlock, ptCloseRound, ptColon, ptComma, ptOpenBlock, ptOpenRound, ptPeriod, ptDoublePeriod, ptSemiColon, ptReference, ptComment, ptEOf };

typedef System::Set<TLMDPasToken, TLMDPasToken::ptIdentifier, TLMDPasToken::ptEOf> TLMDPasTokens;

typedef System::WideChar * TLMDPasScannerSavepoint;

struct DECLSPEC_DRECORD TLMDPasTokenDescription
{
public:
	System::WideString S;
	bool IsKeyword;
};


class PASCALIMPLEMENTATION TLMDPasScanner : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::WideString FStrSource;
	System::WideChar *FSource;
	System::WideChar *FCurChar;
	bool FSkipComments;
	TLMDPasToken FToken;
	int FTokenStartPos;
	System::WideString FSData;
	int FIData;
	System::Extended FFData;
	int FTokenEndPos;
	void __fastcall NextChar(void);
	int __fastcall GetCurCharPos(void);
	void __fastcall SkipBlanks(void);
	void __fastcall ScanToken(void);
	TLMDPasToken __fastcall ScanNumber(bool ALLowFloat, /* out */ int &IntVal, /* out */ System::Extended &FloatVal);
	System::WideString __fastcall ScanIdentifier(void);
	System::WideString __fastcall ScanString(void);
	TLMDPasToken __fastcall DetectReservedWord(const System::WideString Token);
	void __fastcall NextToken(void);
	
public:
	__fastcall TLMDPasScanner(bool SkipComments);
	__fastcall virtual ~TLMDPasScanner(void);
	System::WideString __fastcall TokenToStr(TLMDPasToken Token);
	System::WideChar * __fastcall GetSavepoint(void);
	void __fastcall Rollback(const System::WideChar * S);
	void __fastcall Start(const System::WideString Source);
	void __fastcall SkipToken(void);
	__property TLMDPasToken Token = {read=FToken, nodefault};
	__property int TokenStartPos = {read=FTokenStartPos, nodefault};
	__property int TokenEndPos = {read=FTokenEndPos, nodefault};
	__property System::WideString SData = {read=FSData};
	__property int IData = {read=FIData, nodefault};
	__property System::Extended FData = {read=FFData};
};


enum DECLSPEC_DENUM TLMDPasParserTryState : unsigned char { ptsNowhere, ptsInTry, ptsInExcept, ptsInFinally };

struct DECLSPEC_DRECORD TLMDPasParserSavepoint
{
public:
	System::WideChar *ScannerSP;
	TLMDPasParserTryState TryState;
	int LastSkippedPos;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasParser : public Lmdsctvmcompbase::ILMDParserBase
{
	typedef Lmdsctvmcompbase::ILMDParserBase inherited;
	
private:
	Lmdsctvmcompbase::ILMDParserCallbacks* FCbs;
	TLMDPasScanner* FScanner;
	TLMDPasParserTryState FTryState;
	int FLastSkippedPos;
	TLMDPasToken __fastcall GetCurToken(void);
	void __fastcall DoAddGlobalObject(Lmdsctvmcompbase::TLMDGlobalObject* AObj);
	void __fastcall DoAddUsedUnit(const System::WideString AUnitName);
	void __fastcall DoAddProcLocal(TLMDProcLocal* AItem, TLMDProcedureDecl* AProc);
	System::OleVariant __fastcall PasNil(void);
	void __fastcall InvalidTokenError(TLMDPasToken AToken);
	void __fastcall CheckTokens(const TLMDPasTokens &ATokens);
	void __fastcall CheckAndSkipTokens(const TLMDPasTokens &ATokens);
	void __fastcall SkipToken(void);
	TLMDPasParserSavepoint __fastcall GetSavepoint(void);
	void __fastcall Rollback(const TLMDPasParserSavepoint &ASavepoint);
	__property TLMDPasToken CurToken = {read=GetCurToken, nodefault};
	void __fastcall ParseUnit(void);
	void __fastcall ParseUsesClause(void);
	void __fastcall ParseGlobalVarSection(void);
	void __fastcall ParseGlobalVarDecl(void);
	void __fastcall ParseLocalVarSection(TLMDProcedureDecl* AProc);
	void __fastcall ParseLocalVarDecl(TLMDProcedureDecl* AProc);
	void __fastcall ParseGlobalConstSection(void);
	void __fastcall ParseGlobalConstDecl(void);
	void __fastcall ParseLocalConstSection(TLMDProcedureDecl* AProc);
	TLMDLocalConstDecl* __fastcall ParseLocalConstDecl(void);
	void __fastcall ParseProcedureDecl(void);
	void __fastcall ParseParamsDecl(TLMDProcedureDecl* AProc);
	TLMDParamDecl* __fastcall ParseParamDecl(void);
	void __fastcall ParseStmtList(TLMDStmtList* AStmtList);
	TLMDStatement* __fastcall ParseStatement(void);
	TLMDPasEmptyStmt* __fastcall ParseEmptyStmt(void);
	TLMDCompound* __fastcall ParseCompoundStmt(void);
	TLMDIfStmt* __fastcall ParseIfStmt(void);
	TLMDCaseStmt* __fastcall ParseCaseStmt(void);
	TLMDCaseSelector* __fastcall ParseCaseSelector(void);
	TLMDCaseLabel* __fastcall ParseCaseLabel(void);
	TLMDRepeatStmt* __fastcall ParseRepeatStmt(void);
	TLMDWhileStmt* __fastcall ParseWhileStmt(void);
	TLMDForStmt* __fastcall ParseForStmt(void);
	TLMDTryStmt* __fastcall ParseTryStmt(void);
	TLMDExceptionBlock* __fastcall ParseExceptionBlock(void);
	TLMDRaiseStmt* __fastcall ParseRaiseStmt(void);
	TLMDExpression* __fastcall ParseExpression(void);
	TLMDExpression* __fastcall ParseSimpleExpression(void);
	TLMDExpression* __fastcall ParseTerm(void);
	TLMDExpression* __fastcall ParseFactor(void);
	void __fastcall ParseArrayDim(TLMDArrayExpr* AArrExpr);
	TLMDBinaryOp __fastcall ParseRelOp(void);
	TLMDBinaryOp __fastcall ParseAddOp(void);
	TLMDBinaryOp __fastcall ParseMulOp(void);
	TLMDDesignatorExpr* __fastcall ParseDesignator(void);
	TLMDDesignatorItem* __fastcall ParseNamedCall(void);
	void __fastcall ParseSetElements(TLMDPasSetExpr* ASetExpr);
	TLMDSetElement* __fastcall ParseSetElement(void);
	TLMDBinaryExpr* __fastcall CreateBinaryExpr(TLMDBinaryOp AOper, TLMDExpression* ALeft);
	TLMDUnaryExpr* __fastcall CreateUnaryExpr(TLMDUnaryOp AOper);
	int __fastcall ParseIdentifier(void)/* overload */;
	int __fastcall ParseIdentifier(/* out */ System::WideString &AStrName)/* overload */;
	System::Word __fastcall ParseArrayType(void);
	
public:
	__fastcall TLMDPasParser(Lmdsctvmcompbase::ILMDParserCallbacks* ACbs);
	__fastcall virtual ~TLMDPasParser(void);
	virtual void __fastcall Parse(const System::WideString ASource);
	virtual Lmdsctvmcompbase::ILMDEmitable* __fastcall ParseStmt(const System::WideString ASource);
	virtual Lmdsctvmcompbase::ILMDEmitable* __fastcall ParseExpr(const System::WideString ASource);
	__property TLMDPasScanner* Scanner = {read=FScanner};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasLanguage : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
protected:
	Lmdsctvmcompbase::ILMDParserBase* __fastcall CreateParser(Lmdsctvmcompbase::ILMDParserCallbacks* ACbs);
	void __fastcall AddIntrinsics(Lmdsctvmcompbase::TLMDAddIntrinsicProc AProc);
	System::WideString __fastcall DebugEmpty(void);
	System::WideString __fastcall DebugNothing(void);
	System::WideString __fastcall DebugNull(void);
	System::WideString __fastcall DebugStrLiteral(const System::WideString S);
public:
	/* TObject.Create */ inline __fastcall TLMDPasLanguage(void) : System::TInterfacedObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPasLanguage(void) { }
	
private:
	void *__ILMDLanguage;	// Lmdsctvmcompbase::ILMDLanguage 
	
public:
	operator Lmdsctvmcompbase::ILMDLanguage*(void) { return (Lmdsctvmcompbase::ILMDLanguage*)&__ILMDLanguage; }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsctpascompiler */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTPASCOMPILER)
using namespace Lmdsctpascompiler;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctpascompilerHPP
