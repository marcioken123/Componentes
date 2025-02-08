// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSctMSScriptTLB.pas' rev: 31.00 (Windows)

#ifndef LmdsctmsscripttlbHPP
#define LmdsctmsscripttlbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.OleServer.hpp>
#include <System.Win.StdVCL.hpp>
#include <System.Variants.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsctmsscripttlb
{
//-- forward type declarations -----------------------------------------------
__interface IProcessDebugManager;
typedef System::DelphiInterface<IProcessDebugManager> _di_IProcessDebugManager;
__interface IDebugHelper;
typedef System::DelphiInterface<IDebugHelper> _di_IDebugHelper;
__interface IDebugDocumentHelper;
typedef System::DelphiInterface<IDebugDocumentHelper> _di_IDebugDocumentHelper;
__interface IMachineDebugManager;
typedef System::DelphiInterface<IMachineDebugManager> _di_IMachineDebugManager;
__interface IDebugSessionProvider;
typedef System::DelphiInterface<IDebugSessionProvider> _di_IDebugSessionProvider;
struct __MIDL___MIDL_itf_activdbg_full_0006_0001;
struct tagEXCEPINFO;
struct __MIDL___MIDL_itf_activdbg_full_0000_0006;
struct __MIDL___MIDL_itf_activdbg_full_0000_0007;
struct __MIDL___MIDL_itf_activdbg_full_0000_0009;
struct __MIDL___MIDL_itf_activdbg_full_0000_0010;
struct __MIDL___MIDL_itf_activdbg_full_0000_0014;
struct __MIDL___MIDL_itf_activdbg_full_0000_0008;
struct __MIDL___MIDL_itf_activdbg_full_0000_0011;
struct __MIDL_IWinTypes_0009;
struct _RemotableHandle;
__interface IActiveScriptDebug;
typedef System::DelphiInterface<IActiveScriptDebug> _di_IActiveScriptDebug;
__interface IEnumDebugCodeContexts;
typedef System::DelphiInterface<IEnumDebugCodeContexts> _di_IEnumDebugCodeContexts;
__interface IDebugCodeContext;
typedef System::DelphiInterface<IDebugCodeContext> _di_IDebugCodeContext;
__interface IDebugDocumentContext;
typedef System::DelphiInterface<IDebugDocumentContext> _di_IDebugDocumentContext;
__interface IDebugDocumentInfo;
typedef System::DelphiInterface<IDebugDocumentInfo> _di_IDebugDocumentInfo;
__interface IDebugDocument;
typedef System::DelphiInterface<IDebugDocument> _di_IDebugDocument;
__interface IActiveScriptError;
typedef System::DelphiInterface<IActiveScriptError> _di_IActiveScriptError;
__interface IActiveScriptErrorDebug;
typedef System::DelphiInterface<IActiveScriptErrorDebug> _di_IActiveScriptErrorDebug;
__interface IDebugStackFrame;
typedef System::DelphiInterface<IDebugStackFrame> _di_IDebugStackFrame;
__interface IRemoteDebugApplicationThread;
typedef System::DelphiInterface<IRemoteDebugApplicationThread> _di_IRemoteDebugApplicationThread;
__interface IDebugApplicationThread;
typedef System::DelphiInterface<IDebugApplicationThread> _di_IDebugApplicationThread;
__interface IRemoteDebugApplication;
typedef System::DelphiInterface<IRemoteDebugApplication> _di_IRemoteDebugApplication;
__interface IApplicationDebugger;
typedef System::DelphiInterface<IApplicationDebugger> _di_IApplicationDebugger;
__interface IEnumRemoteDebugApplicationThreads;
typedef System::DelphiInterface<IEnumRemoteDebugApplicationThreads> _di_IEnumRemoteDebugApplicationThreads;
__interface IDebugDocumentProvider;
typedef System::DelphiInterface<IDebugDocumentProvider> _di_IDebugDocumentProvider;
__interface IDebugApplicationNode;
typedef System::DelphiInterface<IDebugApplicationNode> _di_IDebugApplicationNode;
__interface IEnumDebugApplicationNodes;
typedef System::DelphiInterface<IEnumDebugApplicationNodes> _di_IEnumDebugApplicationNodes;
__interface IEnumDebugExpressionContexts;
typedef System::DelphiInterface<IEnumDebugExpressionContexts> _di_IEnumDebugExpressionContexts;
__interface IDebugExpressionContext;
typedef System::DelphiInterface<IDebugExpressionContext> _di_IDebugExpressionContext;
__interface IDebugExpression;
typedef System::DelphiInterface<IDebugExpression> _di_IDebugExpression;
__interface IDebugExpressionCallBack;
typedef System::DelphiInterface<IDebugExpressionCallBack> _di_IDebugExpressionCallBack;
__interface IDebugProperty;
typedef System::DelphiInterface<IDebugProperty> _di_IDebugProperty;
__interface IEnumDebugPropertyInfo;
typedef System::DelphiInterface<IEnumDebugPropertyInfo> _di_IEnumDebugPropertyInfo;
__interface IEnumDebugStackFrames;
typedef System::DelphiInterface<IEnumDebugStackFrames> _di_IEnumDebugStackFrames;
__interface IDebugThreadCall;
typedef System::DelphiInterface<IDebugThreadCall> _di_IDebugThreadCall;
__interface IActiveScriptSiteDebug;
typedef System::DelphiInterface<IActiveScriptSiteDebug> _di_IActiveScriptSiteDebug;
__interface IDebugApplication;
typedef System::DelphiInterface<IDebugApplication> _di_IDebugApplication;
__interface IDebugSyncOperation;
typedef System::DelphiInterface<IDebugSyncOperation> _di_IDebugSyncOperation;
__interface IDebugAsyncOperation;
typedef System::DelphiInterface<IDebugAsyncOperation> _di_IDebugAsyncOperation;
__interface IDebugAsyncOperationCallBack;
typedef System::DelphiInterface<IDebugAsyncOperationCallBack> _di_IDebugAsyncOperationCallBack;
__interface IDebugStackFrameSniffer;
typedef System::DelphiInterface<IDebugStackFrameSniffer> _di_IDebugStackFrameSniffer;
__interface IActiveScriptSite;
typedef System::DelphiInterface<IActiveScriptSite> _di_IActiveScriptSite;
__interface IProvideExpressionContexts;
typedef System::DelphiInterface<IProvideExpressionContexts> _di_IProvideExpressionContexts;
__interface IApplicationDebuggerUI;
typedef System::DelphiInterface<IApplicationDebuggerUI> _di_IApplicationDebuggerUI;
__interface IDebugDocumentText;
typedef System::DelphiInterface<IDebugDocumentText> _di_IDebugDocumentText;
__interface IDebugApplicationNodeEvents;
typedef System::DelphiInterface<IDebugApplicationNodeEvents> _di_IDebugApplicationNodeEvents;
__interface IDebugCookie;
typedef System::DelphiInterface<IDebugCookie> _di_IDebugCookie;
__interface IDebugDocumentHost;
typedef System::DelphiInterface<IDebugDocumentHost> _di_IDebugDocumentHost;
__interface IActiveScript;
typedef System::DelphiInterface<IActiveScript> _di_IActiveScript;
__interface IDebugDocumentTextAuthor;
typedef System::DelphiInterface<IDebugDocumentTextAuthor> _di_IDebugDocumentTextAuthor;
__interface IDebugDocumentTextEvents;
typedef System::DelphiInterface<IDebugDocumentTextEvents> _di_IDebugDocumentTextEvents;
__interface IDebugDocumentTextExternalAuthor;
typedef System::DelphiInterface<IDebugDocumentTextExternalAuthor> _di_IDebugDocumentTextExternalAuthor;
__interface IDebugFormatter;
typedef System::DelphiInterface<IDebugFormatter> _di_IDebugFormatter;
__interface ISimpleConnectionPoint;
typedef System::DelphiInterface<ISimpleConnectionPoint> _di_ISimpleConnectionPoint;
__interface IDebugStackFrameSnifferEx;
typedef System::DelphiInterface<IDebugStackFrameSnifferEx> _di_IDebugStackFrameSnifferEx;
__interface IEnumRemoteDebugApplications;
typedef System::DelphiInterface<IEnumRemoteDebugApplications> _di_IEnumRemoteDebugApplications;
__interface IMachineDebugManagerCookie;
typedef System::DelphiInterface<IMachineDebugManagerCookie> _di_IMachineDebugManagerCookie;
__interface IMachineDebugManagerEvents;
typedef System::DelphiInterface<IMachineDebugManagerEvents> _di_IMachineDebugManagerEvents;
__interface IRemoteDebugApplicationEvents;
typedef System::DelphiInterface<IRemoteDebugApplicationEvents> _di_IRemoteDebugApplicationEvents;
__interface IConnectionPointContainer;
typedef System::DelphiInterface<IConnectionPointContainer> _di_IConnectionPointContainer;
__interface IEnumConnectionPoints;
typedef System::DelphiInterface<IEnumConnectionPoints> _di_IEnumConnectionPoints;
__interface IConnectionPoint;
typedef System::DelphiInterface<IConnectionPoint> _di_IConnectionPoint;
__interface IEnumConnections;
typedef System::DelphiInterface<IEnumConnections> _di_IEnumConnections;
__interface IActiveScriptParseProcedure;
typedef System::DelphiInterface<IActiveScriptParseProcedure> _di_IActiveScriptParseProcedure;
__interface IActiveScriptStats;
typedef System::DelphiInterface<IActiveScriptStats> _di_IActiveScriptStats;
__interface IActiveScriptParseProcedureOld;
typedef System::DelphiInterface<IActiveScriptParseProcedureOld> _di_IActiveScriptParseProcedureOld;
__interface IActiveScriptParse;
typedef System::DelphiInterface<IActiveScriptParse> _di_IActiveScriptParse;
__interface IActiveScriptSiteWindow;
typedef System::DelphiInterface<IActiveScriptSiteWindow> _di_IActiveScriptSiteWindow;
__interface IActiveScriptSiteInterruptPoll;
typedef System::DelphiInterface<IActiveScriptSiteInterruptPoll> _di_IActiveScriptSiteInterruptPoll;
class DELPHICLASS CoProcessDebugManager;
class DELPHICLASS TProcessDebugManager;
class DELPHICLASS CoDebugHelper;
class DELPHICLASS TDebugHelper;
class DELPHICLASS CoCDebugDocumentHelper;
class DELPHICLASS TCDebugDocumentHelper;
class DELPHICLASS CoMachineDebugManager;
class DELPHICLASS TMachineDebugManager;
class DELPHICLASS CoDefaultDebugSessionProvider;
class DELPHICLASS TDefaultDebugSessionProvider;
//-- type declarations -------------------------------------------------------
typedef Winapi::Activex::TOleEnum __MIDL___MIDL_itf_activdbg_full_0000_0003;

typedef Winapi::Activex::TOleEnum __MIDL___MIDL_itf_activdbg_full_0000_0004;

typedef Winapi::Activex::TOleEnum __MIDL___MIDL_itf_activdbg_full_0000_0001;

typedef Winapi::Activex::TOleEnum __MIDL___MIDL_itf_activdbg_full_0000_0002;

typedef Winapi::Activex::TOleEnum __MIDL___MIDL_itf_activdbg_full_0000_0005;

typedef Winapi::Activex::TOleEnum __MIDL___MIDL_itf_activdbg_full_0000_0012;

typedef Winapi::Activex::TOleEnum __MIDL___MIDL_itf_activdbg_full_0000_0013;

typedef Winapi::Activex::TOleEnum tagBREAKRESUMEACTION;

typedef _di_IProcessDebugManager ProcessDebugManager;

typedef _di_IDebugHelper DebugHelper;

typedef _di_IDebugDocumentHelper CDebugDocumentHelper;

typedef _di_IMachineDebugManager MachineDebugManager;

typedef _di_IDebugSessionProvider DefaultDebugSessionProvider;

typedef _RemotableHandle *wireHWND;

typedef __MIDL___MIDL_itf_activdbg_full_0006_0001 *PUserType1;

typedef System::OleVariant *POleVariant1;

typedef tagEXCEPINFO *PUserType2;

typedef System::Word *PWord1;

typedef short *PSmallint1;

typedef __MIDL___MIDL_itf_activdbg_full_0000_0010 *PUserType3;

#pragma pack(push,1)
struct DECLSPEC_DRECORD __MIDL___MIDL_itf_activdbg_full_0006_0001
{
public:
	unsigned Data1;
	System::Word Data2;
	System::Word Data3;
	System::StaticArray<System::Byte, 8> Data4;
};
#pragma pack(pop)


typedef __MIDL___MIDL_itf_activdbg_full_0006_0001 GUID;

typedef Winapi::Activex::TOleEnum tagDOCUMENTNAMETYPE;

typedef Winapi::Activex::TOleEnum tagBREAKPOINT_STATE;

typedef unsigned ULONG_PTR;

#pragma pack(push,1)
struct DECLSPEC_DRECORD tagEXCEPINFO
{
public:
	System::Word wCode;
	System::Word wReserved;
	System::WideString bstrSource;
	System::WideString bstrDescription;
	System::WideString bstrHelpFile;
	unsigned dwHelpContext;
	unsigned pvReserved;
	unsigned pfnDeferredFillIn;
	int scode;
};
#pragma pack(pop)


typedef tagEXCEPINFO EXCEPINFO;

typedef Winapi::Activex::TOleEnum tagBREAKRESUME_ACTION;

typedef Winapi::Activex::TOleEnum tagERRORRESUMEACTION;

typedef Winapi::Activex::TOleEnum tagBREAKREASON;

#pragma pack(push,1)
struct DECLSPEC_DRECORD __MIDL___MIDL_itf_activdbg_full_0000_0006
{
public:
	unsigned m_dwValidFields;
	System::WideString m_bstrName;
	System::WideString m_bstrType;
	System::WideString m_bstrValue;
	System::WideString m_bstrFullName;
	unsigned m_dwAttrib;
	_di_IDebugProperty m_pDebugProp;
};
#pragma pack(pop)


typedef __MIDL___MIDL_itf_activdbg_full_0000_0006 tagDebugPropertyInfo;

#pragma pack(push,1)
struct DECLSPEC_DRECORD __MIDL___MIDL_itf_activdbg_full_0000_0007
{
public:
	_di_IDebugStackFrame pdsf;
	unsigned dwMin;
	unsigned dwLim;
	int fFinal;
	System::_di_IInterface punkFinal;
};
#pragma pack(pop)


typedef __MIDL___MIDL_itf_activdbg_full_0000_0007 tagDebugStackFrameDescriptor;

typedef Winapi::Activex::TOleEnum tagSCRIPTSTATE;

typedef Winapi::Activex::TOleEnum tagSCRIPTTHREADSTATE;

struct DECLSPEC_DRECORD __MIDL___MIDL_itf_activdbg_full_0000_0009
{
	
public:
	union
	{
		struct 
		{
			unsigned hreftype;
		};
		struct 
		{
			void *lpadesc;
		};
		struct 
		{
			void *lptdesc;
		};
		
	};
};


typedef __MIDL___MIDL_itf_activdbg_full_0000_0009 __MIDL_IOleAutomationTypes_0005;

#pragma pack(push,1)
struct DECLSPEC_DRECORD __MIDL___MIDL_itf_activdbg_full_0000_0010
{
public:
	__MIDL___MIDL_itf_activdbg_full_0000_0009 __MIDL_0014;
	System::Word vt;
};
#pragma pack(pop)


typedef __MIDL___MIDL_itf_activdbg_full_0000_0010 tagTYPEDESC;

#pragma pack(push,1)
struct DECLSPEC_DRECORD __MIDL___MIDL_itf_activdbg_full_0000_0014
{
public:
	System::_di_IInterface punk;
	unsigned dwCookie;
};
#pragma pack(pop)


typedef __MIDL___MIDL_itf_activdbg_full_0000_0014 tagCONNECTDATA;

typedef unsigned DWORD;

#pragma pack(push,1)
struct DECLSPEC_DRECORD __MIDL___MIDL_itf_activdbg_full_0000_0008
{
public:
	unsigned cElements;
	int lLbound;
};
#pragma pack(pop)


typedef __MIDL___MIDL_itf_activdbg_full_0000_0008 tagSAFEARRAYBOUND;

#pragma pack(push,1)
struct DECLSPEC_DRECORD __MIDL___MIDL_itf_activdbg_full_0000_0011
{
public:
	__MIDL___MIDL_itf_activdbg_full_0000_0010 tdescElem;
	System::Word cDims;
	__MIDL___MIDL_itf_activdbg_full_0000_0008 *rgbounds;
};
#pragma pack(pop)


typedef __MIDL___MIDL_itf_activdbg_full_0000_0011 tagARRAYDESC;

struct DECLSPEC_DRECORD __MIDL_IWinTypes_0009
{
	
public:
	union
	{
		struct 
		{
			int hRemote;
		};
		struct 
		{
			int hInproc;
		};
		
	};
};


#pragma pack(push,1)
struct DECLSPEC_DRECORD _RemotableHandle
{
public:
	int fContext;
	__MIDL_IWinTypes_0009 u;
};
#pragma pack(pop)


__interface  INTERFACE_UUID("{51973C10-CB0C-11D0-B5C9-00A0244A0E7A}") IActiveScriptDebug  : public System::IInterface 
{
	virtual HRESULT __safecall GetScriptTextAttributes(System::WideChar * pstrCode, unsigned uNumCodeChars, System::WideChar * pstrDelimiter, unsigned dwFlags, System::Word &pattr) = 0 ;
	virtual HRESULT __safecall GetScriptletTextAttributes(System::WideChar * pstrCode, unsigned uNumCodeChars, System::WideChar * pstrDelimiter, unsigned dwFlags, System::Word &pattr) = 0 ;
	virtual HRESULT __safecall EnumCodeContextsOfPosition(unsigned dwSourceContext, unsigned uCharacterOffset, unsigned uNumChars, /* out */ _di_IEnumDebugCodeContexts &ppescc) = 0 ;
};

__interface  INTERFACE_UUID("{51973C1D-CB0C-11D0-B5C9-00A0244A0E7A}") IEnumDebugCodeContexts  : public System::IInterface 
{
	virtual HRESULT __safecall RemoteNext(unsigned celt, /* out */ _di_IDebugCodeContext &pscc, /* out */ unsigned &pceltFetched) = 0 ;
	virtual HRESULT __safecall Skip(unsigned celt) = 0 ;
	virtual HRESULT __safecall Reset(void) = 0 ;
	virtual HRESULT __safecall Clone(/* out */ _di_IEnumDebugCodeContexts &ppescc) = 0 ;
};

__interface  INTERFACE_UUID("{51973C13-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugCodeContext  : public System::IInterface 
{
	virtual HRESULT __safecall GetDocumentContext(/* out */ _di_IDebugDocumentContext &ppsc) = 0 ;
	virtual HRESULT __safecall SetBreakPoint(Winapi::Activex::TOleEnum bps) = 0 ;
};

__interface  INTERFACE_UUID("{51973C28-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugDocumentContext  : public System::IInterface 
{
	virtual HRESULT __safecall GetDocument(/* out */ _di_IDebugDocument &ppsd) = 0 ;
	virtual HRESULT __safecall EnumCodeContexts(/* out */ _di_IEnumDebugCodeContexts &ppescc) = 0 ;
};

__interface  INTERFACE_UUID("{51973C1F-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugDocumentInfo  : public System::IInterface 
{
	virtual HRESULT __safecall GetName(Winapi::Activex::TOleEnum dnt, /* out */ System::WideString &pbstrName) = 0 ;
	virtual HRESULT __safecall GetDocumentClassId(/* out */ __MIDL___MIDL_itf_activdbg_full_0006_0001 &pclsidDocument) = 0 ;
};

__interface  INTERFACE_UUID("{51973C21-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugDocument  : public IDebugDocumentInfo 
{
	
};

__interface  INTERFACE_UUID("{EAE1BA61-A4ED-11CF-8F20-00805F2CD064}") IActiveScriptError  : public System::IInterface 
{
	virtual HRESULT __safecall RemoteGetExceptionInfo(/* out */ tagEXCEPINFO &pexcepinfo) = 0 ;
	virtual HRESULT __safecall GetSourcePosition(/* out */ unsigned &pdwSourceContext, /* out */ unsigned &pulLineNumber, /* out */ int &plCharacterPosition) = 0 ;
	virtual HRESULT __safecall GetSourceLineText(/* out */ System::WideString &pbstrSourceLine) = 0 ;
};

__interface  INTERFACE_UUID("{51973C12-CB0C-11D0-B5C9-00A0244A0E7A}") IActiveScriptErrorDebug  : public IActiveScriptError 
{
	virtual HRESULT __safecall GetDocumentContext(/* out */ _di_IDebugDocumentContext &ppssc) = 0 ;
	virtual HRESULT __safecall GetStackFrame(/* out */ _di_IDebugStackFrame &ppdsf) = 0 ;
};

__interface  INTERFACE_UUID("{51973C17-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugStackFrame  : public System::IInterface 
{
	virtual HRESULT __safecall GetCodeContext(/* out */ _di_IDebugCodeContext &ppcc) = 0 ;
	virtual HRESULT __safecall GetDescriptionString(int fLong, /* out */ System::WideString &pbstrDescription) = 0 ;
	virtual HRESULT __safecall GetLanguageString(int fLong, /* out */ System::WideString &pbstrLanguage) = 0 ;
	virtual HRESULT __safecall GetThread(/* out */ _di_IDebugApplicationThread &ppat) = 0 ;
	virtual HRESULT __safecall GetDebugProperty(/* out */ _di_IDebugProperty &ppDebugProp) = 0 ;
};

__interface  INTERFACE_UUID("{51973C37-CB0C-11D0-B5C9-00A0244A0E7A}") IRemoteDebugApplicationThread  : public System::IInterface 
{
	virtual HRESULT __safecall GetSystemThreadId(/* out */ unsigned &dwThreadId) = 0 ;
	virtual HRESULT __safecall GetApplication(/* out */ _di_IRemoteDebugApplication &pprda) = 0 ;
	virtual HRESULT __safecall EnumStackFrames(/* out */ _di_IEnumDebugStackFrames &ppedsf) = 0 ;
	virtual HRESULT __safecall GetDescription(/* out */ System::WideString &pbstrDescription, /* out */ System::WideString &pbstrState) = 0 ;
	virtual HRESULT __safecall SetNextStatement(const _di_IDebugStackFrame pStackFrame, const _di_IDebugCodeContext pCodeContext) = 0 ;
	virtual HRESULT __safecall GetState(/* out */ unsigned &pState) = 0 ;
	virtual HRESULT __safecall Suspend(/* out */ unsigned &pdwCount) = 0 ;
	virtual HRESULT __safecall Resume(/* out */ unsigned &pdwCount) = 0 ;
	virtual HRESULT __safecall GetSuspendCount(/* out */ unsigned &pdwCount) = 0 ;
};

__interface  INTERFACE_UUID("{51973C38-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugApplicationThread  : public IRemoteDebugApplicationThread 
{
	virtual HRESULT __safecall SynchronousCallIntoThread(const _di_IDebugThreadCall pstcb, unsigned dwParam1, unsigned dwParam2, unsigned dwParam3) = 0 ;
	virtual HRESULT __safecall QueryIsCurrentThread(void) = 0 ;
	virtual HRESULT __safecall QueryIsDebuggerThread(void) = 0 ;
	virtual HRESULT __safecall SetDescription(System::WideChar * pstrDescription) = 0 ;
	virtual HRESULT __safecall SetStateString(System::WideChar * pstrState) = 0 ;
};

__interface  INTERFACE_UUID("{51973C30-CB0C-11D0-B5C9-00A0244A0E7A}") IRemoteDebugApplication  : public System::IInterface 
{
	virtual HRESULT __safecall ResumeFromBreakPoint(const _di_IRemoteDebugApplicationThread prptFocus, Winapi::Activex::TOleEnum bra, Winapi::Activex::TOleEnum era) = 0 ;
	virtual HRESULT __safecall CauseBreak(void) = 0 ;
	virtual HRESULT __safecall ConnectDebugger(const _di_IApplicationDebugger pad) = 0 ;
	virtual HRESULT __safecall DisconnectDebugger(void) = 0 ;
	virtual HRESULT __safecall GetDebugger(/* out */ _di_IApplicationDebugger &pad) = 0 ;
	virtual HRESULT __safecall CreateInstanceAtApplication(__MIDL___MIDL_itf_activdbg_full_0006_0001 &rclsid, const System::_di_IInterface pUnkOuter, unsigned dwClsContext, __MIDL___MIDL_itf_activdbg_full_0006_0001 &riid, /* out */ System::_di_IInterface &ppvObject) = 0 ;
	virtual HRESULT __safecall QueryAlive(void) = 0 ;
	virtual HRESULT __safecall EnumThreads(/* out */ _di_IEnumRemoteDebugApplicationThreads &pperdat) = 0 ;
	virtual HRESULT __safecall GetName(/* out */ System::WideString &pbstrName) = 0 ;
	virtual HRESULT __safecall GetRootNode(/* out */ _di_IDebugApplicationNode &ppdanRoot) = 0 ;
	virtual HRESULT __safecall EnumGlobalExpressionContexts(/* out */ _di_IEnumDebugExpressionContexts &ppedec) = 0 ;
};

__interface  INTERFACE_UUID("{51973C2A-CB0C-11D0-B5C9-00A0244A0E7A}") IApplicationDebugger  : public System::IInterface 
{
	virtual HRESULT __safecall QueryAlive(void) = 0 ;
	virtual HRESULT __safecall CreateInstanceAtDebugger(GUID &rclsid, const System::_di_IInterface pUnkOuter, unsigned dwClsContext, GUID &riid, /* out */ System::_di_IInterface &ppvObject) = 0 ;
	virtual HRESULT __safecall onDebugOutput(System::WideChar * pstr) = 0 ;
	virtual HRESULT __safecall onHandleBreakPoint(const _di_IRemoteDebugApplicationThread prpt, Winapi::Activex::TOleEnum br, const _di_IActiveScriptErrorDebug pError) = 0 ;
	virtual HRESULT __safecall onClose(void) = 0 ;
	virtual HRESULT __safecall onDebuggerEvent(GUID &riid, const System::_di_IInterface punk) = 0 ;
};

__interface  INTERFACE_UUID("{51973C3C-CB0C-11D0-B5C9-00A0244A0E7A}") IEnumRemoteDebugApplicationThreads  : public System::IInterface 
{
	virtual HRESULT __safecall RemoteNext(unsigned celt, /* out */ _di_IRemoteDebugApplicationThread &ppdat, /* out */ unsigned &pceltFetched) = 0 ;
	virtual HRESULT __safecall Skip(unsigned celt) = 0 ;
	virtual HRESULT __safecall Reset(void) = 0 ;
	virtual HRESULT __safecall Clone(/* out */ _di_IEnumRemoteDebugApplicationThreads &pperdat) = 0 ;
};

__interface  INTERFACE_UUID("{51973C20-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugDocumentProvider  : public IDebugDocumentInfo 
{
	virtual HRESULT __safecall GetDocument(/* out */ _di_IDebugDocument &ppssd) = 0 ;
};

__interface  INTERFACE_UUID("{51973C34-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugApplicationNode  : public IDebugDocumentProvider 
{
	virtual HRESULT __safecall EnumChildren(/* out */ _di_IEnumDebugApplicationNodes &pperddp) = 0 ;
	virtual HRESULT __safecall GetParent(/* out */ _di_IDebugApplicationNode &pprddp) = 0 ;
	virtual HRESULT __safecall SetDocumentProvider(const _di_IDebugDocumentProvider pddp) = 0 ;
	virtual HRESULT __safecall Close(void) = 0 ;
	virtual HRESULT __safecall Attach(const _di_IDebugApplicationNode pdanParent) = 0 ;
	virtual HRESULT __safecall Detach(void) = 0 ;
};

__interface  INTERFACE_UUID("{51973C3A-CB0C-11D0-B5C9-00A0244A0E7A}") IEnumDebugApplicationNodes  : public System::IInterface 
{
	virtual HRESULT __safecall RemoteNext(unsigned celt, /* out */ _di_IDebugApplicationNode &pprddp, /* out */ unsigned &pceltFetched) = 0 ;
	virtual HRESULT __safecall Skip(unsigned celt) = 0 ;
	virtual HRESULT __safecall Reset(void) = 0 ;
	virtual HRESULT __safecall Clone(/* out */ _di_IEnumDebugApplicationNodes &pperddp) = 0 ;
};

__interface  INTERFACE_UUID("{51973C40-CB0C-11D0-B5C9-00A0244A0E7A}") IEnumDebugExpressionContexts  : public System::IInterface 
{
	virtual HRESULT __safecall RemoteNext(unsigned celt, /* out */ _di_IDebugExpressionContext &pprgdec, /* out */ unsigned &pceltFetched) = 0 ;
	virtual HRESULT __safecall Skip(unsigned celt) = 0 ;
	virtual HRESULT __safecall Reset(void) = 0 ;
	virtual HRESULT __safecall Clone(/* out */ _di_IEnumDebugExpressionContexts &ppedec) = 0 ;
};

__interface  INTERFACE_UUID("{51973C15-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugExpressionContext  : public System::IInterface 
{
	virtual HRESULT __safecall ParseLanguageText(System::WideChar * pstrCode, unsigned nRadix, System::WideChar * pstrDelimiter, unsigned dwFlags, /* out */ _di_IDebugExpression &ppe) = 0 ;
	virtual HRESULT __safecall GetLanguageInfo(/* out */ System::WideString &pbstrLanguageName, /* out */ __MIDL___MIDL_itf_activdbg_full_0006_0001 &pLanguageID) = 0 ;
};

__interface  INTERFACE_UUID("{51973C14-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugExpression  : public System::IInterface 
{
	virtual HRESULT __safecall Start(const _di_IDebugExpressionCallBack pdecb) = 0 ;
	virtual HRESULT __safecall Abort(void) = 0 ;
	virtual HRESULT __stdcall QueryIsComplete(void) = 0 ;
	virtual HRESULT __safecall GetResultAsString(/* out */ HRESULT &phrResult, /* out */ System::WideString &pbstrResult) = 0 ;
	virtual HRESULT __safecall GetResultAsDebugProperty(/* out */ HRESULT &phrResult, /* out */ _di_IDebugProperty &ppdp) = 0 ;
};

__interface  INTERFACE_UUID("{51973C16-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugExpressionCallBack  : public System::IInterface 
{
	virtual HRESULT __safecall onComplete(void) = 0 ;
};

__interface  INTERFACE_UUID("{51973C50-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugProperty  : public System::IInterface 
{
	virtual HRESULT __safecall GetPropertyInfo(unsigned dwFieldSpec, unsigned nRadix, /* out */ __MIDL___MIDL_itf_activdbg_full_0000_0006 &pPropertyInfo) = 0 ;
	virtual HRESULT __safecall GetExtendedInfo(unsigned cInfos, GUID &rgguidExtendedInfo, /* out */ System::OleVariant &rgvar) = 0 ;
	virtual HRESULT __safecall SetValueAsString(System::WideChar * pszValue, unsigned nRadix) = 0 ;
	virtual HRESULT __safecall EnumMembers(unsigned dwFieldSpec, unsigned nRadix, GUID &refiid, /* out */ _di_IEnumDebugPropertyInfo &ppepi) = 0 ;
	virtual HRESULT __safecall GetParent(/* out */ _di_IDebugProperty &ppDebugProp) = 0 ;
};

__interface  INTERFACE_UUID("{51973C51-CB0C-11D0-B5C9-00A0244A0E7A}") IEnumDebugPropertyInfo  : public System::IInterface 
{
	virtual HRESULT __safecall RemoteNext(unsigned celt, /* out */ __MIDL___MIDL_itf_activdbg_full_0000_0006 &pinfo, /* out */ unsigned &pcEltsfetched) = 0 ;
	virtual HRESULT __safecall Skip(unsigned celt) = 0 ;
	virtual HRESULT __safecall Reset(void) = 0 ;
	virtual HRESULT __safecall Clone(/* out */ _di_IEnumDebugPropertyInfo &ppepi) = 0 ;
	virtual HRESULT __safecall GetCount(/* out */ unsigned &pcelt) = 0 ;
};

__interface  INTERFACE_UUID("{51973C1E-CB0C-11D0-B5C9-00A0244A0E7A}") IEnumDebugStackFrames  : public System::IInterface 
{
	virtual HRESULT __safecall RemoteNext(unsigned celt, /* out */ __MIDL___MIDL_itf_activdbg_full_0000_0007 &prgdsfd, /* out */ unsigned &pceltFetched) = 0 ;
	virtual HRESULT __safecall Skip(unsigned celt) = 0 ;
	virtual HRESULT __safecall Reset(void) = 0 ;
	virtual HRESULT __safecall Clone(/* out */ _di_IEnumDebugStackFrames &ppedsf) = 0 ;
};

__interface  INTERFACE_UUID("{51973C36-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugThreadCall  : public System::IInterface 
{
	virtual HRESULT __safecall ThreadCallHandler(unsigned dwParam1, unsigned dwParam2, unsigned dwParam3) = 0 ;
};

__interface  INTERFACE_UUID("{51973C11-CB0C-11D0-B5C9-00A0244A0E7A}") IActiveScriptSiteDebug  : public System::IInterface 
{
	virtual HRESULT __safecall GetDocumentContextFromPosition(unsigned dwSourceContext, unsigned uCharacterOffset, unsigned uNumChars, /* out */ _di_IDebugDocumentContext &ppsc) = 0 ;
	virtual HRESULT __safecall GetApplication(/* out */ _di_IDebugApplication &ppda) = 0 ;
	virtual HRESULT __safecall GetRootApplicationNode(/* out */ _di_IDebugApplicationNode &ppdanRoot) = 0 ;
	virtual HRESULT __safecall OnScriptErrorDebug(const _di_IActiveScriptErrorDebug pErrorDebug, /* out */ int &pfEnterDebugger, /* out */ int &pfCallOnScriptErrorWhenContinuing) = 0 ;
};

__interface  INTERFACE_UUID("{51973C32-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugApplication  : public IRemoteDebugApplication 
{
	virtual HRESULT __safecall SetName(System::WideChar * pstrName) = 0 ;
	virtual HRESULT __safecall StepOutComplete(void) = 0 ;
	virtual HRESULT __safecall DebugOutput(System::WideChar * pstr) = 0 ;
	virtual HRESULT __safecall StartDebugSession(void) = 0 ;
	virtual HRESULT __safecall HandleBreakPoint(Winapi::Activex::TOleEnum br, /* out */ Winapi::Activex::TOleEnum &pbra) = 0 ;
	virtual HRESULT __safecall Close(void) = 0 ;
	virtual HRESULT __safecall GetBreakFlags(/* out */ unsigned &pabf, /* out */ _di_IRemoteDebugApplicationThread &pprdatSteppingThread) = 0 ;
	virtual HRESULT __safecall GetCurrentThread(/* out */ _di_IDebugApplicationThread &pat) = 0 ;
	virtual HRESULT __safecall CreateAsyncDebugOperation(const _di_IDebugSyncOperation psdo, /* out */ _di_IDebugAsyncOperation &ppado) = 0 ;
	virtual HRESULT __safecall AddStackFrameSniffer(const _di_IDebugStackFrameSniffer pdsfs, /* out */ unsigned &pdwCookie) = 0 ;
	virtual HRESULT __safecall RemoveStackFrameSniffer(unsigned dwCookie) = 0 ;
	virtual HRESULT __safecall QueryCurrentThreadIsDebuggerThread(void) = 0 ;
	virtual HRESULT __safecall SynchronousCallInDebuggerThread(const _di_IDebugThreadCall pptc, unsigned dwParam1, unsigned dwParam2, unsigned dwParam3) = 0 ;
	virtual HRESULT __safecall CreateApplicationNode(/* out */ _di_IDebugApplicationNode &ppdanNew) = 0 ;
	virtual HRESULT __safecall FireDebuggerEvent(__MIDL___MIDL_itf_activdbg_full_0006_0001 &riid, const System::_di_IInterface punk) = 0 ;
	virtual HRESULT __safecall HandleRuntimeError(const _di_IActiveScriptErrorDebug pErrorDebug, const _di_IActiveScriptSite pScriptSite, /* out */ Winapi::Activex::TOleEnum &pbra, /* out */ Winapi::Activex::TOleEnum &perra, /* out */ int &pfCallOnScriptError) = 0 ;
	virtual int __stdcall FCanJitDebug(void) = 0 ;
	virtual int __stdcall FIsAutoJitDebugEnabled(void) = 0 ;
	virtual HRESULT __safecall AddGlobalExpressionContextProvider(const _di_IProvideExpressionContexts pdsfs, /* out */ unsigned &pdwCookie) = 0 ;
	virtual HRESULT __safecall RemoveGlobalExpressionContextProvider(unsigned dwCookie) = 0 ;
};

__interface  INTERFACE_UUID("{51973C1A-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugSyncOperation  : public System::IInterface 
{
	virtual HRESULT __safecall GetTargetThread(/* out */ _di_IDebugApplicationThread &ppatTarget) = 0 ;
	virtual HRESULT __safecall Execute(/* out */ System::_di_IInterface &ppunkResult) = 0 ;
	virtual HRESULT __safecall InProgressAbort(void) = 0 ;
};

__interface  INTERFACE_UUID("{51973C1B-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugAsyncOperation  : public System::IInterface 
{
	virtual HRESULT __safecall GetSyncDebugOperation(/* out */ _di_IDebugSyncOperation &ppsdo) = 0 ;
	virtual HRESULT __safecall Start(const _di_IDebugAsyncOperationCallBack padocb) = 0 ;
	virtual HRESULT __safecall Abort(void) = 0 ;
	virtual HRESULT __safecall QueryIsComplete(void) = 0 ;
	virtual HRESULT __safecall GetResult(/* out */ HRESULT &phrResult, /* out */ System::_di_IInterface &ppunkResult) = 0 ;
};

__interface  INTERFACE_UUID("{51973C1C-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugAsyncOperationCallBack  : public System::IInterface 
{
	virtual HRESULT __safecall onComplete(void) = 0 ;
};

__interface  INTERFACE_UUID("{51973C18-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugStackFrameSniffer  : public System::IInterface 
{
	virtual HRESULT __safecall EnumStackFrames(/* out */ _di_IEnumDebugStackFrames &ppedsf) = 0 ;
};

__interface  INTERFACE_UUID("{DB01A1E3-A42B-11CF-8F20-00805F2CD064}") IActiveScriptSite  : public System::IInterface 
{
	virtual HRESULT __safecall GetLCID(/* out */ unsigned &plcid) = 0 ;
	virtual HRESULT __safecall GetItemInfo(System::WideChar * pstrName, unsigned dwReturnMask, /* out */ System::_di_IInterface &ppiunkItem, /* out */ System::_di_IInterface &ppti) = 0 ;
	virtual HRESULT __safecall GetDocVersionString(/* out */ System::WideString &pbstrVersion) = 0 ;
	virtual HRESULT __safecall OnScriptTerminate(System::OleVariant &pVarResult, tagEXCEPINFO &pexcepinfo) = 0 ;
	virtual HRESULT __safecall OnStateChange(Winapi::Activex::TOleEnum ssScriptState) = 0 ;
	virtual HRESULT __safecall OnScriptError(const _di_IActiveScriptError pscripterror) = 0 ;
	virtual HRESULT __safecall OnEnterScript(void) = 0 ;
	virtual HRESULT __safecall OnLeaveScript(void) = 0 ;
};

__interface  INTERFACE_UUID("{51973C41-CB0C-11D0-B5C9-00A0244A0E7A}") IProvideExpressionContexts  : public System::IInterface 
{
	virtual HRESULT __safecall EnumExpressionContexts(/* out */ _di_IEnumDebugExpressionContexts &ppedec) = 0 ;
};

__interface  INTERFACE_UUID("{51973C2B-CB0C-11D0-B5C9-00A0244A0E7A}") IApplicationDebuggerUI  : public System::IInterface 
{
	virtual HRESULT __safecall BringDocumentToTop(const _di_IDebugDocumentText pddt) = 0 ;
	virtual HRESULT __safecall BringDocumentContextToTop(const _di_IDebugDocumentContext pddc) = 0 ;
};

__interface  INTERFACE_UUID("{51973C22-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugDocumentText  : public IDebugDocument 
{
	virtual HRESULT __safecall GetDocumentAttributes(/* out */ unsigned &ptextdocattr) = 0 ;
	virtual HRESULT __safecall GetSize(/* out */ unsigned &pcNumLines, /* out */ unsigned &pcNumChars) = 0 ;
	virtual HRESULT __safecall GetPositionOfLine(unsigned cLineNumber, /* out */ unsigned &pcCharacterPosition) = 0 ;
	virtual HRESULT __safecall GetLineOfPosition(unsigned cCharacterPosition, /* out */ unsigned &pcLineNumber, /* out */ unsigned &pcCharacterOffsetInLine) = 0 ;
	virtual HRESULT __safecall GetText(unsigned cCharacterPosition, short &pcharText, System::Word &pstaTextAttr, unsigned &pcNumChars, unsigned cMaxChars) = 0 ;
	virtual HRESULT __safecall GetPositionOfContext(const _di_IDebugDocumentContext psc, /* out */ unsigned &pcCharacterPosition, /* out */ unsigned &cNumChars) = 0 ;
	virtual HRESULT __safecall GetContextOfPosition(unsigned cCharacterPosition, unsigned cNumChars, /* out */ _di_IDebugDocumentContext &ppsc) = 0 ;
};

__interface  INTERFACE_UUID("{51973C35-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugApplicationNodeEvents  : public System::IInterface 
{
	virtual HRESULT __safecall onAddChild(const _di_IDebugApplicationNode prddpChild) = 0 ;
	virtual HRESULT __safecall onRemoveChild(const _di_IDebugApplicationNode prddpChild) = 0 ;
	virtual HRESULT __safecall onDetach(void) = 0 ;
	virtual HRESULT __safecall onAttach(const _di_IDebugApplicationNode prddpParent) = 0 ;
};

__interface  INTERFACE_UUID("{51973C39-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugCookie  : public System::IInterface 
{
	virtual HRESULT __safecall SetDebugCookie(unsigned dwDebugAppCookie) = 0 ;
};

__interface  INTERFACE_UUID("{51973C26-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugDocumentHelper  : public System::IInterface 
{
	virtual HRESULT __safecall Init(const _di_IDebugApplication pda, System::WideChar * pszShortName, System::WideChar * pszLongName, unsigned docAttr) = 0 ;
	virtual HRESULT __safecall Attach(const _di_IDebugDocumentHelper pddhParent) = 0 ;
	virtual HRESULT __safecall Detach(void) = 0 ;
	virtual HRESULT __safecall AddUnicodeText(System::WideChar * pszText) = 0 ;
	virtual HRESULT __safecall AddDBCSText(System::WideChar * pszText) = 0 ;
	virtual HRESULT __safecall SetDebugDocumentHost(const _di_IDebugDocumentHost pddh) = 0 ;
	virtual HRESULT __safecall AddDeferredText(unsigned cChars, unsigned dwTextStartCookie) = 0 ;
	virtual HRESULT __safecall DefineScriptBlock(unsigned ulCharOffset, unsigned cChars, const _di_IActiveScript pas, int fScriptlet, /* out */ unsigned &pdwSourceContext) = 0 ;
	virtual HRESULT __safecall SetDefaultTextAttr(System::Word staTextAttr) = 0 ;
	virtual HRESULT __safecall SetTextAttributes(unsigned ulCharOffset, unsigned cChars, System::Word &pstaTextAttr) = 0 ;
	virtual HRESULT __safecall SetLongName(System::WideChar * pszLongName) = 0 ;
	virtual HRESULT __safecall SetShortName(System::WideChar * pszShortName) = 0 ;
	virtual HRESULT __safecall SetDocumentAttr(unsigned pszAttributes) = 0 ;
	virtual HRESULT __safecall GetDebugApplicationNode(/* out */ _di_IDebugApplicationNode &ppdan) = 0 ;
	virtual HRESULT __safecall GetScriptBlockInfo(unsigned dwSourceContext, /* out */ _di_IActiveScript &ppasd, /* out */ unsigned &piCharPos, /* out */ unsigned &pcChars) = 0 ;
	virtual HRESULT __safecall CreateDebugDocumentContext(unsigned iCharPos, unsigned cChars, /* out */ _di_IDebugDocumentContext &ppddc) = 0 ;
	virtual HRESULT __safecall BringDocumentToTop(void) = 0 ;
	virtual HRESULT __safecall BringDocumentContextToTop(const _di_IDebugDocumentContext pddc) = 0 ;
};

__interface  INTERFACE_UUID("{51973C27-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugDocumentHost  : public System::IInterface 
{
	virtual HRESULT __safecall GetDeferredText(unsigned dwTextStartCookie, short &pcharText, System::Word &pstaTextAttr, unsigned &pcNumChars, unsigned cMaxChars) = 0 ;
	virtual HRESULT __safecall GetScriptTextAttributes(System::WideChar * pstrCode, unsigned uNumCodeChars, System::WideChar * pstrDelimiter, unsigned dwFlags, System::Word &pattr) = 0 ;
	virtual HRESULT __safecall OnCreateDocumentContext(/* out */ System::_di_IInterface &ppunkOuter) = 0 ;
	virtual HRESULT __safecall GetPathName(/* out */ System::WideString &pbstrLongName, /* out */ int &pfIsOriginalFile) = 0 ;
	virtual HRESULT __safecall GetFileName(/* out */ System::WideString &pbstrShortName) = 0 ;
	virtual HRESULT __safecall NotifyChanged(void) = 0 ;
};

__interface  INTERFACE_UUID("{BB1A2AE1-A4F9-11CF-8F20-00805F2CD064}") IActiveScript  : public System::IInterface 
{
	virtual HRESULT __safecall SetScriptSite(const _di_IActiveScriptSite pass) = 0 ;
	virtual HRESULT __safecall GetScriptSite(__MIDL___MIDL_itf_activdbg_full_0006_0001 &riid, /* out */ void * &ppvObject) = 0 ;
	virtual HRESULT __safecall SetScriptState(Winapi::Activex::TOleEnum ss) = 0 ;
	virtual HRESULT __safecall GetScriptState(/* out */ Winapi::Activex::TOleEnum &pssState) = 0 ;
	virtual HRESULT __stdcall Close(void) = 0 ;
	virtual HRESULT __safecall AddNamedItem(System::WideChar * pstrName, unsigned dwFlags) = 0 ;
	virtual HRESULT __safecall AddTypeLib(__MIDL___MIDL_itf_activdbg_full_0006_0001 &rguidTypeLib, unsigned dwMajor, unsigned dwMinor, unsigned dwFlags) = 0 ;
	virtual HRESULT __safecall GetScriptDispatch(System::WideChar * pstrItemName, /* out */ _di_IDispatch &ppdisp) = 0 ;
	virtual HRESULT __safecall GetCurrentScriptThreadID(/* out */ unsigned &pstidThread) = 0 ;
	virtual HRESULT __safecall GetScriptThreadID(unsigned dwWin32ThreadId, /* out */ unsigned &pstidThread) = 0 ;
	virtual HRESULT __safecall GetScriptThreadState(unsigned stidThread, /* out */ Winapi::Activex::TOleEnum &pstsState) = 0 ;
	virtual HRESULT __safecall InterruptScriptThread(unsigned stidThread, tagEXCEPINFO &pexcepinfo, unsigned dwFlags) = 0 ;
	virtual HRESULT __safecall Clone(/* out */ _di_IActiveScript &ppscript) = 0 ;
};

__interface  INTERFACE_UUID("{51973C24-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugDocumentTextAuthor  : public IDebugDocumentText 
{
	virtual HRESULT __safecall InsertText(unsigned cCharacterPosition, unsigned cNumToInsert, short &pcharText) = 0 ;
	virtual HRESULT __safecall RemoveText(unsigned cCharacterPosition, unsigned cNumToRemove) = 0 ;
	virtual HRESULT __safecall ReplaceText(unsigned cCharacterPosition, unsigned cNumToReplace, short &pcharText) = 0 ;
};

__interface  INTERFACE_UUID("{51973C23-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugDocumentTextEvents  : public System::IInterface 
{
	virtual HRESULT __safecall onDestroy(void) = 0 ;
	virtual HRESULT __safecall onInsertText(unsigned cCharacterPosition, unsigned cNumToInsert) = 0 ;
	virtual HRESULT __safecall onRemoveText(unsigned cCharacterPosition, unsigned cNumToRemove) = 0 ;
	virtual HRESULT __safecall onReplaceText(unsigned cCharacterPosition, unsigned cNumToReplace) = 0 ;
	virtual HRESULT __safecall onUpdateTextAttributes(unsigned cCharacterPosition, unsigned cNumToUpdate) = 0 ;
	virtual HRESULT __safecall onUpdateDocumentAttributes(unsigned textdocattr) = 0 ;
};

__interface  INTERFACE_UUID("{51973C25-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugDocumentTextExternalAuthor  : public System::IInterface 
{
	virtual HRESULT __safecall GetPathName(/* out */ System::WideString &pbstrLongName, /* out */ int &pfIsOriginalFile) = 0 ;
	virtual HRESULT __safecall GetFileName(/* out */ System::WideString &pbstrShortName) = 0 ;
	virtual HRESULT __safecall NotifyChanged(void) = 0 ;
};

__interface  INTERFACE_UUID("{51973C3D-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugFormatter  : public System::IInterface 
{
	virtual HRESULT __safecall GetStringForVariant(System::OleVariant &pvar, /* out */ System::WideString &pbstrValue) = 0 ;
	virtual HRESULT __safecall GetVariantForString(System::WideChar * pwstrValue, /* out */ System::OleVariant &pvar) = 0 ;
	virtual HRESULT __safecall GetStringForVarType(System::Word vt, __MIDL___MIDL_itf_activdbg_full_0000_0010 &ptdescArrayType, /* out */ System::WideString &pbstr) = 0 ;
};

__interface  INTERFACE_UUID("{51973C3F-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugHelper  : public System::IInterface 
{
	virtual HRESULT __safecall CreatePropertyBrowser(System::OleVariant &pvar, System::WideChar * bstrName, const _di_IDebugApplicationThread pdat, /* out */ _di_IDebugProperty &ppdob) = 0 ;
	virtual HRESULT __safecall CreatePropertyBrowserEx(System::OleVariant &pvar, System::WideChar * bstrName, const _di_IDebugApplicationThread pdat, const _di_IDebugFormatter pdf, /* out */ _di_IDebugProperty &ppdob) = 0 ;
	virtual HRESULT __safecall CreateSimpleConnectionPoint(const _di_IDispatch pdisp, /* out */ _di_ISimpleConnectionPoint &ppscp) = 0 ;
};

__interface  INTERFACE_UUID("{51973C3E-CB0C-11D0-B5C9-00A0244A0E7A}") ISimpleConnectionPoint  : public System::IInterface 
{
	virtual HRESULT __safecall GetEventCount(/* out */ unsigned &pulCount) = 0 ;
	virtual HRESULT __safecall DescribeEvents(unsigned iEvent, unsigned cEvents, /* out */ int &prgid, /* out */ System::WideString &prgbstr, /* out */ unsigned &pcEventsFetched) = 0 ;
	virtual HRESULT __safecall Advise(const _di_IDispatch pdisp, /* out */ unsigned &pdwCookie) = 0 ;
	virtual HRESULT __safecall Unadvise(unsigned dwCookie) = 0 ;
};

__interface  INTERFACE_UUID("{51973C29-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugSessionProvider  : public System::IInterface 
{
	virtual HRESULT __safecall StartDebugSession(const _di_IRemoteDebugApplication pda) = 0 ;
};

__interface  INTERFACE_UUID("{51973C19-CB0C-11D0-B5C9-00A0244A0E7A}") IDebugStackFrameSnifferEx  : public IDebugStackFrameSniffer 
{
	virtual HRESULT __safecall EnumStackFramesEx(unsigned dwSpMin, /* out */ _di_IEnumDebugStackFrames &ppedsf) = 0 ;
};

__interface  INTERFACE_UUID("{51973C3B-CB0C-11D0-B5C9-00A0244A0E7A}") IEnumRemoteDebugApplications  : public System::IInterface 
{
	virtual HRESULT __safecall RemoteNext(unsigned celt, /* out */ _di_IRemoteDebugApplication &ppda, /* out */ unsigned &pceltFetched) = 0 ;
	virtual HRESULT __safecall Skip(unsigned celt) = 0 ;
	virtual HRESULT __safecall Reset(void) = 0 ;
	virtual HRESULT __safecall Clone(/* out */ _di_IEnumRemoteDebugApplications &ppessd) = 0 ;
};

__interface  INTERFACE_UUID("{51973C2F-CB0C-11D0-B5C9-00A0244A0E7A}") IProcessDebugManager  : public System::IInterface 
{
	virtual HRESULT __safecall CreateApplication(/* out */ _di_IDebugApplication &ppda) = 0 ;
	virtual HRESULT __safecall GetDefaultApplication(/* out */ _di_IDebugApplication &ppda) = 0 ;
	virtual HRESULT __safecall AddApplication(const _di_IDebugApplication pda, /* out */ unsigned &pdwAppCookie) = 0 ;
	virtual HRESULT __safecall RemoveApplication(unsigned dwAppCookie) = 0 ;
	virtual HRESULT __safecall CreateDebugDocumentHelper(const System::_di_IInterface pUnkOuter, /* out */ _di_IDebugDocumentHelper &pddh) = 0 ;
};

__interface  INTERFACE_UUID("{51973C2C-CB0C-11D0-B5C9-00A0244A0E7A}") IMachineDebugManager  : public System::IInterface 
{
	virtual HRESULT __safecall AddApplication(const _di_IRemoteDebugApplication pda, /* out */ unsigned &pdwAppCookie) = 0 ;
	virtual HRESULT __safecall RemoveApplication(unsigned dwAppCookie) = 0 ;
	virtual HRESULT __safecall EnumApplications(/* out */ _di_IEnumRemoteDebugApplications &ppeda) = 0 ;
};

__interface  INTERFACE_UUID("{51973C2D-CB0C-11D0-B5C9-00A0244A0E7A}") IMachineDebugManagerCookie  : public System::IInterface 
{
	virtual HRESULT __safecall AddApplication(const _di_IRemoteDebugApplication pda, unsigned dwDebugAppCookie, /* out */ unsigned &pdwAppCookie) = 0 ;
	virtual HRESULT __safecall RemoveApplication(unsigned dwDebugAppCookie, unsigned dwAppCookie) = 0 ;
	virtual HRESULT __safecall EnumApplications(/* out */ _di_IEnumRemoteDebugApplications &ppeda) = 0 ;
};

__interface  INTERFACE_UUID("{51973C2E-CB0C-11D0-B5C9-00A0244A0E7A}") IMachineDebugManagerEvents  : public System::IInterface 
{
	virtual HRESULT __safecall onAddApplication(const _di_IRemoteDebugApplication pda, unsigned dwAppCookie) = 0 ;
	virtual HRESULT __safecall onRemoveApplication(const _di_IRemoteDebugApplication pda, unsigned dwAppCookie) = 0 ;
};

__interface  INTERFACE_UUID("{51973C33-CB0C-11D0-B5C9-00A0244A0E7A}") IRemoteDebugApplicationEvents  : public System::IInterface 
{
	virtual HRESULT __safecall OnConnectDebugger(const _di_IApplicationDebugger pad) = 0 ;
	virtual HRESULT __safecall OnDisconnectDebugger(void) = 0 ;
	virtual HRESULT __safecall OnSetName(System::WideChar * pstrName) = 0 ;
	virtual HRESULT __safecall onDebugOutput(System::WideChar * pstr) = 0 ;
	virtual HRESULT __safecall onClose(void) = 0 ;
	virtual HRESULT __safecall OnEnterBreakPoint(const _di_IRemoteDebugApplicationThread prdat) = 0 ;
	virtual HRESULT __safecall OnLeaveBreakPoint(const _di_IRemoteDebugApplicationThread prdat) = 0 ;
	virtual HRESULT __safecall OnCreateThread(const _di_IRemoteDebugApplicationThread prdat) = 0 ;
	virtual HRESULT __safecall OnDestroyThread(const _di_IRemoteDebugApplicationThread prdat) = 0 ;
	virtual HRESULT __safecall OnBreakFlagChange(unsigned abf, const _di_IRemoteDebugApplicationThread prdatSteppingThread) = 0 ;
};

__interface  INTERFACE_UUID("{B196B284-BAB4-101A-B69C-00AA00341D07}") IConnectionPointContainer  : public System::IInterface 
{
	virtual HRESULT __safecall EnumConnectionPoints(/* out */ _di_IEnumConnectionPoints &ppEnum) = 0 ;
	virtual HRESULT __safecall FindConnectionPoint(__MIDL___MIDL_itf_activdbg_full_0006_0001 &riid, /* out */ _di_IConnectionPoint &ppCP) = 0 ;
};

__interface  INTERFACE_UUID("{B196B285-BAB4-101A-B69C-00AA00341D07}") IEnumConnectionPoints  : public System::IInterface 
{
	virtual HRESULT __safecall RemoteNext(unsigned cConnections, /* out */ _di_IConnectionPoint &ppCP, /* out */ unsigned &pcFetched) = 0 ;
	virtual HRESULT __safecall Skip(unsigned cConnections) = 0 ;
	virtual HRESULT __safecall Reset(void) = 0 ;
	virtual HRESULT __safecall Clone(/* out */ _di_IEnumConnectionPoints &ppEnum) = 0 ;
};

__interface  INTERFACE_UUID("{B196B286-BAB4-101A-B69C-00AA00341D07}") IConnectionPoint  : public System::IInterface 
{
	virtual HRESULT __safecall GetConnectionInterface(/* out */ __MIDL___MIDL_itf_activdbg_full_0006_0001 &pIID) = 0 ;
	virtual HRESULT __safecall GetConnectionPointContainer(/* out */ _di_IConnectionPointContainer &ppCPC) = 0 ;
	virtual HRESULT __safecall Advise(const System::_di_IInterface pUnkSink, /* out */ unsigned &pdwCookie) = 0 ;
	virtual HRESULT __safecall Unadvise(unsigned dwCookie) = 0 ;
	virtual HRESULT __safecall EnumConnections(/* out */ _di_IEnumConnections &ppEnum) = 0 ;
};

__interface  INTERFACE_UUID("{B196B287-BAB4-101A-B69C-00AA00341D07}") IEnumConnections  : public System::IInterface 
{
	virtual HRESULT __safecall RemoteNext(unsigned cConnections, /* out */ __MIDL___MIDL_itf_activdbg_full_0000_0014 &rgcd, /* out */ unsigned &pcFetched) = 0 ;
	virtual HRESULT __safecall Skip(unsigned cConnections) = 0 ;
	virtual HRESULT __safecall Reset(void) = 0 ;
	virtual HRESULT __safecall Clone(/* out */ _di_IEnumConnections &ppEnum) = 0 ;
};

__interface  INTERFACE_UUID("{AA5B6A80-B834-11D0-932F-00A0C90DCAA9}") IActiveScriptParseProcedure  : public System::IInterface 
{
	virtual HRESULT __safecall ParseProcedureText(System::WideChar * pstrCode, System::WideChar * pstrFormalParams, System::WideChar * pstrProcedureName, System::WideChar * pstrItemName, const System::_di_IInterface punkContext, System::WideChar * pstrDelimiter, unsigned dwSourceContextCookie, unsigned ulStartingLineNumber, unsigned dwFlags, /* out */ _di_IDispatch &ppdisp) = 0 ;
};

__interface  INTERFACE_UUID("{B8DA6310-E19B-11D0-933C-00A0C90DCAA9}") IActiveScriptStats  : public System::IInterface 
{
	virtual HRESULT __safecall GetStat(unsigned stid, /* out */ unsigned &pluHi, /* out */ unsigned &pluLo) = 0 ;
	virtual HRESULT __safecall GetStatEx(__MIDL___MIDL_itf_activdbg_full_0006_0001 &GUID, /* out */ unsigned &pluHi, /* out */ unsigned &pluLo) = 0 ;
	virtual HRESULT __safecall ResetStats(void) = 0 ;
};

__interface  INTERFACE_UUID("{1CFF0050-6FDD-11D0-9328-00A0C90DCAA9}") IActiveScriptParseProcedureOld  : public System::IInterface 
{
	virtual HRESULT __safecall ParseProcedureText(System::WideChar * pstrCode, System::WideChar * pstrFormalParams, System::WideChar * pstrItemName, const System::_di_IInterface punkContext, System::WideChar * pstrDelimiter, unsigned dwSourceContextCookie, unsigned ulStartingLineNumber, unsigned dwFlags, /* out */ _di_IDispatch &ppdisp) = 0 ;
};

__interface  INTERFACE_UUID("{BB1A2AE2-A4F9-11CF-8F20-00805F2CD064}") IActiveScriptParse  : public System::IInterface 
{
	virtual HRESULT __safecall InitNew(void) = 0 ;
	virtual HRESULT __safecall AddScriptlet(System::WideChar * pstrDefaultName, System::WideChar * pstrCode, System::WideChar * pstrItemName, System::WideChar * pstrSubItemName, System::WideChar * pstrEventName, System::WideChar * pstrDelimiter, unsigned dwSourceContextCookie, unsigned ulStartingLineNumber, unsigned dwFlags, /* out */ System::WideString &pbstrName, /* out */ tagEXCEPINFO &pexcepinfo) = 0 ;
	virtual HRESULT __safecall ParseScriptText(System::WideChar * pstrCode, System::WideChar * pstrItemName, const System::_di_IInterface punkContext, System::WideChar * pstrDelimiter, unsigned dwSourceContextCookie, unsigned ulStartingLineNumber, unsigned dwFlags, /* out */ System::OleVariant &pVarResult, /* out */ tagEXCEPINFO &pexcepinfo) = 0 ;
};

__interface  INTERFACE_UUID("{D10F6761-83E9-11CF-8F20-00805F2CD064}") IActiveScriptSiteWindow  : public System::IInterface 
{
	virtual HRESULT __safecall GetWindow(/* out */ wireHWND &phwnd) = 0 ;
	virtual HRESULT __safecall EnableModeless(int fEnable) = 0 ;
};

__interface  INTERFACE_UUID("{539698A0-CDCA-11CF-A5EB-00AA0047A063}") IActiveScriptSiteInterruptPoll  : public System::IInterface 
{
	virtual HRESULT __safecall QueryContinue(void) = 0 ;
};

#pragma pack(push,4)
class PASCALIMPLEMENTATION CoProcessDebugManager : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod _di_IProcessDebugManager __fastcall Create();
	__classmethod _di_IProcessDebugManager __fastcall CreateRemote(const System::UnicodeString MachineName);
public:
	/* TObject.Create */ inline __fastcall CoProcessDebugManager(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~CoProcessDebugManager(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TProcessDebugManager : public Vcl::Oleserver::TOleServer
{
	typedef Vcl::Oleserver::TOleServer inherited;
	
private:
	_di_IProcessDebugManager FIntf;
	_di_IProcessDebugManager __fastcall GetDefaultInterface(void);
	
protected:
	virtual void __fastcall InitServerData(void);
	
public:
	__fastcall virtual TProcessDebugManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TProcessDebugManager(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IProcessDebugManager svrIntf);
	virtual void __fastcall Disconnect(void);
	void __fastcall CreateApplication(/* out */ _di_IDebugApplication &ppda);
	void __fastcall GetDefaultApplication(/* out */ _di_IDebugApplication &ppda);
	void __fastcall AddApplication(const _di_IDebugApplication pda, /* out */ unsigned &pdwAppCookie);
	void __fastcall RemoveApplication(unsigned dwAppCookie);
	void __fastcall CreateDebugDocumentHelper(const System::_di_IInterface pUnkOuter, /* out */ _di_IDebugDocumentHelper &pddh);
	__property _di_IProcessDebugManager DefaultInterface = {read=GetDefaultInterface};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION CoDebugHelper : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod _di_IDebugHelper __fastcall Create();
	__classmethod _di_IDebugHelper __fastcall CreateRemote(const System::UnicodeString MachineName);
public:
	/* TObject.Create */ inline __fastcall CoDebugHelper(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~CoDebugHelper(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TDebugHelper : public Vcl::Oleserver::TOleServer
{
	typedef Vcl::Oleserver::TOleServer inherited;
	
private:
	_di_IDebugHelper FIntf;
	_di_IDebugHelper __fastcall GetDefaultInterface(void);
	
protected:
	virtual void __fastcall InitServerData(void);
	
public:
	__fastcall virtual TDebugHelper(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDebugHelper(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IDebugHelper svrIntf);
	virtual void __fastcall Disconnect(void);
	void __fastcall CreatePropertyBrowser(System::OleVariant &pvar, System::WideChar * bstrName, const _di_IDebugApplicationThread pdat, /* out */ _di_IDebugProperty &ppdob);
	void __fastcall CreatePropertyBrowserEx(System::OleVariant &pvar, System::WideChar * bstrName, const _di_IDebugApplicationThread pdat, const _di_IDebugFormatter pdf, /* out */ _di_IDebugProperty &ppdob);
	void __fastcall CreateSimpleConnectionPoint(const _di_IDispatch pdisp, /* out */ _di_ISimpleConnectionPoint &ppscp);
	__property _di_IDebugHelper DefaultInterface = {read=GetDefaultInterface};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION CoCDebugDocumentHelper : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod _di_IDebugDocumentHelper __fastcall Create();
	__classmethod _di_IDebugDocumentHelper __fastcall CreateRemote(const System::UnicodeString MachineName);
public:
	/* TObject.Create */ inline __fastcall CoCDebugDocumentHelper(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~CoCDebugDocumentHelper(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TCDebugDocumentHelperonInsertText)(System::TObject* ASender, unsigned cCharacterPosition, unsigned cNumToInsert);

typedef void __fastcall (__closure *TCDebugDocumentHelperonRemoveText)(System::TObject* ASender, unsigned cCharacterPosition, unsigned cNumToRemove);

typedef void __fastcall (__closure *TCDebugDocumentHelperonReplaceText)(System::TObject* ASender, unsigned cCharacterPosition, unsigned cNumToReplace);

typedef void __fastcall (__closure *TCDebugDocumentHelperonUpdateTextAttributes)(System::TObject* ASender, unsigned cCharacterPosition, unsigned cNumToUpdate);

typedef void __fastcall (__closure *TCDebugDocumentHelperonUpdateDocumentAttributes)(System::TObject* ASender, unsigned textdocattr);

class PASCALIMPLEMENTATION TCDebugDocumentHelper : public Vcl::Oleserver::TOleServer
{
	typedef Vcl::Oleserver::TOleServer inherited;
	
private:
	System::Classes::TNotifyEvent FOnonDestroy;
	TCDebugDocumentHelperonInsertText FOnonInsertText;
	TCDebugDocumentHelperonRemoveText FOnonRemoveText;
	TCDebugDocumentHelperonReplaceText FOnonReplaceText;
	TCDebugDocumentHelperonUpdateTextAttributes FOnonUpdateTextAttributes;
	TCDebugDocumentHelperonUpdateDocumentAttributes FOnonUpdateDocumentAttributes;
	_di_IDebugDocumentHelper FIntf;
	_di_IDebugDocumentHelper __fastcall GetDefaultInterface(void);
	
protected:
	virtual void __fastcall InitServerData(void);
	virtual void __fastcall InvokeEvent(int DispID, System::Win::Comobj::TOleVariantArray &Params);
	
public:
	__fastcall virtual TCDebugDocumentHelper(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TCDebugDocumentHelper(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IDebugDocumentHelper svrIntf);
	virtual void __fastcall Disconnect(void);
	void __fastcall Init(const _di_IDebugApplication pda, System::WideChar * pszShortName, System::WideChar * pszLongName, unsigned docAttr);
	void __fastcall Attach(const _di_IDebugDocumentHelper pddhParent);
	void __fastcall Detach(void);
	void __fastcall AddUnicodeText(System::WideChar * pszText);
	void __fastcall AddDBCSText(System::WideChar * pszText);
	void __fastcall SetDebugDocumentHost(const _di_IDebugDocumentHost pddh);
	void __fastcall AddDeferredText(unsigned cChars, unsigned dwTextStartCookie);
	void __fastcall DefineScriptBlock(unsigned ulCharOffset, unsigned cChars, const _di_IActiveScript pas, int fScriptlet, /* out */ unsigned &pdwSourceContext);
	void __fastcall SetDefaultTextAttr(System::Word staTextAttr);
	void __fastcall SetTextAttributes(unsigned ulCharOffset, unsigned cChars, System::Word &pstaTextAttr);
	void __fastcall SetLongName(System::WideChar * pszLongName);
	void __fastcall SetShortName(System::WideChar * pszShortName);
	void __fastcall SetDocumentAttr(unsigned pszAttributes);
	void __fastcall GetDebugApplicationNode(/* out */ _di_IDebugApplicationNode &ppdan);
	void __fastcall GetScriptBlockInfo(unsigned dwSourceContext, /* out */ _di_IActiveScript &ppasd, /* out */ unsigned &piCharPos, /* out */ unsigned &pcChars);
	void __fastcall CreateDebugDocumentContext(unsigned iCharPos, unsigned cChars, /* out */ _di_IDebugDocumentContext &ppddc);
	void __fastcall BringDocumentToTop(void);
	void __fastcall BringDocumentContextToTop(const _di_IDebugDocumentContext pddc);
	__property _di_IDebugDocumentHelper DefaultInterface = {read=GetDefaultInterface};
	
__published:
	__property System::Classes::TNotifyEvent OnonDestroy = {read=FOnonDestroy, write=FOnonDestroy};
	__property TCDebugDocumentHelperonInsertText OnonInsertText = {read=FOnonInsertText, write=FOnonInsertText};
	__property TCDebugDocumentHelperonRemoveText OnonRemoveText = {read=FOnonRemoveText, write=FOnonRemoveText};
	__property TCDebugDocumentHelperonReplaceText OnonReplaceText = {read=FOnonReplaceText, write=FOnonReplaceText};
	__property TCDebugDocumentHelperonUpdateTextAttributes OnonUpdateTextAttributes = {read=FOnonUpdateTextAttributes, write=FOnonUpdateTextAttributes};
	__property TCDebugDocumentHelperonUpdateDocumentAttributes OnonUpdateDocumentAttributes = {read=FOnonUpdateDocumentAttributes, write=FOnonUpdateDocumentAttributes};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION CoMachineDebugManager : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod _di_IMachineDebugManager __fastcall Create();
	__classmethod _di_IMachineDebugManager __fastcall CreateRemote(const System::UnicodeString MachineName);
public:
	/* TObject.Create */ inline __fastcall CoMachineDebugManager(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~CoMachineDebugManager(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TMachineDebugManager : public Vcl::Oleserver::TOleServer
{
	typedef Vcl::Oleserver::TOleServer inherited;
	
private:
	_di_IMachineDebugManager FIntf;
	_di_IMachineDebugManager __fastcall GetDefaultInterface(void);
	
protected:
	virtual void __fastcall InitServerData(void);
	
public:
	__fastcall virtual TMachineDebugManager(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TMachineDebugManager(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IMachineDebugManager svrIntf);
	virtual void __fastcall Disconnect(void);
	void __fastcall AddApplication(const _di_IRemoteDebugApplication pda, /* out */ unsigned &pdwAppCookie);
	void __fastcall RemoveApplication(unsigned dwAppCookie);
	void __fastcall EnumApplications(/* out */ _di_IEnumRemoteDebugApplications &ppeda);
	__property _di_IMachineDebugManager DefaultInterface = {read=GetDefaultInterface};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION CoDefaultDebugSessionProvider : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod _di_IDebugSessionProvider __fastcall Create();
	__classmethod _di_IDebugSessionProvider __fastcall CreateRemote(const System::UnicodeString MachineName);
public:
	/* TObject.Create */ inline __fastcall CoDefaultDebugSessionProvider(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~CoDefaultDebugSessionProvider(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TDefaultDebugSessionProvider : public Vcl::Oleserver::TOleServer
{
	typedef Vcl::Oleserver::TOleServer inherited;
	
private:
	_di_IDebugSessionProvider FIntf;
	_di_IDebugSessionProvider __fastcall GetDefaultInterface(void);
	
protected:
	virtual void __fastcall InitServerData(void);
	
public:
	__fastcall virtual TDefaultDebugSessionProvider(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDefaultDebugSessionProvider(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IDebugSessionProvider svrIntf);
	virtual void __fastcall Disconnect(void);
	void __fastcall StartDebugSession(const _di_IRemoteDebugApplication pda);
	__property _di_IDebugSessionProvider DefaultInterface = {read=GetDefaultInterface};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 LMDSctMSScriptTLB_CLRMajorVersion = System::Int8(0x1);
static const System::Int8 LMDSctMSScriptTLB_CLRMinorVersion = System::Int8(0x0);
extern DELPHI_PACKAGE GUID LIBID_LMDSctMSScriptTLB_CLR;
extern DELPHI_PACKAGE GUID IID_IActiveScriptDebug;
extern DELPHI_PACKAGE GUID IID_IEnumDebugCodeContexts;
extern DELPHI_PACKAGE GUID IID_IDebugCodeContext;
extern DELPHI_PACKAGE GUID IID_IDebugDocumentContext;
extern DELPHI_PACKAGE GUID IID_IDebugDocumentInfo;
extern DELPHI_PACKAGE GUID IID_IDebugDocument;
extern DELPHI_PACKAGE GUID IID_IActiveScriptError;
extern DELPHI_PACKAGE GUID IID_IActiveScriptErrorDebug;
extern DELPHI_PACKAGE GUID IID_IDebugStackFrame;
extern DELPHI_PACKAGE GUID IID_IRemoteDebugApplicationThread;
extern DELPHI_PACKAGE GUID IID_IDebugApplicationThread;
extern DELPHI_PACKAGE GUID IID_IRemoteDebugApplication;
extern DELPHI_PACKAGE GUID IID_IApplicationDebugger;
extern DELPHI_PACKAGE GUID IID_IEnumRemoteDebugApplicationThreads;
extern DELPHI_PACKAGE GUID IID_IDebugDocumentProvider;
extern DELPHI_PACKAGE GUID IID_IDebugApplicationNode;
extern DELPHI_PACKAGE GUID IID_IEnumDebugApplicationNodes;
extern DELPHI_PACKAGE GUID IID_IEnumDebugExpressionContexts;
extern DELPHI_PACKAGE GUID IID_IDebugExpressionContext;
extern DELPHI_PACKAGE GUID IID_IDebugExpression;
extern DELPHI_PACKAGE GUID IID_IDebugExpressionCallBack;
extern DELPHI_PACKAGE GUID IID_IDebugProperty;
extern DELPHI_PACKAGE GUID IID_IEnumDebugPropertyInfo;
extern DELPHI_PACKAGE GUID IID_IEnumDebugStackFrames;
extern DELPHI_PACKAGE GUID IID_IDebugThreadCall;
extern DELPHI_PACKAGE GUID IID_IActiveScriptSiteDebug;
extern DELPHI_PACKAGE GUID IID_IDebugApplication;
extern DELPHI_PACKAGE GUID IID_IDebugSyncOperation;
extern DELPHI_PACKAGE GUID IID_IDebugAsyncOperation;
extern DELPHI_PACKAGE GUID IID_IDebugAsyncOperationCallBack;
extern DELPHI_PACKAGE GUID IID_IDebugStackFrameSniffer;
extern DELPHI_PACKAGE GUID IID_IActiveScriptSite;
extern DELPHI_PACKAGE GUID IID_IProvideExpressionContexts;
extern DELPHI_PACKAGE GUID IID_IApplicationDebuggerUI;
extern DELPHI_PACKAGE GUID IID_IDebugDocumentText;
extern DELPHI_PACKAGE GUID IID_IDebugApplicationNodeEvents;
extern DELPHI_PACKAGE GUID IID_IDebugCookie;
extern DELPHI_PACKAGE GUID IID_IDebugDocumentHelper;
extern DELPHI_PACKAGE GUID IID_IDebugDocumentHost;
extern DELPHI_PACKAGE GUID IID_IActiveScript;
extern DELPHI_PACKAGE GUID IID_IDebugDocumentTextAuthor;
extern DELPHI_PACKAGE GUID IID_IDebugDocumentTextEvents;
extern DELPHI_PACKAGE GUID IID_IDebugDocumentTextExternalAuthor;
extern DELPHI_PACKAGE GUID IID_IDebugFormatter;
extern DELPHI_PACKAGE GUID IID_IDebugHelper;
extern DELPHI_PACKAGE GUID IID_ISimpleConnectionPoint;
extern DELPHI_PACKAGE GUID IID_IDebugSessionProvider;
extern DELPHI_PACKAGE GUID IID_IDebugStackFrameSnifferEx;
extern DELPHI_PACKAGE GUID IID_IEnumRemoteDebugApplications;
extern DELPHI_PACKAGE GUID IID_IProcessDebugManager;
extern DELPHI_PACKAGE GUID IID_IMachineDebugManager;
extern DELPHI_PACKAGE GUID IID_IMachineDebugManagerCookie;
extern DELPHI_PACKAGE GUID IID_IMachineDebugManagerEvents;
extern DELPHI_PACKAGE GUID IID_IRemoteDebugApplicationEvents;
extern DELPHI_PACKAGE GUID IID_IConnectionPointContainer;
extern DELPHI_PACKAGE GUID IID_IEnumConnectionPoints;
extern DELPHI_PACKAGE GUID IID_IConnectionPoint;
extern DELPHI_PACKAGE GUID IID_IEnumConnections;
extern DELPHI_PACKAGE GUID IID_IActiveScriptParseProcedure;
extern DELPHI_PACKAGE GUID IID_IActiveScriptStats;
extern DELPHI_PACKAGE GUID IID_IActiveScriptParseProcedureOld;
extern DELPHI_PACKAGE GUID IID_IActiveScriptParse;
extern DELPHI_PACKAGE GUID IID_IActiveScriptSiteWindow;
extern DELPHI_PACKAGE GUID IID_IActiveScriptSiteInterruptPoll;
extern DELPHI_PACKAGE GUID CLASS_ProcessDebugManager;
extern DELPHI_PACKAGE GUID CLASS_DebugHelper;
extern DELPHI_PACKAGE GUID CLASS_CDebugDocumentHelper;
extern DELPHI_PACKAGE GUID CLASS_MachineDebugManager;
extern DELPHI_PACKAGE GUID CLASS_DefaultDebugSessionProvider;
static const System::Int8 DOCUMENTNAMETYPE_APPNODE = System::Int8(0x0);
static const System::Int8 DOCUMENTNAMETYPE_TITLE = System::Int8(0x1);
static const System::Int8 DOCUMENTNAMETYPE_FILE_TAIL = System::Int8(0x2);
static const System::Int8 DOCUMENTNAMETYPE_URL = System::Int8(0x3);
static const System::Int8 BREAKPOINT_DELETED = System::Int8(0x0);
static const System::Int8 BREAKPOINT_DISABLED = System::Int8(0x1);
static const System::Int8 BREAKPOINT_ENABLED = System::Int8(0x2);
static const System::Int8 BREAKRESUMEACTION_ABORT = System::Int8(0x0);
static const System::Int8 BREAKRESUMEACTION_CONTINUE = System::Int8(0x1);
static const System::Int8 BREAKRESUMEACTION_STEP_INTO = System::Int8(0x2);
static const System::Int8 BREAKRESUMEACTION_STEP_OVER = System::Int8(0x3);
static const System::Int8 BREAKRESUMEACTION_STEP_OUT = System::Int8(0x4);
static const System::Int8 BREAKRESUMEACTION_IGNORE = System::Int8(0x5);
static const System::Int8 ERRORRESUMEACTION_ReexecuteErrorStatement = System::Int8(0x0);
static const System::Int8 ERRORRESUMEACTION_AbortCallAndReturnErrorToCaller = System::Int8(0x1);
static const System::Int8 ERRORRESUMEACTION_SkipErrorStatement = System::Int8(0x2);
static const System::Int8 BREAKREASON_STEP = System::Int8(0x0);
static const System::Int8 BREAKREASON_BREAKPOINT = System::Int8(0x1);
static const System::Int8 BREAKREASON_DEBUGGER_BLOCK = System::Int8(0x2);
static const System::Int8 BREAKREASON_HOST_INITIATED = System::Int8(0x3);
static const System::Int8 BREAKREASON_LANGUAGE_INITIATED = System::Int8(0x4);
static const System::Int8 BREAKREASON_DEBUGGER_HALT = System::Int8(0x5);
static const System::Int8 BREAKREASON_ERROR = System::Int8(0x6);
static const System::Int8 SCRIPTSTATE_UNINITIALIZED = System::Int8(0x0);
static const System::Int8 SCRIPTSTATE_INITIALIZED = System::Int8(0x5);
static const System::Int8 SCRIPTSTATE_STARTED = System::Int8(0x1);
static const System::Int8 SCRIPTSTATE_CONNECTED = System::Int8(0x2);
static const System::Int8 SCRIPTSTATE_DISCONNECTED = System::Int8(0x3);
static const System::Int8 SCRIPTSTATE_CLOSED = System::Int8(0x4);
static const System::Int8 SCRIPTTHREADSTATE_NOTINSCRIPT = System::Int8(0x0);
static const System::Int8 SCRIPTTHREADSTATE_RUNNING = System::Int8(0x1);
static const System::Int8 SCRIPTINFO_IUNKNOWN = System::Int8(0x1);
static const System::Int8 SCRIPTINFO_ITYPEINFO = System::Int8(0x2);
static const System::Int8 SCRIPTINFO_ALL_FLAGS = System::Int8(0x3);
static const System::Int8 TEXT_DOC_ATTR_READONLY = System::Int8(0x1);
static const System::Int8 DEBUG_TEXT_ISEXPRESSION = System::Int8(0x1);
static const System::Int8 DEBUG_TEXT_RETURNVALUE = System::Int8(0x2);
static const System::Int8 DEBUG_TEXT_NOSIDEEFFECTS = System::Int8(0x4);
static const System::Int8 DEBUG_TEXT_ALLOWBREAKPOINTS = System::Int8(0x8);
static const System::Int8 DEBUG_TEXT_ALLOWERRORREPORT = System::Int8(0x10);
static const System::Int8 SCRIPTTEXT_DELAYEXECUTION = System::Int8(0x1);
static const System::Int8 SCRIPTTEXT_ISVISIBLE = System::Int8(0x2);
static const System::Int8 SCRIPTTEXT_ISEXPRESSION = System::Int8(0x20);
static const System::Int8 SCRIPTTEXT_ISPERSISTENT = System::Int8(0x40);
static const System::Byte SCRIPTTEXT_HOSTMANAGESSOURCE = System::Byte(0x80);
static const System::Byte SCRIPTTEXT_ALL_FLAGS = System::Byte(0xe3);
static const System::Int8 SCRIPTITEM_ISVISIBLE = System::Int8(0x2);
static const System::Int8 SCRIPTITEM_ISSOURCE = System::Int8(0x4);
static const System::Int8 SCRIPTITEM_GLOBALMEMBERS = System::Int8(0x8);
static const System::Int8 SCRIPTITEM_ISPERSISTENT = System::Int8(0x40);
static const System::Word SCRIPTITEM_CODEONLY = System::Word(0x200);
static const System::Word SCRIPTITEM_NOCODE = System::Word(0x400);
static const System::Word SCRIPTITEM_ALL_FLAGS = System::Word(0x64e);
static const System::Int8 DBGPROP_ATTRIB_NO_ATTRIB = System::Int8(0x0);
static const System::Int8 DBGPROP_ATTRIB_VALUE_IS_INVALID = System::Int8(0x8);
static const System::Int8 DBGPROP_ATTRIB_VALUE_IS_EXPANDABLE = System::Int8(0x10);
static const System::Word DBGPROP_ATTRIB_VALUE_READONLY = System::Word(0x800);
static const System::Word DBGPROP_ATTRIB_ACCESS_PUBLIC = System::Word(0x1000);
static const System::Word DBGPROP_ATTRIB_ACCESS_PRIVATE = System::Word(0x2000);
static const System::Word DBGPROP_ATTRIB_ACCESS_PROTECTED = System::Word(0x4000);
static const System::Word DBGPROP_ATTRIB_ACCESS_FINAL = System::Word(0x8000);
static const int DBGPROP_ATTRIB_STORAGE_GLOBAL = int(0x10000);
static const int DBGPROP_ATTRIB_STORAGE_STATIC = int(0x20000);
static const int DBGPROP_ATTRIB_STORAGE_FIELD = int(0x40000);
static const int DBGPROP_ATTRIB_STORAGE_VIRTUAL = int(0x80000);
static const int DBGPROP_ATTRIB_TYPE_IS_CONSTANT = int(0x100000);
static const int DBGPROP_ATTRIB_TYPE_IS_SYNCHRONIZED = int(0x200000);
static const int DBGPROP_ATTRIB_TYPE_IS_VOLATILE = int(0x400000);
static const int DBGPROP_ATTRIB_HAS_EXTENDED_ATTRIBS = int(0x800000);
static const System::Int8 DBGPROP_INFO_NAME = System::Int8(0x1);
static const System::Int8 DBGPROP_INFO_TYPE = System::Int8(0x2);
static const System::Int8 DBGPROP_INFO_VALUE = System::Int8(0x4);
static const System::Int8 DBGPROP_INFO_FULLNAME = System::Int8(0x20);
static const System::Int8 DBGPROP_INFO_ATTRIBUTES = System::Int8(0x8);
static const System::Int8 DBGPROP_INFO_DEBUGPROP = System::Int8(0x10);
static const int DBGPROP_INFO_AUTOEXPAND = int(0x8000000);
static const System::Int8 DBGPROP_INFO_STANDARD = System::Int8(0xf);
static const System::Int8 DBGPROP_INFO_ALL = System::Int8(0x3f);
extern DELPHI_PACKAGE System::ResourceString _dtlServerPage;
#define Lmdsctmsscripttlb_dtlServerPage System::LoadResourceString(&Lmdsctmsscripttlb::_dtlServerPage)
extern DELPHI_PACKAGE System::ResourceString _dtlOcxPage;
#define Lmdsctmsscripttlb_dtlOcxPage System::LoadResourceString(&Lmdsctmsscripttlb::_dtlOcxPage)
}	/* namespace Lmdsctmsscripttlb */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCTMSSCRIPTTLB)
using namespace Lmdsctmsscripttlb;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsctmsscripttlbHPP
