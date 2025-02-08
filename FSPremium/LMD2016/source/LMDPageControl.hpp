// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDPageControl.pas' rev: 31.00 (Windows)

#ifndef LmdpagecontrolHPP
#define LmdpagecontrolHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Messages.hpp>
#include <System.Contnrs.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Themes.hpp>
#include <LMDObjectList.hpp>
#include <LMDTypes.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDFXCaption.hpp>
#include <LMDCustomSheetControl.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <System.Types.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <Vcl.ImgList.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdpagecontrol
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTabSheet;
class DELPHICLASS TLMDCustomTabControl;
class DELPHICLASS TLMDTabControl;
class DELPHICLASS TLMDPageControl;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM Lmdpagecontrol__1 : unsigned char { toCloseButton, toNoTabIfEmpty, toShowBorder, toShowFocusRect, toMouseWheelSupport, toShowAccelChar };

typedef System::Set<Lmdpagecontrol__1, Lmdpagecontrol__1::toCloseButton, Lmdpagecontrol__1::toShowAccelChar> TLMDTabOptions;

class PASCALIMPLEMENTATION TLMDTabSheet : public Lmdcustomsheetcontrol::TLMDCustomSheet
{
	typedef Lmdcustomsheetcontrol::TLMDCustomSheet inherited;
	
private:
	bool FTabEnabled;
	void *FData;
	void __fastcall SetPageControl(TLMDPageControl* const Value);
	void __fastcall SetTabVisible(bool Value);
	TLMDPageControl* __fastcall GetPageControl(void);
	bool __fastcall GetTabVisible(void);
	void __fastcall SetTabEnabled(const bool Value);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMTextChanged(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TLMDTabSheet(System::Classes::TComponent* AOwner);
	__property void * Data = {read=FData, write=FData};
	__property TLMDPageControl* PageControl = {read=GetPageControl, write=SetPageControl};
	
__published:
	__property BorderWidth = {default=0};
	__property ImageList;
	__property ImageIndex = {index=0, default=0};
	__property ListIndex = {index=1, default=0};
	__property bool TabEnabled = {read=FTabEnabled, write=SetTabEnabled, default=1};
	__property bool TabVisible = {read=GetTabVisible, write=SetTabVisible, default=1};
public:
	/* TLMDCustomSheet.Destroy */ inline __fastcall virtual ~TLMDTabSheet(void) { }
	
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTabSheet(HWND ParentWindow) : Lmdcustomsheetcontrol::TLMDCustomSheet(ParentWindow) { }
	
};


enum DECLSPEC_DENUM TLMDTabButtonKind : unsigned char { tbkNone, tbkClose, tbkScrollLeft, tbkScrollRight, tbkTab };

typedef void __fastcall (__closure *TLMDDrawTabEvent)(TLMDCustomTabControl* Control, int TabIndex, const System::Types::TRect &Rect, bool Active);

enum DECLSPEC_DENUM TLMDTabStyle : unsigned char { tsTabs, tsButtons, tsFlatButtons, tsSquareTabs, tsNetTabs };

class PASCALIMPLEMENTATION TLMDCustomTabControl : public Lmdcustomsheetcontrol::TLMDCustomSheetControl
{
	typedef Lmdcustomsheetcontrol::TLMDCustomSheetControl inherited;
	
private:
	TLMDTabButtonKind FDownButton;
	TLMDTabButtonKind FHotButton;
	int FHotTabIndex;
	System::StaticArray<bool, 5> FEnabledButton;
	Vcl::Extctrls::TTimer* FTimer;
	System::Word FTimerInterval;
	Lmdobjectlist::TLMDObjectList* FTabList;
	System::Types::TRect FTabRect;
	int FFirstTab;
	int FRowCount;
	System::Byte FImageGap;
	int FIntImageHeight;
	int FIntImageWidth;
	Lmdfxcaption::TLMDFxCaption* FFont3D;
	Vcl::Graphics::TBitmap* FCloseBtnBitmap;
	System::Uitypes::TColor FTabBKColor;
	bool FHotTrack;
	bool FRaggedRight;
	bool FMultiline;
	bool FOwnerDraw;
	bool FScrollOpposite;
	bool FShowTabs;
	Vcl::Comctrls::TTabPosition FTabPosition;
	System::Types::TSmallPoint FOffset;
	System::Types::TSmallPoint FTabSize;
	short FMinTabWidth;
	TLMDTabStyle FTabStyle;
	TLMDTabOptions FOptions;
	TLMDDrawTabEvent FOnDrawTab;
	Vcl::Comctrls::TTabGetImageEvent FOnGetImageIndex;
	Vcl::Comctrls::TTabChangingEvent FOnChanging;
	System::Uitypes::TColor FHotColor;
	Vcl::Menus::TPopupMenu* FTabMenu;
	Lmdgraph::TLMDAlignment FTabAlignment;
	HIDESBASE void __fastcall SetBoolean(const int Index, const bool Value);
	void __fastcall SetDimensions(const int Index, const short Value);
	void __fastcall SetOptions(const TLMDTabOptions Value);
	void __fastcall SetTabPosition(const Vcl::Comctrls::TTabPosition Value);
	void __fastcall SetTabStyle(const TLMDTabStyle Value);
	void __fastcall SetTabBKColor(const System::Uitypes::TColor Value);
	System::Types::TRect __fastcall GetDisplayRect(void);
	int __fastcall GetIntTabHeight(void);
	System::Types::TRect __fastcall GetTabAreaRect(void);
	System::Uitypes::TColor __fastcall GetThemedTabAreaColor(void);
	System::Uitypes::TColor __fastcall GetTabAreaColor(void);
	int __fastcall GetShownTabIndex(const int TabListIndex);
	int __fastcall GetVisibleLastIndex(void);
	int __fastcall GetVisibleFirstIndex(void);
	TLMDTabButtonKind __fastcall KindOfButtonAt(int X, int Y);
	System::Types::TRect __fastcall GetButtonRect(TLMDTabButtonKind Kind);
	virtual void __fastcall DrawButton(TLMDTabButtonKind Kind);
	void __fastcall DrawTabEdges(System::Types::TRect &R, Vcl::Themes::TThemedTab tabID, const System::Types::TRect &clipRect)/* overload */;
	void __fastcall DrawTabEdges(const System::Types::TRect &r1)/* overload */;
	void __fastcall MakeTabVisible(int TabIndex);
	void __fastcall UpdateButton(TLMDTabButtonKind Kind, int Index = 0xffffffff);
	void __fastcall AddTimer(void);
	void __fastcall RemoveTimer(void);
	void __fastcall TimerExpired(System::TObject* Sender);
	void __fastcall UpdateIntImageValues(void);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Msg);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMKillFocus &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetFocus(Winapi::Messages::TWMSetFocus &Message);
	void __fastcall SetTabAlignment(const Lmdgraph::TLMDAlignment Value);
	
protected:
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	bool __fastcall CanScroll(TLMDTabButtonKind Kind = (TLMDTabButtonKind)(0x0));
	virtual void __fastcall DoThemeChanged(void);
	virtual void __fastcall DoPageClose(int PageIndex) = 0 ;
	DYNAMIC bool __fastcall DoMouseWheelDown(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	DYNAMIC bool __fastcall DoMouseWheelUp(System::Classes::TShiftState Shift, const System::Types::TPoint &MousePos);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual int __fastcall GetTabWidth(int Index);
	virtual bool __fastcall GetTabEnabled(int Index) = 0 ;
	int __fastcall GetTabsWidth(void);
	virtual int __fastcall GetTabIndex(void) = 0 ;
	virtual System::UnicodeString __fastcall GetTabText(int Index) = 0 ;
	virtual System::Uitypes::TColor __fastcall GetTabColor(int Index) = 0 ;
	int __fastcall GetTabGap(void);
	virtual int __fastcall GetTabCount(void) = 0 ;
	int __fastcall GetButtonAreaStart(void);
	virtual System::Classes::TComponent* __fastcall GetTabMenuPopupComponent(void) = 0 ;
	bool __fastcall HasVisibleTabs(void);
	virtual bool __fastcall IMLEmpty(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	void __fastcall DrawTabs(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &bRect, bool CalcOnly = false);
	virtual void __fastcall DrawTab(int TabIndex, const System::Types::TRect &Rect, bool Active);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseExit(void);
	virtual void __fastcall SetTabIndex(const int Value) = 0 ;
	void __fastcall UpdateTab(const int index);
	__property System::Types::TRect DisplayRect = {read=GetDisplayRect};
	
public:
	__fastcall virtual TLMDCustomTabControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomTabControl(void);
	int __fastcall IndexOfTabAt(int X, int Y);
	int __fastcall IndexOfTabByCaption(Lmdtypes::TLMDString aTabCaption);
	int __fastcall IndexOfTabByName(Lmdtypes::TLMDString aTabName);
	Vcl::Comctrls::THitTests __fastcall GetHitTestInfoAt(int X, int Y);
	int __fastcall RowCount(void);
	virtual bool __fastcall NextTab(void) = 0 ;
	virtual bool __fastcall PrevTab(void) = 0 ;
	void __fastcall ScrollTabs(int Delta);
	System::Types::TRect __fastcall TabRect(int Index);
	bool __fastcall TabShowing(int Index);
	__property Canvas;
	__property CtlXP = {default=1};
	__property int HotTabIndex = {read=FHotTabIndex, nodefault};
	__property int TabIndex = {read=GetTabIndex, write=SetTabIndex, default=-1};
	
__published:
	__property AutoFocus = {default=0};
	__property BorderWidth = {default=0};
	__property bool HotTrack = {read=FHotTrack, write=SetBoolean, index=5, default=0};
	__property System::Uitypes::TColor HotColor = {read=FHotColor, write=FHotColor, default=-16777203};
	__property ParentBackground = {default=0};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property Vcl::Menus::TPopupMenu* TabMenu = {read=FTabMenu, write=FTabMenu};
	__property short MinTabWidth = {read=FMinTabWidth, write=SetDimensions, index=4, default=40};
	__property bool MultiLine = {read=FMultiline, write=SetBoolean, index=3, default=0};
	__property short OffsetX = {read=FOffset.x, write=SetDimensions, index=2, default=0};
	__property short OffsetY = {read=FOffset.y, write=SetDimensions, index=3, default=0};
	__property TLMDTabOptions Options = {read=FOptions, write=SetOptions, default=47};
	__property bool OwnerDraw = {read=FOwnerDraw, write=SetBoolean, index=1, default=0};
	__property bool RaggedRight = {read=FRaggedRight, write=SetBoolean, index=4, default=1};
	__property bool ScrollOpposite = {read=FScrollOpposite, write=SetBoolean, index=2, default=0};
	__property bool ShowTabs = {read=FShowTabs, write=SetBoolean, index=0, default=1};
	__property Lmdgraph::TLMDAlignment TabAlignment = {read=FTabAlignment, write=SetTabAlignment, default=3};
	__property System::Uitypes::TColor TabBkColor = {read=FTabBKColor, write=SetTabBKColor, default=-16777201};
	__property short TabHeight = {read=FTabSize.y, write=SetDimensions, index=1, default=0};
	__property Vcl::Comctrls::TTabPosition TabPosition = {read=FTabPosition, write=SetTabPosition, default=0};
	__property TLMDTabStyle TabStyle = {read=FTabStyle, write=SetTabStyle, default=0};
	__property short TabWidth = {read=FTabSize.x, write=SetDimensions, index=0, default=0};
	__property TabStop = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property Vcl::Comctrls::TTabChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TLMDDrawTabEvent OnDrawTab = {read=FOnDrawTab, write=FOnDrawTab};
	__property Vcl::Comctrls::TTabGetImageEvent OnGetImageIndex = {read=FOnGetImageIndex, write=FOnGetImageIndex};
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomTabControl(HWND ParentWindow) : Lmdcustomsheetcontrol::TLMDCustomSheetControl(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TLMDTabGetColorEvent)(System::TObject* Sender, int TabIndex, System::Uitypes::TColor &iColor);

typedef void __fastcall (__closure *TLMDTabGetEnabledEvent)(System::TObject* Sender, int TabIndex, bool &iEnabled);

class PASCALIMPLEMENTATION TLMDTabControl : public TLMDCustomTabControl
{
	typedef TLMDCustomTabControl inherited;
	
private:
	int FTabIndex;
	System::Classes::TStrings* FTabs;
	Lmdbase::TLMDIndexEvent FOnCloseEvent;
	TLMDTabGetColorEvent FOnTabGetColor;
	TLMDTabGetEnabledEvent FOnTabGetEnabled;
	void __fastcall SetTabs(System::Classes::TStrings* const Value);
	
protected:
	virtual void __fastcall DoPageChange(Lmdcustomsheetcontrol::TLMDCustomSheet* NewPage, bool &Cancel);
	virtual void __fastcall DoPageClose(int PageIndex);
	virtual int __fastcall GetTabCount(void);
	virtual int __fastcall GetTabIndex(void);
	virtual System::Uitypes::TColor __fastcall GetTabColor(int Index);
	virtual bool __fastcall GetTabEnabled(int Index);
	virtual System::UnicodeString __fastcall GetTabText(int Index);
	virtual bool __fastcall GetVisible(int Index);
	virtual int __fastcall GetVisibleCount(void);
	virtual System::Classes::TComponent* __fastcall GetTabMenuPopupComponent(void);
	virtual void __fastcall SetTabIndex(const int Value);
	
public:
	__fastcall virtual TLMDTabControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDTabControl(void);
	virtual void __fastcall FirstPage(void);
	virtual bool __fastcall NextTab(void);
	virtual bool __fastcall PrevTab(void);
	virtual Lmdcustomsheetcontrol::TLMDSheetClass __fastcall GetSheetClass(void);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	__property DisplayRect;
	
__published:
	__property System::Classes::TStrings* Tabs = {read=FTabs, write=SetTabs};
	__property TabIndex = {default=-1};
	__property Lmdbase::TLMDIndexEvent OnCloseClick = {read=FOnCloseEvent, write=FOnCloseEvent};
	__property TLMDTabGetColorEvent OnGetColorEvent = {read=FOnTabGetColor, write=FOnTabGetColor};
	__property TLMDTabGetEnabledEvent OnGetEnabledEvent = {read=FOnTabGetEnabled, write=FOnTabGetEnabled};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTabControl(HWND ParentWindow) : TLMDCustomTabControl(ParentWindow) { }
	
};


typedef void __fastcall (__closure *TLMDPageChangeEvent)(System::TObject* Sender, TLMDTabSheet* NewPage, bool &Cancel);

typedef void __fastcall (__closure *TLMDPageCloseEvent)(System::TObject* Sender, TLMDTabSheet* Page, bool &Cancel);

class PASCALIMPLEMENTATION TLMDPageControl : public TLMDCustomTabControl
{
	typedef TLMDCustomTabControl inherited;
	
private:
	TLMDPageChangeEvent FOnPageChanging;
	TLMDPageCloseEvent FOnPageClose;
	bool FXPages;
	TLMDTabSheet* FDefaultPage;
	TLMDTabSheet* FNewDockSheet;
	TLMDTabSheet* FUndockingPage;
	bool FDockMouseDown;
	System::Types::TPoint FDockMousePos;
	void __fastcall SetActivePage(TLMDTabSheet* aValue);
	TLMDTabSheet* __fastcall GetPage(int Index);
	TLMDTabSheet* __fastcall GetActivePage(void);
	int __fastcall GetActivePageIndex(void);
	void __fastcall SetActivePageIndex(const int Value);
	
protected:
	virtual void __fastcall DoPageChange(Lmdcustomsheetcontrol::TLMDCustomSheet* NewPage, bool &Cancel);
	virtual void __fastcall DoPageClose(int PageIndex);
	virtual int __fastcall GetTabIndex(void);
	virtual int __fastcall GetTabCount(void);
	virtual System::Uitypes::TColor __fastcall GetTabColor(int Index);
	virtual System::UnicodeString __fastcall GetTabText(int Index);
	virtual bool __fastcall GetTabEnabled(int Index);
	virtual System::Classes::TComponent* __fastcall GetTabMenuPopupComponent(void);
	virtual void __fastcall SetTabIndex(const int Value);
	MESSAGE void __fastcall CMDockNotification(Vcl::Controls::TCMDockNotification &Message);
	HIDESBASE MESSAGE void __fastcall CMUnDockClient(Vcl::Controls::TCMUnDockClient &Message);
	HIDESBASE MESSAGE void __fastcall CMDockClient(Vcl::Controls::TCMDockClient &Message);
	DYNAMIC void __fastcall DockOver(Vcl::Controls::TDragDockObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	DYNAMIC void __fastcall DoAddDockClient(Vcl::Controls::TControl* Client, const System::Types::TRect &ARect);
	DYNAMIC void __fastcall DoRemoveDockClient(Vcl::Controls::TControl* Client);
	Vcl::Controls::TControl* __fastcall GetDockClientFromMousePos(const System::Types::TPoint &MousePos);
	TLMDTabSheet* __fastcall GetPageFromDockClient(Vcl::Controls::TControl* Client);
	DYNAMIC void __fastcall GetSiteInfo(Vcl::Controls::TControl* Client, System::Types::TRect &InfluenceRect, const System::Types::TPoint &MousePos, bool &CanDock);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall MouseExit(void);
	
public:
	__fastcall virtual TLMDPageControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDPageControl(void);
	virtual Lmdcustomsheetcontrol::TLMDSheetClass __fastcall GetSheetClass(void);
	virtual void __fastcall MovePage(int OldIndex, int NewIndex);
	virtual bool __fastcall NextTab(void);
	virtual bool __fastcall PrevTab(void);
	TLMDTabSheet* __fastcall PageAt(const int X, const int Y);
	virtual TLMDTabSheet* __fastcall AddPage(void);
	HIDESBASE virtual void __fastcall RemovePage(const int AIndex);
	__property int ActivePageIndex = {read=GetActivePageIndex, write=SetActivePageIndex, nodefault};
	__property int PageCount = {read=GetTabCount, nodefault};
	__property TLMDTabSheet* Pages[int Index] = {read=GetPage};
	
__published:
	__property DockSite = {default=0};
	__property DockOrientation;
	__property OnDblClick;
	__property OnDockOver;
	__property OnDockDrop;
	__property OnGetSiteInfo;
	__property TLMDTabSheet* DefaultPage = {read=FDefaultPage, write=FDefaultPage};
	__property TLMDTabSheet* ActivePage = {read=GetActivePage, write=SetActivePage};
	__property bool FreeClosedPages = {read=FXPages, write=FXPages, default=1};
	__property TLMDPageChangeEvent OnChangingEx = {read=FOnPageChanging, write=FOnPageChanging};
	__property TLMDPageCloseEvent OnPageClose = {read=FOnPageClose, write=FOnPageClose};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDPageControl(HWND ParentWindow) : TLMDCustomTabControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_LMDTABOptions (System::Set<Lmdpagecontrol__1, Lmdpagecontrol__1::toCloseButton, Lmdpagecontrol__1::toShowAccelChar>() << Lmdpagecontrol__1::toCloseButton << Lmdpagecontrol__1::toNoTabIfEmpty << Lmdpagecontrol__1::toShowBorder << Lmdpagecontrol__1::toShowFocusRect << Lmdpagecontrol__1::toShowAccelChar )
}	/* namespace Lmdpagecontrol */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDPAGECONTROL)
using namespace Lmdpagecontrol;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdpagecontrolHPP
