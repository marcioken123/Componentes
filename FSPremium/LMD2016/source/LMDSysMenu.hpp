// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysMenu.pas' rev: 31.00 (Windows)

#ifndef LmdsysmenuHPP
#define LmdsysmenuHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Dialogs.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Forms.hpp>
#include <LMDProcs.hpp>
#include <LMDClass.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysmenu
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysMenu;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysMenuEntry : unsigned char { smRestore, smMove, smSize, smMinimize, smMaximize, smClose, smSwitch };

typedef System::Set<TLMDSysMenuEntry, TLMDSysMenuEntry::smRestore, TLMDSysMenuEntry::smSwitch> TLMDSysMenuEntries;

typedef void __fastcall (__closure *TLMDSysMenuClickEvent)(System::TObject* Sender, int Index, System::UnicodeString aCaption);

enum DECLSPEC_DENUM TLMDSysMenuMode : unsigned char { mmItems, mmMenu };

class PASCALIMPLEMENTATION TLMDSysMenu : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	int FFirst;
	bool FActive;
	System::Classes::TStringList* FMenuList;
	System::Classes::TStringList* FItems;
	TLMDSysMenuEntries FSysEntries;
	Vcl::Menus::TPopupMenu* FMenu;
	Vcl::Menus::TMenuItem* it;
	TLMDSysMenuMode FMode;
	TLMDSysMenuClickEvent FOnClick;
	System::Classes::TNotifyEvent FOnChange;
	void __fastcall ActivateMenu(bool aValue);
	void __fastcall ActivatePopUpMenu(void);
	void __fastcall CheckSysEntries(NativeUInt hMenu, NativeUInt hAppMenu);
	void __fastcall DeActivateMenu(bool aValue);
	void __fastcall UpdatePopUpMenu(void);
	NativeUInt __fastcall GetSystemMenuHandle(void);
	System::Classes::TStrings* __fastcall GetItems(void);
	int __fastcall GetItemsCount(void);
	void __fastcall SetItems(System::Classes::TStrings* aValue);
	void __fastcall SetFirst(int aValue);
	void __fastcall SetMenu(Vcl::Menus::TPopupMenu* aValue);
	void __fastcall SetMode(TLMDSysMenuMode aValue);
	
protected:
	virtual void __fastcall Init(void);
	virtual void __fastcall RestoreState(void);
	DYNAMIC void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall SetEnabled(bool aValue)/* overload */;
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual bool __fastcall AppWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDSysMenu(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDSysMenu(void);
	void __fastcall SetChecked(int Index, bool aValue);
	HIDESBASE void __fastcall SetEnabled(int Index, bool aValue)/* overload */;
	bool __fastcall GetChecked(int Index);
	bool __fastcall GetEnabled(int Index);
	void __fastcall UpdateMenu(void);
	void __fastcall ForceUpdate(void);
	System::UnicodeString __fastcall MenuString(int Index);
	__property int MenuCount = {read=GetItemsCount, nodefault};
	
__published:
	__property About = {default=0};
	__property Enabled = {default=1};
	__property System::Classes::TStrings* Items = {read=GetItems, write=SetItems};
	__property int InsertFrom = {read=FFirst, write=SetFirst, default=-1};
	__property HandleApp = {default=0};
	__property Vcl::Menus::TPopupMenu* Menu = {read=FMenu, write=SetMenu};
	__property TLMDSysMenuMode Mode = {read=FMode, write=SetMode, default=0};
	__property TLMDSysMenuEntries ShowEntries = {read=FSysEntries, write=FSysEntries, default=127};
	__property TLMDSysMenuClickEvent OnClick = {read=FOnClick, write=FOnClick};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE TLMDSysMenuEntries defShowEntries;
extern DELPHI_PACKAGE void __fastcall LMDCheckSystemMenu(TLMDSysMenuEntries aFlag, NativeUInt aHandle, bool aW);
extern DELPHI_PACKAGE void __fastcall LMDCheckFormSysMenu(Vcl::Forms::TForm* aForm, TLMDSysMenuEntries aFlag);
extern DELPHI_PACKAGE void __fastcall LMDCheckApplicationSysMenu(TLMDSysMenuEntries aFlag);
}	/* namespace Lmdsysmenu */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSMENU)
using namespace Lmdsysmenu;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysmenuHPP
