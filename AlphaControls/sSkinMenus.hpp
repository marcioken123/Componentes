// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sSkinMenus.pas' rev: 27.00 (Windows)

#ifndef SskinmenusHPP
#define SskinmenusHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sskinmenus
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TsMenuItemType : unsigned char { smCaption, smDivider, smNormal, smTopLine };

typedef void __fastcall (__closure *TsMenuManagerDrawItemEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State, TsMenuItemType ItemType);

class DELPHICLASS TacMenuSupport;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacMenuSupport : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FIcoLineSkin;
	bool FUseExtraLine;
	int FExtraLineWidth;
	Vcl::Graphics::TFont* FExtraLineFont;
	System::Byte FAlphaBlend;
	void __fastcall SetExtraLineFont(Vcl::Graphics::TFont* const Value);
	
public:
	__fastcall TacMenuSupport(void);
	__fastcall virtual ~TacMenuSupport(void);
	
__published:
	__property System::Byte AlphaBlend = {read=FAlphaBlend, write=FAlphaBlend, default=255};
	__property System::UnicodeString IcoLineSkin = {read=FIcoLineSkin, write=FIcoLineSkin};
	__property bool UseExtraLine = {read=FUseExtraLine, write=FUseExtraLine, default=0};
	__property int ExtraLineWidth = {read=FExtraLineWidth, write=FExtraLineWidth, default=32};
	__property Vcl::Graphics::TFont* ExtraLineFont = {read=FExtraLineFont, write=SetExtraLineFont};
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TMenuItemData
{
public:
	Vcl::Menus::TMenuItem* Item;
	System::Types::TRect R;
};


struct DECLSPEC_DRECORD TacMenuInfo
{
public:
	Vcl::Menus::TMenuItem* FirstItem;
	Vcl::Graphics::TBitmap* Bmp;
	HWND Wnd;
	bool HaveExtraLine;
};


class DELPHICLASS TsSkinableMenus;
class PASCALIMPLEMENTATION TsSkinableMenus : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TsMenuItemType it;
	int FMargin;
	System::Classes::TAlignment FAlignment;
	int FBevelWidth;
	int FBorderWidth;
	Vcl::Graphics::TFont* FCaptionFont;
	int FSkinBorderWidth;
	int FSpacing;
	void __fastcall SetCaptionFont(Vcl::Graphics::TFont* const Value);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetBevelWidth(const int Value);
	void __fastcall SetBorderWidth(const int Value);
	int __fastcall GetSkinBorderWidth(void);
	
protected:
	TsMenuManagerDrawItemEvent FOnDrawItem;
	int __fastcall ParentHeight(Vcl::Graphics::TCanvas* aCanvas, Vcl::Menus::TMenuItem* Item);
	int __fastcall GetItemHeight(Vcl::Graphics::TCanvas* aCanvas, Vcl::Menus::TMenuItem* Item);
	int __fastcall ParentWidth(Vcl::Graphics::TCanvas* aCanvas, Vcl::Menus::TMenuItem* Item);
	int __fastcall GetItemWidth(Vcl::Graphics::TCanvas* aCanvas, Vcl::Menus::TMenuItem* Item, const TacMenuInfo &mi);
	bool __fastcall IsDivText(Vcl::Menus::TMenuItem* Item);
	void __fastcall PaintDivider(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, Vcl::Menus::TMenuItem* Item, Vcl::Graphics::TBitmap* MenuBmp, const TacMenuInfo &mi);
	void __fastcall PaintCaption(Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect, Vcl::Menus::TMenuItem* Item, Vcl::Graphics::TBitmap* BG, const TacMenuInfo &mi);
	int __fastcall CursorMarginH(void);
	int __fastcall CursorMarginV(void);
	System::Types::TRect __fastcall ItemRect(Vcl::Menus::TMenuItem* Item, const System::Types::TRect &aRect);
	
public:
	Sconst::TAOR ArOR;
	bool FActive;
	System::Classes::TComponent* FOwner;
	bool Pressed;
	bool BorderDrawing;
	bool __fastcall IsTopLine(Vcl::Menus::TMenuItem* Item);
	void __fastcall sMeasureItem(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, int &Width, int &Height);
	void __fastcall sAdvancedDrawItem(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	void __fastcall DrawWndBorder(HWND Wnd, Vcl::Graphics::TBitmap* MenuBmp);
	Vcl::Graphics::TBitmap* __fastcall PrepareMenuBG(Vcl::Menus::TMenuItem* Item, int Width, int Height, HWND Wnd = (HWND)(0x0));
	void __fastcall sMeasureLineItem(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, int &Width, int &Height);
	void __fastcall sAdvancedDrawLineItem(System::TObject* Sender, Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, Winapi::Windows::TOwnerDrawState State);
	bool __fastcall IsOpened(Vcl::Menus::TMenuItem* Item);
	void __fastcall SetActive(const bool Value);
	__fastcall TsSkinableMenus(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsSkinableMenus(void);
	void __fastcall InitItem(Vcl::Menus::TMenuItem* Item, bool A);
	void __fastcall InitItems(bool A);
	void __fastcall InitMenuLine(Vcl::Menus::TMainMenu* Menu, bool A);
	void __fastcall HookItem(Vcl::Menus::TMenuItem* MenuItem, bool FActive);
	void __fastcall HookPopupMenu(Vcl::Menus::TPopupMenu* Menu, bool Active);
	void __fastcall UpdateMenus(void);
	bool __fastcall LastItem(Vcl::Menus::TMenuItem* Item);
	bool __fastcall IsPopupItem(Vcl::Menus::TMenuItem* Item);
	TacMenuInfo __fastcall GetMenuInfo(Vcl::Menus::TMenuItem* Item, const int aWidth, const int aHeight, Vcl::Graphics::TCanvas* aCanvas, HWND aWnd = (HWND)(0x0));
	int __fastcall ExtraWidth(const TacMenuInfo &mi);
	
__published:
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, nodefault};
	__property int BevelWidth = {read=FBevelWidth, write=SetBevelWidth, default=0};
	__property int BorderWidth = {read=FBorderWidth, write=SetBorderWidth, default=3};
	__property Vcl::Graphics::TFont* CaptionFont = {read=FCaptionFont, write=SetCaptionFont};
	__property int SkinBorderWidth = {read=GetSkinBorderWidth, write=FSkinBorderWidth, nodefault};
	__property int Margin = {read=FMargin, write=FMargin, default=2};
	__property int Spacing = {read=FSpacing, write=FSpacing, default=8};
	__property TsMenuManagerDrawItemEvent OnDrawItem = {read=FOnDrawItem, write=FOnDrawItem};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::TObject* MDISkinProvider;
extern DELPHI_PACKAGE bool acCanHookMenu;
extern DELPHI_PACKAGE Vcl::Graphics::TFont* CustomMenuFont;
#define s_SysMenu L"acSysMenu"
extern DELPHI_PACKAGE bool __fastcall ChildIconPresent(void);
extern DELPHI_PACKAGE Vcl::Menus::TMenuItem* __fastcall GetFirstItem(Vcl::Menus::TMenuItem* Item);
extern DELPHI_PACKAGE void __fastcall DeleteUnusedBmps(bool DeleteAll);
extern DELPHI_PACKAGE void __fastcall ClearCache(void);
}	/* namespace Sskinmenus */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SSKINMENUS)
using namespace Sskinmenus;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SskinmenusHPP
