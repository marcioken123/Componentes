// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolAppLock.pas' rev: 6.00

#ifndef CoolAppLockHPP
#define CoolAppLockHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <CoolCtrls.hpp>	// Pascal unit
#include <ExtCtrls.hpp>	// Pascal unit
#include <TlHelp32.hpp>	// Pascal unit
#include <StdCtrls.hpp>	// Pascal unit
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coolapplock
{
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TAppRunEvent)(System::TObject* Sender, AnsiString AppPath, bool &AllowRun);

class DELPHICLASS TCoolProgrLock;
class PASCALIMPLEMENTATION TCoolProgrLock : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	Extctrls::TTimer* FTimer;
	bool FActive;
	unsigned FInterval;
	Classes::TStringList* StL;
	TAppRunEvent FAppRunDetected;
	void __fastcall SetActive(bool Value);
	void __fastcall TimerAction(System::TObject* Sender);
	void __fastcall SetList(Classes::TStringList* St);
	
protected:
	Classes::TStringList* __fastcall GetSystemProcess(void);
	void __fastcall Kill(AnsiString ProgramPath);
	
public:
	__fastcall virtual TCoolProgrLock(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolProgrLock(void);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property bool Active = {read=FActive, write=SetActive, default=0};
	__property Classes::TStringList* Items = {read=StL, write=SetList};
	__property TAppRunEvent OnAppRunDetected = {read=FAppRunDetected, write=FAppRunDetected};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Coolapplock */
using namespace Coolapplock;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolAppLock
