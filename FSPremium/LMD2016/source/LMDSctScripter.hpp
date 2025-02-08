// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctScripter.pas' rev: 31.00 (Windows)

#ifndef LmdsctscripterHPP
#define LmdsctscripterHPP

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
#include <Vcl.Controls.hpp>
#include <System.TypInfo.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.Variants.hpp>
#include <System.Win.ComObj.hpp>
#include <System.Types.hpp>
#include <System.RTLConsts.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDUnicode.hpp>
#include <LMDHashTable.hpp>
#include <LMDSvcPvdr.hpp>
#include <LMDSctClass.hpp>
#include <LMDSctWrappers.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctscripter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS ELMDScriptControl;
class DELPHICLASS TLMDComExceptionIgnore;
class DELPHICLASS TLMDScriptEventHandler;
__interface ILMDNamedValuesHolder;
typedef System::DelphiInterface<ILMDNamedValuesHolder> _di_ILMDNamedValuesHolder;
class DELPHICLASS TLMDScriptControl;
class DELPHICLASS TLMDDebugModule;
class DELPHICLASS TLMDDebugModules;
class DELPHICLASS TLMDBreakpointAction;
class DELPHICLASS TLMDBreakpoint;
class DELPHICLASS TLMDVariables;
class DELPHICLASS TLMDVariable;
class DELPHICLASS TLMDStackFrame;
class DELPHICLASS ILMDScriptDebuggerNotifier;
class DELPHICLASS TLMDScriptDebugger;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDScriptControl : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDScriptControl(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDScriptControl(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDScriptControl(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDScriptControl(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDScriptControl(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDScriptControl(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDScriptControl(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDScriptControl(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDScriptControl(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDScriptControl(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDScriptControl(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDScriptControl(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDScriptControl(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDComExceptionIgnore : public System::Win::Comobj::EOleSysError
{
	typedef System::Win::Comobj::EOleSysError inherited;
	
public:
	/* EOleSysError.Create */ inline __fastcall TLMDComExceptionIgnore(const System::UnicodeString Message, HRESULT ErrorCode, int HelpContext) : System::Win::Comobj::EOleSysError(Message, ErrorCode, HelpContext) { }
	
public:
	/* Exception.CreateFmt */ inline __fastcall TLMDComExceptionIgnore(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Win::Comobj::EOleSysError(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall TLMDComExceptionIgnore(NativeUInt Ident)/* overload */ : System::Win::Comobj::EOleSysError(Ident) { }
	/* Exception.CreateRes */ inline __fastcall TLMDComExceptionIgnore(System::PResStringRec ResStringRec)/* overload */ : System::Win::Comobj::EOleSysError(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall TLMDComExceptionIgnore(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Win::Comobj::EOleSysError(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall TLMDComExceptionIgnore(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Win::Comobj::EOleSysError(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall TLMDComExceptionIgnore(const System::UnicodeString Msg, int AHelpContext) : System::Win::Comobj::EOleSysError(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall TLMDComExceptionIgnore(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Win::Comobj::EOleSysError(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TLMDComExceptionIgnore(NativeUInt Ident, int AHelpContext)/* overload */ : System::Win::Comobj::EOleSysError(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall TLMDComExceptionIgnore(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Win::Comobj::EOleSysError(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TLMDComExceptionIgnore(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Win::Comobj::EOleSysError(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall TLMDComExceptionIgnore(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Win::Comobj::EOleSysError(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~TLMDComExceptionIgnore(void) { }
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDScriptEventHandlerClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDScriptEventHandler : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDScriptControl* FOwner;
	Lmdtypes::TLMDString FProcName;
	
public:
	__fastcall virtual TLMDScriptEventHandler(TLMDScriptControl* AOwner, const Lmdtypes::TLMDString AProcName);
	virtual System::TMethod __fastcall GetHandler(void) = 0 ;
	__property TLMDScriptControl* Owner = {read=FOwner};
	__property Lmdtypes::TLMDString ProcName = {read=FProcName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDScriptEventHandler(void) { }
	
};

#pragma pack(pop)

__interface  INTERFACE_UUID("{DB3038C2-6AF2-4688-8AD5-716B4337ED7C}") ILMDNamedValuesHolder  : public System::IInterface 
{
	virtual void __fastcall AddOrSet(const System::WideString AName, System::POleVariant AValue) = 0 ;
};

enum DECLSPEC_DENUM TLMDScriptControlState : unsigned char { ssInactive, ssPrepared, ssActive };

typedef System::Set<TLMDScriptControlState, TLMDScriptControlState::ssInactive, TLMDScriptControlState::ssActive> TLMDScriptControlStates;

enum DECLSPEC_DENUM TLMDScriptLanguage : unsigned char { slVBScript, slJScript, slPerl, slRexx, slTCL, slPython, slLua, slPascal, slNativeVb };

enum DECLSPEC_DENUM TLMDScriptLangKind : unsigned char { slkActiveX, slkNative };

class PASCALIMPLEMENTATION TLMDScriptControl : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDScriptControlState FState;
	System::TObject* FRunner;
	_di_IDispatch FCodeObject;
	_di_ILMDNamedValuesHolder FNamedValuesHolder;
	Lmdhashtable::TLMDHashTable* FNamedItems;
	System::Classes::TList* FEventHandlers;
	System::Classes::TStrings* FSource;
	TLMDScriptDebugger* FDebugger;
	TLMDScriptLanguage FLanguage;
	bool FExceptionSourceInfo;
	System::Classes::TNotifyEvent FAfterClose;
	System::Classes::TNotifyEvent FBeforePrepare;
	System::Classes::TNotifyEvent FBeforeOpen;
	TLMDDebugModule* FDebugModule;
	Lmdtypes::TLMDString FLoadingDebugName;
	void __fastcall CheckState(TLMDScriptControlStates AValidStates);
	void __fastcall ValidateDebugger(TLMDScriptLanguage ALanguage, TLMDScriptDebugger* ADebugger);
	void __fastcall SourceChanging(void);
	void __fastcall DoAddNamedObject(const Lmdtypes::TLMDString Name, const _di_IDispatch AObj, bool APublishMembers);
	void __fastcall DoAddOrSetNamedValue(const Lmdtypes::TLMDString Name, const System::OleVariant &Value);
	_di_ILMDNamedValuesHolder __fastcall InitNamedValuesHolder(void);
	_di_IDispatch __fastcall GetCodeObject(void);
	System::OleVariant __fastcall GetScript(void);
	void __fastcall SetLanguage(const TLMDScriptLanguage Value);
	void __fastcall SetSource(System::Classes::TStrings* const Value);
	void __fastcall SetDebugger(TLMDScriptDebugger* const Value);
	bool __fastcall GetActive(void);
	void __fastcall SetActive(const bool Value);
	void __fastcall SetExceptionSourceInfo(const bool Value);
	Lmdtypes::TLMDString __fastcall GetDebugName(void);
	void __fastcall SetDebugModule(TLMDDebugModule* const Value);
	void __fastcall SetDebugName(const Lmdtypes::TLMDString Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DoBeforePrepare(void);
	virtual void __fastcall DoBeforeOpen(void);
	virtual void __fastcall DoAfterClose(void);
	
public:
	__fastcall virtual TLMDScriptControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDScriptControl(void);
	void __fastcall Prepare(void);
	void __fastcall Open(bool ACloseOnRuntimeError = true);
	void __fastcall Close(bool AClearObjects = false, bool AClearEventHandler = true);
	void __fastcall AddOrSetValue(const Lmdtypes::TLMDString Name, const System::OleVariant &Value);
	bool __fastcall TryReadValue(const Lmdtypes::TLMDString Name, /* out */ System::OleVariant &AResult);
	void __fastcall AddObject(const Lmdtypes::TLMDString Name, const System::OleVariant &Obj, bool APublishMembers = false);
	void __fastcall AddChildren(System::Classes::TComponent* const AOwner, bool APublishMembers = false);
	void __fastcall AddUnit(Lmdsctwrappers::TLMDUnitWrapperClass AWrapperClass, bool APublishMembers = true);
	void __fastcall AddUnits(Lmdsctwrappers::TLMDUnitWrapperClass *AWrapperClasses, const int AWrapperClasses_High, bool APublishMembers = true);
	void __fastcall AddAllUnits(bool APublishMembers = true);
	void __fastcall RemoveObject(const Lmdtypes::TLMDString AName);
	void __fastcall ClearObjects(void);
	void __fastcall ClearEventHandlers(void);
	TLMDScriptEventHandler* __fastcall GetEventHandler(const Lmdtypes::TLMDString AProcName, Lmdsctwrappers::TLMDEventWrapperClass AEventType);
	void __fastcall HookEvent(System::Classes::TPersistent* AInstance, System::Typinfo::PPropInfo APropInfo, const Lmdtypes::TLMDString AProcName)/* overload */;
	void __fastcall HookEvent(System::Classes::TPersistent* AInstance, const Lmdtypes::TLMDString APropName, const Lmdtypes::TLMDString AProcName)/* overload */;
	_di_IDispatch __fastcall GetUnitInstance(Lmdsctwrappers::TLMDUnitWrapperClass AWrapperClass);
	System::TObject* __fastcall PrepareExpr(const Lmdtypes::TLMDString AExpression);
	System::TObject* __fastcall PrepareStmt(const Lmdtypes::TLMDString AStatement);
	System::OleVariant __fastcall Eval(const Lmdtypes::TLMDString AExpression)/* overload */;
	System::OleVariant __fastcall Eval(System::TObject* APreparedExpr)/* overload */;
	void __fastcall ExecuteStatement(const Lmdtypes::TLMDString AStatement)/* overload */;
	void __fastcall ExecuteStatement(System::TObject* APreparedStmt)/* overload */;
	System::OleVariant __fastcall RunProc(const Lmdtypes::TLMDString Name)/* overload */;
	System::OleVariant __fastcall RunProc(const Lmdtypes::TLMDString Name, const System::OleVariant *Args, const int Args_High)/* overload */;
	System::OleVariant __fastcall ReadVar(const Lmdtypes::TLMDString Name);
	void __fastcall WriteVar(const Lmdtypes::TLMDString Name, const System::OleVariant &Value);
	__property TLMDScriptControlState State = {read=FState, nodefault};
	__property _di_IDispatch CodeObject = {read=GetCodeObject};
	__property System::OleVariant Script = {read=GetScript};
	__property TLMDDebugModule* DebugModule = {read=FDebugModule, write=SetDebugModule};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property bool Active = {read=GetActive, write=SetActive, default=0};
	__property System::Classes::TStrings* Source = {read=FSource, write=SetSource};
	__property TLMDScriptDebugger* Debugger = {read=FDebugger, write=SetDebugger};
	__property Lmdtypes::TLMDString DebugName = {read=GetDebugName, write=SetDebugName};
	__property TLMDScriptLanguage Language = {read=FLanguage, write=SetLanguage, default=0};
	__property bool ExceptionSourceInfo = {read=FExceptionSourceInfo, write=SetExceptionSourceInfo, default=1};
	__property System::Classes::TNotifyEvent BeforePrepare = {read=FBeforePrepare, write=FBeforePrepare};
	__property System::Classes::TNotifyEvent BeforeOpen = {read=FBeforeOpen, write=FBeforeOpen};
	__property System::Classes::TNotifyEvent AfterClose = {read=FAfterClose, write=FAfterClose};
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDebugModule : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	Lmdtypes::TLMDString FName;
	void __fastcall SetName(const Lmdtypes::TLMDString Value);
	TLMDScriptDebugger* __fastcall GetDebugger(void);
	
public:
	__fastcall virtual ~TLMDDebugModule(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Delete(void);
	__property TLMDScriptDebugger* Debugger = {read=GetDebugger};
	
__published:
	__property Lmdtypes::TLMDString Name = {read=FName, write=SetName};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDDebugModule(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDebugModules : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDDebugModule* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TLMDDebugModule* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDDebugModule* const Value);
	
protected:
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	HIDESBASE TLMDDebugModule* __fastcall Add(void);
	HIDESBASE TLMDDebugModule* __fastcall FindItemID(int ID);
	TLMDDebugModule* __fastcall FindByName(const Lmdtypes::TLMDString AName);
	TLMDDebugModule* __fastcall FindOrAdd(const Lmdtypes::TLMDString AName);
	HIDESBASE TLMDDebugModule* __fastcall Insert(int Index);
	__property TLMDDebugModule* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
public:
	/* TOwnedCollection.Create */ inline __fastcall TLMDDebugModules(System::Classes::TPersistent* AOwner, System::Classes::TCollectionItemClass ItemClass) : System::Classes::TOwnedCollection(AOwner, ItemClass) { }
	
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDDebugModules(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDBreakpointState : unsigned char { bsNonactive, bsValid, bsInvalid };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBreakpointAction : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDBreakpoint* FBP;
	bool FBreak;
	Lmdtypes::TLMDString FLogMessage;
	Lmdtypes::TLMDString FEvalExpression;
	Lmdtypes::TLMDString FDisableGroup;
	Lmdtypes::TLMDString FEnableGroup;
	int FLogStackFrames;
	void __fastcall SetBreak(const bool Value);
	void __fastcall SetLogMessage(const Lmdtypes::TLMDString Value);
	void __fastcall SetLogStackFrames(const int Value);
	void __fastcall SetEvalExpression(const Lmdtypes::TLMDString Value);
	void __fastcall SetEnableGroup(const Lmdtypes::TLMDString Value);
	void __fastcall SetDisableGroup(const Lmdtypes::TLMDString Value);
	
public:
	__fastcall TLMDBreakpointAction(TLMDBreakpoint* ABP);
	__property bool Break = {read=FBreak, write=SetBreak, nodefault};
	__property Lmdtypes::TLMDString LogMessage = {read=FLogMessage, write=SetLogMessage};
	__property int LogStackFrames = {read=FLogStackFrames, write=SetLogStackFrames, nodefault};
	__property Lmdtypes::TLMDString EvalExpression = {read=FEvalExpression, write=SetEvalExpression};
	__property Lmdtypes::TLMDString EnableGroup = {read=FEnableGroup, write=SetEnableGroup};
	__property Lmdtypes::TLMDString DisableGroup = {read=FDisableGroup, write=SetDisableGroup};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBreakpointAction(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDBreakpoint : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDScriptDebugger* FDebugger;
	TLMDDebugModule* FModule;
	int FLine;
	bool FEnabled;
	Lmdtypes::TLMDString FCondition;
	int FPassCount;
	int FCurrentPassCount;
	Lmdtypes::TLMDString FGroup;
	TLMDBreakpointAction* FAction;
	bool FValid;
	void *FData;
	void __fastcall InternalSetCrPassCount(int AValue);
	TLMDBreakpointState __fastcall GetState(void);
	void __fastcall SetEnabled(const bool Value);
	void __fastcall SetCondition(const Lmdtypes::TLMDString Value);
	void __fastcall SetPassCount(const int Value);
	void __fastcall SetGroup(const Lmdtypes::TLMDString Value);
	int __fastcall GetIndex(void);
	
public:
	__fastcall TLMDBreakpoint(TLMDScriptDebugger* ADebugger, TLMDDebugModule* AModule, int ALine)/* overload */;
	__fastcall virtual ~TLMDBreakpoint(void);
	void __fastcall Delete(void);
	__property TLMDScriptDebugger* Debugger = {read=FDebugger};
	__property int Index = {read=GetIndex, nodefault};
	__property TLMDDebugModule* Module = {read=FModule};
	__property int Line = {read=FLine, nodefault};
	__property bool Enabled = {read=FEnabled, write=SetEnabled, nodefault};
	__property Lmdtypes::TLMDString Condition = {read=FCondition, write=SetCondition};
	__property int PassCount = {read=FPassCount, write=SetPassCount, nodefault};
	__property Lmdtypes::TLMDString Group = {read=FGroup, write=SetGroup};
	__property int CurrentPassCount = {read=FCurrentPassCount, nodefault};
	__property TLMDBreakpointAction* Action = {read=FAction};
	__property TLMDBreakpointState State = {read=GetState, nodefault};
	__property void * Data = {read=FData, write=FData};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDVariableFlag : unsigned char { vfReadonly, vfPublic, vfPrivate, vfProtected, vfFinal, vfGlobal, vfStatic, vfField, vfVirtual, vfConstant, vfSynchronized, vfVolatile };

typedef System::Set<TLMDVariableFlag, TLMDVariableFlag::vfReadonly, TLMDVariableFlag::vfVolatile> TLMDVariableFlags;

class PASCALIMPLEMENTATION TLMDVariables : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FChanged;
	int FUpdateCount;
	TLMDVariable* FRoot;
	TLMDScriptDebugger* FDebugger;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall InitProc(const System::_di_IInterface ARunnerVar, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AType, const Lmdtypes::TLMDString AValue, TLMDVariableFlags AFlags, bool AExpandable);
	
protected:
	virtual void __fastcall DoChange(void);
	
public:
	__fastcall TLMDVariables(void);
	__fastcall virtual ~TLMDVariables(void);
	void __fastcall Changed(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	void __fastcall Clear(void);
	__property TLMDVariable* Root = {read=FRoot};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDVariable : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDVariable* operator[](int AIndex) { return this->Items[AIndex]; }
	
private:
	int FId;
	TLMDVariables* FOwner;
	TLMDVariable* FParent;
	bool FItemsFilled;
	System::Classes::TList* FItems;
	System::_di_IInterface FRunnerVar;
	Lmdtypes::TLMDString FValue;
	Lmdtypes::TLMDString FType_;
	Lmdtypes::TLMDString FName;
	TLMDVariableFlags FFlags;
	bool FExpandable;
	int __fastcall GetCount(void);
	TLMDVariable* __fastcall GetItems(int AIndex);
	void __fastcall AddItemProc(const System::_di_IInterface ARunnerVar, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AType, const Lmdtypes::TLMDString AValue, TLMDVariableFlags AFlags, bool AExpandable);
	void __fastcall FillItems(void);
	void __fastcall ClearItems(void);
	int __fastcall GetNextId(void);
	
public:
	__fastcall TLMDVariable(TLMDVariables* AOwner, TLMDVariable* AParent, const System::_di_IInterface ARunnerVar, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AType, const Lmdtypes::TLMDString AValue, TLMDVariableFlags AFlags, bool AExpandable);
	__fastcall virtual ~TLMDVariable(void);
	int __fastcall IndexOfId(int AId);
	__property int Id = {read=FId, nodefault};
	__property Lmdtypes::TLMDString Name = {read=FName};
	__property Lmdtypes::TLMDString Type_ = {read=FType_};
	__property Lmdtypes::TLMDString Value = {read=FValue};
	__property TLMDVariableFlags Flags = {read=FFlags, nodefault};
	__property bool Expandable = {read=FExpandable, nodefault};
	__property TLMDVariable* Parent = {read=FParent};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDVariable* Items[int AIndex] = {read=GetItems/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDStackFrame : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDScriptDebugger* FDebugger;
	System::TObject* FRunnerFrame;
	bool FOwnRunnerFrame;
	TLMDScriptControl* FScriptControl;
	int FLine;
	int __fastcall GetIndex(void);
	Lmdtypes::TLMDString __fastcall GetLongDescription(void);
	Lmdtypes::TLMDString __fastcall GetShortDescription(void);
	TLMDDebugModule* __fastcall GetModule(void);
	
public:
	__fastcall TLMDStackFrame(TLMDScriptDebugger* ADebugger, System::TObject* ARunnerFrame, bool AOwnRunnerFrame, TLMDScriptControl* AScriptControl, int ALine);
	__fastcall virtual ~TLMDStackFrame(void);
	void __fastcall Eval(const Lmdtypes::TLMDString AExpression, TLMDVariables* AResult)/* overload */;
	Lmdtypes::TLMDString __fastcall Eval(const Lmdtypes::TLMDString AExpression)/* overload */;
	void __fastcall GetVariables(TLMDVariables* AResult);
	__property int Index = {read=GetIndex, nodefault};
	__property TLMDScriptControl* ScriptControl = {read=FScriptControl};
	__property TLMDDebugModule* Module = {read=GetModule};
	__property int Line = {read=FLine, nodefault};
	__property Lmdtypes::TLMDString LongDescription = {read=GetLongDescription};
	__property Lmdtypes::TLMDString ShortDescription = {read=GetShortDescription};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDBreakKind : unsigned char { bkNone, bkBreakpoint, bkStep, bkCausedBreak };

enum DECLSPEC_DENUM TLMDBreakResumeKind : unsigned char { rkStepOver, rkStepInto, rkContinue, rkAbort };

enum DECLSPEC_DENUM TLMDDebugMsgKind : unsigned char { dmDebuggerOutput, dmBreakpointReached, dmLogMessage, dmEvalExpr, dmLogStackHeader, dmLogStackFrame };

typedef System::Set<TLMDDebugMsgKind, TLMDDebugMsgKind::dmDebuggerOutput, TLMDDebugMsgKind::dmLogStackFrame> TLMDDebugMsgKinds;

enum DECLSPEC_DENUM TLMDAdjustBPKind : unsigned char { abkSet, abkRemove, abkCorrectLine };

#pragma pack(push,4)
class PASCALIMPLEMENTATION ILMDScriptDebuggerNotifier : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	virtual void __fastcall Breaked(TLMDScriptDebugger* ADebugger) = 0 ;
	virtual void __fastcall Resumed(TLMDScriptDebugger* ADebugger) = 0 ;
	virtual void __fastcall DebugNameChanged(TLMDScriptDebugger* ADebugger, TLMDScriptControl* AScript) = 0 ;
	virtual void __fastcall LogMessage(TLMDScriptDebugger* ADebugger, const Lmdtypes::TLMDString AMsg, TLMDDebugMsgKind AKind) = 0 ;
	virtual void __fastcall BreakpointsChanged(TLMDScriptDebugger* ADebugger) = 0 ;
public:
	/* TObject.Create */ inline __fastcall ILMDScriptDebuggerNotifier(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~ILMDScriptDebuggerNotifier(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDBreakEvent)(System::TObject* Sender, TLMDScriptControl* AScriptControl, int ALine);

typedef void __fastcall (__closure *TLMDInvalidBreakpointEvent)(System::TObject* Sender, TLMDBreakpoint* ABreakpoint);

typedef void __fastcall (__closure *TLMDFormatDebugMsgEvent)(System::TObject* Sender, TLMDDebugMsgKind AMsgKind, TLMDBreakpoint* BP, const Lmdtypes::TLMDString S, TLMDStackFrame* AFRame, Lmdtypes::TLMDString &AMsg);

typedef void __fastcall (__closure *TLMDLogMessageEvent)(System::TObject* Sender, TLMDDebugMsgKind AKind, const Lmdtypes::TLMDString AMsg);

class PASCALIMPLEMENTATION TLMDScriptDebugger : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDDebugModules* FModules;
	Lmdsvcpvdr::TLMDServiceProvider* FServiceProvider;
	System::Classes::TList* FScripts;
	System::Classes::TList* FBreakpoints;
	System::TObject* FRunnerDebug;
	TLMDBreakKind FBreakKind;
	bool FLoggingStack;
	System::Classes::TList* FStackFrames;
	bool FIsSynchBreaks;
	System::Classes::TList* FNotifiers;
	TLMDBreakEvent FOnBreak;
	System::Classes::TNotifyEvent FOnResume;
	TLMDInvalidBreakpointEvent FOnInvalidBreakpoint;
	TLMDFormatDebugMsgEvent FOnFormatDebugMsg;
	TLMDLogMessageEvent FOnLogMessage;
	System::Classes::TNotifyEvent FOnBreakpointsChanged;
	void __fastcall InsertScriptItem(TLMDScriptControl* AItem);
	void __fastcall RemoveScriptItem(TLMDScriptControl* AItem);
	void __fastcall ScriptItemLangChanged(TLMDScriptControl* AItem);
	void __fastcall DisconnectScripts(void);
	void __fastcall AdjustRunnerDebug(void);
	void __fastcall ModuleDeleting(TLMDDebugModule* AModule);
	void __fastcall ScriptDebugModuleChanged(TLMDScriptControl* AItem);
	void __fastcall LogDebugMsg(TLMDDebugMsgKind AKind, TLMDBreakpoint* BP, const Lmdtypes::TLMDString S = Lmdtypes::TLMDString(), TLMDStackFrame* AFrame = (TLMDStackFrame*)(0x0));
	void __fastcall InsertBreakpointItem(TLMDBreakpoint* AItem);
	void __fastcall RemoveBreakpointItem(TLMDBreakpoint* AItem);
	int __fastcall GetBreakpointCount(void);
	TLMDBreakpoint* __fastcall GetBreakpoints(int AIndex);
	void __fastcall SetBreakpointGroupEnabled(const Lmdtypes::TLMDString AGroup, bool AValue);
	void __fastcall AdjustBreakpoint(TLMDBreakpoint* BP, TLMDAdjustBPKind AAdjustKind, int AOldLine = 0xffffffff);
	void __fastcall AddStackFrameProc(System::TObject* ARunnerFrame, bool AOwnRunnerFrame, TLMDScriptControl* AScriptControl, int ALine);
	void __fastcall UpdateStackFrames(void);
	void __fastcall ClearStackFrames(void);
	void __fastcall HandleBreak(TLMDBreakKind ABreakKind, TLMDScriptControl* AScript, int ALine);
	void __fastcall CheckInBerak(void);
	int __fastcall GetStackFrameCount(void);
	TLMDStackFrame* __fastcall GetStackFrames(int AIndex);
	void __fastcall SetIsSynchBreaks(const bool Value);
	void __fastcall SetServiceProvider(Lmdsvcpvdr::TLMDServiceProvider* const Value);
	void __fastcall SetModules(TLMDDebugModules* const Value);
	
protected:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall DoBreakpoint(TLMDScriptControl* AScriptControl, int ALine);
	virtual void __fastcall DoResume(void);
	virtual void __fastcall DoInvalidBreakpoint(TLMDBreakpoint* ABreakpoint);
	virtual void __fastcall DoFormatDebugMsg(TLMDDebugMsgKind AMsgKind, TLMDBreakpoint* BP, const Lmdtypes::TLMDString S, TLMDStackFrame* AFrame, Lmdtypes::TLMDString &AMsg);
	virtual void __fastcall DoLogMessage(TLMDDebugMsgKind AKind, const Lmdtypes::TLMDString AMsg);
	virtual void __fastcall DoBreakpointsChanged(void);
	
public:
	__fastcall virtual TLMDScriptDebugger(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDScriptDebugger(void);
	void __fastcall ResetBreakpointsState(void);
	TLMDBreakpoint* __fastcall FindBreakpoint(TLMDDebugModule* AModule, int ALine)/* overload */;
	TLMDBreakpoint* __fastcall SetBreakpoint(TLMDDebugModule* AModule, int ALine)/* overload */;
	void __fastcall MoveBreakpoints(TLMDBreakpoint* const *ABreakpoints, const int ABreakpoints_High, const int *ANewLines, const int ANewLines_High);
	void __fastcall EnableGroup(const Lmdtypes::TLMDString AGroup);
	void __fastcall DisableGroup(const Lmdtypes::TLMDString AGroup);
	void __fastcall ClearBreakpoints(void)/* overload */;
	void __fastcall ClearBreakpoints(TLMDDebugModule* AModule)/* overload */;
	void __fastcall CauseBreak(void);
	void __fastcall ResumeFromBreak(TLMDBreakResumeKind AKind);
	void __fastcall AddNotifier(ILMDScriptDebuggerNotifier* ANotifier);
	void __fastcall RemoveNotifier(ILMDScriptDebuggerNotifier* ANotifier);
	__property int BreakpointCount = {read=GetBreakpointCount, nodefault};
	__property TLMDBreakpoint* Breakpoints[int AIndex] = {read=GetBreakpoints};
	__property TLMDBreakKind BreakKind = {read=FBreakKind, nodefault};
	__property int StackFrameCount = {read=GetStackFrameCount, nodefault};
	__property TLMDStackFrame* StackFrames[int AIndex] = {read=GetStackFrames};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property TLMDDebugModules* Modules = {read=FModules, write=SetModules};
	__property bool IsSynchBreaks = {read=FIsSynchBreaks, write=SetIsSynchBreaks, default=0};
	__property Lmdsvcpvdr::TLMDServiceProvider* ServiceProvider = {read=FServiceProvider, write=SetServiceProvider};
	__property TLMDBreakEvent OnBreak = {read=FOnBreak, write=FOnBreak};
	__property System::Classes::TNotifyEvent OnResume = {read=FOnResume, write=FOnResume};
	__property TLMDInvalidBreakpointEvent OnInvalidBreakpoint = {read=FOnInvalidBreakpoint, write=FOnInvalidBreakpoint};
	__property TLMDFormatDebugMsgEvent OnFormatDebugMsg = {read=FOnFormatDebugMsg, write=FOnFormatDebugMsg};
	__property TLMDLogMessageEvent OnLogMessage = {read=FOnLogMessage, write=FOnLogMessage};
	__property System::Classes::TNotifyEvent OnBreakpointsChanged = {read=FOnBreakpointsChanged, write=FOnBreakpointsChanged};
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<TLMDScriptLangKind, 9> LMDScriptLangKinds;
static const int LMDAllStackFrames = int(2147483647);
#define LMDAllMsgKinds (System::Set<TLMDDebugMsgKind, TLMDDebugMsgKind::dmDebuggerOutput, TLMDDebugMsgKind::dmLogStackFrame>() << TLMDDebugMsgKind::dmDebuggerOutput << TLMDDebugMsgKind::dmBreakpointReached << TLMDDebugMsgKind::dmLogMessage << TLMDDebugMsgKind::dmEvalExpr << TLMDDebugMsgKind::dmLogStackHeader << TLMDDebugMsgKind::dmLogStackFrame )
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall LMDScriptLangToStr(TLMDScriptLanguage ALanguage);
extern DELPHI_PACKAGE TLMDScriptLanguage __fastcall LMDStrToScriptLang(const Lmdtypes::TLMDString S);
extern DELPHI_PACKAGE bool __fastcall LMDHasErrorMessageInfo(const System::WideString AMsg);
extern DELPHI_PACKAGE void __fastcall LMDEncodeErrorMessageInfo(System::TObject* ASource, int ALine, int APos, System::WideString &AMsg);
extern DELPHI_PACKAGE bool __fastcall LMDDecodeErrorMessageInfo(const System::WideString AMsg, /* out */ System::WideString &AOriginalMsg, /* out */ TLMDScriptControl* &ASource, /* out */ int &ALine, /* out */ int &APos);
}	/* namespace Lmdsctscripter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTSCRIPTER)
using namespace Lmdsctscripter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctscripterHPP
