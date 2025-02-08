// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElComponent.pas' rev: 31.00 (Windows)

#ifndef ElcomponentHPP
#define ElcomponentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <intfLMDBase.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elcomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElComponent;
class DELPHICLASS TElBaseDlgComponent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TElComponent : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	System::Classes::TNotifyEvent FOnChange;
	
protected:
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	DYNAMIC void __fastcall Change(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	
public:
	Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TComponent.Create */ inline __fastcall virtual TElComponent(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TElComponent(void) { }
	
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


class PASCALIMPLEMENTATION TElBaseDlgComponent : public TElComponent
{
	typedef TElComponent inherited;
	
public:
	virtual bool __fastcall Execute(void) = 0 ;
public:
	/* TComponent.Create */ inline __fastcall virtual TElBaseDlgComponent(System::Classes::TComponent* AOwner) : TElComponent(AOwner) { }
	/* TComponent.Destroy */ inline __fastcall virtual ~TElBaseDlgComponent(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Elcomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELCOMPONENT)
using namespace Elcomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElcomponentHPP
