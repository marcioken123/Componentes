// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'acDials.pas' rev: 27.00 (Windows)

#ifndef AcdialsHPP
#define AcdialsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sSkinProvider.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sSkinManager.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Acdials
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TacBorderStyle : unsigned char { acbsDialog, acbsSingle, acbsNone, acbsSizeable, acbsToolWindow, acbsSizeToolWin };

class DELPHICLASS TacSystemMenu;
class DELPHICLASS TacDialogWnd;
class PASCALIMPLEMENTATION TacSystemMenu : public Sskinprovider::TsCustomSysMenu
{
	typedef Sskinprovider::TsCustomSysMenu inherited;
	
public:
	TacDialogWnd* FOwner;
	Vcl::Menus::TMenuItem* ItemRestore;
	Vcl::Menus::TMenuItem* ItemMove;
	Vcl::Menus::TMenuItem* ItemSize;
	Vcl::Menus::TMenuItem* ItemMinimize;
	Vcl::Menus::TMenuItem* ItemMaximize;
	Vcl::Menus::TMenuItem* ItemClose;
	__fastcall virtual TacSystemMenu(System::Classes::TComponent* AOwner);
	bool __fastcall EnabledMove(void);
	bool __fastcall EnabledSize(void);
	HIDESBASE void __fastcall UpdateItems(void);
	void __fastcall RestoreClick(System::TObject* Sender);
	void __fastcall MoveClick(System::TObject* Sender);
	void __fastcall SizeClick(System::TObject* Sender);
	void __fastcall MinClick(System::TObject* Sender);
	void __fastcall MaxClick(System::TObject* Sender);
	void __fastcall CloseClick(System::TObject* Sender);
	virtual bool __fastcall EnabledMax(void);
	virtual bool __fastcall EnabledMin(void);
	virtual bool __fastcall EnabledRestore(void);
	virtual bool __fastcall VisibleClose(void);
	virtual bool __fastcall VisibleMax(void);
	virtual bool __fastcall VisibleMin(void);
	bool __fastcall VisibleSize(void);
public:
	/* TPopupMenu.Destroy */ inline __fastcall virtual ~TacSystemMenu(void) { }
	
};


class DELPHICLASS TacProvider;
class PASCALIMPLEMENTATION TacDialogWnd : public Acsbutils::TacScrollWnd
{
	typedef Acsbutils::TacScrollWnd inherited;
	
protected:
	Sconst::TAOR ArOR;
	int CurrentHT;
	bool FFormActive;
	bool FWMPaintForbidden;
	int FCaptionSkinIndex;
	Sskinprovider::TacMoveTimer* MoveTimer;
	bool Initialized;
	void __fastcall InitExBorders(const bool Active);
	
public:
	Vcl::Forms::TForm* CoverForm;
	Sskinprovider::TacBorderForm* BorderForm;
	Sskinprovider::TsCaptionButton ButtonMin;
	Sskinprovider::TsCaptionButton ButtonMax;
	Sskinprovider::TsCaptionButton ButtonClose;
	Sskinprovider::TsCaptionButton ButtonHelp;
	System::Types::TRect LastClientRect;
	Vcl::Graphics::TBitmap* TitleGlyph;
	HICON TitleIcon;
	Vcl::Graphics::TFont* TitleFont;
	unsigned FormState;
	int dwStyle;
	int dwExStyle;
	bool RgnChanged;
	System::Types::TRect WndRect;
	System::Types::TSize WndSize;
	TacBorderStyle BorderStyle;
	Vcl::Graphics::TBitmap* TitleBG;
	Vcl::Graphics::TBitmap* TempBmp;
	Sskinprovider::TacCtrlAdapter* Adapter;
	TacSystemMenu* SystemMenu;
	TacProvider* Provider;
	int TitleIndex;
	System::UnicodeString TitleSection;
	void __fastcall SendToAdapter(const Winapi::Messages::TMessage &Message);
	void __fastcall MakeTitleBG(void);
	void __fastcall PaintAll(void);
	void __fastcall PaintBorderIcons(void);
	void __fastcall PaintCaption(const HDC DC);
	void __fastcall PaintForm(HDC &DC);
	void __fastcall PrepareTitleGlyph(void);
	void __fastcall RepaintButton(int i);
	virtual void __fastcall acWndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall AfterCreation(void);
	__fastcall virtual ~TacDialogWnd(void);
	void __fastcall InitParams(void);
	void __fastcall UpdateIconsIndexes(void);
	void __fastcall KillAnimations(void);
	void __fastcall Ac_WMPaint(Winapi::Messages::TWMPaint &Msg);
	void __fastcall Ac_WMNCPaint(Winapi::Messages::TMessage &Message);
	void __fastcall Ac_WMNCHitTest(Winapi::Messages::TMessage &Message);
	void __fastcall Ac_WMNCLButtonDown(Winapi::Messages::TWMNCHitMessage &Message);
	void __fastcall Ac_WMLButtonUp(Winapi::Messages::TMessage &Message);
	void __fastcall Ac_WMNCActivate(Winapi::Messages::TMessage &Message);
	void __fastcall Ac_DrawStaticItem(Winapi::Messages::TWMDrawItem &Message);
	int __fastcall HTProcess(Winapi::Messages::TWMNCHitTest &Message);
	void __fastcall SetHotHT(int i, bool Repaint = true);
	void __fastcall SetPressedHT(int i);
	void __fastcall DropSysMenu(int x, int y);
	bool __fastcall AboveBorder(const Winapi::Messages::TWMNCHitTest &Message);
	int __fastcall BorderHeight(void);
	int __fastcall ButtonHeight(int Index);
	int __fastcall CaptionHeight(bool CheckSkin = true);
	System::Types::TPoint __fastcall CursorToPoint(int x, int y);
	bool __fastcall FormActive(void);
	int __fastcall HeaderHeight(void);
	int __fastcall OffsetX(void);
	int __fastcall OffsetY(void);
	System::Types::TRect __fastcall IconRect(void);
	System::Types::TRect __fastcall ShadowSize(void);
	int __fastcall SysButtonWidth(const Sskinprovider::TsCaptionButton &Btn);
	int __fastcall TitleBtnsWidth(void);
	bool __fastcall VisibleMax(void);
	bool __fastcall VisibleMin(void);
	bool __fastcall VisibleHelp(void);
	bool __fastcall VisibleClose(void);
	bool __fastcall VisibleRestore(void);
	bool __fastcall EnabledMax(void);
	bool __fastcall EnabledMin(void);
	bool __fastcall EnabledClose(void);
	bool __fastcall EnabledRestore(void);
public:
	/* TacMainWnd.Create */ inline __fastcall virtual TacDialogWnd(HWND AHandle, Scommondata::TsCommonData* ASkinData, Sskinmanager::TsSkinManager* ASkinManager, const Acsbutils::TacSkinParams &SkinParams, bool Repaint) : Acsbutils::TacScrollWnd(AHandle, ASkinData, ASkinManager, SkinParams, Repaint) { }
	
};


class PASCALIMPLEMENTATION TacProvider : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
public:
	NativeUInt CtrlHandle;
	Sskinprovider::TsSkinProvider* sp;
	TacDialogWnd* ListSW;
	System::Classes::TList* acSkinnedCtrls;
	__fastcall virtual ~TacProvider(void);
	void __fastcall InitForm(Vcl::Forms::TCustomForm* Form);
	bool __fastcall InitSkin(HWND aHandle);
	bool __fastcall InitHwndControls(HWND hWnd);
	bool __fastcall PrintHwndControls(HWND hWnd, HDC DC);
	bool __fastcall AddControl(HWND aHwnd);
public:
	/* TComponent.Create */ inline __fastcall virtual TacProvider(System::Classes::TComponent* AOwner) : System::Classes::TComponent(AOwner) { }
	
};


typedef System::DynamicArray<Acsbutils::TacMnuWnd*> TacMnuArray;

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE HHOOK HookCallback;
extern DELPHI_PACKAGE System::Classes::TList* acSupportedList;
extern DELPHI_PACKAGE int DlgLeft;
extern DELPHI_PACKAGE int DlgTop;
extern DELPHI_PACKAGE TacMnuArray MnuArray;
extern DELPHI_PACKAGE void __fastcall StartBlendOnMovingDlg(TacDialogWnd* dw);
extern DELPHI_PACKAGE NativeInt __stdcall SkinHookCBT(int code, NativeUInt wParam, NativeInt lParam);
extern DELPHI_PACKAGE bool __fastcall AddSupportedForm(NativeUInt hwnd, Winapi::Windows::PCreateStructW cStruct = (Winapi::Windows::PCreateStructW)(0x0));
extern DELPHI_PACKAGE System::WideString __fastcall GetWndText(NativeUInt hwnd);
extern DELPHI_PACKAGE void __fastcall UpdateRgn(TacDialogWnd* ListSW, bool Repaint = true);
extern DELPHI_PACKAGE void __fastcall ClearMnuArray(void);
}	/* namespace Acdials */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ACDIALS)
using namespace Acdials;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// AcdialsHPP
