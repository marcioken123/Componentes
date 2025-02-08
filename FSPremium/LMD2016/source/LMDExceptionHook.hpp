// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDExceptionHook.pas' rev: 31.00 (Windows)

#ifndef LmdexceptionhookHPP
#define LmdexceptionhookHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Dialogs.hpp>
#include <LMDLogMessage.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdexceptionhook
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDExceptionHook;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDApplicationExceptionHandler)(System::TObject* Sender, System::Sysutils::Exception* E);

typedef void __fastcall (__closure *TLMDExceptionHandler)(System::TObject* Sender, System::UnicodeString AExceptionMessage, void * AExceptionAddr);

class PASCALIMPLEMENTATION TLMDExceptionHook : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	int FMaxLevel;
	bool FShowCallStack;
	bool FShowSystemUnit;
	TLMDExceptionHandler FSystemException;
	TLMDExceptionHandler FApplicationException;
	TLMDExceptionHandler FKernel32Exception;
	void __fastcall ApplicationExceptionHandler(System::TObject* Sender, System::Sysutils::Exception* E);
	TLMDApplicationExceptionHandler __fastcall GetAppicationException(void);
	bool __fastcall GetHookAppicationException(void);
	bool __fastcall GetHookSystemException(void);
	void __fastcall SetAppicationException(TLMDApplicationExceptionHandler Value);
	void __fastcall SetHookAppicationException(bool Value);
	void __fastcall SetHookSystemException(bool Value);
	
public:
	__fastcall TLMDExceptionHook(void);
	__fastcall virtual ~TLMDExceptionHook(void);
	void __fastcall HookExeptionInModule(NativeUInt AModuleHandle);
	__classmethod TLMDExceptionHook* __fastcall Instance();
	void __fastcall ShowExceptionMessage(void * AExceptAddr, System::UnicodeString AExceptionMessage);
	__property TLMDApplicationExceptionHandler AppicationException = {read=GetAppicationException, write=SetAppicationException};
	__property bool HookAppicationException = {read=GetHookAppicationException, write=SetHookAppicationException, nodefault};
	__property bool HookSystemException = {read=GetHookSystemException, write=SetHookSystemException, nodefault};
	__property int MaxLevel = {read=FMaxLevel, write=FMaxLevel, nodefault};
	__property bool ShowCallStack = {read=FShowCallStack, write=FShowCallStack, nodefault};
	__property bool ShowSystemUnit = {read=FShowSystemUnit, write=FShowSystemUnit, nodefault};
	__property TLMDExceptionHandler SystemException = {read=FSystemException, write=FSystemException};
	__property TLMDExceptionHandler ApplicationException = {read=FApplicationException, write=FApplicationException};
	__property TLMDExceptionHandler Kernel32Exception = {read=FKernel32Exception, write=FKernel32Exception};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdexceptionhook */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDEXCEPTIONHOOK)
using namespace Lmdexceptionhook;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdexceptionhookHPP
