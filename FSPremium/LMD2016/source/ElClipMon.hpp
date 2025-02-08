﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElClipMon.pas' rev: 31.00 (Windows)

#ifndef ElclipmonHPP
#define ElclipmonHPP

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
#include <Winapi.Messages.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>
#include <LMDUtils.hpp>
#include <ElBaseComp.hpp>
#include <ElComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elclipmon
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElClipboardMonitor;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElClipboardMonitor : public Elbasecomp::TElBaseComponent
{
	typedef Elbasecomp::TElBaseComponent inherited;
	
protected:
	HWND FPrevHandle;
	System::Classes::TStrings* FDataFormats;
	System::Classes::TNotifyEvent FOnChange;
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DoSetEnabled(bool AEnabled);
	virtual void __fastcall TriggerChangeEvent(void);
	System::Classes::TStrings* __fastcall GetDataFormats(void);
	
public:
	__fastcall virtual ~TElClipboardMonitor(void);
	System::UnicodeString __fastcall GetDataString(const System::UnicodeString Format);
	bool __fastcall HasDataFormat(int Format);
	__property System::Classes::TStrings* DataFormats = {read=GetDataFormats};
	
__published:
	__property Enabled = {default=0};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
public:
	/* TElBaseComponent.Create */ inline __fastcall virtual TElClipboardMonitor(System::Classes::TComponent* AOwner) : Elbasecomp::TElBaseComponent(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elclipmon */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCLIPMON)
using namespace Elclipmon;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElclipmonHPP
