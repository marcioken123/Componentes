// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'pLMDConfigExp.pas' rev: 31.00 (Windows)

#ifndef PlmdconfigexpHPP
#define PlmdconfigexpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <ToolsAPI.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Dialogs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Plmdconfigexp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDConfigExpert;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDConfigExpert : public Toolsapi::TNotifierObject
{
	typedef Toolsapi::TNotifierObject inherited;
	
private:
	Vcl::Menus::TMenuItem* FSeparatorItem;
	Vcl::Menus::TMenuItem* FConfigItem;
	void __fastcall CreateMenuItems(void);
	void __fastcall ConfigItemClick(System::TObject* Sender);
	Toolsapi::_di_INTAServices __fastcall GetNTAServices(void);
	
protected:
	System::UnicodeString __fastcall GetIDString(void);
	System::UnicodeString __fastcall GetName(void);
	Toolsapi::TWizardState __fastcall GetState(void);
	
public:
	__fastcall TLMDConfigExpert(void);
	__fastcall virtual ~TLMDConfigExpert(void);
	void __fastcall Execute(void);
private:
	void *__IOTAWizard;	// Toolsapi::IOTAWizard 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B75C0CE0-EEA6-11D1-9504-00608CCBF153}
	operator Toolsapi::_di_IOTAWizard()
	{
		Toolsapi::_di_IOTAWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAWizard*(void) { return (Toolsapi::IOTAWizard*)&__IOTAWizard; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Plmdconfigexp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_PLMDCONFIGEXP)
using namespace Plmdconfigexp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// PlmdconfigexpHPP
