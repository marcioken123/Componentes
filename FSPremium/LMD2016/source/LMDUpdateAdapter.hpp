// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDUpdateAdapter.pas' rev: 31.00 (Windows)

#ifndef LmdupdateadapterHPP
#define LmdupdateadapterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDTypes.hpp>
#include <LMDWebConfig.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <LMDMemoryMappedStream.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDUpdateFrm.hpp>
#include <LMDUpdateMessage.hpp>
#include <LMDWebBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdupdateadapter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDUpdateTransport;
class DELPHICLASS TLMDCustomUpdateAdapter;
class DELPHICLASS TLMDUpdateAdapter;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDUpdateCloseRequestEvent)(bool &AnAllow);

typedef void __fastcall (__closure *TLMDUpdateProgressEvent)(System::Byte AProgressPercent, Lmdtypes::TLMDString ACurrentFileName, unsigned ACurrentFileSize, unsigned ATimeEstimateElapsed);

typedef void __fastcall (__closure *TLMDUpdateScriptReceiveEvent)(int ADbID, Lmdtypes::TLMDString AScript);

typedef void __fastcall (__closure *TLMDUpdateErrorEvent)(int AErrCode, Lmdtypes::TLMDString AComment);

typedef void __fastcall (__closure *TLMDUpdateConfirmEvent)(System::TObject* Sender, Lmdtypes::TLMDString ADesciption, HRESULT &AResult);

typedef void __fastcall (__closure *TLMDUpdateInformationEvent)(Lmdtypes::TLMDString AInfo);

typedef void __fastcall (__closure *TLMDUpdateOnMessageReceive)(System::TObject* Sender, Lmdupdatemessage::TLMDUpdateMessage* AMessage);

class PASCALIMPLEMENTATION TLMDUpdateTransport : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FIsServer;
	TLMDUpdateOnMessageReceive FOnMessageReceive;
	HWND FWindow;
	NativeUInt FLinkedWindow;
	unsigned FMsg;
	Lmdmemorymappedstream::TLMDMemoryMappedStream* FChannel;
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	bool __fastcall GetConnected(void);
	
public:
	__fastcall TLMDUpdateTransport(bool AServer);
	__fastcall virtual ~TLMDUpdateTransport(void);
	bool __fastcall SendMsg(Lmdupdatemessage::TLMDUpdateMessage* &AMsg);
	__property TLMDUpdateOnMessageReceive OnMessageReceive = {read=FOnMessageReceive, write=FOnMessageReceive};
	__property bool IsServer = {read=FIsServer, nodefault};
	__property HWND WindowHandle = {read=FWindow, nodefault};
	__classmethod TLMDUpdateTransport* __fastcall Instance();
	__classmethod TLMDUpdateTransport* __fastcall CreateInstance(bool AServer);
	__property bool Connected = {read=GetConnected, nodefault};
	void __fastcall SetInstance(TLMDUpdateTransport* AnInstance);
};


class PASCALIMPLEMENTATION TLMDCustomUpdateAdapter : public Lmdwebbase::TLMDWebComponent
{
	typedef Lmdwebbase::TLMDWebComponent inherited;
	
private:
	TLMDUpdateCloseRequestEvent FOnCloseRequest;
	TLMDUpdateProgressEvent FOnProgress;
	TLMDUpdateScriptReceiveEvent FOnScriptReceive;
	System::Classes::TNotifyEvent FOnFinish;
	TLMDUpdateErrorEvent FOnError;
	TLMDUpdateConfirmEvent FOnConfirm;
	TLMDUpdateInformationEvent FOnInformation;
	bool FMakeRollback;
	Lmdwebconfig::TLMDWebConfig* FWebConfig;
	Lmdupdatefrm::TLMDUpdateForm* FUpdateFrm;
	bool __fastcall ExtractFromResource(void);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	void __fastcall MessageReceive(System::TObject* Sender, Lmdupdatemessage::TLMDUpdateMessage* AMessage);
	bool __fastcall CheckForUpdate(void);
	bool __fastcall BreakUpdate(bool ARolledback);
	__fastcall virtual TLMDCustomUpdateAdapter(System::Classes::TComponent* AOwner);
	__property bool MakeRollback = {read=FMakeRollback, write=FMakeRollback, nodefault};
	__property Lmdwebconfig::TLMDWebConfig* WebConfig = {read=FWebConfig, write=FWebConfig};
	__property TLMDUpdateCloseRequestEvent OnCloseRequest = {read=FOnCloseRequest, write=FOnCloseRequest};
	__property TLMDUpdateProgressEvent OnProgress = {read=FOnProgress, write=FOnProgress};
	__property TLMDUpdateScriptReceiveEvent OnScriptReceive = {read=FOnScriptReceive, write=FOnScriptReceive};
	__property System::Classes::TNotifyEvent OnFinish = {read=FOnFinish, write=FOnFinish};
	__property TLMDUpdateErrorEvent OnError = {read=FOnError, write=FOnError};
	__property TLMDUpdateConfirmEvent OnConfirm = {read=FOnConfirm, write=FOnConfirm};
	__property TLMDUpdateInformationEvent OnInformation = {read=FOnInformation, write=FOnInformation};
	__property Lmdupdatefrm::TLMDUpdateForm* UpdateForm = {read=FUpdateFrm, write=FUpdateFrm};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDCustomUpdateAdapter(void) { }
	
};


class PASCALIMPLEMENTATION TLMDUpdateAdapter : public TLMDCustomUpdateAdapter
{
	typedef TLMDCustomUpdateAdapter inherited;
	
__published:
	__property OnCloseRequest;
	__property OnProgress;
	__property OnScriptReceive;
	__property OnFinish;
	__property OnError;
	__property OnConfirm;
	__property OnInformation;
	__property UpdateForm;
	__property WebConfig;
	__property About = {default=0};
public:
	/* TLMDCustomUpdateAdapter.Create */ inline __fastcall virtual TLMDUpdateAdapter(System::Classes::TComponent* AOwner) : TLMDCustomUpdateAdapter(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDUpdateAdapter(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define LMD_UPDATE_TRANSPORT_NAME L"@@@LMD_UPDATE_TRANSPORT@@@"
#define LMD_CHANNEL_NAME L"@@@LMD_UPDATE_CHANNEL@@@"
}	/* namespace Lmdupdateadapter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDUPDATEADAPTER)
using namespace Lmdupdateadapter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdupdateadapterHPP
