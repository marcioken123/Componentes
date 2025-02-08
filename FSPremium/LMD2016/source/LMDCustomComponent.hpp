// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomComponent.pas' rev: 34.00 (Windows)

#ifndef LmdcustomcomponentHPP
#define LmdcustomcomponentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomcomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomComponent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomComponent : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::Classes::TNotifyEvent FOnChange;
	
protected:
	System::Word FUpdateCount;
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC void __fastcall Change();
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	__fastcall virtual TLMDCustomComponent(System::Classes::TComponent* AOwner);
	void __fastcall BeginUpdate();
	bool __fastcall IsUpdating();
	void __fastcall EndUpdate(bool aValue = true);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage();
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDCustomComponent() { }
	
private:
	void *__ILMDComponent;	// Intflmdbase::ILMDComponent 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {42DEE038-9F98-4CA3-9734-F770483E97FF}
	operator Intflmdbase::_di_ILMDComponent()
	{
		Intflmdbase::_di_ILMDComponent intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbase::ILMDComponent*(void) { return (Intflmdbase::ILMDComponent*)&__ILMDComponent; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomcomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMCOMPONENT)
using namespace Lmdcustomcomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomcomponentHPP
