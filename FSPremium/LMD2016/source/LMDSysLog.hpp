// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysLog.pas' rev: 31.00 (Windows)

#ifndef LmdsyslogHPP
#define LmdsyslogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDSysBase.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyslog
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysLog;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDSysLogChangeEvent)(System::TObject* Sender, System::UnicodeString propertyDescription, System::UnicodeString oldValue, System::UnicodeString newValue, System::TDateTime datetime);

class PASCALIMPLEMENTATION TLMDSysLog : public Lmdsysbase::TLMDSysComponent
{
	typedef Lmdsysbase::TLMDSysComponent inherited;
	
private:
	TLMDSysLogChangeEvent FOnLog;
	System::Classes::TStrings* FLogStrings;
	Vcl::Stdctrls::TMemo* FLogMemo;
	Vcl::Stdctrls::TCustomListBox* FLogListBox;
	
protected:
	void __fastcall AddLogString(const System::UnicodeString aString);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	void __fastcall SetLogMemo(Vcl::Stdctrls::TMemo* aMemo);
	void __fastcall SetLogListBox(Vcl::Stdctrls::TCustomListBox* aListBox);
	void __fastcall SetLogStrings(System::Classes::TStrings* aStringObject);
	void __fastcall Log(System::UnicodeString changedItem, System::UnicodeString oldValue, System::UnicodeString newValue, System::TDateTime datetime)/* overload */;
	void __fastcall Log(System::UnicodeString changedItem, System::UnicodeString oldValue, System::UnicodeString newValue)/* overload */;
	void __fastcall LogString(const System::UnicodeString aString);
	
__published:
	__property TLMDSysLogChangeEvent OnLog = {read=FOnLog, write=FOnLog};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDSysLog(System::Classes::TComponent* AOwner) : Lmdsysbase::TLMDSysComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDSysLog(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsyslog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSLOG)
using namespace Lmdsyslog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyslogHPP
