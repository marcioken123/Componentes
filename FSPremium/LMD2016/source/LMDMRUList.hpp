// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMRUList.pas' rev: 31.00 (Windows)

#ifndef LmdmrulistHPP
#define LmdmrulistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Menus.hpp>
#include <LMDBaseGraphicButton.hpp>
#include <LMDBaseMRUList.hpp>
#include <LMDCustomIniComponent.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmrulist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDMRUList;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDMRUList : public Lmdbasemrulist::TLMDBaseMRUList
{
	typedef Lmdbasemrulist::TLMDBaseMRUList inherited;
	
private:
	Lmdbasegraphicbutton::TLMDBaseGraphicButton* FButton;
	void __fastcall SetSpeedButton(Lmdbasegraphicbutton::TLMDBaseGraphicButton* aValue);
	
protected:
	virtual void __fastcall AssignPopupMenu(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual bool __fastcall InternalPopupRequired(void);
	
public:
	__fastcall virtual ~TLMDMRUList(void);
	
__published:
	__property Lmdbasegraphicbutton::TLMDBaseGraphicButton* Button = {read=FButton, write=SetSpeedButton};
public:
	/* TLMDBaseMRUList.Create */ inline __fastcall virtual TLMDMRUList(System::Classes::TComponent* AOwner) : Lmdbasemrulist::TLMDBaseMRUList(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmrulist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMRULIST)
using namespace Lmdmrulist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmrulistHPP
