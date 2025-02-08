// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBaseController.pas' rev: 31.00 (Windows)

#ifndef LmdbasecontrollerHPP
#define LmdbasecontrollerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbasecontroller
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDChangeLink;
class DELPHICLASS TLMDBaseController;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDChangeLink : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TLMDBaseController* FSender;
	System::Classes::TNotifyEvent FOnChange;
	
public:
	__fastcall virtual ~TLMDChangeLink(void);
	DYNAMIC void __fastcall Change(void);
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TLMDBaseController* Sender = {read=FSender, write=FSender};
public:
	/* TObject.Create */ inline __fastcall TLMDChangeLink(void) : System::TObject() { }
	
};


class PASCALIMPLEMENTATION TLMDBaseController : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	System::Classes::TList* FClients;
	
protected:
	DYNAMIC void __fastcall Change(void);
	
public:
	__fastcall virtual TLMDBaseController(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDBaseController(void);
	void __fastcall RegisterChanges(TLMDChangeLink* aValue);
	void __fastcall UnRegisterChanges(TLMDChangeLink* aValue);
	
__published:
	__property About = {default=0};
	__property OnChange;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbasecontroller */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASECONTROLLER)
using namespace Lmdbasecontroller;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbasecontrollerHPP
