// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeChartExp.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeechartexpHPP
#define Vcltee_TeechartexpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <ToolsAPI.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teechartexp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TTeeChartWizard;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TTeeChartWizard : public Toolsapi::TNotifierObject
{
	typedef Toolsapi::TNotifierObject inherited;
	
public:
	bool IsBCB;
	System::UnicodeString __fastcall GetIDString();
	System::UnicodeString __fastcall GetName();
	Toolsapi::TWizardState __fastcall GetState();
	System::UnicodeString __fastcall GetDesigner();
	void __fastcall Execute();
	System::UnicodeString __fastcall GetMenuText();
	System::UnicodeString __fastcall GetAuthor();
	System::UnicodeString __fastcall GetComment();
	System::UnicodeString __fastcall GetPage();
	unsigned __fastcall GetGlyph();
	Toolsapi::_di_IOTAGalleryCategory __fastcall GetGalleryCategory();
	System::UnicodeString __fastcall GetPersonality();
public:
	/* TObject.Create */ inline __fastcall TTeeChartWizard() : Toolsapi::TNotifierObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TTeeChartWizard() { }
	
private:
	void *__IOTARepositoryWizard80;	// Toolsapi::IOTARepositoryWizard80 
	void *__IOTAFormWizard;	// Toolsapi::IOTAFormWizard 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {D7714D41-BC4A-445E-B695-25A65C2F561E}
	operator Toolsapi::_di_IOTARepositoryWizard80()
	{
		Toolsapi::_di_IOTARepositoryWizard80 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard80*(void) { return (Toolsapi::IOTARepositoryWizard80*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {08FCCD88-3A21-4281-ADC9-62FC034CDD12}
	operator Toolsapi::_di_IOTARepositoryWizard60()
	{
		Toolsapi::_di_IOTARepositoryWizard60 intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard60*(void) { return (Toolsapi::IOTARepositoryWizard60*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B75C0CE1-EEA6-11D1-9504-00608CCBF153}
	operator Toolsapi::_di_IOTARepositoryWizard()
	{
		Toolsapi::_di_IOTARepositoryWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTARepositoryWizard*(void) { return (Toolsapi::IOTARepositoryWizard*)&__IOTARepositoryWizard80; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {36C8BF35-EFFE-11D1-AB1D-00C04FB16FB3}
	operator Toolsapi::_di_IOTAFormWizard()
	{
		Toolsapi::_di_IOTAFormWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAFormWizard*(void) { return (Toolsapi::IOTAFormWizard*)&__IOTAFormWizard; }
	#endif
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {B75C0CE0-EEA6-11D1-9504-00608CCBF153}
	operator Toolsapi::_di_IOTAWizard()
	{
		Toolsapi::_di_IOTAWizard intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Toolsapi::IOTAWizard*(void) { return (Toolsapi::IOTAWizard*)&__IOTARepositoryWizard80; }
	#endif
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall Register(void);
}	/* namespace Teechartexp */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEECHARTEXP)
using namespace Vcltee::Teechartexp;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeechartexpHPP
