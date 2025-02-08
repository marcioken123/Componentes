// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctVM.pas' rev: 31.00 (Windows)

#ifndef LmdsctvmHPP
#define LmdsctvmHPP

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
#include <Winapi.ActiveX.hpp>
#include <System.SyncObjs.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDSctCst.hpp>
#include <LMDSctClass.hpp>
#include <LMDSctVMByteCode.hpp>
#include <LMDSctVMCompBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctvm
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDVirtMachine;
class DELPHICLASS ELMDVMRuntime;
class DELPHICLASS TLMDStackItem;
class DELPHICLASS TLMDStackPool;
struct TLMDCallStackFrame;
class DELPHICLASS TLMDVMLock;
class DELPHICLASS TLMDThreadGlobals;
class DELPHICLASS TLMDThreadVM;
class DELPHICLASS TLMDThread;
struct TLMDThreadData;
struct TLMDVMId;
class DELPHICLASS TLMDCodeObject;
class DELPHICLASS TLMDExternObjects;
struct TLMDVMSourceItem;
class DELPHICLASS TLMDVMSource;
class DELPHICLASS TLMDVMBreakpoint;
class DELPHICLASS TLMDVMBreakpoints;
struct TLMDVMInterpretContext;
class DELPHICLASS TLMDVirtMachine;
struct TLMDPasDebugVar;
__interface ILMDPasDebugVarChildren;
typedef System::DelphiInterface<ILMDPasDebugVarChildren> _di_ILMDPasDebugVarChildren;
class DELPHICLASS TLMDPasStackFrame;
class DELPHICLASS TLMDPasStackFrames;
class DELPHICLASS TLMDVMDebugger;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDVirtMachine : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDVirtMachine(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDVirtMachine(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDVirtMachine(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDVirtMachine(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDVirtMachine(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDVirtMachine(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDVirtMachine(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDVirtMachine(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDVirtMachine(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDVirtMachine(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDVirtMachine(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDVirtMachine(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDVirtMachine(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDRuntimeErrorType : unsigned char { retUndeclaredId, retOutsideOfLoop, retEBCFromFinally, retCannotAssign, retInvalidParamCount, retTypeMismatch, retObjectRequired, retLoopVar, retCannotRaiseNil, retCannotRaiseLocked, retLowOnlyArray, retHighOnlyArray, retViolatesBounds, retInvalidDispId, retProcRequired, retValObjRequired, retAborted, retIEInvalidObjKind, retIEInvalidBracketType, retIEInvalidInstr, retIENoBreakpointInfo };

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDVMRuntime : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
private:
	__classmethod System::WideString __fastcall FormatMsg(TLMDRuntimeErrorType AErrorType, const System::TVarRec *AArgs, const int AArgs_High);
	
public:
	__classmethod void __fastcall RaiseError(TLMDRuntimeErrorType AErrorType)/* overload */;
	__classmethod void __fastcall RaiseError(TLMDRuntimeErrorType AErrorType, const System::WideString AStrName)/* overload */;
	__classmethod void __fastcall RaiseError(HRESULT AInvokeRes, tagEXCEPINFO &EInfo, bool AFinalizeEInfo)/* overload */;
public:
	/* Exception.Create */ inline __fastcall ELMDVMRuntime(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDVMRuntime(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDVMRuntime(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDVMRuntime(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDVMRuntime(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDVMRuntime(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDVMRuntime(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDVMRuntime(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDVMRuntime(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDVMRuntime(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDVMRuntime(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDVMRuntime(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDVMRuntime(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStackItem : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<System::OleVariant> _TLMDStackItem__1;
	
	
private:
	_TLMDStackItem__1 FData;
	int FSize;
	TLMDStackItem* FPrev;
	int FUsedItemSize;
	
public:
	__fastcall TLMDStackItem(int ASize, TLMDStackItem* APrev);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDStackItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStackPool : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDStackItem* FLast;
	
public:
	__fastcall TLMDStackPool(void);
	__fastcall virtual ~TLMDStackPool(void);
	Lmdsctclass::PLMDVarArray __fastcall AsquireStack(int ASize);
	void __fastcall ReleaseStack(int ASize);
};

#pragma pack(pop)

typedef TLMDCallStackFrame *PLMDCallStackFrame;

struct DECLSPEC_DRECORD TLMDCallStackFrame
{
public:
	TLMDCallStackFrame *Next;
	TLMDVirtMachine* VM;
	void *Ctx;
	Lmdsctvmbytecode::TLMDAbstractNamespace* CurNS;
	Lmdsctvmbytecode::TLMDInstr *IP;
	Lmdsctclass::TLMDVarArray *Stack;
	void *ExcSt;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVMLock : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDVirtMachine* FVM;
	System::Classes::TList* FVMDataList;
	bool FInactiveOrClosing;
	int FDebuggerId;
	
public:
	__fastcall TLMDVMLock(TLMDVirtMachine* VM);
	__fastcall virtual ~TLMDVMLock(void);
	__property TLMDVirtMachine* VM = {read=FVM};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDThreadGlobals : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDThreadVM* FThreadVM;
	TLMDVMLock* FVMLock;
	Lmdsctclass::TLMDNameHashTable* FItems;
	Lmdsctclass::TLMDIdentifierHashTable* FProcsCache;
	Lmdsctclass::TLMDIdentifierHashTable* FValObjCache;
	System::Classes::TList* FPubMrsExterns;
	int FChangeNumber;
	void __fastcall UpdateContent(System::Classes::TList* AScriptGlobals, System::Classes::TList* AExterns, System::Classes::TList* APubMrsExterns, System::Classes::TList* AIntrinsics, int AChangeNumber);
	bool __fastcall SearchInPubMembers(int AName, const System::WideString AStrName, /* out */ Lmdsctvmbytecode::TLMDNameSearchRes &ASearchRes);
	Lmdsctvmbytecode::TLMDNameSearchRes __fastcall AddMemberToItems(Lmdsctvmcompbase::TLMDExternObject* AObject, int AMemberName, int ADispId);
	Lmdsctvmcompbase::TLMDProcObject* __fastcall AddProcToCache(const System::WideString AStrName);
	Lmdsctvmcompbase::TLMDGlobalValuedObject* __fastcall AddValObjToCache(const System::WideString AStrName);
	
public:
	__fastcall TLMDThreadGlobals(TLMDThreadVM* AThreadVM);
	__fastcall virtual ~TLMDThreadGlobals(void);
	void __fastcall Clear(void);
	Lmdsctvmbytecode::TLMDNameSearchRes __fastcall Search(int AName, const System::WideString AStrName);
	Lmdsctvmcompbase::TLMDProcObject* __fastcall FindProcByStrName(const System::WideString AStrName);
	Lmdsctvmcompbase::TLMDGlobalValuedObject* __fastcall FindValObjByStrName(const System::WideString AStrName);
};

#pragma pack(pop)

typedef unsigned TLMDFrame;

typedef TLMDFrame *PLMDFrame;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDThreadVM : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDVMLock* FVMLock;
	TLMDThread* FThread;
	TLMDThreadGlobals* FGlobals;
	int FLockCount;
	int FFlag;
	TLMDFrame *FSteppingBase;
	bool FInBreak;
	
public:
	__fastcall TLMDThreadVM(TLMDVMLock* AVMLock, TLMDThread* AThread, bool AInactiveOrClosing, PLMDFrame ASteppingBase);
	__fastcall virtual ~TLMDThreadVM(void);
	bool __fastcall Lock(void);
	void __fastcall Unlock(void);
	__property TLMDVMLock* VMLock = {read=FVMLock};
	__property TLMDThread* Thread = {read=FThread};
	__property TLMDThreadGlobals* Globals = {read=FGlobals};
	__property PLMDFrame SteppingBase = {read=FSteppingBase};
	__property bool InBreak = {read=FInBreak, write=FInBreak, nodefault};
};

#pragma pack(pop)

typedef System::DynamicArray<TLMDThreadVM*> TLMDThreadVMs;

class PASCALIMPLEMENTATION TLMDThread : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	NativeUInt FThread;
	TLMDStackPool* FStackPool;
	TLMDCallStackFrame *FCallStack;
	TLMDThreadVMs FVMData;
	
public:
	__fastcall TLMDThread(void);
	__fastcall virtual ~TLMDThread(void);
	bool __fastcall IsThreadClosed(void);
	__property TLMDStackPool* StackPool = {read=FStackPool};
	__property PLMDCallStackFrame CallStack = {read=FCallStack, write=FCallStack};
	__property TLMDThreadVMs VMData = {read=FVMData};
	System::OleVariant *PV;
	System::OleVariant V;
};


struct DECLSPEC_DRECORD TLMDThreadData
{
public:
	TLMDThread* Thread;
	int VMDataLength;
};


struct DECLSPEC_DRECORD TLMDVMId
{
public:
	int Id;
	int Index;
	TLMDVMLock* Lock;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDCodeObject : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
private:
	TLMDVMId FId;
	Lmdsctclass::TLMDIdentifierHashTable* FIdsByStrName;
	Lmdsctclass::TLMDNameHashTable* FIdsByName;
	int FMaxDispId;
	void __fastcall Init(TLMDVirtMachine* AVM);
	HRESULT __fastcall EncodeInvokeError(System::Sysutils::Exception* E, Winapi::Activex::PExcepInfo AEInfo);
	void __fastcall RaiseVMHasBeenClosed(void);
	
protected:
	HIDESBASE HRESULT __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	HRESULT __stdcall GetTypeInfo(int Index, int LocaleID, /* out */ void *TypeInfo);
	HRESULT __stdcall GetTypeInfoCount(/* out */ int &Count);
	HRESULT __stdcall GetIDsOfNames(const GUID &IID, void * Names, int NameCount, int LocaleID, void * DispIDs);
	HRESULT __stdcall Invoke(int DispID, const GUID &IID, int LocaleID, System::Word Flags, void *Params, void * VarResult, void * ExcepInfo, void * ArgErr);
	
public:
	__fastcall TLMDCodeObject(TLMDVirtMachine* AVM);
	__fastcall virtual ~TLMDCodeObject(void);
	bool __fastcall GetIdOfName(int ANameIndex, /* out */ int &ADispId);
	void __fastcall InvokeMember(TLMDThread* AThread, int DispID, Lmdsctvmbytecode::TLMDBracketType ABracketType, unsigned AResMask, int AArgCount, Lmdsctclass::PLMDVarArray AArgs, System::OleVariant &AResult);
	void __fastcall InvokePropPut(TLMDThread* AThread, int DispID, Lmdsctvmbytecode::TLMDBracketType ABracketType, int AArgCount, Lmdsctclass::PLMDVarArray AArgs, System::POleVariant AValue);
private:
	void *__IDispatch;	// IDispatch 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00020400-0000-0000-C000-000000000046}
	operator _di_IDispatch()
	{
		_di_IDispatch intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator IDispatch*(void) { return (IDispatch*)&__IDispatch; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {00000000-0000-0000-C000-000000000046}
	operator System::_di_IInterface()
	{
		System::_di_IInterface intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator System::IInterface*(void) { return (System::IInterface*)&__IDispatch; }
	#endif
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDVMState : unsigned char { msUninitialized, msInitialized, msActive };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDExternObjects : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDVirtMachine* FVM;
	System::Syncobjs::TCriticalSection* FSection;
	Lmdsctclass::TLMDNameHashTable* FObjects;
	System::Classes::TList* FPubMrsObjs;
	int FChangeNumber;
	
public:
	__fastcall TLMDExternObjects(TLMDVirtMachine* AVM);
	__fastcall virtual ~TLMDExternObjects(void);
	void __fastcall Close(void);
	bool __fastcall Add(const _di_IDispatch AObj, const System::WideString AName, bool APublishMembers);
	void __fastcall UpdateContentOf(TLMDThreadGlobals* AGlobals);
	__property int ChangeNumber = {read=FChangeNumber, nodefault};
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TLMDVMSourceItem
{
public:
	int Line;
	int Pos;
	System::WideChar *Cur;
};


typedef System::DynamicArray<TLMDVMSourceItem> TLMDVMSourceItems;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVMSource : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::WideString FText;
	TLMDVMSourceItems FIndex;
	int FIndexLength;
	void __fastcall SetText(const System::WideString Value);
	void __fastcall UpdateIndex(void);
	void __fastcall AddItem(int ALine, int APos, System::WideChar * ACur);
	
public:
	__fastcall TLMDVMSource(void)/* overload */;
	__fastcall TLMDVMSource(const System::WideString AText)/* overload */;
	void __fastcall Clear(void);
	void __fastcall PosToLine(int ASrcPos, /* out */ int &ALine, /* out */ int &ALinePos)/* overload */;
	int __fastcall PosToLine(int ASrcPos)/* overload */;
	void __fastcall LineToPos(int ALine, /* out */ int &ASrcPos, /* out */ int &ALength);
	__property System::WideString Text = {read=FText, write=SetText};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVMSource(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVMBreakpoint : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TLMDThread*> _TLMDVMBreakpoint__1;
	
	
public:
	bool IsUser;
	_TLMDVMBreakpoint__1 Threads;
	Lmdsctvmbytecode::TLMDInstr *Instr;
	Lmdsctvmbytecode::TLMDInstrCode Origin;
public:
	/* TObject.Create */ inline __fastcall TLMDVMBreakpoint(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDVMBreakpoint(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDVMGetBPInfoResult : unsigned char { bpirOk, bpirCausedBreak, bpirGoThrough, bpirBPRemoved, bpirNoBPInfo };

enum DECLSPEC_DENUM TLMDVMBreakKind : unsigned char { bkBreakpoint, bkStep, bkCausedBreak };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVMBreakpoints : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDVirtMachine* FVM;
	System::Syncobjs::TCriticalSection* FSection;
	System::Classes::TList* FItems;
	
protected:
	TLMDVMBreakpoint* __fastcall FindItem(Lmdsctvmbytecode::PLMDInstr AInstr);
	TLMDVMBreakpoint* __fastcall AddItem(Lmdsctvmbytecode::PLMDInstr AInstr);
	void __fastcall TryRemoveItem(TLMDVMBreakpoint* AItem);
	int __fastcall IndexOfThread(TLMDVMBreakpoint* AItem, TLMDThread* AThread);
	void __fastcall AddThread(TLMDVMBreakpoint* AItem, TLMDThread* AThread);
	void __fastcall DeleteThread(TLMDVMBreakpoint* AItem, int AIndex);
	void __fastcall AddStepBP(Lmdsctvmbytecode::PLMDInstr AInstr, TLMDThread* AThread);
	void __fastcall AddStepBPs(TLMDThread* AThread, Lmdsctvmbytecode::PLMDInstr AStartFrom, bool ASkipStartLine);
	void __fastcall AddExcStepBPs(TLMDThread* AThread, Lmdsctvmbytecode::TLMDTry* AHandler);
	
public:
	__fastcall TLMDVMBreakpoints(TLMDVirtMachine* AVM);
	__fastcall virtual ~TLMDVMBreakpoints(void);
	void __fastcall Clear(void);
	void __fastcall SetUserBP(Lmdsctvmbytecode::PLMDInstr AInstr);
	void __fastcall RemoveUserBP(Lmdsctvmbytecode::PLMDInstr AInstr);
	TLMDVMGetBPInfoResult __fastcall GetInfo(TLMDThread* AThread, TLMDVMDebugger* ADebugger, PLMDFrame AStepBase, TLMDFrame ACurFrame, Lmdsctvmbytecode::PLMDInstr AInstr, /* out */ TLMDVMBreakKind &ABreakKind, /* out */ Lmdsctvmbytecode::TLMDInstr &AOrigin);
	void __fastcall SetStepBPs(TLMDThread* AThread, PLMDFrame AStepBase, TLMDFrame ACurFrame, Lmdsctvmbytecode::PLMDInstr AStartFrom, bool ASkipStartLine);
	void __fastcall SetExcStepBPs(TLMDThread* AThread, PLMDFrame AStepBase, TLMDFrame ACurFrame, Lmdsctvmbytecode::TLMDTry* AHandler);
	void __fastcall RemoveStepBps(TLMDThread* AThread, PLMDFrame AStepBase);
};

#pragma pack(pop)

typedef TLMDVMInterpretContext *PLMDVMInterpretContext;

struct DECLSPEC_DRECORD TLMDVMInterpretContext
{
public:
	Lmdsctvmbytecode::TLMDByteCode* Code;
	Lmdsctclass::TLMDVarArray *Args;
	System::OleVariant *Result;
	TLMDVMSource* Source;
};


enum DECLSPEC_DENUM TLMVMDResumeKind : unsigned char { rkStepOver, rkStepInto, rkContinue, rkIgnore, rkAbort };

typedef void __fastcall (__closure *TLMDOnIsTest)(System::TObject* Sender, const System::OleVariant &AObj, const System::OleVariant &AType, bool &AResult);

typedef void __fastcall (__closure *TLMDOnExceptionIsTest)(System::TObject* Sender, System::Sysutils::Exception* E, const System::OleVariant &AType, bool &AResult);

typedef void __fastcall (__closure *TLMDOnVarToException)(System::TObject* Sender, const System::OleVariant &V, System::Sysutils::Exception* &AResult);

typedef void __fastcall (__closure *TLMDOnExceptionToVar)(System::TObject* Sender, System::Sysutils::Exception* const E, System::OleVariant &AResult);

typedef void __fastcall (__closure *TLMDOnFormatException)(System::TObject* Sender, int ALine, int ALinePos, System::Sysutils::Exception* const E);

typedef void __fastcall (__closure *TLMDOnEventMake)(System::TObject* Sender, const System::WideString AProcName, System::OleVariant &AResult);

typedef void __fastcall (__closure *TLMDOnNew)(System::TObject* Sender, const System::OleVariant &AType, Lmdsctclass::PLMDVarArray AArgs, int AArgCount, System::OleVariant &AResult);

class PASCALIMPLEMENTATION TLMDVirtMachine : public Lmdsctvmcompbase::TLMDVMBase
{
	typedef Lmdsctvmcompbase::TLMDVMBase inherited;
	
	
private:
	typedef System::DynamicArray<Lmdsctvmcompbase::TLMDDispIdObject*> _TLMDVirtMachine__1;
	
	
private:
	TLMDVMState FState;
	Lmdsctvmcompbase::_di_ILMDLanguage FLanguage;
	System::Syncobjs::TCriticalSection* FSection;
	TLMDVMId FId;
	_di_IDispatch FCodeObject;
	TLMDVMBreakpoints* FBreakpoints;
	TLMDVMSource* FSource;
	Lmdsctclass::TLMDNameHashTable* FScriptGlobals;
	_TLMDVirtMachine__1 FScriptGlobalsByDispId;
	int FDispIdsCount;
	TLMDExternObjects* FExternObjects;
	Lmdsctclass::TLMDNameHashTable* FIntrinsicObjects;
	System::Classes::TList* FProcedures;
	System::Classes::TList* FGlobalVars;
	System::Classes::TList* FGlobalConsts;
	Lmdsctvmbytecode::TLMDAbstractNamespace* FGlobalNamespace;
	System::Classes::TList* FGlobalStmts;
	Lmdsctvmbytecode::TLMDByteCode* FGlobalByteCode;
	TLMDVMDebugger* FDebugger;
	int FTerminateFlag;
	TLMDOnIsTest FOnIsTest;
	TLMDOnExceptionIsTest FOnExceptionIsTest;
	TLMDOnVarToException FOnVarToException;
	TLMDOnExceptionToVar FOnExceptionToVar;
	TLMDOnFormatException FOnFormatException;
	TLMDOnEventMake FOnEventMake;
	TLMDOnNew FOnNew;
	_di_IDispatch __fastcall GetCodeObject(void);
	void __fastcall RaiseVMNotActive(void);
	void __fastcall RaiseProcNotFound(const System::WideString AStrName);
	void __fastcall RaiseValObjNotFound(const System::WideString AStrName);
	void __fastcall AddIntrinsicProc(Lmdsctvmcompbase::TLMDGlobalObject* AObject);
	Lmdsctvmbytecode::TLMDByteCode* __fastcall EmitGlobalCode(void);
	void __fastcall DoClear(void);
	__classmethod Winapi::Activex::PSafeArray __fastcall GetArray(const System::OleVariant &AArray, /* out */ System::Word &AElemType);
	__classmethod void __fastcall CreateArray(Lmdsctvmbytecode::TLMDArray* AArray, Lmdsctclass::PLMDVarArray AArgs, System::OleVariant &AResult);
	__classmethod void __fastcall RedimArray(Lmdsctvmbytecode::TLMDArrayRedim* ARedim, System::OleVariant &AValue, Lmdsctclass::PLMDVarArray AArgs);
	__classmethod void __fastcall GetArrayElem(Winapi::Activex::PSafeArray AArray, System::Word AElemType, System::PInteger AIndices, System::OleVariant &AResult);
	__classmethod void __fastcall SetArrayElem(Winapi::Activex::PSafeArray AArray, System::Word AElemType, System::PInteger AIndices, const System::OleVariant &AValue);
	__classmethod void __fastcall AddValToSet(System::OleVariant &ASet, int AElem);
	__classmethod void __fastcall AddRangeToSet(System::OleVariant &ASet, int AMinElem, int AMaxElem);
	__classmethod void __fastcall GetIndexed(int AArgCount, const System::OleVariant &AIndexed, Lmdsctclass::PLMDVarArray AArgs, System::OleVariant &AResult);
	__classmethod void __fastcall SetIndexed(System::OleVariant &AIndexed, System::POleVariant AValue, Lmdsctclass::PLMDVarArray AArgs, int AArgCount);
	__classmethod void __fastcall InvokeDispatchPropPut(Lmdsctvmbytecode::TLMDCall* ACall, const _di_IDispatch AObj, int ADispId, Lmdsctclass::PLMDVarArray AArgs, System::POleVariant AValue);
	__classmethod void __fastcall InvokeDispatchMember(Lmdsctvmbytecode::TLMDCall* ACall, const _di_IDispatch AObj, int ADispId, Lmdsctclass::PLMDVarArray AArgs, System::OleVariant &OleResult);
	__classmethod void __fastcall InvokeMemberCall(TLMDThread* AThread, Lmdsctvmbytecode::TLMDCall* ACall, System::POleVariant ATop);
	__classmethod void __fastcall InvokeAssignMemberCall(TLMDThread* AThread, Lmdsctvmbytecode::TLMDCall* ACall, System::POleVariant ATop);
	void __fastcall InvokeProc(TLMDThread* AThread, Lmdsctvmbytecode::TLMDCall* ACall, Lmdsctvmcompbase::TLMDProcObject* AProc, System::POleVariant ATop);
	void __fastcall InvokeProcNoChecks(TLMDThread* AThread, Lmdsctvmcompbase::TLMDProcObject* AProc, Lmdsctclass::PLMDVarArray AArgs, System::OleVariant &OleResult);
	void __fastcall FormatException(TLMDThread* AThread, TLMDVMSource* ASource, System::Sysutils::Exception* E, int APos);
	bool __fastcall FindBreakpointCode(int ALine, /* out */ Lmdsctvmbytecode::TLMDByteCode* &AByteCode, /* out */ Lmdsctvmbytecode::PLMDInstr &AInstr);
	void __fastcall HandleBreakpoint(TLMDThread* AThread, PLMDCallStackFrame AFrame, PLMDFrame ASteppingBase, TLMDVMBreakKind ABreakKind);
	System::OleVariant __fastcall EvalDebug(const System::WideString AExpr, PLMDCallStackFrame AFrame);
	void __fastcall Interpret(TLMDThread* AThread, const TLMDVMInterpretContext &ACtx);
	
public:
	__fastcall TLMDVirtMachine(const Lmdsctvmcompbase::_di_ILMDLanguage ALanguage);
	__fastcall virtual ~TLMDVirtMachine(void);
	virtual void __fastcall MakeEventHandler(const System::WideString AProcName, System::OleVariant &AResult);
	void __fastcall Initialize(const System::WideString ASource);
	void __fastcall Open(TLMDVMDebugger* ADebugger = (TLMDVMDebugger*)(0x0));
	void __fastcall Close(void);
	bool __fastcall AddExternObject(_di_IDispatch AObj, const System::WideString AName, bool APublishMembers);
	void __fastcall Lock(void);
	void __fastcall Unlock(void);
	System::OleVariant __fastcall RunProc(const System::WideString AName)/* overload */;
	System::OleVariant __fastcall RunProc(const System::WideString AName, const System::OleVariant *AArgs, const int AArgs_High)/* overload */;
	System::OleVariant __fastcall ReadVar(const System::WideString AName);
	void __fastcall WriteVar(const System::WideString AName, const System::OleVariant &AValue);
	System::TObject* __fastcall PrepareExpr(const System::WideString AExpr);
	System::TObject* __fastcall PrepareStmt(const System::WideString AStmt);
	System::OleVariant __fastcall Eval(System::TObject* APreparedExpr)/* overload */;
	System::OleVariant __fastcall Eval(const System::WideString AExpr)/* overload */;
	void __fastcall ExecStmt(System::TObject* APreparedStmt)/* overload */;
	void __fastcall ExecStmt(const System::WideString AStmt)/* overload */;
	bool __fastcall SetBreakpoint(int ALine);
	void __fastcall RemoveBreakpoint(int ALine);
	__property TLMDVMState State = {read=FState, nodefault};
	__property _di_IDispatch CodeObject = {read=GetCodeObject};
	__property TLMDOnIsTest OnIsTest = {read=FOnIsTest, write=FOnIsTest};
	__property TLMDOnExceptionIsTest OnExceptionIsTest = {read=FOnExceptionIsTest, write=FOnExceptionIsTest};
	__property TLMDOnVarToException OnVarToException = {read=FOnVarToException, write=FOnVarToException};
	__property TLMDOnExceptionToVar OnExceptionToVar = {read=FOnExceptionToVar, write=FOnExceptionToVar};
	__property TLMDOnFormatException OnFormatException = {read=FOnFormatException, write=FOnFormatException};
	__property TLMDOnEventMake OnEventMake = {read=FOnEventMake, write=FOnEventMake};
	__property TLMDOnNew OnNew = {read=FOnNew, write=FOnNew};
};


struct DECLSPEC_DRECORD TLMDPasDebugVar
{
public:
	System::WideString Name;
	System::WideString Type_;
	System::WideString Value;
	_di_ILMDPasDebugVarChildren Children;
};


typedef void __fastcall (__closure *TLMDPasDebugVarChildProc)(const TLMDPasDebugVar &AVariable, void * ACookie, bool &AStop);

__interface ILMDPasDebugVarChildren  : public System::IInterface 
{
	virtual void __fastcall Enum(TLMDPasDebugVarChildProc AProc, void * ACookie) = 0 ;
};

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasStackFrame : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDPasStackFrames* FOwner;
	TLMDCallStackFrame *FFrame;
	TLMDVMInterpretContext *FCtx;
	TLMDVirtMachine* FVM;
	int FLine;
	System::WideString FDescription;
	void __fastcall FillParams(void);
	
public:
	__fastcall TLMDPasStackFrame(TLMDPasStackFrames* AOwner, PLMDCallStackFrame AFrame);
	void __fastcall Eval(const System::WideString AExpr, /* out */ TLMDPasDebugVar &AVars)/* overload */;
	bool __fastcall Eval(const System::WideString AExpr, /* out */ System::OleVariant &AValue)/* overload */;
	void __fastcall GetVariables(/* out */ TLMDPasDebugVar &AVars);
	__property TLMDVirtMachine* VM = {read=FVM};
	__property System::WideString Description = {read=FDescription};
	__property int Line = {read=FLine, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDPasStackFrame(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDPasStackFrames : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDPasStackFrame* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	System::Classes::TList* FItems;
	unsigned FBreakedThreadId;
	int __fastcall GetCount(void);
	TLMDPasStackFrame* __fastcall GetItems(int AIndex);
	void __fastcall Add(PLMDCallStackFrame AFrame);
	void __fastcall SetInBreakFlags(TLMDThread* AThread, bool AInBreak);
	
public:
	__fastcall TLMDPasStackFrames(unsigned ABreakedThreadId);
	__fastcall virtual ~TLMDPasStackFrames(void);
	__property int Count = {read=GetCount, nodefault};
	__property TLMDPasStackFrame* Items[int AIndex] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDOnBreak)(System::TObject* Sender, TLMDVMBreakKind ABreakKind, TLMDVirtMachine* AVM, int ALine, TLMDPasStackFrames* ACallStack, TLMVMDResumeKind &AResumeKind);

class PASCALIMPLEMENTATION TLMDVMDebugger : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FId;
	System::Syncobjs::TCriticalSection* FSection;
	System::Classes::TList* FVMs;
	bool FCausingBreak;
	TLMDOnBreak FOnBreak;
	void __fastcall InsertVM(TLMDVirtMachine* AVM);
	void __fastcall RemoveVM(TLMDVirtMachine* AVM);
	
protected:
	virtual TLMVMDResumeKind __fastcall DoOnBreak(TLMDVMBreakKind ABreakKind, TLMDVirtMachine* AVM, int ALine, TLMDPasStackFrames* AStack);
	TLMVMDResumeKind __fastcall HandleBreak(TLMDThread* AThread, TLMDVMBreakKind ABreakKind, TLMDVirtMachine* AVM, int ALine);
	bool __fastcall ResetCausingBreak(void);
	
public:
	__fastcall TLMDVMDebugger(void);
	__fastcall virtual ~TLMDVMDebugger(void);
	void __fastcall CauseBreak(void);
	__property TLMDOnBreak OnBreak = {read=FOnBreak, write=FOnBreak};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 opStrConcat = System::Int8(0x14);
static const System::Int8 opPower = System::Int8(0x15);
static const System::Int8 opEqv = System::Int8(0x16);
static const System::Int8 opImp = System::Int8(0x17);
static const System::Int8 opCmpREQ = System::Int8(0x18);
static const System::Int8 opCmpRNE = System::Int8(0x19);
extern DELPHI_PACKAGE void __fastcall VarBinaryOp(const System::OleVariant &ALeft, const System::OleVariant &ARight, System::OleVariant &ARes, int AOper);
extern DELPHI_PACKAGE bool __fastcall VarCompareOp(const System::OleVariant &ALeft, const System::OleVariant &ARight, int AOper);
extern DELPHI_PACKAGE void __fastcall VarUnaryOp(const System::OleVariant &AArg, System::OleVariant &ARes, int AOper);
extern DELPHI_PACKAGE void __fastcall VarMoveData(System::OleVariant &ADest, System::OleVariant &ASource);
extern DELPHI_PACKAGE void __fastcall VarAssignByRef(System::OleVariant &ADest, const System::OleVariant &AValue);
extern DELPHI_PACKAGE System::POleVariant __fastcall VarResolveRef(const System::OleVariant &V);
extern DELPHI_PACKAGE System::POleVariant __fastcall VarResolveRefNoCheck(const System::OleVariant &V);
}	/* namespace Lmdsctvm */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTVM)
using namespace Lmdsctvm;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctvmHPP
