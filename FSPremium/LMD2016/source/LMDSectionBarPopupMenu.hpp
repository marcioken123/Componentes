// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSectionBarPopupMenu.pas' rev: 31.00 (Windows)

#ifndef LmdsectionbarpopupmenuHPP
#define LmdsectionbarpopupmenuHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Menus.hpp>
#include <System.Classes.hpp>
#include <LMDBarBase.hpp>
#include <LMDControl.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsectionbarpopupmenu
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSectionBarPopupMenu;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM Lmdsectionbarpopupmenu__1 : unsigned char { sbmAddSection, sbmDelSection, sbmRenSection, sbmMoveSection, sbmAddItem, sbmDelItem, sbmRenItem, sbmIconSize };

typedef System::Set<Lmdsectionbarpopupmenu__1, Lmdsectionbarpopupmenu__1::sbmAddSection, Lmdsectionbarpopupmenu__1::sbmIconSize> TLMDSectionBarPopupMenuItems;

class PASCALIMPLEMENTATION TLMDSectionBarPopupMenu : public Lmdcontrol::TLMDBasePopupMenu
{
	typedef Lmdcontrol::TLMDBasePopupMenu inherited;
	
private:
	bool FCaptionEdit;
	TLMDSectionBarPopupMenuItems FVisibleItems;
	bool FDisableEffect;
	System::TObject* FCurrentItem;
	void __fastcall SetSmallIconSize(System::TObject* Sender);
	void __fastcall SetLargeIconSize(System::TObject* Sender);
	void __fastcall AddSection(System::TObject* Sender);
	void __fastcall DelSection(System::TObject* Sender);
	void __fastcall RenSection(System::TObject* Sender);
	void __fastcall MoveSectionUp(System::TObject* Sender);
	void __fastcall MoveSectionDown(System::TObject* Sender);
	void __fastcall AddItem(System::TObject* Sender);
	void __fastcall DelItem(System::TObject* Sender);
	void __fastcall RenItem(System::TObject* Sender);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	virtual void __fastcall Popup(int X, int Y);
	__fastcall virtual TLMDSectionBarPopupMenu(System::Classes::TComponent* aOwner);
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
	__property TLMDSectionBarPopupMenuItems VisibleItems = {read=FVisibleItems, write=FVisibleItems, default=255};
	__property bool DisableEffect = {read=FDisableEffect, write=FDisableEffect, default=0};
	__property bool CaptionEditor = {read=FCaptionEdit, write=FCaptionEdit, default=0};
public:
	/* TPopupMenu.Destroy */ inline __fastcall virtual ~TLMDSectionBarPopupMenu(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdsectionbarpopupmenu */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSECTIONBARPOPUPMENU)
using namespace Lmdsectionbarpopupmenu;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsectionbarpopupmenuHPP
