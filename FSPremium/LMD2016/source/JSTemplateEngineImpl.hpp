// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'JSTemplateEngineImpl.pas' rev: 31.00 (Windows)

#ifndef JstemplateengineimplHPP
#define JstemplateengineimplHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <ToolsAPI.hpp>
#include <CodeTemplateAPI.hpp>
#include <DesignEditors.hpp>

//-- user supplied -----------------------------------------------------------

namespace Jstemplateengineimpl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTemplateScriptEngine;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TMethodToCall : unsigned char { mcMessageDlg, mcTaskDialog, mcJSDialog };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TTemplateScriptEngine : public Toolsapi::TNotifierObject
{
	typedef Toolsapi::TNotifierObject inherited;
	
public:
	void __fastcall Execute(const Codetemplateapi::_di_IOTACodeTemplate ATemplate, const Codetemplateapi::_di_IOTACodeTemplatePoint APoint, const Toolsapi::_di_IOTASyncEditPoints ASyncPoints, const Codetemplateapi::_di_IOTACodeTemplateScript AScript, bool &Cancel);
	System::WideString __fastcall GetIDString(void);
	System::WideString __fastcall GetLanguage(void);
public:
	/* TObject.Create */ inline __fastcall TTemplateScriptEngine(void) : Toolsapi::TNotifierObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TTemplateScriptEngine(void) { }
	
private:
	void *__IOTACodeTemplateScriptEngine;	// Codetemplateapi::IOTACodeTemplateScriptEngine 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {49A9DED0-9B1B-425B-9752-06E85ED9AE78}
	operator Codetemplateapi::_di_IOTACodeTemplateScriptEngine()
	{
		Codetemplateapi::_di_IOTACodeTemplateScriptEngine intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Codetemplateapi::IOTACodeTemplateScriptEngine*(void) { return (Codetemplateapi::IOTACodeTemplateScriptEngine*)&__IOTACodeTemplateScriptEngine; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Jstemplateengineimpl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_JSTEMPLATEENGINEIMPL)
using namespace Jstemplateengineimpl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// JstemplateengineimplHPP
