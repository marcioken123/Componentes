// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDActnList.pas' rev: 31.00 (Windows)

#ifndef LmdactnlistHPP
#define LmdactnlistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.ActnList.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Controls.hpp>
#include <LMDObjectList.hpp>
#include <LMDUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDUnicodeControl.hpp>
#include <intfLMDBase.hpp>
#include <System.Actions.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdactnlist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDActionList;
class DELPHICLASS TLMDAction;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDActionList : public Vcl::Actnlist::TActionList
{
	typedef Vcl::Actnlist::TActionList inherited;
	
private:
	Lmdobjectlist::TLMDObjectList* FReplacedClassesList;
	Lmdtypes::TLMDAboutVar FAbout;
	
public:
	System::Classes::TBasicActionClass __fastcall GetReplacedActionClass(const System::Classes::TBasicActionClass AOriginal);
	__fastcall virtual TLMDActionList(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDActionList(void);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
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


class PASCALIMPLEMENTATION TLMDAction : public Vcl::Actnlist::TAction
{
	typedef Vcl::Actnlist::TAction inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout, stored=false};
public:
	/* TAction.Create */ inline __fastcall virtual TLMDAction(System::Classes::TComponent* AOwner) : Vcl::Actnlist::TAction(AOwner) { }
	
public:
	/* TCustomAction.Destroy */ inline __fastcall virtual ~TLMDAction(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdactnlist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDACTNLIST)
using namespace Lmdactnlist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdactnlistHPP
