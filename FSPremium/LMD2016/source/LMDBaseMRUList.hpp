// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDBaseMRUList.pas' rev: 31.00 (Windows)

#ifndef LmdbasemrulistHPP
#define LmdbasemrulistHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.ComCtrls.hpp>
#include <LMDCustomIniComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>
#include <LMDIniCtrl.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdbasemrulist
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDBaseMRUList;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDMRUListOption : unsigned char { moFileNameOnly, moShowAccel, moSubIfEmpty, moSubClearOption };

typedef System::Set<TLMDMRUListOption, TLMDMRUListOption::moFileNameOnly, TLMDMRUListOption::moSubClearOption> TLMDMRUListOptions;

enum DECLSPEC_DENUM TLMDMRUDisplay : unsigned char { mdFileName, mdDefault };

enum DECLSPEC_DENUM TLMDMRUListStyle : unsigned char { msAfterItem, msBeforeItem, msCreateSubMenu };

typedef void __fastcall (__closure *TLMDMRUClickEvent)(System::TObject* Sender, const System::UnicodeString aValue, bool &Remove);

class PASCALIMPLEMENTATION TLMDBaseMRUList : public Lmdcustominicomponent::TLMDCustomIniComponent
{
	typedef Lmdcustominicomponent::TLMDCustomIniComponent inherited;
	
private:
	System::Byte FMaxEntries;
	System::Byte FMaxLength;
	Vcl::Menus::TMenuItem* FMenuItem;
	System::Classes::THelpContext FHelpContext;
	System::UnicodeString FHint;
	System::Classes::TStrings* FItems;
	TLMDMRUClickEvent FOnClick;
	System::Classes::TNotifyEvent FOnChange;
	TLMDMRUListOptions FOptions;
	System::Classes::TNotifyEvent FOnClearListClick;
	TLMDMRUListStyle FStyle;
	bool FShared;
	TLMDMRUDisplay FDisplay;
	Vcl::Comctrls::TToolButton* FToolButton;
	void __fastcall SetDisplay(TLMDMRUDisplay aValue);
	void __fastcall SetHelpContext(System::Classes::THelpContext aValue);
	void __fastcall SetHint(const System::UnicodeString aValue);
	void __fastcall SetMaxEntries(System::Byte aValue);
	void __fastcall SetMaxLength(System::Byte aValue);
	void __fastcall SetMenuItem(Vcl::Menus::TMenuItem* aValue);
	void __fastcall SetStyle(TLMDMRUListStyle aValue);
	void __fastcall SetToolButton(Vcl::Comctrls::TToolButton* aValue);
	void __fastcall HandleMenuClick(System::TObject* Sender);
	
protected:
	Vcl::Menus::TPopupMenu* FPopUpMenu;
	virtual void __fastcall AssignPopupMenu(void);
	virtual void __fastcall CreateSectionDefault(System::UnicodeString &aValue);
	virtual bool __fastcall InternalPopupRequired(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall UpdateMenu(void);
	
public:
	__fastcall virtual TLMDBaseMRUList(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDBaseMRUList(void);
	void __fastcall Add(const System::UnicodeString aValue);
	void __fastcall AddItems(System::Classes::TStrings* aValue);
	void __fastcall ClearMenu(void);
	HIDESBASE void __fastcall Remove(const System::UnicodeString aValue);
	void __fastcall RemoveAll(void);
	void __fastcall ShareList(System::Classes::TStrings* aValue);
	DYNAMIC void __fastcall RestoreState(void);
	DYNAMIC void __fastcall SaveState(void);
	void __fastcall ReadData(void);
	void __fastcall WriteData(void);
	void __fastcall CheckSharedFile(const System::UnicodeString aValue);
	void __fastcall CheckClearList(System::TObject* Sender);
	__property System::Classes::TStrings* Items = {read=FItems};
	
__published:
	__property About = {default=0};
	__property System::Classes::THelpContext HelpContext = {read=FHelpContext, write=SetHelpContext, default=0};
	__property TLMDMRUDisplay Display = {read=FDisplay, write=SetDisplay, default=0};
	__property System::UnicodeString Hint = {read=FHint, write=SetHint};
	__property System::Byte MaxEntries = {read=FMaxEntries, write=SetMaxEntries, default=4};
	__property System::Byte MaxLength = {read=FMaxLength, write=SetMaxLength, default=255};
	__property Vcl::Menus::TMenuItem* MenuItem = {read=FMenuItem, write=SetMenuItem};
	__property TLMDMRUListOptions Options = {read=FOptions, write=FOptions, default=6};
	__property bool Shared = {read=FShared, write=FShared, default=0};
	__property TLMDMRUListStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property IniLink;
	__property IniUse = {default=1};
	__property Section = {default=0};
	__property Vcl::Comctrls::TToolButton* ToolButton = {read=FToolButton, write=SetToolButton};
	__property TLMDMRUClickEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::Classes::TNotifyEvent OnClearListClick = {read=FOnClearListClick, write=FOnClearListClick};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdbasemrulist */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDBASEMRULIST)
using namespace Lmdbasemrulist;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdbasemrulistHPP
