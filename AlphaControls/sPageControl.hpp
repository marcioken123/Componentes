// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sPageControl.pas' rev: 27.00 (Windows)

#ifndef SpagecontrolHPP
#define SpagecontrolHPP

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
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sSpeedButton.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Spagecontrol
{
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TacCloseAction : unsigned char { acaHide, acaFree };

typedef void __fastcall (__closure *TacCloseBtnClick)(System::Classes::TComponent* Sender, int TabIndex, bool &CanClose, TacCloseAction &Action);

typedef void __fastcall (__closure *TacTabMouseEvent)(System::Classes::TComponent* Sender, int TabIndex);

class DELPHICLASS TsTabSkinData;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsTabSkinData : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FCustomColor;
	bool FCustomFont;
	System::UnicodeString FSkinSection;
	void __fastcall SetCustomColor(const bool Value);
	void __fastcall SetCustomFont(const bool Value);
	void __fastcall SetSkinSection(const System::UnicodeString Value);
	
__published:
	__property bool CustomColor = {read=FCustomColor, write=SetCustomColor, nodefault};
	__property bool CustomFont = {read=FCustomFont, write=SetCustomFont, nodefault};
	__property System::UnicodeString SkinSection = {read=FSkinSection, write=SetSkinSection};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TsTabSkinData(void) { }
	
public:
	/* TObject.Create */ inline __fastcall TsTabSkinData(void) : System::Classes::TPersistent() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TacTabType : unsigned char { ttButton, ttMenu, ttTab };

class DELPHICLASS TsTabSheet;
class PASCALIMPLEMENTATION TsTabSheet : public Vcl::Comctrls::TTabSheet
{
	typedef Vcl::Comctrls::TTabSheet inherited;
	
private:
	Vcl::Menus::TPopupMenu* FTabMenu;
	System::UnicodeString FTabSkin;
	TacTabType FTabType;
	System::UnicodeString FButtonSkin;
	bool FUseCloseBtn;
	TsTabSkinData* FCommonData;
	System::Classes::TNotifyEvent FOnClickBtn;
	void __fastcall SetUseCloseBtn(const bool Value);
	void __fastcall SetButtonSkin(const System::UnicodeString Value);
	void __fastcall SetTabSkin(const System::UnicodeString Value);
	void __fastcall SetTabMenu(Vcl::Menus::TPopupMenu* const Value);
	void __fastcall SetTabType(const TacTabType Value);
	
public:
	__fastcall virtual TsTabSheet(System::Classes::TComponent* AOwner);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	__fastcall virtual ~TsTabSheet(void);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMPaint &Message);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
__published:
	__property System::UnicodeString ButtonSkin = {read=FButtonSkin, write=SetButtonSkin};
	__property TacTabType TabType = {read=FTabType, write=SetTabType, default=2};
	__property Vcl::Menus::TPopupMenu* TabMenu = {read=FTabMenu, write=SetTabMenu};
	__property System::UnicodeString TabSkin = {read=FTabSkin, write=SetTabSkin};
	__property TsTabSkinData* SkinData = {read=FCommonData, write=FCommonData};
	__property bool UseCloseBtn = {read=FUseCloseBtn, write=SetUseCloseBtn, default=1};
	__property System::Classes::TNotifyEvent OnClickBtn = {read=FOnClickBtn, write=FOnClickBtn};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsTabSheet(HWND ParentWindow) : Vcl::Comctrls::TTabSheet(ParentWindow) { }
	
};


struct DECLSPEC_DRECORD TacTabData
{
public:
	System::Types::TRect GlyphRect;
	System::Types::TRect TextRect;
	System::Types::TRect BtnRect;
	System::Types::TRect ArrowRect;
	System::Types::TRect FocusRect;
	System::Types::TSize TextSize;
	System::Types::TPoint TextPos;
	Sconst::TacSide ArrowDirection;
};


typedef void __fastcall (__closure *TacTabChangingEvent)(System::TObject* Sender, TsTabSheet* NewPage, bool &AllowChange);

class DELPHICLASS TsPageControl;
class PASCALIMPLEMENTATION TsPageControl : public Vcl::Comctrls::TPageControl
{
	typedef Vcl::Comctrls::TPageControl inherited;
	
private:
	int StoredVisiblePageCount;
	System::UnicodeString ChangedSkinSection;
	Scommondata::TsCommonData* FCommonData;
	Sconst::TacAnimatEvents FAnimatEvents;
	bool FShowCloseBtns;
	TacCloseBtnClick FOnCloseBtnClick;
	System::UnicodeString FCloseBtnSkin;
	TsTabSheet* FNewDockSheet;
	void __fastcall CheckUpDown(void);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CNNotify(Winapi::Messages::TWMNotify &Message);
	void __fastcall StdPaint(Winapi::Messages::TWMPaint &Message);
	void __fastcall DrawStdTabs(HDC DC);
	void __fastcall DrawStdTab(int PageIndex, int State, HDC DC);
	void __fastcall InitTabContentData(Vcl::Graphics::TCanvas* Canvas, Vcl::Comctrls::TTabSheet* Page, const System::Types::TRect &TabRect, int State, bool IsTabMenu, TacTabData &Data);
	void __fastcall AcPaint(const Winapi::Messages::TWMPaint &Message);
	void __fastcall DrawSkinTabs(void);
	void __fastcall DrawSkinTab(int PageIndex, int State, HDC DstDC);
	System::Types::TRect __fastcall PageRect(void);
	System::Types::TRect __fastcall TabsRect(void);
	System::Types::TRect __fastcall SkinTabRect(int Index, bool Active);
	TsTabSheet* __fastcall GetActivePage(void);
	HIDESBASE void __fastcall SetActivePage(TsTabSheet* const Value);
	void __fastcall UpdateBtnData(void);
	void __fastcall SetShowCloseBtns(const bool Value);
	void __fastcall SetCloseBtnSkin(const System::UnicodeString Value);
	System::UnicodeString __fastcall SpinSection(void);
	HIDESBASE MESSAGE void __fastcall CMDockClient(Vcl::Controls::TCMDockClient &Message);
	bool FShowUpDown;
	bool FShowFocus;
	int FHoveredBtnIndex;
	int FPressedBtnIndex;
	bool FRotateCaptions;
	bool FActiveIsBold;
	TacTabChangingEvent FOnPageChanging;
	int FTabPadding;
	TacTabMouseEvent FOnTabMouseEnter;
	TacTabMouseEvent FOnTabMouseLeave;
	bool FAccessibleDisabledPages;
	System::Classes::TAlignment FTabAlignment;
	int FTabSpacing;
	bool FReflectedGlyphs;
	int FTabMargin;
	void __fastcall SetShowUpDown(const bool Value);
	void __fastcall SetShowFocus(const bool Value);
	void __fastcall SetHoveredBtnIndex(const int Value);
	void __fastcall SetRotateCaptions(const bool Value);
	void __fastcall SetActiveIsBold(const bool Value);
	HIDESBASE int __fastcall GetActivePageIndex(void);
	HIDESBASE void __fastcall SetActivePageIndex(const int Value);
	void __fastcall SetTabPadding(const int Value);
	void __fastcall SetCurItem(const int Value);
	void __fastcall SetTabAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetTabSpacing(const int Value);
	void __fastcall SetReflectedGlyphs(const bool Value);
	void __fastcall SetTabMargin(const int Value);
	
protected:
	Acsbutils::TacSpinWnd* SpinWnd;
	int FCurItem;
	int DroppedDownItem;
	int BtnIndex;
	int BtnWidth;
	int BtnHeight;
	int __fastcall BtnOffset(int TabHeight, bool Active);
	DYNAMIC void __fastcall DoAddDockClient(Vcl::Controls::TControl* Client, const System::Types::TRect &ARect);
	void __fastcall PaintButton(HDC DC, const System::Types::TRect &TabRect, int State);
	void __fastcall RepaintTabs(HDC DC, int ActiveTabNdx);
	void __fastcall RepaintTab(int i, int State, HDC TabDC = (HDC)(0x0));
	int __fastcall VisibleTabsCount(void);
	bool __fastcall IsSpecialTab(int i, bool IsMenu = false);
	Vcl::Comctrls::TTabSheet* __fastcall CheckActiveTab(int PageIndex);
	HIDESBASE int __fastcall PageIndexFromTabIndex(int TabIndex);
	bool __fastcall PrepareCache(void);
	virtual void __fastcall SetTabIndex(int Value);
	
public:
	__property int ActivePageIndex = {read=GetActivePageIndex, write=SetActivePageIndex, nodefault};
	__property int CurItem = {read=FCurItem, write=SetCurItem, default=-1};
	__property bool ShowUpDown = {read=FShowUpDown, write=SetShowUpDown, default=1};
	__property int HoveredBtnIndex = {read=FHoveredBtnIndex, write=SetHoveredBtnIndex, default=-1};
	__fastcall virtual TsPageControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsPageControl(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall Loaded(void);
	int __fastcall GetTabUnderMouse(const System::Types::TPoint &p);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall UpdateActivePage(void);
	void __fastcall CloseClick(System::TObject* Sender);
	HIDESBASE void __fastcall SetPadding(bool Value);
	
__published:
	__property TsTabSheet* ActivePage = {read=GetActivePage, write=SetActivePage};
	__property Sconst::TacAnimatEvents AnimatEvents = {read=FAnimatEvents, write=FAnimatEvents, default=16};
	__property bool AccessibleDisabledPages = {read=FAccessibleDisabledPages, write=FAccessibleDisabledPages, default=1};
	__property Style = {default=0};
	__property bool ActiveIsBold = {read=FActiveIsBold, write=SetActiveIsBold, default=0};
	__property System::UnicodeString CloseBtnSkin = {read=FCloseBtnSkin, write=SetCloseBtnSkin};
	__property bool ReflectedGlyphs = {read=FReflectedGlyphs, write=SetReflectedGlyphs, default=0};
	__property bool RotateCaptions = {read=FRotateCaptions, write=SetRotateCaptions, default=0};
	__property bool ShowCloseBtns = {read=FShowCloseBtns, write=SetShowCloseBtns, default=0};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
	__property System::Classes::TAlignment TabAlignment = {read=FTabAlignment, write=SetTabAlignment, default=2};
	__property int TabMargin = {read=FTabMargin, write=SetTabMargin, default=3};
	__property int TabPadding = {read=FTabPadding, write=SetTabPadding, default=0};
	__property int TabSpacing = {read=FTabSpacing, write=SetTabSpacing, default=6};
	__property TacCloseBtnClick OnCloseBtnClick = {read=FOnCloseBtnClick, write=FOnCloseBtnClick};
	__property OnDblClick;
	__property TacTabChangingEvent OnPageChanging = {read=FOnPageChanging, write=FOnPageChanging};
	__property TacTabMouseEvent OnTabMouseEnter = {read=FOnTabMouseEnter, write=FOnTabMouseEnter};
	__property TacTabMouseEvent OnTabMouseLeave = {read=FOnTabMouseLeave, write=FOnTabMouseLeave};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsPageControl(HWND ParentWindow) : Vcl::Comctrls::TPageControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall DeletePage(TsTabSheet* Page);
}	/* namespace Spagecontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SPAGECONTROL)
using namespace Spagecontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SpagecontrolHPP
