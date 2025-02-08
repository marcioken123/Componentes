// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDStopWatch.pas' rev: 31.00 (Windows)

#ifndef LmdstopwatchHPP
#define LmdstopwatchHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdstopwatch
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDStopWatch;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDStopWatch : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Vcl::Controls::TCaption FCaption;
	System::Byte FDigits;
	__int64 FStart;
	__int64 FStop;
	int FStartTime;
	int FStopTime;
	bool FRunning;
	bool FWaitCursor;
	Vcl::Controls::TControl* FControl;
	System::Extended FResult;
	System::UnicodeString FSuffix;
	System::UnicodeString __fastcall GetTimeString(void);
	System::UnicodeString __fastcall GetDisplayCaption(void);
	bool __fastcall GetActive(void);
	void __fastcall SetActive(bool aValue);
	
public:
	__fastcall virtual TLMDStopWatch(System::Classes::TComponent* AOwner);
	void __fastcall Start(void);
	System::Extended __fastcall Stop(void);
	__property System::Extended Time = {read=FResult};
	__property System::UnicodeString TimeString = {read=GetTimeString};
	__property System::UnicodeString DisplayCaption = {read=GetDisplayCaption};
	__property bool Active = {read=GetActive, write=SetActive, nodefault};
	
__published:
	__property About = {default=0};
	__property Vcl::Controls::TControl* Control = {read=FControl, write=FControl};
	__property System::Byte Digits = {read=FDigits, write=FDigits, nodefault};
	__property Vcl::Controls::TCaption Caption = {read=FCaption, write=FCaption};
	__property System::UnicodeString Suffix = {read=FSuffix, write=FSuffix};
	__property bool WaitCursor = {read=FWaitCursor, write=FWaitCursor, default=0};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDStopWatch(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdstopwatch */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSTOPWATCH)
using namespace Lmdstopwatch;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdstopwatchHPP
