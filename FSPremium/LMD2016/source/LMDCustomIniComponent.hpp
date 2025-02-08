// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomIniComponent.pas' rev: 34.00 (Windows)

#ifndef LmdcustominicomponentHPP
#define LmdcustominicomponentHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDIniCtrl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustominicomponent
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomIniComponent;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDCustomIniComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Lmdinictrl::TLMDIniCtrl* FIniLink;
	Lmdinictrl::TLMDIniUse FIniUse;
	System::UnicodeString FSection;
	System::Classes::TNotifyEvent FOwnerFormCreate;
	System::Classes::TNotifyEvent FOwnerFormDestroy;
	void __fastcall OwnerFormCreate(System::TObject* Sender);
	void __fastcall OwnerFormDestroy(System::TObject* Sender);
	void __fastcall SetIniLink(Lmdinictrl::TLMDIniCtrl* aValue);
	void __fastcall SetSection(const System::UnicodeString aValue);
	System::UnicodeString __fastcall GetSection();
	
protected:
	virtual void __fastcall CreateSectionDefault(System::UnicodeString &aValue);
	void __fastcall SetSectionDefault();
	virtual void __fastcall Notification(System::Classes::TComponent* aComponent, System::Classes::TOperation Operation);
	void __fastcall NotificationStandard(System::Classes::TComponent* aComponent);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	
public:
	__fastcall virtual TLMDCustomIniComponent(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomIniComponent();
	DYNAMIC void __fastcall RestoreState();
	DYNAMIC void __fastcall SaveState();
	__property Lmdinictrl::TLMDIniCtrl* IniLink = {read=FIniLink, write=SetIniLink};
	__property Lmdinictrl::TLMDIniUse IniUse = {read=FIniUse, write=FIniUse, default=1};
	__property System::UnicodeString Section = {read=GetSection, write=SetSection};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustominicomponent */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMINICOMPONENT)
using namespace Lmdcustominicomponent;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustominicomponentHPP
