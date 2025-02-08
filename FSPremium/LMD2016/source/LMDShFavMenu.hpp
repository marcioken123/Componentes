// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShFavMenu.pas' rev: 31.00 (Windows)

#ifndef LmdshfavmenuHPP
#define LmdshfavmenuHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.ShlObj.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <LMDShBase.hpp>
#include <LMDShMisc.hpp>
#include <LMDShUtils.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshfavmenu
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellFavoritesMenu;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDShellFavoritesClickEvent)(System::TObject* Sender, System::UnicodeString aValue, bool &DefaultAction);

class PASCALIMPLEMENTATION TLMDShellFavoritesMenu : public Lmdshbase::TLMDShellComponent
{
	typedef Lmdshbase::TLMDShellComponent inherited;
	
private:
	bool FEnabled;
	bool FURLHints;
	System::Classes::THelpContext FHelpContext;
	System::UnicodeString FHint;
	System::Byte FMaxLength;
	Vcl::Menus::TMenuItem* FMenuItem;
	TLMDShellFavoritesClickEvent FOnCustomHandler;
	bool FSeparator;
	Vcl::Graphics::TBitmap* FURLBitmap;
	Vcl::Graphics::TBitmap* FFolderBitmap;
	System::Classes::TNotifyEvent FOldClick;
	System::Classes::TStrings* FItemsPath;
	_ITEMIDLIST *FFavoritesShellFolder;
	Lmdshutils::TLMDRoot FFavoritesFolder;
	void __fastcall SetMaxLength(System::Byte aValue);
	void __fastcall SetMenuItem(Vcl::Menus::TMenuItem* aValue);
	void __fastcall SetFavoritesShellFolder(const Winapi::Shlobj::PItemIDList Value);
	void __fastcall SetFavoritesFolder(Lmdshutils::TLMDRoot Value);
	
protected:
	void __fastcall Build(void);
	void __fastcall ClearMenu(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall MainClick(System::TObject* Sender);
	void __fastcall OnClick(System::TObject* Sender);
	
public:
	__fastcall virtual TLMDShellFavoritesMenu(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDShellFavoritesMenu(void);
	__property Winapi::Shlobj::PItemIDList FavoritesShellFolder = {read=FFavoritesShellFolder, write=SetFavoritesShellFolder};
	
__published:
	__property Lmdshutils::TLMDRoot FavoritesFolder = {read=FFavoritesFolder, write=SetFavoritesFolder};
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property System::Classes::THelpContext HelpContext = {read=FHelpContext, write=FHelpContext, default=0};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property bool InsertSeparator = {read=FSeparator, write=FSeparator, default=0};
	__property System::Byte MaxLength = {read=FMaxLength, write=SetMaxLength, default=255};
	__property Vcl::Menus::TMenuItem* MenuItem = {read=FMenuItem, write=SetMenuItem};
	__property bool URLHints = {read=FURLHints, write=FURLHints, nodefault};
	__property TLMDShellFavoritesClickEvent OnCustomHandler = {read=FOnCustomHandler, write=FOnCustomHandler};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshfavmenu */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHFAVMENU)
using namespace Lmdshfavmenu;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshfavmenuHPP
