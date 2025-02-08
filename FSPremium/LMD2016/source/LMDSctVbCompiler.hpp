// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctVbCompiler.pas' rev: 31.00 (Windows)

#ifndef LmdsctvbcompilerHPP
#define LmdsctvbcompilerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.StrUtils.hpp>
#include <Vcl.Dialogs.hpp>
#include <Vcl.Controls.hpp>
#include <System.UITypes.hpp>
#include <LMDSctCst.hpp>
#include <LMDSctClass.hpp>
#include <LMDSctVMCompBase.hpp>
#include <LMDSctVMByteCode.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctvbcompiler
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDVbCompiler;
struct TLMDExitLabels;
struct TLMDContext;
class DELPHICLASS TLMDVbExpression;
class DELPHICLASS TLMDVbUnaryOpExpr;
class DELPHICLASS TLMDVbBinaryOpExpr;
class DELPHICLASS TLMDVbDesignatorItem;
class DELPHICLASS TLMDVbDesignatorExpr;
class DELPHICLASS TLMDVbNewExpr;
class DELPHICLASS TLMDVbLiteralExpr;
class DELPHICLASS TLMDVbStatement;
class DELPHICLASS TLMDVbStmtList;
class DELPHICLASS TLMDVbReturnStmt;
class DELPHICLASS TLMDVbCatchNamespace;
class DELPHICLASS TLMDVbCatch;
class DELPHICLASS TLMDVbTryStmt;
class DELPHICLASS TLMDVbThrowStmt;
class DELPHICLASS TLMDVbExpressionStmt;
class DELPHICLASS TLMDVbCaseSelector;
class DELPHICLASS TLMDVbSelectStmt;
class DELPHICLASS TLMDVbCallStmt;
class DELPHICLASS TLMDVbExitStmt;
class DELPHICLASS TLMDVbDimVarDecl;
class DELPHICLASS TLMDVbDimStmt;
class DELPHICLASS TLMDVbRedimVarDecl;
class DELPHICLASS TLMDVbRedimStmt;
class DELPHICLASS TLMDVbEraseStmt;
class DELPHICLASS TLMDVbAssignmentStmt;
class DELPHICLASS TLMDVbIfBlock;
class DELPHICLASS TLMDVbIfStmt;
class DELPHICLASS TLMDVbForStmt;
class DELPHICLASS TLMDVbDoLoopStmt;
class DELPHICLASS TLMDVbProcLocalNamespace;
class DELPHICLASS TLMDVbProcLocal;
class DELPHICLASS TLMDVbLocalVarDecl;
class DELPHICLASS TLMDVbLocalResultDecl;
class DELPHICLASS TLMDVbParamDecl;
class DELPHICLASS TLMDVbProcDecl;
struct TLMDVbTokenDescription;
class DELPHICLASS TVBScanner;
struct TLMDVbParserSavepoint;
class DELPHICLASS TLMDVbParser;
class DELPHICLASS TLMDVbLanguage;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDVbCompiler : public Lmdsctvmcompbase::ELMDCompileBase
{
	typedef Lmdsctvmcompbase::ELMDCompileBase inherited;
	
public:
	/* ELMDCompileBase.Create */ inline __fastcall ELMDVbCompiler(const System::WideString Msg, int ASourcePos) : Lmdsctvmcompbase::ELMDCompileBase(Msg, ASourcePos) { }
	/* ELMDCompileBase.CreateFmt */ inline __fastcall ELMDVbCompiler(const System::WideString Msg, const System::TVarRec *Args, const int Args_High, int ASourcePos) : Lmdsctvmcompbase::ELMDCompileBase(Msg, Args, Args_High, ASourcePos) { }
	
public:
	/* Exception.CreateRes */ inline __fastcall ELMDVbCompiler(NativeUInt Ident)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDVbCompiler(System::PResStringRec ResStringRec)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDVbCompiler(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDVbCompiler(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDVbCompiler(const System::UnicodeString Msg, int AHelpContext) : Lmdsctvmcompbase::ELMDCompileBase(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDVbCompiler(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : Lmdsctvmcompbase::ELMDCompileBase(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDVbCompiler(NativeUInt Ident, int AHelpContext)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDVbCompiler(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDVbCompiler(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDVbCompiler(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : Lmdsctvmcompbase::ELMDCompileBase(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDVbCompiler(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDExitLabels
{
public:
	Lmdsctvmbytecode::TLMDLabel* ProcL;
	Lmdsctvmbytecode::TLMDLabel* ForL;
	Lmdsctvmbytecode::TLMDLabel* DoL;
};


struct DECLSPEC_DRECORD TLMDContext
{
public:
	Lmdsctvmbytecode::TLMDByteCode* Code;
	Lmdsctvmbytecode::TLMDAbstractNamespace* CurNamespace;
	TLMDExitLabels CurExits;
	Lmdsctvmbytecode::TLMDTry* CurReraise;
};


enum DECLSPEC_DENUM TLMDExprEmitRes : unsigned char { erNoRes, erStack, erPopJmpIfTrue, erPopJmpIfFalse };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbExpression : public Lmdsctvmcompbase::ILMDEmitable
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
	/* TObject.Create */ inline __fastcall TLMDVbExpression(void) : Lmdsctvmcompbase::ILMDEmitable() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVbExpression(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDVbUnaryOp : unsigned char { uoPlus, uoMinus, uoNot };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbUnaryOpExpr : public TLMDVbExpression
{
	typedef TLMDVbExpression inherited;
	
private:
	TLMDVbUnaryOp FOpType;
	TLMDVbExpression* FOperand;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	
public:
	__fastcall TLMDVbUnaryOpExpr(TLMDVbUnaryOp OpType, TLMDVbExpression* Operand);
	__fastcall virtual ~TLMDVbUnaryOpExpr(void);
	__property TLMDVbUnaryOp OpType = {read=FOpType, nodefault};
	__property TLMDVbExpression* Operand = {read=FOperand};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDVbBinaryOp : unsigned char { boPlus, boMinus, boMult, boDivide, boIntDivide, boImp, boEqv, boXor, boOr, boAnd, boGreater, boGreaterEqual, boLess, boLessEqual, boEqual, boNotEqual, boStrConcat, boMod, boExp, boIs, boIsNot, boTypeOfIs };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbBinaryOpExpr : public TLMDVbExpression
{
	typedef TLMDVbExpression inherited;
	
private:
	TLMDVbExpression* FLeftExpr;
	TLMDVbExpression* FRightExpr;
	TLMDVbBinaryOp FOpType;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	
public:
	__fastcall TLMDVbBinaryOpExpr(TLMDVbExpression* ALeftExpr, TLMDVbExpression* ARightExpr, TLMDVbBinaryOp OpType);
	__fastcall virtual ~TLMDVbBinaryOpExpr(void);
	__property TLMDVbExpression* LeftExpr = {read=FLeftExpr};
	__property TLMDVbExpression* RightExpr = {read=FRightExpr};
	__property TLMDVbBinaryOp OpType = {read=FOpType, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbDesignatorItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FName;
	System::WideString FStrName;
	Lmdsctvmbytecode::TLMDBracketType FBracketType;
	System::Classes::TList* FArgs;
	int FSourcePos;
	bool FIsResultUsed;
	TLMDVbExpression* __fastcall GetArg(int AIndex);
	int __fastcall GetArgsCount(void);
	bool __fastcall GetIsNamed(void);
	void __fastcall SetName(int AName, const System::WideString AStrName);
	void __fastcall AddArgument(TLMDVbExpression* AExpression);
	void __fastcall ClearArgs(void);
	void __fastcall EmitArgs(TLMDContext &C);
	
public:
	__fastcall TLMDVbDesignatorItem(void);
	__fastcall virtual ~TLMDVbDesignatorItem(void);
	__property int Name = {read=FName, nodefault};
	__property System::WideString StrName = {read=FStrName};
	__property int SourcePos = {read=FSourcePos, nodefault};
	__property Lmdsctvmbytecode::TLMDBracketType BracketType = {read=FBracketType, nodefault};
	__property TLMDVbExpression* Args[int AIndex] = {read=GetArg};
	__property int ArgCount = {read=GetArgsCount, nodefault};
	__property bool IsNamed = {read=GetIsNamed, nodefault};
	__property bool IsResultUsed = {read=FIsResultUsed, nodefault};
};

#pragma pack(pop)

typedef bool __fastcall (__closure *TLMDVbGetCallInstr)(TLMDContext &C, TLMDVbDesignatorItem* AItem, /* out */ Lmdsctvmbytecode::TLMDInstr &AInstr, /* out */ bool &ANeedSlot);

typedef void __fastcall (__closure *TLMDVbEmitValue)(TLMDContext &C, TLMDVbDesignatorItem* AItem);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbDesignatorExpr : public TLMDVbExpression
{
	typedef TLMDVbExpression inherited;
	
public:
	TLMDVbDesignatorItem* operator[](int AInteger) { return this->Items[AInteger]; }
	
private:
	System::Classes::TList* FItems;
	TLMDVbDesignatorItem* __fastcall GetItems(int AIndex);
	int __fastcall GeItemCount(void);
	TLMDVbDesignatorItem* __fastcall GetLastItem(void);
	void __fastcall AddItem(void);
	void __fastcall ClearItems(void);
	Lmdsctvmbytecode::TLMDInstr __fastcall OptimizeCallInstr(TLMDContext &C, TLMDVbDesignatorItem* AItem, Lmdsctvmbytecode::TLMDInstrCode ACallInstr, bool AHasObject, bool AHasValue, /* out */ bool &ANeedSlot);
	void __fastcall InternalEmit(TLMDContext &C, bool ANeedRef, TLMDVbGetCallInstr AGetInstrProc = 0x0, TLMDVbEmitValue AEmitValueProc = 0x0);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	virtual void __fastcall DoEmitRefByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDVbDesignatorExpr(void);
	__fastcall TLMDVbDesignatorExpr(int AName, const System::WideString AStrName, int ASourcePos);
	__fastcall virtual ~TLMDVbDesignatorExpr(void);
	__property TLMDVbDesignatorItem* Items[int AInteger] = {read=GetItems/*, default*/};
	__property int ItemCount = {read=GeItemCount, nodefault};
	__property TLMDVbDesignatorItem* LastItem = {read=GetLastItem};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbNewExpr : public TLMDVbDesignatorExpr
{
	typedef TLMDVbDesignatorExpr inherited;
	
private:
	TLMDVbDesignatorItem* FNewCallItem;
	bool __fastcall NewCallInstrProc(TLMDContext &C, TLMDVbDesignatorItem* AItem, /* out */ Lmdsctvmbytecode::TLMDInstr &AInstr, /* out */ bool &ANeedSlot);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	virtual void __fastcall DoEmitRefByteCode(TLMDContext &C);
	
public:
	__property TLMDVbDesignatorItem* NewCallItem = {read=FNewCallItem};
public:
	/* TLMDVbDesignatorExpr.Create */ inline __fastcall TLMDVbNewExpr(void) : TLMDVbDesignatorExpr() { }
	/* TLMDVbDesignatorExpr.CreateSimple */ inline __fastcall TLMDVbNewExpr(int AName, const System::WideString AStrName, int ASourcePos) : TLMDVbDesignatorExpr(AName, AStrName, ASourcePos) { }
	/* TLMDVbDesignatorExpr.Destroy */ inline __fastcall virtual ~TLMDVbNewExpr(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDVbLiteralExpr : public TLMDVbExpression
{
	typedef TLMDVbExpression inherited;
	
private:
	System::OleVariant FValue;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C, TLMDExprEmitRes AEmitRes, Lmdsctvmbytecode::TLMDLabel* AJmpLabel, bool &AResInStack);
	
public:
	__fastcall TLMDVbLiteralExpr(const System::OleVariant &Value);
	__property System::OleVariant Value = {read=FValue};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVbLiteralExpr(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbStatement : public Lmdsctvmcompbase::ILMDEmitable
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
	/* TObject.Create */ inline __fastcall TLMDVbStatement(void) : Lmdsctvmcompbase::ILMDEmitable() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVbStatement(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbStmtList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDVbStatement* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	bool FOwnItems;
	System::Classes::TList* FItems;
	TLMDVbStatement* __fastcall GetItems(int AIndex);
	int __fastcall GetCount(void);
	
public:
	__fastcall TLMDVbStmtList(void)/* overload */;
	__fastcall TLMDVbStmtList(bool AOwnItems)/* overload */;
	__fastcall virtual ~TLMDVbStmtList(void);
	void __fastcall EmitByteCode(TLMDContext &C);
	void __fastcall Add(TLMDVbStatement* Statement);
	__property TLMDVbStatement* Items[int AIndex] = {read=GetItems/*, default*/};
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbReturnStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	TLMDVbExpression* FExpr;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall virtual ~TLMDVbReturnStmt(void);
	__property TLMDVbExpression* Expr = {read=FExpr};
public:
	/* TObject.Create */ inline __fastcall TLMDVbReturnStmt(void) : TLMDVbStatement() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbCatchNamespace : public Lmdsctvmbytecode::TLMDAbstractNamespace
{
	typedef Lmdsctvmbytecode::TLMDAbstractNamespace inherited;
	
private:
	TLMDVbCatch* FCatch;
	int FVarIndex;
	
public:
	__fastcall TLMDVbCatchNamespace(Lmdsctvmbytecode::TLMDAbstractNamespace* AParent, TLMDVbCatch* ACatch, int AVarIndex);
	virtual Lmdsctvmbytecode::TLMDNameSearchRes __fastcall Find(void * AThread, int AName, System::PWideString AStrName);
	virtual void __fastcall EnumDebugVars(bool ALocalsOnly, Lmdsctvmbytecode::TLMDNamespaceEnumVarsProc AProc);
	virtual Lmdsctvmbytecode::TLMDNameSearchRes __fastcall CompileTimeFind(int AName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVbCatchNamespace(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbCatch : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FName;
	System::WideString FStrName;
	TLMDVbExpression* FExpr;
	TLMDVbStmtList* FStmts;
	TLMDVbCatchNamespace* FNamespace;
	bool __fastcall GetHasAs(void);
	Lmdsctvmbytecode::TLMDAbstractNamespace* __fastcall CreateNS(Lmdsctvmbytecode::TLMDAbstractNamespace* AParent, int AVarIndex);
	
public:
	__fastcall TLMDVbCatch(int AName, const System::WideString AStrName)/* overload */;
	__fastcall TLMDVbCatch(void)/* overload */;
	__fastcall virtual ~TLMDVbCatch(void);
	__property int Name = {read=FName, nodefault};
	__property bool HasAs = {read=GetHasAs, nodefault};
	__property System::WideString StrName = {read=FStrName};
	__property TLMDVbExpression* Expr = {read=FExpr};
	__property TLMDVbStmtList* Stmts = {read=FStmts};
	__property TLMDVbCatchNamespace* Namespace = {read=FNamespace};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbTryStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	TLMDVbStmtList* FTryStmts;
	System::Classes::TList* FCatches;
	TLMDVbStmtList* FFinallyStmts;
	int __fastcall GetCatchCount(void);
	TLMDVbCatch* __fastcall GetCatches(int AIndex);
	void __fastcall AddCatch(TLMDVbCatch* ACatch);
	void __fastcall EmitTryFinally(TLMDContext &C);
	void __fastcall EmitTryCatch(TLMDContext &C);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDVbTryStmt(void);
	__fastcall virtual ~TLMDVbTryStmt(void);
	__property TLMDVbStmtList* TryStmts = {read=FTryStmts};
	__property int CatchCount = {read=GetCatchCount, nodefault};
	__property TLMDVbCatch* Catches[int AIndex] = {read=GetCatches};
	__property TLMDVbStmtList* FinallyStmts = {read=FFinallyStmts};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbThrowStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	TLMDVbExpression* FExpr;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall virtual ~TLMDVbThrowStmt(void);
	__property TLMDVbExpression* Expr = {read=FExpr};
public:
	/* TObject.Create */ inline __fastcall TLMDVbThrowStmt(void) : TLMDVbStatement() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbExpressionStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	TLMDVbExpression* FExpr;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDVbExpressionStmt(TLMDVbExpression* AExpr);
	__fastcall virtual ~TLMDVbExpressionStmt(void);
	__property TLMDVbExpression* Expr = {read=FExpr};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbCaseSelector : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FLabels;
	TLMDVbStmtList* FStmts;
	int FSourcePos;
	TLMDVbExpression* __fastcall GetLabels(int AIndex);
	int __fastcall GetLabelCount(void);
	void __fastcall AddLabel(TLMDVbExpression* AExpr);
	
public:
	__fastcall TLMDVbCaseSelector(void);
	__fastcall virtual ~TLMDVbCaseSelector(void);
	__property int SourcePos = {read=FSourcePos, nodefault};
	__property TLMDVbExpression* Labels[int AIndex] = {read=GetLabels};
	__property int LabelCount = {read=GetLabelCount, nodefault};
	__property TLMDVbStmtList* StmtList = {read=FStmts};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbSelectStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	TLMDVbExpression* FExpr;
	System::Classes::TList* FSelectors;
	TLMDVbStmtList* FElseStmts;
	TLMDVbCaseSelector* __fastcall GetSelectors(int AIndex);
	int __fastcall GetSelectorCount(void);
	void __fastcall AddSelector(TLMDVbCaseSelector* ASelector);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDVbSelectStmt(void);
	__fastcall virtual ~TLMDVbSelectStmt(void);
	__property TLMDVbExpression* Expr = {read=FExpr};
	__property TLMDVbCaseSelector* Selectors[int AIndex] = {read=GetSelectors};
	__property int SelectorCount = {read=GetSelectorCount, nodefault};
	__property TLMDVbStmtList* ElseStmts = {read=FElseStmts};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbCallStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	TLMDVbDesignatorExpr* FDesignator;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDVbCallStmt(TLMDVbDesignatorExpr* Designator);
	__fastcall virtual ~TLMDVbCallStmt(void);
	__property TLMDVbDesignatorExpr* Designator = {read=FDesignator};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDVbExitType : unsigned char { etFor, etDo, etFunction, etSub };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbExitStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	TLMDVbExitType FExitType;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDVbExitStmt(TLMDVbExitType ExitType);
	__property TLMDVbExitType ExitType = {read=FExitType, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVbExitStmt(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbDimVarDecl : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FIdentifier;
	bool FIsArray;
	System::Classes::TList* FArrayDims;
	int FSourcePos;
	System::TObject* FVar;
	System::Word FElemType;
	TLMDVbExpression* FIniter;
	TLMDVbExpression* __fastcall GetArrayDims(int AIndex);
	int __fastcall GetArrayDimCount(void);
	void __fastcall AddArrayDim(TLMDVbExpression* AExpr);
	void __fastcall EmitArrayDims(TLMDContext &C);
	
public:
	__fastcall TLMDVbDimVarDecl(int AIdentifier);
	__fastcall virtual ~TLMDVbDimVarDecl(void);
	__property int SourcePos = {read=FSourcePos, nodefault};
	__property int Identifier = {read=FIdentifier, nodefault};
	__property bool IsArray = {read=FIsArray, nodefault};
	__property System::Word ElemType = {read=FElemType, nodefault};
	__property TLMDVbExpression* ArrayDims[int AIndex] = {read=GetArrayDims};
	__property int ArrayDimCount = {read=GetArrayDimCount, nodefault};
	__property TLMDVbExpression* Initer = {read=FIniter};
	__property System::TObject* Var_ = {read=FVar};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbDimStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	System::Classes::TList* FVarDecls;
	TLMDVbDimVarDecl* __fastcall GetVarDecls(int AIndex);
	int __fastcall GetVarDeclCount(void);
	void __fastcall AddVarDecl(TLMDVbDimVarDecl* AVarDecl);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDVbDimStmt(void);
	__fastcall virtual ~TLMDVbDimStmt(void);
	__property TLMDVbDimVarDecl* VarDecls[int AIndex] = {read=GetVarDecls};
	__property int VarDeclCount = {read=GetVarDeclCount, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbRedimVarDecl : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDVbDesignatorExpr* FVarExpr;
	System::Classes::TList* FArrayDims;
	int FSourcePos;
	System::Word FElemType;
	TLMDVbExpression* __fastcall GetArrayDims(int AIndex);
	int __fastcall GetArrayDimCount(void);
	void __fastcall AddArrayDim(TLMDVbExpression* AExpr);
	void __fastcall EmitArrayDims(TLMDContext &C);
	
public:
	__fastcall TLMDVbRedimVarDecl(void);
	__fastcall virtual ~TLMDVbRedimVarDecl(void);
	__property int SourcePos = {read=FSourcePos, nodefault};
	__property TLMDVbDesignatorExpr* VarExpr = {read=FVarExpr};
	__property System::Word ElemType = {read=FElemType, nodefault};
	__property TLMDVbExpression* ArrayDims[int AIndex] = {read=GetArrayDims};
	__property int ArrayDimCount = {read=GetArrayDimCount, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbRedimStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	bool FPreserve;
	System::Classes::TList* FVarDecls;
	TLMDVbRedimVarDecl* __fastcall GetVarDecls(int AIndex);
	int __fastcall GetVarDeclCount(void);
	void __fastcall AddVarDecl(TLMDVbRedimVarDecl* AVarDecl);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDVbRedimStmt(bool APreserve);
	__fastcall virtual ~TLMDVbRedimStmt(void);
	__property bool Preserve = {read=FPreserve, nodefault};
	__property TLMDVbRedimVarDecl* VarDecls[int AIndex] = {read=GetVarDecls};
	__property int VarDeclCount = {read=GetVarDeclCount, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbEraseStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	TLMDVbDesignatorExpr* FExpr;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall virtual ~TLMDVbEraseStmt(void);
	__property TLMDVbDesignatorExpr* Expr = {read=FExpr};
public:
	/* TObject.Create */ inline __fastcall TLMDVbEraseStmt(void) : TLMDVbStatement() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbAssignmentStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	TLMDVbDesignatorExpr* FLeftExpr;
	TLMDVbExpression* FRightExpr;
	bool __fastcall AsgnCallInstrProc(TLMDContext &C, TLMDVbDesignatorItem* AItem, /* out */ Lmdsctvmbytecode::TLMDInstr &AInstr, /* out */ bool &ANeedSlot);
	void __fastcall EmitValueProc(TLMDContext &C, TLMDVbDesignatorItem* AItem);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall virtual ~TLMDVbAssignmentStmt(void);
	__property TLMDVbDesignatorExpr* LeftExpr = {read=FLeftExpr};
	__property TLMDVbExpression* RightExpr = {read=FRightExpr};
public:
	/* TObject.Create */ inline __fastcall TLMDVbAssignmentStmt(void) : TLMDVbStatement() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbIfBlock : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDVbExpression* FCondition;
	TLMDVbStmtList* FStmtList;
	int FSourcePos;
	
public:
	__fastcall TLMDVbIfBlock(TLMDVbExpression* Condition);
	__fastcall virtual ~TLMDVbIfBlock(void);
	__property int SourcePos = {read=FSourcePos, nodefault};
	__property TLMDVbExpression* Condition = {read=FCondition};
	__property TLMDVbStmtList* StmtList = {read=FStmtList};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbIfStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	System::Classes::TList* FBlocks;
	TLMDVbStmtList* FElseStmtList;
	TLMDVbIfBlock* __fastcall GetIfBlock(int AIndex);
	int __fastcall GetIfBlocksCount(void);
	TLMDVbIfBlock* __fastcall GetLastBlock(void);
	void __fastcall AddBlock(TLMDVbExpression* Condition);
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDVbIfStmt(void);
	__fastcall virtual ~TLMDVbIfStmt(void);
	__property TLMDVbIfBlock* Blocks[int AIndex] = {read=GetIfBlock};
	__property TLMDVbIfBlock* LastBlock = {read=GetLastBlock};
	__property int BlocksCount = {read=GetIfBlocksCount, nodefault};
	__property TLMDVbStmtList* ElseStmtList = {read=FElseStmtList};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbForStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	TLMDVbDesignatorExpr* FVarExpr;
	TLMDVbExpression* FFromExpr;
	TLMDVbExpression* FToExpr;
	TLMDVbExpression* FStepExpr;
	TLMDVbStmtList* FStmts;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDVbForStmt(void);
	__fastcall virtual ~TLMDVbForStmt(void);
	__property TLMDVbDesignatorExpr* VarExpr = {read=FVarExpr};
	__property TLMDVbExpression* FromExpr = {read=FFromExpr};
	__property TLMDVbExpression* ToExpr = {read=FToExpr};
	__property TLMDVbExpression* StepExpr = {read=FStepExpr};
	__property TLMDVbStmtList* Stmts = {read=FStmts};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDVbLoopType : unsigned char { ltWhile, ltUntil };

enum DECLSPEC_DENUM TLMDVbConditionCheck : unsigned char { ccNoCondition, ccBeforeStmts, ccAfterStmts };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbDoLoopStmt : public TLMDVbStatement
{
	typedef TLMDVbStatement inherited;
	
private:
	TLMDVbLoopType FLoopType;
	TLMDVbConditionCheck FCondCheck;
	TLMDVbExpression* FExpr;
	TLMDVbStmtList* FStmts;
	
protected:
	virtual void __fastcall DoEmitByteCode(TLMDContext &C);
	
public:
	__fastcall TLMDVbDoLoopStmt(void);
	__fastcall virtual ~TLMDVbDoLoopStmt(void);
	__property TLMDVbLoopType LoopType = {read=FLoopType, nodefault};
	__property TLMDVbConditionCheck CondCheck = {read=FCondCheck, nodefault};
	__property TLMDVbExpression* Expr = {read=FExpr};
	__property TLMDVbStmtList* Stmts = {read=FStmts};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbProcLocalNamespace : public Lmdsctvmbytecode::TLMDAbstractNamespace
{
	typedef Lmdsctvmbytecode::TLMDAbstractNamespace inherited;
	
private:
	TLMDVbProcDecl* FProc;
	
public:
	__fastcall TLMDVbProcLocalNamespace(Lmdsctvmbytecode::TLMDAbstractNamespace* AParent, TLMDVbProcDecl* AProc);
	virtual Lmdsctvmbytecode::TLMDNameSearchRes __fastcall Find(void * AThread, int AName, System::PWideString AStrName);
	virtual void __fastcall EnumDebugVars(bool ALocalsOnly, Lmdsctvmbytecode::TLMDNamespaceEnumVarsProc AProc);
	virtual Lmdsctvmbytecode::TLMDNameSearchRes __fastcall CompileTimeFind(int AName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVbProcLocalNamespace(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDVbProcLocalType : unsigned char { ltVar, ltResult, ltParam };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbProcLocal : public Lmdsctclass::TLMDNamedItem
{
	typedef Lmdsctclass::TLMDNamedItem inherited;
	
private:
	System::WideString FStrName;
	TLMDVbProcLocalType FLocalType;
	
public:
	__fastcall TLMDVbProcLocal(TLMDVbProcLocalType ALocalType, int AName, const System::WideString AStrName);
	__property TLMDVbProcLocalType LocalType = {read=FLocalType, nodefault};
	__property System::WideString StrName = {read=FStrName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVbProcLocal(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbLocalVarDecl : public TLMDVbProcLocal
{
	typedef TLMDVbProcLocal inherited;
	
private:
	int FIndex;
	
public:
	__fastcall TLMDVbLocalVarDecl(int AName, const System::WideString AStrName)/* overload */;
	__property int Index = {read=FIndex, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVbLocalVarDecl(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbLocalResultDecl : public TLMDVbProcLocal
{
	typedef TLMDVbProcLocal inherited;
	
public:
	__fastcall TLMDVbLocalResultDecl(int AName, const System::WideString AStrName);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVbLocalResultDecl(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbParamDecl : public TLMDVbProcLocal
{
	typedef TLMDVbProcLocal inherited;
	
private:
	Lmdsctvmbytecode::TLMDParamInfo FParamInfo;
	
public:
	__fastcall TLMDVbParamDecl(int AName, const System::WideString AStrName, Lmdsctvmbytecode::TLMDParamKind AParamKind)/* overload */;
	__property Lmdsctvmbytecode::TLMDParamInfo ParamInfo = {read=FParamInfo};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVbParamDecl(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDVbProcKind : unsigned char { pkFunction, pkSub };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbProcDecl : public Lmdsctvmcompbase::TLMDProcObject
{
	typedef Lmdsctvmcompbase::TLMDProcObject inherited;
	
private:
	TLMDVbProcKind FProcKind;
	TLMDVbProcLocalNamespace* FLocalNamespace;
	Lmdsctclass::TLMDNameHashTable* FLocalMap;
	System::Classes::TList* FParams;
	System::Classes::TList* FLocalVars;
	TLMDVbLocalResultDecl* FLocalResult;
	TLMDVbStmtList* FStmtList;
	int FSourcePos;
	int FEndSourcePos;
	int __fastcall GetLocalVarCount(void);
	TLMDVbLocalVarDecl* __fastcall GetLocalVars(int AIndex);
	TLMDVbParamDecl* __fastcall GetParams(int AIndex);
	bool __fastcall AddLocalItem(TLMDVbProcLocal* AItem);
	Lmdsctvmbytecode::TLMDAbstractNamespace* __fastcall CreateNS(Lmdsctvmbytecode::TLMDAbstractNamespace* AParent);
	
public:
	__fastcall TLMDVbProcDecl(int AName, const System::WideString AStrName, TLMDVbProcKind AProcKind);
	__fastcall virtual ~TLMDVbProcDecl(void);
	virtual void __fastcall EmitByteCode(Lmdsctvmbytecode::TLMDAbstractNamespace* AGlobalNamespace);
	__property int SourcePos = {read=FSourcePos, nodefault};
	__property int EndSourcePos = {read=FEndSourcePos, nodefault};
	__property TLMDVbProcKind ProcKind = {read=FProcKind, nodefault};
	__property TLMDVbParamDecl* Params[int AIndex] = {read=GetParams};
	__property ParamCount;
	__property TLMDVbLocalVarDecl* LocalVars[int AIndex] = {read=GetLocalVars};
	__property int LocalVarCount = {read=GetLocalVarCount, nodefault};
	__property TLMDVbLocalResultDecl* LocalResult = {read=FLocalResult};
	__property TLMDVbProcLocalNamespace* LocalNamespace = {read=FLocalNamespace};
	__property TLMDVbStmtList* StmtList = {read=FStmtList};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDVbToken : unsigned char { ptIdentifier, ptCString, ptCInteger, ptCFloat, ptCDate, ptImp, ptEqv, ptXor, ptOr, ptAnd, ptNot, ptTypeOf, ptIs, ptGreater, ptGreaterEqual, ptLess, ptLessEqual, ptEqual, ptAssignment, ptNotEqual, ptStrConcat, ptPlus, ptMinus, ptMultiply, ptDivide, ptIntDivide, ptMod, ptExp, ptOpenRound, ptCloseRound, ptComma, ptColon, ptDot, ptTrue, ptFalse, ptNothing, ptEmpty, ptNull, ptDim, ptSet, ptRedim, ptPreserve, ptFor, ptTo, ptStep, ptNext, ptIf, ptThen, ptElse, ptElseIf, ptEnd, ptDo, ptLoop, ptWhile, ptUntil, ptFunction, ptSub, ptByRef, ptByVal, ptErase, ptCall, prSelect, ptCase, ptExit, ptTry, ptCatch, ptAs, ptFinally, ptThrow, ptReturn, ptNew, ptComment, ptHiddenEOl, ptEOl, ptEOf };

typedef System::Set<TLMDVbToken, TLMDVbToken::ptIdentifier, TLMDVbToken::ptEOf> TLMDVbTokens;

typedef System::WideChar * TLMDVbScannerSavepoint;

struct DECLSPEC_DRECORD TLMDVbTokenDescription
{
public:
	System::WideString S;
	bool IsKeyword;
};


class PASCALIMPLEMENTATION TVBScanner : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::WideString FStrSource;
	System::WideChar *FSource;
	System::WideChar *FCurChar;
	bool FSkipComments;
	TLMDVbToken FToken;
	int FTokenStartPos;
	System::WideString FSData;
	int FIData;
	System::Extended FFData;
	System::TDateTime FDData;
	int FTokenEndPos;
	bool FLastEOlSkipped;
	void __fastcall NextChar(void);
	int __fastcall GetCurCharPos(void);
	void __fastcall SkipBlanks(void);
	void __fastcall ScanToken(void);
	TLMDVbToken __fastcall ScanNumber(bool ALLowFloat, /* out */ int &IntVal, /* out */ System::Extended &FloatVal);
	TLMDVbToken __fastcall ScanHexNumber(bool ALLowFloat, /* out */ int &IntVal, /* out */ System::Extended &FloatVal);
	System::WideString __fastcall ScanIdentifier(void);
	System::WideString __fastcall ScanBracketIdentifier(void);
	System::WideString __fastcall ScanString(void);
	void __fastcall ScanHiddenEOl(void);
	TLMDVbToken __fastcall ScanDate(System::TDateTime &ADate);
	TLMDVbToken __fastcall DetectReservedWord(const System::WideString Token);
	void __fastcall NextToken(void);
	
public:
	__fastcall TVBScanner(bool SkipComments);
	__fastcall virtual ~TVBScanner(void);
	System::WideString __fastcall TokenToStr(TLMDVbToken Token);
	System::WideChar * __fastcall GetSavepoint(void);
	void __fastcall Rollback(const System::WideChar * S);
	void __fastcall Start(const System::WideString Source);
	void __fastcall SkipToken(void);
	__property TLMDVbToken Token = {read=FToken, nodefault};
	__property int TokenStartPos = {read=FTokenStartPos, nodefault};
	__property int TokenEndPos = {read=FTokenEndPos, nodefault};
	__property System::WideString SData = {read=FSData};
	__property int IData = {read=FIData, nodefault};
	__property System::Extended FData = {read=FFData};
	__property System::TDateTime DData = {read=FDData};
};


enum DECLSPEC_DENUM TLMDVbParserTryState : unsigned char { ptsNowhere, ptsInTry, ptsInCatch, ptsInFinally };

typedef System::StaticArray<int, 4> TLMDVbParserExitCounts;

struct DECLSPEC_DRECORD TLMDVbParserSavepoint
{
public:
	System::WideChar *ScannerSP;
	int LastSkippedPos;
	TLMDVbProcDecl* CurrentProc;
	TLMDVbParserExitCounts ExitPntCounts;
	int OnlyColonBRCount;
	TLMDVbParserTryState TryState;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbParser : public Lmdsctvmcompbase::ILMDParserBase
{
	typedef Lmdsctvmcompbase::ILMDParserBase inherited;
	
private:
	Lmdsctvmcompbase::ILMDParserCallbacks* FCbs;
	TVBScanner* FScanner;
	int FLastSkippedPos;
	TLMDVbProcDecl* FCurrentProc;
	TLMDVbParserExitCounts FExitPntCounts;
	int FOnlyColonBRCount;
	TLMDVbParserTryState FTryState;
	TLMDVbToken __fastcall GetCurToken(void);
	TLMDVbParserSavepoint __fastcall GetSavepoint(void);
	void __fastcall Rollback(const TLMDVbParserSavepoint &ASavepoint);
	void __fastcall DoAddGlobalObject(Lmdsctvmcompbase::TLMDGlobalObject* AObj);
	void __fastcall DoAddProcLocal(TLMDVbProcLocal* AItem, TLMDVbProcDecl* AProc);
	System::TObject* __fastcall DoAddDimVar(int AName, const System::WideString AStrName);
	System::OleVariant __fastcall VbNothing(void);
	
protected:
	void __fastcall InvalidTokenError(TLMDVbToken AToken);
	void __fastcall StrExpectedError(const System::UnicodeString AStr);
	void __fastcall StrError(const System::UnicodeString AStr);
	void __fastcall CheckTokens(const TLMDVbTokens &ATokens);
	void __fastcall CheckAndSkipTokens(const TLMDVbTokens &ATokens);
	void __fastcall SkipToken(void);
	__property TLMDVbToken CurToken = {read=GetCurToken, nodefault};
	void __fastcall ParseUnit(void);
	void __fastcall ParseDecl(void);
	void __fastcall ParseStmtList(TLMDVbStmtList* StmtList);
	TLMDVbStatement* __fastcall ParseStatement(void);
	void __fastcall ParseProcDecl(void);
	void __fastcall ParseParamList(TLMDVbProcDecl* AProcDecl);
	Lmdsctvmbytecode::TLMDParamKind __fastcall ParseParamModifier(void);
	TLMDVbTryStmt* __fastcall ParseTryStmt(void);
	TLMDVbThrowStmt* __fastcall ParseThrowStmt(void);
	TLMDVbReturnStmt* __fastcall ParseReturnStmt(void);
	TLMDVbDoLoopStmt* __fastcall ParseDoLoopStmt(void);
	void __fastcall ParseWUExpr(TLMDVbDoLoopStmt* ADoLoopStmt);
	TLMDVbIfStmt* __fastcall ParseIfStmt(void);
	TLMDVbForStmt* __fastcall ParseForStmt(void);
	TLMDVbExitStmt* __fastcall ParseExitStmt(void);
	TLMDVbSelectStmt* __fastcall ParseSelectStmt(void);
	TLMDVbCallStmt* __fastcall ParseCallStmt(void);
	TLMDVbEraseStmt* __fastcall ParseEraseStmt(void);
	TLMDVbAssignmentStmt* __fastcall ParseSetStmt(void);
	TLMDVbDimStmt* __fastcall ParseDimStmt(void);
	TLMDVbDimVarDecl* __fastcall ParseDimVarDecl(void);
	TLMDVbRedimStmt* __fastcall ParseRedimStmt(void);
	TLMDVbRedimVarDecl* __fastcall ParseRedimVarDecl(void);
	void __fastcall ParseArrayDim(TLMDVbDimVarDecl* ArrayDecl);
	TLMDVbStatement* __fastcall ParseExprStmt(void);
	TLMDVbExpression* __fastcall ParseExpression(void);
	TLMDVbExpression* __fastcall ParseEqvExpr(void);
	TLMDVbExpression* __fastcall ParseXorExpr(void);
	TLMDVbExpression* __fastcall ParseOrExpr(void);
	TLMDVbExpression* __fastcall ParseAndExpr(void);
	TLMDVbExpression* __fastcall ParseCompareExpr(void);
	TLMDVbBinaryOp __fastcall ParseCompareOp(void);
	TLMDVbExpression* __fastcall ParseTypeOfExpr(void);
	TLMDVbExpression* __fastcall ParseConcatExpr(void);
	TLMDVbExpression* __fastcall ParseAddExpr(void);
	TLMDVbBinaryOp __fastcall ParseAddOp(void);
	TLMDVbExpression* __fastcall ParseModExpr(void);
	TLMDVbExpression* __fastcall ParseMultIntExpr(void);
	TLMDVbExpression* __fastcall ParseMultExpr(void);
	TLMDVbBinaryOp __fastcall ParseMultOp(void);
	TLMDVbExpression* __fastcall ParseExpExpr(void);
	TLMDVbExpression* __fastcall ParseValueExpr(void);
	TLMDVbNewExpr* __fastcall ParseNewExpr(void);
	TLMDVbDesignatorExpr* __fastcall ParseDesignator(void)/* overload */;
	TLMDVbDesignatorExpr* __fastcall ParseDesignator(/* out */ int &ArgCount, /* out */ bool &HasRound)/* overload */;
	void __fastcall ParseDesignatorTail(TLMDVbDesignatorExpr* AExpr, /* out */ int &ArgCount, /* out */ bool &HasRound);
	void __fastcall ParseArguments(TLMDVbDesignatorItem* AItem, /* out */ int &ArgCount);
	bool __fastcall IsBR(void);
	void __fastcall ParseBR(void);
	int __fastcall ParseIdentifier(void)/* overload */;
	int __fastcall ParseIdentifier(/* out */ System::WideString &AStrName)/* overload */;
	System::Word __fastcall ParseArrayType(void);
	
public:
	__fastcall TLMDVbParser(Lmdsctvmcompbase::ILMDParserCallbacks* ACbs);
	__fastcall virtual ~TLMDVbParser(void);
	virtual void __fastcall Parse(const System::WideString ASource);
	virtual Lmdsctvmcompbase::ILMDEmitable* __fastcall ParseStmt(const System::WideString ASource);
	virtual Lmdsctvmcompbase::ILMDEmitable* __fastcall ParseExpr(const System::WideString ASource);
	__property TVBScanner* Scanner = {read=FScanner};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVbLanguage : public System::TInterfacedObject
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
	/* TObject.Create */ inline __fastcall TLMDVbLanguage(void) : System::TInterfacedObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVbLanguage(void) { }
	
private:
	void *__ILMDLanguage;	// Lmdsctvmcompbase::ILMDLanguage 
	
public:
	operator Lmdsctvmcompbase::ILMDLanguage*(void) { return (Lmdsctvmcompbase::ILMDLanguage*)&__ILMDLanguage; }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::ResourceString _SStrExpected;
#define Lmdsctvbcompiler_SStrExpected System::LoadResourceString(&Lmdsctvbcompiler::_SStrExpected)
extern DELPHI_PACKAGE System::ResourceString _SInvalidToken;
#define Lmdsctvbcompiler_SInvalidToken System::LoadResourceString(&Lmdsctvbcompiler::_SInvalidToken)
extern DELPHI_PACKAGE System::ResourceString _SLMDWrongDate;
#define Lmdsctvbcompiler_SLMDWrongDate System::LoadResourceString(&Lmdsctvbcompiler::_SLMDWrongDate)
extern DELPHI_PACKAGE System::ResourceString _SLMDUnterminatedIdent;
#define Lmdsctvbcompiler_SLMDUnterminatedIdent System::LoadResourceString(&Lmdsctvbcompiler::_SLMDUnterminatedIdent)
extern DELPHI_PACKAGE System::ResourceString _SLMDEmptyIdent;
#define Lmdsctvbcompiler_SLMDEmptyIdent System::LoadResourceString(&Lmdsctvbcompiler::_SLMDEmptyIdent)
extern DELPHI_PACKAGE System::ResourceString _SLMDInvalidExit;
#define Lmdsctvbcompiler_SLMDInvalidExit System::LoadResourceString(&Lmdsctvbcompiler::_SLMDInvalidExit)
}	/* namespace Lmdsctvbcompiler */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTVBCOMPILER)
using namespace Lmdsctvbcompiler;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctvbcompilerHPP
