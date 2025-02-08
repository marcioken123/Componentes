// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStarter.pas' rev: 31.00 (Windows)

#ifndef LmdstarterHPP
#define LmdstarterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDClass.hpp>
#include <LMDDateTime.hpp>
#include <LMDShBase.hpp>
#include <System.SyncObjs.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstarter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomStarter;
class DELPHICLASS TLMDStarter;
class DELPHICLASS TLMDStarterExt;
class DELPHICLASS TLMDGetAndSendInputThread;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDStarterOperation : unsigned char { smOpen, smPrint, smExplore, smEdit, smProperties };

enum DECLSPEC_DENUM TLMDStarterOptions : unsigned char { soSW_HIDE, soSW_MAXIMIZE, soSW_MINIMIZE, soSW_RESTORE, soSW_SHOW, soSW_SHOWMAXIMIZED, soSW_SHOWMINIMIZED, soSW_SHOWMINNOACTIVE, soSW_SHOWNA, soSW_SHOWNORMAL };

enum DECLSPEC_DENUM TLMDStarterExtendedOption : unsigned char { soxUseCreateProcess, soxRedirectOutput, soxRedirectInput, soxRedirectError };

typedef System::Set<TLMDStarterExtendedOption, TLMDStarterExtendedOption::soxUseCreateProcess, TLMDStarterExtendedOption::soxRedirectError> TLMDStarterExtendedOptions;

typedef void __fastcall (__closure *TLMDStarterOutputEvent)(System::TObject* Sender, System::UnicodeString aBuffer);

class PASCALIMPLEMENTATION TLMDCustomStarter : public Lmdshbase::TLMDShellComponent
{
	typedef Lmdshbase::TLMDShellComponent inherited;
	
protected:
	TLMDStarterOperation FStartOperation;
	TLMDStarterOptions FStartOption;
	System::UnicodeString FParameters;
	System::UnicodeString FFilename;
	System::UnicodeString FDirectory;
	int FResult;
	bool FAutoStart;
	bool FWait;
	Lmddatetime::TLMDDateTime* FStart;
	Lmdclass::TLMDTimer* FFinishedId;
	Lmdclass::TLMDTimer* FTimerID;
	NativeUInt FProcess;
	System::Classes::TNotifyEvent FOnError;
	System::Classes::TNotifyEvent FOnFinished;
	System::Classes::TNotifyEvent FBeforeStart;
	System::Classes::TNotifyEvent FAfterStart;
	bool FUseGlobalTimer;
	void __fastcall SetStartOperation(TLMDStarterOperation aValue);
	void __fastcall SetStartOption(TLMDStarterOptions aValue);
	void __fastcall SetString(int index, System::UnicodeString aValue);
	void __fastcall SetWait(bool aValue);
	void __fastcall SetAutoStart(bool aValue);
	void __fastcall SetStart(Lmddatetime::TLMDDateTime* aValue);
	void __fastcall GetTimer(System::TObject* Sender);
	int __fastcall GetLastErrorInternal(void);
	void __fastcall CheckForProcessEnd(System::TObject* Sender);
	void __fastcall SetUseGlobalTimer(const bool Value);
	
public:
	__fastcall virtual TLMDCustomStarter(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomStarter(void);
	void __fastcall TerminateProcess(void);
	__property int LastError = {read=GetLastErrorInternal, nodefault};
	virtual void __fastcall Execute(void);
	__property NativeUInt Process = {read=FProcess, nodefault};
	__property TLMDStarterOperation StartOperation = {read=FStartOperation, write=SetStartOperation, default=0};
	__property TLMDStarterOptions StartOption = {read=FStartOption, write=SetStartOption, default=4};
	__property System::UnicodeString Command = {read=FFilename, write=SetString, index=0};
	__property System::UnicodeString Parameters = {read=FParameters, write=SetString, index=1};
	__property System::UnicodeString DefaultDir = {read=FDirectory, write=SetString, index=2};
	__property bool AutoStart = {read=FAutoStart, write=SetAutoStart, default=0};
	__property Lmddatetime::TLMDDateTime* StartTime = {read=FStart, write=SetStart};
	__property bool Wait = {read=FWait, write=SetWait, default=0};
	__property bool UseGlobalTimer = {read=FUseGlobalTimer, write=SetUseGlobalTimer, default=0};
	__property System::Classes::TNotifyEvent OnBeforeStart = {read=FBeforeStart, write=FBeforeStart};
	__property System::Classes::TNotifyEvent OnAfterStart = {read=FAfterStart, write=FAfterStart};
	__property System::Classes::TNotifyEvent OnError = {read=FOnError, write=FOnError};
	__property System::Classes::TNotifyEvent OnFinished = {read=FOnFinished, write=FOnFinished};
	
__published:
	__property About = {default=0};
};


class PASCALIMPLEMENTATION TLMDStarter : public TLMDCustomStarter
{
	typedef TLMDCustomStarter inherited;
	
__published:
	__property StartOperation = {default=0};
	__property StartOption = {default=4};
	__property Command = {index=0, default=0};
	__property Parameters = {index=1, default=0};
	__property DefaultDir = {index=2, default=0};
	__property AutoStart = {default=0};
	__property StartTime;
	__property Wait = {default=0};
	__property UseGlobalTimer = {default=0};
	__property OnBeforeStart;
	__property OnAfterStart;
	__property OnError;
	__property OnFinished;
public:
	/* TLMDCustomStarter.Create */ inline __fastcall virtual TLMDStarter(System::Classes::TComponent* AOwner) : TLMDCustomStarter(AOwner) { }
	/* TLMDCustomStarter.Destroy */ inline __fastcall virtual ~TLMDStarter(void) { }
	
};


class PASCALIMPLEMENTATION TLMDStarterExt : public TLMDCustomStarter
{
	typedef TLMDCustomStarter inherited;
	
private:
	TLMDStarterExtendedOptions FExtOptions;
	System::Classes::TThread* FWriteInputThread;
	NativeUInt FOutputRead;
	NativeUInt FOutputWrite;
	NativeUInt FInputRead;
	NativeUInt FInputWrite;
	NativeUInt FErrorWrite;
	NativeUInt FStdIn;
	TLMDStarterOutputEvent FOnOutput;
	System::UnicodeString FInputBuffer;
	System::Syncobjs::TCriticalSection* FLockInputBuffer;
	void __fastcall SetExtOptions(const TLMDStarterExtendedOptions Value);
	
protected:
	void __fastcall PrepareAndRunRedirectedChild(NativeUInt aHChildOutput = (NativeUInt)(0x0), NativeUInt aHChildInput = (NativeUInt)(0x0), NativeUInt aHChildError = (NativeUInt)(0x0));
	void __fastcall PrepareAndRunChild(void);
	virtual void __fastcall PreparePipes(void);
	virtual void __fastcall ReadAndHandleOutput(void);
	
public:
	__fastcall virtual TLMDStarterExt(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDStarterExt(void);
	virtual void __fastcall Execute(void);
	void __fastcall WriteInput(System::UnicodeString aBuffer);
	void __fastcall SendInput(void);
	
__published:
	__property TLMDStarterExtendedOptions ExtStartOptions = {read=FExtOptions, write=SetExtOptions, nodefault};
	__property StartOption = {default=4};
	__property Command = {index=0, default=0};
	__property Parameters = {index=1, default=0};
	__property DefaultDir = {index=2, default=0};
	__property AutoStart = {default=0};
	__property StartTime;
	__property Wait = {default=0};
	__property UseGlobalTimer = {default=0};
	__property OnBeforeStart;
	__property OnAfterStart;
	__property TLMDStarterOutputEvent OnOutput = {read=FOnOutput, write=FOnOutput};
	__property OnError;
	__property OnFinished;
};


class PASCALIMPLEMENTATION TLMDGetAndSendInputThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	TLMDStarterExt* FOwner;
	
public:
	void __fastcall SetOwner(TLMDStarterExt* aOwner);
	virtual void __fastcall Execute(void);
	__fastcall TLMDGetAndSendInputThread(bool CreateSuspended, TLMDStarterExt* aOwner);
	__fastcall virtual ~TLMDGetAndSendInputThread(void);
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstarter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTARTER)
using namespace Lmdstarter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstarterHPP
