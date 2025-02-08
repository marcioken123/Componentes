// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElPgCtl.pas' rev: 31.00 (Windows)

#ifndef ElpgctlHPP
#define ElpgctlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <System.Math.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Consts.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Menus.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Types.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.UxTheme.hpp>
#include <ElSndMap.hpp>
#include <ElPanel.hpp>
#include <ElImgFrm.hpp>
#include <ElStyleMan.hpp>
#include <ElVCLUtils.hpp>
#include <ElXPThemedControl.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>
#include <LMDProcs.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDUnicode.hpp>
#include <LMDStrings.hpp>
#include <LMDObjectList.hpp>
#include <LMDUnicodeStrings.hpp>
#include <LMDGraph.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Elpgctl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTabSheet;
class DELPHICLASS TElPageControl;
class DELPHICLASS TElTab;
class DELPHICLASS TElBitmapTab;
class DELPHICLASS TElStdTab;
class DELPHICLASS TElBtnTab;
class DELPHICLASS TElFlatBtnTab;
class DELPHICLASS TElNetTab;
class DELPHICLASS TEl2DFlatTab;
class DELPHICLASS TElModernAngledTab;
class DELPHICLASS TElAngledTab;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElTabStyle : unsigned char { etsTabs, etsButtons, etsFlatButtons, etsNetTabs, etsFlatTabs, etsModernAngledTabs, etsAngledTabs, etsBitmapTabs };

enum DECLSPEC_DENUM TElTabPosition : unsigned char { etpTop, etpBottom, etpRight, etpLeft };

enum DECLSPEC_DENUM TElTabDrawState : unsigned char { edsBackground, edsEdges, edsContents };

enum DECLSPEC_DENUM TElPageScrollBtnState : unsigned char { pbsNone, pbsLeftBtnOver, pbsLeftBtnDown, pbsLeftBtnHeld, pbsRightBtnOver, pbsRightBtnDown, pbsRightBtnHeld };

enum DECLSPEC_DENUM TElCloseBtnMode : unsigned char { cbmNone, cbmActive, cbmAll };

typedef void __fastcall (__closure *TElMeasureTabEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, TElTabSheet* Page, System::Types::TSize &Size);

typedef void __fastcall (__closure *TElPaintTabEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, TElTabSheet* Page, const System::Types::TRect &Rect, TElTabDrawState DrawStep, bool &DefaultDrawing);

typedef void __fastcall (__closure *TElTabGetImageEvent)(System::TObject* Sender, int PageIndex, int &ImageIndex);

typedef void __fastcall (__closure *TElTabChangingEvent)(System::TObject* Sender, TElTabSheet* NewPage, bool &AllowChange);

typedef void __fastcall (__closure *TElDrawTabsBackgroundEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect);

class PASCALIMPLEMENTATION TElTabSheet : public Vcl::Controls::TCustomControl
{
	typedef Vcl::Controls::TCustomControl inherited;
	
protected:
	System::Classes::TNotifyEvent FOnShow;
	System::Classes::TNotifyEvent FOnHide;
	System::Uitypes::TColor FTabColor;
	TElPageControl* FPageControl;
	int FImageIndex;
	bool FTabVisible;
	Lmdtypes::TLMDString FCaption;
	bool FTabEnabled;
	Vcl::Menus::TPopupMenu* FTabMenu;
	Lmdtypes::TLMDString FHint;
	bool FUseTabColor;
	bool FUseFontForTabs;
	bool FCloseBtnEnabled;
	bool FTabShowing;
	System::Types::TRect FRect;
	bool FComplete;
	int FLine;
	bool FShown;
	bool FShowCloseButton;
	System::Types::TRect FCloseBtnRect;
	bool FCloseBtnDown;
	bool FCloseBtnOwer;
	Elstyleman::TElStyleMgrChangeLink* FStyleMgrLink;
	Elstyleman::TElStyleManager* FStyleManager;
	System::UnicodeString FStyleName;
	int FCreating;
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogChar(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Message);
	MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	void __fastcall SetTabShowing(bool Value);
	void __fastcall UpdateTabShowing(void);
	int __fastcall GetPageIndex(void);
	void __fastcall SetPageIndex(int Value);
	bool __fastcall GetUseXPThemes(void);
	void __fastcall SetShowCloseButton(bool Value);
	virtual void __fastcall TriggerShowEvent(void);
	virtual void __fastcall TriggerHideEvent(void);
	void __fastcall SetTabColor(System::Uitypes::TColor Value);
	void __fastcall SetPageControl(TElPageControl* Value);
	void __fastcall SetImageIndex(int Value);
	void __fastcall SetTabVisible(bool Value);
	void __fastcall SetCaption(Lmdtypes::TLMDString Value);
	Lmdtypes::TLMDString __fastcall GetCaption(void);
	virtual int __fastcall GetTabIndex(void);
	void __fastcall SetTabEnabled(bool Value);
	void __fastcall SetTabMenu(Vcl::Menus::TPopupMenu* Value);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall ReadState(System::Classes::TReader* Reader);
	virtual void __fastcall SetStyleManager(Elstyleman::TElStyleManager* Value);
	virtual void __fastcall SetStyleName(const System::UnicodeString Value);
	void __fastcall StyleMgrChange(System::TObject* Sender);
	void __fastcall UpdateStyle(void);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetUseTabColor(bool Value);
	bool __fastcall CloseButtonVisible(void);
	void __fastcall SetUseFontForTabs(bool Value);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	void __fastcall SetCloseBtnEnabled(bool Value);
	System::UnicodeString __fastcall GetInheritedHint(void);
	void __fastcall BeginCreate(void);
	void __fastcall EndCreate(void);
	__property bool TabShowing = {read=FTabShowing, nodefault};
	
public:
	__fastcall virtual TElTabSheet(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElTabSheet(void);
	virtual void __fastcall DestroyHandle(void);
	HIDESBASE void __fastcall SelectFirst(void);
	bool __fastcall IsThemed(void);
	__property int TabIndex = {read=GetTabIndex, nodefault};
	__property bool UseXPThemes = {read=GetUseXPThemes, nodefault};
	
__published:
	__property System::Uitypes::TColor TabColor = {read=FTabColor, write=SetTabColor, default=-16777201};
	__property System::Classes::TNotifyEvent OnShow = {read=FOnShow, write=FOnShow};
	__property System::Classes::TNotifyEvent OnHide = {read=FOnHide, write=FOnHide};
	__property TElPageControl* PageControl = {read=FPageControl, write=SetPageControl};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property bool TabVisible = {read=FTabVisible, write=SetTabVisible, default=1};
	__property Lmdtypes::TLMDString Caption = {read=GetCaption, write=SetCaption};
	__property int PageIndex = {read=GetPageIndex, write=SetPageIndex, stored=false, nodefault};
	__property bool TabEnabled = {read=FTabEnabled, write=SetTabEnabled, default=1};
	__property Vcl::Menus::TPopupMenu* TabMenu = {read=FTabMenu, write=SetTabMenu};
	__property bool UseTabColor = {read=FUseTabColor, write=SetUseTabColor, default=0};
	__property bool ShowCloseButton = {read=FShowCloseButton, write=SetShowCloseButton, default=0};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property bool UseFontForTabs = {read=FUseFontForTabs, write=SetUseFontForTabs, default=1};
	__property Elstyleman::TElStyleManager* StyleManager = {read=FStyleManager, write=SetStyleManager};
	__property System::UnicodeString StyleName = {read=FStyleName, write=SetStyleName};
	__property bool CloseBtnEnabled = {read=FCloseBtnEnabled, write=SetCloseBtnEnabled, default=1};
	__property Color = {default=-16777201};
	__property ParentColor = {default=0};
	__property Visible = {default=1};
	__property BorderWidth = {default=0};
	__property Constraints;
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentFont = {default=1};
	__property Left = {stored=false};
	__property Top = {stored=false};
	__property Height = {stored=false};
	__property Width = {stored=false};
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnResize;
	__property OnStartDrag;
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElTabSheet(HWND ParentWindow) : Vcl::Controls::TCustomControl(ParentWindow) { }
	
};


typedef System::TMetaClass* TElTabClass;

typedef System::TMetaClass* TElTabSheetClass;

typedef void __fastcall (__closure *TElPageCloseQueryEvent)(System::TObject* Sender, TElTabSheet* Page, bool &CanClose);

class PASCALIMPLEMENTATION TElPageControl : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
protected:
	int FTabMarginLeft;
	int FTabMarginRight;
	System::Types::TSize FSize;
	bool FDenyChanging;
	Vcl::Graphics::TBitmap* FBTab;
	Vcl::Graphics::TBitmap* FActiveTab;
	Vcl::Graphics::TBitmap* FCloseButton;
	TElTab* FTab;
	bool FRecalcTabPos;
	int FLines;
	System::Types::TRect FScrollLeftRect;
	System::Types::TRect FScrollRightRect;
	System::Types::TPoint FTabsPos;
	System::Types::TSize FTabsSize;
	HDC FMemDC;
	TElPageScrollBtnState FScrollBtnState;
	HWND FSaveCapture;
	Vcl::Extctrls::TTimer* FScrollTimer;
	int FTabIndex;
	System::Types::TPoint FHintCoords;
	Vcl::Extctrls::TTimer* FHintTimer;
	Vcl::Controls::THintWindow* FHintWnd;
	bool FNoDTAlert;
	TElTabSheet* FDragTab;
	int FDoStartDrag;
	System::Types::TPoint FDragPos;
	bool FDraggablePages;
	Elsndmap::TElSoundName FActivateSound;
	TElTabSheet* FActivePage;
	System::Uitypes::TColor FActiveTabColor;
	TElTabSheet* FDownTab;
	bool FDrawFocus;
	System::UnicodeString FDummyCaption;
	TElTabSheet* FFirstTab;
	bool FNoSetFirstTab;
	bool FFlat;
	System::Uitypes::TColor FGradientEndColor;
	System::Uitypes::TColor FGradientStartColor;
	int FGradientSteps;
	bool FHotTrack;
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	Vcl::Imglist::TCustomImageList* FImages;
	Vcl::Imglist::TChangeLink* FAImageChangeLink;
	Vcl::Imglist::TCustomImageList* FAlphaImages;
	Elimgfrm::TElImageForm* FImgForm;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	System::Uitypes::TColor FInactiveTabColor;
	int FMinTabHeight;
	int FMinTabWidth;
	bool FMultiLine;
	TElTabSheet* FNewDockSheet;
	System::Classes::TNotifyEvent FOnChange;
	TElTabGetImageEvent FOnGetImageIndex;
	TElMeasureTabEvent FOnMeasureTab;
	TElTabChangingEvent FOnChanging;
	Lmdobjectlist::TLMDObjectList* FPages;
	bool FRaggedRight;
	bool FScrollOpposite;
	bool FShowBorder;
	bool FShowImages;
	bool FShowTabs;
	Elsndmap::TElSoundMap* FSoundMap;
	TElTabStyle FStyle;
	unsigned FTabHeight;
	TElTabPosition FTabPosition;
	unsigned FTabWidth;
	TElTabSheet* FTrackTab;
	TElTabSheet* FUndockingPage;
	bool FDockMouseDown;
	System::Types::TPoint FDockMousePos;
	System::Uitypes::TColor FTabBkColor;
	TElPageCloseQueryEvent FOnClosePageQuery;
	Vcl::Graphics::TFont* FHotTrackFont;
	bool FShowTabHints;
	bool FSavvyMode;
	System::Uitypes::TColor FFlatTabBorderColor;
	System::Uitypes::TColor FTabBkColorNetStyle;
	bool FVerticalSideCaptions;
	Vcl::Graphics::TFont* FActiveTabFont;
	bool FUseActiveTabFont;
	System::Uitypes::TCursor FTabCursor;
	Lmdtypes::TLMDString FHint;
	TElPaintTabEvent FOnDrawTab;
	TElDrawTabsBackgroundEvent FOnDrawTabsBackground;
	TElTabSheet* FDefaultPage;
	TElCloseBtnMode FCloseBtnMode;
	bool FCenterTabCaptions;
	int FUpdateCount;
	int FUpdated;
	TElTabClass FTabClass;
	TElTabSheetClass FTabSheetClass;
	bool FShowAccelChar;
	void __fastcall BmpActiveTabChanged(System::TObject* Sender);
	void __fastcall BmpTabChanged(System::TObject* Sender);
	void __fastcall BmpCloseButtonChanged(System::TObject* Sender);
	void __fastcall SetShowAccelChar(bool Value);
	DYNAMIC void __fastcall Resize(void);
	void __fastcall SetTabMarginLeft(int Value);
	void __fastcall SetTabMarginRight(int Value);
	virtual Vcl::Themes::TThemedElement __fastcall GetThemedElement(void);
	virtual bool __fastcall CanChange(TElTabSheet* NewPage, bool FireOnChanging = true);
	bool __fastcall CanScrollLeft(void);
	virtual void __fastcall Change(void);
	virtual void __fastcall ChangeActivePage(TElTabSheet* Page);
	virtual void __fastcall DoDrawTabs(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &Rect, bool DoDraw, System::Types::TSize &Size);
	System::Types::TSize __fastcall MeasureSheet(Vcl::Graphics::TCanvas* ACanvas, TElTabSheet* Sheet);
	virtual void __fastcall DoThemeChanged(void);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	HIDESBASE MESSAGE void __fastcall WMSize(Winapi::Messages::TWMSize &Msg);
	HIDESBASE MESSAGE void __fastcall WMSetCursor(Winapi::Messages::TWMSetCursor &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMKeyDown(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDown(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMRButtonUp(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMMouseMove(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall ELThemeChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Message);
	HIDESBASE MESSAGE void __fastcall CMShowingChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall CMDialogKey(Winapi::Messages::TWMKey &Message);
	MESSAGE void __fastcall CMDockNotification(Vcl::Controls::TCMDockNotification &Message);
	HIDESBASE MESSAGE void __fastcall CMControlListChange(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMFocusChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMUnDockClient(Vcl::Controls::TCMUnDockClient &Message);
	HIDESBASE MESSAGE void __fastcall CMDockClient(Vcl::Controls::TCMDockClient &Message);
	HIDESBASE MESSAGE void __fastcall CMParentFontChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMSysColorChange(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMLButtonDblClk(Winapi::Messages::TWMMouse &Message);
	void __fastcall SelectFirstTab(void);
	virtual void __fastcall CreateHandle(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	DYNAMIC void __fastcall DockOver(Vcl::Controls::TDragDockObject* Source, int X, int Y, System::Uitypes::TDragState State, bool &Accept);
	DYNAMIC void __fastcall DoAddDockClient(Vcl::Controls::TControl* Client, const System::Types::TRect &ARect);
	DYNAMIC void __fastcall DoRemoveDockClient(Vcl::Controls::TControl* Client);
	int __fastcall GetActivePageIndex(void);
	Vcl::Controls::TControl* __fastcall GetDockClientFromMousePos(const System::Types::TPoint &MousePos);
	int __fastcall GetPageCount(void);
	TElTabSheet* __fastcall GetPageFromDockClient(Vcl::Controls::TControl* Client);
	TElTabSheet* __fastcall GetPages(int index);
	DYNAMIC void __fastcall GetSiteInfo(Vcl::Controls::TControl* Client, System::Types::TRect &InfluenceRect, const System::Types::TPoint &MousePos, bool &CanDock);
	Vcl::Graphics::TBitmap* __fastcall GetBitmapActiveTab(void);
	Vcl::Graphics::TBitmap* __fastcall GetBitmapCloseBtn(void);
	Vcl::Graphics::TBitmap* __fastcall GetBitmapTab(void);
	void __fastcall SetBitmapActiveTab(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetBitmapCloseBtn(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetBitmapTab(Vcl::Graphics::TBitmap* const Value);
	int __fastcall GetTabIndex(void);
	void __fastcall ImageFormChange(System::TObject* Sender);
	void __fastcall ImageListChange(System::TObject* Sender);
	virtual void __fastcall InsertPage(TElTabSheet* TabSheet);
	void __fastcall MakeTabVisible(TElTabSheet* ATabSheet);
	void __fastcall RebuildTabs(bool ResetFirstItem);
	virtual void __fastcall RemovePage(TElTabSheet* TabSheet);
	void __fastcall SetActivePage(TElTabSheet* Value);
	void __fastcall SetActivePageIndex(const int Value);
	void __fastcall SetActiveTabColor(System::Uitypes::TColor Value);
	DYNAMIC void __fastcall SetChildOrder(System::Classes::TComponent* Child, int Order);
	void __fastcall SetDrawFocus(bool Value);
	void __fastcall SetFirstTab(TElTabSheet* Value);
	TElTabSheet* __fastcall GetLastTab(void);
	void __fastcall SetFlat(bool newValue);
	void __fastcall SetHotTrack(bool newValue);
	void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetAlphaImages(Vcl::Imglist::TCustomImageList* newValue);
	void __fastcall SetInactiveTabColor(System::Uitypes::TColor Value);
	void __fastcall SetMinTabHeight(int Value);
	void __fastcall SetMinTabWidth(int Value);
	void __fastcall SetMultiLine(bool newValue);
	void __fastcall SetRaggedRight(const bool Value);
	void __fastcall SetScrollOpposite(const bool Value);
	void __fastcall SetShowBorder(bool Value);
	void __fastcall SetShowImages(bool newValue);
	void __fastcall SetShowTabs(bool Value);
	void __fastcall SetStyle(TElTabStyle newValue);
	void __fastcall SetTabHeight(unsigned newValue);
	void __fastcall SetTabIndex(const int Value);
	void __fastcall SetTabPosition(TElTabPosition newValue);
	void __fastcall SetTabWidth(unsigned newValue);
	virtual void __fastcall ShowControl(Vcl::Controls::TControl* AControl);
	virtual void __fastcall UpdateActivePage(void);
	void __fastcall UpdateTab(TElTabSheet* TabSheet);
	bool __fastcall CanScrollRight(void);
	void __fastcall SetHotTrackFont(Vcl::Graphics::TFont* Value);
	void __fastcall HotTrackFontChange(System::TObject* Sender);
	virtual void __fastcall Paint(void);
	void __fastcall SetScrollBtnState(TElPageScrollBtnState Value);
	void __fastcall SetTrackTab(TElTabSheet* Value);
	void __fastcall OnScrollTimer(System::TObject* Sender);
	void __fastcall SetTabBkColor(System::Uitypes::TColor Value);
	bool __fastcall HasVisibleTabs(void);
	bool __fastcall DoHitTest(int X, int Y, NativeInt &Res);
	void __fastcall UpdateMultilineOrder(void);
	virtual void __fastcall TriggerGetImageEvent(int PageIndex, int &ImageIndex);
	virtual void __fastcall TriggerMeasureTabEvent(Vcl::Graphics::TCanvas* Canvas, TElTabSheet* Page, System::Types::TSize &Size);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall IFMEffectiveSize(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall IFMCanPaintBkgnd(Winapi::Messages::TMessage &Message);
	MESSAGE void __fastcall PMRefreshActivePage(Winapi::Messages::TMessage &Message);
	virtual void __fastcall OnHintTimer(System::TObject* Sender);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	void __fastcall SetSavvyMode(bool Value);
	void __fastcall SetFlatTabBorderColor(System::Uitypes::TColor Value);
	void __fastcall SetTabBkColorNetStyle(System::Uitypes::TColor Value);
	void __fastcall SetVerticalSideCaptions(bool Value);
	void __fastcall SetDraggablePages(bool Value);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	void __fastcall SetActiveTabFont(Vcl::Graphics::TFont* Value);
	void __fastcall SetUseActiveTabFont(bool Value);
	void __fastcall ActiveTabFontChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall TriggerDrawTabEvent(Vcl::Graphics::TCanvas* Canvas, TElTabSheet* Page, const System::Types::TRect &Rect, TElTabDrawState DrawStep, bool &DefaultDrawing);
	void __fastcall SetCloseButtonMode(TElCloseBtnMode Value);
	virtual void __fastcall TriggerClosePageQueryEvent(TElTabSheet* Sheet, bool &CanClose);
	DYNAMIC void __fastcall ChangeScale(int M, int D)/* overload */;
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall SetCenterTabCaptions(bool Value);
	void __fastcall ReadDrawFocus(System::Classes::TReader* Reader);
	virtual void __fastcall AdjustClientRect(System::Types::TRect &Rect);
	void __fastcall IntMouseDown(int XPos, int YPos);
	void __fastcall IntLButtonUp(int XPos, int YPos);
	void __fastcall IntRButtonUp(int XPos, int YPos);
	void __fastcall IntMouseMove(int XPos, int YPos);
	void __fastcall IntKeyDown(System::Word &Key);
	HIDESBASE void __fastcall Realign(void);
	void __fastcall RecalcTabPositions(void);
	virtual System::Types::TSize __fastcall CalcTabAreaSize(void);
	void __fastcall DrawTabs(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &R, bool DoDraw, System::Types::TSize &Size);
	HFONT __fastcall GetRotatedFont(Vcl::Graphics::TCanvas* Canvas, int RotationAngle);
	void __fastcall ReorderPages(int MaxRows);
	void __fastcall SetTabClass(TElTabClass Value);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	HIDESBASE MESSAGE void __fastcall CMVisiblechanged(Winapi::Messages::TMessage &Message);
	__property TElPageScrollBtnState ScrollBtnState = {read=FScrollBtnState, write=SetScrollBtnState, nodefault};
	__property TElTabSheetClass TabSheetClass = {read=FTabSheetClass, write=FTabSheetClass};
	HIDESBASE bool __fastcall IsFontStored(void);
	
public:
	__fastcall virtual TElPageControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TElPageControl(void);
	TElTabSheet* __fastcall FindNextPage(TElTabSheet* CurPage, bool GoForward, bool CheckTabVisible, bool CheckTabEnabled);
	DYNAMIC void __fastcall GetChildren(System::Classes::TGetChildProc Proc, System::Classes::TComponent* Root);
	void __fastcall SelectNextPage(bool GoForward);
	virtual void __fastcall SetBounds(int ALeft, int ATop, int AWidth, int AHeight);
	TElTabSheet* __fastcall TabFromPoint(const System::Types::TPoint &Point);
	void __fastcall UpdateTabs(bool Immediate);
	virtual TElTabSheet* __fastcall NewPage(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
	__property int ActivePageIndex = {read=GetActivePageIndex, write=SetActivePageIndex, nodefault};
	__property TElTabSheet* FirstTab = {read=FFirstTab, write=SetFirstTab};
	__property TElTabSheet* LastTab = {read=GetLastTab};
	__property int PageCount = {read=GetPageCount, nodefault};
	__property TElTabSheet* Pages[int index] = {read=GetPages};
	__property TElTabSheet* TrackTab = {read=FTrackTab, write=SetTrackTab};
	__property System::Uitypes::TColor TabBkColorNetStyle = {read=FTabBkColorNetStyle, write=SetTabBkColorNetStyle, nodefault};
	__property TElTabClass TabClass = {read=FTabClass, write=SetTabClass};
	
__published:
	__property Elsndmap::TElSoundName ActivateSound = {read=FActivateSound, write=FActivateSound};
	__property System::Uitypes::TColor ActiveTabColor = {read=FActiveTabColor, write=SetActiveTabColor, default=-16777201};
	__property Color = {default=-16777201};
	__property bool ShowAccelChar = {read=FShowAccelChar, write=SetShowAccelChar, default=1};
	__property bool DrawFocusRect = {read=FDrawFocus, write=SetDrawFocus, default=0};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property bool HotTrack = {read=FHotTrack, write=SetHotTrack, default=1};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property Vcl::Imglist::TCustomImageList* AlphaForImages = {read=FAlphaImages, write=SetAlphaImages};
	__property System::Uitypes::TColor InactiveTabColor = {read=FInactiveTabColor, write=SetInactiveTabColor, default=-16777201};
	__property int MinTabHeight = {read=FMinTabHeight, write=SetMinTabHeight, default=40};
	__property int MinTabWidth = {read=FMinTabWidth, write=SetMinTabWidth, default=40};
	__property bool Multiline = {read=FMultiLine, write=SetMultiLine, default=0};
	__property TElTabChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property System::Classes::TNotifyEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TElTabGetImageEvent OnGetImageIndex = {read=FOnGetImageIndex, write=FOnGetImageIndex};
	__property TElMeasureTabEvent OnMeasureTab = {read=FOnMeasureTab, write=FOnMeasureTab};
	__property bool RaggedRight = {read=FRaggedRight, write=SetRaggedRight, default=0};
	__property bool ScrollOpposite = {read=FScrollOpposite, write=SetScrollOpposite, default=0};
	__property bool ShowBorder = {read=FShowBorder, write=SetShowBorder, default=1};
	__property bool ShowImages = {read=FShowImages, write=SetShowImages, default=1};
	__property bool ShowTabs = {read=FShowTabs, write=SetShowTabs, default=1};
	__property Elsndmap::TElSoundMap* SoundMap = {read=FSoundMap, write=FSoundMap};
	__property Vcl::Graphics::TBitmap* BitmapTab = {read=GetBitmapTab, write=SetBitmapTab};
	__property Vcl::Graphics::TBitmap* BitmapActiveTab = {read=GetBitmapActiveTab, write=SetBitmapActiveTab};
	__property Vcl::Graphics::TBitmap* BitmapCloseButton = {read=GetBitmapCloseBtn, write=SetBitmapCloseBtn};
	__property TElTabStyle Style = {read=FStyle, write=SetStyle, default=0};
	__property unsigned TabHeight = {read=FTabHeight, write=SetTabHeight, default=0};
	__property int TabIndex = {read=GetTabIndex, write=SetTabIndex, default=-1};
	__property TElTabPosition TabPosition = {read=FTabPosition, write=SetTabPosition, default=0};
	__property unsigned TabWidth = {read=FTabWidth, write=SetTabWidth, default=0};
	__property Vcl::Graphics::TFont* HotTrackFont = {read=FHotTrackFont, write=SetHotTrackFont, stored=IsFontStored};
	__property System::Uitypes::TColor TabBkColor = {read=FTabBkColor, write=SetTabBkColor, default=-16777201};
	__property TElTabSheet* ActivePage = {read=FActivePage, write=SetActivePage};
	__property bool ShowTabHints = {read=FShowTabHints, write=FShowTabHints, default=1};
	__property bool SavvyMode = {read=FSavvyMode, write=SetSavvyMode, default=0};
	__property System::Uitypes::TColor FlatTabBorderColor = {read=FFlatTabBorderColor, write=SetFlatTabBorderColor, default=-16777200};
	__property bool VerticalSideCaptions = {read=FVerticalSideCaptions, write=SetVerticalSideCaptions, default=1};
	__property bool DraggablePages = {read=FDraggablePages, write=SetDraggablePages, default=0};
	__property Vcl::Graphics::TFont* ActiveTabFont = {read=FActiveTabFont, write=SetActiveTabFont};
	__property bool UseActiveTabFont = {read=FUseActiveTabFont, write=SetUseActiveTabFont, default=0};
	__property System::Uitypes::TCursor TabCursor = {read=FTabCursor, write=FTabCursor, default=0};
	__property TElPaintTabEvent OnDrawTab = {read=FOnDrawTab, write=FOnDrawTab};
	__property TElTabSheet* DefaultPage = {read=FDefaultPage, write=FDefaultPage};
	__property TElCloseBtnMode CloseButtonMode = {read=FCloseBtnMode, write=SetCloseButtonMode, default=0};
	__property bool CenterTabCaptions = {read=FCenterTabCaptions, write=SetCenterTabCaptions, default=0};
	__property TElDrawTabsBackgroundEvent OnDrawTabsBackground = {read=FOnDrawTabsBackground, write=FOnDrawTabsBackground};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property int TabMarginLeft = {read=FTabMarginLeft, write=SetTabMarginLeft, default=0};
	__property int TabMarginRight = {read=FTabMarginRight, write=SetTabMarginRight, default=0};
	__property OnResize;
	__property TElPageCloseQueryEvent OnClosePageQuery = {read=FOnClosePageQuery, write=FOnClosePageQuery};
	__property Align = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Enabled = {default=1};
	__property Font;
	__property ParentColor = {default=0};
	__property ParentFont = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property ShowHint;
	__property Visible = {default=1};
	__property ParentThemeMode = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnDblClick;
	__property OnStartDrag;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnEnter;
	__property OnExit;
	__property OnContextPopup;
	__property Anchors = {default=3};
	__property Constraints;
	__property DockSite = {default=0};
	__property DockOrientation;
	__property DragKind = {default=0};
	__property OnStartDock;
	__property OnUnDock;
	__property OnDockDrop;
	__property OnDockOver;
	__property OnEndDock;
public:
	/* TWinControl.CreateParented */ inline __fastcall TElPageControl(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
	/* Hoisted overloads: */
	
protected:
	DYNAMIC inline void __fastcall  ChangeScale(int M, int D, bool isDpiChange){ Vcl::Controls::TWinControl::ChangeScale(M, D, isDpiChange); }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TElTab : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	TElPageControl* FOwner;
	void __fastcall Draw(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &R, TElTabSheet* TabSheet);
	TElTabPosition __fastcall GetTabPosition(void);
	
protected:
	virtual int __fastcall GetOuterMargin(void);
	virtual int __fastcall GetInnerMargin(void);
	virtual void __fastcall DrawTabContents(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall DrawSpace(Vcl::Graphics::TCanvas* Canvas, int &cx, int &cy, int mx, int my);
	virtual bool __fastcall CanDrawTab(bool ActiveDraw);
	virtual int __fastcall GetAscend(void);
	virtual void __fastcall AdjustDrawingSize(bool Active, System::Types::TRect &R);
	virtual void __fastcall AdjustTabSize(System::Types::TSize &Size);
	virtual void __fastcall AdjustFillSize(bool After, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall DrawTabLine(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	virtual void __fastcall FillSpace(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect);
	virtual void __fastcall FillTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TElTabSheet* TabSheet);
	virtual void __fastcall DrawButtons(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &LeftRect, const System::Types::TRect &RightRect, bool CSL, bool CSR);
	virtual int __fastcall GetRowMargin(void);
	virtual void __fastcall DrawTabEdges(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet) = 0 ;
	virtual void __fastcall DrawCloseButton(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall DrawThemedCloseButton(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual int __fastcall GetContentMargin(void);
	virtual void __fastcall FixupTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall AdjustFocusRect(System::Types::TRect &R);
	__property TElTabPosition TabPosition = {read=GetTabPosition, nodefault};
	
public:
	__fastcall virtual TElTab(TElPageControl* Owner);
	bool __fastcall IsThemed(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElTab(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElBitmapTab : public TElTab
{
	typedef TElTab inherited;
	
private:
	Vcl::Graphics::TBitmap* FTab;
	Vcl::Graphics::TBitmap* FActiveTab;
	Vcl::Graphics::TBitmap* FCloseButton;
	
protected:
	virtual int __fastcall GetInnerMargin(void);
	virtual int __fastcall GetContentMargin(void);
	virtual int __fastcall GetOuterMargin(void);
	virtual void __fastcall AdjustTabSize(System::Types::TSize &Size);
	virtual void __fastcall AdjustFillSize(bool After, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall FillTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TElTabSheet* TabSheet);
	virtual void __fastcall DrawTabEdges(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet);
	void __fastcall DrawTab(Vcl::Graphics::TCanvas* Canvas, bool Active, const System::Types::TRect &R);
	virtual void __fastcall DrawCloseButton(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall DrawTabLine(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	
public:
	__fastcall virtual TElBitmapTab(TElPageControl* Owner);
	__fastcall virtual ~TElBitmapTab(void);
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElStdTab : public TElTab
{
	typedef TElTab inherited;
	
protected:
	virtual int __fastcall GetOuterMargin(void);
	virtual bool __fastcall CanDrawTab(bool ActiveDraw);
	virtual int __fastcall GetAscend(void);
	virtual void __fastcall AdjustDrawingSize(bool Active, System::Types::TRect &R);
	virtual void __fastcall AdjustTabSize(System::Types::TSize &Size);
	virtual void __fastcall DrawTabLine(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	virtual void __fastcall AdjustFillSize(bool After, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall FillTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TElTabSheet* TabSheet);
	virtual void __fastcall DrawTabEdges(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet);
public:
	/* TElTab.Create */ inline __fastcall virtual TElStdTab(TElPageControl* Owner) : TElTab(Owner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElStdTab(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElBtnTab : public TElTab
{
	typedef TElTab inherited;
	
protected:
	virtual int __fastcall GetInnerMargin(void);
	virtual void __fastcall DrawSpace(Vcl::Graphics::TCanvas* Canvas, int &cx, int &cy, int mx, int my);
	virtual void __fastcall AdjustTabSize(System::Types::TSize &Size);
	virtual int __fastcall GetRowMargin(void);
	virtual void __fastcall FillTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TElTabSheet* TabSheet);
	virtual void __fastcall DrawTabEdges(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet);
public:
	/* TElTab.Create */ inline __fastcall virtual TElBtnTab(TElPageControl* Owner) : TElTab(Owner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElBtnTab(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElFlatBtnTab : public TElTab
{
	typedef TElTab inherited;
	
protected:
	virtual int __fastcall GetInnerMargin(void);
	virtual void __fastcall DrawSpace(Vcl::Graphics::TCanvas* Canvas, int &cx, int &cy, int mx, int my);
	virtual void __fastcall AdjustTabSize(System::Types::TSize &Size);
	virtual void __fastcall AdjustFillSize(bool After, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual int __fastcall GetRowMargin(void);
	virtual void __fastcall FillTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TElTabSheet* TabSheet);
	virtual void __fastcall DrawTabEdges(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet);
public:
	/* TElTab.Create */ inline __fastcall virtual TElFlatBtnTab(TElPageControl* Owner) : TElTab(Owner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElFlatBtnTab(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElNetTab : public TElTab
{
	typedef TElTab inherited;
	
protected:
	virtual void __fastcall AdjustTabSize(System::Types::TSize &Size);
	virtual int __fastcall GetInnerMargin(void);
	virtual void __fastcall DrawSpace(Vcl::Graphics::TCanvas* Canvas, int &cx, int &cy, int mx, int my);
	virtual bool __fastcall CanDrawTab(bool ActiveDraw);
	virtual void __fastcall AdjustDrawingSize(bool Active, System::Types::TRect &R);
	virtual int __fastcall GetOuterMargin(void);
	virtual void __fastcall DrawTabLine(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	virtual int __fastcall GetAscend(void);
	virtual void __fastcall FillSpace(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect);
	virtual void __fastcall AdjustFillSize(bool After, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall FillTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TElTabSheet* TabSheet);
	virtual void __fastcall DrawButtons(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &LeftRect, const System::Types::TRect &RightRect, bool CSL, bool CSR);
	virtual void __fastcall DrawTabEdges(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet);
public:
	/* TElTab.Create */ inline __fastcall virtual TElNetTab(TElPageControl* Owner) : TElTab(Owner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElNetTab(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TEl2DFlatTab : public TElTab
{
	typedef TElTab inherited;
	
protected:
	virtual void __fastcall AdjustDrawingSize(bool Active, System::Types::TRect &R);
	virtual void __fastcall AdjustFillSize(bool After, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall AdjustTabSize(System::Types::TSize &Size);
	virtual bool __fastcall CanDrawTab(bool ActiveDraw);
	virtual void __fastcall DrawTabLine(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	virtual int __fastcall GetAscend(void);
	virtual int __fastcall GetInnerMargin(void);
	virtual int __fastcall GetOuterMargin(void);
	virtual void __fastcall FillTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TElTabSheet* TabSheet);
	virtual void __fastcall DrawTabEdges(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet);
public:
	/* TElTab.Create */ inline __fastcall virtual TEl2DFlatTab(TElPageControl* Owner) : TElTab(Owner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TEl2DFlatTab(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElModernAngledTab : public TElTab
{
	typedef TElTab inherited;
	
private:
	int SaveDCState;
	
protected:
	virtual bool __fastcall CanDrawTab(bool ActiveDraw);
	virtual void __fastcall DrawButtons(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &LeftRect, const System::Types::TRect &RightRect, bool CSL, bool CSR);
	virtual void __fastcall DrawTabEdges(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall DrawTabLine(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	virtual void __fastcall AdjustFillSize(bool After, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall AdjustDrawingSize(bool Active, System::Types::TRect &R);
	virtual void __fastcall AdjustTabSize(System::Types::TSize &Size);
	virtual void __fastcall FillTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TElTabSheet* TabSheet);
	virtual int __fastcall GetAscend(void);
	virtual int __fastcall GetInnerMargin(void);
	virtual int __fastcall GetOuterMargin(void);
	virtual int __fastcall GetContentMargin(void);
	void __fastcall CreateTabPoints(const System::Types::TRect &R, System::Types::TPoint *APoints, const int APoints_High);
	virtual void __fastcall FixupTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall AdjustFocusRect(System::Types::TRect &R);
public:
	/* TElTab.Create */ inline __fastcall virtual TElModernAngledTab(TElPageControl* Owner) : TElTab(Owner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElModernAngledTab(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElAngledTab : public TElTab
{
	typedef TElTab inherited;
	
private:
	int SaveDCState;
	
protected:
	virtual bool __fastcall CanDrawTab(bool ActiveDraw);
	virtual void __fastcall DrawTabEdges(Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall DrawTabLine(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R);
	virtual void __fastcall AdjustFillSize(bool After, System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall AdjustDrawingSize(bool Active, System::Types::TRect &R);
	virtual void __fastcall AdjustTabSize(System::Types::TSize &Size);
	virtual void __fastcall FillTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect, TElTabSheet* TabSheet);
	virtual int __fastcall GetAscend(void);
	virtual int __fastcall GetInnerMargin(void);
	virtual int __fastcall GetOuterMargin(void);
	virtual int __fastcall GetContentMargin(void);
	void __fastcall CreateTabPoints(const System::Types::TRect &R, System::Types::TPoint *APoints, const int APoints_High);
	virtual void __fastcall FixupTab(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, TElTabSheet* TabSheet);
	virtual void __fastcall AdjustFocusRect(System::Types::TRect &R);
public:
	/* TElTab.Create */ inline __fastcall virtual TElAngledTab(TElPageControl* Owner) : TElTab(Owner) { }
	
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TElAngledTab(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Word PM_REFRESHACTIVEPAGE = System::Word(0x210a);
extern DELPHI_PACKAGE void __fastcall DrawXPTabEdges(Lmdclass::TLMDThemeMode ATabTheme, const Vcl::Themes::TThemedElementDetails &ADetails, Vcl::Graphics::TCanvas* Canvas, System::Types::TRect &R, TElTabPosition ATabPosition);
}	/* namespace Elpgctl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELPGCTL)
using namespace Elpgctl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElpgctlHPP
