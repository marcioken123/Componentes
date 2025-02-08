// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLogMessage.pas' rev: 31.00 (Windows)

#ifndef LmdlogmessageHPP
#define LmdlogmessageHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <System.TypInfo.hpp>
#include <LMDZLib.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDFiles.hpp>
#include <LMDTypes.hpp>
#include <LMDIniCtrl.hpp>
#include <LMDObjectList.hpp>
#include <LMDUnicode.hpp>
#include <LMDStrings.hpp>
#include <LMDSysIn.hpp>
#include <LMDThreads.hpp>
#include <LMDXML.hpp>
#include <LMDProcs.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlogmessage
{
//-- forward type declarations -----------------------------------------------
__interface ILMDStreamed;
typedef System::DelphiInterface<ILMDStreamed> _di_ILMDStreamed;
__interface ILMDLogTransport;
typedef System::DelphiInterface<ILMDLogTransport> _di_ILMDLogTransport;
class DELPHICLASS ELMDLogException;
class DELPHICLASS TLMDLogLevel;
class DELPHICLASS TLMDLogMessageSubtypeClass;
class DELPHICLASS TLMDLogMessage;
class DELPHICLASS TLMDLogCustomSession;
class DELPHICLASS TLMDLogSession;
class DELPHICLASS TLMDLogCustomTransport;
class DELPHICLASS TLMDLogManager;
class DELPHICLASS TLMDLogCustomSendThread;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDLogMessageType : unsigned char { mtControlMessage, mtDataMessage, mtFlowMessage, mtWatchMessage };

typedef GUID TLMDLogMessageSubType;

typedef void __fastcall (__closure *TLMDLogMessageNotify)(System::TObject* Sender, TLMDLogMessage* ALogMessage);

typedef void __fastcall (__closure *TLMDLogCollectorProgress)(System::TObject* Sender, int ACount, int ACurrent);

typedef void __fastcall (__closure *TLMDFilterLogMessageEvent)(System::TObject* Sender, TLMDLogMessage* const AMessage, bool &AFiltered);

__interface  INTERFACE_UUID("{CFDA3B56-D4D8-4174-A9BF-8D863DE0308B}") ILMDStreamed  : public System::IInterface 
{
	virtual void __fastcall SaveToStream(System::Classes::TStream* AStream) = 0 ;
	virtual void __fastcall LoadFromStream(System::Classes::TStream* AStream) = 0 ;
};

__interface  INTERFACE_UUID("{D974AF86-C7E2-49B5-B88F-1D0253320DB3}") ILMDLogTransport  : public System::IInterface 
{
	virtual void __fastcall SetActive(const bool AValue) = 0 ;
	virtual bool __fastcall GetActive(void) = 0 ;
	virtual System::WideString __fastcall GetParameters(void) = 0 ;
	virtual void __fastcall SetParameters(const System::WideString AValue) = 0 ;
	virtual System::WideString __fastcall GetType(void) = 0 ;
	virtual bool __fastcall SendMsg(TLMDLogMessage* AMessage) = 0 ;
	__property bool Active = {read=GetActive, write=SetActive};
	__property System::WideString Parameters = {read=GetParameters, write=SetParameters};
};

#pragma pack(push,4)
class PASCALIMPLEMENTATION ELMDLogException : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall ELMDLogException(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall ELMDLogException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall ELMDLogException(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall ELMDLogException(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDLogException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall ELMDLogException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall ELMDLogException(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall ELMDLogException(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDLogException(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall ELMDLogException(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDLogException(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall ELMDLogException(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~ELMDLogException(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogLevel : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	unsigned FValue;
	Lmdtypes::TLMDString FName;
	
public:
	__fastcall TLMDLogLevel(unsigned ALevelValue, Lmdtypes::TLMDString ALevelName);
	bool __fastcall IsAllow(TLMDLogLevel* ALevel);
	bool __fastcall IsEqual(TLMDLogLevel* ALevel);
	bool __fastcall IsGreater(TLMDLogLevel* ALevel);
	bool __fastcall IsLesser(TLMDLogLevel* Alevel);
	__property unsigned Value = {read=FValue, nodefault};
	__property Lmdtypes::TLMDString Name = {read=FName};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDLogLevel(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogMessageSubtypeClass : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	GUID FGUID;
	System::UnicodeString __fastcall GetAsString(void);
	void __fastcall SetAsString(const System::UnicodeString Value);
	
public:
	bool __fastcall Equal(const GUID &AGUID);
	void __fastcall SaveToStream(System::Classes::TStream* const AStream);
	void __fastcall LoadFromStream(System::Classes::TStream* const AStream);
	__property GUID AsGUID = {read=FGUID, write=FGUID};
	__property System::UnicodeString AsString = {read=GetAsString, write=SetAsString};
public:
	/* TObject.Create */ inline __fastcall TLMDLogMessageSubtypeClass(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDLogMessageSubtypeClass(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDLogMessage : public System::Classes::TInterfacedPersistent
{
	typedef System::Classes::TInterfacedPersistent inherited;
	
private:
	unsigned FThreadId;
	unsigned FProcessId;
	Lmdtypes::TLMDString FUserName;
	Lmdtypes::TLMDString FAppName;
	Lmdtypes::TLMDString FComputerName;
	unsigned FLogLevel;
	Lmdtypes::TLMDString FSessionName;
	Lmdtypes::TLMDString FMessageTitle;
	System::TDateTime FDateTimeSent;
	System::TDateTime FDateTimeReceived;
	System::Classes::TMemoryStream* FStorage;
	TLMDLogMessageType FMessageType;
	TLMDLogMessageSubtypeClass* FMessageSubType;
	System::Uitypes::TColor FBackgroundColor;
	Lmdtypes::TLMDString __fastcall GetMessageName(void);
	Lmdtypes::TLMDString __fastcall GetMessageValue(void);
	
public:
	__fastcall TLMDLogMessage(void);
	__fastcall virtual ~TLMDLogMessage(void);
	void __fastcall SaveToStream(System::Classes::TStream* AStream);
	void __fastcall LoadFromStream(System::Classes::TStream* AStream);
	__property System::Classes::TMemoryStream* Storage = {read=FStorage};
	__property Lmdtypes::TLMDString MessageName = {read=GetMessageName};
	__property Lmdtypes::TLMDString MessageValue = {read=GetMessageValue};
	
__published:
	__property unsigned LogLevel = {read=FLogLevel, nodefault};
	__property TLMDLogMessageSubtypeClass* MessageSubType = {read=FMessageSubType, write=FMessageSubType};
	__property TLMDLogMessageType MessageType = {read=FMessageType, write=FMessageType, nodefault};
	__property Lmdtypes::TLMDString SessionName = {read=FSessionName};
	__property Lmdtypes::TLMDString ComputerName = {read=FComputerName};
	__property Lmdtypes::TLMDString UserName = {read=FUserName};
	__property Lmdtypes::TLMDString AppName = {read=FAppName, write=FAppName};
	__property unsigned ProcessId = {read=FProcessId, write=FProcessId, nodefault};
	__property unsigned ThreadId = {read=FThreadId, write=FThreadId, nodefault};
	__property System::TDateTime DateTimeSent = {read=FDateTimeSent};
	__property System::TDateTime DateTimeReceived = {read=FDateTimeReceived, write=FDateTimeReceived};
	__property Lmdtypes::TLMDString Title = {read=FMessageTitle, write=FMessageTitle};
	__property System::Uitypes::TColor BackgroundColor = {read=FBackgroundColor, write=FBackgroundColor, nodefault};
private:
	void *__ILMDStreamed;	// ILMDStreamed 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {CFDA3B56-D4D8-4174-A9BF-8D863DE0308B}
	operator _di_ILMDStreamed()
	{
		_di_ILMDStreamed intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator ILMDStreamed*(void) { return (ILMDStreamed*)&__ILMDStreamed; }
	#endif
	
};


class PASCALIMPLEMENTATION TLMDLogCustomSession : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	unsigned FProcessId;
	Lmdtypes::TLMDString FComputerName;
	Lmdtypes::TLMDString FUserName;
	Lmdtypes::TLMDString FAppName;
	TLMDLogManager* FLogManager;
	TLMDLogLevel* FDefaultLogLevel;
	TLMDLogLevel* FAllowLogLevel;
	Lmdtypes::TLMDString FSessionName;
	TLMDFilterLogMessageEvent FOnFilterMessage;
	bool FFiltered;
	System::Uitypes::TColor FCurrentBackgroundColor;
	_di_ILMDLogTransport FTransport;
	virtual void __fastcall TriggerFilterMessage(TLMDLogMessage* ALogMsg, bool &ARejected);
	virtual void __fastcall CreateMessage(TLMDLogMessage* &LLogMsg);
	virtual void __fastcall DestroyMessage(TLMDLogMessage* &LLogMsg);
	void __fastcall TransferMessage(TLMDLogMessage* ALogMsg);
	virtual void __fastcall SetCurrentBackgroundColor(const System::Uitypes::TColor AColor);
	
public:
	__fastcall virtual TLMDLogCustomSession(TLMDLogManager* AOwner, const Lmdtypes::TLMDString AName, _di_ILMDLogTransport ATransport);
	__fastcall virtual ~TLMDLogCustomSession(void);
	__classmethod virtual System::WideString __fastcall GetName();
	void __fastcall SendCustomStream(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue, System::Classes::TStream* AStream, TLMDLogMessageType AType, const GUID &ASubType)/* overload */;
	void __fastcall SendCustomStream(Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue, System::Classes::TStream* AStream, TLMDLogMessageType AType, const GUID &ASubType)/* overload */;
	void __fastcall SendCustomString(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue, TLMDLogMessageType AType, const GUID &ASubType)/* overload */;
	void __fastcall SendCustomString(Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue, TLMDLogMessageType AType, const GUID &ASubType)/* overload */;
	void __fastcall SendCustomFile(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue, const Lmdtypes::TLMDString AFileName, TLMDLogMessageType AType, const GUID &ASubType)/* overload */;
	void __fastcall SendCustomFile(Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue, const Lmdtypes::TLMDString AFileName, TLMDLogMessageType AType, const GUID &ASubType)/* overload */;
	__property TLMDLogLevel* DefaultLogLevel = {read=FDefaultLogLevel, write=FDefaultLogLevel};
	__property TLMDLogLevel* AllowLogLevel = {read=FAllowLogLevel, write=FAllowLogLevel};
	__property Lmdtypes::TLMDString Name = {read=FSessionName};
	__property System::Uitypes::TColor BackgroundColor = {read=FCurrentBackgroundColor, write=SetCurrentBackgroundColor, nodefault};
	__property bool Filtered = {read=FFiltered, write=FFiltered, nodefault};
	__property TLMDFilterLogMessageEvent OnFilterMessage = {read=FOnFilterMessage, write=FOnFilterMessage};
};


class PASCALIMPLEMENTATION TLMDLogSession : public TLMDLogCustomSession
{
	typedef TLMDLogCustomSession inherited;
	
public:
	__classmethod virtual System::WideString __fastcall GetName();
	void __fastcall ClearLog(void);
	void __fastcall ClearWatch(void);
	void __fastcall ClearCallStack(void);
	void __fastcall SendSeparator(void);
	void __fastcall TouchCounter(Lmdtypes::TLMDString AName);
	void __fastcall ReleaseCounter(Lmdtypes::TLMDString AName);
	void __fastcall EnterProcess(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall EnterProcess(Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall EnterThread(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall EnterThread(Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall EnterMethod(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall EnterMethod(Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall LeaveProcess(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall LeaveProcess(Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall LeaveThread(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall LeaveThread(Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall LeaveMethod(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall LeaveMethod(Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall CreateCounter(Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall CreateCounter(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall DeleteCounter(Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall DeleteCounter(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall IncCounter(Lmdtypes::TLMDString AName, int ADelta = 0x1)/* overload */;
	void __fastcall IncCounter(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, int ADelta = 0x1)/* overload */;
	void __fastcall DecCounter(Lmdtypes::TLMDString AName, int ADelta = 0x1)/* overload */;
	void __fastcall DecCounter(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, int ADelta = 0x1)/* overload */;
	void __fastcall SendBitmap(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Vcl::Graphics::TBitmap* AValue)/* overload */;
	void __fastcall SendBitmap(Lmdtypes::TLMDString AName, Vcl::Graphics::TBitmap* AValue)/* overload */;
	void __fastcall SendIcon(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, Vcl::Graphics::TIcon* AValue)/* overload */;
	void __fastcall SendIcon(const Lmdtypes::TLMDString AName, Vcl::Graphics::TIcon* AValue)/* overload */;
	void __fastcall SendMetafile(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, Vcl::Graphics::TMetafile* AValue)/* overload */;
	void __fastcall SendMetafile(const Lmdtypes::TLMDString AName, Vcl::Graphics::TMetafile* AValue)/* overload */;
	void __fastcall SendPoint(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, const System::Types::TPoint &AValue)/* overload */;
	void __fastcall SendPoint(const Lmdtypes::TLMDString AName, const System::Types::TPoint &AValue)/* overload */;
	void __fastcall SendRect(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, const System::Types::TRect &AValue)/* overload */;
	void __fastcall SendRect(Lmdtypes::TLMDString AName, const System::Types::TRect &AValue)/* overload */;
	void __fastcall SendHDC(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, const HDC AHDC, const System::Types::TRect &ARect)/* overload */;
	void __fastcall SendHDC(Lmdtypes::TLMDString AName, const HDC AHDC, const System::Types::TRect &ARect)/* overload */;
	void __fastcall SendCanvas(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect)/* overload */;
	void __fastcall SendCanvas(Lmdtypes::TLMDString AName, Vcl::Graphics::TCanvas* const ACanvas, const System::Types::TRect &ARect)/* overload */;
	void __fastcall SendHtml(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AValue)/* overload */;
	void __fastcall SendHtml(const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AValue)/* overload */;
	void __fastcall SendSql(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AValue)/* overload */;
	void __fastcall SendSql(const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AValue)/* overload */;
	void __fastcall SendString(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue)/* overload */;
	void __fastcall SendString(Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue)/* overload */;
	void __fastcall SendFormatString(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AFormat, System::TVarRec *AValues, const int AValues_High)/* overload */;
	void __fastcall SendFormatString(Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AFormat, System::TVarRec *AValues, const int AValues_High)/* overload */;
	void __fastcall SendSourceCode(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue, const Lmdtypes::TLMDString ASyntaxScheme)/* overload */;
	void __fastcall SendSourceCode(Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue, const Lmdtypes::TLMDString ASyntaxScheme)/* overload */;
	void __fastcall SendDate(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall SendDate(Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall SendTime(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall SendTime(Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall SendDateTime(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall SendDateTime(Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall SendInteger(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, int AValue)/* overload */;
	void __fastcall SendInteger(Lmdtypes::TLMDString AName, int AValue)/* overload */;
	void __fastcall SendCurrency(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::Currency AValue)/* overload */;
	void __fastcall SendCurrency(Lmdtypes::TLMDString AName, System::Currency AValue)/* overload */;
	void __fastcall SendFloat(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::Extended AValue)/* overload */;
	void __fastcall SendFloat(Lmdtypes::TLMDString AName, System::Extended AValue)/* overload */;
	void __fastcall SendHResult(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, HRESULT AValue)/* overload */;
	void __fastcall SendHResult(Lmdtypes::TLMDString AName, HRESULT AValue)/* overload */;
	void __fastcall SendBoolean(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AValue)/* overload */;
	void __fastcall SendBoolean(Lmdtypes::TLMDString AName, bool AValue)/* overload */;
	void __fastcall SendEnum(TLMDLogLevel* ALogLevel, const Lmdtypes::TLMDString AName, System::Typinfo::PTypeInfo ATypeInfo, const int AValue)/* overload */;
	void __fastcall SendEnum(const Lmdtypes::TLMDString AName, System::Typinfo::PTypeInfo ATypeInfo, const int AValue)/* overload */;
	void __fastcall SendSet(TLMDLogLevel* ALogLevel, const Lmdtypes::TLMDString AName, System::Typinfo::PTypeInfo ATypeInfo, const int AValue)/* overload */;
	void __fastcall SendSet(const Lmdtypes::TLMDString AName, System::Typinfo::PTypeInfo ATypeInfo, const int AValue)/* overload */;
	void __fastcall SendLastOSError(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, int ALastError)/* overload */;
	void __fastcall SendLastOSError(Lmdtypes::TLMDString AName, int ALastError)/* overload */;
	void __fastcall SendLastOSError(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall SendLastOSError(Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall SendPointer(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, void * AValue)/* overload */;
	void __fastcall SendPointer(Lmdtypes::TLMDString AName, void * AValue)/* overload */;
	void __fastcall SendBinaryData(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, void * AValue, int ASize)/* overload */;
	void __fastcall SendBinaryData(Lmdtypes::TLMDString AName, void * AValue, int ASize)/* overload */;
	void __fastcall SendScreenShot(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, NativeUInt AWindow = (NativeUInt)(0x0))/* overload */;
	void __fastcall SendScreenShot(Lmdtypes::TLMDString AName, NativeUInt AWindow = (NativeUInt)(0x0))/* overload */;
	void __fastcall SendDesktopScreenshot(TLMDLogLevel* ALogLevel)/* overload */;
	void __fastcall SendDesktopScreenshot(void)/* overload */;
	void __fastcall SendSystemInformation(TLMDLogLevel* ALogLevel)/* overload */;
	void __fastcall SendSystemInformation(void)/* overload */;
	void __fastcall SendWindowMessage(TLMDLogLevel* ALogLevel, unsigned AMessage, NativeUInt AWParam, NativeInt ALParam)/* overload */;
	void __fastcall SendWindowMessage(unsigned AMessage, NativeUInt AWParam, NativeInt ALParam)/* overload */;
	void __fastcall SendWindowMessage(TLMDLogLevel* ALogLevel, unsigned AMessage)/* overload */;
	void __fastcall SendWindowMessage(unsigned AMessage)/* overload */;
	void __fastcall SendObject(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::TObject* AInstance)/* overload */;
	void __fastcall SendObject(Lmdtypes::TLMDString AName, System::TObject* AInstance)/* overload */;
	void __fastcall SendComment(Lmdtypes::TLMDString AValue)/* overload */;
	void __fastcall SendComment(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AValue)/* overload */;
	void __fastcall SendImageList(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Vcl::Controls::TImageList* AImageList)/* overload */;
	void __fastcall SendImageList(Lmdtypes::TLMDString AName, Vcl::Controls::TImageList* AImageList)/* overload */;
	void __fastcall SendImageList(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Vcl::Controls::TImageList* AImageList, const int AFromIndex, const int AToIndex)/* overload */;
	void __fastcall SendImageList(Lmdtypes::TLMDString AName, Vcl::Controls::TImageList* AImageList, const int AFromIndex, const int AToIndex)/* overload */;
	void __fastcall SendComponentAsText(Lmdtypes::TLMDString AName, System::Classes::TComponent* AComponent)/* overload */;
	void __fastcall SendComponentAsText(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::Classes::TComponent* AComponent)/* overload */;
	void __fastcall SendStringList(const Lmdtypes::TLMDString AName, System::Classes::TStrings* AValue)/* overload */;
	void __fastcall SendStringList(TLMDLogLevel* ALogLevel, const Lmdtypes::TLMDString AName, System::Classes::TStrings* AValue)/* overload */;
	void __fastcall SendHtmlStream(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, System::Classes::TStream* AStream)/* overload */;
	void __fastcall SendHtmlStream(const Lmdtypes::TLMDString AName, System::Classes::TStream* AStream)/* overload */;
	void __fastcall SendBitmapStream(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, System::Classes::TStream* AStream)/* overload */;
	void __fastcall SendBitmapStream(const Lmdtypes::TLMDString AName, System::Classes::TStream* AStream)/* overload */;
	void __fastcall SendIconStream(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, System::Classes::TStream* AStream)/* overload */;
	void __fastcall SendIconStream(const Lmdtypes::TLMDString AName, System::Classes::TStream* AStream)/* overload */;
	void __fastcall SendMetafileStream(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, System::Classes::TStream* AStream)/* overload */;
	void __fastcall SendMetafileStream(const Lmdtypes::TLMDString AName, System::Classes::TStream* AStream)/* overload */;
	void __fastcall SendSourceCodeStream(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString ASyntaxScheme, System::Classes::TStream* AStream)/* overload */;
	void __fastcall SendSourceCodeStream(const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString ASyntaxScheme, System::Classes::TStream* AStream)/* overload */;
	void __fastcall SendHtmlFile(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall SendHtmlFile(const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall SendBitmapFile(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall SendBitmapFile(const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall SendIconFile(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall SendIconFile(const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall SendMetafileFile(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall SendMetafileFile(const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall SendSourceCodeFile(TLMDLogLevel* const ALogLevel, const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString ASyntaxScheme, const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall SendSourceCodeFile(const Lmdtypes::TLMDString AName, const Lmdtypes::TLMDString ASyntaxScheme, const Lmdtypes::TLMDString AFileName)/* overload */;
	void __fastcall SendIf(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AExpr, Lmdtypes::TLMDString AIfTrue)/* overload */;
	void __fastcall SendIf(Lmdtypes::TLMDString AName, bool AExpr, Lmdtypes::TLMDString AIfTrue)/* overload */;
	void __fastcall SendIf(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AExpr, int AIfTrue)/* overload */;
	void __fastcall SendIf(Lmdtypes::TLMDString AName, bool AExpr, int AIfTrue)/* overload */;
	void __fastcall SendIf(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AExpr, double AIfTrue)/* overload */;
	void __fastcall SendIf(Lmdtypes::TLMDString AName, bool AExpr, double AIfTrue)/* overload */;
	void __fastcall SendIf(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AExpr, System::TObject* AIfTrue)/* overload */;
	void __fastcall SendIf(Lmdtypes::TLMDString AName, bool AExpr, System::TObject* AIfTrue)/* overload */;
	void __fastcall SendIf(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AExpr, bool AIfTrue)/* overload */;
	void __fastcall SendIf(Lmdtypes::TLMDString AName, bool AExpr, bool AIfTrue)/* overload */;
	void __fastcall SendIfThen(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AExpr, Lmdtypes::TLMDString AIfTrue, Lmdtypes::TLMDString AIfFalse)/* overload */;
	void __fastcall SendIfThen(Lmdtypes::TLMDString AName, bool AExpr, Lmdtypes::TLMDString AIfTrue, Lmdtypes::TLMDString AIfFalse)/* overload */;
	void __fastcall SendIfThen(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AExpr, int AIfTrue, int AIfFalse)/* overload */;
	void __fastcall SendIfThen(Lmdtypes::TLMDString AName, bool AExpr, int AIfTrue, int AIfFalse)/* overload */;
	void __fastcall SendIfThen(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AExpr, double AIfTrue, double AIfFalse)/* overload */;
	void __fastcall SendIfThen(Lmdtypes::TLMDString AName, bool AExpr, double AIfTrue, double AIfFalse)/* overload */;
	void __fastcall SendIfThen(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AExpr, System::TObject* AIfTrue, System::TObject* AIfFalse)/* overload */;
	void __fastcall SendIfThen(Lmdtypes::TLMDString AName, bool AExpr, System::TObject* AIfTrue, System::TObject* AIfFalse)/* overload */;
	void __fastcall SendIfThen(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AExpr, bool AIfTrue, bool AIfFalse)/* overload */;
	void __fastcall SendIfThen(Lmdtypes::TLMDString AName, bool AExpr, bool AIfTrue, bool AIfFalse)/* overload */;
	void __fastcall SendAssigned(Lmdtypes::TLMDString AName, void * APointer)/* overload */;
	void __fastcall SendAssigned(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, void * APointer)/* overload */;
	void __fastcall SendProperty(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::TObject* AObject, Lmdtypes::TLMDString APropName)/* overload */;
	void __fastcall SendProperty(Lmdtypes::TLMDString AName, System::TObject* AObject, Lmdtypes::TLMDString APropName)/* overload */;
	void __fastcall SendHeapStatus(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall SendHeapStatus(Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall SendWindowInfo(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, NativeUInt AHandle)/* overload */;
	void __fastcall SendWindowInfo(Lmdtypes::TLMDString AName, NativeUInt AHandle)/* overload */;
	void __fastcall SendWarning(Lmdtypes::TLMDString AWarning)/* overload */;
	void __fastcall SendException(System::Sysutils::Exception* AException)/* overload */;
	void __fastcall SendError(Lmdtypes::TLMDString AError)/* overload */;
	void __fastcall SendFatal(Lmdtypes::TLMDString AError)/* overload */;
	void __fastcall WatchBoolean(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, bool AValue)/* overload */;
	void __fastcall WatchBoolean(Lmdtypes::TLMDString AName, bool AValue)/* overload */;
	void __fastcall WatchString(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue)/* overload */;
	void __fastcall WatchString(Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AValue)/* overload */;
	void __fastcall WatchFormatString(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AFormat, System::TVarRec *AValues, const int AValues_High)/* overload */;
	void __fastcall WatchFormatString(Lmdtypes::TLMDString AName, Lmdtypes::TLMDString AFormat, System::TVarRec *AValues, const int AValues_High)/* overload */;
	void __fastcall WatchInteger(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, int AValue)/* overload */;
	void __fastcall WatchInteger(Lmdtypes::TLMDString AName, int AValue)/* overload */;
	void __fastcall WatchFloat(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::Extended AValue)/* overload */;
	void __fastcall WatchFloat(Lmdtypes::TLMDString AName, System::Extended AValue)/* overload */;
	void __fastcall WatchDate(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall WatchDate(Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall WatchTime(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall WatchTime(Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall WatchDateTime(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall WatchDateTime(Lmdtypes::TLMDString AName, System::TDateTime AValue)/* overload */;
	void __fastcall WatchCurrency(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName, System::Currency AValue)/* overload */;
	void __fastcall WatchCurrency(Lmdtypes::TLMDString AName, System::Currency AValue)/* overload */;
	void __fastcall TimeMark(TLMDLogLevel* ALogLevel, Lmdtypes::TLMDString AName)/* overload */;
	void __fastcall TimeMark(Lmdtypes::TLMDString AName)/* overload */;
public:
	/* TLMDLogCustomSession.Create */ inline __fastcall virtual TLMDLogSession(TLMDLogManager* AOwner, const Lmdtypes::TLMDString AName, _di_ILMDLogTransport ATransport) : TLMDLogCustomSession(AOwner, AName, ATransport) { }
	/* TLMDLogCustomSession.Destroy */ inline __fastcall virtual ~TLMDLogSession(void) { }
	
};


typedef System::TMetaClass* TLMDLogSessionClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogCustomTransport : public System::TInterfacedObject
{
	typedef System::TInterfacedObject inherited;
	
protected:
	bool FActive;
	Lmdthreads::TLMDThreadBuffer* FBuffer;
	System::Classes::TThread* FSendThread;
	virtual System::Classes::TThread* __fastcall CreateSendThread(void) = 0 ;
	virtual System::WideString __fastcall GetParameters(void) = 0 ;
	virtual void __fastcall SetParameters(const System::WideString Value) = 0 ;
	virtual void __fastcall SetActive(const bool AValue);
	virtual bool __fastcall GetActive(void);
	System::WideString __fastcall GetType(void);
	virtual int __fastcall GetMessagesBufferSize(void);
	
public:
	__fastcall virtual TLMDLogCustomTransport(void);
	__fastcall virtual ~TLMDLogCustomTransport(void);
	__classmethod virtual System::WideString __fastcall GetName();
	virtual bool __fastcall SendMsg(TLMDLogMessage* AMessage);
	__property bool Active = {read=GetActive, write=SetActive, nodefault};
	__property System::WideString Parameters = {read=GetParameters, write=SetParameters};
private:
	void *__ILMDLogTransport;	// ILMDLogTransport 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D974AF86-C7E2-49B5-B88F-1D0253320DB3}
	operator _di_ILMDLogTransport()
	{
		_di_ILMDLogTransport intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator ILMDLogTransport*(void) { return (ILMDLogTransport*)&__ILMDLogTransport; }
	#endif
	
};

#pragma pack(pop)

typedef System::TMetaClass* TLMDLogTransportClass;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDLogManager : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Lmdobjectlist::TLMDObjectList* FSessionList;
	Lmdobjectlist::TLMDObjectList* FTransportList;
	Lmdobjectlist::TLMDObjectList* FSessionClasses;
	Lmdobjectlist::TLMDObjectList* FTransportClasses;
	Lmdobjectlist::TLMDObjectList* FLogLevelList;
	TLMDLogCustomSession* __fastcall GetSession(const Lmdtypes::TLMDString AName);
	int __fastcall GetSessionIndex(const Lmdtypes::TLMDString AName);
	TLMDLogSessionClass __fastcall GetSessionClass(const Lmdtypes::TLMDString ASessionClassType);
	TLMDLogTransportClass __fastcall GetTransportClass(const Lmdtypes::TLMDString ATransportName);
	void __fastcall ParseConnectString(const Lmdtypes::TLMDString ASessionConnectString, Lmdtypes::TLMDString &ASessionName, Lmdtypes::TLMDString &ASessionType, Lmdtypes::TLMDString &ATransportType, System::Classes::TStringList* &ATransportParams);
	TLMDLogSession* __fastcall GetRootSession(void);
	
public:
	__fastcall TLMDLogManager(void);
	__fastcall virtual ~TLMDLogManager(void);
	bool __fastcall SaveConfig(Lmdtypes::TLMDString AFileName);
	bool __fastcall LoadConfig(Lmdtypes::TLMDString AFileName);
	void __fastcall RegisterTransportClass(TLMDLogTransportClass ATransportClass);
	void __fastcall RegisterSessionClass(TLMDLogSessionClass ASessionClass);
	void __fastcall RegisterLogLevel(TLMDLogLevel* ALogLevel);
	Lmdtypes::TLMDString __fastcall GetLogLevelNameByValue(const unsigned AValue);
	unsigned __fastcall GetLogLevelValueByName(const Lmdtypes::TLMDString AName);
	TLMDLogCustomSession* __fastcall AddSession(const Lmdtypes::TLMDString ASessionConnectString);
	void __fastcall DeleteSession(const Lmdtypes::TLMDString AName);
	__property TLMDLogSession* RootSession = {read=GetRootSession};
	__property TLMDLogCustomSession* Session[const Lmdtypes::TLMDString AName] = {read=GetSession};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDLogCustomSendThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
protected:
	Lmdthreads::TLMDThreadBuffer* FBuffer;
	virtual void __fastcall Execute(void);
	virtual bool __fastcall DoMessage(TLMDLogMessage* AMessage) = 0 ;
	
public:
	__fastcall TLMDLogCustomSendThread(bool ACreateSuspended, TLMDLogCustomTransport* AOwner);
public:
	/* TThread.Destroy */ inline __fastcall virtual ~TLMDLogCustomSendThread(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<System::Byte, 6> CHeaderMarker;
extern DELPHI_PACKAGE int LMDLogMarker;
extern DELPHI_PACKAGE GUID mstNumber;
extern DELPHI_PACKAGE GUID mstDateTime;
extern DELPHI_PACKAGE GUID mstObject;
extern DELPHI_PACKAGE GUID mstString;
extern DELPHI_PACKAGE GUID mstSourceCode;
extern DELPHI_PACKAGE GUID mstKeyValue;
extern DELPHI_PACKAGE GUID mstImage;
extern DELPHI_PACKAGE GUID mstWarning;
extern DELPHI_PACKAGE GUID mstError;
extern DELPHI_PACKAGE GUID mstFatal;
extern DELPHI_PACKAGE GUID mstInformation;
extern DELPHI_PACKAGE GUID mstException;
extern DELPHI_PACKAGE GUID mstBinary;
extern DELPHI_PACKAGE GUID mstCommand;
extern DELPHI_PACKAGE GUID mstFlowControl;
extern DELPHI_PACKAGE GUID mstProfiling;
extern DELPHI_PACKAGE GUID mstCurrency;
extern DELPHI_PACKAGE GUID mstMessage;
extern DELPHI_PACKAGE GUID mstComment;
extern DELPHI_PACKAGE GUID mstPoint;
extern DELPHI_PACKAGE GUID mstRect;
extern DELPHI_PACKAGE GUID mstPointer;
extern DELPHI_PACKAGE GUID mstBoolean;
extern DELPHI_PACKAGE GUID mstCounter;
extern DELPHI_PACKAGE GUID mstIncCounter;
extern DELPHI_PACKAGE GUID mstDecCounter;
extern DELPHI_PACKAGE GUID mstTable;
extern DELPHI_PACKAGE GUID mstDataSetStructure;
extern DELPHI_PACKAGE GUID mstImageList;
extern DELPHI_PACKAGE GUID mstComponentAsText;
extern DELPHI_PACKAGE GUID mstEnum;
extern DELPHI_PACKAGE GUID mstSet;
extern DELPHI_PACKAGE GUID mstHTML;
extern DELPHI_PACKAGE GUID mstStringList;
extern DELPHI_PACKAGE GUID mstStackTrace;
extern DELPHI_PACKAGE GUID mstNone;
#define SID_LMDLogTransport L"{F4F68406-A3CE-4783-A8BE-4293DC9FB72B}"
#define SID_LMDGeneralLogLink L"{D974AF86-C7E2-49B5-B88F-1D0253320DB3}"
#define SID_LMDImplementing L"{08FBDF7E-3ABB-4731-9B84-5D4F806DD019}"
#define SID_LMDStreamed L"{CFDA3B56-D4D8-4174-A9BF-8D863DE0308B}"
extern DELPHI_PACKAGE GUID IID_LMDLogTransport;
extern DELPHI_PACKAGE GUID IID_LMDImplementing;
extern DELPHI_PACKAGE GUID IID_LMDStreamed;
extern DELPHI_PACKAGE GUID IID_LMDGeneralLogLink;
extern DELPHI_PACKAGE TLMDLogLevel* LogTrace;
extern DELPHI_PACKAGE TLMDLogLevel* LogDebug;
extern DELPHI_PACKAGE TLMDLogLevel* LogInformation;
extern DELPHI_PACKAGE TLMDLogLevel* LogWarning;
extern DELPHI_PACKAGE TLMDLogLevel* LogError;
extern DELPHI_PACKAGE TLMDLogLevel* LogFatal;
extern DELPHI_PACKAGE TLMDLogLevel* LogAll;
extern DELPHI_PACKAGE TLMDLogLevel* LogOff;
extern DELPHI_PACKAGE TLMDLogManager* LMDLogManager;
extern DELPHI_PACKAGE TLMDLogSession* LMDLog;
static const System::WideChar CMSeparator = (System::WideChar)(0x7c);
static const System::WideChar CPSeparator = (System::WideChar)(0x3b);
#define CRootConnectString L"Root|lmd_general_session|lmd_wmcopydata_log|WindowClass=TL"\
	L"MDLogHelperWindow;WindowName=LMDLogHelper"
}	/* namespace Lmdlogmessage */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLOGMESSAGE)
using namespace Lmdlogmessage;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlogmessageHPP
