// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShConsoleView.pas' rev: 31.00 (Windows)

#ifndef LmdshconsoleviewHPP
#define LmdshconsoleviewHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDUnicode.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDThreads.hpp>
#include <LMDTypes.hpp>
#include <LMDShBase.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshconsoleview
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellConsoleThread;
class DELPHICLASS TLMDShellConsoleView;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDShellOnNewLine)(System::TObject* Sender, System::UnicodeString LString);

enum DECLSPEC_DENUM TLMDShellProcessPriority : unsigned char { ppNormal, ppIdle, ppHigh, ppRealtime };

class PASCALIMPLEMENTATION TLMDShellConsoleThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	Lmdthreads::TLMDCriticalSection* FCritical;
	TLMDShellOnNewLine FOnCapture;
	
protected:
	System::Classes::TStrings* FLines;
	System::Classes::TStrings* FInLines;
	System::UnicodeString FWorkingDir;
	unsigned FProcessTimeout;
	System::UnicodeString FCommandLine;
	unsigned FPriority;
	bool __fastcall IsProcessTimeOut(unsigned AStart);
	virtual void __fastcall Execute(void);
	virtual void __fastcall TriggerCaptureLine(System::UnicodeString S);
	
public:
	__fastcall TLMDShellConsoleThread(System::UnicodeString ACmd, unsigned AProcessTimeout);
	__fastcall virtual ~TLMDShellConsoleThread(void);
	__property System::Classes::TStrings* Lines = {read=FLines, write=FLines};
	__property TLMDShellOnNewLine OnCaptureLine = {read=FOnCapture, write=FOnCapture};
};


class PASCALIMPLEMENTATION TLMDShellConsoleView : public Lmdshbase::TLMDShellComponent
{
	typedef Lmdshbase::TLMDShellComponent inherited;
	
private:
	System::Classes::TStrings* FOutput;
	System::Classes::TStrings* FInput;
	Lmdtypes::TLMDString FCommandLine;
	unsigned FTimeout;
	TLMDShellConsoleThread* FRunningThread;
	System::UnicodeString FWorkingDir;
	TLMDShellProcessPriority FPriority;
	TLMDShellOnNewLine FOnCapture;
	System::Classes::TNotifyEvent FOnTerminated;
	void __fastcall SetOutput(System::Classes::TStrings* const Value);
	void __fastcall SetTimeout(const unsigned Value);
	void __fastcall SetPriority(const TLMDShellProcessPriority Value);
	
public:
	__fastcall virtual TLMDShellConsoleView(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDShellConsoleView(void);
	virtual void __fastcall Execute(void);
	virtual void __fastcall Stop(void);
	virtual void __fastcall Write(System::UnicodeString S);
	__property System::Classes::TStrings* Output = {read=FOutput, write=SetOutput};
	
__published:
	__property Lmdtypes::TLMDString CommandLine = {read=FCommandLine, write=FCommandLine};
	__property System::UnicodeString WorkingDirectory = {read=FWorkingDir, write=FWorkingDir};
	__property unsigned Timeout = {read=FTimeout, write=SetTimeout, default=0};
	__property TLMDShellProcessPriority Priority = {read=FPriority, write=SetPriority, default=0};
	__property TLMDShellOnNewLine OnLineAdd = {read=FOnCapture, write=FOnCapture};
	__property System::Classes::TNotifyEvent OnTerminated = {read=FOnTerminated, write=FOnTerminated};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshconsoleview */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHCONSOLEVIEW)
using namespace Lmdshconsoleview;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshconsoleviewHPP
