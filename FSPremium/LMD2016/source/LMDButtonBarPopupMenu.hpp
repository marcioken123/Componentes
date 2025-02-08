// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDButtonBarPopupMenu.pas' rev: 31.00 (Windows)

#ifndef LmdbuttonbarpopupmenuHPP
#define LmdbuttonbarpopupmenuHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Menus.hpp>
#include <System.Classes.hpp>
#include <LMDBase.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbuttonbarpopupmenu
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDButtonBarPopupMenu;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDButtonBarPopupMenuItem : unsigned char { bmAddSection, bmDelSection, bmRenSection, bmAddItem, bmDelItem, bmRenItem, bmIconSize };

typedef System::Set<TLMDButtonBarPopupMenuItem, TLMDButtonBarPopupMenuItem::bmAddSection, TLMDButtonBarPopupMenuItem::bmIconSize> TLMDButtonBarPopupMenuItems;

class PASCALIMPLEMENTATION TLMDButtonBarPopupMenu : public Vcl::Menus::TPopupMenu
{
	typedef Vcl::Menus::TPopupMenu inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDButtonBarPopupMenuItems FVisibleItems;
	void __fastcall SetSmallIconSize(System::TObject* Sender);
	void __fastcall SetLargeIconSize(System::TObject* Sender);
	void __fastcall AddSection(System::TObject* Sender);
	void __fastcall DelSection(System::TObject* Sender);
	void __fastcall RenSection(System::TObject* Sender);
	void __fastcall AddItem(System::TObject* Sender);
	void __fastcall DelItem(System::TObject* Sender);
	void __fastcall RenItem(System::TObject* Sender);
	
public:
	virtual void __fastcall Popup(int X, int Y);
	virtual void __fastcall Loaded(void);
	__fastcall virtual TLMDButtonBarPopupMenu(System::Classes::TComponent* aOwner);
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout};
	__property TLMDButtonBarPopupMenuItems VisibleItems = {read=FVisibleItems, write=FVisibleItems, default=127};
public:
	/* TPopupMenu.Destroy */ inline __fastcall virtual ~TLMDButtonBarPopupMenu(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbuttonbarpopupmenu */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBUTTONBARPOPUPMENU)
using namespace Lmdbuttonbarpopupmenu;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbuttonbarpopupmenuHPP
