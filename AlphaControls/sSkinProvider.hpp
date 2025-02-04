// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sSkinProvider.pas' rev: 27.00 (Windows)

#ifndef SskinproviderHPP
#define SskinproviderHPP

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
#include <Vcl.Forms.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <acSBUtils.hpp>	// Pascal unit
#include <sSkinMenus.hpp>	// Pascal unit
#include <sSkinManager.hpp>	// Pascal unit
#include <acGlow.hpp>	// Pascal unit
#include <acThdTimer.hpp>	// Pascal unit
#include <acTitleBar.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sskinprovider
{
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TacLabelColor
{
public:
	Vcl::Controls::TControl* Control;
	System::Uitypes::TColor Color;
	bool ParentFont;
};


class DELPHICLASS TacGraphItem;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacGraphItem : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	Vcl::Controls::TControl* Ctrl;
	Scommondata::TsCommonData* SkinData;
	System::TObject* Adapter;
	Acsbutils::TacSpeedButtonHandler* Handler;
	__fastcall virtual TacGraphItem(void);
	__fastcall virtual ~TacGraphItem(void);
	void __fastcall DoHook(Vcl::Controls::TControl* Control);
};

#pragma pack(pop)

class DELPHICLASS TacAdapterItem;
class DELPHICLASS TacCtrlAdapter;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacAdapterItem : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	int COC;
	
public:
	Vcl::Controls::TWinControl* WinCtrl;
	TacCtrlAdapter* Adapter;
	Acsbutils::TacMainWnd* ScrollWnd;
	__fastcall virtual TacAdapterItem(TacCtrlAdapter* AAdapter, Vcl::Controls::TWinControl* ACtrl);
	__fastcall virtual ~TacAdapterItem(void);
	void __fastcall DoHook(Vcl::Controls::TWinControl* Control, const Acsbutils::TacSkinParams &SkinParams);
};

#pragma pack(pop)

typedef Acsbutils::TacSkinParams *PacSkinParams;

typedef void __fastcall (__closure *TacNCHitTest)(Winapi::Messages::TWMNCHitTest &Msg);

enum DECLSPEC_DENUM TacAnimEvent : unsigned char { aeShowing, aeHiding, aeSkinChanging };

enum DECLSPEC_DENUM TsGripMode : unsigned char { gmNone, gmRightBottom };

enum DECLSPEC_DENUM TsResizeMode : unsigned char { rmStandard, rmBorder };

typedef void __fastcall (__closure *TacAfterAnimation)(TacAnimEvent AnimType);

typedef void __fastcall (__closure *TAddItemEvent)(System::Classes::TComponent* Item, bool &CanBeAdded, System::UnicodeString &SkinSection);

typedef void __fastcall (__closure *TAddItemExEvent)(System::Classes::TComponent* Item, bool &CanBeAdded, PacSkinParams SkinParams);

class DELPHICLASS TacSBAnimation;
struct DECLSPEC_DRECORD TsCaptionButton
{
public:
	int State;
	int ImageIndex;
	System::Types::TRect Rect;
	bool HaveAlignment;
	int GlowID;
	TacSBAnimation* Timer;
	unsigned HitCode;
};


typedef TsCaptionButton *PsCaptionButton;

class DELPHICLASS TacAddedTitle;
class DELPHICLASS TsSkinProvider;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacAddedTitle : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FShowMainCaption;
	void __fastcall SetShowMainCaption(const bool Value);
	
protected:
	System::UnicodeString FText;
	Vcl::Graphics::TFont* FFont;
	void __fastcall SetText(const System::UnicodeString Value);
	void __fastcall SetFont(Vcl::Graphics::TFont* const Value);
	void __fastcall Repaint(void);
	
public:
	TsSkinProvider* FOwner;
	__fastcall virtual TacAddedTitle(void);
	__fastcall virtual ~TacAddedTitle(void);
	
__published:
	__property Vcl::Graphics::TFont* Font = {read=FFont, write=SetFont};
	__property System::UnicodeString Text = {read=FText, write=SetText};
	__property bool ShowMainCaption = {read=FShowMainCaption, write=SetShowMainCaption, default=1};
};

#pragma pack(pop)

class DELPHICLASS TsTitleButton;
class PASCALIMPLEMENTATION TsTitleButton : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	bool FUseSkinData;
	System::UnicodeString FName;
	Vcl::Graphics::TBitmap* FGlyph;
	Vcl::Controls::TMouseEvent FOnMouseUp;
	Vcl::Controls::TMouseEvent FOnMouseDown;
	bool FEnabled;
	System::UnicodeString FHint;
	bool FVisible;
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetName(const System::UnicodeString Value);
	void __fastcall MouseDown(int BtnIndex, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall MouseUp(int BtnIndex, System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	void __fastcall SetVisible(const bool Value);
	void __fastcall OnGlyphChange(System::TObject* Sender);
	
public:
	Vcl::Controls::THintWindow* HintWnd;
	TsCaptionButton Data;
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	__fastcall virtual TsTitleButton(System::Classes::TCollection* Collection);
	__fastcall virtual ~TsTitleButton(void);
	virtual System::UnicodeString __fastcall GetDisplayName(void);
	
__published:
	__property bool Enabled = {read=FEnabled, write=FEnabled, default=1};
	__property Vcl::Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property System::UnicodeString Hint = {read=FHint, write=FHint};
	__property System::UnicodeString Name = {read=FName, write=SetName};
	__property bool UseSkinData = {read=FUseSkinData, write=FUseSkinData, default=1};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
	__property Vcl::Controls::TMouseEvent OnMouseDown = {read=FOnMouseDown, write=FOnMouseDown};
	__property Vcl::Controls::TMouseEvent OnMouseUp = {read=FOnMouseUp, write=FOnMouseUp};
};


class DELPHICLASS TsTitleButtons;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsTitleButtons : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TsTitleButton* operator[](int Index) { return Items[Index]; }
	
private:
	TsSkinProvider* FOwner;
	HIDESBASE TsTitleButton* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TsTitleButton* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	virtual void __fastcall Update(System::Classes::TCollectionItem* Item);
	
public:
	__fastcall TsTitleButtons(TsSkinProvider* AOwner);
	__fastcall virtual ~TsTitleButtons(void);
	__property TsTitleButton* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

class DELPHICLASS TsTitleIcon;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsTitleIcon : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	TsSkinProvider* FOwner;
	Vcl::Graphics::TBitmap* FGlyph;
	int FHeight;
	int FWidth;
	bool FVisible;
	void __fastcall SetGlyph(Vcl::Graphics::TBitmap* const Value);
	void __fastcall SetHeight(const int Value);
	void __fastcall SetWidth(const int Value);
	void __fastcall SetVisible(const bool Value);
	
public:
	__fastcall TsTitleIcon(TsSkinProvider* AOwner);
	__fastcall virtual ~TsTitleIcon(void);
	
__published:
	__property Vcl::Graphics::TBitmap* Glyph = {read=FGlyph, write=SetGlyph};
	__property int Height = {read=FHeight, write=SetHeight, default=0};
	__property int Width = {read=FWidth, write=SetWidth, default=0};
	__property bool Visible = {read=FVisible, write=SetVisible, default=1};
};

#pragma pack(pop)

enum DECLSPEC_DENUM TacMenuItemPos : unsigned char { ipTop, ipBottom, ipBeforeClose };

class DELPHICLASS TacSysSubMenu;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TacSysSubMenu : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	System::UnicodeString FCaption;
	TacMenuItemPos FPosition;
	Vcl::Menus::TPopupMenu* FPopupMenu;
	
public:
	__fastcall TacSysSubMenu(TsSkinProvider* AOwner);
	
__published:
	__property System::UnicodeString Caption = {read=FCaption, write=FCaption};
	__property Vcl::Menus::TPopupMenu* PopupMenu = {read=FPopupMenu, write=FPopupMenu};
	__property TacMenuItemPos Position = {read=FPosition, write=FPosition, default=2};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TacSysSubMenu(void) { }
	
};

#pragma pack(pop)

typedef System::DynamicArray<TacLabelColor> TacLabelsColors;

class DELPHICLASS TsSystemMenu;
class DELPHICLASS TacBorderForm;
class PASCALIMPLEMENTATION TsSkinProvider : public System::Classes::TComponent
{
	typedef System::Classes::TComponent inherited;
	
private:
	bool RgnChanged;
	int CurrentHT;
	Vcl::Graphics::TBitmap* TempBmp;
	bool FMakeSkinMenu;
	bool FShowAppIcon;
	bool ControlsChanged;
	System::Classes::TAlignment FCaptionAlignment;
	TsTitleIcon* FTitleIcon;
	TsTitleButtons* FTitleButtons;
	TsGripMode FGripMode;
	TsResizeMode FResizeMode;
	bool FirstInitialized;
	bool FScreenSnap;
	int FSnapBuffer;
	bool FUseGlobalColor;
	System::UnicodeString FTitleSkin;
	System::UnicodeString FMenuLineSkin;
	int UserBtnIndex;
	TAddItemEvent FOnSkinItem;
	bool FDrawNonClientArea;
	bool FAllowExtBorders;
	TacNCHitTest FOnExtHitTest;
	TacAfterAnimation FOnAfterAnimation;
	TacAddedTitle* FAddedTitle;
	bool FAllowBlendOnMoving;
	bool FAllowAnimation;
	System::Types::TRect FIconRect;
	bool FDrawClientArea;
	TacSysSubMenu* FSysSubMenu;
	TAddItemExEvent FOnSkinItemEx;
	Vcl::Extctrls::TTimer* FHintTimer;
	System::Types::TRect FHintRect;
	void __fastcall OnHintTimer(System::TObject* Sender);
	void __fastcall StartHintTimer(Actitlebar::TacTitleBarItem* TitleItem);
	void __fastcall OnChildMnuClick(System::TObject* Sender);
	void __fastcall SetCaptionAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetShowAppIcon(const bool Value);
	void __fastcall SetTitleButtons(TsTitleButtons* const Value);
	void __fastcall SetUseGlobalColor(const bool Value);
	int __fastcall GetLinesCount(void);
	void __fastcall SetTitleSkin(const System::UnicodeString Value);
	void __fastcall SetMenuLineSkin(const System::UnicodeString Value);
	void __fastcall SetDrawNonClientArea(const bool Value);
	void __fastcall SetAllowExtBorders(const bool Value);
	void __fastcall SetTitleBar(Actitlebar::TsTitleBar* const Value);
	bool __fastcall HaveSysMenu(void);
	
protected:
	Sconst::TAOR ArOR;
	Scommondata::TsScrollWndData* FCommonData;
	Actitlebar::TsTitleBar* FTitleBar;
	int FHeaderHeight;
	int LockCount;
	bool ClearButtons;
	bool MenusInitialized;
	bool FMenuOwnerDraw;
	TacLabelsColors SavedLabelColors;
	Vcl::Graphics::TBitmap* FGlow1;
	Vcl::Graphics::TBitmap* FGlow2;
	Vcl::Forms::TForm* CoverForm;
	Vcl::Graphics::TBitmap* CoverBmp;
	System::Types::TRect NormalBounds;
	TsCaptionButton ButtonMin;
	TsCaptionButton ButtonMax;
	TsCaptionButton ButtonClose;
	TsCaptionButton ButtonHelp;
	TsCaptionButton MDIMin;
	TsCaptionButton MDIMax;
	TsCaptionButton MDIClose;
	System::Types::TRect LastClientRect;
	bool FSysExHeight;
	int FTitleSkinIndex;
	int VCenter;
	int FCaptionSkinIndex;
	Acthdtimer::TacThreadedTimer* FormTimer;
	virtual void __fastcall AssignTo(System::Classes::TPersistent* Dest);
	void __fastcall AdapterRemove(void);
	void __fastcall AdapterCreate(void);
	void __fastcall SendToAdapter(const Winapi::Messages::TMessage &Message);
	bool __fastcall PaintAll(void);
	void __fastcall PaintForm(HDC DC, bool SendUpdated = true);
	void __fastcall PaintCaption(HDC DC);
	void __fastcall PaintTitleContent(void);
	void __fastcall PaintTitleItem(Actitlebar::TacTitleBarItem* Item, const System::Types::TRect &R, Vcl::Graphics::TBitmap* Bmp, bool NoAlpha = true);
	void __fastcall RepaintButton(int i);
	void __fastcall RepaintMenuItem(Vcl::Menus::TMenuItem* mi, const System::Types::TRect &R, Winapi::Windows::TOwnerDrawState State);
	void __fastcall SaveBGForBtns(bool Full = false);
	void __fastcall RestoreBtnsBG(void);
	void __fastcall OurPaintHandler(const Winapi::Messages::TWMPaint &Msg);
	void __fastcall ProcessMessage(unsigned Msg, NativeUInt WPar = (NativeUInt)(0x0), NativeInt LPar = (NativeInt)(0x0));
	void __fastcall AC_ASEMSG(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMCopyData(Winapi::Messages::TWMCopyData &Message);
	bool __fastcall AC_SMAlphaCmd_Common(Winapi::Messages::TMessage &Message);
	bool __fastcall AC_SMAlphaCmd_Skinned(Winapi::Messages::TMessage &Message);
	bool __fastcall AC_SMAlphaCmd_Unskinned(Winapi::Messages::TMessage &Message);
	void __fastcall AC_CMEnabledChanged(Winapi::Messages::TMessage &Message);
	void __fastcall AC_CMFloat(Winapi::Messages::TMessage &Message);
	void __fastcall AC_CMMenuChanged(Winapi::Messages::TMessage &Message);
	void __fastcall AC_CMMouseEnter(Winapi::Messages::TMessage &Message);
	void __fastcall AC_CMRecreateWnd(Winapi::Messages::TMessage &Message);
	void __fastcall AC_CMShowingChanged(Winapi::Messages::TMessage &Message);
	void __fastcall AC_CMMouseWheel(Vcl::Controls::TCMMouseWheel &Message);
	void __fastcall AC_WMActivate(Winapi::Messages::TWMActivate &Message);
	void __fastcall AC_WMActivateApp(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMChildActivate(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMContextMenu(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMControlListChange(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMCreate(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMEnterMenuLoop(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMEraseBkGnd(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMEraseBkGndHandler(HDC aDC);
	void __fastcall AC_WMExitMenuLoop(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMExitSizeMove(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMGetMinMaxInfo(Winapi::Messages::TWMGetMinMaxInfo &Message);
	void __fastcall AC_WMInitMenuPopup(Winapi::Messages::TWMInitMenuPopup &Message);
	void __fastcall AC_WMLButtonUp(Winapi::Messages::TWMNCHitMessage &Message);
	void __fastcall AC_WMMDIDestroy(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMMeasureItem(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMMove(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMMouseLeave(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMMouseMove(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMNCActivate(Winapi::Messages::TWMNCActivate &Message);
	void __fastcall AC_WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	void __fastcall AC_WMNCCreate(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMNCDestroy(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMNCHitTest(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMNCLButtonDblClick(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMNCLButtonDown(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMNCMouseMove(Winapi::Messages::TWMNCHitMessage &Message);
	void __fastcall AC_WMNCPaint(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMNCPaintHandler(void);
	void __fastcall AC_WMNCRButtonDown(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMNCRButtonUp(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMNotify(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMPaint(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMParentNotify(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMPrint(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMQueryEndSession(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMSetIcon(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMSetRedraw(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMSetText(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMSettingChange(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMSize(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMSizing(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMShowWindow(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMStyleChanged(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMSysColorChange(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMSysCommand(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMVisibleChanged(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMWindowPosChanged(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMWindowPosChanging(Winapi::Messages::TWMWindowPosMsg &Message);
	void __fastcall AC_WMWindowPosChanged_Unskinned(Winapi::Messages::TWMWindowPosMsg &Message);
	void __fastcall AC_CMVisibleChanged_Unskinned(Winapi::Messages::TMessage &Message);
	void __fastcall AC_WMClose(Winapi::Messages::TMessage &Message);
	int __fastcall HTProcess(Winapi::Messages::TWMNCHitTest &Message);
	System::Types::TPoint __fastcall CursorToPoint(const int x, const int y);
	bool __fastcall MDIButtonsNeeded(void);
	System::Types::TPoint __fastcall RBGripPoint(const int ImgIndex);
	System::Types::TPoint __fastcall FormLeftTop(void);
	int __fastcall SysButtonsCount(void);
	int __fastcall SmallButtonWidth(void);
	int __fastcall ButtonHeight(void);
	int __fastcall SmallButtonHeight(void);
	int __fastcall SysButtonWidth(const TsCaptionButton &Btn);
	int __fastcall TitleBtnsWidth(void);
	int __fastcall UserButtonWidth(TsTitleButton* const Btn);
	int __fastcall BarWidth(const int i);
	void __fastcall KillAnimations(void);
	void __fastcall UpdateIconsIndexes(void);
	void __fastcall StartMove(int X, int Y);
	void __fastcall StopMove(int X, int Y);
	void __fastcall DrawFormBorder(int X, int Y);
	void __fastcall SetHotHT(const int i, const bool Repaint = true);
	void __fastcall SetPressedHT(const int i);
	int __fastcall ActualTitleHeight(void);
	virtual int __fastcall GetTopCoord(void);
	bool __fastcall FormChanged(void);
	bool __fastcall IconVisible(void);
	System::UnicodeString __fastcall TitleSkinSection(void);
	int __fastcall TitleSkinIndex(void);
	void __fastcall CheckSysMenu(const bool Skinned);
	void __fastcall TryInitMenu(void);
	void __fastcall InitExBorders(const bool Active);
	
public:
	bool RTInit;
	bool RTEmpty;
	bool InAero;
	bool InMenu;
	bool FInAnimation;
	Vcl::Forms::TShowAction ShowAction;
	bool SkipAnimation;
	bool fAnimating;
	Acsbutils::TacScrollWnd* ListSW;
	TacCtrlAdapter* Adapter;
	unsigned FormState;
	bool RgnChanging;
	bool BigButtons;
	bool MenuChanged;
	System::Classes::TWndMethod OldWndProc;
	System::TObject* MDIForm;
	bool FormActive;
	Vcl::Graphics::TBitmap* MenuLineBmp;
	Vcl::Forms::TForm* Form;
	int FLinesCount;
	TsSystemMenu* SystemMenu;
	Vcl::Forms::TForm* CaptForm;
	System::Classes::TWndMethod OldCaptFormProc;
	TacBorderForm* BorderForm;
	void __fastcall CalcItems(void);
	__fastcall virtual TsSkinProvider(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsSkinProvider(void);
	__fastcall TsSkinProvider(System::Classes::TComponent* AOwner, bool InitRT);
	void __fastcall DropSysMenu(int x, int y);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	void __fastcall LoadInit(void);
	void __fastcall InitLabel(Vcl::Controls::TControl* const Control, const bool Skinned);
	void __fastcall PrepareForm(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	int __fastcall OffsetX(void);
	int __fastcall OffsetY(void);
	System::Types::TRect __fastcall ShadowSize(void);
	void __fastcall NewWndProc(Winapi::Messages::TMessage &Message);
	void __fastcall HookMDI(bool Active = true);
	int __fastcall HeaderHeight(void);
	int __fastcall BorderHeight(bool CheckSkin = true);
	int __fastcall BorderWidth(bool CheckSkin = true);
	int __fastcall CaptionHeight(bool CheckSkin = true);
	int __fastcall CaptionWidth(void);
	int __fastcall MenuHeight(void);
	bool __fastcall MenuPresent(void);
	System::Uitypes::TColor __fastcall FormColor(void);
	void __fastcall MdiIcoFormPaint(System::TObject* Sender);
	void __fastcall CaptFormPaint(System::TObject* Sender);
	void __fastcall NewCaptFormProc(Winapi::Messages::TMessage &Message);
	void __fastcall UpdateTitleBar(void);
	bool __fastcall UpdateMenu(void);
	void __fastcall InitMenuItems(bool A);
	void __fastcall RepaintMenu(void);
	__property System::Types::TRect IconRect = {read=FIconRect};
	__property int LinesCount = {read=GetLinesCount, nodefault};
	
__published:
	__property TacAddedTitle* AddedTitle = {read=FAddedTitle, write=FAddedTitle};
	__property bool AllowAnimation = {read=FAllowAnimation, write=FAllowAnimation, default=1};
	__property bool AllowExtBorders = {read=FAllowExtBorders, write=SetAllowExtBorders, default=1};
	__property bool AllowBlendOnMoving = {read=FAllowBlendOnMoving, write=FAllowBlendOnMoving, default=1};
	__property System::Classes::TAlignment CaptionAlignment = {read=FCaptionAlignment, write=SetCaptionAlignment, default=0};
	__property bool DrawNonClientArea = {read=FDrawNonClientArea, write=SetDrawNonClientArea, default=1};
	__property bool DrawClientArea = {read=FDrawClientArea, write=FDrawClientArea, default=1};
	__property Scommondata::TsScrollWndData* SkinData = {read=FCommonData, write=FCommonData};
	__property TsGripMode GripMode = {read=FGripMode, write=FGripMode, default=0};
	__property bool MakeSkinMenu = {read=FMakeSkinMenu, write=FMakeSkinMenu, default=0};
	__property System::UnicodeString MenuLineSkin = {read=FMenuLineSkin, write=SetMenuLineSkin};
	__property TsResizeMode ResizeMode = {read=FResizeMode, write=FResizeMode, default=0};
	__property bool ScreenSnap = {read=FScreenSnap, write=FScreenSnap, default=0};
	__property int SnapBuffer = {read=FSnapBuffer, write=FSnapBuffer, default=10};
	__property bool ShowAppIcon = {read=FShowAppIcon, write=SetShowAppIcon, default=1};
	__property TacSysSubMenu* SysSubMenu = {read=FSysSubMenu, write=FSysSubMenu};
	__property Actitlebar::TsTitleBar* TitleBar = {read=FTitleBar, write=SetTitleBar};
	__property TsTitleButtons* TitleButtons = {read=FTitleButtons, write=SetTitleButtons};
	__property TsTitleIcon* TitleIcon = {read=FTitleIcon, write=FTitleIcon};
	__property System::UnicodeString TitleSkin = {read=FTitleSkin, write=SetTitleSkin};
	__property bool UseGlobalColor = {read=FUseGlobalColor, write=SetUseGlobalColor, default=1};
	__property TacAfterAnimation OnAfterAnimation = {read=FOnAfterAnimation, write=FOnAfterAnimation};
	__property TacNCHitTest OnExtHitTest = {read=FOnExtHitTest, write=FOnExtHitTest};
	__property TAddItemEvent OnSkinItem = {read=FOnSkinItem, write=FOnSkinItem};
	__property TAddItemExEvent OnSkinItemEx = {read=FOnSkinItemEx, write=FOnSkinItemEx};
};


class PASCALIMPLEMENTATION TacSBAnimation : public Vcl::Extctrls::TTimer
{
	typedef Vcl::Extctrls::TTimer inherited;
	
public:
	TacBorderForm* BorderForm;
	Scommondata::TsCommonData* SkinData;
	HWND FormHandle;
	TsCaptionButton *PBtnData;
	int CurrentLevel;
	int CurrentState;
	bool Up;
	int MaxIterations;
	Vcl::Forms::TForm* AForm;
	Vcl::Graphics::TBitmap* ABmp;
	__fastcall virtual TacSBAnimation(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TacSBAnimation(void);
	System::Types::TRect __fastcall GetFormBounds(void);
	int __fastcall Offset(void);
	int __fastcall Step(void);
	void __fastcall MakeForm(void);
	void __fastcall UpdateForm(const int Blend);
	void __fastcall StartAnimation(int NewState, bool ToUp);
	void __fastcall ChangeState(int NewState, bool ToUp);
	void __fastcall MakeImg(void);
	void __fastcall CheckMouseLeave(void);
	void __fastcall OnAnimTimer(System::TObject* Sender);
};


class PASCALIMPLEMENTATION TacBorderForm : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
protected:
	System::TObject* FOwner;
	TsSkinProvider* sp;
	System::Types::TPoint LastTopLeft;
	
public:
	bool acInMouseMsg;
	Vcl::Forms::TForm* AForm;
	System::Classes::TWndMethod OldBorderProc;
	bool ExBorderShowing;
	Vcl::Graphics::TBitmap* ShadowTemplate;
	NativeUInt ParentHandle;
	Scommondata::TsCommonData* SkinData;
	bool ResetRgn;
	__fastcall TacBorderForm(System::TObject* AOwner);
	void __fastcall CreateNewForm(void);
	__fastcall virtual ~TacBorderForm(void);
	void __fastcall KillAnimations(void);
	int __fastcall OffsetX(void);
	int __fastcall OffsetY(void);
	TsCaptionButton __fastcall ButtonMin(void);
	TsCaptionButton __fastcall ButtonMax(void);
	TsCaptionButton __fastcall ButtonClose(void);
	TsCaptionButton __fastcall ButtonHelp(void);
	HWND __fastcall OwnerHandle(void);
	System::Types::TRect __fastcall ShadowSize(void);
	int __fastcall CaptionHeight(bool CheckSkin = true);
	int __fastcall MenuHeight(void);
	System::Types::TRect __fastcall IconRect(void);
	void __fastcall SetHotHT(const int i, bool Repaint = true);
	void __fastcall PaintAll(void);
	HRGN __fastcall MakeRgn(int NewWidth = 0x0, int NewHeight = 0x0);
	unsigned __fastcall FormState(void);
	void __fastcall UpdateRgn(void);
	bool __fastcall MouseAboveTheShadow(const Winapi::Messages::TWMMouse &Message);
	void __fastcall BorderProc(Winapi::Messages::TMessage &Message);
	void __fastcall UpdateExBordersPos(bool Redraw = true, System::Byte Blend = (System::Byte)(0xff));
	int __fastcall Ex_WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	bool __fastcall Ex_WMSetCursor(Winapi::Messages::TWMSetCursor &Message);
};


class DELPHICLASS TsCustomSysMenu;
class PASCALIMPLEMENTATION TsCustomSysMenu : public Vcl::Menus::TPopupMenu
{
	typedef Vcl::Menus::TPopupMenu inherited;
	
__published:
	virtual bool __fastcall VisibleClose(void) = 0 ;
	virtual bool __fastcall VisibleMax(void) = 0 ;
	virtual bool __fastcall VisibleMin(void) = 0 ;
	virtual bool __fastcall EnabledMax(void) = 0 ;
	virtual bool __fastcall EnabledMin(void) = 0 ;
	virtual bool __fastcall EnabledRestore(void) = 0 ;
public:
	/* TPopupMenu.Create */ inline __fastcall virtual TsCustomSysMenu(System::Classes::TComponent* AOwner) : Vcl::Menus::TPopupMenu(AOwner) { }
	/* TPopupMenu.Destroy */ inline __fastcall virtual ~TsCustomSysMenu(void) { }
	
};


class PASCALIMPLEMENTATION TsSystemMenu : public TsCustomSysMenu
{
	typedef TsCustomSysMenu inherited;
	
public:
	int ExtItemsCount;
	TsSkinProvider* FOwner;
	Vcl::Forms::TCustomForm* FForm;
	Vcl::Menus::TMenuItem* ItemRestore;
	Vcl::Menus::TMenuItem* ItemMove;
	Vcl::Menus::TMenuItem* ItemSize;
	Vcl::Menus::TMenuItem* ItemMinimize;
	Vcl::Menus::TMenuItem* ItemMaximize;
	Vcl::Menus::TMenuItem* ItemClose;
	Vcl::Menus::TMenuItem* SubMenu;
	__fastcall virtual TsSystemMenu(System::Classes::TComponent* AOwner);
	void __fastcall Generate(void);
	HIDESBASE void __fastcall UpdateItems(bool Full = false);
	void __fastcall UpdateGlyphs(void);
	void __fastcall MakeSkinItems(void);
	bool __fastcall VisibleRestore(void);
	bool __fastcall VisibleSize(void);
	virtual bool __fastcall VisibleMin(void);
	virtual bool __fastcall VisibleMax(void);
	virtual bool __fastcall VisibleClose(void);
	virtual bool __fastcall EnabledRestore(void);
	bool __fastcall EnabledMove(void);
	bool __fastcall EnabledSize(void);
	virtual bool __fastcall EnabledMin(void);
	virtual bool __fastcall EnabledMax(void);
	bool __fastcall EnabledClose(void);
	void __fastcall RestoreClick(System::TObject* Sender);
	void __fastcall MoveClick(System::TObject* Sender);
	void __fastcall SizeClick(System::TObject* Sender);
	void __fastcall MinClick(System::TObject* Sender);
	void __fastcall MaxClick(System::TObject* Sender);
	void __fastcall CloseClick(System::TObject* Sender);
	void __fastcall SkinSelect(System::TObject* Sender);
	void __fastcall ExtClick(System::TObject* Sender);
public:
	/* TPopupMenu.Destroy */ inline __fastcall virtual ~TsSystemMenu(void) { }
	
};


typedef System::DynamicArray<TacAdapterItem*> TacAdapterItems;

typedef System::DynamicArray<TacGraphItem*> TacGraphItems;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TacCtrlAdapter : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
public:
	System::TObject* CtrlClass;
	System::UnicodeString DefaultSection;
	TacAdapterItems Items;
	TacGraphItems GraphItems;
	TsSkinProvider* Provider;
	bool __fastcall IsControlSupported(System::Classes::TComponent* Control);
	int __fastcall Count(void);
	__fastcall TacCtrlAdapter(TsSkinProvider* AProvider);
	__fastcall virtual ~TacCtrlAdapter(void);
	TacAdapterItem* __fastcall GetItem(int Index);
	Scommondata::TsCommonData* __fastcall GetCommonData(int Index);
	int __fastcall IndexOf(Vcl::Controls::TWinControl* Ctrl);
	virtual void __fastcall AfterConstruction(void);
	void __fastcall AddAllItems(Vcl::Controls::TWinControl* OwnerCtrl = (Vcl::Controls::TWinControl*)(0x0));
	void __fastcall AddNewItem(Vcl::Buttons::TSpeedButton* const Ctrl)/* overload */;
	void __fastcall AddNewItem(Vcl::Controls::TWinControl* const Ctrl)/* overload */;
	void __fastcall AddNewItem(Vcl::Controls::TWinControl* const Ctrl, const System::UnicodeString SkinSection)/* overload */;
	void __fastcall RemoveItem(int Index);
	void __fastcall RemoveAllItems(void);
	void __fastcall CleanItems(void);
	void __fastcall WndProc(Winapi::Messages::TMessage &Message);
};

#pragma pack(pop)

class DELPHICLASS TacMoveTimer;
class PASCALIMPLEMENTATION TacMoveTimer : public Acthdtimer::TacThreadedTimer
{
	typedef Acthdtimer::TacThreadedTimer inherited;
	
public:
	System::Byte BlendValue;
	double CurrentBlendValue;
	double BlendStep;
	TacBorderForm* BorderForm;
	NativeUInt FormHandle;
	virtual void __fastcall TimeHandler(void);
public:
	/* TacThreadedTimer.Create */ inline __fastcall virtual TacMoveTimer(System::Classes::TComponent* AOwner) : Acthdtimer::TacThreadedTimer(AOwner) { }
	/* TacThreadedTimer.CreateOwned */ inline __fastcall virtual TacMoveTimer(System::Classes::TComponent* AOwner, bool ChangeEvent) : Acthdtimer::TacThreadedTimer(AOwner, ChangeEvent) { }
	/* TacThreadedTimer.Destroy */ inline __fastcall virtual ~TacMoveTimer(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 FS_SIZING = System::Int8(0x1);
static const System::Byte FS_BLENDMOVING = System::Byte(0x80);
static const System::Word FS_ANIMMINIMIZING = System::Word(0x100);
static const System::Word FS_ANIMCLOSING = System::Word(0x200);
static const System::Word FS_ANIMRESTORING = System::Word(0x400);
static const System::Word FS_THUMBDRAWING = System::Word(0x800);
static const System::Word FS_CHANGING = System::Word(0x1000);
static const System::Word FS_MAXHEIGHT = System::Word(0x2000);
static const System::Word FS_MAXWIDTH = System::Word(0x4000);
static const System::Word FS_ACTIVATE = System::Word(0x8000);
static const int FS_LOCKED = int(0x10000);
static const int FS_SCROLLUPDATING = int(0x20000);
static const System::Int8 ScrollWidth = System::Int8(0x12);
static const System::Int8 IconicHeight = System::Int8(0x1a);
static const System::Word HTUDBTN = System::Word(0x3e8);
extern DELPHI_PACKAGE int Style;
extern DELPHI_PACKAGE Sskinmenus::TMenuItemData HotItem;
extern DELPHI_PACKAGE Vcl::Menus::TMenuItem* SelectedMenuItem;
extern DELPHI_PACKAGE int FSysWndCaptHeight;
extern DELPHI_PACKAGE int FSysToolCaptHeight;
extern DELPHI_PACKAGE bool bInProcess;
extern DELPHI_PACKAGE bool bCapture;
extern DELPHI_PACKAGE bool bFlag;
extern DELPHI_PACKAGE bool bRemoving;
extern DELPHI_PACKAGE NativeUInt hDWMAPI;
extern DELPHI_PACKAGE bool __fastcall SetThumbIcon(HWND Handle, TsSkinProvider* sp, int Width, int Height);
extern DELPHI_PACKAGE bool __fastcall SetPreviewBmp(HWND Handle, TsSkinProvider* sp);
extern DELPHI_PACKAGE void __fastcall DwmInvalidateIconicBitmaps(HWND hwnd);
extern DELPHI_PACKAGE void __fastcall SetFormBlendValue(NativeUInt FormHandle, Vcl::Graphics::TBitmap* Bmp, int Value, System::Types::PPoint NewPos = (System::Types::PPoint)(0x0));
extern DELPHI_PACKAGE Vcl::Forms::TForm* __fastcall MakeCoverForm(NativeUInt Wnd);
extern DELPHI_PACKAGE void __fastcall StartMinimizing(TsSkinProvider* sp);
extern DELPHI_PACKAGE bool __fastcall StartRestoring(TsSkinProvider* sp);
extern DELPHI_PACKAGE void __fastcall FinishBlendOnMoving(TsSkinProvider* sp, Vcl::Forms::TForm* CoverForm = (Vcl::Forms::TForm*)(0x0));
extern DELPHI_PACKAGE void __fastcall StartBlendOnMoving(TsSkinProvider* sp, bool ToMove = true);
extern DELPHI_PACKAGE Vcl::Graphics::TBitmap* __fastcall GetFormImage(TsSkinProvider* sp, bool CacheReplaced = false);
extern DELPHI_PACKAGE void __fastcall StartSBAnimation(const PsCaptionButton Btn, const int State, const int Iterations, const bool ToUp, TsSkinProvider* const SkinProvider, void * acDialog = (void *)(0x0));
extern DELPHI_PACKAGE int __fastcall SysBorderWidth(const HWND Handle, TacBorderForm* const BorderForm, bool CheckSkin = true);
extern DELPHI_PACKAGE int __fastcall SysBorderHeight(const HWND Handle, TacBorderForm* const BorderForm, bool CheckSkin = true);
extern DELPHI_PACKAGE int __fastcall SysCaptHeight(Vcl::Forms::TForm* Form);
extern DELPHI_PACKAGE int __fastcall SkinTitleHeight(TacBorderForm* const BorderForm);
extern DELPHI_PACKAGE int __fastcall SkinBorderWidth(TacBorderForm* const BorderForm);
extern DELPHI_PACKAGE System::Types::TPoint __fastcall SkinMenuOffset(TsSkinProvider* const sp);
extern DELPHI_PACKAGE int __fastcall DiffTitle(TacBorderForm* const BorderForm);
extern DELPHI_PACKAGE int __fastcall DiffBorder(TacBorderForm* const BorderForm);
extern DELPHI_PACKAGE HRESULT __fastcall DwmSetWindowAttribute(HWND hwnd, unsigned dwAttribute, void * pvAttribute, unsigned cbAttribute);
extern DELPHI_PACKAGE bool __fastcall AeroIsEnabled(void);
extern DELPHI_PACKAGE bool __fastcall ForbidSysAnimating(void);
extern DELPHI_PACKAGE void __fastcall InitDwm(const NativeUInt Handle, const bool Skinned, const bool Repaint = false);
extern DELPHI_PACKAGE bool __fastcall IsBorderUnchanged(const int BorderIndex, Sskinmanager::TsSkinManager* const sm);
extern DELPHI_PACKAGE void __fastcall FillArOR(TsSkinProvider* sp);
extern DELPHI_PACKAGE void __fastcall UpdateRgn(TsSkinProvider* sp, bool Repaint = true);
extern DELPHI_PACKAGE HRGN __fastcall GetRgnFromArOR(TsSkinProvider* sp, int X = 0x0, int Y = 0x0);
extern DELPHI_PACKAGE void __fastcall ForbidDrawing(TsSkinProvider* sp, bool MDIAlso = false);
extern DELPHI_PACKAGE void __fastcall PermitDrawing(TsSkinProvider* sp, bool MDIAlso = false);
extern DELPHI_PACKAGE void __fastcall UpdateSkinCaption(TsSkinProvider* SkinProvider);
extern DELPHI_PACKAGE TsSkinProvider* __fastcall GetSkinProvider(System::Classes::TComponent* Cmp);
extern DELPHI_PACKAGE int __fastcall GetWindowWidth(HWND Handle);
extern DELPHI_PACKAGE int __fastcall GetClientWidth(HWND Handle);
extern DELPHI_PACKAGE int __fastcall GetWindowHeight(HWND Handle);
extern DELPHI_PACKAGE int __fastcall GetClientHeight(HWND Handle);
extern DELPHI_PACKAGE bool __fastcall DoLayered(HWND FormHandle, bool Layered, System::Byte AlphaValue = (System::Byte)(0x1));
}	/* namespace Sskinprovider */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SSKINPROVIDER)
using namespace Sskinprovider;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SskinproviderHPP
