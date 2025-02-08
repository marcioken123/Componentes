// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctVMByteCode.pas' rev: 31.00 (Windows)

#ifndef LmdsctvmbytecodeHPP
#define LmdsctvmbytecodeHPP

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
#include <Winapi.ActiveX.hpp>
#include <LMDTypes.hpp>
#include <LMDSctCst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctvmbytecode
{
//-- forward type declarations -----------------------------------------------
struct TLMDParamInfo;
struct TLMDNameSearchRes;
class DELPHICLASS TLMDAbstractNamespace;
struct TLMDInstr;
class DELPHICLASS TLMDLabel;
class DELPHICLASS TLMDCall;
class DELPHICLASS TLMDTry;
class DELPHICLASS TLMDExcJump;
class DELPHICLASS TLMDFor;
class DELPHICLASS TLMDArray;
class DELPHICLASS TLMDArrayRedim;
class DELPHICLASS TLMDByteCode;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDNameSearchResKind : unsigned char { srNotFound, srExternal, srExternalMember, srUnit, srGlobalVar, srGlobalConst, srProcedure, srLocalVar, srLocalConst, srParam, srResult, srExit, srBreak, srContinue, srIntrinsic, srDebugVar };

enum DECLSPEC_DENUM TLMDParamKind : unsigned char { pkSimple, pkConst, pkByRef };

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDParamInfo
{
public:
	System::Word Index;
	System::Word Kind;
};
#pragma pack(pop)


struct DECLSPEC_DRECORD TLMDNameSearchRes
{
public:
	TLMDNameSearchResKind ObjKind;
	
public:
	union
	{
		struct 
		{
			System::OleVariant *DebugVar;
		};
		struct 
		{
			TLMDParamInfo ParamInfo;
		};
		struct 
		{
			System::OleVariant *LocalConst;
		};
		struct 
		{
			int LocalVarIndex;
		};
		struct 
		{
			System::TObject* NamedObject;union
			{
				struct 
				{
					int DispId;
				};
				
			};
		};
		
	};
};


typedef void __fastcall (__closure *TLMDNamespaceEnumVarsProc)(const System::WideString ADisplayName, const TLMDNameSearchRes &ASRes);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDAbstractNamespace : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDAbstractNamespace* FParent;
	
public:
	__fastcall TLMDAbstractNamespace(TLMDAbstractNamespace* AParent);
	virtual TLMDNameSearchRes __fastcall Find(void * AThread, int AName, System::PWideString AStrName) = 0 ;
	virtual void __fastcall EnumDebugVars(bool ALocalsOnly, TLMDNamespaceEnumVarsProc AProc) = 0 ;
	virtual TLMDNameSearchRes __fastcall CompileTimeFind(int AName);
	__property TLMDAbstractNamespace* Parent = {read=FParent};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDAbstractNamespace(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDInstrCode : unsigned char { icBreak, icBreakpointJmp, icRet, icJump, icPop, icPush, icPush0, icPushUnassigned, icPushLiteral, icPushLocalVar, icPushLocalConst, icPushArg, icPushResult, icPushLocalVarRef, icPushArgRef, icPushResultRef, icGreater, icGreaterEqual, icLess, icLessEqual, icIn, icIs, icEqual, icRefEqual, icNotEqual, icRefNotEqual, icPlus, icStrConcat, icMinus, icImp, icEqv, icOr, icXor, icMultiply, icDivide, icIntDiv, icMod, icAnd, icShl, icShr, icPower, icUnaryPlus, icUnaryMinus, icUnaryNot, icJmpIfTrue, icJmpIfFalse, icPopJmpIfTrue, icPopJmpIfFalse, icPopJmpIfEqual, icPopJmpIfNotEqual, icAddValToSet, icAddRangeToSet, icGlobCall, icMemberCall, icUnnamedCall, icGlobCallRef, icMemberCallRef, icUnnamedCallRef, icNewUnnamedCall, 
	icAssignGlobCall, icAssignMemberCall, icAssignUnnamedCall, icAssignLValue, icAssignLocalVar, icAssignArg, icAssignResult, icAssignGlobalVar, icAssignGlobalConst, icForInitLValue, icForInitLocal, icForInc, icForIncStep, icForDec, icForJmpIfLE, icForJmpIfGE, icForJmpStep, icCaseJmpIfEqual, icCaseJmpIfInRange, icRaise, isReraise, icRaiseEBCFromFinally, icCallFinally, icFinallyRet, icExceptJmpIfIs, icExceptDone, icExceptToVar, icSetNamespace, icArrayCreate, icArrayRedimLValue, icArrayRedimLocal, icEventHandlerMake };

typedef TLMDInstr *PLMDInstr;

struct DECLSPEC_DRECORD TLMDInstr
{
public:
	TLMDInstrCode Code;
	System::TObject* Data;
	System::Int8 TryIndex;
	unsigned SourceInfo;
};


typedef System::StaticArray<TLMDInstr, 1025> TLMDInstrs;

typedef TLMDInstrs *PLMDInstrs;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLabel : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDInstr *FTarget;
	
public:
	__property PLMDInstr Target = {read=FTarget};
public:
	/* TObject.Create */ inline __fastcall TLMDLabel(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDLabel(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDBracketType : unsigned char { bkNon, bkVbRound, bkRound, bkBlock };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCall : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FName;
	System::WideString FStrName;
	TLMDBracketType FBracketType;
	int FArgCount;
	int FArgsOffset;
	int FResOffset;
	int FObjectOffset;
	unsigned FResMask;
	TLMDLabel* FBreakLabel;
	TLMDLabel* FContinueLabel;
	TLMDLabel* FExitLabel;
	void __fastcall CalcOffsets(bool AHasObject, bool AHasValue);
	
public:
	__property int Name = {read=FName, nodefault};
	__property System::WideString StrName = {read=FStrName};
	__property int ArgCount = {read=FArgCount, nodefault};
	__property TLMDBracketType BracketType = {read=FBracketType, nodefault};
	__property int ObjectOffset = {read=FObjectOffset, nodefault};
	__property int ArgsOffset = {read=FArgsOffset, nodefault};
	__property int ResOffset = {read=FResOffset, nodefault};
	__property unsigned ResMask = {read=FResMask, nodefault};
	__property TLMDLabel* BreakLabel = {read=FBreakLabel, write=FBreakLabel};
	__property TLMDLabel* ContinueLabel = {read=FContinueLabel, write=FContinueLabel};
	__property TLMDLabel* ExitLabel = {read=FExitLabel, write=FExitLabel};
public:
	/* TObject.Create */ inline __fastcall TLMDCall(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDCall(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDTry : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FIndex;
	TLMDTry* FParent;
	int FFinallyRetVar;
	int FExceptionVar;
	TLMDLabel* FFinallyLabel;
	TLMDLabel* FHandlerLabel;
	int FHdrHierHigh;
	int FHdrHierLow;
	System::Classes::TList* FKnownFRets;
	int __fastcall GetKnownFinallyRetCount(void);
	TLMDLabel* __fastcall GetKnownFinallyRets(int AIndex);
	
public:
	__fastcall virtual ~TLMDTry(void);
	void __fastcall AddKnownFinallyRet(TLMDLabel* L);
	__property int Index = {read=FIndex, nodefault};
	__property TLMDTry* Parent = {read=FParent};
	__property TLMDLabel* FinallyLabel = {read=FFinallyLabel, write=FFinallyLabel};
	__property int FinallyRetVar = {read=FFinallyRetVar, write=FFinallyRetVar, nodefault};
	__property TLMDLabel* KnownFinallyRets[int AIndex] = {read=GetKnownFinallyRets};
	__property int KnownFinallyRetCount = {read=GetKnownFinallyRetCount, nodefault};
	__property int ExceptionVar = {read=FExceptionVar, write=FExceptionVar, nodefault};
	__property TLMDLabel* HandlerLabel = {read=FHandlerLabel, write=FHandlerLabel};
	__property int HdrHierLow = {read=FHdrHierLow, nodefault};
	__property int HdrHierHigh = {read=FHdrHierHigh, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDTry(void) : System::TObject() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExcJump : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDTry* FTry;
	TLMDLabel* FLabel;
	
public:
	__fastcall TLMDExcJump(TLMDTry* ATry, TLMDLabel* ALabel);
	__property TLMDTry* Try_ = {read=FTry};
	__property TLMDLabel* Label_ = {read=FLabel};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDExcJump(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFor : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDLabel* FJmpLabel;
	int FToVar;
	int FStepVar;
	int FLoopVarRef;
	int FLoopLocalVar;
	
public:
	__fastcall TLMDFor(TLMDLabel* AJmpLabel, int AToVar, int AStepVar, int ALoopVarRef)/* overload */;
	__fastcall TLMDFor(TLMDLabel* AJmpLabel, int AToVar, int AStepVar, int ALoopVarRef, int ALoopLocalVar)/* overload */;
	__property TLMDLabel* JmpLabel = {read=FJmpLabel};
	__property int ToVar = {read=FToVar, nodefault};
	__property int StepVar = {read=FStepVar, nodefault};
	__property int LoopVarRef = {read=FLoopVarRef, nodefault};
	__property int LoopLocalVar = {read=FLoopLocalVar, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDFor(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDArray : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FArgsOffset;
	System::Word FElemVarType;
	int FDimCount;
	
public:
	__property int DimCount = {read=FDimCount, nodefault};
	__property System::Word ElemVarType = {read=FElemVarType, nodefault};
	__property int ArgsOffset = {read=FArgsOffset, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDArray(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDArray(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDArrayRedim : public TLMDArray
{
	typedef TLMDArray inherited;
	
private:
	bool FPreserve;
	int FArrayOffset;
	int FArrayLocalVar;
	
public:
	__property bool Preserve = {read=FPreserve, nodefault};
	__property int ArrayOffset = {read=FArrayOffset, nodefault};
	__property int ArrayLocalVar = {read=FArrayLocalVar, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDArrayRedim(void) : TLMDArray() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDArrayRedim(void) { }
	
};

#pragma pack(pop)

typedef System::StaticArray<TLMDTry*, 1025> TLMDTrys;

typedef TLMDTrys *PLMDTrys;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDByteCode : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDInstrs *FCode;
	int FCodeLength;
	int FCount;
	System::Classes::TList* FItems;
	int FTryCount;
	TLMDTrys *FTryArray;
	TLMDTry* FCurrentProtBlock;
	int FStackSize;
	int FStackLocalsOffset;
	TLMDAbstractNamespace* FInitialNamespace;
	int FNextExcHdrRangeId;
	int FCurSourcePos;
	int FMaxSourcePos;
	int FMinSourcePos;
	bool FNextInstrBreakable;
	System::WideString FDescription;
	int FLocalVarCount;
	void __fastcall CalcStackSize(void);
	void __fastcall ProcessLabels(void);
	void __fastcall CreateTryArray(void);
	void __fastcall Grow(int AOldLen);
	
public:
	__fastcall TLMDByteCode(void);
	__fastcall virtual ~TLMDByteCode(void);
	void __fastcall BeginEmit(const System::WideString ADescription, TLMDAbstractNamespace* AInitialNamespace, int ASourcePos);
	void __fastcall BeginSourcePos(int ASourcePos, /* out */ int &AOldSourcePos);
	void __fastcall EndSourcePos(int AOldSourcePos);
	__property int CurSourcePos = {read=FCurSourcePos, nodefault};
	TLMDLabel* __fastcall CreateLabel(void);
	void __fastcall BindLabel(TLMDLabel* ALabel);
	void __fastcall SetNextInstrBreakable(void);
	void __fastcall ManualResetNextInstrBreakable(void);
	void __fastcall Emit(TLMDInstrCode ACode, System::TObject* AData)/* overload */;
	void __fastcall Emit(TLMDInstrCode ACode)/* overload */;
	TLMDCall* __fastcall AddCall(int AName, const System::WideString AStrName, TLMDBracketType ABracketType, int AArgCount, bool AHasObject, bool AHasValue, bool AIsResUsed);
	int __fastcall AddLocalVar(void);
	int __fastcall AddLocalVarArray(int ALength);
	TLMDFor* __fastcall AddFor(TLMDLabel* AJmpLabel, bool AIsStepUsed)/* overload */;
	TLMDFor* __fastcall AddFor(TLMDLabel* AJmpLabel, int ALoopLocalVar, bool AIsStepUsed)/* overload */;
	TLMDArray* __fastcall AddArray(int ADimCount, System::Word AElemVarType);
	TLMDArrayRedim* __fastcall AddArrayRedim(int ADimCount, System::Word AElemVarType, bool APreserve)/* overload */;
	TLMDArrayRedim* __fastcall AddArrayRedim(int ADimCount, System::Word AElemVarType, bool APreserve, int AArrayLocalVar)/* overload */;
	TLMDTry* __fastcall BeginProtectedBlock(void);
	void __fastcall EndProtectedBlock(void);
	void __fastcall BeginExcHdrCode(TLMDTry* ATry);
	void __fastcall EndExcHdrCode(TLMDTry* ATry);
	TLMDExcJump* __fastcall AddExcJmp(TLMDTry* ATry, TLMDLabel* ALabel);
	void __fastcall EndEmit(void);
	PLMDInstr __fastcall GetFirstBreakInstr(int AStartPos, int ALength);
	__property PLMDInstrs Code = {read=FCode};
	__property int StackSize = {read=FStackSize, nodefault};
	__property int StackLocalsOffset = {read=FStackLocalsOffset, nodefault};
	__property PLMDTrys Trys = {read=FTryArray};
	__property TLMDAbstractNamespace* InitialNamespace = {read=FInitialNamespace};
	__property System::WideString Description = {read=FDescription};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const int LMD_SPOSMASK = int(0x7fffffff);
static const unsigned LMD_BREAKABLE = unsigned(0x80000000);
static const System::Byte ic_MASK = System::Byte(0xff);
}	/* namespace Lmdsctvmbytecode */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTVMBYTECODE)
using namespace Lmdsctvmbytecode;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctvmbytecodeHPP
