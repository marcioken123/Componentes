unit LMDSctMSScriptTLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 8291 $
// File generated on 26.07.2008 19:10:25 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Projects\samples\idisp_net\test_activescript\idl\new\LMD.Vcl.LMDSctMSScriptTLB_CLR.tlb (1)
// LIBID: {78A51821-51F4-11D0-8F20-00805F2CD064}
// LCID: 0
// Helpfile: 
// HelpString: LMDSctMSScriptTLB_CLR 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Error creating palette bitmap of (TProcessDebugManager) : Server C:\Program Files\Common Files\Microsoft Shared\VS7Debug\pdm.dll contains no icons
//   Error creating palette bitmap of (TDebugHelper) : Server C:\Program Files\Common Files\Microsoft Shared\VS7Debug\pdm.dll contains no icons
//   Error creating palette bitmap of (TCDebugDocumentHelper) : Server C:\Program Files\Common Files\Microsoft Shared\VS7Debug\pdm.dll contains no icons
//   Error creating palette bitmap of (TMachineDebugManager) : Server C:\Program Files\Common Files\Microsoft Shared\VS7Debug\pdm.dll contains no icons
//   Error creating palette bitmap of (TDefaultDebugSessionProvider) : Server C:\Program Files\Common Files\Microsoft Shared\VS7Debug\pdm.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
interface

{$ifndef CLR}
uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  LMDSctMSScriptTLB_CLRMajorVersion = 1;
  LMDSctMSScriptTLB_CLRMinorVersion = 0;

  LIBID_LMDSctMSScriptTLB_CLR: TGUID = '{78A51821-51F4-11D0-8F20-00805F2CD064}';

  IID_IActiveScriptDebug: TGUID = '{51973C10-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumDebugCodeContexts: TGUID = '{51973C1D-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugCodeContext: TGUID = '{51973C13-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentContext: TGUID = '{51973C28-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentInfo: TGUID = '{51973C1F-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocument: TGUID = '{51973C21-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IActiveScriptError: TGUID = '{EAE1BA61-A4ED-11CF-8F20-00805F2CD064}';
  IID_IActiveScriptErrorDebug: TGUID = '{51973C12-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugStackFrame: TGUID = '{51973C17-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IRemoteDebugApplicationThread: TGUID = '{51973C37-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugApplicationThread: TGUID = '{51973C38-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IRemoteDebugApplication: TGUID = '{51973C30-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IApplicationDebugger: TGUID = '{51973C2A-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumRemoteDebugApplicationThreads: TGUID = '{51973C3C-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentProvider: TGUID = '{51973C20-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugApplicationNode: TGUID = '{51973C34-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumDebugApplicationNodes: TGUID = '{51973C3A-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumDebugExpressionContexts: TGUID = '{51973C40-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugExpressionContext: TGUID = '{51973C15-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugExpression: TGUID = '{51973C14-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugExpressionCallBack: TGUID = '{51973C16-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugProperty: TGUID = '{51973C50-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumDebugPropertyInfo: TGUID = '{51973C51-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumDebugStackFrames: TGUID = '{51973C1E-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugThreadCall: TGUID = '{51973C36-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IActiveScriptSiteDebug: TGUID = '{51973C11-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugApplication: TGUID = '{51973C32-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugSyncOperation: TGUID = '{51973C1A-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugAsyncOperation: TGUID = '{51973C1B-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugAsyncOperationCallBack: TGUID = '{51973C1C-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugStackFrameSniffer: TGUID = '{51973C18-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IActiveScriptSite: TGUID = '{DB01A1E3-A42B-11CF-8F20-00805F2CD064}';
  IID_IProvideExpressionContexts: TGUID = '{51973C41-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IApplicationDebuggerUI: TGUID = '{51973C2B-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentText: TGUID = '{51973C22-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugApplicationNodeEvents: TGUID = '{51973C35-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugCookie: TGUID = '{51973C39-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentHelper: TGUID = '{51973C26-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentHost: TGUID = '{51973C27-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IActiveScript: TGUID = '{BB1A2AE1-A4F9-11CF-8F20-00805F2CD064}';
  IID_IDebugDocumentTextAuthor: TGUID = '{51973C24-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentTextEvents: TGUID = '{51973C23-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentTextExternalAuthor: TGUID = '{51973C25-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugFormatter: TGUID = '{51973C3D-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugHelper: TGUID = '{51973C3F-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_ISimpleConnectionPoint: TGUID = '{51973C3E-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugSessionProvider: TGUID = '{51973C29-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugStackFrameSnifferEx: TGUID = '{51973C19-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumRemoteDebugApplications: TGUID = '{51973C3B-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IProcessDebugManager: TGUID = '{51973C2F-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IMachineDebugManager: TGUID = '{51973C2C-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IMachineDebugManagerCookie: TGUID = '{51973C2D-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IMachineDebugManagerEvents: TGUID = '{51973C2E-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IRemoteDebugApplicationEvents: TGUID = '{51973C33-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IConnectionPointContainer: TGUID = '{B196B284-BAB4-101A-B69C-00AA00341D07}';
  IID_IEnumConnectionPoints: TGUID = '{B196B285-BAB4-101A-B69C-00AA00341D07}';
  IID_IConnectionPoint: TGUID = '{B196B286-BAB4-101A-B69C-00AA00341D07}';
  IID_IEnumConnections: TGUID = '{B196B287-BAB4-101A-B69C-00AA00341D07}';
  IID_IActiveScriptParseProcedure: TGUID = '{AA5B6A80-B834-11D0-932F-00A0C90DCAA9}';
  IID_IActiveScriptStats: TGUID = '{B8DA6310-E19B-11D0-933C-00A0C90DCAA9}';
  IID_IActiveScriptParseProcedureOld: TGUID = '{1CFF0050-6FDD-11D0-9328-00A0C90DCAA9}';
  IID_IActiveScriptParse: TGUID = '{BB1A2AE2-A4F9-11CF-8F20-00805F2CD064}';
  IID_IActiveScriptSiteWindow: TGUID = '{D10F6761-83E9-11CF-8F20-00805F2CD064}';
  IID_IActiveScriptSiteInterruptPoll: TGUID = '{539698A0-CDCA-11CF-A5EB-00AA0047A063}';
  CLASS_ProcessDebugManager: TGUID = '{78A51822-51F4-11D0-8F20-00805F2CD064}';
  CLASS_DebugHelper: TGUID = '{0BFCC060-8C1D-11D0-ACCD-00AA0060275C}';
  CLASS_CDebugDocumentHelper: TGUID = '{83B8BCA6-687C-11D0-A405-00AA0060275C}';
  CLASS_MachineDebugManager: TGUID = '{0C0A3666-30C9-11D0-8F20-00805F2CD064}';
  CLASS_DefaultDebugSessionProvider: TGUID = '{834128A2-51F4-11D0-8F20-00805F2CD064}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum __MIDL___MIDL_itf_activdbg_full_0000_0003
type
  __MIDL___MIDL_itf_activdbg_full_0000_0003 = TOleEnum;
const
  DOCUMENTNAMETYPE_APPNODE = $00000000;
  DOCUMENTNAMETYPE_TITLE = $00000001;
  DOCUMENTNAMETYPE_FILE_TAIL = $00000002;
  DOCUMENTNAMETYPE_URL = $00000003;

// Constants for enum __MIDL___MIDL_itf_activdbg_full_0000_0004
type
  __MIDL___MIDL_itf_activdbg_full_0000_0004 = TOleEnum;
const
  BREAKPOINT_DELETED = $00000000;
  BREAKPOINT_DISABLED = $00000001;
  BREAKPOINT_ENABLED = $00000002;

// Constants for enum __MIDL___MIDL_itf_activdbg_full_0000_0001
type
  __MIDL___MIDL_itf_activdbg_full_0000_0001 = TOleEnum;
//  tagBREAKRESUMEACTION = TOleEnum;
const
  BREAKRESUMEACTION_ABORT = $00000000;
  BREAKRESUMEACTION_CONTINUE = $00000001;
  BREAKRESUMEACTION_STEP_INTO = $00000002;
  BREAKRESUMEACTION_STEP_OVER = $00000003;
  BREAKRESUMEACTION_STEP_OUT = $00000004;
  BREAKRESUMEACTION_IGNORE = $00000005;

// Constants for enum __MIDL___MIDL_itf_activdbg_full_0000_0002
type
  __MIDL___MIDL_itf_activdbg_full_0000_0002 = TOleEnum;
const
  ERRORRESUMEACTION_ReexecuteErrorStatement = $00000000;
  ERRORRESUMEACTION_AbortCallAndReturnErrorToCaller = $00000001;
  ERRORRESUMEACTION_SkipErrorStatement = $00000002;

// Constants for enum __MIDL___MIDL_itf_activdbg_full_0000_0005
type
  __MIDL___MIDL_itf_activdbg_full_0000_0005 = TOleEnum;
const
  BREAKREASON_STEP = $00000000;
  BREAKREASON_BREAKPOINT = $00000001;
  BREAKREASON_DEBUGGER_BLOCK = $00000002;
  BREAKREASON_HOST_INITIATED = $00000003;
  BREAKREASON_LANGUAGE_INITIATED = $00000004;
  BREAKREASON_DEBUGGER_HALT = $00000005;
  BREAKREASON_ERROR = $00000006;

// Constants for enum __MIDL___MIDL_itf_activdbg_full_0000_0012
type
  __MIDL___MIDL_itf_activdbg_full_0000_0012 = TOleEnum;
const
  SCRIPTSTATE_UNINITIALIZED = $00000000;
  SCRIPTSTATE_INITIALIZED = $00000005;
  SCRIPTSTATE_STARTED = $00000001;
  SCRIPTSTATE_CONNECTED = $00000002;
  SCRIPTSTATE_DISCONNECTED = $00000003;
  SCRIPTSTATE_CLOSED = $00000004;

// Constants for enum __MIDL___MIDL_itf_activdbg_full_0000_0013
type
  __MIDL___MIDL_itf_activdbg_full_0000_0013 = TOleEnum;
const
  SCRIPTTHREADSTATE_NOTINSCRIPT = $00000000;
  SCRIPTTHREADSTATE_RUNNING = $00000001;

const
  SCRIPTINFO_IUNKNOWN = 1;
  SCRIPTINFO_ITYPEINFO = 2;
  SCRIPTINFO_ALL_FLAGS = SCRIPTINFO_IUNKNOWN or SCRIPTINFO_ITYPEINFO;

  TEXT_DOC_ATTR_READONLY	= 1;
  DEBUG_TEXT_ISEXPRESSION = 1;
  DEBUG_TEXT_RETURNVALUE	= 2;
  DEBUG_TEXT_NOSIDEEFFECTS	= 4;
  DEBUG_TEXT_ALLOWBREAKPOINTS = $8;
  DEBUG_TEXT_ALLOWERRORREPORT = $10;

  SCRIPTTEXT_DELAYEXECUTION = $1;
  SCRIPTTEXT_ISVISIBLE = $2;
  SCRIPTTEXT_ISEXPRESSION = $20;
  SCRIPTTEXT_ISPERSISTENT = $40;
  SCRIPTTEXT_HOSTMANAGESSOURCE = $80;

  SCRIPTTEXT_ALL_FLAGS = SCRIPTTEXT_DELAYEXECUTION or
                         SCRIPTTEXT_ISVISIBLE or
                         SCRIPTTEXT_ISEXPRESSION or
                         SCRIPTTEXT_ISPERSISTENT or
                         SCRIPTTEXT_HOSTMANAGESSOURCE;

  SCRIPTITEM_ISVISIBLE = $2;
  SCRIPTITEM_ISSOURCE = $4;
  SCRIPTITEM_GLOBALMEMBERS= $8;
  SCRIPTITEM_ISPERSISTENT = $40;
  SCRIPTITEM_CODEONLY = $200;
  SCRIPTITEM_NOCODE = $400;

  SCRIPTITEM_ALL_FLAGS = SCRIPTITEM_ISSOURCE or
                         SCRIPTITEM_ISVISIBLE or
                         SCRIPTITEM_ISPERSISTENT or
                         SCRIPTITEM_GLOBALMEMBERS or
                         SCRIPTITEM_NOCODE or
                         SCRIPTITEM_CODEONLY;


  DBGPROP_ATTRIB_NO_ATTRIB	= $0;
	DBGPROP_ATTRIB_VALUE_IS_INVALID	= $8;
	DBGPROP_ATTRIB_VALUE_IS_EXPANDABLE = $10;
	DBGPROP_ATTRIB_VALUE_READONLY	= $800;
	DBGPROP_ATTRIB_ACCESS_PUBLIC	= $1000;
	DBGPROP_ATTRIB_ACCESS_PRIVATE	= $2000;
	DBGPROP_ATTRIB_ACCESS_PROTECTED	= $4000;
	DBGPROP_ATTRIB_ACCESS_FINAL	= $8000;
	DBGPROP_ATTRIB_STORAGE_GLOBAL	= $10000;
	DBGPROP_ATTRIB_STORAGE_STATIC	= $20000;
	DBGPROP_ATTRIB_STORAGE_FIELD	= $40000;
	DBGPROP_ATTRIB_STORAGE_VIRTUAL	= $80000;
	DBGPROP_ATTRIB_TYPE_IS_CONSTANT	= $100000;
	DBGPROP_ATTRIB_TYPE_IS_SYNCHRONIZED	= $200000;
	DBGPROP_ATTRIB_TYPE_IS_VOLATILE	= $400000;
	DBGPROP_ATTRIB_HAS_EXTENDED_ATTRIBS	= $800000;

  DBGPROP_INFO_NAME	= $1;
	DBGPROP_INFO_TYPE	= $2;
	DBGPROP_INFO_VALUE	= $4;
	DBGPROP_INFO_FULLNAME	= $20;
	DBGPROP_INFO_ATTRIBUTES	= $8;
	DBGPROP_INFO_DEBUGPROP	= $10;
	DBGPROP_INFO_AUTOEXPAND	= $8000000;

  DBGPROP_INFO_STANDARD	= DBGPROP_INFO_NAME or DBGPROP_INFO_TYPE or
                          DBGPROP_INFO_VALUE or DBGPROP_INFO_ATTRIBUTES;

  DBGPROP_INFO_ALL = DBGPROP_INFO_NAME or DBGPROP_INFO_TYPE or
                     DBGPROP_INFO_VALUE or DBGPROP_INFO_FULLNAME or
                     DBGPROP_INFO_ATTRIBUTES or DBGPROP_INFO_DEBUGPROP;

type
  tagBREAKRESUMEACTION = TOleEnum;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IActiveScriptDebug = interface;
  IEnumDebugCodeContexts = interface;
  IDebugCodeContext = interface;
  IDebugDocumentContext = interface;
  IDebugDocumentInfo = interface;
  IDebugDocument = interface;
  IActiveScriptError = interface;
  IActiveScriptErrorDebug = interface;
  IDebugStackFrame = interface;
  IRemoteDebugApplicationThread = interface;
  IDebugApplicationThread = interface;
  IRemoteDebugApplication = interface;
  IApplicationDebugger = interface;
  IEnumRemoteDebugApplicationThreads = interface;
  IDebugDocumentProvider = interface;
  IDebugApplicationNode = interface;
  IEnumDebugApplicationNodes = interface;
  IEnumDebugExpressionContexts = interface;
  IDebugExpressionContext = interface;
  IDebugExpression = interface;
  IDebugExpressionCallBack = interface;
  IDebugProperty = interface;
  IEnumDebugPropertyInfo = interface;
  IEnumDebugStackFrames = interface;
  IDebugThreadCall = interface;
  IActiveScriptSiteDebug = interface;
  IDebugApplication = interface;
  IDebugSyncOperation = interface;
  IDebugAsyncOperation = interface;
  IDebugAsyncOperationCallBack = interface;
  IDebugStackFrameSniffer = interface;
  IActiveScriptSite = interface;
  IProvideExpressionContexts = interface;
  IApplicationDebuggerUI = interface;
  IDebugDocumentText = interface;
  IDebugApplicationNodeEvents = interface;
  IDebugCookie = interface;
  IDebugDocumentHelper = interface;
  IDebugDocumentHost = interface;
  IActiveScript = interface;
  IDebugDocumentTextAuthor = interface;
  IDebugDocumentTextEvents = interface;
  IDebugDocumentTextExternalAuthor = interface;
  IDebugFormatter = interface;
  IDebugHelper = interface;
  ISimpleConnectionPoint = interface;
  IDebugSessionProvider = interface;
  IDebugStackFrameSnifferEx = interface;
  IEnumRemoteDebugApplications = interface;
  IProcessDebugManager = interface;
  IMachineDebugManager = interface;
  IMachineDebugManagerCookie = interface;
  IMachineDebugManagerEvents = interface;
  IRemoteDebugApplicationEvents = interface;
  IConnectionPointContainer = interface;
  IEnumConnectionPoints = interface;
  IConnectionPoint = interface;
  IEnumConnections = interface;
  IActiveScriptParseProcedure = interface;
  IActiveScriptStats = interface;
  IActiveScriptParseProcedureOld = interface;
  IActiveScriptParse = interface;
  IActiveScriptSiteWindow = interface;
  IActiveScriptSiteInterruptPoll = interface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  ProcessDebugManager = IProcessDebugManager;
  DebugHelper = IDebugHelper;
  CDebugDocumentHelper = IDebugDocumentHelper;
  MachineDebugManager = IMachineDebugManager;
  DefaultDebugSessionProvider = IDebugSessionProvider;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  wireHWND = ^_RemotableHandle; 
  PUserType1 = ^GUID; {*}
  POleVariant1 = ^OleVariant; {*}
  PUserType2 = ^tagEXCEPINFO; {*}
  PWord1 = ^Word; {*}
  PSmallint1 = ^Smallint; {*}
  PUserType3 = ^tagTYPEDESC; {*}

  __MIDL___MIDL_itf_activdbg_full_0006_0001 = packed record
    Data1: LongWord;
    Data2: Word;
    Data3: Word;
    Data4: array[0..7] of Byte;
  end;

  GUID = __MIDL___MIDL_itf_activdbg_full_0006_0001; 
  tagDOCUMENTNAMETYPE = __MIDL___MIDL_itf_activdbg_full_0000_0003; 
  tagBREAKPOINT_STATE = __MIDL___MIDL_itf_activdbg_full_0000_0004; 
  ULONG_PTR = LongWord; 

  tagEXCEPINFO = packed record
    wCode: Word;
    wReserved: Word;
    bstrSource: WideString;
    bstrDescription: WideString;
    bstrHelpFile: WideString;
    dwHelpContext: LongWord;
    pvReserved: ULONG_PTR;
    pfnDeferredFillIn: ULONG_PTR;
    scode: SCODE;
  end;

  EXCEPINFO = tagEXCEPINFO;

  tagBREAKRESUME_ACTION = __MIDL___MIDL_itf_activdbg_full_0000_0001; 
  tagERRORRESUMEACTION = __MIDL___MIDL_itf_activdbg_full_0000_0002; 
  tagBREAKREASON = __MIDL___MIDL_itf_activdbg_full_0000_0005; 

  __MIDL___MIDL_itf_activdbg_full_0000_0006 = packed record
    m_dwValidFields: LongWord;
    m_bstrName: WideString;
    m_bstrType: WideString;
    m_bstrValue: WideString;
    m_bstrFullName: WideString;
    m_dwAttrib: LongWord;
    m_pDebugProp: IDebugProperty;
  end;

  tagDebugPropertyInfo = __MIDL___MIDL_itf_activdbg_full_0000_0006; 

  __MIDL___MIDL_itf_activdbg_full_0000_0007 = packed record
    pdsf: IDebugStackFrame;
    dwMin: LongWord;
    dwLim: LongWord;
    fFinal: Integer;
    punkFinal: IUnknown;
  end;

  tagDebugStackFrameDescriptor = __MIDL___MIDL_itf_activdbg_full_0000_0007;
  tagSCRIPTSTATE = __MIDL___MIDL_itf_activdbg_full_0000_0012; 
  tagSCRIPTTHREADSTATE = __MIDL___MIDL_itf_activdbg_full_0000_0013; 

  __MIDL___MIDL_itf_activdbg_full_0000_0009 = record
    case Integer of
      0: (lptdesc: Pointer);
      1: (lpadesc: Pointer);
      2: (hreftype: LongWord);
  end;

  __MIDL_IOleAutomationTypes_0005 = __MIDL___MIDL_itf_activdbg_full_0000_0009; 

  __MIDL___MIDL_itf_activdbg_full_0000_0010 = packed record
    __MIDL_0014: __MIDL_IOleAutomationTypes_0005;
    vt: Word;
  end;

  tagTYPEDESC = __MIDL___MIDL_itf_activdbg_full_0000_0010; 

  __MIDL___MIDL_itf_activdbg_full_0000_0014 = packed record
    punk: IUnknown;
    dwCookie: LongWord;
  end;

  tagCONNECTDATA = __MIDL___MIDL_itf_activdbg_full_0000_0014; 
  DWORD = LongWord; 

  __MIDL___MIDL_itf_activdbg_full_0000_0008 = packed record
    cElements: LongWord;
    lLbound: Integer;
  end;

  tagSAFEARRAYBOUND = __MIDL___MIDL_itf_activdbg_full_0000_0008; 

  __MIDL___MIDL_itf_activdbg_full_0000_0011 = packed record
    tdescElem: tagTYPEDESC;
    cDims: Word;
    rgbounds: ^tagSAFEARRAYBOUND;
  end;

  tagARRAYDESC = __MIDL___MIDL_itf_activdbg_full_0000_0011; 

  __MIDL_IWinTypes_0009 = record
    case Integer of
      0: (hInproc: Integer);
      1: (hRemote: Integer);
  end;

  _RemotableHandle = packed record
    fContext: Integer;
    u: __MIDL_IWinTypes_0009;
  end;


// *********************************************************************//
// Interface: IActiveScriptDebug
// Flags:     (0)
// GUID:      {51973C10-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IActiveScriptDebug = interface(IUnknown)
    ['{51973C10-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetScriptTextAttributes(pstrCode: PWideChar; uNumCodeChars: LongWord; 
                                      pstrDelimiter: PWideChar; dwFlags: LongWord; var pattr: Word); safecall;
    procedure GetScriptletTextAttributes(pstrCode: PWideChar; uNumCodeChars: LongWord; 
                                         pstrDelimiter: PWideChar; dwFlags: LongWord; 
                                         var pattr: Word); safecall;
    procedure EnumCodeContextsOfPosition(dwSourceContext: LongWord; uCharacterOffset: LongWord; 
                                         uNumChars: LongWord; out ppescc: IEnumDebugCodeContexts); safecall;
  end;

// *********************************************************************//
// Interface: IEnumDebugCodeContexts
// Flags:     (0)
// GUID:      {51973C1D-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumDebugCodeContexts = interface(IUnknown)
    ['{51973C1D-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure RemoteNext(celt: LongWord; out pscc: IDebugCodeContext; out pceltFetched: LongWord); safecall;
    procedure Skip(celt: LongWord); safecall;
    procedure Reset; safecall;
    procedure Clone(out ppescc: IEnumDebugCodeContexts); safecall;
  end;

// *********************************************************************//
// Interface: IDebugCodeContext
// Flags:     (0)
// GUID:      {51973C13-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugCodeContext = interface(IUnknown)
    ['{51973C13-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetDocumentContext(out ppsc: IDebugDocumentContext); safecall;
    procedure SetBreakPoint(bps: tagBREAKPOINT_STATE); safecall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentContext
// Flags:     (0)
// GUID:      {51973C28-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentContext = interface(IUnknown)
    ['{51973C28-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetDocument(out ppsd: IDebugDocument); safecall;
    procedure EnumCodeContexts(out ppescc: IEnumDebugCodeContexts); safecall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentInfo
// Flags:     (0)
// GUID:      {51973C1F-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentInfo = interface(IUnknown)
    ['{51973C1F-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetName(dnt: tagDOCUMENTNAMETYPE; out pbstrName: WideString); safecall;
    procedure GetDocumentClassId(out pclsidDocument: GUID); safecall;
  end;

// *********************************************************************//
// Interface: IDebugDocument
// Flags:     (0)
// GUID:      {51973C21-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocument = interface(IDebugDocumentInfo)
    ['{51973C21-CB0C-11D0-B5C9-00A0244A0E7A}']
  end;

// *********************************************************************//
// Interface: IActiveScriptError
// Flags:     (0)
// GUID:      {EAE1BA61-A4ED-11CF-8F20-00805F2CD064}
// *********************************************************************//
  IActiveScriptError = interface(IUnknown)
    ['{EAE1BA61-A4ED-11CF-8F20-00805F2CD064}']
    procedure RemoteGetExceptionInfo(out pexcepinfo: tagEXCEPINFO); safecall;
    procedure GetSourcePosition(out pdwSourceContext: LongWord; out pulLineNumber: LongWord; 
                                out plCharacterPosition: Integer); safecall;
    procedure GetSourceLineText(out pbstrSourceLine: WideString); safecall;
  end;

// *********************************************************************//
// Interface: IActiveScriptErrorDebug
// Flags:     (0)
// GUID:      {51973C12-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IActiveScriptErrorDebug = interface(IActiveScriptError)
    ['{51973C12-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetDocumentContext(out ppssc: IDebugDocumentContext); safecall;
    procedure GetStackFrame(out ppdsf: IDebugStackFrame); safecall;
  end;

// *********************************************************************//
// Interface: IDebugStackFrame
// Flags:     (0)
// GUID:      {51973C17-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugStackFrame = interface(IUnknown)
    ['{51973C17-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetCodeContext(out ppcc: IDebugCodeContext); safecall;
    procedure GetDescriptionString(fLong: Integer; out pbstrDescription: WideString); safecall;
    procedure GetLanguageString(fLong: Integer; out pbstrLanguage: WideString); safecall;
    procedure GetThread(out ppat: IDebugApplicationThread); safecall;
    procedure GetDebugProperty(out ppDebugProp: IDebugProperty); safecall;
  end;

// *********************************************************************//
// Interface: IRemoteDebugApplicationThread
// Flags:     (0)
// GUID:      {51973C37-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IRemoteDebugApplicationThread = interface(IUnknown)
    ['{51973C37-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetSystemThreadId(out dwThreadId: LongWord); safecall;
    procedure GetApplication(out pprda: IRemoteDebugApplication); safecall;
    procedure EnumStackFrames(out ppedsf: IEnumDebugStackFrames); safecall;
    procedure GetDescription(out pbstrDescription: WideString; out pbstrState: WideString); safecall;
    procedure SetNextStatement(const pStackFrame: IDebugStackFrame; 
                               const pCodeContext: IDebugCodeContext); safecall;
    procedure GetState(out pState: LongWord); safecall;
    procedure Suspend(out pdwCount: LongWord); safecall;
    procedure Resume(out pdwCount: LongWord); safecall;
    procedure GetSuspendCount(out pdwCount: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IDebugApplicationThread
// Flags:     (0)
// GUID:      {51973C38-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugApplicationThread = interface(IRemoteDebugApplicationThread)
    ['{51973C38-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure SynchronousCallIntoThread(const pstcb: IDebugThreadCall; dwParam1: LongWord; 
                                        dwParam2: LongWord; dwParam3: LongWord); safecall;
    procedure QueryIsCurrentThread; safecall;
    procedure QueryIsDebuggerThread; safecall;
    procedure SetDescription(pstrDescription: PWideChar); safecall;
    procedure SetStateString(pstrState: PWideChar); safecall;
  end;

// *********************************************************************//
// Interface: IRemoteDebugApplication
// Flags:     (0)
// GUID:      {51973C30-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IRemoteDebugApplication = interface(IUnknown)
    ['{51973C30-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure ResumeFromBreakPoint(const prptFocus: IRemoteDebugApplicationThread;
                                   bra: tagBREAKRESUME_ACTION; era: tagERRORRESUMEACTION); safecall;
    procedure CauseBreak; safecall;
    procedure ConnectDebugger(const pad: IApplicationDebugger); safecall;
    procedure DisconnectDebugger; safecall;
    procedure GetDebugger(out pad: IApplicationDebugger); safecall;
    procedure CreateInstanceAtApplication(var rclsid: GUID; const pUnkOuter: IUnknown; 
                                          dwClsContext: LongWord; var riid: GUID; 
                                          out ppvObject: IUnknown); safecall;
    procedure QueryAlive; safecall;
    procedure EnumThreads(out pperdat: IEnumRemoteDebugApplicationThreads); safecall;
    procedure GetName(out pbstrName: WideString); safecall;
    procedure GetRootNode(out ppdanRoot: IDebugApplicationNode); safecall;
    procedure EnumGlobalExpressionContexts(out ppedec: IEnumDebugExpressionContexts); safecall;
  end;

// *********************************************************************//
// Interface: IApplicationDebugger
// Flags:     (0)
// GUID:      {51973C2A-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IApplicationDebugger = interface(IUnknown)
    ['{51973C2A-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure QueryAlive; safecall;
    procedure CreateInstanceAtDebugger(var rclsid: TGUID; const pUnkOuter: IUnknown;
                                       dwClsContext: LongWord; var riid: TGUID;
                                       out ppvObject: IUnknown); safecall;
    procedure onDebugOutput(pstr: PWideChar); safecall;
    procedure onHandleBreakPoint(const prpt: IRemoteDebugApplicationThread; br: tagBREAKREASON;
                                 const pError: IActiveScriptErrorDebug); safecall;
    procedure onClose; safecall;
    procedure onDebuggerEvent(var riid: TGUID; const punk: IUnknown); safecall;
  end;

// *********************************************************************//
// Interface: IEnumRemoteDebugApplicationThreads
// Flags:     (0)
// GUID:      {51973C3C-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumRemoteDebugApplicationThreads = interface(IUnknown)
    ['{51973C3C-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure RemoteNext(celt: LongWord; out ppdat: IRemoteDebugApplicationThread; 
                         out pceltFetched: LongWord); safecall;
    procedure Skip(celt: LongWord); safecall;
    procedure Reset; safecall;
    procedure Clone(out pperdat: IEnumRemoteDebugApplicationThreads); safecall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentProvider
// Flags:     (0)
// GUID:      {51973C20-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentProvider = interface(IDebugDocumentInfo)
    ['{51973C20-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetDocument(out ppssd: IDebugDocument); safecall;
  end;

// *********************************************************************//
// Interface: IDebugApplicationNode
// Flags:     (0)
// GUID:      {51973C34-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugApplicationNode = interface(IDebugDocumentProvider)
    ['{51973C34-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure EnumChildren(out pperddp: IEnumDebugApplicationNodes); safecall;
    procedure GetParent(out pprddp: IDebugApplicationNode); safecall;
    procedure SetDocumentProvider(const pddp: IDebugDocumentProvider); safecall;
    procedure Close; safecall;
    procedure Attach(const pdanParent: IDebugApplicationNode); safecall;
    procedure Detach; safecall;
  end;

// *********************************************************************//
// Interface: IEnumDebugApplicationNodes
// Flags:     (0)
// GUID:      {51973C3A-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumDebugApplicationNodes = interface(IUnknown)
    ['{51973C3A-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure RemoteNext(celt: LongWord; out pprddp: IDebugApplicationNode;
                         out pceltFetched: LongWord); safecall;
    procedure Skip(celt: LongWord); safecall;
    procedure Reset; safecall;
    procedure Clone(out pperddp: IEnumDebugApplicationNodes); safecall;
  end;

// *********************************************************************//
// Interface: IEnumDebugExpressionContexts
// Flags:     (0)
// GUID:      {51973C40-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumDebugExpressionContexts = interface(IUnknown)
    ['{51973C40-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure RemoteNext(celt: LongWord; out pprgdec: IDebugExpressionContext; 
                         out pceltFetched: LongWord); safecall;
    procedure Skip(celt: LongWord); safecall;
    procedure Reset; safecall;
    procedure Clone(out ppedec: IEnumDebugExpressionContexts); safecall;
  end;

// *********************************************************************//
// Interface: IDebugExpressionContext
// Flags:     (0)
// GUID:      {51973C15-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugExpressionContext = interface(IUnknown)
    ['{51973C15-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure ParseLanguageText(pstrCode: PWideChar; nRadix: SYSUINT; pstrDelimiter: PWideChar; 
                                dwFlags: LongWord; out ppe: IDebugExpression); safecall;
    procedure GetLanguageInfo(out pbstrLanguageName: WideString; out pLanguageID: GUID); safecall;
  end;

// *********************************************************************//
// Interface: IDebugExpression
// Flags:     (0)
// GUID:      {51973C14-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugExpression = interface(IUnknown)
    ['{51973C14-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure Start(const pdecb: IDebugExpressionCallBack); safecall;
    procedure Abort; safecall;
    function  QueryIsComplete: HResult; stdcall;
    procedure GetResultAsString(out phrResult: HResult; out pbstrResult: WideString); safecall;
    procedure GetResultAsDebugProperty(out phrResult: HResult; out ppdp: IDebugProperty); safecall;
  end;

// *********************************************************************//
// Interface: IDebugExpressionCallBack
// Flags:     (0)
// GUID:      {51973C16-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugExpressionCallBack = interface(IUnknown)
    ['{51973C16-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure onComplete; safecall;
  end;

// *********************************************************************//
// Interface: IDebugProperty
// Flags:     (0)
// GUID:      {51973C50-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugProperty = interface(IUnknown)
    ['{51973C50-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetPropertyInfo(dwFieldSpec: LongWord; nRadix: SYSUINT; 
                              out pPropertyInfo: tagDebugPropertyInfo); safecall;
    procedure GetExtendedInfo(cInfos: LongWord; var rgguidExtendedInfo: TGUID; out rgvar: OleVariant); safecall;
    procedure SetValueAsString(pszValue: PWideChar; nRadix: SYSUINT); safecall;
    procedure EnumMembers(dwFieldSpec: LongWord; nRadix: SYSUINT; var refiid: TGUID;
                          out ppepi: IEnumDebugPropertyInfo); safecall;
    procedure GetParent(out ppDebugProp: IDebugProperty); safecall;
  end;

// *********************************************************************//
// Interface: IEnumDebugPropertyInfo
// Flags:     (0)
// GUID:      {51973C51-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumDebugPropertyInfo = interface(IUnknown)
    ['{51973C51-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure RemoteNext(celt: LongWord; out pinfo: tagDebugPropertyInfo;
                         out pcEltsfetched: LongWord); safecall;
    procedure Skip(celt: LongWord); safecall;
    procedure Reset; safecall;
    procedure Clone(out ppepi: IEnumDebugPropertyInfo); safecall;
    procedure GetCount(out pcelt: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IEnumDebugStackFrames
// Flags:     (0)
// GUID:      {51973C1E-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumDebugStackFrames = interface(IUnknown)
    ['{51973C1E-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure RemoteNext(celt: LongWord; out prgdsfd: tagDebugStackFrameDescriptor; 
                         out pceltFetched: LongWord); safecall;
    procedure Skip(celt: LongWord); safecall;
    procedure Reset; safecall;
    procedure Clone(out ppedsf: IEnumDebugStackFrames); safecall;
  end;

// *********************************************************************//
// Interface: IDebugThreadCall
// Flags:     (0)
// GUID:      {51973C36-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugThreadCall = interface(IUnknown)
    ['{51973C36-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure ThreadCallHandler(dwParam1: LongWord; dwParam2: LongWord; dwParam3: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IActiveScriptSiteDebug
// Flags:     (0)
// GUID:      {51973C11-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IActiveScriptSiteDebug = interface(IUnknown)
    ['{51973C11-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetDocumentContextFromPosition(dwSourceContext: LongWord; uCharacterOffset: LongWord; 
                                             uNumChars: LongWord; out ppsc: IDebugDocumentContext); safecall;
    procedure GetApplication(out ppda: IDebugApplication); safecall;
    procedure GetRootApplicationNode(out ppdanRoot: IDebugApplicationNode); safecall;
    procedure OnScriptErrorDebug(const pErrorDebug: IActiveScriptErrorDebug; 
                                 out pfEnterDebugger: Integer; 
                                 out pfCallOnScriptErrorWhenContinuing: Integer); safecall;
  end;

// *********************************************************************//
// Interface: IDebugApplication
// Flags:     (0)
// GUID:      {51973C32-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugApplication = interface(IRemoteDebugApplication)
    ['{51973C32-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure SetName(pstrName: PWideChar); safecall;
    procedure StepOutComplete; safecall;
    procedure DebugOutput(pstr: PWideChar); safecall;
    procedure StartDebugSession; safecall;
    procedure HandleBreakPoint(br: tagBREAKREASON; out pbra: tagBREAKRESUME_ACTION); safecall;
    procedure Close; safecall;
    procedure GetBreakFlags(out pabf: LongWord; 
                            out pprdatSteppingThread: IRemoteDebugApplicationThread); safecall;
    procedure GetCurrentThread(out pat: IDebugApplicationThread); safecall;
    procedure CreateAsyncDebugOperation(const psdo: IDebugSyncOperation; 
                                        out ppado: IDebugAsyncOperation); safecall;
    procedure AddStackFrameSniffer(const pdsfs: IDebugStackFrameSniffer; out pdwCookie: LongWord); safecall;
    procedure RemoveStackFrameSniffer(dwCookie: LongWord); safecall;
    procedure QueryCurrentThreadIsDebuggerThread; safecall;
    procedure SynchronousCallInDebuggerThread(const pptc: IDebugThreadCall; dwParam1: LongWord; 
                                              dwParam2: LongWord; dwParam3: LongWord); safecall;
    procedure CreateApplicationNode(out ppdanNew: IDebugApplicationNode); safecall;
    procedure FireDebuggerEvent(var riid: GUID; const punk: IUnknown); safecall;
    procedure HandleRuntimeError(const pErrorDebug: IActiveScriptErrorDebug; 
                                 const pScriptSite: IActiveScriptSite; 
                                 out pbra: tagBREAKRESUME_ACTION; out perra: tagERRORRESUMEACTION;
                                 out pfCallOnScriptError: Integer); safecall;
    function FCanJitDebug: Integer; stdcall;
    function FIsAutoJitDebugEnabled: Integer; stdcall;
    procedure AddGlobalExpressionContextProvider(const pdsfs: IProvideExpressionContexts; 
                                                 out pdwCookie: LongWord); safecall;
    procedure RemoveGlobalExpressionContextProvider(dwCookie: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IDebugSyncOperation
// Flags:     (0)
// GUID:      {51973C1A-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugSyncOperation = interface(IUnknown)
    ['{51973C1A-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetTargetThread(out ppatTarget: IDebugApplicationThread); safecall;
    procedure Execute(out ppunkResult: IUnknown); safecall;
    procedure InProgressAbort; safecall;
  end;

// *********************************************************************//
// Interface: IDebugAsyncOperation
// Flags:     (0)
// GUID:      {51973C1B-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugAsyncOperation = interface(IUnknown)
    ['{51973C1B-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetSyncDebugOperation(out ppsdo: IDebugSyncOperation); safecall;
    procedure Start(const padocb: IDebugAsyncOperationCallBack); safecall;
    procedure Abort; safecall;
    procedure QueryIsComplete; safecall;
    procedure GetResult(out phrResult: HResult; out ppunkResult: IUnknown); safecall;
  end;

// *********************************************************************//
// Interface: IDebugAsyncOperationCallBack
// Flags:     (0)
// GUID:      {51973C1C-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugAsyncOperationCallBack = interface(IUnknown)
    ['{51973C1C-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure onComplete; safecall;
  end;

// *********************************************************************//
// Interface: IDebugStackFrameSniffer
// Flags:     (0)
// GUID:      {51973C18-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugStackFrameSniffer = interface(IUnknown)
    ['{51973C18-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure EnumStackFrames(out ppedsf: IEnumDebugStackFrames); safecall;
  end;

// *********************************************************************//
// Interface: IActiveScriptSite
// Flags:     (0)
// GUID:      {DB01A1E3-A42B-11CF-8F20-00805F2CD064}
// *********************************************************************//
  IActiveScriptSite = interface(IUnknown)
    ['{DB01A1E3-A42B-11CF-8F20-00805F2CD064}']
    procedure GetLCID(out plcid: LongWord); safecall;
    procedure GetItemInfo(pstrName: PWideChar;
                          dwReturnMask: LongWord;
                          out ppiunkItem: IUnknown; 
                          out ppti: IUnknown); safecall;
    procedure GetDocVersionString(out pbstrVersion: WideString); safecall;
    procedure OnScriptTerminate(var pVarResult: OleVariant; var pexcepinfo: tagEXCEPINFO); safecall;
    procedure OnStateChange(ssScriptState: tagSCRIPTSTATE); safecall;
    procedure OnScriptError(const pscripterror: IActiveScriptError); safecall;
    procedure OnEnterScript; safecall;
    procedure OnLeaveScript; safecall;
  end;

// *********************************************************************//
// Interface: IProvideExpressionContexts
// Flags:     (0)
// GUID:      {51973C41-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IProvideExpressionContexts = interface(IUnknown)
    ['{51973C41-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure EnumExpressionContexts(out ppedec: IEnumDebugExpressionContexts); safecall;
  end;

// *********************************************************************//
// Interface: IApplicationDebuggerUI
// Flags:     (0)
// GUID:      {51973C2B-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IApplicationDebuggerUI = interface(IUnknown)
    ['{51973C2B-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure BringDocumentToTop(const pddt: IDebugDocumentText); safecall;
    procedure BringDocumentContextToTop(const pddc: IDebugDocumentContext); safecall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentText
// Flags:     (0)
// GUID:      {51973C22-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentText = interface(IDebugDocument)
    ['{51973C22-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetDocumentAttributes(out ptextdocattr: LongWord); safecall;
    procedure GetSize(out pcNumLines: LongWord; out pcNumChars: LongWord); safecall;
    procedure GetPositionOfLine(cLineNumber: LongWord; out pcCharacterPosition: LongWord); safecall;
    procedure GetLineOfPosition(cCharacterPosition: LongWord; out pcLineNumber: LongWord; 
                                out pcCharacterOffsetInLine: LongWord); safecall;
    procedure GetText(cCharacterPosition: LongWord; var pcharText: Smallint; 
                      var pstaTextAttr: Word; var pcNumChars: LongWord; cMaxChars: LongWord); safecall;
    procedure GetPositionOfContext(const psc: IDebugDocumentContext; 
                                   out pcCharacterPosition: LongWord; out cNumChars: LongWord); safecall;
    procedure GetContextOfPosition(cCharacterPosition: LongWord; cNumChars: LongWord; 
                                   out ppsc: IDebugDocumentContext); safecall;
  end;

// *********************************************************************//
// Interface: IDebugApplicationNodeEvents
// Flags:     (0)
// GUID:      {51973C35-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugApplicationNodeEvents = interface(IUnknown)
    ['{51973C35-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure onAddChild(const prddpChild: IDebugApplicationNode); safecall;
    procedure onRemoveChild(const prddpChild: IDebugApplicationNode); safecall;
    procedure onDetach; safecall;
    procedure onAttach(const prddpParent: IDebugApplicationNode); safecall;
  end;

// *********************************************************************//
// Interface: IDebugCookie
// Flags:     (0)
// GUID:      {51973C39-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugCookie = interface(IUnknown)
    ['{51973C39-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure SetDebugCookie(dwDebugAppCookie: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentHelper
// Flags:     (0)
// GUID:      {51973C26-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentHelper = interface(IUnknown)
    ['{51973C26-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure Init(const pda: IDebugApplication; pszShortName: PWideChar; pszLongName: PWideChar; 
                   docAttr: LongWord); safecall;
    procedure Attach(const pddhParent: IDebugDocumentHelper); safecall;
    procedure Detach; safecall;
    procedure AddUnicodeText(pszText: PWideChar); safecall;
    procedure AddDBCSText(pszText: PChar); safecall;
    procedure SetDebugDocumentHost(const pddh: IDebugDocumentHost); safecall;
    procedure AddDeferredText(cChars: LongWord; dwTextStartCookie: LongWord); safecall;
    procedure DefineScriptBlock(ulCharOffset: LongWord; cChars: LongWord; const pas: IActiveScript; 
                                fScriptlet: Integer; out pdwSourceContext: LongWord); safecall;
    procedure SetDefaultTextAttr(staTextAttr: Word); safecall;
    procedure SetTextAttributes(ulCharOffset: LongWord; cChars: LongWord; var pstaTextAttr: Word); safecall;
    procedure SetLongName(pszLongName: PWideChar); safecall;
    procedure SetShortName(pszShortName: PWideChar); safecall;
    procedure SetDocumentAttr(pszAttributes: LongWord); safecall;
    procedure GetDebugApplicationNode(out ppdan: IDebugApplicationNode); safecall;
    procedure GetScriptBlockInfo(dwSourceContext: LongWord; out ppasd: IActiveScript; 
                                 out piCharPos: LongWord; out pcChars: LongWord); safecall;
    procedure CreateDebugDocumentContext(iCharPos: LongWord; cChars: LongWord; 
                                         out ppddc: IDebugDocumentContext); safecall;
    procedure BringDocumentToTop; safecall;
    procedure BringDocumentContextToTop(const pddc: IDebugDocumentContext); safecall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentHost
// Flags:     (0)
// GUID:      {51973C27-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentHost = interface(IUnknown)
    ['{51973C27-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetDeferredText(dwTextStartCookie: LongWord; var pcharText: Smallint; 
                              var pstaTextAttr: Word; var pcNumChars: LongWord; cMaxChars: LongWord); safecall;
    procedure GetScriptTextAttributes(pstrCode: PWideChar; uNumCodeChars: LongWord; 
                                      pstrDelimiter: PWideChar; dwFlags: LongWord; var pattr: Word); safecall;
    procedure OnCreateDocumentContext(out ppunkOuter: IUnknown); safecall;
    procedure GetPathName(out pbstrLongName: WideString; out pfIsOriginalFile: Integer); safecall;
    procedure GetFileName(out pbstrShortName: WideString); safecall;
    procedure NotifyChanged; safecall;
  end;

// *********************************************************************//
// Interface: IActiveScript
// Flags:     (0)
// GUID:      {BB1A2AE1-A4F9-11CF-8F20-00805F2CD064}
// *********************************************************************//
  IActiveScript = interface(IUnknown)
    ['{BB1A2AE1-A4F9-11CF-8F20-00805F2CD064}']
    procedure SetScriptSite(const pass: IActiveScriptSite); safecall;
    procedure GetScriptSite(var riid: GUID; out ppvObject: Pointer); safecall;
    procedure SetScriptState(ss: tagSCRIPTSTATE); safecall;
    procedure GetScriptState(out pssState: tagSCRIPTSTATE); safecall;
    function  Close: HRESULT; stdcall;
    procedure AddNamedItem(pstrName: PWideChar; dwFlags: LongWord); safecall;
    procedure AddTypeLib(var rguidTypeLib: GUID; dwMajor: LongWord; dwMinor: LongWord; 
                         dwFlags: LongWord); safecall;
    procedure GetScriptDispatch(pstrItemName: PWideChar; out ppdisp: IDispatch); safecall;
    procedure GetCurrentScriptThreadID(out pstidThread: LongWord); safecall;
    procedure GetScriptThreadID(dwWin32ThreadId: LongWord; out pstidThread: LongWord); safecall;
    procedure GetScriptThreadState(stidThread: LongWord; out pstsState: tagSCRIPTTHREADSTATE); safecall;
    procedure InterruptScriptThread(stidThread: LongWord; var pexcepinfo: tagEXCEPINFO; 
                                    dwFlags: LongWord); safecall;
    procedure Clone(out ppscript: IActiveScript); safecall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentTextAuthor
// Flags:     (0)
// GUID:      {51973C24-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentTextAuthor = interface(IDebugDocumentText)
    ['{51973C24-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure InsertText(cCharacterPosition: LongWord; cNumToInsert: LongWord; 
                         var pcharText: Smallint); safecall;
    procedure RemoveText(cCharacterPosition: LongWord; cNumToRemove: LongWord); safecall;
    procedure ReplaceText(cCharacterPosition: LongWord; cNumToReplace: LongWord; 
                          var pcharText: Smallint); safecall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentTextEvents
// Flags:     (0)
// GUID:      {51973C23-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentTextEvents = interface(IUnknown)
    ['{51973C23-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure onDestroy; safecall;
    procedure onInsertText(cCharacterPosition: LongWord; cNumToInsert: LongWord); safecall;
    procedure onRemoveText(cCharacterPosition: LongWord; cNumToRemove: LongWord); safecall;
    procedure onReplaceText(cCharacterPosition: LongWord; cNumToReplace: LongWord); safecall;
    procedure onUpdateTextAttributes(cCharacterPosition: LongWord; cNumToUpdate: LongWord); safecall;
    procedure onUpdateDocumentAttributes(textdocattr: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentTextExternalAuthor
// Flags:     (0)
// GUID:      {51973C25-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentTextExternalAuthor = interface(IUnknown)
    ['{51973C25-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetPathName(out pbstrLongName: WideString; out pfIsOriginalFile: Integer); safecall;
    procedure GetFileName(out pbstrShortName: WideString); safecall;
    procedure NotifyChanged; safecall;
  end;

// *********************************************************************//
// Interface: IDebugFormatter
// Flags:     (0)
// GUID:      {51973C3D-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugFormatter = interface(IUnknown)
    ['{51973C3D-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetStringForVariant(var pvar: OleVariant; out pbstrValue: WideString); safecall;
    procedure GetVariantForString(pwstrValue: PWideChar; out pvar: OleVariant); safecall;
    procedure GetStringForVarType(vt: Word; var ptdescArrayType: tagTYPEDESC; out pbstr: WideString); safecall;
  end;

// *********************************************************************//
// Interface: IDebugHelper
// Flags:     (0)
// GUID:      {51973C3F-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugHelper = interface(IUnknown)
    ['{51973C3F-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure CreatePropertyBrowser(var pvar: OleVariant; bstrName: PWideChar; 
                                    const pdat: IDebugApplicationThread; out ppdob: IDebugProperty); safecall;
    procedure CreatePropertyBrowserEx(var pvar: OleVariant; bstrName: PWideChar; 
                                      const pdat: IDebugApplicationThread; 
                                      const pdf: IDebugFormatter; out ppdob: IDebugProperty); safecall;
    procedure CreateSimpleConnectionPoint(const pdisp: IDispatch; out ppscp: ISimpleConnectionPoint); safecall;
  end;

// *********************************************************************//
// Interface: ISimpleConnectionPoint
// Flags:     (0)
// GUID:      {51973C3E-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  ISimpleConnectionPoint = interface(IUnknown)
    ['{51973C3E-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure GetEventCount(out pulCount: LongWord); safecall;
    procedure DescribeEvents(iEvent: LongWord; cEvents: LongWord; out prgid: Integer; 
                             out prgbstr: WideString; out pcEventsFetched: LongWord); safecall;
    procedure Advise(const pdisp: IDispatch; out pdwCookie: LongWord); safecall;
    procedure Unadvise(dwCookie: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IDebugSessionProvider
// Flags:     (0)
// GUID:      {51973C29-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugSessionProvider = interface(IUnknown)
    ['{51973C29-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure StartDebugSession(const pda: IRemoteDebugApplication); safecall;
  end;

// *********************************************************************//
// Interface: IDebugStackFrameSnifferEx
// Flags:     (0)
// GUID:      {51973C19-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugStackFrameSnifferEx = interface(IDebugStackFrameSniffer)
    ['{51973C19-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure EnumStackFramesEx(dwSpMin: LongWord; out ppedsf: IEnumDebugStackFrames); safecall;
  end;

// *********************************************************************//
// Interface: IEnumRemoteDebugApplications
// Flags:     (0)
// GUID:      {51973C3B-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumRemoteDebugApplications = interface(IUnknown)
    ['{51973C3B-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure RemoteNext(celt: LongWord; out ppda: IRemoteDebugApplication; 
                         out pceltFetched: LongWord); safecall;
    procedure Skip(celt: LongWord); safecall;
    procedure Reset; safecall;
    procedure Clone(out ppessd: IEnumRemoteDebugApplications); safecall;
  end;

// *********************************************************************//
// Interface: IProcessDebugManager
// Flags:     (0)
// GUID:      {51973C2F-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IProcessDebugManager = interface(IUnknown)
    ['{51973C2F-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure CreateApplication(out ppda: IDebugApplication); safecall;
    procedure GetDefaultApplication(out ppda: IDebugApplication); safecall;
    procedure AddApplication(const pda: IDebugApplication; out pdwAppCookie: LongWord); safecall;
    procedure RemoveApplication(dwAppCookie: LongWord); safecall;
    procedure CreateDebugDocumentHelper(const pUnkOuter: IUnknown; out pddh: IDebugDocumentHelper); safecall;
  end;

// *********************************************************************//
// Interface: IMachineDebugManager
// Flags:     (0)
// GUID:      {51973C2C-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IMachineDebugManager = interface(IUnknown)
    ['{51973C2C-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure AddApplication(const pda: IRemoteDebugApplication; out pdwAppCookie: LongWord); safecall;
    procedure RemoveApplication(dwAppCookie: LongWord); safecall;
    procedure EnumApplications(out ppeda: IEnumRemoteDebugApplications); safecall;
  end;

// *********************************************************************//
// Interface: IMachineDebugManagerCookie
// Flags:     (0)
// GUID:      {51973C2D-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IMachineDebugManagerCookie = interface(IUnknown)
    ['{51973C2D-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure AddApplication(const pda: IRemoteDebugApplication; dwDebugAppCookie: LongWord; 
                             out pdwAppCookie: LongWord); safecall;
    procedure RemoveApplication(dwDebugAppCookie: LongWord; dwAppCookie: LongWord); safecall;
    procedure EnumApplications(out ppeda: IEnumRemoteDebugApplications); safecall;
  end;

// *********************************************************************//
// Interface: IMachineDebugManagerEvents
// Flags:     (0)
// GUID:      {51973C2E-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IMachineDebugManagerEvents = interface(IUnknown)
    ['{51973C2E-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure onAddApplication(const pda: IRemoteDebugApplication; dwAppCookie: LongWord); safecall;
    procedure onRemoveApplication(const pda: IRemoteDebugApplication; dwAppCookie: LongWord); safecall;
  end;

// *********************************************************************//
// Interface: IRemoteDebugApplicationEvents
// Flags:     (0)
// GUID:      {51973C33-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IRemoteDebugApplicationEvents = interface(IUnknown)
    ['{51973C33-CB0C-11D0-B5C9-00A0244A0E7A}']
    procedure OnConnectDebugger(const pad: IApplicationDebugger); safecall;
    procedure OnDisconnectDebugger; safecall;
    procedure OnSetName(pstrName: PWideChar); safecall;
    procedure onDebugOutput(pstr: PWideChar); safecall;
    procedure onClose; safecall;
    procedure OnEnterBreakPoint(const prdat: IRemoteDebugApplicationThread); safecall;
    procedure OnLeaveBreakPoint(const prdat: IRemoteDebugApplicationThread); safecall;
    procedure OnCreateThread(const prdat: IRemoteDebugApplicationThread); safecall;
    procedure OnDestroyThread(const prdat: IRemoteDebugApplicationThread); safecall;
    procedure OnBreakFlagChange(abf: LongWord; 
                                const prdatSteppingThread: IRemoteDebugApplicationThread); safecall;
  end;

// *********************************************************************//
// Interface: IConnectionPointContainer
// Flags:     (0)
// GUID:      {B196B284-BAB4-101A-B69C-00AA00341D07}
// *********************************************************************//
  IConnectionPointContainer = interface(IUnknown)
    ['{B196B284-BAB4-101A-B69C-00AA00341D07}']
    procedure EnumConnectionPoints(out ppEnum: IEnumConnectionPoints); safecall;
    procedure FindConnectionPoint(var riid: GUID; out ppCP: IConnectionPoint); safecall;
  end;

// *********************************************************************//
// Interface: IEnumConnectionPoints
// Flags:     (0)
// GUID:      {B196B285-BAB4-101A-B69C-00AA00341D07}
// *********************************************************************//
  IEnumConnectionPoints = interface(IUnknown)
    ['{B196B285-BAB4-101A-B69C-00AA00341D07}']
    procedure RemoteNext(cConnections: LongWord; out ppCP: IConnectionPoint; out pcFetched: LongWord); safecall;
    procedure Skip(cConnections: LongWord); safecall;
    procedure Reset; safecall;
    procedure Clone(out ppEnum: IEnumConnectionPoints); safecall;
  end;

// *********************************************************************//
// Interface: IConnectionPoint
// Flags:     (0)
// GUID:      {B196B286-BAB4-101A-B69C-00AA00341D07}
// *********************************************************************//
  IConnectionPoint = interface(IUnknown)
    ['{B196B286-BAB4-101A-B69C-00AA00341D07}']
    procedure GetConnectionInterface(out pIID: GUID); safecall;
    procedure GetConnectionPointContainer(out ppCPC: IConnectionPointContainer); safecall;
    procedure Advise(const pUnkSink: IUnknown; out pdwCookie: LongWord); safecall;
    procedure Unadvise(dwCookie: LongWord); safecall;
    procedure EnumConnections(out ppEnum: IEnumConnections); safecall;
  end;

// *********************************************************************//
// Interface: IEnumConnections
// Flags:     (0)
// GUID:      {B196B287-BAB4-101A-B69C-00AA00341D07}
// *********************************************************************//
  IEnumConnections = interface(IUnknown)
    ['{B196B287-BAB4-101A-B69C-00AA00341D07}']
    procedure RemoteNext(cConnections: LongWord; out rgcd: tagCONNECTDATA; out pcFetched: LongWord); safecall;
    procedure Skip(cConnections: LongWord); safecall;
    procedure Reset; safecall;
    procedure Clone(out ppEnum: IEnumConnections); safecall;
  end;

// *********************************************************************//
// Interface: IActiveScriptParseProcedure
// Flags:     (0)
// GUID:      {AA5B6A80-B834-11D0-932F-00A0C90DCAA9}
// *********************************************************************//
  IActiveScriptParseProcedure = interface(IUnknown)
    ['{AA5B6A80-B834-11D0-932F-00A0C90DCAA9}']
    procedure ParseProcedureText(pstrCode: PWideChar; pstrFormalParams: PWideChar; 
                                 pstrProcedureName: PWideChar; pstrItemName: PWideChar; 
                                 const punkContext: IUnknown; pstrDelimiter: PWideChar;
                                 dwSourceContextCookie: DWORD; ulStartingLineNumber: LongWord; 
                                 dwFlags: DWORD; out ppdisp: IDispatch); safecall;
  end;

// *********************************************************************//
// Interface: IActiveScriptStats
// Flags:     (0)
// GUID:      {B8DA6310-E19B-11D0-933C-00A0C90DCAA9}
// *********************************************************************//
  IActiveScriptStats = interface(IUnknown)
    ['{B8DA6310-E19B-11D0-933C-00A0C90DCAA9}']
    procedure GetStat(stid: DWORD; out pluHi: LongWord; out pluLo: LongWord); safecall;
    procedure GetStatEx(var GUID: GUID; out pluHi: LongWord; out pluLo: LongWord); safecall;
    procedure ResetStats; safecall;
  end;

// *********************************************************************//
// Interface: IActiveScriptParseProcedureOld
// Flags:     (0)
// GUID:      {1CFF0050-6FDD-11D0-9328-00A0C90DCAA9}
// *********************************************************************//
  IActiveScriptParseProcedureOld = interface(IUnknown)
    ['{1CFF0050-6FDD-11D0-9328-00A0C90DCAA9}']
    procedure ParseProcedureText(pstrCode: PWideChar; pstrFormalParams: PWideChar; 
                                 pstrItemName: PWideChar; const punkContext: IUnknown; 
                                 pstrDelimiter: PWideChar; dwSourceContextCookie: DWORD; 
                                 ulStartingLineNumber: LongWord; dwFlags: DWORD; 
                                 out ppdisp: IDispatch); safecall;
  end;

// *********************************************************************//
// Interface: IActiveScriptParse
// Flags:     (0)
// GUID:      {BB1A2AE2-A4F9-11CF-8F20-00805F2CD064}
// *********************************************************************//
  IActiveScriptParse = interface(IUnknown)
    ['{BB1A2AE2-A4F9-11CF-8F20-00805F2CD064}']
    procedure InitNew; safecall;
    procedure AddScriptlet(pstrDefaultName: PWideChar; pstrCode: PWideChar; 
                           pstrItemName: PWideChar; pstrSubItemName: PWideChar; 
                           pstrEventName: PWideChar; pstrDelimiter: PWideChar; 
                           dwSourceContextCookie: DWORD; ulStartingLineNumber: LongWord; 
                           dwFlags: DWORD; out pbstrName: WideString; out pexcepinfo: tagEXCEPINFO); safecall;
    procedure ParseScriptText(pstrCode: PWideChar; pstrItemName: PWideChar; 
                              const punkContext: IUnknown; pstrDelimiter: PWideChar; 
                              dwSourceContextCookie: DWORD; ulStartingLineNumber: LongWord; 
                              dwFlags: DWORD; out pVarResult: OleVariant; 
                              out pexcepinfo: tagEXCEPINFO); safecall;
  end;

// *********************************************************************//
// Interface: IActiveScriptSiteWindow
// Flags:     (0)
// GUID:      {D10F6761-83E9-11CF-8F20-00805F2CD064}
// *********************************************************************//
  IActiveScriptSiteWindow = interface(IUnknown)
    ['{D10F6761-83E9-11CF-8F20-00805F2CD064}']
    procedure GetWindow(out phwnd: wireHWND); safecall;
    procedure EnableModeless(fEnable: Integer); safecall;
  end;

// *********************************************************************//
// Interface: IActiveScriptSiteInterruptPoll
// Flags:     (0)
// GUID:      {539698A0-CDCA-11CF-A5EB-00AA0047A063}
// *********************************************************************//
  IActiveScriptSiteInterruptPoll = interface(IUnknown)
    ['{539698A0-CDCA-11CF-A5EB-00AA0047A063}']
    procedure QueryContinue; safecall;
  end;

// *********************************************************************//
// The Class CoProcessDebugManager provides a Create and CreateRemote method to          
// create instances of the default interface IProcessDebugManager exposed by              
// the CoClass ProcessDebugManager. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoProcessDebugManager = class
    class function Create: IProcessDebugManager;
    class function CreateRemote(const MachineName: string): IProcessDebugManager;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TProcessDebugManager
// Help String      : ProcessDebugManager Class
// Default Interface: IProcessDebugManager
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TProcessDebugManagerProperties= class;
{$ENDIF}
  TProcessDebugManager = class(TOleServer)
  private
    FIntf: IProcessDebugManager;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TProcessDebugManagerProperties;
    function GetServerProperties: TProcessDebugManagerProperties;
{$ENDIF}
    function GetDefaultInterface: IProcessDebugManager;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IProcessDebugManager);
    procedure Disconnect; override;
    procedure CreateApplication(out ppda: IDebugApplication);
    procedure GetDefaultApplication(out ppda: IDebugApplication);
    procedure AddApplication(const pda: IDebugApplication; out pdwAppCookie: LongWord);
    procedure RemoveApplication(dwAppCookie: LongWord);
    procedure CreateDebugDocumentHelper(const pUnkOuter: IUnknown; out pddh: IDebugDocumentHelper);
    property DefaultInterface: IProcessDebugManager read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TProcessDebugManagerProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TProcessDebugManager
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TProcessDebugManagerProperties = class(TPersistent)
  private
    FServer:    TProcessDebugManager;
    function    GetDefaultInterface: IProcessDebugManager;
    constructor Create(AServer: TProcessDebugManager);
  protected
  public
    property DefaultInterface: IProcessDebugManager read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDebugHelper provides a Create and CreateRemote method to          
// create instances of the default interface IDebugHelper exposed by              
// the CoClass DebugHelper. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDebugHelper = class
    class function Create: IDebugHelper;
    class function CreateRemote(const MachineName: string): IDebugHelper;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDebugHelper
// Help String      : DebugHelper Class
// Default Interface: IDebugHelper
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDebugHelperProperties= class;
{$ENDIF}
  TDebugHelper = class(TOleServer)
  private
    FIntf: IDebugHelper;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TDebugHelperProperties;
    function GetServerProperties: TDebugHelperProperties;
{$ENDIF}
    function GetDefaultInterface: IDebugHelper;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDebugHelper);
    procedure Disconnect; override;
    procedure CreatePropertyBrowser(var pvar: OleVariant; bstrName: PWideChar; 
                                    const pdat: IDebugApplicationThread; out ppdob: IDebugProperty);
    procedure CreatePropertyBrowserEx(var pvar: OleVariant; bstrName: PWideChar; 
                                      const pdat: IDebugApplicationThread; 
                                      const pdf: IDebugFormatter; out ppdob: IDebugProperty);
    procedure CreateSimpleConnectionPoint(const pdisp: IDispatch; out ppscp: ISimpleConnectionPoint);
    property DefaultInterface: IDebugHelper read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDebugHelperProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDebugHelper
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDebugHelperProperties = class(TPersistent)
  private
    FServer:    TDebugHelper;
    function    GetDefaultInterface: IDebugHelper;
    constructor Create(AServer: TDebugHelper);
  protected
  public
    property DefaultInterface: IDebugHelper read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoCDebugDocumentHelper provides a Create and CreateRemote method to          
// create instances of the default interface IDebugDocumentHelper exposed by              
// the CoClass CDebugDocumentHelper. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCDebugDocumentHelper = class
    class function Create: IDebugDocumentHelper;
    class function CreateRemote(const MachineName: string): IDebugDocumentHelper;
  end;

  TCDebugDocumentHelperonInsertText = procedure(ASender: TObject; cCharacterPosition: LongWord;
                                                                  cNumToInsert: LongWord) of object;
  TCDebugDocumentHelperonRemoveText = procedure(ASender: TObject; cCharacterPosition: LongWord; 
                                                                  cNumToRemove: LongWord) of object;
  TCDebugDocumentHelperonReplaceText = procedure(ASender: TObject; cCharacterPosition: LongWord; 
                                                                   cNumToReplace: LongWord) of object;
  TCDebugDocumentHelperonUpdateTextAttributes = procedure(ASender: TObject; cCharacterPosition: LongWord; 
                                                                            cNumToUpdate: LongWord) of object;
  TCDebugDocumentHelperonUpdateDocumentAttributes = procedure(ASender: TObject; textdocattr: LongWord) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCDebugDocumentHelper
// Help String      : DebugDocumentHelper Class
// Default Interface: IDebugDocumentHelper
// Def. Intf. DISP? : No
// Event   Interface: IDebugDocumentTextEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCDebugDocumentHelperProperties= class;
{$ENDIF}
  TCDebugDocumentHelper = class(TOleServer)
  private
    FOnonDestroy: TNotifyEvent;
    FOnonInsertText: TCDebugDocumentHelperonInsertText;
    FOnonRemoveText: TCDebugDocumentHelperonRemoveText;
    FOnonReplaceText: TCDebugDocumentHelperonReplaceText;
    FOnonUpdateTextAttributes: TCDebugDocumentHelperonUpdateTextAttributes;
    FOnonUpdateDocumentAttributes: TCDebugDocumentHelperonUpdateDocumentAttributes;
    FIntf: IDebugDocumentHelper;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TCDebugDocumentHelperProperties;
    function GetServerProperties: TCDebugDocumentHelperProperties;
{$ENDIF}
    function GetDefaultInterface: IDebugDocumentHelper;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDebugDocumentHelper);
    procedure Disconnect; override;
    procedure Init(const pda: IDebugApplication; pszShortName: PWideChar; pszLongName: PWideChar; 
                   docAttr: LongWord);
    procedure Attach(const pddhParent: IDebugDocumentHelper);
    procedure Detach;
    procedure AddUnicodeText(pszText: PWideChar);
    procedure AddDBCSText(pszText: PChar);
    procedure SetDebugDocumentHost(const pddh: IDebugDocumentHost);
    procedure AddDeferredText(cChars: LongWord; dwTextStartCookie: LongWord);
    procedure DefineScriptBlock(ulCharOffset: LongWord; cChars: LongWord; const pas: IActiveScript; 
                                fScriptlet: Integer; out pdwSourceContext: LongWord);
    procedure SetDefaultTextAttr(staTextAttr: Word);
    procedure SetTextAttributes(ulCharOffset: LongWord; cChars: LongWord; var pstaTextAttr: Word);
    procedure SetLongName(pszLongName: PWideChar);
    procedure SetShortName(pszShortName: PWideChar);
    procedure SetDocumentAttr(pszAttributes: LongWord);
    procedure GetDebugApplicationNode(out ppdan: IDebugApplicationNode);
    procedure GetScriptBlockInfo(dwSourceContext: LongWord; out ppasd: IActiveScript; 
                                 out piCharPos: LongWord; out pcChars: LongWord);
    procedure CreateDebugDocumentContext(iCharPos: LongWord; cChars: LongWord; 
                                         out ppddc: IDebugDocumentContext);
    procedure BringDocumentToTop;
    procedure BringDocumentContextToTop(const pddc: IDebugDocumentContext);
    property DefaultInterface: IDebugDocumentHelper read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCDebugDocumentHelperProperties read GetServerProperties;
{$ENDIF}
    property OnonDestroy: TNotifyEvent read FOnonDestroy write FOnonDestroy;
    property OnonInsertText: TCDebugDocumentHelperonInsertText read FOnonInsertText write FOnonInsertText;
    property OnonRemoveText: TCDebugDocumentHelperonRemoveText read FOnonRemoveText write FOnonRemoveText;
    property OnonReplaceText: TCDebugDocumentHelperonReplaceText read FOnonReplaceText write FOnonReplaceText;
    property OnonUpdateTextAttributes: TCDebugDocumentHelperonUpdateTextAttributes read FOnonUpdateTextAttributes write FOnonUpdateTextAttributes;
    property OnonUpdateDocumentAttributes: TCDebugDocumentHelperonUpdateDocumentAttributes read FOnonUpdateDocumentAttributes write FOnonUpdateDocumentAttributes;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCDebugDocumentHelper
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCDebugDocumentHelperProperties = class(TPersistent)
  private
    FServer:    TCDebugDocumentHelper;
    function    GetDefaultInterface: IDebugDocumentHelper;
    constructor Create(AServer: TCDebugDocumentHelper);
  protected
  public
    property DefaultInterface: IDebugDocumentHelper read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoMachineDebugManager provides a Create and CreateRemote method to          
// create instances of the default interface IMachineDebugManager exposed by              
// the CoClass MachineDebugManager. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoMachineDebugManager = class
    class function Create: IMachineDebugManager;
    class function CreateRemote(const MachineName: string): IMachineDebugManager;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TMachineDebugManager
// Help String      : MachineDebugManager Class
// Default Interface: IMachineDebugManager
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TMachineDebugManagerProperties= class;
{$ENDIF}
  TMachineDebugManager = class(TOleServer)
  private
    FIntf: IMachineDebugManager;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TMachineDebugManagerProperties;
    function GetServerProperties: TMachineDebugManagerProperties;
{$ENDIF}
    function GetDefaultInterface: IMachineDebugManager;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IMachineDebugManager);
    procedure Disconnect; override;
    procedure AddApplication(const pda: IRemoteDebugApplication; out pdwAppCookie: LongWord);
    procedure RemoveApplication(dwAppCookie: LongWord);
    procedure EnumApplications(out ppeda: IEnumRemoteDebugApplications);
    property DefaultInterface: IMachineDebugManager read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TMachineDebugManagerProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TMachineDebugManager
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TMachineDebugManagerProperties = class(TPersistent)
  private
    FServer:    TMachineDebugManager;
    function    GetDefaultInterface: IMachineDebugManager;
    constructor Create(AServer: TMachineDebugManager);
  protected
  public
    property DefaultInterface: IMachineDebugManager read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoDefaultDebugSessionProvider provides a Create and CreateRemote method to          
// create instances of the default interface IDebugSessionProvider exposed by              
// the CoClass DefaultDebugSessionProvider. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoDefaultDebugSessionProvider = class
    class function Create: IDebugSessionProvider;
    class function CreateRemote(const MachineName: string): IDebugSessionProvider;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TDefaultDebugSessionProvider
// Help String      : DefaultDebugSessionProvider Class
// Default Interface: IDebugSessionProvider
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TDefaultDebugSessionProviderProperties= class;
{$ENDIF}
  TDefaultDebugSessionProvider = class(TOleServer)
  private
    FIntf: IDebugSessionProvider;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TDefaultDebugSessionProviderProperties;
    function GetServerProperties: TDefaultDebugSessionProviderProperties;
{$ENDIF}
    function GetDefaultInterface: IDebugSessionProvider;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IDebugSessionProvider);
    procedure Disconnect; override;
    procedure StartDebugSession(const pda: IRemoteDebugApplication);
    property DefaultInterface: IDebugSessionProvider read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TDefaultDebugSessionProviderProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TDefaultDebugSessionProvider
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TDefaultDebugSessionProviderProperties = class(TPersistent)
  private
    FServer:    TDefaultDebugSessionProvider;
    function    GetDefaultInterface: IDebugSessionProvider;
    constructor Create(AServer: TDefaultDebugSessionProvider);
  protected
  public
    property DefaultInterface: IDebugSessionProvider read GetDefaultInterface;
  published
  end;
{$ENDIF}


resourcestring
  dtlServerPage = '(none)';

  dtlOcxPage = '(none)';

implementation


uses ComObj;

class function CoProcessDebugManager.Create: IProcessDebugManager;
begin
  Result := CreateComObject(CLASS_ProcessDebugManager) as IProcessDebugManager;
end;

class function CoProcessDebugManager.CreateRemote(const MachineName: string): IProcessDebugManager;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ProcessDebugManager) as IProcessDebugManager;
end;

procedure TProcessDebugManager.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{78A51822-51F4-11D0-8F20-00805F2CD064}';
    IntfIID:   '{51973C2F-CB0C-11D0-B5C9-00A0244A0E7A}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TProcessDebugManager.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IProcessDebugManager;
  end;
end;

procedure TProcessDebugManager.ConnectTo(svrIntf: IProcessDebugManager);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TProcessDebugManager.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TProcessDebugManager.GetDefaultInterface: IProcessDebugManager;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TProcessDebugManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TProcessDebugManagerProperties.Create(Self);
{$ENDIF}
end;

destructor TProcessDebugManager.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TProcessDebugManager.GetServerProperties: TProcessDebugManagerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TProcessDebugManager.CreateApplication(out ppda: IDebugApplication);
begin
  DefaultInterface.CreateApplication(ppda);
end;

procedure TProcessDebugManager.GetDefaultApplication(out ppda: IDebugApplication);
begin
  DefaultInterface.GetDefaultApplication(ppda);
end;

procedure TProcessDebugManager.AddApplication(const pda: IDebugApplication; 
                                              out pdwAppCookie: LongWord);
begin
  DefaultInterface.AddApplication(pda, pdwAppCookie);
end;

procedure TProcessDebugManager.RemoveApplication(dwAppCookie: LongWord);
begin
  DefaultInterface.RemoveApplication(dwAppCookie);
end;

procedure TProcessDebugManager.CreateDebugDocumentHelper(const pUnkOuter: IUnknown; 
                                                         out pddh: IDebugDocumentHelper);
begin
  DefaultInterface.CreateDebugDocumentHelper(pUnkOuter, pddh);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TProcessDebugManagerProperties.Create(AServer: TProcessDebugManager);
begin
  inherited Create;
  FServer := AServer;
end;

function TProcessDebugManagerProperties.GetDefaultInterface: IProcessDebugManager;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoDebugHelper.Create: IDebugHelper;
begin
  Result := CreateComObject(CLASS_DebugHelper) as IDebugHelper;
end;

class function CoDebugHelper.CreateRemote(const MachineName: string): IDebugHelper;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DebugHelper) as IDebugHelper;
end;

procedure TDebugHelper.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0BFCC060-8C1D-11D0-ACCD-00AA0060275C}';
    IntfIID:   '{51973C3F-CB0C-11D0-B5C9-00A0244A0E7A}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDebugHelper.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IDebugHelper;
  end;
end;

procedure TDebugHelper.ConnectTo(svrIntf: IDebugHelper);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDebugHelper.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDebugHelper.GetDefaultInterface: IDebugHelper;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TDebugHelper.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDebugHelperProperties.Create(Self);
{$ENDIF}
end;

destructor TDebugHelper.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDebugHelper.GetServerProperties: TDebugHelperProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TDebugHelper.CreatePropertyBrowser(var pvar: OleVariant; bstrName: PWideChar; 
                                             const pdat: IDebugApplicationThread; 
                                             out ppdob: IDebugProperty);
begin
  DefaultInterface.CreatePropertyBrowser(pvar, bstrName, pdat, ppdob);
end;

procedure TDebugHelper.CreatePropertyBrowserEx(var pvar: OleVariant; bstrName: PWideChar; 
                                               const pdat: IDebugApplicationThread; 
                                               const pdf: IDebugFormatter; out ppdob: IDebugProperty);
begin
  DefaultInterface.CreatePropertyBrowserEx(pvar, bstrName, pdat, pdf, ppdob);
end;

procedure TDebugHelper.CreateSimpleConnectionPoint(const pdisp: IDispatch; 
                                                   out ppscp: ISimpleConnectionPoint);
begin
  DefaultInterface.CreateSimpleConnectionPoint(pdisp, ppscp);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDebugHelperProperties.Create(AServer: TDebugHelper);
begin
  inherited Create;
  FServer := AServer;
end;

function TDebugHelperProperties.GetDefaultInterface: IDebugHelper;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoCDebugDocumentHelper.Create: IDebugDocumentHelper;
begin
  Result := CreateComObject(CLASS_CDebugDocumentHelper) as IDebugDocumentHelper;
end;

class function CoCDebugDocumentHelper.CreateRemote(const MachineName: string): IDebugDocumentHelper;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CDebugDocumentHelper) as IDebugDocumentHelper;
end;

procedure TCDebugDocumentHelper.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{83B8BCA6-687C-11D0-A405-00AA0060275C}';
    IntfIID:   '{51973C26-CB0C-11D0-B5C9-00A0244A0E7A}';
    EventIID:  '{51973C23-CB0C-11D0-B5C9-00A0244A0E7A}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCDebugDocumentHelper.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IDebugDocumentHelper;
  end;
end;

procedure TCDebugDocumentHelper.ConnectTo(svrIntf: IDebugDocumentHelper);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TCDebugDocumentHelper.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TCDebugDocumentHelper.GetDefaultInterface: IDebugDocumentHelper;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TCDebugDocumentHelper.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCDebugDocumentHelperProperties.Create(Self);
{$ENDIF}
end;

destructor TCDebugDocumentHelper.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCDebugDocumentHelper.GetServerProperties: TCDebugDocumentHelperProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TCDebugDocumentHelper.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
(*{The DispID for this method is DISPID_UNKNOWN!?. }
    -1: if Assigned(FOnonDestroy) then
         FOnonDestroy(Self);
*)
(*{The DispID for this method is DISPID_UNKNOWN!?. }
    -1: if Assigned(FOnonInsertText) then
         FOnonInsertText(Self,
                         Params[0] {LongWord},
                         Params[1] {LongWord});
*)
(*{The DispID for this method is DISPID_UNKNOWN!?. }
    -1: if Assigned(FOnonRemoveText) then
         FOnonRemoveText(Self,
                         Params[0] {LongWord},
                         Params[1] {LongWord});
*)
(*{The DispID for this method is DISPID_UNKNOWN!?. }
    -1: if Assigned(FOnonReplaceText) then
         FOnonReplaceText(Self,
                          Params[0] {LongWord},
                          Params[1] {LongWord});
*)
(*{The DispID for this method is DISPID_UNKNOWN!?. }
    -1: if Assigned(FOnonUpdateTextAttributes) then
         FOnonUpdateTextAttributes(Self,
                                   Params[0] {LongWord},
                                   Params[1] {LongWord});
*)
(*{The DispID for this method is DISPID_UNKNOWN!?. }
    -1: if Assigned(FOnonUpdateDocumentAttributes) then
         FOnonUpdateDocumentAttributes(Self, Params[0] {LongWord});
*)
  end; {case DispID}
end;

procedure TCDebugDocumentHelper.Init(const pda: IDebugApplication; pszShortName: PWideChar; 
                                     pszLongName: PWideChar; docAttr: LongWord);
begin
  DefaultInterface.Init(pda, pszShortName, pszLongName, docAttr);
end;

procedure TCDebugDocumentHelper.Attach(const pddhParent: IDebugDocumentHelper);
begin
  DefaultInterface.Attach(pddhParent);
end;

procedure TCDebugDocumentHelper.Detach;
begin
  DefaultInterface.Detach;
end;

procedure TCDebugDocumentHelper.AddUnicodeText(pszText: PWideChar);
begin
  DefaultInterface.AddUnicodeText(pszText);
end;

procedure TCDebugDocumentHelper.AddDBCSText(pszText: PChar);
begin
  DefaultInterface.AddDBCSText(pszText);
end;

procedure TCDebugDocumentHelper.SetDebugDocumentHost(const pddh: IDebugDocumentHost);
begin
  DefaultInterface.SetDebugDocumentHost(pddh);
end;

procedure TCDebugDocumentHelper.AddDeferredText(cChars: LongWord; dwTextStartCookie: LongWord);
begin
  DefaultInterface.AddDeferredText(cChars, dwTextStartCookie);
end;

procedure TCDebugDocumentHelper.DefineScriptBlock(ulCharOffset: LongWord; cChars: LongWord; 
                                                  const pas: IActiveScript; fScriptlet: Integer; 
                                                  out pdwSourceContext: LongWord);
begin
  DefaultInterface.DefineScriptBlock(ulCharOffset, cChars, pas, fScriptlet, pdwSourceContext);
end;

procedure TCDebugDocumentHelper.SetDefaultTextAttr(staTextAttr: Word);
begin
  DefaultInterface.SetDefaultTextAttr(staTextAttr);
end;

procedure TCDebugDocumentHelper.SetTextAttributes(ulCharOffset: LongWord; cChars: LongWord; 
                                                  var pstaTextAttr: Word);
begin
  DefaultInterface.SetTextAttributes(ulCharOffset, cChars, pstaTextAttr);
end;

procedure TCDebugDocumentHelper.SetLongName(pszLongName: PWideChar);
begin
  DefaultInterface.SetLongName(pszLongName);
end;

procedure TCDebugDocumentHelper.SetShortName(pszShortName: PWideChar);
begin
  DefaultInterface.SetShortName(pszShortName);
end;

procedure TCDebugDocumentHelper.SetDocumentAttr(pszAttributes: LongWord);
begin
  DefaultInterface.SetDocumentAttr(pszAttributes);
end;

procedure TCDebugDocumentHelper.GetDebugApplicationNode(out ppdan: IDebugApplicationNode);
begin
  DefaultInterface.GetDebugApplicationNode(ppdan);
end;

procedure TCDebugDocumentHelper.GetScriptBlockInfo(dwSourceContext: LongWord; 
                                                   out ppasd: IActiveScript; 
                                                   out piCharPos: LongWord; out pcChars: LongWord);
begin
  DefaultInterface.GetScriptBlockInfo(dwSourceContext, ppasd, piCharPos, pcChars);
end;

procedure TCDebugDocumentHelper.CreateDebugDocumentContext(iCharPos: LongWord; cChars: LongWord; 
                                                           out ppddc: IDebugDocumentContext);
begin
  DefaultInterface.CreateDebugDocumentContext(iCharPos, cChars, ppddc);
end;

procedure TCDebugDocumentHelper.BringDocumentToTop;
begin
  DefaultInterface.BringDocumentToTop;
end;

procedure TCDebugDocumentHelper.BringDocumentContextToTop(const pddc: IDebugDocumentContext);
begin
  DefaultInterface.BringDocumentContextToTop(pddc);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCDebugDocumentHelperProperties.Create(AServer: TCDebugDocumentHelper);
begin
  inherited Create;
  FServer := AServer;
end;

function TCDebugDocumentHelperProperties.GetDefaultInterface: IDebugDocumentHelper;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoMachineDebugManager.Create: IMachineDebugManager;
begin
  Result := CreateComObject(CLASS_MachineDebugManager) as IMachineDebugManager;
end;

class function CoMachineDebugManager.CreateRemote(const MachineName: string): IMachineDebugManager;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_MachineDebugManager) as IMachineDebugManager;
end;

procedure TMachineDebugManager.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0C0A3666-30C9-11D0-8F20-00805F2CD064}';
    IntfIID:   '{51973C2C-CB0C-11D0-B5C9-00A0244A0E7A}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TMachineDebugManager.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IMachineDebugManager;
  end;
end;

procedure TMachineDebugManager.ConnectTo(svrIntf: IMachineDebugManager);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TMachineDebugManager.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TMachineDebugManager.GetDefaultInterface: IMachineDebugManager;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TMachineDebugManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TMachineDebugManagerProperties.Create(Self);
{$ENDIF}
end;

destructor TMachineDebugManager.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TMachineDebugManager.GetServerProperties: TMachineDebugManagerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TMachineDebugManager.AddApplication(const pda: IRemoteDebugApplication;
                                              out pdwAppCookie: LongWord);
begin
  DefaultInterface.AddApplication(pda, pdwAppCookie);
end;

procedure TMachineDebugManager.RemoveApplication(dwAppCookie: LongWord);
begin
  DefaultInterface.RemoveApplication(dwAppCookie);
end;

procedure TMachineDebugManager.EnumApplications(out ppeda: IEnumRemoteDebugApplications);
begin
  DefaultInterface.EnumApplications(ppeda);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TMachineDebugManagerProperties.Create(AServer: TMachineDebugManager);
begin
  inherited Create;
  FServer := AServer;
end;

function TMachineDebugManagerProperties.GetDefaultInterface: IMachineDebugManager;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoDefaultDebugSessionProvider.Create: IDebugSessionProvider;
begin
  Result := CreateComObject(CLASS_DefaultDebugSessionProvider) as IDebugSessionProvider;
end;

class function CoDefaultDebugSessionProvider.CreateRemote(const MachineName: string): IDebugSessionProvider;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DefaultDebugSessionProvider) as IDebugSessionProvider;
end;

procedure TDefaultDebugSessionProvider.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{834128A2-51F4-11D0-8F20-00805F2CD064}';
    IntfIID:   '{51973C29-CB0C-11D0-B5C9-00A0244A0E7A}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TDefaultDebugSessionProvider.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IDebugSessionProvider;
  end;
end;

procedure TDefaultDebugSessionProvider.ConnectTo(svrIntf: IDebugSessionProvider);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TDefaultDebugSessionProvider.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TDefaultDebugSessionProvider.GetDefaultInterface: IDebugSessionProvider;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call "Connect" or "ConnectTo" before this operation');
  Result := FIntf;
end;

constructor TDefaultDebugSessionProvider.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TDefaultDebugSessionProviderProperties.Create(Self);
{$ENDIF}
end;

destructor TDefaultDebugSessionProvider.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TDefaultDebugSessionProvider.GetServerProperties: TDefaultDebugSessionProviderProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TDefaultDebugSessionProvider.StartDebugSession(const pda: IRemoteDebugApplication);
begin
  DefaultInterface.StartDebugSession(pda);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TDefaultDebugSessionProviderProperties.Create(AServer: TDefaultDebugSessionProvider);
begin
  inherited Create;
  FServer := AServer;
end;

function TDefaultDebugSessionProviderProperties.GetDefaultInterface: IDebugSessionProvider;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

{$else}
implementation
{$endif}
end.
