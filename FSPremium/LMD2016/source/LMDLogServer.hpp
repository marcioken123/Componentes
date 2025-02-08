// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLogServer.pas' rev: 31.00 (Windows)

#ifndef LmdlogserverHPP
#define LmdlogserverHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <LMDTypes.hpp>
#include <LMDZLib.hpp>
#include <LMDFiles.hpp>
#include <LMDObjectList.hpp>
#include <LMDThreads.hpp>
#include <LMDLogMessage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdlogserver
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLogCollector;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDLogCollector : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	Lmdobjectlist::TLMDObjectList* FMessageList;
	Lmdlogmessage::TLMDLogMessageNotify FOnControlMessageReceive;
	Lmdlogmessage::TLMDLogMessageNotify FOnWatchMessageReceive;
	Lmdlogmessage::TLMDLogMessageNotify FOnFlowMessageReceive;
	Lmdlogmessage::TLMDLogMessageNotify FOnDataMessageReceive;
	bool FLogged;
	Lmdlogmessage::TLMDLogCollectorProgress FOnLoadingProgress;
	Lmdthreads::TLMDCriticalSection* FCriticalSection;
	Lmdlogmessage::TLMDLogMessageNotify FNewMessageNotify;
	bool FIgnorePackets;
	System::Classes::TNotifyEvent FOnLoaded;
	bool FIsLoading;
	bool __fastcall GetIsEmpty(void);
	
protected:
	bool FModified;
	virtual void __fastcall DispatchMessage(Lmdlogmessage::TLMDLogMessage* const ALogMsg);
	virtual void __fastcall TriggerLoadingProgress(int ACount, int ACurrent);
	virtual void __fastcall TriggerReceiveDataMessage(Lmdlogmessage::TLMDLogMessage* ALogMessage);
	virtual void __fastcall TriggerReceiveWatchMessage(Lmdlogmessage::TLMDLogMessage* ALogMessage);
	virtual void __fastcall TriggerReceiveFlowMessage(Lmdlogmessage::TLMDLogMessage* ALogMessage);
	virtual void __fastcall TriggerReceiveControlMessage(Lmdlogmessage::TLMDLogMessage* ALogMessage);
	
public:
	__fastcall TLMDLogCollector(void);
	__fastcall virtual ~TLMDLogCollector(void);
	__classmethod virtual System::WideString __fastcall GetName();
	void __fastcall LoadFromFile(Lmdtypes::TLMDString AFileName);
	void __fastcall LoadFromStream(System::Classes::TStream* AStream);
	void __fastcall SaveToFile(Lmdtypes::TLMDString AFileName);
	void __fastcall SaveToStream(System::Classes::TStream* AStream);
	void __fastcall ReloadQueue(void);
	void __fastcall RemoveLogMessage(Lmdlogmessage::TLMDLogMessage* AMessage);
	void __fastcall InsertAfterLogMessage(Lmdlogmessage::TLMDLogMessage* AAfter, Lmdlogmessage::TLMDLogMessage* ALogMessage);
	void __fastcall InsertBeforeLogMessage(Lmdlogmessage::TLMDLogMessage* ABefore, Lmdlogmessage::TLMDLogMessage* ALogMessage);
	void __fastcall Clear(void);
	__property bool Modified = {read=FModified, nodefault};
	__property bool IsLoading = {read=FIsLoading, nodefault};
	__property bool IgnorePackets = {read=FIgnorePackets, write=FIgnorePackets, nodefault};
	__property Lmdobjectlist::TLMDObjectList* MessageList = {read=FMessageList};
	__property bool Logged = {read=FLogged, write=FLogged, nodefault};
	__property bool IsEmpty = {read=GetIsEmpty, nodefault};
	__property Lmdlogmessage::TLMDLogCollectorProgress OnLoadingProgress = {read=FOnLoadingProgress, write=FOnLoadingProgress};
	__property Lmdlogmessage::TLMDLogMessageNotify OnDataMessageReceive = {read=FOnDataMessageReceive, write=FOnDataMessageReceive};
	__property Lmdlogmessage::TLMDLogMessageNotify OnWatchMessageReceive = {read=FOnWatchMessageReceive, write=FOnWatchMessageReceive};
	__property Lmdlogmessage::TLMDLogMessageNotify OnFlowMessageReceive = {read=FOnFlowMessageReceive, write=FOnFlowMessageReceive};
	__property Lmdlogmessage::TLMDLogMessageNotify OnControlMessageReceive = {read=FOnControlMessageReceive, write=FOnControlMessageReceive};
	__property Lmdlogmessage::TLMDLogMessageNotify OnNewMessage = {read=FNewMessageNotify, write=FNewMessageNotify};
	__property System::Classes::TNotifyEvent OnLoaded = {read=FOnLoaded, write=FOnLoaded};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::StaticArray<System::Byte, 6> CHeaderMarker;
}	/* namespace Lmdlogserver */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLOGSERVER)
using namespace Lmdlogserver;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdlogserverHPP
